/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\tunnels.gsc
***********************************************/

main() {
  scripts\sp\maps\tunnels\gen\tunnels_art.gsc::main();
  scripts\sp\maps\tunnels\tunnels_fx.gsc::main();
  scripts\sp\maps\tunnels\tunnels_precache.gsc::main();
  scripts\sp\maps\tunnels\zd30tunnels_anim.gsc::main();
  scripts\sp\maps\tunnels\zd30tunnels_lighting.gsc::main();
  scripts\sp\player\flare::level_flareinit();
  level.tossed_flares = [];
  level.flare_pickup_disabled = 1;
  level.flarefastpickup = 1;
  level.player setclienttriggeraudiozone("fade_to_black_minus_music", 0.05);
  var_0 = getEnt("info_player_start", "classname");
  var_0.origin = (-14848, -536, 296);
  var_1 = undefined;
  scripts\engine\sp\utility::add_start("intro", ::intro_start, var_1, ::main_intro, var_1, ::intro_catchup);
  scripts\engine\sp\utility::add_start("heli_infil", ::lb_infil_start, var_1, ::main_lb_infil, var_1, ::lb_infil_catchup);
  scripts\engine\sp\utility::add_start("heli_unload", ::lb_unload_start, var_1, ::main_lb_unload, var_1, ::lb_unload_catchup);
  scripts\engine\sp\utility::add_start("breached_gate", ::breached_gate_start, var_1, ::main_breached_gate, var_1, ::breached_gate_catchup);
  scripts\engine\sp\utility::add_start("1st_floor", ::comp_1f_start, var_1, ::main_comp_1f, var_1, ::comp_1f_catchup);
  scripts\engine\sp\utility::add_start("2nd_floor", ::comp_2f_start, var_1, ::main_comp_2f, var_1, ::comp_2f_catchup);
  scripts\engine\sp\utility::add_start("3rd_floor", ::comp_3f_start, var_1, ::main_comp_3f, var_1, ::comp_3f_catchup);
  scripts\engine\sp\utility::add_start("downstairs", ::downstairs_start, var_1, ::main_downstairs, var_1, ::downstairs_catchup);
  scripts\engine\sp\utility::add_start("tea_room", ::tea_room_start, var_1, ::main_tea_room, var_1, ::tea_room_catchup);
  scripts\engine\sp\utility::add_start("basement", scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement_start, var_1, ::main_basement, var_1, scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement_catchup);
  scripts\engine\sp\utility::add_start("basement_tunnel", scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement_tunnel_start, var_1, ::main_basement_tunnel, var_1, scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement_tunnel_catchup);
  scripts\engine\sp\utility::add_start("collapse", scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::collapse_start, var_1, ::main_collapse, var_1, scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::collapse_catchup);
  scripts\engine\sp\utility::add_start("storage", scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_start, var_1, ::main_storage, var_1, scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_catchup);
  scripts\engine\sp\utility::add_start("storage_oil", scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_oil_start, var_1, ::main_storage_oil, var_1, scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_oil_catchup);
  scripts\engine\sp\utility::add_start("storage_split", scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_split_start, var_1, ::main_storage_split, var_1, scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_split_catchup);
  scripts\engine\sp\utility::add_start("mine", scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::mine_start, var_1, ::main_mine, var_1, scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::mine_catchup);
  scripts\engine\sp\utility::add_start("shaft", scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::shaft_start, var_1, ::main_shaft, var_1, scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::shaft_catchup);
  scripts\engine\sp\utility::add_start("reunion", scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::reunion_start, var_1, ::main_reunion, var_1, scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::reunion_catchup);
  scripts\engine\sp\utility::add_start("wolf", scripts\sp\maps\tunnels\zd30tunnels_wolf.gsc::wolf_start, var_1, ::main_wolf, var_1, scripts\sp\maps\tunnels\zd30tunnels_wolf.gsc::wolf_catchup);
  scripts\engine\sp\utility::add_start("coldopen_bink", ::coldopen_bink_start, "", ::main_coldopen_bink, var_1, ::coldopen_bink_catchup);
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

intro_screen() {
  scripts\engine\sp\utility::intro_screen_custom_func(::intro_screen_delay);
}

intro_screen_delay() {
  wait 6.5;
  scripts\sp\introscreen::introscreen(1);
}

setup_scriptable_lights_for_compile() {
  var_0 = getEntArray("light_spot", "classname");
  var_0 = scripts\engine\utility::array_combine(getEntArray("light_omni", "classname"), var_0);

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    if(getDvar("LLQQOPKTKM") == "1") {
      var_2 setlightintensity(0);
      var_2 setlightcolor(0, 0, 0);
    }
  }
}

level_inits() {
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
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::init_utility_triggers();
  init_player_monitors();
  init_easter_eggs();
  scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::init_spawnfunctions();
  init_shootable_lanterns();
  setdvarifuninitialized("greenlight", 0);
  var_0 = scripts\sp\player_rig::get_player_rig();
  var_0 hide();
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  disableaudiotrigger("mine_shaft_occluder");
}

init_precache() {
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
  scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::precache_basement();
  scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::precache_storage();
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::precache_mineshaft();
}

init_loadout() {
  scripts\sp\nvg\nvg_player::main("nvg_tunnels");
  scripts\game\sp\door::set_snake_cam_vision("snake_cam_estate");
  level.player scripts\sp\player::remove_all_armor();
  var_0 = ["frag", "flash", "semtex", "molotov", "smoke"];
  scripts\engine\sp\utility::offhandprecache(var_0);

  if(scripts\sp\starts::is_after_start("tea_room"))
    alex_loadout();
  else
    kyle_loadout();
}

kyle_loadout() {
  level.player.maxvisibiltyupdate_disabled = 1;
  level.player.maxvisibledist = 8192;
  level.player scripts\sp\player::set_player_max_health(60);
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setplayerviewmodel("viewmodel_arms_kyle_woodland", "viewhands_base_legs_iw8", "default_character_shadow");
  var_0[0] = scripts\sp\utility::make_weapon_special("kyle_ar");
  var_0[1] = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["silencerpstl_west01"]);
  level.player giveweapon(var_0[0], 0, 0, 0, 1);
  level.player giveweapon(var_0[1], 0, 0, 0, 1);
  level.player scripts\engine\sp\utility::give_offhand("flash", 2);
  level.player switchtoweapon(var_0[0]);
  level.player laseron();
}

alex_loadout() {
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setplayerviewmodel("viewhands_alex_gloves_a", "viewhands_base_legs_iw8", "default_character_shadow");
  level.player takeallweapons();
  level.player scripts\sp\utility::give_weapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  level.player scripts\engine\sp\utility::allow_nvg(0, "zd30Tunnels", 1);
  setomnvar("ui_nvg_equipped", 0);
  level.scr_model["player_rig"] = "viewhands_alex_gloves_a";
  thread alex_loadout_final();
}

alex_loadout_final() {
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_tunnels);

  if(!scripts\sp\starts::is_after_start("basement"))
    scripts\engine\utility::flag_wait("tunnels_gun_ready");

  level.player scripts\sp\utility::take_weapon("iw8_gunless");
  var_0 = alex_weapons_config();
  level.player.loadout_weapons = var_0;
  level.player giveweapon(var_0[0]);
  level.player giveweapon(var_0[1]);
  level.player scripts\engine\sp\utility::give_offhand("flash");
  level.player givemaxammo("flash");
  level.player scripts\engine\sp\utility::give_offhand("semtex");
  level.player setweaponammostock("semtex", 0);
  level.player setweaponammoclip("semtex", 0);
  level.player switchtoweapon(var_0[1]);
}

