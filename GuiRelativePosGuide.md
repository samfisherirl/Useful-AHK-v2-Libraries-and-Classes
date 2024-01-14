
# Gui relative positioning guide 

## AutoHotkey v2 GUI Positioning and Sizing Cheatsheet:

Basic Options:

-   `Rn`: Rows of text to determine height (n = number of rows, e.g. `r3`).
-   `Wn`: Width in pixels (e.g. `w200`).
-   `Hn`: Height in pixels (e.g. `h150`).

Automatic Sizing:

-   If no dimensions are specified, size is determined based on the control's nature and content.
-   Default width and height vary depending on the type of control.

Width and Height Relative to Previous Control:

-   `WP±n`: Adjust width relative to the previous control plus/minus an adjustment.
-   `HP±n`: Adjust height relative to the previous control plus/minus an adjustment.

Absolute Positioning:

-   `Xn`, `Yn`: Set absolute X/Y position in pixels (e.g. `x50 y100`).
-   Negative numbers are absolute; if negative offset needed, use `+` (e.g. `x+-10`).

Relative Positioning to Previous Control:

-   `X+n`, `Y+n`: Position control relative to the right/bottom edge of the previous control.
-   `XP±n`, `YP±n`: Position relative to the previous control's top-left corner (useful within a GroupBox).

Margin-Based Positioning:

-   `XM±n`, `YM±n`: Set control at the leftmost/topmost margins of the window with an adjustment.
-   `M` can be used for window's current margin (e.g. `x+m`).

Section-Based Positioning:

-   `XS±n`, `YS±n`: Position relative to a saved section.
-   To start new section, add control with `Section` option (e.g., `MyGui.Add("Text", "Section", "Label:")`).

Omissions and Defaults:

-   Omitting X, Y or both allows the layout to auto-adjust to future changes.
-   If both X and Y omitted: control is positioned beneath the previous control with standard padding.
-   Omit one component, the other defaults to:
    -   X specified:
        -   `Xn` or `XM`: Beneath all previous controls (max Y plus margin).
        -   `XS`: Beneath controls since the last `Section`.
        -   `X+n` or `XP+nonzero`: Align top with the previous control.
        -   `XP` or `XP+0`: Below the previous control (bottom edge plus margin).
    -   Y specified:
        -   `Yn` or `YM`: Right of all previous controls (max X plus margin).
        -   `YS`: Right of controls since the last `Section`.
        -   `Y+n` or `YP+nonzero`: Align left with the previous control.
        -   `YP` or `YP+0`: Right of the previous control (right edge plus margin).


        `MyGui.Add("Edit", "w300 h100") ; Explicit width and height
        MyGui.Add("Button", "wp-50 hp+10") ; Relative width and height adjustments
        MyGui.Add("Text", "x50 y+m") ; Absolute X position, margin-based Y position
        MyGui.Add("ListBox", "r5") ; Number of visible rows determines height
        MyGui.Add("ComboBox", "w200 h+50") ; Combines width and height relative adjustments`

example with the same cheat sheet

    ; Create a new GUI instance
    MyGui := Gui()

    ; Set overall GUI font if needed, as it may affect sizing and margins
    ; MyGui.Font("s9") ; Set to size 9, affects R, W, H defaults

    ; Add a control (i.e., a Button) with automatic position (below previous control) and automatic width
    MyGui.Add("Button", "vMyButton", "Click Me")

    ; Add a Text control with explicit width and automatic height
    MyGui.Add("Text", "w200", "This is some text")

    ; Add an Edit control with explicit height and automatic width
    MyGui.Add("Edit", "h50")

    ; Add a ListBox with specified row height (R) and automatic width
    MyGui.Add("ListBox", "r3") ; 3 rows in the list box

    ; Add a DropDownList with the width (W) based on font size and automatic height
    MyGui.Add("DropDownList", "w300")

    ; Use WP and HP to mimic the width and adjust the height of the previous control
    MyGui.Add("Edit", "wp hp+20")

    ; Use the X and Y options to set absolute positioning
    MyGui.Add("Edit", "x0 y0") ; Control at upper left corner

    ; Use X+ and Y+ for relative positioning to the right and bottom edges of the previous control
    MyGui.Add("Button", "x+10 y+10", "Relative")

    ; Use XP and YP to position controls relative to the top-left corner of the previous control
    MyGui.Add("Checkbox", "xp+20 yp+20", "Check me")

    ; Use XM and YM for positioning at window margins with adjustment
    MyGui.Add("Radio", "xm+10 ym+10", "Option 1")

    ; Use XS and YS to position relative to a saved section
    MyGui.Add("Text", "Section", "Section Start:")
    MyGui.Add("Edit")
    MyGui.Add("Edit", "ys") ; Positioned below the control marked with "Section"

    ; Omitting X and Y positions the control beneath the previous control using standard padding
    MyGui.Add("Button", "vAnotherButton", "Standard Padding")

    ; Consecutive Text or Link controls auto-align for columns
    MyGui.Add("Text",, "Aligned Text 1")
    MyGui.Add("Text",, "Aligned Text 2")

    ; Specifying only X or Y with defaults for the unspecified component
    MyGui.Add("Slider", "x0") ; Right-aligned to the previous control with margin
    MyGui.Add("Slider", "y50") ; Right-aligned to all previous controls with margin

    ; Show the GUI
    MyGui.Show()
