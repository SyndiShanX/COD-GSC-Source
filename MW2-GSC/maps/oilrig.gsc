/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\oilrig.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_hud_util;
#include maps\_utility;
#include maps\_underwater;
#include maps\_vehicle;
#include maps\jake_tools;
#include maps\_anim;
#include maps\_slowmo_breach;

main() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  setDvar("breach_debug", "0");
  setDvar("breach_weapons", "1");

  setDvar("breach_requires_friendlies_in_position", "0");

  setDvar("hostage_missionfail", "1");
  initPrecache();

  level.squadsize = 3;
  level.droneCallbackThread = ::AI_drone_think;

  setDvarIfUninitialized("oilrig_debug", "0");
  level.goodFriendlyDistanceFromPlayerSquared = 512 * 512;
  level.oilrigStealth = false;
  level.pipesDamage = false;
  level.c4first = false;
  level.underwater = false;
  level.totalHostages = 6;
  level.spawnerCallbackThread = ::AI_think;
  level.EnemyHeli = undefined;
  level.C4locations = [];
  level.C4locationsIndex = 0;
  level.aColornodeTriggers = [];
  level.c4ToPlant = 3;
  level.hostages = 8;
  level.dronedeathanims = [];
  level.cosine["25"] = cos(25);
  level.cosine["35"] = cos(35);
  level.cosine["45"] = cos(45);
  level.cosine["60"] = cos(60);
  level.stealthDistanceSquared = 512 * 512;
  trigs = getEntArray("trigger_multiple", "classname");
  foreach(trigger in trigs) {
    if((isDefined(trigger.script_noteworthy)) && (getsubstr(trigger.script_noteworthy, 0, 10) == "colornodes")) {
      level.aColornodeTriggers = array_add(level.aColornodeTriggers, trigger);
    }
  }

  add_start("debug", ::start_debug, "debug");

  add_start("underwater", ::start_underwater, "underwater");

  add_start("surface", ::start_surface, "surface");

  add_start("rig", ::start_rig, "rig");

  add_start("deck1", ::start_deck1, "deck1");

  add_start("heli", ::start_heli, "ambush");

  add_start("deck2", ::start_deck2, "deck2");

  add_start("deck3", ::start_deck3, "deck3");

  add_start("escape", ::start_escape, "escape");
  default_start(::start_default);

  level.weaponClipModels = [];
  level.weaponClipModels[0] = "weapon_g36_clip";
  level.weaponClipModels[1] = "weapon_mini_uzi_clip";
  level.weaponClipModels[2] = "weapon_mp5_clip";
  level.weaponClipModels[3] = "weapon_g3_clip";
  level.weaponClipModels[4] = "weapon_ump45_clip";
  level.weaponClipModels[5] = "weapon_m16_clip";
  level.weaponClipModels[6] = "weapon_fn2000_clip";
  level.weaponClipModels[7] = "weapon_kriss_clip";
  level.weaponClipModels[8] = "weapon_rpd_clip";
  level.weaponClipModels[9] = "weapon_ak74u_clip";
  level.weaponClipModels[10] = "weapon_ak47_tactical_clip";
  level.weaponClipModels[11] = "weapon_dragunov_clip";
  level.weaponClipModels[12] = "weapon_saw_clip";
  level.weaponClipModels[13] = "weapon_famas_clip";

  maps\_c4::main();
  maps\_drone_civilian::init();
  maps\_attack_heli::preLoad();

  maps\oilrig_precache::main();

  maps\createart\oilrig_fog::main();
  maps\oilrig_fx::main();
  maps\createfx\oilrig_audio::main();

  maps\_load::main();

  maps\_stinger::init();
  maps\_slowmo_breach::slowmo_breach_init();
  maps\oilrig_anim::main();
  level thread maps\oilrig_amb::main();
  maps\_slowmo_breach::add_breach_func(::first_breach);

  flag_init("sdv_01_passing");

  flag_init("oilrig_mission_failed");
  flag_init("player_attached_to_sdv");
  flag_init("difficulty_initialized");
  flag_init("player_broke_stealth");
  flag_init("heli_safezones_setup");
  flag_init("intro_anim_sequence_starting");
  flag_init("open_dds_door");
  flag_init("sdv_02_at_end_of_path");
  flag_init("sdv_01_at_end_of_path");
  flag_init("player_is_surfacing");
  flag_init("player_is_done_swimming");
  flag_init("start_underwater_heli");

  flag_init("obj_stealthkill_given");
  flag_init("obj_stealthkill_complete");
  flag_init("obj_hostages_secure_given");
  flag_init("obj_hostages_secure_complete");
  flag_init("obj_c4_ambush_plant_given");
  flag_init("obj_c4_ambush_plant_complete");
  flag_init("obj_ambush_given");
  flag_init("obj_ambush_complete");
  flag_init("obj_explosives_locate_given");
  flag_init("obj_explosives_locate_complete");
  flag_init("player_has_started_planting_c4");
  flag_init("obj_escape_given");
  flag_init("obj_escape_complete");

  flag_init("player_approaching_oilrig_legs");
  flag_init("player_breaks_surface");
  flag_init("player_slitting_throat");

  flag_init("player_pulled_halfway_out_of_water");
  flag_init("player_looking_at_gear_friendlies");
  flag_init("enemy_lull_in_conversation");
  flag_init("player_looking_at_grate_guard");
  flag_init("start_surface_sequences");
  flag_init("player_in_position_for_stealth_kill");
  flag_init("player_performing_underwater_kill");
  flag_init("player_ready_to_be_helped_from_water");
  flag_init("player_looking_at_floating_body");
  flag_init("player_starting_stealth_kill");
  flag_init("player_done_being_helped_from_water");
  flag_init("lower_decks_closed_off");

  flag_init("player_dealing_with_rail");
  flag_init("player_looking_at_railing");
  flag_init("railing_patroller_dead");
  flag_init("lower_room_breached");
  flag_init("start_nagging_to_go_to_deck1");
  flag_init("heli_flyby_finished");

  flag_init("upper_room_breached");

  flag_init("trig_prisoner_sequence_failsafe");
  flag_init("friendlies_had_to_plant_C4");
  flag_init("ambush_c4_triggered");
  flag_init("ambush_enemies_spawned");
  flag_init("ambush_enemies_alerted");
  flag_init("ambush_enemies_alerted_prematurely");
  flag_init("ambush_enemies_approaching");
  flag_init("ambush_gate_opened");
  flag_init("enemies_discovered_bodies");

  flag_init("deck_2_heli_is_finished_intimidating");
  flag_init("player_shoots_or_aims_rocket_at_intimidating_heli");

  flag_init("zodiacs_evaced");

  flag_init("need_to_check_axis_death");
  flag_init("done_with_smoke_dialogue");
  flag_init("heli_not_killed_in_time");
  flag_init("smoke_thrown");
  flag_init("stop_smoke");
  flag_init("smoke_firefight");
  flag_init("top_deck_room_breached");
  flag_init("player_detonated_explosives");
  flag_init("derrick_room_getting_breached");
  flag_init("player_got_deck3_autosave");
  flag_init("left_deck3_dudes_spawned");

  flag_init("player_on_board_littlebird");
  flag_init("littlebird_escape_lifted_off");
  flag_init("littlebird_escape_spawned");
  flag_init("sub_comes_through_ice");
  flag_init("littlebird_escape_moving");
  flag_init("escape_littlebird_landed");

  battlechatter_off("allies");
  battlechatter_off("axis");

  array_thread(getEntArray("redshirt_trigger", "targetname"), ::redshirt_trigger_think);
  array_thread(getEntArray("compassTriggers", "targetname"), ::compass_triggers_think);
  setSavedDvar("r_specularColorScale", "1.4");
  thread init_air_vehicle_flags();
  level.playerCQBSpeed = 0.8;
  level.playerWaterSpeed = 0.1;
  level.playerSpeed = level.playerCQBSpeed;
  level.player set_speed(level.playerCQBSpeed);
  thread level_think();
  thread init_difficulty();
  disable_color_trigs();
  thread hideAll();
  fx_management();
  heli_targetnames = [];
  heli_targetnames[0] = "heli_ambush";
  heli_targetnames[1] = "heli_deck2";
  heli_targetnames[2] = "heli_patrol_02";
  thread vehicle_heli_setup(heli_targetnames);
  createthreatbiasgroup("player");
  createthreatbiasgroup("ignored");
  createthreatbiasgroup("oblivious");
  level.player setthreatbiasgroup("player");
  setignoremegroup("allies", "oblivious");
  setignoremegroup("axis", "oblivious");
  setignoremegroup("player", "oblivious");
  setignoremegroup("oblivious", "allies");
  setignoremegroup("oblivious", "axis");
  setignoremegroup("oblivious", "oblivious");

  array_thread(getEntArray("hostiles_ambush", "targetname"), ::add_spawn_function, ::ambush_patroller_think);

  array_thread(getEntArray("patroller", "script_noteworthy"), ::add_spawn_function, ::ai_patroller_think);
  array_thread(getEntArray("rappel", "script_noteworthy"), ::add_spawn_function, ::ai_rappel_think);
  array_thread(getEntArray("army", "script_noteworthy"), ::add_spawn_function, ::AI_army_think);
  array_spawn_function_noteworthy("turret_guys", ::AI_turret_guys_think);

  array_spawn_function_noteworthy("left_deck3_dudes", ::AI_left_deck3_dudes_think);
  array_thread(getvehiclenodearray("plane_sound", "script_noteworthy"), maps\_mig29::plane_sound_node);

  thread player_death();

  if(is_specialop()) {
    DDS = getEntArray("sub_dds_01", "targetname");
    DoorDDS = getEntArray("dds_door_01", "targetname");
    array_thread(DDS, ::hide_entity);
    array_thread(DoorDDS, ::hide_entity);
    DDS = getEntArray("sub_dds_02", "targetname");
    DoorDDS = getEntArray("dds_door_02", "targetname");
    array_thread(DDS, ::hide_entity);
    array_thread(DoorDDS, ::hide_entity);
  }
}

player_death() {
  level.player waittill("death", attacker);
  if((isDefined(attacker)) && (attacker.code_classname == "misc_turret")) {
    if(isSubStr(attacker.model, "little_bird")) {
      level notify("new_quote_string");
      setDvar("ui_deadquote", &"OILRIG_MISSIONFAIL_HELI_DEATH");
    }
  }
}

start_default() {
  start_underwater();
}

start_debug() {
  thread above_water_art_and_ambient_setup();
  initFriendlies("Rig");
  thread maps\_slowmo_breach::delete_breach(0);
  thread maps\_slowmo_breach::delete_breach(1);
  thread maps\_slowmo_breach::delete_breach(2);
  thread maps\_slowmo_breach::delete_breach(3);
  thread maps\_slowmo_breach::delete_breach(4);
  thread maps\_slowmo_breach::delete_breach(5);
  thread open_gate(true);
  level.player set_speed(1);

  eNodeIntro = getent("org_stealth_kill", "targetname");
  eSDV_02 = SDV_spawn("02", eNodeIntro);
  eSDV_02.origin = level.player.origin + (0, 0, 100);
  eSDV_02 thread maps\oilrig_fx::sdv02_fx();

  wait(3);

  eNodeIntro anim_first_frame_solo(eSDV_02, "intro_sequence");
}

start_underwater() {
  AA_intro_init();
}

start_surface() {
  flag_init("sdv_01_arriving");
  flag_set("sdv_01_arriving");
  killtrigger_ocean_off();
  flag_set("player_is_done_swimming");
  flag_set("player_breaks_surface");
  eNode = getent("org_stealth_kill", "targetname");
  grate_enemies_setup();
  level.player setorigin(eNode.origin + (0, -65, 0));
  level.player setplayerangles(eNode.angles);
  level.player disableweapons();
  thread player_breaks_surface();
  thread start_surface_notifies();
  wait(0.05);
  underwater_friendly_setup();
  thread AA_surface_init();
}

start_surface_notifies() {
  wait(1);
  i = 0;
  aArray = array_merge(level.sdvSquad01, level.sdvSquad02);
  while(1 < 100) {
    wait(0.05);
    foreach(guy in aArray) {
      guy notify("finished_swim_animation");
    }
    i++;
  }
}

start_rig(bDontSpawnFriendlies) {
  initFriendlies("Rig", bDontSpawnFriendlies);
  thread music_surface_to_first_breach();
  flag_set("player_slitting_throat");
  flag_set("player_ready_to_be_helped_from_water");
  thread AA_rig_init();
  thread killtrigger_ocean_on();
}

start_deck1() {
  thread killtrigger_ocean_on();
  thread above_water_art_and_ambient_setup();
  triggersEnable("colornodes_deck1", "script_noteworthy", true);
  initFriendlies("Deck1");
  thread AA_deck1_init();
  door_deck1 = getent("door_deck1", "targetname");
  door_deck1 open_door_deck1();
  door_deck1_opposite = getent("door_deck1_opposite", "targetname");
  door_deck1_opposite open_door_deck1_opposite();
  MusicPlayWrapper("oilrig_suspense_01_music_alt");
  flag_set("player_ready_to_be_helped_from_water");

  flag_set("obj_hostages_secure_given");
  flag_set("player_at_lower_breach");
  flag_set("railing_patroller_dead");
  flag_set("lower_room_breached");
  flag_set("lower_room_cleared");

  thread obj_hostages_secure();
}

start_heli() {
  thread killtrigger_ocean_on();
  thread above_water_art_and_ambient_setup();
  initFriendlies("Heli");
  thread maps\_slowmo_breach::delete_breach(0);
  thread maps\_slowmo_breach::delete_breach(1);
  thread maps\_slowmo_breach::delete_breach(2);
  thread maps\_slowmo_breach::delete_breach(3);
  thread open_gate(true);
  MusicPlayWrapper("oilrig_fight_music_01");
  thread AA_heli_init();
  level.player set_speed(1);
  battlechatter_on("axis");
  battlechatter_on("allies");
  flag_set("player_ready_to_be_helped_from_water");
}

start_deck2() {
  thread killtrigger_ocean_on();

  flag_set("player_at_stairs_to_deck_2");
  flag_set("player_approaching_deck_2");
  triggersEnable("colornodes_deck2", "script_noteworthy", true);
  thread above_water_art_and_ambient_setup();
  initFriendlies("Deck2");
  thread AA_deck2_init();
  level.player set_speed(1);
  battlechatter_on("axis");
  battlechatter_on("allies");
  flag_set("player_ready_to_be_helped_from_water");
}

start_deck3() {
  thread killtrigger_ocean_on();
  flag_set("player_at_stairs_to_top_deck");
  thread above_water_art_and_ambient_setup();
  initFriendlies("Deck3");
  thread AA_deck3_init();
  level.player set_speed(1);
  battlechatter_on("axis");
  battlechatter_on("allies");
  flag_set("player_ready_to_be_helped_from_water");

  flag_set("obj_explosives_locate_given");

  thread obj_explosives_locate();
}

start_escape() {
  thread maps\_slowmo_breach::delete_breach(0);
  thread maps\_slowmo_breach::delete_breach(1);
  thread maps\_slowmo_breach::delete_breach(2);
  thread maps\_slowmo_breach::delete_breach(3);
  thread maps\_slowmo_breach::delete_breach(4);
  thread maps\_slowmo_breach::delete_breach(5);
  thread open_gate(true);
  thread killtrigger_ocean_on();
  thread above_water_art_and_ambient_setup();
  initFriendlies("Escape");
  flag_set("barracks_cleared");
  level.player set_speed(1);
  thread AA_escape_init();
  flag_set("player_ready_to_be_helped_from_water");
  thread c4_barrels();
  wait(.5);
  level notify("A door in breach group 300 has been activated.");
}

above_water_art_and_ambient_setup() {
  Ambientstop();
  thread maps\_utility::set_ambient("ambient_oilrig_test_ext1");
  thread vision_set_fog_changes("oilrig_exterior_deck0", 0);
}

below_water_art_and_ambient_setup(bUseRigApproachFog) {
  Ambientstop();
  thread maps\_utility::set_ambient("amb_underwater_test1v1");

  if(isDefined(bUseRigApproachFog)) {
    vision_set_fog_changes("oilrig_underwater", 0);
    thread underwater_fog_approaching_rig(0);
  } else {
    thread vision_set_fog_changes("oilrig_underwater", 0);
  }
}

AA_intro_init() {
  enableforcedsunshadows();
  thread maps\_utility::set_ambient("amb_underwater_test1v1");

  level.underwater = true;
  killtrigger_ocean_off();

  thread underwater_friendly_setup();
  thread music_underwater();
  thread underwater_sequence();
  thread dialogue_underwater();
  thread grate_enemies_setup();
  thread player_breaks_surface();

  flag_wait("start_surface_sequences");
  thread AA_surface_init();
}

underwater_sequence() {
  thread underwater_set_culldist(0, 20000);
  underwater_box = getent("underwater_box", "targetname");
  underwater_box show();
  eNodeIntro = getent("org_stealth_kill", "targetname");
  assert(isDefined(eNodeIntro));

  black_overlay = create_client_overlay("black", 1);
  black_overlay.sort = 1000;
  black_overlay.foreground = false;

  thread underwater_hud_enable(true);
  thread enablePlayerWeapons(false);
  below_water_art_and_ambient_setup();

  eSub_01 = submarine_spawn("01", eNodeIntro);
  eSub_02 = submarine_spawn("02", eNodeIntro);
  eSub_02 thread submarine_rumble();
  eSDV_01 = SDV_spawn("01", eNodeIntro);
  eSDV_02 = SDV_spawn("02", eNodeIntro);
  eSub_01 thread maps\oilrig_fx::submarine01_fx();
  eSub_02 thread maps\oilrig_fx::submarine02_fx();
  eSDV_01 thread maps\oilrig_fx::sdv01_fx();
  eSDV_02 thread maps\oilrig_fx::sdv02_fx();

  aIntroVehicles = [];
  aIntroVehicles[0] = eSub_01;
  aIntroVehicles[1] = eSub_02;
  aIntroVehicles[2] = eSDV_01;
  aIntroVehicles[3] = eSDV_02;
  eNodeIntro anim_first_frame(aIntroVehicles, "intro_sequence");

  wait(1);

  level.player thread player_sdv_think(eSDV_01, eNodeIntro);

  wait(.5);
  array_thread(level.sdvSquad01, ::friendly_sdv_think, eSDV_01, eNodeIntro);
  array_thread(level.sdvSquad02, ::friendly_sdv_think, eSDV_02, eNodeIntro);

  wait(1);

  array_thread(level.effects_mid_decks, ::pauseEffect);
  array_thread(level.effects_top_deck, ::pauseEffect);

  flag_wait("player_attached_to_sdv");
  array_thread(level.players, ::player_scuba);
  flag_wait("open_dds_door");
  black_overlay fadeOverTime(5);
  black_overlay.alpha = 0;
  eSub_01.DoorDDS unlink();
  eSub_01.DoorDDS dds_door_open();
  wait(1);
  level.player PlayRumbleOnEntity("light_3s");
  wait(3.5);

  flag_set("intro_anim_sequence_starting");
  eNodeIntro anim_single(aIntroVehicles, "intro_sequence");
  flag_wait("sdv_01_passing");

  thread underwater_fog_approaching_rig(5);

  flag_wait("sdv_01_arriving");
  thread underwater_set_culldist(3, 3000);

  flag_wait("player_ready_to_be_helped_from_water");
  thread underwater_set_culldist(0, 0);

  eSub_01.body delete();
  eSub_01.prop delete();
  eSub_01.DDS delete();
  eSub_01.DoorDDS delete();
  eSub_01.DoorDDS.eDoorSeal delete();
  foreach(part in eSub_01.aDDSparts) {
    part delete();
  }
  eSub_01 delete();

  eSub_02.body delete();
  eSub_02.prop delete();
  eSub_02.DDS delete();
  eSub_02.DoorDDS delete();
  eSub_02 delete();
  eSDV_01 delete();
  eSDV_02 delete();

  underwater_box hide();
  iceberg = getent("iceberg", "targetname");
  iceberg hide();
}

underwater_slowview() {
  level endon("player_breaks_surface");
  while(!flag("player_breaks_surface")) {
    level.player shellshock("slowview", .1);
    wait(.1);
  }
}

