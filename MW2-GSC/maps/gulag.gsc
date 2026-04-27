/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\gulag.gsc
********************************************************/

#include maps\_utility;
#include maps\_riotshield;
#include maps\_vehicle;
#include maps\_vehicle_spline;
#include maps\_anim;
#include maps\_hud_util;
#include common_scripts\utility;
#include maps\gulag_code;

main() {
  SetSavedDvar("com_cinematicEndInWhite", 1);

  gulag_destructible_volumes = getEntArray("gulag_destructible_volume", "targetname");
  mask_destructibles_in_volumes(gulag_destructible_volumes);
  mask_interactives_in_volumes(gulag_destructible_volumes);

  level.default_goalheight = 128;
  create_dvar("f15", 1);
  SetSavedDvar("g_friendlyNameDist", 0);
  SetSavedDvar("r_spotLightMaxLength", 900);

  maps\createfx\gulag_audio::main();

  precachestring(&"GULAG_HOLD_1_TO_SPIE");
  precachestring(&"GULAG_HOLD_1_TO_RAPPEL");
  precachestring(&"SCRIPT_LEARN_GRENADE_LAUNCHER");
  precachestring(&"SCRIPT_NIGHTVISION_USE");
  precachestring(&"SCRIPT_NIGHTVISION_STOP_USE");
  precachestring(&"GULAG_HINT_MELEE");
  precachestring(&"GULAG_INTROSCREEN_LINE_4");
  precachestring(&"GULAG_INTROSCREEN_LINE_3");
  precachestring(&"GULAG_INTROSCREEN_LINE_2");
  precachestring(&"GULAG_INTROSCREEN_LINE_1");
  precachestring(&"AUTOSAVE_AUTOSAVE");
  precachestring(&"GULAG_INTROSCREEN_1");
  precachestring(&"GULAG_INTROSCREEN_2");
  precachestring(&"GULAG_INTROSCREEN_3");
  precachestring(&"GULAG_INTROSCREEN_4");
  precachestring(&"GULAG_INTROSCREEN_5");
  precachestring(&"GULAG_FIND_POW");
  precachestring(&"GULAG_FOLLOW_SOAP");
  precachestring(&"GULAG_CONTROL_ROOM");
  precachestring(&"GULAG_CELL_DUTY");
  precachestring(&"GULAG_BREACH_THE_BATHROOM");
  precachestring(&"GULAG_ESCAPE");
  precachestring(&"GULAG_INTROSCREEN_LINE_1");

  add_start("intro", ::start_empty, "Intro", ::gulag_flyin);
  add_start("approach", ::start_approach, "Approach", ::gulag_approach);
  add_start("f15", ::start_f15, "f15", ::gulag_perimeter);
  add_start("unload", ::start_f15, "Unload", ::gulag_perimeter);
  add_start("control_room", ::start_control_room, "Control Room", ::gulag_cellblocks);
  add_start("armory", ::start_armory, "Armory", ::gulag_armory);
  add_start("rappel", ::start_rappel, "Rappel", ::gulag_rappel);
  add_start("tunnel", ::start_tunnel, "tunnel", ::gulag_tunnel);
  add_start("bathroom", ::start_bathroom, "Bathroom", ::gulag_bathroom);
  add_start("rescue", ::start_rescue, "Rescue", ::gulag_rescue);

  falling_rib_chunks = getEntArray("falling_rib_chunk", "targetname");
  array_thread(falling_rib_chunks, ::self_delete);
  top_hall_exploders = getEntArray("top_hall_exploder", "targetname");
  array_thread(top_hall_exploders, ::self_delete);
  top_hall_chunks = getEntArray("top_hall_chunk", "targetname");
  array_thread(top_hall_chunks, ::self_delete);
  top_hall_chunks = getEntArray("top_hall_chunk", "targetname");
  array_thread(top_hall_chunks, ::self_delete);

  level.disable_interactive_tv_use_triggers = true;

  level.custom_no_game_setupFunc = ::gulag_no_game_start_setupFunc;
  level.slowmo_viewhands = "viewhands_player_udt";

  maps\_drone_ai::init();
  maps\gulag_precache::main();
  maps\createart\gulag_fog::main();
  maps\gulag_fx::main();
  thread maps\gulag_ending::endlog_common();

  maps\_load::main();
  maps\_compass::setupMiniMap("compass_map_gulag");

  thread pa_system();

  maps\_slowmo_breach::slowmo_breach_init();
  level._effect["breach_door"] = LoadFX("explosions/breach_wall_concrete");

  maps\gulag_anim::gulag_anim();
  maps\_nightvision::main(level.players);
  level.player SetActionSlot(1, "");

  add_global_spawn_function("allies", ::no_grenades);

  run_thread_on_targetname("helper_model", ::self_delete);

  add_hint_string("grenade_launcher", &"SCRIPT_LEARN_GRENADE_LAUNCHER", ::should_break_m203_hint);

  add_hint_string("nvg", &"SCRIPT_NIGHTVISION_USE", maps\_nightvision::ShouldBreakNVGHintPrint);

  add_hint_string("disable_nvg", &"SCRIPT_NIGHTVISION_STOP_USE", maps\_nightvision::should_break_disable_nvg_print);

  level.rioter_threat = 1000;
  level._pipe_fx_time = 2.5;

  flag_init("intro_helis_go");
  flag_init("stop_tv_loop");
  flag_init("f15s_spawn");
  flag_init("anti_air_missiles_fire");
  flag_init("aa_hit");
  flag_init("f15s_attack");
  flag_init("player_heli_uses_modified_yaw");
  flag_init("intro_helis_spawned");
  flag_init("player_lands");
  flag_init("a_heli_landed");
  flag_init("overlook_cleared_with_safe_time");
  flag_init("start_armory_music");

  flag_init("spotlight_turns_on");
  flag_init("cell_door2");
  flag_init("cell_door3");
  flag_init("cell_door4");
  flag_init("cell_door_weapons");
  flag_init("access_control_room");
  flag_init("going_in_hot");
  flag_init("armory_attack_sounds");
  flag_init("gulag_cell_doors_enabled");
  flag_init("player_exited_bathroom");
  flag_init("player_rappels_from_bathroom");
  flag_init("rope_drops_now");
  flag_init("cell_duty");
  flag_init("cellblock_player_starts_rappel");
  flag_init("bathroom_second_wave_trigger");
  flag_init("soap_snipes_tower");
  flag_init("slamraam_gets_players_attention");
  flag_init("slamraam_killed_2");
  flag_init("stop_rotating_around_gulag");
  flag_init("player_goes_in_for_landing");
  flag_init("enable_endlog_fx");
  flag_init("escape_the_gulag");
  flag_init("friendlies_use_riotshield");
  flag_init("checking_to_sweep_cells");
  flag_init("lets_sweep_the_nvg_cells");
  flag_init("soap_finishes_talking_about_going_in");
  flag_init("nvg_moveup2");
  flag_init("nvg_moveup3");
  flag_init("nvg_moveup4");

  flag_init("gulag_perimeter");
  flag_init("pre_boats_attack");
  flag_init("clear_dof");
  flag_init("player_heli_backs_up");
  flag_init("stop_shooting_right_side");
  flag_set("player_can_rappel");
  flag_init("background_explosion");
  flag_init("ghost_goes_to_laptop");
  flag_init("ghost_uses_laptop");

  thread setup_celldoor("cell_door2");
  thread setup_celldoor("cell_door3");
  thread setup_celldoor("cell_door4");
  thread setup_celldoor("cell_door_weapons");

  PreCacheItem("smoke_grenade_american");
  PreCacheItem("armory_grenade");
  PreCacheItem("m4m203_reflex_arctic");
  PreCacheItem("f15_sam");
  PreCacheItem("sam");
  PreCacheItem("slamraam_missile");
  PreCacheItem("slamraam_missile_guided");
  PreCacheItem("stinger");
  PreCacheItem("cobra_seeker");
  PreCacheItem("rpg_straight");
  PreCacheItem("cobra_Sidewinder");
  PreCacheItem("m14_scoped_arctic");
  PreCacheItem("claymore");
  PreCacheItem("mp5_silencer_reflex");
  PreCacheTurret("heli_spotlight");
  PreCacheTurret("player_view_controller");

  PreCacheItem("fraggrenade");
  PreCacheItem("flash_grenade");
  PreCacheItem("claymore");

  PreCacheModel("viewhands_player_udt");
  PreCacheModel("viewhands_udt");

  PreCacheModel("com_emergencylightcase_blue");
  PreCacheModel("gulag_price_ak47");
  PreCacheModel("com_emergencylightcase");
  PreCacheModel("com_emergencylightcase_blue_off");
  PreCacheModel("com_drop_rope_obj");
  PreCacheModel("com_blackhawk_spotlight_on_mg_setup");
  PreCacheModel("com_blackhawk_spotlight_on_mg_setup_3x");
  PreCacheModel("vehicle_slamraam_launcher_no_spike");
  PreCacheModel("vehicle_slamraam_missiles");
  PreCacheModel("projectile_slamraam_missile");
  PreCacheModel("tag_turret");
  PreCacheModel("me_lightfluohang_double_destroyed");
  PreCacheModel("me_lightfluohang_single_destroyed");
  PreCacheModel("ma_flatscreen_tv_wallmount_broken_01");
  PreCacheModel("ma_flatscreen_tv_wallmount_broken_02");
  PreCacheModel("com_tv2_d");
  PreCacheModel("com_tv1");
  PreCacheModel("com_tv2");
  PreCacheModel("com_tv1_testpattern");
  PreCacheModel("com_tv2_testpattern");
  PreCacheModel("com_locker_double_destroyed");
  PreCacheModel("ch_street_wall_light_01_off");
  PreCacheModel("dt_mirror_dam");
  PreCacheModel("dt_mirror_des");
  PreCacheModel("tag_laser");

  LoadFX("explosions/tv_flatscreen_explosion");
  LoadFX("misc/light_fluorescent_single_blowout_runner");
  LoadFX("misc/light_fluorescent_blowout_runner");
  LoadFX("props/locker_double_des_01_left");
  LoadFX("props/locker_double_des_02_right");
  LoadFX("props/locker_double_des_03_both");
  LoadFX("misc/no_effect");
  LoadFX("misc/light_blowout_swinging_runner");
  LoadFX("props/mirror_dt_panel_broken");
  LoadFX("props/mirror_shatter");
  PreCacheShellShock("gulag_attack");
  PreCacheShellShock("nosound");

  level.breakables_fx["tv_explode"] = LoadFX("explosions/tv_explosion");

  thread so_remove_weapon_tarp();

  thread handle_gulag_world_fx();

  level thread maps\gulag_amb::main();
  thread player_riotshield_threatbias();

  level thread init_tv_movies();

  thread modify_sm_samplesize_on_flyin();

  level.tarp_guys = [];
  tarp_pull_orgs = getEntArray("tarp_pull_org", "targetname");
  array_thread(tarp_pull_orgs, ::tarp_pull_org_think);

  player_start = getstruct("start_approach", "script_noteworthy");
  friendly_starts = getStructArray("start_approach_friendly", "script_noteworthy");
  friendly_starts["p"] = player_start;

  thread blow_up_first_tower_soon();

  thread remove_rpgs();

  SetIgnoreMeGroup("team3", "axis");
  SetIgnoreMeGroup("axis", "team3");

  spawner = GetEnt("endlog_soap_spawner", "targetname");
  spawner thread add_spawn_function(::gulag_become_soap);

  spawner = GetEnt("ghost", "script_noteworthy");
  spawner thread add_spawn_function(::gulag_become_ghost);

  array_spawn_function_noteworthy("overlook_spawner", ::overlook_spawner_think);

  array_spawn_function_targetname("bhd_spawner", ::bhd_heli_think);
  array_spawn_function_noteworthy("breach_death_spawner", ::die_on_ragdoll);
  array_spawn_function_noteworthy("riot_shield_spawner", ::riot_shield_guy);
  array_spawn_function_noteworthy("flee_armory_spawner", ::flee_armory_think);
  array_spawn_function_noteworthy("tarp_spawner", ::tarp_spawner_think);

  array_spawn_function_noteworthy("close_fighter_spawner", ::close_fighter_think);
  array_spawn_function_noteworthy("bathroom_balcony_spawner", ::bathroom_balcony_spawner);
  array_spawn_function_noteworthy("riot_escort_spawner", ::riot_escort_spawner);
  array_spawn_function_noteworthy("catwalk_spawner", ::catwalk_spawner);
  array_spawn_function_noteworthy("dies_fast_to_explosive", ::dies_fast_to_explosive);
  array_spawn_function_noteworthy("ignore_then_dies_fast_to_explosive", ::ignore_then_dies_fast_to_explosive);

  run_thread_on_noteworthy("low_health_destructible", ::low_health_destructible);

  run_thread_on_targetname("challenge_only", ::self_delete);

  ally_gets_missed_triggers = getEntArray("ally_gets_missed_trigger", "targetname");
  array_thread(ally_gets_missed_triggers, ::ally_gets_missed_trigger_think);

  ally_can_get_hit_triggers = getEntArray("ally_can_get_hit_trigger", "targetname");
  array_thread(ally_can_get_hit_triggers, ::ally_can_get_hit_trigger_think);

  ally_in_armorys = getEntArray("ally_in_armory", "targetname");
  array_thread(ally_in_armorys, ::ally_in_armory_think);

  damage_targ_triggers = getEntArray("damage_targ_trigger", "targetname");
  array_thread(damage_targ_triggers, ::damage_targ_trigger_think);

  friendlies_ditch_riot_shields_triggers = getEntArray("friendlies_ditch_riot_shields_trigger", "targetname");
  array_thread(friendlies_ditch_riot_shields_triggers, ::friendlies_ditch_riot_shields_trigger_think);

  add_wait(::flag_wait, "player_moves_into_gulag");
  add_func(::flag_set, "gulag_cell_doors_enabled");
  thread do_wait();

  thread landing_blocker_think();

  level.ending_flee_guys = 0;
  level.ending_flee_max = 0;

  level.slamraam_missile = "slamraam_missile_guided";

  thread gulag_objectives();
  thread gulag_music();
  thread gulag_startpoint_catchup_thread();

  ai_field_blocker = GetEnt("ai_field_blocker", "targetname");
  ai_field_blocker ConnectPaths();
  ai_field_blocker NotSolid();

  deprecated_traverses = getEntArray("deprecated_traverse", "targetname");
  array_thread(deprecated_traverses, ::self_delete);
}
so_remove_weapon_tarp() {
  if(!is_specialop()) {
    ent = GetEnt("so_weapon_tarp", "targetname");
    ent Delete();
  }
}

