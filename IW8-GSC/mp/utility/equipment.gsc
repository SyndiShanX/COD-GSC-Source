/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\equipment.gsc
***********************************************/

get_mine_ignore_list() {
  var_0 = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(var_2 in level.dynamicladders)
    var_0[var_0.size] = var_2.ents[0];
  }

  var_4 = self getlinkedchildren(1);

  if(!isDefined(var_4))
    var_4 = [];

  var_4[var_4.size] = self getlinkedparent();

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && var_6.classname == "_encstr_8C8D08671D451291C849")
      var_0[var_0.size] = var_6;
  }

  return var_0;
}

get_sticky_grenade_destination(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_5))
    var_5 = spawnStruct();

  if(!isDefined(var_5.contents))
    var_5.contents = get_grenade_cast_contents();

  if(!isDefined(var_5.divisions))
    var_5.divisions = 5;

  if(!isDefined(var_5.amortize))
    var_5.amortize = 1;

  if(!isDefined(var_5.ignorelist))
    var_5.ignorelist = [var_0, var_0.owner];

  if(!isDefined(var_5.ignorclutter))
    var_5.ignoreclutter = 1;

  if(!isDefined(var_4))
    var_4 = 10;

  if(!isDefined(var_5.maxtime))
    var_5.maxtime = var_4 - var_4 * var_0.tickpercent;

  var_6 = var_5.maxtime / var_5.divisions;
  var_7[0] = 0;
  var_8[0] = var_0.origin;
  var_9 = var_5.divisions;
  var_10 = anglesToForward(var_1);
  var_11 = (0, 0, 1);
  var_12 = var_10 * var_2 + var_11 * var_3;
  var_13 = var_11 * vectordot(var_11, var_12);
  var_14 = var_12 - var_13;

  for(var_15 = 1; var_15 < var_5.divisions; var_15++) {
    var_16 = var_7[var_15 - 1];
    var_17 = var_8[var_15 - 1];
    var_18 = var_15 * var_6;
    var_19 = var_14 * var_18;
    var_20 = var_13 * var_18 + (0, 0, -400) * var_18 * var_18;
    var_21 = var_8[0] + var_19 + var_20;
    var_7[var_15] = var_18;
    var_8[var_15] = var_21;
    var_22 = physics_raycast(var_17, var_21, var_5.contents, var_5.ignorelist, 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", var_5.ignoreclutter);

    if(isDefined(var_22) && var_22.size > 0) {
      var_5.destination = var_22[0]["_encstr_BD260953AA97E3F014279D"];
      var_5.destinationnormal = var_22[0]["_encstr_820E07FAE8780B3A4C"];
      var_5.destinationentity = var_22[0]["_encstr_850E077B0BF30318B9"];
      var_5.destinationhit = 1;
      var_23 = var_21 - var_17;
      var_24 = length(var_23);
      var_25 = var_23 / var_24;
      var_26 = var_17 - var_5.destination;
      var_27 = vectordot(var_25, var_26);
      var_28 = clamp(var_27 / var_24, 0, 1);
      var_5.destinationtime = var_16 + var_6 * var_28;
      break;
    } else if(var_15 == var_5.divisions - 1) {
      var_5.destination = var_21;
      break;
    }

    if(var_5.amortize)
      waitframe();
  }

  return var_5;
}

