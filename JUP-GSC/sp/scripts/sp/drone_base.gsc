/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\drone_base.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\friendlyfire;
#using scripts\sp\names;
#using scripts\sp\utility;
#namespace drone_base;

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
  }
}

function thermaldrawenabledrone() {
  if(!isDefined(level.dronesthermalteamselect)) {
    level.dronesthermalteamselect = "all";
  }

  enablethermal = 0;

  switch (level.dronesthermalteamselect) {
    case #"hash_c482c6c109150a4":
      enablethermal = 1;
      break;
    case #"hash_7c2d091e6337bf54":
      enablethermal = self.team == "axis";
      break;
    default:
      break;
  }

  if(enablethermal) {
    self thermaldrawenable();
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
  target = self.target;
  node = getStruct(target, "targetname");

  if(!isDefined(node)) {
    return;
  }

  vectors = [];
  completed_nodes = [];
  original_node = node;

  for(;;) {
    node = original_node;

    for(var_42b4575e536fb56f = 0;; var_42b4575e536fb56f = 1) {
      if(!isDefined(node.target)) {
        break;
      }

      nextnodes = getStructArray(node.target, "targetname");

      if(nextnodes.size) {
        break;
      }

      nextnode = undefined;

      foreach(newnode in nextnodes) {
        if(isDefined(completed_nodes[newnode.origin + ""])) {
          continue;
        }

        nextnode = newnode;
        break;
      }

      if(!isDefined(nextnode)) {
        break;
      }

      completed_nodes[nextnode.origin + ""] = 1;
      vectors[node.targetname] = nextnode.origin - node.origin;
      node.angles = vectortoangles(vectors[node.targetname]);
      node = nextnode;
    }

    if(!var_42b4575e536fb56f) {
      break;
    }
  }

  target = self.target;
  node = getStruct(target, "targetname");
  prevnode = node;
  completed_nodes = [];

  for(;;) {
    node = original_node;
    var_42b4575e536fb56f = 0;

    for(;;) {
      if(!isDefined(node.target)) {
        return;
      }

      if(!isDefined(vectors[node.targetname])) {
        return;
      }

      nextnodes = getStructArray(node.target, "targetname");

      if(nextnodes.size) {
        break;
      }

      nextnode = undefined;

      foreach(newnode in nextnodes) {
        if(isDefined(completed_nodes[newnode.origin + ""])) {
          continue;
        }

        nextnode = newnode;
        break;
      }

      if(!isDefined(nextnode)) {
        break;
      }

      if(isDefined(node.radius)) {
        vec1 = vectors[prevnode.targetname];
        vec2 = vectors[node.targetname];
        vec = (vec1 + vec2) * 0.5;
        node.angles = vectortoangles(vec);
      }

      var_42b4575e536fb56f = 1;
      prevnode = node;
      node = nextnode;
    }

    if(!var_42b4575e536fb56f) {
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