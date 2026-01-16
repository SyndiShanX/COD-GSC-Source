/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_movers.gsc
********************************/

main() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
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
  script_mover_add_hintstring("activate", & "MP_ACTIVATE_MOVER");
  script_mover_add_parameters("none", "");
  level.script_mover_named_goals = [];
  level.script_mover_animations = [];
  waitframe();
  var_0 = [];
  var_1 = script_mover_classnames();

  foreach(var_3 in var_1)
  var_0 = common_scripts\utility::array_combine(var_0, getentarray(var_3, "classname"));

  common_scripts\utility::array_thread(var_0, ::script_mover_init);
}

script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

script_mover_is_script_mover() {
  if(isdefined(self.script_mover))
    return self.script_mover;

  var_0 = script_mover_classnames();

  foreach(var_2 in var_0) {
    if(self.classname == var_2) {
      self.script_mover = 1;
      return 1;
    }
  }

  return 0;
}

script_mover_add_hintstring(var_0, var_1) {
  if(!isdefined(level.script_mover_hintstrings))
    level.script_mover_hintstrings = [];

  level.script_mover_hintstrings[var_0] = var_1;
}

script_mover_add_parameters(var_0, var_1) {
  if(!isdefined(level.script_mover_parameters))
    level.script_mover_parameters = [];

  level.script_mover_parameters[var_0] = var_1;
}

script_mover_add_animation(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.script_mover_animations))
    level.script_mover_animations = [];

  if(!isdefined(var_3))
    var_3 = "default";

  if(!isdefined(level.script_mover_animations[var_0]))
    level.script_mover_animations[var_0] = [];

  var_4 = spawnstruct();
  var_4.animname = var_1;
  var_4.animref = var_2;
  level.script_mover_animations[var_0][var_3] = var_4;
}

script_mover_init() {
  self.script_mover = 1;
  self.moving = 0;
  self.origin_ent = self;
  self.use_triggers = [];
  self.linked_ents = [];
  var_0 = [];

  if(isdefined(self.target))
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isdefined(var_2.script_noteworthy)) {
      continue;
    }
    switch (var_2.script_noteworthy) {
      case "origin":
        if(!isdefined(var_2.angles))
          var_2.angles = (0, 0, 0);

        self.origin_ent = spawn("script_model", var_2.origin);
        self.origin_ent.angles = var_2.angles;
        self.origin_ent setmodel("tag_origin");
        self.origin_ent linkto(self);
        break;
      case "scene_node":
      case "scripted_node":
        if(!isdefined(var_2.angles))
          var_2.angles = (0, 0, 0);

        self.scripted_node = var_2;
        break;
      default:
        break;
    }
  }

  var_4 = [];

  if(isdefined(self.target))
    var_4 = getentarray(self.target, "targetname");

  foreach(var_2 in var_4) {
    if(!isdefined(var_2.script_noteworthy)) {
      continue;
    }
    var_6 = strtok(var_2.script_noteworthy, ";");

    foreach(var_8 in var_6) {
      switch (var_8) {
        case "use_trigger_link":
          var_2 enablelinkto();
          var_2 linkto(self);
        case "use_trigger":
          var_2 script_mover_parse_targets();
          thread script_mover_use_trigger(var_2);
          self.use_triggers[self.use_triggers.size] = var_2;
          break;
        case "link":
          var_2 linkto(self);
          self.linked_ents[self.linked_ents.size] = var_2;
          break;
        default:
          break;
      }
    }
  }

  thread script_mover_parse_targets();
  thread script_mover_init_move_parameters();
  thread script_mover_save_default_move_parameters();
  thread script_mover_set_defaults();
  thread script_mover_apply_move_parameters(self);
  thread script_mover_reset_init();
  script_mover_start();

  foreach(var_12 in self.use_triggers)
  script_mover_set_usable(var_12, 1);

  self.script_mover_init = 1;
  self notify("script_mover_init");
}

