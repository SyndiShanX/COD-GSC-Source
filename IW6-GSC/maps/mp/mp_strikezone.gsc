/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_strikezone.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\mp_strikezone_precache::main();
  maps\createart\mp_strikezone_art::main();
  maps\mp\mp_strikezone_fx::main();

  maps\mp\_teleport::main();
  maps\mp\_teleport::teleport_set_minimap_for_zone("start", "compass_map_mp_strikezone");
  maps\mp\_teleport::teleport_set_minimap_for_zone("destroyed", "compass_map_mp_strikezone_after");
  maps\mp\_teleport::teleport_set_a10_splines_for_zone("start", [1, 2, 3, 4], [2, 1, 4, 3]);
  maps\mp\_teleport::teleport_set_a10_splines_for_zone("destroyed", [5, 6, 7, 8], [6, 5, 8, 7]);
  maps\mp\_teleport::teleport_origin_use_offset(false);

  maps\mp\_teleport::teleport_set_pre_func(::pre_teleport, "destroyed");
  maps\mp\_teleport::teleport_set_post_func(::post_teleport, "destroyed");

  maps\mp\_teleport::teleport_set_post_func(::pre_teleport_to_start, "start");

  level.doNuke_fx = ::doNuke_fx_strikezone;

  level thread sunflare();
  level thread flip_sky();
  level thread init_destroyed_zone();

  level.mapCustomCrateFunc = ::strikezoneCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::strikezoneCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::strikezoneCustomBotKillstreakFunc;

  maps\mp\_load::main();
  thread maps\mp\_fx::func_glass_handler();

  flag_init("nuke_event_active");

  level.vision_set_stage = 0;

  setdvar("r_reactiveMotionWindAmplitudeScale", .3);
  setdvar("r_reactiveMotionWindFrequencyScale", .5);

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_diffuseColorScale", 1.639, 1.5);
  setdvar_cg_ng("r_specularcolorscale", 2.5, 3);
  setdvar("r_ssaorejectdepth", 1500);
  setdvar("r_ssaofadedepth", 1200);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "desert";

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.6");
  } else if(level.xenon) {
    setdvar("sm_sunShadowScale", "0.7");
  }

  level.pre_org = getstruct("world_origin_pre", "targetname");
  level.post_org = getstruct("world_origin_post", "targetname");
  level.mid_z = 0;
  if(isDefined(level.post_org) && isDefined(level.pre_org)) {
    level.mid_z = (level.pre_org.origin[2] + level.post_org.origin[2]) / 2;
  }

  flag_init("teleport_to_destroyed");
  flag_init("start_fog_fade_in");
  flag_init("start_fog_fade_out");

  level thread nuke_activate_at_end_of_match();

  level thread fall_objects();

  level thread ronnie_talks();

  level thread connect_watch();

  level thread vision_set_stage_test();

  level thread initExtraCollision();
}

vision_set_stage_test() {
  SetDevDvar("vision_set_stage_fade_time", "1");
  dvar_name = "vision_set_stage";
  default_value = -1;
  SetDevDvarIfUninitialized(dvar_name, default_value);
  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(value < 0) {
      waitframe();
    } else {
      set_vision_set_stage(value, GetDvarFloat("vision_set_stage_fade_time"));
      SetDvar(dvar_name, default_value);
    }
  }
}

initExtraCollision() {
  collision1 = GetEnt("clip128x128x128", "targetname");
  collision1Ent = spawn("script_model", (1488, 448, 34992));
  collision1Ent.angles = (0, 0, 0);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  collision2 = GetEnt("clip256x256x8", "targetname");
  collision2Ent = spawn("script_model", (-1589.73, 167.941, 34846));
  collision2Ent.angles = (7.64427, 359.534, -40.4325);
  collision2Ent CloneBrushmodelToScriptmodel(collision2);

  if(is_gen4()) {
    collision3 = GetEnt("player256x256x128", "targetname");
    collision3Ent = spawn("script_model", (1091.96, -1218, 35088));
    collision3Ent.angles = (0, 60, -90);
    collision3Ent CloneBrushmodelToScriptmodel(collision3);

    collision4 = GetEnt("player256x256x128", "targetname");
    collision4Ent = spawn("script_model", (1314.31, -727.89, 34967.3));
    collision4Ent.angles = (345.369, 351.123, 18.9223);
    collision4Ent CloneBrushmodelToScriptmodel(collision4);

    collision5 = GetEnt("player256x256x128", "targetname");
    collision5Ent = spawn("script_model", (955.98, 485.142, 34875.7));
    collision5Ent.angles = (336.26, 306.702, -30.7675);
    collision5Ent CloneBrushmodelToScriptmodel(collision5);
  }
}

