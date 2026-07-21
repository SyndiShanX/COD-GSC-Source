/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\script_utility.gsc
***********************************************/

registersharedfunc(var_0, var_1, var_2) {
  if(!isDefined(level.sharedfuncs))
    level.sharedfuncs = [];

  if(!isDefined(level.sharedfuncs[var_0]))
    level.sharedfuncs[var_0] = [];

  level.sharedfuncs[var_0][var_1] = var_2;
}

issharedfuncdefined(var_0, var_1, var_2) {
  if(!isDefined(level.sharedfuncs))
    return 0;

  if(!isDefined(level.sharedfuncs[var_0]))
    return 0;

  var_3 = level.sharedfuncs[var_0][var_1];

  if(!isDefined(var_3)) {
    if(istrue(var_2)) {}

    return 0;
  }

  return 1;
}

getsharedfunc(var_0, var_1) {
  return level.sharedfuncs[var_0][var_1];
}

_id_140DE(var_0, var_1, var_2, var_3) {
  if(issharedfuncdefined(var_0, var_1)) {
    var_4 = getsharedfunc(var_0, var_1);
    var_5 = undefined;

    if(isarray(var_3)) {
      switch (var_3.size) {
        default:
          break;
        case 0:
          var_5 = [[var_4]]();
          break;
        case 1:
          var_5 = [[var_4]](var_3[0]);
          break;
        case 2:
          var_5 = [[var_4]](var_3[0], var_3[1]);
          break;
        case 3:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2]);
          break;
        case 4:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3]);
          break;
        case 5:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3], var_3[4]);
          break;
        case 6:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_3[5]);
          break;
        case 7:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_3[5], var_3[6]);
          break;
        case 8:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_3[5], var_3[6], var_3[7]);
          break;
        case 9:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_3[5], var_3[6], var_3[7], var_3[8]);
          break;
        case 10:
          var_5 = [[var_4]](var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_3[5], var_3[6], var_3[7], var_3[8], var_3[9]);
          break;
      }
    } else
      var_5 = [[var_4]]();

    return var_5;
  }

  return var_2;
}