script_mover_start() {
  if(script_mover_is_animated())
    thread script_mover_animate();
  else
    thread script_mover_move_to_target();
}

script_mover_reset_init() {
  self.mover_reset_origin = self.origin;
  self.mover_reset_angles = self.angles;
}

script_mover_reset(var_0) {
  self notify("mover_reset");

  if(script_mover_is_animated())
    self scriptmodelclearanim();

  self.origin = self.mover_reset_origin;
  self.angles = self.mover_reset_angles;
  self notify("new_path");
  waitframe();
  script_mover_start();
}

script_mover_use_trigger(var_0) {
  self endon("death");

  for (;;) {
    var_0 waittill("trigger");

    if(var_0.goals.size > 0) {
      self notify("new_path");
      thread script_mover_move_to_target(var_0);
      continue;
    }

    self notify("trigger");
  }
}

script_mover_move_to_named_goal(var_0) {
  if(isdefined(level.script_mover_named_goals[var_0])) {
    self notify("new_path");
    self.goals = level.script_mover_named_goals[var_0];
    thread script_mover_move_to_target();
  }
}

anglesclamp180(var_0) {
  return (angleclamp180(var_0[0]), angleclamp180(var_0[1]), angleclamp180(var_0[2]));
}

script_mover_parse_targets() {
  if(isdefined(self.parsed) && self.parsed) {
    return;
  }
  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  var_0 = [];
  var_1 = [];

  if(isdefined(self.target)) {
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");
    var_1 = getentarray(self.target, "targetname");
  }

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isdefined(var_3.script_noteworthy))
      var_3.script_noteworthy = "goal";

    switch (var_3.script_noteworthy) {
      case "ignore":
        if(isdefined(var_3.target)) {
          var_4 = common_scripts\utility::getstructarray(var_3.target, "targetname");

          foreach(var_6 in var_4)
          var_0[var_0.size] = var_6;
        }

        break;
      case "goal":
        var_3 script_mover_init_move_parameters();
        var_3 script_mover_parse_targets();
        self.goals[self.goals.size] = var_3;

        if(isdefined(var_3.params["name"])) {
          if(!isdefined(level.script_mover_named_goals[var_3.params["name"]]))
            level.script_mover_named_goals[var_3.params["name"]] = [];

          var_8 = level.script_mover_named_goals[var_3.params["name"]].size;
          level.script_mover_named_goals[var_3.params["name"]][var_8] = var_3;
        }

        break;
      default:
        break;
    }
  }

  foreach(var_10 in var_1) {
    if(var_10 script_mover_is_script_mover())
      self.movers[self.movers.size] = var_10;

    thread script_mover_parse_ent(var_10);
  }
}

script_mover_parse_ent(var_0) {
  if(!isdefined(var_0.script_noteworthy)) {
    return;
  }
  if(var_0 script_mover_is_script_mover() && !isdefined(var_0.script_mover_init))
    var_0 waittill("script_mover_init");

  var_1 = strtok(var_0.script_noteworthy, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_");

    if(var_4.size < 3 || var_4[1] != "on") {
      continue;
    }
    var_5 = tolower(var_4[0]);
    var_6 = var_4[2];

    for (var_7 = 3; var_7 < var_4.size; var_7++)
      var_6 = var_6 + "_" + var_4[var_7];

    switch (var_5) {
      case "connectpaths":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_connectpaths, ::script_mover_disconnectpaths);
        break;
      case "disconnectpaths":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_disconnectpaths, ::script_mover_connectpaths);
        break;
      case "solid":
        var_0 notsolid();
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_solid, ::script_mover_notsolid);
        break;
      case "notsolid":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_notsolid, ::script_mover_solid);
        break;
      case "delete":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_delete);
        break;
      case "hide":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_hide, ::script_mover_show);
        break;
      case "show":
        var_0 hide();
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_show, ::script_mover_hide);
        break;
      case "triggerhide":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_trigger_off, ::script_mover_trigger_on);
        break;
      case "triggershow":
        var_0 common_scripts\utility::trigger_off();
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_trigger_on, ::script_mover_trigger_off);
        break;
      case "trigger":
        thread script_mover_func_on_notify(var_0, var_6, ::script_mover_trigger, ::script_mover_reset);
        break;
      default:
        break;
    }
  }
}

