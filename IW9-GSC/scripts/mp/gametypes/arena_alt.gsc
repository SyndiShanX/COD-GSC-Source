/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_alt.gsc
***********************************************/

main() {
  setDvar("scr_game_matchstarttime", 10);
  level.bots_gametype_handles_class_choice = 1;

  if(!isDefined(game["launchChunkRuleSet"])) {
    game["launchChunkWinner"] = 0;
    game["launchChunkRuleSet"] = 0;
    game["prevLaunchChunkRuleSet"] = 0;
    game["wasHostAliveAtRoundEnd"] = 1;
    game["matchStartRequiresInput"] = 1;
  } else if(game["launchChunkWinner"] == 1) {
    game["launchChunkWinner"] = 0;
    game["prevLaunchChunkRuleSet"] = game["launchChunkRuleSet"];
    game["launchChunkRuleSet"]++;
    level.resetstats = 1;
    game["matchStartRequiresInput"] = 1;
  }

  if(game["launchChunkRuleSet"] > 3)
    game["launchChunkRuleSet"] = 0;

  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 30);
  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
  scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 19);
  scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 10);
  scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  setDvar("camera_allow3rdspectate", 0);

  if(!isDefined(level.tweakablesinitialized))
    scripts\mp\tweakables::init();

  thread launchchunkbotspawning();
  level.setinitialbotdifficulties = 1;

  switch (game["launchChunkRuleSet"]) {
    case 0:
      if(!isDefined(game["lc_intro_zero"])) {
        game["lc_intro_zero"] = 1;
        game["dialog"]["lc_intro"] = "lc_ffa_first";
      } else if(game["lc_intro_zero"] == 1) {
        game["lc_intro_zero"] = 2;
        game["dialog"]["lc_intro"] = "lc_ffa_second";
      } else
        game["dialog"]["lc_intro"] = "lc_ffa_third";

      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 180);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 15);
      waitthensethealthregentweakable(6);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerKill"), 1);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_dogtags"), 0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lethalDelay"), 0);
      level.scoreconfirm = 0;
      level.scoredeny = 0;
      break;
    case 1:
      if(!isDefined(game["lc_intro_one"])) {
        game["lc_intro_one"] = 1;
        game["dialog"]["lc_intro"] = "lc_arena_first";
      } else if(game["lc_intro_one"] == 1) {
        game["lc_intro_one"] = 2;
        game["dialog"]["lc_intro"] = "lc_arena_second";
      } else
        game["dialog"]["lc_intro"] = "lc_arena_third";

      setomnvar("ui_round_hint_override_attackers", 0);
      setomnvar("ui_round_hint_override_defenders", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 40);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 6);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 6);
      waitthensethealthregentweakable(0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerKill"), 0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_dogtags"), 0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lethalDelay"), 5);
      level.overridetimelimitclock = 10;
      level.setinitialbotdifficulties = 0;
      break;
    case 2:
      if(!isDefined(game["lc_intro_two"])) {
        game["lc_intro_two"] = 1;
        game["dialog"]["lc_intro"] = "lc_pos_first";
      } else if(game["lc_intro_two"] == 1) {
        game["lc_intro_two"] = 2;
        game["dialog"]["lc_intro"] = "lc_pos_second";
      } else
        game["dialog"]["lc_intro"] = "lc_pos_third";

      setomnvar("ui_round_hint_override_attackers", 0);
      setomnvar("ui_round_hint_override_defenders", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 40);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 6);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 6);
      waitthensethealthregentweakable(0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerKill"), 0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_dogtags"), 0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lethalDelay"), 5);
      level.overridetimelimitclock = 10;
      level.setinitialbotdifficulties = 0;
      break;
    case 3:
      if(!isDefined(game["lc_intro_three"])) {
        game["lc_intro_three"] = 1;
        game["dialog"]["lc_intro"] = "lc_conf_first";
      } else if(game["lc_intro_three"] == 1) {
        game["lc_intro_three"] = 2;
        game["dialog"]["lc_intro"] = "lc_conf_second";
      } else
        game["dialog"]["lc_intro"] = "lc_conf_third";

      setomnvar("ui_round_hint_override_attackers", 2);
      setomnvar("ui_round_hint_override_defenders", 2);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 180);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 20);
      waitthensethealthregentweakable(6);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerKill"), 0);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_dogtags"), 1);
      setDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lethalDelay"), 0);
      level.scoreconfirm = 1;
      level.scoredeny = 0;
      break;
    default:
      break;
  }

  updategametypedvars();

  if(israndompreviewloadouts()) {
    level.ispreviewbuild = 1;
    level.previewbuildfirstallies = 1;
    level.previewbuildfirstaxis = 1;
  }

  setDvar("party_maxplayers", 4);
  level.teambased = 1;
  level.objectivebased = 1;
  level.ontimelimit = ::ontimelimit;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerdamaged = ::onplayerdamaged;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimitot = ::ontimelimitot;
  level.droplaunchchunkbots = ::droplaunchchunkbots;
  level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  level.allowlatecomers = 0;

  if(!scripts\mp\utility\game::iswinbytworulegametype())
    level.skipdefendersadvantage = 1;

  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  game["dialog"]["gametype"] = "iw9_gnft_mode_uktl_gfnm";

  if(ispickuploadouts() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_pickups";
    game["dialog"]["defense_obj"] = "boost_arena_pickups";
  } else if(level.objmodifier == 1 && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_objective";
    game["dialog"]["defense_obj"] = "boost_arena_objective";
  } else {
    game["dialog"]["offense_obj"] = "iw9_gnft_mode_uktl_gfbo";
    game["dialog"]["defense_obj"] = "iw9_gnft_mode_uktl_gfbo";
  }

  game["dialog"]["obj_indepth"] = "boost_arena_indepth";
  game["dialog"]["securing_a"] = "iw9_gnft_mode_uktl_gfsg";
  game["dialog"]["secured_a"] = "iw9_gnft_mode_uktl_gfsd";
  game["dialog"]["losing_a"] = "iw9_gnft_mode_uktl_gflg";
  game["dialog"]["lost_a"] = "iw9_gnft_mode_uktl_gflt";
  game["dialog"]["round_success"] = "round_win";
  game["dialog"]["round_failure"] = "round_lose";
  game["dialog"]["mission_success"] = "gamestate_win";
  game["dialog"]["mission_failure"] = "gamestate_lost";
  level.allieshealth = 0;
  level.alliesmaxhealth = 0;
  level.axishealth = 0;
  level.axismaxhealth = 0;
  level.usedspawnposone = 0;
  level.usedspawnpostwo = 0;
  level.usedspawnposthree = 0;
  setomnvar("ui_arena_allies_health", 0);
  setomnvar("ui_arena_axis_health", 0);
  setomnvar("ui_arena_allies_health_max", 100);
  setomnvar("ui_arena_axis_health_max", 100);
  setomnvar("ui_arena_primaryVariantID", -1);
  setomnvar("ui_arena_secondaryVariantID", -1);

  if(game["launchChunkRuleSet"] == 0) {
    game["dialog"]["gametype"] = "gametype_ffa";
    game["dialog"]["boost"] = "boost_tdm";
    game["dialog"]["offense_obj"] = "boost_tdm";
    game["dialog"]["defense_obj"] = "boost_tdm";
  } else if(game["launchChunkRuleSet"] == 3) {
    game["dialog"]["gametype"] = "gametype_killconfirmed";
    game["dialog"]["boost"] = "boost_killconfirmed";
    game["dialog"]["offense_obj"] = "boost_killconfirmed";
    game["dialog"]["defense_obj"] = "boost_killconfirmed";
    game["dialog"]["kill_confirmed"] = "kill_confirmed";
  }
}

waitthensethealthregentweakable(healthregendelay) {
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", healthregendelay);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", healthregendelay);
}

