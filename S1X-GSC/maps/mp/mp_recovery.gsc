/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_recovery.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_audio;
#include maps\mp\_dynamic_events;

main() {
  maps\mp\mp_recovery_precache::main();
  maps\createart\mp_recovery_art::main();
  maps\mp\mp_recovery_fx::main();
  maps\mp\_load::main();
  maps\mp\mp_recovery_lighting::main();
  maps\mp\mp_recovery_aud::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_recovery");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.missilefx = loadfx("vfx/test/hms_fireball_explosion_xlrg");

  thread dynamic_ents();
  thread handle_teleport();
  thread dynamic_pathing_main();

  gametype = level.gametype;
  if(!isDefined(level.isHorde)) {
    if(!(gametype == "twar" || gametype == "sd" || gametype == "sr"))
  }
  level thread DynamicEvent(::recovery_dynamic_event);

  level thread onPlayerConnect();

  thread SpawnSetup();
  level.DynamicEventStatus = "before";
  level.hp_pause_for_dynamic_event = false;

  level.orbitalSupportOverrideFunc = ::recoveryCustomOSPFunc;

  level.ospvisionset = "mp_recovery_b";
  level.ospLightSet = "mp_recovery_osp";

  level.droneVisionSet = "mp_recovery_b";
  level.droneLightSet = "mp_recovery";
}

recoveryCustomOSPFunc() {
  level.orbitalsupportoverrides.spawnHeight = 9324;
  level.orbitalsupportoverrides.spawnAngleMin = 290;
  level.orbitalsupportoverrides.spawnAngleMax = 370;
  level.orbitalsupportoverrides.topArc = -45;
  thread recoveryEventCustomOSPFunc();
}

recoveryEventCustomOSPFunc() {
  level waittill("Gas_Cloud_Start");
  level.orbitalsupportoverrides.spawnAngleMin = 120;
  level.orbitalsupportoverrides.spawnAngleMax = 180;
  level.orbitalsupportoverrides.turretPitch = 55;
  level.orbitalsupportoverrides.topArc = -40;
  level.orbitalsupportoverrides.bottomArc = 65;
}

SpawnSetup() {
  level.dynamicHangarSpawns = false;
  level.dynamicSpawns = ::GetListOfGoodSpawnPoints;
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1");
    }
  }
}

dynamic_ents() {
  emergency_state = GetEnt("mp_recovery_signage", "targetname");
  wait(.05);
  emergency_state hide_notsolid();
  FlickerLights();

  rightdoorArray = getEntArray("hangar_door_right", "targetname");

  leftdoorArray = getEntArray("hangar_door_left", "targetname");

  missileArray = getEntArray("chemical_missile", "targetname");
  missile2Array = getEntArray("chemical_missile2", "targetname");
  missile3Array = getEntArray("chemical_missile3", "targetname");
  missile4Array = getEntArray("chemical_missile4", "targetname");
  missile5Array = getEntArray("chemical_missile5", "targetname");
  missile6Array = getEntArray("chemical_missile6", "targetname");

  missile7Array = getEntArray("chemical_missile7", "targetname");
  missile8Array = getEntArray("chemical_missile8", "targetname");
  missile9Array = getEntArray("chemical_missile9", "targetname");
  missile10Array = getEntArray("chemical_missile10", "targetname");

  GasDeathtrigs_1 = getEntArray("deathTrig_1", "targetname");
  GasDeathtrigs_2 = getEntArray("deathTrig_2", "targetname");
  GasDeathtrigs_3 = getEntArray("deathTrig_3", "targetname");

  foreach(trig1 in GasDeathtrigs_1) {
    trig1 DontInterpolate();
    trig1.origin = trig1.origin + (0, 0, -10000);
  }

  foreach(trig2 in GasDeathtrigs_2) {
    trig2 DontInterpolate();
    trig2.origin = trig2.origin + (0, 0, -10000);
  }

  foreach(trig3 in GasDeathtrigs_3) {
    trig3 DontInterpolate();
    trig3.origin = trig3.origin + (0, 0, -10000);
  }

  level waittill("Missile_Wave2_ended");
  level.dynamicHangarSpawns = true;

  level.DynamicEventStatus = "after";

  wait(5);

  foreach(trig1 in GasDeathtrigs_1) {
    trig1 DontInterpolate();
    trig1.origin = trig1.origin + (0, 0, 10000);
  }

  wait(5);

  foreach(trig2 in GasDeathtrigs_2) {
    trig2 DontInterpolate();
    trig2.origin = trig2.origin + (0, 0, 10000);
  }

  wait(5);

  foreach(trig3 in GasDeathtrigs_3) {
    trig3 DontInterpolate();
    trig3.origin = trig3.origin + (0, 0, 10000);
  }
}

