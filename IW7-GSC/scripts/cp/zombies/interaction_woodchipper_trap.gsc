/***************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_woodchipper_trap.gsc
***************************************************************/

init_woodchipper_trap() {
  level.blackholetrapuses = 0;
  var_00 = scripts\engine\utility::getstructarray("interaction_woodchipper", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread woodchipper_trap_wait_for_power();
    var_03 = scripts\engine\utility::getstructarray(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      if(isDefined(var_05.fgetarg)) {
        var_02.suction_spot = var_05;
      }

      if(var_05.script_noteworthy == "zombie_in_fx") {
        var_02.zombie_in_fx = var_05;
      }

      if(var_05.script_noteworthy == "zombie_out_fx") {
        var_02.zombie_out_fx = var_05;
      }
    }

    var_07 = getEntArray(var_02.target, "targetname");
    foreach(var_09 in var_07) {
      if(var_09.classname == "light_spot") {
        var_02.setminimap = var_09;
      }
    }

    var_02.woodchipper_trigger = spawn("trigger_radius", var_02.suction_spot.origin, 0, var_02.suction_spot.fgetarg, 96);
    var_02.setminimap setlightintensity(0);
  }
}

woodchipper_trap_wait_for_power() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_01 = "power_on";
    if(var_00) {
      var_01 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_01 != "power_off") {
        self.powered_on = 1;
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

use_woodchipper_trap(param_00, param_01) {
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  param_00.setminimap setlightintensity(80);
  param_00.var_19 = 1;
  param_00.trap_kills = 0;
  var_02 = gettime() + 20000;
  param_00 thread kill_zombies(param_01);
  earthquake(0.21, int(21), param_00.origin, 500);
  playsoundatpos(param_00.origin, "trap_wood_chipper_start");
  var_03 = thread scripts\engine\utility::play_loopsound_in_space("trap_wood_chipper_lp", param_00.origin);
  while(gettime() < var_02) {
    wait(1);
  }

  playsoundatpos(param_00.origin, "trap_wood_chipper_end");
  var_03 stoploopsound();
  var_03 delete();
  param_00.setminimap setlightintensity(0);
  param_00 notify("stop_dmg");
  param_00.var_19 = undefined;
  level notify("woodchipper_trap_kills", param_00.trap_kills);
  if(param_01 scripts\cp\utility::is_valid_player()) {
    param_01.tickets_earned = param_00.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.blackholetrapuses * 45, 45));
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
  for(;;) {
    self.woodchipper_trigger waittill("trigger", var_01);
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
  var_02 = param_01.zombie_in_fx;
  var_03 = param_01.suction_spot;
  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_04 = 4096;
  while(distancesquared(self.origin, var_03.origin) > var_04) {
    self setvelocity(vectornormalize(var_03.origin - self.origin) * 150 + (0, 0, 30));
    wait(0.05);
  }

  if(!isDefined(param_01.var_19)) {
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
  self.anchor moveto(var_02.origin, 0.5);
  wait(0.5);
  playFX(level._effect["woodchipper_entry"], self.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  self.anchor delete();
  self.disable_armor = 1;
  param_01.trap_kills = param_01.trap_kills + 1;
  thread woodchipper_spray(param_01);
  if(param_01.trap_kills == 1) {
    scripts\engine\utility::exploder(11);
  }

  thread woodchipper_grind_sfx(param_01);
  if(isDefined(param_00)) {
    var_06 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_06), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + 100, var_02.origin, param_00, param_00, "MOD_UNKNOWN", "iw7_chromosphere_zm");
    return;
  }

  self dodamage(self.health + 100, var_02.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_chromosphere_zm");
}

woodchipper_grind_sfx(param_00) {
  if(!isDefined(param_00.grind_sfx)) {
    param_00.grind_sfx = 0;
  }

  if(param_00.grind_sfx == 0) {
    param_00.grind_sfx = 1;
    playsoundatpos(param_00.origin, "trap_wood_chipper_grind");
    wait(2.2);
    param_00.grind_sfx = 0;
  }
}

woodchipper_spray(param_00) {
  self waittill("death");
  wait(0.5);
  playFX(level._effect["woodchipper_spray"], param_00.zombie_out_fx.origin, anglesToForward(param_00.zombie_out_fx.angles), anglestoup(param_00.zombie_out_fx.angles));
}