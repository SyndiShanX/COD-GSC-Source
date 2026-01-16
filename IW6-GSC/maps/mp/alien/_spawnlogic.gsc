/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_spawnlogic.gsc
*****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_utility;

CONST_DEFAULT_PREGAME_DELAY = 5;
CONST_DEFAULT_MAX_CYCLE_INTERMISSION = 150;
CONST_DEFAULT_MIN_CYCLE_INTERMISSION = 90;
CONST_DEFAULT_WAVE_INTERMISSION = 7;
CONST_WAVE_END_WITH_ALIEN_NUM = 1;
CONST_MAX_LURKER_COUNT = 12;
CONST_MIN_LURKER_COUNT = 8;

spawnAlien(origin, angles, alien_type) {
  return maps\mp\gametypes\aliens::addAlienAgent("axis", origin, angles, alien_type);
}

alien_health_per_player_init() {
  level.alien_health_per_player_scalar = [];
  level.alien_health_per_player_scalar[1] = 0.9;
  level.alien_health_per_player_scalar[2] = 1.0;
  level.alien_health_per_player_scalar[3] = 1.3;
  level.alien_health_per_player_scalar[4] = 1.8;
}

alien_wave_init() {
  level.use_spawn_director = 1;

  if(use_spawn_director()) {
    maps\mp\alien\_spawn_director::init();
  }

  wave_spawners_init();
}

escape_choke_init() {
  level.choke_trigs = [];

  level.choke_trigs[0] = GetEnt("choke_trig_0", "targetname");
  level.choke_trigs[1] = GetEnt("choke_trig_1", "targetname");
  level.choke_trigs[2] = GetEnt("choke_trig_2", "targetname");
  level.choke_trigs[3] = GetEnt("choke_trig_3", "targetname");

  if(!isDefined(level.choke_trigs) || !level.choke_trigs.size) {
    return;
  }
  foreach(trig in level.choke_trigs) {
    assert(isDefined(trig.target));

    choke_point = getstruct(trig.target, "targetname");
    assert(isDefined(choke_point));

    spit_at_struct = getstruct(choke_point.target, "targetname");
    assert(isDefined(spit_at_struct));

    trig.choke_loc = choke_point.origin;
    trig.spit_at_struct = spit_at_struct;
  }

  level thread monitor_trig_activation();
}

monitor_trig_activation() {
  level endon("game_ended");

  if(!flag_exist("nuke_countdown")) {
    return;
  }
  level.latest_choke_trig_active = level.choke_trigs[0];

  level.escape_spitter_target_node = level.choke_trigs[0].spit_at_struct;
  if(!isDefined(level.escape_spitter_target_node.angles))
    level.escape_spitter_target_node.angles = (0, 0, 0);

  if(!flag("nuke_countdown"))
    flag_wait("nuke_countdown");

  update_extraction_waypoint_location(level.latest_choke_trig_active get_choke_trig_id());

  while(1) {
    foreach(player in level.players) {
      foreach(trig in level.choke_trigs) {
        if(isAlive(player) && player IsTouching(trig) && player.sessionstate == "playing") {
          trig_id_num = trig get_choke_trig_id();
          latest_trig_id_num = level.latest_choke_trig_active get_choke_trig_id();

          if(trig_id_num > latest_trig_id_num) {
            level.latest_choke_trig_active = trig;

            update_extraction_waypoint_location(trig get_choke_trig_id());

            level.escape_spitter_target_node = trig.spit_at_struct;
            if(!isDefined(level.escape_spitter_target_node.angles))
              level.escape_spitter_target_node.angles = (0, 0, 0);

            thread escape_spawn_special_minion_wave(6);
          }
        }
      }
    }

    wait 1;
  }
}

update_extraction_waypoint_location(trig_idx) {
  assert(isDefined(trig_idx));

  if(!isDefined(level.rescue_waypoint)) {
    return;
  }
  level.rescue_waypoint.alpha = 1;

  if(!isDefined(level.rescue_waypoint_locs) || !isDefined(level.rescue_waypoint_locs[trig_idx])) {
    return;
  }
  level.rescue_waypoint.x = level.rescue_waypoint_locs[trig_idx][0];
  level.rescue_waypoint.y = level.rescue_waypoint_locs[trig_idx][1];
  level.rescue_waypoint.z = level.rescue_waypoint_locs[trig_idx][2];
}

escape_spawn_special_minion_wave(delay) {
  level endon("game_ended");
  level endon("nuke_went_off");

  level notify("escape_spawn_special_minion_wave");
  level endon("escape_spawn_special_minion_wave");

  wait delay;

  notify_msg = "chaos_event_1";
  level notify(notify_msg);

  maps\mp\alien\_spawn_director::activate_spawn_event(notify_msg);

  if(GetDvarInt("alien_debug_escape") > 0)
    IPrintLnBold("^0[MINION METEOR][^7TRIGGERED^0]");
}

get_choke_trig_id() {
  return int(StrTok(self.targetname, "_")[2]);
}

alien_scene_init() {
  level.scene_trigs = getEntArray("scene_trig", "targetname");

  foreach(trig in level.scene_trigs)
  trig thread setup_scene();
}

setup_scene() {
  self.scene_spawners = getstructarray(self.target, "targetname");

  foreach(spawner in self.scene_spawners) {
    assert(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy != "");
    types = StrTok(spawner.script_noteworthy, " ");
    assert(types.size);
    spawner.types = types;
  }

  self thread run_scene();
}

run_scene() {
  level endon("game_ended");
  self endon("death");

  while(1) {
    self waittill("trigger", player);

    if(!isplayer(player)) {
      wait 0.05;
      continue;
    }

    spawners = array_randomize(self.scene_spawners);
    for(i = 0; i < spawners.size; i++) {
      if(i > 0) {
        if(randomint(100) >= 50)
          continue;
      }

      spawner = spawners[i];
      self thread spawn_scene_alien(spawner);
    }
    return;
  }
}

spawn_scene_alien(spawner) {
  if(isDefined(spawner.script_delay))
    wait spawner.script_delay;

  alien_type = "scene " + spawner.types[randomintrange(0, spawner.types.size)];

  spawn_angles = spawner.angles;
  if(!isDefined(spawn_angles))
    spawn_angles = (0, 270, 0);

  alien = spawnAlien(spawner.origin, spawn_angles, alien_type);
  alien.spawner = spawner;
}

