/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sotf.gsc
*********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 65);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_randomize = 0;
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  setplayerloadout();
  level.teambased = 1;
  level.overridecrateusetime = 500;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.customcratefunc = ::sotfcratecontents;
  level.cratekill = ::cratekill;
  level.pickupweaponhandler = ::pickupweaponhandler;
  level.iconvisall = ::iconvisall;
  level.objvisall = ::objvisall;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.vehicleoverride = "littlebird_neutral_mp";
  level.usedlocations = [];
  level.emptylocations = 1;
  level.firstcratedrop = 1;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "hunted";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "sotf_hint";
  game["dialog"]["defense_obj"] = "sotf_hint";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_sotf_crateamount", getmatchrulesdata("sotfData", "crateAmount"));
  setdynamicdvar("scr_sotf_crategunamount", getmatchrulesdata("sotfData", "crateGunAmount"));
  setdynamicdvar("scr_sotf_cratetimer", getmatchrulesdata("sotfData", "crateDropTimer"));
  setdynamicdvar("scr_sotf_roundlimit", 1);
  scripts\mp\utility::registerroundlimitdvar("sotf", 1);
  setdynamicdvar("scr_sotf_winlimit", 1);
  scripts\mp\utility::registerwinlimitdvar("sotf", 1);
  setdynamicdvar("scr_sotf_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("sotf", 0);
  setdynamicdvar("scr_sotf_promode", 0);
}

onprecachegametype() {
  level._effect["signal_chest_drop"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["signal_chest_drop_mover"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
}

onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  var_2 = &"OBJECTIVES_WAR";
  var_3 = &"OBJECTIVES_WAR_SCORE";
  var_4 = &"OBJECTIVES_WAR_HINT";
  scripts\mp\utility::setobjectivetext("allies", var_2);
  scripts\mp\utility::setobjectivetext("axis", var_2);
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", var_2);
    scripts\mp\utility::setobjectivescoretext("axis", var_2);
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", var_3);
    scripts\mp\utility::setobjectivescoretext("axis", var_3);
  }

  scripts\mp\utility::setobjectivehinttext("allies", var_4);
  scripts\mp\utility::setobjectivehinttext("axis", var_4);
  initspawns();
  var_5 = [];
  scripts\mp\gameobjects::main(var_5);
  level thread sotf();
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

setplayerloadout() {
  definechestweapons();
  var_0 = getrandomweapon(level.pistolarray);
  var_1 = scripts\mp\utility::getweaponrootname(var_0["name"]);
  var_2 = tablelookup("mp\sotfWeapons.csv", 2, var_1, 0);
  setomnvar("ui_sotf_pistol", int(var_2));
  level.sotf_loadouts["axis"]["loadoutPrimary"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondary"] = var_0["name"];
  level.sotf_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.sotf_loadouts["axis"]["loadoutEquipment"] = "throwingknife_mp";
  level.sotf_loadouts["axis"]["loadoutOffhand"] = "flash_grenade_mp";
  level.sotf_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.sotf_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.sotf_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.sotf_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.sotf_loadouts["axis"]["loadoutJuggernaut"] = 0;
  level.sotf_loadouts["axis"]["loadoutPerks"] = ["specialty_longersprint", "specialty_extra_deadly"];
  level.sotf_loadouts["allies"] = level.sotf_loadouts["axis"];
}

getspawnpoint() {
  var_0 = self.pers["team"];
  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility::getotherteam(var_0);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_2);
  }

  return var_2;
}

onspawnplayer() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  self.pers["gamemodeLoadout"] = level.sotf_loadouts[self.pers["team"]];
  level notify("sotf_player_spawned", self);
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  thread waitloadoutdone();
}

waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("giveLoadout");
  var_0 = self getcurrentweapon();
  self setweaponammostock(var_0, 0);
  self.oldprimarygun = var_0;
  thread pickupweaponhandler();
}

onplayerscore(var_0, var_1) {
  if(var_0 == "kill") {
    var_2 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_2;
  }

  return 0;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
  var_1 perkwatcher();
}

sotf() {
  level thread startspawnchest();
}

startspawnchest() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = getdvarint("scr_sotf_crateamount", 1);
  var_1 = getdvarint("scr_sotf_cratetimer", 30);
  level waittill("sotf_player_spawned", var_2);
  for(;;) {
    if(!isalive(var_2)) {
      var_2 = findnewowner(level.players);
      if(!isDefined(var_2)) {
        continue;
      }

      continue;
    }

    while(isalive(var_2)) {
      if(level.emptylocations) {
        for(var_3 = 0; var_3 < var_0; var_3++) {
          level thread spawnchests(var_2);
        }

        level thread showcratesplash("sotf_crate_incoming");
        wait(var_1);
        continue;
      }

      wait(0.05);
    }
  }
}

