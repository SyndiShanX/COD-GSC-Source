/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_alt.gsc
***********************************************/

function main() {
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

  if(game["launchChunkRuleSet"] > 3) {
    game["launchChunkRuleSet"] = 0;
  }

  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 30);
  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
  scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 19);
  scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 10);
  scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  setDvar("LKNNQKNTS", 0);

  if(!isDefined(level.tweakablesinitialized)) {
    scripts\mp\tweakables::init();
  }

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
      } else {
        game["dialog"]["lc_intro"] = "lc_ffa_third";
      }

      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 180);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 15);
      waitthensethealthregentweakable(6);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerKill", 1);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_dogtags", 0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_lethalDelay", 0);
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
      } else {
        game["dialog"]["lc_intro"] = "lc_arena_third";
      }

      setomnvar("ui_round_hint_override_attackers", 0);
      setomnvar("ui_round_hint_override_defenders", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 40);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 6);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 6);
      waitthensethealthregentweakable(0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerKill", 0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_dogtags", 0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_lethalDelay", 5);
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
      } else {
        game["dialog"]["lc_intro"] = "lc_pos_third";
      }

      setomnvar("ui_round_hint_override_attackers", 0);
      setomnvar("ui_round_hint_override_defenders", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 40);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 6);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 6);
      waitthensethealthregentweakable(0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerKill", 0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_dogtags", 0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_lethalDelay", 5);
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
      } else {
        game["dialog"]["lc_intro"] = "lc_conf_third";
      }

      setomnvar("ui_round_hint_override_attackers", 2);
      setomnvar("ui_round_hint_override_defenders", 2);
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 180);
      scripts\mp\utility\dvars::setoverridewatchdvar("numlives", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("roundlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 20);
      waitthensethealthregentweakable(6);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerKill", 0);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_dogtags", 1);
      setDvar("scr_" + scripts\mp\utility\game::getgametype() + "_lethalDelay", 0);
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

  setDvar("OOTQKOTRM", 4);
  level.teambased = 1;
  level.objectivebased = 1;
  level.ontimelimit = &ontimelimit;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerdamaged = &onplayerdamaged;
  level.onnormaldeath = &onnormaldeath;
  level.onplayerkilled = &onplayerkilled;
  level.modeonspawnplayer = &onspawnplayer;
  level.ondeadevent = &ondeadevent;
  level.ontimelimitot = &ontimelimitot;
  level.droplaunchchunkbots = &droplaunchchunkbots;
  level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
  level.allowlatecomers = 0;

  if(!scripts\mp\utility\game::iswinbytworulegametype()) {
    level.skipdefendersadvantage = 1;
  }

  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  level.bypassclasschoicefunc = &alwaysgamemodeclass;
  game["dialog"]["gametype"] = "gametype_arena";

  if(getdvarint("OSMSLRTOP")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("NOSLRNTRKL")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  if(ispickuploadouts() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_pickups";
    game["dialog"]["defense_obj"] = "boost_arena_pickups";
  } else if(level.objmodifier == 1 && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_objective";
    game["dialog"]["defense_obj"] = "boost_arena_objective";
  } else {
    game["dialog"]["offense_obj"] = "boost_arena";
    game["dialog"]["defense_obj"] = "boost_arena";
  }

  game["dialog"]["obj_indepth"] = "boost_arena_indepth";
  game["dialog"]["securing_a"] = "flag_securing";
  game["dialog"]["losing_a"] = "flag_losing";
  game["dialog"]["secured_a"] = "flag_secured";
  game["dialog"]["lost_a"] = "flag_lost";
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
    return;
  }

  if(game["launchChunkRuleSet"] == 3) {
    game["dialog"]["gametype"] = "gametype_killconfirmed";
    game["dialog"]["boost"] = "boost_killconfirmed";
    game["dialog"]["offense_obj"] = "boost_killconfirmed";
    game["dialog"]["defense_obj"] = "boost_killconfirmed";
    game["dialog"]["kill_confirmed"] = "kill_confirmed";
    return;
  }
}

function waitthensethealthregentweakable(var0) {
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", var0);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", var0);
}

function launchchunkbotspawning() {
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

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_arena_arenaloadouts", getmatchrulesdata("arenaData", "arenaLoadouts"));
  setdynamicdvar("scr_arena_loadoutchangeround", getmatchrulesdata("arenaData", "loadoutChangeRound"));
  setdynamicdvar("scr_arena_switchspawns", getmatchrulesdata("arenaData", "switchSpawns"));
  setdynamicdvar("scr_arena_winCondition", getmatchrulesdata("arenaData", "winCondition"));
  setdynamicdvar("scr_arena_objModifier", getmatchrulesdata("arenaData", "objModifier"));
  setdynamicdvar("scr_arena_spawnFlag", getmatchrulesdata("arenaData", "spawnFlag"));
  setdynamicdvar("scr_arena_flagCaptureTime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_arena_tacticaltimemod", getmatchrulesdata("arenaData", "tacticalTimeMod"));
  setdynamicdvar("scr_arena_blastshieldmod", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar("scr_arena_blastshieldclamp", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar("scr_arena_startWeapon", getmatchrulesdata("arenaData", "startWeapon"));
  setdynamicdvar("scr_arena_weaponTier1", getmatchrulesdata("arenaData", "weaponTier1"));
  setdynamicdvar("scr_arena_weaponTier2", getmatchrulesdata("arenaData", "weaponTier2"));
  setdynamicdvar("scr_arena_weaponTier3", getmatchrulesdata("arenaData", "weaponTier3"));
  setdynamicdvar("scr_arena_weaponTier4", getmatchrulesdata("arenaData", "weaponTier4"));
  setdynamicdvar("scr_arena_weaponTier5", getmatchrulesdata("arenaData", "weaponTier5"));
  setdynamicdvar("scr_arena_weaponTier6", getmatchrulesdata("arenaData", "weaponTier6"));
  setdynamicdvar("scr_arena_weaponTier7", getmatchrulesdata("arenaData", "weaponTier7"));
  setdynamicdvar("scr_arena_weaponTier8", getmatchrulesdata("arenaData", "weaponTier8"));
  setdynamicdvar("scr_arena_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/WAR_HINT");
  }

  initspawns();
  thread adjustroundendtimer();
  thread waittooverridegraceperiod();

  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    thread updaterandomloadout();
  } else if(ispickuploadouts()) {
    level.lethaldelay = 0;
    defineplayerloadout();
    initweaponmap();
    thread setupweapons();
  } else if(isgungameloadouts()) {
    level.blockweapondrops = 1;
    thread updatearenagungameloadout(0);
  } else if(isrvsgungameloadouts()) {
    level.blockweapondrops = 1;
    thread updatearenagungameloadout(1);
  }

  buildloadoutsforweaponstreaming();
  setupwaypointicons();
  seticonnames();

  if(level.objmodifier == 1) {
    setupendzones(level);
  }

  var5 = 0;

  switch (game["launchChunkRuleSet"]) {
    case 0:
      break;
    case 1:
      if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
        var5 = 1;
      }

      break;
    case 2:
      break;
    case 3:
      break;
    default:
      break;
  }

  level thread scripts\mp\gametypes\arena::spawngameendflagzone(var5);
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    if(game["roundsPlayed"] == 0) {
      if(game["launchChunkRuleSet"] == 0 && game["prevLaunchChunkRuleSet"] != 3) {
        thread outlineenemyplayerslaunchchunk();
      } else {
        thread outlineenemyplayers();
        thread removeenemyoutlines();
      }
    }
  }

  if(game["roundsPlayed"] == 0) {
    thread setroundwinstreakarray();
  }

  setDvar("scr_disablePerks", 1);
}

function droplaunchchunkbots() {
  if(istrue(game["chunkBotsSpawned"])) {
    game["chunkBotsSpawned"] = 0;
    scripts\mp\bots\bots::drop_bots(1, "allies");
    scripts\mp\bots\bots::drop_bots(1, "axis");
    return;
  }
}

