/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\dog_utility.gsc
***********************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#namespace dog_utility;

function go_to_node(nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247) {
  if(!isDefined(nodes)) {
    nodes = get_target_goals(self.target);

    if(nodes.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(nodes)) {
    nodes = [nodes];
  }

  go_to_node_internal(nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25);
}

function go_to_node_internal(node, optional_arrived_at_node_func, var_5e38f20c9628ae25) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  if(!isarray(node)) {
    node = [node];
  }

  startnode = node[0];
  thread go_to_node_end();
  var_a749ce9b52022669 = 0;
  patharray = undefined;

  for(;;) {
    if(!var_a749ce9b52022669) {
      if(isDefined(level.var_375b317cc772ef57)) {
        node = [[level.var_375b317cc772ef57]](node);
      } else {
        node = get_least_used_from_array(node);
      }

      patharray = get_path_array(node, startnode);
      self.patharray = patharray;
      self.patharrayindex = -1;

      if(patharray.size > 1) {
        var_a749ce9b52022669 = 1;
      }
    }

    self.currentnode = node;

    if(var_a749ce9b52022669) {
      node = patharray[patharray.size - 1];
      go_through_patharray(patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25);
      patharray = undefined;
      var_a749ce9b52022669 = 0;
    } else {
      node_fields_pre_goal(node);

      if(isDefined(self.stealth)) {
        stealth_call("go_to_node_wait", &go_to_node_set_goal, node);
      } else {
        go_to_node_set_goal(node);
        self waittill("goal");
      }
    }

    node notify("trigger", self);
    node_fields_after_goal(node, optional_arrived_at_node_func);
    node script_delay();

    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }

    if(isDefined(node.script_flag_waitopen)) {
      flag_waitopen(node.script_flag_waitopen);
    }

    if(isDefined(node.script_ent_flag_wait)) {
      ent_flag_wait(node.script_ent_flag_wait);
    }

    node script_wait();
    node_fields_after_goal_and_wait(node, var_5e38f20c9628ae25);

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = get_target_goals(node.target);

    if(!nextnode_array.size) {
      break;
    }

    node = nextnode_array;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  volume = self getgoalvolume();

  if(isDefined(volume)) {
    self setgoalvolumeauto(volume, volume get_cover_volume_forward());
    return;
  }

  self.goalradius = level.default_goalradius;
}

function go_through_patharray(patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25) {
  self setgoalpath(patharray);

  foreach(index, tempnode in patharray) {
    node_fields_pre_goal(tempnode);
    patharrayindex = waittill_subgoal();
    self.patharrayindex = patharrayindex;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex)) {
      self.patharrayindex = self.patharray.size - 1;
    }

    if(index == patharray.size - 1) {
      self waittill("goal");
      break;
    }

    tempnode notify("trigger", self);
    node_fields_after_goal(tempnode, optional_arrived_at_node_func);
    node_fields_after_goal_and_wait(tempnode, var_5e38f20c9628ae25);
  }
}

function node_fields_after_goal(node, optional_arrived_at_node_func) {
  if(isDefined(self.stealth)) {
    stealth_call("go_to_node_arrive", &go_to_node_set_goal, node);
  }

  if(isDefined(optional_arrived_at_node_func)) {
    [[optional_arrived_at_node_func]](node);
  }

  if(isDefined(node.script_flag_set)) {
    flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_ent_flag_set)) {
    ent_flag_set(node.script_ent_flag_set);
  }

  if(isDefined(node.script_ent_flag_clear)) {
    ent_flag_clear(node.script_ent_flag_clear);
  }

  if(isDefined(node.script_flag_clear)) {
    flag_clear(node.script_flag_clear);
  }
}

function ai_delete_when_out_of_sight(ai_array, fdist) {
  if(!isDefined(ai_array)) {
    return;
  }

  var_7e36d51c34f3bf2f = 0.75;

  while(ai_array.size > 0) {
    wait 1;

    for(i = 0; i < ai_array.size; i++) {
      if(!isalive(ai_array[i])) {
        ai_array = array_remove(ai_array, ai_array[i]);
        continue;
      }

      if(players_within_distance(fdist, ai_array[i].origin)) {
        continue;
      }

      if(either_player_looking_at(ai_array[i].origin + (0, 0, 48), var_7e36d51c34f3bf2f, 1)) {
        continue;
      }

      if(isDefined(ai_array[i].magic_bullet_shield)) {
        ai_array[i] stop_magic_bullet_shield();
      }

      ai_array[i] delete();
      ai_array = array_remove(ai_array, ai_array[i]);
    }
  }
}

