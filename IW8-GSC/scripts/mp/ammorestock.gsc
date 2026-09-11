/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ammorestock.gsc
***********************************************/

function init() {
  if(!challengesenabled()) {
    return;
  }

  if(scripts\cp\utility::getgametype() == "br") {
    setupchallengelocales(level);
    return;
  }
}

function setupchallengelocales() {
  level.localetriggers = [];
  var_0 = getEntArray("locale_area_trigger", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }

      switch (var_2.script_noteworthy) {
        case "downtown":
          var_2.localeid = 0;
          break;
        case "stadium":
          var_2.localeid = 1;
          break;
        case "tvstation":
          var_2.localeid = 2;
          break;
        case "hospital":
          var_2.localeid = 3;
          break;
        case "airport":
          var_2.localeid = 4;
          break;
        case "dam":
          var_2.localeid = 5;
          break;
        case "scrapyard":
          var_2.localeid = 6;
          break;
        case "trainstation":
          var_2.localeid = 7;
          break;
        case "quarry":
          var_2.localeid = 8;
          break;
        case "lumbermill":
          var_2.localeid = 9;
          break;
        case "port":
          var_2.localeid = 10;
          break;
        case "gulag":
          var_2.localeid = 11;
          break;
      }
    }

    level.localetriggers = var_0;
    return;
  }
}

function challengesenabled() {
  if(getdvarint("force_disable_aeevents", 0) != 0) {
    return 0;
  }

  return level.challengesallowed;
}

function challengesenabledforplayer() {
  if(!challengesenabled()) {
    return false;
  }

  if(!isPlayer(self) || isai(self)) {
    return false;
  }

  return true;
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = var_0;
    } else {
      return;
    }
  }

  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_8)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_5);

    if(!isDefined(var_9)) {
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_5.basename);
    }

    switch (var_9) {
      case "iw8_health_marker_cp":
      case "iw8_adrenaline_marker_cp":
      case "iw8_armor_marker_cp":
      case "iw8_ammo_marker_cp":
        var_9 = "support_box_mp";
        break;
      default:
        break;
    }

    var_10 = "";

    if(isDefined(var_1.secondaryweaponobj)) {
      if(var_5 == var_1.primaryweaponobj) {
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
      } else if(var_5 == var_1.secondaryweaponobj) {
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
      }
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_7)) {
      var_12 = var_7["mask"];
      var_13 = var_7["mask2"];
    }

    var_14 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15)) {
      var_15 = getDvar("NKTMKRMSKR");
    }

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "";
    var_18 = 1;

    if(isDefined(var_5.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_5.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "scope") {
          var_19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var_5, var_22)) {
          if(!var_18) {
            var_17 += "|";
          }

          var_22 = scripts\cp\cp_weapon::ref_12bbb(var_22);
          var_17 += var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18) {
          var_17 += "|";
        }

        var_17 += "default_sniper_scope";
      }
    }

    var_24 = "";
    var_25 = 1;

    if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
      foreach(var_27 in var_1.classstruct.loadoutperks) {
        if(!var_25) {
          var_24 += "|";
        }

        var_24 += var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_2, 0];
    var_30 = 0;

    if(isPlayer(var_8)) {
      var_30 |= 1;
    } else if(isagent(var_8)) {
      var_30 = ref_12ce0(var_30, var_8);
    }

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_6)) {
      if(scripts\cp\utility::isheadshot(var_5, var_6, var_4, var_1)) {
        var_4 = "MOD_HEAD_SHOT";
      }
    }

    if(isDefined(var_8.streakinfo)) {
      var_30 |= 2;
      var_35 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_35);

      switch (var_35) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var_31 = 1;
          break;
        case "nuke":
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
          var_32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var_32 = 1;
          var_33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var_33 = 1;
          break;
      }

      if(var_31) {
        var_30 |= 8;
      }

      if(var_32) {
        var_30 |= 4;
      }

      if(var_33) {
        var_30 |= 16;
      }
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 |= 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var_30 |= 8;
      }
    }

    if(isDefined(var_8.equipmentref)) {
      var_30 |= 64;
    }

    var_36 = "";
    var_37 = 65535;
    var_38 = 65535;

    if(var_30 == 512) {
      vehicle_occupancy_canspawninto(var_1, var_8, var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, var_4, var_37, var_38);
      return;
    }

    var_39 = level.players.size;

    if(istrue(level.matchmakingmatch)) {
      var_40 = var_1 getfireteammembers();
      var_39 = var_40.size;
    }

    var_1 reportchallengeuserevent("kill", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, gettouchinglocaletriggers(var_1, var_8), var_4, var_37, var_38, var_39);
    return;
  }
}