function tryspawnlaunchchunkbots() {
  if(istrue(game["chunkBotsSpawned"])) {
    return;
  }

  level thread scripts\mp\bots\bots::spawn_bots(1, "allies", undefined, undefined, "spawned_allies", "recruit");
  level thread scripts\mp\bots\bots::spawn_bots(1, "axis", undefined, undefined, "spawned_enemies", "recruit");
  game["chunkBotsSpawned"] = 1;
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
  level.ingraceperiod = 5;
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 4;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();

  if(game["launchChunkRuleSet"] == 3) {
    level.dogtagallyonusecb = &dogtagallyonusecbconf;
    level.dogtagenemyonusecb = &dogtagenemyonusecbconf;
  } else if(level.dogtagsenabled) {
    level.dogtagallyonusecb = &dogtagallyonusecb;
    level.dogtagenemyonusecb = &dogtagenemyonusecb;
  }

  if(getdvarint("allow_enemy_proxchat", 0) == 1) {
    setDvar("LOSOOOTNMS", 1);
    var0 = 128;
    var1 = getdvarint("proxchat_radius_override", 0);

    if(var1 != 0) {
      var0 = var1;
    }

    setDvar("NNMLSMNTOQ", var0);
  }

  var2 = 0;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var3 = getdvarint("allow_arenaLoadouts_override", 0);

    if(var3) {
      var2 = getdvarint("arenaLoadouts_override", 0);
    }
  }

  level.arenaloadouts = 2;
  level.loadoutchangeround = scripts\mp\utility\dvars::dvarintvalue("loadoutChangeRound", 3, 0, 5);

  if(var2 != 0) {
    level.arenaloadouts = var2;
    level.loadoutchangeround = 3;
  }

  level.switchspawns = scripts\mp\utility\dvars::dvarintvalue("switchSpawns", 1, 0, 1);
  level.wincondition = scripts\mp\utility\dvars::dvarintvalue("winCondition", 1, 0, 2);
  setomnvar("ui_arena_loadout_type", level.arenaloadouts);
  setomnvar("ui_wincondition", level.wincondition);
  level.objmodifier = scripts\mp\utility\dvars::dvarintvalue("objModifier", 0, 0, 1);
  level.spawnflag = scripts\mp\utility\dvars::dvarintvalue("spawnFlag", 0, 0, 1);

  if(game["launchChunkRuleSet"] != 1 && game["launchChunkRuleSet"] != 2) {
    level.spawnflag = 0;
  } else if(level.spawnflag) {
    level.ontimelimitgraceperiod = 10;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
  }

  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("tacticalTimeMod", 2.5, 0.5, 5);
  level.startweapon = getDvar("scr_arena_startWeapon", "none");
  level.arenaweapont1 = getDvar("scr_arena_weaponTier1", "iw8_pi_golf21_mp");
  level.arenaweapont2 = getDvar("scr_arena_weaponTier2", "iw8_sh_dpapa12_mp");
  level.arenaweapont3 = getDvar("scr_arena_weaponTier3", "iw8_sm_mpapa5_mp");
  level.arenaweapont4 = getDvar("scr_arena_weaponTier4", "iw8_ar_mike4_mp");
  level.arenaweapont5 = getDvar("scr_arena_weaponTier5", "iw8_sn_alpha50_mp");
  level.arenaweapont6 = getDvar("scr_arena_weaponTier6", "equip_frag");
  level.arenaweapont7 = getDvar("scr_arena_weaponTier7", "equip_concussion");
  level.arenaweapont8 = getDvar("scr_arena_weaponTier8", "equip_adrenaline");

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
    thread botpickuphack();
  }

  if(ispickuploadouts()) {
    buildrandomweapontable();

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
    return;
  }
}

function getrandomweaponforweapontier(var0) {
  if(issubstr(var0, "rand")) {
    if(var0 == "random") {
      var0 = getrandomspawnweapon();
    } else {
      var0 = getrandomweaponfromcategory(var0);
    }
  }

  return var0;
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("LaunchChunk", "Crit_Default");
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn");

  if(var0.size > 0 || var1.size > 0) {
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

  if(var2.size > 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_arena_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_arena_spawn");
    level.spawntype = "mp_arena_spawn";
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    if(var2.size > 0) {
      scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
      scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
      level.spawntype = "mp_tdm_spawn";
    } else {
      level.alwaysusestartspawns = 1;
    }
  }

  if(!istrue(level.alwaysusestartspawns)) {
    scripts\mp\spawnlogic::registerspawnset("normal", level.spawntype);
    scripts\mp\spawnlogic::registerspawnset("fallback", level.spawntype);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function validatespawns(var0) {
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = scripts\mp\spawnlogic::getspawnpointarray(var0);

  foreach(var7 in var5) {
    if(isDefined(var7.script_noteworthy)) {
      if(!var1) {
        var1 = var7.script_noteworthy == "1";
      }

      if(!var2) {
        var2 = var7.script_noteworthy == "2";
      }

      if(!var3) {
        var3 = var7.script_noteworthy == "3";
        level.hasthreespawns = 1;
      }

      continue;
    }

    if(var4 == 0) {
      var7.script_noteworthy = "1";
      var4++;
      continue;
    }

    if(var4 == 1) {
      var7.script_noteworthy = "2";
      var4++;
      continue;
    }

    if(var4 == 2) {
      var7.script_noteworthy = "3";
      var4++;
      level.hasthreespawns = 1;
    }
  }
}

function getspawnpoint() {
  var0 = undefined;
  var1 = level.axisstartspawn;
  var2 = 0;
  var3 = 0;

  if(self.pers["team"] == game["attackers"]) {
    var1 = level.alliesstartspawn;
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || dotournamentendgame()) {
    var4 = scripts\mp\spawnlogic::getspawnpointarray(var1);

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0) {
      var5 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

      if(var5 > 3) {
        foreach(var7 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
          if(isDefined(var7.pers["arena_spawn_pos"])) {
            var7.pers["arena_spawn_pos"] = "0";
          }
        }

        var3 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0 && !var3) {
      if(self.pers["arena_spawn_pos"] == "1") {
        self.pers["arena_spawn_pos"] = "2";
      } else if(scripts\mp\utility\teams::getteamcount(self.pers["team"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["arena_spawn_pos"] == "2") {
        self.pers["arena_spawn_pos"] = "3";
      } else if(self.pers["arena_spawn_pos"] == "3") {
        self.pers["arena_spawn_pos"] = "1";
      } else {
        self.pers["arena_spawn_pos"] = "1";
      }

      var0 = getswitchside_spawnpoint(var4, self.pers["arena_spawn_pos"]);
    }

    if(!isDefined(var0)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["arena_spawn_pos"])) {
        cleanupspawn_scriptnoteworthy();
        var0 = getspawnpoint_startspawn(var4);
        self.switching_teams_arena = undefined;
      } else {
        var0 = getspawnpoint_startspawn(var4);
      }

      if(!isDefined(var0)) {
        var5 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

        if(var5 > 3) {
          var9 = undefined;

          foreach(var7 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
            if(isDefined(var7.pers["arena_spawn_pos"])) {
              if(level.usedspawnposone == 1 && level.usedspawnposone == 1 && level.usedspawnposthree == 1) {
                level.usedspawnposone = 0;
                level.usedspawnpostwo = 0;
                level.usedspawnposthree = 0;
              }

              if(var7.pers["arena_spawn_pos"] == "1" && level.usedspawnposone == 0) {
                level.usedspawnposone++;
                var9 = var7;
                break;
              }

              if(var7.pers["arena_spawn_pos"] == "2" && level.usedspawnpostwo == 0) {
                level.usedspawnpostwo++;
                var9 = var7;
                break;
              }

              if(var7.pers["arena_spawn_pos"] == "3" && level.usedspawnposthree == 0) {
                level.usedspawnposthree++;
                var9 = var7;
                break;
              }

              level.usedspawnposone++;
              var9 = var7;
              break;
            }
          }

          if(isDefined(var9)) {
            var0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var9);
            var2 = 1;
          }
        }
      }

      if(istrue(level.switchspawns) && game["roundsPlayed"] == 0 && !var2) {
        self.pers["arena_spawn_pos"] = var0.script_noteworthy;
      }
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    var0 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return var0;
}

function cleanupspawn_scriptnoteworthy() {
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  if(var0 == game["attackers"]) {
    var1 = level.alliesstartspawn;
    var2 = level.axisstartspawn;
  } else {
    var1 = level.axisstartspawn;
    var2 = level.alliesstartspawn;
  }

  var3 = scripts\mp\spawnlogic::getspawnpointarray(var1);

  foreach(var5 in var3) {
    if(var5.script_noteworthy == self.pers["arena_spawn_pos"]) {
      var5.selected = 0;
    }
  }

  var3 = scripts\mp\spawnlogic::getspawnpointarray(var2);

  foreach(var5 in var3) {
    foreach(var9 in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
      if(var9 != self && isDefined(var9.pers["arena_spawn_pos"]) && var5.script_noteworthy != var9.pers["arena_spawn_pos"]) {
        var5.selected = 0;
      }
    }
  }
}

function getspawnpoint_startspawn(var0, var1) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var2 = undefined;
  var0 = scripts\mp\spawnscoring::checkdynamicspawns(var0);

  foreach(var4 in var0) {
    if(!isDefined(var4.selected)) {
      continue;
    }

    if(var4.selected) {
      continue;
    }

    if(var4.script_noteworthy == "1") {
      var2 = var4;
      break;
    } else if(var4.script_noteworthy == "2") {
      var2 = var4;
      break;
    }

    var2 = var4;
  }

  if(isDefined(var2)) {
    var2.selected = 1;
  }

  return var2;
}

function getswitchside_spawnpoint(var0, var1) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var2 = 0;

  foreach(var4 in var0) {
    if(var4.script_noteworthy == var1) {
      if(istrue(var4.selected)) {
        var2 = 1;
        continue;
      }

      var4.selected = 1;
      return var4;
    }
  }

  return undefined;
}

function onplayerconnect(var0) {
  level.bots_gametype_handles_class_choice = 1;

  if(istrue(level.resetstats)) {
    resetpersstats(var0);
  }

  var0.arenadamage = 0;
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["damage"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["damage"]);
  }

  var0 setclientomnvar("ui_skip_loadout", 1);
  var0 setclientomnvar("ui_launch_chunk_phase", 0);
  var0.pers["class"] = "gamemode";
  var0.pers["lastClass"] = "";
  var0.class = var0.pers["class"];
  var0.lastclass = var0.pers["lastClass"];

  if(!istrue(game["chunkFirstAssigned"])) {
    var0.pers["gamemodeLoadout"] = level.chunkloadouts[3];
    game["chunkFirstAssigned"] = 1;
  } else if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    var0.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
  } else if(ispickuploadouts()) {
    var0.pers["gamemodeLoadout"] = level.arena_loadouts["axis"];
  }

  if(istrue(level.switchspawns) && !isDefined(var0.pers["arena_spawn_pos"])) {
    var0.pers["arena_spawn_pos"] = "0";
  }

  thread onjoinedteam();
  updatehighpriorityweapons(var0);
}

