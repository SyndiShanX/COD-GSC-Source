/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_puppeteer_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm_attackables;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_bgb_token;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_bot;
#using scripts\zm\_zm_daily_challenges;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_ffotd;
#using scripts\zm\_zm_game_module;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_player;
#using scripts\zm\_zm_powerup_bonus_points_player;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_timer;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\aats\_zm_aat_blast_furnace;
#using scripts\zm\aats\_zm_aat_dead_wire;
#using scripts\zm\aats\_zm_aat_fire_works;
#using scripts\zm\aats\_zm_aat_thunder_wall;
#using scripts\zm\aats\_zm_aat_turned;
#using scripts\zm\bgbs\_zm_bgb_aftertaste;
#using scripts\zm\bgbs\_zm_bgb_alchemical_antithesis;
#using scripts\zm\bgbs\_zm_bgb_always_done_swiftly;
#using scripts\zm\bgbs\_zm_bgb_anywhere_but_here;
#using scripts\zm\bgbs\_zm_bgb_armamental_accomplishment;
#using scripts\zm\bgbs\_zm_bgb_arms_grace;
#using scripts\zm\bgbs\_zm_bgb_arsenal_accelerator;
#using scripts\zm\bgbs\_zm_bgb_board_games;
#using scripts\zm\bgbs\_zm_bgb_board_to_death;
#using scripts\zm\bgbs\_zm_bgb_bullet_boost;
#using scripts\zm\bgbs\_zm_bgb_burned_out;
#using scripts\zm\bgbs\_zm_bgb_cache_back;
#using scripts\zm\bgbs\_zm_bgb_coagulant;
#using scripts\zm\bgbs\_zm_bgb_crate_power;
#using scripts\zm\bgbs\_zm_bgb_crawl_space;
#using scripts\zm\bgbs\_zm_bgb_danger_closest;
#using scripts\zm\bgbs\_zm_bgb_dead_of_nuclear_winter;
#using scripts\zm\bgbs\_zm_bgb_disorderly_combat;
#using scripts\zm\bgbs\_zm_bgb_ephemeral_enhancement;
#using scripts\zm\bgbs\_zm_bgb_extra_credit;
#using scripts\zm\bgbs\_zm_bgb_eye_candy;
#using scripts\zm\bgbs\_zm_bgb_fatal_contraption;
#using scripts\zm\bgbs\_zm_bgb_fear_in_headlights;
#using scripts\zm\bgbs\_zm_bgb_firing_on_all_cylinders;
#using scripts\zm\bgbs\_zm_bgb_flavor_hexed;
#using scripts\zm\bgbs\_zm_bgb_head_drama;
#using scripts\zm\bgbs\_zm_bgb_idle_eyes;
#using scripts\zm\bgbs\_zm_bgb_im_feelin_lucky;
#using scripts\zm\bgbs\_zm_bgb_immolation_liquidation;
#using scripts\zm\bgbs\_zm_bgb_impatient;
#using scripts\zm\bgbs\_zm_bgb_in_plain_sight;
#using scripts\zm\bgbs\_zm_bgb_kill_joy;
#using scripts\zm\bgbs\_zm_bgb_killing_time;
#using scripts\zm\bgbs\_zm_bgb_licensed_contractor;
#using scripts\zm\bgbs\_zm_bgb_lucky_crit;
#using scripts\zm\bgbs\_zm_bgb_mind_blown;
#using scripts\zm\bgbs\_zm_bgb_near_death_experience;
#using scripts\zm\bgbs\_zm_bgb_newtonian_negation;
#using scripts\zm\bgbs\_zm_bgb_now_you_see_me;
#using scripts\zm\bgbs\_zm_bgb_on_the_house;
#using scripts\zm\bgbs\_zm_bgb_perkaholic;
#using scripts\zm\bgbs\_zm_bgb_phoenix_up;
#using scripts\zm\bgbs\_zm_bgb_pop_shocks;
#using scripts\zm\bgbs\_zm_bgb_power_vacuum;
#using scripts\zm\bgbs\_zm_bgb_profit_sharing;
#using scripts\zm\bgbs\_zm_bgb_projectile_vomiting;
#using scripts\zm\bgbs\_zm_bgb_reign_drops;
#using scripts\zm\bgbs\_zm_bgb_respin_cycle;
#using scripts\zm\bgbs\_zm_bgb_round_robbin;
#using scripts\zm\bgbs\_zm_bgb_secret_shopper;
#using scripts\zm\bgbs\_zm_bgb_self_medication;
#using scripts\zm\bgbs\_zm_bgb_shopping_free;
#using scripts\zm\bgbs\_zm_bgb_slaughter_slide;
#using scripts\zm\bgbs\_zm_bgb_soda_fountain;
#using scripts\zm\bgbs\_zm_bgb_stock_option;
#using scripts\zm\bgbs\_zm_bgb_sword_flay;
#using scripts\zm\bgbs\_zm_bgb_temporal_gift;
#using scripts\zm\bgbs\_zm_bgb_tone_death;
#using scripts\zm\bgbs\_zm_bgb_unbearable;
#using scripts\zm\bgbs\_zm_bgb_undead_man_walking;
#using scripts\zm\bgbs\_zm_bgb_unquenchable;
#using scripts\zm\bgbs\_zm_bgb_wall_power;
#using scripts\zm\bgbs\_zm_bgb_whos_keeping_score;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\gametypes\_globallogic;
#using scripts\zm\gametypes\_globallogic_player;
#using scripts\zm\gametypes\_globallogic_spawn;
#using scripts\zm\gametypes\_globallogic_vehicle;
#using scripts\zm\gametypes\_weapons;
#using scripts\zm\gametypes\_zm_gametype;
#namespace zm;

function autoexec ignore_systems() {
  system::ignore("gadget_clone");
  system::ignore("gadget_armor");
  system::ignore("gadget_heat_wave");
  system::ignore("gadget_resurrect");
  system::ignore("gadget_shock_field");
  system::ignore("gadget_active_camo");
  system::ignore("gadget_mrpukey");
  system::ignore("gadget_misdirection");
  system::ignore("gadget_smokescreen");
  system::ignore("gadget_firefly_swarm");
  system::ignore("gadget_immolation");
  system::ignore("gadget_forced_malfunction");
  system::ignore("gadget_sensory_overload");
  system::ignore("gadget_rapid_strike");
  system::ignore("gadget_unstoppable_force");
  system::ignore("gadget_overdrive");
  system::ignore("gadget_concussive_wave");
  system::ignore("gadget_ravage_core");
  system::ignore("gadget_es_strike");
  system::ignore("gadget_cacophany");
  system::ignore("gadget_iff_override");
  system::ignore("gadget_security_breach");
  system::ignore("gadget_surge");
  system::ignore("gadget_exo_breakdown");
  system::ignore("gadget_servo_shortout");
  system::ignore("gadget_system_overload");
  system::ignore("gadget_cleanse");
  system::ignore("gadget_flashback");
  system::ignore("gadget_combat_efficiency");
  system::ignore("gadget_other");
  system::ignore("gadget_camo");
  system::ignore("gadget_vision_pulse");
  system::ignore("gadget_speed_burst");
  system::ignore("gadget_thief");
  system::ignore("replay_gun");
  system::ignore("spike_charge_siegebot");
  system::ignore("siegebot");
  system::ignore("amws");
}

function autoexec __init__sytem__() {
  system::register("zm", &__init__, undefined, undefined);
}

function __init__() {
  if(!isDefined(level.zombie_vars)) {
    level.zombie_vars = [];
  }
}

function init() {
  setDvar("doublejump_enabled", 0);
  setDvar("juke_enabled", 0);
  setDvar("playerEnergy_enabled", 0);
  setDvar("wallrun_enabled", 0);
  setDvar("sprintLeap_enabled", 0);
  setDvar("traverse_mode", 2);
  setDvar("weaponrest_enabled", 0);
  setDvar("ui_allowDisplayContinue", 1);
  if(!isDefined(level.killstreakweapons)) {
    level.killstreakweapons = [];
  }
  level.weaponnone = getweapon("none");
  level.weaponnull = getweapon("weapon_null");
  level.weaponbasemelee = getweapon("knife");
  level.weaponbasemeleeheld = getweapon("knife_held");
  level.weaponballisticknife = getweapon("knife_ballistic");
  if(!isDefined(level.weaponriotshield)) {
    level.weaponriotshield = getweapon("riotshield");
  }
  level.weaponrevivetool = getweapon("syrette");
  level.weaponzmdeaththroe = getweapon("death_throe");
  level.weaponzmfists = getweapon("zombie_fists");
  if(!isDefined(level.givecustomloadout)) {
    level.givecustomloadout = &zm_weapons::give_start_weapons;
  }
  level.projectiles_should_ignore_world_pause = 1;
  level.player_out_of_playable_area_monitor = 1;
  level.player_too_many_weapons_monitor = 1;
  level.player_too_many_weapons_monitor_func = &player_too_many_weapons_monitor;
  level.player_too_many_players_check = 1;
  level.player_too_many_players_check_func = &player_too_many_players_check;
  level._use_choke_weapon_hints = 1;
  level._use_choke_blockers = 1;
  level.speed_change_round = 15;
  level.passed_introscreen = 0;
  if(!isDefined(level.custom_ai_type)) {
    level.custom_ai_type = [];
  }
  level.custom_ai_spawn_check_funcs = [];
  level thread zm_ffotd::main_start();
  level.zombiemode = 1;
  level.revivefeature = 0;
  level.swimmingfeature = 0;
  level.calc_closest_player_using_paths = 0;
  level.zombie_melee_in_water = 1;
  level.put_timed_out_zombies_back_in_queue = 1;
  level.use_alternate_poi_positioning = 1;
  level.zmb_laugh_alias = "zmb_laugh_child";
  level.sndannouncerisrich = 1;
  level.scr_zm_ui_gametype = getdvarstring("ui_gametype");
  level.scr_zm_ui_gametype_group = "";
  level.scr_zm_map_start_location = "";
  level.curr_gametype_affects_rank = 0;
  gametype = tolower(getdvarstring("g_gametype"));
  if("zclassic" == gametype || "zstandard" == gametype) {
    level.curr_gametype_affects_rank = 1;
  }
  level.grenade_multiattack_bookmark_count = 1;
  demo::initactorbookmarkparams(3, 6000, 6000);
  if(!isDefined(level._zombies_round_spawn_failsafe)) {
    level._zombies_round_spawn_failsafe = &zombie_utility::round_spawn_failsafe;
  }
  level.func_get_zombie_spawn_delay = &get_zombie_spawn_delay;
  level.func_get_delay_between_rounds = &get_delay_between_rounds;
  level.zombie_visionset = "zombie_neutral";
  level.wait_and_revive = 0;
  if(getdvarstring("anim_intro") == "1") {
    level.zombie_anim_intro = 1;
  } else {
    level.zombie_anim_intro = 0;
  }
  precache_models();
  precache_zombie_leaderboards();
  level._zombie_gib_piece_index_all = 0;
  level._zombie_gib_piece_index_right_arm = 1;
  level._zombie_gib_piece_index_left_arm = 2;
  level._zombie_gib_piece_index_right_leg = 3;
  level._zombie_gib_piece_index_left_leg = 4;
  level._zombie_gib_piece_index_head = 5;
  level._zombie_gib_piece_index_guts = 6;
  level._zombie_gib_piece_index_hat = 7;
  if(!isDefined(level.zombie_ai_limit)) {
    level.zombie_ai_limit = 24;
  }
  if(!isDefined(level.zombie_actor_limit)) {
    level.zombie_actor_limit = 31;
  }
  init_flags();
  init_dvars();
  init_strings();
  init_levelvars();
  init_sounds();
  init_shellshocks();
  init_client_field_callback_funcs();
  zm_utility::register_offhand_weapons_for_level_defaults();
  level thread drive_client_connected_notifies();
  zm_craftables::init();
  zm_perks::init();
  zm_powerups::init();
  zm_spawner::init();
  zm_weapons::init();
  level.zombie_poi_array = getEntArray("zombie_poi", "script_noteworthy");
  init_function_overrides();
  level thread last_stand_pistol_rank_init();
  level thread post_all_players_connected();
  level start_zm_dash_counter_watchers();
  zm_utility::init_utility();
  util::registerclientsys("lsm");
  initializestattracking();
  if(getplayers().size <= 1) {
    incrementcounter("global_solo_games", 1);
  } else {
    if(isDefined(level.systemlink) && level.systemlink) {
      incrementcounter("global_systemlink_games", 1);
    } else {
      if(getdvarint("splitscreen_playerCount") == getplayers().size) {
        incrementcounter("global_splitscreen_games", 1);
      } else {
        incrementcounter("global_coop_games", 1);
      }
    }
  }
  callback::on_connect(&zm_on_player_connect);
  zm_utility::set_demo_intermission_point();
  level thread zm_ffotd::main_end();
  level thread zm_utility::track_players_intersection_tracker();
  level thread onallplayersready();
  level thread startunitriggers();
  level thread function_83b0d780();
  callback::on_spawned(&zm_on_player_spawned);
  printhashids();
}

function post_main() {
  level thread init_custom_ai_type();
}

function cheat_enabled(val) {
  if(getdvarint("zombie_cheat") >= val) {
    return true;
  }
  return false;
}

function function_83b0d780() {
  level flag::wait_till_any(array("start_zombie_round_logic", "start_encounters_match_logic"));
  while(true) {
    var_82d7c36d = get_round_number();
    level.round_number = undefined;
    var_fa2cbc15 = var_82d7c36d;
    switch (randomint(5)) {
      case 0: {
        var_d42a41ac = var_82d7c36d;
      }
      case 1: {
        var_ae27c743 = var_82d7c36d;
      }
      case 2: {
        var_88254cda = var_82d7c36d;
      }
      case 3: {
        var_6222d271 = var_82d7c36d;
      }
      case 4: {
        var_3c205808 = var_82d7c36d;
      }
    }
    level.round_number = var_82d7c36d;
    var_82d7c36d = undefined;
    var_202f367e = undefined;
    var_fa2cbc15 = undefined;
    var_d42a41ac = undefined;
    var_ae27c743 = undefined;
    var_88254cda = undefined;
    var_6222d271 = undefined;
    var_3c205808 = undefined;
    wait(0.05);
  }
}

function set_round_number(new_round) {
  if(new_round > 255) {
    new_round = 255;
  }
  world.roundnumber = new_round ^ 115;
}

function get_round_number() {
  return world.roundnumber ^ 115;
}

function startunitriggers() {
  level flag::wait_till_any(array("start_zombie_round_logic", "start_encounters_match_logic"));
  level thread zm_unitrigger::main();
}

function drive_client_connected_notifies() {
  while(true) {
    level waittill("connected", player);
    player demo::reset_actor_bookmark_kill_times();
    player callback::callback("hash_eaffea17");
  }
}

function fade_out_intro_screen_zm(hold_black_time, fade_out_time, destroyed_afterwards) {
  lui::screen_fade_out(0, undefined);
  if(isDefined(hold_black_time)) {
    wait(hold_black_time);
  } else {
    wait(0.2);
  }
  if(!isDefined(fade_out_time)) {
    fade_out_time = 1.5;
  }
  array::thread_all(getplayers(), &initialblackend);
  level clientfield::set("sndZMBFadeIn", 1);
  lui::screen_fade_in(fade_out_time, undefined);
  wait(1.6);
  level.passed_introscreen = 1;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(level.customhudreveal)) {
      players[i] thread[[level.customhudreveal]]();
    } else {
      players[i] showhudandplaypromo();
    }
    if(!(isDefined(level.host_ended_game) && level.host_ended_game)) {
      if(isDefined(level.player_movement_suppressed)) {
        players[i] freezecontrols(level.player_movement_suppressed);
        println("");
        continue;
      }
      if(!(isDefined(players[i].hostmigrationcontrolsfrozen) && players[i].hostmigrationcontrolsfrozen)) {
        players[i] freezecontrols(0);
        println("");
      }
    }
  }
  level flag::set("initial_blackscreen_passed");
  level clientfield::set("gameplay_started", 1);
}

function showhudandplaypromo() {
  self setclientuivisibilityflag("hud_visible", 1);
  self setclientuivisibilityflag("weapon_hud_visible", 1);
  if(!(isDefined(self.seen_promo_anim) && self.seen_promo_anim) && sessionmodeisonlinegame()) {
    self luinotifyevent(&"play_promo_anim", 0);
    self.seen_promo_anim = 1;
  }
}

function onallplayersready() {
  timeout = gettime() + 5000;
  while(isloadingcinematicplaying() || (getnumexpectedplayers() == 0 && gettime() < timeout)) {
    wait(0.1);
  }
  println("" + getnumexpectedplayers());
  player_count_actual = 0;
  while(getnumconnectedplayers() < getnumexpectedplayers() || player_count_actual != getnumexpectedplayers()) {
    players = getplayers();
    player_count_actual = 0;
    for(i = 0; i < players.size; i++) {
      players[i] freezecontrols(1);
      if(players[i].sessionstate == "playing") {
        player_count_actual++;
      }
    }
    println((("" + getnumconnectedplayers()) + "") + getnumexpectedplayers());
    wait(0.1);
  }
  setinitialplayersconnected();
  level flag::set("all_players_connected");
  setDvar("all_players_are_connected", "1");
  println("");
  if(1 == getnumconnectedplayers() && getdvarint("scr_zm_enable_bots") == 1) {
    level thread add_bots();
    level flag::set("initial_players_connected");
  } else {
    players = getplayers();
    if(players.size == 1) {
      level flag::set("solo_game");
      level.solo_lives_given = 0;
      foreach(player in players) {
        player.lives = 0;
      }
      level set_default_laststand_pistol(1);
    }
    level flag::set("initial_players_connected");
    array::thread_all(getplayers(), &initialblack);
    while(!aretexturesloaded()) {
      wait(0.05);
    }
    if(isDefined(level.added_initial_streamer_blackscreen)) {
      wait(level.added_initial_streamer_blackscreen);
    }
    thread start_zombie_logic_in_x_sec(3);
  }
  set_intermission_point();
  n_black_screen = 5;
  level thread fade_out_intro_screen_zm(n_black_screen, 1.5, 1);
  wait(n_black_screen);
  level.n_gameplay_start_time = gettime();
  clientfield::set("game_start_time", level.n_gameplay_start_time);
}

function initialblack() {
  self closemenu("InitialBlack");
  self openmenu("InitialBlack");
}

function initialblackend() {
  self closemenu("InitialBlack");
}

function start_zombie_logic_in_x_sec(time_to_wait) {
  wait(time_to_wait);
  level flag::set("start_zombie_round_logic");
}

function getallotherplayers() {
  aliveplayers = [];
  for(i = 0; i < level.players.size; i++) {
    if(!isDefined(level.players[i])) {
      continue;
    }
    player = level.players[i];
    if(player.sessionstate != "playing" || player == self) {
      continue;
    }
    aliveplayers[aliveplayers.size] = player;
  }
  return aliveplayers;
}

function updateplayernum(player) {
  if(!isDefined(player.playernum)) {
    if(player.team == "allies") {
      player.playernum = zm_utility::get_game_var("_team1_num");
      zm_utility::set_game_var("_team1_num", player.playernum + 1);
    } else {
      player.playernum = zm_utility::get_game_var("_team2_num");
      zm_utility::set_game_var("_team2_num", player.playernum + 1);
    }
  }
}

