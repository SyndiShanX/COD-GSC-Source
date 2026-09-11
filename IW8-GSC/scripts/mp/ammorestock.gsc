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
  var0 = getEntArray("locale_area_trigger", "targetname");

  if(isDefined(var0) && var0.size > 0) {
    foreach(var2 in var0) {
      if(!isDefined(var2.script_noteworthy)) {
        continue;
      }

      switch (var2.script_noteworthy) {
        case "downtown":
          var2.localeid = 0;
          break;
        case "stadium":
          var2.localeid = 1;
          break;
        case "tvstation":
          var2.localeid = 2;
          break;
        case "hospital":
          var2.localeid = 3;
          break;
        case "airport":
          var2.localeid = 4;
          break;
        case "dam":
          var2.localeid = 5;
          break;
        case "scrapyard":
          var2.localeid = 6;
          break;
        case "trainstation":
          var2.localeid = 7;
          break;
        case "quarry":
          var2.localeid = 8;
          break;
        case "lumbermill":
          var2.localeid = 9;
          break;
        case "port":
          var2.localeid = 10;
          break;
        case "gulag":
          var2.localeid = 11;
          break;
      }
    }

    level.localetriggers = var0;
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!challengesenabledforplayer(var1)) {
    return;
  }

  var8 = self;

  if(!isPlayer(var1)) {
    if(isDefined(var0) && isPlayer(var0)) {
      var1 = var0;
    } else {
      return;
    }
  }

  if(!scripts\cp\utility\player::isfriendly(var1.team, var8)) {
    var9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var5);

    if(!isDefined(var9)) {
      var9 = scripts\cp\utility::relic_nuketimer_globalthread(var5.basename);
    }

    switch (var9) {
      case "iw8_health_marker_cp":
      case "iw8_adrenaline_marker_cp":
      case "iw8_armor_marker_cp":
      case "iw8_ammo_marker_cp":
        var9 = "support_box_mp";
        break;
      default:
        break;
    }

    var10 = "";

    if(isDefined(var1.secondaryweaponobj)) {
      if(var5 == var1.primaryweaponobj) {
        var10 = scripts\cp\utility::relic_nuketimer_globalthread(var1.secondaryweaponobj.basename);
      } else if(var5 == var1.secondaryweaponobj) {
        var10 = scripts\cp\utility::relic_nuketimer_globalthread(var1.primaryweaponobj.basename);
      }
    }

    var11 = [var9, var10];
    var12 = 0;
    var13 = 0;

    if(isDefined(var7)) {
      var12 = var7["mask"];
      var13 = var7["mask2"];
    }

    var14 = [var1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var1.team), var1 scripts\cp\survival\survival_loadout::lookupotheroperator(var1.team)];
    var15 = scripts\cp\utility::getgametype();

    if(!isDefined(var15)) {
      var15 = getDvar("NKTMKRMSKR");
    }

    var16 = level.getallselectableattachments.game_type_col[var15];
    var17 = "";
    var18 = 1;

    if(isDefined(var5.attachments)) {
      var19 = 0;

      foreach(var21 in var5.attachments) {
        var22 = scripts\cp\utility::attachmentmap_tobase(var21);

        if(var22 == "scope") {
          var19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var5, var22)) {
          if(!var18) {
            var17 += "|";
          }

          var22 = scripts\cp\cp_weapon::ref_12bbb(var22);
          var17 += var22;
          var18 = 0;
        }
      }

      if(var19) {
        if(!var18) {
          var17 += "|";
        }

        var17 += "default_sniper_scope";
      }
    }

    var24 = "";
    var25 = 1;

    if(isDefined(var1.classstruct) && isDefined(var1.classstruct.loadoutperks)) {
      foreach(var27 in var1.classstruct.loadoutperks) {
        if(!var25) {
          var24 += "|";
        }

        var24 += var27;
        var25 = 0;
      }
    }

    var29 = [var2, 0];
    var30 = 0;

    if(isPlayer(var8)) {
      var30 |= 1;
    } else if(isagent(var8)) {
      var30 = ref_12ce0(var30, var8);
    }

    var31 = 0;
    var32 = 0;
    var33 = 0;
    var34 = 0;

    if(isDefined(var6)) {
      if(scripts\cp\utility::isheadshot(var5, var6, var4, var1)) {
        var4 = "MOD_HEAD_SHOT";
      }
    }

    if(isDefined(var8.streakinfo)) {
      var30 |= 2;
      var35 = var8.streakinfo.streakname;
      var34 = unsetreduceregendelayonkill(var35);

      switch (var35) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var31 = 1;
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
          var32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var32 = 1;
          var33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var33 = 1;
          break;
      }

      if(var31) {
        var30 |= 8;
      }

      if(var32) {
        var30 |= 4;
      }

      if(var33) {
        var30 |= 16;
      }
    }

    if(isDefined(var8.vehiclename) || var34) {
      var30 |= 32;

      if(!var31 && isDefined(var8.vehiclename) && !istrue(var8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var30 |= 8;
      }
    }

    if(isDefined(var8.equipmentref)) {
      var30 |= 64;
    }

    var36 = "";
    var37 = 65535;
    var38 = 65535;

    if(var30 == 512) {
      vehicle_occupancy_canspawninto(var1, var8, var29, var11, var12, var13, var14, var16, var17, var24, var30, var36, var4, var37, var38);
      return;
    }

    var39 = level.players.size;

    if(istrue(level.matchmakingmatch)) {
      var40 = var1 getfireteammembers();
      var39 = var40.size;
    }

    var1 reportchallengeuserevent("kill", var29, var11, var12, var13, var14, var16, var17, var24, var30, var36, gettouchinglocaletriggers(var1, var8), var4, var37, var38, var39);
    return;
  }
}