recovery_dynamic_event() {
  hologram_signs = GetEnt("hologram_signs", "targetname");
  hologram_signs hide_notsolid();
  emergency_state = GetEnt("mp_recovery_signage", "targetname");
  emergency_state show();
  thread KillLights();
  thread spawnHangarDoors();

  thread volcanoStartEruption();

  thread gasCloudStart();
}

handle_teleport() {
  gametype = level.gametype;
  if(!(gameType == "dom" || gametype == "ctf" || gametype == "hp" || gametype == "ball")) {
    return;
  }

  if(gametype == "hp") {
    level waittill("dynamic_event_starting");
  } else {
    level waittill("hangar_doors_opening");
  }

  level.hp_pause_for_dynamic_event = true;
  maps\mp\_teleport::teleport_to_zone("zone_0", true);

  level.useStartSpawns = false;
}

dynamic_pathing_main() {
  hangar_doors = getEntArray("hangar_door_right", "targetname");

  level waittill("hangar_doors_opening");

  wait(3);
  foreach(door in hangar_doors) {
    if(door.classname == "script_brushmodel") {
      door ConnectPaths();
    }
  }
  escape_nodes = GetNodeArray("escape_gas_dest_node", "targetname");
  escape_triggers = getEntArray("escape_gas_dest_trigger", "targetname");

  foreach(player in level.participants) {
    if(IsAI(player)) {
      player maps\mp\bots\_bots_strategy::bot_defend_stop();

      switch (level.gametype) {
        case "war":
        case "conf":
        case "infect":
        case "dm":
          player thread escape_gas(escape_nodes, escape_triggers);
          break;

        default:
          break;
      }
    }
  }

  level waittill("hangar_doors_closed");

  foreach(door in hangar_doors) {
    if(door.classname == "script_brushmodel") {
      door DisconnectPaths();
    }
  }
}

get_escape_gas_dest_node(escape_nodes) {
  random_int = randomint(escape_nodes.size);
  selected_node = escape_nodes[random_int];

  return selected_node;
}

clear_script_goal_on_gas_end() {
  level endon("game_ended");
  self endon("disconnect");

  level waittill("hangar_doors_closed");
  wait(0.05);
  self BotClearScriptGoal();
}

escape_gas(escape_nodes, escape_triggers) {
  level endon("game_ended");
  level endon("hangar_doors_closed");
  self endon("disconnect");

  self thread clear_script_goal_on_gas_end();

  while(1) {
    dest_node = get_escape_gas_dest_node(escape_nodes);
    self BotSetScriptGoal(dest_node.origin, 512, "critical");
    result = self maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "death");
    if(result == "goal") {
      self BotClearScriptGoal();
      wait(5.0);
    } else {
      wait(1.0);
    }
  }
}

spawnHangarDoors() {
  rightdoorArray = getEntArray("hangar_door_right", "targetname");

  door_open_time = 12;
  door_close_time = 12;

  level waittill("Gas_Cloud_Start");

  level.DynamicEventStatus = "event_in_progress";

  foreach(rightdoor in rightdoorArray) {
    rightdoorOrigin = GetEnt(rightdoor.target, "targetname");
    rightdoor MoveTo(rightdoorOrigin.origin, door_open_time);
  }

  thread notify_doors_open(door_open_time);

  dooropen_sfx = getEntArray("hangar_open_sfx", "targetname");

  foreach(dooropen in dooropen_sfx) {
    snd_play_in_space("mp_recovery_hangar_door_open", dooropen.origin);
  }

  level waittill("close_doors");

  foreach(rightdoor in rightdoorArray) {
    rightdoorOrigin = GetEnt(rightdoor.target, "targetname");
    rightdoorclose = GetEnt(rightdoorOrigin.target, "targetname");
    rightdoor MoveTo(rightdoorclose.origin, door_close_time);
    level thread maps\mp\mp_recovery_fx::sulfur_door_fx();
  }

  thread notify_doors_close(door_close_time);

  dooropen_sfx = getEntArray("hangar_open_sfx", "targetname");

  foreach(dooropen in dooropen_sfx) {
    snd_play_in_space("mp_recovery_hangar_door_close", dooropen.origin);
  }
}

