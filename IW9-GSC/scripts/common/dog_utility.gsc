/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\dog_utility.gsc
***********************************************/

go_to_node(nodes, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  if(!isDefined(nodes)) {
    nodes = get_target_goals(self.target);

    if(nodes.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(nodes))
    nodes = [nodes];

  go_to_node_internal(nodes, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25);
}

go_to_node_internal(node, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  if(!isarray(node))
    node = [node];

  startnode = node[0];
  thread go_to_node_end();
  _id_A749CE9B52022669 = 0;
  patharray = undefined;

  for(;;) {
    if(!_id_A749CE9B52022669) {
      if(isDefined(level._id_375B317CC772EF57))
        node = [[level._id_375B317CC772EF57]](node);
      else
        node = get_least_used_from_array(node);

      patharray = get_path_array(node, startnode);
      self.patharray = patharray;
      self.patharrayindex = -1;

      if(patharray.size > 1)
        _id_A749CE9B52022669 = 1;
    }

    self.currentnode = node;

    if(_id_A749CE9B52022669) {
      node = patharray[patharray.size - 1];
      go_through_patharray(patharray, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25);
      patharray = undefined;
      _id_A749CE9B52022669 = 0;
    } else {
      node_fields_pre_goal(node);

      if(isDefined(self.stealth))
        scripts\stealth\callbacks::stealth_call("go_to_node_wait", ::go_to_node_set_goal, node);
      else {
        go_to_node_set_goal(node);
        self waittill("goal");
      }
    }

    node notify("trigger", self);
    node_fields_after_goal(node, _id_D25339A42DEEAC35);
    node scripts\engine\utility::script_delay();

    if(isDefined(node.script_flag_wait))
      scripts\engine\utility::flag_wait(node.script_flag_wait);

    if(isDefined(node._id_7FD486C78ED742F7))
      scripts\engine\utility::flag_waitopen(node._id_7FD486C78ED742F7);

    if(isDefined(node.script_ent_flag_wait))
      scripts\engine\utility::ent_flag_wait(node.script_ent_flag_wait);

    node scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(node, _id_5E38F20C9628AE25);

    if(!isDefined(node.target)) {
      break;
    }

    _id_6EC865F8E82F3AE6 = get_target_goals(node.target);

    if(!_id_6EC865F8E82F3AE6.size) {
      break;
    }

    node = _id_6EC865F8E82F3AE6;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  volume = self getgoalvolume();

  if(isDefined(volume))
    self setgoalvolumeauto(volume, volume get_cover_volume_forward());
  else
    self.goalradius = level.default_goalradius;
}

go_through_patharray(patharray, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  self setgoalpath(patharray);

  foreach(index, _id_E0386CBFBCCBBC5B in patharray) {
    node_fields_pre_goal(_id_E0386CBFBCCBBC5B);
    patharrayindex = waittill_subgoal();
    self.patharrayindex = patharrayindex;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex))
      self.patharrayindex = self.patharray.size - 1;

    if(index == patharray.size - 1) {
      self waittill("goal");
      break;
    }

    _id_E0386CBFBCCBBC5B notify("trigger", self);
    node_fields_after_goal(_id_E0386CBFBCCBBC5B, _id_D25339A42DEEAC35);
    node_fields_after_goal_and_wait(_id_E0386CBFBCCBBC5B, _id_5E38F20C9628AE25);
  }
}