showcratesplash(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\hud_message::showsplash(var_0);
  }
}

findnewowner(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      return var_2;
    }
  }

  level waittill("sotf_player_spawned", var_4);
  return var_4;
}

spawnchests(var_0) {
  var_1 = scripts\engine\utility::getstructarray("sotf_chest_spawnpoint", "targetname");
  if(level.firstcratedrop) {
    var_2 = getcenterpoint(var_1);
    level.firstcratedrop = 0;
  } else {
    var_2 = getrandompoint(var_2);
  }

  if(isDefined(var_2)) {
    playfxatpoint(var_2);
    level thread scripts\mp\killstreaks\_airdrop::doflyby(var_0, var_2, randomfloat(360), "airdrop_sotf");
  }
}

playfxatpoint(var_0) {
  var_1 = var_0 + (0, 0, 30);
  var_2 = var_0 + (0, 0, -1000);
  var_3 = bulletTrace(var_1, var_2, 0, undefined);
  var_4 = var_3["position"] + (0, 0, 1);
  var_5 = var_3["entity"];
  if(isDefined(var_5)) {
    for(var_6 = var_5 getlinkedparent(); isDefined(var_6); var_6 = var_5 getlinkedparent()) {
      var_5 = var_6;
    }
  }

  if(isDefined(var_5)) {
    var_7 = spawn("script_model", var_4);
    var_7 setModel("tag_origin");
    var_7.angles = (90, randomintrange(-180, 179), 0);
    var_7 linkto(var_5);
    thread playlinkedsmokeeffect(scripts\engine\utility::getfx("signal_chest_drop_mover"), var_7);
    return;
  }

  playFX(scripts\engine\utility::getfx("signal_chest_drop"), var_4);
}

playlinkedsmokeeffect(var_0, var_1) {
  level endon("game_ended");
  wait(0.05);
  playFXOnTag(var_0, var_1, "tag_origin");
  wait(6);
  stopFXOnTag(var_0, var_1, "tag_origin");
  wait(0.05);
  var_1 delete();
}

getcenterpoint(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  foreach(var_4 in var_0) {
    var_5 = distance2dsquared(level.mapcenter, var_4.origin);
    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  level.usedlocations[level.usedlocations.size] = var_1.origin;
  return var_1.origin;
}

getrandompoint(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 0;
    if(isDefined(level.usedlocations) && level.usedlocations.size > 0) {
      foreach(var_5 in level.usedlocations) {
        if(var_0[var_2].origin == var_5) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        continue;
      }

      var_1[var_1.size] = var_0[var_2].origin;
      continue;
    }

    var_1[var_1.size] = var_0[var_2].origin;
  }

  if(var_1.size > 0) {
    var_7 = randomint(var_1.size);
    var_8 = var_1[var_7];
    level.usedlocations[level.usedlocations.size] = var_8;
    return var_8;
  }

  level.emptylocations = 0;
  return undefined;
}

definechestweapons() {
  var_0 = [];
  var_1 = [];
  for(var_2 = 0; tablelookupbyrow("mp\sotfWeapons.csv", var_2, 0) != ""; var_2++) {
    var_3 = tablelookupbyrow("mp\sotfWeapons.csv", var_2, 2);
    var_4 = tablelookupbyrow("mp\sotfWeapons.csv", var_2, 1);
    var_5 = isselectableweapon(var_3);
    if(isDefined(var_4) && var_5 && var_4 == "weapon_pistol") {
      var_6 = 30;
      var_0[var_0.size]["name"] = var_3;
      var_0[var_0.size - 1]["weight"] = var_6;
      continue;
    }

    if(isDefined(var_4) && var_5 && var_4 == "weapon_shotgun" || var_4 == "weapon_smg" || var_4 == "weapon_assault" || var_4 == "weapon_sniper" || var_4 == "weapon_dmr" || var_4 == "weapon_lmg" || var_4 == "weapon_projectile") {
      var_6 = 0;
      switch (var_4) {
        case "weapon_shotgun":
          var_6 = 35;
          break;

        case "weapon_assault":
        case "weapon_smg":
          var_6 = 25;
          break;

        case "weapon_dmr":
        case "weapon_sniper":
          var_6 = 15;
          break;

        case "weapon_lmg":
          var_6 = 10;
          break;

        case "weapon_projectile":
          var_6 = 30;
          break;
      }

      var_1[var_1.size]["name"] = var_3 + "_mp";
      var_1[var_1.size - 1]["group"] = var_4;
      var_1[var_1.size - 1]["weight"] = var_6;
      continue;
    }

    continue;
  }

  var_1 = sortbyweight(var_1);
  level.pistolarray = var_0;
  level.weaponarray = var_1;
}