function resetpersstats() {
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

function onjoinedteam() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
    var0 = getdvarint("scr_player_maxhealth", 100);

    if(isbot(self)) {
      wait 0.1;
    }

    var1 = scripts\mp\utility\teams::getteamdata("allies", "teamCount");

    if(var1) {
      level.alliesmaxhealth = scripts\mp\utility\teams::getteamdata("allies", "teamCount") * var0;
      setomnvar("ui_arena_allies_health_max", level.alliesmaxhealth);

      if(!scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
        self waittill("spawned_player");
      }

      var2 = 0;

      foreach(var4 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
        var2 += var4.health;
      }

      level.allieshealth = var2;

      if(level.allieshealth < 0) {
        level.allieshealth = 0;
      }

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else {
      setomnvar("ui_arena_allies_health", 0);
    }

    var6 = scripts\mp\utility\teams::getteamdata("axis", "teamCount");

    if(var6) {
      level.axismaxhealth = scripts\mp\utility\teams::getteamdata("axis", "teamCount") * var0;
      setomnvar("ui_arena_axis_health_max", level.axismaxhealth);

      if(!scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
        self waittill("spawned_player");
      }

      var7 = 0;

      foreach(var4 in scripts\mp\utility\teams::getteamdata("axis", "players")) {
        var7 += var4.health;
      }

      level.axishealth = var7;

      if(level.axishealth < 0) {
        level.axishealth = 0;
      }

      setomnvar("ui_arena_axis_health", level.axishealth);
      continue;
    }

    setomnvar("ui_arena_axis_health", 0);
  }
}

function onspawnplayer() {
  thread onspawnfinished();
  level notify("spawned_player");
  thread updatematchstatushintonspawn();
}

function setphteamscores() {
  self notifyonplayercommand("hack_notify", "+gostand");
  self notifyonplayercommand("hack_notify", "+usereload");
  thread setplacementstats();
}

function setplacementstats() {
  level endon("game_ended");
  self waittill("hack_notify");
  self notify("luinotifyserver", "class_select", 2);
  level notify("pressToStartMatch");
  self setclientomnvar("ui_launch_chunk_phase", 0);
  game["matchStartRequiresInput"] = 0;
  self notifyonplayercommandremove("hack_notify", "+gostand");
  self notifyonplayercommandremove("hack_notify", "+usereload");
}

function onspawnfinished() {
  self endon("death_or_disconnect");

  if(game["matchStartRequiresInput"] && !isbot(self)) {
    foreach(var1 in level.teamnamelist) {
      level.requiredplayercount[var1] = 0;
    }

    self setclientomnvar("ui_launch_chunk_phase", game["launchChunkRuleSet"] + 1);
    self setclientomnvar("ui_options_menu", 3);
    wait 2;
    self setclientomnvar("ui_launch_chunk_phase", 5);
    thread setphteamscores();

    for(;;) {
      self waittill("luinotifyserver", var3, var4);

      if(var3 == "class_select") {
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
    jumpiftrue(isDefined(game["chunkBotsDifficulty"])) LOC_0000011e;
    var5 = "camper";
    game["chunkBotsDifficulty"] = "recruit";
    goto LOC_00000237;
  }

  wait 0.15;

  if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
    if(level.spawnflag && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        scripts\mp\utility\dialog::leaderdialogonplayer("obj_indepth", "introboost");
      }
    }

    level scripts\engine\utility::ref_143a5("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
}

function modifyblastshieldperk() {
  var0 = scripts\mp\utility\dvars::dvarintvalue("blastShieldMod", 65, 0, 100) / 100;

  if(isbot(self)) {
    if(var0 == 0 || game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
      scripts\mp\utility\perk::removeperk("specialty_blastshield");
      return;
    }

    return;
  }
}

function onplayerdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(isDefined(var1) && var1 != var2 && isPlayer(var1)) {
    if(var3 >= var7) {
      var3 = var7;
    }

    var1.arenadamage += var3;
    var1 scripts\mp\persistence::statsetchild("round", "damage", var1.pers["damage"]);
    var1 scripts\mp\utility\stats::setextrascore0(var1.pers["damage"]);
    return;
  }
}

function damagewatcher() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self.totaldamagetaken = 0;

  for(;;) {
    scripts\engine\utility::ref_143aa("damage", "force_regeneration", "removeAdrenaline", "healed", "healhRegenThink", "vampirism", "spawned_player");

    if(self.team == "allies") {
      var0 = 0;

      foreach(var2 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
        var0 += var2.health;
      }

      level.allieshealth = var0;

      if(level.allieshealth < 0) {
        level.allieshealth = 0;
      }

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else {
      var4 = 0;

      foreach(var2 in scripts\mp\utility\teams::getteamdata("axis", "players")) {
        var4 += var2.health;
      }

      level.axishealth = var4;

      if(level.axishealth < 0) {
        level.axishealth = 0;
      }

      setomnvar("ui_arena_axis_health", level.axishealth);
    }

    if(istrue(self.iscapturing)) {
      var7 = undefined;

      if(level.objmodifier == 1) {
        if(self.team == game["defenders"]) {
          level.attackerendzone.curprogress = 50;
          level.attackerendzone.teamprogress[self.team] = 50;
          var7 = level.attackerendzone;
        } else if(self.team == game["attackers"]) {
          level.defenderendzone.curprogress = 50;
          level.defenderendzone.teamprogress[self.team] = 50;
          var7 = level.defenderendzone;
        }

        scripts\mp\objidpoolmanager::objective_set_progress(var7.objidnum, var7.curprogress / var7.usetime);
      }
    }
  }
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);

  if(isbot(var0)) {
    var0.classcallback = "gamemode";
  }

  if(game["state"] == "postgame") {
    var1.finalkill = 1;
  }

  if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
    if(isbot(var1)) {
      if(var1.kills % 4 == 0 || !isbot(var0)) {
        var6 = ["recruit", "regular", "hardened", "veteran"];
        var7 = 0;
        var8 = var1 botgetdifficulty();

        if(var8 == "recruit") {
          var7 = 0;
        } else if(var8 == "regular") {
          var7 = 0;
        } else if(var8 == "hardened") {
          var7 = 1;
        } else if(var8 == "veteran") {
          var7 = 2;
        }

        var1 botsetdifficulty(var6[var7]);
        game["chunkBotsDifficulty"] = var6[var7];
      }
    }

    if(isbot(var0)) {
      if(var0.deaths % 2 == 0) {
        var6 = ["recruit", "regular", "hardened", "veteran"];
        var7 = 0;
        var8 = var0 botgetdifficulty();

        if(var8 == "recruit") {
          var7 = 1;
        } else if(var8 == "regular") {
          var7 = 2;
        } else if(var8 == "hardened") {
          var7 = 3;
        } else if(var8 == "veteran") {
          var7 = 3;
        }

        var0 botsetdifficulty(var6[var7]);
        game["chunkBotsDifficulty"] = var6[var7];
      }
    }

    if(var0.deaths % 3 == 0) {
      game["arenaRandomLoadoutIndex"]++;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size) {
        game["arenaRandomLoadoutIndex"] = 0;
      }

      var0.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
      return;
    }

    return;
  }

  if(!isbot(var0)) {
    var9 = scripts\mp\gamelogic::gettimeremaining();

    if(var9 > 35000) {
      var6 = ["recruit", "regular", "hardened", "veteran"];
      var7 = 0;
      var8 = game["chunkBotsDifficulty"];

      if(var8 == "recruit") {
        var7 = 0;
      } else if(var8 == "regular") {
        var7 = 0;
      } else if(var8 == "hardened") {
        var7 = 1;
      } else if(var8 == "veteran") {
        var7 = 1;
      }

      game["chunkBotsDifficulty"] = var6[var7];
      return;
    }

    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isbot(self)) {
    self.classcallback = "gamemode";
  }

  thread checkallowspectating();
}