node_fields_after_goal(node, _id_D25339A42DEEAC35) {
  if(isDefined(self.stealth))
    scripts\stealth\callbacks::stealth_call("go_to_node_arrive", ::go_to_node_set_goal, node);

  if(isDefined(_id_D25339A42DEEAC35))
    [[_id_D25339A42DEEAC35]](node);

  if(isDefined(node.script_flag_set))
    scripts\engine\utility::flag_set(node.script_flag_set);

  if(isDefined(node.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(node.script_ent_flag_set);

  if(isDefined(node.script_ent_flag_clear))
    scripts\engine\utility::ent_flag_clear(node.script_ent_flag_clear);

  if(isDefined(node.script_flag_clear))
    scripts\engine\utility::flag_clear(node.script_flag_clear);
}

ai_delete_when_out_of_sight(ai_array, _id_644ED64F4BE560B9) {
  if(!isDefined(ai_array)) {
    return;
  }
  _id_7E36D51C34F3BF2F = 0.75;

  while(ai_array.size > 0) {
    wait 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ai_array.size; _id_AC0E594AC96AA3A8++) {
      if(!isalive(ai_array[_id_AC0E594AC96AA3A8])) {
        ai_array = scripts\engine\utility::array_remove(ai_array, ai_array[_id_AC0E594AC96AA3A8]);
        continue;
      }

      if(players_within_distance(_id_644ED64F4BE560B9, ai_array[_id_AC0E594AC96AA3A8].origin)) {
        continue;
      }
      if(either_player_looking_at(ai_array[_id_AC0E594AC96AA3A8].origin + (0, 0, 48), _id_7E36D51C34F3BF2F, 1)) {
        continue;
      }
      if(isDefined(ai_array[_id_AC0E594AC96AA3A8].magic_bullet_shield))
        ai_array[_id_AC0E594AC96AA3A8] scripts\common\ai::stop_magic_bullet_shield();

      ai_array[_id_AC0E594AC96AA3A8] delete();
      ai_array = scripts\engine\utility::array_remove(ai_array, ai_array[_id_AC0E594AC96AA3A8]);
    }
  }
}

player_looking_at(start, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615) {
  if(!isDefined(dot))
    dot = 0.8;

  player = get_player_from_self();
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  _id_DEE6508B0BA437C5 = player getplayerangles();
  _id_70222FBC47330166 = anglesToForward(_id_DEE6508B0BA437C5);
  _id_334AF980E8C1A3AD = vectordot(forward, _id_70222FBC47330166);

  if(_id_334AF980E8C1A3AD < dot)
    return 0;

  if(isDefined(_id_95BFA6EAF973D593))
    return 1;

  return scripts\engine\trace::ray_trace_detail_passed(start, end, _id_75BEA58D65510615, scripts\engine\trace::create_default_contents(1));
}

either_player_looking_at(org, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] player_looking_at(org, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615))
      return 1;
  }

  return 0;
}

players_within_distance(_id_644ED64F4BE560B9, org) {
  _id_74A76BBC5F12D7EA = _id_644ED64F4BE560B9 * _id_644ED64F4BE560B9;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(distancesquared(org, level.players[_id_AC0E594AC96AA3A8].origin) < _id_74A76BBC5F12D7EA)
      return 1;
  }

  return 0;
}

go_to_node_set_goal(ent) {
  if(isnode(ent))
    go_to_node_set_goal_node(ent);
  else if(isstruct(ent))
    go_to_node_set_goal_pos(ent);
  else if(isent(ent))
    go_to_node_set_goal_ent(ent);

  if(isstruct(ent) || isnode(ent))
    ent.patrol_stop = go_to_node_should_stop(ent);
}

go_to_node_set_goal_ent(ent) {
  if(ent.code_classname == "info_volume") {
    self setgoalvolumeauto(ent, ent get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(ent);
}

go_to_node_set_goal_pos(ent) {
  set_goal_ent(ent);
  self notify("go_to_node_new_goal");
}

go_to_node_set_goal_node(node) {
  set_goal_node(node);
  self notify("go_to_node_new_goal");
}

set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(node);
}

set_goal_ent(target) {
  set_goal_pos(target.origin);
  self.last_set_goalent = target;

  if(isstruct(target) && !isDefined(target.type))
    target.type = "struct";
}

set_goal_pos(origin) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = origin;
  self.last_set_goalent = undefined;
  self setgoalpos(origin);
}

