/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: codescripts\message.gsc
********************************/

codecallback_handleinstantmessage(var_0) {
  if(isDefined(level.globalinstantmessagehandler)) {
    [[level.globalinstantmessagehandler]](var_0);
  }
  else {
    iprintlnbold("no level handler for: " + var_0);
  }
}