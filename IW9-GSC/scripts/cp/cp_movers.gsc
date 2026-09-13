/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_movers.gsc
***********************************************/

main() {
  if(getDvar("r_reflectionprobegenerate") == "1") {
    return;
  }
  level.script_mover_defaults = [];
  level.script_mover_defaults["move_time"] = 5;
  level.script_mover_defaults["accel_time"] = 0;
  level.script_mover_defaults["decel_time"] = 0;
  level.script_mover_defaults["wait_time"] = 0;
  level.script_mover_defaults["delay_time"] = 0;
  level.script_mover_defaults["usable"] = 0;
  level.script_mover_defaults["hintstring"] = "activate";
  script_mover_add_hintstring("activate", &"MP/ACTIVATE_MOVER");
  script_mover_add_parameters("none", "");
  level.script_mover_named_goals = [];
  waitframe();
  movers = [];
  _id_F9DE49798947A6A9 = script_mover_classnames();

  foreach(class in _id_F9DE49798947A6A9)
  movers = scripts\engine\utility::array_combine(movers, getEntArray(class, "classname"));

  scripts\engine\utility::array_thread(movers, ::script_mover_int);
  init();
}

script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

script_mover_is_script_mover() {
  if(isDefined(self.script_mover))
    return self.script_mover;

  _id_F9DE49798947A6A9 = script_mover_classnames();

  foreach(class in _id_F9DE49798947A6A9) {
    if(self.classname == class) {
      self.script_mover = 1;
      return 1;
    }
  }

  return 0;
}

script_mover_add_hintstring(name, hintstring) {
  if(!isDefined(level.script_mover_hintstrings))
    level.script_mover_hintstrings = [];

  level.script_mover_hintstrings[name] = hintstring;
}

script_mover_add_parameters(name, _id_6C1755E925291505) {
  if(!isDefined(level.script_mover_parameters))
    level.script_mover_parameters = [];

  level.script_mover_parameters[name] = _id_6C1755E925291505;
}

script_mover_int() {
  if(!isDefined(self.target)) {
    return;
  }
  self.script_mover = 1;
  self.moving = 0;
  self.origin_ent = self;
  self.use_triggers = [];
  self.linked_ents = [];
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(target in _id_9E4E1482CB40C9C5) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "origin":
        if(!isDefined(target.angles))
          target.angles = (0, 0, 0);

        self.origin_ent = spawn("script_model", target.origin);
        self.origin_ent.angles = target.angles;
        self.origin_ent setModel("tag_origin");
        self.origin_ent linkTo(self);
        break;
      default:
        break;
    }
  }

  ents = getEntArray(self.target, "targetname");

  foreach(target in ents) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "use_trigger_link":
        target enablelinkTo();
        target linkTo(self);
      case "use_trigger":
        target script_mover_parse_targets();
        thread script_mover_use_trigger(target);
        self.use_triggers[self.use_triggers.size] = target;
        break;
      case "link":
        target linkTo(self);
        self.linked_ents[self.linked_ents.size] = target;
        break;
      default:
        break;
    }
  }

  thread script_mover_parse_targets();
  thread script_mover_init_move_parameters();
  thread script_mover_save_default_move_parameters();
  thread script_mover_apply_move_parameters(self);
  thread script_mover_move_to_target();

  foreach(trigger in self.use_triggers)
  script_mover_set_usable(trigger, 1);
}

script_mover_use_trigger(trigger) {
  self endon("death");

  for(;;) {
    trigger waittill("trigger");

    if(trigger.goals.size > 0) {
      self notify("new_path");
      thread script_mover_move_to_target(trigger);
      continue;
    }

    self notify("trigger");
  }
}

script_mover_move_to_named_goal(_id_8037D6A83D174E6C) {
  if(isDefined(level.script_mover_named_goals[_id_8037D6A83D174E6C])) {
    self notify("new_path");
    self.goals = [level.script_mover_named_goals[_id_8037D6A83D174E6C]];
    thread script_mover_move_to_target();
  }
}

anglesclamp180(angles) {
  return (angleclamp180(angles[0]), angleclamp180(angles[1]), angleclamp180(angles[2]));
}

