/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_matchdata.gsc
********************************/

init() {
  if(!isdefined(game["gamestarted"])) {
    setmatchdatadef("mp\matchdata.ddl");
    setmatchdata("map", level.script);

    if(level.hardcoremode) {
      var_0 = level.gametype + " hc";
      setmatchdata("gametype", var_0);
    } else if(level.oldschool) {
      var_0 = level.gametype + " os";
      setmatchdata("gametype", var_0);
    } else
      setmatchdata("gametype", level.gametype);

    setmatchdata("buildVersion", getbuildversion());
    setmatchdata("buildNumber", getbuildnumber());
    setmatchdataid();
  }

  level.maxlives = 285;
  level.maxevents = 150;
  level.maxkillstreaks = 64;
  level.maxlogclients = 30;
  level.maxnumchallengesperplayer = 5;
  level.maxnumawardsperplayer = 10;
  level.maxloadouts = 10;
  level thread gameendlistener();

  if(getdvar("virtualLobbyActive") != "1")
    level thread reconlogplayerinfo();
}

matchstarted() {
  if(getdvar("virtualLobbyActive") == "1") {
    return;
  }
  if(getdvar("mapname") == getdvar("virtualLobbyMap")) {
    return;
  }
  sysprint("MatchStarted: Completed");
  var_0 = getplaylistname();
  setmatchdata("playlistName", var_0);
  var_1 = getlocaltimestring();
  setmatchdata("localTimeStringAtMatchStart", var_1);

  if(getmatchstarttimeutc() == 0)
    setmatchdata("startTimeUTC", getsystemtime());

  setmatchdata("iseSports", maps\mp\_utility::ismlgmatch());

  if(maps\mp\_utility::privatematch())
    setmatchdata("privateMatch", 1);

  if(maps\mp\_utility::isdivisionmode())
    setmatchdata("divisionMode", 1);

  thread logbreadcrumbdata();
  thread accumulateplayerpingdata();
}

logbreadcrumbdata() {
  level endon("game_ended");

  for (;;) {
    var_0 = maps\mp\_utility::getgametimepassedseconds();

    foreach(var_2 in level.players) {
      if(isbot(var_2) || istestclient(var_2)) {
        continue;
      }
      if(maps\mp\_utility::isreallyalive(var_2) && isdefined(var_2.lifeid) && canloglife(var_2.lifeid)) {
        var_3 = 31;

        if(isdefined(var_2.lastshotby))
          var_3 = var_2.lastshotby;

        recordbreadcrumbdataforplayer(var_2, var_2.lifeid, var_0, var_3);
        var_2.lastshotby = undefined;
      }
    }

    if(isdefined(level.iszombiegame) && level.iszombiegame) {
      wait 5;
      continue;
    }

    wait 2;
  }
}

accumulateplayerpingdata() {
  level endon("game_ended");

  for (;;) {
    foreach(var_1 in level.players) {
      if(isbot(var_1) || istestclient(var_1)) {
        continue;
      }
      if(!isdefined(var_1.pers["pingAccumulation"]) || !isdefined(var_1.pers["minPing"]) || !isdefined(var_1.pers["maxPing"]) || !isdefined(var_1.pers["pingSampleCount"])) {
        continue;
      }
      var_2 = var_1 getcurrentping();
      var_1.pers["pingAccumulation"] = var_1.pers["pingAccumulation"] + var_2;
      var_1.pers["pingSampleCount"]++;

      if(var_1.pers["pingSampleCount"] > 5 && var_2 > 0) {
        if(var_2 > var_1.pers["maxPing"])
          var_1.pers["maxPing"] = var_2;

        if(var_2 < var_1.pers["minPing"])
          var_1.pers["minPing"] = var_2;
      }
    }

    wait 2;
  }
}

getmatchstarttimeutc() {
  return getmatchdata("startTimeUTC");
}

logkillstreakevent(var_0, var_1) {
  if(!canlogclient(self) || !canlogkillstreak()) {
    return;
  }
  var_2 = getmatchdata("killstreakCount");
  setmatchdata("killstreakCount", var_2 + 1);
  setmatchdata("killstreaks", var_2, "eventType", var_0);
  setmatchdata("killstreaks", var_2, "player", self.clientid);
  setmatchdata("killstreaks", var_2, "eventStartTimeDeciSecondsFromMatchStart", maps\mp\_utility::gettimepasseddeciseconds());
  setmatchdata("killstreaks", var_2, "eventPos", 0, int(var_1[0]));
  setmatchdata("killstreaks", var_2, "eventPos", 1, int(var_1[1]));
  setmatchdata("killstreaks", var_2, "eventPos", 2, int(var_1[2]));
  setmatchdata("killstreaks", var_2, "index", var_2);
  self.currentkillstreakindex = var_2;
  reconspatialevent(var_1, "script_mp_killstreak: eventType %s, player_name %s, player %d, gameTime %d", var_0, self.name, self.clientid, gettime());
}

loggameevent(var_0, var_1) {
  if(!canlogclient(self) || !canlogevent()) {
    return;
  }
  var_2 = getmatchdata("eventCount");
  setmatchdata("eventCount", var_2 + 1);
  setmatchdata("events", var_2, "eventType", var_0);
  setmatchdata("events", var_2, "player", self.clientid);
  setmatchdata("events", var_2, "eventTimeDeciSecondsFromMatchStart", maps\mp\_utility::gettimepasseddeciseconds());
  setmatchdata("events", var_2, "eventPos", 0, int(var_1[0]));
  setmatchdata("events", var_2, "eventPos", 1, int(var_1[1]));
  setmatchdata("events", var_2, "eventPos", 2, int(var_1[2]));
  reconspatialevent(var_1, "script_mp_event: event_type %s, player_name %s, player %d, gameTime %d", var_0, self.name, self.clientid, gettime());
}

