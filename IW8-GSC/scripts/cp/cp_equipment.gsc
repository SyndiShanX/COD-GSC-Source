/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_equipment.gsc
***********************************************/

function subway_car_move_think() {
  level.equipment = spawnStruct();
  loadtable();
}

function loadtable() {
  level.equipment.table = [];

  for(var_0 = 1;; var_0++) {
    var_1 = tablelookupbyrow("mp/equipment.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tolower(var_1);
    var_3 = spawnStruct();
    var_3.ref = var_2;
    var_4 = tablelookupbyrow("mp/equipment.csv", var_0, 6);

    if(var_4 != "none") {
      var_3.objweapon = getcompleteweaponname(var_4);
    }

    var_3.id = var_0;
    var_3.image = tablelookupbyrow("mp/equipment.csv", var_0, 4);
    var_3.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow("mp/equipment.csv", var_0, 7) == "2", "secondary", "primary");
    var_3.scavengerammo = int(tablelookupbyrow("mp/equipment.csv", var_0, 10));
    var_3.ispassive = tolower(tablelookupbyrow("mp/equipment.csv", var_0, 11)) == "true";
    var_3.usecellspawns = tablelookupbyrow("mp/equipment.csv", var_0, 8) != "-1";
    var_5 = tablelookupbyrow("mp/equipment.csv", var_0, 12);

    if(var_5 == "none") {} else if(var_5 == "") {
      if(var_4 != "none") {
        var_3.damageweaponnames = [var_4];
      }
    } else {
      var_6 = [];

      if(var_4 != "none") {
        GscBinSkip0(0x2e, var_6.size, var_4);
      }

      var_7 = strtok(var_5, " ");

      foreach(var_9 in var_7) {
        var_6 = var_9;
      }

      var_3.damageweaponnames = var_6;
    }

    level.equipment.table[var_2] = var_3;
  }
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
  self endon("death");
  self endon("disconnect");
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
  } else {
    var_7 = plant_clamp_angles(var_0.angles, var_1);
  }

  if(istrue(var_6)) {
    if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos) {
      var_2 = 1;
    } else {
      var_8 = vectordot(var_0.releaseownerorigin - var_3, (0, 0, 1));

      if(var_8 > 0) {
        if(var_8 > var_1.plantmaxdistbelowownerfeet) {
          var_2 = 1;
        }
      } else {
        var_9 = vectordot(var_0.releaseownereye - var_0.releaseownerorigin, (0, 0, 1));

        if(var_9 > var_1.plantmindisteyetofeet) {
          var_10 = vectordot(var_0.releaseownereye - var_3, (0, 0, 1));

          if(var_10 >= 0) {
            if(var_10 < var_1.plantmindistbeloweye) {
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
    var_11 = var_1.castcontents;

    if(!isDefined(var_11)) {
      var_11 = get_grenade_cast_contents();
    }

    var_12 = [var_0, self];
    var_13 = var_0.releaseownerorigin;
    var_14 = var_13 + (0, 0, -1 * var_1.plantmaxdistbelowownerfeet);
    var_15 = physics_raycast(var_13, var_14, var_11, var_12, 1, "physicsquery_closest", 1);

    if(isDefined(var_15) && var_15.size > 0) {
      var_3 = var_15[0]["position"];
      var_4 = var_15[0]["normal"];

      if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1.plantnormalcos) {
        return false;
      }

      var_16 = var_0.releaseownerangles * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\cp\utility::vectortoanglessafe(anglesToForward(var_16), var_4);
        var_7 = plant_clamp_angles(var_7, var_1);
      } else {
        var_7 = var_16;
      }

      var_3 += anglestoup(var_7) * var_1.plantoffsetz;
      var_5 = var_15[0]["entity"];
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
        var_7 = scripts\cp\utility::vectortoanglessafe(anglesToForward(var_16), var_4);
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

function makeexplosiveusabletag(var_0, var_1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_2 = self.owner;
  var_3 = self.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    self enablemissilehint(1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethinttag(var_0);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  scripts\cp\utility::setselfusable(var_2);
  childthread scripts\cp\utility::notusableforjoiningplayers(var_2);
  self waittillmatch("trigger", var_2);

  if(isDefined(var_3)) {
    var_4 = undefined;

    switch (var_3) {
      case "at_mine_mp":
        var_4 = "power_atMine";
        break;
      case "trophy_mp":
        var_4 = "power_trophy";
        break;
      case "claymore_mp":
        var_4 = "power_claymore";
        break;
      case "c4_mp_p":
        var_4 = "power_c4";
        break;
    }

    if(isDefined(var_4)) {
      if(!self.owner scripts\cp\cp_powers::haspower(var_4)) {
        self.owner scripts\cp\cp_powers::givepower(var_4, "primary", undefined, undefined, undefined, 0, 1, 0);
      }
    }
  }

  var_2 notify("pickup_equipment", var_3);
  var_5 = getequipmentreffromweapon(getcompleteweaponname(var_3));

  if(isDefined(var_5) && hasequipment(self.owner, var_5)) {
    self.owner setweaponammoclip(self.objweapon, weaponclipsize(self.objweapon) + 1);
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  thread scripts\cp\cp_weapon::deleteexplosive();
}

function setexplosiveusablehintstring(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "c4_mp_p":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_C4");
      break;
    case "at_mine_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_AT_MINE");
      break;
    case "claymore_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_CLAYMORE");
      break;
    case "gas_grenade_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_GAS_GRENADE");
      break;
    case "trophy_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_TROPHY");
      break;
  }
}

function hasequipment(var_0) {
  if(!isDefined(self.equipment)) {
    if(isDefined(self.powers)) {
      foreach(var_2 in self.powers) {
        if(var_3 == var_0) {
          return true;
        }
      }
    }

    return false;
  }

  foreach(var_5 in self.equipment) {
    if(var_5 == var_0) {
      return true;
    }
  }

  return false;
}

function getequipmentreffromweapon(var_0) {
  var_0 = mapequipmentweaponforref(var_0);

  foreach(var_2 in level.equipment.table) {
    if(isDefined(var_2.objweapon) && var_0 == var_2.objweapon) {
      return var_2.ref;
    }
  }

  return undefined;
}

function mapequipmentweaponforref(var_0) {
  switch (var_0.basename) {
    case "throwingknife_drill_mp":
    case "throwingknife_electric_mp":
    case "throwingknife_fire_mp":
    case "throwingknife_mp":
      return getcompleteweaponname("throwingknife_mp");
    case "claymore_radial_mp":
      return getcompleteweaponname("claymore_mp");
    case "at_mine_ap_mp":
      return getcompleteweaponname("at_mine_mp");
    case "thermite_ap_mp":
    case "thermite_av_mp":
      return getcompleteweaponname("thermite_mp");
  }

  if(issubstr(var_0.basename, "throwingknife")) {
    return getcompleteweaponname("throwingknife_mp");
  }

  if(issubstr(var_0.basename, "thermite")) {
    return getcompleteweaponname("thermite_mp");
  }

  if(issubstr(var_0.basename, "claymore")) {
    return getcompleteweaponname("claymore_mp");
  }

  return var_0;
}

function getequipmentammo(var_0) {
  if(!issameweapon(var_0)) {
    var_0 = asmdevgetallstates(var_0);
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  return self getammocount(var_0);
}

function setequipmentammo(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  self setweaponammoclip(var_0, var_1);
}