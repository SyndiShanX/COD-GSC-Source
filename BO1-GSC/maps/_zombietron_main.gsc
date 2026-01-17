/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_main.gsc
**************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#include maps\_music;
#include maps\_zombietron_utility;
#include maps\_busing;

save_restore_callback() {
  wait 0.75;
  move_players_to_start();
  fade_in();
}

init_client_flags() {
  level._ZT_ACTOR_CF_GIB_DEATH_P1 = 2;
  level._ZT_ACTOR_CF_GIB_DEATH_P2 = 3;
  level._ZT_ACTOR_CF_GIB_DEATH_P3 = 4;
  level._ZT_ACTOR_CF_GIB_DEATH_P4 = 5;
  level._ZT_ACTOR_CF_BLOOD = 6;
  level._ZT_ACTOR_CF_LAUNCH_AND_BURN = 7;
  level._ZT_ACTOR_CF_KILLED_BY_HELI = 8;
  level._ZT_SCRIPTMOVER_CF_SACRED_COW = 0;
  level._ZT_SCRIPTMOVER_CF_POWERUP = 1;
  level._ZT_SCRIPTMOVER_CF_ELEC_TRAP = 2;
  level._ZT_PLAYER_CF_UPDATEPROFILE = 10;
  level._ZT_PLAYER_CF_HELI_PILOT = 11;
  level._ZT_PLAYER_CF_LIGHTNING = 12;
  level._ZT_PLAYER_CF_SHOW_SCORES = 13;
  level._ZT_PLAYER_CF_START_SMART_BOMB = 14;
}