go_to_node_wait_for_player(node, _id_98EA791865528A70) {
  if(distancesquared(level.player.origin, node.origin) < distancesquared(self.origin, node.origin))
    return 1;

  if(!isDefined(node.script_dist_only)) {
    _id_06A3A1033FFC2699 = anglesToForward(self.angles);

    if(isDefined(node.target)) {
      temp = [[_id_98EA791865528A70]](node.target);

      if(temp.size == 1)
        _id_06A3A1033FFC2699 = vectorNormalize(temp[0].origin - node.origin);
      else if(isDefined(node.angles))
        _id_06A3A1033FFC2699 = anglesToForward(node.angles);
    } else if(isDefined(node.angles))
      _id_06A3A1033FFC2699 = anglesToForward(node.angles);

    _id_9601C525B7890A11 = [];
    _id_9601C525B7890A11[_id_9601C525B7890A11.size] = vectorNormalize(level.player.origin - self.origin);

    foreach(value in _id_9601C525B7890A11) {
      if(vectordot(_id_06A3A1033FFC2699, value) > 0)
        return 1;
    }
  }

  dist = 32;

  if(node.script_requires_player > dist)
    dist = node.script_requires_player;

  if(distancesquared(level.player.origin, self.origin) < squared(dist))
    return 1;

  return 0;
}

node_fields_after_goal_and_wait(node, _id_5E38F20C9628AE25) {
  if(isDefined(node.script_soundalias))
    self playSound(node.script_soundalias);

  if(isDefined(node.script_gesture))
    thread gesture_simple(node.script_gesture);

  if(isDefined(self.stealth))
    scripts\stealth\callbacks::stealth_call("go_to_node_post_wait", ::go_to_node_set_goal, node);

  if(isDefined(self.post_wait_func))
    [[self.post_wait_func]]();

  if(isDefined(node.script_delay_post))
    wait(node.script_delay_post);

  while(isDefined(node.script_requires_player)) {
    if(go_to_node_wait_for_player(node, ::get_target_goals)) {
      node notify("script_requires_player");
      break;
    }

    wait 0.1;
  }

  if(isDefined(node.script_demeanor_post))
    scripts\common\utility::demeanor_override(node.script_demeanor_post);

  if(isDefined(_id_5E38F20C9628AE25))
    [[_id_5E38F20C9628AE25]](node);

  if(istrue(node.script_death))
    die();

  if(istrue(node.script_delete)) {
    if(istrue(node.script_nosight))
      level thread ai_delete_when_out_of_sight([self], 350);
    else {
      if(isDefined(self.magic_bullet_shield))
        scripts\common\ai::stop_magic_bullet_shield();

      self delete();
    }
  }
}

die() {
  self kill((0, 0, 0));
}

gesture_simple(_id_7CA8D1CE367054F8) {}

waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", index);
  return index;
}

node_fields_pre_goal(node) {
  if(isDefined(node.radius))
    self.goalradius = node.radius;

  if(isDefined(node.height))
    self.goalheight = node.height;

  if(isDefined(node.script_demeanor))
    scripts\common\utility::demeanor_override(node.script_demeanor);

  if(isDefined(node.script_civilian_state))
    scripts\asm\asm_bb::bb_setcivilianstate(node.script_civilian_state);

  if(isDefined(node.script_pacifist))
    self.pacifist = node.script_pacifist;

  if(isDefined(node.script_ignoreall))
    self.ignoreall = node.script_ignoreall;

  if(isDefined(node.script_ignoreme))
    self.ignoreme = node.script_ignoreme;

  if(isDefined(node.script_moveplaybackrate))
    set_moveplaybackrate(node.script_moveplaybackrate, 0.25);

  if(isDefined(node.script_speed))
    scripts\engine\utility::set_movement_speed(node.script_speed);

  if(isDefined(node.script_gunpose))
    scripts\common\ai::set_gunpose(node.script_gunpose);

  if(isDefined(node.script_disable_arrivals)) {
    if(node.script_disable_arrivals)
      scripts\common\ai::disable_arrivals();
    else
      self.disablearrivals = 0;
  }

  if(isDefined(node.script_disable_exits)) {
    if(node.script_disable_exits)
      scripts\common\ai::disable_exits();
    else
      scripts\common\ai::enable_exits();
  }

  if(isDefined(node.script_combatmode))
    self.combatmode = node.script_combatmode;
}