underwater_friendly_setup() {
  initFriendlies("Rig", false, true);
  array_call(level.friendlies, ::hide);

  level.sdvSquad01 = [];
  level.sdvSquad01[0] = spawn_script_noteworthy("sdv01_pilot");
  level.sdvSquad01[0].animname = "sdv01_pilot";
  level.sdvSquad01[1] = spawn_script_noteworthy("sdv01_copilot");
  level.sdvSquad01[1].animname = "sdv01_copilot";
  level.sdvSquad01[2] = spawn_script_noteworthy("sdv01_swimmer1");
  level.sdvSquad01[2].animname = "sdv01_swimmer1";

  level.sdvSquad02 = [];
  level.sdvSquad02[0] = spawn_script_noteworthy("sdv02_pilot");
  level.sdvSquad02[0].animname = "sdv02_pilot";
  level.sdvSquad02[1] = spawn_script_noteworthy("sdv02_copilot");
  level.sdvSquad02[1].animname = "sdv02_copilot";
  level.sdvSquad02[2] = spawn_script_noteworthy("sdv02_swimmer1");
  level.sdvSquad02[2].animname = "sdv02_swimmer1";
  level.sdvSquad02[3] = spawn_script_noteworthy("sdv02_swimmer2");
  level.sdvSquad02[3].animname = "sdv02_swimmer2";

  array_thread(level.sdvSquad02, maps\_underwater::friendly_bubbles);
  array_thread(level.sdvSquad01, maps\_underwater::friendly_bubbles);

  flag_wait("sdv_01_arriving");
  wait(5);
  level.sdvSquad02[0] maps\_underwater::friendly_bubbles_stop();

  flag_wait("player_breaks_surface");

  array_thread(level.sdvSquad02, maps\_underwater::friendly_bubbles_stop);
  array_thread(level.sdvSquad01, maps\_underwater::friendly_bubbles_stop);
}

grate_enemies_setup() {
  eNodeIntro = getent("org_stealth_kill", "targetname");
  level.eNodeIntroDuplicate = spawn("script_origin", eNodeIntro.origin);
  level.eNodeIntroDuplicate.origin = eNodeIntro.origin;
  level.eNodeIntroDuplicate.angles = eNodeIntro.angles;

  level.hostile_stealthkill_player = spawn_targetname("hostile_stealthkill_player");
  level.hostile_stealthkill_friendly = spawn_targetname("hostile_stealthkill_friendly");
  level.hostile_stealthkill_player.animname = "hostile_stealthkill_player";
  level.hostile_stealthkill_friendly.animname = "hostile_stealthkill_friendly";
  level.hostile_stealthkill_player thread grate_enemies_wait_to_be_killed();
  level.hostile_stealthkill_friendly thread grate_enemies_wait_to_be_killed();

  level.eNodeIntroDuplicate thread delete_on_flag("lower_room_breached");
}

delete_on_flag(flag) {
  self endon("death");
  flag_wait(flag);
  if(isDefined(self)) {
    self delete();
  }
}

grate_enemies_wait_to_be_killed() {
  self.ignoreme = true;
  level.eNodeIntroDuplicate thread anim_loop_solo(self, "grate_idle", "stop_idle");
}

heli_patrol() {
  flag_wait("start_underwater_heli");
  flag_wait("sdv_02_arriving");
  eHeli = spawn_vehicle_from_targetname("heli_patrol_01");
  eHeli thread heli_patrol_think();
  thread maps\_vehicle::gopath(eHeli);
  eHeli waittill("reached_dynamic_path_end");
  eHeli delete();
}

DDS_water_rise() {
  wait(1);
  movetime = 10;
  moveDist = 20;
  self moveTo(self.origin + (0, 0, moveDist), movetime, 1, 1);
  wait(movetime);
  self delete();
}
submarine_rumble() {
  self endon("death");
  org = spawn("script_origin", self.origin + (0, -900, -1800));
  org linkto(self);
  while(!flag("player_ready_to_be_helped_from_water")) {
    org PlayRumbleOnEntity("mig_rumble");
    wait(.4);
  }
  org delete();
}

dialogue_underwater() {
  wait(8);

  wait(2);

  flag_set("open_dds_door");
  wait(10);

  wait(5);

  flag_wait("sdv_01_passing");

  wait(3);
  flag_set("player_approaching_oilrig_legs");
  flag_set("start_underwater_heli");
  wait(3);

  flag_wait("sdv_02_arriving");
  flag_set("start_surface_sequences");

  wait(3);

  thread maps\_introscreen::oilrig_intro2();

  flag_wait("sdv_01_stopping");

  wait(5);
}

player_sdv_think(eSDV, eNodeIntro) {
  level.player disableweapons();
  level.player allowcrouch(false);
  level.player allowprone(false);
  level.player allowsprint(false);
  level.player allowjump(false);

  ePlayer_rig = spawn_anim_model("player_rig");
  ePlayer_rig thread underwater_player_flags();
  eSDV anim_first_frame_solo(ePlayer_rig, "underwater_player_start", "origin_animate_jnt");
  ePlayer_rig linkto(eSDV, "origin_animate_jnt");

  level.player setorigin(ePlayer_rig gettagorigin("tag_player"));
  level.player setplayerangles(ePlayer_rig gettagangles("tag_player"));
  wait(1);

  level.player PlayerLinkToDelta(ePlayer_rig, "tag_player", 1, 55, 43, 5, 20, true);
  flag_set("player_attached_to_sdv");

  flag_wait("intro_anim_sequence_starting");
  eSDV thread anim_single_solo(ePlayer_rig, "underwater_player_start", "origin_animate_jnt");

  flag_wait("sdv_01_arriving");

  wait(4);

  wait(15.5);
  flag_set("player_breaks_surface");
  ePlayer_rig hide();
  flag_wait("player_is_done_swimming");
  ePlayer_rig delete();
}

player_breaks_surface() {
  eNodeIntro = getent("org_stealth_kill", "targetname");
  assert(isDefined(eNodeIntro));

  grate_blocker = getent("grate_blocker", "targetname");
  assert(isDefined(grate_blocker));
  grate_blocker hide();
  grate_blocker notsolid();

  flag_wait("player_breaks_surface");
  array_thread(level.players, ::stop_player_scuba);
  level.player StopSounds();
  thread above_water_art_and_ambient_setup();
  level.player thread play_sound_on_entity("surface_breathe");
  thread play_sound_in_space("player_break_surface", level.player.origin);
  thread player_surface_blur();

  thread water_bob();
}

water_bob() {
  org_water_level = getent("org_water_level", "targetname");
  org_water_level.origin = org_water_level.origin + (0, 0, 0);
  org_view_bob = spawn("script_origin", (0, 0, 0));

  org_view_bob.origin = level.player.origin + (0, 0, 10);
  org_view_bob.angles = org_water_level.angles;

  waterMoveModel = spawn("script_model", org_view_bob.origin);
  waterMoveModel setModel("tag_origin");
  waterMoveModel.origin = org_view_bob.origin;
  waterMoveModel.angles = org_view_bob.angles;

  org_view_bob thread view_bob();
  org_view_bob thread view_rotate();
  waterMoveModel thread water_movement(org_view_bob);

  timer = 1;

  zOffset = 9;
  waterMoveModel.origin = level.player.origin + (0, 0, zOffset);
  org_view_bob.origin = level.player.origin + (0, 0, zOffset);

  waterMoveModel lerp_player_view_to_tag_oldstyle(level.player, "tag_origin", timer, 1, 90, 90, 50, 4);

  delaythread(0, ::open_up_player_fov, waterMoveModel, "tag_origin");
}

open_up_player_fov(view_arms, tag) {
  level.player PlayerLinkToDelta(view_arms, tag, 0.0, 90, 90, 50, 4, true);
}

view_bob() {
  self endon("death");
  movetime = 2.4;
  moveDist = 3.2;
  self moveTo(self.origin + (0, 0, moveDist / 2), movetime, 1, 1);
  wait(movetime);

  while(isDefined(self)) {
    self moveTo(self.origin + (0, 0, moveDist * (-1)), movetime, 1, 1);
    wait(movetime);
    self moveTo(self.origin + (0, 0, moveDist), movetime, 1, 1);
    wait(movetime);
  }
}

view_rotate() {
  self endon("death");
  rotaterollangle = 4;
  rotateTime = 6;
  self rotateRoll(rotaterollangle / 2, rotateTime, rotateTime / 2, rotateTime / 2);
  wait(rotateTime);

  while(isDefined(self)) {
    self rotateRoll(rotaterollangle * (-1), rotateTime, rotateTime / 2, rotateTime / 2);
    wait(rotateTime);
    self rotateRoll(rotaterollangle, rotateTime, rotateTime / 2, rotateTime / 2);
    wait(rotateTime);
  }
}

water_movement(org_view_bob) {
  moveRate = 1;
  updateTime = 0.05;

  org_grate_top_left = getent("org_grate_top_left", "targetname");
  org_grate_bot_right = getent("org_grate_bot_right", "targetname");

  maxValueX = org_grate_top_left.origin[0];
  maxValueY = org_grate_bot_right.origin[1];

  minValueX = org_grate_bot_right.origin[0];
  minValueY = org_grate_top_left.origin[1];

  valueX = undefined;
  valueY = undefined;
  valueZ = undefined;

  while(!flag("player_ready_to_be_helped_from_water")) {
    wait(updateTime);
    movement = level.player GetNormalizedMovement();

    forward = anglesToForward(level.player.angles);
    right = anglesToRight(level.player.angles);

    forward *= movement[0] * moveRate;
    right *= movement[1] * moveRate;

    newLocation = self.origin + forward + right;
    newLocation = (newLocation[0], newLocation[1], org_view_bob.origin[2]);

    valueX = cap_value(newLocation[0], minValueX, maxValueX);
    valueY = cap_value(newLocation[1], minValueY, maxValueY);
    valueZ = org_view_bob.origin[2];
    newLocation = (valueX, valueY, valueZ);

    self.angles = (level.player.angles[0], level.player.angles[1], org_view_bob.angles[2]);
    self moveto(newLocation, updateTime, 0, 0);
  }
  if(isDefined(org_view_bob)) {
    org_view_bob delete();
  }
  if(isDefined(self)) {
    self delete();
  }
}

underwater_player_flags() {
  self waittillmatch("single anim", "end");
  flag_set("player_is_done_swimming");
}

friendly_sdv_think(eSDV, eNodeIntro) {
  eSDV anim_first_frame_solo(self, "sdv_ride_in", "origin_animate_jnt");
  self linkto(eSDV, "origin_animate_jnt");
  flag_wait("intro_anim_sequence_starting");

  eSDV thread anim_single_solo(self, "sdv_ride_in", "origin_animate_jnt");
  self waittillmatch("single anim", "end");
  self notify("finished_swim_animation");
}

AA_surface_init() {
  thread dialogue_stealth_kill();
  thread obj_stealthkill();
  thread music_surface_to_first_breach();
  thread enemy_dialogue();
  thread water_monitor();
  thread friendly_gear_takeoff();
  level.player thread player_grate_sequence_think();
  array_thread(level.sdvSquad01, ::friendly_surface_think);
  array_thread(level.sdvSquad02, ::friendly_surface_think);
  thread friendlies_help_player_from_water();
  thread show_friendlies_out_of_water();
  thread grate_enemy_setup();

  flag_wait("obj_stealthkill_complete");
  thread AA_rig_init();
}

water_monitor() {
  level endon("obj_stealthkill_complete");
  org_water_level = getent("org_water_level", "targetname");
  assert(isDefined(org_water_level));
  water_level = org_water_level.origin[2];

  flag_wait("player_starting_stealth_kill");
  thread water_vision_management();

  while(true) {
    wait(0.05);
    playerEye = level.player getEye();
    if(playerEye[2] < water_level) {
      level notify("player_is_below_water");
    } else {
      level notify("player_is_above_water");
    }
  }
}

water_vision_management() {
  level endon("obj_stealthkill_complete");
  while(true) {
    level waittill("player_is_below_water");
    below_water_art_and_ambient_setup(true);

    level waittill("player_is_above_water");
    above_water_art_and_ambient_setup();
    thread player_surface_blur();
  }
}

player_surface_blur() {
  level.player thread play_sound_in_space("splash_player_water_exit");
  thread water_streaks();
  SetBlur(3, .1);
  wait 0.25;
  SetBlur(0, .5);
}

water_streaks() {
  level.player SetWaterSheeting(1, 3.0);
}

friendlies_help_player_from_water() {
  eNodeIntro = getent("org_stealth_kill", "targetname");
  assert(isDefined(eNodeIntro));
  aWaterHelpers = [];
  aWaterHelpers[0] = get_AI_with_script_noteworthy("allies", "water_helper_01");
  aWaterHelpers[1] = get_AI_with_script_noteworthy("allies", "water_helper_02");
  aWaterHelpers[0].animname = "water_helper_01";
  aWaterHelpers[1].animname = "water_helper_02";

  eNodeIntro anim_first_frame(aWaterHelpers, "surface_helpout");
  flag_wait("player_ready_to_be_helped_from_water");
  eNodeIntro anim_single(aWaterHelpers, "surface_helpout");

  flag_wait("lower_room_breached");
  array_thread(aWaterHelpers, ::AI_delete);
}

show_friendlies_out_of_water() {
  flag_wait("player_looking_at_floating_body");
  array_call(level.friendlies, ::show);
}

enemy_dialogue() {
  level endon("player_starting_stealth_kill");

  flag_wait("player_breaks_surface");

  level.hostile_stealthkill_friendly dialogue_execute("oilrig_mrc1_killyou");

  flag_set_delayed("enemy_lull_in_conversation", 1);
  wait(.75);

  level.hostile_stealthkill_friendly thread dialogue_execute("oilrig_mrc1_givemeone");

  wait(1.5);

  level.hostile_stealthkill_player dialogue_execute("oilrig_mrc2_foff");

  flag_wait("obj_stealthkill_given");

  wait(.4);

  level.hostile_stealthkill_friendly dialogue_execute("oilrig_mrc1_limoallday");

  level.hostile_stealthkill_player dialogue_execute("oilrig_mrc2_complain");

  level.hostile_stealthkill_friendly dialogue_execute("oilrig_mrc1_theitalians");

  level.hostile_stealthkill_player dialogue_execute("oilrig_mrc2_noclue");
}

grate_enemy_setup() {
  level.hostile_stealthkill_player thread grate_enemy_think();
  level.hostile_stealthkill_friendly thread grate_enemy_think();
}

grate_enemy_think() {
  flag_wait("player_starting_stealth_kill");

  self waittillmatch("single anim", "grab");
  self stopSounds();
  wait(0.05);
  if(self.animname == "hostile_stealthkill_player") {
    self thread play_sound_on_entity("grate_enemy_grabbed_grunt_01");
  } else {
    self thread play_sound_on_entity("grate_enemy_grabbed_grunt_02");
  }

  self waittillmatch("single anim", "end");
  self delete();
}

dialogue_stealth_kill() {
  flag_wait("player_is_done_swimming");
  flag_wait("enemy_lull_in_conversation");

  dialogue_random_gratekill();

  flag_set("obj_stealthkill_given");
}

player_grate_sequence_think() {
  org_water_exit = getent("org_water_exit", "targetname");
  assert(isDefined(org_water_exit));
  org_water_exit.origin = org_water_exit.origin + (0, 0, 10);

  eNodeIntro = getent("org_stealth_kill", "targetname");
  assert(isDefined(eNodeIntro));
  flag_wait("player_is_done_swimming");

  SetSavedDvar("compass", "1");

  level.player set_speed(level.playerWaterSpeed);

  ePlayer_rig = spawn_anim_model("player_rig");
  ePlayer_rig thread player_kill_fx();
  ePlayer_rig hide();
  eNodeIntro anim_first_frame_solo(ePlayer_rig, "player_stealth_kill");

  thread grate_enemy_hint();
  thread player_looking_at_grate_guard_logic();
  waittill_player_triggers_stealth_kill();

  SetSavedDvar("compass", "0");
  level.hostile_stealthkill_player.useable = false;

  level.player PlayerLinkToBlend(ePlayer_rig, "tag_player", 1, 0, 0);

  wait(.5);
  flag_set("player_starting_stealth_kill");
  eNodeIntro thread anim_single_solo(ePlayer_rig, "player_stealth_kill");
  ePlayer_rig show();

  ePlayer_rig waittillmatch("single anim", "throat");
  flag_set("player_slitting_throat");

  ePlayer_rig waittillmatch("single anim", "teleport");
  flag_set("player_looking_at_floating_body");

  ePlayer_rig waittillmatch("single anim", "help");
  flag_set("player_ready_to_be_helped_from_water");

  flag_set_delayed("player_pulled_halfway_out_of_water", 2);

  ePlayer_rig waittillmatch("single anim", "end");

  level.player unlink();
  thread autosave_by_name("rig_start");
  ePlayer_rig delete();

  level.player thread lerp_player_view_to_position(org_water_exit.origin, org_water_exit.angles, .25, 1);

  flag_set("player_done_being_helped_from_water");
  thread underwater_hud_enable(false);

  array_thread(level.effects_underwater, ::pauseEffect);

  mantle_platform = getent("mantle_platform", "targetname");
  assert(isDefined(mantle_platform));
  mantle_platform show();
  mantle_platform solid();

  thread player_in_water_monitor();
  flag_set("obj_stealthkill_complete");
}

player_looking_at_grate_guard_logic() {
  level endon("player_starting_stealth_kill");
  bInFOV = undefined;
  trig_player_near_grate_guard = getent("trig_player_near_grate_guard", "script_noteworthy");
  org = getent(trig_player_near_grate_guard.target, "targetname");
  while(true) {
    wait(0.05);
    if(flag("player_near_grate_guard")) {
      bInFOV = within_fov(level.player getEye(), level.player getPlayerAngles(), org.origin, level.cosine["25"]);
      if(bInFOV) {
        flag_set("player_looking_at_grate_guard");
      } else {
        flag_clear("player_looking_at_grate_guard");
      }
    } else
      flag_clear("player_looking_at_grate_guard");
  }
}

grate_enemy_hint() {
  level endon("player_starting_stealth_kill");
  sHint = &"SCRIPT_PLATFORM_OILRIG_HINT_STEALTH_KILL";
  thread grate_enemy_hint_cleanup();
  while(!flag("player_starting_stealth_kill")) {
    flag_wait("player_looking_at_grate_guard");
    thread hint(sHint);
    flag_set("player_in_position_for_stealth_kill");

    while(flag("player_looking_at_grate_guard")) {
      wait(0.05);
    }

    flag_clear("player_in_position_for_stealth_kill");
    thread hint_fade();
  }
  thread hint_fade();
}

grate_enemy_hint_cleanup() {
  flag_wait("player_starting_stealth_kill");
  thread hint_fade();
}

waittill_player_triggers_stealth_kill() {
  while(!flag("player_starting_stealth_kill")) {
    wait(0.05);
    if((flag("player_looking_at_grate_guard")) && (level.player meleeButtonPressed())) {
      break;
    }
  }
}

player_in_water_monitor() {
  level notify("player_in_water");
  level endon("player_out_of_water");

  thread killtrigger_ocean_off();

  level.player allowcrouch(false);
  level.player allowprone(false);
  level.player allowsprint(false);
  level.player allowjump(false);
  level.player set_speed(level.playerWaterSpeed);
  level.player disableWeapons();

  trig_out_of_water = getent("trig_out_of_water", "targetname");
  assert(isDefined(trig_out_of_water));
  trig_out_of_water waittill("trigger");

  level.player allowcrouch(true);
  level.player allowprone(true);
  level.player allowsprint(true);
  level.player allowjump(true);
  level.player set_speed(level.playerCQBSpeed);
  level.player enableWeapons();

  trig_in_water = getent("trig_in_water", "targetname");
  assert(isDefined(trig_in_water));
  while(level.player isTouching(trig_in_water)) {
    wait(0.05);
  }
  thread player_out_of_water_monitor();
}

player_out_of_water_monitor() {
  level notify("player_out_of_water");
  level endon("player_in_water");
  level endon("lower_decks_closed_off");
  thread killtrigger_ocean_on();
  trig_in_water = getent("trig_in_water", "targetname");
  assert(isDefined(trig_in_water));
  trig_in_water waittill("trigger");

  level.player thread play_sound_in_space("splash_player_water_enter");
  thread player_in_water_monitor();
}

player_kill_fx() {
  flag_wait("player_starting_stealth_kill");
  wait(2.8);
  level.player thread play_sound_on_entity("stealth_kill_player");
}

