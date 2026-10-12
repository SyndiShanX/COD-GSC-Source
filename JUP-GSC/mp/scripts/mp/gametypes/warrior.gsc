/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\warrior.gsc
***********************************************/

#using script_133ea27280b07bc2;
#using script_146d12c281f80426;
#using script_1691191ee7a81f1e;
#using script_25f7a26c5200ba6d;
#using script_294f6be0d87c3600;
#using script_2f382e6c1908fbd4;
#using script_30e688bfc7d547ae;
#using script_32e45a09983017e;
#using script_3bdadfff7554ceba;
#using script_42e17fdd8c77a57;
#using script_4da53161e7ca9970;
#using script_5331cbd5b243e8e7;
#using script_53ca2cad11025a0f;
#using script_55af858a93ca2439;
#using script_6231da148afb3247;
#using script_66a3a1958fd958e7;
#using script_70a02791462720d9;
#using script_7163a90de898cc17;
#using script_737192aa82af4a27;
#using script_7473976f0e6c2030;
#using script_7c29f8a58f851e08;
#using script_924961495eb0ab1;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace warrior;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 3);
    registerroundlimitdvar(getgametype(), 2);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
  }

  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onscorelimit = &onscorelimit;
  level.endgame = &endgame;
  level.onplayerkilled = &onplayerkilled;
  level.getactiveequipmentarray = &scripts\mp\weapons::getactiveequipmentarray;
  level.mines = [];
  level.onplayerjointeam = &onplayerjointeam;
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  level.modeonspawnplayer = &onspawnplayer;
  level.roundenddelay = 4;
  updategametypedvars();

  setdvarifuninitialized(@ "hash_57ce7409e4c27ebd", "<dev string:x1c>");

  namespace_2c19af30dc7a566c::function_4a18dd73a966821e(2);
  namespace_2c19af30dc7a566c::function_6cce72ce8bb6af87(["allies", "axis", "team_three"]);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  if(isDefined(level.initspawnsoverridefunc)) {
    [[level.initspawnsoverridefunc]]();
  } else {
    initspawns();
  }

  if(!isDefined(game["minigames"]) || game["minigames"].size == 0 || !function_cfc9bf375c442d87()) {
    function_4a4c1e886036be4e();
  }

  function_93d4ef801ec5a9d3();
  thread waittooverridegraceperiod();
}

