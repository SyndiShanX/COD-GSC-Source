/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\tunnels.gsc
***********************************************/

function main() {
  scripts\sp\maps\tunnels\gen\tunnels_art::main();
  scripts\sp\maps\tunnels\tunnels_fx::main();
  scripts\sp\maps\tunnels\tunnels_precache::main();
  scripts\sp\maps\tunnels\zd30tunnels_anim::main();
  scripts\sp\maps\tunnels\zd30tunnels_lighting::main();
  scripts\sp\player\flare::level_flareinit();
  level.tossed_flares = [];
  level.flare_pickup_disabled = 1;
  level.flarefastpickup = 1;
  level.player setclienttriggeraudiozone("fade_to_black_minus_music", 0.05);
  var0 = getEnt("info_player_start", "classname");
  var0.origin = (-14848, -536, 296);
  var1 = undefined;
  scripts\engine\sp\utility::add_start("intro", &intro_start, var1, &main_intro, var1, &intro_catchup);
  scripts\engine\sp\utility::add_start("heli_infil", &lb_infil_start, var1, &main_lb_infil, var1, &lb_infil_catchup);
  scripts\engine\sp\utility::add_start("heli_unload", &lb_unload_start, var1, &main_lb_unload, var1, &lb_unload_catchup);
  scripts\engine\sp\utility::add_start("breached_gate", &breached_gate_start, var1, &main_breached_gate, var1, &breached_gate_catchup);
  scripts\engine\sp\utility::add_start("1st_floor", &comp_1f_start, var1, &main_comp_1f, var1, &comp_1f_catchup);
  scripts\engine\sp\utility::add_start("2nd_floor", &comp_2f_start, var1, &main_comp_2f, var1, &comp_2f_catchup);
  scripts\engine\sp\utility::add_start("3rd_floor", &comp_3f_start, var1, &main_comp_3f, var1, &comp_3f_catchup);
  scripts\engine\sp\utility::add_start("downstairs", &downstairs_start, var1, &main_downstairs, var1, &downstairs_catchup);
  scripts\engine\sp\utility::add_start("tea_room", &tea_room_start, var1, &main_tea_room, var1, &tea_room_catchup);
  scripts\engine\sp\utility::add_start("basement", &scripts\sp\maps\tunnels\zd30tunnels_basement::basement_start, var1, &main_basement, var1, &scripts\sp\maps\tunnels\zd30tunnels_basement::basement_catchup);
  scripts\engine\sp\utility::add_start("basement_tunnel", &scripts\sp\maps\tunnels\zd30tunnels_basement::basement_tunnel_start, var1, &main_basement_tunnel, var1, &scripts\sp\maps\tunnels\zd30tunnels_basement::basement_tunnel_catchup);
  scripts\engine\sp\utility::add_start("collapse", &scripts\sp\maps\tunnels\zd30tunnels_basement::collapse_start, var1, &main_collapse, var1, &scripts\sp\maps\tunnels\zd30tunnels_basement::collapse_catchup);
  scripts\engine\sp\utility::add_start("storage", &scripts\sp\maps\tunnels\zd30tunnels_storage::storage_start, var1, &main_storage, var1, &scripts\sp\maps\tunnels\zd30tunnels_storage::storage_catchup);
  scripts\engine\sp\utility::add_start("storage_oil", &scripts\sp\maps\tunnels\zd30tunnels_storage::storage_oil_start, var1, &main_storage_oil, var1, &scripts\sp\maps\tunnels\zd30tunnels_storage::storage_oil_catchup);
  scripts\engine\sp\utility::add_start("storage_split", &scripts\sp\maps\tunnels\zd30tunnels_storage::storage_split_start, var1, &main_storage_split, var1, &scripts\sp\maps\tunnels\zd30tunnels_storage::storage_split_catchup);
  scripts\engine\sp\utility::add_start("mine", &scripts\sp\maps\tunnels\zd30tunnels_mineshaft::mine_start, var1, &main_mine, var1, &scripts\sp\maps\tunnels\zd30tunnels_mineshaft::mine_catchup);
  scripts\engine\sp\utility::add_start("shaft", &scripts\sp\maps\tunnels\zd30tunnels_mineshaft::shaft_start, var1, &main_shaft, var1, &scripts\sp\maps\tunnels\zd30tunnels_mineshaft::shaft_catchup);
  scripts\engine\sp\utility::add_start("reunion", &scripts\sp\maps\tunnels\zd30tunnels_mineshaft::reunion_start, var1, &main_reunion, var1, &scripts\sp\maps\tunnels\zd30tunnels_mineshaft::reunion_catchup);
  scripts\engine\sp\utility::add_start("wolf", &scripts\sp\maps\tunnels\zd30tunnels_wolf::wolf_start, var1, &main_wolf, var1, &scripts\sp\maps\tunnels\zd30tunnels_wolf::wolf_catchup);
  scripts\engine\sp\utility::add_start("coldopen_bink", &coldopen_bink_start, "", &main_coldopen_bink, var1, &coldopen_bink_catchup);
  scripts\engine\sp\utility::set_default_start("heli_infil");
  thread intro_screen();
  scripts\sp\audio::set_audio_level_fade_time(0.1);
  scripts\sp\load::main();
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("TLMMOPMSK", 1);
  setsaveddvar("MMLNNQSTTL", 15);
  scripts\engine\sp\utility::battlechatter_on("axis");
  level_inits();
  level_compound_setup();
  setomnvar("ai_fulllight", 0.0045);
  setomnvar("ai_nolight", 0.001);
  scripts\sp\utility::nvidiaansel_allowduringcinematic(1);
}

function intro_screen() {
  scripts\engine\sp\utility::intro_screen_custom_func(&intro_screen_delay);
}

function intro_screen_delay() {
  wait 6.5;
  scripts\sp\introscreen::introscreen(1);
}

function setup_scriptable_lights_for_compile() {
  var0 = getEntArray("light_spot", "classname");
  var0 = scripts\engine\utility::array_combine(getEntArray("light_omni", "classname"), var0);

  foreach(var2 in var0) {
    if(!isDefined(var2.script_noteworthy)) {
      continue;
    }

    if(getDvar("LLQQOPKTKM") == "1") {
      var2 setlightintensity(0);
      var2 setlightcolor(0, 0, 0);
    }
  }
}

function level_inits() {
  level.fov_mine = 65;
  level.fov_basement = 55;
  level.fov_wolf_bomb_defuse = 65;
  level.zd30_player_max_health = 100;
  level.zd30_player_max_health_tunnels = 60;
  level.zd30_player_max_health_storage = 60;
  level.zd30_player_max_health_shaft = 100;
  level.civs = [];
  level.cleanup = [];
  level.charlie = [];
  level.infil_dogs = [];
  level.current_obj = undefined;
  level.unarmedkilled = 0;
  init_flags();
  init_precache();
  init_loadout();
  init_objectives();
  init_hints();
  init_postspawns();
  scripts\sp\maps\tunnels\zd30tunnels_utility::init_utility_triggers();
  init_player_monitors();
  init_easter_eggs();
  scripts\sp\maps\tunnels\zd30tunnels_ai::init_spawnfunctions();
  init_shootable_lanterns();
  setdvarifuninitialized("greenlight", 0);
  var0 = scripts\sp\player_rig::get_player_rig();
  var0 hide();
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  disableaudiotrigger("mine_shaft_occluder");
}

function init_precache() {
  precachemodel("misc_wm_sledgehammer_scaled");
  precachemodel("offhand_wm_c4_bomb_sp");
  precachemodel("me_doors_zd30_gate_01_dmg_lod0");
  precachemodel("door_industrial_metal_sp_01_dmg");
  precachemodel("body_sas_woodland_ar_1_1_wind");
  precachemodel("body_sas_woodland_ar_4_1_wind");
  precachemodel("body_hero_kyle_woodland_wind");
  precachemodel("viewhands_kyle_fullbody_wind");
  precachemodel("head_hero_alex");
  precachemodel("body_civ_syrkistan_boy_1_1");
  precachemodel("body_civ_syrkistan_boy_4_1");
  precachemodel("head_sc_f_rezaee");
  precachemodel("body_civ_london_male_bombvest");
  precachemodel("head_villain_wolf");
  precachemodel("misc_wm_flarestick_throwable");
  precachemodel("emergency_flare_iw6");
  precacherumble("subtle_tank_rumble");
  precacheitem("fighter_spotlight");
  precachestring(&"MINEFIELDS_MINEDIED");
  precacheitem("iw8_pi_mike1911");
  precachemodel("tag_origin_only_collision");
  precachemodel("burntbody_male");
  precachemodel("offhand_wm_clacker");
  precachemodel("offhand_vm_clacker_tactical");
  precacheshader("reticle_center_dot");
  precachemodel("body_villain_wolf_desert");
  precachemodel("body_hero_farah_nobraids");
  scripts\sp\maps\tunnels\zd30tunnels_basement::precache_basement();
  scripts\sp\maps\tunnels\zd30tunnels_storage::precache_storage();
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft::precache_mineshaft();
}

function init_loadout() {
  scripts\sp\nvg\nvg_player::main("nvg_tunnels");
  scripts\game\sp\door::set_snake_cam_vision("snake_cam_estate");
  level.player scripts\sp\player::remove_all_armor();
  var0 = ["frag", "flash", "semtex", "molotov", "smoke"];
  scripts\engine\sp\utility::offhandprecache(var0);

  if(scripts\sp\starts::is_after_start("tea_room")) {
    alex_loadout();
    return;
  }

  kyle_loadout();
}

function kyle_loadout() {
  level.player.maxvisibiltyupdate_disabled = 1;
  level.player.maxvisibledist = 8192;
  level.player scripts\sp\player::set_player_max_health(60);
  scripts\sp\maps\tunnels\zd30tunnels_utility::setplayerviewmodel("viewmodel_arms_kyle_woodland", "viewhands_base_legs_iw8", "default_character_shadow");
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon_special("kyle_ar"));
}

