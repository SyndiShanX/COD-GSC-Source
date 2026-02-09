/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_prison_z.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_audio;
#include maps\mp\gametypes\_horde_zombies;

main() {
  maps\mp\mp_prison_z_precache::main();
  maps\createart\mp_prison_z_art::main();
  maps\mp\mp_prison_z_fx::main();
  maps\mp\mp_prison_z_lighting::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_prison");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.mapCustomKillstreakFunc = ::prisonCustomKillstreakFunc;

  thread ambientAnimation();
  thread zombieExtractionGates();
  thread initZombies();

  while(true) {
    level waittill("connected", player);

    skybox_night = getEntArray("prsion_night_sky", "targetname");
    foreach(thing in skybox_night) {
      thing hide();
    }

    level waittill("zombie_go_night");

    skybox_night = getEntArray("prsion_night_sky", "targetname");
    foreach(thing in skybox_night) {
      thing show();
    }

    foreach(player in level.players) {
      player LightSetForPlayer("mp_prison_night");
      player SetClientTriggerVisionSet("mp_prison_night", 1.0);
      if(level.nextgen) {
        player SetClutOverrideEnableForPlayer("clut_identity", 0);
      }
    }

  }
}

prisonCustomKillstreakFunc() {}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1", "r_tonemapkey", "0");
    }
  }
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

zombieExtractionGates() {
  level.zombieMovingGates = [];
  level.zombieRotatingGates = [];

  moveTime = .5;

  extractionGates = getEntArray("extraction_gate", "targetname");

  foreach(gate in extractionGates) {
    gate_struct = spawnStruct();
    gate.originalPos = gate.origin;
    gate_struct.gate = gate;

    moveToOrg = getstruct(gate.target, "targetname");
    gate_struct.dest = moveToOrg;

    col = getent(moveToOrg.target, "targetname");
    col.originalPos = col.origin;
    gate_struct.collision = col;

    level.zombieMovingGates[level.zombieMovingGates.size] = gate_struct;
  }

  foreach(gate in level.zombieMovingGates) {
    gate.gate moveto(gate.dest.origin, moveTime, .1, .2);
    gate.collision moveto(gate.dest.origin, moveTime, .1, .2);
  }

  wait 1.0;

  thread disconnectGatePaths();

  level waittill("start_extraction");

  foreach(gate in level.zombieMovingGates) {
    gate.collision connectpaths();
  }

  foreach(gate in level.zombieMovingGates) {
    gate.gate moveto(gate.gate.originalPos, moveTime, .1, .2);
    gate.collision moveto(gate.gate.originalPos, moveTime, .1, .2);
  }
}

disconnectGatePaths() {
  level endon("game_ended");

  level waittill("start_round");

  wait 5;

  foreach(gate in level.zombieMovingGates) {
    gate.collision disconnectpaths();
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