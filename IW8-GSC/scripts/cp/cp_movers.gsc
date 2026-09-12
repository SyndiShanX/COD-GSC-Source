/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_movers.gsc
***********************************************/

function main() {
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
  script_mover_add_hintstring("activate", &"MP/ACTIVATE_MOVER");
  script_mover_add_parameters("none", "");
  level.script_mover_named_goals = [];
  waitframe();
  var_0 = [];
  var_1 = script_mover_classnames();

  foreach(var_3 in var_1) {
    var_0 = scripts\engine\utility::array_combine(var_0, getEntArray(var_3, "classname"));
  }

  scripts\engine\utility::array_thread(var_0, &script_mover_int);
}

function script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

function script_mover_is_script_mover() {
  if(isDefined(self.script_mover)) {
    return self.script_mover;
  }

  var_0 = script_mover_classnames();

  foreach(var_2 in var_0) {
    if(self.classname == var_2) {
      self.script_mover = 1;
      return 1;
    }
  }

  return 0;
}

function script_mover_add_hintstring(var_0, var_1) {
  if(!isDefined(level.script_mover_hintstrings)) {
    level.script_mover_hintstrings = [];
  }

  level.script_mover_hintstrings[var_0] = var_1;
}

function script_mover_add_parameters(var_0, var_1) {
  if(!isDefined(level.script_mover_parameters)) {
    level.script_mover_parameters = [];
  }

  level.script_mover_parameters[var_0] = var_1;
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
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }

    switch (var_2.script_noteworthy) {
      case "origin":
        if(!isDefined(var_2.angles)) {
          var_2.angles = (0, 0, 0);
        }

        self.origin_ent = spawn("script_model", var_2.origin);
        self.origin_ent.angles = var_2.angles;
        self.origin_ent setModel("tag_origin");
        self.origin_ent linkTo(self);
        break;
      default:
        break;
    }
  }

  var_4 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_4) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }

    switch (var_2.script_noteworthy) {
      case "use_trigger_link":
        var_2 enablelinkTo();
        var_2 linkTo(self);
      case "use_trigger":
        script_mover_parse_targets(var_2);
        thread script_mover_use_trigger(var_2);
        self.use_triggers[self.use_triggers.size] = var_2;
        break;
      case "link":
        var_2 linkTo(self);
        self.linked_ents[self.linked_ents.size] = var_2;
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

  foreach(var_8 in self.use_triggers) {
    script_mover_set_usable(var_8, 1);
  }
}

function script_mover_use_trigger(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger");

    if(var_0.goals.size > 0) {
      self notify("new_path");
      thread script_mover_move_to_target(var_0);
      continue;
    }

    self notify("trigger");
  }
}

function script_mover_move_to_named_goal(var_0) {
  if(isDefined(level.script_mover_named_goals[var_0])) {
    self notify("new_path");
    self.goals = [level.script_mover_named_goals[var_0]];
    thread script_mover_move_to_target();
    return;
  }
}

function anglesclamp180(var_0) {
  return (angleclamp180(var_0[0]), angleclamp180(var_0[1]), angleclamp180(var_0[2]));
}

function script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }

  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  self.level_notify = [];
  var_0 = [];
  var_1 = [];

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
    var_1 = getEntArray(self.target, "targetname");
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.script_noteworthy)) {
      var_3.script_noteworthy = "goal";
    }

    switch (var_3.script_noteworthy) {
      case "ignore":
        if(isDefined(var_3.target)) {
          var_4 = scripts\engine\utility::getStructArray(var_3.target, "targetname");

          foreach(var_6 in var_4) {
            var_0 = var_6;
          }
        }

        break;
      case "goal":
        script_mover_init_move_parameters(var_3);
        script_mover_parse_targets(var_3);
        self.goals[self.goals.size] = var_3;

        if(isDefined(var_3.params["name"])) {
          level.script_mover_named_goals[var_3.params["name"]] = var_3;
        }

        break;
      case "level_notify":
        if(isDefined(var_3.script_parameters)) {
          self.level_notify[self.level_notify.size] = var_3;
        }

        break;
      default:
        break;
    }
  }

  foreach(var_9 in var_1) {
    if(script_mover_is_script_mover(var_9)) {
      self.movers[self.movers.size] = var_9;
      continue;
    }

    if(!isDefined(var_9.script_noteworthy)) {
      continue;
    }

    var_10 = strtok(var_9.script_noteworthy, "_");

    if(var_10.size != 3 || var_10[1] != "on") {
      continue;
    }

    switch (var_10[0]) {
      case "delete":
        thread script_mover_call_func_on_notify(var_9, &delete, var_10[2]);
        break;
      case "hide":
        thread script_mover_call_func_on_notify(var_9, &hide, var_10[2]);
        break;
      case "show":
        var_9 hide();
        thread script_mover_call_func_on_notify(var_9, &show, var_10[2]);
        break;
      case "triggerHide":
      case "triggerhide":
        thread script_mover_func_on_notify(var_9, &scripts\engine\utility::trigger_off, var_10[2]);
        break;
      case "triggerShow":
      case "triggershow":
        var_9 scripts\engine\utility::trigger_off();
        thread script_mover_func_on_notify(var_9, &scripts\engine\utility::trigger_on, var_10[2]);
        break;
      default:
        break;
    }
  }
}