flip_sky() {
  sky = GetEnt("after_sky", "targetname");
  if(isDefined(sky)) {
    sky.angles = (180, 0, 0);
  }
}

connect_watch() {
  while(1) {
    level waittill("connected", player);
    if(isDefined(level.vision_set_stage)) {
      player VisionSetStage(level.vision_set_stage, .1);
    }

    player thread watch_throwing_knife();
    PlayFXOnTagForClients(level._effect["vfx_sunflare"], level.sunflare_ent, "tag_origin", player);
  }
}

watch_throwing_knife() {
  self endon("disconnect");

  while(1) {
    self waittill("grenade_fire", knife, weaponName);
    if(isDefined(weaponName) && isDefined(knife) && weaponName == "throwingknife_mp") {
      level thread watch_throwing_knife_land(knife);
    }
  }
}

watch_throwing_knife_land(knife) {
  knife endon("death");

  knife waittill("missile_stuck", hitEnt);

  level notify("hit_by_knife", knife, hitEnt);
}

sunflare() {
  pre_nuke_origin = (-2827.98, -25930.5, 12914.9);
  pre_nuke_angles = (270, 0, 0);

  post_nuke_origin = (-1831.25, -12492.3, 41020.6);
  post_nuke_angles = (270, 0, 0);

  level.sunflare_ent = spawn("script_model", pre_nuke_origin);
  level.sunflare_ent setModel("tag_origin");
  level.sunflare_ent.angles = pre_nuke_angles;

  flag_wait("teleport_setup_complete");
  if(level.teleport_zone_current != "start") {
    level.sunflare_ent.origin = post_nuke_origin;
    level.sunflare_ent.angles = post_nuke_angles;
  }

  while(1) {
    level waittill("teleport_to_zone", new_zone_name);
    if(new_zone_name == "start") {
      level.sunflare_ent.origin = pre_nuke_origin;
      level.sunflare_ent.angles = pre_nuke_angles;
    } else {
      level.sunflare_ent.origin = post_nuke_origin;
      level.sunflare_ent.angles = post_nuke_angles;
    }
  }
}

init_destroyed_zone() {
  flag_wait("teleport_setup_complete");
  if(level.teleport_zone_current != "start") {
    destroyed_fire_fx();
  }
}

doNuke_fx_strikezone() {
  if(!level.allow_level_killstreak) {
    return false;
  }

  game["player_holding_level_killstrek"] = false;
  disable_strikezone_rog();
  thread maps\mp\_teleport::teleport_to_zone("destroyed");

  return true;
}

pre_teleport() {
  level notify("nuke_start");
  flag_set("nuke_event_active");

  level.allow_level_killstreak = false;

  level.disable_killcam = true;
  maps\mp\gametypes\_damage::eraseFinalKillCam();

  if(!levelFlag("post_game_level_event_active")) {
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(level.nukeTimer - 2);
  }

  fx_to_flash_time = 2;
  slow_mo_time = .2;
  flash_fade_in_time = .1;

  level thread nuke_earthquake(.3, fx_to_flash_time);
  thread nuke_fx_exploders(2);
  level.nuke_fx_start_time = GetTime();
  exploder(60);
  level thread nuke_sounds();

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(fx_to_flash_time);

  foreach(player in level.players) {
    if(isDefined(player.setSpawnPoint)) {
      player maps\mp\perks\_perkfunctions::deleteTI(player.setSpawnPoint);
    }
  }

  level thread nuke_slow_motion(.1, slow_mo_time + flash_fade_in_time, 0);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(slow_mo_time);

  level thread nuke_earthquake(.5, 5);
  level thread rumble_all_players("hijack_plane_medium");
  level thread nuke_ground_tilt();
  if(!levelFlag("post_game_level_event_active") && isDefined(level.nukeInfo.team)) {
    level thread maps\mp\killstreaks\_nuke::nukeDeath();
  }

  VisionSetNaked("mp_strikezone_flash", flash_fade_in_time);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(flash_fade_in_time);
  wait .1;
  exploder(70, undefined, (level.nuke_fx_start_time / 1000));
  flag_set("teleport_to_destroyed");
}