function ref_12ce0(var0, var1) {
  var2 = var1.aitype;

  if(!isDefined(var1.aitype)) {
    if(isDefined(var1.unittype)) {
      var2 = var1.unittype;
    }
  }

  switch (var2) {
    case "soldier":
      var0 |= 128;
      break;
    case "juggernaut":
      var0 |= 512;
      break;
    case "suicidebomber":
      var0 |= 1024;
      break;
    case "riotshield":
      var0 |= 256;
      break;
    default:
      var0 |= 128;
      break;
  }

  return var0;
}

function vehicle_occupancy_canspawninto(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  if(var10 != 512) {
    return false;
  }

  if(isDefined(var1.attackers)) {
    foreach(var16 in var1.attackers) {
      if(!isDefined(scripts\cp\cp_agent_damage::_validateattacker(var16))) {
        continue;
      }

      if(var1 == var16) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      var17 = undefined;

      if(isDefined(var1.attackerdata)) {
        var18 = var1.attackerdata[var16.guid];

        if(isDefined(var18)) {
          var17 = var18.objweapon;
        }
      }

      var19 = 0;

      if(self.attackerdata[var16.guid].damage >= var1.maxhealth * 0.1) {
        var19 = 1;
      }

      if(self.attackerdata[var16.guid].damage >= var1.maxhealth * 0.2) {
        var19 = 2;
      }

      if(var19 >= 1) {
        var20 = level.players.size;

        if(istrue(level.matchmakingmatch)) {
          var21 = var0 getfireteammembers();
          var20 = var21.size;
        }

        var16 reportchallengeuserevent("kill", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, gettouchinglocaletriggers(var0, var1), var12, var13, var14, var20);
      }
    }

    return true;
  }

  return false;
}

function ondeath(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("death", 0);
}

function onplayerkillassist(var0) {
  var1 = self;

  if(!challengesenabledforplayer(var1)) {
    return;
  }

  if(!scripts\cp\utility\player::isfriendly(var1.team, var0)) {
    var2 = "";

    if(isDefined(var1.primaryweaponobj)) {
      var2 = scripts\cp\utility::relic_nuketimer_globalthread(var1.primaryweaponobj.basename);
    }

    var3 = "";

    if(isDefined(var1.secondaryweaponobj)) {
      var3 = scripts\cp\utility::relic_nuketimer_globalthread(var1.secondaryweaponobj.basename);
    }

    var4 = [var2, var3];
    var5 = [0, 0];
    var6 = 0;

    if(isPlayer(var0)) {
      var6 |= 1;
    } else if(isagent(var0)) {
      var6 = ref_12ce0(var6, var0);
    }

    var7 = resetstuckthermite(var1);
    var1 reportchallengeuserevent("assist", var5, var4, var7);
    return;
  }
}