friendly_surface_think() {
  eNodeIntro = getent("org_stealth_kill", "targetname");
  assert(isDefined(eNodeIntro));

  self waittill("finished_swim_animation");

  self unlink();

  if(self.animname == "sdv02_pilot") {
    level.eNodeIntroDuplicate thread anim_loop_solo(self, "surface_idle", "stop_idle");
  } else
    eNodeIntro thread anim_loop_solo(self, "surface_idle", "stop_idle");

  if(self.animname == "sdv02_pilot") {
    self thread underwater_stealth_kill();
  } else {
    flag_wait("player_looking_at_floating_body");
    self delete();
  }
}

friendly_gear_takeoff() {
  flag_wait("player_ready_to_be_helped_from_water");

  eGearNode = getent("node_gear_takeoff", "targetname");
  eGearNode anim_generic_first_frame(level.friendly02, "oilrig_seal_surface_rebreather_off_guy2");
  eGearNode anim_generic_first_frame(level.friendly03, "oilrig_seal_surface_rebreather_off_guy1");

  mask_remove_guy = undefined;
  foreach(guy in level.team2) {
    if((isDefined(guy.script_noteworthy)) && (guy.script_noteworthy == "mask_remove_guy")) {
      mask_remove_guy = guy;
      break;
    }
  }

  mask_remove_guy anim_generic_first_frame(mask_remove_guy, "oilrig_seal_surface_mask_off");
  tempNode = spawn("script_origin", mask_remove_guy gettagorigin("TAG_ORIGIN"));
  tempNode.angles = mask_remove_guy gettagangles("TAG_ORIGIN");
  thread maps\oilrig_anim::scuba_gear_removal("mask_off_oilrig_seal_surface_mask_off", "oilrig_seal_surface_mask_off_prop", tempNode, "player_pulled_halfway_out_of_water");
  mask_remove_guy setgoalpos(mask_remove_guy.origin);

  level.friendly02.disableexits = true;
  level.friendly03.disableexits = true;
  level.friendly02.disablearrivals = true;
  level.friendly03.disablearrivals = true;

  level.friendly03.oldinterval = level.friendly03.interval;
  level.friendly03.interval = 40;

  level.friendly02.oldinterval = level.friendly03.interval;
  level.friendly02.interval = 40;

  eGearNode anim_generic_first_frame(level.friendly02, "oilrig_seal_surface_rebreather_off_guy2");
  eGearNode anim_generic_first_frame(level.friendly03, "oilrig_seal_surface_rebreather_off_guy1");
  thread maps\oilrig_anim::scuba_gear_removal("rebreather_off_oilrig_seal_surface_rebreather_off_guy2", "oilrig_seal_surface_rebreather_off_guy2_prop", eGearNode, "player_done_being_helped_from_water");
  thread maps\oilrig_anim::scuba_gear_removal("rebreather_off_oilrig_seal_surface_rebreather_off_guy1", "oilrig_seal_surface_rebreather_off_guy1_prop", eGearNode, "player_done_being_helped_from_water");

  flag_wait("player_pulled_halfway_out_of_water");

  mask_remove_guy thread anim_generic(mask_remove_guy, "oilrig_seal_surface_mask_off");

  flag_wait("player_done_being_helped_from_water");

  eGearNode thread anim_generic(level.friendly02, "oilrig_seal_surface_rebreather_off_guy2");
  eGearNode anim_generic(level.friendly03, "oilrig_seal_surface_rebreather_off_guy1");

  wait(2);
  level.friendly02.disableexits = false;
  level.friendly03.disableexits = false;
  level.friendly02.disablearrivals = false;
  level.friendly03.disablearrivals = false;

  flag_wait("player_at_lower_breach");

  level.friendly02.interval = level.friendly02.oldinterval;
  level.friendly03.interval = level.friendly03.oldinterval;

  flag_wait("lower_room_breached");
  mask_remove_guy thread AI_delete();
  tempNode delete();
}

player_looking_at_gear_friendlies(eGearNode) {
  level endon("player_approaching_gear_friendlies");
  level endon("player_looking_at_gear_friendlies");
  bInFOV = undefined;
  while(true) {
    wait(0.05);
    bInFOV = within_fov(level.player getEye(), level.player getPlayerAngles(), eGearNode.origin, level.cosine["25"]);
    if(bInFOV) {
      flag_set("player_looking_at_gear_friendlies");
    }
  }
}

underwater_stealth_kill() {
  aStealthKillActors = [];
  aStealthKillActors[0] = self;
  aStealthKillActors[1] = level.hostile_stealthkill_player;
  aStealthKillActors[2] = level.hostile_stealthkill_friendly;

  flag_wait("player_starting_stealth_kill");

  level.eNodeIntroDuplicate notify("stop_idle");
  level.eNodeIntroDuplicate anim_single(aStealthKillActors, "stealth_kill");

  self waittillmatch("single anim", "end");
  if(isDefined(self.magic_bullet_shield)) {
    self stop_magic_bullet_shield();
  }
  self delete();

  fin_remove_guy = undefined;
  foreach(guy in level.team2) {
    if((isDefined(guy.script_noteworthy)) && (guy.script_noteworthy == "fin_remove_guy")) {
      fin_remove_guy = guy;
      break;
    }
  }
  level.eNodeIntroDuplicate anim_generic_first_frame(fin_remove_guy, "oilrig_seal_surface_fins_off");
  thread maps\oilrig_anim::scuba_gear_removal("fins_off_oilrig_seal_surface_fins_off", "oilrig_seal_surface_fins_off_prop", level.eNodeIntroDuplicate, "player_ready_to_be_helped_from_water");
  fin_remove_guy setgoalpos(fin_remove_guy.origin);
  flag_wait("player_ready_to_be_helped_from_water");

  level.eNodeIntroDuplicate anim_generic(fin_remove_guy, "oilrig_seal_surface_fins_off");

  fin_remove_guy enable_ai_color();

  flag_wait("lower_room_breached");
  fin_remove_guy thread AI_delete();
}

AA_rig_init() {
  level.slomoBasevision = "oilrig_interior";
  triggersEnable("colornodes_rig", "script_noteworthy", true);
  thread oilrig_stealth_monitor_on(true);
  thread obj_hostages_secure();
  thread door_to_deck1_think();
  thread first_breach_ambient_guys();
  thread music_lower_room_to_upper_room();
  thread railing_patroller();
  thread breach_lower_setup();
  thread dialogue_rig_to_first_breach();
  thread dialogue_nag_to_deck1();
  thread friendly_speed_adjustment_breach_01();
  thread friendlies_shielded_during_breach("lower_room_breached", "lower_room_cleared");
  flag_wait("lower_room_cleared");
  disableforcedsunshadows();
  thread AA_deck1_init();
}

friendly_speed_adjustment_breach_01() {
  flag_wait("player_at_lower_breach");
  friendly_speed_adjustment_on();
  flag_wait("lower_room_breached");
  friendly_speed_adjustment_off();
}

door_to_deck1_think() {
  flag_wait("lower_room_breached");
  volume_first_room = getent("volume_first_room", "script_noteworthy");

  wait(2);
  eNode = getnode("node_deck1_door", "targetname");
  level.teamleader disable_ai_color();
  flag_wait("lower_room_cleared");
  wait(.5);
  level.teamleader setgoalnode(eNode);

  door_deck1 = getent("door_deck1", "targetname");
  door_deck1 open_door_deck1();
  door_deck1_opposite = getent("door_deck1_opposite", "targetname");
  door_deck1_opposite open_door_deck1_opposite();

  flag_wait("player_approaching_deck1");
  level.teamleader enable_ai_color();
}

teleport_when_out_of_sight(eNode) {
  while(true) {
    wait(0.05);
    while(within_fov(level.player getEye(), level.player getPlayerAngles(), self.origin, level.cosine["45"])) {
      wait(0.1);
    }
    if(distance(self.origin, level.player.origin) > 512) {
      break;
    }
  }

  self forceTeleport(eNode.origin, eNode.angles);
  self setgoalpos(self.origin);
  self setgoalnode(eNode);
}

first_breach_ambient_guys() {
  flag_wait("player_at_lower_breach");

  sound_org = getent("origin_breach1_dialogue", "targetname");
  sound_org thread play_loop_sound_on_entity("oilrig_muffled_breach_voices");
  aSpawners = getEntArray("hostiles_ambient_breach1", "targetname");
  aHostiles = array_spawn(aSpawners);
  array_thread(aHostiles, ::premature_kill_missionfail, sound_org);
  level waittill("A door in breach group 100 has been activated.");
  thread oilrig_stealth_monitor_off();

  array_call(aHostiles, ::delete);
  level waittill("breach_explosion");
  flag_set("lower_room_breached");
  sound_org notify("stop sound" + "oilrig_muffled_breach_voices");
  thread enemy_breach_dialogue(sound_org, 100);
}

dialogue_get_amped_on_stairway() {
  level endon("player_at_lower_breach");

  wait(randomfloatrange(4, 6));
  while(flag("player_dealing_with_rail")) {
    wait(.5);
  }

  radio_dialogue("oilrig_nsl_keepittight");

  wait(randomfloatrange(6, 8));
  while(flag("player_dealing_with_rail")) {
    wait(.5);
  }

  radio_dialogue("oilrig_nsl_readyweapons");

  wait(randomfloatrange(6, 8));
  while(flag("player_dealing_with_rail")) {
    wait(.5);
  }

  radio_dialogue("oilrig_nsl_moveup2");
}

dialogue_rig_to_first_breach() {
  level endon("mission failed");

  radio_dialogue("oilrig_nsl_sect1alpha");

  flag_set("obj_hostages_secure_given");

  thread dialogue_railing();

  thread dialogue_get_amped_on_stairway();

  flag_wait("railing_patroller_dead");

  wait(2);

  flag_wait("player_at_lower_breach");

  radio_dialogue("oilrig_nsl_tm1tobreach");

  thread dialogue_breach_nag(100);

  flag_wait("lower_room_cleared");

  radio_dialogue("oilrig_nsl_wereclear");

  iRand = randomint(2);

  radio_dialogue("oilrig_deck2_movenag_start");

  flag_set("start_nagging_to_go_to_deck1");

  flag_wait("player_above_first_breach_room");

  radio_dialogue("oilrig_nsl_eyesopen");
}

dialogue_nag_to_deck1() {
  level endon("upper_room_breached");
  flag_wait("start_nagging_to_go_to_deck1");

  volume_first_room = getent("volume_first_room", "script_noteworthy");
  while(!flag("upper_room_breached")) {
    if(level.player istouching(volume_first_room)) {
      dialogue_random_manhandler_nag_to_deck1();
    }
    wait(randomfloatrange(8, 14));
  }
}

dialogue_random_manhandler_nag_to_deck1() {
  iRand = randomint(4);
  radio_dialogue("room1_manhandler_nag_0" + iRand);
}

dialogue_railing() {
  level endon("mission failed");

  level endon("railing_patroller_dead");

  array_thread(level.players, ::is_player_looking_at_railing);
  flag_wait_either("player_looking_at_railing", "player_at_lower_breach");

  if(!flag("railing_patroller_dead")) {
    flag_set("player_dealing_with_rail");

    flag_clear("player_dealing_with_rail");
  }

  if(!flag("railing_patroller_dead")) {
    flag_set("player_dealing_with_rail");

    radio_dialogue("oilrig_nsl_suppweapons");
    flag_clear("player_dealing_with_rail");
  }
}

is_player_looking_at_railing() {
  self endon("death");
  level endon("railing_patroller_dead");
  level endon("player_at_lower_breach");
  level endon("player_looking_at_railing");

  railing_org = getent("railing_org", "targetname");
  while(true) {
    wait(.25);
    if(self adsButtonPressed()) {
      playerEye = self getEye();
      if(within_fov(playerEye, self getPlayerAngles(), railing_org.origin, level.cosine["25"])) {
        flag_set("player_looking_at_railing");
      }
    }
  }
}

railing_patroller() {
  level endon("stealth_broken");

  aSpawners = getEntArray("hostile_railing", "targetname");
  eSpawner = aSpawners[randomintrange(0, 2)];
  ePatroller = eSpawner spawn_ai();
  ePatroller.ignoreme = true;
  ePatroller.animname = "generic";
  ePatroller thread body_splash();
  level.railingdude = ePatroller;
  eNode = getnode(ePatroller.target, "targetname");
  eNode thread anim_generic_loop(ePatroller, "oilrig_balcony_smoke_idle", "stop_idle");
  ePatroller thread maps\_props::attach_cig_self();
  ePatroller thread magic_bullet_shield();
  thread friendly_aims_at_railing_guy(ePatroller);
  ePatroller thread railing_patroller_react(eNode);
  ePatroller thread railing_patroller_player_detect();
  ePatroller waittill("damage");
  ePatroller setContents(0);
  ePatroller.scriptedDying = true;
  flag_set("railing_patroller_dead");
  thread move_breach_safe_volumes();

  eNode notify("stop_idle");
  eNode thread play_sound_in_space("railing_death_sound");
  eNode anim_generic(ePatroller, "railing_death");
  ePatroller stop_magic_bullet_shield();
  ePatroller kill();
  ePatroller delete();
}

railing_patroller_player_detect() {
  self endon("death");
  level endon("railing_patroller_dead");
  flag_wait_either("player_alerted_railing", "player_broke_stealth");
  wait(2);
  level notify("stealth_broken");
  eNode = getnode(self.target, "targetname");
  eNode notify("stop_idle");
  self notify("stop_idle");
  self anim_stopanimscripted();
  battlechatter_on("axis");
  ignoreme_off_squad_and_player();
}

move_breach_safe_volumes() {
  first_breach_safe_volumes = getEntArray("first_breach_safe_volumes", "targetname");
  foreach(volume in first_breach_safe_volumes) {
    volume.origin = volume.origin + (0, 0, 20000);
  }
}

railing_patroller_react(eNode) {
  if(!isDefined(self)) {
    return;
  }
  level endon("railing_patroller_dead");
  level waittill("stealth_broken");
  eNode notify("stop_idle");
  self notify("stop_idle");
  self anim_stopanimscripted();
  battlechatter_on("axis");
  ignoreme_off_squad_and_player();
}

body_splash() {
  org_splash = spawn("script_origin", (0, 0, 0));
  self waittill("damage");
  self waittillmatch("single anim", "splash");
  org_splash.origin = self.origin;
  playFX(getfx("body_splash_railing"), org_splash.origin);
  org_splash play_sound_on_entity("scn_body_splash");
  wait(10);
  org_splash delete();
}

breach_lower_setup() {
  flag_wait("player_at_lower_breach");
  flag_wait("railing_patroller_dead");

  triggersEnable("colornodes_lower_breach", "script_noteworthy", true);
  activate_trigger_with_noteworthy("colornodes_lower_breach");

  wait(1.5);
  eNode = getnode("node_railing_friendly", "targetname");
  eNode notify("stop_idle");
  level.teamleader notify("stop_idle");
  level.teamleader enable_ai_color();
  level.teamleader pushplayer(false);
  level.teamleader maps\_slowmo_breach::add_slowmo_breacher();
  thread autosave_by_name("lower_breach");

  level waittill("A door in breach group 100 has been activated.");
  volume_first_room = getent("volume_first_room", "script_noteworthy");
  level.hostageNodes = getnodearray("node_hostage_bottom", "targetname");

  flag_wait("lower_room_cleared");

  array_thread(level.effects_mid_decks, ::restartEffect);

  wait(1);

  triggersEnable("colornodes_after_lower_breach", "script_noteworthy", true);
  triggersEnable("colornodes_deck1", "script_noteworthy", true);
  activate_trigger_with_noteworthy("colornodes_after_lower_breach");

  thread autosave_tactical();
}

friendly_aims_at_railing_guy(ePatroller) {
  level endon("railing_patroller_dead");

  eNode = getnode("node_railing_friendly", "targetname");
  assert(isDefined(eNode));
  level.teamleader disable_ai_color();
  level.teamleader pushplayer(true);
  level.teamleader setgoalnode(eNode);
  level.teamleader maps\_slowmo_breach::remove_slowmo_breacher();
  eNode anim_generic_reach(level.teamleader, "railing_execute_reach");
  eNode thread anim_generic_loop(level.teamleader, "railing_execute_idle", "stop_idle");
  flag_wait_either("player_alerted_railing", "player_broke_stealth");

  level.teamleader thread friendly_executes_railing_guy(ePatroller, eNode);
}

friendly_executes_railing_guy(ePatroller, eNode) {
  self notify("stop_idle");
  eNode notify("stop_idle");
  eNode thread anim_generic(self, "railing_execute_shoot");

  enemy_head_org = ePatroller gettagorigin("tag_eye");
  MagicBullet(self.weapon, self gettagorigin("tag_flash"), enemy_head_org);
  thread play_sound_in_space("bullet_impact_headshot", enemy_head_org);
  bullettracer(self gettagorigin("tag_flash"), enemy_head_org, true);
  self waittillmatch("single anim", "end");
  eNode thread anim_generic_loop(level.teamleader, "railing_execute_idle", "stop_idle");
}

AA_deck1_init() {
  array_thread(getEntArray("triggers_deck1_hall", "targetname"), ::trigger_on);
  thread friendlies_shielded_during_breach("upper_room_breached", "upper_room_cleared");
  thread friendly_speed_adjustment_breach_02();
  thread glowing_c4_think();
  thread music_ambush_to_deck_2();
  thread deck1_breach_ambient_guys();
  thread heli_flyby();
  thread balls_out_player_speed();
  thread upper_room_setup();
  thread dialogue_to_deck1();
  thread dialogue_heli_patrol_deck_1();
  thread dialogue_last_hostages();
  thread obj_c4_ambush_plant();
  thread obj_ambush();
  thread hostage_manhandle_sequence();
  thread ambush_sequence();
  thread ambush_c4_triggered();
  thread enemies_approach_ambush();
  thread ambush_dialogue();
  thread enemies_alerted();
}

friendly_speed_adjustment_breach_02() {
  flag_wait("lower_room_cleared");
  friendly_speed_adjustment_on();
  thread ignoreme_on_squad_and_player();
  flag_wait("upper_room_breached");
  friendly_speed_adjustment_off();
  thread ignoreme_off_squad_and_player();
}

deck1_breach_ambient_guys() {
  flag_wait("player_ignoring_heli_flyby");

  sound_org = getent("origin_ambush_discovery_dialogue", "targetname");
  sound_org thread play_loop_sound_on_entity("oilrig_muffled_breach_voices");
  aSpawners = getEntArray("hostiles_ambient_deckbreach", "targetname");
  aHostiles = array_spawn(aSpawners);
  array_thread(aHostiles, ::premature_kill_missionfail, sound_org);
  level waittill("A door in breach group 200 has been activated.");
  thread delete_first_breach_room_ai();

  thread oilrig_stealth_monitor_off();
  array_call(aHostiles, ::delete);
  level waittill("breach_explosion");
  flag_set("upper_room_breached");
  sound_org notify("stop sound" + "oilrig_muffled_breach_voices");
  thread enemy_breach_dialogue(sound_org, 200);
}

delete_first_breach_room_ai() {
  volume_first_room = getent("volume_first_room", "script_noteworthy");
  aAI_to_delete = volume_first_room get_ai_touching_volume();
  if(aAI_to_delete.size) {
    foreach(guy in aAI_to_delete) {
      if(isDefined(guy.magic_bullet_shield)) {
        guy stop_magic_bullet_shield();
      }
      guy delete();
    }
  }
}

heli_flyby() {
  flag_wait("player_approaching_deck1");
  eHeli = spawn_vehicle_from_targetname("heli_patrol_02");
  eHeli thread heli_patrol_think();
  flag_wait("player_at_door_to_deck1");
  thread maps\_vehicle::gopath(eHeli);

  thread oilrig_stealth_monitor_on(true);

  eHeli waittill("reached_dynamic_path_end");
  eHeli delete();
}

dialogue_to_deck1() {
  level endon("mission failed");

  level endon("player_at_door_to_deck1");
  flag_wait("player_approaching_deck1");
}

dialogue_heli_patrol_deck_1() {
  level endon("mission failed");

  flag_wait("player_at_door_to_deck1");

  dialogue_random_heliwarning_stealth();

  level endon("player_ignoring_heli_flyby");

  wait(4.5);

  flag_set("heli_flyby_finished");

  level endon("player_at_last_breach_building");

  dialogue_random_heli_all_clear();
}

balls_out_player_speed() {
  level waittill("A door in breach group 200 has been activated.");
  level.player set_speed(1);
}