function getfreespawnpoint(spawnpoints, player) {
  if(!isDefined(spawnpoints)) {
    iprintlnbold("");
    return undefined;
  }
  if(!isDefined(game["spawns_randomized"])) {
    game["spawns_randomized"] = 1;
    spawnpoints = array::randomize(spawnpoints);
    random_chance = randomint(100);
    if(random_chance > 50) {
      zm_utility::set_game_var("side_selection", 1);
    } else {
      zm_utility::set_game_var("side_selection", 2);
    }
  }
  side_selection = zm_utility::get_game_var("side_selection");
  if(zm_utility::get_game_var("switchedsides")) {
    if(side_selection == 2) {
      side_selection = 1;
    } else if(side_selection == 1) {
      side_selection = 2;
    }
  }
  if(isDefined(player) && isDefined(player.team)) {
    i = 0;
    while(isDefined(spawnpoints) && i < spawnpoints.size) {
      if(side_selection == 1) {
        if(player.team != "allies" && (isDefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 1)) {
          arrayremovevalue(spawnpoints, spawnpoints[i]);
          i = 0;
        } else {
          if(player.team == "allies" && (isDefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 2)) {
            arrayremovevalue(spawnpoints, spawnpoints[i]);
            i = 0;
          } else {
            i++;
          }
        }
      } else {
        if(player.team == "allies" && (isDefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 1)) {
          arrayremovevalue(spawnpoints, spawnpoints[i]);
          i = 0;
        } else {
          if(player.team != "allies" && (isDefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 2)) {
            arrayremovevalue(spawnpoints, spawnpoints[i]);
            i = 0;
          } else {
            i++;
          }
        }
      }
    }
  }
  updateplayernum(player);
  for(j = 0; j < spawnpoints.size; j++) {
    if(!isDefined(spawnpoints[j].en_num)) {
      for(m = 0; m < spawnpoints.size; m++) {
        spawnpoints[m].en_num = m;
      }
    }
    if(spawnpoints[j].en_num == player.playernum) {
      return spawnpoints[j];
    }
  }
  return spawnpoints[0];
}

function delete_in_createfx() {
  exterior_goals = struct::get_array("exterior_goal", "targetname");
  for(i = 0; i < exterior_goals.size; i++) {
    if(!isDefined(exterior_goals[i].target)) {
      continue;
    }
    targets = getEntArray(exterior_goals[i].target, "targetname");
    for(j = 0; j < targets.size; j++) {
      targets[j] zm_utility::self_delete();
    }
  }
  if(isDefined(level.level_createfx_callback_thread)) {
    level thread[[level.level_createfx_callback_thread]]();
  }
}

function add_bots() {
  host = util::gethostplayer();
  while(!isDefined(host)) {
    wait(0.05);
    host = util::gethostplayer();
  }
  wait(4);
  zbot_spawn();
  setDvar("bot_AllowMovement", "1");
  setDvar("bot_PressAttackBtn", "1");
  setDvar("bot_PressMeleeBtn", "1");
  while(getplayers().size < 2) {
    wait(0.05);
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(0);
    println("");
  }
  level.numberbotsadded = 1;
  level flag::set("start_zombie_round_logic");
}

function zbot_spawn() {
  player = util::gethostplayer();
  bot = addtestclient();
  if(!isDefined(bot)) {
    println("");
    return;
  }
  spawnpoint = bot zm_gametype::onfindvalidspawnpoint();
  bot.pers["isBot"] = 1;
  bot.equipment_enabled = 0;
  yaw = spawnpoint.angles[1];
  return bot;
}

function post_all_players_connected() {
  level thread end_game();
  level flag::wait_till("start_zombie_round_logic");
  zm_utility::increment_zm_dash_counter("start_per_game", 1);
  zm_utility::increment_zm_dash_counter("start_per_player", level.players.size);
  zm_utility::upload_zm_dash_counters();
  level.dash_counter_start_player_count = level.players.size;
  println("", level.script, "", getplayers().size);
  level thread round_end_monitor();
  if(!level.zombie_anim_intro) {
    if(isDefined(level._round_start_func)) {
      level thread[[level._round_start_func]]();
    }
  }
  level thread players_playing();
  disablegrenadesuicide();
  level.startinvulnerabletime = getdvarint("player_deathInvulnerableTime");
}

function start_zm_dash_counter_watchers() {
  level thread first_consumables_used_watcher();
  level thread players_reached_rounds_counter_watcher();
}

function first_consumables_used_watcher() {
  level flag::init("first_consumables_used");
  level flag::wait_till("first_consumables_used");
  zm_utility::increment_zm_dash_counter("first_consumables_used", 1);
  zm_utility::upload_zm_dash_counters();
}

function players_reached_rounds_counter_watcher() {
  while(true) {
    level waittill("start_of_round");
    if(!isDefined(level.dash_counter_round_reached_5) && level.round_number >= 5) {
      level.dash_counter_round_reached_5 = 1;
      zm_utility::increment_zm_dash_counter("reached_5", 1);
    }
    if(!isDefined(level.dash_counter_round_reached_10) && level.round_number >= 10) {
      level.dash_counter_round_reached_10 = 1;
      zm_utility::increment_zm_dash_counter("reached_10", 1);
      return;
    }
  }
}

function init_custom_ai_type() {
  if(isDefined(level.custom_ai_type)) {
    for(i = 0; i < level.custom_ai_type.size; i++) {
      [[level.custom_ai_type[i]]]();
    }
  }
}

function zombiemode_melee_miss() {
  if(isDefined(self.enemy.curr_pay_turret)) {
    self.enemy dodamage(getdvarint("ai_meleeDamage"), self.origin, self, self, "none", "melee");
  }
}

function player_track_ammo_count() {
  self notify("stop_ammo_tracking");
  self endon("disconnect");
  self endon("stop_ammo_tracking");
  ammolowcount = 0;
  ammooutcount = 0;
  while(true) {
    wait(0.5);
    weapon = self getcurrentweapon();
    if(weapon == level.weaponnone || weapon.skiplowammovox) {
      continue;
    }
    if(weapon.type == "grenade") {
      continue;
    }
    if(self getammocount(weapon) > 5 || self laststand::player_is_in_laststand()) {
      ammooutcount = 0;
      ammolowcount = 0;
      continue;
    }
    if(self getammocount(weapon) > 0) {
      if(ammolowcount < 1) {
        self zm_audio::create_and_play_dialog("general", "ammo_low");
        ammolowcount++;
      }
    } else if(ammooutcount < 1) {
      wait(0.5);
      if(self getcurrentweapon() !== weapon) {
        continue;
      }
      self zm_audio::create_and_play_dialog("general", "ammo_out");
      ammooutcount++;
    }
    wait(20);
  }
}

function spawn_vo() {
  wait(1);
  players = getplayers();
  if(players.size > 1) {
    player = array::random(players);
    index = zm_utility::get_player_index(player);
    player thread spawn_vo_player(index, players.size);
  }
}

function spawn_vo_player(index, num) {
  sound = ((("plr_" + index) + "_vox_") + num) + "play";
  self playsoundwithnotify(sound, "sound_done");
  self waittill("sound_done");
}

function precache_models() {
  if(isDefined(level.precachecustomcharacters)) {
    self[[level.precachecustomcharacters]]();
  }
}

function init_shellshocks() {
  level.player_killed_shellshock = "zombie_death";
}