launchchunkbotspawning() {
  level waittill("spawned_player");

  switch (game["launchChunkRuleSet"]) {
    case 0:
      level.launchchunkfreespawn = 0;
      break;
    case 1:
      level.launchchunkfreespawn = 1;
      break;
    case 2:
      level.launchchunkfreespawn = 1;
      break;
    case 3:
      level.launchchunkfreespawn = 1;
      break;
    default:
      break;
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_arena_arenaloadouts", getmatchrulesdata("arenaData", "arenaLoadouts"));
  setdynamicdvar("scr_arena_loadoutchangeround", getmatchrulesdata("arenaData", "loadoutChangeRound"));
  setdynamicdvar("scr_arena_switchspawns", getmatchrulesdata("arenaData", "switchSpawns"));
  setdynamicdvar("scr_arena_winCondition", getmatchrulesdata("arenaData", "winCondition"));
  setdynamicdvar("scr_arena_objmodifier", getmatchrulesdata("arenaData", "objModifier"));
  setdynamicdvar("scr_arena_spawnflag", getmatchrulesdata("arenaData", "spawnFlag"));
  setdynamicdvar("scr_arena_flagcapturetime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_arena_tacticaltimemod", getmatchrulesdata("arenaData", "tacticalTimeMod"));
  setdynamicdvar("scr_arena_blastshieldmod", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar("scr_arena_blastshieldclamp", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar("scr_arena_startWeapon", getmatchrulesdata("arenaData", "startWeapon"));
  setdynamicdvar("scr_arena_weapontier1", getmatchrulesdata("arenaData", "weaponTier1"));
  setdynamicdvar("scr_arena_weapontier2", getmatchrulesdata("arenaData", "weaponTier2"));
  setdynamicdvar("scr_arena_weapontier3", getmatchrulesdata("arenaData", "weaponTier3"));
  setdynamicdvar("scr_arena_weapontier4", getmatchrulesdata("arenaData", "weaponTier4"));
  setdynamicdvar("scr_arena_weapontier5", getmatchrulesdata("arenaData", "weaponTier5"));
  setdynamicdvar("scr_arena_weapontier6", getmatchrulesdata("arenaData", "weaponTier6"));
  setdynamicdvar("scr_arena_weapontier7", getmatchrulesdata("arenaData", "weaponTier7"));
  setdynamicdvar("scr_arena_weapontier8", getmatchrulesdata("arenaData", "weaponTier8"));
  setdynamicdvar("dvar_0C110A01FB151DA3", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  initspawns();
  thread adjustroundendtimer();
  thread waittooverridegraceperiod();

  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts())
    thread updaterandomloadout();
  else if(ispickuploadouts()) {
    level.lethaldelay = 0;
    defineplayerloadout();
    initweaponmap();
    thread setupweapons();
  } else if(isgungameloadouts()) {
    level.blockweapondrops = 1;
    thread _id_3686609F08F20087::updatearenagungameloadout(0);
  } else if(isrvsgungameloadouts()) {
    level.blockweapondrops = 1;
    thread _id_3686609F08F20087::updatearenagungameloadout(1);
  }

  buildloadoutsforweaponstreaming();
  setupwaypointicons();
  seticonnames();

  if(level.objmodifier == 1)
    level setupendzones();

  _id_90B3677E000C6C1B = 0;

  switch (game["launchChunkRuleSet"]) {
    case 0:
      break;
    case 1:
      if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0)
        _id_90B3677E000C6C1B = 1;

      break;
    case 2:
      break;
    case 3:
      break;
    default:
      break;
  }

  level thread _id_3686609F08F20087::spawngameendflagzone(_id_90B3677E000C6C1B);
  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    if(game["roundsPlayed"] == 0) {
      if(game["launchChunkRuleSet"] == 0 && game["prevLaunchChunkRuleSet"] != 3)
        level thread outlineenemyplayerslaunchchunk();
      else {
        level thread outlineenemyplayers();
        level thread removeenemyoutlines();
      }
    }
  }

  if(game["roundsPlayed"] == 0)
    level thread setroundwinstreakarray();

  setDvar("dvar_52994F8FC649C87A", 1);
}

droplaunchchunkbots() {
  if(istrue(game["chunkBotsSpawned"])) {
    game["chunkBotsSpawned"] = 0;
    scripts\mp\bots\bots::drop_bots(1, "allies");
    scripts\mp\bots\bots::drop_bots(1, "axis");
  }
}

tryspawnlaunchchunkbots() {
  if(istrue(game["chunkBotsSpawned"])) {
    return;
  }
  level thread scripts\mp\bots\bots::spawn_bots(1, "allies", undefined, undefined, "spawned_allies", "recruit");
  level thread scripts\mp\bots\bots::spawn_bots(1, "axis", undefined, undefined, "spawned_enemies", "recruit");
  game["chunkBotsSpawned"] = 1;
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
  level.ingraceperiod = 5;
}

adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 4.0;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();

  if(game["launchChunkRuleSet"] == 3) {
    level.dogtagallyonusecb = ::dogtagallyonusecbconf;
    level.dogtagenemyonusecb = ::dogtagenemyonusecbconf;
  } else if(level.dogtagsenabled) {
    level.dogtagallyonusecb = ::dogtagallyonusecb;
    level.dogtagenemyonusecb = ::dogtagenemyonusecb;
  }

  level.arenaloadouts = 2;
  level.loadoutchangeround = scripts\mp\utility\dvars::dvarintvalue("loadoutChangeRound", 3, 0, 5);
  level.switchspawns = scripts\mp\utility\dvars::dvarintvalue("switchSpawns", 1, 0, 1);
  level.wincondition = scripts\mp\utility\dvars::dvarintvalue("winCondition", 1, 0, 2);
  setomnvar("ui_arena_loadout_type", level.arenaloadouts);
  setomnvar("ui_wincondition", level.wincondition);
  level.objmodifier = scripts\mp\utility\dvars::dvarintvalue("objModifier", 0, 0, 1);
  level.spawnflag = scripts\mp\utility\dvars::dvarintvalue("spawnFlag", 0, 0, 1);

  if(game["launchChunkRuleSet"] != 1 && game["launchChunkRuleSet"] != 2)
    level.spawnflag = 0;
  else if(level.spawnflag) {
    level.ontimelimitgraceperiod = 10.0;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
  }

  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("tacticalTimeMod", 2.5, 0.5, 5);
  level.startweapon = getDvar("scr_arena_startWeapon", "none");
  level.arenaweapont1 = getDvar("scr_arena_weapontier1", "iw8_pi_golf21_mp");
  level.arenaweapont2 = getDvar("scr_arena_weapontier2", "iw8_sh_dpapa12_mp");
  level.arenaweapont3 = getDvar("scr_arena_weapontier3", "iw8_sm_mpapa5_mp");
  level.arenaweapont4 = getDvar("scr_arena_weapontier4", "iw8_ar_mike4_mp");
  level.arenaweapont5 = getDvar("scr_arena_weapontier5", "iw8_sn_alpha50_mp");
  level.arenaweapont6 = getDvar("scr_arena_weapontier6", "equip_frag");
  level.arenaweapont7 = getDvar("scr_arena_weapontier7", "equip_concussion");
  level.arenaweapont8 = getDvar("scr_arena_weapontier8", "equip_adrenaline");

  if(game["launchChunkRuleSet"] == 2) {
    level.arenaloadouts = 3;
    level.loadoutchangeround = 3;
    level.startweapon = "none";
    level.arenaweapont1 = "rand_pistol";
    level.arenaweapont2 = "random";
    level.arenaweapont3 = "rand_smg";
    level.arenaweapont4 = "rand_assault";
    level.arenaweapont5 = "rand_sniper";
    level.arenaweapont6 = "rand_lethal";
    level.arenaweapont7 = "rand_tactical";
    level.arenaweapont8 = "random";
    level thread botpickuphack();
  }

  if(ispickuploadouts()) {
    _id_E427E359BB108351();

    if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      level.startweapon = getrandomweaponforweapontier(level.startweapon);
      level.arenaweapont1 = getrandomweaponforweapontier(level.arenaweapont1);
      level.arenaweapont2 = getrandomweaponforweapontier(level.arenaweapont2);
      level.arenaweapont3 = getrandomweaponforweapontier(level.arenaweapont3);
      level.arenaweapont4 = getrandomweaponforweapontier(level.arenaweapont4);
      level.arenaweapont5 = getrandomweaponforweapontier(level.arenaweapont5);
      level.arenaweapont6 = getrandomweaponforweapontier(level.arenaweapont6);
      level.arenaweapont7 = getrandomweaponforweapontier(level.arenaweapont7);
      level.arenaweapont8 = getrandomweaponforweapontier(level.arenaweapont8);
    } else if(level.loadoutchangeround == 0 || game["roundsPlayed"] % level.loadoutchangeround != 0) {
      level.startweapon = game["startWeapon"];
      level.arenaweapont1 = game["arenaWeaponT1"];
      level.arenaweapont2 = game["arenaWeaponT2"];
      level.arenaweapont3 = game["arenaWeaponT3"];
      level.arenaweapont4 = game["arenaWeaponT4"];
      level.arenaweapont5 = game["arenaWeaponT5"];
      level.arenaweapont6 = game["arenaWeaponT6"];
      level.arenaweapont7 = game["arenaWeaponT7"];
      level.arenaweapont8 = game["arenaWeaponT8"];
    } else if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
      level.startweapon = getrandomweaponforweapontier(level.startweapon);
      level.arenaweapont1 = getrandomweaponforweapontier(level.arenaweapont1);
      level.arenaweapont2 = getrandomweaponforweapontier(level.arenaweapont2);
      level.arenaweapont3 = getrandomweaponforweapontier(level.arenaweapont3);
      level.arenaweapont4 = getrandomweaponforweapontier(level.arenaweapont4);
      level.arenaweapont5 = getrandomweaponforweapontier(level.arenaweapont5);
      level.arenaweapont6 = getrandomweaponforweapontier(level.arenaweapont6);
      level.arenaweapont7 = getrandomweaponforweapontier(level.arenaweapont7);
      level.arenaweapont8 = getrandomweaponforweapontier(level.arenaweapont8);
    }

    game["startWeapon"] = level.startweapon;
    game["arenaWeaponT1"] = level.arenaweapont1;
    game["arenaWeaponT2"] = level.arenaweapont2;
    game["arenaWeaponT3"] = level.arenaweapont3;
    game["arenaWeaponT4"] = level.arenaweapont4;
    game["arenaWeaponT5"] = level.arenaweapont5;
    game["arenaWeaponT6"] = level.arenaweapont6;
    game["arenaWeaponT7"] = level.arenaweapont7;
    game["arenaWeaponT8"] = level.arenaweapont8;
  }
}

getrandomweaponforweapontier(_id_63573DFB900DD221) {
  if(issubstr(_id_63573DFB900DD221, "rand")) {
    if(_id_63573DFB900DD221 == "random")
      _id_63573DFB900DD221 = getrandomspawnweapon();
    else
      _id_63573DFB900DD221 = _id_FBC569A8B64FE92B(_id_63573DFB900DD221);
  }

  return _id_63573DFB900DD221;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("LaunchChunk", "Crit_Default");
  _id_1CF8BE03FB3C42DE = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");
  _id_68C73806E24FF493 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");
  _id_EBB5693CE8D3A200 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn");

  if(_id_1CF8BE03FB3C42DE.size > 0 || _id_68C73806E24FF493.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_axis_start");
    level.alliesstartspawn = "mp_arena_spawn_allies_start";
    level.axisstartspawn = "mp_arena_spawn_axis_start";
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
    level.alliesstartspawn = "mp_sd_spawn_attacker";
    level.axisstartspawn = "mp_sd_spawn_defender";
  }

  if(_id_EBB5693CE8D3A200.size > 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_arena_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_arena_spawn");
    level.spawntype = "mp_arena_spawn";
  } else {
    _id_EBB5693CE8D3A200 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    if(_id_EBB5693CE8D3A200.size > 0) {
      scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
      scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
      level.spawntype = "mp_tdm_spawn";
    } else
      level.alwaysusestartspawns = 1;
  }

  if(!istrue(level.alwaysusestartspawns)) {
    scripts\mp\spawnlogic::registerspawnset("normal", level.spawntype);
    scripts\mp\spawnlogic::registerspawnset("fallback", level.spawntype);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

validatespawns(_id_700A871A46435669) {
  _id_ECBE28103D8BA707 = 0;
  _id_ECBE29103D8BA93A = 0;
  _id_ECBE2A103D8BAB6D = 0;
  _id_E89636DADEA5A56A = 0;
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

  foreach(s in spawnpoints) {
    if(isDefined(s.script_noteworthy)) {
      if(!_id_ECBE28103D8BA707)
        _id_ECBE28103D8BA707 = s.script_noteworthy == "1";
      else {}

      if(!_id_ECBE29103D8BA93A)
        _id_ECBE29103D8BA93A = s.script_noteworthy == "2";
      else {}

      if(!_id_ECBE2A103D8BAB6D) {
        _id_ECBE2A103D8BAB6D = s.script_noteworthy == "3";
        level.hasthreespawns = 1;
      } else {}

      continue;
    }

    if(_id_E89636DADEA5A56A == 0) {
      s.script_noteworthy = "1";
      _id_E89636DADEA5A56A++;
      continue;
    }

    if(_id_E89636DADEA5A56A == 1) {
      s.script_noteworthy = "2";
      _id_E89636DADEA5A56A++;
      continue;
    }

    if(_id_E89636DADEA5A56A == 2) {
      s.script_noteworthy = "3";
      _id_E89636DADEA5A56A++;
      level.hasthreespawns = 1;
    }
  }
}

getspawnpoint() {
  spawnpoint = undefined;
  _id_700A871A46435669 = level.axisstartspawn;
  _id_D8F6B733865965FD = 0;
  _id_AA57738EDF8A8169 = 0;

  if(self.pers["team"] == game["attackers"])
    _id_700A871A46435669 = level.alliesstartspawn;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || isintournament()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0) {
      _id_49ED3F681FAF7163 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

      if(_id_49ED3F681FAF7163 > 3) {
        foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
          if(isDefined(player.pers["arena_spawn_pos"]))
            player.pers["arena_spawn_pos"] = "0";
        }

        _id_AA57738EDF8A8169 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0 && !_id_AA57738EDF8A8169) {
      if(self.pers["arena_spawn_pos"] == "1")
        self.pers["arena_spawn_pos"] = "2";
      else if(scripts\mp\utility\teams::getteamcount(self.pers["team"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["arena_spawn_pos"] == "2")
        self.pers["arena_spawn_pos"] = "3";
      else if(self.pers["arena_spawn_pos"] == "3")
        self.pers["arena_spawn_pos"] = "1";
      else
        self.pers["arena_spawn_pos"] = "1";

      spawnpoint = getswitchside_spawnpoint(spawnpoints, self.pers["arena_spawn_pos"]);
    }

    if(!isDefined(spawnpoint)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["arena_spawn_pos"])) {
        cleanupspawn_scriptnoteworthy();
        spawnpoint = getspawnpoint_startspawn(spawnpoints);
        self.switching_teams_arena = undefined;
      } else
        spawnpoint = getspawnpoint_startspawn(spawnpoints);

      if(!isDefined(spawnpoint)) {
        _id_49ED3F681FAF7163 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

        if(_id_49ED3F681FAF7163 > 3) {
          buddyspawnplayer = undefined;

          foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
            if(isDefined(player.pers["arena_spawn_pos"])) {
              if(level.usedspawnposone == 1 && level.usedspawnposone == 1 && level.usedspawnposthree == 1) {
                level.usedspawnposone = 0;
                level.usedspawnpostwo = 0;
                level.usedspawnposthree = 0;
              }

              if(player.pers["arena_spawn_pos"] == "1" && level.usedspawnposone == 0) {
                level.usedspawnposone++;
                buddyspawnplayer = player;
                break;
              } else if(player.pers["arena_spawn_pos"] == "2" && level.usedspawnpostwo == 0) {
                level.usedspawnpostwo++;
                buddyspawnplayer = player;
                break;
              } else if(player.pers["arena_spawn_pos"] == "3" && level.usedspawnposthree == 0) {
                level.usedspawnposthree++;
                buddyspawnplayer = player;
                break;
              } else {
                level.usedspawnposone++;
                buddyspawnplayer = player;
                break;
              }
            }
          }

          if(isDefined(buddyspawnplayer)) {
            spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(buddyspawnplayer);
            _id_D8F6B733865965FD = 1;
          }
        }
      }

      if(istrue(level.switchspawns) && game["roundsPlayed"] == 0 && !_id_D8F6B733865965FD)
        self.pers["arena_spawn_pos"] = spawnpoint.script_noteworthy;
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return spawnpoint;
}

cleanupspawn_scriptnoteworthy() {
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  if(otherteam == game["attackers"]) {
    _id_700A871A46435669 = level.alliesstartspawn;
    _id_55AF954984FC6A2A = level.axisstartspawn;
  } else {
    _id_700A871A46435669 = level.axisstartspawn;
    _id_55AF954984FC6A2A = level.alliesstartspawn;
  }

  _id_CB5363AB35B26AEA = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

  foreach(s in _id_CB5363AB35B26AEA) {
    if(s.script_noteworthy == self.pers["arena_spawn_pos"])
      s.selected = 0;
  }

  _id_CB5363AB35B26AEA = scripts\mp\spawnlogic::getspawnpointarray(_id_55AF954984FC6A2A);

  foreach(s in _id_CB5363AB35B26AEA) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
      if(player != self && isDefined(player.pers["arena_spawn_pos"]) && s.script_noteworthy != player.pers["arena_spawn_pos"])
        s.selected = 0;
    }
  }
}