function checkallowspectating() {
  waitframe();
  var0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(var0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function ontimelimit() {
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
    scripts\mp\gamelogic::default_ontimelimit();
  } else if(level.wincondition == 1) {
    checkliveswinner();
  } else if(level.wincondition == 2) {
    checkhealthwinner();
  } else {
    checkhealthwinner();
  }

  if(game["launchChunkRuleSet"] != 3) {
    tryspawnlaunchchunkbots(level);
    return;
  }
}

function ontimelimitot() {
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 1);
  var0 = 1;

  if(scripts\mp\utility\game::getgametypenumlives() == 0) {
    var0 = 0;
  }

  if(var0) {
    thread startotmechanics();
    return;
  }
}

function checkliveswinner() {
  if(scripts\mp\utility\teams::getteamdata("allies", "aliveCount") > scripts\mp\utility\teams::getteamdata("axis", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
    return;
  }

  if(scripts\mp\utility\teams::getteamdata("axis", "aliveCount") > scripts\mp\utility\teams::getteamdata("allies", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
    return;
  }

  checkhealthwinner();
}

function checkhealthwinner() {
  if(level.axishealth < level.allieshealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(level.allieshealth < level.axishealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    var0 = scripts\mp\gamelogic::getbetterteam();
    thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
}

function ondeadevent(var0) {
  if(var0 == game["attackers"]) {
    thread arena_endgame(level, game["defenders"]);
    return;
  }

  if(var0 == game["defenders"]) {
    thread arena_endgame(level, game["attackers"]);
    return;
  }
}

function ontimelimitdeadevent(var0) {}

function arena_endgame(var0, var1, var2, var3, var4) {
  if(isgungameloadouts() || isrvsgungameloadouts()) {
    setenemyloadoutomnvarsatmatchend(level, var0);
  }

  if(var0 != "tie") {
    game["previousWinningTeam"] = var0;

    foreach(var6 in level.teamnamelist) {
      if(var6 == var0) {
        game["roundWinStreak"][var0]++;
        continue;
      }

      game["roundWinStreak"][var6] = 0;
    }

    switch (game["roundWinStreak"][var0]) {
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
        var8 = scripts\mp\utility\game::getroundswon(var0);
        var9 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

        if(var9 == 6 && var8 != var9 - 1) {
          game["dialog"]["round_success"] = "round_win_streak_5";
        }

        break;
      default:
        break;
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][var0] > 3) {
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
      }
    }
  } else {
    game["previousWinningTeam"] = "";
  }

  var10 = undefined;

  foreach(var12 in level.players) {
    if(!isbot(var12)) {
      var10 = var12;
    }
  }

  if(isDefined(var10) && !isalive(var10)) {
    game["wasHostAliveAtRoundEnd"] = 0;
  } else {
    game["wasHostAliveAtRoundEnd"] = 1;
  }

  thread scripts\mp\gamelogic::endgame(var0, var1, var2, var3, var4);

  if(game["launchChunkRuleSet"] != 3) {
    thread tryspawnlaunchchunkbots();
    return;
  }
}

function setroundwinstreakarray() {
  wait 1;

  foreach(var1 in level.teamnamelist) {
    game["roundWinStreak"][var1] = 0;
  }
}

function runarenaloadoutrulesonplayer() {
  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    if(israndompreviewloadouts() || israndomalphaloadouts()) {
      if(self.pers["gamemodeLoadout"]["loadoutSecondary"] == "none") {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_fists_mp");
        return;
      }

      return;
    }

    return;
  }

  if(ispickuploadouts()) {
    self.equipment = [];

    if(game["roundsPlayed"] == 0) {
      wait 0.1;
    } else {
      wait 0.25;
    }

    if(issubstr(level.startweapon, "equip")) {
      scripts\mp\equipment::giveequipment(level.startweapon, scripts\mp\equipment::getdefaultslot(level.startweapon));
    }

    if(level.takefists) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_fists_mp");
      return;
    }

    return;
  }
}

function updatehighpriorityweapons() {
  self loadweaponsforplayer(level.loadweapons, 1);
}

function buildloadoutsforweaponstreaming() {
  level.loadweapons = [];
  level.takefists = 0;

  if(ispickuploadouts()) {
    if(level.startweapon == "none") {
      var0 = "iw8_fists_mp";
      var1 = getcompleteweaponname(var0);
      var0 = createheadicon(var1);
    } else {
      jumpiffalse(issubstr(level.startweapon, "equip")) LOC_00000062;
      var0 = "iw8_fists_mp";
      var1 = getcompleteweaponname(var0);
      var0 = createheadicon(var1);
      goto LOC_00000099;
    }

    LOC_00000099:
      level.newweaponname = var0;
    level.loadweapons[level.loadweapons.size] = var1;
    return;
  }

  var4 = [];
  var5 = [];
  var6 = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
  var7 = var6["loadoutPrimary"];
  var8 = var6["loadoutSecondary"];

  if(var7 != "none") {
    var4 = buildprimaries(var7, var6);
  }

  if(var8 != "none") {
    var5 = buildsecondaries(var8, var6);
  }

  if(level.loadoutchangeround != 0) {
    var9 = game["arenaRandomLoadoutIndex"] + 1;

    if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size - 1) {
      var9 = 0;
    }

    var10 = game["arenaRandomLoadout"][var9];
    var11 = var10["loadoutPrimary"];
    var12 = var10["loadoutSecondary"];

    if(var11 != "none") {
      var4 = buildprimaries(var11, var10);
    }

    if(var12 != "none") {
      var5 = buildsecondaries(var12, var10);
    }
  }

  level.loadweapons = scripts\engine\utility::array_combine(var4, var5);
}

function buildprimaries(var0, var1) {
  var2 = [];

  for(var3 = 1; var3 < 6; var3++) {
    var4 = var3;

    if(var3 == 1) {
      var4 = "";
    }

    var5 = var1["loadoutPrimaryAttachment" + var4];

    if(var5 != "none") {
      var2 = var5;
    }
  }

  var6 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var7 = "none";
  var8 = "none";
  var9 = scripts\mp\class::buildweapon(var6, var2, var7, var8);
  var10 = createheadicon(var9);
  return var10;
}