function init_strings() {
  zm_utility::add_zombie_hint("undefined", &"ZOMBIE_UNDEFINED");
  zm_utility::add_zombie_hint("default_treasure_chest", &"ZOMBIE_RANDOM_WEAPON_COST");
  zm_utility::add_zombie_hint("default_buy_barrier_piece_10", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_10");
  zm_utility::add_zombie_hint("default_buy_barrier_piece_20", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_20");
  zm_utility::add_zombie_hint("default_buy_barrier_piece_50", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_50");
  zm_utility::add_zombie_hint("default_buy_barrier_piece_100", &"ZOMBIE_BUTTON_BUY_BACK_BARRIER_100");
  zm_utility::add_zombie_hint("default_reward_barrier_piece", &"ZOMBIE_BUTTON_REWARD_BARRIER");
  zm_utility::add_zombie_hint("default_buy_area", &"ZOMBIE_BUTTON_BUY_OPEN_AREA_COST");
}

function init_sounds() {
  zm_utility::add_sound("end_of_round", "mus_zmb_round_over");
  zm_utility::add_sound("end_of_game", "mus_zmb_game_over");
  zm_utility::add_sound("chalk_one_up", "mus_zmb_chalk");
  zm_utility::add_sound("purchase", "zmb_cha_ching");
  zm_utility::add_sound("no_purchase", "zmb_no_cha_ching");
  zm_utility::add_sound("playerzombie_usebutton_sound", "zmb_zombie_vocals_attack");
  zm_utility::add_sound("playerzombie_attackbutton_sound", "zmb_zombie_vocals_attack");
  zm_utility::add_sound("playerzombie_adsbutton_sound", "zmb_zombie_vocals_attack");
  zm_utility::add_sound("zombie_head_gib", "zmb_zombie_head_gib");
  zm_utility::add_sound("rebuild_barrier_piece", "zmb_repair_boards");
  zm_utility::add_sound("rebuild_barrier_metal_piece", "zmb_metal_repair");
  zm_utility::add_sound("rebuild_barrier_hover", "zmb_boards_float");
  zm_utility::add_sound("debris_hover_loop", "zmb_couch_loop");
  zm_utility::add_sound("break_barrier_piece", "zmb_break_boards");
  zm_utility::add_sound("grab_metal_bar", "zmb_bar_pull");
  zm_utility::add_sound("break_metal_bar", "zmb_bar_break");
  zm_utility::add_sound("drop_metal_bar", "zmb_bar_drop");
  zm_utility::add_sound("blocker_end_move", "zmb_board_slam");
  zm_utility::add_sound("barrier_rebuild_slam", "zmb_board_slam");
  zm_utility::add_sound("bar_rebuild_slam", "zmb_bar_repair");
  zm_utility::add_sound("zmb_rock_fix", "zmb_break_rock_barrier_fix");
  zm_utility::add_sound("zmb_vent_fix", "evt_vent_slat_repair");
  zm_utility::add_sound("zmb_barrier_debris_move", "zmb_barrier_debris_move");
  zm_utility::add_sound("door_slide_open", "zmb_door_slide_open");
  zm_utility::add_sound("door_rotate_open", "zmb_door_slide_open");
  zm_utility::add_sound("debris_move", "zmb_weap_wall");
  zm_utility::add_sound("open_chest", "zmb_lid_open");
  zm_utility::add_sound("music_chest", "zmb_music_box");
  zm_utility::add_sound("close_chest", "zmb_lid_close");
  zm_utility::add_sound("weapon_show", "zmb_weap_wall");
  zm_utility::add_sound("break_stone", "evt_break_stone");
}

function init_levelvars() {
  level.is_zombie_level = 1;
  level.default_laststandpistol = getweapon("pistol_standard");
  level.default_solo_laststandpistol = getweapon("pistol_standard_upgraded");
  level.super_ee_weapon = getweapon("pistol_burst");
  level.laststandpistol = level.default_laststandpistol;
  level.start_weapon = level.default_laststandpistol;
  level.first_round = 1;
  level.start_round = getgametypesetting("startRound");
  level.round_number = level.start_round;
  level.enable_magic = getgametypesetting("magic");
  level.headshots_only = getgametypesetting("headshotsonly");
  level.player_starting_points = level.round_number * 500;
  level.round_start_time = 0;
  level.pro_tips_start_time = 0;
  level.intermission = 0;
  level.dog_intermission = 0;
  level.zombie_total = 0;
  level.zombie_respawns = 0;
  level.total_zombies_killed = 0;
  level.hudelem_count = 0;
  level.zm_loc_types = [];
  level.zm_loc_types["zombie_location"] = [];
  level.zm_variant_type_max = [];
  level.zm_variant_type_max["walk"] = [];
  level.zm_variant_type_max["run"] = [];
  level.zm_variant_type_max["sprint"] = [];
  level.zm_variant_type_max["super_sprint"] = [];
  level.zm_variant_type_max["walk"]["down"] = 14;
  level.zm_variant_type_max["walk"]["up"] = 16;
  level.zm_variant_type_max["run"]["down"] = 13;
  level.zm_variant_type_max["run"]["up"] = 12;
  level.zm_variant_type_max["sprint"]["down"] = 9;
  level.zm_variant_type_max["sprint"]["up"] = 8;
  level.zm_variant_type_max["super_sprint"]["down"] = 1;
  level.zm_variant_type_max["super_sprint"]["up"] = 1;
  level.zm_variant_type_max["burned"]["down"] = 1;
  level.zm_variant_type_max["burned"]["up"] = 1;
  level.zm_variant_type_max["jump_pad_super_sprint"]["down"] = 1;
  level.zm_variant_type_max["jump_pad_super_sprint"]["up"] = 1;
  level.current_zombie_array = [];
  level.current_zombie_count = 0;
  level.zombie_total_subtract = 0;
  level.destructible_callbacks = [];
  foreach(team in level.teams) {
    if(!isDefined(level.zombie_vars[team])) {
      level.zombie_vars[team] = [];
    }
  }
  difficulty = 1;
  column = int(difficulty) + 1;
  zombie_utility::set_zombie_var("zombie_health_increase", 100, 0, column);
  zombie_utility::set_zombie_var("zombie_health_increase_multiplier", 0.1, 1, column);
  zombie_utility::set_zombie_var("zombie_health_start", 150, 0, column);
  zombie_utility::set_zombie_var("zombie_spawn_delay", 2, 1, column);
  zombie_utility::set_zombie_var("zombie_new_runner_interval", 10, 0, column);
  zombie_utility::set_zombie_var("zombie_move_speed_multiplier", 4, 0, column);
  zombie_utility::set_zombie_var("zombie_move_speed_multiplier_easy", 2, 0, column);
  zombie_utility::set_zombie_var("zombie_max_ai", 24, 0, column);
  zombie_utility::set_zombie_var("zombie_ai_per_player", 6, 0, column);
  zombie_utility::set_zombie_var("below_world_check", -1000);
  zombie_utility::set_zombie_var("spectators_respawn", 1);
  zombie_utility::set_zombie_var("zombie_use_failsafe", 1);
  zombie_utility::set_zombie_var("zombie_between_round_time", 10);
  zombie_utility::set_zombie_var("zombie_intermission_time", 15);
  zombie_utility::set_zombie_var("game_start_delay", 0, 0, column);
  zombie_utility::set_zombie_var("player_base_health", 100);
  zombie_utility::set_zombie_var("penalty_no_revive", 0.1, 1, column);
  zombie_utility::set_zombie_var("penalty_died", 0, 1, column);
  zombie_utility::set_zombie_var("penalty_downed", 0.05, 1, column);
  zombie_utility::set_zombie_var("zombie_score_kill_4player", 50);
  zombie_utility::set_zombie_var("zombie_score_kill_3player", 50);
  zombie_utility::set_zombie_var("zombie_score_kill_2player", 50);
  zombie_utility::set_zombie_var("zombie_score_kill_1player", 50);
  zombie_utility::set_zombie_var("zombie_score_damage_normal", 10);
  zombie_utility::set_zombie_var("zombie_score_damage_light", 10);
  zombie_utility::set_zombie_var("zombie_score_bonus_melee", 80);
  zombie_utility::set_zombie_var("zombie_score_bonus_head", 50);
  zombie_utility::set_zombie_var("zombie_score_bonus_neck", 20);
  zombie_utility::set_zombie_var("zombie_score_bonus_torso", 10);
  zombie_utility::set_zombie_var("zombie_score_bonus_burn", 10);
  zombie_utility::set_zombie_var("zombie_flame_dmg_point_delay", 500);
  zombie_utility::set_zombie_var("zombify_player", 0);
  if(issplitscreen()) {
    zombie_utility::set_zombie_var("zombie_timer_offset", 280);
  }
  level thread init_player_levelvars();
  level.gamedifficulty = getgametypesetting("zmDifficulty");
  if(level.gamedifficulty == 0) {
    level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
  } else {
    level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
  }
  if(level.round_number == 1) {
    level.zombie_move_speed = 1;
  }
  level.speed_change_max = 0;
  level.speed_change_num = 0;
  set_round_number(level.round_number);
}

function init_player_levelvars() {
  level flag::wait_till("start_zombie_round_logic");
  difficulty = 1;
  column = int(difficulty) + 1;
  for(i = 0; i < 8; i++) {
    points = 500;
    if(i > 3) {
      points = 3000;
    }
    points = zombie_utility::set_zombie_var(("zombie_score_start_" + (i + 1)) + "p", points, 0, column);
  }
}

function init_dvars() {
  if(getdvarstring("zombie_debug") == "") {
    setDvar("zombie_debug", "0");
  }
  if(getdvarstring("scr_zm_enable_bots") == "") {
    setDvar("scr_zm_enable_bots", "0");
  }
  if(getdvarstring("zombie_cheat") == "") {
    setDvar("zombie_cheat", "0");
  }
  if(getdvarstring("zombiemode_debug_zombie_count") == "") {
    setDvar("zombiemode_debug_zombie_count", "0");
  }
  if(level.script != "zombie_cod5_prototype") {
    setDvar("magic_chest_movable", "1");
  }
  setDvar("revive_trigger_radius", "75");
  setDvar("scr_deleteexplosivesonspawn", "0");
}

function init_function_overrides() {
  level.callbackplayerdamage = &callback_playerdamage;
  level.overrideplayerdamage = &player_damage_override;
  level.callbackplayerkilled = &player_killed_override;
  level.playerlaststand_func = &player_laststand;
  level.callbackplayerlaststand = &callback_playerlaststand;
  level.prevent_player_damage = &player_prevent_damage;
  level.callbackactorkilled = &actor_killed_override;
  level.callbackactordamage = &actor_damage_override_wrapper;
  level.callbackvehicledamage = &vehicle_damage_override;
  level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
  level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
  level.custom_introscreen = &zombie_intro_screen;
  level.custom_intermission = &player_intermission;
  level.global_damage_func = &zm_spawner::zombie_damage;
  level.global_damage_func_ads = &zm_spawner::zombie_damage_ads;
  level.reset_clientdvars = &onplayerconnect_clientdvars;
  level.zombie_last_stand = &last_stand_pistol_swap;
  level.zombie_last_stand_pistol_memory = &last_stand_save_pistol_ammo;
  level.zombie_last_stand_ammo_return = &last_stand_restore_pistol_ammo;
  level.player_becomes_zombie = &zombify_player;
  level.validate_enemy_path_length = &zm_utility::default_validate_enemy_path_length;
}

function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self endon("disconnect");
  zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
}

function codecallback_destructibleevent(event, param1, param2, param3) {
  if(event == "broken") {
    notify_type = param1;
    attacker = param2;
    weapon = param3;
    if(isDefined(level.destructible_callbacks[notify_type])) {
      self thread[[level.destructible_callbacks[notify_type]]](notify_type, attacker);
    }
    self notify(event, notify_type, attacker);
  } else if(event == "breakafter") {
    piece = param1;
    time = param2;
    damage = param3;
    self thread breakafter(time, damage, piece);
  }
}

function breakafter(time, damage, piece) {
  self notify("breakafter");
  self endon("breakafter");
  wait(time);
  self dodamage(damage, self.origin, undefined, undefined);
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  startedinlaststand = 0;
  if(isPlayer(self)) {
    startedinlaststand = self laststand::player_is_in_laststand();
  }
  println(("" + idamage) + "");
  if(isDefined(eattacker) && isPlayer(eattacker) && eattacker.sessionteam == self.sessionteam && !eattacker hasperk("specialty_playeriszombie") && (!(isDefined(self.is_zombie) && self.is_zombie))) {
    self process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    if(self != eattacker) {
      println("");
      return;
    }
    if(smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_BURNED" && smeansofdeath != "MOD_SUICIDE") {
      println("");
      return;
    }
  }
  if(isDefined(level.pers_upgrade_insta_kill) && level.pers_upgrade_insta_kill) {
    self zm_pers_upgrades_functions::pers_insta_kill_melee_swipe(smeansofdeath, eattacker);
  }
  if(isDefined(self.overrideplayerdamage)) {
    idamage = self[[self.overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
  } else if(isDefined(level.overrideplayerdamage)) {
    idamage = self[[level.overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
  }
  assert(isDefined(idamage), "");
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    maxhealth = self.maxhealth;
    self.health = self.health + idamage;
    self.maxhealth = maxhealth;
  }
  if(isDefined(self.divetoprone) && self.divetoprone == 1) {
    if(smeansofdeath == "MOD_GRENADE_SPLASH") {
      dist = distance2d(vpoint, self.origin);
      if(dist > 32) {
        dot_product = vectordot(anglesToForward(self.angles), vdir);
        if(dot_product > 0) {
          idamage = int(idamage * 0.5);
        }
      }
    }
  }
  println("");
  if(isDefined(level.prevent_player_damage)) {
    if(self[[level.prevent_player_damage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)) {
      return;
    }
  }
  idflags = idflags | level.idflags_no_knockback;
  if(idamage > 0 && shitloc == "riotshield") {
    shitloc = "torso_upper";
  }
  println("");
  wasdowned = 0;
  if(isPlayer(self)) {
    wasdowned = !startedinlaststand && self laststand::player_is_in_laststand();
  }
  if(isDefined(eattacker)) {
    record3dtext((((("" + idamage) + "") + self.health) + "") + eattacker getentitynumber(), self.origin, (1, 0, 0), "", self);
  } else {
    record3dtext(((("" + idamage) + "") + self.health) + "", self.origin, (1, 0, 0), "", self);
  }
  self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, self.health <= 0, wasdowned);
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

function register_player_friendly_fire_callback(callback) {
  if(!isDefined(level.player_friendly_fire_callbacks)) {
    level.player_friendly_fire_callbacks = [];
  }
  level.player_friendly_fire_callbacks[level.player_friendly_fire_callbacks.size] = callback;
}

function process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isDefined(level.player_friendly_fire_callbacks)) {
    foreach(callback in level.player_friendly_fire_callbacks) {
      self[[callback]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
  }
}

function init_flags() {
  level flag::init("solo_game");
  level flag::init("start_zombie_round_logic");
  level flag::init("start_encounters_match_logic");
  level flag::init("spawn_point_override");
  level flag::init("crawler_round");
  level flag::init("spawn_zombies", 1);
  level flag::init("special_round");
  level flag::init("dog_round");
  level flag::init("raps_round");
  level flag::init("begin_spawning");
  level flag::init("end_round_wait");
  level flag::init("wait_and_revive");
  level flag::init("instant_revive");
  level flag::init("initial_blackscreen_passed");
  level flag::init("initial_players_connected");
  level flag::init("power_on");
  power_trigs = getEntArray("use_elec_switch", "targetname");
  foreach(trig in power_trigs) {
    if(isDefined(trig.script_int)) {
      level flag::init("power_on" + trig.script_int);
    }
  }
}

function init_client_field_callback_funcs() {
  clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
  if(isDefined(level.use_water_risers) && level.use_water_risers) {
    clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int");
  }
  if(isDefined(level.use_foliage_risers) && level.use_foliage_risers) {
    clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int");
  }
  if(isDefined(level.use_low_gravity_risers) && level.use_low_gravity_risers) {
    clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int");
  }
  clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
  clientfield::register("actor", "zombie_ragdoll_explode", 1, 1, "int");
  clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int");
  clientfield::register("actor", "sndZombieContext", -1, 1, "int");
  clientfield::register("actor", "zombie_keyline_render", 1, 1, "int");
  bits = 4;
  trigs = getEntArray("use_elec_switch", "targetname");
  if(isDefined(trigs)) {
    bits = getminbitcountfornum(trigs.size + 1);
  }
  clientfield::register("world", "zombie_power_on", 1, bits, "int");
  clientfield::register("world", "zombie_power_off", 1, bits, "int");
  clientfield::register("world", "round_complete_time", 1, 20, "int");
  clientfield::register("world", "round_complete_num", 1, 8, "int");
  clientfield::register("world", "game_end_time", 1, 20, "int");
  clientfield::register("world", "quest_complete_time", 1, 20, "int");
  clientfield::register("world", "game_start_time", 15001, 20, "int");
}

function init_fx() {
  level.createfx_callback_thread = &delete_in_createfx;
  level._effect["fx_zombie_bar_break"] = "_t6/maps/zombie/fx_zombie_bar_break";
  level._effect["fx_zombie_bar_break_lite"] = "_t6/maps/zombie/fx_zombie_bar_break_lite";
  if(!(isDefined(level.fx_exclude_edge_fog) && level.fx_exclude_edge_fog)) {
    level._effect["edge_fog"] = "_t6/maps/zombie/fx_fog_zombie_amb";
  }
  level._effect["chest_light"] = "zombie/fx_weapon_box_open_glow_zmb";
  level._effect["chest_light_closed"] = "zombie/fx_weapon_box_closed_glow_zmb";
  if(!(isDefined(level.fx_exclude_default_eye_glow) && level.fx_exclude_default_eye_glow)) {
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
  }
  level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
  level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
  level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
  if(!(isDefined(level.fx_exclude_tesla_head_light) && level.fx_exclude_tesla_head_light)) {
    level._effect["tesla_head_light"] = "_t6/maps/zombie/fx_zombie_tesla_neck_spurt";
  }
  level._effect["zombie_guts_explosion"] = "zombie/fx_blood_torso_explo_lg_zmb";
  level._effect["rise_burst_water"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect["rise_billow_water"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect["rise_dust_water"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
  level._effect["rise_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect["rise_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect["rise_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
  level._effect["fall_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect["fall_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect["fall_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
  level._effect["character_fire_death_sm"] = "zombie/fx_fire_torso_zmb";
  level._effect["character_fire_death_torso"] = "zombie/fx_fire_torso_zmb";
  if(!(isDefined(level.fx_exclude_default_explosion) && level.fx_exclude_default_explosion)) {
    level._effect["def_explosion"] = "_t6/explosions/fx_default_explosion";
  }
  if(!(isDefined(level.disable_fx_upgrade_aquired) && level.disable_fx_upgrade_aquired)) {
    level._effect["upgrade_aquired"] = "_t6/maps/zombie/fx_zmb_tanzit_upgrade";
  }
}

function zombie_intro_screen(string1, string2, string3, string4, string5) {
  level flag::wait_till("start_zombie_round_logic");
}

function players_playing() {
  players = getplayers();
  level.players_playing = players.size;
  wait(20);
  players = getplayers();
  level.players_playing = players.size;
}

function onplayerconnect_clientdvars() {
  self setclientcompass(0);
  self setclientthirdperson(0);
  self resetfov();
  self setclientthirdpersonangle(0);
  self setclientuivisibilityflag("weapon_hud_visible", 1);
  self setclientminiscoreboardhide(1);
  self setclienthudhardcore(0);
  self setclientplayerpushamount(1);
  self setdepthoffield(0, 0, 512, 4000, 4, 0);
  self zm_laststand::player_getup_setup();
}

function checkforalldead(excluded_player) {
  players = getplayers();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(isDefined(excluded_player) && excluded_player == players[i]) {
      continue;
    }
    if(!players[i] laststand::player_is_in_laststand() && !players[i].sessionstate == "spectator") {
      count++;
    }
  }
  if(count == 0 && (!(isDefined(level.no_end_game_check) && level.no_end_game_check))) {
    level notify("end_game");
  }
}

function onplayerspawned() {
  self endon("disconnect");
  self notify("stop_onplayerspawned");
  self endon("stop_onplayerspawned");
  for(;;) {
    self waittill("spawned_player");
    if(!(isDefined(level.host_ended_game) && level.host_ended_game)) {
      self freezecontrols(0);
      println("");
    }
    self.hits = 0;
    self zm_utility::init_player_offhand_weapons();
    lethal_grenade = self zm_utility::get_player_lethal_grenade();
    if(!self hasweapon(lethal_grenade)) {
      self giveweapon(lethal_grenade);
      self setweaponammoclip(lethal_grenade, 0);
    }
    self recordplayerrevivezombies(self);
    if(getdvarint("") >= 1 && getdvarint("") <= 3) {
      self enableinvulnerability();
    }
    self setactionslot(3, "altMode");
    self playerknockback(0);
    self setclientthirdperson(0);
    self resetfov();
    self setclientthirdpersonangle(0);
    self setdepthoffield(0, 0, 512, 4000, 4, 0);
    self cameraactivate(0);
    self.num_perks = 0;
    self.on_lander_last_stand = undefined;
    self setblur(0, 0.1);
    self.zmbdialogqueue = [];
    self.zmbdialogactive = 0;
    self.zmbdialoggroups = [];
    self.zmbdialoggroup = "";
    if(isDefined(level.player_out_of_playable_area_monitor) && level.player_out_of_playable_area_monitor) {
      self thread player_out_of_playable_area_monitor();
    }
    if(isDefined(level.player_too_many_weapons_monitor) && level.player_too_many_weapons_monitor) {
      self thread[[level.player_too_many_weapons_monitor_func]]();
    }
    if(isDefined(level.player_too_many_players_check) && level.player_too_many_players_check) {
      level thread[[level.player_too_many_players_check_func]]();
    }
    self.disabled_perks = [];
    if(isDefined(self.player_initialized)) {
      if(self.player_initialized == 0) {
        self.player_initialized = 1;
        self giveweapon(self zm_utility::get_player_lethal_grenade());
        self setweaponammoclip(self zm_utility::get_player_lethal_grenade(), 0);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
        self setclientminiscoreboardhide(0);
        self.is_drinking = 0;
        self thread player_zombie_breadcrumb();
        self thread player_monitor_travel_dist();
        self thread player_monitor_time_played();
        if(isDefined(level.custom_player_track_ammo_count)) {
          self thread[[level.custom_player_track_ammo_count]]();
        } else {
          self thread player_track_ammo_count();
        }
        self thread zm_utility::shock_onpain();
        self thread player_grenade_watcher();
        self laststand::revive_hud_create();
        if(isDefined(level.zm_gamemodule_spawn_func)) {
          self thread[[level.zm_gamemodule_spawn_func]]();
        }
        self thread player_spawn_protection();
        if(!isDefined(self.lives)) {
          self.lives = 0;
        }
      }
    }
  }
}

function player_spawn_protection() {
  self endon("disconnect");
  self zm_utility::increment_ignoreme();
  x = 0;
  while(x < 60) {
    x++;
    wait(0.05);
  }
  self zm_utility::decrement_ignoreme();
}

function spawn_life_brush(origin, radius, height) {
  life_brush = spawn("trigger_radius", origin, 0, radius, height);
  life_brush.script_noteworthy = "life_brush";
  return life_brush;
}

function in_life_brush() {
  life_brushes = getEntArray("life_brush", "script_noteworthy");
  if(!isDefined(life_brushes)) {
    return false;
  }
  for(i = 0; i < life_brushes.size; i++) {
    if(self istouching(life_brushes[i])) {
      return true;
    }
  }
  return false;
}

function spawn_kill_brush(origin, radius, height) {
  kill_brush = spawn("trigger_radius", origin, 0, radius, height);
  kill_brush.script_noteworthy = "kill_brush";
  return kill_brush;
}

function in_kill_brush() {
  kill_brushes = getEntArray("kill_brush", "script_noteworthy");
  self.kill_brush = undefined;
  if(!isDefined(kill_brushes)) {
    return false;
  }
  for(i = 0; i < kill_brushes.size; i++) {
    if(self istouching(kill_brushes[i])) {
      self.kill_brush = kill_brushes[i];
      return true;
    }
  }
  return false;
}

function in_enabled_playable_area() {
  zm_zonemgr::wait_zone_flags_updating();
  playable_area = getEntArray("player_volume", "script_noteworthy");
  if(!isDefined(playable_area)) {
    return false;
  }
  for(i = 0; i < playable_area.size; i++) {
    if(zm_zonemgr::zone_is_enabled(playable_area[i].targetname) && self istouching(playable_area[i])) {
      return true;
    }
  }
  return false;
}

function get_player_out_of_playable_area_monitor_wait_time() {
  if(isDefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame) {
    return 0.05;
  }
  return 3;
}

function player_out_of_playable_area_monitor() {
  self notify("stop_player_out_of_playable_area_monitor");
  self endon("stop_player_out_of_playable_area_monitor");
  self endon("disconnect");
  level endon("end_game");
  while(!isDefined(self.characterindex)) {
    wait(0.05);
  }
  wait(0.15 * self.characterindex);
  while(true) {
    if(self.sessionstate == "spectator") {
      wait(get_player_out_of_playable_area_monitor_wait_time());
      continue;
    }
    if(isDefined(level.hostmigration_occured) && level.hostmigration_occured) {
      wait(get_player_out_of_playable_area_monitor_wait_time());
      continue;
    }
    if(!self in_life_brush() && (self in_kill_brush() || !self in_enabled_playable_area() || (isDefined(level.player_out_of_playable_area_override) && (isDefined(self[[level.player_out_of_playable_area_override]]()) && self[[level.player_out_of_playable_area_override]]())))) {
      if(!isDefined(level.player_out_of_playable_area_monitor_callback) || self[[level.player_out_of_playable_area_monitor_callback]]()) {
        if(isDefined(level.kill_thread_test_mode) && level.kill_thread_test_mode) {
          printtoprightln("" + self.origin);
          wait(get_player_out_of_playable_area_monitor_wait_time());
          continue;
        }
        if(self isinmovemode("", "") || (isDefined(level.disable_kill_thread) && level.disable_kill_thread) || getdvarint("") > 0) {
          wait(get_player_out_of_playable_area_monitor_wait_time());
          continue;
        }
        self zm_stats::increment_map_cheat_stat("cheat_out_of_playable");
        self zm_stats::increment_client_stat("cheat_out_of_playable", 0);
        self zm_stats::increment_client_stat("cheat_total", 0);
        self playlocalsound(level.zmb_laugh_alias);
        wait(0.5);
        if(getplayers().size == 1 && level flag::get("solo_game") && (isDefined(self.waiting_to_revive) && self.waiting_to_revive)) {
          level notify("end_game");
        } else {
          self disableinvulnerability();
          self.lives = 0;
          self dodamage(self.health + 1000, self.origin);
          self.bleedout_time = 0;
        }
      }
    }
    wait(get_player_out_of_playable_area_monitor_wait_time());
  }
}

function get_player_too_many_weapons_monitor_wait_time() {
  return 3;
}

function player_too_many_weapons_monitor_takeaway_simultaneous(primary_weapons_to_take) {
  self endon("player_too_many_weapons_monitor_takeaway_sequence_done");
  self util::waittill_any("player_downed", "replace_weapon_powerup");
  for(i = 0; i < primary_weapons_to_take.size; i++) {
    self takeweapon(primary_weapons_to_take[i]);
  }
  self zm_score::player_reduce_points("take_all");
  self zm_utility::give_start_weapon(0);
  if(!self laststand::player_is_in_laststand()) {
    self zm_utility::decrement_is_drinking();
  } else if(level flag::get("solo_game")) {
    self.score_lost_when_downed = 0;
  }
  self notify("player_too_many_weapons_monitor_takeaway_sequence_done");
}

function player_too_many_weapons_monitor_takeaway_sequence(primary_weapons_to_take) {
  self thread player_too_many_weapons_monitor_takeaway_simultaneous(primary_weapons_to_take);
  self endon("player_downed");
  self endon("replace_weapon_powerup");
  self zm_utility::increment_is_drinking();
  score_decrement = zm_utility::round_up_to_ten(int(self.score / (primary_weapons_to_take.size + 1)));
  for(i = 0; i < primary_weapons_to_take.size; i++) {
    self playlocalsound(level.zmb_laugh_alias);
    self switchtoweapon(primary_weapons_to_take[i]);
    self zm_score::player_reduce_points("take_specified", score_decrement);
    wait(3);
    self takeweapon(primary_weapons_to_take[i]);
  }
  self playlocalsound(level.zmb_laugh_alias);
  self zm_score::player_reduce_points("take_all");
  wait(1);
  self zm_utility::give_start_weapon(1);
  self zm_utility::decrement_is_drinking();
  self notify("player_too_many_weapons_monitor_takeaway_sequence_done");
}

function player_too_many_weapons_monitor() {
  self notify("stop_player_too_many_weapons_monitor");
  self endon("stop_player_too_many_weapons_monitor");
  self endon("disconnect");
  level endon("end_game");
  scalar = self.characterindex;
  if(!isDefined(scalar)) {
    scalar = self getentitynumber();
  }
  wait(0.15 * scalar);
  while(true) {
    if(self zm_utility::has_powerup_weapon() || self laststand::player_is_in_laststand() || self.sessionstate == "spectator" || isDefined(self.laststandpistol)) {
      wait(get_player_too_many_weapons_monitor_wait_time());
      continue;
    }
    if(getdvarint("") > 0) {
      wait(get_player_too_many_weapons_monitor_wait_time());
      continue;
    }
    weapon_limit = zm_utility::get_player_weapon_limit(self);
    primaryweapons = self getweaponslistprimaries();
    if(primaryweapons.size > weapon_limit) {
      self zm_weapons::take_fallback_weapon();
      primaryweapons = self getweaponslistprimaries();
    }
    primary_weapons_to_take = [];
    for(i = 0; i < primaryweapons.size; i++) {
      if(zm_weapons::is_weapon_included(primaryweapons[i]) || zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
        primary_weapons_to_take[primary_weapons_to_take.size] = primaryweapons[i];
      }
    }
    if(primary_weapons_to_take.size > weapon_limit) {
      if(!isDefined(level.player_too_many_weapons_monitor_callback) || self[[level.player_too_many_weapons_monitor_callback]](primary_weapons_to_take)) {
        self zm_stats::increment_map_cheat_stat("cheat_too_many_weapons");
        self zm_stats::increment_client_stat("cheat_too_many_weapons", 0);
        self zm_stats::increment_client_stat("cheat_total", 0);
        self thread player_too_many_weapons_monitor_takeaway_sequence(primary_weapons_to_take);
        self waittill("player_too_many_weapons_monitor_takeaway_sequence_done");
      }
    }
    wait(get_player_too_many_weapons_monitor_wait_time());
  }
}

function player_monitor_travel_dist() {
  self endon("disconnect");
  self notify("stop_player_monitor_travel_dist");
  self endon("stop_player_monitor_travel_dist");
  prevpos = self.origin;
  while(true) {
    wait(0.1);
    self.pers["distance_traveled"] = self.pers["distance_traveled"] + distance(self.origin, prevpos);
    prevpos = self.origin;
  }
}

function player_monitor_time_played() {
  self endon("disconnect");
  self notify("stop_player_monitor_time_played");
  self endon("stop_player_monitor_time_played");
  level flag::wait_till("start_zombie_round_logic");
  for(;;) {
    wait(1);
    zm_stats::increment_client_stat("time_played_total");
  }
}

function player_grenade_multiattack_bookmark_watcher(grenade) {
  self endon("disconnect");
  waittillframeend();
  if(!isDefined(grenade)) {
    return;
  }
  inflictorentnum = grenade getentitynumber();
  inflictorenttype = grenade getentitytype();
  inflictorbirthtime = 0;
  if(isDefined(grenade.birthtime)) {
    inflictorbirthtime = grenade.birthtime;
  }
  ret_val = grenade util::waittill_any_ex(15, "explode", "death", self, "disconnect");
  if(!isDefined(self) || (isDefined(ret_val) && "timeout" == ret_val)) {
    return;
  }
  self.grenade_multiattack_count = 0;
  self.grenade_multiattack_ent = undefined;
  self.grenade_multikill_count = 0;
  waittillframeend();
  if(!isDefined(self)) {
    return;
  }
  count = level.grenade_multiattack_bookmark_count;
  if(isDefined(grenade.grenade_multiattack_bookmark_count) && grenade.grenade_multiattack_bookmark_count) {
    count = grenade.grenade_multiattack_bookmark_count;
  }
  bookmark_string = "zm_player_grenade_multiattack";
  if(isDefined(grenade.use_grenade_special_long_bookmark) && grenade.use_grenade_special_long_bookmark) {
    bookmark_string = "zm_player_grenade_special_long";
  } else if(isDefined(grenade.use_grenade_special_bookmark) && grenade.use_grenade_special_bookmark) {
    bookmark_string = "zm_player_grenade_special";
  }
  if(count <= self.grenade_multiattack_count && isDefined(self.grenade_multiattack_ent)) {
    adddemobookmark(bookmark_string, gettime(), self getentitynumber(), 255, 0, inflictorentnum, inflictorenttype, inflictorbirthtime, 0, self.grenade_multiattack_ent getentitynumber());
  }
  if(5 <= self.grenade_multikill_count) {
    self zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_EXPLOSION_MULTIKILL");
  }
  self.grenade_multiattack_count = 0;
  self.grenade_multikill_count = 0;
}

function player_grenade_watcher() {
  self endon("disconnect");
  self notify("stop_player_grenade_watcher");
  self endon("stop_player_grenade_watcher");
  self.grenade_multiattack_count = 0;
  self.grenade_multikill_count = 0;
  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    if(isDefined(grenade) && isalive(grenade)) {
      grenade.team = self.team;
    }
    self thread player_grenade_multiattack_bookmark_watcher(grenade);
    if(isDefined(level.grenade_watcher)) {
      self[[level.grenade_watcher]](grenade, weapon);
    }
  }
}

function player_prevent_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(!isDefined(einflictor) || !isDefined(eattacker)) {
    return false;
  }
  if(einflictor == self || eattacker == self) {
    return false;
  }
  if(isDefined(einflictor) && isDefined(einflictor.team)) {
    if(!(isDefined(einflictor.damage_own_team) && einflictor.damage_own_team)) {
      if(einflictor.team == self.team) {
        return true;
      }
    }
  }
  return false;
}

function player_revive_monitor() {
  self endon("disconnect");
  self notify("stop_player_revive_monitor");
  self endon("stop_player_revive_monitor");
  while(true) {
    self waittill("player_revived", reviver);
    self playsoundtoplayer("zmb_character_revived", self);
    if(isDefined(level.isresetting_grief) && level.isresetting_grief) {
      continue;
    }
    if(isDefined(reviver)) {
      if(reviver != self) {
        if(math::cointoss()) {
          self zm_audio::create_and_play_dialog("general", "revive_up");
        } else {
          reviver zm_audio::create_and_play_dialog("general", "revive_support");
        }
      } else {
        self zm_audio::create_and_play_dialog("general", "revive_up");
      }
      points = self.score_lost_when_downed;
      if(!isDefined(points)) {
        points = 0;
      }
      println("" + points);
      reviver zm_score::player_add_points("reviver", points);
      self.score_lost_when_downed = 0;
      if(isPlayer(reviver) && reviver != self) {
        reviver zm_stats::increment_challenge_stat("SURVIVALIST_REVIVE");
      }
    }
  }
}

function laststand_giveback_player_perks() {
  if(isDefined(self.laststand_perks)) {
    lost_perk_index = int(-1);
    if(self.laststand_perks.size > 1) {
      lost_perk_index = randomint(self.laststand_perks.size - 1);
    }
    for(i = 0; i < self.laststand_perks.size; i++) {
      if(self hasperk(self.laststand_perks[i])) {
        continue;
      }
      if(i == lost_perk_index) {
        continue;
      }
      zm_perks::give_perk(self.laststand_perks[i]);
    }
  }
}

function remote_revive_watch() {
  self endon("death");
  self endon("player_revived");
  keep_checking = 1;
  while(keep_checking) {
    self waittill("remote_revive", reviver);
    if(reviver.team == self.team) {
      keep_checking = 0;
    }
  }
  self zm_laststand::remote_revive(reviver);
}

function player_laststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  println("");
  b_alt_visionset = 0;
  self allowjump(0);
  currweapon = self getcurrentweapon();
  self addweaponstat(currweapon, "deathsDuringUse", 1);
  if(isDefined(self.pers_upgrades_awarded["perk_lose"]) && self.pers_upgrades_awarded["perk_lose"]) {
    self zm_pers_upgrades_functions::pers_upgrade_perk_lose_save();
  }
  players = getplayers();
  if(players.size == 1 && level flag::get("solo_game")) {
    if(self.lives > 0 && self hasperk("specialty_quickrevive")) {
      self thread wait_and_revive();
    }
  }
  self zm_utility::clear_is_drinking();
  self thread remote_revive_watch();
  self zm_score::player_downed_penalty();
  self disableoffhandweapons();
  self thread last_stand_grenade_save_and_return();
  if(smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_FALLING") {
    if(!(isDefined(self.intermission) && self.intermission)) {
      self zm_audio::create_and_play_dialog("general", "revive_down");
    } else if(isDefined(level.custom_player_death_vo_func) && !self[[level.custom_player_death_vo_func]]()) {
      self zm_audio::create_and_play_dialog("general", "exert_death");
    }
  }
  if(isDefined(level._zombie_minigun_powerup_last_stand_func)) {
    self thread[[level._zombie_minigun_powerup_last_stand_func]]();
  }
  if(isDefined(level._zombie_tesla_powerup_last_stand_func)) {
    self thread[[level._zombie_tesla_powerup_last_stand_func]]();
  }
  if(self hasperk("specialty_electriccherry")) {
    b_alt_visionset = 1;
    if(isDefined(level.custom_laststand_func)) {
      self thread[[level.custom_laststand_func]]();
    }
  }
  if(isDefined(self.intermission) && self.intermission) {
    wait(0.5);
    self stopsounds();
    level waittill("forever");
  }
  if(!b_alt_visionset) {
    visionset_mgr::activate("visionset", "zombie_last_stand", self, 1);
  }
}

function failsafe_revive_give_back_weapons(excluded_player) {
  for(i = 0; i < 10; i++) {
    wait(0.05);
    players = getplayers();
    foreach(player in players) {
      if(player == excluded_player || !isDefined(player.reviveprogressbar) || player zm_laststand::is_reviving_any()) {
        continue;
      }
      iprintlnbold("");
      player zm_laststand::revive_give_back_weapons(level.weaponnone);
      if(isDefined(player.reviveprogressbar)) {
        player.reviveprogressbar hud::destroyelem();
      }
      if(isDefined(player.revivetexthud)) {
        player.revivetexthud destroy();
      }
    }
  }
}

function set_intermission_point() {
  points = struct::get_array("intermission", "targetname");
  if(points.size < 1) {
    return;
  }
  points = array::randomize(points);
  point = points[0];
  setdemointermissionpoint(point.origin, point.angles);
}

function spawnspectator() {
  self endon("disconnect");
  self endon("spawned_spectator");
  self notify("spawned");
  self notify("end_respawn");
  if(level.intermission) {
    return;
  }
  if(isDefined(level.no_spectator) && level.no_spectator) {
    wait(3);
    exitlevel();
  }
  self.is_zombie = 1;
  level thread failsafe_revive_give_back_weapons(self);
  self notify("zombified");
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
    self.revivetrigger = undefined;
  }
  self.zombification_time = gettime();
  resettimeout();
  self stopshellshock();
  self stoprumble("damage_heavy");
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.maxhealth = self.health;
  self.shellshocked = 0;
  self.inwater = 0;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.afk = 0;
  println("");
  self detachall();
  if(isDefined(level.custom_spectate_permissions)) {
    self[[level.custom_spectate_permissions]]();
  } else {
    self setspectatepermissions(1);
  }
  self thread spectator_thread();
  self spawn(self.origin, self.angles);
  self notify("spawned_spectator");
}

function setspectatepermissions(ison) {
  self allowspectateteam("allies", ison && self.team == "allies");
  self allowspectateteam("axis", ison && self.team == "axis");
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);
}

function spectator_thread() {
  self endon("disconnect");
  self endon("spawned_player");
}

function spectator_toggle_3rd_person() {
  self endon("disconnect");
  self endon("spawned_player");
  third_person = 1;
  self set_third_person(1);
}

function set_third_person(value) {
  if(value) {
    self setclientthirdperson(1);
    self setclientthirdpersonangle(354);
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  } else {
    self setclientthirdperson(0);
    self setclientthirdpersonangle(0);
    self setdepthoffield(0, 0, 512, 4000, 4, 0);
  }
  self resetfov();
}

function last_stand_revive() {
  level endon("between_round_over");
  players = getplayers();
  laststand_count = 0;
  foreach(player in players) {
    if(!zm_utility::is_player_valid(player)) {
      laststand_count++;
    }
  }
  if(laststand_count == players.size) {
    for(i = 0; i < players.size; i++) {
      if(players[i] laststand::player_is_in_laststand() && players[i].revivetrigger.beingrevived == 0) {
        players[i] zm_laststand::auto_revive(players[i]);
      }
    }
  }
}

function last_stand_pistol_rank_init() {
  level.pistol_values = [];
  level.pistol_values[level.pistol_values.size] = level.default_laststandpistol;
  level.pistol_values[level.pistol_values.size] = getweapon("pistol_burst");
  level.pistol_values[level.pistol_values.size] = getweapon("pistol_fullauto");
  level.pistol_value_solo_replace_below = level.pistol_values.size - 1;
  level.pistol_values[level.pistol_values.size] = level.default_solo_laststandpistol;
  level.pistol_values[level.pistol_values.size] = getweapon("pistol_burst_upgraded");
  level.pistol_values[level.pistol_values.size] = getweapon("pistol_fullauto_upgraded");
  level.pistol_values[level.pistol_values.size] = getweapon("ray_gun");
  level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark2");
  level.pistol_values[level.pistol_values.size] = getweapon("ray_gun_upgraded");
  level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark2_upgraded");
  level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark3");
  level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark3_upgraded");
}

function last_stand_pistol_swap() {
  if(self zm_utility::has_powerup_weapon()) {
    self.lastactiveweapon = level.weaponnone;
  }
  if(isDefined(self.w_min_last_stand_pistol_override)) {
    self last_stand_minimum_pistol_override();
  }
  if(!self hasweapon(self.laststandpistol)) {
    self giveweapon(self.laststandpistol);
  }
  ammoclip = self.laststandpistol.clipsize;
  doubleclip = ammoclip * 2;
  if(isDefined(self._special_solo_pistol_swap) && self._special_solo_pistol_swap || (self.laststandpistol == level.default_solo_laststandpistol && !self.hadpistol)) {
    self._special_solo_pistol_swap = 0;
    self.hadpistol = 0;
    self setweaponammostock(self.laststandpistol, doubleclip);
  } else {
    if(level flag::get("solo_game") && self.laststandpistol == level.default_solo_laststandpistol) {
      self setweaponammostock(self.laststandpistol, doubleclip);
    } else {
      if(self.laststandpistol == level.default_laststandpistol) {
        self setweaponammostock(self.laststandpistol, doubleclip);
      } else {
        if(!isDefined(self.stored_weapon_info) || !isDefined(self.stored_weapon_info[self.laststandpistol])) {
          self setweaponammostock(self.laststandpistol, doubleclip);
        } else {
          if(self.laststandpistol.name == "ray_gun" || self.laststandpistol.name == "ray_gun_upgraded") {
            if(self.stored_weapon_info[self.laststandpistol].total_amt >= ammoclip) {
              self setweaponammoclip(self.laststandpistol, ammoclip);
              self.stored_weapon_info[self.laststandpistol].given_amt = ammoclip;
            } else {
              self setweaponammoclip(self.laststandpistol, self.stored_weapon_info[self.laststandpistol].total_amt);
              self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
            }
            self setweaponammostock(self.laststandpistol, 0);
          } else {
            if(self.stored_weapon_info[self.laststandpistol].stock_amt >= doubleclip) {
              self setweaponammostock(self.laststandpistol, doubleclip);
              self.stored_weapon_info[self.laststandpistol].given_amt = (doubleclip + self.stored_weapon_info[self.laststandpistol].clip_amt) + self.stored_weapon_info[self.laststandpistol].left_clip_amt;
            } else {
              self setweaponammostock(self.laststandpistol, self.stored_weapon_info[self.laststandpistol].stock_amt);
              self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
            }
          }
        }
      }
    }
  }
  self switchtoweapon(self.laststandpistol);
}

function last_stand_minimum_pistol_override() {
  for(i = 0; i < level.pistol_values.size; i++) {
    if(level.pistol_values[i] == self.w_min_last_stand_pistol_override) {
      n_min_last_stand_pistol_value = i;
      break;
    }
  }
  for(k = 0; k < level.pistol_values.size; k++) {
    if(level.pistol_values[k] == self.laststandpistol) {
      n_default_last_stand_pistol_value = k;
      break;
    }
  }
  if(n_min_last_stand_pistol_value > n_default_last_stand_pistol_value) {
    self.hadpistol = 0;
    self.laststandpistol = self.w_min_last_stand_pistol_override;
  }
}

function last_stand_best_pistol() {
  pistol_array = [];
  current_weapons = self getweaponslistprimaries();
  for(i = 0; i < current_weapons.size; i++) {
    wclass = current_weapons[i].weapclass;
    if(current_weapons[i].isballisticknife) {
      wclass = "knife";
    }
    if(wclass == "pistol" || wclass == "pistolspread" || wclass == "pistol spread") {
      if(current_weapons[i] != level.default_solo_laststandpistol && !level flag::get("solo_game") || (!level flag::get("solo_game") && current_weapons[i] != level.default_solo_laststandpistol)) {
        if(current_weapons[i] != self.laststandpistol || self.laststandpistol != level.default_laststandpistol) {
          if(self getammocount(current_weapons[i]) <= 0) {
            continue;
          }
        }
      }
      pistol_array_index = pistol_array.size;
      pistol_array[pistol_array_index] = spawnStruct();
      pistol_array[pistol_array_index].weapon = current_weapons[i];
      pistol_array[pistol_array_index].value = 0;
      for(j = 0; j < level.pistol_values.size; j++) {
        if(level.pistol_values[j] == current_weapons[i].rootweapon) {
          pistol_array[pistol_array_index].value = j;
          break;
        }
      }
    }
  }
  self.laststandpistol = last_stand_compare_pistols(pistol_array);
}

function last_stand_compare_pistols(struct_array) {
  if(!isarray(struct_array) || struct_array.size <= 0) {
    self.hadpistol = 0;
    if(isDefined(self.stored_weapon_info)) {
      stored_weapon_info = getarraykeys(self.stored_weapon_info);
      for(j = 0; j < stored_weapon_info.size; j++) {
        if(stored_weapon_info[j].rootweapon == level.laststandpistol) {
          self.hadpistol = 1;
          return stored_weapon_info[j];
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
  if(level flag::get("solo_game")) {
    self._special_solo_pistol_swap = 0;
    if(highest_score_pistol.value <= level.pistol_value_solo_replace_below) {
      self.hadpistol = 0;
      self._special_solo_pistol_swap = 1;
      if(isDefined(level.force_solo_quick_revive) && level.force_solo_quick_revive && !self hasperk("specialty_quickrevive")) {
        return highest_score_pistol.weapon;
      }
      return level.laststandpistol;
    }
    return highest_score_pistol.weapon;
  }
  return highest_score_pistol.weapon;
}

function last_stand_save_pistol_ammo() {
  weapon_inventory = self getweaponslist(1);
  self.stored_weapon_info = [];
  for(i = 0; i < weapon_inventory.size; i++) {
    weapon = weapon_inventory[i];
    wclass = weapon.weapclass;
    if(weapon.isballisticknife) {
      wclass = "knife";
    }
    if(wclass == "pistol" || wclass == "pistolspread" || wclass == "pistol spread") {
      self.stored_weapon_info[weapon] = spawnStruct();
      self.stored_weapon_info[weapon].clip_amt = self getweaponammoclip(weapon);
      self.stored_weapon_info[weapon].left_clip_amt = 0;
      dual_wield_weapon = weapon.dualwieldweapon;
      if(level.weaponnone != dual_wield_weapon) {
        self.stored_weapon_info[weapon].left_clip_amt = self getweaponammoclip(dual_wield_weapon);
      }
      self.stored_weapon_info[weapon].stock_amt = self getweaponammostock(weapon);
      self.stored_weapon_info[weapon].total_amt = (self.stored_weapon_info[weapon].clip_amt + self.stored_weapon_info[weapon].left_clip_amt) + self.stored_weapon_info[weapon].stock_amt;
      self.stored_weapon_info[weapon].given_amt = 0;
    }
  }
  self last_stand_best_pistol();
}

function last_stand_restore_pistol_ammo() {
  self.weapon_taken_by_losing_specialty_additionalprimaryweapon = level.weaponnone;
  if(!isDefined(self.stored_weapon_info)) {
    return;
  }
  weapon_inventory = self getweaponslist(1);
  weapon_to_restore = getarraykeys(self.stored_weapon_info);
  for(i = 0; i < weapon_inventory.size; i++) {
    weapon = weapon_inventory[i];
    if(weapon != self.laststandpistol) {
      continue;
    }
    for(j = 0; j < weapon_to_restore.size; j++) {
      if(weapon == weapon_to_restore[j]) {
        dual_wield_weapon = weapon_to_restore[j].dualwieldweapon;
        if(weapon != level.default_laststandpistol) {
          last_clip = self getweaponammoclip(weapon);
          last_left_clip = 0;
          if(level.weaponnone != dual_wield_weapon) {
            last_left_clip = self getweaponammoclip(dual_wield_weapon);
          }
          last_stock = self getweaponammostock(weapon);
          last_total = (last_clip + last_left_clip) + last_stock;
          used_amt = self.stored_weapon_info[weapon].given_amt - last_total;
          if(used_amt >= self.stored_weapon_info[weapon].stock_amt) {
            used_amt = used_amt - self.stored_weapon_info[weapon].stock_amt;
            self.stored_weapon_info[weapon].stock_amt = 0;
            self.stored_weapon_info[weapon].clip_amt = self.stored_weapon_info[weapon].clip_amt - used_amt;
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
        self setweaponammoclip(weapon, self.stored_weapon_info[weapon].clip_amt);
        if(level.weaponnone != dual_wield_weapon) {
          self setweaponammoclip(dual_wield_weapon, self.stored_weapon_info[weapon].left_clip_amt);
        }
        self setweaponammostock(weapon, self.stored_weapon_info[weapon].stock_amt);
        break;
      }
    }
  }
}

function last_stand_take_thrown_grenade() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("player_revived");
  self waittill("grenade_fire", grenade, weapon);
  if(isDefined(self.lsgsar_lethal) && weapon == self.lsgsar_lethal) {
    self.lsgsar_lethal_nade_amt--;
  }
  if(isDefined(self.lsgsar_tactical) && weapon == self.lsgsar_tactical) {
    self.lsgsar_tactical_nade_amt--;
  }
}

function last_stand_grenade_save_and_return() {
  if(isDefined(level.isresetting_grief) && level.isresetting_grief) {
    return;
  }
  self endon("disconnect");
  self endon("bled_out");
  self.lsgsar_lethal_nade_amt = 0;
  self.lsgsar_has_lethal_nade = 0;
  self.lsgsar_tactical_nade_amt = 0;
  self.lsgsar_has_tactical_nade = 0;
  self.lsgsar_lethal = undefined;
  self.lsgsar_tactical = undefined;
  if(self isthrowinggrenade()) {
    self thread last_stand_take_thrown_grenade();
  }
  weapon = self zm_utility::get_player_lethal_grenade();
  if(weapon != level.weaponnone) {
    self.lsgsar_has_lethal_nade = 1;
    self.lsgsar_lethal = weapon;
    self.lsgsar_lethal_nade_amt = self getweaponammoclip(weapon);
    self setweaponammoclip(weapon, 0);
    self takeweapon(weapon);
  }
  weapon = self zm_utility::get_player_tactical_grenade();
  if(weapon != level.weaponnone) {
    self.lsgsar_has_tactical_nade = 1;
    self.lsgsar_tactical = weapon;
    self.lsgsar_tactical_nade_amt = self getweaponammoclip(weapon);
    self setweaponammoclip(weapon, 0);
    self takeweapon(weapon);
  }
  self waittill("player_revived");
  if(self.lsgsar_has_lethal_nade) {
    self zm_utility::set_player_lethal_grenade(self.lsgsar_lethal);
    self giveweapon(self.lsgsar_lethal);
    self setweaponammoclip(self.lsgsar_lethal, self.lsgsar_lethal_nade_amt);
  }
  if(self.lsgsar_has_tactical_nade) {
    self zm_utility::set_player_tactical_grenade(self.lsgsar_tactical);
    self giveweapon(self.lsgsar_tactical);
    self setweaponammoclip(self.lsgsar_tactical, self.lsgsar_tactical_nade_amt);
  }
  self.lsgsar_lethal_nade_amt = undefined;
  self.lsgsar_has_lethal_nade = undefined;
  self.lsgsar_tactical_nade_amt = undefined;
  self.lsgsar_has_tactical_nade = undefined;
  self.lsgsar_lethal = undefined;
  self.lsgsar_tactical = undefined;
}

function spectators_respawn() {
  level endon("between_round_over");
  if(!isDefined(level.zombie_vars["spectators_respawn"]) || !level.zombie_vars["spectators_respawn"]) {
    return;
  }
  while(true) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      e_player = players[i];
      e_player spectator_respawn_player();
    }
    wait(1);
  }
}

function spectator_respawn_player() {
  if(self.sessionstate == "spectator" && isDefined(self.spectator_respawn)) {
    if(!isDefined(level.custom_spawnplayer)) {
      level.custom_spawnplayer = &spectator_respawn;
    }
    self[[level.spawnplayer]]();
    thread refresh_player_navcard_hud();
    if(isDefined(level.script) && level.round_number > 6 && self.score < 1500) {
      self.old_score = self.score;
      if(isDefined(level.spectator_respawn_custom_score)) {
        self[[level.spectator_respawn_custom_score]]();
      }
      self.score = 1500;
    }
  }
}

function spectator_respawn() {
  println("");
  assert(isDefined(self.spectator_respawn));
  origin = self.spectator_respawn.origin;
  angles = self.spectator_respawn.angles;
  self setspectatepermissions(0);
  new_origin = undefined;
  if(isDefined(level.check_valid_spawn_override)) {
    new_origin = [[level.check_valid_spawn_override]](self);
  }
  if(!isDefined(new_origin)) {
    new_origin = check_for_valid_spawn_near_team(self, 1);
  }
  if(isDefined(new_origin)) {
    if(!isDefined(new_origin.angles)) {
      angles = (0, 0, 0);
    } else {
      angles = new_origin.angles;
    }
    self spawn(new_origin.origin, angles);
  } else {
    self spawn(origin, angles);
  }
  if(isDefined(self zm_utility::get_player_placeable_mine())) {
    self takeweapon(self zm_utility::get_player_placeable_mine());
    self zm_utility::set_player_placeable_mine(level.weaponnone);
  }
  self zm_equipment::take();
  self.is_burning = undefined;
  self.abilities = [];
  self.is_zombie = 0;
  zm_laststand::set_ignoreme(0);
  self clientfield::set("zmbLastStand", 0);
  self reviveplayer();
  self notify("spawned_player");
  self callback::callback("hash_bc12b61f");
  if(isDefined(level._zombiemode_post_respawn_callback)) {
    self thread[[level._zombiemode_post_respawn_callback]]();
  }
  self zm_score::player_reduce_points("died");
  self zm_melee_weapon::spectator_respawn_all();
  self thread player_zombie_breadcrumb();
  self thread zm_perks::return_retained_perks();
  return true;
}

function check_for_valid_spawn_near_team(revivee, return_struct) {
  if(isDefined(level.check_for_valid_spawn_near_team_callback)) {
    spawn_location = [[level.check_for_valid_spawn_near_team_callback]](revivee, return_struct);
    return spawn_location;
  }
  players = getplayers();
  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  closest_group = undefined;
  closest_distance = 100000000;
  backup_group = undefined;
  backup_distance = 100000000;
  if(spawn_points.size == 0) {
    return undefined;
  }
  a_enabled_zone_entities = zm_zonemgr::get_active_zones_entities();
  for(i = 0; i < players.size; i++) {
    if(zm_utility::is_player_valid(players[i], undefined, 1) && players[i] != self) {
      for(j = 0; j < spawn_points.size; j++) {
        if(isDefined(spawn_points[j].script_int)) {
          ideal_distance = spawn_points[j].script_int;
        } else {
          ideal_distance = 1000;
        }
        if(zm_utility::check_point_in_enabled_zone(spawn_points[j].origin, 0, a_enabled_zone_entities) == 0) {
          continue;
        }
        if(spawn_points[j].locked == 0) {
          plyr_dist = distancesquared(players[i].origin, spawn_points[j].origin);
          if(plyr_dist < (ideal_distance * ideal_distance)) {
            if(plyr_dist < closest_distance) {
              closest_distance = plyr_dist;
              closest_group = j;
            }
            continue;
          }
          if(plyr_dist < backup_distance) {
            backup_group = j;
            backup_distance = plyr_dist;
          }
        }
      }
    }
    if(!isDefined(closest_group)) {
      closest_group = backup_group;
    }
    if(isDefined(closest_group)) {
      spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
      if(isDefined(spawn_location)) {
        return spawn_location;
      }
    }
  }
  return undefined;
}

function get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct) {
  spawn_array = struct::get_array(spawn_points[closest_group].target, "targetname");
  spawn_array = array::randomize(spawn_array);
  for(k = 0; k < spawn_array.size; k++) {
    if(isDefined(spawn_array[k].plyr) && spawn_array[k].plyr == revivee getentitynumber()) {
      if(positionwouldtelefrag(spawn_array[k].origin)) {
        spawn_array[k].plyr = undefined;
        break;
        continue;
      }
      if(isDefined(return_struct) && return_struct) {
        return spawn_array[k];
      }
      return spawn_array[k].origin;
    }
  }
  for(k = 0; k < spawn_array.size; k++) {
    if(positionwouldtelefrag(spawn_array[k].origin)) {
      continue;
    }
    if(!isDefined(spawn_array[k].plyr) || spawn_array[k].plyr == revivee getentitynumber()) {
      spawn_array[k].plyr = revivee getentitynumber();
      if(isDefined(return_struct) && return_struct) {
        return spawn_array[k];
      }
      return spawn_array[k].origin;
    }
  }
  if(isDefined(return_struct) && return_struct) {
    return spawn_array[0];
  }
  return spawn_array[0].origin;
}

function check_for_valid_spawn_near_position(revivee, v_position, return_struct) {
  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  if(spawn_points.size == 0) {
    return undefined;
  }
  closest_group = undefined;
  closest_distance = 100000000;
  backup_group = undefined;
  backup_distance = 100000000;
  for(i = 0; i < spawn_points.size; i++) {
    if(isDefined(spawn_points[i].script_int)) {
      ideal_distance = spawn_points[i].script_int;
    } else {
      ideal_distance = 1000;
    }
    if(spawn_points[i].locked == 0) {
      dist = distancesquared(v_position, spawn_points[i].origin);
      if(dist < (ideal_distance * ideal_distance)) {
        if(dist < closest_distance) {
          closest_distance = dist;
          closest_group = i;
        }
      } else if(dist < backup_distance) {
        backup_group = i;
        backup_distance = dist;
      }
    }
    if(!isDefined(closest_group)) {
      closest_group = backup_group;
    }
  }
  if(isDefined(closest_group)) {
    spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
    if(isDefined(spawn_location)) {
      return spawn_location;
    }
  }
  return undefined;
}

function check_for_valid_spawn_within_range(revivee, v_position, return_struct, min_distance, max_distance) {
  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  if(spawn_points.size == 0) {
    return undefined;
  }
  closest_group = undefined;
  closest_distance = 100000000;
  for(i = 0; i < spawn_points.size; i++) {
    if(spawn_points[i].locked == 0) {
      dist = distance(v_position, spawn_points[i].origin);
      if(dist >= min_distance && dist <= max_distance) {
        if(dist < closest_distance) {
          closest_distance = dist;
          closest_group = i;
        }
      }
    }
  }
  if(isDefined(closest_group)) {
    spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
    if(isDefined(spawn_location)) {
      return spawn_location;
    }
  }
  return undefined;
}

function get_players_on_team(exclude) {
  teammates = [];
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i].spawn_side == self.spawn_side && !isDefined(players[i].revivetrigger) && players[i] != exclude) {
      teammates[teammates.size] = players[i];
    }
  }
  return teammates;
}

function get_safe_breadcrumb_pos(player) {
  players = getplayers();
  valid_players = [];
  min_dist = 22500;
  for(i = 0; i < players.size; i++) {
    if(!zm_utility::is_player_valid(players[i])) {
      continue;
    }
    valid_players[valid_players.size] = players[i];
  }
  for(i = 0; i < valid_players.size; i++) {
    count = 0;
    for(q = 1; q < player.zombie_breadcrumbs.size; q++) {
      if(distancesquared(player.zombie_breadcrumbs[q], valid_players[i].origin) < min_dist) {
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

function round_spawning() {
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  level endon("kill_round");
  if(level.intermission) {
    return;
  }
  if(cheat_enabled(2)) {
    return;
  }
  if(level.zm_loc_types["zombie_location"].size < 1) {
    assertmsg("");
    return;
  }
  zombie_utility::ai_calculate_health(level.round_number);
  count = 0;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i].zombification_time = 0;
  }
  if(!(isDefined(level.kill_counter_hud) && level.zombie_total > 0)) {
    level.zombie_total = get_zombie_count_for_round(level.round_number, level.players.size);
    level.zombie_respawns = 0;
    level notify("zombie_total_set");
  }
  if(isDefined(level.zombie_total_set_func)) {
    level thread[[level.zombie_total_set_func]]();
  }
  if(level.round_number < 10 || level.speed_change_max > 0) {
    level thread zombie_utility::zombie_speed_up();
  }
  old_spawn = undefined;
  while(true) {
    while(zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit || level.zombie_total <= 0) {
      wait(0.1);
    }
    while(zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
      zombie_utility::clear_all_corpses();
      wait(0.1);
    }
    if(flag::exists("world_is_paused")) {
      level flag::wait_till_clear("world_is_paused");
    }
    level flag::wait_till("spawn_zombies");
    while(level.zm_loc_types["zombie_location"].size <= 0) {
      wait(0.1);
    }
    run_custom_ai_spawn_checks();
    if(isDefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
      util::wait_network_frame();
      continue;
    }
    if(isDefined(level.fn_custom_round_ai_spawn)) {
      if([[level.fn_custom_round_ai_spawn]]()) {
        util::wait_network_frame();
        continue;
      }
    }
    if(isDefined(level.zombie_spawners)) {
      if(isDefined(level.fn_custom_zombie_spawner_selection)) {
        spawner = [[level.fn_custom_zombie_spawner_selection]]();
      } else {
        if(isDefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
          if(isDefined(level.spawner_int) && (isDefined(level.zombie_spawn[level.spawner_int].size) && level.zombie_spawn[level.spawner_int].size)) {
            spawner = array::random(level.zombie_spawn[level.spawner_int]);
          } else {
            spawner = array::random(level.zombie_spawners);
          }
        } else {
          spawner = array::random(level.zombie_spawners);
        }
      }
      ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);
    }
    if(isDefined(ai)) {
      level.zombie_total--;
      if(level.zombie_respawns > 0) {
        level.zombie_respawns--;
      }
      ai thread zombie_utility::round_spawn_failsafe();
      count++;
      if(ai ai::has_behavior_attribute("can_juke")) {
        ai ai::set_behavior_attribute("can_juke", 0);
      }
      if(level.zombie_respawns > 0) {
        wait(0.1);
      } else {
        wait(level.zombie_vars["zombie_spawn_delay"]);
      }
    }
    util::wait_network_frame();
  }
}

function get_zombie_count_for_round(n_round, n_player_count) {
  max = level.zombie_vars["zombie_max_ai"];
  multiplier = n_round / 5;
  if(multiplier < 1) {
    multiplier = 1;
  }
  if(n_round >= 10) {
    multiplier = multiplier * (n_round * 0.15);
  }
  if(n_player_count == 1) {
    max = max + (int((0.5 * level.zombie_vars["zombie_ai_per_player"]) * multiplier));
  } else {
    max = max + (int(((n_player_count - 1) * level.zombie_vars["zombie_ai_per_player"]) * multiplier));
  }
  if(!isDefined(level.max_zombie_func)) {
    level.max_zombie_func = &zombie_utility::default_max_zombie_func;
  }
  n_zombie_count = [[level.max_zombie_func]](max, n_round);
  return n_zombie_count;
}

function run_custom_ai_spawn_checks() {
  foreach(s in level.custom_ai_spawn_check_funcs) {
    if([[s.func_check]]()) {
      a_spawners = [[s.func_get_spawners]]();
      level.zombie_spawners = arraycombine(level.zombie_spawners, a_spawners, 0, 0);
      if(isDefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
        foreach(sp in a_spawners) {
          if(isDefined(sp.script_int)) {
            if(!isDefined(level.zombie_spawn[sp.script_int])) {
              level.zombie_spawn[sp.script_int] = [];
            }
            if(!isinarray(level.zombie_spawn[sp.script_int], sp)) {
              if(!isDefined(level.zombie_spawn[sp.script_int])) {
                level.zombie_spawn[sp.script_int] = [];
              } else if(!isarray(level.zombie_spawn[sp.script_int])) {
                level.zombie_spawn[sp.script_int] = array(level.zombie_spawn[sp.script_int]);
              }
              level.zombie_spawn[sp.script_int][level.zombie_spawn[sp.script_int].size] = sp;
            }
          }
        }
      }
      if(isDefined(s.func_get_locations)) {
        a_locations = [[s.func_get_locations]]();
        level.zm_loc_types["zombie_location"] = arraycombine(level.zm_loc_types["zombie_location"], a_locations, 0, 0);
      }
      continue;
    }
    a_spawners = [[s.func_get_spawners]]();
    foreach(sp in a_spawners) {
      arrayremovevalue(level.zombie_spawners, sp);
    }
    if(isDefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
      foreach(sp in a_spawners) {
        if(isDefined(sp.script_int) && isDefined(level.zombie_spawn[sp.script_int])) {
          arrayremovevalue(level.zombie_spawn[sp.script_int], sp);
        }
      }
    }
    if(isDefined(s.func_get_locations)) {
      a_locations = [[s.func_get_locations]]();
      foreach(s_loc in a_locations) {
        arrayremovevalue(level.zm_loc_types["zombie_location"], s_loc);
      }
    }
  }
}

function register_custom_ai_spawn_check(str_id, func_check, func_get_spawners, func_get_locations) {
  if(!isDefined(level.custom_ai_spawn_check_funcs[str_id])) {
    level.custom_ai_spawn_check_funcs[str_id] = spawnStruct();
  }
  level.custom_ai_spawn_check_funcs[str_id].func_check = func_check;
  level.custom_ai_spawn_check_funcs[str_id].func_get_spawners = func_get_spawners;
  level.custom_ai_spawn_check_funcs[str_id].func_get_locations = func_get_locations;
}

function round_spawning_test() {
  while(true) {
    spawn_point = array::random(level.zm_loc_types["zombie_location"]);
    spawner = array::random(level.zombie_spawners);
    ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
    ai waittill("death");
    wait(5);
  }
}

function round_pause(delay = 30) {
  level.countdown_hud = zm_utility::create_counter_hud();
  level.countdown_hud setvalue(delay);
  level.countdown_hud.color = (1, 1, 1);
  level.countdown_hud.alpha = 1;
  level.countdown_hud fadeovertime(2);
  wait(2);
  level.countdown_hud.color = vectorscale((1, 0, 0), 0.21);
  level.countdown_hud fadeovertime(3);
  wait(3);
  while(delay >= 1) {
    wait(1);
    delay--;
    level.countdown_hud setvalue(delay);
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] playlocalsound("zmb_perks_packa_ready");
  }
  level.countdown_hud fadeovertime(1);
  level.countdown_hud.color = (1, 1, 1);
  level.countdown_hud.alpha = 0;
  wait(1);
  level.countdown_hud zm_utility::destroy_hud();
}

function round_start() {
  if(!isDefined(level.zombie_spawners) || level.zombie_spawners.size == 0) {
    println("");
    level flag::set("begin_spawning");
    return;
  }
  println("");
  if(isDefined(level.round_prestart_func)) {
    [[level.round_prestart_func]]();
  } else {
    n_delay = 2;
    if(isDefined(level.zombie_round_start_delay)) {
      n_delay = level.zombie_round_start_delay;
    }
    wait(n_delay);
  }
  level.zombie_health = level.zombie_vars["zombie_health_start"];
  if(getdvarint("scr_writeconfigstrings") == 1) {
    wait(5);
    exitlevel();
    return;
  }
  if(level.zombie_vars["game_start_delay"] > 0) {
    round_pause(level.zombie_vars["game_start_delay"]);
  }
  level flag::set("begin_spawning");
  if(!isDefined(level.round_spawn_func)) {
    level.round_spawn_func = &round_spawning;
  }
  if(!isDefined(level.move_spawn_func)) {
    level.move_spawn_func = &zm_utility::move_zombie_spawn_location;
  }
  if(getdvarint("")) {
    level.round_spawn_func = &round_spawning_test;
  }
  if(!isDefined(level.round_wait_func)) {
    level.round_wait_func = &round_wait;
  }
  if(!isDefined(level.round_think_func)) {
    level.round_think_func = &round_think;
  }
  level thread[[level.round_think_func]]();
}

function play_door_dialog() {
  self endon("warning_dialog");
  timer = 0;
  while(true) {
    wait(0.05);
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 4900) {
        timer = 0;
        continue;
      }
      while(dist < 4900 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist > 4900 && timer >= 3) {
        self playSound("door_deny");
        players[i] zm_audio::create_and_play_dialog("general", "outofmoney");
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

function wait_until_first_player() {
  players = getplayers();
  if(!isDefined(players[0])) {
    level waittill("first_player_ready");
  }
}

function round_one_up() {
  level endon("end_game");
  if(isDefined(level.noroundnumber) && level.noroundnumber == 1) {
    return;
  }
  if(!isDefined(level.doground_nomusic)) {
    level.doground_nomusic = 0;
  }
  if(level.first_round) {
    intro = 1;
    if(isDefined(level._custom_intro_vox)) {
      level thread[[level._custom_intro_vox]]();
    } else {
      level thread play_level_start_vox_delayed();
    }
  } else {
    intro = 0;
  }
  if(level.round_number == 5 || level.round_number == 10 || level.round_number == 20 || level.round_number == 35 || level.round_number == 50) {
    players = getplayers();
    rand = randomintrange(0, players.size);
    players[rand] thread zm_audio::create_and_play_dialog("general", "round_" + level.round_number);
  }
  if(intro) {
    if(isDefined(level.host_ended_game) && level.host_ended_game) {
      return;
    }
    wait(6.25);
    level notify("intro_hud_done");
    wait(2);
  } else {
    wait(2.5);
  }
  reportmtu(level.round_number);
}

function round_over() {
  if(isDefined(level.noroundnumber) && level.noroundnumber == 1) {
    return;
  }
  time = [[level.func_get_delay_between_rounds]]();
  players = getplayers();
  for(player_index = 0; player_index < players.size; player_index++) {
    if(!isDefined(players[player_index].pers["previous_distance_traveled"])) {
      players[player_index].pers["previous_distance_traveled"] = 0;
    }
    distancethisround = int(players[player_index].pers["distance_traveled"] - players[player_index].pers["previous_distance_traveled"]);
    players[player_index].pers["previous_distance_traveled"] = players[player_index].pers["distance_traveled"];
    players[player_index] incrementplayerstat("distance_traveled", distancethisround);
    if(players[player_index].pers["team"] != "spectator") {
      players[player_index] recordroundendstats();
    }
  }
  recordzombieroundend();
  wait(time);
}

function get_delay_between_rounds() {
  return level.zombie_vars["zombie_between_round_time"];
}

function recordplayerroundweapon(weapon, statname) {
  if(isDefined(weapon)) {
    weaponidx = getbaseweaponitemindex(weapon);
    if(isDefined(weaponidx)) {
      self incrementplayerstat(statname, weaponidx);
    }
  }
}

function recordprimaryweaponsstats(base_stat_name, max_weapons) {
  current_weapons = self getweaponslistprimaries();
  for(index = 0; index < max_weapons && index < current_weapons.size; index++) {
    recordplayerroundweapon(current_weapons[index], base_stat_name + index);
  }
}

function recordroundstartstats() {
  zonename = self zm_utility::get_current_zone();
  if(isDefined(zonename)) {
    self recordzombiezone("startingZone", zonename);
  }
  self incrementplayerstat("score", self.score);
  primaryweapon = self getcurrentweapon();
  self recordprimaryweaponsstats("roundStartPrimaryWeapon", 3);
  self recordmapevent(8, gettime(), self.origin, level.round_number);
}

function recordroundendstats() {
  zonename = self zm_utility::get_current_zone();
  if(isDefined(zonename)) {
    self recordzombiezone("endingZone", zonename);
  }
  self recordprimaryweaponsstats("roundEndPrimaryWeapon", 3);
  self recordmapevent(9, gettime(), self.origin, level.round_number);
}

function round_think(restart = 0) {
  println("");
  level endon("end_round_think");
  if(!(isDefined(restart) && restart)) {
    if(isDefined(level.initial_round_wait_func)) {
      [[level.initial_round_wait_func]]();
    }
    if(!(isDefined(level.host_ended_game) && level.host_ended_game)) {
      players = getplayers();
      foreach(player in players) {
        if(!(isDefined(player.hostmigrationcontrolsfrozen) && player.hostmigrationcontrolsfrozen)) {
          player freezecontrols(0);
          println("");
        }
        player zm_stats::set_global_stat("rounds", level.round_number);
      }
    }
  }
  setroundsplayed(level.round_number);
  for(;;) {
    maxreward = 50 * level.round_number;
    if(maxreward > 500) {
      maxreward = 500;
    }
    level.zombie_vars["rebuild_barrier_cap_per_round"] = maxreward;
    level.pro_tips_start_time = gettime();
    level.zombie_last_run_time = gettime();
    if(isDefined(level.zombie_round_change_custom)) {
      [[level.zombie_round_change_custom]]();
    } else {
      if(!(isDefined(level.sndmusicspecialround) && level.sndmusicspecialround)) {
        if(isDefined(level.sndgotoroundoccurred) && level.sndgotoroundoccurred) {
          level.sndgotoroundoccurred = 0;
        } else {
          if(level.round_number == 1) {
            level thread zm_audio::sndmusicsystem_playstate("round_start_first");
          } else {
            if(level.round_number <= 5) {
              level thread zm_audio::sndmusicsystem_playstate("round_start");
            } else {
              level thread zm_audio::sndmusicsystem_playstate("round_start_short");
            }
          }
        }
      }
      round_one_up();
    }
    zm_powerups::powerup_round_start();
    players = getplayers();
    array::thread_all(players, &zm_blockers::rebuild_barrier_reward_reset);
    if(!(isDefined(level.headshots_only) && level.headshots_only) && !restart) {
      level thread award_grenades_for_survivors();
    }
    println((("" + level.round_number) + "") + players.size);
    level.round_start_time = gettime();
    while(level.zm_loc_types["zombie_location"].size <= 0) {
      wait(0.1);
    }
    zkeys = getarraykeys(level.zones);
    for(i = 0; i < zkeys.size; i++) {
      zonename = zkeys[i];
      level.zones[zonename].round_spawn_count = 0;
    }
    level thread[[level.round_spawn_func]]();
    level notify("start_of_round");
    recordzombieroundstart();
    bb::logroundevent("start_of_round");
    players = getplayers();
    for(index = 0; index < players.size; index++) {
      players[index] recordroundstartstats();
    }
    if(isDefined(level.round_start_custom_func)) {
      [[level.round_start_custom_func]]();
    }
    [[level.round_wait_func]]();
    level.first_round = 0;
    level notify("end_of_round");
    bb::logroundevent("end_of_round");
    uploadstats();
    if(isDefined(level.round_end_custom_logic)) {
      [[level.round_end_custom_logic]]();
    }
    players = getplayers();
    if(isDefined(level.no_end_game_check) && level.no_end_game_check) {
      level thread last_stand_revive();
      level thread spectators_respawn();
    } else if(1 != players.size) {
      level thread spectators_respawn();
    }
    players = getplayers();
    array::thread_all(players, &zm_pers_upgrades_system::round_end);
    if(((int(level.round_number / 5)) * 5) == level.round_number) {
      level clientfield::set("round_complete_time", int(((level.time - level.n_gameplay_start_time) + 500) / 1000));
      level clientfield::set("round_complete_num", level.round_number);
    }
    if(level.gamedifficulty == 0) {
      level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
    } else {
      level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
    }
    set_round_number(1 + get_round_number());
    setroundsplayed(get_round_number());
    level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]](get_round_number());
    matchutctime = getutc();
    players = getplayers();
    foreach(player in players) {
      if(level.curr_gametype_affects_rank && get_round_number() > (3 + level.start_round)) {
        player zm_stats::add_client_stat("weighted_rounds_played", get_round_number());
      }
      player zm_stats::set_global_stat("rounds", get_round_number());
      player zm_stats::update_playing_utc_time(matchutctime);
      player zm_perks::perk_set_max_health_if_jugg("health_reboot", 1, 1);
      for(i = 0; i < 4; i++) {
        player.number_revives_per_round[i] = 0;
      }
      if(isalive(player) && player.sessionstate != "spectator" && (!(isDefined(level.skip_alive_at_round_end_xp) && level.skip_alive_at_round_end_xp))) {
        player zm_stats::increment_challenge_stat("SURVIVALIST_SURVIVE_ROUNDS");
        score_number = get_round_number() - 1;
        if(score_number < 1) {
          score_number = 1;
        } else if(score_number > 20) {
          score_number = 20;
        }
        scoreevents::processscoreevent("alive_at_round_end_" + score_number, player);
      }
    }
    if(isDefined(level.check_quickrevive_hotjoin)) {
      [[level.check_quickrevive_hotjoin]]();
    }
    level.round_number = get_round_number();
    level round_over();
    level notify("between_round_over");
    level.skip_alive_at_round_end_xp = 0;
    restart = 0;
  }
}

function award_grenades_for_survivors() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(!players[i].is_zombie && (!(isDefined(players[i].altbody) && players[i].altbody)) && !players[i] laststand::player_is_in_laststand()) {
      lethal_grenade = players[i] zm_utility::get_player_lethal_grenade();
      if(!players[i] hasweapon(lethal_grenade)) {
        players[i] giveweapon(lethal_grenade);
        players[i] setweaponammoclip(lethal_grenade, 0);
      }
      frac = players[i] getfractionmaxammo(lethal_grenade);
      if(frac < 0.25) {
        players[i] setweaponammoclip(lethal_grenade, 2);
        continue;
      }
      if(frac < 0.5) {
        players[i] setweaponammoclip(lethal_grenade, 3);
        continue;
      }
      players[i] setweaponammoclip(lethal_grenade, 4);
    }
  }
}

function get_zombie_spawn_delay(n_round) {
  if(n_round > 60) {
    n_round = 60;
  }
  n_multiplier = 0.95;
  switch (level.players.size) {
    case 1: {
      n_delay = 2;
      break;
    }
    case 2: {
      n_delay = 1.5;
      break;
    }
    case 3: {
      n_delay = 0.89;
      break;
    }
    case 4: {
      n_delay = 0.67;
      break;
    }
  }
  for(i = 1; i < n_round; i++) {
    n_delay = n_delay * n_multiplier;
    if(n_delay <= 0.1) {
      n_delay = 0.1;
      break;
    }
  }
  return n_delay;
}

function round_spawn_failsafe_debug() {
  level notify("failsafe_debug_stop");
  level endon("failsafe_debug_stop");
  start = gettime();
  level.chunk_time = 0;
  while(true) {
    level.failsafe_time = gettime() - start;
    if(isDefined(self.lastchunk_destroy_time)) {
      level.chunk_time = gettime() - self.lastchunk_destroy_time;
    }
    util::wait_network_frame();
  }
}

function print_zombie_counts() {
  while(true) {
    if(getdvarint("")) {
      if(!isDefined(level.debug_zombie_count_hud)) {
        level.debug_zombie_count_hud = newdebughudelem();
        level.debug_zombie_count_hud.alignx = "";
        level.debug_zombie_count_hud.x = 100;
        level.debug_zombie_count_hud.y = 10;
        level.debug_zombie_count_hud settext("");
      }
      currentcount = zombie_utility::get_current_zombie_count();
      number_to_kill = level.zombie_total;
      level.debug_zombie_count_hud settext((("" + currentcount) + "") + number_to_kill);
    } else if(isDefined(level.debug_zombie_count_hud)) {
      level.debug_zombie_count_hud destroy();
      level.debug_zombie_count_hud = undefined;
    }
    wait(0.1);
  }
}

function round_wait() {
  level endon("restart_round");
  level endon("kill_round");
  if(getdvarint("")) {
    level waittill("forever");
  }
  if(cheat_enabled(2)) {
    level waittill("forever");
  }
  if(getdvarint("") == 0) {
    level waittill("forever");
  }
  wait(1);
  level thread print_zombie_counts();
  level thread sndmusiconkillround();
  while(true) {
    should_wait = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
    if(!should_wait) {
      level thread zm_audio::sndmusicsystem_playstate("round_end");
      return;
    }
    if(level flag::get("end_round_wait")) {
      level thread zm_audio::sndmusicsystem_playstate("round_end");
      return;
    }
    wait(1);
  }
}

function sndmusiconkillround() {
  level endon("end_of_round");
  level waittill("kill_round");
  level thread zm_audio::sndmusicsystem_playstate("round_end");
}

function zombify_player() {
  self zm_score::player_died_penalty();
  self recordplayerdeathzombies();
  if(isDefined(level.deathcard_spawn_func)) {
    self[[level.deathcard_spawn_func]]();
  }
  if(isDefined(level.func_clone_plant_respawn) && isDefined(self.s_clone_plant)) {
    self[[level.func_clone_plant_respawn]]();
    return;
  }
  if(!isDefined(level.zombie_vars["zombify_player"]) || !level.zombie_vars["zombify_player"]) {
    self thread spawnspectator();
    return;
  }
  self.ignoreme = 1;
  self.is_zombie = 1;
  self.zombification_time = gettime();
  self.team = level.zombie_team;
  self notify("zombified");
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }
  self.revivetrigger = undefined;
  self setmovespeedscale(0.3);
  self reviveplayer();
  self takeallweapons();
  self disableweaponcycling();
  self disableoffhandweapons();
  self thread zombie_utility::zombie_eye_glow();
  self thread playerzombie_player_damage();
  self thread playerzombie_soundboard();
}

function playerzombie_player_damage() {
  self endon("death");
  self endon("disconnect");
  self thread playerzombie_infinite_health();
  self.zombiehealth = level.zombie_health;
  while(true) {
    self waittill("damage", amount, attacker, directionvec, point, type);
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      wait(0.05);
      continue;
    }
    self.zombiehealth = self.zombiehealth - amount;
    if(self.zombiehealth <= 0) {
      self thread playerzombie_downed_state();
      self waittill("playerzombie_downed_state_done");
      self.zombiehealth = level.zombie_health;
    }
  }
}

function playerzombie_downed_state() {
  self endon("death");
  self endon("disconnect");
  downtime = 15;
  starttime = gettime();
  endtime = starttime + (downtime * 1000);
  self thread playerzombie_downed_hud();
  self.playerzombie_soundboard_disable = 1;
  self thread zombie_utility::zombie_eye_glow_stop();
  self disableweapons();
  self allowstand(0);
  self allowcrouch(0);
  self allowprone(1);
  while(gettime() < endtime) {
    wait(0.05);
  }
  self.playerzombie_soundboard_disable = 0;
  self thread zombie_utility::zombie_eye_glow();
  self enableweapons();
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
  self notify("playerzombie_downed_state_done");
}

function playerzombie_downed_hud() {
  self endon("death");
  self endon("disconnect");
  text = newclienthudelem(self);
  text.alignx = "center";
  text.aligny = "middle";
  text.horzalign = "user_center";
  text.vertalign = "user_bottom";
  text.foreground = 1;
  text.font = "default";
  text.fontscale = 1.8;
  text.alpha = 0;
  text.color = (1, 1, 1);
  text settext(&"ZOMBIE_PLAYERZOMBIE_DOWNED");
  text.y = -113;
  if(self issplitscreen()) {
    text.y = -137;
  }
  text fadeovertime(0.1);
  text.alpha = 1;
  self waittill("playerzombie_downed_state_done");
  text fadeovertime(0.1);
  text.alpha = 0;
}

function playerzombie_infinite_health() {
  self endon("death");
  self endon("disconnect");
  bighealth = 100000;
  while(true) {
    if(self.health < bighealth) {
      self.health = bighealth;
    }
    wait(0.1);
  }
}

function playerzombie_soundboard() {
  self endon("death");
  self endon("disconnect");
  self.playerzombie_soundboard_disable = 0;
  self.buttonpressed_use = 0;
  self.buttonpressed_attack = 0;
  self.buttonpressed_ads = 0;
  self.usesound_waittime = 3000;
  self.usesound_nexttime = gettime();
  usesound = "playerzombie_usebutton_sound";
  self.attacksound_waittime = 3000;
  self.attacksound_nexttime = gettime();
  attacksound = "playerzombie_attackbutton_sound";
  self.adssound_waittime = 3000;
  self.adssound_nexttime = gettime();
  adssound = "playerzombie_adsbutton_sound";
  self.inputsound_nexttime = gettime();
  while(true) {
    if(self.playerzombie_soundboard_disable) {
      wait(0.05);
      continue;
    }
    if(self usebuttonpressed()) {
      if(self can_do_input("use")) {
        self thread playerzombie_play_sound(usesound);
        self thread playerzombie_waitfor_buttonrelease("use");
        self.usesound_nexttime = gettime() + self.usesound_waittime;
      }
    } else {
      if(self attackbuttonpressed()) {
        if(self can_do_input("attack")) {
          self thread playerzombie_play_sound(attacksound);
          self thread playerzombie_waitfor_buttonrelease("attack");
          self.attacksound_nexttime = gettime() + self.attacksound_waittime;
        }
      } else if(self adsbuttonpressed()) {
        if(self can_do_input("ads")) {
          self thread playerzombie_play_sound(adssound);
          self thread playerzombie_waitfor_buttonrelease("ads");
          self.adssound_nexttime = gettime() + self.adssound_waittime;
        }
      }
    }
    wait(0.05);
  }
}

function can_do_input(inputtype) {
  if(gettime() < self.inputsound_nexttime) {
    return 0;
  }
  cando = 0;
  switch (inputtype) {
    case "use": {
      if(gettime() >= self.usesound_nexttime && !self.buttonpressed_use) {
        cando = 1;
      }
      break;
    }
    case "attack": {
      if(gettime() >= self.attacksound_nexttime && !self.buttonpressed_attack) {
        cando = 1;
      }
      break;
    }
    case "ads": {
      if(gettime() >= self.usesound_nexttime && !self.buttonpressed_ads) {
        cando = 1;
      }
      break;
    }
    default: {
      assertmsg("" + inputtype);
      break;
    }
  }
  return cando;
}

function playerzombie_play_sound(alias) {
  self zm_utility::play_sound_on_ent(alias);
}

function playerzombie_waitfor_buttonrelease(inputtype) {
  if(inputtype != "use" && inputtype != "attack" && inputtype != "ads") {
    assertmsg(("" + inputtype) + "");
    return;
  }
  notifystring = "waitfor_buttonrelease_" + inputtype;
  self notify(notifystring);
  self endon(notifystring);
  if(inputtype == "use") {
    self.buttonpressed_use = 1;
    while(self usebuttonpressed()) {
      wait(0.05);
    }
    self.buttonpressed_use = 0;
  } else {
    if(inputtype == "attack") {
      self.buttonpressed_attack = 1;
      while(self attackbuttonpressed()) {
        wait(0.05);
      }
      self.buttonpressed_attack = 0;
    } else if(inputtype == "ads") {
      self.buttonpressed_ads = 1;
      while(self adsbuttonpressed()) {
        wait(0.05);
      }
      self.buttonpressed_ads = 0;
    }
  }
}

function remove_ignore_attacker() {
  self notify("new_ignore_attacker");
  self endon("new_ignore_attacker");
  self endon("disconnect");
  if(!isDefined(level.ignore_enemy_timer)) {
    level.ignore_enemy_timer = 0.4;
  }
  wait(level.ignore_enemy_timer);
  self.ignoreattacker = undefined;
}

function player_damage_override_cheat(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
  return false;
}

function player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  idamage = self check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
  if(self.scene_takedamage === 0) {
    return 0;
  }
  if(isDefined(eattacker) && (isDefined(eattacker.b_aat_fire_works_weapon) && eattacker.b_aat_fire_works_weapon)) {
    return 0;
  }
  if(isDefined(self.use_adjusted_grenade_damage) && self.use_adjusted_grenade_damage) {
    self.use_adjusted_grenade_damage = undefined;
    if(self.health > idamage) {
      return idamage;
    }
  }
  if(!idamage) {
    return 0;
  }
  if(self laststand::player_is_in_laststand()) {
    return 0;
  }
  if(isDefined(einflictor)) {
    if(isDefined(einflictor.water_damage) && einflictor.water_damage) {
      return 0;
    }
  }
  if(isDefined(eattacker)) {
    if(eattacker.owner === self) {
      return 0;
    }
    if(isDefined(self.ignoreattacker) && self.ignoreattacker == eattacker) {
      return 0;
    }
    if(isDefined(self.is_zombie) && self.is_zombie && (isDefined(eattacker.is_zombie) && eattacker.is_zombie)) {
      return 0;
    }
    if(isDefined(eattacker.is_zombie) && eattacker.is_zombie) {
      self.ignoreattacker = eattacker;
      self thread remove_ignore_attacker();
      if(isDefined(eattacker.custom_damage_func)) {
        idamage = eattacker[[eattacker.custom_damage_func]](self);
      }
    }
    eattacker notify("hit_player");
    if(isDefined(eattacker) && isDefined(eattacker.func_mod_damage_override)) {
      smeansofdeath = eattacker[[eattacker.func_mod_damage_override]](einflictor, smeansofdeath, weapon);
    }
    if(smeansofdeath != "MOD_FALLING") {
      self thread playswipesound(smeansofdeath, eattacker);
      if(isDefined(eattacker.is_zombie) && eattacker.is_zombie || isPlayer(eattacker)) {
        self playrumbleonentity("damage_heavy");
      }
      if(isDefined(eattacker.is_zombie) && eattacker.is_zombie) {
        self zm_audio::create_and_play_dialog("general", "attacked");
      }
      canexert = 1;
      if(isDefined(level.pers_upgrade_flopper) && level.pers_upgrade_flopper) {
        if(isDefined(self.pers_upgrades_awarded["flopper"]) && self.pers_upgrades_awarded["flopper"]) {
          canexert = smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH";
        }
      }
      if(isDefined(canexert) && canexert) {
        if(randomintrange(0, 1) == 0) {
          self thread zm_audio::playerexert("hitmed");
        } else {
          self thread zm_audio::playerexert("hitlrg");
        }
      }
    }
  }
  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_DROWN") {
    self thread zm_audio::playerexert("drowning", 1);
    self.voxdrowning = 1;
  }
  if(isDefined(level.perk_damage_override)) {
    foreach(func in level.perk_damage_override) {
      n_damage = self[[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
      if(isDefined(n_damage)) {
        idamage = n_damage;
      }
    }
  }
  finaldamage = idamage;
  if(zm_utility::is_placeable_mine(weapon)) {
    return 0;
  }
  if(isDefined(self.player_damage_override)) {
    self thread[[self.player_damage_override]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
  }
  if(isDefined(einflictor) && isDefined(einflictor.archetype) && einflictor.archetype == "zombie_quad") {
    if(smeansofdeath == "MOD_EXPLOSIVE") {
      if(self.health > 75) {
        return 75;
      }
    }
  }
  if(smeansofdeath == "MOD_SUICIDE" && self bgb::is_enabled("zm_bgb_danger_closest")) {
    return 0;
  }
  if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
    if(self bgb::is_enabled("zm_bgb_danger_closest")) {
      return 0;
    }
    if(!(isDefined(self.is_zombie) && self.is_zombie)) {
      if(!isDefined(eattacker) || (!(isDefined(eattacker.is_zombie) && eattacker.is_zombie) && (!(isDefined(eattacker.b_override_explosive_damage_cap) && eattacker.b_override_explosive_damage_cap)))) {
        if(isDefined(weapon.name) && (weapon.name == "ray_gun" || weapon.name == "ray_gun_upgraded")) {
          if(self.health > 25 && idamage > 25) {
            return 25;
          }
        } else if(self.health > 75 && idamage > 75) {
          return 75;
        }
      }
    }
  }
  if(idamage < self.health) {
    if(isDefined(eattacker)) {
      if(isDefined(level.custom_kill_damaged_vo)) {
        eattacker thread[[level.custom_kill_damaged_vo]](self);
      } else {
        eattacker.sound_damage_player = self;
      }
      if(isDefined(eattacker.missinglegs) && eattacker.missinglegs) {
        self zm_audio::create_and_play_dialog("general", "crawl_hit");
      }
    }
    return finaldamage;
  }
  if(isDefined(eattacker)) {
    if(isDefined(eattacker.animname) && eattacker.animname == "zombie_dog") {
      self zm_stats::increment_client_stat("killed_by_zdog");
      self zm_stats::increment_player_stat("killed_by_zdog");
    } else if(isDefined(eattacker.is_avogadro) && eattacker.is_avogadro) {
      self zm_stats::increment_client_stat("killed_by_avogadro", 0);
      self zm_stats::increment_player_stat("killed_by_avogadro");
    }
  }
  self thread clear_path_timers();
  if(level.intermission) {
    level waittill("forever");
  }
  if(level.scr_zm_ui_gametype == "zcleansed" && idamage > 0) {
    if(isDefined(eattacker) && isPlayer(eattacker) && eattacker.team != self.team && (!(isDefined(self.laststand) && self.laststand) && !self laststand::player_is_in_laststand() || !isDefined(self.last_player_attacker))) {
      if(isDefined(eattacker.maxhealth) && (isDefined(eattacker.is_zombie) && eattacker.is_zombie)) {
        eattacker.health = eattacker.maxhealth;
      }
      if(isDefined(level.player_kills_player)) {
        self thread[[level.player_kills_player]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
      }
    }
  }
  if(self.lives > 0 && self hasperk("specialty_whoswho")) {
    self.lives--;
    if(isDefined(level.whoswho_laststand_func)) {
      self thread[[level.whoswho_laststand_func]]();
      return 0;
    }
  }
  players = getplayers();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] == self || players[i].is_zombie || players[i] laststand::player_is_in_laststand() || players[i].sessionstate == "spectator") {
      count++;
    }
  }
  if(count < players.size || (isDefined(level._game_module_game_end_check) && ![[level._game_module_game_end_check]]())) {
    if(isDefined(self.lives) && self.lives > 0 && (isDefined(level.force_solo_quick_revive) && level.force_solo_quick_revive) && self hasperk("specialty_quickrevive")) {
      self thread wait_and_revive();
    }
    return finaldamage;
  }
  if(players.size == 1 && level flag::get("solo_game")) {
    if(isDefined(level.no_end_game_check) && level.no_end_game_check || (isDefined(level.check_end_solo_game_override) && [[level.check_end_solo_game_override]]())) {
      return finaldamage;
    }
    if(self.lives == 0 || !self hasperk("specialty_quickrevive")) {
      self.intermission = 1;
    }
  }
  solo_death = players.size == 1 && level flag::get("solo_game") && (self.lives == 0 || !self hasperk("specialty_quickrevive"));
  non_solo_death = count > 1 || (players.size == 1 && !level flag::get("solo_game"));
  if(solo_death || non_solo_death && (!(isDefined(level.no_end_game_check) && level.no_end_game_check))) {
    level notify("stop_suicide_trigger");
    self allowprone(1);
    self thread zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    if(!isDefined(vdir)) {
      vdir = (1, 0, 0);
    }
    self fakedamagefrom(vdir);
    level notify("last_player_died");
    if(isDefined(level.custom_player_fake_death)) {
      self thread[[level.custom_player_fake_death]](vdir, smeansofdeath);
    } else {
      self thread player_fake_death();
    }
  }
  if(count == players.size && (!(isDefined(level.no_end_game_check) && level.no_end_game_check))) {
    if(players.size == 1 && level flag::get("solo_game")) {
      if(self.lives == 0 || !self hasperk("specialty_quickrevive")) {
        self.lives = 0;
        level notify("pre_end_game");
        util::wait_network_frame();
        if(level flag::get("dog_round")) {
          increment_dog_round_stat("lost");
        }
        level notify("end_game");
      } else {
        return finaldamage;
      }
    } else {
      level notify("pre_end_game");
      util::wait_network_frame();
      if(level flag::get("dog_round")) {
        increment_dog_round_stat("lost");
      }
      level notify("end_game");
    }
    return 0;
  }
  surface = "flesh";
  return finaldamage;
}

