/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2487.gsc
*************************************************/

_id_F78C(var_0) {
  if(getdvarint("#x397affc07b3e49fc6", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(var_0.streakname != "intel") {
    _func_0140("Player has old killstreak data, requires data wipe");
    var_0.streakname = "intel";
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(self._id_8311) && istrue(self._id_8311)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INTEL_ACTIVE");
    }

    return 0;
  }

  var_1 = "s4_ks_gesture_generic_mp";
  var_2 = makeweapon(var_1);
  var_3 = _id_09B9::_id_EA01(var_0, var_2);

  if(!istrue(var_3) || level.gameended) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_intel", var_0.owner);
  }

  self._id_8311 = 1;
  thread playintelvo(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  self _meth_8222();
  thread _id_10B8A(var_0);
  thread watchintelroundend(var_0);
  thread _id_10B89(var_0);
  return 1;
}

playintelvo(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("intel_complete");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  wait(_func_0142(self._id_AC3D.voiceprefix + "_" + self._id_AC3D._id_10691 + "_inac") / 1000.0);
  thread _id_0A8D::_id_9137("intel_loop");
}

_id_10B8A(var_0) {
  self endon("intel_complete");
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  self._id_8311 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }

  self _meth_8081();
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

watchintelroundend(var_0) {
  self endon("death");
  self endon("disconnect");
  level waittill("round_end_finished");
  self notify("intel_complete");
  self._id_8311 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }

  self _meth_8081();
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_10B89(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("round_end_finished");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(35);
  self._id_8311 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }

  self _meth_8081();
  thread _id_0A8D::_id_9137("intel_time");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
  self notify("intel_complete");
}

intelloopvo() {
  self endon("death");
  self endon("disconnect");
  self endon("intel_complete");

  while(self._id_8311 == 1) {
    thread _id_0A8D::_id_9137("intel_loop");
    wait(getdvarint("#x32b60c67f16ea9eee", 8000) / 1000);
  }
}