/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\infect.gsc
*************************************************/

#using scripts\mp\_teamops;
#using scripts\mp\_util;
#using scripts\mp\bots\_bot;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_spawn;
#using scripts\mp\gametypes\_globallogic_ui;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\gametypes\_spectating;
#using scripts\mp\gametypes\_wager;
#using scripts\mp\teams\_teams;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\util_shared;
#namespace infect;

function main() {
  globallogic::init();
  level.var_f817b02b = 1;
  level.var_b7bd625 = getweapon("pistol_standard");
  level.var_55c74d4a = getweapon("melee_boneglass");
  level.var_6fd3f827 = getweapon("hatchet");
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
  level.teamscoreperkill = getgametypesetting("teamScorePerKill");
  level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
  level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
  level.teambased = 1;
  level.overrideteamscore = 1;
  level.onstartgametype = &onstartgametype;
  level.onendgame = &onendgame;
  level.onspawnplayer = &onspawnplayer;
  level.onroundendgame = &onroundendgame;
  level.onroundswitch = &onroundswitch;
  level.onplayerkilled = &onplayerkilled;
  level.var_859df572 = &function_859df572;
  level.gettimelimit = &gettimelimit;
  level.var_ad0ac054 = &function_e7129db9;
  callback::on_connect(&onplayerconnect);
  callback::on_disconnect(&onplayerdisconnect);
  callback::on_joined_team(&onplayerjoinedteam);
  callback::on_joined_spectate(&function_27abe9eb);
  gameobjects::register_allowed_gameobject(level.gametype);
  if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "infects", "deaths", "assists");
  } else {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "infects", "assists");
  }
  level.givecustomloadout = &givecustomloadout;
  level.var_485556b = &function_485556b;
  level.ontimelimit = &ontimelimit;
  level.maydropweapon = &maydropweapon;
  var_ad774848 = [];
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_longersprint";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_quieter";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_loudenemies";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_movefaster";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_jetnoradar";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_jetquiet";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_fallheight";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_fastladderclimb";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_fastmantle";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_fastreload";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_detectexplosive";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_bulletaccuracy";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_stalker";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_jetcharger";
  if(!isDefined(var_ad774848)) {
    var_ad774848 = [];
  } else if(!isarray(var_ad774848)) {
    var_ad774848 = array(var_ad774848);
  }
  var_ad774848[var_ad774848.size] = "specialty_overcharge";
  level.var_ad774848 = var_ad774848;
  var_206b5e08 = [];
  if(!isDefined(var_206b5e08)) {
    var_206b5e08 = [];
  } else if(!isarray(var_206b5e08)) {
    var_206b5e08 = array(var_206b5e08);
  }
  var_206b5e08[var_206b5e08.size] = "gadget_camo";
  if(!isDefined(var_206b5e08)) {
    var_206b5e08 = [];
  } else if(!isarray(var_206b5e08)) {
    var_206b5e08 = array(var_206b5e08);
  }
  var_206b5e08[var_206b5e08.size] = "gadget_clone";
  if(!isDefined(var_206b5e08)) {
    var_206b5e08 = [];
  } else if(!isarray(var_206b5e08)) {
    var_206b5e08 = array(var_206b5e08);
  }
  var_206b5e08[var_206b5e08.size] = "gadget_armor";
  level.var_206b5e08 = var_206b5e08;
}

