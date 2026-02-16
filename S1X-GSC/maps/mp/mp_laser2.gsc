/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_laser2.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_dynamic_events;
#include maps\mp\_audio;

WATER_START_DIRECTION = 1;
WATER_HEIGHT_OFFSET = 132;
PROP_HIDE_OFFSET = 10000;

main() {
  maps\mp\mp_laser2_precache::main();
  maps\createart\mp_laser2_art::main();
  maps\mp\mp_laser2_fx::main();
  thread aud_init();

  if(GetDvarInt("r_reflectionProbeGenerate") == 1) {
    setAtmosFog(0, (0.87037, 0.923157, 0.975854), (1, 1, 1), 0.03125, 0.0121191, 0.557743, 19.999, 44278.8, 5252.51, 4.06552, 218083, 1, 19.6056, 53.3102, (0.795324, -0.208482, 0.569205), 0, 80.5889, 4915.02);
  }

  maps\mp\_load::main();
  maps\mp\mp_laser2_lighting::main();
  maps\mp\mp_laser2_aud::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_laser2");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.aerial_pathnode_offset = 450;

  thread set_lighting_values();
  thread set_umbra_values();
  level.ospvisionset = "mp_laser2_osp";

  if(level.nextgen == true) {
    level thread RotateRadar();
  }

  level.ospvisionset = "mp_laser2_osp";
  level.ospLightSet = "mp_laser2_streak";

  level.mapCustomKillstreakFunc = ::laser2CustomKillstreakFunc;

  level.orbitalSupportOverrideFunc = ::laser2CustomOSPFunc;

  level.orbitalLaserOverrideFunc = ::laser2CustomOrbitalLaserFunc;

  thread Laser2CustomAirstrike();

  level.Anim_laserBuoy = "laser_buoy_loop";

  level.waterline_offset = 2;
  maps\mp\_water::SetShallowWaterWeapon("iw5_underwater_mp");
  level thread maps\mp\_water::init();

  PreCacheRumble("damage_light");
  level DynamicEvent_init_sound();
  level DynamicEvent_init();
  level thread DynamicEvent(::handleMovingWater, undefined, ::handleEndWater);

  level.AlarmSystem = spawnStruct();
  level.AlarmSystem.SpinnerArray = getEntArray("horizonal_spinner", "targetname");
  foreach(spinner in level.AlarmSystem.SpinnerArray) {
    spinner hide();
  }

  level thread HandleClouds();

  thread SpawnSetup();
}

DynamicEvent_init_sound() {
  level.tsunami_alarm = "mp_laser2_typhoon_alarm";
  level.tsunami_vo_int = "mp_laser2_vo_tsunami_warning_int";
  level.tsunami_vo_ext = "mp_laser2_vo_tsunami_warning_ext";
}

laser2CustomKillstreakFunc() {
  level.killstreakWeildWeapons["mp_laser2_core"] = true;

  level thread maps\mp\killstreaks\streak_mp_laser2::init();
}

laser2CustomOSPFunc() {
  level.orbitalsupportoverrides.spawnAngleMin = 30;
  level.orbitalsupportoverrides.spawnAngleMax = 90;
  level.orbitalsupportoverrides.spawnHeight = 9541;

  if(level.currentgen) {
    level.orbitalsupportoverrides.leftArc = 20;
    level.orbitalsupportoverrides.rightArc = 20;
    level.orbitalsupportoverrides.topArc = -30;
    level.orbitalsupportoverrides.bottomArc = 60;
  }
}

laser2CustomOrbitalLaserFunc() {
  level.orbitallaseroverrides.spawnHeight = 3300;
}

Laser2CustomAirstrike() {
  if(!isDefined(level.airstrikeoverrides)) {
    level.airstrikeoverrides = spawnStruct();
  }

  level.airstrikeoverrides.spawnHeight = 1750;
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "2");
    }
  }
}

set_umbra_values() {
  setDvar("r_umbraAccurateOcclusionThreshold", 256);
}

HandleClouds() {
  clouds_exploder_id = 122;

  ActivatePersistentClientExploder(clouds_exploder_id);

  level thread HandleCloudsAerialJoin();
  level thread HandleCloudsAerialLeave();
}