alex_weapons_config() {
  var_0[0] = scripts\sp\utility::make_weapon("iw8_sh_romeo870", ["reflex_west01"]);
  var_0[1] = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  var_0[1] = var_0[1] withoutattachment("slide_mike1911");
  var_0[1] = var_0[1] withattachment("slide_tritium_mike1911");
  return var_0;
}

init_player_monitors() {
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_weapon_fire();
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_player_in_danger();
  thread init_player_death_monitor();
}

init_player_death_monitor() {
  level.player_death_refs = [];
  waitframe();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setup_player_deaths("storage_MG");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setup_player_deaths("shaft_puzzle");
}

init_easter_eggs() {
  level.easter_eggs = [];
  level.easter_eggs["tv_teddy"] = easter_egg_tv_teddy();
}

init_objectives() {}

init_hints() {
  scripts\engine\sp\utility::add_hint_string("hint_use_flashbang", &"ZD30/HINT_USEFLASH", scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_using_flash);
  scripts\engine\sp\utility::add_hint_string("hint_use_molotov", &"ZD30/HINT_USEMOLOTOV", scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_using_molotov);
  scripts\engine\sp\utility::add_hint_string("hint_shoot_on_ladder", &"ZD30/HINT_SHOOTONLADDER");
  scripts\engine\sp\utility::add_hint_string("wolf_defuse_hint", &"ZD30/HINT_WOLFBOMBDEFUSE", scripts\sp\maps\tunnels\zd30tunnels_wolf.gsc::wolf_bomb_vest_defuse_looked_at_any_wire);
  scripts\engine\sp\utility::add_hint_string("wolf_defuse_hint_kbm", &"ZD30/HINT_WOLFBOMBDEFUSE_KBM", scripts\sp\maps\tunnels\zd30tunnels_wolf.gsc::wolf_bomb_vest_defuse_looked_at_any_wire);
  scripts\engine\sp\utility::add_hint_string("storage_split_hint", &"ZD30/HINT_MINESGETUP");
}

init_flags() {
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

init_postspawns() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alpha", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_allies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("bravo", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_allies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("charlie", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_charlie);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("price", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_hero);
  scripts\engine\sp\utility::array_spawn_function_targetname("infil_caged_dog", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_infil_dogs);
  scripts\engine\sp\utility::array_spawn_function_targetname("1f_civ_back_room", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_1f_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2f_data_room", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_2f_data);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2f_data_room_civ", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_2f_dataciv);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2f_enemies", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::postspawn_2f_enemies);
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::friendly_nvg_setup);
  level._effect["breach_explode"] = loadfx("vfx/iw8/level/zd30/vfx_zd30_door_breach_thick.vfx");
  var_0 = getEnt("blood_smear", "script_noteworthy");
  var_0 hide();
  var_1 = getEntArray("player_movement_clip", "script_noteworthy");
  level.cleanup = scripts\engine\utility::array_combine(level.cleanup, var_1);

  foreach(var_3 in var_1)
  var_3 notsolid();

  var_5 = getEntArray("price_bty", "targetname");

  foreach(var_7 in var_5) {
    var_7.og_intensity = var_7 getlightintensity();
    var_7 setlightintensity(0);
  }
}

init_threatbias() {
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

level_compound_setup() {
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
    var_0 = getEnt("power_switch", "targetname");
    var_0.animname = "power";
    var_0 scripts\engine\sp\utility::assign_animtree();
    var_1 = scripts\engine\utility::getStruct("power_animnode", "targetname");
    var_1 thread scripts\common\anim::anim_first_frame_solo(var_0, "power_interact");
    var_0 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::power_interact_anim(var_1);
  }

  if(getdvarint("greenlight") == 1)
    scripts\engine\utility::flag_set("did_door_hint");

  setsaveddvar("NQQSKRQMTS", 0);
}

level_tunnel_setup() {
  setsaveddvar("MQPQKNPQOK", level.wind["amp"]);
  setsaveddvar("MRNRKKOPLN", level.wind["freq"]);
  setsaveddvar("LQLSPQOPKM", level.wind["area"]);
  setsaveddvar("OLSKLTPPMR", level.wind["noise"]);
  setsaveddvar("NQTLPTNSSO", level.wind["str"]);
  setsaveddvar("NTMMTOLQMQ", level.wind["dir"]);
  setsaveddvar("LKOLRONRNQ", 600);
  setsaveddvar("NQNQPRLRQM", 10);
  setomnvar("ai_fulllight", 0.0000001);
  setomnvar("ai_nolight", 0.02);
  level thread scripts\sp\utility::context_melee_enable(0);
  thread spawn_pre_placed_flares_for_tunnels();
  thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::tunnels_spawnfunctions();
  level.player_is_safe_from_smoke = 1;
  level.inside_shaft_trig = getEnt("inside_shaft", "targetname");
  level.special_autosavecondition = ::zd30_autosave_condition;
  level.custom_oilfire_think = scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::custom_collapse_oilfire_think;
  hadir();
  thread tunnels_achievement();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::tripwire_explosion_enhancement();
  thread player_tunnel_explosion_experience();
  thread player_ladder_aid();
  thread player_prone_slide_dirt_fx();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::offhand_box_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::tripwire_enemy_trip_monitor();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::tripwire_pathing_think();
  thread player_fov_think();
  thread player_aim_at_think();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_player_past_loc();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_player_jump();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::magic_grenades();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::oilfire_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::garbage_collector();
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_flashlight_maxvis_hack();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setup_traps();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::fall_damage_remove_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::stealth_break_monitor();
  thread player_unresolved_collision_suspend();
  thread scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::collapse_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::mines_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::shaft_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::reunion_setup();
}

player_unresolved_collision_suspend() {
  wait 2;
  level.player notify("stop_unresolved_collision_script");
}

tunnels_achievement() {
  level.tunnels_achievements = [];
  level thread tunnels_achievement_pistol_only();
}

tunnels_achievement_pistol_only() {
  level endon("bomb_vest_scene_finished");
  var_0 = "tunnelrat";
  level.tunnels_achievements[var_0] = 1;
  var_1 = "iw8_pi_mike1911";
  level thread tunnels_achievement_pistol_only_final(var_0);

  while(!scripts\engine\utility::flag("bomb_vest_scene_finished")) {
    var_2 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "grenade_fire", "offhand_fired");

    if(!isDefined(var_2) || var_2 == "grenade_fire" || var_2 == "offhand_fired") {
      level.tunnels_achievements[var_0] = 0;
      return;
    }

    var_3 = level.player getcurrentweapon();

    if(!isDefined(var_3) || !isDefined(var_3.basename)) {
      continue;
    }
    if(!issubstr(var_3.basename, var_1) || var_2 != "weapon_fired") {
      level.tunnels_achievements[var_0] = 0;
      return;
    }
  }
}

tunnels_achievement_pistol_only_final(var_0) {
  scripts\engine\utility::flag_wait("bomb_vest_scene_finished");
  wait 0.05;

  if(level.tunnels_achievements[var_0])
    scripts\sp\utility::giveachievement_wrapper(var_0);
}

player_aim_at_think() {
  var_0 = spawn("script_origin", level.player getEye());
  var_0 linkTo(level.player, "tag_eye");
  level.player.look_at_ent = var_0;
}

