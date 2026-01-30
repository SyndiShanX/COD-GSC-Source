/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_movers.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

SCRIPT_MOVER_NOTIFY_NAME = "script_mover_anim";

main() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
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

  script_mover_add_hintString("activate", &"MP_ACTIVATE_MOVER");

  script_mover_add_parameters("none", "");

  level.script_mover_named_goals = [];

  level.script_mover_animations = [];

  waitframe();

  movers = [];
  classnames = script_mover_classnames();
  foreach(class in classnames) {
    movers = array_combine(movers, getEntArray(class, "classname"));
  }
  array_thread(movers, ::script_mover_init);
}

script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

script_mover_is_script_mover() {
  if(isDefined(self.script_mover)) {
    return self.script_mover;
  }

  classnames = script_mover_classnames();
  foreach(class in classnames) {
    if(self.classname == class) {
      self.script_mover = true;
      return true;
    }
  }

  return false;
}

script_mover_add_hintString(name, hintString) {
  if(!isDefined(level.script_mover_hintstrings)) {
    level.script_mover_hintstrings = [];
  }

  level.script_mover_hintstrings[name] = hintString;
}

script_mover_add_parameters(name, parameters) {
  if(!isDefined(level.script_mover_parameters)) {
    level.script_mover_parameters = [];
  }
  level.script_mover_parameters[name] = parameters;
}

script_mover_add_animation(scene_name, animation_string, animation_ref, optional_type) {
  if(!isDefined(level.script_mover_animations)) {
    level.script_mover_animations = [];
  }

  if(!isDefined(optional_type)) {
    optional_type = "default";
  }

  if(!isDefined(level.script_mover_animations[scene_name])) {
    level.script_mover_animations[scene_name] = [];
  }

  anim_info = spawnStruct();
  anim_info.animname = animation_string;
  anim_info.animref = animation_ref;

  level.script_mover_animations[scene_name][optional_type] = anim_info;
}

script_mover_init() {
  self.script_mover = true;
  self.moving = false;

  self.origin_ent = self;

  self.use_triggers = [];
  self.linked_ents = [];

  structs = [];
  if(isDefined(self.target)) {
    structs = GetStructArray(self.target, "targetname");
  }

  foreach(target in structs) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }

    switch (target.script_noteworthy) {
      case "origin":
        if(!isDefined(target.angles)) {
          target.angles = (0, 0, 0);
        }
        self.origin_ent = spawn("script_model", target.origin);
        self.origin_ent.angles = target.angles;
        self.origin_ent setModel("tag_origin");
        self.origin_ent LinkTo(self);
        break;
      case "scripted_node":
      case "scene_node":
        if(!isDefined(target.angles)) {
          target.angles = (0, 0, 0);
        }
        self.scripted_node = target;
        break;
      default:
        break;
    }
  }

  ents = [];
  if(isDefined(self.target)) {
    ents = getEntArray(self.target, "targetname");
  }
  foreach(target in ents) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }

    toks = StrTok(target.script_noteworthy, ";");
    foreach(tok in toks) {
      switch (tok) {
        case "use_trigger_link":
          target EnableLinkTo();
          target LinkTo(self);

        case "use_trigger":
          target script_mover_parse_targets();
          self thread script_mover_use_trigger(target);
          self.use_triggers[self.use_triggers.size] = target;
          break;
        case "link":
          target LinkTo(self);
          self.linked_ents[self.linked_ents.size] = target;
          break;
        default:
          break;
      }
    }
  }

  self thread script_mover_parse_targets();
  self thread script_mover_init_move_parameters();
  self thread script_mover_save_default_move_parameters();
  self thread script_mover_set_defaults();
  self thread script_mover_apply_move_parameters(self);
  self thread script_mover_reset_init();

  script_mover_start();

  foreach(trigger in self.use_triggers) {
    self script_mover_set_usable(trigger, true);
  }

  self.script_mover_init = true;
  self notify("script_mover_init");
}

script_mover_start() {
  if(self script_mover_is_animated()) {
    self thread script_mover_animate();
  } else {
    self thread script_mover_move_to_target();
  }
}

