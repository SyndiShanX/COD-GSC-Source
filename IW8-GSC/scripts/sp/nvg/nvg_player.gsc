/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\nvg\nvg_player.gsc
***********************************************/

function main(var0) {
  nvg_init(level.player, var0);
  thread player_nvg_watcher();
}

function nvg_init(var0) {
  if(!isDefined(var0)) {
    var0 = "nvg_base_sp";
  }

  self.nvg = spawnStruct();
  self.nvg.lightmeter = 1;
  self.nvg.flir = 0;
  self.nvg.defaultnvgvision = var0;
  self.nvg.light_model = spawn("script_model", (0, 0, 0));
  self.nvg.light_model setModel("tag_origin");
  self.nvg.light_model linktoplayerview(self, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  scripts\engine\utility::ent_flag_init("nightvision_disabled");
  level._effect["player_nvg_light"] = loadfx("vfx/iw8/core/nvg/vfx_nvg_light_player.vfx");
  level._effect["player_nvg_light_ext"] = loadfx("vfx/iw8/core/nvg/vfx_nvg_light_player_ext.vfx");
  precachenightvisioncodeassets();
  setomnvar("ui_nvg_equipped", 1);
  thread track_player_light_meter();
  scripts\engine\sp\utility::add_hint_string("nvg_on", &"SCRIPT/NIGHTVISION_USE", &is_nvg_on);
  scripts\engine\sp\utility::add_hint_string("nvg_off", &"SCRIPT/NIGHTVISION_STOP_USE", &is_nvg_off);
  scripts\engine\utility::delaythread(0.1, &update_visionsetnight_for_nvg_type);
}

function player_nvg_watcher() {
  self endon("death");
  self setactionslot(2, "nightvision");

  for(;;) {
    scripts\engine\utility::waittill_either("night_vision_on", "night_vision_off");

    if(self isnightvisionon()) {
      if(isDefined(self.nvg.on_func)) {
        self thread[[self.nvg.on_func]]();
      }

      player_nvg_on();
    } else {
      if(isDefined(self.nvg.off_func)) {
        self thread[[self.nvg.off_func]]();
      }

      player_nvg_off();
    }

    scripts\sp\nvg\nvg_ai::ai_nvg_player_update();
    scripts\sp\player::updatedeathsdoorvisionset();
    self.lightmeterdelay = gettime() + 1750;
  }
}

function is_nvg_on() {
  return level.player isnightvisionon();
}

function is_nvg_off() {
  return !level.player isnightvisionon();
}

function nvg_on_hint(var0, var1, var2, var3) {
  scripts\engine\sp\utility::display_hint_forced("nvg_on", var0, var1, var2, var3);
}

function nvg_off_hint(var0, var1, var2, var3) {
  scripts\engine\sp\utility::display_hint_forced("nvg_off", var0, var1, var2, var3);
}

function disable_nvg_proc(var0, var1) {
  self notify("kill_nvg_after_gesture");
  self endon("kill_nvg_after_gesture");

  if(var0) {
    if(self isnightvisionon()) {
      if(var1) {
        self nightvisiongogglesforceoff();
      } else {
        self nightvisionviewoff();
        wait 0.05;
      }
    }

    self setactionslot(2, "");
  } else {
    self setactionslot(2, "nightvision");
  }

  if(!var0) {
    return;
  }

  self endon("kill_nvg_after_gesture");

  if(self isgestureplaying("ges_equip_nvg_puton")) {
    self stopgestureviewmodel("ges_equip_nvg_puton", 0.1);
  }

  var2 = 1.5;

  for(;;) {
    if(self isnightvisionon()) {
      break;
    } else {
      wait 0.05;
      var2 -= 0.05;
    }

    if(var2 <= 0) {
      return;
    }
  }

  if(var1) {
    if(var1) {
      self nightvisiongogglesforceoff();
      return;
    }

    self nightvisionviewoff();
    return;
  }
}

function set_nvg_flir_proc(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(self.nvg.flir == var0) {
    return;
  }

  self.nvg.flir = var0;
  self.nvg.origviewmodel = self getviewmodel();

  if(var0) {
    anim.flirfootprinteffects = 1;
  } else {
    anim.flirfootprinteffects = 0;
  }

  if(!isDefined(anim.flirfootprints)) {
    anim.flirfootprints = [];
  }

  setomnvar("ui_nvg_flir", var0);
  update_visionsetnight_for_nvg_type();
}

function set_nvg_light_proc(var0) {
  self.nvg.lightoverride = var0;
  update_nvg_light();
}

function set_nvg_vision_proc(var0) {
  self.nvg.visionoverride = var0;
  update_visionsetnight_for_nvg_type();
}

function remove_exotic_nvg_types() {
  if(self.nvg.flir) {
    scripts\engine\sp\utility::set_nvg_flir(0);
    return;
  }
}

function update_nvg_light() {
  if(isDefined(self.nvg.lightoverride)) {
    var0 = self.nvg.lightoverride;
  } else {
    var0 = "player_nvg_light";
  }

  if(level.player isnightvisionon()) {
    if(isDefined(self.nvg.currentlight) && self.nvg.currentlight != var0) {
      killfxontag(level._effect[self.nvg.currentlight], self.nvg.light_model, "tag_origin");
      self.nvg.currentlight = undefined;
    }

    if(!isDefined(self.nvg.currentlight)) {
      playFXOnTag(level._effect[var0], self.nvg.light_model, "tag_origin");
      self.nvg.currentlight = var0;
      return;
    }

    return;
  }

  if(isDefined(self.nvg.currentlight)) {
    stopFXOnTag(level._effect[self.nvg.currentlight], self.nvg.light_model, "tag_origin");
    self.nvg.currentlight = undefined;
    return;
  }
}

function update_visionsetnight_for_nvg_type() {
  if(isDefined(self.nvg.visionoverride)) {
    var0 = self.nvg.visionoverride;
  } else if(self.nvg.flir) {
    var0 = "nvg_flir";
  } else {
    var0 = self.nvg.defaultnvgvision;
  }

  visionsetnight(var0, 0.1);
}

function get_nvg_bar_level() {
  if(self.nvg.power > 0.9) {
    return 6;
  }

  if(self.nvg.power > 0.72) {
    return 5;
  }

  if(self.nvg.power > 0.54) {
    return 4;
  }

  if(self.nvg.power > 0.36) {
    return 3;
  }

  if(self.nvg.power > 0.18) {
    return 2;
  }

  if(self.nvg.power > 0) {
    return 1;
  }

  return 0;
}

function player_nvg_on() {
  earthquake(0.1, 0.35, level.player.origin, 1000);
  level.player playRumbleOnEntity("damage_heavy");
  nvg_mb_on(0.05);
  nvg_flir_on();
  update_nvg_light();
  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(22, 1800);
  self setdepthoffield(1, 200, 5000, 10000, 10, 0);
  self setviewmodeldepthoffield(4, 45, 6);
}

function player_nvg_off() {
  earthquake(0.07, 0.25, level.player.origin, 1000);
  level.player playRumbleOnEntity("damage_light");
  killfxontag(level._effect["player_nvg_light"], self.nvg.light_model, "tag_origin");
  nvg_mb_off();
  nvg_flir_off();
  update_nvg_light();
  self setdepthoffield(1, 200, 5000, 10000, 3.9, 0);
  self setviewmodeldepthoffield(4, 30, 0);
  level.player disablephysicaldepthoffieldscripting();
}

function nvg_mb_on(var0) {
  if(self.nvg.flir) {
    return;
  }

  if(isDefined(self.nvg.no_rblur) && self.nvg.no_rblur) {
    return;
  }

  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 10.5, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.025, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0.8, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.006, var0);
  level.player setlensprofiledistort("compact portable", 0, 0, 0.9, 0.93);
}

