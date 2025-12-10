/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode.gsc
**************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#include maps\_music;
#include maps\_zombiemode_utility;
#include maps\_busing;
#using_animtree("generic_human");
main() {
  level.player_too_many_weapons_monitor = true;
  level.player_too_many_weapons_monitor_func = ::player_too_many_weapons_monitor;
  level._dontInitNotifyMessage = 1;
  init_additionalprimaryweapon_machine_locations();
  level thread maps\_zombiemode_ffotd::main_start();
  level.zombiemode = true;
  level.reviveFeature = false;
  level.contextualMeleeFeature = false;
  level.swimmingFeature = false;
  level.calc_closest_player_using_paths = true;
  level.zombie_melee_in_water = true;
  level.put_timed_out_zombies_back_in_queue = true;
  level.use_alternate_poi_positioning = true;
  level.zombies_timeout_spawn = 0;
  level.zombies_timeout_playspace = 0;
  level.zombies_timeout_undamaged = 0;
  level.zombie_player_killed_count = 0;
  level.zombie_trap_killed_count = 0;
  level.zombie_pathing_failed = 0;
  level.zombie_breadcrumb_failed = 0;
  level.zombie_visionset = "zombie_neutral";
  if(getDvar("anim_intro") == "1") {
    level.zombie_anim_intro = 1;
  } else {
    level.zombie_anim_intro = 0;
  }
  precache_shaders();
  precache_models();
  PrecacheItem("frag_grenade_zm");
  PrecacheItem("claymore_zm");
  level.skill_override = 1;
  maps\_gameskill::setSkill(undefined, level.skill_override);
  level.disable_player_damage_knockback = true;
  level._ZOMBIE_GIB_PIECE_INDEX_ALL = 0;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM = 1;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM = 2;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG = 3;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG = 4;
  level._ZOMBIE_GIB_PIECE_INDEX_HEAD = 5;
  level._ZOMBIE_GIB_PIECE_INDEX_GUTS = 6;
  init_dvars();
  init_mutators();
  init_strings();
  init_levelvars();
  init_animscripts();
  init_sounds();
  init_shellshocks();
  init_flags();
  init_client_flags();
  register_offhand_weapons_for_level_defaults();
  if(!isDefined(level.zombie_ai_limit)) {
    level.zombie_ai_limit = 24;
    SetAILimit(level.zombie_ai_limit);
  }
  init_fx();
  maps\_zombiemode_load::main();
  maps\_zombiemode_zone_manager::init();
  maps\_zombiemode_audio::audio_init();
  maps\_zombiemode_claymore::init();
  maps\_zombiemode_weapons::init();
  maps\_zombiemode_equipment::init();
  maps\_zombiemode_blockers::init();
  maps\_zombiemode_spawner::init();
  maps\_zombiemode_powerups::init();
  maps\_zombiemode_perks::init();
  maps\_zombiemode_user::init();
  maps\_zombiemode_weap_cymbal_monkey::init();
  maps\_zombiemode_weap_freezegun::init();
  maps\_zombiemode_weap_tesla::init();
  maps\_zombiemode_weap_thundergun::init();
  maps\_zombiemode_weap_crossbow::init();
  maps\_zombiemode_bowie::bowie_init();
  maps\_zombiemode_traps::init();
  maps\_zombiemode_weapon_box::init();
  init_function_overrides();
  level thread last_stand_pistol_rank_init();
  level thread[[level.Player_Spawn_func]]();
  level thread onPlayerConnect();
  level thread post_all_players_connected();
  init_utility();
  maps\_utility::registerClientSys("zombify");
  init_anims();
  if(isDefined(level.custom_ai_type)) {
    for(i = 0; i < level.custom_ai_type.size; i++) {
      [
        [level.custom_ai_type[i]]
      ]();
    }
  }
  if(level.mutators["mutator_friendlyFire"]) {
    SetDvar("friendlyfire_enabled", "1");
  }
  initZombieLeaderboardData();
  initializeStatTracking();
  if(GetPlayers().size <= 1) {
    incrementCounter("global_solo_games", 1);
  } else if(level.systemLink) {
    incrementCounter("global_systemlink_games", 1);
  } else if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    incrementCounter("global_splitscreen_games", 1);
  } else {
    incrementCounter("global_coop_games", 1);
  }
  if(IsSplitScreen()) {
    set_splitscreen_fog(350, 2986.33, 10000, -480, 0.805, 0.715, 0.61, 0.0, 10000);
  }
  level thread maps\_zombiemode_ffotd::main_end();
}

post_all_players_connected() {
  flag_wait("all_players_connected");
  println("sessions: mapname=", level.script, " gametype zom isserver 1 player_count=", get_players().size);
  maps\_zombiemode_score::init();
  level difficulty_init();
  level thread clear_mature_blood();
  level thread end_game();
  if(!level.zombie_anim_intro) {
    level thread round_start();
  }
  level thread players_playing();
  if(isDefined(level.crawlers_enabled) && level.crawlers_enabled == 1) {
    level thread crawler_round_tracker();
  }
  level thread track_players_ammo_count();
  DisableGrenadeSuicide();
  level.startInvulnerableTime = GetDvarInt(#"player_deathInvulnerableTime");
  if(!isDefined(level.music_override)) {
    level.music_override = false;
  }
}

zombiemode_melee_miss() {
  if(isDefined(self.enemy.curr_pay_turret)) {
    self.enemy doDamage(GetDvarInt(#"ai_meleeDamage"), self.origin, self, undefined, "melee", "none");
  }
}

init_additionalprimaryweapon_machine_locations() {
  switch (Tolower(getDvar(#"mapname"))) {
    case "zombie_theater":
      level.zombie_additionalprimaryweapon_machine_origin = (1172.4, -359.7, 320);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (1160, -360, 448);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
      break;
    case "zombie_pentagon":
      level.zombie_additionalprimaryweapon_machine_origin = (-1081.4, 1496.9, -512);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 162.2, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (-1084, 1489, -448);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 341.4, 0);
      break;
    case "zombie_cosmodrome":
      level.zombie_additionalprimaryweapon_machine_origin = (420.8, 1359.1, 55);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 270, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (436, 1359, 177);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
      level.zombie_additionalprimaryweapon_machine_monkey_angles = (0, 0, 0);
      level.zombie_additionalprimaryweapon_machine_monkey_origins = [];
      level.zombie_additionalprimaryweapon_machine_monkey_origins[0] = (398.8, 1398.6, 60);
      level.zombie_additionalprimaryweapon_machine_monkey_origins[1] = (380.8, 1358.6, 60);
      level.zombie_additionalprimaryweapon_machine_monkey_origins[2] = (398.8, 1318.6, 60);
      break;
    case "zombie_coast":
      level.zombie_additionalprimaryweapon_machine_origin = (2424.4, -2884.3, 314);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 231.6, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (2435, -2893, 439);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 322.2, 0);
      break;
    case "zombie_temple":
      level.zombie_additionalprimaryweapon_machine_origin = (-1352.9, -1437.2, -485);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 297.8, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (-1342, -1431, -361);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 28.8, 0);
      break;
    case "zombie_moon":
      level.zombie_additionalprimaryweapon_machine_origin = (1480.8, 3450, -65);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 180, 0);
      break;
    case "zombie_cod5_prototype":
      level.zombie_additionalprimaryweapon_machine_origin = (-160, -528, 1);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 0, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (-162, -517, 17);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
      break;
    case "zombie_cod5_asylum":
      level.zombie_additionalprimaryweapon_machine_origin = (-91, 540, 64);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (-103, 540, 92);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
      break;
    case "zombie_cod5_sumpf":
      level.zombie_additionalprimaryweapon_machine_origin = (9565, 327, -529);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (9555, 327, -402);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
      break;
    case "zombie_cod5_factory":
      level.zombie_additionalprimaryweapon_machine_origin = (-1089, -1366, 67);
      level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
      level.zombie_additionalprimaryweapon_machine_clip_origin = (-1100, -1365, 70);
      level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
      break;
  }
}

track_players_ammo_count() {
  self endon("disconnect");
  self endon("death");
  wait(5);
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].player_ammo_low)) {
        players[i].player_ammo_low = 0;
      }
      if(!isDefined(players[i].player_ammo_out)) {
        players[i].player_ammo_out = 0;
      }
      weap = players[i] getcurrentweapon();
      if(!isDefined(weap) ||
        weap == "none" ||
        isSubStr(weap, "zombie_perk_bottle") ||
        is_placeable_mine(weap) ||
        is_equipment(weap) ||
        weap == "syrette_sp" ||
        weap == "zombie_knuckle_crack" ||
        weap == "zombie_bowie_flourish" ||
        weap == "zombie_sickle_flourish" ||
        issubstr(weap, "knife_ballistic_") ||
        (GetSubStr(weap, 0, 3) == "gl_") ||
        weap == "humangun_zm" ||
        weap == "humangun_upgraded_zm" ||
        weap == "equip_gasmask_zm" ||
        weap == "lower_equip_gasmask_zm") {
        continue;
      }
      if(players[i] GetAmmoCount(weap) > 5) {
        continue;
      }
      if(players[i] maps\_laststand::player_is_in_laststand()) {
        continue;
      } else if(players[i] GetAmmoCount(weap) < 5 && players[i] GetAmmoCount(weap) > 0) {
        if(players[i].player_ammo_low != 1) {
          players[i].player_ammo_low = 1;
          players[i] maps\_zombiemode_audio::create_and_play_dialog("general", "ammo_low");
          players[i] thread ammo_dialog_timer();
        }
      } else if(players[i] GetAmmoCount(weap) == 0) {
        if(!isDefined(weap) || weap == "none") {
          continue;
        }
        wait(2);
        if(!isDefined(players[i])) {
          return;
        }
        if(players[i] GetAmmoCount(weap) != 0) {
          continue;
        }
        if(players[i].player_ammo_out != 1) {
          players[i].player_ammo_out = 1;
          players[i] maps\_zombiemode_audio::create_and_play_dialog("general", "ammo_out");
          players[i] thread ammoout_dialog_timer();
        }
      } else {
        continue;
      }
    }
    wait(.5);
  }
}

ammo_dialog_timer() {
  self endon("disconnect");
  self endon("death");
  wait(20);
  self.player_ammo_low = 0;
}

ammoout_dialog_timer() {
  self endon("disconnect");
  self endon("death");
  wait(20);
  self.player_ammo_out = 0;
}

spawn_vo() {
  wait(1);
  players = getplayers();
  if(players.size > 1) {
    player = random(players);
    index = maps\_zombiemode_weapons::get_player_index(player);
    player thread spawn_vo_player(index, players.size);
  }
}

spawn_vo_player(index, num) {
  sound = "plr_" + index + "_vox_" + num + "play";
  self playSound(sound, "sound_done");
  self waittill("sound_done");
}

testing_spawner_bug() {
  wait(0.1);
  level.round_number = 7;
  spawners = [];
  spawners[0] = getEnt("testy", "targetname");
  while(1) {
    wait(1);
    level.enemy_spawns = spawners;
  }
}

precache_shaders() {
  PrecacheShader("hud_chalk_1");
  PrecacheShader("hud_chalk_2");
  PrecacheShader("hud_chalk_3");
  PrecacheShader("hud_chalk_4");
  PrecacheShader("hud_chalk_5");
  PrecacheShader("zom_icon_community_pot");
  PrecacheShader("zom_icon_community_pot_strip");
  precacheshader("zom_icon_player_life");
}

precache_models() {
  precachemodel("char_ger_zombieeye");
  precachemodel("p_zom_win_bars_01_vert04_bend_180");
  precachemodel("p_zom_win_bars_01_vert01_bend_180");
  precachemodel("p_zom_win_bars_01_vert04_bend");
  precachemodel("p_zom_win_bars_01_vert01_bend");
  PreCacheModel("p_zom_win_cell_bars_01_vert04_bent");
  precachemodel("p_zom_win_cell_bars_01_vert01_bent");
  PrecacheModel("tag_origin");
  PrecacheModel("p_zom_counter_0");
  PrecacheModel("p_zom_counter_1");
  PrecacheModel("p_zom_counter_2");
  PrecacheModel("p_zom_counter_3");
  PrecacheModel("p_zom_counter_4");
  PrecacheModel("p_zom_counter_5");
  PrecacheModel("p_zom_counter_6");
  PrecacheModel("p_zom_counter_7");
  PrecacheModel("p_zom_counter_8");
  PrecacheModel("p_zom_counter_9");
  precachemodel("zombie_revive");
  PrecacheModel("zombie_z_money_icon");
}

init_shellshocks() {
  level.player_killed_shellshock = "zombie_death";
  PrecacheShellshock(level.player_killed_shellshock);
}