main() {
  level thread fade_out(.1);
  level.zombiemode = true;
  level.zombietron_mode = true;
  level.reviveFeature = false;
  level.contextualMeleeFeature = false;
  level.swimmingFeature = false;
  init_client_flags();
  maps\_zombietron_load::main();
  maps\_zombietron_spawner::init();
  maps\_zombietron_pickups::init();
  maps\_zombietron_weapon::main();
  level thread maps\_zombietron_fate::main();
  init_function_overrides();
  DisableGrenadeSuicide();
  level thread maps\zombietron::onPlayerConnect();
  level thread post_all_players_connected();
  level thread players_playing();
  level thread init_difficulty();
  level thread maps\_zombietron_ai_ape::ape_taunt_player();
  level thread maps\_zombietron_ai_buffalo::buffalo_stampede_monitor();
  level thread maps\_zombietron_challenges::barrel_challenge_monitor();
  OnSaveRestored_Callback(::save_restore_callback);
  level.onMenuMessage = maps\zombietron::menu_message;
  level thread setup_ambient_fx();
  level.startInvulnerableTime = GetDvarInt(#"player_deathInvulnerableTime");
  level thread detect_and_change_music_states();
  if(isDefined(level.custom_ai_type)) {
    for(i = 0; i < level.custom_ai_type.size; i++) {
      [
        [level.custom_ai_type[i]]
      ]();
    }
  }
  initZombieLeaderboardData();
  if(IsSplitScreen()) {
    halfway_height = 10000;
    cull_dist = 10000;
    set_splitscreen_fog(350, 2986.33, halfway_height, -480, 0.805, 0.715, 0.61, 0.0, cull_dist);
  }
  if(!isDefined(level.survived_msg)) {
    level.survived_msg = NewHudElem(level);
    level.survived_msg.alignX = "center";
    level.survived_msg.alignY = "middle";
    level.survived_msg.horzAlign = "center";
    level.survived_msg.vertAlign = "middle";
    level.survived_msg.y += 20;
    level.survived_msg.foreground = true;
    level.survived_msg.fontScale = 2;
    level.survived_msg.color = (1.0, 0.0, 0.0);
    level.survived_msg.hidewheninmenu = true;
    if(isSplitScreen()) {
      level.survived_msg.y += 30;
    }
  }
  if(!isDefined(level.msg_t3)) {
    level.msg_t3 = NewHudElem(level);
    level.msg_t3.alignX = "center";
    level.msg_t3.alignY = "middle";
    level.msg_t3.horzAlign = "center";
    level.msg_t3.vertAlign = "middle";
    level.msg_t3.y += 40;
    level.msg_t3.foreground = true;
    level.msg_t3.fontScale = 1.25;
    level.msg_t3.color = (1.0, 0.0, 0.0);
    level.msg_t3.hidewheninmenu = true;
    if(isSplitScreen()) {
      level.msg_t3.y += 30;
    }
  }
}

arena_findIndexByName(name) {
  for(i = 0; i < level.arenas.size; i++) {
    if(level.arenas[i] == name) {
      return i;
    }
  }
  return undefined;
}

arena_initialize() {
  level.arenas = [];
  level.arenas[level.arenas.size] = "island";
  level.arenas[level.arenas.size] = "town";
  level.arenas[level.arenas.size] = "prison";
  level.arenas[level.arenas.size] = "temple";
  level.arenas[level.arenas.size] = "factory";
  level.arenas[level.arenas.size] = "rooftop";
  level.arenas[level.arenas.size] = "street";
  level.arenas[level.arenas.size] = "bunker";
  level.arenas[level.arenas.size] = "snow";
  level.arenas[level.arenas.size] = "jungle";
  level.current_arena = 0;
  level.arena_laps = 0;
  level.raw_round = 0;
  setup_exits();
}

init_difficulty() {
  self notify("init_difficulty");
  self endon("init_difficulty");
  while(1) {
    self waittill("change_difficulty");
  }
}

player_reset_score() {
  self.score = 0;
  self.lives = 3;
  self.bombs = 1;
  self.boosters = 2;
  self maps\_zombietron_score::update_multiplier_bar(0);
  self maps\_zombietron_score::update_hud();
}

players_playing() {
  self notify("players_playing");
  self endon("players_playing");
  while(1) {
    players = get_players();
    if(!isDefined(level.players_playing) || players.size != level.players_playing) {
      level notify("change_difficulty");
    }
    level.players_playing = players.size;
    wait(1);
  }
}

intermission_monitor() {
  while(1) {
    level.in_intermission = false;
    level waittill("exit_taken");
    level.in_intermission = true;
    level waittill("fade_in_complete");
  }
}

post_all_players_connected() {
  self notify("post_all_players_connected");
  self endon("post_all_players_connected");
  flag_wait("all_players_connected");
  bbPrint("sessions: mapname %s gametype zt isserver 1 player_count %d", level.script, get_players().size);
  level thread fade_in(1);
  players = GetPlayers();
  wait 0.2;
  move_players_to_start();
  level thread end_game();
  level thread begin_game();
  level thread intermission_monitor();
}

mini_boss_spawn_think() {
  level endon("round_spawning_done");
  while(1) {
    time = randomFloatRange(level.zombie_vars["mini_boss_interval_min"], level.zombie_vars["mini_boss_interval_max"]);
    time = time / GetPlayers().size;
    time -= (level.round_number / 10);
    if(time < 1)
      time = 1;
    wait(time);
    if(randomInt(100) < (level.zombie_vars["mini_boss_spawn_percentage"] + (level.round_number * GetPlayers().size))) {
      spawn_locations = level.current_spawners[level.current_wave.spawn_side];
      spawn_point = spawn_locations[randomInt(spawn_locations.size)];
      maps\_zombietron_spawner::spawn_a_mini_boss(spawn_point);
      if(GetPlayers().size == 4) {
        spawn_locations = level.current_spawners[level.current_wave.spawn_side];
        spawn_point = spawn_locations[randomInt(spawn_locations.size)];
        maps\_zombietron_spawner::spawn_a_mini_boss(spawn_point, "engineer", true);
      }
    }
  }
}

wave_spawn(current_wave) {
  spawn_locations = level.current_spawners[current_wave.spawn_side];
  time = current_wave.spawn_duration;
  time = (time * 1000) + GetTime();
  while(GetTime() < time) {
    ai = undefined;
    spawn_point = spawn_locations[randomInt(spawn_locations.size)];
    if(isDefined(level.challenge) && isDefined(level.challenge.spawner)) {
      if(isDefined(level.challenge.spawner_secondary_type) && isDefined(level.challenge.spawner_secondary_chance)) {
        if(randomInt(100) < level.challenge.spawner_secondary_chance) {
          ai = maps\_zombietron_spawner::spawn_a_mini_boss(spawn_point, level.challenge.spawner_secondary_type);
        }
      }
      if(!isDefined(ai))
        ai = maps\_zombietron_spawner::spawn_a_mini_boss(spawn_point, level.challenge.type);
    } else {
      ai = spawn_zombie(spawn_point);
    }
    wait current_wave.spawn_delay;
    wait_network_frame();
    if(isDefined(level.desiredRound)) {
      break;
    }
    if(flag("all_players_dead")) {
      break;
    }
    if(flag("boss_is_spawned") && flag("boss_is_dead")) {
      break;
    }
  }
}

round_zombie_counter(waitTime) {
  level.zombie_count = undefined;
  wait waitTime;
  zombies = GetAISpeciesArray("axis", "all");
  while(flag("round_is_active") || zombies.size > 0) {
    zombies = GetAISpeciesArray("axis", "all");
    level.zombie_count = zombies.size;
    wait 1;
  }
}

round_spawning() {
  level notify("round_spawning_starting");
  level.round_start_time = GetTime();
  level.round_end_time = undefined;
  if(level.epic_boss_battle == true) {
    flag_wait("boss_intro_done");
  }
  if(level.RandomMiniBosses.size > 0) {
    level thread mini_boss_spawn_think();
  }
  spawn_set = level.arenas[level.current_arena] + "_spawner";
  level.current_spawners = level.spawners[spawn_set];
  assertex(isDefined(level.current_spawners), "No Spawenrs set up for zombietron environment.");
  flag_set("round_is_active");
  level thread round_zombie_counter(8);
  for(wave = 0; wave < level.spawn_sequence.size; wave++) {
    if(flag("all_players_dead")) {
      break;
    }
    if(flag("boss_is_spawned")) {
      if(flag("boss_is_dead")) {
        break;
      } else {
        if(wave == level.spawn_sequence.size - 1) {
          wave -= RandomIntRange(4, 10);
          if(wave < 0) wave = 0;
        }
      }
    }
    if(isDefined(level.desiredRound)) {
      break;
    }
    level.current_wave = level.spawn_sequence[wave];
    thread wave_spawn(level.current_wave);
    wait level.current_wave.time_till_next_group;
  }
  flag_clear("round_is_active");
  level notify("round_spawning_done");
  level.round_end_time = GetTime();
  wait 1;
  zombies = GetAISpeciesArray("axis", "all");
  array_thread(zombies, maps\_zombietron_spawner::zombie_killer_failsafe);
}

get_all_the_map_spawners_on_side(side) {
  spawners = [];
  for(i = 0; i < level.current_spawners[side].size; i++) {
    spawner = level.current_spawners[side][i];
    spawners[spawners.size] = spawner;
  }
  return spawners;
}

get_all_the_map_spawners() {
  spawners = [];
  top = get_all_the_map_spawners_on_side("top");
  bottom = get_all_the_map_spawners_on_side("bottom");
  left = get_all_the_map_spawners_on_side("left");
  right = get_all_the_map_spawners_on_side("right");
  for(i = 0; i < top.size; i++) {
    spawners[spawners.size] = top[i];
  }
  for(i = 0; i < bottom.size; i++) {
    spawners[spawners.size] = bottom[i];
  }
  for(i = 0; i < right.size; i++) {
    spawners[spawners.size] = right[i];
  }
  for(i = 0; i < left.size; i++) {
    spawners[spawners.size] = left[i];
  }
  return spawners;
}

get_opposite_side(side) {
  if(side == "top")
    return "bottom";
  if(side == "bottom")
    return "top";
  if(side == "left")
    return "right";
  if(side == "right")
    return "left";
  assertex(0, "side parameter was not handled");
}

get_random_side() {
  chance = randomInt(4);
  if(chance == 0) {
    return "top";
  } else if(chance == 1) {
    return "bottom";
  } else if(chance == 2) {
    return "left";
  } else if(chance == 3) {
    return "right";
  }
}

create_spawn_group(wave_number) {
  wave = spawnStruct();
  wave.type = "zombies";
  wave.spawn_duration = 1 + RandomFloatRange(0, 1 + wave_number * .3) + RandomFloatRange(0, 1 + level.round_number * .2);
  wave.spawn_delay = .6;
  wave.spawn_side = get_random_side();
  wave.time_till_next_group = 1 + RandomFloatRange(0, wave.spawn_duration);
  return wave;
}

setup_spawn_sequence() {
  level.spawn_sequence = [];
  max = level.zombie_vars["zombie_max_waves"] + (level.arena_laps * level.zombie_vars["zombie_max_waves"]);
  waves = 6 + level.round_number;
  if(waves > max) {
    waves = max;
  }
  for(i = 0; i < waves; i++) {
    level.spawn_sequence[i] = create_spawn_group(i);
  }
}

player_basic_needs() {
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(!isAlive(players[i]) && players[i].lives == 0) {
      players[i] player_respawn_now();
    }
    if(players[i].boosters < 1) {
      players[i].boosters = 1;
      players[i] maps\_zombietron_score::update_hud();
    }
    if(isDefined(players[i].fate) && players[i].fate == "furious_feet") {
      if(players[i].boosters < 3) {
        players[i].boosters = 3;
        players[i] maps\_zombietron_score::update_hud();
      }
    }
  }
}

