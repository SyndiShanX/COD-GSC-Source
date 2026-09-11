/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\script_utility.gsc
****************************************************/

function registersharedfunc(var0, var1, var2) {
  if(!isDefined(level.sharedfuncs)) {
    level.sharedfuncs = [];
  }

  if(!isDefined(level.sharedfuncs[var0])) {
    level.sharedfuncs[var0] = [];
  }

  level.sharedfuncs[var0][var1] = var2;
}

function issharedfuncdefined(var0, var1, var2) {
  if(!isDefined(level.sharedfuncs)) {
    return false;
  }

  if(!isDefined(level.sharedfuncs[var0])) {
    return false;
  }

  var3 = level.sharedfuncs[var0][var1];

  if(!isDefined(var3)) {
    if(istrue(var2)) {}

    return false;
  }

  return true;
}

function getsharedfunc(var0, var1) {
  return level.sharedfuncs[var0][var1];
}

function ref_140de(var0, var1, var2, var3) {
  if(issharedfuncdefined(var0, var1)) {
    var4 = getsharedfunc(var0, var1);
    var5 = undefined;

    if(isarray(var3)) {
      switch (var3.size) {
        default:
          break;
        case 0:
          var5 = [[var4]]();
          break;
        case 1:
          var5 = [[var4]](var3[0]);
          break;
        case 2:
          var5 = [[var4]](var3[0], var3[1]);
          break;
        case 3:
          var5 = [[var4]](var3[0], var3[1], var3[2]);
          break;
        case 4:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3]);
          break;
        case 5:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3], var3[4]);
          break;
        case 6:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3], var3[4], var3[5]);
          break;
        case 7:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3], var3[4], var3[5], var3[6]);
          break;
        case 8:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3], var3[4], var3[5], var3[6], var3[7]);
          break;
        case 9:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3], var3[4], var3[5], var3[6], var3[7], var3[8]);
          break;
        case 10:
          var5 = [[var4]](var3[0], var3[1], var3[2], var3[3], var3[4], var3[5], var3[6], var3[7], var3[8], var3[9]);
          break;
      }
    } else {
      var5 = [[var4]]();
    }

    return var5;
  }

  return var4;
}