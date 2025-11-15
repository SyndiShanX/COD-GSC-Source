/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_util.gsc
*****************************************************/

heroes_move(var_0) {
  level notify("hero_move");
  level endon("hero_move");
  thread move_to_goal(var_0);
}

move_to_goal(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "targetname";

  if(!isDefined(var_2))
    var_2 = "node";

  var_3 = undefined;
  var_4 = undefined;

  switch (var_2) {
    case "node":
      var_3 = getnodearray(var_0, var_1);
      var_4 = maps\_utility::set_goal_node;
      break;
    case "struct":
      var_3 = common_scripts\utility::getstructarray(var_0, var_1);
      var_4 = ::set_goal_pos_think;
      break;
    case "ent":
      var_3 = getEntArray(var_0, var_1);
      var_4 = maps\_utility::set_goal_ent;
      break;
  }

  var_5 = [];

  if(!isarray(self))
    var_5[0] = self;
  else
    var_5 = self;

  foreach(var_7 in var_5) {
    var_8 = undefined;

    foreach(var_10 in var_3) {
      if(var_10.script_noteworthy == var_7.script_noteworthy) {
        var_8 = var_10;
        break;
      }
    }

    var_7 thread move_to_goal_think(var_4, var_8);
  }
}

move_to_goal_think(var_0, var_1) {
  self notify("new_move_path");
  self endon("new_move_path");
  self endon("death");

  while(isDefined(var_1)) {
    var_1 maps\_utility::script_delay();

    if(self.type == "dog")
      dog_attackradius_check(var_1);

    self childthread[[var_0]](var_1);

    if(isDefined(var_1.radius) && var_1.radius != 0)
      self.goalradius = var_1.radius;

    if(self.goalradius < 16)
      self.goalradius = 16;

    if(isDefined(var_1.height) && var_1.height != 0)
      self.goalheight = var_1.height;

    var_2 = self.goalradius;

    for(;;) {
      self waittill("goal");

      if(distance(var_1.origin, self.origin) < var_2 + 10) {
        break;
      }
    }

    if(!isDefined(var_1.target)) {
      break;
    }

    var_1 = var_1 common_scripts\utility::get_target_ent();
  }
}

set_goal_pos_think(var_0) {
  childthread maps\_utility::set_goal_pos(var_0.origin);
}

dog_attackradius_check(var_0) {
  if(isDefined(var_0.script_parameters)) {
    var_1 = strtok(var_0.script_parameters, " ");

    foreach(var_3 in var_1) {
      if(var_3 == "attack_radius") {
        self.dogattackradius = var_0.radius;
        self setdogattackradius(var_0.radius);
      }
    }
  }
}

move_up_when_clear() {
  var_0 = common_scripts\utility::get_target_ent();
  var_1 = var_0 common_scripts\utility::get_target_ent();
  var_1 endon("trigger");
  self waittill("trigger");
  volume_waittill_no_axis(var_0.targetname, var_0.script_count, var_1);
  var_1 thread maps\_utility::activate_trigger();

  if(var_1 parameters_check("move_up_delete"))
    var_1 delete();
}

volume_waittill_no_axis(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::get_target_ent(var_0);

  for(;;) {
    if(volume_is_empty(var_3, var_1)) {
      break;
    }

    wait 0.2;
  }
}

volume_is_empty(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getaiarray("axis");
  var_3 = 0;
  var_4 = 0;

  if(var_0 parameters_check("ignore_dying"))
    var_4 = 1;

  foreach(var_6 in var_2) {
    if(var_6 istouching(var_0)) {
      if(var_4 == 1) {
        if(var_6 maps\_utility::doinglongdeath())
          continue;
      }

      var_3 = var_3 + 1;

      if(var_3 > var_1)
        return 0;
    }
  }

  return 1;
}

function_trigger_switch(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4))
    level endon(var_4);

  if(isstring(var_0))
    var_0 = getent(var_0, "targetname");

  if(isstring(var_1))
    var_1 = getent(var_1, "targetname");

  if(isDefined(var_5)) {
    childthread[[var_2]]();
    var_1 waittill("trigger");
    childthread[[var_3]]();
  }

  for(;;) {
    var_0 waittill("trigger");
    childthread[[var_2]]();
    var_1 waittill("trigger");
    childthread[[var_3]]();
  }
}

set_follow_path_and_animate() {
  if(maps\homecoming_drones::isdrone()) {
    thread maps\homecoming_drones::drone_animate_on_path();
    return;
  }

  var_0 = self.spawner;
  var_1 = var_0 get_linked_struct();
  thread maps\_utility::follow_path_and_animate(var_1, 999999);
  disable_arrivals_and_exits();
}

dog_spawn() {
  var_0 = getent("dog_spawner", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1.name = "Riley";
  var_1.ignoreme = 1;
  var_1.ignoresuppression = 1;
  var_1 setdogattackradius(56);
  var_1 maps\_utility::set_moveplaybackrate(0.8);
  var_1.goalradius = 56;
  var_1.animname = "dog";
  return var_1;
}

alliesteletostartspot(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == "player") {
      level.player teletospot(var_3);
      continue;
    }

    foreach(var_5 in level.heroes) {
      if(var_3.script_noteworthy == var_5.script_noteworthy)
        var_5 teletospot(var_3);
    }
  }
}

teletospot(var_0) {
  if(isplayer(self)) {
    self setorigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else
    self forceteleport(var_0.origin, var_0.angles);
}

spawn_and_reinforce(var_0, var_1, var_2, var_3) {
  level endon(var_2);
  var_4 = getEntArray(var_0, "targetname");

  if(!isDefined(var_3))
    var_5 = maps\_utility::array_spawn(var_4);

  if(!isDefined(var_1)) {
    var_1[0] = 2;
    var_1[1] = 4;
  }

  var_6 = getEntArray(var_0 + "_respawners", "targetname");
  var_7 = var_4.size;

  for(;;) {
    wait(randomfloatrange(var_1[0], var_1[1]));
    var_5 = get_ai_array(var_0);
    var_8 = var_7 - var_5.size;

    for(var_9 = 0; var_9 < var_8; var_9++) {
      var_10 = common_scripts\utility::random(var_6);
      var_11 = var_10 maps\_utility::spawn_ai();
      wait(randomfloatrange(0.4, 0.8));
    }
  }
}

set_random_targets(var_0) {
  self endon("death");
  self endon("stop_random_targets");

  if(isstring(var_0))
    var_0 = getEntArray(var_0, "targetname");

  for(;;) {
    var_1 = common_scripts\utility::random(var_0);
    self setentitytarget(var_1);
    wait(randomintrange(2, 8));
  }
}

waittill_trigger(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level endon("ender");

  if(isstring(var_0))
    var_0 = getent(var_0, "targetname");

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isDefined(var_4)) {
      break;
    }

    if(isDefined(var_1) && var_4 == var_1) {
      if(isarray(var_1)) {
        foreach(var_6 in var_1) {
          if(var_4 == var_6) {
            break;
          }
        }
      } else if(var_4 == var_1) {
        break;
      }
    }

    if(var_4 == level.player) {
      break;
    }
  }

  if(isDefined(var_2))
    self thread[[var_2]]();
}

func_waittill_msg(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 waittill(var_1);

  if(isDefined(var_3))
    var_0 thread[[var_2]](var_3);
  else if(isDefined(var_4))
    var_4 thread[[var_2]](var_3);
  else
    var_0 thread[[var_2]]();
}

notify_trigger(var_0) {
  if(isstring(var_0))
    var_0 = getent(var_0, "targetname");

  var_0 notify("trigger");
}

delete_on_flag(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = self.script_parameters;

  common_scripts\utility::flag_wait(var_0);

  if(isai(self) || isalive(self))
    delete_safe();
  else
    self delete();
}

smoke_trigger() {
  var_0 = maps\_utility::get_linked_structs();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 parameters_check("smoke"))
      var_1[var_1.size] = var_3;
  }

  self waittill("trigger");

  foreach(var_3 in var_1) {
    var_6 = 5;

    if(var_3 parameters_check("infinite"))
      var_6 = undefined;

    if(isDefined(var_3.script_timeout))
      var_6 = var_3.script_timeout;

    var_3 thread playloopingfx("smoke_grenade", 5.5, var_6);
  }
}

smoke_stop_trigger() {
  var_0 = maps\_utility::get_linked_structs();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 parameters_check("smoke"))
      var_1[var_1.size] = var_3;
  }

  self waittill("trigger");
  maps\_utility::array_notify(var_1, "stop_looping_fx");
}

get_target_chain_array(var_0) {
  var_1 = [];

  while(isDefined(var_0)) {
    var_1[var_1.size] = var_0;

    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = maps\_utility::getent_or_struct_or_node(var_0.target, "targetname");
    wait 0.05;
  }

  return var_1;
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(level.player.angles);
  var_4 = anglesToForward(level.player.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_0 = var_5 * var_1;
  var_0 = var_0 + var_6 * var_2;
  return var_0 + (0, var_0[1], 0);
}

playloopingfx(var_0, var_1, var_2, var_3, var_4) {
  self endon("stop_looping_fx");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0.05;

  var_5 = undefined;

  if(isDefined(var_2))
    var_5 = gettime();

  while(isDefined(self)) {
    if(isDefined(var_2)) {
      if(gettime() - var_5 >= var_2) {
        break;
      }
    }

    if(isDefined(var_4) && var_4 == 1) {
      playFXOnTag(common_scripts\utility::getfx(var_0), self, var_3);
      wait(var_1);
      continue;
    }

    var_6 = self.origin;
    var_7 = undefined;

    if(isDefined(var_3)) {
      var_6 = self gettagorigin(var_3);
      var_7 = anglesToForward(self gettagangles(var_3));
    }

    if(isDefined(var_7))
      playFX(common_scripts\utility::getfx(var_0), var_6 + (0, 0, 0), var_7);
    else
      playFX(common_scripts\utility::getfx(var_0), var_6 + (0, 0, 0));

    wait(var_1);
  }
}

postion_dot_check(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = vectornormalize(var_0.origin - var_1.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0)
    return "behind";
  else
    return "infront";
}

noteworthy_check(var_0, var_1) {
  if(!isDefined(self.script_noteworthy))
    return 0;

  if(!isDefined(var_1))
    var_1 = " ";

  var_0 = tolower(var_0);
  var_2 = strtok(self.script_noteworthy, var_1);

  foreach(var_4 in var_2) {
    var_4 = tolower(var_4);

    if(var_4 == var_0)
      return 1;
  }

  return 0;
}

parameters_check(var_0, var_1) {
  if(!isDefined(self.script_parameters))
    return 0;

  if(!isDefined(var_1))
    var_1 = " ";

  var_0 = tolower(var_0);
  var_2 = strtok(self.script_parameters, var_1);

  foreach(var_4 in var_2) {
    var_4 = tolower(var_4);

    if(var_4 == var_0)
      return 1;
  }

  return 0;
}

get_midpoint(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_2 = var_2 + var_0[var_5][0];
    var_3 = var_3 + var_0[var_5][1];

    if(isDefined(var_1))
      var_4 = var_4 + var_0[var_5][2];
  }

  if(isDefined(var_1))
    var_4 = var_4 / var_0.size;

  return (var_2 / var_0.size, var_3 / var_0.size, var_4);
}

calculate_bezier_curve(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0];
  var_5 = var_0[1];
  var_6 = var_0[2];
  var_7 = var_0[0];
  var_8 = var_0[1];
  var_9 = var_0[2];

  if(!isDefined(var_2)) {
    var_10 = [var_0, var_1];
    var_2 = get_midpoint(var_10, 1);
  }

  var_11 = var_2[0];
  var_12 = var_2[1];
  var_13 = var_2[2];
  var_14 = [];

  for(var_15 = 0; var_15 < var_3; var_15++) {
    var_16 = int((1 - var_15) * (1 - var_15) * var_4 + 2 * (1 - var_15) * var_15 * var_11 + var_15 * var_15 * var_7);
    var_17 = int((1 - var_15) * (1 - var_15) * var_5 + 2 * (1 - var_15) * var_15 * var_12 + var_15 * var_15 * var_8);
    var_18 = int((1 - var_15) * (1 - var_15) * var_6 + 2 * (1 - var_15) * var_15 * var_13 + var_15 * var_15 * var_9);
    var_14[var_15] = (var_16, var_17, var_18);
  }

  return var_14;
}

getclosest2d(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 500000;

  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = distance2dsquared(var_5.origin, var_0);

    if(var_6 >= squared(var_2)) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

get_fov_2d(var_0, var_1, var_2) {
  var_3 = vectornormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_4 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_4, var_3);
}

get_fov(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

return_point_in_circle(var_0, var_1, var_2) {
  var_3 = var_1 * randomfloat(1.0);
  var_4 = randomfloat(360.0);
  var_5 = sin(var_4);
  var_6 = cos(var_4);
  var_7 = var_3 * var_6;
  var_8 = var_3 * var_5;
  var_9 = 0;

  if(isDefined(var_2))
    var_9 = randomfloatrange(var_2 * -1, var_2);

  var_7 = var_7 + var_0[0];
  var_8 = var_8 + var_0[1];
  var_9 = var_9 + var_0[2];
  return (var_7, var_8, var_9);
}

kill_over_time(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = randomfloatrange(var_1, var_2);
    var_5 thread kill_over_time_death(var_6, var_3);
  }
}

kill_over_time_death(var_0, var_1) {
  wait(var_0);

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(var_1) && var_1) {
    var_2 = ["j_head", "tag_weapon_chest", "j_SpineUpper", "J_SpineLower"];
    var_3 = common_scripts\utility::random(var_2);
    var_4 = randomintrange(1, 3);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_3 = common_scripts\utility::random(var_2);
      var_6 = "body_impact1";

      if(var_3 == "j_head")
        var_6 = "headshot_blood";

      playFXOnTag(common_scripts\utility::getfx(var_6), self, var_3);
    }
  }

  kill_safe();
}

