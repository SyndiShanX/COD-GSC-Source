/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_prison.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_audio;

main() {
  maps\mp\mp_prison_precache::main();
  maps\createart\mp_prison_art::main();
  maps\mp\mp_prison_fx::main();
  maps\mp\mp_prison_lighting::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_prison");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.mapCustomKillstreakFunc = ::prisonCustomKillstreakFunc;
  level.orbitalSupportOverrideFunc = ::prisonPaladinOverrides;

  thread GoliathVolumes();

  level.droneVisionSet = "mp_instinct_osp";
  level.droneLightSet = "mp_prison_drone";

  thread ambientAnimation();
}

GoliathVolumes() {
  level.goliath_bad_landing_volumes = getEntArray("goliath_bad_landing_volume", "targetname");
}

prisonCustomKillstreakFunc() {
  level thread maps\mp\killstreaks\streak_mp_prison::init();
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0");
    }
  }
}

prisonPaladinOverrides() {
  level.orbitalsupportoverrides.spawnHeight = 7500;
  level.orbitalsupportoverrides.spawnRadius = 4500;
  level.orbitalsupportoverrides.leftArc = 40;
  level.orbitalsupportoverrides.rightArc = 40;
  level.orbitalsupportoverrides.topArc = -38;
  level.orbitalsupportoverrides.bottomArc = 78;
}

ambientAnimation() {
  radar_dishes = getEntArray("guard_tower_radar", "targetname");

  foreach(dish in radar_dishes) {
    dish thread rotateRadar();
  }
}

rotateRadar() {
  if(!isDefined(level.rotatetime)) {
    level.rotatetime = 20;
  }

  while(1) {
    self RotateVelocity((0, -100, 0), level.rotatetime);
    wait level.rotatetime;
  }
}

setupRiotSuppresionSystem() {
  PreCacheLocationSelector("map_artillery_selector");

  PreCacheString(&"KILLSTREAKS_MP_PRISON");
  PreCacheItem("mp_prison_gas");
  level.gasedVisionSet = "mp_prison_gas";
  level.gas_alarm_sfx_alias = "mp_prison_gas_on_siren";
  level.gate_spark_fx = "gate_sparks";
  level._effect[level.gate_spark_fx] = LoadFX("vfx/sparks/electrical_sparks_oneshot");

  gasFields = getEntArray("gas_trigger", "targetname");

  thread gasFieldsOff();

  if(gasFields.size > 0) {
    precacheshellshock("mp_prison_gas");

    foreach(trigger in gasFields) {
      trigger thread common_scripts\_dynamic_world::triggerTouchThink(::playerEnterArea, ::playerLeaveArea);
    }

    thread onPlayerConnect();
  }

  thread gasVisualsSetup();
  thread setupGates();

  thread monitorRiotSuppressionSystem();
}

monitorRiotSuppressionSystem() {
  level endon("debug_mp_prison_gas");

  level.dynamicEventCount = 3;
  dynamicEventDetaultTimer = 2;

  timelimit = getTimeLimit();
  startRiotSuppressionAt = GetTime() + dynamicEventDetaultTimer * 1000;
  dynamicEventInterval = (timelimit / level.dynamicEventCount) * 60 * 1000;

  for(i = 1; i < level.dynamicEventCount; i++) {
    if(timelimit > 0) {
      startRiotSuppressionAt = gettime() + dynamicEventInterval;
    } else {
      startRiotSuppressionAt = GetTime() + dynamicEventDetaultTimer * 1000;
    }

    while(gettime() < startRiotSuppressionAt) {
      wait 1;
    }

    startRiotSuppressionSystem();
  }
}

startRiotSuppressionSystem() {
  gas_time = 20;

  thread gasVisualsWarningStart();
  thread moveGates();
  thread rotateGates();
  thread rotateGatesConstant();
  thread gas_alarm_on_vo();

  wait 5;

  thread gasVisualsStart();
  thread aud_gas_sfx();

  gasFieldsOn();

  wait gas_time;

  level notify("stop_gas_sfx");
  thread resetGates();
  thread resetRotateGates();
  thread resetRotateGateConstant();
  thread gas_alarm_off_vo();

  gasFieldsOff();
}