init_strings() {
  PrecacheString(&"ZOMBIE_WEAPONCOSTAMMO");
  PrecacheString(&"ZOMBIE_ROUND");
  PrecacheString(&"SCRIPT_PLUS");
  PrecacheString(&"ZOMBIE_GAME_OVER");
  PrecacheString(&"ZOMBIE_SURVIVED_ROUND");
  PrecacheString(&"ZOMBIE_SURVIVED_ROUNDS");
  PrecacheString(&"ZOMBIE_SURVIVED_NOMANS");
  PrecacheString(&"ZOMBIE_EXTRA_LIFE");
  add_zombie_hint("undefined", &"ZOMBIE_UNDEFINED");
  add_zombie_hint("default_treasure_chest_950", &"ZOMBIE_RANDOM_WEAPON_950");
  add_zombie_hint("default_buy_barrier_piece_10", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_10");
  add_zombie_hint("default_buy_barrier_piece_20", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_20");
  add_zombie_hint("default_buy_barrier_piece_50", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_50");
  add_zombie_hint("default_buy_barrier_piece_100", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_100");
  add_zombie_hint("default_reward_barrier_piece", &"ZOMBIE_BUTTON_REWARD_BARRIER");
  add_zombie_hint("default_reward_barrier_piece_10", &"ZOMBIE_BUTTON_REWARD_BARRIER_10");
  add_zombie_hint("default_reward_barrier_piece_20", &"ZOMBIE_BUTTON_REWARD_BARRIER_20");
  add_zombie_hint("default_reward_barrier_piece_30", &"ZOMBIE_BUTTON_REWARD_BARRIER_30");
  add_zombie_hint("default_reward_barrier_piece_40", &"ZOMBIE_BUTTON_REWARD_BARRIER_40");
  add_zombie_hint("default_reward_barrier_piece_50", &"ZOMBIE_BUTTON_REWARD_BARRIER_50");
  add_zombie_hint("default_buy_debris_100", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_100");
  add_zombie_hint("default_buy_debris_200", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_200");
  add_zombie_hint("default_buy_debris_250", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_250");
  add_zombie_hint("default_buy_debris_500", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_500");
  add_zombie_hint("default_buy_debris_750", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_750");
  add_zombie_hint("default_buy_debris_1000", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_1000");
  add_zombie_hint("default_buy_debris_1250", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_1250");
  add_zombie_hint("default_buy_debris_1500", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_1500");
  add_zombie_hint("default_buy_debris_1750", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_1750");
  add_zombie_hint("default_buy_debris_2000", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_2000");
  add_zombie_hint("default_buy_door_100", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_100");
  add_zombie_hint("default_buy_door_200", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_200");
  add_zombie_hint("default_buy_door_250", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_250");
  add_zombie_hint("default_buy_door_500", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_500");
  add_zombie_hint("default_buy_door_750", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_750");
  add_zombie_hint("default_buy_door_1000", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_1000");
  add_zombie_hint("default_buy_door_1250", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_1250");
  add_zombie_hint("default_buy_door_1500", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_1500");
  add_zombie_hint("default_buy_door_1750", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_1750");
  add_zombie_hint("default_buy_door_2000", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_2000");
  add_zombie_hint("default_buy_area_100", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_100");
  add_zombie_hint("default_buy_area_200", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_200");
  add_zombie_hint("default_buy_area_250", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_250");
  add_zombie_hint("default_buy_area_500", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_500");
  add_zombie_hint("default_buy_area_750", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_750");
  add_zombie_hint("default_buy_area_1000", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_1000");
  add_zombie_hint("default_buy_area_1250", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_1250");
  add_zombie_hint("default_buy_area_1500", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_1500");
  add_zombie_hint("default_buy_area_1750", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_1750");
  add_zombie_hint("default_buy_area_2000", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_2000");
  add_zombie_hint("powerup_fire_sale_cost", &"ZOMBIE_FIRE_SALE_COST");
}

init_sounds() {
  add_sound("end_of_round", "mus_zmb_round_over");
  add_sound("end_of_game", "mus_zmb_game_over");
  add_sound("chalk_one_up", "mus_zmb_chalk");
  add_sound("purchase", "zmb_cha_ching");
  add_sound("no_purchase", "zmb_no_cha_ching");
  add_sound("playerzombie_usebutton_sound", "zmb_zombie_vocals_attack");
  add_sound("playerzombie_attackbutton_sound", "zmb_zombie_vocals_attack");
  add_sound("playerzombie_adsbutton_sound", "zmb_zombie_vocals_attack");
  add_sound("zombie_head_gib", "zmb_zombie_head_gib");
  add_sound("rebuild_barrier_piece", "zmb_repair_boards");
  add_sound("rebuild_barrier_metal_piece", "zmb_metal_repair");
  add_sound("rebuild_barrier_hover", "zmb_boards_float");
  add_sound("debris_hover_loop", "zmb_couch_loop");
  add_sound("break_barrier_piece", "zmb_break_boards");
  add_sound("grab_metal_bar", "zmb_bar_pull");
  add_sound("break_metal_bar", "zmb_bar_break");
  add_sound("drop_metal_bar", "zmb_bar_drop");
  add_sound("blocker_end_move", "zmb_board_slam");
  add_sound("barrier_rebuild_slam", "zmb_board_slam");
  add_sound("bar_rebuild_slam", "zmb_bar_repair");
  add_sound("zmb_rock_fix", "zmb_break_rock_barrier_fix");
  add_sound("zmb_vent_fix", "evt_vent_slat_repair");
  add_sound("door_slide_open", "zmb_door_slide_open");
  add_sound("door_rotate_open", "zmb_door_slide_open");
  add_sound("debris_move", "zmb_weap_wall");
  add_sound("open_chest", "zmb_lid_open");
  add_sound("music_chest", "zmb_music_box");
  add_sound("close_chest", "zmb_lid_close");
  add_sound("weapon_show", "zmb_weap_wall");
}

init_levelvars() {
  level.is_zombie_level = true;
  level.laststandpistol = "m1911_zm";
  level.first_round = true;
  level.round_number = 1;
  level.round_start_time = 0;
  level.pro_tips_start_time = 0;
  level.intermission = false;
  level.dog_intermission = false;
  level.zombie_total = 0;
  level.total_zombies_killed = 0;
  level.no_laststandmissionfail = true;
  level.hudelem_count = 0;
  level.zombie_move_speed = 1;
  level.enemy_spawns = [];
  level.zombie_rise_spawners = [];
  level.counter_model[0] = "p_zom_counter_0";
  level.counter_model[1] = "p_zom_counter_1";
  level.counter_model[2] = "p_zom_counter_2";
  level.counter_model[3] = "p_zom_counter_3";
  level.counter_model[4] = "p_zom_counter_4";
  level.counter_model[5] = "p_zom_counter_5";
  level.counter_model[6] = "p_zom_counter_6";
  level.counter_model[7] = "p_zom_counter_7";
  level.counter_model[8] = "p_zom_counter_8";
  level.counter_model[9] = "p_zom_counter_9";
  level.zombie_vars = [];
  difficulty = 1;
  column = int(difficulty) + 1;
  set_zombie_var("zombie_health_increase", 100, false, column);
  set_zombie_var("zombie_health_increase_multiplier", 0.1, true, column);
  set_zombie_var("zombie_health_start", 150, false, column);
  set_zombie_var("zombie_spawn_delay", 2.0, true, column);
  set_zombie_var("zombie_new_runner_interval", 10, false, column);
  set_zombie_var("zombie_move_speed_multiplier", 8, false, column);
  set_zombie_var("zombie_max_ai", 24, false, column);
  set_zombie_var("zombie_ai_per_player", 6, false, column);
  set_zombie_var("below_world_check", -1000);
  set_zombie_var("spectators_respawn", true);
  set_zombie_var("zombie_use_failsafe", true);
  set_zombie_var("zombie_between_round_time", 10);
  set_zombie_var("zombie_intermission_time", 15);
  set_zombie_var("game_start_delay", 0, false, column);
  set_zombie_var("penalty_no_revive", 0.10, true, column);
  set_zombie_var("penalty_died", 0.0, true, column);
  set_zombie_var("penalty_downed", 0.05, true, column);
  set_zombie_var("starting_lives", 1, false, column);
  players = get_players();
  points = set_zombie_var(("zombie_score_start_" + players.size + "p"), 3000, false, column);
  points = set_zombie_var(("zombie_score_start_" + players.size + "p"), 3000, false, column);
  set_zombie_var("zombie_score_kill_4player", 50);
  set_zombie_var("zombie_score_kill_3player", 50);
  set_zombie_var("zombie_score_kill_2player", 50);
  set_zombie_var("zombie_score_kill_1player", 50);
  set_zombie_var("zombie_score_kill_4p_team", 30);
  set_zombie_var("zombie_score_kill_3p_team", 35);
  set_zombie_var("zombie_score_kill_2p_team", 45);
  set_zombie_var("zombie_score_kill_1p_team", 0);
  set_zombie_var("zombie_score_damage_normal", 10);
  set_zombie_var("zombie_score_damage_light", 10);
  set_zombie_var("zombie_score_bonus_melee", 80);
  set_zombie_var("zombie_score_bonus_head", 50);
  set_zombie_var("zombie_score_bonus_neck", 20);
  set_zombie_var("zombie_score_bonus_torso", 10);
  set_zombie_var("zombie_score_bonus_burn", 10);
  set_zombie_var("zombie_flame_dmg_point_delay", 500);
  set_zombie_var("zombify_player", false);
  if(IsSplitScreen()) {
    set_zombie_var("zombie_timer_offset", 280);
  }
}

init_dvars() {
  setSavedDvar("fire_world_damage", "0");
  setSavedDvar("fire_world_damage_rate", "0");
  setSavedDvar("fire_world_damage_duration", "0");
  if(getDvar(#"zombie_debug") == "") {
    SetDvar("zombie_debug", "0");
  }
  if(getDvar(#"zombie_cheat") == "") {
    SetDvar("zombie_cheat", "0");
  }
  if(level.script != "zombie_cod5_prototype") {
    SetDvar("magic_chest_movable", "1");
  }
  if(getDvar(#"magic_box_explore_only") == "") {
    SetDvar("magic_box_explore_only", "1");
  }
  SetDvar("revive_trigger_radius", "75");
  SetDvar("player_lastStandBleedoutTime", "45");
  SetDvar("scr_deleteexplosivesonspawn", "0");
}

init_mutators() {
  level.mutators = [];
  init_mutator("mutator_noPerks");
  init_mutator("mutator_noTraps");
  init_mutator("mutator_noMagicBox");
  init_mutator("mutator_noRevive");
  init_mutator("mutator_noPowerups");
  init_mutator("mutator_noReloads");
  init_mutator("mutator_noBoards");
  init_mutator("mutator_fogMatch");
  init_mutator("mutator_quickStart");
  init_mutator("mutator_headshotsOnly");
  init_mutator("mutator_friendlyFire");
  init_mutator("mutator_doubleMoney");
  init_mutator("mutator_susceptible");
  init_mutator("mutator_powerShot");
}

init_mutator(mutator_s) {
  level.mutators[mutator_s] = ("1" == getDvar(mutator_s));
}

init_function_overrides() {
  level.custom_introscreen = ::zombie_intro_screen;
  level.custom_intermission = ::player_intermission;
  level.reset_clientdvars = ::onPlayerConnect_clientDvars;
  level.playerlaststand_func = ::player_laststand;
  level.global_damage_func = maps\_zombiemode_spawner::zombie_damage;
  level.global_damage_func_ads = maps\_zombiemode_spawner::zombie_damage_ads;
  level.overridePlayerKilled = ::player_killed_override;
  level.overridePlayerDamage = ::player_damage_override;
  level.overrideActorKilled = ::actor_killed_override;
  level.overrideActorDamage = ::actor_damage_override;
  level.melee_miss_func = ::zombiemode_melee_miss;
  level.player_becomes_zombie = ::zombify_player;
  level.is_friendly_fire_on = ::is_friendly_fire_on;
  level.can_revive = ::can_revive;
  level.zombie_last_stand = ::last_stand_pistol_swap;
  level.zombie_last_stand_pistol_memory = ::last_stand_save_pistol_ammo;
  level.zombie_last_stand_ammo_return = ::last_stand_restore_pistol_ammo;
  level.prevent_player_damage = ::player_prevent_damage;
  if(!isDefined(level.Player_Spawn_func)) {
    level.Player_Spawn_func = ::coop_player_spawn_placement;
  }
}

initZombieLeaderboardData() {
  level.zombieLeaderboardStatVariable["zombie_theater"]["highestwave"] = "zombie_theater_highestwave";
  level.zombieLeaderboardStatVariable["zombie_theater"]["timeinwave"] = "zombie_theater_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_theater"]["totalpoints"] = "zombie_theater_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_pentagon"]["highestwave"] = "zombie_pentagon_highestwave";
  level.zombieLeaderboardStatVariable["zombie_pentagon"]["timeinwave"] = "zombie_pentagon_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_pentagon"]["totalpoints"] = "zombie_pentagon_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_cod5_asylum"]["highestwave"] = "zombie_asylum_highestwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_asylum"]["timeinwave"] = "zombie_asylum_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_asylum"]["totalpoints"] = "zombie_asylum_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_cod5_factory"]["highestwave"] = "zombie_factory_highestwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_factory"]["timeinwave"] = "zombie_factory_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_factory"]["totalpoints"] = "zombie_factory_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_cod5_prototype"]["highestwave"] = "zombie_prototype_highestwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_prototype"]["timeinwave"] = "zombie_prototype_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_prototype"]["totalpoints"] = "zombie_prototype_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_cod5_sumpf"]["highestwave"] = "zombie_sumpf_highestwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_sumpf"]["timeinwave"] = "zombie_sumpf_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_cod5_sumpf"]["totalpoints"] = "zombie_sumpf_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_cosmodrome"]["highestwave"] = "zombie_cosmodrome_highestwave";
  level.zombieLeaderboardStatVariable["zombie_cosmodrome"]["timeinwave"] = "zombie_cosmodrome_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_cosmodrome"]["totalpoints"] = "zombie_cosmodrome_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_coast"]["highestwave"] = "zombie_coast_highestwave";
  level.zombieLeaderboardStatVariable["zombie_coast"]["timeinwave"] = "zombie_coast_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_coast"]["totalpoints"] = "zombie_coast_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_temple"]["highestwave"] = "zombie_temple_highestwave";
  level.zombieLeaderboardStatVariable["zombie_temple"]["timeinwave"] = "zombie_temple_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_temple"]["totalpoints"] = "zombie_temple_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_moon"]["highestwave"] = "zombie_moon_highestwave";
  level.zombieLeaderboardStatVariable["zombie_moon"]["timeinwave"] = "zombie_moon_timeinwave";
  level.zombieLeaderboardStatVariable["zombie_moon"]["totalpoints"] = "zombie_moon_totalpoints";
  level.zombieLeaderboardStatVariable["zombie_moon"]["nomanslandtime"] = "zombie_moon_nomansland";
  level.zombieLeaderboardNumber["zombie_theater"]["waves"] = 0;
  level.zombieLeaderboardNumber["zombie_theater"]["points"] = 1;
  level.zombieLeaderboardNumber["zombie_pentagon"]["waves"] = 6;
  level.zombieLeaderboardNumber["zombie_pentagon"]["points"] = 7;
  level.zombieLeaderboardNumber["zombie_cod5_asylum"]["waves"] = 9;
  level.zombieLeaderboardNumber["zombie_cod5_asylum"]["points"] = 10;
  level.zombieLeaderboardNumber["zombie_cod5_factory"]["waves"] = 12;
  level.zombieLeaderboardNumber["zombie_cod5_factory"]["points"] = 13;
  level.zombieLeaderboardNumber["zombie_cod5_prototype"]["waves"] = 15;
  level.zombieLeaderboardNumber["zombie_cod5_prototype"]["points"] = 16;
  level.zombieLeaderboardNumber["zombie_cod5_sumpf"]["waves"] = 18;
  level.zombieLeaderboardNumber["zombie_cod5_sumpf"]["points"] = 19;
  level.zombieLeaderboardNumber["zombie_cosmodrome"]["waves"] = 21;
  level.zombieLeaderboardNumber["zombie_cosmodrome"]["points"] = 22;
  level.zombieLeaderboardNumber["zombie_coast"]["waves"] = 24;
  level.zombieLeaderboardNumber["zombie_coast"]["points"] = 25;
  level.zombieLeaderboardNumber["zombie_temple"]["waves"] = 27;
  level.zombieLeaderboardNumber["zombie_temple"]["points"] = 28;
  level.zombieLeaderboardNumber["zombie_moon"]["waves"] = 30;
  level.zombieLeaderboardNumber["zombie_moon"]["points"] = 31;
  level.zombieLeaderboardNumber["zombie_moon"]["kills"] = 32;
}

init_flags() {
  flag_init("spawn_point_override");
  flag_init("power_on");
  flag_init("crawler_round");
  flag_init("spawn_zombies", true);
  flag_init("dog_round");
  flag_init("begin_spawning");
  flag_init("end_round_wait");
  flag_init("wait_and_revive");
  flag_init("instant_revive");
}

init_client_flags() {
  level._ZOMBIE_SCRIPTMOVER_FLAG_BOX_RANDOM = 15;
  if(is_true(level.use_clientside_board_fx)) {
    level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_HORIZONTAL_FX = 14;
    level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_VERTICAL_FX = 13;
  }
  if(is_true(level.use_clientside_rock_tearin_fx)) {
    level._ZOMBIE_SCRIPTMOVER_FLAG_ROCK_FX = 12;
  }
  level._ZOMBIE_PLAYER_FLAG_CLOAK_WEAPON = 14;
  level._ZOMBIE_PLAYER_FLAG_DIVE2NUKE_VISION = 13;
  level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK = 12;
  if(is_true(level.riser_fx_on_client)) {
    level._ZOMBIE_ACTOR_ZOMBIE_RISER_FX = 8;
    if(!isDefined(level._no_water_risers)) {
      level._ZOMBIE_ACTOR_ZOMBIE_RISER_FX_WATER = 9;
    }
    if(is_true(level.risers_use_low_gravity_fx)) {
      level._ZOMBIE_ACTOR_ZOMBIE_RISER_LOWG_FX = 7;
    }
  }
}

init_fx() {
  level._effect["wood_chunk_destory"] = LoadFX("impacts/fx_large_woodhit");
  level._effect["fx_zombie_bar_break"] = LoadFX("maps/zombie/fx_zombie_bar_break");
  level._effect["fx_zombie_bar_break_lite"] = LoadFX("maps/zombie/fx_zombie_bar_break_lite");
  level._effect["edge_fog"] = LoadFX("maps/zombie/fx_fog_zombie_amb");
  level._effect["chest_light"] = LoadFX("env/light/fx_ray_sun_sm_short");
  level._effect["eye_glow"] = LoadFX("misc/fx_zombie_eye_single");
  level._effect["headshot"] = LoadFX("impacts/fx_flesh_hit");
  level._effect["headshot_nochunks"] = LoadFX("misc/fx_zombie_bloodsplat");
  level._effect["bloodspurt"] = LoadFX("misc/fx_zombie_bloodspurt");
  level._effect["tesla_head_light"] = LoadFX("maps/zombie/fx_zombie_tesla_neck_spurt");
  level._effect["rise_burst_water"] = LoadFX("maps/zombie/fx_zombie_body_wtr_burst");
  level._effect["rise_billow_water"] = LoadFX("maps/zombie/fx_zombie_body_wtr_billowing");
  level._effect["rise_dust_water"] = LoadFX("maps/zombie/fx_zombie_body_wtr_falling");
  level._effect["rise_burst"] = LoadFX("maps/zombie/fx_mp_zombie_hand_dirt_burst");
  level._effect["rise_billow"] = LoadFX("maps/zombie/fx_mp_zombie_body_dirt_billowing");
  level._effect["rise_dust"] = LoadFX("maps/zombie/fx_mp_zombie_body_dust_falling");
  level._effect["fall_burst"] = LoadFX("maps/zombie/fx_mp_zombie_hand_dirt_burst");
  level._effect["fall_billow"] = LoadFX("maps/zombie/fx_mp_zombie_body_dirt_billowing");
  level._effect["fall_dust"] = LoadFX("maps/zombie/fx_mp_zombie_body_dust_falling");
  level._effect["character_fire_pain_sm"] = LoadFX("env/fire/fx_fire_player_sm_1sec");
  level._effect["character_fire_death_sm"] = LoadFX("env/fire/fx_fire_player_md");
  level._effect["character_fire_death_torso"] = LoadFX("env/fire/fx_fire_player_torso");
  level._effect["def_explosion"] = LoadFX("explosions/fx_default_explosion");
  level._effect["betty_explode"] = LoadFX("weapon/bouncing_betty/fx_explosion_betty_generic");
}

init_standard_zombie_anims() {
  level.scr_anim["zombie"]["death1"] = % ai_zombie_death_v1;
  level.scr_anim["zombie"]["death2"] = % ai_zombie_death_v2;
  level.scr_anim["zombie"]["death3"] = % ai_zombie_crawl_death_v1;
  level.scr_anim["zombie"]["death4"] = % ai_zombie_crawl_death_v2;
  level.scr_anim["zombie"]["walk1"] = % ai_zombie_walk_v1;
  level.scr_anim["zombie"]["walk2"] = % ai_zombie_walk_v2;
  level.scr_anim["zombie"]["walk3"] = % ai_zombie_walk_v3;
  level.scr_anim["zombie"]["walk4"] = % ai_zombie_walk_v4;
  level.scr_anim["zombie"]["walk5"] = % ai_zombie_walk_v6;
  level.scr_anim["zombie"]["walk6"] = % ai_zombie_walk_v7;
  level.scr_anim["zombie"]["walk7"] = % ai_zombie_walk_v9;
  level.scr_anim["zombie"]["walk8"] = % ai_zombie_walk_v9;
  level.scr_anim["zombie"]["run1"] = % ai_zombie_walk_fast_v1;
  level.scr_anim["zombie"]["run2"] = % ai_zombie_walk_fast_v2;
  level.scr_anim["zombie"]["run3"] = % ai_zombie_walk_fast_v3;
  level.scr_anim["zombie"]["run4"] = % ai_zombie_run_v2;
  level.scr_anim["zombie"]["run5"] = % ai_zombie_run_v4;
  level.scr_anim["zombie"]["run6"] = % ai_zombie_run_v3;
  level.scr_anim["zombie"]["sprint1"] = % ai_zombie_sprint_v1;
  level.scr_anim["zombie"]["sprint2"] = % ai_zombie_sprint_v2;
  level.scr_anim["zombie"]["sprint3"] = % ai_zombie_sprint_v1;
  level.scr_anim["zombie"]["sprint4"] = % ai_zombie_sprint_v2;
  level.scr_anim["zombie"]["crawl1"] = % ai_zombie_crawl;
  level.scr_anim["zombie"]["crawl2"] = % ai_zombie_crawl_v1;
  level.scr_anim["zombie"]["crawl3"] = % ai_zombie_crawl_v2;
  level.scr_anim["zombie"]["crawl4"] = % ai_zombie_crawl_v3;
  level.scr_anim["zombie"]["crawl5"] = % ai_zombie_crawl_v4;
  level.scr_anim["zombie"]["crawl6"] = % ai_zombie_crawl_v5;
  level.scr_anim["zombie"]["crawl_hand_1"] = % ai_zombie_walk_on_hands_a;
  level.scr_anim["zombie"]["crawl_hand_2"] = % ai_zombie_walk_on_hands_b;
  level.scr_anim["zombie"]["crawl_sprint1"] = % ai_zombie_crawl_sprint;
  level.scr_anim["zombie"]["crawl_sprint2"] = % ai_zombie_crawl_sprint_1;
  level.scr_anim["zombie"]["crawl_sprint3"] = % ai_zombie_crawl_sprint_2;
  if(!isDefined(level._zombie_melee)) {
    level._zombie_melee = [];
  }
  if(!isDefined(level._zombie_walk_melee)) {
    level._zombie_walk_melee = [];
  }
  if(!isDefined(level._zombie_run_melee)) {
    level._zombie_run_melee = [];
  }
  level._zombie_melee["zombie"] = [];
  level._zombie_walk_melee["zombie"] = [];
  level._zombie_run_melee["zombie"] = [];
  level._zombie_melee["zombie"][0] = % ai_zombie_attack_v2;
  level._zombie_melee["zombie"][1] = % ai_zombie_attack_v4;
  level._zombie_melee["zombie"][2] = % ai_zombie_attack_v6;
  level._zombie_melee["zombie"][3] = % ai_zombie_attack_v1;
  level._zombie_melee["zombie"][4] = % ai_zombie_attack_forward_v1;
  level._zombie_melee["zombie"][5] = % ai_zombie_attack_forward_v2;
  level._zombie_run_melee["zombie"][0] = % ai_zombie_run_attack_v1;
  level._zombie_run_melee["zombie"][1] = % ai_zombie_run_attack_v2;
  level._zombie_run_melee["zombie"][2] = % ai_zombie_run_attack_v3;
  if(isDefined(level.zombie_anim_override)) {
    [[level.zombie_anim_override]]();
  }
  level._zombie_walk_melee["zombie"][0] = % ai_zombie_walk_attack_v1;
  level._zombie_walk_melee["zombie"][1] = % ai_zombie_walk_attack_v2;
  level._zombie_walk_melee["zombie"][2] = % ai_zombie_walk_attack_v3;
  level._zombie_walk_melee["zombie"][3] = % ai_zombie_walk_attack_v4;
  if(!isDefined(level._zombie_melee_crawl)) {
    level._zombie_melee_crawl = [];
  }
  level._zombie_melee_crawl["zombie"] = [];
  level._zombie_melee_crawl["zombie"][0] = % ai_zombie_attack_crawl;
  level._zombie_melee_crawl["zombie"][1] = % ai_zombie_attack_crawl_lunge;
  if(!isDefined(level._zombie_stumpy_melee)) {
    level._zombie_stumpy_melee = [];
  }
  level._zombie_stumpy_melee["zombie"] = [];
  level._zombie_stumpy_melee["zombie"][0] = % ai_zombie_walk_on_hands_shot_a;
  level._zombie_stumpy_melee["zombie"][1] = % ai_zombie_walk_on_hands_shot_b;
  if(!isDefined(level._zombie_tesla_death)) {
    level._zombie_tesla_death = [];
  }
  level._zombie_tesla_death["zombie"] = [];
  level._zombie_tesla_death["zombie"][0] = % ai_zombie_tesla_death_a;
  level._zombie_tesla_death["zombie"][1] = % ai_zombie_tesla_death_b;
  level._zombie_tesla_death["zombie"][2] = % ai_zombie_tesla_death_c;
  level._zombie_tesla_death["zombie"][3] = % ai_zombie_tesla_death_d;
  level._zombie_tesla_death["zombie"][4] = % ai_zombie_tesla_death_e;
  if(!isDefined(level._zombie_tesla_crawl_death)) {
    level._zombie_tesla_crawl_death = [];
  }
  level._zombie_tesla_crawl_death["zombie"] = [];
  level._zombie_tesla_crawl_death["zombie"][0] = % ai_zombie_tesla_crawl_death_a;
  level._zombie_tesla_crawl_death["zombie"][1] = % ai_zombie_tesla_crawl_death_b;
  if(!isDefined(level._zombie_knockdowns)) {
    level._zombie_knockdowns = [];
  }
  level._zombie_knockdowns["zombie"] = [];
  level._zombie_knockdowns["zombie"]["front"] = [];
  level._zombie_knockdowns["zombie"]["front"]["no_legs"] = [];
  level._zombie_knockdowns["zombie"]["front"]["no_legs"][0] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["no_legs"][1] = % ai_zombie_thundergun_hit_doublebounce;
  level._zombie_knockdowns["zombie"]["front"]["no_legs"][2] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"] = [];
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][0] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][1] = % ai_zombie_thundergun_hit_doublebounce;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][2] = % ai_zombie_thundergun_hit_upontoback;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][3] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][4] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][5] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][6] = % ai_zombie_thundergun_hit_stumblefall;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][7] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][8] = % ai_zombie_thundergun_hit_doublebounce;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][9] = % ai_zombie_thundergun_hit_upontoback;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][10] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][11] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][12] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][13] = % ai_zombie_thundergun_hit_deadfallknee;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][14] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][15] = % ai_zombie_thundergun_hit_doublebounce;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][16] = % ai_zombie_thundergun_hit_upontoback;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][17] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][18] = % ai_zombie_thundergun_hit_armslegsforward;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][19] = % ai_zombie_thundergun_hit_forwardtoface;
  level._zombie_knockdowns["zombie"]["front"]["has_legs"][20] = % ai_zombie_thundergun_hit_flatonback;
  level._zombie_knockdowns["zombie"]["left"] = [];
  level._zombie_knockdowns["zombie"]["left"][0] = % ai_zombie_thundergun_hit_legsout_right;
  level._zombie_knockdowns["zombie"]["right"] = [];
  level._zombie_knockdowns["zombie"]["right"][0] = % ai_zombie_thundergun_hit_legsout_left;
  level._zombie_knockdowns["zombie"]["back"] = [];
  level._zombie_knockdowns["zombie"]["back"][0] = % ai_zombie_thundergun_hit_faceplant;
  if(!isDefined(level._zombie_getups)) {
    level._zombie_getups = [];
  }
  level._zombie_getups["zombie"] = [];
  level._zombie_getups["zombie"]["back"] = [];
  level._zombie_getups["zombie"]["back"]["early"] = [];
  level._zombie_getups["zombie"]["back"]["early"][0] = % ai_zombie_thundergun_getup_b;
  level._zombie_getups["zombie"]["back"]["early"][1] = % ai_zombie_thundergun_getup_c;
  level._zombie_getups["zombie"]["back"]["late"] = [];
  level._zombie_getups["zombie"]["back"]["late"][0] = % ai_zombie_thundergun_getup_b;
  level._zombie_getups["zombie"]["back"]["late"][1] = % ai_zombie_thundergun_getup_c;
  level._zombie_getups["zombie"]["back"]["late"][2] = % ai_zombie_thundergun_getup_quick_b;
  level._zombie_getups["zombie"]["back"]["late"][3] = % ai_zombie_thundergun_getup_quick_c;
  level._zombie_getups["zombie"]["belly"] = [];
  level._zombie_getups["zombie"]["belly"]["early"] = [];
  level._zombie_getups["zombie"]["belly"]["early"][0] = % ai_zombie_thundergun_getup_a;
  level._zombie_getups["zombie"]["belly"]["late"] = [];
  level._zombie_getups["zombie"]["belly"]["late"][0] = % ai_zombie_thundergun_getup_a;
  level._zombie_getups["zombie"]["belly"]["late"][1] = % ai_zombie_thundergun_getup_quick_a;
  if(!isDefined(level._zombie_freezegun_death)) {
    level._zombie_freezegun_death = [];
  }
  level._zombie_freezegun_death["zombie"] = [];
  level._zombie_freezegun_death["zombie"][0] = % ai_zombie_freeze_death_a;
  level._zombie_freezegun_death["zombie"][1] = % ai_zombie_freeze_death_b;
  level._zombie_freezegun_death["zombie"][2] = % ai_zombie_freeze_death_c;
  level._zombie_freezegun_death["zombie"][3] = % ai_zombie_freeze_death_d;
  level._zombie_freezegun_death["zombie"][4] = % ai_zombie_freeze_death_e;
  if(!isDefined(level._zombie_freezegun_death_missing_legs)) {
    level._zombie_freezegun_death_missing_legs = [];
  }
  level._zombie_freezegun_death_missing_legs["zombie"] = [];
  level._zombie_freezegun_death_missing_legs["zombie"][0] = % ai_zombie_crawl_freeze_death_01;
  level._zombie_freezegun_death_missing_legs["zombie"][1] = % ai_zombie_crawl_freeze_death_02;
  if(!isDefined(level._zombie_deaths)) {
    level._zombie_deaths = [];
  }
  level._zombie_deaths["zombie"] = [];
  level._zombie_deaths["zombie"][0] = % ch_dazed_a_death;
  level._zombie_deaths["zombie"][1] = % ch_dazed_b_death;
  level._zombie_deaths["zombie"][2] = % ch_dazed_c_death;
  level._zombie_deaths["zombie"][3] = % ch_dazed_d_death;
  if(!isDefined(level._zombie_rise_anims)) {
    level._zombie_rise_anims = [];
  }
  level._zombie_rise_anims["zombie"] = [];
  level._zombie_rise_anims["zombie"][1]["walk"][0] = % ai_zombie_traverse_ground_v1_walk;
  level._zombie_rise_anims["zombie"][1]["run"][0] = % ai_zombie_traverse_ground_v1_run;
  level._zombie_rise_anims["zombie"][1]["sprint"][0] = % ai_zombie_traverse_ground_climbout_fast;
  level._zombie_rise_anims["zombie"][2]["walk"][0] = % ai_zombie_traverse_ground_v2_walk_altA;
  if(!isDefined(level._zombie_rise_death_anims)) {
    level._zombie_rise_death_anims = [];
  }
  level._zombie_rise_death_anims["zombie"] = [];
  level._zombie_rise_death_anims["zombie"][1]["in"][0] = % ai_zombie_traverse_ground_v1_deathinside;
  level._zombie_rise_death_anims["zombie"][1]["in"][1] = % ai_zombie_traverse_ground_v1_deathinside_alt;
  level._zombie_rise_death_anims["zombie"][1]["out"][0] = % ai_zombie_traverse_ground_v1_deathoutside;
  level._zombie_rise_death_anims["zombie"][1]["out"][1] = % ai_zombie_traverse_ground_v1_deathoutside_alt;
  level._zombie_rise_death_anims["zombie"][2]["in"][0] = % ai_zombie_traverse_ground_v2_death_low;
  level._zombie_rise_death_anims["zombie"][2]["in"][1] = % ai_zombie_traverse_ground_v2_death_low_alt;
  level._zombie_rise_death_anims["zombie"][2]["out"][0] = % ai_zombie_traverse_ground_v2_death_high;
  level._zombie_rise_death_anims["zombie"][2]["out"][1] = % ai_zombie_traverse_ground_v2_death_high_alt;
  if(!isDefined(level._zombie_run_taunt)) {
    level._zombie_run_taunt = [];
  }
  if(!isDefined(level._zombie_board_taunt)) {
    level._zombie_board_taunt = [];
  }
  level._zombie_run_taunt["zombie"] = [];
  level._zombie_board_taunt["zombie"] = [];
  level._zombie_board_taunt["zombie"][0] = % ai_zombie_taunts_4;
  level._zombie_board_taunt["zombie"][1] = % ai_zombie_taunts_7;
  level._zombie_board_taunt["zombie"][2] = % ai_zombie_taunts_9;
  level._zombie_board_taunt["zombie"][3] = % ai_zombie_taunts_5b;
  level._zombie_board_taunt["zombie"][4] = % ai_zombie_taunts_5c;
  level._zombie_board_taunt["zombie"][5] = % ai_zombie_taunts_5d;
  level._zombie_board_taunt["zombie"][6] = % ai_zombie_taunts_5e;
  level._zombie_board_taunt["zombie"][7] = % ai_zombie_taunts_5f;
}