alien_scene_behavior() {
  self endon("death");
  self endon("run_to_death");

  self maps\mp\agents\alien\_alien_think::set_alien_movemode("run");

  old_rate = self.moveplaybackrate;
  self.scene_moveplaybackrate = old_rate * 1.25;

  self set_ignore_enemy();

  self thread alien_ai_debug_print("acting");

  self thread wakeup_to_player_damage();
  self thread wakeup_to_player_distance(256);
  self thread scene_loop();

  self waittill("woke");
  self.scene = undefined;

  self.moveplaybackrate = old_rate;

  self clear_ignore_enemy();
  self ScrAgentSetScripted(false);

  if(self get_alien_type() == "elite") {
    level thread maps\mp\alien\_music_and_dialog::handleFirstEliteArrival(self);
  }

  self thread alien_ai_debug_print("attacking");

  wait 1;
}

scene_loop() {
  self endon("woke");
  self endon("death");
  self endon("run_to_death");

  wait 1;

  self maps\mp\agents\alien\_alien_think::set_alien_movemode("run");

  nodes = getstructarray(self.spawner.target, "targetname");
  assert(isDefined(nodes));
  cur_node = nodes[RandomIntRange(0, nodes.size)];

  while(isDefined(cur_node)) {
    self ScrAgentSetGoalPos(cur_node.origin);
    self ScrAgentSetGoalRadius(32);

    self waittill("goal_reached");

    if(isDefined(cur_node.script_noteworthy)) {
      wait 0.5;

      script_key = StrTok(cur_node.script_noteworthy, " ");

      if(script_key[0] == "delete") {
        self suicide();
        return;
      }

      player = level.players[RandomIntRange(0, level.players.size)];
      self maps\mp\agents\alien\_alien_anim_utils::turnTowardsEntity(player);

      anim_num = 1;
      if(script_key.size == 2 && int(script_key[1]) > 1)
        anim_num = int(script_key[1]);

      if(script_key[0] == "posture") {
        for(i = 0; i < anim_num; i++) {
          self ScrAgentSetScripted(true);
          self set_alien_emissive(0.2, 1);
          self ScrAgentSetOrientMode("face angle abs", self.angles);
          self maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack("posture", "posture", "end");
          self set_alien_emissive_default(0.2);
          self ScrAgentSetScripted(false);

          self ScrAgentSetGoalPos(self.origin);
          wait RandomFloatRange(0.25, 0.75);
        }

        self.moveplaybackrate = self.scene_moveplaybackrate;
      }

      if(script_key[0] == "ground_slam") {
        for(i = 0; i < anim_num; i++) {
          self ScrAgentSetScripted(true);
          self set_alien_emissive(0.2, 1);
          self ScrAgentSetOrientMode("face angle abs", self.angles);
          self maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack("attack_melee_swipe", "attack_melee", "end");
          self set_alien_emissive_default(0.2);
          self ScrAgentSetScripted(false);

          self ScrAgentSetGoalPos(self.origin);
          wait RandomFloatRange(0.5, 1.0);
        }

        self.moveplaybackrate = self.scene_moveplaybackrate;
      }
    }

    nodes = getstructarray(cur_node.target, "targetname");
    if(!isDefined(nodes))
      return;
    cur_node = nodes[RandomIntRange(0, nodes.size)];
  }
}

alien_lurker_init() {
  if(!alien_mode_has("lurker")) {
    return;
  }
  flag_init("lurker_active");

  thread init_patrol_paths();

  spawn_locs = getstructarray("alien_spawn_struct", "targetname");

  level.alien_lurkers = [];
  level.max_lurker_population = 18;

  foreach(key_string, type in level.alien_types) {
    alien_lurker_struct = spawnStruct();
    alien_lurker_struct.spawn_locs = [];

    level.alien_lurkers[key_string] = alien_lurker_struct;
  }

  foreach(spawn_loc in spawn_locs) {
    msg_prefix = "Spawn location at: " + spawn_loc.origin + " ";

    if(isDefined(spawn_loc.script_noteworthy) && spawn_loc.script_noteworthy != "") {
      spawn_types = strtok(spawn_loc.script_noteworthy, " ");

      if(!IsSubStr(spawn_loc.script_noteworthy, "lurker"))
        continue;
      else
        spawn_types = array_remove(spawn_types, spawn_types[0]);

      spawn_loc.spawn_trigger = getent(spawn_loc.target, "targetname");
      assert(isDefined(spawn_loc.spawn_trigger));

      assertex(spawn_types.size > 0, msg_prefix + "does not have enough spawn types");

      foreach(type in spawn_types) {
        if(isDefined(level.alien_lurkers[type])) {
          level.alien_lurkers[type].spawn_locs[level.alien_lurkers[type].spawn_locs.size] = spawn_loc;
        } else {
          assertex(true, msg_prefix + "has unknown spawn type: " + type);
        }
      }
    } else if(!use_spawn_director()) {
      assertex(false, msg_prefix + "is missing spawner type (script_noteworthy = brute cloaker spitter)");
    }
  }

  level notify("alien_lurkers_spawn_initialized");

  /#	
  if(!alien_mode_has("nogame"))
    thread lurker_loop();
}

init_patrol_paths() {
  level.patrol_start_nodes = Getstructarray("patrol_start_node", "targetname");
}

wave_spawners_init() {
  level.alien_wave = [];

  foreach(key_string, type in level.alien_types) {
    alien_wave_struct = spawnStruct();
    alien_wave_struct.spawn_locs = [];

    level.alien_wave[key_string] = alien_wave_struct;
  }

  alien_spawn_locs = getstructarray("alien_spawn_struct", "targetname");
  assertex(isDefined(alien_spawn_locs) && alien_spawn_locs.size > 0, "Not enough spawn locations (alien_spawn_struct)");

  foreach(spawn_loc in alien_spawn_locs) {
    msg_prefix = "Spawn location at: " + spawn_loc.origin + " ";

    if(isDefined(spawn_loc.script_noteworthy) && spawn_loc.script_noteworthy != "") {
      spawn_types = strtok(spawn_loc.script_noteworthy, " ");

      if(IsSubStr(spawn_loc.script_noteworthy, "lurker")) {
        continue;
      }
      assertex(spawn_types.size > 0, msg_prefix + "does not have enough spawn types");

      foreach(type in spawn_types) {
        if(isDefined(level.alien_wave[type]))
          level.alien_wave[type].spawn_locs[level.alien_wave[type].spawn_locs.size] = spawn_loc;
        else
          assertex(true, msg_prefix + "has unknown spawn type: " + type);
      }
    } else if(!use_spawn_director()) {
      assertex(false, msg_prefix + "is missing spawner type (script_noteworthy = brute cloaker spitter)");
    }
  }

  level notify("alien_wave_spawn_initialized");
}