EnableCloudsExploder(player) {
  clouds_exploder_id = 122;

  specify_players = false;
  player_list = [];

  if(isDefined(player)) {
    specify_players = true;
    player_list[player_list.size] = player;
    if(isDefined(player.disableCloudsCount)) {
      player.disableCloudsCount--;
      if(player.disableCloudsCount <= 0) {
        player.disableCloudsCount = 0;
      }
    }
  } else {
    foreach(my_player in level.players) {
      if(isDefined(my_player.disableCloudsCount)) {
        my_player.disableCloudsCount--;
        if(my_player.disableCloudsCount > 0) {
          specify_players = true;
        } else {
          my_player.disableCloudsCount = 0;
        }

        player_list[player_list.size] = my_player;
      }
    }
  }

  if(specify_players) {
    ActivatePersistentClientExploder(clouds_exploder_id, player_list);
  } else {
    ActivatePersistentClientExploder(clouds_exploder_id);
  }
}

DisableCloudsExploder(player, shouldKill) {
  clouds_exploder_id = 122;

  player_list = [];
  level thread common_scripts\_exploder::deactivate_clientside_exploder(clouds_exploder_id, player, shouldKill);
  if(isDefined(player)) {
    player_list[player_list.size] = player;
  } else {
    player_list = level.players;
  }

  foreach(my_player in player_list) {
    if(isDefined(my_player.disableCloudsCount)) {
      my_player.disableCloudsCount++;
    } else {
      my_player.disableCloudsCount = 1;
    }
  }
}

HandleCloudsAerialJoin() {
  while(1) {
    level waittill("player_start_aerial_view", player);
    level DisableCloudsExploder(player, true);
  }
}

HandleCloudsAerialLeave() {
  while(1) {
    level waittill("player_stop_aerial_view", player);
    level EnableCloudsExploder(player);
  }
}

#using_animtree("animated_props");
RotateRadar() {
  wait(0.05);
  Radar01 = getent("radar_dish01_rotate", "targetname");

  ScriptModelPlayAnimWithNotify(Radar01, "lsr_radar_dish_loop", "ps_emt_satellite_dish_rotate", "emt_satellite_dish_rotate", "laser2_custom_end_notify", "laser2_custom_ent_end_notify", "laser2_custom_ent2_end_notify");
}

handlePropAttachments(ParentMover) {
  if(isDefined(self.target)) {
    attachments = getEntArray(self.target, "targetname");
    foreach(att in attachments) {
      if(isDefined(ParentMover)) {
        att LinkToSynchronizedParent(ParentMover);
      } else {
        att LinkToSynchronizedParent(self);
      }
    }
  }
}

