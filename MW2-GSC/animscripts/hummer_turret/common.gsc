/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\common.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("generic_human");

humvee_turret_init(turret, turretType) {
  self endon("killanimscript");

  Assert(isDefined(turret));

  animscripts\utility::initialize(turretType);

  self.no_ai = true;
  self.noDrop = true;
  self.a.movement = "stop";
  self.a.special = turretType;
  self.a.usingTurret = turret;
  self.ignoreme = true;
  self.isCustomAnimating = false;
  self SetTurretAnim(self.primaryTurretAnim);
  self SetAnimKnobRestart(self.primaryTurretAnim, 1, 0.2, 1);

  if(isDefined(self.weapon)) {
    self animscripts\shared::placeWeaponOn(self.weapon, "none");
  }

  self.onRotatingVehicleTurret = true;
  self.getOffVehicleFunc = ::turret_cleanup_on_unload;

  self notify("guy_man_turret_stop");
  turret notify("stop_burst_fire_unmanned");

  turret.turretState = "start";
  turret.aiOwner = self;
  turret.fireTime = 0;
  turret SetMode("sentry");
  turret SetSentryOwner(self);
  turret SetDefaultDropPitch(0);
  turret SetTurretCanAIDetach(false);

  self gunner_pain_init();
  level thread handle_gunner_pain(self, turret);
  level thread handle_gunner_death(self, turret);

  turret thread turret_track_rotatedirection(self);

  turret.doFiring = false;
  self thread fireDirector(turret);

  wait(0.05);
  if(IsAlive(self)) {
    self thread gunner_turning_anims(turret);
  }
}

gunner_pain_init() {
  self.allowPain = false;
  self setFlashbangImmunity(true);

  self.og_health = self.health;
  self.health = 200;
}

gunner_pain_reset() {
  self.allowPain = true;
  self setFlashbangImmunity(false);
  self.health = self.og_health;
}

handle_gunner_pain(gunner, turret) {
  gunner endon("death");
  turret endon("death");
  gunner endon("dismount");
  gunner endon("jumping_out");

  while(1) {
    flashedNotify = "flashbang";

    msg = gunner waittill_any_return("damage", flashedNotify);

    painAnim = random(gunner.turretPainAnims);
    if(msg == flashedNotify) {
      painAnim = gunner.turretFlashbangedAnim;
      gunner animscripts\face::SayGenericDialogue("flashbang");
    }

    gunner DoCustomAnim(turret, painAnim, false);
    turret notify("pain_done");
  }
}

turret_recenter() {
  self turret_aim_straight();
  self waittill("pain_done");
  self turret_aim_restore();
}

handle_gunner_death(gunner, turret) {
  gunner endon("dismount");
  turret endon("turret_cleanup");

  gunner.deathanim = gunner.turretDeathAnim;
  gunner.noragdoll = true;

  gunner waittill("death");
  level thread turret_cleanup(gunner, turret);
}
turret_cleanup_on_unload() {
  Assert(isDefined(self.ridingVehicle));

  turret = self.ridingVehicle.mgturret[0];
  Assert(isDefined(turret));

  if(IsAlive(self)) {
    self.no_ai = undefined;
    self.noDrop = undefined;
    self.ignoreme = false;
    self.a.special = "none";
    self.a.usingTurret = undefined;
    self.deathanim = undefined;
    self gunner_pain_reset();
    self.isCustomAnimating = undefined;

    self.turretSpecialAnims = undefined;
    self.turretPainAnims = undefined;

    self.onRotatingVehicleTurret = undefined;
    self.getOffVehicleFunc = undefined;

    self StopUseTurret();

    if(isDefined(self.weapon)) {
      self animscripts\shared::placeWeaponOn(self.weapon, "right");
    }
  }

  level thread turret_cleanup(self, turret);
}