script_mover_reset_init() {
  self.mover_reset_origin = self.origin;
  self.mover_reset_angles = self.angles;
}

script_mover_reset(unused) {
  self notify("mover_reset");
  if(self script_mover_is_animated()) {
    self ScriptModelClearAnim();
  }
  self.origin = self.mover_reset_origin;
  self.angles = self.mover_reset_angles;
  self notify("new_path");

  waitframe();

  self script_mover_start();
}

script_mover_use_trigger(trigger) {
  self endon("death");
  while(1) {
    trigger waittill("trigger");

    if(trigger.goals.size > 0) {
      self notify("new_path");
      self thread script_mover_move_to_target(trigger);
    } else {
      self notify("trigger");
    }
  }
}

script_mover_move_to_named_goal(goal_name) {
  if(isDefined(level.script_mover_named_goals[goal_name])) {
    self notify("new_path");
    self.goals = level.script_mover_named_goals[goal_name];
    self thread script_mover_move_to_target();
  }
}

anglesClamp180(angles) {
  return (AngleClamp180(angles[0]), AngleClamp180(angles[1]), AngleClamp180(angles[2]));
}

script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }

  self.parsed = true;

  self.goals = [];
  self.movers = [];

  structs = [];
  ents = [];
  if(isDefined(self.target)) {
    structs = GetStructArray(self.target, "targetname");
    ents = getEntArray(self.target, "targetname");
  }

  for(i = 0; i < structs.size; i++) {
    target = structs[i];
    if(!isDefined(target.script_noteworthy)) {
      target.script_noteworthy = "goal";
    }

    switch (target.script_noteworthy) {
      case "ignore":
        if(isDefined(target.target)) {
          add_structs = GetStructArray(target.target, "targetname");
          foreach(add in add_structs) {
            structs[structs.size] = add;
          }
        }
        break;
      case "goal":
        target script_mover_init_move_parameters();
        target script_mover_parse_targets();
        self.goals[self.goals.size] = target;
        if(isDefined(target.params["name"])) {
          if(!isDefined(level.script_mover_named_goals[target.params["name"]])) {
            level.script_mover_named_goals[target.params["name"]] = [];
          }

          size = level.script_mover_named_goals[target.params["name"]].size;
          level.script_mover_named_goals[target.params["name"]][size] = target;
        }
        break;
      default:
        break;
    }
  }

  foreach(ent in ents) {
    if(ent script_mover_is_script_mover()) {
      self.movers[self.movers.size] = ent;
    }

    self thread script_mover_parse_ent(ent);
  }
}

script_mover_parse_ent(ent) {
  if(!isDefined(ent.script_noteworthy)) {
    return;
  }

  if(ent script_mover_is_script_mover() && !isDefined(ent.script_mover_init)) {
    ent waittill("script_mover_init");
  }

  notes = StrTok(ent.script_noteworthy, ";");
  foreach(note in notes) {
    toks = StrTok(note, "_");
    if(toks.size < 3 || toks[1] != "on") {
      continue;
    }

    action = ToLower(toks[0]);
    action_notify = toks[2];
    for(i = 3; i < toks.size; i++) {
      action_notify = action_notify + "_" + toks[i];
    }

    switch (action) {
      case "connectpaths":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_connectpaths, ::script_mover_disconnectpaths);
        break;
      case "disconnectpaths":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_disconnectpaths, ::script_mover_connectpaths);
        break;
      case "solid":
        ent NotSolid();
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_solid, ::script_mover_notsolid);
        break;
      case "notsolid":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_notsolid, ::script_mover_solid);
        break;
      case "delete":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_delete);
        break;
      case "hide":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_hide, ::script_mover_show);
        break;
      case "show":
        ent Hide();
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_show, ::script_mover_hide);
        break;
      case "triggerhide":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_trigger_off, ::script_mover_trigger_on);
        break;
      case "triggershow":
        ent trigger_off();
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_trigger_on, ::script_mover_trigger_off);
        break;
      case "trigger":
        self thread script_mover_func_on_notify(ent, action_notify, ::script_mover_trigger, ::script_mover_reset);
        break;
      default:
        break;
    }
  }
}