function alex_loadout() {
  scripts\sp\maps\tunnels\zd30tunnels_utility::setplayerviewmodel("viewhands_alex_gloves_a", "viewhands_base_legs_iw8", "default_character_shadow");
  level.player takeallweapons();
  level.player scripts\sp\utility::give_weapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  level.player scripts\engine\sp\utility::allow_nvg(0, "zd30Tunnels", 1);
  setomnvar("ui_nvg_equipped", 0);
  level.scr_model["player_rig"] = "viewhands_alex_gloves_a";
  thread alex_loadout_final();
}

function alex_loadout_final() {
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_tunnels);

  if(!scripts\sp\starts::is_after_start("basement")) {
    scripts\engine\utility::flag_wait("tunnels_gun_ready");
  }

  level.player scripts\sp\utility::take_weapon("iw8_gunless");
  var0 = alex_weapons_config();
  level.player.loadout_weapons = var0;
  level.player giveweapon(var0[0]);
  level.player giveweapon(var0[1]);
  level.player scripts\engine\sp\utility::give_offhand("flash");
  level.player givemaxammo("flash");
  level.player scripts\engine\sp\utility::give_offhand("semtex");
  level.player setweaponammostock("semtex", 0);
  level.player setweaponammoclip("semtex", 0);
  level.player switchtoweapon(var0[1]);
}

function alex_weapons_config() {
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon("iw8_sh_romeo870", ["reflex_west01"]));
}

function init_player_monitors() {
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_weapon_fire();
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_player_in_danger();
  thread init_player_death_monitor();
}

function init_player_death_monitor() {
  level.player_death_refs = [];
  waitframe();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::setup_player_deaths("storage_MG");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::setup_player_deaths("shaft_puzzle");
}

function init_easter_eggs() {
  level.easter_eggs = [];
  level.easter_eggs["tv_teddy"] = easter_egg_tv_teddy();
}

function init_objectives() {}

function init_hints() {
  scripts\engine\sp\utility::add_hint_string("hint_use_flashbang", &"ZD30/HINT_USEFLASH", &scripts\sp\maps\tunnels\zd30tunnels_utility::player_using_flash);
  scripts\engine\sp\utility::add_hint_string("hint_use_molotov", &"ZD30/HINT_USEMOLOTOV", &scripts\sp\maps\tunnels\zd30tunnels_utility::player_using_molotov);
  scripts\engine\sp\utility::add_hint_string("hint_shoot_on_ladder", &"ZD30/HINT_SHOOTONLADDER");
  scripts\engine\sp\utility::add_hint_string("wolf_defuse_hint", &"ZD30/HINT_WOLFBOMBDEFUSE", &scripts\sp\maps\tunnels\zd30tunnels_wolf::wolf_bomb_vest_defuse_looked_at_any_wire);
  scripts\engine\sp\utility::add_hint_string("wolf_defuse_hint_kbm", &"ZD30/HINT_WOLFBOMBDEFUSE_KBM", &scripts\sp\maps\tunnels\zd30tunnels_wolf::wolf_bomb_vest_defuse_looked_at_any_wire);
  scripts\engine\sp\utility::add_hint_string("storage_split_hint", &"ZD30/HINT_MINESGETUP");
}

function init_flags() {
  scripts\engine\utility::flag_init("forever");
  scripts\engine\utility::flag_init("heli_intro_skipped");
  scripts\engine\utility::flag_init("start_fp_trans");
  scripts\engine\utility::flag_init("pre_anim_finished");
  scripts\engine\utility::flag_init("kill_lights");
  scripts\engine\utility::flag_init("b1_intro_guy_dead");
  scripts\engine\utility::flag_init("sledge_ready");
  scripts\engine\utility::flag_init("start_sledge");
  scripts\engine\utility::flag_init("player_inside_b1");
  scripts\engine\utility::flag_init("lb_landed");
  scripts\engine\utility::flag_init("b1_start_2nd_guy");
  scripts\engine\utility::flag_init("breacher_set");
  scripts\engine\utility::flag_init("moveup_building1");
  scripts\engine\utility::flag_init("b1_runner_start");
  scripts\engine\utility::flag_init("player_in_1st_building");
  scripts\engine\utility::flag_init("b1_girl_ready");
  scripts\engine\utility::flag_init("b1_girl_dead");
  scripts\engine\utility::flag_init("b1_runner_dead");
  scripts\engine\utility::flag_init("building1_guy_dead");
  scripts\engine\utility::flag_init("building1_guy_moveup");
  scripts\engine\utility::flag_init("player_in_building1_back_room");
  scripts\engine\utility::flag_init("player_close_to_mom");
  scripts\engine\utility::flag_init("mom_isflashed");
  scripts\engine\utility::flag_init("building1_mom_dead");
  scripts\engine\utility::flag_init("allies_and_doors_ready");
  scripts\engine\utility::flag_init("breach_gate");
  scripts\engine\utility::flag_init("breach_explosion");
  scripts\engine\utility::flag_init("breach_finished");
  scripts\engine\utility::flag_init("price_approach_finished");
  scripts\engine\utility::flag_init("bravo4_approach_finished");
  scripts\engine\utility::flag_init("bravo5_approach_finished");
  scripts\engine\utility::flag_init("set_yard_targets");
  scripts\engine\utility::flag_init("bravo5_in_position");
  scripts\engine\utility::flag_init("main_door_clip");
  scripts\engine\utility::flag_init("1f_ambush");
  scripts\engine\utility::flag_init("1f_runner_start");
  scripts\engine\utility::flag_init("1f_civ_reaction");
  scripts\engine\utility::flag_init("civ01_dies");
  scripts\engine\utility::flag_init("civ02_dies");
  scripts\engine\utility::flag_init("civ03_dies");
  scripts\engine\utility::flag_init("player_in_left_room");
  scripts\engine\utility::flag_init("1f_civs_ads");
  scripts\engine\utility::flag_init("compound_side_door_breach");
  scripts\engine\utility::flag_init("player_in_1f_back_room");
  scripts\engine\utility::flag_init("1f_runner_dead");
  scripts\engine\utility::flag_init("player_back_in_hallway");
  scripts\engine\utility::flag_init("remove_1f_hallway_clip");
  scripts\engine\utility::flag_init("power_is_off");
  scripts\engine\utility::flag_init("player_at_2f_stairs");
  scripts\engine\utility::flag_init("player_at_top_2f_stairs");
  scripts\engine\utility::flag_init("player_in_2f_hallway");
  scripts\engine\utility::flag_init("player_midway_in_2f_hallway");
  scripts\engine\utility::flag_init("price_kick_in_door");
  scripts\engine\utility::flag_init("dataCiv_is_dead");
  scripts\engine\utility::flag_init("player_2f_balcony");
  scripts\engine\utility::flag_init("2f_pre_bedroom_save");
  scripts\engine\utility::flag_init("bathroom_moveup");
  scripts\engine\utility::flag_init("2f_hallway_door_opened");
  scripts\engine\utility::flag_init("balcony_guy_dead");
  scripts\engine\utility::flag_init("bathroom_guy_dead");
  scripts\engine\utility::flag_init("bedroom_girl_seen");
  scripts\engine\utility::flag_init("3f_ready");
  scripts\engine\utility::flag_init("3f_stairs_clip");
  scripts\engine\utility::flag_init("player_at_3f_stairs");
  scripts\engine\utility::flag_init("ready_3f_ascend");
  scripts\engine\utility::flag_init("player_in_3f_hallway");
  scripts\engine\utility::flag_init("player_near_3f_balcony");
  scripts\engine\utility::flag_init("player_is_breaching_balcony");
  scripts\engine\utility::flag_init("player_is_breaching_hallway");
  scripts\engine\utility::flag_init("player_3f_shot");
  scripts\engine\utility::flag_init("start_3f_favela_door");
  scripts\engine\utility::flag_init("start_3f_react");
  scripts\engine\utility::flag_init("3f_bedroom_guy_dead");
  scripts\engine\utility::flag_init("3f_hostage_dead");
  scripts\engine\utility::flag_init("3f_favela_guy_dead");
  scripts\engine\utility::flag_init("3f_cleared");
  scripts\engine\utility::flag_init("bravo1_anim_finished");
  scripts\engine\utility::flag_init("3f_scene_done");
  scripts\engine\utility::flag_init("trap_door_interacted");
  scripts\engine\utility::flag_init("tunnels_transiton_skipped");
  scripts\engine\utility::flag_init("tunnels_entrance");
  scripts\engine\utility::flag_init("basement_first_blast_cancel");
  scripts\engine\utility::flag_init("basement_right_flank_surpise_dealt");
  scripts\engine\utility::flag_init("basement_runner_gone");
  scripts\engine\utility::flag_init("farah_hallway_takedown_skipped");
  scripts\engine\utility::flag_init("player_ladder_explode");
  scripts\engine\utility::flag_init("triggered_basement_whisper");
  scripts\engine\utility::flag_init("fire_phase1_started");
  scripts\engine\utility::flag_init("shaft_fire_on");
  scripts\engine\utility::flag_init("oilpusher_awake_in_mine");
  scripts\engine\utility::flag_init("tunnels_gun_ready");
  scripts\engine\utility::flag_init("storage_flank_weapon_fired");
  scripts\engine\utility::flag_init("farah_storage_split_scene_start");
  scripts\engine\utility::flag_init("storage_retreat_now");
  scripts\engine\utility::flag_init("storage_player_flanking");
  scripts\engine\utility::flag_init("storage_split_hint");
  scripts\engine\utility::flag_init("shaft_split_vo_done");
  scripts\engine\utility::flag_init("basement_door_guy_dealt");
  scripts\engine\utility::flag_init("shaft_propane_kick_detonated");
  scripts\engine\utility::flag_init("shaft_propane_toss_detonated");
  scripts\engine\utility::flag_init("mg_gunner_died_from_fire");
  scripts\engine\utility::flag_init("shaft_propane_toss");
  scripts\engine\utility::flag_init("shaft_propane_kicked");
  scripts\engine\utility::flag_init("mines_bridge_collapsed");
  scripts\engine\utility::flag_init("mines_tunnel_collapsed");
  scripts\engine\utility::flag_init("reunion_pull_up_success");
  scripts\engine\utility::flag_init("reunion_pull_up_failed");
  scripts\engine\utility::flag_init("wolf_killed");
  scripts\engine\utility::flag_init("wolf_door_unlocked");
  scripts\engine\utility::flag_init("wolfdeath_player_cleared_door");
  scripts\engine\utility::flag_init("wolfdeath_timer_low");
  scripts\engine\utility::flag_init("wolfdeath_player_escaped");
  scripts\engine\utility::flag_init("wolfdeath_player_too_close");
  scripts\engine\utility::flag_init("wolfdeath_player_shoots_wolf");
  scripts\engine\utility::flag_init("wolfdeath_player_shoots_around");
  scripts\engine\utility::flag_init("wolfdeath_farah_reached");
  scripts\engine\utility::flag_init("wolfdeath_farah_shoot");
  scripts\engine\utility::flag_init("wolfdeath_farah_in_position");
  scripts\engine\utility::flag_init("wolfdeath_farah_shoots_wolf");
  scripts\engine\utility::flag_init("wolfdeath_farah_defuse_ready");
  scripts\engine\utility::flag_init("wolfdeath_farah_defuse_ready_tele");
  scripts\engine\utility::flag_init("wolfdeath_player_defuse_interacted");
  scripts\engine\utility::flag_init("wolfdeath_defuse_green");
  scripts\engine\utility::flag_init("wolfdeath_defuse_yellow");
  scripts\engine\utility::flag_init("wolfdeath_defuse_red");
  scripts\engine\utility::flag_init("wolfdeath_defuse_done");
  scripts\engine\utility::flag_init("wolfdeath_defuse_looked_at_green_wire");
  scripts\engine\utility::flag_init("bomb_vest_scene_finished");
}