script_mover_trigger_off(var_0) {
  self dontinterpolate();
  common_scripts\utility::trigger_off();
}

script_mover_trigger_on(var_0) {
  self dontinterpolate();
  common_scripts\utility::trigger_on();
}

script_mover_notify(var_0, var_1) {
  var_0 notify(var_1);
}

script_mover_levelnotify(var_0, var_1) {
  level notify(var_1);
}

script_mover_connectpaths(var_0) {
  self connectpaths();
}

script_mover_disconnectpaths(var_0) {
  self disconnectpaths(var_0);
}

script_mover_solid(var_0) {
  self solid();
}

script_mover_notsolid(var_0) {
  self notsolid();
}

script_mover_delete(var_0) {
  self delete();
}

script_mover_hide(var_0) {
  self hide();
}

script_mover_show(var_0) {
  self show();
}

script_mover_trigger(var_0) {
  self notify("trigger");
}

script_mover_func_on_notify(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death");

  for (;;) {
    self waittill(var_1, var_4);
    var_0[[var_2]](var_4);

    if(isdefined(var_3) && isdefined(var_4)) {
      var_4 script_mover_watch_for_reset(var_0, var_3);
      continue;
    }

    break;
  }
}

script_mover_update_paths() {
  var_0 = [];

  if(script_mover_is_dynamic_path())
    var_0[var_0.size] = self;

  foreach(var_2 in self.linked_ents) {
    if(var_2 script_mover_is_dynamic_path())
      var_0[var_0.size] = var_2;
  }

  if(var_0.size == 0) {
    return;
  }
  for (;;) {
    foreach(var_5 in var_0)
    var_5 script_mover_disconnectpaths();

    self waittill("move_start");

    foreach(var_5 in var_0)
    var_5 script_mover_connectpaths();

    self waittill("move_end");
  }
}

script_mover_animate() {
  childthread script_mover_update_paths();
  var_0 = self.params["animation"];

  if(isdefined(level.script_mover_animations[var_0]["idle"]))
    script_mover_play_animation(level.script_mover_animations[var_0]["idle"], 0);

  script_mover_delay();
  self notify("move_start");
  self notify("start", self);
  var_1 = level.script_mover_animations[var_0]["default"];

  if(isdefined(var_1)) {
    script_mover_play_animation(var_1, 1);
    self waittill("end");
  }

  self notify("move_end");
}

script_mover_play_animation(var_0, var_1) {
  self notify("play_animation");

  if(var_1)
    thread script_mover_handle_notetracks();

  if(isdefined(self.scripted_node))
    self scriptmodelplayanimdeltamotionfrompos(var_0.animname, self.scripted_node.origin, self.scripted_node.angles, "script_mover_anim");
  else
    self scriptmodelplayanimdeltamotion(var_0.animname, "script_mover_anim");
}

script_mover_handle_notetracks() {
  self endon("play_animation");
  self endon("mover_reset");

  for (;;) {
    self waittill("script_mover_anim", var_0);
    self notify(var_0, self);
  }
}

script_mover_delay() {
  if(isdefined(self.params["delay_till"]))
    level waittill(self.params["delay_till"]);

  if(isdefined(self.params["delay_till_trigger"]) && self.params["delay_till_trigger"])
    self waittill("trigger");

  if(self.params["delay_time"] > 0)
    wait(self.params["delay_time"]);
}

