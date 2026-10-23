/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_movers.gsc
***************************************/

main() {
  if(getDvar("233") == "1") {
    return;
  }
  level.getpointinbounds = [];
  level.getpointinbounds["move_time"] = 5;
  level.getpointinbounds["accel_time"] = 0;
  level.getpointinbounds["decel_time"] = 0;
  level.getpointinbounds["wait_time"] = 0;
  level.getpointinbounds["delay_time"] = 0;
  level.getpointinbounds["usable"] = 0;
  level.getpointinbounds["hintstring"] = "activate";
  script_mover_add_hintstring("activate", &"MP_ACTIVATE_MOVER");
  getplayersetting("none", "");
  level.vehicle_isphysveh = [];
  level.script_mover_animations = [];
  waitframe();
  var_0 = [];
  var_1 = script_mover_classnames();

  foreach(var_3 in var_1) {
    var_0 = common_scripts\utility::_id_0F73(var_0, getEntArray(var_3, "classname"));
  }

  common_scripts\utility::_id_0FB2(var_0, ::script_mover_init);
}

script_mover_classnames() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

isturretready() {
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

script_mover_add_hintstring(var_0, var_1) {
  if(!isDefined(level.playersetatmosfog)) {
    level.playersetatmosfog = [];
  }

  level.playersetatmosfog[var_0] = var_1;
}

getplayersetting(var_0, var_1) {
  if(!isDefined(level.vehphys_disablecrashing)) {
    level.vehphys_disablecrashing = [];
  }

  level.vehphys_disablecrashing[var_0] = var_1;
}

script_mover_add_animation(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.script_mover_animations)) {
    level.script_mover_animations = [];
  }

  if(!isDefined(var_3)) {
    var_3 = "default";
  }

  if(!isDefined(level.script_mover_animations[var_0])) {
    level.script_mover_animations[var_0] = [];
  }

  var_4 = spawnStruct();
  var_4._id_0EC4 = var_1;
  var_4._id_0ED1 = var_2;
  level.script_mover_animations[var_0][var_3] = var_4;
}

script_mover_init() {
  self.script_mover = 1;
  self.moving = 0;
  self.origin_ent = self;
  self.use_triggers = [];
  self.linked_ents = [];
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    switch (var_2._id_0165) {
      case "origin":
        if(!isDefined(var_2.angles)) {
          var_2.angles = (0, 0, 0);
        }

        self.origin_ent = spawn("script_model", var_2.origin);
        self.origin_ent.angles = var_2.angles;
        self.origin_ent setModel("tag_origin");
        self.origin_ent linkTo(self);
        break;
      case "scene_node":
      case "scripted_node":
        if(!isDefined(var_2.angles)) {
          var_2.angles = (0, 0, 0);
        }

        self.setviewkickscale = var_2;
        break;
      default:
        break;
    }
  }

  var_4 = [];

  if(isDefined(self.target)) {
    var_4 = getEntArray(self.target, "targetname");
  }

  foreach(var_2 in var_4) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    var_6 = strtok(var_2._id_0165, ";");

    foreach(var_8 in var_6) {
      switch (var_8) {
        case "use_trigger_link":
          var_2 enablelinkTo();
          var_2 linkTo(self);
        case "use_trigger":
          var_2 script_mover_parse_targets();
          thread startscriptedanim(var_2);
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
  }

  thread script_mover_parse_targets();
  thread getplayerdata();
  thread playerlinkedvehicleanglesdisable();
  thread playersetstreamorigin();
  thread setmotiontrackervisible(self);
  thread playerlinkedvehicleanglesenable();
  painvisionoff();

  foreach(var_12 in self.use_triggers) {
    nightvisionviewon(var_12, 1);
  }

  self.script_mover_init = 1;
  self notify("script_mover_init");
}

painvisionoff() {
  if(script_mover_is_animated()) {
    thread script_mover_animate();
  } else {
    thread vehicle_dospawn();
  }
}