logkillevent(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  setmatchdata("lives", var_0, "modifiers", var_1, 1);
}

logmultikill(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  setmatchdata("lives", var_0, "multikill", var_1);
}

logplayerlife(var_0) {
  if(!canlogclient(self) || !canloglife(self.lifeid)) {
    return;
  }
  var_1 = gettime() - self.spawntime;
  self.totallifetime = self.totallifetime + var_1;
  var_2 = maps\mp\_utility::convertmillisecondstodecisecondsandclamptoshort(var_1);
  setmatchdata("lives", self.lifeid, "player", self.clientid);
  setmatchdata("lives", self.lifeid, "spawnPos", 0, int(self.spawnpos[0]));
  setmatchdata("lives", self.lifeid, "spawnPos", 1, int(self.spawnpos[1]));
  setmatchdata("lives", self.lifeid, "spawnPos", 2, int(self.spawnpos[2]));
  setmatchdata("lives", self.lifeid, "team", self.team);

  if(isdefined(self.spawntimedecisecondsfrommatchstart))
    setmatchdata("lives", self.lifeid, "spawnTimeDeciSecondsFromMatchStart", self.spawntimedecisecondsfrommatchstart);
  else
    setmatchdata("lives", self.lifeid, "spawnTimeDeciSecondsFromMatchStart", -1);

  setmatchdata("lives", self.lifeid, "durationDeciSeconds", var_2);
  var_3 = logloadout();
  setmatchdata("lives", self.lifeid, "loadoutIndex", var_3);
  var_4 = maps\mp\_utility::clamptoshort(self.pers["score"] - self.scoreatlifestart);
  setmatchdata("lives", self.lifeid, "scoreEarnedDuringThisLife", var_4);

  if(isdefined(self.pers["summary"]) && isdefined(self.pers["summary"]["xp"])) {
    if(isdefined(self.xpatlifestart)) {
      var_5 = maps\mp\_utility::clamptoshort(self.pers["summary"]["xp"] - self.xpatlifestart);
      setmatchdata("lives", self.lifeid, "xpEarnedDuringThisLife", var_5);
    }
  }
}

logplayerxp(var_0, var_1) {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, var_1, var_0);
}

logcompletedchallenge(var_0) {
  if(!isplayer(self) || !canlogclient(self) || isbot(self)) {
    return;
  }
  var_1 = getmatchdata("players", self.clientid, "challengeCount");

  if(var_1 < level.maxnumchallengesperplayer) {
    setmatchdata("players", self.clientid, "challenges", var_1, var_0);
    setmatchdata("players", self.clientid, "challengeCount", var_1 + 1);
  }
}

logloadout() {
  var_0 = 255;

  if(!canlogclient(self) || !canloglife(self.lifeid) || self.curclass == "gamemode")
    return var_0;

  var_1 = self.curclass;
  var_2 = 0;

  for (var_2 = 0; var_2 < level.maxloadouts; var_2++) {
    var_3 = getmatchdata("players", self.clientid, "loadouts", var_2, "slotUsed");

    if(!var_3) {
      break;
    } else {
      var_4 = getmatchdata("players", self.clientid, "loadouts", var_2, "className");

      if(var_1 == var_4)
        return var_2;
    }
  }

  if(var_2 == level.maxloadouts)
    return var_0;

  setmatchdata("players", self.clientid, "loadouts", var_2, "slotUsed", 1);
  setmatchdata("players", self.clientid, "loadouts", var_2, "className", var_1);
  var_5 = [];
  var_6 = "";
  var_7 = "";

  if(var_1 == "copycat") {
    var_8 = self.pers["copyCatLoadout"];
    var_9 = var_8["loadoutPrimary"];
    var_10 = var_8["loadoutPrimaryAttachKit"];
    var_11 = var_8["loadoutPrimaryFurnitureKit"];
    var_12 = var_8["loadoutPrimaryCamo"];
    var_13 = var_8["loadoutPrimaryReticle"];
    var_14 = var_8["loadoutSecondary"];
    var_15 = var_8["loadoutSecondaryAttachKit"];
    var_16 = var_8["loadoutSecondaryFurnitureKit"];
    var_17 = var_8["loadoutSecondaryCamo"];
    var_18 = var_8["loadoutSecondaryReticle"];
    var_6 = var_8["loadoutEquipment"];
    var_7 = var_8["loadoutOffhand"];

    for (var_19 = 0; var_19 < 3; var_19++)
      var_5[var_19] = var_8["loadoutPerks"][var_19];

    var_20 = var_8["loadoutMelee"];
  } else if(issubstr(var_1, "custom")) {
    var_21 = maps\mp\_utility::getclassindex(var_1);
    var_9 = maps\mp\gametypes\_class::cac_getweapon(var_21, 0);
    var_10 = maps\mp\gametypes\_class::cac_getweaponattachkit(var_21, 0);
    var_11 = maps\mp\gametypes\_class::cac_getweaponfurniturekit(var_21, 0);
    var_12 = maps\mp\gametypes\_class::cac_getweaponcamo(var_21, 0);

    for (var_19 = 0; var_19 < 3; var_19++)
      var_5[var_19] = maps\mp\gametypes\_class::cac_getperk(var_21, var_19);

    var_14 = maps\mp\gametypes\_class::cac_getweapon(var_21, 1);
    var_15 = maps\mp\gametypes\_class::cac_getweaponattachkit(var_21, 1);
    var_16 = maps\mp\gametypes\_class::cac_getweaponfurniturekit(var_21, 1);
    var_17 = maps\mp\gametypes\_class::cac_getweaponcamo(var_21, 1);
    var_6 = maps\mp\gametypes\_class::cac_getequipment(var_21, 0);
    var_7 = maps\mp\gametypes\_class::cac_getoffhand(var_21);
    var_20 = maps\mp\gametypes\_class::cac_getmeleeweapon(var_21);
  } else {
    var_21 = maps\mp\_utility::getclassindex(var_1);
    var_9 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_21, 0);
    var_10 = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, var_21, 0);
    var_11 = maps\mp\gametypes\_class::table_getweaponfurniturekit(level.classtablename, var_21, 0);
    var_12 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_21, 0);

    for (var_19 = 0; var_19 < 3; var_19++)
      var_5[var_19] = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_21, var_19);

    var_14 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_21, 1);
    var_15 = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, var_21, 1);
    var_16 = maps\mp\gametypes\_class::table_getweaponfurniturekit(level.classtablename, var_21, 1);
    var_17 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_21, 1);
    var_6 = maps\mp\gametypes\_class::table_getequipment(level.classtablename, var_21);
    var_7 = maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_21);
    var_20 = "none";
  }

  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryWeapon", var_9);

  for (var_19 = 0; var_19 < 3; var_19++)
    setmatchdata("players", self.clientid, "loadouts", var_2, "perkSlots", var_19, var_5[var_19]);

  setmatchdata("players", self.clientid, "loadouts", var_2, "secondaryWeapon", var_14);
  var_22 = maps\mp\gametypes\_class::attachkitnametoid(var_10);
  var_23 = maps\mp\gametypes\_class::attachkitnametoid(var_15);
  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryAttachKit", var_22);
  setmatchdata("players", self.clientid, "loadouts", var_2, "secondaryAttachKit", var_23);
  var_24 = maps\mp\gametypes\_class::furniturekitnametoid(var_11);
  var_25 = maps\mp\gametypes\_class::furniturekitnametoid(var_16);
  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryFurnitureKit", var_24);
  setmatchdata("players", self.clientid, "loadouts", var_2, "secondaryFurnitureKit", var_25);
  setmatchdata("players", self.clientid, "loadouts", var_2, "offhandWeapon", var_7);
  setmatchdata("players", self.clientid, "loadouts", var_2, "equipment", var_6);
  thread recon_log_loadout(self, var_9, var_10, var_11, var_12, var_14, var_15, var_16, var_17, var_6, var_7, var_5[0], var_5[1], var_5[2]);
  return var_2;
}

