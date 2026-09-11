/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\turret.gsc
***********************************************/

function turret_vm_playeranims_think() {
  self endon("death");

  for(;;) {
    self waittill("turretownerchange");
    var0 = self getturretowner();
    var1 = undefined;

    if(isDefined(var0) && isPlayer(var0) && !isbot(var0)) {
      var0 giveweapon(self.weaponinfo);
      var1 = var0 getcurrentweapon();
      var0 switchtoweaponimmediate(self.weaponinfo);
    }

    self waittill("turretownerchange");

    if(isDefined(var0) && isPlayer(var0) && !isbot(var0)) {
      var0 switchtoweaponimmediate(var1);
      var0 takeweapon(self.weaponinfo);
    }
  }
}