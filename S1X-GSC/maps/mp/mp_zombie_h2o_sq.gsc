/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_h2o_sq.gsc
****************************************/

init_sidequest() {
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("main", ::init_main_sidequest, ::sidequest_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage1", ::stage1_init, ::stage1_logic, ::stage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage2", ::stage2_init, ::stage2_logic, ::stage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage3", ::stage3_init, ::stage3_logic, ::stage3_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage4", ::stage4_init, ::stage4_logic, ::stage4_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage5", ::stage5_init, ::stage5_logic, ::stage5_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage7", ::stage7_init, ::stage7_logic, ::stage7_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage8", ::stage8_init, ::stage8_logic, ::stage8_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage9", ::stage9_init, ::stage9_logic, ::stage9_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage10", ::stage10_init, ::stage10_logic, ::stage10_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage11", ::stage11_init, ::stage11_logic, ::stage11_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage12", ::stage12_init, ::stage12_logic, ::stage12_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage13", ::stage13_init, ::stage13_logic, ::stage13_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage14", ::stage14_init, ::stage14_logic, ::stage14_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage15", ::stage15_init, ::stage15_logic, ::stage15_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("song", ::init_song_sidequest, ::sidequest_logic_song);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage1", ::songstage1_init, ::songstage1_logic, ::songstage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage2", ::songstage2_init, ::songstage2_logic, ::songstage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage3", ::songstage3_init, ::songstage3_logic, ::songstage3_end);
  level._effect["sq_capacitor_cover_blown_off"] = loadfx("vfx/explosion/vehicle_assault_drone_death");
  level._effect["sq_capacitor_charge"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_capacitor_charge");
  level._effect["sq_capacitor_charge_complete"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_capacitor_charge_complete");
  level._effect["sq_emz_explode"] = loadfx("vfx/map/mp_zombie_h2o/h2o_sq_emz_explode");
  level._effect["sq_light_puzzle_0"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_0");
  level._effect["sq_light_puzzle_1"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_1");
  level._effect["sq_light_puzzle_2"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_2");
  level._effect["sq_light_puzzle_3"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_3");
  level._effect["sq_light_puzzle_loop"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_4");
  level._effect["sq_memory_machine_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_memory_pwr_on");
  level._effect["sq_memory_machine_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_memory_pwr_off");
  level._effect["sq_memory_tunnel_player"] = loadfx("vfx/map/mp_zombie_h2o/h2o_teleport_tunnel_player");
  level._effect["sq_bubbles"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_diving_suit_bubble_trail_lp");
  level._effect["sq_bubbles_first_person"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_player_bubbles_breath");
  level._effect["sq_plunge"] = loadfx("vfx/water/screen_fx_plunge");
  level._effect["sq_emerge"] = loadfx("vfx/water/screen_fx_emerge");
  level._effect["h2o_ee_wave_hit_large"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_wave_hit_large");
  level._effect["h2o_ee_wave_hit_med"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_wave_hit_med");
  level._effect["h2o_ee_wave_hit_sm"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_wave_hit_sm");
  level.shouldignoreplayercallback = ::h2oshouldignoreplayer;
  level.zombiehardmodevisionset = "mp_zombie_h2o_hard";
  level.zombiehardmodeinfectedvisionset = "mp_zombie_h2o_infected_hard";
  level thread jumpquest_init();
  level thread starth2osidequest();
  level thread setuptrophycase();
  level thread setuphardmode();
  level thread initvo();
  level thread initcapacitors();
}

starth2osidequest() {
  var_0 = getent("sq_underwater_switch_off", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
  }

  var_0 = getent("sq_underwater_switch_on", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
  }

  var_1 = getent("sqCounterTop0", "targetname");
  var_2 = getent("sqCounterTop1", "targetname");
  var_3 = getent("sqCounterTop2", "targetname");
  var_4 = getent("sqCounterTop3", "targetname");
  var_5 = getent("sqCounterBottom0", "targetname");
  var_6 = getent("sqCounterBottom1", "targetname");
  var_7 = getent("sqCounterBottom2", "targetname");
  var_8 = getent("sqCounterBottom3", "targetname");
  var_1 hide();
  var_2 hide();
  var_3 hide();
  var_4 hide();
  var_5 hide();
  var_6 hide();
  var_7 hide();
  var_8 hide();

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    return;
  }
  wait 1;
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

setuptrophycase() {
  var_0 = [];
  var_1 = gettrophy("1a");

  if(!isDefined(var_1)) {
    return;
  }
  var_0[var_0.size] = var_1;
  var_0[var_0.size] = gettrophy("1b");
  var_0[var_0.size] = gettrophy("2");
  var_0[var_0.size] = gettrophy("3a");
  var_0[var_0.size] = gettrophy("3b");
  var_0[var_0.size] = gettrophy("4a");
  var_0[var_0.size] = gettrophy("4b");

  if(var_0.size != 7) {
    return;
  }
  foreach(var_1 in var_0) {
    var_1 trophyhide();
  }

  if(!isDefined(level.players) || level.players.size == 0) {
    level waittill("player_spawned");
  }

  level thread onplayerconnecttrophies(var_0);

  for(;;) {
    foreach(var_5 in level.players) {
      var_5 playershowtrophies(var_0);
    }

    level waittill("sq_update_trophies");

    foreach(var_1 in var_0) {
      var_1 trophyhide();
    }
  }
}

playershowtrophies(var_0) {
  var_1 = self getcoopplayerdatareservedint("eggData");

  if(var_1 & 1) {
    showtrophyforplayer(var_0, "1a", self);
  }

  if(var_1 & 2) {
    showtrophyforplayer(var_0, "1b", self);
  }

  if(var_1 & 4) {
    showtrophyforplayer(var_0, "2", self);
  }

  if(var_1 & 8) {
    showtrophyforplayer(var_0, "3a", self);
  }

  if(var_1 & 16) {
    showtrophyforplayer(var_0, "3b", self);
  }

  if(var_1 & 32) {
    showtrophyforplayer(var_0, "4a", self);
  }

  if(var_1 & 64) {
    showtrophyforplayer(var_0, "4b", self);
  }
}

showtrophyforplayer(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(var_4.id == var_1) {
      var_4 trophyshowtoplayer(var_2);
      break;
    }
  }
}

trophyhide() {
  self hide();

  if(isDefined(self.trophynum)) {
    self.trophynum hide();
  }
}

trophyshowtoplayer(var_0) {
  self showtoplayer(var_0);

  if(isDefined(self.trophynum)) {
    self.trophynum showtoplayer(var_0);
  }
}

gettrophy(var_0) {
  var_1 = getent("sqTrophy" + var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getent("sqTrophyNum" + var_0, "targetname");
  var_1.id = var_0;
  var_1.trophynum = var_2;
  return var_1;
}

onplayerconnecttrophies(var_0) {
  for(;;) {
    level waittill("connected", var_1);
    var_1 playershowtrophies(var_0);
  }
}

setuphardmode() {
  if(maps\mp\zombies\_util::iszombieshardmode()) {
    setnojipscore(1);
    setomnvar("ui_zm_hard_mode", 1);
    visionsetpostapply(level.zombiehardmodevisionset, 0);
    setmatchdata("gameLengthSeconds", 0);
    setmatchdata("lifeCount", 0);
    setmatchdata("eventCount", 0);

    if(isDefined(level.players)) {
      foreach(var_1 in level.players) {
        var_1 thread playersetuphardmode();
      }
    }

    level thread onplayerconnecthardmode();
    var_3 = getent("sqHardModeButton", "targetname");
    var_4 = getent("sqHardModeTrigger", "targetname");

    if(isDefined(var_3)) {
      var_3 hide();
    }

    if(isDefined(var_4)) {
      var_4 hide();
    }

    level.zmbhardmodeintro = ::zmbhardmodeintro;
    level waittill("zombie_boss_stage2_ended");
    sethardmodebosscoopdatah2o();
  } else {
    level thread handlehardmodebutton();
    waittillstarthardmode();
    setnojipscore(1);
    level.zombiegamepaused = 1;
    maps\mp\zombies\_util::writezombiestats();
    level thread endgametohardmode(level.playerteam, game["end_reason"]["zombies_hard_mode"]);
  }
}

zmbhardmodeintro() {
  announcerozglobalplaysq(34);
}

handlehardmodebutton() {
  var_0 = getent("sqHardModeButton", "targetname");
  var_1 = getent("sqHardModeTrigger", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1.origin = var_1.origin + (0, 0, 1000);
  var_0 hide();

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      var_3 playershowhardmodebutton(var_1, var_0);
    }
  }

  level thread onplayerconnectshowhardmodebutton(var_1, var_0);

  for(;;) {
    var_1 waittill("trigger", var_3);

    if(maps\mp\zombies\_util::is_true(var_1.enabled)) {
      if(!maps\mp\zombies\_util::is_true(var_3.hardmodevote)) {
        var_3.hardmodevote = 1;
        iprintlnbold(&"ZOMBIE_H2O_HARD_MODE_VOTE", numplayersvotedforhardmode(), level.players.size);
      } else {
        var_3 iprintlnbold(&"ZOMBIE_H2O_HARD_MODE_VOTE", numplayersvotedforhardmode(), level.players.size);
      }

      if(checkstarthardmode()) {
        return;
      }
    }

    wait 0.5;
  }
}

checkstarthardmode() {
  if(allplayerswanthardmode()) {
    wait 1;
    level notify("start_hard_mode");
    return 1;
  }

  return 0;
}

numplayersvotedforhardmode() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_2.hardmodevote)) {
      var_0++;
    }
  }

  return var_0;
}

allplayerswanthardmode() {
  foreach(var_1 in level.players) {
    if(!maps\mp\zombies\_util::is_true(var_1.hardmodevote)) {
      return 0;
    }
  }

  return 1;
}

onplayerconnectshowhardmodebutton(var_0, var_1) {
  for(;;) {
    level waittill("connected", var_2);
    var_2 thread playershowhardmodebutton(var_0, var_1);
  }
}

playershowhardmodebutton(var_0, var_1) {
  thread onplayerdisconnecthardmodebutton();

  if(playerhashardmode() && !maps\mp\zombies\_util::is_true(var_0.enabled)) {
    var_0.origin = var_0.origin + (0, 0, -1000);
    var_0 setcursorhint("HINT_NOICON");
    var_0 sethintstring(&"ZOMBIE_H2O_START_HARD_MODE");
    var_0.enabled = 1;
    var_1 show();
  }
}

onplayerdisconnecthardmodebutton() {
  level endon("game_ended");
  self waittill("disconnect");
  checkstarthardmode();
}

sethardmodebosscoopdatah2o() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_2 = var_1 getcoopplayerdatareservedint("eggData");
    var_2 = var_2 | 64;
    var_1 setcoopplayerdatareservedint("eggData", var_2);
  }

  level notify("sq_update_trophies");
}

onplayerconnecthardmode() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedhardmode();
  }
}

onplayerspawnedhardmode() {
  self endon("disconnect");
  self waittill("spawned_player");
  thread playersetuphardmode();
}

playersetuphardmode() {
  self endon("disconnect");
  playersethardmodecoopdatah2o();
  self _meth_856B(0);

  for(;;) {
    self waittill("spawned_player");
    self _meth_856B(0);
  }
}

setsidequestcoopdatah2o() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_2 = var_1 getcoopplayerdatareservedint("eggData");
    var_2 = var_2 | 32;
    var_1.sidequest = 1;
    var_1 setcoopplayerdatareservedint("eggData", var_2);
    setmatchdata("players", var_1.clientid, "startPrestige", var_1.sidequest);
  }

  level notify("sq_update_trophies");
}

playersethardmodecoopdatah2o() {
  var_0 = self getcoopplayerdatareservedint("eggData");
  var_0 = var_0 | 128;
  self setcoopplayerdatareservedint("eggData", var_0);
}

playerhashardmode() {
  var_0 = self getcoopplayerdatareservedint("eggData");
  return var_0 & 128;
}

givesidequestachievement() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_EASTEREGG");
  }
}

waittillstarthardmode() {
  level endon("start_hard_mode");
  level waittill("sidequest_main_complete");
}

endgametohardmode(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(game["state"] == "postgame" || level.gameended) {
    return;
  }
  game["state"] = "postgame";
  setDvar("ui_game_state", "postgame");
  level.zmbtransitiontohardmode = 1;
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level notify("game_ended", var_0);
  maps\mp\_utility::levelflagset("game_over");
  maps\mp\_utility::levelflagset("block_notifies");
  var_3 = maps\mp\gametypes\_gamelogic::getgameduration();
  setomnvar("ui_game_duration", var_3 * 1000);
  waitframe();
  setgameendtime(0);
  setmatchdata("gameLengthSeconds", var_3);
  setmatchdata("endTimeUTC", getsystemtime());
  maps\mp\gametypes\_gamelogic::checkgameendchallenges();

  if(isDefined(var_0) && isstring(var_0) && maps\mp\_utility::isovertimetext(var_0)) {
    level.finalkillcam_winner = "none";
    maps\mp\gametypes\_gamelogic::endgameovertime(var_0, var_1);
    return;
  }

  if(isDefined(var_0) && isstring(var_0) && var_0 == "halftime") {
    level.finalkillcam_winner = "none";
    maps\mp\gametypes\_gamelogic::endgamehalftime(var_1);
    return;
  }

  if(isDefined(level.finalkillcam_winner)) {
    level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
  }

  game["roundsPlayed"]++;
  setomnvar("ui_current_round", game["roundsPlayed"]);

  if(level.teambased) {
    if((var_0 == "axis" || var_0 == "allies") && level.gametype != "ctf") {
      game["roundsWon"][var_0]++;
    }

    maps\mp\gametypes\_gamescore::updateteamscore("axis");
    maps\mp\gametypes\_gamescore::updateteamscore("allies");
  } else if(isDefined(var_0) && isPlayer(var_0)) {
    game["roundsWon"][var_0.guid]++;
  }

  maps\mp\gametypes\_gamescore::updateplacement();
  maps\mp\gametypes\_gamelogic::rankedmatchupdates(var_0);

  foreach(var_5 in level.players) {
    var_5 setclientdvar("ui_opensummary", 1);

    if(maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround()) {
      var_5 maps\mp\killstreaks\_killstreaks::clearkillstreaks(1);
    }
  }

  setDvar("g_deadChat", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("bg_compassShowEnemies", 0);
  maps\mp\gametypes\_gamelogic::freezeallplayers(1.0, 1);

  if(!maps\mp\_utility::wasonlyround() && !var_2) {
    maps\mp\gametypes\_gamelogic::displayroundend(var_0, var_1);

    if(isDefined(level.finalkillcam_winner)) {
      foreach(var_5 in level.players) {
        var_5 notify("reset_outcome");
      }

      level notify("game_cleanup");
      maps\mp\gametypes\_gamelogic::waittillfinalkillcamdone();
    }

    if(!maps\mp\_utility::waslastround()) {
      maps\mp\_utility::levelflagclear("block_notifies");

      if(maps\mp\gametypes\_gamelogic::checkroundswitch()) {
        maps\mp\gametypes\_gamelogic::displayroundswitch();
      }

      foreach(var_5 in level.players) {
        var_5.pers["stats"] = var_5.stats;
        var_5.pers["segments"] = var_5.segments;
      }

      level notify("restarting");
      game["state"] = "playing";
      setDvar("ui_game_state", "playing");
      map_restart(1);
      return;
    }

    if(!level.forcedend) {
      var_1 = maps\mp\gametypes\_gamelogic::updateendreasontext(var_0);
    }
  }

  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp/clientmatchdata.def";
    setclientmatchdatadef(game["clientMatchDataDef"]);
  }

  maps\mp\gametypes\_missions::roundend(var_0);
  var_0 = maps\mp\gametypes\_gamelogic::getgamewinner(var_0, 1);

  if(level.teambased) {
    setomnvar("ui_game_victor", 0);

    if(var_0 == "allies") {
      setomnvar("ui_game_victor", 2);
    } else if(var_0 == "axis") {
      setomnvar("ui_game_victor", 1);
    }
  }

  maps\mp\gametypes\_gamelogic::displaygameend(var_0, var_1);

  foreach(var_5 in level.players) {
    var_5 setclientomnvar("ui_round_end_reason", var_1);
  }

  var_13 = gettime();

  if(isDefined(level.finalkillcam_winner) && maps\mp\_utility::wasonlyround()) {
    foreach(var_5 in level.players) {
      var_5 notify("reset_outcome");
    }

    level notify("game_cleanup");
    maps\mp\gametypes\_gamelogic::waittillfinalkillcamdone();
  }

  maps\mp\_utility::levelflagclear("block_notifies");
  level.intermission = 1;
  level notify("spawning_intermission");

  foreach(var_5 in level.players) {
    var_5 closepopupmenu();
    var_5 closeingamemenu();
    var_5 notify("reset_outcome");
    var_5 thread maps\mp\gametypes\_playerlogic::spawnintermission();
  }

  maps\mp\gametypes\_gamelogic::processlobbydata();
  wait 1.0;
  maps\mp\gametypes\_gamelogic::checkforpersonalbests();
  maps\mp\gametypes\_gamelogic::updatecombatrecord();

  if(level.teambased) {
    if(var_0 == "axis" || var_0 == "allies") {
      setmatchdata("victor", var_0);
    } else {
      setmatchdata("victor", "none");
    }

    setmatchdata("alliesScore", game["teamScores"]["allies"]);
    setmatchdata("axisScore", game["teamScores"]["axis"]);
    tournamentreportwinningteam(var_0);
  } else {
    setmatchdata("victor", "none");
  }

  level maps\mp\_matchdata::endofgamesummarylogger();

  foreach(var_5 in level.players) {
    if(var_5 maps\mp\_utility::rankingenabled()) {
      var_5 maps\mp\_matchdata::logfinalstats();
    }

    var_5 maps\mp\gametypes\_playerlogic::logplayerstats();
  }

  setmatchdata("host", maps\mp\gametypes\_playerlogic::truncateplayername(level.hostname));

  if(maps\mp\_utility::matchmakinggame()) {
    setmatchdata("playlistVersion", getplaylistversion());
    setmatchdata("playlistID", getplaylistid());
    setmatchdata("isDedicated", isdedicatedserver());
  }

  setmatchdata("levelMaxClients", level.maxclients);
  sendmatchdata();

  foreach(var_5 in level.players) {
    var_5.pers["stats"] = var_5.stats;
    var_5.pers["segments"] = var_5.segments;
  }

  tournamentreportendofgame();
  var_22 = 0;

  if(maps\mp\_utility::practiceroundgame()) {
    var_22 = 5.0;
  }

  if(isDefined(level.endgamewaitfunc)) {
    [[level.endgamewaitfunc]](var_2, level.postgamenotifies, var_22, var_0);
  } else if(!var_2 && !level.postgamenotifies) {
    if(!maps\mp\_utility::wasonlyround()) {
      wait(6.0 + var_22);
    } else {
      wait(min(10.0, 4.0 + var_22 + level.postgamenotifies));
    }
  } else {
    wait(min(10.0, 4.0 + var_22 + level.postgamenotifies));
  }

  var_23 = "_gamelogic.gsc";
  var_24 = "all";

  if(level.teambased && isDefined(var_0)) {
    var_24 = var_0;
  }

  var_25 = "undefined";

  if(isDefined(var_1)) {
    switch (var_1) {
      case 1:
        var_25 = "MP_SCORE_LIMIT_REACHED";
        break;
      case 2:
        var_25 = "MP_TIME_LIMIT_REACHED";
        break;
      case 3:
        var_25 = "MP_PLAYERS_FORFEITED";
        break;
      case 4:
        var_25 = "MP_TARGET_DESTROYED";
        break;
      case 5:
        var_25 = "MP_BOMB_DEFUSED";
        break;
      case 6:
        var_25 = "MP_GHOSTS_ELIMINATED";
        break;
      case 7:
        var_25 = "MP_FEDERATION_ELIMINATED";
        break;
      case 8:
        var_25 = "MP_GHOSTS_FORFEITED";
        break;
      case 9:
        var_25 = "MP_FEDERATION_FORFEITED";
        break;
      case 10:
        var_25 = "MP_ENEMIES_ELIMINATED";
        break;
      case 11:
        var_25 = "MP_MATCH_TIE";
        break;
      case 12:
        var_25 = "GAME_OBJECTIVECOMPLETED";
        break;
      case 13:
        var_25 = "GAME_OBJECTIVEFAILED";
        break;
      case 14:
        var_25 = "MP_SWITCHING_SIDES";
        break;
      case 15:
        var_25 = "MP_ROUND_LIMIT_REACHED";
        break;
      case 16:
        var_25 = "MP_ENDED_GAME";
        break;
      case 17:
        var_25 = "MP_HOST_ENDED_GAME";
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_13)) {
    var_13 = -1;
  }

  var_26 = 15;
  var_27 = var_26;
  var_28 = getmatchdata("playerCount");
  var_29 = getmatchdata("lifeCount");

  if(!isDefined(level.matchdata)) {
    var_30 = 0;
    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;
    var_35 = 0;
    var_36 = 0;
  } else {
    if(isDefined(level.matchdata["botJoinCount"])) {
      var_30 = level.matchdata["botJoinCount"];
    } else {
      var_30 = 0;
    }

    if(isDefined(level.matchdata["deathCount"])) {
      var_31 = level.matchdata["deathCount"];
    } else {
      var_31 = 0;
    }

    if(isDefined(level.matchdata["badSpawnDiedTooFastCount"])) {
      var_32 = level.matchdata["badSpawnDiedTooFastCount"];
    } else {
      var_32 = 0;
    }

    if(isDefined(level.matchdata["badSpawnKilledTooFastCount"])) {
      var_33 = level.matchdata["badSpawnKilledTooFastCount"];
    } else {
      var_33 = 0;
    }

    if(isDefined(level.matchdata["badSpawnDmgDealtCount"])) {
      var_34 = level.matchdata["badSpawnDmgDealtCount"];
    } else {
      var_34 = 0;
    }

    if(isDefined(level.matchdata["badSpawnDmgReceivedCount"])) {
      var_35 = level.matchdata["badSpawnDmgReceivedCount"];
    } else {
      var_35 = 0;
    }

    if(isDefined(level.matchdata["badSpawnByAnyMeansCount"])) {
      var_36 = level.matchdata["badSpawnByAnyMeansCount"];
    } else {
      var_36 = 0;
    }
  }

  var_37 = 0;

  if(isDefined(level.spawnsighttracesused_pres1tu)) {
    var_37 = var_37 + 1;
  }

  if(isDefined(level.spawnsighttracesused_posts1tu)) {
    var_37 = var_37 + 2;
  }

  reconevent("script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnDiedTooFastCount %d, badSpawnKilledTooFastCount %d, badSpawnDmgDealtCount %d, badSpawnDmgReceivedCount %d, badSpawnByAnyMeansCount %d, sightTraceMethodsUsed %d", var_23, var_13, var_24, var_25, var_27, var_28, var_30, var_29, var_31, var_32, var_33, var_34, var_35, var_36, var_37);

  if(isDefined(level.ishorde) && level.ishorde) {
    if(isDefined(level.zombiescompleted) && level.zombiescompleted) {
      setDvar("cg_drawCrosshair", 1);
    }
  }

  foreach(var_5 in level.players) {
    var_5.pers["stats"] = var_5.stats;
    var_5.pers["segments"] = var_5.segments;
    var_5.pers["team"] = undefined;
    var_5 sendleaderboards();
    var_5 setclientomnvar("ui_round_end", 0);
  }

  setomnvar("ui_zm_hard_mode", 1);
  setomnvar("ui_zm_ee_bool", 1);
  wait 0.5;
  level notify("restarting");
  game["state"] = "playing";
  game["start_in_zmb_hard_mode"] = 1;
  game["gamestarted"] = undefined;
  setDvar("ui_game_state", "playing");
  map_restart(1);
}