function init_postspawns() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alpha", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_allies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("bravo", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_allies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("charlie", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_charlie);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("price", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_hero);
  scripts\engine\sp\utility::array_spawn_function_targetname("infil_caged_dog", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_infil_dogs);
  scripts\engine\sp\utility::array_spawn_function_targetname("1f_civ_back_room", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_1f_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2f_data_room", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_2f_data);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2f_data_room_civ", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_2f_dataciv);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2f_enemies", &scripts\sp\maps\tunnels\zd30tunnels_infil::postspawn_2f_enemies);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\tunnels\zd30tunnels_ai::friendly_nvg_setup);
  level._effect["breach_explode"] = loadfx("vfx/iw8/level/zd30/vfx_zd30_door_breach_thick.vfx");
  var0 = getEnt("blood_smear", "script_noteworthy");
  var0 hide();
  var1 = getEntArray("player_movement_clip", "script_noteworthy");
  level.cleanup = scripts\engine\utility::array_combine(level.cleanup, var1);

  foreach(var3 in var1) {
    var3 notsolid();
  }

  var5 = getEntArray("price_bty", "targetname");

  foreach(var7 in var5) {
    var7.og_intensity = var7 getlightintensity();
    var7 setlightintensity(0);
  }
}

function init_threatbias() {
  createthreatbiasgroup("farah");
  createthreatbiasgroup("player");
  createthreatbiasgroup("forest_enemies");
  createthreatbiasgroup("basement_dudes");
  createthreatbiasgroup("storage_dudes");
  level.player setthreatbiasgroup("player");
  setthreatbias("player", "forest_enemies", 1000);
  setthreatbias("farah", "forest_enemies", -1000);
  setthreatbias("player", "basement_dudes", 1000);
  setthreatbias("farah", "basement_dudes", -1000);
  setthreatbias("player", "storage_dudes", 1000);
  setthreatbias("farah", "storage_dudes", -1000);
}

function level_compound_setup() {
  level.wind["amp"] = getDvar("MQPQKNPQOK");
  level.wind["freq"] = getDvar("MRNRKKOPLN");
  level.wind["area"] = getDvar("LQLSPQOPKM");
  level.wind["noise"] = getDvar("OLSKLTPPMR");
  level.wind["str"] = getDvar("NQTLPTNSSO");
  level.wind["dir"] = getDvar("NTMMTOLQMQ");
  setsaveddvar("MQPQKNPQOK", 2);
  setsaveddvar("MRNRKKOPLN", 4);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("NQTLPTNSSO", 1);
  setsaveddvar("NTMMTOLQMQ", (1, 0, 0));

  if(!scripts\sp\starts::is_after_start("2nd_floor")) {
    var0 = getEnt("power_switch", "targetname");
    var0.animname = "power";
    var0 scripts\engine\sp\utility::assign_animtree();
    var1 = scripts\engine\utility::getStruct("power_animnode", "targetname");
    var1 thread scripts\common\anim::anim_first_frame_solo(var0, "power_interact");
    var0 thread scripts\sp\maps\tunnels\zd30tunnels_infil::power_interact_anim(var1);
  }

  if(getdvarint("greenlight") == 1) {
    scripts\engine\utility::flag_set("did_door_hint");
  }

  setsaveddvar("NQQSKRQMTS", 0);
}

function level_tunnel_setup() {
  setsaveddvar("MQPQKNPQOK", level.wind["amp"]);
  setsaveddvar("MRNRKKOPLN", level.wind["freq"]);
  setsaveddvar("LQLSPQOPKM", level.wind["area"]);
  setsaveddvar("OLSKLTPPMR", level.wind["noise"]);
  setsaveddvar("NQTLPTNSSO", level.wind["str"]);
  setsaveddvar("NTMMTOLQMQ", level.wind["dir"]);
  setsaveddvar("LKOLRONRNQ", 600);
  setsaveddvar("NQNQPRLRQM", 10);
  setomnvar("ai_fulllight", 1e-07);
  setomnvar("ai_nolight", 0.02);
  level thread scripts\sp\utility::context_melee_enable(0);
  thread spawn_pre_placed_flares_for_tunnels();
  thread scripts\sp\maps\tunnels\zd30tunnels_ai::tunnels_spawnfunctions();
  level.player_is_safe_from_smoke = 1;
  level.inside_shaft_trig = getEnt("inside_shaft", "targetname");
  level.special_autosavecondition = &zd30_autosave_condition;
  level.custom_oilfire_think = &scripts\sp\maps\tunnels\zd30tunnels_utility::custom_collapse_oilfire_think;
  hadir();
  thread tunnels_achievement();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::tripwire_explosion_enhancement();
  thread player_tunnel_explosion_experience();
  thread player_ladder_aid();
  thread player_prone_slide_dirt_fx();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::offhand_box_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::tripwire_enemy_trip_monitor();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::tripwire_pathing_think();
  thread player_fov_think();
  thread player_aim_at_think();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_player_past_loc();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_player_jump();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::magic_grenades();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::oilfire_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::garbage_collector();
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::player_flashlight_maxvis_hack();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::setup_traps();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::fall_damage_remove_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::stealth_break_monitor();
  thread player_unresolved_collision_suspend();
  thread scripts\sp\maps\tunnels\zd30tunnels_basement::basement_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_basement::collapse_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_storage::storage_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_mineshaft::mines_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_mineshaft::shaft_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_mineshaft::reunion_setup();
}

function player_unresolved_collision_suspend() {
  wait 2;
  level.player notify("stop_unresolved_collision_script");
}

function tunnels_achievement() {
  level.tunnels_achievements = [];
  thread tunnels_achievement_pistol_only();
}

function tunnels_achievement_pistol_only() {
  level endon("bomb_vest_scene_finished");
  var0 = "tunnelrat";
  level.tunnels_achievements[var0] = 1;
  var1 = "iw8_pi_mike1911";
  thread tunnels_achievement_pistol_only_final(level);

  while(!scripts\engine\utility::flag("bomb_vest_scene_finished")) {
    var2 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "grenade_fire", "offhand_fired");

    if(!isDefined(var2) || var2 == "grenade_fire" || var2 == "offhand_fired") {
      level.tunnels_achievements[var0] = 0;
      return;
    }

    var3 = level.player getcurrentweapon();

    if(!issubstr(var3.basename, var1) || var2 != "weapon_fired") {
      level.tunnels_achievements[var0] = 0;
      return;
    }
    LOC_000000bb:
  }
}

function tunnels_achievement_pistol_only_final(var0) {
  scripts\engine\utility::flag_wait("bomb_vest_scene_finished");
  wait 0.05;

  if(level.tunnels_achievements[var0]) {
    scripts\sp\utility::giveachievement_wrapper(var0);
    return;
  }
}

function player_aim_at_think() {
  var0 = spawn("script_origin", level.player getEye());
  var0 linkTo(level.player, "tag_eye");
  level.player.look_at_ent = var0;
}

function spawn_pre_placed_flares_for_tunnels() {
  level.flare_spawn_array = getEntArray("flare_shadow_casting_model", "targetname");
  var0 = "tag_fx";

  foreach(var2 in level.flare_spawn_array) {
    waitframe();
    playFXOnTag(level._effect["emergency_flare_nolight"], var2, "tag_fx");
  }
}

function init_shootable_lanterns() {
  thread init_shootable_lanterns_internal();
}

function init_shootable_lanterns_internal() {
  waitframe();
  level.scriptable_lanterns = getscriptablearray("lantern", "targetname");
  level.scriptable_lantern_lights = getEntArray("lantern_light", "script_noteworthy");
  var0 = 48;
  var1 = 3;

  foreach(var3 in level.scriptable_lanterns) {
    var4 = [];

    foreach(var6 in level.scriptable_lantern_lights) {
      if(!istrue(var6.assaigned) && scripts\engine\utility::distance_2d_squared(var6.origin, var3.origin) < var0 * var0) {
        var4 = var6;
        var6.assigned = 1;
      }

      if(var4.size >= 3) {
        break;
      }
    }

    var3.lights = var4;
    thread scriptable_lantern_think();
  }
}

