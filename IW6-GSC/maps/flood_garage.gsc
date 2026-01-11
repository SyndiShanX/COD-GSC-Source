/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_garage.gsc
*****************************************************/

section_

section_

section_flag_inits() {
  common_scripts\utility::flag_init("garage_ally_0_door_ready");
  common_scripts\utility::flag_init("garage_ally_1_door_ready");
  common_scripts\utility::flag_init("garage_ally_2_door_ready");
  common_scripts\utility::flag_init("garage_done");
}

garage_start() {
  maps\flood_util::player_move_to_checkpoint_start("garage_start");
  maps\flood_util::spawn_allies();
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
  thread float_cars();
  level.allies[0] thread ally_garage_sneak("r", "garage_ally0_cover_crouch", "r_end_node");
  level.allies[1] maps\_utility::delaythread(2, ::ally_garage_sneak, "y", "garage_ally1_cover_crouch", "y_end_node");
  level.allies[2] thread ally_garage_sneak("g", "garage_ally2_cover_crouch", "g_end_node");
}

garage() {
  level thread maps\_utility::autosave_by_name("garage");
  level thread maps\flood_util::flood_battlechatter_on();
  level.disable_destructible_bad_places = 1;
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
  thread maps\flood_fx::fx_parking_garage_ambient();
  thread maps\flood_coverwater::register_coverwater_area("coverwater_garage", "garage");
  level.cw_player_in_rising_water = 0;

  if(maps\_utility::getdifficulty() == "fu") {
    level.cw_player_allowed_underwater_time = 10;
  } else {
    level.cw_player_allowed_underwater_time = 15;
  }

  var_0 = getEntArray("garage_wave1_ai", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::enemy_garage);
  maps\_utility::array_spawn(var_0);
  var_0 = getEntArray("garage_wave1above_ai", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::enemy_garage);
  maps\_utility::array_spawn(var_0);
  thread garage_teleport_allies_off_debrisbridge();
  thread garage_wave2_trig();
  thread garage_wave3_trig();
  thread garage_wave4_trig();
  thread garage_ally_move476_jumpers();
  thread garage_ally_move476();
  thread garage_ally_move477();
  thread garage_ally_move478();
  thread garage_ally_move479();
  thread garage_ally_move480();
  thread track_ai();
  level thread maps\flood_ending::ending_transition();
  common_scripts\utility::flag_wait("garage_done");
  maps\flood_util::jkuprint("garage done");
}

block_for_trigger_release(var_0) {
  var_0 endon("death");

  while(level.player istouching(var_0)) {
    common_scripts\utility::waitframe();
  }
}

ally_garage(var_0) {
  maps\_utility::set_force_color(var_0);
  maps\_utility::enable_cqbwalk();
}

