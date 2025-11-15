/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sotf.gsc
*****************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
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
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
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
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  var_02 = & "OBJECTIVES_WAR";
  var_03 = & "OBJECTIVES_WAR_SCORE";
  var_04 = & "OBJECTIVES_WAR_HINT";
  scripts\mp\utility::setobjectivetext("allies", var_02);
  scripts\mp\utility::setobjectivetext("axis", var_02);
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", var_02);
    scripts\mp\utility::setobjectivescoretext("axis", var_02);
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", var_03);
    scripts\mp\utility::setobjectivescoretext("axis", var_03);
  }

  scripts\mp\utility::setobjectivehinttext("allies", var_04);
  scripts\mp\utility::setobjectivehinttext("axis", var_04);
  initspawns();
  var_05 = [];
  scripts\mp\gameobjects::main(var_05);
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
  var_00 = getrandomweapon(level.pistolarray);
  var_01 = scripts\mp\utility::getweaponrootname(var_00["name"]);
  var_02 = tablelookup("mp\sotfWeapons.csv", 2, var_01, 0);
  setomnvar("ui_sotf_pistol", int(var_02));
  level.sotf_loadouts["axis"]["loadoutPrimary"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondary"] = var_00["name"];
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
  var_00 = self.pers["team"];
  if(game["switchedsides"]) {
    var_00 = scripts\mp\utility::getotherteam(var_00);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_01 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
    var_02 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_01);
  } else {
    var_01 = scripts\mp\spawnlogic::getteamspawnpoints(var_02);
    var_02 = scripts\mp\spawnscoring::getspawnpoint(var_02);
  }

  return var_02;
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
  var_00 = self getcurrentweapon();
  self setweaponammostock(var_00, 0);
  self.oldprimarygun = var_00;
  thread pickupweaponhandler();
}

onplayerscore(param_00, param_01) {
  if(param_00 == "kill") {
    var_02 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_02;
  }

  return 0;
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  scripts\mp\gametypes\common::onnormaldeath(param_00, param_01, param_02, param_03, param_04);
  param_01 perkwatcher();
}

sotf() {
  level thread startspawnchest();
}

startspawnchest() {
  level endon("game_ended");
  self endon("disconnect");
  var_00 = getdvarint("scr_sotf_crateamount", 1);
  var_01 = getdvarint("scr_sotf_cratetimer", 30);
  level waittill("sotf_player_spawned", var_02);
  for(;;) {
    if(!isalive(var_02)) {
      var_02 = findnewowner(level.players);
      if(!isDefined(var_02)) {
        continue;
      }

      continue;
    }

    while(isalive(var_02)) {
      if(level.emptylocations) {
        for(var_03 = 0; var_03 < var_00; var_03++) {
          level thread spawnchests(var_02);
        }

        level thread showcratesplash("sotf_crate_incoming");
        wait(var_01);
        continue;
      }

      wait(0.05);
    }
  }
}

showcratesplash(param_00) {
  foreach(var_02 in level.players) {
    var_02 thread scripts\mp\hud_message::showsplash(param_00);
  }
}

findnewowner(param_00) {
  foreach(var_02 in param_00) {
    if(isalive(var_02)) {
      return var_02;
    }
  }

  level waittill("sotf_player_spawned", var_04);
  return var_04;
}

spawnchests(param_00) {
  var_01 = scripts\engine\utility::getstructarray("sotf_chest_spawnpoint", "targetname");
  if(level.firstcratedrop) {
    var_02 = getcenterpoint(var_01);
    level.firstcratedrop = 0;
  } else {
    var_02 = getrandompoint(var_02);
  }

  if(isDefined(var_02)) {
    playfxatpoint(var_02);
    level thread scripts\mp\killstreaks\_airdrop::doflyby(param_00, var_02, randomfloat(360), "airdrop_sotf");
  }
}