script_mover_move_to_target(var_0) {
  self endon("death");
  self endon("new_path");
  childthread script_mover_update_paths();

  if(!isdefined(var_0))
    var_0 = self;

  while (var_0.goals.size != 0) {
    var_1 = common_scripts\utility::random(var_0.goals);
    var_2 = self;
    var_2 script_mover_apply_move_parameters(var_1);
    var_2 script_mover_delay();
    var_3 = var_2.params["move_time"];
    var_4 = var_2.params["accel_time"];
    var_5 = var_2.params["decel_time"];
    var_6 = 0;
    var_7 = 0;
    var_8 = transformmove(var_1.origin, var_1.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

    if(var_2.origin != var_1.origin) {
      if(isdefined(var_2.params["move_speed"])) {
        var_9 = distance(var_2.origin, var_1.origin);
        var_3 = var_9 / var_2.params["move_speed"];
      }

      if(isdefined(var_2.params["accel_frac"]))
        var_4 = var_2.params["accel_frac"] * var_3;

      if(isdefined(var_2.params["decel_frac"]))
        var_5 = var_2.params["decel_frac"] * var_3;

      if(var_3 <= 0) {
        var_2 dontinterpolate();
        var_2.origin = var_8["origin"];
      } else
        var_2 moveto(var_8["origin"], var_3, var_4, var_5);

      var_6 = 1;
    }

    if(anglesclamp180(var_8["angles"]) != anglesclamp180(var_2.angles)) {
      if(var_3 <= 0) {
        var_2 dontinterpolate();
        var_2.angles = var_8["angles"];
      } else
        var_2 rotateto(var_8["angles"], var_3, var_4, var_5);

      var_7 = 1;
    }

    foreach(var_11 in var_2.movers) {
      var_11 notify("trigger");
      script_mover_watch_for_reset(var_11, ::script_mover_reset);
    }

    var_2 notify("move_start");
    var_0 notify("depart", var_2);

    if(isdefined(var_2.params["name"])) {
      var_13 = "mover_depart_" + var_2.params["name"];
      var_2 notify(var_13);
      level notify(var_13, var_2);
    }

    var_2 script_mover_allow_usable(0);

    if(var_3 <= 0) {

    } else if(var_6)
      var_2 waittill("movedone");
    else if(var_7)
      var_2 waittill("rotatedone");
    else
      wait(var_3);

    var_2 notify("move_end");
    var_1 notify("arrive", var_2);

    if(isdefined(var_2.params["name"])) {
      var_13 = "mover_arrive_" + var_2.params["name"];
      var_2 notify(var_13);
      level notify(var_13, var_2);
    }

    if(isdefined(var_2.params["solid"])) {
      if(var_2.params["solid"])
        var_2 solid();
      else
        var_2 notsolid();
    }

    foreach(var_11 in var_1.movers) {
      var_11 notify("trigger");
      script_mover_watch_for_reset(var_11, ::script_mover_reset);
    }

    if(isdefined(var_2.params["wait_till"]))
      level waittill(var_2.params["wait_till"]);

    if(var_2.params["wait_time"] > 0)
      wait(var_2.params["wait_time"]);

    var_2 script_mover_allow_usable(1);
    var_0 = var_1;
  }
}

script_mover_watch_for_reset(var_0, var_1) {
  thread script_mover_func_on_notify(var_0, "mover_reset", var_1);
}

script_mover_init_move_parameters() {
  self.params = [];

  if(!isdefined(self.angles))
    self.angles = (0, 0, 0);

  self.angles = anglesclamp180(self.angles);
  script_mover_parse_move_parameters(self.script_parameters);
}

script_mover_parse_move_parameters(var_0) {
  if(!isdefined(var_0))
    var_0 = "";

  var_1 = strtok(var_0, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "=");

    if(var_4.size != 2) {
      continue;
    }
    if(var_4[1] == "undefined" || var_4[1] == "default") {
      self.params[var_4[0]] = "<undefined>";
      continue;
    }

    switch (var_4[0]) {
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
      case "animation":
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

        if(isdefined(var_6))
          script_mover_parse_move_parameters(var_6);

        break;
      default:
        break;
    }
  }
}

