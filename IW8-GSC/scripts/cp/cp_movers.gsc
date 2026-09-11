/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_movers.gsc
***********************************************/

function main() {
  if(getDvar("LLQQOPKTKM") == "1") {
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
  var0 = [];
  var1 = script_mover_classnames();

  foreach(var3 in var1) {
    var0 = scripts\engine\utility::array_combine(var0, getEntArray(var3, "classname"));
  }

  scripts\engine\utility::array_thread(var0, &script_mover_int);
}

function script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

function script_mover_is_script_mover() {
  if(isDefined(self.script_mover)) {
    return self.script_mover;
  }

  var0 = script_mover_classnames();

  foreach(var2 in var0) {
    if(self.classname == var2) {
      self.script_mover = 1;
      return 1;
    }
  }

  return 0;
}

function script_mover_add_hintstring(var0, var1) {
  if(!isDefined(level.script_mover_hintstrings)) {
    level.script_mover_hintstrings = [];
  }

  level.script_mover_hintstrings[var0] = var1;
}

function script_mover_add_parameters(var0, var1) {
  if(!isDefined(level.script_mover_parameters)) {
    level.script_mover_parameters = [];
  }

  level.script_mover_parameters[var0] = var1;
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
  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2.script_noteworthy)) {
      continue;
    }

    switch (var2.script_noteworthy) {
      case "origin":
        if(!isDefined(var2.angles)) {
          var2.angles = (0, 0, 0);
        }

        self.origin_ent = spawn("script_model", var2.origin);
        self.origin_ent.angles = var2.angles;
        self.origin_ent setModel("tag_origin");
        self.origin_ent linkTo(self);
        break;
      default:
        break;
    }
  }

  var4 = getEntArray(self.target, "targetname");

  foreach(var2 in var4) {
    if(!isDefined(var2.script_noteworthy)) {
      continue;
    }

    switch (var2.script_noteworthy) {
      case "use_trigger_link":
        var2 enablelinkTo();
        var2 linkTo(self);
      case "use_trigger":
        script_mover_parse_targets(var2);
        thread script_mover_use_trigger(var2);
        self.use_triggers[self.use_triggers.size] = var2;
        break;
      case "link":
        var2 linkTo(self);
        self.linked_ents[self.linked_ents.size] = var2;
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

  foreach(var8 in self.use_triggers) {
    script_mover_set_usable(var8, 1);
  }
}

function script_mover_use_trigger(var0) {
  self endon("death");

  for(;;) {
    var0 waittill("trigger");

    if(var0.goals.size > 0) {
      self notify("new_path");
      thread script_mover_move_to_target(var0);
      continue;
    }

    self notify("trigger");
  }
}

function script_mover_move_to_named_goal(var0) {
  if(isDefined(level.script_mover_named_goals[var0])) {
    self notify("new_path");
    self.goals = [level.script_mover_named_goals[var0]];
    thread script_mover_move_to_target();
    return;
  }
}

function anglesclamp180(var0) {
  return (angleclamp180(var0[0]), angleclamp180(var0[1]), angleclamp180(var0[2]));
}

function script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }

  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  self.level_notify = [];
  var0 = [];
  var1 = [];

  if(isDefined(self.target)) {
    var0 = scripts\engine\utility::getStructArray(self.target, "targetname");
    var1 = getEntArray(self.target, "targetname");
  }

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = var0[var2];

    if(!isDefined(var3.script_noteworthy)) {
      var3.script_noteworthy = "goal";
    }

    switch (var3.script_noteworthy) {
      case "ignore":
        if(isDefined(var3.target)) {
          var4 = scripts\engine\utility::getStructArray(var3.target, "targetname");

          foreach(var6 in var4) {
            var0 = var6;
          }
        }

        break;
      case "goal":
        script_mover_init_move_parameters(var3);
        script_mover_parse_targets(var3);
        self.goals[self.goals.size] = var3;

        if(isDefined(var3.params["name"])) {
          level.script_mover_named_goals[var3.params["name"]] = var3;
        }

        break;
      case "level_notify":
        if(isDefined(var3.script_parameters)) {
          self.level_notify[self.level_notify.size] = var3;
        }

        break;
      default:
        break;
    }
  }

  foreach(var9 in var1) {
    if(script_mover_is_script_mover(var9)) {
      self.movers[self.movers.size] = var9;
      continue;
    }

    if(!isDefined(var9.script_noteworthy)) {
      continue;
    }

    var10 = strtok(var9.script_noteworthy, "_");

    if(var10.size != 3 || var10[1] != "on") {
      continue;
    }

    switch (var10[0]) {
      case "delete":
        thread script_mover_call_func_on_notify(var9, &delete, var10[2]);
        break;
      case "hide":
        thread script_mover_call_func_on_notify(var9, &hide, var10[2]);
        break;
      case "show":
        var9 hide();
        thread script_mover_call_func_on_notify(var9, &show, var10[2]);
        break;
      case "triggerHide":
      case "triggerhide":
        thread script_mover_func_on_notify(var9, &scripts\engine\utility::trigger_off, var10[2]);
        break;
      case "triggerShow":
      case "triggershow":
        var9 scripts\engine\utility::trigger_off();
        thread script_mover_func_on_notify(var9, &scripts\engine\utility::trigger_on, var10[2]);
        break;
      default:
        break;
    }
  }
}