DynamicEvent_init() {
  level endon("game_ended");

  level.water_warning = undefined;

  level.ocean = undefined;
  ocean_ents = getEntArray("ocean_water", "targetname");
  if(isDefined(ocean_ents)) {
    level.ocean = ocean_ents[0];
    if(ocean_ents.size > 0) {
      level.ocean_pieces = array_remove(ocean_ents, level.ocean);
      array_thread(level.ocean_pieces, ::linktoEnt, level.ocean);
    }
  }

  level.ocean.warning_time = 30;
  level.ocean.origin = level.ocean.origin - (0, 0, WATER_HEIGHT_OFFSET);
  ocean_underside = getent("ocean_water_underside", "targetname");
  triggers = getEntArray("trigger_underwater", "targetname");
  props = getEntArray("ocean_moving_prop", "targetname");
  buoys = getEntArray("buoy", "targetname");
  traversable_props = [];
  level.moving_buoys = [];
  water_clip = getEntArray("water_clip", "targetname");
  level.post_event_geo = getEntArray("post_event_geo", "targetname");
  level.end_state_geo = getEntArray("end_state_geo", "targetname");
  level.post_event_nodes = getNodeArray("post_event_node", "targetname");
  level.pre_event_nodes = getNodeArray("pre_event_node", "targetname");
  level.goliath_bad_landing_volumes = getEntArray("goliath_bad_landing_volume", "targetname");
  level.drop_pod_bad_places = getEntArray("drop_pod_bad_place", "targetname");
  level.post_event_pathing_blockers = getEntArray("post_event_pathing_blocker", "targetname");
  level.pre_event_pathing_blockers = getEntArray("pre_event_pathing_blocker", "targetname");

  level handle_event_geo_off();
  level thread handle_pathing_pre_event();

  foreach(prop in props) {
    if(isDefined(prop.script_noteworthy) && prop.script_noteworthy == "has_collision") {
      traversable_props[traversable_props.size] = prop;
    }
  }

  foreach(buoy in buoys) {
    if(isDefined(buoy.script_noteworthy) && buoy.script_noteworthy == "moving") {
      level.moving_buoys[level.moving_buoys.size] = buoy;
    }
  }

  all_props = array_combine(props, level.moving_buoys);

  thread maps\mp\mp_laser2_fx::setupWaves(level.ocean);
  thread maps\mp\mp_laser2_fx::setupOceanFoam(level.ocean);

  if(isDefined(level.waterline_ents)) {
    array_thread(level.waterline_ents, ::linktoEnt, level.ocean);
  }

  if(level.nextgen) {
    ocean_underside linktoEnt(level.ocean);
  }

  if(isDefined(water_clip) && water_clip.size > 0) {
    array_thread(water_clip, ::linktoEnt, level.ocean);
  }
  if(isDefined(all_props) && all_props.size > 0) {
    array_thread(all_props, ::linktoEnt, level.ocean);
  }
  if(isDefined(triggers) && triggers.size > 0 && isDefined(level.ocean)) {
    foreach(trig in triggers) {
      trig thread handleWaterTriggerMovement(level.ocean);
    }
  }
  if(isDefined(level.goliath_bad_landing_volumes) && level.goliath_bad_landing_volumes.size > 0 && isDefined(level.ocean)) {
    foreach(trig in level.goliath_bad_landing_volumes) {
      if(isDefined(trig.script_noteworthy) && trig.script_noteworthy == "dont_move_me") {
        continue;
      } else {
        trig thread handleWaterTriggerMovement(level.ocean);
      }
    }
  }

  if(isDefined(traversable_props) && traversable_props.size > 0) {
    array_thread(traversable_props, ::handlePropAttachments, level.ocean);
  }
  if(isDefined(buoys) && buoys.size > 0) {
    array_thread(buoys, ::playBuoyLights);
  }

  if(isDefined(level.moving_buoys) && level.moving_buoys.size > 0) {
    array_thread(level.moving_buoys, ::PlayPropAnim, level.Anim_laserBuoy);

    array_thread(level.moving_buoys, ::handlePropAttachments, level.ocean);
  }

  tidal_wave = GetEnt("tidal_wave", "targetname");
  tidal_wave hide();

  trigger_off("trig_kill_00", "targetname");
  trigger_off("trig_kill_01", "targetname");
  trigger_off("trig_kill_02", "targetname");
  trigger_off("trig_kill_03", "targetname");
  trigger_off("trig_kill_04", "targetname");
  trigger_off("trig_kill_drone_vista", "targetname");

  maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_00", "targetname");
  maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_01", "targetname");
  maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_02", "targetname");
  maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_03", "targetname");
  maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_04", "targetname");
  maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_drone_vista", "targetname");

  thread maps\mp\mp_laser2_fx::playWaves("end_initial_waves", 4, 6, "breaking_wave_01");
  level setOceanSinValuesLowTide();
}

connect_paths() {
  if(isDefined(self)) {
    self ConnectPaths();
  }
}

disconnect_paths() {
  if(isDefined(self)) {
    self DisconnectPaths();
  }
}

connect_nodes() {
  if(isDefined(self)) {
    self ConnectNode();
  }
}

disconnect_nodes() {
  if(isDefined(self)) {
    self DisconnectNode();
  }
}

hideGeo() {
  if(isDefined(self) && !isDefined(self.isHidden)) {
    self.isHidden = true;

    self trigger_off();
  }
}

showGeo() {
  if(isDefined(self) && isDefined(self.isHidden)) {
    self.isHidden = undefined;

    self trigger_on();
  }
}

oceanSinMovement(startPoint) {
  level endon("game_ended");
  level endon("end_initial_waves");

  self notify("ocean_sin_movement");
  self endon("ocean_sin_movement");

  while(true) {
    self moveto((0, level.oceanSinAmplitude, level.oceanSinAmplitude) + startPoint, level.oceanSinPeriod / 2, level.oceanSinPeriod * 0.25, level.oceanSinPeriod * 0.25);
    wait level.oceanSinPeriod / 2;
    self moveto(-1 * (0, level.oceanSinAmplitude, level.oceanSinAmplitude) + startPoint, level.oceanSinPeriod / 2, level.oceanSinPeriod * 0.25, level.oceanSinPeriod * 0.25);
    wait level.oceanSinPeriod / 2;
  }
}

setOceanSinValuesLowTide() {
  if(level.nextgen) {
    level.oceanSinAmplitude = 12;
    level.oceanSinPeriod = 10;
  } else {
    level.oceanSinAmplitude = 16;
    level.oceanSinPeriod = 20;
  }
}