function player_looking_at(start, dot, dot_only, ignore_ent) {
  if(!isDefined(dot)) {
    dot = 0.8;
  }

  player = get_player_from_self();
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  new_dot = vectordot(forward, player_forward);

  if(new_dot < dot) {
    return 0;
  }

  if(isDefined(dot_only)) {
    assertex(dot_only, "<dev string:x1c>");
    return 1;
  }

  return ray_trace_detail_passed(start, end, ignore_ent, create_default_contents(1));
}

function either_player_looking_at(org, dot, dot_only, ignore_ent) {
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] player_looking_at(org, dot, dot_only, ignore_ent)) {
      return true;
    }
  }

  return false;
}

function players_within_distance(fdist, org) {
  var_74a76bbc5f12d7ea = fdist * fdist;

  for(i = 0; i < level.players.size; i++) {
    if(distancesquared(org, level.players[i].origin) < var_74a76bbc5f12d7ea) {
      return true;
    }
  }

  return false;
}

function go_to_node_set_goal(ent) {
  if(isnode(ent)) {
    go_to_node_set_goal_node(ent);
  } else if(isstruct(ent)) {
    go_to_node_set_goal_pos(ent);
  } else if(isent(ent)) {
    go_to_node_set_goal_ent(ent);
  }

  if(isstruct(ent) || isnode(ent)) {
    ent.patrol_stop = go_to_node_should_stop(ent);
  }
}

function go_to_node_set_goal_ent(ent) {
  if(ent.code_classname == "info_volume") {
    self setgoalvolumeauto(ent, ent get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(ent);
}

function go_to_node_set_goal_pos(ent) {
  set_goal_ent(ent);
  self notify("go_to_node_new_goal");
}

function go_to_node_set_goal_node(node) {
  set_goal_node(node);
  self notify("go_to_node_new_goal");
}

function set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(node);
}

function set_goal_ent(target) {
  set_goal_pos(target.origin);
  self.last_set_goalent = target;

  if(isstruct(target) && !isDefined(target.type)) {
    target.type = "struct";
  }
}

function set_goal_pos(origin) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = origin;
  self.last_set_goalent = undefined;
  self setgoalpos(origin);
}

function go_to_node_wait_for_player(node, get_target_func) {
  if(distancesquared(level.player.origin, node.origin) < distancesquared(self.origin, node.origin)) {
    return true;
  }

  if(!isDefined(node.script_dist_only)) {
    vec = anglesToForward(self.angles);

    if(isDefined(node.target)) {
      temp = [[get_target_func]](node.target);

      if(temp.size == 1) {
        vec = vectorNormalize(temp[0].origin - node.origin);
      } else if(isDefined(node.angles)) {
        vec = anglesToForward(node.angles);
      }
    } else if(isDefined(node.angles)) {
      vec = anglesToForward(node.angles);
    }

    vec2 = [];
    vec2[vec2.size] = vectorNormalize(level.player.origin - self.origin);

    foreach(value in vec2) {
      if(vectordot(vec, value) > 0) {
        return true;
      }
    }
  }

  dist = 32;

  if(node.script_requires_player > dist) {
    dist = node.script_requires_player;
  }

  if(distancesquared(level.player.origin, self.origin) < squared(dist)) {
    return true;
  }

  return false;
}

function node_fields_after_goal_and_wait(node, var_5e38f20c9628ae25) {
  if(isDefined(node.script_soundalias)) {
    self playSound(node.script_soundalias);
  }

  if(isDefined(node.script_gesture)) {
    thread gesture_simple(node.script_gesture);
  }

  if(isDefined(self.stealth)) {
    stealth_call("go_to_node_post_wait", &go_to_node_set_goal, node);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]]();
  }

  if(isDefined(node.script_delay_post)) {
    wait node.script_delay_post;
  }

  while(isDefined(node.script_requires_player)) {
    if(go_to_node_wait_for_player(node, &get_target_goals)) {
      node notify("script_requires_player");
      break;
    }

    wait 0.1;
  }

  if(isDefined(node.script_demeanor_post)) {
    utility::demeanor_override(node.script_demeanor_post);
  }

  if(isDefined(var_5e38f20c9628ae25)) {
    [[var_5e38f20c9628ae25]](node);
  }

  if(istrue(node.script_death)) {
    die();
  }

  if(istrue(node.script_delete)) {
    if(istrue(node.script_nosight)) {
      level thread ai_delete_when_out_of_sight([self], 350);
      return;
    }

    if(isDefined(self.magic_bullet_shield)) {
      stop_magic_bullet_shield();
    }

    self delete();
  }
}

function die() {
  self kill((0, 0, 0));
}

function gesture_simple(var_7ca8d1ce367054f8) {}

function waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", index);
  return index;
}

