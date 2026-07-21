/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_equipment.gsc
***********************************************/

subway_car_move_think() {
  level.equipment = spawnStruct();
  loadtable();
}

loadtable() {
  level.equipment.table = [];
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 1);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tolower(var_1);
    var_3 = spawnStruct();
    var_3.ref = var_2;
    var_4 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 6);

    if(var_4 != "_encstr_8BBA05185F8B99")
      var_3.objweapon = getcompleteweaponname(var_4);

    var_3.id = var_0;
    var_3.image = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 4);
    var_3.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 7) == "_encstr_A74C0222", "_encstr_AC8F0AE74163F85AAA380AD8", "_encstr_BA7F0830B3A7859B60B0");
    var_3.scavengerammo = int(tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 10));
    var_3.ispassive = tolower(tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 11)) == "_encstr_AAEF05B83B43EB";
    var_3.usecellspawns = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 8) != "_encstr_B10703DD0F";
    var_5 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 12);

    if(var_5 == "_encstr_8BBA05185F8B99") {} else if(var_5 == "_encstr_B40101") {
      if(var_4 != "_encstr_8BBA05185F8B99")
        var_3.damageweaponnames = [var_4];
    } else {
      var_6 = [];

      if(var_4 != "_encstr_8BBA05185F8B99")
        var_6[var_6.size] = var_4;

      var_7 = strtok(var_5, "_encstr_974C0246");

      foreach(var_9 in var_7)
      var_6[var_6.size] = var_9;

      var_3.damageweaponnames = var_6;
    }

    level.equipment.table[var_2] = var_3;
    var_0++;
  }
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
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
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
  } else
    var_7 = plant_clamp_angles(var_0.angles, var_1);

  if(istrue(var_6)) {
    if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos)
      var_2 = 1;
    else {
      var_8 = vectordot(var_0.releaseownerorigin - var_3, (0, 0, 1));

      if(var_8 > 0) {
        if(var_8 > var_1.plantmaxdistbelowownerfeet)
          var_2 = 1;
      } else {
        var_9 = vectordot(var_0.releaseownereye - var_0.releaseownerorigin, (0, 0, 1));

        if(var_9 > var_1.plantmindisteyetofeet) {
          var_10 = vectordot(var_0.releaseownereye - var_3, (0, 0, 1));

          if(var_10 >= 0) {
            if(var_10 < var_1.plantmindistbeloweye)
              var_2 = 1;
          } else
            var_2 = 1;
        }
      }
    }
  } else
    var_2 = 1;

  if(var_2) {
    var_11 = var_1.castcontents;

    if(!isDefined(var_11))
      var_11 = get_grenade_cast_contents();

    var_12 = [var_0, self];
    var_13 = var_0.releaseownerorigin;
    var_14 = var_13 + (0, 0, -1 * var_1.plantmaxdistbelowownerfeet);
    var_15 = physics_raycast(var_13, var_14, var_11, var_12, 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_15) && var_15.size > 0) {
      var_3 = var_15[0]["_encstr_BD260953AA97E3F014279D"];
      var_4 = var_15[0]["_encstr_820E07FAE8780B3A4C"];

      if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos)
        return 0;

      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\cp\utility::vectortoanglessafe(anglesToForward(var_16), var_4);
        var_7 = plant_clamp_angles(var_7, var_1);
      } else
        var_7 = var_16;

      var_3 = var_3 + anglestoup(var_7) * var_1.plantoffsetz;
      var_5 = var_15[0]["_encstr_850E077B0BF30318B9"];
      var_0 dontinterpolate();
      var_0.origin = var_3;
      var_0.angles = var_7;
    } else
      return 0;
  } else {
    if(!isDefined(var_7)) {
      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\cp\utility::vectortoanglessafe(anglesToForward(var_16), var_4);
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

makeexplosiveusabletag(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");
  var_2 = self.owner;
  var_3 = self.weapon_name;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    self enablemissilehint(1);
  else
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  self sethinttag(var_0);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  scripts\cp\utility::setselfusable(var_2);
  childthread scripts\cp\utility::notusableforjoiningplayers(var_2);

  for(;;) {
    self waittillmatch("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_3)) {
      var_4 = undefined;

      switch (var_3) {
        case "_encstr_81430B218B3F7018458997D78A":
          var_4 = "_encstr_8B960D1CF6DD599CD7C247A94BCD56";
          break;
        case "_encstr_92EA0A290B32FF88A90170EB":
          var_4 = "_encstr_92D60D79F74BB8B6F7C333986BC3EB";
          break;
        case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
          var_4 = "_encstr_8E910FA7E764B78317A2C973305A28B33B";
          break;
        case "_encstr_9AAE0876FCB7603101DB":
          var_4 = "_encstr_8D7C09102FE7216D71A66D";
          break;
      }

      if(isDefined(var_4)) {
        if(!self.owner scripts\cp\cp_powers::haspower(var_4))
          self.owner scripts\cp\cp_powers::givepower(var_4, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, 0, 1, 0);
      }
    }

    var_2 notify("_encstr_9A3C117B6B0602C5284EC7CA23C808BAED8D93", var_3);
    var_5 = getequipmentreffromweapon(getcompleteweaponname(var_3));

    if(isDefined(var_5) && self.owner hasequipment(var_5))
      self.owner setweaponammoclip(self.objweapon, weaponclipsize(self.objweapon) + 1);

    if(isDefined(self.useobj))
      self.useobj delete();

    thread scripts\cp\cp_weapon::deleteexplosive();
    return;
  }
}

setexplosiveusablehintstring(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "_encstr_9AAE0876FCB7603101DB":
      self setHintString(&"_encstr_BDCD1AA245AA920A5354722AD742A472A2A9BC41941AD2AA41BE8643");
      break;
    case "_encstr_81430B218B3F7018458997D78A":
      self setHintString(&"_encstr_A7691F152A55A40A9A5439157D4252C9A2359782943469AA82AF28A2F553A4398A");
      break;
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
      self setHintString(&"_encstr_99E92015CFA3B8518D0530C597A13878519F58F859DFA0476931A39C21762B8F42A5");
      break;
    case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
      self setHintString(&"_encstr_993B23A88A55A40A532A932ABE2492C9A86A970AA41A695528F5A3A0A6AF8E92152714118A");
      break;
    case "_encstr_92EA0A290B32FF88A90170EB":
      self setHintString(&"_encstr_B6AC1E512AAA9282D4A23951D7425293A2A6792852D09655A0FA2A253D2812CA");
      break;
  }
}

hasequipment(var_0) {
  if(!isDefined(self.equipment)) {
    if(isDefined(self.powers)) {
      foreach(var_3, var_2 in self.powers) {
        if(var_3 == var_0)
          return 1;
      }
    }

    return 0;
  }

  foreach(var_5 in self.equipment) {
    if(var_5 == var_0)
      return 1;
  }

  return 0;
}

getequipmentreffromweapon(var_0) {
  var_0 = mapequipmentweaponforref(var_0);

  foreach(var_2 in level.equipment.table) {
    if(isDefined(var_2.objweapon) && var_0 == var_2.objweapon)
      return var_2.ref;
  }

  return undefined;
}

mapequipmentweaponforref(var_0) {
  switch (var_0.basename) {
    case "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA":
    case "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170":
    case "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83":
    case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
      return getcompleteweaponname("_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83");
    case "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB":
      return getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA");
    case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
      return getcompleteweaponname("_encstr_81430B218B3F7018458997D78A");
    case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
      return getcompleteweaponname("_encstr_99410C4B48C39AB7D0CD95B769DB");
  }

  if(issubstr(var_0.basename, "_encstr_92590EFBF91ED25750D8D7DC30B88E8A"))
    return getcompleteweaponname("_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83");

  if(issubstr(var_0.basename, "_encstr_8D7609A4F337C2C9C2BDB7"))
    return getcompleteweaponname("_encstr_99410C4B48C39AB7D0CD95B769DB");

  if(issubstr(var_0.basename, "_encstr_9BD1091BC62CBCB5F6E4CA"))
    return getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA");

  return var_0;
}

getequipmentammo(var_0) {
  if(!issameweapon(var_0))
    var_0 = asmdevgetallstates(var_0);

  if(!isDefined(var_0))
    return 0;

  return self getammocount(var_0);
}

setequipmentammo(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  self setweaponammoclip(var_0, var_1);
}