setOceanSinValuesHighTide() {
  level.oceanSinAmplitude = 6;
  level.oceanSinPeriod = 10;
}

linktoEnt(originEnt) {
  mover = self;
  mover LinkToSynchronizedParent(originEnt);
}

handleBuoyDings(warningSound, quietSound) {
  level endon("game_ended");

  while(true) {
    wait(RandomFloatRange(.05, .5));

    while(!isDefined(level.water_warning) || level.water_warning != true) {
      self play_sound_on_tag(quietSound, "tag_origin");
      wait(RandomFloatRange(3, 7));
    }

    while(level.water_warning == true) {
      self play_sound_on_tag(warningSound, "tag_origin");
      wait(RandomFloatRange(1.5, 4.5));
    }
  }
}

playBuoyLights() {
  self notify("stop_buoy_lights");
  self endon("stop_buoy_lights");

  playFXOnTag(getfx("light_buoy_red"), self, "fx_joint_0");
  wait randomFloat(4);
  stopFXOnTag(getfx("light_buoy_red"), self, "fx_joint_0");
  wait(.05);
  playFXOnTag(getfx("light_buoy_red"), self, "fx_joint_0");
}

PlayPropAnim(animName) {
  wait(RandomFloatRange(.1, 1));
  self ScriptModelPlayAnim(animName);
}

oceanMover_init(targetname) {
  level endon("game_ended");

  assertEx(isDefined(targetname), "no targetname specified for oceanMover_init()");

  water = getent(targetname, "targetname");

  if(!isDefined(water)) {
    AssertMsg("water is not defined. Expecting targetname of " + targetname);
    return undefined;
  }

  water.warning_time = 30;

  return water;
}

OceanObjectMover_init(water_ent) {
  OceanObjectMover = spawn("script_origin", (0, 0, 0));
  OceanObjectMover.targetname = "OceanObjectMover";

  OceanObjectMover.dist_prop = (0, 352, 0);

  return OceanObjectMover;
}

moving_water_init() {
  level endon("game_ended");
  thread maps\mp\mp_laser2_fx::playWaves("end_initial_waves", 4, 6, "breaking_wave_01");
}

handleEndWater() {
  level.ocean.origin = level.ocean.origin + (0, 0, 72);

  level notify("end_initial_waves");
  thread maps\mp\mp_laser2_fx::playWaves(undefined, 6, 8, "breaking_wave_01");
  level thread common_scripts\_exploder::activate_clientside_exploder(201);
  level thread common_scripts\_exploder::activate_clientside_exploder(202);
  level thread common_scripts\_exploder::activate_clientside_exploder(203);
  level thread common_scripts\_exploder::activate_clientside_exploder(204);
  level thread common_scripts\_exploder::activate_clientside_exploder(205);
  level thread common_scripts\_exploder::activate_clientside_exploder(206);
  level thread common_scripts\_exploder::activate_clientside_exploder(207);
  level thread common_scripts\_exploder::activate_clientside_exploder(208);
  level thread common_scripts\_exploder::activate_clientside_exploder(209);
  level thread common_scripts\_exploder::activate_clientside_exploder(121);

  if(isDefined(level.end_state_geo)) {
    array_thread(level.end_state_geo, ::showGeo);
  }

  level handle_event_geo_on();
  level delaythread(.05, ::handle_pathing_post_event);
}

