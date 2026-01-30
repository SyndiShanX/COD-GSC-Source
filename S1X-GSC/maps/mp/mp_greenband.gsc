/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_greenband.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;
#include maps\mp\_dynamic_events;

main() {
  maps\mp\mp_greenband_precache::main();
  maps\createart\mp_greenband_art::main();
  maps\mp\mp_greenband_fx::main();

  maps\mp\_load::main();

  thread setup_audio();

  maps\mp\_compass::setupMiniMap("compass_map_mp_greenband");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_diffuseColorScale", 1.5);

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");

  level.ospvisionset = "(mp_greenband_osp)";
  level.osplightset = "(mp_greenband_osp)";
  level.droneVisionSet = "(mp_greenband_drone)";
  level.droneLightSet = "(mp_greenband_drone)";
  level.warbirdVisionSet = "(mp_greenband_warbird)";
  level.warbirdLightSet = "(mp_greenband_warbird)";

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  if(level.nextgen) {
    level.aerial_pathnode_group_connect_dist = 600;
  }

  level thread maps\mp\_water::init();
  level thread greenband_drones();

  if(!isDefined(level.airstrikeoverrides)) {
    level.airstrikeoverrides = spawnStruct();
  }
  level.airstrikeoverrides.spawnHeight = 2500;

  level.orbitalSupportOverrideFunc = ::greenbandCustomOSPFunc;

  level.goliath_bad_landing_volumes = getEntArray("goliath_bad_landing_volume", "targetname");
}

greenbandCustomOSPFunc() {
  level.orbitalsupportoverrides.spawnHeight = 9279;
  level.orbitalsupportoverrides.spawnRadius = 7000;
  level.orbitalsupportoverrides.turretPitch = 50;
  level.orbitalsupportoverrides.spawnAngleMin = undefined;
  level.orbitalsupportoverrides.spawnAngleMax = undefined;

  if(level.currentgen) {
    level.orbitalsupportoverrides.topArc = -40;
  }
}

setup_audio() {
  AmbientPlay("amb_gnb_ext");
}

greenband_drones() {
  level thread test_drone();

  level.drones = [];
  level thread ambient_police_drones();
  level thread vista_police_drones();
  level thread vista_police_group_drones();
}

test_drone() {
  test_drone = undefined;
  while(1) {
    SetDevDvar("spawn_test_drone", 0);
    while(!GetDvarInt("spawn_test_drone")) {
      waitframe();
    }

    if(isDefined(test_drone)) {
      test_drone delete();
    }

    test_drone = spawn_police_drone("test");
    test_drone.origin = level.player.origin;
    test_drone.angles = level.player.angles;
  }
}

spawn_police_drone_with_anim(droneType, drone_anim, respawn_anim) {
  anim_node = GetStruct("event_anim_node", "targetname");

  new_drone = spawn_police_drone(droneType);

  if(isDefined(respawn_anim)) {
    while(1) {
      new_drone.health = 20;
      new_drone setCanDamage(true);

      new_drone thread police_drone_play_anim(drone_anim, respawn_anim, droneType, anim_node);
      new_drone waittill("death");

      new_drone Hide();
      playFX(level._effect["vehicle_pdrone_explosion"], new_drone.origin);
      playSoundAtPos(new_drone.origin, "mp_greenband_drone_exp");

      new_drone waittillmatch("event_police_drone", "enter_start");

      new_drone Show();
      new_drone thread police_drone_play_all_fx();
    }
  } else {
    new_drone thread police_drone_play_anim(drone_anim, undefined, droneType, anim_node);
  }
}

police_drone_play_anim(drone_anim, enter_anim, droneType, anim_node) {
  self notify("police_drone_play_anim");
  self endon("police_drone_play_anim");

  self ScriptModelClearAnim();

  if(isDefined(enter_anim)) {
    self ScriptModelPlayAnimDeltaMotionFromPos(enter_anim, anim_node.origin, anim_node.angles, "event_police_drone");
    self waittillmatch("event_police_drone", "end");
  }

  self ScriptModelPlayAnimDeltaMotionFromPos(drone_anim, anim_node.origin, anim_node.angles, "event_police_drone");
}