upper_room_setup() {
  flag_wait_either("heli_flyby_finished", "player_ignoring_heli_flyby");
  level.slomoBasevision = "oilrig_exterior_deck1";
  triggersEnable("colornodes_upper_room_setup", "script_noteworthy", true);
  activate_trigger_with_noteworthy("colornodes_upper_room_setup");

  breach_upper_desk_triggers = getEntArray("breach_upper_desk", "targetname");
  array_thread(breach_upper_desk_triggers, ::breach_upper_desk_triggers_think);

  ambush_damage_triggers = getEntArray("ambush_damage_triggers", "targetname");
  array_thread(ambush_damage_triggers, ::ambush_damage_triggers_think);
}

ambush_damage_triggers_think() {
  flag_wait("ambush_c4_triggered");
  wait(2);
  self thread cause_damage_in_radius_trigger();
}

breach_upper_desk_triggers_think() {
  level endon("upper_room_cleared");
  while(!flag("upper_room_cleared")) {
    self waittill("trigger", other);
    if((isDefined(other.team)) && (other.team == "axis")) {
      RadiusDamage(self.origin, self.radius, 500, 500);
      break;
    }
  }
}

dialogue_last_hostages() {
  level endon("mission failed");

  volume_ambush_room = getent("volume_ambush_room", "script_noteworthy");
  volume_ambush_room endon("breached");

  flag_wait("player_at_last_breach_building");

  thread autosave_tactical();

  wait(4);
  thread dialogue_breach_nag(200);
}

ambush_sequence() {
  level endon("mission failed");
  level endon("missionfailed");

  radio = level.player;
  volume_ambush_room = getent("volume_ambush_room", "script_noteworthy");

  level waittill("A door in breach group 200 has been activated.");

  array_thread(level.effects_lower_rig, ::pauseEffect);
  array_thread(level.effects_underwater, ::pauseEffect);
  array_thread(level.effects_top_deck, ::pauseEffect);

  flag_wait("upper_room_breached");

  aFriendlyC4Orgs = [];
  aFriendlyC4Orgs[0] = getent("origin_c4_friendly", "targetname");
  aFriendlyC4Orgs[1] = getent("origin_c4_friendly2", "targetname");
  aC4Nodes = [];
  aC4Nodes[0] = getnode("ambush_guard_01", "targetname");
  aC4Nodes[1] = getnode("ambush_guard_02", "targetname");
  eFriendlyC4Org = getfarthest(level.player.origin, aFriendlyC4Orgs);
  eC4Node = getfarthest(level.player.origin, aC4Nodes);

  flag_set("lower_decks_closed_off");
  door_deck1 = getent("door_deck1", "targetname");
  door_deck1 close_door_deck1();
  door_deck1_opposite = getent("door_deck1_opposite", "targetname");
  door_deck1_opposite close_door_deck1_opposite();

  bottom_deck_destructibles = getEntArray("bottom_deck_destructibles", "script_noteworthy");
  array_thread(bottom_deck_destructibles, ::destructible_cleanup);

  aNodes = getnodearray("node_team2_scaffolding", "targetname");
  level.team2 = array_spawn(getEntArray("team2_escort", "targetname"), true);
  level.team2[0] thread teleport_ai(aNodes[0]);
  level.team2[1] thread teleport_ai(aNodes[1]);

  flag_wait("upper_room_cleared");

  array_thread(level.effects_top_deck, ::restartEffect);

  thread autosave_by_name("deck1_breach_finished");

  ac4Friendlies = [];
  ac4Friendlies[0] = level.friendly02;
  ac4Friendlies[1] = level.friendly03;
  c4Friendly = getfarthest(level.player.origin, ac4Friendlies);
  c4Friendly thread friendly_plant_c4(eFriendlyC4Org, eC4Node);

  flag_set("obj_hostages_secure_complete");

  radio_dialogue("oilrig_nsl_clear");

  level.teamleader cqb_walk("off");
  level.teamleader ClearEnemy();
  level.friendly02 cqb_walk("off");
  level.friendly02 ClearEnemy();
  level.friendly03 cqb_walk("off");
  level.friendly03 ClearEnemy();
  level.teamleader.alertlevel = "noncombat";
  level.friendly02.alertlevel = "noncombat";
  level.friendly03.alertlevel = "noncombat";

  radio play_sound_on_entity("oilrig_enc_maerhoffer");

  radio delaythread(5, ::play_sound_on_entity, "oilrig_enc_team5");

  wait(2);
  thread c4_nag(volume_ambush_room);
  flag_set("obj_c4_ambush_plant_given");
  thread autosave_by_name("obj_c4_ambush_plant_given");
  wait(2);

  level.teamleader thread teamleader_ambush_think();

  flag_wait("player_has_started_planting_c4");

  level.teamleader.alertlevel = "alert";
  level.friendly02.alertlevel = "alert";
  level.friendly03.alertlevel = "alert";
  level.friendly02 cqb_walk("on");
  level.friendly03 cqb_walk("on");

  flag_wait_or_timeout("obj_c4_ambush_plant_complete", 6);

  if(!flag("obj_c4_ambush_plant_complete")) {
    flag_set("obj_c4_ambush_plant_complete");
  }

  thread switch_player_weapons_to_loud_versions();

  thread autosave_by_name("c4_planted");

  radio_dialogue("oilrig_ns2_c4placed");
  triggersEnable("colornodes_ambush_setup", "script_noteworthy", true);
  activate_trigger_with_noteworthy("colornodes_ambush_setup");

  flag_set("obj_ambush_given");

  thread ambush_nag();

  flag_wait("ambush_enemies_spawned");

  level.teamleader thread force_weapon_when_player_not_looking("m4m203_reflex");
  level.friendly02 thread force_weapon_when_player_not_looking("mp5_reflex");
  level.friendly03 thread force_weapon_when_player_not_looking("mp5_reflex");

  thread oilrig_stealth_monitor_on();

  ignoreme_on_squad_and_player();

  flag_wait_either("ambush_enemies_alerted", "ambush_enemies_alerted_prematurely");
  thread oilrig_stealth_monitor_off();
  wait(1);
  ignoreme_off_squad_and_player();

  spawn_trigger_dummy("dummy_spawner_ballsout_intro");

  thread AA_heli_init();

  flag_wait("player_passing_ambush_gate");
  thread autosave_by_name("past_ambush_gate");
}

switch_player_weapons_to_loud_versions() {
  level endon("ambush_enemies_alerted");
  level endon("ambush_enemies_alerted_prematurely");
  level.player endon("death");
  swapped_thermal = false;
  swapped_m4 = false;
  while(true) {
    if((swapped_thermal == true) && (swapped_m4 == true)) {
      break;
    }
    wait(1);
    weaponList = level.player GetWeaponsListPrimaries();
    currentWeapon = level.player getCurrentWeapon();
    foreach(weapon in weaponList) {
      if((weapon == "scar_h_thermal_silencer") && (currentWeapon != "scar_h_thermal_silencer") && (swapped_thermal == false)) {
        level.player takeweapon("scar_h_thermal_silencer");
        level.player giveweapon("scar_h_thermal");
        swapped_thermal = true;
      }
      if((weapon == "m4m203_silencer_reflex") && (currentWeapon != "m4m203_silencer_reflex") && (swapped_m4 == false)) {
        level.player takeweapon("m4m203_silencer_reflex");
        level.player giveweapon("m4m203_reflex");
        swapped_m4 = true;
      }
    }
  }
}

hostage_manhandle_sequence() {
  prison_sequence_dummies_walk = getent("prison_sequence_dummies_walk", "script_noteworthy");
  prison_sequence_dummies_run = getent("prison_sequence_dummies_run", "script_noteworthy");
  walkReference = prison_sequence_dummies_walk;
  runReference = prison_sequence_dummies_run;
  lookatPoint = runReference.origin + (0, 0, 36);

  flag_wait("obj_c4_ambush_plant_given");

  volume_ambush_room = getent("volume_ambush_room", "script_noteworthy");
  aHostagesForSequence = volume_ambush_room get_ai_touching_volume("neutral");

  aWalkActors = [];
  aWalkActors[0] = level.team2[0];
  aWalkActors[1] = aHostagesForSequence[0];
  aWalkActors[0].animname = "manhandle_soldier_walk";
  aWalkActors[1].animname = "manhandle_prisoner_walk";

  aRunActors = [];
  aRunActors[0] = level.team2[1];
  aRunActors[1] = aHostagesForSequence[1];
  aRunActors[0].animname = "manhandle_soldier_run";
  aRunActors[1].animname = "manhandle_prisoner_run";

  flag_wait("player_has_started_planting_c4");

  while(within_fov(level.player getEye(), level.player getPlayerAngles(), aHostagesForSequence[0].origin, level.cosine["45"])) {
    wait(.1);
  }

  foreach(hostage in aHostagesForSequence) {
    hostage hide();
  }

  if(isDefined(level.manhandler)) {
    if(level.manhandler istouching(volume_ambush_room)) {
      if(isDefined(level.manhandler.magic_bullet_shield)) {
        level.manhandler stop_magic_bullet_shield();
      }
      level.manhandler delete();
    }
  }

  walkReference anim_first_frame(aWalkActors, "prisoner_manhandle_walk");
  runReference anim_first_frame(aRunActors, "prisoner_manhandle_run");

  foreach(hostage in aHostagesForSequence) {
    hostage show();
  }

  player_looking_at_prisoner_sequence = getent("player_looking_at_prisoner_sequence", "targetname");
  player_looking_at_prisoner_sequence trigger_on();

  thread trig_prisoner_sequence_failsafe();
  flag_wait_either("player_looking_at_prisoner_sequence", "trig_prisoner_sequence_failsafe");

  array_thread(aWalkActors, ::play_anim_and_delete, walkReference, "prisoner_manhandle_walk");
  array_thread(aRunActors, ::play_anim_and_delete, runReference, "prisoner_manhandle_run");
}

play_anim_and_delete(eAnimNode, sAnim) {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  eAnimNode anim_single_solo(self, sAnim);
  if(isDefined(self.magic_bullet_shield)) {
    self stop_magic_bullet_shield();
  }
  self delete();
}

trig_prisoner_sequence_failsafe() {
  trig_prisoner_sequence_failsafe = getent("trig_prisoner_sequence_failsafe", "targetname");
  trig_prisoner_sequence_failsafe waittill("trigger");
  flag_set("trig_prisoner_sequence_failsafe");
}

friendlies_go_loud() {
  self endon("death");
}

friendly_plant_c4(eAnimOrg, eNode) {
  self endon("death");
  level.player endon("death");
  level.player endon("death");
  c4 = getent(eAnimOrg.target, "targetname");
  assert(isDefined(c4));
  safeVolume = getent(c4.target, "targetname");
  assert(isDefined(safeVolume));

  self disable_ai_color();
  self cqb_walk("on");
  self setGoalNode(eNode);
  flag_wait("obj_c4_ambush_plant_given");
  wait(randomfloatrange(2, 4));

  eAnimOrg anim_generic_reach(self, "C4_plant_start");
  self setgoalpos(self.origin);
  while(level.player isTouching(safeVolume)) {
    wait(0.05);
  }

  eAnimOrg thread anim_generic(self, "C4_plant");

  wait(2);
  c4 show();
  playFXOnTag(getfx("light_c4_blink_nodlight"), c4, "tag_fx");
  c4 play_sound_on_entity("c4_bounce_default");
  self setGoalNode(eNode);
  flag_wait("obj_c4_ambush_plant_complete");

  self enable_ai_color();
  flag_wait("ambush_c4_triggered");
  c4 delete();
}

c4_ambush_hints() {
  level endon("ambush_c4_triggered");
  level endon("obj_explosives_locate_given");
  wait(2);
  thread c4_ambush_hints_cleanup();

  eTrig = getent("ambush_area", "targetname");
  bC4hint = false;
  bAmbushHint = false;
  while(true) {
    wait(0.05);
    if((level.player GetCurrentWeapon() != "c4") && (bC4hint == false) && (!flag("player_on_ladder"))) {
      wait(0.5);
      hint_fade();

      thread hint(&"OILRIG_HINT_C4_SWITCH");
      bC4hint = true;
      bAmbushHint = false;
    } else if((level.player GetCurrentWeapon() == "c4") && (bC4hint == true)) {
      hint_fade();
      bC4hint = false;
    }

    if((!level.player istouching(eTrig)) && (bAmbushHint == false) && (bC4hint == false)) {
      hint_fade();

      bAmbushHint = true;
      bC4hint = false;
    }

    if((level.player istouching(eTrig)) && (bAmbushHint == true) && (bC4hint == false)) {
      hint_fade();
      bAmbushHint = false;
    }
  }
}

c4_ambush_hints_cleanup() {
  flag_wait_either("ambush_c4_triggered", "obj_explosives_locate_given");
  thread hint_fade();
}

ambush_nag() {
  eTrig = getent("ambush_area", "targetname");
  eTrig endon("trigger");
  wait(randomintrange(14, 18));
}

teamleader_ambush_think() {
  eNode = getnode("node_guard_scaffolding", "targetname");
  self disable_ai_color();

  self setgoalnode(eNode);
  self.alertlevel = "alert";
  level.teamleader cqb_walk("on");

  flag_wait("obj_c4_ambush_plant_complete");
  aNodes = getnodearray("friendlyStartHeli", "targetname");
  eNode = undefined;
  foreach(node in aNodes) {
    if((isDefined(node.script_noteworthy)) && (node.script_noteworthy == "nodePrice")) {
      eNode = node;
      break;
    }
  }
  assert(isDefined(eNode));
  eTrig = getent("ambush_area", "targetname");
  eTrig waittill("trigger");

  if((flag("player_in_ambush_position")) || (flag("player_on_ladder"))) {
    eNode = getnode("node_guard_scaffolding", "targetname");
  }
  self.goalradius = 182;
  self setgoalnode(eNode);
}

c4_nag(volume_ambush_room) {
  level endon("obj_c4_ambush_plant_complete");
  level endon("player_has_started_planting_c4");

  wait(randomintrange(4, 6));

  wait(randomintrange(4, 6));

  wait(randomintrange(4, 6));

  wait(4);

  flag_set("friendlies_had_to_plant_C4");

  thread mission_fail_c4_not_planted();
}

mission_fail_c4_not_planted() {
  flag_set("oilrig_mission_failed");
  setDvar("ui_deadquote", &"OILRIG_MISSIONFAIL_EXPLOSIVES_NOTPLANTED");
  level notify("mission failed");
  maps\_utility::missionFailedWrapper();
}

glowing_c4_think(volume_ambush_room) {
  flag_wait("upper_room_breached");

  c4_hostiles = getEntArray("c4_hostiles", "targetname");
  c4_hostiles2 = getEntArray("c4_hostiles2", "targetname");
  c4_hostile_spawner = getfarthest(level.player.origin, c4_hostiles);
  c4_hostile_spawner2 = getfarthest(level.player.origin, c4_hostiles2);
  c4_hostile_spawner thread c4_drone_think("execution_slamwall_hostage_death");
  c4_hostile_spawner2 thread c4_drone_think("run_death_roll");
}

c4_drone_think(deathanim) {
  sAnim = level.scr_anim["generic"][deathanim];

  reference = self;
  c4_dead_drone = self spawn_ai();
  c4_dead_drone gun_remove();

  c4_player_on_deadguy = getent(c4_dead_drone.target, "targetname");
  reference anim_generic_first_frame(c4_dead_drone, deathanim);
  dummy = maps\_vehicle_aianim::convert_guy_to_drone(c4_dead_drone);
  dummy setanim(sAnim, 1, .2);
  dummy notsolid();

  flag_wait("obj_c4_ambush_plant_given");

  thread c4_think(c4_player_on_deadguy);

  flag_wait("ambush_c4_triggered");
  c4_player_on_deadguy notify("clear_c4");
  dummy delete();
}

c4_think(org_c4) {
  c4_model = org_c4 maps\_c4::c4_location(undefined, (0, 0, 0), (0, 0, 0), org_c4.origin);
  org_c4 thread obj_c4_ambush_think();
  org_c4 thread c4_delete_unplanted(c4_model);
  org_c4 waittill("c4_detonation");
  if(!flag("ambush_c4_triggered")) {
    flag_set("ambush_c4_triggered");
  }
}

c4_delete_unplanted(c4_model) {
  self endon("c4_planted");
  level endon("ambush_c4_triggered");
  flag_wait("obj_c4_ambush_plant_complete");
  c4_model thread hideC4();
}

hideC4() {
  self endon("death");
  self.trigger notify("trigger", level.player);
  self hide();
  wait(.15);
  stopFXOnTag(getfx("c4_light_blink"), self, "tag_fx");
}
ambush_c4_triggered() {
  volume_ambush_room = getent("volume_ambush_room", "script_noteworthy");
  volume_c4_ambush = getent("volume_c4_ambush", "targetname");
  flag_wait("ambush_c4_triggered");
  flag_set("ambush_enemies_alerted");
  fail_on_friendly_fire();
  thread play_sound_in_space("oilrig_ambush_explosion", volume_ambush_room.origin);
  earthquake(0.6, 2, level.player.origin, 1500);
  level.player PlayRumbleOnEntity("damage_heavy");
  exploder(1);
  if(level.player istouching(volume_ambush_room)) {
    playFX(getfx("player_death_explosion"), level.player.origin);
    level.player kill();
  }

  thread guy_blown_out_door();

  aAi = volume_ambush_room get_ai_touching_volume();
  foreach(guy in aAi) {
    if(isDefined(guy.magic_bullet_shield)) {
      guy stop_magic_bullet_shield();
    }

    if(guy is_in_array(level.squad, guy)) {
      level thread maps\_friendlyfire::missionfail();
      return;
    }

    guy dodamage(guy.health + 1000, guy.origin, level.player);
  }
  aAi = volume_c4_ambush get_ai_touching_volume();
  foreach(guy in aAi) {
    if((isDefined(guy)) && (isalive(guy))) {
      guy.flashingteam = "allies";
      guy flashBangStart(5);
    }
  }
  wait(1);
  thread ambush_room_aftermath();
  wait(5);
  normal_friendly_fire_penalty();
}

ambush_room_aftermath() {
  exploder("exploder_ambush_afterfx");

  light_ambush_room2 = getent("light_ambush_room2", "targetname");
  light_ambush_room2 thread fluorescentFlicker();

  light_ambush_room = getent("light_ambush_room", "targetname");
  light_ambush_room.lit_model = getent("light_ambush_room_model", "targetname");
  light_ambush_room.unlit_model = spawn("script_model", (0, 0, 0));
  light_ambush_room.unlit_model setModel("com_floodlight");
  light_ambush_room.unlit_model.origin = light_ambush_room.lit_model.origin;
  light_ambush_room.unlit_model.angles = light_ambush_room.lit_model.angles;
  light_ambush_room.linked_models = true;
  light_ambush_room.linked_lights = false;
  light_ambush_room thread maps\_lights::generic_flicker();

  wait(2);
  breach_room_2_destructible_triggers = getEntArray("breach_room_2_destructible_triggers", "script_noteworthy");
  array_thread(breach_room_2_destructible_triggers, ::cause_damage_in_radius_trigger);
}

cause_damage_in_radius_trigger() {
  if(!isDefined(self)) {
    return;
  }
  if(level.player istouching(self)) {
    return;
  }
  RadiusDamage(self.origin, self.radius, 500, 500);
  self delete();
}

fluorescentFlicker() {
  for(;;) {
    wait(randomfloatrange(.05, .1));
    self setLightIntensity(randomfloatrange(.25, 1));
  }
}

enemies_approach_ambush() {
  flag_wait("obj_c4_ambush_plant_complete");
  flag_wait_or_timeout("player_in_ambush_position", 8);
  wait(5);
  thread open_gate();
  aSpawners = getEntArray("hostiles_ambush", "targetname");
  aHostilesAmbush = array_spawn(aSpawners);
  flag_set("ambush_enemies_spawned");
  level endon("ambush_enemies_alerted_prematurely");
  eTrig = getent("ambush_enemies_approaching", "targetname");
  eTrig waittill("trigger");
  flag_set("ambush_enemies_approaching");
  eTrig = getent("enemies_discovered_bodies", "targetname");
  eTrig waittill("trigger");
  flag_set("enemies_discovered_bodies");
}

ambush_enemies_alerted_prematurely() {
  level endon("ambush_enemies_alerted");
  self waittill_alert();
  flag_set("ambush_enemies_alerted_prematurely");
}