post_teleport() {
  level thread maps\mp\killstreaks\_nuke::nukeClearTimer();
  level thread updateMLGCameras();

  if(level.gametype == "grnd") {
    level thread maps\mp\gametypes\grnd::cycleZones();
  }

  flash_fade_out_time = 0.5;
  explosion_vision_time = 2.5;
  explosion_vision_fade_out_time = 3.5;
  nuke_blur(3, .1);

  flag_set("start_fog_fade_out");
  VisionSetNaked("mp_strikezone_explosion", flash_fade_out_time);

  waitframe();

  level thread nuke_slow_motion(0, flash_fade_out_time, 1);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(flash_fade_out_time);
  nuke_blur(0, explosion_vision_time + 2);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(explosion_vision_time);

  VisionSetNaked("mp_strikezone_after", explosion_vision_fade_out_time);
  SetExpFog(431.294, 2011.37, 0.54, 0.54, 0.54, 1, 0.5, explosion_vision_fade_out_time, 0.92, 0.69, 0.44, 1, (-0.05, -0.89, 0.44), 0, 100, 0.625, 1, 140.897, 114.026);
  wait explosion_vision_fade_out_time;
  VisionSetNaked("", 0);
  ClearFog(0);
  level.disable_killcam = false;
  flag_clear("nuke_event_active");
}

updateMLGCameras() {
  if(level.gameEnded) {
    return;
  }
  foreach(player in level.players) {
    if(isAI(player)) {
      continue;
    }
    player setmlgcameradefaults(0, level.Camera5Pos, level.Camera5Ang);
    player setmlgcameradefaults(1, level.Camera6Pos, level.Camera6Ang);
    player setmlgcameradefaults(2, level.Camera7Pos, level.Camera7Ang);
    player setmlgcameradefaults(3, level.Camera8Pos, level.Camera8Ang);
  }
}

pre_teleport_to_start() {
  VisionSetNaked("", 0);
}

nuke_activate_at_end_of_match() {
  level endon("nuke_start");

  flag_wait("teleport_setup_complete");

  level waittill("spawning_intermission");
  if(level.allow_level_killstreak) {
    level thread nuke_end_of_match();
  }
}

nuke_end_of_match() {
  levelFlagSet("post_game_level_event_active");
  visionSetNaked("", 0.5);

  maps\mp\_teleport::teleport_to_zone("destroyed");

  wait 5;

  levelFlagClear("post_game_level_event_active");
}

nuke_fx_exploders(delay_time) {
  if(isDefined(delay_time) && delay_time > 0) {
    wait delay_time;
  }

  exploder(2);
  wait(2);
  destroyed_fire_fx();
  wait(2.5);
  exploder(19);
  wait(4.8);
  exploder(23);
}

destroyed_fire_fx() {
  exploder_with_connect_watch(8, -2);
}

exploder_with_connect_watch(num, startTime) {
  exploder(num, undefined, startTime);
  level thread exploder_connect_watch(num, startTime);
}

exploder_connect_watch(num, startTime) {
  while(1) {
    level waittill("connected", player);
    exploder(num, player, startTime);
  }
}

set_vision_set_stage(stage, time) {
  if(!isDefined(time)) {
    time = 1.0;
  }

  foreach(player in level.players) {
    player VisionSetStage(stage, time);
  }

  level.vision_set_stage = stage;
}

set_all_players_undying(enable) {
  if(!isDefined(level.players_undying)) {
    level.players_undying = false;
  }

  if(enable == level.players_undying) {
    return;
  }
  if(enable) {
    level.prev_modifyPlayerDamage = level.modifyPlayerDamage;
    level.modifyPlayerDamage = ::undying;
  } else {
    level.modifyPlayerDamage = level.prev_modifyPlayerDamage;
  }

  level.players_undying = enable;
}

undying(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc) {
  if(isDefined(victim)) {
    return victim.health - 1;
  }

  return 0;
}

nuke_slow_motion(transition_to_slow, players_are_slow, transition_to_normal) {
  SetSlowMotion(1.0, 0.25, transition_to_slow);
  wait(players_are_slow);
  SetSlowMotion(0.25, 1, transition_to_normal);
}

nuke_earthquake(scale, time) {
  quakes = getstructarray("nuke_earthquake", "targetname");
  foreach(quake in quakes) {
    Earthquake(scale, time, quake.origin, quake.radius);
  }
}