function scriptable_lantern_think() {
  jumpiffalse(!isDefined(self.lights) || self.lights.size == 0) LOC_00000017;
  return;
}

function zd30_autosave_condition() {
  if(is_anim_enemy_engaging_player(level.storage_ambusher_blind_fire_guy)) {
    return false;
  }

  if(is_anim_enemy_engaging_player(level.basement_first_cell_guy)) {
    return false;
  }

  if(scripts\engine\utility::flag("flare_in_fire") && !scripts\engine\utility::flag("collapse_hadir_convo")) {
    return false;
  }

  if(!istrue(level.player_is_safe_from_smoke)) {
    return false;
  }

  if(scripts\engine\utility::flag("basement_trapdoor_entered")) {
    var0 = 130;

    if(isDefined(level.tripwires.traps) && level.tripwires.traps.size > 0) {
      foreach(var2 in level.tripwires.traps) {
        if(isDefined(var2) && isDefined(var2.origin) && distancesquared(level.player.origin, var2.origin) < var0 * var0) {
          return false;
        }
      }
    }
  }

  if(isDefined(level.player.lasttriptime)) {
    var4 = 5;
    var5 = gettime() - level.player.lasttriptime;

    if(var5 > 0 && var5 < var4 * 1000) {
      return false;
    }
  }

  if(isDefined(level.lastoilfiretime) && !scripts\engine\utility::flag("shaft_fire_on")) {
    var4 = 5;
    var5 = gettime() - level.lastoilfiretime;

    if(var5 < var4 * 1000) {
      return false;
    }
  }

  if(scripts\engine\utility::flag("shaft_fire_on") && !scripts\engine\utility::flag("fire_phase1_started")) {
    return false;
  }

  if(isDefined(level.storage_mg_guy) && isalive(level.storage_mg_guy)) {
    if(isDefined(level.storage_mg_shoot_zone) && level.player istouching(level.storage_mg_shoot_zone)) {
      return false;
    }

    if(isDefined(level.storage_mg_shoot_wall_zone) && level.player istouching(level.storage_mg_shoot_wall_zone)) {
      return false;
    }
  }

  if(scripts\engine\utility::flag("storage_final_room_entered") && !scripts\engine\utility::flag("storage_mg_passed") && !scripts\engine\utility::flag("storage_mg_crawl")) {
    if(!isDefined(level.alcove_trig)) {
      var6 = getEntArray("turret_overheat_trig", "targetname");
      var7 = spawn("script_model", (-4800, 2528, -496));
      var7 setModel("tag_origin");

      foreach(var9 in var6) {
        if(var7 istouching(var9)) {
          level.alcove_trig = var9;
          break;
        }
      }

      var7 delete();
    }

    var11 = 350;

    if(level.player istouching(level.alcove_trig)) {
      var12 = scripts\sp\maps\tunnels\zd30tunnels_ai::get_alive_enemies();

      if(var12.size > 0) {
        var12 = sortbydistance(var12, level.player.origin);
        var13 = var12[0];

        if(scripts\engine\utility::distance_2d_squared(var13.origin, level.player.origin) < var11 * var11) {
          return false;
        }
      }
    }
  }

  if(scripts\engine\utility::flag("shaft_ladder_scene_execute") && !scripts\engine\utility::flag("shaft_plank_passed")) {
    return false;
  }

  if(scripts\engine\utility::flag("shaft_plank_passed") && level.player istouching(level.inside_shaft_trig)) {
    return false;
  }

  return true;
}

function is_anim_enemy_engaging_player(var0) {
  if(isDefined(var0) && isalive(var0)) {
    if(var0 cansee(level.player)) {
      return true;
    }

    if(scripts\engine\sp\utility::player_looking_at(var0 getEye(), 0.9, 1)) {
      return true;
    }
  }

  return false;
}

function easter_egg_tv_teddy() {
  var0 = getEnt("tv_teddy", "targetname");
  thread easter_egg_tv_teddy_monitor();
  return var0;
}

function easter_egg_tv_teddy_monitor() {
  self endon("entitydeleted");
  self endon("death");
  self endon("failed");
  var0 = getEnt(self.target, "targetname");
  var1 = getEnt(var0.target, "targetname");
  var2 = getEnt(var1.target, "targetname");
  wait 2;
  var3 = getscriptablearray("mines_tv", "targetname")[0];

  if(!isDefined(var3)) {
    return;
  }

  var4 = getEnt("mines_tv_light", "targetname");
  thread easter_egg_tv_light_flicker(var4);
  thread easter_egg_tv_teddy_monitor_helper(var1);
  var5 = var3.model;

  while(var3.model == var5) {
    wait 0.1;
  }

  var4 notify("tv_light_off");
  waitframe();
  var4 setlightintensity(0);
  var1 waittill("damage");
  self.activated = 1;
  var2 waittill("trigger");
  var6 = scripts\engine\utility::getStruct("mines_bats", "targetname");
  var7 = anglesToForward(var6.angles);
  var8 = anglestoup(var6.angles);
  playFX(level._effect["vfx_zd30_bats"], var6.origin, var7, var8);
  self hide();
}

function easter_egg_tv_light_flicker(var0) {
  self endon("entitydeleted");
  self endon("death");
  self endon("failed");
  var0 endon("tv_light_off");
  var1 = 1;
  var2 = 0.65;

  while(isDefined(var0)) {
    var0 setlightintensity(var1);
    wait randomfloatrange(0.1, 0.5);
    var0 setlightintensity(var2);
    wait randomfloatrange(0.1, 0.2);
  }
}

function easter_egg_tv_teddy_monitor_helper(var0) {
  var0 endon("damage");
  self waittill("damage");
  self notify("failed");
}

function hadir() {
  level.hadir = scripts\engine\sp\utility::spawn_targetname("hadirSpawner", 1);
  level.hadir.animname = "hadir";
  level.hadir.ignoreall = 1;
  level.hadir.ignoreme = 1;
  level.hadir scripts\common\ai::magic_bullet_shield();
  level.hadir scripts\common\ai::gun_remove();
  level.hadir scripts\engine\sp\utility::name_hide();
  level.hadir thread scripts\sp\maps\tunnels\zd30tunnels_ai::battlechatter_off_spawn_func();
}

function farah() {
  level.farah = scripts\engine\sp\utility::spawn_targetname("farahSpawner", 1);
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility::player_bump_management();
  var0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["reflexstable_west01", "calsmg_akilo47_sp", "barsmg_akilo47", "stocksmg_akilo47"]);
  level.farah scripts\anim\shared::forceuseweapon(var0, "primary");
  level.farah.animname = "farah";
  level.farah.baseaccuracy = 0.75;
  level.farah scripts\common\ai::magic_bullet_shield();
  thread pain_management();
  level.farah scripts\engine\utility::set_movement_speed(120);
  level.farah scripts\engine\sp\utility::name_hide();
  level.farah scripts\engine\sp\utility::name_show();
  thread farah_glow_stick_attach(0.5);
  level.anim_structs = [];
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_weapon_fire();
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_ai_in_danger();
  level.farah thread scripts\engine\sp\utility::battlechatter_filter_on(["order"]);
  level.farah thread scripts\engine\sp\utility::battlechatter_probability(-25);
}

function pain_management() {
  self endon("death");
  var0 = 0;
  var1 = 200;
  var2 = 5;
  var3 = 5;

  for(;;) {
    var4 = gettime();
    self waittill("damage", var5, var6);

    if(!isDefined(var6)) {
      wait 0.05;
      continue;
    }

    if(gettime() - var4 > var3 * 1000) {
      var0 = 0;

      if(getdvarint("zd30_debug") > 0) {}
    } else {
      var0 += var5;

      if(getdvarint("zd30_debug") > 0) {}
    }

    if(var0 >= var1) {
      scripts\engine\utility::disable_pain();

      if(getdvarint("zd30_debug") > 0) {}

      wait var2;
      scripts\engine\utility::enable_pain();
      var0 = 0;
    }
  }
}

function farah_glow_stick_attach(var0) {
  if(!isDefined(level.farah)) {
    return;
  }

  level.farah endon("death");
  level.farah endon("entitydeleted");
  level.farah.glowstick_vfx = "vfx_farah_glow_stick";
  level.farah.glowstick_fade_vfx = "vfx_farah_glow_stick_fade";
  level.farah.glowstick_tag = "tag_stowed_hip_rear";
  waitframe();

  if(isDefined(level.farah.glowstick)) {
    return;
  }

  if(!scripts\sp\starts::is_after_start("basement")) {
    return;
  }

  if(isDefined(var0)) {
    wait var0;
  }

  scripts\sp\maps\tunnels\zd30tunnels_utility::spawn_stowed_glowstick_on_farah();
}

function vo_via_trigger(var0, var1, var2, var3) {
  self endon("death");
  scripts\engine\sp\utility::trigger_wait_targetname(var0);

  if(isDefined(var3)) {
    wait var3;
  }

  if(isDefined(level.trigger_hint_string) && isDefined(level.trigger_hint_string[var1])) {
    scripts\engine\sp\utility::display_hint(var1, var2);
    return;
  }
}

function vo_via_flag(var0, var1, var2, var3) {
  self endon("death");
  scripts\engine\utility::flag_wait(var0);

  if(isDefined(var3)) {
    wait var3;
  }

  if(isDefined(level.trigger_hint_string) && isDefined(level.trigger_hint_string[var1])) {
    scripts\engine\sp\utility::display_hint(var1, var2);
    return;
  }
}

function player_fov_think() {
  level.player modifybasefov(level.fov_basement, 0.05);
}

function player_tunnel_explosion_experience() {
  var0 = getEnt("player_dmg_trig", "targetname");
  var0.origin = level.player.origin;
  var0 enablelinkTo();
  var0 linkTo(level.player);
  level.player.exp_trig = var0;
  thread player_tunnel_explosion_watch();
}