waittill_alert() {
  self endon("death");
  self waittill_any("damage", "enemy", "alerted", "bulletwhizby", "flashbang", "grenade danger", "explode", "pain_death");
}

ambush_dialogue() {
  level endon("ambush_enemies_alerted_prematurely");
  level endon("ambush_c4_triggered");

  flag_wait("ambush_enemies_approaching");

  wait(.5);

  flag_wait("ambush_gate_opened");

  wait(1);

  aHostiles = getaiarray("axis");
  dude = getclosest(level.player.origin, aHostiles);
  org = dude.origin + (0, 0, -512);
  thread dialogue_random_pmc(org);

  wait(2);

  thread dialogue_random_pmc(org);

  flag_wait("enemies_discovered_bodies");
  wait(1);

  thread enemy_discovers_body_dialogue();

  wait(1);

  flag_set("ambush_enemies_alerted");
}

enemy_discovers_body_dialogue() {
  org = getent("origin_ambush_discovery_dialogue", "targetname");

  org thread play_sound_on_tag_endon_death("temp_vo_alarm");
  if(!flag("ambush_c4_triggered")) {
    flag_wait("ambush_c4_triggered");
    org delete();
  }
}

enemy_breach_dialogue(org, iRoomNumber) {
  iDialogueNumber = randomint(2);
  sSound = "oilrig_mrc_killhostages_room_" + iRoomNumber + "_0" + iDialogueNumber;
  wait(.5);
  eEnemy = get_closest_ai(level.player.origin, "axis");
  if(isDefined(eEnemy)) {
    eEnemy thread play_sound_on_tag_endon_death(level.scr_sound[sSound], "tag_origin");
  }
}

enemies_alerted() {
  flag_wait_either("ambush_enemies_alerted", "ambush_enemies_alerted_prematurely");
  battlechatter_on("axis");
  battlechatter_on("allies");
  wait(1.5);
  flag_set("obj_ambush_complete");
  alarm_org = getent("origin_alarm", "targetname");
  alarm_org playLoopSound("emt_oilrig_alarm_alert");
  wait(20);
  alarm_org stopLoopSound("emt_oilrig_alarm_alert");
  alarm_org delete();
}

guy_blown_out_door() {
  eSpawner = getent("hostile_c4_blowup", "targetname");
  eGuy = eSpawner spawn_ai();
  org = eGuy.origin + (0, 20, 35);
  eGuy.skipdeathanim = true;
  eGuy kill();
  wait(0.1);
  physicsExplosionSphere(org, 100, 50, 5);
}

AA_heli_init() {
  thread obj_explosives_locate();
  thread helicopter_dialogue();

  thread deck1_firefight();

  flag_wait("player_at_stairs_to_deck_2");
  thread AA_deck2_init();
}

deck1_firefight() {
  triggersEnable("colornodes_deck1_postbreach", "script_noteworthy", true);

  flag_wait("obj_explosives_locate_given");

  level.friendly03 setFlashbangImmunity(false);
  level.friendly03 maps\_slowmo_breach::remove_slowmo_breacher();
  level.friendly03 thread stop_magic_bullet_shield();
  assertex(level.breachfriendlies.size == 2, "level.breachfriendlies should only include 2 people at this point. It includes " + level.breachfriendlies.size);
}

helicopter_dialogue() {
  battlechatter_off("allies");
  wait(2);

  thread autosave_by_name("ambush_been_triggered");

  radio_dialogue("oilrig_sbc_possibleexpl");

  radio_dialogue("oilrig_sbc_secthatloc");

  flag_set("obj_explosives_locate_given");

  thread radio_dialogue("oilrig_nsl_centcom");

  spawn_trigger_dummy("dummy_spawner_ballsout");

  array_thread(level.squad, ::enable_ai_color);
  array_thread(level.squad, ::cqb_walk, "off");
  wait(2);
  triggersEnable("colornodes_heli_deck1", "script_noteworthy", true);
  activate_trigger_with_noteworthy("colornodes_heli_deck1");

  wait(3);
  battlechatter_on("allies");

  radio_dialogue("oilrig_nsl_move2");
}

heli_ramp_up_damage(eHeli) {
  if(level.gameskill > 1) {
    return;
  }

  heli_damage_delay = 1.25;
  heli_damage_ramp_loops = 20;

  if(level.gameskill == 0) {
    heli_damage_delay = 2.5;
    heli_damage_ramp_loops = 40;
  }

  i = 0;

  while((isDefined(eHeli)) && (i < heli_damage_ramp_loops)) {
    level.player waittill("damage", amount, attacker);
    if(!isDefined(eHeli)) {
      break;
    }
    if(!isDefined(eHeli.mgturret)) {
      break;
    }
    if((isDefined(attacker)) && (isDefined(eHeli.mgturret)) && (is_in_array(eHeli.mgturret, attacker))) {
      level.player enableInvulnerability();
      wait(heli_damage_delay);
      i++;
      heli_damage_delay = heli_damage_delay / 1.3;
      level.player disableInvulnerability();
    }
  }
  level.player disableInvulnerability();
}

heli_kill_nag(eHeli, sEndFlag) {
  level endon(sEndFlag);
  level endon("player_at_end_of_deck2");
  iDialogueNumberNoRocket = 1;
  iLastDialogueNumberNoRocket = 1;
  iDialogueNumber = 1;
  iLastDialogueNumber = 1;

  while(!flag(sEndFlag)) {
    wait(randomfloatrange(15, 25));

    if((isDefined(eHeli)) && (isDefined(eHeli.firingguns)) && (eHeli.firingguns == true)) {
      while((isDefined(eHeli.firingguns)) && (eHeli.firingguns == true)) {
        wait(.5);
      }
    }

    if(!level.player player_using_missile()) {
      while(iDialogueNumberNoRocket == iLastDialogueNumberNoRocket) {
        wait(0.05);
        iDialogueNumberNoRocket = randomint(5);
      }
      if(flag(sEndFlag)) {
        break;
      }
      radio_dialogue("oilrig_nsl_takeoutbird_0" + iDialogueNumberNoRocket);
      iLastDialogueNumberNoRocket = iDialogueNumberNoRocket;
    } else {
      while(iDialogueNumber == iLastDialogueNumber) {
        wait(0.05);
        iDialogueNumber = randomint(4);
      }
      if(flag(sEndFlag)) {
        break;
      }
      radio_dialogue("oilrig_nsl_takeoutbird_withrocket_0" + iDialogueNumber);
      iLastDialogueNumber = iDialogueNumber;
    }
  }
}

AA_deck2_init() {
  thread music_deck2_to_deck3();
  thread ai_cleanup();
  thread dialogue_deck2();
  thread zodiacs_evac();
  thread heli_deck2_harass();
  thread rappel_firefight();

  flag_wait("player_at_end_of_deck2");
  thread ai_cleanup();
  thread AA_deck3_init();
}

dialogue_deck2() {
  flag_wait("player_at_deck1_midpoint");

  battlechatter_off("allies");

  thread autosave_by_name("deck2_start");

  wait(randomfloatrange(1, 2));

  flag_set("zodiacs_evaced");

  wait(4);

  battlechatter_on("allies");

  flag_wait("player_approaching_deck2_flank_path");

  radio_dialogue("oilrig_nsl_splitup");

  thread autosave_by_name("split_up");

  flag_wait("player_at_end_of_deck2");

  radio_dialogue("oilrig_nsl_rescuethemselves");

  wait(2);
  if(!flag("player_on_right_top_deck")) {
    radio_dialogue("oilrig_nsl_moveup");
  }
}

zodiacs_evac() {
  flag_wait("player_at_stairs_to_deck_2");
  aZodiacs = spawn_vehicles_from_targetname_and_drive("zodiacs_evac");
  zodiacs_grate = getEntArray("zodiacs_grate", "targetname");
  array_call(zodiacs_grate, ::delete);
  array_thread(aZodiacs, ::zodiac_think);
}

zodiac_think() {
  playFXOnTag(getfx("zodiac_wake_geotrail_oilrig"), self, "tag_origin");
}

rappel_firefight() {
  aSpawners = getEntArray("hostiles_rappel_deck2", "targetname");
  flag_wait("player_approaching_deck_2");
  triggersEnable("colornodes_deck2", "script_noteworthy", true);
  flag_wait("player_at_deck_2");

  thread autosave_by_name("rappel_firefight");

  thread rappel_ignoreme();

  aHostiles = spawn_group_staggered(aSpawners);
}

rappel_ignoreme() {
  level.player.ignoreme = true;
  flag_wait_or_timeout("rappel_dudes_failsafe", 5);
  level.player.ignoreme = false;
}

attack_heli_riders_think() {
  self SetContents(0);
}

heli_deck2_harass() {
  level endon("heli_not_killed_in_time");
  flag_wait("player_deck2_littlebird");

  eHeli = spawn_vehicle_from_targetname("heli_deck2");
  level.heli = eHeli;
  array_thread(eHeli.riders, ::attack_heli_riders_think);
  flag_wait_either("player_looking_deck2_littlebird", "player_deck2_littlebird_failsafe");

  delaythread(2, ::dialogue_random_heliwarning_combat_intense);
  thread maps\_vehicle::gopath(eHeli);
  eHeli Vehicle_SetSpeed(10);
  eHeli thread play_sound_on_entity("scn_oilrig_chopper_appear");

  foreach(eTurret in eHeli.mgturret) {
    eTurret turret_set_default_on_mode("manual");
    eTurret setMode("manual");
  }

  eHeli.dontWaitForPathEnd = true;
  thread heli_ramp_up_damage(eHeli);
  thread friendlies_shoot_heli_with_rockets(eHeli);
  eHeli SetLookAtEnt(level.player);
  eHeli thread heli_intimidates_player();
  eHeli delaythread(3, maps\_attack_heli::heli_spotlight_on, "tag_barrel", true);
  thread track_if_player_is_shooting_at_intimidating_heli(eHeli);
  thread heli_kill_failsafe(eHeli);

  flag_wait_either("player_shoots_or_aims_rocket_at_intimidating_heli", "deck_2_heli_is_finished_intimidating");

  eHeli = maps\_attack_heli::begin_attack_heli_behavior(eHeli);
  wait(1);
  thread heli_kill_nag(eHeli, "heli_deck2_shot_down");
  flag_wait("heli_deck2_shot_down");

  thread autosave_by_name("heli_deck2_dead");
  wait(1.5);
  thread dialogue_random_helicongats();
  wait(2);

  radio_dialogue("oilrig_nsl_clocksticking");
}

heli_kill_failsafe(eHeli) {
  level endon("heli_deck2_shot_down");
  flag_wait("top_deck_room_breached");
  flag_set("heli_not_killed_in_time");
  if(isDefined(eHeli)) {
    eHeli delete();
  }
  wait(.5);
  flag_set("heli_deck2_shot_down");
}

heli_intimidates_player() {
  wait(5);
  flag_set("deck_2_heli_is_finished_intimidating");
}

track_if_player_is_shooting_at_intimidating_heli(eHeli) {
  level endon("deck_2_heli_is_finished_intimidating");
  level endon("player_shoots_or_aims_rocket_at_intimidating_heli");
  for(;;) {
    eHeli waittill("damage", damage, attacker, direction_vec, P, type);

    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    } else {
      flag_set("player_shoots_or_aims_rocket_at_intimidating_heli");
      break;
    }
  }
}

smoke_throw(aSmokeOrgs) {
  flag1 = "derrick_room_getting_breached";
  flag2 = "stop_smoke";

  while(true) {
    smokeTarget = undefined;
    foreach(org in aSmokeOrgs) {
      playFX(getfx("smokescreen"), org.origin);
      org thread play_sound_in_space("smokegrenade_explode_default");
      wait(randomfloatrange(.1, .3));
    }
    wait(28);
    if((flag(flag1)) || (flag(flag2))) {
      break;
    }
  }
}

AA_deck3_init() {
  flag_set("need_to_check_axis_death");
  level.slomoBasevision = "oilrig_interior2";
  thread samsites();
  thread deck3_breach_autosaves();
  level.slomobreachplayerspeed = 1;
  thread friendly_speed_adjustment_breach_03();
  thread friendlies_shielded_during_breach("top_deck_room_breached", "barracks_cleared");
  thread deck3_firefight();
  thread dialogue_last_room();
  thread deck3_music();
  thread end_music();
  thread autosave_by_name("deck3_start");
  thread colornodes_deck3();
  thread c4_barrels();

  flag_wait("barracks_cleared");
  thread AA_escape_init();
}

deck3_breach_autosaves() {
  flag_wait("player_at_stairs_to_top_deck");
  breach_save_deck3_triggers = getEntArray("breach_save_deck3", "targetname");
  array_thread(breach_save_deck3_triggers, ::breach_save_deck3_triggers_think);
}

breach_save_deck3_triggers_think() {
  level endon("breach_deck3_autosave_threaded");
  level endon("A door in breach group 300 has been activated.");
  aEnemies = undefined;
  volumeAbove = getent(self.script_linkto, "script_linkname");
  enemiesDeleted = false;
  while(true) {
    self waittill("trigger");
    enemiesPresent = false;
    if(enemiesDeleted == false) {
      enemiesDeleted = true;
      enemiesToDelete = volumeAbove get_ai_touching_volume("axis");
      thread AI_delete_when_out_of_sight(enemiesToDelete, 128);
    }

    aEnemies = getaiarray("axis");
    foreach(dude in aEnemies) {
      if(dude istouching(self)) {
        enemiesPresent = true;
        break;
      }
    }
    if(enemiesPresent == false) {
      thread autosave_by_name("deck3_breach");
      level notify("breach_deck3_autosave_threaded");
      break;
    } else {
      wait(2);
    }
  }
}

samsites() {
  flag_wait("player_at_stairs_to_top_deck");
  samsite_turrets = getEntArray("samsite_turret", "script_noteworthy");
  array_thread(samsite_turrets, ::samsite_turret_think);
}

samsite_turret_think() {
  self.missileTags = [];
  self.missileTags[0] = "tag_missle1";
  self.missileTags[1] = "tag_missle2";
  self.missileTags[2] = "tag_missle3";
  self.missileTags[3] = "tag_missle4";
  self.missileTags[4] = "tag_missle5";
  self.missileTags[5] = "tag_missle6";
  self.missileTags[6] = "tag_missle7";
  self.missileTags[7] = "tag_missle8";

  foreach(tag in self.missileTags) {
    self Attach("projectile_slamraam_missile", tag, true);
  }

  time = 4.4;

  wait(randomfloatrange(0, 1.5));
  targetOrg = getent(self.target, "targetname");
  while(!flag("top_deck_room_breached")) {
    self detach("projectile_slamraam_missile", self.missileTags[0]);
    earthquake(.3, .5, self.origin, 1600);
    magicBullet("slamraam_missile_dcburning", self gettagorigin(self.missileTags[0]), targetOrg.origin);
    self.missileTags = array_remove(self.missileTags, self.missileTags[0]);
    if(self.missileTags.size < 1) {
      break;
    }
    self rotateyaw(45, time, time / 2, time / 2);
    wait(time);
    wait(randomfloatrange(0, 2));
    self rotateyaw(-45, time, time / 2, time / 2);
    wait(time);
    wait(randomfloatrange(0, 1.5));
  }
}

friendly_speed_adjustment_breach_03() {
  flag_wait_either("player_near_breach_topdeck_right", "player_near_breach_topdeck_left");
  friendly_speed_adjustment_on();
  flag_wait("top_deck_room_breached");
  friendly_speed_adjustment_off();
}

deck3_autosaves() {
  enemiesKilled = 0;
  while(true) {
    level waittill("player_killed_an_enemy");
    enemiesKilled++;
    if(flag("player_got_deck3_autosave")) {
      flag_clear("need_to_check_axis_death");
      break;
    }

    if(enemiesKilled > 5) {
      thread autosave_by_name("deck3");
      enemiesKilled = 0;
    }
  }
}

deck3_firefight() {
  flag_wait("player_at_stairs_to_top_deck");

  thread deck3_autosaves();

  if(!is_specialop()) {
    foreach(dude in level.squad) {
      if(!isDefined(dude)) {
        continue;
      }
      dude.disableDamageShieldPain = true;
    }
  }

  if(!is_specialop()) {
    thread autosave_by_name("deck3_firefight_start");
  }

  flag_wait("player_on_right_top_deck");
  aSmokeOrgs = getEntArray("smoke_deck3", "targetname");
  thread smoke_throw(aSmokeOrgs);
  wait(1);
  flag_set("smoke_thrown");
  wait(2);

  if(!is_specialop()) {
    foreach(dude in level.squad) {
      if(!isDefined(dude)) {
        continue;
      }
      dude.disableDamageShieldPain = undefined;
    }
  }

  flag_set("smoke_firefight");

  if(!is_specialop()) {
    thread dialogue_smoke_and_first_thermal_hint();
  }

  flag_wait_or_timeout("player_approaching_topdeck_building", 28);
  if(!flag("player_approaching_topdeck_building")) {
    if(!is_specialop()) {
      if(!flag("player_approaching_topdeck_building")) {
        thread dialogue_random_thermal_hint();
      }
    }
  }

  flag_wait_or_timeout("player_approaching_topdeck_building", 28);
  if(!flag("player_approaching_topdeck_building")) {
    thread spawn_smoke_flankers();
  }

  flag_wait_either("player_near_breach_topdeck_right", "player_near_breach_topdeck_left");

  if(!is_specialop()) {
    thread autosave_by_name("deck3_breach_approach");
    flag_set("player_got_deck3_autosave");
    thread dialogue_breach_nag(300);
  }

  flag_wait("derrick_room_getting_breached");

  battlechatter_off("allies");

  if(!flag("stop_smoke")) {
    flag_set("stop_smoke");
  }
  array_thread(level.effects_mid_decks, ::pauseEffect);
  array_thread(level.effects_underwater, ::pauseEffect);
  array_thread(level.effects_lower_rig, ::pauseEffect);

  aAI_to_delete = getaiarray();
  thread activate_all_deck3_killspawners();
  array_thread(aAI_to_delete, ::delete_ai_if_alive);

  level waittill("breach_explosion");
  flag_set("top_deck_room_breached");
}

dialogue_smoke_and_first_thermal_hint() {
  dialogue_random_enemy_smoke();
  wait(1);
  thread dialogue_random_thermal_hint();
  flag_set("done_with_smoke_dialogue");
}

dialogue_last_room() {
  level endon("top_deck_room_breached");

  flag_wait("player_approaching_topdeck_building");

  if(!flag("top_deck_room_breached")) {
    radio_dialogue("oilrig_sbc_hostconfirmed");
  }

  if(!flag("top_deck_room_breached")) {
    radio_dialogue("oilrig_nsl_behinddoors");
  }
}

delete_ai_if_alive() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.script_slowmo_breach)) {
    return;
  }
  if(!is_specialop()) {
    if(is_in_array(level.squad, self)) {
      return;
    }
  }

  if(isDefined(self)) {
    if(isDefined(self.magic_bullet_shield)) {
      self stop_magic_bullet_shield();
    }
    self delete();
  }
}

spawn_smoke_flankers() {
  triggerActivate("smoke_flankers");
}

activate_all_deck3_killspawners() {
  maps\_spawner::kill_spawnerNum(17);
  maps\_spawner::kill_spawnerNum(18);
  maps\_spawner::kill_spawnerNum(19);
  maps\_spawner::kill_spawnerNum(20);
}

colornodes_deck3() {
  triggersEnable("colornodes_deck3", "script_noteworthy", true);
}

c4_barrels() {
  c4_barrels = getEntArray("c4_barrel", "script_noteworthy");
  array_thread(c4_barrels, ::c4_barrels_think);
  c4barrelPacks = getEntArray("c4barrelPacks", "script_noteworthy");
  array_thread(c4barrelPacks, ::c4_packs_think);
  level waittill("A door in breach group 300 has been activated.");
  flag_set("derrick_room_getting_breached");
}

