/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_19b3e06c555316d7.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_3c5077a8847a5d9e;
#using script_78ee1f1787a2e6a4;
#using scripts\anim\squadmanager;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace namespace_cca5aad993a641fe;

function function_90d3f7b0c040f569(targetname) {
  spawnstructs = getStructArray(targetname, "targetname");

  if(!isDefined(spawnstructs) || spawnstructs.size == 0) {
    return;
  }

  var_17a4bf9cbc1b315e = [];

  foreach(spawner in spawnstructs) {
    spawned = spawner function_bf9eb3e39aa854d();
    var_17a4bf9cbc1b315e[var_17a4bf9cbc1b315e.size] = spawned;
  }

  return var_17a4bf9cbc1b315e;
}

function function_633165d9faaae73b() {
  if(!istrue(level.var_61198536443ad7ec)) {
    function_f982e82bbd03d707();
  }
}

function function_f1543fa991abb308(spawners, forcespawn) {
  function_633165d9faaae73b();
  guys = [];

  foreach(spawner in spawners) {
    if(isspawner(spawner)) {
      spawner.count = 1;
    }

    guy = spawner function_bf9eb3e39aa854d(forcespawn);

    if(isstruct(spawner)) {
      assertex(isalive(guy), "Guy at " + spawner.origin + " failed to spawn.");
    } else {
      assertex(isalive(guy), "Guy with export " + spawner.export+" failed to spawn.");
    }

    guys[guys.size] = guy;
  }

  assertex(guys.size == spawners.size, "Didnt spawn correct number of guys");
  return guys;
}

function function_3bc156ea86eac9e2(forcespawn) {
  function_633165d9faaae73b();
  return function_bf9eb3e39aa854d();
}

function function_bf9eb3e39aa854d(forcespawn) {
  ai_types = scripts\cp\spawning::get_aitypes_from_spawner();
  var_1bbe1e86bf2144d6 = random(ai_types);
  aitype = level.aitypes[var_1bbe1e86bf2144d6].agent_type;
  var_44c998e27e126507 = scripts\mp\mp_agent::spawnnewagentaitype(aitype, self.origin, self.angles);

  if(!isDefined(var_44c998e27e126507)) {
    return undefined;
  }

  thread namespace_1170726b2799ea65::function_4576aecf9d0c4082(var_44c998e27e126507);
  var_44c998e27e126507 ai::spawner_fields(self);
  var_44c998e27e126507 scripts\cp\spawning::function_bcd664c7997b7469(self);

  if(!var_44c998e27e126507 is_specified_unittype("civilian")) {
    var_44c998e27e126507 thread scripts\anim\squadmanager::addtosquad();
  }

  self.aitype = aitype;
  var_44c998e27e126507 scripts\cp\spawning::function_1329b355d73712f(undefined, self);
  var_44c998e27e126507 scripts\cp\spawning::function_389fff85c076f49e();

  if(isDefined(var_44c998e27e126507.target) && !isDefined(var_44c998e27e126507.script_moveoverride)) {
    node = scripts\cp\spawning::get_next_node_array();
    var_44c998e27e126507 thread scripts\cp\spawning::go_to_node(node);
  }

  tier = "tier1";
  aitype = var_44c998e27e126507 function_2ee1dc768d1a4703(self);

  if(issubstr(aitype, "_t1_") || issubstr(aitype, "_tier1_")) {
    scripts\cp_mp\agents\agent_utils::overridetier1(var_44c998e27e126507);
  } else if(issubstr(aitype, "_t2_") || issubstr(aitype, "_tier2_")) {
    tier = "tier2";
    scripts\cp_mp\agents\agent_utils::overridetier2(var_44c998e27e126507);
  } else if(issubstr(aitype, "_t3_") || issubstr(aitype, "_tier3_")) {
    tier = "tier3";
    scripts\cp_mp\agents\agent_utils::overridetier3(var_44c998e27e126507);
  }

  if(isDefined(self.spawn_funcs)) {
    var_44c998e27e126507.spawn_funcs = self.spawn_funcs;
  }

  var_44c998e27e126507 thread function_b742d2da5a20db26();
  return var_44c998e27e126507;
}