function script_mover_func_on_notify(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill(var_2);
    var_0[[var_1]]();
  }
}

function script_mover_call_func_on_notify(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill(var_2);
    var_0 builtin[[var_1]]();
  }
}

function script_mover_trigger_on() {
  scripts\engine\utility::trigger_on();
}

function script_mover_move_to_target(var_0) {
  self endon("death");
  self endon("new_path");
  jumpiftrue(isDefined(var_0)) LOC_00000018;

  for(var_0 = self; var_0.goals.size != 0; var_0 = var_1) {
    var_1 = scripts\engine\utility::random(var_0.goals);
    var_2 = self;
    script_mover_apply_move_parameters(var_2, var_1);

    if(isDefined(var_2.params["delay_till"])) {
      level waittill(var_2.params["delay_till"]);
    }

    if(isDefined(var_2.params["delay_till_trigger"]) && var_2.params["delay_till_trigger"]) {
      self waittill("trigger");
    }

    if(var_2.params["delay_time"] > 0) {
      wait var_2.params["delay_time"];
    }

    var_3 = var_2.params["move_time"];
    var_4 = var_2.params["accel_time"];
    var_5 = var_2.params["decel_time"];
    var_6 = 0;
    var_7 = 0;
    var_8 = transformmove(var_1.origin, var_1.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

    if(var_2.origin != var_1.origin) {
      if(isDefined(var_2.params["move_speed"])) {
        var_9 = distance(var_2.origin, var_1.origin);
        var_3 = var_9 / var_2.params["move_speed"];
      }

      if(isDefined(var_2.params["accel_frac"])) {
        var_4 = var_2.params["accel_frac"] * var_3;
      }

      if(isDefined(var_2.params["decel_frac"])) {
        var_5 = var_2.params["decel_frac"] * var_3;
      }

      var_2 moveTo(var_8["origin"], var_3, var_4, var_5);

      foreach(var_11 in var_1.level_notify) {
        thread script_mover_run_notify(var_11.origin, var_11.script_parameters, self.origin, var_1.origin);
      }

      var_6 = 1;
    }

    if(anglesclamp180(var_8["angles"]) != anglesclamp180(var_2.angles)) {
      var_2 rotateTo(var_8["angles"], var_3, var_4, var_5);
      var_7 = 1;
    }

    foreach(var_14 in var_2.movers) {
      var_14 notify("trigger");
    }

    var_0 notify("depart");
    script_mover_allow_usable(var_2, 0);
    self.moving = 1;

    if(isDefined(var_2.params["move_time_offset"]) && var_2.params["move_time_offset"] + var_3 > 0) {
      wait var_2.params["move_time_offset"] + var_3;
    } else if(var_6) {
      self waittill("movedone");
    } else if(var_7) {
      self waittill("rotatedone");
    } else {
      wait var_3;
    }

    self.moving = 0;
    self notify("move_end");
    var_1 notify("arrive");

    if(isDefined(var_2.params["solid"])) {
      if(var_2.params["solid"]) {
        var_2 solid();
      } else {
        var_2 notsolid();
      }
    }

    foreach(var_14 in var_1.movers) {
      var_14 notify("trigger");
    }

    if(isDefined(var_2.params["wait_till"])) {
      level waittill(var_2.params["wait_till"]);
    }

    if(var_2.params["wait_time"] > 0) {
      wait var_2.params["wait_time"];
    }

    script_mover_allow_usable(var_2, 1);
  }
}

function script_mover_run_notify(var_0, var_1, var_2, var_3) {
  self endon("move_end");
  var_4 = self;
  var_5 = vectorNormalize(var_3 - var_2);

  for(;;) {
    var_6 = vectorNormalize(var_0 - var_4.origin);

    if(vectordot(var_5, var_6) <= 0) {
      break;
    }

    wait 0.05;
  }

  level notify(var_1);
}

function script_mover_init_move_parameters() {
  self.params = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = anglesclamp180(self.angles);
  script_mover_parse_move_parameters(self.script_parameters);
}

function script_mover_parse_move_parameters(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_1 = strtok(var_0, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "=");

    if(var_4.size != 2) {
      continue;
    }

    if(var_4[1] == "undefined" || var_4[1] == "default") {
      self.params[var_4[0]] = undefined;
      continue;
    }

    switch (var_4[0]) {
      case "move_time_offset":
      case "decel_frac":
      case "accel_frac":
      case "move_speed":
      case "delay_time":
      case "wait_time":
      case "decel_time":
      case "accel_time":
      case "move_time":
        self.params[var_4[0]] = script_mover_parse_range(var_4[1]);
        break;
      case "wait_till":
      case "delay_till":
      case "hintstring":
      case "name":
        self.params[var_4[0]] = var_4[1];
        break;
      case "delay_till_trigger":
      case "usable":
      case "solid":
        self.params[var_4[0]] = int(var_4[1]);
        break;
      case "script_params":
        var_5 = var_4[1];
        var_6 = level.script_mover_parameters[var_5];

        if(isDefined(var_6)) {
          script_mover_parse_move_parameters(var_6);
        }

        break;
      default:
        break;
    }
  }
}