assign_alien_attributes(alien_type) {
  self endon("death");

  spawn_type = "none";

  spawn_type_config = strtok(alien_type, " ");
  if(isDefined(spawn_type_config) && spawn_type_config.size == 2) {
    if(spawn_type_config[0] == "lurker")
      spawn_type = "lurker";

    if(spawn_type_config[0] == "wave")
      spawn_type = "wave";

    if(spawn_type_config[0] == "scene")
      spawn_type = "scene";

    alien_type = spawn_type_config[1];
  }

  assertex(spawn_type != "none", "spawn type defined does not exist - none");
  assertex(isDefined(level.alien_types), "Must run _alien::main() before _spawner::wave_spawners_init()");

  if(isDefined(level.players) && level.players.size > 0) {
    health = level.alien_types[alien_type].attributes["health"] * level.alien_health_per_player_scalar[level.players.size];
  } else {
    health = level.alien_types[alien_type].attributes["health"];
  }

  health = int(level.cycle_health_scalar * health);

  self maps\mp\agents\_agent_common::set_agent_health(health);
  self.max_health = health;
  self.alien_type = level.alien_types[alien_type].attributes["ref"];

  self.moveplaybackrate = level.alien_types[alien_type].attributes["speed"] * RandomFloatRange(0.95, 1.05);

  if(flag_exist("hives_cleared") && flag("hives_cleared"))
    self.moveplaybackrate *= 1.25;

  self.defaultmoveplaybackrate = self.moveplaybackrate;

  self.animplaybackrate = self.moveplaybackrate;
  self.xyanimscale = level.alien_types[alien_type].attributes["scale"];
  self.hindlegstraceoffset = -37.0 * self.xyanimscale;
  self.defaultEmissive = level.alien_types[alien_type].attributes["emissive_default"];
  self.maxEmissive = level.alien_types[alien_type].attributes["emissive_max"];
  self thread set_initial_emissive();
  self ScrAgentSetViewHeight(level.alien_types[alien_type].attributes["view_height"]);

  if(spawn_type == "lurker") {
    self thread alien_lurker_behavior();
    self.lurker = true;
  }

  if(spawn_type == "scene") {
    self thread alien_scene_behavior();
    self.scene = true;
  }

  if(spawn_type == "wave") {
    self thread alien_wave_behavior();
    self.wave_spawned = true;
  }

  if(level.alien_types[alien_type].attributes["behavior_cloak"] == 1) {
    self thread maps\mp\alien\_director::alien_cloak();
  }
}

set_initial_emissive() {
  self endon("death");
  wait 1;
  set_alien_emissive_default(0.2);
}

add_fire_fx() {
  self maps\mp\alien\_alien_fx::alien_fire_on();
}

stop_fire_fx() {
  self maps\mp\alien\_alien_fx::alien_fire_off();
}

remaining_alien_management() {
  aliens = GetActiveAgentsOfType("alien");
  foreach(alien in aliens) {
    if(!isalive(alien)) {
      continue;
    }
    if(isDefined(alien.from_previous_hive)) {
      alien suicide();
    } else {
      alien.from_previous_hive = true;
    }

    if(!isDefined(alien.alien_type) || alien.alien_type == "elite") {
      continue;
    }
    if(alien.health < 80) {
      continue;
    }
    hp_remove_factor = 0.5;
    hp_remove = int(hp_remove_factor * alien.health);
    alien.health -= hp_remove;

    wait 0.05;
  }
}

get_blocker_hive(hive_id) {
  foreach(hive_loc in level.stronghold_hive_locs) {
    if(isDefined(hive_loc.target) && hive_loc.target == hive_id)
      return hive_loc;
  }

  return undefined;
}

make_spitter_attack_chopper(attack) {
  if(attack)
    group = "spitters";
  else
    group = "other_aliens";

  if(ThreatBiasGroupExists(group) && self GetThreatBiasGroup() != group)
    self SetThreatBiasGroup(group);

  if(isDefined(level.hive_heli) && attack) {
    if(!isDefined(self.favoriteenemy) || self.favoriteenemy != level.hive_heli)
      self.favoriteenemy = level.hive_heli;
  }
}

escape_spawning(cycle_count) {
  foreach(player in level.players)
  player.threatbias = 100000;

  maps\mp\alien\_spawn_director::start_cycle(cycle_count);

  level thread clean_up_lagged_aliens();

  level waittill_any("game_ended", "nuke_went_off");

  maps\mp\alien\_spawn_director::end_cycle();

  if(flag_exist("nuke_went_off") && flag("nuke_went_off"))
    level waittill_any_timeout(10, "game_ended");
  else
    wait 7;

  foreach(agent in level.agentArray) {
    if(isalive(agent) && isDefined(agent.isActive) && agent.isActive) {
      agent Suicide();

      wait 0.1;
    }
  }
}

CONST_TIME_UNSEEN_RESET = 2;
CONST_TIME_ALIVE_RESET = 10;
CONST_LAGGED_RADIUS = 1000;

clean_up_lagged_aliens() {
  level endon("nuke_went_off");
  level endon("game_ended");

  level notify("clean_up_lagged_aliens");
  level endon("clean_up_lagged_aliens");

  interval = 1;

  while(1) {
    active_aliens = [];
    foreach(agent in level.agentArray) {
      if(!isDefined(agent.isActive) || !agent.isActive) {
        continue;
      }
      active_aliens[active_aliens.size] = agent;
    }

    buffer = 4;
    if(active_aliens.size <= (maps\mp\alien\_spawn_director::get_max_alien_count() - buffer)) {
      wait 1;
      continue;
    }

    foreach(alien in active_aliens) {
      if(!isDefined(alien.last_looked_at)) {
        alien.last_looked_at = gettime();
        alien thread monitor_looked_at();
        continue;
      }

      if(!isDefined(alien.team) || alien.team != "axis") {
        continue;
      }
      alive_time = gettime() - alien.birthtime;
      if(alive_time / 1000 < CONST_TIME_ALIVE_RESET) {
        continue;
      }
      result = false;
      foreach(player in level.players) {
        if(isalive(player) && distance(player.origin, alien.origin) < CONST_LAGGED_RADIUS)
          result = true;
      }
      if(result) {
        continue;
      }
      time_unseen = gettime() - alien.last_looked_at;
      if(time_unseen / 1000 > CONST_TIME_UNSEEN_RESET) {
        if(GetDvarInt("alien_debug_escape") > 0)
          IPrintLnBold("^1[ALIEN CLEANED AT: " + alien.origin + "]");

        alien Suicide();

        break;
      }
    }

    wait interval;
  }
}

monitor_looked_at() {
  self endon("death");

  self notify("monitoring_looked_at");
  self endon("monitoring_looked_at");

  while(1) {
    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      angles = player gettagangles("tag_eye");
      origin = player getEye();
      sight = anglesToForward(angles);
      vec = vectornormalize(self.origin - origin);
      cone = 0.55;

      if(VectorDot(sight, vec) > cone)
        self.last_looked_at = gettime();
    }

    wait 0.25;
  }
}