function onstartgametype() {
  setclientnamemode("auto_change");
  game["defenders"] = "allies";
  game["attackers"] = "axis";
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }
  level.displayroundendtext = 0;
  spawning::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.teams) {
    util::setobjectivetext(team, &"OBJECTIVES_INFECT");
    util::setobjectivehinttext(team, &"OBJECTIVES_INFECT_HINT");
    util::setobjectivescoretext(team, &"OBJECTIVES_INFECT");
    spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
    spawnlogic::place_spawn_points(spawning::gettdmstartspawnname(team));
  }
  spawning::updateallspawnpoints();
  level.spawn_start = [];
  foreach(team in level.teams) {
    level.spawn_start[team] = spawnlogic::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
  }
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  if(!util::isoneround()) {
    level.displayroundendtext = 1;
    if(level.scoreroundwinbased) {
      globallogic_score::resetteamscores();
    }
  }
  level.infect_chosefirstinfected = 0;
  level.infect_choosingfirstinfected = 0;
  level.infect_allowsuicide = 0;
  level.infect_awardedfinalsurvivor = 0;
  level.infect_players = [];
  inithud();
  level thread function_897ac191();
  maxfree = getdvarint("bot_maxFree", 0);
  level thread bot::monitor_bot_population(maxfree);
  level thread function_d07961fd();
  level thread function_938d075f();
}

function function_8dde4d1f() {
  function_f72d8c1c(game["attackers"], "MPUI_INFECTED");
  function_f72d8c1c(game["defenders"], "MPUI_SURVIVORS");
}

function function_f72d8c1c(team, name) {
  var_19719540 = "g_customTeamName_" + team;
  if(getdvarstring(var_19719540) == "") {
    setdvar(var_19719540, name);
  }
}

function onendgame(winningteam) {
  if(!util::isoneround() && !util::islastround()) {
    function_22765af9(winningteam);
  }
}

function function_22765af9(winningteam) {
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].pers["team"])) {
      continue;
    }
    if(level.hostforcedend && players[i] ishost()) {
      continue;
    }
    if(winningteam == "tie") {
      globallogic_score::updatetiestats(players[i]);
      continue;
    }
    if(players[i].pers["team"] == winningteam) {
      globallogic_score::updatewinstats(players[i]);
      continue;
    }
    if(level.rankedmatch && !level.leaguematch && players[i].pers["lateJoin"] === 1) {
      globallogic_score::updatelosslatejoinstats(players[i]);
    }
    if(!level.disablestattracking) {
      players[i] setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
    }
  }
}

function inithud() {
  level.var_796fada2 = hud::createservertimer("objective", 1.5);
  level.var_796fada2 hud::setpoint("CENTER", undefined, 0, 50);
  level.var_796fada2.label = &"MP_DRAFT_STARTS_IN";
  level.var_796fada2.alpha = 0;
  level.var_796fada2.archived = 0;
  level.var_796fada2.hidewheninmenu = 1;
  level.var_a3c7456d = hud::createserverfontstring("objective", 1.5);
  level.var_a3c7456d hud::setpoint("CENTER", undefined, 0, 50);
  level.var_a3c7456d.label = &"MP_INFECTED_TIME_EXTENDED";
  level.var_a3c7456d.alpha = 0;
  level.var_a3c7456d.archived = 0;
  level.var_a3c7456d.hidewheninmenu = 1;
}

function onplayerconnect() {
  self.var_e8432f46 = 1;
  self.var_10054897 = level.inprematchperiod;
  if(self.sessionteam != "spectator") {
    self.pers["needteam"] = 1;
  }
  playerxuid = self getxuid();
  if(isDefined(level.infect_players[playerxuid])) {
    self.var_1df9e01d = 1;
  }
  self.var_d1d70226 = 1;
}

function onplayerjoinedteam() {
  if(self.team == game["attackers"]) {
    self.disableclassselection = 1;
  } else {
    self.disableclassselection = undefined;
  }
}

function function_485556b(player, comingfrommenu) {
  if(!comingfrommenu && player.sessionteam == "spectator") {
    teamname = "spectator";
  } else {
    if(isDefined(level.var_8d48cf10) && level.var_8d48cf10) {
      level.var_8d48cf10 = undefined;
      teamname = game["defenders"];
      level thread function_93f386c5();
    } else {
      if(isDefined(player.var_1df9e01d) && player.var_1df9e01d || (isDefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected)) {
        teamname = game["attackers"];
      } else {
        teamname = game["defenders"];
      }
    }
  }
  return teamname;
}

