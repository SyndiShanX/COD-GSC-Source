/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dm.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("scr_dm_aonrules", getmatchrulesdata("dmData", "aonRules"));
  setdynamicdvar("scr_dm_scoreontargetplayer", getmatchrulesdata("dmData", "scoreOnTargetPlayer"));
  setdynamicdvar("scr_dm_targetplayercycle", getmatchrulesdata("dmData", "targetPlayerCycle"));
  setdynamicdvar("scr_dm_showtargettime", getmatchrulesdata("dmData", "showTargetTime"));
  setdynamicdvar("scr_dm_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("dm", 1);
  setdynamicdvar("scr_dm_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("dm", 1);
  setdynamicdvar("scr_dm_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dm", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/DM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/DM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/DM_HINT");
  }

  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dm", var3);
  scripts\mp\spawnlogic::registerspawnset("dm_fallback", var4);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.aonrules = scripts\mp\utility\dvars::dvarintvalue("aonRules", 0, 0, 4);
  level.scoreontargetplayer = scripts\mp\utility\dvars::dvarintvalue("scoreOnTargetPlayer", 0, 0, 1);
  level.targetplayercycle = scripts\mp\utility\dvars::dvarintvalue("targetPlayerCycle", 0, 0, 1);
  level.showtargettime = scripts\mp\utility\dvars::dvarintvalue("showTargetTime", 1, 0, 6);

  switch (level.showtargettime) {
    case 0:
      level.objpingdelay = 60;
      break;
    case 1:
      level.objpingdelay = 0.05;
      break;
    case 2:
      level.objpingdelay = 1;
      break;
    case 3:
      level.objpingdelay = 1.5;
      break;
    case 4:
      level.objpingdelay = 2;
      break;
    case 5:
      level.objpingdelay = 3;
      break;
    case 6:
      level.objpingdelay = 4;
      break;
  }

  if(level.aonrules > 0) {
    level.blockweapondrops = 1;
    return;
  }

  level notify("cancel_loadweapons");
}

function getspawnpoint() {
  var0 = undefined;

  if(level.ingraceperiod) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(isDefined(level.requiresminstartspawns)) {}

    if(var1.size > 0) {
      var0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1, 1);
    }

    if(!isDefined(var0)) {
      var1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var1);
    }
  } else {
    var0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "dm", "dm_fallback");
  }

  return var0;
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", 0);

  if(level.aonrules > 0) {
    thread onspawnfinished();
  }

  if(level.scoreontargetplayer) {
    if(!isDefined(self.targetvictim)) {
      thread gettarget();
      thread newtargetmessage();
    }
  }

  level notify("spawned_player");
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);

  if(level.aonrules > 0) {}

  var6 = 0;

  foreach(var8 in level.players) {
    if(isDefined(var8.score) && var8.score > var6) {
      var6 = var8.score;
    }
  }

  if(!level.didhalfscorevoboost) {
    if(var1.score >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      thread dohalftimevo(var1);
    }
  }

  if(var1.score == level.scorelimit - 2) {
    level.kick_afk_check = 1;
  }

  var10 = var1 scripts\mp\utility\stats::getpersstat("killChains");

  if(isDefined(var10)) {
    var1 scripts\mp\utility\stats::setextrascore1(var10);
    return;
  }
}

function onplayerscore(var0, var1, var2, var3) {
  var1 scripts\mp\utility\stats::incpersstat("gamemodeScore", var2);
  var4 = int(var1 scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  var1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var4);

  if(var1.pers["cur_kill_streak"] > var1 scripts\mp\utility\stats::getpersstat("killChains")) {
    var1.pers["killChains"] = var1.pers["cur_kill_streak"];
    var1 scripts\mp\utility\stats::setextrascore1(var1.pers["cur_kill_streak"]);
  }

  if(issubstr(var0, "super_")) {
    return 0;
  }

  if(issubstr(var0, "kill_ss")) {
    return 0;
  }

  if(issubstr(var0, "kill")) {
    if(level.scoreontargetplayer) {
      if(var3 != var1.targetvictim) {
        return 0;
      } else {
        var1 notify("target_eliminated");
        var1.targetvictim = undefined;
        thread gettarget();
        thread newtargetmessage();
      }
    }

    var5 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var5;
  } else if(var1 == "assist_ffa") {
    var2 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var3);
  }

  return 0;
}