function script_mover_parse_range(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, ",");

  if(var_2.size == 1) {
    var_1 = float(var_2[0]);
  } else if(var_2.size == 2) {
    var_3 = float(var_2[0]);
    var_4 = float(var_2[1]);

    if(var_3 >= var_4) {
      var_1 = var_3;
    } else {
      var_1 = randomfloatrange(var_3, var_4);
    }
  }

  return var_1;
}

function script_mover_apply_move_parameters(var_0) {
  foreach(var_2 in var_0.params) {
    script_mover_set_param(var_3, var_2);
  }

  script_mover_set_defaults();
}

function script_mover_set_param(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == "usable" && isDefined(var_1)) {
    script_mover_set_usable(self, var_1);
  }

  self.params[var_0] = var_1;
}

function script_mover_allow_usable(var_0) {
  if(self.params["usable"]) {
    script_mover_set_usable(self, var_0);
  }

  foreach(var_2 in self.use_triggers) {
    script_mover_set_usable(var_2, var_0);
  }
}

function script_mover_set_usable(var_0, var_1) {
  if(var_1) {
    var_0 makeusable();
    var_0 setCursorHint("HINT_NOICON");
    var_0 setHintString(level.script_mover_hintstrings[self.params["hintstring"]]);
    return;
  }

  var_0 makeunusable();
}

function script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(var_1 in self.params) {
    self.params_default[var_2] = var_1;
  }
}

function script_mover_set_defaults() {
  foreach(var_2, var_1 in level.script_mover_defaults) {
    if(!isDefined(self.params[var_2])) {
      script_mover_set_param(var_2, var_1);
    }
  }

  if(isDefined(self.params_default)) {
    foreach(var_2, var_1 in self.params_default) {
      if(!isDefined(self.params[var_2])) {
        script_mover_set_param(var_2, var_1);
      }
    }

    return;
  }
}

function init() {
  thread script_mover_agent_spawn_watch();
}

function script_mover_agent_spawn_watch() {
  for(;;) {
    level waittill("spawned_agent", var_0);
    thread player_unresolved_collision_watch();
  }
}

function player_unresolved_collision_watch() {
  self endon("disconnect");

  if(isagent(self)) {
    self endon("death");
  }

  self.unresolved_collision_count = 0;

  for(;;) {
    self waittill("unresolved_collision", var_0, var_1);
    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    var_2 = 3;

    if(isDefined(var_0) && isDefined(var_0.unresolved_collision_notify_min)) {
      var_2 = var_0.unresolved_collision_notify_min;
    }

    if(self.unresolved_collision_count >= var_2) {
      if(isDefined(var_0)) {
        if(isDefined(var_0.unresolved_collision_func)) {
          var_0[[var_0.unresolved_collision_func]](self, var_1);
        } else if(isDefined(var_0.unresolved_collision_kill) && var_0.unresolved_collision_kill) {
          unresolved_collision_owner_damage(var_0, self);
        } else if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          if(!scripts\cp_mp\vehicles\vehicle::ref_1418b(var_0, self)) {
            unresolved_collision_nearest_node(var_0, self);
          }
        } else {
          unresolved_collision_nearest_node(var_0, self);
        }
      } else {
        unresolved_collision_nearest_node(self);
      }

      self.unresolved_collision_count = 0;
    }
  }
}