c4_barrels_think() {
  if(is_specialop()) {
    level endon("special_op_terminated");
  }

  level endon("mission failed");
  level endon("missionfailed");
  level endon("player_detonated_explosives");
  eDamageTrigger = self;
  eDamageTrigger setCanDamage(true);

  eDamageTrigger.hitpoints = undefined;
  switch (level.gameSkill) {
    case 0:
      eDamageTrigger.hitpoints = 5;
      break;
    case 1:
      eDamageTrigger.hitpoints = 4;
      break;
    case 2:
      eDamageTrigger.hitpoints = 2;
      break;
    case 3:
      eDamageTrigger.hitpoints = 1;
      break;
  }

  flag_wait("derrick_room_getting_breached");
  while(!flag("player_detonated_explosives")) {
    eDamageTrigger waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, idFlags);
    if((isDefined(attacker)) && (isPlayer(attacker))) {
      if(idFlags & 8) {
        continue;
      }
      if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE") || isSubStr(type, "MOD_PROJECTILE"))) {
        break;
      }

      if(eDamageTrigger.hitpoints > 0) {
        eDamageTrigger.hitpoints -= 1;
      }

      if(eDamageTrigger.hitpoints == 0) {
        break;
      }
    }
  }

  thread c4_barrel_explode();
  flag_set("player_detonated_explosives");
}

c4_barrel_explode() {
  level notify("c4_barrels_exploding");
  level endon("c4_barrels_exploding");
  level.player playLocalSound("oilrig_ambush_explosion");
  playFX(getfx("player_death_explosion"), level.player.origin);
  earthquake(1, 1, level.player.origin, 100);
  if(is_specialop()) {
    maps\_specialops::so_force_deadquote("@OILRIG_MISSIONFAIL_EXPLOSIVES");
  } else {
    setDvar("ui_deadquote", &"OILRIG_MISSIONFAIL_EXPLOSIVES");
  }
  level notify("mission failed");
  maps\_utility::missionFailedWrapper();
}

c4_packs_think() {
  flag_wait("derrick_room_getting_breached");
  self show();

  self notsolid();
  wait(randomfloatrange(0, .6));
  playFXOnTag(getfx("light_c4_blink_nodlight"), self, "tag_fx");
  flag_wait("player_on_board_littlebird");

  self delete();
}

AA_escape_init() {
  battlechatter_on("allies");
  thread music_escape();
  thread escape_sequence();
  thread samsite_01_destroy();

  thread dialogue_escape();
  thread obj_escape();
  enableforcedsunshadows();
}

dialogue_escape() {
  level endon("mission failed");
  flag_wait("barracks_cleared");
  flag_set("obj_explosives_locate_complete");

  battlechatter_off("allies");
  battlechatter_off("axis");
  wait(.5);

  radio_dialogue("oilrig_nsl_roomclear");

  radio_dialogue("oilrig_nsl_allhostsec");

  flag_set("obj_escape_given");

  radio_dialogue("oilrig_sbc_phase2");

  if(!flag("player_on_board_littlebird")) {
    radio_dialogue("oilrig_rmv_goplat");
  }

  if(!flag("player_on_board_littlebird")) {
    radio_dialogue("oilrig_gm1_copies");
  }

  if(!flag("player_on_board_littlebird")) {
    radio_dialogue("oilrig_f15_twof15s");
  }

  if(!flag("player_on_board_littlebird")) {
    radio_dialogue("oilrig_rmv_bluesky");
  }

  if(!flag("player_on_board_littlebird")) {
    radio_dialogue("oilrig_f15_copies");
  }

  flag_wait("littlebird_escape_lifted_off");

  radio_dialogue("oilrig_rmv_localairspace");

  radio_dialogue("oilrig_gm1_hunteractual");

  radio_dialogue("oilrig_rmv_samsitesneut");
}

escape_sequence() {
  flag_wait("barracks_cleared");

  thread autosave_by_name("escape");

  aAI_to_delete = getaiarray("axis");
  thread AI_delete_when_out_of_sight(aAI_to_delete, 512);

  thread friendly_speed_adjustment_on();

  setsaveddvar("sm_sunSampleSizeNear", 1);
  setsaveddvar("sm_sunShadowScale", 0.5);

  sPlayerRideTag = "tag_guy3";

  wait(1);

  triggersEnable("colornodes_escape", "script_noteworthy", true);
  triggersEnable("colornodes_escape_start", "script_noteworthy", true);
  activate_trigger_with_noteworthy("colornodes_escape_start");

  aRoof_riders_left = array_spawn(getEntArray("littlebird_riders_left", "targetname"));
  aRoof_riders_right = array_spawn(getEntArray("littlebird_riders_right", "targetname"));

  aRoof_riders_right = array_add(aRoof_riders_right, level.teamleader);
  level.teamleader.script_startingposition = 4;

  level.littlebird_escape = spawn_vehicle_from_targetname("littlebird_escape");
  obj_escape = getent("obj_escape", "targetname");

  flag_set("littlebird_escape_spawned");

  flag_wait("player_headed_out_of_barracks");
  level.teamleader disable_ai_color();

  pickup_node_before_stage = getstruct("pickup_node_before_stage", "script_noteworthy");
  level.littlebird_escape set_stage(pickup_node_before_stage, aRoof_riders_left, "left");
  level.littlebird_escape set_stage(pickup_node_before_stage, aRoof_riders_right, "right");

  aRiders = array_merge(aRoof_riders_left, aRoof_riders_right);
  foreach(guy in aRiders) {
    assertex(isDefined(guy.script_startingposition), "One of the littlebird escape riders doesnt have a .script_startingposition. Export " + guy.export);
    if(guy.script_startingposition == 2) {
      guy hide();
      guy setcontents(0);
      break;
    }
  }

  foreach(guy in aRiders) {
    guy disable_ai_color();
    if(!isDefined(guy.magic_bullet_shield)) {
      guy thread magic_bullet_shield();
    }
    guy setFlashbangImmunity(true);
    guy.ignoreme = true;
    guy.grenadeawareness = 0;
    guy setthreatbiasgroup("oblivious");
  }

  flag_wait("player_approaching_derrick_building_exit");
  level.littlebird_escape gopath();
  flag_set("littlebird_escape_moving");

  thread helipad_jets();

  level.littlebird_escape waittill("touch_down");
  flag_set("escape_littlebird_landed");

  level.littlebird_escape thread player_gets_on_littlebird(sPlayerRideTag);

  level.littlebird_escape thread load_side("left", aRoof_riders_left);
  level.littlebird_escape thread load_side("right", aRoof_riders_right);

  while(level.littlebird_escape.riders.size < 8) {
    wait(.1);
  }

  wait(1);
  level.littlebird_escape vehicle_ai_event("idle_alert_to_casual");

  flag_wait("player_on_board_littlebird");

  thread vision_set_fog_changes("oilrig_exterior_heli", 5);
  flag_set("obj_escape_complete");

  array_thread(level.effects_mid_decks, ::pauseEffect);

  exploder("ride_smoke");

  heli_escape_path = getstruct("heli_escape_path", "targetname");
  level.littlebird_escape thread vehicle_paths(heli_escape_path);
  level.littlebird_escape setmaxpitchroll(50, 50);

  flag_set("littlebird_escape_lifted_off");

  thread friendly_speed_adjustment_off();

  level.littlebird_escape vehicle_ai_event("idle_alert_to_casual");

  level.littlebird_escape Vehicle_SetSpeed(17);

  flag_wait("heli_escape_path_01");
  blackhawk_main_deck = spawn_vehicle_from_targetname_and_drive("blackhawk_main_deck");
  view_derrick_building_01 = getent("view_derrick_building_01", "targetname");

  flag_wait("heli_escape_path_03");
  friendlies_deck3_stairs = array_spawn(getEntArray("friendlies_deck3_stairs", "targetname"));

  flag_wait("heli_escape_path_04");
  littlebird_wingman_01_drone = spawn_vehicle_from_targetname_and_drive("littlebird_wingman_01_drone");
  littlebird_wingman_01_drone vehicle_ai_event("idle_alert_to_casual");
  littlebird_wingman_01_drone Vehicle_SetSpeed(28);

  flag_wait("heli_escape_path_05");

  level.littlebird_escape Vehicle_SetSpeed(22);

  flag_wait("heli_escape_path_06");
  littlebird_wingman_02_drone = spawn_vehicle_from_targetname_and_drive("littlebird_wingman_02_drone");
  littlebird_wingman_02_drone vehicle_ai_event("idle_alert_to_casual");

  littlebird_wingman_02_drone Vehicle_SetSpeed(33);
  littlebird_wingman_01_drone Vehicle_SetSpeed(33);

  jets_escape_flight_03 = spawn_vehicles_from_targetname_and_drive("jets_escape_flight_03");

  level.littlebird_escape Vehicle_SetSpeed(28);

  flag_wait("heli_escape_path_07");

  flag_wait("heli_escape_path_09");

  littlebird_wingman_02_drone Vehicle_SetSpeed(30);
  littlebird_wingman_01_drone Vehicle_SetSpeed(31);

  wait(4.5);
  level_end();
}

helipad_jets() {
  flag_wait("player_approaching_derrick_building_exit");
  jets_escape_flight_01 = spawn_vehicles_from_targetname_and_drive("jets_escape_flight_01");
  flag_wait("player_approaching_helipad");
  jets_escape_flight_01a = spawn_vehicles_from_targetname_and_drive("jets_escape_flight_01a");
}

sub_through_ice() {
  eSub = undefined;
  eProp = undefined;
  aSubmarineParts = getEntArray("submarine_03", "targetname");
  foreach(part in aSubmarineParts) {
    if((isDefined(part.script_parameters)) && (part.script_parameters == "sub")) {
      eSub = part;
    } else {
      eProp = part;
    }
  }

  level.subDummy = spawn("script_origin", eSub.origin);
  level.subDummy.origin = eSub.origin;
  level.subDummy.angles = eSub.angles;
  eProp linkto(eSub);
  eSub linkto(level.subDummy);

  moveTime = 12;
  moveDist = 1024;

  level.subDummy moveto(level.subDummy.origin + (0, 0, (-1 * moveDist)), .1);
  eSub show();
  eProp show();

  flag_wait("sub_comes_through_ice");

  level.subDummy moveto(eSub.origin + (0, 0, moveDist), moveTime, moveTime / 3, moveTime / 3);
}

liner(blah) {
  for(;;) {
    line(self.origin, blah.origin);
    wait(0.05);
  }
}

player_gets_on_littlebird(sPlayerRideTag) {
  trigger_origin = self gettagorigin(sPlayerRideTag);
  trigger_radius = 80;
  trigger_height = 100;
  trigger_spawnflags = 0;
  trigger = spawn("trigger_radius", trigger_origin, trigger_spawnflags, trigger_radius, trigger_height);

  player_seat = spawn_tag_origin();
  player_seat.origin = self gettagorigin(sPlayerRideTag);
  player_seat.angles = self gettagangles(sPlayerRideTag);
  player_seat.angles = player_seat.angles + (0, 0, 0);
  player_seat linkto(self, sPlayerRideTag, (0, 0, 0), (0, -90, 0));
  trigger waittill("trigger");

  level.player freezeControls(true);
  setsaveddvar("ui_hidemap", 1);
  SetSavedDvar("hud_showStance", "0");
  SetSavedDvar("compass", "0");
  SetSavedDvar("ammoCounterHide", "1");
  level.player allowprone(false);
  level.player allowcrouch(false);
  level.player allowsprint(false);
  level.player allowjump(false);
  level.player disableWeapons();

  viewPercentFrac = 1.0;
  arcRight = 40;
  arcLeft = 40;
  arcTop = 10;
  arcBottom = 45;

  level.player PlayerLinkToBlend(player_seat, "tag_origin", 1, .2, .2);
  wait 1;
  level.player PlayerLinkToDelta(player_seat, "tag_origin", viewPercentFrac, arcRight, arcLeft, arcTop, arcBottom);
  level.player freezeControls(false);

  level.player takeallweapons();
  level.player GiveWeapon("m14_scoped_arctic");
  level.player SwitchToWeapon("m14_scoped_arctic");
  level.player enableWeapons();

  flag_set("player_on_board_littlebird");
}

samsite_01_destroy() {
  flag_wait("barracks_cleared");
  flag_wait("player_exiting_derrick_building");

  samsite1_heli_unload = getstruct("samsite1_heli_unload", "targetname");
  blackhawk_samsite_01 = spawn_vehicle_from_targetname_and_drive("blackhawk_samsite_01");

  blackhawk_samsite_01 waittill("reached_dynamic_path_end");

  flag_wait("littlebird_escape_lifted_off");
  aFriendlies = blackhawk_samsite_01.riders;
  blackhawk_samsite_01 vehicle_paths(samsite1_heli_unload);

  wait(4.5);
  guy = getClosest(level.player.origin, aFriendlies);

  guy thread play_sound_on_entity("oilrig_gm1_samssecure");
}

samsite_02_destroy() {
  flag_wait("littlebird_escape_lifted_off");
  friendlies_samsite_02 = array_spawn(getEntArray("friendlies_samsite_02", "targetname"));
}

samsite_03_destroy() {
  flag_wait("littlebird_escape_lifted_off");
  friendlies_samsite_03 = array_spawn(getEntArray("friendlies_samsite_03", "targetname"));
}

level_end() {
  black_overlay = create_client_overlay("black", 0, level.player);
  black_overlay fadeOverTime(3);
  black_overlay.alpha = 1;
  wait(3);

  nextMission();
}

obj_stealthkill() {
  flag_wait("obj_stealthkill_given");
  objective_number = 1;

  obj_position = level.hostile_stealthkill_player;

  objective_add(objective_number, "active", &"OILRIG_OBJ_STEALTHKILL", obj_position.origin);
  objective_current(objective_number);

  flag_wait("obj_stealthkill_complete");

  objective_state(objective_number, "done");
}

obj_hostages_secure() {
  obj_positions = getEntArray("obj_breach1", "targetname");
  objective_number = 2;

  flag_wait("obj_hostages_secure_given");

  objective_add(objective_number, "invisible", &"OILRIG_OBJ_HOSTAGES_SECURE");
  Objective_OnEntity(objective_number, level.teamleader);
  objective_state(objective_number, "current");
  Objective_String(objective_number, &"OILRIG_OBJ_HOSTAGES_SECURE", level.totalHostages);

  flag_wait("player_at_lower_breach");
  flag_wait("railing_patroller_dead");

  maps\_slowmo_breach::objective_breach(objective_number, 0, 1);

  Objective_String(objective_number, &"OILRIG_OBJ_HOSTAGES_SECURE", level.totalHostages);

  flag_wait("lower_room_breached");
  objective_clearAdditionalPositions(objective_number);
  Objective_SetPointerTextOverride(objective_number);

  flag_wait("lower_room_cleared");

  Objective_String(objective_number, &"OILRIG_OBJ_HOSTAGES_SECURE", level.totalHostages - 4);
  Objective_OnEntity(objective_number, level.friendly02);

  flag_wait("player_at_last_breach_building");

  maps\_slowmo_breach::objective_breach(objective_number, 2, 3);

  flag_wait("upper_room_breached");
  objective_clearAdditionalPositions(objective_number);
  Objective_SetPointerTextOverride(objective_number);

  flag_wait("obj_hostages_secure_complete");

  objective_state(objective_number, "done");
  Objective_String(objective_number, &"OILRIG_OBJ_HOSTAGES_SECURE_DONE");
}

obj_c4_ambush_plant() {
  flag_wait("obj_c4_ambush_plant_given");
  objective_number = 3;

  objective_add(objective_number, "invisible", &"OILRIG_OBJ_C4_AMBUSH_PLANT");

  objective_state(objective_number, "current");

  Objective_String(objective_number, &"OILRIG_OBJ_C4_AMBUSH_PLANT");
  objective_current(objective_number);

  flag_wait("obj_c4_ambush_plant_complete");

  objective_state(objective_number, "done");
}

obj_c4_ambush_think() {
  level.C4locationsIndex++;
  index = level.C4locationsIndex;
  level.C4locations[level.C4locations.size] = self;

  Objective_String(3, &"OILRIG_OBJ_C4_AMBUSH_PLANT");

  objective_additionalposition(3, index, self.origin);

  Objective_String(3, &"OILRIG_OBJ_C4_AMBUSH_PLANT");

  self waittill("c4_planted");
  if(!flag("player_has_started_planting_c4")) {
    flag_set("player_has_started_planting_c4");
  }
  level.C4locations = array_remove(level.C4locations, self);
  waittillframeend;
  objective_additionalposition(3, index, (0, 0, 0));
  if(level.C4locations.size < 2) {
    flag_set("obj_c4_ambush_plant_complete");
  }

  Objective_String(3, &"OILRIG_OBJ_C4_AMBUSH_PLANT");
}

obj_ambush() {
  flag_wait("obj_ambush_given");
  objective_number = 4;

  objective_add(objective_number, "active", &"OILRIG_OBJ_AMBUSH");
  objective_current(objective_number);
  Objective_OnEntity(objective_number, level.teamleader);
  flag_wait("obj_ambush_complete");

  objective_state(objective_number, "done");
}

obj_explosives_locate() {
  flag_wait("obj_explosives_locate_given");
  objective_number = 5;

  objective_add(objective_number, "active", &"OILRIG_OBJ_EXPLOSIVES_LOCATE");
  objective_current(objective_number);
  Objective_OnEntity(objective_number, level.teamleader);

  flag_wait("player_on_right_top_deck");
  objective_position(objective_number, (0, 0, 0));
  obj_positions = getEntArray("obj_breach3", "targetname");

  maps\_slowmo_breach::objective_breach(objective_number, 4, 5);

  flag_wait("top_deck_room_breached");
  objective_clearAdditionalPositions(objective_number);
  Objective_SetPointerTextOverride(objective_number);

  flag_wait("obj_explosives_locate_complete");

  objective_state(objective_number, "done");
}

obj_escape() {
  flag_wait("obj_escape_given");
  objective_number = 6;

  objective_add(objective_number, "active", &"OILRIG_OBJ_ESCAPE");
  objective_current(objective_number);
  Objective_OnEntity(objective_number, level.teamleader);

  flag_wait("player_at_helipad_stairs");

  flag_wait("escape_littlebird_landed");
  objective_position(objective_number, (0, 0, 0));

  obj_escape = getent("obj_escape", "targetname");
  obj_escape.origin = level.littlebird_escape gettagorigin("tag_guy3");
  obj_escape.origin = obj_escape.origin + (0, 0, 30);
  objective_position(objective_number, obj_escape.origin);

  flag_wait("obj_escape_complete");
  objective_state(objective_number, "done");
}

AA_music_init() {}

music_underwater() {
  flag_wait("player_approaching_oilrig_legs");
  MusicPlayWrapper("oilrig_underwater_music");
}

music_surface_to_first_breach() {
  level endon("lower_room_breached");

  flag_wait("player_slitting_throat");
  musicstop();
  time = musicLength("oilrig_sneak_music");
  while(!flag("lower_room_breached")) {
    MusicPlayWrapper("oilrig_sneak_music");
    wait(time);

    music_stop(1);
    wait(1.1);
  }
}

music_lower_room_to_upper_room() {
  level endon("upper_room_breached");

  flag_wait("lower_room_breached");
  musicstop();
  flag_wait("lower_room_cleared");
  time = musicLength("oilrig_suspense_01_music_alt");
  while(!flag("upper_room_breached")) {
    MusicPlayWrapper("oilrig_suspense_01_music_alt");
    wait(time);

    music_stop(1);
    wait(1.1);
  }
}

music_ambush_to_deck_2() {
  level endon("player_at_stairs_to_deck_2");
  flag_wait("upper_room_breached");
  musicstop();

  flag_wait("obj_c4_ambush_plant_given");
  MusicPlayWrapper("oilrig_suspense_01_music_alt");

  flag_wait_either("ambush_enemies_alerted", "ambush_enemies_alerted_prematurely");
  musicstop();
  wait(0.05);

  time = musicLength("oilrig_fight_music_01");
  while(!flag("player_at_stairs_to_deck_2")) {
    MusicPlayWrapper("oilrig_fight_music_01");
    wait(time);

    music_stop(1);
    wait(1.1);
  }
}

music_deck2_to_deck3() {
  flag_wait("player_at_stairs_to_deck_2");
  music_stop(5);
  flag_wait("zodiacs_evaced");

  level endon("smoke_thrown");

  time = musicLength("oilrig_fight_music_01");
  while(!flag("smoke_thrown")) {
    MusicPlayWrapper("oilrig_fight_music_01");
    wait(time);

    music_stop(1);
    wait(1.1);
  }
}

deck3_music() {
  level endon("top_deck_room_breached");
  flag_wait("smoke_thrown");
  music_stop(4);
  wait(4.1);
  time = musicLength("oilrig_top_deck_music_01");
  while(!flag("top_deck_room_breached")) {
    MusicPlayWrapper("oilrig_top_deck_music_01");
    wait(time);

    music_stop(1);
    wait(1.1);
  }
}