function nvg_mb_off() {
  var0 = 0.1;
  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 0, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0, var0);
  level.player setlensprofiledistort("none");
}

function nvg_flir_on() {
  if(!self.nvg.flir) {
    return;
  }

  if(!isDefined(self.nvg.ogsunintensity)) {
    var0 = getmapsuncolorandintensity();
    self.nvg.ogsunintensity = var0[3];
  }

  scripts\sp\nvg\nvg_ai::do_flir_footsteps();
  self setviewmodel("viewmodel_base_viewhands_iw7_flir");

  foreach(var2 in anim.flirfootprints) {
    var2 scripts\anim\notetracks_sp::play_flir_footstep_fx();
  }

  lerp_sunintensity(self.nvg.ogsunintensity, 0, 0.2);
}

function nvg_flir_off() {
  if(!self.nvg.flir) {
    return;
  }

  self setviewmodel(self.nvg.origviewmodel);
  scripts\sp\nvg\nvg_ai::dont_do_flir_footsteps();

  foreach(var1 in anim.flirfootprints) {
    var1 scripts\anim\notetracks_sp::kill_flir_footstep_fx();
  }

  lerp_sunintensity(0, self.nvg.ogsunintensity, 0.2);
}

function lerp_sunintensity(var0, var1, var2) {
  thread lerp_sunintensity_internal(var0, var1, var2);
}

