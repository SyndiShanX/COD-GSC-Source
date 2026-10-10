/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\turret.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace turret;

function turret_vm_playeranims_think() {
  self endon("death");

  while(true) {
    self waittill("turretownerchange");
    player = self getturretowner();
    weap = undefined;

    if(isDefined(player) && isPlayer(player) && !isbot(player)) {
      player giveweapon(self.weaponinfo);
      weap = player getcurrentweapon();
      player switchtoweaponimmediate(self.weaponinfo);
    }

    self waittill("turretownerchange");

    if(isDefined(player) && isPlayer(player) && !isbot(player)) {
      player switchtoweaponimmediate(weap);
      player takeweapon(self.weaponinfo);
    }
  }
}