gulag_introscreen() {
  level.player FreezeControls(true);

  introblack = create_client_overlay("black", 1, level.player);

  wait(0.5);

  lines = [];

  lines[lines.size] = &"GULAG_INTROSCREEN_LINE_4";
  lines[lines.size] = &"GULAG_INTROSCREEN_LINE_3";
  lines["date"] = &"GULAG_INTROSCREEN_LINE_2";
  lines[lines.size] = &"GULAG_INTROSCREEN_LINE_1";

  wait(2);

  introblack FadeOverTime(4);
  introblack.alpha = 0;

  wait(1);

  level.player FreezeControls(false);

  wait(3);
  introblack Destroy();
}
gulag_no_game_start_setupFunc() {
  maps\_loadout::init_loadout();

  level.spawn_funcs = [];
  level.spawn_funcs["allies"] = [];
  level.spawn_funcs["axis"] = [];
  level.spawn_funcs["neutral"] = [];

  maps\_nightvision::main(level.players);
  level.player SetActionSlot(1, "nightvision");
}

start_empty() {}

gulag_flyin() {
  level.player DisableWeapons();
  thread draw_waterfx();
  level.treadfx_maxheight = 5000;
  level.skip_treadfx = true;

  SetSavedDvar("compass", "0");
  SetSavedDvar("ammoCounterHide", 1);
  SetSavedDvar("hud_showStance", 0);
  SetSavedDvar("hud_drawhud", 1);

  array_spawn_function_noteworthy("goal_delete_spawner", ::delete_on_player_land);

  thread control_room_destructibles_turn_on();

  heli_smoke_triggers = getEntArray("heli_smoke_trigger", "targetname");
  array_thread(heli_smoke_triggers, ::heli_smoke_trigger_think);

  thread gulag_top_drones();
  thread spawn_f15s();
  thread maps\_introscreen::introscreen_generic_white_fade_in(0.5, 1);

  timer = GetTime();
  level.good_tone_timer = GetTime();
  going_in_hot = GetEnt("going_in_hot", "script_noteworthy");
  going_in_hot add_spawn_function(::going_in_hot);

  thread spawn_player_heli();

  spawners = getEntArray("intro_heli_1", "targetname");
  thread spawn_friendly_helis(spawners);

  player_heli = level.player_heli;

  wait(1.2);

  level.soap thread dialogue_queue("gulag_rpt_30sec");

  delayThread(2.7, ::radio_dialogue, "gulag_hrp1_angelsone");

  delayThread(3, ::radio_dialogue, "gulag_lbp1_gogetem");

  delayThread(12, ::radio_dialogue, "gulag_fp1_goodtone");

  wait(21);

  thread radio_dialogue("gulag_fp2_goodkill");

  thread radio_dialogue("gulag_fp1_niceday");

  thread radio_dialogue("gulag_lbp1_copies");

  thread radio_dialogue("gulag_lbp2_copiesall");

  thread radio_dialogue("gulag_lbp3_solidcopy");
}