function lerp_sunintensity_internal(var0, var1, var2) {
  level notify("lerp_sunintensity");
  level endon("lerp_sunintensity");
  var3 = var1 - var0;
  var4 = 0.05;
  var5 = int(var2 / var4);

  if(var5 > 0) {
    var6 = var3 / var5;

    while(var5) {
      var0 += var6;
      setsuncolorandintensity(var0);
      wait var4;
      var5--;
    }
  }

  setsuncolorandintensity(var1);
}

function track_player_light_meter() {
  self endon("stop_tracking_dynolights");

  if(!scripts\engine\utility::ent_flag_exist("in_the_dark")) {
    scripts\engine\utility::ent_flag_init("in_the_dark");
  }

  self.nvg.prevlightmeter = 1;
  self.nvg.lightmeter = 1;
  var0 = 1;
  var1 = 0;
  thread light_meter_hud();
  var2 = 0;
  var3 = (0, 0, 0);
  var4 = 0.45;

  for(;;) {
    var4 = 0.1;
    var0 = self getplayerlightlevel();
    lightmeter_lerp_lightmeter(var0, var4);

    if(self.nvg.lightmeter < 0.5 && !var1) {
      scripts\engine\utility::ent_flag_set("in_the_dark");
      var1 = 1;
      continue;
    }

    if(self.nvg.lightmeter >= 0.5 && var1) {
      scripts\engine\utility::ent_flag_clear("in_the_dark");
      var1 = 0;
    }
  }
}

function light_meter_hud() {
  var0 = spawnStruct();
  var0.mag = 0.02;
  var0.period_min = 0.05;
  var0.period_max = 0.15;
  var0.data = [];
  var0.data["old"] = 0;
  var0.data["period"] = 0;
  var0.data["target"] = 0;
  var0.data["val"] = 0;
  var0.data["time"] = 0;

  for(var1 = 0;; var1 = 0) {
    self.nvg waittill("update_nvg_hud");
    needle_noise(var0);
    var2 = self.nvg.lightmeter;
    var2 = clamp(var2, var0.mag, 1 - var0.mag);
    var2 += var0.data["val"];
    setomnvar("ui_nvg_light_meter_needle", var2);

    if(var2 >= 0.9 && is_nvg_on() && !var1) {
      self playSound("item_nightvision_lightmeter_warning");
      var1 = 1;
      continue;
    }

    if(var2 < 0.9 && is_nvg_on() && var1) {}
  }
}

function needle_noise() {
  if(self.data["time"] >= self.data["period"]) {
    self.data["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data["old"] = self.data["target"];
    self.data["time"] = 0;
    self.data["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  var0 = scripts\engine\math::normalize_value(0, self.data["period"], self.data["time"]);
  var0 = scripts\engine\math::normalized_float_smoth_in_out(var0);
  self.data["val"] = self.data["old"] * (1 - var0) + self.data["target"] * var0;
  self.data["time"] = self.data["time"] + 0.05;
}

function lightmeter_lerp_lightmeter(var0, var1) {
  var2 = self.nvg.lightmeter;
  var3 = var0 - var2;
  var4 = 0.05;
  var5 = int(var1 / var4);
  var6 = var3 / var5;

  while(var5) {
    self.nvg.prevlightmeter = self.nvg.lightmeter;
    self.nvg.lightmeter += var6;
    self.nvg notify("update_nvg_hud");
    wait var4;
    var5--;
  }

  self.nvg.prevlightmeter = self.nvg.lightmeter;
  self.nvg.lightmeter = var0;
}