function dohalftimevo(var0) {
  var0 scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_first");
  var1 = scripts\engine\utility::array_sort_with_func(level.players, &compare_player_score);

  if(isDefined(var1[1])) {
    var1[1] scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_second");
  }

  if(isDefined(var1[2]) && var1.size > 2) {
    var1[2] scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_third");
  }

  if(isDefined(var1[var1.size - 1]) && var1.size > 3) {
    var1[var1.size - 1] scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_last");
  }

  level.didhalfscorevoboost = 1;
}

function compare_player_score(var0, var1) {
  return var0.score >= var1.score;
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  self setclientomnvar("ui_skip_loadout", 1);
  self waittill("giveLoadout");
  runaonrules();
}

function setspecialloadout() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    var0 = scripts\engine\utility::ter_op(randomintrange(0, 99) > 50, "iw8_me_akimboblades", "iw8_knife");

    if(var0 == "iw8_knife") {
      var1 = 11;
    } else {
      var1 = 0;
    }

    if(getdvarint("scr_dm_randomAONMelee", 1) == 1) {
      var2 = randomintrange(0, 99);

      if(var2 > 75) {
        var1 = "iw8_me_akimboblunt";
        var1 = 2;
      }
    }
  } else {
    switch (level.aonrules) {
      case 1:
        var0 = "iw8_knife";
        var1 = 11;
        break;
      case 2:
        var0 = "iw8_me_akimboblades";
        var1 = 0;
        break;
      case 3:
        var0 = "iw8_me_akimboblunt";
        var1 = 2;
        break;
      default:
        var0 = "iw8_knife";
        var1 = 11;
        break;
    }
  }

  level.aon_loadouts["allies"]["loadoutPrimary"] = var0;
  level.aon_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryVariantID"] = var1;
  level.aon_loadouts["allies"]["loadoutSecondary"] = "iw8_pi_golf21";
  level.aon_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryVariantID"] = 1;
  level.aon_loadouts["allies"]["loadoutEquipmentPrimary"] = "equip_throwing_knife";
  level.aon_loadouts["allies"]["loadoutEquipmentSecondary"] = "none";
  level.aon_loadouts["allies"]["loadoutSuper"] = "none";
  level.aon_loadouts["allies"]["loadoutStreakType"] = "assault";
  level.aon_loadouts["allies"]["loadoutKillstreak1"] = "none";
  level.aon_loadouts["allies"]["loadoutKillstreak2"] = "none";
  level.aon_loadouts["allies"]["loadoutKillstreak3"] = "none";
  level.aon_loadouts["allies"]["loadoutUsingSpecialist"] = 1;
  level.aon_loadouts["allies"]["loadoutPerks"] = ["specialty_hustle", "specialty_hardline"];
  level.aon_loadouts["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_huntmaster", "specialty_surveillance"];
  level.aon_loadouts["allies"]["loadoutGesture"] = "playerData";
  level.aon_loadouts["allies"]["loadoutFieldUpgrade1"] = "super_deadsilence";
  level.aon_loadouts["allies"]["loadoutFieldUpgrade2"] = "none";
  level.aon_loadouts["axis"] = level.aon_loadouts["allies"];
}

function runaonrules() {
  giveextraaonperks();
  var0 = getcompleteweaponname("iw8_knifestab_mp");
  self giveweapon(var0);
  self assignweaponmeleeslot(var0);
}

function giveextraaonperks() {
  var0 = ["specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker"];

  foreach(var2 in var0) {
    scripts\mp\utility\perk::giveperk(var2);
  }
}

