/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2659.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("toma_strike", _id_09AB::_id_F76A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "monitorDamage", ::_id_F2FD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "molotov_branch_draw_hits", ::_id_F2FC);
}

_id_F2FD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_07C3::_id_A0FF(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_F2FC() {}