update_next_arena() {
  ClearAllCorpses();
  player_basic_needs();
  reportmtu(level.round_number);
  level.raw_round++;
  if(level.arena_round_number <= level.zombie_vars["zombie_arena_rounds"]) {
    if(level.flipped) {
      level.flipped = false;
    } else {
      level.flipped = true;
    }
    return;
  }
  level.arena_round_number = 1;
  level.current_arena++;
  if(level.current_arena >= level.arenas.size) {
    level.current_arena = 0;
    level.arena_laps++;
  }
  if(level.current_arena == arena_findIndexByName("temple")) {
    maps\_zombietron_scenes::hide_temple_props("none");
  }
}

end_of_round_cleanup() {
  if(level.arenas[level.current_arena] == "prison") {
    players = GetPlayers();
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].heli)) {
        players[i] notify("heli_abort");
      }
    }
  }
}

begin_game() {
  level endon("all_players_dead");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].default_movespeed = 1.0;
    players[i] SetMoveSpeedScale(players[i].default_movespeed);
    players[i] TakeAllWeapons();
    players[i] freezeControls(true);
    players[i] SetClientDvars("miniscoreboardhide", "0", "player_topDownCamOffset", (0, -15, 650), "player_TopDownCamAngles", (75, 0, 0), "player_topDownCamMode", "3");
    players[i] SetClientDvars("zombietron_discovered", 1);
  }
  wait 0.5;
  players = get_players();
  players[0] clearclientflag(level._ZT_PLAYER_CF_SHOW_SCORES);
  for(i = 0; i < players.size; i++) {
    players[i] setclientflag(level._ZT_PLAYER_CF_UPDATEPROFILE);
    players[i] giveachievement_wrapper("SP_ZOM_FLAMINGBULL");
    players[i] freezeControls(false);
  }
  wait 1;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] freezeControls(false);
  }
  maps\zombietron::force_game_controller_bindings();
  flag_clear("all_players_dead");
  while(1) {
    if(level.magical_exit_taken) {
      maps\_zombietron_pickups::clear_all_pickups();
      if(isDefined(level.magical_exit_armory)) {
        level thread maps\_zombietron_pickups::spawn_armory();
      } else {
        level thread maps\_zombietron_pickups::spawn_bonus_room();
      }
      open_exits();
      level.magical_exit_taken = false;
      level.magical_exit_armory = undefined;
      update_next_arena();
      maps\_zombietron_pickups::clear_all_pickups();
      maps\_zombietron_pickups::spawn_mines();
      move_players_to_start();
      level notify("change_music_state");
      fade_in();
      continue;
    } else {
      level.magical_exit_taken = false;
      level.magical_exit_armory = undefined;
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i] setClientDvar("cg_drawFriendlyNames", 0);
      }
      setup_spawn_sequence();
      level thread maps\_zombietron_challenges::try_to_start_challenge_round(level.round_number);
      round_spawning();
      waittill_all_zombies_dead();
      level notify("all_zombies_dead");
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i] setClientDvar("cg_drawFriendlyNames", 1);
      }
      if(level.epic_boss_battle == false) {
        maps\_zombietron_pickups::spawn_treasure(level.zombie_vars["zombie_treasure_regular"]);
      } else {
        maps\_zombietron_pickups::spawn_treasure(level.zombie_vars["zombie_treasure_boss"]);
      }
      level.round_number++;
      level.arena_round_number++;
      level.zombie_move_speed += level.zombie_vars["zombie_speed_inc"];
      level.zombie_health += level.zombie_vars["zombie_health_inc"];
      end_of_round_cleanup();
      if(level.arena_round_number <= level.zombie_vars["zombie_arena_rounds"]) {
        if(!isDefined(level.desiredRound)) {
          if(level.epic_boss_battle == false) {
            level notify("APE_TAUNT_GO");
          }
          open_exits();
          if(maps\_zombietron_fate::time_to_choose_fate()) {
            level.magical_exit_taken = false;
            level.magical_exit_armory = undefined;
            level.music_state_fate_round = true;
            level notify("change_music_state");
            maps\_zombietron_fate::choose_fate_round();
          }
        }
        update_next_arena();
      } else {
        if(!isDefined(level.desiredRound)) {
          if(level.epic_boss_battle == false && maps\_zombietron_utility::is_arena_boss_available()) {
            level thread play_movie(level.victory_movie, false, true, "victory_movie_go", false, "victory_movie_done", 1.5);
            level notify("change_music_state");
            level.epic_boss_battle = true;
            level.round_number--;
            maps\_zombietron_spawner::spawn_the_big_boss();
            continue;
          } else {
            spawn_teleporter(level.epic_boss_battle);
            level.epic_boss_battle = false;
            flag_clear("boss_is_spawned");
            update_next_arena();
            maps\_zombietron_pickups::clear_all_pickups();
          }
        } else {
          update_next_arena();
          maps\_zombietron_pickups::clear_all_pickups();
        }
      }
      maps\_zombietron_pickups::clear_all_pickups();
      CleanupSpawnedDynEnts();
      maps\_zombietron_pickups::spawn_mines();
      move_players_to_start();
      if(isDefined(level.desiredRound) && level.round_number >= level.desiredRound) {
        level.desiredRound = undefined;
      }
      level notify("change_music_state");
      fade_in();
    }
  }
}

