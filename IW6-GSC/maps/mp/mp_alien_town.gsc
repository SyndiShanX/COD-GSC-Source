/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_town.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_hive;

main() {
  level.additional_boss_weapon = ::update_weapon_placement;

  level.introscreen_line_1 = &"MP_ALIEN_TOWN_INTRO_LINE_1";
  level.introscreen_line_2 = &"MP_ALIEN_TOWN_INTRO_LINE_2";
  level.introscreen_line_3 = &"MP_ALIEN_TOWN_INTRO_LINE_3";
  level.introscreen_line_4 = &"MP_ALIEN_TOWN_INTRO_LINE_4";
  level.intro_dialogue_func = ::mp_alien_town_intro_dialog;
  level.postIntroscreenFunc = ::mp_alien_town_post_intro_func;
  level.custom_onStartGameTypeFunc = ::mp_alien_town_onStartGameTypeFunc;
  level.alien_character_cac_table = "mp/alien/alien_cac_presets.csv";
  level.initial_spawn_loc_override_func = ::player_initial_spawn_loc_override;
  level.custom_pillageInitFunc = ::mp_alien_town_pillage_init;
  level.tryUseDroneHive = ::mp_alien_town_try_use_drone_hive;

  level._effect["alien_ark_gib"] = loadfx("vfx/gameplay/alien/vfx_alien_ark_gib_01");
  level.custom_alien_death_func = maps\mp\alien\_death::general_alien_custom_death;

  if(is_chaos_mode())
    level.adjust_spawnLocation_func = ::town_chaos_adjust_spawnLocation;

  alien_mode_enable("kill_resource", "wave", "airdrop", "lurker", "collectible", "loot", "pillage", "challenge", "outline", "scenes");
  alien_areas = ["lodge", "city", "lake"];
  alien_area_init(alien_areas);
  level.alien_challenge_table = "mp/alien/mp_alien_town_challenges.csv";
  level.include_default_challenges = true;
  level.include_default_achievements = true;
  level.include_default_unlocks = true;
  level.escape_cycle = 15;

  level.ricochetDamageMax = 10;
  level.hardcore_spawn_multiplier = 1.0;
  level.hardcore_damage_scalar = 1.0;
  level.hardcore_health_scalar = 1.0;
  level.hardcore_reward_scalar = 1.0;
  level.hardcore_score_scalar = 1.25;

  level.casual_spawn_multiplier = 1.0;
  level.casual_damage_scalar = 0.45;
  level.casual_health_scalar = 0.45;
  level.casual_reward_scalar = 1.0;
  level.casual_score_scalar = 0.5;

  maps\mp\mp_alien_town_precache::main();
  maps\createart\mp_alien_town_art::main();
  maps\mp\mp_alien_town_fx::main();

  setDvar("r_reactiveMotionWindAmplitudeScale", 0.15);

  level.craftingEasy = 0;
  level.craftingMedium = 0;
  level.craftingHard = 0;

  maps\mp\_load::main();

  setdvar_cg_ng("sm_sunShadowScale", 0.5, 1.0);

  setdvar_cg_ng("r_specularColorScale", 2.5, 9.01);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "woodland";

  blocker_hives = [];
  blocker_hives[5] = "lodge_lung_3";
  blocker_hives[9] = "city_lung_5";
  cycle_end_area_list = [5, 9];
  maps\mp\gametypes\aliens::setup_cycle_end_area_list(cycle_end_area_list);
  maps\mp\gametypes\aliens::setup_blocker_hives(blocker_hives);
  maps\mp\gametypes\aliens::setup_last_hive("crater_lung");

  thread maps\mp\alien\_alien_class_skills_main::main();
  level.custom_onSpawnPlayer_func = ::mp_alien_town_onSpawnPlayer_func;

  crater_dependencies = ["lake_lung_1", "lake_lung_2", "lake_lung_3", "lake_lung_4", "lake_lung_5", "lake_lung_6"];
  add_hive_dependencies("crater_lung", crater_dependencies);
  lodge_lung_dependencies = ["mini_lung"];
  add_hive_dependencies("lodge_lung_1", lodge_lung_dependencies);
  add_hive_dependencies("lodge_lung_2", lodge_lung_dependencies);
  add_hive_dependencies("lodge_lung_3", lodge_lung_dependencies);
  add_hive_dependencies("lodge_lung_4", lodge_lung_dependencies);
  add_hive_dependencies("lodge_lung_5", lodge_lung_dependencies);
  add_hive_dependencies("lodge_lung_6", lodge_lung_dependencies);

  level.hintprecachefunc = ::town_hint_precache;

  TIME_LEFT_RANK_0 = 85000;
  TIME_LEFT_RANK_1 = 95000;
  TIME_LEFT_RANK_2 = 105000;
  TIME_LEFT_RANK_3 = 240000;
  maps\mp\alien\_persistence::register_LB_escape_rank([0, TIME_LEFT_RANK_0, TIME_LEFT_RANK_1, TIME_LEFT_RANK_2, TIME_LEFT_RANK_3]);

  level.should_play_next_hive_vo_func = ::should_play_next_hive_vo_func;

  register_encounters();

  restore_fog_setting();
  nuke_fog_setting();
  rescue_waypoint_setting();
  set_spawn_table();

  amb_quakes();

  level thread TU_electric_fence_fix();

  game["thermal_vision"] = "mp_alien_town_thermal";
  VisionSetThermal(game["thermal_vision"]);

  game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";

  level thread initSpawnableCollision();
  level.skip_radius_damage_on_puddles = true;

  level thread maps\mp\alien\_lasedStrike_alien::init();
  level thread maps\mp\alien\_switchblade_alien::init();
  array_thread(getEntArray("killstreak_attack_chopper", "targetname"), ::attack_chopper_monitorUse);
}

