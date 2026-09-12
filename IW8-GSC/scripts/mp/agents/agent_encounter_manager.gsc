/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_encounter_manager.gsc
*********************************************************/

function init() {
  level.ai_encounter_manager = spawnStruct();
  level.ai_encounter_manager.encounters = [];
  level.ai_encounter_manager.next_encounter_id = 0;
  level.ai_encounter_manager.used_agents = 0;
  level.ai_encounter_manager.agent_classes = [];
  init_dvars();
  init_defaults();
}

function init_dvars() {
  level.ai_encounter_manager.max_agents = getdvarint("scr_default_maxagents", 48);
}

function can_request_num_agents(var_0) {
  return var_0 <= level.ai_encounter_manager.max_agents - level.ai_encounter_manager.used_agents;
}

function end_encounter_by_id(var_0) {
  var_1 = level.ai_encounter_manager.encounters[var_0];

  if(isDefined(var_1)) {
    end_encounter(var_1);
    return;
  }
}

function init_defaults() {
  _handlevehiclerepair::init();
  var_0 = [];
  GscBinSkip0(0x2e, "nothing", 1);
}

function get_agent_class_by_name(var_0) {
  if(!isDefined(var_0) || !isDefined(level.ai_encounter_manager.agent_classes[var_0])) {
    var_0 = "default";
  }

  return level.ai_encounter_manager.agent_classes[var_0];
}

function make_spawn_params_list(var_0, var_1) {
  if(!isDefined(var_0) || var_0.size <= 0) {
    return level.ai_encounter_manager.default_spawn_params;
  }

  var_2 = spawnStruct();
  var_2.spawn_type = "list";
  var_2.spawn_points = var_0;
  var_2.use_parachute = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0);
  return var_2;
}

function make_spawn_params_radius(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.spawn_type = "radius";
  var_3.min_radius = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 100);
  var_3.max_radius = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 2500);
  var_3.use_parachute = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  return var_3;
}

function init_encounter_params_swarm(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "swarm";
  var_4.requested_agents = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  var_4.total_agents = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 9999);
  var_4.class = get_agent_class_by_name(var_2);
  var_4.spawn_params = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.ai_encounter_manager.default_spawn_params);
  return var_4;
}

function init_encounter_params_waves(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.type = "waves";
  var_2.waves = var_0;
  var_2.requested_agents = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1);
  var_2.spawn_params = level.ai_encounter_manager.default_spawn_params;
  return var_2;
}

function make_wave(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.num_agents = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  var_4.remaining_threshold = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0);
  var_4.spawn_params = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.ai_encounter_manager.default_spawn_params);
  var_4.class = get_agent_class_by_name(var_2);
  return var_4;
}

function register_agent_class(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    var_5 = spawnStruct();
    var_5.type = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "actor_enemy_lw_br");
    var_5.ref_1404D = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
    var_5.loot_table_key = scripts\engine\utility::ter_op(isDefined(var_3), var_3, "agent_encounter_manager_default");
    var_5.loot_drop_count = scripts\engine\utility::ter_op(isDefined(var_4), var_4, 1);
    level.ai_encounter_manager.agent_classes[var_0] = var_5;
    return;
  }
}

function start_encounter(var_0, var_1) {
  if(!validate_new_encounter(var_1)) {
    return undefined;
  }

  var_2 = spawnStruct();
  var_2.id = level.ai_encounter_manager.next_encounter_id;
  var_2.agents = [];
  var_2.params = var_1;
  var_2.origin = var_0;
  var_2.max_agents = var_1.requested_agents;
  var_2.num_spawned = 0;
  var_2.num_killed = 0;
  level.ai_encounter_manager.next_encounter_id++;
  level.ai_encounter_manager.used_agents += var_1.requested_agents;

  if(!isDefined(var_1.type)) {
    var_1.type = "swarm";
  }

  switch (var_1.type) {
    case "waves":
      thread wave_encounter_think();
      break;
    case "swarm":
      thread swarm_encounter_think();
      break;
    default:
      break;
  }

  level.ai_encounter_manager.encounters[var_2.id] = var_2;
  return var_2;
}

function validate_new_encounter(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(var_0.requested_agents)) {
    return false;
  }

  if(!can_request_num_agents(var_0.requested_agents)) {
    return false;
  }

  if(!isDefined(var_0.spawn_params)) {
    return false;
  }

  return true;
}

function end_encounter() {
  level.ai_encounter_manager.used_agents -= self.params.requested_agents;

  foreach(var_1 in self.agents) {
    var_1 despawnagent();
  }

  level.ai_encounter_manager.encounters[self.id] = undefined;
  self notify("encounter_end");
}

