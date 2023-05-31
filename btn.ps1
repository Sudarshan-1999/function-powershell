var wshShell = WScript.CreateObject("WScript.Shell");

# Call the Popup method with a 7 second timeout.
var btn = wshShell.Popup("Do you feel alright?", 7, "Question:", 0x4 + 0x20);
switch(btn) {
    # Yes button pressed.
    case 6:
        WScript.Echo("Glad to hear you feel alright.");
        break;
    # No button pressed.
    case 7:
        WScript.Echo("Hope you're feeling better soon.");
        break;
    # Timed out.
    case -1:
       WScript.Echo("Is there anybody out there?");
       break;
}