function clear_path_timers() {
  zombies = getaiteamarray(level.zombie_team);
  foreach(zombie in zombies) {
    if(isDefined(zombie.favoriteenemy) && zombie.favoriteenemy == self) {
      zombie.zombie_path_timer = 0;
    }
  }
}

function check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(!isDefined(level.player_damage_callbacks)) {
    return idamage;
  }
  for(i = 0; i < level.player_damage_callbacks.size; i++) {
    newdamage = self[[level.player_damage_callbacks[i]]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if(-1 != newdamage) {
      return newdamage;
    }
  }
  return idamage;
}

function register_player_damage_callback(func) {
  if(!isDefined(level.player_damage_callbacks)) {
    level.player_damage_callbacks = [];
  }
  level.player_damage_callbacks[level.player_damage_callbacks.size] = func;
}

function wait_and_revive() {
  self endon("remote_revive");
  level flag::set("wait_and_revive");
  level.wait_and_revive = 1;
  if(isDefined(self.waiting_to_revive) && self.waiting_to_revive == 1) {
    return;
  }
  if(isDefined(self.pers_upgrades_awarded["perk_lose"]) && self.pers_upgrades_awarded["perk_lose"]) {
    self zm_pers_upgrades_functions::pers_upgrade_perk_lose_save();
  }
  self.waiting_to_revive = 1;
  self.lives--;
  if(isDefined(level.exit_level_func)) {
    self thread[[level.exit_level_func]]();
  } else if(getplayers().size == 1) {
    player = getplayers()[0];
    level.move_away_points = positionquery_source_navigation(player.origin, 480, 960, 120, 20);
    if(!isDefined(level.move_away_points)) {
      level.move_away_points = positionquery_source_navigation(player.last_valid_position, 480, 960, 120, 20);
    }
  }
  solo_revive_time = 10;
  name = level.player_name_directive[self getentitynumber()];
  self.revive_hud settext(&"ZOMBIE_REVIVING_SOLO", name);
  self laststand::revive_hud_show_n_fade(solo_revive_time);
  level flag::wait_till_timeout(solo_revive_time, "instant_revive");
  if(level flag::get("instant_revive")) {
    self laststand::revive_hud_show_n_fade(1);
  }
  level flag::clear("wait_and_revive");
  level.wait_and_revive = 0;
  self zm_laststand::auto_revive(self);
  self.waiting_to_revive = 0;
  if(isDefined(self.pers_upgrades_awarded["perk_lose"]) && self.pers_upgrades_awarded["perk_lose"]) {
    self thread zm_pers_upgrades_functions::pers_upgrade_perk_lose_restore();
  }
}

