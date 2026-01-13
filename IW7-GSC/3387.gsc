/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3387.gsc
************************/

init_rockettrap() {
  level.rockettrapuses = 0;
  var_0 = scripts\engine\utility::getstructarray("rockettrap", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_E5D9();
  }
}

func_E5D9() {
  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");
  var_1 = undefined;
  var_2 = undefined;
  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == "rocket_blast_fx") {
      self.sysprint = var_4;
    }

    if(var_4.script_noteworthy == "rocket_blast_trigger") {
      self.var_4CDF = var_4;
    }
  }

  var_6 = getEntArray(self.target, "targetname");
  var_7 = undefined;
  var_8 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_9 = "power_on";
  foreach(var_0B in var_6) {
    if(var_0B.classname == "light_spot") {
      var_7 = var_0B;
    }
  }

  var_7 setlightintensity(0);
  for(;;) {
    if(var_8) {
      var_9 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_9 != "power_off") {
      for(var_0D = 0; var_0D < 3; var_0D++) {
        var_7 setlightintensity(100);
        wait(randomfloatrange(0.5, 1));
        var_7 setlightintensity(0);
        wait(randomfloatrange(0.5, 1));
      }

      var_7 setlightintensity(100);
      self.powered_on = 1;
      level thread func_E5D6();
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
    } else {
      var_7 setlightintensity(0);
      self.powered_on = 0;
    }

    if(!var_8) {
      break;
    }
  }
}

use_rocket_trap(var_0, var_1) {
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  var_2 = sortbydistance(scripts\engine\utility::getstructarray("fm_start_struct", "targetname"), var_1.origin);
  level.rockettrapuses++;
  level.rocket_trap_kills = 0;
  level.fmtraptrigger = var_2[0];
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  if(!isDefined(level.var_E5D5)) {
    level.var_E5D5 = spawn("trigger_radius", var_0.var_4CDF.origin, 0, var_0.var_4CDF.fgetarg, 128);
    level.var_E5D8 = spawn("script_origin", var_0.sysprint.origin);
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  var_0.trap_kills = 0;
  var_0.var_126A5 = var_1;
  func_E5D3();
  level notify("rocket_idle_stop");
  scripts\engine\utility::exploder(56);
  level thread func_E5D4(level.var_E5D5, var_1, var_0);
  if(scripts\engine\utility::flag("mini_ufo_blue_ready")) {
    level thread func_13622();
  }

  level.var_E5D8 playSound("trap_rocket_start");
  wait(1.95);
  scripts\engine\utility::exploder(57);
  earthquake(0.3, 25, var_0.sysprint.origin, 850);
  scripts\engine\utility::waitframe();
  level.var_E5D8 playLoopSound("trap_rocket_lp");
  wait(21);
  level.var_E5D8 stoploopsound("trap_rocket_lp");
  level.var_E5D8 playSound("trap_rocket_stop");
  wait(0.75);
  level.var_E5D8 stoploopsound("trap_rocket_lp");
  level notify("rocket_trap_done");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_1.tickets_earned = var_0.trap_kills * 2;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.rockettrapuses * 45, 45));
  level thread func_E5D6();
}

func_E5D3() {
  earthquake(0.12, 4, level.var_E5D5.origin, 1000);
  playsoundatpos(level.var_E5D5.origin, "trap_rocket_alarm");
  wait(1);
  playsoundatpos(level.var_E5D5.origin, "trap_rocket_alarm");
  wait(1);
}

func_E5D4(var_0, var_1, var_2) {
  level endon("rocket_trap_done");
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(isplayer(var_3) && isalive(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3) && !isDefined(var_3.padding_damage)) {
      var_3.padding_damage = 1;
      var_3 dodamage(35, var_3.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_rockettrap_zm");
      playfxontagforclients(level._effect["player_scr_fire"], var_3, "tag_eye", var_3);
      var_3 thread remove_padding_damage();
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_3, undefined, 1)) {
      if(scripts\engine\utility::istrue(var_3.is_burning)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_3.is_suicide_bomber)) {
        var_3.is_burning = 1;
        level notify("rocket_trap_kill");
        var_2.trap_kills++;
        var_3 dodamage(var_3.health + 1000, var_3.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_rockettrap_zm");
        continue;
      }

      var_4 = ["kill_trap_generic", "kill_trap_rocket"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_4), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
      var_3.marked_for_death = 1;
      var_3.trap_killed_by = var_1;
      if(isDefined(var_1)) {
        if(!isDefined(var_1.trapkills["trap_rocket"])) {
          var_1.trapkills["trap_rocket"] = 1;
        } else {
          var_1.trapkills["trap_rocket"]++;
        }

        var_2.trap_kills++;
        var_3 thread scripts\cp\utility::damage_over_time(var_3, var_1, 1.5, int(var_3.health + 100), "MOD_UNKNOWN", "iw7_rockettrap_zm", 1, "burning", "rocket_trap_kill");
      } else {
        var_3 thread scripts\cp\utility::damage_over_time(var_3, undefined, 1.5, int(var_3.health + 100), "MOD_UNKNOWN", "iw7_rockettrap_zm", 1, "burning", "rocket_trap_kill");
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