handleMovingWater() {
  level endon("game_ended");

  level DisableCloudsExploder(undefined, false);

  level.skipOceanSpawns = true;
  ocean = level.ocean;
  tidal_wave = GetEnt("tidal_wave", "targetname");
  tidal_wave show();
  ocean_model = spawn_tag_origin();
  ocean_model.targetname = "ocean_tag_origin";
  ocean_model show();
  car = getent("lsr_tidal_wave_car", "targetname");
  container_closed = getent("lsr_tidal_wave_shipping_container_closed", "targetname");
  container_open = getent("lsr_tidal_wave_shipping_container_open", "targetname");

  create_bot_badplaces();

  foreach(trig in level.water_triggers) {
    trig thread killObjectsUnderWater();
  }
  level thread addPostEventGeoToCrateBadPlaceArray();
  level thread killPlayersUsingRemoteStreaks();

  wait(.05);

  level.water_warning = true;
  level notify("end_initial_waves");
  thread maps\mp\mp_laser2_aud::start_rough_tide();
  earthquake_duration = 2;
  Earthquake(.3, earthquake_duration, (0, 0, 0), 5000);
  thread aud_dynamic_event_startup(earthquake_duration);
  thread play_earthquake_rumble_for_all_players(.75);

  level delaythread(3, ::handleTsunamiWarningSounds);

  animtime_wave = 26.667;
  animtime_ocean = 36.7;

  animtime = animtime_ocean;
  if(animtime_wave > animtime_ocean) {
    animtime = animtime_wave;
  }

  if(ocean.warning_time > animtime) {
    wait(ocean.warning_time - animtime);
  } else {
    wait(2);
  }

  tidal_wave thread tidal_wave_notetracks();
  tidal_wave ScriptModelPlayAnimDeltaMotion("lsr_tidal_wave_mesh_anim", "tidal_wave_notetrack");
  ocean linkto(ocean_model);
  ocean_model ScriptModelPlayAnimDeltaMotion("lsr_tidal_wave_ocean_anim");
  if(isDefined(car)) {
    car ScriptModelPlayAnimDeltaMotion("lsr_tidal_wave_car");
  }
  container_closed ScriptModelPlayAnimDeltaMotion("lsr_tidal_wave_shipping_container_closed");
  container_open ScriptModelPlayAnimDeltaMotion("lsr_tidal_wave_shipping_container_open");

  foreach(buoy in level.moving_buoys) {
    if(isDefined(buoy.animation)) {
      buoy ScriptModelClearAnim();
      buoy unlink();
      buoy ScriptModelPlayAnimDeltaMotion(buoy.animation);
      buoy thread playBuoyLights();
      buoy delaythread(animtime_ocean, ::buoys_return_to_bobbing);
    }
  }

  level delaythread(animtime_wave - 3, ::stop_water_warning);
  level delaythread(animtime_wave - 2.9, ::play_earthquake_rumble_for_all_players, .75);
  tidal_wave delaycall(animtime_wave, ::Hide);
  ocean_model delaycall(animtime_ocean, ::Hide);
  ocean delaycall(animtime_ocean, ::unlink);

  wait(animtime);

  water_nodes = GetNodeArray("water_nodes", "targetname");
  foreach(node in water_nodes) {
    NodeSetNotUsable(node, true);
  }
  delete_bot_badplaces();

  level.skipOceanSpawns = false;

  wait 2;
  thread maps\mp\mp_laser2_fx::playWaves(undefined, 6, 8, "breaking_wave_01");

  level notify("dynamic_event_complete");
}

create_bot_badplaces() {
  BadPlace_Cylinder("badplace_1", -1, (-1096, -688, 229.5), 300, 200);
  BadPlace_Cylinder("badplace_2", -1, (-544, -1104, 158), 500, 200);
  BadPlace_Cylinder("badplace_3", -1, (0, -1024, 154.286), 500, 200);
  BadPlace_Cylinder("badplace_4", -1, (608, -1152, 153.195), 500, 200);
  BadPlace_Cylinder("badplace_5", -1, (1360, -832, 203.4), 500, 200);
  BadPlace_Cylinder("badplace_6", -1, (2128, -416, 159.325), 500, 200);
  BadPlace_Cylinder("badplace_7", -1, (2464, 176, 128), 500, 200);
}

delete_bot_badplaces() {
  BadPlace_Delete("badplace_1");
  BadPlace_Delete("badplace_2");
  BadPlace_Delete("badplace_3");
  BadPlace_Delete("badplace_4");
  BadPlace_Delete("badplace_5");
  BadPlace_Delete("badplace_6");
  BadPlace_Delete("badplace_7");
}

killObjectsUnderWater() {
  level endon("game_ended");
  level endon("dynamic_event_complete");

  while(true) {
    if(isDefined(level.turrets)) {
      foreach(turret in level.turrets) {
        if(turret IsTouching(self)) {
          turret notify("death");
        }
      }
    }

    if(isDefined(level.carepackages)) {
      foreach(carepackage in level.carepackages) {
        if(isDefined(carepackage) && !IsRemovedEntity(carepackage) && carepackage isCarepackageInPostEventGeo()) {
          if(isDefined(carepackage.crateType) && carepackage.crateType != "juggernaut") {
            carepackage maps\mp\killstreaks\_airdrop::deleteCrate(true, true);
          } else if(isDefined(carepackage.crateType) && carepackage.crateType == "juggernaut") {
            carepackage maps\mp\killstreaks\_juggernaut::deleteGoliathPod(true, true);
          }
        }
      }
    }

    wait(0.05);
  }
}