function register_vehicle_damage_callback(func) {
  if(!isDefined(level.vehicle_damage_callbacks)) {
    level.vehicle_damage_callbacks = [];
  }
  level.vehicle_damage_callbacks[level.vehicle_damage_callbacks.size] = func;
}

function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(level.vehicle_damage_callbacks)) {
    for(i = 0; i < level.vehicle_damage_callbacks.size; i++) {
      idamage = self[[level.vehicle_damage_callbacks[i]]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
  }
  self globallogic_vehicle::callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isDefined(self) || !isDefined(attacker)) {
    return damage;
  }
  damage = bgb::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
  damage = self check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
  self.knuckles_extinguish_flames = weapon.name == "tazer_knuckles";
  if(isDefined(attacker.animname) && attacker.animname == "quad_zombie") {
    if(isDefined(self.animname) && self.animname == "quad_zombie") {
      return 0;
    }
  }
  if(isDefined(self.killby_interdimensional_gun_hole)) {
    return damage;
  }
  if(isDefined(self.interdimensional_gun_kill)) {
    if(isDefined(self.idgun_damage_cb)) {
      self[[self.idgun_damage_cb]](inflictor, attacker);
      return 0;
    }
  }
  if(isDefined(weapon)) {
    if(is_idgun_damage(weapon) && (!isDefined(meansofdeath) || meansofdeath != "MOD_EXPLOSIVE")) {
      if(!self.archetype === "margwa" && !self.archetype === "mechz") {
        self.damageorigin = vpoint;
        self.allowdeath = 0;
        self.magic_bullet_shield = 1;
        self.interdimensional_gun_kill = 1;
        self.interdimensional_gun_weapon = weapon;
        self.interdimensional_gun_attacker = attacker;
        if(isDefined(inflictor)) {
          self.interdimensional_gun_inflictor = inflictor;
        } else {
          self.interdimensional_gun_inflictor = attacker;
        }
      }
      if(isDefined(self.idgun_damage_cb)) {
        self[[self.idgun_damage_cb]](inflictor, attacker);
      }
      return 0;
    }
  }
  attacker thread zm_audio::sndplayerhitalert(self, meansofdeath, inflictor, weapon);
  if(!isPlayer(attacker) && isDefined(self.non_attacker_func)) {
    if(isDefined(self.non_attack_func_takes_attacker) && self.non_attack_func_takes_attacker) {
      return self[[self.non_attacker_func]](damage, weapon, attacker);
    }
    return self[[self.non_attacker_func]](damage, weapon);
  }
  if(isDefined(attacker) && isai(attacker)) {
    if(self.team == attacker.team && meansofdeath == "MOD_MELEE") {
      return 0;
    }
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }
  if(!isDefined(damage) || !isDefined(meansofdeath)) {
    return damage;
  }
  if(meansofdeath == "") {
    return damage;
  }
  if(isDefined(self.aioverridedamage)) {
    for(index = 0; index < self.aioverridedamage.size; index++) {
      damagecallback = self.aioverridedamage[index];
      damage = self[[damagecallback]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, undefined);
    }
    if(damage < 1) {
      return 0;
    }
    damage = int(damage + 0.5);
  }
  old_damage = damage;
  final_damage = damage;
  if(isDefined(self.actor_damage_func)) {
    final_damage = [[self.actor_damage_func]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
  }
  if(getdvarint("")) {
    println((((("" + (final_damage / old_damage)) + "") + old_damage) + "") + final_damage);
  }
  if(isDefined(self.in_water) && self.in_water) {
    if(int(final_damage) >= self.health) {
      self.water_damage = 1;
    }
  }
  if(isDefined(inflictor) && isDefined(inflictor.archetype) && inflictor.archetype == "glaive") {
    if(meansofdeath == "MOD_CRUSH") {
      if(isDefined(inflictor.enemy) && inflictor.enemy != self || (isDefined(inflictor._glaive_must_return_to_owner) && inflictor._glaive_must_return_to_owner)) {
        if(isDefined(self.archetype) && self.archetype != "margwa") {
          final_damage = final_damage + self.health;
          if(isactor(self)) {
            self zombie_utility::gib_random_parts();
          }
        }
      } else {
        return 0;
      }
    }
  }
  if(isDefined(inflictor) && isPlayer(attacker) && attacker == inflictor) {
    if(meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
      attacker.hits++;
    }
  }
  if(isDefined(level.headshots_only) && level.headshots_only && isDefined(attacker) && isPlayer(attacker)) {
    if(meansofdeath == "MOD_MELEE" && (shitloc == "head" || shitloc == "helmet")) {
      return int(final_damage);
    }
    if(zm_utility::is_explosive_damage(meansofdeath)) {
      return int(final_damage);
    }
    if(!zm_utility::is_headshot(weapon, shitloc, meansofdeath)) {
      return 0;
    }
  }
  return int(final_damage);
}

function check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isDefined(level.actor_damage_callbacks)) {
    return damage;
  }
  for(i = 0; i < level.actor_damage_callbacks.size; i++) {
    newdamage = self[[level.actor_damage_callbacks[i]]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    if(-1 != newdamage) {
      return newdamage;
    }
  }
  return damage;
}