get_grenade_cast_contents(var_0) {
  var_1 = undefined;

  if(istrue(var_0))
    var_1 = physics_createcontents(["_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
  else
    var_1 = physics_createcontents(["_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52"]);

  return var_1;
}

plant(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.releasegrenadeorigin = var_0.origin;
  var_0.releaseownerorigin = self.origin;
  var_0.releaseownereye = self getEye();
  var_0.releaseownerangles = self getgunangles();

  if(!isDefined(var_1.plantmaxtime))
    var_1.plantmaxtime = 0.5;

  if(!isDefined(var_1.plantmaxroll))
    var_1.plantmaxroll = 0;

  if(!isDefined(var_1.plantmindistbeloweye))
    var_1.plantmindistbeloweye = 12;

  if(!isDefined(var_1.plantmaxdistbelowownerfeet))
    var_1.plantmaxdistbelowownerfeet = 20;

  if(!isDefined(var_1.plantmindisteyetofeet))
    var_1.plantmindisteyetofeet = 45;

  if(!isDefined(var_1.plantnormalcos))
    var_1.plantnormalcos = 0.342;

  if(!isDefined(var_1.plantoffsetz))
    var_1.plantoffsetz = 1;

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

    if(istrue(var_6) && isDefined(var_5) && var_5 getnonstick())
      var_6 = undefined;

    var_8 = get_grenade_cast_contents(0);
    var_9 = [var_0];
    var_10 = self getEye() - (0, 0, 30);
    var_11 = var_10 + anglesToForward(self getplayerangles(1)) * 20;
    var_12 = physics_raycast(var_10, var_11, var_8, var_9, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_12) && var_12.size > 0)
      var_6 = 0;
  } else
    var_7 = plant_clamp_angles(var_0.angles, var_1);

  if(istrue(var_6)) {
    if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos)
      var_2 = 1;
    else {
      var_13 = vectordot(var_0.releaseownerorigin - var_3, (0, 0, 1));

      if(var_13 > 0) {
        if(var_13 > var_1.plantmaxdistbelowownerfeet)
          var_2 = 1;
      } else {
        var_14 = vectordot(var_0.releaseownereye - var_0.releaseownerorigin, (0, 0, 1));

        if(var_14 > var_1.plantmindisteyetofeet) {
          var_15 = vectordot(var_0.releaseownereye - var_3, (0, 0, 1));

          if(var_15 >= 0) {
            if(var_15 < var_1.plantmindistbeloweye)
              var_2 = 1;
          } else
            var_2 = 1;
        }
      }
    }
  } else
    var_2 = 1;

  if(var_2) {
    var_8 = var_1.castcontents;

    if(!isDefined(var_8))
      var_8 = get_grenade_cast_contents();

    var_9 = [var_0];
    var_10 = var_0.releaseownerorigin + (0, 0, 1);
    var_11 = var_10 + (0, 0, -1 * var_1.plantmaxdistbelowownerfeet);
    var_12 = physics_raycast(var_10, var_11, var_8, var_9, 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_12) && var_12.size > 0) {
      var_3 = var_12[0]["_encstr_BD260953AA97E3F014279D"];
      var_4 = var_12[0]["_encstr_820E07FAE8780B3A4C"];

      if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos)
        return 0;

      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(var_16), var_4);
        var_7 = plant_clamp_angles(var_7, var_1);
      } else
        var_7 = var_16;

      var_3 = var_3 + anglestoup(var_7) * var_1.plantoffsetz;
      var_5 = var_12[0]["_encstr_850E077B0BF30318B9"];
      var_0 dontinterpolate();
      var_0.origin = var_3;
      var_0.angles = var_7;
    } else
      return 0;
  } else {
    if(!isDefined(var_7)) {
      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(var_16), var_4);
        var_7 = plant_clamp_angles(var_7, var_1);
      } else
        var_7 = var_16;
    }

    var_3 = var_3 + anglestoup(var_7) * var_1.plantoffsetz;
    var_0 dontinterpolate();
    var_0.origin = var_3;
    var_0.angles = var_7;
  }

  if(isDefined(var_5))
    var_0 linkTo(var_5);

  return 1;
}

plant_watch_stuck(var_0, var_1) {
  childthread plant_watch_stuck_notify(var_0, var_1);
  childthread plant_watch_stuck_calculate(var_0, var_1);
  childthread plant_watch_stuck_timeout(var_0, var_1);
  var_1 waittill("_encstr_AB830B932B1763B3495DA1AB1B");
  waittillframeend;
  var_1 notify("_encstr_A15C098556ABD6A51E7A78");
  return var_1;
}

plant_watch_stuck_notify(var_0, var_1) {
  var_1 endon("_encstr_A15C098556ABD6A51E7A78");
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_2);
  var_1.notifyorigin = var_0.origin;
  var_1.notifyangles = var_0.angles;
  var_1.notifyentity = var_2;
  var_1.notifyhit = 1;
  var_1 notify("_encstr_AB830B932B1763B3495DA1AB1B");
}

plant_watch_stuck_calculate(var_0, var_1) {
  var_1 endon("_encstr_A15C098556ABD6A51E7A78");
  var_1 = get_sticky_grenade_destination(var_0, var_0.releaseownerangles, var_1.throwspeedforward, var_1.throwspeedup, var_1.castmaxtime, var_1);
  var_1.calcorigin = var_1.destination;
  var_1.calcnormal = var_1.destinationnormal;
  var_1.calcentity = var_1.destinationentity;
  var_1.calchit = var_1.destinationhit;
  var_1 notify("_encstr_AB830B932B1763B3495DA1AB1B");
}

plant_watch_stuck_timeout(var_0, var_1) {
  var_1 endon("_encstr_A15C098556ABD6A51E7A78");
  wait(var_1.plantmaxtime);
  var_1 notify("_encstr_AB830B932B1763B3495DA1AB1B");
}

plant_clamp_angles(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0[1];
  var_4 = scripts\engine\utility::ter_op(var_1.plantmaxroll != 0, var_0[2], 0);

  if(var_4 != 0) {
    if(var_4 > 0)
      var_4 = clamp(var_0[2], 0, var_1.plantmaxroll);
    else
      var_4 = clamp(var_0[2], -1 * var_1.plantmaxroll, 0);
  }

  return (var_2, var_3, var_4);
}

_id_14444() {
  var_0 = self.origin;

  for(;;) {
    self waittill("_encstr_9BEC12738743F3E4FC383F10EFB9F28BAF651888", var_1);

    if(isDefined(var_1) && self istouching(var_1) && self.origin[2] - var_0[2] > 12) {
      self notify("_encstr_8C4918EA30E953BC7023976EB7A844FB03AE53A259BD03755003");
      return;
    }
  }
}