initvo() {
  waitframe();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "sq", "sq", "dlc4_easter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "sq", "sq_jump_win", "dlc4_easter_jumpw", undefined, 80);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "sq", "sq_jump_fail", "dlc4_easter_jumpf", undefined, 30);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "sq", "sq_dlc4", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "sq3", "sq_dlc3", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "sq", "dlc4_easter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "sq", "dlc4_easter", undefined);
}

h2oshouldignoreplayer(var_0) {
  if(maps\mp\zombies\_util::is_true(var_0.inairlock)) {
    return 1;
  }

  return 0;
}

init_main_sidequest() {}

sidequest_logic() {
  level thread monitorbossintermission();
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage1");
  level waittill("main_stage1_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage2");
  level waittill("main_stage2_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage3");
  level waittill("main_stage3_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage4");
  level waittill("main_stage4_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage5");
  level waittill("main_stage5_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage7");
  level waittill("main_stage7_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage8");
  level waittill("main_stage8_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage9");
  level waittill("main_stage9_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage10");
  level waittill("main_stage10_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage11");
  level waittill("main_stage11_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage12");
  level waittill("main_stage12_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage13");
  level waittill("main_stage13_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage14");
  level waittill("main_stage14_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage15");
  level waittill("main_stage15_over");
  wait 2;
  setsidequestcoopdatah2o();
  givesidequestachievement();
}

monitorbossintermission() {
  level endon("main_stage15_over");
  level.zmbsqinbossintermission = 0;

  for(;;) {
    level waittill("zombie_round_count_update");
    level.zmbsqinbossintermission = 1;
    level waittill("zombie_wave_started");
    level.zmbsqinbossintermission = 0;
  }
}

generic_stage_start() {}

generic_stage_complete() {}

complete_sidequest() {}

stage1_init() {}

stage1_logic() {
  var_0 = getEntArray("sqValve", "targetname");

  if(var_0.size == 0) {
    return;
  }
  level.zmbsqnumvalvescomplete = 0;
  assignexplodernumberstovalves(var_0);

  foreach(var_2 in var_0) {
    var_2 thread valvesetup();
  }

  level waittill("zmb_sq_valve_complete");

  while(level.zmbsqnumvalvescomplete < 3) {
    waitframe();
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage1");
}

valvesetup() {
  self.degreesturned = 0;
  self.firstturn = 0;
  self.halfway = 0;
  self.damagecallback = ::valvedamagecallback;
  self setdamagecallbackon(1);
  self setCanDamage(1);
  self waittill("turn_complete");
  level.zmbsqnumvalvescomplete++;
  thread maps\mp\mp_zombie_h2o_aud::sndvalvelight(self.origin);
  level notify("zmb_sq_valve_complete");
  activateclientexploder(self.script_index);
}

assignexplodernumberstovalves(var_0) {
  if(isDefined(var_0[0].script_index)) {
    return;
  }
  var_1 = 40;
  var_0 = maps\mp\_utility::quicksort(var_0, ::comparevalveheight);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2].script_index = var_1;
    var_1++;
  }
}

comparevalveheight(var_0, var_1) {
  return var_0.origin[2] <= var_1.origin[2];
}

valvedamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_4) && isexplosivedamagemod(var_4)) {
    return;
  }
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  self.angles = (self.angles[0], self.angles[1], self.angles[2] + 6.0);
  self.degreesturned = self.degreesturned + 6.0;

  if(!self.halfway && self.degreesturned >= 180) {
    self.halfway = 1;
    self notify("turn_halfway");
  }

  if(!self.firstturn) {
    self.firstturn = 1;
    self notify("first_turn");
  }

  if(self.degreesturned >= 360) {
    self setdamagecallbackon(0);
    self.damagecallback = undefined;
    self notify("turn_complete");
  }
}

stage1_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Opened secret room");
  thread maps\mp\mp_zombie_h2o_aud::sndcomputerloop();
  level thread opendoors();
}

opendoors() {
  var_0 = common_scripts\utility::getstruct("sqDoor1", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_4.openpos = common_scripts\utility::getstruct(var_4.target, "targetname");
    var_5 = getent(var_4.target, "targetname");
    var_5 linktosynchronizedparent(var_4);

    if(!common_scripts\utility::array_contains(var_2, var_4.origin)) {
      var_2[var_2.size] = var_4.origin;
    }
  }

  var_7 = 1.0;

  foreach(var_4 in var_1) {
    var_4 moveto(var_4.openpos.origin, var_7);
  }

  foreach(var_11 in var_2) {
    playsoundatpos(var_11, "interact_door");
  }

  wait(var_7);
  level.zone_data.zones["easter_egg"].is_enabled = 1;
  common_scripts\utility::flag_set("zone_04_to_easter_egg");
  waitframe();

  foreach(var_4 in var_1) {
    var_4 delete();
  }
}

stage2_init() {}

stage2_logic() {
  var_0 = common_scripts\utility::getstruct("sqComputer", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 76;
  var_2 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("computer_used", undefined, undefined, "main_stage2_over", var_1);
  maps\mp\mp_zombie_h2o_aud::sndcomputeracknowledge(var_0.origin);
  wait 1;
  doangozconversation(var_0);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage2");
}

doangozconversation(var_0) {
  var_1 = 76;
  announcerglobalplaysqvowaittilldone(1);
  var_2 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("computer_used", undefined, undefined, "main_stage2_over", var_1);
  maps\mp\mp_zombie_h2o_aud::sndcomputerfail(var_0.origin);
  wait 1;
  announcerglobalplaysqvowaittilldone(2);
  var_3 = getplayerlistforstage2();

  if(!isDefined(var_2)) {
    var_2 = getnextplayerfromlist(var_3);
  }

  var_2 playerplaysqvo(1, undefined, 1);
  wait 1;
  var_2 = getnextplayerfromlist(var_3, var_2);
  var_2 playerplaysqvo(2, undefined, 1);
  wait 1;
  announcerozglobalplaysqwaittilldone(1);
  wait 1;
  var_2 = getnextplayerfromlist(var_3, var_2);
  var_2 playerplaysqvo(4, undefined, 1);
  wait 3;
}

getplayerlistforstage2() {
  var_0 = [];
  var_1 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");

  if(isDefined(var_1)) {
    var_0[var_0.size] = var_1;
  }

  var_2 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");

  if(isDefined(var_2)) {
    var_0[var_0.size] = var_2;
  }

  var_3 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");

  if(isDefined(var_3)) {
    var_0[var_0.size] = var_3;
  }

  var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");

  if(isDefined(var_4)) {
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

getnextplayerfromlist(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_0.size;

  if(var_3 == 1) {
    return var_1;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(!isDefined(var_1) || var_5 == var_1) {
      var_2 = var_4;
      break;
    }
  }

  var_4 = 0;
  var_2++;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(var_2 >= var_3) {
      var_2 = 0;
    }

    var_5 = var_0[var_2];

    if(isalive(var_5)) {
      return var_5;
    }

    var_4++;
    var_2++;
  }

  return var_1;
}

stage2_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Used Computer and talked to Oz");
}

stage3_init() {
  var_0 = common_scripts\utility::getstruct("sqWaterValveLight", "targetname");
  activateclientexploder(70);
  var_1 = getent("sq_underwater_switch_off", "targetname");

  if(isDefined(var_1)) {
    var_1 show();
  }
}

stage3_logic() {
  var_0 = common_scripts\utility::getstruct("sqAirlockUse", "targetname");
  var_1 = getent("airlockClip1", "targetname");
  var_2 = getent("sqAirlockUseTrigger", "targetname");

  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  var_3 = 0;

  for(;;) {
    var_2 waittill("trigger", var_4);

    if(!var_4 isonground()) {
      continue;
    }
    thread maps\mp\mp_zombie_h2o_aud::snddepressurizeloopstart(var_1);
    activateclientexploder(30);
    level.zmbhighpriorityenemy = var_4;

    if(!var_3) {
      var_3 = 1;
      level thread announcerozglobalplaysq(24);
    }

    var_5 = var_1 useholdthink(var_4, 0, 45000);
    thread maps\mp\mp_zombie_h2o_aud::snddepressurizeloopend(var_1);
    stopclientexploder(30);

    if(var_5) {
      level.zmbhighpriorityenemy = undefined;
      break;
    }

    wait 1.5;
    level.zmbhighpriorityenemy = undefined;
  }

  maps\mp\mp_zombie_h2o_aud::snddepressurizecomplete(var_1);
  level thread announcerglobalplaysqvo(3, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage3");
}

useholdthink(var_0, var_1, var_2) {
  var_0 playerlinkto(self);
  var_0 playerlinkedoffsetenable();

  if(!isDefined(self.curprogress)) {
    self.curprogress = var_1;
    self.usetime = var_2;
  }

  self.inuse = 1;
  self.userate = 0;
  var_0 disableweapons();
  var_0 thread personalusebar(self);
  var_3 = useholdthinkloop(var_0);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self.inuse = 0;

  if(isDefined(var_0)) {
    var_0 enableweapons();
    var_0 setclientomnvar("ui_use_bar_text", 0);
    var_0 setclientomnvar("ui_use_bar_end_time", 0);
    var_0 setclientomnvar("ui_use_bar_start_time", 0);

    if(var_0 islinked()) {
      var_0 unlink();
    }
  }

  self notify("zombieUseHoldThinkComplete");
  return var_3;
}

personalusebar(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("enter_last_stand");
  self endon("stop_useHoldThinkLoop");
  self setclientomnvar("ui_use_bar_text", 6);
  self setclientomnvar("ui_use_bar_start_time", int(gettime() - var_0.curprogress));
  var_1 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_1 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      if(var_0.userate > 0) {
        var_2 = gettime();
        var_3 = var_0.curprogress / var_0.usetime;
        var_4 = var_2 + (1 - var_3) * (var_0.usetime / var_0.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_4));
      }

      var_1 = var_0.userate;
    }

    waitframe();
  }
}

useholdthinkloop(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("enter_last_stand");
  var_0 endon("stop_useHoldThinkLoop");

  while(!level.gameended && isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && var_0 usebuttonpressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    if(self.curprogress >= self.usetime) {
      return maps\mp\_utility::isreallyalive(var_0);
    }

    wait 0.05;
  }

  return 0;
}

stage3_end(var_0) {
  level.zmbhighpriorityenemy = undefined;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Activated the airlock");
}

stage4_init() {}

stage4_logic() {
  var_0 = common_scripts\utility::getstruct("sqAirlockUse", "targetname");
  var_1 = getent("airlockClip1", "targetname");
  var_2 = getent("airlockClip2", "targetname");
  var_3 = getent("sqAirlockTrigger1", "targetname");
  var_4 = getent("sqAirlockTrigger2", "targetname");
  var_5 = getent("sqAirlockVolume", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 180, 0);
  }

  var_6 = createairlockdoor(var_1);
  var_7 = createairlockdoor(var_2);
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    level.zmbbossteleportdelay = undefined;
    var_10 = activatedairlock(var_0);
    var_11 = 0;
    level thread monitorplayersinairlock(var_5, var_3);
    level thread openairlockdoor(var_6);

    if(canplayercontinuestage4(var_10) && var_10 maps\mp\_utility::isjuggernaut()) {
      waittillplayerinairlock(var_10, var_3, var_5, 1);
    }

    level.zmbbossteleportdelay = 1;
    level thread closeairlockdoor(var_6);

    if(maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress)) {
      teleportoutplayersinairlock();
    } else {
      teleportoutplayersinairlock(var_10);
    }

    if(!canplayercontinuestage4(var_10) || !var_10 maps\mp\_utility::isjuggernaut() || !maps\mp\zombies\_util::is_true(var_10.inairlock)) {
      level notify("main_stage4_stop_airlock_monitor");
      wait 1;
      continue;
    }

    if(!var_8) {
      level thread announcerozglobalplaysq(25);
      var_8 = 1;
    }

    if(!var_9) {
      level thread dofloaterzombie();
      var_9 = 1;
    }

    fillairlockwithwater();

    if(canplayercontinuestage4(var_10) && var_10 maps\mp\_utility::isjuggernaut()) {
      var_10 playergoliathsetwater(1);
      openairlockdoor(var_7);

      if(canplayercontinuestage4(var_10) && var_10 maps\mp\_utility::isjuggernaut()) {
        var_11 = waittillactivatedwatervalve(var_10);
      }

      if(canplayercontinuestage4(var_10) && var_10 maps\mp\_utility::isjuggernaut()) {
        waittillplayerinairlock(var_10, var_4, var_5, 0);
      }

      closeairlockdoor(var_7);
    } else if(isDefined(var_10) && isalive(var_10)) {
      var_10 maps\mp\gametypes\zombies::moversuicidecustom();
      wait 2;
    }

    emptywaterfromairlock();

    if(isDefined(var_10) && isDefined(var_10.underwatermotiontype)) {
      var_10 playergoliathsetwater(0);
    }

    if(isDefined(var_10) && isalive(var_10)) {
      openairlockdoor(var_6);

      if(isDefined(var_10) && isalive(var_10)) {
        waittillplayernotinairlock(var_10, var_3, var_5, 1);
      }

      if(isDefined(var_10)) {
        var_10.inairlock = 0;
      }

      closeairlockdoor(var_6);
    }

    level notify("main_stage4_stop_airlock_monitor");
    teleportoutplayersinairlock();
    waitframe();
    level.zmbbossteleportdelay = undefined;

    if(maps\mp\zombies\_util::is_true(var_11)) {
      break;
    }

    wait 2;
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage4");
}

