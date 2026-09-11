/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\hostmigration.gsc
***********************************************/

function hostmigration_waitlongdurationwithpause(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hostmigration", "waitLongDurationWithPause")]](var_0);
    return;
  }

  wait var_0;
}

function hostmigration_waittillnotifyortimeoutpause(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hostmigration", "waittillNotifyOrTimeoutPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hostmigration", "waittillNotifyOrTimeoutPause")]](var_0, var_1);
    return;
  }

  scripts\engine\utility::ref_143b9(var_1, var_0);
}