isCarepackageInPostEventGeo() {
  if(isDefined(level.drop_pod_bad_places)) {
    foreach(vol in level.drop_pod_bad_places) {
      if(IsPointInVolume(self.origin, vol)) {
        return true;
      }
    }
  }

  return false;
}

addPostEventGeoToCrateBadPlaceArray() {
  level waittill("post_event_geo_on");

  foreach(vol in level.drop_pod_bad_places) {
    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = vol;
  }
}

killPlayersUsingRemoteStreaks() {
  level endon("game_ended");
  level endon("dynamic_event_complete");
  self endon("death");
  self endon("disconnect");

  while(true) {
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.inwater) && player maps\mp\_utility::isUsingRemote()) {
        player _suicide();
      }
    }

    wait(.05);
  }
}

buoys_return_to_bobbing() {
  self linkToEnt(level.ocean);
  self ScriptModelClearAnim();

  wait(RandomFloatRange(.1, 1));

  self ScriptModelPlayAnim(level.Anim_laserBuoy);
  self thread playBuoyLights();
}

play_earthquake_rumble_for_all_players(time) {
  foreach(Player in level.players) {
    player thread play_earthquake_rumble(time);
  }
}

play_earthquake_rumble(time) {
  self endon("death");
  level endon("game_ended");

  frames = time * 20;

  while(frames >= 0) {
    self PlayRumbleOnEntity("damage_light");
    wait(.1);
    frames = frames - 2;
  }
}

stop_water_warning() {
  level.water_warning = false;
  array_thread(level.AlarmSystem.SpinnerArray, ::SpinAlarmsStop);
}

tidal_wave_notetracks() {
  self thread event_fx();
  self thread event_killtriggers();
  self thread event_geo();
}

event_fx() {
  self waittillmatch("tidal_wave_notetrack", "vfx_wave_mist_start");
  thread maps\mp\mp_laser2_fx::start_wave_mist_fx();

  self waittillmatch("tidal_wave_notetrack", "vfx_receding_foam_start");
  level thread common_scripts\_exploder::activate_clientside_exploder(120);
  level thread common_scripts\_exploder::activate_clientside_exploder(100);

  self waittillmatch("tidal_wave_notetrack", "vfx_rocks1_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(101);
  level thread common_scripts\_exploder::activate_clientside_exploder(201);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 0);

  self waittillmatch("tidal_wave_notetrack", "vfx_tower_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(102);
  level thread common_scripts\_exploder::activate_clientside_exploder(202);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 1);

  self waittillmatch("tidal_wave_notetrack", "vfx_concrete_chunk1_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(103);
  level thread common_scripts\_exploder::activate_clientside_exploder(203);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 2);
  thread maps\mp\mp_laser2_fx::stop_wave_mist_fx();

  self waittillmatch("tidal_wave_notetrack", "vfx_wave_collapse1_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(104);
  level thread common_scripts\_exploder::activate_clientside_exploder(204);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 3);

  self waittillmatch("tidal_wave_notetrack", "vfx_wave_collapse2_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(105);
  level thread common_scripts\_exploder::activate_clientside_exploder(205);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 4);

  self waittillmatch("tidal_wave_notetrack", "vfx_wave_collapse3_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(106);
  level thread common_scripts\_exploder::activate_clientside_exploder(206);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 5);

  self waittillmatch("tidal_wave_notetrack", "vfx_midbeach_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(107);
  level thread common_scripts\_exploder::activate_clientside_exploder(207);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 6);

  self waittillmatch("tidal_wave_notetrack", "vfx_helipad_splash");
  level thread common_scripts\_exploder::activate_clientside_exploder(108);
  level thread common_scripts\_exploder::activate_clientside_exploder(208);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 7);

  self waittillmatch("tidal_wave_notetrack", "vfx_helipad_splash2");
  level thread common_scripts\_exploder::activate_clientside_exploder(109);
  level thread common_scripts\_exploder::activate_clientside_exploder(209);
  thread maps\mp\mp_laser2_fx::playOceanFoam("tidal_wave_lingering_foam1", 8);

  wait 1.0;

  level thread common_scripts\_exploder::activate_clientside_exploder(121);

  level EnableCloudsExploder();
}

