/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1552.gsc
**************************************/

squad_setup(var_0) {
  if(!common_scripts\utility::flag_exist("squad_spawning")) {
    common_scripts\utility::flag_init("squad_spawning");
  }
  level.new_squad_logic = 1;
  level.merge_squad_member_max = 3;
  level.leaders = [];

  if(isDefined(var_0) && var_0) {
    var_1 = common_scripts\utility::getStructArray("leader", "script_noteworthy");
  } else {
    var_1 = getEntArray("leader", "script_noteworthy");
  }
  foreach(var_3 in var_1) {
    if(isDefined(var_3.targetname) && issubstr(var_3.targetname, "protector")) {
      var_1 = common_scripts\utility::array_remove(var_1, var_3);
    }
  }

  level.squad_follower_func = ::setup_follower_advanced;
  thread merge_squad();
  thread squad_spread();
  thread drawleader();
  return var_1;
}

squad_disband(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  if(common_scripts\utility::flag_exist("squad_spawning")) {
    common_scripts\utility::flag_waitopen("squad_spawning");
  }
  level notify("squad_disband");
  level.leaders = [];

  if(isDefined(var_1)) {
    var_3 = getaiarray("axis");

    foreach(var_5 in var_3) {
      var_5 notify("ai_behavior_change");
      var_5.leader = undefined;
      var_5.squadmembers = undefined;

      if(isDefined(var_5.is_squad_enemy) && var_5.is_squad_enemy) {
        if(isDefined(var_2)) {
          var_5 thread[[var_1]](var_2);
        } else {
          var_5 thread[[var_1]]();
        }
      }

      var_5.is_squad_enemy = 0;
    }
  }
}

setup_zones(var_0, var_1) {
  level endon("challenge_success");
  level endon("special_op_terminated");

  if(!common_scripts\utility::flag_exist("squad_spawning")) {
    common_scripts\utility::flag_init("squad_spawning");
  }
  var_2 = var_0 common_scripts\utility::get_links();
  var_3 = [];

  foreach(var_5 in var_2) {}
  var_3[var_3.size] = getEnt(var_5, "script_linkname");

  var_0 thread one_direction_trigger();
  var_0 waittill("trigger");

  if(getaiarray("axis").size > 1) {
    level.cleaning_up = 1;
    squad_clean_up();
    wait 2.02;
  } else {
    level.cleaning_up = 0;
  }
  if(level.leaders.size + var_1 > level.desired_squads) {
    var_1 = level.desired_squads - level.leaders.size;
  }
  for(var_7 = 0; var_7 < var_1; var_7++) {
    spawn_far_squad(var_3, undefined, undefined, undefined);
  }
  wait 1;
  level.cleaning_up = 0;
  level notify("clean_up_done");
  level notify("zone_spawn_complete");
}

spawn_enemy_squads(var_0) {
  level endon("challenge_success");
  level endon("special_op_terminated");
  var_1 = squad_setup();

  if(!isDefined(level.desired_squads)) {
    level.desired_squads = 4;
  } else {
    var_2 = "Must have at least 4 squad leader spawners in level";
  }
  if(isDefined(level.squad_zoning) && level.squad_zoning) {
    var_3 = getEntArray("zone_trig", "targetname");

    foreach(var_5 in var_3) {}
    thread setup_zones(var_5, int(var_5.script_noteworthy));

    level waittill("zone_spawn_complete");
  }

  for(;;) {
    wait 0.15;

    if(isDefined(level.cleaning_up) && level.cleaning_up) {
      level waittill("clean_up_done");
    }
    if(level.leaders.size < level.desired_squads) {
      spawn_far_squad(var_1, undefined, undefined, var_0);
    }
  }
}

spawn_far_squad(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[var_4.size] = level.player;

  if(maps\_utility::is_coop()) {
    var_4[var_4.size] = level.players[1];
  }
  foreach(var_6 in level.leaders) {}
  var_4[var_4.size] = var_6;

  var_8 = undefined;

  while(var_0.size > 1) {
    foreach(var_10 in var_4) {
      var_8 = maps\_utility::getclosest(var_10.origin, var_0);
      var_0 = common_scripts\utility::array_remove(var_0, var_8);

      if(var_0.size == 1) {
        break;
      }
    }
  }

  var_8 = var_0[0];
  thread draw_debug_marker(var_8.origin, (1, 1, 1));

  if(isspawner(var_0[0])) {
    var_12 = getEntArray(var_8.target, "targetname");
  } else {
    var_12 = common_scripts\utility::getStructArray(var_8.target, "targetname");
  }
  var_12[var_12.size] = var_8;

  foreach(var_14 in var_12) {
    if(!isDefined(var_14.script_noteworthy)) {
      var_14.script_noteworthy = "follower";
    }
  }

  common_scripts\utility::flag_set("squad_spawning");
  var_16 = [];
  var_16 = spawn_enemy_group(var_12, var_1, var_2, var_3);
  common_scripts\utility::flag_clear("squad_spawning");
  wait 0.05;
  return var_16;
}

