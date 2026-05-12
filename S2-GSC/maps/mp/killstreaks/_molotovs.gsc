/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_molotovs.gsc
*********************************************/

func_00D5() {
  level.var_5A61["molotovs"] = ::func_9E32;
  level.var_5A7D["killstreak_molotov_cocktail_mp"] = "molotovs";
  level.var_5A7D["killstreak_molotov_cocktail_grenadier_mp"] = "molotovs";
  level.var_5A7D["thermite_flames_mp"] = "molotovs";
}

func_9E32(param_00) {
  var_01 = func_9E33();
  return var_01;
}

func_9E33() {
  if(maps\mp\_utility::func_57A0(self)) {
    maps\mp\_matchdata::func_5E9A("molotovs", self.var_0116);
    return 1;
  }

  return 0;
}