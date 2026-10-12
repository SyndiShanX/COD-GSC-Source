/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\movers.gsc
***********************************************/

#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\movers;
#using scripts\mp\utility\damage;
#using scripts\mp\weapons;
#namespace movers;

function main() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
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
  classnames = script_mover_classnames();

  foreach(class in classnames) {
    movers = array_combine(movers, getEntArray(class, "classname"));
  }

  array_thread(movers, &script_mover_int);
}

function script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

function script_mover_is_script_mover() {
  if(isDefined(self.script_mover)) {
    return self.script_mover;
  }

  classnames = script_mover_classnames();

  foreach(class in classnames) {
    if(self.classname == class) {
      self.script_mover = 1;
      return 1;
    }
  }

  return 0;
}

function script_mover_add_hintstring(name, hintstring) {
  if(!isDefined(level.script_mover_hintstrings)) {
    level.script_mover_hintstrings = [];
  }

  level.script_mover_hintstrings[name] = hintstring;
}

function script_mover_add_parameters(name, parameters) {
  if(!isDefined(level.script_mover_parameters)) {
    level.script_mover_parameters = [];
  }

  level.script_mover_parameters[name] = parameters;
}

function script_mover_int() {
  if(!isDefined(self.target)) {
    return;
  }

  self.script_mover = 1;
  self.moving = 0;
  self.origin_ent = self;
  self.use_triggers = [];
  self.linked_ents = [];
  structs = getStructArray(self.target, "targetname");

  foreach(target in structs) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }

    switch (target.script_noteworthy) {
      case #"hash_6479a60057df5aaf":
        if(!isDefined(target.angles)) {
          target.angles = (0, 0, 0);
        }

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
      case #"hash_66b78ac7e1f6f148":
        target enablelinkTo();
        target linkTo(self);
      case #"hash_cbaf3545ee235037":
        target script_mover_parse_targets();
        thread script_mover_use_trigger(target);
        self.use_triggers[self.use_triggers.size] = target;
        break;
      case #"hash_6fb23e39e833ccc9":
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

  foreach(trigger in self.use_triggers) {
    script_mover_set_usable(trigger, 1);
  }
}

function script_mover_use_trigger(trigger) {
  self endon("death");

  while(true) {
    trigger waittill("trigger");

    if(trigger.goals.size > 0) {
      self notify("new_path");
      thread script_mover_move_to_target(trigger);
      continue;
    }

    self notify("trigger");
  }
}

function script_mover_move_to_named_goal(goal_name) {
  if(isDefined(level.script_mover_named_goals[goal_name])) {
    self notify("new_path");
    self.goals = [level.script_mover_named_goals[goal_name]];
    thread script_mover_move_to_target();
  }
}

function anglesclamp180(angles) {
  return (angleclamp180(angles[0]), angleclamp180(angles[1]), angleclamp180(angles[2]));
}

function script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }

  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  self.level_notify = [];
  structs = [];
  ents = [];

  if(isDefined(self.target)) {
    structs = getStructArray(self.target, "targetname");
    ents = getEntArray(self.target, "targetname");
  }

  for(i = 0; i < structs.size; i++) {
    target = structs[i];

    if(!isDefined(target.script_noteworthy)) {
      target.script_noteworthy = "goal";
    }

    switch (target.script_noteworthy) {
      case #"hash_f4a879c6a099e6a3":
        if(isDefined(target.target)) {
          add_structs = getStructArray(target.target, "targetname");

          foreach(add in add_structs) {
            structs[structs.size] = add;
          }
        }

        break;
      case #"hash_8d43150f19c69bd6":
        target script_mover_init_move_parameters();
        target script_mover_parse_targets();
        self.goals[self.goals.size] = target;

        if(isDefined(target.params["name"])) {
          level.script_mover_named_goals[target.params["name"]] = target;
        }

        break;
      case #"hash_9d36212eda6f7813":
        if(isDefined(target.script_parameters)) {
          self.level_notify[self.level_notify.size] = target;
        }

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

    toks = strtok(ent.script_noteworthy, "_");

    if(toks.size != 3 || toks[1] != "on") {
      continue;
    }

    switch (toks[0]) {
      case #"hash_897c0184865c23aa":
        thread script_mover_call_func_on_notify(ent, &delete, toks[2]);
        break;
      case #"hash_7ebb454a971d80d":
        thread script_mover_call_func_on_notify(ent, &hide, toks[2]);
        break;
      case #"hash_ca51c18a00a0a89c":
        ent hide();
        thread script_mover_call_func_on_notify(ent, &show, toks[2]);
        break;
      case #"hash_6fc6a816bd9d0753":
      case #"hash_a604a8dc3d70bb33":
        thread script_mover_func_on_notify(ent, &trigger_off, toks[2]);
        break;
      case #"hash_59c0513670a01816":
      case #"hash_8cd851fbedf962f6":
        ent trigger_off();
        thread script_mover_func_on_notify(ent, &trigger_on, toks[2]);
        break;
      default:
        break;
    }
  }
}