function function_dc5fbf33() {
  started_waiting = gettime();
  while(!self isstreamerready(-1, 1) && (started_waiting + 90000) > gettime()) {
    wait(0.05);
  }
}

function onspawnplayer(predictedspawn) {
  if(level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
    level.usestartspawns = 0;
  }
  updateteamscores();
  if(self.team == game["attackers"]) {
    function_e834578f();
  }
  if(!level.infect_choosingfirstinfected) {
    level.infect_choosingfirstinfected = 1;
    level thread choosefirstinfected();
  }
  spawning::onspawnplayer(predictedspawn);
}

function onroundswitch() {
  game["switchedsides"] = !game["switchedsides"];
}

function onroundendgame(roundwinner) {
  if(level.scoreroundwinbased) {
    foreach(team in level.teams) {
      [
        [level._setteamscore]
      ](team, game["roundswon"][team]);
    }
  }
  return [[level.determinewinner]]();
}

function function_b3349c22() {
  return self.pers["time_played_moving"] > 0;
}

function function_40cc7792(team, var_eb4caf58, var_852860b4) {
  players = getplayersonteam(team);
  foreach(player in players) {
    player luinotifyevent(&"player_callout", 2, var_eb4caf58, var_852860b4);
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  processkill = 0;
  wassuicide = 0;
  if(self.team == game["defenders"] && isDefined(attacker)) {
    if(level.friendlyfire > 0 && isDefined(attacker.team) && attacker.team == self.team) {
      processkill = 0;
    } else {
      if(isplayer(attacker) && attacker != self) {
        processkill = 1;
      } else if(level.infect_allowsuicide && (attacker == self || !isplayer(attacker))) {
        processkill = 1;
        wassuicide = 1;
      }
    }
  }
  if(!processkill) {
    return;
  }
  if(!wassuicide) {
    scoreevents::processscoreevent("infected_survivor", attacker, self, weapon);
    if(isDefined(attacker.pers["infects"])) {
      attacker.pers["infects"] = attacker.pers["infects"] + 1;
      attacker.infects = attacker.pers["infects"];
    }
    attacker addplayerstatwithgametype("INFECTS", 1);
  }
  level thread function_e523aca(self, wassuicide);
}

function function_e523aca(victim, wassuicide) {
  level endon("game_ended");
  waittillframeend();
  if(isDefined(victim.laststand)) {
    result = victim function_a27aff1a();
    if(result === "player_input_revive") {
      return;
    }
  }
  wait(0.05);
  if(isDefined(victim)) {
    level thread function_34c8bd01();
    function_f65059ce(victim);
    function_e834578f();
  }
  var_7dc99dab = [[level._getteamscore]](game["defenders"]);
  if(var_7dc99dab > 1 && isDefined(victim)) {
    sound::play_on_players("mpl_flagget_sting_enemy", game["defenders"]);
    sound::play_on_players("mpl_flagget_sting_friend", game["attackers"]);
    function_40cc7792(game["defenders"], &"MP_GOT_INFECTED", victim.entnum);
    if(!wassuicide) {
      function_40cc7792(game["attackers"], &"SCORE_INFECTED_SURVIVOR", victim.entnum);
      survivors = getplayersonteam(game["defenders"]);
      foreach(survivor in survivors) {
        if(survivor != victim && survivor function_b3349c22()) {
          survivor scoreevents::processscoreevent("survivor_still_alive", survivor);
        }
      }
    }
  } else {
    if(var_7dc99dab == 1) {
      onfinalsurvivor();
    } else if(var_7dc99dab == 0) {
      onsurvivorseliminated();
    }
  }
}

function function_a27aff1a() {
  level endon("game_ended");
  self endon("disconnect");
  return self util::waittill_any_return("player_input_revive", "death");
}

function onfinalsurvivor() {
  if(isDefined(level.var_c1bb459e) && level.var_c1bb459e) {
    return;
  }
  sound::play_on_players("mpl_ballreturn_sting");
  var_53fb74fd = getplayersonteam(game["defenders"])[0];
  if(!level.infect_awardedfinalsurvivor) {
    var_53fb74fd function_d24c1b2e();
    if(var_53fb74fd.var_10054897 && var_53fb74fd function_b3349c22()) {
      var_53fb74fd scoreevents::processscoreevent("final_survivor", var_53fb74fd);
    }
    level.infect_awardedfinalsurvivor = 1;
  }
  luinotifyevent(&"player_callout", 2, &"SCORE_FINAL_SURVIVOR", var_53fb74fd.entnum);
  var_e8414f44 = getdvarint("scr_infect_finaluav");
  if(var_e8414f44) {
    level thread finalsurvivoruav(var_53fb74fd);
  }
  level.var_c1bb459e = 1;
}

function function_d24c1b2e() {
  if(!isDefined(self.heroweapon)) {
    return;
  }
  var_16c7dd95 = self gadgetgetslot(self.heroweapon);
  if(self gadgetisready(var_16c7dd95)) {
    return;
  }
  self gadgetpowerset(var_16c7dd95, 100);
}

function finalsurvivoruav(var_53fb74fd) {
  level endon("game_ended");
  var_53fb74fd endon("disconnect");
  var_53fb74fd endon("death");
  level endon("infect_latejoiner");
  level thread enduavonlatejoiner(var_53fb74fd);
  setteamspyplane(game["attackers"], 1);
  util::set_team_radar(game["attackers"], 1);
  removeuav = 0;
  while(true) {
    prevpos = var_53fb74fd.origin;
    wait(4);
    if(removeuav) {
      setteamspyplane(game["attackers"], 0);
      util::set_team_radar(game["attackers"], 0);
      removeuav = 0;
    }
    wait(6);
    if(distancesquared(prevpos, var_53fb74fd.origin) < (200 * 200)) {
      setteamspyplane(game["attackers"], 1);
      util::set_team_radar(game["attackers"], 1);
      removeuav = 1;
      foreach(player in level.players) {
        sound::play_on_players("fly_hunter_raise_plr");
      }
    }
  }
}

function enduavonlatejoiner(var_53fb74fd) {
  level endon("game_ended");
  var_53fb74fd endon("disconnect");
  var_53fb74fd endon("death");
  while(true) {
    var_7dc99dab = [[level._getteamscore]](game["defenders"]);
    if(var_7dc99dab > 1) {
      level notify("infect_latejoiner");
      wait(0.05);
      setteamspyplane(game["attackers"], 1);
      util::set_team_radar(game["attackers"], 1);
      break;
    }
    wait(0.05);
  }
}

function ontimelimit() {
  winner = game["defenders"];
  level thread endgame(winner, game["strings"]["time_limit_reached"]);
}

function onsurvivorseliminated() {
  updateteamscores();
  winner = game["attackers"];
  loser = util::getotherteam(winner);
  level thread endgame(winner, game["strings"][loser + "_eliminated"]);
}

function endgame(winner, endreasontext) {
  if(isDefined(level.var_15e262e5) && level.var_15e262e5) {
    return;
  }
  level.var_15e262e5 = 1;
  util::wait_network_frame();
  globallogic::endgame(winner, endreasontext);
}

function function_27abe9eb() {
  function_ca9945d6();
}

function onplayerdisconnect() {
  function_ca9945d6();
}

function function_ca9945d6() {
  if(isDefined(level.gameended) && level.gameended) {
    return;
  }
  updateteamscores();
  var_9cc4807f = [[level._getteamscore]](game["attackers"]);
  var_7dc99dab = [[level._getteamscore]](game["defenders"]);
  if(isDefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
    if(var_9cc4807f > 0 && var_7dc99dab > 0) {
      if(var_7dc99dab == 1) {
        onfinalsurvivor();
      }
    } else {
      if(var_7dc99dab == 0) {
        onsurvivorseliminated();
      } else if(var_9cc4807f == 0) {
        if(var_7dc99dab == 1) {
          winner = game["defenders"];
          loser = util::getotherteam(winner);
          level thread endgame(winner, game["strings"][loser + "_eliminated"]);
        } else if(var_7dc99dab > 1) {
          level.infect_chosefirstinfected = 0;
          level thread choosefirstinfected();
        }
      }
    }
  } else {
    var_c2df8eb5 = function_d418a8fd(game["defenders"]);
    if(var_c2df8eb5.size < 1) {
      level notify("infect_stopcountdown");
    }
  }
}

function givecustomloadout(takeallweapons, alreadyspawned) {
  if(self.team == game["attackers"]) {
    self function_4fe19a2e();
    self.movementspeedmodifier = 1.2;
  } else if(self.team == game["defenders"]) {
    self function_bce75136();
    self.movementspeedmodifier = undefined;
  }
  return self.spawnweapon;
}

function function_bce75136() {
  loadout::giveloadout_init(1);
  loadout::setclassnum(self.curclass);
  self setactionslot(3, "altMode");
  self setactionslot(4, "");
  allocationspent = self getloadoutallocation(self.class_num);
  overallocation = allocationspent > level.maxallocation;
  if(!overallocation) {
    giveperks();
    loadout::giveweapons();
    loadout::giveprimaryoffhand();
  } else {
    loadout::givebaseweapon();
  }
  loadout::givesecondaryoffhand();
  if(getdvarint("tu11_enableClassicMode") == 0) {
    loadout::givespecialoffhand();
    loadout::giveheroweapon();
  }
  loadout::givekillstreaks();
}

function giveperks() {
  self.specialty = self getloadoutperks(self.class_num);
  if(level.leaguematch) {
    for(i = 0; i < self.specialty.size; i++) {
      if(loadout::isleagueitemrestricted(self.specialty[i])) {
        arrayremoveindex(self.specialty, i);
        i--;
      }
    }
  }
  self loadout::register_perks();
  anteup_bonus = getdvarint("perk_killstreakAnteUpResetValue");
  momentum_at_spawn_or_game_end = (isDefined(self.pers["momentum_at_spawn_or_game_end"]) ? self.pers["momentum_at_spawn_or_game_end"] : 0);
  hasnotdonecombat = !self.hasdonecombat === 1;
  if(level.inprematchperiod || (level.ingraceperiod && hasnotdonecombat) && momentum_at_spawn_or_game_end < anteup_bonus) {
    new_momentum = (self hasperk("specialty_anteup") ? anteup_bonus : momentum_at_spawn_or_game_end);
    globallogic_score::_setplayermomentum(self, new_momentum, 0);
  }
}

function function_4fe19a2e() {
  self loadout::giveloadout_init(1);
  loadout::setclassnum(self.curclass);
  self clearperks();
  foreach(perkname in level.var_ad774848) {
    if(!self hasperk(perkname)) {
      self setperk(perkname);
    }
  }
  var_9cc4807f = [[level._getteamscore]](game["attackers"]);
  if(var_9cc4807f == 1) {
    defaultweapon = level.var_b7bd625;
  } else {
    defaultweapon = level.var_55c74d4a;
  }
  self function_84503315(defaultweapon);
  self switchtoweapon(defaultweapon);
  self setspawnweapon(defaultweapon);
  self.spawnweapon = defaultweapon;
  primaryoffhand = level.var_6fd3f827;
  primaryoffhandcount = 1;
  self giveweapon(primaryoffhand);
  self setweaponammostock(primaryoffhand, primaryoffhandcount);
  self switchtooffhand(primaryoffhand);
  self.grenadetypeprimary = primaryoffhand;
  self.grenadetypeprimarycount = primaryoffhandcount;
  secondaryoffhand = getweapon("null_offhand_secondary");
  secondaryoffhandcount = 0;
  self giveweapon(secondaryoffhand);
  self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
  self switchtooffhand(secondaryoffhand);
  self.grenadetypesecondary = secondaryoffhand;
  self.grenadetypesecondarycount = secondaryoffhandcount;
  self giveweapon(level.weaponbasemelee);
  function_39be730b();
  self.heroweapon = undefined;
}

function function_39be730b() {
  specialoffhand = self.var_55849a30;
  var_a664ae9a = 0;
  if(!isDefined(specialoffhand)) {
    var_9a4ea9ec = array::random(level.var_206b5e08);
    specialoffhand = getweapon(var_9a4ea9ec);
    var_a664ae9a = 1;
  }
  specialoffhandcount = specialoffhand.startammo;
  self giveweapon(specialoffhand);
  self setweaponammoclip(specialoffhand, specialoffhandcount);
  self switchtooffhand(specialoffhand);
  self.grenadetypespecial = specialoffhand;
  self.grenadetypespecialcount = specialoffhandcount;
  if(isDefined(var_a664ae9a) && var_a664ae9a) {
    slot = self gadgetgetslot(specialoffhand);
    self gadgetpowerreset(slot);
  }
  self.var_55849a30 = specialoffhand;
}

function choosefirstinfected() {
  level endon("game_ended");
  level endon("infect_stopcountdown");
  level.infect_allowsuicide = 0;
  level.var_93e2155b = undefined;
  if(level.inprematchperiod) {
    level waittill("prematch_over");
  }
  level.var_796fada2.label = &"MP_DRAFT_STARTS_IN";
  level.var_796fada2 settimer(8);
  level.var_796fada2.alpha = 1;
  hostmigration::waitlongdurationwithhostmigrationpause(8);
  level.var_796fada2.alpha = 0;
  var_c2df8eb5 = function_d418a8fd(game["defenders"]);
  if(var_c2df8eb5.size > 0) {
    var_c2df8eb5[getarraykeys(var_c2df8eb5)[randomint(getarraykeys(var_c2df8eb5).size)]] setfirstinfected();
  } else {
    level.infect_choosingfirstinfected = 0;
  }
}

function function_d07961fd() {
  while(true) {
    event = level util::waittill_any_return("game_ended", "infect_stopCountdown");
    if(isDefined(level.var_796fada2)) {
      level.var_796fada2.alpha = 0;
    }
    if(event == "game_ended") {
      return;
    }
    level.infect_choosingfirstinfected = 0;
  }
}

function function_34c8bd01() {
  level notify("hash_14015a9");
  level endon("game_ended");
  level endon("infect_stoptimeextended");
  level endon("hash_14015a9");
  timeout = 0;
  while(isDefined(level.var_796fada2) && level.var_796fada2.alpha > 0) {
    hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    timeout++;
    if(timeout == 20) {
      return;
    }
  }
  level.var_a3c7456d.alpha = 1;
  hostmigration::waitlongdurationwithhostmigrationpause(1);
  level.var_a3c7456d fadeovertime(2);
  level.var_a3c7456d.alpha = 0;
}

function function_938d075f() {
  while(true) {
    event = level util::waittill_any_return("game_ended", "infect_stopTimeExtended");
    if(isDefined(level.var_a3c7456d)) {
      level.var_a3c7456d.alpha = 0;
    }
    if(event == "game_ended") {
      return;
    }
  }
}

function function_d418a8fd(team) {
  activeplayers = [];
  teamplayers = getplayersonteam(team);
  foreach(player in teamplayers) {
    if(player.sessionstate == "spectator") {
      continue;
    }
    if(!isDefined(activeplayers)) {
      activeplayers = [];
    } else if(!isarray(activeplayers)) {
      activeplayers = array(activeplayers);
    }
    activeplayers[activeplayers.size] = player;
  }
  return activeplayers;
}

function setfirstinfected() {
  self endon("disconnect");
  self.infect_isbeingchosen = 1;
  while(!isalive(self) || self util::isusingremote()) {
    wait(0.05);
  }
  if(isDefined(self.iscarrying) && self.iscarrying) {
    self notify("force_cancel_placement");
    wait(0.05);
  }
  while(self ismantling()) {
    wait(0.05);
  }
  while(!self isonground() && !self isonladder()) {
    wait(0.05);
  }
  function_f65059ce(self);
  self.switching_teams = undefined;
  if(self isusingoffhand()) {
    self forceoffhandend();
  }
  self disableoffhandspecial();
  self thread function_4c6fd26d();
  loadout::giveloadout(self.team, self.curclass);
  var_7dc99dab = [[level._getteamscore]](game["defenders"]);
  if(var_7dc99dab < 1) {
    level.var_8d48cf10 = 1;
  } else {
    forcespawnteam(game["defenders"]);
  }
  luinotifyevent(&"player_callout", 2, &"SCORE_FIRST_INFECTED", self.entnum);
  scoreevents::processscoreevent("first_infected", self);
  sound::play_on_players("mpl_flagget_sting_enemy");
  level.infect_allowsuicide = 1;
  level.infect_chosefirstinfected = 1;
  self.infect_isbeingchosen = undefined;
}

function forcespawnteam(team) {
  players = getplayersonteam(team);
  foreach(player in players) {
    player thread playerforcespawn();
  }
}

function playerforcespawn() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  self function_dc5fbf33();
  self.pers["class"] = level.defaultclass;
  self.curclass = level.defaultclass;
  self globallogic_ui::closemenus();
  self closemenu("ChooseClass_InGame");
  self thread[[level.spawnclient]]();
}