notify_doors_close(wait_time) {
  level notify("hangar_doors_closing");

  playSoundAtPos((0, 0, 0), "mp_recovery_doors_closing");

  wait(wait_time);

  level notify("hangar_doors_closed");

  wait(2);
  playSoundAtPos((0, 0, 0), "mp_recovery_doors_sealed");
}

notify_doors_open(wait_time) {
  level notify("hangar_doors_opening");

  playSoundAtPos((0, 0, 0), "mp_recovery_doors_opening");

  thread side_b_visionset_reset();

  level.hp_pause_for_dynamic_event = false;
  level notify("ready_for_next_hp_zone");

  wait(wait_time);

  level notify("hangar_doors_opened");
}

volcanoStartEruption() {
  thread aud_dyanmic_event();

  Earthquake(.6, 2, (0, 0, 0), 5000);

  foreach(Player in level.players) {
    player thread play_earthquake_rumble(.75);
  }
  level.gas_cloud_origin = getEnt("gas_cloud_origin", "targetname");

  StopClientExploder(200);
  if(isDefined(level.panoramicfx)) {
    level.panoramicfx delete();
  }
  level thread common_scripts\_exploder::activate_clientside_exploder(100);

  wait 8;

  thread boulderBarrage(15, 2.0, 10, 19);
  wait 5;

  foreach(player in level.players) {
    player SetClientTriggerVisionSet("mp_recovery_post", 10.0);
  }

  level notify("Gas_Cloud_Start");
}

aud_dyanmic_event() {
  playSoundAtPos((2067, -2296, 186), "emt_event_volcano_erupt");

  thread aud_handle_alarms();

  wait(4);

  playSoundAtPos((0, 0, 0), "mp_recovery_volcanic_activity");
}

aud_handle_alarms() {
  level endon("hangar_doors_closed");
  while(1) {
    playSoundAtPos((0, 0, 0), "mp_recovery_alarms");

    wait(4);
  }
}

gasCloudStart() {
  level waittill("Gas_Cloud_Start");
  wait 5;

  level.gas_cloud_origin = getEnt("gas_cloud_origin", "targetname");
  playFXOnTag(getfx("pyroclastic_flow_1"), level.gas_cloud_origin, "tag_origin");

  wait 5;

  thread boulderBarrage(15, 2.0, 20, 29);

  delayThread(15, ::boulderBarrage, 15, 1.5, 30, 39);

  level.dynamicHangarSpawns = true;

  gas_cloud_travel_time = 40;
  door_close_time = 12;
  level.gas_cloud_origin moveto((level.gas_cloud_origin.origin + (0, 3912, 0)), gas_cloud_travel_time);
  level.gas_cloud_origin thread killPlayersInCloud(gas_cloud_travel_time + door_close_time, 7.5);
  start_door_close_time = gas_cloud_travel_time - (door_close_time / 2);
  thread setup_poison_gas_death();

  wait start_door_close_time;
  level notify("close_doors");

  wait door_close_time;
  stopFXOnTag(getfx("pyroclastic_flow_1"), level.gas_cloud_origin, "tag_origin");

  level.gas_cloud_origin thread instantKillPlayersInCloud();

  level thread common_scripts\_exploder::activate_clientside_exploder(102);

  wait 0.05;
  level notify("gas_cloud_finished");

  StopClientExploder(40);
}

onPlayerConnect() {
  safe_from_gas_trigger = getEnt("safe_from_gas", "targetname");
  while(true) {
    level waittill("connected", player);
    player thread swapFogAndFX(safe_from_gas_trigger);
  }
}