dofloaterzombie() {
  var_0 = common_scripts\utility::getstruct("floater_anim_node", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getent("sq_floater_blocker", "targetname");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  level.sqfloater = spawn("script_model", (0, 0, 0));
  level.sqfloater setModel("zom_host_fullbody");
  level.sqfloater scriptmodelplayanimdeltamotionfrompos("zom_h2o_floater_enter", var_0.origin, var_0.angles, "floater_notetrack");
  level.sqfloater waittillmatch("floater_notetrack", "end");
  level.sqfloater thread floaterzombiedetecthit();
  level.sqfloater scriptmodelplayanimdeltamotionfrompos("zom_h2o_floater_loop", var_0.origin, var_0.angles, "floater_notetrack", 1);
  level.sqfloater common_scripts\utility::waittill_any_return_no_endon_death("hit_floater", "main_stage4_over");
  level.sqfloater scriptmodelplayanimdeltamotionfrompos("zom_h2o_floater_exit", var_0.origin, var_0.angles, "floater_notetrack", 1);

  if(isDefined(var_1)) {
    var_1 delete();
  }

  level.sqfloater waittillmatch("floater_notetrack", "end");
  level.sqfloater delete();
}

floaterzombiedetecthit() {
  var_0 = 6400;
  var_1 = 0.866;
  waitframe();

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 maps\mp\_utility::isjuggernaut() && var_3 ismeleeing()) {
        var_4 = distance2dsquared(var_3.origin, self.origin);

        if(var_4 <= var_0) {
          var_5 = anglesToForward(var_3.angles);
          var_6 = self.origin - var_3.origin;
          var_6 = vectornormalize((var_6[0], var_6[1], 0));
          var_7 = vectordot(var_5, var_6);

          if(var_7 >= var_1) {
            self notify("hit_floater");
            return;
          }
        }
      }
    }

    waitframe();
  }
}

fillairlockwithwater() {
  var_0 = getent("sqAirlockWater", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.emptypos)) {
    var_0.emptypos = var_0.origin;
    var_0.filledpos = var_0.origin + (0, 0, 192);
  }

  thread maps\mp\mp_zombie_h2o_aud::sndfillwithwater();
  var_0 moveto(var_0.filledpos, 2, 0.1, 0.1);
  wait 1.3;
}

emptywaterfromairlock() {
  var_0 = getent("sqAirlockWater", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  thread maps\mp\mp_zombie_h2o_aud::snddrainwater();
  var_0 moveto(var_0.emptypos, 2, 0.1, 0.1);
  wait 1.3;
}

playergoliathcleanupbubblesondisconnect(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  var_0.bubblesfx = undefined;
  self delete();
}

playergoliathsetwater(var_0) {
  if(var_0) {
    playergoliathhelmet();
    thread playerhandleunderwatershellshock();
    self.underwatermotiontype = "deep";
    maps\mp\zombies\_util::playerallowfire(0, "sq");
    common_scripts\utility::_disableoffhandweapons();
    self disableoffhandsecondaryweapons();
    self.oldmovescaler = self.movespeedscaler;
    self.movespeedscaler = self.movespeedscaler * 0.75;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\mp_zombie_h2o_aud::sndunderwaterenter(self);
    playFXOnTag(common_scripts\utility::getfx("sq_bubbles"), self, "j_shoulder_ri");
    self.bubblesfx = spawnfxforclient(common_scripts\utility::getfx("sq_bubbles_first_person"), self.origin, self);
    triggerfx(self.bubblesfx);
    self.bubblesfx thread playergoliathcleanupbubblesondisconnect(self);
    playfxontagforclients(common_scripts\utility::getfx("sq_plunge"), self, "tag_origin", self);
  } else {
    if(isalive(self)) {
      playergoliathnohelmet();
    }

    maps\mp\zombies\_util::playerallowfire(1, "sq");
    self notify("main_stage4_stop_shellshock");
    self stopshellshock();
    self.underwatermotiontype = undefined;
    common_scripts\utility::_enableoffhandweapons();
    self enableoffhandsecondaryweapons();
    self.movespeedscaler = self.oldmovescaler;
    self.oldmovescaler = undefined;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\mp_zombie_h2o_aud::sndunderwaterexit(self);
    killfxontag(common_scripts\utility::getfx("sq_bubbles"), self, "j_shoulder_ri");

    if(isDefined(self.bubblesfx)) {
      self.bubblesfx delete();
    }

    playfxontagforclients(common_scripts\utility::getfx("sq_emerge"), self, "tag_origin", self);
  }
}

playergoliathhelmet() {
  self detachall();

  if(level.currentgen) {
    self attach("sentinel_udt_strike_head_a");
  } else {
    self attach("head_hero_cormack_sentinel_halo");
  }

  self attach("npc_exo_armor_minigun_handle", "TAG_HANDLE");
}

playergoliathnohelmet() {
  self detachall();
  self attach(self.characterhead);
  self attach("npc_exo_armor_minigun_handle", "TAG_HANDLE");
}

playerhandleunderwatershellshock() {
  self endon("main_stage4_stop_shellshock");
  self endon("disconnect");

  for(;;) {
    self shellshock("underwater", 60, 0, 0);
    wait 59.5;
  }
}

teleportoutplayersinairlock(var_0) {
  if(isDefined(var_0) && !var_0 maps\mp\_utility::isjuggernaut()) {
    var_0 = undefined;
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_0) && var_0 == var_2) {
      continue;
    }
    if(maps\mp\zombies\_util::is_true(var_2.inairlock)) {
      var_2 playerteleportoutofairlock();
    }
  }
}

playerteleportoutofairlock() {
  self setorigin(self.lastgroundposition);
  self.inairlock = undefined;
  self.disabletombstonedropinarea = undefined;
}

monitorplayersinairlock(var_0, var_1) {
  level endon("main_stage4_stop_airlock_monitor");

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0) || var_3 istouching(var_1) || var_3 maps\mp\_utility::isjuggernaut() && isDefined(var_3.underwatermotiontype)) {
        var_3.inairlock = 1;
        var_3.disabletombstonedropinarea = 1;
        continue;
      }

      var_3.inairlock = undefined;
      var_3.disabletombstonedropinarea = 1;
    }

    waitframe();
  }
}

createairlockdoor(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = var_1[0];
  var_2.closedpos = var_2.origin;
  var_2.openpos = var_2.origin + (0, 0, 100);
  var_1[1] linktosynchronizedparent(var_2);
  var_0 linktosynchronizedparent(var_2);
  return var_2;
}

waittillactivatedwatervalve(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = common_scripts\utility::getstruct("sqWaterValve", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getent("sq_underwater_switch_off", "targetname");
  var_3 = getent("sq_underwater_switch_on", "targetname");
  var_1 maps\mp\zombies\_zombies_sidequests::fake_use("water_valve_used", undefined, undefined, "main_stage4_over");
  maps\mp\mp_zombie_h2o_aud::sndunderwaterpanelaccessed(var_1.origin);
  level thread announcerglobalplaysqvo(5, 1);
  stopclientexploder(70);
  activateclientexploder(71);

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 show();
  }

  return 1;
}

canplayercontinuestage4(var_0) {
  return isDefined(var_0) && isalive(var_0) && !maps\mp\zombies\_util::isplayerinlaststand(var_0);
}

isplayerinairlock(var_0, var_1, var_2) {
  return var_0 istouching(var_2) && !var_0 istouching(var_1);
}

waittillplayernotinairlock(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("enter_last_stand");
  var_4 = gettime() + 10000;

  for(;;) {
    if(!var_0 istouching(var_2) && !var_0 istouching(var_1)) {
      break;
    }

    if(var_3 && gettime() > var_4) {
      break;
    }

    waitframe();
  }
}

waittillplayerinairlock(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  var_0 endon("ejectedFromJuggernaut");
  var_0 endon("death");
  var_0 endon("enter_last_stand");
  var_4 = gettime() + 5000;

  for(;;) {
    if(maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress)) {
      break;
    }

    if(isplayerinairlock(var_0, var_1, var_2)) {
      break;
    }

    if(var_3 && gettime() > var_4) {
      break;
    }

    waitframe();
  }
}

closeairlockdoor(var_0) {
  playsoundatpos(var_0.origin, "trap_security_door_slam");
  var_0 moveto(var_0.closedpos, 0.1, 0.1);
  wait 0.2;
}

openairlockdoor(var_0) {
  playsoundatpos(var_0.origin, "interact_door");
  var_0 moveto(var_0.openpos, 1.0);
  wait 2.1;
}

activatedairlock(var_0) {
  var_1 = getent("sqAirlockUseTrigger", "targetname");
  var_2 = 40000;
  level thread doairlockhint(var_1);
  var_3 = undefined;

  for(;;) {
    var_1 waittill("trigger", var_3);

    if(var_3 maps\mp\_utility::isjuggernaut() && !maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress)) {
      break;
    }

    maps\mp\mp_zombie_h2o_aud::sndairlockdoorinteract(var_0.origin);
    wait 1;
  }

  level notify("main_stage4_airlock_activated");
  return var_3;
}

doairlockhint(var_0) {
  level endon("main_stage4_over");
  level endon("main_stage4_airlock_activated");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!var_1 maps\mp\_utility::isjuggernaut()) {
      var_2 = var_1 playerplaysqvo(5);

      if(var_2) {
        return;
      }
    }

    wait 1;
  }
}

stage4_end(var_0) {
  level.zmbbossteleportdelay = undefined;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Released the security clamp in the water");
}

stage5_init() {}

stage5_logic() {
  level thread announcerozglobalplaysq(20);

  if(shoulddelayforbossround()) {
    waituntilnextround();
  }

  waituntilnextround();
  level thread announcerozglobalplaysq(2);

  for(;;) {
    var_0 = 0;
    setomnvar("ui_zm_zone_identifier", 1);

    while(var_0 < 5) {
      var_1 = donextdrone(var_0, 5);

      if(var_1) {
        var_0++;
      } else {
        setomnvar("ui_zm_zone_identifier", 6);

        if(shoulddelayforbossround()) {
          waituntilnextround();
        }

        waituntilnextround();
        break;
      }

      wait 1;
    }

    level.sqplayedfindnextdronevo = undefined;

    if(var_0 == 5) {
      break;
    }
  }

  level thread announcerozglobalplaysq(16);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage5");
}

shoulddelayforbossround() {
  var_0 = level.wavecounter + 1;

  if(level.zmbsqinbossintermission) {
    var_0 = level.wavecounter;
  }

  return maps\mp\mp_zombie_h2o::isbossround(var_0);
}

waituntilnextround() {
  level waittill("zombie_wave_started");
}

donextdrone(var_0, var_1) {
  var_2 = startsqdrone(var_0);

  if(!isDefined(var_2)) {
    level thread announcerozglobalplaysq(17);

    if(isDefined(level.ammodrone2)) {
      level.ammodrone2 notify("disabled");
      waitframe();
      level.ammodrone2 maps\mp\zombies\zombie_ammo_drone::droneexplode();
    }
  } else if(!var_2) {
    level thread announcerozglobalplaysqfailchallenge();
  } else if(var_0 + 1 < var_1) {
    if(!maps\mp\zombies\_util::is_true(level.sqplayedfindnextdronevo)) {
      level thread announcerozglobalplaysq(23, 1.5);
      level.sqplayedfindnextdronevo = 1;
    }
  }

  return maps\mp\zombies\_util::is_true(var_2);
}

startsqdrone(var_0) {
  level endon("zombie_wave_ended");
  var_1 = maps\mp\zombies\zombie_ammo_drone::getstartzone();
  var_2 = randomint(var_1.ammodronespawnnodes.size);
  var_3 = var_1.ammodronespawnnodes[var_2];

  if(isDefined(level.ammodrone)) {
    if(var_3 == level.ammodrone.startnode) {
      if(var_2 == 0) {
        var_2++;
      } else {
        var_2--;
      }

      var_3 = var_1.ammodronespawnnodes[var_2];
    }
  }

  if(!isDefined(var_3)) {
    return;
  }
  maps\mp\_utility::incrementfauxvehiclecount();
  level.ammodrone2 = maps\mp\zombies\zombie_ammo_drone::spawnammodrone(var_3.origin, (0, 0, 0));

  if(!isDefined(level.ammodrone2)) {
    maps\mp\_utility::decrementfauxvehiclecount();
  } else {
    level.ammodrone2.health = getdronehealth(var_0);
    level.ammodrone2.speedoverride = 8 + var_0;
    level.ammodrone2.startnode = var_3;
    level.ammodrone2.startzone = var_1;
    level.ammodrone2.linegunignore = 1;
    level.ammodrone2.skipplayervo = 1;
    var_4 = maps\mp\zombies\zombie_ammo_drone::waittillactivate(level.ammodrone2, var_1);

    if(isDefined(var_4)) {
      var_4 playerplaysqfounddronevo();
    }

    var_5 = maps\mp\zombies\zombie_ammo_drone::getdestinationzone(var_1);
    var_6 = maps\mp\zombies\zombie_ammo_drone::getdestinationnode(var_5, var_3);
    level.ammodrone2.endnode = var_6;
    level.ammodrone2.endzone = var_5;
    level thread maps\mp\zombies\zombie_ammo_drone::droneactivate(level.ammodrone2, var_5, var_6, 0);
    var_7 = waittilldronecomplete(level.ammodrone2);
    level.ammodrone2 = undefined;
  }
}

playerplaysqfounddronevo() {
  var_0 = [7, 8, 9];
  playerplaysqvo(var_0[randomint(var_0.size)]);
}

waittilldronecomplete(var_0) {
  var_1 = var_0 common_scripts\utility::waittill_any_return("stopBeeping", "disabled");

  if(var_1 == "disabled") {
    return 1;
  } else {
    return 0;
  }
}

getdronehealth(var_0) {
  var_1 = 1;

  switch (var_0) {
    case 0:
      var_1 = 15;
      break;
    case 1:
      var_1 = 18.75;
      break;
    case 2:
      var_1 = 22.5;
      break;
    case 3:
      var_1 = 26.25;
    case 4:
    default:
      var_1 = 30;
      break;
  }

  var_2 = 2;

  if(level.players.size > 2) {
    var_2 = 3;
  }

  var_3 = int(1500 + var_1 * 200 * var_2);
  return var_3;
}

createchallengehud(var_0) {
  var_1 = newteamhudelem(level.playerteam);
  var_1.foreground = 1;
  var_1.sort = 2;
  var_1.hidewheninmenu = 0;
  var_1.alignx = "left";
  var_1.aligny = "bottom";
  var_1.horzalign = "left";
  var_1.vertalign = "bottom";
  var_1.font = "small";
  var_1.fontscale = 1.5;
  var_1.x = 120;
  var_1.y = -70;
  var_1.alpha = 1;
  var_1.color = (1, 0, 0);
  var_1 settext(var_0);
  return var_1;
}

stage5_end(var_0) {
  level thread dochallengehudcomplete();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 1 - Drones");
}

dochallengehudactive() {
  level.zmbsqchallengehud.color = (1, 0, 0);
}

dochallengehudinactive() {
  level.zmbsqchallengehud.color = (0.5, 0.5, 0.5);
}

dochallengehudcomplete() {
  setomnvar("ui_zm_zone_identifier", 7);
}

stage7_init() {}

stage7_logic() {
  var_0 = getent("sqCapacitorCover", "targetname");
  var_1 = common_scripts\utility::getstruct("sqCapacitors", "targetname");
  var_2 = common_scripts\utility::getstruct("sqCapacitorFx", "targetname");
  var_3 = getEntArray("sqCapacitorMeter", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level thread launchcover(var_0, var_1);
  runchargecapacitorlogic(var_1, var_2, var_3);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage7");
}

initcapacitors() {
  var_0 = getEntArray("sqCapacitorMeter", "targetname");
  common_scripts\utility::array_thread(var_0, ::capacitormetersinit);
}

capacitormetersinit() {
  var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0) {
    switch (var_2.script_noteworthy) {
      case "end":
        self.end = var_2.origin;
        break;
      case "start":
        self.origin = var_2.origin;
        break;
      default:
        break;
    }
  }

  self.start = self.origin;
}

launchcover(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles) * 2000;
  var_0 physicslaunchclient(var_0.origin, var_2);
  playFX(common_scripts\utility::getfx("sq_capacitor_cover_blown_off"), var_1.origin);
  maps\mp\mp_zombie_h2o_aud::sndcapacitorcoverblownoff(var_1.origin);
  var_0 common_scripts\utility::waittill_notify_or_timeout("physics_finished", 4);
  var_0 physicsstop();
  wait 20;
  var_0 delete();
}

runchargecapacitorlogic(var_0, var_1, var_2) {
  var_3 = 32400;
  var_4 = 15;
  var_5 = 0;
  activatepersistentclientexploder(85);

  while(var_4 > 0) {
    level waittill("zmb_emz_attack", var_6, var_7, var_8);
    var_9 = distancesquared(var_7, var_0.origin);

    if(var_9 < var_3) {
      playFX(common_scripts\utility::getfx("sq_emz_explode"), var_6.origin + (0, 0, 30));
      activateclientexploder(51);

      if(isalive(var_6)) {
        if(isscriptedagent(var_6) && !var_6 maps\mp\agents\humanoid\_humanoid_util::iscrawling() && isDefined(var_6.agent_type) && var_6.agent_type != "zombie_dog") {
          level thread electrocutezombie(var_6, var_0);
        } else {
          var_6 dodamage(var_6.health, var_6.origin);
        }
      }

      if(!var_5) {
        var_5 = 1;
        level thread announcerglobalplaysqvowaittilldone(14, 1.5);
      }

      var_4--;
      thread maps\mp\mp_zombie_h2o_aud::sndcapacitorcharging(15 - var_4);

      foreach(var_11 in var_2) {
        var_12 = (15 - var_4) / 15;
        var_13 = (var_11.end - var_11.start) * var_12 + var_11.start;
        var_11 moveto(var_13, 0.1);
      }
    }
  }

  wait 1;
  stopclientexploder(85);
  activateclientexploder(50);
  thread maps\mp\mp_zombie_h2o_aud::sndcapacitorchargedsuccess(var_1);
  announcerglobalplaysqvowaittilldone(15, 1);
  announcerglobalplaysqvowaittilldone(6, 0.5);
}

