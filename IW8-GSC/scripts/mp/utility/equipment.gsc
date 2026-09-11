/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\equipment.gsc
***********************************************/

function get_mine_ignore_list() {
  var_0 = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(var_2 in level.dynamicladders) {
      var_0 = var_2.ents[0];
    }
  }

  var_4 = self getlinkedchildren(1);

  if(!isDefined(var_4)) {
    var_4 = [];
  }

  GscBinSkip0(0x2e, var_4.size, self getlinkedparent());
}

function get_sticky_grenade_destination(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
  }

  if(!isDefined(var_5.contents)) {
    var_5.contents = get_grenade_cast_contents();
  }

  if(!isDefined(var_5.divisions)) {
    var_5.divisions = 5;
  }

  if(!isDefined(var_5.amortize)) {
    var_5.amortize = 1;
  }

  if(!isDefined(var_5.ignorelist)) {
    var_5.ignorelist = [var_0, var_0.owner];
  }

  if(!isDefined(var_5.ignorclutter)) {
    var_5.ignoreclutter = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 10;
  }

  if(!isDefined(var_5.maxtime)) {
    var_5.maxtime = var_4 - var_4 * var_0.tickpercent;
  }

  var_6 = var_5.maxtime / var_5.divisions;
  GscBinSkip1(0x45, 0, 0);
}

function get_grenade_cast_contents(var_0) {
  var_1 = undefined;

  if(istrue(var_0)) {
    var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_player"]);
  } else {
    var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);
  }

  return var_1;
}

function plant(var_0, var_1) {
  self endon("death_or_disconnect");
  var_0 endon("death");
  var_0.releasegrenadeorigin = var_0.origin;
  var_0.releaseownerorigin = self.origin;
  var_0.releaseownereye = self getEye();
  var_0.releaseownerangles = self getgunangles();

  if(!isDefined(var_1.plantmaxtime)) {
    var_1.plantmaxtime = 0.5;
  }

  if(!isDefined(var_1.plantmaxroll)) {
    var_1.plantmaxroll = 0;
  }

  if(!isDefined(var_1.plantmindistbeloweye)) {
    var_1.plantmindistbeloweye = 12;
  }

  if(!isDefined(var_1.plantmaxdistbelowownerfeet)) {
    var_1.plantmaxdistbelowownerfeet = 20;
  }

  if(!isDefined(var_1.plantmindisteyetofeet)) {
    var_1.plantmindisteyetofeet = 45;
  }

  if(!isDefined(var_1.plantnormalcos)) {
    var_1.plantnormalcos = 0.342;
  }

  if(!isDefined(var_1.plantoffsetz)) {
    var_1.plantoffsetz = 1;
  }

  plant_watch_stuck(var_0, var_1);
  var_2 = 0;
  var_3 = var_1.notifyorigin;
  var_4 = var_1.notifynormal;
  var_5 = var_1.notifyentity;
  var_6 = var_1.notifyhit;
  var_7 = undefined;

  if(!istrue(var_6)) {
    var_3 = var_1.calcorigin;
    var_4 = var_1.calcnormal;
    var_5 = var_1.calcentity;
    var_6 = var_1.calchit;

    if(istrue(var_6) && isDefined(var_5) && var_5 getnonstick()) {
      var_6 = undefined;
    }

    var_8 = get_grenade_cast_contents(0);
    var_9 = [var_0];
    var_10 = self getEye() - (0, 0, 30);
    var_11 = var_10 + anglesToForward(self getplayerangles(1)) * 20;
    var_12 = physics_raycast(var_10, var_11, var_8, var_9, 0, "physicsquery_closest", 1);

    if(isDefined(var_12) && var_12.size > 0) {
      var_6 = 0;
    }
  } else {
    var_7 = plant_clamp_angles(var_0.angles, var_1);
  }

  if(istrue(var_6)) {
    if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos) {
      var_2 = 1;
    } else {
      var_13 = vectordot(var_0.releaseownerorigin - var_3, (0, 0, 1));

      if(var_13 > 0) {
        if(var_13 > var_1.plantmaxdistbelowownerfeet) {
          var_2 = 1;
        }
      } else {
        var_14 = vectordot(var_0.releaseownereye - var_0.releaseownerorigin, (0, 0, 1));

        if(var_14 > var_1.plantmindisteyetofeet) {
          var_15 = vectordot(var_0.releaseownereye - var_3, (0, 0, 1));

          if(var_15 >= 0) {
            if(var_15 < var_1.plantmindistbeloweye) {
              var_2 = 1;
            }
          } else {
            var_2 = 1;
          }
        }
      }
    }
  } else {
    var_2 = 1;
  }

  if(var_2) {
    var_8 = var_1.castcontents;

    if(!isDefined(var_8)) {
      var_8 = get_grenade_cast_contents();
    }

    var_9 = [var_0];
    var_10 = var_0.releaseownerorigin + (0, 0, 1);
    var_11 = var_10 + (0, 0, -1 * var_1.plantmaxdistbelowownerfeet);
    var_12 = physics_raycast(var_10, var_11, var_8, var_9, 1, "physicsquery_closest", 1);

    if(isDefined(var_12) && var_12.size > 0) {
      var_3 = var_12[0]["position"];
      var_4 = var_12[0]["normal"];

      if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos) {
        return false;
      }

      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(var_16), var_4);
        var_7 = plant_clamp_angles(var_7, var_1);
      } else {
        var_7 = var_16;
      }

      var_3 += anglestoup(var_7) * var_1.plantoffsetz;
      var_5 = var_12[0]["entity"];
      var_0 dontinterpolate();
      var_0.origin = var_3;
      var_0.angles = var_7;
    } else {
      return false;
    }
  } else {
    if(!isDefined(var_7)) {
      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(var_16), var_4);
        var_7 = plant_clamp_angles(var_7, var_1);
      } else {
        var_7 = var_16;
      }
    }

    var_3 += anglestoup(var_7) * var_1.plantoffsetz;
    var_0 dontinterpolate();
    var_0.origin = var_3;
    var_0.angles = var_7;
  }

  if(isDefined(var_5)) {
    var_0 linkTo(var_5);
  }

  return true;
}