playerlinkedvehicleanglesenable() {
  self.mover_reset_origin = self.origin;
  self.mover_reset_angles = self.angles;
}

playerlinkedturretanglesdisable(var_0) {
  self notify("mover_reset");

  if(script_mover_is_animated()) {
    self scriptmodelclearanim();
  }

  self.origin = self.mover_reset_origin;
  self.angles = self.mover_reset_angles;
  self notify("new_path");
  waitframe();
  painvisionoff();
}

startscriptedanim(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger");

    if(var_0.goals.size > 0) {
      self notify("new_path");
      thread vehicle_dospawn(var_0);
      continue;
    }

    self notify("trigger");
  }
}

vehicledriveto(var_0) {
  if(isDefined(level.vehicle_isphysveh[var_0])) {
    self notify("new_path");
    self.goals = level.vehicle_isphysveh[var_0];
    thread vehicle_dospawn();
  }
}

_id_0DDE(var_0) {
  return (_angleclamp180(var_0[0]), _angleclamp180(var_0[1]), _angleclamp180(var_0[2]));
}

script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }
  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  var_0 = [];
  var_1 = [];

  if(isDefined(self.target)) {
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");
    var_1 = getEntArray(self.target, "targetname");
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3._id_0165)) {
      var_3._id_0165 = "goal";
    }

    switch (var_3._id_0165) {
      case "ignore":
        if(isDefined(var_3.target)) {
          var_4 = common_scripts\utility::getstructarray(var_3.target, "targetname");

          foreach(var_6 in var_4) {
            var_0[var_0.size] = var_6;
          }
        }

        break;
      case "goal":
        var_3 getplayerdata();
        var_3 script_mover_parse_targets();
        self.goals[self.goals.size] = var_3;

        if(isDefined(var_3.params["name"])) {
          if(!isDefined(level.vehicle_isphysveh[var_3.params["name"]])) {
            level.vehicle_isphysveh[var_3.params["name"]] = [];
          }

          var_8 = level.vehicle_isphysveh[var_3.params["name"]].size;
          level.vehicle_isphysveh[var_3.params["name"]][var_8] = var_3;
        }

        break;
      default:
        break;
    }
  }

  foreach(var_10 in var_1) {
    if(var_10 isturretready()) {
      self.movers[self.movers.size] = var_10;
    }

    thread vehphys_enablecrashing(var_10);
  }
}

vehphys_enablecrashing(var_0) {
  if(!isDefined(var_0._id_0165)) {
    return;
  }
  if(var_0 isturretready() && !isDefined(var_0.script_mover_init)) {
    var_0 waittill("script_mover_init");
  }

  var_1 = strtok(var_0._id_0165, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_");

    if(var_4.size < 3 || var_4[1] != "on") {
      continue;
    }
    var_5 = _tolower(var_4[0]);
    var_6 = var_4[2];

    for(var_7 = 3; var_7 < var_4.size; var_7++) {
      var_6 = var_6 + "_" + var_4[var_7];
    }

    switch (var_5) {
      case "connectpaths":
        thread setweaponhudiconoverride(var_0, var_6, ::worldpointinreticle_rect, ::script_mover_disconnectpaths);
        break;
      case "disconnectpaths":
        thread setweaponhudiconoverride(var_0, var_6, ::script_mover_disconnectpaths, ::worldpointinreticle_rect);
        break;
      case "solid":
        var_0 notsolid();
        thread setweaponhudiconoverride(var_0, var_6, ::painvisionon, ::vehphys_launch);
        break;
      case "notsolid":
        thread setweaponhudiconoverride(var_0, var_6, ::vehphys_launch, ::painvisionon);
        break;
      case "delete":
        thread setweaponhudiconoverride(var_0, var_6, ::script_mover_delete);
        break;
      case "hide":
        thread setweaponhudiconoverride(var_0, var_6, ::script_mover_hide, ::nightvisionviewoff);
        break;
      case "show":
        var_0 hide();
        thread setweaponhudiconoverride(var_0, var_6, ::nightvisionviewoff, ::script_mover_hide);
        break;
      case "triggerhide":
        thread setweaponhudiconoverride(var_0, var_6, ::setplayerintelfound, ::script_mover_trigger_on);
        break;
      case "triggershow":
        var_0 common_scripts\utility::trigger_off();
        thread setweaponhudiconoverride(var_0, var_6, ::script_mover_trigger_on, ::setplayerintelfound);
        break;
      case "trigger":
        thread setweaponhudiconoverride(var_0, var_6, ::getplayerintelisfound, ::playerlinkedturretanglesdisable);
        break;
      default:
        break;
    }
  }
}