end_music() {
  flag_wait("top_deck_room_breached");
  musicstop();
}

music_escape() {
  flag_wait("barracks_cleared");
  musicstop();
  wait(.5);
  MusicPlayWrapper("oilrig_victory_music");
}

AA_utility() {}

AI_army_think() {
  self set_battlechatter(false);
}

AI_think(guy) {
  if(guy.team == "axis") {
    guy thread AI_axis_think();
  }

  if(guy.team == "allies") {
    guy thread AI_allies_think();
  }
}

AI_allies_think() {
  flag_wait("player_ready_to_be_helped_from_water");
  self thread animscripts\utility::PersonalColdBreath();
}

AI_axis_think() {
  self endon("death");
  if(self has_shotgun()) {
    self cqb_walk("on");
  }
  if(level.oilrigStealth == true) {
    self thread AI_stealth_monitor();
  }

  doorFlashChanceFactor = undefined;
  baseaccuracyFactor = undefined;

  switch (level.gameSkill) {
    case 0:
      doorFlashChanceFactor = 1;
      baseaccuracyFactor = 1.5;
      break;
    case 1:
      doorFlashChanceFactor = 1.5;
      baseaccuracyFactor = 1.5;
      break;
    case 2:
      doorFlashChanceFactor = 2;
      baseaccuracyFactor = 1;
      break;
    case 3:
      doorFlashChanceFactor = 2;
      baseaccuracyFactor = 1;
      break;
  }

  self.baseaccuracy = self.baseaccuracy * baseaccuracyFactor;

  while(!isDefined(self.doorFlashChance)) {
    wait(0.05);
  }

  self.doorFlashChance = self.doorFlashChance * doorFlashChanceFactor;

  if((flag("need_to_check_axis_death")) && (level.gameskill < 2)) {
    self thread AI_axis_death_think();
  }
}

AI_axis_death_think() {
  self waittill("death", attacker);
  if((isDefined(attacker)) && (isPlayer(attacker))) {
    level notify("player_killed_an_enemy");
  }
}

ai_rappel_think() {
  self endon("death");
  self.animname = "generic";
  reference = self.spawner;
  ropeModel = undefined;
  sRopeAnim = undefined;

  self hide();
  self.ignoreme = true;
  reference anim_first_frame_solo(self, self.animation);
  eRopeOrg = spawn("script_origin", self.spawner.origin);
  self thread delete_on_death(eRopeOrg);
  eRopeOrg.angles = self.spawner.angles;

  switch (self.animation) {
    case "oilrig_rappel_over_rail_R":
      ropeModel = "oilrig_rappelrope_50ft";
      sRopeAnim = "oilrig_rappelrope_over_rail_R";
      break;
    case "oilrig_rappel_2_crouch":
      ropeModel = "oilrig_rappelrope_80ft";
      sRopeAnim = "oilrig_rappelrope_2_crouch";
      break;
    default:
      assertmsg("rappel spawner with export " + self.export+" does not have a valid animation key set in radiant.");
      break;
  }

  eRope = spawn("script_model", eRopeOrg.origin);
  eRope setModel(ropeModel);

  eRope.animname = "rope";
  eRope assign_animtree();
  eRopeOrg anim_first_frame_solo(eRope, sRopeAnim);
  self.oldhealth = self.health;
  self.health = 3;
  self show();
  self.allowdeath = true;
  self thread ai_rappel_death();
  eRopeOrg thread rope_anim(eRope, sRopeAnim);
  reference thread anim_generic(self, self.animation);
  wait(1.5);
  self.ignoreme = false;
  self waittill("over_solid_ground");
  self.health = self.oldhealth;
}

rope_anim(eRope, sRopeAnim) {
  self anim_single_solo(eRope, sRopeAnim);
  flag_wait("player_at_stairs_to_top_deck");
  if(isDefined(self)) {
    self delete();
  }
  if(isDefined(eRope)) {
    eRope delete();
  }
}

ai_rappel_death() {
  self endon("over_solid_ground");
  if(!isDefined(self)) {
    return;
  }
  self set_deathanim("fastrope_fall");
  self waittill("death");
  self thread play_sound_in_space("generic_death_falling");
}

ai_rappel_over_ground_death_anim(guy) {
  guy endon("death");
  guy notify("over_solid_ground");
  guy clear_deathanim();
}

ai_rappel_reset_death_anim(guy) {
  guy endon("death");
  guy clear_deathanim();
}

stealth_hostage_monitor() {
  level endon("obj_hostages_secure_complete");
}

heli_patrol_think() {
  self endon("death");
  if(isDefined(self.riders)) {
    foreach(guy in self.riders) {
      guy.ignoreme = true;
      guy setthreatbiasgroup("oblivious");
    }
  }
  self thread maps\_attack_heli::heli_spotlight_on(undefined, true);
  self waittill("damage");
  self.dontWaitForPathEnd = true;
  maps\_attack_heli::begin_attack_heli_behavior(self);
  wait(2);
  thread mission_fail_hostage_executed();
}

vehicle_heli_setup(aTargetnames) {
  foreach(sTargetname in aTargetnames) {
    thread vehicle_heli_think(sTargetname);
  }
}

vehicle_heli_think(sTargetname) {
  flag_init(sTargetname + "_shot_down");
  eHeli = maps\_vehicle::waittill_vehiclespawn(sTargetname);
  level.EnemyHeli = eHeli;
  level.EnemyHeli.enableRocketDeath = true;
  array_thread(eHeli.mgturret, ::turret_rains_down_shells);
  wait(1);

  eHeli waittill_either("death", "crash_done");
  flag_set(sTargetname + "_shot_down");
}

turret_rains_down_shells() {
  self endon("death");
  fx = getfx("minigun_shell_eject");
  for(;;) {
    if(self IsFiringTurret()) {
      for(;;) {
        if(!self IsFiringTurret()) {
          break;
        }

        playFXOnTag(fx, self, "tag_flash");
        wait(0.05);
      }
    }

    wait(0.05);
  }
}

level_think() {
  eDerrick_thing = getent("derrick_thing", "targetname");
  eDerrick_thing.origin = eDerrick_thing.origin + (0, 0, -2816);
  assert(isDefined(eDerrick_thing));
  time = 2;
  speed = 300;
  while(true) {
    eDerrick_thing rotatevelocity((0, speed, 0), time);
    wait(time);
  }
}

player_stealth_monitor() {
  flag_set("player_broke_stealth");
}

hostage_evac_think() {
  level endon("mission failed");

  while(!isDefined(self.breachfinished)) {
    wait(.1);
  }

  while(self.breachfinished == false) {
    wait(.1);
  }

  wait(randomfloatrange(1, 2));
  eNode = level.hostageNodes[0];
  level.hostageNodes = array_remove(level.hostageNodes, eNode);
  self endon("death");
  self notify("stop_idle");
  self setgoalnode(eNode);
  self.goalradius = 64;
  self.alertlevel = "noncombat";
  self waittill("goal");
}

dialogue_random_pmc(org) {
  iRand = randomint(21);
  if(iRand < 10) {
    sLine = "oilrig_merc_chatter_0" + iRand;
  } else {
    sLine = "oilrig_merc_chatter_" + iRand;
  }
  thread play_sound_in_space(level.scr_sound[sLine], org);
}

dialogue_random_no_hostages_go_nuts() {}

dialogue_random_gratekill() {
  iRand = randomint(4);
  radio_dialogue("oilrig_nsl_outtogether_0" + iRand);
}

dialogue_random_friendly_rocket_miss_heli() {
  iRand = randomint(3);
  battlechatter_off("allies");
  radio_dialogue("oilrig_ns2_fireat4_0" + iRand);
  battlechatter_on("allies");
}
dialogue_random_helicongats() {
  iRand = randomint(6);
  battlechatter_off("allies");
  radio_dialogue("oilrig_heli_grats_0" + iRand);
  battlechatter_on("allies");
}

dialogue_random_enemy_smoke() {
  battlechatter_off("allies");
  iRand = randomint(5);
  radio_dialogue("oilrig_enemy_smoke_0" + iRand);
  battlechatter_on("allies");
}

dialogue_random_thermal_hint() {
  level endon("player_approaching_topdeck_building");

  if(level.player player_has_thermal()) {
    iRand = randomint(2);
    radio_dialogue("oilrig_use_thermal_0" + iRand);
  } else {
    iRand = randomint(2);
    radio_dialogue("oilrig_find_thermal_0" + iRand);
  }

  waittill_using_thermal_scope_or_timeout_func(7);
}

waittill_using_thermal_scope_or_timeout_func(time) {
  level endon("oilrig_timeout_func");
  level endon("player_approaching_topdeck_building");
  thread timeout_func(time);
  while(true) {
    wait(0.1);
    while(!level.player player_has_thermal()) {
      wait(.5);
    }
    if(level.player adsButtonPressed()) {
      break;
    }
  }

}

timeout_func(time) {
  wait(time);
  level notify("oilrig_timeout_func");
}

dialogue_random_heliwarning_stealth() {
  radio_dialogue("oilrig_heloapproach_0" + iRand);
}

dialogue_random_heliwarning_combat_intense() {
  iRand = randomint(3);

  battlechatter_off("allies");

  radio_dialogue("oilrig_ambush_helo_alert_0" + iRand);

  battlechatter_on("allies");
}

dialogue_random_heli_all_clear() {
  iRand = randomint(3);
  radio_dialogue("dialogue_heli_all_clear_0" + iRand);
}

volumes_clear_of_enemies(aVolumes) {
  array = undefined;
  foreach(volume in aVolumes) {
    array = volume get_ai_touching_volume("axis");
    if(array.size) {
      return false;
    }
  }
  return true;
}

dialogue_breach_nag(iBreachGroup) {
  level notify("breach_nag_called");
  level endon("breach_nag_called");
  level endon("lower_room_cleared");
  level endon("upper_room_cleared");
  level endon("A door in breach group " + iBreachGroup + " has been activated.");

  iNagNumber = 0;

  while(true) {
    if(iBreachGroup == 300) {
      wait(randomfloatrange(5, 8));
    } else {
      wait(randomfloatrange(12, 18));
    }
    if(iBreachGroup == 300) {
      breach_safe_volumes = getEntArray("breach_safe_volume", "targetname");
      if((!volumes_clear_of_enemies(breach_safe_volumes)) || (!flag("left_deck3_dudes_spawned"))) {
        wait(3);
        continue;
      }
    }

    iNagNumber++;
    if(iNagNumber > 3) {
      iNagNumber = 0;
    }
  }
}

init_difficulty() {
  playerThreatAdditional = undefined;
  switch (level.gameSkill) {
    case 0:
      playerThreatAdditional = 500;
      break;
    case 1:
      playerThreatAdditional = 500;
      break;
    case 2:
      playerThreatAdditional = 500;
      break;
    case 3:
      playerThreatAdditional = 500;
      break;
  }

  easyWeapons = getEntArray("easy", "script_noteworthy");
  if(level.gameskill > 0) {
    array_call(easyWeapons, ::delete);
  }

  level.player.old_threatbias = level.player.threatbias;
  level.player.threatbias = level.player.threatbias + playerThreatAdditional;
  flag_set("difficulty_initialized");
}

spawn_trigger_dummy(sDummyTargetname) {
  ent = getent(sDummyTargetname, "targetname");
  assert(isDefined(ent));
  assert(isDefined(ent.script_linkTo));
  trig = getent(ent.script_linkTo, "script_linkname");
  assert(isDefined(trig));
  trig notify("trigger", level.player);
}

disable_color_trigs() {
  array_thread(level.aColornodeTriggers, ::trigger_off);
}

open_gate(bImmediately, bDontWaitForFlags) {
  eGate = getent("gate_01", "targetname");
  assert(isDefined(eGate));
  eGate connectpaths();

  if(isDefined(bImmediately)) {
    eGate moveto((eGate.origin - (0, -170, 0)), 1);
  } else {
    if(!isDefined(bDontWaitForFlags)) {
      flag_wait_either("ambush_enemies_approaching", "ambush_enemies_alerted_prematurely");
    }
    eGate thread play_sound_on_entity("scn_oilrig_fence_open");
    eGate moveto((eGate.origin - (0, -170, 0)), 8, 3, 3);
    wait(8);
  }
  flag_set("ambush_gate_opened");
}

initPrecache() {
  PreCacheItem("slamraam_missile_dcburning");

  PreCacheModel("com_floodlight");
  PreCacheModel("tag_turret");
  precacheModel("prop_seal_udt_flippers");
  precacheModel("prop_seal_udt_goggles");
  precacheModel("prop_seal_udt_draeger");
  PreCacheModel("furniture_chair_metal01");
  PreCacheModel("com_restaurantchair_2");
  PreCacheModel("furniture_long_desk_animate");

  precacheModel("com_blackhawk_spotlight_on_mg_setup");
  precacheTurret("heli_spotlight");
  PreCacheTurret("player_view_controller");

  precacheItem("rpg_nodamage");
  precacheItem("m14_scoped_arctic");
  precacheItem("m4m203_reflex");
  precacheItem("scar_h_thermal");
  precacheItem("mp5_reflex");

  precacheModel("weapon_rpd_MG_Setup");
  precacheModel("furniture_chair_metal01");
  precacheModel("com_restaurantchair_2");
  precachemodel("oilrig_rappelrope_80ft");
  precachemodel("oilrig_rappelrope_50ft");

  precachemodel("viewhands_player_udt");
  precacherumble("light_3s");
  precacherumble("damage_heavy");
  precacherumble("tank_rumble");
  precacherumble("pistol_fire");
  precacherumble("mig_rumble");
  precacheModel("weapon_parabolic_knife");

  precacheItem("missile_mi28");

  precachestring(&"OILRIG_MISSIONFAIL_HELI_DEATH");
  precachestring(&"OILRIG_MISSIONFAIL_EXPLOSIVES_NOTPLANTED");

  precachestring(&"SCRIPT_DEBUG_LEVEL_END");

  precachestring(&"OILRIG_OBJ_STEALTHKILL");

  precachestring(&"OILRIG_OBJ_HOSTAGES_SECURE");

  precachestring(&"OILRIG_OBJ_C4_AMBUSH_PLANT");

  precachestring(&"OILRIG_OBJ_AMBUSH");

  precachestring(&"OILRIG_OBJ_EXPLOSIVES_LOCATE");

  precachestring(&"OILRIG_HINT_AMBUSH_COVER");

  precachestring(&"OILRIG_HINT_C4_SWITCH");

  precachestring(&"OILRIG_MISSIONFAIL_ENEMIES_ALERTED_HOSTAGES_KILLED");

  precachestring(&"OILRIG_HINT_C4_DETONATE");
  precachestring(&"SCRIPT_PLATFORM_OILRIG_HINT_STEALTH_KILL");
  precachestring(&"OILRIG_HINT_THERMAL_WEAPON_USE");
  precachestring(&"OILRIG_HINT_THERMAL_WEAPON_FIND");
}

initFriendlies(sStartPoint, bDontSpawnFriendlies, bWarpPlayer) {
  if(!isDefined(bWarpPlayer)) {
    bWarpPlayer = true;
  }

  if(!isDefined(bDontSpawnFriendlies)) {
    bDontSpawnFriendlies = false;
  }

  waittillframeend;
  assert(isDefined(sStartPoint));

  if((isDefined(bDontSpawnFriendlies)) && (bDontSpawnFriendlies != true)) {
    aSpawners = getEntArray("team2", "targetname");
    level.team2 = array_spawn(aSpawners);
    array_thread(level.team2, ::team2_think);
    level.squad = [];
    level.teamleader = spawn_script_noteworthy("price");
    level.teamleader.animname = "soap";
    level.friendly02 = spawn_script_noteworthy("friendly02");
    level.friendly03 = spawn_script_noteworthy("friendly03");
    level.teamleader forceUseWeapon("mp5_silencer_reflex", "primary");
    level.friendly02 forceUseWeapon("mp5_silencer_reflex", "primary");
    level.friendly03 forceUseWeapon("mp5_silencer_reflex", "primary");
    level.squad[0] = level.teamleader;
    level.squad[1] = level.friendly02;
    level.squad[2] = level.friendly03;
    array_thread(level.squad, maps\_slowmo_breach::add_slowmo_breacher);
    array_thread(level.squad, ::friendly_squad_think);
  }
  level.friendlies = [];
  level.friendlies = array_merge(level.squad, level.team2);

  if(is_default_start()) {
    return;
  }

  aFriendlies = level.squad;
  warpNodes = getnodearray("friendlyStart" + sStartPoint, "targetname");
  assertEx(warpNodes.size == 3, "Need exactly 3 nodes with targetname: nodeStart" + sStartPoint);
  while(aFriendlies.size > 0) {
    wait(0.05);
    for(i = 0; i < warpNodes.size; i++) {
      if(isDefined(warpNodes[i].script_noteworthy)) {
        switch (warpNodes[i].script_noteworthy) {
          case "nodePrice":
            level.teamleader teleport_ai(warpNodes[i]);
            aFriendlies = array_remove(aFriendlies, level.teamleader);
            warpNodes = array_remove(warpNodes, warpNodes[i]);
            break;
          case "nodeFriendly02":
            level.friendly02 teleport_ai(warpNodes[i]);
            aFriendlies = array_remove(aFriendlies, level.friendly02);
            warpNodes = array_remove(warpNodes, warpNodes[i]);
            break;
          case "nodeFriendly03":
            level.friendly03 teleport_ai(warpNodes[i]);
            aFriendlies = array_remove(aFriendlies, level.friendly03);
            warpNodes = array_remove(warpNodes, warpNodes[i]);
            break;
          default:
            assertmsg("node has invalid name for initFriendlies() function: " + warpNodes[i].script_noteworthy);
            break;
        }
      }
    }
  }

  if((isDefined(bWarpPlayer)) && (bWarpPlayer == true)) {
    aPlayerNodes = getnodearray("playerStart" + sStartPoint, "targetname");
    teleport_players(aPlayerNodes);
  }
}

team2_think() {
  wait(.5);
  self cqb_walk("on");
  self thread magic_bullet_shield();
  self setFlashbangImmunity(true);
  self setthreatbiasgroup("oblivious");
  self.ignoreme = true;
}

friendly_squad_think() {
  self cqb_walk("on");
  self thread magic_bullet_shield();
  self setFlashbangImmunity(true);
  wait(0.05);

  if((self == level.teamleader) || (self == level.friendly02)) {
    self.attackeraccuracy = 0.5;
    self.baseaccuracy = self.baseaccuracy * 0.7;
  }
}

first_breach(breach_rig) {
  level notify("breach_explosion");
}

ambush_patroller_think() {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "body_discover") {
    self.usechokepoints = false;
  }

  self.ignoreme = true;
  old_movepalybackrate = self.moveplaybackrate;
  self.moveplaybackrate = .7;
  self setthreatbiasgroup("oblivious");
  self.animname = "generic";
  self cqb_walk("on");
  wait(.5);
  self thread ambush_enemies_alerted_prematurely();
  self thread enemy_alert_think();

  flag_wait_either("ambush_enemies_alerted", "ambush_enemies_alerted_prematurely");
  wait(1);
  self.ignoreme = false;
  self setthreatbiasgroup("axis");
  self cqb_walk("off");
  self.moveplaybackrate = old_movepalybackrate;
}

ai_patroller_think() {
  self endon("death");
  self.ignoreme = true;
  self setthreatbiasgroup("oblivious");
  self set_walkdist(1000);
  self.disablearrivals = true;
  self setthreatbiasgroup("oblivious");
  self clearEnemy();
  wait(0.1);
  self thread maps\_patrol::patrol();
}

premature_kill_missionfail(soundOrg) {
  level endon("breach_explosion");
  while(true) {
    self waittill("damage", amount, attacker);
    if(isPlayer(attacker)) {
      thread mission_fail_generic(soundOrg);
    }
  }

}

mission_fail_generic(soundOrg) {
  level notify("doing_generic_mission_fail");
  level endon("doing_generic_mission_fail");

  wait(.5);
  thread premature_hostage_death_fx();
  if(isDefined(soundOrg)) {
    soundOrg thread play_sound_in_space("weap_deserteagle_fire_npc");
  }
  wait(.25);
  level.player thread play_loop_sound_on_entity("emt_oilrig_alarm_alert");
  if(isDefined(soundOrg)) {
    soundOrg thread play_sound_in_space("weap_deserteagle_fire_npc");
  }
  wait(.5);
  thread mission_fail_hostage_executed();
}