function ref_12ce0(var_0, var_1) {
  var_2 = var_1.aitype;

  if(!isDefined(var_1.aitype)) {
    if(isDefined(var_1.unittype)) {
      var_2 = var_1.unittype;
    }
  }

  switch (var_2) {
    case "soldier":
      var_0 |= 128;
      break;
    case "juggernaut":
      var_0 |= 512;
      break;
    case "suicidebomber":
      var_0 |= 1024;
      break;
    case "riotshield":
      var_0 |= 256;
      break;
    default:
      var_0 |= 128;
      break;
  }

  return var_0;
}

function vehicle_occupancy_canspawninto(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(var_10 != 512) {
    return false;
  }

  if(isDefined(var_1.attackers)) {
    foreach(var_16 in var_1.attackers) {
      if(!isDefined(scripts\cp\cp_agent_damage::_validateattacker(var_16))) {
        continue;
      }

      if(var_1 == var_16) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      var_17 = undefined;

      if(isDefined(var_1.attackerdata)) {
        var_18 = var_1.attackerdata[var_16.guid];

        if(isDefined(var_18)) {
          var_17 = var_18.objweapon;
        }
      }

      var_19 = 0;

      if(self.attackerdata[var_16.guid].damage >= var_1.maxhealth * 0.1) {
        var_19 = 1;
      }

      if(self.attackerdata[var_16.guid].damage >= var_1.maxhealth * 0.2) {
        var_19 = 2;
      }

      if(var_19 >= 1) {
        var_20 = level.players.size;

        if(istrue(level.matchmakingmatch)) {
          var_21 = var_0 getfireteammembers();
          var_20 = var_21.size;
        }

        var_16 reportchallengeuserevent("kill", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, gettouchinglocaletriggers(var_0, var_1), var_12, var_13, var_14, var_20);
      }
    }

    return true;
  }

  return false;
}

function ondeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("death", 0);
}

function onplayerkillassist(var_0) {
  var_1 = self;

  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_0)) {
    var_2 = "";

    if(isDefined(var_1.primaryweaponobj)) {
      var_2 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
    }

    var_3 = "";

    if(isDefined(var_1.secondaryweaponobj)) {
      var_3 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
    }

    var_4 = [var_2, var_3];
    var_5 = [0, 0];
    var_6 = 0;

    if(isPlayer(var_0)) {
      var_6 |= 1;
    } else if(isagent(var_0)) {
      var_6 = ref_12ce0(var_6, var_0);
    }

    var_7 = resetstuckthermite(var_1);
    var_1 reportchallengeuserevent("assist", var_5, var_4, var_7);
    return;
  }
}

