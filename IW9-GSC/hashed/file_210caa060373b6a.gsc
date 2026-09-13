/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_210caa060373b6a.gsc
***********************************************/

setupagent(taskid) {
  if(istrue(self.bagentinitialized))
    return anim.success;

  scripts\aitypes\combat::soldier_init_common();
  self.goalradius = 480;
  self.goalheight = 1024;
  self.moveplaybackrate = 1.0;
  self.animplaybackrate = 1.0;
  self.movetransitionrate = 1.0;
  self._id_79C2DE8443D5F950 = 1;
  self.dont_cleanup = 1;
  self.bsoldier = 1;
  self.space = 0;
  self.export = "agent";
  self._id_689BF433CB5C5322 = "melee_ai_mp";
  self.fnplaceweaponon = _id_3433EE6B63C7E243::placeweaponon;
  self.fndropweapon = _id_3433EE6B63C7E243::dropaiweapon;
  self.fnstealthgotonode = _id_5938B1C7E9CF6DDD::go_to_node;
  scripts\asm\soldier\patrol::_id_3ABA5F22B60D37F5();
  scripts\asm\shared\utility::setupsoldierdefaults();
  self._id_DF41B7F76F62D9A2 = 1;
  self.dropweapon = 0;
  thread _id_3433EE6B63C7E243::default_weaponsetup();
  thread handledeathcleanup();
  thread _id_13D1C402F1421C35::monitorflash();
  self _meth_33C6BAADEDC4DCDE(1);

  if(isDefined(level.fnoffhandfire))
    self thread[[level.fnoffhandfire]]();

  self.bagentinitialized = 1;
  return anim.success;
}

_id_40150623EB9F4EA2(taskid) {
  self.disablepistol = 1;
  self.disablelmgmount = 1;
  self._id_98ADD129A7ECB962 = 0;
}

handledeathcleanup() {
  level endon("game_ended");
  self waittill("death");
  scripts\asm\asm_bb::bb_clearmeleetarget();
}