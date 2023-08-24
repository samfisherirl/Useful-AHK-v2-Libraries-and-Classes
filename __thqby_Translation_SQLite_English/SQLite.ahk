/************************************************************************
 * @description SQLite class
 * @file CSQLite.ahk
 * @author thqby
 * @date 2022/04/23
 * @version 0.0.4
 ***********************************************************************/

class CSQLite
{
	static Version := "", _SQLiteDLL := A_ScriptDir . "\SQLite3.dll", _RefCount := 0, hModule:=0
	static _MinVersion := "3.29", execfunc_ptr := 0, callback_gettable_ptr := 0

	__New(DllFolder:="") {
		this._Path := ""						; Database path											(String)
		this._Handle := 0					  ; Database handle										 (Pointer)
		if (CSQLite._RefCount = 0) {
			SQLiteDLL := CSQLite._SQLiteDLL
			if FileExist(DllFolder "\SQLite3.dll")
				SQLiteDLL := CSQLite._SQLiteDLL := DllFolder "\SQLite3.dll"
			if (!DllCall("GetModuleHandle", "Str", SQLiteDLL, "UPtr")
				&&!(CSQLite.hModule:=DllCall("LoadLibrary", "Str", SQLiteDLL, "UPtr"))){
				MsgBox("DLL " SQLiteDLL " does not exist!", "CSQLite Error", 16)
				ExitApp()
			}
			CSQLite.Version := StrGet(DllCall("SQLite3.dll\sqlite3_libversion", "Cdecl UPtr"), "UTF-8")
			SQLVersion := StrSplit(CSQLite.Version, ".")
			MinVersion := StrSplit(CSQLite._MinVersion, ".")
			if (SQLVersion[1] < MinVersion[1]) || ((SQLVersion[1] = MinVersion[1]) && (SQLVersion[2] < MinVersion[2])){
				DllCall("FreeLibrary", "Ptr", CSQLite.hModule), CSQLite.hModule:=0
				MsgBox("Version " . CSQLite.Version .  " of SQLite3.dll is not supported!`n`n"
					. "You can download the current version from www.sqlite.org!", "SQLite ERROR", 16)
				ExitApp()
			}
			CSQLite.execfunc_ptr := DllCall("GetProcAddress", "Ptr", DllCall("LoadLibrary", "Str", SQLiteDLL, "UPtr"), "AStr", "sqlite3_exec", "Ptr")
			CSQLite.callback_gettable_ptr := CallbackCreate("callback_gettable", "F C")
		}
		CSQLite._RefCount += 1
	}
	; ===================================================================================================================
	; DESTRUCTOR __Delete
	; ===================================================================================================================
	__Delete() {
		if (this._Thread.HasOwnProp("_Threadobj"))
			this._Thread._Threadobj:=""
		if (this._Handle)
			this.CloseDB()
		CSQLite._RefCount -= 1
		if (CSQLite._RefCount = 0) {
			CallbackFree(CSQLite.callback_gettable_ptr)
			if (CSQLite.hModule)
				DllCall("FreeLibrary", "Ptr", CSQLite.hModule)
		}
	}
	; ===================================================================================================================
	; PRIVATE _StrToUTF8
	; ===================================================================================================================
	_StrToUTF8(Str, &UTF8) => (VarSetStrCapacity(&UTF8, size:=StrPut(Str, "UTF-8")), StrPut(Str, StrPtr(UTF8), "UTF-8"), size)

	; ===================================================================================================================
	; PRIVATE _ErrMsg
	; ===================================================================================================================
	_UTF8ToStr(UTF8) => StrGet(StrPtr(UTF8), "UTF-8")
	
   ; ===================================================================================================================
   ; PRIVATE _ErrMsg
   ; ===================================================================================================================
	_ErrMsg() => ((RC := DllCall("SQLite3.dll\sqlite3_errmsg", "Ptr", this._Handle, "Cdecl UPtr")) ? StrGet(StrPtr(RC), "UTF-8") : "")
	
   ; ===================================================================================================================
   ; PRIVATE _ErrCode
   ; ===================================================================================================================
	_ErrCode() => DllCall("SQLite3.dll\sqlite3_errcode", "Ptr", this._Handle, "Cdecl Int")
	