swapFogAndFX(safe_from_gas_trigger) {
  level endon("gas_cloud_finished");
  self endon("disconnect");

  while(true) {
    if(!isDefined(safe_from_gas_trigger) || !isDefined(self)) {
      break;
    }

    if(level.DynamicEventStatus == "event_in_progress" && IsAlive(self)) {
      if(!(self isTouching(safe_from_gas_trigger)) && isDefined(self.onNoPoisonSide)) {
        self SetClientTriggerVisionSet("mp_recovery_post", 5.0);

        stopFXOnTag(getfx("pyroclastic_flow_2"), level.gas_cloud_origin, "tag_origin");
        playFXOnTag(getfx("pyroclastic_flow_1"), level.gas_cloud_origin, "tag_origin");
        self.onNoPoisonSide = undefined;
      } else if(self isTouching(safe_from_gas_trigger) && !isDefined(self.onNoPoisonSide)) {
        self SetClientTriggerVisionSet("", 5.0);

        stopFXOnTag(getfx("pyroclastic_flow_1"), level.gas_cloud_origin, "tag_origin");
        playFXOnTag(getfx("pyroclastic_flow_2"), level.gas_cloud_origin, "tag_origin");
        self.onNoPoisonSide = true;
      }
      wait(0.2);
    } else {
      wait(1.0);
    }
  }
}

FlickerLights() {
  FlckLgtEnts = GetScriptableArray("stairlgt_die_3", "targetname");
  foreach(FlckLgtEnt in FlckLgtEnts) {
    FlckLgtEnt SetScriptablePartState(0, 1);
  }

  FlckrLgtaEnts = GetScriptableArray("die_2", "targetname");
  foreach(FlckrLgtaEnt in FlckrLgtaEnts) {
    FlckrLgtaEnt SetScriptablePartState(0, 1);
  }
}

KillLights() {
  KillLgtEnts = GetScriptableArray("killed_lights", "targetname");
  foreach(KillLgtEnt in KillLgtEnts) {
    wait(.1);
    KillLgtEnt SetScriptablePartState(0, 1);
  }

  DangerLgtEnts = GetScriptableArray("danger_red", "targetname");
  foreach(DangerLgtEnt in DangerLgtEnts) {
    DangerLgtEnt SetScriptablePartState(0, 1);
  }

  FlckrLgtEnts = GetScriptableArray("die", "targetname");
  foreach(FlckrLgtEnt in FlckrLgtEnts) {
    FlckrLgtEnt SetScriptablePartState(0, 2);
    wait(.1);
    FlckrLgtEnt SetScriptablePartState(0, 3);
  }

  FlckrLgtaEnts = GetScriptableArray("die_2", "targetname");
  foreach(FlckrLgtaEnt in FlckrLgtaEnts) {
    FlckrLgtaEnt SetScriptablePartState(0, 3);
  }

  FlckLgtEnts = GetScriptableArray("stairlgt_die_3", "targetname");
  foreach(FlckLgtEnt in FlckLgtEnts) {
    FlckLgtEnt SetScriptablePartState(0, 3);
  }

  StairLgtEnts = GetScriptableArray("stairlgt_die", "targetname");
  foreach(StairLgtEnt in StairLgtEnts) {
    wait(.1);
    StairLgtEnt SetScriptablePartState(0, 1);
    wait(.15);
    StairLgtEnt SetScriptablePartState(0, 3);
  }

  StairLgt2Ents = GetScriptableArray("stairlgt_die_2", "targetname");
  foreach(StairLgt2Ent in StairLgt2Ents) {
    StairLgt2Ent SetScriptablePartState(0, 3);
    wait(.2);
    StairLgt2Ent SetScriptablePartState(0, 1);
  }

  EvacuateLgtEnts = GetScriptableArray("evacuate_lights", "targetname");
  foreach(EvacuateLgtEnt in EvacuateLgtEnts) {
    EvacuateLgtEnt SetScriptablePartState(0, 1);
  }

  EvacuatePillLgtEnts = GetScriptableArray("evacuate_pill_lights", "targetname");
  foreach(EvacuatePillLgtEnt in EvacuatePillLgtEnts) {
    EvacuatePillLgtEnt SetScriptablePartState(0, 1);
  }

  HoloLgtEnts = GetScriptableArray("hologram_lgt", "targetname");
  foreach(HoloLgtEnt in HoloLgtEnts) {
    HoloLgtEnt SetScriptablePartState(0, 2);
  }

  CaveLgtEnts = GetScriptableArray("cave_kill", "targetname");
  foreach(CaveLgtEnt in CaveLgtEnts) {
    CaveLgtEnt SetScriptablePartState(0, 1);
    wait(.2);
    CaveLgtEnt SetScriptablePartState(0, 2);
  }
}

