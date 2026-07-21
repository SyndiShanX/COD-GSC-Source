/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\nvg\nvg_player.gsc
***********************************************/

main(var_0) {
  level.player nvg_init(var_0);
  level.player thread player_nvg_watcher();
}

nvg_init(var_0) {
  if(!isDefined(var_0))
    var_0 = "nvg_base_sp";

  self.nvg = spawnStruct();
  self.nvg.lightmeter = 1;
  self.nvg.flir = 0;
  self.nvg.defaultnvgvision = var_0;
  self.nvg.light_model = spawn("script_model", (0, 0, 0));
  self.nvg.light_model setModel("tag_origin");
  self.nvg.light_model linktoplayerview(self, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  scripts\engine\utility::ent_flag_init("nightvision_disabled");
  level._effect["player_nvg_light"] = loadfx("vfx/iw8/core/nvg/vfx_nvg_light_player.vfx");
  level._effect["player_nvg_light_ext"] = loadfx("vfx/iw8/core/nvg/vfx_nvg_light_player_ext.vfx");
  precachenightvisioncodeassets();
  setomnvar("ui_nvg_equipped", 1);
  thread track_player_light_meter();
  scripts\engine\sp\utility::add_hint_string("nvg_on", &"SCRIPT/NIGHTVISION_USE", ::is_nvg_on);
  scripts\engine\sp\utility::add_hint_string("nvg_off", &"SCRIPT/NIGHTVISION_STOP_USE", ::is_nvg_off);
  scripts\engine\utility::delaythread(0.1, ::update_visionsetnight_for_nvg_type);
}

player_nvg_watcher() {
  self endon("death");
  self setactionslot(2, "nightvision");

  for(;;) {
    scripts\engine\utility::waittill_either("night_vision_on", "night_vision_off");

    if(self isnightvisionon()) {
      if(isDefined(self.nvg.on_func))
        self thread[[self.nvg.on_func]]();

      player_nvg_on();
    } else {
      if(isDefined(self.nvg.off_func))
        self thread[[self.nvg.off_func]]();

      player_nvg_off();
    }

    scripts\sp\nvg\nvg_ai::ai_nvg_player_update();
    scripts\sp\player::updatedeathsdoorvisionset();
    self.lightmeterdelay = gettime() + 1750;
  }
}

is_nvg_on() {
  return level.player isnightvisionon();
}

is_nvg_off() {
  return !level.player isnightvisionon();
}

nvg_on_hint(var_0, var_1, var_2, var_3) {
  scripts\engine\sp\utility::display_hint_forced("nvg_on", var_0, var_1, var_2, var_3);
}

nvg_off_hint(var_0, var_1, var_2, var_3) {
  scripts\engine\sp\utility::display_hint_forced("nvg_off", var_0, var_1, var_2, var_3);
}

disable_nvg_proc(var_0, var_1) {
  self notify("kill_nvg_after_gesture");
  self endon("kill_nvg_after_gesture");

  if(var_0) {
    if(self isnightvisionon()) {
      if(var_1)
        self nightvisiongogglesforceoff();
      else {
        self nightvisionviewoff();
        wait 0.05;
      }
    }

    self setactionslot(2, "");
  } else
    self setactionslot(2, "nightvision");

  if(!var_0) {
    return;
  }
  self endon("kill_nvg_after_gesture");

  if(self isgestureplaying("ges_equip_nvg_puton"))
    self stopgestureviewmodel("ges_equip_nvg_puton", 0.1);

  var_2 = 1.5;

  for(;;) {
    if(self isnightvisionon()) {
      break;
    } else {
      wait 0.05;
      var_2 = var_2 - 0.05;
    }

    if(var_2 <= 0)
      return;
  }

  if(var_1) {
    if(var_1)
      self nightvisiongogglesforceoff();
    else
      self nightvisionviewoff();
  }
}

set_nvg_flir_proc(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(self.nvg.flir == var_0) {
    return;
  }
  self.nvg.flir = var_0;
  self.nvg.origviewmodel = self getviewmodel();

  if(var_0)
    anim.flirfootprinteffects = 1;
  else
    anim.flirfootprinteffects = 0;

  if(!isDefined(anim.flirfootprints))
    anim.flirfootprints = [];

  setomnvar("ui_nvg_flir", var_0);
  update_visionsetnight_for_nvg_type();
}

set_nvg_light_proc(var_0) {
  self.nvg.lightoverride = var_0;
  update_nvg_light();
}

set_nvg_vision_proc(var_0) {
  self.nvg.visionoverride = var_0;
  update_visionsetnight_for_nvg_type();
}

remove_exotic_nvg_types() {
  if(self.nvg.flir)
    scripts\engine\sp\utility::set_nvg_flir(0);
}

update_nvg_light() {
  if(isDefined(self.nvg.lightoverride))
    var_0 = self.nvg.lightoverride;
  else
    var_0 = "player_nvg_light";

  if(level.player isnightvisionon()) {
    if(isDefined(self.nvg.currentlight) && self.nvg.currentlight != var_0) {
      killfxontag(level._effect[self.nvg.currentlight], self.nvg.light_model, "tag_origin");
      self.nvg.currentlight = undefined;
    }

    if(!isDefined(self.nvg.currentlight)) {
      playFXOnTag(level._effect[var_0], self.nvg.light_model, "tag_origin");
      self.nvg.currentlight = var_0;
    }
  } else if(isDefined(self.nvg.currentlight)) {
    stopFXOnTag(level._effect[self.nvg.currentlight], self.nvg.light_model, "tag_origin");
    self.nvg.currentlight = undefined;
  }
}

update_visionsetnight_for_nvg_type() {
  if(isDefined(self.nvg.visionoverride))
    var_0 = self.nvg.visionoverride;
  else if(self.nvg.flir)
    var_0 = "nvg_flir";
  else
    var_0 = self.nvg.defaultnvgvision;

  visionsetnight(var_0, 0.1);
}

get_nvg_bar_level() {
  if(self.nvg.power > 0.9)
    return 6;
  else if(self.nvg.power > 0.72)
    return 5;
  else if(self.nvg.power > 0.54)
    return 4;
  else if(self.nvg.power > 0.36)
    return 3;
  else if(self.nvg.power > 0.18)
    return 2;
  else if(self.nvg.power > 0)
    return 1;
  else
    return 0;
}

player_nvg_on() {
  earthquake(0.1, 0.35, level.player.origin, 1000);
  level.player playRumbleOnEntity("damage_heavy");
  nvg_mb_on(0.05);
  nvg_flir_on();
  update_nvg_light();
  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(22.0, 1800.0);
  self setdepthoffield(1, 200, 5000, 10000, 10, 0);
  self setviewmodeldepthoffield(4, 45, 6);
}

player_nvg_off() {
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

nvg_mb_on(var_0) {
  if(self.nvg.flir) {
    return;
  }
  if(isDefined(self.nvg.no_rblur) && self.nvg.no_rblur) {
    return;
  }
  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 10.5, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.025, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0.8, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.006, var_0);
  level.player setlensprofiledistort("compact portable", 0.0, 0.0, 0.9, 0.93);
}

nvg_mb_off() {
  var_0 = 0.1;
  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 0, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0, var_0);
  level.player setlensprofiledistort("none");
}