function script_mover_func_on_notify(ent, func, note) {
  self endon("death");
  ent endon("death");

  while(true) {
    self waittill(note);
    ent[[func]]();
  }
}

function script_mover_call_func_on_notify(ent, func, note) {
  self endon("death");
  ent endon("death");

  while(true) {
    self waittill(note);
    ent builtin[[func]]();
  }
}

function script_mover_trigger_on() {
  trigger_on();
}

function script_mover_move_to_target(current) {
  self endon("death");
  self endon("new_path");

  if(!isDefined(current)) {}

  for(current = self; current.goals.size != 0; current = goal) {
    goal = random(current.goals);
    mover = self;
    mover script_mover_apply_move_parameters(goal);

    if(isDefined(mover.params["delay_till"])) {
      level waittill(mover.params["delay_till"]);
    }

    if(isDefined(mover.params["delay_till_trigger"]) && mover.params["delay_till_trigger"]) {
      self waittill("trigger");
    }

    if(mover.params["delay_time"] > 0) {
      wait mover.params["delay_time"];
    }

    move_time = mover.params["move_time"];
    accel_time = mover.params["accel_time"];
    decel_time = mover.params["decel_time"];
    is_moveto = 0;
    is_rotateto = 0;
    trans = transformmove(goal.origin, goal.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

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

      mover moveTo(trans["origin"], move_time, accel_time, decel_time);

      foreach(note in goal.level_notify) {
        thread script_mover_run_notify(note.origin, note.script_parameters, self.origin, goal.origin);
      }

      is_moveto = 1;
    }

    if(anglesclamp180(trans["angles"]) != anglesclamp180(mover.angles)) {
      mover rotateTo(trans["angles"], move_time, accel_time, decel_time);
      is_rotateto = 1;
    }

    foreach(targeted_mover in mover.movers) {
      targeted_mover notify("trigger");
    }

    current notify("depart");
    mover script_mover_allow_usable(0);
    self.moving = 1;

    if(isDefined(mover.params["move_time_offset"]) && mover.params["move_time_offset"] + move_time > 0) {
      wait mover.params["move_time_offset"] + move_time;
    } else if(is_moveto) {
      self waittill("movedone");
    } else if(is_rotateto) {
      self waittill("rotatedone");
    } else {
      wait move_time;
    }

    self.moving = 0;
    self notify("move_end");
    goal notify("arrive");

    if(isDefined(mover.params["solid"])) {
      if(mover.params["solid"]) {
        mover solid();
      } else {
        mover notsolid();
      }
    }

    foreach(targeted_mover in goal.movers) {
      targeted_mover notify("trigger");
    }

    if(isDefined(mover.params["wait_till"])) {
      level waittill(mover.params["wait_till"]);
    }

    if(mover.params["wait_time"] > 0) {
      wait mover.params["wait_time"];
    }

    mover script_mover_allow_usable(1);
  }
}

function script_mover_run_notify(notify_origin, level_notify, start, end) {
  self endon("move_end");
  mover = self;
  move_dir = vectorNormalize(end - start);

  while(true) {
    notify_dir = vectorNormalize(notify_origin - mover.origin);

    if(vectordot(move_dir, notify_dir) <= 0) {
      break;
    }

    wait 0.05;
  }

  level notify(level_notify);
}

function script_mover_init_move_parameters() {
  self.params = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = anglesclamp180(self.angles);
  script_mover_parse_move_parameters(self.script_parameters);
}