script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }
  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  self.level_notify = [];
  _id_9E4E1482CB40C9C5 = [];
  ents = [];

  if(isDefined(self.target)) {
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(self.target, "targetname");
    ents = getEntArray(self.target, "targetname");
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E4E1482CB40C9C5.size; _id_AC0E594AC96AA3A8++) {
    target = _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8];

    if(!isDefined(target.script_noteworthy))
      target.script_noteworthy = "goal";

    switch (target.script_noteworthy) {
      case "ignore":
        if(isDefined(target.target)) {
          _id_3452A514EC135B39 = scripts\engine\utility::getStructArray(target.target, "targetname");

          foreach(add in _id_3452A514EC135B39)
          _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = add;
        }

        break;
      case "goal":
        target script_mover_init_move_parameters();
        target script_mover_parse_targets();
        self.goals[self.goals.size] = target;

        if(isDefined(target.params["name"]))
          level.script_mover_named_goals[target.params["name"]] = target;

        break;
      case "level_notify":
        if(isDefined(target.script_parameters))
          self.level_notify[self.level_notify.size] = target;

        break;
      default:
        break;
    }
  }

  foreach(ent in ents) {
    if(ent script_mover_is_script_mover()) {
      self.movers[self.movers.size] = ent;
      continue;
    }

    if(!isDefined(ent.script_noteworthy)) {
      continue;
    }
    _id_F077ADF688122C36 = strtok(ent.script_noteworthy, "_");

    if(_id_F077ADF688122C36.size != 3 || _id_F077ADF688122C36[1] != "on") {
      continue;
    }
    switch (_id_F077ADF688122C36[0]) {
      case "delete":
        thread script_mover_call_func_on_notify(ent, ::delete, _id_F077ADF688122C36[2]);
        break;
      case "hide":
        thread script_mover_call_func_on_notify(ent, ::hide, _id_F077ADF688122C36[2]);
        break;
      case "show":
        ent hide();
        thread script_mover_call_func_on_notify(ent, ::show, _id_F077ADF688122C36[2]);
        break;
      case "triggerHide":
      case "triggerhide":
        thread script_mover_func_on_notify(ent, scripts\engine\utility::trigger_off, _id_F077ADF688122C36[2]);
        break;
      case "triggershow":
      case "triggerShow":
        ent scripts\engine\utility::trigger_off();
        thread script_mover_func_on_notify(ent, scripts\engine\utility::trigger_on, _id_F077ADF688122C36[2]);
        break;
      default:
        break;
    }
  }
}

script_mover_func_on_notify(ent, func, _id_A234A65C378F3289) {
  self endon("death");
  ent endon("death");

  for(;;) {
    self waittill(_id_A234A65C378F3289);
    ent[[func]]();
  }
}

script_mover_call_func_on_notify(ent, func, _id_A234A65C378F3289) {
  self endon("death");
  ent endon("death");

  for(;;) {
    self waittill(_id_A234A65C378F3289);
    ent call[[func]]();
  }
}

script_mover_trigger_on() {
  scripts\engine\utility::trigger_on();
}

