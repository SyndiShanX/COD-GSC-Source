/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_raid_superweapon.gsc
*****************************************************/

func_00D5() {
  level.var_5A61["raid_superweapon"] = ::tryusesuperweapon;
  level.var_5A7D["teslagunmtx_mp"] = "flamethrower";
}

tryusesuperweapon(param_00) {
  var_01 = tryusesuperweaponinternal();
  return var_01;
}

tryusesuperweaponinternal() {
  if(maps\mp\_utility::func_57A0(self)) {
    maps\mp\_matchdata::func_5E9A("raid_superweapon", self.var_116);
    return 1;
  }

  return 0;
}