function player_tunnel_explosion_watch() {
  self endon("death");
  self endon("entitydeleted");
  level.player endon("death");
  var0 = 0.6;
  var1 = 1;
  var2 = 350;

  for(;;) {
    self waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16);

    if(isDefined(var12) && isDefined(var12.basename) && var12.basename == "flash") {
      continue;
    }

    var17 = "MOD_GRENADE MOD_GRENADE_SPLASH MOD_EXPLOSIVE";

    if(isDefined(var7) && issubstr(var17, var7) && isDefined(var6)) {
      if(scripts\engine\utility::distance_2d_squared(level.player.origin, var6) < 2304) {
        continue;
      }

      var18 = 0;

      if(scripts\engine\utility::distance_2d_squared(level.player.origin, var6) < 9216) {
        var18 = 3;
        var19 = var1 * 3;
        level.player playRumbleOnEntity("heavy_3s");
        earthquake(var0, var19, var6, var2);
      } else if(scripts\engine\utility::distance_2d_squared(level.player.origin, var7) < 16384) {
        var19 = 2;
        var19 = var2 * 3;
        level.player playRumbleOnEntity("heavy_3s");
        earthquake(var1, var19, var7, var3);
      } else {
        var19 = 1;
        var19 = var3 * 2;
        level.player playRumbleOnEntity("heavy_2s");
        earthquake(var2, var19, var8, var4);
      }
    }
  }
}

function player_ladder_aid() {
  thread player_ladder_ease();
  thread player_ladder_pistol();
}

function player_ladder_pistol() {
  for(;;) {
    if(level.player isonladder()) {
      var0 = undefined;
      var1 = get_player_pistol_data()[0];
      var2 = get_player_pistol_data()[1];

      if(isDefined(var1)) {
        var3 = weaponclipsize(var1);
        level.player setweaponammoclip(var1, var3);
      } else {
        var1 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
        level.player giveweapon(var1);
        level.player givemaxammo(var1);
        var3 = weaponclipsize(var1);
        level.player setweaponammoclip(var1, var3);
      }

      while(level.player isonladder() || level.player ismeleeing()) {
        wait 0.05;
      }

      if(isDefined(var1)) {
        level.player takeweapon(var1);
      }
    } else {
      while(!level.player isonladder()) {
        wait 0.05;
      }
    }

    wait 0.05;
  }
}

function get_player_pistol_data() {
  var0 = undefined;
  var1 = undefined;
  var2 = level.player getweaponslistall();

  if(!isDefined(var2) || var2.size == 0) {
    var1 = undefined;
  } else {
    foreach(var4 in var2) {
      if(weaponclass(var4) == "pistol") {
        var1 = var4;
        var0 = level.player getweaponammoclip(var4);
      }
    }
  }

  return [var1, var0];
}

function player_ladder_ease() {
  for(;;) {
    if(level.player isonladder()) {
      level.player scripts\sp\utility::set_player_attacker_accuracy(0.1);
    } else {
      level.player scripts\sp\utility::set_player_attacker_accuracy(1);
    }

    wait 0.1;
  }
}

function player_prone_slide_dirt_fx() {
  var0 = 1;
  var1 = 8;
  var2 = 1;
  var3 = getEntArray("no_dirt_zone", "targetname");

  for(;;) {
    var4 = level.player.origin;
    var5 = gettime();

    while(level.player getstance() != "prone" && !level.player issprintsliding()) {
      wait 0.05;
    }

    if(isDefined(var3) && var3.size > 0) {
      var6 = sortbydistance(var3, level.player.origin)[0];

      if(isDefined(var6) && level.player istouching(var6)) {
        wait 0.25;
        continue;
      }
    }

    while(level.player getstance() == "prone" || level.player issprintsliding()) {
      if(level.player issprintsliding()) {
        var1 = 16;
      }

      var7 = var4 != level.player.origin;
      var8 = var7 && distance2dsquared(var4, level.player.origin) > var1 * var1;
      var9 = gettime() - var5 > var2 * 1000;

      if(var8 || var7 && var9) {
        var4 = level.player.origin;
        var5 = gettime();
        var10 = level.player.origin;
        var11 = var10 + (0, 0, 32);
        var12 = var10 - (0, 0, 32);
        var13 = scripts\engine\trace::_bullet_trace(var11, var12, 0, level.player);
        var14 = 8;
        var15 = level._effect["vfx_prone_dust"];

        if(var13["surfacetype"] == "surftype_dirt") {
          var14 = 8;
          var15 = level._effect["vfx_prone_dust"];
        } else {
          wait 0.05;
          continue;
        }

        if(level.player issprintsliding()) {
          var14 *= 4;
        }

        var16 = anglesToForward(level.player.angles);
        var17 = vectorNormalize(var16) * var14;
        var18 = scripts\engine\utility::drop_to_ground(level.player getEye() + var17, 32, -48);
        var19 = scripts\engine\utility::spawn_tag_origin(var18, level.player.angles);
        playFXOnTag(var15, var19, "tag_origin");
        thread stop_prone_slide_vfx(var0, var15, var19);
      }

      wait 0.05;
    }
  }
}

function stop_prone_slide_vfx(var0, var1, var2) {
  wait var0;

  if(!isDefined(var2)) {
    return;
  }

  stopFXOnTag(var1, var2, "tag_origin");
  wait 0.1;
  var2 delete();
}

function debug_fail_player_prone_dirt_fx(var0, var1) {
  if(getdvarint("zd30_debug") > 0) {
    var0 = 0.25;
    var2 = anglesToForward(level.player.angles);
    var2 = vectorNormalize(var2) * 32;
    var3 = anglestoleft(level.player.angles);
    var3 = vectorNormalize(var3) * 8;
    var4 = scripts\engine\utility::drop_to_ground(level.player getEye() + var2 + var3, 32, -48);
    var5 = int(var0 * 20);
    return;
  }
}

function debug_pass_player_prone_dirt_fx(var0, var1, var2, var3, var4) {
  if(getdvarint("zd30_debug") > 0) {
    var5 = anglestoleft(level.player.angles);
    var5 = vectorNormalize(var5) * var4;
    var6 = int(var0 * 20);
    thread scripts\engine\utility::draw_circle(var2, var4, (0.7, 0.7, 0.7), 1, 0, int(var0 * 20));
    thread scripts\engine\utility::draw_line_for_time(var2 + var5, var2 - var5, 0.7, 0.7, 0.7, var0);
    thread scripts\engine\utility::draw_line_for_time(var2 + var3, var2 - var3, 0.7, 0.7, 0.7, var0);
    thread scripts\engine\utility::draw_line_for_time(var2, var2 + (0, 0, 20), 0.7, 0.7, 0.7, var0);
    return;
  }
}

function intro_start() {
  level.player clearclienttriggeraudiozone(1);
}

function intro_catchup() {
  level.stealth_break_timestamp = 0;
}

function main_intro() {
  setdvarifuninitialized("emb_skip_cinematic_hack", "0");
  cinematic_hack();
}

function cinematic_hack() {
  if(!getdvarint("zd30_skip_cinematic_hack", 0) && !issaverecentlyloaded()) {
    setomnvar("ui_hide_dpad_hud", 1);
    level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
    setomnvar("ui_hide_weapon_info", 1);
    setomnvar("ui_hide_hud", 1);
    var0 = scripts\sp\hud_util::create_client_overlay("black", 1);
    thread scripts\sp\art::dof_enable_script(0, 100, 150, 100, 3000, 50, 0);
    level.player setclienttriggeraudiozone("bink_fadeout_amb", 0.5);
    scripts\sp\endmission::level_settle_time_wait();
    var0 destroy();
    cinematicingame("sp_zd30_mbi_standalone");
    var1 = 25000;
    level.player freezecontrols(1);
    var2 = cinematicgettimeinmsec();

    while(var2 <= var1) {
      var2 = cinematicgettimeinmsec();
      wait 0.05;
    }

    level.player clearclienttriggeraudiozone(3);
    thread scripts\sp\art::dof_disable_script(1);
    level.player freezecontrols(0);
    return;
  }
}

function lb_infil_start() {
  scripts\sp\hud_util::fade_out(0);
}

function main_lb_infil() {
  level.player setclienttriggeraudiozone("fade_to_black", 0.05);
  level.player lerpfovscalefactor(0, 0);
  thread cine_letterboxing_intro();
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("intro");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::heli_intro_anim();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::heli_ride_intro_extras();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_tea_room();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::flashbang_watcher();
  var0 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_off(var0);
  scripts\engine\sp\utility::array_spawn_targetname("infil_caged_dog");
  scripts\sp\player::player_movement_state("cqb");
  wait 0.1;
  level.player setclienttriggeraudiozone("zdt_infil", 0.5);
  scripts\engine\utility::flag_wait("lb_landed");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  thread scripts\engine\sp\utility::autosave_now();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::infil_spawn_building1_runner();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::nag_enter_b1();
  scripts\engine\utility::flag_wait("sledge_ready");
}

function cine_letterboxing_intro() {
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level waittill("cine_letterboxing");
  getrandomnodedestination(1.5, 0);
  level.player clearcinematicmotionoverride();
}

function lb_infil_catchup() {
  if(!scripts\sp\starts::is_after_start("tea_room")) {
    scripts\sp\player::player_movement_state("default");
    level.player modifybasefov(55, 0.05);
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::flashbang_watcher();
  }

  if(!scripts\sp\starts::is_after_start("downstairs")) {
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_tea_room();
    return;
  }

  if(!scripts\sp\starts::is_after_start("basement")) {
    scripts\sp\maps\tunnels\zd30tunnels_infil::tea_room_change("after", 0);
    return;
  }
}

function lb_unload_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::array_spawn_targetname("infil_caged_dog");
  var0 = scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  var1 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  var2 = scripts\engine\utility::array_combine(var0, var1, [level.price]);

  foreach(var4 in var2) {
    var5 = scripts\engine\utility::getStruct("unload_" + var4.animname, "targetname");
    var4 teleport(var5.origin, var5.angles);
  }

  var7 = [level.alpha5, level.alpha6, level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4];
  var7 thread scripts\sp\maps\tunnels\zd30tunnels_infil::allies_nvg_on(1);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::infil_spawn_building1_runner();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_alpha_breach_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_alpha_sledge_team();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_bravo_roof();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::b1_door_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::nag_enter_b1();
  level.alpha6 attach("misc_wm_sledgehammer_scaled", "tag_accessory_right");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil::overwatch_setup();
  var8 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_off(var8);
  scripts\engine\sp\utility::set_start_location("lb_unload", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("clear_building");
}