nuke_sounds() {
  move_dist = 40000;
  move_dir = anglesToForward((319.008, 265.869, 88.6746));
  end_point = (-3892.33, 1244.78, -156.711);
  start_point = end_point + move_dir * move_dist;

  playSoundAtPos(start_point, "kem_launch");

  move_time = 2;
  sound_mover = spawn("script_model", start_point);
  sound_mover setModel("tag_origin");
  sound_mover delayCall(0.05, ::PlaySoundOnMovingEnt, "kem_incoming");

  sound_mover MoveTo(end_point, move_time);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(move_time);

  if(!isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject = spawn("script_origin", (0, 0, 1));
    level.nuke_soundObject hide();
  }
  level.nuke_soundObject playSound("kem_explosion");
}

nuke_ground_tilt() {
  start = spawnStruct();
  end = spawnStruct();

  kick_time = .2;
  unkick_time = 1;
  kick_angle = 20;

  ground_ent = spawn("script_model", (0, 0, 0));
  ground_ent.angles = (0, 0, 0);

  foreach(player in level.players) {
    player PlayerSetGroundReferenceEnt(ground_ent);
  }

  ground_ent Rotateto((kick_angle, 0, 0), kick_time, 0, kick_time);

  wait kick_time;

  ground_ent Rotateto((0, 0, 0), unkick_time, 0, unkick_time);

  wait unkick_time;

  foreach(player in level.players) {
    player PlayerSetGroundReferenceEnt(undefined);
  }

  ground_ent Delete();
}

nuke_blur(scale, blend_time) {
  foreach(player in level.players) {
    player SetBlurForPlayer(scale, blend_time);
  }
}

rumble_all_players(rumble, loop) {
  if(!isDefined(loop)) {
    loop = false;
  }

  foreach(player in level.players) {
    if(loop) {
      player PlayRumbleLoopOnEntity(rumble);
    } else {
      player PlayRumbleOnEntity(rumble);
    }
  }

  if(!loop) {
    return;
  }
  level waittill("stop_rumble_loop");

  foreach(player in level.players) {
    player StopRumble(rumble);
  }
}

stop_rumble_all_players() {
  level notify("stop_rumble_loop");
}

generic_swing_ents() {
  swing_anims = [];
  swing_anims["small"] = "mp_strikezone_chunk_sway_small";
  swing_anims["large"] = "mp_strikezone_chunk_sway_large";

  foreach(key, value in swing_anims) {
    PrecacheMpAnim(value);
  }

  swing_origins = getEntArray("generic_swing", "targetname");

  foreach(swing in swing_origins) {
    if(!isDefined(swing.angles)) {
      swing.angles = (0, 0, 0);
    }

    pivot = spawn("script_model", swing.origin);
    pivot.angles = swing.angles;
    pivot setModel("generic_prop_raven");

    swing linkto(pivot, "j_prop_1");

    anim_name = "small";
    if(isDefined(swing.script_noteworthy) && isDefined(swing_anims[swing.script_noteworthy])) {
      anim_name = swing.script_noteworthy;
    }

    pivot ScriptModelPlayAnim(swing_anims[swing.script_noteworthy]);
  }

}

fall_objects() {
  objects = getEntArray("fall_object", "targetname");
  array_thread(objects, ::fall_object_init);
}

fall_object_init() {
  self.end = self;

  things = [];

  if(isDefined(self.target)) {
    structs = getstructarray(self.target, "targetname");
    set_default_script_noteworthy(structs, "angle_ref");
    things = array_combine(things, structs);

    ents = getEntArray(self.target, "targetname");
    things = array_combine(things, ents);
  }

  if(isDefined(self.script_linkto)) {
    structs = getstructarray(self.script_linkto, "script_linkname");
    set_default_script_noteworthy(structs, "start");
    things = array_combine(things, structs);

    ents = getEntArray(self.script_linkto, "script_linkname");
    things = array_combine(things, ents);
  }

  foreach(thing in things) {
    if(!isDefined(thing.script_noteworthy)) {
      continue;
    }
    switch (thing.script_noteworthy) {
      case "angle_ref":
        self.end = thing;
        break;
      case "start":
        self.start = thing;
        break;
      case "link":
        thing linkto(self);
        break;
      default:
        break;
    }
  }

  set_default_angles(things);

  if(isDefined(self.start) && isDefined(self.end)) {
    self thread fall_object_run();
  }
}

set_default_script_noteworthy(things, noteworthy) {
  if(!isDefined(things)) {
    return;
  }
  if(!isDefined(noteworthy)) {
    noteworthy = "";
  }

  if(!isArray(things)) {
    things = [things];
  }

  foreach(thing in things) {
    if(!isDefined(thing.script_noteworthy)) {
      thing.script_noteworthy = noteworthy;
    }
  }
}

