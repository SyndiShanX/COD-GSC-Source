/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle_missile.gsc
**************************************/

#include maps\_utility;

main() {
  if(getDvar("cobrapilot_surface_to_air_missiles_enabled") == "") {
    setDvar("cobrapilot_surface_to_air_missiles_enabled", "1");
  }

  self tryReload();
  self thread fireMissile();
  self thread turret_think();
  self thread detachall_on_death();
}

detachall_on_death() {
  self waittill("death");
  self DetachAll();
}

turret_think() {
  self endon("death");

  if(!isDefined(self.script_turret)) {
    return;
  }
  if(self.script_turret == 0) {
    return;
  }
  assert(isDefined(self.script_team));

  self.attackRadius = 30000;
  if(isDefined(self.radius)) {
    self.attackRadius = self.radius;
  }

  difficultyScaler = 1.0;
  if(level.cobrapilot_difficulty == "easy") {
    difficultyScaler = 0.5;
  } else {
  if(level.cobrapilot_difficulty == "medium") {
    difficultyScaler = 1.7;
  }
  } else {
  if(level.cobrapilot_difficulty == "hard") {
    difficultyScaler = 1.0;
  }
  } else {
  if(level.cobrapilot_difficulty == "insane") {
    difficultyScaler = 1.5;
  }
  }
  self.attackRadius *= difficultyScaler;

  if(getDvar("cobrapilot_debug") == "1") {
    iprintln("surface-to-air missile range difficultyScaler = " + difficultyScaler);
  }

  for(;;) {
    wait(2 + randomfloat(1));

    eTarget = undefined;

    if(!isDefined(eTarget)) {
      continue;
    }
    aimOrigin = eTarget.origin;
    if(isDefined(eTarget.script_targetoffset_z)) {
      aimOrigin += (0, 0, eTarget.script_targetoffset_z);
    }

    self setTurretTargetVec(aimOrigin);
    level thread turret_rotate_timeout(self, 5.0);
    self waittill("turret_rotate_stopped");
    self clearTurretTarget();

    if(distance(self.origin, eTarget.origin) > self.attackRadius) {
      continue;
    }
    sightTracePassed = false;
    sightTracePassed = sighttracepassed(self.origin, eTarget.origin + (0, 0, 150), false, self);
    if(!sightTracePassed) {
      continue;
    }
    if(getDvar("cobrapilot_surface_to_air_missiles_enabled") == "1") {
      self notify("shoot_target", eTarget);
      self waittill("missile_fired", eMissile);
      if(isDefined(eMissile)) {
        if(level.cobrapilot_difficulty == "hard") {
          wait(1 + randomfloat(2));
          continue;
        } else if(level.cobrapilot_difficulty == "insane")
          continue;
        else {
          eMissile waittill("death");
        }
      }
      continue;
    }
  }
}

turret_rotate_timeout(turret, time) {
  turret endon("death");
  turret endon("turret_rotate_stopped");
  wait time;
  turret notify("turret_rotate_stopped");
}

within_attack_range(targetEnt) {
  d = distance((self.origin[0], self.origin[1], 0), (targetEnt.origin[0], targetEnt.origin[1], 0));
  zDiff = (targetEnt.origin[2] - self.origin[2]);
  if(zDiff <= 750) {
    return false;
  }
  zMod = zDiff * 2.5;
  if(d <= (self.attackRadius + zMod)) {
    return true;
  }
  return false;
}

fireMissile() {
  self endon("death");

  for(;;) {
    self waittill("shoot_target", targetEnt);

    assert(isDefined(targetEnt));
    assert(isDefined(self.missileTags[self.missileLaunchNextTag]));

    eMissile = undefined;

    if(!isDefined(targetEnt.script_targetoffset_z)) {
      targetEnt.script_targetoffset_z = 0;
    }
    offset = (0, 0, targetEnt.script_targetoffset_z);

    eMissile = self fireWeapon(self.missileTags[self.missileLaunchNextTag], targetEnt, offset);
    assert(isDefined(eMissile));

    if(getDvar("cobrapilot_debug") == "1") {
      level thread draw_missile_target_line(eMissile, targetEnt, offset);
    }

    if(!isDefined(targetEnt.incomming_Missiles)) {
      targetEnt.incomming_Missiles = [];
    }
    targetEnt.incomming_Missiles = array_add(targetEnt.incomming_Missiles, eMissile);

    self detach(self.missileModel, self.missileTags[self.missileLaunchNextTag]);

    self.missileLaunchNextTag++;
    self.missileAmmo--;

    targetEnt notify("incomming_missile", eMissile);

    self tryReload();

    wait 0.05;

    self notify("missile_fired", eMissile);
  }
}

draw_missile_target_line(eMissile, targetEnt, offset) {
  eMissile endon("death");

  for(;;) {
    line(eMissile.origin, targetEnt.origin + offset);
    wait 0.05;
  }
}

tryReload() {
  if(!isDefined(self.missileAmmo)) {
    self.missileAmmo = 0;
  }
  if(!isDefined(self.missileLaunchNextTag)) {
    self.missileLaunchNextTag = 0;
  }

  if(self.missileAmmo > 0) {
    return;
  }
  for(i = 0; i < self.missileTags.size; i++) {
    self attach(self.missileModel, self.missileTags[i]);
  }

  self.missileAmmo = self.missileTags.size;
  self.missileLaunchNextTag = 0;
}