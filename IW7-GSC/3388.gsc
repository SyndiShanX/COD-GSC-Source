/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3388.gsc
*********************************************/

init_scrambler() {
  level.scrambletrapuses = 0;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = scripts\engine\utility::getStructArray("scrambler", "script_noteworthy");
  foreach(var_4 in var_2) {
    var_4 thread func_EC9E();
    var_4.rockets = [];
    var_5 = getEntArray(var_4.target, "targetname");
    foreach(var_7 in var_5) {
      if(var_7.script_noteworthy == "scrambler_center") {
        var_4.body = var_7;
        continue;
      }

      if(var_7.script_noteworthy == "scrambler_trig") {
        var_4.var_1270F = var_7;
        continue;
      }

      if(var_7.script_noteworthy == "scrambler_cars") {
        var_4.rockets[var_4.rockets.size] = var_7;
        continue;
      }

      if(var_7.script_noteworthy == "scrambler_clip") {
        var_4.clip = var_7;
      }
    }
  }

  var_2[0].var_1270F enablelinkto();
  var_2[0].var_1270F linkto(var_2[0].body);
  foreach(var_11 in var_2[0].rockets) {
    var_11 linkto(var_2[0].body);
  }

  var_2[0].clip disconnectpaths();
}

func_EC9E() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_1 = undefined;
  for(;;) {
    var_2 = "power_on";
    if(var_0) {
      var_2 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_2 != "power_off") {
      self.powered_on = 1;
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
      var_3 = getent("escape_velocity_main_ride", "targetname");
      var_3 setscriptablepartstate("model", "on");
      var_3 setscriptablepartstate("fx", "idle");
      scripts\engine\utility::waitframe();
      self.body setModel("zmb_escape_velocity_ride_center_activated");
      scripts\engine\utility::waitframe();
      foreach(var_5 in self.rockets) {
        var_5 setModel("zmb_escape_velocity_ride_car");
        scripts\engine\utility::waitframe();
      }

      scripts\engine\utility::waitframe();
      var_7 = getent("escape_velocity_top_lights", "targetname");
      var_7 setscriptablepartstate("model", "on");
    } else {
      self.powered_on = 0;
    }

    wait(0.25);
  }
}

use_scrambler(var_0, var_1) {
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  level.scrambletrapuses++;
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_0.clip connectpaths();
  scripts\engine\utility::waitframe();
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_0.trap_kills = 0;
  var_0.var_126A5 = var_1;
  var_2 = getent("escape_velocity_main_ride", "targetname");
  var_2 setscriptablepartstate("fx", "active");
  var_2 setscriptablepartstate("model", "active");
  var_0.body setModel("zmb_escape_velocity_ride_center_on");
  var_0.body rotateyaw(3240, 25, 5, 5);
  var_0 thread kill_zombies(var_0, var_1);
  var_0 thread func_6734();
  var_3 = 25;
  var_4 = gettime();
  var_5 = var_4 + var_3 * 1000;
  while(gettime() < var_5) {
    wait(1);
  }

  var_2 setscriptablepartstate("fx", "idle");
  var_0.body setModel("zmb_escape_velocity_ride_center_activated");
  var_2 setscriptablepartstate("model", "on");
  var_0 notify("stop_dmg");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_1.tickets_earned = var_0.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  scripts\engine\utility::waitframe();
  var_0.clip disconnectpaths();
  wait(3);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.scrambletrapuses * 45, 45));
}

kill_zombies(var_0, var_1) {
  self endon("stop_dmg");
  var_2 = var_0.var_1270F;
  for(;;) {
    var_2 waittill("trigger", var_3);
    if(!isPlayer(var_3) && !scripts\cp\utility::should_be_affected_by_trap(var_3, undefined, 1) && isDefined(var_3.agent_type) && var_3.agent_type != "zombie_brute") {
      continue;
    }

    if(!isDefined(var_3.agent_type) && !isPlayer(var_3)) {
      continue;
    }

    if(isPlayer(var_3)) {
      var_3 dodamage(25, self.body.origin);
      var_3 setvelocity(vectornormalize(var_3.origin - self.body.origin) * 500);
      continue;
    }

    if(var_3.agent_type == "zombie_brute" || var_3.team == "allies") {
      if(var_3.agent_type == "zombie_brute") {
        var_3 notify("no_path_to_targets");
      } else {
        var_3 setvelocity(vectornormalize(var_3.origin - self.body.origin) * 500);
      }

      continue;
    }

    if(isDefined(var_3.flung)) {
      continue;
    }

    var_4 = self.body;
    var_3.flung = 1;
    var_0.trap_kills = var_0.trap_kills + 2;
    if(isDefined(var_1)) {
      if(!isDefined(var_1.trapkills["trap_spin"])) {
        var_1.trapkills["trap_spin"] = 1;
      } else {
        var_1.trapkills["trap_spin"]++;
      }

      var_5 = ["kill_trap_generic", "kill_trap_spin"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo", "highest", 10, 0, 0, 1, 10);
    }

    if(scripts\engine\utility::istrue(var_3.is_suicide_bomber)) {
      if(!isDefined(level.spinner_trap_kills)) {
        level.spinner_trap_kills = 0;
      }

      level.spinner_trap_kills++;
      var_3 dodamage(var_3.health + 1000, var_4.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_escapevelocity_zm");
      var_3 thread fling_zombie(var_4, var_1);
    } else {
      var_3 dodamage(var_3.health + 1000, var_4.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_escapevelocity_zm");
      var_3 thread fling_zombie(var_4, undefined);
    }
  }
}

fling_zombie(var_0, var_1) {
  self endon("death");
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait(0.05);
  self setvelocity(vectornormalize(self.origin - var_0.origin) * 200 + (0, 0, 300));
  wait(0.1);
  if(!isDefined(level.spinner_trap_kills)) {
    level.spinner_trap_kills = 0;
  }

  level.spinner_trap_kills++;
  self dodamage(self.health + 1000, var_0.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_escapevelocity_zm");
}

func_6734() {
  self endon("stop_dmg");
  var_0 = scripts\engine\utility::getStructArray("escape_velocity_attractors", "targetname");
  var_1 = getent("escape_velocity_volume", "targetname");
  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_2 = scripts\engine\utility::get_array_of_closest(self.body.origin, var_2);
    foreach(var_4 in var_2) {
      if(var_4 istouching(var_1)) {
        if(!scripts\cp\utility::should_be_affected_by_trap(var_4) || var_4.scripted_mode) {
          continue;
        }

        var_4 thread func_8404(var_0, self);
        var_4 thread func_DF46(self);
        scripts\engine\utility::waitframe();
      }
    }

    wait(0.1);
  }
}

func_8404(var_0, var_1) {
  var_1 endon("stop_dmg");
  self endon("death");
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 32;
  self give_mp_super_weapon(scripts\engine\utility::getclosest(self.origin, var_0).origin);
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  self.scripted_mode = 0;
}

func_DF46(var_0) {
  self endon("death");
  var_0 waittill("stop_dmg");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.scripted_mode = 0;
}