function register_actor_damage_callback(func) {
  if(!isDefined(level.actor_damage_callbacks)) {
    level.actor_damage_callbacks = [];
  }
  level.actor_damage_callbacks[level.actor_damage_callbacks.size] = func;
}

function actor_damage_override_wrapper(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  damage_override = self actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
  willbekilled = (self.health - damage_override) <= 0;
  if(isDefined(level.zombie_damage_override_callbacks)) {
    foreach(func_override in level.zombie_damage_override_callbacks) {
      self thread[[func_override]](willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
  }
  bb::logdamage(attacker, self, weapon, damage_override, meansofdeath, shitloc, willbekilled, willbekilled);
  if(!willbekilled || (!(isDefined(self.dont_die_on_me) && self.dont_die_on_me))) {
    self finishactordamage(inflictor, attacker, damage_override, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
  }
}

function register_zombie_damage_override_callback(func) {
  if(!isDefined(level.zombie_damage_override_callbacks)) {
    level.zombie_damage_override_callbacks = [];
  }
  if(!isDefined(level.zombie_damage_override_callbacks)) {
    level.zombie_damage_override_callbacks = [];
  } else if(!isarray(level.zombie_damage_override_callbacks)) {
    level.zombie_damage_override_callbacks = array(level.zombie_damage_override_callbacks);
  }
  level.zombie_damage_override_callbacks[level.zombie_damage_override_callbacks.size] = func;
}

function actor_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(game["state"] == "postgame") {
    return;
  }
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(attacker.script_owner.team != self.team) {
      attacker = attacker.script_owner;
    }
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }
  if(isDefined(attacker) && isPlayer(attacker)) {
    multiplier = 1;
    if(zm_utility::is_headshot(weapon, shitloc, smeansofdeath)) {
      multiplier = 1.5;
    }
    type = undefined;
    if(isDefined(self.animname)) {
      switch (self.animname) {
        case "quad_zombie": {
          type = "quadkill";
          break;
        }
        case "ape_zombie": {
          type = "apekill";
          break;
        }
        case "zombie": {
          type = "zombiekill";
          break;
        }
        case "zombie_dog": {
          type = "dogkill";
          break;
        }
      }
    }
  }
  if(isDefined(self.is_ziplining) && self.is_ziplining) {
    self.deathanim = undefined;
  }
  if(isDefined(self.actor_killed_override)) {
    self[[self.actor_killed_override]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
  if(isDefined(self.deathfunction)) {
    self[[self.deathfunction]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

function round_end_monitor() {
  while(true) {
    level waittill("end_of_round");
    demo::bookmark("zm_round_end", gettime(), undefined, undefined, 1);
    bbpostdemostreamstatsforround(level.round_number);
    zm_utility::upload_zm_dash_counters();
    wait(0.05);
  }
}

function updateendofmatchcounters() {
  zm_utility::increment_zm_dash_counter("end_per_game", 1);
  zm_utility::increment_zm_dash_counter("end_per_player", level.players.size);
  if(!(isDefined(level.dash_counter_round_reached_5) && level.dash_counter_round_reached_5)) {
    zm_utility::increment_zm_dash_counter("end_less_5", 1);
  } else {
    if(!(isDefined(level.dash_counter_round_reached_10) && level.dash_counter_round_reached_10)) {
      zm_utility::increment_zm_dash_counter("end_reached_5_less_10", 1);
    } else {
      zm_utility::increment_zm_dash_counter("end_reached_10", 1);
    }
  }
  if(!zm_utility::is_solo_ranked_game()) {
    if(level.dash_counter_start_player_count != level.players.size) {
      zm_utility::increment_zm_dash_counter("end_player_count_diff", 1);
    }
  }
}

function end_game() {
  level waittill("end_game");
  check_end_game_intermission_delay();
  println("");
  setmatchflag("game_ended", 1);
  level clientfield::set("gameplay_started", 0);
  level clientfield::set("game_end_time", int(((gettime() - level.n_gameplay_start_time) + 500) / 1000));
  util::clientnotify("zesn");
  level thread zm_audio::sndmusicsystem_playstate("game_over");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] clientfield::set("zmbLastStand", 0);
  }
  for(i = 0; i < players.size; i++) {
    if(players[i] laststand::player_is_in_laststand()) {
      players[i] recordplayerdeathzombies();
      players[i] zm_stats::increment_player_stat("deaths");
      players[i] zm_stats::increment_client_stat("deaths");
      players[i] zm_pers_upgrades_functions::pers_upgrade_jugg_player_death_stat();
    }
    if(isDefined(players[i].revivetexthud)) {
      players[i].revivetexthud destroy();
    }
  }
  stopallrumbles();
  level.intermission = 1;
  level.zombie_vars["zombie_powerup_insta_kill_time"] = 0;
  level.zombie_vars["zombie_powerup_fire_sale_time"] = 0;
  level.zombie_vars["zombie_powerup_double_points_time"] = 0;
  wait(0.1);
  game_over = [];
  survived = [];
  players = getplayers();
  setmatchflag("disableIngameMenu", 1);
  foreach(player in players) {
    player closeingamemenu();
    player closemenu("StartMenu_Main");
  }
  foreach(player in players) {
    player setdstat("AfterActionReportStats", "lobbyPopup", "summary");
  }
  if(!isDefined(level._supress_survived_screen)) {
    for(i = 0; i < players.size; i++) {
      game_over[i] = newclienthudelem(players[i]);
      survived[i] = newclienthudelem(players[i]);
      if(isDefined(level.custom_game_over_hud_elem)) {
        [[level.custom_game_over_hud_elem]](players[i], game_over[i], survived[i]);
      } else {
        game_over[i].alignx = "center";
        game_over[i].aligny = "middle";
        game_over[i].horzalign = "center";
        game_over[i].vertalign = "middle";
        game_over[i].y = game_over[i].y - 130;
        game_over[i].foreground = 1;
        game_over[i].fontscale = 3;
        game_over[i].alpha = 0;
        game_over[i].color = (1, 1, 1);
        game_over[i].hidewheninmenu = 1;
        game_over[i] settext(&"ZOMBIE_GAME_OVER");
        game_over[i] fadeovertime(1);
        game_over[i].alpha = 1;
        if(players[i] issplitscreen()) {
          game_over[i].fontscale = 2;
          game_over[i].y = game_over[i].y + 40;
        }
        survived[i].alignx = "center";
        survived[i].aligny = "middle";
        survived[i].horzalign = "center";
        survived[i].vertalign = "middle";
        survived[i].y = survived[i].y - 100;
        survived[i].foreground = 1;
        survived[i].fontscale = 2;
        survived[i].alpha = 0;
        survived[i].color = (1, 1, 1);
        survived[i].hidewheninmenu = 1;
        if(players[i] issplitscreen()) {
          survived[i].fontscale = 1.5;
          survived[i].y = survived[i].y + 40;
        }
      }
      if(level.round_number < 2) {
        if(level.script == "zm_moon") {
          if(!isDefined(level.left_nomans_land)) {
            nomanslandtime = level.nml_best_time;
            player_survival_time = int(nomanslandtime / 1000);
            player_survival_time_in_mins = to_mins(player_survival_time);
            survived[i] settext(&"ZOMBIE_SURVIVED_NOMANS", player_survival_time_in_mins);
          } else if(level.left_nomans_land == 2) {
            survived[i] settext(&"ZOMBIE_SURVIVED_ROUND");
          }
        } else {
          survived[i] settext(&"ZOMBIE_SURVIVED_ROUND");
        }
      } else {
        survived[i] settext(&"ZOMBIE_SURVIVED_ROUNDS", level.round_number);
      }
      survived[i] fadeovertime(1);
      survived[i].alpha = 1;
    }
  }
  if(isDefined(level.custom_end_screen)) {
    level[[level.custom_end_screen]]();
  }
  for(i = 0; i < players.size; i++) {
    players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
    players[i] setclientminiscoreboardhide(1);
    players[i] notify("report_bgb_consumption");
    players[i] zm_utility::zm_dash_stats_game_end();
  }
  uploadstats();
  zm_stats::update_players_stats_at_match_end(players);
  zm_stats::update_global_counters_on_match_end();
  bb::logroundevent("end_game");
  upload_leaderboards();
  recordgameresult("draw");
  globallogic::recordzmendgamecomscoreevent("draw");
  globallogic_player::recordactiveplayersendgamematchrecordstats();
  updateendofmatchcounters();
  if(sessionmodeisonlinegame()) {
    level thread zm_utility::upload_zm_dash_counters_end_game();
  }
  finalizematchrecord();
  players = getplayers();
  foreach(player in players) {
    if(isDefined(player.sessionstate) && player.sessionstate == "spectator") {
      player.sessionstate = "playing";
      player thread end_game_player_was_spectator();
    }
  }
  wait(0.05);
  if(!(isDefined(level.host_ended_game) && level.host_ended_game) && getdvarint("") > 1) {
    luinotifyevent(&"", 0);
    map_restart(1);
    wait(666);
  }
  players = getplayers();
  luinotifyevent(&"force_scoreboard", 1, 1);
  intermission();
  wait(level.zombie_vars["zombie_intermission_time"]);
  if(!isDefined(level._supress_survived_screen)) {
    for(i = 0; i < players.size; i++) {
      survived[i] destroy();
      game_over[i] destroy();
    }
  } else {
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].survived_hud)) {
        players[i].survived_hud destroy();
      }
      if(isDefined(players[i].game_over_hud)) {
        players[i].game_over_hud destroy();
      }
    }
  }
  level notify("stop_intermission");
  array::thread_all(getplayers(), &player_exit_level);
  wait(1.5);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] cameraactivate(0);
  }
  if(!(isDefined(level.host_ended_game) && level.host_ended_game) && getdvarint("")) {
    luinotifyevent(&"", 1, 0);
    map_restart(1);
    wait(666);
  }
  exitlevel(0);
  wait(666);
}