getspawnpoint_startspawn(spawnpoints, _id_728D3544BA462895) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_B8D119D2C9609296 = undefined;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    if(!isDefined(spawnpoint.selected)) {
      continue;
    }
    if(spawnpoint.selected) {
      continue;
    }
    if(spawnpoint.script_noteworthy == "1") {
      _id_B8D119D2C9609296 = spawnpoint;
      break;
    } else if(spawnpoint.script_noteworthy == "2") {
      _id_B8D119D2C9609296 = spawnpoint;
      break;
    }

    _id_B8D119D2C9609296 = spawnpoint;
  }

  if(isDefined(_id_B8D119D2C9609296))
    _id_B8D119D2C9609296.selected = 1;

  return _id_B8D119D2C9609296;
}

getswitchside_spawnpoint(spawnpoints, _id_2B71CDD2F02EB67B) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_CEE9D4C5101C6EAD = 0;

  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint.script_noteworthy == _id_2B71CDD2F02EB67B) {
      if(istrue(spawnpoint.selected)) {
        _id_CEE9D4C5101C6EAD = 1;
        continue;
      }

      spawnpoint.selected = 1;
      return spawnpoint;
    }
  }

  return undefined;
}

onplayerconnect(player) {
  level.bots_gametype_handles_class_choice = 1;

  if(istrue(level.resetstats))
    player resetpersstats();

  player.arenadamage = 0;
  player scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(player.pers["damage"]))
    player scripts\mp\utility\stats::setextrascore0(player.pers["damage"]);

  player scripts\mp\class::_id_A16868D4DCD81A4B();
  player setclientomnvar("ui_launch_chunk_phase", 0);

  if(!istrue(game["chunkFirstAssigned"])) {
    player.pers["gamemodeLoadout"] = level.chunkloadouts[3];
    game["chunkFirstAssigned"] = 1;
  } else if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts())
    player.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
  else if(ispickuploadouts())
    player.pers["gamemodeLoadout"] = level.arena_loadouts["axis"];

  if(istrue(level.switchspawns) && !isDefined(player.pers["arena_spawn_pos"]))
    player.pers["arena_spawn_pos"] = "0";

  player thread onjoinedteam();
  player _id_0FD32F08E72B657F::updatehighpriorityweapons();
}

resetpersstats() {
  self.pers["score"] = 0;
  self.pers["kills"] = 0;
  self.pers["deaths"] = 0;
  self.pers["suicides"] = 0;
  self.pers["headshots"] = 0;
  self.pers["assists"] = 0;
  self.pers["captures"] = 0;
  self.pers["confirmed"] = 0;
  self.pers["denied"] = 0;
  self.pers["extrascore0"] = 0;
  self.pers["extrascore1"] = 0;
  self.pers["extrascore2"] = 0;
  self.pers["damage"] = 0;
  self.pers["gamemodeScore"] = 0;
  self.score = 0;
  self.kills = 0;
  self.deaths = 0;
  self.assists = 0;
  self.extrascore0 = 0;
  self.extrascore1 = 0;
  self.extrascore2 = 0;
}

onjoinedteam() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    _id_586DC9DC0CF668AD = getdvarint("scr_player_maxhealth", 100);

    if(isbot(self))
      wait 0.1;

    _id_2005D12681400473 = scripts\mp\utility\teams::getteamdata("allies", "teamCount");

    if(_id_2005D12681400473) {
      level.alliesmaxhealth = scripts\mp\utility\teams::getteamdata("allies", "teamCount") * _id_586DC9DC0CF668AD;
      setomnvar("ui_arena_allies_health_max", level.alliesmaxhealth);

      if(!scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
        self waittill("spawned_player");

      allieshealth = 0;

      foreach(player in scripts\mp\utility\teams::getteamdata("allies", "players"))
      allieshealth = allieshealth + player.health;

      level.allieshealth = allieshealth;

      if(level.allieshealth < 0)
        level.allieshealth = 0;

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else
      setomnvar("ui_arena_allies_health", 0);

    _id_650728BA49299C62 = scripts\mp\utility\teams::getteamdata("axis", "teamCount");

    if(_id_650728BA49299C62) {
      level.axismaxhealth = scripts\mp\utility\teams::getteamdata("axis", "teamCount") * _id_586DC9DC0CF668AD;
      setomnvar("ui_arena_axis_health_max", level.axismaxhealth);

      if(!scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
        self waittill("spawned_player");

      axishealth = 0;

      foreach(player in scripts\mp\utility\teams::getteamdata("axis", "players"))
      axishealth = axishealth + player.health;

      level.axishealth = axishealth;

      if(level.axishealth < 0)
        level.axishealth = 0;

      setomnvar("ui_arena_axis_health", level.axishealth);
      continue;
    }

    setomnvar("ui_arena_axis_health", 0);
  }
}

onspawnplayer(_id_9156B53BCF7CE573) {
  thread onspawnfinished();
  level notify("spawned_player");
  thread updatematchstatushintonspawn();
}

_id_30203219F14DA40C() {
  self notifyonplayercommand("hack_notify", "+gostand");
  self notifyonplayercommand("hack_notify", "+usereload");
  thread _id_71980E537ADB90FC();
}

_id_71980E537ADB90FC() {
  level endon("game_ended");
  self waittill("hack_notify");
  self notify("luinotifyserver", "class_select", 2);
  level notify("pressToStartMatch");
  self setclientomnvar("ui_launch_chunk_phase", 0);
  game["matchStartRequiresInput"] = 0;
  self notifyonplayercommandremove("hack_notify", "+gostand");
  self notifyonplayercommandremove("hack_notify", "+usereload");
}

onspawnfinished() {
  self endon("death_or_disconnect");

  if(game["matchStartRequiresInput"] && !isbot(self)) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    level.requiredplayercount[_id_F90358454413407F] = 0;

    self setclientomnvar("ui_launch_chunk_phase", game["launchChunkRuleSet"] + 1);
    self setclientomnvar("ui_options_menu", 3);
    wait 2;
    self setclientomnvar("ui_launch_chunk_phase", 5);
    thread _id_30203219F14DA40C();

    for(;;) {
      self waittill("luinotifyserver", msg, value);

      if(msg == "class_select") {
        break;
      }
    }

    level notify("pressToStartMatch");
    self setclientomnvar("ui_launch_chunk_phase", 0);
    game["matchStartRequiresInput"] = 0;
    scripts\mp\utility\dialog::leaderdialogonplayer("lc_intro", "lc_intro");
  }

  thread damagewatcher();
  self waittill("giveLoadout");
  runarenaloadoutrulesonplayer();
  thread modifyblastshieldperk();
  wait 0.1;
  self.hasarenaspawned = 1;

  if(isbot(self)) {
    if(!isDefined(game["chunkBotsDifficulty"])) {
      _id_BCE1CF9927E810F2 = "camper";
      game["chunkBotsDifficulty"] = "recruit";
    } else {
      _id_C22F59E21C234D66 = randomint(3);

      switch (_id_C22F59E21C234D66) {
        case 0:
        default:
          _id_BCE1CF9927E810F2 = "camper";
          break;
        case 1:
          _id_BCE1CF9927E810F2 = "run_and_gun";
          break;
        case 2:
          _id_BCE1CF9927E810F2 = "cqb";
          break;
      }

      _id_11BFC6B0E47D4408 = ["recruit", "regular", "hardened", "veteran"];
      _id_FFE4AD4ADE846878 = 0;

      if(isDefined(game["chunkBotsDifficulty"])) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_11BFC6B0E47D4408.size; _id_AC0E594AC96AA3A8++) {
          if(game["chunkBotsDifficulty"] == _id_11BFC6B0E47D4408[_id_AC0E594AC96AA3A8]) {
            _id_FFE4AD4ADE846878 = _id_AC0E594AC96AA3A8;
            break;
          }
        }

        if(!level.setinitialbotdifficulties && (game["launchChunkRuleSet"] == 1 || game["launchChunkRuleSet"] == 2)) {
          if(!isbot(self)) {
            if(game["previousWinningTeam"] == self.team && game["wasHostAliveAtRoundEnd"]) {
              if(_id_FFE4AD4ADE846878 < _id_11BFC6B0E47D4408.size - 1)
                _id_FFE4AD4ADE846878++;
            } else if(_id_FFE4AD4ADE846878 > 0)
              _id_FFE4AD4ADE846878--;
          }

          game["chunkBotsDifficulty"] = _id_11BFC6B0E47D4408[_id_FFE4AD4ADE846878];
          level.setinitialbotdifficulties = 1;
        }
      }
    }

    self botsetdifficulty(game["chunkBotsDifficulty"]);
    scripts\mp\bots\bots_util::bot_set_personality(_id_BCE1CF9927E810F2);
  }

  wait 0.15;

  if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
    if(level.spawnflag && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        scripts\mp\utility\dialog::leaderdialogonplayer("obj_indepth", "introboost");
    }

    level scripts\engine\utility::waittill_any_2("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
}

modifyblastshieldperk() {
  blastshieldmod = scripts\mp\utility\dvars::dvarintvalue("blastShieldMod", 0.65, 0, 1.0);

  if(isbot(self)) {
    if(blastshieldmod == 0 || game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3)
      scripts\mp\utility\perk::removeperk("specialty_blastshield");
  }
}

onplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(isDefined(eattacker) && eattacker != victim && isPlayer(eattacker)) {
    if(idamage >= _id_FCDF19E3CDD29669)
      idamage = _id_FCDF19E3CDD29669;

    eattacker.arenadamage = eattacker.arenadamage + idamage;
    eattacker scripts\mp\persistence::statsetchild("round", "damage", eattacker.pers["damage"]);
    eattacker scripts\mp\utility\stats::setextrascore0(eattacker.pers["damage"]);
  }
}

