/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\item\cp_item_armor.gsc
*************************************************/

init() {
  _id_092E::_id_C1F0("armor", ::pickup_armor, ::can_pickup_armor);
  _id_092E::_id_C1F0("armor_shard", ::pickup_shard, ::can_pickup_shard, undefined, ::can_drop_shard);
}

can_pickup_armor(var_0, var_1, var_2, var_3) {
  return var_0._id_1B3D == 0 || !_id_0707::_id_B4C7(var_0);
}

pickup_armor(var_0, var_1, var_2, var_3) {
  if(var_0._id_1B3D == 0) {
    var_0 _id_0707::_id_6ECA(var_0, 1);
  } else {
    var_0 _id_0707::_id_6ECA(var_0, var_0._id_1B3D);
  }

  var_0 _id_092E::show_pickup_notification(4, 0, 0);
  var_0 playsoundtoplayer("zmb_pickup_armor", var_0);
  var_4 = "cploot";

  if(isDefined(var_1._id_CF0C)) {
    var_5 = strtok(var_1._id_CF0C, "_");

    if(var_5.size > 0) {
      var_4 = var_5[0];
    }
  }

  scripts\cp\telemetry_cp::logevent_armoracquired(var_0, var_1._id_CF0C, var_0._id_1B3D, var_4);
}

can_pickup_shard(var_0, var_1, var_2, var_3) {
  return var_0._id_1B3D > 0 && !var_0 _id_0707::_id_B4C7(var_0);
}

pickup_shard(var_0, var_1, var_2, var_3) {
  var_4 = var_0._id_1B26 + 200;
  var_0 _id_0707::_id_D161(var_0, var_4);
  var_0 _id_092E::show_pickup_notification(4, 0, 0);
  var_0 playsoundtoplayer("zmb_pickup_armor_shard", var_0);
}

can_drop_shard(var_0) {
  foreach(var_2 in level.players) {
    if(var_2._id_1B3D > 0) {
      return 1;
    }
  }

  return 0;
}