electrocutezombie(var_0, var_1) {
  var_0 endon("death");
  var_0 scragentsetanimmode("anim deltas");
  var_0 scragentsetanimscale(1, 1);
  var_0 scragentsetphysicsmode("no_gravity");
  var_0 scragentsetorientmode("face angle abs", var_0.angles);
  var_2 = "sq_electrocute";
  var_3 = var_0 getanimentrycount(var_2);
  var_4 = angleclamp180(var_0.angles[1] - var_1.angles[1]);
  var_5 = 1;

  if(abs(var_4) < 45) {
    var_5 = 0;
  } else if(var_4 > -135 && var_4 < 0) {
    var_5 = 3;
  } else if(var_4 < 135 && var_4 > 0) {
    var_5 = 2;
  }

  var_0.skipmutilate = 1;
  var_0.ragdollimmediately = 1;
  var_0.godmode = 1;

  if(isDefined(var_0.swapbody)) {
    var_0 setModel(var_0.swapbody);
  }

  var_0 notify("humanoidPendingDeath");
  var_0 scragentsetscripted(1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "sq_electrocute");
  var_0 thread maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_2, var_5, 1.0, "scripted_anim");
  wait 1.5;
  var_0.godmode = 0;
  var_0 dodamage(var_0.health, var_0.origin);
}

stage7_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Capacitors charged");
}

stage8_init() {}

stage8_logic() {
  level thread announcerozglobalplaysq(21);

  if(shoulddelayforbossround()) {
    waituntilnextround();
  }

  waituntilnextround();
  level thread playstage8startvo();
  setomnvar("ui_zm_zone_identifier", 2);

  foreach(var_1 in level.players) {
    var_1 thread playerhandleweaponsstage8();
  }

  level thread onplayerconnectstage8();
  level thread handlefeaturesstage8();
  waituntilnextround();
  var_3 = getteamplayersalive(level.playerteam);

  if(var_3 > 0) {
    maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage8");
  }
}

playstage8startvo() {
  announcerozglobalplaysqwaittilldone(11);
  getanyplayer(1) playerplaysqvo(11);
}

handlefeaturesstage8() {
  maps\mp\zombies\_util::disablekillstreaks();
  maps\mp\zombies\_util::disablepickups();
  maps\mp\zombies\_util::disablewallbuys();
  maps\mp\zombies\_traps::trap_deactivate_all();
  setomnvar("ui_zm_ee_int2", 2);
  level waittill("main_stage8_over");
  setomnvar("ui_zm_ee_int2", 0);
  maps\mp\zombies\_util::enablekillstreaks();
  maps\mp\zombies\_util::enablepickups();
  maps\mp\zombies\_util::enablewallbuys();
  maps\mp\zombies\_traps::trap_reactivate_all();
}

playerhandleweaponsstage8() {
  self endon("disconnect");

  if(maps\mp\_utility::isjuggernaut()) {
    self dodamage(self.mechhealth, self.origin);
    wait 1;
  }

  self notify("stop_useHoldThinkLoop");
  removeweaponsstage8();
  thread playerinfinitegrenadesstage8();
  waituntilnextround();

  if(!isalive(self) || maps\mp\zombies\_util::isplayerinlaststand(self)) {
    return;
  }
  restoreweaponsstage8();
}

playerinfinitegrenadesstage8() {
  level endon("main_stage8_over");
  var_0 = self getweaponslistoffhands();

  foreach(var_2 in var_0) {
    var_3 = weaponmaxammo(var_2);
    self setweaponammoclip(var_2, var_3);
  }

  for(;;) {
    self waittill("grenade_fire", var_5, var_2);
    var_3 = weaponmaxammo(var_2);
    self setweaponammoclip(var_2, var_3);
  }
}

onplayerconnectstage8() {
  level endon("main_stage8_over");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedstage8();
  }
}

onplayerspawnedstage8() {
  level endon("main_stage8_over");
  self waittill("spawned_player");
  thread playerhandleweaponsstage8();
}

removeweaponsstage8() {
  playergivecontactgrenade();
  maps\mp\zombies\_util::playerallowfire(0, "sq");
  self disableoffhandsecondaryweapons();
  common_scripts\utility::_disableweaponswitch();
}

playergivecontactgrenade() {
  var_0 = playergetcontactgrenade();

  if(isDefined(var_0)) {
    self.hadcontactgrenade = 1;
  } else {
    self.hadcontactgrenade = 0;
    maps\mp\zombies\_wall_buys::givezombieequipment(self, "contact_grenade_zombies_mp", 0);
  }
}

playergetcontactgrenade() {
  var_0 = self getweaponslistoffhands();

  foreach(var_2 in var_0) {
    var_3 = getweaponbasename(var_2);

    if(var_3 == "contact_grenade_zombies_mp" || var_3 == "contact_grenade_throw_zombies_mp") {
      return var_2;
    }
  }
}

playertakecontactgrenade() {
  if(!self.hadcontactgrenade) {
    maps\mp\zombies\_wall_buys::givezombieequipment(self, "frag_grenade_zombies_mp", 0);
  }

  self.hadcontactgrenade = undefined;
}

isweaponswitchenabled_duplicate() {
  return !self.disabledweaponswitch;
}

restoreweaponsstage8() {
  playertakecontactgrenade();
  maps\mp\zombies\_util::playerallowfire(1, "sq");
  self enableoffhandsecondaryweapons();

  if(!isweaponswitchenabled_duplicate()) {
    common_scripts\utility::_enableweaponswitch();
  }
}

stage8_end(var_0) {
  level thread dochallengehudcomplete();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 2 - Grenades");
}

stage9_init() {
  if(!level.jumpquest.init) {
    return;
  }
  jumpquest_setstage(1);
}

stage9_logic() {
  if(level.jumpquest.init) {
    common_scripts\utility::flag_wait("jumpQuest_final_stage_complete");
    maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage9");
  }
}