spawn_pre_placed_flares_for_tunnels() {
  level.flare_spawn_array = getEntArray("flare_shadow_casting_model", "targetname");
  var_0 = "tag_fx";

  foreach(var_2 in level.flare_spawn_array) {
    waitframe();
    playFXOnTag(level._effect["emergency_flare_nolight"], var_2, "tag_fx");
  }
}

init_shootable_lanterns() {
  thread init_shootable_lanterns_internal();
}

init_shootable_lanterns_internal() {
  waitframe();
  level.scriptable_lanterns = getscriptablearray("lantern", "targetname");
  level.scriptable_lantern_lights = getEntArray("lantern_light", "script_noteworthy");
  var_0 = 48;
  var_1 = 3;

  foreach(var_3 in level.scriptable_lanterns) {
    var_4 = [];

    foreach(var_6 in level.scriptable_lantern_lights) {
      if(!istrue(var_6.assaigned) && scripts\engine\utility::distance_2d_squared(var_6.origin, var_3.origin) < var_0 * var_0) {
        var_4[var_4.size] = var_6;
        var_6.assigned = 1;
      }

      if(var_4.size >= 3) {
        break;
      }
    }

    var_3.lights = var_4;
    var_3 thread scriptable_lantern_think();
  }
}

scriptable_lantern_think() {
  if(!isDefined(self.lights) || self.lights.size == 0) {
    return;
  }
  for(;;) {
    self waittill("scriptableNotification", var_0);

    if(isDefined(var_0) && (var_0 == "tact_lamp_shot" || var_0 == "gas_lantern_shot")) {
      break;
    }
  }

  scripts\engine\utility::array_call(self.lights, ::setlightintensity, 0);
}

zd30_autosave_condition() {
  if(is_anim_enemy_engaging_player(level.storage_ambusher_blind_fire_guy))
    return 0;

  if(is_anim_enemy_engaging_player(level.basement_first_cell_guy))
    return 0;

  if(scripts\engine\utility::flag("flare_in_fire") && !scripts\engine\utility::flag("collapse_hadir_convo"))
    return 0;

  if(!istrue(level.player_is_safe_from_smoke))
    return 0;

  if(scripts\engine\utility::flag("basement_trapdoor_entered")) {
    var_0 = 130;

    if(isDefined(level.tripwires.traps) && level.tripwires.traps.size > 0) {
      foreach(var_2 in level.tripwires.traps) {
        if(isDefined(var_2) && isDefined(var_2.origin) && distancesquared(level.player.origin, var_2.origin) < var_0 * var_0)
          return 0;
      }
    }
  }

  if(isDefined(level.player.lasttriptime)) {
    var_4 = 5;
    var_5 = gettime() - level.player.lasttriptime;

    if(var_5 > 0 && var_5 < var_4 * 1000)
      return 0;
  }

  if(isDefined(level.lastoilfiretime) && !scripts\engine\utility::flag("shaft_fire_on")) {
    var_4 = 5;
    var_5 = gettime() - level.lastoilfiretime;

    if(var_5 < var_4 * 1000)
      return 0;
  }

  if(scripts\engine\utility::flag("shaft_fire_on") && !scripts\engine\utility::flag("fire_phase1_started"))
    return 0;

  if(isDefined(level.storage_mg_guy) && isalive(level.storage_mg_guy)) {
    if(isDefined(level.storage_mg_shoot_zone) && level.player istouching(level.storage_mg_shoot_zone))
      return 0;

    if(isDefined(level.storage_mg_shoot_wall_zone) && level.player istouching(level.storage_mg_shoot_wall_zone))
      return 0;
  }

  if(scripts\engine\utility::flag("storage_final_room_entered") && !scripts\engine\utility::flag("storage_mg_passed") && !scripts\engine\utility::flag("storage_mg_crawl")) {
    if(!isDefined(level.alcove_trig)) {
      var_6 = getEntArray("turret_overheat_trig", "targetname");
      var_7 = spawn("script_model", (-4800, 2528, -496));
      var_7 setModel("tag_origin");

      foreach(var_9 in var_6) {
        if(var_7 istouching(var_9)) {
          level.alcove_trig = var_9;
          break;
        }
      }

      var_7 delete();
    }

    var_11 = 350;

    if(level.player istouching(level.alcove_trig)) {
      var_12 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

      if(var_12.size > 0) {
        var_12 = sortbydistance(var_12, level.player.origin);
        var_13 = var_12[0];

        if(scripts\engine\utility::distance_2d_squared(var_13.origin, level.player.origin) < var_11 * var_11)
          return 0;
      }
    }
  }

  if(scripts\engine\utility::flag("shaft_ladder_scene_execute") && !scripts\engine\utility::flag("shaft_plank_passed"))
    return 0;

  if(scripts\engine\utility::flag("shaft_plank_passed") && level.player istouching(level.inside_shaft_trig))
    return 0;

  return 1;
}

is_anim_enemy_engaging_player(var_0) {
  if(isDefined(var_0) && isalive(var_0)) {
    if(var_0 cansee(level.player))
      return 1;

    if(scripts\engine\sp\utility::player_looking_at(var_0 getEye(), 0.9, 1))
      return 1;
  }

  return 0;
}

easter_egg_tv_teddy() {
  var_0 = getEnt("tv_teddy", "targetname");
  var_0 thread easter_egg_tv_teddy_monitor();
  return var_0;
}

easter_egg_tv_teddy_monitor() {
  self endon("entitydeleted");
  self endon("death");
  self endon("failed");
  var_0 = getEnt(self.target, "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  wait 2;
  var_3 = getscriptablearray("mines_tv", "targetname")[0];

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = getEnt("mines_tv_light", "targetname");
  thread easter_egg_tv_light_flicker(var_4);
  var_1 thread easter_egg_tv_teddy_monitor_helper(var_0);
  var_5 = var_3.model;

  while(var_3.model == var_5)
    wait 0.1;

  var_4 notify("tv_light_off");
  waitframe();
  var_4 setlightintensity(0);
  var_1 waittill("damage");
  self.activated = 1;
  var_2 waittill("trigger");
  var_6 = scripts\engine\utility::getStruct("mines_bats", "targetname");
  var_7 = anglesToForward(var_6.angles);
  var_8 = anglestoup(var_6.angles);
  playFX(level._effect["vfx_zd30_bats"], var_6.origin, var_7, var_8);
  self hide();
}

easter_egg_tv_light_flicker(var_0) {
  self endon("entitydeleted");
  self endon("death");
  self endon("failed");
  var_0 endon("tv_light_off");
  var_1 = 1;
  var_2 = 0.65;

  while(isDefined(var_0)) {
    var_0 setlightintensity(var_1);
    wait(randomfloatrange(0.1, 0.5));
    var_0 setlightintensity(var_2);
    wait(randomfloatrange(0.1, 0.2));
  }
}

easter_egg_tv_teddy_monitor_helper(var_0) {
  var_0 endon("damage");
  self waittill("damage");
  self notify("failed");
}

hadir() {
  level.hadir = scripts\engine\sp\utility::spawn_targetname("hadirSpawner", 1);
  level.hadir.animname = "hadir";
  level.hadir.ignoreall = 1;
  level.hadir.ignoreme = 1;
  level.hadir scripts\common\ai::magic_bullet_shield();
  level.hadir scripts\common\ai::gun_remove();
  level.hadir scripts\engine\sp\utility::name_hide();
  level.hadir thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
}

farah() {
  level.farah = scripts\engine\sp\utility::spawn_targetname("farahSpawner", 1);
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_bump_management();
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["reflexstable_west01", "calsmg_akilo47_sp", "barsmg_akilo47", "stocksmg_akilo47"]);
  level.farah scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  level.farah.animname = "farah";
  level.farah.baseaccuracy = 0.75;
  level.farah scripts\common\ai::magic_bullet_shield();
  level.farah thread pain_management();
  level.farah scripts\engine\utility::set_movement_speed(120);
  level.farah scripts\engine\sp\utility::name_hide();
  level.farah scripts\engine\sp\utility::name_show();
  thread farah_glow_stick_attach(0.5);
  level.anim_structs = [];
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_weapon_fire();
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_ai_in_danger();
  level.farah thread scripts\engine\sp\utility::battlechatter_filter_on(["order"]);
  level.farah thread scripts\engine\sp\utility::battlechatter_probability(-25);
}