recon_log_loadout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = isbot(var_0) || istestclient(var_0);
  var_15 = "_matchdata.gsc";
  var_16 = var_0.spawntime;
  var_17 = var_0.curclass;
  var_18 = var_0.name;
  reconevent("script_mp_loadout_gear: script_file %s, gameTime %d, player_name %s, is_bot %b, class %s, primary_weapon %s, primary_attach_kit %s, primary_furniture_kit %s, primary_camo %s, secondary_weapon %s, secondary_attach_kit %s,secondary_furniture_kit %s, secondary_camo %s, equipment %s, offhand %s", var_15, var_16, var_18, var_14, var_17, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  reconevent("script_mp_loadout_perks: script_file %s, gameTime %d, player_name %s, perk_1 %s, perk_2 %s, perk_3 %s", var_15, var_16, var_18, var_11, var_12, var_13);
}

logplayerandkilleradsandfov(var_0, var_1) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(isplayer(var_1)) {
    if(var_1 playerads() > 0.5)
      setmatchdata("lives", var_0, "killerWasADS", 1);

    var_2 = var_1 geteye();

    if(common_scripts\utility::within_fov(var_2, var_1.angles, self.origin, cos(getdvarfloat("cg_fov"))))
      setmatchdata("lives", var_0, "victimWasInKillersFOV", 1);

    var_3 = self geteye();

    if(common_scripts\utility::within_fov(var_3, self.angles, var_1.origin, cos(getdvarfloat("cg_fov"))))
      setmatchdata("lives", var_0, "killerWasInVictimsFOV", 1);
  }

  if(self playerads() > 0.5)
    setmatchdata("lives", var_0, "victimWasADS", 1);
}

