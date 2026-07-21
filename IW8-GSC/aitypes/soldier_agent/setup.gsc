/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\soldier_agent\setup.gsc
***********************************************/

setupagent(var_0) {
  if(istrue(self.chopper_lights))
    return anim.success;

  scripts\aitypes\combat::soldier_init_common();
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.stopsoonnotifydist = 150;
  self.suppressionthreshold = 0.0;
  self.goalradius = 480;
  self.goalheight = 1024;
  self.moveplaybackrate = 1.0;
  self.animplaybackrate = self.moveplaybackrate;
  self.animplaybackrate = 1;
  self.movetransitionrate = 1;
  self.domagicdoorchecks = 1;
  self.brjugg_watchstartnotify = 1;
  self.space = 0;
  self.nocorpse = undefined;
  self.dont_cleanup = 1;
  self.bsoldier = 1;
  self.fnplaceweaponon = _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon;
  self.playercleanupentondisconnect = _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::dropaiweapon;
  scripts\asm\shared\utility::setupsoldierdefaults();
  self.export = "_encstr_AA15062C769537A3";
  self.dropweapon = 0;
  thread _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::default_weaponsetup();
  thread handledeathcleanup();
  thread _encstr_83062042F108F193B56F3EFFADD38A7F58D87D8E2950BF9B8D733BD7B183C66F70A1::monitorflash();
  self enablemissedbulletclientonly(1);

  if(isDefined(level.playerent))
    self thread[[level.playerent]]();

  self.chopper_lights = 1;
  return anim.success;
}

handledeathcleanup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}