init_anims() {
  init_standard_zombie_anims();
}

init_animscripts() {
  animscripts\zombie_init::firstInit();
  anim.idleAnimArray["stand"] = [];
  anim.idleAnimWeights["stand"] = [];
  anim.idleAnimArray["stand"][0][0] = % ai_zombie_idle_v1_delta;
  anim.idleAnimWeights["stand"][0][0] = 10;
  anim.idleAnimArray["crouch"] = [];
  anim.idleAnimWeights["crouch"] = [];
  anim.idleAnimArray["crouch"][0][0] = % ai_zombie_idle_crawl_delta;
  anim.idleAnimWeights["crouch"][0][0] = 10;
}

zombie_intro_screen(string1, string2, string3, string4, string5) {
  flag_wait("all_players_connected");
}

players_playing() {
  players = get_players();
  level.players_playing = players.size;
  wait(20);
  players = get_players();
  level.players_playing = players.size;
}

difficulty_init() {
  flag_wait("all_players_connected");
  difficulty = 1;
  table = "mp/zombiemode.csv";
  column = int(difficulty) + 1;
  players = get_players();
  points = 500;
  points = set_zombie_var(("zombie_score_start_" + players.size + "p"), 3000, false, column);
  for(p = 0; p < players.size; p++) {
    players[p].score = points;
    players[p].score_total = players[p].score;
    players[p].old_score = players[p].score;
  }
  points = set_zombie_var(("zombie_team_score_start_" + players.size + "p"), 2000, false, column);
  for(tp = 0; tp < level.team_pool.size; tp++) {
    pool = level.team_pool[tp];
    pool.score = points;
    pool.old_score = pool.score;
    pool.score_total = pool.score;
  }
  switch (difficulty) {
    case "0":
    case "1":
      break;
    case "2":
      level.first_round = false;
      level.round_number = 8;
      break;
    case "3":
      level.first_round = false;
      level.round_number = 18;
      break;
    default:
      break;
  }
  if(level.mutators["mutator_quickStart"]) {
    level.first_round = false;
    level.round_number = 5;
  }
}

watchTakenDamage() {
  self endon("disconnect");
  self endon("death");
  self.has_taken_damage = false;
  while(1) {
    self waittill("damage", damage_amount);
    if(0 < damage_amount) {
      self.has_taken_damage = true;
      return;
    }
  }
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player.entity_num = player getEntityNumber();
    player thread onPlayerSpawned();
    player thread onPlayerDisconnect();
    player thread player_revive_monitor();
    player freezecontrols(true);
    player thread watchTakenDamage();
    player.score = 0;
    player.score_total = player.score;
    player.old_score = player.score;
    player.is_zombie = false;
    player.initialized = false;
    player.zombification_time = 0;
    player.enableText = true;
    player.team_num = 0;
    player setTeamForEntity("allies");
    player thread maps\_zombiemode_blockers::rebuild_barrier_reward_reset();
  }
}

onPlayerConnect_clientDvars() {
  self SetClientDvars("cg_deadChatWithDead", "1",
    "cg_deadChatWithTeam", "1",
    "cg_deadHearTeamLiving", "1",
    "cg_deadHearAllLiving", "1",
    "cg_everyoneHearsEveryone", "1",
    "compass", "0",
    "hud_showStance", "0",
    "cg_thirdPerson", "0",
    "cg_fov", "65",
    "cg_thirdPersonAngle", "0",
    "ammoCounterHide", "1",
    "miniscoreboardhide", "1",
    "cg_drawSpectatorMessages", "0",
    "ui_hud_hardcore", "0",
    "playerPushAmount", "1");
  self SetDepthOfField(0, 0, 512, 4000, 4, 0);
  self setClientDvar("aim_lockon_pitch_strength", 0.0);
  if(!level.wii) {}
}

checkForAllDead() {
  players = get_players();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(!(players[i] maps\_laststand::player_is_in_laststand()) && !(players[i].sessionstate == "spectator")) {
      count++;
    }
  }
  if(count == 0) {
    level notify("end_game");
  }
}

onPlayerDisconnect() {
  self waittill("disconnect");
  self remove_from_spectate_list();
  self checkForAllDead();
}

onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self freezecontrols(false);
    self init_player_offhand_weapons();
    self enablehealthshield(false);
    self PlayerKnockback(false);
    self SetClientDvars("cg_thirdPerson", "0",
      "cg_fov", "65",
      "cg_thirdPersonAngle", "0");
    self SetDepthOfField(0, 0, 512, 4000, 4, 0);
    self cameraactivate(false);
    self add_to_spectate_list();
    self.num_perks = 0;
    self.on_lander_last_stand = undefined;
    if(is_true(level.player_out_of_playable_area_monitor)) {
      self thread player_out_of_playable_area_monitor();
    }
    if(is_true(level.player_too_many_weapons_monitor)) {
      self thread[[level.player_too_many_weapons_monitor_func]]();
    }
    if(isDefined(self.initialized)) {
      if(self.initialized == false) {
        self.initialized = true;
        self freezecontrols(true);
        self.is_drinking = 0;
        self maps\_zombiemode_score::set_player_score_hud(true);
        self thread player_zombie_breadcrumb();
        self.stats["kills"] = 0;
        self.stats["score"] = 0;
        self.stats["downs"] = 0;
        self.stats["revives"] = 0;
        self.stats["perks"] = 0;
        self.stats["headshots"] = 0;
        self.stats["zombie_gibs"] = 0;
        self.stats["damage_taken"] = 0;
        self.stats["distance_traveled"] = 0;
        self thread player_monitor_travel_dist();
        self thread player_grenade_watcher();
      }
    }
  }
}

spawn_life_brush(origin, radius, height) {
  life_brush = spawn("trigger_radius", origin, 0, radius, height);
  life_brush.script_noteworthy = "life_brush";
  return life_brush;
}

in_life_brush() {
  life_brushes = getEntArray("life_brush", "script_noteworthy");
  if(!isDefined(life_brushes)) {
    return false;
  }
  for(i = 0; i < life_brushes.size; i++) {
    if(self IsTouching(life_brushes[i])) {
      return true;
    }
  }
  return false;
}

spawn_kill_brush(origin, radius, height) {
  kill_brush = spawn("trigger_radius", origin, 0, radius, height);
  kill_brush.script_noteworthy = "kill_brush";
  return kill_brush;
}

in_kill_brush() {
  kill_brushes = getEntArray("kill_brush", "script_noteworthy");
  if(!isDefined(kill_brushes)) {
    return false;
  }
  for(i = 0; i < kill_brushes.size; i++) {
    if(self IsTouching(kill_brushes[i])) {
      return true;
    }
  }
  return false;
}

in_enabled_playable_area() {
  playable_area = getEntArray("player_volume", "script_noteworthy");
  if(!isDefined(playable_area)) {
    return false;
  }
  for(i = 0; i < playable_area.size; i++) {
    if(maps\_zombiemode_zone_manager::zone_is_enabled(playable_area[i].targetname) && self IsTouching(playable_area[i])) {
      return true;
    }
  }
  return false;
}

get_player_out_of_playable_area_monitor_wait_time() {
  return 3;
}

player_out_of_playable_area_monitor() {
  self notify("stop_player_out_of_playable_area_monitor");
  self endon("stop_player_out_of_playable_area_monitor");
  self endon("disconnect");
  level endon("end_game");
  wait((0.15 * self getEntityNumber()));
  while(true) {
    if(self.sessionstate == "spectator") {
      wait(get_player_out_of_playable_area_monitor_wait_time());
      continue;
    }
    if(!self in_life_brush() && (self in_kill_brush() || !self in_enabled_playable_area())) {
      if(!isDefined(level.player_out_of_playable_area_monitor_callback) || self[[level.player_out_of_playable_area_monitor_callback]]()) {
        if(is_true(level.player_4_vox_override)) {
          self playlocalsound("zmb_laugh_rich");
        } else {
          self playlocalsound("zmb_laugh_child");
        }
        wait(0.5);
        if(getplayers().size == 1 && flag("solo_game") && is_true(self.waiting_to_revive)) {
          level notify("end_game");
        } else {
          self.lives = 0;
          self dodamage(self.health + 1000, self.origin);
          self.bleedout_time = 0;
        }
      }
    }
    wait(get_player_out_of_playable_area_monitor_wait_time());
  }
}

