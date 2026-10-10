/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\coop_stealth.gsc
***********************************************/

#using scripts\asm\soldier\patrol;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_relics;
#using scripts\cp\laststand;
#using scripts\cp\spawning;
#using scripts\cp\star_rewards;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\stealth\manager;
#using scripts\cp_mp\stealth\stealth_music;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace coop_stealth;

function function_a2c5010c4e9d31fe() {
  while(!isDefined(level.stealth)) {
    waitframe();
  }

  setDvar(@ "hash_ae9c969df88e37e1", 5000);
  setDvar(@ "hash_f72ce39dd23b00d1", 5000);
  setDvar(@ "hash_cda36d9770cf5189", 150);
  level.stealth.var_792e4b9a380ade11 = 5000;
  level.stealth.var_94f8771062f2161 = 5000;
  level.stealth.var_e2e3c78d7dc88605 = 22500;
  function_4ff17efd15d01d3f(256);
  function_1611d0f6b5f84b9a(700);
}

function coop_stealth_init() {
  if(!scripts\engine\utility::flag_exist("raid_active")) {
    scripts\engine\utility::flag_init("raid_active");
  }

  if(!scripts\engine\utility::flag_exist("weapons_free")) {
    scripts\engine\utility::flag_init("weapons_free");
  }

  if(!scripts\engine\utility::flag_exist("stealth_enabled")) {
    scripts\engine\utility::flag_init("stealth_enabled");
  }

  setDvar(@ "hash_b1a48f998d883ffb", 1);

  if(getdvarint(@ "hash_f8332f8a8cedca1c", 0)) {
    scripts\cp_mp\stealth\stealth_music::main();
  }

  scripts\engine\utility::flag_init("stealth_settings_activated");

  if(!isDefined(level.var_7651ace291f2ce35)) {
    level.var_7651ace291f2ce35 = [];
  }

  level.var_7651ace291f2ce35["combat"] = gettime();
  level.var_7651ace291f2ce35["cover_blown"] = gettime();
  level.var_7651ace291f2ce35["explosion"] = gettime();
  level.var_1a6c1600565c49a = &function_1a6c1600565c49a;
  level.var_fcff6df987be068c = &function_fcff6df987be068c;
  level.var_28c0d60e971ff699 = &function_de5486dc9107107c;
  level.var_5f907987b2562f10 = &isinexecutionvictim;
  setDvar(@ "hash_52188cd691f99b29", 1);
  setDvar(@ "hash_1e36075e6b8ced83", 0);
  thread scripts\cp\coop_stealth::players_weapon_fired_monitor();
  function_ab229ed68fc7fd63();
  level thread function_b5eb90c4bf658113();
  register_stealth_state_funcs();
  randomize_stealth_alert_music_array();
  randomize_stealth_broken_music_array();
  level.ai_raising_alarm = [];
  level.stealth_soundaliases = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];
}

function function_1a6c1600565c49a(event) {
  if(!isDefined(level.var_7651ace291f2ce35[event.type])) {
    level.var_7651ace291f2ce35[event.type] = gettime();
  }

  if(function_85dd561037b4b981(gettime(), event)) {
    if(isDefined(event.type)) {
      if(event.type == "combat") {
        if(isDefined(level.var_6c5a3dd9183fa65e)) {
          level thread[[level.var_6c5a3dd9183fa65e]](event);
        }
      } else if(issubstr(event.type, "hunt")) {
        iprintlnbold("^1 HUNT ");
      }

      level.var_7651ace291f2ce35[event.type] = gettime() + 5000;
      return;
    }

    iprintlnbold(event.type);
    level.var_7651ace291f2ce35[event.type] = gettime() + 3000;
  }
}

function function_85dd561037b4b981(ntime, event) {
  if(isDefined(level.var_7651ace291f2ce35[event.type]) && ntime <= level.var_7651ace291f2ce35[event.type]) {
    return 0;
  }

  return 1;
}

function reset_global_stealth_settings() {
  level.ai_raising_alarm = [];
  level.global_stealth_broken = 0;
}

function register_stealth_state_funcs() {
  level.enter_stealth_state_func = [];
  level.exit_stealth_state_func = [];
  register_stealth_state_func("idle", &enter_casual, &exit_casual);
  register_stealth_state_func("casual", &enter_casual, &exit_casual);
  register_stealth_state_func("alert", &enter_alert, &exit_alert);
  register_stealth_state_func("combat", &enter_combat, &exit_combat);
}

function register_stealth_state_func(state_name, enter_func, exit_func) {
  level.enter_stealth_state_func[state_name] = enter_func;
  level.exit_stealth_state_func[state_name] = exit_func;
}

function ai_sight_monitor(player) {
  self.sightlastactivetime = 0;
  self.sightstate = 0;
  updateaisightonplayer(self.sightstate);
}

function getaisightdirection(enemy) {
  forward = anglesToForward(self getplayerangles());
  forward2d = (forward[0], forward[1], forward[2]);
  forward2d = vectorNormalize(forward2d);
  toenemy = enemy.origin - self.origin;
  toenemy2d = (toenemy[0], toenemy[1], toenemy[2]);
  toenemy2d = vectorNormalize(toenemy2d);
  dot = vectordot(forward2d, toenemy2d);

  if(dot >= 0.92388) {
    return 2;
  }

  if(dot >= 0.382683) {
    return scripts\engine\utility::ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 4, 1);
  }

  if(dot >= -0.382683) {
    return scripts\engine\utility::ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 128, 64);
  }

  if(dot >= -0.92388) {
    return scripts\engine\utility::ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 32, 8);
  }

  return 16;
}

function regular_enemy_death_func() {
  enemy_ai = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  if(isDefined(level.ai_raising_alarm) && array_contains(level.ai_raising_alarm, self)) {
    array_remove(level.ai_raising_alarm, self);
  }

  enemy_ai leave_corpse_for_others_to_see();
  enemy_ai delete_stealth_meter(enemy_ai);
  enemy_ai delete_combat_icon(enemy_ai);
}

function leave_corpse_for_others_to_see() {
  if(!isDefined(level.enemy_ai_corpse_locations)) {
    level.enemy_ai_corpse_locations = [];
  }

  if(!istrue(self.died_poorly)) {
    corpse_info = spawnStruct();
    corpse_info.loc = self.origin + (0, 0, 120);
    corpse_info.time_stamp = gettime();
    corpse_info.index = self getentitynumber() + randomint(100);
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_add(level.enemy_ai_corpse_locations, corpse_info);
  }
}

function level_should_run_sp_stealth() {
  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    return 1;
  }

  return getdvarint(@ "hash_9eb1e24f643e2711", 0);
}

function stealth_meter_sp_stealth_display_think(enemy_ai) {
  level endon("game_ended");
  level endon("weapons_free");
  enemy_ai endon("death");
  enemy_ai endon("enter_combat");
  enemy_ai endon("exit_stealth_think");
  enemy_ai notify("stealth_meter_sp_stealth_display_think");
  enemy_ai endon("stealth_meter_sp_stealth_display_think");

  while(true) {
    enemy_ai waittill("display_stealth_meter_to", player);

    function_a464c293616a3a6("<dev string:x1c>" + player.name);

    player thread ping_enemy_and_player_for_duration(enemy_ai, player, 1);

    if(function_e39a555170607456()) {
      thread scripts\cp_mp\utility\debug_utility::drawline(enemy_ai.origin, player.origin, 3, (1, 0, 0));
    }
  }
}

function ping_enemy_and_player_for_duration(enemy_ai, player, duration) {
  player notify("ping_enemy_and_player_for_duration");
  player endon("disconnect");
  player endon("ping_enemy_and_player_for_duration");

  if(!isDefined(duration)) {
    duration = 3;
  }

  player.sightstate = player getaisightdirection(enemy_ai);
  player updateaisightonplayer(player.sightstate);
  wait duration;
  player updateaisightonplayer(0);
}

function updateaisightonplayer(sightmask) {
  self setclientomnvar("ui_edge_glow", sightmask);
}

function threat_sight_monitor() {
  self endon("death");
  self endon("disconnect");
}

function mark_seen_this_player_this_frame(enemy_ai, player) {
  enemy_ai.player_most_recently_saw = player;
  player_id = player getentitynumber();

  if(!isDefined(enemy_ai.time_seeing_players)) {
    enemy_ai thread seeing_player_time_tracker(enemy_ai);
  }

  if(!isDefined(enemy_ai.time_seeing_players[player_id])) {
    enemy_ai.time_seeing_players[player_id] = 0;
  }
}