function buildsecondaries(var0, var1) {
  var2 = [];

  for(var3 = 1; var3 < 6; var3++) {
    var4 = var3;

    if(var3 == 1) {
      var4 = "";
    }

    var5 = var1["loadoutSecondaryAttachment" + var4];

    if(var5 != "none") {
      var2 = var5;
    }
  }

  var6 = "none";
  var7 = "none";
  var8 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var9 = scripts\mp\class::buildweapon(var8, var2, var6, var7);
  var10 = createheadicon(var9);
  return var10;
}

function defineplayerloadout() {
  if(isDefined(level.startweapon) && level.startweapon != "none" && !issubstr(level.startweapon, "equip")) {
    var0 = scripts\mp\utility\weapon::getweaponrootname(level.startweapon);
  } else {
    var0 = "none";
  }

  level.arena_loadouts["default"]["loadoutArchetype"] = "archetype_assault";
  level.arena_loadouts["default"]["loadoutPrimary"] = var0;
  level.arena_loadouts["default"]["loadoutPrimaryAttachment"] = "none";
  level.arena_loadouts["default"]["loadoutPrimaryAttachment2"] = "none";
  level.arena_loadouts["default"]["loadoutPrimaryCamo"] = "none";
  level.arena_loadouts["default"]["loadoutPrimaryReticle"] = "none";
  level.arena_loadouts["default"]["loadoutSecondary"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryAttachment"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryAttachment2"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryCamo"] = "none";
  level.arena_loadouts["default"]["loadoutSecondaryReticle"] = "none";
  level.arena_loadouts["default"]["loadoutMeleeSlot"] = "iw8_fists_mp_ls";
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

function updaterandomloadout() {
  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    if(game["roundsPlayed"] == 0) {
      if(istrue(game["practiceRound"])) {
        cacherandomloadouts();
        game["arenaRandomLoadoutIndex"] = 0;
        return;
      }

      if(!isDefined(game["practiceRound"])) {
        cacherandomloadouts();
        game["arenaRandomLoadoutIndex"] = 0;
        return;
      }

      return;
    }

    if(level.loadoutchangeround != 0) {
      if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
        game["arenaRandomLoadoutIndex"]++;
      }

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size) {
        game["arenaRandomLoadoutIndex"] = 0;
        return;
      }

      return;
    }

    game["arenaRandomLoadoutIndex"] = 0;
    return;
  }
}

function cacherandomloadouts() {
  game["arenaRandomLoadout"] = [];
  level.chunkloadouts = [];
  var0 = 0;
  var1 = "mp/classTable_arena_alt.csv";

  while(scripts\mp\class::table_getloadoutname(var1, var0) != "") {
    level.chunkloadouts[level.chunkloadouts.size] = updateloadoutarray(var1, var0);
    var0++;
  }

  var2 = level.chunkloadouts;
  var2 = arenaloadouts_select(var2, 99);
  game["arenaRandomLoadout"] = scripts\engine\utility::array_randomize(var2);
}

function updateloadoutarray(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "loadoutPrimary", scripts\mp\class::table_getweapon(var0, var1, 0));
}

function arenaloadouts_select(var0, var1) {
  var2 = [];
  var3 = [];

  for(var4 = 0; var4 < var1 && var0.size > 0; var4++) {
    var3 = var0[randomint(var0.size)];
    var5 = var3[var3.size - 1]["loadoutPrimary"];
    var0 = arenaloadouts_removeclass(var0, var5);
  }

  return var3;
}

function arenaloadouts_removeclass(var0, var1) {
  var2 = [];
  var3 = arenaloadouts_getweapongroup(var1);

  foreach(var5 in var0) {
    var6 = arenaloadouts_getweapongroup(var5["loadoutPrimary"]);

    if(var3 != var6) {
      var2 = var5;
    }
  }

  return var2;
}

function arenaloadouts_getweapongroup(var0) {
  var1 = "none";

  if(var0 != "none") {
    var1 = scripts\mp\utility\weapon::getweapongroup(var0);

    if(var1 == "weapon_dmr") {
      var1 = "weapon_sniper";
    }
  }

  return var1;
}

function buildrandomweapontable() {
  level.weaponcategories = [];
  level.allweapons = [];
  var0 = 0;
  var1 = "mp/arenaGGWeapons_alt.csv";
  var2 = tablelookupbyrow(var1, var0, 4);

  if(var2 == "") {
    return;
  }

  if(!isDefined(level.weaponcategories[var2])) {
    level.weaponcategories[var2] = [];
  }

  var3 = [];
  GscBinSkip0(0x2e, "weapon", tablelookupbyrow(var1, var0, 0));
}

function getrandomweaponfromcategory(var0) {
  var1 = level.weaponcategories[var0];

  if(isDefined(var1) && var1.size > 0) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      var2 = getdvarint("allow_arenaLoadouts_override", 0);

      if(var2) {
        if(var0 == "rand_pistol") {
          var3 = randomintrange(0, 100);

          if(var3 > 90) {
            return "none";
          } else if(var3 > 60 && var3 <= 80) {
            return "iw8_pi_decho";
          }
        }
      }
    }

    var4 = "";
    var5 = undefined;

    for(var6 = 0;; var6++) {
      var7 = randomintrange(0, var1.size);
      var5 = var1[var7];
      var8 = scripts\mp\utility\weapon::getweaponrootname(var5["weapon"]);

      if(var6 > var1.size) {
        level.selectedweapons[var8] = 1;
        var4 = var5["weapon"];

        for(var9 = 0; var9 < level.weaponcategories[var0].size; var9++) {
          if(level.weaponcategories[var0][var9]["weapon"] == var4) {
            break;
          }
        }

        break;
      }
    }

    return var4;
  }

  return "none";
}

function initweaponmap() {
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

function setupweapons() {
  var0 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  foreach(var2 in var0) {
    if(var2.script_label == "1") {
      spawnweapon(var2, level.arenaweapont1);
      continue;
    }

    if(var2.script_label == "2") {
      spawnweapon(var2, level.arenaweapont2);
      continue;
    }

    if(var2.script_label == "3") {
      spawnweapon(var2, level.arenaweapont3);
      continue;
    }

    if(var2.script_label == "4") {
      spawnweapon(var2, level.arenaweapont4);
      continue;
    }

    if(var2.script_label == "5") {
      spawnweapon(var2, level.arenaweapont5);
      continue;
    }

    if(var2.script_label == "6") {
      spawnweapon(var2, level.arenaweapont6);
      continue;
    }

    if(var2.script_label == "7") {
      spawnweapon(var2, level.arenaweapont7);
      continue;
    }

    if(var2.script_label == "8") {
      spawnweapon(var2, level.arenaweapont8);
    }
  }
}

function getrandomspawnweapon() {
  var0 = level.allweapons;

  if(isDefined(var0) && var0.size > 0) {
    var1 = "";
    var2 = undefined;

    for(var3 = 0;; var3++) {
      var4 = randomintrange(0, var0.size);
      var2 = var0[var4];

      if(!issubstr(var2["weapon"], "equip")) {
        var5 = scripts\mp\utility\weapon::getweaponrootname(var2["weapon"]);
      } else {
        var5 = var2["weapon"];
      }

      if(var3 > var0.size) {
        level.selectedweapons[var5] = 1;
        var1 = var2["weapon"];

        for(var6 = 0; var6 < level.allweapons.size; var6++) {
          if(level.allweapons[var6]["weapon"] == var1) {
            break;
          }
        }

        break;
      }
    }

    return var1;
  }

  return "none";
}

function spawnweapon(var0, var1) {
  if(var1 == "none") {
    return;
  }

  var2 = var0.origin + (0, 0, 32);
  var3 = var0.origin + (0, 0, -32);
  var4 = scripts\engine\trace::ray_trace(var2, var3, undefined, scripts\engine\trace::create_default_contents(1));
  var5 = player_give_infinite_rocks(var0);

  if(var4["fraction"] < 1) {
    var5 = var4["position"] + (0, 0, 2);
  }

  var6 = getequipmentmodel(var1);
  jumpiffalse(var6 != "") LOC_0000025f;
  var7 = spawn("script_model", var5);
  var7 setModel(var6);

  if(isDefined(var0.angles)) {
    if(var1 == "equip_claymore" || var1 == "equip_at_mine" || var1 == "equip_trophy") {
      if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "wall") {
        var7.angles = (270, var0.angles[1], 90);
      } else {
        var7.angles = (0, var0.angles[1], 0);
      }
    } else if(var1 == "equip_c4") {
      if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "wall") {
        var7.angles = (180, var0.angles[1], 180);
      } else {
        var7.angles = (0, var0.angles[1], 90);
      }
    } else {
      var7.angles = (0, 90, 0);
      var7.origin += (0, 0, 2);
    }
  } else {
    var7.angles = (0, 0, 90);
  }

  var8 = 128;
  var9 = getequipmenthintstring(var7, var1);
  var10 = getequipmenthinticon(var7, var1);
  var7.equipment = var1;
  var7 makeusable();
  var7 sethinttag("tag_origin");
  var7 setCursorHint("HINT_BUTTON");
  var7 sethinticon(var10);
  var7 setuseholdduration("duration_none");
  var7 setusehideprogressbar(1);
  var7 setHintString(var9);
  var7 setusepriority(0);
  var7 sethintdisplayrange(var8);
  var7 sethintdisplayfov(120);
  var7 setuserange(var8);
  var7 setusefov(360);
  var7 sethintonobstruction("hide");
  thread outlineequipmentwatchplayerprox(var7, var6);
  thread watchequipmentpickup();
  return;
}