function function_f65059ce(player) {
  function_e90123d3(player);
  function_fb693482(player);
  player changeteam(game["attackers"]);
  updateteamscores();
  function_c30d35d6();
}

function function_4c6fd26d() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("weapon_change");
  self enableoffhandspecial();
}

function function_e90123d3(player) {
  playerxuid = player getxuid();
  level.infect_players[playerxuid] = 1;
}

function changeteam(team) {
  if(self.sessionstate != "dead") {
    self.switching_teams = 1;
    self.switchedteamsresetgadgets = 1;
    self.joining_team = team;
    self.leaving_team = self.pers["team"];
  }
  self.pers["team"] = team;
  self.team = team;
  self.pers["weapon"] = undefined;
  self.pers["spawnweapon"] = undefined;
  self.pers["savedmodel"] = undefined;
  self.pers["teamTime"] = undefined;
  self.sessionteam = self.pers["team"];
  self globallogic_ui::updateobjectivetext();
  self spectating::set_permissions();
  self notify("end_respawn");
}

function getplayersonteam(team) {
  playersonteam = [];
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    playerteam = player.pers["team"];
    if(isDefined(playerteam) && isDefined(level.teams[playerteam]) && playerteam == team) {
      if(!isDefined(playersonteam)) {
        playersonteam = [];
      } else if(!isarray(playersonteam)) {
        playersonteam = array(playersonteam);
      }
      playersonteam[playersonteam.size] = player;
    }
  }
  return playersonteam;
}

