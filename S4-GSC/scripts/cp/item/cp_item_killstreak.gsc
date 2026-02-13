/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\item\cp_item_killstreak.gsc
**************************************************/

init() {
  _id_092E::_id_C1F0("killstreak", ::pickup_killstreak);
}

pickup_killstreak(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2._id_C558), var_2._id_C558, var_2.origin);
  var_5 = var_4 - var_0.origin;
  var_6 = _func_0261(var_5);
  var_7 = (0, var_6, 0);
  var_0 scripts\cp\cp_killstreaks::grant_killstreak(var_2.streak_name, var_4, var_7, undefined, var_2._id_AE4A);
  var_0 playsoundtoplayer("zmb_pickup_weapon", var_0);
}