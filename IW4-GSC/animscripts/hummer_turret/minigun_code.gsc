/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\minigun_code.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\hummer_turret\common;

main(turret) {
  turret.fireInterval = 0.1;
  turret.closeEnoughAimDegrees = 45;
  turret.fireControllerFunc = ::fireController_minigun;
  turret.specialCleanupFunc = ::minigun_cleanup_func;
  turret.default_drop_pitch = 20;

  humvee_turret_init(turret, "minigun");
  wait(0.05);

  turret notify("turret_ready");
}

minigun_cleanup_func(gunner, turret) {
  if(turret GetBarrelSpinRate() > 0) {
    turret StopBarrelSpin();
  }
}
fireController_minigun(turret) {
  self endon("death");
  self endon("dismount");

  assert(isDefined(turret));

  turret endon("kill_fireController");
  turret endon("death");

  turret.extraFireTime_min = 600;
  turret.extraFireTime_max = 900;
  startFireTime = -1;
  ceaseFireTime = undefined;
  extraFireTime = undefined;

  turret.extraSpinTime_min = 250;
  turret.extraSpinTime_max = 2250;
  startExtraSpinningTime = -1;
  extraSpinTime = undefined;

  isFiring = false;
  isSpinning = false;

  turret.fireTime = 0;

  self DoAim(turret);

  while(1) {
    if(turret.doFiring && !isFiring && !self.isCustomAnimating) {
      isFiring = true;

      if(!isSpinning) {
        turret minigun_spinup();
        isSpinning = true;
      }

      turret notify("startfiring");
      startFireTime = GetTime();
      self DoShoot(turret);
      wait(0.05);
    } else if(!turret.doFiring && isFiring) {
      if(!isDefined(ceaseFireTime)) {
        ceaseFireTime = GetTime();
      }

      if(!isDefined(extraFireTime)) {
        extraFireTime = RandomFloatRange(turret.extraFireTime_min, turret.extraFireTime_max);
      }

      if(GetTime() - ceaseFireTime >= extraFireTime) {
        isFiring = false;

        self DoAim(turret);
        startExtraSpinningTime = GetTime();

        ceaseFireTime = undefined;
        extraFireTime = undefined;
      }
    } else if(!turret.doFiring && !isFiring && isSpinning) {
      if(!isDefined(extraSpinTime)) {
        extraSpinTime = RandomFloatRange(turret.extraSpinTime_min, turret.extraSpinTime_max);
      }

      if(self.isCustomAnimating || (GetTime() - startExtraSpinningTime >= extraSpinTime)) {
        turret StopBarrelSpin();
        isSpinning = false;

        extraSpinTime = undefined;
      }
    }

    if(turret.turretstate == "fire") {
      turret.fireTime += 0.05;
    }

    if(turret.fireTime > turret.secsOfFiringBeforeReload) {
      turret.doFiring = false;
      isFiring = false;
      self DoAim(turret);
      startExtraSpinningTime = -1;
      ceaseFireTime = undefined;
      extraFireTime = undefined;

      self thread DoReload(turret);
      turret.fireTime = 0;
    }

    wait(0.05);

    if(!isDefined(turret)) {
      break;
    }
  }
}
minigun_spinup() {
  if(self GetBarrelSpinRate() == 1) {
    return;
  }

  self StartBarrelSpin();

  while(self GetBarrelSpinRate() < 1) {
    wait(0.05);
  }
}