start_approach() {
  array_spawn_function_noteworthy("goal_delete_spawner", ::delete_on_player_land);
  thread gulag_top_drones();
  flag_set("display_introscreen_text");
}

gulag_approach() {
  battlechatter_off("allies");

  gulag_player_loadout();
  level.player DisableWeapons();

  if(level.start_point == "approach") {
    heli_intro_player = GetEnt("heli_intro_player", "targetname");
    player_start = getstruct("start_approach", "script_noteworthy");
    heli_intro_player.origin = player_start.origin;
    remap_targets(heli_intro_player.target, player_start.targetname);
    heli_intro_player.target = player_start.targetname;

    friendly_starts = getStructArray("start_approach_friendly", "script_noteworthy");
    friendly_heli_spawners = getEntArray("intro_heli_1", "targetname");
    foreach(index, spawner in friendly_heli_spawners) {
      remap_targets(spawner.target, friendly_starts[index].targetname);
      spawner.origin = friendly_starts[index].origin;
      spawner.target = friendly_starts[index].targetname;
    }

    going_in_hot = GetEnt("going_in_hot", "script_noteworthy");
    going_in_hot add_spawn_function(::going_in_hot);
    thread spawn_player_heli();

    spawners = getEntArray("intro_heli_1", "targetname");
    thread spawn_friendly_helis(spawners);

    level.player SetPlayerAngles((0, -163, 0));
    level.player_heli Vehicle_SetSpeedImmediate(84, 84 / 4, 84 / 4);
  } else
  if(level.start_point == "landing_test") {
    heli_intro_player = GetEnt("heli_intro_player", "targetname");
    player_start = getstruct("start_approach", "script_noteworthy");
    heli_intro_player.origin = player_start.origin;
    remap_targets(heli_intro_player.target, player_start.targetname);
    heli_intro_player.target = player_start.targetname;

    friendly_starts = getStructArray("start_approach_friendly", "script_noteworthy");
    new_start = getstruct("test_unload_node", "script_noteworthy");
    friendly_starts[2] = new_start;
    friendly_heli_spawners = getEntArray("intro_heli_1", "targetname");
    foreach(index, spawner in friendly_heli_spawners) {
      remap_targets(spawner.target, friendly_starts[index].targetname);
      spawner.origin = friendly_starts[index].origin;
      spawner.target = friendly_starts[index].targetname;
    }

    going_in_hot = GetEnt("going_in_hot", "script_noteworthy");
    going_in_hot add_spawn_function(::going_in_hot);
    thread spawn_player_heli();

    spawners = getEntArray("intro_heli_1", "targetname");
    thread spawn_friendly_helis(spawners);

    level.player SetPlayerAngles((0, -163, 0));
    level.player_heli Vehicle_SetSpeedImmediate(84, 84 / 4, 84 / 4);

    level.player Unlink();
    gulag_center = GetEnt("gulag_center", "targetname");
    level.player SetOrigin(gulag_center.origin);
  }

  flag_wait("display_introscreen_text");

  wait(2.2);

  SaveGame("approach", &"AUTOSAVE_AUTOSAVE", " ", true);

  lines = [];

  lines[lines.size] = &"GULAG_INTROSCREEN_2";

  lines[lines.size] = &"GULAG_INTROSCREEN_3";

  lines[lines.size] = &"GULAG_INTROSCREEN_4";

  lines[lines.size] = &"GULAG_INTROSCREEN_5";
  thread maps\_introscreen::introscreen_feed_lines(lines);

  flag_wait("approach_dialogue");

  wait(1);

  radio_dialogue_stop();

  thread radio_dialogue("gulag_lbp2_goinghot");
  flag_set("going_in_hot");

  thread radio_dialogue("gulag_lbp1_roger");
  wait(3.65);

  delayThread(7, ::blend_in_gulag_dof, 11);

  wait(0.5);

  thread radio_dialogue("gulag_lbp2_guns");
  wait(1.85);

  wait(1);

  thread radio_dialogue("gulag_lbp2_guns2");
  wait(1.9);

  delayThread(4, ::kill_deathflag, "first_tower");

  flag_set("player_heli_uses_modified_yaw");

  wait(1);

  delayThread(1, ::radio_dialogue_overlap, "gulag_lbp1_goodeffect");

  foreach(heli in level.friendly_helis) {
    heli mgon();
    foreach(turret in heli.mgturret) {
      turret SetMode("auto_nonai");
    }
  }

  level.stabilize_offset = 3;
  level.player_heli thread player_heli_rotates_properly_around_gulag();

  wait(3.2);

  level.soap thread dialogue_queue("gulag_rpt_stbyengage");
  delayThread(2, ::gulag_player_snipes);

  wait(3);

  wait(0.65);

  level.soap thread dialogue_queue("gulag_rpt_stabilize");

  flag_wait("stabilize");

  wait(0.75);

  level.soap thread dialogue_queue("gulag_rpt_clearedengage");
  delayThread(2, ::flag_set, "soap_snipes_tower");

  thread radio_dialogue("gulag_lbp1_roger2");

  delayThread(8, ::kill_deathflag, "stab1_clear", 6);

  old_time = GetTime();
  flag_wait("stab1_clear");

  flag_clear("stabilize");
  flag_clear("soap_snipes_tower");
  wait(0.75);

  wait(0.75);
  level.soap thread dialogue_queue("gulag_rpt_shiftright");
  wait(1.25);
  flag_set("stab1_shift");

  thread radio_dialogue("gulag_lbp1_shifting");

  flag_wait("stabilize");

  delayThread(2, ::flag_set, "soap_snipes_tower");

  thread second_tower_stabilize_dialogue();

  delayThread(8, ::kill_deathflag, "second_tower_clear", 4);

  wait(4);

  car_blows_up = GetEnt("car_blows_up", "script_noteworthy");
  RadiusDamage(car_blows_up.origin, 1200, 5000, 5000);

  tarp_puller_spawners = getEntArray("tarp_puller_spawner", "targetname");
  array_thread(tarp_puller_spawners, ::spawn_ai);

  level waittill("tarp_activate");

  delayThread(4, ::kill_deathflag, "sam_cleared", 2.5);

  flag_wait("sam_cleared");
  flag_clear("soap_snipes_tower");

  wait(0.5);

  delayThread(2.2, ::exploder, "main_building");
  level.soap thread dialogue_queue("gulag_rpt_shiftright2");

  wait(1.5);
  flag_set("stab2_clear");

  flag_clear("stabilize");

  radio_dialogue("gulag_lbp1_shifting2");
}

start_perimeter() {
  array_spawn_function_noteworthy("goal_delete_spawner", ::delete_on_player_land);
  thread gulag_top_drones();

  heli_intro_player = GetEnt("heli_intro_player", "targetname");
  player_start = getstruct("start_player_perimeter", "script_noteworthy");
  heli_intro_player.origin = player_start.origin;
  heli_intro_player.angles = player_start.angles;
  remap_targets(heli_intro_player.target, player_start.targetname);
  heli_intro_player.target = player_start.targetname;

  thread spawn_player_heli();

  level.player SetPlayerAngles((0, -163, 0));
  speed = 24;
  level.player_heli Vehicle_SetSpeedImmediate(speed, speed / 4, speed / 4);

  level.stabilize_offset = 3;
  level.player_heli thread player_heli_rotates_properly_around_gulag();
  blend_in_gulag_dof(3);
}

start_f15() {
  array_spawn_function_noteworthy("goal_delete_spawner", ::delete_on_player_land);

  heli_intro_player = GetEnt("heli_intro_player", "targetname");
  player_start = getstruct("f15_attack_start", "script_noteworthy");
  heli_intro_player.origin = player_start.origin;
  heli_intro_player.angles = player_start.angles;
  remap_targets(heli_intro_player.target, player_start.targetname);
  heli_intro_player.target = player_start.targetname;

  thread spawn_player_heli();

  speed = 40;
  level.player_heli Vehicle_SetSpeedImmediate(speed, speed / 4, speed / 4);

  level.stabilize_offset = 3;
  level.player_heli thread player_heli_rotates_properly_around_gulag();
  blend_in_gulag_dof(3);
}