function seeing_player_time_tracker(enemy_ai) {
  level endon("game_ended");
  level endon("weapons_free");
  enemy_ai notify("seeing_player_time_tracker");
  enemy_ai endon("seeing_player_time_tracker");
  enemy_ai endon("death");
  enemy_ai endon("long_death");
  enemy_ai endon("enter_combat");
  enemy_ai.player_most_recently_saw = undefined;
  enemy_ai.time_seeing_players = [];
  var_7670d6a914797e69 = 0;

  if(getdvarint(@ "hash_91536e3e17dddc14", 0) != 0) {
    return;
  }

  while(true) {
    if(isDefined(enemy_ai.player_most_recently_saw)) {
      var_7670d6a914797e69 = 0;
    } else {
      var_7670d6a914797e69 += 0.1;
    }

    foreach(player_id, time in enemy_ai.time_seeing_players) {
      if(isDefined(enemy_ai.player_most_recently_saw) && player_id == enemy_ai.player_most_recently_saw getentitynumber()) {
        enemy_ai.time_seeing_players[player_id] += 0.1;
        enemy_ai.player_most_recently_saw = undefined;
        continue;
      }

      enemy_ai.time_seeing_players[player_id] = max(enemy_ai.time_seeing_players[player_id] - 0.05, 0);
    }

    foreach(player in level.players) {
      player_id = player getentitynumber();

      if(isDefined(enemy_ai.time_seeing_players[player_id]) && enemy_ai.time_seeing_players[player_id] == 0) {
        hide_stealth_meter_from(player, enemy_ai);
      }
    }

    if(var_7670d6a914797e69 >= 0.5) {
      stop_stealth_meter(enemy_ai);
    }

    wait 0.1;
  }
}

function stop_stealth_meter(enemy_ai) {
  enemy_ai.target_stealth_meter_progress = enemy_ai.current_stealth_meter_progress;
  enemy_ai notify("stop_stealth_meter");
}

function should_run_sp_stealth() {
  return level_should_run_sp_stealth() && (self.unittype == "soldier" || self.unittype == "juggernaut" || self.unittype == "dog");
}

function run_common_functions(enemy_ai, var_5001d8d3a6a01d08, var_b723fe98dd0f39f4, fov, var_d5ae73a7cc51f85a, var_f31ba637cec4081e, var_5438269deeb18825) {
  if(!scripts\engine\utility::flag("stealth_settings_activated")) {
    setdvarifuninitialized(@ "hash_9eb1e24f643e2711", 0);
    activate_stealth_settings();
  }

  if(isDefined(level.var_2a7a0dd9628ab102)) {
    enemy_ai[[level.var_2a7a0dd9628ab102]]();
  }

  forced_investigate = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    enemy_ai laseron();
  }

  if(isDefined(level.var_b20a836da84340b0) && isfunction(level.var_b20a836da84340b0)) {
    enemy_ai function_640ddd42cdc91a26();

    if([[level.var_b20a836da84340b0]](enemy_ai, enemy_ai.script_stealthgroup)) {
      enemy_ai scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();

      if(enemy_ai should_run_sp_stealth()) {
        enemy_ai function_640ddd42cdc91a26();
        enemy_ai thread scripts\stealth\enemy::main();
        enemy_ai thread scripts\cp_mp\stealth\manager::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
        enemy_ai thread seeing_player_time_tracker(enemy_ai);
        enemy_ai thread watch_for_level_weapons_free();
        enemy_ai.fnstealthgotonode = &go_to_node_callback;
      }

      return;
    } else {
      enemy_ai scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();

      if(enemy_ai should_run_sp_stealth()) {
        enemy_ai function_640ddd42cdc91a26();
        enemy_ai thread scripts\stealth\enemy::main();
        enemy_ai thread scripts\cp_mp\stealth\manager::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
        enemy_ai thread seeing_player_time_tracker(enemy_ai);
        enemy_ai thread watch_for_level_weapons_free();

        if(enemy_ai.agent_type != "dog_agent") {
          enemy_ai.fnstealthgotonode = &go_to_node_callback;
        }
      }
    }
  } else if(function_94ffb636a243cf0e(4)) {
    enemy_ai scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();

    if(enemy_ai should_run_sp_stealth()) {
      enemy_ai function_640ddd42cdc91a26();
      enemy_ai thread scripts\stealth\enemy::main();
      enemy_ai thread scripts\cp_mp\stealth\manager::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
      enemy_ai thread seeing_player_time_tracker(enemy_ai);
      enemy_ai thread watch_for_level_weapons_free();
      enemy_ai.fnstealthgotonode = &go_to_node_callback;
    }

    return;
  }

  if(istrue(level.global_stealth_broken) || istrue(level.forced_hunt) && istrue(forced_investigate)) {
    enemy_ai scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();

    if(enemy_ai should_run_sp_stealth()) {
      enemy_ai function_640ddd42cdc91a26();
      enemy_ai thread scripts\stealth\enemy::main();
      enemy_ai thread scripts\cp_mp\stealth\manager::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
      enemy_ai thread seeing_player_time_tracker(enemy_ai);
      enemy_ai thread watch_for_level_weapons_free();
      enemy_ai scripts\stealth\utility::set_stealth_func("event_combat", &enter_combat_callback);
      enemy_ai.fnstealthgotonode = &go_to_node_callback;
    }

    return;
  }

  if(enemy_ai should_run_sp_stealth()) {
    enemy_ai scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();
    enemy_ai function_640ddd42cdc91a26();
    enemy_ai thread scripts\stealth\enemy::main();
    enemy_ai thread scripts\cp_mp\stealth\manager::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
    enemy_ai thread seeing_player_time_tracker(enemy_ai);
    enemy_ai thread watch_for_level_weapons_free();
    enemy_ai scripts\stealth\utility::set_stealth_func("event_combat", &enter_combat_callback);

    if(enemy_ai.agent_type != "dog_agent") {
      enemy_ai.fnstealthgotonode = &go_to_node_callback;
    }
  }
}

function function_640ddd42cdc91a26() {
  enemy_ai = self;

  if(isDefined(enemy_ai.group) && isDefined(enemy_ai.group.group_name)) {
    enemy_ai.script_stealthgroup = enemy_ai.group.group_name;
  } else if(isDefined(enemy_ai.directorspawndata) && isDefined(enemy_ai.directorspawndata.script_stealthgroup)) {
    enemy_ai.script_stealthgroup = enemy_ai.directorspawndata.script_stealthgroup;
  } else {
    enemy_ai.script_stealthgroup = "group";
  }

  if(isDefined(enemy_ai.spawnpoint)) {
    if(isDefined(enemy_ai.spawnpoint.script_stealthgroup)) {
      enemy_ai.script_stealthgroup = enemy_ai.spawnpoint.script_stealthgroup;
    }

    if(isDefined(enemy_ai.spawnpoint.script_sightrange)) {
      enemy_ai.stealth.override_damage_auto_range = int(enemy_ai.script_sightrange);
    }
  }
}

function get_players_not_in_laststand() {
  result = [];

  foreach(player in level.players) {
    if(scripts\cp\laststand::player_in_laststand(player)) {
      continue;
    }

    result[result.size] = player;
  }

  return result;
}

function function_be21052e355eac6a(spot) {
  assertex(isDefined(spot), " investigate event needs to defined when calling this function _>fire_investigate_event( )");

  if(!isDefined(spot)) {
    return;
  }

  event = spawnStruct();
  event.type = "combat_hunt";
  event.typeorig = "sight";
  event.origin = spot + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  event.investigate_pos = getclosestpointonnavmesh(event.origin, self);

  if(!isDefined(self.fnsetstealthstate)) {
    self setgoalpos(event.investigate_pos);
    return;
  }

  scripts\stealth\enemy::bt_set_stealth_state("hunt", event);
}

function function_7e00903590974138(var_aff9420e4547ceea) {
  if(isDefined(self.fnisinstealthhunt) && self[[self.fnisinstealthhunt]]()) {
    return;
  }

  event = spawnStruct();
  event.entity = random(get_players_not_in_laststand());

  if(!isDefined(event.entity)) {
    scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
    return;
  }

  event.investigate_pos = event.entity.origin;
  spot = event.investigate_pos;
  assertex(isDefined(spot), " investigate event needs to defined when calling this function _>fire_investigate_event( )");

  if(!isDefined(spot)) {
    return;
  }

  event = spawnStruct();
  event.type = "combat_hunt";
  event.typeorig = ter_op(isDefined(var_aff9420e4547ceea), var_aff9420e4547ceea, "sight");
  event.origin = spot + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  event.investigate_pos = getclosestpointonnavmesh(event.origin);

  if(!isDefined(self.fnsetstealthstate)) {
    self setgoalpos(event.investigate_pos);
    return;
  }

  scripts\stealth\enemy::bt_set_stealth_state("hunt", event);
}

