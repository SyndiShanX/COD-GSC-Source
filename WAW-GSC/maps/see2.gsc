/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see2.gsc
**************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#include maps\pel2_util;
#include maps\_vehicle_utility;
#include maps\see2_threat;
#include maps\_grenade_toss;
#include maps\_music;
#include maps\see2_vehicle_behavior;
#include maps\see2_fortifications;
#include maps\see2_sound;
#include maps\_busing;

main() {
  precachemodel("vehicle_ger_tracked_panzer4_d_turret");
  precachemodel("vehicle_ger_tracked_panther_d_turret");
  precachemodel("vehicle_ger_tracked_king_tiger_d_turret");
  precachemodel("vehicle_ger_tracked_panzer4v1_dmg1");
  precachemodel("vehicle_ger_tracked_panther_dmg1");
  precachemodel("vehicle_ger_tracked_king_tiger_dmg1");
  precachemodel("katyusha_rocket");

  precachemodel("weapon_rus_reznov_knife");
  precachemodel("weapon_rus_mosinnagant_rifle");

  precacheRumble("tank_damage_heavy_mp");
  precacheRumble("tank_damage_light_mp");

  level.campaign = "russian";

  maps\_see2_panther::main("vehicle_ger_tracked_panther");
  maps\_see2_ot34::main("vehicle_rus_tracked_ot34");
  maps\_see2_t34::main("vehicle_rus_tracked_t34");
  maps\_see2_physics_t34::main("vehicle_rus_tracked_ot34");
  maps\_see2_tiger::main("vehicle_ger_tracked_king_tiger");
  maps\_see2_panzeriv::main("vehicle_ger_tracked_panzer4v1");
  maps\_truck::main("vehicle_ger_wheeled_covered_opel_blitz", "opel");
  maps\_see2_flak88::main("artillery_ger_flak88");
  maps\_aircraft::main("vehicle_rus_airplane_il2", "il2", 0, false);

  precachemodel("weapon_machinegun_tiger");
  precachemodel("vehicle_rus_tracked_ot34_d");
  precacheturret("allied_hull_flamethrower");

  precachestring(&"SEE2_FLAMETHROWER_HINT");
  precachestring(&"SEE2_MG_COOP_HINT");
  precachestring(&"SEE2_ADS_HINT");

  default_start(::field_begin);
  add_start("radio_tower", ::radio_tower_begin, &"STARTS_SEE2_RADIOTOWER");
  add_start("fuel_depot", ::fuel_depot_begin, &"STARTS_SEE2_FUELDEPOT");
  add_start("air_strike", ::air_strike_begin, &"STARTS_SEE2_AIRSTRIKE");

  level.drones_per_wave = 8;

  setup_level();

  maps\_drone::init();

  level.max_drones["allies"] = 32;
  level.max_drones["axis"] = 32;

  maps\see2_fx::main();
  maps\see2_drones::main();
  maps\see2_anim::main();
  maps\see2_breadcrumbs::main();
  maps\see2_amb::main();

  maps\_load::main();

  level thread difficulty_scale();
  level init_level_flags();
  thread tune_max_ai_numbers();

  level tune_ai();

  level.enemy_armor = [];
  level.death_bucket = [];
  level.enemy_infantry = [];
  level.line_queue = [];
  level.identified_entities = [];

  level.radio_tower_goal_nodes = GetNodeArray("radio tower goal", "script_noteworthy");
  level.fuel_depot_goal_nodes = GetNodeArray("fuel depot goal", "script_noteworthy");

  level.custom_target = undefined;

  level.vehicle_death_thread = [];
  level.vehicle_death_thread["see2_panzeriv"] = maps\see2_vehicle_behavior::see2_veh_death_thread;
  level.vehicle_death_thread["see2_tiger"] = maps\see2_vehicle_behavior::see2_veh_death_thread;
  level.vehicle_death_thread["see2_panther"] = maps\see2_vehicle_behavior::see2_veh_death_thread;

  level.finished_events = [];
  thread do_friendly_consistency_check();
  thread do_radio_tower_explode();
  level thread wait_for_finalbattle_alternate();

  level.centroid = undefined;
  level thread keep_track_of_player_centroid();
  level thread wait_for_dialog_triggers();
  level thread see2_handleLineQueue();

  level.retreat_points = [];
  level.retreat_points = array_add(level.retreat_points, "radio tower");
  level.retreat_points = array_add(level.retreat_points, "fuel depot");
  level.retreat_points = array_add(level.retreat_points, "airstrike");

  level.invalid_retreat_points = [];

  level.time_between_dialogue = 9;
  level.dialogue_timer = 0;
  level.min_close_infantry_for_warning = 3;
  level.min_distance_for_close_infantry = 120;

  level.current_idle_time = 0;
  level.min_idle_dist_sq = 0.5;
  level.idle_warn_time = 10;
  level.num_idle_lines = 6;

  level thread update_dialogue_timer();
  level thread setup_achievement_spawn_func();
  level thread spawn_func_throttle_spawns();

  level.callbackSaveRestored = ::see2_callback_saveRestored;

  level thread debug_ai_prints();

  BadPlacesEnable(0);
}

tune_max_ai_numbers() {
  level.max_ai_spawn = 20;
  level.max_vehicles = 8;

  level.max_ai_spawn_current = 20;
  level.max_vehicle_spawn_current = 8;

  if(1) {
    return;
  }

  while(1) {
    current_number_of_vehicles = [];
    current_number_of_vehicles = getEntArray("script_vehicle", "classname");

    for(i = 0; i < current_number_of_vehicles.size; i++) {}

    wait(1);
  }
}
tune_ai() {
  level.number_miss_structs = 8;
  level.min_miss_distance = 150;
  level.max_miss_distance = 250;

  level.see2_max_tank_target_dist = 4000;
  level.see2_max_tank_firing_dist = 3500;

  level.retreat_threshold = 0.6;

  min_pzrsk_dist = 500;
  max_pzrsk_dist = 2500;
  level.min_panzerschreck_eng_distsq = min_pzrsk_dist * min_pzrsk_dist;
  level.max_panzerschreck_eng_distsq = max_pzrsk_dist * max_pzrsk_dist;
}
difficulty_scale() {
  switch (GetDifficulty()) {
    case "easy":
      level.see2_player_armor = 7500;
      level.see2_base_lag_time = 1;
      level.see2_max_targeters = 3;
      level.see2_percent_life_at_checkpoint = 1;
      level.time_before_regen = 9;
      level.no_shoot_increase = .05;
      break;

    case "medium":
      level.see2_player_armor = 6000;
      level.see2_base_lag_time = 0.75;
      level.see2_max_targeters = 3;
      level.see2_percent_life_at_checkpoint = 0.75;
      level.time_before_regen = 10;
      level.no_shoot_increase = .05;
      break;

    case "hard":
      level.see2_player_armor = 4500;
      level.see2_base_lag_time = 0.5;
      level.see2_max_targeters = 4;
      level.see2_percent_life_at_checkpoint = 0.5;
      level.time_before_regen = 11;
      level.no_shoot_increase = .03;
      break;

    case "fu":
      level.see2_player_armor = 3000;
      level.see2_base_lag_time = 0.25;
      level.see2_max_targeters = 4;
      level.see2_percent_life_at_checkpoint = 0.5;
      level.time_before_regen = 12;
      level.no_shoot_increase = .01;
      break;
  }

  level.armor_per_frame = int(level.see2_player_armor / level.time_before_regen / 20);
}
keep_track_of_achievement() {
  water_tower_trigs = getEntArray("water_tower_trig", "targetname");
  for(i = 0; i < water_tower_trigs.size; i++) {
    water_tower_trigs[i] thread track_water_tower_triggers();
  }

  water_tower_number = 3;
  bunker_number = 5;
  schreck_number = 14;

  water_tower_achievement = 0;
  bunker_achievement = 0;
  schreck_tower_achievement = 0;

  while(1) {
    level waittill("achievement_destroy_notify", item);

    switch (item) {
      case "water_tower":
        water_tower_achievement++;
        break;

      case "bunker":
        bunker_achievement++;
        break;

      case "schreck_tower":
        schreck_tower_achievement++;
        break;

      default:
        break;
    }

    if(water_tower_achievement >= water_tower_number && bunker_achievement >= bunker_number && schreck_tower_achievement >= schreck_number) {
      break;
    }
  }

  players = get_players();

  for(i = 0; i < players.size; i++) {
    players[i] maps\_utility::giveachievement_wrapper("SEE2_ACHIEVEMENT_TOWER");
  }
}

track_water_tower_triggers() {
  self waittill("trigger");
  level notify("achievement_destroy_notify", "water_tower");
}

setup_achievement_spawn_func() {}

spawn_func_throttle_spawns() {
  ai_array = GetSpawnerArray();

  for(i = 0; i < ai_array.size; i++) {
    ai_array[i] add_spawn_function(::throttle_ai_make_room);
  }
}

throttle_ai_keep_time() {
  self endon("death");

  while(true) {
    self.see2_life_time += 0.001;
    wait(0.1);
  }
}

throttle_ai_make_room() {
  ai = GetAIArray("axis");

  for(i = 0; i < ai.size; i++) {
    if(!isDefined(ai[i].see2_life_time)) {
      ai[i].see2_life_time = 0;
      ai[i] thread throttle_ai_keep_time();
    }
  }

  if(ai.size > level.max_ai_spawn_current) {
    ai = sort_ai_by_life_time(ai);
    num_ai_to_remove = ai.size - level.max_ai_spawn_current;

    for(i = 0; i < num_ai_to_remove; i++) {
      random_wait = RandomFloatRange(0.1, 1.0);
      ai[i] thread bloody_death(random_wait);
    }
  }
}