get_player_too_many_weapons_monitor_wait_time() {
  return 3;
}

player_too_many_weapons_monitor_takeaway_simultaneous(primary_weapons_to_take) {
  self endon("player_too_many_weapons_monitor_takeaway_sequence_done");
  self waittill_any("player_downed", "replace_weapon_powerup");
  for(i = 0; i < primary_weapons_to_take.size; i++) {
    self TakeWeapon(primary_weapons_to_take[i]);
  }
  self maps\_zombiemode_score::minus_to_player_score(self.score);
  self GiveWeapon("m1911_zm");
  if(!self maps\_laststand::player_is_in_laststand()) {
    self decrement_is_drinking();
  } else if(flag("solo_game")) {
    self.score_lost_when_downed = 0;
  }
  self notify("player_too_many_weapons_monitor_takeaway_sequence_done");
}

player_too_many_weapons_monitor_takeaway_sequence(primary_weapons_to_take) {
  self thread player_too_many_weapons_monitor_takeaway_simultaneous(primary_weapons_to_take);
  self endon("player_downed");
  self endon("replace_weapon_powerup");
  self increment_is_drinking();
  score_decrement = round_up_to_ten(int(self.score / (primary_weapons_to_take.size + 1)));
  for(i = 0; i < primary_weapons_to_take.size; i++) {
    if(is_true(level.player_4_vox_override)) {
      self playlocalsound("zmb_laugh_rich");
    } else {
      self playlocalsound("zmb_laugh_child");
    }
    self SwitchToWeapon(primary_weapons_to_take[i]);
    self maps\_zombiemode_score::minus_to_player_score(score_decrement);
    wait(3);
    self TakeWeapon(primary_weapons_to_take[i]);
  }
  if(is_true(level.player_4_vox_override)) {
    self playlocalsound("zmb_laugh_rich");
  } else {
    self playlocalsound("zmb_laugh_child");
  }
  self maps\_zombiemode_score::minus_to_player_score(self.score);
  wait(1);
  self GiveWeapon("m1911_zm");
  self SwitchToWeapon("m1911_zm");
  self decrement_is_drinking();
  self notify("player_too_many_weapons_monitor_takeaway_sequence_done");
}

player_too_many_weapons_monitor() {
  self notify("stop_player_too_many_weapons_monitor");
  self endon("stop_player_too_many_weapons_monitor");
  self endon("disconnect");
  level endon("end_game");
  wait((0.15 * self getEntityNumber()));
  while(true) {
    if(self has_powerup_weapon() || self maps\_laststand::player_is_in_laststand() || self.sessionstate == "spectator") {
      wait(get_player_too_many_weapons_monitor_wait_time());
      continue;
    }
    primary_weapons_to_take = [];
    weapon_limit = 2;
    if(self HasPerk("specialty_additionalprimaryweapon")) {
      weapon_limit = 3;
    }
    primaryWeapons = self GetWeaponsListPrimaries();
    for(i = 0; i < primaryWeapons.size; i++) {
      if(maps\_zombiemode_weapons::is_weapon_included(primaryWeapons[i]) || maps\_zombiemode_weapons::is_weapon_upgraded(primaryWeapons[i])) {
        primary_weapons_to_take[primary_weapons_to_take.size] = primaryWeapons[i];
      }
    }
    if(primary_weapons_to_take.size > weapon_limit) {
      if(!isDefined(level.player_too_many_weapons_monitor_callback) || self[[level.player_too_many_weapons_monitor_callback]](primary_weapons_to_take)) {
        self thread player_too_many_weapons_monitor_takeaway_sequence(primary_weapons_to_take);
        self waittill("player_too_many_weapons_monitor_takeaway_sequence_done");
      }
    }
    wait(get_player_too_many_weapons_monitor_wait_time());
  }
}

player_monitor_travel_dist() {
  self endon("disconnect");
  prevpos = self.origin;
  while(1) {
    wait .1;
    self.stats["distance_traveled"] += distance(self.origin, prevpos);
    prevpos = self.origin;
  }
}

player_grenade_watcher() {
  self endon("disconnect");
  while(1) {
    self waittill("grenade_fire", grenade, weapName);
    if(isDefined(grenade) && isalive(grenade)) {
      grenade.team = self.team;
    }
  }
}

player_prevent_damage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  if(eInflictor == self || eAttacker == self) {
    return false;
  }
  if(isDefined(eInflictor) && isDefined(eInflictor.team)) {
    if(eInflictor.team == self.team) {
      return true;
    }
  }
  return false;
}

player_revive_monitor() {
  self endon("disconnect");
  while(1) {
    self waittill("player_revived", reviver);
    bbPrint("zombie_playerdeaths: round %d playername %s deathtype revived x %f y %f z %f", level.round_number, self.playername, self.origin);
    if(isDefined(reviver)) {
      self maps\_zombiemode_audio::create_and_play_dialog("general", "revive_up");
      points = self.score_lost_when_downed;
      reviver maps\_zombiemode_score::player_add_points("reviver", points);
      self.score_lost_when_downed = 0;
    }
  }
}

laststand_giveback_player_perks() {
  if(isDefined(self.laststand_perks)) {
    lost_perk_index = int(-1);
    if(self.laststand_perks.size > 1) {
      lost_perk_index = randomInt(self.laststand_perks.size - 1);
    }
    for(i = 0; i < self.laststand_perks.size; i++) {
      if(self HasPerk(self.laststand_perks[i])) {
        continue;
      }
      if(i == lost_perk_index) {
        continue;
      }
      maps\_zombiemode_perks::give_perk(self.laststand_perks[i]);
    }
  }
}

remote_revive_watch() {
  self endon("death");
  self endon("player_revived");
  self waittill("remote_revive", reviver);
  self maps\_laststand::remote_revive(reviver);
}

remove_deadshot_bottle() {
  wait(0.05);
  if(isDefined(self.lastActiveWeapon) && self.lastActiveWeapon == "zombie_perk_bottle_deadshot") {
    self.lastActiveWeapon = "none";
  }
}

take_additionalprimaryweapon() {
  weapon_to_take = undefined;
  if(is_true(self._retain_perks)) {
    return weapon_to_take;
  }
  primary_weapons_that_can_be_taken = [];
  primaryWeapons = self GetWeaponsListPrimaries();
  for(i = 0; i < primaryWeapons.size; i++) {
    if(maps\_zombiemode_weapons::is_weapon_included(primaryWeapons[i]) || maps\_zombiemode_weapons::is_weapon_upgraded(primaryWeapons[i])) {
      primary_weapons_that_can_be_taken[primary_weapons_that_can_be_taken.size] = primaryWeapons[i];
    }
  }
  if(primary_weapons_that_can_be_taken.size >= 3) {
    weapon_to_take = primary_weapons_that_can_be_taken[primary_weapons_that_can_be_taken.size - 1];
    if(weapon_to_take == self GetCurrentWeapon()) {
      self SwitchToWeapon(primary_weapons_that_can_be_taken[0]);
    }
    self TakeWeapon(weapon_to_take);
  }
  return weapon_to_take;
}

player_laststand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  if(self HasPerk("specialty_additionalprimaryweapon")) {
    self.weapon_taken_by_losing_specialty_additionalprimaryweapon = self take_additionalprimaryweapon();
  }
  self clear_is_drinking();
  self thread remove_deadshot_bottle();
  self thread remote_revive_watch();
  self maps\_zombiemode_score::player_downed_penalty();
  self DisableOffhandWeapons();
  self thread last_stand_grenade_save_and_return();
  if(sMeansOfDeath != "MOD_SUICIDE" && sMeansOfDeath != "MOD_FALLING") {
    self maps\_zombiemode_audio::create_and_play_dialog("general", "revive_down");
  }
  bbPrint("zombie_playerdeaths: round %d playername %s deathtype downed x %f y %f z %f", level.round_number, self.playername, self.origin);
  if(isDefined(level._zombie_minigun_powerup_last_stand_func)) {
    self thread[[level._zombie_minigun_powerup_last_stand_func]]();
  }
  if(isDefined(level._zombie_tesla_powerup_last_stand_func)) {
    self thread[[level._zombie_tesla_powerup_last_stand_func]]();
  }
  if(isDefined(self.intermission) && self.intermission) {
    bbPrint("zombie_playerdeaths: round %d playername %s deathtype died x %f y %f z %f", level.round_number, self.playername, self.origin);
    level waittill("forever");
  }
}

failsafe_revive_give_back_weapons() {
  for(i = 0; i < 10; i++) {
    wait(0.05);
    if(!isDefined(self.reviveProgressBar)) {
      continue;
    }
    players = get_players();
    for(playerIndex = 0; playerIndex < players.size; playerIndex++) {
      revivee = players[playerIndex];
      if(self maps\_laststand::is_reviving(revivee)) {
        continue;
      }
    }
    self maps\_laststand::revive_give_back_weapons("none");
    if(isDefined(self.reviveProgressBar)) {
      self.reviveProgressBar maps\_hud_util::destroyElem();
    }
    if(isDefined(self.reviveTextHud)) {
      self.reviveTextHud destroy();
    }
    return;
  }
}

spawnSpectator() {
  self endon("disconnect");
  self endon("spawned_spectator");
  self notify("spawned");
  self notify("end_respawn");
  if(level.intermission) {
    return;
  }
  if(isDefined(level.no_spectator) && level.no_spectator) {
    wait(3);
    ExitLevel();
  }
  self.is_zombie = true;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(self != players[i]) {
      players[i] thread failsafe_revive_give_back_weapons();
    }
  }
  self notify("zombified");
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
    self.revivetrigger = undefined;
  }
  self.zombification_time = GetTime();
  resetTimeout();
  self StopShellshock();
  self stopRumble("damage_heavy");
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self remove_from_spectate_list();
  self.maxhealth = self.health;
  self.shellshocked = false;
  self.inWater = false;
  self.friendlydamage = undefined;
  self.hasSpawned = true;
  self.spawnTime = GetTime();
  self.afk = false;
  println("**Zombie Spectator**");
  self detachAll();
  self setSpectatePermissions(true);
  self thread spectator_thread();
  self spawn(self.origin, self.angles);
  self notify("spawned_spectator");
}

setSpectatePermissions(isOn) {
  self AllowSpectateTeam("allies", isOn);
  self AllowSpectateTeam("axis", false);
  self AllowSpectateTeam("freelook", false);
  self AllowSpectateTeam("none", false);
}

spectator_thread() {
  self endon("disconnect");
  self endon("spawned_player");
}

spectator_toggle_3rd_person() {
  self endon("disconnect");
  self endon("spawned_player");
  third_person = true;
  self set_third_person(true);
}

set_third_person(value) {
  if(value) {
    self SetClientDvars("cg_thirdPerson", "1",
      "cg_fov", "40",
      "cg_thirdPersonAngle", "354");
    self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
  } else {
    self SetClientDvars("cg_thirdPerson", "0",
      "cg_fov", "65",
      "cg_thirdPersonAngle", "0");
    self setDepthOfField(0, 0, 512, 4000, 4, 0);
  }
}

last_stand_revive() {
  level endon("between_round_over");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] maps\_laststand::player_is_in_laststand() && players[i].revivetrigger.beingRevived == 0) {
      players[i] maps\_laststand::auto_revive();
    }
  }
}

last_stand_pistol_rank_init() {
  level.pistol_values = [];
  flag_wait("_start_zm_pistol_rank");
  if(flag("solo_game")) {
    level.pistol_values[level.pistol_values.size] = "m1911_zm";
    level.pistol_values[level.pistol_values.size] = "cz75_zm";
    level.pistol_values[level.pistol_values.size] = "cz75dw_zm";
    level.pistol_values[level.pistol_values.size] = "python_zm";
    level.pistol_values[level.pistol_values.size] = "python_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "cz75_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "cz75dw_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "m1911_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "ray_gun_zm";
    level.pistol_values[level.pistol_values.size] = "freezegun_zm";
    level.pistol_values[level.pistol_values.size] = "ray_gun_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "freezegun_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "microwavegundw_zm";
    level.pistol_values[level.pistol_values.size] = "microwavegundw_upgraded_zm";
  } else {
    level.pistol_values[level.pistol_values.size] = "m1911_zm";
    level.pistol_values[level.pistol_values.size] = "cz75_zm";
    level.pistol_values[level.pistol_values.size] = "cz75dw_zm";
    level.pistol_values[level.pistol_values.size] = "python_zm";
    level.pistol_values[level.pistol_values.size] = "python_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "cz75_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "cz75dw_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "m1911_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "ray_gun_zm";
    level.pistol_values[level.pistol_values.size] = "freezegun_zm";
    level.pistol_values[level.pistol_values.size] = "ray_gun_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "freezegun_upgraded_zm";
    level.pistol_values[level.pistol_values.size] = "microwavegundw_zm";
    level.pistol_values[level.pistol_values.size] = "microwavegundw_upgraded_zm";
  }
}

last_stand_pistol_swap() {
  if(self has_powerup_weapon()) {
    self.lastActiveWeapon = "none";
  }
  if(!self hasWeapon(self.laststandpistol)) {
    self GiveWeapon(self.laststandpistol);
  }
  ammoclip = WeaponClipSize(self.laststandpistol);
  doubleclip = ammoclip * 2;
  if(is_true(self._special_solo_pistol_swap) || (self.laststandpistol == "m1911_upgraded_zm" && !self.hadpistol)) {
    self._special_solo_pistol_swap = 0;
    self.hadpistol = false;
    self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
  } else if(flag("solo_game") && self.laststandpistol == "m1911_upgraded_zm") {
    self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
  } else if(self.laststandpistol == "m1911_zm") {
    self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
  } else if(self.laststandpistol == "ray_gun_zm" || self.laststandpistol == "ray_gun_upgraded_zm") {
    if(self.stored_weapon_info[self.laststandpistol].total_amt >= ammoclip) {
      self SetWeaponAmmoClip(self.laststandpistol, ammoclip);
      self.stored_weapon_info[self.laststandpistol].given_amt = ammoclip;
    } else {
      self SetWeaponAmmoClip(self.laststandpistol, self.stored_weapon_info[self.laststandpistol].total_amt);
      self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
    }
    self SetWeaponAmmoStock(self.laststandpistol, 0);
  } else {
    if(self.stored_weapon_info[self.laststandpistol].stock_amt >= doubleclip) {
      self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
      self.stored_weapon_info[self.laststandpistol].given_amt = doubleclip + self.stored_weapon_info[self.laststandpistol].clip_amt + self.stored_weapon_info[self.laststandpistol].left_clip_amt;
    } else {
      self SetWeaponAmmoStock(self.laststandpistol, self.stored_weapon_info[self.laststandpistol].stock_amt);
      self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
    }
  }
  self SwitchToWeapon(self.laststandpistol);
}

last_stand_best_pistol() {
  pistol_array = [];
  current_weapons = self GetWeaponsListPrimaries();
  for(i = 0; i < current_weapons.size; i++) {
    if(WeaponClass(current_weapons[i]) == "pistol") {
      if((current_weapons[i] != "m1911_zm" && !flag("solo_game")) || (!flag("solo_game") && current_weapons[i] != "m1911_upgraded_zm")) {
        if(self GetAmmoCount(current_weapons[i]) <= 0) {
          continue;
        }
      }
      pistol_array_index = pistol_array.size;
      pistol_array[pistol_array_index] = spawnStruct();
      pistol_array[pistol_array_index].gun = current_weapons[i];
      pistol_array[pistol_array_index].value = 0;
      for(j = 0; j < level.pistol_values.size; j++) {
        if(level.pistol_values[j] == current_weapons[i]) {
          pistol_array[pistol_array_index].value = j;
          break;
        }
      }
    }
  }
  self.laststandpistol = last_stand_compare_pistols(pistol_array);
}

last_stand_compare_pistols(struct_array) {
  if(!IsArray(struct_array) || struct_array.size <= 0) {
    self.hadpistol = false;
    if(isDefined(self.stored_weapon_info)) {
      stored_weapon_info = GetArrayKeys(self.stored_weapon_info);
      for(j = 0; j < stored_weapon_info.size; j++) {
        if(stored_weapon_info[j] == level.laststandpistol) {
          self.hadpistol = true;
        }
      }
    }
    return level.laststandpistol;
  }
  highest_score_pistol = struct_array[0];
  for(i = 1; i < struct_array.size; i++) {
    if(struct_array[i].value > highest_score_pistol.value) {
      highest_score_pistol = struct_array[i];
    }
  }
  if(flag("solo_game")) {
    self._special_solo_pistol_swap = 0;
    if(highest_score_pistol.value <= 4) {
      self.hadpistol = false;
      self._special_solo_pistol_swap = 1;
      return level.laststandpistol;
    } else {
      return highest_score_pistol.gun;
    }
  } else {
    return highest_score_pistol.gun;
  }
}

last_stand_save_pistol_ammo() {
  weapon_inventory = self GetWeaponsList();
  self.stored_weapon_info = [];
  for(i = 0; i < weapon_inventory.size; i++) {
    weapon = weapon_inventory[i];
    if(WeaponClass(weapon) == "pistol") {
      self.stored_weapon_info[weapon] = spawnStruct();
      self.stored_weapon_info[weapon].clip_amt = self GetWeaponAmmoClip(weapon);
      self.stored_weapon_info[weapon].left_clip_amt = 0;
      dual_wield_name = WeaponDualWieldWeaponName(weapon);
      if("none" != dual_wield_name) {
        self.stored_weapon_info[weapon].left_clip_amt = self GetWeaponAmmoClip(dual_wield_name);
      }
      self.stored_weapon_info[weapon].stock_amt = self GetWeaponAmmoStock(weapon);
      self.stored_weapon_info[weapon].total_amt = self.stored_weapon_info[weapon].clip_amt + self.stored_weapon_info[weapon].left_clip_amt + self.stored_weapon_info[weapon].stock_amt;
      self.stored_weapon_info[weapon].given_amt = 0;
    }
  }
  self last_stand_best_pistol();
}