turret_cleanup(gunner, turret) {
  if(!isDefined(turret)) {
    return;
  }

  turret notify("kill_fireController");
  turret notify("turret_cleanup");
  turret SetMode("manual");
  turret ClearTargetEntity();

  turret SetDefaultDropPitch(turret.default_drop_pitch);

  if(isDefined(gunner)) {
    gunner ClearAnim(gunner.additiveUsegunRoot, 0);
    gunner ClearAnim(gunner.additiveRotateRoot, 0);
    gunner ClearAnim(gunner.turretSpecialAnimsRoot, 0);
  }

  turret.fireInterval = undefined;
  turret.closeEnoughAimDegrees = undefined;
  turret.fireControllerFunc = undefined;

  turret.turretState = "free";
  turret.aiOwner = undefined;
  turret.fireTime = undefined;

  if(isDefined(turret.specialCleanupFunc)) {
    level[[turret.specialCleanupFunc]](gunner, turret);
  }
}
turret_track_rotatedirection(gunner) {
  self endon("turret_cleanup");
  self endon("death");
  gunner endon("death");
  gunner endon("detach");

  tag = "tag_aim";
  lastAngles = self GetTagAngles(tag);

  self turret_update_rotatedirection("none");

  while(1) {
    currentAngles = self GetTagAngles(tag);

    oldRight = AnglesToRight(lastAngles);
    currentForward = anglesToForward(currentAngles);

    dot = VectorDot(oldRight, currentForward);

    if(dot == 0) {
      self turret_update_rotatedirection("none");
    } else if(dot > 0) {
      self turret_update_rotatedirection("right");
    } else {
      self turret_update_rotatedirection("left");
    }

    lastAngles = self GetTagAngles(tag);

    wait(0.05);
  }
}

turret_update_rotatedirection(direction) {
  if(!isDefined(self.rotateDirection) || self.rotateDirection != direction) {
    self.rotateDirection = direction;
  }
}

gunner_turning_anims(turret) {
  self endon("death");
  turret endon("death");
  self endon("dismount");
  turret endon("turret_cleanup");

  blendInTime = 0.3;
  blendOutTime = 0.3;

  while(1) {
    turret waittill("new_fireTarget");
    wait(0.05);

    if(!isDefined(turret.fireTarget) || self.isCustomAnimating) {
      continue;
    }

    anime = undefined;

    if(!turret turret_aiming_near_target(turret.fireTarget, turret.closeEnoughAimDegrees)) {
      if(turret.rotateDirection == "right") {
        anime = self.additiveTurretRotateRight;
      } else if(turret.rotateDirection == "left") {
        anime = self.additiveTurretRotateLeft;
      }

      if(isDefined(anime)) {
        self SetAnimLimited(self.additiveRotateRoot, 1, blendInTime, 1);

        self SetAnimKnobLimited(anime, 1, 0, 1);

        while(isDefined(turret.fireTarget) && !turret turret_aiming_near_target(turret.fireTarget, turret.closeEnoughAimDegrees)) {
          if(self.isCustomAnimating) {
            break;
          }

          wait(0.05);
        }

        self ClearAnim(self.additiveRotateRoot, blendOutTime);
      }
    }
  }
}
vehicle_passenger_2_turret(vehicle, pos, turret, animation) {
  vehicle.usedPositions[self.vehicle_position] = false;

  self maps\_vehicle_aianim::guy_cleanup_vehiclevars();
  guy_gets_on_turret(vehicle, pos, turret, animation);
}
guy_goes_directly_to_turret(vehicle, pos, turret, animation) {
  guy_gets_on_turret(vehicle, pos, turret, animation);
}

guy_gets_on_turret(vehicle, pos, turret, animation) {
  self endon("death");
  turret endon("death");

  self StopAnimScripted();
  self notify("newanim");

  self.drivingVehicle = undefined;

  self.no_ai = true;
  animation = % humvee_passenger_2_turret;
  if(!isDefined(animation))
    animation = self.passenger_2_turret_anim;

  animpos = maps\_vehicle_aianim::anim_pos(vehicle, pos);
  org = vehicle GetTagOrigin(animpos.sittag);
  angles = vehicle GetTagAngles(animpos.sittag);

  turret SetDefaultDropPitch(0);
  turret thread turret_animate(turret.passenger2turret_anime);

  self AnimScripted("passenger2turret", org, angles, animation);
  wait(GetAnimLength(animation));
  self StopAnimScripted();

  turret turret_aim_restore();

  self UseTurret(turret);
}

turret_animate(anime) {
  if(isDefined(self.idleAnim)) {
    self ClearAnim(self.idleAnim, 0);
    self.idleAnim = undefined;
  }

  self SetFlaggedAnimKnobRestart("minigun_turret", anime, 1, 0, 1);
  self waittillmatch("minigun_turret", "end");
  self ClearAnim(anime, 0);
}