sort_ai_by_life_time(nodes) {
  for(i = 0; i < nodes.size; i++) {
    for(j = i; j < nodes.size; j++) {
      if(nodes[j].see2_life_time > nodes[i].see2_life_time) {
        temp = nodes[i];
        nodes[i] = nodes[j];
        nodes[j] = temp;
      }
    }
  }

  return nodes;
}
keep_track_of_player_centroid() {
  wait_for_first_player();
  while(1) {
    players = get_players();
    num_players = players.size;
    total = undefined;
    for(i = 0; i < num_players; i++) {
      if(!isDefined(total)) {
        total = players[i].origin;
      } else {
        total = total + players[i].origin;
      }
    }
    level.centroid = total / num_players;
    wait(3);
  }
}
keep_grenade_bags_from_spawning() {
  self endon("death");

  while(1) {
    level.nextGrenadeDrop = 9999;
    wait(0.05);
  }
}
setup_flak88_guard() {
  self.ignoreall = true;
}
wait_for_group_spawn(group) {
  trigger = GetEnt("group " + group + " spawn", "script_noteworthy");
  trigger thread inform_on_touch_trigger(trigger.script_noteworthy);
  level waittill(trigger.script_noteworthy);

  if(flag(level.skipto_flag_names[group])) {
    return;
  }

  do_area_spawn(group);
}
do_friendly_consistency_check() {
  names = [];
  names[0] = "friendly 1";
  names[1] = "friendly 2";
  names[2] = "friendly 3";

  advance_triggers = getEntArray("friendly advance trigger", "script_noteworthy");

  for(i = 0; i < advance_triggers.size; i++) {
    advance_nodes = GetVehicleNodeArray(advance_triggers[i].script_noteworthy, "script_noteworthy");
    if(advance_nodes.size != 3) {
      iprintlnbold("Insufficient advance nodes for trigger " + advance_triggers[i].script_noteworthy);
    }
    for(j = 0; j < names.size; j++) {
      found = false;
      for(k = 0; k < advance_nodes.size; k++) {
        if(advance_nodes[k].script_string == names[j]) {
          found = true;
          break;
        }
      }
      if(!found) {
        iprintlnbold("Advance node " + advance_triggers[i].script_noteworthy + " does not exist for ent " + names[j]);
      }
    }
  }
}
see2_callback_saveRestored() {
  maps\_callbackglobal::Callback_SaveRestored();

  for(i = 0; i < get_players().size; i++) {
    if((get_players()[i].myTank.armor / get_players()[i].myTank.maxarmor) < 0.5) {
      get_players()[i].myTank.armor = get_players()[i].myTank.maxarmor * level.see2_percent_life_at_checkpoint;
    }
  }
}
explosive_damage(type) {
  return (issubstr(type, "GRENADE") || issubstr(type, "PROJECTILE") || issubstr(type, "EXPLOSIVE") || issubstr(type, "BURNED"));
}
inform_on_touch_trigger(event) {
  self waittill("trigger");
  level notify(event);
}
inform_on_damage_trigger(event) {
  while(1) {
    self waittill("damage", damage, other, direction, origin, damage_type);
    if(explosive_damage(damage_type)) {
      if(isDefined(other.script_team) && other.script_team == "allies") {
        level notify(event);
        return;
      }
    }
    wait(0.05);
  }
}
is_in_player_arc(player) {
  myOrigin = (self.origin[0], self.origin[1], 0);
  playerOrigin = (player.origin[0], player.origin[1], 0);
  diff = myOrigin - playerOrigin;
  angles = vectortoangles(diff);
  if(abs(angles[1] - player.angles[1]) > 32.5) {
    return true;
  }
  return false;
}
setup_level() {
  CreateThreatBiasGroup("players");
  create_see2_threat_group("players");
  CreateThreatBiasGroup("player tanks");
  create_see2_threat_group("player tanks");
  CreateThreatBiasGroup("enemy antitank");
  create_see2_threat_group("enemy antitank");
  CreateThreatBiasGroup("enemy infantry");
  create_see2_threat_group("enemy infantry");
  CreateThreatBiasGroup("friendly antitank");
  create_see2_threat_group("friendly antitank");
  CreateThreatBiasGroup("friendly infantry");
  create_see2_threat_group("friendly infantry");
  CreateThreatBiasGroup("friendly armor");
  create_see2_threat_group("friendly armor");
  create_see2_threat_group("enemy armor");

  SetThreatBias("player tanks", "enemy antitank", 10000);
  SetThreatBias("friendly armor", "enemy antitank", 15000);
  SetIgnoreMeGroup("players", "enemy infantry");
  SetIgnoreMeGroup("players", "enemy antitank");
  SetIgnoreMeGroup("friendly armor", "enemy infantry");
}
setup_player_tanks() {
  entry_points = [];
  for(i = 0; i < 4; i++) {
    entry_points = array_add(entry_points, getstruct("orig_enter_tanks" + (i + 1), "targetname"));
  }

  for(i = 0; i < entry_points.size; i++) {
    tank = getent(entry_points[i].target, "targetname");
    if(isDefined(get_players()[i])) {
      tank.animname = "ot34";

      if(i == 2) {
        flag_set("coop");
      }

      get_players()[i] setOrigin(tank gettagorigin("tag_enter_driver"));
      get_players()[i] setThreatBiasGroup("players");
      tank makevehicleunusable();

      tank makevehicleusable();

      tank useby(get_players()[i]);
      get_players()[i].mytank = tank;

      tank thread update_current_targeters();

      delta = maps\see2_breadcrumbs::add_new_breadcrumb_ent(tank, 10, 200);
      if(isDefined(delta)) {
        tank.my_targeting_delta = delta;
      }

      tank thread vehicle_damage();
      tank thread disconnect_paths_around_me_based_on_speed();

      tank thread friendly_fire_kill_tank();

      tank thread keep_tank_alive();
    } else {
      level.player_tanks = array_remove(level.player_tanks, tank);
      old_script_int = tank.script_int;
      tank delete();
      spawn_trigger = getEnt("friendly " + i + " spawn_trigger", "script_noteworthy");
      move_trigger = getEnt("friendly " + i + " move_trigger", "script_noteworthy");
      spawn_trigger notify("trigger");
      wait(0.05);
      move_trigger notify("trigger");
      wait(0.05);
      new_tank = getEnt("friendly " + i, "script_noteworthy");
      level.player_tanks = array_add(level.player_tanks, new_tank);
      new_tank.script_int = i;
      new_tank setSpeed(0, 1000, 1000);
      new_tank thread do_player_support();
      new_tank thread cleanup_targeting();
      new_tank maps\_vehicle::mgoff();
      new_tank.current_node = getVehicleNode("friendly " + i + " start", "script_noteworthy");
    }
  }
}

triggered_drop_bad_areas() {
  self endon("death");

  while(1) {
    level waittill("ai_set_new_retreat_node");

    self_forward = anglesToForward(self.angles);
    self_right = AnglesToRight(self.angles);

    BadPlace_Cylinder("center", 10, self.origin, 64, 100, "axis");
    BadPlace_Cylinder("front_left", 10, self.origin + (self_forward * 62) - (self_right * 62), 64, 100, "axis");
    BadPlace_Cylinder("front_right", 10, self.origin + (self_forward * 62) + (self_right * 62), 64, 100, "axis");
    BadPlace_Cylinder("rear_left", 10, self.origin - (self_forward * 62) - (self_right * 62), 64, 100, "axis");
    BadPlace_Cylinder("rear_right", 10, self.origin - (self_forward * 62) + (self_right * 62), 64, 100, "axis");

    wait(5);
  }
}

constant_drop_bad_place() {
  lifetime = 2;
  old_position = self.origin;

  while(1) {
    self_forward = anglesToForward(self.angles);
    self_right = AnglesToRight(self.angles);

    if(distanceSquared(self.origin, old_position) > 8 * 8) {
      BadPlace_Cylinder("center", lifetime, self.origin, 200, 100, "axis");

      old_position = self.origin;
      wait(1);
    } else {
      wait(0.1);
    }
  }
}

disconnect_paths_around_me_based_on_speed() {
  self endon("death");

  while(1) {
    while(self GetSpeed() > 1) {
      wait(0.05);
    }

    self DisconnectPaths();

    while(self GetSpeed() < 1) {
      wait(0.05);
    }

    self ConnectPaths();
  }
}
setup_delete_triggers() {
  delete_triggers = getEntArray("trigger_delete", "script_noteworthy");
  for(i = 0; i < delete_triggers.size; i++) {
    delete_triggers[i] thread do_delete_trigger();
  }
}
do_delete_trigger() {
  while(1) {
    self waittill("trigger", guy);
    guy delete();
    wait(0.05);
  }
}
setup_early_tanks() {
  flak88_guard_array = getEntArray("flak 88 guards", "script_noteworthy");
  array_thread(flak88_guard_array, ::add_spawn_function, ::setup_flak88_guard);

  flame_bunker_array = getEntArray("flame bunker one guard", "script_noteworthy");
  flame_bunker_array = array_combine(flame_bunker_array, getEntArray("flame bunker two guard", "script_noteworthy"));
  flame_bunker_array = array_combine(flame_bunker_array, getEntArray("flame bunker three guard", "script_noteworthy"));
  array_thread(flame_bunker_array, ::add_spawn_function, ::setup_flame_bunker_guard);

  thread do_flame_bunker("flame bunker one", "bunker one flamed", true, true, false, true);
  thread do_flame_bunker("flame bunker two", "bunker two flamed", true, true, true, true);
  thread do_flame_bunker("flame bunker three", "bunker three flamed", true);
  thread do_flame_bunker("flame bunker four", "bunker four flamed", true, true, true);
  thread do_flame_bunker("flame bunker six", "bunker six flamed", true, true, true);
  thread keep_grenade_bags_from_spawning();
  thread do_fake_schrecks();

  level.player_tanks = [];
  for(i = 0; i < 4; i++) {
    ent = getEnt("player_tank_" + (i + 1), "targetname");
    if(isDefined(ent)) {
      level.player_tanks = array_add(level.player_tanks, ent);
    }
  }

  for(i = 0; i < level.player_tanks.size; i++) {
    if(isDefined(level.player_tanks[i])) {
      level.player_tanks[i] thread keep_tank_alive();
    }
  }
  level thread setup_friendly_advance_triggers();
}
do_area_spawn(areaNum) {
  trigger_array = getEntArray("area" + areaNum + " spawn trigger", "targetname");
  for(i = 0; i < trigger_array.size; i++) {
    trigger_array[i] notify("trigger");
    wait_network_frame();
  }

  thread setup_spawngroup_generics(areaNum);
  thread do_fortification_spawn(areaNum);

  level notify("area" + areaNum + " spawned");
}
Log_Finished_Event(event, waittime) {
  if(isDefined(waittime)) {
    wait(waittime);
  }
  if(array_check_for_dupes(level.finished_events, event)) {
    level.finished_events = array_add(level.finished_events, event);
    level notify(event);
  }
}
begin_armor_regen() {
  self endon("damage");
  self endon("death");

  while(1) {
    if(self.armor > self.maxarmor) {
      self.armor = self.maxarmor;
    }
    if(self.armor == self.maxarmor) {
      break;
    }

    self.armor += level.armor_per_frame;
    wait(0.05);
  }
  self notify("armor_full");
}
check_for_flamethrower() {
  self endon("death");
  self endon("disconnect");
  self.myTank endon("death");
  self.mytank thread do_my_loop();
}
do_my_loop() {
  self endon("stop firing");

  while(1) {
    angles = self getTagAngles("tag_barrel");

    angles = (angles[0] - 5, angles[1], angles[2]);

    forward = anglesToForward(angles);

    target_vec = self getTagOrigin("tag_gunner_barrel1") + (forward * 50);

    self setGunnerTargetVec(target_vec, 0);

    wait(0.05);
  }
}
vehicle_damage() {
  self endon("death");
  players = get_players();
  vehicle_owner = self getvehicleowner();
  vehicle_owner endon("death");
  vehicle_owner endon("disconnect");

  myPlayer = undefined;
  for(i = 0; i < players.size; i++) {
    if(players[i] == vehicle_owner) {
      myPlayer = players[i];
    }
  }
  if(!isDefined(myPlayer)) {
    return;
  }

  self.armor = level.see2_player_armor;
  self.maxarmor = level.see2_player_armor;
  self.starty = 380;

  self thread do_veh_damage_hud();
  self thread do_veh_extra_damage_no_play();

  while(1) {
    self waittill("damage", amount, attacker);

    if(isGodMode(myPlayer)) {
      continue;
    }

    if(!array_check_for_dupes(get_players(), attacker) || !array_check_for_dupes(level.player_tanks, attacker)) {
      continue;
    }

    if(self.armor > 0) {
      dmg_faked = amount * self.do_extra_dmg_no_fire;

      if(isDefined(self.too_close_damage_modifier)) {
        dmg_faked = dmg_faked * self.too_close_damage_modifier;
      }

      self.armor -= dmg_faked;
    } else {
      self kill_tank();
    }

    if(isDefined(myPlayer)) {
      hurtTime = gettime();
      level.hurtTime = hurtTime;

      if(amount < 500) {
        myPlayer PlayRumbleOnEntity("tank_damage_light_mp");
      } else {
        myPlayer PlayRumbleOnEntity("tank_damage_heavy_mp");
      }

      myPlayer viewkick(127, attacker.origin);
      myPlayer player_flag_set("player_has_red_flashing_overlay");
      myPlayer startfadingblur(3, 2);

      playerJustGotRedFlashing = true;
    }
  }
}

do_veh_extra_damage_no_play() {
  self endon("death");

  if(!isDefined(self.do_extra_dmg_no_fire)) {
    self.do_extra_dmg_no_fire = 1;
  }

  while(1) {
    self thread do_veh_extra_damage_no_play_update();
    self waittill("weapon_fired");
    self.do_extra_dmg_no_fire = 1;
    wait(0.05);
  }
}

do_veh_extra_damage_no_play_update() {
  self endon("weapon_fired");
  wait(60);

  while(1) {
    if(self.do_extra_dmg_no_fire < 3) {
      self.do_extra_dmg_no_fire += level.no_shoot_increase;
      wait(5);
    } else {
      wait(10);
    }
  }
}
kill_tank() {
  if(get_players().size > 1) {
    self see2_fail_the_mission_coop();
    return;
  }

  self setModel("vehicle_rus_tracked_ot34_d");
  playFX(level._effect["tank_destruct"], self.origin);
  player = self getVehicleOwner();
  player freezeControls(true);
  wait(1);
  maps\_utility::missionFailedWrapper();
}

see2_fail_the_mission_coop() {
  self setModel("vehicle_rus_tracked_ot34_d");
  playFX(level._effect["tank_destruct"], self.origin);
  player = self getVehicleOwner();
  player freezeControls(true);

  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      players[i] thread maps\_quotes::displayMissionFailed();
      if(players[i] == player) {
        players[i] thread maps\_quotes::displayPlayerDead();
        println("Player #" + i + " is dead");
      } else {
        players[i] thread maps\_quotes::displayTeammateDead(player);
        println("Player #" + i + " is alive");
      }
    }
  }

  wait(1);
  maps\_utility::missionFailedWrapper();
}

friendly_fire_kill_tank() {
  player = self getVehicleOwner();

  if(!isPlayer(player)) {
    return;
  }

  player.friendlyfire_count = 0;
  player thread friendly_fire_kill_tank_reduce();

  while(1) {
    level waittill("friendly attacked by player", attacker);

    if(player == attacker) {
      player.friendlyfire_count++;
    }

    if(player.friendlyfire_count >= 3) {
      maps\_friendlyfire::missionfail();
    }
  }
}

