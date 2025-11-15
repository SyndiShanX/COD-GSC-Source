/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_gargoyle.gsc
****************************************************/

load_gargoyle_fx() {
  level._effect["gargoyle_darts_fire"] = loadfx("vfx/gameplay/alien/vfx_alien_gargoyle_darts_01");
}

gargoyle_level_init() {
  if(!isDefined(level.alien_funcs))
    level.agent_funcs = [];

  level.alien_funcs["gargoyle"]["approach"] = ::gargoyle_approach;
  level.alien_funcs["gargoyle"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["gargoyle"]["badpath"] = ::handle_badpath;
}

gargoyle_init() {
  var_0 = gettime();
  self.last_stun_time = var_0;
  self.last_hover_attack_time = var_0;
  self.last_strafe_attack_time = var_0;
  self.last_fly_time = var_0;
  self.last_close_range_attack_time = var_0;
  self.last_air_dodge_time = var_0;
  self.in_air = 0;
  self.air_complete = 0;
  self.air_dodge_allowed = 0;
  self.cannothypno = 1;
  self.fly_end_position = undefined;
  setup_hover_turret();

  if(getdvarint("scr_gargoyle_disable_fly_intro") != 1)
    fly_intro_attack(undefined);
}

fly_intro(var_0) {
  self scragentsetphysicsmode("noclip");
  self scragentsetorientmode("face angle abs", self.angles);
  self.fly_end_position = self.origin + anglesToForward(self.angles) * 1600;
  self.in_intro = 1;
  self.in_air = 1;
  self.fly_type = "attack";
  fly(var_0);
  self.air_dodge_allowed = 1;
  thread air_damage_monitor();
  self.air_attacks_available = 0;
  self.in_intro = 0;
}

handle_badpath(var_0) {
  var_1 = 150;
  var_2 = self.origin + (0, 0, var_1);

  if(self.badpathcount > 3) {
    self.badpathcount = 0;
    self.badpath = 0;
    perform_melee(var_0, "takeoff");
    clear_goal_position();
  } else
    maps\mp\agents\alien\_alien_think::handle_badpath(var_0);
}

gargoyle_approach(var_0, var_1) {
  if(is_enemy_vanguard(var_0))
    return approach_vanguard(var_0);
  else
    return approach_enemy(var_0);
}

approach_enemy(var_0) {
  if(should_stun()) {
    if(distancesquared(self.close_proximity_enemy.origin, self.origin) > 22500)
      move_towards_enemy(self.close_proximity_enemy);

    return "stun";
  }

  if(should_begin_air_attacks(var_0)) {
    var_1 = proceed_to_air_node(var_0);

    if(var_1)
      return "takeoff";
  }

  if(should_end_air_attacks(var_0))
    return "land";

  while(self.in_air) {
    if(should_strafe_run(var_0))
      return "strafe_run";

    if(should_fly_to_node(var_0, 800, 1, 350)) {
      self.fly_type = "move";
      return "fly";
    }

    if(should_hover_attack(var_0))
      return "hover_attack";

    wait 0.05;
  }

  return "none";
}

approach_vanguard(var_0) {
  if(should_begin_air_attacks(var_0)) {
    var_1 = proceed_to_air_node(var_0);

    if(var_1)
      return "takeoff";
  }

  while(self.in_air) {
    if(should_fly_to_node(var_0, 1600, 1, 0)) {
      self.fly_type = "attack";
      return "fly";
    }

    if(should_hover_attack(var_0))
      return "hover_attack";

    wait 0.05;
  }

  return "none";
}

find_air_attack_node(var_0) {
  var_1 = getnodesinradius(var_0.origin, 1600.0, 700.0, 512, "jump");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "flyable")
      var_2[var_2.size] = var_4;
  }

  var_6 = get_air_node_rated(var_0, var_2);
  return var_6;
}