array_remove_when_dead(var_0, var_1) {
  var_1 waittill("death");
  common_scripts\utility::array_remove(var_0, var_1);
}

self_add_array(var_0) {
  var_0[var_0.size] = self;
  return var_0;
}

isentity(var_0) {
  return isDefined(var_0.classname);
}

get_linked_struct() {
  var_0 = maps\_utility::get_linked_structs();

  if(var_0.size > 1) {} else if(var_0.size < 1) {}

  return var_0[0];
}

get_goalvolume(var_0) {
  return level.goalvolumes[var_0];
}

cinematicmode_on(var_0) {
  level.player disableweapons();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowsprint(0);

  if(isDefined(var_0) && var_0 == 1)
    hud_hide();
}

cinematicmode_off(var_0) {
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player allowsprint(1);

  if(isDefined(var_0) && var_0 == 1)
    hud_show();
}

hud_hide() {
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("compass", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showstance", "0");
}

hud_show() {
  setsaveddvar("g_friendlyNameDist", 15000);
  setsaveddvar("compass", "1");
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showstance", "1");
}

player_heartbeat() {
  level.player endon("stop_player_heartbeat");

  if(!isDefined(level.heartbeatrate))
    level.heartbeatrate = 0.8;

  for(;;) {
    level.player thread maps\_utility::play_sound_on_entity("breathing_heartbeat");
    wait(level.heartbeatrate);
  }
}

player_heartbeat_slowmo() {
  level.player endon("stop_player_heartbeat");

  for(;;) {
    level.player playlocalsound("breathing_heartbeat_homecoming", "sounddone");
    level.player waittill("sounddone");
  }
}

player_hurt(var_0, var_1) {
  level.player endon("stop_player_breathing");
  var_2 = level.player maps\_hud_util::create_client_overlay("dogcam_edge", 0, level.player);
  var_2.sort = 1;
  var_3 = level.player maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_3.sort = -1;
  var_4 = 0.4;
  var_5 = 0.4;
  var_2 fadeovertime(var_4);
  var_2.alpha = 0.6;
  level.player.hurtfade = 1;
  thread player_hurt_cleanup(var_2, var_3, var_5);

  for(;;) {
    level.player.hurtfade = 1;
    var_3 fadeovertime(var_4);
    var_3.alpha = 0.6;

    if(isDefined(var_0))
      level.player thread maps\_utility::set_vision_set("aftermath_hurt", var_4);

    if(!isDefined(var_1))
      level.player common_scripts\utility::play_sound_in_space("breathing_limp_start");

    level.player.hurtfade = 0;
    var_3 fadeovertime(var_5);
    var_3.alpha = 0;

    if(isDefined(var_0))
      level.player thread maps\_utility::set_vision_set("aftermath_walking", var_4);

    wait(randomfloatrange(1, 3));
  }
}

player_hurt_single(var_0) {
  var_1 = level.player maps\_hud_util::create_client_overlay("dogcam_edge", 0, level.player);
  var_1.sort = 1;
  var_2 = level.player maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_2.sort = -1;
  var_3 = 0.4;
  var_4 = 0.4;
  level.player.hurtfade = 1;
  thread player_hurt_cleanup(var_1, var_2, var_4);
  level.player.hurtfade = 1;
  var_1 fadeovertime(var_3);
  var_1.alpha = 1;
  var_2 fadeovertime(var_3);
  var_2.alpha = 0.3;
  level.player common_scripts\utility::play_sound_in_space("breathing_hurt");
  level.player.hurtfade = 0;
  var_1 fadeovertime(var_4);
  var_1.alpha = 0;
  var_2 fadeovertime(var_4);
  var_2.alpha = 0;
}

player_hurt_cleanup(var_0, var_1, var_2) {
  level.player waittill("stop_player_breathing");

  if(level.player.hurtfade == 1) {
    var_0 fadeovertime(var_2);
    var_0.alpha = 0;
    var_1 fadeovertime(var_2);
    var_1.alpha = 0;
  }

  wait(var_2);
  var_0 destroy();
  var_1 destroy();
}

waittill_forever() {}

earthquake_loop(var_0, var_1) {
  level.player endon("stop_earthquake_loop");
  level.player notify("new_earthquake_loop");
  level.player endon("new_earthquake_loop");

  for(;;) {
    if(!isDefined(var_1))
      var_1 = level.player.origin;

    earthquake(var_0, 1, var_1, 5000);
    wait 0.2;
  }
}

screenshake_loop(var_0) {
  level.player endon("stop_earthquake_loop");
  level.player notify("new_earthquake_loop");
  level.player endon("new_earthquake_loop");

  for(;;) {
    screenshake(var_0, 1, level.player.origin, 5000);
    wait 0.2;
  }
}

set_mortar_on(var_0) {
  common_scripts\utility::flag_wait("load_setup_complete");
  var_1 = getEntArray("mortar_on", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_mortargroup)) {
      if(var_3.script_mortargroup == maps\_utility::string(var_0))
        var_3 notify("trigger");
    }
  }
}

fire_fake_javelin(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "javelin_no_explode";

  if(!isDefined(var_1))
    var_1 = common_scripts\utility::getfx("javelin_explosion_cheap");

  var_3 = undefined;

  if(isalive(self)) {
    var_3 = self.javelin gettagorigin("tag_flash");
    playFXOnTag(common_scripts\utility::getfx("javelin_muzzle"), self.javelin, "tag_flash");
  } else
    var_3 = self.origin;

  var_4 = var_0.origin;
  var_5 = magicbullet(var_2, var_3, var_4);
  var_6 = 0;

  if(isentity(var_0))
    var_6 = 1;

  if(var_6) {
    var_0 notify("missile_targeted", var_5);
    var_5 missile_settargetent(var_0);
  } else
    var_5 missile_settargetpos(var_4);

  var_5 missile_setflightmodetop();
  var_5 waittill("death");
  var_7 = var_5.origin;

  if(isDefined(var_7))
    playFX(var_1, var_7);

  if(isDefined(var_5) && isvalidmissile(var_5))
    var_5 delete();
}

#using_animtree("generic_human");

fake_shooter_think() {
  self endon("stop_fake_behavior");
  self endon("death");
  thread fake_shooter_death();
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  self.animspot = var_0;
  var_1 = "coverstand";

  if(parameters_check("crouch"))
    var_1 = "covercrouch";

  var_2 = var_1 + "_hide_idle";
  var_3 = var_1 + "_reload";
  var_4 = var_1 + "_hide_2_aim";
  var_5 = var_1 + "_aim";
  var_6 = var_1 + "_aim_2_hide";
  var_7 = % exposed_aim_2;
  var_8 = 0;

  for(;;) {
    if(!var_8) {
      var_0 thread maps\_anim::anim_generic_loop(self, var_2);
      var_8 = 1;
    }

    wait(randomintrange(1, 3));

    if(common_scripts\utility::cointoss()) {
      var_0 notify("stop_loop");
      self stopanimscripted();
      var_8 = 0;

      if(common_scripts\utility::cointoss())
        var_0 maps\_anim::anim_generic(self, var_3);

      var_0 maps\_anim::anim_generic(self, var_4);
      thread fake_shooter_shoot();
      thread maps\_anim::anim_generic_loop(self, var_5);
      self setanimknobrestart(var_7, 1, 0.2, 1.0);
      wait(randomintrange(4, 8));
      self notify("stop_loop");
      self notify("stop_shooting");
      self stopanimscripted();
      maps\_anim::anim_generic(self, var_6);
    }
  }
}

fake_shooter_shoot() {
  self endon("stop_shooting");
  self endon("death");

  for(;;) {
    wait(randomfloatrange(0.2, 0.6));
    self shootblank();
  }
}

fake_shooter_death() {
  self endon("stop_fake_behavior");
  maps\_utility::set_allowdeath(1);
  self waittill("death");
  self stopanimscripted();
  self.animspot notify("stop_loop");
  self notify("stop_loop");
}

set_ai_array(var_0) {
  if(!isDefined(var_0))
    var_0 = self.script_parameters;

  if(!isDefined(level.aiarray[var_0]))
    level.aiarray[var_0] = [];

  level.aiarray[var_0] = common_scripts\utility::array_add(level.aiarray[var_0], self);
  thread ai_array_remove_on_death(var_0);
}

ai_array_remove_on_death(var_0) {
  self waittill("death");
  level.aiarray[var_0] = common_scripts\utility::array_remove(level.aiarray[var_0], self);
}

get_ai_array(var_0) {
  level.aiarray[var_0] = maps\_utility::array_removedead(level.aiarray[var_0]);
  return level.aiarray[var_0];
}

delete_ai_array(var_0) {
  if(!isDefined(level.aiarray[var_0])) {
    iprintln("Trying to delete undefined aiArray");
    iprintln("This should only happen when on a start point.");
    return;
  }

  var_1 = get_ai_array(var_0);
  common_scripts\utility::array_thread(var_1, ::delete_safe);
}

blackout(var_0, var_1) {
  fadeoverlay(var_0, 1, var_1);
}

grayout(var_0, var_1) {
  fadeoverlay(var_0, 0.6, var_1);
}

restorevision(var_0, var_1) {
  fadeoverlay(var_0, 0, var_1);
}

fadeoverlay(var_0, var_1, var_2) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  setblur(var_2, var_0);
  wait(var_0);
}

ignore_everything() {
  self.ignoreall = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
}

clear_ignore_everything() {
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

move_on_path(var_0, var_1) {
  self endon("stop_path");
  self endon("death");
  disable_arrivals_and_exits();
  var_2 = get_target_chain_array(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_animation)) {
      var_4 maps\_anim::anim_generic_reach(self, var_4.script_animation);
      var_4 maps\_anim::anim_generic(self, var_4.script_animation);
    } else {
      var_5 = undefined;

      if(isDefined(var_4.radius))
        var_5 = var_4.radius;
      else
        var_5 = 56;

      childthread force_goalradius(var_5);
      self setgoalpos(var_4.origin);

      while(distancesquared(var_4.origin, self.origin) > squared(self.goalradius))
        wait 0.1;
    }

    if(isDefined(var_4.script_noteworthy))
      self notify(var_4.script_noteworthy);
  }

  if(isDefined(var_1))
    delete_safe();
}

delete_safe() {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();

  if(isDefined(self.furfx))
    thread maps\_utility_dogs::kill_dog_fur_effect_and_delete();
  else
    self delete();
}

kill_safe() {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();

  self kill();
}

create_dead_guys(var_0, var_1, var_2) {
  if(isDefined(var_1))
    common_scripts\utility::flag_wait(var_1);

  var_3 = getent(var_0 + "_spawner", "targetname");
  var_4 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = var_3 maps\_utility::spawn_ai();
    var_8 maps\_utility::gun_remove();

    if(!isDefined(var_7.angles))
      var_7.angles = (0, 0, 0);

    var_9 = spawn("script_model", var_8.origin);
    var_9.angles = var_8.angles;
    var_9 setModel(var_8.model);
    var_10 = var_8 getattachsize();

    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_12 = var_8 getattachmodelname(var_11);
      var_13 = var_8 getattachtagname(var_11);
      var_9 attach(var_12, var_13, 1);
    }

    var_9 useanimtree(#animtree);
    var_9.animname = "generic";
    var_5 = common_scripts\utility::array_add(var_5, var_9);
    var_8 delete();
    var_14 = var_7.animation;
    var_7 thread maps\_anim::anim_generic_first_frame(var_9, var_14);

    if(var_7 parameters_check("blood_pool"))
      playFX(common_scripts\utility::getfx("blood_pool"), var_9.origin);

    common_scripts\utility::waitframe();
  }

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
    maps\_utility::array_delete(var_5);
  }
}

ambient_runner_think() {
  self endon("death");
  disable_arrivals_and_exits();
  ignore_everything();
  maps\_utility::pathrandompercent_zero();
  self.fixednode = 0;
  self.interval = 0;
  self.pushable = 0;
  self.badplaceawareness = 0;
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");

  while(isDefined(var_0)) {
    var_1 = 56;

    if(isDefined(var_0.radius))
      var_1 = var_0.radius;

    self setgoalpos(var_0.origin);
    waittill_goal(var_1);

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = common_scripts\utility::getstructarray(var_0.target, "targetname");

    if(var_2.size > 1) {
      var_0 = var_2[randomint(var_2.size)];
      continue;
    }

    var_0 = var_2[0];
  }

  self delete();
}

waittill_goal(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0))
    self.goalradius = var_0;

  self waittill("goal");

  if(isDefined(var_1))
    self delete();
}

waittill_real_goal(var_0, var_1) {
  self endon("death");
  self notify("setting_new_goal");
  self endon("setting_new_goal");

  for(;;) {
    self waittill("goal");
    var_2 = self.goalradius;

    if(isDefined(var_0.radius))
      var_2 = var_0.radius;

    if(distance(var_0.origin, self.origin) < var_2 + 10) {
      break;
    }
  }

  if(isDefined(var_1))
    delete_safe();

  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  switch (var_0.script_noteworthy) {
    case "deleteme":
      self delete();
      break;
    case "deleteme_safe":
      delete_safe();
      break;
    case "killme":
      self kill();
      break;
  }
}

force_goalradius(var_0) {
  self notify("force_goal_radius");
  self endon("force_goal_radius");
  self endon("death");

  for(;;) {
    self.goalradius = var_0;
    wait 0.1;
  }
}