function function_bf7761ac(team) {
  playersonteam = getplayersonteam(team);
  return playersonteam.size;
}

function updateteamscores() {
  updateteamscore(game["attackers"]);
  updateteamscore(game["defenders"]);
}

function updateteamscore(team) {
  score = function_bf7761ac(team);
  game["teamScores"][team] = score;
  globallogic_score::updateteamscores(team);
}

function maydropweapon(weapon) {
  if(self.team === game["attackers"]) {
    return false;
  }
  return true;
}

function function_84503315(weapon) {
  self giveweapon(weapon);
  self givestartammo(weapon);
  self setblockweaponpickup(weapon, 1);
  self.var_9ac00079 = weapon;
}

function function_e834578f() {
  attackers = getplayersonteam(game["attackers"]);
  if(attackers.size < 2) {
    return;
  }
  foreach(player in attackers) {
    if(!isalive(player)) {
      continue;
    }
    if(player.var_9ac00079 !== level.var_55c74d4a) {
      if(isDefined(player.var_9ac00079)) {
        player takeweapon(player.var_9ac00079);
      }
      newweapon = level.var_55c74d4a;
      player function_84503315(newweapon);
      player switchtoweapon(newweapon);
    }
  }
}

function function_859df572(weapon, var_a76a1b22) {
  if(weapon == self.grenadetypeprimary || weapon == self.grenadetypesecondary) {
    return 0;
  }
  return var_a76a1b22;
}