playfxatpoint(param_00) {
  var_01 = param_00 + (0, 0, 30);
  var_02 = param_00 + (0, 0, -1000);
  var_03 = bulletTrace(var_01, var_02, 0, undefined);
  var_04 = var_03["position"] + (0, 0, 1);
  var_05 = var_03["entity"];
  if(isDefined(var_05)) {
    for(var_06 = var_05 getlinkedparent(); isDefined(var_06); var_06 = var_05 getlinkedparent()) {
      var_05 = var_06;
    }
  }

  if(isDefined(var_05)) {
    var_07 = spawn("script_model", var_04);
    var_07 setModel("tag_origin");
    var_07.angles = (90, randomintrange(-180, 179), 0);
    var_07 linkto(var_05);
    thread playlinkedsmokeeffect(scripts\engine\utility::getfx("signal_chest_drop_mover"), var_07);
    return;
  }

  playFX(scripts\engine\utility::getfx("signal_chest_drop"), var_04);
}

playlinkedsmokeeffect(param_00, param_01) {
  level endon("game_ended");
  wait(0.05);
  playFXOnTag(param_00, param_01, "tag_origin");
  wait(6);
  stopFXOnTag(param_00, param_01, "tag_origin");
  wait(0.05);
  param_01 delete();
}

getcenterpoint(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in param_00) {
    var_05 = distance2dsquared(level.mapcenter, var_04.origin);
    if(!isDefined(var_01) || var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  level.usedlocations[level.usedlocations.size] = var_01.origin;
  return var_01.origin;
}

getrandompoint(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = 0;
    if(isDefined(level.usedlocations) && level.usedlocations.size > 0) {
      foreach(var_05 in level.usedlocations) {
        if(param_00[var_02].origin == var_05) {
          var_03 = 1;
          break;
        }
      }

      if(var_03) {
        continue;
      }

      var_01[var_01.size] = param_00[var_02].origin;
      continue;
    }

    var_01[var_01.size] = param_00[var_02].origin;
  }

  if(var_01.size > 0) {
    var_07 = randomint(var_01.size);
    var_08 = var_01[var_07];
    level.usedlocations[level.usedlocations.size] = var_08;
    return var_08;
  }

  level.emptylocations = 0;
  return undefined;
}

definechestweapons() {
  var_00 = [];
  var_01 = [];
  for(var_02 = 0; tablelookupbyrow("mp\sotfWeapons.csv", var_02, 0) != ""; var_02++) {
    var_03 = tablelookupbyrow("mp\sotfWeapons.csv", var_02, 2);
    var_04 = tablelookupbyrow("mp\sotfWeapons.csv", var_02, 1);
    var_05 = isselectableweapon(var_03);
    if(isDefined(var_04) && var_05 && var_04 == "weapon_pistol") {
      var_06 = 30;
      var_00[var_00.size]["name"] = var_03;
      var_00[var_00.size - 1]["weight"] = var_06;
      continue;
    }

    if(isDefined(var_04) && var_05 && var_04 == "weapon_shotgun" || var_04 == "weapon_smg" || var_04 == "weapon_assault" || var_04 == "weapon_sniper" || var_04 == "weapon_dmr" || var_04 == "weapon_lmg" || var_04 == "weapon_projectile") {
      var_06 = 0;
      switch (var_04) {
        case "weapon_shotgun":
          var_06 = 35;
          break;

        case "weapon_assault":
        case "weapon_smg":
          var_06 = 25;
          break;

        case "weapon_dmr":
        case "weapon_sniper":
          var_06 = 15;
          break;

        case "weapon_lmg":
          var_06 = 10;
          break;

        case "weapon_projectile":
          var_06 = 30;
          break;
      }

      var_01[var_01.size]["name"] = var_03 + "_mp";
      var_01[var_01.size - 1]["group"] = var_04;
      var_01[var_01.size - 1]["weight"] = var_06;
      continue;
    }

    continue;
  }

  var_01 = sortbyweight(var_01);
  level.pistolarray = var_00;
  level.weaponarray = var_01;
}

sotfcratecontents(param_00, param_01) {
  scripts\mp\killstreaks\_airdrop::addcratetype("airdrop_sotf", "sotf_weapon", 100, ::sotfcratethink, param_00, param_00, & "KILLSTREAKS_HINTS_WEAPON_PICKUP");
}