event_killtriggers() {
  trigger_on("trig_kill_drone_vista", "targetname");

  self waittillmatch("tidal_wave_notetrack", "kill_trig_00");
  trigger_off("trig_kill_drone_vista", "targetname");
  trigger_on("trig_kill_00", "targetname");

  self waittillmatch("tidal_wave_notetrack", "kill_trig_01");
  trigger_off("trig_kill_00", "targetname");
  trigger_on("trig_kill_01", "targetname");

  self waittillmatch("tidal_wave_notetrack", "kill_trig_02");
  trigger_off("trig_kill_01", "targetname");
  trigger_on("trig_kill_02", "targetname");

  self waittillmatch("tidal_wave_notetrack", "kill_trig_03");
  trigger_off("trig_kill_02", "targetname");
  trigger_on("trig_kill_03", "targetname");

  self waittillmatch("tidal_wave_notetrack", "kill_trig_04");
  trigger_off("trig_kill_03", "targetname");
  trigger_on("trig_kill_04", "targetname");
  delayThread(1, ::trigger_off, "trig_kill_04", "targetname");
}

event_geo() {
  self waittillmatch("tidal_wave_notetrack", "kill_trig_04");

  level handle_event_geo_on();
  level handle_pathing_post_event();
}

handle_event_geo_on() {
  if(isDefined(level.post_event_geo)) {
    foreach(ent in level.post_event_geo) {
      ent showGeo();
    }

    level notify("post_event_geo_on");
  }

  if(isDefined(level.drop_pod_bad_places)) {
    foreach(vol in level.drop_pod_bad_places) {
      vol showGeo();
    }
  }
}

handle_event_geo_off() {
  if(isDefined(level.post_event_geo)) {
    foreach(ent in level.post_event_geo) {
      ent hideGeo();
    }

    level notify("post_event_geo_off");
  }

  if(isDefined(level.drop_pod_bad_places)) {
    foreach(vol in level.drop_pod_bad_places) {
      vol hideGeo();
    }
  }

  if(isDefined(level.end_state_geo)) {
    array_thread(level.end_state_geo, ::hideGeo);
  }
}

handle_pathing_pre_event() {
  if(getDvar("scr_dynamic_event_state", "on") != "endstate" && (!isDefined(level.dynamicEventsType) || level.dynamicEventsType != 2)) {
    wait(.05);
  }

  foreach(ent in level.pre_event_pathing_blockers) {
    ent disconnect_paths();
    ent hideGeo();
  }

  foreach(ent in level.post_event_pathing_blockers) {
    ent hideGeo();
    ent connect_paths();
  }
}

handle_pathing_post_event() {
  if(isDefined(level.post_event_pathing_blockers)) {
    foreach(ent in level.post_event_pathing_blockers) {
      ent showGeo();
      ent disconnect_paths();
      ent hideGeo();
    }
  }

  if(isDefined(level.pre_event_pathing_blockers)) {
    array_thread(level.pre_event_pathing_blockers, ::connect_paths);
  }
}

OceanObjectMover_set_goal(ocean_ent) {
  if(ocean_ent.direction == "up" && WATER_START_DIRECTION == -1) {
    self.goal = self.loc_start;
  } else if(ocean_ent.direction == "down" && WATER_START_DIRECTION == 1) {
    self.goal = self.loc_start;
  } else {
    self.goal = self.loc_end;
  }
}

activate_splashes(exp_num, endon_msg, wait_min, wait_max) {
  level endon("game_ended");

  if(isDefined(endon_msg)) {
    level notify(endon_msg);
    level endon(endon_msg);
  }

  if(!isDefined(wait_min)) {
    wait_min = 3;
  }

  if(!isDefined(wait_max)) {
    wait_max = 5;
  }

  while(1) {
    level thread common_scripts\_exploder::activate_clientside_exploder(exp_num);
    wait(RandomFloatRange(wait_min, wait_max));
  }
}

handleWatertriggerMovement(parent) {
  assertex(isDefined(parent), "must have a parent entity to know where the water trigger should be");

  level endon("game_ended");

  waterline_ent = undefined;
  if(isDefined(self.target)) {
    waterline_ent = getstruct(self.target, "targetname");
  }

  parent_offset = self.origin - parent.origin;

  self childthread MoveTrig(parent, parent_offset);
  if(isDefined(waterline_ent)) {
    waterline_offset = waterline_ent.origin[2] - self.origin[2];
    offset = parent_offset + (0, 0, waterline_offset);
    waterline_ent childthread MoveTrig(parent, offset);
  }
}

MoveTrig(parent, offset) {
  while(true) {
    self.origin = (parent.origin + offset);
    wait(.05);
  }
}