function updategametypedvars() {
  setDvar(@ "hash_58f6ddd5e5892406", 0);
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function initspawns() {
  if(getdvarint(@ "hash_742caa13b3c2e685")) {
    return;
  }

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  spawnteam = self.pers["team"];

  if(level.var_6298f362ec23d83.ref == "revive") {
    spawnteam = namespace_2cda60670556b724::getspawnteam();
  }

  spawnpoint = undefined;

  if(!isDefined(level.var_9e03b52348acaff)) {
    level.var_9e03b52348acaff = [];
  }

  if(!isDefined(level.var_9e03b52348acaff[spawnteam])) {
    level.var_9e03b52348acaff[spawnteam] = [];
  }

  var_cafc02fbf308d35b = level.teamnamelist;

  for(i = 0; i < game["roundsPlayed"]; i++) {
    var_cafc02fbf308d35b = array_add(var_cafc02fbf308d35b, var_cafc02fbf308d35b[0]);
    var_cafc02fbf308d35b = array_slice(var_cafc02fbf308d35b, 1, level.teamnamelist.size + 1);
  }

  teams_key = [];

  foreach(index, team in level.teamnamelist) {
    teams_key[team] = var_cafc02fbf308d35b[index];
  }

  if(level.var_6298f362ec23d83.ref == "dontshoot" || level.var_6298f362ec23d83.ref == "shoot") {
    spawns = getspawnarray("mp_warrior_spawn_" + teams_key[spawnteam] + "_start_ds");
  } else if(level.var_6298f362ec23d83.ref == "beatupthecar") {
    spawns = getspawnarray("mp_warrior_spawn_" + teams_key[spawnteam] + "_start_car");
  } else {
    spawns = getspawnarray("mp_warrior_spawn_" + teams_key[spawnteam] + "_start");
  }

  foreach(spawner in spawns) {
    if(isDefined(level.mapname) && level.mapname == "mp_jup_karachi") {
      if(isDefined(spawner.classname) && (spawner.classname == "mp_warrior_spawn_allies_start" || spawner.classname == "mp_warrior_spawn_allies_start_ds")) {
        if(isDefined(spawner.origin)) {
          if(spawner.origin[0] == 288 && spawner.origin[1] == 2416) {
            continue;
          }
        }
      }
    }

    if(isDefined(level.var_9e03b52348acaff[spawnteam][spawner.index])) {
      continue;
    }

    level.var_9e03b52348acaff[spawnteam][spawner.index] = spawner;
    return spawner;
  }

  return random(spawns);
}

function function_4a4c1e886036be4e() {
  game["minigames"] = [];
  game["minigames_revivePlayed"] = 0;
  function_a747d75f79124d88("knives", getdvarint(@ "hash_5a9e63951cf7044f", 1), &function_bdabea561d7e97b1, &function_6368ff608fe6c16f);
  function_a747d75f79124d88("breacher", getdvarint(@ "hash_f66bf55074b120a7", 1), &function_1e328551d2f6d389, &function_6368ff608fe6c16f, &function_5e68e790dbe88d75);
  function_a747d75f79124d88("miniguns", getdvarint(@ "hash_d4c7c6412cf0c951", 1), &function_d8ab130aa8874e6b, &function_6368ff608fe6c16f, &function_eb881ddfad8bc7eb);
  function_a747d75f79124d88("serpentine", getdvarint(@ "hash_6ce57dc0855c72e8", 1), &function_c9cfdf276fba4138, &function_6368ff608fe6c16f, &function_cccdb1b3d660c940);
  function_a747d75f79124d88("dontshoot", getdvarint(@ "hash_fcd575c96456d747", 1), &function_3c1a6c0c2ccb4869, &function_6368ff608fe6c16f, undefined, 15);
  function_a747d75f79124d88("ninja", getdvarint(@ "hash_21d61c37e3afd0d", 1), &function_575e0b9cb7ee4d8f, &function_6368ff608fe6c16f, &function_b56a350cf32bf14f);
  function_a747d75f79124d88("fragged", getdvarint(@ "hash_9167a457b07c89d1", 1), &function_46e09220a05bae5f, &function_6368ff608fe6c16f, &function_afa6a2ae298ee59f);
  function_a747d75f79124d88("metagame", getdvarint(@ "hash_dbe9772d27e2f590", 1), &function_84ff73203e4fc8a4, &function_6368ff608fe6c16f);
  function_a747d75f79124d88("turrettime", getdvarint(@ "hash_98fe55d205fb584", 1), &function_f1e15d6ce495e904, &function_6368ff608fe6c16f, &function_6e36432069ac5ccc, 90);
  function_a747d75f79124d88("dronewars", getdvarint(@ "hash_4c30f0f2c236031a", 1), &function_fc973eaad5032286, &function_6368ff608fe6c16f, &function_edbb4af03709e7ca);
  function_a747d75f79124d88("shocking", getdvarint(@ "hash_88e7a69c0497818f", 1), &function_4629defddacd1dc1, &function_6368ff608fe6c16f);
  function_a747d75f79124d88("hunt", getdvarint(@ "hash_bc5a77c96dfc55d6", 1), &function_32ab7b20f72916ba, &function_317ba71811b1e7a6, &function_a4018333bf6dabce);
  function_a747d75f79124d88("beatupthecar", getdvarint(@ "hash_2f8a584298e5919f", 1), &function_1622b20751666c1d, &function_1d85758902f3471, &function_8c0bfe15c3fac89);
  function_a747d75f79124d88("bullettime", getdvarint(@ "hash_52d8547ef03a7132", 1), &function_b4220bf7ade5fc76, &function_6368ff608fe6c16f);
  function_a747d75f79124d88("shoot", getdvarint(@ "hash_734ccd99fa2e1e38", 1), &function_9642c94f003bc908, &function_6368ff608fe6c16f, undefined, 30);
}

function function_a747d75f79124d88(ref, weight, triggerfunc, var_c8bf09356ba2b89a, var_65429a5fb9ead47a, timelimit) {
  var_d3557b2a041c82a0 = spawnStruct();
  game["minigames"][ref] = var_d3557b2a041c82a0;
  game["minigames"][ref].ref = ref;
  game["minigames"][ref].weight = weight;
  game["minigames"][ref].triggerfunc = triggerfunc;
  game["minigames"][ref].var_c8bf09356ba2b89a = var_c8bf09356ba2b89a;
  game["minigames"][ref].timelimit = timelimit;

  if(isDefined(var_65429a5fb9ead47a)) {
    game["minigames"][ref].var_65429a5fb9ead47a = var_65429a5fb9ead47a;
  }
}

function function_93d4ef801ec5a9d3() {
  if(getDvar(@ "hash_57ce7409e4c27ebd") != "<dev string:x1c>") {
    ref = getDvar(@ "hash_57ce7409e4c27ebd");

    foreach(minigame in game["<dev string:x20>"]) {
      if(minigame.ref == ref) {
        var_95538e13aa8dee85 = minigame;
        break;
      }
    }

    if(!isDefined(var_95538e13aa8dee85)) {
      iprintlnbold("<dev string:x2d>");
    } else {
      function_7b7b385bbe43578b(var_95538e13aa8dee85);
      return;
    }
  }

  var_57bac0a78c352463 = function_a656c6dfb7dcb33a(game["minigames"]);
  game["minigames"] = array_remove(game["minigames"], var_57bac0a78c352463);
  function_7b7b385bbe43578b(var_57bac0a78c352463);
}

function function_7b7b385bbe43578b(minigame) {
  if(minigame.ref == "revive") {
    game["minigames_revivePlayed"] = 1;
  }

  level.var_6298f362ec23d83 = minigame;

  if(isDefined(minigame.timelimit)) {
    setoverridewatchdvar("timeLimit", minigame.timelimit);
  }

  level thread[[minigame.triggerfunc]]();
}

function function_3c83e1443071c31e() {
  setoverridewatchdvar("timeLimit", getmatchrulesdata("commonOption", "timeLimit"));
}

function function_cfc9bf375c442d87() {
  foreach(minigame in game["minigames"]) {
    if(minigame.weight != 0) {
      return true;
    }
  }

  return false;
}

function function_c61f0b95beb2455f(ref) {
  if(!isDefined(game["minigames"])) {
    return;
  }

  foreach(minigame in game["minigames"]) {
    if(minigame.ref == ref) {
      return minigame;
    }
  }
}

function onscorelimit(winner) {
  level.forcedend = 1;
}

function endgame(winner, endreasontext, nukedetonated) {
  if(level.gameended) {
    return;
  }

  level.endgame = undefined;
  setscore = [[level.var_6298f362ec23d83.var_c8bf09356ba2b89a]](winner, endreasontext, nukedetonated);

  if(!setscore) {
    endgame_regularmp(winner, endreasontext, undefined, nukedetonated);
  } else {
    level waittill("roundEnd_CheckScoreLimit_finished");

    if(!level.gameended) {
      endgame_regularmp(winner, endreasontext, undefined, nukedetonated);
    }
  }

  level.endgame = &endgame;

  if(isDefined(level.var_6298f362ec23d83) && isDefined(level.var_6298f362ec23d83.var_65429a5fb9ead47a)) {
    level[[level.var_6298f362ec23d83.var_65429a5fb9ead47a]]();
  }

  function_3c83e1443071c31e();
}

function function_6368ff608fe6c16f(winner, endreasontext, nukedetonated) {
  setscore = 0;

  if(winner == "tie") {
    foreach(team in level.teamnamelist) {
      alivecount = getteamdata(team, "aliveCount");

      if(alivecount > 0) {
        scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 1);
        setscore = 1;
      }
    }
  } else {
    scripts\mp\gamescore::giveteamscoreforobjective(winner, 1, 1);
    setscore = 1;
  }

  return setscore;
}

