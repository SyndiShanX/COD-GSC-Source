/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_spawn.gsc
***********************************************/

vehicle_spawn_getleveldataforvehicle(var_0, var_1) {
  var_2 = vehicle_spawn_getleveldata();
  var_3 = var_2.databyref[var_0];

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_2.databyref[var_0] = var_3;
    var_3.ref = var_0;
    var_3.maxinstancecount = 0;
    var_3.priority = 50;
    var_3.getspawnstructscallback = undefined;
    var_3.spawncallback = undefined;
    var_3.canspawncallback = undefined;
    var_3.clearancecheckradius = undefined;
    var_3.clearancecheckheight = undefined;
    var_3.clearancecheckoffsetz = undefined;
    var_3.clearancecheckminradius = undefined;
    var_3._id_13B83 = undefined;
    var_3._id_12CA1 = undefined;
    var_3._id_13B84 = undefined;
  }

  return var_3;
}

vehicle_spawn_canspawnVehicle(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_spawn_getleveldata();

  if(vehicle_spawn_getinstancecount() < var_4.maxinstancecount) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_960110D858376A07B077CD952B0D2DB1C6B2")]](var_0)) {
      if(isDefined(var_0)) {
        if(!scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_instancesarelimited(var_0) || !scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_atinstancelimit(var_0, var_1, var_2)) {
          var_5 = vehicle_spawn_getleveldataforvehicle(var_0);

          if(isDefined(var_5)) {
            if(istrue(level.ignorevehicletypeinstancelimit) || !isDefined(var_5.maxinstancecount) || vehicle_spawn_getinstancecountforref(var_0) < var_5.maxinstancecount) {
              if(isDefined(var_5.canspawncallback))
                return [[var_5.canspawncallback]](var_1, var_2, var_3, var_0);
              else
                return 1;
            }
          }
        }
      }
    }
  }

  return 0;
}

vehicle_spawn_spawnVehicle(var_0, var_1, var_2) {
  var_3 = vehicle_spawn_getleveldataforvehicle(var_0);

  if(vehicle_spawn_iscodevehicletest()) {
    var_4 = scripts\cp_mp\utility\game_utility::getmapname();
    var_5 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_0);

    if(var_5.size > 0) {
      return;
    }
    if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (44455, -12715, 108);
        var_1.angles = (360, 315, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (45735, -12397, 121);
        var_1.angles = (0, 358, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (29480, 33349, 589);
        var_1.angles = (0, 202, 0);
      }
    } else if(var_0 == "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (20845, -12233, -57);
        var_1.angles = (7, 81, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944")
        return;
      else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2")
        return;
    } else if(var_0 == "_encstr_86510C82737817CD40B38B720A15") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (20845, -12233, -57);
        var_1.angles = (7, 81, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (44559, -12331, 87);
        var_1.angles = (0, 11, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (29135, 33754, 605);
        var_1.angles = (0, 7, 0);
      }
    } else if(var_0 == "_encstr_8C190467402B") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (22421, -13456, -48);
        var_1.angles = (13, 36, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (45202, -11294, 149);
        var_1.angles = (0, 283, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (29250, 35115, 616);
        var_1.angles = (0, 321, 0);
      }
    } else if(var_0 == "_encstr_84D70A6B2BEF3C9B30A67164") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (22742, -12693, -56);
        var_1.angles = (360, 315, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944")
        return;
      else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2")
        return;
    } else if(var_0 == "_encstr_AF390B295782C3585F1B21D8C4") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (22787, -13503, -56);
        var_1.angles = (3, 269, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (45259, -12740, 63);
        var_1.angles = (0, 274, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (32524, 34558, 599);
        var_1.angles = (0, 107, 0);
      }
    } else if(var_0 == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_0 == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (21108, -12603, 100);
        var_1.angles = (6, 353, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (46478, -12482, 400);
        var_1.angles = (0, 84, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (28735, 34000, 767);
        var_1.angles = (0, 80, 0);
      }
    } else if(var_0 == "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6" || var_0 == "_encstr_BAC20FBEE6F88945F163A37BD68409923B") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (23503, -12799, -56);
        var_1.angles = (6, 359, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (45644, -11370, 160);
        var_1.angles = (0, 80, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (29280, 35546, 626);
        var_1.angles = (0, 148, 0);
      }
    } else if(var_0 == "_encstr_85DE05A6B2AC0E") {
      if(var_4 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        var_1.origin = (22781, -14070, -56);
        var_1.angles = (5, 86, 0);
      } else if(var_4 == "_encstr_93D20D28714743B99070632BAF3944") {
        var_1.origin = (46119, -11995, 168);
        var_1.angles = (0, 4, 0);
      } else if(var_4 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_1.origin = (30351, 34420, 593);
        var_1.angles = (0, 31, 0);
      }
    } else
      return;
  }

  var_6 = [[var_3.spawncallback]](var_1, var_2);

  if(isDefined(var_6))
    vehicle_spawn_registerinstance(var_6);

  return var_6;
}

vehicle_spawn_deregisterinstance(var_0, var_1) {
  var_2 = vehicle_spawn_getleveldata();

  if(isDefined(var_2.instancesbyref[var_0]))
    var_2.instancesbyref[var_0][var_1] = undefined;
}

vehicle_spawn_removespawnstructswithflag(var_0, var_1) {
  if(getdvarint("_encstr_B6C01692FEB5A13EB0F0E7E7C929F80A6F819F02DF3B7B4E", 0) == 1)
    return var_0;

  var_2 = 1 >> var_1 - 1;
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5.spawnflags) && var_5.spawnflags &var_2) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

