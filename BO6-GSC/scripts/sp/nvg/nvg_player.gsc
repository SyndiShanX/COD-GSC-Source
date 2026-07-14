/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\nvg\nvg_player.gsc
*****************************************/

#using scripts\anim\notetracks_sp;
#using scripts\common\nvg_player;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\player;
#namespace nvg_player;

function main(defaultnvgvision, viewmodeloverride) {
  function_47ace643225173db();
  utility::create_func_ref("\a\x8dX\xbc\x95\xc9\xaf7v;\xaf6Z\x9d\x86:m\xb7d\x95c\xd7V\x0ft\x9c\x85\x9b\xebw\x85\xd1\xd8CYr_\xb2s\xe8\xc9\x97", &player_nvg_lightmodel_extras_watcher_entry);
  utility::create_func_ref("\x96\x8d\x13\xf2q\x02\x14[\xaa\xd7\x9cP\xf0p\xcd\xae\xac\x951qP\x8c\xc5\xb7\xee}\x93s6\x98\xe5\xae\xb0\x8d\x11\x9f6\x01{\xd5\x88\xd3\x89\xd3", &player_nvg_lightmodel_extras_watcher_trigger);
  utility::create_func_ref("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", &utility_sp::lerp_saveddvar);
  utility::create_func_ref("\xec)4\xe5\xdf\xe7\xba\b\x1a\xb9\xb5\x9ftF\x9fx", &linktoplayerview_temp);
  utility::create_func_ref("\x9c\x11\xb0L\f_\xd0m\x04\x10\x1b", &function_ccff09eade8955ed);
  utility::create_func_ref("Vg{\x94rc#\xf4\xf3\xa7l\x88", &function_5205824d14e6c5c7);
  level.player nvg_init(defaultnvgvision, viewmodeloverride);
  level.player thread player_nvg_lightmodel_extras_watcher();
}

function nvg_init(defaultnvgvision, viewmodeloverride) {
  if(!isDefined(defaultnvgvision)) {
    defaultnvgvision = "\xacN\xfc\n\x8c[\x0e\xe3 \x19\xc3";
  }

  self.nvg = spawnStruct();
  self.nvg.lightmeter = 1;
  self.nvg.flir = 0;
  self.nvg.toggleenabled = 1;
  self.nvg.viewmodeloverride = viewmodeloverride;
  self.nvg.defaultnvgvision = defaultnvgvision;
  utility::ent_flag_init("v\x9c\xfbw\x13y'7\x18\x0f\xdc\a\xd8\x947\xe31\xd6\xa8v");
  precachenightvisioncodeassets();
  setomnvar("7z\xb0\x05\x18\xcaSJp^\xcf[\n\xcd|", 1);
  thread track_player_light_meter();
  utility_sp::add_hint_string("\xef\xc2G\xa60\x15", &"script/nightvision_use", &is_nvg_on);
  utility_sp::add_hint_string("v\x11=\xedw\xab1", &"script/nightvision_stop_use", &is_nvg_off);

  thread function_78a321b96d7e9dd1();

  utility::delaythread(0.1, &update_visionsetnight_for_nvg_type);
}

function linktoplayerview_temp(player, tag, posoffset) {
  if(!isDefined(tag)) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";
  }

  if(!isDefined(posoffset)) {
    posoffset = (0, 0, 0);
  }

  if(isDefined(level.nvgposoffset)) {
    posoffset = level.nvgposoffset;
  }

  self linktoplayerview(player, tag, posoffset, (0, 0, 0), 1);
}

function function_42132a7f29e5eab9(boolean) {
  self.nvg.toggleenabled = boolean;
  setomnvar("7z\xb0\x05\x18\xcaSJp^\xcf[\n\xcd|", boolean);

  if(boolean) {
    self setactionslot(2, "\x11\xac !5B5kw\xb5b");
    return;
  }

  self setactionslot(2, "");
}

function player_nvg_lightmodel_extras_watcher_entry() {
  self setactionslot(2, "\x11\xac !5B5kw\xb5b");
}

function player_nvg_lightmodel_extras_watcher_trigger() {
  utility::array_thread(getaiarray(), &nvg_ai::ai_nvg_player_update);
  player_sp::updatedeathsdoorvisionset();
  function_91ebb1c345b0cbe1(self, gettime() + 1750);
}