ally_garage_sneak(var_0, var_1, var_2) {
  self endon("death");
  maps\flood_util::jkuprint(self.animname + " in garage scripts!");

  if(isDefined(var_1)) {
    block_ally_sneak_to_node(var_1);
  }

  maps\_utility::set_force_color(var_0);
  maps\_utility::enable_cqbwalk();
  var_3 = getnode(var_2, "targetname");

  while(distance2d(self.origin, var_3.origin) > 12) {
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("garage_" + self.animname + "_door_ready");
}

block_ally_sneak_to_node(var_0) {
  var_1 = self.moveplaybackrate;
  var_2 = self.movetransitionrate;
  var_3 = self.animplaybackrate;
  var_4 = randomfloatrange(0.75, 0.85);
  self.moveplaybackrate = var_4;
  self.movetransitionrate = var_4 * 0.7;
  self.animplaybackrate = var_4;
  self allowedstances("crouch");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.ignoresuppression = 1;
  maps\_utility::disable_ai_color();
  var_5 = self.goalradius;
  self.goalradius = 1;
  var_0 = getnode(var_0, "targetname");
  self setgoalnode(var_0);
  common_scripts\utility::waitframe();
  common_scripts\utility::waittill_any("goal", "goal_changed");
  self.ignoreall = 0;
  self allowedstances("stand");
  self.goalradius = var_5;
  self.moveplaybackrate = var_1;
  self.movetransitionrate = var_2;
  self.animplaybackrate = var_3;
  wait(randomintrange(10, 15));
  self.ignoreme = 0;
  self.ignoresuppression = 0;
  maps\_utility::enable_ai_color();
}

enemy_garage() {
  self.script_forcespawn = 1;
  maps\_utility::enable_cqbwalk();
}

enemy_garage_jumper(var_0) {
  self endon("death");
  thread enemy_garage();
  self.allowdeath = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;

  if(isDefined(var_0)) {
    var_1 = getent(var_0, "targetname");
    var_1 notsolid();
    var_1 connectpaths();
  }

  self waittill("goal");

  if(isDefined(var_0)) {
    var_1 = getent(var_0, "targetname");
    var_1 solid();
    var_1 disconnectpaths();
  }

  self.allowdeath = 1;
  self.ignoreall = 0;
  self.ignoreme = 0;
}

track_ai() {
  while(maps\_utility::get_ai_group_count("garage_wave1_ai") + maps\_utility::get_ai_group_count("garage_wave1above_ai") > 5) {
    wait 0.05;
  }

  maps\_utility::activate_trigger("garage_wave2_trig", "targetname");
  maps\flood_util::jkuprint("g: 2 via tracker");

  while(maps\_utility::get_ai_group_count("garage_wave1_ai") + maps\_utility::get_ai_group_count("garage_wave1above_ai") + maps\_utility::get_ai_group_count("garage_wave2_ai") + maps\_utility::get_ai_group_count("garage_wave2_ai_jumper") > 8) {
    wait 0.05;
  }

  maps\_utility::activate_trigger("garage_wave3_trig", "targetname");
  maps\flood_util::jkuprint("g: 2above(3) via tracker");

  while(maps\_utility::get_ai_group_count("garage_wave2above_ai") > 2) {
    wait 0.05;
  }

  maps\_utility::activate_trigger("garage_wave4_trig", "targetname");
  maps\flood_util::jkuprint("g: 4 via tracker");
}

garage_wave2_trig() {
  var_0 = getent("garage_wave2_trig", "targetname");
  var_0 waittill("trigger");
  maps\flood_util::jkuprint("g: 2");
  var_1 = getEntArray("garage_wave2_ai", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::enemy_garage);
  maps\_utility::array_spawn(var_1);
  var_1 = getEntArray("garage_wave2_ai_jumper", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::enemy_garage_jumper);
  maps\_utility::array_spawn(var_1);
}

garage_wave3_trig() {
  var_0 = getent("garage_wave3_trig", "targetname");
  var_0 waittill("trigger");
  maps\flood_util::jkuprint("g: 3");
  var_1 = getEntArray("garage_wave2above_ai", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::enemy_garage);

  foreach(var_3 in var_1) {
    var_3 maps\_utility::spawn_ai();
    wait 0.5;
  }
}

garage_wave4_trig() {
  var_0 = getent("garage_wave4_trig", "targetname");
  var_0 waittill("trigger");
  maps\flood_util::jkuprint("g: 4");
  var_1 = getEntArray("garage_wave4_ai", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::enemy_garage);

  foreach(var_3 in var_1) {
    var_3 maps\_utility::spawn_ai();
    wait 0.5;
  }
}

pause_ally_suppression(var_0) {
  level.allies[0].ignoresuppression = 1;
  level.allies[1].ignoresuppression = 1;
  level.allies[2].ignoresuppression = 1;
  wait(var_0);
  maps\flood_util::jkuprint(level.allies[0].node.targetname);
  level.allies[0].ignoresuppression = 0;
  level.allies[1].ignoresuppression = 0;
  level.allies[2].ignoresuppression = 0;
}

garage_ally_move476_jumpers() {
  var_0 = getent("garage_ally_move476", "targetname");
  var_0 waittill("trigger");
  var_1 = getEntArray("garage_wave1_ai_jumper1", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::enemy_garage_jumper, "garage_jumper_clip_hack1");
  maps\_utility::array_spawn(var_1);
  var_1 = getEntArray("garage_wave1_ai_jumper2", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::enemy_garage_jumper, "garage_jumper_clip_hack2");
  maps\_utility::array_spawn(var_1);
}

garage_ally_move476() {
  var_0 = getent("garage_ally_move476", "targetname");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = maps\_utility::get_ai_group_ai("garage_wave1_ai");
    var_2 = maps\_utility::get_ai_group_ai("garage_wave2_ai");
    var_3 = maps\_utility::get_ai_group_ai("garage_wave2_ai_jumper");
    var_4 = maps\_utility::array_merge(var_1, var_2);
    var_4 = maps\_utility::array_merge(var_4, var_3);

    foreach(var_6 in var_4) {
      if(var_6 getgoalvolume().targetname != "garage_wave1_below") {
        thread maps\flood_util::reassign_goal_volume(var_6, "garage_wave1_below");
      }
    }

    block_for_trigger_release(var_0);
  }
}