sotfcratecontents(var_0, var_1) {
  scripts\mp\killstreaks\_airdrop::addcratetype("airdrop_sotf", "sotf_weapon", 100, ::sotfcratethink, var_0, var_0, &"KILLSTREAKS_HINTS_WEAPON_PICKUP");
}

sotfcratethink(var_0) {
  self endon("death");
  self endon("restarting_physics");
  level endon("game_ended");
  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var_1 = game["strings"][self.cratetype + "_hint"];
  } else {
    var_1 = &"PLATFORM_GET_KILLSTREAK";
  }

  var_2 = "icon_hunted";
  scripts\mp\killstreaks\_airdrop::cratesetupforuse(var_1, var_2);
  thread scripts\mp\killstreaks\_airdrop::crateallcapturethink();
  childthread cratewatcher(60);
  childthread playerjoinwatcher();
  var_3 = 0;
  var_4 = getdvarint("scr_sotf_crategunamount", 6);
  for(;;) {
    self waittill("captured", var_5);
    var_5 playlocalsound("ammo_crate_use");
    var_6 = getrandomweapon(level.weaponarray);
    var_6 = getrandomattachments(var_6);
    var_7 = var_5.lastdroppableweaponobj;
    var_8 = var_5 getrunningforwardpainanim(var_7);
    if(var_6 == var_7) {
      var_5 givestartammo(var_6);
      var_5 setweaponammostock(var_6, var_8);
    } else {
      if(isDefined(var_7) && var_7 != "none") {
        var_9 = var_5 dropitem(var_7);
        if(isDefined(var_9) && var_8 > 0) {
          var_9.var_336 = "dropped_weapon";
        }
      }

      var_5 giveweapon(var_6, 0, 0, 0, 1);
      var_5 setweaponammostock(var_6, 0);
      var_5 scripts\mp\utility::_switchtoweaponimmediate(var_6);
      if(var_5 getweaponammoclip(var_6) == 1) {
        var_5 setweaponammostock(var_6, 1);
      }

      var_5.oldprimarygun = var_6;
    }

    var_3++;
    var_4 = var_4 - 1;
    if(var_4 > 0) {
      foreach(var_5 in level.players) {
        scripts\mp\entityheadicons::setheadicon(var_5, "blitz_time_0" + var_4 + "_blue", (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
        self.crateheadicon = "blitz_time_0" + var_4 + "_blue";
      }
    }

    if(self.cratetype == "sotf_weapon" && var_3 == getdvarint("scr_sotf_crategunamount", 6)) {
      scripts\mp\killstreaks\_airdrop::deletecrateold();
    }
  }
}

cratewatcher(var_0) {
  wait(var_0);
  while(isDefined(self.inuse) && self.inuse) {
    scripts\engine\utility::waitframe();
  }

  scripts\mp\killstreaks\_airdrop::deletecrateold();
}

playerjoinwatcher() {
  for(;;) {
    level waittill("connected", var_0);
    if(!isDefined(var_0)) {
      continue;
    }

    scripts\mp\entityheadicons::setheadicon(var_0, self.crateheadicon, (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  }
}

cratekill(var_0) {
  for(var_1 = 0; var_1 < level.usedlocations.size; var_1++) {
    if(var_0 != level.usedlocations[var_1]) {
      continue;
    }

    level.usedlocations = scripts\engine\utility::array_remove(level.usedlocations, var_0);
  }

  level.emptylocations = 1;
}

isselectableweapon(var_0) {
  var_1 = tablelookup("mp\sotfWeapons.csv", 2, var_0, 3);
  var_2 = tablelookup("mp\sotfWeapons.csv", 2, var_0, 4);
  if(var_1 == "TRUE" && var_2 == "" || getdvarint(var_2, 0) == 1) {
    return 1;
  }

  return 0;
}

getrandomweapon(var_0) {
  var_1 = setbucketval(var_0);
  var_2 = randomint(level.weaponmaxval["sum"]);
  var_3 = undefined;
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!var_1[var_4]["weight"]) {
      continue;
    }

    if(var_1[var_4]["weight"] > var_2) {
      var_3 = var_1[var_4];
      break;
    }
  }

  return var_3;
}

getrandomattachments(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = scripts\mp\utility::getweaponrootname(var_0["name"]);
  var_5 = scripts\mp\utility::getweaponattachmentarrayfromstats(var_4);
  if(var_5.size > 0) {
    var_6 = randomint(5);
    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_1 = getvalidattachments(var_0, var_2, var_5);
      if(var_1.size == 0) {
        break;
      }

      var_8 = randomint(var_1.size);
      var_2[var_2.size] = var_1[var_8];
      var_9 = scripts\mp\utility::attachmentmap_tounique(var_1[var_8], var_4);
      var_3[var_3.size] = var_9;
    }

    var_10 = scripts\mp\utility::getweapongroup(var_0["name"]);
    if(var_10 == "weapon_dmr" || var_10 == "weapon_sniper" || var_4 == "iw7_ripper") {
      var_11 = 0;
      foreach(var_13 in var_2) {
        if(scripts\mp\utility::getattachmenttype(var_13) == "rail") {
          var_11 = 1;
          break;
        }
      }

      if(!var_11 && var_0["name"] != "iw7_m1_mp") {
        var_15 = strtok(var_4, "_")[1];
        var_3[var_3.size] = var_15 + "scope";
      }
    }

    if(var_3.size > 0) {
      var_3 = scripts\engine\utility::alphabetize(var_3);
      foreach(var_11 in var_3) {
        var_0["name"] = var_0["name"] + "_" + var_11;
      }
    }
  }

  return var_0["name"];
}

