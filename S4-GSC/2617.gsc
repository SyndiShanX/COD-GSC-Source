/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2617.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("chopper_support", _id_09AE::_id_F772);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", ::_id_365F);
}

_id_365F(var_0, var_1) {
  _id_0AAF::_id_D42B(var_0, var_1);
}