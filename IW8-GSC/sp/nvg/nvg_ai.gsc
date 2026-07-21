/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\nvg\nvg_ai.gsc
***********************************************/

nvg_ai_init() {
  var_0 = getaiarray();

  foreach(var_2 in var_0)
  var_2 thread nvg_ai();

  scripts\engine\sp\utility::add_global_spawn_function("axis", ::nvg_ai);
  scripts\engine\sp\utility::add_global_spawn_function("allies", ::nvg_ai);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", ::nvg_ai);
  scripts\engine\utility::array_thread(getEntArray("dynolight_area", "targetname"), ::dynolight_area_trigger_logic);
}

nvg_ai() {
  self endon("death");
  wait 0.05;
  local_init();
  ai_nvg_player_update();
  thread nvg_death_cleanup();
}

do_flir_footsteps(var_0) {}

dont_do_flir_footsteps() {}

local_init() {
  scripts\engine\utility::ent_flag_init("react_to_dynolights");
  scripts\engine\utility::ent_flag_init("in_the_dark");

  if(istrue(level.is_dark))
    scripts\engine\utility::ent_flag_set("in_the_dark");
}

ai_nvg_player_update() {
  if(!should_update_ai_nvg_state()) {
    return;
  }
  var_0 = level.player isnightvisionon();

  if(isDefined(self.custom_nvg_update_func))
    self thread[[self.custom_nvg_update_func]](var_0);
}

should_update_ai_nvg_state() {
  if(self.classname == "script_vehicle_blackhornet")
    return 0;

  return 1;
}

dynolight_area_trigger_logic() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isai(var_0)) {
      continue;
    }
    if(!isDefined(var_0.in_dynolight_trigger) && !isDefined(var_0.nvg_goggles))
      var_0 childthread dynolight_area_ai(self);
  }
}

dynolight_area_ai(var_0) {
  self endon("death");
  self.in_dynolight_trigger = var_0;
  thread enable_ai_dynolight_behavior();

  while(self istouching(var_0))
    wait 0.05;

  disable_ai_dynolight_behavior();
}

enable_ai_dynolight_behavior() {
  scripts\engine\utility::ent_flag_set("react_to_dynolights");
}

