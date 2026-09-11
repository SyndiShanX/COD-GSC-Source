/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\nvg\nvg_ai.gsc
***********************************************/

function nvg_ai_init() {
  var0 = getaiarray();

  foreach(var2 in var0) {
    thread nvg_ai();
  }

  scripts\engine\sp\utility::add_global_spawn_function("axis", &nvg_ai);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &nvg_ai);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", &nvg_ai);
  scripts\engine\utility::array_thread(getEntArray("dynolight_area", "targetname"), &dynolight_area_trigger_logic);
}

function nvg_ai() {
  self endon("death");
  wait 0.05;
  local_init();
  ai_nvg_player_update();
  thread nvg_death_cleanup();
}

function do_flir_footsteps(var0) {}

function dont_do_flir_footsteps() {}

function local_init() {
  scripts\engine\utility::ent_flag_init("react_to_dynolights");
  scripts\engine\utility::ent_flag_init("in_the_dark");

  if(istrue(level.is_dark)) {
    scripts\engine\utility::ent_flag_set("in_the_dark");
    return;
  }
}

function ai_nvg_player_update() {
  if(!should_update_ai_nvg_state()) {
    return;
  }

  var0 = level.player isnightvisionon();

  if(isDefined(self.custom_nvg_update_func)) {
    self thread[[self.custom_nvg_update_func]](var0);
    return;
  }
}

function should_update_ai_nvg_state() {
  if(self.classname == "script_vehicle_blackhornet") {
    return false;
  }

  return true;
}

function dynolight_area_trigger_logic() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isai(var0)) {
      continue;
    }

    if(!isDefined(var0.in_dynolight_trigger) && !isDefined(var0.nvg_goggles)) {
      GscBinSkip4(0x6e, var0, self);
    }
  }
}

function dynolight_area_ai(var0) {
  self endon("death");
  self.in_dynolight_trigger = var0;
  thread enable_ai_dynolight_behavior();

  while(self istouching(var0)) {
    wait 0.05;
  }

  disable_ai_dynolight_behavior();
}

function enable_ai_dynolight_behavior() {
  scripts\engine\utility::ent_flag_set("react_to_dynolights");
}