squad_clean_up() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.protector_obj_group)) {
      var_0 = common_scripts\utility::array_remove(var_0, var_2);
    }
  }

  thread maps\_utility::ai_delete_when_out_of_sight(var_0, 1300);
}

squad_spread() {
  level endon("challenge_success");
  level endon("special_op_terminated");

  for(;;) {
    wait 1;

    if(!isDefined(level.leaders)) {
      continue;
    }
    if(level.leaders.size < 2) {
      continue;
    }
    foreach(var_1 in level.leaders) {
      if(!isDefined(var_1.squadmembers) || var_1.squadmembers.size < 2) {
        continue;
      }
      foreach(var_3 in level.leaders) {
        if(var_3 == var_1) {
          continue;
        }
        if(!isDefined(var_3.squadmembers) || var_3.squadmembers.size < 2) {
          continue;
        }
        if(distance(var_1.origin, var_3.origin) < 600) {
          foreach(var_5 in var_3.squadmembers) {
            if(isDefined(var_5.saw_player) && var_5.saw_player) {
              var_5.goalradius = 800;
            }
          }

          continue;
        }

        foreach(var_5 in var_3.squadmembers) {
          if(isDefined(var_5.saw_player) && var_5.saw_player) {
            var_5.goalradius = 600;
          }
        }
      }
    }
  }
}

merge_squad() {
  level endon("challenge_success");
  level endon("special_op_terminated");

  for(;;) {
    wait 2;

    if(!isDefined(level.leaders)) {
      continue;
    }
    if(level.leaders.size < 2) {
      continue;
    }
    var_0 = level.leaders[0];

    foreach(var_2 in level.leaders) {
      if(var_0.squadmembers.size > var_2.squadmembers.size) {
        var_0 = var_2;
      }
    }

    var_4 = common_scripts\utility::array_remove(level.leaders, var_0);
    var_5 = var_4[0];

    foreach(var_2 in var_4) {
      if(var_5.squadmembers.size > var_2.squadmembers.size) {
        var_5 = var_2;
      }
    }

    var_8 = var_0.squadmembers.size + var_5.squadmembers.size + 2;

    if(var_8 <= 3) {
      level.leaders = common_scripts\utility::array_remove(level.leaders, var_0);
      var_0 notify("demotion");
      var_9 = common_scripts\utility::array_combine(var_0.squadmembers, var_5.squadmembers);
      var_9[var_9.size] = var_0;
      var_9[var_9.size] = var_5;
      var_5 thread setup_leader(var_9);
      var_10 = common_scripts\utility::array_remove(var_9, var_5);

      foreach(var_12 in var_10) {
        if(isalive(var_12)) {
          var_12 thread setup_follower(var_5);
        }
      }
    }
  }
}