register_encounters() {
  if(is_chaos_mode()) {
    maps\mp\gametypes\aliens::register_encounter(::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank);

    maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank);
    return;
  }

  maps\mp\gametypes\aliens::register_encounter(::encounter_init, undefined, undefined, undefined, ::encounter_init, maps\mp\alien\_globallogic::blank);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_1st_area, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_lodge, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_lodge, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_lodge, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::blocker_hive, 1, 1, true, ::skip_hive, ::jump_to_lodge, ::beat_blocker_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_city, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_city, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_city, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::blocker_hive, 1, 1, true, ::skip_hive, ::jump_to_city, ::beat_blocker_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_cabin, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_cabin, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_cabin, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_cabin, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(::regular_hive, 1, undefined, undefined, ::skip_hive, ::jump_to_crater_hive, ::beat_regular_hive);

  maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_airdrop::escape, undefined, undefined, undefined, ::skip_escape, ::jump_to_escape);
}

initSpawnableCollision() {
  level waittill("spawn_nondeterministic_entities");

  collision1 = GetEnt("player512x512x8", "targetname");
  collision1Ent = spawn("script_model", (-5332.5, -4394, 774.5));
  collision1Ent.angles = (90, 274, 7);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);
}

encounter_init() {
  maps\mp\alien\_drill::init_drill();

  init_hives();

  maps\mp\alien\_airdrop::init_escape();

  maps\mp\alien\_gamescore::init_eog_score_components(["hive", "escape", "relics"]);

  maps\mp\alien\_gamescore::init_encounter_score_components(["challenge", "drill", "team", "team_blocker", "personal", "personal_blocker", "escape"]);
}

town_hint_precache() {
  all_hints_array = [];

  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_MAUL"] = &"ALIEN_COLLECTIBLES_PICKUP_MAUL";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_AK12"] = &"ALIEN_COLLECTIBLES_PICKUP_AK12";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_M27"] = &"ALIEN_COLLECTIBLES_PICKUP_M27";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_PROPANE_TANK"] = &"ALIEN_COLLECTIBLES_PICKUP_PROPANE_TANK";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_MK32"] = &"ALIEN_COLLECTIBLES_PICKUP_MK32";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_HONEYBADGER"] = &"ALIEN_COLLECTIBLES_PICKUP_HONEYBADGER";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_VKS"] = &"ALIEN_COLLECTIBLES_PICKUP_VKS";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_FP6"] = &"ALIEN_COLLECTIBLES_PICKUP_FP6";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_KRISS"] = &"ALIEN_COLLECTIBLES_PICKUP_KRISS";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_MICROTAR"] = &"ALIEN_COLLECTIBLES_PICKUP_MICROTAR";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_P226"] = &"ALIEN_COLLECTIBLES_PICKUP_P226";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_L115A3"] = &"ALIEN_COLLECTIBLES_PICKUP_L115A3";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_SC2010"] = &"ALIEN_COLLECTIBLES_PICKUP_SC2010";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_KAC"] = &"ALIEN_COLLECTIBLES_PICKUP_KAC";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_IMBEL"] = &"ALIEN_COLLECTIBLES_PICKUP_IMBEL";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_MTS255"] = &"ALIEN_COLLECTIBLES_PICKUP_MTS255";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_PANZERFAUST"] = &"ALIEN_COLLECTIBLES_PICKUP_PANZERFAUST";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_CBJMS"] = &"ALIEN_COLLECTIBLES_PICKUP_CBJMS";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_PP19"] = &"ALIEN_COLLECTIBLES_PICKUP_PP19";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_VEPR"] = &"ALIEN_COLLECTIBLES_PICKUP_VEPR";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_BREN"] = &"ALIEN_COLLECTIBLES_PICKUP_BREN";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_RGM"] = &"ALIEN_COLLECTIBLES_PICKUP_RGM";
  all_hints_array["ALIEN_COLLECTIBLES_PICKUP_G28"] = &"ALIEN_COLLECTIBLES_PICKUP_G28";

  return all_hints_array;
}