waittill_death_respawn(var_0, var_1, var_2) {
  var_0 endon("stop_spawning");
  var_3 = self;

  for(;;) {
    var_3 common_scripts\utility::waittill_any("death", "dying");
    wait(randomfloatrange(var_1, var_2));
    var_3 = var_0 maps\_utility::spawn_ai();
  }
}

waittill_spawners_empty(var_0, var_1) {
  var_2 = spawnStruct();
  common_scripts\utility::array_thread(var_0, ::waittill_spawner_spawns, var_2);

  if(!isDefined(var_1)) {
    foreach(var_4 in var_0)
    var_1 = var_1 + var_4.count;
  }

  while(var_2.deathcounter < var_1)
    wait 0.1;

  iprintlnbold("killed enough");
}

waittill_spawner_spawns(var_0) {
  while(isDefined(self)) {
    if(self.count < 1) {
      break;
    }

    self waittill("spawned", var_1);
    var_0.deathcounter++;
  }
}

waittill_stealth_notify() {
  self endon("death");
  level endon("stealth_event_notify");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  self waittill("ai_event", var_0);
  level notify("stealth_event_notify", self);
}

disable_arrivals_and_exits(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.disablearrivals = var_0;
  self.disableexits = var_0;
}

set_all_ai_targetnames(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  self.targetname = var_0.targetname;
}

enemy_rpg_unlimited_ammo(var_0) {
  if(isDefined(var_0))
    self endon(var_0);

  self endon("death");
  var_1 = 1;

  for(;;) {
    if(isDefined(self.a.rockets))
      self.a.rockets = var_1;

    wait 0.05;
  }
}

goal_radius_constant(var_0) {
  self endon("death");

  for(;;) {
    maps\_utility::set_goal_radius(var_0);
    wait 0.1;
  }
}

vehicle_set_parameters() {
  var_0 = strtok(self.script_parameters, " ");

  foreach(var_2 in var_0) {
    switch (var_2) {
      case "path_notifications":
        thread vehicle_path_notifications();
        break;
      case "allow_player_damage":
        thread vehicle_allow_player_death();
        break;
      case "a10_strafe_vehicle":
        thread maps\homecoming_a10::set_a10_strafe_vehicle();
        break;
      case "a10_strafe_target":
        thread maps\homecoming_a10::set_a10_strafe_target_vehicle();
        break;
    }
  }
}

#using_animtree("vehicles");

vehicle_to_model() {
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel(self.model);
  var_0 useanimtree(#animtree);
  self.fakemodel = var_0;
  self hide();
  maps\_vehicle::move_riders_here(self.fakemodel);
  maps\_vehicle_code::move_turrets_here(self.fakemodel);
  return var_0;
}

model_to_vehicle() {
  self vehicle_teleport(self.fakemodel.origin, self.fakemodel.angles);
  self show();
  maps\_vehicle_code::move_turrets_here(self);

  if(isDefined(self.mgturret) && isDefined(self.riders)) {
    if(isDefined(self.mgturret[1]) && isDefined(self.riders[0])) {
      var_0 = self.riders[0];
      var_0 unlink();
      var_0 linkto(self.mgturret[1], "tag_origin", (0, 0, -25), (0, 0, 0));
    }
  }

  self.fakemodel delete();
  self.fakemodel = undefined;
}

nh90_doors_open() {
  self waittill("unloading");
  self setanim( % nh90_left_door_open);
  self setanim( % nh90_right_door_open);
}

create_default_targetent(var_0) {
  if(!isDefined(var_0))
    var_0 = "tag_flash";

  var_1 = anglesToForward(self gettagangles(var_0));
  var_2 = spawn("script_origin", self gettagorigin(var_0) + var_1 * 50);
  var_2 linkto(self);
  self.defaulttarget = var_2;
}

vehicle_fire_at_targets(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_firing");
  self notify("engaging_new_targets");
  self endon("engaging_new_targets");

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = 1;

  if(isDefined(self.turretturntime))
    var_4 = self.turretturntime;

  var_5 = undefined;

  if(isDefined(self.firerumble))
    var_5 = self.firerumble;

  var_6 = ::vehicle_fire;

  if(isDefined(self.tankfireoverride))
    var_6 = self.tankfireoverride;

  var_7 = undefined;

  for(;;) {
    wait(randomfloatrange(var_2, var_3));
    var_8 = 0;
    var_9 = var_0;

    if(isDefined(var_7))
      var_9 = common_scripts\utility::array_remove(var_0, var_7);

    var_10 = var_9[randomint(var_9.size)];

    if(var_9.size > 1)
      var_7 = var_10;

    self.currentvehicletarget = var_10;
    self setturrettargetvec(var_10.origin);
    wait(var_4);

    for(var_11 = 0; var_8 < var_1; var_11 = 0.2) {
      wait(var_11);

      if(isDefined(var_5))
        self playrumbleonentity(var_5);

      self[[var_6]]();
      var_8++;
    }
  }
}

vehicle_fire_loop(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_firing");

  if(!isDefined(var_1))
    var_1 = 0.5;

  if(!isDefined(var_2))
    var_2 = 1;

  for(;;) {
    wait(randomfloatrange(var_1, var_2));
    vehicle_fire(var_0);
  }
}

vehicle_fire(var_0) {
  if(!isDefined(var_0))
    var_0 = "tag_flash";

  self fireweapon(var_0);
}

vehicle_play_sound(var_0) {
  var_1 = var_0.script_sound;

  if(var_0 parameters_check("inSpace"))
    thread common_scripts\utility::play_sound_in_space(var_1);
  else
    thread maps\_utility::play_sound_on_entity(var_1);
}

attach_path_and_drive(var_0) {
  self attachpath(var_0);
  self startpath(var_0);
  thread maps\_vehicle::vehicle_paths(var_0);
}

vehicle_allow_player_death(var_0, var_1) {
  self endon("death");
  self.bulletcount = 0;
  maps\_vehicle::godon();
  self setCanDamage(1);

  switch (self.classname) {
    case "script_vehicle_t90ms":
      self.fakehealth = 2000;
      break;
    case "script_vehicle_t90ms_trophy":
      self.fakehealth = 2000;
      break;
    case "script_vehicle_t90ms_turret":
      self.fakehealth = 2000;
      break;
    case "script_vehicle_m880_launcher":
      self.fakehealth = 2000;
      break;
    case "script_vehicle_nh90":
      self.fakehealth = 200;
      break;
    case "script_vehicle_nh90_cheap":
      self.fakehealth = 200;
      break;
    case "script_vehicle_hind_battle":
      self.fakehealth = 1000;
      break;
    case "script_vehicle_hind_battle_oilrocks":
      self.fakehealth = 1000;
      break;
    default:
  }

  var_2 = self.fakehealth;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!isplayer(var_4)) {
      continue;
    }
    if(isDefined(self.fakehealthinvulnerability) && self.fakehealthinvulnerability == 1) {
      continue;
    }
    if(isDefined(self.flareprotection) && self.flareprotection == 1) {
      if(var_7 == "MOD_PROJECTILE" || var_7 == "MOD_PROJECTILE_SPLASH")
        continue;
    }

    var_12 = tolower(var_12);

    switch (var_12) {
      case "maaws":
        self.fakehealth = self.fakehealth - 500;
        break;
      case "dshk_turret_homecoming":
        self.fakehealth = self.fakehealth - 10;
        break;
      case "chaingun_turret":
        self.fakehealth = self.fakehealth - 10;
        break;
      case "a10_30mm_player_homecoming":
        self.fakehealth = self.fakehealth - 200;
        break;
    }

    if(isDefined(var_0))
      self childthread[[var_0]](var_2);

    if(self.fakehealth <= 0) {
      if(isDefined(var_1)) {
        self thread[[var_1]](var_12);
        return;
      }

      maps\_vehicle::godoff();
      self.dontallowexplode = undefined;
      self.forceexploding = 1;
      self notify("death", level.player, undefined, var_12);
    }

    if(isDefined(self.beachlander)) {
      if(maps\_utility::ent_flag("unload_interrupted")) {
        continue;
      }
      if(self.fakehealth <= int(var_2 / 2))
        maps\_utility::ent_flag_set("unload_interrupted");
    }
  }
}

javelin_target_set(var_0, var_1) {
  target_set(var_0, var_1);
  target_setjavelinonly(var_0, 1);
  target_setattackmode(var_0, "top");
  var_0 thread javelin_target_death();
}

javelin_target_death() {
  self waittill("death");

  if(isDefined(self) && isalive(self))
    target_remove(self);
}

javelin_check_decent(var_0) {
  var_0 endon("death");
  wait 2;

  for(;;) {
    var_1 = var_0.origin[2];
    wait 0.1;
    var_2 = var_0.origin[2];

    if(var_1 > var_2) {
      break;
    }
  }
}

stinger_target_set() {
  target_set(self, (0, 0, 50));
  target_hidefromplayer(self, level.player);
}

turret_shoot_targets(var_0, var_1) {
  var_2 = self;
  var_2 notify("turret_shoot_targets");
  var_2 endon("turret_shoot_targets");
  var_2 endon("turret_stop_shooting_targets");
  var_2 endon("death");
  var_2 setmode("manual");

  if(var_2 parameters_check("fakefire"))
    var_1 = 1;

  var_3 = ::turret_startfiring;

  if(isDefined(var_1))
    var_3 = ::turret_startfakefiring;

  var_4 = var_0;
  var_5 = undefined;

  for(;;) {
    if(var_0.size > 1) {
      var_5 = common_scripts\utility::random(var_4);
      var_4 = common_scripts\utility::array_remove(var_0, var_5);
    } else
      var_5 = var_4[0];

    var_2 settargetentity(var_5, (0, 0, 0));
    var_2 childthread[[var_3]]();
    wait(randomfloatrange(1.5, 3));
    var_2 thread turret_stopfiring();
    wait(randomfloatrange(0.5, 1.5));
  }
}

turret_startfiring() {
  self endon("stop_firing_turret");
  self endon("death");

  for(;;) {
    self shootturret();
    wait 0.15;
  }
}

turret_startfakefiring(var_0, var_1) {
  self endon("stop_firing_turret");
  self endon("turret_shoot_targets");
  self endon("death");
  var_2 = "mg_tracer";

  if(isDefined(var_0))
    var_2 = var_0;

  if(parameters_check("nosound"))
    var_1 = 1;

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx(var_2), self, "tag_flash");

    if(!isDefined(var_1))
      self playSound("weap_kacsawtur_fire_npc");

    wait 0.15;
  }
}

turret_stopfiring() {
  self notify("stop_firing_turret");
}

default_mg_guy() {
  if(maps\homecoming_drones::isdrone()) {
    maps\homecoming_drones::default_mg_drone();
    return undefined;
  }

  thread maps\_utility::magic_bullet_shield();
  ignore_everything();
  maps\_utility::gun_remove();
  var_0 = getent(self.target, "targetname");
  var_0 thread maps\_anim::anim_generic_first_frame(self, "stand_gunner_idle");
  self linkto(var_0, "trigger", (-16, 10, -55), (0, 0, 0));

  if(!isDefined(var_0.script_linkto)) {
    return;
  }
  var_1 = var_0 common_scripts\utility::get_linked_ents();
  self endon("death");
  var_0 childthread turret_shoot_targets(var_1);
  return var_0;
}

set_mk23_model() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("vehicle_mk23_truck_iw6");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self hide();
  self waittill("death");
  var_0 delete();
}

vehicle_path_notifications() {
  self endon("death");

  for(;;) {
    self waittill("noteworthy", var_0);

    if(maps\_vehicle::ishelicopter()) {
      thread heli_path_notifications(var_0);
      continue;
    }

    var_1 = self.currentnode;

    switch (var_0) {
      case "target_nothing":
        self notify("stop_firing");
        break;
      case "fire_at_targets":
        var_2 = var_1 maps\_utility::get_linked_structs();
        var_3 = undefined;

        if(isDefined(self.script_shotcount))
          var_3 = self.script_shotcount;

        var_4 = undefined;
        var_5 = undefined;

        if(!isDefined(self.firetime))
          vehicle_get_firetime();

        if(isDefined(self.firetime)) {
          var_4 = self.firetime[0];
          var_5 = self.firetime[1];
        }

        thread vehicle_fire_at_targets(var_2, var_3, var_4, var_5);
        break;
      case "strafe_start":
        thread a10_strafe_run(var_1);
        break;
      case "strafe_start_cheap":
        thread a10_strafe_run_cheap(var_1);
        break;
      case "play_sound":
        thread vehicle_play_sound(var_1);
        break;
    }
  }
}

vehicle_get_firetime() {
  var_0 = strtok(self.classname, "_");

  foreach(var_2 in var_0) {
    if(var_2 == "t90ms" || var_2 == "abrams") {
      self.firetime[0] = 2;
      self.firetime[1] = 4;
    }
  }
}