   ; ===================================================================================================================
   ; PRIVATE _Changes
   ; ===================================================================================================================
	_Changes() => DllCall("SQLite3.dll\sqlite3_changes", "Ptr", this._Handle, "Cdecl Int")
	
   ; ===================================================================================================================
   ; PRIVATE _Returncode
   ; ===================================================================================================================
_ReturnMsg(RC) {
    static Msg := Map(1,    "SQL error or missing database"
	                , 2,    "SQLite internal logic error"
	                , 3,    "Access denied"
	                , 4,    "Callback function requested operation cancellation"
	                , 5,    "Database file is locked"
	                , 6,    "A table in the database is locked"
	                , 7,    "A malloc() function call failed"
	                , 8,    "Attempt to write to a read-only database"
	                , 9,    "Operation interrupted by sqlite3_interrupt() function"
	                , 10,   "Some disk I/O error occurred"
	                , 11,   "Incorrect database disk image"
	                , 12,   "Unknown opcode in sqlite3_file_control()"
	                , 13,   "Insertion failed due to database full"
	                , 14,   "Unable to open the database file"
	                , 15,   "Database lock protocol error"
	                , 16,   "Database is empty"
	                , 17,   "Data structure has changed"
	                , 18,   "String or binary data exceeds size limit"
	                , 19,   "Cancelled due to constraint violation"
	                , 20,   "Data type mismatch"
	                , 21,   "Incorrect library usage"
	                , 22,   "Use of unsupported operating system feature"
	                , 23,   "Authorization failed"
	                , 24,   "Attached database format error"
	                , 25,   "Second parameter passed to sqlite3_bind() is out of range"
	                , 26,   "The opened file is not a database file"
	                , 100,  "sqlite3_step() has produced a row result"
	                , 101,  "sqlite3_step() completed the execution operation")
    return Msg.HasKey(RC) ? Msg[RC] : ""
}
   ; ===================================================================================================================
   ; Properties
   ; ===================================================================================================================
	ErrorMsg := ""              ; Error message                           (String) 
	ErrorCode := 0              ; SQLite error code / ErrorLevel          (Variant)
	Changes := 0                ; Changes made by last call of Exec()     (Integer)
	SQL := ""                   ; Last executed SQL statement             (String)
	_Thread := {_Threadobj:0, queue:[], pexec:0, DB:0}
	OpenDB(DBPath, Access := "W", Create := true) {
		static SQLITE_OPEN_READONLY  := 0x01 ; Database opened as read-only
		static SQLITE_OPEN_READWRITE := 0x02 ; Database opened as read-write
		static SQLITE_OPEN_CREATE    := 0x04 ; Database will be created if not exists
		static MEMDB := ":memory:"
		this.ErrorMsg := "", this.ErrorCode := 0
		if (DBPath = "")
			DBPath := MEMDB
		if (DBPath = this._Path) && (this._Handle)
			return true
		if (this._Handle)
			return (this.ErrorMsg := "You must first close DB " . this._Path . "!", false)
		Flags := 0, Access := SubStr(Access, 1, 1)
		if (Access != "W") && (Access != "R")
			Access := "R"
		Flags := SQLITE_OPEN_READONLY
		if (Access = "W") {
			Flags := SQLITE_OPEN_READWRITE
			if (Create)
				Flags |= SQLITE_OPEN_CREATE
		}
		this._Path := DBPath, this._StrToUTF8(DBPath, &UTF8:="")
		if (RC := DllCall("SQLite3.dll\sqlite3_open_v2", "Ptr", StrPtr(UTF8), "Ptr*", &HDB:=0, "Int", Flags, "Ptr", 0, "Cdecl Int"))
			return (this._Path := "", this.ErrorMsg := this._ErrMsg(), this.ErrorCode := RC, false)
		this._Handle := HDB
		this.createScalarFunction(regexp, 2)
		this.createScalarFunction(regex_replace, 3)
		return true
	}
   ; ===================================================================================================================
   ; METHOD CloseDB        Close database
   ; Parameters:           None
   ; return values:        On success  - true
   ;                       On failure  - false, ErrorMsg / ErrorCode contain additional information
   ; ===================================================================================================================
	CloseDB() {
		this.ErrorMsg := "", this.ErrorCode := 0, this.SQL := ""
		if !(this._Handle)
			return true
		if (RC := DllCall("SQLite3.dll\sqlite3_close", "Ptr", this._Handle, "Cdecl Int"))
			return (this.ErrorMsg := this._ErrMsg(), this.ErrorCode := RC, false)
		this._Path := "", this._Handle := ""
		return true
	}
   ; ===================================================================================================================
	LoadOrSaveDb(DBPath, isSave:=0){
		static SQLITE_OPEN_READONLY  := 0x01 ; Database opened as read-only
		static SQLITE_OPEN_READWRITE := 0x02 ; Database opened as read-write
		static SQLITE_OPEN_CREATE    := 0x04 ; Database will be created if not exists
		this.ErrorMsg := "", this.ErrorCode := 0, HDB := 0
		if (DBPath = "")
			return false
		if (!this._Handle)
			return (this.ErrorMsg := "You must first Open Memory DB!", false)
		Flags := SQLITE_OPEN_READWRITE, Flags |= SQLITE_OPEN_CREATE
		this._StrToUTF8(isSave?(tmp:=StrReplace(DBPath, ".db", ".tmp")):DBPath, &UTF8:="")
		if (RC := DllCall("SQLite3.dll\sqlite3_open_v2", "Ptr", StrPtr(UTF8), "Ptr*", &HDB, "Int", Flags, "Ptr", 0, "Cdecl Int"))
			return (this.ErrorMsg := this._ErrMsg(), this.ErrorCode := RC, false)
		pFrom := (isSave ? this._Handle : HDB), pTo   := (isSave ? HDB : this._Handle), this._StrToUTF8("main", &UTF8)
		pBackup := DllCall("SQLite3.dll\sqlite3_backup_init", "Ptr", pTo, "Ptr", StrPtr(UTF8), "Ptr", pFrom, "Ptr", StrPtr(UTF8), "Cdecl Int")
		if (pBackup){
			DllCall("SQLite3.dll\sqlite3_backup_step", "Ptr", pBackup, "Int", -1, "Cdecl Int")
			DllCall("SQLite3.dll\sqlite3_backup_finish", "Ptr", pBackup, "Cdecl Int")
		}
		RC := DllCall("SQLite3.dll\sqlite3_errcode", "Ptr", pTo, "Cdecl Int")
		DllCall("SQLite3.dll\sqlite3_close", "Ptr", HDB, "Cdecl Int")
		if (RC) {
			this._Path := "", this.ErrorMsg := this._ErrMsg(), this.ErrorCode := RC
			if (isSave)
				FileDelete tmp
			return false
		}
		if (isSave){
			if (FileGetSize(tmp, "K")<16)
				return (FileDelete(tmp), false)
			FileMove tmp, DBPath, 1
			this.Changes:=0
		}
		return true
	}
   ; ===================================================================================================================
   ; METHOD AttachDB       Add another database file to the current database connection
   ;                       http://www.sqlite.org/lang_attach.html
   ; Parameters:           DBPath      - Path of the database file
   ;                       DBAlias     - Database alias name used internally by SQLite
   ; return values:        On success  - true
   ;                       On failure  - false, ErrorMsg / ErrorCode contain additional information
   ; ===================================================================================================================
	AttachDB(DBPath, DBAlias) => this.Exec("ATTACH DATABASE '" . DBPath . "' As " . DBAlias . ";")