function plant_watch_stuck(var_0, var_1) {
  GscBinSkip4(0x35, var_0, var_1);
}

function plant_watch_stuck_notify(var_0, var_1) {
  var_1 endon("end_race");
  var_0 waittill("missile_stuck", var_2);
  var_1.notifyorigin = var_0.origin;
  var_1.notifyangles = var_0.angles;
  var_1.notifyentity = var_2;
  var_1.notifyhit = 1;
  var_1 notify("start_race");
}

function plant_watch_stuck_calculate(var_0, var_1) {
  var_1 endon("end_race");
  var_1 = get_sticky_grenade_destination(var_0, var_0.releaseownerangles, var_1.throwspeedforward, var_1.throwspeedup, var_1.castmaxtime, var_1);
  var_1.calcorigin = var_1.destination;
  var_1.calcnormal = var_1.destinationnormal;
  var_1.calcentity = var_1.destinationentity;
  var_1.calchit = var_1.destinationhit;
  var_1 notify("start_race");
}

function plant_watch_stuck_timeout(var_0, var_1) {
  var_1 endon("end_race");
  wait var_1.plantmaxtime;
  var_1 notify("start_race");
}

function plant_clamp_angles(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0[1];
  var_4 = scripts\engine\utility::ter_op(var_1.plantmaxroll != 0, var_0[2], 0);

  if(var_4 != 0) {
    if(var_4 > 0) {
      var_4 = clamp(var_0[2], 0, var_1.plantmaxroll);
    } else {
      var_4 = clamp(var_0[2], -1 * var_1.plantmaxroll, 0);
    }
  }

  return (var_2, var_3, var_4);
}

function ref_14444() {
  var_0 = self.origin;

  for(;;) {
    self waittill("touching_platform", var_1);

    if(isDefined(var_1) && self istouching(var_1) && self.origin[2] - var_0[2] > 12) {
      self notify("collision_with_platform");
      return;
    }
  }
}