function end_game_player_was_spectator() {
  wait(0.05);
  self ghost();
  self freezecontrols(1);
}

function disable_end_game_intermission(delay) {
  level.disable_intermission = 1;
  wait(delay);
  level.disable_intermission = undefined;
}

function check_end_game_intermission_delay() {
  if(isDefined(level.disable_intermission)) {
    while(true) {
      if(!isDefined(level.disable_intermission)) {
        break;
      }
      wait(0.01);
    }
  }
}

function upload_leaderboards() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] uploadleaderboards();
  }
}

function initializestattracking() {
  level.global_zombies_killed = 0;
  level.zombies_timeout_spawn = 0;
  level.zombies_timeout_playspace = 0;
  level.zombies_timeout_undamaged = 0;
  level.zombie_player_killed_count = 0;
  level.zombie_trap_killed_count = 0;
  level.zombie_pathing_failed = 0;
  level.zombie_breadcrumb_failed = 0;
}

function uploadglobalstatcounters() {
  incrementcounter("global_zombies_killed", level.global_zombies_killed);
  incrementcounter("global_zombies_killed_by_players", level.zombie_player_killed_count);
  incrementcounter("global_zombies_killed_by_traps", level.zombie_trap_killed_count);
}

function player_fake_death() {
  level notify("fake_death");
  self notify("fake_death");
  self takeallweapons();
  self allowstand(0);
  self allowcrouch(0);
  self allowprone(1);
  self.ignoreme = 1;
  self enableinvulnerability();
  wait(1);
  self freezecontrols(1);
}

