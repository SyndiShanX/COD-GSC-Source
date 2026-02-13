/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\debug.gsc
*************************************************/

get_text_safe(var_0, var_1) {
  if(isDefined(var_0)) {
    return var_0 + "";
  }

  if(isDefined(var_1)) {
    return var_1;
  }

  return "";
}

waittill_buttonpressedandreleased_debug(var_0, var_1, var_2) {
  self endon("death");

  for(;;) {
    if(!self _meth_805E(var_0)) {
      break;
    }

    waitframe();
  }

  for(;;) {
    if(isDefined(var_1)) {}

    if(self _meth_805E(var_0)) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_2)) {
    iprintlnbold(var_2);
  } else if(isDefined(var_1)) {
    iprintlnbold("Performed:" + var_1);
  }
}