gulag_perimeter() {
  level.treadfx_maxheight = undefined;
  level.skip_treadfx = undefined;
  level notify("stop_special_treadfx");

  thread f15_gulag_attack();

  flag_set("gulag_perimeter");

  level.soap delayThread(1.8, ::dialogue_queue, "gulag_cmt_seehostiles");

  flag_wait("f15_gulag_explosion");
  battlechatter_off("allies");

  wait(2);

  autosave_by_name("gulag_perimeter");

  level.player GiveWeapon("m4m203_reflex_arctic");

  level notify("stop_gulag_drones");

  thread player_loses_ads_briefly();

  wait(3.5);
  thread radio_dialogue("gulag_lbp1_hangon");
  thread flyby_earthquake();

  wait(2.9);

  iprint("Hargrove, get the navy to cease fire immediately! That was too close!");
  thread radio_dialogue("gulag_rpt_tooclose");

  thread bhd_heli_attack_setup();

  thread ai_field_blocker();

  noself_delayCall(11, ::SetSavedDvar, "g_friendlyNameDist", 15000);

  battlechatter_off("allies");
  delayThread(41, ::battlechatter_on, "allies");
  thread friendlies_traverse_gulag_exterior();

  iprint("The navy doesn't care about one man in a Gulag. I'll try to buy you some time but I can't promise much.");

  thread radio_dialogue("gulag_hqr_moretime");

  thread radio_dialogue("gulag_tco_goodorbad");

  thread radio_dialogue("gulag_rpt_cutchatter");

  thread radio_dialogue("gulag_lbp1_2ndwave");

  thread radio_dialogue("gulag_lbp1_10ft");

  thread gulag_landing_update_entities();

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    guy pathrandompercent_set(200);
  }

  level.player_heli waittill("nearing_landing");

  wait(0.3);

  level.soap delaythread(3, ::generic_dialogue_queue, "gulag_rpt_gogogo");

  thread radio_dialogue("gulag_lbp1_touchdown");

  thread radio_dialogue("gulag_lbp1_deployed");

  thread radio_dialogue("gulag_lbp3_snipercover");

  thread radio_dialogue("gulag_lbp1_solidcopy");

  level.soap set_force_color("cyan");

  level.soap StopLookAt();

  thread armory_roach_is_down();

  level.player_heli waittill("stable_for_unlink");

  level.player SetActionSlot(1, "nightvision");
  level.player GiveWeapon("claymore");
  level.player SetActionSlot(4, "weapon", "claymore");
  level.player GiveMaxAmmo("claymore");

  level.player thread playerSnowFootsteps("disable_exterior_fx");
  level.player PlayerSetGroundReferenceEnt(undefined);

  Missile_DeleteAttractor(level.player_repulsor);

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    guy pathrandompercent_set(200);
  }

  angles = level.player_view_controller GetTagAngles("tag_aim");
  angles = (0, angles[1], 0);
  forward = anglesToForward(angles);
  forward *= 32;

  ent = spawn_tag_origin();
  ent.origin = level.player_view_controller.origin;
  ent.angles = level.player_view_controller.angles;

  level.player_view_controller LinkTo(ent);
  movetime = 0.2;
  ent MoveTo(ent.origin + forward + (0, 0, 4), movetime, 0.1, 0.1);
  wait(movetime);
  level.player_view_controller Delete();
  ent Delete();

  level.player AllowProne(true);
  level.player AllowCrouch(true);
  level.player AllowSprint(true);
  level.player AllowJump(true);

  autosave_by_name("player_lands");

  level.soap forceUseWeapon("m4m203_reflex_arctic", "primary");
  flag_set("access_control_room");
}

start_control_room() {
  struct = getstruct("ghost_spawner_struct", "targetname");
  ghost_spawner = GetEnt("ghost", "script_noteworthy");
  ghost_spawner.script_drone = undefined;
  ghost_spawner.origin = struct.origin;
  ghost_spawner.angles = struct.angles;

  spawners = getEntArray("start_controlroom_spawner", "targetname");
  spawners = update_soap_spawner(spawners);
  spawners[spawners.size] = ghost_spawner;
  array_thread(spawners, ::spawn_ai);

  player_org = GetEnt("start_controlroom_player", "targetname");
  level.player SetOrigin(player_org.origin);
  level.player SetPlayerAngles(player_org.angles);
}

soap_chats_outside_gulag() {
  flag_wait("player_inside_gulag");

  level.soap dialogue_queue("gulag_cmt_getout");

  flag_set("start_armory_music");

  level.soap thread dialogue_queue("gulag_cmt_checkcorners");
  wait(1.5);
  flag_set("soap_finishes_talking_about_going_in");
}

gulag_cellblocks() {
  flag_wait("player_progresses_passed_ext_area");
  kill_deathflag("upper_balcony_deathflag", 4);

  if(!flag("player_nears_cell_door1")) {
    activate_trigger_with_targetname("ext_finished");
    thread push_friendlies_forward_on_flag();
  }

  flag_wait("postup_outside_gulag");

  thread soap_chats_outside_gulag();

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    if(isDefined(guy.old_pathrandompercent))
      guy pathrandompercent_reset();
  }

  add_global_spawn_function("axis", ::ambush_behavior);
  add_global_spawn_function("allies", ::enable_cqbwalk);

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    guy.baseaccuracy = 1;
    guy.attackeraccuracy = 1;
  }

  flag_wait_either("last_outside_guys", "player_moves_into_gulag");

  level.soap set_force_color("cyan");

  if(!flag("player_nears_cell_door1"))
    activate_trigger_with_targetname("outside_gulag_postup");

  flag_wait("player_moves_into_gulag");

  friendly_respawn_trigger = GetEnt("friendly_reinforcement_trigger", "targetname");
  friendly_respawn_trigger thread reinforcement_friendlies();

  volume = GetEnt("purple_friendlies_priority_volume", "targetname");
  ai = GetAIArray("allies");
  ai = remove_heroes_from_array(ai);

  purple_guys = 0;
  foreach(index, guy in ai) {
    if(guy IsTouching(volume)) {
      purple_guys++;
      guy set_force_color("p");
      ai[index] = undefined;
    }
  }

  ai = remove_dead_from_array(ai);
  for(i = purple_guys; i < 2; i++) {
    if(!isalive(ai[i])) {
      continue;
    }
    ai[i] set_force_color("p");
    ai[i] = undefined;
  }

  ai = remove_dead_from_array(ai);
  foreach(guy in ai) {
    guy set_force_color("o");
  }

  if(!flag("player_nears_cell_door1"))
    activate_trigger_with_targetname("pre_controlroom_postup");

  flag_wait("soap_finishes_talking_about_going_in");

  volume = GetEnt("control_room_hallway_volume", "targetname");
  volume waittill_volume_dead_or_dying();

  if(!flag("player_nears_cell_door1"))
    activate_trigger_with_targetname("control_room_postup");

  flag_wait("disable_exterior_fx");

  ghost_line("gulag_gst_controlroom");

  thread ghost_uses_laptop();

  flag_wait("control_room");

  thread gulag_cellblocks_spotlight();

  if(IsAlive(level.ghost)) {
    level.ghost disable_ai_color();
  } else {
    AssertEx(!is_default_start(), "Ghost was dead on default start!");
  }

  ai = GetAIArray("allies");
  excluders = [];
  excluders[0] = level.soap;
  excluders[1] = level.ghost;
  ai = get_array_of_closest(level.player.origin, ai, excluders);

  extra_friendlies = 2;

  for(i = 0; i < extra_friendlies; i++) {
    guy = ai[i];
    if(!isalive(guy)) {
      continue;
    }
    guy set_force_color("g");
    guy allies_have_low_attacker_accuracy();
  }

  for(i = extra_friendlies; i < ai.size; i++) {
    ai[i] disable_ai_color();
  }

  add_global_spawn_function("allies", ::allies_have_low_attacker_accuracy);

  wait_while_enemy_near_player();
  battlechatter_off("allies");

  flag_set("ghost_goes_to_laptop");

  if(isalive(level.ghost))
    level.ghost set_battlechatter(false);

  ghost_line("gulag_cmt_tapinto");

  flag_set("cell_duty");

  thread friendly_cellblock_respawner();

  if(!flag("player_nears_cell_door1"))
    activate_trigger_with_targetname("first_cell_postup");

  level.soap dialogue_queue("gulag_cmt_cellduty");

  flag_wait("player_nears_cell_door1");

  thread teleport_ghost_to_laptop_if_possible();

  flag_wait("cellblock_clear1");

  wait(0.5);

  radio_dialogue("gulag_tf1_cellclear");
  wait(0.4);

  flag_wait("ghost_uses_laptop");

  radio_dialogue("gulag_gst_patchedin");

  level.soap dialogue_queue("gulag_cmt_location");

  delayThread(1.5, ::flag_set, "spotlight_turns_on");

  radio_dialogue("gulag_gst_jobeasier");

  level.soap dialogue_queue("gulag_cmt_staysharp");

  battlechatter_on("allies");

  flag_wait("player_nears_cell_door2");

  thread insure_player_has_enemies_to_fight_for_door_sequence();

  level.soap dialogue_queue("gulag_cmt_secdoor");

  thread radio_dialogue("gulag_cmt_ancient");
  wait(2.5);

  flag_set("open_cell_door3");
  wait(3);

  level.soap dialogue_queue("gulag_cmt_wrongdoor");

  thread radio_dialogue("gulag_gst_standby");

  wait(3);

  flag_set("open_cell_door2");

  radio_dialogue("gulag_gst_gotit2");
  activate_trigger_with_targetname("mid_door_opens");

  wait(1);

  level.soap dialogue_queue("gulag_cmt_thatsbetter");

  flag_wait("cell_clear_1");

  radio_dialogue("gulag_tf1_cell4dclear");

  flag_wait("cell_clear_2");

  radio_dialogue("gulag_tf1_cellsclear");

  flag_wait("player_nears_cell_door4");

  delayThread(3.5, ::flag_set, "open_cell_door4");

  level.soap dialogue_queue("gulag_cmt_talktome");

  enemies_retreat_and_delete();

  radio_dialogue("gulag_gst_eastwing");

  level.soap thread dialogue_queue("gulag_cmt_armorydownthere");
  activate_trigger_with_targetname("pre_armory");
  wait(2.3);

  flag_set("pre_armory_open");
  activate_trigger_with_noteworthy("pre_armory");

  flag_wait("player_approaches_armory");
  ai = GetAIArray("axis");
  array_thread(ai, ::die_soon);
}