setplayerintelfound(var_0) {
  self dontinterpolate();
  common_scripts\utility::trigger_off();
}

script_mover_trigger_on(var_0) {
  self dontinterpolate();
  common_scripts\utility::trigger_on();
}

vehphys_crash(var_0, var_1) {
  var_0 notify(var_1);
}

vehicleturretcontroloff(var_0, var_1) {
  level notify(var_1);
}

worldpointinreticle_rect(var_0) {
  self connectpaths();
}

script_mover_disconnectpaths(var_0) {
  self disconnectPaths(var_0);
}

painvisionon(var_0) {
  self solid();
}

vehphys_launch(var_0) {
  self notsolid();
}

script_mover_delete(var_0) {
  self delete();
}

script_mover_hide(var_0) {
  self hide();
}

nightvisionviewoff(var_0) {
  self show();
}

getplayerintelisfound(var_0) {
  self notify("trigger");
}

setweaponhudiconoverride(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill(var_1, var_4);
    var_0[[var_2]](var_4);

    if(isDefined(var_3) && isDefined(var_4)) {
      var_4 startcoverbehavior(var_0, var_3);
      continue;
    }

    break;
  }
}

script_mover_update_paths() {
  var_0 = [];

  if(script_mover_is_dynamic_path()) {
    var_0[var_0.size] = self;
  }

  foreach(var_2 in self.linked_ents) {
    if(var_2 script_mover_is_dynamic_path()) {
      var_0[var_0.size] = var_2;
    }
  }

  if(var_0.size == 0) {
    return;
  }
  for(;;) {
    foreach(var_5 in var_0) {
      var_5 script_mover_disconnectpaths();
    }

    self waittill("move_start");

    foreach(var_5 in var_0) {
      var_5 worldpointinreticle_rect();
    }

    self waittill("move_end");
  }
}

script_mover_animate() {
  childthread script_mover_update_paths();
  var_0 = self.params["animation"];

  if(isDefined(level.script_mover_animations[var_0]["idle"])) {
    playerlinkedturretanglesenable(level.script_mover_animations[var_0]["idle"], 0);
  }

  script_mover_delay();
  self notify("move_start");
  self notify("start", self);
  var_1 = level.script_mover_animations[var_0]["default"];

  if(isDefined(var_1)) {
    playerlinkedturretanglesenable(var_1, 1);
    self waittill("end");
  }

  self notify("move_end");
}

playerlinkedturretanglesenable(var_0, var_1) {
  self notify("play_animation");

  if(var_1) {
    thread script_mover_handle_notetracks();
  }

  if(isDefined(self.setviewkickscale)) {
    self scriptmodelplayanimdeltamotionfrompos(var_0._id_0EC4, self.setviewkickscale.origin, self.setviewkickscale.angles, "script_mover_anim");
  } else {
    self scriptmodelplayanimdeltamotion(var_0._id_0EC4, "script_mover_anim");
  }
}

script_mover_handle_notetracks() {
  self endon("play_animation");
  self endon("mover_reset");

  for(;;) {
    self waittill("script_mover_anim", var_0);
    self notify(var_0, self);
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
    wait(self.params["delay_time"]);
  }
}

