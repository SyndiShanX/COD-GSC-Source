/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\soldier_agent\setup.gsc
***************************************************/

function setupagent(var_0) {
  if(istrue(self.chopper_lights)) {
    return anim.success;
  }

  scripts\aitypes\combat::soldier_init_common();
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.stopsoonnotifydist = 150;
  self.suppressionthreshold = 0;
  self.goalradius = 480;
  self.goalheight = 1024;
  self.moveplaybackrate = 1;
  self.animplaybackrate = self.moveplaybackrate;
  self.animplaybackrate = 1;
  self.movetransitionrate = 1;
  self.domagicdoorchecks = 1;
  self.brjugg_watchstartnotify = 1;
  self.space = 0;
  self.nocorpse = undefined;
  self.dont_cleanup = 1;
  self.bsoldier = 1;
  self.fnplaceweaponon = &scripts\anim\shared::placeweaponon;
  self.playercleanupentondisconnect = &scripts\anim\shared::dropaiweapon;
  scripts\asm\shared\utility::setupsoldierdefaults();
  self.export = "agent";
  self.dropweapon = 0;
  thread scripts\anim\shared::default_weaponsetup();
  thread handledeathcleanup();
  thread scripts\anim\combat_utility::monitorflash();
  self enablemissedbulletclientonly(1);

  if(isDefined(level.playerent)) {
    self thread[[level.playerent]]();
  }

  self.chopper_lights = 1;
  return anim.success;
}

function handledeathcleanup() {
  level endon("game_ended");
  self waittill("death");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}