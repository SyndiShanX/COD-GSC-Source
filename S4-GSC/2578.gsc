/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2578.gsc
*************************************************/

_id_CA64() {
  scripts\common\input_allow::_id_38B0("NVG");

  if(!_id_07D1::_id_60BE("prematch_done") && isDefined(self._id_7E24)) {
    scripts\common\utility::_id_155D(0);
    thread _id_15C5();
  } else
    scripts\common\utility::_id_155D(1, undefined, 1);

  if(!isDefined(self.pers["useNVG"])) {
    self.pers["useNVG"] = 0;
  }

  if(!isDefined(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  thread _id_A7B1();
}

_id_15C5() {
  self notify("allowNVGsAtMatchStart");
  self endon("allowNVGsAtMatchStart");
  self endon("disconnect");
  _id_07D1::_id_60C2("prematch_done");
  scripts\common\utility::_id_155D(1);
}

_id_395E(var_0) {
  if(isDefined(self._id_A7A1)) {
    if(var_0) {
      self detach(self._id_A7A1, "j_head");
    }

    self._id_A7A1 = undefined;
  }
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
    _id_07A9::_id_9777(gettime(), self._id_936C, self.origin, var_2, var_4, "none");
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