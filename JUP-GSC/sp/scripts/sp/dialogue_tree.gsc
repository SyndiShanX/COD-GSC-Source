/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\dialogue_tree.gsc
***********************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\dialogue_wheel;
#namespace dialogue_tree;

function function_e342035d4be91696() {
  level.var_1b2599094f1aa7a3 = spawnStruct();
  level.var_1b2599094f1aa7a3.actors = [];
  level.var_1b2599094f1aa7a3.nodes = [];
  level.var_1b2599094f1aa7a3.current_node = undefined;
  level.var_1b2599094f1aa7a3 thread function_511a5e11aca48790();
}

function function_511a5e11aca48790() {
  has_node = 0;

  while(true) {
    waitframe();

    if(!isDefined(level.var_1b2599094f1aa7a3.current_node)) {
      has_node = 0;
      continue;
    }

    if(!has_node) {
      level notify("dialogue_start");
    }

    has_node = 1;
    next_node = function_a375ef915e817d5d();

    if(istrue(level.var_1b2599094f1aa7a3.aborted)) {
      level.var_1b2599094f1aa7a3.aborted = undefined;
      continue;
    }

    level.var_1b2599094f1aa7a3.current_node = next_node;

    if(!isDefined(next_node)) {
      level notify("dialogue_end");
      continue;
    }

    level notify("dialogue_next_node");
  }
}

function function_a375ef915e817d5d() {
  level endon("dialogue_abort");
  current_node = level.var_1b2599094f1aa7a3.current_node;
  next_node = undefined;
  current_node.visited = 1;

  if(isDefined(current_node.func)) {
    next_node = current_node.owner[[current_node.func]]();
  } else {
    current_node.owner waittill(current_node.name + "_end", next_node);
  }

  current_node.completed = 1;

  if(isDefined(next_node)) {
    if(isstring(next_node)) {
      next_node = function_8c75a86890a649dc(next_node);
    }

    next_node.owner = current_node.owner;
  }

  return next_node;
}

function function_3ecb520991a212fc(name, animname, team) {
  if(isDefined(name)) {
    self.ainame = name;
  }

  if(isDefined(animname)) {
    self.animname = animname;
  }

  if(isDefined(team)) {
    self.team = team;
  }

  assert(isDefined(self.ainame), "Dialogue Tree Actor must have a name");
  assert(isDefined(self.animname), "Dialogue Tree Actor must have an animname");
  assert(isDefined(self.team), "Dialogue Tree Actor must have a team");
  actors = level.var_1b2599094f1aa7a3.actors[self.animname];

  if(isDefined(actors)) {
    if(!isarray(actors)) {
      actors = [actors];
    }

    level.var_1b2599094f1aa7a3.actors[self.animname] = array_add(actors, self);
    return;
  }

  level.var_1b2599094f1aa7a3.actors[self.animname] = self;
}

function function_3bcb10406ab4ad1d(animname) {
  if(!isDefined(animname)) {
    animname = self.animname;
  }

  actors = level.var_1b2599094f1aa7a3.actors[animname];

  if(isarray(actors)) {
    assert(isDefined(self) && is_equal(self.animname, animname), "Don't know which Dialogue Tree Actor to remove!");
    actors = array_remove(actors, self);

    if(actors.size > 1) {
      level.var_1b2599094f1aa7a3.actors[animname] = actors;
    } else {
      level.var_1b2599094f1aa7a3.actors[animname] = actors[0];
    }

    return;
  }

  level.var_1b2599094f1aa7a3.actors = array_remove_key(level.var_1b2599094f1aa7a3.actors, animname);
}

function function_88c416555bc21541(animname) {
  actor = level.var_1b2599094f1aa7a3.actors[animname];

  if(isarray(actor)) {
    actor = getclosest(level.player.origin, actor);
  }

  return actor;
}

function function_2ca2807712501171() {
  actors = [];

  foreach(value in level.var_1b2599094f1aa7a3.actors) {
    if(isarray(value)) {
      actors = array_combine(actors, value);
      continue;
    }

    actors[actors.size] = value;
  }

  return actors;
}

function function_88e8f81ba53c8399(name) {
  name = tolower(name);
  assert(!function_937c5de25d5682b(), "Cannot run more than one node at a time");
  assert(array_contains_key(level.var_1b2599094f1aa7a3.nodes, name), "Dialogue node with name " + name + " does not exist");
  level.var_1b2599094f1aa7a3.current_node = level.var_1b2599094f1aa7a3.nodes[name];
}

