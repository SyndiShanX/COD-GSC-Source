/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1833.gsc
*************************************************/

main() {
  level._id_55B0 = 0;
  level._id_55AF = 0;
  level._id_9E9E = getdvarint("#x3c3dad862f4bb63c4", 0);
}

_id_55B1(var_0) {
  return clamp(var_0, _id_65A5(), _id_658D());
}

_id_7DD7() {
  level._id_55B0 = int(_id_55B1(level._id_55B0 + 1));
}

_id_454F() {
  level._id_55B0 = int(_id_55B1(level._id_55B0 - 1));
}

_id_D3E8() {
  level._id_55B0 = int(_id_55B1(_id_658D()));
}

_id_D3E9() {
  level._id_55B0 = int(_id_55B1(_id_65A5()));
}

_id_658D() {
  return getdvarint("#x32e74521e806c49e", 5);
}

_id_658C() {
  return getdvarint("#x3ad73aaedcb725c91", 10);
}

_id_658B() {
  return getdvarint("#x3c6f5d35b6f8ef409", 1);
}

_id_65A5() {
  var_0 = getdvarint("#x3c3dad862f4bb63c4", 0);

  if(level._id_9E9E != var_0) {
    var_0 = level._id_9E9E;
  }

  return var_0;
}

_id_6487() {
  return level._id_55AF;
}

_id_7DB9(var_0) {
  level._id_9E9E = _id_55B1(var_0);
}

_id_7DB6() {
  var_0 = level._id_55AF + 0.1;
  level._id_55AF = _id_55B1(var_0);

  if(int(level._id_55AF) > level._id_55B0) {
    _id_7DD7();
  }
}

_id_4543() {
  var_0 = level._id_55AF - 0.1;
  level._id_55AF = _id_55B1(var_0);

  if(int(level._id_55AF) < level._id_55B0) {
    _id_454F();
  }
}

_id_73F3() {
  level endon("game_ended");
  level notify("handle_escalation_on_death");
  level endon("handle_escalation_on_death");
  _id_7DB6();
  wait(_id_658C());

  while(_id_6487() > 0) {
    _id_4543();
    wait(_id_658B());
  }
}