stage9_end(var_0) {
  if(level.jumpquest.init) {
    jumpquest_setstage(0);
    level thread announcerglobalplaysqvo(6, 0.5);
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed jumping puzzle");
}

jumpquest_init() {
  level.jumpquest = spawnStruct();
  level.jumpquest.init = 0;
  common_scripts\utility::flag_init("jumpQuest_final_stage_complete");
  level.jumpquest.refloc = common_scripts\utility::getstruct("jumpQuest_ref", "targetname");

  if(!isDefined(level.jumpquest.refloc)) {
    return;
  }
  jumpquest_initgoal();
  jumpquest_initplatforms();
  jumpquest_initstages();
  jumpquest_initreset();
  jumpquest_initfx();
  level.jumpquest.init = 1;
  jumpquest_arrangeplatforms("default", 0);
  level thread jumpquest_run();
}

jumpquest_initgoal() {
  level.jumpquest.goal = getent("jumpQuest_goal", "targetname");
  level.jumpquest.goal.angles = common_scripts\utility::getstruct(level.jumpquest.goal.target, "targetname").angles;
}

jumpquest_initreset() {
  level.jumpquest.resetlocs = common_scripts\utility::getstructarray("jumpQuest_reset_loc", "targetname");
  var_0 = getEntArray("jumpQuest_reset_trigger", "targetname");

  foreach(var_2 in var_0) {
    level.jumpquest thread jumpquest_reset(var_2);
  }

  var_4 = getEntArray("jumpQuest_reset_clip", "targetname");

  foreach(var_6 in var_4) {
    level.jumpquest thread jumpquest_reset_clip(var_6);
  }
}

jumpquest_initfx() {
  level._effect["jump_quest_goal"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_jumping_goal");
}

jumpquest_initplatforms() {
  level.jumpquest.platformstandtime = 3;
  level.jumpquest.platformresettime = 3;
  level.jumpquest.platforms = getEntArray("jumpQuest_platform", "targetname");

  foreach(var_1 in level.jumpquest.platforms) {
    var_1.noteleportgrenade = 1;
    var_1.unresolved_collision_func = ::jumpquestunresolvedcollision;
    var_1.visuals = getEntArray(var_1.target, "targetname");

    foreach(var_3 in var_1.visuals) {
      var_3 linkto(var_1);
      var_3.noteleportgrenade = 1;
    }

    var_1.fxtype = "sm";

    if(issubstr(var_1.script_noteworthy, "medium")) {
      var_1.fxtype = "med";
    } else if(issubstr(var_1.script_noteworthy, "large")) {
      var_1.fxtype = "large";
    }

    var_1.angles = common_scripts\utility::getstruct(var_1.target, "targetname").angles;
    var_1 thread jumpquest_platformwatch();
  }
}

jumpquest_platformplayertouch() {
  level.jumpquest endon("reset");

  if(self.visuals.size > 0) {
    var_0 = level.jumpquest.platformstandtime / 3;

    foreach(var_2 in self.visuals) {
      var_2 hudoutlineenable(1, 1);
    }

    wait(var_0);

    foreach(var_2 in self.visuals) {
      var_2 hudoutlineenable(4, 1);
    }

    wait(var_0);

    foreach(var_2 in self.visuals) {
      var_2 hudoutlineenable(0, 1);
    }

    wait(var_0);
  } else {
    wait(level.jumpquest.platformstandtime);
  }

  self notsolid();
  self ghost();

  foreach(var_2 in self.visuals) {
    var_2 ghost();
  }

  wait(level.jumpquest.platformresettime);

  while(!jumpquest_allplayersoffplatforms()) {
    waitframe();
  }
}

jumpquest_platformwatch() {
  for(;;) {
    while(!jumpquest_anyplayeronplatform(self)) {
      waitframe();
    }

    jumpquest_platformplayertouch();
    self solid();
    self show();

    foreach(var_1 in self.visuals) {
      var_1 hudoutlinedisable();
      var_1 show();
    }
  }
}

jumpquest_allplayersoffplatforms() {
  foreach(var_1 in level.players) {
    if(!maps\mp\_utility::isreallyalive(var_1)) {
      continue;
    }
    var_2 = var_1 getgroundentity();

    if(!isDefined(var_2)) {
      return 0;
    }

    foreach(var_4 in level.jumpquest.platforms) {
      if(var_4 == var_2) {
        return 0;
      }
    }
  }

  return 1;
}

jumpquest_anyplayeronplatform(var_0) {
  if(!isDefined(level.players)) {
    return 0;
  }

  foreach(var_2 in level.players) {
    if(!maps\mp\_utility::isreallyalive(var_2)) {
      continue;
    }
    var_3 = var_2 getgroundentity();

    if(isDefined(var_3) && var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

jumpquest_moveplatform(var_0, var_1, var_2) {
  var_0 notify("move");
  var_0 endon("move");
  var_3 = (0, 0, -800);
  var_4 = 0;
  var_5 = var_1.origin;

  if(var_5 != var_0.origin) {
    var_6 = trajectorycalculateinitialvelocity(var_0.origin, var_5, var_3, var_2);
    var_0 movegravity(var_6, var_2);
    var_4 = 1;
  }

  var_7 = var_1.angles;

  if(anglesdelta(var_7, var_0.angles) > 0 || var_4) {
    var_8 = randomintrange(-2, 2) * 360 + angleclamp180(var_7[0] - var_0.angles[0]);
    var_9 = randomintrange(-2, 2) * 360 + angleclamp180(var_7[1] - var_0.angles[1]);
    var_10 = randomintrange(-2, 2) * 360 + angleclamp180(var_7[2] - var_0.angles[2]);
    var_11 = 2 * (var_8, var_9, var_10) / var_2;
    var_0 rotatevelocity(var_11, var_2, 0, var_2);
    var_4 = 1;
  }

  if(!var_4) {
    return;
  }
  level thread jumpquest_platformsplash(var_0);
  wait(var_2);
  maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzleplatformlock(var_1.origin);
  jumpquest_setplatform(var_0, var_1);
}

jumpquest_setplatform(var_0, var_1) {
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
}

jumpquest_platformsplash(var_0) {
  var_1 = 680;

  if(var_0.origin[2] < var_1) {
    while(var_0.origin[2] < var_1) {
      waitframe();
    }
  } else {
    while(var_0.origin[2] > var_1) {
      waitframe();
    }
  }

  var_2 = "h2o_ee_wave_hit_" + var_0.fxtype;
  var_3 = (var_0.origin[0], var_0.origin[1], var_1);
  playFX(common_scripts\utility::getfx(var_2), var_3);
}

jumpquest_initstages() {
  level.jumpquest.stages = [];
  jumpquest_initstage("default", (2308, 0, -104), (0, 0, 0));
  jumpquest_initstageplatform("default", "small_01", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "small_02", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "small_03", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "medium_01", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "medium_02", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "medium_03", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "large_01", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "large_02", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstageplatform("default", "large_03", (2308, 0, -140), (0, 0, 0));
  jumpquest_initstage("stage_1", (480, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_1", "medium_01", (96, 0, 0), (0, 0, 0));
  jumpquest_initstageplatform("stage_1", "medium_02", (480, 0, 0), (0, 0, 0));
  jumpquest_initstage("stage_2", (1088, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_2", "medium_01", (96, 0, 0), (0, 0, 0));
  jumpquest_initstageplatform("stage_2", "small_01", (592, 0, 0), (0, 0, 0));
  jumpquest_initstageplatform("stage_2", "medium_02", (1088, 0, 0), (0, 0, 0));
  jumpquest_initstage("stage_3", (1088, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_3", "medium_01", (96, 0, 0), (0, 0, 0));
  jumpquest_initstageplatform("stage_3", "medium_02", (1088, 0, 0), (0, 0, 0));
  jumpquest_initstage("stage_4", (408, 0, 16), (0, 0, 0));
  jumpquest_initstageplatform("stage_4", "medium_01", (196, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_4", "large_01", (300, 0, 192), (0, 270, 90));
  jumpquest_initstageplatform("stage_4", "medium_02", (404, 0, 8), (0, 0, 0));
  jumpquest_initstage("stage_5", (1120, 0, 784), (0, 0, 0));
  jumpquest_initstageplatform("stage_5", "medium_01", (96, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_5", "small_01", (384, 64, 200), (0, 0, 0));
  jumpquest_initstageplatform("stage_5", "small_02", (608, -64, 392), (0, 0, 0));
  jumpquest_initstageplatform("stage_5", "small_03", (832, 64, 584), (0, 0, 0));
  jumpquest_initstageplatform("stage_5", "medium_02", (1120, 0, 776), (0, 0, 0));
  jumpquest_initstage("stage_6", (1556, 0, 16), (0, 0, 0));
  jumpquest_initstageplatform("stage_6", "medium_01", (96, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_6", "small_01", (160, 0, 208), (0, 0, 0));
  jumpquest_initstageplatform("stage_6", "small_02", (160, 0, 408), (0, 0, 0));
  jumpquest_initstageplatform("stage_6", "small_03", (160, 0, 608), (0, 0, 0));
  jumpquest_initstageplatform("stage_6", "large_01", (544, 0, 800), (0, 0, 0));
  jumpquest_initstageplatform("stage_6", "medium_02", (1556, 0, 8), (0, 0, 0));
  jumpquest_initstage("stage_7", (928, 0, 16), (0, 0, 0));
  jumpquest_initstageplatform("stage_7", "medium_01", (96, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_7", "small_01", (928, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_7", "large_01", (768, -30, 192), (0, 0, 90));
  jumpquest_initstageplatform("stage_7", "large_02", (768, 30, 192), (0, 0, 90));
  jumpquest_initstage("stage_8", (1792, 0, 66), (0, 0, 0));
  jumpquest_initstageplatform("stage_8", "large_01", (192, 0, -102), (0, 0, 90));
  jumpquest_initstageplatform("stage_8", "large_02", (724, -30, 46), (0, 0, 90));
  jumpquest_initstageplatform("stage_8", "large_03", (1308, 30, -62), (0, 0, 90));
  jumpquest_initstageplatform("stage_8", "medium_01", (724, -30, 334), (0, 0, 90));
  jumpquest_initstageplatform("stage_8", "medium_02", (1792, 0, 58), (0, 0, 0));
  jumpquest_initstageplatform("stage_8", "small_01", (724, -30, 462), (0, 0, 90));
  jumpquest_initstageplatform("stage_8", "small_02", (1216, 30, 162), (0, 0, 90));
  jumpquest_initstageplatform("stage_8", "small_03", (1420, 30, 162), (0, 0, 90));
  jumpquest_initstage("stage_9", (192, 0, 976), (0, 0, 0));
  jumpquest_initstageplatform("stage_9", "large_01", (192, 0, 8), (0, 0, 0));
  jumpquest_initstageplatform("stage_9", "small_01", (192, 0, 200), (0, 0, 0));
  jumpquest_initstageplatform("stage_9", "medium_01", (192, 0, 392), (0, 0, 0));
  jumpquest_initstageplatform("stage_9", "large_02", (192, 0, 584), (0, 0, 0));
  jumpquest_initstageplatform("stage_9", "medium_02", (192, 0, 776), (0, 0, 0));
  jumpquest_initstageplatform("stage_9", "small_02", (192, 0, 968), (0, 0, 0));
  level.jumpquest.stageorder = ["stage_1", "stage_2", "stage_3", "stage_4", "stage_5", "stage_6", "stage_7", "stage_8", "stage_9"];
  jumpquest_setstage(0);
}

jumpquest_arrangeplatforms(var_0, var_1) {
  level.jumpquest notify("setStage");
  level.jumpquest endon("setStage");
  var_2 = level.jumpquest.stages[var_0];
  var_3 = level.jumpquest.stages["default"];
  var_4 = -1;

  foreach(var_6 in level.jumpquest.platforms) {
    var_7 = var_6.script_noteworthy;
    var_8 = var_2.platforms[var_7];

    if(!isDefined(var_8)) {
      var_8 = var_3.platforms[var_7];
    }

    var_9 = distance(var_6.origin, var_8.origin);

    if(var_9 > var_4) {
      var_4 = var_9;
    }

    var_6.arrangeloc = var_8;
    var_6.arrangedist = var_9;
  }

  foreach(var_6 in level.jumpquest.platforms) {
    if(var_4 <= 0) {
      var_12 = var_1;
    } else {
      var_12 = var_6.arrangedist / var_4 * var_1;
    }

    if(var_12 > 0) {
      thread jumpquest_moveplatform(var_6, var_6.arrangeloc, var_12);
      continue;
    }

    thread jumpquest_setplatform(var_6, var_6.arrangeloc);
  }

  level thread maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzleplatformwhoosh();
  level.jumpquest.goal.origin = var_2.goal.origin + (0, 0, 40);
  level.jumpquest.goal.angles = var_2.goal.angles;
}

jumpquest_run() {
  var_0 = 3;

  for(;;) {
    while(level.jumpquest.stagecurrent <= 0) {
      level.jumpquest waittill("stage_change");
    }

    var_1 = level.jumpquest.stageorder[level.jumpquest.stagecurrent - 1];
    jumpquest_arrangeplatforms(var_1, var_0);
    wait(var_0 + 0.05);
    var_2 = spawnfx(common_scripts\utility::getfx("jump_quest_goal"), level.jumpquest.goal.origin, anglestoup(level.jumpquest.goal.angles), anglestoright(level.jumpquest.goal.angles));
    triggerfx(var_2);
    setfxkillondelete(var_2, 1);
    var_3 = jumpquest_waitforgoal();

    if(isDefined(var_3)) {
      thread maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzlesucess(var_3);
      jumpquest_setstage(level.jumpquest.stagecurrent + 1);

      if(common_scripts\utility::flag("jumpQuest_final_stage_complete")) {
        var_3 thread playerplaysqvo(10);
      } else {
        var_3 thread playerplaysqvo(undefined, 1, 0, "sq_jump_win");
      }

      jumpquest_resetplayer(var_3, 0);
    }

    var_2 delete();
    level.jumpquest notify("reset");
    jumpquest_arrangeplatforms("default", var_0);
    wait(var_0 + 0.05);
    wait 1;
  }
}

jumpquest_setstage(var_0) {
  if(!isDefined(level.jumpquest.stagecurrent) || level.jumpquest.stagecurrent != var_0) {
    level.jumpquest.stagecurrent = var_0;

    if(level.jumpquest.stagecurrent > level.jumpquest.stageorder.size) {
      level.jumpquest.stagecurrent = 0;
      common_scripts\utility::flag_set("jumpQuest_final_stage_complete");
    }

    level.jumpquest notify("stage_change");
  }
}

jumpquest_initstage(var_0, var_1, var_2) {
  level.jumpquest.stages[var_0] = spawnStruct();
  level.jumpquest.stages[var_0].platforms = [];
  level.jumpquest.stages[var_0].goal = jumpquest_createloc(var_1, var_2, level.jumpquest.refloc);
}

jumpquest_initstageplatform(var_0, var_1, var_2, var_3) {
  var_4 = jumpquest_createloc(var_2, var_3, level.jumpquest.refloc, var_0);
  level.jumpquest.stages[var_0].platforms[var_1] = var_4;
}

jumpquest_createloc(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;

  if(isDefined(var_2)) {
    var_4.origin = rotatevector(var_4.origin, var_2.angles) + var_2.origin;
  }

  var_4.angles = var_1;

  if(isDefined(var_2)) {
    var_4.angles = var_4.angles + var_2.angles;
  }

  var_4.stagename = var_3;
  return var_4;
}

jumpquest_waitforgoal() {
  level.jumpquest endon("stage_change");

  for(;;) {
    level.jumpquest.goal waittill("trigger", var_0);
    return var_0;
  }
}

jumpquest_reset_clip(var_0) {
  var_1 = var_0 setcontents(0);

  for(;;) {
    if(level.jumpquest.stagecurrent <= 0) {
      var_0 notsolid();
    } else {
      var_0 solid();
      var_0 setcontents(var_1);
    }

    level.jumpquest waittill("stage_change");
  }
}

jumpquest_reset(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(level.jumpquest.stagecurrent > 0) {
      jumpquest_resetplayer(var_1, 1);
    }
  }
}

jumpquest_resetplayer(var_0, var_1) {
  if(var_1) {
    if(!maps\mp\zombies\_util::is_true(level.zmbsqplayedjumpfailvo)) {
      level.zmbsqplayedjumpfailvo = 1;
      level thread announcerozglobalplaysq(26);
    } else {
      var_0 thread playerplaysqvo(undefined, 1, 0, "sq_jump_fail");
    }
  }

  thread jumpquest_bounceresetplayer(var_0);
}

jumpquest_bounceresetplayer(var_0) {
  if(var_0 islinked()) {
    return;
  }
  var_0 thread maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzleplayerwhoosh();
  var_1 = jumpquest_getresetloc(var_0);
  var_2 = distance2d(var_0.origin, var_1.origin);
  var_3 = clamp(var_2 / 1500, 0, 1) * 1.5 + 1;
  var_4 = trajectorycalculateinitialvelocity(var_0.origin, var_1.origin, (0, 0, -800), var_3);
  var_5 = spawn("script_model", var_0.origin);
  var_5 setModel("tag_origin");
  var_0 playerlinkto(var_5, "tag_origin");
  var_5 movegravity(var_4, var_3);
  wait(var_3);
  var_5.origin = var_1.origin;
  waitframe();

  if(isDefined(var_0)) {
    var_0 unlink();
  }

  var_5 delete();
}

jumpquest_getresetloc(var_0) {
  level.jumpquest.resetlocs = sortbydistance(level.jumpquest.resetlocs, var_0.origin);
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level.jumpquest.resetlocs) {
    var_5 = 0;

    foreach(var_7 in level.characters) {
      if(var_7.team == var_0.team) {
        continue;
      }
      var_8 = distance2d(var_4.origin, var_7.origin);

      if(var_8 < 100) {
        var_5++;
      }
    }

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

jumpquestunresolvedcollision(var_0) {
  jumpquest_resetplayer(var_0, 1);
}

stage14_init() {}

stage14_logic() {
  level thread announcerozglobalplaysq(20);

  if(shoulddelayforbossround()) {
    waituntilnextround();
  }

  waituntilnextround();
  level thread playstage14startvo();
  setomnvar("ui_zm_zone_identifier", 5);

  foreach(var_1 in level.players) {
    var_1 thread playerhandleweaponsstage14();
  }

  level thread onplayerconnectstage14();
  level thread handlefeaturesstage14();
  waituntilnextround();
  var_3 = getteamplayersalive(level.playerteam);

  if(var_3 > 0) {
    maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage14");
  }
}

playstage14startvo() {
  announcerozglobalplaysqwaittilldone(12);
  getanyplayer(1) playerplaysqvo(12);
}

handlefeaturesstage14() {
  maps\mp\zombies\_util::disablekillstreaks();
  maps\mp\zombies\_util::disablepickups();
  maps\mp\zombies\_util::disablewallbuys();
  level.dotombstoneweaponswitch = 0;
  level.customreplaceweaponfunc = ::stage14customreplaceweaponfunc;
  maps\mp\zombies\_traps::trap_deactivate_all();
  setomnvar("ui_zm_ee_int2", 1);
  level waittill("main_stage14_over");
  setomnvar("ui_zm_ee_int2", 0);
  maps\mp\zombies\_util::enablekillstreaks();
  maps\mp\zombies\_util::enablepickups();
  maps\mp\zombies\_util::enablewallbuys();
  level.dotombstoneweaponswitch = undefined;
  level.customreplaceweaponfunc = undefined;
  maps\mp\zombies\_traps::trap_reactivate_all();
}

stage14customreplaceweaponfunc(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  if(var_1.size > 2) {
    var_2 = var_0 playergetmahem();

    if(var_1[0] != var_2) {
      return var_1[0];
    }

    foreach(var_4 in var_1) {
      if(var_4 != var_2) {
        return var_4;
      }
    }
  }

  return "none";
}

playerhandleweaponsstage14() {
  self endon("disconnect");

  if(maps\mp\_utility::isjuggernaut()) {
    self dodamage(self.mechhealth, self.origin);
    wait 1;
  }

  self notify("stop_useHoldThinkLoop");
  var_0 = playerwaittilllaststandcomplete();

  if(maps\mp\zombies\_util::is_true(var_0) && isalive(self)) {
    removeweaponsstage14();
    thread playerinfiniterocketsstage14();
    waituntilnextround();

    if(!isalive(self) || maps\mp\zombies\_util::isplayerinlaststand(self)) {
      return;
    }
    restoreweaponsstage14();
  }
}

playerwaittilllaststandcomplete() {
  if(maps\mp\zombies\_util::isplayerinlaststand(self)) {
    self endon("death");
    level endon("zombie_wave_started");
    self waittill("revive");
    waitframe();
  }

  return 1;
}

playerinfiniterocketsstage14() {
  level endon("main_stage14_over");
  var_0 = playergetmahem();
  var_1 = weaponmaxammo(var_0);

  for(;;) {
    self waittill("reload");
    self setweaponammostock(var_0, var_1);
  }
}

onplayerconnectstage14() {
  level endon("main_stage14_over");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedstage14();
  }
}

onplayerspawnedstage14() {
  level endon("main_stage14_over");
  self waittill("spawned_player");
  thread playerhandleweaponsstage14();
}

removeweaponsstage14() {
  playergivemahem();
  common_scripts\utility::_disableoffhandweapons();
  self disableoffhandsecondaryweapons();
  common_scripts\utility::_disableweaponswitch();
}

playergivemahem() {
  maps\mp\zombies\_zombies_laststand::savelaststandweapons("", 0);
  self.scriptedtombstoneweapon = self.tombstoneweapon;
  self.scriptedtombstoneweaponlevel = self.tombstoneweaponlevel;
  var_0 = playergetmahem();

  if(isDefined(var_0)) {
    self.hadmahem = 1;
    self switchtoweapon(var_0);

    if(isDefined(self.weaponstate["iw5_mahemzm_mp"]["level"]) && self.weaponstate["iw5_mahemzm_mp"]["level"] < 10) {
      self.oldmahemweaponlevel = self.weaponstate["iw5_mahemzm_mp"]["level"];
      setweaponlevelallowthird(self, var_0, 10);
    }
  } else {
    self.hadmahem = 0;
    givezombieweaponallowthird(self, "iw5_mahemzm_mp");
    setweaponlevelallowthird(self, "iw5_mahemzm_mp", 25);
  }
}

givezombieweaponallowthird(var_0, var_1) {
  maps\mp\gametypes\zombies::createzombieweaponstate(var_0, var_1);
  var_0 maps\mp\_utility::_giveweapon(var_1);
  var_0 givemaxammo(var_1);
  var_0 maps\mp\zombies\_wall_buys::givemaxscriptedammo(var_1);
  var_0 switchtoweaponimmediate(var_1);
}

setweaponlevelallowthird(var_0, var_1, var_2) {
  var_0 takeweapon(var_1);
  var_3 = getweaponbasename(var_1);
  var_0.weaponstate[var_3]["level"] = var_2;
  var_4 = maps\mp\zombies\_wall_buys::getupgradeweaponname(var_0, var_3);
  givezombieweaponallowthird(var_0, var_4);

  if(issubstr(var_4, "iw5_em1zm_mp")) {
    var_0 maps\mp\gametypes\zombies::playersetem1maxammo();
  }

  if(isDefined(level.setweaponlevelfunc)) {
    var_0[[level.setweaponlevelfunc]](var_1, var_2);
  }
}

playergetmahem() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = getweaponbasename(var_2);

    if(var_3 == "iw5_mahemzm_mp") {
      return var_2;
    }
  }
}

playertakemahem() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = getweaponbasename(var_2);

    if(var_3 == "iw5_mahemzm_mp") {
      if(self.hadmahem) {
        if(isDefined(self.oldmahemweaponlevel)) {
          maps\mp\zombies\_wall_buys::setweaponlevel(self, var_2, self.oldmahemweaponlevel);
        }
      } else {
        self.weaponstate[var_3]["level"] = 1;
        self takeweapon(var_2);
        var_0 = self getweaponslistprimaries();

        if(var_0.size > 0) {
          self switchtoweapon(var_0[0]);
        }
      }

      break;
    }
  }

  playerclearmahemdata();
}

playerclearmahemdata() {
  self.hadmahem = undefined;
  self.oldmahemweaponlevel = undefined;
  self.scriptedtombstoneweapon = undefined;
  self.scriptedtombstoneweaponlevel = undefined;
}

restoreweaponsstage14() {
  playertakemahem();

  if(!common_scripts\utility::isoffhandweaponenabled()) {
    common_scripts\utility::_enableoffhandweapons();
  }

  self enableoffhandsecondaryweapons();

  if(!isweaponswitchenabled_duplicate()) {
    common_scripts\utility::_enableweaponswitch();
  }
}

delayclearmahemdata() {
  waitframe();

  foreach(var_1 in level.players) {
    var_1 playerclearmahemdata();
  }
}

stage14_end(var_0) {
  level thread dochallengehudcomplete();
  level thread delayclearmahemdata();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 5 - Mahem");
}

stage11_init() {}

stage11_logic() {
  var_0 = common_scripts\utility::getstructarray("sqLightPuzzle", "targetname");

  if(var_0.size == 0) {
    return;
  }
  var_0 = common_scripts\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_1;
    var_3 = var_1 + 1;
    var_4 = var_0[var_1];
    setuplight(var_4, var_2, var_3);
  }

  setuplightlooping(var_0[0], 0);
  wait 1;

  for(;;) {
    var_0[0] lightloopingon();
    var_0[0] maps\mp\zombies\_zombies_sidequests::fake_use("light_puzzle_on", undefined, undefined, "main_stage11_over", 80);
    var_5 = dolightpuzzle(var_0);

    if(var_5) {
      break;
    }

    wait 2;
  }

  announcerglobalplaysqvowaittilldone(6, 0.5);
  unlockspecialweaponupgrade();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage11");
}

setuplight(var_0, var_1, var_2) {
  var_0.index = var_1;
  var_0.sound = "ee_puzzle_beep" + var_2;
  var_0.fx = spawnfx(common_scripts\utility::getfx("sq_light_puzzle_" + var_1), var_0.origin);
}

setuplightlooping(var_0, var_1) {
  var_0.fxlooping = spawnfx(common_scripts\utility::getfx("sq_light_puzzle_loop"), var_0.origin);
  triggerfx(var_0.fxlooping);
}

lightloopingon() {
  self.fxlooping show();
}

lightloopingoff() {
  self.fxlooping hide();
}

lightturnon() {
  triggerfx(self.fx);
}

dolightpuzzle(var_0) {
  var_0[0] lightloopingoff();
  var_1 = generatelightpuzzlepattern(var_0);
  wait 1.5;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = calculatetimeon(var_2);
    playlightsequence(var_2, var_1, var_3);
    var_4 = waittillplayersactivatesequence(var_2, var_0, var_1);

    if(!var_4) {
      maps\mp\mp_zombie_h2o_aud::sndlightpuzzlefail();

      if(!maps\mp\zombies\_util::is_true(level.zmbsqplayedlightpuzzlefail)) {
        level thread announcerozglobalplaysq(28, 1.5);
        level.zmbsqplayedlightpuzzlefail = 1;
      }

      return 0;
    }

    wait 1.5;
  }

  wait 1;
  maps\mp\mp_zombie_h2o_aud::sndlightpuzzlesuccess();
  return 1;
}

calculatetimeon(var_0) {
  var_1 = 1.5;

  if(var_0 > 0) {
    var_2 = 1.0;
    var_3 = var_2 / 8;
    var_1 = var_1 - var_3 * var_0;
  }

  return var_1;
}

playlightsequence(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 <= var_0; var_3++) {
    var_4 = var_1[var_3];
    var_4 lightturnon();
    maps\mp\mp_zombie_h2o_aud::sndlightpuzzle(var_4.origin, var_4.sound);
    wait(var_2);
  }
}

generatelightpuzzlepattern(var_0) {
  var_1 = undefined;
  var_2 = [];

  while(var_2.size < 8) {
    var_3 = var_0[randomint(var_0.size)];

    if(isDefined(var_1) && var_3 == var_1) {
      waitframe();
      continue;
    }

    var_2[var_2.size] = var_3;
    var_1 = var_3;
  }

  return var_2;
}

waittillplayersactivatesequence(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 <= var_0; var_3++) {
    var_4 = var_2[var_3];
    var_5 = waittilllightpressed(var_4, var_1);

    if(maps\mp\zombies\_util::is_true(var_5)) {
      var_4 lightturnon();
      maps\mp\mp_zombie_h2o_aud::sndlightpuzzle(var_4.origin, var_4.sound);
      wait 0.5;
      continue;
    }

    return 0;
  }

  return 1;
}

waittilllightpressed(var_0, var_1) {
  level endon("sq_light_puzzle_cancel");
  level thread lightusetimeout();

  foreach(var_3 in var_1) {
    if(var_3.index != var_0.index) {
      var_3 thread lightusecancel();
    }
  }

  var_0 maps\mp\zombies\_zombies_sidequests::fake_use("used", undefined, undefined, "sq_light_uses_off", 80);
  level notify("sq_light_uses_off");
  return 1;
}

lightusetimeout() {
  level endon("sq_light_uses_off");
  wait 5;
  level notify("sq_light_puzzle_cancel");
}

lightusecancel() {
  level endon("sq_light_uses_off");
  maps\mp\zombies\_zombies_sidequests::fake_use("used", undefined, undefined, "sq_light_uses_off", 80);
  level notify("sq_light_puzzle_cancel");
  level notify("sq_light_uses_off");
}

stage11_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed simon lights puzzle");
}

unlockspecialweaponupgrade() {
  level notify("special_weapon_box_unlocked");
  announcerglobalplaysqvo(3, 2, undefined, "sq3");
  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

stage12_init() {}

stage12_logic() {
  level thread announcerozglobalplaysq(22);

  if(shoulddelayforbossround()) {
    waituntilnextround();
  }

  waituntilnextround();
  level thread announcerglobalplaysqvo(12);
  setomnvar("ui_zm_zone_identifier", 4);

  foreach(var_1 in level.players) {
    if(var_1 maps\mp\_utility::isjuggernaut()) {
      var_1 dodamage(var_1.mechhealth, var_1.origin);
    }

    if(isalive(var_1)) {
      var_1 notify("stop_useHoldThinkLoop");
    }
  }

  level thread handlefeaturesstage12();
  level thread spawncharactersstage12();
  level thread runprizelogic();
  waituntilnextround();
  var_3 = getteamplayersalive(level.playerteam);
  level thread announcerglobalplaysqvo(13);

  if(var_3 > 0) {
    maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage12");
  }
}

handlefeaturesstage12() {
  maps\mp\zombies\_util::disablekillstreaks();
  maps\mp\zombies\_util::setfriendlyfireround(1);
  level waittill("main_stage12_over");
  maps\mp\zombies\_util::setfriendlyfireround(0);
  maps\mp\zombies\_util::enablekillstreaks();
  despawncharacters();
}

runprizelogic() {
  foreach(var_1 in level.players) {
    var_1 thread playerhurtvostage12();
    var_1 thread playerrewardprizestage12();
    var_1 thread playerhandleicon();
  }

  level thread onplayerconnectstage12();
}

playerhandleicon() {
  var_0 = newteamhudelem(level.playerteam);
  var_0 setshader("hud_upgrade_reward", 14, 14);
  var_0 setwaypoint(1, 1);
  var_0 settargetent(self);
  waittillstage12overordeath(self);

  if(isDefined(var_0)) {
    var_0 destroy();
  }
}

waittillstage12overordeath(var_0) {
  var_0 endon("death");
  level waittill("main_stage12_over");
}

playerrewardprizestage12() {
  level endon("main_stage12_over");
  self notify("playerRewardPrizeStage12");
  self endon("playerRewardPrizeStage12");
  self waittill("death", var_0, var_1, var_2);

  if(isai(self)) {
    level.zmbsqcharacterskilled++;

    if(level.zmbsqcharacterskilled == 3) {
      if(isPlayer(var_0)) {
        var_0 thread playerrewardweaponupgrade();
      }
    }

    level thread dokillplayerozvo();
  } else if(isPlayer(var_0) && var_0 != self) {
    if(!isDefined(level.zmbsqrewardprizes)) {
      level.zmbsqrewardprizes = 1;
    } else if(level.zmbsqrewardprizes < 3) {
      level.zmbsqrewardprizes++;
    } else {
      return;
    }

    var_0 thread playerrewardweaponupgrade();
    level thread dokillplayerozvo();
  }
}

dokillplayerozvo() {
  var_0 = 0;

  if(level.players.size == 1) {
    if(level.zmbsqcharacterskilled == 1) {
      var_0 = 29;
    } else if(level.zmbsqcharacterskilled == 2) {
      var_0 = 30;
    } else {
      var_0 = 31;
    }
  } else {
    var_1 = level.players.size;
    var_2 = getteamplayersalive(level.playerteam);
    var_3 = var_1 - var_2;

    if(var_1 == 4 && var_3 == 1) {
      var_0 = 29;
    } else if(var_1 == 4 && var_3 == 2 || var_1 == 3 && var_3 == 1) {
      var_0 = 30;
    } else {
      var_0 = 31;
    }
  }

  wait 1;
  announcerozglobalplaysq(var_0);
}

playerhurtvostage12() {
  level endon("main_stage12_over");
  self notify("playerHurtVoStage12");
  self endon("playerHurtVoStage12");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1) && var_1 != self && isDefined(var_4) && maps\mp\_utility::isbulletdamage(var_4)) {
      if(playerplaysqvo(13)) {
        return;
      }
    }
  }
}

playerrewardweaponupgrade() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(maps\mp\zombies\_util::is_true(self.sqawardingweaponupgrade)) {
    wait 0.1;
  }

  self.sqawardingweaponupgrade = 1;
  var_0 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 185);
  var_0 settext(&"ZOMBIE_H2O_SQ_WPN_UPGRADE");
  var_0.fontscale = 0.65;
  var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 205);
  var_1 thread update_countdown(self);
  var_1.fontscale = 1;
  common_scripts\utility::waittill_any("timer_countdown_complete");
  var_1 maps\mp\gametypes\_hud_util::destroyelem();
  var_0 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(self.inlaststand) && self.inlaststand == 1) {
    while(self.inlaststand == 1) {
      wait 0.1;
    }
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    while(self.iscarrying == 1) {
      wait 0.1;
    }
  }

  if(isDefined(self.hasbomb) && self.hasbomb == 1) {
    while(self.hasbomb == 1) {
      wait 0.1;
    }
  }

  var_2 = maps\mp\zombies\_util::getplayerweaponzombies(self);
  var_3 = getweaponbasename(var_2);

  if(!maps\mp\zombies\_util::haszombieweaponstate(self, var_3)) {
    self.sqawardingweaponupgrade = undefined;
    return;
  }

  if(self.weaponstate[var_3]["level"] < 20) {
    maps\mp\zombies\_wall_buys::setweaponlevel(self, var_2, self.weaponstate[var_3]["level"] + 1);
  } else if(self.weaponstate[var_3]["level"] == 20) {
    maps\mp\zombies\_wall_buys::setweaponlevel(self, var_2, 25);
  } else {
    self.sqawardingweaponupgrade = undefined;
    return;
  }

  thread maps\mp\zombies\_zombies_audio::playerweaponupgrade(0, self.weaponstate[var_3]["level"]);
  self.sqawardingweaponupgrade = undefined;
}

update_countdown(var_0) {
  var_0 endon("disconnect");
  self endon("death");

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_2 = "" + (5 - var_1);
    self settext(var_2);
    var_0 playsoundtoplayer("ee_weapon_upgrade_countdown", var_0);
    wait 1;
  }

  var_0 notify("timer_countdown_complete");
}

onplayerconnectstage12() {
  level endon("main_stage12_over");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedstage12();
  }
}

onplayerspawnedstage12() {
  level endon("main_stage12_over");
  self waittill("spawned_player");
  thread playerrewardprizestage12();
  thread playerhurtvostage12();
}

spawncharactersstage12() {
  level endon("main_stage12_over");
  level.zmbsqcharacters = [];
  setupcharacterlogic();

  for(;;) {
    while(level.players.size != 1) {
      waitframe();
    }

    docharacterspawn();

    while(level.players.size == 1) {
      waitframe();
    }

    despawncharacters();
    level.zmbsqcharacters = [];
  }
}

setupcharacterlogic() {
  if(!isDefined(level.agent_funcs["sq_character"])) {
    maps\mp\zombies\ranged_elite_soldier::init_ally();
    level.agent_funcs["sq_character"] = level.agent_funcs["ranged_elite_soldier"];
    level.agent_funcs["sq_character"]["think"] = ::characterthink;
    level.getloadout["sq_character"] = ::sqcharactergetloadout;
    level.onspawnfinished["sq_character"] = ::onspawnfinishedsqcharacter;
    var_0 = level.agentclasses["ranged_elite_soldier"];
    maps\mp\zombies\_util::agentclassregister(var_0, "sq_character");
  }
}

onspawnfinishedsqcharacter(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("applyLoadout");
  var_1 = common_scripts\utility::array_combine(level.players, level.zmbsqcharacters);

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = getcharacterbyindex(var_2, var_1);

    if(!isDefined(var_3)) {
      self.characterindex = var_2;
      setexocharactermodel();
      break;
    }
  }

  setcharacterbotsettings();
  self agentusescragentclipmask(1);
  self.pers["numberOfTimesCloakingUsed"] = 0;
  self.pers["numberOfTimesShieldUsed"] = 0;
}