pain_management() {
  self endon("death");
  var_0 = 0;
  var_1 = 200;
  var_2 = 5;
  var_3 = 5;

  for(;;) {
    var_4 = gettime();
    self waittill("damage", var_5, var_6);

    if(!isDefined(var_6)) {
      wait 0.05;
      continue;
    }

    if(gettime() - var_4 > var_3 * 1000) {
      var_0 = 0;

      if(getdvarint("zd30_debug") > 0) {}
    } else {
      var_0 = var_0 + var_5;

      if(getdvarint("zd30_debug") > 0) {}
    }

    if(var_0 >= var_1) {
      scripts\engine\utility::disable_pain();

      if(getdvarint("zd30_debug") > 0) {}

      wait(var_2);
      scripts\engine\utility::enable_pain();
      var_0 = 0;
    }
  }
}

farah_glow_stick_attach(var_0) {
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
  if(isDefined(var_0))
    wait(var_0);

  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::spawn_stowed_glowstick_on_farah();
}

vo_via_trigger(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\engine\sp\utility::trigger_wait_targetname(var_0);

  if(isDefined(var_3))
    wait(var_3);

  if(isDefined(level.trigger_hint_string) && isDefined(level.trigger_hint_string[var_1]))
    scripts\engine\sp\utility::display_hint(var_1, var_2);
}

vo_via_flag(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_3))
    wait(var_3);

  if(isDefined(level.trigger_hint_string) && isDefined(level.trigger_hint_string[var_1]))
    scripts\engine\sp\utility::display_hint(var_1, var_2);
}

player_fov_think() {
  level.player modifybasefov(level.fov_basement, 0.05);
}

player_tunnel_explosion_experience() {
  var_0 = getEnt("player_dmg_trig", "targetname");
  var_0.origin = level.player.origin;
  var_0 enablelinkTo();
  var_0 linkTo(level.player);
  level.player.exp_trig = var_0;
  var_0 thread player_tunnel_explosion_watch();
}

player_tunnel_explosion_watch() {
  self endon("death");
  self endon("entitydeleted");
  level.player endon("death");
  var_0 = 0.6;
  var_1 = 1;
  var_2 = 350;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(isDefined(var_12) && isDefined(var_12.basename) && var_12.basename == "flash") {
      continue;
    }
    var_17 = "MOD_GRENADE MOD_GRENADE_SPLASH MOD_EXPLOSIVE";

    if(isDefined(var_7) && issubstr(var_17, var_7) && isDefined(var_6)) {
      if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_6) < 2304) {
        continue;
      }
      var_18 = 0;

      if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_6) < 9216) {
        var_18 = 3;
        var_19 = var_1 * 3;
        level.player playRumbleOnEntity("heavy_3s");
        earthquake(var_0, var_19, var_6, var_2);
      } else if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_6) < 16384) {
        var_18 = 2;
        var_19 = var_1 * 3;
        level.player playRumbleOnEntity("heavy_3s");
        earthquake(var_0, var_19, var_6, var_2);
      } else {
        var_18 = 1;
        var_19 = var_1 * 2;
        level.player playRumbleOnEntity("heavy_2s");
        earthquake(var_0, var_19, var_6, var_2);
      }
    }
  }
}

player_ladder_aid() {
  thread player_ladder_ease();
  thread player_ladder_pistol();
}

player_ladder_pistol() {
  for(;;) {
    if(level.player isonladder()) {
      var_0 = undefined;
      var_1 = get_player_pistol_data()[0];
      var_2 = get_player_pistol_data()[1];

      if(isDefined(var_1)) {
        var_3 = weaponclipsize(var_1);
        level.player setweaponammoclip(var_1, var_3);
      } else {
        var_0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
        level.player giveweapon(var_0);
        level.player givemaxammo(var_0);
        var_3 = weaponclipsize(var_0);
        level.player setweaponammoclip(var_0, var_3);
      }

      while(level.player isonladder() || level.player ismeleeing())
        wait 0.05;

      if(isDefined(var_0))
        level.player takeweapon(var_0);
    } else {
      while(!level.player isonladder())
        wait 0.05;
    }

    wait 0.05;
  }
}

get_player_pistol_data() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = level.player getweaponslistall();

  if(!isDefined(var_2) || var_2.size == 0)
    var_1 = undefined;
  else {
    foreach(var_4 in var_2) {
      if(weaponclass(var_4) == "pistol") {
        var_1 = var_4;
        var_0 = level.player getweaponammoclip(var_4);
      }
    }
  }

  return [var_1, var_0];
}

player_ladder_ease() {
  for(;;) {
    if(level.player isonladder())
      level.player scripts\sp\utility::set_player_attacker_accuracy(0.1);
    else
      level.player scripts\sp\utility::set_player_attacker_accuracy(1);

    wait 0.1;
  }
}

player_prone_slide_dirt_fx() {
  var_0 = 1;
  var_1 = 8;
  var_2 = 1;
  var_3 = getEntArray("no_dirt_zone", "targetname");

  for(;;) {
    var_4 = level.player.origin;
    var_5 = gettime();

    while(level.player getstance() != "prone" && !level.player issprintsliding())
      wait 0.05;

    if(isDefined(var_3) && var_3.size > 0) {
      var_6 = sortbydistance(var_3, level.player.origin)[0];

      if(isDefined(var_6) && level.player istouching(var_6)) {
        wait 0.25;
        continue;
      }
    }

    while(level.player getstance() == "prone" || level.player issprintsliding()) {
      if(level.player issprintsliding())
        var_1 = 16;

      var_7 = var_4 != level.player.origin;
      var_8 = var_7 && distance2dsquared(var_4, level.player.origin) > var_1 * var_1;
      var_9 = gettime() - var_5 > var_2 * 1000;

      if(var_8 || var_7 && var_9) {
        var_4 = level.player.origin;
        var_5 = gettime();
        var_10 = level.player.origin;
        var_11 = var_10 + (0, 0, 32);
        var_12 = var_10 - (0, 0, 32);
        var_13 = scripts\engine\trace::_bullet_trace(var_11, var_12, 0, level.player);
        var_14 = 8;
        var_15 = level._effect["vfx_prone_dust"];

        if(var_13["surfacetype"] == "surftype_dirt") {
          var_14 = 8;
          var_15 = level._effect["vfx_prone_dust"];
        } else {
          wait 0.05;
          continue;
        }

        if(level.player issprintsliding())
          var_14 = var_14 * 4;

        var_16 = anglesToForward(level.player.angles);
        var_17 = vectorNormalize(var_16) * var_14;
        var_18 = scripts\engine\utility::drop_to_ground(level.player getEye() + var_17, 32, -48);
        var_19 = scripts\engine\utility::spawn_tag_origin(var_18, level.player.angles);
        playFXOnTag(var_15, var_19, "tag_origin");
        thread stop_prone_slide_vfx(var_0, var_15, var_19);
      }

      wait 0.05;
    }
  }
}