function clear_unresolved_collision_count_next_frame() {
  self endon("unresolved_collision");
  waitframe();

  if(isDefined(self)) {
    self.unresolved_collision_count = 0;
    return;
  }
}

function unresolved_collision_owner_damage(var_0) {
  var_1 = self;

  if(!isDefined(var_1.owner)) {
    mover_suicide(var_0);
    return;
  }

  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_1.owner.team) && var_1.owner.team != var_0.team) {
      var_2 = 1;
    }
  } else if(var_0 != var_1.owner) {
    var_2 = 1;
  }

  if(!var_2) {
    mover_suicide(var_0);
    return;
  }

  var_3 = 1000;

  if(isDefined(var_1.unresolved_collision_damage)) {
    var_3 = var_1.unresolved_collision_damage;
  }

  var_0 dodamage(var_3, var_1.origin, var_1.owner, var_1, "MOD_CRUSH");
}

function unresolved_collision_nearest_node(var_0, var_1) {
  if(isDefined(level.override_unresolved_collision)) {
    self[[level.override_unresolved_collision]](var_0, var_1);
    return;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\cp\utility::tryingtoleave()) {
    var_1 = 1;

    if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(self, 1);

      if(isDefined(var_2)) {
        var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitpositionandangles(self, var_0, var_2, 1);

        if(isDefined(var_3)) {
          var_0 setOrigin(var_3[0]);
          return;
        }
      }
    }
  } else {
    var_4 = self.unresolved_collision_nodes;

    if(isDefined(var_4)) {
      var_4 = sortbydistance(var_4, var_0.origin);
    } else {
      var_4 = getnodesinradius(var_0.origin, 300, 0, 200);
      var_4 = sortbydistance(var_4, var_0.origin);
    }

    var_5 = (0, 0, -100);
    var_0 cancelmantle();
    var_0 dontinterpolate();
    var_0 setOrigin(var_0.origin + var_5);

    for(var_6 = 0; var_6 < var_4.size; var_6++) {
      var_7 = var_4[var_6];
      var_8 = var_7.origin;

      if(!canspawn(var_8)) {
        continue;
      }

      if(positionwouldtelefrag(var_8)) {
        continue;
      }

      if(var_0 getstance() == "prone") {
        var_0 setstance("crouch");
      }

      var_0 setOrigin(var_8);
      return;
    }

    var_0 setOrigin(var_0.origin - var_5);
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    mover_suicide(var_0);
    return;
  }
}

function unresolved_collision_void(var_0, var_1) {}

function mover_suicide() {
  if(isDefined(level.ishorde) && !isagent(self)) {
    return;
  }

  scripts\cp\utility::_suicide();
}

function player_pushed_kill(var_0) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for(;;) {
    self waittill("player_pushed", var_1, var_2);

    if(isPlayer(var_1) || isagent(var_1)) {
      var_3 = length(var_2);

      if(var_3 >= var_0) {
        unresolved_collision_owner_damage(var_1);
      }
    }
  }
}

function stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

function script_mover_get_top_parent() {
  var_0 = self getlinkedparent();

  for(var_1 = var_0; isDefined(var_1); var_1 = var_1 getlinkedparent()) {
    var_0 = var_1;
  }

  return var_0;
}

function script_mover_start_use(var_0) {
  var_1 = script_mover_get_top_parent(var_0);

  if(isDefined(var_1)) {
    var_1.startuseorigin = var_1.origin;
  }

  self.startusemover = self getmovingplatformparent();

  if(isDefined(self.startusemover)) {
    var_2 = script_mover_get_top_parent(self.startusemover);

    if(isDefined(var_2)) {
      self.startusemover = var_2;
    }

    self.startusemover.startuseorigin = self.startusemover.origin;
    return;
  }
}

function script_mover_has_parent_moved(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return lengthsquared(var_0.origin - var_0.startuseorigin) > 0.001;
}

