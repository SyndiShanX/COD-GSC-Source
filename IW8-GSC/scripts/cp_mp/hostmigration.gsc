/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\hostmigration.gsc
***********************************************/

function hostmigration_waitlongdurationwithpause(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hostmigration", "waitLongDurationWithPause")]](var0);
    return;
  }

  wait var0;
}

function hostmigration_waittillnotifyortimeoutpause(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hostmigration", "waittillNotifyOrTimeoutPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hostmigration", "waittillNotifyOrTimeoutPause")]](var0, var1);
    return;
  }

  scripts\engine\utility::ref_143b9(var1, var0);
}