end_game() {
  level waittill("end_the_game");
  wait 2;
  level.survived_msg FadeOverTime(1);
  level.msg_t3 FadeOverTime(1);
  level.survived_msg.alpha = 0;
  level.msg_t3.alpha = 0;
  wait 1;
  fade_out();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] hide();
    players[i].headshots = 0;
  }
  kill_all_the_mfn_zombies();
  maps\_zombietron_pickups::clear_all_pickups();
  CleanupSpawnedDynEnts();
  flag_set("all_players_dead");
  update_leaderboards();
  wait 0.05;
  ClearAllCorpses();
  level thread maps\_zombietron_scenes::end_of_game_summary();
  setmusicstate("end_of_game");
  level waittill("summary_complete");
  for(i = 0; i < players.size; i++) {
    players[i] show();
  }
  fade_in();
  if(!isDefined(level.game_over_msg)) {
    level.game_over_msg = NewHudElem(self);
    level.game_over_msg.alignX = "center";
    level.game_over_msg.alignY = "middle";
    level.game_over_msg.horzAlign = "center";
    level.game_over_msg.vertAlign = "middle";
    level.game_over_msg.y -= 130;
    level.game_over_msg.foreground = true;
    level.game_over_msg.fontScale = 4;
    level.game_over_msg.color = (1.0, 0.0, 0.0);
    level.game_over_msg.hidewheninmenu = false;
  }
  if(!isDefined(level.game_over_msg2)) {
    level.game_over_msg2 = NewHudElem(self);
    level.game_over_msg2.alignX = "center";
    level.game_over_msg2.alignY = "middle";
    level.game_over_msg2.horzAlign = "center";
    level.game_over_msg2.vertAlign = "middle";
    level.game_over_msg2.y -= 100;
    level.game_over_msg2.foreground = true;
    level.game_over_msg2.fontScale = 2;
    level.game_over_msg2.color = (1.0, 0.0, 0.0);
    level.game_over_msg2.hidewheninmenu = false;
  }
  level.game_over_msg.alpha = 0;
  level.game_over_msg SetText(&"ZOMBIETRON_GAMEOVER");
  level.game_over_msg FadeOverTime(1);
  level.game_over_msg.alpha = 1;
  level.game_over_msg2.alpha = 0;
  level.game_over_msg2 SetText(&"ZOMBIETRON_SURVIVED_ROUNDS", level.round_number);
  level.game_over_msg2 FadeOverTime(1);
  level.game_over_msg2.alpha = 1;
  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvars("ammoCounterHide", "1", "miniscoreboardhide", "1");
  }
  players[0] setclientflag(level._ZT_PLAYER_CF_SHOW_SCORES);
  wait(4.5);
  fade_out();
  for(i = 0; i < players.size; i++) {
    players[i] SetOrigin(players[i].origin + (0, 0, 500));
  }
  if(level.onlineGame || level.systemLink) {
    ExitLevel(false);
  } else {
    MissionFailed();
  }
  wait(666);
}

update_leaderboards() {
  if(GetPlayers().size <= 1) {
    return;
  }
  if(level.systemLink) {
    return;
  }
  if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    return;
  }
  zombietron_upload_highscore();
  zombietron_set_new_zombie_stats();
}

get_player_spawn_point() {
  if(level.arena_round_number != 1) {
    camera_center = get_camera_center_point();
    y = 390;
    x = 270;
    if(level.previous_exit_taken == "top") {
      x = 0;
    } else if(level.previous_exit_taken == "bottom") {
      x = 0;
      y = 0 - y;
    } else if(level.previous_exit_taken == "right") {
      y = 0;
    } else if(level.previous_exit_taken == "left") {
      y = 0;
      x = 0 - x;
    }
    return camera_center + (x, y, 0);
  }
  spawnPointTarget = level.arenas[level.current_arena] + "_spawnpoint";
  return GetStruct(spawnPointTarget, "targetname").origin;
}

get_camera_center_point() {
  cameraTarget = level.arenas[level.current_arena] + "_center";
  return GetStruct(cameraTarget, "targetname").origin;
}

move_players_to_start() {
  spawn_origin = get_player_spawn_point();
  spawn_origin = PlayerPhysicsTrace(spawn_origin + (0, 0, 1000), spawn_origin - (0, 0, 1000));
  camera_center = get_camera_center_point();
  angles = VectorToAngles(camera_center - spawn_origin);
  camera_angles = GetDvarVector("player_TopDownCamAngles");
  if(level.flipped) {
    camera_angles = (camera_angles[0], 180, camera_angles[2]);
  } else {
    camera_angles = (camera_angles[0], 0, camera_angles[2]);
  }
  players = get_players();
  shift = (0, 50, 0);
  if(level.previous_exit_taken == "top" || level.previous_exit_taken == "bottom") {
    shift = (50, 0, 0);
  }
  spawn_origin -= shift * 0.5 * (players.size - 1);
  for(i = 0; i < players.size; i++) {
    above = spawn_origin + (0, 0, 100);
    below = spawn_origin + (0, 0, -100);
    hitp = PlayerPhysicsTrace(above, below);
    if(isDefined(players[i].tank)) {
      hitp += (0, 0, 10);
      players[i].tank.origin = hitp;
    } else if(isDefined(players[i].heli)) {
      players[i].heli.origin = hitp + (0, 0, level.heli_height);
    } else {
      players[i] SetOrigin(hitp);
    }
    players[i] breadcrumb_point_clear();
    players[i] SetPlayerAngles(angles);
    players[i] setClientDvars("player_topDownCamMode", 3, "player_topDownCamCenterPos", camera_center, "player_TopDownCamAngles", camera_angles, "player_topDownCamOffset", (0, -15, 650));
    spawn_origin += shift;
    players[i] notify("move_to_start");
    players[i] StartCameraTween(0.2);
  }
  setup_random_environment();
  maps\_zombietron_spawner::update_drop_locations();
  level notify("move_to_start");
}

player_respawn_if_extra_life() {
  self endon("disconnect");
  self endon("player_respawned");
  level endon("end_the_game");
  while(!level.gameEnded) {
    if(self.lives > 0 || isDefined(self.stolen_life)) {
      player_respawn();
      return;
    }
    wait .2;
  }
}

life_link(source, dest) {
  self endon("disconnect");
  level endon("end_the_game");
  orb = spawn("script_model", self.origin + (0, 0, 50));
  orb setModel("tag_origin");
  playFXOnTag(level._effect["life_force"], orb, "tag_origin");
  orb thread destroy_me_on_player_notify(source, "disconnect");
  orb thread destroy_me_on_player_notify(dest, "disconnect");
  orb thread destroy_me_on_player_notify(source, "end_life_link");
  while(isDefined(orb)) {
    orb moveTo(dest.origin, 0.2, 0, 0);
    wait 0.2;
    if(isDefined(orb)) {
      orb.origin = source.origin;
    }
  }
}

steal_life_cooldown(time) {
  self endon("disconnect");
  level endon("end_the_game");
  self.stealing = 1;
  wait time;
  self.stealing = undefined;
}