damagewatcher() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self.totaldamagetaken = 0;

  for(;;) {
    scripts\engine\utility::waittill_any_7("damage", "force_regeneration", "removeAdrenaline", "healed", "naturalHealthRegen", "vampirism", "spawned_player");

    if(self.team == "allies") {
      allieshealth = 0;

      foreach(player in scripts\mp\utility\teams::getteamdata("allies", "players"))
      allieshealth = allieshealth + player.health;

      level.allieshealth = allieshealth;

      if(level.allieshealth < 0)
        level.allieshealth = 0;

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else {
      axishealth = 0;

      foreach(player in scripts\mp\utility\teams::getteamdata("axis", "players"))
      axishealth = axishealth + player.health;

      level.axishealth = axishealth;

      if(level.axishealth < 0)
        level.axishealth = 0;

      setomnvar("ui_arena_axis_health", level.axishealth);
    }

    if(istrue(self.iscapturing)) {
      _id_D3AE4CB68808AAA8 = undefined;

      if(level.objmodifier == 1) {
        if(self.team == game["defenders"]) {
          level.attackerendzone.curprogress = 50;
          level.attackerendzone.teamprogress[self.team] = 50;
          _id_D3AE4CB68808AAA8 = level.attackerendzone;
        } else if(self.team == game["attackers"]) {
          level.defenderendzone.curprogress = 50;
          level.defenderendzone.teamprogress[self.team] = 50;
          _id_D3AE4CB68808AAA8 = level.defenderendzone;
        }

        scripts\mp\objidpoolmanager::objective_set_progress(_id_D3AE4CB68808AAA8.objidnum, _id_D3AE4CB68808AAA8.curprogress / _id_D3AE4CB68808AAA8.usetime);
      }
    }
  }
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(isbot(victim))
    victim.classcallback = "gamemode";

  if(game["state"] == "postgame")
    attacker.finalkill = 1;

  if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
    if(isbot(attacker)) {
      if(attacker.kills % 4 == 0 || !isbot(victim)) {
        _id_11BFC6B0E47D4408 = ["recruit", "regular", "hardened", "veteran"];
        _id_FFE4AD4ADE846878 = 0;
        difficulty = attacker botgetdifficulty();

        if(difficulty == "recruit")
          _id_FFE4AD4ADE846878 = 0;
        else if(difficulty == "regular")
          _id_FFE4AD4ADE846878 = 0;
        else if(difficulty == "hardened")
          _id_FFE4AD4ADE846878 = 1;
        else if(difficulty == "veteran")
          _id_FFE4AD4ADE846878 = 2;

        attacker botsetdifficulty(_id_11BFC6B0E47D4408[_id_FFE4AD4ADE846878]);
        game["chunkBotsDifficulty"] = _id_11BFC6B0E47D4408[_id_FFE4AD4ADE846878];
      }
    }

    if(isbot(victim)) {
      if(victim.deaths % 2 == 0) {
        _id_11BFC6B0E47D4408 = ["recruit", "regular", "hardened", "veteran"];
        _id_FFE4AD4ADE846878 = 0;
        difficulty = victim botgetdifficulty();

        if(difficulty == "recruit")
          _id_FFE4AD4ADE846878 = 1;
        else if(difficulty == "regular")
          _id_FFE4AD4ADE846878 = 2;
        else if(difficulty == "hardened")
          _id_FFE4AD4ADE846878 = 3;
        else if(difficulty == "veteran")
          _id_FFE4AD4ADE846878 = 3;

        victim botsetdifficulty(_id_11BFC6B0E47D4408[_id_FFE4AD4ADE846878]);
        game["chunkBotsDifficulty"] = _id_11BFC6B0E47D4408[_id_FFE4AD4ADE846878];
      }
    }

    if(victim.deaths % 3 == 0) {
      game["arenaRandomLoadoutIndex"]++;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size)
        game["arenaRandomLoadoutIndex"] = 0;

      victim.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    }
  } else if(!isbot(victim)) {
    timeremaining = scripts\mp\gamelogic::gettimeremaining();

    if(timeremaining > 35000) {
      _id_11BFC6B0E47D4408 = ["recruit", "regular", "hardened", "veteran"];
      _id_FFE4AD4ADE846878 = 0;
      difficulty = game["chunkBotsDifficulty"];

      if(difficulty == "recruit")
        _id_FFE4AD4ADE846878 = 0;
      else if(difficulty == "regular")
        _id_FFE4AD4ADE846878 = 0;
      else if(difficulty == "hardened")
        _id_FFE4AD4ADE846878 = 1;
      else if(difficulty == "veteran")
        _id_FFE4AD4ADE846878 = 1;

      game["chunkBotsDifficulty"] = _id_11BFC6B0E47D4408[_id_FFE4AD4ADE846878];
    }
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isbot(self))
    self.classcallback = "gamemode";

  thread checkallowspectating();
}

checkallowspectating() {
  waitframe();
  update = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update)
    scripts\mp\spectating::updatespectatesettings();
}

ontimelimit() {
  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3)
    scripts\mp\gamelogic::default_ontimelimit();
  else if(level.wincondition == 1)
    checkliveswinner();
  else if(level.wincondition == 2)
    checkhealthwinner();
  else
    checkhealthwinner();

  if(game["launchChunkRuleSet"] != 3)
    level tryspawnlaunchchunkbots();
}

ontimelimitot() {
  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 1);
  _id_5F7407BF2B59F865 = 1;

  if(scripts\mp\utility\game::getgametypenumlives() == 0)
    _id_5F7407BF2B59F865 = 0;

  if(_id_5F7407BF2B59F865)
    level thread startotmechanics();
}

checkliveswinner() {
  if(scripts\mp\utility\teams::getteamdata("allies", "aliveCount") > scripts\mp\utility\teams::getteamdata("axis", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
  } else if(scripts\mp\utility\teams::getteamdata("axis", "aliveCount") > scripts\mp\utility\teams::getteamdata("allies", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
  } else
    checkhealthwinner();
}

checkhealthwinner() {
  if(level.axishealth < level.allieshealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
  } else if(level.allieshealth < level.axishealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
  } else if(scripts\mp\utility\game::matchmakinggame()) {
    _id_D1C52BD1768483B2 = scripts\mp\gamelogic::getbetterteam();
    thread scripts\mp\gamelogic::endgame(_id_D1C52BD1768483B2, game["end_reason"]["time_limit_reached"]);
  } else
    thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
}

ondeadevent(team) {
  if(team == game["attackers"])
    level thread arena_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  else if(team == game["defenders"])
    level thread arena_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

ontimelimitdeadevent(team) {}

arena_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B) {
  if(isgungameloadouts() || isrvsgungameloadouts())
    level setenemyloadoutomnvarsatmatchend(_id_EC15CE3E7A9D1D86);

  if(_id_EC15CE3E7A9D1D86 != "tie") {
    game["previousWinningTeam"] = _id_EC15CE3E7A9D1D86;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_F90358454413407F == _id_EC15CE3E7A9D1D86) {
        game["roundWinStreak"][_id_EC15CE3E7A9D1D86]++;
        continue;
      }

      game["roundWinStreak"][_id_F90358454413407F] = 0;
    }

    switch (game["roundWinStreak"][_id_EC15CE3E7A9D1D86]) {
      case 2:
        game["dialog"]["round_success"] = "round_win_streak_2";
        break;
      case 3:
        game["dialog"]["round_success"] = "round_win_streak_3";
        break;
      case 4:
        game["dialog"]["round_success"] = "round_win_streak_4";
        break;
      case 5:
        _id_C077C467A67F3354 = scripts\mp\utility\game::getroundswon(_id_EC15CE3E7A9D1D86);
        winlimit = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

        if(winlimit == 6 && _id_C077C467A67F3354 != winlimit - 1)
          game["dialog"]["round_success"] = "round_win_streak_5";

        break;
      default:
        break;
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][_id_EC15CE3E7A9D1D86] > 3)
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
    }
  } else
    game["previousWinningTeam"] = "";

  _id_9D709D44ADD4A33A = undefined;

  foreach(player in level.players) {
    if(!isbot(player))
      _id_9D709D44ADD4A33A = player;
  }

  if(isDefined(_id_9D709D44ADD4A33A) && !isalive(_id_9D709D44ADD4A33A))
    game["wasHostAliveAtRoundEnd"] = 0;
  else
    game["wasHostAliveAtRoundEnd"] = 1;

  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B);

  if(game["launchChunkRuleSet"] != 3)
    level thread tryspawnlaunchchunkbots();
}

setroundwinstreakarray() {
  wait 1;

  foreach(_id_F90358454413407F in level.teamnamelist)
  game["roundWinStreak"][_id_F90358454413407F] = 0;
}

runarenaloadoutrulesonplayer() {
  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    if(israndompreviewloadouts() || israndomalphaloadouts()) {
      if(self.pers["gamemodeLoadout"]["loadoutSecondary"] == "none")
        scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_me_fists_mp");
    }
  } else if(ispickuploadouts()) {
    self.equipment = [];

    if(game["roundsPlayed"] == 0)
      wait 0.1;
    else
      wait 0.25;

    if(issubstr(level.startweapon, "equip"))
      scripts\mp\equipment::giveequipment(level.startweapon, scripts\mp\equipment::getdefaultslot(level.startweapon));

    if(level.takefists)
      scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_me_fists_mp");
  }
}

buildloadoutsforweaponstreaming() {
  level.loadweapons = [];
  level.takefists = 0;

  if(ispickuploadouts()) {
    if(level.startweapon == "none") {
      _id_DD515FCF025B2E79 = "iw9_me_fists_mp";
      _id_66B3DB972AC1531E = makeweapon(_id_DD515FCF025B2E79);
      _id_DD515FCF025B2E79 = getcompleteweaponname(_id_66B3DB972AC1531E);
    } else if(issubstr(level.startweapon, "equip")) {
      _id_DD515FCF025B2E79 = "iw9_me_fists_mp";
      _id_66B3DB972AC1531E = makeweapon(_id_DD515FCF025B2E79);
      _id_DD515FCF025B2E79 = getcompleteweaponname(_id_66B3DB972AC1531E);
    } else {
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(level.startweapon);
      attachments = [];
      _id_66B3DB972AC1531E = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, "none", "none", -1);
      _id_DD515FCF025B2E79 = getcompleteweaponname(_id_66B3DB972AC1531E);
      level.takefists = 1;
    }

    level.newweaponname = _id_DD515FCF025B2E79;
    level.loadweapons[level.loadweapons.size] = _id_66B3DB972AC1531E;
  } else {
    _id_BC002676438672C9 = [];
    _id_2AEE5A9B1A165F09 = [];
    loadout = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    primary = loadout["loadoutPrimary"];
    _id_D7B9856A19F9B6B5 = loadout["loadoutSecondary"];

    if(primary != "none")
      _id_BC002676438672C9[_id_BC002676438672C9.size] = buildprimaries(primary, loadout);

    if(_id_D7B9856A19F9B6B5 != "none")
      _id_2AEE5A9B1A165F09[_id_2AEE5A9B1A165F09.size] = buildsecondaries(_id_D7B9856A19F9B6B5, loadout);

    if(level.loadoutchangeround != 0) {
      _id_A9C56228C41ECDA0 = game["arenaRandomLoadoutIndex"] + 1;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size - 1)
        _id_A9C56228C41ECDA0 = 0;

      _id_C3D433AF5F864E84 = game["arenaRandomLoadout"][_id_A9C56228C41ECDA0];
      _id_C03D6DD4BFB14C5A = _id_C3D433AF5F864E84["loadoutPrimary"];
      _id_FCCB1D1573E7F2A6 = _id_C3D433AF5F864E84["loadoutSecondary"];

      if(_id_C03D6DD4BFB14C5A != "none")
        _id_BC002676438672C9[_id_BC002676438672C9.size] = buildprimaries(_id_C03D6DD4BFB14C5A, _id_C3D433AF5F864E84);

      if(_id_FCCB1D1573E7F2A6 != "none")
        _id_2AEE5A9B1A165F09[_id_2AEE5A9B1A165F09.size] = buildsecondaries(_id_FCCB1D1573E7F2A6, _id_C3D433AF5F864E84);
    }

    level.loadweapons = scripts\engine\utility::array_combine(_id_BC002676438672C9, _id_2AEE5A9B1A165F09);
  }
}