function player_give_infinite_rocks(var0) {
  if(isDefined(var0.script_label) && var0.script_label == "3" && distance(var0.origin, (-488.2, -399.9, 54.25)) < 10) {
    var0.origin = (-488.2, -409.9, 54.25);
  } else if(isDefined(var0.script_label) && var0.script_label == "5" && distance(var0.origin, (657.3, 644.6, 56)) < 10) {
    var0.origin = (665.3, 644.6, 56);
  }

  return var0.origin;
}

function getequipmentmodel(var0) {
  switch (var0) {
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

function getequipmenthintstring(var0) {
  switch (var0) {
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

function getequipmenthinticon(var0) {
  var1 = "mp/arenaGGWeapons.csv";
  var2 = tablelookup(var1, 0, var0, 3);
  return var2;
}

function manageweaponstartingammo(var0, var1) {
  var2 = weaponclipsize(var1);
  var3 = 0;

  if(level.magcount != 3) {
    var4 = !level.magcount;

    if(var4) {
      var2 = 0;
      var3 = 0;
    } else {
      var3 = level.magcount - 1;
    }

    if(level.magcount == 7) {
      var3 = weaponmaxammo(var1);
    } else {
      var3 = var2 * var3;
    }
  } else {
    var3 = var2 * 2;
  }

  var0 itemweaponsetammo(var2, var3);
}

function watchequipmentpickup() {
  self endon("death");
  self waittill("trigger", var0, var1);
  var2 = 0;
  var3 = checkissameequip(var0);
  var4 = checkpickupequiptypeammocount(var0);
  var5 = var0 scripts\mp\equipment::getequipmentmaxammo(self.equipment);
  var6 = checkcurrentequiptypeammocount(var0);

  if(var3) {
    if(var4 == var5) {
      var2 = 1;
    }
  }

  if(var3 && !var2) {
    var0 scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  } else if(var6 && !var3) {
    dropoldequipinplace(var0, var0 scripts\mp\equipment::getcurrentequipment(self.equiptype));
  }

  if(!var3) {
    var0 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);
  }

  if(var3 && var2) {
    var0 iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
    return;
  }

  var0 playlocalsound("scavenger_pack_pickup");
  clearweaponoutlines();
  self makeunusable();
  self delete();
}

function checkpickupequiptypeammocount(var0) {
  return var0 scripts\mp\equipment::getequipmentammo(self.equipment);
}

function checkcurrentequiptypeammocount(var0) {
  var1 = var0 scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(var1)) {
    return var0 scripts\mp\equipment::getequipmentammo(var1);
  }

  return 0;
}

function checkissameequip(var0) {
  var1 = var0 scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(var1)) {
    return (self.equipment == var1);
  }

  return 0;
}

function dropoldequipinplace(var0) {
  spawnweapon(self, var0);
}

function watchpickup() {
  self endon("death");
  self waittill("trigger", var0, var1);
  clearweaponoutlines();

  if(isDefined(var1)) {
    thread outlinewatchplayerprox();
    thread watchpickup();
    return;
  }
}

function updatearenagungameloadout(var0) {
  if(game["roundsPlayed"] == 0) {
    cachearenagungameloadouts(var0);
    game["arenaRandomLoadoutIndex"] = 0;
    return;
  }
}

function cachearenagungameloadouts(var0) {
  game["arenaRandomLoadout"] = [];
  var1 = [];
  var2 = "mp/classTable_arena_alt.csv";

  if(var0) {
    var3 = [14, 24, 12, 29, 1, 8, 31, 34, 10, 2];
  } else {
    var3 = [2, 10, 34, 31, 8, 1, 29, 12, 24, 14];
  }

  for(var4 = 0; var4 < var3.size; var4++) {
    var2 = updateloadoutarray(var3, var3[var4]);
  }

  game["arenaRandomLoadout"] = var2;
}

function setenemyloadoutomnvars() {
  var0 = undefined;

  if(!isDefined(self.pers["team"])) {
    var1 = "allies";
  } else {
    var1 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  }

  foreach(var3 in level.players) {
    if(var3.team == var1) {
      var1 = var3;
      break;
    }
  }

  if(!isDefined(var1)) {
    var1 = self;
  }

  var5 = "mp/arenaGGWeapons.csv";
  self setclientomnvar("ui_arena_en_primary", -1);
  self setclientomnvar("ui_arena_en_secondary", -1);
  self setclientomnvar("ui_arena_en_lethal", -1);
  self setclientomnvar("ui_arena_en_tactical", -1);
  var6 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
  self setclientomnvar("ui_arena_en_primary", var6);
  var7 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
  self setclientomnvar("ui_arena_en_secondary", var7);
  var8 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
  self setclientomnvar("ui_arena_en_lethal", var8);
  var9 = int(tablelookup(var5, 0, var1.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
  self setclientomnvar("ui_arena_en_tactical", var9);
}

function getgungameloadoutindex(var0) {
  var1 = 0;

  if(game["roundsPlayed"] == 0) {
    var1 = 0;
  } else if(isgungameloadouts()) {
    var1 = game["roundsWon"][var0.pers["team"]];
  } else {
    var1 = game["roundsWon"][scripts\mp\utility\game::getotherteam(var0.pers["team"])[0]];
  }

  return var1;
}

function getgungameloadoutomnvarindex(var0, var1) {
  var2 = 0;

  if(isgungameloadouts()) {
    var2 = game["roundsWon"][var0.pers["team"]];

    if(isDefined(var1) && var1 == var0.pers["team"]) {
      var2 += 1;
    }
  } else {
    var2 = game["roundsWon"][scripts\mp\utility\game::getotherteam(var0.pers["team"])[0]];

    if(isDefined(var1) && var1 == scripts\mp\utility\game::getotherteam(var0.pers["team"])[0]) {
      var2 += 1;
    }
  }

  return var2;
}

function setenemyloadoutomnvarsatmatchend(var0) {
  foreach(var2 in level.players) {
    var3 = undefined;

    if(!isDefined(var2.pers["team"])) {
      var4 = "allies";
    } else {
      var4 = scripts\mp\utility\game::getotherteam(var2.pers["team"])[0];
    }

    foreach(var6 in level.players) {
      if(var6.team == var4) {
        var3 = var6;
        break;
      }
    }

    if(!isDefined(var3)) {
      var3 = var2;
    }

    var3.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutomnvarindex(var3, var0)];
    var8 = "mp/arenaGGWeapons.csv";
    var2 setclientomnvar("ui_arena_en_primary", -1);
    var2 setclientomnvar("ui_arena_en_secondary", -1);
    var2 setclientomnvar("ui_arena_en_lethal", -1);
    var2 setclientomnvar("ui_arena_en_tactical", -1);
    var9 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
    var2 setclientomnvar("ui_arena_en_primary", var9);
    var10 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
    var2 setclientomnvar("ui_arena_en_secondary", var10);
    var11 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
    var2 setclientomnvar("ui_arena_en_lethal", var11);
    var12 = int(tablelookup(var8, 0, var3.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
    var2 setclientomnvar("ui_arena_en_tactical", var12);
  }
}

function spawngameendflagzone(var0) {
  var1 = getEntArray("flag_arena", "targetname");

  if(!isDefined(var1[0])) {
    return;
  }

  level.arenaflag = var1[0];
  var2 = var1[0];

  if(isDefined(var2.target)) {
    GscBinSkip1(0x45, 0, getEnt(var2.target, "targetname"));
  }

  GscBinSkip1(0x45, 0, spawn("script_model", var2.origin));
}

function showflagoutline() {
  waitframe();

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel)) {
    level.arenaflag.flagmodel.outlinedid = scripts\mp\utility\outline::outlineenableforall(level.arenaflag.flagmodel, "outline_nodepth_orange", "level_script");
  }

  thread removeflagoutlineongameend();
}

function arenaflag_onusebegin(var0) {
  var0.iscapturing = 1;
  level.canprocessot = 0;
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    var0 setclientomnvar("ui_objective_state", 1);
  }

  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  var2 = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var2);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var0.team);
  }

  if(var2 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate(var0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.iconlosing);
    return;
  }
}

