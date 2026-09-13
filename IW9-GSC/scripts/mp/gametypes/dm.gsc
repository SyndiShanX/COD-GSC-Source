/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dm.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 30);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 0;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerscore = ::onplayerscore;
  level.didhalfscorevoboost = 0;
  setteammode("ffa");

  if(istrue(level.aonrules)) {
    level.denyclasschoice = 1;
    _id_0FD32F08E72B657F::addspecialistdialog();
    level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
    setspecialloadout();
    game["dialog"]["gametype"] = "gametype_aon";
  } else if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mffa_mode_uktl_fft1";
  else
    game["dialog"]["gametype"] = "iw9_mffa_mode_uktl_name";

  game["dialog"]["ffa_lead_first"] = "iw9_mffa_mode_uktl_ffp1";
  game["dialog"]["ffa_lead_second"] = "iw9_mffa_mode_uktl_ffp2";
  game["dialog"]["ffa_lead_third"] = "iw9_mffa_mode_uktl_ffp3";
  game["dialog"]["ffa_lead_last"] = "iw9_mffa_mode_uktl_ffp3";
  game["dialog"]["offense_obj"] = "iw9_mffa_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mffa_mode_uktl_bost";
}

initializematchrules() {
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

onstartgametype() {
  setclientnamemode("auto_change");

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DM_HINT");
  }

  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dm", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("dm_fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.aonrules = scripts\mp\utility\dvars::dvarintvalue("aonRules", 0, 0, 4);
  level.scoreontargetplayer = scripts\mp\utility\dvars::dvarintvalue("scoreOnTargetPlayer", 0, 0, 1);
  level.targetplayercycle = scripts\mp\utility\dvars::dvarintvalue("targetPlayerCycle", 0, 0, 1);
  level.showtargettime = scripts\mp\utility\dvars::dvarintvalue("showTargetTime", 1, 0, 6);

  switch (level.showtargettime) {
    case 0:
      level.objpingdelay = 60.0;
      break;
    case 1:
      level.objpingdelay = 0.05;
      break;
    case 2:
      level.objpingdelay = 1.0;
      break;
    case 3:
      level.objpingdelay = 1.5;
      break;
    case 4:
      level.objpingdelay = 2.0;
      break;
    case 5:
      level.objpingdelay = 3.0;
      break;
    case 6:
      level.objpingdelay = 4.0;
      break;
  }

  if(level.aonrules > 0)
    level.blockweapondrops = 1;
  else
    level notify("cancel_loadweapons");
}

getspawnpoint() {
  spawnpoint = undefined;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(!isDefined(level.requiresminstartspawns)) {}

    if(spawnpoints.size > 0)
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints, 1);

    if(!isDefined(spawnpoint)) {
      spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      spawnpoint = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(spawnpoints);
    }
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, "none", "dm", "dm_fallback");

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");

  if(level.aonrules > 0)
    thread onspawnfinished();

  if(level.scoreontargetplayer) {
    if(!isDefined(self.targetvictim)) {
      thread gettarget();
      thread newtargetmessage();
    }
  }

  level notify("spawned_player");
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_9570B6E76C7E14F9 = _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(istrue(_id_9570B6E76C7E14F9)) {
    return;
  }
  _id_C7761B0132ABCFA7 = 0;

  foreach(player in level.players) {
    if(isDefined(player.score) && player.score > _id_C7761B0132ABCFA7)
      _id_C7761B0132ABCFA7 = player.score;
  }

  if(!level.didhalfscorevoboost) {
    if(attacker.score >= int(level.scorelimit * level.currentround - level.scorelimit / 2))
      thread dohalftimevo(attacker);
  }

  if(attacker.score == level.scorelimit - 2)
    level.kick_afk_check = 1;

  _id_153FDEE861E0F06F = attacker scripts\mp\utility\stats::getpersstat("killChains");

  if(isDefined(_id_153FDEE861E0F06F))
    attacker scripts\mp\utility\stats::setextrascore1(_id_153FDEE861E0F06F);
}

onplayerscore(event, player, _id_353F1E80E9476419, victim, _id_7EC7671A1E0C788F) {
  player scripts\mp\utility\stats::incpersstat("gamemodeScore", _id_353F1E80E9476419);
  _id_C82F49D7E44EB40D = int(player scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  player scripts\mp\persistence::statsetchild("round", "gamemodeScore", _id_C82F49D7E44EB40D);

  if(player.pers["cur_kill_streak"] > player scripts\mp\utility\stats::getpersstat("killChains")) {
    player.pers["killChains"] = player.pers["cur_kill_streak"];
    player scripts\mp\utility\stats::setextrascore1(player.pers["cur_kill_streak"]);
  }

  if(isDefined(_id_7EC7671A1E0C788F)) {
    if(istrue(_id_7EC7671A1E0C788F._id_3A13C58C2A354968))
      return 0;
  }

  if(event == "stat_EF9582D72160F199" || isDefined(_id_7EC7671A1E0C788F) && istrue(_id_7EC7671A1E0C788F._id_E0BADEC2B1517CA3)) {
    if(level.scoreontargetplayer) {
      if(victim != player.targetvictim)
        return 0;
      else {
        player notify("target_eliminated");
        player.targetvictim = undefined;
        player thread gettarget();
        player thread newtargetmessage();
      }
    }

    _id_CC7886247A15DFDF = scripts\mp\rank::getscoreinfovalue("stat_CADE9C820001F3BF");
    return _id_CC7886247A15DFDF;
  } else if(event == "stat_FE68DFA78D19874E")
    player scripts\mp\utility\script::bufferednotify("earned_score_buffered", _id_353F1E80E9476419);

  return 0;
}

dohalftimevo(attacker) {
  attacker scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_first");
  _id_BFC65A378A6D8EFE = scripts\engine\utility::array_sort_with_func(level.players, ::compare_player_score);

  if(isDefined(_id_BFC65A378A6D8EFE[1]))
    _id_BFC65A378A6D8EFE[1] scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_second");

  if(isDefined(_id_BFC65A378A6D8EFE[2]) && _id_BFC65A378A6D8EFE.size > 2)
    _id_BFC65A378A6D8EFE[2] scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_third");

  if(isDefined(_id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size - 1]) && _id_BFC65A378A6D8EFE.size > 3)
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size - 1] scripts\mp\utility\dialog::leaderdialogonplayer("ffa_lead_last");

  level.didhalfscorevoboost = 1;
}