CONST_TELEPORT_TO_PLAYER_RADIUS = 350;
CONST_TELEPORT_TO_PLAYER_RADIUS_INCREMENT = 250;
CONST_TELEPORT_TO_PLAYER_RADIUS_MAX = 2000;
CONST_PORT_ALINE_TO_LEADER_CHANCE = 66;

port_to_player_loc(alien_type, radius) {
  assertex(isDefined(level.choke_trigs), "There are no choke triggers found in map...");

  if(!isDefined(radius))
    radius = CONST_TELEPORT_TO_PLAYER_RADIUS;

  if(isDefined(alien_type) && alien_type == "minion")
    radius *= 1.2;

  alive_players = [];
  foreach(player in level.players) {
    if(isalive(player))
      alive_players[alive_players.size] = player;
  }

  if(GetDvarInt("alien_debug_escape") > 0 && alive_players.size == 0) {
    IPrintLnBold("DEBUG: No player(s) found alive to teleport alien to");
    return undefined;
  }

  sorted_players = [];

  for(i = level.choke_trigs.size - 1; i >= 0; i--) {
    trig = level.choke_trigs[i];

    occupants = [];
    foreach(player in alive_players) {
      if(player istouching(trig))
        occupants[occupants.size] = player;
    }

    if(occupants.size) {
      occupants = SortByDistance(occupants, trig.choke_loc);
      for(j = 0; j < occupants.size; j++)
        sorted_players[sorted_players.size] = occupants[j];
    }
  }

  if(GetDvarInt("alien_debug_escape") > 0 && alive_players.size == 0) {
    IPrintLnBold("DEBUG: No player(s) found in choke triggers");
    return undefined;
  }

  selected_player = sorted_players[0];
  if(sorted_players.size > 1 && RandomIntRange(0, 100) <= CONST_PORT_ALINE_TO_LEADER_CHANCE)
    selected_player = sorted_players[RandomIntRange(1, sorted_players.size)];

  choke_loc = undefined;
  foreach(trig in level.choke_trigs) {
    if(selected_player istouching(trig)) {
      choke_loc = trig.choke_loc;
      break;
    }
  }

  if(!isDefined(choke_loc)) {
    if(GetDvarInt("alien_debug_escape") > 0)
      IPrintLnBold("Player at: " + selected_player.origin + " is not inside any choke trigger");

    return undefined;
  }

  centering_factor = 3;
  if(alien_type == "spitter" || alien_type == "seeder")
    centering_factor = 4;
  origin_infront_of_player = selected_player.origin + VectorNormalize(choke_loc - selected_player.origin) * radius * centering_factor;
  nodes = GetNodesInRadius(origin_infront_of_player, radius, 0, 1024, "Path");

  if(GetDvarInt("alien_debug_escape") > 0)
    thread debug_circle(origin_infront_of_player, radius, (0, 1, 1), true, 16, 1);

  if(nodes.size == 0) {
    if(radius >= CONST_TELEPORT_TO_PLAYER_RADIUS_MAX) {
      if(GetDvarInt("alien_debug_escape") > 0)
        IPrintLnBold("DEBUG: No spawn node found near player at: " + selected_player.origin + " within 3000 radius");

      return undefined;
    }

    new_radius = radius + CONST_TELEPORT_TO_PLAYER_RADIUS_INCREMENT;

    if(GetDvarInt("alien_debug_escape") > 0)
      IPrintLnBold("DEBUG: No spawn node found near player at: " + selected_player.origin + ", new radius=" + new_radius);

    return port_to_player_loc(alien_type, new_radius);
  }

  selected_node = get_selected_node_for_teleport(nodes, choke_loc, selected_player);

  if(GetDvarInt("alien_debug_escape") > 1) {
    position = "#";
    foreach(index, player in sorted_players) {
      if(player == selected_player)
        position = int(index + 1);
    }

    population = 1;
    foreach(agent in level.agentArray) {
      if(!isDefined(agent.isActive) || !agent.isActive || !isalive(agent)) {
        continue;
      }
      population++;
    }

    if(isDefined(selected_player.name) && isDefined(selected_node) && isDefined(selected_node.origin))
      iprintln("[^3" + alien_type + "^7 ported to ^3" + selected_player.name + "^7 in position ^3" + position + "^7][dist=^3" + int(distance(selected_node.origin, selected_player.origin)) + "^7][alien#=^3" + population + "^7]");
  }

  angles_facing_player = VectorToAngles(selected_player.origin - selected_node.origin);
  return [selected_node.origin, angles_facing_player];
}

port_to_escape_spitter_location() {
  SPITTER_NODE_RADIUS = 512;
  spitterLocation = level.escape_spitter_target_node.origin;

  nodes = GetNodesInRadius(spitterLocation, SPITTER_NODE_RADIUS, 0, 1024, "Path");
  selectedNode = get_selected_node_for_teleport(nodes, spitterLocation, level.escape_spitter_target_node);

  return selectedNode.origin;
}

get_selected_node_for_teleport(nodes, location, selected_target) {
  nodes = SortByDistance(nodes, location);

  selected_node = undefined;
  for(i = 0; i < nodes.size; i++) {
    if(!isDefined(nodes[i].teleport_inuse) || !nodes[i].teleport_inuse) {
      selected_node = nodes[i];
      selected_node.teleport_inuse = true;
      thread reset_teleport_inuse(selected_node);
      break;
    }
  }

  if(!isDefined(selected_node)) {
    if(GetDvarInt("alien_debug_escape") > 0)
      IPrintLnBold("All path nodes near player at: " + selected_target.origin + " are in cooldown for teleport");

    selected_node = nodes[randomint(nodes.size)];
  }

  return selected_node;
}

