/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\nvg.gsc
***********************************************/

function runnvg() {
  scripts\common\input_allow::clear_allow_info("NVG");

  if(!scripts\mp\flags::gameflag("prematch_done") && isDefined(self.infil)) {
    scripts\common\utility::brjugg_oncrateuse(0);
    thread brking_getrandompointinmovingcircle();
  } else {
    scripts\common\utility::brjugg_oncrateuse(1, undefined, 1);
  }

  if(!isDefined(self.pers["useNVG"])) {
    self.pers["useNVG"] = 0;
  }

  if(!isDefined(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  thread nvg_monitor();
}

function brking_getrandompointinmovingcircle() {
  self notify("allowNVGsAtMatchStart");
  self endon("allowNVGsAtMatchStart");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\common\utility::brjugg_oncrateuse(1);
}

function clearnvg(var_0) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    if(var_0) {
      self detach(self.nvg3rdpersonmodel, "j_head");
    }

    self.nvg3rdpersonmodel = undefined;
    return;
  }
}

function savenvgstate() {
  if(self isnightvisionon()) {
    self.pers["useNVG"] = 1;
    return;
  }

  if(!self isnightvisionon() && !istrue(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["useNVG"] = 0;
    return;
  }
}

function nvg_monitor() {
  self notify("nvg_monitor");
  self endon("nvg_monitor");
  self endon("disconnect");
  self endon("death");

  for(var_0 = gettime();; var_0 = var_3) {
    var_1 = scripts\engine\utility::ref_143ad("night_vision_on", "night_vision_off");

    if(!isDefined(var_1)) {
      continue;
    }

    savenvgstate();
    var_2 = var_1 == "night_vision_on";
    nvg_update3rdperson(var_2);

    if(istrue(var_2)) {
      level notify("player_enabled_nvgs");
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    scripts\mp\analyticslog::logevent_nvgtoggled(gettime(), self.lifeid, self.origin, var_2, var_4, "none");
  }
}

function nvg_get3rdpersonupmodel() {
  var_0 = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    var_0 = level.nvgheadoverrides[self.operatorcustomization.head]["up"];
  }

  if(!isDefined(var_0)) {
    var_0 = "offhand_wm_nvgquad_mp_1_up";
  } else if(var_0 == "nvg_2") {
    var_0 = "offhand_wm_nvgquad_mp_2_up";
  } else if(var_0 == "nvg_3") {
    var_0 = "offhand_wm_nvgquad_mp_3_up";
  } else if(var_0 == "nvg_4") {
    var_0 = "offhand_wm_nvgquad_mp_3_up";
  } else if(var_0 == "none") {
    var_0 = undefined;
  } else {
    var_0 = "offhand_wm_nvgquad_mp_1_up";
  }

  return var_0;
}

function nvg_get3rdpersondownmodel() {
  var_0 = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    var_0 = level.nvgheadoverrides[self.operatorcustomization.head]["down"];
  }

  if(!isDefined(var_0)) {
    var_0 = "offhand_wm_nvgquad_mp_1";
  } else if(var_0 == "nvg_2") {
    var_0 = "offhand_wm_nvgquad_mp_2";
  } else if(var_0 == "nvg_3") {
    var_0 = "offhand_wm_nvgquad_mp_3";
  } else if(var_0 == "nvg_4") {
    var_0 = "offhand_wm_nvgquad_mp_4";
  } else if(var_0 == "none") {
    var_0 = undefined;
  } else {
    var_0 = "offhand_wm_nvgquad_mp_1";
  }

  return var_0;
}

function nvg_update3rdperson(var_0) {
  if(istrue(self.isjuggernaut)) {
    return;
  }

  if(istrue(self.unset_relic_steelballs)) {
    return;
  }

  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "j_head");
    self.nvg3rdpersonmodel = undefined;
  }

  if(var_0) {
    var_1 = nvg_get3rdpersondownmodel();

    if(isDefined(var_1)) {
      self.nvg3rdpersonmodel = var_1;
      self attach(self.nvg3rdpersonmodel, "j_head");
      return;
    }

    return;
  }

  var_2 = nvg_get3rdpersonupmodel();

  if(isDefined(var_2)) {
    self.nvg3rdpersonmodel = var_2;
    self attach(self.nvg3rdpersonmodel, "j_head");
    return;
  }
}