aud_gas_sfx() {
  nozzle_org_01 = (-2666, 1305, 828);
  nozzle_org_02 = (-2282, 1305, 840);
  nozzle_org_03 = (-2026, 1305, 840);
  nozzle_org_04 = (-1557, 1305, 840);
  nozzle_org_05 = (-1512, 903, 840);
  nozzle_org_06 = (-2024, 903, 840);
  nozzle_org_07 = (-2411, 903, 840);
  nozzle_org_08 = (-2666, 903, 840);

  gas_nozzles = [nozzle_org_01, nozzle_org_02, nozzle_org_03, nozzle_org_04, nozzle_org_05, nozzle_org_06, nozzle_org_07, nozzle_org_08];

  foreach(nozzle_org in gas_nozzles) {
    thread snd_play_in_space("mp_prison_gas_valve_start", nozzle_org);
    thread snd_play_loop_in_space("mp_prison_gas_lp", nozzle_org, "stop_gas_sfx", 2.2);
  }
}

gas_alarm_on_vo() {
  gas_alarm_vo_org = spawn("script_origin", (-2143, 1108, 946));
  gas_alarm_vo_org playSound("mp_prison_gas_on");
}

gas_alarm_off_vo() {
  gas_alarm_vo_org = spawn("script_origin", (-2143, 1108, 946));
  gas_alarm_vo_org playSound("mp_prison_gas_off_02");
}

gasVisualsSetup() {
  if(!isDefined(level.mp_prison_killstreak)) {
    level.mp_prison_killstreak = spawnStruct();
  }

  if(!isDefined(level.mp_prison_killstreak.gas_tags)) {
    orgs = getStructArray("gas_org", "targetname");
    level.mp_prison_killstreak.gas_tags = [];
    foreach(org in orgs) {
      tag_origin = org spawn_tag_origin();
      tag_origin show();
      level.mp_prison_killstreak.gas_tags[level.mp_prison_killstreak.gas_tags.size] = tag_origin;
    }
  }

  if(!isDefined(level.mp_prison_killstreak.gas_warning_light_tags)) {
    orgs = getStructArray("flashing_red_light", "targetname");
    level.mp_prison_killstreak.gas_warning_light_tags = [];
    foreach(org in orgs) {
      tag_origin = org spawn_tag_origin();
      tag_origin show();
      level.mp_prison_killstreak.gas_warning_light_tags[level.mp_prison_killstreak.gas_warning_light_tags.size] = tag_origin;
    }
  }
}

gasVisualsWarningStart() {
  foreach(org in level.mp_prison_killstreak.gas_warning_light_tags) {
    org thread playLoopingSoundOnOrigin();
  }
  ActivateClientExploder(10);
}

