/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_drone_base.gsc
********************************/

drone_give_soul() {
  assign_drone_tree();
  self startusingheroonlylighting();

  if(isdefined(self.script_moveplaybackrate))
    self.moveplaybackrate = self.script_moveplaybackrate;
  else
    self.moveplaybackrate = 1;

  if(self.team == "allies") {
    maps\_names::get_name();

    if(isdefined(self.name))
      self setlookattext(self.name, & "");
  }

  if(isdefined(level.dronecallbackthread))
    self thread[[level.dronecallbackthread]]();

  if(!isdefined(self.script_friendly_fire_disable))
    level thread maps\_friendlyfire::friendly_fire_think(self);

  if(!isdefined(level.ai_dont_glow_in_thermal))
    thermaldrawenabledrone();
}

thermaldrawenabledrone() {
  if(!isdefined(level.dronesthermalteamselect))
    level.dronesthermalteamselect = "all";

  var_0 = 0;

  switch (level.dronesthermalteamselect) {
    case "all":
      var_0 = 1;
      break;
    case "axis":
      var_0 = self.team == "axis";
      break;
    default:
      break;
  }

  if(var_0)
    self thermaldrawenable();
}

drone_init_path() {
  if(!isdefined(self.target)) {
    return;
  }
  if(isdefined(level.drone_paths[self.target])) {
    return;
  }
  level.drone_paths[self.target] = 1;
  var_0 = self.target;
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  if(!isdefined(var_1)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = var_1;

  for (;;) {
    var_1 = var_4;
    var_5 = 0;

    for (;;) {
      if(!isdefined(var_1.target)) {
        break;
      }

      var_6 = common_scripts\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }

      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(isdefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isdefined(var_7)) {
        break;
      }

      var_3[var_7.origin + ""] = 1;
      var_2[var_1.targetname] = var_7.origin - var_1.origin;
      var_1.angles = vectortoangles(var_2[var_1.targetname]);
      var_1 = var_7;
      var_5 = 1;
    }

    if(!var_5) {
      break;
    }
  }

  var_0 = self.target;
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_11 = var_1;
  var_3 = [];

  for (;;) {
    var_1 = var_4;
    var_5 = 0;

    for (;;) {
      if(!isdefined(var_1.target)) {
        return;
      }
      if(!isdefined(var_2[var_1.targetname])) {
        return;
      }
      var_6 = common_scripts\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }

      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(isdefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isdefined(var_7)) {
        break;
      }

      if(isdefined(var_1.radius)) {
        var_14 = var_2[var_11.targetname];
        var_15 = var_2[var_1.targetname];
        var_16 = (var_14 + var_15) * 0.5;
        var_1.angles = vectortoangles(var_16);
      }

      var_5 = 1;
      var_11 = var_1;
      var_1 = var_7;
    }

    if(!var_5) {
      break;
    }
  }
}

assign_drone_tree() {
  if(isdefined(self.type)) {
    if(self.type == "dog")
      assign_animals_tree();
    else
      assign_generic_human_tree();
  }
}

#using_animtree("generic_human");

assign_generic_human_tree() {
  self useanimtree(#animtree);
}

#using_animtree("animals");

assign_animals_tree() {
  self useanimtree(#animtree);
}