function main_lb_unload() {
  level.player clearclienttriggeraudiozone(2);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::b1_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::b1_flashbang_watcher();
  scripts\engine\utility::flag_wait("moveup_building1");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::teleport_bravo_midway();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::breach_gate_nag("breach_gate_nag_end");
  var0 = cos(35);

  for(;;) {
    var1 = scripts\engine\utility::getStruct("breach_gate", "targetname");
    var2 = distance(level.player.origin, var1.origin);

    if(var2 < 540) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var1.origin, var0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var1.origin, [level.player])) {
        break;
      } else if(var2 < 455) {
        break;
      }
    }

    waitframe();
  }

  level notify("breach_gate_nag_end");
  level.alpha4 stopsounds();
  level.alpha4 thread scripts\engine\sp\utility::smart_radio_dialogue_interrupt("dx_vom_b63_breached_gate_courtyard_10");
  thread scripts\engine\sp\utility::autosave_now();
  wait 0.8;
  scripts\engine\utility::flag_set("breach_gate");
}

function lb_unload_catchup() {
  scripts\engine\utility::flag_set("player_in_1st_building");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::b1_open_door();
}

function breached_gate_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::array_spawn_targetname("infil_caged_dog");
  var0 = scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  var1 = scripts\engine\utility::getStruct("unload_overwatch", "targetname");
  level.overwatch teleport(var1.origin, var1.angles);
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil::overwatch_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::teleport_bravo_midway();

  foreach(var3 in var0) {
    var1 = scripts\engine\utility::getStruct("unload_" + var3.animname, "targetname");
    var3 teleport(var1.origin, var1.angles);

    if(var3.animname == "alpha5") {
      var3 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      continue;
    }

    if(var3.animname == "alpha6") {
      var3 setgoalnode(getnode("alpha6_b1_node", "targetname"));
    }
  }

  var5 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_off(var5);
  scripts\engine\sp\utility::set_start_location("breached_gate", [level.player]);
  var6 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_alpha_breach_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::breach_gate();
  var6 thread scripts\sp\maps\tunnels\zd30tunnels_infil::allies_nvg_on(1);
}

function main_breached_gate() {
  thread start_midway_guys();
  scripts\engine\utility::flag_wait("breach_finished");
  setsaveddvar("MMLNNQSTTL", "0");
  level.maindoor = getscriptablearray("compound_door", "targetname");
  level.maindoor[0] thread scripts\sp\maps\tunnels\zd30tunnels_infil::maindoor_damage_watcher();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::alpha_moveup_post_breach();
  var0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var1 = [level.alpha2, level.alpha3, level.alpha4];

  foreach(var3 in var1) {
    var3 thread scripts\sp\maps\tunnels\zd30tunnels_infil::moveto_compound(var0);
    var3 scripts\common\ai::poi_enable(1, scripts\engine\utility::getStruct("yard_poi_" + var3.animname, "targetname"));
  }

  scripts\engine\utility::flag_wait_all("price_approach_finished", "bravo4_approach_finished", "bravo5_approach_finished");
  scripts\engine\utility::flag_wait("set_yard_targets");
  var1 = [level.price, level.bravo4, level.bravo5, level.bravo1, level.bravo2];

  foreach(var3 in var1) {
    var3 thread scripts\sp\maps\tunnels\zd30tunnels_infil::moveto_compound(var0);

    if(var3.animname != "bravo5") {
      var3 scripts\common\ai::poi_enable(1, scripts\engine\utility::getStruct("yard_poi_" + var3.animname, "targetname"));
    }
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_1f_main_door(var0);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_1f_side_door(var0);
}

function start_midway_guys() {
  scripts\engine\utility::flag_wait("breach_explosion");
  var0 = [level.price, level.bravo4, level.bravo5];

  foreach(var2 in var0) {
    var2 thread scripts\sp\maps\tunnels\zd30tunnels_infil::moveto_midway();
  }
}

function breached_gate_catchup() {}

function comp_1f_start() {
  level.player clearclienttriggeraudiozone(1);
  var0 = scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  var1 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  var2 = scripts\engine\utility::array_combine(var0, var1, [level.price]);

  foreach(var4 in var2) {
    if(var4.animname == "overwatch" || var4.animname == "alpha5" || var4.animname == "alpha6") {
      var5 = scripts\engine\utility::getStruct("unload_" + var4.animname, "targetname");
      var4 teleport(var5.origin, var5.angles);

      if(var4.animname == "alpha5") {
        var4 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      } else if(var4.animname == "alpha6") {
        var4 setgoalnode(getnode("alpha6_b1_node", "targetname"));
      }

      continue;
    }

    if(var4.animname == "alpha3" || var4.animname == "alpha4") {
      var5 = scripts\engine\utility::getStruct("comp_1f_" + var4.animname, "targetname");
      var4 teleport(var5.origin, var5.angles);
      var4 scripts\engine\sp\utility::set_goal_node_targetname(var5.target);
      continue;
    }

    var5 = scripts\engine\utility::getStruct("comp_1f_" + var4.animname, "targetname");
    var4 teleport(var5.origin, var5.angles);
  }

  var7 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil::overwatch_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_1f_side_door_arrival();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_1f_side_door(var7);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_1f_main_door_arrival();
  var8 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var8 thread scripts\sp\maps\tunnels\zd30tunnels_infil::allies_nvg_on(1);
  var9 = ["compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_off(var9);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_main_door_jumpto_damage();
  scripts\engine\sp\utility::set_start_location("comp_1f", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("reach_main_house");
}

function main_comp_1f() {
  thread audio_thread_lever();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::side_breach_1f_vo();
  scripts\engine\utility::flag_wait("player_in_1f_back_room");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::clip_delete("1f_backtrack_safety_clip", "power_is_off");
  var0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::power_interact();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::waittill_player_looks_at_hallway(var0);
  scripts\engine\utility::flag_wait("player_back_in_hallway");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::moveup_1f_hallway(var0);
  level.bravo4 scripts\sp\maps\tunnels\zd30tunnels_infil::moveto_unbreachable_door(var0);
  var1 = ["dx_vom_b63_1st_floor_power_60", "dx_vom_b63_1st_floor_power_70"];

  if(!scripts\engine\utility::flag("power_is_off")) {
    level.bravo4 thread scripts\sp\maps\tunnels\zd30tunnels_infil::notetrack_nag(var1, "power_is_off");
  }

  var0 thread scripts\common\anim::anim_loop_solo_with_nags(level.bravo4, "1f_hallway_idle", "stop_loop_hallway");
  scripts\engine\utility::flag_wait("power_is_off");
  var2 = [level.bravo5];
  var2 thread scripts\sp\maps\tunnels\zd30tunnels_infil::allies_nvg_on(1);
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control, "2f_stairs");
  level.price scripts\sp\maps\tunnels\zd30tunnels_infil::setup_2f_price(var0);
  var3 = scripts\sp\maps\tunnels\zd30tunnels_infil::compound_door_setup("1f_hallway_door");
  var3[0] scripts\engine\sp\utility::assign_animtree("hallway_door");
  var2 = [level.price, level.bravo4, level.bravo2];
  var0 notify("stop_loop_hallway");
  var0 notify("stop_first_frame");
  var3[0] thread scripts\sp\maps\tunnels\zd30tunnels_infil::open_1f_hallway_door(var0);
  var0 scripts\common\anim::anim_single(var2, "1f_hallway_open");
  var1 = ["dx_vom_pri_2nd_floor_stairs_32", "dx_vom_pri_1st_floor_stairs_20", "dx_vom_b63_1st_floor_stairs_30"];
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil::notetrack_nag(var1, "stairs_2f_nag_end");
  var0 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "1f_hallway_open_idle", "ready_2f_ascend");
  var0 thread scripts\common\anim::anim_loop_solo(level.bravo4, "1f_hallway_open_idle", "stop_loop_1f_hallway_open");
  var0 thread scripts\common\anim::anim_loop_solo(level.bravo2, "1f_hallway_open_idle", "stop_loop_cleanup");
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil::stairtrain_1f();
}

function comp_1f_catchup() {
  if(!scripts\sp\starts::is_after_start("basement")) {
    scripts\sp\player::player_movement_state("creep");
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::force_open_doors("1f_runner_door");
  }

  scripts\engine\utility::flag_set("1f_runner_start");
}

function comp_2f_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil::overwatch_setup();
  var0 = scripts\engine\utility::getStruct("unload_" + level.overwatch.animname, "targetname");
  level.overwatch teleport(var0.origin, var0.angles);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::open_main_door();
  var1 = scripts\sp\maps\tunnels\zd30tunnels_infil::compound_door_setup("1f_hallway_door");
  var1[0] scripts\engine\sp\utility::assign_animtree("hallway_door");
  var2 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var2 scripts\common\anim::anim_last_frame_solo(var1[0], "1f_hallway_open");
  var3 = ["dx_vom_pri_2nd_floor_stairs_32", "dx_vom_pri_1st_floor_stairs_20", "dx_vom_b63_1st_floor_stairs_30"];
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil::notetrack_nag(var3, "stairs_2f_nag_end");
  var2 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "1f_hallway_open_idle", "ready_2f_ascend");
  var2 thread scripts\common\anim::anim_loop_solo(level.bravo4, "1f_hallway_open_idle", "stop_loop_1f_hallway_open");
  var2 thread scripts\common\anim::anim_loop_solo(level.bravo2, "1f_hallway_open_idle", "stop_loop_cleanup");
  var4 = [level.alpha5, level.alpha6];

  foreach(var6 in var4) {
    var0 = scripts\engine\utility::getStruct("unload_" + var6.animname, "targetname");
    var6 teleport(var0.origin, var0.angles);

    if(var6.animname == "alpha5") {
      var6 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      continue;
    }

    if(var6.animname == "alpha6") {
      var6 setgoalnode(getnode("alpha6_b1_node", "targetname"));
    }
  }

  var8 = getnode("1f_guard_civs", "targetname");
  level.bravo5 forceteleport(var8.origin, var8.angles);
  level.bravo5 setgoalnode(var8);
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil::stairtrain_1f();
  level.bravo1 thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_2f_bravo1(var2);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_1f_civ_jumpto();
  var4 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var4 thread scripts\sp\maps\tunnels\zd30tunnels_infil::allies_nvg_on(1);
  var3 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_off(var3);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::start_point_nvg_on_hint();
  scripts\engine\sp\utility::set_start_location("comp_2f", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("2f_stairs");
}