function function_492b4dec632917ec(splash) {
  level waittill("prematch_done");

  foreach(player in level.players) {
    player thread scripts\mp\hud_message::showsplash(splash);
  }
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  scripts\mp\gametypes\common::spawnhealthpickup();
  thread checkallowspectating();
}

function checkallowspectating() {
  waitframe();
  update = 0;

  foreach(team in level.teamnamelist) {
    if(!getteamdata(team, "aliveCount")) {
      level.spectateoverride[team].allowenemyspectate = 1;
      update = 1;
    }
  }

  if(update) {
    scripts\mp\spectating::updatespectatesettings();
  }
}

function teamoutcomenotify(winner, isround, endreasontext, endreasontextloss, roundendextramessage) {
  assertex(winner == "<dev string:x48>", "<dev string:x4f>");

  if(getteamdata(self.team, "aliveCount") > 0) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    return;
  }

  self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
}

function onplayerjointeam(player) {
  function_1bc5c8974d86a54();
}

function onplayerdisconnect(player) {
  numteams = 0;
  var_f7f2e1d809127acc = "tie";

  foreach(team in level.teamnamelist) {
    players = getteamdata(team, "players");

    if(players.size >= 1) {
      numteams++;
      var_f7f2e1d809127acc = team;
    }
  }

  if(numteams <= 1) {
    level.forcedend = 1;
    scripts\mp\gamelogic::endgame(var_f7f2e1d809127acc, game["end_reason"]["objective_completed"]);
  }

  function_f83dcbfcdb233c29();
}

function function_1bc5c8974d86a54() {
  var_58e96cee87d7e469 = 1;

  foreach(team in level.teamnamelist) {
    players = getteamdata(team, "players");

    if(players.size != 0 && players.size < 2) {
      var_58e96cee87d7e469 = 0;
      break;
    }
  }

  if(istrue(var_58e96cee87d7e469)) {
    if(isDefined(game["minigames"]) && !isDefined(function_c61f0b95beb2455f("revive")) && game["minigames_revivePlayed"] == 0) {
      function_a747d75f79124d88("revive", getdvarint(@ "hash_1393e7ac05d17eaa", 1), &function_12d48a74b22a6cce, &function_d63a7e17a1e870f2, &function_7826f269377f2e62);
    }
  }
}

function function_f83dcbfcdb233c29() {
  var_56a523a5ea3ec7ac = 0;

  foreach(team in level.teamnamelist) {
    players = getteamdata(team, "players");

    if(players.size != 0 && players.size < 2) {
      var_56a523a5ea3ec7ac = 1;
      break;
    }
  }

  if(istrue(var_56a523a5ea3ec7ac)) {
    if(isDefined(game["minigames"]) && isDefined(function_c61f0b95beb2455f("revive"))) {
      game["minigames"] = array_remove(game["minigames"], function_c61f0b95beb2455f("revive"));
    }
  }
}

function onspawnplayer(revivespawn) {
  thread loadout_clearperks();
}

function loadout_clearperks() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    self waittill("giveLoadout");
    scripts\mp\class::loadout_clearperks(1);
  }
}