/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\nvg\nvg_player.gsc
***********************************************/

#using scripts\anim\notetracks_sp;
#using scripts\common\nvg_player;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\player;
#using scripts\sp\utility;
#namespace nvg_player;

function main(defaultnvgvision, viewmodeloverride) {
  scripts\common\nvg_player::function_d357a2923790fad6();
  create_func_ref("player_nvg_lightmodel_extras_watcher_entry", &player_nvg_lightmodel_extras_watcher_entry);
  create_func_ref("player_nvg_lightmodel_extras_watcher_trigger", &player_nvg_lightmodel_extras_watcher_trigger);
  create_func_ref("lerp_savedDvar", &lerp_saveddvar);
  create_func_ref("LinkToPlayerView", &linktoplayerview_temp);
  create_func_ref("nvg_flir_on", &function_2db6d8e00bcac9ec);
  create_func_ref("nvg_flir_off", &function_c795b940a8014a);
  level.player nvg_init(defaultnvgvision, viewmodeloverride);
  level.player thread scripts\common\nvg_player::player_nvg_lightmodel_extras_watcher();
}

function nvg_init(defaultnvgvision, viewmodeloverride) {
  if(!isDefined(defaultnvgvision)) {
    defaultnvgvision = "nvg_base_sp";
  }

  self.nvg = spawnStruct();
  self.nvg.lightmeter = 1;
  self.nvg.flir = 0;
  self.nvg.toggleenabled = 1;
  self.nvg.viewmodeloverride = viewmodeloverride;
  self.nvg.defaultnvgvision = defaultnvgvision;
  ent_flag_init("nightvision_disabled");
  precachenightvisioncodeassets();
  setomnvar("ui_nvg_equipped", 1);
  thread track_player_light_meter();
  add_hint_string("nvg_on", &"SCRIPT/NIGHTVISION_USE", &is_nvg_on);
  add_hint_string("nvg_off", &"SCRIPT/NIGHTVISION_STOP_USE", &is_nvg_off);

  thread function_5863a3db7cf44d90();

  delaythread(0.1, &update_visionsetnight_for_nvg_type);
  thread scripts\common\nvg_player::function_c105076398ebbb59();
}

function linktoplayerview_temp(player, tag, posoffset) {
  if(!isDefined(tag)) {
    tag = "tag_origin";
  }

  if(!isDefined(posoffset)) {
    posoffset = (0, 0, 0);
  }

  if(isDefined(level.nvgposoffset)) {
    posoffset = level.nvgposoffset;
  }

  self linktoplayerview(player, tag, posoffset, (0, 0, 0), 1);
}

function function_674bfe1e4a640c10(boolean) {
  self.nvg.toggleenabled = boolean;
  setomnvar("ui_nvg_equipped", boolean);

  if(boolean) {
    self setactionslot(2, "nightvision");
    return;
  }

  self setactionslot(2, "");
}

function player_nvg_lightmodel_extras_watcher_entry() {
  self setactionslot(2, "nightvision");
}

function player_nvg_lightmodel_extras_watcher_trigger() {
  array_thread(getaiarray(), &scripts\sp\nvg\nvg_ai::ai_nvg_player_update);
  scripts\sp\player::updatedeathsdoorvisionset();
  function_e0392f9961a02820(self, gettime() + 1750);
}

function is_nvg_on() {
  return level.player isnightvisionon();
}

function is_nvg_off() {
  return !level.player isnightvisionon();
}

function nvg_on_hint(timeout, delay, endonentities, endonmessages) {
  display_hint_forced("nvg_on", timeout, delay, endonentities, endonmessages);
}

function nvg_off_hint(timeout, delay, endonentities, endonmessages) {
  display_hint_forced("nvg_off", timeout, delay, endonentities, endonmessages);
}