heli_path_notifications(var_0) {
  self endon("death");
  var_1 = self.currentnode;

  if(var_0 == "target_nothing") {
    self notify("stop_firing");
    self clearlookatent();
  } else if(var_0 == "fire_at_targets") {
    var_2 = undefined;

    if(parameters_check("turret_cheap"))
      var_2 = 1;

    var_3 = var_1 common_scripts\utility::get_linked_ents();
    var_4 = [];
    var_4[0] = "tag_missile_left";
    var_4[1] = "tag_missile_right";
    var_5 = -1;
    var_6 = 0;

    foreach(var_8 in var_3) {
      if(isDefined(var_8.script_turret)) {
        continue;
      }
      if(isDefined(var_8.script_index)) {
        var_3 = common_scripts\utility::array_remove(var_3, var_8);
        var_3 = common_scripts\utility::array_insert(var_3, var_8, var_8.script_index);
      }
    }

    foreach(var_8 in var_3) {
      if(isDefined(var_8.script_turret)) {
        var_11 = undefined;

        if(var_8 parameters_check("lookat"))
          var_11 = 1;
        else if(var_8 parameters_check("cheap"))
          var_2 = 1;

        if(self.classname == "script_vehicle_hind_battle_oilrocks")
          thread heli_fire_turret_oilrocks(var_8, var_11, var_2);
        else
          thread heli_fire_turret(var_8, var_11, var_2);

        continue;
      }

      var_12 = undefined;

      if(isDefined(var_8.delay))
        var_12 = var_8.delay;

      var_13 = 1;

      if(isDefined(var_8.script_shotcount))
        var_13 = var_8.script_shotcount;

      var_14 = undefined;

      if(isDefined(var_8.script_noteworthy))
        var_14 = var_8.script_noteworthy;

      var_15 = 0;

      if(isDefined(var_8.script_delay)) {
        var_15 = var_8.script_delay;
        var_6 = var_15 + var_6;
      }

      if(var_8 parameters_check("add_delay"))
        var_15 = var_6;

      if(var_8 parameters_check("left"))
        var_5 = 0;
      else if(var_8 parameters_check("right"))
        var_5 = 1;
      else {
        var_5++;

        if(var_5 >= var_4.size)
          var_5 = 0;
      }

      maps\_utility::delaythread(var_15, ::heli_fire_missiles, var_8, var_13, var_4[var_5], var_12, var_14);
    }
  } else if(var_0 == "play_sound")
    thread vehicle_play_sound(var_1);
}

heli_enable_rocketdeath(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.enablerocketdeath = var_0;
  self.alwaysrocketdeath = var_0;
}

heli_fire_missiles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "missile_attackheli";

  if(isDefined(var_4))
    var_5 = var_4;

  if(!isDefined(var_3))
    var_3 = 1;

  var_6 = "hind_turret_oilrocks";

  if(isDefined(self.defaultweapon))
    var_6 = self.defaultweapon;

  self.firingmissiles = 1;
  var_7 = undefined;

  for(var_8 = 0; var_8 < var_1; var_8++) {
    self setvehweapon(var_5);
    var_7 = self fireweapon(var_2, var_0);

    if(var_5 == "missile_attackheli_no_explode")
      var_7 thread heli_firemissile_noexplode();

    if(var_8 < var_1 - 1)
      wait(var_3);
  }

  self setvehweapon(var_6);
  self.firingmissiles = 0;
  self notify("missile_fired", var_7);
  return var_7;
}

heli_firemissile_noexplode() {
  self waittill("death");

  if(isDefined(self)) {
    thread common_scripts\utility::play_sound_in_space("missile_attackheli_bunker_explosion", self.origin);
    earthquake(0.55, 1, self.origin, 500);
    playrumbleonposition("artillery_rumble", self.origin);
  }
}

heli_fire_turret(var_0, var_1, var_2, var_3) {
  self endon("death");
  self notify("switching_targets");
  self endon("switching_targets");
  self endon("stop_firing");

  if(!isDefined(self.defaultweapon))
    self.defaultweapon = "hind_turret_oilrocks";

  self setvehweapon(self.defaultweapon);

  if(isentity(var_0)) {
    self setturrettargetent(var_0);

    if(isDefined(var_1))
      self setlookatent(var_0);
  } else
    self setturrettargetvec(var_0.origin);

  var_4 = 30;
  var_5 = 50;

  if(isDefined(self.script_burst_min) && isDefined(self.script_burst_max)) {
    var_4 = self.script_burst_min;
    var_5 = self.script_burst_max;
  }

  var_6 = 0.05;

  if(isDefined(self.firewait))
    var_6 = self.firewait;

  for(;;) {
    thread heli_fire_turret_sound();
    var_7 = randomintrange(var_4, var_5);

    for(var_8 = 0; var_8 < var_7; var_8++) {
      if(isDefined(self.firingmissiles) && self.firingmissiles == 1) {
        continue;
      }
      if(isDefined(var_2) || isDefined(self.helifirecheap) && self.helifirecheap == 1)
        heli_fireminigun_cheap();
      else
        self fireweapon("tag_barrel");

      wait(var_6);
    }

    self notify("stop_minigun_sound");
    wait(randomfloatrange(0.4, 0.9));
  }
}

heli_fireminigun_cheap() {
  playFXOnTag(common_scripts\utility::getfx("chopper_minigun_tracer"), self, "tag_flash");
}

heli_fire_turret_sound() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self, "tag_flash", (0, 0, 0), (0, 0, 0));
  var_1 = "minigun_heli_gatling_fire";

  if(isDefined(self.firesoundoverride))
    var_1 = self.firesoundoverride;

  var_0 thread common_scripts\utility::play_loop_sound_on_entity(var_1);
  common_scripts\utility::waittill_any("death", "switching_targets", "stop_firing", "stop_minigun_sound");
  var_0 common_scripts\utility::stop_loop_sound_on_entity("minigun_heli_gatling_fire");
  var_0 delete();
}

heli_fire_turret_oilrocks(var_0, var_1, var_2) {
  self endon("death");
  self notify("switching_targets");
  self endon("switching_targets");
  self endon("stop_firing");
  var_3 = self.mgturret[0];
  var_3 setmode("manual");
  var_3 settargetentity(var_0);

  if(isDefined(var_1))
    self setlookatent(var_0);

  var_4 = 30;
  var_5 = 50;

  if(isDefined(self.script_burst_min) && isDefined(self.script_burst_max)) {
    var_4 = self.script_burst_min;
    var_5 = self.script_burst_max;
  }

  var_6 = 0.05;

  if(isDefined(self.firewait))
    var_6 = self.firewait;

  for(;;) {
    var_7 = randomintrange(var_4, var_5);

    for(var_8 = 0; var_8 < var_7; var_8++) {
      if(isDefined(var_2) || isDefined(self.helifirecheap) && self.helifirecheap == 1)
        heli_fireminigun_cheap();
      else
        var_3 shootturret();

      wait(var_6);
    }

    wait(randomfloatrange(0.4, 0.9));
  }
}

heli_beach_lander_init() {
  self endon("death");
  maps\_utility::ent_flag_init("unload_interrupted");
  maps\_utility::ent_flag_init("landing_gear");
  maps\_utility::ent_flag_init("unload_started");
  maps\_utility::ent_flag_init("unload_complete");
  self.beachlander = 1;

  if(parameters_check("instant_landing")) {
    self.currentnode = common_scripts\utility::getstruct(self.script_linkto, "script_linkname");
    self vehicle_teleport(self.currentnode.origin, self.currentnode.angles);
    self setanimrestart( % nh90_landing_gear_down, 1, 1, 999);
  } else {
    var_0 = common_scripts\utility::waittill_any_return("landing_gear", "reached_dynamic_path_end");

    if(var_0 == "landing_gear") {
      maps\_utility::ent_flag_set("landing_gear");
      self setanimrestart( % nh90_landing_gear_down, 1, 1, 0.5);
      self waittill("reached_dynamic_path_end");
    }
  }

  var_1 = self.currentnode;
  self setneargoalnotifydist(5);
  self sethoverparams(0, 0, 0);
  self setvehgoalpos(var_1.origin, 1);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  self waittill("near_goal");
  maps\_utility::ent_flag_set("unload_started");
  self.fakehealthinvulnerability = 1;
  common_scripts\utility::delaycall(randomfloatrange(0.1, 0.3), ::setanim, % nh90_left_door_open);
  common_scripts\utility::delaycall(randomfloatrange(0.1, 0.3), ::setanim, % nh90_right_door_open);
  var_2 = 0;
  self.unloaded = 0;
  var_3 = var_1 common_scripts\utility::get_linked_ents();
  self.unloadspawners = var_3;

  foreach(var_5 in var_3) {
    wait(randomfloatrange(0.5, 1));
    var_6 = 3;

    if(isDefined(var_5.script_index))
      var_6 = var_5.script_index;

    var_2 = var_6 + var_2;
    var_7 = common_scripts\utility::getstruct(var_5.script_linkto, "script_linkname");
    var_5 thread heli_beach_lander_ai_jumpout(var_7, var_6, self);
  }

  self.fakehealthinvulnerability = undefined;

  while(self.unloaded != var_2) {
    if(maps\_utility::ent_flag("unload_interrupted")) {
      break;
    }

    wait 0.1;
  }

  if(isDefined(var_1.script_flag_wait))
    common_scripts\utility::flag_wait(var_1.script_flag_wait);

  if(isDefined(self.takeoffdelay)) {
    var_9 = self.takeoffdelay * 1000;
    var_10 = gettime();

    while(gettime() - var_10 < var_9) {
      if(maps\_utility::ent_flag("unload_interrupted")) {
        break;
      }

      wait 0.1;
    }
  }

  self notify("unload_complete");
  maps\_utility::ent_flag_set("unload_complete");
  thread heli_beach_lander_leave(var_1);
}

heli_beach_lander_leave(var_0) {
  var_1 = var_0 maps\_utility::get_linked_structs();
  thread maps\_vehicle::vehicle_paths(var_1[0]);
  self setanimrestart( % nh90_landing_gear_up, 1, 1, 0.3);
  heli_enable_rocketdeath(0);
  self.fakehealth = 25;
  self.fakehealthinvulnerability = 1;
  wait 1;
  self.fakehealthinvulnerability = undefined;
}

heli_beach_lander_ai_jumpout(var_0, var_1, var_2) {
  var_2 endon("death");
  var_3 = 0;

  while(var_3 < var_1) {
    var_4 = maps\_utility::spawn_ai();

    if(!isDefined(var_4)) {
      wait 0.1;
      continue;
    }

    var_4 maps\homecoming_beach::beach_enemy_default();
    var_4 maps\_utility::set_baseaccuracy(3);

    if(common_scripts\utility::cointoss())
      var_4.favoriteenemy = level.player;

    var_0 thread maps\_anim::anim_generic(var_4, "jump_down_56");
    wait 1.6;
    var_4 maps\_utility::anim_stopanimscripted();
    wait(randomfloatrange(0.5, 0.9));
    var_3++;
    var_2.unloaded++;

    if(var_2 maps\_utility::ent_flag("unload_interrupted")) {
      break;
    }
  }
}

heli_missile_defense_init(var_0) {
  self endon("death");
  self.flareprotection = 1;

  if(isDefined(var_0))
    level.javelintargets[level.javelintargets.size] = self;

  for(;;) {
    self waittill("missile_targeted", var_1);
    common_scripts\utility::waitframe();
    var_2 = undefined;

    if(isDefined(var_1.islaserguidedmissile))
      var_2 = 1000;
    else {
      var_2 = 600;
      javelin_check_decent(var_1);
    }

    while(isvalidmissile(var_1)) {
      if(common_scripts\utility::distance_2d_squared(self.origin, var_1.origin) < squared(var_2)) {
        break;
      }

      wait 0.05;
    }

    if(!isDefined(var_1) || !isvalidmissile(var_1)) {
      continue;
    }
    thread shootflares();

    while(!isDefined(self.flares))
      wait 0.05;

    wait 0.4;

    if(!isDefined(var_1) || !isvalidmissile(var_1)) {
      continue;
    }
    var_3 = common_scripts\utility::random(self.flares);
    var_3.mytarget = var_1;
    var_1 missile_settargetent(var_3);
    var_1 notify("targeting_flare");

    if(isDefined(var_1.islaserguidedmissile) && var_1.islaserguidedmissile == 1)
      var_1 notify("guided_missile_stop_logic");

    while(isvalidmissile(var_1)) {
      if(distancesquared(var_3.origin, var_1.origin) < squared(400)) {
        break;
      }

      wait 0.05;
    }

    var_4 = common_scripts\utility::getfx("chopper_flare_explosion");

    if(isDefined(var_1) && isvalidmissile(var_1))
      var_1 delete();

    playFX(var_4, var_3.origin);
    var_3 delete();

    if(isDefined(self.flareammo)) {
      self.flareammo--;

      if(self.flareammo == 0) {
        break;
      }
    }
  }

  self.flareprotection = undefined;
}

shootflares(var_0) {
  self notify("shooting_flares");
  var_1 = "tag_flare";

  if(isDefined(var_0))
    var_1 = var_0;

  var_2 = maps\_utility::spawn_anim_model("flare_rig");
  var_2.origin = self gettagorigin(var_1);
  var_3 = anglesToForward(self.angles);
  var_2.angles = vectortoangles(var_3);
  var_4 = [];
  var_5 = ["flare_right_top", "flare_left_bot", "flare_right_bot"];

  foreach(var_7 in var_5) {
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8 linkto(var_2, var_7, (0, 0, 0), (0, 0, 0));
    var_8 thread flare_trackvelocity();
    var_4[var_7] = var_8;
  }

  self.flares = var_4;
  var_10 = level.scr_anim["flare_rig"]["flare"].size;
  var_11 = level.scr_anim["flare_rig"]["flare"][2];
  var_2 setflaggedanim("flare_anim", var_11, 1, 0, 1);
  var_12 = common_scripts\utility::getfx("chopper_flare");
  var_4 = common_scripts\utility::array_randomize(var_4);

  foreach(var_7, var_8 in var_4) {
    if(isDefined(var_8))
      playFXOnTag(var_12, var_4[var_7], "tag_origin");
  }

  var_2 waittillmatch("flare_anim", "end");

  foreach(var_7, var_8 in var_4) {
    if(isDefined(var_8))
      stopFXOnTag(var_12, var_4[var_7], "tag_origin");
  }

  var_2 delete();
  var_4 = common_scripts\utility::array_removeundefined(var_4);
  common_scripts\utility::array_thread(var_4, ::flare_doburnout);
  return var_4;
}

