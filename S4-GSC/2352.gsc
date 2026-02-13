/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2352.gsc
*************************************************/

init() {
  _id_092E::_id_C1F0("lethal", ::_id_B07B, ::_id_30D9, ::should_auto_pickup);
  _id_092E::_id_C1F0("tactical", ::_id_B07B, ::_id_30D9, ::should_auto_pickup);
}

_id_B07B(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.pickup_sound) && _func_0205(var_1.pickup_sound)) {
    var_0 playsoundtoplayer(var_1.pickup_sound, var_0);
  } else {
    var_0 playsoundtoplayer("zmb_pickup_weapon", var_0);
  }

  if(!var_3 && !istrue(level.disable_pickup_item_vo)) {
    var_0 _id_0720::_id_BEC0("pickup_item");
  }

  var_4 = _func_0222("cp/equipment.csv", 1, var_1._id_22AC, 0);
  var_0 _id_092E::show_pickup_notification(3, 0, int(var_4));
  var_5 = spawnStruct();
  var_5._id_5556 = var_1._id_22AC;
  var_5._id_C559 = var_1._id_CF0C;
  var_5._id_C558 = scripts\engine\utility::ter_op(isDefined(var_2._id_C558), var_2._id_C558, var_2.origin);
  var_5._id_BE99 = var_2._id_BE99;
  var_5.motherlode_quantity = var_2.motherlode_quantity;
  var_0 _id_0728::giveequipment(var_5);
  var_6 = "cploot";

  if(isDefined(var_1._id_CF0C)) {
    var_7 = strtok(var_1._id_CF0C, "_");

    if(var_7.size > 0) {
      var_6 = var_7[0];
    }
  }

  scripts\cp\telemetry_cp::logevent_equipmentacquired(var_0, var_5._id_5556, var_6);
}

_id_6D2F(var_0) {
  switch (var_0) {
    case "lethal":
      return "primary";
    case "tactical":
      return "secondary";
  }

  return undefined;
}

_id_5B05(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;

    if(isweapon(var_0)) {
      var_1 = var_0.basename;
    }

    foreach(var_4, var_3 in level._id_3E13._id_4355) {
      if(var_3._id_22AC == var_1) {
        return var_4;
      }
    }
  }

  return undefined;
}

_id_E35C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_1 - var_2;
  var_9 = _func_0261(var_8);
  var_10 = (0, var_9, 0);
  var_11 = _id_092E::_id_E178(var_0, var_1, var_10, var_5, var_6, var_7);
  var_11.motherlode_quantity = var_4;
  var_11._id_BE99 = var_3;
  return var_11;
}

_id_30D9(var_0, var_1, var_2) {
  if(var_0 _meth_81EF()) {
    return 0;
  }

  var_3 = _id_6D2F(var_1._id_8B2D);
  var_4 = var_0 _id_0728::_id_69A4(var_3);

  if(!isDefined(var_4)) {
    return 1;
  }

  if(var_4 == var_1._id_22AC) {
    var_5 = var_0 _id_0728::_id_6A0F(var_4);
    var_6 = var_0 _id_0728::_id_6A12(var_4);
    return var_5 < var_6;
  }

  return 1;
}

should_auto_pickup(var_0, var_1, var_2) {
  return var_0 _id_0728::_id_755B(var_1._id_22AC);
}