function onplayerconnect(var0) {
  if(level.aonrules > 0) {
    if(level.allowkillstreaks) {}

    var0.pers["class"] = "gamemode";
    var0.pers["lastClass"] = "";
    var0.class = var0.pers["class"];
    var0.lastclass = var0.pers["lastClass"];
    var0.pers["gamemodeLoadout"] = level.aon_loadouts["allies"];
    var0 loadweaponsforplayer(["iw8_pi_golf21_mp", "iw8_knife_mp"], 1);
    return;
  }
}

function gettarget() {
  level endon("game_ended");
  self notify("get_target");
  self endon("get_target");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  var0 = 0;

  if(!isDefined(self.targetarray) || !level.targetplayercycle) {
    self.targetarray = [];
    self.targetindex = 0;
    var0 = 1;

    foreach(var2 in level.players) {
      if(var2 == self) {
        continue;
      }

      self.targetarray[self.targetarray.size] = var2;
    }
  }

  if(self.targetarray.size > 0) {
    if(!level.targetplayercycle) {
      self.targetindex = randomint(self.targetarray.size);
    } else {
      if(!var0) {
        self.targetindex++;
      }

      if(self.targetindex == self.targetarray.size) {
        self.targetindex = 0;
      }
    }
  }

  self.targetvictim = self.targetarray[self.targetindex];

  if(!isDefined(self.targetvictim)) {
    waitframe();
    thread gettarget();
    thread newtargetmessage();
    return;
  }

  waitframe();

  if(level.showtargettime != 0) {
    self.curorigin = self.origin;
    self.offset3d = (0, 0, 10);
    scripts\mp\gameobjects::requestid(1, 1);
    var4 = self.objidnum;
    objective_setlabel(var4, "MP_INGAME_ONLY/OBJ_TARGET_CAPS");
    objective_setzoffset(var4, 90);
    objective_icon(var4, "hud_icon_targeted_player_cir");
    objective_setplayintro(var4, 1);
    scripts\mp\objidpoolmanager::objective_playermask_single(var4, self);
    objective_setbackground(var4, 2);
    objective_position(var4, self.curorigin);
    objective_state(var4, "current");
    scripts\mp\objidpoolmanager::update_objective_onentity(var4, self.targetvictim);
    objective_setownerclient(var4, self.targetvictim);

    if(level.showtargettime > 1) {
      thread updatetargetlocation();
    }
  }

  thread targetvictimdeathwatcher();
}

function targetvictimdeathwatcher() {
  level endon("game_ended");
  self waittill("target_eliminated");
  thread scripts\mp\hud_message::showsplash("target_eliminated", scripts\mp\rank::getscoreinfovalue("kill"));
  objective_state(self.objidnum, "done");
  scripts\mp\gameobjects::releaseid();
}

function updatetargetlocation() {
  level endon("game_ended");
  self.targetvictim endon("disconnect");
  self endon("target_eliminated");
  thread updatetargetcurorigin();
  objective_setpings(self.objidnum, 1);

  if(!isDefined(level.objpingdelay)) {
    level.objpingdelay = 3;
  }

  for(;;) {
    if(isDefined(self.targetvictim)) {
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.curorigin + self.offset3d);
      objective_ping(self.objidnum);
      wait level.objpingdelay;
      continue;
    }

    waitframe();
  }
}

function updatetargetcurorigin() {
  level endon("game_ended");
  self.targetvictim endon("disconnect");
  self endon("target_eliminated");

  for(;;) {
    if(isDefined(self.targetvictim)) {
      self.curorigin = self.targetvictim.origin + (0, 0, 90);
    }

    waitframe();
  }
}

function newtargetmessage() {
  level endon("game_ended");
  self notify("endDeathWatcher");
  self endon("endDeathWatcher");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  wait 2.5;

  if(isDefined(self.targetvictim)) {
    self iprintlnbold(&"MP/DM_NEW_TARGET", self.targetvictim.name);
    return;
  }
}