start_armory() {
  thread gulag_cellblocks_spotlight();

  flag_set("player_nears_cell_door1");
  flag_set("pre_armory_open");

  activate_trigger_with_noteworthy("pre_armory");

  spawners = getEntArray("start_armory_spawner", "targetname");
  spawners = update_soap_spawner(spawners);
  array_thread(spawners, ::spawn_ai);

  player_org = GetEnt("start_armory_player", "targetname");
  level.player SetOrigin(player_org.origin);
  level.player SetPlayerAngles(player_org.angles);

  wait(0.05);
  level.soap set_force_color("cyan");
}

gulag_armory() {
  level.soap forceUseWeapon("mp5", "primary");

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    guy disable_heat_behavior();
    guy delayThread(3, ::enable_dontevershoot);
  }
  thread battlechatter_off("axis");
  thread battlechatter_off("allies");

  flag_wait("player_in_armory");

  cellblock_spawning_door = getent("cellblock_spawning_door", "targetname");
  cellblock_spawning_door connectpaths();
  cellblock_spawning_door notsolid();
  cellblock_spawning_door hide();

  level.soap thread dialogue_queue("gulag_cmt_seeanything");
  wait(1.5);

  level.armory_laser_index = 0;
  add_global_spawn_function("axis", ::armory_laser_ambush);

  wait(2.5);

  wait(1);
  thread radio_dialogue("gulag_gst_badnews");

  wait(2.1);
  thread armory_attack_sounds(4000);
  wait(0.9);

  wait(1);

  level.soap thread dialogue_queue("gulag_cmt_hearcoming");
  delaythread(0.9, ::activate_trigger_with_targetname, "stand_at_armory_door");

  start_time = gettime();
  wait(3.0);

  thread ghost_tries_to_open_door();

  wait_for_buffer_time_to_pass(start_time, 5.85);

  level.soap thread dialogue_queue("gulag_cmt_opendoor");
  wait(2.0);

  allies = getaiarray("allies");
  foreach(guy in allies) {
    guy.baseaccuracy = 10;
    guy disable_surprise();
  }

  wait(1.8);
  delaythread(2.5, ::enemies_attack_friendlies_in_armory_first_wave);

  set_player_attacker_accuracy(0.85);

  thread radio_dialogue("gulag_gst_runabypass");
  wait(3.4);

  level.soap thread dialogue_queue("gulag_cmt_toolate");

  activate_trigger_with_targetname("armory_attacked_postup");

  wait_until_first_wave_ends();
  start_time = gettime();

  set_player_attacker_accuracy(0);
  level.player.ignorerandombulletdamage = true;

  autosave_by_name_thread("armory_fight", 10);

  wait_for_buffer_time_to_pass(start_time, 3);
  wait(0.5);

  maps\_gameskill::updateAllDifficulty();
  level.player.ignorerandombulletdamage = false;

  thread radio_dialogue("gulag_gst_gotmoretangos");

  allies = getaiarray("allies");
  foreach(guy in allies) {
    guy.baseaccuracy = 0;
  }

  wait(2.35);

  second_wave_delay = [];
  second_wave_delay[0] = 5;
  second_wave_delay[1] = 4;
  second_wave_delay[2] = 2.5;
  second_wave_delay[3] = 1.5;

  delay = second_wave_delay[level.gameskill];

  delaythread(delay, ::enemies_attack_friendlies_in_armory_second_wave);

  level.soap thread dialogue_queue("gulag_cmt_morecover");

  thread player_riotshield_bash_hint();

  wait(1.5);
  thread friendlies_grab_riotshields();
  flag_set("friendlies_use_riotshield");

  wait(8);

  if(!player_has_weapon("riotshield"))
    set_player_attacker_accuracy(1.5);

  thread player_riotshield_nag();
  wait(5);

  wait(1.5);

  activate_trigger_with_targetname("take_cover_at_armory_door");

  wait(4.5);

  level.soap thread dialogue_queue("gulag_cmt_openthedoor");
  wait(2.0);

  wait(2.5);
  level notify("force_door_open");

  level waittill("cell_door_opens");

  activate_trigger_with_targetname("post_armory");

  flag_wait("run_from_armory");
  kill_volume = GetEnt("run_from_armory_kill_volume", "targetname");
  ai = kill_volume get_ai_touching_volume("axis");
  foreach(guy in ai) {
    guy thread die_soon();
  }

  remove_global_spawn_function("axis", ::armory_laser_ambush);
  ai = GetAIArray("axis");
  array_thread(ai, ::disable_lasers);

  maps\_gameskill::updateAllDifficulty();

  spawn_rappel_rope();
  thread cellblock_rappel_player();

  level notify("stop_cellblock_respawn");

  thread friendlies_ignore_grenades_for_awhile();

  allies = getaiarray("allies");
  foreach(guy in allies) {
    guy.baseaccuracy = 1;
    guy enable_surprise();
  }

  level.soap thread dialogue_queue("gulag_cmt_gogogo1");

  level.riotshield_friendlies = remove_dead_from_array(level.riotshield_friendlies);
  foreach(guy in level.riotshield_friendlies) {
    guy enable_dontevershoot();
    guy riotshield_fastwalk_on();
  }

  battlechatter_on("axis");
  flag_wait("use_your_riotshield");

  cellblock_spawning_door disconnectpaths();
  cellblock_spawning_door solid();
  cellblock_spawning_door show();

  if(level.player GetCurrentWeapon() == "riotshield") {
    flag_clear("friendlies_use_riotshield");

    level.soap thread dialogue_queue("gulag_cmt_usesheild");

    ai = GetAIArray("allies");
    foreach(guy in ai) {
      guy clear_rioter();
    }
  } else {
    flag_set("friendlies_use_riotshield");

    level.soap thread dialogue_queue("gulag_cmt_illdrawfire");
  }

  delayThread(3.5, ::battlechatter_on, "allies");

  flag_wait("last_cellblock_guys_flee");
  lower_cellblock_enemies_retreat_and_delete();

  flag_wait("rappel_time");
  allies = getaiarray("allies");
  foreach(guy in allies) {
    guy enable_surprise();
  }

  thread rappel_time_dialogue();
}

rappel_time_dialogue() {
  radio_dialogue("gulag_gst_bypassfloors");

  level.soap dialogue_queue("gulag_cmt_roachfollow");
}

start_rappel() {
  spawn_rappel_rope();

  spawners = getEntArray("start_rappel_spawner", "targetname");
  spawners = update_soap_spawner(spawners);
  for(i = 1; i < spawners.size; i++) {
    spawners[i] add_spawn_function(::replace_on_death);
  }

  array_thread(spawners, ::spawn_ai);

  player_org = GetEnt("start_rappel_player", "targetname");
  level.player SetOrigin(player_org.origin);
  level.player SetPlayerAngles(player_org.angles);
  cellblock_rappel_player();
}

gulag_solitary_dialogue() {
  wait(1.8);

  radio_dialogue("gulag_gst_feedisdead");

  level.soap dialogue_queue("gulag_cmt_switchnv");
}