steal_life_from(source, dest) {
  self endon("disconnect");
  level endon("end_the_game");
  if(!isDefined(source) || source.lives < 1)
    return;
  if(isDefined(source.stealing))
    return;
  if(isDefined(dest.stealing))
    return;
  source thread steal_life_cooldown(10);
  dest thread steal_life_cooldown(level.zombie_vars["auto_respawn_timeout"] + 5);
  source thread life_link(source, dest);
  wait 1;
  source.lives--;
  if(source.lives < 0) {
    source.lives = 0;
  }
  origin = source.origin;
  pickup = spawn("script_model", origin);
  pickup.angles = source.angles;
  pickup setModel(level.extra_life_model);
  playFXOnTag(level._effect[source.light_playFX], pickup, "tag_origin");
  source thread maps\_zombietron_pickups::turn_shield_on(true);
  pickup moveTo(dest.origin, 1, 0, 0);
  pickup playLoopSound("zmb_pickup_life_shimmer");
  pickup waittill("movedone");
  pickup Delete();
  dest.stolen_life = true;
  source maps\_zombietron_score::update_hud();
  reward = undefined;
  model = undefined;
  number = 1;
  while(!isDefined(reward) || maps\_zombietron_pickups::can_spawn_pickup(reward) == false) {
    i = randomInt(level.reward_pickups.size);
    reward = level.reward_pickups[i];
    switch (reward) {
      case "booster":
        model = level.booster_model;
        number = 4;
        break;
      case "bomb":
        model = level.bomb_model;
        number = 3;
        break;
      case "heli":
        model = level.heli_pickup_model;
        number = 1;
        break;
      case "tank":
        model = level.tank_pickup_model;
        number = 1;
        break;
    }
    wait 0.05;
  }
  while(number > 0) {
    level thread maps\_zombietron_pickups::directed_pickup_award_to(source, reward, model);
    number--;
    wait 0.3;
  }
  source notify("end_life_link");
}

player_automatic_respawn() {
  self endon("disconnect");
  level endon("end_the_game");
  original_time = level.zombie_vars["auto_respawn_timeout"];
  time_left = original_time;
  while(!isAlive(self) && time_left > 0) {
    wait 0.05;
    time_left -= 0.05;
    self.headshots = Int((time_left / original_time) * 1000);
  }
  if(!isAlive(self)) {
    self player_respawn_now();
  }
  self.headshots = 0;
}

player_steal_life() {
  self endon("disconnect");
  level endon("end_the_game");
  self thread player_respawn_if_extra_life();
  self thread player_automatic_respawn();
  while(self.lives == 0 && !isDefined(self.stolen_life) && !level.gameEnded) {
    wait 1;
    if(isDefined(self.next_life_steal) && GetTime() < self.next_life_steal) {
      continue;
    }
    players = GetPlayers();
    richestPlayer = undefined;
    biggestLives = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] == self) {
        continue;
      }
      if(players[i].lives > biggestLives) {
        biggestLives = players[i].lives;
        richestPlayer = players[i];
      }
    }
    if(isDefined(richestPlayer)) {
      level thread steal_life_from(richestPlayer, self);
      return;
    }
  }
}

player_respawn_now() {
  self maps\_zombietron_score::update_hud();
  self playSound("zmb_player_respawn");
  playFX(level._effect["respawn"], self.origin, anglesToForward(self.angles));
  RadiusDamage(self.origin, 200, 10000, 10000, self);
  self spawn(self.origin, (0, 0, 0));
  self thread maps\_zombietron_pickups::turn_shield_on();
  self SetPlayerCollision(1);
  self TakeAllWeapons();
  self GiveWeapon(self.default_weap);
  self switchToWeapon(self.default_weap);
  self.headshots = 0;
  self DisableWeaponCycling();
  self AllowJump(false);
  self AllowCrouch(false);
  self AllowSprint(false);
  self SetStance("stand");
  self notify("player_respawned");
}

player_respawn() {
  wait 2;
  if(self.lives < 1 && !isDefined(self.stolen_life))
    return;
  if(level.gameEnded)
    return;
  if(!isDefined(self.stolen_life)) {
    self.lives--;
    if(self.lives < 0) {
      self.lives = 0;
    }
  } else {
    self.stolen_life = undefined;
  }
  self player_respawn_now();
}

exit_cleanup() {
  level waittill("exit_taken");
  wait .05;
  self notify("trigger");
}

make_exit_magical(trigger) {
  level endon("exit_taken");
  trigger waittill("trigger");
  level.lastmagical_exit_taken = level.round_number;
  level.magical_exit_taken = true;
  chance = level.zombie_vars["armory_chance"];
  if(level.round_number >= 20 && !isDefined(level.lastmagical_armory)) {
    chance = 100;
  }
  if(level.round_number > 4 && randomInt(100) < chance) {
    level.magical_exit_armory = 1;
    level.lastmagical_armory = level.round_number;
  }
}

is_exit_open(label) {
  exit_triggers = get_environment_exits();
  for(i = 0; i < exit_triggers.size; i++) {
    if(!isDefined(label) && isDefined(exit_triggers[i].exit_open)) {
      return true;
    } else
    if(exit_triggers[i].script_parameters == label && isDefined(exit_triggers[i].exit_open)) {
      return true;
    }
  }
  return false;
}

open_exit(trigger, objective_id) {
  blocker = getEnt(trigger.target, "targetname");
  blocker.origin -= (0, 0, 500);
  trigger.exit_open = true;
  trigger thread exit_cleanup();
  objective_add(objective_id, "active", &"EXIT", trigger.origin);
  objective_set3d(objective_id, true, "default", "*");
  objective_current(objective_id);
  trigger waittill("trigger");
  trigger.exit_open = undefined;
  blocker.origin += (0, 0, 500);
  objective_delete(objective_id);
  wait 0.1;
  level notify("exit_taken", trigger);
}

open_exits(specific) {
  level.teleporter_spawned = true;
  exit_triggers = get_environment_exits();
  if(exit_triggers.size != 4) {
    fade_out();
    level.teleporter_spawned = false;
    return;
  }
  level.survived_msg.hidewheninmenu = true;
  level.survived_msg.alpha = 0;
  if(level.magical_exit_taken) {
    if(isDefined(level.magical_exit_armory)) {
      level.survived_msg SetText(&"ZOMBIETRON_ARMORY");
    } else {
      level.survived_msg SetText(&"ZOMBIETRON_BONUS");
    }
  } else {
    if(level.round_number - 1 > 0) {
      level.survived_msg SetText(&"ZOMBIETRON_ROUND_COMPLETE", level.round_number - 1);
    }
  }
  level.survived_msg FadeOverTime(1);
  level.survived_msg.alpha = 1;
  if(isDefined(specific)) {
    num_exits = 1;
    the_specific_exit = [];
    for(i = 0; i < exit_triggers.size; i++) {
      if(exit_triggers[i].script_parameters == specific) {
        the_specific_exit[the_specific_exit.size] = exit_triggers[i];
      }
    }
    exit_triggers = the_specific_exit;
  } else {
    exit_triggers = randomize_array(exit_triggers);
    num_exits = 1 + randomInt(3);
  }
  if(level.arena_round_number == level.zombie_vars["zombie_arena_rounds"]) {
    num_exits = 1;
  }
  level.msg_t3.alpha = 0;
  magic_exit = undefined;
  if(level.round_number - level.lastmagical_exit_taken > 2) {
    if(num_exits > 1) {
      magic_exit = randomInt(num_exits);
    }
  }
  opened_exits = 0;
  for(i = 0; i < num_exits; i++) {
    if(exit_triggers[i].script_parameters == level.previous_exit_taken) {
      if(isDefined(magic_exit) && magic_exit == i) {
        magic_exit++;
      }
      i++;
    }
    if(isDefined(magic_exit) && i == magic_exit) {
      level thread make_exit_magical(exit_triggers[i]);
      magic_exit = undefined;
    }
    level thread open_exit(exit_triggers[i], i);
    opened_exits++;
    PlaySoundAtPosition("zmb_exit_open", exit_triggers[i].origin);
    wait .2;
  }
  if(opened_exits > 1) {
    level.msg_t3 SetText(&"ZOMBIETRON_PICK_A_PATH");
    level.msg_t3 FadeOverTime(1);
    level.msg_t3.alpha = 1;
  }
  flag_set("exits_open");
  level waittill("exit_taken", exit_trigger);
  flag_clear("exits_open");
  fade_out();
  level.survived_msg FadeOverTime(1);
  level.msg_t3 FadeOverTime(1);
  level.survived_msg.alpha = 0;
  level.msg_t3.alpha = 0;
  level notify("exit_taken_fadeout");
  PlaySoundAtPosition("zmb_exit_taken", exit_trigger.origin);
  wait 1.7;
  level.previous_exit_taken = exit_trigger.script_parameters;
  level.teleporter_spawned = false;
}