function ref_1204a(var0, var1, var2, var3, var4, var5, var6) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var7 = var0;
  var8 = var1;
  var9 = var2;
  var10 = var3;
  var11 = var4;
  var12 = var5;
  var13 = var6;
  var14 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();

  switch (var7) {
    case "cp_used_adrenaline":
    case "cp_used_grenade_crate":
    case "cp_used_armor":
    case "cp_used_ammo_crate":
      var7 = "support_box_mp";

      if(var10 == 0) {
        var10++;
      }

      break;
    default:
      break;
  }

  var15 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("killstreak_end", var7, var8, var9, var10, var11, var12, var13, var14, var15);
}

function ref_12033(var0, var1) {
  var2 = var0;

  if(var0 == "super_recon_drone" && isDefined(self.recondronesuper)) {
    if(isDefined(self.recondronesuper.ref_1406b)) {
      var1 = self.recondronesuper.ref_1406b;
    }
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12032(var0, var1);
}

function ref_12032(var0, var1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var2 = var0;
  var3 = var1;
  self reportchallengeuserevent("field_end", var2, var3);
}

function ref_12003(var0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var1 = 0;
  var2 = 0;

  if(isDefined(var0)) {
    var1 = var0["mask"];
    var2 = var0["mask2"];
  }

  var3 = scripts\cp\utility::getgametype();

  if(!isDefined(var3)) {
    var3 = getDvar("NKTMKRMSKR");
  }

  var4 = level.getallselectableattachments.game_type_col[var3];
  self reportchallengeuserevent("capture", var4, var1, var2);
}

function ref_1201f(var0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var1 = 0;
  var2 = 0;

  if(isDefined(var0)) {
    var1 = var0["mask"];
    var2 = var0["mask2"];
  }

  var3 = scripts\cp\utility::getgametype();

  if(!isDefined(var3)) {
    var3 = getDvar("NKTMKRMSKR");
  }

  var4 = level.getallselectableattachments.game_type_col[var3];
  self reportchallengeuserevent("defuse", var4, var1, var2);
}

function ref_12062(var0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var1 = 0;
  var2 = 0;

  if(isDefined(var0)) {
    var1 = var0["mask"];
    var2 = var0["mask2"];
  }

  var3 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  var4 = resetstuckthermite();
  self reportchallengeuserevent("defuse", var3, var1, var2, var4);
}

function ref_12096(var0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("stun", var0);
}

function ref_12092(var0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("stim", var0);
}

function ref_1203d(var0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var1 = "";
  var2 = 1;

  if(isDefined(self.classstruct) && isDefined(self.classstruct.loadoutperks)) {
    foreach(var4 in self.classstruct.loadoutperks) {
      if(!var2) {
        var1 += "|";
      }

      var1 += var4;
      var2 = 0;
    }
  }

  self reportchallengeuserevent("hack", var0, var1);
}

function gettouchinglocaletriggers(var0, var1) {
  var2 = "";

  if(!isDefined(level.localetriggers)) {
    return var2;
  }

  var3 = 0;

  foreach(var5 in level.localetriggers) {
    if(var0 istouching(var5) || var1 istouching(var5)) {
      if(isDefined(var5.localeid)) {
        if(var3) {
          var2 += "|";
        }

        var2 += var5.localeid;
        var3 = 1;
      }
    }
  }

  return var2;
}

function onplayerteamrevive(var0, var1) {}

function onsuccessfulhit(var0) {}

function onspawn() {}

function updatesuperweaponkills(var0, var1) {}

function updatesuperkills(var0, var1, var2) {}

function resistedstun(var0) {}

function triggereddelayedexplosion() {}

function minedestroyed(var0, var1, var2) {}

function roundbegin() {}

function roundend(var0) {}

function playerdamaged(var0, var1, var2, var3, var4, var5) {}

function processuavassist(var0, var1) {}

function killstreakdamaged(var0, var1, var2, var3, var4) {}

function killstreakkilled(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!challengesenabledforplayer(var3)) {
    return;
  }

  var8 = self;

  if(!isPlayer(var3)) {
    return;
  }

  if(!isDefined(var8.owner)) {
    return;
  }

  if(!scripts\cp\utility\player::isfriendly(var3.team, var8.owner)) {
    var9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var6);

    if(!isDefined(var9)) {
      var9 = scripts\cp\utility::relic_nuketimer_globalthread(var6.basename);
    }

    var10 = "";

    if(isDefined(var3.secondaryweaponobj)) {
      if(var6 == var3.primaryweaponobj) {
        var10 = scripts\cp\utility::relic_nuketimer_globalthread(var3.secondaryweaponobj.basename);
      } else if(var6 == var3.secondaryweaponobj) {
        var10 = scripts\cp\utility::relic_nuketimer_globalthread(var3.primaryweaponobj.basename);
      }
    }

    var11 = [var9, var10];
    var12 = 0;
    var13 = 0;

    if(isDefined(var3.modifiers)) {
      var12 = var3.modifiers["mask"];
      var13 = var3.modifiers["mask2"];
    }

    var14 = [var3 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var3.team), var3 scripts\cp\survival\survival_loadout::lookupotheroperator(var3.team)];
    var15 = scripts\cp\utility::getgametype();

    if(!isDefined(var15)) {
      var15 = getDvar("NKTMKRMSKR");
    }

    var16 = level.getallselectableattachments.game_type_col[var15];
    var17 = "";
    var18 = 1;

    if(isDefined(var6.attachments)) {
      var19 = 0;

      foreach(var21 in var6.attachments) {
        var22 = scripts\cp\utility::attachmentmap_tobase(var21);

        if(var22 == "scope") {
          var19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var6, var22)) {
          if(var22 == "scope") {
            var22 = "default_sniper_scope";
          }

          if(!var18) {
            var17 += "|";
          }

          var22 = scripts\cp\cp_weapon::ref_12bbb(var22);
          var17 += var22;
          var18 = 0;
        }
      }

      if(var19) {
        if(!var18) {
          var17 += "|";
        }

        var17 += "default_sniper_scope";
      }
    }

    var24 = "";
    var25 = 1;

    if(isDefined(var3.classstruct) && isDefined(var3.classstruct.loadoutperks)) {
      foreach(var27 in var3.classstruct.loadoutperks) {
        if(!var25) {
          var24 += "|";
        }

        var24 += var27;
        var25 = 0;
      }
    }

    var29 = [var4, 0];
    var30 = 0;

    if(isPlayer(var8)) {
      var30 |= 1;
    } else if(isagent(var8)) {
      var30 = ref_12ce0(var30, var8);
    }

    var31 = 0;
    var32 = 0;
    var33 = 0;
    var34 = 0;

    if(isDefined(var8.streakinfo)) {
      var30 |= 2;
      var0 = var8.streakinfo.streakname;
      var34 = unsetreduceregendelayonkill(var0);

      switch (var0) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var31 = 1;
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
          var32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var32 = 1;
          var33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var33 = 1;
          break;
      }

      if(var31) {
        var30 |= 8;
      }

      if(var32) {
        var30 |= 4;
      }

      if(var33) {
        var30 |= 16;
      }
    }

    if(isDefined(var8.vehiclename) || var34) {
      var30 |= 32;

      if(!var31 && isDefined(var8.vehiclename) && !istrue(var8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var30 |= 8;
      }
    }

    if(isDefined(var8.equipmentref)) {
      var30 |= 64;
    }

    var35 = "";
    var3 reportchallengeuserevent("kill", var29, var11, var12, var13, var14, var16, var17, var24, var30, var35, gettouchinglocaletriggers(var3, var8));
    return;
  }
}