script_mover_move_to_target(current) {
  self endon("death");
  self endon("new_path");

  if(!isDefined(current))
    current = self;

  while(current.goals.size != 0) {
    goal = scripts\engine\utility::random(current.goals);
    mover = self;
    mover script_mover_apply_move_parameters(goal);

    if(isDefined(mover.params["delay_till"]))
      level waittill(mover.params["delay_till"]);

    if(isDefined(mover.params["delay_till_trigger"]) && mover.params["delay_till_trigger"])
      self waittill("trigger");

    if(mover.params["delay_time"] > 0)
      wait(mover.params["delay_time"]);

    _id_69E534485EF2759C = mover.params["move_time"];
    _id_59509577645DE971 = mover.params["accel_time"];
    _id_FECC6E7F3326E7CA = mover.params["decel_time"];
    _id_8C5F7FCE9EA17D82 = 0;
    _id_A1D8548C477E5348 = 0;
    _id_B2282BDE95016D95 = transformmove(goal.origin, goal.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

    if(mover.origin != goal.origin) {
      if(isDefined(mover.params["move_speed"])) {
        dist = distance(mover.origin, goal.origin);
        _id_69E534485EF2759C = dist / mover.params["move_speed"];
      }

      if(isDefined(mover.params["accel_frac"]))
        _id_59509577645DE971 = mover.params["accel_frac"] * _id_69E534485EF2759C;

      if(isDefined(mover.params["decel_frac"]))
        _id_FECC6E7F3326E7CA = mover.params["decel_frac"] * _id_69E534485EF2759C;

      mover moveTo(_id_B2282BDE95016D95["origin"], _id_69E534485EF2759C, _id_59509577645DE971, _id_FECC6E7F3326E7CA);

      foreach(_id_A234A65C378F3289 in goal.level_notify)
      thread script_mover_run_notify(_id_A234A65C378F3289.origin, _id_A234A65C378F3289.script_parameters, self.origin, goal.origin);

      _id_8C5F7FCE9EA17D82 = 1;
    }

    if(anglesclamp180(_id_B2282BDE95016D95["angles"]) != anglesclamp180(mover.angles)) {
      mover rotateTo(_id_B2282BDE95016D95["angles"], _id_69E534485EF2759C, _id_59509577645DE971, _id_FECC6E7F3326E7CA);
      _id_A1D8548C477E5348 = 1;
    }

    foreach(_id_E6C68E108C6446FB in mover.movers)
    _id_E6C68E108C6446FB notify("trigger");

    current notify("depart");
    mover script_mover_allow_usable(0);
    self.moving = 1;

    if(isDefined(mover.params["move_time_offset"]) && mover.params["move_time_offset"] + _id_69E534485EF2759C > 0)
      wait(mover.params["move_time_offset"] + _id_69E534485EF2759C);
    else if(_id_8C5F7FCE9EA17D82)
      self waittill("movedone");
    else if(_id_A1D8548C477E5348)
      self waittill("rotatedone");
    else
      wait(_id_69E534485EF2759C);

    self.moving = 0;
    self notify("move_end");
    goal notify("arrive");

    if(isDefined(mover.params["solid"])) {
      if(mover.params["solid"])
        mover solid();
      else
        mover notsolid();
    }

    foreach(_id_E6C68E108C6446FB in goal.movers)
    _id_E6C68E108C6446FB notify("trigger");

    if(isDefined(mover.params["wait_till"]))
      level waittill(mover.params["wait_till"]);

    if(mover.params["wait_time"] > 0)
      wait(mover.params["wait_time"]);

    mover script_mover_allow_usable(1);
    current = goal;
  }
}

script_mover_run_notify(_id_CC67D2091616DC0F, level_notify, start, end) {
  self endon("move_end");
  mover = self;
  _id_0B04EA82614E4EEC = vectorNormalize(end - start);

  for(;;) {
    _id_90CAC5D946C3BB94 = vectorNormalize(_id_CC67D2091616DC0F - mover.origin);

    if(vectordot(_id_0B04EA82614E4EEC, _id_90CAC5D946C3BB94) <= 0) {
      break;
    }

    wait 0.05;
  }

  level notify(level_notify);
}

script_mover_init_move_parameters() {
  self.params = [];

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  self.angles = anglesclamp180(self.angles);
  script_mover_parse_move_parameters(self.script_parameters);
}

script_mover_parse_move_parameters(_id_6C1755E925291505) {
  if(!isDefined(_id_6C1755E925291505))
    _id_6C1755E925291505 = "";

  params = strtok(_id_6C1755E925291505, ";");

  foreach(param in params) {
    _id_F077ADF688122C36 = strtok(param, "=");

    if(_id_F077ADF688122C36.size != 2) {
      continue;
    }
    if(_id_F077ADF688122C36[1] == "undefined" || _id_F077ADF688122C36[1] == "default") {
      self.params[_id_F077ADF688122C36[0]] = undefined;
      continue;
    }

    switch (_id_F077ADF688122C36[0]) {
      case "accel_frac":
      case "decel_frac":
      case "move_speed":
      case "delay_time":
      case "wait_time":
      case "accel_time":
      case "move_time":
      case "move_time_offset":
      case "decel_time":
        self.params[_id_F077ADF688122C36[0]] = script_mover_parse_range(_id_F077ADF688122C36[1]);
        break;
      case "delay_till":
      case "wait_till":
      case "hintstring":
      case "name":
        self.params[_id_F077ADF688122C36[0]] = _id_F077ADF688122C36[1];
        break;
      case "delay_till_trigger":
      case "solid":
      case "usable":
        self.params[_id_F077ADF688122C36[0]] = int(_id_F077ADF688122C36[1]);
        break;
      case "script_params":
        _id_FC31A8F54B711348 = _id_F077ADF688122C36[1];
        _id_E7752450AB0C4553 = level.script_mover_parameters[_id_FC31A8F54B711348];

        if(isDefined(_id_E7752450AB0C4553))
          script_mover_parse_move_parameters(_id_E7752450AB0C4553);

        break;
      default:
        break;
    }
  }
}

script_mover_parse_range(str) {
  value = 0;
  _id_F077ADF688122C36 = strtok(str, ",");

  if(_id_F077ADF688122C36.size == 1)
    value = float(_id_F077ADF688122C36[0]);
  else if(_id_F077ADF688122C36.size == 2) {
    _id_3C141DF65714D228 = float(_id_F077ADF688122C36[0]);
    _id_47EF1080427D4D3A = float(_id_F077ADF688122C36[1]);

    if(_id_3C141DF65714D228 >= _id_47EF1080427D4D3A)
      value = _id_3C141DF65714D228;
    else
      value = randomfloatrange(_id_3C141DF65714D228, _id_47EF1080427D4D3A);
  }

  return value;
}

script_mover_apply_move_parameters(from) {
  foreach(key, value in from.params)
  script_mover_set_param(key, value);

  script_mover_set_defaults();
}

script_mover_set_param(_id_FC31A8F54B711348, value) {
  if(!isDefined(_id_FC31A8F54B711348)) {
    return;
  }
  if(_id_FC31A8F54B711348 == "usable" && isDefined(value))
    script_mover_set_usable(self, value);

  self.params[_id_FC31A8F54B711348] = value;
}

script_mover_allow_usable(usable) {
  if(self.params["usable"])
    script_mover_set_usable(self, usable);

  foreach(trigger in self.use_triggers)
  script_mover_set_usable(trigger, usable);
}

script_mover_set_usable(_id_C5D3D8FF129F88BA, usable) {
  if(usable) {
    _id_C5D3D8FF129F88BA makeusable();
    _id_C5D3D8FF129F88BA setCursorHint("HINT_NOICON");
    _id_C5D3D8FF129F88BA setHintString(level.script_mover_hintstrings[self.params["hintstring"]]);
  } else
    _id_C5D3D8FF129F88BA makeunusable();
}

script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(key, value in self.params)
  self.params_default[key] = value;
}