nvg_flir_on() {
  if(!self.nvg.flir) {
    return;
  }
  if(!isDefined(self.nvg.ogsunintensity)) {
    var_0 = getmapsuncolorandintensity();
    self.nvg.ogsunintensity = var_0[3];
  }

  scripts\sp\nvg\nvg_ai::do_flir_footsteps();
  self setviewmodel("viewmodel_base_viewhands_iw7_flir");

  foreach(var_2 in anim.flirfootprints)
  var_2 scripts\anim\notetracks_sp.gsc::play_flir_footstep_fx();

  lerp_sunintensity(self.nvg.ogsunintensity, 0, 0.2);
}

nvg_flir_off() {
  if(!self.nvg.flir) {
    return;
  }
  self setviewmodel(self.nvg.origviewmodel);
  scripts\sp\nvg\nvg_ai::dont_do_flir_footsteps();

  foreach(var_1 in anim.flirfootprints)
  var_1 scripts\anim\notetracks_sp.gsc::kill_flir_footstep_fx();

  lerp_sunintensity(0, self.nvg.ogsunintensity, 0.2);
}

lerp_sunintensity(var_0, var_1, var_2) {
  thread lerp_sunintensity_internal(var_0, var_1, var_2);
}

lerp_sunintensity_internal(var_0, var_1, var_2) {
  level notify("lerp_sunintensity");
  level endon("lerp_sunintensity");
  var_3 = var_1 - var_0;
  var_4 = 0.05;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      setsuncolorandintensity(var_0);
      wait(var_4);
    }
  }

  setsuncolorandintensity(var_1);
}