last_stand_restore_pistol_ammo() {
  self.weapon_taken_by_losing_specialty_additionalprimaryweapon = undefined;
  if(!isDefined(self.stored_weapon_info)) {
    return;
  }
  weapon_inventory = self GetWeaponsList();
  weapon_to_restore = GetArrayKeys(self.stored_weapon_info);
  for(i = 0; i < weapon_inventory.size; i++) {
    weapon = weapon_inventory[i];
    if(weapon != self.laststandpistol) {
      continue;
    }
    for(j = 0; j < weapon_to_restore.size; j++) {
      check_weapon = weapon_to_restore[j];
      if(weapon == check_weapon) {
        dual_wield_name = WeaponDualWieldWeaponName(weapon_to_restore[j]);
        if(weapon != "m1911_zm") {
          last_clip = self GetWeaponAmmoClip(weapon);
          last_left_clip = 0;
          if("none" != dual_wield_name) {
            last_left_clip = self GetWeaponAmmoClip(dual_wield_name);
          }
          last_stock = self GetWeaponAmmoStock(weapon);
          last_total = last_clip + last_left_clip + last_stock;
          used_amt = self.stored_weapon_info[weapon].given_amt - last_total;
          if(used_amt >= self.stored_weapon_info[weapon].stock_amt) {
            used_amt -= self.stored_weapon_info[weapon].stock_amt;
            self.stored_weapon_info[weapon].stock_amt = 0;
            self.stored_weapon_info[weapon].clip_amt -= used_amt;
            if(self.stored_weapon_info[weapon].clip_amt < 0) {
              self.stored_weapon_info[weapon].clip_amt = 0;
            }
          } else {
            new_stock_amt = self.stored_weapon_info[weapon].stock_amt - used_amt;
            if(new_stock_amt < self.stored_weapon_info[weapon].stock_amt) {
              self.stored_weapon_info[weapon].stock_amt = new_stock_amt;
            }
          }
        }
        self SetWeaponAmmoClip(weapon_to_restore[j], self.stored_weapon_info[weapon_to_restore[j]].clip_amt);
        if("none" != dual_wield_name) {
          self SetWeaponAmmoClip(dual_wield_name, self.stored_weapon_info[weapon_to_restore[j]].left_clip_amt);
        }
        self SetWeaponAmmoStock(weapon_to_restore[j], self.stored_weapon_info[weapon_to_restore[j]].stock_amt);
        break;
      }
    }
  }
}

zombiemode_solo_last_stand_pistol() {
  level.laststandpistol = "m1911_upgraded_zm";
}

last_stand_grenade_save_and_return() {
  self endon("death");
  lethal_nade_amt = 0;
  has_lethal_nade = false;
  tactical_nade_amt = 0;
  has_tactical_nade = false;
  weapons_on_player = self GetWeaponsList();
  for(i = 0; i < weapons_on_player.size; i++) {
    if(self is_player_lethal_grenade(weapons_on_player[i])) {
      has_lethal_nade = true;
      lethal_nade_amt = self GetWeaponAmmoClip(self get_player_lethal_grenade());
      self SetWeaponAmmoClip(self get_player_lethal_grenade(), 0);
      self TakeWeapon(self get_player_lethal_grenade());
    } else if(self is_player_tactical_grenade(weapons_on_player[i])) {
      has_tactical_nade = true;
      tactical_nade_amt = self GetWeaponAmmoClip(self get_player_tactical_grenade());
      self SetWeaponAmmoClip(self get_player_tactical_grenade(), 0);
      self TakeWeapon(self get_player_tactical_grenade());
    }
  }
  self waittill("player_revived");
  if(has_lethal_nade) {
    self GiveWeapon(self get_player_lethal_grenade());
    self SetWeaponAmmoClip(self get_player_lethal_grenade(), lethal_nade_amt);
  }
  if(has_tactical_nade) {
    self GiveWeapon(self get_player_tactical_grenade());
    self SetWeaponAmmoClip(self get_player_tactical_grenade(), tactical_nade_amt);
  }
}

spectators_respawn() {
  level endon("between_round_over");
  if(!isDefined(level.zombie_vars["spectators_respawn"]) || !level.zombie_vars["spectators_respawn"]) {
    return;
  }
  if(!isDefined(level.custom_spawnPlayer)) {
    level.custom_spawnPlayer = ::spectator_respawn;
  }
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate == "spectator") {
        players[i][
          [level.spawnPlayer]
        ]();
        if(isDefined(level.script) && level.round_number > 6 && players[i].score < 1500) {
          players[i].old_score = players[i].score;
          players[i].score = 1500;
          players[i] maps\_zombiemode_score::set_player_score_hud();
        }
      }
    }
    wait(1);
  }
}

spectator_respawn() {
  println("**Respawn Spectator**");
  assert(isDefined(self.spectator_respawn));
  origin = self.spectator_respawn.origin;
  angles = self.spectator_respawn.angles;
  self setSpectatePermissions(false);
  new_origin = undefined;
  if(isDefined(level.check_valid_spawn_override)) {
    new_origin = [[level.check_valid_spawn_override]](self);
  }
  if(!isDefined(new_origin)) {
    new_origin = check_for_valid_spawn_near_team(self);
  }
  if(isDefined(new_origin)) {
    self spawn(new_origin, angles);
  } else {
    self spawn(origin, angles);
  }
  if(isDefined(self get_player_placeable_mine())) {
    self TakeWeapon(self get_player_placeable_mine());
    self set_player_placeable_mine(undefined);
  }
  self maps\_zombiemode_equipment::equipment_take();
  self.is_burning = undefined;
  self.abilities = [];
  self.is_zombie = false;
  self.ignoreme = false;
  setClientSysState("lsm", "0", self);
  self RevivePlayer();
  self notify("spawned_player");
  if(isDefined(level._zombiemode_post_respawn_callback)) {
    self thread[[level._zombiemode_post_respawn_callback]]();
  }
  self maps\_zombiemode_score::player_reduce_points("died");
  bowie_triggers = getEntArray("bowie_upgrade", "targetname");
  self._bowie_zm_equipped = undefined;
  players = get_players();
  for(i = 0; i < bowie_triggers.size; i++) {
    bowie_triggers[i] SetVisibleToAll();
    for(j = 0; j < players.size; j++) {
      if(isDefined(players[j]._bowie_zm_equipped) && players[j]._bowie_zm_equipped == 1) {
        bowie_triggers[i] SetInvisibleToPlayer(players[j]);
      }
    }
  }
  sickle_triggers = getEntArray("sickle_upgrade", "targetname");
  self._sickle_zm_equipped = undefined;
  players = get_players();
  for(i = 0; i < sickle_triggers.size; i++) {
    sickle_triggers[i] SetVisibleToAll();
    for(j = 0; j < players.size; j++) {
      if(isDefined(players[j]._sickle_zm_equipped) && players[j]._sickle_zm_equipped == 1) {
        sickle_triggers[i] SetInvisibleToPlayer(players[j]);
      }
    }
  }
  claymore_triggers = getEntArray("claymore_purchase", "targetname");
  for(i = 0; i < claymore_triggers.size; i++) {
    claymore_triggers[i] SetVisibleToPlayer(self);
    claymore_triggers[i].claymores_triggered = false;
  }
  self thread player_zombie_breadcrumb();
  return true;
}

check_for_valid_spawn_near_team(revivee) {
  players = get_players();
  spawn_points = getstructarray("player_respawn_point", "targetname");
  closest_group = undefined;
  closest_distance = 100000000;
  backup_group = undefined;
  backup_distance = 100000000;
  if(spawn_points.size == 0)
    return undefined;
  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i])) {
      for(j = 0; j < spawn_points.size; j++) {
        if(isDefined(spawn_points[i].script_int))
          ideal_distance = spawn_points[i].script_int;
        else
          ideal_distance = 1000;
        if(spawn_points[j].locked == false) {
          distance = distanceSquared(players[i].origin, spawn_points[j].origin);
          if(distance < (ideal_distance * ideal_distance)) {
            if(distance < closest_distance) {
              closest_distance = distance;
              closest_group = j;
            }
          } else {
            if(distance < backup_distance) {
              backup_group = j;
              backup_distance = distance;
            }
          }
        }
      }
    }
    if(!isDefined(closest_group)) {
      closest_group = backup_group;
    }
    if(isDefined(closest_group)) {
      spawn_array = getstructarray(spawn_points[closest_group].target, "targetname");
      for(k = 0; k < spawn_array.size; k++) {
        if(spawn_array[k].script_int == (revivee.entity_num + 1)) {
          return spawn_array[k].origin;
        }
      }
      return spawn_array[0].origin;
    }
  }
  return undefined;
}

get_players_on_team(exclude) {
  teammates = [];
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i].spawn_side == self.spawn_side && !isDefined(players[i].revivetrigger) && players[i] != exclude) {
      teammates[teammates.size] = players[i];
    }
  }
  return teammates;
}

get_safe_breadcrumb_pos(player) {
  players = get_players();
  valid_players = [];
  min_dist = 150 * 150;
  for(i = 0; i < players.size; i++) {
    if(!is_player_valid(players[i])) {
      continue;
    }
    valid_players[valid_players.size] = players[i];
  }
  for(i = 0; i < valid_players.size; i++) {
    count = 0;
    for(q = 1; q < player.zombie_breadcrumbs.size; q++) {
      if(distanceSquared(player.zombie_breadcrumbs[q], valid_players[i].origin) < min_dist) {
        continue;
      }
      count++;
      if(count == valid_players.size) {
        return player.zombie_breadcrumbs[q];
      }
    }
  }
  return undefined;
}

default_max_zombie_func(max_num) {
  max = max_num;
  if(level.first_round) {
    max = int(max_num * 0.25);
  } else if(level.round_number < 3) {
    max = int(max_num * 0.3);
  } else if(level.round_number < 4) {
    max = int(max_num * 0.5);
  } else if(level.round_number < 5) {
    max = int(max_num * 0.7);
  } else if(level.round_number < 6) {
    max = int(max_num * 0.9);
  }
  return max;
}

round_spawning() {
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  if(level.intermission) {
    return;
  }
  if(level.enemy_spawns.size < 1) {
    ASSERTMSG("No active spawners in the map.Check to see if the zone is active and if it's pointing to spawners.");
    return;
  }
  ai_calculate_health(level.round_number);
  count = 0;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].zombification_time = 0;
  }
  max = level.zombie_vars["zombie_max_ai"];
  multiplier = level.round_number / 5;
  if(multiplier < 1) {
    multiplier = 1;
  }
  if(level.round_number >= 10) {
    multiplier *= level.round_number * 0.15;
  }
  player_num = get_players().size;
  if(player_num == 1) {
    max += int((0.5 * level.zombie_vars["zombie_ai_per_player"]) * multiplier);
  } else {
    max += int(((player_num - 1) * level.zombie_vars["zombie_ai_per_player"]) * multiplier);
  }
  if(!isDefined(level.max_zombie_func)) {
    level.max_zombie_func = ::default_max_zombie_func;
  }
  if(!(isDefined(level.kill_counter_hud) && level.zombie_total > 0)) {
    level.zombie_total = [[level.max_zombie_func]](max);
  }
  if(isDefined(level.zombie_total_set_func)) {
    level thread[[level.zombie_total_set_func]]();
  }
  if(level.round_number < 10) {
    level thread zombie_speed_up();
  }
  mixed_spawns = 0;
  old_spawn = undefined;
  while(1) {
    while(get_enemy_count() >= level.zombie_ai_limit || level.zombie_total <= 0) {
      wait(0.1);
    }
    if(!flag("spawn_zombies")) {
      flag_wait("spawn_zombies");
    }
    spawn_point = level.enemy_spawns[randomInt(level.enemy_spawns.size)];
    if(!isDefined(old_spawn)) {
      old_spawn = spawn_point;
    } else if(Spawn_point == old_spawn) {
      spawn_point = level.enemy_spawns[randomInt(level.enemy_spawns.size)];
    }
    old_spawn = spawn_point;
    if(isDefined(level.mixed_rounds_enabled) && level.mixed_rounds_enabled == 1) {
      spawn_dog = false;
      if(level.round_number > 30) {
        if(randomInt(100) < 3) {
          spawn_dog = true;
        }
      } else if(level.round_number > 25 && mixed_spawns < 3) {
        if(randomInt(100) < 2) {
          spawn_dog = true;
        }
      } else if(level.round_number > 20 && mixed_spawns < 2) {
        if(randomInt(100) < 2) {
          spawn_dog = true;
        }
      } else if(level.round_number > 15 && mixed_spawns < 1) {
        if(randomInt(100) < 1) {
          spawn_dog = true;
        }
      }
      if(spawn_dog) {
        keys = GetArrayKeys(level.zones);
        for(i = 0; i < keys.size; i++) {
          if(level.zones[keys[i]].is_occupied) {
            akeys = GetArrayKeys(level.zones[keys[i]].adjacent_zones);
            for(k = 0; k < akeys.size; k++) {
              if(level.zones[akeys[k]].is_active &&
                !level.zones[akeys[k]].is_occupied &&
                level.zones[akeys[k]].dog_locations.size > 0) {
                maps\_zombiemode_ai_dogs::special_dog_spawn(undefined, 1);
                level.zombie_total--;
                wait_network_frame();
              }
            }
          }
        }
      }
    }
    ai = spawn_zombie(spawn_point);
    if(isDefined(ai)) {
      level.zombie_total--;
      ai thread round_spawn_failsafe();
      count++;
    }
    wait(level.zombie_vars["zombie_spawn_delay"]);
    wait_network_frame();
  }
}

zombie_speed_up() {
  if(level.round_number <= 3) {
    return;
  }
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  while(level.zombie_total > 4) {
    wait(2.0);
  }
  num_zombies = get_enemy_count();
  while(num_zombies > 3) {
    wait(2.0);
    num_zombies = get_enemy_count();
  }
  zombies = GetAiSpeciesArray("axis", "all");
  while(zombies.size > 0) {
    if(zombies.size == 1 && zombies[0].has_legs == true) {
      if(isDefined(level.zombie_speed_up)) {
        zombies[0] thread[[level.zombie_speed_up]]();
        break;
      } else {
        var = randomintrange(1, 4);
        zombies[0] set_run_anim("sprint" +
          var);
        zombies[0].run_combatanim = level.scr_anim[zombies[0].animname]["sprint" +
          var
        ];
      }
    }
    wait(0.5);
    zombies = GetAiSpeciesArray("axis", "all");
  }
}

round_spawning_test() {
  while(true) {
    spawn_point = level.enemy_spawns[randomInt(level.enemy_spawns.size)];
    ai = spawn_zombie(spawn_point);
    ai waittill("death");
    wait 5;
  }
}

round_pause(delay) {
  if(!isDefined(delay)) {
    delay = 30;
  }
  level.countdown_hud = create_counter_hud();
  level.countdown_hud SetValue(delay);
  level.countdown_hud.color = (1, 1, 1);
  level.countdown_hud.alpha = 1;
  level.countdown_hud FadeOverTime(2.0);
  wait(2.0);
  level.countdown_hud.color = (0.21, 0, 0);
  level.countdown_hud FadeOverTime(3.0);
  wait(3);
  while(delay >= 1) {
    wait(1);
    delay--;
    level.countdown_hud SetValue(delay);
  }
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] playlocalsound("zmb_perks_packa_ready");
  }
  level.countdown_hud FadeOverTime(1.0);
  level.countdown_hud.color = (1, 1, 1);
  level.countdown_hud.alpha = 0;
  wait(1.0);
  level.countdown_hud destroy_hud();
}

round_start() {
  if(isDefined(level.round_prestart_func)) {
    [[level.round_prestart_func]]();
  } else {
    wait(2);
  }
  level.zombie_health = level.zombie_vars["zombie_health_start"];
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] giveweapon(players[i] get_player_lethal_grenade());
    players[i] setweaponammoclip(players[i] get_player_lethal_grenade(), 0);
    players[i] SetClientDvars("ammoCounterHide", "0",
      "miniscoreboardhide", "0");
  }
  if(getDvarInt(#"scr_writeconfigstrings") == 1) {
    wait(5);
    ExitLevel();
    return;
  }
  if(level.zombie_vars["game_start_delay"] > 0) {
    round_pause(level.zombie_vars["game_start_delay"]);
  }
  flag_set("begin_spawning");
  level.chalk_hud1 = create_chalk_hud();
  level.chalk_hud2 = create_chalk_hud(64);
  if(!isDefined(level.round_spawn_func)) {
    level.round_spawn_func = ::round_spawning;
  }
  if(!isDefined(level.round_wait_func)) {
    level.round_wait_func = ::round_wait;
  }
  if(!isDefined(level.round_think_func)) {
    level.round_think_func = ::round_think;
  }
  if(level.mutators["mutator_fogMatch"]) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      players[i] thread set_fog(729.34, 971.99, 338.336, 398.623, 0.58, 0.60, 0.56, 3);
    }
  }
  level thread[[level.round_think_func]]();
}

create_chalk_hud(x) {
  if(!isDefined(x)) {
    x = 0;
  }
  hud = create_simple_hud();
  hud.alignX = "left";
  hud.alignY = "bottom";
  hud.horzAlign = "user_left";
  hud.vertAlign = "user_bottom";
  hud.color = (0.21, 0, 0);
  hud.x = x;
  hud.y = -4;
  hud.alpha = 0;
  hud.fontscale = 32.0;
  hud SetShader("hud_chalk_1", 64, 64);
  return hud;
}

destroy_chalk_hud() {
  if(isDefined(level.chalk_hud1)) {
    level.chalk_hud1 Destroy();
    level.chalk_hud1 = undefined;
  }
  if(isDefined(level.chalk_hud2)) {
    level.chalk_hud2 Destroy();
    level.chalk_hud2 = undefined;
  }
}