flare_trackvelocity() {
  self endon("death");
  self.velocity = 0;
  var_0 = self.origin;

  for(;;) {
    self.velocity = self.origin - var_0;
    var_0 = self.origin;
    wait 0.05;
  }
}

flare_doburnout() {
  self endon("death");
  self movegravity(14 * self.velocity, 0.2);
  wait 0.2;

  if(!isDefined(self) || isDefined(self.mytarget)) {
    return;
  }
  self delete();
}

get_helicopter_crash_location(var_0) {
  var_1 = [];

  foreach(var_3 in level.helicopter_crash_locations) {
    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy == var_0)
        var_1 = common_scripts\utility::array_add(var_1, var_3);
    }
  }

  if(var_1.size == 1)
    return var_1[0];
  else
    return var_1;
}

a10_strafe_run(var_0) {
  thread maps\_utility::play_sound_on_entity("a10_strafe_roar");
  maps\_utility::delaythread(1, maps\_utility::play_sound_on_entity, "a10_flyby_short");
  var_1 = var_0 maps\_utility::get_linked_structs();

  foreach(var_3 in var_1) {
    if(var_3 noteworthy_check("strafe_start_spot")) {
      var_4 = undefined;

      if(var_3 parameters_check("cheap"))
        var_4 = 1;

      a10_strafe_impacts(var_3, var_4);
    }
  }

  self notify("strafe_done");
}

a10_strafe_impacts(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_3 = var_0.radius;
  var_4 = vectornormalize(var_2.origin - var_0.origin);
  var_5 = spawnStruct();
  var_5.origin = var_0.origin;
  var_5.angles = vectortoangles(var_4);
  var_6 = [var_0.origin, var_2.origin];
  var_7 = get_midpoint(var_6);
  var_7 = common_scripts\utility::drop_to_ground(var_7);
  maps\_utility::delaythread(0.4, ::a10_strafe_impact_earthquake, var_7);
  var_8 = undefined;

  if(var_0 parameters_check("impact_loop_sound")) {
    var_9 = var_0.script_sound;
    var_8 = spawn("script_origin", var_5.origin);
    maps\_utility::delaythread(0.4, ::a10_strafe_impacts_loop_sound, var_8, var_9);
  }

  var_10 = 3;
  var_11 = undefined;

  while(postion_dot_check(var_5, var_2) == "infront") {
    var_12 = 1;

    if(maps\_utility::game_is_current_gen())
      var_12 = 1;

    for(var_13 = 0; var_13 < var_12; var_13++) {
      if(postion_dot_check(var_5, var_2) == "behind") {
        break;
      }

      var_11 = return_point_in_circle(var_5.origin, var_3);

      if(!isDefined(var_1)) {
        var_14 = bulletTrace(var_11, (var_11[0], var_11[1], -99999), 0);
        var_11 = var_14["position"];
      }

      thread a10_strafe_impact(var_11);
    }

    if(var_10 == 3 && !isDefined(var_8)) {
      maps\_utility::delaythread(0.4, common_scripts\utility::play_sound_in_space, "a10p_impact", var_11);
      var_10 = 0;
    } else if(!isDefined(var_8))
      var_10++;

    var_15 = vectornormalize(var_11 - self gettagorigin("tag_gun"));
    playFX(common_scripts\utility::getfx("a10_tracer"), self gettagorigin("tag_gun"), var_15);
    playFXOnTag(common_scripts\utility::getfx("a10_muzzle_flash"), self, "tag_gun");
    self radiusdamage(var_5.origin, var_3, 9999, 9999, self);
    var_5.origin = var_5.origin + var_4 * 100;
    wait 0.05;
  }

  wait 0.4;
  self notify("strafe_done");
  earthquake(0.65, 2, var_7, 2300);

  if(isDefined(var_8))
    var_8 delete();
}

a10_strafe_impact(var_0) {
  wait 0.4;
  playFX(common_scripts\utility::getfx("a10_impact"), var_0, (0, 0, 1));
  playrumbleonposition("artillery_rumble", var_0);
}

a10_strafe_impact_earthquake(var_0) {
  self endon("strafe_done");
  self notify("kill_rumble_forever");

  for(;;) {
    earthquake(0.75, 2, var_0, 2300);
    wait 1;
  }
}

a10_strafe_impacts_loop_sound(var_0, var_1) {
  self endon("strafe_done");

  for(;;)
    var_0 maps\_utility::play_sound_on_entity(var_1);
}

a10_strafe_run_cheap(var_0) {
  self endon("death");
  thread playloopingfx("a10_muzzle_flash", 0.05, undefined, "tag_gun", 1);
  thread playloopingfx("a10_tracer", 0.05, undefined, "tag_gun");
  self waittill("stop_firing");
  self notify("stop_looping_fx");
  thread maps\_utility::play_sound_on_entity("a10_strafe_roar_distant");
}

a10_vista_strafe_group(var_0) {
  level endon("stop_a10_strafe_" + var_0);
  var_1 = getEntArray(var_0, "targetname");
  var_1 = common_scripts\utility::array_randomize(var_1);
  level.a10_strafe_groups[var_0] = [];
  var_2 = getent(var_0 + "_mig", "targetname");
  var_3 = undefined;

  for(;;) {
    foreach(var_5 in var_1) {
      var_6 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
      var_6 vehicle_turnengineoff();
      level.a10_strafe_groups[var_0] = common_scripts\utility::array_removeundefined(level.a10_strafe_groups[var_0]);
      level.a10_strafe_groups[var_0] = common_scripts\utility::array_add(level.a10_strafe_groups[var_0], var_6);

      if(isDefined(var_2) && common_scripts\utility::cointoss()) {
        var_7 = getvehiclenode(var_5.target, "targetname");
        thread a10_vista_strafe_mig(var_2, var_7);
      } else
        var_6 thread vehicle_path_notifications();

      var_6 common_scripts\utility::waittill_any("next_strafe", "reached_end_node", "death");
      var_3 = var_5;
    }

    var_1 = common_scripts\utility::array_remove(var_1, var_3);
    var_1 = common_scripts\utility::array_randomize(var_1);
    var_1 = common_scripts\utility::array_add(var_1, var_3);
  }
}

a10_vista_strafe_group_delete(var_0, var_1) {
  if(!isDefined(level.a10_strafe_groups[var_0])) {
    iprintln("Trying to delete undefined strafe group");
    iprintln("This should only happen when on a start point.");
    return;
  }

  level notify("stop_a10_strafe_" + var_0);

  if(isDefined(var_1))
    maps\_utility::array_delete(common_scripts\utility::array_removeundefined(level.a10_strafe_groups[var_0]));
}

a10_vista_strafe_mig(var_0, var_1) {
  wait(randomfloatrange(0.5, 1));
  var_2 = maps\_vehicle::vehicle_spawn(var_0);
  var_2 attach_path_and_drive(var_1);
  var_2 endon("death");

  for(;;) {
    var_2 notify("stop_looping_fx");
    wait(randomfloatrange(0.5, 1));
    var_2 thread playloopingfx("a10_tracer", 0.05, undefined, "tag_body");
    wait(randomfloatrange(1, 2));
  }
}

slamraam_think(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = [];
  var_4[var_4.size] = "tag_missle1";
  var_4[var_4.size] = "tag_missle2";
  var_4[var_4.size] = "tag_missle3";
  var_4[var_4.size] = "tag_missle4";
  var_4[var_4.size] = "tag_missle5";
  var_4[var_4.size] = "tag_missle6";
  var_4[var_4.size] = "tag_missle7";
  var_4[var_4.size] = "tag_missle8";
  var_3.missiletags = var_4;
  var_3.missiles = [];

  foreach(var_6 in var_4) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7.origin = var_3 gettagorigin(var_6);
    var_7.angles = var_3 gettagangles(var_6);
    var_7 setModel("projectile_slamraam_missile");
    var_7 linkto(var_3, var_6);
    var_3.missiles[var_3.missiles.size] = var_7;
  }

  var_9 = anglesToForward(var_3.angles);
  var_3.targetent = spawn("script_origin", var_3.origin + var_9 * 50 + (0, 0, 115));
  var_3 setturrettargetent(var_3.targetent);

  if(isDefined(var_0) && var_0 == 1)
    var_3 thread slamraam_fire_missiles(var_0, var_1, var_2);
}

slamraam_fire_missiles(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("stop_firing");
  var_4 = var_3.missiletags;

  if(!isDefined(var_1)) {
    var_1[0] = 0.4;
    var_1[1] = 0.8;
  }

  for(;;) {
    foreach(var_8, var_6 in var_4) {
      if(isDefined(var_3.missiles[var_8])) {
        continue;
      }
      var_7 = spawn("script_model", (0, 0, 0));
      var_7.origin = var_3 gettagorigin(var_6);
      var_7.angles = var_3 gettagangles(var_6);
      var_7 setModel("projectile_slamraam_missile");
      var_7 linkto(var_3);
      var_3.missiles[var_3.missiles.size] = var_7;
    }

    var_9 = common_scripts\utility::array_randomize(var_3.missiles);
    wait(randomfloatrange(0.2, 1.2));

    foreach(var_8, var_11 in var_9) {
      var_3 slamraam_fire_missile(var_4[var_8], var_11, var_2);
      wait(randomfloatrange(var_1[0], var_1[1]));
    }

    if(!isDefined(var_0)) {
      break;
    }

    wait(randomintrange(1, 4));
  }
}

slamraam_fire_missile(var_0, var_1, var_2) {
  var_3 = "slamraam_missile";

  if(isDefined(var_2))
    var_3 = var_2;

  var_4 = self gettagorigin(var_0);
  var_5 = self gettagangles(var_0);
  var_6 = anglesToForward(var_5);
  var_7 = var_4 + var_6 * 50000;
  magicbullet(var_3, var_4, var_7);
  maps\_utility::delaythread(0.05, maps\_utility::deleteent, var_1);
}

artemis_think(var_0) {
  if(!isDefined(var_0))
    var_0 = maps\_utility::get_linked_structs();

  var_1 = ["tag_flash_left", "tag_flash_right"];
  var_2 = [ % artemis_fire_l, % artemis_fire_r];
  self.fireents = [];

  foreach(var_6, var_4 in var_1) {
    var_5 = spawn("script_origin", (0, 0, 0));
    var_5.angles = self gettagangles(var_4);
    var_5 linkto(self, var_4, (0, 0, 0), (0, 0, 0));
    var_5.tag = var_4;
    var_5.animation = var_2[var_6];
    self.fireents = common_scripts\utility::array_add(self.fireents, var_5);
  }

  thread artemis_fire_think(var_0);
  common_scripts\utility::waittill_any("death", "stop_firing_for_good");
  maps\_utility::array_delete(self.fireents);
}

artemis_fire_think(var_0) {
  self notify("new_targets");
  self endon("new_targets");
  self endon("stop_firing_for_good");
  self endon("death");

  for(;;) {
    childthread artemis_fire();

    foreach(var_2 in var_0) {
      var_3 = var_2.origin + (0, 0, randomintrange(-25, 25));
      self setturrettargetvec(var_3);

      if(common_scripts\utility::cointoss()) {
        self notify("stop_firing");
        common_scripts\utility::waittill_notify_or_timeout("turret_rotate_stopped", 3);
        childthread artemis_fire();
      }

      wait 5;
    }
  }
}

artemis_fire() {
  self notify("stop_firing");
  self endon("stop_firing");
  var_0 = randomintrange(1, 4);
  var_1 = 0;

  for(;;) {
    foreach(var_3 in self.fireents) {
      if(!isDefined(self.artemisnofiresound))
        var_3 playSound("weap_zpu_turret_fire");

      playFXOnTag(common_scripts\utility::getfx("artemis_muzzleflash"), self, var_3.tag);
      self setanimknoballrestart(var_3.animation, % root);

      if(var_1 == var_0) {
        var_4 = anglesToForward(self gettagangles(var_3.tag));
        var_5 = self gettagorigin(var_3.tag) + var_4 * 400;
        playFX(common_scripts\utility::getfx("artemis_tracer"), var_5, var_4);
        var_1 = 0;
        var_0 = randomintrange(1, 4);
      } else
        var_1++;

      wait 0.16;
    }
  }
}

