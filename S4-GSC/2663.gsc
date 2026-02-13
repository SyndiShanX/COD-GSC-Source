/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2663.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("white_phosphorus", _id_09B2::_id_F7A9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "startMapSelectSequence", ::_id_10E0C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getSelectMapPoint", ::_id_10E0B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "monitorDamage", _id_07C3::_id_A0FF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "codcasterAddPhosphorousStatusEffect", ::codcaster_add_phosphorous_status_effect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "codcasterRemovePhosphorousStatusEffect", ::codcaster_remove_phosphorous_status_effect);
}

_id_10E0C(var_0, var_1, var_2, var_3) {
  _id_0A54::_id_E6E4(var_0, var_1, var_2);
}

_id_10E0B(var_0, var_1, var_2) {
  return _id_0A54::_id_6D1F(var_0, var_1, var_2);
}

codcaster_add_phosphorous_status_effect() {
  scripts\mp\utility\player::_id_3A20("phosphorous", -1);
}

codcaster_remove_phosphorous_status_effect() {
  scripts\mp\utility\player::_id_3A20("phosphorous", 0);
}