function updatelightmeter() {
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

  var0 = gettime();

  if(!isDefined(level.lastdynolightcleantime) || var0 == level.lastdynolightcleantime) {
    level.castingdynolights = scripts\engine\utility::array_removeundefined(level.castingdynolights);
    level.lastdynolightcleantime = var0;
  }

  var1 = sortbydistance(level.castingdynolights, self.origin);
  var2 = self getapproxeyepos();
  var3 = 9999999;

  if(isDefined(self.lightmeter_lastcheckpos)) {
    var3 = distancesquared(self.lightmeter_lastcheckpos, self.origin);
  }

  if(!isDefined(self.lightmeter_lastchecktime)) {
    self.lightmeter_lastchecktime = -1000;
  }

  var4 = [];
  var5 = [];
  var6 = [];
  var7 = var3 > 900;
  var8 = 998001;
  var9 = var1.size;

  for(var10 = 0; var10 < var9; var10++) {
    var11 = var1[var10];
    var12 = distancesquared(var2, var11.origin);

    if(var12 > var8) {
      break;
    }

    if(!var7 && var11.timeoflaststatechange >= self.lightmeter_lastchecktime) {
      var7 = 1;
    }

    if(!var11.alive) {
      continue;
    }

    if(var11 getscriptablepartstate("onoff") == "off") {
      continue;
    }

    var13 = 650;

    if(isDefined(var11.data)) {
      if(istrue(var11.data.script_ignoreme)) {
        continue;
      }

      if(istrue(var11.data.script_radius)) {
        var13 = var11.data.script_radius;

        if(var12 > var13 * var13) {
          continue;
        }
      }

      if(scripts\engine\utility::is_equal(var11.data.script_type, "light_spot")) {
        var14 = var11.data.script_fov_inner;
        var15 = var11.data.angles;
        var16 = var11.lightpos;

        if(!scripts\engine\utility::within_fov(var16, var15, var2, cos(var14))) {
          continue;
        }
      }
    }

    if(!var11 istouching(self.in_dynolight_trigger)) {
      continue;
    }

    var17 = var4.size;
    var4 = var11;
    var6 = var13;
    var5 = var12;
  }

  if(var7) {
    var18 = 0;
    var19 = spawnStruct();
    var20 = self pathdisttogoal();
    var21 = 32;
    var19.bmoving = lengthsquared(self.velocity) > 1 || var20 > var21;
    var22 = self getapproxeyepos() - self.origin;

    if(var19.bmoving) {
      var19.pointsonpath = [];
      var19.pointsonpath[0] = self.origin + var22;
      var19.pointsonpath[1] = self getposonpath(var21) + var22;

      if(var20 > var21 * 2) {
        var19.pointsonpath[2] = self getposonpath(var21 * 2) + var22;
      }
    }

    var9 = var4.size;

    for(var10 = 0; var10 < var9; var10++) {
      var11 = var4[var10];
      var23 = sqrt(var5[var10]);
      var13 = var6[var10];
      var24 = 0;

      if(isDefined(var11.data) && isDefined(var11.data.script_percent)) {
        var24 = var11.data.script_percent;
      } else if(isDefined(level.dynolight_falloff_dist)) {
        var24 = level.dynolight_falloff_dist;
      }

      var25 = (1 - scripts\engine\math::normalize_value(var13 * var24, var13, var23)) * var11.intensity;

      if(!dynolight_trace_passed(var11, var19)) {
        continue;
      }

      var18 += var25;

      if(var18 > 0.5) {
        break;
      }
    }

    self.lightmeter = var18;
    self.lightmeter_lastchecktime = gettime();
    self.lightmeter_lastcheckpos = self.origin;
  }
}

function dynolight_trace_passed(var0, var1) {
  var2 = [level.player];

  if(isDefined(var0.linked_ents)) {
    var2 = scripts\engine\utility::array_combine(var2, var0.linked_ents);
  }

  if(istrue(var1.bmoving)) {
    var2 = scripts\engine\utility::array_combine(var2, [var0, self]);
    var3 = var1.pointsonpath.size;

    for(var4 = 0; var4 < var3; var4++) {
      var5 = var1.pointsonpath[var4];

      if(scripts\engine\trace::ray_trace_passed(var0.lightpos, var5, var2, level.dynolight_trace_contents)) {
        return 1;
      }
    }

    return 0;
  }

  return var3 scripts\engine\utility::can_trace_to_ai(var3.lightpos, self, var5, level.dynolight_trace_contents);
}

function is_gun_raised() {
  if(nullweapon(self.weapon)) {
    return false;
  }

  return self gettagorigin("tag_eye")[2] - self gettagorigin("tag_flash")[2] <= 15;
}

function draw_spotlight_fov() {
  var0 = acos(cos(self.data.script_fov_inner));
  var1 = self.data.angles[1];
  var2 = self.data.angles[0];
  var3 = (1, 0, 0);
  var4 = self.data.script_radius;
  var5 = self.lightpos;
  var6 = 10;
}

function draw_flashlight_fov() {
  var0 = cos(30);
  var1 = (1, 0, 0);
  var2 = acos(var0);
  var3 = self gettagangles("tag_flash")[1];
  var4 = 500;
  var5 = self gettagorigin("tag_flash");
  var6 = 10;
}

function disable_ai_dynolight_behavior() {
  self.in_dynolight_trigger = undefined;
  self.lightmeter = undefined;
  self.maxsightdistsqrd = 67108864;
  level.player.dontmelee = undefined;
  scripts\engine\utility::ent_flag_clear("react_to_dynolights");

  if(istrue(level.is_dark)) {
    scripts\engine\utility::ent_flag_set("in_the_dark");
  } else {
    scripts\engine\utility::ent_flag_clear("in_the_dark");
  }

  self.threatsightratescale = undefined;
}

