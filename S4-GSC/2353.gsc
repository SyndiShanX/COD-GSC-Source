/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2353.gsc
*************************************************/

init() {
  _id_092E::_id_C1F0("salvage", ::_id_B07F);
}

_id_B07F(var_0, var_1, var_2, var_3) {
  if(var_0 scripts\cp\utility::_hasperk("specialty_scrapper")) {
    var_0 playsoundtoplayer("zmb_pickup_scrapper", var_0);
  } else {
    var_0 playsoundtoplayer("zmb_pickup_salvage", var_0);
  }

  var_4 = scripts\cp\utility::_id_459B(level.salvage_pickup_amount, 50);
  var_5 = int(var_4 * var_0 _id_0945::_id_664E("salvage_pickup_increase"));
  var_0 _id_092E::show_pickup_notification(1, var_5, 0);
  var_0 _id_075A::_id_6FCE(var_5, var_2._id_332F);
}