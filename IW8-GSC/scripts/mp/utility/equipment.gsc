/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\equipment.gsc
***********************************************/

function get_mine_ignore_list() {
  var0 = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(var2 in level.dynamicladders) {
      var0 = var2.ents[0];
    }
  }

  var4 = self getlinkedchildren(1);

  if(!isDefined(var4)) {
    var4 = [];
  }

  GscBinSkip0(0x2e, var4.size, self getlinkedparent());
}

function get_sticky_grenade_destination(var0, var1, var2, var3, var4, var5) {
  var0 endon("death");

  if(!isDefined(var5)) {
    var5 = spawnStruct();
  }

  if(!isDefined(var5.contents)) {
    var5.contents = get_grenade_cast_contents();
  }

  if(!isDefined(var5.divisions)) {
    var5.divisions = 5;
  }

  if(!isDefined(var5.amortize)) {
    var5.amortize = 1;
  }

  if(!isDefined(var5.ignorelist)) {
    var5.ignorelist = [var0, var0.owner];
  }

  if(!isDefined(var5.ignorclutter)) {
    var5.ignoreclutter = 1;
  }

  if(!isDefined(var4)) {
    var4 = 10;
  }

  if(!isDefined(var5.maxtime)) {
    var5.maxtime = var4 - var4 * var0.tickpercent;
  }

  var6 = var5.maxtime / var5.divisions;
  GscBinSkip1(0x45, 0, 0);
}

function get_grenade_cast_contents(var0) {
  var1 = undefined;

  if(istrue(var0)) {
    var1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_player"]);
  } else {
    var1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);
  }

  return var1;
}

function plant(var0, var1) {
  self endon("death_or_disconnect");
  var0 endon("death");
  var0.releasegrenadeorigin = var0.origin;
  var0.releaseownerorigin = self.origin;
  var0.releaseownereye = self getEye();
  var0.releaseownerangles = self getgunangles();

  if(!isDefined(var1.plantmaxtime)) {
    var1.plantmaxtime = 0.5;
  }

  if(!isDefined(var1.plantmaxroll)) {
    var1.plantmaxroll = 0;
  }

  if(!isDefined(var1.plantmindistbeloweye)) {
    var1.plantmindistbeloweye = 12;
  }

  if(!isDefined(var1.plantmaxdistbelowownerfeet)) {
    var1.plantmaxdistbelowownerfeet = 20;
  }

  if(!isDefined(var1.plantmindisteyetofeet)) {
    var1.plantmindisteyetofeet = 45;
  }

  if(!isDefined(var1.plantnormalcos)) {
    var1.plantnormalcos = 0.342;
  }

  if(!isDefined(var1.plantoffsetz)) {
    var1.plantoffsetz = 1;
  }

  plant_watch_stuck(var0, var1);
  var2 = 0;
  var3 = var1.notifyorigin;
  var4 = var1.notifynormal;
  var5 = var1.notifyentity;
  var6 = var1.notifyhit;
  var7 = undefined;

  if(!istrue(var6)) {
    var3 = var1.calcorigin;
    var4 = var1.calcnormal;
    var5 = var1.calcentity;
    var6 = var1.calchit;

    if(istrue(var6) && isDefined(var5) && var5 getnonstick()) {
      var6 = undefined;
    }

    var8 = get_grenade_cast_contents(0);
    var9 = [var0];
    var10 = self getEye() - (0, 0, 30);
    var11 = var10 + anglesToForward(self getplayerangles(1)) * 20;
    var12 = physics_raycast(var10, var11, var8, var9, 0, "physicsquery_closest", 1);

    if(isDefined(var12) && var12.size > 0) {
      var6 = 0;
    }
  } else {
    var7 = plant_clamp_angles(var0.angles, var1);
  }

  if(istrue(var6)) {
    if(isDefined(var4) && vectordot(var4, (0, 0, 1)) < var1.plantnormalcos) {
      var2 = 1;
    } else {
      var13 = vectordot(var0.releaseownerorigin - var3, (0, 0, 1));

      if(var13 > 0) {
        if(var13 > var1.plantmaxdistbelowownerfeet) {
          var2 = 1;
        }
      } else {
        var14 = vectordot(var0.releaseownereye - var0.releaseownerorigin, (0, 0, 1));

        if(var14 > var1.plantmindisteyetofeet) {
          var15 = vectordot(var0.releaseownereye - var3, (0, 0, 1));

          if(var15 >= 0) {
            if(var15 < var1.plantmindistbeloweye) {
              var2 = 1;
            }
          } else {
            var2 = 1;
          }
        }
      }
    }
  } else {
    var2 = 1;
  }

  if(var2) {
    var8 = var1.castcontents;

    if(!isDefined(var8)) {
      var8 = get_grenade_cast_contents();
    }

    var9 = [var0];
    var10 = var0.releaseownerorigin + (0, 0, 1);
    var11 = var10 + (0, 0, -1 * var1.plantmaxdistbelowownerfeet);
    var12 = physics_raycast(var10, var11, var8, var9, 1, "physicsquery_closest", 1);

    if(isDefined(var12) && var12.size > 0) {
      var3 = var12[0]["position"];
      var4 = var12[0]["normal"];

      if(isDefined(var4) && vectordot(var4, (0, 0, 1)) < var1.plantnormalcos) {
        return false;
      }

      var16 = var0.releaseownerangles * (0, 1, 0);

      if(isDefined(var4)) {
        var7 = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(var16), var4);
        var7 = plant_clamp_angles(var7, var1);
      } else {
        var7 = var16;
      }

      var3 += anglestoup(var7) * var1.plantoffsetz;
      var5 = var12[0]["entity"];
      var0 dontinterpolate();
      var0.origin = var3;
      var0.angles = var7;
    } else {
      return false;
    }
  } else {
    if(!isDefined(var7)) {
      var16 = var0.releaseownerangles * (0, 1, 0);

      if(isDefined(var4)) {
        var7 = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(var16), var4);
        var7 = plant_clamp_angles(var7, var1);
      } else {
        var7 = var16;
      }
    }

    var3 += anglestoup(var7) * var1.plantoffsetz;
    var0 dontinterpolate();
    var0.origin = var3;
    var0.angles = var7;
  }

  if(isDefined(var5)) {
    var0 linkTo(var5);
  }

  return true;
}