function enter_combat_callback(event) {
  if(self isinexecutionvictim()) {
    return false;
  }

  thread function_85de6fd095875e9d();
  return false;
}

function function_85de6fd095875e9d() {
  self endon("death");
  wait 2.5;

  if(isDefined(self.vehicle) && !istrue(self.vehicle scripts\common\vehicle::ishelicopter())) {
    if(!isDefined(self.vehicle.var_af63688e8d4f80ee) || self.vehicle.var_af63688e8d4f80ee == 0) {
      self.vehicle thread function_ffe8657189764909(self);
    }
  }

  level notify("stealth_combat_validated", self.script_stealthgroup);
}

function function_81f873eae0cbac09() {
  target = self getturrettarget(0);

  if(isDefined(target) && isPlayer(target) && !target isparachuting()) {
    origin = target.origin;
    aiarray = getaiarrayinradius(origin, 2048);

    foreach(ai in aiarray) {
      if(!isDefined(origin)) {
        continue;
      }

      event = spawnStruct();
      event.origin = origin + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
      event.investigate_pos = getclosestpointonnavmesh(event.origin, ai);
      ai aieventlistenerevent("investigate", target, event.origin);
    }
  }
}

function function_ffe8657189764909(rider) {
  self vehicle_setspeedimmediate(0, 300, 300);
  self stoppath(1);
  self notify("unload_guys");

  foreach(ai in self.riders) {
    ai notify("unloaded_from_techo");
  }

  scripts\common\vehicle::vehicle_unload();
}

function go_to_node_callback(nodes, var_29455cbea8b9ad83, var_b7e2619a5c2c393d, var_686ec37f85316247) {
  if(isDefined(self.currentnode)) {
    thread scripts\cp\spawning::go_to_node(self.currentnode);
    return;
  }

  scripts\cp\spawning::return_to_last_goalRadius();
}

function suspicious_door_monitor() {
  self notify("suspicious_door_monitor_end");
  self endon("death");
  self endon("disconnect");
  self endon("suspicious_door_monitor_end");
  var_ebab8c83f9c41c5f = 512;
  var_da76fc64f53d4b8c = 512;

  while(true) {
    level waittill("door_event", origin, user);

    if(isDefined(user) && isPlayer(user)) {
      function_daf6c5596bb31dff("window_open", user, user.origin, var_ebab8c83f9c41c5f, user.origin, 1, var_da76fc64f53d4b8c);
    }
  }
}

function change_stealth_state_to(enemy_ai, var_6879f8f1b126e993) {
  level endon("weapons_free");
  enemy_ai notify("change_stealth_state_to", var_6879f8f1b126e993);
  enemy_ai endon("change_stealth_state_to");
  enemy_ai endon("death");
  enemy_ai endon("enter_combat");
  exit_current_stealth_state(enemy_ai);
  set_current_stealth_state(enemy_ai, var_6879f8f1b126e993);
  enter_current_stealth_state(enemy_ai);
}

function exit_current_stealth_state(enemy_ai) {
  enemy_ai[[level.exit_stealth_state_func[get_current_stealth_state(enemy_ai)]]](enemy_ai);
}

function enter_current_stealth_state(enemy_ai) {
  enemy_ai[[level.enter_stealth_state_func[get_current_stealth_state(enemy_ai)]]](enemy_ai);
}

function set_current_stealth_state(enemy_ai, current_stealth_state) {
  enemy_ai.current_stealth_state = current_stealth_state;
}

function get_current_stealth_state(enemy_ai) {
  return enemy_ai.current_stealth_state;
}

function is_ai_in_stealth(enemy_ai) {
  return isDefined(get_current_stealth_state(enemy_ai));
}

function enter_casual(enemy_ai) {
  enemy_ai scripts\cp\spawning::set_demeanor_from_unittype("patrol");
  enemy_ai scripts\engine\utility::set_movement_speed(25);
}

function exit_casual(enemy_ai) {}

function enter_alert(enemy_ai) {}

function stopsoundoncompletion(alias) {
  wait lookupsoundlength(alias);
  self.bplayingspecificstealthsound = undefined;
}

function exit_alert(enemy_ai) {
  delete_stealth_meter(enemy_ai);
}

function enter_combat(enemy_ai) {
  enemy_ai endon("death");
  enemy_ai endon("enter_combat");

  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    level.global_stealth_broken = 1;
    level thread play_combat_music_to_players();
  }
}

function ai_is_juggernaut(enemy_ai) {
  return enemy_ai.agent_type == "actor_enemy_cp_rus_juggernaut" || enemy_ai.agent_type == "actor_enemy_cp_jugg_aq" || enemy_ai.agent_type == "actor_enemy_cp_jugg_cartel";
}

function exit_combat(enemy_ai) {}

function stop_patrol(var_65773575afb98ed4) {
  enemy_ai = self;
  enemy_ai notify("stop_going_to_node");
  enemy_ai notify("patrol_using_cover_nodes");

  if(istrue(var_65773575afb98ed4)) {
    enemy_ai scripts\cp\spawning::set_goal_pos(enemy_ai.origin);
  }
}

function watch_for_level_weapons_free() {
  level endon("game_ended");
  self notify("watch_for_level_weapons_free");
  self endon("watch_for_level_weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");

  if(getdvarint(@ "hash_5f4b6ed389fc998", 0) != 0) {
    return;
  }

  assert(should_run_sp_stealth());
  level waittill("weapons_free");
  scripts\cp\spawning::remove_pacifist_from_guy();
  self aieventlistenerevent("combat", self, self.origin);
}

function player_in_concealment_area(who) {
  return istrue(who.inside_bush);
}

function make_headicon_on_ai(enemy_ai, var_5b78e77c334fa943) {
  if(getdvarint(@ "hash_52188cd691f99b29", 0) != 0) {
    return;
  }

  if(has_headicon(enemy_ai)) {
    return;
  }

  reinforcement_icon = get_reinforcement_icon_image(enemy_ai);
  reinforcement_headicon = createheadicon(enemy_ai);
  setheadiconimage(reinforcement_headicon, reinforcement_icon);
  setheadiconzoffset(reinforcement_headicon, 10);
  setheadiconsnaptoedges(reinforcement_headicon, 0);
  setheadicondrawthroughgeo(reinforcement_headicon, 1);
  setheadiconmaxdistance(reinforcement_headicon, 5000);
  setheadiconnaturaldistance(reinforcement_headicon, 500);
  reinforcement_icon_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + enemy_ai getentitynumber(), 22);
  objective_state(reinforcement_icon_objective_id, "active");
  objective_icon(reinforcement_icon_objective_id, reinforcement_icon);
  objective_setbackground(reinforcement_icon_objective_id, 1);
  objective_removeallfrommask(reinforcement_icon_objective_id);
  objective_setplayoutro(reinforcement_icon_objective_id, 0);
  objective_setshowdistance(reinforcement_icon_objective_id, 0);
  objective_setshowprogress(reinforcement_icon_objective_id, 0);
  objective_setfadedisabled(reinforcement_icon_objective_id, 1);
  objective_sethot(reinforcement_icon_objective_id, 1);
  objective_setpulsate(reinforcement_icon_objective_id, 1);
  objective_setshowoncompass(reinforcement_icon_objective_id, 1);
  objective_onentity(reinforcement_icon_objective_id, enemy_ai);
  enemy_ai thread[[var_5b78e77c334fa943]](reinforcement_icon_objective_id, reinforcement_headicon, enemy_ai);
  enemy_ai.reinforcement_icon_objective_id = reinforcement_icon_objective_id;
}

function get_reinforcement_icon_image(enemy_ai) {
  assertex(isDefined(enemy_ai.reinforcement_type), "<dev string:x37>");

  switch (enemy_ai.reinforcement_type) {
    case #"hash_186d745a92c317d9":
      return "hud_alert";
    case #"hash_f91ce75a81ea18ba":
      return "hud_icon_head_tacops_alarm";
    case #"hash_d65a232a0dab9abf":
      return "hud_icon_head_tacops_cellphone";
    case #"hash_aed8817b69fca3d4":
      return "hud_icon_esc_bounty_target";
  }
}