determineweaponnameandattachments(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(var_0 == "none") {
    var_2 = "none";
    var_3 = "none";
  } else {
    var_2 = weaponinventorytype(var_0);
    var_3 = weaponclass(var_0);
  }

  if(issubstr(var_0, "destructible"))
    var_0 = "destructible";

  var_4 = [];
  var_4[0] = "None";
  var_4[1] = "None";
  var_4[2] = "None";
  var_5 = "none";
  var_6 = "none";
  var_7 = "";

  if(maps\mp\_utility::iskillstreakweapon(var_0))
    var_7 = maps\mp\_utility::strip_suffix(var_0, "_mp");
  else if(var_0 == "destructible")
    var_7 = var_0;
  else if(isdefined(var_2) && (var_2 == "primary" || var_2 == "altmode" || var_2 == "melee") && (var_3 == "pistol" || var_3 == "smg" || var_3 == "rifle" || var_3 == "spread" || var_3 == "mg" || var_3 == "grenade" || var_3 == "rocketlauncher" || var_3 == "sniper" || var_3 == "cone" || var_3 == "beam" || var_3 == "shield")) {
    if(var_2 == "altmode") {
      if(isdefined(var_1))
        var_0 = var_1;
    }

    var_8 = maps\mp\_utility::getweaponnametokens(var_0);
    var_7 = maps\mp\_utility::getbaseweaponname(var_0);

    if(var_8[0] == "iw5" || var_8[0] == "iw6" || var_8[0] == "h1") {
      foreach(var_10 in var_8) {
        var_11 = strtok(var_10, "#");

        if(var_11.size > 1) {
          if(var_11[0] == "a") {
            var_5 = var_11[1];
            continue;
          }

          if(var_11[0] == "f")
            var_6 = var_11[1];
        }
      }

      if(var_5 == "none" && var_6 == "none") {
        var_13 = getweaponattachments(var_0);
        var_14 = 0;

        foreach(var_16 in var_13) {
          if(!maps\mp\_utility::isattachment(var_16)) {
            continue;
          }
          var_17 = maps\mp\_utility::attachmentmap_tobase(var_16);

          if(var_14 <= 2) {
            var_4[var_14] = var_17;
            var_14++;
            continue;
          }

          break;
        }
      }
    } else if(var_8[0] == "alt") {
      var_19 = var_8[1] + "_" + var_8[2];
      var_7 = var_19;

      if(isdefined(var_8[4]) && maps\mp\_utility::isattachment(var_8[4])) {
        var_17 = maps\mp\_utility::attachmentmap_tobase(var_8[4]);
        var_4[0] = var_17;
      }

      if(isdefined(var_8[5]) && maps\mp\_utility::isattachment(var_8[5])) {
        var_17 = maps\mp\_utility::attachmentmap_tobase(var_8[5]);
        var_4[1] = var_17;
      }
    } else {
      var_8[var_8.size - 1] = undefined;

      if(isdefined(var_8[1]) && var_2 != "altmode") {
        var_17 = maps\mp\_utility::attachmentmap_tobase(var_8[1]);
        var_4[0] = var_17;
      }

      if(isdefined(var_8[2]) && var_2 != "altmode") {
        var_17 = maps\mp\_utility::attachmentmap_tobase(var_8[2]);
        var_4[1] = var_17;
      }
    }
  } else if(var_2 == "item" || var_2 == "offhand") {
    var_7 = maps\mp\_utility::strip_suffix(var_0, "_lefthand");
    var_7 = maps\mp\_utility::strip_suffix(var_7, "_mp");
  } else
    var_7 = var_0;

  var_20 = spawnstruct();
  var_20.weaponname = var_7;
  var_20.attachments = var_4;
  var_20.attachkit = var_5;
  var_20.furniturekit = var_6;
  var_20.weapontype = var_2;
  var_20.weaponclass = var_3;
  var_20.weaponnamefull = var_0;
  return var_20;
}

logfirefightshotshits(var_0, var_1) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(!isplayer(var_1)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(self.currentfirefightshots > 0)
    setmatchdata("lives", var_0, "shots", maps\mp\_utility::clamptobyte(self.currentfirefightshots));

  if(isdefined(var_1.enemyhitcounts) && isdefined(var_1.enemyhitcounts[self.guid]) && var_1.enemyhitcounts[self.guid] > 0)
    setmatchdata("lives", var_0, "hits", maps\mp\_utility::clamptobyte(var_1.enemyhitcounts[self.guid]));

  if(var_1.currentfirefightshots > 0)
    setmatchdata("lives", var_0, "killerShots", maps\mp\_utility::clamptobyte(var_1.currentfirefightshots));

  if(isdefined(self.enemyhitcounts) && isdefined(self.enemyhitcounts[var_1.guid]) && self.enemyhitcounts[var_1.guid] > 0)
    setmatchdata("lives", var_0, "killerHits", maps\mp\_utility::clamptobyte(self.enemyhitcounts[var_1.guid]));
}

logplayerandkillerstanceandmotionstate(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  if(isplayer(self) && canlogclient(self)) {
    var_2 = getstanceandmotionstateforplayer(self);
    setmatchdata("lives", var_0, "victimStanceAndMotionState", var_2);
  }

  if(isplayer(var_1) && canlogclient(var_1)) {
    var_2 = getstanceandmotionstateforplayer(var_1);
    setmatchdata("lives", var_0, "killerStanceAndMotionState", var_2);
  }
}

logassists(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  if(isplayer(self) && canlogclient(self)) {
    if(isdefined(self.attackerdata)) {
      var_2 = 0;

      foreach(var_4 in self.attackerdata) {
        if(isplayer(var_4.attackerent)) {
          if(var_4.attackerent != var_1) {
            setmatchdata("lives", var_0, "assists", var_2, "assistingPlayerIndex", var_4.attackerent.clientid);
            setmatchdata("lives", var_0, "assists", var_2, "damage", maps\mp\_utility::clamptobyte(var_4.damage));
            var_2++;

            if(var_2 == 5) {
              break;
            }
          }
        }
      }

      if(var_2 < 5) {
        for (var_6 = var_2; var_6 < 5; var_6++)
          setmatchdata("lives", var_0, "assists", var_6, "assistingPlayerIndex", 255);
      }
    }
  }
}

logspecialassists(var_0, var_1) {
  if(!isplayer(self) || !canlogclient(self)) {
    return;
  }
  if(!isplayer(var_0) || !canlogclient(var_0)) {
    return;
  }
  var_2 = self.lifeid;

  if(!canloglife(var_2)) {
    return;
  }
  if(var_1 == "assist_uav" || var_1 == "assist_concussion" || var_1 == "assist_flash") {
    for (var_3 = 0; var_3 < 5; var_3++) {
      var_4 = getmatchdata("lives", var_2, "assists", var_3, "assistingPlayerIndex");

      if(var_4 == var_0.clientid || var_4 == 255) {
        if(var_4 == 255)
          setmatchdata("lives", var_2, "assists", var_3, "assistingPlayerIndex", var_0.clientid);

        if(var_1 == "assist_uav")
          setmatchdata("lives", var_2, "assists", var_3, "assistUAV", 1);
        else if(var_1 == "assist_concussion")
          setmatchdata("lives", var_2, "assists", var_3, "assistConcussion", 1);
        else if(var_1 == "assist_flash")
          setmatchdata("lives", var_2, "assists", var_3, "assistFlash", 1);
        else {

        }

        break;
      }
    }
  }
}

logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(level.iszombiegame) {
    return;
  }
  if(isdefined(level.ishorde) && level.ishorde) {
    return;
  }
  logplayerandkilleradsandfov(var_0, var_1);
  logfirefightshotshits(var_0, var_1);
  logplayerandkillerstanceandmotionstate(var_0, var_1);
  logassists(var_0, var_1);
  var_8 = determineweaponnameandattachments(var_4, var_5);
  var_9 = maps\mp\gametypes\_class::attachkitnametoid(var_8.attachkit);
  setmatchdata("lives", var_0, "killersWeaponAttachKit", var_9);
  var_10 = maps\mp\gametypes\_class::furniturekitnametoid(var_8.furniturekit);
  setmatchdata("lives", var_0, "killersWeaponFurnitureKit", var_10);

  if(var_8.weapontype != "exclusive")
    setmatchdata("lives", var_0, "killersWeapon", var_8.weaponname);

  if(var_8.weaponnamefull == "altmode")
    setmatchdata("lives", var_0, "killersWeaponAltMode", 1);

  if(maps\mp\_utility::iskillstreakweapon(var_8.weaponnamefull)) {
    setmatchdata("lives", var_0, "modifiers", "killstreak", 1);

    if(isdefined(var_1.currentkillstreakindex)) {
      var_11 = getmatchdata("killstreaks", var_1.currentkillstreakindex, "killsTotal");
      var_11++;
      setmatchdata("killstreaks", var_1.currentkillstreakindex, "killsTotal", maps\mp\_utility::clamptoshort(var_11));
      setmatchdata("lives", var_0, "killerKillstreakIndex", var_1.currentkillstreakindex);
    }
  } else
    setmatchdata("lives", var_0, "killerKillstreakIndex", 255);

  var_12 = determineweaponnameandattachments(var_7, undefined);
  var_9 = maps\mp\gametypes\_class::attachkitnametoid(var_12.attachkit);
  setmatchdata("lives", var_0, "victimCurrentWeaponAtDeathAttachKit", var_9);
  var_10 = maps\mp\gametypes\_class::furniturekitnametoid(var_12.furniturekit);
  setmatchdata("lives", var_0, "victimCurrentWeaponAtDeathFurnitureKit", var_10);

  if(var_12.weapontype != "exclusive") {
    if(maps\mp\_utility::iskillstreakweapon(var_12.weaponname)) {
      if(isdefined(self.primaryweapon)) {
        var_13 = maps\mp\_utility::getbaseweaponname(self.primaryweapon);
        setmatchdata("lives", var_0, "victimCurrentWeaponAtDeath", var_13);
      }
    } else
      setmatchdata("lives", var_0, "victimCurrentWeaponAtDeath", var_12.weaponname);
  }

  if(isdefined(self.pickedupweaponfrom) && isdefined(self.pickedupweaponfrom[var_12.weaponnamefull]))
    setmatchdata("lives", var_0, "victimCurrentWeaponPickedUp", 1);

  setmatchdata("lives", var_0, "meansOfDeath", var_3);
  var_14 = 2;

  if(isplayer(var_1)) {
    setmatchdata("lives", var_0, "killer", var_1.clientid);
    setmatchdata("lives", var_0, "killerLifeIndex", var_1.lifeid);
    setmatchdata("lives", var_0, "killerPos", 0, int(var_1.origin[0]));
    setmatchdata("lives", var_0, "killerPos", 1, int(var_1.origin[1]));
    setmatchdata("lives", var_0, "killerPos", 2, int(var_1.origin[2]));
    setmatchdata("lives", var_0, "killerAngles", 0, int(var_1.angles[0]));
    setmatchdata("lives", var_0, "killerAngles", 1, int(var_1.angles[1]));
    setmatchdata("lives", var_0, "killerAngles", 2, int(var_1.angles[2]));
    var_15 = anglestoforward((0, self.angles[1], 0));
    var_16 = self.origin - var_1.origin;
    var_16 = vectornormalize((var_16[0], var_16[1], 0));
    var_14 = vectordot(var_15, var_16);
    setmatchdata("lives", var_0, "dotOfDeath", var_14);

    if(isdefined(var_1.pickedupweaponfrom) && isdefined(var_1.pickedupweaponfrom[var_8.weaponnamefull]))
      setmatchdata("lives", var_0, "killerCurrentWeaponPickedUp", 1);
  } else {
    setmatchdata("lives", var_0, "killer", 255);
    setmatchdata("lives", var_0, "killerLifeIndex", 65535);
    setmatchdata("lives", var_0, "killerPos", 0, int(self.origin[0]));
    setmatchdata("lives", var_0, "killerPos", 1, int(self.origin[1]));
    setmatchdata("lives", var_0, "killerPos", 2, int(self.origin[2]));
    setmatchdata("lives", var_0, "killerAngles", 0, int(self.angles[0]));
    setmatchdata("lives", var_0, "killerAngles", 1, int(self.angles[1]));
    setmatchdata("lives", var_0, "killerAngles", 2, int(self.angles[2]));
  }

  setmatchdata("lives", var_0, "kill_timestamp", getsystemtime());
  setmatchdata("lives", var_0, "player", self.clientid);
  setmatchdata("lives", var_0, "victimPos", 0, int(self.origin[0]));
  setmatchdata("lives", var_0, "victimPos", 1, int(self.origin[1]));
  setmatchdata("lives", var_0, "victimPos", 2, int(self.origin[2]));
  setmatchdata("lives", var_0, "victimAngles", 0, int(self.angles[0]));
  setmatchdata("lives", var_0, "victimAngles", 1, int(self.angles[1]));
  setmatchdata("lives", var_0, "victimAngles", 2, int(self.angles[2]));
  var_17 = "world";

  if(isplayer(var_1))
    var_17 = var_1.name;

  var_18 = 1;
  var_19 = 0;
  var_20 = maps\mp\_utility::isaiteamparticipant(self);
  var_21 = 0;

  if(isplayer(var_1))
    var_21 = maps\mp\_utility::isaiteamparticipant(var_1);

  var_22 = length(self.origin - var_1.origin);
  var_23 = 0;
  var_24 = 0.0;
  var_25 = -1;
  var_26 = -1;
  var_27 = gettime();

  if(isplayer(var_1))
    var_24 = var_1 playerads();

  var_28 = var_1.clientid;

  if(!isdefined(var_28))
    var_28 = -1;

  var_29 = var_1.lifeid;

  if(!isdefined(var_29))
    var_29 = -1;

  var_30 = 0.1;

  if(self.damage_info.size > 1)
    var_18 = 0;

  if(isdefined(self.damage_info[var_1 getentitynumber()]))
    var_19 = self.damage_info[var_1 getentitynumber()].num_shots;

  var_31 = self.pers["primaryWeapon"] + "_mp";
  var_32 = weaponclass(var_31);

  if(issubstr(var_8.weaponname, "loot"))
    var_23 = 1;

  if(isdefined(self.spawninfo) && isdefined(self.spawninfo.spawntime))
    var_25 = (var_27 - self.spawninfo.spawntime) / 1000.0;

  if(isdefined(var_1.spawninfo) && isdefined(var_1.spawninfo.spawntime) && isplayer(var_1))
    var_26 = (var_27 - var_1.spawninfo.spawntime) / 1000.0;

  reconspatialevent(self.origin, "script_mp_playerdeath: player_name %s, life_id %d, angles %v, death_dot %f, is_jugg %b, is_killstreak %b, mod %s, gameTime %d, spawnToDeathTime %f, attackerAliveTime %f, attacker_life_id %d", self.name, self.lifeid, self.angles, var_14, var_1 maps\mp\_utility::isjuggernaut(), maps\mp\_utility::iskillstreakweapon(var_8.weaponnamefull), var_3, var_27, var_25, var_26, var_29);
  reconspatialevent(self.origin, "script_mp_weaponinfo: player_name %s, life_id %d, isbot %b, attacker_name %s, attacker %d, attacker_pos %v, distance %f, ads_fraction %f, is_jugg %b, is_killstreak %b, weapon_type %s, weapon_class %s, weapon_name %s, isLoot %b, attachKit %s, furnitureKit %s, numShots %d, soleAttacker %b, gameTime %d", self.name, self.lifeid, var_20, var_17, var_28, var_1.origin, var_22, var_24, var_1 maps\mp\_utility::isjuggernaut(), maps\mp\_utility::iskillstreakweapon(var_8.weaponnamefull), var_8.weapontype, var_8.weaponclass, var_8.weaponname, var_23, var_8.attachkit, var_8.furniturekit, var_19, var_18, var_27);
  reconspatialevent(self.origin, "script_mp_weaponinfo_ext: player_name %s, life_id %d, gametime %d, version %f, victimWeapon %s, victimWeaponClass %s, killerIsBot %b", self.name, self.lifeid, var_27, var_30, var_31, var_32, var_21);

  if(!isdefined(level.matchdata))
    level.matchdata = [];

  if(!isdefined(level.matchdata["deathCount"]))
    level.matchdata["deathCount"] = 1;
  else
    level.matchdata["deathCount"]++;

  if(var_25 <= 3.0) {
    if(!isdefined(level.matchdata["badSpawnDiedTooFastCount"]))
      level.matchdata["badSpawnDiedTooFastCount"] = 1;
    else
      level.matchdata["badSpawnDiedTooFastCount"]++;

    if(self.spawninfo.badspawn == 0) {
      if(!isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
        level.matchdata["badSpawnByAnyMeansCount"] = 1;
      else
        level.matchdata["badSpawnByAnyMeansCount"]++;

      self.spawninfo.badspawn = 1;
    }
  }

  if(isplayer(var_1) && var_26 <= 3.0) {
    if(!isdefined(level.matchdata["badSpawnKilledTooFastCount"]))
      level.matchdata["badSpawnKilledTooFastCount"] = 1;
    else
      level.matchdata["badSpawnKilledTooFastCount"]++;

    if(var_1.spawninfo.badspawn == 0) {
      if(!isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
        level.matchdata["badSpawnByAnyMeansCount"] = 1;
      else
        level.matchdata["badSpawnByAnyMeansCount"]++;

      var_1.spawninfo.badspawn = 1;
    }
  }
}

logplayerdata() {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "score", maps\mp\_utility::getpersstat("score"));

  if(maps\mp\_utility::getpersstat("assists") > 255)
    setmatchdata("players", self.clientid, "assists", 255);
  else
    setmatchdata("players", self.clientid, "assists", maps\mp\_utility::getpersstat("assists"));

  if(maps\mp\_utility::getpersstat("longestStreak") > 255)
    setmatchdata("players", self.clientid, "longestStreak", 255);
  else
    setmatchdata("players", self.clientid, "longestStreak", maps\mp\_utility::getpersstat("longestStreak"));

  if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers["validationInfractions"])) {
    if(maps\mp\_utility::getpersstat("validationInfractions") > 255)
      setmatchdata("players", self.clientid, "validationInfractions", 255);
    else
      setmatchdata("players", self.clientid, "validationInfractions", maps\mp\_utility::getpersstat("validationInfractions"));
  }
}

