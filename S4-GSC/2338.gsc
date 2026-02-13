/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2338.gsc
*************************************************/

_id_CA64() {
  if(istrue(level._id_4A29)) {
    return;
  }
  scripts\cp\utility\player::_id_8108();

  if(!isai(self)) {
    scripts\common\utility::_id_155D(1, undefined, 1);
  }

  if(!isDefined(self.pers["useNVG"])) {
    self.pers["useNVG"] = 0;
  }

  if(!isDefined(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  thread _id_A7B1();
}

_id_395E(var_0) {
  if(isDefined(self._id_A7A1)) {
    if(var_0) {
      self detach(self._id_A7A1, "j_head");
    }

    self._id_A7A1 = undefined;
  }
}

_id_F819() {
  foreach(var_1 in level.players) {
    if(isalive(var_1)) {
      var_1 _id_CB51();
    }

    if(var_1 _meth_8632()) {
      var_1 _meth_8246();
    }

    var_1 thread _id_C4F1();
  }
}

_id_C4F1() {
  self setactionslot(2, "");
  self notify("nvg_removed");
}

_id_CB51() {
  if(self _meth_8632()) {
    self.pers["useNVG"] = 1;
  } else if(!self _meth_8632() && !istrue(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["useNVG"] = 0;
  }
}

_id_A7B1() {
  self notify("nvg_monitor");
  self endon("nvg_monitor");
  self endon("disconnect");
  self endon("death");
  self endon("nvg_removed");
  var_0 = gettime();

  for(;;) {
    var_1 = scripts\engine\utility::_id_10897("night_vision_on", "night_vision_off");

    if(!isDefined(var_1)) {
      continue;
    }
    _id_CB51();
    var_2 = var_1 == "night_vision_on";
    _id_A7B8(var_2);

    if(istrue(var_2)) {
      level notify("player_enabled_nvgs");
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    var_0 = var_3;
  }
}

_id_A7AB() {
  var_0 = undefined;

  if(isDefined(level._id_A7BB[self._id_AC3D._id_75DA])) {
    var_0 = level._id_A7BB[self._id_AC3D._id_75DA]["up"];
  }

  if(!isDefined(var_0)) {
    var_0 = "offhand_wm_nvgquad_mp_1_up";
  } else if(var_0 == "nvg_2") {
    var_0 = "offhand_wm_nvgquad_mp_2_up";
  } else if(var_0 == "nvg_3") {
    var_0 = "offhand_wm_nvgquad_mp_3_up";
  } else if(var_0 == "none") {
    var_0 = undefined;
  } else {
    var_0 = "offhand_wm_nvgquad_mp_1_up";
  }

  return var_0;
}

_id_A7AA() {
  var_0 = undefined;

  if(isDefined(level._id_A7BB[self._id_AC3D._id_75DA])) {
    var_0 = level._id_A7BB[self._id_AC3D._id_75DA]["down"];
  }

  if(!isDefined(var_0)) {
    var_0 = "offhand_wm_nvgquad_mp_1";
  } else if(var_0 == "nvg_2") {
    var_0 = "offhand_wm_nvgquad_mp_2";
  } else if(var_0 == "nvg_3") {
    var_0 = "offhand_wm_nvgquad_mp_3";
  } else if(var_0 == "none") {
    var_0 = undefined;
  } else {
    var_0 = "offhand_wm_nvgquad_mp_1";
  }

  return var_0;
}

_id_A7B8(var_0) {
  if(isDefined(self._id_A7A1)) {
    self detach(self._id_A7A1, "j_head");
    self._id_A7A1 = undefined;
  }

  if(var_0) {
    var_1 = _id_A7AA();

    if(isDefined(var_1)) {
      self._id_A7A1 = var_1;
      self attach(self._id_A7A1, "j_head");
      return;
    }
  } else {
    var_2 = _id_A7AB();

    if(isDefined(var_2)) {
      self._id_A7A1 = var_2;
      self attach(self._id_A7A1, "j_head");
    }
  }
}

_id_E675() {
  thread _id_6F1A(2);
}

_id_6F1A(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    self waittill("loadout_given");
  } else {
    if(!scripts\engine\utility::_id_5472("player_spawned_with_loadout")) {
      scripts\engine\utility::_id_5473("player_spawned_with_loadout");
    }

    scripts\engine\utility::_id_5476("player_spawned_with_loadout");
  }

  thread _id_DC47(var_0 / 2, var_1);
  wait(var_0);
  self _meth_8249();
  thread _id_A7B8(1);
}

_id_DC47(var_0, var_1) {
  wait(var_0);
  var_2 = 5;

  if(isDefined(var_1) && (isint(var_1) || _func_0110(var_1))) {
    var_2 = var_1;
  }

  if(self usinggamepad()) {
    thread scripts\cp\cp_hud_message::_id_F8D0(&"MP/PRESS_TO_USE_NVG", var_2);
  } else {
    thread scripts\cp\cp_hud_message::_id_F8D0(&"MP/PRESS_TO_USE_NVG_KB", var_2);
  }
}