vehicle_dospawn(var_0) {
  self endon("death");
  self endon("new_path");
  childthread script_mover_update_paths();

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  while(var_0.goals.size != 0) {
    var_1 = common_scripts\utility::random(var_0.goals);
    var_2 = self;
    var_2 setmotiontrackervisible(var_1);
    var_2 script_mover_delay();
    var_3 = var_2.params["move_time"];
    var_4 = var_2.params["accel_time"];
    var_5 = var_2.params["decel_time"];
    var_6 = 0;
    var_7 = 0;
    var_8 = _transformmove(var_1.origin, var_1.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

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

      if(var_3 <= 0) {
        var_2 dontinterpolate();
        var_2.origin = var_8["origin"];
      } else
        var_2 moveTo(var_8["origin"], var_3, var_4, var_5);

      var_6 = 1;
    }

    if(_id_0DDE(var_8["angles"]) != _id_0DDE(var_2.angles)) {
      if(var_3 <= 0) {
        var_2 dontinterpolate();
        var_2.angles = var_8["angles"];
      } else
        var_2 rotateTo(var_8["angles"], var_3, var_4, var_5);

      var_7 = 1;
    }

    foreach(var_11 in var_2.movers) {
      var_11 notify("trigger");
      startcoverbehavior(var_11, ::playerlinkedturretanglesdisable);
    }

    var_2 notify("move_start");
    var_0 notify("depart", var_2);

    if(isDefined(var_2.params["name"])) {
      var_13 = "mover_depart_" + var_2.params["name"];
      var_2 notify(var_13);
      level notify(var_13, var_2);
    }

    var_2 setlocalplayerprofiledata(0);

    if(var_3 <= 0) {} else if(var_6) {
      var_2 waittill("movedone");
    } else if(var_7) {
      var_2 waittill("rotatedone");
    } else {
      wait(var_3);
    }

    var_2 notify("move_end");
    var_1 notify("arrive", var_2);

    if(isDefined(var_2.params["name"])) {
      var_13 = "mover_arrive_" + var_2.params["name"];
      var_2 notify(var_13);
      level notify(var_13, var_2);
    }

    if(isDefined(var_2.params["solid"])) {
      if(var_2.params["solid"]) {
        var_2 solid();
      } else {
        var_2 notsolid();
      }
    }

    foreach(var_11 in var_1.movers) {
      var_11 notify("trigger");
      startcoverbehavior(var_11, ::playerlinkedturretanglesdisable);
    }

    if(isDefined(var_2.params["wait_till"])) {
      level waittill(var_2.params["wait_till"]);
    }

    if(var_2.params["wait_time"] > 0) {
      wait(var_2.params["wait_time"]);
    }

    var_2 setlocalplayerprofiledata(1);
    var_0 = var_1;
  }
}

startcoverbehavior(var_0, var_1) {
  thread setweaponhudiconoverride(var_0, "mover_reset", var_1);
}

getplayerdata() {
  self.params = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = _id_0DDE(self.angles);
  vehphys_setspeed(self.setlookatent);
}

vehphys_setspeed(var_0) {
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
        self.params[var_4[0]] = vehphys_setconveyorbelt(var_4[1]);
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
        var_6 = level.vehphys_disablecrashing[var_5];

        if(isDefined(var_6)) {
          vehphys_setspeed(var_6);
        }

        break;
      default:
        break;
    }
  }
}

vehphys_setconveyorbelt(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, ",");

  if(var_2.size == 1) {
    var_1 = _float(var_2[0]);
  } else if(var_2.size == 2) {
    var_3 = _float(var_2[0]);
    var_4 = _float(var_2[1]);

    if(var_3 >= var_4) {
      var_1 = var_3;
    } else {
      var_1 = _randomfloatrange(var_3, var_4);
    }
  }

  return var_1;
}

setmotiontrackervisible(var_0) {
  foreach(var_3, var_2 in var_0.params) {
    playerclearstreamorigin(var_3, var_2);
  }

  playersetstreamorigin();
}

