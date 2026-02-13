/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2084.gsc
*************************************************/

_id_6E12(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_C98F[var_1]._id_5095;
      break;
    case "game":
      var_2 = level._id_60EF[var_1]._id_5095;
      break;
    case "team":
      var_2 = level._id_EFB5[var_1]._id_5095;
      break;
    case "player":
      var_2 = level._id_B806[var_1]._id_5095;
      break;
    case "class":
      var_2 = level._id_380B[var_1]._id_5095;
      break;
    case "weapon":
      var_2 = level._id_10DE6[var_1]._id_5095;
      break;
    case "hardpoint":
      var_2 = level._id_74CA[var_1]._id_5095;
      break;
    case "hud":
      var_2 = level._id_7B96[var_1]._id_5095;
      break;
    default:
      var_2 = undefined;
      break;
  }

  var_3 = getdvarint(var_2);
  return var_3;
}

_id_6E11(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_C98F[var_1]._id_5095;
      break;
    case "game":
      var_2 = level._id_60EF[var_1]._id_5095;
      break;
    case "team":
      var_2 = level._id_EFB5[var_1]._id_5095;
      break;
    case "player":
      var_2 = level._id_B806[var_1]._id_5095;
      break;
    case "class":
      var_2 = level._id_380B[var_1]._id_5095;
      break;
    case "weapon":
      var_2 = level._id_10DE6[var_1]._id_5095;
      break;
    case "hardpoint":
      var_2 = level._id_74CA[var_1]._id_5095;
      break;
    case "hud":
      var_2 = level._id_7B96[var_1]._id_5095;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

_id_6E14(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_C98F[var_1]._id_04CB;
      break;
    case "game":
      var_2 = level._id_60EF[var_1]._id_04CB;
      break;
    case "team":
      var_2 = level._id_EFB5[var_1]._id_04CB;
      break;
    case "player":
      var_2 = level._id_B806[var_1]._id_04CB;
      break;
    case "class":
      var_2 = level._id_380B[var_1]._id_04CB;
      break;
    case "weapon":
      var_2 = level._id_10DE6[var_1]._id_04CB;
      break;
    case "hardpoint":
      var_2 = level._id_74CA[var_1]._id_04CB;
      break;
    case "hud":
      var_2 = level._id_7B96[var_1]._id_04CB;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

_id_6E13(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_C98F[var_1]._id_90C1;
      break;
    case "game":
      var_2 = level._id_60EF[var_1]._id_90C1;
      break;
    case "team":
      var_2 = level._id_EFB5[var_1]._id_90C1;
      break;
    case "player":
      var_2 = level._id_B806[var_1]._id_90C1;
      break;
    case "class":
      var_2 = level._id_380B[var_1]._id_90C1;
      break;
    case "weapon":
      var_2 = level._id_10DE6[var_1]._id_90C1;
      break;
    case "hardpoint":
      var_2 = level._id_74CA[var_1]._id_90C1;
      break;
    case "hud":
      var_2 = level._id_7B96[var_1]._id_90C1;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

_id_D736(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      var_3 = level._id_C98F[var_1]._id_5095;
      break;
    case "game":
      var_3 = level._id_60EF[var_1]._id_5095;
      break;
    case "team":
      var_3 = level._id_EFB5[var_1]._id_5095;
      break;
    case "player":
      var_3 = level._id_B806[var_1]._id_5095;
      break;
    case "class":
      var_3 = level._id_380B[var_1]._id_5095;
      break;
    case "weapon":
      var_3 = level._id_10DE6[var_1]._id_5095;
      break;
    case "hardpoint":
      var_3 = level._id_74CA[var_1]._id_5095;
      break;
    case "hud":
      var_3 = level._id_7B96[var_1]._id_5095;
      break;
    default:
      var_3 = undefined;
      break;
  }

  setDvar(var_3, var_2);
}

_id_D738(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      level._id_C98F[var_1]._id_04CB = var_2;
      break;
    case "game":
      level._id_60EF[var_1]._id_04CB = var_2;
      break;
    case "team":
      level._id_EFB5[var_1]._id_04CB = var_2;
      break;
    case "player":
      level._id_B806[var_1]._id_04CB = var_2;
      break;
    case "class":
      level._id_380B[var_1]._id_04CB = var_2;
      break;
    case "weapon":
      level._id_10DE6[var_1]._id_04CB = var_2;
      break;
    case "hardpoint":
      level._id_74CA[var_1]._id_04CB = var_2;
      break;
    case "hud":
      level._id_7B96[var_1].v = var_2;
      break;
    default:
      break;
  }
}

_id_D737(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      level._id_C98F[var_1]._id_90C1 = var_2;
      break;
    case "game":
      level._id_60EF[var_1]._id_90C1 = var_2;
      break;
    case "team":
      level._id_EFB5[var_1]._id_90C1 = var_2;
      break;
    case "player":
      level._id_B806[var_1]._id_90C1 = var_2;
      break;
    case "class":
      level._id_380B[var_1]._id_90C1 = var_2;
      break;
    case "weapon":
      level._id_10DE6[var_1]._id_90C1 = var_2;
      break;
    case "hardpoint":
      level._id_74CA[var_1]._id_90C1 = var_2;
      break;
    case "hud":
      level._id_7B96[var_1]._id_90C1 = var_2;
      break;
    default:
      break;
  }
}

