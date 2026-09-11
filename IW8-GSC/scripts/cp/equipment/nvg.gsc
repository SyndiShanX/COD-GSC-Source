/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\nvg.gsc
***********************************************/

function runnvg() {
  if(istrue(level.disable_nvg)) {
    return;
  }

  scripts\cp\utility\player::init_visionsetnight();

  if(!isai(self)) {
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

function clearnvg(var_0) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    if(var_0) {
      self detach(self.nvg3rdpersonmodel, "j_head");
    }

    self.nvg3rdpersonmodel = undefined;
    return;
  }
}

function turnoffnvgs() {
  foreach(var_1 in level.players) {
    if(isalive(var_1)) {
      savenvgstate(var_1);
    }

    if(var_1 isnightvisionon()) {
      var_1 nightvisionviewoff();
    }

    thread removenvg();
  }
}

function removenvg() {
  self setactionslot(2, "");
  self notify("nvg_removed");
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
  self endon("nvg_removed");

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

function ref_13830() {
  thread screenent_b(2);
}

function screenent_b(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    self waittill("loadout_given");
  } else {
    if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout")) {
      scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");
    }

    scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  }

  thread ref_13337(var_0 / 2, var_1);
  wait var_0;
  self nightvisionviewon();
  thread nvg_update3rdperson(1);
}

function ref_13337(var_0, var_1) {
  wait var_0;
  var_2 = 5;

  if(isDefined(var_1) && (isint(var_1) || isfloat(var_1))) {
    var_2 = var_1;
  }

  if(self usinggamepad()) {
    thread scripts\cp\cp_hud_message::tutorialprint(&"MP/PRESS_TO_USE_NVG", var_2);
    return;
  }

  thread scripts\cp\cp_hud_message::tutorialprint(&"MP/PRESS_TO_USE_NVG_KB", var_2);
}