function function_c30d35d6() {
  level.var_93e2155b = gettime();
}

function gettimelimit() {
  var_6b74a930 = getgametypesetting("timeLimit");
  if(var_6b74a930 == 0) {
    return 0;
  }
  if(!isDefined(level.var_93e2155b)) {
    return 0;
  }
  var_22ff0aac = ((level.var_93e2155b - level.starttime) + 1000) / 60000;
  timelimit = var_22ff0aac + var_6b74a930;
  return timelimit;
}

function function_fb693482(player) {
  for(i = 0; i < level.missileentities.size; i++) {
    item = level.missileentities[i];
    if(!isDefined(item)) {
      continue;
    }
    if(!isDefined(item.weapon)) {
      continue;
    }
    if(item.owner !== player && item.originalowner !== player) {
      continue;
    }
    item notify("detonating");
    if(isDefined(item)) {
      item delete();
    }
  }
}

function function_c17c938d(winner, endtype, endreasontext, outcometext, team, winnerenum, notifyroundendtoui, matchbonus) {
  if(endtype == "roundend") {
    if(winner == "tie") {
      outcometext = game["strings"]["draw"];
    } else {
      if(isDefined(self.pers["team"]) && winner == team) {
        outcometext = game["strings"]["victory"];
        overridespectator = 1;
      } else {
        outcometext = game["strings"]["defeat"];
        if(level.rankedmatch || level.leaguematch && self.pers["lateJoin"] === 1) {
          endreasontext = game["strings"]["join_in_progress_loss"];
        }
        overridespectator = 1;
      }
    }
    notifyroundendtoui = 0;
    if(team == "spectator" && overridespectator) {
      foreach(team in level.teams) {
        if(endreasontext == (game["strings"][team + "_eliminated"])) {
          endreasontext = game["strings"]["cod_caster_team_eliminated"];
          break;
        }
      }
      outcometext = game["strings"]["cod_caster_team_wins"];
    }
    self luinotifyevent(&"show_outcome", 5, outcometext, endreasontext, int(matchbonus), winnerenum, notifyroundendtoui);
    return true;
  }
  return false;
}