playerclearstreamorigin(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "usable" && isDefined(var_1)) {
    nightvisionviewon(self, var_1);
  }

  if(isDefined(var_1) && _isstring(var_1) && var_1 == "<undefined>") {
    var_1 = undefined;
  }

  self.params[var_0] = var_1;
}

setlocalplayerprofiledata(var_0) {
  if(self.params["usable"]) {
    nightvisionviewon(self, var_0);
  }

  foreach(var_2 in self.use_triggers) {
    nightvisionviewon(var_2, var_0);
  }
}

nightvisionviewon(var_0, var_1) {
  if(var_1) {
    var_0 makeusable();
    var_0 setCursorHint("HINT_ACTIVATE");
    var_0 setHintString(level.playersetatmosfog[self.params["hintstring"]]);
  } else
    var_0 makeunusable();
}

playerlinkedvehicleanglesdisable() {
  self.params_default = [];

  foreach(var_2, var_1 in self.params) {
    self.params_default[var_2] = var_1;
  }
}

playersetstreamorigin() {
  if(isDefined(self.params_default)) {
    foreach(var_2, var_1 in self.params_default) {
      if(!isDefined(self.params[var_2])) {
        playerclearstreamorigin(var_2, var_1);
      }
    }
  }

  foreach(var_2, var_1 in level.getpointinbounds) {
    if(!isDefined(self.params[var_2])) {
      playerclearstreamorigin(var_2, var_1);
    }
  }
}

script_mover_is_dynamic_path() {
  return isDefined(self.spawnflags) && self.spawnflags & 1;
}

script_mover_is_animated() {
  return isDefined(self.params["animation"]);
}

init() {
  level thread worldpointinreticle_circle();
  level thread getlocalplayerprofiledata();
}

worldpointinreticle_circle() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread player_unresolved_collision_watch();
  }
}

getlocalplayerprofiledata() {
  for(;;) {
    level waittill("spawned_agent", var_0);
    var_0 thread player_unresolved_collision_watch();
  }
}

player_unresolved_collision_watch() {
  self endon("disconnect");

  if(_isagent(self)) {
    self endon("death");
  }

  self.unresolved_collision_count = 0;

  for(;;) {
    self waittill("unresolved_collision", var_0);

    if(_isagent(self) && isDefined(self._id_0EAE)) {
      if(self scragentgetphysicsmode() == "noclip") {
        continue;
      }
    }

    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    var_1 = 3;

    if(isDefined(var_0) && isDefined(var_0.unresolved_collision_notify_min)) {
      var_1 = var_0.unresolved_collision_notify_min;
    }

    if(self.unresolved_collision_count >= var_1) {
      if(isDefined(var_0)) {
        if(isDefined(var_0.unresolved_collision_func)) {
          var_0[[var_0.unresolved_collision_func]](self);
        } else if(isDefined(var_0.unresolved_collision_kill) && var_0.unresolved_collision_kill) {
          var_0 unresolved_collision_owner_damage(self);
        } else {
          var_0 unresolved_collision_nearest_node(self);
        }
      } else
        unresolved_collision_nearest_node(self);

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

unresolved_collision_owner_damage(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_0117)) {
    var_0 mover_suicide();
    return;
  }

  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_1._id_0117.team) && var_1._id_0117.team != var_0.team) {
      var_2 = 1;
    }
  } else if(var_0 != var_1._id_0117)
    var_2 = 1;

  if(!var_2) {
    var_0 mover_suicide();
    return;
  }

  var_3 = 1000;

  if(isDefined(var_1.unresolved_collision_damage)) {
    var_3 = var_1.unresolved_collision_damage;
  }

  var_0 dodamage(var_3, var_1.origin, var_1._id_0117, var_1, "MOD_CRUSH");
}