stop_prone_slide_vfx(var_0, var_1, var_2) {
  wait(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  stopFXOnTag(var_1, var_2, "tag_origin");
  wait 0.1;
  var_2 delete();
}

debug_fail_player_prone_dirt_fx(var_0, var_1) {
  if(getdvarint("zd30_debug") > 0) {
    var_0 = 0.25;
    var_2 = anglesToForward(level.player.angles);
    var_2 = vectorNormalize(var_2) * 32;
    var_3 = anglestoleft(level.player.angles);
    var_3 = vectorNormalize(var_3) * 8;
    var_4 = scripts\engine\utility::drop_to_ground(level.player getEye() + var_2 + var_3, 32, -48);
    var_5 = int(var_0 * 20);
  }
}

debug_pass_player_prone_dirt_fx(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("zd30_debug") > 0) {
    var_5 = anglestoleft(level.player.angles);
    var_5 = vectorNormalize(var_5) * var_4;
    var_6 = int(var_0 * 20);
    thread scripts\engine\utility::draw_circle(var_2, var_4, (0.7, 0.7, 0.7), 1, 0, int(var_0 * 20));
    thread scripts\engine\utility::draw_line_for_time(var_2 + var_5, var_2 - var_5, 0.7, 0.7, 0.7, var_0);
    thread scripts\engine\utility::draw_line_for_time(var_2 + var_3, var_2 - var_3, 0.7, 0.7, 0.7, var_0);
    thread scripts\engine\utility::draw_line_for_time(var_2, var_2 + (0, 0, 20), 0.7, 0.7, 0.7, var_0);
  }
}

intro_start() {
  level.player clearclienttriggeraudiozone(1.0);
}

intro_catchup() {
  level.stealth_break_timestamp = 0;
}

main_intro() {
  setdvarifuninitialized("emb_skip_cinematic_hack", "0");
  cinematic_hack();
}

cinematic_hack() {
  if(!getdvarint("zd30_skip_cinematic_hack", 0) && !issaverecentlyloaded()) {
    setomnvar("ui_hide_dpad_hud", 1);
    level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
    setomnvar("ui_hide_weapon_info", 1);
    setomnvar("ui_hide_hud", 1);
    var_0 = scripts\sp\hud_util::create_client_overlay("black", 1);
    thread scripts\sp\art::dof_enable_script(0, 100, 150, 100, 3000, 50, 0);
    level.player setclienttriggeraudiozone("bink_fadeout_amb", 0.5);
    scripts\sp\endmission::level_settle_time_wait();
    var_0 destroy();
    cinematicingame("sp_zd30_mbi_standalone");
    var_1 = 25000;
    level.player freezecontrols(1);
    var_2 = cinematicgettimeinmsec();

    while(var_2 <= var_1) {
      var_2 = cinematicgettimeinmsec();
      wait 0.05;
    }

    level.player clearclienttriggeraudiozone(3.0);
    thread scripts\sp\art::dof_disable_script(1.0);
    level.player freezecontrols(0);
  }
}

lb_infil_start() {
  scripts\sp\hud_util::fade_out(0);
}

main_lb_infil() {
  level.player setclienttriggeraudiozone("fade_to_black", 0.05);
  level.player lerpfovscalefactor(0, 0);
  thread cine_letterboxing_intro();
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("intro");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::heli_intro_anim();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::heli_ride_intro_extras();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_tea_room();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::flashbang_watcher();
  var_0 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_off(var_0);
  scripts\engine\sp\utility::array_spawn_targetname("infil_caged_dog");
  scripts\sp\player::player_movement_state("cqb");
  wait 0.1;
  level.player setclienttriggeraudiozone("zdt_infil", 0.5);
  scripts\engine\utility::flag_wait("lb_landed");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  thread scripts\engine\sp\utility::autosave_now();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::infil_spawn_building1_runner();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::nag_enter_b1();
  scripts\engine\utility::flag_wait("sledge_ready");
}

cine_letterboxing_intro() {
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level waittill("cine_letterboxing");
  getrandomnodedestination(1.5, 0);
  level.player clearcinematicmotionoverride();
}

lb_infil_catchup() {
  if(!scripts\sp\starts::is_after_start("tea_room")) {
    scripts\sp\player::player_movement_state("default");
    level.player modifybasefov(55, 0.05);
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::flashbang_watcher();
  }

  if(!scripts\sp\starts::is_after_start("downstairs"))
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_tea_room();
  else if(!scripts\sp\starts::is_after_start("basement"))
    scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::tea_room_change("after", 0);
}

lb_unload_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::array_spawn_targetname("infil_caged_dog");
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  var_1 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1, [level.price]);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::getStruct("unload_" + var_4.animname, "targetname");
    var_4 teleport(var_5.origin, var_5.angles);
  }

  var_7 = [level.alpha5, level.alpha6, level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4];
  var_7 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::allies_nvg_on(1);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::infil_spawn_building1_runner();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_alpha_breach_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_alpha_sledge_team();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_bravo_roof();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::b1_door_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::nag_enter_b1();
  level.alpha6 attach("misc_wm_sledgehammer_scaled", "tag_accessory_right");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::overwatch_setup();
  var_8 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_off(var_8);
  scripts\engine\sp\utility::set_start_location("lb_unload", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("clear_building");
}

main_lb_unload() {
  level.player clearclienttriggeraudiozone(2);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::b1_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::b1_flashbang_watcher();
  scripts\engine\utility::flag_wait("moveup_building1");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::teleport_bravo_midway();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::breach_gate_nag("breach_gate_nag_end");
  var_0 = cos(35);

  for(;;) {
    var_1 = scripts\engine\utility::getStruct("breach_gate", "targetname");
    var_2 = distance(level.player.origin, var_1.origin);

    if(var_2 < 540) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, var_0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_1.origin, [level.player])) {
        break;
      } else if(var_2 < 455) {
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

lb_unload_catchup() {
  scripts\engine\utility::flag_set("player_in_1st_building");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::b1_open_door();
}

breached_gate_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::array_spawn_targetname("infil_caged_dog");
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  var_1 = scripts\engine\utility::getStruct("unload_overwatch", "targetname");
  level.overwatch teleport(var_1.origin, var_1.angles);
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::overwatch_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::teleport_bravo_midway();

  foreach(var_3 in var_0) {
    var_1 = scripts\engine\utility::getStruct("unload_" + var_3.animname, "targetname");
    var_3 teleport(var_1.origin, var_1.angles);

    if(var_3.animname == "alpha5") {
      var_3 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      continue;
    }

    if(var_3.animname == "alpha6")
      var_3 setgoalnode(getnode("alpha6_b1_node", "targetname"));
  }

  var_5 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_off(var_5);
  scripts\engine\sp\utility::set_start_location("breached_gate", [level.player]);
  var_6 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_alpha_breach_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::breach_gate();
  var_6 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::allies_nvg_on(1);
}