spawn_enemy_group(var_0, var_1, var_2, var_3) {
  level endon("challenge_success");
  level endon("special_op_terminated");
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = 1;
  }
  if(!isDefined(level.leaders)) {
    level.leaders = [];
  }
  if(!isDefined(var_3)) {
    var_3 = var_0.size - 1;
  } else {
    var_3 = int(min(var_0.size - 1, var_3));
  }
  var_5 = "Trying to spawn " + var_3 + " followers but only " + (var_0.size - 1) + " spawners are available!";

  if(var_4 || !isspawner(var_0[0])) {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = getspawnerarray();

    foreach(var_10 in var_8) {
      if(var_10.classname == var_1) {
        var_6 = var_10;
      }
      if(var_10.classname == var_2) {
        var_7 = var_10;
      }
    }

    var_12 = 0;
    var_13 = [];

    foreach(var_15 in var_0) {
      wait 0.05;

      if(var_15.script_noteworthy == "leader") {
        var_6.script_noteworthy = "leader";
        var_6.count = 1;
        var_6.origin = var_15.origin;
        var_6.angles = var_15.angles;
        var_16 = var_6 maps\_utility::spawn_ai(1);
        var_13[var_13.size] = var_16;
      }

      if(var_15.script_noteworthy == "follower") {
        if(var_12 >= var_3) {
          continue;
        }
        var_12++;
        var_7.script_noteworthy = "follower";
        var_7.count = 1;
        var_7.origin = var_15.origin;
        var_7.angles = var_15.angles;
        var_16 = var_7 maps\_utility::spawn_ai(1);
        var_13[var_13.size] = var_16;
      }
    }
  } else {
    var_12 = 0;
    var_13 = [];

    foreach(var_15 in var_0) {
      if(var_15.script_noteworthy == "follower") {
        var_12++;
      }
      if(var_12 >= var_3) {
        continue;
      }
      var_15.count = 1;
      var_16 = var_15 maps\_utility::spawn_ai(1);
      var_13[var_13.size] = var_16;
    }
  }

  if(!var_13.size) {
    return undefined;
  }
  var_20 = [];

  foreach(var_16 in var_13) {
    var_16.is_squad_enemy = 1;

    if(isalive(var_16)) {
      var_20[var_20.size] = var_16;
    }
  }

  var_13 = var_20;
  var_23 = undefined;

  foreach(var_16 in var_13) {
    if(var_16.script_noteworthy == "leader") {
      var_23 = var_16;
      var_23.back_occupied["left"] = 0;
      var_23.back_occupied["right"] = 0;
      var_23 thread setup_leader(var_13);
    }
  }

  if(var_13.size < var_0.size && !isDefined(var_23)) {
    var_23 = var_13[randomint(var_13.size)];
    var_23.script_noteworthy = "leader";
    var_23 thread setup_leader(var_13);
  }

  foreach(var_16 in var_13) {
    if(isDefined(level.squad_drop_weapon_rate)) {
      var_27 = randomfloat(1);

      if(var_27 > level.squad_drop_weapon_rate) {
        var_16.dropweapon = 0;
      }
    }

    if(var_16.script_noteworthy == "follower") {
      var_16 thread setup_follower(var_23);
    }
  }

  return var_13;
}

setup_leader(var_0) {
  level endon("squad_disband");
  self notify("new_leader");
  self endon("new_leader");
  self endon("demotion");
  self.squadmembers = [];
  self.leader = undefined;

  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      var_0 common_scripts\utility::array_remove(var_0, var_2);
    }
  }

  if(!isDefined(level.new_squad_logic) || level.new_squad_logic == 0) {
    if(var_0.size == 1 && level.leaders.size > 0) {
      var_4 = level.leaders[0];

      if(level.leaders.size > 1) {
        var_4 = maps\_utility::get_closest_living(self.origin, level.leaders);
      }
      setup_follower(var_4);
      return;
    }
  }

  if(!maps\_utility::is_in_array(level.leaders, self)) {
    level.leaders[level.leaders.size] = self;
  }
  if(isDefined(level.squad_leader_behavior_func)) {
    self thread[[level.squad_leader_behavior_func]]();
  } else {
    self.goalradius = 2048;
    var_5 = maps\_utility::getclosest(self.origin, level.players);
    self.favoriteenemy = var_5;
    self setgoalentity(var_5);
    self setengagementmindist(300, 200);
    self setengagementmaxdist(512, 720);
  }

  thread wait_for_followers();
  thread enlarge_follower_goalradius_upon_seeing_player();

  if(!isDefined(level.new_squad_logic) || level.new_squad_logic == 0) {
    thread handle_all_followers_dying(var_0);
  }
  self waittill("death");
  var_6 = [];

  foreach(var_4 in level.leaders) {
    if(isDefined(var_4) && isalive(var_4)) {
      var_6[var_6.size] = var_4;
    }
  }

  level.leaders = var_6;
  var_4 = undefined;

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      if(!isDefined(var_4)) {
        var_4 = var_2;
        var_2 notify("promotion");
        var_2 thread setup_leader(var_0);
        continue;
      }

      var_2 thread setup_follower(var_4);
    }
  }
}

enlarge_follower_goalradius_upon_seeing_player() {
  level endon("squad_disband");
  self endon("new_leader");
  self endon("demotion");
  self endon("death");
  self waittill("enemy_visible");

  if(isDefined(self.squadmembers) && self.squadmembers.size) {
    foreach(var_1 in self.squadmembers) {}
    var_1 notify("leader_saw_player");
  }
}