Rotate() {
  self endon("death");
  while(1) {
    self rotateTo(self.angles + (0, 180, 0), 4);
    wait 4;
  }
}

spawn_teleporter(boss_battle) {
  level.teleporter_spawned = true;
  location = maps\_zombietron_pickups::get_random_pickup_location();
  if(!isDefined(location)) {
    return;
  }
  level.survived_msg SetText(&"ZOMBIETRON_ROUND_COMPLETE", level.round_number - 1);
  level.msg_t3 SetText(&"ZOMBIETRON_TELEPORTER");
  level.survived_msg FadeOverTime(1);
  level.msg_t3 FadeOverTime(1);
  level.survived_msg.alpha = 1;
  level.msg_t3.alpha = 1;
  above = location.origin + (0, 0, 10);
  below = location.origin + (0, 0, -500);
  hitp = PlayerPhysicsTrace(above, below);
  dest_point = (location.origin[0], location.origin[1], hitp[2]);
  start_point = dest_point + (0, 0, -50);
  teleporter = spawn("script_model", start_point);
  teleporter setModel("zombie_teleporter_pad");
  lights = [];
  if(isDefined(level.is_nighttime)) {
    next = lights.size;
    lights[next] = spawn("script_model", start_point);
    lights[next] setModel("tag_origin");
    lights[next] thread fake_linkto(teleporter, (0, 0, 50));
    playFXOnTag(level._effect["white_light"], lights[next], "tag_origin");
    next = lights.size;
    lights[next] = spawn("script_model", start_point);
    lights[next] setModel("tag_origin");
    lights[next] thread fake_linkto(teleporter, (0, 72, 50));
    playFXOnTag(level._effect["coconut"], lights[next], "tag_origin");
    next = lights.size;
    lights[next] = spawn("script_model", start_point);
    lights[next] setModel("tag_origin");
    lights[next] thread fake_linkto(teleporter, (72, 0, 50));
    playFXOnTag(level._effect["coconut"], lights[next], "tag_origin");
    next = lights.size;
    lights[next] = spawn("script_model", start_point);
    lights[next] setModel("tag_origin");
    lights[next] thread fake_linkto(teleporter, (0, -72, 50));
    playFXOnTag(level._effect["coconut"], lights[next], "tag_origin");
    next = lights.size;
    lights[next] = spawn("script_model", start_point);
    lights[next] setModel("tag_origin");
    lights[next] thread fake_linkto(teleporter, (-72, 0, 50));
    playFXOnTag(level._effect["coconut"], lights[next], "tag_origin");
  }
  teleporter moveTo(dest_point + (0, 0, 5), 3, 0, 0);
  teleporter thread Rotate();
  physicsExplosionSphere(start_point, 200, 128, 4);
  teleporter waittill("movedone");
  physicsExplosionSphere(start_point, 200, 128, 3);
  playsoundatposition("zmb_teleporter_spawn", teleporter.origin);
  trigger = spawn("trigger_radius", location.origin + (0, 0, -100), 0, 20, 200);
  trigger playLoopSound("zmb_teleporter_loop", .5);
  trigger waittill("trigger", player);
  PlayRumbleOnPosition("artillery_rumble", location.origin);
  trigger stopLoopSound(.5);
  PlaySoundAtPosition("zmb_teleporter_tele_out", (0, 0, 0));
  level.survived_msg FadeOverTime(1);
  level.msg_t3 FadeOverTime(1);
  level.survived_msg.alpha = 0;
  level.msg_t3.alpha = 0;
  if(boss_battle) {
    wait 1;
    level maps\_zombietron_spawner::the_big_boss_defeated("ape_zombie");
    level notify("victory_movie_go");
    level waittill("victory_movie_done");
  }
  fade_out();
  trigger Delete();
  teleporter Delete();
  if(isDefined(lights)) {
    for(i = 0; i < lights.size; i++) {
      lights[i] Delete();
    }
  }
  level.teleporter_spawned = false;
}

setup_random_environment() {
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(level.xenon && level.arenas[level.current_arena] == "island") {
      players[i] SetClientDvars("phys_buoyancy", 1, "phys_ragdoll_buoyancy", 1);
    } else {
      players[i] SetClientDvars("phys_buoyancy", 0, "phys_ragdoll_buoyancy", 0);
    }
  }
  if(isDefined(level.weatherFx)) {
    for(i = 0; i < level.weatherFx.size; i++) {
      level.weatherFx[i] Delete();
    }
  }
  level.weatherFx = [];
  weather_chance = randomInt(3);
  if(level.arena_round_number == 3) {
    fog = getEntArray("fog_fx", "targetname");
    for(i = 0; i < fog.size; i++) {
      level.weatherFx[level.weatherFx.size] = SpawnFx(level._effect["fog_amb"], fog[i].origin);
      TriggerFx(level.weatherFx[level.weatherFx.size - 1]);
    }
  } else if(level.arena_round_number == 4) {
    rainfall_fx = getEntArray("rain_fx", "targetname");
    for(i = 0; i < rainfall_fx.size; i++) {
      level.weatherFx[level.weatherFx.size] = SpawnFx(level._effect["rainfall"], rainfall_fx[i].origin);
      TriggerFx(level.weatherFx[level.weatherFx.size - 1]);
    }
    snow = getEntArray("snow_fx", "targetname");
    for(i = 0; i < snow.size; i++) {
      level.weatherFx[level.weatherFx.size] = SpawnFx(level._effect["snowfall"], snow[i].origin);
      TriggerFx(level.weatherFx[level.weatherFx.size - 1]);
    }
  }
  maps\createart\zombietron_art::setup_random_sun();
  setup_script_models();
  CleanupSpawnedDynEnts();
}

