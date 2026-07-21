/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\turret.gsc
***********************************************/

turret_vm_playeranims_think() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B684128ED593C9ACD1DEDD7356E41B0D16739D95");
    var_0 = self getturretowner();
    var_1 = undefined;

    if(isDefined(var_0) && isPlayer(var_0) && !isbot(var_0)) {
      var_0 giveweapon(self.weaponinfo);
      var_1 = var_0 getcurrentweapon();
      var_0 switchtoweaponimmediate(self.weaponinfo);
    }

    self waittill("_encstr_B684128ED593C9ACD1DEDD7356E41B0D16739D95");

    if(isDefined(var_0) && isPlayer(var_0) && !isbot(var_0)) {
      var_0 switchtoweaponimmediate(var_1);
      var_0 takeweapon(self.weaponinfo);
    }
  }
}