wait_for_followers() {
  level endon("squad_disband");
  self endon("new_leader");
  self endon("demotion");
  self endon("death");
  var_0 = self.moveplaybackrate;

  for(;;) {
    wait 2;

    if(isDefined(self.squadmembers) && self.squadmembers.size) {
      var_1 = maps\_utility::get_closest_living(self.origin, self.squadmembers);

      if(isDefined(var_1) && distance(var_1.origin, self.origin) > 256) {
        self.moveplaybackrate = 0.85 * var_0;
      } else {
        self.moveplaybackrate = var_0;
      }
    }
  }
}

setup_follower(var_0) {
  level endon("squad_disband");
  self notify("assigned_new_leader");
  self endon("assigned_new_leader");
  self endon("death");
  self endon("promotion");
  self.squadmembers = undefined;
  self.leader = var_0;
  thread leader_follower_count(var_0);

  if(isDefined(level.attributes_func)) {
    self[[level.attributes_func]]();
  }
  if(isDefined(level.squad_follower_func)) {
    self[[level.squad_follower_func]](var_0);
  } else {
    thread follow_leader_regular(var_0);
  }
}

leader_follower_count(var_0) {
  level endon("squad_disband");
  self endon("assigned_new_leader");
  var_0 endon("death");
  var_0.squadmembers[var_0.squadmembers.size] = self;
  self waittill("death");

  if(!isDefined(self.leader)) {
    return;
  }
  if(isalive(self.leader) && isDefined(self.leader.squadmembers) && self.leader.squadmembers.size > 0) {
    var_1 = [];

    foreach(var_3 in var_0.squadmembers) {
      if(isalive(var_3)) {
        var_1[var_1.size] = var_3;
      }
    }

    var_0.squadmembers = var_1;
  }
}

setup_follower_advanced(var_0) {
  if(is_riotshield(var_0)) {
    var_0.goalradius = 1300;
    var_1 = undefined;

    if(!var_0.back_occupied["right"] && !var_0.back_occupied["left"]) {
      if(common_scripts\utility::cointoss()) {
        follow_leader_riotshield("left");
      } else {
        follow_leader_riotshield("right");
      }
      return;
    }

    if(var_0.back_occupied["right"] && var_0.back_occupied["left"]) {
      follow_leader_regular();
      return;
    }

    if(!var_0.back_occupied["right"] && var_0.back_occupied["left"]) {
      follow_leader_riotshield("right");
      return;
    }

    if(var_0.back_occupied["right"] && !var_0.back_occupied["left"]) {
      follow_leader_riotshield("left");
      return;
      return;
    }
  } else {
    follow_leader_regular();
  }
}

follow_leader_riotshield(var_0) {
  level endon("squad_disband");
  self endon("death");
  self endon("promotion");
  self.goalradius = 128;
  self.pathenemyfightdist = 192;
  self.pathenemylookahead = 192;
  self.favoriteenemy = undefined;
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 720);
  self.leader.back_occupied[var_0] = 1;
  self.is_occupying = var_0;
  thread setup_follower_goalradius_riotshield();

  for(;;) {
    var_1 = self.leader get_riotshield_back_pos(var_0, 0);

    if(!isDefined(var_1)) {
      follow_leader_regular();
      return;
    }

    var_2 = self.leader.origin;
    wait 0.2;

    while(isDefined(self.leader) && isalive(self.leader) && distance(self.leader.origin, var_2) < 2) {
      var_2 = self.leader.origin;
      wait 0.2;
    }

    if(!isalive(self.leader) || !isDefined(var_1)) {
      self setgoalpos(self.origin);
      continue;
    }

    self setgoalpos(var_1);
  }
}

follow_leader_regular() {
  level endon("squad_disband");
  self endon("death");
  self endon("promotion");
  self.goalradius = 128;
  self.pathenemyfightdist = 192;
  self.pathenemylookahead = 192;
  self.favoriteenemy = undefined;
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 720);
  thread setup_follower_goalradius();

  for(;;) {
    wait 0.2;

    if(!isalive(self.leader)) {
      self setgoalpos(self.origin);
      continue;
    }

    self setgoalpos(self.leader.origin);
  }
}