function make_combat_icon_on_ai(enemy_ai) {
  if(getdvarint(@ "hash_52188cd691f99b29", 0) != 0) {
    return;
  }

  if(has_combat_icon(enemy_ai)) {
    return;
  }

  combat_icon_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + enemy_ai getentitynumber(), 22);
  objective_state(combat_icon_objective_id, "active");
  objective_icon(combat_icon_objective_id, "hud_icon_stealth");
  objective_onentity(combat_icon_objective_id, enemy_ai);
  objective_setzoffset(combat_icon_objective_id, 90);
  objective_removeallfrommask(combat_icon_objective_id);
  objective_setplayintro(combat_icon_objective_id, 0);
  objective_setplayoutro(combat_icon_objective_id, 0);
  objective_setbackground(combat_icon_objective_id, 1);
  objective_setshowdistance(combat_icon_objective_id, 0);
  objective_setshowprogress(combat_icon_objective_id, 1);
  objective_setfadedisabled(combat_icon_objective_id, 1);
  objective_sethot(combat_icon_objective_id, 1);
  objective_setpulsate(combat_icon_objective_id, 1);
  objective_setshowoncompass(combat_icon_objective_id, 1);
  enemy_ai.combat_icon_objective_id = combat_icon_objective_id;
}

function make_stealth_meter_on_ai(enemy_ai) {
  if(getdvarint(@ "hash_52188cd691f99b29", 0) != 0) {
    return;
  }

  if(has_stealth_meter(enemy_ai)) {
    return;
  }

  stealth_meter_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_stealth_ID_" + enemy_ai getentitynumber(), 21);
  objective_state(stealth_meter_objective_id, "active");
  objective_icon(stealth_meter_objective_id, "hud_icon_stealth");
  objective_onentity(stealth_meter_objective_id, enemy_ai);
  objective_setzoffset(stealth_meter_objective_id, 90);
  objective_removeallfrommask(stealth_meter_objective_id);
  objective_setplayintro(stealth_meter_objective_id, 0);
  objective_setplayoutro(stealth_meter_objective_id, 0);
  objective_setbackground(stealth_meter_objective_id, 1);
  objective_setshowdistance(stealth_meter_objective_id, 0);
  objective_setshowprogress(stealth_meter_objective_id, 1);
  objective_setprogress(stealth_meter_objective_id, 0);
  objective_setfadedisabled(stealth_meter_objective_id, 1);
  objective_sethot(stealth_meter_objective_id, 1);
  objective_setpulsate(stealth_meter_objective_id, 1);
  objective_setshowoncompass(stealth_meter_objective_id, 1);
  enemy_ai.showing_the_stealth_meter_to_players = [];
  enemy_ai.stealth_meter_objective_id = stealth_meter_objective_id;
  enemy_ai thread clear_up_stealth_meter_when_enter_combat(enemy_ai);
}

function clear_up_stealth_meter_when_enter_combat(enemy_ai) {
  enemy_ai endon("death");
  enemy_ai waittill("enter_combat");
  delete_stealth_meter(enemy_ai);
}

function show_stealth_meter_to(player, enemy_ai) {
  if(!has_stealth_meter(enemy_ai)) {
    make_stealth_meter_on_ai(enemy_ai);
  }

  if(is_showing_stealth_meter_to(player, enemy_ai)) {
    return;
  }

  enemy_ai.showing_the_stealth_meter_to_players[enemy_ai.showing_the_stealth_meter_to_players.size] = player;
  objective_addclienttomask(enemy_ai.stealth_meter_objective_id, player);
}

function show_combat_icon_to(player, enemy_ai) {
  if(getdvarint(@ "hash_52188cd691f99b29", 0) != 0) {
    return;
  }

  if(!has_combat_icon(enemy_ai)) {
    make_combat_icon_on_ai(enemy_ai);
  }

  objective_addclienttomask(enemy_ai.combat_icon_objective_id, player);
}

function show_headicon_to(player, enemy_ai, var_5b78e77c334fa943) {
  if(istrue(level.disable_stealth_reinforcement_icon)) {
    return;
  }

  if(getdvarint(@ "hash_52188cd691f99b29", 0) != 0) {
    return;
  }

  if(!has_headicon(enemy_ai)) {
    make_headicon_on_ai(enemy_ai, var_5b78e77c334fa943);
  }

  objective_addclienttomask(enemy_ai.reinforcement_icon_objective_id, player);
}

function set_stealth_meter_progress(enemy_ai, progress) {
  if(get_current_stealth_state(enemy_ai) == "alert") {
    enemy_ai.target_stealth_meter_progress = progress;
  }
}

function hide_stealth_meter_from(player, enemy_ai) {
  if(!has_stealth_meter(enemy_ai)) {
    return;
  }

  if(!is_showing_stealth_meter_to(player, enemy_ai)) {
    return;
  }

  enemy_ai.showing_the_stealth_meter_to_players = scripts\engine\utility::array_remove(enemy_ai.showing_the_stealth_meter_to_players, player);
  objective_removeclientfrommask(enemy_ai.stealth_meter_objective_id, player);

  if(enemy_ai.showing_the_stealth_meter_to_players.size == 0) {
    enemy_ai.i_am_seeing_this_player = undefined;
  }
}

function is_showing_stealth_meter_to(player, enemy_ai) {
  return scripts\engine\utility::array_contains(enemy_ai.showing_the_stealth_meter_to_players, player);
}

function has_stealth_meter(enemy_ai) {
  return isDefined(enemy_ai.stealth_meter_objective_id);
}

function has_combat_icon(enemy_ai) {
  return isDefined(enemy_ai.combat_icon_objective_id);
}

function has_headicon(enemy_ai) {
  return isDefined(enemy_ai.reinforcement_icon_objective_id);
}

function delete_stealth_meter(enemy_ai) {
  if(has_stealth_meter(enemy_ai)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_stealth_ID_" + enemy_ai getentitynumber());
    objective_delete(enemy_ai.stealth_meter_objective_id);
    enemy_ai.stealth_meter_objective_id = undefined;
    enemy_ai notify("exit_stealth_think");
  }
}

function delete_combat_icon(enemy_ai) {
  if(has_combat_icon(enemy_ai)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_combat_ID_" + enemy_ai getentitynumber());
    objective_delete(enemy_ai.combat_icon_objective_id);
    enemy_ai.combat_icon_objective_id = undefined;
    enemy_ai notify("exit_stealth_think");
  }
}

function delete_headicon(reinforcement_icon_objective_id, reinforcement_headicon, enemy_ai, var_edcde399ccbc2094) {
  scripts\cp\cp_objectives::freeworldid("enemy_AI_reinforcement_ID_" + var_edcde399ccbc2094);
  objective_delete(reinforcement_icon_objective_id);
  enemy_ai.reinforcement_icon_objective_id = undefined;
  deleteheadicon(reinforcement_headicon);
  enemy_ai notify("exit_stealth_think");
}