turret_animfirstframe(anime) {
  self SetAnimKnobRestart(anime, 1, 0, 0);
  self.idleAnim = anime;
}
fireDirector(turret) {
  self endon("death");
  turret endon("death");
  self endon("dismount");
  turret endon("kill_fireController");

  turret thread turret_target_updater(self);
  wait(0.05);

  self thread[[turret.fireControllerFunc]](turret);

  target = undefined;

  while(1) {
    target = turret.fireTarget;

    while(turret target_confirm(target)) {
      if(turret turret_aiming_near_target(target, turret.closeEnoughAimDegrees)) {
        break;
      }
      wait(0.05);
    }

    if(turret target_confirm(target) && !self.ignoreall) {
      turret.doFiring = true;
    }

    while(turret target_confirm(target) && !self.ignoreall && !self.isCustomAnimating) {
      wait(0.05);
    }

    if(turret.Dofiring || self.ignoreall) {
      turret.doFiring = false;
    }

    wait(0.05);
  }
}
target_confirm(target) {
  if(isDefined(self.dontshoot)) {
    AssertEx(self.dontshoot, ".dontshoot must be true or undefined.");
    return false;
  }

  if(!isDefined(self.fireTarget)) {
    return false;
  }

  if(!turret_target_validate(target)) {
    return false;
  }

  if(target != self.fireTarget) {
    return false;
  }

  return true;
}
turret_target_updater(gunner) {
  gunner endon("death");
  self endon("death");
  gunner endon("dismount");
  self endon("kill_fireController");

  self.fireTarget = undefined;

  target = undefined;
  lastTarget = undefined;

  while(1) {
    target = self GetTurretTarget(false);

    doUpdate = false;

    if(turret_target_validate(target) || !isDefined(target)) {
      if(!isDefined(target) && isDefined(lastTarget)) {
        doUpdate = true;
      } else if(isDefined(target) && !isDefined(lastTarget)) {
        doUpdate = true;
      } else if(isDefined(target) && target != lastTarget) {
        doUpdate = true;
      }

      if(doUpdate) {
        self.fireTarget = target;
        lastTarget = target;
        self notify("new_fireTarget");
      }
    }

    wait(0.05);
  }
}

turret_target_validate(target) {
  if(!isDefined(target)) {
    return false;
  }

  if(isDefined(target.ignoreme) && target.ignoreme) {
    return false;
  }

  if(IsSubStr(target.code_classname, "actor") && !IsAlive(target)) {
    return false;
  }

  return true;
}
set_manual_target(target, fireTime_min, fireTime_max, fireTime_message) {
  AssertEx(isDefined(target), "undefined target passed to set_manual_target().");

  self endon("turret_cleanup");

  oldMode = self GetMode();
  if(oldMode != "manual") {
    self SetMode("manual");
  }

  if(!isDefined(fireTime_min) && !isDefined(fireTime_max)) {
    fireTime_min = 1.5;
    fireTime_max = 3;
  }

  self animscripts\hummer_turret\common::custom_anim_wait();
  self SetTargetEntity(target);

  self waittill("turret_on_target");

  if(isDefined(fireTime_message)) {
    self waittill(fireTime_message);
  } else if(isDefined(fireTime_max)) {
    wait(RandomFloatRange(fireTime_min, fireTime_max));
  } else {
    wait(fireTime_min);
  }

  self custom_anim_wait();
  self ClearTargetEntity(target);

  if(isDefined(oldMode)) {
    self SetMode(oldMode);
  }
}

DoShoot(turret) {
  self notify("doshoot_starting");

  self SetAnimLimited(self.additiveUsegunRoot, 1, .1);
  self SetAnimKnobLimited(self.additiveTurretFire, 1, .1);

  turret.turretState = "fire";
  turret thread fire(self);
}

fire(gunner) {
  gunner endon("death");
  self endon("death");
  gunner endon("dismount");
  self endon("kill_fireController");
  self endon("stopfiring");
  self endon("custom_anim");

  while(1) {
    self ShootTurret();
    wait(self.fireInterval);
  }
}

DoAim(turret) {
  turret.turretState = "aim";
  turret notify("stopfiring");

  self thread DoAim_idle_think(turret);
}

DoAim_idle_think(turret) {
  self notify("doaim_idle_think");
  self endon("doaim_idle_think");

  self endon("custom_anim");
  self endon("doshoot_starting");
  self endon("death");

  turret endon("death");
  assertex(isDefined(turret), "The turret is gone!");
  assertex(isalive(self), "No, I can't die!");

  Assert(isDefined(turret.ownervehicle));
  vehicle = turret.ownervehicle;
  assertex(isDefined(vehicle), "There is no vehicle!");

  idle = -1;

  for(;;) {
    if(vehicle Vehicle_GetSpeed() < 1 && idle) {
      self SetAnimLimited(self.additiveUsegunRoot, 1, 0.1);
      self SetAnimKnobLimited(self.additiveTurretIdle, 1, 0.1);
      idle = 0;
    } else
    if(vehicle Vehicle_GetSpeed() >= 1 && !idle) {
      self SetAnimLimited(self.additiveUsegunRoot, 1, 0.1);
      self SetAnimKnobLimited(self.additiveTurretDriveIdle, 1, 0.1);
      idle = 1;
    }

    wait(0.05);
  }
}