get_air_node_rated(var_0, var_1) {
  var_2 = [];
  var_2["direction"] = "override";
  var_2["direction_override"] = vectornormalize(self.origin - var_0.origin);
  var_2["direction_weight"] = 3.0;
  var_2["min_height"] = 0.0;
  var_2["max_height"] = 512.0;
  var_2["height_weight"] = 1.0;
  var_2["enemy_los"] = 1;
  var_2["enemy_los_weight"] = 10.0;
  var_2["min_dist_from_enemy"] = 700.0;
  var_2["max_dist_from_enemy"] = 1600.0;
  var_2["desired_dist_from_enemy"] = 600.0;
  var_2["dist_from_enemy_weight"] = 4.0;
  var_2["min_dist_from_all_enemies"] = 200.0;
  var_2["min_dist_from_all_enemies_weight"] = 1.0;
  var_2["not_recently_used_weight"] = 5.0;
  var_2["random_weight"] = 1.0;
  var_2["test_offset"] = (0, 0, 128);
  return maps\mp\agents\alien\_alien_think::get_retreat_node_rated(var_0, var_2, var_1);
}

move_towards_enemy(var_0) {
  var_1 = maps\mp\agents\alien\_alien_think::do_initial_approach(var_0);
  maps\mp\agents\alien\_alien_think::go_for_swipe(var_0, var_1);
}

can_do_pain(var_0) {
  switch (var_0) {
    case "move":
      return 0;
    case "idle":
    case "melee":
      return !self.in_air;
    default:
      return 1;
  }
}

get_pain_anim_state(var_0) {
  switch (var_0) {
    case "idle":
      return get_idle_pain_anim_state();
    default:
      return undefined;
  }
}

get_idle_pain_anim_state() {
  if(!self.in_air)
    return undefined;

  return "idle_fly_pain";
}

should_immediate_ragdoll_on_death() {
  if(self.in_air)
    return 1;

  return undefined;
}

get_turn_in_place_anim_state() {
  if(!self.in_air)
    return undefined;

  return "air_turn_in_place";
}

can_retreat(var_0) {
  return !self.in_air;
}

should_begin_air_attacks(var_0) {
  if(self.in_air)
    return 0;

  var_1 = find_air_attack_node(var_0);

  if(!isDefined(var_1))
    return 0;

  self.air_jump_node = var_1;
  return 1;
}

should_end_air_attacks(var_0) {
  if(!self.in_air)
    return 0;

  return self.air_complete;
}

should_hover_attack(var_0) {
  if(!isalive(var_0))
    return 0;

  if(gettime() < self.last_hover_attack_time + 3000)
    return 0;

  var_1 = self gettagorigin("TAG_tail");
  var_2 = get_enemy_target_position(var_0);
  var_3 = bullettracepassed(var_1, var_2, 0, undefined);
  wait 0.05;
  return var_3;
}

should_stun(var_0) {
  return isDefined(self.close_proximity_enemy) && !self.in_air;
}

should_close_range_attack() {
  return !self.in_air && gettime() > self.last_close_range_attack_time + 8000;
}

is_enemy_vanguard(var_0) {
  return isDefined(var_0.helitype) && var_0.helitype == "remote_uav";
}

get_possible_fly_node_points(var_0, var_1) {
  var_2 = anglestoright(self.angles);
  var_3 = anglesToForward(self.angles);
  var_4 = [];
  var_4[0] = self.origin + var_3 * var_1 + var_0;
  var_4[1] = self.origin + var_2 * var_1 + var_0;
  var_4[2] = self.origin + var_2 * -1 * var_1 + var_0;
  var_4[3] = self.origin + vectornormalize(var_2 + var_3) * var_1 + var_0;
  var_4[4] = self.origin + vectornormalize(var_2 * -1 + var_3) * var_1 + var_0;
  var_4 = common_scripts\utility::array_randomize(var_4);
  return var_4;
}

should_fly_to_node(var_0, var_1, var_2, var_3) {
  var_4 = 0.939;
  var_5 = 75;
  var_6 = -300;
  var_7 = 90000;

  if(gettime() <= self.last_fly_time + 6000)
    return 0;

  var_8 = (0, 0, max(var_6, var_0.origin[2] - self.origin[2]) + var_3);
  var_9 = get_possible_fly_node_points(var_8, var_1);
  var_10 = undefined;

  for(var_11 = 0; var_11 < var_9.size; var_11++) {
    var_12 = var_9[var_11];
    var_13 = vectornormalize(var_0.origin - self.origin);
    var_14 = vectornormalize(var_12 - self.origin);
    var_15 = vectordot(var_13, var_14) > var_4 && abs(var_8[2]) < var_5 || distancesquared(var_0.origin, var_12) < var_7;

    if(!var_15 && self aiphysicstracepassed(self.origin, var_12, self.radius, self.height, 1)) {
      if(!var_2 || has_valid_ground_nodes(var_12)) {
        var_10 = var_12;
        break;
      }
    }

    wait 0.05;
  }

  self.fly_end_position = var_10;
  return isDefined(self.fly_end_position);
}