function function_7ce7fbed(player) {
  if(player.team === game["attackers"]) {
    playerweapon = player getcurrentweapon();
    if(isDefined(playerweapon.worldmodel)) {
      return playerweapon;
    }
  }
  return undefined;
}

function function_93f386c5() {
  level endon("game_ended");
  level notify("hash_10030d46");
  level endon("hash_10030d46");
  wait(30);
  forcespawnteam(game["defenders"]);
}

function function_e7129db9(var_5d733658) {
  var_5d733658 hidefromteam(game["attackers"]);
}

function function_fb550fe9(dvarname, var_c0c93d2) {
  setdvar(dvarname, "");
  while(true) {
    wait(0.05);
    dvarvalue = getdvarstring(dvarname);
    if(dvarvalue == "") {
      continue;
    }
    setdvar(dvarname, "");
    tokens = strtok(dvarvalue, "");
    if(!isDefined(tokens) || tokens.size < 1) {
      continue;
    }
    command = tokens[0];
    arrayremoveindex(tokens, 1);
    [[var_c0c93d2]](command, tokens);
  }
}

function function_27ccd53(command, args) {
  switch (command) {
    case "": {
      foreach(player in level.players) {
        if(player util::is_bot()) {
          player kill();
        }
      }
      break;
    }
    default: {
      break;
    }
  }
}

function function_897ac191() {
  level thread function_fb550fe9("", &function_27ccd53);
  level flag::wait_till("");
  var_126022b3 = "";
  adddebugcommand((((var_126022b3 + "") + "") + "") + "");
}