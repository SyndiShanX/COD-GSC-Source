/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_events.gsc
*************************************************/

_id_2BB3() {
  var_0 = getdvarint("#x3329de69d4dbc1313", 0);

  if(!var_0) {
    return;
  }
  if(var_0 & 1) {
    thread _id_2BAB();
  }

  if(var_0 & 2) {
    thread _id_2BAE();
  }

  if(var_0 & 4) {
    thread _id_2BAF();
  }

  if(var_0 & 8) {
    thread _id_2BB0();
  }
}

_id_2BB2(var_0) {
  var_1 = self _meth_876E("ui_br_events");
  self setclientomnvar("ui_br_events", var_1 | var_0);
}

_id_2BB1(var_0) {
  var_1 = self _meth_876E("ui_br_events");
  self setclientomnvar("ui_br_events", var_1 &~var_0);
}

_id_2BAB() {
  if(scripts\mp\gametypes\br_public::_id_8758()) {
    return;
  }
  var_0 = getdvarfloat("#x3cd1f6d8aa2f28e5a", 0.04);

  if(var_0 <= randomfloat(1.0)) {
    return;
  }
  _id_07D1::_id_60C2("prematch_done");
  var_1 = getdvarfloat("#x3e958c20590f2a145", 180);
  var_2 = getdvarfloat("#x3e97bcc059118fefb", 300);
  var_3 = randomfloat(var_2 - var_1) + var_1;
  wait(var_3);

  if(scripts\mp\utility\game::_id_6D9E() == "dmz" || !isDefined(level._id_2A1B._id_372F) || level._id_2A1B._id_372F < 0) {
    var_4 = level._id_2A73._id_2A7A;
    var_5 = level._id_2A73._id_2A7B[0] * getdvarfloat("#x3132665b6b8c117d4", 0.5);
  } else {
    var_4 = level._id_2A73._id_2A1F[level._id_2A1B._id_372F];
    var_5 = level._id_2A73._id_2A25[level._id_2A1B._id_372F] * getdvarfloat("#x3132665b6b8c117d4", 1.0);
  }

  var_6 = getdvarint("#x3d968d13e3ce4afc9", 18000);
  var_4 = (var_4[0], var_4[1], var_6);
  var_7 = scripts\mp\gametypes\br_circle::_id_6CC7(var_4, var_5, 0.0, 1.0, 0, 0);
  var_8 = (0, randomfloat(360.0), 0);
  var_9 = anglesToForward(var_8);
  var_10 = getdvarfloat("#x3ad03ad5f94c3e760", 2.0);
  var_11 = level._id_2A73._id_2A7B[0] * var_10;
  var_12 = var_7 - var_9 * var_11;
  var_13 = var_7 + var_9 * var_11;
  var_14 = spawn("script_model", var_12);
  var_14 setModel("x1_u2_plane");
  var_14.angles = var_8;
  var_15 = distance(var_12, var_13);
  var_16 = getdvarint("#x325a098b6ba0cd745", 8800);
  var_17 = var_15 / var_16;
  var_18 = getdvarfloat("#x3aac5b2d432f67fc8", 2.0);
  var_19 = anglestoright(var_8);

  foreach(var_21 in level.players) {
    if(!_id_2BAD(var_21)) {
      continue;
    }
    var_22 = distance2d(var_14.origin, var_21.origin);
    var_3 = var_22 / var_16;
    var_21 thread _id_2BAC(var_3, var_18);
  }

  var_14 moveto(var_13, var_17);
  wait(var_17);
  var_14 delete();
}

_id_2BAD(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_2A63) || !isalive(var_0) || istrue(var_0._id_7262)) {
    return 0;
  }

  return 1;
}

_id_2BAC(var_0, var_1) {
  self endon("death_or_disconnect");
  wait(var_0);

  if(!_id_2BAD(self)) {
    return;
  }
  _id_2BB2(1);
  self setclientomnvar("ui_br_bink_overlay_state", 8);
  wait(var_1);
  _id_2BB1(1);
  self setclientomnvar("ui_br_bink_overlay_state", 0);
}

_id_2BAE() {}

_id_2BAF() {}

_id_2BB0() {}