function is_nvg_on() {
  return level.player isnightvisionon();
}

function is_nvg_off() {
  return !level.player isnightvisionon();
}

function nvg_on_hint(timeout, delay, endonentities, endonmessages) {
  utility_sp::display_hint_forced("\xef\xc2G\xa60\x15", timeout, delay, endonentities, endonmessages);
}

function nvg_off_hint(timeout, delay, endonentities, endonmessages) {
  utility_sp::display_hint_forced("v\x11=\xedw\xab1", timeout, delay, endonentities, endonmessages);
}

function disable_nvg_proc(disable, immediate) {
  if(!isDefined(self.nvg)) {
    return;
  }

  self notify("\x01\x1f5\xb7T!\x0fC\x05\xac\xc4\xd8|)u\xe4\xb1\xbd\x8f#\x10\xa5");
  self endon("\x01\x1f5\xb7T!\x0fC\x05\xac\xc4\xd8|)u\xe4\xb1\xbd\x8f#\x10\xa5");

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
    self setactionslot(2, "\x11\xac !5B5kw\xb5b");
  }

  if(!disable) {
    return;
  }

  self endon("\x01\x1f5\xb7T!\x0fC\x05\xac\xc4\xd8|)u\xe4\xb1\xbd\x8f#\x10\xa5");

  if(self isgestureplaying("v\xac\xdc_\x95\x8b\xd5\xd2\a\xd7\xdc;v_\x83\xd5G{\xb9")) {
    self stopgestureviewmodel("v\xac\xdc_\x95\x8b\xd5\xd2\a\xd7\xdc;v_\x83\xd5G{\xb9", 0.1);
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

  setomnvar("\"\x93W\x16!\xa9\xc4\xd9\x1epu", enable);
  update_visionsetnight_for_nvg_type();
}

function set_nvg_light_proc(light) {
  self.nvg.lightoverride = light;
  update_nvg_light();
}

function set_nvg_vision_proc(vision, blendtime) {
  self.nvg.visionoverride = vision;
  update_visionsetnight_for_nvg_type(blendtime);
}

function remove_exotic_nvg_types() {
  if(self.nvg.flir) {
    utility_sp::set_nvg_flir(0);
  }
}