_id_C2C3(var_0, var_1, var_2, var_3) {
  if(_func_0121(var_3)) {
    var_3 = getDvar(var_2, var_3);
  } else {
    var_3 = getdvarint(var_2, var_3);
  }

  switch (var_0) {
    case "rule":
      if(!isDefined(level._id_C98F[var_1])) {
        level._id_C98F[var_1] = spawnStruct();
      }

      level._id_C98F[var_1]._id_04CB = var_3;
      level._id_C98F[var_1]._id_90C1 = var_3;
      level._id_C98F[var_1]._id_5095 = var_2;
      break;
    case "game":
      if(!isDefined(level._id_60EF[var_1])) {
        level._id_60EF[var_1] = spawnStruct();
      }

      level._id_60EF[var_1]._id_04CB = var_3;
      level._id_60EF[var_1]._id_90C1 = var_3;
      level._id_60EF[var_1]._id_5095 = var_2;
      break;
    case "team":
      if(!isDefined(level._id_EFB5[var_1])) {
        level._id_EFB5[var_1] = spawnStruct();
      }

      level._id_EFB5[var_1]._id_04CB = var_3;
      level._id_EFB5[var_1]._id_90C1 = var_3;
      level._id_EFB5[var_1]._id_5095 = var_2;
      break;
    case "player":
      if(!isDefined(level._id_B806[var_1])) {
        level._id_B806[var_1] = spawnStruct();
      }

      level._id_B806[var_1]._id_04CB = var_3;
      level._id_B806[var_1]._id_90C1 = var_3;
      level._id_B806[var_1]._id_5095 = var_2;
      break;
    case "class":
      if(!isDefined(level._id_380B[var_1])) {
        level._id_380B[var_1] = spawnStruct();
      }

      level._id_380B[var_1]._id_04CB = var_3;
      level._id_380B[var_1]._id_90C1 = var_3;
      level._id_380B[var_1]._id_5095 = var_2;
      break;
    case "weapon":
      if(!isDefined(level._id_10DE6[var_1])) {
        level._id_10DE6[var_1] = spawnStruct();
      }

      level._id_10DE6[var_1]._id_04CB = var_3;
      level._id_10DE6[var_1]._id_90C1 = var_3;
      level._id_10DE6[var_1]._id_5095 = var_2;
      break;
    case "hardpoint":
      if(!isDefined(level._id_74CA[var_1])) {
        level._id_74CA[var_1] = spawnStruct();
      }

      level._id_74CA[var_1]._id_04CB = var_3;
      level._id_74CA[var_1]._id_90C1 = var_3;
      level._id_74CA[var_1]._id_5095 = var_2;
      break;
    case "hud":
      if(!isDefined(level._id_7B96[var_1])) {
        level._id_7B96[var_1] = spawnStruct();
      }

      level._id_7B96[var_1]._id_04CB = var_3;
      level._id_7B96[var_1]._id_90C1 = var_3;
      level._id_7B96[var_1]._id_5095 = var_2;
      break;
  }
}

init() {
  level._id_39A5 = [];
  level._id_F8D5 = 1;
  level._id_C98F = [];
  level._id_60EF = [];
  level._id_EFB5 = [];
  level._id_B806 = [];
  level._id_380B = [];
  level._id_10DE6 = [];
  level._id_74CA = [];
  level._id_7B96 = [];
  _id_C2C3("game", "graceperiod", "#x3eca1f58470677919", 20);
  _id_C2C3("game", "graceperiod_comp", "#x3ae2b68e32db401c1", 30);
  _id_C2C3("game", "onlyheadshots", "#x39bbda22bdf02c2dd", 0);
  _id_C2C3("game", "allowkillcam", "#x3ce8d42bddf1541b4", 1);
  _id_C2C3("game", "spectatetype", "#x3579f4929fab8a387", 2);
  _id_C2C3("game", "allow3rdspectate", "#x33c7832882e7f841f", 1);
  _id_C2C3("game", "deathpointloss", "#x3bd05761b1ec260e3", 0);
  _id_C2C3("game", "suicidepointloss", "#x3406c213c604b1d75", 0);
  _id_C2C3("team", "teamkillpointloss", "#x3b8bf85c638a4d689", 0);
  _id_C2C3("team", "fftype", "#x3ee6d1b6a4d407071", 0);
  _id_C2C3("team", "teamkillspawndelay", "#x3bd29add5196a852e", 0);
  _id_C2C3("player", "maxhealth", "#x3479ab28f2a947c0b", 100);
  _id_C2C3("player", "laststand", "#x389465c9e5fd57277", 0);
  _id_C2C3("player", "postgameexfilweapon", "#x320bae50718405307", "none");
  _id_C2C3("player", "healthregentime", "#x362b15ff47d91275", 6);
  _id_C2C3("player", "forcerespawn", "#x388d06624940c1a88", 1);
  _id_C2C3("player", "streamingwaittime", "#x3f676621e3f832853", 5);
  _id_C2C3("weapon", "allowfrag", "#x33e1f66ea25181928", 1);
  _id_C2C3("weapon", "allowsmoke", "#x3886efad3b766e9d0", 1);
  _id_C2C3("weapon", "allowflash", "#x36ae9484519424f5f", 1);
  _id_C2C3("weapon", "allowc4", "#x390198e0e902bcc50", 1);
  _id_C2C3("weapon", "allowclaymores", "#x34edb437bfcf45b3c", 1);
  _id_C2C3("weapon", "allowrpgs", "#x3d2250416ba6a04ff", 1);
  _id_C2C3("weapon", "allowmines", "#x31572c7bd3d8bd55", 1);
  _id_C2C3("hardpoint", "allowartillery", "#x35378d8851783b86e", 1);
  _id_C2C3("hardpoint", "allowuav", "#x35d98df25943d05ec", 1);
  _id_C2C3("hardpoint", "allowsupply", "#x3ebbae6d56a5c578b", 1);
  _id_C2C3("hardpoint", "allowhelicopter", "#x31bec352e6d8c7d31", 1);
  _id_C2C3("hud", "showobjicons", "#x32e71bce06d9fd495", 1);
  setDvar("#x32e71bce06d9fd495", 1);
}