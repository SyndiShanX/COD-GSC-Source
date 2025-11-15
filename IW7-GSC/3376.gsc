/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3376.gsc
************************/

init_blackhole_trap() {
  level.blackholetrapuses = 0;
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = scripts\engine\utility::getstructarray("blackhole_trap", "script_noteworthy");
  foreach(var_05 in var_03) {
    var_05 thread func_2B36();
    var_05.body = getent(var_05.target, "targetname");
    var_06 = scripts\engine\utility::getstructarray(var_05.target, "targetname");
    foreach(var_08 in var_06) {
      if(isDefined(var_08.fgetarg)) {
        var_05.var_2B32 = var_08;
        continue;
      }

      var_05.var_2B30 = var_08;
    }

    var_05.var_2B37 = spawn("trigger_radius", var_05.var_2B32.origin, 0, var_05.var_2B32.fgetarg, 96);
  }
}

func_2B36() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_01 = "power_on";
    if(var_00) {
      var_01 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_01 != "power_off") {
        self.powered_on = 1;
        self.body setModel("ride_zombies_chromosphere_on");
        level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
      } else {
        self.powered_on = 0;
      }
    }

    if(!var_00) {
      break;
    }

    wait(0.25);
  }
}

use_blackhole_trap(param_00, param_01) {
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  level.blackholetrapuses++;
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  level.angry_mike_trap_kills = 0;
  param_00.trap_kills = 0;
  var_02 = gettime() + 20000;
  param_00.body rotateyaw(10800, int(21), 5, 5);
  param_00 thread kill_zombies(param_01);
  earthquake(0.28, int(21), param_00.body.origin, 500);
  param_00 thread func_2B35(int(21), param_00.body.origin);
  level thread func_2B34(var_02);
  while(gettime() < var_02) {
    wait(1);
  }

  param_00 notify("stop_dmg");
  param_00.var_2B30.fx delete();
  if(param_01 scripts\cp\utility::is_valid_player()) {
    param_01.tickets_earned = param_00.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.blackholetrapuses * 45, 45));
}

func_2B34(param_00) {
  var_01 = getent("chromosphere_sign", "targetname");
  var_01 setscriptablepartstate("quake", "on");
  while(gettime() < param_00) {
    var_01 setscriptablepartstate("rumble", "rumble1");
    wait(1);
    var_01 setscriptablepartstate("rumble", "rumble2");
    wait(1);
  }

  var_01 setscriptablepartstate("rumble", "off");
  var_01 setscriptablepartstate("quake", "off");
}

func_2B35(param_00, param_01) {
  playsoundatpos(param_01, "trap_blackhole_ride_start");
  wait(2);
  var_02 = scripts\engine\utility::play_loopsound_in_space("trap_blackhole_ride_loop", param_01);
  wait(0.8);
  playsoundatpos((-3321, 802, 888), "trap_blackhole_energy_start");
  wait(0.6);
  var_03 = scripts\engine\utility::play_loopsound_in_space("trap_blackhole_energy_close_lp", (-3321, 802, 888));
  wait(0.1);
  var_04 = scripts\engine\utility::play_loopsound_in_space("trap_blackhole_trap_suction_lp", (-3013, 833, 511));
  wait(param_00 - 8.5);
  playsoundatpos(param_01, "trap_blackhole_ride_stop");
  wait(1);
  var_02 stoploopsound();
  wait(3.5);
  playsoundatpos((-3321, 802, 888), "trap_blackhole_energy_end");
  var_03 stoploopsound();
  var_04 stoploopsound();
  var_02 delete();
  var_03 delete();
  var_04 delete();
}

kill_zombies(param_00) {
  self endon("stop_dmg");
  wait(2);
  self.var_2B30.fx = spawnfx(level._effect["blackhole_trap"], self.var_2B30.origin, anglesToForward(self.var_2B30.angles), anglestoup(self.var_2B30.angles));
  wait(1);
  triggerfx(self.var_2B30.fx);
  for(;;) {
    self.var_2B37 waittill("trigger", var_01);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_01) || isDefined(var_01.flung)) {
      continue;
    }

    var_01.flung = 1;
    var_01 thread suck_zombie(param_00, self);
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_01, "death_blackhole", 0);
  }
}

suck_zombie(param_00, param_01) {
  self endon("death");
  var_02 = param_01.var_2B30;
  var_03 = param_01.var_2B32;
  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_04 = 16384;
  while(distancesquared(self.origin, var_03.origin) > var_04) {
    self setvelocity(vectornormalize(var_03.origin - self.origin) * 150 + (0, 0, 30));
    wait(0.05);
  }

  if(!isDefined(var_02.fx)) {
    self.scripted_mode = 0;
    self.flung = undefined;
    return;
  }

  var_05 = 2304;
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor rotateto((-90, 0, 0), 0.2);
  var_06 = 360;
  if(randomint(100) > 50) {
    var_06 = -360;
  }

  self.anchor rotateroll(var_06, 1.5);
  self.anchor moveto(var_02.origin, 1.5);
  wait(1.5);
  playsoundatpos(self.origin, "trap_blackhole_body_gore");
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self.anchor delete();
  self.disable_armor = 1;
  param_01.trap_kills = param_01.trap_kills + 2;
  if(scripts\engine\utility::flag("mini_ufo_red_ready")) {
    level.angry_mike_trap_kills++;
  }

  if(isDefined(param_00)) {
    if(!isDefined(param_00.trapkills["trap_gravitron"])) {
      param_00.trapkills["trap_gravitron"] = 1;
    } else {
      param_00.trapkills["trap_gravitron"]++;
    }

    var_07 = ["kill_trap_generic", "kill_trap_gravitron"];
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_07), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + 100, var_02.origin, param_00, param_00, "MOD_UNKNOWN", "iw7_chromosphere_zm");
    return;
  }

  self dodamage(self.health + 100, var_02.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_chromosphere_zm");
}