setupGates() {
  gates = getEntArray("moving_gate", "targetname");
  level.mp_prison_killstreak.gates = [];
  foreach(gate in gates) {
    gate_struct = spawnStruct();
    gate.originalPos = gate.origin;
    gate_struct.gate = gate;

    moveToOrg = getstruct(gate.target, "targetname");
    gate_struct.dest = moveToOrg;

    col = getent(moveToOrg.target, "targetname");
    col.originalPos = col.origin;
    gate_struct.collision = col;

    spark_org = getstruct(col.target, "targetname");
    spark1 = spark_org spawn_tag_origin();
    spark1 show();
    spark1 LinkTo(gate);

    spark_org2 = getstruct(spark_org.target, "targetname");
    spark2 = spark_org2 spawn_tag_origin();
    spark2 show();
    spark2 LinkTo(gate);

    gate_struct.sparks = [spark1, spark2];

    level.mp_prison_killstreak.gates[level.mp_prison_killstreak.gates.size] = gate_struct;
  }

  gates = getEntArray("rotating_gate", "targetname");
  level.mp_prison_killstreak.rotating_gates = [];
  foreach(gate in gates) {
    gate_struct = spawnStruct();
    gate.originalPos = gate.origin;
    gate.originalRot = gate.angles;
    gate_struct.gate = gate;

    moveToOrg = getstruct(gate.target, "targetname");
    gate_struct.dest = moveToOrg;

    col = getent(moveToOrg.target, "targetname");
    col.originalPos = col.origin;
    col.angles = gate.angles + (0, -90, 0);
    col.originalRot = col.angles;
    gate_struct.collision = col;

    spark_org = getstruct(col.target, "targetname");
    spark1 = spark_org spawn_tag_origin();
    spark1 show();
    spark1 LinkTo(gate);

    spark_org2 = getstruct(spark_org.target, "targetname");
    spark2 = spark_org2 spawn_tag_origin();
    spark2 show();
    spark2 LinkTo(gate);

    gate_struct.sparks = [spark1, spark2];

    if(isDefined(spark_org2.target)) {
      kill_vol = GetEnt(spark_org2.target, "targetname");
      gate_struct.kill_vol = kill_vol;
      gate_struct.kill_vol trigger_off_proc();
    }

    level.mp_prison_killstreak.rotating_gates[level.mp_prison_killstreak.rotating_gates.size] = gate_struct;
  }

  gates = getEntArray("rotating_gate_constant", "targetname");
  level.mp_prison_killstreak.rotating_gate_constant = [];
  foreach(gate in gates) {
    gate_struct = spawnStruct();
    gate.originalPos = gate.origin;
    gate.originalRot = gate.angles;
    gate_struct.gate = gate;

    moveToOrg = getstruct(gate.target, "targetname");
    gate_struct.dest = moveToOrg;

    spark_org = getstruct(moveToOrg.target, "targetname");
    if(!isDefined(spark_org)) {
      print("Unable to find spark_org " + moveToOrg.target);
      continue;
    }
    spark1 = spark_org spawn_tag_origin();
    spark1 show();
    spark1 LinkTo(gate);

    spark_org2 = getstruct(spark_org.target, "targetname");
    if(!isDefined(spark_org2)) {
      print("Unable to find spark_org2 " + spark_org.target);
      spark1 delete();
      continue;
    }
    spark2 = spark_org2 spawn_tag_origin();
    spark2 show();
    spark2 LinkTo(gate);

    gate_struct.sparks = [spark1, spark2];

    level.mp_prison_killstreak.rotating_gate_constant[level.mp_prison_killstreak.rotating_gate_constant.size] = gate_struct;
  }
}

moveGates() {
  moveTime = .5;

  foreach(gate in level.mp_prison_killstreak.gates) {
    gate.gate moveto(gate.dest.origin, moveTime, .1, .2);
    gate.collision moveto(gate.dest.origin, moveTime, .1, .2);
    gate thread bounceGate(moveTime);
  }
}

rotateGates() {
  moveTime = .5;

  foreach(gate in level.mp_prison_killstreak.rotating_gates) {
    gate thread gateFxOn();
    gate.gate MoveTo(gate.dest.origin, moveTime, .1, .2);
    gate.gate RotateTo(gate.dest.angles, moveTime, .1, .2);
    gate.collision RotateTo(gate.dest.angles - (0, 90, 0), moveTime, .1, .2);
    gate.collision MoveTo(gate.dest.origin, moveTime, .1, .2);
  }

  wait movetime;

  foreach(gate in level.mp_prison_killstreak.rotating_gates) {
    gate thread gateFxOff();
  }
}

rotateGatesConstant() {
  foreach(gate in level.mp_prison_killstreak.rotating_gate_constant) {
    gate thread rotateGateBounce();
  }
}

