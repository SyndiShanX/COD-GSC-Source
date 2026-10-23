/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_molotovs.gsc
*****************************************************/

init() {
  level.killstreakfuncs["molotovs"] = ::_id_9E32;
  level.killstreakwieldweapons["killstreak_molotov_cocktail_mp"] = "molotovs";
  level.killstreakwieldweapons["killstreak_molotov_cocktail_grenadier_mp"] = "molotovs";
  level.killstreakwieldweapons["thermite_flames_mp"] = "molotovs";
}

_id_9E32(var_0) {
  var_1 = _id_9E33();
  return var_1;
}

_id_9E33() {
  if(maps\mp\_utility::isreallyalive(self)) {
    _id_0485::_id_5E9A("molotovs", self.origin);
    return 1;
  } else
    return 0;
}