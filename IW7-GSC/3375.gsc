/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3375.gsc
*********************************************/

init_beam_trap() {
  level.beamtrapuses = 0;
  var_0 = scripts\engine\utility::getstructarray("beamtrap", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_2A39();
  }
}

func_2A39() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
}

use_beam_trap(var_0, var_1) {
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  level.head_cutter_trap_kills = 0;
  level.beamtrapuses++;
  var_2 = 25;
  var_3 = sortbydistance(scripts\engine\utility::getstructarray("hc_start_struct", "targetname"), var_1.origin);
  var_0.trap_kills = 0;
  var_0.var_126A5 = var_1;
  level.hctraptrigger = var_3[0];
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_4 = getent(var_0.target, "targetname");
  var_5 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  playsoundatpos((-946, -3528, 456), "trap_beam_build");
  wait(2);
  var_4 playSound("trap_beam_start");
  var_6 = spawnfx(level._effect["beam_trap_beam"], var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
  scripts\engine\utility::waitframe();
  earthquake(0.2, 25, var_4.origin, 850);
  scripts\engine\utility::exploder(89);
  scripts\engine\utility::waitframe();
  triggerfx(var_6);
  level thread func_2A37(var_4, var_1, var_0);
  wait(0.4);
  var_4 playLoopSound("trap_beam_lp");
  var_7 = thread scripts\engine\utility::play_loopsound_in_space("trap_beam_impact_lp", (-950, -3075, 428));
  wait(var_2);
  var_4 stoploopsound("trap_beam_lp");
  var_7 stoploopsound();
  var_7 delete();
  playsoundatpos((-946, -3528, 456), "trap_beam_stop");
  var_6 delete();
  level notify("beam_trap_done");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_1.tickets_earned = var_0.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.beamtrapuses * 45, 45));
}

func_2A37(var_0, var_1, var_2) {
  level endon("beam_trap_done");
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(isDefined(var_3.padding_damage)) {
      continue;
    }

    if(isPlayer(var_3) && isalive(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      var_3.padding_damage = 1;
      var_3 thread remove_padding_damage();
      var_4 = var_3 getstance();
      if(var_4 == "prone" || var_4 == "crouch" || var_3 issprintsliding()) {
        continue;
      }

      var_3 dodamage(50, (-959, -3560, 420), var_3, var_3, "MOD_UNKNOWN", "iw7_beamtrap_zm");
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_3, undefined, 1) && !scripts\engine\utility::istrue(var_3.dismember_crawl)) {
      var_2.trap_kills = var_2.trap_kills + 2;
      var_3.marked_for_death = 1;
      var_3.trap_killed_by = var_1;
      var_3 thread func_3286(var_1);
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(1);
  self.padding_damage = undefined;
}

func_3286(var_0) {
  self endon("death");
  if(!scripts\engine\utility::istrue(self.is_suicide_bomber)) {
    self.is_burning = 1;
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    wait(1);
    self.disable_armor = 1;
  }

  if(scripts\engine\utility::flag("mini_ufo_yellow_ready")) {
    level.head_cutter_trap_kills++;
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_0.trapkills["trap_dragon"])) {
      var_0.trapkills["trap_dragon"] = 1;
    } else {
      var_0.trapkills["trap_dragon"]++;
    }

    var_1 = ["kill_trap_generic", "kill_trap_dragon"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_1), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + -15536, self.origin, var_0, var_0, "MOD_UNKNOWN", "iw7_beamtrap_zm");
    return;
  }

  self dodamage(self.health + -15536, self.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_beamtrap_zm");
}