function main_comp_2f() {
  scripts\engine\utility::flag_wait("player_at_2f_stairs");
  level.player scripts\engine\utility::delaythread(5, &scripts\engine\sp\utility::set_player_demeanor, "normal");
  level.dataciv = scripts\engine\sp\utility::spawn_script_noteworthy("2f_data_room_civ");
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");
  var0 = scripts\engine\utility::array_add(level.dataenemies, level.dataciv);
  var0 scripts\sp\maps\tunnels\zd30tunnels_infil::setup_2f_data_enemies();
  var1 = scripts\sp\door::double_doors_init_targetname("2f_data_door");
  var1[0] scripts\sp\door::remove_open_prompts();
  var1 scripts\engine\utility::array_thread(var1, &scripts\game\sp\door::remove_door_snake_cam_ability);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_2f_stairs_vo();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_2f_bedroom();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  thread add_clip();
  scripts\engine\utility::flag_wait_any("player_in_2f_hallway", "price_kick_in_door");
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("locate_wolf2");

  if(scripts\engine\utility::flag("price_kick_in_door")) {
    var2 = gettime() + 1200;

    for(;;) {
      if(scripts\engine\utility::flag("player_in_2f_hallway")) {
        break;
      } else if(gettime() >= var2) {
        break;
      }

      waitframe();
    }
  }

  var3 = scripts\engine\utility::getStruct("2f_hallway_struct", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("player_midway_in_2f_hallway")) {
      break;
    } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var3.origin, cos(20)) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var3.origin, [level.player])) {
      break;
    }

    waitframe();
  }

  scripts\engine\sp\utility::array_spawn_noteworthy("2f_enemies");
  scripts\engine\utility::flag_wait("player_in_2f_hallway");
  var4 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var4 notify("stop_loop_1f_hallway_open");
  level.bravo4 thread scripts\sp\maps\tunnels\zd30tunnels_infil::bravo4_movements();
  scripts\engine\utility::flag_wait("3f_ready");
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("3f_stairs");
}

function add_clip() {
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::clip_delete("2f_stairs_up_clip", "3f_ready");
  scripts\engine\utility::flag_wait("player_in_2f_hallway");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::clip_delete("2f_stairs_down_clip", "3f_scene_done");
}

function comp_2f_catchup() {
  if(!scripts\sp\starts::is_after_start("basement")) {
    var0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
    var1 = scripts\sp\maps\tunnels\zd30tunnels_infil::compound_door_setup("1f_hallway_door");
    var1[0] scripts\engine\sp\utility::assign_animtree("hallway_door");
    var0 scripts\common\anim::anim_last_frame_solo(var1[0], "1f_hallway_open");
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::force_open_doors("2f_data_door", "2f_hallway_door", "2f_runner_door");
    return;
  }
}

function comp_3f_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil::overwatch_setup();
  var0 = scripts\engine\utility::getStruct("unload_" + level.overwatch.animname, "targetname");
  level.overwatch teleport(var0.origin, var0.angles);
  var1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var1 thread scripts\common\anim::anim_loop_solo(level.bravo2, "1f_hallway_open_idle", "stop_loop_cleanup");
  var2 = scripts\engine\utility::getStruct("2f_animnode", "targetname");
  var2 thread scripts\common\anim::anim_loop_solo(level.price, "2f_data_scene_idle", "stop_loop_cleanup");
  var1 = scripts\engine\utility::getStruct("temp_2f_animnode2", "targetname");
  var1 thread scripts\common\anim::anim_loop_solo(level.bravo4, "2f_hallway_post_idle", "stop_loop_cleanup");
  var1 = scripts\engine\utility::getStruct("3f_animnode", "targetname");
  var1 thread scripts\common\anim::anim_loop_solo(level.bravo1, "3f_stairs_intro", "stop_3f_stairs");
  var3 = [level.alpha5, level.alpha6];

  foreach(var5 in var3) {
    var0 = scripts\engine\utility::getStruct("unload_" + var5.animname, "targetname");
    var5 teleport(var0.origin, var0.angles);

    if(var5.animname == "alpha5") {
      var5 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      continue;
    }

    if(var5.animname == "alpha6") {
      var5 setgoalnode(getnode("alpha6_b1_node", "targetname"));
    }
  }

  var7 = getnode("1f_guard_civs", "targetname");
  level.bravo5 forceteleport(var7.origin, var7.angles);
  level.bravo5 setgoalnode(var7);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::open_main_door();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_1f_civ_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_civ_jumpto();
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");

  foreach(var5 in level.dataenemies) {
    var2 scripts\common\anim::anim_last_frame_solo(var5, "2f_data_scene");
  }

  var3 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var3 thread scripts\sp\maps\tunnels\zd30tunnels_infil::allies_nvg_on(1);
  var10 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_off(var10);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::start_point_nvg_on_hint();
  scripts\engine\sp\utility::set_start_location("comp_3f", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("3f_stairs");
}