function did_anyone_see_this(enemy, eventposition, eventradius, var_be714c91530ba6ca, tacposition, autorange) {
  ais = getaiarray("axis");
  cradiussq = eventradius * eventradius;

  if(!isDefined(var_be714c91530ba6ca)) {
    var_be714c91530ba6ca = 1;
  }

  if(!isDefined(tacposition)) {
    tacposition = eventposition;
  }

  var_2068a3efd793afba = 3;
  var_c9787abb0668d729 = 0;

  foreach(ai in ais) {
    if(enemy == ai) {
      if(!isDefined(enemy.times_hit)) {
        enemy.times_hit = 1;
      } else {
        enemy.times_hit++;
      }

      if(enemy.times_hit > 1) {
        return true;
      } else {
        continue;
      }
    }

    if(!isalive(ai)) {
      continue;
    }

    distsq = distancesquared(ai.origin, eventposition);

    if(distsq > cradiussq) {
      continue;
    }

    if(isDefined(autorange) && distsq <= autorange * autorange) {
      continue;
    }

    if(!ai hastacvis(tacposition, var_be714c91530ba6ca)) {
      if(var_be714c91530ba6ca && !ai aipointinfov(eventposition)) {
        continue;
      }

      var_c9787abb0668d729++;

      if(var_c9787abb0668d729 > var_2068a3efd793afba) {
        waitframe();
        var_c9787abb0668d729 = 0;
      }

      if(!sighttracepassed(ai getEye(), eventposition, 0, enemy)) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function increase_script_maxdist(group, param1, param2, param3) {
  spawnpoints = scripts\cp\spawning::process_module_var(group, group.spawn_points);

  for(i = 0; i < spawnpoints.size; i++) {
    struct = spawnpoints[i];
    struct.script_maxdist = 20000;
  }
}

function player_in_bush_monitor() {
  level endon("game_ended");

  foreach(player in level.players) {
    player thread monitor_bush_trig(player);
  }

  level thread bush_onplayerconnect();
}

function bush_onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player thread monitor_bush_trig(player);
  }
}

function monitor_bush_trig(player) {
  level endon("game_ended");
  player endon("disconnect");
  var_eace1f6533829ead = 100;
  interval = 0.1;

  while(true) {
    wait interval;
    player.inside_bush = 0;

    if(player istouching(level.bush_trig)) {
      player.inside_bush = 1;
      continue;
    }

    zone = get_current_bush_zone(player);

    if(!isDefined(zone)) {
      continue;
    }

    foreach(struct in zone[2]) {
      org = struct[0];
      radius_sq = struct[1];

      if(scripts\engine\utility::distance_2d_squared(org, player.origin) < radius_sq && abs(org[2] - player.origin[2]) < var_eace1f6533829ead) {
        player.inside_bush = 1;

        if(istrue(level.bush_trig_debug)) {
          thread scripts\engine\utility::draw_circle(org, sqrt(radius_sq), (0, 1, 1), 1, 0, 2);
        }
      }
    }
  }
}

function get_current_bush_zone(player) {
  foreach(zone in level.bush_zones) {
    if(scripts\engine\utility::distance_2d_squared(player.origin, zone[0]) < zone[1]) {
      return zone;
    }
  }

  return undefined;
}

function is_stealth_sequence_activated() {
  if(!scripts\engine\utility::flag_exist("stealth_settings_activated")) {
    return 0;
  }

  return scripts\engine\utility::flag("stealth_settings_activated");
}

function function_a464c293616a3a6(debug_string) {
  if(!function_e39a555170607456()) {
    return;
  }

  iprintln(debug_string);
}

function function_e39a555170607456() {
  return getdvarint(@ "hash_6d78d3cf7d56cdd5", 0) != 0;
}

function activate_stealth_settings() {
  function_7afb89fc511bf315("explosion", 2048);
  function_7afb89fc511bf315("gunshot", 1024);
  function_7afb89fc511bf315("footstep", 128);
  function_7afb89fc511bf315("footstep_walk", 64);
  function_7afb89fc511bf315("footstep_sprint", 200);
  level thread grenade_exploded_during_stealth_listener();

  if(isDefined(level.var_4056f15d39bcf78)) {
    [[level.var_4056f15d39bcf78]]();
  } else {
    function_a2c5010c4e9d31fe();
  }

  setDvar(@ "hash_7af445124b2a7094", 1);
  scripts\engine\utility::flag_set("stealth_settings_activated");
}

function players_grenade_fire_monitor() {
  level endon("game_ended");
  level endon("weapons_free");
  level notify("players_grenade_fire_monitor");
  level endon("players_grenade_fire_monitor");

  foreach(player in level.players) {
    player thread player_grenade_fire_monitor(player);
  }

  while(true) {
    level waittill("connected", player);
    player thread delay_start_player_grenade_fire_monitor(player);
  }
}

function delay_start_player_grenade_fire_monitor(player) {
  level endon("game_ended");
  level endon("weapons_free");
  player scripts\engine\utility::waittill_any_2("loadout_given", "start_hotjoining_via_c130");
  player thread player_grenade_fire_monitor(player);
}

function player_grenade_fire_monitor(player) {
  level endon("game_ended");
  level endon("weapons_free");
  player notify("player_grenade_fire_monitor");
  player endon("player_grenade_fire_monitor");

  while(true) {
    player waittill("grenade_fire");
    player.last_grenade_fire_time = gettime();
  }
}

function get_player_who_most_recently_threw_grenade() {
  result = undefined;
  var_826ce097d3746cc8 = -1;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }

    if(isDefined(player.last_grenade_fire_time) && player.last_grenade_fire_time > var_826ce097d3746cc8) {
      result = player;
      var_826ce097d3746cc8 = player.last_grenade_fire_time;
    }
  }

  return result;
}

function players_weapon_fired_monitor() {
  level endon("game_ended");
  level notify("players_weapon_fired_monitor");
  level endon("players_weapon_fired_monitor");

  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(player in level.players) {
    player thread player_weapon_fired_monitor(player);
  }

  while(true) {
    level waittill("connected", player);
    player thread delay_start_player_weapon_fired_monitor(player);
  }
}

function delay_start_player_weapon_fired_monitor(player) {
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_2("loadout_given", "start_hotjoining_via_c130");
  player thread player_weapon_fired_monitor(player);
}

function player_weapon_fired_monitor(player) {
  level endon("game_ended");
  player notify("player_weapon_fired_monitor");
  player endon("player_weapon_fired_monitor");

  while(true) {
    player waittill("weapon_fired");
    player.last_weapon_fired_time = gettime();
  }
}

function get_player_who_most_likely_broke_stealth(event_pos, var_6ab916505c4d2e82) {
  result = [[var_6ab916505c4d2e82]]();

  if(isDefined(result)) {
    return result;
  }

  return get_closest_valid_player(event_pos);
}

function get_closest_valid_player(event_pos) {
  valid_players = [];

  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }

    valid_players[valid_players.size] = player;
  }

  return scripts\engine\utility::getclosest(event_pos, valid_players);
}

function get_player_who_most_recently_fired_weapon() {
  result = undefined;
  var_826ce097d3746cc8 = -1;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }

    if(isDefined(player.last_weapon_fired_time) && player.last_weapon_fired_time > var_826ce097d3746cc8) {
      result = player;
      var_826ce097d3746cc8 = player.last_weapon_fired_time;
    }
  }

  return result;
}

function deactivate_stealth_settings() {
  function_7afb89fc511bf315("explosion", 1024);
  function_7afb89fc511bf315("gunshot", 1024);
  function_7afb89fc511bf315("glass_destroyed", 384);
  function_7afb89fc511bf315("footstep", 256);
  function_7afb89fc511bf315("footstep_walk", 128);
  function_7afb89fc511bf315("footstep_sprint", 400);
  scripts\engine\utility::flag_clear("stealth_settings_activated");
}

function randomize_stealth_alert_music_array() {
  var_60b19c2064e2dcb5 = ["mus_cp_stealth_1", "mus_cp_stealth_2", "mus_cp_stealth_3", "mus_cp_stealth_4", "mus_cp_stealth_5", "mus_cp_stealth_6"];

  for(i = 0; i < 5; i++) {
    var_60b19c2064e2dcb5 = scripts\engine\utility::array_randomize(var_60b19c2064e2dcb5);
  }

  level.stealth_alert_music = var_60b19c2064e2dcb5;
  level.stealth_alert_music_index = 0;
}

function get_stealth_alert_music_alias() {
  result = level.stealth_alert_music[level.stealth_alert_music_index];
  level.stealth_alert_music_index++;

  if(level.stealth_alert_music_index == level.stealth_alert_music.size - 1) {
    randomize_stealth_alert_music_array();
  }

  return result;
}

function randomize_stealth_broken_music_array() {
  var_60b19c2064e2dcb5 = ["mus_cp_stealth_broken_1", "mus_cp_stealth_broken_2", "mus_cp_stealth_broken_3", "mus_cp_stealth_broken_4", "mus_cp_stealth_broken_5", "mus_cp_stealth_broken_6"];

  for(i = 0; i < 5; i++) {
    var_60b19c2064e2dcb5 = scripts\engine\utility::array_randomize(var_60b19c2064e2dcb5);
  }

  level.stealth_broken_music = var_60b19c2064e2dcb5;
  level.stealth_broken_music_index = 0;
}

function get_stealth_broken_music_alias() {
  result = level.stealth_broken_music[level.stealth_broken_music_index];
  level.stealth_broken_music_index++;

  if(level.stealth_broken_music_index == level.stealth_broken_music.size - 1) {
    randomize_stealth_broken_music_array();
  }

  return result;
}

function play_alert_music_to_player(player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("play_alert_music_to_player");
  player endon("play_alert_music_to_player");

  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    return;
  }

  var_d0bc1a870de36153 = 3;

  if(!isDefined(player.playing_stealth_alert_music)) {
    stealth_alert_music_alias = get_stealth_alert_music_alias();
    player.playing_stealth_alert_music = stealth_alert_music_alias;
    scripts\cp\utility::play_music_to_team(stealth_alert_music_alias, player);
  }

  result = level scripts\engine\utility::waittill_any_timeout_1(var_d0bc1a870de36153, "weapons_free");
  player.playing_stealth_alert_music = undefined;
  player setplayermusicstate("");
}

function play_combat_music_to_players() {
  scripts\cp\utility::play_music_to_team(get_stealth_broken_music_alias(), level.players);
}