setcharacterbotsettings() {
  self botsetdifficultysetting("meleeReactAllowed", 0);
  self botsetdifficultysetting("quickPistolSwitch", 1);
  self botsetdifficultysetting("diveChance", 0);
  self botsetdifficultysetting("diveDelay", 300);
  self botsetdifficultysetting("slideChance", 0.6);
  self botsetdifficultysetting("cornerFireChance", 1.0);
  self botsetdifficultysetting("cornerJumpChance", 1.0);
  self botsetdifficultysetting("throwKnifeChance", 1.0);
  self botsetdifficultysetting("meleeDist", 100);
  self botsetdifficultysetting("meleeChargeDist", 160);
  self botsetdifficultysetting("grenadeCookPrecision", 100);
  self botsetdifficultysetting("grenadeDoubleTapChance", 1.0);
  self botsetdifficultysetting("strategyLevel", 3);
  self botsetdifficultysetting("intelligentSprintLevel", 2);
  self botsetdifficultysetting("holdBreathChance", 1.0);
  self botsetdifficultysetting("intelligentReload", 1.0);
  self botsetdifficultysetting("dodgeChance", 0.5);
  self botsetdifficultysetting("dodgeIntelligence", 0.8);
  self botsetdifficultysetting("boostSlamChance", 0.35);
  self botsetdifficultysetting("boostLookAroundChance", 1.0);
}

sqcharactergetloadout() {
  var_0 = maps\mp\bots\_bots_loadout::bot_loadout_choose_from_attachmenttable;
  var_1 = [];
  var_1["loadoutWildcard1"] = "specialty_null";
  var_1["loadoutWildcard2"] = "specialty_null";
  var_1["loadoutWildcard3"] = "specialty_null";
  var_1["loadoutPrimary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["primary"]);
  var_1["loadoutPrimaryAttachment"] = self[[var_0]]("attachmenttable", var_1, "loadoutPrimaryAttachment", self.personality, self.difficulty);
  var_1["loadoutPrimaryAttachment2"] = self[[var_0]]("attachmenttable", var_1, "loadoutPrimaryAttachment2", self.personality, self.difficulty);
  var_1["loadoutPrimaryAttachment3"] = "none";
  var_1["loadoutPrimaryBuff"] = "specialty_null";
  var_1["loadoutPrimaryCamo"] = "none";
  var_1["loadoutPrimaryReticle"] = "none";
  var_1["loadoutSecondary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["secondary"]);
  var_1["loadoutSecondaryAttachment"] = self[[var_0]]("attachmenttable", var_1, "loadoutSecondaryAttachment", self.personality, self.difficulty);
  var_1["loadoutSecondaryAttachment2"] = self[[var_0]]("attachmenttable", var_1, "loadoutSecondaryAttachment2", self.personality, self.difficulty);
  var_1["loadoutSecondaryAttachment3"] = "none";
  var_1["loadoutSecondaryBuff"] = "specialty_null";
  var_1["loadoutSecondaryCamo"] = "none";
  var_1["loadoutSecondaryReticle"] = "none";
  var_1["loadoutEquipment"] = common_scripts\utility::random(["frag_grenade_mp", "semtex_mp"]);
  var_1["loadoutEquipmentExtra"] = 0;
  var_1["loadoutOffhand"] = "specialty_null";
  var_1["loadoutPerk1"] = "specialty_null";
  var_1["loadoutPerk2"] = "specialty_null";
  var_1["loadoutPerk3"] = "specialty_null";
  var_1["loadoutPerk4"] = "specialty_null";
  var_1["loadoutPerk5"] = "specialty_null";
  var_1["loadoutPerk6"] = "specialty_null";
  var_1["loadoutKillstreaks"][0] = "none";
  var_1["loadoutKillstreaks"][1] = "none";
  var_1["loadoutKillstreaks"][2] = "none";
  var_1["loadoutKillstreaks"][3] = "none";

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_1["loadoutPerks"][var_2] = var_1["loadoutPerk" + (var_2 + 1)];
    var_1["loadoutPerk" + (var_2 + 1)] = undefined;
  }

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_1["loadoutWildcards"][var_2] = var_1["loadoutWildcard" + (var_2 + 1)];
    var_1["loadoutWildcard" + (var_2 + 1)] = undefined;
  }

  return var_1;
}

characterthink() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("soldier_think");
  self endon("soldier_think");
  childthread maps\mp\zombies\ranged_elite_soldier::ammorefillprimary();
  childthread maps\mp\zombies\ranged_elite_soldier::ammorefillsecondary();
  childthread maps\mp\zombies\killstreaks\_zombie_squadmate::monitorteleporttraversals();

  if(self.team == level.enemyteam) {
    childthread maps\mp\zombies\_util::locateenemypositions();
  } else {
    maps\mp\_utility::giveperk("specialty_coldblooded", 0);
  }
}

despawncharacters() {
  foreach(var_1 in level.zmbsqcharacters) {
    var_1 suicide();
  }
}

docharacterspawn() {
  var_0 = getanyplayer();
  spawncharacters(var_0, 3, level.enemyteam);
  var_1 = var_0.characterindex;
  level.zmbsqcharacterskilled = 0;

  foreach(var_3 in level.zmbsqcharacters) {
    var_3.fakeplayer = 1;
    var_3 thread playerrewardprizestage12();
    var_3 thread playerhandleicon();
  }
}

getanyplayer(var_0) {
  var_1 = level.players;

  if(maps\mp\zombies\_util::is_true(var_0)) {
    var_1 = common_scripts\utility::array_randomize(level.players);
  }

  foreach(var_3 in level.players) {
    if(isalive(var_3)) {
      return var_3;
    }
  }

  if(isDefined(level.player)) {
    return level.player;
  }

  return level.players[0];
}

setexocharactermodel() {
  switch (self.characterindex) {
    case 0:
      thread maps\mp\zombies\_util::setcharactermodel("security_exo", 1, 1);
      break;
    case 1:
      thread maps\mp\zombies\_util::setcharactermodel("exec_exo", 1, 1);
      break;
    case 2:
      thread maps\mp\zombies\_util::setcharactermodel("it_exo", 1, 1);
      break;
    case 3:
    default:
      thread maps\mp\zombies\_util::setcharactermodel("pilot_exo", 1, 1);
      break;
  }
}

spawncharacters(var_0, var_1, var_2, var_3) {
  level endon("main_stage12_over");
  var_4 = 0;
  var_5 = [];
  var_6 = 0;

  while(!var_6) {
    var_7 = getanyplayer();
    var_8 = var_7 maps\mp\zombies\_util::getenemyagents();
    var_9 = maps\mp\zombies\_util::getnumagentswaitingtodeactivate();
    var_4 = var_8.size + var_9 - (maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - var_1);
    var_5 = maps\mp\zombies\_util::getarrayofoffscreenagentstorecycle(var_8);

    if(var_5.size >= var_4) {
      var_6 = 1;
      continue;
    }

    waitframe();
  }

  var_10 = 0;

  if(var_4 > 0) {
    maps\mp\zombies\_util::pausezombiespawning(1);
    var_10 = 1;
    var_5 = common_scripts\utility::array_randomize(var_5);
    var_11 = [];

    for(var_12 = 0; var_12 < var_4; var_12++) {
      var_11[var_12] = var_5[var_12];
    }

    foreach(var_14 in var_11) {
      var_14 suicide();
    }

    wait 0.5;
  }

  if(!isDefined(var_3)) {
    var_3 = getnodesforenemycharacters(var_0, var_1);
  }

  level.zmbsqcharacters = [];

  for(var_12 = 0; var_12 < var_1; var_12++) {
    var_18 = var_3[var_12].origin;
    var_19 = vectortoangles(var_0.origin - var_3[var_12].origin);
    var_20 = "sq_character";
    var_21 = maps\mp\agents\_agent_common::connectnewagent(var_20, var_2);
    var_21 maps\mp\agents\_agents::spawn_agent_player(var_18, var_19);
    level.zmbsqcharacters[level.zmbsqcharacters.size] = var_21;
    var_22 = 100;
    var_21 maps\mp\agents\_agent_common::set_agent_health(var_22);
    maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(var_21);
    playFX(common_scripts\utility::getfx("npc_teleport_ally"), var_18, (1, 0, 0), (0, 0, 1));
    waitframe();
  }

  if(var_10) {
    maps\mp\zombies\_util::pausezombiespawning(0);
  }
}

getnodesforenemycharacters(var_0, var_1) {
  var_2 = maps\mp\zombies\_zombies_zone_manager::getcurrentplayeroccupiedzones();
  var_3 = [];
  var_4 = [];
  var_5 = [];

  while(!isDefined(level.zone_data)) {
    waitframe();
  }

  while(!isDefined(level.closetpathnodescalculated) || !level.closetpathnodescalculated) {
    waitframe();
  }

  foreach(var_7 in level.zone_data.zones) {
    if(!isDefined(var_7.volumes)) {
      continue;
    }
    if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_7.zone_name)) {
      continue;
    }
    if(isDefined(level.ammodroneillegalzones)) {
      if(common_scripts\utility::array_contains(level.ammodroneillegalzones, var_7.zone_name)) {
        continue;
      }
    }

    if(!common_scripts\utility::array_contains(var_2, var_7.zone_name)) {
      var_3[var_3.size] = var_7;
      continue;
    }

    var_4[var_4.size] = var_7;
  }

  if(var_3.size == 0) {
    var_3 = var_4;
  }

  var_3 = common_scripts\utility::array_randomize(var_3);

  foreach(var_7 in var_3) {
    var_10 = var_7.volumes[randomint(var_7.volumes.size)];
    var_11 = getnodesintrigger(var_10);
    var_12 = [];

    foreach(var_14 in var_11) {
      if(!var_14 nodeisdisconnected() && isDefined(var_14.zombieszone)) {
        var_12[var_12.size] = var_14;
      }
    }

    var_5[var_5.size] = var_12[randomint(var_12.size)];

    for(var_16 = var_1 - 1; var_16 > 0 && var_5.size < var_1; var_16--) {
      if(var_3.size <= var_16) {
        var_5[var_5.size] = var_12[randomint(var_12.size)];
      }
    }

    if(var_5.size == var_1) {
      break;
    }
  }

  return var_5;
}

stage12_end(var_0) {
  level thread dochallengehudcomplete();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 4 - Last One Standing");
}

stage13_init() {}