script_mover_trigger_off(mover) {
  self DontInterpolate();
  self trigger_off();
}

script_mover_trigger_on(mover) {
  self DontInterpolate();
  self trigger_on();
}

script_mover_notify(mover, note) {
  mover notify(note);
}

script_mover_levelnotify(mover, note) {
  level notify(note);
}

script_mover_connectpaths(mover) {
  self ConnectPaths();
}

script_mover_disconnectpaths(mover) {
  self DisconnectPaths(mover);
}

script_mover_solid(mover) {
  self solid();
}

script_mover_notsolid(mover) {
  self NotSolid();
}

script_mover_delete(mover) {
  self delete();
}

script_mover_hide(mover) {
  self Hide();
}

script_mover_show(mover) {
  self show();
}

script_mover_trigger(mover) {
  self notify("trigger");
}

script_mover_func_on_notify(ent, note, func, reset_func) {
  self endon("death");
  ent endon("death");

  while(1) {
    self waittill(note, mover);

    ent[[func]](mover);

    if(isDefined(reset_func) && isDefined(mover)) {
      mover script_mover_watch_for_reset(ent, reset_func);
    } else {
      break;
    }
  }
}

script_mover_update_paths() {
  dynamic_path_ents = [];
  if(self script_mover_is_dynamic_path()) {
    dynamic_path_ents[dynamic_path_ents.size] = self;
  }

  foreach(linked_ent in self.linked_ents) {
    if(linked_ent script_mover_is_dynamic_path()) {
      dynamic_path_ents[dynamic_path_ents.size] = linked_ent;
    }
  }

  if(dynamic_path_ents.size == 0) {
    return;
  }

  while(1) {
    foreach(ent in dynamic_path_ents) {
      ent script_mover_disconnectpaths();
    }

    self waittill("move_start");

    foreach(ent in dynamic_path_ents) {
      ent script_mover_connectpaths();
    }

    self waittill("move_end");
  }
}

script_mover_animate() {
  self childthread script_mover_update_paths();

  scene_name = self.params["animation"];

  if(isDefined(level.script_mover_animations[scene_name]["idle"])) {
    script_mover_play_animation(level.script_mover_animations[scene_name]["idle"], false);
  }

  self script_mover_delay();

  self notify("move_start");
  self notify("start", self);
  default_anim_info = level.script_mover_animations[scene_name]["default"];
  if(isDefined(default_anim_info)) {
    script_mover_play_animation(default_anim_info, true);
    self waittill("end");
  }
  self notify("move_end");
}

script_mover_play_animation(anim_info, process_notetracks) {
  self notify("play_animation");
  if(process_notetracks) {
    self thread script_mover_handle_notetracks();
  }

  if(isDefined(self.scripted_node)) {
    self ScriptModelPlayAnimDeltaMotionFromPos(anim_info.animname, self.scripted_node.origin, self.scripted_node.angles, SCRIPT_MOVER_NOTIFY_NAME);
  } else {
    self ScriptModelPlayAnimDeltaMotion(anim_info.animname, SCRIPT_MOVER_NOTIFY_NAME);
  }
}

script_mover_handle_notetracks() {
  self endon("play_animation");
  self endon("mover_reset");

  while(1) {
    self waittill(SCRIPT_MOVER_NOTIFY_NAME, note);
    self notify(note, self);
  }
}

script_mover_delay() {
  if(isDefined(self.params["delay_till"])) {
    level waittill(self.params["delay_till"]);
  }

  if(isDefined(self.params["delay_till_trigger"]) && self.params["delay_till_trigger"]) {
    self waittill("trigger");
  }

  if(self.params["delay_time"] > 0) {
    wait self.params["delay_time"];
  }
}