vehicle_spawn_gamemodesupportsrespawn() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_8E1318E912B74D912D942347ADD240B763DBE3373A977F38C366")]]();
}

vehicle_spawn_init() {
  var_0 = spawnStruct();
  level.vehicle.spawn = var_0;
  var_0.maxinstancecount = 128;
  var_0.databyref = [];
  var_0.instancesbyref = [];
  var_0.spawnfromstructsdelayornotify = 5;
  var_0._id_12CA2 = getdvarint("_encstr_AD8820DA61D6D60B579FBBB9BF0A7EF3F01942A805DF95B5DEA3C18B2BD30E80EB77", 0);
  var_0.argshave = getdvarint("_encstr_849624967E02F129A64E12A0E08A78FB8B855080F62850E13315A73DCB798F0B69CB8BAF8B49", 0);
  var_0._id_12CA1 = getdvarint("_encstr_B6F81893B84549533936F8E1CCA03B0F99701ADA2071BF63911B", 60);
  var_0.areplayersnear = getdvarint("_encstr_883F1CA00AA2FF69C331606D07CBD14103F2F088E2FD33878755FDD0F54B", 30);
  vehicle_spawn_initspawnclearance();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_88C5055208731B")]]();
  vehicle_spawn_initlate();
}

vehicle_spawn_initlate() {
  thread vehicle_spawn_spawnfromstructs();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_BAF609D2739647C4853A2B")]]();
}