combinelbstat(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = var_1;

  var_4 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", var_3);
  var_5 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "lbstats", var_2, var_1);
  var_0 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "lbstats", var_2, var_1, var_5 + var_4);
}

endofgamesummarylogger() {
  foreach(var_1 in level.players) {
    wait 0.05;

    if(!isdefined(var_1)) {
      continue;
    }
    logplayerping(var_1);

    if(isdefined(var_1.detectedexploit) && var_1.detectedexploit && var_1 maps\mp\_utility::rankingenabled())
      var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "restXPGoal", var_1.detectedexploit);

    var_2 = undefined;
    var_3 = 0;

    if(isdefined(game["challengeStruct"]) && isdefined(game["challengeStruct"]["challengesCompleted"]) && isdefined(game["challengeStruct"]["challengesCompleted"][var_1.guid]))
      var_3 = 1;

    if(var_3) {
      var_2 = game["challengeStruct"]["challengesCompleted"][var_1.guid];

      if(var_2.size > 0) {
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "challengeNumCompleted", var_2.size);
        var_4 = maps\mp\_utility::clamptobyte(var_2.size);
        setmatchdata("players", var_1.clientid, "challengesCompleted", var_4);
      } else
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "challengeNumCompleted", 0);
    } else
      var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "challengeNumCompleted", 0);

    for (var_5 = 0; var_5 < 20; var_5++) {
      if(isdefined(var_2) && isdefined(var_2[var_5]) && var_2[var_5] != 8000) {
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "challengesCompleted", var_5, var_2[var_5]);
        continue;
      }

      var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "challengesCompleted", var_5, 0);
    }

    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "gameMode", level.gametype);
    var_1 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "map", tolower(getdvar("mapname")));

    if(maps\mp\_utility::matchmakinggame()) {
      var_6 = level.gametype;

      if(getdvarint("g_hardcore"))
        var_6 = level.gametype + "_HC";
      else if(getdvarint("g_oldschool"))
        var_6 = level.gametype + "_OS";

      combinelbstat(var_1, "score", var_6);
      combinelbstat(var_1, "timePlayed", var_6);
      combinelbstat(var_1, "kills", var_6);
      combinelbstat(var_1, "deaths", var_6);
      var_7 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "lbstats", var_6, "gamesPlayed");
      var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "lbstats", var_6, "gamesPlayed", var_7 + 1);

      if(level.gametype == "war")
        combinelbstat(var_1, "assists", var_6);
      else if(level.gametype == "dm")
        combinelbstat(var_1, "headshots", var_6);
      else if(level.gametype == "conf") {
        combinelbstat(var_1, "confirms", var_6, "confirmed");
        combinelbstat(var_1, "denies", var_6, "denied");
      } else if(level.gametype == "sd") {
        combinelbstat(var_1, "plants", var_6);
        combinelbstat(var_1, "defuses", var_6);
        combinelbstat(var_1, "defends", var_6);
      } else if(level.gametype == "dom") {
        combinelbstat(var_1, "captures", var_6);
        combinelbstat(var_1, "defends", var_6);
      } else if(level.gametype == "koth") {
        combinelbstat(var_1, "captures", var_6);
        combinelbstat(var_1, "defends", var_6);
        combinelbstat(var_1, "destructions", var_6);
      } else if(level.gametype == "sab") {
        combinelbstat(var_1, "plants", var_6);
        combinelbstat(var_1, "defuses", var_6);
        combinelbstat(var_1, "defends", var_6);
      } else if(level.gametype == "ctf") {
        combinelbstat(var_1, "captures", var_6);
        combinelbstat(var_1, "returns", var_6);
        combinelbstat(var_1, "defends", var_6);
      } else if(level.gametype == "gun") {
        combinelbstat(var_1, "humiliations", var_6);
        combinelbstat(var_1, "setbacks", var_6);
      } else if(level.gametype == "hp") {
        combinelbstat(var_1, "captures", var_6);
        combinelbstat(var_1, "defends", var_6);
        combinelbstat(var_1, "captureTime", var_6);
      } else if(level.gametype == "dd") {
        combinelbstat(var_1, "plants", var_6);
        combinelbstat(var_1, "defuses", var_6);
        combinelbstat(var_1, "defends", var_6);
      } else if(level.gametype == "mugger") {
        combinelbstat(var_1, "muggings", var_6);
        combinelbstat(var_1, "banked", var_6);
      }
    }
  }
}