hide_model() {
  if(!isDefined(self.hidden)) {
    if(self.spawnflags & 1) {
      self ConnectPaths();
    }
    self.hidden = true;
    self.origin += (0, 0, 2000);
  }
}

show_model() {
  if(isDefined(self.hidden)) {
    if(self.spawnflags & 1) {
      self.hidden = undefined;
    }
    self.origin -= (0, 0, 2000);
    self DisconnectPaths();
  }
}

setup_script_models() {
  for(i = 0; i < level.zombie_vars["zombie_arena_rounds"]; i++) {
    models = getEntArray("round" + i, "targetname");
    if(level.arena_round_number == i) {
      for(j = 0; j < models.size; j++) {
        models[j] show_model();
      }
    } else {
      for(j = 0; j < models.size; j++) {
        models[j] hide_model();
      }
    }
  }
}

setup_ambient_fx() {
  vespa_smoke = getEnt("vespa_1", "targetname");
  assertex(isDefined(vespa_smoke), "vespa_smoke is missing");
  playFX(level._effect["vespa_smoke_fx"], vespa_smoke.origin);
  capacitors = getEntArray("capacitor", "targetname");
  assertex((capacitors.size > 0), "capacitors are missing!");
  for(i = 0; i < capacitors.size; i++) {
    playFX(level._effect["capacitor_light"], capacitors[i].origin);
  }
}

remove_ignore_attacker() {
  self notify("new_ignore_attacker");
  self endon("new_ignore_attacker");
  self endon("disconnect");
  if(!isDefined(level.ignore_enemy_timer)) {
    level.ignore_enemy_timer = 0.4;
  }
  wait(level.ignore_enemy_timer);
  self.ignoreAttacker = undefined;
}

init_function_overrides() {
  level.custom_introscreen = ::zombie_intro_screen;
  level.reset_clientdvars = ::onPlayerConnect_clientDvars;
  level.overridePlayerKilled = ::player_killed_override;
  level.overridePlayerDamage = ::player_damage_override;
  level.overrideActorDamage = ::actor_damage_override;
  level.melee_miss_func = ::zombiemode_melee_miss;
  level.callbackPlayerKilled = ::Callback_PlayerKilledZT;
}

initZombieLeaderboardData() {
  level.zombieLeaderboardStatVariable["zombietron"]["highestwave"] = "zombietron_highestwave";
  level.zombieLeaderboardStatVariable["zombietron"]["timeinwave"] = "zombietron_timeinwave";
  level.zombieLeaderboardStatVariable["zombietron"]["totalpoints"] = "zombietron_totalpoints";
  level.zombieLeaderboardNumber["zombietron"]["waves"] = 3;
  level.zombieLeaderboardNumber["zombietron"]["points"] = 4;
}

zombie_intro_screen(string1, string2, string3, string4, string5) {
  flag_wait("all_players_connected");
  wait(1);
  setmusicstate("SPLASH_SCREEN");
  wait(0.2);
}

onPlayerConnect_clientDvars() {
  self SetClientDvars("cg_deadChatWithDead", "1",
    "cg_deadChatWithTeam", "1",
    "cg_deadHearTeamLiving", "1",
    "cg_deadHearAllLiving", "1",
    "cg_everyoneHearsEveryone", "1",
    "compass", "0",
    "hud_showStance", "0",
    "ammoCounterHide", "1",
    "miniscoreboardhide", "1",
    "ui_hud_hardcore", "0",
    "player_topDownCamMode", "3",
    "ai_corpseCount", "14",
    "waypointOffscreenPointerHeight", "30",
    "waypointOffscreenPointerWidth", "70",
    "cg_drawSpectatorMessages", "0",
    "sm_sunSampleSizeNear", ".57",
    "playerPushAmount", "1");
  self SetDepthOfField(0, 0, 512, 4000, 4, 0);
  self setClientDvars("aim_lockon_pitch_strength", 0.0, "player_topDownCamOffset", (0, -15, 650), "player_TopDownCamAngles", (75, 0, 0), "cg_fov", 65);
}

player_killed_override() {
  level waittill("forever");
}

player_damage_override(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  if(isDefined(self.shield_is_on)) {
    self ClearDamageIndicator();
    return 0;
  }
  if(isDefined(eAttacker)) {
    if(isDefined(self.ignoreAttacker) && self.ignoreAttacker == eAttacker) {
      return 0;
    }
    if((isDefined(eAttacker.is_zombie) && eAttacker.is_zombie)) {
      self.ignoreAttacker = eAttacker;
      self thread remove_ignore_attacker();
      if(!isDefined(eAttacker.meleeDamage)) {
        iDamage = 45;
      } else if(isDefined(eAttacker.custom_damage_func)) {
        iDamage = eAttacker[[eAttacker.custom_damage_func]]();
      } else {
        iDamage = eAttacker.meleeDamage;
      }
    }
    eAttacker notify("hit_player");
  }
  finalDamage = iDamage;
  if(sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH" || sMeansOfDeath == "MOD_GRENADE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" || sMeansOfDeath == "MOD_BURNED") {
    if(!(sMeansOfDeath == "MOD_PROJECTILE_SPLASH" && isDefined(eAttacker.is_zombie))) {
      self ClearDamageIndicator();
      return 0;
    }
  }
  if(iDamage < self.health) {
    if(isDefined(eAttacker)) {
      eAttacker.sound_damage_player = self;
    }
    return finalDamage;
  }
  return finalDamage;
}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, sHitLoc, modelIndex, psOffsetTime) {
  if(!isDefined(self) || !isDefined(attacker))
    return damage;
  if(!isplayer(attacker) && !isplayer(self))
    return damage;
  if(!isDefined(damage) || !isDefined(meansofdeath))
    return damage;
  if(meansofdeath == "")
    return damage;
  final_damage = damage;
  if(isDefined(self.actor_damage_func)) {
    final_damage = [[self.actor_damage_func]](weapon, final_damage);
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner))
    attacker = attacker.owner;
  return int(final_damage);
}

