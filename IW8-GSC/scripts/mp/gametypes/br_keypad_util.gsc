/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_keypad_util.gsc
***************************************************/

function removedeathicon() {
  return ref_126D6("ui_keypad_data", 0, 2);
}

function removealldeathicons() {
  return ref_126D6("ui_keypad_data", 2, 4);
}

function ref_12685(var_0) {
  ref_12688(0, var_0);
}

function ref_12683(var_0) {
  ref_12688(1, var_0);
}

function ref_12684(var_0) {
  var_1 = setteamplacement(var_0, "up");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2 = var_0[var_4];
  }

  var_6 = "";

  foreach(var_8 in var_2) {
    var_9 = "" + var_8;

    if(!ref_13925(var_6, var_9)) {
      var_6 += var_9;
    }
  }

  var_11 = int(var_6);
  ref_12688(2, var_11);
}

function ref_13925(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return true;
    }
  }

  return false;
}

function ref_12688(var_0, var_1) {
  var_2 = removechevronsfromarray(var_0, var_1);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_1 = var_2[3];
  var_2 = undefined;

  if(var_5 == "") {
    return;
  }

  ref_12610(var_5, var_1, var_3, var_4);
}

function removechevronsfromarray(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  switch (var_0) {
    case 0:
      var_5 = [0, 2];
      var_2 = var_5[0];
      var_3 = var_5[1];
      var_5 = undefined;
      var_4 = "ui_keypad_data";
      break;
    case 1:
      var_6 = [2, 4];
      var_2 = var_6[0];
      var_3 = var_6[1];
      var_6 = undefined;
      var_4 = "ui_keypad_data";
      break;
    case 2:
      var_7 = [6, 16];
      var_2 = var_7[0];
      var_3 = var_7[1];
      var_7 = undefined;
      var_4 = "ui_keypad_data";
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

function ref_12610(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7) {
    self setclientomnvar(var_0, var_9);
    return;
  }
}

function ref_126D6(var_0, var_1, var_2) {
  var_3 = self calloutmarkerping_entityzoffset(var_0);
  var_4 = (1 << var_2) - 1;
  var_5 = var_3 >> var_1;
  var_6 = var_4 &var_5;
  return var_6;
}