updatelightmeter() {
  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]() && !istrue(self.reacttodynolightsinhunt)) {
    self.lightmeter = undefined;
    return;
  }

  if(distancesquared(self.origin, level.player.origin) > 4000000) {
    return;
  }
  if(!isDefined(level.castingdynolights) || level.castingdynolights.size == 0) {
    self.lightmeter = scripts\engine\utility::ter_op(istrue(level.is_dark), 0, 1);
    return;
  }

  var_0 = gettime();

  if(!isDefined(level.lastdynolightcleantime) || var_0 == level.lastdynolightcleantime) {
    level.castingdynolights = scripts\engine\utility::array_removeundefined(level.castingdynolights);
    level.lastdynolightcleantime = var_0;
  }

  var_1 = sortbydistance(level.castingdynolights, self.origin);
  var_2 = self getapproxeyepos();
  var_3 = 9999999;

  if(isDefined(self.lightmeter_lastcheckpos))
    var_3 = distancesquared(self.lightmeter_lastcheckpos, self.origin);

  if(!isDefined(self.lightmeter_lastchecktime))
    self.lightmeter_lastchecktime = -1000;

  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = var_3 > 900;
  var_8 = 998001;
  var_9 = var_1.size;

  for(var_10 = 0; var_10 < var_9; var_10++) {
    var_11 = var_1[var_10];
    var_12 = distancesquared(var_2, var_11.origin);

    if(var_12 > var_8) {
      break;
    }

    if(!var_7 && var_11.timeoflaststatechange >= self.lightmeter_lastchecktime)
      var_7 = 1;

    if(!var_11.alive) {
      continue;
    }
    if(var_11 getscriptablepartstate("onoff") == "off") {
      continue;
    }
    var_13 = 650;

    if(isDefined(var_11.data)) {
      if(istrue(var_11.data.script_ignoreme)) {
        continue;
      }
      if(istrue(var_11.data.script_radius)) {
        var_13 = var_11.data.script_radius;

        if(var_12 > var_13 * var_13)
          continue;
      }

      if(scripts\engine\utility::is_equal(var_11.data.script_type, "light_spot")) {
        var_14 = var_11.data.script_fov_inner;
        var_15 = var_11.data.angles;
        var_16 = var_11.lightpos;

        if(!scripts\engine\utility::within_fov(var_16, var_15, var_2, cos(var_14)))
          continue;
      }
    }

    if(!var_11 istouching(self.in_dynolight_trigger)) {
      continue;
    }
    var_17 = var_4.size;
    var_4[var_17] = var_11;
    var_6[var_17] = var_13;
    var_5[var_17] = var_12;
  }

  if(var_7) {
    var_18 = 0;
    var_19 = spawnStruct();
    var_20 = self pathdisttogoal();
    var_21 = 32;
    var_19.bmoving = lengthsquared(self.velocity) > 1 || var_20 > var_21;
    var_22 = self getapproxeyepos() - self.origin;

    if(var_19.bmoving) {
      var_19.pointsonpath = [];
      var_19.pointsonpath[0] = self.origin + var_22;
      var_19.pointsonpath[1] = self getposonpath(var_21) + var_22;

      if(var_20 > var_21 * 2)
        var_19.pointsonpath[2] = self getposonpath(var_21 * 2) + var_22;
    }

    var_9 = var_4.size;

    for(var_10 = 0; var_10 < var_9; var_10++) {
      var_11 = var_4[var_10];
      var_23 = sqrt(var_5[var_10]);
      var_13 = var_6[var_10];
      var_24 = 0;

      if(isDefined(var_11.data) && isDefined(var_11.data.script_percent))
        var_24 = var_11.data.script_percent;
      else if(isDefined(level.dynolight_falloff_dist))
        var_24 = level.dynolight_falloff_dist;

      var_25 = (1 - scripts\engine\math::normalize_value(var_13 * var_24, var_13, var_23)) * var_11.intensity;

      if(!dynolight_trace_passed(var_11, var_19)) {
        continue;
      }
      var_18 = var_18 + var_25;

      if(var_18 > 0.5) {
        break;
      }
    }

    self.lightmeter = var_18;
    self.lightmeter_lastchecktime = gettime();
    self.lightmeter_lastcheckpos = self.origin;
  }
}

dynolight_trace_passed(var_0, var_1) {
  var_2 = [level.player];

  if(isDefined(var_0.linked_ents))
    var_2 = scripts\engine\utility::array_combine(var_2, var_0.linked_ents);

  if(istrue(var_1.bmoving)) {
    var_2 = scripts\engine\utility::array_combine(var_2, [var_0, self]);
    var_3 = var_1.pointsonpath.size;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_1.pointsonpath[var_4];

      if(scripts\engine\trace::ray_trace_passed(var_0.lightpos, var_5, var_2, level.dynolight_trace_contents))
        return 1;
    }

    return 0;
  }

  return var_0 scripts\engine\utility::can_trace_to_ai(var_0.lightpos, self, var_2, level.dynolight_trace_contents);
}

is_gun_raised() {
  if(nullweapon(self.weapon))
    return 0;

  return self gettagorigin("tag_eye")[2] - self gettagorigin("tag_flash")[2] <= 15;
}

draw_spotlight_fov() {
  var_0 = acos(cos(self.data.script_fov_inner));
  var_1 = self.data.angles[1];
  var_2 = self.data.angles[0];
  var_3 = (1, 0, 0);
  var_4 = self.data.script_radius;
  var_5 = self.lightpos;
  var_6 = 10;
}

draw_flashlight_fov() {
  var_0 = cos(30);
  var_1 = (1, 0, 0);
  var_2 = acos(var_0);
  var_3 = self gettagangles("tag_flash")[1];
  var_4 = 500;
  var_5 = self gettagorigin("tag_flash");
  var_6 = 10;
}

