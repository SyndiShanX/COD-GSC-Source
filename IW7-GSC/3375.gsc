/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3375.gsc
************************/

init_beam_trap() {
  level.beamtrapuses = 0;
  var_00 = scripts\engine\utility::getstructarray("beamtrap", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_2A39();
  }
}

func_2A39() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
}

use_beam_trap(param_00, param_01) {
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  level.head_cutter_trap_kills = 0;
  level.beamtrapuses++;
  var_02 = 25;
  var_03 = sortbydistance(scripts\engine\utility::getstructarray("hc_start_struct", "targetname"), param_01.origin);
  param_00.trap_kills = 0;
  param_00.var_126A5 = param_01;
  level.hctraptrigger = var_03[0];
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_04 = getent(param_00.target, "targetname");
  var_05 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  playsoundatpos((-946, -3528, 456), "trap_beam_build");
  wait(2);
  var_04 playSound("trap_beam_start");
  var_06 = spawnfx(level._effect["beam_trap_beam"], var_05.origin, anglesToForward(var_05.angles), anglestoup(var_05.angles));
  scripts\engine\utility::waitframe();
  earthquake(0.2, 25, var_04.origin, 850);
  scripts\engine\utility::exploder(89);
  scripts\engine\utility::waitframe();
  triggerfx(var_06);
  level thread func_2A37(var_04, param_01, param_00);
  wait(0.4);
  var_04 playLoopSound("trap_beam_lp");
  var_07 = thread scripts\engine\utility::play_loopsound_in_space("trap_beam_impact_lp", (-950, -3075, 428));
  wait(var_02);
  var_04 stoploopsound("trap_beam_lp");
  var_07 stoploopsound();
  var_07 delete();
  playsoundatpos((-946, -3528, 456), "trap_beam_stop");
  var_06 delete();
  level notify("beam_trap_done");
  if(param_01 scripts\cp\utility::is_valid_player(1)) {
    param_01.tickets_earned = param_00.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.beamtrapuses * 45, 45));
}

func_2A37(param_00, param_01, param_02) {
  level endon("beam_trap_done");
  for(;;) {
    param_00 waittill("trigger", var_03);
    if(isDefined(var_03.padding_damage)) {
      continue;
    }

    if(isplayer(var_03) && isalive(var_03) && !scripts\cp\cp_laststand::player_in_laststand(var_03)) {
      var_03.padding_damage = 1;
      var_03 thread remove_padding_damage();
      var_04 = var_03 getstance();
      if(var_04 == "prone" || var_04 == "crouch" || var_03 issprintsliding()) {
        continue;
      }

      var_03 dodamage(50, (-959, -3560, 420), var_03, var_03, "MOD_UNKNOWN", "iw7_beamtrap_zm");
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_03, undefined, 1) && !scripts\engine\utility::istrue(var_03.dismember_crawl)) {
      param_02.trap_kills = param_02.trap_kills + 2;
      var_03.marked_for_death = 1;
      var_03.trap_killed_by = param_01;
      var_03 thread func_3286(param_01);
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(1);
  self.padding_damage = undefined;
}

func_3286(param_00) {
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

  if(isDefined(param_00)) {
    if(!isDefined(param_00.trapkills["trap_dragon"])) {
      param_00.trapkills["trap_dragon"] = 1;
    } else {
      param_00.trapkills["trap_dragon"]++;
    }

    var_01 = ["kill_trap_generic", "kill_trap_dragon"];
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_01), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    self dodamage(self.health + -15536, self.origin, param_00, param_00, "MOD_UNKNOWN", "iw7_beamtrap_zm");
    return;
  }

  self dodamage(self.health + -15536, self.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_beamtrap_zm");
}