get_path_array(node, startnode) {
  array = [];
  count = 0;

  for(;;) {
    if(scripts\engine\utility::is_equal(node.code_classname, "info_volume")) {
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

    _id_6EC865F8E82F3AE6 = get_target_goals(node.target);

    if(!_id_6EC865F8E82F3AE6.size) {
      break;
    }

    node = get_least_used_from_array(_id_6EC865F8E82F3AE6);

    if(node == startnode) {
      break;
    }
  }

  return array;
}

go_to_node_should_stop(_id_9DA7DD4834E89D17) {
  if(!isDefined(_id_9DA7DD4834E89D17))
    return 1;

  if(!isDefined(_id_9DA7DD4834E89D17.target))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_min))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_max))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_add))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_min))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_max))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_flag_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17._id_7FD486C78ED742F7))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_ent_flag_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_post))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_requires_player))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_idle))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_stopnode))
    return 1;

  return 0;
}

get_least_used_from_array(array) {
  if(array.size == 1)
    return array[0];

  array = scripts\engine\utility::array_randomize(array);
  _id_AD98B0B8CE2A6FDE = array[0];

  if(!isDefined(_id_AD98B0B8CE2A6FDE.used_time))
    _id_AD98B0B8CE2A6FDE.used_time = 0;

  foreach(node in array) {
    if(!isDefined(node.used_time))
      node.used_time = 0;

    if(node.used_time < _id_AD98B0B8CE2A6FDE.used_time)
      _id_AD98B0B8CE2A6FDE = node;
  }

  _id_AD98B0B8CE2A6FDE.used_time = gettime();
  return _id_AD98B0B8CE2A6FDE;
}

get_target_goals(target) {
  goals = getnodearray(target, "targetname");
  _id_889BE5A52999435E = scripts\engine\utility::getStructArray(target, "targetname");

  foreach(new in _id_889BE5A52999435E)
  goals[goals.size] = new;

  _id_889BE5A52999435E = getEntArray(target, "targetname");

  foreach(new in _id_889BE5A52999435E) {
    if(!is_target_goal_valid(new)) {
      continue;
    }
    goals[goals.size] = new;
  }

  return goals;
}

is_target_goal_valid(object) {
  if(isspawner(object))
    return 0;

  switch (object.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return 0;
  }

  return 1;
}

go_to_node_end() {
  self endon("death");
  self.using_goto_node = 1;

  if(scripts\common\utility::iscp() || scripts\common\utility::ismp())
    scripts\engine\utility::waittill_any_2("reached_path_end", "stop_going_to_node");
  else
    scripts\engine\utility::waittill_any("reached_path_end", "stop_going_to_node");

  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

set_moveplaybackrate(rate, time) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  self endon("death");

  if(isDefined(time)) {
    _id_EC2AB9497C8F6E29 = scripts\asm\asm::asm_getmoveplaybackrate();
    range = rate - _id_EC2AB9497C8F6E29;
    interval = 0.05;
    _id_92FEDD11192AD154 = time / interval;

    for(fraction = range / _id_92FEDD11192AD154; abs(rate - _id_EC2AB9497C8F6E29) > abs(fraction * 1.1); _id_EC2AB9497C8F6E29 = scripts\asm\asm::asm_getmoveplaybackrate()) {
      scripts\asm\asm::asm_setmoveplaybackrate(_id_EC2AB9497C8F6E29 + fraction);
      wait(interval);
    }
  }

  scripts\asm\asm::asm_setmoveplaybackrate(rate);
}

get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw))
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  else
    return undefined;
}

get_player_from_self() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self))
      return level.player;
    else
      return self;
  } else
    return level.players[0];
}