disable_ai_dynolight_behavior() {
  self.in_dynolight_trigger = undefined;
  self.lightmeter = undefined;
  self.maxsightdistsqrd = 67108864;
  level.player.dontmelee = undefined;
  scripts\engine\utility::ent_flag_clear("react_to_dynolights");

  if(istrue(level.is_dark))
    scripts\engine\utility::ent_flag_set("in_the_dark");
  else
    scripts\engine\utility::ent_flag_clear("in_the_dark");

  self.threatsightratescale = undefined;
}

nvg_death_cleanup() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(is_using_flashlight())
    kill_flashlight_fx(0);
}

flashlight_on(var_0) {
  if(!can_use_flashlight()) {
    return;
  }
  if(is_using_flashlight()) {
    return;
  }
  self.flashlight = 1;
  play_flashlight_fx(var_0);

  if(isDefined(self.flashlightlaserweapon))
    flashlight_laser_on();
}

flashlight_off(var_0) {
  if(!is_using_flashlight()) {
    return;
  }
  self.flashlight = 0;
  kill_flashlight_fx(var_0);

  if(isDefined(self.flashlightlaserweapon))
    flashlight_laser_off();
}

flashlight_laser_on() {
  if(isDefined(self.flashlightlaser)) {
    return;
  }
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 linkTo(self, self.flashlightfxtag, (0, 0, 0), (0, 0, 0));
  var_0 setModel("tag_laser");
  var_0 setmoverlaserweapon(self.flashlightlaserweapon);
  var_0 laserforceon();
  self.flashlightlaser = var_0;
  thread flashlight_laser_cleanup();
}

flashlight_laser_cleanup() {
  self endon("flashlight_laser_off");
  self waittill("death");
  self.flashlightlaser laserforceoff();
  self.flashlightlaser delete();
}

flashlight_laser_off() {
  if(!isDefined(self.flashlightlaser)) {
    return;
  }
  self notify("flashlight_laser_off");
  self.flashlightlaser laserforceoff();
  self.flashlightlaser delete();
  self.flashlightlaser = undefined;
}

play_flashlight_fx(var_0) {
  var_1 = "tag_flash";

  if(isDefined(self.flashlightfxoverridetag))
    var_1 = self.flashlightfxoverridetag;

  var_2 = "npc_flashlight";

  if(isDefined(self.flashlightfxoverride))
    var_2 = self.flashlightfxoverride;

  self.flashlightfx = var_2;
  self.flashlightfxtag = var_1;

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0)
    scripts\engine\sp\utility::fx_playontag_safe(self.flashlightfx, self.flashlightfxtag, undefined, undefined, 1);
  else
    playFXOnTag(scripts\engine\utility::getfx(self.flashlightfx), self, self.flashlightfxtag);
}

kill_flashlight_fx(var_0) {
  if(scripts\engine\utility::is_equal(self.flashlightfxtag, "tag_flash") || !isDefined(self.flashlightfxtag)) {
    if(nullweapon(self.weapon))
      return;
  }

  if(isDefined(self.flashlightfx)) {
    var_1 = "tag_flash";

    if(isDefined(self.flashlightfxtag))
      var_1 = self.flashlightfxtag;

    if(!isDefined(var_0))
      var_0 = 1;

    if(var_0)
      scripts\engine\sp\utility::fx_killontag_safe(self.flashlightfx, var_1, undefined, undefined, 1);
    else
      killfxontag(scripts\engine\utility::getfx(self.flashlightfx), self, var_1);
  }

  self.flashlightfx = undefined;
  self.flashlightfxtag = undefined;
}

is_using_flashlight() {
  if(istrue(self.flashlight))
    return 1;
  else
    return 0;
}

is_using_nvg() {
  if(istrue(self.nvg))
    return 1;
  else
    return 0;
}

can_use_flashlight() {
  if(isDefined(self.noflashlight) && self.noflashlight)
    return 0;

  if(!isDefined(self.a) || !isDefined(self.a.weaponpos) || getqueuedspleveltransients(self.a.weaponpos["right"]))
    return 0;

  return 1;
}