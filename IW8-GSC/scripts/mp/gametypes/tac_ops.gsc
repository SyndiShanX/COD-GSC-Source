/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tac_ops.gsc
***********************************************/

function main() {
  if(!isDefined(level.tacopssublevel)) {
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    level.tacopssublevel = "tac_ops";
    level.currentmode = "tac_ops";
    level.onphaseend = &onphaseend;
    level.tacopscurrentstate = "START";
  }

  level.tacopsroundresults = [];
  level.spottedindex = 0;
  level.axisadjuststarttime = 5;

  if(isusingmatchrulesdata()) {
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("tac_ops", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("tac_ops", 3);
    scripts\mp\utility\game::registerscorelimitdvar("tac_ops", 0);
    scripts\mp\utility\game::registerroundlimitdvar("tac_ops", 1);
    scripts\mp\utility\game::registerwinlimitdvar("tac_ops", 1);
    scripts\mp\utility\game::registernumlivesdvar("tac_ops", 0);
    scripts\mp\utility\game::registerhalftimedvar("tac_ops", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("tac_ops", 0);
    scripts\mp\utility\game::setovertimelimitdvar(2);
  }

  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.modeonspawnplayer = &onspawnplayer;
}

function commoninit() {
  scripts\mp\tac_ops\radio_utility::initialize_radio();
  onbeginnewmode();
  thread timelimitthread();
  level.allowkillstreaks = 0;
  level.istacops = 1;
  scripts\mp\tac_ops\roles_utility::initroles();
  scripts\mp\tac_ops_map::init();
  initspawns();
}

function onphaseend(var_0) {
  var_1 = 1;

  if(isDefined(var_0)) {
    level.lastwinner = var_0;
  }

  if(isDefined(level.lastwinner)) {
    var_1 = level.lastwinner == "allies";
  }

  level.modeonspawnplayer = &onspawnplayer;
  level.tacopssubmodetimeron = 0;
  setgameendtime(0);
  level.starttime = gettime();
  level.tacopssublevel = "tac_ops";
  level.currentmode = "tac_ops";
  level.tacopscurrentstate = statecontroller(level.tacopscurrentstate, var_1);
  thread runnextmode();
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function playsoundforteam(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  foreach(var_5 in var_3) {
    if(!isbot(var_5)) {
      var_5 playlocalsound(var_0, var_2);
    }
  }
}

function teamprint(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
    thread tutorialprint(var_3, var_0);
  }

  foreach(var_3 in scripts\mp\utility\teams::getteamdata("axis", "players")) {
    thread tutorialprint(var_3, var_1);
  }
}

function tutorialprint(var_0, var_1) {
  self sethudtutorialmessage(var_0);
  wait var_1;
  self clearhudtutorialmessage();
}

function spawnsandboxa() {
  var_0 = level.sandboxobjectivesa[0][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(5, var_0, "allies", 1);
  var_0 = level.sandboxobjectivesa[1][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(1, var_0, "allies", 1);
  var_0 = level.sandboxobjectivesa[2][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(3, var_0, "allies", 1);
  var_0 = level.sandboxobjectivesa[3][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(6, var_0, "allies", 1);
  var_0 = level.sandboxobjectivesa[4][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(2, var_0, "allies", 1);
  var_0 = level.sandboxobjectivesa[5][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(4, var_0, "allies", 1);
  var_0 = level.sandboxobjectivesa[6][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(1, var_0, "axis", 1);
  var_0 = level.sandboxobjectivesa[7][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(5, var_0, "axis", 1);
  var_0 = level.sandboxobjectivesa[8][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(10, var_0, "axis", 1);
  var_0 = level.sandboxobjectivesa[9][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(9, var_0, "axis", 1);
  var_0 = level.sandboxobjectivesa[10][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(6, var_0, "axis", 1);
  var_0 = level.sandboxobjectivesa[11][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(7, var_0, "axis", 1);
}

function runnextmode() {
  onbeginnewmode();

  switch (level.tacopscurrentstate) {
    case "START":
      wait 5;
      break;
    case "ROUND_1":
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_infila2", "allies");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase1_infilb", "axis");
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_chem_phase1_safehouse", "axis");
      scripts\mp\gametypes\to_dd::maintacops();
      break;
    case "TRANSFER_1_2A":
      level notify("dd_phase_ended");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_chem_phase1_hvtgrab", "allies");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_wina", "allies");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase1_losingb", "axis");
      spawnsandboxa();
      level.tacopscurrentstate = statecontroller(level.tacopscurrentstate, 1);
      thread runnextmode();
      break;
    case "TRANSFER_1_2B":
      level notify("dd_phase_ended");
      spawnsandboxa();
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_DD_END_1B", &"MISC_MESSAGES_MP/TO_AXIS_DD_END_1B");
      wait 6;
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_DD_END_1C", &"MISC_MESSAGES_MP/TO_AXIS_DD_END_1C");
      wait 6;
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_PRE_1B");
      wait 6;
      level.tacopscurrentstate = statecontroller(level.tacopscurrentstate, 0);
      thread runnextmode();
      break;
    case "ROUND_2B":
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_AIR_START_1", &"MISC_MESSAGES_MP/TO_AXIS_AIR_START_1");
      break;
    case "ROUND_2A":
      level scripts\mp\gametypes\to_hstg::maintacops();
      level scripts\mp\gametypes\to_hstg::activatespawns();
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_ovl_phase1_wina", "allies");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase2_introb", "axis");
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_ovl_phase2_introa1", "allies");
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase2_introa2", "allies");
      break;
    case "TRANSFER_2A_3AA":
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase2_lossb", "axis");
      level notify("hostage_phase_ended");
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2A", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2A");
      wait 6;
      thread scripts\mp\gamelogic::endgame("none", 0);
      return;
    case "TRANSFER_2A_3AB":
      level notify("hostage_phase_ended");
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2B", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2B");
      wait 6;
      thread scripts\mp\gamelogic::endgame("none", 0);
      return;
    case "TRANSFER_2B_3BA":
      level notify("hostage_phase_ended");
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2A", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2A");
      wait 6;
      thread scripts\mp\gamelogic::endgame("none", 0);
      return;
    case "TRANSFER_2B_3BB":
      level notify("hostage_phase_ended");
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_END_2B", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_END_2B");
      wait 6;
      thread scripts\mp\gamelogic::endgame("none", 0);
      return;
    case "ROUND_3AA":
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_WMD_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_WMD_PRE_1");
      wait 6;
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_WMD_START_1", &"MISC_MESSAGES_MP/TO_AXIS_WMD_START_1");
      level scripts\mp\gametypes\to_wmd::maintacops();
      level scripts\mp\gametypes\to_wmd::activatespawns();
      break;
    case "ROUND_3AB":
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_BHD_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_BHD_PRE_1");
      wait 6;
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_BHD_START_1", &"MISC_MESSAGES_MP/TO_AXIS_BHD_START_1");
      level scripts\mp\gametypes\to_bhd::maintacops();
      level scripts\mp\gametypes\to_bhd::activatespawns();
      break;
    case "ROUND_3BA":
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_SAM_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_SAM_PRE_1");
      wait 6;
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_SAM_START_1", &"MISC_MESSAGES_MP/TO_AXIS_SAM_START_1");
      level scripts\mp\gametypes\to_sam::maintacops();
      level scripts\mp\gametypes\to_sam::activatespawns();
      break;
    case "ROUND_3BB":
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_BLITZ_PRE_1", &"MISC_MESSAGES_MP/TO_AXIS_BLITZ_PRE_1");
      wait 6;
      teamprint(&"MISC_MESSAGES_MP/TO_ALLY_BLITZ_START_1", &"MISC_MESSAGES_MP/TO_AXIS_BLITZ_START_1");
      level scripts\mp\gametypes\to_blitz::maintacops();
      level scripts\mp\gametypes\to_blitz::activatespawns();
      break;
    case "END":
    case "FINALE_3BBB":
    case "FINALE_3BBA":
    case "FINALE_3BAB":
    case "FINALE_3BAA":
    case "FINALE_3ABB":
    case "FINALE_3ABA":
    case "FINALE_3AAB":
    case "FINALE_3AAA":
      thread scripts\mp\gamelogic::endgame("none", 0);
      break;
  }
}

function onbeginnewmode() {
  level.starttime = gettime();
  level.tacopssubmodetimeron = 0;
  level.pausetacopscounter = 0;
  level.pausetimerecord = 0;
}

function sendwinnerresultstoclients() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(isDefined(level.tacopsroundresults[var_1])) {
      if(level.tacopsroundresults[var_1] == "tie" || level.tacopsroundresults[var_1] == "allies") {
        var_0 += int(pow(10, var_1) * 1);
        continue;
      }

      var_0 += int(pow(10, var_1) * 2);
    }
  }

  setomnvarforallclients("ui_tac_ops_results", var_0);
}

function roundbreaktest() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  scripts\mp\utility\player::_visionsetnaked("", 0);
  visionsetfadetoblack("", 0.75);
  wait 5;
  visionsetnaked("", 0.75);
}

function statecontroller(var_0, var_1) {
  switch (var_0) {
    case "START":
      var_0 = "ROUND_1";
      break;
    case "ROUND_1":
      if(var_1) {
        var_0 = "TRANSFER_1_2A";
      } else {
        var_0 = "END";
      }

      break;
    case "TRANSFER_1_2A":
      var_0 = "ROUND_2A";
      break;
    case "TRANSFER_1_2B":
      var_0 = "END";
      break;
    case "ROUND_2A":
      if(var_1) {
        var_0 = "TRANSFER_2A_3AA";
      } else {
        var_0 = "END";
      }

      break;
    case "ROUND_2B":
      if(var_1) {
        var_0 = "TRANSFER_2B_3BA";
      } else {
        var_0 = "TRANSFER_2B_3BB";
      }

      break;
    case "TRANSFER_2A_3AA":
      var_0 = "ROUND_3AA";
      break;
    case "TRANSFER_2A_3AB":
      var_0 = "ROUND_3AB";
      break;
    case "TRANSFER_2B_3BA":
      var_0 = "ROUND_3AB";
      break;
    case "TRANSFER_2B_3BB":
      var_0 = "ROUND_3BB";
      break;
    case "ROUND_3AA":
      if(var_1) {
        var_0 = "FINALE_3AAA";
      } else {
        var_0 = "FINALE_3AAB";
      }

      break;
    case "ROUND_3BB":
      if(var_1) {
        var_0 = "FINALE_3BBA";
      } else {
        var_0 = "FINALE_3BBB";
      }

      break;
    case "ROUND_3AB":
      if(var_1) {
        var_0 = "FINALE_3ABA";
      } else {
        var_0 = "FINALE_3ABB";
      }

      break;
    case "ROUND_3BA":
      if(var_1) {
        var_0 = "FINALE_3BAA";
      } else {
        var_0 = "FINALE_3BAB";
      }

      break;
    case "FINALE_3BBB":
    case "FINALE_3BBA":
    case "FINALE_3BAB":
    case "FINALE_3BAA":
    case "FINALE_3ABB":
    case "FINALE_3ABA":
    case "FINALE_3AAB":
    case "FINALE_3AAA":
      var_0 = "END";
      break;
  }

  return var_0;
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/WAR_HINT");
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");
  GscBinSkip1(0x45, 0, "dd");
}

function initsandbox() {
  var_0 = "radar_drone";
  var_1 = "precision_airstrike";
  level.sandboxobjectivesa = [];
  level.sandboxrewarda = [];
  level.sandboxobjectivesa[0] = scripts\engine\utility::getStructArray("tac_advantage_a", "targetname");
  level.sandboxrewarda[0] = var_0;
  level.sandboxobjectivesa[1] = scripts\engine\utility::getStructArray("tac_advantage_b", "targetname");
  level.sandboxrewarda[1] = var_0;
  level.sandboxobjectivesa[2] = scripts\engine\utility::getStructArray("tac_advantage_c", "targetname");
  level.sandboxrewarda[2] = var_1;
  level.sandboxobjectivesa[3] = scripts\engine\utility::getStructArray("tac_advantage_d", "targetname");
  level.sandboxrewarda[3] = var_1;
  level.sandboxobjectivesa[4] = scripts\engine\utility::getStructArray("tac_advantage_e", "targetname");
  level.sandboxrewarda[4] = var_0;
  level.sandboxobjectivesa[5] = scripts\engine\utility::getStructArray("tac_advantage_f", "targetname");
  level.sandboxrewarda[5] = var_1;
  level.sandboxobjectivesa[6] = scripts\engine\utility::getStructArray("tac_advantage_h", "targetname");
  level.sandboxrewarda[6] = var_1;
  level.sandboxobjectivesa[7] = scripts\engine\utility::getStructArray("tac_advantage_i", "targetname");
  level.sandboxrewarda[7] = var_0;
  level.sandboxobjectivesa[8] = scripts\engine\utility::getStructArray("tac_advantage_j", "targetname");
  level.sandboxrewarda[8] = var_1;
  level.sandboxobjectivesa[9] = scripts\engine\utility::getStructArray("tac_advantage_k", "targetname");
  level.sandboxrewarda[9] = var_1;
  level.sandboxobjectivesa[10] = scripts\engine\utility::getStructArray("tac_advantage_l", "targetname");
  level.sandboxrewarda[10] = var_1;
  level.sandboxobjectivesa[11] = scripts\engine\utility::getStructArray("tac_advantage_m", "targetname");
  level.sandboxrewarda[11] = var_1;
}

function firstphaseend() {
  if(level.prematchperiod > 0) {
    scripts\mp\flags::gameflagwait("prematch_done");
  } else {
    wait 15;
  }

  onphaseend(level.lastwinner);
}

function onspawnplayer() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.isplanting = 0;
  self.isdefusing = 0;
}

function onplayerconnect(var_0) {
  var_0 setclientomnvar("ui_hp_callout_id", 2);
  var_0.isscoring = 0;
  setomnvar("ui_tac_ops_submode", level.currentmode);
  thread monitorjointeam();
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    scripts\mp\supers::clearsuper();
    scripts\mp\tac_ops\roles_utility::latejointeamkitobjective();
  }
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  var_0 = spawnStruct();
  level.tacopsspawns = var_0;
  scripts\mp\gametypes\to_air::initspawns();
  scripts\mp\gametypes\to_bhd::initspawns();
  scripts\mp\gametypes\to_blitz::initspawns();
  scripts\mp\gametypes\to_dd::initspawns();
  scripts\mp\gametypes\to_hstg::initspawns();
  scripts\mp\gametypes\to_sam::initspawns();
  scripts\mp\gametypes\to_wmd::initspawns();
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  scripts\mp\tac_ops_map::setupspawnareas();
}

function onsuicidedeath(var_0) {}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_0.switching_teams)) {
    var_0 scripts\mp\playerlogic::decrementalivecount(var_0.team);
    return;
  }
}