friendly_fire_kill_tank_reduce() {
  self endon("death");

  while(1) {
    while(self.friendlyfire_count == 0) {
      wait(0.05);
    }

    wait(10);
    self.friendlyfire_count--;
  }
}
cleanup_damage_hud() {
  self waittill("stop damage hud");
}
do_veh_damage_hud() {
  self endon("death");

  vehicle_owner = self getvehicleowner();
  vehicle_owner endon("death");
  vehicle_owner endon("disconnect");
  vehicle_owner endon("stop damage hud");
  vehicle_owner thread cleanup_damage_hud();

  slow_flash_time = 1;
  slow_flash_color = (1, 1, 0);
  fast_flash_time = 0.5;
  fast_flash_color = (1, 0, 0);

  self thread regen_armor();

  current_time = 0;
  while(1) {
    percent = self.armor / self.maxarmor;
    if(percent < 0) {
      percent = 0;
    }

    if(percent > 0.1 && percent <= 0.25) {
      if(current_time >= slow_flash_time) {
        current_time = 0;
      }
      percent_flash = current_time / slow_flash_time;

      current_time += 0.05;
    } else if(percent < 0.1) {
      if(current_time >= fast_flash_time) {
        current_time = 0;
      }
      percent_flash = current_time / fast_flash_time;

      current_time += 0.05;
    } else {}

    self setHealthPercent(percent);

    wait(0.05);
  }
}
regen_armor() {
  self endon("death");

  self.time_since_last_damage = 0;

  self thread update_damage_timer();
  self thread wait_for_damage_events();

  while(1) {
    if(self.time_since_last_damage > level.time_before_regen) {
      self thread begin_armor_regen();
      self waittill_either("damage", "armor_full");
    }

    wait(0.05);
  }
}
update_damage_timer() {
  self endon("death");
  while(1) {
    self.time_since_last_damage += 0.05;
    wait(0.05);
  }
}
wait_for_damage_events() {
  self endon("death");
  while(1) {
    self waittill("damage");
    self.time_since_last_damage = 0;
    wait(0.05);
  }
}
update_dialogue_timer() {
  while(1) {
    level.dialogue_timer += 0.05;
    wait(0.05);
  }
}
wait_for_dialog_triggers() {
  wait_for_first_player();

  dialog_triggers = getEntArray("dialog trigger", "script_noteworthy");
  for(i = 0; i < dialog_triggers.size; i++) {
    dialog_triggers[i] thread wait_for_dialog_event();
  }
}
wait_for_dialog_event() {
  while(1) {
    self waittill("trigger", guy);
    if(isPlayer(guy)) {
      break;
    }
    wait(0.05);
  }

  do_sound_for_event(self.script_string);
  if(isDefined(level.kill_events[self.script_string])) {
    for(i = 0; i < level.kill_events[self.script_string].size; i++) {
      level notify(level.endon_signals[level.kill_events[self.script_string][i]]);
    }
  }
}
init_level_flags() {
  level.skipto_flag_names = [];
  flag_init("flak 88s destroyed");
  level.skipto_flag_names = array_add(level.skipto_flag_names, "flak 88s destroyed");
  flag_init("radio tower destroyed");
  level.skipto_flag_names = array_add(level.skipto_flag_names, "radio tower destroyed");
  flag_init("fuel depot cleared");
  level.skipto_flag_names = array_add(level.skipto_flag_names, "fuel depot cleared");
  flag_init("final line breached");
  level.skipto_flag_names = array_add(level.skipto_flag_names, "final line breached");

  flag_init("playback happening");
  flag_init("battlechatter allowed");

  flag_init("coop");
  flag_init("left_path");

  level.event_flags = [];
  level.endon_signals = [];
  level.complete_signals = [];
  level.event_functions = [];
  level.kill_events = [];

  level.event_flags["battlechatter"] = [];
  flag_init("do_firing");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "do_firing");
  flag_init("heavy_damage");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "heavy_damage");
  flag_init("damaged");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "damaged");
  flag_init("infantry_close");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "infantry_close");
  flag_init("retreaters");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "retreaters");
  flag_init("destruction");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "destruction");
  flag_init("idle");
  level.event_flags["battlechatter"] = array_add(level.event_flags["battlechatter"], "idle");
  level.endon_signals["battlechatter"] = "end battlechatter";
  level.complete_signals["battlechatter"] = "DNE";
  level.event_functions["battlechatter"] = ::do_battlechatter;

  level.event_flags["objective intro"] = [];
  level.endon_signals["objective intro"] = "intro interrupt";
  level.complete_signals["objective intro"] = "commissar done";
  level.event_functions["objective intro"] = ::level_intro_announcements;

  level.event_flags["flamethrower_tutorial"] = [];
  flag_init("flamethrower_fired_once");
  level.event_flags["flamethrower_tutorial"] = array_add(level.event_flags["flamethrower_tutorial"], "flamethrower_fired_once");
  flag_init("ads_once");
  level.event_flags["flamethrower_tutorial"] = array_add(level.event_flags["flamethrower_tutorial"], "ads_once");
  flag_init("flamethrower_close_to_inf");
  level.event_flags["flamethrower_tutorial"] = array_add(level.event_flags["flamethrower_tutorial"], "flamethrower_close_to_inf");
  flag_init("killed_with_flamethrower");
  level.event_flags["flamethrower_tutorial"] = array_add(level.event_flags["flamethrower_tutorial"], "killed_with_flamethrower");
  level.endon_signals["flamethrower_tutorial"] = "engaged second 88";
  level.complete_signals["flamethrower_tutorial"] = "tank weapon tutorial complete";
  level.event_functions["flamethrower_tutorial"] = ::flamethrower_tutorial;

  level.event_flags["first_88_obj"] = [];
  level.event_flags["first_88_obj"] = array_add(level.event_flags["first_88_obj"], "destroyed first 88");
  level.endon_signals["first_88_obj"] = "moved into field";
  level.complete_signals["first_88_obj"] = "first 88 destroyed";
  level.event_functions["first_88_obj"] = ::first_88_obj;

  level.event_flags["second_88_obj"] = [];
  level.event_flags["second_88_obj"] = array_add(level.event_flags["second_88_obj"], "destroyed second 88");
  flag_init("second 88 in sights");
  level.event_flags["second_88_obj"] = array_add(level.event_flags["second_88_obj"], "second 88 in sights");
  level.endon_signals["second_88_obj"] = "moved past second position";
  level.complete_signals["second_88_obj"] = "second 88 destroyed";
  level.event_functions["second_88_obj"] = ::second_88_obj;

  level.event_flags["dead_88"] = [];
  flag_init("destroyed first 88");
  level.event_flags["dead_88"] = array_add(level.event_flags["dead_88"], "destroyed first 88");
  flag_init("destroyed second 88");
  level.event_flags["dead_88"] = array_add(level.event_flags["dead_88"], "destroyed second 88");
  flag_init("destroyed third and fourth 88");
  level.event_flags["dead_88"] = array_add(level.event_flags["dead_88"], "destroyed third and fourth 88");
  flag_init("destroyed second last 88");
  level.event_flags["dead_88"] = array_add(level.event_flags["dead_88"], "destroyed second last 88");
  flag_init("destroyed last 88");
  level.event_flags["dead_88"] = array_add(level.event_flags["dead_88"], "destroyed last 88");
  level.endon_signals["dead_88"] = "stop track 88";
  level.complete_signals["dead_88"] = "all 88s dead";
  level.event_functions["dead_88"] = ::dead_88;

  level.event_flags["tank_move_fire_tutorial"] = [];
  flag_init("first_fired_on_event");
  level.event_flags["tank_move_fire_tutorial"] = array_add(level.event_flags["tank_move_fire_tutorial"], "first_fired_on_event");
  flag_init("first_shot");
  level.event_flags["tank_move_fire_tutorial"] = array_add(level.event_flags["tank_move_fire_tutorial"], "first_shot");
  level.endon_signals["tank_move_fire_tutorial"] = "skipped mf tutorial";
  level.complete_signals["tank_move_fire_tutorial"] = "tank move tutorial complete";
  level.event_functions["tank_move_fire_tutorial"] = ::tank_reload_movement_tutorial;

  level.event_flags["first_panther"] = [];
  flag_init("panther_activated");
  level.event_flags["first_panther"] = array_add(level.event_flags["first_panther"], "panther_activated");
  flag_init("panther_in_sights");
  level.event_flags["first_panther"] = array_add(level.event_flags["first_panther"], "panther_in_sights");
  flag_init("panther_first_shot");
  level.event_flags["first_panther"] = array_add(level.event_flags["first_panther"], "panther_first_shot");
  flag_init("panther_second_shot");
  level.event_flags["first_panther"] = array_add(level.event_flags["first_panther"], "panther_second_shot");
  flag_init("panther_third_shot");
  level.event_flags["first_panther"] = array_add(level.event_flags["first_panther"], "panther_third_shot");
  flag_init("panther_dead");
  level.event_flags["first_panther"] = array_add(level.event_flags["first_panther"], "panther_dead");
  level.endon_signals["first_panther"] = "engage last 88s";
  level.complete_signals["first_panther"] = "first panther dead";
  level.event_functions["first_panther"] = ::first_panther_prompt;

  level.event_flags["choose_path"] = [];
  level.endon_signals["choose_path"] = "path chosen";
  level.complete_signals["choose_path"] = "player chose... wisely";
  level.event_functions["choose_path"] = ::choose_path;

  level.event_flags["choose_right_path"] = [];
  level.event_flags["choose_right_path"] = array_add(level.event_flags["choose_right_path"], "destroyed third and fourth 88");
  level.event_flags["choose_right_path"] = array_add(level.event_flags["choose_right_path"], "destroyed second last 88");
  level.event_flags["choose_right_path"] = array_add(level.event_flags["choose_right_path"], "destroyed last 88");
  level.endon_signals["choose_right_path"] = "stop choose right";
  level.complete_signals["choose_right_path"] = "all artillery destroyed";
  level.event_functions["choose_right_path"] = ::choose_right_path;

  level.event_flags["choose_left_path"] = [];
  level.event_flags["choose_left_path"] = array_add(level.event_flags["choose_left_path"], "destroyed third and fourth 88");
  level.event_flags["choose_left_path"] = array_add(level.event_flags["choose_left_path"], "destroyed second last 88");
  level.event_flags["choose_left_path"] = array_add(level.event_flags["choose_left_path"], "destroyed last 88");
  level.endon_signals["choose_left_path"] = "stop choose left";
  level.complete_signals["choose_left_path"] = "all artillery destroyed";
  level.event_functions["choose_left_path"] = ::choose_left_path;

  level.event_flags["player_exposed"] = [];
  flag_init("internal_first_warning_given");
  level.event_flags["player_exposed"] = array_add(level.event_flags["player_exposed"], "internal_first_warning_given");
  flag_init("internal_second_warning_given");
  level.event_flags["player_exposed"] = array_add(level.event_flags["player_exposed"], "internal_second_warning_given");
  level.endon_signals["player_exposed"] = "player not exposed";
  level.complete_signals["player_exposed"] = "all warnings given";
  level.event_functions["player_exposed"] = ::player_exposed;

  level.event_flags["radio_tower_dialog"] = [];
  flag_init("radio_tower_visible");
  level.event_flags["radio_tower_dialog"] = array_add(level.event_flags["radio_tower_dialog"], "radio_tower_visible");
  flag_init("radio_tower_close");
  level.event_flags["radio_tower_dialog"] = array_add(level.event_flags["radio_tower_dialog"], "radio_tower_close");
  flag_init("radio_tower_destroyed");
  level.event_flags["radio_tower_dialog"] = array_add(level.event_flags["radio_tower_dialog"], "radio_tower_destroyed");
  level.kill_events["radio_tower_dialog"] = [];
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "first_88_obj");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "second_88_obj");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "dead_88");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "first_panther");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "choose_path");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "choose_left_path");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "choose_right_path");
  level.kill_events["radio_tower_dialog"] = array_add(level.kill_events["radio_tower_dialog"], "player_exposed");
  level.endon_signals["radio_tower_dialog"] = "do not interrupt";
  level.complete_signals["radio_tower_dialog"] = "radio tower destroyed";
  level.event_functions["radio_tower_dialog"] = ::radio_tower_dialog;

  level.event_flags["fuel_depot_dialog"] = [];
  level.endon_signals["fuel_depot_dialog"] = "do not interrupt";
  level.complete_signals["fuel_depot_dialog"] = "fuel depot done";
  level.event_functions["fuel_depot_dialog"] = ::fuel_depot_dialog;

  level.event_flags["final_battle_dialog"] = [];
  level.endon_signals["final_battle_dialog"] = "do not interrupt";
  level.complete_signals["final_battle_dialog"] = "final done";
  level.event_functions["final_battle_dialog"] = ::final_battle_dialog;

  flag_init("flak objective completed");
  flag_init("radio tower objective completed");
  flag_init("final battle already started");

  flag_init("player_ready_for_outro");
  flag_init("outro_group_1_ready");
  flag_init("outro_group_2_ready");
}
do_sound_for_event(event) {
  if(!isDefined(event) || !isDefined(level.event_flags[event]) || !isDefined(level.endon_signals[event]) || !isDefined(level.complete_signals[event]) || !isDefined(level.event_functions[event])) {
    error("Requested sound event '" + event + "' is not setup properly");
  }

  if(!array_check_for_dupes(level.finished_events, event)) {
    return;
  }

  level.finished_events = array_add(level.finished_events, event);

  for(i = 0; i < level.event_flags[event].size; i++) {
    if(!isSubStr("internal_", level.event_flags[event][i])) {
      level thread update_target_flag(level.event_flags[event][i]);
    }
  }
  level thread[[level.event_functions[event]]](level.endon_signals[event], level.complete_signals[event], level.event_flags[event][0], level.event_flags[event][1], level.event_flags[event][2], level.event_flags[event][3], level.event_flags[event][4], level.event_flags[event][5], level.event_flags[event][6]);
}
update_target_flag(flag) {
  switch (flag) {
    case "heavy_damage":
      player = get_players()[0];
      while(1) {
        if(!isDefined(player.myTank)) {
          wait(0.05);
          continue;
        }
        player.myTank waittill("damage", amount);
        old_percent = player.myTank.armor / player.myTank.maxarmor;
        new_percent = (player.myTank.armor - amount) / player.myTank.maxarmor;
        if((old_percent > 0.2 && new_percent <= 0.2) || (old_percent > 0.5 && new_percent <= 0.5)) {
          flag_set("heavy_damage");
          wait(3);
          flag_clear("heavy_damage");
          wait(8);
        }
      }

    case "do_firing":
      player = get_players()[0];
      while(1) {
        if(!isDefined(player.myTank)) {
          wait(0.05);
          continue;
        }
        angles = player.myTank getTagAngles("tag_flash");
        origin = player.myTank getTagOrigin("tag_flash");
        vec = anglesToForward(angles);

        trace = bulletTrace(origin, origin + vec * 5000, false, player.myTank);
        if(trace["fraction"] < 0.95) {
          ent = trace["entity"];
          if(isDefined(ent)) {
            if(!array_check_for_dupes(level.enemy_armor, ent) && ent.classname != "script_vehicle_corpse") {
              flag_set("do_firing");
            }
          }
        }

        wait(4);
      }

    case "damaged":
      player = get_players()[0];
      while(1) {
        if(!isDefined(player.myTank)) {
          wait(0.05);
          continue;
        }
        player.myTank waittill("damage", amount);
        flag_set("damaged");
        wait(0.5);
        flag_clear("damaged");
        wait(8);
      }

    case "infantry_close":
      player = get_players()[0];
      while(1) {
        close_count = 0;
        for(i = 0; i < level.enemy_infantry.size; i++) {
          if(isDefined(level.enemy_infantry[i])) {
            if(distanceSquared(player.myTank.origin, level.enemy_infantry[i].origin) < level.min_distance_for_close_infantry * level.min_distance_for_close_infantry) {
              close_count++;
            }
          }
        }
        if(close_count > level.min_close_infantry_for_warning) {
          flag_set("infantry_close");
          wait(3);
          flag_clear("infantry_close");
        }
        wait(3);
      }

    case "retreaters":
      player = get_players()[0];
      while(1) {
        level waittill("retreaters", ent);

        if(check_for_visible(player, ent, 3000)) {
          flag_set("retreaters");
          wait(4);
          flag_clear("retreaters");
        }
      }

    case "destruction":
      player = get_players()[0];
      while(1) {
        level waittill("destruction");
        flag_set("destruction");
        wait(4);
        flag_clear("destruction");
      }

    case "idle":
      player = get_players()[0];
      prev_position = player.origin;

      while(1) {
        if(distanceSquared(prev_position, player.origin) < level.min_idle_dist_sq) {
          level.current_idle_time += 0.05;
          if(level.current_idle_time >= level.idle_warn_time) {
            level.current_idle_time = 0;
            flag_set("idle");
            wait(4);
            flag_clear("idle");
          }
        } else {
          level.current_idle_time = 0;
        }
        prev_position = player.origin;
      }

    case "flamethrower_fired_once":
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[0] thread inform_on_ft_button("ft_pressed");
      }
      level waittill_notify_or_timeout("ft_pressed", 6);
      players[0] notify("go_past_ft_tut");
      flag_set("flamethrower_fired_once");
      break;

    case "ads_once":
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[0] thread inform_on_ads_button("ads_pressed");
      }
      level waittill_notify_or_timeout("ads_pressed", 14);
      players[0] notify("go_past_ads_tut");
      flag_set("ads_once");
      break;

    case "flamethrower_close_to_inf":
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i] thread check_close_to_stuck_inf("player_close", 1200);
      }
      level waittill("player_close");
      flag_set("flamethrower_close_to_inf");
      wait(1);
      flag_set("battlechatter allowed");
      break;

    case "destroyed first 88":
      while(1) {
        if((level.max_active_arty - level.active_arty) > 0) {
          break;
        }
        wait(0.05);
      }
      flag_set("destroyed first 88");
      break;

    case "second 88 in sights":
      second_arty = getEnt("arty 3", "targetname");
      in_player_sights = false;
      while(in_player_sights == false) {
        if(!isDefined(second_arty)) {
          break;
        }
        for(i = 0; i < get_players().size && !in_player_sights; i++) {
          toVec = second_arty.origin - get_players()[i].origin;
          forward = anglesToForward(get_players()[i].angles);
          toVec = (toVec[0], toVec[1], 0);
          forward = (forward[0], forward[1], 0);
          diff = VectorDot(VectorNormalize(forward), VectorNormalize(toVec));
          if(acos(diff) < 65) {
            in_player_sights = true;
          }
        }
        wait(1);
      }
      flag_set("second 88 in sights");
      break;

    case "destroyed second 88":
      while(1) {
        if((level.max_active_arty - level.active_arty) > 1) {
          break;
        }
        wait(0.05);
      }
      flag_set("destroyed second 88");
      break;

    case "destroyed third and fourth 88":
      while(1) {
        if((level.max_active_arty - level.active_arty) > 3) {
          break;
        }
        wait(0.05);
      }
      flag_set("destroyed third and fourth 88");
      break;

    case "destroyed second last 88":
      while(1) {
        if(level.active_arty < 2) {
          break;
        }
        wait(0.05);
      }
      flag_set("destroyed second last 88");
      break;

    case "destroyed last 88":
      while(1) {
        if(level.active_arty == 0) {
          break;
        }
        wait(0.05);
      }
      flag_set("destroyed last 88");
      break;

    case "first_fired_on_event":
      flag_set("first_fired_on_event");
      break;

    case "first_shot":
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i] thread wait_for_player_shoot_event("player shot");
      }
      level waittill("player shot");
      flag_set("first_shot");
      break;

    case "panther_activated":
      trigger = GetEnt("panther activate trigger", "targetname");
      trigger waittill("trigger");
      wait(8);
      flag_set("panther_activated");

    case "panther_in_sights":
      flag_wait("panther_activated");
      panther = getEnt("lineveh 4 group0", "script_noteworthy");
      in_player_sights = false;
      while(in_player_sights == false) {
        if(!isDefined(panther)) {
          break;
        }
        for(i = 0; i < get_players().size && !in_player_sights; i++) {
          toVec = panther.origin - get_players()[i].origin;
          forward = anglesToForward(get_players()[i].angles);
          toVec = (toVec[0], toVec[1], 0);
          forward = (forward[0], forward[1], 0);
          diff = VectorDot(VectorNormalize(forward), VectorNormalize(toVec));
          if(acos(diff) < 30) {
            in_player_sights = true;
          }
        }
        wait(1);
      }
      flag_set("panther_in_sights");
      break;

    case "panther_first_shot":
      panther = getEnt("lineveh 4 group0", "script_noteworthy");
      damaged_by_player = false;
      while(!damaged_by_player) {
        if(panther.classname == "script_vehicle_corpse" || panther.health < 1) {
          break;
        }
        panther waittill("damage", amt, guy);
        damaged_by_player = check_damaged_by_player(guy);
        wait(0.05);
      }
      flag_set("panther_first_shot");
      break;

    case "panther_second_shot":
      panther = getEnt("lineveh 4 group0", "script_noteworthy");
      flag_wait("panther_first_shot");
      damaged_by_player = false;
      while(!damaged_by_player) {
        if(panther.classname == "script_vehicle_corpse" || panther.health < 1) {
          break;
        }
        panther waittill("damage", amt, guy);
        damaged_by_player = check_damaged_by_player(guy);
        wait(0.05);
      }
      flag_set("panther_second_shot");
      break;

    case "panther_third_shot":
      panther = getEnt("lineveh 4 group0", "script_noteworthy");
      flag_wait("panther_first_shot");
      flag_wait("panther_second_shot");
      damaged_by_player = false;
      while(!damaged_by_player) {
        if(panther.classname == "script_vehicle_corpse" || panther.health < 1) {
          break;
        }
        panther waittill("damage", amt, guy);
        damaged_by_player = check_damaged_by_player(guy);
        wait(0.05);
      }
      flag_set("panther_third_shot");
      break;

    case "panther_dead":
      panther = getEnt("lineveh 4 group0", "script_noteworthy");
      panther waittill("death");
      flag_set("panther_dead");
      break;

    case "radio_tower_visible":
      radio_tower = GetEnt("radio tower", "script_noteworthy");
      visible = false;
      while(!visible) {
        for(i = 0; i < get_players().size && !visible; i++) {
          if(check_for_visible(get_players()[i], radio_tower, 8500)) {
            visible = true;
          }
        }
        wait(0.05);
      }
      flag_set("radio_tower_visible");
      break;

    case "radio_tower_close":
      radio_tower = GetEnt("radio tower", "script_noteworthy");
      close = false;
      while(!close) {
        for(i = 0; i < get_players().size && !close; i++) {
          if(check_for_close(get_players()[i], radio_tower, 3500)) {
            close = true;
          }
          wait(0.05);
        }
      }
      flag_set("radio_tower_close");
      break;

    case "radio_tower_destroyed":
      radio_tower = GetEnt("radio tower", "script_noteworthy");
      while(1) {
        if(radio_tower.model == "anim_seelow_radiotower_d") {
          break;
        }
        wait(0.05);
      }
      wait(3);
      flag_set("radio_tower_destroyed");
      break;
  }
}
check_for_close(player, object, dist) {
  if(distanceSquared(player.origin, object.origin) < dist * dist) {
    return true;
  }
  return false;
}
check_for_arty_destroyed(arty_array, inform) {
  dead_arty = false;
  while(!dead_arty) {
    for(i = 0; i < arty_array.size; i++) {
      if(check_for_arty_dead(arty_array[i])) {
        dead_arty = true;
      }
    }
  }
}
check_for_visible(player, object, dist) {
  toVec = object.origin - player.origin;
  forward = anglesToForward(player.angles);
  toVec = (toVec[0], toVec[1], 0);
  forward = (forward[0], forward[1], 0);
  diff = VectorDot(VectorNormalize(forward), VectorNormalize(toVec));
  if(acos(diff) < 65 && distanceSquared(player.origin, object.origin) < dist * dist) {
    return true;
  }
  return false;
}
check_for_either_arty_destroyed(arty1, arty2, inform) {
  level endon(inform);
  while(1) {
    if(check_for_arty_dead(arty1) || check_for_arty_dead(arty2)) {
      break;
    }
    wait(0.05);
  }
  level notify(inform);
}
check_for_both_arty_destroyed(arty1, arty2, inform) {
  level endon(inform);
  while(1) {
    if(check_for_arty_dead(arty1) && check_for_arty_dead(arty2)) {
      break;
    }
    wait(0.05);
  }
  level notify(inform);
}
check_for_arty_dead(arty) {
  if(!isDefined(arty) || arty.health < 1 || arty.classname == "script_vehicle_corpse" || arty.crewsize < 1) {
    return true;
  }
  return false;
}
check_damaged_by_player(guy) {
  damaged_by_player = false;
  for(i = 0; i < get_players().size; i++) {
    if(guy == get_players()[i] || guy == get_players()[i].myTank) {
      damaged_by_player = true;
    }
  }
  return damaged_by_player;
}
wait_for_player_shoot_event(inform) {
  level endon(inform);
  while(1) {
    if(self attackButtonPressed()) {
      break;
    }
    wait(0.05);
  }
  level notify(inform);
}
wait_for_player_damage_event(inform) {
  level endon(inform);
  self waittill("tank hit");
  level notify(inform);
}
check_close_to_stuck_inf(inform, dist) {
  stuck_infantry = [];
  while(stuck_infantry.size < 1) {
    stuck_infantry = get_living_ai_array("stuck infantry", "script_noteworthy");
    wait(0.05);
  }

  close_enough = false;
  while(!close_enough) {
    for(i = 0; i < stuck_infantry.size && !close_enough; i++) {
      if(isDefined(stuck_infantry[i])) {
        if(distanceSquared(self.origin, stuck_infantry[i].origin) < dist * dist) {
          close_enough = true;
        }
      }
    }
    wait(0.05);
  }
  level notify(inform);
}
inform_on_ft_button(inform) {
  while(1) {
    if(self fragButtonPressed()) {
      level notify(inform);
      return;
    }
    wait(0.05);
  }
}
inform_on_ads_button(inform) {
  while(1) {
    if(self adsButtonPressed()) {
      level notify(inform);
      return;
    }
    wait(0.05);
  }
}
spawn_guys(spawners, target_name, ok_to_spawn) {
  guys = [];

  for(i = 0; i < spawners.size; i++) {
    if(NumRemoteClients() == 0) {
      guy = spawn_guy(spawners[i], target_name, false);
    } else {
      guy = spawn_guy(spawners[i], target_name, ok_to_spawn);
    }
    if(isDefined(guy)) {
      guys[guys.size] = guy;
    }
  }

  if(!isDefined(ok_to_spawn) || !ok_to_spawn) {
    return guys;
  }
}
spawn_guy(spawner, target_name, ok_to_spawn) {
  if(isDefined(ok_to_spawn) && ok_to_spawn) {
    while(!OkTospawn()) {
      wait(0.1);
    }
  }

  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
    guy = spawner Stalingradspawn();
  } else {
    guy = spawner Dospawn();
  }

  if(!spawn_failed(guy)) {
    if(isDefined(target_name)) {
      guy.targetname = target_name;
    }

    return guy;
  }

  return undefined;
}
do_floodspawners(areaname, time) {
  trigger = getEnt("radio tower back half", "script_noteworthy");

  level endon(trigger.script_noteworthy);

  trigger thread inform_on_touch_trigger(trigger.script_noteworthy);

  floodspawners = getEntArray(areaname + " floodspawner", "script_noteworthy");
  spawners = [];

  x = 0;
  y = 0;

  while(1) {
    ai = getaiarray("axis");

    if((ai.size < level.max_ai_spawn_current || x < 5) && y < 10) {
      spawners[0] = floodspawners[randomint(floodspawners.size)];
      spawn_guys(spawners, undefined, true);
      spawners[0].count++;
      x++;
      y++;
    }
    wait(time);
  }
}
fuel_depot_infantry_evasion() {
  self endon("death");

  trigger = GetEnt("fuel depot retreat trigger", "script_noteworthy");

  trigger waittill("trigger");

  wait(randomfloatrange(0.5, 3));

  retreat_node = level.fuel_depot_goal_nodes[randomint(level.fuel_depot_goal_nodes.size)];

  self setGoalNode(retreat_node);
}
enforce_flame_deaths() {
  self endon("death");

  while(1) {
    self waittill("damage", amount, other, direction_vec, point, type);
    if(type == "MOD_BURNED") {
      self.a.forceflamedeath = true;
      self doDamage(self.health * 2, self.origin);
    }
  }
}
radio_tower_infantry_evasion() {
  self endon("death");

  players = get_players();
  timer = 0;
  min_time_before_shift = 6;
  max_time_before_shift = 12;

  while(1) {
    inArc = false;
    for(i = 0; i < players.size && !inArc; i++) {
      if(isDefined(players[i])) {
        inArc = self is_in_player_arc(players[i]);
      }
    }
    if(timer > randomfloatrange(min_time_before_shift, max_time_before_shift) || (timer > min_time_before_shift && inArc)) {
      self notify("radio_set_new_goal_node");
      self waittill("goal");
    }
    timer += 0.5;
    wait(0.5);
  }
}