sotfcratethink(param_00) {
  self endon("death");
  self endon("restarting_physics");
  level endon("game_ended");
  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var_01 = game["strings"][self.cratetype + "_hint"];
  } else {
    var_01 = & "PLATFORM_GET_KILLSTREAK";
  }

  var_02 = "icon_hunted";
  scripts\mp\killstreaks\_airdrop::cratesetupforuse(var_01, var_02);
  thread scripts\mp\killstreaks\_airdrop::crateallcapturethink();
  childthread cratewatcher(60);
  childthread playerjoinwatcher();
  var_03 = 0;
  var_04 = getdvarint("scr_sotf_crategunamount", 6);
  for(;;) {
    self waittill("captured", var_05);
    var_05 playlocalsound("ammo_crate_use");
    var_06 = getrandomweapon(level.weaponarray);
    var_06 = getrandomattachments(var_06);
    var_07 = var_05.lastdroppableweaponobj;
    var_08 = var_05 getrunningforwardpainanim(var_07);
    if(var_06 == var_07) {
      var_05 givestartammo(var_06);
      var_05 setweaponammostock(var_06, var_08);
    } else {
      if(isDefined(var_07) && var_07 != "none") {
        var_09 = var_05 dropitem(var_07);
        if(isDefined(var_09) && var_08 > 0) {
          var_09.var_336 = "dropped_weapon";
        }
      }

      var_05 giveweapon(var_06, 0, 0, 0, 1);
      var_05 setweaponammostock(var_06, 0);
      var_05 scripts\mp\utility::_switchtoweaponimmediate(var_06);
      if(var_05 getweaponammoclip(var_06) == 1) {
        var_05 setweaponammostock(var_06, 1);
      }

      var_05.oldprimarygun = var_06;
    }

    var_03++;
    var_04 = var_04 - 1;
    if(var_04 > 0) {
      foreach(var_05 in level.players) {
        scripts\mp\entityheadicons::setheadicon(var_05, "blitz_time_0" + var_04 + "_blue", (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
        self.crateheadicon = "blitz_time_0" + var_04 + "_blue";
      }
    }

    if(self.cratetype == "sotf_weapon" && var_03 == getdvarint("scr_sotf_crategunamount", 6)) {
      scripts\mp\killstreaks\_airdrop::deletecrateold();
    }
  }
}

cratewatcher(param_00) {
  wait(param_00);
  while(isDefined(self.inuse) && self.inuse) {
    scripts\engine\utility::waitframe();
  }

  scripts\mp\killstreaks\_airdrop::deletecrateold();
}

playerjoinwatcher() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00)) {
      continue;
    }

    scripts\mp\entityheadicons::setheadicon(var_00, self.crateheadicon, (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  }
}

cratekill(param_00) {
  for(var_01 = 0; var_01 < level.usedlocations.size; var_01++) {
    if(param_00 != level.usedlocations[var_01]) {
      continue;
    }

    level.usedlocations = scripts\engine\utility::array_remove(level.usedlocations, param_00);
  }

  level.emptylocations = 1;
}

isselectableweapon(param_00) {
  var_01 = tablelookup("mp\sotfWeapons.csv", 2, param_00, 3);
  var_02 = tablelookup("mp\sotfWeapons.csv", 2, param_00, 4);
  if(var_01 == "TRUE" && var_02 == "" || getdvarint(var_02, 0) == 1) {
    return 1;
  }

  return 0;
}

getrandomweapon(param_00) {
  var_01 = setbucketval(param_00);
  var_02 = randomint(level.weaponmaxval["sum"]);
  var_03 = undefined;
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    if(!var_01[var_04]["weight"]) {
      continue;
    }

    if(var_01[var_04]["weight"] > var_02) {
      var_03 = var_01[var_04];
      break;
    }
  }

  return var_03;
}

