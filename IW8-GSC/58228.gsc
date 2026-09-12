/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58228.gsc
***********************************************/

function ref_124f5() {
  var_0 = self getmovingplatformparent();

  if(isDefined(var_0)) {
    if(tugofwar_tank(var_0)) {
      return true;
    }
  }

  return false;
}

function tugofwar_tank(var_0) {
  if(isDefined(level.ref_145f1)) {
    foreach(var_2 in level.ref_145f1.ref_13c8d) {
      if(var_2 == var_0) {
        return true;
      }

      if(isDefined(var_2.wz_tease) && var_2.wz_tease == var_0) {
        return true;
      }
    }
  } else if(isDefined(level.ref_13cd3) && isDefined(level.ref_13cd3.helis_assault2_check_size) && isDefined(level.ref_13cd3.ref_11c70)) {
    if(var_0 == level.ref_13cd3.ref_11c70) {
      return true;
    }

    foreach(var_2 in level.ref_13cd3.helis_assault2_check_size) {
      if(var_2 == var_0) {
        return true;
      }
    }
  }

  return false;
}

function tryspawnweapons(var_0) {
  if(isDefined(level.ref_1394c)) {
    foreach(var_2 in level.ref_1394c) {
      if(isDefined(var_2)) {
        if(var_2 == var_0) {
          return true;
        }

        if(isDefined(var_2.get_depletion_delay) && var_2.get_depletion_delay == var_0) {
          return true;
        }
      }
    }
  }

  return false;
}

function trophy_tryreflectsnapshot(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(level.ref_145f1)) {
    foreach(var_2 in level.ref_145f1.ref_13c8d) {
      if(var_2 == var_0) {
        return true;
      }
    }
  }

  return false;
}

function manageworldspawnedbolts(var_0) {
  if(isDefined(level.ref_145f1)) {
    if(isDefined(var_0) && isDefined(var_0.tablet) && istrue(var_0.tablet.ref_11ff8)) {
      level.ref_145f1 notify("train_dom_contract_complete", var_0);
      return;
    }

    return;
  }
}

function c130airdrop_deleteatlifetime(var_0, var_1) {
  var_2 = 0;

  if(var_0 > 5) {
    var_2 = 5;
  }

  var_3 = 10;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = var_2;

  while(var_4 < var_0) {
    if(c130airdrop_createpathstruct(var_4)) {
      return true;
    }

    var_4 += var_3;
  }

  return false;
}

function c130airdrop_createpathstruct(var_0) {
  for(var_1 = 0; var_1 < level.ref_145f1.animents.size; var_1++) {
    var_2 = level.scr_anim["br_cargo_train_anim"][level.ref_145f1.animents[var_1].bullet][0];

    if(!isDefined(var_2)) {
      return;
    }

    var_3 = getanimlength(var_2);
    var_4 = level.ref_145f1.animents[var_1] getanimtime(var_2);
    var_5 = var_4 * var_3;

    if(var_5 + var_0 > var_3) {
      var_6 = var_5 + var_0 - var_3;
      var_7 = var_3 / var_6;
      var_8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var_2, var_7);
    } else {
      var_9 = var_5 + var_0;
      var_10 = var_9 / var_3;
      var_8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var_2, var_10);
    }

    if(!isDefined(var_8) || !isvector(var_8)) {
      return 0;
    }

    if(ref_127da(var_8)) {
      return 1;
    }
  }

  return 0;
}

function c130airdrop_createpath() {
  if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d)) {
    foreach(var_1 in level.ref_145f1.ref_13c8d) {
      if(ref_127da(var_1.origin)) {
        return true;
      }
    }
  }

  return false;
}

function ref_127da(var_0, var_1) {
  if(istrue(level.br_circle_disabled)) {
    return false;
  }

  var_2 = ai_pushes_terminal();
  var_3 = ai_raising_alarm();

  if(istrue(var_1) && istrue(level.group_unset_jugg_standstill)) {
    var_2 = ai_stop_shooting_watch();
    var_3 = ai_truck_rider_think();
  }

  if(!try_play_tv_station_intro_sequence(var_0, var_2, var_3)) {
    return true;
  }

  return false;
}

function try_play_tv_station_intro_sequence(var_0, var_1, var_2) {
  if(squared(var_0[0] - var_1[0]) + squared(var_0[1] - var_1[1]) <= squared(var_2)) {
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

function updatelocationbesttime(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = init_timer(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  return updateleadmarkers(var_0, var_9);
}

function updateleadmarkers(var_0, var_1) {
  var_2 = var_1.ref_14724;
  var_3 = var_0.origin - var_2;
  var_4 = vectordot(var_3, var_1.ref_12ac3);

  if(var_4 > var_1.halflength) {
    return false;
  }

  if(var_4 < var_1.halflength * -1) {
    return false;
  }

  var_5 = vectordot(var_3, var_1.ref_12ac4);

  if(var_5 > var_1.halfwidth) {
    return false;
  }

  if(var_5 < var_1.halfwidth * -1) {
    return false;
  }

  var_6 = vectordot(var_3, var_1.ref_12ac5);

  if(var_6 > var_1.setplayerbeingrevivedextrainfo) {
    return false;
  }

  if(var_6 < var_1.setplayerbeingrevivedextrainfo * -1) {
    return false;
  }

  return true;
}

function init_timer(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();
  var_8.ref_12ac3 = anglesToForward(var_0.angles);
  var_8.ref_12ac4 = anglestoright(var_0.angles);
  var_8.ref_12ac5 = anglestoup(var_0.angles);
  var_9 = var_0 gettagorigin(var_1);
  var_8.ref_14724 = var_9 + var_8.ref_12ac3 * var_2 + var_8.ref_12ac4 * var_3 + var_8.ref_12ac5 * var_4;
  var_10 = [];
  var_8.halflength = var_5 / 2;
  var_8.halfwidth = var_6 / 2;
  var_8.setplayerbeingrevivedextrainfo = var_7 / 2;
  return var_8;
}

function ref_124d8(var_0, var_1) {
  return updatelocationbesttime(var_1, var_0, "tag_origin", 0, 0, 88, 760, 112, 124);
}

function updateleaders() {
  var_0 = 0;

  if(level.gametype == "br") {
    if(isDefined(level.ref_1394c)) {
      foreach(var_2 in level.ref_1394c) {
        if(!isDefined(var_2)) {
          continue;
        }

        if(ref_124d8(var_2, self)) {
          var_0 = 1;
          break;
        }
      }
    }
  }

  return var_0;
}