   ; ===================================================================================================================
   ; METHOD DetachDB       Detaches an additional database connection previously attached using AttachDB()
   ;                       http://www.sqlite.org/lang_detach.html
   ; Parameters:           DBAlias     - Database alias name used with AttachDB()
   ; return values:        On success  - true
   ;                       On failure  - false, ErrorMsg / ErrorCode contain additional information
   ; ===================================================================================================================
	DetachDB(DBAlias) => this.Exec("DETACH DATABASE " . DBAlias . ";")

	class Thread
	{
		Ptr:=0, pfunc:=0
		__New(funcobj, params, initflag:=0){
			this.pfunc:=pfunc:=CallbackCreate(funcobj)
			if (!this.Ptr:=DllCall("msvcrt\_beginthreadex", "Ptr", 0, "UInt", 0, "Ptr", pfunc, "Ptr", ObjPtrAddRef(params), "UInt", initflag, "UInt*", &threadid:=0))
				throw Error("create thread fail")
			this.threadid:=threadid
		}

		__Delete()=>(CallbackFree(this.pfunc), (this.ExitCode=259)?this.Terminate():"", (this.Ptr?DllCall("Kernel32\CloseHandle", "Ptr", this):0))
		Terminate(dwExitCode:=1)=>(DllCall("Kernel32\TerminateThread", "Ptr", this, "UInt", dwExitCode))
		ExitCode=>(DllCall("Kernel32\GetExitCodeThread", "Ptr", this, "UInt*", &Code:=0)?Code:0)
	}
	ExecByThread(SQL){
		if !(this._Handle)
			return (this.ErrorMsg := "Invalid database handle!", false)
		s:=StrPut(SQL, "UTF-8"), this._Thread.queue.Push(Buffer(s)), StrPut(SQL, this._Thread.queue[-1], "UTF-8")
		if (this._Thread.pexec)
			return
		this._Thread.DB:=this, this._Thread.pexec:=CSQLite.execfunc_ptr
		this._Thread._Threadobj:=CSQLite.Thread(_Exec, this._Thread)
		
		_Exec(pinfo){
			_Thread:=ObjFromPtr(pinfo), hdb:=_Thread.DB._Handle, pexec:=_Thread.pexec
			while (_Thread.queue.Has(1)){
				if (RC:=DllCall(pexec, "Ptr", hdb, "Ptr", _Thread.queue[1], "Ptr", 0, "Ptr", 0, "Ptr*", &Err:=0, "Cdecl Int")){
					ErrMsg:=_Thread.DB._ReturnMsg(RC), DllCall("SQLite3.dll\sqlite3_free", "Ptr", Err, "Cdecl")
					throw Error(ErrMsg)
				}
				_Thread.queue.RemoveAt(1)
			}
			_Thread.DB:="", _Thread.pexec:=0
			return 0
		}
	}
	Exec(SQL, pCallback := 0) {
		this.ErrorMsg := "", this.ErrorCode := 0, this.SQL := SQL
		if !(this._Handle)
			return (this.ErrorMsg := "Invalid database handle!", false)
		this._StrToUTF8(SQL, &UTF8:="")
		RC := DllCall(CSQLite.execfunc_ptr, "Ptr", this._Handle, "Ptr", StrPtr(UTF8), "Ptr", pCallback, "Ptr", ObjPtrAddRef(this), "Ptr*", &Err:=0, "Cdecl Int")
		if (RC) {
			this.ErrorMsg := this._ReturnMsg(RC)
			if (this.ErrorMsg = "")
				this.ErrorMsg := StrGet(Err, "UTF-8")
			this.ErrorCode := RC
			DllCall("SQLite3.dll\sqlite3_free", "Ptr", Err, "Cdecl")
			return false
		}
		this.Changes := this._Changes()
		return true
	}
	GetTable(SQL, &TB, pcall := 0) {
		this.ErrorMsg := "", this.ErrorCode := 0, this.SQL := SQL
		if !(this._Handle)
			return (this.ErrorMsg := "Invalid database handle!", false)
		this._StrToUTF8(SQL, &UTF8:=""), TB := {RowCount:0, Rows:[]}
		RC := DllCall(CSQLite.execfunc_ptr, "Ptr", this._Handle, "Ptr", StrPtr(UTF8)
			, "Ptr", (pcall>0?pcall:CSQLite.callback_gettable_ptr), "Ptr", ObjPtrAddRef(TB), "Ptr*", &Err:=0, "Cdecl Int")
		if (RC) {
			this.ErrorMsg := this._ReturnMsg(RC)
			if (this.ErrorMsg = "")
				this.ErrorMsg := StrGet(Err, "UTF-8"), this.Err := ""
			else
				this.Err := StrGet(Err, "UTF-8")
			this.ErrorCode := RC, DllCall("SQLite3.dll\sqlite3_free", "Ptr", Err, "Cdecl")
			return false
		} else if (pcall<0){
			RC := DllCall("SQlite3.dll\sqlite3_prepare_v2", "Ptr", This._Handle, "Ptr", StrPtr(UTF8), "Int", -1, "Ptr*", &Stmt:=0, "Ptr", 0, "Cdecl Int")
			TB.Cols := [], TB.ColCount := DllCall("SQlite3.dll\sqlite3_column_count", "Ptr", Stmt, "Cdecl Int")
			Loop TB.ColCount
				TB.Cols.Push(StrGet(DllCall("SQlite3.dll\sqlite3_column_name16", "Ptr", Stmt, "Int", A_Index - 1, "Cdecl UPtr"), "UTF-16"))
			DllCall("SQLite3.dll\sqlite3_finalize", "Ptr", Stmt, "Cdecl Int")
		}
		return true
	}
	createScalarFunction(func, params) {
		argType := Type(func)
		if (argType != "Func" && argType != "Closure")
			throw Error(this.__class "::" A_thisFunc " - First parameter not a Func object", -1)
		else if (!func.name)
			throw Error(this.__class "::" A_thisFunc " - Function must be named", -1)
		this.ErrorMsg := "", this.ErrorCode := 0, cb := CallbackCreate(func, "F C")
		if (err := DllCall("SQLite3.dll\sqlite3_create_function16", "Ptr", this._handle, "Str", func.name, "Int", params, "Int", 0x801, "Ptr", 0, "Ptr", cb, "Ptr", 0, "Ptr", 0, "Cdecl Int"))
			return (this.ErrorMsg := this._ErrMsg(), this.ErrorCode := err, false)
		return true
	}
	LastInsertRowID(&RowID) {
		this.ErrorMsg := "", this.ErrorCode := 0, this.SQL := ""
		if !(this._Handle)
			return (this.ErrorMsg := "Invalid database handle!", false)
		RowID := DllCall("SQLite3.dll\sqlite3_last_insert_rowid", "Ptr", this._Handle, "Cdecl Int64")
		return true
	}
	TotalChanges(&Rows) {
		this.ErrorMsg := "", this.ErrorCode := 0, this.SQL := ""
		if !(this._Handle)
			return (this.ErrorMsg := "Invalid database handle!", false)
		Rows := DllCall("SQLite3.dll\sqlite3_total_changes", "Ptr", this._Handle, "Cdecl Int")
		return true
	}
	SetTimeout(Timeout := 1000) {
		this.ErrorMsg := "", this.ErrorCode := 0, this.SQL := ""
		if !(this._Handle)
			return (this.ErrorMsg := "Invalid database handle!", false)
		if !IsInteger(Timeout)
			Timeout := 1000
		RC := DllCall("SQLite3.dll\sqlite3_busy_timeout", "Ptr", this._Handle, "Int", Timeout, "Cdecl Int")
		if (RC)
			return (this.ErrorMsg := this._ErrMsg(), this.ErrorCode := RC, false)
		return true
	}
}