function change_stealth_state_to_combat_warpper(enemy_ai, player_name_who_broke_stealth, reason_stealth_broken) {
  enemy_ai.player_name_who_broke_stealth = player_name_who_broke_stealth;
  enemy_ai.reason_stealth_broken = reason_stealth_broken;
  enemy_ai thread change_stealth_state_to(enemy_ai, "combat");
}

function display_who_broke_stealth_message(enemy_ai) {
  assertex(isDefined(enemy_ai.player_name_who_broke_stealth), "<dev string:x68>");
  assertex(isDefined(enemy_ai.reason_stealth_broken), "<dev string:x8c>");

  foreach(player in level.players) {
    if(player.name == enemy_ai.player_name_who_broke_stealth) {
      display_message_to_guilty_player(player, enemy_ai.reason_stealth_broken);
      continue;
    }

    display_message_to_teammates(player, enemy_ai.player_name_who_broke_stealth, enemy_ai.reason_stealth_broken);
  }
}

function display_message_to_guilty_player(var_a34441262b0d5315, reason_stealth_broken) {
  switch (reason_stealth_broken) {
    case #"hash_39fb8322da3b46f6":
      var_a34441262b0d5315 iprintlnbold("^1You ^7have alerted the enemies");
      break;
    case #"hash_885c3e314392bb2":
      var_a34441262b0d5315 iprintlnbold("^1You ^7have been spotted by the enemies");
      break;
  }
}

function display_message_to_teammates(teammate_player, guilty_player_name, reason_stealth_broken) {
  switch (reason_stealth_broken) {
    case #"hash_39fb8322da3b46f6":
      teammate_player iprintlnbold("^1" + guilty_player_name + "^7 has alerted the enemies");
      break;
    case #"hash_885c3e314392bb2":
      teammate_player iprintlnbold("^1" + guilty_player_name + "^7 has been spotted by the enemies");
      break;
  }
}

function function_ab229ed68fc7fd63() {
  level.var_a3c1a3a8df3469c0 = 0;
  function_b75dbbff9d3cbe0a(1);
}

function function_b75dbbff9d3cbe0a(state) {
  level.var_a3c1a3a8df3469c0 |= state;
}

function function_7da79658b6525c11(state) {
  level.var_a3c1a3a8df3469c0 = state;
}

function function_94ffb636a243cf0e(state) {
  return level.var_a3c1a3a8df3469c0 &state;
}

function function_4dd5aaecf6acb8d7(state) {
  level.var_a3c1a3a8df3469c0 &= ~state;
}

function function_b5eb90c4bf658113() {
  level endon("game_ended");

  while(true) {
    level waittill("stealth_combat", stealth_group);
    level thread validate_stealth_claim(stealth_group);
  }
}

function validate_stealth_claim(stealth_group) {
  if(isDefined(stealth_group)) {
    level notify("validate_stealth_claim" + stealth_group);
    level endon("validate_stealth_claim" + stealth_group);
  } else {
    level notify("validate_stealth_claim");
    level endon("validate_stealth_claim");
  }

  msg = waittill_any_timeout_1(2.5, "stealth_combat_validated");

  if(isDefined(level.var_ef796ac0b0326726) && isfunction(level.var_ef796ac0b0326726)) {
    level thread[[level.var_ef796ac0b0326726]](stealth_group);
  }

  if(!function_94ffb636a243cf0e(4)) {
    if(function_e39a555170607456()) {
      iprintln("<dev string:xb8>");
    }

    function_b75dbbff9d3cbe0a(4);
    return;
  }

  if(function_e39a555170607456()) {
    iprintln("<dev string:xce>");
  }
}

function set_maxvisibledist(value) {
  self.maxvisibledist = value;
}

function init_event_distances() {
  array["spotted"]["death"] = function_9d30fd63965bafa9("death");
  array["hidden"]["death"] = 512;
  array["spotted"]["pain"] = function_9d30fd63965bafa9("pain");
  array["hidden"]["pain"] = 256;
  array["spotted"]["explosion"] = function_9d30fd63965bafa9("explosion");
  array["hidden"]["explosion"] = 2048;
  array["spotted"]["bullet"] = function_9d30fd63965bafa9("bullet");
  array["hidden"]["bullet"] = 64;
  array["spotted"]["footstep_walk"] = function_9d30fd63965bafa9("footstep_walk");
  array["hidden"]["footstep_walk"] = 50;
  array["spotted"]["footstep"] = function_9d30fd63965bafa9("footstep");
  array["hidden"]["footstep"] = 100;
  array["spotted"]["footstep_sprint"] = function_9d30fd63965bafa9("footstep_sprint");
  array["hidden"]["footstep_sprint"] = 400;
  array["spotted"]["gunshot"] = function_9d30fd63965bafa9("gunshot");
  array["hidden"]["gunshot"] = 1500;
  array["spotted"]["silenced_shot"] = function_9d30fd63965bafa9("silenced_shot");
  array["hidden"]["silenced_shot"] = 180;
  array["spotted"]["glass_destroyed"] = function_9d30fd63965bafa9("glass_destroyed");
  array["hidden"]["glass_destroyed"] = 384;
  array["spotted"]["gunshot_teammate"] = function_9d30fd63965bafa9("gunshot_teammate");
  array["hidden"]["gunshot_teammate"] = 1500;
  array["spotted"]["new_enemy"] = 128;
  array["hidden"]["new_enemy"] = 128;
  scripts\stealth\manager::set_event_distances(array);
}

function function_fe683c90ead4e88b() {
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");
  hiddenranges["prone"] = 600;
  hiddenranges["crouch"] = 800;
  hiddenranges["stand"] = 1200;
  var_b6b642cbeff52b88["prone"] = 150;
  var_b6b642cbeff52b88["crouch"] = 350;
  var_b6b642cbeff52b88["stand"] = 600;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 1800;
  spottedranges["crouch"] = 2400;
  spottedranges["stand"] = 4200;
  var_d0f35fc0a5c3df79["prone"] = 250;
  var_d0f35fc0a5c3df79["crouch"] = 1000;
  var_d0f35fc0a5c3df79["stand"] = 1800;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  scripts\stealth\utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  scripts\stealth\utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
  event_distances["spotted"]["explosion"] = 2500;
  event_distances["hidden"]["explosion"] = 2500;
  event_distances["spotted"]["gunshot"] = 4000;
  event_distances["hidden"]["gunshot"] = 4000;
  event_distances["spotted"]["gunshot_teammate"] = 4000;
  event_distances["hidden"]["gunshot_teammate"] = 4000;
  scripts\stealth\manager::set_custom_distances(event_distances);
}

function function_fcff6df987be068c() {
  var_262770259c50b3ad = getdvarint(@ "hash_52500d90411d2058", 828);
  var_d80639aa5ae9958a = getdvarint(@ "hash_3c1be1756fb521c7", 768);
  var_661edf1ef9fd9c38 = getdvarint(@ "hash_b70103e1c59e5dbd", 700);
  var_5f12d85ab5dc2c0d = getdvarint(@ "hash_ff951e1686e0157c", 640);
  combatradius = getdvarint(@ "hash_fa1ba7ea176f6c82", 512);
  self.smellradiussq = var_d80639aa5ae9958a * var_d80639aa5ae9958a;
  self.smellouterradiussq = var_262770259c50b3ad * var_262770259c50b3ad;
  self.barkradiussq = var_5f12d85ab5dc2c0d * var_5f12d85ab5dc2c0d;
  self.barkouterradiussq = var_661edf1ef9fd9c38 * var_661edf1ef9fd9c38;
  self.combatradiussq = combatradius * combatradius;
}

