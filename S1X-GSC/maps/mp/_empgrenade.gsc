/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_empgrenade.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
  PrecacheDigitalDistortCodeAssets();
  thread onPlayerConnect();
  PreCacheString(&"MP_EMP_REBOOTING");
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    self thread monitorEMPGrenade();
  }
}

monitorEMPGrenade() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.empEndTime = 0;

  while(1) {
    self waittill("emp_grenaded", attacker);

    if(!isalive(self)) {
      continue;
    }

    if(isDefined(self.usingRemote)) {
      continue;
    }

    if(self _hasPerk("specialty_empimmune")) {
      continue;
    }

    hurtVictim = true;
    hurtAttacker = false;

    assert(isDefined(self.pers["team"]));

    if(level.teamBased && isDefined(attacker) && isDefined(attacker.pers["team"]) && attacker.pers["team"] == self.pers["team"] && attacker != self) {
      if(level.friendlyfire == 0) {
        continue;
      } else if(level.friendlyfire == 1) {
        hurtattacker = false;
        hurtvictim = true;
      } else if(level.friendlyfire == 2) {
        hurtvictim = false;
        hurtattacker = true;
      } else if(level.friendlyfire == 3) {
        hurtattacker = true;
        hurtvictim = true;
      }
    } else if(isDefined(attacker)) {
      attacker notify("emp_hit");
      if(attacker != self) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_onthepulse");
      }
    }

    if(hurtvictim && isDefined(self)) {
      self thread applyEMP();
    }
    if(hurtattacker && isDefined(attacker)) {
      attacker thread applyEMP();
    }
  }
}

emp_hide_HUD(id) {
  maps\mp\gametypes\_scrambler::playerSetHUDEmpScrambledOff(id);
}

applyEMP() {
  self notify("applyEmp");
  self endon("applyEmp");

  self endon("death");
  self endon("disconnect");

  wait .05;
  self.empDuration = 3;

  HUDtext = 2;

  if(isAugmentedGameMode()) {
    HUDtext = 1;
    self playerAllowHighJump(false, "empgrenade");
    self playerAllowHighJumpDrop(false, "empgrenade");
    self playerAllowBoostJump(false, "empgrenade");
    self playerAllowPowerSlide(false, "empgrenade");
    self playerAllowDodge(false, "empgrenade");
  }

  self.empGrenaded = true;

  self.empEndTime = getTime() + (self.empDuration * 1000);
  id = maps\mp\gametypes\_scrambler::playerSetHUDEmpScrambled(self.empEndTime, HUDtext, "emp");
  self thread digitalDistort(self.empDuration, id);

  self thread empRumbleLoop(.75);
  self setEMPJammed(true);

  self thread empGrenadeDeathWaiter(id);
  wait(self.empDuration);
  self notify("empGrenadeTimedOut");
  self checkToTurnOffEmp(id);
}

digitalDistort(empDuration, id) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");

  self DigitalDistortSetMaterial("digital_distort_mp");
  self DigitalDistortSetParams(1.0, 1.0);

  self thread watchDistortDisconnectDeath(id);

  wait(0.1);

  fadeTime = empDuration;
  maxIntensity = 0.95;
  minIntensity = 0.2;
  intensityRange = maxIntensity - minIntensity;
  increment = 0.1;
  currentIntensity = maxIntensity;
  while(fadeTime > 0) {
    currentIntensity = intensityRange * (fadeTime / empDuration) + minIntensity;
    self DigitalDistortSetParams(currentIntensity, 1.0);
    fadeTime -= increment;
    wait(increment);
  }
  self DigitalDistortSetParams(0.0, 0.0);
}

watchDistortDisconnectDeath(id) {
  self waittill_any("death", "disconnect", "faux_spawn", "joined_team");
  if(isDefined(self)) {
    self DigitalDistortSetParams(0.0, 0.0);
    emp_hide_HUD(id);
  }
}

empGrenadeDeathWaiter(id) {
  self notify("empGrenadeDeathWaiter");
  self endon("empGrenadeDeathWaiter");

  self endon("empGrenadeTimedOut");

  self waittill("death");
  self checkToTurnOffEmp(id);
}

checkToTurnOffEmp(id) {
  self.empGrenaded = false;

  self setEMPJammed(false);

  if(isAugmentedGameMode()) {
    self playerAllowHighJump(true, "empgrenade");
    self playerAllowHighJumpDrop(true, "empgrenade");
    self playerAllowBoostJump(true, "empgrenade");
    self playerAllowPowerSlide(true, "empgrenade");
    self playerAllowDodge(true, "empgrenade");
  }
  self DigitalDistortSetParams(0.0, 0.0);
  self emp_hide_HUD(id);
}

empRumbleLoop(duration) {
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");

  goalTime = getTime() + duration * 1000;

  while(getTime() < goalTime) {
    self PlayRumbleOnEntity("damage_heavy");
    wait(0.05);
  }
}

isEMPGrenaded() {
  return isDefined(self.empEndTime) && gettime() < self.empEndTime;
}