script_mover_set_defaults() {
  foreach(key, value in level.script_mover_defaults) {
    if(!isDefined(self.params[key]))
      script_mover_set_param(key, value);
  }

  if(isDefined(self.params_default)) {
    foreach(key, value in self.params_default) {
      if(!isDefined(self.params[key]))
        script_mover_set_param(key, value);
    }
  }
}

init() {
  level thread script_mover_agent_spawn_watch();
}

script_mover_agent_spawn_watch() {
  level notify("script_mover_agent_spawn_watch");
  level endon("script_mover_agent_spawn_watch");

  for(;;) {
    level waittill("spawned_agent", agent);
    agent thread player_unresolved_collision_watch();
  }
}

player_unresolved_collision_watch() {
  self endon("disconnect");

  if(isagent(self))
    self endon("death");

  self.unresolved_collision_count = 0;

  for(;;) {
    self waittill("unresolved_collision", mover, _id_1EE51B0A59B58D1E);
    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    unresolved_collision_notify_min = 3;

    if(isDefined(mover) && isDefined(mover.unresolved_collision_notify_min))
      unresolved_collision_notify_min = mover.unresolved_collision_notify_min;

    if(self.unresolved_collision_count >= unresolved_collision_notify_min) {
      if(isDefined(mover)) {
        if(isDefined(mover.unresolved_collision_func))
          mover[[mover.unresolved_collision_func]](self, _id_1EE51B0A59B58D1E);
        else if(isDefined(mover.unresolved_collision_kill) && mover.unresolved_collision_kill)
          mover unresolved_collision_owner_damage(self);
        else if(mover scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          if(!scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer(mover, self))
            mover unresolved_collision_nearest_node(self);
        } else
          mover unresolved_collision_nearest_node(self);
      } else
        unresolved_collision_nearest_node(self);

      self.unresolved_collision_count = 0;
    }
  }
}

clear_unresolved_collision_count_next_frame() {
  self endon("unresolved_collision");
  waitframe();

  if(isDefined(self))
    self.unresolved_collision_count = 0;
}

unresolved_collision_owner_damage(player) {
  inflictor = self;

  if(!isDefined(inflictor.owner)) {
    player mover_suicide();
    return;
  }

  _id_136D9D8040CC1EAC = 0;

  if(level.teambased) {
    if(isDefined(inflictor.owner.team) && inflictor.owner.team != player.team)
      _id_136D9D8040CC1EAC = 1;
  } else if(player != inflictor.owner)
    _id_136D9D8040CC1EAC = 1;

  if(!_id_136D9D8040CC1EAC) {
    player mover_suicide();
    return;
  }

  _id_6FDF3DBBB3B42F68 = 1000;

  if(isDefined(inflictor.unresolved_collision_damage))
    _id_6FDF3DBBB3B42F68 = inflictor.unresolved_collision_damage;

  player dodamage(_id_6FDF3DBBB3B42F68, inflictor.origin, inflictor.owner, inflictor, "MOD_CRUSH");
}