regexp(Context, ArgC, vals) {
	regexNeedle := DllCall("SQLite3.dll\sqlite3_value_text16", "Ptr", NumGet(vals + 0, "Ptr"), "Cdecl Str")
	search := DllCall("SQLite3.dll\sqlite3_value_text16", "Ptr", NumGet(vals + A_PtrSize, "Ptr"), "Cdecl Str")
	DllCall("SQLite3.dll\sqlite3_result_int", "Ptr", Context, "Int", RegexMatch(search, regexNeedle), "Cdecl") ; 0 = false, 1 = true
}
regex_replace(Context, ArgC, vals) {
	search := DllCall("SQLite3.dll\sqlite3_value_text16", "Ptr", NumGet(vals + 0, "Ptr"), "Cdecl Str")
	regexNeedle := DllCall("SQLite3.dll\sqlite3_value_text16", "Ptr", NumGet(vals + A_PtrSize, "Ptr"), "Cdecl Str")
	Replacement := DllCall("SQLite3.dll\sqlite3_value_text16", "Ptr", NumGet(vals + A_PtrSize*2, "Ptr"), "Cdecl Str")
	DllCall("SQLite3.dll\sqlite3_result_text16", "Ptr", Context, "Str", RegExReplace(search, regexNeedle, Replacement), "Int", -1, "Ptr", 0, "Cdecl")
}
callback_gettable(TB, coln, vals, cols) {
	arr := Array(), TBobj := ObjFromPtrAddRef(TB)
	Loop coln
		arr.Push(StrGet(NumGet(vals + A_PtrSize * (A_Index - 1), "Ptr"), "UTF-8"))
	TBobj.Rows.Push(arr), TBobj.RowCount++
	return 0
}