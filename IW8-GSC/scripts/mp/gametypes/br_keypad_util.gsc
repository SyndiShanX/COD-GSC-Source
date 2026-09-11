/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_keypad_util.gsc
***************************************************/

function removedeathicon() {
  return ref_126d6("ui_keypad_data", 0, 2);
}

function removealldeathicons() {
  return ref_126d6("ui_keypad_data", 2, 4);
}

function ref_12685(var0) {
  ref_12688(0, var0);
}

function ref_12683(var0) {
  ref_12688(1, var0);
}

function ref_12684(var0) {
  var1 = setteamplacement(var0, "up");
  var2 = [];

  foreach(var4 in var1) {
    var2 = var0[var4];
  }

  var6 = "";

  foreach(var8 in var2) {
    var9 = "" + var8;

    if(!ref_13925(var6, var9)) {
      var6 += var9;
    }
  }

  var11 = int(var6);
  ref_12688(2, var11);
}

function ref_13925(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    if(var0[var2] == var1) {
      return true;
    }
  }

  return false;
}

function ref_12688(var0, var1) {
  var2 = removechevronsfromarray(var0, var1);
  var3 = var2[0];
  var4 = var2[1];
  var5 = var2[2];
  var1 = var2[3];
  var2 = undefined;

  if(var5 == "") {
    return;
  }

  ref_12610(var5, var1, var3, var4);
}

function removechevronsfromarray(var0, var1) {
  var2 = 0;
  var3 = 0;
  var4 = "";

  switch (var0) {
    case 0:
      var5 = [0, 2];
      var2 = var5[0];
      var3 = var5[1];
      var5 = undefined;
      var4 = "ui_keypad_data";
      break;
    case 1:
      var6 = [2, 4];
      var2 = var6[0];
      var3 = var6[1];
      var6 = undefined;
      var4 = "ui_keypad_data";
      break;
    case 2:
      var7 = [6, 16];
      var2 = var7[0];
      var3 = var7[1];
      var7 = undefined;
      var4 = "ui_keypad_data";
      break;
    default:
      break;
  }

  return [var2, var3, var4, var1];
}

function ref_12610(var0, var1, var2, var3) {
  var4 = int(pow(2, var3)) - 1;
  var5 = (var1 &var4) << var2;
  var6 = ~(var4 << var2);
  var7 = self calloutmarkerping_entityzoffset(var0);
  var8 = var7 &var6;
  var9 = var8 + var5;

  if(var9 != var7) {
    self setclientomnvar(var0, var9);
    return;
  }
}

function ref_126d6(var0, var1, var2) {
  var3 = self calloutmarkerping_entityzoffset(var0);
  var4 = (1 << var2) - 1;
  var5 = var3 >> var1;
  var6 = var4 &var5;
  return var6;
}