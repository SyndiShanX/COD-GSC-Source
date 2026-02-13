/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1814.gsc
*************************************************/

_id_8125() {
  _id_7F73(["money_earned"]);
  _id_7F6E(["money_earned"]);
  _id_D26D();
  _id_D26C();
}

_id_D26D() {
  level._id_42A1 = 1;
}

_id_D26C() {
  level._id_5301 = ::_id_11083;
}

_id_7F73(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "damage":
        _id_072C::_id_C1E1("damage", 29);
        break;
      case "money_earned":
        _id_072C::_id_C1E1("money_earned", 30);
        break;
      case "tickets_earned":
        _id_072C::_id_C1E1("tickets_earned", 31);
        break;
      case "consumables_earned":
        _id_072C::_id_C1E1("consumables_earned", 32);
        break;
      default:
    }
  }
}

_id_7F6E(var_0) {
  level._id_5279 = [];

  foreach(var_2 in var_0) {
    switch (var_2) {
      case "damage":
        _id_7F4F();
        break;
      case "money_earned":
        _id_8003();
        break;
      case "tickets_earned":
        _id_80D5();
        break;
      case "consumables_earned":
        _id_7F31();
        break;
      default:
    }
  }
}

_id_7F4F() {
  _id_072C::_id_C1DF("damage", ::_id_7F4E, ::_id_C5EE, ::_id_C5D4, ::_id_2ECE, 29, "damage");
}

_id_8003() {
  _id_072C::_id_C1DF("money_earned", ::_id_8002, ::_id_C5EF, ::_id_C5D7, ::_id_2ED3, 30, "money_earned");
}

_id_80D5() {
  _id_072C::_id_C1DF("tickets_earned", ::_id_80D4, ::_id_C5F1, ::_id_C5D9, ::_id_2ED8, 31, "tickets_earned");
}

_id_7F31() {
  _id_072C::_id_C1DF("consumables_earned", ::_id_7F30, ::_id_C5ED, ::_id_C5D3, ::_id_2ECD, 32, "consumables_earned");
}

_id_7F30(var_0) {
  return var_0;
}

_id_C5ED(var_0) {
  return var_0;
}

_id_C5D3(var_0) {
  var_0._id_5278["total_consumables_earned"] = 0;
}

_id_2ECD(var_0, var_1) {
  var_2 = _id_072C::_id_666F(var_0, "total_consumables_earned");
  var_3 = min(50000, var_2 * 10000);
  return int(var_3);
}

_id_80D4(var_0) {
  return var_0;
}

_id_C5F1(var_0) {
  return var_0;
}

_id_C5D9(var_0) {
  var_0._id_5278["total_tickets_earned"] = 0;
}

_id_2ED8(var_0, var_1) {
  var_2 = _id_072C::_id_666F(var_0, "total_tickets_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

_id_8002(var_0) {
  return var_0;
}

_id_C5EF(var_0) {
  return var_0;
}

_id_C5D7(var_0) {
  var_0._id_5278["total_money_earned"] = 0;
}

_id_2ED3(var_0, var_1) {
  var_2 = _id_072C::_id_666F(var_0, "total_money_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

_id_7F4E(var_0) {
  return var_0;
}

_id_C5EE(var_0) {
  return var_0;
}

_id_C5D4(var_0) {
  var_0._id_5278["damage_done_on_agent"] = 0;
}

_id_2ECE(var_0, var_1) {
  var_2 = _id_072C::_id_666F(var_0, "damage_done_on_agent");
  var_3 = min(999999, var_2 * 0.2);
  return int(var_3);
}

_id_FB35(var_0, var_1, var_2) {
  if(var_2 == "MOD_TRIGGER_HURT") {
    return;
  }
  var_3 = scripts\cp\utility::_id_6376(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 _id_072C::_id_FBA7("damage", "damage_done_on_agent", var_1);
}

_id_FB89(var_0, var_1) {
  var_0 _id_072C::_id_FBA7("money_earned", "total_money_earned", var_1);
}

_id_FBDC(var_0, var_1) {
  var_0 _id_072C::_id_FBA7("tickets_earned", "total_tickets_earned", var_1);
}

_id_11083(var_0) {
  _id_072C::_id_2ED0(level.players, ["money_earned"], var_0);
}