function plant_watch_stuck(var0, var1) {
  GscBinSkip4(0x35, var0, var1);
}

function plant_watch_stuck_notify(var0, var1) {
  var1 endon("end_race");
  var0 waittill("missile_stuck", var2);
  var1.notifyorigin = var0.origin;
  var1.notifyangles = var0.angles;
  var1.notifyentity = var2;
  var1.notifyhit = 1;
  var1 notify("start_race");
}

function plant_watch_stuck_calculate(var0, var1) {
  var1 endon("end_race");
  var1 = get_sticky_grenade_destination(var0, var0.releaseownerangles, var1.throwspeedforward, var1.throwspeedup, var1.castmaxtime, var1);
  var1.calcorigin = var1.destination;
  var1.calcnormal = var1.destinationnormal;
  var1.calcentity = var1.destinationentity;
  var1.calchit = var1.destinationhit;
  var1 notify("start_race");
}

function plant_watch_stuck_timeout(var0, var1) {
  var1 endon("end_race");
  wait var1.plantmaxtime;
  var1 notify("start_race");
}

function plant_clamp_angles(var0, var1) {
  var2 = 0;
  var3 = var0[1];
  var4 = scripts\engine\utility::ter_op(var1.plantmaxroll != 0, var0[2], 0);

  if(var4 != 0) {
    if(var4 > 0) {
      var4 = clamp(var0[2], 0, var1.plantmaxroll);
    } else {
      var4 = clamp(var0[2], -1 * var1.plantmaxroll, 0);
    }
  }

  return (var2, var3, var4);
}

function ref_14444() {
  var0 = self.origin;

  for(;;) {
    self waittill("touching_platform", var1);

    if(isDefined(var1) && self istouching(var1) && self.origin[2] - var0[2] > 12) {
      self notify("collision_with_platform");
      return;
    }
  }
}