getrandomattachments(param_00) {
  var_01 = [];
  var_02 = [];
  var_03 = [];
  var_04 = scripts\mp\utility::getweaponrootname(param_00["name"]);
  var_05 = scripts\mp\utility::getweaponattachmentarrayfromstats(var_04);
  if(var_05.size > 0) {
    var_06 = randomint(5);
    for(var_07 = 0; var_07 < var_06; var_07++) {
      var_01 = getvalidattachments(param_00, var_02, var_05);
      if(var_01.size == 0) {
        break;
      }

      var_08 = randomint(var_01.size);
      var_02[var_02.size] = var_01[var_08];
      var_09 = scripts\mp\utility::attachmentmap_tounique(var_01[var_08], var_04);
      var_03[var_03.size] = var_09;
    }

    var_0A = scripts\mp\utility::getweapongroup(param_00["name"]);
    if(var_0A == "weapon_dmr" || var_0A == "weapon_sniper" || var_04 == "iw7_ripper") {
      var_0B = 0;
      foreach(var_0D in var_02) {
        if(scripts\mp\utility::getattachmenttype(var_0D) == "rail") {
          var_0B = 1;
          break;
        }
      }

      if(!var_0B && param_00["name"] != "iw7_m1_mp") {
        var_0F = strtok(var_04, "_")[1];
        var_03[var_03.size] = var_0F + "scope";
      }
    }

    if(var_03.size > 0) {
      var_03 = scripts\engine\utility::alphabetize(var_03);
      foreach(var_11 in var_03) {
        param_00["name"] = param_00["name"] + "_" + var_11;
      }
    }
  }

  return param_00["name"];
}

getvalidattachments(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in param_02) {
    if(var_05 == "gl" || var_05 == "shotgun") {
      continue;
    }

    var_06 = attachmentcheck(var_05, param_01);
    if(!var_06) {
      continue;
    }

    var_03[var_03.size] = var_05;
  }

  return var_03;
}

attachmentcheck(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(param_00 == param_01[var_02] || !scripts\mp\utility::attachmentscompatible(param_00, param_01[var_02])) {
      return 0;
    }
  }

  return 1;
}

checkscopes(param_00) {
  foreach(var_02 in param_00) {
    if(var_02 == "thermal" || var_02 == "vzscope" || var_02 == "acog" || var_02 == "ironsight") {
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
    var_00 = self getweaponslistprimaries();
    if(var_00.size > 1) {
      foreach(var_02 in var_00) {
        if(var_02 == self.oldprimarygun) {
          var_03 = self getrunningforwardpainanim(var_02);
          var_04 = self dropitem(var_02);
          if(isDefined(var_04) && var_03 > 0) {
            var_04.var_336 = "dropped_weapon";
          }

          break;
        }
      }

      var_00 = scripts\engine\utility::array_remove(var_00, self.oldprimarygun);
      self.oldprimarygun = var_00[0];
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

iconvisall(param_00, param_01) {
  foreach(var_03 in level.players) {
    param_00 scripts\mp\entityheadicons::setheadicon(var_03, param_01, (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
    self.crateheadicon = param_01;
  }
}

objvisall(param_00) {
  scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(param_00);
}

setbucketval(param_00) {
  level.weaponmaxval["sum"] = 0;
  var_01 = param_00;
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(!var_01[var_02]["weight"]) {
      continue;
    }

    level.weaponmaxval["sum"] = level.weaponmaxval["sum"] + var_01[var_02]["weight"];
    var_01[var_02]["weight"] = level.weaponmaxval["sum"];
  }

  return var_01;
}

sortbyweight(param_00) {
  var_01 = [];
  var_02 = [];
  for(var_03 = 1; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03]["weight"];
    var_01 = param_00[var_03];
    for(var_05 = var_03 - 1; var_05 >= 0 && is_weight_a_less_than_b(param_00[var_05]["weight"], var_04); var_05--) {
      var_02 = param_00[var_05];
      param_00[var_05] = var_01;
      param_00[var_05 + 1] = var_02;
    }
  }

  return param_00;
}

is_weight_a_less_than_b(param_00, param_01) {
  return param_00 < param_01;
}