getvalidattachments(var_0, var_1, var_2) {
  var_3 = [];
  foreach(var_5 in var_2) {
    if(var_5 == "gl" || var_5 == "shotgun") {
      continue;
    }

    var_6 = attachmentcheck(var_5, var_1);
    if(!var_6) {
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  return var_3;
}

attachmentcheck(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2] || !scripts\mp\utility::attachmentscompatible(var_0, var_1[var_2])) {
      return 0;
    }
  }

  return 1;
}

checkscopes(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 == "thermal" || var_2 == "vzscope" || var_2 == "acog" || var_2 == "ironsight") {
      return 1;
    }
  }

  return 0;
}

pickupweaponhandler() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    scripts\engine\utility::waitframe();
    var_0 = self getweaponslistprimaries();
    if(var_0.size > 1) {
      foreach(var_2 in var_0) {
        if(var_2 == self.oldprimarygun) {
          var_3 = self getrunningforwardpainanim(var_2);
          var_4 = self dropitem(var_2);
          if(isDefined(var_4) && var_3 > 0) {
            var_4.var_336 = "dropped_weapon";
          }

          break;
        }
      }

      var_0 = scripts\engine\utility::array_remove(var_0, self.oldprimarygun);
      self.oldprimarygun = var_0[0];
    }
  }
}

loginckillchain() {
  self.pers["killChains"]++;
  scripts\mp\persistence::statsetchild("round", "killChains", self.pers["killChains"]);
}

perkwatcher() {
  if(level.allowperks) {
    switch (self.streakpoints) {
      case 2:
        scripts\mp\utility::giveperk("specialty_fastsprintrecovery");
        thread scripts\mp\hud_message::showsplash("specialty_fastsprintrecovery_sotf", self.streakpoints);
        thread loginckillchain();
        break;

      case 3:
        scripts\mp\utility::giveperk("specialty_lightweight");
        thread scripts\mp\hud_message::showsplash("specialty_lightweight_sotf", self.streakpoints);
        thread loginckillchain();
        break;

      case 4:
        scripts\mp\utility::giveperk("specialty_stalker");
        thread scripts\mp\hud_message::showsplash("specialty_stalker_sotf", self.streakpoints);
        thread loginckillchain();
        break;

      case 5:
        scripts\mp\utility::giveperk("specialty_regenfaster");
        thread scripts\mp\hud_message::showsplash("specialty_regenfaster_sotf", self.streakpoints);
        thread loginckillchain();
        break;

      case 6:
        scripts\mp\utility::giveperk("specialty_deadeye");
        thread scripts\mp\hud_message::showsplash("specialty_deadeye_sotf", self.streakpoints);
        thread loginckillchain();
        break;
    }
  }
}

iconvisall(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_0 scripts\mp\entityheadicons::setheadicon(var_3, var_1, (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
    self.crateheadicon = var_1;
  }
}

objvisall(var_0) {
  scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(var_0);
}

setbucketval(var_0) {
  level.weaponmaxval["sum"] = 0;
  var_1 = var_0;
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!var_1[var_2]["weight"]) {
      continue;
    }

    level.weaponmaxval["sum"] = level.weaponmaxval["sum"] + var_1[var_2]["weight"];
    var_1[var_2]["weight"] = level.weaponmaxval["sum"];
  }

  return var_1;
}

sortbyweight(var_0) {
  var_1 = [];
  var_2 = [];
  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3]["weight"];
    var_1 = var_0[var_3];
    for(var_5 = var_3 - 1; var_5 >= 0 && is_weight_a_less_than_b(var_0[var_5]["weight"], var_4); var_5--) {
      var_2 = var_0[var_5];
      var_0[var_5] = var_1;
      var_0[var_5 + 1] = var_2;
    }
  }

  return var_0;
}

is_weight_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
}