play_door_dialog() {
  level endon("power_on");
  self endon("warning_dialog");
  timer = 0;
  while(1) {
    wait(0.05);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 70 * 70) {
        timer = 0;
        continue;
      }
      while(dist < 70 * 70 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist > 70 * 70 && timer >= 3) {
        self playSound("door_deny");
        players[i] maps\_zombiemode_audio::create_and_play_dialog("general", "door_deny");
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

wait_until_first_player() {
  players = get_players();
  if(!isDefined(players[0])) {
    level waittill("first_player_ready");
  }
}

chalk_one_up() {
  huds = [];
  huds[0] = level.chalk_hud1;
  huds[1] = level.chalk_hud2;
  if(level.round_number >= 1 && level.round_number <= 5) {
    huds[0] SetShader("hud_chalk_" + level.round_number, 64, 64);
  } else if(level.round_number >= 5 && level.round_number <= 10) {
    huds[0] SetShader("hud_chalk_5", 64, 64);
  }
  if(level.round_number > 5 && level.round_number <= 10) {
    huds[1] SetShader("hud_chalk_" + (level.round_number - 5), 64, 64);
  }
  if(isDefined(level.chalk_override)) {
    huds[0] SetText(level.chalk_override);
    huds[1] SetText(" ");
  } else if(level.round_number <= 5) {
    huds[1] SetText(" ");
  } else if(level.round_number > 10) {
    huds[0].fontscale = 32;
    huds[0] SetValue(level.round_number);
    huds[1] SetText(" ");
  }
  if(!isDefined(level.doground_nomusic)) {
    level.doground_nomusic = 0;
  }
  if(level.first_round) {
    intro = true;
    if(isDefined(level._custom_intro_vox)) {
      level thread[[level._custom_intro_vox]]();
    } else {
      level thread play_level_start_vox_delayed();
    }
  } else {
    intro = false;
  }
  if(level.round_number == 5 || level.round_number == 10 || level.round_number == 20 || level.round_number == 35 || level.round_number == 50) {
    players = getplayers();
    rand = RandomIntRange(0, players.size);
    players[rand] thread maps\_zombiemode_audio::create_and_play_dialog("general", "round_" + level.round_number);
  }
  round = undefined;
  if(intro) {
    round = create_simple_hud();
    round.alignX = "center";
    round.alignY = "bottom";
    round.horzAlign = "user_center";
    round.vertAlign = "user_bottom";
    round.fontscale = 16;
    round.color = (1, 1, 1);
    round.x = 0;
    round.y = -265;
    round.alpha = 0;
    round SetText(&"ZOMBIE_ROUND");
    huds[0].color = (1, 1, 1);
    huds[0].alpha = 0;
    huds[0].horzAlign = "user_center";
    huds[0].x = -5;
    huds[0].y = -200;
    huds[1] SetText(" ");
    round FadeOverTime(1);
    round.alpha = 1;
    huds[0] FadeOverTime(1);
    huds[0].alpha = 1;
    wait(1);
    round FadeOverTime(2);
    round.color = (0.21, 0, 0);
    huds[0] FadeOverTime(2);
    huds[0].color = (0.21, 0, 0);
    wait(2);
  } else {
    for(i = 0; i < huds.size; i++) {
      huds[i] FadeOverTime(0.5);
      huds[i].alpha = 0;
    }
    wait(0.5);
  }
  for(i = 0; i < huds.size; i++) {
    huds[i] FadeOverTime(2);
    huds[i].alpha = 1;
  }
  if(intro) {
    wait(3);
    if(isDefined(round)) {
      round FadeOverTime(1);
      round.alpha = 0;
    }
    wait(0.25);
    level notify("intro_hud_done");
    huds[0] MoveOverTime(1.75);
    huds[0].horzAlign = "user_left";
    huds[0].y = -4;
    wait(2);
    round destroy_hud();
  } else {
    for(i = 0; i < huds.size; i++) {
      huds[i].color = (1, 1, 1);
    }
  }
  if(!intro) {
    wait(2);
    for(i = 0; i < huds.size; i++) {
      huds[i] FadeOverTime(1);
      huds[i].color = (0.21, 0, 0);
    }
  }
  ReportMTU(level.round_number);
  if(isDefined(level.chalk_override)) {
    level.chalk_override = undefined;
  }
}

chalk_round_over() {
  huds = [];
  huds[huds.size] = level.chalk_hud1;
  huds[huds.size] = level.chalk_hud2;
  if(level.round_number <= 5 || level.round_number > 10) {
    level.chalk_hud2 SetText(" ");
  }
  time = level.zombie_vars["zombie_between_round_time"];
  if(time > 3) {
    time = time - 2;
  }
  for(i = 0; i < huds.size; i++) {
    if(isDefined(huds[i])) {
      huds[i] FadeOverTime(time * 0.25);
      huds[i].color = (1, 1, 1);
    }
  }
  fade_time = 0.5;
  steps = (time * 0.5) / fade_time;
  for(q = 0; q < steps; q++) {
    for(i = 0; i < huds.size; i++) {
      if(!isDefined(huds[i])) {
        continue;
      }
      huds[i] FadeOverTime(fade_time);
      huds[i].alpha = 0;
    }
    wait(fade_time);
    for(i = 0; i < huds.size; i++) {
      if(!isDefined(huds[i])) {
        continue;
      }
      huds[i] FadeOverTime(fade_time);
      huds[i].alpha = 1;
    }
    wait(fade_time);
  }
  for(i = 0; i < huds.size; i++) {
    if(!isDefined(huds[i])) {
      continue;
    }
    huds[i] FadeOverTime(time * 0.25);
    huds[i].color = (0.21, 0, 0);
    huds[i].alpha = 0;
  }
  wait(2.0);
}

round_think() {
  for(;;) {
    maxreward = 50 * level.round_number;
    if(maxreward > 500)
      maxreward = 500;
    level.zombie_vars["rebuild_barrier_cap_per_round"] = maxreward;
    level.pro_tips_start_time = GetTime();
    level.zombie_last_run_time = GetTime();
    level thread maps\_zombiemode_audio::change_zombie_music("round_start");
    chalk_one_up();
    maps\_zombiemode_powerups::powerup_round_start();
    players = get_players();
    array_thread(players, maps\_zombiemode_blockers::rebuild_barrier_reward_reset);
    level thread award_grenades_for_survivors();
    bbPrint("zombie_rounds: round %d player_count %d", level.round_number, players.size);
    level.round_start_time = GetTime();
    level thread[[level.round_spawn_func]]();
    level notify("start_of_round");
    [[level.round_wait_func]]();
    level.first_round = false;
    level notify("end_of_round");
    level thread maps\_zombiemode_audio::change_zombie_music("round_end");
    UploadStats();
    if(1 != players.size) {
      level thread spectators_respawn();
    }
    level chalk_round_over();
    timer = level.zombie_vars["zombie_spawn_delay"];
    if(timer > 0.08) {
      level.zombie_vars["zombie_spawn_delay"] = timer * 0.95;
    } else if(timer < 0.08) {
      level.zombie_vars["zombie_spawn_delay"] = 0.08;
    }
    level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
    level.round_number++;
    level notify("between_round_over");
  }
}

award_grenades_for_survivors() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(!players[i].is_zombie) {
      lethal_grenade = players[i] get_player_lethal_grenade();
      if(!players[i] hasWeapon(lethal_grenade)) {
        players[i] GiveWeapon(lethal_grenade);
        players[i] SetWeaponAmmoClip(lethal_grenade, 0);
      }
      if(players[i] GetFractionMaxAmmo(lethal_grenade) < .25) {
        players[i] SetWeaponAmmoClip(lethal_grenade, 2);
      } else if(players[i] GetFractionMaxAmmo(lethal_grenade) < .5) {
        players[i] SetWeaponAmmoClip(lethal_grenade, 3);
      } else {
        players[i] SetWeaponAmmoClip(lethal_grenade, 4);
      }
    }
  }
}

ai_calculate_health(round_number) {
  level.zombie_health = level.zombie_vars["zombie_health_start"];
  for(i = 2; i <= round_number; i++) {
    if(i >= 10) {
      level.zombie_health += Int(level.zombie_health * level.zombie_vars["zombie_health_increase_multiplier"]);
    } else {
      level.zombie_health = Int(level.zombie_health + level.zombie_vars["zombie_health_increase"]);
    }
  }
}

round_spawn_failsafe() {
  self endon("death");
  prevorigin = self.origin;
  while(1) {
    if(!level.zombie_vars["zombie_use_failsafe"]) {
      return;
    }
    if(is_true(self.ignore_round_spawn_failsafe)) {
      return;
    }
    wait(30);
    if(isDefined(self.lastchunk_destroy_time)) {
      if((GetTime() - self.lastchunk_destroy_time) < 8000)
        continue;
    }
    if(self.origin[2] < level.zombie_vars["below_world_check"]) {
      if(is_true(level.put_timed_out_zombies_back_in_queue) && !flag("dog_round")) {
        level.zombie_total++;
      }
      self dodamage(self.health + 100, (0, 0, 0));
      break;
    }
    if(distanceSquared(self.origin, prevorigin) < 576) {
      if(is_true(level.put_timed_out_zombies_back_in_queue) && !flag("dog_round")) {
        if(!self.ignoreall && !is_true(self.nuked) && !is_true(self.marked_for_death)) {
          level.zombie_total++;
        }
      }
      level.zombies_timeout_playspace++;
      self dodamage(self.health + 100, (0, 0, 0));
      break;
    }
    prevorigin = self.origin;
  }
}

round_wait() {
  wait(1);
  if(flag("dog_round")) {
    wait(7);
    while(level.dog_intermission) {
      wait(0.5);
    }
  } else {
    while(get_enemy_count() > 0 || level.zombie_total > 0 || level.intermission) {
      if(flag("end_round_wait")) {
        return;
      }
      wait(1.0);
    }
  }
}

is_friendly_fire_on() {
  return level.mutators["mutator_friendlyFire"];
}

can_revive(reviver) {
  if(self has_powerup_weapon()) {
    return false;
  }
  return true;
}

zombify_player() {
  self maps\_zombiemode_score::player_died_penalty();
  bbPrint("zombie_playerdeaths: round %d playername %s deathtype died x %f y %f z %f", level.round_number, self.playername, self.origin);
  if(isDefined(level.deathcard_spawn_func)) {
    self[[level.deathcard_spawn_func]]();
  }
  if(!isDefined(level.zombie_vars["zombify_player"]) || !level.zombie_vars["zombify_player"]) {
    if(!is_true(self.solo_respawn)) {
      self thread spawnSpectator();
    }
    return;
  }
  self.ignoreme = true;
  self.is_zombie = true;
  self.zombification_time = GetTime();
  self.team = "axis";
  self notify("zombified");
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger Delete();
  }
  self.revivetrigger = undefined;
  self setMoveSpeedScale(0.3);
  self reviveplayer();
  self TakeAllWeapons();
  self GiveWeapon("zombie_melee", 0);
  self SwitchToWeapon("zombie_melee");
  self DisableWeaponCycling();
  self DisableOffhandWeapons();
  self visionSetNaked("zombie_turned", 1);
  maps\_utility::setClientSysState("zombify", 1, self);
  self thread maps\_zombiemode_spawner::zombie_eye_glow();
  self thread injured_walk();
  self thread playerzombie_player_damage();
  self thread playerzombie_soundboard();
}

playerzombie_player_damage() {
  self endon("death");
  self endon("disconnect");
  self thread playerzombie_infinite_health();
  self.zombiehealth = level.zombie_health;
  while(1) {
    self waittill("damage", amount, attacker, directionVec, point, type);
    if(!isDefined(attacker) || !IsPlayer(attacker)) {
      wait(0.05);
      continue;
    }
    self.zombiehealth -= amount;
    if(self.zombiehealth <= 0) {
      self thread playerzombie_downed_state();
      self waittill("playerzombie_downed_state_done");
      self.zombiehealth = level.zombie_health;
    }
  }
}

playerzombie_downed_state() {
  self endon("death");
  self endon("disconnect");
  downTime = 15;
  startTime = GetTime();
  endTime = startTime + (downTime * 1000);
  self thread playerzombie_downed_hud();
  self.playerzombie_soundboard_disable = true;
  self thread maps\_zombiemode_spawner::zombie_eye_glow_stop();
  self DisableWeapons();
  self AllowStand(false);
  self AllowCrouch(false);
  self AllowProne(true);
  while(GetTime() < endTime) {
    wait(0.05);
  }
  self.playerzombie_soundboard_disable = false;
  self thread maps\_zombiemode_spawner::zombie_eye_glow();
  self EnableWeapons();
  self AllowStand(true);
  self AllowCrouch(false);
  self AllowProne(false);
  self notify("playerzombie_downed_state_done");
}

playerzombie_downed_hud() {
  self endon("death");
  self endon("disconnect");
  text = NewClientHudElem(self);
  text.alignX = "center";
  text.alignY = "middle";
  text.horzAlign = "user_center";
  text.vertAlign = "user_bottom";
  text.foreground = true;
  text.font = "default";
  text.fontScale = 1.8;
  text.alpha = 0;
  text.color = (1.0, 1.0, 1.0);
  text SetText(&"ZOMBIE_PLAYERZOMBIE_DOWNED");
  text.y = -113;
  if(IsSplitScreen()) {
    text.y = -137;
  }
  text FadeOverTime(0.1);
  text.alpha = 1;
  self waittill("playerzombie_downed_state_done");
  text FadeOverTime(0.1);
  text.alpha = 0;
}

playerzombie_infinite_health() {
  self endon("death");
  self endon("disconnect");
  bighealth = 100000;
  while(1) {
    if(self.health < bighealth) {
      self.health = bighealth;
    }
    wait(0.1);
  }
}

playerzombie_soundboard() {
  self endon("death");
  self endon("disconnect");
  self.playerzombie_soundboard_disable = false;
  self.buttonpressed_use = false;
  self.buttonpressed_attack = false;
  self.buttonpressed_ads = false;
  self.useSound_waitTime = 3 * 1000;
  self.useSound_nextTime = GetTime();
  useSound = "playerzombie_usebutton_sound";
  self.attackSound_waitTime = 3 * 1000;
  self.attackSound_nextTime = GetTime();
  attackSound = "playerzombie_attackbutton_sound";
  self.adsSound_waitTime = 3 * 1000;
  self.adsSound_nextTime = GetTime();
  adsSound = "playerzombie_adsbutton_sound";
  self.inputSound_nextTime = GetTime();
  while(1) {
    if(self.playerzombie_soundboard_disable) {
      wait(0.05);
      continue;
    }
    if(self UseButtonPressed()) {
      if(self can_do_input("use")) {
        self thread playerzombie_play_sound(useSound);
        self thread playerzombie_waitfor_buttonrelease("use");
        self.useSound_nextTime = GetTime() + self.useSound_waitTime;
      }
    } else if(self AttackButtonPressed()) {
      if(self can_do_input("attack")) {
        self thread playerzombie_play_sound(attackSound);
        self thread playerzombie_waitfor_buttonrelease("attack");
        self.attackSound_nextTime = GetTime() + self.attackSound_waitTime;
      }
    } else if(self AdsButtonPressed()) {
      if(self can_do_input("ads")) {
        self thread playerzombie_play_sound(adsSound);
        self thread playerzombie_waitfor_buttonrelease("ads");
        self.adsSound_nextTime = GetTime() + self.adsSound_waitTime;
      }
    }
    wait(0.05);
  }
}

can_do_input(inputType) {
  if(GetTime() < self.inputSound_nextTime) {
    return false;
  }
  canDo = false;
  switch (inputType) {
    case "use":
      if(GetTime() >= self.useSound_nextTime && !self.buttonpressed_use) {
        canDo = true;
      }
      break;
    case "attack":
      if(GetTime() >= self.attackSound_nextTime && !self.buttonpressed_attack) {
        canDo = true;
      }
      break;
    case "ads":
      if(GetTime() >= self.useSound_nextTime && !self.buttonpressed_ads) {
        canDo = true;
      }
      break;
    default:
      ASSERTMSG("can_do_input(): didn't recognize inputType of " + inputType);
      break;
  }
  return canDo;
}

playerzombie_play_sound(alias) {
  self play_sound_on_ent(alias);
}