main_breached_gate() {
  thread start_midway_guys();
  scripts\engine\utility::flag_wait("breach_finished");
  setsaveddvar("MMLNNQSTTL", "0");
  level.maindoor = getscriptablearray("compound_door", "targetname");
  level.maindoor[0] thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::maindoor_damage_watcher();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::alpha_moveup_post_breach();
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_1 = [level.alpha2, level.alpha3, level.alpha4];

  foreach(var_3 in var_1) {
    var_3 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::moveto_compound(var_0);
    var_3 scripts\common\ai::poi_enable(1, scripts\engine\utility::getStruct("yard_poi_" + var_3.animname, "targetname"));
  }

  scripts\engine\utility::flag_wait_all("price_approach_finished", "bravo4_approach_finished", "bravo5_approach_finished");
  scripts\engine\utility::flag_wait("set_yard_targets");
  var_1 = [level.price, level.bravo4, level.bravo5, level.bravo1, level.bravo2];

  foreach(var_3 in var_1) {
    var_3 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::moveto_compound(var_0);

    if(var_3.animname != "bravo5")
      var_3 scripts\common\ai::poi_enable(1, scripts\engine\utility::getStruct("yard_poi_" + var_3.animname, "targetname"));
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_1f_main_door(var_0);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_1f_side_door(var_0);
}

start_midway_guys() {
  scripts\engine\utility::flag_wait("breach_explosion");
  var_0 = [level.price, level.bravo4, level.bravo5];

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::moveto_midway();
}

breached_gate_catchup() {}

comp_1f_start() {
  level.player clearclienttriggeraudiozone(1.0);
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  var_1 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1, [level.price]);

  foreach(var_4 in var_2) {
    if(var_4.animname == "overwatch" || var_4.animname == "alpha5" || var_4.animname == "alpha6") {
      var_5 = scripts\engine\utility::getStruct("unload_" + var_4.animname, "targetname");
      var_4 teleport(var_5.origin, var_5.angles);

      if(var_4.animname == "alpha5")
        var_4 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      else if(var_4.animname == "alpha6")
        var_4 setgoalnode(getnode("alpha6_b1_node", "targetname"));

      continue;
    }

    if(var_4.animname == "alpha3" || var_4.animname == "alpha4") {
      var_5 = scripts\engine\utility::getStruct("comp_1f_" + var_4.animname, "targetname");
      var_4 teleport(var_5.origin, var_5.angles);
      var_4 scripts\engine\sp\utility::set_goal_node_targetname(var_5.target);
      continue;
    }

    var_5 = scripts\engine\utility::getStruct("comp_1f_" + var_4.animname, "targetname");
    var_4 teleport(var_5.origin, var_5.angles);
  }

  var_7 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::overwatch_setup();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_1f_side_door_arrival();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_1f_side_door(var_7);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_1f_main_door_arrival();
  var_8 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var_8 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::allies_nvg_on(1);
  var_9 = ["compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_off(var_9);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_main_door_jumpto_damage();
  scripts\engine\sp\utility::set_start_location("comp_1f", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("reach_main_house");
}

main_comp_1f() {
  level thread audio_thread_lever();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::side_breach_1f_vo();
  scripts\engine\utility::flag_wait("player_in_1f_back_room");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::clip_delete("1f_backtrack_safety_clip", "power_is_off");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::power_interact();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::waittill_player_looks_at_hallway(var_0);
  scripts\engine\utility::flag_wait("player_back_in_hallway");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::moveup_1f_hallway(var_0);
  level.bravo4 scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::moveto_unbreachable_door(var_0);
  var_1 = ["dx_vom_b63_1st_floor_power_60", "dx_vom_b63_1st_floor_power_70"];

  if(!scripts\engine\utility::flag("power_is_off"))
    level.bravo4 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::notetrack_nag(var_1, "power_is_off");

  var_0 thread scripts\common\anim::anim_loop_solo_with_nags(level.bravo4, "1f_hallway_idle", "stop_loop_hallway");
  scripts\engine\utility::flag_wait("power_is_off");
  var_2 = [level.bravo5];
  var_2 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::allies_nvg_on(1);
  scripts\engine\utility::delaythread(1, scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control, "2f_stairs");
  level.price scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_2f_price(var_0);
  var_3 = scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_door_setup("1f_hallway_door");
  var_3[0] scripts\engine\sp\utility::assign_animtree("hallway_door");
  var_2 = [level.price, level.bravo4, level.bravo2];
  var_0 notify("stop_loop_hallway");
  var_0 notify("stop_first_frame");
  var_3[0] thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::open_1f_hallway_door(var_0);
  var_0 scripts\common\anim::anim_single(var_2, "1f_hallway_open");
  var_1 = ["dx_vom_pri_2nd_floor_stairs_32", "dx_vom_pri_1st_floor_stairs_20", "dx_vom_b63_1st_floor_stairs_30"];
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::notetrack_nag(var_1, "stairs_2f_nag_end");
  var_0 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "1f_hallway_open_idle", "ready_2f_ascend");
  var_0 thread scripts\common\anim::anim_loop_solo(level.bravo4, "1f_hallway_open_idle", "stop_loop_1f_hallway_open");
  var_0 thread scripts\common\anim::anim_loop_solo(level.bravo2, "1f_hallway_open_idle", "stop_loop_cleanup");
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::stairtrain_1f();
}

comp_1f_catchup() {
  if(!scripts\sp\starts::is_after_start("basement")) {
    scripts\sp\player::player_movement_state("creep");
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::force_open_doors("1f_runner_door");
  }

  scripts\engine\utility::flag_set("1f_runner_start");
}

comp_2f_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::overwatch_setup();
  var_0 = scripts\engine\utility::getStruct("unload_" + level.overwatch.animname, "targetname");
  level.overwatch teleport(var_0.origin, var_0.angles);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::open_main_door();
  var_1 = scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_door_setup("1f_hallway_door");
  var_1[0] scripts\engine\sp\utility::assign_animtree("hallway_door");
  var_2 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_2 scripts\common\anim::anim_last_frame_solo(var_1[0], "1f_hallway_open");
  var_3 = ["dx_vom_pri_2nd_floor_stairs_32", "dx_vom_pri_1st_floor_stairs_20", "dx_vom_b63_1st_floor_stairs_30"];
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::notetrack_nag(var_3, "stairs_2f_nag_end");
  var_2 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "1f_hallway_open_idle", "ready_2f_ascend");
  var_2 thread scripts\common\anim::anim_loop_solo(level.bravo4, "1f_hallway_open_idle", "stop_loop_1f_hallway_open");
  var_2 thread scripts\common\anim::anim_loop_solo(level.bravo2, "1f_hallway_open_idle", "stop_loop_cleanup");
  var_4 = [level.alpha5, level.alpha6];

  foreach(var_6 in var_4) {
    var_0 = scripts\engine\utility::getStruct("unload_" + var_6.animname, "targetname");
    var_6 teleport(var_0.origin, var_0.angles);

    if(var_6.animname == "alpha5") {
      var_6 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      continue;
    }

    if(var_6.animname == "alpha6")
      var_6 setgoalnode(getnode("alpha6_b1_node", "targetname"));
  }

  var_8 = getnode("1f_guard_civs", "targetname");
  level.bravo5 forceteleport(var_8.origin, var_8.angles);
  level.bravo5 setgoalnode(var_8);
  level.price thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::stairtrain_1f();
  level.bravo1 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_2f_bravo1(var_2);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_1f_civ_jumpto();
  var_4 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var_4 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::allies_nvg_on(1);
  var_3 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_off(var_3);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::start_point_nvg_on_hint();
  scripts\engine\sp\utility::set_start_location("comp_2f", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("2f_stairs");
}

