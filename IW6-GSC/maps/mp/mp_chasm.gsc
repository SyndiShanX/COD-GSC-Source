/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_chasm.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_chasm_precache::main();
  maps\createart\mp_chasm_art::main();
  maps\mp\mp_chasm_fx::main();

  level thread maps\mp\_movers::main();
  maps\mp\_movers::script_mover_add_parameters("falling_elevator", "delay_till_trigger=1");
  maps\mp\_movers::script_mover_add_parameters("falling_elevator_cables", "delay_till_trigger=1");
  maps\mp\_movers::script_mover_add_parameters("elevator_drop_1", "move_time=.7;accel_time=.7");
  maps\mp\_movers::script_mover_add_parameters("elevator_drop_2", "move_time=1.2;accel_time=1.2;name=elevator_end");

  maps\mp\_load::main();
  thread maps\mp\_fx::func_glass_handler();

  maps\mp\_compass::setupMiniMap("compass_map_mp_chasm");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar_cg_ng("r_specularColorScale", 2.5, 5);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  if(level.gametype == "sd" ||
    level.gameType == "sr") {
    level.srKillCamOverridePosition = [];
    level.srKillCamOverridePosition["_b"] = (384, 278, 1716);
  }

  level thread falling_elevator();
  level thread setupBus();
  level thread initExtraCollision();
}

initExtraCollision() {
  gryphonTrig1Ent = spawn("trigger_radius", (-2304, -3072, 512), 0, 1024, 2048);
  gryphonTrig1Ent.radius = 1024;
  gryphonTrig1Ent.height = 2048;
  gryphonTrig1Ent.angles = (0, 0, 0);
  gryphonTrig1Ent.targetname = "remote_heli_range";

  collision1 = GetEnt("clip256x256x8", "targetname");
  collision1Ent = spawn("script_model", (-1216, 2112, 1376));
  collision1Ent.angles = (0, 0, 0);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  placeableBarrier = spawn("script_model", (-2304, -936, 1492));
  placeableBarrier setModel("placeable_barrier");
  placeableBarrier.angles = (0, 0, 12);

  collision2 = GetEnt("clip32x32x32", "targetname");
  collision2Ent = spawn("script_model", (-1438, -1424, 1030));
  collision2Ent.angles = (0, 0, 0);
  collision2Ent CloneBrushmodelToScriptmodel(collision2);
}

BUS_FALL_DELAY = 1.0;
setupBus() {
  bus = GetEnt("falling_bus", "targetname");
  busCol = GetEnt("bus_collision", "targetname");
  bus.collision = busCol;

  busInterior = getEntArray("falling_bus_parts", "targetname");

  foreach(item in busInterior) {
    item LinkTo(bus);
  }
  bus.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;

  bus thread explosive_damage_watch(bus, "bus_start_fall");
  if(isDefined(busCol)) {
    busCol LinkTo(bus);
    bus thread explosive_damage_watch(busCol, "bus_start_fall");
  }

  ent = bus;
  ent.keyframes = [];
  keyframeName = ent.target;
  i = 0;
  while(isDefined(keyframeName)) {
    struct = getstruct(keyframeName, "targetname");
    if(isDefined(struct)) {
      ent.keyframes[i] = struct;

      i++;
      keyframeName = struct.target;
    } else {
      break;
    }
  }

  if(ent.keyframes.size > 2) {
    ent.keyframes[1].script_duration = 0.75;
    ent.keyframes[1].script_accel = 0.75;
    ent.keyframes[1].script_decel = 0;
    ent.keyframes[1].shakeMag = .5;
    ent.keyframes[1].shakeDuration = 1.5;
    ent.keyframes[1].shakeDistance = 1000;

    ent.keyframes[2].script_duration = 4.0;
    ent.keyframes[2].script_accel = 0.0;
    ent.keyframes[2].script_decel = 0;
  }

  bus.pathBlocker = GetEnt("pathBlocker", "targetname");
  wait(0.05);
  bus.pathBlocker elevatorClearPath();

  bus thread moverDoMove("bus_start_fall");
}

moverDoMove(waitString) {
  level endon("game_ended");

  self waittill(waitString, attacker);

  self playSound("scn_bus_groan");

  self.pathBlocker elevatorBlockPath();

  self busSlidingEffect();

  self.collision killLinkedEntities(attacker);

  for(i = 1; i < self.keyframes.size; i++) {
    kf = self.keyframes[i];

    self MoveTo(kf.origin, kf.script_duration, kf.script_accel, kf.script_decel);
    self RotateTo(kf.angles, kf.script_duration, kf.script_accel, kf.script_decel);

    if(isDefined(kf.shakeMag)) {
      Earthquake(kf.shakeMag, kf.shakeDuration, self.origin, kf.shakeDistance);
    }

    self waittill("movedone");
  }

  fakeBusPos = self.origin + (0, 0, 2000);

  Earthquake(0.25, .5, fakeBusPos, 3000);

  stopFXOnTag(getFx("vfx_bus_fall_dust"), self.busDust, "tag_origin");
  self.busDust Delete();

  PlaySoundAtPos(fakeBusPos, "scn_bus_crash");
}

