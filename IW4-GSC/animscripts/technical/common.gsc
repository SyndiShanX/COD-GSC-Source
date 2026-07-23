/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\technical\common.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;

main(turret) {
  self endon("killanimscript");

  assert(isDefined(turret));

  animscripts\utility::initialize("technical");

  if(!isDefined(turret)) {
    return;
  }

  self.a.special = "technical";

  if(isDefined(turret.script_delay_min)) {
    turret_delay = turret.script_delay_min;
  } else {
    turret_delay = maps\_mgturret::burst_fire_settings("delay");
  }

  if(isDefined(turret.script_delay_max)) {
    turret_delay_range = turret.script_delay_max - turret_delay;
  } else {
    turret_delay_range = maps\_mgturret::burst_fire_settings("delay_range");
  }

  if(isDefined(turret.script_burst_min)) {
    turret_burst = turret.script_burst_min;
  } else {
    turret_burst = maps\_mgturret::burst_fire_settings("burst");
  }

  if(isDefined(turret.script_burst_max)) {
    turret_burst_range = turret.script_burst_max - turret_burst;
  } else {
    turret_burst_range = maps\_mgturret::burst_fire_settings("burst_range");
  }

  pauseUntilTime = getTime();
  turretState = "start";

  self animscripts\shared::placeWeaponOn(self.weapon, "none");
  turret show();

  self.a.postScriptFunc = ::preplacedPostScriptFunc;

  turret notify("stop_burst_fire_unmanned");

  turret.doFiring = false;
  self thread fireController(turret);

  self setTurretAnim(self.primaryTurretAnim);
  self setAnimKnobRestart(self.primaryTurretAnim, 1, 0.2, 1);

  self setAnimKnobLimitedRestart(self.additiveTurretIdle);
  self setAnimKnobLimitedRestart(self.additiveTurretFire);

  turret endon("death");
  for(;;) {
    if(turret.doFiring) {
      thread DoShoot(turret);

      self waitTimeOrUntilTurretStateChange(randomFloatRange(turret_burst, turret_burst + turret_burst_range), turret);
      turret notify("turretstatechange");

      if(turret.doFiring) {
        thread DoAim(turret);
        wait(randomFloatRange(turret_delay, turret_delay + turret_delay_range));
      }
    } else {
      thread DoAim(turret);
      turret waittill("turretstatechange");
    }
  }
}

waitTimeOrUntilTurretStateChange(time, turret) {
  turret endon("turretstatechange");
  wait time;
}

fireController(turret) {
  self endon("killanimscript");

  fovdot = cos(15);

  for(;;) {
    while(isDefined(self.enemy)) {
      if(self turret_should_shoot(turret, fovdot)) {
        if(!turret.doFiring) {
          turret.doFiring = true;
          turret notify("turretstatechange");
        }
      } else if(turret.doFiring) {
        turret.doFiring = false;
        turret notify("turretstatechange");
      }

      wait(0.05);
    }

    if(turret.doFiring) {
      turret.doFiring = false;
      turret notify("turretstatechange");
    }

    wait(0.05);
  }
}

turret_should_shoot(turret, fovdot) {
  ASSERT(isDefined(self.enemy));

  enemypos = self.enemy.origin;
  turretAimPos = turret getTagAngles("tag_aim");

  if(within_fov(turret.origin, turretAimPos, enemypos, fovdot) || distanceSquared(turret.origin, enemyPos) < 200 * 200) {
    if(!self turret_would_hit_friend(turret)) {
      return true;
    }
  }

  return false;
}

turret_would_hit_friend(turret, friendlyTeam) {
  tag = "tag_flash";
  start = turret GetTagOrigin(tag);
  vec = anglesToForward(turret GetTagAngles(tag));
  end = vector_multiply(vec, 10000);

  trace = bulletTrace(start, end, true, undefined);
  ent = trace["entity"];

  if(isDefined(ent)) {
    if((isDefined(ent.team) && ent.team == self.team) || (isDefined(ent.script_team) && ent.script_team == self.team)) {
      return true;
    }
  }

  return false;
}

turretTimer(duration, turret) {
  if(duration <= 0) {
    return;
  }
  self endon("killanimscript");
  turret endon("turretstatechange");

  wait(duration);
  turret notify("turretstatechange");
}

postScriptFunc(animscript) {
  if(animscript == "pain") {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 64 * 64) {
      self.a.usingTurret hide();
      self animscripts\shared::placeWeaponOn(self.weapon, "right");
      self.a.postScriptFunc = ::postPainFunc;
      return;
    } else {
      self StopUseTurret();
    }
  }

  assert(self.a.usingTurret.aiOwner == self);

  if(animscript == "saw") {
    turret = self GetTurret();
    assert(isDefined(turret) && turret == self.a.usingTurret);
    return;
  }

  self.a.usingTurret Delete();
  self.a.usingTurret = undefined;

  self animscripts\shared::placeWeaponOn(self.weapon, "right");
}

postPainFunc(animscript) {
  assert(isDefined(self.a.usingTurret));
  assert(self.a.usingTurret.aiOwner == self);

  if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 64 * 64) {
    self stopUseTurret();

    self.a.usingTurret delete();
    self.a.usingTurret = undefined;

    if(isDefined(self.weapon) && self.weapon != "none") {
      self animscripts\shared::placeWeaponOn(self.weapon, "right");
    }
  } else if(animscript != "saw") {
    self.a.usingTurret delete();
  }
}

preplacedPostScriptFunc(animscript) {
  self animscripts\shared::placeWeaponOn(self.weapon, "right");
}

#using_animtree("generic_human");

DoShoot(turret) {
  self setAnim(%additive_saw_idle, 0, .1);
  self setAnim(%additive_saw_fire, 1, .1);

  TurretDoShoot(turret);
}

DoAim(turret) {
  self setAnim(%additive_saw_idle, 1, .1);
  self setAnim(%additive_saw_fire, 0, .1);
}
#using_animtree("mg42");

TurretDoShoot(turret) {
  self endon("killanimscript");
  turret endon("turretstatechange");
  turret endon("death");

  for(;;) {
    turret ShootTurret();
    wait(0.15);
  }
}

turretDoShootAnims() {
  self setAnim(%additive_saw_idle, 0, .1);
  self setAnim(%additive_saw_fire, 1, .1);
}

turretDoAimAnims() {
  self setAnim(%additive_saw_idle, 1, .1);
  self setAnim(%additive_saw_fire, 0, .1);
}