function function_318fc8ecd4d8e798(team, function, param1, param2, param3) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }

  if(!isDefined(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = [];
  }

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

function function_6933179df6aa483e(spawners, function, param1, param2, param3, param4, param5) {
  foreach(spawner in spawners) {
    spawner function_5563625b36395600(function, param1, param2, param3, param4, param5);
  }
}

function function_5563625b36395600(function, param1, param2, param3, param4, param5) {
  assertex(!isalive(self), "Tried to add_spawn_function to a living guy.");
  assertex(isspawner(self) || isstruct(self), "Tried to add_spawn_function to something that isn't a spawner.");

  if(!isDefined(self.spawn_funcs)) {
    self.spawn_funcs = [];
  }

  foreach(func_array in self.spawn_funcs) {
    if(func_array["function"] == function) {
      return;
    }
  }

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func["param5"] = param5;
  self.spawn_funcs[self.spawn_funcs.size] = func;
}

function function_b742d2da5a20db26() {
  team = self.team;

  if(isDefined(team)) {
    if(!isDefined(level.spawn_funcs)) {
      level.spawn_funcs = [];
    }

    if(!isDefined(level.spawn_funcs[team])) {
      level.spawn_funcs[team] = [];
    }

    for(i = 0; i < level.spawn_funcs[team].size; i++) {
      func = level.spawn_funcs[team][i];

      if(isDefined(func["param5"])) {
        thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
        continue;
      }

      if(isDefined(func["param4"])) {
        thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
        continue;
      }

      if(isDefined(func["param3"])) {
        thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
        continue;
      }

      if(isDefined(func["param2"])) {
        thread[[func["function"]]](func["param1"], func["param2"]);
        continue;
      }

      if(isDefined(func["param1"])) {
        thread[[func["function"]]](func["param1"]);
        continue;
      }

      thread[[func["function"]]]();
    }
  }

  if(!isDefined(self.spawn_funcs)) {
    if(!isDefined(self.script_suspend)) {
      self.spawner = undefined;
    }

    return;
  }

  for(i = 0; i < self.spawn_funcs.size; i++) {
    func = self.spawn_funcs[i];

    if(isDefined(func["param5"])) {
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
      continue;
    }

    if(isDefined(func["param4"])) {
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
      continue;
    }

    if(isDefined(func["param3"])) {
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
      continue;
    }

    if(isDefined(func["param2"])) {
      thread[[func["function"]]](func["param1"], func["param2"]);
      continue;
    }

    if(isDefined(func["param1"])) {
      thread[[func["function"]]](func["param1"]);
      continue;
    }

    thread[[func["function"]]]();
  }

  self.saved_spawn_functions = self.spawn_funcs;

  self.spawn_funcs = undefined;

  self.spawn_funcs = self.saved_spawn_functions;
  self.saved_spawn_functions = undefined;

  if(!isDefined(self.script_suspend)) {
    self.spawner = undefined;
  }
}

function function_72f87f6619b5a684(trigname) {
  self endon("stop_color_movement");
  self.goalheight = 90;

  for(var_4c0a5d9582876bb6 = undefined; true; var_4c0a5d9582876bb6 = var_a4427908e4d0e21f) {
    wait 0.5;
    namespace_897c361e01268820::function_d14fcd3a04720601(trigname);
    var_a4427908e4d0e21f = level.color_trig;

    if(!isDefined(var_4c0a5d9582876bb6) || var_4c0a5d9582876bb6 != var_a4427908e4d0e21f) {
      nodes = getnodearray(var_a4427908e4d0e21f.target, "targetname");
      assertex(isDefined(nodes), "Color trigger missing nodes");
      thread scripts\cp\spawning::go_to_node(nodes);

      if(isDefined(var_a4427908e4d0e21f.script_noteworthy) && var_a4427908e4d0e21f.script_noteworthy == "final_color_trigger") {
        self notify("stop_color_movement");
      }

      var_a4427908e4d0e21f thread function_b3df6ca6547fc27f();
    }
  }
}

function function_b3df6ca6547fc27f() {
  self triggerdisable();
  wait 10;

  if(!isDefined(self)) {
    return;
  }

  self triggerenable();
}