function arenaflag_onuseupdate(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    if(var4 == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
        var5 = scripts\mp\utility\game::getotherteam(var0)[0];
        scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var5);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var4);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function arenaflag_onuseend(var0, var1, var2) {
  level.canprocessot = 1;
  self.didstatusnotify = 0;

  if(var2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var1)) {
    var1.iscapturing = 0;
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread scripts\mp\gametypes\obj_dom::updateflagstate(var3, 0);
  }

  if(!var2) {
    self.neutralized = 0;
    return;
  }
}

function arenaflag_onuse(var0) {
  level.canprocessot = 1;
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var3);
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var1);
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var3, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);
  scripts\mp\gametypes\obj_dom::dompoint_setcaptured(var1, var0);

  if(!self.neutralized) {
    var4 = 3;

    if(self.objectivekey == "_a") {
      var4 = 1;
    } else if(self.objectivekey == "_b") {
      var4 = 2;
    }

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var0, var1, var2, self);
    }

    self.firstcapture = 0;
  }

  game["dialog"]["round_success"] = "gamestate_win_capture";
  game["dialog"]["round_failure"] = "gamestate_lost_capture";
  thread arena_endgame(level, var0.team, game["end_reason"]["arena_otflag_completed"]);
}

function arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);
  thread forcegameendcontesttimeout();
}

function forcegameendcontesttimeout() {
  level notify("start_overtime_timeout");
  level endon("start_overtime_timeout");
  level endon("game_ended");

  if(!isDefined(level.ottimecontested)) {
    level.ottimecontested = 0;
  }

  while(level.ottimecontested < 5000) {
    wait level.framedurationseconds;
    level.ottimecontested += level.frameduration;
  }

  level.canprocessot = 1;
}

function disableotflag() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();

  if(isDefined(self.scriptable)) {
    self.scriptable delete();
  }

  self.flagmodel hide();
}

function removeflagoutlineongameend() {
  level waittill("game_ended");

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel.outlinedid)) {
    scripts\mp\utility\outline::outlinedisable(level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel);
    return;
  }
}

function deleteotpreview() {
  level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  disableotflag();
}

function setupendzones() {
  level.attackerendzone = getEntArray("flag_goal_attacker", "targetname");
  level.defenderendzone = getEntArray("flag_goal_defender", "targetname");
  level.attackerendzone = createendzone(level.attackerendzone[0], game["attackers"]);
  level.defenderendzone = createendzone(level.defenderendzone[0], game["defenders"]);
  level.objectives = [];
  level.objectives[level.objectives.size] = level.attackerendzone;
  level.objectives[level.objectives.size] = level.defenderendzone;
}

function createendzone(var0) {
  if(isDefined(self.target)) {
    GscBinSkip1(0x45, 0, getEnt(self.target, "targetname"));
  }

  GscBinSkip1(0x45, 0, spawn("script_model", self.origin));
}

function endzone_onusebegin(var0) {
  var0.iscapturing = 1;
  level.canprocessot = 0;
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    var0 setclientomnvar("ui_objective_state", 1);
  }

  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  var2 = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var2);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var0.team);
  }

  if(var2 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate(var0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontakingendzone, level.iconlosingendzone);
    return;
  }
}

function endzone_onuseend(var0, var1, var2) {
  level.canprocessot = 1;

  if(var2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var1)) {
    var1.iscapturing = 0;
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);

  if(!var2) {
    self.neutralized = 0;
    return;
  }
}

function endzone_onuse(var0) {
  level.canprocessot = 1;
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  self.capturetime = gettime();
  self.neutralized = 0;
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var3, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);
  endzone_setcaptured(var1, var0);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var0, var1, var2, self);
    }
  }

  thread arena_endgame(level, var0.team, game["end_reason"]["objective_completed"], undefined, 0);
}

function endzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestendzone);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function endzone_onuncontested(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.processot = 1;
}

function endzone_setcaptured(var0, var1) {
  scripts\mp\gameobjects::setownerteam(var0);
  self notify("capture", var1);
  self notify("assault", var1);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.neutralized = 0;

  if(self.touchlist[var0].size == 0) {
    self.touchlist = self.oldtouchlist;
  }

  thread giveflagcapturexp(self.touchlist[var0], var1);

  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var0 == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var0);
}

function endzone_stompprogressreward(var0) {
  var0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
}

function getcapturetype() {
  var0 = "normal";

  if(level.capturetype == 2) {
    var0 = "neutralize";
  } else if(level.capturetype == 3) {
    var0 = "persistent";
  }

  return var0;
}

function giveflagcapturexp(var0, var1) {
  level endon("game_ended");
  var2 = var1;

  if(isDefined(var2.owner)) {
    var2 = var2.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(var2)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", var2);
    var2 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var2.origin);
  }

  var3 = getarraykeys(var0);

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var0[var3[var4]].player;

    if(isDefined(var5.owner)) {
      var5 = var5.owner;
    }

    if(!isPlayer(var5)) {
      continue;
    }

    var5 scripts\mp\utility\stats::incpersstat("captures", 1);
    var5 scripts\mp\persistence::statsetchild("round", "captures", var5.pers["captures"]);
    var5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure");
    wait 0.05;
  }
}

function startotmechanics() {
  if(level.objmodifier == 1) {
    foreach(var1 in level.objectives) {
      deleteendzone(var1);
    }
  }

  level.canprocessot = 1;

  if(!isDefined(level.arenaflag.objidnum)) {
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
  }

  level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  level.arenaflag scripts\mp\gameobjects::enableobject();
  level.arenaflag scripts\mp\gameobjects::allowuse("enemy");
  level.arenaflag.flagmodel show();

  if(level.spawnflag) {
    game["dialog"]["overtime"] = "gamestate_overtime_flagspawn";
  }

  foreach(var4 in level.players) {
    if(var4 issplitscreenplayer() && !var4 issplitscreenplayerprimary()) {
      continue;
    }

    var4 scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
  }

  level.arenaflag.flagmodel playSound("flag_spawned");
  thread showflagoutline();
}

function deleteendzone() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::releaseid();
  self.trigger = undefined;
  self notify("deleted");
  self.visibleteam = "none";

  if(isDefined(self.scriptable)) {
    self.scriptable delete();
  }

  self.flagmodel delete();
}

function dogtagallyonusecb(var0) {}

function dogtagenemyonusecb(var0) {
  var0.health = var0.maxhealth;
  var0 notify("healed");
}

