/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_loudspeaker.gsc
**********************************************************/

init_loudspeaker_trap() {
  wait(3);
  level.loudspeaker_trap_uses = 0;
  var_0 = scripts\engine\utility::getstructarray("trap_loudspeaker", "script_noteworthy");
  foreach(var_3, var_2 in var_0) {
    if(var_3 == 0) {
      var_2.origin = (2412, -2136.5, var_2.origin[2]);
      continue;
    }

    if(var_3 == 1) {
      var_2.origin = (2412, -2136.5, var_2.origin[2]);
      continue;
    }

    var_2.origin = (2412, -2058, var_2.origin[2]);
  }

  level.loudspeaker_blast_zone = getent("loudspeaker_blast_zone", "targetname");
  level.dance_floor_volume = level.loudspeaker_blast_zone;
  level.rave_dance_attract_zone = getent("rave_dance_attract_trig", "targetname");
  level.rave_dance_attract_zone.fgetarg = 750;
  level.rave_dance_attract_zone.height = 175;
  level.rave_dance_attract_zone.origin = level.rave_dance_attract_zone.origin + (0, 0, -50);
  foreach(var_5 in var_0) {
    var_5 thread func_13611();
  }

  wait(1);
  level.rave_dance_attract_sorter = scripts\engine\utility::getstruct("rave_dance_sorter", "targetname");
  level.rave_dance_spots = scripts\engine\utility::getstructarray("rave_dance_spots", "targetname");
  func_E1E0();
}

func_13611() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_1 = "power_on";
    if(var_0) {
      var_1 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_1 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_1 != "power_off") {
      self.powered_on = 1;
    } else {
      self.powered_on = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

use_loudspeaker_trap(var_0, var_1) {
  level.loudspeaker_trap_uses++;
  level.discotrap_active = 1;
  scripts\cp\cp_interaction::disable_like_interactions(var_0);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_0.trap_kills = 0;
  var_0.var_126A5 = var_1;
  level thread func_254E();
  var_0 thread sfx_speaker_trap();
  wait(29.5);
  level thread loudspeaker_damage(level.loudspeaker_blast_zone, var_1, var_0);
  wait(1);
  level notify("speaker_trap_done");
  wait(0.1);
  level thread loudspeaker_damage(level.loudspeaker_blast_zone, var_1, var_0);
  wait(0.5);
  level notify("speaker_trap_kills", var_0.trap_kills);
  func_E1E0();
  level.discotrap_active = undefined;
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_1.tickets_earned = var_0.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  scripts\cp\cp_interaction::enable_like_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.loudspeaker_trap_uses * 45, 45));
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
  var_0 = getent("rave_dance_attract_trig", "targetname");
  level.rave_dancing_zombies = [];
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isplayer(var_1)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_1) || var_1.about_to_dance || var_1.scripted_mode) {
      continue;
    }

    if(var_1.agent_type == "slasher" || var_1.agent_type == "superslasher" || var_1.agent_type == "lumberjack" || var_1.agent_type == "zombie_sasquatch") {
      continue;
    }

    if(isDefined(var_1.is_skeleton)) {
      continue;
    }

    var_1 thread visionsetthermalforplayer();
    var_1 thread release_zombie_on_trap_done();
  }
}

func_78B3(var_0) {
  var_1 = sortbydistance(level.rave_dance_spots, level.rave_dance_attract_sorter.origin);
  foreach(var_3 in var_1) {
    if(!var_3.occupied) {
      var_3.occupied = 1;
      var_0.var_4D7D = var_3;
      return var_3;
    }
  }

  return undefined;
}

func_E1E0() {
  foreach(var_1 in level.rave_dance_spots) {
    var_1.occupied = 0;
  }
}

visionsetthermalforplayer(var_0) {
  self endon("death");
  self endon("turned");
  level endon("speaker_trap_done");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self ghostskulls_total_waves(32);
  var_1 = func_78B3(self);
  if(!isDefined(var_1)) {
    var_2 = sortbydistance(level.rave_dance_spots, self.origin);
    var_1 = var_2[0];
  }

  self.desired_dance_angles = (0, var_1.angles[1], 0);
  self ghostskulls_complete_status(var_1.origin);
  scripts\engine\utility::waittill_any("goal", "goal_reached");
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

loudspeaker_damage(var_0, var_1, var_2) {
  physicsexplosionsphere((2216, -2108, 2), 575, 512, 10);
  var_3 = 0;
  foreach(var_5 in level.rave_dancing_zombies) {
    if(isDefined(var_5) && isalive(var_5)) {
      var_5.trap_killed_by = var_1;
      var_2.trap_kills++;
      if(var_3 > 10) {
        var_5.nocorpse = 1;
        var_5.full_gib = 1;
        var_6 = "boombox";
        var_5 dodamage(var_5.health + 100, level.rave_dance_attract_sorter.origin, var_0, var_0, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
        continue;
      }

      var_5 setvelocity(vectornormalize(var_5.origin + (0, 0, 40) - level.rave_dance_attract_sorter.origin) * 1800 + (0, 0, 550));
      var_5.do_immediate_ragdoll = 1;
      var_5.customdeath = 1;
      var_5 thread speaker_delayed_death(var_1);
      var_3++;
      scripts\engine\utility::waitframe();
    }
  }
}

speaker_delayed_death(var_0) {
  self endon("death");
  wait(0.1);
  if(isDefined(var_0) && isalive(var_0)) {
    var_1 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_1), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + 1000, level.rave_dance_attract_sorter.origin, var_0, var_0, "MOD_EXPLOSIVE", "iw7_discotrap_zm");
    return;
  }

  self dodamage(self.health + 1000, level.rave_dance_attract_sorter.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw7_discotrap_zm");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.25);
  self.padding_damage = undefined;
}