function main_comp_3f() {
  var0 = scripts\sp\maps\tunnels\zd30tunnels_infil::balcony_3f_door();
  var1 = scripts\sp\maps\tunnels\zd30tunnels_infil::bedroom_3f_door();
  scripts\engine\utility::flag_wait("player_at_3f_stairs");
  var2 = scripts\engine\utility::getStruct("3f_animnode", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_3f_scene(var2);
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.bravo1 thread scripts\sp\maps\tunnels\zd30tunnels_infil::stairtrain_2f(var2);
  scripts\engine\utility::flag_wait("player_in_3f_hallway");
  thread scripts\engine\sp\utility::autosave_now();
  scripts\engine\utility::flag_wait("3f_scene_done");
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("downstairs");
  var2 notify("stop_last_frame");
}

function comp_3f_catchup() {
  if(!scripts\sp\starts::is_after_start("downstairs")) {
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::force_open_doors("3f_bedroom_door");
    level.heli_charlie = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("heli_charlie");
    level.heli_charlie.animname = "heli_charlie_end";
    level.heli_charlie scripts\engine\sp\utility::assign_animtree("heli_charlie_end");
    level.heli_charlie thread scripts\sp\maps\tunnels\zd30tunnels_infil::charlie_heli_lights();
    scripts\common\vehicle_build::build_treadfx("script_vehicle_iw8_lbravo_carrier", "default", "vfx/code/tread/heli_dust_default.vfx");
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_gear_alex();
    return;
  }

  if(!scripts\sp\starts::is_after_start("tea_room")) {
    thread scripts\sp\maps\tunnels\zd30tunnels_infil::setup_gear_alex();
    return;
  }
}

function downstairs_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::open_main_door();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_1f_civ_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_civ_jumpto();
  var0 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_on(var0);
  scripts\engine\sp\utility::set_start_location("start_downstairs", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("downstairs");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
}

function main_downstairs() {
  scripts\sp\maps\tunnels\zd30tunnels_infil::setup_downstairs_pillage();
}

function cleanup_compound_ents() {
  var0 = gettime();
  var1 = 0;
  waitframe();
  var2 = scripts\engine\utility::array_combine(level.cleanup, level.civs, level.charlie);

  foreach(var4 in var2) {
    if(!isDefined(var4)) {
      continue;
    }

    if(isai(var4) && isalive(var4)) {
      var4 scripts\engine\sp\utility::anim_stopanimScripted();

      if(istrue(var4.magic_bullet_shield)) {
        var4 scripts\common\ai::stop_magic_bullet_shield();
      }

      var4 kill();
    }

    var4 delete();
    var1++;
  }

  if(isDefined(level.kyledrone)) {
    level.kyledrone delete();
  }

  if(isDefined(level.interactive_doors) && isDefined(level.interactive_doors.ents)) {
    foreach(var4 in level.interactive_doors.ents) {
      if(isDefined(var4.clip)) {
        var1++;
        var4.clip delete();
      }
    }
  }

  var8 = getEntArray("trigger_multiple_flag_set", "classname");
  var9 = getEntArray("trigger_multiple", "classname");
  var10 = scripts\engine\utility::array_combine(var8, var9);

  foreach(var4 in var10) {
    if(!isDefined(var4) || !isDefined(var4.origin) || var4.origin == (0, 0, 0)) {
      continue;
    }

    if(var4.origin[0] > -800) {
      var4 delete();
      var1++;
    }
  }

  var13 = gettime() - var0;
  scripts\engine\utility::delaythread(5, &scripts\sp\maps\tunnels\zd30tunnels_utility::debug_print, "^1Cleaned up " + var1 + " entities in " + var13 + "ms");
}

function downstairs_catchup() {}

function tea_room_start() {
  level.player clearclienttriggeraudiozone(1);
  var0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  scripts\engine\sp\utility::array_spawn_noteworthy("charlie");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  scripts\sp\maps\tunnels\zd30tunnels_infil::setup_kyledrone(var0);
  level.revealrope = scripts\engine\sp\utility::spawn_anim_model("reveal_rope");
  var1 = scripts\engine\utility::array_combine([level.price, level.revealrope], level.charlie);

  foreach(var3 in var1) {
    if(isDefined(level.scr_anim[var3.animname]["landing_idle"])) {
      var0 thread scripts\common\anim::anim_loop_solo(var3, "landing_idle", "stop_landing_charlie");
      continue;
    }

    if(isDefined(var3.magic_bullet_shield)) {
      var3 scripts\common\ai::stop_magic_bullet_shield();
    }

    var3 delete();
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_infil::open_main_door();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_1f_civ_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::spawn_2f_civ_jumpto();
  var5 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::compound_lights_on(var5);
  scripts\sp\maps\tunnels\zd30tunnels_infil::objective_control("lift_trap_door");
  scripts\engine\sp\utility::set_start_location("tea_room", [level.player]);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::trap_door_plywood(var0);
}

function main_tea_room() {
  thread scripts\sp\maps\tunnels\zd30tunnels_infil::trap_door_scene();
  level waittill("tunnels_transition");
  visionsetnaked("zd30tunnels_upper", 0.5);
  setsaveddvar("MMLNNQSTTL", 15);
  thread cleanup_compound_ents();
  setomnvar("ai_fulllight", 1e-07);
  setomnvar("ai_nolight", 0.02);
}

function tea_room_catchup() {
  setomnvar("ai_fulllight", 1e-07);
  setomnvar("ai_nolight", 0.02);
  scripts\sp\player_rig::get_player_rig();
  thread cleanup_compound_ents();
}

function main_basement() {
  scripts\sp\maps\tunnels\zd30tunnels_basement::basement();
}

function main_basement_tunnel() {
  scripts\sp\maps\tunnels\zd30tunnels_basement::basement_tunnel();
}

function main_collapse() {
  scripts\sp\maps\tunnels\zd30tunnels_basement::collapse();
}

function main_storage() {
  scripts\sp\maps\tunnels\zd30tunnels_storage::storage();
}

function main_storage_oil() {
  scripts\sp\maps\tunnels\zd30tunnels_storage::storage_oil();
}

function main_storage_split() {
  scripts\sp\maps\tunnels\zd30tunnels_storage::storage_split();
}

function main_mine() {
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft::mine();
}

function main_shaft() {
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft::shaft();
}

function main_reunion() {
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft::reunion();
}

function main_wolf() {
  scripts\sp\maps\tunnels\zd30tunnels_wolf::wolf();
  level waittill("godot");
}

function coldopen_bink_start() {
  scripts\engine\sp\utility::set_start_location("start_coldopen_bink", [level.player]);
}

function coldopen_bink_catchup() {}

function main_coldopen_bink() {
  thread coldopen_bink_move_scene();
  level waittill("godot");
}

function coldopen_bink_move_scene() {
  var0 = getEnt("1f_hallway_door", "targetname");
  var0 delete();
  var1 = getEnt("1f_hallway_door_clip", "targetname");
  var1 delete();
  var2 = getEntArray("player_movement_clip", "script_noteworthy");

  foreach(var4 in var2) {
    var4 scripts\engine\sp\utility::hide_entity();
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  scripts\sp\maps\tunnels\zd30tunnels_infil::power_down_electronics();
  var6 = getEnt("coldopen_bink_anim_node", "script_noteworthy");
  level.node = var6 scripts\engine\utility::spawn_script_origin();
  level.butcher = scripts\engine\sp\utility::spawn_targetname("butcherSpawner", 1);
  level.butcher.animname = "butcher";
  level.butcher.ignoreall = 1;
  level.butcher.ignoreme = 1;
  level.butcher.noragdoll = 1;
  level.butcher.team = "axis";
  level.butcher.name = "";
  level.butcher.callsign = "";
  level.butcher scripts\common\ai::gun_remove();
  level.butcher visiblenotsolid();
  level.player setstance("stand");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  var7 = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.node.origin, level.node.angles);
  level.player playerlinktoabsolute(var7, "tag_player");
  level.player hideviewmodel();
  var7 hide();
  var6.origin = level.node.origin;
  var6.angles = level.node.angles;
  level.player modifybasefov(35, 0.05);
  setsaveddvar("OMNONNMOTP", "0.1 400 0.5 1000");
  level.player setcinematicmotionoverride("disabled");
  level.node.origin = (221.868, 823.872, 85);
  level.node.angles = (0, 58.1513, 0);
  level.wolf = scripts\engine\sp\utility::spawn_targetname("wolfSpawner", 1);
  level.wolf.animname = "wolf";
  level.wolf.ignoreall = 1;
  level.wolf.ignoreme = 1;
  level.wolf.noragdoll = 1;
  level.wolf.team = "axis";
  level.wolf.name = "";
  level.wolf.callsign = "";
  level.wolf scripts\common\ai::gun_remove();
  level.wolf visiblenotsolid();
  level.wolf setModel("body_villain_wolf_desert");
  level.node thread scripts\common\anim::anim_first_frame_solo(level.wolf, "coldopen_bink");
  level.node thread scripts\common\anim::anim_first_frame_solo(level.butcher, "coldopen_bink");
  level.node scripts\common\anim::anim_first_frame_solo(var7, "coldopen_bink");
  wait 2;
  thread co_cine_dof();
  thread wolf_scene_lights(level.node, var6);
  thread co_wolf_mayhem();
  thread co_butcher_mayhem();
  level.node thread scripts\common\anim::anim_single_solo(level.wolf, "coldopen_bink");
  level.node thread scripts\common\anim::anim_single_solo(level.butcher, "coldopen_bink");
  level.node scripts\common\anim::anim_single_solo(var7, "coldopen_bink");
  level.node thread scripts\common\anim::anim_last_frame_solo(level.wolf, "coldopen_bink");
  level.node thread scripts\common\anim::anim_last_frame_solo(level.butcher, "coldopen_bink");
  level.node thread scripts\common\anim::anim_last_frame_solo(var7, "coldopen_bink");
}

function co_cine_dof() {
  level.wolf scripts\engine\sp\utility::dof_enable_autofocus(2.8, 100, undefined, undefined, "tag_eye");
}

function move_scene(var0) {
  iprintlnbold("Move the Wolf around - Hold ADS to start the scene.");
  thread stop_move_scene();
  level endon("picked_spot");
  level.wolf = scripts\engine\sp\utility::spawn_targetname("wolfSpawner", 1);
  level.wolf.animname = "wolf";
  level.wolf.ignoreall = 1;
  level.wolf.ignoreme = 1;
  level.wolf.noragdoll = 1;
  level.wolf.team = "axis";
  level.wolf.name = "";
  level.wolf.callsign = "";
  level.wolf scripts\common\ai::gun_remove();
  level.wolf visiblenotsolid();
  level.wolf setModel("body_villain_wolf_desert");
  level.wolf forceteleport(var0.origin, var0.angles, 10000);
  level.wolf linkTo(var0);

  for(;;) {
    var1 = level.player.origin + anglesToForward(level.player.angles) * 60;
    var2 = level.player.angles + (0, 180, 0);
    var0.origin = var1;
    var0.angles = var2;
    var0 scripts\common\anim::anim_first_frame_solo(level.wolf, "coldopen_bink");
    waitframe();
  }
}

function stop_move_scene() {
  var0 = 0;

  for(;;) {
    if(level.player adsButtonPressed()) {
      var0++;

      if(var0 == 10) {
        break;
      }
    } else {
      var0 = 0;
    }

    waitframe();
  }

  level.player playRumbleOnEntity("damage_heavy");
  level notify("picked_spot");
}

function wolf_scene_lights(var0, var1) {
  level.wolf_scene_light_key = getEnt("wolf_light_key", "script_noteworthy");
  level.wolf_scene_light_key setlightintensity(0);
  level.wolf_scene_light_rim = getEnt("wolf_light_rim", "script_noteworthy");
  level.wolf_scene_light_rim setlightintensity(0);
  level.wolf_scene_light_rim_lf = getEnt("wolf_light_rim_lf", "script_noteworthy");
  level.wolf_scene_light_rim_lf setlightintensity(0);
  level.wolf_scene_light_fill = getEnt("wolf_light_fill", "script_noteworthy");
  level.wolf_scene_light_fill setlightintensity(0);
  level.wolf_scene_lights_node = getEnt("wolf_light_org", "script_noteworthy");
  level.wolf_scene_light_key linkTo(level.wolf_scene_lights_node);
  level.wolf_scene_light_rim linkTo(level.wolf_scene_lights_node);
  level.wolf_scene_light_rim_lf linkTo(level.wolf_scene_lights_node);
  level.wolf_scene_light_fill linkTo(level.wolf_scene_lights_node);
  level.wolf_scene_lights_node.origin = level.node.origin;
  level.wolf_scene_lights_node.angles = level.node.angles;
  waitframe();
  level.wolf_scene_light_fill setlightintensity(0.044);
  level.wolf_scene_light_key setlightintensity(0.35);
  level.wolf_scene_light_rim setlightintensity(0.1);
  level.wolf_scene_light_rim_lf setlightintensity(0.1);
}

#using_animtree("");

function co_wolf_mayhem() {
  level.wolf detach(level.wolf.headmodel);
  level.wolf setanim(%co_wolf_video_wolf_face, 1, 0, 1);
  level waittill("wolf_mayhem_end");
  level.wolf setanim($co_wolf_video_wolf_face, 0, 0, 1);
  level.wolf attach(level.wolf.headmodel);
}

function co_butcher_mayhem() {
  level.butcher detach(level.butcher.headmodel);
  level.butcher setanim(%co_wolf_video_butcher_face, 1, 0, 1);
  level waittill("butcher_mayhem_end");
  level.butcher setanim(%co_wolf_video_butcher_face, 0, 0, 1);
  level.butcher attach(level.butcher.headmodel);
}

function audio_thread_lever() {
  var0 = spawn("script_origin", (446.525, 1042.04, 192.998));
  var1 = getEnt("main_door_trigger", "targetname");
  var1 waittill("trigger", var2);
  var0 playLoopSound("emt_scripted_light_hum_lp");
  scripts\engine\utility::flag_wait("power_is_off");
  wait 1;
  var0 stoploopsound();
  wait 0.1;
  var0 delete();
}