compare_player_score(left, right) {
  return left.score >= right.score;
}

onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  runaonrules();
}

setspecialloadout() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_144130378B339AB7 = scripts\engine\utility::ter_op(randomintrange(0, 99) > 50, "iw8_me_akimboblades", "iw8_knife");

    if(_id_144130378B339AB7 == "iw8_knife")
      variantid = 11;
    else
      variantid = 0;

    if(getdvarint("dvar_13114BE89D903DC0", 1) == 1) {
      _id_15F8181003E5624C = randomintrange(0, 99);

      if(_id_15F8181003E5624C > 75) {
        _id_144130378B339AB7 = "iw8_me_akimboblunt";
        variantid = 2;
      }
    }
  } else {
    switch (level.aonrules) {
      case 1:
        _id_144130378B339AB7 = "iw8_knife";
        variantid = 11;
        break;
      case 2:
        _id_144130378B339AB7 = "iw8_me_akimboblades";
        variantid = 0;
        break;
      case 3:
        _id_144130378B339AB7 = "iw8_me_akimboblunt";
        variantid = 2;
        break;
      default:
        _id_144130378B339AB7 = "iw8_knife";
        variantid = 11;
        break;
    }
  }

  level.aon_loadouts["allies"]["loadoutPrimary"] = _id_144130378B339AB7;
  level.aon_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryVariantID"] = variantid;
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

runaonrules() {
  giveextraaonperks();
  _id_F968C960C23738E6 = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_knifestab_mp");
  self giveweapon(_id_F968C960C23738E6);
  self assignweaponmeleeslot(_id_F968C960C23738E6);
}

giveextraaonperks() {
  _id_50D0559DCBA571E2 = ["specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker"];

  foreach(perk in _id_50D0559DCBA571E2)
  scripts\mp\utility\perk::giveperk(perk);
}

onplayerconnect(player) {
  if(level.aonrules > 0) {
    if(level.allowkillstreaks) {}

    player scripts\mp\class::_id_A16868D4DCD81A4B();
    player.pers["gamemodeLoadout"] = level.aon_loadouts["allies"];
    player loadweaponsforplayer(["iw8_pi_golf21_mp", "iw8_knife_mp"], 1);
  }
}

gettarget() {
  level endon("game_ended");
  self notify("get_target");
  self endon("get_target");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level waittill("prematch_done");

  firsttime = 0;

  if(!isDefined(self.targetarray) || !level.targetplayercycle) {
    self.targetarray = [];
    self.targetindex = 0;
    firsttime = 1;

    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(_id_AC0E424AC96A7113 == self)
        continue;
      else
        self.targetarray[self.targetarray.size] = _id_AC0E424AC96A7113;
    }
  }

  if(self.targetarray.size > 0) {
    if(!level.targetplayercycle)
      self.targetindex = randomint(self.targetarray.size);
    else {
      if(!firsttime)
        self.targetindex++;

      if(self.targetindex == self.targetarray.size)
        self.targetindex = 0;
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
    objid = self.objidnum;
    objective_setlabel(objid, "MP_INGAME_ONLY/OBJ_TARGET_CAPS");
    objective_setzoffset(objid, 90);
    objective_icon(objid, "hud_icon_targeted_player_cir");
    objective_setplayintro(objid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_single(objid, self);
    objective_setbackground(objid, 2);
    objective_position(objid, self.curorigin);
    objective_state(objid, "current");
    scripts\mp\objidpoolmanager::update_objective_onentity(objid, self.targetvictim);
    objective_setownerclient(objid, self.targetvictim);

    if(level.showtargettime > 1)
      thread updatetargetlocation();
  }

  thread targetvictimdeathwatcher();
}

targetvictimdeathwatcher() {
  level endon("game_ended");
  self waittill("target_eliminated");
  thread scripts\mp\hud_message::showsplash("target_eliminated", scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199"));
  objective_state(self.objidnum, "done");
  scripts\mp\gameobjects::releaseid();
}

updatetargetlocation() {
  level endon("game_ended");
  self.targetvictim endon("disconnect");
  self endon("target_eliminated");
  thread updatetargetcurorigin();
  objective_setpings(self.objidnum, 1);

  if(!isDefined(level.objpingdelay))
    level.objpingdelay = 3.0;

  for(;;) {
    if(isDefined(self.targetvictim)) {
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.curorigin + self.offset3d);
      objective_ping(self.objidnum);
      wait(level.objpingdelay);
      continue;
    }

    waitframe();
  }
}

updatetargetcurorigin() {
  level endon("game_ended");
  self.targetvictim endon("disconnect");
  self endon("target_eliminated");

  for(;;) {
    if(isDefined(self.targetvictim))
      self.curorigin = self.targetvictim.origin + (0, 0, 90);

    waitframe();
  }
}

newtargetmessage() {
  level endon("game_ended");
  self notify("endDeathWatcher");
  self endon("endDeathWatcher");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level waittill("prematch_done");

  wait 2.5;

  if(isDefined(self.targetvictim))
    self iprintlnbold(&"MP/DM_NEW_TARGET", self.targetvictim.name);
}