function ref_1204a(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_7 = var_0;
  var_8 = var_1;
  var_9 = var_2;
  var_10 = var_3;
  var_11 = var_4;
  var_12 = var_5;
  var_13 = var_6;
  var_14 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();

  switch (var_7) {
    case "cp_used_adrenaline":
    case "cp_used_grenade_crate":
    case "cp_used_armor":
    case "cp_used_ammo_crate":
      var_7 = "support_box_mp";

      if(var_10 == 0) {
        var_10++;
      }

      break;
    default:
      break;
  }

  var_15 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("killstreak_end", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
}

function ref_12033(var_0, var_1) {
  var_2 = var_0;

  if(var_0 == "super_recon_drone" && isDefined(self.recondronesuper)) {
    if(isDefined(self.recondronesuper.ref_1406b)) {
      var_1 = self.recondronesuper.ref_1406b;
    }
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12032(var_0, var_1);
}

function ref_12032(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_2 = var_0;
  var_3 = var_1;
  self reportchallengeuserevent("field_end", var_2, var_3);
}

function ref_12003(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = scripts\cp\utility::getgametype();

  if(!isDefined(var_3)) {
    var_3 = getDvar("NKTMKRMSKR");
  }

  var_4 = level.getallselectableattachments.game_type_col[var_3];
  self reportchallengeuserevent("capture", var_4, var_1, var_2);
}

function ref_1201f(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = scripts\cp\utility::getgametype();

  if(!isDefined(var_3)) {
    var_3 = getDvar("NKTMKRMSKR");
  }

  var_4 = level.getallselectableattachments.game_type_col[var_3];
  self reportchallengeuserevent("defuse", var_4, var_1, var_2);
}

function ref_12062(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("defuse", var_3, var_1, var_2, var_4);
}

function ref_12096(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("stun", var_0);
}

function ref_12092(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("stim", var_0);
}

function ref_1203d(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = "";
  var_2 = 1;

  if(isDefined(self.classstruct) && isDefined(self.classstruct.loadoutperks)) {
    foreach(var_4 in self.classstruct.loadoutperks) {
      if(!var_2) {
        var_1 += "|";
      }

      var_1 += var_4;
      var_2 = 0;
    }
  }

  self reportchallengeuserevent("hack", var_0, var_1);
}

function gettouchinglocaletriggers(var_0, var_1) {
  var_2 = "";

  if(!isDefined(level.localetriggers)) {
    return var_2;
  }

  var_3 = 0;

  foreach(var_5 in level.localetriggers) {
    if(var_0 istouching(var_5) || var_1 istouching(var_5)) {
      if(isDefined(var_5.localeid)) {
        if(var_3) {
          var_2 += "|";
        }

        var_2 += var_5.localeid;
        var_3 = 1;
      }
    }
  }

  return var_2;
}

function onplayerteamrevive(var_0, var_1) {}

function onsuccessfulhit(var_0) {}

function onspawn() {}

function updatesuperweaponkills(var_0, var_1) {}

function updatesuperkills(var_0, var_1, var_2) {}

function resistedstun(var_0) {}

function triggereddelayedexplosion() {}

function minedestroyed(var_0, var_1, var_2) {}

function roundbegin() {}

function roundend(var_0) {}

function playerdamaged(var_0, var_1, var_2, var_3, var_4, var_5) {}

function processuavassist(var_0, var_1) {}

function killstreakdamaged(var_0, var_1, var_2, var_3, var_4) {}

function killstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer(var_3)) {
    return;
  }

  var_8 = self;

  if(!isPlayer(var_3)) {
    return;
  }

  if(!isDefined(var_8.owner)) {
    return;
  }

  if(!scripts\cp\utility\player::isfriendly(var_3.team, var_8.owner)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_6);

    if(!isDefined(var_9)) {
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_6.basename);
    }

    var_10 = "";

    if(isDefined(var_3.secondaryweaponobj)) {
      if(var_6 == var_3.primaryweaponobj) {
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_3.secondaryweaponobj.basename);
      } else if(var_6 == var_3.secondaryweaponobj) {
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_3.primaryweaponobj.basename);
      }
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_3.modifiers)) {
      var_12 = var_3.modifiers["mask"];
      var_13 = var_3.modifiers["mask2"];
    }

    var_14 = [var_3 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_3.team), var_3 scripts\cp\survival\survival_loadout::lookupotheroperator(var_3.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15)) {
      var_15 = getDvar("NKTMKRMSKR");
    }

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "";
    var_18 = 1;

    if(isDefined(var_6.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_6.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "scope") {
          var_19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var_6, var_22)) {
          if(var_22 == "scope") {
            var_22 = "default_sniper_scope";
          }

          if(!var_18) {
            var_17 += "|";
          }

          var_22 = scripts\cp\cp_weapon::ref_12bbb(var_22);
          var_17 += var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18) {
          var_17 += "|";
        }

        var_17 += "default_sniper_scope";
      }
    }

    var_24 = "";
    var_25 = 1;

    if(isDefined(var_3.classstruct) && isDefined(var_3.classstruct.loadoutperks)) {
      foreach(var_27 in var_3.classstruct.loadoutperks) {
        if(!var_25) {
          var_24 += "|";
        }

        var_24 += var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_4, 0];
    var_30 = 0;

    if(isPlayer(var_8)) {
      var_30 |= 1;
    } else if(isagent(var_8)) {
      var_30 = ref_12ce0(var_30, var_8);
    }

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_8.streakinfo)) {
      var_30 |= 2;
      var_0 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_0);

      switch (var_0) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var_31 = 1;
          break;
        case "nuke":
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
          var_32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var_32 = 1;
          var_33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var_33 = 1;
          break;
      }

      if(var_31) {
        var_30 |= 8;
      }

      if(var_32) {
        var_30 |= 4;
      }

      if(var_33) {
        var_30 |= 16;
      }
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 |= 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var_30 |= 8;
      }
    }

    if(isDefined(var_8.equipmentref)) {
      var_30 |= 64;
    }

    var_35 = "";
    var_3 reportchallengeuserevent("kill", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_35, gettouchinglocaletriggers(var_3, var_8));
    return;
  }
}