buildprimaries(primary, loadout) {
  _id_AC82E189F4D06152 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 == 1)
      _id_AB0F600188412CF1 = "";

    attachment = loadout["loadoutPrimaryAttachment" + _id_AB0F600188412CF1];

    if(attachment != "none")
      _id_AC82E189F4D06152[_id_AC82E189F4D06152.size] = attachment;
  }

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(primary);
  camoname = "none";
  _id_6A42D475DFB96A31 = "none";
  _id_2CF0771420522CB6 = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, _id_AC82E189F4D06152, camoname, _id_6A42D475DFB96A31);
  _id_DD515FCF025B2E79 = getcompleteweaponname(_id_2CF0771420522CB6);
  return _id_DD515FCF025B2E79;
}

buildsecondaries(_id_D7B9856A19F9B6B5, loadout) {
  _id_AC82E189F4D06152 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 == 1)
      _id_AB0F600188412CF1 = "";

    attachment = loadout["loadoutSecondaryAttachment" + _id_AB0F600188412CF1];

    if(attachment != "none")
      _id_AC82E189F4D06152[_id_AC82E189F4D06152.size] = attachment;
  }

  camoname = "none";
  _id_6A42D475DFB96A31 = "none";
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_D7B9856A19F9B6B5);
  _id_2CF0771420522CB6 = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, _id_AC82E189F4D06152, camoname, _id_6A42D475DFB96A31);
  _id_DD515FCF025B2E79 = getcompleteweaponname(_id_2CF0771420522CB6);
  return _id_DD515FCF025B2E79;
}

defineplayerloadout() {
  if(isDefined(level.startweapon) && level.startweapon != "none" && !issubstr(level.startweapon, "equip"))
    primary = _id_2669878CF5A1B6BC::getweaponrootname(level.startweapon);
  else
    primary = "none";

  level.arena_loadouts["default"]["loadoutArchetype"] = "archetype_assault";
  level.arena_loadouts["default"]["loadoutPrimary"] = primary;
  level.arena_loadouts["default"]["loadoutPrimaryAttachment"] = "none";
  level.arena_loadouts["default"]["loadoutPrimaryAttachment2"] = "none";
  level.arena_loadouts["default"]["loadoutPrimaryCamo"] = "none";
  level.arena_loadouts["default"]["loadoutPrimaryReticle"] = "none";
  level.arena_loadouts["default"]["loadoutSecondary"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryAttachment"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryAttachment2"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryCamo"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryReticle"] = "none";
  level.arena_loadouts["default"]["loadoutMeleeSlot"] = "iw9_me_fists_mp_ls";
  level.arena_loadouts["default"]["loadoutEquipmentPrimary"] = "none";
  level.arena_loadouts["default"]["loadoutEquipmentSecondary"] = "none";
  level.arena_loadouts["default"]["loadoutStreakType"] = "assault";
  level.arena_loadouts["default"]["loadoutKillstreak1"] = "none";
  level.arena_loadouts["default"]["loadoutKillstreak2"] = "none";
  level.arena_loadouts["default"]["loadoutKillstreak3"] = "none";
  level.arena_loadouts["default"]["loadoutSuper"] = "none";
  level.arena_loadouts["default"]["loadoutPerks"] = ["specialty_blastshield"];
  level.arena_loadouts["default"]["loadoutGesture"] = "playerData";
  level.arena_loadouts["default"]["loadoutExecution"] = "playerData";
  level.arena_loadouts["allies"] = level.arena_loadouts["default"];
  level.arena_loadouts["axis"] = level.arena_loadouts["default"];
}

updaterandomloadout() {
  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    if(game["roundsPlayed"] == 0) {
      if(istrue(game["practiceRound"])) {
        cacherandomloadouts();
        game["arenaRandomLoadoutIndex"] = 0;
      } else if(!isDefined(game["practiceRound"])) {
        cacherandomloadouts();
        game["arenaRandomLoadoutIndex"] = 0;
      }
    } else if(level.loadoutchangeround != 0) {
      if(game["roundsPlayed"] % level.loadoutchangeround == 0)
        game["arenaRandomLoadoutIndex"]++;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size)
        game["arenaRandomLoadoutIndex"] = 0;
    } else
      game["arenaRandomLoadoutIndex"] = 0;
  }
}

cacherandomloadouts() {
  game["arenaRandomLoadout"] = [];
  level.chunkloadouts = [];
  _id_57C2FBE37E0787EA = _id_3686609F08F20087::_id_3187496929140714(["arena_alt_class_table"]);

  foreach(_id_09DDC180A1A5121D in _id_57C2FBE37E0787EA) {
    foreach(loadout in _id_09DDC180A1A5121D._id_8D5460BE7DB831C3)
    level.chunkloadouts[level.chunkloadouts.size] = _id_3686609F08F20087::_id_37F8BE8199814F97(loadout);
  }

  loadouts = level.chunkloadouts;
  loadouts = arenaloadouts_select(loadouts, 99);
  game["arenaRandomLoadout"] = scripts\engine\utility::array_randomize(loadouts);
}

updateloadoutarray(table, _id_089688461C79EF11) {
  _id_E698DF1EC0933CE4 = [];
  _id_E698DF1EC0933CE4["loadoutPrimary"] = scripts\mp\class::table_getweapon(table, _id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutPrimaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_089688461C79EF11, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_089688461C79EF11, 0);
  _id_E698DF1EC0933CE4["loadoutSecondary"] = scripts\mp\class::table_getweapon(table, _id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxsecondaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "secondary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_089688461C79EF11, 1);
  _id_E698DF1EC0933CE4["loadoutSecondaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_089688461C79EF11, 1);
  _id_E698DF1EC0933CE4["loadoutEquipmentPrimary"] = scripts\mp\class::table_getequipmentprimary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutExtraEquipmentPrimary"] = scripts\mp\class::table_getextraequipmentprimary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutEquipmentSecondary"] = scripts\mp\class::table_getequipmentsecondary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutExtraEquipmentSecondary"] = scripts\mp\class::table_getextraequipmentsecondary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutPerks"] = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    perk = scripts\mp\class::table_getperk(table, _id_089688461C79EF11, _id_AC0E594AC96AA3A8);

    if(perk != "specialty_null")
      _id_E698DF1EC0933CE4["loadoutPerks"][_id_E698DF1EC0933CE4["loadoutPerks"].size] = perk;
  }

  _id_E698DF1EC0933CE4["loadoutGesture"] = "playerData";
  _id_E698DF1EC0933CE4["loadoutExecution"] = "playerData";
  return _id_E698DF1EC0933CE4;
}

arenaloadouts_select(loadouts, count) {
  _id_92F35FCFAE58B4EB = [];
  _id_B0BC46F3BA5DB389 = [];

  for(num = 0; num < count && loadouts.size > 0; num++) {
    _id_B0BC46F3BA5DB389[_id_B0BC46F3BA5DB389.size] = loadouts[randomint(loadouts.size)];
    _id_ACFE7336F59B3D76 = _id_B0BC46F3BA5DB389[_id_B0BC46F3BA5DB389.size - 1]["loadoutPrimary"];
    loadouts = arenaloadouts_removeclass(loadouts, _id_ACFE7336F59B3D76);
  }

  return _id_B0BC46F3BA5DB389;
}

arenaloadouts_removeclass(loadouts, _id_ACFE7336F59B3D76) {
  _id_7CB19F95DBC68942 = [];
  group = arenaloadouts_getweapongroup(_id_ACFE7336F59B3D76);

  foreach(loadout in loadouts) {
    _id_EDCF839453192090 = arenaloadouts_getweapongroup(loadout["loadoutPrimary"]);

    if(group != _id_EDCF839453192090)
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = loadout;
  }

  return _id_7CB19F95DBC68942;
}

arenaloadouts_getweapongroup(rootweapon) {
  group = "none";

  if(rootweapon != "none") {
    group = scripts\mp\utility\weapon::getweapongroup(rootweapon);

    if(group == "weapon_dmr")
      group = "weapon_sniper";
  }

  return group;
}

_id_E427E359BB108351() {
  level.weaponcategories = [];
  level.allweapons = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_00CEBA6EC7E8CA50 = "mp/arenaGGWeapons_alt.csv";
    _id_22E2935C86B3B88E = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 4);

    if(_id_22E2935C86B3B88E == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[_id_22E2935C86B3B88E]))
      level.weaponcategories[_id_22E2935C86B3B88E] = [];

    data = [];
    data["weapon"] = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 0);
    level.weaponcategories[_id_22E2935C86B3B88E][level.weaponcategories[_id_22E2935C86B3B88E].size] = data;
    level.allweapons[level.allweapons.size] = data;
    _id_CB89110314447B2F++;
  }
}

_id_FBC569A8B64FE92B(_id_22E2935C86B3B88E) {
  weaponlist = level.weaponcategories[_id_22E2935C86B3B88E];

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    _id_DD515FCF025B2E79 = "";
    data = undefined;
    loopcount = 0;

    for(;;) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(data["weapon"]);

      if(loopcount > weaponlist.size) {
        level.selectedweapons[_id_AB501F397D3CD312] = 1;
        _id_DD515FCF025B2E79 = data["weapon"];

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.weaponcategories[_id_22E2935C86B3B88E].size; _id_AC0E594AC96AA3A8++) {
          if(level.weaponcategories[_id_22E2935C86B3B88E][_id_AC0E594AC96AA3A8]["weapon"] == _id_DD515FCF025B2E79) {
            break;
          }
        }

        break;
      }

      loopcount++;
    }

    return _id_DD515FCF025B2E79;
  } else
    return "none";
}

initweaponmap() {
  level.baseraritymap = [];
  level.baseraritymap[level.arenaweapont1] = 0;
  level.baseraritymap[level.arenaweapont2] = 1;
  level.baseraritymap[level.arenaweapont3] = 2;
  level.baseraritymap[level.arenaweapont4] = 3;
  level.baseraritymap[level.arenaweapont5] = 4;
  level.baseraritymap[level.arenaweapont6] = 5;
  level.baseraritymap[level.arenaweapont7] = 6;
  level.baseraritymap[level.arenaweapont8] = 0;
}

setupweapons() {
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  foreach(loc in _id_9577902B42FBD7F6) {
    if(loc.script_label == "1") {
      spawnweapon(loc, level.arenaweapont1);
      continue;
    }

    if(loc.script_label == "2") {
      spawnweapon(loc, level.arenaweapont2);
      continue;
    }

    if(loc.script_label == "3") {
      spawnweapon(loc, level.arenaweapont3);
      continue;
    }

    if(loc.script_label == "4") {
      spawnweapon(loc, level.arenaweapont4);
      continue;
    }

    if(loc.script_label == "5") {
      spawnweapon(loc, level.arenaweapont5);
      continue;
    }

    if(loc.script_label == "6") {
      spawnweapon(loc, level.arenaweapont6);
      continue;
    }

    if(loc.script_label == "7") {
      spawnweapon(loc, level.arenaweapont7);
      continue;
    }

    if(loc.script_label == "8")
      spawnweapon(loc, level.arenaweapont8);
  }
}