should_strafe_run(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = self.origin;

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 1000000;
  var_4 = 90000;
  var_5 = distance2dsquared(var_0.origin, self.origin);

  if(var_5 > var_3 || var_5 < var_4)
    return 0;

  var_6 = 1150;

  if(!var_2 && gettime() <= self.last_strafe_attack_time + 12000)
    return 0;

  var_7 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_8 = var_1 + var_7 * var_6;

  if(!self aiphysicstracepassed(var_1, var_8, self.radius, self.height, 1))
    return 0;

  return has_valid_ground_nodes(var_8);
}

has_valid_ground_nodes(var_0) {
  var_1 = 1000;
  var_2 = var_0 - (0, 0, var_1);
  var_3 = bulletTrace(var_0, var_2, 0);
  var_4 = getnodesinradius(var_3["position"], 500, 0, 128);
  return isDefined(var_4) && var_4.size > 0;
}

air_damage_monitor() {
  self endon("death");
  self endon("air_complete");
  var_0 = [];

  for(;;) {
    self waittill("damage", var_1);

    if(!self.air_dodge_allowed) {
      continue;
    }
    var_2 = gettime();
    var_3 = var_2 - 1200;

    for(var_4 = var_0.size - 1; var_4 >= 0; var_4--) {
      if(var_0[var_4]["time"] > var_3) {
        continue;
      }
      var_0 = maps\mp\alien\_utility::array_remove_index(var_0, var_4);
    }

    var_5 = var_0.size;
    var_0[var_5]["time"] = var_2;
    var_0[var_5]["damage"] = var_1;
    var_6 = 0;

    for(var_4 = 0; var_4 < var_0.size; var_4++)
      var_6 = var_6 + var_0[var_4]["damage"];

    if(var_6 > 100) {
      try_damage_air_dodge();
      wait 0.2;
    }
  }
}

proceed_to_air_node(var_0) {
  self endon("death");
  self scragentsetgoalnode(self.air_jump_node);
  self scragentsetgoalradius(32);
  thread check_player_proximity();
  var_1 = common_scripts\utility::waittill_any_return("goal_reached", "close_range_attack");

  if(var_1 == "close_range_attack")
    return 0;

  self notify("at_air_node");

  if(isDefined(var_0)) {
    maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
    self scragentsetorientmode("face enemy");
  }

  clear_goal_position();
  return 1;
}

check_player_proximity() {
  self endon("death");
  self endon("at_air_node");
  self endon("alien_main_loop_restart");
  var_0 = 300;

  for(;;) {
    if(should_close_range_attack()) {
      foreach(var_2 in level.players) {
        if(distancesquared(self.origin, var_2.origin) < var_0 * var_0) {
          close_proximity_attack(var_2);
          return;
        }
      }
    }

    wait 0.1;
  }
}

close_proximity_attack(var_0) {
  self.close_proximity_enemy = var_0;
  clear_goal_position();
  self notify("alien_main_loop_restart");
}

air_dodge(var_0) {
  var_1 = "air_dodge";
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_1, self.air_dodge_index, var_1);
  clear_goal_position();
  self.last_air_dodge_time = gettime();
}

takeoff(var_0) {
  var_1 = "ground_takeoff";
  self.in_air = 1;
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_1, 0, var_1);
  self.air_dodge_allowed = 1;
  thread air_damage_monitor();
  self.air_attacks_available = 0;
  clear_goal_position();
}

do_takeoff_lerp(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 64.0;
  var_4 = 0.4;
  var_5 = self getanimentry(var_0, var_1);
  var_6 = getanimlength(var_5);
  var_7 = getmovedelta(var_5);
  var_8 = var_7[2];
  var_9 = randomfloat(var_3);
  var_10 = self localtoworldcoords(var_7) + (0, 0, var_9);

  if(!bullettracepassed(var_10, var_2.origin, 0, undefined)) {
    return;
  }
  var_11 = getmovedelta(var_5, 0.0, var_4);
  var_12 = self localtoworldcoords(var_11);
  var_12 = (var_12[0], var_12[1], var_12[2] + var_9);
  var_13 = var_6 * var_4;
  self scragentdoanimlerp(self.origin, var_12, var_13);
  wait(var_13);
  self scragentsetanimmode("anim deltas");
}