gulag_rappel() {
  flag_set("access_control_room");
  flag_set("control_room");

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    guy.baseaccuracy = 1;
    guy.attackeraccuracy = 1;
  }

  kill_all_axis();

  level.soap thread hero_rappels();

  flag_wait("cellblock_player_starts_rappel");

  fog_set_changes("gulag_hallways");

  volume = GetEnt("gulag_hallway_destructibles", "script_noteworthy");
  volume activate_destructibles_in_volume();
  volume activate_interactives_in_volume();

  wait(5);

  activate_trigger_with_targetname("cellblock_exit_postup");

  thread gulag_solitary_dialogue();

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    if(guy is_hero()) {
      continue;
    }
    if(isDefined(guy.magic_bullet_shield))
      guy stop_magic_bullet_shield();

    guy Delete();
  }

  friendly_cellhall_spawners = getEntArray("friendly_cellhall_spawner", "targetname");
  array_spawn_function(friendly_cellhall_spawners, ::replace_on_death);
  array_thread(friendly_cellhall_spawners, ::spawn_ai);

  flag_wait("leaving_cellblock");
  activate_trigger_with_targetname("friendly_nvg_hallway_trigger");

  level.player delayThread(1.8, ::display_hint, "nvg");

  flag_wait("nvg_zone");

  spawners = getEntArray("hallway_runner_spawner", "script_noteworthy");
  nodes = GetNodeArray("nvg_ambush_node", "targetname");
  nodes = array_randomize(nodes);
  array_thread(nodes, ::nodes_are_periodically_bad);
  foreach(index, spawner in spawners) {
    spawner.origin = nodes[index].origin;
  }

  activate_trigger_with_targetname("friendly_nvg_cell_hall_postup");

  thread nvg_hallway_fight();

  add_wait(::flag_wait, "lets_sweep_the_nvg_cells");
  add_func(::friendlies_move_up_through_cells);
  thread do_wait();

  flag_wait("nvg_leave_cellarea");
  flag_wait_either("nvg_fight_spawner", "player_sees_explosion");

  DisableForcedSunShadows();
  exploder("hall_attack_explosion");
  level.player delayCall(0.5, ::ShellShock, "gulag_attack", 5, false);
  level.player delayCall(0.6, ::setstance, "prone");
  Earthquake(0.3, 3, level.player.origin, 5000);
  level.player PlayRumbleLoopOnEntity("damage_heavy");
  level.player delayCall(2, ::StopRumble, "damage_heavy");
  axis = GetAIArray("axis");
  foreach(guy in axis) {
    if(Distance(level.player.origin, guy.origin) < 350)
      guy delayCall(0.5, ::Kill);
  }

  allies = GetAIArray("allies");
  foreach(guy in allies) {
    timer = randomfloatrange(4.5, 6.5);
    guy thread flashBangStart(timer);
  }

  delayThread(1.5, ::exploder, "hall_attack");
  thread drop_riotshield();

  add_wait(::flag_wait, "nvg_disable_night_vision");
  add_func(::display_hint, "disable_nvg");
  thread do_wait();

  vision_set_changes("gulag_hallways", 4);

  wait(5);
  thread soap_is_angry_about_attack();

  flag_wait("nvg_disable_night_vision");
}

start_tunnel() {
  spawners = getEntArray("friendly_tunnel_spawner", "targetname");
  spawners = update_soap_spawner(spawners);
  for(i = 1; i < spawners.size; i++) {
    spawners[i] add_spawn_function(::replace_on_death);
  }

  array_thread(spawners, ::spawn_ai);

  player_org = Getstruct("start_tunnel_player", "targetname");
  level.player SetOrigin(player_org.origin);
  level.player SetPlayerAngles(player_org.angles);
}

gulag_tunnel() {
  activate_trigger_with_targetname("pipe_tunnel_fight_nodes");

  flag_wait("go_to_pipearea_postup");
  thread throw_flash_trigger();

  wait(0.5);

  volume = GetEnt("tunnel_pre_hallway_volume", "targetname");
  volume add_wait(::waittill_volume_dead_or_dying);
  add_wait(::_wait, 15);
  level add_wait(::waittill_msg, "flashed_room");
  do_wait_any();

  level.soap thread dialogue_queue("gulag_cmt_gogogo1");
  wait(0.15);

  activate_trigger_with_targetname("pipe_tunnel_postup");
  ai = getaiarray("allies");
  foreach(guy in ai) {
    guy thread move_on_pipe();
  }

  battlechatter_on("axis");
  battlechatter_on("allies");

  flag_wait("advance_through_pipearea");
  EnableForcedNoSunShadows();

  level notify("stop_music");

  fog_set_changes("gulag");

  flag_wait("friendlies_follow_pipe_area");

  level.soap thread dialogue_queue("gulag_cmt_gogogo1");

  activate_trigger_with_targetname("breach_bathroom_postup");

  flag_wait("nearing_bathroom_breach");

  ai = getaiarray("allies");
  foreach(guy in ai) {
    guy.fixednode = true;
  }

  thread radio_dialogue("gulag_gst_30ftonleft");
}

start_bathroom() {
  spawners = getEntArray("friendly_bathroom_spawner", "targetname");
  spawners = update_soap_spawner(spawners);

  if(level.start_point == "bathroom") {
    for(i = 1; i < spawners.size; i++) {
      spawners[i] add_spawn_function(::replace_on_death);
    }
  }

  array_thread(spawners, ::spawn_ai);

  start_point = GetEnt("start_bathroom_player", "targetname");
  level.player SetOrigin(start_point.origin);
  level.player SetPlayerAngles(start_point.angles);

  activate_trigger_with_targetname("breach_bathroom_postup");
}

enable_bathroom_complete_trigger() {
  trigger_ent = GetEnt("player_rappels_from_bathroom", "script_noteworthy");
  trigger_ent waittill("trigger");
  flag_set("player_exited_bathroom");
}

gulag_bathroom() {
  fog_set_changes("gulag");

  flag_wait("leaving_pipe_area");

  add_global_spawn_function("axis", ::higher_max_facedist);
  add_global_spawn_function("axis", ::track_spawn_time);

  level waittill("breaching");

  delaythread(0.05, ::remove_global_spawn_function, "axis", ::track_spawn_time);

  axis = getaiarray("axis");
  foreach(guy in axis) {
    if(!isDefined(guy.spawn_time) || guy.spawn_time != gettime())
      guy thread die_soon();
  }

  volume = GetEnt("gulag_shower_destructibles", "script_noteworthy");
  volume activate_destructibles_in_volume();
  volume activate_interactives_in_volume();

  level.player.attackeraccuracy = 0;
  level.player delayThread(6, maps\_gameskill::update_player_attacker_accuracy);

  flag_wait("player_enters_bathroom");

  activate_trigger_with_noteworthy("first_friendly_bathroom_trigger");

  thread friendlies_traverse_bathroom();

  thread maps\_ambient::activateAmbient("gulag_shower_int0");
  thread enable_bathroom_complete_trigger();

  level.soap delayThread(3.5, ::dialogue_queue, "gulag_cmt_spreadout");

  activate_trigger_with_targetname("bathroom_initial_enemies");

  delay = 15;

  delayThread(delay, ::activate_trigger_with_targetname, "bathroom_balcony_room1_trigger");

  level.soap delayThread(delay + 3, ::dialogue_queue, "gulag_cmt_hostiles2ndfloor");

  flag_wait("bathroom_start_second_wave");

  bathroom_second_wave();

  add_wait(::flag_wait, "use_lockers_for_cover");
  level.soap add_func(::dialogue_queue, "gulag_cmt_uselockers");
  thread do_wait();

  riot_shield_detector = GetEnt("riot_shield_detector", "targetname");
  riot_shield_detector thread riot_shield_detector_think();

  add_wait(::flag_wait, "bathroom_room2_enemies_dead");
  add_wait(::flag_wait, "leaving_bathroom_vol2");
  do_wait_any();

  thread bathroom_periodic_autosave();

  autosave_by_name("bathroom_cleared");

  flag_wait("leaving_bathroom_vol2");

  level.soap thread dialogue_queue("gulag_cmt_holeinfloor");

  activate_trigger_with_targetname("cistern_friendly_trigger");

  level.soap delayThread(2.5, ::dialogue_queue, "gulag_cmt_gogogo1");

  ai = GetAIArray("allies");
  foreach(guy in ai) {
    guy.attackeraccuracy = 0;
  }

  thread friendly_hole_rappel();

  flag_wait("player_exited_bathroom");
  add_global_spawn_function("allies", ::waterfx, "rescue_begins");

  ai = GetAIArray("allies");
  array_thread(ai, ::waterfx, "rescue_begins");
  level.player thread waterfx("rescue_begins");

  remove_global_spawn_function("axis", ::higher_max_facedist);

  run_thread_on_targetname("slide_trigger", ::sewer_slide_trigger);

  ai = GetAIArray("bad_guys");
  array_thread(ai, ::die_soon);

  thread maps\_ambient::activateAmbient("gulag_exit");

  autosave_by_name("reached_sewers");

  thread gulag_cistern_dialogue();

  add_wait(::flag_wait, "friendly_rappels_from_bathroom");
  add_func(::activate_trigger_with_targetname, "breach_rescue_trigger");
  thread do_wait();
}