radio_tower_infantry_grenades() {
  self endon("death");

  while(1) {
    self waittill("radio_set_new_goal_node");

    if(self.classname != "actor_axis_ger_ber_wehr_reg_kar98k") {
      self setGoalNode(level.radio_tower_goal_nodes[randomint(level.radio_tower_goal_nodes.size)]);
      return;
    }

    random_grenade_chance = RandomIntRange(0, 100);

    if(random_grenade_chance > 70) {
      players = get_players();

      my_target = players[0].myTank;
      for(i = 1; i < players.size; i++) {
        if(distanceSquared(self.origin, my_target.origin) > distanceSquared(self.origin, players[i].myTank.origin)) {
          my_target = players[i].myTank;
        }
      }

      self maps\_grenade_toss::force_grenade_toss(my_target.origin, undefined, 3, undefined, undefined);
    }

    self setGoalNode(level.radio_tower_goal_nodes[randomint(level.radio_tower_goal_nodes.size)]);
  }
}
do_antitank_AI() {
  self endon("death");

  while(1) {
    best_target = self maps\_vehicle::get_nearest_target(level.player_tanks);
    if(isDefined(best_target)) {
      dist = distanceSquared(best_target.origin, self.origin);
      if(dist < level.max_panzerschreck_eng_distsq && dist > level.min_panzerschreck_eng_distsq) {
        self setEntityTarget(best_target);
      } else {
        self clearEntityTarget();
      }
    }
    wait(0.05);
  }
}
remove_old_targeters() {
  self endon("death");
  while(1) {
    self waittill("stopped targeting", ent);
    for(i = 0; i < self.current_targeters.size; i++) {
      if(self.current_targeters[i] == ent) {
        self.current_targeters = array_remove(self.current_targeters, ent);
      }
    }

    for(i = 0; i < self.queued_targeters.size; i++) {
      if(self.queued_targeters[i] == ent) {
        self.queued_targeters = array_remove(self.queued_targeters, ent);
      }
    }
  }
}
update_current_targeters() {
  self endon("death");
  self endon("disconnect");
  self thread remove_old_targeters();
  if(!isDefined(self.current_targeters)) {
    self.current_targeters = [];
  }
  if(!isDefined(self.queued_targeters)) {
    self.queued_targeters = [];
  }
  if(!isDefined(self.miss_structs)) {
    self.miss_structs = [];
  }

  x_sign = 1;
  y_sign = 1;

  for(i = 0; i < level.number_miss_structs; i++) {
    x = randomfloat(0 - level.max_miss_distance, level.max_miss_distance);
    y = randomfloat(0 - level.max_miss_distance, level.max_miss_distance);
    if(x < level.min_miss_distance && x > 0) {
      x = level.min_miss_distance;
    } else if(x > 0 - level.min_miss_distance) {
      x = 0 - level.min_miss_distance;
    }

    if(y < level.min_miss_distance && x > 0) {
      y = level.min_miss_distance;
    } else if(y > 0 - level.min_miss_distance) {
      y = 0 - level.min_miss_distance;
    }
    miss_struct = spawn("script_origin", (0, 0, 0));
    miss_struct.origin = (self.origin[0] + x, self.origin[1] + y, self.origin[2]);
    miss_struct.origin = groundpos(miss_struct.origin);
    self.miss_structs = array_add(self.miss_structs, miss_struct);
    miss_struct linkto(self);
  }

  while(1) {
    best_dist = 10000000000;
    best_index = -1;
    for(i = 0; i < level.see2_max_targeters; i++) {
      if(!isDefined(self.current_targeters[i])) {
        for(j = 0; j < self.queued_targeters.size; j++) {
          if(isDefined(self.queued_targeters[j])) {
            dist = distanceSquared(self.origin, self.queued_targeters[i].origin);
            if(dist < best_dist) {
              best_index = j;
              best_dist = dist;
            }
          }
        }
        if(best_index > 0) {
          self.queued_targeters[best_index] notify("switch targets", self);
          self.current_targeters[i] = self.queued_targeters[best_index];
          self.queued_targeters = array_remove(self.queued_targeters, self.queued_targeters[best_index]);
        }
      }
    }
    wait(0.5);
  }
}
request_target(target) {
  if(!isDefined(target) || !isDefined(target.miss_structs)) {
    return target;
  }

  targeted = undefined;
  for(i = 0; i < level.see2_max_targeters; i++) {
    if(!isDefined(target.current_targeters[i]) || target.current_targeters[i] == self) {
      target.current_targeters[i] = self;
      targeted = target;
      break;
    }
  }

  if(!isDefined(targeted)) {
    rand = randomint(level.number_miss_structs);
    targeted = target.miss_structs[rand];
    if(array_check_for_dupes(target.queued_targeters, self)) {
      target.queued_targeters = array_add(target.queued_targeters, self);
    }
  }

  return targeted;
}
field_begin() {
  thread setup_stuck_event();

  thread setup_early_tanks();

  wait_for_first_player();
  wait(4);

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].squishcount = 0;
  }
  for(i = 1; i < players.size; i++) {
    players[i] TakeWeapon("m2_flamethrower");
    players[i] SwitchToWeapon("ppsh");
  }

  setup_player_tanks();

  thread keep_track_of_achievement();

  thread do_sound_for_event("battlechatter");

  do_area_spawn(0);
  wait_network_frame();
  do_arty_spawn(0);

  arty_flaps = getEntArray("arty tarp", "targetname");
  for(i = 0; i < arty_flaps.size; i++) {
    arty_flaps[i] thread do_tarp_flap();
    arty_flaps[i] thread cleanup_tarp();
  }

  level waittill("controls_active");

  level clientNotify("aaa_begin");
  level notify("aaa_begin");
  level clientNotify("start_distance_planes_field_1");
  level notify("start_distance_planes_field_1");
  level thread field_begin_planes_end();

  level thread arcademode_water_tower_setup();

  arty_array = getEntArray("group1 arty", "script_noteworthy");
  assert(arty_array.size > 1);
  objective_add(1, "current");

  for(i = 0; i < arty_array.size; i++) {
    arty_array[i].health = 1;
    arty_array[i] thread arty_behavior();
    objective_additionalPosition(1, i, arty_array[i].origin);
  }

  level.active_arty = arty_array.size;
  level.max_active_arty = arty_array.size;
  objective_string(1, &"SEE2_DESTROY_ARTILLERY", level.active_arty);

  third_tier = getEntArray("third tier", "targetname");
  third_tier = array_merge(third_tier, getEntArray("third tier two", "targetname"));
  third_tier = array_merge(third_tier, getEntArray("third tier three", "targetname"));

  for(i = 0; i < third_tier.size; i++) {
    third_tier[i].script_forcespawn = 1;
  }

  for(i = 0; i < arty_array.size; i++) {
    arty_array[i] thread wait_for_neutralize(i);
  }

  level thread wait_for_third_wave();
  level thread wait_for_area_two_infantry();
  level thread wait_for_area_three_infantry();
  level thread wait_for_area_four_infantry();
  level thread setup_airstrike_triggers();

  level thread do_retreat_trucks();
  level thread do_stop_wait_triggers();

  thread do_bunker_group("first bunker", "fourth bunker", "first bunker taken");
  thread do_bunker_group("second bunker", "fourth bunker", "second bunker taken", "second tier");
  thread do_bunker_group("third bunker", "fifth bunker", "third bunker taken", "third tier");
  thread do_bunker_group("fourth bunker", "third bunker", "fourth bunker taken", "second tier");
  thread do_bunker_group("fifth bunker", "third bunker", "fifth bunker taken");

  thread wait_for_group_spawn(1);
  thread wait_for_group_spawn(2);
  thread wait_for_group_spawn(3);
  thread keep_grenade_bags_from_spawning();
  thread do_fake_schrecks();

  setmusicstate("INTRO");
  setbusstate("TANKS");

  build_retreat_generics();
}