script_mover_parse_range(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, ",");

  if(var_2.size == 1)
    var_1 = float(var_2[0]);
  else if(var_2.size == 2) {
    var_3 = float(var_2[0]);
    var_4 = float(var_2[1]);

    if(var_3 >= var_4)
      var_1 = var_3;
    else
      var_1 = randomfloatrange(var_3, var_4);
  }

  return var_1;
}

script_mover_apply_move_parameters(var_0) {
  foreach(var_3, var_2 in var_0.params)
  script_mover_set_param(var_3, var_2);

  script_mover_set_defaults();
}

script_mover_set_param(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  if(var_0 == "usable" && isdefined(var_1))
    script_mover_set_usable(self, var_1);

  if(isdefined(var_1) && isstring(var_1) && var_1 == "<undefined>")
    var_1 = undefined;

  self.params[var_0] = var_1;
}

script_mover_allow_usable(var_0) {
  if(self.params["usable"])
    script_mover_set_usable(self, var_0);

  foreach(var_2 in self.use_triggers)
  script_mover_set_usable(var_2, var_0);
}

script_mover_set_usable(var_0, var_1) {
  if(var_1) {
    var_0 makeusable();
    var_0 setcursorhint("HINT_ACTIVATE");
    var_0 sethintstring(level.script_mover_hintstrings[self.params["hintstring"]]);
  } else
    var_0 makeunusable();
}

script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(var_2, var_1 in self.params)
  self.params_default[var_2] = var_1;
}

script_mover_set_defaults() {
  if(isdefined(self.params_default)) {
    foreach(var_2, var_1 in self.params_default) {
      if(!isdefined(self.params[var_2]))
        script_mover_set_param(var_2, var_1);
    }
  }

  foreach(var_2, var_1 in level.script_mover_defaults) {
    if(!isdefined(self.params[var_2]))
      script_mover_set_param(var_2, var_1);
  }
}

script_mover_is_dynamic_path() {
  return isdefined(self.spawnflags) && self.spawnflags & 1;
}

script_mover_is_animated() {
  return isdefined(self.params["animation"]);
}

init() {
  level thread script_mover_connect_watch();
  level thread script_mover_agent_spawn_watch();
}

script_mover_connect_watch() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread player_unresolved_collision_watch();
  }
}

script_mover_agent_spawn_watch() {
  for (;;) {
    level waittill("spawned_agent", var_0);
    var_0 thread player_unresolved_collision_watch();
  }
}

player_unresolved_collision_watch() {
  self endon("disconnect");

  if(isagent(self))
    self endon("death");

  self.unresolved_collision_count = 0;

  for (;;) {
    self waittill("unresolved_collision", var_0);

    if(isagent(self) && isdefined(self.animclass)) {
      if(self scragentgetphysicsmode() == "noclip")
        continue;
    }

    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    var_1 = 3;

    if(isdefined(var_0) && isdefined(var_0.unresolved_collision_notify_min))
      var_1 = var_0.unresolved_collision_notify_min;

    if(self.unresolved_collision_count >= var_1) {
      if(isdefined(var_0)) {
        if(isdefined(var_0.unresolved_collision_func))
          var_0[[var_0.unresolved_collision_func]](self);
        else if(isdefined(var_0.unresolved_collision_kill) && var_0.unresolved_collision_kill)
          var_0 unresolved_collision_owner_damage(self);
        else
          var_0 unresolved_collision_nearest_node(self);
      } else
        unresolved_collision_nearest_node(self);

      self.unresolved_collision_count = 0;
    }
  }
}

clear_unresolved_collision_count_next_frame() {
  self endon("unresolved_collision");
  waitframe();

  if(isdefined(self))
    self.unresolved_collision_count = 0;
}