function grenade_exploded_during_stealth_listener() {
  level endon("game_ended");
  level notify("grenade_exploded_during_stealth_listener");
  level endon("grenade_exploded_during_stealth_listener");

  if(true) {
    return;
  }

  while(true) {
    level waittill("grenade_exploded_during_stealth", grenade, grenade_type, grenade_owner_name);

    switch (grenade_type) {
      case #"hash_432644fc4753dde9":
      case #"hash_435258fc47768fa7":
      case #"hash_6a2e4f9c54756dc7":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case #"hash_2b6e2f3f1de3ae32":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case #"hash_5e4ccaa178cac19c":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case #"hash_ab3485fa6834de47":
        level.last_molotov_explode_time = gettime();
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case #"hash_56ee829cc162271a":
      case #"hash_c46d19aa871781fa":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case #"hash_4b87af60037f526f":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1.8, grenade_owner_name);
        break;
      case #"hash_34f28162f0f54c6e":
        level.var_db1b17b1caad25db = gettime();
        nearby_ai_investigate_grenade(1048576, 1, grenade, grenade_type, &should_enter_combat_after_checking_throwingknife, grenade_owner_name);
        break;
      case #"hash_5e8f81314553dd36":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.6, grenade_owner_name);
        break;
      case #"hash_4c7de5619284e175":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.6, grenade_owner_name);
        break;
      case #"hash_d072a0adddda0068":
        level.last_flash_explode_time = gettime();
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.6, grenade_owner_name);
        break;
      case #"hash_34e7a4cd11aed6bc":
        level.var_12a10c9b8e19df0 = gettime();
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.75, grenade_owner_name);
        break;
      case #"hash_e3575fdd14663ca9":
        nearby_ai_investigate_grenade(4194304, 2, grenade, grenade_type, &should_enter_combat_after_checking_smoke_grenade, grenade_owner_name);
        break;
      case #"hash_aec9c140fca96664":
        level.var_2445992238654014 = gettime();
        nearby_ai_investigate_grenade(4194304, 2, grenade, grenade_type, &should_enter_combat_after_checking_snapshot_grenade, grenade_owner_name);
        break;
      case #"hash_4cd748aa3895508a":
        nearby_ai_investigate_grenade(4194304, 2, grenade, grenade_type, &should_enter_combat_after_checking_gas_grenade, grenade_owner_name);
        break;
      case #"hash_9ca85335d506dad6":
        nearby_ai_investigate_grenade(9437184, 2, grenade, grenade_type, &should_enter_combat_after_checking_decoy_grenade, grenade_owner_name);
        break;
      default:
        return;
    }
  }
}

function function_663719d74fbec07f(ai, pos) {
  event = spawnStruct();
  event.typeorig = "explosion";
  event.investigate_pos = pos;
  event.origin = pos;
  event.type = "combat";
  ai[[ai.fnsetstealthstate]]("combat", event);
}

function nearby_ai_combat_via_grenade(var_33621118e3427b21, var_fc8aecb0c985e3f8, grenade, var_96c5db7b1e2f5891, grenade_owner_name) {
  if(level_should_run_sp_stealth()) {
    if(!isDefined(grenade_owner_name)) {
      if(isvector(grenade)) {
        player_who_most_likely_broke_stealth = get_player_who_most_likely_broke_stealth(grenade, &get_player_who_most_recently_threw_grenade);
      } else {
        player_who_most_likely_broke_stealth = get_player_who_most_likely_broke_stealth(grenade.origin, &get_player_who_most_recently_threw_grenade);
      }

      grenade_owner_name = player_who_most_likely_broke_stealth.name;
    }

    wait var_96c5db7b1e2f5891;

    if(isvector(grenade)) {
      nearby_ais = get_ai_within_range(grenade, var_33621118e3427b21, var_fc8aecb0c985e3f8);
    } else {
      nearby_ais = get_ai_within_range(grenade.origin, var_33621118e3427b21, var_fc8aecb0c985e3f8);
    }

    foreach(nearby_ai in nearby_ais) {
      if(isvector(grenade)) {
        thread function_663719d74fbec07f(nearby_ai, grenade);
        continue;
      }

      thread function_663719d74fbec07f(nearby_ai, grenade.origin);
    }

    return;
  }

  if(!isDefined(grenade_owner_name)) {
    if(isvector(grenade)) {
      player_who_most_likely_broke_stealth = get_player_who_most_likely_broke_stealth(grenade, &get_player_who_most_recently_threw_grenade);
    } else {
      player_who_most_likely_broke_stealth = get_player_who_most_likely_broke_stealth(grenade.origin, &get_player_who_most_recently_threw_grenade);
    }

    grenade_owner_name = player_who_most_likely_broke_stealth.name;
  }

  wait var_96c5db7b1e2f5891;

  if(isvector(grenade)) {
    nearby_ais = get_ai_within_range(grenade, var_33621118e3427b21, var_fc8aecb0c985e3f8);
  } else {
    nearby_ais = get_ai_within_range(grenade.origin, var_33621118e3427b21, var_fc8aecb0c985e3f8);
  }

  foreach(nearby_ai in nearby_ais) {
    if(isDefined(get_current_stealth_state(nearby_ai))) {
      nearby_ai change_stealth_state_to_combat_warpper(nearby_ai, grenade_owner_name, "enemies_are_alerted");
    }
  }
}

function nearby_ai_investigate_grenade(var_33621118e3427b21, var_fc8aecb0c985e3f8, grenade, grenade_type, var_c7259036623763c1, grenade_owner_name) {
  if(level_should_run_sp_stealth()) {
    return;
  }

  nearby_ais = get_ai_within_range(grenade.origin, var_33621118e3427b21, var_fc8aecb0c985e3f8);

  foreach(nearby_ai in nearby_ais) {
    if(is_ai_in_stealth(nearby_ai)) {
      enemy_ai_enter_alert_due_to_grenade_explode(nearby_ai, grenade, grenade_type, var_c7259036623763c1, grenade_owner_name);
    }
  }
}

function enemy_ai_enter_alert_due_to_grenade_explode(enemy_ai, var_b5aad1bf0db6d8d4, reason_string, var_c7259036623763c1, grenade_owner_name) {
  if(get_current_stealth_state(enemy_ai) != "alert") {
    enemy_ai thread change_stealth_state_to(enemy_ai, "alert");
  }
}

function get_ai_within_range(center_loc, range_sq, var_fc8aecb0c985e3f8) {
  result = [];
  ai_within_range = [];
  all_ais = getaiarray("axis");

  foreach(ai in all_ais) {
    if(distancesquared(center_loc, ai.origin) <= range_sq) {
      ai_within_range[ai_within_range.size] = ai;
    }
  }

  ai_within_range = sortbydistance(ai_within_range, center_loc);
  var_aea70742c9f555f3 = int(min(ai_within_range.size, var_fc8aecb0c985e3f8));

  for(i = 0; i < var_aea70742c9f555f3; i++) {
    result[i] = ai_within_range[i];
  }

  return result;
}

function should_enter_combat_after_checking_throwingknife(throwingknife) {
  return false;
}

function should_enter_combat_after_checking_snapshot_grenade(snapshot_grenade) {
  return false;
}

function should_enter_combat_after_checking_smoke_grenade(var_7f8d26b0cc303cd3) {
  return isDefined(var_7f8d26b0cc303cd3);
}

function should_enter_combat_after_checking_gas_grenade(var_a241727d55a4c2f8) {
  return isDefined(var_a241727d55a4c2f8);
}

function should_enter_combat_after_checking_decoy_grenade(decoy_grenade) {
  return isDefined(decoy_grenade);
}

function function_d15bb6bdcb366a27(event) {
  if(isDefined(event) && isDefined(event.type)) {
    switch (event.type) {
      case #"hash_f796130a9b9cec5":
      case #"hash_9e02cd4a0f3ca981":
        if(isDefined(event.typeorig)) {
          switch (event.typeorig) {
            case #"hash_641050446d8ad59e":
              if(event.type == "cover_blown") {
                scripts\stealth\utility::set_event_override("should_ignore", undefined);
                scripts\cp\spawning::set_goal_radius(1024);
                return 0;
              }
            case #"hash_1d0022d9b49074c0":
            case #"hash_1de3ab20a61203e4":
            case #"hash_40e5cc134d32e10e":
            case #"hash_412938e72fd9ab35":
            case #"hash_9567f12963cd5717":
            case #"hash_9e02cd4a0f3ca981":
            case #"hash_9ef2596c4c4ce657":
            case #"hash_c5c143ba1ce58744":
            case #"hash_c910677ee9c31085":
            case #"hash_de811d1d5fa7e6b4":
            case #"hash_ea10345acf995244":
            case #"hash_f4eac828cdfe2da9":
              return 1;
            case #"hash_3e323a3a6f36e18b":
            default:
              scripts\stealth\utility::set_event_override("should_ignore", undefined);
              scripts\cp\spawning::set_goal_radius(1024);
              return 0;
          }
        } else {
          scripts\stealth\utility::set_event_override("should_ignore", undefined);
          scripts\cp\spawning::set_goal_radius(1024);
          return 0;
        }
      default:
        return 1;
    }

    return;
  }

  return 1;
}

function function_de5486dc9107107c(dir, active, spotted) {
  if(!isDefined(self.var_f5c2aeceb96a7d6b)) {
    self.var_f5c2aeceb96a7d6b = gettime();
  }

  if(gettime() >= self.var_f5c2aeceb96a7d6b) {
    if(istrue(active) && !istrue(spotted)) {
      self notify("stealth_hud_updated");
      self.var_f5c2aeceb96a7d6b = gettime() + 5000;
    }
  }
}