turret_gunner_custom_anim(turret, animStr, centerTurretFirst) {
  self endon("death");
  turret endon("death");
  self endon("dismount");
  self endon("jumping_out");

  anime = self.turretSpecialAnims[animStr];
  Assert(isDefined(anime));

  self custom_anim_wait();

  disabledReload = turret reload_disable_safe();

  self DoCustomAnim(turret, anime, centerTurretFirst);

  if(disabledReload) {
    turret reload_enable();
  }
}

reload_disable_safe() {
  disabledReload = false;
  if(!isDefined(self.disableReload) || !self.disableReload) {
    disabledReload = true;
    self.disableReload = true;
  }

  return disabledReload;
}

reload_enable() {
  self.disableReload = false;
}

DoReload(turret) {
  if(isDefined(turret.disableReload)) {
    return;
  }

  self endon("death");
  turret endon("death");
  self endon("dismount");
  self endon("jumping_out");

  self thread custom_battlechatter("inform_reloading");

  self DoCustomAnim(turret, self.turretReloadAnim, true);
}

DoCustomAnim(turret, anime, centerTurretFirst) {
  self notify("do_custom_anim");
  self endon("do_custom_anim");

  Assert(isDefined(anime));

  self.isCustomAnimating = true;
  self.customAnim = anime;
  turret.turretState = "customanim";
  turret TurretFireDisable();

  if(turret GetBarrelSpinRate() > 0) {
    turret StopBarrelSpin();
  }

  turret notify("kill_fireController");
  self notify("custom_anim");

  if(isDefined(centerTurretFirst) && centerTurretFirst) {
    turret turret_aim_straight();
  }

  self SetAnimKnobLimitedRestart(self.turretSpecialAnimsRoot, 1, 0.2);
  self SetFlaggedAnimKnobRestart("special_anim", anime, 1, 0, 1);

  for(;;) {
    self waittill("special_anim", notetrack);
    if(notetrack == "end") {
      break;
    }
  }

  self ClearAnim(self.turretSpecialAnimsRoot, 0.2);

  self SetAnimLimited(self.primaryTurretAnim, 1);
  self SetAnimLimited(self.additiveUsegunRoot, 1);

  if(isDefined(centerTurretFirst) && centerTurretFirst) {
    turret turret_aim_restore();
  }

  self.customAnim = undefined;
  self.isCustomAnimating = false;
  turret TurretFireEnable();

  self thread fireDirector(turret);
}
custom_anim_wait() {
  self endon("death");

  if(!isDefined(self.isCustomAnimating)) {
    return;
  }

  while(self.isCustomAnimating) {
    wait(0.05);
  }
}

turret_aim_straight(straightAngles) {
  if(!isDefined(straightAngles)) {
    currentAngles = self GetTagAngles("tag_flash");
    straightAngles = (0, currentAngles[1], currentAngles[2]);
  }

  self.oldMode = self GetMode();
  self SetMode("manual");

  forward = anglesToForward(straightAngles);
  scalevec = vector_multiply(forward, 96);
  targetOrigin = self GetTagOrigin("tag_aim") + scalevec;
  self.tempTarget = spawn("script_origin", targetOrigin);
  self.tempTarget.ignoreme = true;

  self.tempTarget LinkTo(self.ownerVehicle);

  self ClearTargetEntity();
  self SetTargetEntity(self.tempTarget);

  self waittill("turret_on_target");
}

turret_aim_restore() {
  self ClearTargetEntity();

  if(isDefined(self.tempTarget)) {
    self.tempTarget Unlink();
    self.tempTarget Delete();
  }

  if(isDefined(self.oldMode)) {
    self SetMode(self.oldMode);
    self.oldMode = undefined;
  }
}
turret_aiming_near_target(target, closeEnoughAngle) {
  delta = self turret_get_angle_to_target(target);

  if(delta <= closeEnoughAngle) {
    return true;
  }

  return false;
}

turret_get_angle_to_target(target) {
  yawAngleToTarget = VectorToYaw(target.origin - self.origin);

  turretYawAngle = self GetTagAngles("tag_flash")[1];
  delta = animscripts\utility::AbsAngleClamp180(turretYawAngle - yawAngleToTarget);

  return delta;
}

lerp_out_drop_pitch(time) {
  blend = self create_blend(::blend_dropPitch, 20, 0);
  blend.time = time;
}

blend_dropPitch(progress, start, end) {
  val = start * (1 - progress) + end * progress;
  self SetDefaultDropPitch(val);
}