hovercraft_init() {
  self endon("hovercraft_delete");

  if(!isDefined(level.hovercrafts))
    level.hovercrafts = [];

  level.hovercrafts = common_scripts\utility::array_removeundefined(level.hovercrafts);
  level.hovercrafts[level.hovercrafts.size] = self;
  maps\_utility::ent_flag_init("hovercraft_unload_complete");
  maps\_utility::ent_flag_init("hovercraft_continue_path");
  maps\_utility::ent_flag_init("hovercraft_animations_done");
  maps\_utility::ent_flag_init("hovercraft_delay_return");

  if(!parameters_check("engine_on"))
    self vehicle_turnengineoff();

  if(hovercraft_set_unloaded()) {
    return;
  }
  if(!isDefined(level.hovercraftlanders))
    level.hovercraftlanders = [];

  level.hovercraftlanders[level.hovercraftlanders.size] = self;
  self.cleanupents = [];
  thread hovercraft_anim_logic();
  thread hovercraft_missile_fire();
  var_0 = [];
  var_1 = common_scripts\utility::get_linked_ents();

  foreach(var_3 in var_1) {
    if(var_3 maps\_vehicle::isvehicle()) {
      if(var_3 parameters_check("starter")) {
        continue;
      }
      var_0[var_0.size] = var_3;
      break;
    }
  }

  if(var_0.size > 0) {
    hovercraft_tanks_setup(var_0);
    thread hovercraft_tanks_unload();
  }

  if(parameters_check("droneUnloader"))
    self.droneunloader = 1;

  if(isDefined(self.droneunloader) && self.droneunloader == 1) {
    maps\_utility::ent_flag_init("hovercraft_drone_setup_complete");
    thread hovercraft_drone_setup();
    maps\_utility::ent_flag_wait("hovercraft_drone_setup_complete");
  }

  thread maps\_vehicle::gopath(self);
  self waittill("hovercraft_reached_beach");

  if(hovercraft_deploy_smoke())
    wait 3;

  self notify("hovercraft_unload");
  level.hovercraftlanders = common_scripts\utility::array_remove(level.hovercraftlanders, self);

  if(maps\_utility::ent_flag_exist("hovercraft_tank_unload_complete"))
    maps\_utility::ent_flag_wait("hovercraft_tank_unload_complete");

  if(maps\_utility::ent_flag_exist("hovercraft_drone_unload_complete"))
    maps\_utility::ent_flag_wait("hovercraft_drone_unload_complete");

  if(parameters_check("nonLooper"))
    maps\_utility::ent_flag_wait("hovercraft_unload_complete");
  else
    maps\_utility::ent_flag_set("hovercraft_unload_complete");

  maps\_utility::ent_flag_wait("hovercraft_animations_done");
  maps\_utility::ent_flag_set("hovercraft_continue_path");
  hovercraft_cleanup();
}

hovercraft_anim_logic() {
  self endon("hovercraft_delete");
  self setanim( % hovercraft_rocking);
  self waittill("hovercraft_reached_beach");
  self clearanim( % hovercraft_rocking, 0.2);
  self setanim( % hovercraft_enemy_upper_fans, 1, 0.2, 0.4);
  var_0 = 1;
  var_1 = 12;

  if(isDefined(self.deflaterate)) {
    var_0 = self.deflaterate;
    var_1 = var_1 / var_0;
  }

  self.deflaterate = var_0;
  self setanim( % lcac_deflate, 1.0, 0.2, var_0);
  wait(var_1);
  self setflaggedanim("anim", % lcac_deflate, 1, 0, 0);
  maps\_utility::ent_flag_wait("hovercraft_unload_complete");
  self setanim( % hovercraft_enemy_upper_fans, 1, 0.2, 1);
  self setflaggedanim("anim", % lcac_deflate, 1, 1, 1);
  self waittillmatch("anim", "end");
  self setanim( % hovercraft_rocking);
  maps\_utility::ent_flag_set("hovercraft_animations_done");
}

hovercraft_missile_fire() {
  self endon("hovercraft_delete");
  self endon("death");
  var_0 = maps\_utility::get_linked_structs();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 parameters_check("missile_spot")) {
      var_4 = spawn("script_origin", var_3.origin);
      var_4 linkto(self);
      var_1[var_1.size] = var_4;
      self.cleanupents = common_scripts\utility::array_add(self.cleanupents, var_4);
    }
  }

  var_6 = undefined;

  if(isDefined(self.hovercraftmissiletimeout))
    var_6 = self.hovercraftmissiletimeout;

  var_7 = "hovercraft_missile_guided";

  for(;;) {
    self waittill("fire_missiles");
    var_8 = self.currentnode;

    if(var_8 parameters_check("cointoss")) {
      if(common_scripts\utility::cointoss())
        continue;
    }

    if(isDefined(var_8.script_sound))
      thread maps\_utility::play_sound_on_entity(var_8.script_sound);

    var_9 = 3;

    if(isDefined(var_8.script_count))
      var_9 = var_8.script_count;

    var_1 = common_scripts\utility::array_randomize(var_1);
    var_10 = 0;

    while(var_10 <= var_9) {
      foreach(var_12 in var_1) {
        var_10++;

        if(var_10 > var_9) {
          break;
        }

        var_13 = var_12.origin;
        var_14 = anglesToForward((330, 0, 0));
        var_15 = var_13 + var_14 * 50000;
        var_16 = magicbullet(var_7, var_13, var_15);
        var_17 = anglesToForward((0, 0, 0));
        var_15 = var_13 + var_17 * 20000;
        var_16 common_scripts\utility::delaycall(randomfloatrange(4, 6), ::missile_settargetpos, var_15);

        if(isDefined(var_6))
          var_16 common_scripts\utility::delaycall(var_6, ::delete);

        wait(randomfloatrange(0.4, 0.8));
      }
    }
  }
}

hovercraft_drone_setup() {
  self endon("hovercraft_delete");
  maps\_utility::ent_flag_init("hovercraft_drone_unload_complete");

  if(parameters_check("infiniteDrones"))
    self.infinitedrones = 1;

  var_0 = common_scripts\utility::get_linked_ents();

  foreach(var_2 in var_0) {
    if(var_2 parameters_check("hovercraft_drone_clip")) {
      var_2 linkto(self, "tag_detach");
      self.droneclip = var_2;
      self.cleanupents = common_scripts\utility::array_add(self.cleanupents, var_2);
    }
  }

  var_4 = maps\_utility::get_linked_structs();

  foreach(var_6 in var_4) {
    if(var_6 parameters_check("hovercraft_drone_row")) {
      self.dronerowstart = spawn("script_origin", var_6.origin);
      self.dronerowstart.angles = var_6.angles;
      self.dronerowstart linkto(self, "tag_detach");
      self.cleanupents = common_scripts\utility::array_add(self.cleanupents, self.dronerowstart);
      var_7 = common_scripts\utility::getstruct(var_6.target, "targetname");
      self.dronerowend = spawn("script_origin", var_7.origin);
      self.dronerowend.origin = var_7.origin;
      self.dronerowend.angles = var_7.angles;
      self.dronerowend linkto(self, "tag_detach");
      self.cleanupents = common_scripts\utility::array_add(self.cleanupents, self.dronerowend);
    }
  }

  self.fakedrones = undefined;
  maps\_utility::ent_flag_set("hovercraft_drone_setup_complete");
  self.unloaddrones = [];
  self waittill("hovercraft_unload");

  if(!isDefined(level.hovercraftdroneunloader))
    level.hovercraftdroneunloader = 0;

  level.hovercraftdroneunloader++;
  hovercraft_unloader_init();

  if(isDefined(self.fronttank))
    self.fronttank maps\_utility::ent_flag_wait("hovercraft_unload_complete");
  else if(isDefined(self.fakedrones)) {
    maps\_utility::array_delete(self.fakedrones);
    self.fakedrones = undefined;
  }

  var_9 = 4;

  if(isDefined(self.infinitedrones))
    var_9 = 1;
  else if(isDefined(self.script_drone_repeat_count))
    var_9 = self.script_drone_repeat_count;

  var_10 = randomfloatrange(0.5, 1.4);
  var_11 = 5;
  var_12 = undefined;

  if(isDefined(self.backtank))
    var_12 = 1;

  while(var_9 != 0) {
    if(isDefined(self.stopdroneunload)) {
      break;
    }

    common_scripts\utility::flag_wait("player_not_doing_strafe");
    hovercraft_load_drones();
    wait(var_10);
    hovercraft_dday_runout();
    wait(var_11);
    self.script_drones_max = 5;

    if(!isDefined(self.infinitedrones))
      var_9--;

    var_10 = 0;
    var_11 = 3;

    if(isDefined(var_12)) {
      if(isDefined(self.delaytankunload)) {
        continue;
      }
      var_12 = undefined;
      maps\_utility::ent_flag_wait("hovercraft_tank_unload_complete");
      wait 2;
    }
  }

  maps\_utility::ent_flag_set("hovercraft_drone_unload_complete");
  self notify("drone_runout_done");
}

hovercraft_unloader_init() {
  common_scripts\utility::waitframe();
  var_0 = self.currentnode;
  self.dronepathstarts = [];
  self.dronefightspots = [];

  if(isDefined(var_0.script_drones_max))
    self.script_drones_max = var_0.script_drones_max;

  var_1 = var_0 common_scripts\utility::get_linked_ents();
  var_2 = var_0 maps\_utility::get_linked_structs();
  var_3 = common_scripts\utility::array_combine(var_1, var_2);

  foreach(var_5 in var_3) {
    if(isspawner(var_5)) {
      self.dronespawner = var_5;
      continue;
    }

    if(isentity(var_5))
      var_5 linkto(self, "tag_detach");

    if(!isDefined(var_5.script_noteworthy)) {
      continue;
    }
    switch (var_5.script_noteworthy) {
      case "hovercraft_drone_pathstarts":
        self.dronepathstarts[self.dronepathstarts.size] = var_5;
        break;
    }
  }
}

hovercraft_load_drones() {
  var_0 = spawnStruct();
  var_0.origin = self.dronerowstart.origin;
  var_0.angles = self.dronerowstart.angles;
  var_1 = self.dronerowend;
  var_2 = anglesToForward(var_0.angles) * -1;
  var_3 = anglestoright(var_0.angles);
  var_4 = 7;

  if(isDefined(self.dronerowsamount))
    var_4 = self.dronerowsamount;

  if(!isDefined(self.script_drones_max))
    self.script_drones_max = 5;

  self.dronerows = [];
  var_5 = 0;
  var_6 = [];

  for(var_7 = maps\homecoming_drones::drones_request(self.script_drones_max); var_6.size < var_7; var_5++) {
    var_8 = spawnStruct();
    var_8.origin = var_0.origin;
    var_8.origin = var_0.origin + var_3 * randomintrange(10, 40);
    self.dronerows[var_5] = [];

    while(postion_dot_check(var_1, var_8) == "behind") {
      if(var_6.size >= var_7) {
        return;
      }
      var_9 = self.dronerows[var_5].size;
      var_10 = self.dronespawner maps\_utility::spawn_ai();
      var_10 thread maps\homecoming_drones::drones_death_watcher();
      var_10.origin = var_8.origin;
      var_10.angles = var_0.angles;
      var_10 linkto(self, "tag_detach");
      var_6 = common_scripts\utility::array_add(var_6, var_10);
      self.unloaddrones = common_scripts\utility::array_add(self.unloaddrones, var_10);
      self.dronerows[var_5][var_9] = var_10;
      var_10.script_linkname = undefined;
      var_11 = randomintrange(40, 80);
      var_8.origin = var_8.origin + var_3 * var_11;

      if(var_6.size >= self.script_drones_max)
        return;
    }

    var_0.origin = var_0.origin + var_2 * 24;
  }
}

hovercraft_load_fake_drones() {
  var_0 = spawnStruct();
  var_0.origin = self.dronerowstart.origin;
  var_0.angles = self.dronerowstart.angles;
  var_1 = self.dronerowend;
  var_2 = anglesToForward(var_0.angles) * -1;
  var_3 = anglestoright(var_0.angles);
  var_4 = 0;

  for(self.fakedrones = []; var_4 < 7; var_4++) {
    var_5 = spawnStruct();

    for(var_5.origin = var_0.origin + var_3 * randomintrange(10, 40); postion_dot_check(var_1, var_5) == "behind"; var_5.origin = var_5.origin + var_3 * var_7) {
      var_6 = spawn("script_model", var_5.origin);
      var_6.angles = (0, 90, 0);
      var_6 setModel("pose_fed_army_stand_idle");
      var_6 linkto(self, "tag_detach");
      self.fakedrones[self.fakedrones.size] = var_6;
      var_7 = randomintrange(40, 80);
    }

    var_0.origin = var_0.origin + var_2 * 24;
  }
}

hovercraft_dday_runout() {
  var_0 = 0;

  foreach(var_2 in self.dronerows) {
    var_3 = var_2.size / 2;
    var_3 = int(var_3);
    var_4 = var_2[var_3];
    var_5 = undefined;
    var_6 = sortbydistance(self.dronepathstarts, var_4.origin);

    foreach(var_8 in var_6) {
      if(postion_dot_check(var_8, var_4) == "behind") {
        var_5 = var_8;
        break;
      }
    }

    foreach(var_11 in var_2) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_12 = randomfloatrange(0, 0.4);
      var_12 = var_12 + var_0;
      var_11 common_scripts\utility::delaycall(var_12, ::unlink);
      var_11 maps\_utility::delaythread(var_12, maps\homecoming_drones::drone_animate_on_path, common_scripts\utility::getstruct(var_5.targetname, "targetname"));
      var_11 thread maps\_utility::notify_delay("hovercraft_runout", var_12);
      var_11 thread hovercraft_drone_random_die(var_12 + 8, 14);
    }

    var_0 = var_0 + randomfloatrange(0.2, 0.4);
  }
}

hovercraft_ai_pathstarts() {
  var_0 = self.dronepathstarts[0];
  var_1 = anglesToForward(var_0.angles) * -1;
  self.dronepathstarts = [];
  var_2 = int(self.dronerows.size / 2);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self.dronepathstarts[self.dronepathstarts.size] = var_0;
    iprintlnbold("created");
    var_4 = spawnStruct();
    var_4.origin = var_0.origin + var_1 * 60;
    var_4.angles = var_0.angles;
    var_4.target = var_0.targetname;
    var_4.targetname = "hovercraft_" + level.hovercraftdroneunloader + "_dronepathstart_" + var_3;
    var_0 = var_4;
  }
}

