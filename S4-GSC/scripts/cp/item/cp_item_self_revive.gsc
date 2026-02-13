/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\item\cp_item_self_revive.gsc
***************************************************/

init() {
  _id_092E::_id_C1F0("self_revive", ::pickup_self_revive, ::can_pickup_self_revive);
}

pickup_self_revive(var_0, var_1, var_2, var_3) {
  var_0 _id_0981::_id_6ED6("self_revive", 0);
  var_0 playsoundtoplayer("zmb_pickup_health_regen", var_0);
  var_4 = "cploot";

  if(isDefined(var_1._id_CF0C)) {
    var_5 = strtok(var_1._id_CF0C, "_");

    if(var_5.size > 0) {
      var_4 = var_5[0];
    }
  }

  scripts\cp\telemetry_cp::logevent_supportacquired(var_0, var_1._id_CF0C, var_4);
}

can_pickup_self_revive(var_0, var_1, var_2, var_3) {
  return !var_0 scripts\cp\utility::_id_8580("self_revive");
}