function function_6b2794be53922d6e() {
  if(scripts\sp\dialogue_wheel::function_ffdce2654ea23d5a()) {
    scripts\sp\dialogue_wheel::function_6f846e9519b4cff2();
  }

  if(isDefined(level.var_1b2599094f1aa7a3.current_node)) {
    level.var_1b2599094f1aa7a3.aborted = 1;
    level.var_1b2599094f1aa7a3.current_node = undefined;
  }

  level notify("dialogue_abort");
}

function function_937c5de25d5682b() {
  return isDefined(level.var_1b2599094f1aa7a3.current_node);
}

function function_44768f37b1a9f788(leader, startnode) {
  scene = spawnStruct();
  scene.leader = leader;
  scene.var_f087ac9bee88f3df = startnode;
  scene.started = 0;
  scene.running = 0;
  scene.var_37563fdbbec9d7ee = 0;
  scene.timedout = 0;
  return scene;
}

function function_e0b639a16bf31bcf(name, params) {
  node = spawnStruct();
  name = tolower(name);
  node.name = name;
  node.visited = 0;
  node.completed = 0;
  node.owner = level;
  node.resetoptions = 0;
  node.responserequired = 1;

  if(isfunction(params)) {
    node.func = params;
  }

  if(isarray(params)) {
    foreach(value in params) {
      switch (key) {
        case #"hash_cd4f17d4aa69e985":
          node.options = value;
          break;
        case #"hash_e702ff190f9ffed5":
          node.results = value;
          break;
        case #"hash_6b1ba289ab27fab4":
          node.owner = value;
          break;
        case #"hash_847455c830e9351e":
          node.resetoptions = value;
          break;
        case #"hash_ada48ad47876cc77":
          node.responserequired = value;
          break;
        case #"hash_d529bbd00a46c374":
          node.timeoutnode = value;
          break;
        default:
          break;
      }
    }
  }

  level.var_1b2599094f1aa7a3.nodes[name] = node;
}

function function_bda26c6b3a7d395a(owner, options, results, resetoptions, responserequired, timeoutnode) {
  params = [];

  if(isDefined(owner)) {
    params["owner"] = owner;
  }

  if(isDefined(options)) {
    params["options"] = options;
  }

  if(isDefined(results)) {
    params["results"] = results;
  }

  if(isDefined(resetoptions)) {
    params["resetOptions"] = resetoptions;
  }

  if(isDefined(responserequired)) {
    params["responseRequired"] = responserequired;
  }

  if(isDefined(timeoutnode)) {
    params["timeoutNode"] = timeoutnode;
  }

  return params;
}

function function_8c75a86890a649dc(name) {
  name = tolower(name);
  return level.var_1b2599094f1aa7a3.nodes[name];
}

function function_bd86a7339819b9a4(name) {
  name = tolower(name);
  assert(array_contains_key(level.var_1b2599094f1aa7a3.nodes, name), "Dialogue node with name " + name + " does not exist");
  node = level.var_1b2599094f1aa7a3.nodes[name];
  node.owner = self;
}

function function_cbd09ef58f58efef(name) {
  node = function_8c75a86890a649dc(name);
  return node.owner == self;
}

function function_d22210db2062c3ba(name) {
  name = tolower(name);
  return level.var_1b2599094f1aa7a3.nodes[name].visited;
}

function function_55f69519f0c8adb9(name) {
  name = tolower(name);
  return level.var_1b2599094f1aa7a3.nodes[name].completed;
}

function function_4e65800aa9026a50(name) {
  name = tolower(name);
  return isDefined(level.var_1b2599094f1aa7a3.nodes[name]);
}

function function_bf2b4156c2ad2ece(message) {
  if(!flag_exist(message)) {
    flag_init(message);
  }

  return flag(message);
}

function function_b4fd13a02335dcd6(message) {
  if(!flag_exist(message)) {
    flag_init(message);
  }

  flag_set(message);
}

function function_c3b8ade88249f5ff(message) {
  if(!flag_exist(message)) {
    flag_init(message);
    return;
  }

  flag_clear(message);
}

function function_ac9f4287e5e75c03(message) {
  if(!ent_flag_exist(message)) {
    ent_flag_init(message);
  }

  return ent_flag(message);
}

function function_670bf3283b391e01(message) {
  if(!ent_flag_exist(message)) {
    ent_flag_init(message);
  }

  ent_flag_set(message);
}

function function_aac7cc330b31b0ec(message) {
  if(!ent_flag_exist(message)) {
    ent_flag_init(message);
    return;
  }

  ent_flag_clear(message);
}