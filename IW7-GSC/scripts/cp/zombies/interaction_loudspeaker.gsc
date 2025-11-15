/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_loudspeaker.gsc
**********************************************************/

init_loudspeaker_trap() {
  wait(3);
  level.loudspeaker_trap_uses = 0;
  var_00 = scripts\engine\utility::getstructarray("trap_loudspeaker", "script_noteworthy");
  foreach(var_03, var_02 in var_00) {
    if(var_03 == 0) {
      var_02.origin = (2412, -2136.5, var_02.origin[2]);
      continue;
    }

    if(var_03 == 1) {
      var_02.origin = (2412, -2136.5, var_02.origin[2]);
      continue;
    }

    var_02.origin = (2412, -2058, var_02.origin[2]);
  }

  level.loudspeaker_blast_zone = getent("loudspeaker_blast_zone", "targetname");
  level.dance_floor_volume = level.loudspeaker_blast_zone;
  level.rave_dance_attract_zone = getent("rave_dance_attract_trig", "targetname");
  level.rave_dance_attract_zone.fgetarg = 750;
  level.rave_dance_attract_zone.height = 175;
  level.rave_dance_attract_zone.origin = level.rave_dance_attract_zone.origin + (0, 0, -50);
  foreach(var_05 in var_00) {
    var_05 thread func_13611();
  }

  wait(1);
  level.rave_dance_attract_sorter = scripts\engine\utility::getstruct("rave_dance_sorter", "targetname");
  level.rave_dance_spots = scripts\engine\utility::getstructarray("rave_dance_spots", "targetname");
  func_E1E0();
}

func_13611() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_01 = "power_on";
    if(var_00) {
      var_01 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_01 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_01 != "power_off") {
      self.powered_on = 1;
    } else {
      self.powered_on = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

use_loudspeaker_trap(param_00, param_01) {
  level.loudspeaker_trap_uses++;
  level.discotrap_active = 1;
  scripts\cp\cp_interaction::disable_like_interactions(param_00);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  param_00.trap_kills = 0;
  param_00.var_126A5 = param_01;
  level thread func_254E();
  param_00 thread sfx_speaker_trap();
  wait(29.5);
  level thread loudspeaker_damage(level.loudspeaker_blast_zone, param_01, param_00);
  wait(1);
  level notify("speaker_trap_done");
  wait(0.1);
  level thread loudspeaker_damage(level.loudspeaker_blast_zone, param_01, param_00);
  wait(0.5);
  level notify("speaker_trap_kills", param_00.trap_kills);
  func_E1E0();
  level.discotrap_active = undefined;
  if(param_01 scripts\cp\utility::is_valid_player(1)) {
    param_01.tickets_earned = param_00.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  scripts\cp\cp_interaction::enable_like_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.loudspeaker_trap_uses * 45, 45));
}

sfx_speaker_trap() {
  level thread scripts\cp\maps\cp_rave\cp_rave::disable_rave_speakers();
  playsoundatpos(self.origin, "mus_rave_stage_trap");
  wait(28.8);
  playsoundatpos(self.origin, "trap_speaker_feedback");
  scripts\engine\utility::exploder(1);
  wait(1.2);
  playsoundatpos(self.origin, "trap_speaker_expl");
  wait(0.5);
  level thread scripts\cp\maps\cp_rave\cp_rave::reenable_rave_speakers();
}

func_254E() {
  level endon("speaker_trap_done");
  var_00 = getent("rave_dance_attract_trig", "targetname");
  level.rave_dancing_zombies = [];
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(isplayer(var_01)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_01) || var_01.about_to_dance || var_01.scripted_mode) {
      continue;
    }

    if(var_01.agent_type == "slasher" || var_01.agent_type == "superslasher" || var_01.agent_type == "lumberjack" || var_01.agent_type == "zombie_sasquatch") {
      continue;
    }

    if(isDefined(var_01.is_skeleton)) {
      continue;
    }

    var_01 thread visionsetthermalforplayer();
    var_01 thread release_zombie_on_trap_done();
  }
}

func_78B3(param_00) {
  var_01 = sortbydistance(level.rave_dance_spots, level.rave_dance_attract_sorter.origin);
  foreach(var_03 in var_01) {
    if(!var_03.occupied) {
      var_03.occupied = 1;
      param_00.var_4D7D = var_03;
      return var_03;
    }
  }

  return undefined;
}

func_E1E0() {
  foreach(var_01 in level.rave_dance_spots) {
    var_01.occupied = 0;
  }
}

visionsetthermalforplayer(param_00) {
  self endon("death");
  self endon("turned");
  level endon("speaker_trap_done");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self ghostskulls_total_waves(32);
  var_01 = func_78B3(self);
  if(!isDefined(var_01)) {
    var_02 = sortbydistance(level.rave_dance_spots, self.origin);
    var_01 = var_02[0];
  }

  self.desired_dance_angles = (0, var_01.angles[1], 0);
  self ghostskulls_complete_status(var_01.origin);
  scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  self.do_immediate_ragdoll = 1;
  self.is_dancing = 1;
  level.rave_dancing_zombies[level.rave_dancing_zombies.size] = self;
}

release_zombie_on_trap_done() {
  self endon("death");
  level waittill("speaker_trap_done");
  if(isDefined(self.og_goalradius)) {
    self ghostskulls_total_waves(self.og_goalradius);
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
}

loudspeaker_damage(param_00, param_01, param_02) {
  physicsexplosionsphere((2216, -2108, 2), 575, 512, 10);
  var_03 = 0;
  foreach(var_05 in level.rave_dancing_zombies) {
    if(isDefined(var_05) && isalive(var_05)) {
      var_05.trap_killed_by = param_01;
      param_02.trap_kills++;
      if(var_03 > 10) {
        var_05.nocorpse = 1;
        var_05.full_gib = 1;
        var_06 = "boombox";
        var_05 dodamage(var_05.health + 100, level.rave_dance_attract_sorter.origin, param_00, param_00, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
        continue;
      }

      var_05 setvelocity(vectornormalize(var_05.origin + (0, 0, 40) - level.rave_dance_attract_sorter.origin) * 1800 + (0, 0, 550));
      var_05.do_immediate_ragdoll = 1;
      var_05.customdeath = 1;
      var_05 thread speaker_delayed_death(param_01);
      var_03++;
      scripts\engine\utility::waitframe();
    }
  }
}

speaker_delayed_death(param_00) {
  self endon("death");
  wait(0.1);
  if(isDefined(param_00) && isalive(param_00)) {
    var_01 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_01), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + 1000, level.rave_dance_attract_sorter.origin, param_00, param_00, "MOD_EXPLOSIVE", "iw7_discotrap_zm");
    return;
  }

  self dodamage(self.health + 1000, level.rave_dance_attract_sorter.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw7_discotrap_zm");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.25);
  self.padding_damage = undefined;
}