function unsetreduceregendelayonkill(var0) {
  switch (var0) {
    case "sentry_gun":
    case "manual_turret":
    case "cruise_predator":
    case "juggernaut":
      return false;
  }

  return true;
}

function equipmentdestroyed(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!challengesenabledforplayer(var1)) {
    return;
  }

  var8 = self;

  if(!isPlayer(var1)) {
    if(isDefined(var0) && isPlayer(var0)) {
      var1 = var0;
    } else {
      return;
    }
  }

  if(!isDefined(var8.owner)) {
    return;
  }

  if(!scripts\cp\utility\player::isfriendly(var1.team, var8.owner)) {
    var9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var5);

    if(!isDefined(var9)) {
      var9 = scripts\cp\utility::relic_nuketimer_globalthread(var5.basename);
    }

    var10 = "";

    if(var5 == var1.primaryweaponobj) {
      var10 = scripts\cp\utility::relic_nuketimer_globalthread(var1.secondaryweaponobj.basename);
    } else if(var5 == var1.secondaryweaponobj) {
      var10 = scripts\cp\utility::relic_nuketimer_globalthread(var1.primaryweaponobj.basename);
    }

    var11 = [var9, var10];
    var12 = 0;
    var13 = 0;

    if(isDefined(var7)) {
      var12 = var7["mask"];
      var13 = var7["mask2"];
    }

    var14 = [var1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var1.team), var1 scripts\cp\survival\survival_loadout::lookupotheroperator(var1.team)];
    var15 = scripts\cp\utility::getgametype();

    if(!isDefined(var15)) {
      var15 = getDvar("NKTMKRMSKR");
    }

    var16 = level.getallselectableattachments.game_type_col[var15];
    var17 = "";
    var18 = 1;

    if(isDefined(var5.attachments)) {
      var19 = 0;

      foreach(var21 in var5.attachments) {
        var22 = scripts\cp\utility::attachmentmap_tobase(var21);

        if(var22 == "scope") {
          var19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var5, var22)) {
          if(!var18) {
            var17 += "|";
          }

          var22 = scripts\cp\cp_weapon::ref_12bbb(var22);
          var17 += var22;
          var18 = 0;
        }
      }

      if(var19) {
        if(!var18) {
          var17 += "|";
        }

        var17 += "default_sniper_scope";
      }
    }

    var24 = "";
    var25 = 1;

    if(isDefined(var1.classstruct) && isDefined(var1.classstruct.loadoutperks)) {
      foreach(var27 in var1.classstruct.loadoutperks) {
        if(!var25) {
          var24 += "|";
        }

        var24 += var27;
        var25 = 0;
      }
    }

    var29 = [var2, 0];
    var30 = 0;

    if(isPlayer(var8)) {
      var30 |= 1;
    } else if(isagent(var8)) {
      var30 = ref_12ce0(var30, var8);
    }

    var31 = 0;
    var32 = 0;
    var33 = 0;
    var34 = 0;

    if(isDefined(var8.streakinfo)) {
      var30 |= 2;
      var35 = var8.streakinfo.streakname;
      var34 = unsetreduceregendelayonkill(var35);

      switch (var35) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var31 = 1;
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
          var32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var32 = 1;
          var33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var33 = 1;
          break;
      }

      if(var31) {
        var30 |= 8;
      }

      if(var32) {
        var30 |= 4;
      }

      if(var33) {
        var30 |= 16;
      }
    }

    if(isDefined(var8.vehiclename) || var34) {
      var30 |= 32;

      if(!var31 && isDefined(var8.vehiclename) && !istrue(var8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var30 |= 8;
      }
    }

    if(isDefined(var8.equipmentref)) {
      var30 |= 64;
    }

    var36 = "";
    var1 reportchallengeuserevent("kill", var29, var11, var12, var13, var14, var16, var17, var24, var30, var36, gettouchinglocaletriggers(var1, var8));
    return;
  }
}