function unsetreduceregendelayonkill(var_0) {
  switch (var_0) {
    case "sentry_gun":
    case "manual_turret":
    case "cruise_predator":
    case "juggernaut":
      return false;
  }

  return true;
}

function equipmentdestroyed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = var_0;
    } else {
      return;
    }
  }

  if(!isDefined(var_8.owner)) {
    return;
  }

  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_8.owner)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_5);

    if(!isDefined(var_9)) {
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_5.basename);
    }

    var_10 = "";

    if(var_5 == var_1.primaryweaponobj) {
      var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
    } else if(var_5 == var_1.secondaryweaponobj) {
      var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_7)) {
      var_12 = var_7["mask"];
      var_13 = var_7["mask2"];
    }

    var_14 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15)) {
      var_15 = getDvar("NKTMKRMSKR");
    }

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "";
    var_18 = 1;

    if(isDefined(var_5.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_5.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "scope") {
          var_19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var_5, var_22)) {
          if(!var_18) {
            var_17 += "|";
          }

          var_22 = scripts\cp\cp_weapon::ref_12bbb(var_22);
          var_17 += var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18) {
          var_17 += "|";
        }

        var_17 += "default_sniper_scope";
      }
    }

    var_24 = "";
    var_25 = 1;

    if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
      foreach(var_27 in var_1.classstruct.loadoutperks) {
        if(!var_25) {
          var_24 += "|";
        }

        var_24 += var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_2, 0];
    var_30 = 0;

    if(isPlayer(var_8)) {
      var_30 |= 1;
    } else if(isagent(var_8)) {
      var_30 = ref_12ce0(var_30, var_8);
    }

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_8.streakinfo)) {
      var_30 |= 2;
      var_35 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_35);

      switch (var_35) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var_31 = 1;
          break;
        case "nuke":
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
          var_32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var_32 = 1;
          var_33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var_33 = 1;
          break;
      }

      if(var_31) {
        var_30 |= 8;
      }

      if(var_32) {
        var_30 |= 4;
      }

      if(var_33) {
        var_30 |= 16;
      }
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 |= 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var_30 |= 8;
      }
    }

    if(isDefined(var_8.equipmentref)) {
      var_30 |= 64;
    }

    var_36 = "";
    var_1 reportchallengeuserevent("kill", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, gettouchinglocaletriggers(var_1, var_8));
    return;
  }
}