arcademode_water_tower_setup() {
  water_tower_trigs = [];
  water_tower_trigs = getEntArray("water_tower_trig", "targetname");

  for(i = 0; i < water_tower_trigs.size; i++) {
    water_tower_trigs[i] thread arcademode_water_tower_give_points();
  }
}

arcademode_water_tower_give_points() {
  self waittill("trigger", ent);

  if(isPlayer(ent)) {
    arcademode_assignpoints("arcademode_score_banzai", ent);
  }
}

move_radio_tower_blocker(proper_position) {
  radio_tower_blocker = GetEnt("radio_tower_blocker", "targetname");
  if(!proper_position) {
    radio_tower_blocker.origin = radio_tower_blocker.origin - (0, 0, 5000);
  } else {
    radio_tower_blocker.origin = radio_tower_blocker.origin + (0, 0, 5000);
  }
}

field_begin_planes_end() {
  trig = GetEnt("stop field planes", "targetname");
  trig waittill("trigger");

  level clientNotify("start_distance_planes_field_1_stop");
  level notify("start_distance_planes_field_1_stop");
}
do_stop_wait_triggers() {
  triggers = getEntArray("stop wait trigger", "targetname");
  for(i = 0; i < triggers.size; i++) {
    triggers[i] thread wait_for_stop_wait();
  }
}
wait_for_stop_wait() {
  while(1) {
    self waittill("trigger", guy);
    if(isPlayer(guy)) {
      break;
    }
  }
  if(array_check_for_dupes(level.invalid_retreat_points, self.script_noteworthy)) {
    level.invalid_retreat_points = array_add(level.invalid_retreat_points, self.script_noteworthy);
  }
}
wait_for_third_wave() {
  spawners = getEntArray("third tier", "targetname");

  level waittill_either("second bunker taken", "fourth bunker taken");
  spawn_guys(spawners, undefined, true);
}
wait_for_neutralize(objNum) {
  self waittill_either("death", "crew dead");
  level.active_arty--;
  if(level.active_arty == 0) {
    Objective_AdditionalPosition(1, objNum, (0, 0, 0));
    Objective_String_NoMessage(1, &"SEE2_DESTROY_ARTILLERY", level.active_arty);
    flag_set("flak objective completed");
    Objective_State(1, "done");
    autosave_by_name("first area arty destroyed");
    level notify("begin event 2");
    wait(5);
    thread do_sound_for_event("radio_tower_dialog");
  } else {
    Objective_AdditionalPosition(1, objNum, (0, 0, 0));
    Objective_String(1, &"SEE2_DESTROY_ARTILLERY", level.active_arty);
    if(level.active_arty == 2) {
      autosave_by_name("first area arty destroyed" + level.active_arty);
    }
  }
}
do_death_tank_sequence(target_node, death_node) {
  self setWaitNode(target_node);

  self waittill("reached_wait_node");

  has_target = false;

  stuck_infantry = [];
  while(stuck_infantry.size < 1) {
    stuck_infantry = get_living_ai_array("stuck infantry", "script_noteworthy");
    wait(0.05);
  }

  for(i = 0; i < stuck_infantry.size; i++) {
    if(isDefined(stuck_infantry[i])) {
      if(!has_target) {
        has_target = true;
        self setTurretTargetEnt(stuck_infantry[i]);
      }
      stuck_infantry[i].ignoreall = false;
      stuck_infantry[i] setEntityTarget(self);
    }
  }

  wait(0.05);

  self setWaitNode(death_node);
  wait(0.05);
  self waittill("reached_wait_node");

  self.health = 1;

  self waittill("death");
  flag_set("death tank dead");
}
setup_stuck_event() {
  flag_init("death tank dead");

  stuck_infantry = getEntArray("stuck infantry", "script_noteworthy");

  level waittill("controls_active");

  stuck_tanknode = GetEnt("stuck tank node", "script_noteworthy");
  stuck_flee_nodes = GetNodeArray("stuck flee node", "script_noteworthy");
  stuck_flee_panzer_nodes = GetNodeArray("stuck panzer flee node", "script_noteworthy");
  stuck_trigger = GetEnt("stuck trigger", "script_noteworthy");
  stuck_ammo_boxes = getEntArray("stuck ammo crate", "script_noteworthy");
  stuck_damage_trigger = GetEnt("stuck damage trigger", "script_noteworthy");
  death_tank_move_trigger = getEnt("death tank move_trigger", "script_noteworthy");
  death_tank_spawn_trigger = getEnt("death tank spawn_trigger", "script_noteworthy");
  target_node = getVehicleNode("start targeting", "script_noteworthy");
  death_node = getVehicleNode("death node", "script_noteworthy");

  array_thread(stuck_infantry, ::add_spawn_function, ::setup_stuck_infantry);

  death_tank_spawn_trigger notify("trigger");
  wait(0.05);
  death_tank = getEnt("death tank", "script_noteworthy");

  death_tank_move_trigger notify("trigger");

  death_tank thread do_death_tank_sequence(target_node, death_node);

  stuck_trigger waittill("trigger");

  while(!flag("death tank dead")) {
    wait(0.05);
    continue;
  }

  wait(2);

  stuck_infantry = get_living_ai_array("stuck infantry", "script_noteworthy");

  for(i = 0; i < stuck_infantry.size; i++) {
    if(isDefined(stuck_infantry[i])) {
      stuck_infantry[i] ClearEntityTarget();
      stuck_infantry[i] thread setup_bunker_infantry();
      stuck_infantry[i].goalradius = 32;
      if(stuck_infantry[i].classname == "actor_axis_ger_ber_wehr_reg_panzerschrek") {
        stuck_infantry[i].maxsightdistsqrd = 3000 * 3000;
        stuck_infantry[i] setGoalNode(stuck_flee_panzer_nodes[i]);
      } else {
        stuck_infantry[i] setGoalNode(stuck_flee_nodes[i]);
        stuck_infantry[i].script_noteworthy = "first bunker guard";
      }
      wait(randomfloatrange(0.25, 0.5));
    }
  }

  stuck_damage_trigger thread inform_on_damage_trigger("blow up ammo boxes");

  level waittill("blow up ammo boxes");

  for(i = 0; i < stuck_ammo_boxes.size; i++) {
    playFX(level._effect["dummy_tank_explode"], stuck_ammo_boxes[i].origin);
    radiusDamage(stuck_ammo_boxes[i].origin, 1000, 500, 500);
    stuck_ammo_boxes[i] delete();
    wait(randomintrange(1, 5));
  }
}
setup_stuck_infantry() {
  self.goalradius = 32;
  self.ignoreall = true;
}
setup_field_ambushes() {
  for(i = 1;; i++) {
    trigger = GetEnt("field " + i + " ambush trigger");
    if(isDefined(trigger)) {
      level thread setup_single_ambush(i, trigger);
    } else {
      break;
    }
  }
}
setup_single_ambush(field, trigger) {
  guys = getEntArray("field " + field + " ambush", "script_noteworthy");
  for(i = 0; i < guys.size; i++) {
    guys.ignoreall = true;
    guys.ignoreme = true;
    guys allowedstances("prone");
    guys.a.no_switch_weapon = true;
  }
  trigger inform_on_touch_trigger(trigger.script_noteworthy);
  level waittill(trigger.script_noteworthy);
  for(i = 0; i < guys.size; i++) {
    guys.ignoreall = false;
    guys.ignoreme = false;
    guys allowedstances("stand", "crouch", "prone");
  }
}
find_farthest_retreat_point(enemy) {
  best_dist = 0;
  ref_pt = -1;

  for(i = 0; i < level.retreat_reference_points.size; i++) {
    dist = distanceSquared(level.retreat_reference_points[i].origin, enemy.origin);
    if(dist > best_dist) {
      tank_dir = level.retreat_reference_points[i].origin - enemy.origin;
      retreat_dir = enemy.origin - self.origin;

      if(VectorDot(VectorNormalize(tank_dir), VectorNormalize(retreat_dir)) > 0) {
        continue;
      }

      best_dist = dist;
      ref_pt = i;
    }
  }
  if(ref_pt < 0) {
    return undefined;
  }

  node = level.retreat_nodes[ref_pt][randomint(level.retreat_nodes[ref_pt].size)];
  return node;
}
build_retreat_generics() {
  level.retreat_reference_points = [];
  level.retreat_nodes = [];

  for(i = 0;; i++) {
    ref = getNode("retreat " + i, "targetname");
    if(!isDefined(ref)) {
      break;
    }
    level.retreat_reference_points = array_add(level.retreat_reference_points, ref);
    level.retreat_nodes = array_add(level.retreat_nodes, GetNodeArray("retreat " + i, "script_noteworthy"));
  }
}
setup_bunker_infantry() {
  level.enemy_infantry = array_add(level.enemy_infantry, self);
  self thread enforce_flame_deaths();
  if(self.classname == "actor_axis_ger_ber_wehr_reg_panzerschrek") {
    self thread do_antitank_AI();

    self setThreatBiasGroup("enemy antitank");
    self set_ent_see2_bias_group("enemy antitank");
    self.a.rockets = 200;
    self.maxsightdistsqrd = 3000 * 3000;
    self.a.no_weapon_switch = true;
  } else {
    self setThreatBiasGroup("enemy infantry");
    self set_ent_see2_bias_group("enemy infantry");
  }
}

