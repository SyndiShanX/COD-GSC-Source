/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_keypad_util.gsc
***********************************************/

removedeathicon() {
  return _id_126D6("_encstr_96350F13D37FB458E2F16ACDBE8BBE047B", 0, 2);
}

removealldeathicons() {
  return _id_126D6("_encstr_96350F13D37FB458E2F16ACDBE8BBE047B", 2, 4);
}

_id_12685(var_0) {
  _id_12688(0, var_0);
}

_id_12683(var_0) {
  _id_12688(1, var_0);
}

_id_12684(var_0) {
  var_1 = setteamplacement(var_0, "_encstr_87070365F7");
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_4] = var_0[var_4];

  var_6 = "_encstr_B40101";

  foreach(var_8 in var_2) {
    var_9 = "_encstr_B40101" + var_8;

    if(!_id_13925(var_6, var_9))
      var_6 = var_6 + var_9;
  }

  var_11 = int(var_6);
  _id_12688(2, var_11);
}

_id_13925(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 1;
  }

  return 0;
}

_id_12688(var_0, var_1) {
  [var_3, var_4, var_5, var_1] = removechevronsfromarray(var_0, var_1);

  if(var_5 == "_encstr_B40101") {
    return;
  }
  _id_12610(var_5, var_1, var_3, var_4);
}

removechevronsfromarray(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "_encstr_B40101";

  switch (var_0) {
    case 0:
      [var_2, var_3] = [0, 2];
      var_4 = "_encstr_96350F13D37FB458E2F16ACDBE8BBE047B";
      break;
    case 1:
      [var_2, var_3] = [2, 4];
      var_4 = "_encstr_96350F13D37FB458E2F16ACDBE8BBE047B";
      break;
    case 2:
      [var_2, var_3] = [6, 16];
      var_4 = "_encstr_96350F13D37FB458E2F16ACDBE8BBE047B";
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

_id_12610(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7)
    self setclientomnvar(var_0, var_9);
}

_id_126D6(var_0, var_1, var_2) {
  var_3 = self calloutmarkerping_entityzoffset(var_0);
  var_4 = (1 << var_2) - 1;
  var_5 = var_3 >> var_1;
  var_6 = var_4 &var_5;
  return var_6;
}