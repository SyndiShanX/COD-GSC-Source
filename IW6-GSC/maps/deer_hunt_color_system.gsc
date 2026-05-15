/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_color_system.gsc
*******************************************/

init_enemy_color_volumes() {
  level.current_enemy_vol = undefined;
  level.current_color_line = 0;
  level.time_before_checking_enemy_count = 10;
  level.enemy_count_when_clear = 1;
  level.color_volume_enemies = [];
  level.color_trig_targetname_prefix = "color_line_";
  level thread debug_color_system_hud();
  var_0 = getEntArray("color_trig", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::color_trig_moves_enemies);
}

color_trig_moves_enemies() {
  level endon("stop_custom_color_system");
  maps\_utility::ent_flag_init("script_activated");
  maps\_utility::ent_flag_init("player_activated");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.player) {
      if(!maps\_utility::ent_flag("player_activated")) {
        if(isDefined(self.targetname)) {
          var_1 = "player in color trig " + self.targetname;
        } else {
          var_1 = "Player in color trig with no targetname at: " + self.origin;
        }

        color_debug_println(var_1);

        if(!maps\_utility::ent_flag("script_activated")) {
          maps\_utility::ent_flag_set("player_activated");
          level.current_color_line++;
          update_debug_hud(level.hud2, level.current_color_line);
          color_debug_println("Player hit color trig.");
        }
      }
    }

    if(isDefined(self.target)) {
      if(!isDefined(level.current_enemy_vol)) {
        set_new_enemy_volume(self);

        if(!maps\_utility::ent_flag("player_activated")) {
          maps\_utility::ent_flag_set("script_activated");
          update_debug_hud(level.hud2, level.current_color_line);
        }
      }

      if(isDefined(level.current_enemy_vol.targetname) && level.current_enemy_vol.targetname != self.target) {
        set_new_enemy_volume(self);

        if(!maps\_utility::ent_flag("player_activated")) {
          maps\_utility::ent_flag_set("script_activated");
          update_debug_hud(level.hud2, level.current_color_line);
          color_debug_println("Script activated color trig.");
        }
      }
    }

    thread temp_trigger_off();
    wait 1;
  }
}

set_new_enemy_volume(var_0) {
  level endon("stop_custom_color_system");
  level notify("new_volume");
  level.current_enemy_vol = getent(var_0.target, "targetname");
  update_debug_hud(level.hud1, level.current_enemy_vol.targetname);
  level thread notify_baddies_to_retreat();
  level.current_enemy_vol thread enemy_volume_logic();
}

temp_trigger_off() {
  if(isDefined(self.targetname)) {
    var_0 = "Turning off trig " + self.targetname;
  } else {
    var_0 = "Turning off trig with no target name at: " + self.origin;
  }

  color_debug_println(var_0);
  common_scripts\utility::trigger_off();
  wait 30;

  if(isDefined(self.targetname)) {
    var_0 = "Restoring trig " + self.targetname;
  } else {
    var_0 = "Restoring trig with no target name at: " + self.origin;
  }

  color_debug_println(var_0);
  common_scripts\utility::trigger_on();
}

notify_baddies_to_retreat() {
  level endon("new_volume");
  var_0 = maps\_utility::array_removedead_or_dying(level.color_volume_enemies);

  if(var_0.size == 0) {
    return;
  }
  var_0 = common_scripts\utility::array_randomize(var_0);
  var_1 = 1;
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(isalive(var_4)) {
      wait(var_1);

      if(!var_2) {
        if(isDefined(var_4) && !isDefined(var_4.a.doinglongdeath) && isalive(var_4)) {
          var_4 thread first_guy_leap_frog_logic();
          var_2 = 1;
          continue;
        }
      }

      var_4 notify("go_to_new_volume");
    }
  }
}

first_guy_leap_frog_logic() {
  self endon("death");
  self notify("go_to_new_volume");
  wait 0.5;
  self.ignoreme = 1;
  self endon("go_to_new_volume");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self.node)) {
    var_0 = distance(self.origin, self.node.origin) * 0.5;
    var_1 = self.node.origin;
  } else if(isDefined(self.goalpos)) {
    var_0 = distance(self.origin, self.goalpos) * 0.5;
    var_1 = self.goalpos;
  }

  while(distance(self.origin, var_1) > var_0) {
    wait 0.5;
  }

  self cleargoalvolume();
  self.goalradius = 200;
  self.old_fightdist = self.pathenemyfightdist;
  self.pathenemyfightdist = 8;
  self setgoalpos(self.origin);
  self allowedstances("crouch", "prone");
  wait(randomintrange(8, 14));
  self.pathenemyfightdist = self.old_fightdist;
  self.ignoreme = 0;
  self notify("stop_print3d_on_ent");
  self allowedstances("stand", "crouch", "prone");
  self setgoalvolumeauto(level.current_enemy_vol);
}

enemy_color_volume_logic() {
  self endon("death");
  level.color_volume_enemies = common_scripts\utility::add_to_array(level.color_volume_enemies, self);
  self.goalradius = 32;

  if(isDefined(level.current_enemy_vol)) {
    self setgoalvolumeauto(level.current_enemy_vol);
  }

  for(;;) {
    self waittill("go_to_new_volume");
    self allowedstances("stand", "crouch", "prone");
    self setgoalvolumeauto(level.current_enemy_vol);
  }
}

enemy_volume_logic() {
  level endon("stop_custom_color_system");
  level endon("new_volume");
  wait_for_at_least_one_enemy_to_spawn();
  var_0 = "Waiting " + level.time_before_checking_enemy_count + " secs before monitoring volume for baddies";
  color_debug_println(var_0);
  wait(level.time_before_checking_enemy_count);
  var_1 = maps\_utility::get_ai_touching_volume("axis");
  var_0 = var_1.size + " baddies in volume";
  color_debug_println(var_0);
  color_debug_println("Monitoring Enemy count.");

  while(var_1.size > level.enemy_count_when_clear) {
    wait 1;
    var_1 = maps\_utility::get_ai_touching_volume("axis");
    var_0 = var_1.size + " baddies in volume";
    color_debug_println(var_0);
  }

  level.current_color_line++;
  color_debug_println("One guy left, moving up friendlies");

  if(!isDefined(getent(level.color_trig_targetname_prefix + level.current_color_line, "targetname"))) {
    var_0 = "NO COLOR TRIG TO ACTIVATE ( " + level.color_trig_targetname_prefix + level.current_color_line + " )";
    color_debug_println(var_0);
    return;
  }

  maps\_utility::activate_trigger(level.color_trig_targetname_prefix + level.current_color_line, "targetname", level);
  update_debug_hud(level.hud2, level.current_color_line);
}

wait_for_at_least_one_enemy_to_spawn() {
  level endon("stop_custom_color_system");
  level endon("new_volume");
  thread color_debug_println("Waiting for at least one enmey to spawn");

  for(;;) {
    var_0 = getaiarray("axis");
    wait 0.25;
    var_1 = getaiarray("axis");

    if(var_1.size > var_0.size) {
      thread color_debug_println("Am enemy spawned.");
      return;
    }
  }
}

debug_color_system_hud() {}

color_debug_println(var_0) {}

check_debug_hud_dvar() {}

create_color_debug_hud() {}

update_debug_hud(var_0, var_1) {}

destroy_color_debug_hud() {}