unresolved_collision_owner_damage(var_0) {
  var_1 = self;

  if(!isdefined(var_1.owner)) {
    var_0 mover_suicide();
    return;
  }

  var_2 = 0;

  if(level.teambased) {
    if(isdefined(var_1.owner.team) && var_1.owner.team != var_0.team)
      var_2 = 1;
  } else if(var_0 != var_1.owner)
    var_2 = 1;

  if(!var_2) {
    var_0 mover_suicide();
    return;
  }

  var_3 = 1000;

  if(isdefined(var_1.unresolved_collision_damage))
    var_3 = var_1.unresolved_collision_damage;

  var_0 dodamage(var_3, var_1.origin, var_1.owner, var_1, "MOD_CRUSH");
}

unresolved_collision_nearest_node(var_0, var_1) {
  var_2 = self.unresolved_collision_nodes;

  if(isdefined(var_2))
    var_2 = sortbydistance(var_2, var_0.origin);
  else {
    var_2 = getnodesinradius(var_0.origin, 300, 0, 200);
    var_2 = sortbydistance(var_2, var_0.origin);
  }

  var_3 = (0, 0, -100);
  var_0 cancelmantle();
  var_0 dontinterpolate();
  var_0 setorigin(var_0.origin + var_3);

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];
    var_6 = var_5.origin;

    if(!canspawn(var_6)) {
      continue;
    }
    if(positionwouldtelefrag(var_6)) {
      continue;
    }
    if(var_0 getstance() == "prone")
      var_0 setstance("crouch");

    var_0 setorigin(var_6);
    return;
  }

  var_0 setorigin(var_0.origin - var_3);

  if(!isdefined(var_1))
    var_1 = 1;

  if(var_1)
    var_0 mover_suicide();
}

unresolved_collision_void(var_0) {}

mover_suicide() {
  if(isdefined(level.ishorde) && !isagent(self)) {
    return;
  }
  maps\mp\_utility::_suicide();
}

player_pushed_kill(var_0) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for (;;) {
    self waittill("player_pushed", var_1, var_2);

    if(isplayer(var_1) || isagent(var_1)) {
      var_3 = length(var_2);

      if(var_3 >= var_0)
        unresolved_collision_owner_damage(var_1);
    }
  }
}

stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

notify_moving_platform_invalid() {
  var_0 = self getlinkedchildren(0);

  if(!isdefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isdefined(var_2.no_moving_platfrom_unlink) && var_2.no_moving_platfrom_unlink) {
      continue;
    }
    var_2 unlink();
    var_2 notify("invalid_parent", self);
  }
}

process_moving_platform_death(var_0, var_1) {
  if(isdefined(var_1) && isdefined(var_1.no_moving_platfrom_death) && var_1.no_moving_platfrom_death) {
    return;
  }
  if(isdefined(var_0.playdeathfx))
    playfx(common_scripts\utility::getfx("airdrop_crate_destroy"), self.origin);

  if(isdefined(var_0.deathoverridecallback))
    self thread[[var_0.deathoverridecallback]](var_0);
  else
    self delete();
}

handle_moving_platform_touch(var_0) {
  for (;;) {
    self waittill("touching_platform", var_1);

    if(isdefined(var_0.touchingplatformvalid) && !self[[var_0.touchingplatformvalid]](var_1)) {
      continue;
    }
    if(isdefined(var_0.validateaccuratetouching) && var_0.validateaccuratetouching) {
      if(!self istouching(var_1)) {
        wait 0.05;
        continue;
      }
    }

    thread process_moving_platform_death(var_0, var_1);
    break;
  }
}

handle_moving_platform_invalid(var_0) {
  self waittill("invalid_parent", var_1);

  if(isdefined(var_0.invalidparentoverridecallback))
    self thread[[var_0.invalidparentoverridecallback]](var_0);
  else
    thread process_moving_platform_death(var_0, var_1);
}

handle_moving_platforms(var_0) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isdefined(var_0))
    var_0 = spawnstruct();

  if(isdefined(var_0.endonstring))
    self endon(var_0.endonstring);

  if(isdefined(var_0.linkparent))
    self linkto(var_0.linkparent);

  childthread handle_moving_platform_touch(var_0);
  childthread handle_moving_platform_invalid(var_0);
}

stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

moving_platform_empty_func(var_0) {}