stage13_logic() {
  var_0 = getent("sqCounterTop0", "targetname");
  var_1 = getent("sqCounterTop1", "targetname");
  var_2 = getent("sqCounterTop2", "targetname");
  var_3 = getent("sqCounterTop3", "targetname");
  var_4 = getent("sqCounterBottom0", "targetname");
  var_5 = getent("sqCounterBottom1", "targetname");
  var_6 = getent("sqCounterBottom2", "targetname");
  var_7 = getent("sqCounterBottom3", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 show();
  var_1 show();
  var_2 show();
  var_3 show();
  var_4 show();
  var_5 show();
  var_6 show();
  var_7 show();
  var_8 = [var_0, var_1, var_2, var_3];
  var_9 = [var_4, var_5, var_6, var_7];
  level.zmbsqcountertop = setupcounter(var_8);
  level.zmbsqcounterbottom = setupcounter(var_9);
  runcounterpuzzlelogic(level.zmbsqcountertop, level.zmbsqcounterbottom);
  level thread delaydeletecounters(var_8, var_9);
  maps\mp\mp_zombie_h2o_aud::sndcounterdigitsuccess();
  announcerglobalplaysqvowaittilldone(6, 2);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage13");
}

delaydeletecounters(var_0, var_1) {
  wait 1;

  foreach(var_3 in var_0) {
    var_3 delete();
  }

  foreach(var_3 in var_1) {
    var_3 delete();
  }
}

runcounterpuzzlelogic(var_0, var_1) {
  var_2 = randomintrange(1, 10);
  var_3 = randomintrange(1, 10);
  var_4 = randomintrange(1, 10);
  var_5 = randomintrange(1, 10);
  setcounter(var_0, var_2, var_3, var_4, var_5, "red");
  setcounter(var_1, 0, 0, 0, 0, "blue");
  level thread monitorboostslamhits(var_1, 0);
  level thread monitorjumps(var_1, 1);
  level thread monitorweaponspickedup(var_1, 2);
  level thread monitorkills(var_1, 3);

  for(;;) {
    if(docountersmatch(var_0, var_1)) {
      level notify("sq_counter_puzzle_complete");
      break;
    }

    waitframe();
  }
}

docountersmatch(var_0, var_1) {
  return var_0.digits[0] == var_1.digits[0] && var_0.digits[1] == var_1.digits[1] && var_0.digits[2] == var_1.digits[2] && var_0.digits[3] == var_1.digits[3];
}

monitorboostslamhits(var_0, var_1, var_2) {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");

  if(!isDefined(level.zmbsqboostslamhits)) {
    level.zmbsqboostslamhits = 0;
  }

  level.processenemydamagedfunc = ::processenemydamagedfuncsq;
  var_3 = level.zmbsqboostslamhits;

  for(;;) {
    level waittill("sq_boost_slam_hit");
    waittillframeend;
    var_4 = level.zmbsqboostslamhits - var_3;
    var_5 = getcounterdigit(var_0, var_1);
    var_5 = (var_5 + var_4) % 10;
    setcounterdigit(var_0, var_1, var_5, "blue");
    var_3 = level.zmbsqboostslamhits;
  }
}

processenemydamagedfuncsq(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(var_0)) {
    return;
  }
  if(isDefined(var_4) && var_4 == "MOD_SUICIDE") {
    return;
  }
  if(isDefined(var_5) && var_5 == "boost_slam_mp") {
    level notify("sq_boost_slam_hit");
    level.zmbsqboostslamhits++;
  }
}

monitorjumps(var_0, var_1) {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");

  if(!isDefined(level.zmbsqplayerjumps)) {
    level.zmbsqplayerjumps = 0;
  }

  level thread onplayerconnectstage13();

  foreach(var_3 in level.players) {
    var_3 thread playermonitorjumps();
  }

  var_5 = level.zmbsqplayerjumps;

  for(;;) {
    level waittill("sq_player_jumped");
    waittillframeend;
    var_6 = level.zmbsqplayerjumps - var_5;
    var_7 = getcounterdigit(var_0, var_1);
    var_7 = (var_7 + var_6) % 10;
    setcounterdigit(var_0, var_1, var_7, "blue");
    var_5 = level.zmbsqplayerjumps;
  }
}

onplayerconnectstage13() {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedstage13();
  }
}

onplayerspawnedstage13() {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");
  self endon("disconnect");
  self waittill("spawned_player");
  thread playermonitorjumps();
}

playermonitorjumps() {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");
  self endon("disconnect");

  if(!isDefined(level.zmbsqplayerjumps)) {
    level.zmbsqplayerjumps = 0;
  }

  for(;;) {
    while(!self isjumping()) {
      waitframe();
    }

    level.zmbsqplayerjumps++;
    level notify("sq_player_jumped");

    while(!self isonground()) {
      waitframe();
    }

    waitframe();
  }
}

monitorweaponspickedup(var_0, var_1) {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");

  if(!isDefined(level.zmbsqweaponspickedup)) {
    level.zmbsqweaponspickedup = 0;
  }

  level.zmbprocessweapongivenfunc = ::zmbprocessweapongivenfunc;
  level thread onplayerconnectstage13();
  var_2 = level.zmbsqweaponspickedup;

  for(;;) {
    level waittill("sq_weapon_given");
    waittillframeend;
    var_3 = level.zmbsqweaponspickedup - var_2;
    var_4 = getcounterdigit(var_0, var_1);
    var_4 = (var_4 + var_3) % 10;
    setcounterdigit(var_0, var_1, var_4, "blue");
    var_2 = level.zmbsqweaponspickedup;
  }
}

zmbprocessweapongivenfunc(var_0, var_1) {
  if(maps\mp\zombies\_util::iszombieequipment(var_1)) {
    level.zmbsqweaponspickedup++;
    level notify("sq_weapon_given");
  }
}

monitorkills(var_0, var_1, var_2) {
  level endon("main_stage13_over");
  level endon("sq_counter_puzzle_complete");

  if(!isDefined(level.zmbsqregularkills)) {
    level.zmbsqregularkills = 0;
  }

  level.processenemykilledfunc = ::processenemykilledsq;
  var_3 = level.zmbsqregularkills;

  for(;;) {
    level waittill("sq_regular_kill");
    waittillframeend;
    var_4 = level.zmbsqregularkills - var_3;
    var_5 = getcounterdigit(var_0, var_1);
    var_5 = (var_5 + var_4) % 10;
    setcounterdigit(var_0, var_1, var_5, "blue");
    var_3 = level.zmbsqregularkills;
  }
}

processenemykilledsq(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }
  level notify("sq_regular_kill");
  level.zmbsqregularkills++;
}

setcounter(var_0, var_1, var_2, var_3, var_4, var_5) {
  setcounterdigit(var_0, 0, var_1, var_5);
  setcounterdigit(var_0, 1, var_2, var_5);
  setcounterdigit(var_0, 2, var_3, var_5);
  setcounterdigit(var_0, 3, var_4, var_5);
}

getcounterdigit(var_0, var_1) {
  return var_0.digits[var_1];
}

setcounterdigit(var_0, var_1, var_2, var_3) {
  var_4 = "neon_alphabet_num_0_off";

  switch (var_2) {
    case 0:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_0";
      } else if(var_3 == "off") {
        var_4 = "h2o_sign_ee_scoreboard_no_0";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_0";
      }

      break;
    case 1:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_1";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_1";
      }

      break;
    case 2:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_2";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_2";
      }

      break;
    case 3:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_3";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_3";
      }

      break;
    case 4:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_4";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_4";
      }

      break;
    case 5:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_5";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_5";
      }

      break;
    case 6:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_6";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_6";
      }

      break;
    case 7:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_7";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_7";
      }

      break;
    case 8:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_8";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_8";
      }

      break;
    case 9:
      if(var_3 == "red") {
        var_4 = "h2o_sign_ee_scoreboard_no_9";
      } else {
        var_4 = "h2o_sign_ee_scoreboard_no_9";
      }

      break;
    default:
      var_4 = "h2o_sign_ee_scoreboard_no_0";
      break;
  }

  var_0.digits[var_1] = var_2;
  var_0.digitmodels[var_1] setModel(var_4);
  maps\mp\mp_zombie_h2o_aud::sndcounterdigitflip(var_0.digitmodels[var_1].origin);
}

setupcounter(var_0) {
  var_1 = spawnStruct();
  var_1.digitmodels = var_0;
  var_1.digits = [0, 0, 0, 0];
  return var_1;
}

stage13_end(var_0) {
  level.zmbprocessweapongivenfunc = undefined;
  level.processenemykilledfunc = undefined;
  level.processenemydamagedfunc = undefined;
  level.zmbsqboostslamhits = undefined;
  level.zmbsqplayerjumps = undefined;
  level.zmbsqregularkills = undefined;
  level.zmbsqweaponspickedup = undefined;
  level.zmbsqcountertop = undefined;
  level.zmbsqcounterbottom = undefined;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed counters puzzle");
}

stage10_init() {}

stage10_logic() {
  level thread announcerozglobalplaysq(21);

  if(shoulddelayforbossround()) {
    waituntilnextround();
  }

  waituntilnextround();
  level thread announcerozglobalplaysq(13);
  setomnvar("ui_zm_zone_identifier", 3);
  level thread runmovementiscostly();
  waituntilnextround();
  var_0 = getteamplayersalive(level.playerteam);

  if(var_0 > 0) {
    level thread announcerozglobalplaysq(33);
    maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage10");
  }
}

runmovementiscostly() {
  level.zmbsqlinkent = spawn("script_model", (0, 0, 0));

  foreach(var_1 in level.players) {
    var_1 thread playertravelcosts();
  }

  level thread onplayerconnectstage10();
}

onplayerconnectstage10() {
  level endon("main_stage10_over");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedstage10();
  }
}

onplayerspawnedstage10() {
  level endon("main_stage10_over");
  self endon("disconnect");
  self waittill("spawned_player");
  thread playertravelcosts();
}

getspendincrement(var_0) {
  var_1 = int(var_0 * 0.01);
  var_2 = var_1 % 5;
  var_1 = var_1 - var_2;
  return int(max(5, var_1));
}

playertravelcosts() {
  level endon("main_stage10_over");
  self endon("disconnect");
  var_0 = 0;
  var_1 = 1;
  var_2 = 20000;
  var_3 = 60000;
  var_4 = 300;
  var_5 = 0;
  var_6 = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    while(self.sessionstate != "playing" || maps\mp\zombies\_util::isplayerteleporting(self)) {
      waitframe();
    }

    var_10 = self.origin;
    waitframe();

    if(self.sessionstate != "playing" || maps\mp\zombies\_util::isplayerteleporting(self)) {
      continue;
    }
    var_11 = distance(self.origin, var_10);
    var_12 = maps\mp\gametypes\zombies::getcurrentmoney(self);
    var_13 = getspendincrement(var_12);
    var_14 = var_13 / 50.0;
    var_0 = var_0 + var_11 * var_14;

    if(var_0 >= var_13) {
      var_12 = maps\mp\gametypes\zombies::getcurrentmoney(self);
      var_15 = int(var_0 - int(var_0) % var_13);
      var_0 = var_0 - var_15;

      if(var_15 > var_12) {
        var_15 = var_12;
      }

      if(var_15 > 0) {
        maps\mp\gametypes\zombies::spendmoney(var_15);

        if(!maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking() && !var_5 && playerplaysqvo(14)) {
          var_5 = 1;
        }
      }
    }

    var_12 = maps\mp\gametypes\zombies::getcurrentmoney(self);

    if(!var_6 && var_12 > var_4) {
      var_6 = 1;
    }

    if(var_12 > 0 && var_12 < var_4 && var_7 < gettime()) {
      if(var_6 && playerplaysqvo(15)) {
        var_7 = gettime() + var_3;
        var_6 = 0;
      }
    }

    if(!var_12 && self isonground() && !self islinked()) {
      if(var_8 < gettime()) {
        if(playerplaysqvo(16)) {
          var_8 = gettime() + var_2;

          if(!var_9) {
            level thread announcerozglobalplaysq(32);
            var_9 = 1;
          }
        }
      }

      self playerlinkto(level.zmbsqlinkent);
      self playerlinkedoffsetenable();
      var_1 = 1;
      continue;
    }

    if(var_12 && var_1) {
      self unlink();
      var_1 = 0;
    }
  }
}

stage10_end(var_0) {
  if(isDefined(level.zmbsqlinkent)) {
    level.zmbsqlinkent delete();
  }

  level thread dochallengehudcomplete();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 3 - Movement is Costly");
}

stage15_init() {}

stage15_logic() {
  announcerglobalplaysqvowaittilldone(11, 1);
  wait 0.5;
  announcerozglobalplaysqwaittilldone(14);
  var_0 = undefined;
  var_1 = common_scripts\utility::getstruct("sqMemoryDevice", "targetname");

  if(isDefined(var_1)) {
    var_0 = spawn("script_model", var_1.origin);
    var_0 setModel("tag_origin");
    var_0.angles = var_1.angles;
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_off"), var_0, "tag_origin");
  }

  var_2 = common_scripts\utility::getstruct("sqComputer", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = 76;

  for(;;) {
    for(;;) {
      var_4 = var_2 maps\mp\zombies\_zombies_sidequests::fake_use("computer_used", undefined, undefined, "main_stage15_over", var_3);

      if(maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress)) {
        maps\mp\mp_zombie_h2o_aud::sndcomputerfail(var_2.origin);
        wait 1;
        continue;
      }

      thread maps\mp\mp_zombie_h2o_aud::sndusememorymachine(var_2);
      var_5 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone("easter_egg", 0);

      if(level.players.size == var_5.size) {
        if(isDefined(var_0)) {
          maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_off"), var_0, "tag_origin");
          maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_on"), var_0, "tag_origin");
          maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_exo"), var_0, "tag_origin", 1);
        }

        announcerglobalplaysqvowaittilldone(16);
        break;
      } else {
        maps\mp\mp_zombie_h2o_aud::sndcomputerfail(var_2.origin);
      }

      wait 1;
    }

    var_6 = runbussequence();

    if(maps\mp\zombies\_util::is_true(var_6)) {
      break;
    }

    wait 1;

    if(isDefined(var_0)) {
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_on"), var_0, "tag_origin");
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_off"), var_0, "tag_origin");
    }

    wait 2;
  }

  if(isDefined(var_0)) {
    maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_on"), var_0, "tag_origin");
  }

  foreach(var_4 in level.players) {
    if(var_4 maps\mp\_utility::isjuggernaut()) {
      var_4 dodamage(var_4.mechhealth, var_4.origin);
    }

    if(isalive(var_4)) {
      var_4 notify("stop_useHoldThinkLoop");
    }
  }

  wait 2;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage15");
}

stage15_end(var_0) {
  level.zmbsqbusroundnum = undefined;
  level.zmbbossteleportdelay = undefined;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Bus Memory Sequence");
}

runbussequence() {
  level.zmbbossteleportdelay = 1;
  level.zone_data.zones["bus"].is_enabled = 1;
  maps\mp\zombies\_util::pausezombiespawning(1);
  level.zmbpauselightningflashes = 1;
  teleportplayerstobuszone();
  var_0 = runbusroundlogic();
  busroundcomplete();
  return var_0;
}

monitorplayersleavebusarena() {
  level endon("main_stage15_over");
  level endon("bus_round_complete");
  var_0 = getent("sqBusFloorTeleport", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      level notify("bus_round_complete");
      return;
    }
  }
}

monitorplayersalive() {
  level endon("main_stage15_over");
  level endon("bus_round_complete");
  level waittill("bleedout");
  level notify("bus_round_complete");
}

monitorplayerdisconnects() {
  foreach(var_1 in level.players) {
    var_1 thread playernotifyondisconnectstage15();
  }
}

playernotifyondisconnectstage15() {
  level endon("main_stage15_over");
  level endon("bus_round_complete");
  self waittill("disconnect");
  level notify("bus_round_complete");
}

busroundcomplete() {
  level notify("bus_round_complete");
  teleportplayersback();

  if(isDefined(level.zmbsqpreviousspecialmutators)) {
    maps\mp\zombies\_util::enablepickups();
    level.disablespawning = undefined;
    level.special_mutators = level.zmbsqpreviousspecialmutators;
    level.zmbsqpreviousspecialmutators = undefined;
    level.movemodefunc["zombie_generic"] = undefined;
    level.moveratescalefunc["zombie_generic"] = undefined;
    level.nonmoveratescalefunc["zombie_generic"] = undefined;
    level.traverseratescalefunc["zombie_generic"] = undefined;

    if(isDefined(level.zmbsqpreviousroundhealth)) {
      var_0 = maps\mp\zombies\_util::agentclassget("zombie_generic");
      var_0.roundhealth = level.zmbsqpreviousroundhealth;
      level.zmbsqpreviousroundhealth = undefined;
    }

    var_1 = common_scripts\utility::getstructarray("sqBusPlayerSpawner", "targetname");

    foreach(var_3 in var_1) {
      var_3.used = undefined;
    }
  }

  var_5 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_7 in var_5) {
    var_7 dodamage(var_7.health + 1, var_7.origin);
  }

  level.zone_data.zones["bus"].is_enabled = 0;
  maps\mp\zombies\_util::pausezombiespawning(0);
  level.zmbbossteleportdelay = undefined;
  level.zmbpauselightningflashes = undefined;
}

runbusroundlogic() {
  level endon("bus_round_complete");
  level common_scripts\utility::waittill_notify_or_timeout("sq_player_teleport_to_bus_zone", 1.8);
  level thread spawncharactersstage15();
  level thread monitorplayersleavebusarena();
  level thread monitorplayersalive();
  level thread monitorplayerdisconnects();
  wait 1;
  var_0 = getcharacterbyprefixstage15("janitor");
  var_1 = getcharacterbyprefixstage15("it");
  var_2 = getcharacterbyprefixstage15("exec");
  var_3 = getcharacterbyprefixstage15("guard");
  var_1 playerplaysqvo(27, 0.5, 1);
  var_0 playerplaysqvo(35, 0.5, 1);
  var_1 playerplaysqvo(28, 0.5, 1);
  var_0 playerplaysqvo(36, 0.5, 1);
  maps\mp\zombies\_util::disablepickups();
  level.disablespawning = 1;
  level.zmbsqpreviousspecialmutators = level.special_mutators;
  level.special_mutators = [];
  maps\mp\zombies\zombies_spawn_manager::defaultmutatorsetup();
  level.movemodefunc["zombie_generic"] = ::calulatezombiemovemode;
  level.moveratescalefunc["zombie_generic"] = ::calculatezombiemoveratescale;
  level.nonmoveratescalefunc["zombie_generic"] = ::calculatezombienonmoveratescale;
  level.traverseratescalefunc["zombie_generic"] = ::calculatezombietraverseratescale;
  var_4 = maps\mp\zombies\_util::agentclassget("zombie_generic");
  level.zmbsqpreviousroundhealth = var_4.roundhealth;
  level.zmbsqbusroundnum = 12;
  var_4.roundhealth = calculatezombiehealth(var_4);
  var_5 = 100;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }

    while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount) {
      wait 0.1;
    }

    var_7 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype("zombie_generic", undefined, ::applyzombiemutatorbusround);
    var_7.hastraversed = 1;
    wait 0.1;
  }

  for(var_8 = 1; var_8 > 0; var_8 = maps\mp\agents\_agent_utility::getnumactiveagents("zombie_generic")) {
    wait 0.1;
  }

  wait 2;
  var_0 playerplaysqvo(41, 0.5, 1);
  var_2 playerplaysqvo(29, 0.5, 1);
  var_0 playerplaysqvo(42, 0.5, 1);
  var_2 playerplaysqvo(30, 0.5, 1);
  var_0 playerplaysqvo(43, 0.5, 1);
  var_3 playerplaysqvo(28, 0.5, 1);
  var_0 playerplaysqvo(44, 0.5, 1);
  var_1 playerplaysqvo(31, 0.5, 1);
  var_3 playerplaysqvo(29, 0.5, 1);
  var_0 playerplaysqvo(45, 0.5, 1);
  var_2 playerplaysqvo(31, 0.5, 1);
  var_0 playerplaysqvo(46, 0.5, 1);
  var_0 playerplaysqvo(47, 0.5, 1);
  var_3 playerplaysqvo(30, 0.5, 1);
  level.zmbsqbusroundnum = 20;
  var_4.roundhealth = calculatezombiehealth(var_4);
  var_9 = 100;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }

    while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount) {
      wait 0.1;
    }

    var_7 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype("zombie_generic", undefined, ::applyzombiemutatorbusround);
    var_7.hastraversed = 1;
    wait 0.1;
  }

  for(var_8 = 1; var_8 > 0; var_8 = maps\mp\agents\_agent_utility::getnumactiveagents("zombie_generic")) {
    wait 0.1;
  }

  wait 2;
  var_0 playerplaysqvo(48, 0.5, 1);
  var_0 playerplaysqvo(49, 0.5, 1);
  var_3 playerplaysqvo(31, 0.5, 1);
  var_0 playerplaysqvo(50, 0.5, 1);
  var_0 playerplaysqvo(51, 0.5, 1);
  var_0 playerplaysqvo(52, 0.5, 1);
  wait 1;
  return 1;
}