track_player_light_meter() {
  self endon("stop_tracking_dynolights");

  if(!scripts\engine\utility::ent_flag_exist("in_the_dark"))
    scripts\engine\utility::ent_flag_init("in_the_dark");

  self.nvg.prevlightmeter = 1;
  self.nvg.lightmeter = 1;
  var_0 = 1;
  var_1 = 0;
  thread light_meter_hud();
  var_2 = 0;
  var_3 = (0, 0, 0);
  var_4 = 0.45;

  for(;;) {
    var_4 = 0.1;
    var_0 = self getplayerlightlevel();
    lightmeter_lerp_lightmeter(var_0, var_4);

    if(self.nvg.lightmeter < 0.5 && !var_1) {
      scripts\engine\utility::ent_flag_set("in_the_dark");
      var_1 = 1;
      continue;
    }

    if(self.nvg.lightmeter >= 0.5 && var_1) {
      scripts\engine\utility::ent_flag_clear("in_the_dark");
      var_1 = 0;
    }
  }
}

light_meter_hud() {
  var_0 = spawnStruct();
  var_0.mag = 0.02;
  var_0.period_min = 0.05;
  var_0.period_max = 0.15;
  var_0.data = [];
  var_0.data["old"] = 0;
  var_0.data["period"] = 0;
  var_0.data["target"] = 0;
  var_0.data["val"] = 0;
  var_0.data["time"] = 0;
  var_1 = 0;

  for(;;) {
    self.nvg waittill("update_nvg_hud");
    var_0 needle_noise();
    var_2 = self.nvg.lightmeter;
    var_2 = clamp(var_2, var_0.mag, 1 - var_0.mag);
    var_2 = var_2 + var_0.data["val"];
    setomnvar("ui_nvg_light_meter_needle", var_2);

    if(var_2 >= 0.9 && is_nvg_on() && !var_1) {
      self playSound("item_nightvision_lightmeter_warning");
      var_1 = 1;
      continue;
    }

    if(var_2 < 0.9 && is_nvg_on() && var_1)
      var_1 = 0;
  }
}

needle_noise() {
  if(self.data["time"] >= self.data["period"]) {
    self.data["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data["old"] = self.data["target"];
    self.data["time"] = 0;
    self.data["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  var_0 = scripts\engine\math::normalize_value(0, self.data["period"], self.data["time"]);
  var_0 = scripts\engine\math::normalized_float_smoth_in_out(var_0);
  self.data["val"] = self.data["old"] * (1 - var_0) + self.data["target"] * var_0;
  self.data["time"] = self.data["time"] + 0.05;
}

lightmeter_lerp_lightmeter(var_0, var_1) {
  var_2 = self.nvg.lightmeter;
  var_3 = var_0 - var_2;
  var_4 = 0.05;
  var_5 = int(var_1 / var_4);

  for(var_6 = var_3 / var_5; var_5; var_5--) {
    self.nvg.prevlightmeter = self.nvg.lightmeter;
    self.nvg.lightmeter = self.nvg.lightmeter + var_6;
    self.nvg notify("update_nvg_hud");
    wait(var_4);
  }

  self.nvg.prevlightmeter = self.nvg.lightmeter;
  self.nvg.lightmeter = var_0;
}