unresolved_collision_nearest_node(player, _id_4258FB168FB20BA6) {
  if(isDefined(level.override_unresolved_collision)) {
    self[[level.override_unresolved_collision]](player, _id_4258FB168FB20BA6);
    return;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\cp\utility::is_specops_gametype()) {
    _id_4258FB168FB20BA6 = 1;

    if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(self, 1);

      if(isDefined(seatid)) {
        _id_AA8EFEC6248A879F = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitpositionandangles(self, player, seatid, 1);

        if(isDefined(_id_AA8EFEC6248A879F)) {
          player setOrigin(_id_AA8EFEC6248A879F[0]);
          return;
        }
      }
    }
  } else {
    nodes = self.unresolved_collision_nodes;

    if(isDefined(nodes))
      nodes = sortbydistance(nodes, player.origin);
    else {
      nodes = getnodesinradius(player.origin, 300, 0, 200);
      nodes = sortbydistance(nodes, player.origin);
    }

    _id_CD2C014424008317 = (0, 0, -100);
    player cancelmantle();
    player dontinterpolate();
    player setOrigin(player.origin + _id_CD2C014424008317);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
      _id_D554296707528E80 = nodes[_id_AC0E594AC96AA3A8];
      org = _id_D554296707528E80.origin;

      if(!canspawn(org)) {
        continue;
      }
      if(positionwouldtelefrag(org)) {
        continue;
      }
      if(player getstance() == "prone")
        player setstance("crouch");

      player setOrigin(org);
      return;
    }

    player setOrigin(player.origin - _id_CD2C014424008317);
  }

  if(!isDefined(_id_4258FB168FB20BA6))
    _id_4258FB168FB20BA6 = 1;

  if(_id_4258FB168FB20BA6)
    player mover_suicide();
}

unresolved_collision_void(player, _id_1EE51B0A59B58D1E) {}

mover_suicide() {
  if(isDefined(level.ishorde) && !isagent(self)) {
    return;
  }
  scripts\cp\utility::_suicide();
}

player_pushed_kill(_id_2267C8D9F12685B3) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for(;;) {
    self waittill("player_pushed", player, _id_3346EC1BCECB9711);

    if(isPlayer(player) || isagent(player)) {
      _id_360E0B041DF08CAC = length(_id_3346EC1BCECB9711);

      if(_id_360E0B041DF08CAC >= _id_2267C8D9F12685B3)
        unresolved_collision_owner_damage(player);
    }
  }
}

stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

script_mover_get_top_parent() {
  _id_573BC6F86B3288E0 = self getlinkedparent();

  for(parent = _id_573BC6F86B3288E0; isDefined(parent); parent = parent getlinkedparent())
    _id_573BC6F86B3288E0 = parent;

  return _id_573BC6F86B3288E0;
}

script_mover_start_use(_id_DBCE45A33308630D) {
  _id_716617EA25261328 = _id_DBCE45A33308630D script_mover_get_top_parent();

  if(isDefined(_id_716617EA25261328))
    _id_716617EA25261328.startuseorigin = _id_716617EA25261328.origin;

  self.startusemover = self getmovingplatformparent();

  if(isDefined(self.startusemover)) {
    _id_573BC6F86B3288E0 = self.startusemover script_mover_get_top_parent();

    if(isDefined(_id_573BC6F86B3288E0))
      self.startusemover = _id_573BC6F86B3288E0;

    self.startusemover.startuseorigin = self.startusemover.origin;
  }
}

script_mover_has_parent_moved(parent) {
  if(!isDefined(parent))
    return 0;

  return lengthsquared(parent.origin - parent.startuseorigin) > 0.001;
}

script_mover_use_can_link(ent) {
  if(!isPlayer(self))
    return 1;

  if(!isDefined(ent))
    return 0;

  _id_573BC6F86B3288E0 = ent script_mover_get_top_parent();
  _id_AD23FD3579008374 = self.startusemover;

  if(!isDefined(_id_573BC6F86B3288E0) && !isDefined(_id_AD23FD3579008374))
    return 1;

  if(isDefined(_id_573BC6F86B3288E0) && isDefined(_id_AD23FD3579008374) && _id_573BC6F86B3288E0 == _id_AD23FD3579008374)
    return 1;

  if(script_mover_has_parent_moved(_id_573BC6F86B3288E0))
    return 0;

  if(script_mover_has_parent_moved(_id_AD23FD3579008374))
    return 0;

  return 1;
}