gulag_cistern_dialogue() {
  if(flag("player_approaches_rescue_breach"))
    return;
  level endon("player_approaches_rescue_breach");

  flag_wait("friendly_rappels_from_bathroom");
  wait(1.5);

  level.soap dialogue_queue("gulag_cmt_whichway");

  radio_dialogue("gulag_gst_50meters");
  wait(3);

  level.soap dialogue_queue("gulag_cmt_startfiring");

  radio_dialogue("gulag_gst_cistern");
}

start_rescue() {
  spawners = getEntArray("start_rescue_spawner", "targetname");
  spawners = update_soap_spawner(spawners);
  for(i = 1; i < spawners.size; i++) {
    spawners[i] add_spawn_function(::magic_bullet_shield);
  }

  array_thread(spawners, ::spawn_ai);

  player_org = GetEnt("start_rescue_player", "targetname");
  level.player SetOrigin(player_org.origin);
  level.player SetPlayerAngles(player_org.angles);
  activate_trigger_with_targetname("breach_rescue_trigger");
}

gulag_rescue() {
  level._effect["breach_door"] = level._effect["breach_price"];

  flag_wait("player_approaches_rescue_breach");

  level.slowmo_breach_disable_stancemod = true;

  remove_global_spawn_function("allies", ::enable_cqbwalk);
  remove_global_spawn_function("allies", ::waterfx);

  ai = GetAIArray("bad_guys");
  array_thread(ai, ::die_soon);

  flag_set("rescue_begins");
  level.player.dont_unlink_after_breach = true;
  level.forced_slowmo_breach_slowdown = true;

  autosave_by_name("end_breach");

  thread radio_dialogue("gulag_gst_8tangos");

  trigger_from = level.breach_groups[3].trigger;
  trigger_to = level.breach_groups[4].trigger;

  level.skip_breach = [];
  level.skip_breach[3] = true;
  ent = spawn_tag_origin();
  ent.origin = level.breach_groups[3].left_post.origin;
  ent.angles = level.breach_groups[3].left_post.angles;

  arm_ent = spawn_tag_origin();

  from_org = trigger_from.origin;
  from_angles = trigger_from.angles;

  ai = GetAIArray("allies");

  for(;;) {
    trigger_from waittill("trigger");
    if(!level.player maps\_slowmo_breach::breach_failed_to_start()) {
      break;
    }
  }

  SetSavedDvar("g_friendlynamedist", 0);

  level.doPickyAutosaveChecks = false;
  ending_room_spawners = getEntArray("ending_room_spawner", "targetname");

  waittillframeend;

  level.player DontInterpolate();
  arm_ent.origin = level.player.origin;
  arm_ent.angles = level.player.angles;
  arm_ent LinkTo(ent);
  level.player PlayerLinkTo(arm_ent, "tag_origin", 1, 0, 0, 0, 0, 0);

  ent.origin = level.breach_groups[4].left_post.origin;
  ent.angles = level.breach_groups[4].left_post.angles;

  thread gulag_finish_rescue_thread(trigger_to, ai);

  if(level.start_point == "ending") {
    wait(0.05);
  }

  DisableForcedSunShadows();
  SetSavedDvar("ai_friendlysuppression", 0);
  SetSavedDvar("ai_friendlyfireblockduration", 0);

  delayThread(0.05, ::exploder, "rock_glass");

  trash_sound = GetEnt("trash_sound", "script_noteworthy");
  trash_sound thread maps\gulag_ending_code::trash_sound_think();

  run_thread_on_targetname("hallway_flicker_light", maps\gulag_ending_code::hallway_flicker_light);
  thread maps\_utility::set_ambient("gulag_exit");

  level waittill("breaching");

  level.player SetStance("stand");
  level.player EnableInvulnerability();
  level.player DisableWeaponSwitch();
  level.player DisableOffhandWeapons();
  level.player AllowCrouch(false);
  level.player AllowProne(false);
  level.player AllowSprint(false);
  level.player AllowJump(false);

  delayThread(4, ::vision_set_fog_changes, "gulag_ending", 4);

  level.player.attackeraccuracy = 0;
  level.player.IgnoreRandomBulletDamage = true;
  level.player delayThread(15, maps\_gameskill::update_player_attacker_accuracy);

  spawner = GetEnt("price_spawner", "targetname");
  spawner spawn_ai();

  spawner = GetEnt("price_choke_spawner", "targetname");
  chokey = spawner spawn_ai();
  chokey.animname = "chokey";
  chokey gun_remove();
  chokey.health = 5000;

  chokey add_damage_function(::bloody_pain);

  struct = getstruct("ending_breach_org", "targetname");
  level.price_breach_struct = struct;

  ent = spawn_tag_origin();

  ent.origin = struct.origin;
  ent.angles = struct.angles;

  localtrans = spawnStruct();
  localtrans.entity = ent;
  localtrans.forward = -38;
  localtrans.right = -24;
  localtrans translate_local();

  player_rig = spawn_anim_model("player_rig");
  player_rig Hide();

  strangle_chain = spawn_anim_model("strangle_chain");

  guys = [];
  guys[guys.size] = level.price;
  guys[guys.size] = chokey;
  guys[guys.size] = player_rig;
  guys[guys.size] = strangle_chain;

  foreach(guy in guys) {
    guy LinkTo(ent);
  }
  level.price_breach_ent = ent;

  time = GetAnimLength(level.price getanim("price_breach"));
  time -= 2;
  delayThread(time, maps\gulag_ending_code::player_gets_knocked_out_by_price, player_rig);

  ent anim_first_frame(guys, "price_breach");
  wait(2.2);
  thread price_breach_dof();

  level.price thread play_sound_on_entity("scn_gulag_price_rescue_foley");
  delayThread(3.95, ::play_sound_in_space, "scn_gulag_price_rescue_punch", level.player getEye());
  delayThread(4.35, ::play_sound_in_space, "scn_gulag_price_rescue_bodyfall", level.player getEye());

  chair = GetEnt("price_chair", "targetname");
  targ = getstruct(chair.target, "targetname");
  angles = VectorToAngles(targ.origin - chair.origin);
  forward = anglesToForward(angles);

  chair delayCall(0.5, ::PhysicsLaunchClient, chair.origin + (0, 0, 20), forward * 2000);
  ent anim_single(guys, "price_breach");

  level.player SetMoveSpeedScale(1);

  axis = GetAIArray("axis");
  foreach(guy in axis) {
    guy Delete();
  }

  spawner = GetEnt("endlog_soap_spawner", "targetname");
  spawner.count = 1;
  spawner spawn_ai();

  spawner = getEntArray("endlog_redshirt_spawner", "targetname")[0];
  spawner.count = 1;
  spawner spawn_ai();

  strangle_chain delete();

  level.soap gun_remove();
  price_1911 = spawn_anim_model("1911");

  guys = [];
  guys[guys.size] = level.price;

  animation = level.price getanim("price_rescue_intro");
  time = getanimlength(animation);
  ent delaythread(time, ::old_soap);

  guys["player"] = player_rig;

  guys[guys.size] = level.redshirt;
  guys[guys.size] = level.soap;
  guys["gun"] = price_1911;

  level.price Unlink();

  ent thread anim_single(guys, "price_rescue");

  delaythread(8.15, ::play_sound_in_space, "gulag_pri_soap", level.price.origin);
  delaythread(10.75, ::play_sound_in_space, "gulag_cmt_price", level.price.origin);
  delaythread(12.7, ::play_sound_in_space, "gulag_cmt_thisbelongs", level.price.origin);

  animation = level.soap getanim("price_rescue");
  time = GetAnimLength(animation);
  offset = 1.5;
  wait(time - offset);

  level.soap forceUseWeapon("m4_grunt", "primary");
  level.price notify("change_to_regular_weapon");
  flag_set("escape_the_gulag");
  price_1911 Delete();

  SetSavedDvar("g_friendlynamedist", 196);

  thread finish_rescue_sequence(offset);
}

