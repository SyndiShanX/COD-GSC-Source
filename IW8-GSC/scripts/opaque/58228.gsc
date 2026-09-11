/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58228.gsc
***********************************************/

function ref_124f5() {
  var0 = self getmovingplatformparent();

  if(isDefined(var0)) {
    if(tugofwar_tank(var0)) {
      return true;
    }
  }

  return false;
}

function tugofwar_tank(var0) {
  if(isDefined(level.ref_145f1)) {
    foreach(var2 in level.ref_145f1.ref_13c8d) {
      if(var2 == var0) {
        return true;
      }

      if(isDefined(var2.wz_tease) && var2.wz_tease == var0) {
        return true;
      }
    }
  } else if(isDefined(level.ref_13cd3) && isDefined(level.ref_13cd3.helis_assault2_check_size) && isDefined(level.ref_13cd3.ref_11c70)) {
    if(var0 == level.ref_13cd3.ref_11c70) {
      return true;
    }

    foreach(var2 in level.ref_13cd3.helis_assault2_check_size) {
      if(var2 == var0) {
        return true;
      }
    }
  }

  return false;
}

function tryspawnweapons(var0) {
  if(isDefined(level.ref_1394c)) {
    foreach(var2 in level.ref_1394c) {
      if(isDefined(var2)) {
        if(var2 == var0) {
          return true;
        }

        if(isDefined(var2.get_depletion_delay) && var2.get_depletion_delay == var0) {
          return true;
        }
      }
    }
  }

  return false;
}

function trophy_tryreflectsnapshot(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(level.ref_145f1)) {
    foreach(var2 in level.ref_145f1.ref_13c8d) {
      if(var2 == var0) {
        return true;
      }
    }
  }

  return false;
}

function manageworldspawnedbolts(var0) {
  if(isDefined(level.ref_145f1)) {
    if(isDefined(var0) && isDefined(var0.tablet) && istrue(var0.tablet.ref_11ff8)) {
      level.ref_145f1 notify("train_dom_contract_complete", var0);
      return;
    }

    return;
  }
}

function c130airdrop_deleteatlifetime(var0, var1) {
  var2 = 0;

  if(var0 > 5) {
    var2 = 5;
  }

  var3 = 10;

  if(isDefined(var1)) {
    var3 = var1;
  }

  var4 = var2;

  while(var4 < var0) {
    if(c130airdrop_createpathstruct(var4)) {
      return true;
    }

    var4 += var3;
  }

  return false;
}

function c130airdrop_createpathstruct(var0) {
  for(var1 = 0; var1 < level.ref_145f1.animents.size; var1++) {
    var2 = level.scr_anim["br_cargo_train_anim"][level.ref_145f1.animents[var1].bullet][0];

    if(!isDefined(var2)) {
      return;
    }

    var3 = getanimlength(var2);
    var4 = level.ref_145f1.animents[var1] getanimtime(var2);
    var5 = var4 * var3;

    if(var5 + var0 > var3) {
      var6 = var5 + var0 - var3;
      var7 = var3 / var6;
      var8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var2, var7);
    } else {
      var9 = var5 + var0;
      var10 = var9 / var3;
      var8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var2, var10);
    }

    if(!isDefined(var8) || !isvector(var8)) {
      return 0;
    }

    if(ref_127da(var8)) {
      return 1;
    }
  }

  return 0;
}

function c130airdrop_createpath() {
  if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d)) {
    foreach(var1 in level.ref_145f1.ref_13c8d) {
      if(ref_127da(var1.origin)) {
        return true;
      }
    }
  }

  return false;
}

function ref_127da(var0, var1) {
  if(istrue(level.br_circle_disabled)) {
    return false;
  }

  var2 = ai_pushes_terminal();
  var3 = ai_raising_alarm();

  if(istrue(var1) && istrue(level.group_unset_jugg_standstill)) {
    var2 = ai_stop_shooting_watch();
    var3 = ai_truck_rider_think();
  }

  if(!try_play_tv_station_intro_sequence(var0, var2, var3)) {
    return true;
  }

  return false;
}

function try_play_tv_station_intro_sequence(var0, var1, var2) {
  if(squared(var0[0] - var1[0]) + squared(var0[1] - var1[1]) <= squared(var2)) {
    return true;
  }

  return false;
}

function ai_stop_shooting_watch() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    return (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  }

  return (0, 0, 0);
}

function ai_truck_rider_think() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    return level.br_circle.safecircleent.origin[2];
  }

  return 0;
}

function ai_pushes_terminal() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    return (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  }

  return (0, 0, 0);
}

function ai_raising_alarm() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    return level.br_circle.dangercircleent.origin[2];
  }

  return 0;
}

function updatelocationbesttime(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = init_timer(var1, var2, var3, var4, var5, var6, var7, var8);
  return updateleadmarkers(var0, var9);
}

function updateleadmarkers(var0, var1) {
  var2 = var1.ref_14724;
  var3 = var0.origin - var2;
  var4 = vectordot(var3, var1.ref_12ac3);

  if(var4 > var1.halflength) {
    return false;
  }

  if(var4 < var1.halflength * -1) {
    return false;
  }

  var5 = vectordot(var3, var1.ref_12ac4);

  if(var5 > var1.halfwidth) {
    return false;
  }

  if(var5 < var1.halfwidth * -1) {
    return false;
  }

  var6 = vectordot(var3, var1.ref_12ac5);

  if(var6 > var1.setplayerbeingrevivedextrainfo) {
    return false;
  }

  if(var6 < var1.setplayerbeingrevivedextrainfo * -1) {
    return false;
  }

  return true;
}

function init_timer(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = spawnStruct();
  var8.ref_12ac3 = anglesToForward(var0.angles);
  var8.ref_12ac4 = anglestoright(var0.angles);
  var8.ref_12ac5 = anglestoup(var0.angles);
  var9 = var0 gettagorigin(var1);
  var8.ref_14724 = var9 + var8.ref_12ac3 * var2 + var8.ref_12ac4 * var3 + var8.ref_12ac5 * var4;
  var10 = [];
  var8.halflength = var5 / 2;
  var8.halfwidth = var6 / 2;
  var8.setplayerbeingrevivedextrainfo = var7 / 2;
  return var8;
}

function ref_124d8(var0, var1) {
  return updatelocationbesttime(var1, var0, "tag_origin", 0, 0, 88, 760, 112, 124);
}

function updateleaders() {
  var0 = 0;

  if(level.gametype == "br") {
    if(isDefined(level.ref_1394c)) {
      foreach(var2 in level.ref_1394c) {
        if(!isDefined(var2)) {
          continue;
        }

        if(ref_124d8(var2, self)) {
          var0 = 1;
          break;
        }
      }
    }
  }

  return var0;
}