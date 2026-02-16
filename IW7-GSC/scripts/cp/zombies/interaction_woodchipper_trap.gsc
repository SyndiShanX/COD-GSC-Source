/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_woodchipper_trap.gsc
***************************************************************/

init_woodchipper_trap() {
  level.blackholetrapuses = 0;
  var_0 = scripts\engine\utility::getStructArray("interaction_woodchipper", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread woodchipper_trap_wait_for_power();
    var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      if(isDefined(var_5.fgetarg)) {
        var_2.suction_spot = var_5;
      }

      if(var_5.script_noteworthy == "zombie_in_fx") {
        var_2.zombie_in_fx = var_5;
      }

      if(var_5.script_noteworthy == "zombie_out_fx") {
        var_2.zombie_out_fx = var_5;
      }
    }

    var_7 = getEntArray(var_2.target, "targetname");
    foreach(var_9 in var_7) {
      if(var_9.classname == "light_spot") {
        var_2.setminimap = var_9;
      }
    }

    var_2.woodchipper_trigger = spawn("trigger_radius", var_2.suction_spot.origin, 0, var_2.suction_spot.fgetarg, 96);
    var_2.setminimap setlightintensity(0);
  }
}

woodchipper_trap_wait_for_power() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_1 = "power_on";
    if(var_0) {
      var_1 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_1 != "power_off") {
        self.powered_on = 1;
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

use_woodchipper_trap(var_0, var_1) {
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_0.setminimap setlightintensity(80);
  var_0.var_19 = 1;
  var_0.trap_kills = 0;
  var_2 = gettime() + 20000;
  var_0 thread kill_zombies(var_1);
  earthquake(0.21, int(21), var_0.origin, 500);
  playsoundatpos(var_0.origin, "trap_wood_chipper_start");
  var_3 = thread scripts\engine\utility::play_loopsound_in_space("trap_wood_chipper_lp", var_0.origin);
  while(gettime() < var_2) {
    wait(1);
  }

  playsoundatpos(var_0.origin, "trap_wood_chipper_end");
  var_3 stoploopsound();
  var_3 delete();
  var_0.setminimap setlightintensity(0);
  var_0 notify("stop_dmg");
  var_0.var_19 = undefined;
  level notify("woodchipper_trap_kills", var_0.trap_kills);
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_1.tickets_earned = var_0.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.blackholetrapuses * 45, 45));
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
  for(;;) {
    self.woodchipper_trigger waittill("trigger", var_1);
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
  var_2 = var_1.zombie_in_fx;
  var_3 = var_1.suction_spot;
  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_4 = 4096;
  while(distancesquared(self.origin, var_3.origin) > var_4) {
    self setvelocity(vectornormalize(var_3.origin - self.origin) * 150 + (0, 0, 30));
    wait(0.05);
  }

  if(!isDefined(var_1.var_19)) {
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
  self.anchor moveto(var_2.origin, 0.5);
  wait(0.5);
  playFX(level._effect["woodchipper_entry"], self.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  self.anchor delete();
  self.disable_armor = 1;
  var_1.trap_kills = var_1.trap_kills + 1;
  thread woodchipper_spray(var_1);
  if(var_1.trap_kills == 1) {
    scripts\engine\utility::exploder(11);
  }

  thread woodchipper_grind_sfx(var_1);
  if(isDefined(var_0)) {
    var_6 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_6), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + 100, var_2.origin, var_0, var_0, "MOD_UNKNOWN", "iw7_chromosphere_zm");
    return;
  }

  self dodamage(self.health + 100, var_2.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_chromosphere_zm");
}

woodchipper_grind_sfx(var_0) {
  if(!isDefined(var_0.grind_sfx)) {
    var_0.grind_sfx = 0;
  }

  if(var_0.grind_sfx == 0) {
    var_0.grind_sfx = 1;
    playsoundatpos(var_0.origin, "trap_wood_chipper_grind");
    wait(2.2);
    var_0.grind_sfx = 0;
  }
}

woodchipper_spray(var_0) {
  self waittill("death");
  wait(0.5);
  playFX(level._effect["woodchipper_spray"], var_0.zombie_out_fx.origin, anglesToForward(var_0.zombie_out_fx.angles), anglestoup(var_0.zombie_out_fx.angles));
}