script_mover_link_to_use_object(player) {
  if(isPlayer(player)) {
    player script_mover_start_use(self);
    playermover = player getmovingplatformparent();
    _id_AAF7642EE16A1E33 = undefined;

    if(isDefined(playermover))
      _id_AAF7642EE16A1E33 = playermover;
    else if(!isDefined(script_mover_get_top_parent()))
      _id_AAF7642EE16A1E33 = self;
    else {
      _id_AAF7642EE16A1E33 = spawn("script_model", player.origin);
      _id_AAF7642EE16A1E33 setModel("tag_origin");
      player.scriptmoverlinkdummy = _id_AAF7642EE16A1E33;
      player thread sciprt_mover_use_object_wait_for_disconnect(_id_AAF7642EE16A1E33);
    }

    player playerlinkTo(_id_AAF7642EE16A1E33);
  } else
    player linkTo(self);

  player playerlinkedoffsetenable();
}

script_mover_unlink_from_use_object(player) {
  player unlink();

  if(isDefined(player.scriptmoverlinkdummy)) {
    player notify("removeMoverLinkDummy");
    player.scriptmoverlinkdummy delete();
    player.scriptmoverlinkdummy = undefined;
  }
}

sciprt_mover_use_object_wait_for_disconnect(_id_262B8635E7FF6ADB) {
  self endon("removeMoverLinkDummy");
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  self.scriptmoverlinkdummy delete();
  self.scriptmoverlinkdummy = undefined;
}

notify_moving_platform_invalid() {
  children = self getlinkedchildren(0);

  if(!isDefined(children)) {
    return;
  }
  foreach(child in children) {
    if(isDefined(child.no_moving_platfrom_unlink) && child.no_moving_platfrom_unlink) {
      continue;
    }
    child unlink();
    child notify("invalid_parent", self);
  }
}

process_moving_platform_death(data, _id_36C12D04A03471D6) {
  if(isDefined(_id_36C12D04A03471D6) && isDefined(_id_36C12D04A03471D6.no_moving_platfrom_death) && _id_36C12D04A03471D6.no_moving_platfrom_death) {
    return;
  }
  if(isDefined(data.deathoverridecallback)) {
    data.lasttouchedplatform = _id_36C12D04A03471D6;
    self thread[[data.deathoverridecallback]](data);
  } else
    self delete();
}

handle_moving_platform_touch(data) {
  self notify("handle_moving_platform_touch");
  self endon("handle_moving_platform_touch");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(isDefined(data.endonstring))
    self endon(data.endonstring);

  for(;;) {
    self waittill("touching_platform", _id_36C12D04A03471D6);

    if(isDefined(data.validateaccuratetouching) && data.validateaccuratetouching) {
      if(!self istouching(_id_36C12D04A03471D6)) {
        wait 0.05;
        continue;
      }
    }

    thread process_moving_platform_death(data, _id_36C12D04A03471D6);
    break;
  }
}

handle_moving_platform_invalid(data) {
  self notify("handle_moving_platform_invalid");
  self endon("handle_moving_platform_invalid");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(isDefined(data.endonstring))
    self endon(data.endonstring);

  self waittill("invalid_parent", _id_36C12D04A03471D6);

  if(isDefined(data.invalidparentoverridecallback))
    self thread[[data.invalidparentoverridecallback]](data);
  else
    thread process_moving_platform_death(data, _id_36C12D04A03471D6);
}

handle_moving_platforms(data) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(data))
    data = spawnStruct();

  if(isDefined(data.endonstring))
    self endon(data.endonstring);

  if(isDefined(data.linkparent)) {
    parent = self getlinkedparent();

    if(!isDefined(parent) || parent != data.linkparent)
      self linkTo(data.linkparent);
  }

  if(isDefined(data.linkparents)) {
    if(isarray(data.linkparents)) {
      foreach(_id_BF8E5F003146AF44 in data.linkparents) {
        parent = self getlinkedparent();

        if(!isDefined(parent) || parent != _id_BF8E5F003146AF44)
          self linkTo(_id_BF8E5F003146AF44);
      }
    }
  }

  thread handle_moving_platform_touch(data);
  thread handle_moving_platform_invalid(data);
}

stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

moving_platform_empty_func(data) {}