function nvg_death_cleanup() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(is_using_flashlight()) {
    kill_flashlight_fx(0);
    return;
  }
}

function flashlight_on(var0) {
  if(!can_use_flashlight()) {
    return;
  }

  if(is_using_flashlight()) {
    return;
  }

  self.flashlight = 1;
  play_flashlight_fx(var0);

  if(isDefined(self.flashlightlaserweapon)) {
    flashlight_laser_on();
    return;
  }
}

function flashlight_off(var0) {
  if(!is_using_flashlight()) {
    return;
  }

  self.flashlight = 0;
  kill_flashlight_fx(var0);

  if(isDefined(self.flashlightlaserweapon)) {
    flashlight_laser_off();
    return;
  }
}

function flashlight_laser_on() {
  if(isDefined(self.flashlightlaser)) {
    return;
  }

  var0 = spawn("script_model", (0, 0, 0));
  var0 linkTo(self, self.flashlightfxtag, (0, 0, 0), (0, 0, 0));
  var0 setModel("tag_laser");
  var0 setmoverlaserweapon(self.flashlightlaserweapon);
  var0 laserforceon();
  self.flashlightlaser = var0;
  thread flashlight_laser_cleanup();
}

function flashlight_laser_cleanup() {
  self endon("flashlight_laser_off");
  self waittill("death");
  self.flashlightlaser laserforceoff();
  self.flashlightlaser delete();
}

function flashlight_laser_off() {
  if(!isDefined(self.flashlightlaser)) {
    return;
  }

  self notify("flashlight_laser_off");
  self.flashlightlaser laserforceoff();
  self.flashlightlaser delete();
  self.flashlightlaser = undefined;
}

function play_flashlight_fx(var0) {
  var1 = "tag_flash";

  if(isDefined(self.flashlightfxoverridetag)) {
    var1 = self.flashlightfxoverridetag;
  }

  var2 = "npc_flashlight";

  if(isDefined(self.flashlightfxoverride)) {
    var2 = self.flashlightfxoverride;
  }

  self.flashlightfx = var2;
  self.flashlightfxtag = var1;

  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(var0) {
    scripts\engine\sp\utility::fx_playontag_safe(self.flashlightfx, self.flashlightfxtag, undefined, undefined, 1);
    return;
  }

  playFXOnTag(scripts\engine\utility::getfx(self.flashlightfx), self, self.flashlightfxtag);
}

function kill_flashlight_fx(var0) {
  if(scripts\engine\utility::is_equal(self.flashlightfxtag, "tag_flash") || !isDefined(self.flashlightfxtag)) {
    if(nullweapon(self.weapon)) {
      return;
    }
  }

  if(isDefined(self.flashlightfx)) {
    var1 = "tag_flash";

    if(isDefined(self.flashlightfxtag)) {
      var1 = self.flashlightfxtag;
    }

    if(!isDefined(var0)) {
      var0 = 1;
    }

    if(var0) {
      scripts\engine\sp\utility::fx_killontag_safe(self.flashlightfx, var1, undefined, undefined, 1);
    } else {
      killfxontag(scripts\engine\utility::getfx(self.flashlightfx), self, var1);
    }
  }

  self.flashlightfx = undefined;
  self.flashlightfxtag = undefined;
}

function is_using_flashlight() {
  if(istrue(self.flashlight)) {
    return 1;
  }

  return 0;
}

function is_using_nvg() {
  if(istrue(self.nvg)) {
    return 1;
  }

  return 0;
}

function can_use_flashlight() {
  if(isDefined(self.noflashlight) && self.noflashlight) {
    return false;
  }

  if(!isDefined(self.a) || !isDefined(self.a.weaponpos) || getqueuedspleveltransients(self.a.weaponpos["right"])) {
    return false;
  }

  return true;
}