hovercraft_deploy_smoke() {
  var_0 = self.currentnode;
  var_1 = var_0 maps\_utility::get_linked_structs();
  var_2 = undefined;
  self.hovercraftsmokeents = undefined;
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(var_3 == 1) {
      break;
    }

    if(!isDefined(var_5.targetname)) {
      continue;
    }
    if(var_5.targetname == "hovercraft_drone_smoke") {
      if(!isDefined(var_2))
        var_2 = [];

      var_2 = common_scripts\utility::array_add(var_2, var_5);
      var_3++;
    }
  }

  if(!isDefined(var_2))
    return 0;

  self endon("hovercraft_drone_unload_complete");
  self endon("stop_deploying_smoke");
  self.hovercraftsmokeents = [];

  foreach(var_8 in var_2) {
    var_9 = var_8 common_scripts\utility::spawn_tag_origin();
    self.hovercraftsmokeents = common_scripts\utility::array_add(self.hovercraftsmokeents, var_9);
    playFXOnTag(common_scripts\utility::getfx("hovercraft_smoke"), var_9, "tag_origin");
  }

  self notify("hovercraft_smoke_deployed");
  thread hovercraft_deploy_smoke_stop();
  return 1;
}

hovercraft_deploy_smoke_stop() {
  self endon("hovercraft_delete");
  common_scripts\utility::waittill_any("stop_deploying_smoke", "hovercraft_animations_done");
  maps\_utility::array_delete(self.hovercraftsmokeents);
  self.hovercraftsmokeents = undefined;
}

hovercraft_drone_default(var_0) {
  if(!isDefined(level.hovercraftdrones))
    level.hovercraftdrones = [];

  level.hovercraftdrones = common_scripts\utility::array_removeundefined(level.hovercraftdrones);
  level.hovercraftdrones[level.hovercraftdrones.size] = self;
  self.name = "";
  self setlookattext("", & "");
  self.team = "axis";
  self.health = 1;

  if(!isDefined(level.defaultdroneragdoll))
    level.defaultdroneragdoll = 0;

  level.defaultdroneragdoll++;

  if(level.defaultdroneragdoll == 6) {
    self.noragdoll = 1;
    level.defaultdroneragdoll = 0;
  }

  if(!isDefined(var_0))
    self.drone_lookahead_value = 350;

  maps\homecoming_drones::give_drone_deathanim();
  self.muzzleflashoverride = "drone_tracer";
  self.nodroneweaponsound = 1;
  var_1 = ["run_n_gun", "run", "sprint"];
  var_2 = common_scripts\utility::random(var_1);

  if(var_2 == "sprint")
    maps\_utility::set_moveplaybackrate(1.3);
  else if(var_2 == "run_n_gun") {
    if(common_scripts\utility::cointoss())
      var_2 = "run";
    else
      thread func_waittill_msg(self, "hovercraft_runout", maps\homecoming_drones::drone_fire_randomly_loop);
  }

  self.runanim = level.drone_anims[self.team]["stand"][var_2];
}

hovercraft_drone_random_die(var_0, var_1) {
  self endon("death");
  self endon("drone_random_death");
  wait(randomfloatrange(var_0, var_1));
  maps\_utility::die();
}

hovercraft_tanks_setup(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_4] = maps\_vehicle::vehicle_spawn(var_3);

  self.tanks = var_1;
  maps\_utility::ent_flag_init("hovercraft_allow_tank_unload");
  maps\_utility::ent_flag_init("hovercraft_tank_unload_complete");
  var_5 = ["front", "back"];
  var_6 = ["TAG_TANK_FORWARD", "TAG_TANK_BACK"];
  var_7 = ["lcac_tank_exit_01", "lcac_tank_exit_02"];

  foreach(var_4, var_9 in var_1) {
    var_9 maps\_utility::ent_flag_init("hovercraft_unload_complete");
    var_9 vehicle_turnengineoff();
    var_9.lights = undefined;
    var_10 = var_9 vehicle_to_model();

    if(isDefined(var_9.script_parameters)) {
      if(var_9 parameters_check("front")) {
        var_10.tag = "TAG_TANK_FORWARD";
        var_10.unloadanim = "lcac_tank_exit_01";
        self.fronttank = var_9;
      } else if(var_9 parameters_check("back")) {
        var_10.tag = "TAG_TANK_BACK";
        var_10.unloadanim = "lcac_tank_exit_02";
        self.backtank = var_9;
      }
    }

    if(!isDefined(var_10.tag)) {
      var_10.tag = var_6[var_4];
      var_10.unloadanim = var_7[var_4];
    }

    var_10 linkto(self, var_10.tag, (0, 0, 0), (0, 0, 0));
    maps\_vehicle::gopath(var_9);
  }
}

hovercraft_tanks_unload(var_0) {
  self waittill("hovercraft_unload");
  common_scripts\utility::waitframe();

  if(parameters_check("delayTankUnload"))
    self.delaytankunload = 1;

  if(isDefined(self.delaytankunload)) {
    maps\_utility::ent_flag_wait("hovercraft_allow_tank_unload");
    self.delaytankunload = undefined;
  }

  foreach(var_6, var_2 in self.tanks) {
    var_3 = var_2.fakemodel;
    thread maps\_anim::anim_generic(var_3, var_3.unloadanim, var_3.tag);
    var_4 = maps\_utility::getanim_generic(var_3.unloadanim);
    var_3 setflaggedanim("single anim", var_4, 1, 0, self.deflaterate);
    var_5 = getanimlength(var_4);
    var_5 = var_5 / self.deflaterate;
    maps\_utility::delaythread(var_5, ::hovercraft_tanks_unload_logic, var_2, var_3);
  }

  foreach(var_2 in self.tanks)
  var_2 maps\_utility::add_wait(maps\_utility::ent_flag_wait, "hovercraft_unload_complete");

  maps\_utility::do_wait();
  self notify("unloaded");
  maps\_utility::ent_flag_set("hovercraft_tank_unload_complete");
}

hovercraft_tanks_unload_logic(var_0, var_1) {
  var_0 model_to_vehicle();
  var_0 maps\_utility::ent_flag_set("hovercraft_unload_complete");
}

hovercraft_set_unloaded() {
  if(!parameters_check("unloaded"))
    return 0;

  self setanim( % lcac_deflate);
  self setanimtime( % lcac_deflate, 0.5);
  self setflaggedanim("single anim", % lcac_deflate, 1, 0, 0);
  thread hovercraft_deploy_smoke();
  thread hovercraft_unloaded_leave();
  return 1;
}

hovercraft_unloaded_leave() {
  self endon("death");
  maps\_utility::ent_flag_wait("hovercraft_unload_complete");
  self notify("stop_deploying_smoke");
  self setanim( % hovercraft_enemy_upper_fans, 1, 0.2, 1);
  self setflaggedanim("anim", % lcac_deflate, 1, 1, 1);
  self waittillmatch("anim", "end");
  self setanim( % hovercraft_rocking);
  maps\_utility::ent_flag_set("hovercraft_continue_path");
}

hovercraft_cleanup() {
  if(isDefined(self.cleanupents)) {
    self.cleanupents = common_scripts\utility::array_removeundefined(self.cleanupents);
    maps\_utility::array_delete(self.cleanupents);
  }
}

hovercraft_delete() {
  self notify("hovercraft_delete");

  if(isDefined(self.fakedrones))
    maps\_utility::array_delete(self.fakedrones);

  if(isDefined(self.hovercraftsmokeents))
    maps\_utility::array_delete(self.hovercraftsmokeents);

  if(isDefined(self.unloaddrones)) {
    var_0 = maps\_utility::array_removedead(self.unloaddrones);
    maps\_utility::array_delete(var_0);
  }

  hovercraft_cleanup();
  self delete();
}

hovercraft_allow_death() {
  var_0 = common_scripts\utility::get_linked_ents();
  self.weaponclip = undefined;

  foreach(var_2 in var_0) {
    if(var_2 parameters_check("weaponclip")) {
      var_2 setCanDamage(1);
      var_2 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
      self.weaponclip = var_2;
      break;
    }
  }

  for(;;) {
    self.weaponclip waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(!isplayer(var_5)) {
      continue;
    }
    if(var_13 == "a10_30mm_player_homecoming")
      self.fakehealth = self.fakehealth - 200;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  maps\_vehicle::godoff();
  self notify("death");
}

ship_artillery_init(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4.script_index;
    var_2[var_5] = var_4;
  }

  level.shipartilleryspots = var_2;
}

fire_artillery(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_3 = get_target_chain_array(var_2);

  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_delay))
      var_5 maps\_utility::script_delay();

    thread fire_artillery_shell(level.shipartilleryspots[var_5.script_index], var_5, var_1);
  }
}

fire_artillery_shell(var_0, var_1, var_2) {
  playFX(common_scripts\utility::getfx("battleship_artillery_flash"), var_0.origin, anglesToForward((0, 0, 0)));
  maps\_utility::delaythread(0.5, common_scripts\utility::play_sound_in_space, "artillery_fire_distant", var_0.origin);
  wait 2;
  var_3 = 1.1;
  var_4 = create_artillery_shell(var_0);
  var_4 moveto(var_1.origin, var_3, 0.7, 0);
  var_5 = (var_1.origin[0], var_1.origin[1], var_4.wake.origin[2]);
  var_4.wake moveto(var_5, var_3, 0.7, 0);
  thread artillery_shell_wake_watcher(var_4);
  thread common_scripts\utility::play_sound_in_space("artillery_incoming", var_1.origin);
  var_4 thread playloopingfx("artillery_trail_2");
  var_4 waittill("movedone");

  if(isDefined(var_1.script_flag_set))
    common_scripts\utility::flag_set(var_1.script_flag_set);

  if(isDefined(var_1.script_noteworthy))
    level notify(var_1.script_noteworthy, var_1);

  var_6 = var_1 maps\_utility::get_linked_structs();

  foreach(var_8 in var_6) {
    if(var_8 parameters_check("sandbag"))
      thread explosion_throw_sandbags(var_8);
  }

  thread common_scripts\utility::play_sound_in_space("artillery_explosion", var_1.origin);

  if(!var_1 parameters_check("no_explosion")) {
    if(isDefined(var_2)) {
      artillery_player_mg_check();
      thread artillery_player_slide(var_1);

      if(distance2d(level.player.origin, var_1.origin) < 200)
        level.player shellshock("homecoming_artillery_close", 5);
      else
        level.player shellshock("homecoming_artillery_far", 5);

      level.player thread artillery_disableweapons();
      level.player viewkick(25, var_1.origin);
    }

    earthquake(0.4, randomfloatrange(1.5, 2), var_1.origin, 10000);
    var_10 = anglesToForward((0, 0, 0));
    var_11 = "artillery_explosion_player";

    if(isDefined(var_1.script_fxid)) {
      var_11 = var_1.script_fxid;

      if(isDefined(var_1.angles))
        var_10 = anglesToForward(var_1.angles);
    }

    playFX(common_scripts\utility::getfx(var_11), var_1.origin, var_10);
  }

  var_4 delete();
}

shell_screen_effects(var_0) {
  if(common_scripts\utility::flag("artillery_roof_blowup")) {
    return;
  }
  level.player notify("shell_screen_effect");
  level.player endon("shell_screen_effect");

  if(!isDefined(level.player.shellscreeneffect)) {
    level.player.shellscreeneffect = maps\_hud_util::create_client_overlay("black", 0, level.player);
    level.player.lastshelleffecttime = 0;
  }

  var_1 = var_0.origin;
  playrumbleonposition("artillery_rumble", var_1);
  var_2 = common_scripts\utility::distance_2d_squared(level.player.origin, var_1);

  if(var_2 > squared(1000)) {
    return;
  }
  if(level.player.health > 50)
    level.player dodamage(100, level.player.origin);

  level.player shellshock("homecoming_bunker", 0.4);
  level.player thread maps\_gameskill::grenade_dirt_on_screen("left");
  level.player.lastshelleffecttime = gettime();
  var_3 = 0.25;
  thread maps\_utility::set_blur(randomintrange(3, 5), 0.25);
  level.player.shellscreeneffect thread maps\_hud_util::fade_over_time(0.1, 0.25);
  wait 0.25;
  thread maps\_utility::set_blur(0, 0.25);
  level.player.shellscreeneffect thread maps\_hud_util::fade_over_time(0, 0.4);
}

