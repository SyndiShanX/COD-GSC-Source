/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\drone_base.gsc
***********************************************/

function drone_give_soul() {
  assign_drone_tree();
  self startusingheroonlylighting();

  if(isDefined(self.script_moveplaybackrate)) {
    self.moveplaybackrate = self.script_moveplaybackrate;
  } else {
    self.moveplaybackrate = 1;
  }

  if(self.team == "allies") {
    scripts\sp\names::get_name();
    self setlookattext(self.name, &"");
  }

  if(isDefined(level.dronecallbackthread)) {
    self thread[[level.dronecallbackthread]]();
  }

  if(!isDefined(self.script_friendly_fire_disable)) {
    level thread scripts\sp\friendlyfire::friendly_fire_think(self);
  }

  if(!isDefined(level.ai_dont_glow_in_thermal)) {
    thermaldrawenabledrone();
    return;
  }
}

function thermaldrawenabledrone() {
  if(!isDefined(level.dronesthermalteamselect)) {
    level.dronesthermalteamselect = "all";
  }

  var0 = 0;

  switch (level.dronesthermalteamselect) {
    case "all":
      var0 = 1;
      break;
    case "axis":
      var0 = self.team == "axis";
      break;
    default:
      break;
  }

  if(var0) {
    self thermaldrawenable();
    return;
  }
}

function drone_init_path() {
  if(!isDefined(self.target)) {
    return;
  }

  if(isDefined(level.drone_paths[self.target])) {
    return;
  }

  level.drone_paths[self.target] = 1;
  var0 = self.target;
  var1 = scripts\engine\utility::getStruct(var0, "targetname");

  if(!isDefined(var1)) {
    return;
  }

  var2 = [];
  var3 = [];
  var4 = var1;

  for(;;) {
    var1 = var4;

    for(var5 = 0;; var5 = 1) {
      if(!isDefined(var1.target)) {
        break;
      }

      var6 = scripts\engine\utility::getStructArray(var1.target, "targetname");

      if(var6.size) {
        break;
      }

      var7 = undefined;

      foreach(var9 in var6) {
        if(isDefined(var3[var9.origin + ""])) {
          continue;
        }

        var7 = var9;
        break;
      }

      if(!isDefined(var7)) {
        break;
      }

      var3 = 1;
      var2 = var7.origin - var1.origin;
      var1.angles = vectortoangles(var2[var1.targetname]);
      var1 = var7;
    }

    if(!var5) {
      break;
    }
  }

  var0 = self.target;
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var11 = var1;
  var3 = [];

  for(;;) {
    var1 = var4;
    var5 = 0;

    for(;;) {
      if(!isDefined(var1.target)) {
        return;
      }

      if(!isDefined(var2[var1.targetname])) {
        return;
      }

      var6 = scripts\engine\utility::getStructArray(var1.target, "targetname");

      if(var6.size) {
        break;
      }

      var7 = undefined;

      foreach(var9 in var6) {
        if(isDefined(var3[var9.origin + ""])) {
          continue;
        }

        var7 = var9;
        break;
      }

      if(!isDefined(var7)) {
        break;
      }

      if(isDefined(var1.radius)) {
        var14 = var2[var11.targetname];
        var15 = var2[var1.targetname];
        var16 = (var14 + var15) * 0.5;
        var1.angles = vectortoangles(var16);
      }

      var5 = 1;
      var11 = var1;
      var1 = var7;
    }

    if(!var5) {
      break;
    }
  }
}

function assign_drone_tree() {
  if(isDefined(self.type)) {
    if(self.type == "dog") {
      assign_animals_tree();
      return;
    }

    assign_generic_human_tree();
    return;
  }
}

#using_animtree("generic_human");

function assign_generic_human_tree() {
  self useanimtree(#animtree);
}

#using_animtree("animals");

function assign_animals_tree() {
  self useanimtree(#animtree);
}