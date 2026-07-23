/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1379.gsc
**************************************/

_id_42B8() {
  thread _id_42B9();
  self._id_0B6E._id_423A._id_0EFE = 1;
}

_id_42B9() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    self waittill("event_awareness", var_0);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    if(maps\_stealth_utility::_id_4208()) {
      continue;
    }
    var_1 = self._id_0B6E._id_41D0._id_41D1["event"];

    if(!isDefined(var_1[var_0])) {
      continue;
    }
    thread _id_42BA(var_0);
  }
}

_id_42BA(var_0) {
  var_1 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  self endon("_stealth_enemy_alert_level_change");
  level endon(var_1);
  self endon("death");
  waittillframeend;
  self endon("enemy_awareness_reaction");
  maps\_stealth_shared_utilities::_id_41EB();
  maps\_stealth_shared_utilities::_id_41F0();
  maps\_stealth_shared_utilities::_id_41EF();
  var_2 = self._id_0B6E._id_41D0._id_41D1["event"][var_0];
  self[[var_2]](var_0);
  maps\_stealth_threat_enemy::_id_4264("reset");
}

_id_42BB(var_0) {
  var_1 = self._id_0B6E._id_41ED._id_0EFE._id_4276[var_0];
  wait 0.05;
  maps\_utility::_id_13DB("_stealth_behavior_reaction_anim_in_progress");
  var_2 = maps\_stealth_shared_utilities::_id_41F3(var_1, 300, 40);
  _id_42BF(var_2);
}

_id_42BC(var_0) {
  var_1 = self._id_0B6E._id_41ED._id_0EFE._id_4276[var_0];

  if(common_scripts\utility::isflashed() && self.script == "<custom>") {
    wait 0.05;
    self setflashbanged(1);
  }

  wait 0.05;

  if(self.script == "flashed") {
    self waittill("stop_flashbang_effect");
  }
  var_2 = maps\_stealth_shared_utilities::_id_41F3(var_1, 300, 40);

  if(isDefined(var_2)) {
    thread maps\_stealth_shared_utilities::_id_41F4();
    thread maps\_stealth_shared_utilities::_id_41FA(var_1);
  }

  _id_42BF(var_2);
}

_id_42BD(var_0) {
  var_1 = self._id_0B6E._id_41ED._id_0EFE._id_4276[var_0];
  wait 0.05;
  maps\_utility::_id_13DB("_stealth_behavior_reaction_anim_in_progress");
  var_2 = maps\_stealth_shared_utilities::_id_41F3(var_1, 300, 40);
  thread maps\_stealth_shared_utilities::_id_41F4();
  _id_42BF(var_2);
}

_id_42BE(var_0) {
  return;
}

_id_42BF(var_0, var_1) {
  if(isDefined(var_0)) {
    wait(randomfloat(1));
    thread maps\_stealth_shared_utilities::_id_41F2(var_0, var_1);
    self._id_117F = 0;
    self._id_1199 = 0;
    self waittill("goal");
    wait(randomfloatrange(15, 25));
  } else {
    wait(randomfloatrange(1, 4));
  }
}

_id_42C0() {
  _id_42C1("heard_scream");
  _id_42C1("doFlashBanged");
  _id_42C1("explode");
}

_id_42C1(var_0, var_1, var_2, var_3) {
  var_4 = _id_42C2();
  var_5 = _id_42C4();

  if(!isDefined(var_1)) {
    var_1 = var_4[var_0];
  }
  if(!isDefined(var_2)) {
    var_2 = var_5[var_0];
  }
  if(!isDefined(var_3)) {
    var_3 = _id_42C3(var_0);
  }
  maps\_stealth_shared_utilities::_id_41CF("event", var_0, var_1);
  maps\_stealth_shared_utilities::_id_41CF("animation", var_0, var_2);
  thread _id_055D::_id_4279(var_0);

  if(var_3) {
    self addaieventlistener(var_0);
  }
  switch (var_0) {
    case "explode":
      self.ignoreexplosionevents = 1;
      break;
  }
}

_id_42C2() {
  var_0 = [];

  if(self.type == "dog") {
    var_0["heard_scream"] = ::_id_42BE;
    var_0["doFlashBanged"] = ::_id_42BE;
  } else {
    var_0["heard_scream"] = ::_id_42BB;
    var_0["doFlashBanged"] = ::_id_42BC;
  }

  var_0["explode"] = ::_id_42BD;
  return var_0;
}

_id_42C3(var_0) {
  switch (var_0) {
    case "heard_scream":
      return 0;
    case "doFlashBanged":
      return 0;
    case "explode":
      return 0;
    default:
      return 0;
  }
}

_id_42C4() {
  var_0 = [];
  var_0["doFlashBanged"] = _id_055B::_id_423F;

  if(self.type == "dog") {
    var_0["heard_scream"] = _id_055B::_id_4241;
    var_0["explode"] = _id_055B::_id_4242;
  } else {
    var_0["heard_scream"] = _id_055B::_id_4240;
    var_0["explode"] = _id_055B::_id_4240;
  }

  return var_0;
}