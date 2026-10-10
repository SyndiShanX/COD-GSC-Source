/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\hostmigration.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace hostmigration;

function hostmigration_waitlongdurationwithpause(duration) {
  if(issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[getsharedfunc("hostmigration", "waitLongDurationWithPause")]](duration);
    return;
  }

  wait duration;
}

function hostmigration_waittillnotifyortimeoutpause(msg, duration) {
  if(issharedfuncdefined("hostmigration", "waittillNotifyOrTimeoutPause")) {
    [[getsharedfunc("hostmigration", "waittillNotifyOrTimeoutPause")]](msg, duration);
    return;
  }

  waittill_any_timeout_1(duration, msg);
}