vehicle_spawn_spawnfromstructs() {
  if(istrue(level.modecontrolledvehiclespawningonly)) {
    return;
  }
  var_0 = vehicle_spawn_getleveldata();

  if(isstring(var_0.spawnfromstructsdelayornotify))
    level waittill(var_0.spawnfromstructsdelayornotify);
  else
    wait(var_0.spawnfromstructsdelayornotify);

  var_1 = [];

  foreach(var_3 in var_0.databyref) {
    if(isDefined(var_3.getspawnstructscallback)) {
      var_3.priority = clamp(var_3.priority, 0, 100);
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size > 0) {
    if(var_1.size > 1)
      var_1 = scripts\engine\utility::array_sort_with_func(var_1, ::vehicle_spawn_spawnfromstructscomparefunc);

    var_5 = isDefined(scripts\cp_mp\utility\game_utility::getlocaleid());

    if(vehicle_spawn_iscodevehicletest())
      var_5 = 0;

    foreach(var_3 in var_1) {
      var_7 = [[var_3.getspawnstructscallback]]();

      foreach(var_9 in var_7) {
        if(var_5) {
          if(!isDefined(var_9.script_noteworthy) || isDefined(var_9.script_noteworthy) && var_9.script_noteworthy != level.localeid)
            continue;
        }

        if(vehicle_spawn_canspawnVehicle(var_3.ref)) {
          var_10 = spawnStruct();
          var_10.origin = var_9.origin;
          var_10.angles = var_9.angles;
          var_10.spawntype = "_encstr_8A0A063CE0EB0DC9";
          var_11 = spawnStruct();
          var_12 = vehicle_spawn_spawnVehicle(var_3.ref, var_10, var_11);

          if(!isDefined(var_12)) {}

          continue;
        }

        break;
      }
    }
  }
}

vehicle_spawn_spawnfromstructscomparefunc(var_0, var_1) {
  return var_0.priority >= var_1.priority;
}

vehicle_spawn_registerinstance(var_0) {
  var_1 = vehicle_spawn_getleveldata();

  if(!isDefined(var_1.instancesbyref[var_0.vehiclename]))
    var_1.instancesbyref[var_0.vehiclename] = [];

  var_1.instancesbyref[var_0.vehiclename][var_0 getentitynumber()] = var_0;
}

vehicle_spawn_getleveldata() {
  return level.vehicle.spawn;
}

vehicle_spawn_getinstancecount() {
  var_0 = vehicle_spawn_getleveldata();
  var_1 = 0;

  foreach(var_3 in var_0.instancesbyref)
  var_1 = var_1 + var_3.size;

  return var_1;
}

vehicle_spawn_getinstancecountforref(var_0) {
  var_1 = vehicle_spawn_getleveldata();
  var_2 = 0;

  if(isDefined(var_1.instancesbyref[var_0]))
    var_2 = var_1.instancesbyref[var_0].size;

  return var_2;
}

vehicle_spawn_isvehiclespawnStruct() {
  var_0 = self.targetname;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_87470AEB7203514BD3DF73DA":
      case "_encstr_BA6A107318F7349308AE797CA89333BE37B8":
      case "_encstr_9B910F8E2C36937BD956E47DCDC10BEECD":
      case "_encstr_8BBC121759BF58D32203D8F86ABCCF134BF91C80":
      case "_encstr_969116B695914BD55B8E9C5837DCC1DE4E1DF5E638B0EEDC":
      case "_encstr_827911362D47E8C6CA26A539197D37C116DD37":
      case "_encstr_843D107B1B7442B41899357C7608F86AD4BD":
      case "_encstr_9AF01563B09CB395A39358E6B9E0DB39A3FAE6C116DDCD":
      case "_encstr_9B1A0BCA9B29FF2703F3124BE0":
      case "_encstr_A25612D42F20D32B9B9B2B7BFFF2D1D347E853F6":
      case "_encstr_AD8D0DA07A28AAC42337DBB8BB6F45":
      case "_encstr_B26E0D5E6883E36A4ECFA7A39BF4A2":
      case "_encstr_85A91140D1CA87553BD33F571247EFC9616BB3":
      case "_encstr_BE7E0A0F2843CFA3792F7B35":
      case "_encstr_92C211580E8D275DDCE62D2C73EB6EE00BBBB9":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

vehicle_spawn_initspawnclearance() {
  var_0 = vehicle_spawn_getleveldata();
  var_0.clearancecheckminradii = [];
}

vehicle_spawn_checkspawnclearance(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_spawn_getleveldata();
  var_6 = 200;
  var_7 = 200;
  var_8 = vehicle_spawn_getleveldataforvehicle(var_1);
  var_9 = var_8.clearancecheckminradius;

  if(!isDefined(var_9))
    var_9 = var_5.clearancecheckminradii[var_1];

  if(isDefined(var_8.clearancecheckradius))
    var_6 = var_8.clearancecheckradius;

  if(isDefined(var_8.clearancecheckheight))
    var_7 = var_8.clearancecheckheight;

  if(isDefined(var_4))
    var_0 = var_0 + (0, 0, var_4);

  var_10 = (var_6, var_6, var_7);
  var_11 = var_0 - var_10;
  var_12 = var_0 + var_10;
  var_13 = var_2;

  if(!isDefined(var_13))
    var_13 = physics_createcontents(["_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);

  var_14 = var_3;

  if(!isDefined(var_14)) {
    var_14 = [];
    var_14[var_14.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_8F2C0AB2DA1CD74639B7372B");
    var_14[var_14.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_B270105ECB28E94BC5CFABAB937D524C5053");

    if(isDefined(level.supportdrones))
      var_14[var_14.size] = level.supportdrones;

    var_14 = scripts\engine\utility::array_combine_multiple(var_14);
  }

  var_15 = physics_aabbbroadphasequery(var_11, var_12, var_13, var_14);

  if(isDefined(var_15) && var_15.size > 0) {
    foreach(var_17 in var_15) {
      if(isDefined(var_17.vehiclename)) {
        var_18 = vehicle_spawn_getleveldataforvehicle(var_17.vehiclename);
        var_19 = undefined;

        if(isDefined(var_18))
          var_19 = var_18.clearancecheckminradius;

        if(!isDefined(var_19))
          var_19 = var_5.clearancecheckminradii[var_17.vehiclename];

        if(!isDefined(var_19)) {
          continue;
        }
        var_20 = pow(var_9 + var_19, 2);

        if(isDefined(var_20) && var_20 < distance2dsquared(var_17.origin, var_0)) {
          continue;
        }
        return 0;
      }
    }
  }

  return 1;
}

vehicle_spawn_setclearancecheckminradius(var_0, var_1) {
  var_2 = vehicle_spawn_getleveldata();
  var_3 = vehicle_spawn_getleveldataforvehicle(var_0);

  if(isDefined(var_3)) {
    var_3.clearancecheckminradius = var_1;
    return;
  }

  var_2.clearancecheckminradii[var_0] = var_1;
}

_id_1421C(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_97C12036E933E15B8D69208052A71B187FAFC4BD4897298137710898FBFAC3F3832B");
  var_3 = vehicle_spawn_getleveldataforvehicle(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_3.spawncallback)) {
    return;
  }
  var_4 = vehicle_spawn_getleveldata();
  var_5 = undefined;

  if(var_4._id_12CA2 != 0)
    var_5 = var_4._id_12CA2;
  else if(isDefined(var_3._id_12CA1))
    var_5 = var_3._id_12CA1;
  else
    var_5 = var_4._id_12CA1;

  if(var_5 >= 1) {
    if(var_5 >= 9999)
      return undefined;
  } else
    var_5 = 1;

  for(;;) {
    wait(var_5);

    if(vehicle_spawn_canspawnVehicle(var_0)) {
      if(vehicle_spawn_checkspawnclearance(var_1.origin, var_0)) {
        var_6 = vehicle_spawn_spawnVehicle(var_0, var_1, var_2);

        if(!isDefined(var_6)) {
          continue;
        }
        return var_6;
      }
    }
  }
}

_id_14219(var_0) {
  var_0.ondeathrespawn = undefined;
}

_id_14212() {
  level notify("_encstr_97C12036E933E15B8D69208052A71B187FAFC4BD4897298137710898FBFAC3F3832B");
}

_id_14214() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_97842141BA1F15C945FC5B2FF56AE8E89B035B0D3287D8F81DDE53493C1458A5478B33")]]();
}

_id_1421D() {
  if(istrue(self.isdestroyed)) {
    return;
  }
  if(istrue(self.matchdata_level)) {
    return;
  }
  var_0 = vehicle_spawn_getleveldataforvehicle(self.vehiclename);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.arenavday)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B4B818A07BE5A1AE97316DEE68D7B04741B2A0C832FF27C0B75C");
  var_1 = vehicle_spawn_getleveldata();
  var_2 = undefined;

  if(var_1.argshave != 0)
    var_2 = var_1.argshave;
  else if(isDefined(var_0.areplayersnear))
    var_2 = var_0.areplayersnear;
  else
    var_2 = var_1.areplayersnear;

  if(var_2 >= 1) {
    if(var_2 >= 9999)
      return;
  } else
    var_2 = 1;

  wait(var_2);
  thread _id_14210();
}

_id_1421A() {
  self notify("_encstr_B4B818A07BE5A1AE97316DEE68D7B04741B2A0C832FF27C0B75C");
}

_id_14210() {
  _id_1421A();
  self.matchdata_level = 1;
  var_0 = vehicle_spawn_getleveldataforvehicle(self.vehiclename);
  self thread[[var_0.arenavday]]();
}

_id_14211() {
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_14152();

  if(var_0 != "_encstr_B846067B175AA56A") {
    var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414B(self);

    if(isDefined(var_1)) {
      self.health = int(min(var_1, self.health));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
    }

    scripts\cp_mp\vehicles\vehicle_damage::_id_14177("_encstr_B846067B175AA56A", var_0);
  }
}

vehicle_spawn_iscodevehicletest() {
  var_0 = level.codevehicletest;

  if(!isDefined(var_0)) {
    var_0 = getdvarint("_encstr_A57C149FF75BD098E7973957FFD8F076127759CBDF63", 0) == 1;

    if(var_0 && vehicle_spawn_iscodevehicletestlevel())
      var_0 = 1;
    else
      var_0 = 0;

    level.codevehicletest = var_0;
  }

  return var_0;
}

vehicle_spawn_iscodevehicletestlevel() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_0) {
    case "_encstr_93D20D28714743B99070632BAF3944":
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      return 1;
    default:
      return 0;
  }
}

_id_14215() {}