function script_mover_parse_move_parameters(parameters) {
  if(!isDefined(parameters)) {
    parameters = "";
  }

  params = strtok(parameters, ";");

  foreach(param in params) {
    toks = strtok(param, "=");

    if(toks.size != 2) {
      continue;
    }

    if(toks[1] == "undefined" || toks[1] == "default") {
      self.params[toks[0]] = undefined;
      continue;
    }

    switch (toks[0]) {
      case #"hash_2b74fd1351aa7a2c":
      case #"hash_3c39a00c7c7d0dc4":
      case #"hash_785811f02a52ccba":
      case #"hash_7b12226936aa30c5":
      case #"hash_7ce5e6f06cb19f77":
      case #"hash_85409ed1316ad84c":
      case #"hash_9a32d25bf1504c7e":
      case #"hash_cbf4d1a793ce27c8":
      case #"hash_ee220acc1acae64c":
        self.params[toks[0]] = script_mover_parse_range(toks[1]);
        break;
      case #"hash_3c36bb0c7c7af9ae":
      case #"hash_738c50493c45cf46":
      case #"hash_853da9d13168ab06":
      case #"hash_dde06d8e15af50a1":
        self.params[toks[0]] = toks[1];
        break;
      case #"hash_5277b19543577b0d":
      case #"hash_6cf0fecd49dc6429":
      case #"hash_b669df4fb84dddd4":
        self.params[toks[0]] = int(toks[1]);
        break;
      case #"hash_7eb55b2a3a2f02dd":
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

function script_mover_parse_range(str) {
  value = 0;
  toks = strtok(str, ",");

  if(toks.size == 1) {
    value = float(toks[0]);
  } else if(toks.size == 2) {
    minvalue = float(toks[0]);
    maxvalue = float(toks[1]);

    if(minvalue >= maxvalue) {
      value = minvalue;
    } else {
      value = randomfloatrange(minvalue, maxvalue);
    }
  }

  return value;
}

function script_mover_apply_move_parameters(from) {
  foreach(key, value in from.params) {
    script_mover_set_param(key, value);
  }

  script_mover_set_defaults();
}

function script_mover_set_param(param_name, value) {
  if(!isDefined(param_name)) {
    return;
  }

  if(param_name == "usable" && isDefined(value)) {
    script_mover_set_usable(self, value);
  }

  self.params[param_name] = value;
}

function script_mover_allow_usable(usable) {
  if(self.params["usable"]) {
    script_mover_set_usable(self, usable);
  }

  foreach(trigger in self.use_triggers) {
    script_mover_set_usable(trigger, usable);
  }
}

function script_mover_set_usable(use_ent, usable) {
  if(usable) {
    use_ent makeusable();
    use_ent setCursorHint("HINT_NOICON");
    use_ent setHintString(level.script_mover_hintstrings[self.params["hintstring"]]);
    return;
  }

  use_ent makeunusable();
}

function script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(key, value in self.params) {
    self.params_default[key] = value;
  }
}

function script_mover_set_defaults() {
  foreach(key, value in level.script_mover_defaults) {
    if(!isDefined(self.params[key])) {
      script_mover_set_param(key, value);
    }
  }

  if(isDefined(self.params_default)) {
    foreach(key, value in self.params_default) {
      if(!isDefined(self.params[key])) {
        script_mover_set_param(key, value);
      }
    }
  }
}

function init() {
  level thread script_mover_connect_watch();
  level thread script_mover_agent_spawn_watch();
}

function script_mover_connect_watch() {
  while(true) {
    level waittill("connected", player);
    player thread player_unresolved_collision_watch();
  }
}

function script_mover_agent_spawn_watch() {
  while(true) {
    level waittill("spawned_agent", agent);
    agent thread player_unresolved_collision_watch();
  }
}

function player_update_unresolved_collision(mover, penetration) {
  self.unresolved_collision_count++;
  thread clear_unresolved_collision_count_next_frame();
  unresolved_collision_notify_min = 3;

  if(isDefined(mover) && isDefined(mover.unresolved_collision_notify_min)) {
    unresolved_collision_notify_min = mover.unresolved_collision_notify_min;
  }

  if(self.unresolved_collision_count >= unresolved_collision_notify_min) {
    if(isDefined(mover)) {
      if(isDefined(mover.unresolved_collision_func)) {
        mover[[mover.unresolved_collision_func]](self, penetration);
      } else if(isDefined(mover.unresolved_collision_kill) && mover.unresolved_collision_kill) {
        mover unresolved_collision_owner_damage(self);
      } else {
        var_4c9e50755168f1eb = isDefined(self.lastascenderusetime) && gettime() - self.lastascenderusetime <= 250;

        if(var_4c9e50755168f1eb || mover scripts\cp_mp\vehicles\vehicle::isvehicle() && !scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer(mover, self)) {
          mover unresolved_collision_nearest_node(self, 0, mover, 0);
        } else {
          allowsuicide = player_should_be_killed_by_mover(mover);
          mover unresolved_collision_nearest_node(self, allowsuicide, mover, 0);
        }
      }
    } else {
      allowsuicide = player_should_be_killed_by_mover(mover);
      unresolved_collision_nearest_node(self, allowsuicide, undefined, 0);
    }

    self.unresolved_collision_count = 0;
    return;
  }

  if(self.unresolved_collision_count == 1) {
    if(isPlayer(self) && isDefined(mover)) {
      radius = getdvarint(@ "scr_unresolved_collision_door_check_radius", 1000);
      nearestdoor = function_65eef2622bd403cf(self.origin, radius);

      if(isDefined(nearestdoor) && nearestdoor isscriptableinstance()) {
        allowsuicide = player_should_be_killed_by_mover(mover);
        mover unresolved_collision_nearest_node(self, allowsuicide, mover, 1);
        self.unresolved_collision_count = 0;
      }
    }
  }
}

function player_should_be_killed_by_mover(mover) {
  if(isDefined(mover) && istrue(mover.moverdoesnotkill)) {
    return false;
  }

  return true;
}

function player_unresolved_collision_watch() {
  if(isagent(self)) {
    self endon("death_or_disconnect");
  } else {
    self endon("disconnect");
  }

  self.unresolved_collision_count = 0;

  while(true) {
    self waittill("unresolved_collision", mover, penetration);

    if(player_ignore_mover(mover)) {
      continue;
    }

    player_update_unresolved_collision(mover, penetration);
  }
}

function player_ignore_mover(mover) {
  ignoremover = 0;

  if(isDefined(mover.streakinfo) && mover.streakinfo.streakname == "cruise_predator") {
    ignoremover = 1;
  }

  if(isDefined(mover.carriabletype)) {
    ignoremover = 1;
  }

  if(isPlayer(self) && !scripts\common\values::get("unresolved_collisions")) {
    ignoremover = 1;
  }

  return ignoremover;
}

function clear_unresolved_collision_count_next_frame() {
  self endon("unresolved_collision");
  waitframe();

  if(isDefined(self)) {
    self.unresolved_collision_count = 0;
  }
}

function unresolved_collision_owner_damage(player) {
  inflictor = self;

  if(!isDefined(inflictor.owner)) {
    player scripts\mp\movers::mover_suicide();
    return;
  }

  var_136d9d8040cc1eac = 0;

  if(level.teambased) {
    if(isDefined(inflictor.owner.team) && inflictor.owner.team != player.team) {
      var_136d9d8040cc1eac = 1;
    }
  } else if(player != inflictor.owner) {
    var_136d9d8040cc1eac = 1;
  }

  if(!var_136d9d8040cc1eac) {
    player scripts\mp\movers::mover_suicide();
    return;
  }

  damage_ammount = 1000;

  if(isDefined(inflictor.unresolved_collision_damage)) {
    damage_ammount = inflictor.unresolved_collision_damage;
  }

  player dodamage(damage_ammount, inflictor.origin, inflictor.owner, inflictor, "MOD_CRUSH");
}

function unresolved_collision_nearest_node(player, var_4258fb168fb20ba6, mover, var_8f2da01924d0ae97) {
  if(isDefined(level.override_unresolved_collision)) {
    self[[level.override_unresolved_collision]](player, istrue(var_4258fb168fb20ba6));
    return;
  }

  if(isDefined(mover) && isDefined(mover.override_unresolved_collision)) {
    self[[mover.override_unresolved_collision]](player, istrue(var_4258fb168fb20ba6));
    return;
  }

  if(isDefined(mover)) {
    if(isDefined(mover.elevator)) {
      if(player scripts\common\elevators::isinsideelevator(mover)) {
        return;
      }
    }

    if(isDefined(mover.cover)) {
      if(player ishanging()) {
        player clearhanging();
      }
    }

    if(scripts\cp_mp\utility\game_utility::islargemap() || istrue(var_8f2da01924d0ae97)) {
      if(mover scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(mover scripts\cp_mp\vehicles\vehicle_occupancy::function_a24042975031e692()) {
          [exitposition, exitdirection] = scripts\cp_mp\vehicles\vehicle_occupancy::function_9d86fd9a89cd2702(player, mover, player.origin);
        } else {
          exitposition = scripts\cp_mp\vehicles\vehicle_occupancy::function_ca069b5427d4ff47(mover, player);
          exitdirection = undefined;
        }

        if(isDefined(exitposition)) {
          if(isDefined(exitdirection) && (exitdirection == "inside" || exitdirection == "top")) {
            player function_a055801da45d769(exitposition, mover);
            return;
          }

          player setOrigin(exitposition);
          return;
        } else {
          scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer(mover, player, 1);
          return;
        }
      } else if(scripts\mp\weapons::isplantedequipment(mover)) {
        mover scripts\mp\weapons::deleteexplosive();
        return;
      } else if(isDefined(mover.cover)) {
        mover.cover scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
        return;
      } else if(isDefined(level.var_9e34d99a98d2ff67) && [[level.var_9e34d99a98d2ff67]](player, mover)) {
        return;
      }
    } else {
      nodes = self.unresolved_collision_nodes;
      nearestnode = undefined;

      if(isDefined(nodes)) {
        nodes = sortbydistance(nodes, player.origin);
      } else {
        nodes = getnodesinradiussorted(player.origin, 500, 0, 128, "path");
      }

      var_cd2c014424008317 = (0, 0, -100);
      player cancelmantle();
      player dontinterpolate();
      moverents = get_mover_ents(mover);
      ignoredcharacters = level.characters;

      if(isDefined(level.var_4d6759431590af80)) {
        ignoredcharacters = [[level.var_4d6759431590af80]](player);
      }

      ignorelist = array_combine(moverents, ignoredcharacters);

      if(ignorelist.size > 128) {
        assertmsg("<dev string:x1c>" + moverents.size + "<dev string:x65>" + ignoredcharacters.size);
      }

      ignorelist = get_array_of_closest(player.origin, ignorelist, undefined, 128);

      for(i = 0; i < nodes.size; i++) {
        if(i == 3) {
          break;
        }

        check_node = nodes[i];
        org = check_node.origin + (0, 0, 10);
        contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1);
        trace = scripts\engine\trace::ray_trace(player gettagorigin("tag_eye"), org, ignorelist, contents);

        if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
          continue;
        }

        if(!canspawn(org)) {
          continue;
        }

        if(positionwouldtelefrag(org)) {
          continue;
        }

        if(player getstance() == "prone") {
          player setstance("crouch");
        }

        player setOrigin(org);
        return;
      }
    }
  }

  if(istrue(mover.var_428aae905d2786a7) && isDefined(mover.owner)) {
    player kill(mover.origin, mover.owner, mover, "MOD_CRUSH");
    return;
  }

  if(!isDefined(var_4258fb168fb20ba6)) {
    var_4258fb168fb20ba6 = 1;
  }

  if(var_4258fb168fb20ba6) {
    if(!getdvarint(@ "hash_60159c88e0599409", 1) && istrue(mover.var_2ee93f095dc416f8)) {
      return;
    }

    player mover_suicide();
  }
}

