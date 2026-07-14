/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\drone_base.gsc
**************************************/

#using scripts\engine\utility;
#using scripts\sp\friendlyfire;
#using scripts\sp\names;
#namespace drone_base;

function drone_give_soul() {
  assign_drone_tree();
  self startusingheroonlylighting();

  if(isDefined(self.script_moveplaybackrate)) {
    self.moveplaybackrate = self.script_moveplaybackrate;
  } else {
    self.moveplaybackrate = 1;
  }

  if(self.team == "O\x15\x1b\xad\x9ff") {
    names::get_name();
    self setlookattext(self.name, &"");
  }

  if(isDefined(level.dronecallbackthread)) {
    self thread[[level.dronecallbackthread]]();
  }

  if(!isDefined(self.script_friendly_fire_disable)) {
    level thread friendlyfire::friendly_fire_think(self);
  }

  if(!isDefined(level.ai_dont_glow_in_thermal)) {
    thermaldrawenabledrone();
  }
}

function thermaldrawenabledrone() {
  if(!isDefined(level.dronesthermalteamselect)) {
    level.dronesthermalteamselect = "\xc0\xc6J";
  }

  enablethermal = 0;

  switch (level.dronesthermalteamselect) {
    case #"hash_c482c6c109150a4":
      enablethermal = 1;
      break;
    case #"hash_7c2d091e6337bf54":
      enablethermal = self.team == "?\xb1\xc0\x9a";
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
  node = utility::getStruct(target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  if(!isDefined(node)) {
    return;
  }

  vectors = [];
  completed_nodes = [];
  original_node = node;

  for(;;) {
    node = original_node;

    for(var_fae289a6e7b33746 = 0;; var_fae289a6e7b33746 = 1) {
      if(!isDefined(node.target)) {
        break;
      }

      nextnodes = utility::getStructArray(node.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

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

    if(!var_fae289a6e7b33746) {
      break;
    }
  }

  target = self.target;
  node = utility::getStruct(target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  prevnode = node;
  completed_nodes = [];

  for(;;) {
    node = original_node;
    var_fae289a6e7b33746 = 0;

    for(;;) {
      if(!isDefined(node.target)) {
        return;
      }

      if(!isDefined(vectors[node.targetname])) {
        return;
      }

      nextnodes = utility::getStructArray(node.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

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

      var_fae289a6e7b33746 = 1;
      prevnode = node;
      node = nextnode;
    }

    if(!var_fae289a6e7b33746) {
      break;
    }
  }
}

function assign_drone_tree() {
  if(isDefined(self.type)) {
    if(self.type == "\xde\x9d\xa5") {
      assign_animals_tree();
      return;
    }

    assign_generic_human_tree();
  }
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function assign_generic_human_tree() {
  self useanimtree(#animtree);
}

#using_animtree("}\n\xc6\x10\x1bTW");

function assign_animals_tree() {
  self useanimtree(#animtree);
}