getrandomspawnweapon() {
  weaponlist = level.allweapons;

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    _id_DD515FCF025B2E79 = "";
    data = undefined;
    loopcount = 0;

    for(;;) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];

      if(!issubstr(data["weapon"], "equip"))
        _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(data["weapon"]);
      else
        _id_AB501F397D3CD312 = data["weapon"];

      if(loopcount > weaponlist.size) {
        level.selectedweapons[_id_AB501F397D3CD312] = 1;
        _id_DD515FCF025B2E79 = data["weapon"];

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.allweapons.size; _id_AC0E594AC96AA3A8++) {
          if(level.allweapons[_id_AC0E594AC96AA3A8]["weapon"] == _id_DD515FCF025B2E79) {
            break;
          }
        }

        break;
      }

      loopcount++;
    }

    return _id_DD515FCF025B2E79;
  } else
    return "none";
}

spawnweapon(loc, _id_63573DFB900DD221) {
  if(_id_63573DFB900DD221 == "none") {
    return;
  }
  tracestart = loc.origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = loc.origin + (0, 0, -32);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  _id_1F9238CE81EA0D85 = fixuppickuporigin(loc);

  if(trace["fraction"] < 1.0)
    _id_1F9238CE81EA0D85 = trace["position"] + (0, 0, 2);

  _id_825BB0B1FF925278 = getequipmentmodel(_id_63573DFB900DD221);

  if(_id_825BB0B1FF925278 != "") {
    equipment = spawn("script_model", _id_1F9238CE81EA0D85);
    equipment setModel(_id_825BB0B1FF925278);

    if(isDefined(loc.angles)) {
      if(_id_63573DFB900DD221 == "equip_claymore" || _id_63573DFB900DD221 == "equip_at_mine" || _id_63573DFB900DD221 == "equip_trophy") {
        if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall")
          equipment.angles = (270, loc.angles[1], 90);
        else
          equipment.angles = (0, loc.angles[1], 0);
      } else if(_id_63573DFB900DD221 == "equip_c4") {
        if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall")
          equipment.angles = (180, loc.angles[1], 180);
        else
          equipment.angles = (0, loc.angles[1], 90);
      } else {
        equipment.angles = (0, 90, 0);
        equipment.origin = equipment.origin + (0, 0, 2);
      }
    } else
      equipment.angles = (0, 0, 90);

    userange = 128;
    _id_5DC911E38B550433 = equipment getequipmenthintstring(_id_63573DFB900DD221);
    _id_36E496CDBC979837 = equipment getequipmenthinticon(_id_63573DFB900DD221);
    equipment.equipment = _id_63573DFB900DD221;
    equipment makeusable();
    equipment sethinttag("tag_origin");
    equipment setCursorHint("HINT_BUTTON");
    equipment sethinticon(_id_36E496CDBC979837);
    equipment setuseholdduration("duration_none");
    equipment setusehideprogressbar(1);
    equipment setHintString(_id_5DC911E38B550433);
    equipment setusepriority(0);
    equipment sethintdisplayrange(userange);
    equipment sethintdisplayfov(120);
    equipment setuserange(userange);
    equipment setusefov(360);
    equipment sethintonobstruction("hide");
    equipment thread outlineequipmentwatchplayerprox(_id_825BB0B1FF925278, _id_63573DFB900DD221);
    equipment thread watchequipmentpickup();
  } else {
    _id_AB501F397D3CD312 = undefined;
    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_63573DFB900DD221);
    attachments = [];
    userange = 128;
    objweapon = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, "none", "none", -1);
    weaponname = getcompleteweaponname(objweapon);
    weapon = spawn("weapon_" + weaponname, _id_1F9238CE81EA0D85, 17);
    weapon sethintdisplayrange(userange);
    weapon setuserange(userange);
    manageweaponstartingammo(weapon, weaponname);

    if(isDefined(loc.angles))
      weapon.angles = loc.angles;
    else
      weapon.angles = (0, 0, 90);

    weapon thread outlinewatchplayerprox();
    weapon thread watchpickup();
  }
}

fixuppickuporigin(loc) {
  if(isDefined(loc.script_label) && loc.script_label == "3" && distance(loc.origin, (-488.2, -399.9, 54.25)) < 10)
    loc.origin = (-488.2, -409.9, 54.25);
  else if(isDefined(loc.script_label) && loc.script_label == "5" && distance(loc.origin, (657.3, 644.6, 56)) < 10)
    loc.origin = (665.3, 644.6, 56);

  return loc.origin;
}

getequipmentmodel(weapon) {
  switch (weapon) {
    case "equip_frag":
      return "offhand_wm_grenade_mike67";
    case "equip_semtex":
      return "offhand_wm_grenade_semtex";
    case "equip_c4":
      return "offhand_wm_c4";
    case "equip_claymore":
      return "offhand_wm_claymore_held";
    case "equip_at_mine":
      return "offhand_wm_at_mine";
    case "equip_throwing_knife":
      return "weapon_wm_me_soscar_knife_offhand_thrown";
    case "equip_molotov":
      return "offhand_wm_molotov";
    case "equip_thermite":
      return "offhand_wm_grenade_semtex";
    case "equip_flash":
      return "offhand_wm_grenade_flash";
    case "equip_snapshot_grenade":
      return "offhand_wm_grenade_snapshot_mp";
    case "equip_smoke":
      return "offhand_wm_grenade_smoke";
    case "equip_concussion":
      return "offhand_wm_grenade_concussion";
    case "equip_trophy":
      return "offhand_wm_trophy_system";
    case "equip_decoy":
      return "offhand_wm_grenade_decoy";
    case "equip_adrenaline":
      return "offhand_wm_stim";
    default:
      return "";
  }
}

getequipmenthintstring(weapon) {
  switch (weapon) {
    case "equip_frag":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_FRAG";
    case "equip_semtex":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_SEMTEX";
    case "equip_c4":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_C4";
    case "equip_claymore":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
    case "equip_at_mine":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_ATMINE";
    case "equip_throwing_knife":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_TKNIFE";
    case "equip_molotov":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
    case "equip_thermite":
      self.equiptype = "primary";
      return &"MP_INGAME_ONLY/PICKUP_THERMITE";
    case "equip_flash":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_FLASH";
    case "equip_snapshot_grenade":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
    case "equip_smoke":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_SMOKE";
    case "equip_concussion":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_STUN";
    case "equip_trophy":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_TROPHY_SYSTEM";
    case "equip_decoy":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_DECOY";
    case "equip_adrenaline":
      self.equiptype = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_STIM";
    default:
      return "";
  }
}

getequipmenthinticon(weapon) {
  table = "mp/arenaGGWeapons.csv";
  icon = tablelookup(table, 0, weapon, 3);
  return icon;
}

manageweaponstartingammo(weapon, weaponname) {
  mag = weaponclipsize(weaponname);
  _id_06F592A5FB739460 = 0;

  if(level.magcount != 3) {
    _id_640C8B74FC979400 = !level.magcount;

    if(_id_640C8B74FC979400) {
      mag = 0;
      _id_06F592A5FB739460 = 0;
    } else
      _id_06F592A5FB739460 = level.magcount - 1;

    if(level.magcount == 7)
      _id_06F592A5FB739460 = weaponmaxammo(weaponname);
    else
      _id_06F592A5FB739460 = mag * _id_06F592A5FB739460;
  } else
    _id_06F592A5FB739460 = mag * 2;

  weapon itemweaponsetammo(mag, _id_06F592A5FB739460);
}

watchequipmentpickup() {
  self endon("death");
  self waittill("trigger", player, _id_76F4143215683892);
  hasmaxammo = 0;
  _id_F23035E6F6B69F91 = checkissameequip(player);
  _id_0C89F07DA007FF0D = checkpickupequiptypeammocount(player);
  _id_8B9AB3ABAE98D973 = player scripts\mp\equipment::getequipmentmaxammo(self.equipment);
  _id_B64209459DA65860 = checkcurrentequiptypeammocount(player);

  if(_id_F23035E6F6B69F91) {
    if(_id_0C89F07DA007FF0D == _id_8B9AB3ABAE98D973)
      hasmaxammo = 1;
  }

  if(_id_F23035E6F6B69F91 && !hasmaxammo)
    player scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  else if(_id_B64209459DA65860 && !_id_F23035E6F6B69F91)
    player dropoldequipinplace(player scripts\mp\equipment::getcurrentequipment(self.equiptype));

  if(!_id_F23035E6F6B69F91)
    player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

  if(_id_F23035E6F6B69F91 && hasmaxammo) {
    player iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
  } else {
    player playlocalsound("scavenger_pack_pickup");
    clearweaponoutlines();
    self makeunusable();
    self delete();
  }
}

checkpickupequiptypeammocount(player) {
  return player scripts\mp\equipment::getequipmentammo(self.equipment);
}

checkcurrentequiptypeammocount(player) {
  _id_1189BD7FBE2861F8 = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(_id_1189BD7FBE2861F8))
    return player scripts\mp\equipment::getequipmentammo(_id_1189BD7FBE2861F8);
  else
    return 0;
}

checkissameequip(player) {
  _id_1189BD7FBE2861F8 = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(_id_1189BD7FBE2861F8))
    return self.equipment == _id_1189BD7FBE2861F8;
  else
    return 0;
}

dropoldequipinplace(equipment) {
  spawnweapon(self, equipment);
}

watchpickup() {
  self endon("death");
  self waittill("trigger", player, _id_76F4143215683892);
  clearweaponoutlines();

  if(isDefined(_id_76F4143215683892)) {
    _id_76F4143215683892 thread outlinewatchplayerprox();
    _id_76F4143215683892 thread watchpickup();
  }
}

setenemyloadoutomnvars() {
  _id_AA74D78F1A2354AE = undefined;

  if(!isDefined(self.pers["team"]))
    otherteam = "allies";
  else
    otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  foreach(player in level.players) {
    if(player.team == otherteam) {
      _id_AA74D78F1A2354AE = player;
      break;
    }
  }

  if(!isDefined(_id_AA74D78F1A2354AE))
    _id_AA74D78F1A2354AE = self;

  table = "mp/arenaGGWeapons.csv";
  self setclientomnvar("ui_arena_en_primary", -1);
  self setclientomnvar("ui_arena_en_secondary", -1);
  self setclientomnvar("ui_arena_en_lethal", -1);
  self setclientomnvar("ui_arena_en_tactical", -1);
  primary = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
  self setclientomnvar("ui_arena_en_primary", primary);
  _id_D7B9856A19F9B6B5 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
  self setclientomnvar("ui_arena_en_secondary", _id_D7B9856A19F9B6B5);
  _id_0E8F6FDB8F100FF7 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
  self setclientomnvar("ui_arena_en_lethal", _id_0E8F6FDB8F100FF7);
  tactical = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
  self setclientomnvar("ui_arena_en_tactical", tactical);
}

getgungameloadoutindex(player) {
  _id_627FA174D00EF780 = 0;

  if(game["roundsPlayed"] == 0)
    _id_627FA174D00EF780 = 0;
  else if(isgungameloadouts())
    _id_627FA174D00EF780 = game["roundsWon"][player.pers["team"]];
  else
    _id_627FA174D00EF780 = game["roundsWon"][scripts\mp\utility\game::getotherteam(player.pers["team"])[0]];

  return _id_627FA174D00EF780;
}

getgungameloadoutomnvarindex(player, _id_EC15CE3E7A9D1D86) {
  _id_627FA174D00EF780 = 0;

  if(isgungameloadouts()) {
    _id_627FA174D00EF780 = game["roundsWon"][player.pers["team"]];

    if(isDefined(_id_EC15CE3E7A9D1D86) && _id_EC15CE3E7A9D1D86 == player.pers["team"])
      _id_627FA174D00EF780 = _id_627FA174D00EF780 + 1;
  } else {
    _id_627FA174D00EF780 = game["roundsWon"][scripts\mp\utility\game::getotherteam(player.pers["team"])[0]];

    if(isDefined(_id_EC15CE3E7A9D1D86) && _id_EC15CE3E7A9D1D86 == scripts\mp\utility\game::getotherteam(player.pers["team"])[0])
      _id_627FA174D00EF780 = _id_627FA174D00EF780 + 1;
  }

  return _id_627FA174D00EF780;
}