debug_circle(center, radius, color, depthTest, segments, time) {
  level endon("game_ended");

  if(!isDefined(time))
    time = 0.5;

  if(!isDefined(segments))
    segments = 16;

  angleFrac = 360 / segments;
  circlepoints = [];

  for(i = 0; i < segments; i++) {
    angle = (angleFrac * i);
    xAdd = cos(angle) * radius;
    yAdd = sin(angle) * radius;
    x = center[0] + xAdd;
    y = center[1] + yAdd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  while(time > 0) {
    for(i = 0; i < circlepoints.size; i++) {
      start = circlepoints[i];
      if(i + 1 >= circlepoints.size)
        end = circlepoints[0];
      else
        end = circlepoints[i + 1];

      line(start, end, color, 1.0, depthTest);
    }

    time -= 0.05;
    wait 0.05;
  }

}

reset_teleport_inuse(node) {
  wait 5;
  node.teleport_inuse = undefined;
}

infinite_cycle(cycle_count) {
  maps\mp\alien\_spawn_director::start_cycle(cycle_count);

  level waittill("game_ended");

  maps\mp\alien\_spawn_director::end_cycle();
}

lurker_loop() {
  level endon("game_ended");

  flag_set("lurker_active");

  while(true) {
    ai_event_settings();

    type = "goon";
    foreach(lurker_spawn_struct in level.alien_lurkers[type].spawn_locs) {
      lurker_spawn_struct notify("new_listener");
      lurker_spawn_struct thread lurker_listen_trigger(type);
    }

    level waittill("alien_cycle_prespawning", countdown);

    ahead_of_time = 10;
    wait(max(0, countdown - ahead_of_time));

    flag_clear("lurker_active");

    level notify("removing_lurkers");

    ai_event_settings_reset();

    alive_lurkers = get_alive_lurkers();

    foreach(lurker in alive_lurkers)
    lurker thread send_away_and_die();

    wait 6;

    if(get_alive_lurkers().size > 0) {
      foreach(lurker in get_alive_lurkers())
      lurker Suicide();
    }

    level waittill("alien_cycle_ended");

    flag_set("lurker_active");
  }
}

CONST_LURKER_ALERT_DIST = 512;
CONST_LURKER_GUNSHOT_ALERT_DIST = 512;

ai_event_settings() {
  level.old_ai_eventdistgunshot = GetDvarInt("ai_eventdistgunshot");
  level.old_ai_eventdistgunshotteam = GetDvarInt("ai_eventdistgunshotteam");
  level.old_ai_eventdistnewenemy = GetDvarInt("ai_eventdistnewenemy");
  level.old_ai_eventdistdeath = GetDvarInt("ai_eventdistdeath");

  SetDvar("ai_eventdistgunshot", CONST_LURKER_GUNSHOT_ALERT_DIST);
  SetDvar("ai_eventdistgunshotteam", CONST_LURKER_GUNSHOT_ALERT_DIST);
  SetDvar("ai_eventdistnewenemy", CONST_LURKER_ALERT_DIST);
  SetDvar("ai_eventdistdeath", CONST_LURKER_ALERT_DIST);
}

ai_event_settings_reset() {
  SetDvar("ai_eventdistgunshot", level.old_ai_eventdistgunshot);
  SetDvar("ai_eventdistgunshotteam", level.old_ai_eventdistgunshotteam);
  SetDvar("ai_eventdistnewenemy", level.old_ai_eventdistnewenemy);
  SetDvar("ai_eventdistdeath", level.old_ai_eventdistdeath);
}

remove_farthest_lurker(avoid_ents) {
  lurkers = get_alive_lurkers();

  while(lurkers.size > 1) {
    foreach(avoid_ent in avoid_ents) {
      far_agent = getclosest(avoid_ent.origin, lurkers);
      lurkers = array_remove(lurkers, far_agent);

      if(lurkers.size == 1) {
        break;
      }
    }
  }

  if(!lurkers.size)
    return false;

  lurkers[0] Suicide();
}

get_alive_agents() {
  alive_agents = [];
  foreach(agent in level.agentArray) {
    if(isalive(agent))
      alive_agents[alive_agents.size] = agent;
  }

  return alive_agents;
}

get_alive_enemies() {
  alive_enemies = [];
  alive_non_agents = [];
  alive_agents = get_alive_agents();

  if(isDefined(level.dlc_get_non_agent_enemies))
    alive_non_agents = [
      [level.dlc_get_non_agent_enemies]
    ]();

  alive_enemies = array_combine(alive_agents, alive_non_agents);

  return alive_enemies;
}

get_alive_lurkers() {
  lurkers = [];
  foreach(agent in level.agentArray) {
    if(isalive(agent) && isDefined(agent.lurker))
      lurkers[lurkers.size] = agent;
  }

  return lurkers;
}

CONST_LURKER_RESPAWN_TIME = 10;

lurker_listen_trigger(type) {
  level endon("game_ended");
  level endon("removing_lurkers");

  self endon("new_listener");

  self.cooldown = 0;
  self.spawned_lurker = undefined;
  self.spawn_trigger.reset = false;

  while(true) {
    if(!flag("lurker_active")) {
      flag_wait("lurker_active");
      self.cooldown = 0;
    }

    wait self.cooldown;
    self.cooldown = 0;

    if(isDefined(self.spawned_lurker) && isalive(self.spawned_lurker)) {
      wait 0.05;
      continue;
    }

    if(!self.spawn_trigger.reset)
      self wait_for_reset();

    self.spawn_trigger waittill("trigger", owner);
    self.spawn_trigger.reset = false;

    if(get_alive_agents().size >= get_alive_lurkers().size) {
      while(get_alive_agents().size >= level.max_lurker_population) {
        remove_farthest_lurker(get_players());
        wait 0.1;
      }
    } else {
      while(get_alive_lurkers().size >= level.max_lurker_population) {
        remove_farthest_lurker(get_players());
        wait 0.1;
      }
    }

    self.cooldown = CONST_LURKER_RESPAWN_TIME;

    self.spawned_lurker = self spawn_lurker(type);

    self.spawned_lurker waittill("death");
  }
}

wait_for_reset() {
  level endon("game_ended");
  level endon("removing_lurkers");

  self endon("new_listener");

  is_touching = true;
  while(is_touching) {
    is_touching = false;
    foreach(player in get_players()) {
      if(player IsTouching(self.spawn_trigger))
        is_touching = true;
    }

    if(is_touching)
      wait 0.05;
  }

  self.spawn_trigger.reset = true;
}

send_away_and_die() {
  self endon("death");
  self notify("run_to_death");

  if(isDefined(self.lurker))
    self thread alien_ai_debug_print("Lurker x_X");
  else
    self thread alien_ai_debug_print("x_X");

  self maps\mp\agents\alien\_alien_think::set_alien_movemode("run");
  self set_ignore_enemy();
  self.moveplaybackrate *= 1.25;

  far_nodes = GetNodesInRadiusSorted(self.origin, 1000, 10);

  self ScrAgentSetGoalNode(far_nodes[far_nodes.size - 1]);
  self ScrAgentSetGoalRadius(64);
  self waittill_any_timeout(5, "goal_reached");

  self clear_ignore_enemy();

  smoke_puff();

  wait 0.20;

  self Suicide();

  return true;
}

set_ignore_enemy() {
  self enable_alien_scripted();

  if(isDefined(self.enemy))
    self.enemy.current_attackers = [];
}

clear_ignore_enemy() {
  self disable_alien_scripted();

  foreach(player in get_players())
  self GetEnemyInfo(player);
}

smoke_puff() {
  playFXOnTag(level._effect["alien_teleport"], self, "j_jaw");
  playFXOnTag(level._effect["alien_teleport"], self, "j_spineupper");
  playFXOnTag(level._effect["alien_teleport"], self, "j_mainroot");
  playFXOnTag(level._effect["alien_teleport"], self, "j_tail_3");

  playFXOnTag(level._effect["alien_teleport_dist"], self, "j_mainroot");
}

spawn_lurker(type) {
  assert(isDefined(self));

  spawner_origin = self.origin;
  spawner_angles = (0, 0, 0);
  if(isDefined(self.angles))
    spawner_angles = self.angles;

  spawn_type = "lurker";
  spawn_type_config = spawn_type + " " + type;

  agent = spawnAlien(spawner_origin, spawner_angles, spawn_type_config);

  return agent;
}

alien_wave_behavior() {
  self endon("death");

  foreach(player in get_players()) {
    self GetEnemyInfo(player);
  }

  if(isDefined(level.bomb) && IsSentient(level.bomb))
    self GetEnemyInfo(level.bomb);

  self.goalradius = 64;
  self.inStandingMelee = false;

  self thread alien_ai_debug_print(self.alien_type);
}

alien_lurker_behavior() {
  self endon("death");
  self endon("run_to_death");

  self set_ignore_enemy();

  self thread alien_ai_debug_print("Lurker -_-zZ");

  self thread wakeup_to_player_distance();
  self thread wakeup_to_player_damage();

  self thread walk_patrol_loop();

  self waittill("woke");

  self clear_ignore_enemy();

  self thread alien_ai_debug_print("Lurker >:E");

  wait 1;

  if(self.movemode == "walk")
    self maps\mp\agents\alien\_alien_think::set_alien_movemode("run");
}

wakeup_to_enemy() {
  self endon("woke");
  self endon("death");
  self endon("run_to_death");

  self waittill("enemy");

  self notify("woke");
}

wakeup_to_player_distance(dist) {
  self endon("woke");
  self endon("death");
  self endon("run_to_death");

  if(!isDefined(dist))
    dist = 512;

  wakeup = false;

  while(!wakeup) {
    foreach(player in get_players()) {
      if(distance(player.origin, self.origin) < dist) {
        wakeup = true;
        break;
      }
    }

    wait 0.25;
  }

  self notify("woke");
}

wakeup_to_player_damage() {
  self endon("woke");
  self endon("death");
  self endon("run_to_death");

  while(true) {
    self waittill("damage", damage, attacker);

    if(isDefined(attacker) && isalive(attacker) && isplayer(attacker)) {
      break;
    }
  }

  self notify("woke");
}

walk_patrol_loop() {
  self endon("woke");
  self endon("death");
  self endon("run_to_death");

  wait 1;

  if(isDefined(level.patrol_start_nodes)) {
    node = getClosest(self.origin, level.patrol_start_nodes);

    self maps\mp\agents\alien\_alien_think::set_alien_movemode("walk");

    while(true) {
      self ScrAgentSetGoalPos(node.origin);
      self ScrAgentSetGoalRadius(32);
      self waittill("goal_reached");

      if(isDefined(node.script_delay))
        wait node.script_delay;

      node = Getstruct(node.target, "targetname");
    }
  }
}

alien_ai_debug_print(nametag) {
  self endon("death");
  self notify("new_name_tag");
  self endon("new_name_tag");

  if(getdvarint("alien_debug_director") == 1) {
    while(true) {
      Print3d(self.origin, nametag, (1, 1, 1), 0.75, 2, 1);
      wait 0.05;
    }
  }
}

get_available_meteoroid_clip(node) {
  foreach(clip in level.meteoroid_clips) {
    if(!isDefined(clip.used_by)) {
      clip.used_by = node;
      return clip;
    }
  }

  return undefined;
}

setup_meteoroid_paths() {
  level._effect["vfx_alien_lightning_bolt"] = loadfx("vfx/gameplay/alien/vfx_alien_lightning_bolt_02");
  level._effect["vfx_alien_lightning_impact"] = loadfx("vfx/gameplay/alien/vfx_alien_lightning_impact_debris_01");

  level.meteoroid_impact_nodes = [];
  level.meteoroid_impact_nodes = getstructarray("meteoroid_impact", "targetname");

  level.meteoroid_clips = [];
  level.meteoroid_clips = getEntArray("meteoroid_clip", "targetname");
  foreach(clip in level.meteoroid_clips) {
    clip.used_by = undefined;
    clip.old_origin = clip.origin;
  }

  if(!isDefined(level.meteoroid_impact_nodes) || level.meteoroid_impact_nodes.size == 0) {
    return;
  }
  foreach(impact_node in level.meteoroid_impact_nodes) {
    impact_node.rocks = [];
    impact_node.occupied = false;

    targeted_array = GetStructArray(impact_node.target, "targetname");

    foreach(targeted in targeted_array) {
      if(!isDefined(targeted.script_noteworthy)) {
        continue;
      }
      if(targeted.script_noteworthy == "rocks") {
        impact_node.rocks[impact_node.rocks.size] = targeted;
      }

      if(targeted.script_noteworthy == "meteoroid_final") {
        impact_node.meteoroid_final_pos = targeted.origin;
        impact_node.meteoroid_final_angles = targeted.angles;
        impact_node.meteoroid = targeted;

        start = getstruct(targeted.target, "targetname");
        if(isDefined(start)) {
          impact_node.meteoroid_start_pos = start.origin;
          impact_node.meteoroid_start_angles = start.angles;

          end = getstruct(start.target, "targetname");
          if(isDefined(end)) {
            impact_node.meteoroid_end_pos = end.origin;
            impact_node.meteoroid_end_angles = end.angles;
          }
        }
      }
    }
  }
}

get_meteoroid_impact_node() {
  if(flag_exist("hives_cleared") && flag("hives_cleared"))
    return get_meteoroid_impact_node_escape();

  CoM = get_center_of_players();
  range = 2000;

  free_nodes = [];
  foreach(node in level.meteoroid_impact_nodes) {
    if(isDefined(node.script_noteworthy) && (node.script_noteworthy == "escape_blocker_meteor" || node.script_noteworthy == "escape_meteor")) {
      continue;
    }
    if(Distance2D(node.origin, CoM) > range) {
      continue;
    }
    if(node.occupied == false)
      free_nodes[free_nodes.size] = node;
  }

  if(free_nodes.size > 0)
    return free_nodes[randomint(free_nodes.size)];
  else
    return undefined;
}

get_meteoroid_impact_node_escape() {
  msg = "level.latest_choke_trig_active not defined during escape sequence";
  assertex(isDefined(level.latest_choke_trig_active) && isDefined(level.latest_choke_trig_active.choke_loc), msg);

  CoM = level.latest_choke_trig_active.choke_loc;
  range = 4000;

  free_nodes = [];
  foreach(node in level.meteoroid_impact_nodes) {
    if(!isDefined(node.script_noteworthy) || (node.script_noteworthy != "escape_blocker_meteor" && node.script_noteworthy != "escape_meteor")) {
      continue;
    }
    if(Distance2D(node.origin, CoM) > range) {
      continue;
    }
    if(node.occupied == false)
      free_nodes[free_nodes.size] = node;
  }

  if(free_nodes.size > 0) {
    closest_node = getClosest(CoM, free_nodes);

    if(isDefined(closest_node) && isDefined(closest_node.script_noteworthy) && closest_node.script_noteworthy == "escape_blocker_meteor")
      return closest_node;
    else
      return free_nodes[randomint(free_nodes.size)];
  } else {
    return undefined;
  }
}

get_center_of_players() {
  x = 0;
  y = 0;
  z = 0;
  foreach(player in level.players) {
    x += player.origin[0];
    y += player.origin[1];
    z += player.origin[2];
  }

  player_count = max(1, level.players.size);
  CoM = (x / player_count, y / player_count, z / player_count);

  return CoM;
}

CONST_ESCAPE_BLOCKER_METEOR_DELAY = 25;

spawn_alien_meteoroid(alien_type, count, respawn, spm, lasting_time) {
  level endon("nuke_went_off");

  if(!isDefined(level.meteoroid_impact_nodes) || level.meteoroid_impact_nodes.size == 0)
    return false;

  if(!isDefined(respawn))
    respawn = false;

  if(!isDefined(count)) {
    count = 4;

    foreach(node in level.meteoroid_impact_nodes) {
      if(node.occupied) {
        count += 2;
      }
    }
  }

  if(!isDefined(spm))
    spm = 60;

  if(!isDefined(lasting_time))
    lasting_time = 20;

  impact_node = get_meteoroid_impact_node();
  if(!isDefined(impact_node)) {
    return false;
  }

  clip = get_available_meteoroid_clip(impact_node);
  if(!isDefined(clip)) {
    return false;
  }

  impact_node.occupied = true;
  impact_node.meteoroid.ent = spawn("script_model", impact_node.meteoroid.origin);
  impact_node.meteoroid.ent setModel("mp_ext_alien_meteor");

  start_pos = impact_node.meteoroid_start_pos;
  start_angles = impact_node.meteoroid_start_angles;
  final_pos = impact_node.meteoroid_final_pos;
  final_angles = impact_node.meteoroid_final_angles;
  end_pos = impact_node.meteoroid_end_pos;
  end_angles = impact_node.meteoroid_end_angles;

  travel_time = 5;
  accel = 4;
  lightning_strikes = 3;

  if(flag_exist("hives_cleared") && flag("hives_cleared")) {
    travel_time = 3;
    accel = 1;
    lightning_strikes = 2;
  }

  impact_node.meteoroid.ent.origin = start_pos;
  impact_node.meteoroid.ent.angles = start_angles;

  level thread maps\mp\alien\_music_and_dialog::playVOForMeteor();

  impact_node.meteoroid.ent MoveTo(final_pos, travel_time, accel);
  thread playSoundInSpace("alien_minion_spawn_mtr_incoming", final_pos);

  impact_node.meteoroid.ent RotateVelocity((0, 360, 0), travel_time, accel);

  for(i = 0; i < lightning_strikes; i++) {
    playFX(level._effect["vfx_alien_lightning_bolt"], final_pos);
    thread playSoundInSpace("alien_minion_spawn_lightning", final_pos);
    wait travel_time / lightning_strikes;
  }

  impact_node.meteoroid.ent.origin = final_pos;
  impact_node.meteoroid.ent.angles = final_angles;

  playFX(level._effect["vfx_alien_lightning_impact"], impact_node.origin);
  Earthquake(0.75, 1, impact_node.origin, 2000);

  thread playSoundInSpace("alien_meteor_impact", impact_node.origin);
  PlayRumbleOnPosition("grenade_rumble", impact_node.origin);
  RadiusDamage(impact_node.origin, 256, 150, 10);

  clip.origin = impact_node.origin;
  clip DisconnectPaths();

  playFX(level._effect["vfx_alien_lightning_bolt"], final_pos);

  spawn_meteoroid_aliens(impact_node, alien_type, count, respawn, spm, lasting_time);

  if(flag_exist("hives_cleared") &&
    flag("hives_cleared") &&
    isDefined(impact_node.script_noteworthy) &&
    impact_node.script_noteworthy == "escape_blocker_meteor") {
    total_delay = CONST_ESCAPE_BLOCKER_METEOR_DELAY;
    lightning_strikes = 3;

    for(i = 0; i < lightning_strikes; i++) {
      playFX(level._effect["vfx_alien_lightning_bolt"], final_pos);
      thread playSoundInSpace("alien_minion_spawn_lightning", final_pos);
      wait total_delay / lightning_strikes;
    }
  }

  playFX(level._effect["vfx_alien_lightning_bolt"], final_pos);
  thread playSoundInSpace("alien_minion_spawn_lightning", final_pos);
  impact_node.meteoroid.ent MoveTo(end_pos, travel_time / 2, accel / 2);

  impact_node.meteoroid.ent RotateVelocity((0, 90, 0), travel_time / 2, accel / 2);

  playFX(level._effect["queen_ground_spawn"], impact_node.origin, (0, 0, 1));

  thread playSoundInSpace("alien_minion_spawn_mtr_sink", impact_node.origin);
  Earthquake(0.3, travel_time / 2, impact_node.origin, 512);

  wait travel_time / 4;

  wait travel_time / 4;

  impact_node.meteoroid.ent delete();

  clip.origin = clip.old_origin;
  clip ConnectPaths();

  clip.used_by = undefined;
  impact_node.occupied = false;
}

spawn_meteoroid_aliens(impact_node, alien_type, count, respawn, spm, spawn_time) {
  level endon("nuke_went_off");

  pos = impact_node.origin;

  wait 1;

  spawned = 0;
  end_time = GetTime() + spawn_time * 1000.0;
  spawned_aliens = [];

  while(1) {
    if(GetTime() >= end_time) {
      level notify("meteor_aliens_spawned", spawned_aliens, count);
      return;
    }

    if(spawned >= count && !respawn) {
      level notify("meteor_aliens_spawned", spawned_aliens, count);

      wait 7;
      return;
    }

    if(!can_spawn_meteoroid_alien(alien_type, count)) {
      wait 0.05;
      continue;
    }

    CoM = get_center_of_players();
    direction_vec = VectorNormalize(CoM - pos);
    direction_vec = RotateVector(direction_vec, (0, 120 - randomint(120), 0));
    spawner_angles = VectorToAngles(direction_vec);

    agent = spawnAlien(pos, spawner_angles, "wave " + alien_type);

    if(!isDefined(impact_node.script_noteworthy) || (impact_node.script_noteworthy != "escape_blocker_meteor" && impact_node.script_noteworthy != "escape_meteor"))
      agent thread crawl_out(pos, direction_vec);

    spawned_aliens[spawned_aliens.size] = agent;

    spawned++;

    wait RandomFloatRange(0.05, 0.25);

    wait(60 / spm) - 0.15;
  }
}

can_spawn_meteoroid_alien(alien_type, count) {
  alive_by_type = 0;

  foreach(agent in level.agentArray) {
    if(isalive(agent)) {
      if(agent is_alien_agent() && agent.alien_type == alien_type)
        alive_by_type++;
    }
  }

  budgetUsed = maps\mp\alien\_spawn_director::get_current_agent_count(true);

  if(budgetUsed > 17) {
    return false;
  }

  if(alive_by_type > count) {
    return false;
  }

  return true;
}

crawl_out(pos, direction_vec) {
  self endon("death");

  self enable_alien_scripted();

  default_rate = self.moveplaybackrate;
  self.moveplaybackrate = 0.5;

  self ScrAgentSetGoalRadius(4000);
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self ScrAgentSetPhysicsMode("noclip");

  self SetOrigin(pos + VectorNormalize(direction_vec) * 64);
  self moveToEndOnGround("traverse_climb_up", 4);

  self SetAnimState("traverse_climb_up", 4);
  anim_length = getAnimLength(self GetAnimEntry("traverse_climb_up", 4));

  wait anim_length / 2;
  self ScrAgentSetPhysicsMode("gravity");
  wait anim_length / 2;

  self.moveplaybackrate = default_rate;
  self clear_ignore_enemy();

  original_health = self.health;
  original_moverate = self.moveplaybackrate;
  original_animrate = self.animplaybackrate;

  while(self.health > original_health * 0.95) {
    self maps\mp\agents\alien\_alien_think::set_alien_movemode("walk");
    self.moveplaybackrate = 1.75;
    self.animplaybackrate = 1.75;
    wait 0.05;
  }

  self maps\mp\agents\alien\_alien_think::set_alien_movemode("run");
  self.moveplaybackrate = original_moverate;
  self.animplaybackrate = original_animrate;
}

moveToEndOnGround(animState, animIndex, animState2, animIndex2) {
  VERTICAL_DELTA_BUFFER = 2;
  GET_GROUND_DROP_HEIGHT = 60;
  AI_PHYSICS_TRACE_RADIUS = 32;

  anime = self GetAnimEntry(animState, animIndex);
  animLength = GetAnimLength(anime);
  animDelta = GetMoveDelta(anime, 0, 1);
  offsetFromStart = RotateVector(animDelta, self.angles);

  trace_start_pos = self.origin + (offsetFromStart[0], offsetFromStart[1], GET_GROUND_DROP_HEIGHT);
  trace_end_pos = trace_start_pos - (0, 0, 2 * GET_GROUND_DROP_HEIGHT);
  ground_pos = self AIPhysicsTrace(trace_start_pos, trace_end_pos, AI_PHYSICS_TRACE_RADIUS, 65);
  lerp_target_pos = ground_pos - offsetFromStart + (0, 0, VERTICAL_DELTA_BUFFER);

  self SetOrigin(lerp_target_pos);

  playFX(level._effect["drone_ground_spawn"], (self.origin[0], self.origin[1], ground_pos[2]), (0, 0, 1));

  debug_line(trace_start_pos, ground_pos, (1, 0, 0), 30);
  debug_origin(ground_pos, 4, (1, 0, 0), 30);

  debug_origin(self.origin + offsetFromStart, 4, (1, 1, 1), 30);
  debug_line(self.origin, self.origin + offsetFromStart, (1, 1, 1), 30);
}

debug_origin(vector, size, color, frames) {
  size = size / 2;
  thread draw_line(vector + (0, 0, size), vector - (0, 0, size), color, frames);
  thread draw_line(vector + (0, size, 0), vector - (0, size, 0), color, frames);
  thread draw_line(vector + (size, 0, 0), vector - (size, 0, 0), color, frames);
}

debug_line(from, to, color, frames) {
  thread draw_line(from, to, color, frames);
}

draw_line(from, to, color, frames) {
  if(GetDvarInt("alien_debug_director") > 0) {
    if(isDefined(frames)) {
      for(i = 0; i < frames; i++) {
        line(from, to, color);
        wait 0.05;
      }
    } else {
      for(;;) {
        line(from, to, color);
        wait 0.05;
      }
    }
  }
}

get_cycles(stronghold) {
  return level.strongholds[stronghold].cycles;
}

is_cycle_repeated(stronghold, cycle) {
  cycles = get_cycles(stronghold);
  return cycles[cycle].repeat;
}

get_waves(stronghold, cycle) {
  cycles = get_cycles(stronghold);
  return cycles[cycle].waves;
}

get_current_cycle() {
  return level.alien_wave_status["cycle"];
}

get_current_wave() {
  return level.alien_wave_status["wave"];
}

use_spawn_director() {
  if(isDefined(level.use_spawn_director) && level.use_spawn_director == 1)
    return true;
  return false;
}

encounter_cycle_spawn(force_cycle_start_notify, endon_notify) {
  level endon("game_ended");

  level.current_cycle_started_by_timeout = undefined;

  if(isDefined(endon_notify))
    level endon(endon_notify);

  if(!isDefined(level.cycle_count))
    level.cycle_count = init_cycle_count();

  cycle_spawn_delay = get_cycle_spawn_delay();

  msg = undefined;
  if(isDefined(force_cycle_start_notify))
    msg = level waittill_any_timeout(cycle_spawn_delay, force_cycle_start_notify);
  else
    wait cycle_spawn_delay;

  if(isDefined(msg) && msg == "timeout")
    level.current_cycle_started_by_timeout = true;

  cycle = level.cycle_count;
  if(isDefined(level.get_custom_cycle_func))
    cycle = [
      [level.get_custom_cycle_func]
    ]();

  maps\mp\alien\_spawn_director::start_cycle(cycle);
  level.cycle_count++;

  if(getdvarint("scr_debugcyclecount") == 1) {
    println("CYCLE_COUNT_DEBUG -- > Cycle Count INCREMENTED to: " + level.cycle_count);
  }

}

init_cycle_count() {
  if(GetDvarInt("scr_startingcycle") > 0)
    return GetDvarInt("scr_startingcycle");

  return 1;
}

get_cycle_spawn_delay() {
  extra_time = get_extra_spawn_delay();
  return (level.cycle_data.cycle_delay_times[level.cycle_count] + extra_time);
}

get_extra_spawn_delay() {
  if(is_chaos_mode())
    return 0;
  else
    return (getNumActiveAgents() * 3.0);
}