unlimited_rocket_ammo() {
  self endon("death");

  while(1) {
    if(self.bulletsInClip < weaponClipSize(self.weapon)) {
      self.bulletsInClip = weaponClipSize(self.weapon);
    }
    wait(0.5);
  }
}
do_generic_retreats() {
  self endon("death");

  while(isDefined(self.scripted_grenade_throw)) {
    wait(0.05);
  }

  while(1) {
    for(i = 0; i < get_players().size; i++) {
      if(distanceSquared(self.origin, get_players()[i].origin) < 1000 * 1000) {
        node = self find_farthest_retreat_point(get_players()[i]);
        self.goal_radius = 64;
        self setGoalNode(node);
        level notify("ai_set_new_retreat_node");

        self waittill("goal");
        self.ignoreme = false;
        self.ignoreall = false;
        self AllowedStances("crouch", "prone");
        return;
      }
    }
    wait(0.2);
  }
}
do_retreat_trucks() {
  trucks = getEntArray("retreat truck", "targetname");
  for(i = 0; i < trucks.size; i++) {
    trucks[i] thread retreat_truck_behavior();
    vehicle_node = GetVehicleNode(trucks[i].target, "targetname");
    if(isDefined(vehicle_node)) {
      trucks[i] thread maps\_vehicle::vehicle_paths(vehicle_node);
    }
    wait(2);
  }
}
radio_tower_begin() {
  flag_set("flak 88s destroyed");

  thread do_sound_for_event("battlechatter");

  level thread setup_early_tanks();
  wait_for_first_player();
  wait(4);
  level thread setup_player_tanks();

  wait(1);
  new_starts = [];
  for(i = 0; i < level.player_tanks.size; i++) {
    start_pt = getStruct("radio_tower start " + i, "targetname");
    if(isDefined(start_pt.target)) {
      warp_pt = getStruct(start_pt.target, "targetname");
    } else {
      warp_pt = start_pt;
    }
    if(isDefined(start_pt.script_noteworthy)) {
      level.current_advance_level = start_pt.script_noteworthy;
    }
    level.player_tanks[i].origin = warp_pt.origin;
    if(isDefined(level.player_tanks[i].current_node)) {
      level.player_tanks[i].current_node = warp_pt;
    }
    if(isDefined(level.player_tanks[i].target_node)) {
      level.player_tanks[i].target_node = warp_pt;
    }
  }

  do_area_spawn(1);
  wait_network_frame();
  spawn_area_two_infantry();

  level thread wait_for_group_spawn(2);
  level thread wait_for_group_spawn(3);

  level thread setup_airstrike_triggers();
}
wait_for_area_two_infantry() {
  trigger = GetEnt("group 1 spawn", "script_noteworthy");
  trigger waittill("trigger");

  if(flag("radio tower destroyed")) {
    return;
  }

  spawn_area_two_infantry();
}
spawn_area_two_infantry() {
  spawner_array = getEntArray("radio tower spawner", "script_noteworthy");
  array_thread(spawner_array, ::add_spawn_function, ::setup_radio_tower_infantry);
  array_thread(spawner_array, ::add_spawn_function, ::radio_tower_infantry_evasion);
  array_thread(spawner_array, ::add_spawn_function, ::radio_tower_infantry_grenades);

  spawner_array_2 = getEntArray("radio tower bunker spawner", "script_noteworthy");
  array_thread(spawner_array, ::add_spawn_function, ::setup_radio_tower_infantry);

  flood_spawner_array = getEntArray("radio tower floodspawners", "script_noteworthy");
  array_thread(flood_spawner_array, ::add_spawn_function, ::radio_tower_infantry_grenades);

  spawn_guys(spawner_array, undefined, true);
  spawn_guys(spawner_array_2, undefined, true);

  do_floodspawners("radio tower", 1);
}
add_radio_tower_objective(radiotower) {
  level endon("radio tower start alternate");

  level waittill("begin event 2");
  level notify("radio tower start normal");

  proceed_trigger = GetEnt("radio tower proceed trigger", "targetname");
  next_proceed_trigger = GetEnt("radio tower next proceed trigger", "targetname");

  thread do_radio_tower_owned_event();

  objective_add(2, "current");
  Objective_String(2, &"SEE2_PROCEED_RADIOTOWER");

  Objective_additionalPosition(2, 0, proceed_trigger.origin);

  proceed_trigger waittill("trigger");
  Objective_additionalPosition(2, 0, next_proceed_trigger.origin);

  next_proceed_trigger waittill("trigger");

  Objective_String(2, &"SEE2_DESTROY_RADIOTOWER");

  objective_additionalPosition(2, 0, radiotower.origin);

  while(1) {
    if(radiotower.model == "anim_seelow_radiotower_d") {
      flag_set("radio tower objective completed");
      Objective_State(2, "done");
      break;
    }
    wait(0.05);
  }
}