main_comp_2f() {
  scripts\engine\utility::flag_wait("player_at_2f_stairs");
  level.player scripts\engine\utility::delaythread(5, scripts\engine\sp\utility::set_player_demeanor, "normal");
  level.dataciv = scripts\engine\sp\utility::spawn_script_noteworthy("2f_data_room_civ");
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");
  var_0 = scripts\engine\utility::array_add(level.dataenemies, level.dataciv);
  var_0 scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_2f_data_enemies();
  var_1 = scripts\sp\door::double_doors_init_targetname("2f_data_door");
  var_1[0] scripts\sp\door::remove_open_prompts();
  var_1 scripts\engine\utility::array_thread(var_1, scripts\game\sp\door::remove_door_snake_cam_ability);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_2f_stairs_vo();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_2f_bedroom();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  thread add_clip();
  scripts\engine\utility::flag_wait_any("player_in_2f_hallway", "price_kick_in_door");
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("locate_wolf2");

  if(scripts\engine\utility::flag("price_kick_in_door")) {
    var_2 = gettime() + 1200;

    for(;;) {
      if(scripts\engine\utility::flag("player_in_2f_hallway")) {
        break;
      } else if(gettime() >= var_2) {
        break;
      }

      waitframe();
    }
  }

  var_3 = scripts\engine\utility::getStruct("2f_hallway_struct", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("player_midway_in_2f_hallway")) {
      break;
    } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, cos(20)) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_3.origin, [level.player])) {
      break;
    }

    waitframe();
  }

  scripts\engine\sp\utility::array_spawn_noteworthy("2f_enemies");
  scripts\engine\utility::flag_wait("player_in_2f_hallway");
  var_4 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_4 notify("stop_loop_1f_hallway_open");
  level.bravo4 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::bravo4_movements();
  scripts\engine\utility::flag_wait("3f_ready");
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("3f_stairs");
}

add_clip() {
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::clip_delete("2f_stairs_up_clip", "3f_ready");
  scripts\engine\utility::flag_wait("player_in_2f_hallway");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::clip_delete("2f_stairs_down_clip", "3f_scene_done");
}

comp_2f_catchup() {
  if(!scripts\sp\starts::is_after_start("basement")) {
    var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
    var_1 = scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_door_setup("1f_hallway_door");
    var_1[0] scripts\engine\sp\utility::assign_animtree("hallway_door");
    var_0 scripts\common\anim::anim_last_frame_solo(var_1[0], "1f_hallway_open");
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::force_open_doors("2f_data_door", "2f_hallway_door", "2f_runner_door");
  }
}