function vehiclekilled(var0, var1, var2, var3) {
  if(!challengesenabledforplayer(var1)) {
    return;
  }

  var4 = var0;
  var5 = scripts\cp\cp_equipment::getequipmentreffromweapon(var3);

  if(!isDefined(var5)) {
    var5 = scripts\cp\utility::relic_nuketimer_globalthread(var3.basename);
  }

  var6 = "";

  if(var3 == var1.primaryweaponobj) {
    var6 = scripts\cp\utility::relic_nuketimer_globalthread(var1.secondaryweaponobj.basename);
  } else if(var3 == var1.secondaryweaponobj) {
    var6 = scripts\cp\utility::relic_nuketimer_globalthread(var1.primaryweaponobj.basename);
  }

  var7 = [var5, var6];
  var8 = 0;
  var9 = 0;

  if(isDefined(var1.modifiers)) {
    var8 = var1.modifiers["mask"];
    var9 = var1.modifiers["mask2"];
  }

  var10 = [var1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var1.team), var1 scripts\cp\survival\survival_loadout::lookupotheroperator(var1.team)];
  var11 = scripts\cp\utility::getgametype();

  if(!isDefined(var11)) {
    var11 = getDvar("NKTMKRMSKR");
  }

  var12 = level.getallselectableattachments.game_type_col[var11];
  var13 = "";
  var14 = 1;

  if(isDefined(var3.attachments)) {
    var15 = 0;

    foreach(var17 in var3.attachments) {
      var18 = scripts\cp\utility::attachmentmap_tobase(var17);

      if(var18 == "scope") {
        var15 = 1;
      }

      if(scripts\cp\cp_weapon::carriedpunchcard(var3, var18)) {
        if(var18 == "scope") {
          var18 = "default_sniper_scope";
        }

        if(!var14) {
          var13 += "|";
        }

        var18 = scripts\cp\cp_weapon::ref_12bbb(var18);
        var13 += var18;
        var14 = 0;
      }
    }

    if(var15) {
      if(!var14) {
        var13 += "|";
      }

      var13 += "default_sniper_scope";
    }
  }

  var20 = "";
  var21 = 1;

  if(isDefined(var1.classstruct) && isDefined(var1.classstruct.loadoutperks)) {
    foreach(var23 in var1.classstruct.loadoutperks) {
      if(!var21) {
        var20 += "|";
      }

      var20 += var23;
      var21 = 0;
    }
  }

  var25 = [var2, 0];
  var26 = 0;

  if(isPlayer(var4)) {
    var26 |= 1;
  } else if(isagent(var4)) {
    var26 = ref_12ce0(var26, var4);
  }

  var27 = 0;
  var28 = 0;
  var29 = 0;
  var30 = 0;

  if(isDefined(var4.streakinfo)) {
    var26 |= 2;
    var31 = var4.streakinfo.streakname;
    var30 = unsetreduceregendelayonkill(var31);

    switch (var31) {
      case "sentry_gun":
      case "pac_sentry":
      case "manual_turret":
      case "bradley":
      case "juggernaut":
        var27 = 1;
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
        var28 = 1;
        break;
      case "scrambler_drone_guard":
      case "directional_uav":
      case "uav":
      case "radar_drone_overwatch":
        var28 = 1;
        var29 = 1;
        break;
      case "airdrop_multiple":
      case "airdrop":
        var29 = 1;
        break;
    }

    if(var27) {
      var26 |= 8;
    }

    if(var28) {
      var26 |= 4;
    }

    if(var29) {
      var26 |= 16;
    }
  }

  if(isDefined(var4.vehiclename) || var30) {
    var26 |= 32;

    if(!var27 && isDefined(var4.vehiclename) && !istrue(var4 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
      var26 |= 8;
    }
  }

  if(isDefined(var4.equipmentref)) {
    var26 |= 64;
  }

  var32 = "";
  var1 reportchallengeuserevent("kill", var25, var7, var8, var9, var10, var12, var13, var20, var26, var32, gettouchinglocaletriggers(var1, var4));
}