rotateGateBounce() {
  self endon("stop_bounce");
  while(1) {
    movetime = RandomFloatRange(.1, .5);
    self thread gateFxOn();
    self.gate MoveTo(self.dest.origin, moveTime, .05, .05);
    self.gate RotateTo(self.dest.angles, moveTime, .05, .05);

    wait movetime;
    self.gate MoveTo(self.gate.originalPos, moveTime, .05, .05);
    self.gate RotateTo(self.gate.originalRot, moveTime, .05, .05);

    self thread gateFxOff();
    wait RandomFloatRange(.1, 1);
  }
}

resetRotateGateConstant() {
  moveTime = .5;

  foreach(gate in level.mp_prison_killstreak.rotating_gate_constant) {
    gate notify("stop_bounce");
  }

  wait .5;

  foreach(gate in level.mp_prison_killstreak.rotating_gate_constant) {
    gate thread gateFxOn();
    gate.gate MoveTo(gate.gate.originalPos, moveTime, .05, .05);
    gate.gate RotateTo(gate.gate.originalRot, moveTime, .05, .05);
  }

  wait moveTime;

  foreach(gate in level.mp_prison_killstreak.rotating_gate_constant) {
    gate thread gateFxOff();
  }
}

resetRotateGates() {
  moveTime = .5;

  foreach(gate in level.mp_prison_killstreak.rotating_gates) {
    gate thread gateFxOn();
    if(isDefined(gate.kill_vol)) {
      gate.kill_vol trigger_on_proc();
    }
    gate.gate MoveTo(gate.gate.originalPos, moveTime, .1, .2);
    gate.gate RotateTo(gate.gate.originalRot, moveTime, .1, .2);
    gate.collision RotateTo(gate.collision.originalRot, moveTime, .1, .2);
    gate.collision MoveTo(gate.collision.originalPos, moveTime, .1, .2);
  }

  wait movetime;

  foreach(gate in level.mp_prison_killstreak.rotating_gates) {
    if(isDefined(gate.kill_vol)) {
      gate.kill_vol trigger_off_proc();
    }
    gate thread gateFxOff();
  }
}

resetGates() {
  gateCloseTime = .5;
  foreach(gate in level.mp_prison_killstreak.gates) {
    gate notify("stop_bounce");
  }

  wait .5;

  foreach(gate in level.mp_prison_killstreak.gates) {
    gate thread gateFxOn();
    gate.gate moveto(gate.gate.originalPos, gateCloseTime, .1, .2);
    gate.collision moveto(gate.collision.originalPos, gateCloseTime, .1, .2);
  }

  wait gateCloseTime;

  foreach(gate in level.mp_prison_killstreak.gates) {
    gate thread gateFxOff();
  }
}

bounceGate(delaytime) {
  self endon("stop_bounce");

  thread gateFxOn();
  wait delaytime;
  thread gateFxOff();

  forward = anglesToForward(VectorToAngles(self.dest.origin - self.gate.originalPos));

  bounceDistForward = forward * 2;

  while(1) {
    bounceForwardTime = RandomfloatRange(.1, .5);
    bounceBackTime = RandomfloatRange(.1, .5);

    thread gateFxOn();
    self.gate moveto(self.gate.origin + bounceDistForward, bounceForwardTime, .05, .05);

    wait bounceForwardTime;

    self.gate moveto(self.dest.origin, bounceBackTime, .05, .05);

    wait bounceBackTime;

    thread gateFxOff();

    wait RandomFloat(2);
  }
}

gateFxOn() {
  self endon("stop_sparks");
  while(1) {
    foreach(fx in self.sparks) {
      playFXOnTag(getfx(level.gate_spark_fx), fx, "tag_origin");
    }
    wait randomFloatRange(0.5, 1.0);
  }
}

gateFxOff() {
  self notify("stop_sparks");
  foreach(fx in self.sparks) {
    stopFXOnTag(getfx(level.gate_spark_fx), fx, "tag_origin");
  }
}

gasVisualsStart() {
  ActivateClientExploder(20);
}

gasVisualsEnd() {}

playLoopingSoundOnOrigin() {
  wait 3.5;
  thread playSoundInSpace(level.gas_alarm_sfx_alias, self.origin);
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player.numAreas = 0;
  }
}