getcharacterbyprefixstage15(var_0) {
  var_1 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix(var_0);

  if(isDefined(var_1)) {
    return var_1;
  } else {
    var_2 = maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix(var_0);

    foreach(var_4 in level.zmbsqcharacters) {
      if(var_4.characterindex == var_2) {
        return var_4;
      }
    }
  }

  return level.players[0];
}

applyzombiemutatorbusround(var_0) {
  if(!isscriptedagent(var_0)) {
    return;
  }
  var_1 = var_0 maps\mp\zombies\zombies_spawn_manager::specialmutatorshouldapply(level.zmbsqbusroundnum);
  var_2 = [];
  var_3 = var_0 maps\mp\zombies\zombies_spawn_manager::exomutatorshouldapply(level.zmbsqbusroundnum) || var_1;

  if(var_3) {
    var_0 thread maps\mp\zombies\_mutators::mutator_apply("exo");
  }

  if(var_1) {
    var_4 = [];
    var_5 = 0.0;

    foreach(var_10, var_7 in level.special_mutators) {
      var_8 = var_7[0];
      var_9 = var_7[1];

      if(isDefined(level.mutators_disabled[var_0.agent_type])) {
        if(isDefined(level.mutators_disabled[var_0.agent_type][var_10]) && level.mutators_disabled[var_0.agent_type][var_10]) {
          continue;
        }
      }

      if(var_0[[var_8]](level.zmbsqbusroundnum)) {
        var_4[var_4.size] = var_10;
        var_5 = var_5 + var_9;
      }
    }

    var_11 = randomfloat(var_5);
    var_12 = 0.0;

    foreach(var_10 in var_4) {
      var_9 = level.special_mutators[var_10][1];

      if(var_11 > var_12 && var_11 <= var_12 + var_9) {
        var_0 thread maps\mp\zombies\_mutators::mutator_apply(var_10);
        break;
      }

      var_12 = var_12 + var_9;
    }
  }
}

spawncharactersstage15() {
  level.zmbsqcharacters = [];
  setupcharacterlogic();
  maps\mp\zombies\_util::initializecharactermodel("janitor", "janitor_body_dlc2", "viewhands_janitor", ["janitor_head_dlc2"]);
  maps\mp\zombies\_util::initializecharactermodel("janitor_exo", "janitor_body_exo_dlc2", "viewhands_janitor_exo", ["janitor_head_dlc2"]);
  var_0 = getanyplayer();
  var_1 = getnumplayersalive();
  var_2 = 4 - var_1;

  if(var_2 > 0) {
    var_3 = getbuszonecharacterspawns();
    spawncharacters(var_0, var_2, level.playerteam, var_3);
    var_4 = getanyplayer();

    foreach(var_6 in level.zmbsqcharacters) {
      var_6.bypassagentcorpse = 1;
      var_6.godmode = 1;
      var_6.fakeplayer = 1;
      var_6 maps\mp\zombies\_util::setcharacteraudio(var_6.characterindex, 1);
    }
  }

  var_8 = getcharacterbyindex(3, level.players);

  if(!isDefined(var_8)) {
    var_8 = getcharacterbyindex(3, level.zmbsqcharacters);
  }

  if(isPlayer(var_8)) {
    var_8 maps\mp\zombies\_util::setcharacteraudio(3, 1);
  }

  var_9 = !isPlayer(var_8);
  var_10 = "janitor";

  if(maps\mp\zombies\_util::is_true(var_8.exosuitonline) || !isPlayer(var_8)) {
    var_10 = "janitor_exo";
  }

  var_8 thread maps\mp\zombies\_util::setcharactermodel(var_10, 1, var_9);
  level waittill("bus_round_complete");

  if(isPlayer(var_8)) {
    if(isalive(var_8)) {
      var_10 = "pilot";

      if(maps\mp\zombies\_util::is_true(var_8.exosuitonline)) {
        var_10 = "pilot_exo";
      }

      var_8 thread maps\mp\zombies\_util::setcharactermodel(var_10, 1);
    }

    var_8 maps\mp\zombies\_util::setcharacteraudio(3, 0);
  }

  despawncharacters();
}

getprefixbycharacterindex(var_0) {
  switch (var_0) {
    case 0:
      return "guard";
    case 1:
      return "exec";
    case 2:
      return "it";
    case 3:
      return "janitor";
  }
}

getbuszonecharacterspawns() {
  var_0 = common_scripts\utility::getstructarray("sqBusPlayerSpawner", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!maps\mp\zombies\_util::is_true(var_3.used)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getnumplayersalive() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isalive(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

getcharacterbyindex(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(isDefined(var_3.characterindex) && var_3.characterindex == var_0) {
      return var_3;
    }
  }
}

calculatezombiehealth(var_0) {
  var_1 = 150;

  if(level.zmbsqbusroundnum == 1) {
    var_2 = var_1;
  } else if(level.zmbsqbusroundnum <= 9) {
    var_2 = var_1 + (level.zmbsqbusroundnum - 1) * 100;
  } else {
    var_3 = 950;
    var_4 = level.zmbsqbusroundnum - 9;
    var_2 = var_3 * pow(1.1, var_4);
  }

  var_2 = int(var_2 * var_0.health_scale);
  return var_2;
}

calulatezombiemovemode() {
  var_0 = 7;
  var_1 = calculatezombieroundindex(var_0);
  var_2 = int(var_1 / var_0);
  return level.zombie_move_modes[int(clamp(var_2, 0, level.zombie_move_modes.size - 1))];
}

calculatezombiemoveratescale() {
  var_0 = 7;
  var_1 = calculatezombieroundindex(var_0);
  var_2 = var_1 % var_0;
  var_3 = float(var_2) / float(var_0 - 1);
  var_4 = maps\mp\zombies\_util::lerp(var_3, level.moveratescalemod[self.movemode][0], level.moveratescalemod[self.movemode][1]);

  if(level.zmbsqbusroundnum > 24) {
    var_4 = var_4 + 0.05;
  }

  if(level.zmbsqbusroundnum > 29) {
    var_4 = var_4 + 0.05;
  }

  var_4 = var_4 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
  return var_4;
}

calculatezombienonmoveratescale() {
  var_0 = level.nonmoveratescalemod[self.movemode];
  var_0 = var_0 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
  return var_0;
}

calculatezombietraverseratescale() {
  var_0 = 7;
  var_1 = calculatezombieroundindex(var_0);
  var_2 = var_1 / (level.zombie_move_modes.size * var_0 - 1.0);
  var_3 = maps\mp\zombies\_util::lerp(var_2, level.traverseratescalemod[0], level.traverseratescalemod[1]);

  if(level.zmbsqbusroundnum > 24) {
    var_3 = var_3 + 0.05;
  }

  if(level.zmbsqbusroundnum > 29) {
    var_3 = var_3 + 0.05;
  }

  var_3 = var_3 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
  return var_3;
}

calculatezombieroundindex(var_0) {
  var_1 = level.zmbsqbusroundnum - 1;

  if(isDefined(self.moverateroundmod)) {
    var_1 = var_1 + self.moverateroundmod;
  }

  var_1 = int(clamp(var_1, 0, level.zombie_move_modes.size * var_0 - 1));
  return var_1;
}

teleportplayerstobuszone() {
  level thread hideshowkillstreakicons();
  var_0 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_2 in var_0) {
    var_2 dodamage(var_2.health + 500000, var_2.origin);
  }

  var_4 = common_scripts\utility::getstructarray("sqBusPlayerSpawner", "targetname");

  if(!isDefined(var_4)) {
    var_4 = [];
    var_5 = spawnStruct();
    var_5.origin = (764, -68, 152);
    var_5.angles = (0, 190, 0);
    var_4[var_4.size] = var_5;
    var_4[var_4.size] = var_5;
    var_4[var_4.size] = var_5;
    var_4[var_4.size] = var_5;
  }

  for(var_6 = 0; var_6 < level.players.size; var_6++) {
    level.players[var_6] thread playerteleporttobuszone(var_4[var_6]);
  }

  level thread maps\mp\mp_zombie_h2o_aud::sndbusmusic();
  stopclientexploder(60);
}

playerteleporttobuszone(var_0) {
  if(!isDefined(self.memorytunnelfx)) {
    self.memorytunnelfx = spawnfxforclient(common_scripts\utility::getfx("sq_memory_tunnel_player"), self.origin, self);
    self.memorytunnelfx thread teleportfxdelete(self);
  }

  triggerfx(self.memorytunnelfx);
  self.disabletombstonedropinarea = 1;
  var_0.used = 1;
  maps\mp\zombies\_teleport::teleport_players_through_chute([self], 0, 1);
  thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self], 0.75);
  self setorigin(var_0.origin, 1);
  self setangles(var_0.angles);
  self setclientomnvar("ui_zm_ee_bool2", 1);
  self.inbuszone = 1;
  level notify("sq_player_teleport_to_bus_zone");
  thread maps\mp\mp_zombie_h2o_aud::sndteleporttobuszone();
}

teleportfxdelete(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

teleportplayersback() {
  var_0 = common_scripts\utility::getstructarray("sqExoCorePlayerSpawner", "targetname");

  if(!isDefined(var_0)) {
    var_0 = [];
    var_1 = spawnStruct();
    var_1.origin = (452, 2968, -92);
    var_1.angles = (0, 190, 0);
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_1;
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    level.players[var_2] thread playerteleportback(var_0[var_2]);
  }

  activatepersistentclientexploder(60);
}

playerteleportback(var_0) {
  if(!isDefined(self.memorytunnelfx)) {
    self.memorytunnelfx = spawnfxforclient(common_scripts\utility::getfx("sq_memory_tunnel_player"), self.origin, self);
    self.memorytunnelfx thread teleportfxdelete(self);
  }

  triggerfx(self.memorytunnelfx);
  maps\mp\zombies\_teleport::teleport_players_through_chute([self], 0, 1);
  thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self], 0.75);
  self setorigin(var_0.origin, 1);
  self setangles(var_0.angles);
  self setclientomnvar("ui_zm_ee_bool2", 0);
  self.inbuszone = undefined;
  level notify("sq_teleport_players_back");
  self.disabletombstonedropinarea = undefined;
}

hideshowkillstreakicons() {
  level.disablecarepackagedrops = 1;
  waitframe();
  var_0 = getEntArray("care_package", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread carepackagehidehudicon();
  }

  var_4 = getEntArray("goliath_pod_model", "targetname");

  foreach(var_6 in var_4) {
    var_6 thread carepackagehidehudicon();
  }

  level waittill("sq_teleport_players_back");
  level.disablecarepackagedrops = undefined;
}

carepackagehidehudicon() {
  level endon("sq_teleport_players_back");
  self endon("death");

  while(!isDefined(self.entityheadicons) || self.entityheadicons.size == 0) {
    waitframe();
  }

  foreach(var_1 in self.entityheadicons) {
    var_1.alpha = 0;
  }

  thread carepackagedelayshowhudicon();
}

carepackagedelayshowhudicon() {
  self endon("death");
  level waittill("sq_teleport_players_back");

  if(isDefined(self.entityheadicons)) {
    foreach(var_1 in self.entityheadicons) {
      var_1.alpha = 1;
    }
  }
}

init_song_sidequest() {
  level.sq_song_ent = getent("sq_song", "targetname");

  if(!isDefined(level.sq_song_ent)) {
    level.sq_song_ent = spawn("script_model", (0, 0, 0));
  }
}

sidequest_logic_song() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage1");
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage2");
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage3");
  var_3 = 0;

  for(;;) {
    var_4 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over", "song_stage2_over", "song_stage3_over");
    var_3++;

    if(var_3 < 3) {
      thread song_play(var_3);
      continue;
    }

    song_play(2);
    thread song_play();
    break;
  }
}

song_play(var_0) {
  level notify("sq_song_play");
  level endon("sq_song_play");
  level endon("sq_song_stop");

  if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing)) {
    level.sq_song_ent stopsounds();
    level.sq_song_ent.playing = 0;
    wait 0.2;
  }

  var_1 = "zmb_mus_ee_05";

  if(!isDefined(var_0) || var_0 <= 0) {
    var_0 = musiclength("zmb_mus_ee_05");
  } else {
    var_1 = "zmb_mus_ee_05_prvw";
  }

  level.sq_song_ent playsoundonmovingent(var_1);
  level.sq_song_ent.playing = 1;
  wait(var_0);
  level.sq_song_ent stopsounds();
  level.sq_song_ent.playing = 0;
}

song_stop() {
  level.sq_song_ent stopsounds();
  level.sq_song_ent.playing = 0;
  level notify("sq_song_stop");
}

song_fake_use(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "song_stage" + var_1 + "_over", var_2, var_3);
  var_4 waittill("activated", var_5);
  return var_5;
}

songstage1_init() {}

songstage1_logic() {
  var_0 = song_fake_use((-550, 2719, -76), 1, 100, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage1");
}

songstage1_end(var_0) {}

songstage2_init() {}

songstage2_logic() {
  var_0 = song_fake_use((-2000, 4506, 836), 2, 100, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage2");
}

songstage2_end(var_0) {}

songstage3_init() {}

songstage3_logic() {
  var_0 = song_fake_use((-512, 69, 181.1), 3, 160, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage3");
}

songstage3_end(var_0) {}

musiclength(var_0) {
  var_1 = tablelookup("mp/sound/soundlength_zm_mp_dlc4.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return 2;
  }

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}

dofakevo(var_0) {
  iprintlnbold(var_0);
}

dofakevomultiline(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  dofakevo(var_0);

  if(isDefined(var_1)) {
    wait 3;
    dofakevo(var_1);
  }

  if(isDefined(var_2)) {
    wait 3;
    dofakevo(var_2);
  }

  if(isDefined(var_3)) {
    wait 3;
    dofakevo(var_3);
  }

  if(isDefined(var_4)) {
    wait 3;
    dofakevo(var_4);
  }

  if(isDefined(var_5)) {
    wait 3;
    dofakevo(var_5);
  }

  if(isDefined(var_6)) {
    wait 3;
    dofakevo(var_6);
  }

  if(isDefined(var_7)) {
    wait 3;
    dofakevo(var_7);
  }

  if(isDefined(var_8)) {
    wait 3;
    dofakevo(var_8);
  }
}

playerplaysqvo(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(maps\mp\zombies\_util::is_true(self.speaking)) {
    self waittill("done_speaking");
  }

  if(!isDefined(var_3)) {
    var_3 = "sq";
  }

  var_4 = maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq", var_3, undefined, var_0);

  if(var_4 && maps\mp\zombies\_util::is_true(var_2)) {
    waitframe();
    waittillplayerdonespeaking(self);
  }

  return var_4;
}

waittillplayerdonespeaking(var_0) {
  var_0 endon("disconnect");

  if(maps\mp\zombies\_util::is_true(var_0.isspeaking)) {
    var_0 waittill("done_speaking");
  }
}

playsqvowaittilldone(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix(var_0);

  if(isDefined(var_4)) {
    var_5 = var_4 playerplaysqvo(var_1, var_2, 1);

    if(isDefined(var_3)) {
      wait(var_3);
    }

    return var_5;
  }

  return 0;
}

announcerinworldplaysqvowaittilldone(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 > 0) {
    wait(var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = level.players;
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerinworlddialog("machine_all_players", "sq", var_1, undefined, var_0, undefined, undefined, var_3);
  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

announcerglobalplaysqvo(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  if(!isDefined(var_3)) {
    var_3 = "sq";
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority", var_3, undefined, var_0, 1, undefined, var_2);
}

announcerglobalplaysqvowaittilldone(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  announcerglobalplaysqvo(var_0, var_1, var_2);
  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

announcerozglobalplaysqwaittilldone(var_0) {
  announcerozglobalplaysq(var_0);
  waittillannouncerozdonespeaking();
}

announcerozglobalplaysq(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  waittilldonespeaking();
  var_3 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  return var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "sq", undefined, var_0, 1, undefined, var_2);
}

announcerozinworldplaysq(var_0, var_1, var_2) {
  waittilldonespeaking();
  var_3 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  var_3.origin = var_0;
  waitframe();

  if(isDefined(var_2)) {
    var_2 = common_scripts\utility::array_removeundefined(var_2);
  }

  return var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", "sq", undefined, var_1, 1, undefined, var_2);
}

waittillannouncerozdonespeaking(var_0) {
  if(!isDefined(var_0)) {
    var_0 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  }

  if(maps\mp\zombies\_util::is_true(var_0.isspeaking)) {
    var_0 waittill("done_speaking");
  }
}

announcerozglobalplaysqfailchallenge() {
  if(!isDefined(level.sqozwonchallengevo) || level.sqozwonchallengevoindex >= level.sqozwonchallengevo.size) {
    level.sqozwonchallengevo = common_scripts\utility::array_randomize([3, 4, 5, 6, 7, 8, 9, 10]);
    level.sqozwonchallengevoindex = 0;
  }

  announcerozglobalplaysq(level.sqozwonchallengevo[level.sqozwonchallengevoindex]);
  level.sqozwonchallengevoindex++;
}

anyplayersspeaking() {
  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_1.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

waittilldonespeaking() {
  while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking()) {
    waitframe();
  }
}