setenemyloadoutomnvarsatmatchend(_id_EC15CE3E7A9D1D86) {
  foreach(player in level.players) {
    _id_AA74D78F1A2354AE = undefined;

    if(!isDefined(player.pers["team"]))
      otherteam = "allies";
    else
      otherteam = scripts\mp\utility\game::getotherteam(player.pers["team"])[0];

    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(_id_AC0E424AC96A7113.team == otherteam) {
        _id_AA74D78F1A2354AE = _id_AC0E424AC96A7113;
        break;
      }
    }

    if(!isDefined(_id_AA74D78F1A2354AE))
      _id_AA74D78F1A2354AE = player;

    _id_AA74D78F1A2354AE.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutomnvarindex(_id_AA74D78F1A2354AE, _id_EC15CE3E7A9D1D86)];
    table = "mp/arenaGGWeapons.csv";
    player setclientomnvar("ui_arena_en_primary", -1);
    player setclientomnvar("ui_arena_en_secondary", -1);
    player setclientomnvar("ui_arena_en_lethal", -1);
    player setclientomnvar("ui_arena_en_tactical", -1);
    primary = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
    player setclientomnvar("ui_arena_en_primary", primary);
    _id_D7B9856A19F9B6B5 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
    player setclientomnvar("ui_arena_en_secondary", _id_D7B9856A19F9B6B5);
    _id_0E8F6FDB8F100FF7 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
    player setclientomnvar("ui_arena_en_lethal", _id_0E8F6FDB8F100FF7);
    tactical = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
    player setclientomnvar("ui_arena_en_tactical", tactical);
  }
}

spawngameendflagzone(_id_90B3677E000C6C1B) {
  arenaflag = getEntArray("flag_arena", "targetname");

  if(!isDefined(arenaflag[0])) {
    return;
  }
  level.arenaflag = arenaflag[0];
  trigger = arenaflag[0];

  if(isDefined(trigger.target))
    visuals[0] = getEnt(trigger.target, "targetname");
  else {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  trigger.objectivekey = "_a";
  trigger.iconname = "_a";
  arenaflag = _id_6663215F917210AE::setupobjective(trigger, "neutral", undefined, 1);
  arenaflag.onuse = ::arenaflag_onuse;
  arenaflag.onbeginuse = ::arenaflag_onusebegin;
  arenaflag.onenduse = ::arenaflag_onuseend;
  arenaflag.onuseupdate = ::arenaflag_onuseupdate;
  arenaflag.oncontested = ::arenaflag_oncontested;
  arenaflag.isarena = 1;
  arenaflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  arenaflag.id = "domFlag";
  arenaflag.scriptable delete();
  arenaflag scripts\mp\gameobjects::setcapturebehavior("persistent");
  arenaflag.ignorestomp = 1;
  level.objectives[arenaflag.objectivekey] = arenaflag;
  level.arenaflag = arenaflag;

  if(istrue(_id_90B3677E000C6C1B)) {
    wait 0.1;
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
    level.arenaflag.visibleteam = "any";
    level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_ot");
    level.arenaflag thread _id_3686609F08F20087::deleteotpreview();
    level thread showflagoutline();
  } else {
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
    level.arenaflag disableotflag();
  }
}

showflagoutline() {
  waitframe();

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel))
    level.arenaflag.flagmodel.outlinedid = scripts\mp\utility\outline::outlineenableforall(level.arenaflag.flagmodel, "outline_nodepth_orange", "level_script");

  level thread removeflagoutlineongameend();
}

arenaflag_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  usetime = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(player.team);

  if(usetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
    _id_6663215F917210AE::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.iconlosing);
  }
}

arenaflag_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify) {
    if(ownerteam == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
        otherteam = scripts\mp\utility\game::getotherteam(team)[0];
        scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, otherteam);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, ownerteam);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
    }

    self.didstatusnotify = 1;
  }
}

arenaflag_onuseend(team, player, success) {
  level.canprocessot = 1;
  self.didstatusnotify = 0;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread _id_6663215F917210AE::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread _id_6663215F917210AE::updateflagstate(ownerteam, 0);
  }

  if(!success)
    self.neutralized = 0;
}

arenaflag_onuse(_id_22282E7D48CA3400) {
  level.canprocessot = 1;
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);
  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", _id_22282E7D48CA3400);
  _id_6663215F917210AE::dompoint_setcaptured(team, _id_22282E7D48CA3400);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, self);

    self.firstcapture = 0;
  }

  game["dialog"]["round_success"] = "gamestate_win_capture";
  game["dialog"]["round_failure"] = "gamestate_lost_capture";
  level thread arena_endgame(_id_22282E7D48CA3400.team, game["end_reason"]["arena_otflag_completed"], game["end_reason"]["arena_otflag_failed"]);
}

arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread _id_6663215F917210AE::updateflagstate("contested", 0);
  level thread forcegameendcontesttimeout();
}

forcegameendcontesttimeout() {
  level notify("start_overtime_timeout");
  level endon("start_overtime_timeout");
  level endon("game_ended");

  if(!isDefined(level.ottimecontested))
    level.ottimecontested = 0;

  while(level.ottimecontested < 5000) {
    wait(level.framedurationseconds);
    level.ottimecontested = level.ottimecontested + level.frameduration;
  }

  level.canprocessot = 1;
}

disableotflag() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();

  if(isDefined(self.scriptable))
    self.scriptable delete();

  self.flagmodel hide();
}

removeflagoutlineongameend() {
  level waittill("game_ended");

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel.outlinedid))
    scripts\mp\utility\outline::outlinedisable(level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel);
}

deleteotpreview() {
  level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  disableotflag();
}

setupendzones() {
  level.attackerendzone = getEntArray("flag_goal_attacker", "targetname");
  level.defenderendzone = getEntArray("flag_goal_defender", "targetname");
  level.attackerendzone = level.attackerendzone[0] createendzone(game["attackers"]);
  level.defenderendzone = level.defenderendzone[0] createendzone(game["defenders"]);
  level.objectives = [];
  level.objectives[level.objectives.size] = level.attackerendzone;
  level.objectives[level.objectives.size] = level.defenderendzone;
}

createendzone(team) {
  if(isDefined(self.target))
    visuals[0] = getEnt(self.target, "targetname");
  else {
    visuals[0] = spawn("script_model", self.origin);
    visuals[0].angles = self.angles;
  }

  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);

  if(isDefined(self.objectivekey))
    objectivekey = self.objectivekey;
  else
    objectivekey = self.script_label;

  if(isDefined(self.iconname))
    iconname = self.iconname;
  else
    iconname = self.script_label;

  _id_54B003CE5D016238 = scripts\mp\gameobjects::createuseobject(team, self, visuals, (0, 0, 100));
  _id_54B003CE5D016238.team = team;
  _id_54B003CE5D016238.ownerteam = team;
  _id_54B003CE5D016238 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  _id_54B003CE5D016238 scripts\mp\gameobjects::allowuse("enemy");
  _id_54B003CE5D016238 scripts\mp\gameobjects::cancontestclaim(1);
  _id_54B003CE5D016238 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  _id_54B003CE5D016238.onuse = ::endzone_onuse;
  _id_54B003CE5D016238.onbeginuse = ::endzone_onusebegin;
  _id_54B003CE5D016238.onenduse = ::endzone_onuseend;
  _id_54B003CE5D016238.oncontested = ::endzone_oncontested;
  _id_54B003CE5D016238.onuncontested = ::endzone_onuncontested;
  _id_54B003CE5D016238.isarena = 1;
  _id_54B003CE5D016238 scripts\mp\gameobjects::pinobjiconontriggertouch();
  _id_54B003CE5D016238.id = "domFlag";

  if(isDefined(level.capturetype))
    _id_54B003CE5D016238 scripts\mp\gameobjects::setcapturebehavior(getcapturetype());

  _id_54B003CE5D016238.objectivekey = objectivekey;
  _id_54B003CE5D016238.iconname = iconname;
  _id_54B003CE5D016238 scripts\mp\gameobjects::setvisibleteam("any");
  _id_54B003CE5D016238.stompprogressreward = ::endzone_stompprogressreward;
  _id_54B003CE5D016238.nousebar = 1;
  _id_54B003CE5D016238.claimgracetime = level.flagcapturetime * 1000;
  tracestart = visuals[0].origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = visuals[0].origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  _id_54B003CE5D016238.baseeffectpos = trace["position"];
  upangles = vectortoangles(trace["normal"]);
  _id_54B003CE5D016238.baseeffectforward = anglesToForward(upangles);
  scriptable = spawn("script_model", _id_54B003CE5D016238.baseeffectpos);
  scriptable setModel("dom_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(_id_54B003CE5D016238.baseeffectforward, scriptable.angles);
  _id_54B003CE5D016238.scriptable = scriptable;
  _id_54B003CE5D016238.vfxnamemod = "";

  if(isDefined(_id_54B003CE5D016238.trigger.radius)) {
    if(_id_54B003CE5D016238.trigger.radius == 160)
      _id_54B003CE5D016238.vfxnamemod = "_160";
    else if(_id_54B003CE5D016238.trigger.radius == 90)
      _id_54B003CE5D016238.vfxnamemod = "_90";
    else if(_id_54B003CE5D016238.trigger.radius == 315)
      _id_54B003CE5D016238.vfxnamemod = "_300";
    else if(_id_54B003CE5D016238.trigger.radius != 120)
      _id_54B003CE5D016238.noscriptable = 1;
  }

  _id_54B003CE5D016238.flagmodel = spawn("script_model", _id_54B003CE5D016238.baseeffectpos);
  _id_54B003CE5D016238.flagmodel setModel("military_dom_flag_neutral");
  _id_54B003CE5D016238.outlineent = _id_54B003CE5D016238.flagmodel;
  return _id_54B003CE5D016238;
}

endzone_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  usetime = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(player.team);

  if(usetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
    _id_6663215F917210AE::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontakingendzone, level.iconlosingendzone);
  }
}

endzone_onuseend(team, player, success) {
  level.canprocessot = 1;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);

  if(!success)
    self.neutralized = 0;
}

endzone_onuse(_id_22282E7D48CA3400) {
  level.canprocessot = 1;
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  self.capturetime = gettime();
  self.neutralized = 0;
  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", _id_22282E7D48CA3400);
  endzone_setcaptured(team, _id_22282E7D48CA3400);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, self);
  }

  level thread arena_endgame(_id_22282E7D48CA3400.team, game["end_reason"]["objective_completed"], undefined, 0, 2);
}

endzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestendzone);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

endzone_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.processot = 1;
}

endzone_setcaptured(team, _id_22282E7D48CA3400) {
  scripts\mp\gameobjects::setownerteam(team);
  self notify("capture", _id_22282E7D48CA3400);
  self notify("assault", _id_22282E7D48CA3400);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.neutralized = 0;

  if(self.touchlist[team].size == 0)
    self.touchlist = self.oldtouchlist;

  thread giveflagcapturexp(self.touchlist[team], _id_22282E7D48CA3400);

  if(isDefined(level.matchrecording_logevent))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(team == "allies", 1, 2));

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + team);
}

endzone_stompprogressreward(player) {
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
}

getcapturetype() {
  capturetype = "normal";

  if(level.capturetype == 2)
    capturetype = "neutralize";
  else if(level.capturetype == 3)
    capturetype = "persistent";

  return capturetype;
}

giveflagcapturexp(touchlist, _id_22282E7D48CA3400) {
  level endon("game_ended");
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  level.lastcaptime = gettime();

  if(isPlayer(_id_0666D6B1872868D7)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", _id_0666D6B1872868D7);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  }

  _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

  for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
    player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    player scripts\mp\utility\stats::incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A7B15A24E10A93B");
    wait 0.05;
  }
}