script_mover_move_to_target(current) {
  self endon("death");
  self endon("new_path");

  self childthread script_mover_update_paths();

  if(!isDefined(current)) {
    current = self;
  }

  while(current.goals.size != 0) {
    goal = random(current.goals);

    mover = self;

    mover script_mover_apply_move_parameters(goal);

    mover script_mover_delay();

    move_time = mover.params["move_time"];
    accel_time = mover.params["accel_time"];
    decel_time = mover.params["decel_time"];

    is_moveTo = false;
    is_rotateTo = false;

    trans = TransformMove(goal.origin, goal.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);
    if(mover.origin != goal.origin) {
      if(isDefined(mover.params["move_speed"])) {
        dist = distance(mover.origin, goal.origin);
        move_time = dist / mover.params["move_speed"];
      }

      if(isDefined(mover.params["accel_frac"])) {
        accel_time = mover.params["accel_frac"] * move_time;
      }

      if(isDefined(mover.params["decel_frac"])) {
        decel_time = mover.params["decel_frac"] * move_time;
      }

      if(move_time <= 0) {
        mover DontInterpolate();
        mover.origin = trans["origin"];
      } else {
        mover MoveTo(trans["origin"], move_time, accel_time, decel_time);
      }

      is_moveTo = true;
    }

    if(anglesClamp180(trans["angles"]) != anglesClamp180(mover.angles)) {
      if(move_time <= 0) {
        mover DontInterpolate();
        mover.angles = trans["angles"];
      } else {
        mover RotateTo(trans["angles"], move_time, accel_time, decel_time);
      }

      is_rotateTo = true;
    }

    foreach(targeted_mover in mover.movers) {
      targeted_mover notify("trigger");
      self script_mover_watch_for_reset(targeted_mover, ::script_mover_reset);
    }

    mover notify("move_start");
    current notify("depart", mover);

    if(isDefined(mover.params["name"])) {
      notifyStr = "mover_depart_" + mover.params["name"];
      mover notify(notifyStr);
      level notify(notifyStr, mover);
    }

    mover script_mover_allow_usable(false);

    if(move_time <= 0) {} else if(is_moveTo) {
      mover waittill("movedone");
    } else if(is_rotateTo) {
      mover waittill("rotatedone");
    } else {
      wait move_time;
    }

    mover notify("move_end");
    goal notify("arrive", mover);

    if(isDefined(mover.params["name"])) {
      notifyStr = "mover_arrive_" + mover.params["name"];
      mover notify(notifyStr);
      level notify(notifyStr, mover);
    }

    if(isDefined(mover.params["solid"])) {
      if(mover.params["solid"]) {
        mover solid();
      } else {
        mover notsolid();
      }
    }

    foreach(targeted_mover in goal.movers) {
      targeted_mover notify("trigger");
      self script_mover_watch_for_reset(targeted_mover, ::script_mover_reset);
    }

    if(isDefined(mover.params["wait_till"])) {
      level waittill(mover.params["wait_till"]);
    }

    if(mover.params["wait_time"] > 0) {
      wait mover.params["wait_time"];
    }

    mover script_mover_allow_usable(true);

    current = goal;
  }
}

script_mover_watch_for_reset(ent, func) {
  self thread script_mover_func_on_notify(ent, "mover_reset", func);
}

script_mover_init_move_parameters() {
  self.params = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = anglesClamp180(self.angles);

  script_mover_parse_move_parameters(self.script_parameters);
}

script_mover_parse_move_parameters(parameters) {
  if(!isDefined(parameters)) {
    parameters = "";
  }

  params = StrTok(parameters, ";");
  foreach(param in params) {
    toks = strtok(param, "=");
    if(toks.size != 2) {
      continue;
    }

    if(toks[1] == "undefined" || toks[1] == "default") {
      self.params[toks[0]] = "<undefined>";
      continue;
    }

    switch (toks[0]) {
      case "move_speed":
      case "accel_frac":
      case "decel_frac":
      case "move_time":
      case "accel_time":
      case "decel_time":
      case "wait_time":
      case "delay_time":
        self.params[toks[0]] = script_mover_parse_range(toks[1]);
        break;
      case "wait_till":
      case "delay_till":
      case "name":
      case "hintstring":
      case "animation":
        self.params[toks[0]] = toks[1];
        break;
      case "usable":
      case "delay_till_trigger":
      case "solid":
        self.params[toks[0]] = int(toks[1]);
        break;
      case "script_params":
        param_name = toks[1];
        additional_params = level.script_mover_parameters[param_name];
        if(isDefined(additional_params)) {
          script_mover_parse_move_parameters(additional_params);
        }
        break;
      default:
        break;
    }
  }
}