comp_3f_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  level.overwatch thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::overwatch_setup();
  var_0 = scripts\engine\utility::getStruct("unload_" + level.overwatch.animname, "targetname");
  level.overwatch teleport(var_0.origin, var_0.angles);
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(level.bravo2, "1f_hallway_open_idle", "stop_loop_cleanup");
  var_2 = scripts\engine\utility::getStruct("2f_animnode", "targetname");
  var_2 thread scripts\common\anim::anim_loop_solo(level.price, "2f_data_scene_idle", "stop_loop_cleanup");
  var_1 = scripts\engine\utility::getStruct("temp_2f_animnode2", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(level.bravo4, "2f_hallway_post_idle", "stop_loop_cleanup");
  var_1 = scripts\engine\utility::getStruct("3f_animnode", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(level.bravo1, "3f_stairs_intro", "stop_3f_stairs");
  var_3 = [level.alpha5, level.alpha6];

  foreach(var_5 in var_3) {
    var_0 = scripts\engine\utility::getStruct("unload_" + var_5.animname, "targetname");
    var_5 teleport(var_0.origin, var_0.angles);

    if(var_5.animname == "alpha5") {
      var_5 setgoalnode(getnode("alpha5_b1_node", "targetname"));
      continue;
    }

    if(var_5.animname == "alpha6")
      var_5 setgoalnode(getnode("alpha6_b1_node", "targetname"));
  }

  var_7 = getnode("1f_guard_civs", "targetname");
  level.bravo5 forceteleport(var_7.origin, var_7.angles);
  level.bravo5 setgoalnode(var_7);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::open_main_door();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_1f_civ_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_civ_jumpto();
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");

  foreach(var_5 in level.dataenemies)
  var_2 scripts\common\anim::anim_last_frame_solo(var_5, "2f_data_scene");

  var_3 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var_3 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::allies_nvg_on(1);
  var_10 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_off(var_10);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::start_point_nvg_on_hint();
  scripts\engine\sp\utility::set_start_location("comp_3f", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("3f_stairs");
}

main_comp_3f() {
  var_0 = scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::balcony_3f_door();
  var_1 = scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::bedroom_3f_door();
  scripts\engine\utility::flag_wait("player_at_3f_stairs");
  var_2 = scripts\engine\utility::getStruct("3f_animnode", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_3f_scene(var_2);
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.bravo1 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::stairtrain_2f(var_2);
  scripts\engine\utility::flag_wait("player_in_3f_hallway");
  thread scripts\engine\sp\utility::autosave_now();
  scripts\engine\utility::flag_wait("3f_scene_done");
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("downstairs");
  var_2 notify("stop_last_frame");
}

comp_3f_catchup() {
  if(!scripts\sp\starts::is_after_start("downstairs")) {
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::force_open_doors("3f_bedroom_door");
    level.heli_charlie = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("heli_charlie");
    level.heli_charlie.animname = "heli_charlie_end";
    level.heli_charlie scripts\engine\sp\utility::assign_animtree("heli_charlie_end");
    level.heli_charlie thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::charlie_heli_lights();
    scripts\common\vehicle_build::build_treadfx("script_vehicle_iw8_lbravo_carrier", "default", "vfx/code/tread/heli_dust_default.vfx");
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_gear_alex();
  } else if(!scripts\sp\starts::is_after_start("tea_room"))
    thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_gear_alex();
}

downstairs_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::open_main_door();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_1f_civ_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_civ_jumpto();
  var_0 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_on(var_0);
  scripts\engine\sp\utility::set_start_location("start_downstairs", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("downstairs");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
}

main_downstairs() {
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_downstairs_pillage();
}

cleanup_compound_ents() {
  var_0 = gettime();
  var_1 = 0;
  waitframe();
  var_2 = scripts\engine\utility::array_combine(level.cleanup, level.civs, level.charlie);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isai(var_4) && isalive(var_4)) {
      var_4 scripts\engine\sp\utility::anim_stopanimScripted();

      if(istrue(var_4.magic_bullet_shield))
        var_4 scripts\common\ai::stop_magic_bullet_shield();

      var_4 kill();
    }

    var_4 delete();
    var_1++;
  }

  if(isDefined(level.kyledrone))
    level.kyledrone delete();

  if(isDefined(level.interactive_doors) && isDefined(level.interactive_doors.ents)) {
    foreach(var_4 in level.interactive_doors.ents) {
      if(isDefined(var_4.clip)) {
        var_1++;
        var_4.clip delete();
      }
    }
  }

  var_8 = getEntArray("trigger_multiple_flag_set", "classname");
  var_9 = getEntArray("trigger_multiple", "classname");
  var_10 = scripts\engine\utility::array_combine(var_8, var_9);

  foreach(var_4 in var_10) {
    if(!isDefined(var_4) || !isDefined(var_4.origin) || var_4.origin == (0, 0, 0)) {
      continue;
    }
    if(var_4.origin[0] > -800) {
      var_4 delete();
      var_1++;
    }
  }

  var_13 = gettime() - var_0;
  scripts\engine\utility::delaythread(5, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print, "^1Cleaned up " + var_1 + " entities in " + var_13 + "ms");
}

downstairs_catchup() {}

tea_room_start() {
  level.player clearclienttriggeraudiozone(1.0);
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  scripts\engine\sp\utility::array_spawn_noteworthy("charlie");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::setup_kyledrone(var_0);
  level.revealrope = scripts\engine\sp\utility::spawn_anim_model("reveal_rope");
  var_1 = scripts\engine\utility::array_combine([level.price, level.revealrope], level.charlie);

  foreach(var_3 in var_1) {
    if(isDefined(level.scr_anim[var_3.animname]["landing_idle"])) {
      var_0 thread scripts\common\anim::anim_loop_solo(var_3, "landing_idle", "stop_landing_charlie");
      continue;
    }

    if(isDefined(var_3.magic_bullet_shield))
      var_3 scripts\common\ai::stop_magic_bullet_shield();

    var_3 delete();
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::open_main_door();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_extras(scripts\engine\utility::getStruct("2f_animnode", "targetname"));
  level.dataenemies = scripts\engine\sp\utility::array_spawn_noteworthy("2f_data_room");
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_1f_civ_jumpto();
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::spawn_2f_civ_jumpto();
  var_5 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::compound_lights_on(var_5);
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("lift_trap_door");
  scripts\engine\sp\utility::set_start_location("tea_room", [level.player]);
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::trap_door_plywood(var_0);
}

main_tea_room() {
  thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::trap_door_scene();
  level waittill("tunnels_transition");
  visionsetnaked("zd30tunnels_upper", 0.5);
  setsaveddvar("MMLNNQSTTL", 15);
  thread cleanup_compound_ents();
  setomnvar("ai_fulllight", 0.0000001);
  setomnvar("ai_nolight", 0.02);
}

tea_room_catchup() {
  setomnvar("ai_fulllight", 0.0000001);
  setomnvar("ai_nolight", 0.02);
  scripts\sp\player_rig::get_player_rig();
  thread cleanup_compound_ents();
}

main_basement() {
  scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement();
}

main_basement_tunnel() {
  scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::basement_tunnel();
}

main_collapse() {
  scripts\sp\maps\tunnels\zd30tunnels_basement.gsc::collapse();
}

main_storage() {
  scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage();
}

main_storage_oil() {
  scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_oil();
}

main_storage_split() {
  scripts\sp\maps\tunnels\zd30tunnels_storage.gsc::storage_split();
}

main_mine() {
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::mine();
}

main_shaft() {
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::shaft();
}

main_reunion() {
  scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::reunion();
}

main_wolf() {
  scripts\sp\maps\tunnels\zd30tunnels_wolf.gsc::wolf();
  level waittill("godot");
}

coldopen_bink_start() {
  scripts\engine\sp\utility::set_start_location("start_coldopen_bink", [level.player]);
}

coldopen_bink_catchup() {}

main_coldopen_bink() {
  thread coldopen_bink_move_scene();
  level waittill("godot");
}

coldopen_bink_move_scene() {
  var_0 = getEnt("1f_hallway_door", "targetname");
  var_0 delete();
  var_1 = getEnt("1f_hallway_door_clip", "targetname");
  var_1 delete();
  var_2 = getEntArray("player_movement_clip", "script_noteworthy");

  foreach(var_4 in var_2)
  var_4 scripts\engine\sp\utility::hide_entity();

  scripts\engine\utility::flag_wait("scriptables_ready");
  scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::power_down_electronics();
  var_6 = getEnt("coldopen_bink_anim_node", "script_noteworthy");
  level.node = var_6 scripts\engine\utility::spawn_script_origin();
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
  var_7 = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.node.origin, level.node.angles);
  level.player playerlinktoabsolute(var_7, "tag_player");
  level.player hideviewmodel();
  var_7 hide();
  var_6.origin = level.node.origin;
  var_6.angles = level.node.angles;
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
  level.node scripts\common\anim::anim_first_frame_solo(var_7, "coldopen_bink");
  wait 2.0;
  thread co_cine_dof();
  thread wolf_scene_lights(level.node, var_6);
  thread co_wolf_mayhem();
  thread co_butcher_mayhem();
  level.node thread scripts\common\anim::anim_single_solo(level.wolf, "coldopen_bink");
  level.node thread scripts\common\anim::anim_single_solo(level.butcher, "coldopen_bink");
  level.node scripts\common\anim::anim_single_solo(var_7, "coldopen_bink");
  level.node thread scripts\common\anim::anim_last_frame_solo(level.wolf, "coldopen_bink");
  level.node thread scripts\common\anim::anim_last_frame_solo(level.butcher, "coldopen_bink");
  level.node thread scripts\common\anim::anim_last_frame_solo(var_7, "coldopen_bink");
}

co_cine_dof() {
  level.wolf scripts\engine\sp\utility::dof_enable_autofocus(2.8, 100, undefined, undefined, "tag_eye");
}

move_scene(var_0) {
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
  level.wolf forceteleport(var_0.origin, var_0.angles, 10000);
  level.wolf linkTo(var_0);

  for(;;) {
    var_1 = level.player.origin + anglesToForward(level.player.angles) * 60;
    var_2 = level.player.angles + (0, 180, 0);
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 scripts\common\anim::anim_first_frame_solo(level.wolf, "coldopen_bink");
    waitframe();
  }
}

stop_move_scene() {
  var_0 = 0;

  for(;;) {
    if(level.player adsButtonPressed()) {
      var_0++;

      if(var_0 == 10) {
        break;
      }
    } else
      var_0 = 0;

    waitframe();
  }

  level.player playRumbleOnEntity("damage_heavy");
  level notify("picked_spot");
}

wolf_scene_lights(var_0, var_1) {
  level.wolf_scene_light_key = getEnt("wolf_light_key", "script_noteworthy");
  level.wolf_scene_light_key setlightintensity(0.0);
  level.wolf_scene_light_rim = getEnt("wolf_light_rim", "script_noteworthy");
  level.wolf_scene_light_rim setlightintensity(0.0);
  level.wolf_scene_light_rim_lf = getEnt("wolf_light_rim_lf", "script_noteworthy");
  level.wolf_scene_light_rim_lf setlightintensity(0.0);
  level.wolf_scene_light_fill = getEnt("wolf_light_fill", "script_noteworthy");
  level.wolf_scene_light_fill setlightintensity(0.0);
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

#using_animtree("generic_human");

co_wolf_mayhem() {
  level.wolf detach(level.wolf.headmodel);
  level.wolf setanim(%co_wolf_video_wolf_face, 1.0, 0.0, 1.0);
  level waittill("wolf_mayhem_end");
  level.wolf setanim(%co_wolf_video_wolf_face, 0.0, 0.0, 1.0);
  level.wolf attach(level.wolf.headmodel);
}

co_butcher_mayhem() {
  level.butcher detach(level.butcher.headmodel);
  level.butcher setanim(%co_wolf_video_butcher_face, 1.0, 0.0, 1.0);
  level waittill("butcher_mayhem_end");
  level.butcher setanim(%co_wolf_video_butcher_face, 0.0, 0.0, 1.0);
  level.butcher attach(level.butcher.headmodel);
}

audio_thread_lever() {
  var_0 = spawn("script_origin", (446.525, 1042.04, 192.998));
  var_1 = getEnt("main_door_trigger", "targetname");
  var_1 waittill("trigger", var_2);
  var_0 playLoopSound("emt_scripted_light_hum_lp");
  scripts\engine\utility::flag_wait("power_is_off");
  wait 1.0;
  var_0 stoploopsound();
  wait 0.1;
  var_0 delete();
}