SpawnSetup() {
  level.skipOceanSpawns = false;
  level.dynamicSpawns = ::GetListOfGoodSpawnPoints;
}

GetListOfGoodSpawnPoints(fullListOfSpawnPoints) {
  goodpoints = [];

  foreach(spawn in fullListOfSpawnPoints) {
    if(!isDefined(spawn.targetname) || (spawn.targetname == "") || spawn IsValidspawn() == true) {
      goodpoints = add_to_array(goodpoints, spawn);
    }
  }
  return goodpoints;
}

IsValidspawn() {
  if(level.skipOceanSpawns == true && self.targetname == "ocean_spawn") {
    return false;
  }

  return true;
}

SpinAlarmsStart() {
  self show();
  self RotateVelocity((0, 600, 0), 12);

  TsunamiAlarmLgtEnts = GetScriptableArray("tsunami_alarm", "targetname");
  foreach(TsunamiAlarmLgtEnt in TsunamiAlarmLgtEnts) {
    TsunamiAlarmLgtEnt SetScriptablePartState("static_part", "siren_on");
  }
}

SpinAlarmsStop() {
  self hide();

  TsunamiAlarmLgtEnts = GetScriptableArray("tsunami_alarm", "targetname");
  foreach(TsunamiAlarmLgtEnt in TsunamiAlarmLgtEnts) {
    TsunamiAlarmLgtEnt SetScriptablePartState("static_part", "siren_off");
  }
}

aud_init() {}

aud_dynamic_event_startup(earthquake_duration) {
  thread aud_handle_earthquake(earthquake_duration);
  thread aud_handle_warning_vo();
  thread aud_handle_wave_incoming();
  thread aud_handle_buoy_sfx();
}

aud_handle_warning_vo() {
  wait(2);

  thread snd_play_in_space("mp_laser2_vo_tsunami_warn_tide", (0, 0, 0));

  wait(5);

  thread snd_play_in_space("mp_laser2_vo_tsunami_warn_high_ground", (0, 0, 0));
}

aud_handle_earthquake(earthquake_duration) {
  thread snd_play_in_space("mp_laser2_ty_initial_hit", (0, 0, 0));
}

aud_handle_buoy_sfx() {
  level endon("aud_kill_dings");
  while(1) {
    thread snd_play_in_space("mp_laser_buoy_ding_event", (150, -2295, 403));
    wait(0.5);
    thread snd_play_in_space("mp_laser_buoy_ding_event", (1026, -2381, 403));
    wait(6);
  }
}

aud_handle_wave_incoming() {
  quake_ent = thread snd_play_loop_in_space("mp_laser2_ty_quake_lp", (79, -1591, 455), "aud_dynamic_event_end");

  thread aud_handle_waves_crash();

  quake_ent ScaleVolume(0, 0.05);

  wait(16.5);
  thread aud_handle_incoming();

  quake_ent ScaleVolume(0.8, 8);
}

aud_handle_incoming() {
  thread snd_play_in_space("mp_laser2_ty_incoming", (79, -1591, 455));
  wait(4);
  level notify("aud_kill_dings");
  Earthquake(.1, 4, (79, -1591, 455), 2500);
  wait(1.2);
  Earthquake(.2, 4, (79, -1591, 455), 2500);
  wait(2);
  Earthquake(.3, 5.5, (79, -1591, 455), 2500);
}

aud_handle_waves_crash() {
  wait(27);
  level notify("aud_dynamic_event_end");
  level._snd.dynamic_event_happened = true;

  foreach(player in level.players) {
    player clientclearsoundsubmix("mp_pre_event_mix");
    wait(0.05);
  }

  wait(0.05);

  foreach(player in level.players) {
    player clientaddsoundsubmix("mp_post_event_mix", 1);
    wait(0.05);
  }
}

handleTsunamiWarningSounds() {
  level endon("game_ended");

  speakers = getEntArray("tsunami_speaker", "targetname");

  while(level.water_warning == true) {
    if(isDefined(speakers)) {
      foreach(speaker in speakers) {
        playsoundatpos(speaker.origin, level.tsunami_alarm);
      }
      playsoundatpos((0, 0, 0), level.tsunami_alarm);
    }
    array_thread(level.AlarmSystem.SpinnerArray, ::SpinAlarmsStart);

    wait(2);

    if(!isDefined(level.water_warning) || level.water_warning != true) {
      return;
    }

    foreach(speaker in speakers) {}

    wait(3);
  }
}