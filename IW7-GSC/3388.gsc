/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3388.gsc
************************/

init_scrambler() {
  level.scrambletrapuses = 0;
  var_00 = undefined;
  var_01 = undefined;
  var_02 = scripts\engine\utility::getstructarray("scrambler", "script_noteworthy");
  foreach(var_04 in var_02) {
    var_04 thread func_EC9E();
    var_04.rockets = [];
    var_05 = getEntArray(var_04.target, "targetname");
    foreach(var_07 in var_05) {
      if(var_07.script_noteworthy == "scrambler_center") {
        var_04.body = var_07;
        continue;
      }

      if(var_07.script_noteworthy == "scrambler_trig") {
        var_04.var_1270F = var_07;
        continue;
      }

      if(var_07.script_noteworthy == "scrambler_cars") {
        var_04.rockets[var_04.rockets.size] = var_07;
        continue;
      }

      if(var_07.script_noteworthy == "scrambler_clip") {
        var_04.clip = var_07;
      }
    }
  }

  var_02[0].var_1270F enablelinkto();
  var_02[0].var_1270F linkto(var_02[0].body);
  foreach(var_0B in var_02[0].rockets) {
    var_0B linkto(var_02[0].body);
  }

  var_02[0].clip disconnectpaths();
}

func_EC9E() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_01 = undefined;
  for(;;) {
    var_02 = "power_on";
    if(var_00) {
      var_02 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_02 != "power_off") {
      self.powered_on = 1;
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
      var_03 = getent("escape_velocity_main_ride", "targetname");
      var_03 setscriptablepartstate("model", "on");
      var_03 setscriptablepartstate("fx", "idle");
      scripts\engine\utility::waitframe();
      self.body setModel("zmb_escape_velocity_ride_center_activated");
      scripts\engine\utility::waitframe();
      foreach(var_05 in self.rockets) {
        var_05 setModel("zmb_escape_velocity_ride_car");
        scripts\engine\utility::waitframe();
      }

      scripts\engine\utility::waitframe();
      var_07 = getent("escape_velocity_top_lights", "targetname");
      var_07 setscriptablepartstate("model", "on");
    } else {
      self.powered_on = 0;
    }

    wait(0.25);
  }
}

use_scrambler(param_00, param_01) {
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  level.scrambletrapuses++;
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  param_00.clip connectpaths();
  scripts\engine\utility::waitframe();
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  param_00.trap_kills = 0;
  param_00.var_126A5 = param_01;
  var_02 = getent("escape_velocity_main_ride", "targetname");
  var_02 setscriptablepartstate("fx", "active");
  var_02 setscriptablepartstate("model", "active");
  param_00.body setModel("zmb_escape_velocity_ride_center_on");
  param_00.body rotateyaw(3240, 25, 5, 5);
  param_00 thread kill_zombies(param_00, param_01);
  param_00 thread func_6734();
  var_03 = 25;
  var_04 = gettime();
  var_05 = var_04 + var_03 * 1000;
  while(gettime() < var_05) {
    wait(1);
  }

  var_02 setscriptablepartstate("fx", "idle");
  param_00.body setModel("zmb_escape_velocity_ride_center_activated");
  var_02 setscriptablepartstate("model", "on");
  param_00 notify("stop_dmg");
  if(param_01 scripts\cp\utility::is_valid_player(1)) {
    param_01.tickets_earned = param_00.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  scripts\engine\utility::waitframe();
  param_00.clip disconnectpaths();
  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.scrambletrapuses * 45, 45));
}

kill_zombies(param_00, param_01) {
  self endon("stop_dmg");
  var_02 = param_00.var_1270F;
  for(;;) {
    var_02 waittill("trigger", var_03);
    if(!isplayer(var_03) && !scripts\cp\utility::should_be_affected_by_trap(var_03, undefined, 1) && isDefined(var_03.agent_type) && var_03.agent_type != "zombie_brute") {
      continue;
    }

    if(!isDefined(var_03.agent_type) && !isplayer(var_03)) {
      continue;
    }

    if(isplayer(var_03)) {
      var_03 dodamage(25, self.body.origin);
      var_03 setvelocity(vectornormalize(var_03.origin - self.body.origin) * 500);
      continue;
    }

    if(var_03.agent_type == "zombie_brute" || var_03.team == "allies") {
      if(var_03.agent_type == "zombie_brute") {
        var_03 notify("no_path_to_targets");
      } else {
        var_03 setvelocity(vectornormalize(var_03.origin - self.body.origin) * 500);
      }

      continue;
    }

    if(isDefined(var_03.flung)) {
      continue;
    }

    var_04 = self.body;
    var_03.flung = 1;
    param_00.trap_kills = param_00.trap_kills + 2;
    if(isDefined(param_01)) {
      if(!isDefined(param_01.trapkills["trap_spin"])) {
        param_01.trapkills["trap_spin"] = 1;
      } else {
        param_01.trapkills["trap_spin"]++;
      }

      var_05 = ["kill_trap_generic", "kill_trap_spin"];
      param_01 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_05), "zmb_comment_vo", "highest", 10, 0, 0, 1, 10);
    }

    if(scripts\engine\utility::istrue(var_03.is_suicide_bomber)) {
      if(!isDefined(level.spinner_trap_kills)) {
        level.spinner_trap_kills = 0;
      }

      level.spinner_trap_kills++;
      var_03 dodamage(var_03.health + 1000, var_04.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_escapevelocity_zm");
      var_03 thread fling_zombie(var_04, param_01);
    } else {
      var_03 dodamage(var_03.health + 1000, var_04.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_escapevelocity_zm");
      var_03 thread fling_zombie(var_04, undefined);
    }
  }
}

fling_zombie(param_00, param_01) {
  self endon("death");
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait(0.05);
  self setvelocity(vectornormalize(self.origin - param_00.origin) * 200 + (0, 0, 300));
  wait(0.1);
  if(!isDefined(level.spinner_trap_kills)) {
    level.spinner_trap_kills = 0;
  }

  level.spinner_trap_kills++;
  self dodamage(self.health + 1000, param_00.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_escapevelocity_zm");
}

func_6734() {
  self endon("stop_dmg");
  var_00 = scripts\engine\utility::getstructarray("escape_velocity_attractors", "targetname");
  var_01 = getent("escape_velocity_volume", "targetname");
  for(;;) {
    var_02 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_02 = scripts\engine\utility::get_array_of_closest(self.body.origin, var_02);
    foreach(var_04 in var_02) {
      if(var_04 istouching(var_01)) {
        if(!scripts\cp\utility::should_be_affected_by_trap(var_04) || var_04.scripted_mode) {
          continue;
        }

        var_04 thread _meth_8404(var_00, self);
        var_04 thread func_DF46(self);
        scripts\engine\utility::waitframe();
      }
    }

    wait(0.1);
  }
}

_meth_8404(param_00, param_01) {
  param_01 endon("stop_dmg");
  self endon("death");
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 32;
  self give_mp_super_weapon(scripts\engine\utility::getclosest(self.origin, param_00).origin);
  scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  self.scripted_mode = 0;
}

func_DF46(param_00) {
  self endon("death");
  param_00 waittill("stop_dmg");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.scripted_mode = 0;
}