boulderBarrage(duration, frequency, exploderMin, exploderMax) {
  endTime = getTime() + (duration * 1000);
  randInt = 0;
  lastInt = 0;

  while(getTime() < endTime) {
    wait(randomFloatRange((frequency / 2), frequency));
    while(randInt == 0) {
      randInt = randomIntRange(exploderMin, exploderMax);
      if(randInt == lastInt) {
        randInt = 0;
      } else {
        lastInt = randInt;
        level thread common_scripts\_exploder::activate_clientside_exploder(randInt);
        level thread maps\mp\mp_recovery_fx::setup_boulder_audio(randInt);
        randInt = 0;
        break;
      }
      wait 0.05;
    }
  }
}

killPlayersInCloud(duration, dmgAmount) {
  cloud_height_z = 800;
  safe_from_gas_trigger = getEnt("safe_from_gas", "targetname");
  endTime = getTime() + (duration * 1000);

  foreach(player in level.players) {
    player.isInGas = false;
  }

  while(getTime() < endTime) {
    foreach(player in level.players) {
      playerViewOrigin = player getViewOrigin();
      if((player.origin[1] < (self.origin[1] - 500)) && !(player isTouching(safe_from_gas_trigger))) {
        player DoDamage(dmgAmount, player.origin);

        if(!player isUsingRemote() && (playerViewOrigin[1] < self.origin[1]) && (playerViewOrigin[2] < cloud_height_z)) {
          player SetClientTriggerVisionSet("poison_gas", 1.5);
          player shellshock("mp_lab_gas", 1, true, true, 0);
        }
        player.isInGas = true;
      } else if(!player isUsingRemote()) {
        if(player.isInGas == true) {
          if(player isTouching(safe_from_gas_trigger)) {
            player revertVisionSetForPlayer(1.5);
          } else {
            player SetClientTriggerVisionSet("mp_recovery_post", 1.5);
          }

          player.isInGas = false;
        }
      }
    }

    if(level.gametype == "ctf") {
      foreach(flag in level.teamFlags) {
        if((flag.curOrigin[1] < self.origin[1]) && !(flag.visuals[0] isTouching(safe_from_gas_trigger))) {
          flag maps\mp\gametypes\ctf::returnFlag();
        }
      }
    }

    wait 0.25;
  }
}

instantKillPlayersInCloud() {
  safe_from_gas_trigger = getEnt("safe_from_gas", "targetname");

  foreach(player in level.players) {
    if(!(player isTouching(safe_from_gas_trigger))) {
      player DoDamage(10000, player.origin);
    }
  }
}

side_b_visionset_reset() {
  level endon("game_ended");
  level endon("hangar_doors_closed");

  safe_from_gas_trigger = getEnt("safe_from_gas", "targetname");
  while(true) {
    safe_from_gas_trigger waittill("trigger", player);
    if(isDefined(player) && isPlayer(player) && !isDefined(player.safeFromGas)) {
      player revertVisionSetForPlayer(3.0);
      player.safeFromGas = true;
    }
  }
}

setup_poison_gas_death() {
  foreach(player in level.players) {
    player thread onPlayerDeath();
  }
}

onPlayerDeath() {
  level endon("game_ended");
  self endon("disconnect");

  self waittill("spawned");

  self revertVisionSetForPlayer(0);
}

ShockThink() {
  if(!isDefined(self.inGas)) {
    self shellshock("mp_lab_gas", 1);
  }
}

play_event_music() {}

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

GetListOfGoodSpawnPoints(fullListOfSpawnPoints) {
  goodpoints = [];

  foreach(spawn in fullListOfSpawnPoints) {
    if(!isDefined(spawn.targetname) || (spawn.targetname == "")) {
      goodpoints = add_to_array(goodpoints, spawn);
    } else if(spawn GetValidSpawns() == true) {
      goodpoints = add_to_array(goodpoints, spawn);
    }
  }
  return goodpoints;
}
GetValidSpawns() {
  if(level.dynamicHangarSpawns == false) {
    if(self.targetname == "first_map_spawns") {
      return true;
    }
  } else if(level.dynamicHangarSpawns == true) {
    if(self.targetname == "second_map_spawns") {
      return true;
    }
  }
  return false;
}