create_artillery_shell(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = (0, 0, 0);
  var_1 setModel("tag_origin");
  var_1.wake = spawn("script_model", var_1.origin - (0, 0, 690));
  var_1.wake.angles = (0, 0, 0);
  var_1.wake setModel("tag_origin");
  playFXOnTag(common_scripts\utility::getfx("artillery_tracer"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("artillery_trail"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("artillery_mist"), var_1.wake, "tag_origin");
  return var_1;
}

artillery_shell_wake_watcher(var_0) {
  while(isDefined(var_0)) {
    if(var_0.origin[0] > -7000) {
      break;
    }

    wait 0.05;
  }

  var_0.wake delete();
}

artillery_player_slide(var_0) {
  level.player notify("new_artillery_slide");
  level.player endon("new_artillery_slide");

  if(!isDefined(level.player.slidemodel)) {
    var_1 = spawn("script_origin", level.player.origin);
    var_1.angles = level.player.angles;
    level.player.slidemodel = var_1;
    level.player playerlinkto(var_1);
    var_2 = anglesToForward(level.player.angles);
    var_1 moveslide((0, 0, 0), 15, var_2);
    level.player thread maps\_utility_code::doslide(var_1, 10, 0.1);
  }

  var_1 = level.player.slidemodel;
  var_2 = vectornormalize(level.player.origin - var_0.origin);
  var_2 = (0, var_2[1], var_2[2]);
  var_1 moveslide((0, 0, 15), 15, var_2 * 500);
  maps\_utility::wait_for_flag_or_timeout("FLAG_artillery_sequence_done", 5);

  if(common_scripts\utility::flag("FLAG_artillery_sequence_done"))
    wait 0.5;

  level.player notify("stop_sliding");
  level.player unlink();
  level.player.slidemodel delete();
}

artillery_player_mg_check() {
  var_0 = getent("bunker_turret", "targetname");

  if(common_scripts\utility::flag("player_on_dshk_turret")) {
    level.player notify("turret_dismount");
    common_scripts\utility::flag_wait("player_dismounting_turret");

    while(common_scripts\utility::flag("player_dismounting_turret"))
      wait 0.05;
  }
}

artillery_disableweapons() {
  level.player notify("new_artillery_hit");
  level.player endon("new_artillery_hit");
  level.player disableweapons();
  wait(randomfloatrange(1, 2));
  level.player enableweapons();
}

explosion_throw_sandbags(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_5 = int(distance2d(var_0.origin, var_4.origin));
  var_6 = vectornormalize(var_4.origin - var_0.origin);
  var_7 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(isDefined(var_7.target)) {
    var_11 = common_scripts\utility::getstruct(var_7.target, "targetname");
    var_8 = int(distance2d(var_7.origin, var_11.origin));
    var_9 = vectornormalize(var_11.origin - var_7.origin);
  } else
    var_10 = vectornormalize(var_7.origin - var_0.origin);

  var_12 = ["ac_prs_imp_mil_sandbag_desert_single_flat", "ac_prs_imp_mil_sandbag_desert_single_bent"];

  if(!isDefined(var_1))
    var_1 = randomintrange(10, 15);

  for(var_13 = 0; var_13 < var_1; var_13++) {
    var_14 = randomintrange(0, var_5);
    var_15 = var_0.origin + var_6 * var_14;
    var_16 = spawn("script_model", var_15);
    var_16 setModel(common_scripts\utility::random(var_12));

    if(isDefined(var_8)) {
      var_14 = randomintrange(0, var_8);
      var_15 = var_7.origin + var_9 * var_14;
      var_10 = vectornormalize(var_15 - var_16.origin);
    }

    if(getdvarint("daniel") == 1)
      thread maps\_utility::draw_line_until_notify(var_16.origin, var_15, 0, 0, 1, level.player, "STOPPPP");

    if(!isDefined(var_2))
      var_2 = randomfloatrange(30000, 35000);

    var_16 physicslaunchclient(var_16.origin, var_10 * var_2);
    var_16 maps\_utility::delaythread(randomintrange(5, 10), maps\_utility::self_delete);

    if(isDefined(var_3)) {
      wait(var_3);
      continue;
    }

    if(common_scripts\utility::cointoss())
      wait 0.05;
  }
}

ambient_smallarms_fire(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1))
    level endon(var_1);

  if(isstring(var_0))
    var_0 = common_scripts\utility::getstruct(var_0, "targetname");

  var_5 = "drone_tracer";

  if(isDefined(var_4))
    var_5 = var_4;

  var_6 = 0.05;

  if(isDefined(var_2))
    var_6 = var_2;

  var_7 = 0.1;

  if(isDefined(var_3))
    var_7 = var_3;

  var_8 = common_scripts\utility::getstruct(var_0.target, "targetname");

  for(;;) {
    var_9 = return_point_in_circle(var_0.origin, var_0.radius, var_0.height);
    var_10 = return_point_in_circle(var_8.origin, var_8.radius, var_8.height);
    var_11 = vectornormalize(var_10 - var_9);
    playFX(common_scripts\utility::getfx(var_5), var_9, var_11);
    wait(randomfloatrange(var_6, var_7));
  }
}

init_ambient_distant_battlechatter() {
  level.distant_battlechatter = [];
  level.distant_battlechatter["us"] = [];
  level.distant_battlechatter["sp"] = [];
  var_0 = ["US_0_inform_attack_grenade_d", "US_0_inform_killfirm_infantry_d", "US_0_inform_reloading_generic_d", "US_0_inform_taking_fire_d", "US_0_order_move_combat_d", "US_0_reaction_casualty_generic_d", "US_1_inform_attack_grenade_d", "US_1_inform_killfirm_infantry_d", "US_1_inform_taking_fire_d", "US_1_inform_reloading_generic_d"];
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = var_3;

  level.distant_battlechatter["us"] = var_1;
  var_0 = ["SP_0_grenade_incoming_d", "SP_0_inform_killfirm_infantry_d", "SP_0_inform_reloading_generic_d", "SP_0_inform_taking_fire_d", "SP_0_order_move_combat_d", "SP_0_reaction_casualty_generic_d", "SP_1_inform_killfirm_infantry_d", "SP_1_inform_attack_grenade_d", "SP_1_inform_reloading_generic_d", "SP_1_inform_taking_fire_d"];
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = var_3;

  level.distant_battlechatter["sp"] = var_1;
}

ambient_distant_battlechatter(var_0, var_1, var_2) {
  level notify("new_distant_battlechatter");
  level endon("new_distant_battlechatter");

  if(isDefined(var_1))
    level endon(var_1);

  if(isstring(var_0))
    var_0 = common_scripts\utility::getstructarray(var_0, "targetname");

  if(isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(var_4.script_noteworthy == var_2)
        var_0 = common_scripts\utility::array_remove(var_0, var_4);
    }
  }

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_4 = var_0[randomint(var_0.size)];
    var_6 = var_4.script_noteworthy;
    var_7 = level.distant_battlechatter[var_6];
    var_8 = var_7[randomint(var_7.size)];
    common_scripts\utility::play_sound_in_space(var_8, var_4.origin);
  }
}

destructible_dragons_teeth() {
  var_0 = self;
  var_0 destructible_setup(1000);

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_10)) {
      continue;
    }
    if(!isplayer(var_2)) {
      continue;
    }
    var_10 = tolower(var_10);

    if(var_10 != "chaingun_turret") {
      continue;
    }
    var_0.currenthealth = var_0.currenthealth - var_1;

    if(var_0.currenthealth <= 0) {
      playFX(common_scripts\utility::getfx("dragons_teeth_concrete_fx"), var_0.origin, var_3 * -1);
      var_11 = undefined;

      if(isDefined(var_0.target))
        var_11 = getent(var_0.target, "targetname");

      var_0 delete();

      if(!isDefined(var_11)) {
        return;
      }
      var_11 destructible_setup(1000);
      var_0 = var_11;
    }
  }
}

destructible_sandbags() {
  var_0 = self;
  var_0 destructible_setup(2000);
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = var_0 common_scripts\utility::get_linked_ent();
  var_3 = getnode(var_0.target, "targetname");

  for(;;) {
    var_0 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(!isDefined(var_13)) {
      continue;
    }
    if(!isplayer(var_5)) {
      continue;
    }
    var_13 = tolower(var_13);

    if(var_13 != "chaingun_turret") {
      continue;
    }
    var_0.currenthealth = var_0.currenthealth - var_4;

    if(var_0.currenthealth <= 0) {
      playFX(common_scripts\utility::getfx("destructible_sandbags_fx"), var_0.origin);
      thread explosion_throw_sandbags(var_1, randomintrange(4, 6), 20000, randomfloatrange(0.05, 0.1));
      var_0.origin = var_0.origin + (0, 0, -13);
      break;
    } else {
      thread explosion_throw_sandbags(var_1, 1, 2000);
      var_0.origin = var_0.origin + (0, 0, -2);
    }
  }

  if(isDefined(var_3))
    var_3 disconnectnode();
}

destructible_setup(var_0) {
  self setCanDamage(1);
  self.currenthealth = var_0;
}

player_embers() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 hide();
  var_0.origin = level.player getEye();
  var_0 linkto(level.player);

  while(!common_scripts\utility::flag("FLAG_start_recruit_scene")) {
    playFXOnTag(common_scripts\utility::getfx("player_embers"), var_0, "tag_origin");
    wait 0.25;
  }

  stopFXOnTag(common_scripts\utility::getfx("player_embers"), var_0, "tag_origin");
  var_0 delete();
}

debug_check_time() {
  var_0 = gettime();
  level.player notifyonplayercommand("BUTTON_TIMECHECK", "+attack");

  for(;;) {
    level.player waittill("BUTTON_TIMECHECK");
    iprintlnbold((gettime() - var_0) / 1000);
  }
}

debug_ai_drone_amounts() {
  level.player notifyonplayercommand("BUTTON_AI_DRONE_AMOUNT_DEBUG", "+actionslot 4");

  for(;;) {
    if(!getdvarint("daniel")) {
      wait 0.2;
      continue;
    }

    level.player waittill("BUTTON_AI_DRONE_AMOUNT_DEBUG");
    var_0 = 110;
    var_1 = maps\_hud_util::createfontstring("default", 1.5);
    var_1.x = 580;
    var_1.y = var_0;
    var_0 = var_0 + 15;
    var_2 = maps\_hud_util::createfontstring("default", 1.5);
    var_2.x = 580;
    var_2.y = var_0;
    var_0 = var_0 + 15;
    var_3 = maps\_hud_util::createfontstring("default", 1.5);
    var_3.x = 580;
    var_3.y = var_0;
    var_0 = var_0 + 15;
    var_4 = maps\_hud_util::createfontstring("default", 1.5);
    var_4.x = 580;
    var_4.y = var_0;
    var_0 = var_0 + 15;
    var_5 = maps\_hud_util::createfontstring("default", 1.5);
    var_5.x = 580;
    var_5.y = var_0;
    var_0 = var_0 + 30;
    var_6 = maps\_hud_util::createfontstring("default", 1.5);
    var_6.x = 580;
    var_6.y = var_0;
    var_0 = var_0 + 15;
    var_7 = maps\_hud_util::createfontstring("default", 1.5);
    var_7.x = 580;
    var_7.y = var_0;
    var_0 = var_0 + 15;
    var_8 = maps\_hud_util::createfontstring("default", 1.5);
    var_8.x = 580;
    var_8.y = var_0;
    var_0 = var_0 + 15;
    var_9 = maps\_hud_util::createfontstring("default", 1.5);
    var_9.x = 580;
    var_9.y = var_0;
    var_0 = var_0 + 15;
    var_10 = maps\_hud_util::createfontstring("default", 1.5);
    var_10.x = 580;
    var_10.y = var_0;
    thread debug_ai_drone_amounts_logic(var_1, var_3, var_2, var_4, var_5);
    thread ent_count_check(var_6, var_7, var_8, var_9, var_10);
    level.player waittill("BUTTON_AI_DRONE_AMOUNT_DEBUG");
    level notify("stop_ai_drone_debug");
    var_3 destroy();
    var_2 destroy();
    var_4 destroy();
    var_1 destroy();
    var_5 destroy();
    var_6 destroy();
    var_7 destroy();
    var_8 destroy();
    var_9 destroy();
    var_10 destroy();
  }
}

debug_ai_drone_amounts_logic(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_ai_drone_debug");
  var_5 = var_1.color;

  for(;;) {
    var_6 = level.vehicles["allies"];
    var_6 = common_scripts\utility::array_combine(var_6, level.vehicles["axis"]);
    var_7 = getaiarray();
    var_8 = [];
    var_9 = [level.drones["allies"], level.drones["axis"], level.drones["team3"], level.drones["neutral"]];

    foreach(var_11 in var_9)
    var_8 = common_scripts\utility::array_combine(var_8, var_11.array);

    var_0 settext("Vehicles : " + var_6.size);
    var_2 settext("AI : " + var_7.size);
    var_1 settext("Drones : " + var_8.size);
    var_3 settext("Available : " + level.availabledrones);
    var_4 settext("Total : " + (level.availabledrones + var_8.size));

    if(var_8.size > 50)
      var_1.color = (1, 0, 0);
    else
      var_1.color = var_5;

    wait 0.05;
  }
}

ent_count_check(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_ai_drone_debug");
  var_5 = 0;
  var_6 = 50;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    var_10 = getEntArray("script_model", "classname");
    var_11 = getEntArray("script_origin", "classname");
    var_0 settext("models : " + var_10.size);
    var_1 settext("origins : " + var_11.size);
    var_12 = var_10.size + var_11.size;
    var_2 settext("total : " + var_12);
    var_7 = var_7 + var_12;
    var_3 settext("average : " + var_5);
    var_8++;

    if(var_8 == var_6) {
      var_5 = int(var_7 / var_6);
      var_7 = 0;
      var_8 = 0;
    }

    if(var_12 > var_9) {
      var_9 = var_12;
      var_4 settext("highest :" + var_9);
    }

    wait 0.05;
  }
}

end_of_scripting(var_0) {
  var_1 = 7;
  var_2 = 0;

  for(;;) {
    if(var_2 == var_1) {
      break;
    }

    iprintlnbold("end of scripting");

    if(isDefined(var_0))
      iprintlnbold(var_0);

    var_2++;
    wait 3;
  }
}

player_push_quad(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  var_2 = anglesToForward(var_2) * 20;

  for(;;) {
    wait 0.05;
    var_4 = level.player.origin;
    var_5 = 0;

    for(var_6 = 0; var_6 < 3; var_6++) {
      if(var_4[var_6] > var_0[var_6] && var_4[var_6] < var_1[var_6]) {
        if(var_6 == 2)
          var_5 = 1;

        continue;
      }

      break;
    }

    if(var_5) {
      level.player pushplayervector(var_2);
      continue;
    }

    level.player pushplayervector((0, 0, 0));
  }
}

player_kill_quad(var_0, var_1, var_2) {
  level endon(var_2);

  for(;;) {
    wait 0.05;
    var_3 = level.player.origin;
    var_4 = 0;

    for(var_5 = 0; var_5 < 3; var_5++) {
      if(var_3[var_5] > var_0[var_5] && var_3[var_5] < var_1[var_5]) {
        if(var_5 == 2)
          var_4 = 1;

        continue;
      }

      break;
    }

    if(var_4) {
      level.player kill();
      break;
    }
  }
}