busSlidingEffect() {
  busDust = GetEnt("busDustEffect2", "targetname");
  busDust setModel("tag_origin");
  busDust LinkTo(self);
  playFXOnTag(getfx("vfx_bus_fall_dust"), busDust, "tag_origin");
  self.busDust = busDust;

  scrapeDustLoc = GetEnt("busDustEffect", "targetname");
  if(isDefined(scrapeDustLoc)) {
    playFX(getFX("vfx_bus_scrape_dust"), scrapeDustLoc.origin, anglesToForward(scrapeDustLoc.angles));
    scrapeDustLoc playSound("scn_bus_slide");
  }
}

killLinkedEntities(attacker) {
  linkedObjs = self GetLinkedChildren();
  foreach(obj in linkedObjs) {
    if(isDefined(obj.owner)) {
      obj DoDamage(1000, self.origin, attacker, self, "MOD_CRUSH");
    }
  }
}

falling_elevator() {
  elevator = GetEnt("falling_elevator", "targetname");
  cables = GetEnt("falling_elevator_cables", "targetname");

  elevatorPathBlocker1 = GetEnt("elevatorBlockPaths1", "targetname");
  elevatorPathBlocker1 elevatorBlockPath();

  if(!isDefined(elevator) || !isDefined(cables)) {
    return;
  }
  while(!isDefined(elevator.linked_ents)) {
    wait .05;
  }

  elevator.state = 1;

  elevator thread falling_elevator_cables(cables);
  elevator thread explosive_damage_watch(elevator, "next_stage");
  foreach(ent in elevator.linked_ents) {
    elevator thread explosive_damage_watch(ent, "next_stage");
  }

  cablePos = cables.origin;

  wait(0.05);
  elevatorPathBlocker2 = GetEnt("elevatorBlockPaths2", "targetname");
  elevatorPathBlocker2 elevatorClearPath();
  elevatorPathBlocker2 SetContents(0);

  elevator.dustEffect = getEntArray("dustEffect", "targetname");
  foreach(ent in elevator.dustEffect) {
    ent LinkTo(cables);
  }
  elevator.sparkEffect = getEntArray("sparkEffect", "targetname");
  foreach(ent in elevator.sparkEffect) {
    ent LinkTo(cables);
  }

  while(1) {
    elevator waittill("next_stage", attacker);

    if(elevator.moving) {
      continue;
    }
    elevator.state++;

    elevator notify("trigger");
    if(isDefined(cables)) {
      cables notify("trigger");
    }

    if(elevator.state == 2) {
      elevator PlaySoundOnMovingEnt("scn_elevator_fall_move");
      cables notify("stop_watching_cable");
      elevatorPathBlocker1 elevatorClearPath();
      elevatorPathBlocker1 SetContents(0);

      foreach(ent in elevator.dustEffect) {
        playFX(getfx("vfx_elevator_fall_dust"), ent.origin);
      }
    } else if(elevator.state == 3) {
      playSoundAtPos(cablePos, "scn_elevator_fall_cable_snap");
      elevatorPathBlocker2 SetContents(1);
      elevatorPathBlocker2 elevatorBlockPath();

      foreach(ent in elevator.sparkEffect) {
        playFX(getfx("vfx_spark_drip_child"), ent.origin);
      }

      elevator killLinkedEntities(attacker);
    }

    elevator waittill("move_end");

    if(elevator.state == 2) {
      playSoundAtPos(cablePos, "scn_elevator_fall_cable_stress");
      playFX(getfx("vfx_elevator_shaft_dust"), elevator.origin);
      Earthquake(0.5, 1.5, elevator.origin, 1000);
    } else if(elevator.state == 3) {
      elevator PlaySoundOnMovingEnt("scn_elevator_fall_crash");
      Earthquake(0.75, 1.5, elevator.origin, 1000);
      elevatorPathBlocker1 SetContents(1);
      elevatorPathBlocker1 elevatorBlockPath();
    }
  }
}

explosive_damage_watch(ent, note) {
  if(!isDefined(note)) {
    note = "explosive_damage";
  }

  ent setCanDamage(true);
  while(1) {
    ent.health = 1000000;
    ent waittill("damage", amount, attacker, direction_vec, point, type);
    if(!is_explosive(type)) {
      continue;
    }
    self notify(note, attacker);
  }
}

falling_elevator_cables(cables) {
  cables endon("stop_watching_cable");

  large_health = 1000000;
  cables setCanDamage(true);
  cables.health = large_health;
  cables.fake_health = 50;

  while(1) {
    cables waittill("damage", amount, attacker, direction_vec, point, type);

    if(cables.moving || (self.state == 2 && !is_explosive(type))) {
      cables.health = cables.health + amount;
      continue;
    }

    if(cables.health > large_health - cables.fake_health) {
      continue;
    }

    self notify("next_stage");
    break;
  }
}

is_explosive(cause) {
  if(!isDefined(cause)) {
    return false;
  }

  cause = tolower(cause);
  switch (cause) {
    case "mod_grenade_splash":
    case "mod_projectile_splash":
    case "mod_explosive":
    case "splash":
      return true;
    default:
      return false;
  }
  return false;
}

elevatorClearPath() {
  self ConnectPaths();
  self Hide();
}

elevatorBlockPath() {
  self Show();
  self DisconnectPaths();
}