function wave_encounter_think() {
  level endon("game_ended");
  self endon("encounter_end");
  wave_encounter_set_wave(0);

  for(;;) {
    var_0 = self.initoperatorunlocks;

    while(self.num_spawned < self.num_total) {
      if(self.agents.size >= self.max_agents || scripts\mp\mp_agent::getfreeagentcount() <= 0) {
        break;
      }

      var_1 = rear_door_collision(var_0.spawn_params);

      if(isDefined(var_1)) {
        spawn_agent(var_1[0], var_1[1], var_0.class, var_0.spawn_params.use_parachute);
      }

      waitframe();
    }

    if(self.num_spawned >= self.num_total && self.num_total - self.num_killed <= var_0.remaining_threshold) {
      if(self.wave_index + 1 >= self.params.waves.size) {
        break;
      }

      wave_encounter_set_wave(self.wave_index + 1);
      continue;
    }

    self waittill("agent_death");
    wait 1;
  }

  while(self.agents.size > 0) {
    self waittill("agent_death");
  }

  end_encounter();
}

function wave_encounter_set_wave(var_0) {
  if(var_0 < 0 || var_0 >= self.params.waves.size) {
    return;
  }

  self.wave_index = var_0;
  self.initoperatorunlocks = self.params.waves[var_0];
  self.num_spawned = self.agents.size;
  self.num_total = self.initoperatorunlocks.num_agents + self.agents.size;
  self.num_killed = 0;
}

function swarm_encounter_think() {
  level endon("game_ended");
  self endon("encounter_end");
  self.num_total = self.params.total_agents;

  while(self.num_spawned < self.num_total) {
    if(self.agents.size >= self.max_agents || scripts\mp\mp_agent::getfreeagentcount() <= 0) {
      self waittill("agent_death");
      wait 1;
    }

    var_0 = rear_door_collision();

    if(isDefined(var_0)) {
      spawn_agent(var_0[0], var_0[1], self.params.class, self.params.spawn_params.use_parachute);
    }

    waitframe();
  }

  while(self.num_killed < self.num_total) {
    self waittill("agent_death");
  }

  end_encounter();
}

function spawn_agent(var_0, var_1, var_2, var_3, var_4) {
  if(self.agents.size >= self.max_agents) {
    return undefined;
  }

  if(scripts\mp\mp_agent::getfreeagentcount() <= 0) {
    return undefined;
  }

  if(!isDefined(var_4)) {
    var_4 = "team_two_hundred";
  }

  var_5 = undefined;

  if(var_3 && isDefined(level.fnbrsoldierparachutespawn)) {
    var_5 = _testing_ending::spawnnewparachuteagent(var_0, var_1, var_2.ref_1404D, var_2.type, var_4);
  } else {
    var_5 = _testing_ending::spawnnewagent(var_0, var_1, var_2.ref_1404D, var_2.type, var_4);
  }

  if(isDefined(var_5)) {}

  var_5.class = var_2;
  var_5.isinlaststand = &handle_agent_death_info;
  self.num_spawned++;
  self.agents[self.agents.size] = var_5;
  thread watch_agent_death(var_5);
  return var_5;
}

function rear_door_collision(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.params.spawn_params;
  }

  var_1 = undefined;

  switch (var_0.spawn_type) {
    case "radius":
      var_1 = get_spawn_point_radius(var_0);
      break;
    case "list":
      var_1 = get_spawn_point_from_list(var_0);
      break;
    default:
      break;
  }

  return var_1;
}

function get_spawn_point_radius(var_0) {
  var_1 = randomfloatrange(0, 360);
  var_2 = anglesToForward((0, var_1, 0));
  var_3 = randomfloatrange(var_0.min_radius, var_0.max_radius);
  var_4 = self.origin + var_2 * var_3;
  var_4 = getclosestpointonnavmesh(var_4);
  return [var_4, (0, randomfloatrange(0, 360), 0)];
}

function get_spawn_point_from_list(var_0) {
  var_1 = randomintrange(0, var_0.spawn_points.size);
  return var_0.spawn_ponts[var_1];
}

function inrease_ai_budget_by(var_0) {
  self.max_agents += var_0;
  self notify("agent_death");
}

function watch_agent_death(var_0) {
  level endon("game_ended");
  self endon("encounter_end");
  var_0 waittill("death");
  self.agents = scripts\engine\utility::array_remove(self.agents, var_0);
  self.num_killed++;
  self notify("agent_death");
}

function handle_agent_death_info(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, "eAttacker", var_0.eattacker);
}