function player_exit_level() {
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
}

function player_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  level waittill("forever");
}

function player_zombie_breadcrumb() {
  self notify("stop_player_zombie_breadcrumb");
  self endon("stop_player_zombie_breadcrumb");
  self endon("disconnect");
  self endon("spawned_spectator");
  level endon("intermission");
  self.zombie_breadcrumbs = [];
  self.zombie_breadcrumb_distance = 576;
  self.zombie_breadcrumb_area_num = 3;
  self.zombie_breadcrumb_area_distance = 16;
  self store_crumb(self.origin);
  last_crumb = self.origin;
  self thread zm_utility::debug_breadcrumbs();
  while(true) {
    wait_time = 0.1;
    if(self.ignoreme) {
      wait(wait_time);
      continue;
    }
    store_crumb = 1;
    airborne = 0;
    crumb = self.origin;
    if(!self isonground() && self isinvehicle()) {
      trace = bulletTrace(self.origin + vectorscale((0, 0, 1), 10), self.origin, 0, undefined);
      crumb = trace["position"];
    }
    if(!airborne && distancesquared(crumb, last_crumb) < self.zombie_breadcrumb_distance) {
      store_crumb = 0;
    }
    if(airborne && self isonground()) {
      store_crumb = 1;
      airborne = 0;
    }
    if(isDefined(level.custom_breadcrumb_store_func)) {
      store_crumb = self[[level.custom_breadcrumb_store_func]](store_crumb);
    }
    if(isDefined(level.custom_airborne_func)) {
      airborne = self[[level.custom_airborne_func]](airborne);
    }
    if(store_crumb) {
      zm_utility::debug_print("Player is storing breadcrumb " + crumb);
      if(isDefined(self.node)) {
        zm_utility::debug_print("has closest node ");
      }
      last_crumb = crumb;
      self store_crumb(crumb);
    }
    wait(wait_time);
  }
}

function store_crumb(origin) {
  offsets = [];
  height_offset = 32;
  index = 0;
  for(j = 1; j <= self.zombie_breadcrumb_area_num; j++) {
    offset = j * self.zombie_breadcrumb_area_distance;
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

function to_mins(seconds) {
  hours = 0;
  minutes = 0;
  if(seconds > 59) {
    minutes = int(seconds / 60);
    seconds = (int(seconds * 1000)) % 60000;
    seconds = seconds * 0.001;
    if(minutes > 59) {
      hours = int(minutes / 60);
      minutes = (int(minutes * 1000)) % 60000;
      minutes = minutes * 0.001;
    }
  }
  if(hours < 10) {
    hours = "0" + hours;
  }
  if(minutes < 10) {
    minutes = "0" + minutes;
  }
  seconds = int(seconds);
  if(seconds < 10) {
    seconds = "0" + seconds;
  }
  combined = (((("" + hours) + ":") + minutes) + ":") + seconds;
  return combined;
}

function intermission() {
  level.intermission = 1;
  level notify("intermission");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] setclientthirdperson(0);
    players[i] resetfov();
    players[i].health = 100;
    players[i] thread[[level.custom_intermission]]();
    players[i] stopsounds();
  }
  wait(5.25);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] clientfield::set("zmbLastStand", 0);
  }
  level thread zombie_game_over_death();
}

function zombie_game_over_death() {
  zombies = getaiteamarray(level.zombie_team);
  for(i = 0; i < zombies.size; i++) {
    if(!isalive(zombies[i])) {
      continue;
    }
    zombies[i] setgoal(zombies[i].origin);
  }
  for(i = 0; i < zombies.size; i++) {
    if(!isalive(zombies[i])) {
      continue;
    }
    if(isDefined(zombies[i].ignore_game_over_death) && zombies[i].ignore_game_over_death) {
      continue;
    }
    wait(0.5 + randomfloat(2));
    if(isDefined(zombies[i])) {
      if(!isvehicle(zombies[i])) {
        zombies[i] zombie_utility::zombie_head_gib();
      }
      zombies[i] kill();
    }
  }
}

function screen_fade_in(n_time, v_color, str_menu_id) {
  lui::screen_fade(n_time, 0, 1, v_color, 0, str_menu_id);
  wait(n_time);
}

function player_intermission() {
  self closeingamemenu();
  self closemenu("StartMenu_Main");
  self notify("player_intermission");
  self endon("player_intermission");
  level endon("stop_intermission");
  self endon("disconnect");
  self endon("death");
  self notify("_zombie_game_over");
  self.score = self.score_total;
  points = struct::get_array("intermission", "targetname");
  if(!isDefined(points) || points.size == 0) {
    points = getEntArray("info_intermission", "classname");
    if(points.size < 1) {
      println("");
      return;
    }
  }
  if(isDefined(level.b_show_single_intermission) && level.b_show_single_intermission) {
    a_s_temp_points = array::randomize(points);
    points = [];
    points[0] = array::random(a_s_temp_points);
  } else {
    points = array::randomize(points);
  }
  self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
  wait(5);
  self lui::screen_fade_out(1);
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  if(isDefined(level.player_intemission_spawn_callback)) {
    self thread[[level.player_intemission_spawn_callback]](points[0].origin, points[0].angles);
  }
  while(true) {
    for(i = 0; i < points.size; i++) {
      point = points[i];
      nextpoint = points[i + 1];
      self setorigin(point.origin);
      self setplayerangles(point.angles);
      wait(0.15);
      self notify("player_intermission_spawned");
      if(isDefined(nextpoint)) {
        self zm_utility::create_streamer_hint(nextpoint.origin, nextpoint.angles, 0.9);
        self screen_fade_in(2);
        wait(3);
        self lui::screen_fade_out(2);
        continue;
      }
      self screen_fade_in(2);
      if(points.size == 1) {
        return;
      }
    }
  }
}

function fade_up_over_time(t) {
  self fadeovertime(t);
  self.alpha = 1;
}

function default_exit_level() {
  zombies = getaiteamarray(level.zombie_team);
  for(i = 0; i < zombies.size; i++) {
    if(isDefined(zombies[i].ignore_solo_last_stand) && zombies[i].ignore_solo_last_stand) {
      continue;
    }
    if(isDefined(zombies[i].find_exit_point)) {
      zombies[i] thread[[zombies[i].find_exit_point]]();
      continue;
    }
    if(zombies[i].ignoreme) {
      zombies[i] thread default_delayed_exit();
      continue;
    }
    zombies[i] thread default_find_exit_point();
  }
}

function default_delayed_exit() {
  self endon("death");
  while(true) {
    if(!level flag::get("wait_and_revive")) {
      return;
    }
    if(!self.ignoreme) {
      break;
    }
    wait(0.1);
  }
  self thread default_find_exit_point();
}

function default_find_exit_point() {
  self endon("death");
  player = getplayers()[0];
  dist_zombie = 0;
  dist_player = 0;
  dest = 0;
  away = vectornormalize(self.origin - player.origin);
  endpos = self.origin + vectorscale(away, 600);
  if(isDefined(level.zm_loc_types["wait_location"]) && level.zm_loc_types["wait_location"].size > 0) {
    locs = array::randomize(level.zm_loc_types["wait_location"]);
  } else {
    locs = array::randomize(level.zm_loc_types["dog_location"]);
  }
  for(i = 0; i < locs.size; i++) {
    dist_zombie = distancesquared(locs[i].origin, endpos);
    dist_player = distancesquared(locs[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      dest = i;
      break;
    }
  }
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  if(isDefined(locs[dest])) {
    self setgoal(locs[dest].origin);
  }
  while(true) {
    b_passed_override = 1;
    if(isDefined(level.default_find_exit_position_override)) {
      b_passed_override = [[level.default_find_exit_position_override]]();
    }
    if(!level flag::get("wait_and_revive") && b_passed_override) {
      break;
    }
    wait(0.1);
  }
}

function play_level_start_vox_delayed() {
  wait(3);
  players = getplayers();
  num = randomintrange(0, players.size);
  players[num] zm_audio::create_and_play_dialog("general", "intro");
}

function register_sidequest(id, sidequest_stat) {
  if(!isDefined(level.zombie_sidequest_stat)) {
    level.zombie_sidequest_previously_completed = [];
    level.zombie_sidequest_stat = [];
  }
  level.zombie_sidequest_stat[id] = sidequest_stat;
  level flag::wait_till("start_zombie_round_logic");
  level.zombie_sidequest_previously_completed[id] = 0;
  if(!level.onlinegame) {
    return;
  }
  if(isDefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
    return;
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] zm_stats::get_global_stat(level.zombie_sidequest_stat[id])) {
      level.zombie_sidequest_previously_completed[id] = 1;
      return;
    }
  }
}

function is_sidequest_previously_completed(id) {
  return isDefined(level.zombie_sidequest_previously_completed[id]) && level.zombie_sidequest_previously_completed[id];
}

function set_sidequest_completed(id) {
  level notify("zombie_sidequest_completed", id);
  level.zombie_sidequest_previously_completed[id] = 1;
  if(!level.onlinegame) {
    return;
  }
  if(isDefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
    return;
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(level.zombie_sidequest_stat[id])) {
      players[i] zm_stats::add_global_stat(level.zombie_sidequest_stat[id], 1);
    }
  }
}

function playswipesound(mod, attacker) {
  if(isDefined(attacker.is_zombie) && attacker.is_zombie || (isDefined(attacker.archetype) && attacker.archetype == "margwa")) {
    self playsoundtoplayer("evt_player_swiped", self);
    return;
  }
}

function precache_zombie_leaderboards() {
  if(sessionmodeissystemlink()) {
    return;
  }
  globalleaderboards = "LB_ZM_GB_BULLETS_FIRED_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_BULLETS_HIT_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_DISTANCE_TRAVELED_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_DOORS_PURCHASED_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_GRENADE_KILLS_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_HEADSHOTS_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_KILLS_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_PERKS_DRANK_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_REVIVES_AT ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_KILLSTATS_MR ";
  globalleaderboards = globalleaderboards + "LB_ZM_GB_GAMESTATS_MR ";
  if(!level.rankedmatch && getdvarint("zm_private_rankedmatch", 0) == 0) {
    precacheleaderboards(globalleaderboards);
    return;
  }
  mapname = getdvarstring("mapname");
  expectedplayernum = getnumexpectedplayers();
  mapleaderboard = ((("LB_ZM_MAP_" + getsubstr(mapname, 3, mapname.size)) + "_") + expectedplayernum) + "PLAYER";
  precacheleaderboards(globalleaderboards + mapleaderboard);
}

function zm_on_player_connect() {
  if(level.passed_introscreen) {
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    zm_utility::increment_zm_dash_counter("hotjoined", 1);
    zm_utility::upload_zm_dash_counters();
  }
  self flag::init("used_consumable");
  self thread zm_utility::zm_dash_stats_game_start();
  self thread zm_utility::zm_dash_stats_wait_for_consumable_use();
  thread refresh_player_navcard_hud();
  self thread watchdisconnect();
  self.hud_damagefeedback = newdamageindicatorhudelem(self);
  self.hud_damagefeedback.horzalign = "center";
  self.hud_damagefeedback.vertalign = "middle";
  self.hud_damagefeedback.x = -12;
  self.hud_damagefeedback.y = -12;
  self.hud_damagefeedback.alpha = 0;
  self.hud_damagefeedback.archived = 1;
  self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  self.hitsoundtracker = 1;
}

function zm_on_player_disconnect() {
  thread refresh_player_navcard_hud();
  zm_utility::increment_zm_dash_counter("left_midgame", 1);
  zm_utility::upload_zm_dash_counters();
}

function watchdisconnect() {
  self notify("watchdisconnect");
  self endon("watchdisconnect");
  self waittill("disconnect");
  zm_on_player_disconnect();
}

function increment_dog_round_stat(stat) {
  players = getplayers();
  foreach(player in players) {
    player zm_stats::increment_client_stat("zdog_rounds_" + stat);
  }
}

function setup_player_navcard_hud() {
  level flag::wait_till("start_zombie_round_logic");
  thread refresh_player_navcard_hud();
}

function refresh_player_navcard_hud() {
  if(!isDefined(level.navcards)) {
    return;
  }
  players = getplayers();
  foreach(player in players) {
    navcard_bits = 0;
    for(i = 0; i < level.navcards.size; i++) {
      hasit = player zm_stats::get_global_stat(level.navcards[i]);
      if(isDefined(player.navcard_grabbed) && player.navcard_grabbed == level.navcards[i]) {
        hasit = 1;
      }
      if(hasit) {
        navcard_bits = navcard_bits + (1 << i);
      }
    }
    util::wait_network_frame();
    player clientfield::set("navcard_held", 0);
    if(navcard_bits > 0) {
      util::wait_network_frame();
      player clientfield::set("navcard_held", navcard_bits);
    }
  }
}

function set_default_laststand_pistol(solo_mode) {
  if(!solo_mode) {
    level.laststandpistol = level.default_laststandpistol;
  } else {
    level.laststandpistol = level.default_solo_laststandpistol;
  }
}

function player_too_many_players_check() {
  max_players = 4;
  if(level.scr_zm_ui_gametype == "zgrief" || level.scr_zm_ui_gametype == "zmeat") {
    max_players = 8;
  }
  if(getplayers().size > max_players) {
    zm_game_module::freeze_players(1);
    level notify("end_game");
  }
}

function is_idgun_damage(weapon) {
  if(isDefined(level.idgun_weapons)) {
    if(isinarray(level.idgun_weapons, weapon)) {
      return true;
    }
  }
  return false;
}

function zm_on_player_spawned() {
  thread update_zone_name();
  thread update_is_player_valid();
}

function update_is_player_valid() {
  self endon("death");
  self endon("disconnnect");
  self.am_i_valid = 1;
  while(isDefined(self)) {
    self.am_i_valid = zm_utility::is_player_valid(self, 1);
    wait(0.05);
  }
}

function update_zone_name() {
  self endon("death");
  self endon("disconnnect");
  self.zone_name = zm_utility::get_current_zone();
  if(isDefined(self.zone_name)) {
    self.previous_zone_name = self.zone_name;
  }
  while(isDefined(self)) {
    if(isDefined(self.zone_name)) {
      self.previous_zone_name = self.zone_name;
    }
    self.zone_name = zm_utility::get_current_zone();
    wait(randomfloatrange(0.5, 1));
  }
}

function printhashids() {
  outputstring = "";
  outputstring = outputstring + "";
  foreach(s_craftable in level.zombie_include_craftables) {
    outputstring = outputstring + (((("" + s_craftable.name) + "") + s_craftable.var_2c8ee667) + "");
    if(!isDefined(s_craftable.a_piecestubs)) {
      continue;
    }
    foreach(s_piece in s_craftable.a_piecestubs) {
      outputstring = outputstring + (((s_piece.piecename + "") + s_piece.var_2c8ee667) + "");
    }
  }
  outputstring = outputstring + "";
  foreach(powerup in level.zombie_powerups) {
    outputstring = outputstring + (((powerup.powerup_name + "") + powerup.var_2c8ee667) + "");
  }
  outputstring = outputstring + "";
  if(isDefined(level.aat_in_use) && level.aat_in_use) {
    foreach(aat in level.aat) {
      if(!isDefined(aat) || !isDefined(aat.name) || aat.name == "") {
        continue;
      }
      outputstring = outputstring + (((aat.name + "") + aat.var_2c8ee667) + "");
    }
  }
  outputstring = outputstring + "";
  foreach(perk in level._custom_perks) {
    if(!isDefined(perk) || !isDefined(perk.alias)) {
      continue;
    }
    outputstring = outputstring + (((perk.alias + "") + perk.var_2c8ee667) + "");
  }
  outputstring = outputstring + "";
  println(outputstring);
}