logplayerping(var_0) {
  if(!isdefined(var_0.pers["maxPing"]) || !isdefined(var_0.pers["minPing"]) || !isdefined(var_0.pers["pingAccumulation"]) || !isdefined(var_0.pers["pingSampleCount"])) {
    return;
  }
  if(var_0.pers["pingSampleCount"] > 0 && var_0.pers["maxPing"] > 0) {
    var_1 = maps\mp\_utility::clamptoshort(var_0.pers["pingAccumulation"] / var_0.pers["pingSampleCount"]);
    setmatchdata("players", var_0.clientid, "averagePing", var_1);
    setmatchdata("players", var_0.clientid, "maxPing", maps\mp\_utility::clamptoshort(var_0.pers["maxPing"]));
    setmatchdata("players", var_0.clientid, "minPing", maps\mp\_utility::clamptoshort(var_0.pers["minPing"]));
  }
}

gameendlistener() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    var_1 logplayerdata();

    if(!isalive(var_1)) {
      continue;
    }
    var_1 logplayerlife(0);
  }

  foreach(var_1 in level.players) {
    if(var_1.totallifetime > 0) {
      var_4 = var_1 maps\mp\_utility::getpersstat("score") / (var_1.totallifetime / 60000);
      tournamentreportplayerspm(var_1.xuid, var_4, var_1.team);
    }

    var_1.totallifetime = 0;
  }
}