function disable_nvg_proc(disable, immediate) {
  if(!isDefined(self.nvg)) {
    return;
  }

  self notify("kill_nvg_after_gesture");
  self endon("kill_nvg_after_gesture");

  if(disable) {
    if(self isnightvisionon()) {
      if(immediate) {
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

  if(!disable) {
    return;
  }

  self endon("kill_nvg_after_gesture");

  if(self isgestureplaying("ges_equip_nvg_puton")) {
    self stopgestureviewmodel("ges_equip_nvg_puton", 0.1);
  }

  timer = 1.5;

  while(true) {
    if(self isnightvisionon()) {
      break;
    } else {
      wait 0.05;
      timer -= 0.05;
    }

    if(timer <= 0) {
      return;
    }
  }

  if(immediate) {
    if(immediate) {
      self nightvisiongogglesforceoff();
      return;
    }

    self nightvisionviewoff();
  }
}

function set_nvg_flir_proc(enable) {
  if(!isDefined(enable)) {
    enable = 1;
  }

  if(self.nvg.flir == enable) {
    return;
  }

  self.nvg.flir = enable;
  self.nvg.origviewmodel = self getviewmodel();

  if(enable) {
    anim.flirfootprinteffects = 1;
  } else {
    anim.flirfootprinteffects = 0;
  }

  if(!isDefined(anim.flirfootprints)) {
    anim.flirfootprints = [];
  }

  setomnvar("ui_nvg_flir", enable);
  update_visionsetnight_for_nvg_type();
}

function set_nvg_light_proc(light) {
  self.nvg.lightoverride = light;
  scripts\common\nvg_player::update_nvg_light();
}

function set_nvg_vision_proc(vision, blendtime) {
  self.nvg.visionoverride = vision;
  update_visionsetnight_for_nvg_type(blendtime);
}

function remove_exotic_nvg_types() {
  if(self.nvg.flir) {
    set_nvg_flir(0);
  }
}

function update_visionsetnight_for_nvg_type(blendtime) {
  if(isDefined(self.nvg.visionoverride)) {
    vision = self.nvg.visionoverride;
  } else if(self.nvg.flir) {
    vision = "nvg_flir";
  } else {
    vision = self.nvg.defaultnvgvision;
  }

  if(isDefined(vision)) {
    if(isDefined(vision) && isDefined(blendtime)) {
      visionsetnight(vision, blendtime);
      return;
    }

    visionsetnight(vision, 0);
  }
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

function function_2db6d8e00bcac9ec() {
  scripts\sp\nvg\nvg_ai::do_flir_footsteps();

  foreach(footprint in anim.flirfootprints) {
    footprint scripts\anim\notetracks_sp::play_flir_footstep_fx();
  }
}

function function_c795b940a8014a() {
  scripts\sp\nvg\nvg_ai::dont_do_flir_footsteps();

  foreach(footprint in anim.flirfootprints) {
    footprint scripts\anim\notetracks_sp::kill_flir_footstep_fx();
  }
}

function track_player_light_meter() {
  self endon("stop_tracking_dynolights");

  if(!ent_flag_exist("in_the_dark")) {
    ent_flag_init("in_the_dark");
  }

  self.nvg.prevlightmeter = 1;
  self.nvg.lightmeter = 1;
  light_meter = 1;
  player_invisible = 0;
  thread light_meter_hud();
  light_factor = 0;
  start = (0, 0, 0);
  var_cbbfb154c6f4fffb = 0.45;

  while(true) {
    var_cbbfb154c6f4fffb = 0.1;
    light_meter = self getplayerlightlevel();
    lightmeter_lerp_lightmeter(light_meter, var_cbbfb154c6f4fffb);

    if(self.nvg.lightmeter < 0.5 && !player_invisible) {
      ent_flag_set("in_the_dark");
      player_invisible = 1;
      continue;
    }

    if(self.nvg.lightmeter >= 0.5 && player_invisible) {
      ent_flag_clear("in_the_dark");
      player_invisible = 0;
    }
  }
}

function function_5863a3db7cf44d90() {
  while(true) {
    bool = ent_flag("<dev string:x1c>");

    if(getdvarint(@ "hash_fbade9cee2d02d33")) {
      printtoscreen2d(600, 50, "<dev string:x28>" + flag("<dev string:x42>"), (1, 1, 1), 1.5);
      answer = ter_op(bool, "<dev string:x62>", "<dev string:x66>");
      printtoscreen2d(600, 70, "<dev string:x69>" + answer, (1, 1, 1), 1.5);

      if(isDefined(level.player.nvg) && isDefined(level.player.nvg.lightmeter)) {
        printtoscreen2d(600, 90, "<dev string:x7e>" + level.player.nvg.lightmeter, (level.player.nvg.lightmeter, level.player.nvg.lightmeter, level.player.nvg.lightmeter), 1.5);
      }

      printtoscreen2d(600, 110, "<dev string:x93>" + level.player.maxvisibledist, (1, 1, 1), 1.5);
    }

    wait 0.05;
  }
}

function light_meter_hud() {
  noise = spawnStruct();
  noise.mag = 0.02;
  noise.period_min = 0.05;
  noise.period_max = 0.15;
  noise.data = [];
  noise.data["old"] = 0;
  noise.data["period"] = 0;
  noise.data["target"] = 0;
  noise.data["val"] = 0;
  noise.data["time"] = 0;

  for(var_e7c9c132ee82ad4f = 0; true; var_e7c9c132ee82ad4f = 0) {
    self.nvg waittill("update_nvg_hud");
    noise needle_noise();
    needle_position = self.nvg.lightmeter;
    needle_position = clamp(needle_position, noise.mag, 1 - noise.mag);
    needle_position += noise.data["val"];
    setomnvar("ui_nvg_light_meter_needle", needle_position);

    if(needle_position >= 0.9 && is_nvg_on() && !var_e7c9c132ee82ad4f) {
      self playSound("item_nightvision_lightmeter_warning");
      var_e7c9c132ee82ad4f = 1;
      continue;
    }

    if(needle_position < 0.9 && is_nvg_on() && var_e7c9c132ee82ad4f) {}
  }
}

function needle_noise() {
  if(self.data["time"] >= self.data["period"]) {
    self.data["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data["old"] = self.data["target"];
    self.data["time"] = 0;
    self.data["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  period_factor = math::normalize_value(0, self.data["period"], self.data["time"]);
  period_factor = math::function_889bef0ad1600791(period_factor);
  self.data["val"] = self.data["old"] * (1 - period_factor) + self.data["target"] * period_factor;
  self.data["time"] = self.data["time"] + 0.05;
}

function lightmeter_lerp_lightmeter(value, time) {
  curr = self.nvg.lightmeter;
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);
  delta = range / count;

  while(count) {
    self.nvg.prevlightmeter = self.nvg.lightmeter;
    self.nvg.lightmeter += delta;
    self.nvg notify("update_nvg_hud");
    wait interval;
    count--;
  }

  self.nvg.prevlightmeter = self.nvg.lightmeter;
  self.nvg.lightmeter = value;
}

function function_63cd796e95f7dbfc() {
  display_hint("nvg_on");

  while(!level.player isnightvisionon()) {
    waitframe();
  }
}