function vehiclekilled(var_0, var_1, var_2, var_3) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_4 = var_0;
  var_5 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_3);

  if(!isDefined(var_5)) {
    var_5 = scripts\cp\utility::relic_nuketimer_globalthread(var_3.basename);
  }

  var_6 = "";

  if(var_3 == var_1.primaryweaponobj) {
    var_6 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
  } else if(var_3 == var_1.secondaryweaponobj) {
    var_6 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
  }

  var_7 = [var_5, var_6];
  var_8 = 0;
  var_9 = 0;

  if(isDefined(var_1.modifiers)) {
    var_8 = var_1.modifiers["mask"];
    var_9 = var_1.modifiers["mask2"];
  }

  var_10 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
  var_11 = scripts\cp\utility::getgametype();

  if(!isDefined(var_11)) {
    var_11 = getDvar("NKTMKRMSKR");
  }

  var_12 = level.getallselectableattachments.game_type_col[var_11];
  var_13 = "";
  var_14 = 1;

  if(isDefined(var_3.attachments)) {
    var_15 = 0;

    foreach(var_17 in var_3.attachments) {
      var_18 = scripts\cp\utility::attachmentmap_tobase(var_17);

      if(var_18 == "scope") {
        var_15 = 1;
      }

      if(scripts\cp\cp_weapon::carriedpunchcard(var_3, var_18)) {
        if(var_18 == "scope") {
          var_18 = "default_sniper_scope";
        }

        if(!var_14) {
          var_13 += "|";
        }

        var_18 = scripts\cp\cp_weapon::ref_12bbb(var_18);
        var_13 += var_18;
        var_14 = 0;
      }
    }

    if(var_15) {
      if(!var_14) {
        var_13 += "|";
      }

      var_13 += "default_sniper_scope";
    }
  }

  var_20 = "";
  var_21 = 1;

  if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
    foreach(var_23 in var_1.classstruct.loadoutperks) {
      if(!var_21) {
        var_20 += "|";
      }

      var_20 += var_23;
      var_21 = 0;
    }
  }

  var_25 = [var_2, 0];
  var_26 = 0;

  if(isPlayer(var_4)) {
    var_26 |= 1;
  } else if(isagent(var_4)) {
    var_26 = ref_12ce0(var_26, var_4);
  }

  var_27 = 0;
  var_28 = 0;
  var_29 = 0;
  var_30 = 0;

  if(isDefined(var_4.streakinfo)) {
    var_26 |= 2;
    var_31 = var_4.streakinfo.streakname;
    var_30 = unsetreduceregendelayonkill(var_31);

    switch (var_31) {
      case "sentry_gun":
      case "pac_sentry":
      case "manual_turret":
      case "bradley":
      case "juggernaut":
        var_27 = 1;
        break;
      case "nuke":
      case "white_phosphorus":
      case "toma_strike":
      case "precision_airstrike":
      case "hover_jet":
      case "gunship":
      case "cruise_predator":
      case "chopper_support":
      case "chopper_gunner":
        var_28 = 1;
        break;
      case "scrambler_drone_guard":
      case "directional_uav":
      case "uav":
      case "radar_drone_overwatch":
        var_28 = 1;
        var_29 = 1;
        break;
      case "airdrop_multiple":
      case "airdrop":
        var_29 = 1;
        break;
    }

    if(var_27) {
      var_26 |= 8;
    }

    if(var_28) {
      var_26 |= 4;
    }

    if(var_29) {
      var_26 |= 16;
    }
  }

  if(isDefined(var_4.vehiclename) || var_30) {
    var_26 |= 32;

    if(!var_27 && isDefined(var_4.vehiclename) && !istrue(var_4 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
      var_26 |= 8;
    }
  }

  if(isDefined(var_4.equipmentref)) {
    var_26 |= 64;
  }

  var_32 = "";
  var_1 reportchallengeuserevent("kill", var_25, var_7, var_8, var_9, var_10, var_12, var_13, var_20, var_26, var_32, gettouchinglocaletriggers(var_1, var_4));
}

function processfinalkillchallenges(var_0, var_1) {}

function usedkillstreak(var_0) {}

function resetstuckthermite() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp\survival\survival_loadout::lookupcurrentoperator(self.team));
}

function ref_12071(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = var_0;
    } else {
      return;
    }
  }

  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_8)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_5);

    if(!isDefined(var_9)) {
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_5.basename);
    }

    var_10 = "";

    if(isDefined(var_1.secondaryweaponobj)) {
      if(var_5 == var_1.primaryweaponobj) {
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
      } else if(var_5 == var_1.secondaryweaponobj) {
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
      }
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_7)) {
      var_12 = var_7["mask"];
      var_13 = var_7["mask2"];
    }

    var_14 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15)) {
      var_15 = getDvar("NKTMKRMSKR");
    }

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "";
    var_18 = 1;

    if(isDefined(var_5.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_5.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "scope") {
          var_19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var_5, var_22)) {
          if(!var_18) {
            var_17 += "|";
          }

          var_22 = scripts\cp\cp_weapon::ref_12bbb(var_22);
          var_17 += var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18) {
          var_17 += "|";
        }

        var_17 += "default_sniper_scope";
      }
    }

    var_24 = "";
    var_25 = 1;

    if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
      foreach(var_27 in var_1.classstruct.loadoutperks) {
        if(!var_25) {
          var_24 += "|";
        }

        var_24 += var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_2, 0];
    var_30 = 0;

    if(isPlayer(var_8)) {
      var_30 |= 1;
    } else if(isagent(var_8)) {
      var_30 = ref_12ce0(var_30, var_8);
    }

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_8.streakinfo)) {
      var_30 |= 2;
      var_35 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_35);

      switch (var_35) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var_31 = 1;
          break;
        case "nuke":
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
          var_32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var_32 = 1;
          var_33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var_33 = 1;
          break;
      }

      if(var_31) {
        var_30 |= 8;
      }

      if(var_32) {
        var_30 |= 4;
      }

      if(var_33) {
        var_30 |= 16;
      }
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 |= 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var_30 |= 8;
      }
    }

    if(isDefined(var_8.equipmentref)) {
      var_30 |= 64;
    }

    var_36 = "";
    var_1 reportchallengeuserevent("kill", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, gettouchinglocaletriggers(var_1, var_8));
    return;
  }
}