function script_mover_func_on_notify(var0, var1, var2) {
  self endon("death");
  var0 endon("death");

  for(;;) {
    self waittill(var2);
    var0[[var1]]();
  }
}

function script_mover_call_func_on_notify(var0, var1, var2) {
  self endon("death");
  var0 endon("death");

  for(;;) {
    self waittill(var2);
    var0 builtin[[var1]]();
  }
}

function script_mover_trigger_on() {
  scripts\engine\utility::trigger_on();
}

function script_mover_move_to_target(var0) {
  self endon("death");
  self endon("new_path");
  jumpiftrue(isDefined(var0)) LOC_00000018;

  for(var0 = self; var0.goals.size != 0; var0 = var1) {
    var1 = scripts\engine\utility::random(var0.goals);
    var2 = self;
    script_mover_apply_move_parameters(var2, var1);

    if(isDefined(var2.params["delay_till"])) {
      level waittill(var2.params["delay_till"]);
    }

    if(isDefined(var2.params["delay_till_trigger"]) && var2.params["delay_till_trigger"]) {
      self waittill("trigger");
    }

    if(var2.params["delay_time"] > 0) {
      wait var2.params["delay_time"];
    }

    var3 = var2.params["move_time"];
    var4 = var2.params["accel_time"];
    var5 = var2.params["decel_time"];
    var6 = 0;
    var7 = 0;
    var8 = transformmove(var1.origin, var1.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

    if(var2.origin != var1.origin) {
      if(isDefined(var2.params["move_speed"])) {
        var9 = distance(var2.origin, var1.origin);
        var3 = var9 / var2.params["move_speed"];
      }

      if(isDefined(var2.params["accel_frac"])) {
        var4 = var2.params["accel_frac"] * var3;
      }

      if(isDefined(var2.params["decel_frac"])) {
        var5 = var2.params["decel_frac"] * var3;
      }

      var2 moveTo(var8["origin"], var3, var4, var5);

      foreach(var11 in var1.level_notify) {
        thread script_mover_run_notify(var11.origin, var11.script_parameters, self.origin, var1.origin);
      }

      var6 = 1;
    }

    if(anglesclamp180(var8["angles"]) != anglesclamp180(var2.angles)) {
      var2 rotateTo(var8["angles"], var3, var4, var5);
      var7 = 1;
    }

    foreach(var14 in var2.movers) {
      var14 notify("trigger");
    }

    var0 notify("depart");
    script_mover_allow_usable(var2, 0);
    self.moving = 1;

    if(isDefined(var2.params["move_time_offset"]) && var2.params["move_time_offset"] + var3 > 0) {
      wait var2.params["move_time_offset"] + var3;
    } else if(var6) {
      self waittill("movedone");
    } else if(var7) {
      self waittill("rotatedone");
    } else {
      wait var3;
    }

    self.moving = 0;
    self notify("move_end");
    var1 notify("arrive");

    if(isDefined(var2.params["solid"])) {
      if(var2.params["solid"]) {
        var2 solid();
      } else {
        var2 notsolid();
      }
    }

    foreach(var14 in var1.movers) {
      var14 notify("trigger");
    }

    if(isDefined(var2.params["wait_till"])) {
      level waittill(var2.params["wait_till"]);
    }

    if(var2.params["wait_time"] > 0) {
      wait var2.params["wait_time"];
    }

    script_mover_allow_usable(var2, 1);
  }
}

function script_mover_run_notify(var0, var1, var2, var3) {
  self endon("move_end");
  var4 = self;
  var5 = vectorNormalize(var3 - var2);

  for(;;) {
    var6 = vectorNormalize(var0 - var4.origin);

    if(vectordot(var5, var6) <= 0) {
      break;
    }

    wait 0.05;
  }

  level notify(var1);
}

function script_mover_init_move_parameters() {
  self.params = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = anglesclamp180(self.angles);
  script_mover_parse_move_parameters(self.script_parameters);
}

function script_mover_parse_move_parameters(var0) {
  if(!isDefined(var0)) {
    var0 = "";
  }

  var1 = strtok(var0, ";");

  foreach(var3 in var1) {
    var4 = strtok(var3, "=");

    if(var4.size != 2) {
      continue;
    }

    if(var4[1] == "undefined" || var4[1] == "default") {
      self.params[var4[0]] = undefined;
      continue;
    }

    switch (var4[0]) {
      case "move_time_offset":
      case "decel_frac":
      case "accel_frac":
      case "move_speed":
      case "delay_time":
      case "wait_time":
      case "decel_time":
      case "accel_time":
      case "move_time":
        self.params[var4[0]] = script_mover_parse_range(var4[1]);
        break;
      case "wait_till":
      case "delay_till":
      case "hintstring":
      case "name":
        self.params[var4[0]] = var4[1];
        break;
      case "delay_till_trigger":
      case "usable":
      case "solid":
        self.params[var4[0]] = int(var4[1]);
        break;
      case "script_params":
        var5 = var4[1];
        var6 = level.script_mover_parameters[var5];

        if(isDefined(var6)) {
          script_mover_parse_move_parameters(var6);
        }

        break;
      default:
        break;
    }
  }
}

function script_mover_parse_range(var0) {
  var1 = 0;
  var2 = strtok(var0, ",");

  if(var2.size == 1) {
    var1 = float(var2[0]);
  } else if(var2.size == 2) {
    var3 = float(var2[0]);
    var4 = float(var2[1]);

    if(var3 >= var4) {
      var1 = var3;
    } else {
      var1 = randomfloatrange(var3, var4);
    }
  }

  return var1;
}

function script_mover_apply_move_parameters(var0) {
  foreach(var2 in var0.params) {
    script_mover_set_param(var3, var2);
  }

  script_mover_set_defaults();
}

function script_mover_set_param(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(var0 == "usable" && isDefined(var1)) {
    script_mover_set_usable(self, var1);
  }

  self.params[var0] = var1;
}

function script_mover_allow_usable(var0) {
  if(self.params["usable"]) {
    script_mover_set_usable(self, var0);
  }

  foreach(var2 in self.use_triggers) {
    script_mover_set_usable(var2, var0);
  }
}

function script_mover_set_usable(var0, var1) {
  if(var1) {
    var0 makeusable();
    var0 setCursorHint("HINT_NOICON");
    var0 setHintString(level.script_mover_hintstrings[self.params["hintstring"]]);
    return;
  }

  var0 makeunusable();
}

function script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(var1 in self.params) {
    self.params_default[var2] = var1;
  }
}