premature_hostage_death_fx() {
  aBloodSpatters = getEntArray("blood_spatters", "targetname");
}

mission_fail_hostage_executed() {
  flag_set("oilrig_mission_failed");
  setDvar("ui_deadquote", &"OILRIG_MISSIONFAIL_ENEMIES_ALERTED_HOSTAGES_KILLED");
  level notify("mission failed");
  maps\_utility::missionFailedWrapper();
}

enemy_alert_think() {
  self endon("death");
  self thread player_in_exposed_ambush_spot();
  level endon("ambush_enemies_alerted");
  level endon("ambush_enemies_alerted_prematurely");
  self waittill("enemy");
  flag_set("ambush_enemies_alerted_prematurely");
}

player_in_exposed_ambush_spot() {
  self endon("death");
  level endon("ambush_enemies_alerted");
  level endon("ambush_enemies_alerted_prematurely");
  trigger_exposed_ambush_spot = getent("exposed_ambush_spot", "targetname");
  while(true) {
    wait(1.5);
    if(self istouching(trigger_exposed_ambush_spot)) {
      if(flag("player_in_exposed_ambush_spot")) {
        break;
      }
    }
  }

  flag_set("ambush_enemies_alerted_prematurely");
}

spawn_group_staggered(aSpawners) {
  assertEx((aSpawners.size > 0), "The array passed to array_spawn function is empty");
  aSpawners = array_randomize(aSpawners);
  spawnedGuys = [];
  foreach(spawner in aSpawners) {
    wait(randomfloatrange(.25, 1));
    guy = spawner spawn_ai();
    spawnedGuys[spawnedGuys.size] = guy;
  }

  assertEx((aSpawners.size == spawnedGuys.size), "Not all guys were spawned successfully from array_spawn");

  return spawnedGuys;
}

open_door_deck1() {
  self.startingpos = self.origin;
  self.startingangles = self.angles;
  self rotateyaw(160, 0.5);
  self moveto(self.origin + (3, 0, 0), 0.1);
  self connectpaths();
}

open_door_deck1_opposite() {
  self.startingpos = self.origin;
  self.startingangles = self.angles;
  self rotateyaw(-110, 0.5);
  self moveto(self.origin + (3, 0, 0), 0.1);
  self connectpaths();
}
close_door_deck1() {
  self.origin = self.startingpos;
  self.angles = self.startingangles;
}

close_door_deck1_opposite() {
  self.origin = self.startingpos;
  self.angles = self.startingangles;
}

ai_cleanup(dist) {
  if(!isDefined(dist)) {
    dist = 1024;
  }
  aAI_to_delete = getaiarray("axis");
  thread AI_delete_when_out_of_sight(aAI_to_delete, dist);
}

submarine_spawn(sSubNumber, eNode) {
  eSub = spawn("script_model", eNode.origin + (0, 0, 0));
  eSub setModel("vehicle_submarine_nuclear");
  eSub.origin = eNode.origin;
  eSub.angles = eNode.angles;

  eSub.body = undefined;
  eSub.prop = undefined;
  aSubmarineParts = getEntArray("submarine_" + sSubNumber, "targetname");
  foreach(part in aSubmarineParts) {
    if((isDefined(part.script_parameters)) && (part.script_parameters == "sub")) {
      eSub.body = part;
    } else {
      eSub.prop = part;
    }
  }

  eSub.DDS = undefined;
  eSub.aDDSparts = undefined;
  if(sSubNumber == "01") {
    eSub.aDDSparts = getEntArray("sub_dds_01", "targetname");
    foreach(part in eSub.aDDSparts) {
      if((isDefined(part.script_noteworthy)) && (part.script_noteworthy == "body")) {
        eSub.DDS = spawn("script_origin", part.origin);
        eSub.DDS.angles = part.angles;
        eSub.DDS.angles = part.angles;
        break;
      }
    }
    foreach(part in eSub.aDDSparts) {
      part linkto(eSub.DDS);
    }
  } else {
    eSub.DDS = getent("sub_dds_" + sSubNumber, "targetname");
  }
  eSub.DoorDDS = getent("dds_door_" + sSubNumber, "targetname");
  eSub.DoorDDS.eDoorSeal = undefined;
  if(sSubNumber == "01") {
    eSub.DoorDDS.eDoorSeal = getent("dds_door_01_seal", "targetname");
    eSub.DoorDDS.eDoorSeal linkTo(eSub.DoorDDS);
  }
  assert(isDefined(eSub));
  assert(isDefined(eSub.body));
  assert(isDefined(eSub.prop));
  assert(isDefined(eSub.DDS));
  assert(isDefined(eSub.DoorDDS));
  eSub.body.origin = eSub.origin;
  eSub.body.angles = eSub.angles;
  eSub.animname = "submarine_" + sSubNumber;
  if(eSub.animname == "submarine_01") {
    eSub.body linkto(eSub, "TAG_ORIGIN", (-10, 0, -324), (0, 0, 0));
  } else {
    eSub.body linkto(eSub, "TAG_ORIGIN", (-10, 0, -348), (0, 0, 0));
  }

  eSub.body show();

  eSub.DoorDDS linkto(eSub.DDS);
  eSub.DDS.origin = eSub.origin;
  eSub.DDS.angles = eSub.angles;

  eSub.DDS LinkTo(eSub, "TAG_ORIGIN", (330, 0, 100), (0, 0, 0));

  eSub assign_animtree();

  eSub HidePart("origin_animate_jnt");
  eSub thread submarine_think();
  return eSub;
}

SDV_spawn(sSDVNumber, eNode) {
  eSDV = spawn("script_model", eNode.origin + (0, 0, 0));
  eSDV setModel("vehicle_submarine_sdv");
  eSDV.origin = eNode.origin;
  eSDV.angles = eNode.angles;

  assert(isDefined(eSDV));
  eSDV.animname = "sdv_" + sSDVNumber;
  eSDV assign_animtree();
  eSDV thread sdv_think();
  return eSDV;
}

sdv_think() {
  sFlagNameStarting = self.animname + "_starting";
  sFlagNameStopping = self.animname + "_stopping";
  sFlagNameArriving = self.animname + "_arriving";
  flag_init(sFlagNameStarting);
  flag_init(sFlagNameArriving);
  flag_init(sFlagNameStopping);

  self waittillmatch("single anim", "start");
  flag_set(sFlagNameStarting);
  self.moving = true;
  self notify("moving");

  switch (self.animname) {
    case "sdv_01":
      self waittillmatch("single anim", "passing");
      flag_set("sdv_01_passing");
      break;
  }
  self waittillmatch("single anim", "arrival");
  self notify("arriving");
  flag_set(sFlagNameArriving);

  self waittillmatch("single anim", "stop");
  self.moving = false;
  self notify("stopped_moving");
  flag_set(sFlagNameStopping);
  self waittillmatch("single anim", "end");
}

submarine_think() {}

dds_door_open() {
  self rotateto(self.angles + (0, -90, 0), 12, 2, 2);
  self playSound("hatch_and_bubbles");
}

killtrigger_ocean_off() {
  killtrigger_ocean = getent("killtrigger_ocean", "targetname");
  assert(isDefined(killtrigger_ocean));
  killtrigger_ocean notify("turn_off");
}

killtrigger_ocean_on() {
  killtrigger_ocean = getent("killtrigger_ocean", "targetname");
  assert(isDefined(killtrigger_ocean));
  killtrigger_ocean notify("turn_off");
  killtrigger_ocean endon("turn_off");
  while(true) {
    killtrigger_ocean waittill("trigger", other);
    if((isDefined(other)) && (isPlayer(other))) {
      dummy = spawn_tag_origin();
      dummy.origin = other.origin;
      dummy.angles = other.angles;
      other PlayerLinkToBlend(dummy, "tag_origin", .05);
      other kill();
      if(is_specialop()) {
        setDvar("ui_deadquote", &"OILRIG_MISSIONFAIL_WATER_DEATH");
        level notify("mission failed");
        maps\_utility::missionFailedWrapper();
      }
      break;
    }
  }
}

get_AI_with_script_noteworthy(sTeam, sNoteworthy) {
  assert(isDefined(sTeam));
  assert(isDefined(sNoteworthy));
  aTeamArray = getaiarray("allies");
  aAI = [];
  foreach(guy in aTeamArray) {
    if((isDefined(guy.script_noteworthy)) && (guy.script_noteworthy == sNoteworthy)) {
      aAI = array_add(aAI, guy);
    }
  }
  assertex(aAI.size < 2, "There is more than one AI with script_noteworthy of + " + sNoteworthy);
  if(aAI.size == 0) {
    assertmsg("there are no AI in team " + sTeam + " with script_noteworthy: " + sNoteworthy);
  }

  return aAI[0];
}

set_speed(speed) {
  level.playerSpeed = speed;
  self SetMoveSpeedScale(speed);
}

friendlies_shoot_heli_with_rockets(eHeli) {
  eHeli endon("death");
  zOffset = 32;
  playerSawRocket = false;
  eHeliTarget = undefined;
  guy = undefined;

  while(isDefined(eHeli)) {
    wait(randomfloatrange(15, 25));

    eFriendly = undefined;
    level.squad = remove_dead_from_array(level.squad);
    aFriendlies = get_array_of_farthest(level.player.origin, level.squad);
    while(!isDefined(eFriendly)) {
      wait(1.5);
      aFriendlies = remove_dead_from_array(aFriendlies);
      foreach(guy in aFriendlies) {
        if(!isDefined(guy)) {
          continue;
        }
        playerEye = level.player getEye();
        if(within_fov(playerEye, level.player getPlayerAngles(), guy.origin, level.cosine["45"])) {
          continue;
        } else {
          eHeliTarget = spawn("script_origin", eHeli.origin + (0, 0, -200));
          eHeli thread delete_on_death(eHeliTarget);
          eHeliTarget linkto(eHeli);
          if(!bullettracepassed(guy gettagorigin("tag_flash") + (0, 0, zOffset), eHeliTarget.origin, true, guy)) {
            eHeliTarget delete();
            continue;
          } else {
            eFriendly = guy;
            break;
          }
        }
      }
    }

    if((isDefined(eHeliTarget)) && (bullettracepassed(eFriendly gettagorigin("tag_flash") + (0, 0, zOffset), eHeliTarget.origin, true, eFriendly))) {
      if(!isDefined(eFriendly)) {
        continue;
      }
      MagicBullet("rpg_nodamage", eFriendly gettagorigin("tag_flash") + (0, 0, zOffset), eHeliTarget.origin);
      eHeliTarget delete();
      playerSawRocket = within_fov(level.player getEye(), level.player getPlayerAngles(), eHeli.origin, level.cosine["45"]);
      wait(.5);
      if(playerSawRocket) {
        dialogue_random_friendly_rocket_miss_heli();
      }
    }
  }
}

oilrig_stealth_monitor_on(bMissionFail) {
  level endon("oilrig_stealth_monitor_off");
  level.oilrigStealth = true;
  level thread oilrig_destructible_monitor();
  aAI = getaiarray("axis");
  array_thread(aAI, ::AI_stealth_monitor);
  level.player thread player_weapons_monitor();

  level waittill("stealth_broken");

  if(isDefined(bMissionFail)) {
    thread mission_fail_generic();
  }
}

AI_stealth_monitor() {
  self endon("death");
  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "not_alerted")) {
    return;
  }
  self notify("running_stealth_monitor_on_me");
  self endon("running_stealth_monitor_on_me");
  level endon("oilrig_stealth_monitor_off");
  self thread AI_player_distance_monitor();

  self addAIEventListener("grenade danger");
  self addAIEventListener("gunshot");
  self addAIEventListener("silenced_shot");
  self addAIEventListener("bulletwhizby");
  self addAIEventListener("projectile_impact");

  wait(.5);
  while(isalive(self)) {
    self waittill("ai_event", eventtype);
    if((eventtype == "grenade danger") || (eventtype == "damage") || (eventtype == "gunshot") || (eventtype == "bulletwhizby") || (eventtype == "projectile_impact") || (eventtype == "explode")) {
      break;
    }
  }
  wait(1);
  if(isalive(self)) {
    self thread AI_become_alerted();
  }
}

AI_become_alerted() {
  if((isDefined(self)) && (isalive(self)) && (!isDefined(self.scriptedDying))) {
    level notify("stealth_broken");
    self anim_stopanimscripted();
    self notify("alerted");
  }
}

player_weapons_monitor() {}

oilrig_stealth_monitor_off() {
  level notify("oilrig_stealth_monitor_off");
  level.oilrigStealth = false;
}

AI_player_distance_monitor() {
  self endon("death");
  level endon("oilrig_stealth_monitor_off");

  while(isDefined(self)) {
    wait(1);
    if(!within_fov(self.origin, self.angles, level.player.origin + (0, 0, 32), level.cosine["45"])) {
      continue;
    }
    if(!sighttracepassed(self.origin + (0, 0, 32), level.player.origin + (0, 0, 32), false, self)) {
      continue;
    }
    if(distancesquared(self.origin, level.player.origin) < level.stealthDistanceSquared) {
      break;
    }
  }
  self thread AI_become_alerted();
}

oilrig_destructible_monitor() {
  level endon("oilrig_stealth_monitor_off");
  level waittill("destructible_exploded");
  level notify("stealth_broken");
}

ignoreme_on_squad_and_player() {
  level.player.ignoreme = true;
  foreach(guy in level.squad) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.ignoreme = true;
    guy setthreatbiasgroup("oblivious");
  }
}

ignoreme_off_squad_and_player() {
  level.player.ignoreme = false;
  foreach(guy in level.squad) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.ignoreme = false;
    guy setthreatbiasgroup("allies");
  }
}

underwater_set_culldist(time, range) {
  wait time;
  SetCullDist(range);
}

vehicle_heli_land(eNode) {
  self endon("death");
  eNode waittill("trigger");
  self notify("landing");
  self vehicle_detachfrompath();
  self setgoalyaw(eNode.angles[1]);
  vehicle_land_beneath_node(undefined, eNode);
  self notify("landed");
}

init_air_vehicle_flags() {
  array1 = getEntArray("script_origin", "classname");
  aAirNodes = array_merge(array1, level.struct);
  array_thread(aAirNodes, ::air_nodes_think);
}

air_nodes_think() {
  if(!isDefined(self.script_flag)) {
    return;
  }
  flag_init(self.script_flag);
  if(getDvar("oilrig_debug") == "1") {
    self thread debug_message(self.script_flag, self.origin, 9999);
  }
  self waittill("trigger");
  flag_set(self.script_flag);
  if(getDvar("oilrig_debug") == "1") {
    iPrintlnbold("flag: " + self.script_flag + " has been set");
  }
}

friendly_speed_adjustment_on() {
  array_thread(level.squad, ::friendly_adjust_movement_speed);
}

friendly_speed_adjustment_off() {
  foreach(guy in level.squad) {
    if(!isDefined(guy)) {
      continue;
    }
    guy notify("stop_adjust_movement_speed");
    guy.moveplaybackrate = 1.0;
  }
}

friendly_adjust_movement_speed() {
  if(!isDefined(self)) {
    return;
  }
  self notify("stop_adjust_movement_speed");
  self endon("death");
  self endon("stop_adjust_movement_speed");

  for(;;) {
    wait randomfloatrange(.5, 1.5);

    while(friendly_should_speed_up()) {
      self.moveplaybackrate = 2.5;
      wait 0.05;
    }

    self.moveplaybackrate = 1.0;
  }
}

friendly_should_speed_up() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  prof_begin("friendly_movement_rate_math");

  if(!isDefined(self.goalpos)) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  if(distanceSquared(self.origin, self.goalpos) <= level.goodFriendlyDistanceFromPlayerSquared) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  if(within_fov(level.player.origin, level.player getPlayerAngles(), self.origin, level.cosine["60"])) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  prof_end("friendly_movement_rate_math");

  return true;
}

fx_management() {
  level.effects_underwater = [];
  level.effects_lower_rig = [];
  level.effects_mid_decks = [];
  level.effects_top_deck = [];

  effects_underwater = getent("effects_underwater", "script_noteworthy");
  effects_lower_rig = getent("effects_lower_rig", "script_noteworthy");
  effects_mid_decks = getent("effects_mid_decks", "script_noteworthy");
  effects_top_deck = getent("effects_top_deck", "script_noteworthy");

  dummy = spawn("script_origin", (0, 0, 0));
  for(i = 0; i < level.createfxent.size; i++) {
    EntFx = level.createfxent[i];
    dummy.origin = EntFx.v["origin"];
    if(dummy istouching(effects_underwater)) {
      level.effects_underwater[level.effects_underwater.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_lower_rig)) {
      level.effects_lower_rig[level.effects_lower_rig.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_mid_decks)) {
      level.effects_mid_decks[level.effects_mid_decks.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_top_deck)) {
      level.effects_top_deck[level.effects_top_deck.size] = EntFx;
      continue;
    }
  }
  dummy delete();
}

compass_triggers_think() {
  assertex(isDefined(self.script_noteworthy), "compassTrigger at " + self.origin + " needs to have a script_noteworthy with the name of the minimap to use");
  while(true) {
    wait(1);
    self waittill("trigger");
    setsaveddvar("ui_hidemap", 0);
    maps\_compass::setupMiniMap(self.script_noteworthy);
  }
}

AI_drone_think() {}

underwater_fog_approaching_rig(transitionTime) {
  setExpFog(0, 482, 0.0461649, 0.25026, 0.221809, 1, transitionTime, 0.0501764, 0.0501764, 0.0501764, (-0.0563281, 0.0228246, -1), 58.2299, 87.711, 1.48781);
}

friendlies_shielded_during_breach(sFlagToStart, sFlagToEnd) {
  flag_wait(sFlagToStart);
  level.breachfriendlies = remove_dead_from_array(level.breachfriendlies);
  foreach(dude in level.breachfriendlies) {
    dude.disableDamageShieldPain = true;
    dude disable_pain();
  }
  flag_wait(sFlagToEnd);
  level.breachfriendlies = remove_dead_from_array(level.breachfriendlies);
  foreach(dude in level.breachfriendlies) {
    dude.disableDamageShieldPain = undefined;
    dude enable_pain();
  }
}

redshirt_trigger_think() {
  while(true) {
    self waittill("trigger");
    level.breachfriendlies = remove_dead_from_array(level.breachfriendlies);
    iRedshirtsToSpawn = undefined;
    aSpawners = undefined;
    level.squad = remove_dead_from_array(level.squad);
    guy = undefined;
    if(level.squad.size < level.squadsize) {
      aSpawners = getEntArray(self.target, "targetname");
      assertex(aSpawners.size > 0, "Redshirt_trigger at " + self.origin + " needs to target at least 1 spawner");
      iRedshirtsToSpawn = (level.squadsize - level.squad.size);
      for(i = 0; i < iRedshirtsToSpawn; i++) {
        guy = aSpawners[i] spawn_ai(true);
        if(isDefined(guy)) {
          guy set_force_color("r");
          level.squad = array_add(level.squad, guy);
          guy thread friendly_redshirt_think();
        }
      }
    }
    wait(10);
  }
}

friendly_redshirt_think() {
  self endon("death");

  level.friendly03 = self;
}

destructible_cleanup() {
  if(!isDefined(self)) {
    return;
  }
  self common_scripts\_destructible::cleanupVars();
  if(isDefined(self)) {
    self delete();
  }
}

AI_delete(excluders) {
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  if((isDefined(excluders)) && (excluders.size > 0)) {
    if(is_in_array(excluders, self)) {
      return;
    }
  }
  if(isDefined(self.magic_bullet_shield)) {
    self stop_magic_bullet_shield();
  }
  if(!isSentient(self)) {}

  self delete();
}

all_ai_dead_in_volumes(aVolumes) {
  aAI = [];
  foreach(volume in aVolumes) {
    array = volume get_ai_touching_volume();
    if(array.size) {
      aAI = array_merge(aAI, array);
    }
  }
  if(aAI.size) {
    return false;
  } else {
    return true;
  }
}

force_weapon_when_player_not_looking(weaponName) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  while(within_fov(level.player.origin, level.player getplayerangles(), self.origin, level.cosine["45"])) {
    wait 1;
  }
  self forceUseWeapon(weaponName, "primary");
}

AI_left_deck3_dudes_think() {
  if(!flag("left_deck3_dudes_spawned")) {
    flag_set("left_deck3_dudes_spawned");
  }
}

AI_turret_guys_think() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  waittillframeend;
  if(level.gameskill == 0) {
    self delete();
  }
}