/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\turret.gsc
***********************************************/

function turret_vm_playeranims_think() {
  self endon("death");

  for(;;) {
    self waittill("turretownerchange");
    var_0 = self getturretowner();
    var_1 = undefined;

    if(isDefined(var_0) && isPlayer(var_0) && !isbot(var_0)) {
      var_0 giveweapon(self.weaponinfo);
      var_1 = var_0 getcurrentweapon();
      var_0 switchtoweaponimmediate(self.weaponinfo);
    }

    self waittill("turretownerchange");

    if(isDefined(var_0) && isPlayer(var_0) && !isbot(var_0)) {
      var_0 switchtoweaponimmediate(var_1);
      var_0 takeweapon(self.weaponinfo);
    }
  }
}