set_default_angles(things, angles) {
  if(!isDefined(things)) {
    return;
  }
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isArray(things)) {
    things = [things];
  }

  foreach(thing in things) {
    if(!isDefined(thing.angles)) {
      thing.angles = angles;
    }
  }
}

fall_object_run() {
  fall_to_origin = self.origin;
  fall_to_angles = self.angles;

  trans = TransformMove(self.start.origin, self.start.angles, self.end.origin, self.end.angles, self.origin, self.angles);
  self.origin = trans["origin"];
  self.angles = trans["angles"];

  flag_wait("start_fog_fade_out");

  wait RandomFloatRange(0.8, 1.0);

  if(isDefined(self.script_delay)) {
    if(self.script_delay < 0) {
      self.script_delay = RandomFloatRange(30, 120);
    }

    wait self.script_delay;
  }

  PlaySoundAtPos(self.origin, "cobra_helicopter_crash");

  fall_speed = RandomFloatRange(300, 320);
  dist = Distance(fall_to_origin, self.origin);
  time = dist / fall_speed;

  self moveTo(fall_to_origin, time, time, 0);
  if(fall_to_angles != self.angles) {
    self RotateTo(fall_to_angles, time, 0, 0);
  }

  wait time;
}

ronnie_talks() {
  ronnie_vo = [];
  ronnie_vo["low"] = [];
  ronnie_vo["high"] = [];

  ronnie_vo["high"][0] = "mp_strikezone_hdg_01";
  ronnie_vo["high"][1] = "mp_strikezone_hdg_02";
  ronnie_vo["high"][2] = "mp_strikezone_hdg_03";
  ronnie_vo["high"][3] = "mp_strikezone_hdg_05";
  ronnie_vo["high"][4] = "mp_strikezone_hdg_06";
  ronnie_vo["high"][4] = "mp_strikezone_hdg_07";
  ronnie_vo["high"][4] = "mp_strikezone_hdg_09";

  ronnie_vo["low"][0] = "mp_strikezone_hdg_04";
  ronnie_vo["low"][1] = "mp_strikezone_hdg_08";
  ronnie_vo["low"][2] = "mp_strikezone_hdg_10";

  locs = getEntArray("ronnie_talk_location", "targetname");
  array_thread(locs, ::ronnie_knife_watcher);

  while(1) {
    level waittill("ronnie_speak", trigger);

    vo = random(ronnie_vo[trigger.script_noteworthy]);
    playSoundAtPos(trigger.origin, vo);
  }
}

ronnie_knife_watcher() {
  self endon("death");
  while(1) {
    level waittill("hit_by_knife", knife, hitEnt);
    if(isDefined(knife)) {
      if(knife IsTouching(self)) {
        level notify("ronnie_speak", self);
      }
    }
  }
}

STRIKEZONE_ROG_WEIGHT = 55;
strikezoneCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"])) {
    game["player_holding_level_killstrek"] = false;
  }

  level.allow_level_killstreak = allowLevelKillstreaks();
  if(!level.allow_level_killstreak || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "nuke", STRIKEZONE_ROG_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"KILLSTREAKS_HINTS_STRIKEZONE_ROG");
  level thread strikezone_rog_post_teleport_init();
}

strikezone_rog_post_teleport_init() {
  flag_wait("teleport_setup_complete");

  if(level.teleport_allowed) {
    if(level.allow_level_killstreak) {
      level thread watch_for_strikezone_rog_crate();
    }
  } else {
    level.allow_level_killstreak = false;
    disable_strikezone_rog();
  }
}

watch_for_strikezone_rog_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "nuke") {
      disable_strikezone_rog();

      captured = wait_for_capture(dropCrate);

      if(!captured) {
        enable_strikezone_rog();
      } else {
        game["player_holding_level_killstrek"] = true;
        break;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return !isDefined(result);
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("captured");

  dropCrate waittill("death");
  waittillframeend;

  return true;
}

enable_strikezone_rog() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "nuke", STRIKEZONE_ROG_WEIGHT);
}

disable_strikezone_rog() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "nuke", 0);
}

strikezoneCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Strikezone RoG\" \"set scr_devgivecarepackage nuke; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Strikezone RoG\" \"set scr_givekillstreak nuke\"\n");
}

strikezoneCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Strikezone RoG\" \"set scr_testclients_givekillstreak nuke\"\n");
}