function get_mover_ents(mover) {
  moverents = [];
  moverents[moverents.size] = mover;
  parent = mover getlinkedparent();
  children = mover getlinkedchildren(1);

  if(isDefined(parent)) {
    moverents[moverents.size] = parent;
  }

  if(isDefined(children)) {
    foreach(child in children) {
      moverents[moverents.size] = child;
    }
  }

  return moverents;
}

function unresolved_collision_void(player, penetration) {}

function mover_suicide() {
  _suicide();
}

function player_pushed_kill(min_mph) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  while(true) {
    self waittill("player_pushed", player, platformmph);

    if(isPlayer(player) || isagent(player)) {
      mph = length(platformmph);

      if(mph >= min_mph) {
        unresolved_collision_owner_damage(player);
      }
    }
  }
}

function stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

function script_mover_get_top_parent() {
  topparent = self getlinkedparent();

  for(parent = topparent; isDefined(parent); parent = parent getlinkedparent()) {
    topparent = parent;
  }

  return topparent;
}

function script_mover_start_use(useent) {
  useparent = useent script_mover_get_top_parent();

  if(isDefined(useparent)) {
    useparent.startuseorigin = useparent.origin;
  }

  self.startusemover = self getmovingplatformparent();

  if(isDefined(self.startusemover)) {
    topparent = self.startusemover script_mover_get_top_parent();

    if(isDefined(topparent)) {
      self.startusemover = topparent;
    }

    self.startusemover.startuseorigin = self.startusemover.origin;
  }
}

