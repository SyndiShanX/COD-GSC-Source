/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1250.gsc
**************************************/

_id_8662() {
  var_0 = self;
  var_0 visionsetnakedforplayer("mp_hub_allies_vlobby", 0);
}

_id_A594(var_0, var_1) {
  if(isDefined(self.pers["class"]) && self.pers["class"] == var_0 && (!isDefined(var_1) || !var_1)) {
    return;
  }
  self.pers["class"] = var_0;
  self.class = var_0;
  maps\mp\gametypes\_class::setclass(self.pers["class"]);
  self._id_95AE = undefined;
  self._id_95AF = undefined;
  maps\mp\gametypes\_class::_id_4790(self.pers["team"], self.pers["class"]);
  _id_04E0::_id_115E();
}

_id_636A(var_0) {
  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "class_select") {
      var_0.scragentsetmaxturnspeed = var_2;
      continue;
    }

    if(var_1 != "hub_firing_range_selected") {
      continue;
    }
    if(isDefined(var_0._id_5721)) {
      waitframe();
      var_0 setclientdvar("3078", "1.0");
      var_0 notify("buttonToFiringRangePressed");
      var_0 notify("weaponPlantFiringRange");

      if(!var_0._id_5721) {
        var_0._id_3C3D = 1;
        var_0 _id_04DB::_id_98C7();
        var_0 unlink();
        var_0 cameraunlink();
        continue;
      }

      var_0 _id_04DB::_id_21C0();
    }
  }
}

getturretpitchrate(var_0, var_1) {
  var_2 = _getent(var_0, "targetname");

  if(isDefined(var_2))
    var_2 setlightintensity(var_1);
}

_id_8418(var_0, var_1) {
  foreach(var_3 in var_0)
  getturretpitchrate(var_3, var_1);
}

_id_8877() {}

_id_62F5() {
  self endon("disconnect");
  var_0 = ["soldier_key", "soldier_rim", "soldier_fill", "soldier_rimR"];
  var_1 = ["gun_key", "gun_rim", "gun_fill"];
  var_2 = ["wide_rim", "wide_key", "wide_fill"];
  var_3 = [1, 52, 24, 51, 51, 44, 44, 51, 52, 51];
  _id_8877();

  for(;;) {
    self waittill("luinotifyserver", var_4, var_5);
    var_6 = getdvarint("2454", 0);

    if(var_4 == "weapon_select" && isDefined(var_5)) {
      var_7 = int(var_5);
      var_8 = maps\mp\gametypes\_class::_id_1D66(maps\mp\_utility::_id_452B(var_7), undefined, undefined, undefined, undefined, undefined, undefined, maps\mp\_utility::_id_472C(var_7));
      var_9 = [];
      var_9[var_9.size] = var_8;
      self loadweapons(var_9);
      continue;
    }

    if((var_4 == "classpreview" || var_4 == "classpreview_postcopy") && isDefined(var_5)) {
      if(!var_6) {
        if(var_5 >= 0) {
          var_10 = var_5 & 15;
          var_11 = int(var_5 / 16);

          if(var_11 > 0) {
            self._id_294D = var_11 - 1;
            _id_A594("custom" + (self._id_294D + 1), 0);
          }
        }
      }

      continue;
    }

    if(var_4 == "costume_apply") {
      var_12 = maps\mp\gametypes\_class::_id_1F95();

      if(isDefined(var_5) && var_5 >= 0) {
        var_13 = var_5 & 7;
        var_14 = int((var_5 &~7) / 8);
        var_12[var_13] = var_14;
      }

      self _meth_84C7(var_12);
      self loadcustomizationplayerview(self);
    }
  }
}

_id_0953(var_0) {
  for(var_1 = 0; var_1 < level._id_60B7.size; var_1++) {
    if(level._id_60B7[var_1]._id_01D6 == var_0._id_01D6) {
      level._id_60B7[var_1] = var_0;
      var_0 = undefined;
      break;
    }
  }

  if(isDefined(var_0))
    level._id_60B7[level._id_60B7.size] = var_0;
}