rescue_waypoint_setting() {
  escape_ent = getent("escape_zone", "targetname");
  assertex(isDefined(escape_ent), "Level missing escape_zone");
  final_waypoint_loc = escape_ent.origin;

  level.rescue_waypoint_locs = [];
  level.rescue_waypoint_locs[0] = (-3152, 1356, 610);
  level.rescue_waypoint_locs[1] = (-5081, -2715, 522);
  level.rescue_waypoint_locs[2] = (-1105, -1760, 831);
  level.rescue_waypoint_locs[3] = final_waypoint_loc;
  level.rescue_waypoint_locs[4] = final_waypoint_loc;
}

restore_fog_setting() {
  ent = spawnStruct();

  ent.HDRColorIntensity = 1;
  ent.HDRSunColorIntensity = 1;
  ent.startDist = 0;
  ent.halfwayDist = 2048;
  ent.red = 0.206;
  ent.green = 0.255;
  ent.blue = 0.317;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 0;

  ent.sunFogEnabled = 1;
  ent.sunRed = 0.791;
  ent.sunGreen = 0.435;
  ent.sunBlue = 0.331;
  ent.sunDir = (-0.893, 0.273, 0.35);
  ent.sunBeginFadeAngle = 8;
  ent.sunEndFadeAngle = 64;
  ent.normalFogScale = 0.06;

  ent.skyFogIntensity = 1.0;
  ent.skyFogMinAngle = 30;
  ent.skyFogMaxAngle = 67;

  level.restore_fog_setting = ent;
}
nuke_fog_setting() {
  ent = spawnStruct();

  if(is_gen4()) {
    ent.startDist = 0;
    ent.halfwayDist = 2048;
    ent.red = 0.498;
    ent.green = 0.343;
    ent.blue = 0.192;
    ent.HDRColorIntensity = 1.25;
    ent.maxOpacity = 0.5;
    ent.transitionTime = 0;

    ent.sunFogEnabled = 1;
    ent.sunRed = 0.791;
    ent.sunGreen = 0.435;
    ent.sunBlue = 0.331;
    ent.HDRSunColorIntensity = 1.25;
    ent.sunDir = (-0.893, 0.273, 0.35);
    ent.sunBeginFadeAngle = 0;
    ent.sunEndFadeAngle = 160;
    ent.normalFogScale = 0.01;

    ent.skyFogIntensity = 0.9;
    ent.skyFogMinAngle = 30;
    ent.skyFogMaxAngle = 71;
  } else {
    ent.startDist = 0;
    ent.halfwayDist = 2048;
    ent.red = 0.498;
    ent.green = 0.343;
    ent.blue = 0.192;
    ent.maxOpacity = 0.5;
    ent.transitionTime = 0;

    ent.sunFogEnabled = 1;
    ent.sunRed = 0.791;
    ent.sunGreen = 0.435;
    ent.sunBlue = 0.331;
    ent.sunDir = (-0.893, 0.273, 0.35);
    ent.sunBeginFadeAngle = 0;
    ent.sunEndFadeAngle = 160;
    ent.normalFogScale = 0.01;

    ent.skyFogIntensity = 0.9;
    ent.skyFogMinAngle = 30;
    ent.skyFogMaxAngle = 71;
    ent.HDROverride = "alien_nuke_HDR";
  }

  level.nuke_fog_setting = ent;
}

test_meteoroid() {
  wait 10;

  thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid("minion");
  wait 2;
  thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid("minion");
  wait 10;
  thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid("minion");
}

amb_quakes() {
  level.quake_trigs = getEntArray("quake_trig", "targetname");

  foreach(quake_trig in level.quake_trigs)
  quake_trig thread run_quake_scene();
}