function script_mover_has_parent_moved(parent) {
  if(!isDefined(parent)) {
    return false;
  }

  return lengthsquared(parent.origin - parent.startuseorigin) > 0.001;
}

function script_mover_use_can_link(ent) {
  if(!isPlayer(self)) {
    return true;
  }

  if(!isDefined(ent)) {
    return false;
  }

  topparent = ent script_mover_get_top_parent();
  playerparent = self.startusemover;

  if(!isDefined(topparent) && !isDefined(playerparent)) {
    return true;
  }

  if(isDefined(topparent) && isDefined(playerparent) && topparent == playerparent) {
    return true;
  }

  if(script_mover_has_parent_moved(topparent)) {
    return false;
  }

  if(script_mover_has_parent_moved(playerparent)) {
    return false;
  }

  return true;
}

function script_mover_link_to_use_object(player) {
  if(isPlayer(player)) {
    player scripts\mp\movers::script_mover_start_use(self);
  }

  player allowmovement(0);
  player allowjump(0);
}

function script_mover_unlink_from_use_object(player) {
  player allowmovement(1);
  player allowjump(1);
}

function notify_moving_platform_invalid() {
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

function process_moving_platform_death(data, platform) {
  if(isDefined(platform) && isDefined(platform.no_moving_platfrom_death) && platform.no_moving_platfrom_death) {
    return;
  }

  if(isDefined(data.deathoverridecallback)) {
    data.lasttouchedplatform = platform;
    self thread[[data.deathoverridecallback]](data);
    return;
  }

  self delete();
}

function handle_moving_platform_touch(data) {
  self notify("handle_moving_platform_touch");
  self endon("handle_moving_platform_touch");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(isDefined(data.endonstring)) {
    self endon(data.endonstring);
  }

  while(true) {
    self waittill("touching_platform", platform);

    if(isDefined(data.validateaccuratetouching) && data.validateaccuratetouching) {
      if(!self istouching(platform)) {
        waitframe();
        continue;
      }
    }

    if(isDefined(data.plantedontrain) && data.plantedontrain) {
      if(scripts\cp_mp\utility\train_utility::is_train_ent(platform)) {
        waitframe();
        continue;
      }
    }

    if(isDefined(self.streakinfo) && self.streakinfo.streakname == "pac_sentry") {
      if(isDefined(platform) && isDefined(platform.crate)) {
        waitframe();
        continue;
      }
    }

    if(!istrue(data.skipdeath)) {
      thread process_moving_platform_death(data, platform);
    }

    self.touchedmovingplatform = 1;
    self.lastmovingplatform = platform;
    thread platform_cleanup_on_death();
    break;
  }
}

function platform_cleanup_on_death() {
  self endon("death");
  self.lastmovingplatform waittill("death");
  self.lastmovingplatform = undefined;
}

function handle_moving_platform_invalid(data) {
  self notify("handle_moving_platform_invalid");
  self endon("handle_moving_platform_invalid");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(isDefined(data.endonstring)) {
    self endon(data.endonstring);
  }

  self waittill("invalid_parent", platform);

  if(isDefined(data.invalidparentoverridecallback)) {
    self thread[[data.invalidparentoverridecallback]](data);
    return;
  }

  thread process_moving_platform_death(data, platform);
}

function handle_moving_platforms(data) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(data)) {
    data = spawnStruct();
  }

  if(isDefined(data.endonstring)) {
    self endon(data.endonstring);
  }

  if(isDefined(data.linkparent)) {
    parent = self getlinkedparent();

    if(!isDefined(parent) || parent != data.linkparent) {
      if(isDefined(data.linkoffset)) {
        self linkTo(data.linkparent, "", data.linkoffset, data.angleoffset);
      } else {
        self linkTo(data.linkparent);
      }
    }
  }

  thread handle_moving_platform_touch(data);
  thread handle_moving_platform_invalid(data);
}

function stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

function moving_platform_empty_func(data) {}