_id_6EA2(var_0) {
  foreach(var_2 in var_0) {
    var_3 = var_2._id_01D6;

    if(var_2._id_013B >= 0)
      _id_0953(var_2);
  }
}

_id_3B94(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3._id_01D6 == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_631E() {
  level._id_60B7 = [];
  var_0 = maps\mp\_utility::_id_4604();

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0)
      waitframe();

    while(isDefined(level.players) && level.players.size > 0) {
      var_1 = [];
      var_2 = [];
      var_3 = 0;
      var_4 = 0;
      var_5 = 0;

      foreach(var_7 in level._id_60B7) {
        var_8 = _id_3B94(var_7._id_01D6);

        if(isDefined(var_8) && var_7._id_011C != 0) {
          var_2[var_4] = var_8;
          var_4++;
        } else if(!isDefined(var_8) && getdvarint("2803", 0) == 0) {}

        var_9 = spawnStruct();
        var_9._id_985A = "allies";
        var_9._id_23D9 = 0;
        var_9._id_2669 = 0;
        var_9._id_1E26 = 1;
        var_9._id_7615 = 0;
        var_9._id_56FE = 0;
        var_9._id_0079 = var_7._id_0079;
        var_9._id_76F7 = var_7._id_013B;
        var_9._id_76F3[0] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013C, 3));
        var_9._id_76F3[1] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013D, 3));
        var_9._id_76F3[2] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013E, 3));
        var_9._id_76F3[3] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013F, 3));
        var_9._id_76F3[4] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0140, 3));
        var_9._id_76F3[5] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0141, 3));
        var_9._id_0144 = var_7._id_0144;
        var_9._id_76F5 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0142, 1));
        var_9._id_76F4 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0143, 1));
        var_9._id_7700 = maps\mp\_utility::_id_452A(tablelookup("mp/reticleTable.csv", 0, var_7._id_0145, 1));
        var_9.primarypaintjobid = var_7._id_76EF;
        var_9.primarycharmguid = var_7._id_76F0;
        var_9.botsetscriptgoalnode = var_7._id_016E;
        var_9.botsetflag[0] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0170, 3));
        var_9.botsetflag[1] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0171, 3));
        var_9.botsetflag[2] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0172, 3));
        var_9.botsetflag[3] = 0;
        var_9.botsetflag[4] = 0;
        var_9.botsetflag[5] = 0;
        var_9._id_0176 = var_7._id_0176;
        var_9.botsetscriptmove = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0173, 1));
        var_9.botsetstance = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0174, 1));
        var_9.botsetscriptenemy = maps\mp\_utility::_id_452A(tablelookup("mp/reticleTable.csv", 0, var_7._id_0177, 1));
        var_9.secondarypaintjobid = var_7.usinggamepad;
        var_9.secondarycharmguid = var_7.forcethirdpersonwhenfollowing;
        var_9._id_60E9 = var_7._id_0101;
        var_9._id_5CA8 = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_00ED, 1));
        var_9._id_959F = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_01A0, 1));
        var_9._id_6F69[0] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0123, 1));
        var_9._id_6F69[1] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0124, 1));
        var_9._id_6F69[2] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0125, 1));
        var_9._id_6F69[3] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0126, 1));
        var_9._id_6F69[4] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0127, 1));
        var_9._id_6F69[5] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0128, 1));
        var_9._id_6F69[6] = 0;
        var_9._id_6F69[7] = 0;
        var_9._id_6F69[8] = 0;

        if(isDefined(var_7._id_0129))
          var_9._id_6F69[6] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0129, 1));

        if(isDefined(var_7._id_012A))
          var_9._id_6F69[7] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_012A, 1));

        if(isDefined(var_7._id_012B))
          var_9._id_6F69[8] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_012B, 1));

        var_10 = 1;
        var_11 = 1;
        var_12 = 1;

        if(!maps\mp\gametypes\_class::isvalidprimary(var_9._id_76F7, var_10) && !maps\mp\gametypes\_class::isvalidsecondary(var_9.botsetscriptgoalnode, var_11, var_12)) {
          var_9._id_76F7 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 0);

          for(var_13 = 0; var_13 < 6; var_13++)
            var_9._id_76F3[var_13] = 0;
        }

        if(!maps\mp\gametypes\_class::isvalidsecondary(var_9.botsetscriptgoalnode, var_11, var_12)) {
          var_9.botsetscriptgoalnode = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 1);

          for(var_13 = 0; var_13 < 6; var_13++)
            var_9.botsetflag[var_13] = 0;
        }

        var_9._id_7709 = maps\mp\_utility::_id_473C(var_9._id_76F7, 0);
        var_9.botgetscriptgoalradius = maps\mp\_utility::_id_473C(var_9.botsetscriptgoalnode, 0);
        var_9._id_60FC = maps\mp\_utility::_id_473C(var_9._id_60E9, 0);
        var_9._id_76F8 = maps\mp\gametypes\_class::_id_1D66(maps\mp\_utility::_id_452B(var_9._id_76F7), var_9._id_76F3[0], var_9._id_76F3[1], var_9._id_76F3[2], var_9._id_76F3[3], var_9._id_76F3[4], var_9._id_76F3[5], maps\mp\_utility::_id_472C(var_9._id_76F7), var_9._id_76F5, var_9._id_76F4, var_9._id_7700, var_9._id_0144);
        var_9.botclearscriptgoal = maps\mp\gametypes\_class::_id_1D66(maps\mp\_utility::_id_452B(var_9.botsetscriptgoalnode), var_9.botsetflag[0], var_9.botsetflag[1], var_9.botsetflag[2], var_9.botsetflag[3], var_9.botsetflag[4], var_9.botsetflag[5], maps\mp\_utility::_id_472C(var_9.botsetscriptgoalnode), var_9.botsetscriptmove, var_9.botsetstance, var_9.botsetscriptenemy, var_9._id_0176);
        var_9._id_5A62 = 0;
        var_9._id_5A63 = 0;
        var_9._id_5A64 = 0;
        var_9._id_5A65 = 0;
        var_9._id_59DA = 0;
        var_9._id_870C = 1;
        var_9._id_37FE = maps\mp\_utility::_id_44CE(var_9._id_5CA8, 0);
        var_9._id_37FD = 0;
        var_9._id_69AD = maps\mp\_utility::_id_44CE(var_9._id_959F, 0);
        var_9._id_69AC = 0;
        var_14 = [];
        var_14[level._id_2682["shirt"]] = var_7._id_017F;
        var_14[level._id_2682["head"]] = var_7._id_00B9;
        var_14[level._id_2682["pants"]] = var_7._id_011A;
        var_14[level._id_2682["eyewear"]] = var_7._id_0091;
        var_14[level._id_2682["hat"]] = var_7._id_00B8;
        var_14[level._id_2682["gear"]] = var_7._id_00A8;
        var_8 = _id_3B94(var_7._id_01D6);

        if(isDefined(var_8) && var_7._id_011C != 0) {
          var_2[var_4] = var_8;
          var_4++;
        }

        if(!isDefined(var_8)) {
          if(getdvarint("2803", 0) == 0) {}

          continue;
        }

        var_15 = 0;
        var_16 = "customClasses";

        if(isDefined(var_8._id_294D))
          var_15 = var_8._id_294D;

        var_9.class = "custom" + common_scripts\utility::_id_9AAD(var_15 + 1);
        var_9._id_231B = var_15;
        var_8._id_A597 = var_9;
      }

      level._id_60B7 = [];
      waitframe();
    }
  }
}