gulag_finish_rescue_thread(trigger_to, ai) {
  wait(0.1);
  trigger_to notify("trigger", level.player);

  wait(2.5);
  level notify("kill_color_replacements");

  friendlies = GetAIArray("allies");
  foreach(guy in friendlies) {
    if(guy is_hero()) {
      continue;
    }
    if(isDefined(guy.magic_bullet_shield))
      guy stop_magic_bullet_shield();

    guy Delete();
  }

  foreach(guy in ai) {
    if(!isalive(guy)) {
      continue;
    }
    if(isDefined(guy.magic_bullet_shield))
      guy stop_magic_bullet_shield();

    guy Delete();
  }
}

finish_rescue_sequence(offset) {
  wait(offset + 0.5);

  level.player EnableWeapons();

  weapons = level.player GetWeaponsListPrimaries();

  foreach(weapon in weapons) {
    if(IsSubStr(weapon, "riot")) {
      continue;
    }
    level.player SwitchToWeapon(weapon);
    break;
  }

  level.player Unlink();
  level.player DisableInvulnerability();
  level.player EnableWeaponSwitch();
  level.player EnableOffhandWeapons();
  level.player AllowSprint(true);
  level.player AllowJump(true);
  level.player AllowCrouch(true);
  level.player AllowProne(true);

  time = 1.7;
  dif = time / 20;

  for(i = 0; i <= 1; i += dif) {
    level.player SetMoveSpeedScale(i);
    wait(0.05);
  }
}

gulag_objectives() {
  waittillframeend;

  if(is_default_start()) {
    wait(2);
  } else {
    waittillframeend;
  }

  Objective_Add(1, "current", &"GULAG_FIND_POW", pow_org());
  Objective_OnEntity(1, level.soap);
  Objective_Current(1);

  switch (level.start_point) {
    case "default":
    case "intro":
    case "approach":
    case "unload":
    case "f15":
      setsaveddvar("ui_hidemap", 1);
      flag_wait("player_lands");
      setsaveddvar("ui_hidemap", 0);

      Objective_Add(2, "current", &"GULAG_FOLLOW_SOAP", (0, 0, 0));
      Objective_Current(2);
      Objective_OnEntity(2, level.soap);
      flag_wait("postup_outside_gulag");
      objective_complete(2);

    case "control_room":

      Objective_Current(1);
      flag_wait("cell_duty");
      remove_global_spawn_function("allies", ::no_grenades);

    case "armory":

      Objective_Add(3, "current", &"GULAG_CELL_DUTY", cellblock_sweep_org());
      Objective_OnEntity(3, level.soap);
      Objective_Current(3);
      flag_wait("leaving_cellblock");
      objective_complete(3);

      Objective_Current(1);
      Objective_OnEntity(1, level.soap);

    case "rappel":
    case "tunnel":
    case "bathroom":

      flag_wait("advance_through_pipearea");
      struct = getstruct("hallway_obj_struct", "targetname");
      Objective_Position(1, struct.origin);

      flag_wait("nearing_bathroom_breach");
      SetSavedDvar("compass", "0");
      battlechatter_off("axis");
      MusicStop(3);
      wait(4);
      level notify("stop_objective_updating");

      Objective_Add(4, "current", &"GULAG_BREACH_THE_BATHROOM", breach_org());
      Objective_Current(4);
      SetSavedDvar("compass", "1");
      maps\_slowmo_breach::objective_breach(4, 2);

      wait_until_player_breaches_bathroom();
      battlechatter_on("axis");
      objective_complete(4);
      Objective_Current(1);
      Objective_OnEntity(1, level.soap);

      flag_wait("leaving_bathroom_vol2");
      wait(2);

    case "rescue":

      Objective_OnEntity(1, level.soap);

      flag_wait("player_approaches_rescue_breach");

      Objective_State(4, "active");
      maps\_slowmo_breach::objective_breach(4, 3);
      Objective_OnEntity(2, level.soap);
      Objective_Current(4);

      level waittill("breaching");
      setsaveddvar("compass", 0);

      flag_wait("price_rescued");
      flag_wait("escape_the_gulag");
      setsaveddvar("compass", 1);

      objective_complete(1);
      objective_complete(4);

    case "ending":
    case "run":
    case "cafe":
    case "evac":

      Objective_Add(6, "current", &"GULAG_ESCAPE", evac_obj_org());
      Objective_Current(6);

      flag_wait("exit_collapses");
      wait(0.25);

      SetSavedDvar("compass", 0);

      break;
    default:
      AssertMsg("No objectives set for this start point");
  }
}

gulag_startpoint_catchup_thread() {
  waittillframeend;
  start = level.start_point;

  if(is_default_start()) {
    return;
  }
  thread control_room_destructibles_turn_on();

  if(start == "intro") {
    return;
  }
  SetSavedDvar("compass", "0");
  SetSavedDvar("ammoCounterHide", 1);
  SetSavedDvar("hud_showStance", 0);
  SetSavedDvar("hud_drawhud", 1);

  if(start == "approach") {
    return;
  }
  flag_set("player_heli_uses_modified_yaw");

  gulag_player_loadout();
  wait(0.05);
  vision_set_fog_changes("gulag_circle", 1);

  car_blows_up = GetEnt("car_blows_up", "script_noteworthy");
  RadiusDamage(car_blows_up.origin, 1200, 5000, 5000);

  flag_set("approach_dialogue");
  flag_set("slamraam_gets_players_attention");

  flag_set("stab2_clear");

  if(start == "unload")
    return;
  if(start == "f15") {
    return;
  }
  thread armory_roach_is_down();

  SetSavedDvar("g_friendlyNameDist", 15000);
  SetSavedDvar("compass", "1");
  SetSavedDvar("ammoCounterHide", 0);
  SetSavedDvar("hud_showStance", 1);
  SetSavedDvar("hud_drawhud", 1);

  flag_set("stop_rotating_around_gulag");
  flag_set("player_heli_uses_modified_yaw");

  wait(0.05);
  vision_set_fog_changes("gulag", 1);

  if(start == "bhd") {
    return;
  }
  flag_set("access_control_room");
  flag_set("player_progresses_passed_ext_area");
  if(start == "control_room") {
    return;
  }
  remove_global_spawn_function("allies", ::no_grenades);

  maps\_compass::setupMiniMap("compass_map_gulag_2");

  add_global_spawn_function("axis", ::ambush_behavior);
  add_global_spawn_function("allies", ::enable_cqbwalk);

  flag_set("gulag_cell_doors_enabled");
  flag_set("enable_interior_fx");
  flag_set("disable_exterior_fx");
  flag_set("pre_armory_open");

  flag_set("spotlight_turns_on");
  flag_set("start_armory_music");
  if(start == "armory") {
    return;
  }
  thread player_riotshield_bash_hint();

  flag_set("access_control_room");
  flag_set("run_from_armory");

  if(start == "rappel") {
    return;
  }
  fog_set_changes("gulag_hallways");
  flag_set("cell_duty");
  flag_set("go_to_pipearea_postup");
  if(start == "tunnel") {
    return;
  }
  flag_set("nearing_bathroom_breach");
  flag_set("leaving_pipe_area");
  flag_set("advance_through_pipearea");
  flag_set("access_control_room");
  flag_set("control_room");
  flag_set("leaving_pipe_area");

  if(start == "bathroom") {
    return;
  }
  if(start == "so_showers") {
    return;
  }
  fog_set_changes("gulag");
  flag_set("player_enters_bathroom");

  maps\gulag_ending::gulag_ending_startpoint_catchup_thread();
}

gulag_music() {
  waittillframeend;

  switch (level.start_point) {
    case "default":
    case "intro":
      time = musicLength("gulag_intro");
      MusicPlayWrapper("gulag_intro", 0);
      wait time;

    case "approach":
    case "unload":
    case "f15":
    case "control_room":

      thread MusicLoop("gulag_intro_repeatable");

      flag_wait("start_armory_music");
      level notify("stop_music");
      MusicStop(3);
      wait 3;

    case "armory":
    case "rappel":
    case "tunnel":

      thread MusicLoop("gulag_armory");
      flag_wait("nearing_bathroom_breach");
      level notify("stop_music");
      MusicStop(5);

    case "bathroom":

      level waittill("breaching");
      wait 0.15;
      thread MusicLoop("gulag_showers");
      flag_wait("player_exited_bathroom");
      level notify("stop_music");
      MusicStop(3.1);
      wait 3.15;
      thread MusicLoop("gulag_sewer_loop");

    case "rescue":
      flag_wait("player_approaches_rescue_breach");
      level notify("stop_music");
      MusicStop(5.5);
      level waittill("breaching");

    case "ending":
    case "run":
    case "cafe":
      thread MusicPlaywrapper("gulag_liftoff1of2", 0);

    case "evac":
      flag_wait("player_falls_down");
      MusicStop(1);

      flag_wait("evac_begins");
      thread MusicPlaywrapper("gulag_liftoff2of2", 0);
      break;

    default:
      AssertMsg("No objectives set for this start point");
  }
}