protector_leader_logic(var_0, var_1) {
  level endon("squad_disband");
  self endon("death");
  self.back_occupied["left"] = 0;
  self.back_occupied["right"] = 0;
  self.protecting_obj = 1;
  self.protector_obj_group = var_0;
  var_2 = common_scripts\utility::getStruct(self.target, "targetname");
  bind_in_place(var_1, var_2.origin);
  var_1 waittill("trigger");
  wait 5;
  self.protecting_obj = 0;
  self.goalradius = 512;
  var_3 = maps\_utility::getclosest(self.origin, level.players);
  self.favoriteenemy = var_3;
  self setgoalentity(var_3);
}

setup_follower_goalradius() {
  common_scripts\utility::waittill_either("enemy_visible", "leader_saw_player");
  self.goalradius = 600;
  self.saw_player = 1;
}

setup_follower_goalradius_riotshield() {
  level endon("squad_disband");
  self endon("death");
  self endon("promotion");
  self.goalradius = 8;
  self waittill("goal");
  var_0 = 10;
  var_1 = 5;
  var_2 = 120;

  for(;;) {
    maps\_utility::cqb_walk("on");

    if(isDefined(self.protecting_obj) && self.protecting_obj) {
      wait 1;
      continue;
    }

    wait 30;
    self.goalradius = 600;
    maps\_utility::cqb_walk("off");
    wait 20;
    self.goalradius = 8;
  }

  self.goalradius = 600;
  self.leader.back_occupied[self.is_occupying] = 0;
}

get_riotshield_back_pos(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }
  var_2 = undefined;

  if(isDefined(var_1) && var_1) {
    if(isDefined(self.enemy) && isPlayer(self.enemy)) {
      var_2 = vectortoangles(self.enemy - self.origin);
    } else {
      return undefined;
    }
  } else {
    var_2 = self.angles;
  }
  if(var_0 == "left") {
    var_3 = (var_2[0], var_2[1] - 145, var_2[2]);
  } else {
    var_3 = (var_2[0], var_2[1] + 145, var_2[2]);
  }
  var_4 = vectorNormalize(anglesToForward(var_3)) * 45;
  return self.origin + var_4;
}

bind_in_place(var_0, var_1) {
  level endon("squad_disband");
  var_0 endon("trigger");
  self endon("death");

  for(;;) {
    self.goalradius = 8;
    self setgoalpos(var_1);
    wait 0.05;
  }
}

one_direction_trigger() {
  self endon("trigger");
  var_0 = getEnt(self.target, "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::trigger_off();
}

is_leader_riotshield(var_0) {
  return isDefined(var_0.leader) && var_0.leader.classname == "actor_enemy_afghan_riotshield";
}

is_riotshield(var_0) {
  if(var_0.classname == "actor_enemy_afghan_riotshield") {
    return 1;
  }
  return 0;
}

handle_all_followers_dying(var_0) {
  level endon("squad_disband");
  self endon("death");

  for(;;) {
    wait 1;
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(isalive(var_3)) {
        var_1++;
      }
    }

    if(var_1 == 1 && level.leaders.size > 1) {
      level.leaders = common_scripts\utility::array_remove(level.leaders, self);
      var_5 = level.leaders[0];

      if(level.leaders.size > 1) {
        var_5 = maps\_utility::get_closest_living(self.origin, level.leaders);
      }
      thread setup_follower(var_5);
      self notify("demotion");
      return;
    }
  }
}

drawleader() {
  if(getDvar("squad_debug") == "" || getDvar("squad_debug") == "0") {
    return;
  }
  var_0 = (1, 1, 1);

  for(;;) {
    foreach(var_2 in level.leaders) {
      if(isalive(var_2) && isDefined(var_2.squadmembers)) {
        foreach(var_4 in var_2.squadmembers) {
          if(isDefined(var_4) && isalive(var_4)) {}
        }
      }
    }

    wait 0.05;
  }
}

draw_debug_marker(var_0, var_1) {
  if(getDvar("squad_debug") == "" || getDvar("squad_debug") == "0") {
    return;
  }
  for(var_2 = 0; var_2 < 40; var_2++) {
    wait 0.05;
  }
}

drawfollowers() {
  if(getDvar("squad_debug") == "" || getDvar("squad_debug") == "0") {
    return;
  }
  for(;;) {
    var_0 = getaiarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.leader)) {
        thread common_scripts\utility::draw_line_for_time(var_2.origin, var_2.leader.origin, 0.5, 0.5, 1, 0.1);
      }
    }

    wait 0.1;
  }
}