clear_goal_position() {
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(4096);
}

land(var_0) {
  self endon("death");
  var_1 = "ground_landing";
  self scragentsetorientmode("face angle abs", self.angles);
  self notify("air_complete");
  thread do_landing_lerp(var_1, 0);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_1, 0, var_1);
  self.in_air = 0;
  self.air_complete = 0;
  clear_goal_position();
}

do_landing_lerp(var_0, var_1) {
  var_2 = 1000;
  var_3 = 100;
  var_4 = 0.4;
  var_5 = 10;
  var_6 = self.origin - (0, 0, var_2);
  var_7 = self.origin + (0, 0, var_3);
  var_8 = self aiphysicstrace(var_7, var_6, self.radius, self.height, 1);
  var_9 = self getanimentry(var_0, var_1);
  var_10 = getanimlength(var_9);
  var_11 = getmovedelta(var_9, var_4, 1.0);
  var_12 = length(var_11 * (0, 0, 1));
  var_13 = var_8 + (0, 0, var_12 + var_5);
  var_14 = var_10 * var_4;
  self scragentdoanimlerp(self.origin, var_13, var_14);
  wait(var_14);
  self scragentsetanimmode("anim deltas");
}

gargoyle_idle_state(var_0) {
  if(self.in_air)
    return "idle_fly";

  return undefined;
}

run_to_swipe(var_0) {
  maps\mp\agents\alien\_alien_think::run_near_enemy(150, var_0);
  return 1;
}

stun_attack(var_0) {
  perform_melee(var_0, "stun");
}

wing_swipe_attack(var_0) {
  perform_melee(var_0, "wing_swipe");
}

hover_attack(var_0) {
  perform_melee(var_0, "hover_attack");
}

strafe_run_attack(var_0) {
  perform_melee(var_0, "strafe_run");
}

takeoff_attack(var_0) {
  perform_melee(var_0, "takeoff");
}

landing_attack(var_0) {
  perform_melee(var_0, "land");
}

fly_attack(var_0) {
  perform_melee(var_0, "fly");
}

fly_intro_attack(var_0) {
  perform_melee(var_0, "fly_intro");
}

perform_melee(var_0, var_1) {
  self.melee_type = var_1;

  if(!isDefined(var_0)) {
    var_0 = findanenemy();

    if(!isDefined(var_0))
      return;
  }

  if(maps\mp\agents\alien\_alien_think::melee_okay()) {
    self scragentbeginmelee(var_0);
    self scragentsetgoalpos(self.origin);
    self scragentsetgoalradius(4096.0);
    self waittill("melee_complete");
  } else
    wait 0.2;
}

findanenemy() {
  if(isDefined(self.enemy))
    return self.enemy;

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      return var_1;
  }

  return undefined;
}

stun(var_0) {
  self endon("death");
  self endon("melee_pain_interrupt");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
  self scragentsetorientmode("face enemy");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_ground_whip", 0, "attack_melee", undefined, ::handlestunnotetracks);
  maps\mp\agents\alien\_alien_melee::move_back(var_0, 1);
  self.close_proximity_enemy = undefined;
  self.last_stun_time = gettime();
  self.last_close_range_attack_time = gettime();
}

handlestunnotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "ground_whip":
      stun_enemy(self.close_proximity_enemy);
      break;
  }
}

stun_enemy(var_0) {
  var_1 = 3.0;

  if(isplayer(var_0) && isalive(var_0))
    maps\mp\agents\alien\_alien_melee::melee_dodamage(var_0, "swipe");
}

wing_swipe(var_0) {
  self endon("death");
  self endon("melee_pain_interrupt");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
  self scragentsetorientmode("face enemy");
  maps\mp\agents\alien\_alien_melee::try_preliminary_swipes("swipe", var_0, 125, 150);
  maps\mp\agents\alien\_alien_melee::move_back(var_0, 1);
  self.last_close_range_attack_time = gettime();
}