run_quake_scene() {
  level endon("game_ended");

  wait 5;

  self.movables = [];
  self.fx = [];

  if(isDefined(self.target)) {
    targeted_ents = getEntArray(self.target, "targetname");
    foreach(targeted_ent in targeted_ents) {
      if(!isDefined(targeted_ent.script_noteworthy)) {
        continue;
      }
      if(targeted_ent.script_noteworthy == "moveable")
        self.movables[self.movables.size] = targeted_ent;

      if(targeted_ent.script_noteworthy == "fx")
        self.fx[self.fx.size] = targeted_ent;
    }
  }

  inner_radius = self.radius;
  outter_radius = self.script_radius;
  quake_origin = self.origin;

  count = 1;
  while(count) {
    foreach(player in level.players) {
      if(isalive(player) && player IsTouching(self)) {
        player playSound("elm_quake_rumble");
        wait 0.25;

        Earthquake(0.3, 3, quake_origin, outter_radius);
        PhysicsJitter(quake_origin, outter_radius, inner_radius, 4.0, 6.0);
        player PlayRumbleOnEntity("heavy_3s");

        foreach(movable in self.movables)
        self thread quake_rotate(movable);

        count--;
        wait RandomIntRange(20, 30);
        break;
      }
    }

    wait 1;
  }
}

quake_rotate(movable_ent) {
  self notify("moving");
  self endon("moving");

  moveto_ent = getstruct(movable_ent.target, "targetname");
  assert(isDefined(moveto_ent));

  original_angles = movable_ent.angles;
  moveto_angles = moveto_ent.angles;
  oscillation = 5;
  move_interval = 0.8;

  for(i = 0; i < oscillation; i++) {
    angles = angles_frac(original_angles, moveto_angles, 1 - (i / oscillation));
    interval = move_interval * ((i + 1) / oscillation);

    movable_ent rotateto(angles, interval);
    wait interval;
    movable_ent rotateto(original_angles, interval);
    wait interval;
  }
}

angles_frac(angles_1, angles_2, fraction) {
  fraction *= fraction;

  pitch = angles_1[0] + (angles_2[0] - angles_1[0]) * fraction;
  yaw = angles_1[1] + (angles_2[1] - angles_1[1]) * fraction;
  roll = angles_1[2] + (angles_2[2] - angles_1[2]) * fraction;

  return (pitch, yaw, roll);
}

