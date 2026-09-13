/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\turret.gsc
***********************************************/

turret_vm_playeranims_think() {
  self endon("death");

  for(;;) {
    self waittill("turretownerchange");
    player = self getturretowner();
    _id_DE88CD14114C1E24 = undefined;

    if(isDefined(player) && isPlayer(player) && !isbot(player)) {
      player giveweapon(self.weaponinfo);
      _id_DE88CD14114C1E24 = player getcurrentweapon();
      player switchtoweaponimmediate(self.weaponinfo);
    }

    self waittill("turretownerchange");

    if(isDefined(player) && isPlayer(player) && !isbot(player)) {
      player switchtoweaponimmediate(_id_DE88CD14114C1E24);
      player takeweapon(self.weaponinfo);
    }
  }
}