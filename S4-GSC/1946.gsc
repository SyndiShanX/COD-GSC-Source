/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1946.gsc
*************************************************/

_id_BAEC() {
  var_0 = spawnStruct();
  level._id_BAAC = var_0;
  var_0._id_AA40 = ["primary", "secondary"];
  var_0._id_AA40["primary"][0] = "ui_power_num_charges";
  var_0._id_AA40["primary"][1] = "ui_power_max_charges";
  var_0._id_AA40["primary"][2] = "ui_power_recharge";
  var_0._id_AA40["primary"][3] = "ui_power_id";
  var_0._id_AA40["primary"][4] = "ui_power_consume";
  var_0._id_AA40["primary"][5] = "ui_power_disabled";
  var_0._id_AA40["primary"][6] = "ui_power_state";
  var_0._id_AA40["secondary"][0] = "ui_power_secondary_num_charges";
  var_0._id_AA40["secondary"][1] = "ui_power_secondary_max_charges";
  var_0._id_AA40["secondary"][2] = "ui_power_secondary_recharge";
  var_0._id_AA40["secondary"][3] = "ui_power_id_secondary";
  var_0._id_AA40["secondary"][4] = "ui_power_secondary_consume";
  var_0._id_AA40["secondary"][5] = "ui_power_secondary_disabled";
  var_0._id_AA40["secondary"][6] = "ui_power_secondary_state";
}

_id_BAE5(var_0, var_1, var_2, var_3) {
  if(var_0 == "scripted") {
    return;
  }
  self setclientomnvar(_id_BAEB(var_0, 3), var_1);
  var_4 = scripts\engine\utility::ter_op(var_2, 1000, 0);
  self setclientomnvar(_id_BAEB(var_0, 2), var_4);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self setclientomnvar(_id_BAEB(var_0, 0), var_3);
  self setclientomnvar(_id_BAEB(var_0, 4), 0);
}

_id_BAE8(var_0) {
  if(var_0 == "scripted") {
    return;
  }
  self setclientomnvar(_id_BAEB(var_0, 3), -1);
  self setclientomnvar(_id_BAEB(var_0, 2), -1);
  self setclientomnvar(_id_BAEB(var_0, 0), 0);
  self setclientomnvar(_id_BAEB(var_0, 4), -1);
}

_id_BAED(var_0, var_1) {
  self setclientomnvar(_id_BAEB(var_0, 0), int(var_1));
}

_id_BAF3(var_0, var_1) {
  self setclientomnvar(_id_BAEB(var_0, 1), int(var_1));
}

_id_BAF1(var_0, var_1) {
  self setclientomnvar(_id_BAEB(var_0, 4), var_1);
}

_id_BAF4(var_0, var_1) {
  self setclientomnvar(_id_BAEB(var_0, 2), int(var_1));
}

_id_BAF0(var_0, var_1) {
  self setclientomnvar(_id_BAEB(var_0, 5), var_1);
}

_id_BAF5(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1, 1, 0);
  self setclientomnvar(_id_BAEB(var_0, 6), var_2);
}

_id_BAF6(var_0, var_1) {
  self setclientomnvar(_id_BAEB(var_0, 6), var_1);
}

_id_BAE7(var_0) {
  _id_BAF1(var_0, 1);
}

_id_BAE9(var_0) {
  _id_BAF1(var_0, 0);
}

_id_BAE6(var_0, var_1) {
  _id_BAF4(var_0, 0);

  if(isDefined(var_1) && var_1) {
    _id_BAF0(var_0, 1);
  }

  _id_BAF6(var_0, 1);
}

_id_BAEA(var_0, var_1) {
  _id_BAF4(var_0, 1000);

  if(isDefined(var_1) && var_1) {
    _id_BAF0(var_0, 0);
  }

  if(var_0 == "primary") {
    self playlocalsound("iw8_new_objective_sfx");
  } else {
    self playlocalsound("iw8_new_objective_sfx");
  }

  _id_BAF6(var_0, 0);
}

_id_BAEF(var_0, var_1) {
  _id_BAF4(var_0, 1000 * var_1);
}

_id_BAF2(var_0, var_1) {
  _id_BAF4(var_0, 1000 * var_1);
}

_id_BAEB(var_0, var_1) {
  if(var_0 == "scripted") {
    return;
  }
  return level._id_BAAC._id_AA40[var_0][var_1];
}