canlogclient(var_0) {
  if(isagent(var_0))
    return 0;

  var_1 = var_0.code_classname;

  if(!isdefined(var_1))
    var_1 = "undefined";

  return var_0.clientid < level.maxlogclients;
}

canlogevent() {
  return getmatchdata("eventCount") < level.maxevents;
}

canlogkillstreak() {
  return getmatchdata("killstreakCount") < level.maxkillstreaks;
}

canloglife(var_0) {
  return getmatchdata("lifeCount") < level.maxlives;
}

logweaponstat(var_0, var_1, var_2) {
  if(!canlogclient(self)) {
    return;
  }
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return;
  }
  if(!isdefined(self.pers["mpWeaponStats"][var_0]))
    self.pers["mpWeaponStats"][var_0] = [];

  if(!isdefined(self.pers["mpWeaponStats"][var_0][var_1]))
    self.pers["mpWeaponStats"][var_0][var_1] = 0;

  var_3 = self.pers["mpWeaponStats"][var_0][var_1];
  var_3 = var_3 + var_2;
  self.pers["mpWeaponStats"][var_0][var_1] = var_3;
}

buildbaseweaponlist() {
  var_0 = [];
  var_1 = 149;

  for (var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = tablelookup("mp\statstable.csv", 0, var_2, 4);

    if(var_3 == "") {
      continue;
    }
    if(!issubstr(tablelookup("mp\statsTable.csv", 0, var_2, 2), "weapon_")) {
      continue;
    }
    if(tablelookup("mp\statsTable.csv", 0, var_2, 2) == "weapon_other") {
      continue;
    }
    if(tablelookup("mp\statsTable.csv", 0, var_2, 51) != "") {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

logkillsconfirmed() {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "killsConfirmed", self.pers["confirmed"]);
}

logkillsdenied() {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "killsDenied", self.pers["denied"]);
}

loginitialstats() {
  if(getdvarint("mdsd") > 0) {
    var_0 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "experience");
    setmatchdata("players", self.clientid, "startXp", var_0);
    setmatchdata("players", self.clientid, "startKills", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "kills"));
    setmatchdata("players", self.clientid, "startDeaths", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "deaths"));
    setmatchdata("players", self.clientid, "startWins", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "wins"));
    setmatchdata("players", self.clientid, "startLosses", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "losses"));
    setmatchdata("players", self.clientid, "startHits", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "hits"));
    setmatchdata("players", self.clientid, "startMisses", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "misses"));
    setmatchdata("players", self.clientid, "startGamesPlayed", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "gamesPlayed"));
    setmatchdata("players", self.clientid, "startScore", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "score"));
    setmatchdata("players", self.clientid, "startPrestige", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "prestige"));
    setmatchdata("players", self.clientid, "startDP", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division"));
    var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mmr");
    setmatchdata("players", self.clientid, "startMMR", var_1);
  }
}

logfinalstats() {
  if(getdvarint("mdsd") > 0) {
    var_0 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "experience");
    setmatchdata("players", self.clientid, "endXp", var_0);
    setmatchdata("players", self.clientid, "endKills", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "kills"));
    setmatchdata("players", self.clientid, "endDeaths", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "deaths"));
    setmatchdata("players", self.clientid, "endWins", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "wins"));
    setmatchdata("players", self.clientid, "endLosses", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "losses"));
    setmatchdata("players", self.clientid, "endHits", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "hits"));
    setmatchdata("players", self.clientid, "endMisses", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "misses"));
    setmatchdata("players", self.clientid, "endGamesPlayed", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "gamesPlayed"));
    setmatchdata("players", self.clientid, "endScore", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "score"));
    setmatchdata("players", self.clientid, "endPrestige", self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "prestige"));
    var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mmr");
    setmatchdata("players", self.clientid, "endMMR", var_1);

    if(isdefined(self.pers["rank"])) {
      var_3 = maps\mp\_utility::clamptobyte(maps\mp\gametypes\_rank::getrank());
      setmatchdata("players", self.clientid, "rankAtEnd", var_3);
    }
  }
}

reconlogplayerinfo() {
  for (;;) {
    if(getdvarint("cl_freemove") == 0) {
      foreach(var_1 in level.players) {
        var_2 = 0;

        if(maps\mp\_utility::isreallyalive(var_1))
          var_2 = 1;

        if(istestclient(var_1)) {
          continue;
        }
        if(!isdefined(var_1.origin)) {
          continue;
        }
        var_3 = "disconnected?";

        if(isdefined(var_1.name))
          var_3 = var_1.name;

        var_4 = -1;

        if(isdefined(var_1.clientid))
          var_4 = var_1.clientid;

        var_5 = (-999, -999, -999);

        if(isdefined(var_1.angles))
          var_5 = var_1.angles;

        var_6 = "undefined";

        if(isdefined(var_1.team))
          var_6 = var_1.team;

        var_7 = gettime();
        reconspatialevent(var_1.origin, "script_mp_playerpos: player_name %s, angles %v, gameTime %d, playerTeam %s, is_alive %b", var_3, var_5, var_7, var_6, var_2);
      }
    }

    wait 0.2;
  }
}