add_radio_tower_objective_alternate(radiotower) {
  level endon("radio tower start normal");

  objective_start_tower = GetEnt("radio tower next proceed trigger", "targetname");
  objective_start_tower waittill("trigger");

  level notify("radio tower start alternate");

  proceed_trigger = GetEnt("radio tower proceed trigger", "targetname");
  next_proceed_trigger = GetEnt("radio tower next proceed trigger", "targetname");

  thread do_radio_tower_owned_event();

  objective_add(2, "current");
  Objective_String(2, &"SEE2_DESTROY_RADIOTOWER");
  objective_additionalPosition(2, 0, radiotower.origin);

  while(1) {
    if(radiotower.model == "anim_seelow_radiotower_d") {
      flag_set("radio tower objective completed");
      Objective_State(2, "done");
      break;
    }
    wait(0.05);
  }
}
do_radio_tower_owned_event() {
  vig_trigger = getEnt("radio tower vig trigger", "script_noteworthy");

  vig_trigger waittill("trigger");

  enemy_tank = undefined;
  while(!isDefined(enemy_tank)) {
    enemy_tank = getEnt("radio tower vig tank", "script_noteworthy");
    wait(0.05);
  }

  friendly_tank = undefined;
  while(!isDefined(friendly_tank)) {
    friendly_tank = getEnt("radio tower owned tank", "script_noteworthy");
    wait(0.05);
  }

  enemy_tank setTurretTargetEnt(friendly_tank);
  friendly_tank setTurretTargetEnt(enemy_tank);

  enemy_tank thread dummy_fire_behavior();
  friendly_tank thread dummy_fire_behavior();

  friendly_tank thread friendly_tank_wait_for_enemy_tank_to_die(enemy_tank);
  enemy_tank thread enemy_tank_wait_for_friendly_tank_to_die(friendly_tank);
}

friendly_tank_wait_for_enemy_tank_to_die(enemy_tank) {
  self endon("death");

  self thread friendly_tank_wait_for_enemy_tank_die_then_move(enemy_tank);

  enemy_tank waittill("death");

  self.enemy_tank_dead = true;
  self notify("stop dummy firing");
  self notify("stop_burst_fire_unmanned");
  self notify("stop_using_built_in_burst_fire");
}

friendly_tank_wait_for_enemy_tank_die_then_move(enemy_tank) {
  self endon("death");
  self waittill("pink_tank_wait_here");
  self SetSpeed(0, 5, 5);

  while(!isDefined(self.enemy_tank_dead)) {
    wait(0.05);
  }

  self ResumeSpeed(5);
  self waittill("pink_tank_blow_up");
  RadiusDamage(self.origin, 200, 10000, 9999);
}

enemy_tank_wait_for_friendly_tank_to_die(friendly_tank) {
  self endon("death");
  friendly_tank waittill("death");

  self notify("stop dummy firing");
  self thread moving_firing_behavior();
}
dummy_fire_behavior() {
  self endon("stop dummy firing");
  self endon("death");

  while(1) {
    wait(randomintrange(2, 5));
    self fireweapon();
  }
}
#using_animtree("see2_models");
do_radio_tower_explode() {
  radiotower = getEnt("radio tower", "script_noteworthy");
  flag_init(radiotower.script_noteworthy + " destroyed");
  thread check_for_tower_damage(radiotower, 1500);
  level thread add_radio_tower_objective(radiotower);
  level thread add_radio_tower_objective_alternate(radiotower);

  level flag_wait(radiotower.script_noteworthy + " destroyed");

  playFX(level._effect["tower_explode"], radiotower.origin);
  radiotower setModel("anim_seelow_radiotower_d");
  radiotower.animname = "radiotower";
  radiotower SetAnimTree();

  wait(4);

  radiotower anim_single_solo(radiotower, "fall");
  playFX(level._effect["tower_secondary_explosion"], radiotower.origin);

  autosave_by_name("radio tower destroyed");

  level thread fuel_depot_objectives();
}
check_for_tower_damage(tower, amt) {
  count = 0;
  damage_trigger = GetEnt(tower.script_noteworthy + " damage trigger", "script_noteworthy");
  while(1) {
    damage_trigger waittill("damage", damage, other, direction, origin, damage_type);
    if(array_check_for_dupes(get_players(), other) || !explosive_damage(damage_type)) {
      continue;
    }
    count += damage;
    if(count >= amt) {
      flag_set(tower.script_noteworthy + " destroyed");
      return;
    }
    wait(0.05);
  }
}
setup_radio_tower_infantry() {
  self endon("death");

  level.enemy_infantry = array_add(level.enemy_infantry, self);
  self thread enforce_flame_deaths();
  if(self.classname == "actor_axis_ger_ber_wehr_reg_panzerschrek") {
    self setThreatBiasGroup("enemy antitank");
    self thread do_antitank_AI();
    self set_ent_see2_bias_group("enemy antitank");
    self.a.rockets = 200;
    self.maxsightdistsqrd = 3000 * 3000;
    self.a.no_weapon_switch = true;
    self.goalradius = 128;
  } else {
    self setThreatBiasGroup("enemy infantry");
    self set_ent_see2_bias_group("enemy infantry");
    self.goalradius = 128;
  }
}
fuel_depot_begin() {
  flag_set("flak 88s destroyed");
  flag_set("radio tower destroyed");

  thread do_sound_for_event("battlechatter");

  level thread setup_early_tanks();
  wait_for_first_player();
  wait(4);
  level thread setup_player_tanks();

  do_area_spawn(2);
  wait_network_frame();

  spawn_area_three_infantry();

  level thread wait_for_group_spawn(3);

  level thread wait_for_area_four_infantry();
  level thread setup_airstrike_triggers();
}
fuel_depot_objectives() {
  if(flag("final battle already started")) {
    return;
  }

  start_trigger = getEnt("finalbattle_trigger", "script_noteworthy");

  objective_add(3, "current");
  Objective_String(3, &"SEE2_REJOIN_ARMY");
  Objective_additionalPosition(3, 0, start_trigger.origin);

  while(1) {
    start_trigger waittill("trigger", guy);
    if(isPlayer(guy)) {
      break;
    }
  }

  autosave_by_name("fuel supplies destroyed");

  level thread wait_for_finalbattle();
}
wait_for_finalbattle_alternate() {
  start_trigger = GetEnt("finalbattle_trigger", "script_noteworthy");
  start_trigger waittill("trigger");

  wait(0.2);

  if(!flag("final battle already started")) {
    level thread wait_for_finalbattle(true);
  }
}
do_tiger_retreats() {
  for(i = 1;; i++) {
    retreat_tiger = GetEnt("retreat tiger " + i, "script_noteworthy");
    retreat_endpoint = getVehicleNode("end retreat tiger " + i, "script_noteworthy");
    if(!isDefined(retreat_tiger) || !isDefined(retreat_endpoint)) {
      break;
    }
    retreat_tiger setWaitNode(retreat_endpoint);
    retreat_tiger thread wait_for_retreat_done();
  }
}
wait_for_retreat_done() {
  self waittill("reached_wait_node");

  self delete();
}
wait_for_area_three_infantry() {
  trigger = GetEnt("group 2 spawn", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }

  trigger waittill("trigger");

  if(flag("fuel depot cleared")) {
    return;
  }

  spawn_area_three_infantry();
}
spawn_area_three_infantry() {
  spawner_array = getEntArray("fuel depot spawner", "script_noteworthy");
  array_thread(spawner_array, ::add_spawn_function, ::setup_fuel_depot_infantry);
  array_thread(spawner_array, ::add_spawn_function, ::fuel_depot_infantry_evasion);

  spawn_guys(spawner_array, undefined, true);
}
setup_fuel_depot_infantry() {
  self endon("death");

  level.enemy_infantry = array_add(level.enemy_infantry, self);
  self thread enforce_flame_deaths();
  if(self.classname == "actor_axis_ger_ber_wehr_reg_panzerschrek") {
    self setThreatBiasGroup("enemy antitank");

    self set_ent_see2_bias_group("enemy antitank");
    self.a.rockets = 200;
    self.maxsightdistsqrd = 3000 * 3000;
    self.a.no_weapon_switch = true;
    self.goalradius = 128;
    self thread do_antitank_AI();
  } else {
    self setThreatBiasGroup("enemy infantry");
    self set_ent_see2_bias_group("enemy infantry");
    self.goalradius = 128;
  }
}
air_strike_begin() {
  flag_set("flak 88s destroyed");
  flag_set("radio tower destroyed");
  flag_set("fuel depot cleared");

  thread do_sound_for_event("battlechatter");

  level thread setup_early_tanks();
  wait_for_first_player();
  wait(4);
  thread setup_player_tanks();
  wait(5);
  do_victory_scene(true);
}
wait_for_area_four_infantry() {
  trigger = GetEnt("group 3 spawn", "script_noteworthy");
  trigger waittill("trigger");

  if(flag("final line breached")) {
    return;
  }

  spawn_area_four_infantry();
}
spawn_area_four_infantry() {
  spawner_array = getEntArray("final battle spawner", "script_noteworthy");

  spawn_guys(spawner_array, undefined, true);
}
do_final_battle_fortify() {
  mg_array = getEntArray("holdout mg", "script_noteworthy");
  for(i = 0; i < mg_array.size; i++) {
    mg_array[i].script_fireondrones = 1;
    mg_array[i] setturretignoregoals(true);
    mg_array[i] thread maps\_mgturret::mg42_target_drones(undefined, "axis", undefined);
  }
}
setup_airstrike_triggers() {
  airstrike_triggers = getEntArray("airstrike_trigger", "script_noteworthy");

  for(i = 0; i < airstrike_triggers.size; i++) {
    airstrike_triggers[i] thread wait_for_airstrike();
  }
}
wait_for_airstrike() {
  level.see2_max_tank_target_dist = 6000;
  level.see2_max_tank_firing_dist = 5000;
  while(1) {
    self waittill("trigger", ent);

    if(flag("final line breached")) {
      return;
    }

    ent notify("fire rockets");

    wait(0.05);
  }
}
setup_airstrike_planes() {
  rocket_planes = getEntArray("rocket plane", "script_noteworthy");
  level.rocket_planes = rocket_planes;

  for(i = 0; i < rocket_planes.size; i++) {
    rocket_planes[i].rockets = [];
    rocket_planes[i].rocket_tags = [];
    for(j = 1; j < 3; j++) {
      left_tag = "tag_smallbomb0" + j + "Left";
      right_tag = "tag_smallbomb0" + j + "Right";
      shreck = spawn("script_model", rocket_planes[i] getTagOrigin(left_tag));
      shreck.angles = rocket_planes[i] getTagAngles(left_tag);
      shreck setModel("katyusha_rocket");
      shreck linkto(rocket_planes[i], left_tag);
      rocket_planes[i].rockets = array_add(rocket_planes[i].rockets, shreck);
      rocket_planes[i].rocket_tags = array_add(rocket_planes[i].rocket_tags, left_tag);
      wait_network_frame();
      shreck = spawn("script_model", rocket_planes[i] getTagOrigin(right_tag));
      shreck.angles = rocket_planes[i] getTagAngles(right_tag);
      shreck setModel("katyusha_rocket");
      shreck linkto(rocket_planes[i], right_tag);
      rocket_planes[i].rockets = array_add(rocket_planes[i].rockets, shreck);
      rocket_planes[i].rocket_tags = array_add(rocket_planes[i].rocket_tags, right_tag);
      wait_network_frame();
    }

    for(z = 0; z < rocket_planes[i].rockets.size; z++) {
      rocket_planes[i].rockets[z] Hide();
    }

    rocket_planes[i] thread wait_for_fire_rockets();
  }

  level thread run_airstrike_planes();
}
run_airstrike_planes() {
  start_move_triggers = [];
  start_move_triggers = getEntArray("rocket_plane_starts", "targetname");

  start_trigger = getEnt("finalbattle_trigger", "script_noteworthy");
  start_trigger waittill("trigger");

  for(i = 0; i < level.rocket_planes.size; i++) {
    for(z = 0; z < level.rocket_planes[i].rockets.size; z++) {
      level.rocket_planes[i].rockets[z] Hide();
    }
    level.rocket_planes[i] thread DeleteMeAtEndOfPath();
  }

  player = get_players()[0];
  for(i = 0; i < start_move_triggers.size; i++) {
    start_move_triggers[i] UseBy(player);

    level.rocket_planes[i] thread bomber_planes();
    wait(1.5);
  }
}
bomber_planes() {
  while(distance(self.origin, GetPlayers()[0].origin) > 10000) {
    wait(.01);
  }
  self playSound("fly_by");
}