function script_mover_set_defaults() {
  foreach(var2, var1 in level.script_mover_defaults) {
    if(!isDefined(self.params[var2])) {
      script_mover_set_param(var2, var1);
    }
  }

  if(isDefined(self.params_default)) {
    foreach(var2, var1 in self.params_default) {
      if(!isDefined(self.params[var2])) {
        script_mover_set_param(var2, var1);
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
    level waittill("spawned_agent", var0);
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
    self waittill("unresolved_collision", var0, var1);
    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    var2 = 3;

    if(isDefined(var0) && isDefined(var0.unresolved_collision_notify_min)) {
      var2 = var0.unresolved_collision_notify_min;
    }

    if(self.unresolved_collision_count >= var2) {
      if(isDefined(var0)) {
        if(isDefined(var0.unresolved_collision_func)) {
          var0[[var0.unresolved_collision_func]](self, var1);
        } else if(isDefined(var0.unresolved_collision_kill) && var0.unresolved_collision_kill) {
          unresolved_collision_owner_damage(var0, self);
        } else if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          if(!scripts\cp_mp\vehicles\vehicle::ref_1418b(var0, self)) {
            unresolved_collision_nearest_node(var0, self);
          }
        } else {
          unresolved_collision_nearest_node(var0, self);
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

function unresolved_collision_owner_damage(var0) {
  var1 = self;

  if(!isDefined(var1.owner)) {
    mover_suicide(var0);
    return;
  }

  var2 = 0;

  if(level.teambased) {
    if(isDefined(var1.owner.team) && var1.owner.team != var0.team) {
      var2 = 1;
    }
  } else if(var0 != var1.owner) {
    var2 = 1;
  }

  if(!var2) {
    mover_suicide(var0);
    return;
  }

  var3 = 1000;

  if(isDefined(var1.unresolved_collision_damage)) {
    var3 = var1.unresolved_collision_damage;
  }

  var0 dodamage(var3, var1.origin, var1.owner, var1, "MOD_CRUSH");
}

function unresolved_collision_nearest_node(var0, var1) {
  if(isDefined(level.override_unresolved_collision)) {
    self[[level.override_unresolved_collision]](var0, var1);
    return;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\cp\utility::tryingtoleave()) {
    var1 = 1;

    if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(self, 1);

      if(isDefined(var2)) {
        var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitpositionandangles(self, var0, var2, 1);

        if(isDefined(var3)) {
          var0 setOrigin(var3[0]);
          return;
        }
      }
    }
  } else {
    var4 = self.unresolved_collision_nodes;

    if(isDefined(var4)) {
      var4 = sortbydistance(var4, var0.origin);
    } else {
      var4 = getnodesinradius(var0.origin, 300, 0, 200);
      var4 = sortbydistance(var4, var0.origin);
    }

    var5 = (0, 0, -100);
    var0 cancelmantle();
    var0 dontinterpolate();
    var0 setOrigin(var0.origin + var5);

    for(var6 = 0; var6 < var4.size; var6++) {
      var7 = var4[var6];
      var8 = var7.origin;

      if(!canspawn(var8)) {
        continue;
      }

      if(positionwouldtelefrag(var8)) {
        continue;
      }

      if(var0 getstance() == "prone") {
        var0 setstance("crouch");
      }

      var0 setOrigin(var8);
      return;
    }

    var0 setOrigin(var0.origin - var5);
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(var1) {
    mover_suicide(var0);
    return;
  }
}

function unresolved_collision_void(var0, var1) {}

function mover_suicide() {
  if(isDefined(level.ishorde) && !isagent(self)) {
    return;
  }

  scripts\cp\utility::_suicide();
}

function player_pushed_kill(var0) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for(;;) {
    self waittill("player_pushed", var1, var2);

    if(isPlayer(var1) || isagent(var1)) {
      var3 = length(var2);

      if(var3 >= var0) {
        unresolved_collision_owner_damage(var1);
      }
    }
  }
}

function stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

function script_mover_get_top_parent() {
  var0 = self getlinkedparent();

  for(var1 = var0; isDefined(var1); var1 = var1 getlinkedparent()) {
    var0 = var1;
  }

  return var0;
}

function script_mover_start_use(var0) {
  var1 = script_mover_get_top_parent(var0);

  if(isDefined(var1)) {
    var1.startuseorigin = var1.origin;
  }

  self.startusemover = self getmovingplatformparent();

  if(isDefined(self.startusemover)) {
    var2 = script_mover_get_top_parent(self.startusemover);

    if(isDefined(var2)) {
      self.startusemover = var2;
    }

    self.startusemover.startuseorigin = self.startusemover.origin;
    return;
  }
}

function script_mover_has_parent_moved(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  return lengthsquared(var0.origin - var0.startuseorigin) > 0.001;
}

function script_mover_use_can_link(var0) {
  if(!isPlayer(self)) {
    return true;
  }

  if(!isDefined(var0)) {
    return false;
  }

  var1 = script_mover_get_top_parent(var0);
  var2 = self.startusemover;

  if(!isDefined(var1) && !isDefined(var2)) {
    return true;
  }

  if(isDefined(var1) && isDefined(var2) && var1 == var2) {
    return true;
  }

  if(script_mover_has_parent_moved(var1)) {
    return false;
  }

  if(script_mover_has_parent_moved(var2)) {
    return false;
  }

  return true;
}

function script_mover_link_to_use_object(var0) {
  if(isPlayer(var0)) {
    script_mover_start_use(var0, self);
    var1 = var0 getmovingplatformparent();
    var2 = undefined;

    if(isDefined(var1)) {
      var2 = var1;
    } else if(!isDefined(script_mover_get_top_parent())) {
      var2 = self;
    } else {
      var2 = spawn("script_model", var0.origin);
      var2 setModel("tag_origin");
      var0.scriptmoverlinkdummy = var2;
      thread sciprt_mover_use_object_wait_for_disconnect(var0);
    }

    var0 playerlinkTo(var2);
  } else {
    var0 linkTo(self);
  }

  var0 playerlinkedoffsetenable();
}

function script_mover_unlink_from_use_object(var0) {
  var0 unlink();

  if(isDefined(var0.scriptmoverlinkdummy)) {
    var0 notify("removeMoverLinkDummy");
    var0.scriptmoverlinkdummy delete();
    var0.scriptmoverlinkdummy = undefined;
    return;
  }
}

function sciprt_mover_use_object_wait_for_disconnect(var0) {
  self endon("removeMoverLinkDummy");
  scripts\engine\utility::ref_143a5("death", "disconnect");
  self.scriptmoverlinkdummy delete();
  self.scriptmoverlinkdummy = undefined;
}

function notify_moving_platform_invalid() {
  var0 = self getlinkedchildren(0);

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0) {
    if(isDefined(var2.no_moving_platfrom_unlink) && var2.no_moving_platfrom_unlink) {
      continue;
    }

    var2 unlink();
    var2 notify("invalid_parent", self);
  }
}

function process_moving_platform_death(var0, var1) {
  if(isDefined(var1) && isDefined(var1.no_moving_platfrom_death) && var1.no_moving_platfrom_death) {
    return;
  }

  if(isDefined(var0.playdeathfx)) {
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(var0.deathoverridecallback)) {
    var0.lasttouchedplatform = var1;
    self thread[[var0.deathoverridecallback]](var0);
    return;
  }

  self delete();
}

function handle_moving_platform_touch(var0) {
  self notify("handle_moving_platform_touch");
  self endon("handle_moving_platform_touch");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");
  jumpiffalse(isDefined(var0.endonstring)) LOC_0000003b;
  self endon(var0.endonstring);

  for(;;) {
    self waittill("touching_platform", var1);

    if(isDefined(var0.validateaccuratetouching) && var0.validateaccuratetouching) {
      if(!self istouching(var1)) {
        wait 0.05;
        continue;
      }
    }

    thread process_moving_platform_death(var0, var1);
    break;
  }
}

function handle_moving_platform_invalid(var0) {
  self notify("handle_moving_platform_invalid");
  self endon("handle_moving_platform_invalid");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");
  jumpiffalse(isDefined(var0.endonstring)) LOC_0000003b;
  self endon(var0.endonstring);
  self waittill("invalid_parent", var1);

  if(isDefined(var0.invalidparentoverridecallback)) {
    self thread[[var0.invalidparentoverridecallback]](var0);
    return;
  }

  thread process_moving_platform_death(var0, var1);
}

function handle_moving_platforms(var0) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(var0)) {
    var0 = spawnStruct();
  }

  if(isDefined(var0.endonstring)) {
    self endon(var0.endonstring);
  }

  if(isDefined(var0.linkparent)) {
    var1 = self getlinkedparent();

    if(!isDefined(var1) || var1 != var0.linkparent) {
      self linkTo(var0.linkparent);
    }
  }

  if(isDefined(var0.linkparents)) {
    if(isarray(var0.linkparents)) {
      foreach(var3 in var0.linkparents) {
        var1 = self getlinkedparent();

        if(!isDefined(var1) || var1 != var3) {
          self linkTo(var3);
        }
      }
    }
  }

  thread handle_moving_platform_touch(var0);
  thread handle_moving_platform_invalid(var0);
}

function stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

function moving_platform_empty_func(var0) {}