function node_fields_pre_goal(node) {
  if(isDefined(node.radius)) {
    self.goalradius = node.radius;
  }

  if(isDefined(node.height)) {
    self.goalheight = node.height;
  }

  if(isDefined(node.script_demeanor)) {
    utility::demeanor_override(node.script_demeanor);
  }

  if(isDefined(node.script_civilian_state)) {
    scripts\asm\asm_bb::bb_setcivilianstate(node.script_civilian_state);
  }

  if(isDefined(node.script_pacifist)) {
    self.pacifist = node.script_pacifist;
  }

  if(isDefined(node.script_ignoreall)) {
    self.ignoreall = node.script_ignoreall;
  }

  if(isDefined(node.script_ignoreme)) {
    self.ignoreme = node.script_ignoreme;
  }

  if(isDefined(node.script_moveplaybackrate)) {
    set_moveplaybackrate(node.script_moveplaybackrate, 0.25);
  }

  if(isDefined(node.script_speed)) {
    set_movement_speed(node.script_speed);
  }

  if(isDefined(node.script_gunpose)) {
    set_gunpose(node.script_gunpose);
  }

  if(isDefined(node.script_disable_arrivals)) {
    if(node.script_disable_arrivals) {
      disable_arrivals();
    } else {
      self.disablearrivals = 0;
    }
  }

  if(isDefined(node.script_disable_exits)) {
    if(node.script_disable_exits) {
      disable_exits();
    } else {
      enable_exits();
    }
  }

  if(isDefined(node.script_combatmode)) {
    self.combatmode = node.script_combatmode;
  }
}

function get_path_array(node, startnode) {
  array = [];
  count = 0;

  while(true) {
    if(is_equal(node.code_classname, "info_volume")) {
      break;
    }

    array[array.size] = node;
    count++;

    if(count == 16) {
      break;
    }

    if(go_to_node_should_stop(node)) {
      break;
    }

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = get_target_goals(node.target);

    if(!nextnode_array.size) {
      break;
    }

    node = get_least_used_from_array(nextnode_array);

    if(node == startnode) {
      break;
    }
  }

  return array;
}

function go_to_node_should_stop(arrivaltarget) {
  if(!isDefined(arrivaltarget)) {
    return true;
  }

  if(!isDefined(arrivaltarget.target)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay_min)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay_max)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait_add)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait_min)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait_max)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_flag_wait)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_flag_waitopen)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_ent_flag_wait)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay_post)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_requires_player)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_idle)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_stopnode)) {
    return true;
  }

  return false;
}

function get_least_used_from_array(array) {
  if(array.size == 1) {
    return array[0];
  }

  array = array_randomize(array);
  least_used = array[0];

  if(!isDefined(least_used.used_time)) {
    least_used.used_time = 0;
  }

  foreach(node in array) {
    if(!isDefined(node.used_time)) {
      node.used_time = 0;
    }

    if(node.used_time < least_used.used_time) {
      least_used = node;
    }
  }

  least_used.used_time = gettime();
  return least_used;
}

function get_target_goals(target) {
  goals = getnodearray(target, "targetname");
  new_goals = getStructArray(target, "targetname");

  foreach(new in new_goals) {
    goals[goals.size] = new;
  }

  new_goals = getEntArray(target, "targetname");

  foreach(new in new_goals) {
    if(!is_target_goal_valid(new)) {
      continue;
    }

    goals[goals.size] = new;
  }

  return goals;
}

function is_target_goal_valid(object) {
  if(isspawner(object)) {
    return false;
  }

  switch (object.code_classname) {
    case #"hash_1b79c5d9e0f9886a":
    case #"hash_5e0756fcd4e0adcd":
    case #"hash_8040aa10d9cac1e8":
    case #"hash_81903cb95a447b8c":
      return false;
  }

  return true;
}

function go_to_node_end() {
  self endon("death");
  self.using_goto_node = 1;

  if(utility::iscp() || utility::ismp()) {
    waittill_any_2("reached_path_end", "stop_going_to_node");
  } else {
    waittill_any("reached_path_end", "stop_going_to_node");
  }

  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

function set_moveplaybackrate(rate, time) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  self endon("death");

  if(isDefined(time)) {
    current_rate = asm_getmoveplaybackrate();
    range = rate - current_rate;
    interval = 0.05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(rate - current_rate) > abs(fraction * 1.1)) {
      asm_setmoveplaybackrate(current_rate + fraction);
      wait interval;
      current_rate = asm_getmoveplaybackrate();
    }
  }

  asm_setmoveplaybackrate(rate);
}

function get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw)) {
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  }

  return undefined;
}

function get_player_from_self() {
  if(isDefined(self)) {
    if(!array_contains(level.players, self)) {
      return level.player;
    } else {
      return self;
    }

    return;
  }

  return level.players[0];
}