spawn_police_drone(droneType) {
  new_drone = spawn("script_model", (0, 0, 0));
  new_drone.angles = (0, 0, 0);
  new_drone.destroyed = false;
  new_drone.droneType = droneType;

  if(!isDefined(level.drones[droneType])) {
    level.drones[droneType] = [];
  }

  level.drones[droneType][level.drones[droneType].size] = new_drone;

  switch (droneType) {
    case "test":
    case "ambient":
      new_drone.light_fx_name = "mp_gb_drone_blink_nt";
      new_drone.exhaust_fx_name = "mp_gb_drone_trail";
      new_drone setModel("vehicle_police_drone_01_anim");
      new_drone playLoopSound("mp_gnb_police_drone_hover_lp");
      break;
    case "vista":
      new_drone.light_fx_name = "mp_gb_drone_blink_vista";
      new_drone.exhaust_fx_name = "mp_gb_drone_trail_vista";
      new_drone setModel("vehicle_police_drone_01_simple_anim");
      break;
    case "vista_group":
      new_drone.light_fx_name = "mp_gb_drone_hd_grp";
      new_drone.exhaust_fx_name = "mp_gb_drone_trail_grp";
      new_drone setModel("vehicle_police_drone_01_group_anim");
      new_drone playLoopSound("mp_gnb_drone_group_flyby");
      break;
    default:
      break;
  }

  new_drone thread police_drone_play_all_fx();

  return new_drone;
}

police_drone_play_all_fx() {
  self endon("death");

  self thread police_drone_play_fx(self.light_fx_name, "tag_lights");
  self thread police_drone_play_fx(self.exhaust_fx_name, "tag_exhaust");

  while(1) {
    level waittill("connected", player);

    self thread police_drone_play_fx(self.light_fx_name, "tag_lights", player);
    self thread police_drone_play_fx(self.exhaust_fx_name, "tag_exhaust", player);
  }
}

police_drone_play_fx(fx_name, tag_name, player) {
  if(!isDefined(fx_name)) {
    return;
  }

  if(isDefined(player)) {
    player endon("death");
  }

  waitframe();

  tags = [tag_name];
  if(self.droneType == "vista_group") {
    for(i = 1; i < 5; i++) {
      tags[tags.size] = tag_name + "" + i;
    }
  }

  foreach(tag in tags) {
    if(isDefined(player)) {
      PlayFXOnTagForClients(level._effect[fx_name], self, tag, player);
    } else {
      playFXOnTag(level._effect[fx_name], self, tag);
    }
    waitframe();
  }
}

vista_police_group_drones() {
  level thread spawn_police_drone_with_anim("vista_group", "mp_gb_drone_vista_group_01");
  level thread spawn_police_drone_with_anim("vista_group", "mp_gb_drone_vista_group_02");
}

vista_police_drones() {
  level thread spawn_police_drone_with_anim("vista", "mp_gb_drone_vista_01");
  level thread spawn_police_drone_with_anim("vista", "mp_gb_drone_vista_02");
  level thread spawn_police_drone_with_anim("vista", "mp_gb_drone_vista_03");
  level thread spawn_police_drone_with_anim("vista", "mp_gb_drone_vista_04");
}

ambient_police_drones() {
  level thread spawn_police_drone_with_anim("ambient", "mp_gb_drone_circle_01", "mp_gb_drone_circle_01_enter");
  level thread spawn_police_drone_with_anim("ambient", "mp_gb_drone_circle_02", "mp_gb_drone_circle_02_enter");
  level thread spawn_police_drone_with_anim("ambient", "mp_gb_drone_circle_03", "mp_gb_drone_circle_03_enter");
  level thread spawn_police_drone_with_anim("ambient", "mp_gb_drone_circle_04", "mp_gb_drone_circle_04_enter");
  level thread ambient_police_drone_vo();
}

ambient_police_drone_vo() {
  while(1) {
    foreach(drone in level.drones["ambient"]) {
      if(!drone.destroyed) {
        wait RandomFloatRange(7, 15);
        drone playSound("mp_gnb_police_drone_chatter");
      }
    }
    wait 1;
  }
}