hover(var_0) {
  self endon("death");
  self endon("damage_dodge_interrupt");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
  self scragentsetorientmode("face enemy");

  if(gettime() > self.last_air_dodge_time + 1500)
    var_1 = 0;
  else
    var_1 = 1;

  var_2 = get_hover_start_anim_mode("attack_air_hover_spit_start", var_1);
  self scragentsetanimmode(var_2);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_air_hover_spit_start", var_1, "attack_melee");
  var_3 = "hover_spit_end";
  self scragentsetanimmode("anim deltas");

  if(isDefined(var_0)) {
    thread hover_spit(var_0, var_3);
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_air_hover_spit_loop", 0, "attack_melee");
  }

  self notify(var_3);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_air_hover_spit_stop", 0, "attack_melee");
  self.last_hover_attack_time = gettime();
  register_air_attack_end(var_0);

  if(!self.air_complete && isDefined(var_0))
    try_air_dodge(var_0);
}

get_hover_start_anim_mode(var_0, var_1) {
  var_2 = self getanimentry(var_0, var_1);
  var_3 = getmovedelta(var_2);
  var_4 = self localtoworldcoords(var_3);

  if(self aiphysicstracepassed(self.origin, var_4, self.radius, self.height, 1))
    return "anim deltas";

  return "code_move";
}

try_air_dodge(var_0) {
  var_1 = randomint(3);
  return do_dodge(var_0, var_1);
}

try_air_dodge_up(var_0) {
  var_1 = randomint(2) + 2;
  return do_dodge(var_0, var_1);
}

do_dodge(var_0, var_1) {
  var_2 = "air_dodge";
  var_3 = self getanimentry(var_2, var_1);
  var_4 = getmovedelta(var_3);
  var_5 = length(var_4);
  var_6 = vectornormalize(var_4) * (var_5 + 50);
  var_7 = self localtoworldcoords(var_6);

  if(!self aiphysicstracepassed(self.origin, var_7, self.radius, self.height, 1))
    return 0;

  if(!bullettracepassed(var_7, get_enemy_target_position(var_0), 0, undefined))
    return 0;

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_2, var_1, var_2);
  clear_goal_position();
  return 1;
}

try_damage_air_dodge() {
  var_0 = "air_dodge";
  var_1 = [0, 1, 2, 3, 4, 5];
  var_1 = common_scripts\utility::array_randomize(var_1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = self getanimentry(var_0, var_3);
    var_5 = getmovedelta(var_4);
    var_6 = length(var_5);
    var_7 = vectornormalize(var_5) * (var_6 + 50);
    var_8 = self localtoworldcoords(var_7);

    if(self aiphysicstracepassed(self.origin, var_8, self.radius, self.height, 1)) {
      if(!isDefined(self.enemy) || bullettracepassed(var_8, get_enemy_target_position(self.enemy), 0, undefined)) {
        self.air_dodge_index = var_3;
        perform_melee(self.enemy, "air_dodge");
        break;
      } else {
        register_air_attack_end(self.enemy, 1);
        self notify("damage_dodge_interrupt");

        if(self.statelocked)
          self.statelocked = 0;

        break;
      }
    }

    wait 0.05;
  }
}

get_enemy_target_position(var_0) {
  if(issentient(var_0)) {
    if(!isDefined(var_0.usingremote))
      return var_0 getEye();
    else
      return var_0.origin + (0, 0, 32);
  }

  return var_0.origin;
}

hover_spit(var_0, var_1) {
  self endon(var_1);
  self endon("death");
  self endon("melee_pain_interrupt");
  self endon("killanimscript");
  self endon("damage_dodge_interrupt");
  var_2 = get_enemy_target_position(var_0);
  var_3 = "hover_spit_complete";

  for(;;) {
    if(isDefined(var_0))
      var_2 = get_enemy_target_position(var_0);

    fire_weapon(var_2, 0.2, var_1);
  }

  self notify(var_3);
}

fire_weapon(var_0, var_1, var_2) {
  if(isDefined(self) && isDefined(self.shooting_target)) {
    self.shooting_target.origin = var_0;
    self.hover_turret settargetentity(self.shooting_target);
    self.hover_turret shootturret();
    wait(var_1);
  }
}

fly(var_0) {
  self endon("death");
  self.air_dodge_allowed = 0;
  var_1 = self.fly_end_position - self.origin;
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_1);
  self scragentsetorientmode("face angle abs", vectortoangles(var_1));
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_fly_start", 0, "attack_melee");

  if(self.fly_type == "attack")
    fly_loop();

  var_2 = get_fly_end_anim(var_0);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_2, 0, "attack_melee");
  self.last_fly_time = gettime();
  register_air_attack_end(var_0, 0);
}