playerEnterArea(trigger) {
  self.numAreas++;

  if(self.numAreas == 1) {
    self gasEffect();
  }
}

playerLeaveArea(trigger) {
  self.numAreas--;
  assert(self.numAreas >= 0);

  if(self.numAreas != 0) {
    return;
  }

  self.poison = 0;
  self notify("leftTrigger");

  if(isDefined(self.gasOverlay)) {
    self.gasOverlay fadeoutBlackOut(.10, 0);
  }
}

gasFieldsOn() {
  gasFields = getEntArray("gas_trigger", "targetname");

  foreach(trigger in gasFields) {
    trigger trigger_on();
  }
}

gasFieldsOff() {
  gasFields = getEntArray("gas_trigger", "targetname");

  foreach(trigger in gasFields) {
    trigger trigger_off();
  }
}

soundWatcher(soundOrg) {
  self waittill_any("death", "leftTrigger");

  self stopLoopSound();
}

gasEffect() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("leftTrigger");

  self.poison = 0;
  self thread soundWatcher(self);

  while(1) {
    self.poison++;

    switch (self.poison) {
      case 1:

        self ViewKick(1, self.origin);
        break;
      case 3:
        self shellshock("mp_prison_gas", 4);

        self ViewKick(3, self.origin);
        self doGasDamage(25);
        break;
      case 4:
        self shellshock("mp_prison_gas", 5);

        self ViewKick(15, self.origin);
        self thread blackout();
        self doGasDamage(45);
        break;
      case 6:
        self shellshock("mp_prison_gas", 5);

        self ViewKick(75, self.origin);
        self doGasDamage(80);
        break;
      case 8:
        self shellshock("mp_prison_gas", 5);

        self ViewKick(127, self.origin);
        self doGasDamage(175);

        break;
    }
    wait(1);
  }
  wait(5);
}

blackout() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("leftTrigger");

  if(!isDefined(self.gasOverlay)) {
    self.gasOverlay = newClientHudElem(self);
    self.gasOverlay.x = 0;
    self.gasOverlay.y = 0;
    self.gasOverlay setshader("black", 640, 480);
    self.gasOverlay.alignX = "left";
    self.gasOverlay.alignY = "top";
    self.gasOverlay.horzAlign = "fullscreen";
    self.gasOverlay.vertAlign = "fullscreen";
    self.gasOverlay.alpha = 0;
  }

  min_length = 1;
  max_length = 2;
  min_alpha = .25;
  max_alpha = 1;

  min_percent = 5;
  max_percent = 100;

  fraction = 0;

  for(;;) {
    while(self.poison > 1) {
      percent_range = max_percent - min_percent;
      fraction = (self.poison - min_percent) / percent_range;

      if(fraction < 0) {
        fraction = 0;
      } else if(fraction > 1) {
        fraction = 1;
      }

      length_range = max_length - min_length;
      length = min_length + (length_range * (1 - fraction));

      alpha_range = max_alpha - min_alpha;
      alpha = min_alpha + (alpha_range * fraction);

      end_alpha = fraction * 0.5;

      if(fraction == 1) {
        break;
      }

      duration = length / 2;

      self.gasOverlay fadeinBlackOut(duration, alpha);
      self.gasOverlay fadeoutBlackOut(duration, end_alpha);

      wait(fraction * 0.5);
    }

    if(fraction == 1) {
      break;
    }

    if(self.gasOverlay.alpha != 0) {
      self.gasOverlay fadeoutBlackOut(1, 0);
    }

    wait 0.05;
  }
  self.gasOverlay fadeinBlackOut(2, 0);
}

doGasDamage(iDamage) {
  self thread[[level.callbackPlayerDamage]](
    self, self, iDamage, 0, "MOD_SUICIDE", "mp_prison_gas", self.origin, (0, 0, 0) - self.origin, "none", 0
  );
}

fadeinBlackOut(duration, alpha) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  wait duration;
}

fadeoutBlackOut(duration, alpha) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  wait duration;
}