function function_a38fad5164d90667() {
  return [2, 1, 0];
}

function function_c72b7181608c8607(var_42012dd2e8ee7c69, var_e085cf82adc280a3, forced_delay) {
  if(!isDefined(var_42012dd2e8ee7c69)) {
    if(function_e39a555170607456()) {
      iprintln("<dev string:xf6>");
    }

    return;
  }

  if(!isDefined(level.var_1d4c5a0449d1c023)) {
    level.var_1d4c5a0449d1c023 = 0;
  }

  level.var_1d4c5a0449d1c023++;

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    setomnvar("num_bombs_planted", level.var_1d4c5a0449d1c023);

    if(level.var_1d4c5a0449d1c023 <= 1) {
      scripts\cp\star_rewards::function_26dc2f0b0bd90e86(2);
    } else {
      scripts\cp\star_rewards::function_26dc2f0b0bd90e86(1);
    }
  }

  game["stealth_was_broken"] = 1;

  if(isDefined(forced_delay)) {
    wait forced_delay;
  }

  org = undefined;

  if(isvector(var_42012dd2e8ee7c69)) {
    org = var_42012dd2e8ee7c69;
  } else {
    org = var_42012dd2e8ee7c69.origin;
  }

  pos = spawn("script_origin", org);

  if(!istrue(var_e085cf82adc280a3)) {
    while(!pos isnearanyplayer(2500)) {
      wait 0.1;
    }
  }

  pos playLoopSound("milbase_alarm");

  if(getdvarint(@ "hash_b14f25e83a3e8215", 0) != 0) {
    thread function_795560a1304fc900(pos);
  }

  wait 11;
  pos stoploopsound();
  pos delete();
}

function function_795560a1304fc900(ent) {
  ent endon("death");
  origin = ent.origin;
  nearbyai = getaiarrayinradius(origin, 2500, "axis");

  foreach(ai in nearbyai) {
    if(ai[[ai.fnisinstealthcombat]]()) {
      continue;
    }

    foreach(player in level.players) {
      ai aieventlistenerevent("combat", player, player.origin);
      ai getenemyinfo(player);
    }
  }
}

function function_ba975873cb8e4618() {
  wait 5;

  if(function_1fcfec6aecf17a41()) {
    return 1;
  }
}

function function_53c55a0c7af36050() {
  level.shots_fired = [];
  level.var_6baf074ba0f09afc = [];
  level.entered_hunt = [];
  level.entered_combat = [];
  level.entered_investigate = [];
  level.killed_ai = [];
}

function function_18cd746ff947ff3c(region) {
  level.shots_fired[region] = 0;
  level.entered_hunt[region] = 0;
  level.entered_combat[region] = 0;
  level.entered_investigate[region] = 0;
  level.killed_ai[region] = 0;
  level.var_6baf074ba0f09afc = array_add(level.var_6baf074ba0f09afc, region);
}

function function_52d8a3ce21f0dfe8(region) {
  level.shots_fired[region] = 0;
  level.entered_hunt[region] = 0;
  level.entered_combat[region] = 0;
  level.entered_investigate[region] = 0;
  level.killed_ai[region] = 0;
}

function function_16e012e4220410f6(region) {
  level.var_6baf074ba0f09afc = array_remove(level.var_6baf074ba0f09afc, region);
}

function function_1b1663a65690a44a(region, delay, var_1d6462b67c5ed471) {
  if(isDefined(var_1d6462b67c5ed471)) {
    self endon("death");
  }

  wait delay;
  var_2a54763b46ecd8d7 = function_9d30fd63965bafa9("gunshot", self);

  if(isDefined(var_1d6462b67c5ed471) && isvector(var_1d6462b67c5ed471)) {
    if(distance2d(var_1d6462b67c5ed471.origin, self.origin) < var_2a54763b46ecd8d7) {
      level.shots_fired[region]++;
    }

    return;
  }

  level.shots_fired[region]++;
}

function stealth_watchweaponfired(region) {
  self endon("death");
  self notify("stealth_watchWeaponFired");
  self endon("stealth_watchWeaponFired");

  while(true) {
    self waittill("weapon_fired");
    thread function_1b1663a65690a44a(region, 0.05);
  }
}

function stealth_watchaigoingintocombat(region) {
  self endon("death");
  self notify("stealth_watchAIGoingIntoCombat");
  self endon("stealth_watchAIGoingIntoCombat");

  while(true) {
    self waittill("stealth_combat");
    level thread function_a5464841fa1292fe("combat", region, 0.05);
  }
}

function function_a5464841fa1292fe(type, obj, delay) {
  wait delay;

  switch (type) {
    case #"hash_37bb23543c319104":
      level.entered_hunt[obj]++;
      break;
    case #"hash_9e02cd4a0f3ca981":
      level.entered_combat[obj]++;
      break;
    case #"hash_e21b072df2b47f94":
      level.entered_investigate[obj]++;
      break;
    case #"hash_b216c9cbf6b56ed0":
      level.killed_ai[obj]++;
      break;
  }
}

function function_1fcfec6aecf17a41() {
  foreach(region in level.var_6baf074ba0f09afc) {
    if(level.shots_fired[region] > 1) {
      return true;
    }
  }

  return false;
}

function function_2cdd250ebe64308f(agenttype, origin, dormancyid) {
  infopackage = function_2b0e82156fa6075b(dormancyid);
  function_760792071513b00d(dormancyid);

  if(!isDefined(infopackage)) {
    println("<dev string:x128>");
    return;
  }

  aitype = infopackage.aitype;
  origin = infopackage.origin;
  angles = infopackage.angles;
  priority = function_72d6808216b4d44(infopackage.priority);
  category = infopackage.category;
  subcategory = infopackage.subcategory;
  groupname = infopackage.groupname;
  team = infopackage.team;
  destination = undefined;
  poiname = infopackage.poi;
  skipstealth = infopackage.skipstealth;
  behaviorpackage = infopackage.behaviorpackage;
  var_80f4bde7090a4773 = infopackage.var_80f4bde7090a4773;
  spawnfunctions = infopackage.functionsonspawn;
  var_8a76b06617613d30 = getsharedfunc("ai_mp_controller", "ai_mp_requestSpawnAgent");
  agent = [[var_8a76b06617613d30]](aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, 1, undefined, var_80f4bde7090a4773);

  if(isDefined(agent)) {
    agent.behaviorpackage = behaviorpackage;
    behavior_executebehaviorpackage = getsharedfunc("ai_mp_controller", "behavior_executeBehaviorPackage");
    [[behavior_executebehaviorpackage]](agent);
    agent.functionsonspawn = spawnfunctions;
    function_e662189d61d1874e(agent);
  }
}

function function_418b248fc7829336() {
  scripts\cp_mp\agents\agent_utils::function_b04c0433e8107615();
  level.var_74e9c02b56e4ba52 = &function_2cdd250ebe64308f;
  level.var_8a42b71f799936ad = &function_a362af8fe3c74d33;
  level.var_fe093e9b2b6c3751 = getdvarint(@ "hash_320c4db6af00b215", 0);
  level.var_53db9bacadef066d = spawnStruct();
  level.var_53db9bacadef066d.var_d4053e1a1d2983ce = 0;
  level.var_879053468f168806 = [];
}

function function_a362af8fe3c74d33(agent, dormancyid) {
  aitype = agent.agent_type;
  origin = agent.origin;
  angles = agent.angles;
  priority = agent.priority;
  category = agent.category;
  subcategory = agent.subcategory;
  groupname = agent.script_stealthgroup;
  team = agent.team;
  destination = undefined;
  poiname = agent.poi;
  skipstealth = !agent.stealth_enabled;
  behaviorpackage = agent.behaviorpackage;
  var_80f4bde7090a4773 = agent.var_80f4bde7090a4773;
  spawnfunctions = agent.functionsonspawn;

  if(isDefined(behaviorpackage) && behaviorpackage.behavior == "cqb" && isDefined(behaviorpackage.cqbnodes)) {
    foreach(node in behaviorpackage.cqbnodes) {
      if(isDefined(node)) {
        node.claimed = 0;
      }
    }
  }

  infopackage = function_e83d1f023a2609ff(aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, behaviorpackage, var_80f4bde7090a4773, spawnfunctions);
  function_7a9172605e0228df(dormancyid, infopackage);
}

function function_778f9d9e0731e729() {
  level endon("gane_ended");

  while(true) {
    level waittill("trigger_reinforcements_if_applicable");

    if(isDefined(level.var_42354bfd2f2f8439)) {
      level thread[[level.var_42354bfd2f2f8439]]();
    }
  }
}