DeleteMeAtEndOfPath() {
  self waittill("reached_end_node");
  self Delete();
}
wait_for_fire_rockets() {
  self endon("death");

  self waittill("fire rockets");
  targetnodes = [];
  for(i = 1; i <= self.rockets.size; i++) {
    targetnodes = array_add(targetnodes, getStruct(self.targetname + " target node " + i, "script_noteworthy"));
  }
  for(j = 0; j < self.rockets.size; j++) {
    self.rockets[j] thread fire_rocket_at_pos(targetnodes[j]);
    wait(randomintrange(1, 2));
  }
}
fire_rocket_at_pos(target_struct) {
  start_pos = self.origin;
  end_pos = target_struct.origin;
  angles = vectortoangles(end_pos - start_pos);
  self.angles = angles;
  distance = distance(start_pos, end_pos);
  time = distance / 4200;

  self unlink();
  self moveTo(end_pos, time);
  playFXOnTag(level._effect["pc132_trail"], self, "tag_fx");
  self playLoopSound("rpg_rocket");
  wait time;

  self hide();

  playFX(level._effect["pc132_explode"], self.origin);

  self stoploopsound();
  playSoundAtPosition("rpg_impact_boom", self.origin);
  radiusdamage(self.origin, 256, 250, 250);
  earthquake(0.5, 1.5, self.origin, 512);

  wait(4);
  self delete();
}
wait_for_finalbattle(skipped_radio) {
  flag_set("final battle already started");

  wait(1);

  tanks = getEntArray("obj tanks", "targetname");

  if(!isDefined(skipped_radio)) {
    Objective_State(3, "done");
  }

  Objective_add(4, "current");
  Objective_String(4, &"SEE2_BREAK_THE_LINE");

  autosave_by_name("line broken");

  level thread do_victory_scene();
}
do_victory_scene(jumpto) {
  if(!isDefined(jumpto)) {
    victory_trigger = GetEnt("victory trigger", "targetname");
    obj_trigger = GetEnt("special obj trigger", "targetname");

    Objective_additionalPosition(4, 0, obj_trigger.origin);
    guy = undefined;

    while(1) {
      victory_trigger waittill("trigger", guy);
      if(!isPlayer(guy)) {
        continue;
      } else {
        break;
      }
    }
  }

  level.nextmission_cleanup = ::clean_up_fadeout_hud;
  level notify("kill the audio queue");

  if(!flag("flak objective completed")) {
    Objective_state(1, "failed");
  }

  if(!flag("radio tower objective completed")) {
    Objective_state(2, "failed");
  }

  Objective_state(4, "done");

  flag_clear("battlechatter allowed");

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread magic_bullet_shield();
    if(!isDefined(jumpto)) {
      players[i] FreezeControls(true);
    }
  }

  for(i = 0; i < level.enemy_armor.size; i++) {
    if(isDefined(level.enemy_armor[i]) && isDefined(level.enemy_armor[i].health)) {
      level.enemy_armor[i].health = 1;
      radiusDamage(level.enemy_armor[i].origin, 1000, 10, 10);
    }
  }

  level.enemy_infantry = GetAIArray("axis");
  for(i = 0; i < level.enemy_infantry.size; i++) {
    if(isDefined(level.enemy_infantry[i]) && isDefined(level.enemy_infantry[i].health)) {
      level.enemy_infantry[i] thread bloody_death(0.2);
    }
  }

  wait(0.75);

  players[0].myTank playSound(level.scr_sound["commissar"]["victory1"], "commissar done");
  players[0].myTank waittill_notify_or_timeout("commissar done", 10);

  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvar("hud_showStance", "0");
    players[i] SetClientDvar("miniscoreboardhide", 1);
  }
  level thread fade_to_black(2);

  players[0].myTank playSound(level.scr_sound["commissar"]["victory2"], "commissar done");
  players[0].myTank waittill_notify_or_timeout("commissar done", 10);
  players[0].myTank playSound(level.scr_sound["commissar"]["victory3"], "commissar done");
  players[0].myTank waittill_notify_or_timeout("commissar done", 10);

  share_screen(get_host(), true, true);

  wait(1);

  for(i = 0; i < players.size; i++) {
    players[i].myTank MakeVehicleUsable();
    players[i].myTank UseBy(players[i]);
    wait(0.05);
    players[i].myTank MakeVehicleUnusable();
  }

  wait(0.05);

  link = getent("player_temp_ending_pos", "script_noteworthy");
  anim_node = getent("temp_center", "targetname");

  players[0] TakeWeapon("m2_flamethrower");

  for(i = 0; i < players.size; i++) {
    players[i] hide();
    players[i] setorigin(link.origin + (0, 0, 4));
    players[i] setplayerangles(link.angles);
    players[i] notify("stop damage hud");
    players[i] disableWeapons();

    if(i != 0) {
      level.otherPlayersSpectate = true;
      level.otherPlayersSpectateClient = players[0];

      players[i] thread maps\_callbackglobal::spawnSpectator();
    }
  }

  level notify("walla");
  level thread maps\see2_anim::play_player_anim_outro(0, players[0], anim_node);
  level thread play_center_car_anims_side();
  level thread play_center_car_anims_middle();

  while(!flag("player_ready_for_outro") || !flag("outro_group_1_ready") || !flag("outro_group_2_ready")) {
    wait(0.05);
  }

  level thread fade_from_black(2);
  wait(34);
  level notify("audio_fade");

  level thread fade_to_black(2);
  wait(2);
  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvar("miniscoreboardhide", 0);
  }

  thread nextmission();
  wait(0.5);
  share_screen(get_host(), false, false);
}

clean_up_fadeout_hud() {
  if(isDefined(level.fadetoblack)) {
    level.fadetoblack Destroy();
  }
}
play_center_car_anims_side() {
  anim_node = getent("temp_center", "targetname");

  guys = [];

  left_spawn_points = getStructArray("center_car_guy_left", "targetname");

  guys[0] = spawn_fake_guy_outro(left_spawn_points[1].origin, left_spawn_points[1].angles, "guyl2");
  guys[1] = spawn_fake_guy_outro(left_spawn_points[2].origin, left_spawn_points[2].angles, "guyl3");
  guys[2] = spawn_fake_guy_outro(left_spawn_points[3].origin, left_spawn_points[3].angles, "guyl4");
  guys[3] = spawn_fake_hero_outro(left_spawn_points[4].origin, left_spawn_points[4].angles, "guyl5", "chernov");

  right_spawn_points = getStructArray("center_car_guy_left", "targetname");

  guys[4] = spawn_fake_guy_outro(right_spawn_points[0].origin, right_spawn_points[0].angles, "guyr1");
  guys[5] = spawn_fake_guy_outro(right_spawn_points[1].origin, right_spawn_points[1].angles, "guyr2");

  flag_set("outro_group_1_ready");

  while(!flag("player_ready_for_outro") || !flag("outro_group_1_ready") || !flag("outro_group_2_ready")) {
    wait(0.05);
  }

  anim_node anim_single(guys, "outro");
}
#using_animtree("generic_human");
play_center_car_anims_middle() {
  anim_node = getent("temp_center", "targetname");

  guys = [];

  center_spawn_points = getStructArray("center_car_guy_center", "targetname");

  guys[0] = spawn_fake_hero_outro(center_spawn_points[0].origin, center_spawn_points[0].angles, "guyc1", "chernov");
  guys[1] = spawn_fake_guy_outro(center_spawn_points[1].origin, center_spawn_points[1].angles, "guyc2");
  guys[2] = spawn_fake_hero_outro(center_spawn_points[2].origin, center_spawn_points[2].angles, "guyc3", "reznov");

  guys[3] = spawn_fake_guy_outro(center_spawn_points[3].origin, center_spawn_points[3].angles, "guyc4");

  guys[4] = spawn_fake_guy_outro(center_spawn_points[4].origin, center_spawn_points[4].angles, "guyc5");
  guys[5] = spawn_fake_guy_outro(center_spawn_points[5].origin, center_spawn_points[5].angles, "guyc6");

  flag_set("outro_group_2_ready");

  while(!flag("player_ready_for_outro") || !flag("outro_group_1_ready") || !flag("outro_group_2_ready")) {
    wait(0.05);
  }

  anim_node anim_single(guys, "outro");
}
spawn_fake_guy_outro(startpoint, startangles, anim_name) {
  while(!OkTospawn()) {
    wait(0.05);
  }

  guy = spawn("script_model", startpoint);
  guy.angles = startangles;

  guy character\char_rus_r_rifle::main();
  guy maps\_drones::drone_allies_assignWeapon_russian();
  guy attach("weapon_rus_mosinnagant_rifle", "tag_weapon_right");

  guy.team = "allies";
  guy.for_ai_print = 1;
  guy.a = guy;

  guy UseAnimTree(#animtree);
  guy.animname = anim_name;
  guy makeFakeAI();
  guy.health = 100;

  return guy;
}
spawn_fake_hero_outro(startpoint, startangles, anim_name, heroname) {
  guy = spawn("script_model", startpoint);
  guy.angles = startangles;

  if(heroname == "reznov") {
    guy character\char_rus_h_reznov_coat::main();
  } else {
    guy character\char_rus_p_chernova::main();
    guy attach("weapon_rus_mosinnagant_rifle", "tag_weapon_right");
  }
  guy maps\_drones::drone_allies_assignWeapon_russian();

  guy.team = "allies";
  guy.a = guy;

  guy UseAnimTree(#animtree);
  guy.animname = anim_name;
  guy makeFakeAI();
  guy.health = 100;

  return guy;
}
fade_to_black(fadeTime) {
  if(!isDefined(fadeTime)) {
    fadeTime = 5;
  }

  level.fadetoblack = NewHudElem();
  level.fadetoblack.x = 0;
  level.fadetoblack.y = 0;
  level.fadetoblack.alpha = 0;

  level.fadetoblack.horzAlign = "fullscreen";
  level.fadetoblack.vertAlign = "fullscreen";
  level.fadetoblack.foreground = false;
  level.fadetoblack.sort = 50;
  level.fadetoblack SetShader("black", 640, 480);

  level.fadetoblack FadeOverTime(fadeTime);
  level.fadetoblack.alpha = 1;
}
fade_from_black(fadeTime) {
  if(!isDefined(fadeTime)) {
    fadeTime = 5;
  }

  level.fadetoblack FadeOverTime(fadeTime);
  level.fadetoblack.alpha = 0;
}

debug_ai_prints() {
  if(getDvar("debug_ai_print") == "") {
    setDvar("debug_ai_print", "0");
  }

  if(getDvar("debug_ai_print_range") == "") {
    setDvar("debug_ai_print_range", "1000");
  }

  level.debug_ai_print = false;
  while(1) {
    wait(0.5);

    if(getDvar("debug_ai_print") == "0") {
      level.debug_ai_print = false;
      continue;
    }

    level.debug_ai_print = true;

    ai = getEntArray("script_model", "classname");

    for(i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].for_ai_print)) {
        ai[i] thread debug_ai_prints_thread();
      }
    }
  }
}

debug_ai_prints_thread() {
  self endon("death");

  if(isDefined(self.ai_print)) {
    return;
  }

  self.ai_print = true;

  while(level.debug_ai_print) {
    range = GetDvarInt("debug_ai_print_range");
    player = get_host();
    if(DistanceSquared(player.origin, self.origin) < range * range) {
      print3d(self.origin + (0, 0, 72), self get_debug_ai_print());
      wait(0.05);
    } else {
      wait(0.2);
    }
  }

  self.ai_print = false;
}

get_debug_ai_print() {
  dvar = getDvar("debug_ai_print");
  switch (dvar) {
    case "script_noteworthy":
      value = self.script_noteworthy;
      break;
    case "threatbias":
      value = self.threatbias;
      break;
    case "getthreatbiasgroup":
      value = self GetThreatBiasGroup();
      break;
    case "accuracy":
      value = self.accuracy;
      break;
    case "ignoreme":
      value = self.ignoreme;
      break;
    case "ignoreall":
      value = self.ignoreall;
      break;
    case "health":
      value = self.health;
      break;
    case "goalradius":
      value = self.goalradius;
      break;
    case "moveplaybackrate":
      value = self.moveplaybackrate;
      break;
    case "animname":
      value = self.animname;
      break;
    case "script_forcecolor":
      if(isDefined(self.script_forceColor)) {
        value = self.script_forceColor;
      } else {
        value = "undefined";
      }
      break;
    case "player_seek":
      if(isDefined(self.player_seek)) {
        value = self.player_seek;
      } else {
        value = "undefined";
      }
      break;
    default:
      value = "undefined";
  }

  if(!isDefined(value)) {
    value = "no animname";
  }

  return value;
}