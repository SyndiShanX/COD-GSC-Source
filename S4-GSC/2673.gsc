/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2673.gsc
*************************************************/

_id_EB15() {
  if(getdvarint("#x3d9a3bde669953456", 0) == 1) {
    return 0;
  }

  if(!scripts\mp\utility\perk::_hasperk("specialty_ninja")) {
    scripts\mp\utility\perk::_id_6FC2("specialty_quieter");
    scripts\mp\utility\perk::_id_6FC2("specialty_no_battle_chatter");
  }

  if(!scripts\mp\utility\perk::_hasperk("specialty_scout")) {
    scripts\mp\utility\perk::_id_6FC2("specialty_ghost");
  }

  self._id_43A1 = 0;

  if(isDefined(self.pers["deadSilenceTime"])) {
    self.deadsilencestarttime = gettime();
  }

  _id_07C4::_id_7B6B("scout");
  thread _id_EB1B();
  return 1;
}

_id_EB17(var_0) {
  if(!scripts\mp\utility\perk::_hasperk("specialty_ninja")) {
    scripts\mp\utility\perk::removeperk("specialty_quieter");
    scripts\mp\utility\perk::removeperk("specialty_no_battle_chatter");
  }

  if(!scripts\mp\utility\perk::_hasperk("specialty_scout")) {
    scripts\mp\utility\perk::removeperk("specialty_ghost");
  }

  if(isDefined(self.pers["deadSilenceTime"])) {
    var_1 = gettime();
    var_2 = var_1 - self.deadsilencestarttime;
    scripts\mp\utility\stats::_id_7DAE("deadSilenceTime", var_2);
  }

  _id_07BC::_id_AAE7("super_deadsilence", self._id_43A1);

  if(scripts\mp\utility\game::getgametype() != "infect") {
    _id_07A9::_id_9768(self, level._id_EB2B._id_E76D["super_deadsilence"]._id_7C8C, self._id_43A1, istrue(var_0));
  }

  thread _id_EB16();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](self);
  }

  return 0;
}

_id_EB18() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\utility\stats::_id_7DAE("deadSilenceKills", 1);
    scripts\mp\supers::_id_3AC0("super_deadsilence");
    self._id_43A1++;
    var_0 = scripts\mp\supers::_id_697D("super_deadsilence");

    if(self._id_43A1 > var_0) {
      var_1 = self._id_43A1 - var_0;
      scripts\mp\supers::_id_3AC1("super_deadsilence", var_1);
    }
  }

  scripts\mp\supers::_id_C64A();
  thread _id_19D4();
}

_id_EB16() {
  self endon("disconnect");
  wait 1;
}

_id_EB1A(var_0) {
  self._id_43A2 = var_0;
  self setclientomnvar("ui_deadsilence_overlay", var_0);
}

_id_19D4() {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self _meth_8577("zombiedefault");

  if(isDefined(self._id_EB09._id_E76B._id_FEE7)) {
    var_0 = self._id_EB09._id_E76B._id_FEE7;
  } else {
    var_0 = 15;
  }

  var_1 = var_0 - 2;
  scripts\engine\utility::_id_108AE(var_1, "super_use_finished");
  self _meth_8577("default_2seconds");
}

_id_EB1B() {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self notify("superDeadsilence_watchForGameEnded");
  self endon("superDeadsilence_watchForGameEnded");
  level scripts\engine\utility::waittill_any_2("game_ended", "prematch_cleanup");
  thread scripts\mp\supers::_id_EB50();
}