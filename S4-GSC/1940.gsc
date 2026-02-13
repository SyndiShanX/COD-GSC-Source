/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1940.gsc
*************************************************/

hostmigration_waitlongdurationwithpause(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hostmigration", "waitLongDurationWithPause")]](var_0);
  } else {
    wait(var_0);
  }
}

_id_7AA7(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hostmigration", "waittillNotifyOrTimeoutPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hostmigration", "waittillNotifyOrTimeoutPause")]](var_0, var_1);
  } else {
    scripts\engine\utility::_id_108A7(var_1, var_0);
  }
}