function timelimitthread() {
  level endon("game_ended");
  var_0 = gettacopstimepassedms();

  for(;;) {
    thread checktacopstimelimit(var_0);
    var_0 = gettacopstimepassedms();

    if(isDefined(level.starttime)) {
      if(gettacopstimeremainingms() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

function extendtacopstimelimitms(var_0) {
  level.basetacopstimelimit = gettacopstimelimitms() + var_0;
}

function reducetacopstimelimitms(var_0) {
  level.basetacopstimelimit = gettacopstimelimitms() - var_0;
}

function checktacopstimelimit(var_0) {
  var_1 = gettacopstimeremainingms();
  setgameendtime(gettime() + int(var_1));

  if(level.tacopssubmodetimeron == 0) {
    setgameendtime(0);
    return;
  }

  if(var_1 > 0) {
    return;
  }

  setgameendtime(0);
  [[level.ontimelimit]]();
}

function gettacopstimepassedms() {
  if(isDefined(level.pausetacopstime)) {
    return level.pausetacopstime;
  }

  return gettime() - level.starttime;
}

function gettacopstimelimitms() {
  if(!isDefined(level.basetacopstimelimit)) {
    level.basetacopstimelimit = scripts\mp\utility\dvars::getwatcheddvar("timelimit") * 60 * 1000;
  }

  return level.basetacopstimelimit;
}

function gettacopstimeextensionsms() {
  return level.basetacopstimelimit - scripts\mp\utility\dvars::getwatcheddvar("timelimit") * 60 * 1000 + level.pausetimerecord;
}

function gettacopstimeremainingms() {
  return gettacopstimelimitms() - gettacopstimepassedms();
}

function pausetacopstimer() {
  if(level.pausetacopscounter == 0) {
    level.pausetacopstime = gettacopstimepassedms();
    level.pausetacopstimestarted = gettime();
  }

  level.pausetacopscounter++;
}

function resumetacopstimer() {
  level.pausetacopscounter--;

  if(level.pausetacopscounter < 0) {
    level.pausetacopscounter = 0;
  }

  if(level.pausetacopscounter == 0) {
    if(!isDefined(level.pausetacopstime)) {
      level.pausetacopstime = 0;
    }

    if(!isDefined(level.pausetacopstimestarted)) {
      level.pausetacopstimestarted = 0;
    }

    level.starttime = gettime() - level.pausetacopstime;

    if(!isDefined(level.pausetimerecord)) {
      level.pausetimerecord = 0;
    }

    level.pausetimerecord += gettime() - level.pausetacopstimestarted;
    level.pausetacopstime = undefined;
    level.pausetacopstimestarted = undefined;
    return;
  }
}

function tacopslongwaitsec(var_0) {
  var_1 = gettacopstimeremainingms() / 1000 - var_0;
  wait var_1;
  var_2 = gettacopstimeextensionsms() / 1000;
  wait var_2;
}