garage_ally_move477() {
  var_0 = getent("garage_ally_move477", "targetname");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = maps\_utility::get_ai_group_ai("garage_wave1_ai");
    var_2 = maps\_utility::get_ai_group_ai("garage_wave1above_ai");
    var_3 = maps\_utility::get_ai_group_ai("garage_wave2_ai");
    var_4 = maps\_utility::get_ai_group_ai("garage_wave2_ai_jumper");
    var_5 = maps\_utility::array_merge(var_1, var_2);
    var_5 = maps\_utility::array_merge(var_5, var_3);
    var_5 = maps\_utility::array_merge(var_5, var_4);

    foreach(var_7 in var_5) {
      if(var_7 getgoalvolume().targetname != "garage_wave1_below_retreat") {}
    }

    block_for_trigger_release(var_0);
  }
}

garage_ally_move478() {
  var_0 = getent("garage_ally_move478", "targetname");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = maps\_utility::get_ai_group_ai("garage_wave1_ai");
    var_2 = maps\_utility::get_ai_group_ai("garage_wave1above_ai");
    var_3 = maps\_utility::get_ai_group_ai("garage_wave2_ai");
    var_4 = maps\_utility::get_ai_group_ai("garage_wave2_ai_jumper");
    var_5 = maps\_utility::array_merge(var_1, var_2);
    var_5 = maps\_utility::array_merge(var_5, var_3);
    var_5 = maps\_utility::array_merge(var_5, var_4);

    foreach(var_7 in var_5) {
      if(var_7 getgoalvolume().targetname != "garage_wave2_below_retreat") {
        thread maps\flood_util::reassign_goal_volume(var_7, "garage_wave2_below_retreat");
      }
    }

    block_for_trigger_release(var_0);
  }
}

garage_ally_move479() {
  var_0 = getent("garage_ally_move479", "targetname");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = maps\_utility::get_ai_group_ai("garage_wave1_ai");
    var_2 = maps\_utility::get_ai_group_ai("garage_wave1above_ai");
    var_3 = maps\_utility::get_ai_group_ai("garage_wave2_ai");
    var_4 = maps\_utility::get_ai_group_ai("garage_wave2_ai_jumper");
    var_5 = maps\_utility::array_merge(var_1, var_2);
    var_5 = maps\_utility::array_merge(var_5, var_3);
    var_5 = maps\_utility::array_merge(var_5, var_4);

    foreach(var_7 in var_5) {
      if(var_7 getgoalvolume().targetname != "garage_wave2_above") {
        thread maps\flood_util::reassign_goal_volume(var_7, "garage_wave2_above");
      }
    }

    block_for_trigger_release(var_0);
  }
}