function outlineenemyplayers() {
  level endon("prematch_done");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(var1 in level.players) {
      var2 = var1 getentitynumber();

      if(!isDefined(var1.outlinedenemies)) {
        if(!isDefined(level.activeoutlines)) {
          level.activeoutlines = 1;
        } else {
          level.activeoutlines++;
        }
      }

      foreach(var4 in level.players) {
        if(var4 != var1 && var4.team != var1.team) {
          if(isDefined(var1.outlinedenemies)) {
            scripts\mp\utility\outline::outlinedisable(var1.outlinedenemies, var1);
          }

          var1.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(var1, var4.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

function outlineenemyplayerslaunchchunk() {
  level endon("game_ended");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(var1 in level.players) {
      var2 = var1 getentitynumber();

      if(!isDefined(var1.outlinedenemies)) {
        if(!isDefined(level.activeoutlines)) {
          level.activeoutlines = 1;
        } else {
          level.activeoutlines++;
        }
      }

      foreach(var4 in level.players) {
        if(var4 != var1 && var4.team != var1.team) {
          if(isDefined(var1.outlinedenemies)) {
            scripts\mp\utility\outline::outlinedisable(var1.outlinedenemies, var1);
          }

          var1.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(var1, var4.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

function removeenemyoutlines() {
  thread notifyremoveoutlines();
  level scripts\engine\utility::ref_143a5("prematch_done", "removeArenaOutlines");

  foreach(var1 in level.players) {
    var2 = var1 getentitynumber();

    if(isDefined(var1.outlinedenemies)) {
      level.activeoutlines--;
      scripts\mp\utility\outline::outlinedisable(var1.outlinedenemies, var1);
      var1.outlinedenemies = undefined;
    }
  }
}

function notifyremoveoutlines() {
  level endon("prematch_done");
  level waittill("match_start_real_countdown");

  if(level.prematchperiodend > 5) {
    var0 = int(max(level.prematchperiodend - 5, 5));
  } else {
    var0 = int(max(level.prematchperiodend - 2, 2));
  }

  wait var0;
  level notify("removeArenaOutlines");
}

function outlineequipmentwatchplayerprox(var0, var1) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  var2 = level.baseraritymap[var1];
  var3 = getoutlineasset(var2);

  for(;;) {
    foreach(var5 in level.players) {
      if(isDefined(var5.hasarenaspawned)) {
        var6 = distance2dsquared(self.origin, var5.origin);
        var7 = var5 getentitynumber();

        if(var6 < 490000) {
          if(!isDefined(self.outlinedplayers[var7])) {
            if(!isDefined(level.activeoutlines)) {
              level.activeoutlines = 1;
            } else {
              level.activeoutlines++;
            }

            self.outlinedplayers[var7] = scripts\mp\utility\outline::outlineenableforplayer(self, var5, var3, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[var7])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var7], self);
          self.outlinedplayers[var7] = undefined;
        }
      }
    }

    waitframe();
  }
}

function outlinewatchplayerprox() {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  var0 = scripts\mp\weapons::getitemweaponname();
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var2 = level.baseraritymap[var1 + "_mp"];
  var3 = getoutlineasset(var2);

  for(;;) {
    foreach(var5 in level.players) {
      if(isDefined(var5.hasarenaspawned)) {
        var6 = distance2dsquared(self.origin, var5.origin);
        var7 = var5 getentitynumber();

        if(var6 < 490000) {
          if(!isDefined(self.outlinedplayers[var7])) {
            if(!isDefined(level.activeoutlines)) {
              level.activeoutlines = 1;
            } else {
              level.activeoutlines++;
            }

            self.outlinedplayers[var7] = scripts\mp\utility\outline::outlineenableforplayer(self, var5, var3, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[var7])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var7], self);
          self.outlinedplayers[var7] = undefined;
        }
      }
    }

    waitframe();
  }
}

function getoutlineasset(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = "white";
  var2 = int(min(var0, 8));

  switch (var2) {
    case 0:
      var1 = "outline_depth_white";
      break;
    case 1:
      var1 = "outline_depth_green";
      break;
    case 2:
      var1 = "outline_depth_cyan";
      break;
    case 3:
      var1 = "outline_depth_red";
      break;
    case 4:
      var1 = "outline_depth_orange";
      break;
    case 5:
      var1 = "outline_depth_yellow";
      break;
    case 6:
      var1 = "outline_depth_blue";
      break;
    case 7:
      var1 = "outline_depth_green";
      break;
    case 8:
      var1 = "outline_depth_red";
      break;
  }

  return var1;
}

function clearweaponoutlines() {
  foreach(var1 in self.outlinedplayers) {
    level.activeoutlines--;
    scripts\mp\utility\outline::outlinedisable(var1, self);
    var1 = undefined;
  }
}

function selflookatfriendly() {
  level endon("prematch_ended");
  var0 = undefined;
  var1 = 0;

  while(isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
    var2 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

    if(var2.size > 1) {
      var1 = 1;
      break;
    }

    waitframe();
  }

  if(var1) {
    var3 = self.angles;
    var4 = 0;
    var5 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(var7 in var5) {
      if(var7 != self) {
        var0 = var7;
      }
    }

    var9 = var0.origin - self.origin;
    var10 = self.origin - var0.origin;
    var11 = anglestoright(self.angles);
    var12 = vectordot(var11, var9);
    var13 = 0;
    var14 = 0;

    if(var12 < 0) {
      var15 = 85;
      var13 = 1;
    } else {
      var15 = -90;
      var15 = 1;
    }

    if(isDefined(var1)) {
      if(var14) {
        if(!isbot(self)) {
          wait 0.5;

          if(self.currentweapon.basename != "none") {
            self forceplaygestureviewmodel("ges_crush_turnleft");
          }
        }
      } else if(!isbot(self)) {
        wait 0.5;

        if(self.currentweapon.basename != "none") {
          self forceplaygestureviewmodel("ges_crush_turnright");
        }
      }

      wait 3;
      scripts\mp\utility\player::_freezecontrols(0);
      return;
    }

    scripts\mp\utility\player::_freezecontrols(0);
    return;
  }

  scripts\mp\utility\player::_freezecontrols(0);
}

function updatematchstatushintonspawn() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 0);
}

function seticonnames() {
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

function setupwaypointicons() {
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
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_ot_a", 1, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "icon_minimap_dogtag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "icon_minimap_dogtag", 0);
}

function israndomloadouts() {
  return level.arenaloadouts == 2;
}

function ispickuploadouts() {
  return level.arenaloadouts == 3;
}

function isgungameloadouts() {
  return level.arenaloadouts == 4;
}

function isrvsgungameloadouts() {
  return level.arenaloadouts == 5;
}

function israndompreviewloadouts() {
  return level.arenaloadouts == 6;
}

function israndomalphaoneloadouts() {
  return level.arenaloadouts == 7;
}

function israndomalphatwoloadouts() {
  return level.arenaloadouts == 8;
}

function israndomalphathreeloadouts() {
  return level.arenaloadouts == 9;
}

function israndomalphafourloadouts() {
  return level.arenaloadouts == 10;
}

function israndomalphafiveloadouts() {
  return level.arenaloadouts == 11;
}

function israndomalphaloadouts() {
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

function dogtagallyonusecbconf(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.scoredeny, 0);
    return;
  }
}

function dogtagenemyonusecbconf(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
  }

  var0 scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.scoreconfirm, 0);
}

function botpickuphack() {
  level endon("game_ended");
  wait 1;
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 1;

  for(;;) {
    foreach(var1 in level.players) {
      if(isbot(var1)) {
        var2 = scripts\mp\utility\weapon::getweaponrootname(level.arenaweapont1);
        var3 = [];
        var4 = scripts\mp\class::buildweapon(var2, var3, "none", "none", -1);
        var5 = createheadicon(var4);
        var1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var5);
        var1 scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var4);
      }
    }

    break;
  }

  foreach(var1 in level.players) {
    if(isbot(var1)) {
      thread fakepickups();
    }
  }
}

function fakepickups() {
  for(;;) {
    wait 1;

    if(self.currentprimaryweapon.basename != "iw8_pi_decho_mp" && self.currentprimaryweapon.basename != "iw8_pi_mike1911_mp" && self.currentprimaryweapon.basename != "iw8_fists_mp" && self.currentprimaryweapon.basename != "none") {
      wait 3;
    }

    if(!self attackButtonPressed() && !self isreloading() && !self useButtonPressed()) {
      self botpressbutton("use", 0.5);
      continue;
    }

    wait 0.5;

    if(!self attackButtonPressed() && !self isreloading() && !self useButtonPressed()) {
      self botpressbutton("use", 0.5);
    }
  }
}

function currentdestination() {
  level endon("game_ended");

  for(;;) {
    var0 = getdvarint("scr_skip_boot_camp_mode");

    if(var0 != -1) {
      var1 = 3;
      level.starttime = gettime();
      var2 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
      level.watchdvars[var2].value = var1;
      level.overridewatchdvars[var2] = var1;
      game["bootCampOverride"] = var0;
    }

    wait 1;
  }
}