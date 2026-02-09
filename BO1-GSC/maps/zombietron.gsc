/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombietron.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

main() {
  maps\zombietron_fx::main();
  level._ZOMBIE_GIB_PIECE_INDEX_ALL = 0;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM = 1;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM = 2;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG = 3;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG = 4;
  level._ZOMBIE_GIB_PIECE_INDEX_HEAD = 5;
  level._ZOMBIE_GIB_PIECE_INDEX_GUTS = 6;
  precache_shaders();
  precache_models();
  init_dvars();
  init_strings();
  init_levelvars();
  init_animscripts();
  init_sounds();
  init_shellshocks();
  init_flags();
  init_fx();
  level thread zombie_devgui_think();
  maps\_zombietron_challenges::main();
  maps\_zombietron_main::main();
  maps\createart\zombietron_art::main();
  setDvar("scr_expDeathMayMoveCheck", "off");
}
onPlayerConnect() {
  self notify("onPlayerConnect");
  self endon("onPlayerConnect");
  for(;;) {
    level waittill("connecting", player);
    player.entity_num = player GetEntityNumber();
    player thread onPlayerSpawned();
    player thread onPlayerDisconnect();
    player thread maps\_zombietron_pickups::update_drop_bomb();
    player thread maps\_zombietron_pickups::update_drop_booster();
    player.stats["kills"] = 0;
    player.stats["score"] = 0;
  }
}
cheat_Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  return 0;
}
onPlayerDisconnect() {
  self waittill("disconnect");
}
onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    wait 1;
    self SetDepthOfField(0, 0, 512, 4000, 4, 0);
    self SetPlayerCollision(1);
    self maps\_zombietron_main::player_reset_score();
    self.default_movespeed = 1;
    self.score_total = self.score;
    self.old_score = self.score;
    self.team_num = 0;
    self.default_weap = "m60_zt";
    self TakeAllWeapons();
    self.next_extra_life = level.zombie_vars["extra_life_at_every"];
    self.pointBarInc = level.zombie_vars["prize_increment"];
    self maps\_zombietron_score::update_hud();
    self setTeamForEntity("allies");
    self DisableWeaponCycling();
    self AllowJump(false);
    self AllowCrouch(false);
    self AllowSprint(false);
    self SetStance("stand");
    self.dog_damage_func = maps\_zombietron_ai_dog::dog_player_damage;
    self maps\_zombietron_score::update_multiplier_bar(0);
    self SetClientDvars("cg_objectiveIndicatorFarFadeDist", "120000", "cg_objectiveIndicatornearFadeDist", "0", "ik_enable", 0, "cg_drawCrosshair", 0, "bg_legYawTolerance", 0);
    self setClientDvars("aim_lockon_pitch_strength", 0.0, "hud_drawHUD", "1", "cl_scoreDraw", "1");
    SetSavedDvar("phys_maxFloatTime", 10000);
    level.xenon = (getDvar(#"xenonGame") == "true");
    if(!isDefined(level.xenon)) {
      level.xenon = false;
    }
    self TakeAllWeapons();
    self GiveWeapon(self.default_weap);
    self switchToWeapon(self.default_weap);
    self SetSpawnWeapon(self.default_weap);
    self thread setup_smashtv_loadout();
    self thread ammo();
    if(!isDefined(self.initialized) || self.initialized == false) {
      self.initialized = true;
      playtag = "player" + (self.entity_num + 1) + "_light";
      self.light_playFX = playtag;
      playFXOnTag(level._effect[playtag], self, "tag_origin");
      self thread breadcrumb_point_thread(30, 0.5);
    }
  }
}
precache_shaders() {
  PreCacheShader("cinematic");
  PrecacheShader("zom_icon_community_pot");
  PrecacheShader("zom_icon_community_pot_strip");
  PrecacheShader("zom_icon_player_life");
  PrecacheShader("zom_pack_a_punch_battery_icon");
  PrecacheShader("text_box");
}
precache_models() {
  precachemodel("char_ger_zombieeye");
  PrecacheModel("zombie_z_money_icon");
  PrecacheModel("anim_chicken");
  PrecacheModel("zombie_teleporter_pad");
  PrecacheModel("c_usa_blackops_body3_fb");
  PrecacheModel("c_usa_blackops_body3_fb_zt");
  PrecacheModel("c_zom_blue_guy_fb_zt");
  PrecacheModel("c_zom_red_guy_fb_zt");
  PrecacheModel("c_zom_yellow_guy_fb_zt");
  PrecacheModel("c_zom_blue_guy_fb");
  PrecacheModel("c_zom_red_guy_fb");
  PrecacheModel("c_zom_yellow_guy_fb");
}
init_shellshocks() {
  level.player_killed_shellshock = "zombie_death";
  PrecacheShellshock(level.player_killed_shellshock);
}
init_strings() {}
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
  add_sound("door_slide_open", "zmb_door_slide_open");
  add_sound("door_rotate_open", "zmb_door_slide_open");
}
init_levelvars() {
  level.dogshit = 0;
  level.is_zombie_level = true;
  level.in_intermission = false;
  level.round_number = 1;
  level.arena_round_number = 1;
  level.zombie_total = 0;
  level.total_zombies_killed = 0;
  level.total_boss_killed = 0;
  level.hudelem_count = 0;
  level.teleporter_spawned = false;
  level.flipped = false;
  level.epic_boss_battle = false;
  level.lastmagical_exit_taken = 0;
  level.lastmagical_armory = undefined;
  level.magical_exit_taken = false;
  level.fates_have_been_chosen = false;
  level.active_monkeys = [];
  level.active_heli = [];
  level.heli_height = 55;
  level.music_state_fate_round = false;
  level.victory_movie = "zmb_tron_victory";
  level.raining = false;
  flag_init("boss_intro_done");
  flag_init("boss_spawn_go");
  flag_init("boss_is_spawned");
  flag_init("boss_is_dead");
  flag_init("round_is_active");
  flag_init("all_players_dead");
  flag_init("exits_open");
  flag_init("barrel_burst1");
  flag_init("barrel_burst2");
  level.previous_exit_taken = "right";
  maps\_zombietron_main::arena_initialize();
  set_zombie_var("zombie_move_speed", 30);
  set_zombie_var("zombie_health", 1000);
  set_zombie_var("zombie_arena_rounds", 4);
  set_zombie_var("player_speed", 1.5);
  set_zombie_var("tank_alive_time", 20);
  set_zombie_var("heli_alive_time", 20);
  set_zombie_var("mini_turret_time", 30);
  set_zombie_var("mini_turret_min_round", 4);
  set_zombie_var("player_speed_time", 10);
  set_zombie_var("double_shot_time", 40);
  set_zombie_var("double_shot_upgrade", 3);
  set_zombie_var("barrel_time", 20);
  set_zombie_var("tesla_time", 40);
  set_zombie_var("stun_time", 20);
  set_zombie_var("stun_effect_time", 8);
  set_zombie_var("pickup_time", 10);
  set_zombie_var("zombie_health_inc", 150);
  set_zombie_var("zombie_speed_inc", 5);
  set_zombie_var("zombie_treasure_regular", 3);
  set_zombie_var("zombie_treasure_weapon_drops_max", 3);
  set_zombie_var("zombie_treasure_weapon_drops_min", 1);
  set_zombie_var("zombie_treasure_boss", 25);
  set_zombie_var("zombie_points_regular", 100);
  set_zombie_var("zombie_points_boss", 30000);
  set_zombie_var("ape_zombie_health", 500000);
  set_zombie_var("mini_boss_health", 10000);
  set_zombie_var("mini_boss_interval_min", 5);
  set_zombie_var("mini_boss_interval_max", 10);
  set_zombie_var("mini_boss_spawn_percentage", 30);
  set_zombie_var("dog_fire_trail_percent", 50);
  set_zombie_var("fate_level_min", 13);
  set_zombie_var("fate_level_max", 15);
  set_zombie_var("fate_level_chance", 30);
  set_zombie_var("fate_fortune_drop_mod", 2);
  set_zombie_var("fate_wait", 30);
  set_zombie_var("max_lives", 9);
  set_zombie_var("max_bombs", 9);
  set_zombie_var("max_boost", 9);
  set_zombie_var("max_multiplier", 9);
  set_zombie_var("prize_increment", 20);
  set_zombie_var("max_prize_inc_range", 512);
  set_zombie_var("prize_points", 125);
  set_zombie_var("rare_price_percentage", 1);
  set_zombie_var("min_extra_life_spawn_time", 240);
  set_zombie_var("max_extra_life_spawn_time", 540);
  set_zombie_var("monkey_fuse_time", 10);
  set_zombie_var("monkey_attract_dist", 300);
  set_zombie_var("extra_life_at_every", 200000);
  set_zombie_var("boss_taunt_percent_per_level", 10);
  set_zombie_var("powerup_timeout", 12);
  set_zombie_var("powerup_uber_timeout", 24);
  set_zombie_var("sacred_cow_chance", 5);
  set_zombie_var("moss_martyrdom_chance", 20);
  set_zombie_var("armory_chance", 20);
  set_zombie_var("zombie_max_waves", 30);
  set_zombie_var("auto_respawn_timeout", 60);
  level.zombie_health = level.zombie_vars["zombie_health"];
  level.zombie_move_speed = level.zombie_vars["zombie_move_speed"];
  level.default_ai_limit = 32;
  SetAILimit(level.default_ai_limit);
  if(getDvar(#"zombie_dog_animset") == "") {
    setDvar("zombie_dog_animset", "zombie");
  }
}
init_dvars() {
  setSavedDvar("fire_world_damage", "0");
  setSavedDvar("fire_world_damage_rate", "0");
  setSavedDvar("fire_world_damage_duration", "0");
  SetSavedDvar("sv_restrictedtempents", "1");
}
init_flags() {}
init_fx() {
  maps\_zombietron_ai_ape::precache_ape_fx();
  maps\_zombietron_ai_dog::precache_dog_fx();
  maps\_zombietron_ai_engineer::precache_engineer_fx();
}
#using_animtree("generic_human");

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
  level.scr_anim["zombie"]["walk7"] = % ai_zombie_walk_v8;
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
  level._zombie_run_taunt["zombie"] = [];
}
init_animscripts() {
  animscripts\zombie_init::firstInit();
  animscripts\zombie_dog_init::initDogAnimations();
  anim.idleAnimArray["stand"] = [];
  anim.idleAnimWeights["stand"] = [];
  anim.idleAnimArray["stand"][0][0] = % ai_zombie_idle_v1_delta;
  anim.idleAnimWeights["stand"][0][0] = 10;
  anim.idleAnimArray["crouch"] = [];
  anim.idleAnimWeights["crouch"] = [];
  anim.idleAnimArray["crouch"][0][0] = % ai_zombie_idle_crawl_delta;
  anim.idleAnimWeights["crouch"][0][0] = 10;
  init_standard_zombie_anims();
  maps\_zombietron_ai_ape::init_ape_zombie_anims();
  maps\_zombietron_ai_quad::init_quad_zombie_anims();
  maps\_zombietron_ai_engineer::init_engineer_zombie_anims();
}
force_game_controller_bindings() {
  level.dogshit++;
  level.dogshit = level.dogshit & 7;
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] setclientflagasval(level.dogshit);
  }
}
menu_message(state, item) {
  if(state == "close") {
    switch (item) {
      case "pausedmenu":
        force_game_controller_bindings();
        break;
    }
  }
}
zombie_devgui_think() {}