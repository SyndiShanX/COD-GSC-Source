/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2747.gsc
*************************************************/

_id_10014() {
  _id_0AA3::_id_C28D(_id_09DE::_id_10017);
  _id_0A97::_id_C28B(_id_09DE::_id_10016);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::_id_10015);
}

_id_10015(var_0, var_1) {
  if(var_1 _meth_8703(var_0)) {
    return 1;
  } else if(scripts\mp\utility\game::getgametype() != "br") {
    if(!scripts\cp_mp\vehicles\vehicle::_id_10122(var_0, var_1)) {
      return 1;
    }
  } else if(var_1 scripts\mp\utility\perk::_hasperk("specialty_tactical_recon")) {
    if(!scripts\cp_mp\vehicles\vehicle::_id_10126(var_0, var_1)) {
      return 1;
    }
  }

  return undefined;
}