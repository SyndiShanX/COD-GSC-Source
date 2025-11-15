/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3387.gsc
************************/

init_rockettrap() {
  level.rockettrapuses = 0;
  var_00 = scripts\engine\utility::getstructarray("rockettrap", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_E5D9();
  }
}

func_E5D9() {
  var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in var_00) {
    if(var_04.script_noteworthy == "rocket_blast_fx") {
      self.sysprint = var_04;
    }

    if(var_04.script_noteworthy == "rocket_blast_trigger") {
      self.var_4CDF = var_04;
    }
  }

  var_06 = getEntArray(self.target, "targetname");
  var_07 = undefined;
  var_08 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_09 = "power_on";
  foreach(var_0B in var_06) {
    if(var_0B.classname == "light_spot") {
      var_07 = var_0B;
    }
  }

  var_07 setlightintensity(0);
  for(;;) {
    if(var_08) {
      var_09 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_09 != "power_off") {
      for(var_0D = 0; var_0D < 3; var_0D++) {
        var_07 setlightintensity(100);
        wait(randomfloatrange(0.5, 1));
        var_07 setlightintensity(0);
        wait(randomfloatrange(0.5, 1));
      }

      var_07 setlightintensity(100);
      self.powered_on = 1;
      level thread func_E5D6();
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
    } else {
      var_07 setlightintensity(0);
      self.powered_on = 0;
    }

    if(!var_08) {
      break;
    }
  }
}

use_rocket_trap(param_00, param_01) {
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  var_02 = sortbydistance(scripts\engine\utility::getstructarray("fm_start_struct", "targetname"), param_01.origin);
  level.rockettrapuses++;
  level.rocket_trap_kills = 0;
  level.fmtraptrigger = var_02[0];
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  if(!isDefined(level.var_E5D5)) {
    level.var_E5D5 = spawn("trigger_radius", param_00.var_4CDF.origin, 0, param_00.var_4CDF.fgetarg, 128);
    level.var_E5D8 = spawn("script_origin", param_00.sysprint.origin);
  }

  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  param_00.trap_kills = 0;
  param_00.var_126A5 = param_01;
  func_E5D3();
  level notify("rocket_idle_stop");
  scripts\engine\utility::exploder(56);
  level thread func_E5D4(level.var_E5D5, param_01, param_00);
  if(scripts\engine\utility::flag("mini_ufo_blue_ready")) {
    level thread func_13622();
  }

  level.var_E5D8 playSound("trap_rocket_start");
  wait(1.95);
  scripts\engine\utility::exploder(57);
  earthquake(0.3, 25, param_00.sysprint.origin, 850);
  scripts\engine\utility::waitframe();
  level.var_E5D8 playLoopSound("trap_rocket_lp");
  wait(21);
  level.var_E5D8 stoploopsound("trap_rocket_lp");
  level.var_E5D8 playSound("trap_rocket_stop");
  wait(0.75);
  level.var_E5D8 stoploopsound("trap_rocket_lp");
  level notify("rocket_trap_done");
  if(param_01 scripts\cp\utility::is_valid_player(1)) {
    param_01.tickets_earned = param_00.trap_kills * 2;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.rockettrapuses * 45, 45));
  level thread func_E5D6();
}

func_E5D3() {
  earthquake(0.12, 4, level.var_E5D5.origin, 1000);
  playsoundatpos(level.var_E5D5.origin, "trap_rocket_alarm");
  wait(1);
  playsoundatpos(level.var_E5D5.origin, "trap_rocket_alarm");
  wait(1);
}

func_E5D4(param_00, param_01, param_02) {
  level endon("rocket_trap_done");
  for(;;) {
    param_00 waittill("trigger", var_03);
    if(isplayer(var_03) && isalive(var_03) && !scripts\cp\cp_laststand::player_in_laststand(var_03) && !isDefined(var_03.padding_damage)) {
      var_03.padding_damage = 1;
      var_03 dodamage(35, var_03.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_rockettrap_zm");
      playfxontagforclients(level._effect["player_scr_fire"], var_03, "tag_eye", var_03);
      var_03 thread remove_padding_damage();
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_03, undefined, 1)) {
      if(scripts\engine\utility::istrue(var_03.is_burning)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_03.is_suicide_bomber)) {
        var_03.is_burning = 1;
        level notify("rocket_trap_kill");
        param_02.trap_kills++;
        var_03 dodamage(var_03.health + 1000, var_03.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_rockettrap_zm");
        continue;
      }

      var_04 = ["kill_trap_generic", "kill_trap_rocket"];
      param_01 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_04), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
      var_03.marked_for_death = 1;
      var_03.trap_killed_by = param_01;
      if(isDefined(param_01)) {
        if(!isDefined(param_01.trapkills["trap_rocket"])) {
          param_01.trapkills["trap_rocket"] = 1;
        } else {
          param_01.trapkills["trap_rocket"]++;
        }

        param_02.trap_kills++;
        var_03 thread scripts\cp\utility::damage_over_time(var_03, param_01, 1.5, int(var_03.health + 100), "MOD_UNKNOWN", "iw7_rockettrap_zm", 1, "burning", "rocket_trap_kill");
      } else {
        var_03 thread scripts\cp\utility::damage_over_time(var_03, undefined, 1.5, int(var_03.health + 100), "MOD_UNKNOWN", "iw7_rockettrap_zm", 1, "burning", "rocket_trap_kill");
      }
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.25);
  self.padding_damage = undefined;
}

func_13622() {
  level endon("rocket_trap_done");
  for(;;) {
    level waittill("rocket_trap_kill");
    level.rocket_trap_kills++;
  }
}

func_E5D6() {
  level endon("rocket_idle_stop");
  for(;;) {
    scripts\engine\utility::exploder(55);
    wait(1);
  }
}