script_mover_parse_range(str) {
  value = 0;

  toks = strtok(str, ",");
  if(toks.size == 1) {
    value = float(toks[0]);
  } else if(toks.size == 2) {
    minValue = float(toks[0]);
    maxValue = float(toks[1]);

    if(minValue >= maxValue) {
      value = minValue;
    } else {
      value = RandomFloatRange(minValue, maxValue);
    }
  }

  return value;
}

script_mover_apply_move_parameters(from) {
  foreach(key, value in from.params) {
    script_mover_set_param(key, value);
  }

  script_mover_set_defaults();
}

script_mover_set_param(param_name, value) {
  if(!isDefined(param_name)) {
    return;
  }

  if(param_name == "usable" && isDefined(value)) {
    self script_mover_set_usable(self, value);
  }

  if(isDefined(value) && isString(value) && value == "<undefined>") {
    value = undefined;
  }

  self.params[param_name] = value;
}

script_mover_allow_usable(usable) {
  if(self.params["usable"]) {
    self script_mover_set_usable(self, usable);
  }
  foreach(trigger in self.use_triggers) {
    self script_mover_set_usable(trigger, usable);
  }
}

script_mover_set_usable(use_ent, usable) {
  if(usable) {
    use_ent MakeUsable();
    use_ent SetCursorHint("HINT_ACTIVATE");
    use_ent SetHintString(level.script_mover_hintstrings[self.params["hintstring"]]);
  } else {
    use_ent MakeUnusable();
  }
}

script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(key, value in self.params) {
    self.params_default[key] = value;
  }
}

script_mover_set_defaults() {
  if(isDefined(self.params_default)) {
    foreach(key, value in self.params_default) {
      if(!isDefined(self.params[key])) {
        script_mover_set_param(key, value);
      }
    }
  }

  foreach(key, value in level.script_mover_defaults) {
    if(!isDefined(self.params[key])) {
      script_mover_set_param(key, value);
    }
  }
}

script_mover_is_dynamic_path() {
  return (isDefined(self.spawnflags) && (self.spawnflags & 1));
}

script_mover_is_animated() {
  return isDefined(self.params["animation"]);
}

init() {
  level thread script_mover_connect_watch();
  level thread script_mover_agent_spawn_watch();
}

script_mover_connect_watch() {
  while(1) {
    level waittill("connected", player);
    player thread player_unresolved_collision_watch();
  }
}

script_mover_agent_spawn_watch() {
  while(1) {
    level waittill("spawned_agent", agent);
    agent thread player_unresolved_collision_watch();
  }
}

player_unresolved_collision_watch() {
  self endon("disconnect");
  if(IsAgent(self)) {
    self endon("death");
  }

  self.unresolved_collision_count = 0;
  while(1) {
    self waittill("unresolved_collision", mover);
    self.unresolved_collision_count++;
    self thread clear_unresolved_collision_count_next_frame();

    unresolved_collision_notify_min = 3;
    if(isDefined(mover) && isDefined(mover.unresolved_collision_notify_min)) {
      unresolved_collision_notify_min = mover.unresolved_collision_notify_min;
    }

    if(self.unresolved_collision_count >= unresolved_collision_notify_min) {
      if(isDefined(mover)) {
        if(isDefined(mover.unresolved_collision_func)) {
          mover[[mover.unresolved_collision_func]](self);
        } else if(isDefined(mover.unresolved_collision_kill) && mover.unresolved_collision_kill) {
          mover unresolved_collision_owner_damage(self);
        } else {
          mover unresolved_collision_nearest_node(self);
        }
      } else {
        unresolved_collision_nearest_node(self);
      }
      self.unresolved_collision_count = 0;
    }
  }
}

clear_unresolved_collision_count_next_frame() {
  self endon("unresolved_collision");
  waitframe();
  if(isDefined(self)) {
    self.unresolved_collision_count = 0;
  }
}

