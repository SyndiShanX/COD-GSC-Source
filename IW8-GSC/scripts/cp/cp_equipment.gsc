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

  for(var0 = 1;; var0++) {
    var1 = tablelookupbyrow("mp/equipment.csv", var0, 1);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tolower(var1);
    var3 = spawnStruct();
    var3.ref = var2;
    var4 = tablelookupbyrow("mp/equipment.csv", var0, 6);

    if(var4 != "none") {
      var3.objweapon = getcompleteweaponname(var4);
    }

    var3.id = var0;
    var3.image = tablelookupbyrow("mp/equipment.csv", var0, 4);
    var3.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow("mp/equipment.csv", var0, 7) == "2", "secondary", "primary");
    var3.scavengerammo = int(tablelookupbyrow("mp/equipment.csv", var0, 10));
    var3.ispassive = tolower(tablelookupbyrow("mp/equipment.csv", var0, 11)) == "true";
    var3.usecellspawns = tablelookupbyrow("mp/equipment.csv", var0, 8) != "-1";
    var5 = tablelookupbyrow("mp/equipment.csv", var0, 12);

    if(var5 == "none") {} else if(var5 == "") {
      if(var4 != "none") {
        var3.damageweaponnames = [var4];
      }
    } else {
      var6 = [];

      if(var4 != "none") {
        GscBinSkip0(0x2e, var6.size, var4);
      }

      var7 = strtok(var5, " ");

      foreach(var9 in var7) {
        var6 = var9;
      }

      var3.damageweaponnames = var6;
    }

    level.equipment.table[var2] = var3;
  }
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
  self endon("death");
  self endon("disconnect");
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
  } else {
    var7 = plant_clamp_angles(var0.angles, var1);
  }

  if(istrue(var6)) {
    if(isDefined(var4) && vectordot(var4, (0, 0, 1)) < var1.plantnormalcos) {
      var2 = 1;
    } else {
      var8 = vectordot(var0.releaseownerorigin - var3, (0, 0, 1));

      if(var8 > 0) {
        if(var8 > var1.plantmaxdistbelowownerfeet) {
          var2 = 1;
        }
      } else {
        var9 = vectordot(var0.releaseownereye - var0.releaseownerorigin, (0, 0, 1));

        if(var9 > var1.plantmindisteyetofeet) {
          var10 = vectordot(var0.releaseownereye - var3, (0, 0, 1));

          if(var10 >= 0) {
            if(var10 < var1.plantmindistbeloweye) {
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
    var11 = var1.castcontents;

    if(!isDefined(var11)) {
      var11 = get_grenade_cast_contents();
    }

    var12 = [var0, self];
    var13 = var0.releaseownerorigin;
    var14 = var13 + (0, 0, -1 * var1.plantmaxdistbelowownerfeet);
    var15 = physics_raycast(var13, var14, var11, var12, 1, "physicsquery_closest", 1);

    if(isDefined(var15) && var15.size > 0) {
      var3 = var15[0]["position"];
      var4 = var15[0]["normal"];

      if(isDefined(var4) && vectordot(var4, (0, 0, 1)) < var1.plantnormalcos) {
        return false;
      }

      var16 = var0.releaseownerangles * (0, 1, 0);

      if(isDefined(var4)) {
        var7 = scripts\cp\utility::vectortoanglessafe(anglesToForward(var16), var4);
        var7 = plant_clamp_angles(var7, var1);
      } else {
        var7 = var16;
      }

      var3 += anglestoup(var7) * var1.plantoffsetz;
      var5 = var15[0]["entity"];
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
        var7 = scripts\cp\utility::vectortoanglessafe(anglesToForward(var16), var4);
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

function makeexplosiveusabletag(var0, var1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var2 = self.owner;
  var3 = self.weapon_name;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    self enablemissilehint(1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethinttag(var0);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  scripts\cp\utility::setselfusable(var2);
  childthread scripts\cp\utility::notusableforjoiningplayers(var2);
  self waittillmatch("trigger", var2);

  if(isDefined(var3)) {
    var4 = undefined;

    switch (var3) {
      case "at_mine_mp":
        var4 = "power_atMine";
        break;
      case "trophy_mp":
        var4 = "power_trophy";
        break;
      case "claymore_mp":
        var4 = "power_claymore";
        break;
      case "c4_mp_p":
        var4 = "power_c4";
        break;
    }

    if(isDefined(var4)) {
      if(!self.owner scripts\cp\cp_powers::haspower(var4)) {
        self.owner scripts\cp\cp_powers::givepower(var4, "primary", undefined, undefined, undefined, 0, 1, 0);
      }
    }
  }

  var2 notify("pickup_equipment", var3);
  var5 = getequipmentreffromweapon(getcompleteweaponname(var3));

  if(isDefined(var5) && hasequipment(self.owner, var5)) {
    self.owner setweaponammoclip(self.objweapon, weaponclipsize(self.objweapon) + 1);
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  thread scripts\cp\cp_weapon::deleteexplosive();
}

function setexplosiveusablehintstring(var0) {
  if(!isDefined(var0)) {
    return;
  }

  switch (var0) {
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

function hasequipment(var0) {
  if(!isDefined(self.equipment)) {
    if(isDefined(self.powers)) {
      foreach(var2 in self.powers) {
        if(var3 == var0) {
          return true;
        }
      }
    }

    return false;
  }

  foreach(var5 in self.equipment) {
    if(var5 == var0) {
      return true;
    }
  }

  return false;
}

function getequipmentreffromweapon(var0) {
  var0 = mapequipmentweaponforref(var0);

  foreach(var2 in level.equipment.table) {
    if(isDefined(var2.objweapon) && var0 == var2.objweapon) {
      return var2.ref;
    }
  }

  return undefined;
}

function mapequipmentweaponforref(var0) {
  switch (var0.basename) {
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

  if(issubstr(var0.basename, "throwingknife")) {
    return getcompleteweaponname("throwingknife_mp");
  }

  if(issubstr(var0.basename, "thermite")) {
    return getcompleteweaponname("thermite_mp");
  }

  if(issubstr(var0.basename, "claymore")) {
    return getcompleteweaponname("claymore_mp");
  }

  return var0;
}

function getequipmentammo(var0) {
  if(!issameweapon(var0)) {
    var0 = asmdevgetallstates(var0);
  }

  if(!isDefined(var0)) {
    return 0;
  }

  return self getammocount(var0);
}

function setequipmentammo(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  self setweaponammoclip(var0, var1);
}