unresolved_collision_nearest_node(var_0, var_1) {
  var_2 = self.unresolved_collision_nodes;
  var_3 = undefined;

  if(maps\mp\_utility::_id_585F() && common_scripts\utility::_id_562E(level.use_zombie_unresolved_collision)) {
    if(!isDefined(var_2)) {
      var_2 = [];
    }

    var_4 = _func_2E1(var_0.origin);

    if(isDefined(var_4)) {
      var_3 = spawnStruct();
      var_3.origin = _func_2E1(var_0.origin);
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_3);
    }

    var_2 = common_scripts\utility::_id_0F73(var_2, _getnodesinradius(var_0.origin, 300, 0, 200, "End 3D"));

    if(isDefined(level.failsafe_collision_nodes) && _isarray(level.failsafe_collision_nodes)) {
      var_2 = common_scripts\utility::_id_0F73(var_2, level.failsafe_collision_nodes);
    }
  }

  if(isDefined(var_2)) {
    var_2 = _sortbydistance(var_2, var_0.origin);
  } else {
    var_2 = _getnodesinradius(var_0.origin, 300, 0, 200);
    var_2 = _sortbydistance(var_2, var_0.origin);
  }

  var_5 = (0, 0, -100);
  var_0 cancelmantle();
  var_0 dontinterpolate();
  var_0 setOrigin(var_0.origin + var_5);

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];
    var_8 = var_7.origin;

    if(!_canspawn(var_8)) {
      continue;
    }
    if(_positionwouldtelefrag(var_8)) {
      continue;
    }
    if(var_0 same_color_code_as_last_time()) {
      var_0 _id_028D::forcedismountweapon();
    }

    if(var_0 getstance() == "prone") {
      var_0 setstance("crouch");
    }

    var_0 setOrigin(var_8);
    return;
  }

  if(level._id_015D == "mp_hub_allies_slim" && var_2.size == 0) {
    if(var_0 same_color_code_as_last_time()) {
      var_0 _id_028D::forcedismountweapon();
    }

    return;
  }

  var_0 setOrigin(var_0.origin - var_5);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    var_0 mover_suicide();
  }
}

unresolved_collision_void(var_0) {}

mover_suicide() {
  maps\mp\_utility::_suicide();
}

player_pushed_kill(var_0) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for(;;) {
    self waittill("player_pushed", var_1, var_2);

    if(isPlayer(var_1) || _isagent(var_1)) {
      var_3 = length(var_2);

      if(var_3 >= var_0) {
        unresolved_collision_owner_damage(var_1);
      }
    }
  }
}

stop_player_pushed_kill() {
  self notify("stop_player_pushed_kill");
}

notify_moving_platform_invalid() {
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

process_moving_platform_death(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.no_moving_platfrom_death) && var_1.no_moving_platfrom_death) {
    return;
  }
  if(isDefined(var_0.playdeathfx)) {
    playFX(common_scripts\utility::getfx("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(var_0.deathoverridecallback)) {
    self thread[[var_0.deathoverridecallback]](var_0);
  } else {
    self delete();
  }
}

handle_moving_platform_touch(var_0) {
  for(;;) {
    self waittill("touching_platform", var_1);

    if(isDefined(var_0.touchingplatformvalid) && !self[[var_0.touchingplatformvalid]](var_1)) {
      continue;
    }
    if(isDefined(var_0.validateaccuratetouching) && var_0.validateaccuratetouching) {
      if(!self istouching(var_1)) {
        waitframe();
        continue;
      }
    }

    thread process_moving_platform_death(var_0, var_1);
    break;
  }
}

handle_moving_platform_invalid(var_0) {
  self waittill("invalid_parent", var_1);

  if(isDefined(var_0.invalidparentoverridecallback)) {
    self thread[[var_0.invalidparentoverridecallback]](var_0);
  } else {
    thread process_moving_platform_death(var_0, var_1);
  }
}

handle_moving_platforms(var_0) {
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
    self linkTo(var_0.linkparent);
  }

  childthread handle_moving_platform_touch(var_0);
  childthread handle_moving_platform_invalid(var_0);
}

stop_handling_moving_platforms() {
  self notify("stop_handling_moving_platforms");
}

moving_platform_empty_func(var_0) {}