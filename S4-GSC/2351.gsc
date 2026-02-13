/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2351.gsc
*************************************************/

init() {
  _id_092E::_id_C1F0("ammo", ::_id_B079, ::_id_30D7);
}

_id_30D7(var_0, var_1, var_2, var_3) {
  var_4 = var_0 getweaponslistprimaries();

  foreach(var_6 in var_4) {
    var_7 = var_6.basename;

    if(scripts\cp\utility::_id_8632(var_7) || scripts\cp\utility::_id_88F6(var_7)) {
      continue;
    }
    if(var_0 getweaponammostock(var_6) < var_6._id_0298) {
      return 1;
    }
  }

  return 0;
}

_id_B079(var_0, var_1, var_2, var_3) {
  var_0 playsoundtoplayer("zmb_pickup_ammo", var_0);
  var_4 = var_0 getweaponslistprimaries();

  foreach(var_6 in var_4) {
    if(var_6._id_0241 == "primary" && !scripts\cp\utility::_id_88F6(var_6.basename)) {
      if(isDefined(var_6.basename) && scripts\engine\utility::is_equal(var_6.basename, "s4_pi_raygun_mp")) {
        var_7 = var_6._id_0298 * 0.2;
      } else {
        var_7 = var_6._id_0298 * 0.2;
      }

      var_8 = var_0 getweaponammostock(var_6) + var_7;
      var_8 = int(min(var_8, var_6._id_0298));
      var_0 setweaponammostock(var_6, var_8);
      var_0 _id_092E::show_pickup_notification(0, 0, 0);
    }
  }
}