fly_loop() {
  var_0 = randomint(self getanimentrycount("attack_fly_loop"));
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_fly_loop", var_0, "attack_melee");
}

strafe_run(var_0) {
  self endon("death");
  self.air_dodge_allowed = 0;
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetanimmode("anim deltas");
  var_1 = "strafe_run_complete";
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_strafe_run_start", 0, "attack_melee");
  thread strafing_shoot(var_0, var_1);
  var_2 = maps\mp\agents\_scriptedagents::getrandomanimentry("attack_strafe_run_loop");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_strafe_run_loop", var_2, "attack_melee");
  self notify(var_1);
  var_3 = get_fly_end_anim(var_0);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_3, 0, "attack_melee");
  self.last_strafe_attack_time = gettime();
  register_air_attack_end(var_0);
}

get_fly_end_anim(var_0) {
  var_1 = vectornormalize(var_0.origin - self.origin);
  var_2 = anglesToForward(self.angles);

  if(vectordot(var_1, var_2) > 0.0)
    return "attack_fly_stop";

  return "attack_strafe_run_stop";
}

strafing_shoot(var_0, var_1) {
  self endon(var_1);
  self endon("death");
  self endon("melee_pain_interrupt");
  self endon("killanimscript");
  self endon("damage_dodge_interrupt");

  if(isDefined(var_0))
    self.hover_turret settargetentity(var_0);

  var_2 = 0.2;
  var_3 = 300;
  var_4 = 300;
  var_5 = 20;
  var_6 = vectornormalize(anglesToForward(self.angles) * (1, 1, 0));
  var_7 = vectortoangles(var_6);
  var_8 = var_6;
  wait(var_2);

  for(;;) {
    if(isDefined(var_0)) {
      var_9 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));
      var_10 = vectortoangles(var_9);

      if(anglesdelta(var_10, var_7) > var_5)
        var_9 = var_8;
    } else
      var_9 = var_8;

    var_11 = self.origin + var_9 * var_3 - (0, 0, var_4);
    fire_weapon(var_11, 0.05, var_1);
    var_8 = var_9;
  }
}

strafe_run_loop() {
  var_0 = randomint(3);

  if(var_0 == 0)
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_strafe_run_loop_single", var_0, "attack_melee");
  else {
    var_1 = var_0 - 1;
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_strafe_run_loop_multi_start", var_1, "attack_melee");
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_strafe_run_loop_multi_loop", var_1, "attack_melee");
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_strafe_run_loop_multi_exit", var_1, "attack_melee");
  }
}

register_air_attack_end(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getdvarint("scr_gargoyle_disable_fly_intro") != 1 && self.in_intro;
  var_3 = !var_1 && randomfloat(1.0) < 0.85 || var_2;

  if(var_3 && isDefined(var_0)) {
    var_4 = self.origin[2] - var_0.origin[2];

    if(var_4 > 800)
      var_3 = 0;
    else if(var_4 < 100)
      var_3 = try_air_dodge_up(var_0);
  }

  if(var_3) {
    var_5 = 100;
    var_6 = self.origin - (0, 0, var_5);

    if(!self aiphysicstracepassed(self.origin, var_6, self.radius, self.height, 1))
      var_3 = try_air_dodge_up(var_0);
  }

  self.air_complete = !var_3;
  clear_goal_position();
  self.idle_state_locked = !self.air_complete;
  self.air_dodge_allowed = !self.air_complete;
}

setup_hover_turret() {
  self.hover_turret = [];
  var_0 = "TAG_tail";
  self.hover_turret = spawnturret("misc_turret", self gettagorigin(var_0), "gargoyle_beam_mp");
  self.hover_turret linkto(self, var_0);
  self.hover_turret setModel("gargoyle_beam_gun");
  self.hover_turret.angles = self gettagangles(var_0);
  self.hover_turret.team = "axis";
  self.hover_turret maketurretinoperable();
  self.hover_turret makeunusable();
  self.hover_turret.health = 1000000;
  self.hover_turret.maxhealth = 1000000;
  self.hover_turret setmode("manual");
  self.hover_turret setturretteam("axis");
  self.shooting_target = spawn("script_origin", self.origin);
  thread clean_up_turret();
}

clean_up_turret() {
  var_0 = self.hover_turret;
  self waittill("death");

  if(isDefined(var_0))
    var_0 delete();
}