garage_ally_move480() {
  common_scripts\utility::flag_wait("ending_gate_open");

  for(;;) {
    var_0 = getaiarray("axis");

    if(var_0.size < 3) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  maps\flood_util::jkuprint("move up");
  var_1 = getEntArray("garage_ally_movement_volumes", "script_noteworthy");
  maps\_utility::array_delete(var_1);
  maps\_utility::activate_trigger("garage_ally_move480", "targetname");
}

float_cars() {
  var_0 = getEntArray("floating_car", "script_linkname");

  foreach(var_2 in var_0) {
    var_2 thread floater_logic("car_bob");
  }

  var_4 = getEntArray("floating_container", "script_noteworthy");

  foreach(var_6 in var_4) {
    var_6 thread floater_logic("bob");
  }
}

floater_logic(var_0) {
  self endon("destroyed");
  wait(randomfloatrange(0, 1.5));

  switch (var_0) {
    case "spin":
      if(isDefined(self.targetname) && self.targetname == "floating_ball") {
        thread check_for_ball_pop();
      }

      for(;;) {
        self moveto(self.origin - (0, 0, 1), 1, 0.2, 0.2);
        self rotateto(self.angles - (0, 0, 25), 2);
        wait 1;
        self moveto(self.origin + (0, 0, 1), 1, 0.2, 0.2);
        self rotateto(self.angles - (0, 0, 25), 2);
        wait 1;
      }
    case "bob":
      for(;;) {
        var_1 = 2;
        var_2 = 1;
        var_3 = 1.25;
        self moveto(self.origin - (0, 0, var_1), var_3, 0.2, 0.2);
        self rotateto(self.angles - (var_2, 0, var_2), var_3, 0.4, 0.4);
        wait(var_3);
        self moveto(self.origin + (0, 0, var_1), var_3, 0.2, 0.2);
        self rotateto(self.angles + (var_2, 0, var_2), var_3, 0.4, 0.4);
        wait(var_3);
      }
    case "car_bob":
      thread maps\_utility::destructible_disable_explosion();

      for(;;) {
        var_1 = randomfloatrange(1.5, 2.5);
        var_2 = randomfloatrange(0.75, 1.75);
        var_3 = 4;

        for(var_4 = 0; var_4 < 2; var_4++) {
          self moveto(self.origin - (0, 0, var_1), var_3, var_3 * 0.4, var_3 * 0.4);
          self rotateto(self.angles - (var_2, 0, var_2), var_3, var_3 * 0.4, var_3 * 0.4);
          wait(var_3);
          self moveto(self.origin + (0, 0, var_1), var_3, var_3 * 0.4, var_3 * 0.4);
          self rotateto(self.angles + (var_2, 0, var_2), var_3, var_3 * 0.4, var_3 * 0.4);
          wait(var_3);
        }
      }
  }
}

car_sink_logic() {
  maps\_utility::ent_flag_init("destroyed");

  if(isDefined(self.script_noteworthy)) {
    var_0 = getent(self.script_noteworthy + "_destroyed", "targetname");
    var_1 = getent(self.script_noteworthy + "_notdestroyed", "targetname");
    var_0 hide();
    var_0 notsolid();
    var_1 hide();
    var_1 notsolid();
    wait 0.05;
    var_1 connectpaths();
  }

  while(common_scripts\utility::isdestructible()) {
    wait 0.05;
  }

  maps\_utility::ent_flag_set("destroyed");
  var_2 = common_scripts\utility::drop_to_ground(self.origin, self.origin[2]);
  self movez(var_2[2] - self.origin[2], 1.5, 0.02, 0.1);
  wait 1.5;

  if(isDefined(self.script_noteworthy)) {
    var_0 = getent(self.script_noteworthy + "_destroyed", "targetname");
    var_1 = getent(self.script_noteworthy + "_notdestroyed", "targetname");
    var_1 show();
    var_1 solid();
    var_1 disconnectpaths();
    var_1 hide();
    var_1 notsolid();
    var_0 connectpaths();
  }
}

check_for_ball_pop() {
  self setCanDamage(1);
  self waittill("damage");
  self notify("popped");
  self delete();
}

door_open() {
  common_scripts\utility::flag_wait("garage_ally_0_door_ready");
  common_scripts\utility::flag_wait_all("garage_ally_0_door_ready", "garage_ally_1_door_ready", "garage_ally_2_door_ready");
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_getready");
  var_0 = getEntArray("garage_door_l", "targetname");
  var_1 = getEntArray("garage_door_r", "targetname");
  var_2 = 0.3;

  foreach(var_4 in var_0) {
    var_4 rotateyaw(130, var_2, 0, 0.2);

    if(var_4.classname == "script_brushmodel") {
      var_4 connectpaths();
    }
  }

  foreach(var_4 in var_1) {
    var_4 rotateyaw(-130, var_2, 0, 0.2);

    if(var_4.classname == "script_brushmodel") {
      var_4 connectpaths();
    }
  }

  wait(var_2);
  common_scripts\utility::flag_set("garage_done");
}

garage_teleport_allies_off_debrisbridge() {
  var_0 = getent("garage_ally_teleport", "targetname");
  var_1 = common_scripts\utility::getstruct("garage_ally0_teleport", "targetname");
  var_2 = common_scripts\utility::getstruct("garage_ally1_teleport", "targetname");
  var_3 = common_scripts\utility::getstruct("garage_ally2_teleport", "targetname");
  var_0 waittill("trigger");

  if(isDefined(level.allies[0].ondebrisbridge) && level.allies[0].ondebrisbridge == 1) {
    maps\flood_util::jkuprint("teleporting ally 0");
    level.allies[0].garage_teleported = 1;
    level.allies[0] stopanimscripted();
    level.allies[0] maps\flood_anim::vignette_actor_aware_everything();
    level.allies[0].ondebrisbridge = 0;
    level.allies[0] forceteleport(var_1.origin, var_1.angles);
    var_4 = getnode("garage_ally0_cover_start", "targetname");
    var_5 = level.allies[0].goalradius;
    level.allies[0].goalradius = 8;
    level.allies[0] setgoalnode(var_4);
    level.allies[0] waittill("goal");
    level.allies[0].goalradius = var_5;
    level.allies[0] thread ally_garage_sneak("r", undefined, "r_end_node");
    var_4 = getnode("garage_ally0_teleport_goal", "targetname");
    level.allies[0] setgoalnode(var_4);
  }

  if(isDefined(level.allies[1].ondebrisbridge) && level.allies[1].ondebrisbridge == 1) {
    maps\flood_util::jkuprint("teleporting ally 1");
    level.allies[1].garage_teleported = 1;
    level.allies[1] stopanimscripted();
    level.allies[1] maps\flood_anim::vignette_actor_aware_everything();
    level.allies[1].ondebrisbridge = 0;
    level.allies[1] forceteleport(var_2.origin, var_2.angles);
    var_4 = getnode("garage_ally1_cover_start", "targetname");
    var_5 = level.allies[1].goalradius;
    level.allies[1].goalradius = 8;
    level.allies[1] setgoalnode(var_4);
    level.allies[1] waittill("goal");
    level.allies[1].goalradius = var_5;
    level.allies[1] thread ally_garage_sneak("y", undefined, "y_end_node");
    var_4 = getnode("garage_ally1_teleport_goal", "targetname");
    level.allies[1] setgoalnode(var_4);
  }

  if(isDefined(level.allies[2].ondebrisbridge) && level.allies[2].ondebrisbridge == 1) {
    maps\flood_util::jkuprint("teleporting ally 2");
    level.allies[2].garage_teleported = 1;
    level.allies[2] stopanimscripted();
    level.allies[2] maps\flood_anim::vignette_actor_aware_everything();
    level.allies[2].ondebrisbridge = 0;
    level.allies[2] forceteleport(var_3.origin, var_3.angles);
    var_4 = getnode("garage_ally2_cover_start", "targetname");
    var_5 = level.allies[2].goalradius;
    level.allies[2].goalradius = 8;
    level.allies[2] setgoalnode(var_4);
    level.allies[2] waittill("goal");
    level.allies[2].goalradius = var_5;
    level.allies[2] thread ally_garage_sneak("g", undefined, "g_end_node");
    var_4 = getnode("garage_ally2_teleport_goal", "targetname");
    level.allies[2] setgoalnode(var_4);
  }
}