startotmechanics() {
  if(level.objmodifier == 1) {
    foreach(objective in level.objectives)
    objective deleteendzone();
  }

  level.canprocessot = 1;

  if(!isDefined(level.arenaflag.objidnum))
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);

  level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  level.arenaflag scripts\mp\gameobjects::enableobject();
  level.arenaflag scripts\mp\gameobjects::allowuse("enemy");
  level.arenaflag.flagmodel show();

  if(level.spawnflag)
    game["dialog"]["overtime"] = "gamestate_overtime_flagspawn";

  foreach(player in level.players) {
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }
    player scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
  }

  level.arenaflag.flagmodel playSound("flag_spawned");
  level thread showflagoutline();
}

deleteendzone() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::releaseid();
  self.trigger = undefined;
  self notify("deleted");
  self.visibleteam = "none";

  if(isDefined(self.scriptable))
    self.scriptable delete();

  self.flagmodel delete();
}

dogtagallyonusecb(player) {}

dogtagenemyonusecb(player) {
  player.health = player.maxhealth;
  player notify("healed");
}

outlineenemyplayers() {
  level endon("prematch_done");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(player in level.players) {
      entnum = player getentitynumber();

      if(!isDefined(player.outlinedenemies)) {
        if(!isDefined(level.activeoutlines))
          level.activeoutlines = 1;
        else
          level.activeoutlines++;
      }

      foreach(_id_AC0E424AC96A7113 in level.players) {
        if(_id_AC0E424AC96A7113 != player && _id_AC0E424AC96A7113.team != player.team) {
          if(isDefined(player.outlinedenemies))
            scripts\mp\utility\outline::outlinedisable(player.outlinedenemies, player);

          player.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(player, _id_AC0E424AC96A7113.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

outlineenemyplayerslaunchchunk() {
  level endon("game_ended");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(player in level.players) {
      entnum = player getentitynumber();

      if(!isDefined(player.outlinedenemies)) {
        if(!isDefined(level.activeoutlines))
          level.activeoutlines = 1;
        else
          level.activeoutlines++;
      }

      foreach(_id_AC0E424AC96A7113 in level.players) {
        if(_id_AC0E424AC96A7113 != player && _id_AC0E424AC96A7113.team != player.team) {
          if(isDefined(player.outlinedenemies))
            scripts\mp\utility\outline::outlinedisable(player.outlinedenemies, player);

          player.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(player, _id_AC0E424AC96A7113.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

removeenemyoutlines() {
  thread notifyremoveoutlines();
  level scripts\engine\utility::waittill_any_2("prematch_done", "removeArenaOutlines");

  foreach(player in level.players) {
    entnum = player getentitynumber();

    if(isDefined(player.outlinedenemies)) {
      level.activeoutlines--;
      scripts\mp\utility\outline::outlinedisable(player.outlinedenemies, player);
      player.outlinedenemies = undefined;
    }
  }
}

notifyremoveoutlines() {
  level endon("prematch_done");
  level waittill("match_start_real_countdown");

  if(level.prematchperiodend > 5)
    time = int(max(level.prematchperiodend - 5, 5));
  else
    time = int(max(level.prematchperiodend - 2, 2));

  wait(time);
  level notify("removeArenaOutlines");
}

outlineequipmentwatchplayerprox(_id_825BB0B1FF925278, equipname) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  basescore = level.baseraritymap[equipname];
  _id_4430B08D5A2D47BF = getoutlineasset(basescore);

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player.hasarenaspawned)) {
        dist = distance2dsquared(self.origin, player.origin);
        entnum = player getentitynumber();

        if(dist < 490000) {
          if(!isDefined(self.outlinedplayers[entnum])) {
            if(!isDefined(level.activeoutlines))
              level.activeoutlines = 1;
            else
              level.activeoutlines++;

            self.outlinedplayers[entnum] = scripts\mp\utility\outline::outlineenableforplayer(self, player, _id_4430B08D5A2D47BF, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[entnum])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[entnum], self);
          self.outlinedplayers[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

outlinewatchplayerprox() {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  _id_C27E2A04BAB78C1F = scripts\mp\weapons::getitemweaponname();
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_C27E2A04BAB78C1F);
  basescore = level.baseraritymap[_id_AB501F397D3CD312 + "_mp"];
  _id_4430B08D5A2D47BF = getoutlineasset(basescore);

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player.hasarenaspawned)) {
        dist = distance2dsquared(self.origin, player.origin);
        entnum = player getentitynumber();

        if(dist < 490000) {
          if(!isDefined(self.outlinedplayers[entnum])) {
            if(!isDefined(level.activeoutlines))
              level.activeoutlines = 1;
            else
              level.activeoutlines++;

            self.outlinedplayers[entnum] = scripts\mp\utility\outline::outlineenableforplayer(self, player, _id_4430B08D5A2D47BF, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[entnum])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[entnum], self);
          self.outlinedplayers[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

getoutlineasset(basescore) {
  if(!isDefined(basescore))
    basescore = 0;

  _id_4430B08D5A2D47BF = "white";
  score = int(min(basescore, 8));

  switch (score) {
    case 0:
      _id_4430B08D5A2D47BF = "outline_depth_white";
      break;
    case 1:
      _id_4430B08D5A2D47BF = "outline_depth_green";
      break;
    case 2:
      _id_4430B08D5A2D47BF = "outline_depth_cyan";
      break;
    case 3:
      _id_4430B08D5A2D47BF = "outline_depth_red";
      break;
    case 4:
      _id_4430B08D5A2D47BF = "outline_depth_orange";
      break;
    case 5:
      _id_4430B08D5A2D47BF = "outline_depth_yellow";
      break;
    case 6:
      _id_4430B08D5A2D47BF = "outline_depth_blue";
      break;
    case 7:
      _id_4430B08D5A2D47BF = "outline_depth_green";
      break;
    case 8:
      _id_4430B08D5A2D47BF = "outline_depth_red";
      break;
  }

  return _id_4430B08D5A2D47BF;
}

clearweaponoutlines() {
  foreach(key, value in self.outlinedplayers) {
    level.activeoutlines--;
    scripts\mp\utility\outline::outlinedisable(value, self);
    value = undefined;
  }
}

selflookatfriendly() {
  level endon("prematch_ended");
  _id_F0EA4030349A33D5 = undefined;
  _id_C244143DAA28D2F0 = 0;

  while(isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
    alive = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

    if(alive.size > 1) {
      _id_C244143DAA28D2F0 = 1;
      break;
    }

    waitframe();
  }

  if(_id_C244143DAA28D2F0) {
    _id_5BCF8DFEAFE8ACE2 = self.angles;
    count = 0;
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(t in _id_6D5ED003AF1F9612) {
      if(t != self)
        _id_F0EA4030349A33D5 = t;
    }

    _id_93616E7A405192C4 = _id_F0EA4030349A33D5.origin - self.origin;
    _id_2EA336DF4F6E46EA = self.origin - _id_F0EA4030349A33D5.origin;
    _id_BBEA66C71351983F = anglestoright(self.angles);
    _id_2E9A24DF4F6400A6 = vectordot(_id_BBEA66C71351983F, _id_93616E7A405192C4);
    _id_386AD24C3342DAB7 = 0;
    lookright = 0;

    if(_id_2E9A24DF4F6400A6 < 0) {
      _id_0DD4BAD131228EA4 = 85;
      _id_386AD24C3342DAB7 = 1;
    } else {
      _id_0DD4BAD131228EA4 = -90;
      lookright = 1;
    }

    if(isDefined(_id_F0EA4030349A33D5)) {
      if(_id_386AD24C3342DAB7) {
        if(!isbot(self)) {
          wait 0.5;

          if(self.currentweapon.basename != "none")
            self forceplaygestureviewmodel("ges_crush_turnleft");
        }
      } else if(!isbot(self)) {
        wait 0.5;

        if(self.currentweapon.basename != "none")
          self forceplaygestureviewmodel("ges_crush_turnright");
      }

      wait 3;
      scripts\mp\utility\player::_freezecontrols(0);
      return;
    }

    scripts\mp\utility\player::_freezecontrols(0);
    return;
  } else
    scripts\mp\utility\player::_freezecontrols(0);
}

updatematchstatushintonspawn() {
  level endon("game_ended");
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");
}

seticonnames() {
  level.iconcaptureendzone = "waypoint_capture_endzone";
  level.icondefendendzone = "waypoint_defend_endzone";
  level.iconcontestendzone = "waypoint_contesting_endzone";
  level.icontakingendzone = "waypoint_taking_endzone";
  level.iconlosingendzone = "waypoint_losing_endzone";
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_ot_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_misc_dog_tag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_misc_dog_tag", 0);
}

israndomloadouts() {
  return level.arenaloadouts == 2;
}

ispickuploadouts() {
  return level.arenaloadouts == 3;
}

isgungameloadouts() {
  return level.arenaloadouts == 4;
}

isrvsgungameloadouts() {
  return level.arenaloadouts == 5;
}

israndompreviewloadouts() {
  return level.arenaloadouts == 6;
}

israndomalphaoneloadouts() {
  return level.arenaloadouts == 7;
}

israndomalphatwoloadouts() {
  return level.arenaloadouts == 8;
}

israndomalphathreeloadouts() {
  return level.arenaloadouts == 9;
}

israndomalphafourloadouts() {
  return level.arenaloadouts == 10;
}

israndomalphafiveloadouts() {
  return level.arenaloadouts == 11;
}

israndomalphaloadouts() {
  switch (level.arenaloadouts) {
    case 11:
    case 10:
    case 9:
    case 8:
    case 7:
      return 1;
    default:
      return 0;
  }
}

dogtagallyonusecbconf(player) {
  if(isPlayer(player))
    player scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], level.scoredeny, 0);
}

dogtagenemyonusecbconf(player) {
  if(isPlayer(player))
    player scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);

  player scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], level.scoreconfirm, 0);
}

botpickuphack() {
  level endon("game_ended");
  wait 1;
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 1;

  for(;;) {
    foreach(player in level.players) {
      if(isbot(player)) {
        _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(level.arenaweapont1);
        attachments = [];
        _id_66B3DB972AC1531E = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, "none", "none", -1);
        _id_DD515FCF025B2E79 = getcompleteweaponname(_id_66B3DB972AC1531E);
        player scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_DD515FCF025B2E79);
        player scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_66B3DB972AC1531E);
      }
    }

    break;
  }

  foreach(player in level.players) {
    if(isbot(player))
      player thread fakepickups();
  }
}

fakepickups() {
  for(;;) {
    wait 1;

    if(self.currentprimaryweapon.basename != "iw8_pi_decho_mp" && self.currentprimaryweapon.basename != "iw8_pi_mike1911_mp" && self.currentprimaryweapon.basename != "iw9_me_fists_mp" && self.currentprimaryweapon.basename != "none")
      wait 3;

    if(!self attackButtonPressed() && !self isreloading() && !self useButtonPressed()) {
      self botpressbutton("use", 0.5);
      continue;
    }

    wait 0.5;

    if(!self attackButtonPressed() && !self isreloading() && !self useButtonPressed())
      self botpressbutton("use", 0.5);
  }
}

bootcampmodewatcher() {
  level endon("game_ended");

  for(;;) {
    _id_BAAD1502BCA0F26F = getdvarint("dvar_52B2904136C93F2B");

    if(_id_BAAD1502BCA0F26F != -1) {
      timelimit = 3;
      level.starttime = gettime();
      _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
      level.watchdvars[_id_B2FF82EC901486E4].value = timelimit;
      level.overridewatchdvars[_id_B2FF82EC901486E4] = timelimit;
      game["bootCampOverride"] = _id_BAAD1502BCA0F26F;
    }

    wait 1;
  }
}