function script_mover_use_can_link(var_0) {
  if(!isPlayer(self)) {
    return true;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = script_mover_get_top_parent(var_0);
  var_2 = self.startusemover;

  if(!isDefined(var_1) && !isDefined(var_2)) {
    return true;
  }

  if(isDefined(var_1) && isDefined(var_2) && var_1 == var_2) {
    return true;
  }

  if(script_mover_has_parent_moved(var_1)) {
    return false;
  }

  if(script_mover_has_parent_moved(var_2)) {
    return false;
  }

  return true;
}

function script_mover_link_to_use_object(var_0) {
  if(isPlayer(var_0)) {
    script_mover_start_use(var_0, self);
    var_1 = var_0 getmovingplatformparent();
    var_2 = undefined;

    if(isDefined(var_1)) {
      var_2 = var_1;
    } else if(!isDefined(script_mover_get_top_parent())) {
      var_2 = self;
    } else {
      var_2 = spawn("script_model", var_0.origin);
      var_2 setModel("tag_origin");
      var_0.scriptmoverlinkdummy = var_2;
      thread sciprt_mover_use_object_wait_for_disconnect(var_0);
    }

    var_0 playerlinkTo(var_2);
  } else {
    var_0 linkTo(self);
  }

  var_0 playerlinkedoffsetenable();
}

function script_mover_unlink_from_use_object(var_0) {
  var_0 unlink();

  if(isDefined(var_0.scriptmoverlinkdummy)) {
    var_0 notify("removeMoverLinkDummy");
    var_0.scriptmoverlinkdummy delete();
    var_0.scriptmoverlinkdummy = undefined;
    return;
  }
}

function sciprt_mover_use_object_wait_for_disconnect(var_0) {
  self endon("removeMoverLinkDummy");
  scripts\engine\utility::ref_143a5("death", "disconnect");
  self.scriptmoverlinkdummy delete();
  self.scriptmoverlinkdummy = undefined;
}

function notify_moving_platform_invalid() {
  var_0 = self getlinkedchildren(0);

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.no_moving_platfrom_unlink) && var_2.no_moving_platfrom_unlink) {
      continue;
    }

    var_2 unlink();
    var_2 notify("invalid_parent", self);
  }
}

function process_moving_platform_death(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.no_moving_platfrom_death) && var_1.no_moving_platfrom_death) {
    return;
  }

  if(isDefined(var_0.playdeathfx)) {
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(var_0.deathoverridecallback)) {
    var_0.lasttouchedplatform = var_1;
    self thread[[var_0.deathoverridecallback]](var_0);
    return;
  }

  self delete();
}

function handle_moving_platform_touch(var_0) {
  self notify("handle_moving_platform_touch");
  self endon("handle_moving_platform_touch");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");
  jumpiffalse(isDefined(var_0.endonstring)) LOC_0000003b;
  self endon(var_0.endonstring);

  for(;;) {
    self waittill("touching_platform", var_1);

    if(isDefined(var_0.validateaccuratetouching) && var_0.validateaccuratetouching) {
      if(!self istouching(var_1)) {
        wait 0.05;
        continue;
      }
    }

    thread process_moving_platform_death(var_0, var_1);
    break;
  }
}

function handle_moving_platform_invalid(var_0) {
  self notify("handle_moving_platform_invalid");
  self endon("handle_moving_platform_invalid");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");
  jumpiffalse(isDefined(var_0.endonstring)) LOC_0000003b;
  self endon(var_0.endonstring);
  self waittill("invalid_parent", var_1);

  if(isDefined(var_0.invalidparentoverridecallback)) {
    self thread[[var_0.invalidparentoverridecallback]](var_0);
    return;
  }

  thread process_moving_platform_death(var_0, var_1);
}

function handle_moving_platforms(var_0) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  if(isDefined(var_0.endonstring)) {
    self endon(var_0.endonstring);
  }

  if(isDefined(var_0.linkparent)) {
    var_1 = self getlinkedparent();

    if(!isDefined(var_1) || var_1 != var_0.linkparent) {
      self linkTo(var_0.linkparent);
    }
  }

  if(isDefined(var_0.linkparents)) {
    if(isarray(var_0.linkparents)) {
      foreach(var_3 in var_0.linkparents) {
        var_1 = self getlinkedparent();

        if(!isDefined(var_1) || var_1 != var_3) {
          self linkTo(var_3);
        }
      }
    }
  }

  thread handle_moving_platform_touch(var_0);
  thread handle_moving_platform_invalid(var_0);
}

function stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

function moving_platform_empty_func(var_0) {}