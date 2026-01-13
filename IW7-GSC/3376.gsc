/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3376.gsc
*********************************************/

init_blackhole_trap() {
  level.blackholetrapuses = 0;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = scripts\engine\utility::getstructarray("blackhole_trap", "script_noteworthy");
  foreach(var_5 in var_3) {
    var_5 thread func_2B36();
    var_5.body = getent(var_5.target, "targetname");
    var_6 = scripts\engine\utility::getstructarray(var_5.target, "targetname");
    foreach(var_8 in var_6) {
      if(isDefined(var_8.fgetarg)) {
        var_5.var_2B32 = var_8;
        continue;
      }

      var_5.var_2B30 = var_8;
    }

    var_5.var_2B37 = spawn("trigger_radius", var_5.var_2B32.origin, 0, var_5.var_2B32.fgetarg, 96);
  }
}

func_2B36() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_1 = "power_on";
    if(var_0) {
      var_1 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_1 != "power_off") {
        self.powered_on = 1;
        self.body setModel("ride_zombies_chromosphere_on");
        level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
      } else {
        self.powered_on = 0;
      }
    }

    if(!var_0) {
      break;
    }

    wait(0.25);
  }
}

use_blackhole_trap(var_0, var_1) {
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  level.blackholetrapuses++;
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  level.angry_mike_trap_kills = 0;
  var_0.trap_kills = 0;
  var_2 = gettime() + 20000;
  var_0.body rotateyaw(10800, int(21), 5, 5);
  var_0 thread kill_zombies(var_1);
  earthquake(0.28, int(21), var_0.body.origin, 500);
  var_0 thread func_2B35(int(21), var_0.body.origin);
  level thread func_2B34(var_2);
  while(gettime() < var_2) {
    wait(1);
  }

  var_0 notify("stop_dmg");
  var_0.var_2B30.fx delete();
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_1.tickets_earned = var_0.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.blackholetrapuses * 45, 45));
}

func_2B34(var_0) {
  var_1 = getent("chromosphere_sign", "targetname");
  var_1 setscriptablepartstate("quake", "on");
  while(gettime() < var_0) {
    var_1 setscriptablepartstate("rumble", "rumble1");
    wait(1);
    var_1 setscriptablepartstate("rumble", "rumble2");
    wait(1);
  }

  var_1 setscriptablepartstate("rumble", "off");
  var_1 setscriptablepartstate("quake", "off");
}

func_2B35(var_0, var_1) {
  playsoundatpos(var_1, "trap_blackhole_ride_start");
  wait(2);
  var_2 = scripts\engine\utility::play_loopsound_in_space("trap_blackhole_ride_loop", var_1);
  wait(0.8);
  playsoundatpos((-3321, 802, 888), "trap_blackhole_energy_start");
  wait(0.6);
  var_3 = scripts\engine\utility::play_loopsound_in_space("trap_blackhole_energy_close_lp", (-3321, 802, 888));
  wait(0.1);
  var_4 = scripts\engine\utility::play_loopsound_in_space("trap_blackhole_trap_suction_lp", (-3013, 833, 511));
  wait(var_0 - 8.5);
  playsoundatpos(var_1, "trap_blackhole_ride_stop");
  wait(1);
  var_2 stoploopsound();
  wait(3.5);
  playsoundatpos((-3321, 802, 888), "trap_blackhole_energy_end");
  var_3 stoploopsound();
  var_4 stoploopsound();
  var_2 delete();
  var_3 delete();
  var_4 delete();
}

kill_zombies(var_0) {
  self endon("stop_dmg");
  wait(2);
  self.var_2B30.fx = spawnfx(level._effect["blackhole_trap"], self.var_2B30.origin, anglesToForward(self.var_2B30.angles), anglestoup(self.var_2B30.angles));
  wait(1);
  triggerfx(self.var_2B30.fx);
  for(;;) {
    self.var_2B37 waittill("trigger", var_1);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_1) || isDefined(var_1.flung)) {
      continue;
    }

    var_1.flung = 1;
    var_1 thread suck_zombie(var_0, self);
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_1, "death_blackhole", 0);
  }
}

suck_zombie(var_0, var_1) {
  self endon("death");
  var_2 = var_1.var_2B30;
  var_3 = var_1.var_2B32;
  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_4 = 16384;
  while(distancesquared(self.origin, var_3.origin) > var_4) {
    self setvelocity(vectornormalize(var_3.origin - self.origin) * 150 + (0, 0, 30));
    wait(0.05);
  }

  if(!isDefined(var_2.fx)) {
    self.scripted_mode = 0;
    self.flung = undefined;
    return;
  }

  var_5 = 2304;
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor rotateto((-90, 0, 0), 0.2);
  var_6 = 360;
  if(randomint(100) > 50) {
    var_6 = -360;
  }

  self.anchor rotateroll(var_6, 1.5);
  self.anchor moveto(var_2.origin, 1.5);
  wait(1.5);
  playsoundatpos(self.origin, "trap_blackhole_body_gore");
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self.anchor delete();
  self.disable_armor = 1;
  var_1.trap_kills = var_1.trap_kills + 2;
  if(scripts\engine\utility::flag("mini_ufo_red_ready")) {
    level.angry_mike_trap_kills++;
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_0.trapkills["trap_gravitron"])) {
      var_0.trapkills["trap_gravitron"] = 1;
    } else {
      var_0.trapkills["trap_gravitron"]++;
    }

    var_7 = ["kill_trap_generic", "kill_trap_gravitron"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_7), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + 100, var_2.origin, var_0, var_0, "MOD_UNKNOWN", "iw7_chromosphere_zm");
    return;
  }

  self dodamage(self.health + 100, var_2.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_chromosphere_zm");
}