playerzombie_waitfor_buttonrelease(inputType) {
  if(inputType != "use" && inputType != "attack" && inputType != "ads") {
    ASSERTMSG("playerzombie_waitfor_buttonrelease(): inputType of " + inputType + " is not recognized.");
    return;
  }
  notifyString = "waitfor_buttonrelease_" + inputType;
  self notify(notifyString);
  self endon(notifyString);
  if(inputType == "use") {
    self.buttonpressed_use = true;
    while(self UseButtonPressed()) {
      wait(0.05);
    }
    self.buttonpressed_use = false;
  } else if(inputType == "attack") {
    self.buttonpressed_attack = true;
    while(self AttackButtonPressed()) {
      wait(0.05);
    }
    self.buttonpressed_attack = false;
  } else if(inputType == "ads") {
    self.buttonpressed_ads = true;
    while(self AdsButtonPressed()) {
      wait(0.05);
    }
    self.buttonpressed_ads = false;
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

player_damage_override_cheat(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  player_damage_override(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
  return 0;
}

player_damage_override(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  iDamage = self check_player_damage_callbacks(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
  if(!iDamage) {
    return 0;
  }
  if(sWeapon == "crossbow_explosive_upgraded_zm" && sMeansOfDeath == "MOD_IMPACT") {
    level.monkey_bolt_holder = self;
  }
  if(GetSubStr(sWeapon, 0, 8) == "blow_gun" && sMeansOfDeath == "MOD_IMPACT") {
    eAttacker notify("blow_gun_hit", self, eInflictor);
  }
  if(self maps\_laststand::player_is_in_laststand()) {
    return 0;
  }
  if(isDefined(eInflictor)) {
    if(is_true(eInflictor.water_damage)) {
      return 0;
    }
  }
  if(isDefined(eAttacker)) {
    if(is_true(eAttacker.is_zombie)) {
      self.stats["damage_taken"] += iDamage;
    }
    if(isDefined(self.ignoreAttacker) && self.ignoreAttacker == eAttacker) {
      return 0;
    }
    if((isDefined(eAttacker.is_zombie) && eAttacker.is_zombie) || level.mutators["mutator_friendlyFire"]) {
      self.ignoreAttacker = eAttacker;
      self thread remove_ignore_attacker();
      if(isDefined(eAttacker.custom_damage_func)) {
        iDamage = eAttacker[[eAttacker.custom_damage_func]](self);
      } else if(isDefined(eAttacker.meleeDamage)) {
        iDamage = eAttacker.meleeDamage;
      } else {
        iDamage = 50;
      }
    }
    eAttacker notify("hit_player");
    if(is_true(eattacker.is_zombie) && eattacker.animname == "director_zombie") {
      self playSound("zmb_director_light_hit");
      if(RandomIntRange(0, 1) == 0) {
        self thread maps\_zombiemode_audio::create_and_play_dialog("general", "hitmed");
      } else {
        self thread maps\_zombiemode_audio::create_and_play_dialog("general", "hitlrg");
      }
    } else if(sMeansOfDeath != "MOD_FALLING") {
      self playSound("evt_player_swiped");
      if(RandomIntRange(0, 1) == 0) {
        self thread maps\_zombiemode_audio::create_and_play_dialog("general", "hitmed");
      } else {
        self thread maps\_zombiemode_audio::create_and_play_dialog("general", "hitlrg");
      }
    }
  }
  finalDamage = iDamage;
  if(is_placeable_mine(sWeapon) || sWeapon == "freezegun_zm" || sWeapon == "freezegun_upgraded_zm") {
    return 0;
  }
  if(isDefined(self.player_damage_override)) {
    self thread[[self.player_damage_override]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
  }
  if(sMeansOfDeath == "MOD_FALLING") {
    if(self HasPerk("specialty_flakjacket") && isDefined(self.divetoprone) && self.divetoprone == 1) {
      if(isDefined(level.zombiemode_divetonuke_perk_func)) {
        [
          [level.zombiemode_divetonuke_perk_func]
        ](self, self.origin);
      }
      return 0;
    }
  }
  if(sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH" || sMeansOfDeath == "MOD_GRENADE" || sMeansOfDeath == "MOD_GRENADE_SPLASH") {
    if(self HasPerk("specialty_flakjacket")) {
      return 0;
    }
    if(self.health > 75) {
      return 75;
    }
  }
  if(iDamage < self.health) {
    if(isDefined(eAttacker)) {
      eAttacker.sound_damage_player = self;
      if(isDefined(eAttacker.has_legs) && !eAttacker.has_legs) {
        self maps\_zombiemode_audio::create_and_play_dialog("general", "crawl_hit");
      } else if(isDefined(eAttacker.animname) && (eAttacker.animname == "monkey_zombie")) {
        self maps\_zombiemode_audio::create_and_play_dialog("general", "monkey_hit");
      }
    }
    return finalDamage;
  }
  if(level.intermission) {
    level waittill("forever");
  }
  players = get_players();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] == self || players[i].is_zombie || players[i] maps\_laststand::player_is_in_laststand() || players[i].sessionstate == "spectator") {
      count++;
    }
  }
  if(count < players.size) {
    return finalDamage;
  }
  if(players.size == 1 && flag("solo_game")) {
    if(self.lives == 0) {
      self.intermission = true;
    }
  }
  solo_death = (players.size == 1 && flag("solo_game") && self.lives == 0);
  non_solo_death = (players.size > 1 || (players.size == 1 && !flag("solo_game")));
  if(solo_death || non_solo_death) {
    self thread maps\_laststand::PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime);
    self player_fake_death();
  }
  if(count == players.size) {
    if(players.size == 1 && flag("solo_game")) {
      if(self.lives == 0) {
        level notify("pre_end_game");
        wait_network_frame();
        level notify("end_game");
      } else {
        self thread wait_and_revive();
        return finalDamage;
      }
    } else {
      level notify("pre_end_game");
      wait_network_frame();
      level notify("end_game");
    }
    return 0;
  } else {
    return finalDamage;
  }
}

check_player_damage_callbacks(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  if(!isDefined(level.player_damage_callbacks)) {
    return iDamage;
  }
  for(i = 0; i < level.player_damage_callbacks.size; i++) {
    newDamage = self[[level.player_damage_callbacks[i]]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
    if(-1 != newDamage) {
      return newDamage;
    }
  }
  return iDamage;
}

register_player_damage_callback(func) {
  if(!isDefined(level.player_damage_callbacks)) {
    level.player_damage_callbacks = [];
  }
  level.player_damage_callbacks[level.player_damage_callbacks.size] = func;
}

wait_and_revive() {
  flag_set("wait_and_revive");
  if(isDefined(self.waiting_to_revive) && self.waiting_to_revive == true) {
    return;
  }
  self.waiting_to_revive = true;
  if(isDefined(level.exit_level_func)) {
    self thread[[level.exit_level_func]]();
  } else {
    self thread default_exit_level();
  }
  while(1) {
    if(self maps\_laststand::player_is_in_laststand()) {
      break;
    }
    wait_network_frame();
  }
  solo_revive_time = 10.0;
  self.revive_hud setText(&"ZOMBIE_REVIVING_SOLO", self);
  self maps\_laststand::revive_hud_show_n_fade(solo_revive_time);
  flag_wait_or_timeout("instant_revive", solo_revive_time);
  flag_clear("wait_and_revive");
  self maps\_laststand::auto_revive(self);
  self.lives--;
  self.waiting_to_revive = false;
}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, sHitLoc, modelIndex, psOffsetTime) {
  if(weapon == "crossbow_explosive_upgraded_zm" && meansofdeath == "MOD_IMPACT") {
    level.monkey_bolt_holder = self;
  }
  if(GetSubStr(weapon, 0, 8) == "blow_gun" && meansofdeath == "MOD_IMPACT") {
    attacker notify("blow_gun_hit", self, inflictor);
  }
  if(isDefined(attacker.animname) && attacker.animname == "quad_zombie") {
    if(isDefined(self.animname) && self.animname == "quad_zombie") {
      return 0;
    }
  }
  if(!isDefined(self) || !isDefined(attacker))
    return damage;
  if(!isplayer(attacker) && isDefined(self.non_attacker_func)) {
    override_damage = self[[self.non_attacker_func]](damage, weapon);
    if(override_damage)
      return override_damage;
  }
  if(!isplayer(attacker) && !isplayer(self))
    return damage;
  if(!isDefined(damage) || !isDefined(meansofdeath))
    return damage;
  if(meansofdeath == "")
    return damage;
  old_damage = damage;
  final_damage = damage;
  if(isDefined(self.actor_damage_func)) {
    final_damage = [[self.actor_damage_func]](weapon, old_damage, attacker);
  }
  if(isDefined(self.actor_full_damage_func)) {
    final_damage = [[self.actor_full_damage_func]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, sHitLoc, modelIndex, psOffsetTime);
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner))
    attacker = attacker.owner;
  if(!isDefined(self.damage_assists)) {
    self.damage_assists = [];
  }
  if(!isDefined(self.damage_assists[attacker.entity_num])) {
    self.damage_assists[attacker.entity_num] = attacker;
  }
  if(level.mutators["mutator_headshotsOnly"] && !is_headshot(weapon, sHitLoc, meansofdeath)) {
    return 0;
  }
  if(level.mutators["mutator_powerShot"]) {
    final_damage = int(final_damage * 1.5);
  }
  if(is_true(self.in_water)) {
    if(int(final_damage) >= self.health) {
      self.water_damage = true;
    }
  }
  return int(final_damage);
}

is_headshot(sWeapon, sHitLoc, sMeansOfDeath) {
  return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_BAYONET" && sMeansOfDeath != "MOD_IMPACT";
}

actor_killed_override(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime) {
  if(game["state"] == "postgame")
    return;
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(attacker.script_owner.team != self.aiteam)
      attacker = attacker.script_owner;
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner))
    attacker = attacker.owner;
  if(IsPlayer(level.monkey_bolt_holder) && sMeansOfDeath == "MOD_GRENADE_SPLASH" &&
    (sWeapon == "crossbow_explosive_upgraded_zm" || sWeapon == "explosive_bolt_upgraded_zm")) {
    level._bolt_on_back = level._bolt_on_back + 1;
  }
  if(isDefined(attacker) && isplayer(attacker)) {
    multiplier = 1;
    if(is_headshot(sWeapon, sHitLoc, sMeansOfDeath)) {
      multiplier = 1.5;
    }
    type = undefined;
    if(isDefined(self.animname)) {
      switch (self.animname) {
        case "quad_zombie":
          type = "quadkill";
          break;
        case "ape_zombie":
          type = "apekill";
          break;
        case "zombie":
          type = "zombiekill";
          break;
        case "zombie_dog":
          type = "dogkill";
          break;
      }
    }
  }
  if(is_true(self.is_ziplining)) {
    self.deathanim = undefined;
  }
  if(isDefined(self.actor_killed_override)) {
    self[[self.actor_killed_override]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime);
  }
}

process_assist(type, attacker) {
  if(isDefined(self.damage_assists)) {
    for(j = 0; j < self.damage_assists.size; j++) {
      player = self.damage_assists[j];
      if(!isDefined(player))
        continue;
      if(player == attacker)
        continue;
    }
    self.damage_assists = undefined;
  }
}

end_game() {
  level waittill("end_game");
  clientnotify("zesn");
  level thread maps\_zombiemode_audio::change_zombie_music("game_over");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    setClientSysState("lsm", "0", players[i]);
  }
  StopAllRumbles();
  level.intermission = true;
  level.zombie_vars["zombie_powerup_insta_kill_time"] = 0;
  level.zombie_vars["zombie_powerup_fire_sale_time"] = 0;
  level.zombie_vars["zombie_powerup_point_doubler_time"] = 0;
  wait 0.1;
  update_leaderboards();
  game_over = [];
  survived = [];
  players = get_players();
  for(i = 0; i < players.size; i++) {
    game_over[i] = NewClientHudElem(players[i]);
    game_over[i].alignX = "center";
    game_over[i].alignY = "middle";
    game_over[i].horzAlign = "center";
    game_over[i].vertAlign = "middle";
    game_over[i].y -= 130;
    game_over[i].foreground = true;
    game_over[i].fontScale = 3;
    game_over[i].alpha = 0;
    game_over[i].color = (1.0, 1.0, 1.0);
    game_over[i] SetText(&"ZOMBIE_GAME_OVER");
    game_over[i] FadeOverTime(1);
    game_over[i].alpha = 1;
    if(players[i] isSplitScreen()) {
      game_over[i].y += 40;
    }
    survived[i] = NewClientHudElem(players[i]);
    survived[i].alignX = "center";
    survived[i].alignY = "middle";
    survived[i].horzAlign = "center";
    survived[i].vertAlign = "middle";
    survived[i].y -= 100;
    survived[i].foreground = true;
    survived[i].fontScale = 2;
    survived[i].alpha = 0;
    survived[i].color = (1.0, 1.0, 1.0);
    if(players[i] isSplitScreen()) {
      survived[i].y += 40;
    }
    if(level.round_number < 2) {
      if(level.script == "zombie_moon") {
        if(!isDefined(level.left_nomans_land)) {
          nomanslandtime = level.nml_best_time;
          player_survival_time = int(nomanslandtime / 1000);
          player_survival_time_in_mins = maps\_zombiemode::to_mins(player_survival_time);
          survived[i] SetText(&"ZOMBIE_SURVIVED_NOMANS", player_survival_time_in_mins);
        } else if(level.left_nomans_land == 2) {
          survived[i] SetText(&"ZOMBIE_SURVIVED_ROUND");
        }
      } else {
        survived[i] SetText(&"ZOMBIE_SURVIVED_ROUND");
      }
    } else {
      survived[i] SetText(&"ZOMBIE_SURVIVED_ROUNDS", level.round_number);
    }
    survived[i] FadeOverTime(1);
    survived[i].alpha = 1;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvars("ammoCounterHide", "1",
      "miniscoreboardhide", "1");
  }
  destroy_chalk_hud();
  UploadStats();
  wait(1);
  wait(2);
  intermission();
  wait(level.zombie_vars["zombie_intermission_time"]);
  level notify("stop_intermission");
  array_thread(get_players(), ::player_exit_level);
  bbPrint("zombie_epilogs: rounds %d", level.round_number);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    survived[i] FadeOverTime(1);
    survived[i].alpha = 0;
    game_over[i] FadeOverTime(1);
    game_over[i].alpha = 0;
  }
  wait(1.5);
  for(j = 0; j < get_players().size; j++) {
    player = get_players()[j];
    player CameraActivate(false);
    survived[j] Destroy();
    game_over[j] Destroy();
  }
  if(level.onlineGame || level.systemLink) {
    ExitLevel(false);
  } else {
    MissionFailed();
  }
  wait(666);
}

update_leaderboards() {
  uploadGlobalStatCounters();
  if(GetPlayers().size <= 1) {
    cheater_found = maps\_zombiemode_ffotd::nazizombies_checking_for_cheats();
    if(cheater_found == false) {
      nazizombies_upload_solo_highscore();
    }
    return;
  }
  if(level.systemLink) {
    return;
  }
  if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    return;
  }
  cheater_found = maps\_zombiemode_ffotd::nazizombies_checking_for_cheats();
  if(cheater_found == false) {
    nazizombies_upload_highscore();
    nazizombies_set_new_zombie_stats();
  }
}

initializeStatTracking() {
  level.global_zombies_killed = 0;
}

uploadGlobalStatCounters() {
  incrementCounter("global_zombies_killed", level.global_zombies_killed);
  incrementCounter("global_zombies_killed_by_players", level.zombie_player_killed_count);
  incrementCounter("global_zombies_killed_by_traps", level.zombie_trap_killed_count);
}

player_fake_death() {
  level notify("fake_death");
  self notify("fake_death");
  self TakeAllWeapons();
  self AllowProne(true);
  self AllowStand(false);
  self AllowCrouch(false);
  self.ignoreme = true;
  self EnableInvulnerability();
  wait(1);
  self FreezeControls(true);
}

player_exit_level() {
  self AllowStand(true);
  self AllowCrouch(false);
  self AllowProne(false);
  if(isDefined(self.game_over_bg)) {
    self.game_over_bg.foreground = true;
    self.game_over_bg.sort = 100;
    self.game_over_bg FadeOverTime(1);
    self.game_over_bg.alpha = 1;
  }
}

player_killed_override() {
  level waittill("forever");
}

injured_walk() {
  self.ground_ref_ent = spawn("script_model", (0, 0, 0));
  self.player_speed = 50;
  self AllowSprint(false);
  self AllowProne(false);
  self AllowCrouch(false);
  self AllowAds(false);
  self AllowJump(false);
  self PlayerSetGroundReferenceEnt(self.ground_ref_ent);
  self thread limp();
}

limp() {
  level endon("disconnect");
  level endon("death");
  stumble = 0;
  alt = 0;
  while(1) {
    velocity = self GetVelocity();
    player_speed = abs(velocity[0]) + abs(velocity[1]);
    if(player_speed < 10) {
      wait(0.05);
      continue;
    }
    speed_multiplier = player_speed / self.player_speed;
    p = RandomFloatRange(3, 5);
    if(randomInt(100) < 20) {
      p *= 3;
    }
    r = RandomFloatRange(3, 7);
    y = RandomFloatRange(-8, -2);
    stumble_angles = (p, y, r);
    stumble_angles = vector_scale(stumble_angles, speed_multiplier);
    stumble_time = RandomFloatRange(.35, .45);
    recover_time = RandomFloatRange(.65, .8);
    stumble++;
    if(speed_multiplier > 1.3) {
      stumble++;
    }
    self thread stumble(stumble_angles, stumble_time, recover_time);
    level waittill("recovered");
  }
}

stumble(stumble_angles, stumble_time, recover_time, no_notify) {
  stumble_angles = self adjust_angles_to_player(stumble_angles);
  self.ground_ref_ent RotateTo(stumble_angles, stumble_time, (stumble_time / 4 * 3), (stumble_time / 4));
  self.ground_ref_ent waittill("rotatedone");
  base_angles = (RandomFloat(4) - 4, RandomFloat(5), 0);
  base_angles = self adjust_angles_to_player(base_angles);
  self.ground_ref_ent RotateTo(base_angles, recover_time, 0, (recover_time / 2));
  self.ground_ref_ent waittill("rotatedone");
  if(!isDefined(no_notify)) {
    level notify("recovered");
  }
}

adjust_angles_to_player(stumble_angles) {
  pa = stumble_angles[0];
  ra = stumble_angles[2];
  rv = AnglesToRight(self.angles);
  fv = anglesToForward(self.angles);
  rva = (rv[0], 0, rv[1] * -1);
  fva = (fv[0], 0, fv[1] * -1);
  angles = vector_scale(rva, pa);
  angles = angles + vector_scale(fva, ra);
  return angles + (0, stumble_angles[1], 0);
}

coop_player_spawn_placement() {
  structs = getstructarray("initial_spawn_points", "targetname");
  temp_ent = spawn("script_model", (0, 0, 0));
  for(i = 0; i < structs.size; i++) {
    temp_ent.origin = structs[i].origin;
    temp_ent placeSpawnpoint();
    structs[i].origin = temp_ent.origin;
  }
  temp_ent Delete();
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] setorigin(structs[i].origin);
    players[i] setplayerangles(structs[i].angles);
    players[i].spectator_respawn = structs[i];
  }
}

player_zombie_breadcrumb() {
  self endon("disconnect");
  self endon("spawned_spectator");
  level endon("intermission");
  self.zombie_breadcrumbs = [];
  self.zombie_breadcrumb_distance = 24 * 24;
  self.zombie_breadcrumb_area_num = 3;
  self.zombie_breadcrumb_area_distance = 16;
  self store_crumb(self.origin);
  last_crumb = self.origin;
  self thread debug_breadcrumbs();
  while(1) {
    wait_time = 0.1;
    store_crumb = true;
    airborne = false;
    crumb = self.origin;
    if(!self IsOnGround() && self isinvehicle()) {
      trace = bulletTrace(self.origin + (0, 0, 10), self.origin, false, undefined);
      crumb = trace["position"];
    }
    if(!airborne && distanceSquared(crumb, last_crumb) < self.zombie_breadcrumb_distance) {
      store_crumb = false;
    }
    if(airborne && self IsOnGround()) {
      store_crumb = true;
      airborne = false;
    }
    if(isDefined(level.custom_breadcrumb_store_func)) {
      store_crumb = self[[level.custom_breadcrumb_store_func]](store_crumb);
    }
    if(isDefined(level.custom_airborne_func)) {
      airborne = self[[level.custom_airborne_func]](airborne);
    }
    if(store_crumb) {
      debug_print("Player is storing breadcrumb " + crumb);
      if(isDefined(self.node)) {
        debug_print("has closest node ");
      }
      last_crumb = crumb;
      self store_crumb(crumb);
    }
    wait(wait_time);
  }
}

store_crumb(origin) {
  offsets = [];
  height_offset = 32;
  index = 0;
  for(j = 1; j <= self.zombie_breadcrumb_area_num; j++) {
    offset = (j * self.zombie_breadcrumb_area_distance);
    offsets[0] = (origin[0] - offset, origin[1], origin[2]);
    offsets[1] = (origin[0] + offset, origin[1], origin[2]);
    offsets[2] = (origin[0], origin[1] - offset, origin[2]);
    offsets[3] = (origin[0], origin[1] + offset, origin[2]);
    offsets[4] = (origin[0] - offset, origin[1], origin[2] + height_offset);
    offsets[5] = (origin[0] + offset, origin[1], origin[2] + height_offset);
    offsets[6] = (origin[0], origin[1] - offset, origin[2] + height_offset);
    offsets[7] = (origin[0], origin[1] + offset, origin[2] + height_offset);
    for(i = 0; i < offsets.size; i++) {
      self.zombie_breadcrumbs[index] = offsets[i];
      index++;
    }
  }
}

to_mins(seconds) {
  hours = 0;
  minutes = 0;
  if(seconds > 59) {
    minutes = int(seconds / 60);
    seconds = int(seconds * 1000) % (60 * 1000);
    seconds = seconds * 0.001;
    if(minutes > 59) {
      hours = int(minutes / 60);
      minutes = int(minutes * 1000) % (60 * 1000);
      minutes = minutes * 0.001;
    }
  }
  if(hours < 10) {
    hours = "0" + hours;
  }
  if(minutes < 10) {
    minutes = "0" + minutes;
  }
  seconds = Int(seconds);
  if(seconds < 10) {
    seconds = "0" + seconds;
  }
  combined = "" + hours + ":" + minutes + ":" + seconds;
  return combined;
}

