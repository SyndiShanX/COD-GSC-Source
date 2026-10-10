/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_keypad_util.gsc
******************************************************/

#namespace br_keypad_util;

function getkeypadstatefromomnvar() {
  return playerunpackdatafromomnvar("ui_keypad_data", 0, 2);
}

function getkeypadcodelengthfromomnvar() {
  return playerunpackdatafromomnvar("ui_keypad_data", 2, 4);
}

function playersetkeypadstateindex(stateindex) {
  playersetomnvarkeypad(0, stateindex);
}

function playersetkeypadcodelengthindex(codelengthindex) {
  playersetomnvarkeypad(1, codelengthindex);
}

function function_b899a0471538d3d4(var_62a655cbda625e8d) {
  playersetomnvarkeypad(2, var_62a655cbda625e8d);
}

function function_da718c8ec624b4da(objid) {
  if(!isDefined(objid)) {
    objid = 15;
  } else if(objid > 14) {
    assertmsg("<dev string:x1c>" + objid + "<dev string:x54>");
    return;
  }

  playersetomnvarkeypad(3, objid);
}

function function_5392765d56bf59ea(attemptsremaining) {
  if(!isDefined(attemptsremaining)) {
    attemptsremaining = 3;
  } else if(attemptsremaining > 14) {
    assertmsg("<dev string:x89>" + attemptsremaining + "<dev string:xd3>");
    return;
  }

  playersetomnvarkeypad(4, attemptsremaining);
}

function function_b751dd55c6c31d6d(var_6f6d810585c7349b, var_fa0f2d5aeb7a3af9, objid) {
  var_2e3292ed32077253 = 0;

  if(!isDefined(objid)) {
    objid = 15;
  } else if(objid >= 15) {
    assertmsg("<dev string:x114>" + objid + "<dev string:x14c>" + 15 + "<dev string:x180>");
    return;
  }

  shift = 0;
  var_2e3292ed32077253 |= objid << shift;
  i = 0;

  foreach(digit in var_6f6d810585c7349b) {
    shift = i * 4 + 4;

    if(i < var_fa0f2d5aeb7a3af9) {
      var_2e3292ed32077253 |= digit << shift;
    } else {
      var_2e3292ed32077253 |= 10 << shift;
    }

    i++;
  }

  while(i < 4) {
    shift = i * 4 + 4;
    var_2e3292ed32077253 |= 15 << shift;
    i++;
  }

  self setclientomnvar("ui_vault_code_known_digits", int(var_2e3292ed32077253));
}

function playersetomnvarkeypad(dataref, value) {
  assert(isPlayer(self));
  [bitoffset, bitwidth, var_8e90fa6d5789ad63, value] = getkeypadomnvarbitpackinginfo(dataref, value);

  if(var_8e90fa6d5789ad63 == "") {
    return;
  }

  playerpackdataintoomnvar(var_8e90fa6d5789ad63, value, bitoffset, bitwidth);
}

function getkeypadomnvarbitpackinginfo(dataref, value) {
  bitoffset = 0;
  bitwidth = 0;
  var_8e90fa6d5789ad63 = "";

  switch (dataref) {
    case 0:
      [bitoffset, bitwidth] = [0, 2];
      var_8e90fa6d5789ad63 = "ui_keypad_data";
      break;
    case 1:
      [bitoffset, bitwidth] = [2, 4];
      var_8e90fa6d5789ad63 = "ui_keypad_data";
      break;
    case 2:
      [bitoffset, bitwidth] = [6, 4];
      var_8e90fa6d5789ad63 = "ui_keypad_data";
      break;
    case 3:
      [bitoffset, bitwidth] = [10, 8];
      var_8e90fa6d5789ad63 = "ui_keypad_data";
      break;
    case 4:
      [bitoffset, bitwidth] = [18, 4];
      var_8e90fa6d5789ad63 = "ui_keypad_data";
      break;
    default:
      assertmsg("<dev string:x185>" + dataref + "<dev string:x19e>");
      break;
  }

  return [bitoffset, bitwidth, var_8e90fa6d5789ad63, value];
}

function playerpackdataintoomnvar(var_8e90fa6d5789ad63, value, bitoffset, bitwidth) {
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (value &mask) << bitoffset;
  var_f8f977081d3da8b4 = ~(mask << bitoffset);
  prevvalue = self getclientomnvar(var_8e90fa6d5789ad63);
  cleanedbase = prevvalue &var_f8f977081d3da8b4;
  var_82a90e56e416fa55 = cleanedbase + var_a463992091f1d483;

  if(var_82a90e56e416fa55 != prevvalue) {
    self setclientomnvar(var_8e90fa6d5789ad63, var_82a90e56e416fa55);
  }
}

function playerunpackdatafromomnvar(var_8e90fa6d5789ad63, var_c20319aa0598dc14, var_7214adeafee0fc1b) {
  prevvalue = self getclientomnvar(var_8e90fa6d5789ad63);
  var_81829a47d6020a = (1 << var_7214adeafee0fc1b) - 1;
  bitarray = prevvalue >> var_c20319aa0598dc14;
  var_f94e3b11a17a0398 = var_81829a47d6020a &bitarray;
  return var_f94e3b11a17a0398;
}