zombiemode_melee_miss() {
  if(isDefined(self.enemy.curr_pay_turret)) {
    self.enemy doDamage(GetDvarInt(#"ai_meleeDamage"), self.origin, self, undefined, "melee", "none");
  }
}

Callback_PlayerKilledZT(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  self playSound("zmb_player_death");
  self notify("player_died");
  self.headshots = 0;
  self SetPlayerCollision(0);
  self maps\_zombietron_score::update_multiplier_bar(0);
  if(isDefined(level.round_end_time) && level.round_start_time < level.round_end_time) {
    self.zombification_time = level.round_end_time - level.round_start_time;
  } else {
    self.zombification_time = GetTime() - level.round_start_time;
  }
  if(self.lives == 0) {
    players = get_players();
    count = 0;
    for(i = 0; i < players.size; i++) {
      if(!isAlive(players[i]) && players[i].lives == 0 && !isDefined(players[i].stolen_life)) {
        count++;
      }
    }
    if(count == players.size) {
      level notify("end_the_game");
    } else {
      self thread player_steal_life();
    }
  } else {
    self thread player_respawn();
  }
}

get_environment_exits() {
  return level.arena_exits[level.current_arena];
}

setup_exits() {
  level.arena_exits = [];
  for(i = 0; i < level.arenas.size; i++) {
    arena = level.arenas[i];
    level.arena_exits[i] = getEntArray(arena + "_exit", "script_noteworthy");
  }
}

detect_and_change_music_states() {
  wait_for_all_players();
  setmusicstate(level.arenas[level.current_arena]);
  last_arena = level.current_arena;
  while(1) {
    level waittill("change_music_state");
    if(level.magical_exit_taken && last_arena != 96) {
      setmusicstate("bonus");
      last_arena = 96;
      continue;
    } else if(level.music_state_fate_round) {
      setmusicstate("fate");
      level.music_state_fate_round = false;
      last_arena = 97;
      continue;
    } else if(maps\_zombietron_challenges::is_this_a_challenge_round(level.round_number)) {
      if(level.round_number == 40) {
        setmusicstate("boss");
        last_arena = 98;
      } else {
        setmusicstate("challenge");
        last_arena = 99;
      }
      continue;
    } else if(level.current_arena != last_arena) {
      last_arena = level.current_arena;
      setmusicstate(level.arenas[level.current_arena]);
      last_music_state = level.arenas[level.current_arena];
      continue;
    }
  }
}

zombietron_upload_highscore() {
  playersRank = 1;
  if(level.players_playing == 1)
    playersRank = 4;
  else if(level.players_playing == 2)
    playersRank = 3;
  else if(level.players_playing == 3)
    playersRank = 2;
  map_name = getDvar(#"mapname");
  if(!isZombieLeaderboardAvailable(map_name, "waves") || !isZombieLeaderboardAvailable(map_name, "points"))
    return;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    pre_highest_wave = players[i] playerZombieStatGet(map_name, "highestwave");
    pre_time_in_wave = players[i] playerZombieStatGet(map_name, "timeinwave");
    new_highest_wave = level.round_number + "" + playersRank;
    new_highest_wave = int(new_highest_wave);
    if(new_highest_wave >= pre_highest_wave) {
      if(players[i].zombification_time == 0) {
        players[i].zombification_time = GetTime() - level.round_start_time;
      }
      player_survival_time = players[i].zombification_time;
      player_survival_time = int(player_survival_time / 1000);
      if(new_highest_wave > pre_highest_wave || player_survival_time > pre_time_in_wave) {
        rankNumber = makeRankNumber(level.round_number, playersRank, player_survival_time);
        leaderboard_number = getZombieLeaderboardNumber(map_name, "waves");
        players[i] UploadScore(leaderboard_number, int(rankNumber), level.round_number, player_survival_time, level.players_playing);
        players[i] playerZombieStatSet(map_name, "highestwave", new_highest_wave);
        players[i] playerZombieStatSet(map_name, "timeinwave", player_survival_time);
      }
    }
    pre_total_points = players[i] playerZombieStatGet(map_name, "totalpoints");
    if(players[i].score > pre_total_points) {
      leaderboard_number = getZombieLeaderboardNumber(map_name, "points");
      players[i] UploadScore(leaderboard_number, players[i].score, players[i].kills, level.players_playing);
      players[i] playerZombieStatSet(map_name, "totalpoints", players[i].score);
    }
  }
}

isZombieLeaderboardAvailable(map, type) {
  if(!isDefined(level.zombieLeaderboardNumber[map]))
    return 0;
  if(!isDefined(level.zombieLeaderboardNumber[map][type]))
    return 0;
  return 1;
}

getZombieLeaderboardNumber(map, type) {
  if(!isDefined(level.zombieLeaderboardNumber[map][type]))
    assertMsg("Unknown leaderboard number for map " + map + "and type " + type);
  return level.zombieLeaderboardNumber[map][type];
}

getZombieStatVariable(map, variable) {
  if(!isDefined(level.zombieLeaderboardStatVariable[map][variable]))
    assertMsg("Unknown stat variable " + variable + " for map " + map);
  return level.zombieLeaderboardStatVariable[map][variable];
}

playerZombieStatGet(map, variable) {
  stat_variable = getZombieStatVariable(map, variable);
  result = self zombieStatGet(stat_variable);
  if(!isDefined(result)) {
    result = 0;
  }
  return result;
}

playerZombieStatSet(map, variable, value) {
  if(!isDefined(value)) {
    value = 0;
  }
  stat_variable = getZombieStatVariable(map, variable);
  self zombieStatSet(stat_variable, value);
}

zombietron_set_new_zombie_stats() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    total_kills = players[i] zombieStatGet("zombie_kills") + players[i].stats["kills"];
    total_points = players[i] zombieStatGet("zombie_points") + players[i].stats["score"];
    total_rounds = players[i] zombieStatGet("zombie_rounds") + (level.round_number - 1);
    players[i] zombieStatSet("zombie_kills", total_kills);
    players[i] zombieStatSet("zombie_points", total_points);
    players[i] zombieStatSet("zombie_rounds", total_rounds);
  }
}

makeRankNumber(wave, players, time) {
  if(time > 86400)
    time = 86400;
  padding = "";
  if(10 > time)
    padding += "0000";
  else if(100 > time)
    padding += "000";
  else if(1000 > time)
    padding += "00";
  else if(10000 > time)
    padding += "0";
  rank = wave + "" + players + padding + time;
  return rank;
}

zombieStatGet(dataName) {
  if(level.systemLink) {
    return 0;
  }
  if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    return 0;
  }
  return (self getdstat("PlayerStatsList", dataName));
}

zombieStatSet(dataName, value) {
  if(level.systemLink) {
    return;
  }
  if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    return;
  }
  if(!isDefined(value)) {
    value = 0;
  }
  self setdstat("PlayerStatsList", dataName, value);
}