nazizombies_upload_solo_highscore() {
  map_name = getDvar(#"mapname");
  if(!isZombieLeaderboardAvailable(map_name, "kills"))
    return;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(map_name == "zombie_moon") {
      nomanslandtime = level.nml_best_time;
      nomansland_kills = level.nml_kills;
      nomansland_score = level.nml_score;
      player_survival_time = int(nomanslandtime / 1000);
      total_score = nomansland_score;
      total_kills = nomansland_kills;
      leaderboard_number = getZombieLeaderboardNumber(map_name, "kills");
      rounds_survived = level.round_number;
      if(isDefined(level.nml_didteleport) && (level.nml_didteleport == false)) {
        rounds_survived = 0;
      }
      rankNumber = makeNMLRankNumberSolo(total_kills, total_score);
      if(!isDefined(level.round_number)) {
        level.round_number = 0;
      }
      if(!isDefined(level.nml_pap)) {
        level.nml_pap = 0;
      }
      if(!isDefined(level.nml_speed)) {
        level.nml_speed = 0;
      }
      if(!isDefined(level.nml_jugg)) {
        level.nml_jugg = 0;
      }
      if(!isDefined(level.sololb_build_number)) {
        level.sololb_build_number = 48;
      }
      players[i] UploadScore(leaderboard_number, int(rankNumber), total_kills, total_score, player_survival_time, rounds_survived, level.sololb_build_number, level.nml_pap, level.nml_speed, level.nml_jugg);
    }
  }
}

makeNMLRankNumberSolo(total_kills, total_score) {
  maximum_survival_time = 108000;
  if(total_kills > 2000)
    total_kills = 2000;
  if(total_score > 99999)
    total_score = 99999;
  score_padding = "";
  if(total_score < 10)
    score_padding += "0000";
  else if(total_score < 100)
    score_padding += "000";
  else if(total_score < 1000)
    score_padding += "00";
  else if(total_score < 10000)
    score_padding += "0";
  rankNumber = total_kills + score_padding + total_score;
  return rankNumber;
}

nazizombies_upload_highscore() {
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
        players[i].zombification_time = GetTime();
      }
      player_survival_time = players[i].zombification_time - level.round_start_time;
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
    if(players[i].score_total > pre_total_points) {
      leaderboard_number = getZombieLeaderboardNumber(map_name, "points");
      players[i] UploadScore(leaderboard_number, players[i].score_total, players[i].kills, level.players_playing);
      players[i] playerZombieStatSet(map_name, "totalpoints", players[i].score_total);
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
  return result;
}

playerZombieStatSet(map, variable, value) {
  stat_variable = getZombieStatVariable(map, variable);
  self zombieStatSet(stat_variable, value);
}

nazizombies_set_new_zombie_stats() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    total_kills = players[i] zombieStatGet("zombie_kills") + players[i].stats["kills"];
    total_points = players[i] zombieStatGet("zombie_points") + players[i].stats["score"];
    total_rounds = players[i] zombieStatGet("zombie_rounds") + (level.round_number - 1);
    total_downs = players[i] zombieStatGet("zombie_downs") + players[i].stats["downs"];
    total_revives = players[i] zombieStatGet("zombie_revives") + players[i].stats["revives"];
    total_perks = players[i] zombieStatGet("zombie_perks_consumed") + players[i].stats["perks"];
    total_headshots = players[i] zombieStatGet("zombie_heashots") + players[i].stats["headshots"];
    total_zombie_gibs = players[i] zombieStatGet("zombie_gibs") + players[i].stats["zombie_gibs"];
    players[i] zombieStatSet("zombie_kills", total_kills);
    players[i] zombieStatSet("zombie_points", total_points);
    players[i] zombieStatSet("zombie_rounds", total_rounds);
    players[i] zombieStatSet("zombie_downs", total_downs);
    players[i] zombieStatSet("zombie_revives", total_revives);
    players[i] zombieStatSet("zombie_perks_consumed", total_perks);
    players[i] zombieStatSet("zombie_heashots", total_headshots);
    players[i] zombieStatSet("zombie_gibs", total_zombie_gibs);
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
    return;
  }
  if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    return;
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
  self setdstat("PlayerStatsList", dataName, value);
}

intermission() {
  level.intermission = true;
  level notify("intermission");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    setclientsysstate("levelNotify", "zi", players[i]);
    players[i] SetClientDvars("cg_thirdPerson", "0",
      "cg_fov", "65");
    players[i].health = 100;
    players[i] thread[[level.custom_intermission]]();
  }
  wait(0.25);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    setClientSysState("lsm", "0", players[i]);
  }
  visionset = "zombie";
  if(isDefined(level.zombie_vars["intermission_visionset"])) {
    visionset = level.zombie_vars["intermission_visionset"];
  }
  level thread maps\_utility::set_all_players_visionset(visionset, 2);
  level thread zombie_game_over_death();
}

zombie_game_over_death() {
  zombies = GetAiArray("axis");
  for(i = 0; i < zombies.size; i++) {
    if(!IsAlive(zombies[i])) {
      continue;
    }
    zombies[i] SetGoalPos(zombies[i].origin);
  }
  for(i = 0; i < zombies.size; i++) {
    if(!IsAlive(zombies[i])) {
      continue;
    }
    wait(0.5 + RandomFloat(2));
    if(isDefined(zombies[i])) {
      zombies[i] maps\_zombiemode_spawner::zombie_head_gib();
      zombies[i] DoDamage(zombies[i].health + 666, zombies[i].origin);
    }
  }
}

player_intermission() {
  self closeMenu();
  self closeInGameMenu();
  level endon("stop_intermission");
  self endon("disconnect");
  self endon("death");
  self notify("_zombie_game_over");
  self.score = self.score_total;
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  points = getstructarray("intermission", "targetname");
  if(!isDefined(points) || points.size == 0) {
    points = getEntArray("info_intermission", "classname");
    if(points.size < 1) {
      println("NO info_intermission POINTS IN MAP");
      return;
    }
  }
  self.game_over_bg = NewClientHudelem(self);
  self.game_over_bg.horzAlign = "fullscreen";
  self.game_over_bg.vertAlign = "fullscreen";
  self.game_over_bg SetShader("black", 640, 480);
  self.game_over_bg.alpha = 1;
  org = undefined;
  while(1) {
    points = array_randomize(points);
    for(i = 0; i < points.size; i++) {
      point = points[i];
      if(!isDefined(org)) {
        self spawn(point.origin, point.angles);
      }
      if(isDefined(points[i].target)) {
        if(!isDefined(org)) {
          org = spawn("script_model", self.origin + (0, 0, -60));
          org setModel("tag_origin");
        }
        org.origin = points[i].origin;
        org.angles = points[i].angles;
        for(j = 0; j < get_players().size; j++) {
          player = get_players()[j];
          player CameraSetPosition(org);
          player CameraSetLookAt();
          player CameraActivate(true);
        }
        speed = 20;
        if(isDefined(points[i].speed)) {
          speed = points[i].speed;
        }
        target_point = getstruct(points[i].target, "targetname");
        dist = Distance(points[i].origin, target_point.origin);
        time = dist / speed;
        q_time = time * 0.25;
        if(q_time > 1) {
          q_time = 1;
        }
        self.game_over_bg FadeOverTime(q_time);
        self.game_over_bg.alpha = 0;
        org moveTo(target_point.origin, time, q_time, q_time);
        org RotateTo(target_point.angles, time, q_time, q_time);
        wait(time - q_time);
        self.game_over_bg FadeOverTime(q_time);
        self.game_over_bg.alpha = 1;
        wait(q_time);
      } else {
        self.game_over_bg FadeOverTime(1);
        self.game_over_bg.alpha = 0;
        wait(5);
        self.game_over_bg thread fade_up_over_time(1);
      }
    }
  }
}

fade_up_over_time(t) {
  self FadeOverTime(t);
  self.alpha = 1;
}

prevent_near_origin() {
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      for(q = 0; q < players.size; q++) {
        if(players[i] != players[q]) {
          if(check_to_kill_near_origin(players[i], players[q])) {
            p1_org = players[i].origin;
            p2_org = players[q].origin;
            wait 5;
            if(check_to_kill_near_origin(players[i], players[q])) {
              if((distance(players[i].origin, p1_org) < 30) && distance(players[q].origin, p2_org) < 30) {
                setsaveddvar("player_deathInvulnerableTime", 0);
                players[i] DoDamage(players[i].health + 1000, players[i].origin, undefined, undefined, "riflebullet");
                setsaveddvar("player_deathInvulnerableTime", level.startInvulnerableTime);
              }
            }
          }
        }
      }
    }
    wait 0.2;
  }
}

check_to_kill_near_origin(player1, player2) {
  if(!isDefined(player1) || !isDefined(player2)) {
    return false;
  }
  if(distance(player1.origin, player2.origin) > 12) {
    return false;
  }
  if(player1 maps\_laststand::player_is_in_laststand() || player2 maps\_laststand::player_is_in_laststand()) {
    return false;
  }
  if(!isalive(player1) || !isalive(player2)) {
    return false;
  }
  return true;
}

crawler_round_tracker() {
  level.crawler_round_count = 1;
  level.next_crawler_round = 4;
  sav_func = level.round_spawn_func;
  while(1) {
    level waittill("between_round_over");
    if(level.round_number == level.next_crawler_round) {
      sav_func = level.round_spawn_func;
      crawler_round_start();
      level.round_spawn_func = ::round_spawning;
      if(isDefined(level.next_dog_round)) {
        level.next_crawler_round = level.next_dog_round + randomintrange(2, 3);
      } else {
        level.next_crawler_round = randomintrange(4, 6);
      }
    } else if(flag("crawler_round")) {
      crawler_round_stop();
      if(isDefined(level.next_dog_round) &&
        level.next_dog_round == level.round_number) {
        level.round_spawn_func = sav_func;
      }
      level.crawler_round_count += 1;
    }
  }
}

crawler_round_start() {
  flag_set("crawler_round");
  if(!isDefined(level.crawlerround_nomusic)) {
    level.crawlerround_nomusic = 0;
  }
  level.crawlerround_nomusic = 1;
  level notify("crawler_round_starting");
  clientnotify("crawler_start");
}

crawler_round_stop() {
  flag_clear("crawler_round");
  if(!isDefined(level.crawlerround_nomusic)) {
    level.crawlerround_nomusic = 0;
  }
  level.crawlerround_nomusic = 0;
  level notify("crawler_round_ending");
  clientnotify("crawler_stop");
}

default_exit_level() {
  zombies = GetAiArray("axis");
  for(i = 0; i < zombies.size; i++) {
    if(is_true(zombies[i].ignore_solo_last_stand)) {
      continue;
    }
    if(isDefined(zombies[i].find_exit_point)) {
      zombies[i] thread[[zombies[i].find_exit_point]]();
      continue;
    }
    if(zombies[i].ignoreme) {
      zombies[i] thread default_delayed_exit();
    } else {
      zombies[i] thread default_find_exit_point();
    }
  }
}

default_delayed_exit() {
  self endon("death");
  while(1) {
    if(!flag("wait_and_revive")) {
      return;
    }
    if(!self.ignoreme) {
      break;
    }
    wait_network_frame();
  }
  self thread default_find_exit_point();
}

default_find_exit_point() {
  self endon("death");
  player = getplayers()[0];
  dist_zombie = 0;
  dist_player = 0;
  dest = 0;
  away = VectorNormalize(self.origin - player.origin);
  endPos = self.origin + vector_scale(away, 600);
  locs = array_randomize(level.enemy_dog_locations);
  for(i = 0; i < locs.size; i++) {
    dist_zombie = distanceSquared(locs[i].origin, endPos);
    dist_player = distanceSquared(locs[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      dest = i;
      break;
    }
  }
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self setgoalpos(locs[dest].origin);
  while(1) {
    if(!flag("wait_and_revive")) {
      break;
    }
    wait_network_frame();
  }
  self thread maps\_zombiemode_spawner::find_flesh();
}

play_level_start_vox_delayed() {
  wait(5);
  players = getplayers();
  num = RandomIntRange(0, players.size);
  players[num] maps\_zombiemode_audio::create_and_play_dialog("general", "intro");
}

init_screen_stats() {
  level.zombies_timeout_spawn_info = NewHudElem();
  level.zombies_timeout_spawn_info.alignX = "right";
  level.zombies_timeout_spawn_info.x = 100;
  level.zombies_timeout_spawn_info.y = 80;
  level.zombies_timeout_spawn_info.label = "Timeout(Spawncloset): ";
  level.zombies_timeout_spawn_info.fontscale = 1.2;
  level.zombies_timeout_playspace_info = NewHudElem();
  level.zombies_timeout_playspace_info.alignX = "right";
  level.zombies_timeout_playspace_info.x = 100;
  level.zombies_timeout_playspace_info.y = 95;
  level.zombies_timeout_playspace_info.label = "Timeout(Playspace): ";
  level.zombies_timeout_playspace_info.fontscale = 1.2;
  level.zombie_player_killed_count_info = NewHudElem();
  level.zombie_player_killed_count_info.alignX = "right";
  level.zombie_player_killed_count_info.x = 100;
  level.zombie_player_killed_count_info.y = 110;
  level.zombie_player_killed_count_info.label = "Zombies killed by players: ";
  level.zombie_player_killed_count_info.fontscale = 1.2;
  level.zombie_trap_killed_count_info = NewHudElem();
  level.zombie_trap_killed_count_info.alignX = "right";
  level.zombie_trap_killed_count_info.x = 100;
  level.zombie_trap_killed_count_info.y = 125;
  level.zombie_trap_killed_count_info.label = "Zombies killed by traps: ";
  level.zombie_trap_killed_count_info.fontscale = 1.2;
  level.zombie_pathing_failed_info = NewHudElem();
  level.zombie_pathing_failed_info.alignX = "right";
  level.zombie_pathing_failed_info.x = 100;
  level.zombie_pathing_failed_info.y = 140;
  level.zombie_pathing_failed_info.label = "Pathing failed: ";
  level.zombie_pathing_failed_info.fontscale = 1.2;
  level.zombie_breadcrumb_failed_info = NewHudElem();
  level.zombie_breadcrumb_failed_info.alignX = "right";
  level.zombie_breadcrumb_failed_info.x = 100;
  level.zombie_breadcrumb_failed_info.y = 155;
  level.zombie_breadcrumb_failed_info.label = "Breadcrumbs failed: ";
  level.zombie_breadcrumb_failed_info.fontscale = 1.2;
  level.player_0_distance_traveled_info = NewHudElem();
  level.player_0_distance_traveled_info.alignX = "right";
  level.player_0_distance_traveled_info.x = 100;
  level.player_0_distance_traveled_info.y = 170;
  level.player_0_distance_traveled_info.label = "Player(0) Distance traveled: ";
  level.player_0_distance_traveled_info.fontscale = 1.2;
}

update_screen_stats() {
  flag_wait("all_players_spawned");
  while(1) {
    wait(1);
    if(getdvarint("zombie_show_stats") == 0) {
      level.zombies_timeout_spawn_info.alpha = 0;
      level.zombies_timeout_playspace_info.alpha = 0;
      level.zombie_player_killed_count_info.alpha = 0;
      level.zombie_trap_killed_count_info.alpha = 0;
      level.zombie_pathing_failed_info.alpha = 0;
      level.zombie_breadcrumb_failed_info.alpha = 0;
      level.player_0_distance_traveled_info.alpha = 0;
      continue;
    } else {
      level.zombies_timeout_spawn_info.alpha = 1;
      level.zombies_timeout_playspace_info.alpha = 1;
      level.zombie_player_killed_count_info.alpha = 1;
      level.zombie_trap_killed_count_info.alpha = 1;
      level.zombie_pathing_failed_info.alpha = 1;
      level.zombie_breadcrumb_failed_info.alpha = 1;
      level.player_0_distance_traveled_info.alpha = 1;
      level.zombies_timeout_spawn_info setValue(level.zombies_timeout_spawn);
      level.zombies_timeout_playspace_info SetValue(level.zombies_timeout_playspace);
      level.zombie_player_killed_count_info SetValue(level.zombie_player_killed_count);
      level.zombie_trap_killed_count_info SetValue(level.zombie_trap_killed_count);
      level.zombie_pathing_failed_info SetValue(level.zombie_pathing_failed);
      level.zombie_breadcrumb_failed_info SetValue(level.zombie_breadcrumb_failed);
      level.player_0_distance_traveled_info SetValue(get_players()[0].stats["distance_traveled"]);
    }
  }
}

register_sidequest(id, solo_stat, solo_collectible, coop_stat, coop_collectible) {
  if(!isDefined(level.zombie_sidequest_solo_stat)) {
    level.zombie_sidequest_previously_completed = [];
    level.zombie_sidequest_solo_stat = [];
    level.zombie_sidequest_solo_collectible = [];
    level.zombie_sidequest_coop_stat = [];
    level.zombie_sidequest_coop_collectible = [];
  }
  level.zombie_sidequest_solo_stat[id] = solo_stat;
  level.zombie_sidequest_solo_collectible[id] = solo_collectible;
  level.zombie_sidequest_coop_stat[id] = coop_stat;
  level.zombie_sidequest_coop_collectible[id] = coop_collectible;
  flag_wait("all_players_spawned");
  level.zombie_sidequest_previously_completed[id] = false;
  if(flag("solo_game")) {
    if(isDefined(level.zombie_sidequest_solo_collectible[id])) {
      level.zombie_sidequest_previously_completed[id] = HasCollectible(level.zombie_sidequest_solo_collectible[id]);
    }
  } else {
    if(level.systemLink || GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
      if(isDefined(level.zombie_sidequest_coop_collectible[id])) {
        level.zombie_sidequest_previously_completed[id] = HasCollectible(level.zombie_sidequest_coop_collectible[id]);
      }
      return;
    }
    if(!isDefined(level.zombie_sidequest_coop_stat[id])) {
      return;
    }
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] zombieStatGet(level.zombie_sidequest_coop_stat[id])) {
        level.zombie_sidequest_previously_completed[id] = true;
        return;
      }
    }
  }
}

is_sidequest_previously_completed(id) {
  return is_true(level.zombie_sidequest_previously_completed[id]);
}

set_sidequest_completed(id) {
  if(maps\_cheat::is_cheating() || flag("has_cheated")) {
    return;
  }
  if(flag("solo_game")) {
    client_notify_str = "SQS";
  } else {
    client_notify_str = "SQC";
  }
  clientnotify(client_notify_str);
  level notify("zombie_sidequest_completed", id);
  level.zombie_sidequest_previously_completed[id] = true;
  if(level.systemLink) {
    return;
  }
  if(GetDvarInt(#"splitscreen_playerCount") == GetPlayers().size) {
    return;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(level.zombie_sidequest_solo_stat[id])) {
      players[i] zombieStatSet(level.zombie_sidequest_solo_stat[id], (players[i] zombieStatGet(level.zombie_sidequest_solo_stat[id]) + 1));
    }
    if(!flag("solo_game") && isDefined(level.zombie_sidequest_coop_stat[id])) {
      players[i] zombieStatSet(level.zombie_sidequest_coop_stat[id], (players[i] zombieStatGet(level.zombie_sidequest_coop_stat[id]) + 1));
    }
  }
}