function processfinalkillchallenges(var0, var1) {}

function usedkillstreak(var0) {}

function resetstuckthermite() {
  var0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp\survival\survival_loadout::lookupcurrentoperator(self.team));
}

function ref_12071(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!challengesenabledforplayer(var1)) {
    return;
  }

  var8 = self;

  if(!isPlayer(var1)) {
    if(isDefined(var0) && isPlayer(var0)) {
      var1 = var0;
    } else {
      return;
    }
  }

  if(!scripts\cp\utility\player::isfriendly(var1.team, var8)) {
    var9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var5);

    if(!isDefined(var9)) {
      var9 = scripts\cp\utility::relic_nuketimer_globalthread(var5.basename);
    }

    var10 = "";

    if(isDefined(var1.secondaryweaponobj)) {
      if(var5 == var1.primaryweaponobj) {
        var10 = scripts\cp\utility::relic_nuketimer_globalthread(var1.secondaryweaponobj.basename);
      } else if(var5 == var1.secondaryweaponobj) {
        var10 = scripts\cp\utility::relic_nuketimer_globalthread(var1.primaryweaponobj.basename);
      }
    }

    var11 = [var9, var10];
    var12 = 0;
    var13 = 0;

    if(isDefined(var7)) {
      var12 = var7["mask"];
      var13 = var7["mask2"];
    }

    var14 = [var1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var1.team), var1 scripts\cp\survival\survival_loadout::lookupotheroperator(var1.team)];
    var15 = scripts\cp\utility::getgametype();

    if(!isDefined(var15)) {
      var15 = getDvar("NKTMKRMSKR");
    }

    var16 = level.getallselectableattachments.game_type_col[var15];
    var17 = "";
    var18 = 1;

    if(isDefined(var5.attachments)) {
      var19 = 0;

      foreach(var21 in var5.attachments) {
        var22 = scripts\cp\utility::attachmentmap_tobase(var21);

        if(var22 == "scope") {
          var19 = 1;
        }

        if(scripts\cp\cp_weapon::carriedpunchcard(var5, var22)) {
          if(!var18) {
            var17 += "|";
          }

          var22 = scripts\cp\cp_weapon::ref_12bbb(var22);
          var17 += var22;
          var18 = 0;
        }
      }

      if(var19) {
        if(!var18) {
          var17 += "|";
        }

        var17 += "default_sniper_scope";
      }
    }

    var24 = "";
    var25 = 1;

    if(isDefined(var1.classstruct) && isDefined(var1.classstruct.loadoutperks)) {
      foreach(var27 in var1.classstruct.loadoutperks) {
        if(!var25) {
          var24 += "|";
        }

        var24 += var27;
        var25 = 0;
      }
    }

    var29 = [var2, 0];
    var30 = 0;

    if(isPlayer(var8)) {
      var30 |= 1;
    } else if(isagent(var8)) {
      var30 = ref_12ce0(var30, var8);
    }

    var31 = 0;
    var32 = 0;
    var33 = 0;
    var34 = 0;

    if(isDefined(var8.streakinfo)) {
      var30 |= 2;
      var35 = var8.streakinfo.streakname;
      var34 = unsetreduceregendelayonkill(var35);

      switch (var35) {
        case "sentry_gun":
        case "pac_sentry":
        case "manual_turret":
        case "bradley":
        case "juggernaut":
          var31 = 1;
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
          var32 = 1;
          break;
        case "scrambler_drone_guard":
        case "directional_uav":
        case "uav":
        case "radar_drone_overwatch":
          var32 = 1;
          var33 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          var33 = 1;
          break;
      }

      if(var31) {
        var30 |= 8;
      }

      if(var32) {
        var30 |= 4;
      }

      if(var33) {
        var30 |= 16;
      }
    }

    if(isDefined(var8.vehiclename) || var34) {
      var30 |= 32;

      if(!var31 && isDefined(var8.vehiclename) && !istrue(var8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
        var30 |= 8;
      }
    }

    if(isDefined(var8.equipmentref)) {
      var30 |= 64;
    }

    var36 = "";
    var1 reportchallengeuserevent("kill", var29, var11, var12, var13, var14, var16, var17, var24, var30, var36, gettouchinglocaletriggers(var1, var8));
    return;
  }
}