function update_visionsetnight_for_nvg_type(blendtime) {
  if(isDefined(self.nvg.visionoverride)) {
    vision = self.nvg.visionoverride;
  } else if(self.nvg.flir) {
    vision = "\xcdI\xaaMp \x17y";
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

function function_ccff09eade8955ed() {
  nvg_ai::do_flir_footsteps();

  foreach(footprint in anim.flirfootprints) {
    footprint notetracks_sp::play_flir_footstep_fx();
  }
}

function function_5205824d14e6c5c7() {
  nvg_ai::dont_do_flir_footsteps();

  foreach(footprint in anim.flirfootprints) {
    footprint notetracks_sp::kill_flir_footstep_fx();
  }
}

function track_player_light_meter() {
  self endon("\xaf\xc7\xdb\xc0_,\xce(0\x82F\xca7|(<\xc5?\ft\x8b=\x1a\x02");

  if(!utility::ent_flag_exist("{,\xfb-\xab\x9b\xb5_vd\xf3")) {
    utility::ent_flag_init("{,\xfb-\xab\x9b\xb5_vd\xf3");
  }

  self.nvg.prevlightmeter = 1;
  self.nvg.lightmeter = 1;
  light_meter = 1;
  player_invisible = 0;
  thread light_meter_hud();
  light_factor = 0;
  start = (0, 0, 0);
  var_a519016749777dd6 = 0.45;

  while(true) {
    var_a519016749777dd6 = 0.1;
    light_meter = self getplayerlightlevel();
    lightmeter_lerp_lightmeter(light_meter, var_a519016749777dd6);

    if(self.nvg.lightmeter < 0.5 && !player_invisible) {
      utility::ent_flag_set("{,\xfb-\xab\x9b\xb5_vd\xf3");
      player_invisible = 1;
      continue;
    }

    if(self.nvg.lightmeter >= 0.5 && player_invisible) {
      utility::ent_flag_clear("{,\xfb-\xab\x9b\xb5_vd\xf3");
      player_invisible = 0;
    }
  }
}

function function_78a321b96d7e9dd1() {
  while(true) {
    bool = utility::ent_flag("<dev string:x24>");

    if(getdvarint(@ "hash_fbade9cee2d02d33")) {
      printtoscreen2d(600, 50, "<dev string:x33>" + utility::flag("<dev string:x50>"), (1, 1, 1), 1.5);
      answer = bool ? "<dev string:x73>" : "<dev string:x7a>";
      printtoscreen2d(600, 70, "<dev string:x80>" + answer, (1, 1, 1), 1.5);

      if(isDefined(level.player.nvg) && isDefined(level.player.nvg.lightmeter)) {
        printtoscreen2d(600, 90, "<dev string:x98>" + level.player.nvg.lightmeter, (level.player.nvg.lightmeter, level.player.nvg.lightmeter, level.player.nvg.lightmeter), 1.5);
      }

      printtoscreen2d(600, 110, "<dev string:xb0>" + level.player.maxvisibledist, (1, 1, 1), 1.5);
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
  noise.data["\xc58\xf1"] = 0;
  noise.data["&\x19\x03\xd9i\x10"] = 0;
  noise.data["\x7fw*%A\xff"] = 0;
  noise.data["\x1b\xdb\x03"] = 0;
  noise.data["\x92\xd3\x9f\xbb"] = 0;

  for(var_47f7236ed099d746 = 0; true; var_47f7236ed099d746 = 0) {
    self.nvg waittill("W\x1c#\xb0\x8e\xca\xd7\xcd\xcev\xfa\xa1\xae\x8c");
    noise needle_noise();
    needle_position = self.nvg.lightmeter;
    needle_position = clamp(needle_position, noise.mag, 1 - noise.mag);
    needle_position += noise.data["\x1b\xdb\x03"];
    setomnvar("B\xfb\xb0>se\xfcd\x16:\xa8\x7fc\x84/\x02\xca\xf3Roo\x16\x94\xbdm", needle_position);

    if(needle_position >= 0.9 && is_nvg_on() && !var_47f7236ed099d746) {
      self playSound("\xa0m\xd1\x99M\x1a\x8c\x85\xfd^\x19v\x96P\x1b\x98\x11\x1dP\x9c7Y\x84\x95\x1d\x94\x99M\x94Q\xe2\x98\xa0\xd9\x91");
      var_47f7236ed099d746 = 1;
      continue;
    }

    if(needle_position < 0.9 && is_nvg_on() && var_47f7236ed099d746) {}
  }
}

function needle_noise() {
  if(self.data["\x92\xd3\x9f\xbb"] >= self.data["&\x19\x03\xd9i\x10"]) {
    self.data["&\x19\x03\xd9i\x10"] = randomfloatrange(self.period_min, self.period_max);
    self.data["\xc58\xf1"] = self.data["\x7fw*%A\xff"];
    self.data["\x92\xd3\x9f\xbb"] = 0;
    self.data["\x7fw*%A\xff"] = randomfloatrange(self.mag * -1, self.mag);
  }

  period_factor = math::normalize_value(0, self.data["&\x19\x03\xd9i\x10"], self.data["\x92\xd3\x9f\xbb"]);
  period_factor = math::function_a8193f1c6a4715dc(period_factor);
  self.data["\x1b\xdb\x03"] = self.data["\xc58\xf1"] * (1 - period_factor) + self.data["\x7fw*%A\xff"] * period_factor;
  self.data["\x92\xd3\x9f\xbb"] = self.data["\x92\xd3\x9f\xbb"] + 0.05;
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
    self.nvg notify("W\x1c#\xb0\x8e\xca\xd7\xcd\xcev\xfa\xa1\xae\x8c");
    wait interval;
    count--;
  }

  self.nvg.prevlightmeter = self.nvg.lightmeter;
  self.nvg.lightmeter = value;
}

function function_8b9c9e089a3cac51() {
  utility_sp::display_hint("\xef\xc2G\xa60\x15");

  while(!level.player isnightvisionon()) {
    waitframe();
  }
}