unresolved_collision_owner_damage(player) {
  inflictor = self;

  if(!isDefined(inflictor.owner)) {
    player maps\mp\_movers::mover_suicide();
    return;
  }

  canInflictorOwnerDamagePlayer = false;

  if(level.teambased) {
    if(isDefined(inflictor.owner.team) && inflictor.owner.team != player.team) {
      canInflictorOwnerDamagePlayer = true;
    }
  } else {
    if(player != inflictor.owner) {
      canInflictorOwnerDamagePlayer = true;
    }
  }

  if(!canInflictorOwnerDamagePlayer) {
    player maps\mp\_movers::mover_suicide();
    return;
  }

  damage_ammount = 1000;
  if(isDefined(inflictor.unresolved_collision_damage)) {
    damage_ammount = inflictor.unresolved_collision_damage;
  }

  player DoDamage(damage_ammount, inflictor.origin, inflictor.owner, inflictor, "MOD_CRUSH");
}

unresolved_collision_nearest_node(player, bAllowSuicide) {
  nodes = self.unresolved_collision_nodes;
  if(isDefined(nodes)) {
    nodes = SortByDistance(nodes, player.origin);
  } else {
    nodes = GetNodesInRadius(player.origin, 300, 0, 200);
    nodes = SortByDistance(nodes, player.origin);
  }

  avoid_telefrag_offset = (0, 0, -100);

  player CancelMantle();
  player DontInterpolate();
  player SetOrigin(player.origin + avoid_telefrag_offset);

  for(i = 0; i < nodes.size; i++) {
    check_node = nodes[i];

    org = check_node.origin;
    if(!Canspawn(org)) {
      continue;
    }

    if(PositionWouldTelefrag(org)) {
      continue;
    }

    if(player GetStance() == "prone") {
      player Setstance("crouch");
    }

    player SetOrigin(org);
    return;
  }

  player SetOrigin(player.origin - avoid_telefrag_offset);

  if(!isDefined(bAllowSuicide)) {
    bAllowSuicide = true;
  }

  if(bAllowSuicide) {
    player mover_suicide();
  }
}

unresolved_collision_void(player) {}

mover_suicide() {
  if(isDefined(level.isHorde) && !IsAgent(self)) {
    return;
  }

  self _suicide();
}

player_pushed_kill(min_mph) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  while(1) {
    self waittill("player_pushed", player, platformMPH);
    if(isPlayer(player) || isAgent(player)) {
      mph = Length(platformMPH);

      if(mph >= min_mph) {
        self unresolved_collision_owner_damage(player);
      }
    }
  }
}

stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

notify_moving_platform_invalid() {
  children = self GetLinkedChildren(false);
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

process_moving_platform_death(data, platform) {
  if(isDefined(platform) && isDefined(platform.no_moving_platfrom_death) && platform.no_moving_platfrom_death) {
    return;
  }

  if(isDefined(data.playDeathFx)) {
    playFX(getfx("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(data.deathOverrideCallback)) {
    self thread[[data.deathOverrideCallback]](data);
  } else {
    self delete();
  }
}

handle_moving_platform_touch(data) {
  while(1) {
    self waittill("touching_platform", platform);

    if(isDefined(data.touchingPlatformValid) && !self[[data.touchingPlatformValid]](platform)) {
      continue;
    }

    if(isDefined(data.validateAccurateTouching) && data.validateAccurateTouching) {
      if(!self IsTouching(platform)) {
        wait(0.05);
        continue;
      }
    }

    self thread process_moving_platform_death(data, platform);
    break;
  }
}

handle_moving_platform_invalid(data) {
  self waittill("invalid_parent", platform);
  if(isDefined(data.invalidParentOverrideCallback)) {
    self thread[[data.invalidParentOverrideCallback]](data);
  } else {
    self thread process_moving_platform_death(data, platform);
  }
}

handle_moving_platforms(data) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");

  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(data)) {
    data = spawnStruct();
  }

  if(isDefined(data.endonString)) {
    self endon(data.endonString);
  }

  if(isDefined(data.linkParent)) {
    self linkto(data.linkParent);
  }

  childthread handle_moving_platform_touch(data);
  childthread handle_moving_platform_invalid(data);
}

stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

moving_platform_empty_func(data) {}