mp_alien_town_intro_dialog() {
  wait(2);
  sound_ent = spawn("script_origin", (0, 0, 0));
  sound_ent thread maps\mp\alien\_music_and_dialog::play_pilot_vo("so_alien_plt_introlastsquad");

  level waittill("introscreen_over");
  sound_ent delaythread(0.067, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_introunearthed");
  sound_ent delaythread(4.667, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_plt_introdrill");
  sound_ent delaythread(15.767, maps\mp\alien\_music_and_dialog::play_pilot_vo, "so_alien_goodluck");
  level delaythread(17.5, maps\mp\alien\_music_and_dialog::PlayVOForIntro);
  wait(20);
  sound_ent delete();
}

should_play_next_hive_vo_func() {
  if(level.cycle_count + 1 == 14)
    return false;

  if(flag_exist("hives_cleared") && flag("hives_cleared"))
    return false;

  return (!isDefined(level.blocker_hives[level.cycle_count + 1]));
}

mp_alien_town_post_intro_func() {
  foreach(player in level.players) {
    if(isDefined(player.default_starting_pistol))
      player SwitchToWeapon(player.default_starting_pistol);
  }
}

mp_alien_town_onStartGameTypeFunc() {
  level mp_alien_town_pillage_modification();
  level alter_drill_locations();
}

mp_alien_town_pillage_modification() {
  distcheck = 10 * 10;

  pillage_areas = getstructarray("pillage_area", "targetname");
  foreach(index, area in pillage_areas) {
    pillage_spots = getstructarray(area.target, "targetname");
    foreach(spot in pillage_spots) {
      if(DistanceSquared(spot.origin, (-3771, 1288, 830)) <= distcheck) {
        spot.origin = spot.origin + (0, 15, -4);
        return;
      }
    }
  }
}

alter_drill_locations() {
  set_drill_location("city_lung_4", (-4285.85, -3098.1, 550.75), (2.87763, 77.0197, -2.07208));
  set_drill_location("lake_lung_1", (-3286.2, 699.453, 671.517), (356.167, 249.913, 1.77588));
  set_drill_location("lake_lung_2", (-1620.41, 1558.15, 758), (0, 161.813, 0));
  set_drill_location("lake_lung_3", (-3542.69, 2058.54, 570.984), (0.647456, 186.237, -1.42968));
  set_drill_location("lake_lung_4", (-2977.48, 1790.44, 565.36), (358.167, 184.775, -5.04523));
  set_drill_location("lake_lung_6", (-2769.68, 3698.48, 419.95), (359.953, 22.833, -10.9619));
  set_drill_location("crater_lung", (-4375.36, 3138.18, 285.152), (356.676, 249.752, 12.7989));
}

set_drill_location(target_name, location, orientation) {
  drillLocation = GetEnt(target_name, "target");

  if(isDefined(drillLocation)) {
    drillLocation.origin = location;
    drillLocation.angles = orientation;
  }
}

TU_electric_fence_fix() {
  while(!isDefined(level.electric_fences))
    wait 0.05;

  wait 5;

  foreach(fence in level.electric_fences) {
    target_name = fence.generator.target;
    target_name_array = StrTok(fence.generator.target, "_");
    if(target_name_array.size > 0) {
      foreach(name in target_name_array) {
        if(IsSubStr(name, "auto"))
          target_name = name;
      }
    }

    if(isDefined(fence.generator.target) && (target_name == "auto92"))
      fence.shock_trig.origin += (0, 0, 30);

    if(isDefined(fence.generator.target) && (target_name == "auto3")) {
      fence.shock_trig.origin += (102, 64, 30);
      fence.shock_damage = 800;
    }
  }
}

player_initial_spawn_loc_override() {
  if(alien_mode_has("nogame")) {
    return;
  }
  if(is_chaos_mode()) {
    chaos_player_initial_spawn_loc_override();
    return;
  }

  AFTER_NUKE_ACTIVATION_SPAWN_ORIGIN = (-4297, 3215, 303);
  AFTER_NUKE_ACTIVATION_SPAWN_ANGLES = (0, -6, 0);

  if(flag("nuke_countdown")) {
    self.forceSpawnOrigin = AFTER_NUKE_ACTIVATION_SPAWN_ORIGIN;
    self.forceSpawnAngles = AFTER_NUKE_ACTIVATION_SPAWN_ANGLES;
  }
}

skip_escape() {}

chaos_player_initial_spawn_loc_override() {
  location_list = [];
  angle_list = [];
  switch (get_chaos_area()) {
    case "lodge":
      location_list = [(410, -1084, 708.838), (559, -1239, 705.007), (753, -1115, 709.901), (532, -930, 703.947)];
      angle_list = [(0, 210, 0), (0, 210, 0), (0, 345, 0), (0, 345, 0)];
      break;

    case "city":
      location_list = [(-4449, -2801, 535.798), (-4496, -3085, 539.619), (-4300, -3088, 549.954), (-4209, -3326, 552.298)];
      angle_list = [(0, 210, 0), (0, 210, 0), (0, 345, 0), (0, 345, 0)];
      break;

    case "cabin":
      location_list = [(-2105, 2215, 580), (-2029, 2103, 579), (-3462, 1786, 573), (-3451, 1892, 565)];
      angle_list = [(0, 210, 0), (0, 210, 0), (0, 345, 0), (0, 345, 0)];
      break;
  }

  self.forceSpawnOrigin = location_list[level.players.size];
  self.forceSpawnAngles = angle_list[level.players.size];
}

mp_alien_town_try_use_drone_hive(rank, num_missiles, missile_name, altitude, baby_missile_name) {
  self maps\mp\alien\_switchblade_alien::tryUseDroneHive(rank, num_missiles, missile_name, altitude, baby_missile_name);
}

/

move_clip_brush_cabin_to_city() {
  clip = GetEnt("player256x256x256", "targetname");
  clip.origin = (-5374, -2662, 498);
  clip.angles = (0, 248, 0);
}

move_clip_brush_cabin_to_lake() {
  clip = GetEnt("player128x128x256", "targetname");
  clip.origin = (-3448, 2256, 618);
  clip.angles = (270, 344, -8.36695);
}

delete_intro_heli_clip() {
  helibrush = GetEnt("helicoptercoll", "targetname");
  helibrush delete();
}

set_hardcore_extinction_spawn_table() {
  if(isPlayingSolo())
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_town_hardcore_sp.csv";
  else
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_town_hardcore.csv";
}

mp_alien_town_onSpawnPlayer_func() {
  if(!isDefined(level.setSkillsFlag)) {
    level.setSkillsFlag = true;
    flag_set("give_player_abilities");
  }
  self thread maps\mp\alien\_alien_class_skills_main::assign_skills();
}

update_weapon_placement() {
  items = getstructarray("item", "targetname");

  foreach(world_item in items) {
    if(!isDefined(world_item.script_noteworthy)) {
      continue;
    }
    if(world_item.script_noteworthy == "weapon_iw6_alienhoneybadger_mp") {
      world_item.script_noteworthy = "weapon_iw6_alienak12_mp";
      world_item.origin = (-1503.68, 1942.12, 598.9);
      break;
    }
  }
  return undefined;
}