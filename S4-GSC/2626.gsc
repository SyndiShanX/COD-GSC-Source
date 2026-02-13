/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2626.gsc
*************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "getSelectMapPoint", ::_id_5182);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "startMapSelectSequence", ::_id_5184);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "monitorDamage", ::_id_5183);
}

_id_5182(var_0, var_1, var_2) {
  return _id_0A54::_id_6D1F(var_0, var_1, var_2);
}

_id_5184(var_0, var_1, var_2, var_3) {
  _id_0A54::_id_E6E4(var_0, var_1, var_2, var_3);
}

_id_5183(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_07C3::_id_A0FF(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}