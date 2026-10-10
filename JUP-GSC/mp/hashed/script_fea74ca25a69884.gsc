/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_fea74ca25a69884.gsc
************************************************/

#using script_3aacf02225ca0da5;
#using script_5bc60484d17fa95c;
#using script_64acb6ce534155b7;
#using script_7933519955f32c4e;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\dev;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\carriable;
#using scripts\mp\class;
#using scripts\mp\equipment\molotov;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_functional_poi;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\gametypes\br_vip_quest;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_util;
#using scripts\mp\javelin;
#using scripts\mp\juggernaut;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\laststand;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace namespace_3db0584c4c3b350b;

function init() {
  setdvarifuninitialized(@ "hash_87e38fca685cec1d", 1);

  if(getdvarint(@ "hash_87e38fca685cec1d", 0)) {
    scripts\mp\gametypes\br_dev::registerhandlecommand(&function_dd5235ea93f4af20);
    thread scripts\mp\gametypes\br_dev::commandwatcher(@ "hash_97cda940cb7bd182", &scripts\mp\gametypes\br_dev::handlecommand);
  }
}

function function_dd5235ea93f4af20(command, args) {
  switch (command) {
    case #"hash_fa50c0f6bd8302a2":
      thread devscriptedtests(args);
      break;
    default:
      break;
  }
}

function devscriptedtests(args) {
  level notify("devScriptedTests");
  level endon("devScriptedTests");
  host = gethost(args);

  if(!isDefined(host)) {
    return;
  }

  function_d721ba3a92dffd4c();
  function_8032016446156bad();
  resetplayers();
  resetcircles();
  [hostteammates, enemyteammates] = spawnteams(args);
  host iprintlnbold("Test ready");
  wait 2;
  runtests(args, host, hostteammates, enemyteammates);
}

function getspawnlocations() {
  if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    spawnlocations = [scripts\mp\gametypes\br::createspawnlocation((-21500, 46200, -300), 0, 6000), scripts\mp\gametypes\br::createspawnlocation((51000, -39000, 1401), 0, 4000), scripts\mp\gametypes\br::createspawnlocation((32000, 40000, 767), 0, 5500), scripts\mp\gametypes\br::createspawnlocation((23000, -15000, -158), 0, 6000)];
    return spawnlocations;
  }

  if(scripts\cp_mp\utility\game_utility::function_eb4bce9b222e36ac()) {
    spawnlocations = [scripts\mp\gametypes\br::createspawnlocation((26889.1, -30035.3, 3497.65), 0, 6000), scripts\mp\gametypes\br::createspawnlocation((37200, 30506.6, 1760.46), 0, 4000), scripts\mp\gametypes\br::createspawnlocation((-29611.7, 35197, 1376.12), 0, 5500), scripts\mp\gametypes\br::createspawnlocation((-24496.6, -27294.2, 1700.23), 0, 6000)];
    return spawnlocations;
  }
}

function function_d721ba3a92dffd4c() {
  if(istrue(level.usegulag)) {
    foreach(arena in level.gulag.arenas) {
      arena.matches = [];
    }

    level.gulag.arenas = sortbydistance(level.gulag.arenas, level.mapcorners[0].origin);
    level.gulag.maxuses = -1;
    level.gulag.timelimit = 15;
    setDvar(@ "hash_1ff83f4f24656c5b", 15);
    setDvar(@ "hash_e5f703a38f6e8043", 95);
    setDvar(@ "hash_8bdee07fa09e810a", -1);
    setDvar(@ "hash_e43719f8cb449c07", 0);
    setDvar(@ "hash_98b297a8680cbdc2", 0);

    if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
      foreach(arena in level.gulag.arenas) {
        arena.shutdown = undefined;
      }

      level.gulag.shutdown = undefined;
    }
  }
}

function function_8032016446156bad() {
  scripts\mp\flags::gameflagset("prematch_done");
  level notify("prematch_over");
  level notify("cancel_public_event");
  setomnvar("ui_prematch_period", 0);
  level.maxteamsize = 3;
  level.br_prematchstarted = 1;
  level.teammaxfill = 1;
  level.disablespawning = 0;
  level.ignorescoring = 0;
  level.allowprematchdamage = 1;
  level.ingraceperiod = 0;
  level.var_82a0e660e66306dc = undefined;
  setDvar(@ "hash_c2de8ca6dc8512c1", 1);
  setDvar(@ "br_minplayers", 150);
  setDvar(@ "live_lobby_minplayers_start", 150);
  setDvar(@ "hash_2c879521333c4987", 0);
  setDvar(@ "live_lobby_max_time", 0);
  setDvar(@ "hash_4ce07ca6680c1333", 0);
  level.var_c3a1ed2db43ce5a = 3;
  level.br_debugsolotest = 0;
  scripts\mp\spawnlogic::function_182c52d5da69684d();
  scripts\mp\flags::gameflagset("prematch_fade_done");
}

function resetplayers() {
  foreach(player in level.players) {
    if(player isplayerheadless()) {
      player allowmovement(0);
      player allowfire(0);
      player allowmelee(0);
    }

    player function_df49f9975e17b225(undefined);
    player.gulag = undefined;
    player.jailed = undefined;
    player.gulagarena = undefined;
    player.wasingulag = undefined;
    player.playertospectate = undefined;
    player.nextplayertospectate = undefined;
    player.gulagloser = undefined;
    player.gulaguses = undefined;
    player.longgulagstream = undefined;
    player.gulagholding = undefined;
    player.var_4af73ce40a5d8572 = undefined;
    player notify("gulag_end");
    player notify("gulag_auto_win");
    player notify("last_stand_start");
    player scripts\mp\laststand::finishreviveplayer("self_revive_success", player);

    if(player getstance() != "stand") {
      player setstance("stand");
    }

    player setallstreamloaddist(0);
    player.setspawnpoint = undefined;
    optparams = spawnStruct();
    optparams.var_fb551788da0fc531 = 0;
    player scripts\mp\gametypes\br_gulag::playerrespawngulagcleanup(optparams);

    if(isDefined(level.gulag)) {
      player scripts\mp\gametypes\br_gulag::playergulagarenaready();
    }

    player scripts\mp\gametypes\br_spectate::playerclearspectatekillchainsystem();
  }
}

function resetcircles() {
  if(isDefined(level.br_circle.safecircleent)) {
    level.br_circle.dangercircleui.hidden = 1;
    level.br_circle.dangercircleent.hidden = 1;
    level.br_circle.safecircleui.hidden = 1;
    level.br_circle.safecircleent.hidden = 1;
    level notify("update_circle_hide");
  }
}

function spawnteams(args) {
  host = gethost(args);
  spawnlocations = getspawnlocations();

  if(!isDefined(level.devspectateloc)) {
    level.devspectateloc = [];
  }

  var_e2d2256d6f8ba785 = level.var_c3a1ed2db43ce5a - 1;
  count = 0;
  level.var_e1e5bac199d37317 = [];

  for(i = 0; i < level.teamnamelist.size; i++) {
    team = level.teamnamelist[i];

    if(team != host.team) {
      level.var_e1e5bac199d37317[count] = team;
      count++;

      if(count >= var_e2d2256d6f8ba785) {
        break;
      }
    }
  }

  reviveteam(host, host.team);

  for(i = 0; i < var_e2d2256d6f8ba785; i++) {
    reviveteam(host, level.var_e1e5bac199d37317[i]);
  }

  level.var_84931945e7b207 = getteamspawnbots(host, host.team);
  level.var_cc15d00c0dfbf14e = [];

  for(i = 0; i < var_e2d2256d6f8ba785; i++) {
    level.var_cc15d00c0dfbf14e[i] = getteamspawnbots(host, level.var_e1e5bac199d37317[i]);
  }

  for(i = 0; i < level.var_84931945e7b207.size; i++) {
    player1 = level.var_84931945e7b207[i];
    spawnorigin = player1.origin;

    if(isDefined(spawnlocations)) {
      spawnorigin = spawnlocations[i].origin;
    }

    player1 playerteleporttoloc(spawnorigin, 0);

    for(slotindex = 0; slotindex < var_e2d2256d6f8ba785; slotindex++) {
      nextplayer = level.var_cc15d00c0dfbf14e[slotindex][i];
      nextplayer playerteleporttoloc(spawnorigin, slotindex + 1);
    }
  }

  level.disablespawning = 1;
  totalplayers = getlivingplayers();
  level.totalplayers = totalplayers.size;
  return [level.var_84931945e7b207, level.var_cc15d00c0dfbf14e];
}

function playerteleporttoloc(spawnorigin, posindex) {
  if(self isplayerheadless()) {
    self allowmovement(0);
    self allowfire(0);
    self allowmelee(0);
  }

  entnum = self getentitynumber();

  if(isDefined(level.devspectateloc[entnum])) {
    spawnorigin = level.devspectateloc[entnum];
  } else {
    dir = anglesToForward((0, 0, 0));
    spawnorigin += dir * posindex * 50;
    spawnorigin = getgroundposition(spawnorigin, 15, 100);
  }

  self setOrigin(spawnorigin);
  self setplayerangles((0, 0, 0));

  if(!isDefined(level.devspectateloc[entnum])) {
    level.devspectateloc[entnum] = spawnorigin;
  }
}

function reviveteam(host, team) {
  teammates = level.teamdata[team]["players"];
  revivedplayers = 0;

  foreach(player in teammates) {
    if(!isalive(player) || player.sessionstate != "playing") {
      entnum = player getentitynumber();

      if(isDefined(level.devspectateloc[entnum])) {
        player.forcespawnangles = (0, 0, 0);
        player.forcespawnorigin = level.devspectateloc[entnum];
      } else {
        player.forcespawnangles = player.angles;
        player.forcespawnorigin = player.origin;
      }

      player spawnclientdevtest(0);
      revivedplayers = 1;
    }

    if(istrue(player.br_iseliminated)) {
      scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
    }
  }

  if(revivedplayers) {
    host iprintlnbold("Reviving Team: " + team);
    wait 1;
  }
}

function getteamspawnbots(host, team) {
  numtospawn = 0;

  if(level.teamdata[team]["teamCount"] < level.maxteamsize) {
    numtospawn = level.maxteamsize - level.teamdata[team]["teamCount"];
  }

  if(numtospawn > 0) {
    level.modespawnclient = &spawnclientdevtest;
    addbots(numtospawn, team);
    host iprintlnbold("Spawning Team: " + team);
    timeout = gettime() + 10000;

    while(gettime() < timeout && level.teamdata[team]["aliveCount"] < level.maxteamsize) {
      waitframe();
    }

    level.modespawnclient = &scripts\mp\gametypes\br::spawnclientbr;
  }

  assert(level.teamdata[team]["<dev string:x1c>"].size == level.maxteamsize);
  return level.teamdata[team]["alivePlayers"];
}

function botcallback() {
  team = self.bot_team;
  players = level.teamdata[team]["players"];

  for(i = 0; i < level.maxteamsize; i++) {
    validindex = 1;

    foreach(player in players) {
      if(self == player) {
        continue;
      }

      if(isDefined(player.sessionuimemberindex) && player.sessionuimemberindex == i) {
        validindex = 0;
        break;
      }
    }

    if(validindex) {
      self.sessionuimemberindex = i;
      break;
    }
  }
}

function addbots(numbots, team) {
  if(!isDefined(team)) {
    team = "autoassign";
  }

  level thread[[level.bot_funcs["bots_spawn"]]](numbots, team, &botcallback);

  if(level.matchmakingmatch) {
    setmatchdata("hasBots", 1);
  }
}

function spawnclientdevtest(revivespawn) {
  self.class = scripts\mp\gametypes\br::pickprematchrandomloadout();
  self.pers["class"] = self.class;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  waitframe();
  self skydive_setdeploymentstatus(0);
  self skydive_setbasejumpingstatus(0);
  var_4de859b9228e5cfd = !self isplayerheadless();

  if(var_4de859b9228e5cfd) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
}

function function_954dd6e60394e2f4() {
  level.br_debugsolotest = 1;
}

function function_df49f9975e17b225(value) {
  self.br_infilstarted = value;
}

function disconnectbot(botplayer) {
  assert(isbot(botplayer));
  kick(botplayer getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
}

function killplayer(victim, var_25012cdc0dfdc53f) {
  enemy = var_25012cdc0dfdc53f;

  if(isarray(var_25012cdc0dfdc53f)) {
    enemy = getnearbyaliveplayer(victim.origin, var_25012cdc0dfdc53f);
  }

  victim dodamage(500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());
  wait 1;

  while(isalive(victim)) {
    victim dodamage(500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());
    waitframe();
  }

  return enemy;
}

function killplayerinstant(victim, var_25012cdc0dfdc53f, keeplaststand) {
  enemy = var_25012cdc0dfdc53f;

  if(isarray(var_25012cdc0dfdc53f)) {
    enemy = getnearbyaliveplayer(victim.origin, var_25012cdc0dfdc53f);
  }

  if(!isDefined(enemy)) {
    enemy = victim;
  }

  if(!istrue(keeplaststand) && victim scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    victim scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  }

  while(isalive(victim)) {
    victim dodamage(500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());

    if(!isalive(victim)) {
      break;
    }

    waitframe();
  }

  return enemy;
}

function putinlaststand(player, var_25012cdc0dfdc53f) {
  enemy = var_25012cdc0dfdc53f;

  if(isarray(var_25012cdc0dfdc53f)) {
    enemy = getnearbyaliveplayer(player.origin, var_25012cdc0dfdc53f);
  }

  if(!isDefined(enemy)) {
    enemy = player;
  }

  if(!player scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    player scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
  }

  while(!istrue(player.inlaststand)) {
    player dodamage(30, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon());
    wait 0.1;
  }

  return enemy;
}

function scriptcircleat(origin, radius) {
  if(!isDefined(level.br_circle.safecircleent)) {
    thread scripts\mp\gametypes\br_circle::runcircles(1);
    level.br_circle thread scripts\mp\gametypes\br_circle::circledamagetick();
  }

  waitframe();
  level notify("CirclePeekCleanup");
  circleindex = 1;
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = circleindex;
  var_f007ce073dc3c519 = circleindex == 0;
  var_6b890e6be7982efb = circleindex == level.br_level.br_circleclosetimes.size - 1;
  prewaittime = level.br_level.br_circledelaytimes[circleindex];
  closetime = level.br_level.br_circleclosetimes[circleindex];
  targetradius = level.br_level.br_circleradii[circleindex + 1];
  setomnvar("ui_br_circle_num", circleindex + 1);
  level.br_circle.centertarget = origin;
  level.br_circle.safecircleent.origin = origin;
  level.br_circle.dangercircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.safecircleent.hidden = 0;
  level notify("update_circle_hide");
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = origin + (0, 0, radius);
  scripts\mp\gametypes\br_circle::setstaticuicircles(999, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_6b890e6be7982efb);
  level notify("br_circle_set");
  waitframe();
  level notify("br_circle_started");
  level.br_circle.dangercircleent brcirclemoveTo(origin[0], origin[1], radius, 1);
}

function setnumteams(args, numteams) {
  if(numteams <= 0) {
    return;
  }

  level.var_c3a1ed2db43ce5a = numteams;
  return spawnteams(args);
}

function getnearbyaliveplayer(org, players) {
  players = array_removeundefined(players);
  players = sortbydistance(players, org);

  if(isalive(players[0])) {
    dist = distance2dsquared(org, players[0].origin);

    if(dist < 40000) {
      return players[0];
    }
  }

  aliveplayer = undefined;

  for(i = 1; i < players.size; i++) {
    player = players[i];

    if(isalive(player)) {
      aliveplayer = player;
      break;
    }
  }

  return aliveplayer;
}

function argshave(args, token) {
  foreach(arg in args) {
    if(arg == token) {
      return true;
    }
  }

  return false;
}

function gethost(args) {
  if(isDefined(level.devspectatetesthost)) {
    return level.devspectatetesthost;
  }

  host = scripts\mp\gamelogic::gethostplayer();

  if(argshave(args, "clientHost")) {
    foreach(player in level.players) {
      if(!isai(player) && !player isplayerheadless() && (!isDefined(host) || player != host)) {
        host = player;
        break;
      }
    }
  } else if(!isDefined(host)) {
    foreach(player in level.players) {
      if(!isai(player) && !player isplayerheadless()) {
        level.devspectatetesthost = player;
        host = player;
        break;
      }
    }
  } else {
    level.maxteamsize = 3;
  }

  if(!isDefined(level.devspectatetesthost)) {
    level.devspectatetesthost = host;
  }

  return host;
}

function playerstartrecondronewait() {
  pickupent = spawnStruct();
  pickupent.scriptablename = "brloot_killstreak_recondrone";
  pickupent.count = 1;
  scripts\mp\gametypes\br_pickups::takesuperpickup(pickupent);
  wait 1;
  superweapon = makeweapon("super_default_mp");
  scripts\mp\supers::trysuperusebegin(superweapon);

  while(self getcurrentprimaryweapon().basename != "ks_remote_drone_mp") {
    waitframe();
  }
}

function waitandsuicide(delaytime, player) {
  wait delaytime;
  player suicide();
}

function onprematchstarted2() {
  level notify("onPrematchFadeDoneClear");
  level thread onprematchfadedone2();
  c130pathstruct = undefined;

  if(!istrue(level.br_infils_disabled)) {
    c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path();
  }

  waitframe();
  level.br_c130spawndone = 0;
  level.br_latejoininfilready = 0;
  namespace_973962356ce55fee::beginbrc130playeraniminfilsequence(c130pathstruct, "player");
  level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();
  level notify("infils_ready");
}

function onprematchfadedone2() {
  var_36648016ce75e753 = 1.4;
  level endon("onPrematchFadeDoneClear");

  if(!isDefined(level.spectatetestonprematchfadedone)) {
    level.spectatetestonprematchfadedone = 1;
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level thread scripts\mp\gametypes\br::resetalldoors(var_36648016ce75e753 * 1.5);
  level thread scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforallplayers(1);
  level thread scripts\mp\gametypes\br_vehicles::brvehicleonprematchstarted();
  level thread scripts\mp\gametypes\br_functional_poi::onprematchdone();
  scripts\mp\gametypes\br::cleanupmolotovs();
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();

  foreach(player in level.players) {
    player scripts\mp\gametypes\br::setplayerprematchallows();
    player thread scripts\mp\gametypes\br_pickups::resetplayerinventory();

    if(istrue(player.hasspawned)) {
      if(istrue(player.usingascender)) {
        player scripts\cp_mp\auto_ascender::ascenderinstantstop();
      }

      player thread scripts\mp\weapons::deleteplacedequipment();
    }
  }

  foreach(player in level.players) {
    if(isDefined(player.burninginfo)) {
      player scripts\mp\equipment\molotov::molotov_clear_burning();
    }

    player scripts\mp\javelin::javelin_forceclear();
  }

  level notify("prematch_cleanup");

  if(!istrue(level.br_circle_disabled)) {
    level thread scripts\mp\gametypes\br_circle::runcircles(1);
  }
}

function function_53aa698b2205a4c3(player, scriptablename, spawnpos) {
  if(!isDefined(spawnpos)) {
    spawnpos = player.origin + anglesToForward(player.angles) * 100 + (0, 0, 12);
  }

  initialcount = 0;

  if(isDefined(level.br_pickups.counts[scriptablename])) {
    initialcount = level.br_pickups.counts[scriptablename];
  }

  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(spawnpos);
  item = spawnpickup(scriptablename, dropinfo, initialcount);

  if(isweaponcase(scriptablename)) {
    namespace_a8b2b88699fc40fb::function_3e7ee85cb0d3504c(item);
  }

  if(isquesttablet(scriptablename)) {
    namespace_1eb3c4e0e28fac71::function_8a25384bacdd7b79(item, scriptablename);
  }

  if(isDefined(item)) {
    contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
    ignorelist = [];
    caststart = item.origin + (0, 0, 50);
    castend = caststart + (0, 0, -200);
    traceresult = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

    if(isDefined(traceresult["entity"]) && isDefined(traceresult["entity"].targetname) && traceresult["entity"].targetname == "train_wz") {
      trainent = traceresult["entity"];
      localorigin = rotatevectorinverted(item.origin - trainent.origin, trainent.angles);
      localangles = combineangles(invertangles(trainent.angles), item.angles);
      item utility::function_6e506f39f121ea8a(trainent, localorigin, localangles);
    }
  }

  return item;
}

function runtests(args, host, hostteammates, enemyteammates) {
  if(argshave(args, "killcam1") || argshave(args, "killchain") || argshave(args, "disconnect1") || argshave(args, "disconnect2") || argshave(args, "disconnect3")) {
    killplayer(host, enemyteammates[0]);

    if(argshave(args, "disconnect2")) {
      while(host.sessionstate != "intermission") {
        waitframe();
      }

      while(host.sessionstate == "intermission") {
        waitframe();
      }
    } else if(argshave(args, "disconnect3")) {
      while(host.sessionstate != "intermission") {
        waitframe();
      }

      wait 0.5;
    } else {
      scripts\mp\gametypes\br_spectate::waittillspectating(host);
      wait 3;

      if(argshave(args, "disconnect1")) {
        host iprintlnbold("Waiting");
        wait 10;
      }
    }
  }

  if(argshave(args, "disconnect1") || argshave(args, "disconnect2") || argshave(args, "disconnect3")) {
    playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    disconnectbot(playertospectate);
  }

  if(argshave(args, "killchain")) {
    for(playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer()) {
      waitframe();
    }

    killplayer(playertospectate, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 3;
  }

  if(argshave(args, "killchain")) {
    for(playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer()) {
      waitframe();
    }

    killplayer(playertospectate, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 3;
  }

  if(argshave(args, "killchain")) {
    for(playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer()) {
      waitframe();
    }

    killplayer(playertospectate, enemyteammates[1]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 3;
  }

  if(argshave(args, "killchain")) {
    for(playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer()) {
      waitframe();
    }

    killplayer(playertospectate, enemyteammates[1]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 3;
  }

  if(argshave(args, "killchain")) {
    for(playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer(); !isDefined(playertospectate); playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer()) {
      waitframe();
    }

    killplayer(playertospectate, enemyteammates[1]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 3;
  }

  if(argshave(args, "gulag1")) {
    foreach(player in hostteammates) {
      if(player != host) {
        player function_df49f9975e17b225(1);
        killplayer(player, enemyteammates[0]);
      }
    }

    wait 10;
    killplayer(host, enemyteammates[0]);
  }

  if(argshave(args, "gulag2") || argshave(args, "gulag3")) {
    killplayer(host, enemyteammates[0]);
    host waittill("killcam_ended");
    wait 2;

    foreach(player in hostteammates) {
      if(player != host) {
        player function_df49f9975e17b225(1);
        killplayer(player, enemyteammates[0]);
      }
    }

    while(!isDefined(host getspectatingplayer())) {
      waitframe();
    }

    friendly = host getspectatingplayer();
    friendly function_df49f9975e17b225(1);
    wait 1;

    foreach(player in enemyteammates[0]) {
      player function_df49f9975e17b225(1);
      killplayer(player, enemyteammates[1]);
    }

    while(!istrue(friendly.gulagarena)) {
      waitframe();
    }

    wait 10;

    if(argshave(args, "gulag2")) {
      setspawnpoint = spawnStruct();
      setspawnpoint.playerspawnpos = (26474, -16709, -162);
      setspawnpoint.playerspawnangles = (85, 135, 0);
      friendly.setspawnpoint = setspawnpoint;

      foreach(player in enemyteammates[0]) {
        if(istrue(player.gulagarena)) {
          player function_df49f9975e17b225(1);
          killplayer(player, enemyteammates[1]);
          break;
        }
      }

      while(!friendly islinked()) {
        waitframe();
      }

      while(friendly islinked()) {
        waitframe();
      }

      waitframe();
      playerangles = friendly getplayerangles();
      friendly setplayerangles((85, playerangles[1], 0));
    } else {
      killplayer(friendly, enemyteammates[1]);
    }
  }

  if(argshave(args, "gulag4")) {
    host function_df49f9975e17b225(1);
    enemy = killplayer(host, enemyteammates[0]);
    enemy function_df49f9975e17b225(1);
    killplayer(enemy, hostteammates);
  }

  if(argshave(args, "gulaggulag")) {
    first = getdvarint(@ "hash_ad0ddaf795b2ef1a", 0);
    second = getdvarint(@ "hash_ad0dd9f795b2ece7", 5);
    setDvar(@ "hash_e5f703a38f6e8043", 9999);
    setDvar(@ "hash_8bdee07fa09e810a", first);
    host function_df49f9975e17b225(1);
    enemy = killplayer(host, enemyteammates[0]);
    setDvar(@ "hash_8bdee07fa09e810a", second);

    foreach(player in hostteammates) {
      if(player != host) {
        player function_df49f9975e17b225(1);
        killplayer(player, enemyteammates[0]);
      }
    }

    setDvar(@ "hash_8bdee07fa09e810a", first);
    enemy function_df49f9975e17b225(1);
    killplayer(enemy, enemyteammates[1]);

    while(!istrue(host.gulagarena) && !istrue(enemy.gulagarena)) {
      waitframe();
    }

    wait 10;
    killplayer(host, enemy);
    setDvar(@ "hash_e5f703a38f6e8043", 90);
  }

  if(argshave(args, "killkill")) {
    enemy = enemyteammates[0][0];

    foreach(player in hostteammates) {
      if(player != host) {
        killplayer(player, enemy);
      }
    }

    killplayer(enemy, host);
    wait 10;
    killplayer(host, enemy);
  }

  if(argshave(args, "killcam2")) {
    enemy = killplayer(host, enemyteammates[0]);
    wait 3;
    killplayer(host.nextplayertospectate, enemyteammates[0]);
  }

  if(argshave(args, "gulag5") || argshave(args, "gulag6")) {
    nothost = undefined;

    foreach(player in hostteammates) {
      if(!isDefined(nothost) && player != host) {
        nothost = player;
        continue;
      }

      killplayer(player, enemyteammates[0]);
      scripts\mp\gametypes\br_spectate::waittillspectating(player);
    }

    nothost function_df49f9975e17b225(1);

    if(argshave(args, "gulag6")) {
      setDvar(@ "hash_e5f703a38f6e8043", 9999);
      first = getdvarint(@ "hash_ad0ddaf795b2ef1a", 5);
      setDvar(@ "hash_8bdee07fa09e810a", first);
      nothost.longgulagstream = 1;
    }

    killplayer(nothost, enemyteammates[0]);
  }

  if(argshave(args, "gulag7")) {
    killplayer(host, enemyteammates[0]);
    host waittill("killcam_ended");
    wait 2;
    gulagplayer = undefined;

    foreach(player in hostteammates) {
      if(player != host) {
        player function_df49f9975e17b225(1);
        gulagplayer = player;
        gulagplayer scripts\mp\gametypes\br_gulag::initplayerjail();
        break;
      }
    }

    while(!isDefined(host getspectatingplayer())) {
      waitframe();
    }

    wait 1;
    gulagenemy = undefined;

    foreach(player in enemyteammates[0]) {
      player function_df49f9975e17b225(1);
      gulagenemy = player;
      killplayer(player, enemyteammates[1]);
      break;
    }

    while(!istrue(gulagplayer.gulagarena) && !istrue(gulagenemy.gulagarena)) {
      waitframe();
    }

    wait 10;
    setDvar(@ "hash_e43719f8cb449c07", 1);
    killplayer(gulagenemy, gulagplayer);

    while(host getspectatingplayer() != gulagplayer) {
      println("<dev string:x2c>");
      wait 1;
    }

    wait 10;
    setDvar(@ "hash_e43719f8cb449c07", 0);
  }

  if(argshave(args, "gulag8")) {
    level.gulag.timelimit = 3;
    setDvar(@ "hash_1ff83f4f24656c5b", 3);
    setDvar(@ "hash_e5f703a38f6e8043", -1);
    killplayer(host, enemyteammates[0]);
    host waittill("killcam_ended");
    wait 2;
    gulagplayer = undefined;

    foreach(player in hostteammates) {
      if(player != host) {
        player function_df49f9975e17b225(1);
        gulagplayer = player;
        gulagplayer scripts\mp\gametypes\br_gulag::initplayerjail();
        break;
      }
    }

    while(!isDefined(host getspectatingplayer())) {
      waitframe();
    }

    while(host getspectatingplayer() != gulagplayer) {
      iprintlnbold("Switch to spectating gulag player");
      waitframe();
    }

    wait 1;
    gulagenemy = undefined;

    foreach(player in enemyteammates[0]) {
      player function_df49f9975e17b225(1);
      gulagenemy = player;
      killplayer(player, enemyteammates[1]);
      break;
    }
  }

  if(argshave(args, "gulag9")) {
    host function_df49f9975e17b225(1);
    enemy = killplayer(host, enemyteammates[0]);
    enemy function_df49f9975e17b225(1);
    killplayer(enemy, hostteammates);

    foreach(player in hostteammates) {
      if(player != host) {
        killplayer(player, enemyteammates[0]);
      }
    }

    foreach(player in enemyteammates[0]) {
      if(player != enemy) {
        killplayer(player, enemyteammates[1]);
      }
    }

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    setDvar(@ "hash_e43719f8cb449c07", 1);
    setDvar(@ "hash_2c879521333c4987", 3);
    killplayer(host, enemy);
    wait 9;
    setDvar(@ "hash_e43719f8cb449c07", 0);
    setDvar(@ "hash_2c879521333c4987", 0);
  }

  if(argshave(args, "gulag10")) {
    var_57b48ef0392ddd42 = enemyteammates[0][0];
    var_57b48ef0392ddd42 function_df49f9975e17b225(1);
    killplayer(var_57b48ef0392ddd42, enemyteammates[1]);
    var_57b48df0392ddb0f = enemyteammates[1][0];
    var_57b48df0392ddb0f function_df49f9975e17b225(1);
    killplayer(var_57b48df0392ddb0f, enemyteammates[0]);
    wait 1;
    var_57b896f03931e4b1 = host;
    var_57b896f03931e4b1 function_df49f9975e17b225(1);
    killplayer(var_57b896f03931e4b1, enemyteammates[0]);
    var_57b893f03931de18 = enemyteammates[0][1];
    var_57b893f03931de18 function_df49f9975e17b225(1);
    killplayer(var_57b893f03931de18, enemyteammates[1]);

    while(!istrue(var_57b48ef0392ddd42.gulagarena) || !istrue(var_57b48df0392ddb0f.gulagarena) || !istrue(var_57b896f03931e4b1.jailed) || !istrue(var_57b893f03931de18.jailed)) {
      waitframe();
    }

    setDvar(@ "hash_98b297a8680cbdc2", 1);
    playerc = enemyteammates[1][1];
    playerc function_df49f9975e17b225(1);
    killplayer(playerc, enemyteammates[0]);
    wait 1;

    while(istrue(playerc.gulagloading)) {
      waitframe();
    }

    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    disconnectbot(playerc);
    wait 3;
    setDvar(@ "hash_98b297a8680cbdc2", 0);
  }

  if(argshave(args, "gulag11")) {
    host function_df49f9975e17b225(1);
    putinlaststand(host, enemyteammates[1]);
    wait 1;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    host scripts\mp\laststand::finishreviveplayer("self_revive_success", host);
    wait 10;
    killplayer(host, enemyteammates[0]);
  }

  if(argshave(args, "twooneframe")) {
    foreach(player in hostteammates) {
      if(player != host) {
        killplayer(player, enemyteammates[0]);
        break;
      }
    }

    wait 5;

    foreach(player in hostteammates) {
      if(isalive(player)) {
        killplayerinstant(player, enemyteammates[0]);
      }
    }
  }

  if(argshave(args, "suicide")) {
    foreach(player in hostteammates) {
      if(player != host) {
        killplayer(player, enemyteammates[0]);
      }
    }

    wait 5;

    if(host scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      host scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
    }

    host suicide();
  }

  if(argshave(args, "team")) {
    foreach(player in hostteammates) {
      if(player != host) {
        killplayerinstant(player, enemyteammates[0]);
      }
    }
  }

  if(argshave(args, "moving")) {
    killplayerinstant(host, enemyteammates[0]);

    while(!isDefined(host.playertospectate)) {
      waitframe();
    }

    player = host.playertospectate;
    dir = anglesToForward(player.angles);
    amount = getdvarint(@ "testforward", 5);

    for(spectatingplayer = host getspectatingplayer(); !isDefined(spectatingplayer); spectatingplayer = host getspectatingplayer()) {
      nextorg = player.origin + dir * amount;
      player setOrigin(nextorg);
      waitframe();
    }
  }

  if(argshave(args, "heli1") || argshave(args, "heli2")) {
    friendly = undefined;

    foreach(player in hostteammates) {
      if(player != host) {
        if(!isDefined(friendly)) {
          friendly = player;
          continue;
        }

        killplayerinstant(player, enemyteammates[0]);
      }
    }

    wait 1;
    killplayerinstant(host, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 1;
    keys = getarraykeys(level.vehicle.instances["little_bird"]);
    heli = level.vehicle.instances["little_bird"][keys[0]];
    instance = heli getlinkedscriptableinstance();
    friendly setOrigin(heli.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(instance, "single", "vehicle_use", friendly, 0);

    if(argshave(args, "heli2")) {
      wait 3;
      disconnectbot(friendly);
    }
  }

  if(argshave(args, "water")) {
    host setOrigin((28252, -32627, -415));
  }

  if(argshave(args, "disconnectswitch1")) {
    killplayerinstant(host, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    friendly = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();

    while(!host buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    friendly2 = undefined;

    foreach(player in hostteammates) {
      if(player != host && player != friendly) {
        friendly2 = player;
        break;
      }
    }

    wait 0.5;
    disconnectbot(friendly2);
  }

  if(argshave(args, "disconnectswitch2")) {
    killplayerinstant(host, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    friendly = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();

    while(!host buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    wait 0.5;
    disconnectbot(friendly);
  }

  if(argshave(args, "endspectate")) {
    level.br_infils_disabled = 1;

    setdevdvar(@ "hash_7a1447160ba151fe", 1);

    setDvar(@ "br_minplayers", 2);
    level.gulag.maxuses = 0;
    wait 1;
    killplayerinstant(host, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;

    foreach(player in hostteammates) {
      if(player != host) {
        killplayerinstant(player, enemyteammates[0]);
      }
    }

    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;
    enemy = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killplayerinstant(enemy, enemyteammates[1]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;
    enemy = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killplayerinstant(enemy, enemyteammates[1]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;
    enemy = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killplayerinstant(enemy, enemyteammates[1]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;
  }

  if(argshave(args, "teamwipe1")) {
    setDvar(@ "hash_2c879521333c4987", 5);

    foreach(player in hostteammates) {
      if(player != host) {
        killplayerinstant(player, enemyteammates[0]);
      }
    }

    wait getdvarfloat(@ "hash_b436ad5a39cb1f59", 5);
    enemy = killplayerinstant(host, enemyteammates[0]);
    wait getdvarfloat(@ "hash_1f5ea86d19b61851", 13);
    killplayerinstant(enemy, enemyteammates[1]);
  }

  if(argshave(args, "deathswitch1")) {
    setDvar(@ "hash_2c879521333c4987", 5);
    killplayerinstant(host, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    friendly = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();

    while(!host buttonPressed("BUTTON_RSHLDR")) {
      waitframe();
    }

    friendly2 = undefined;

    foreach(player in hostteammates) {
      if(player != host && player != friendly) {
        friendly2 = player;
        break;
      }
    }

    wait 0.5;
    killplayerinstant(friendly2, enemyteammates[0]);
  }

  if(argshave(args, "squadwidget")) {
    setDvar(@ "hash_e5f703a38f6e8043", 9999);
    setDvar(@ "hash_2c879521333c4987", 3);

    foreach(player in hostteammates) {
      if(player != host) {
        disconnectbot(player);
      }
    }

    wait 5;
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy1 function_df49f9975e17b225(1);
    killplayerinstant(enemy1, host);
    wait getdvarfloat(@ "hash_32c6816aee4fdb27", 4);
    killplayerinstant(host, enemy2);
  }

  if(argshave(args, "killall")) {
    level.overrideingraceperiod = 1;
    lastplayer = hostteammates[1];

    foreach(player in hostteammates) {
      if(player != lastplayer) {
        killplayerinstant(player, enemyteammates[0]);
      }
    }

    foreach(player in enemyteammates[0]) {
      killplayerinstant(player, enemyteammates[1]);
    }

    foreach(player in enemyteammates[1]) {
      killplayerinstant(player, enemyteammates[0]);
    }

    wait 10;
    disconnectbot(lastplayer);
    level.overrideingraceperiod = undefined;
  }

  if(argshave(args, "moneykill")) {
    foreach(player in hostteammates) {
      if(player != host) {
        player scripts\mp\gametypes\br_plunder::playersetplundercount(45);
        player function_df49f9975e17b225(1);
        killplayerinstant(player, enemyteammates[0]);
      }
    }

    wait 5;
    killplayerinstant(host, enemyteammates[0]);
  }

  if(argshave(args, "buyback1")) {
    scriptcircleat(host.origin, 500);
    setDvar(@ "hash_e5f703a38f6e8043", -1);
    playera = host;
    playera function_df49f9975e17b225(1);
    killplayer(playera, enemyteammates[1]);
    enemya = enemyteammates[1][0];
    enemya function_df49f9975e17b225(1);
    killplayer(enemya, enemyteammates[1]);

    while(!istrue(playera.gulagarena)) {
      waitframe();
    }

    wait 10;
    killplayerinstant(playera, []);

    while(!isDefined(playera getspectatingplayer())) {
      waitframe();
    }

    playerb = playera getspectatingplayer();
    playerb function_df49f9975e17b225(1);
    playerc = undefined;

    foreach(player in hostteammates) {
      if(player != playera && player != playerb) {
        playerc = player;
        break;
      }
    }

    playerc scripts\mp\gametypes\br_plunder::playersetplundercount(45);
    killplayer(playerb, enemyteammates[1]);

    while(!istrue(playerb.jailed)) {
      waitframe();
    }

    while(!isDefined(playera getspectatingplayer()) || playera getspectatingplayer() != playerb) {
      waitframe();
    }

    enemyb = enemyteammates[1][1];
    enemyb function_df49f9975e17b225(1);
    killplayer(enemyb, enemyteammates[1]);

    while(!istrue(playerb.gulagarena)) {
      waitframe();
    }

    wait 10;
    setDvar(@ "hash_2c879521333c4987", 3);
    killplayerinstant(playerb, []);
    playerc scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    playera thread scripts\mp\gametypes\br_gulag::playergulagautowin("devtest", playerc, 0);
  }

  if(argshave(args, "teamwipe2")) {
    killplayerinstant(host, enemyteammates[0]);
    host waittill("killcam_ended");
    wait 2;
    count = 0;

    foreach(player in hostteammates) {
      if(player != host) {
        if(count > 0) {
          player scripts\mp\gametypes\br_plunder::playersetplundercount(45);
          player function_df49f9975e17b225(1);
        }

        killplayerinstant(player, enemyteammates[1]);
        count++;
        wait 5;
      }
    }
  }

  if(argshave(args, "gulag11")) {
    host function_df49f9975e17b225(1);
    putinlaststand(host, enemyteammates[1]);
    wait 1;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    wait 1;
    host scripts\mp\laststand::finishreviveplayer("self_revive_success", host);
    wait 10;
    killplayer(host, enemyteammates[0]);
  }

  if(argshave(args, "infilDeath")) {
    thread waitandsuicide(getdvarint(@ "test_suicide", 1), hostteammates[1]);
    onprematchstarted2();
    level waittill("br_c130_left_bounds");
    wait 2;
    hostteammates[2] function_df49f9975e17b225(0);
    killplayerinstant(hostteammates[2], enemyteammates[0]);
    wait 10;
    host function_df49f9975e17b225(0);
    killplayerinstant(host, enemyteammates[0]);
  }

  if(argshave(args, "reconGulag1")) {
    setDvar(@ "br_minplayers", 9);
    wait 5;
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[1][0];
    disconnectbot(enemyteammates[0][2]);
    disconnectbot(enemyteammates[0][1]);
    disconnectbot(enemyteammates[1][2]);
    disconnectbot(enemyteammates[1][1]);
    disconnectbot(hostteammates[2]);
    disconnectbot(hostteammates[1]);
    wait 1;
    host playerstartrecondronewait();
    enemy1 function_df49f9975e17b225(1);
    killplayerinstant(enemy1, enemy2);
    wait 7;
    host function_df49f9975e17b225(1);

    if(!host scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      host scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    killplayerinstant(host, enemy2, 1);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    killplayerinstant(enemy1, host);
  }

  if(argshave(args, "reconGulag2")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(enemyteammates[0][2]);
    disconnectbot(enemyteammates[1][2]);
    disconnectbot(enemyteammates[1][1]);
    disconnectbot(enemyteammates[1][0]);
    killplayerinstant(friendly2, enemy1);
    wait 1;
    friendly1 playerstartrecondronewait();
    wait 2;
    killplayerinstant(host, enemy1);
    host waittill("killcam_ended");
    wait 3;
    enemy2 function_df49f9975e17b225(1);
    killplayerinstant(enemy2, friendly1);
    friendly1 function_df49f9975e17b225(1);

    if(!friendly1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      friendly1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    }

    killplayerinstant(friendly1, enemy1, 1);

    while(!istrue(friendly1.gulagarena)) {
      waitframe();
    }

    wait 10;
    killplayerinstant(friendly1, enemy2);
  }

  if(argshave(args, "endGameTwoDie")) {
    setDvar(@ "br_minplayers", 8);
    wait 5;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    enemy1 = enemyteammates[0][0];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    killplayerinstant(enemyteammates[0][2], host);
    killplayerinstant(enemyteammates[0][1], host);
    killplayerinstant(enemyteammates[1][2], host);
    killplayerinstant(enemyteammates[1][1], host);
    killplayerinstant(enemyteammates[1][0], host);
    killplayerinstant(friendly1, enemy1);
    killplayerinstant(friendly2, enemy1);
    wait 3;
    host scripts\mp\juggernaut::jugg_makejuggernaut(level.juggksglobals.config);
    wait 3;
    enemy1 dodamage(999, enemy1.origin, enemy1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

    while(isalive(host)) {
      host dodamage(999, host.origin, host, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      waitframe();
    }
  }

  if(argshave(args, "infiniteLoot")) {
    setomnvar("scriptable_loot_hide", 0);
    startorigin = host.origin;
    startangles = host.angles;
    curxoffset = 0;
    curyoffset = 0;

    for(var_338deefd32d7ae30 = 0; true; var_338deefd32d7ae30 = 0) {
      dropinfo = getitemdropinfo(startorigin + (curxoffset, curyoffset, 0), startangles);
      spawnpickup("brloot_self_revive", dropinfo);
      var_338deefd32d7ae30++;
      curxoffset += 10;

      if(curxoffset > 5000) {
        curxoffset = 0;
        curyoffset += 10;

        if(curyoffset > 100) {
          curyoffset = 0;
        }
      }

      if(var_338deefd32d7ae30 > 8) {
        waitframe();
      }
    }
  }

  if(argshave(args, "tempTeamTest")) {
    enemy1 = enemyteammates[0][0];
    enemy1 hudoutlineenableforclient(host, "defaulthudoutline");
    host.var_b5091efefe8e436b = "axis";
    enemy1.var_b5091efefe8e436b = "axis";
  }

  if(argshave(args, "gulag22a")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[1][0];
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    enemy3 function_df49f9975e17b225(1);
    killplayer(host, enemyteammates[0]);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(enemy3, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    gulagenemy = enemy1;

    if(teammate == enemy1) {
      gulagenemy = enemy2;
    }

    killplayer(host, gulagenemy);
    wait getdvarint(@ "test_wait", 2);
    disconnectbot(teammate);
  }

  if(argshave(args, "gulag22b")) {
    setDvar(@ "hash_8bdee07fa09e810a", 0);
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[1][0];
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendlyjail = hostteammates[1];

    if(friendlyjail == host || friendlyjail == var_70189b6a231df8d6) {
      friendlyjail = hostteammates[2];
    }

    friendlyjail function_df49f9975e17b225(1);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 12;
    killplayer(friendlyjail, enemy3);
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    gulagenemy = enemy1;

    if(teammate == enemy1) {
      gulagenemy = enemy2;
    }

    killplayer(host, gulagenemy);

    while(!isDefined(host getspectatingplayer()) || host getspectatingplayer() != teammate) {
      waitframe();
    }

    wait getdvarint(@ "hash_c12d58979b7c7ca8", 3);
    assert(teammate == var_70189b6a231df8d6);
    killplayer(teammate, enemy1);

    while(!isDefined(host getspectatingplayer()) || host getspectatingplayer() != friendlyjail) {
      waitframe();
    }

    var_df2fbb13c226be75 = "timeout";

    if(namespace_eb17b46cdcb98eea::function_1980065ce4dc067b()) {
      var_df2fbb13c226be75 = "br_twotwo_gulag_win_jail_timeout";
    }

    thread scripts\mp\gametypes\br_gulag::gulagvictory(friendlyjail.arena, friendlyjail, 1, 0, var_df2fbb13c226be75);
  }

  if(argshave(args, "gulag22c")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[1][0];
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    enemy3 function_df49f9975e17b225(1);
    killplayer(host, enemyteammates[0]);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(enemy3, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    gulagenemy = enemy1;

    if(teammate == enemy1) {
      gulagenemy = enemy2;
    }

    killplayer(host, gulagenemy);
    killplayer(teammate, gulagenemy);
    setDvar(@ "hash_9e78730ec3baa38c", 0.1);
    eventdata = level.br_pe_data[3];
    eventdata.active = 1;
    scripts\mp\gametypes\br_publicevents::activateevent(eventdata);
  }

  if(argshave(args, "gulag22d")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    var_24b7d6dc16777f00 = enemy1;

    if(teammate == enemy1) {
      var_24b7d6dc16777f00 = enemy2;
    }

    killplayer(host, var_24b7d6dc16777f00);
    killplayer(teammate, var_24b7d6dc16777f00);
    wait 10;
    setDvar(@ "hash_9e78730ec3baa38c", 0.1);
    eventdata = level.br_pe_data[3];
    eventdata.active = 1;
    scripts\mp\gametypes\br_publicevents::activateevent(eventdata);
  }

  if(argshave(args, "gulag22e")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);
    wait 1;
    killplayer(friendly2, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    killplayer(enemy1, host);
    killplayer(enemy2, host);
  }

  if(argshave(args, "gulag22f")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 10;
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    host iprintlnbold("END ARENA");
    host.arena notify("matchEnded");
    host.arena notify("fight_over_early");
    thread scripts\mp\gametypes\br_gulag::handleendarena(host.arena, undefined, 1, 1, "debug", friendly2);
    wait 10;
    host iprintlnbold("Kill Players");
    killplayer(enemy1, host);
    killplayer(enemy2, host);
  }

  if(argshave(args, "gulag22g")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[0][2];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait getdvarint(@ "test_wait", 12);

    if(getdvarint(@ "test_kill", 0)) {
      killplayer(host, enemyteammates[0]);
      killplayer(var_70189b6a231df8d6, enemyteammates[0]);
      wait getdvarfloat(@ "hash_3a9d30277e079900", 0);
    } else if(getdvarint(@ "test_kill2", 0)) {
      killplayer(host, enemyteammates[0]);
      wait getdvarfloat(@ "hash_3a9d30277e079900", 0);
    }

    arena = host.arena;

    if(getdvarint(@ "test_allies", 0)) {
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(host, friendly2, "debug");
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(var_70189b6a231df8d6, friendly2, "debug");
    } else {
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(enemy1, enemy3, "debug");
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(enemy1, enemy3, "debug");
    }
  }

  if(argshave(args, "gulag22h")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[0][2];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait getdvarint(@ "test_wait", 12);

    if(getdvarint(@ "test_kill", 0)) {
      killplayer(host, enemyteammates[0]);
      killplayer(var_70189b6a231df8d6, enemyteammates[0]);
      wait getdvarfloat(@ "hash_3a9d30277e079900", 0);
    } else if(getdvarint(@ "test_kill2", 1)) {
      killplayer(host, enemyteammates[0]);
      wait getdvarfloat(@ "hash_3a9d30277e079900", 1);
    }

    arena = host.arena;

    if(getdvarint(@ "test_allies", 1)) {
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(host, friendly2, "debug");
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(var_70189b6a231df8d6, friendly2, "debug");
    } else {
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(enemy1, enemy3, "debug");
      scripts\mp\gametypes\br_vip_quest::vip_respawnplayer(enemy1, enemy3, "debug");
    }
  }

  if(argshave(args, "gulag22i")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[0][2];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait getdvarint(@ "test_wait", 5);
    disconnectbot(var_70189b6a231df8d6);
    disconnectbot(enemy1);
    disconnectbot(enemy2);
  }

  if(argshave(args, "gulag22j")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    enemy3 = enemyteammates[0][2];
    enemya = enemyteammates[1][0];
    enemyb = enemyteammates[1][1];
    enemyc = enemyteammates[1][2];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    enemy3 function_df49f9975e17b225(1);
    enemya function_df49f9975e17b225(1);
    enemyb function_df49f9975e17b225(1);
    enemyc function_df49f9975e17b225(1);
    killplayer(enemy1, host);
    killplayer(enemy2, host);
    killplayer(enemya, host);
    killplayer(enemyb, host);

    while(!istrue(enemy1.gulagarena)) {
      waitframe();
    }

    wait getdvarint(@ "test_wait", 1);
    killplayer(host, enemy1);
    killplayer(var_70189b6a231df8d6, enemy1);
    killplayer(enemy3, host);
    killplayer(enemyc, host);

    while(!istrue(host.jailed) || !istrue(var_70189b6a231df8d6.jailed) || !istrue(enemy3.jailed) || !istrue(enemyc.jailed)) {
      waitframe();
    }

    scripts\mp\gametypes\br_gulag::shutdowngulag("debug", 0);
  }

  if(argshave(args, "gulag22k")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    var_70189b6a231df8d6 = hostteammates[0];

    if(var_70189b6a231df8d6 == host) {
      var_70189b6a231df8d6 = hostteammates[1];
    }

    var_70189b6a231df8d6 function_df49f9975e17b225(1);
    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    host function_df49f9975e17b225(1);
    enemy1 function_df49f9975e17b225(1);
    enemy2 function_df49f9975e17b225(1);
    killplayer(enemy1, enemyteammates[1]);
    killplayer(enemy2, enemyteammates[1]);
    killplayer(host, enemyteammates[0]);
    killplayer(var_70189b6a231df8d6, enemyteammates[0]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    wait 12;
    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    killplayer(var_70189b6a231df8d6, host);
    killplayer(enemy2, host);
  }

  if(argshave(args, "jailbreakRespawn")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    friendly1 = hostteammates[0];

    if(friendly1 == host) {
      friendly1 = hostteammates[1];
    }

    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    friendly2 function_df49f9975e17b225(1);
    killplayer(host, enemyteammates[1]);
    killplayer(friendly1, enemyteammates[1]);
    killplayer(friendly2, enemyteammates[0]);
    wait getdvarint(@ "hash_3a9d33277e079f99", 10);
    setDvar(@ "hash_9e78730ec3baa38c", 0.1);
    eventdata = level.br_pe_data[3];
    eventdata.active = 1;
    scripts\mp\gametypes\br_publicevents::activateevent(eventdata);
  }

  if(argshave(args, "gulag22l")) {
    [hostteammates, enemyteammates] = setnumteams(args, 4);
    playera = host;
    playerb = enemyteammates[0][0];
    playerc = enemyteammates[1][0];
    playerd = enemyteammates[2][0];
    playere = enemyteammates[2][1];
    friendly1 = hostteammates[0];

    if(friendly1 == host) {
      friendly1 = hostteammates[1];
    }

    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    playera function_df49f9975e17b225(1);
    playerb function_df49f9975e17b225(1);
    playerc function_df49f9975e17b225(0);
    playerd function_df49f9975e17b225(1);
    playere function_df49f9975e17b225(1);
    killplayer(playera, enemyteammates[1]);
    killplayer(playerb, enemyteammates[1]);
    killplayer(playerd, enemyteammates[0]);
    killplayer(playere, enemyteammates[0]);
    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(enemyteammates[1][1]);
    disconnectbot(enemyteammates[1][2]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    assert(teammate == playerb);
    wait 10;
    arena = host.arena;
    killplayer(playera, playerd);
    wait 3;
    killplayer(playerc, enemyteammates[2][2]);

    while(!isDefined(arena.var_707537a8904aa962) || arena.var_707537a8904aa962.size == 0) {
      waitframe();
    }

    jailer = arena.var_707537a8904aa962[0];
    wait 3;

    while(isalive(jailer)) {
      jailer dodamage(jailer.health, playerb.origin, playerb, playerb, "MOD_RIFLE_BULLET", playerb getcurrentprimaryweapon());
    }

    while(!isalive(playera)) {
      waitframe();
    }

    wait 3;
    playera function_df49f9975e17b225(0);
    killplayer(playera, playerd);
  }

  if(argshave(args, "gulag22m")) {
    [hostteammates, enemyteammates] = setnumteams(args, 4);
    playera = host;
    playerb = enemyteammates[0][0];
    playerc = enemyteammates[1][0];
    playerd = enemyteammates[1][1];
    friendly1 = hostteammates[0];

    if(friendly1 == host) {
      friendly1 = hostteammates[1];
    }

    friendly2 = hostteammates[2];

    if(friendly2 == host) {
      friendly2 = hostteammates[1];
    }

    playera function_df49f9975e17b225(1);
    playerb function_df49f9975e17b225(1);
    playerc function_df49f9975e17b225(1);
    playerd function_df49f9975e17b225(1);
    killplayer(playera, enemyteammates[1]);
    killplayer(playerb, enemyteammates[1]);
    killplayer(playerc, enemyteammates[0]);
    killplayer(playerd, enemyteammates[0]);
    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(enemyteammates[0][1]);
    disconnectbot(enemyteammates[0][2]);

    while(!istrue(host.gulagarena)) {
      waitframe();
    }

    teammate = scripts\mp\gametypes\br_twotwo_gulag::function_1bd32287885bb933(host);
    assert(teammate == playerb);
    wait 10;
    arena = host.arena;
    killplayer(playerb, playerd);
    wait 3;
    killplayer(playera, playerd);
  }

  if(argshave(args, "endGameTeam")) {
    level.br_infils_disabled = 1;
    setDvar(@ "br_minplayers", 8);
    wait 5;
    scripts\mp\gametypes\br_gulag::shutdowngulag("circle_index", 0);
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    killplayerinstant(enemy2, host);
    wait 1;
    killplayerinstant(friendly1, enemy1);
    wait 1;
    killplayerinstant(friendly2, enemy1);
    wait 1;
    killplayerinstant(host, enemy1);
  }

  if(argshave(args, "riotBackSeat")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    if(!isDefined(level.var_bce6d38bf86a8328)) {
      seatid = undefined;
      spawndata = spawnStruct();
      spawndata.origin = (250, -1900, 130);
      spawndata.angles = (0, 0, 0);
      spawndata.spawntype = "DEVGUI";
      level.var_bce6d38bf86a8328 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata);
      wait 1;
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.var_bce6d38bf86a8328, "driver", friendly1, undefined, 1);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.var_bce6d38bf86a8328, "front_right", friendly2, undefined, 1);
    }

    setomnvar("scriptable_loot_hide", 0);
    host takeallweapons();
    host function_d5d7db93c58f96b7("iw9_me_riotshield_mp");
    host function_d5d7db93c58f96b7("iw9_me_tonfa_mp");
  }

  if(argshave(args, "interrogateKill")) {
    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    putinlaststand(enemy1, host);

    while(!istrue(host.var_93018d510a589832)) {
      waitframe();
    }

    wait getdvarfloat(@ "test_wait", 3.5);
    killplayerinstant(enemy1, friendly1);
  }

  if(argshave(args, "helmet_test")) {
    wait 1;
    var_90b785bcb1d9abf7 = host.maxarmorhealth;

    if(isDefined(args[1])) {
      var_90b785bcb1d9abf7 = int(args[1]);
    }

    foreach(enemyteam in enemyteammates) {
      foreach(targetenemy in enemyteam) {
        targetenemy scripts\cp_mp\armor::setarmorhealth(var_90b785bcb1d9abf7);
        helmet = function_53aa698b2205a4c3(targetenemy, "brloot_equip_reinforced_helmet");
        scripts\mp\gametypes\br_pickups::lootused(helmet, helmet.type, "visible", targetenemy);
        waitframe();
      }
    }
  }

  if(argshave(args, "eod_test")) {
    level thread scripts\mp\gametypes\br_dev::function_2729e9ab8a4ec44e();

    enemy1 = enemyteammates[0][0];
    enemy2 = enemyteammates[0][1];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    var_3a09c5274d12ec10 = anglestoleft(host.angles);
    neworg = host.origin + var_3a09c5274d12ec10 * 200;

    while(true) {
      enemy1 scripts\cp_mp\armor::setarmorhealth(host.maxarmorhealth);
      enemy1 scripts\mp\utility\perk::giveperk("specialty_eod");
      enemy1 setOrigin(neworg);
      enemy1 waittill("death");
      wait 3;
      enemy1 spawnclientdevtest(0);

      if(istrue(enemy1.br_iseliminated)) {
        scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(enemy1);
      }
    }
  }

  if(argshave(args, "maxloot") || argshave(args, "maxlootforce")) {
    setomnvar("scriptable_loot_hide", 0);
    numtospawn = level.br_pickups.scriptablesmax - level.br_pickups.scriptables.size;

    if(argshave(args, "maxlootforce")) {
      numtospawn = level.br_pickups.scriptablesmax;
    }

    if(numtospawn == 0) {
      return;
    }

    if(!isDefined(level.var_7494af60dff9dc61) || argshave(args, "maxlootforce")) {
      level.var_7494af60dff9dc61 = 0;
    } else {
      level.var_7494af60dff9dc61 += 30;
    }

    for(i = 0; i < numtospawn; i++) {
      function_53aa698b2205a4c3(host, "brloot_self_revive", host.origin + i * (30, 0, 0) + (0, level.var_7494af60dff9dc61, 0));
    }
  }

  if(argshave(args, "death_disconnect")) {
    killplayer(host, enemyteammates[0]);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 3;
    playertospectate = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killplayer(playertospectate, enemyteammates[0]);

    while(!isDefined(host.playertospectate)) {
      waitframe();
    }

    waitframe();
    playertospectate = host.playertospectate;
    disconnectbot(playertospectate);
  }

  if(argshave(args, "inflation")) {
    foreach(player in level.players) {
      player.br_infilstarted = 1;
      player scripts\mp\gametypes\br_plunder::playerplunderpickup(500);
    }
  }

  if(argshave(args, "afk_disconnect")) {
    foreach(player in level.players) {
      player.br_infilstarted = 1;
    }

    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);

    foreach(player in level.players) {
      if(isalive(player)) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(500);
      }
    }

    wait 10;
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    kick(playerspectating getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
  }

  if(argshave(args, "spectate_death_respawn")) {
    foreach(player in level.players) {
      player.br_infilstarted = 1;
    }

    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);

    foreach(player in level.players) {
      if(isalive(player)) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(500);
      }
    }

    wait 10;
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    killplayer(playerspectating, killer);
  }

  if(argshave(args, "spectate_death_respawn2")) {
    function_954dd6e60394e2f4();

    foreach(player in level.players) {
      player.br_infilstarted = 1;
    }

    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);

    foreach(player in level.players) {
      if(isalive(player)) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(500);
      }
    }

    wait 10;
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    killplayer(playerspectating, killer);
    wait getdvarfloat(@ "hash_588637cb5b2cb459", 5);
    disconnectbot(playerspectating);
  }

  if(argshave(args, "spectate_death_respawn3")) {
    function_954dd6e60394e2f4();

    foreach(player in level.players) {
      player.br_infilstarted = 1;
    }

    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);
    host.br_infilstarted = 0;
    host.respawndelay = 1000000;
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 10;
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    killplayer(playerspectating, killer);
    wait getdvarfloat(@ "hash_588637cb5b2cb459", 10);
    disconnectbot(playerspectating);
  }

  if(argshave(args, "spectate_death_matchend")) {
    foreach(player in level.players) {
      player.br_infilstarted = 1;
    }

    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);

    foreach(player in level.players) {
      if(isalive(player)) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(500);
      }
    }

    wait getdvarfloat(@ "hash_588637cb5b2cb459", 10);
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    playerspectating.br_infilstarted = 0;
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    killplayer(playerspectating, killer);
  }

  if(argshave(args, "respawn_token")) {
    function_954dd6e60394e2f4();
    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait getdvarfloat(@ "hash_588637cb5b2cb459", 10);
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    playerspectating scripts\mp\gametypes\br_pickups::addrespawntoken();
    playerspectating.br_infilstarted = 1;
    killplayer(playerspectating, killer);
  }

  if(argshave(args, "ui_squad_widget_test")) {
    wait 2;
    enemy1 = enemyteammates[0][0];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];
    enemy1 function_df49f9975e17b225(1);
    friendly1 function_df49f9975e17b225(1);
    friendly2 function_df49f9975e17b225(1);

    for(i = 0; i < 11; i++) {
      friendly1 scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(friendly1, "brloot_armor_plate", 1);
      friendly2 scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(friendly2, "brloot_armor_plate", 1);
      wait 0.25;
    }

    friendly1 scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(friendly1, "brloot_equip_gasmask", 1);
    friendly2 scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(friendly2, "brloot_equip_gasmask_durable", 1);
    wait 1;
    friendly1 scripts\mp\killstreaks\killstreaks::awardkillstreak("uav", "other");
    friendly2 scripts\mp\killstreaks\killstreaks::awardkillstreak("precision_airstrike", "other");
    wait 1;
    friendly1 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    friendly2 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    wait 1;
    friendly1 scripts\mp\gametypes\br_pickups::function_127474f04c3a06b5(1);
    friendly2 scripts\mp\gametypes\br_pickups::function_127474f04c3a06b5(1);
    wait 3;
    killplayer(friendly1, enemy1);

    if(!isDefined(level.var_bce6d38bf86a8328)) {
      seatid = undefined;
      spawndata = spawnStruct();
      spawndata.origin = (250, -1900, 130);
      spawndata.angles = (0, 0, 0);
      spawndata.spawntype = "DEVGUI";
      level.var_bce6d38bf86a8328 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata);
      wait 1;
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.var_bce6d38bf86a8328, "driver", friendly2, undefined, 1);
    }
  }

  if(argshave(args, "respawn_token_solo")) {
    function_954dd6e60394e2f4();
    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait getdvarfloat(@ "hash_588637cb5b2cb459", 10);
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    playerspectating scripts\mp\gametypes\br_pickups::addrespawntoken();
    playerspectating.br_infilstarted = 1;
    killplayer(playerspectating, killer);
  }

  if(argshave(args, "respawn_token_friendly")) {
    function_954dd6e60394e2f4();
    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    killplayer(host, var_c5f4ed006985c19b);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait getdvarfloat(@ "hash_588637cb5b2cb459", 10);
    playerspectating = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    killer = var_c5f4ed006985c19b;

    if(playerspectating == killer) {
      killer = var_c5f065006980a0ac;
    }

    playerspectating scripts\mp\gametypes\br_pickups::addrespawntoken();
    playerspectating.br_infilstarted = 1;
    killplayer(playerspectating, killer);
  }

  if(argshave(args, "go_again_gulag")) {
    function_954dd6e60394e2f4();
    setDvar(@ "hash_e5f703a38f6e8043", 9999);
    level.gulag.eventinfo.chance = 1;

    foreach(event in level.gulag.eventinfo.events) {
      if(event.settings.ref == "go_again") {
        event.weight = 10000;
        break;
      }
    }

    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly2);
    wait 2;
    killplayer(host, var_c5f4ef006985c601);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    friendly = host scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
    wait 2;
    var_c5f4ef006985c601.br_infilstarted = 1;
    friendly.br_infilstarted = 1;
    killplayer(var_c5f4ef006985c601, friendly);
    killplayer(friendly, var_c5f4ed006985c19b);

    while(!istrue(friendly.gulagarena) && !istrue(var_c5f4ef006985c601.gulagarena)) {
      waitframe();
    }

    var_c5f4ec006985bf68.br_infilstarted = 1;
    killplayer(var_c5f4ec006985bf68, var_c5f067006980a512);
    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;
    killplayer(friendly, var_c5f4ef006985c601);

    while(!istrue(friendly.gulagarena) && !istrue(var_c5f4ec006985bf68.gulagarena)) {
      waitframe();
    }

    scripts\mp\gametypes\br_spectate::waittillspectating(host);
    wait 2;

    if(getdvarint(@ "hash_8e395c0720703044", 1)) {
      killplayer(friendly, var_c5f4ec006985bf68);
    } else {
      killplayer(var_c5f4ec006985bf68, friendly);
    }

    setDvar(@ "hash_e5f703a38f6e8043", 90);
  }

  if(argshave(args, "dropItems")) {
    function_954dd6e60394e2f4();
    function_141f14f3a7ba86b2();
    wait 5;
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    player = friendly1;
    player.pers["gamemodeLoadout"] = level.gulagloadouts[0];
    struct = player scripts\mp\class::loadout_getclassstruct();
    struct = player scripts\mp\class::loadout_updateclass(struct, "gamemode");
    player scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
    player scripts\mp\class::giveloadout(player.team, "gamemode", 0, 0);
    player br_ammo_player_max_out();
    player scripts\mp\gametypes\br_plunder::playersetplundercount(0);
    br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, 3);
    player br_plunder::playerplunderpickup(5000);
    br_forcegivecustompickupitem(player, "brloot_equip_gasmask", 1);
    br_forcegivecustompickupitem(player, "brloot_self_revive", 1);
    br_forcegivecustompickupitem(player, "brloot_killstreak_uav_bigmap", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_atmine", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    br_forcegivecustompickupitem(player, "brloot_super_munitionsbox", 1);
    br_forcegivecustompickupitem(player, "brloot_perkpack_airman_jup", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
    wait 3;
    killplayerinstant(friendly1, enemyteammates[0][0]);
  }

  if(argshave(args, "dropItemsEveryone")) {
    function_954dd6e60394e2f4();
    function_141f14f3a7ba86b2();
    wait 5;
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    foreach(player in level.players) {
      player.pers["gamemodeLoadout"] = level.gulagloadouts[0];
      struct = player scripts\mp\class::loadout_getclassstruct();
      struct = player scripts\mp\class::loadout_updateclass(struct, "gamemode");
      player scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
      player scripts\mp\class::giveloadout(player.team, "gamemode", 0, 0);
      player br_ammo_player_max_out();
      player scripts\mp\gametypes\br_plunder::playersetplundercount(0);
      br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, 3);
      player br_plunder::playerplunderpickup(5000);
      br_forcegivecustompickupitem(player, "brloot_equip_gasmask", 1);
      br_forcegivecustompickupitem(player, "brloot_self_revive", 1);
      br_forcegivecustompickupitem(player, "brloot_killstreak_uav_bigmap", 1);
      br_forcegivecustompickupitem(player, "brloot_offhand_atmine", 1);
      br_forcegivecustompickupitem(player, "brloot_offhand_flash", 1);
      br_forcegivecustompickupitem(player, "brloot_super_munitionsbox", 1);
      br_forcegivecustompickupitem(player, "brloot_perkpack_airman_jup", 1);
    }

    wait 3;

    foreach(player in level.players) {
      if(player != host) {
        enemy = host;

        if(player.team == host.team) {
          enemy = enemyteammates[0][0];
        }

        thread killplayerinstant(player, enemy);
      }
    }
  }

  if(argshave(args, "enemy_turret")) {
    function_954dd6e60394e2f4();
    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    gunner = var_c5f4ef006985c601;

    if(!isDefined(level.testvehicle)) {
      spawnposition = gunner.origin + (1000, 0, 100);
      spawnangles = gunner.angles * (0, 1, 0);
      vehicle = undefined;
      seatid = undefined;
      spawndata = spawnStruct();
      spawndata.origin = spawnposition;
      spawndata.angles = spawnangles;
      spawndata.spawntype = "<dev string:x81>";
      [level.testvehicle, seatid] = scripts\cp_mp\vehicles\vehicle::function_84033ce50b8afce2("<dev string:x8b>", spawndata);
    }

    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.testvehicle, "<dev string:x9b>", gunner, undefined, 1);
  }

  if(argshave(args, "switchblade")) {
    function_954dd6e60394e2f4();
    var_c5f4ef006985c601 = enemyteammates[0][0];
    var_c5f4ec006985bf68 = enemyteammates[0][1];
    var_c5f4ed006985c19b = enemyteammates[0][2];
    var_c5f067006980a512 = enemyteammates[1][0];
    var_c5f066006980a2df = enemyteammates[1][1];
    var_c5f065006980a0ac = enemyteammates[1][2];
    friendly1 = hostteammates[1];
    friendly2 = hostteammates[2];

    if(friendly1 == host) {
      friendly1 = hostteammates[0];
    } else if(friendly2 == host) {
      friendly2 = hostteammates[0];
    }

    disconnectbot(friendly1);
    disconnectbot(friendly2);
    disconnectbot(var_c5f4ef006985c601);
    disconnectbot(var_c5f4ec006985bf68);
    disconnectbot(var_c5f067006980a512);
    disconnectbot(var_c5f066006980a2df);

    while(!isDefined(level.switchblade_drone)) {
      waitframe();
    }

    wait 2;
    level.switchblade_drone.owner = var_c5f4ed006985c19b;
    disconnectbot(var_c5f4ed006985c19b);
    level.switchblade_drone dodamage(9999, var_c5f065006980a0ac.origin, var_c5f065006980a0ac, var_c5f065006980a0ac, "MOD_EXPLOSIVE");
  }
}

function function_141f14f3a7ba86b2() {
  var_3fa40817bd0d730e = level.br_pickups.scriptablescleanupbatchsize;
  maxloot = level.br_pickups.scriptablesmax;
  level.br_pickups.scriptablescleanupbatchsize = 9999;
  level.br_pickups.scriptablesmax = level.br_pickups.scriptables.size;
  scripts\mp\gametypes\br_pickups::clearspaceforscriptableinstance();
  level.br_pickups.scriptablescleanupbatchsize = var_3fa40817bd0d730e;
  level.br_pickups.scriptablesmax = maxloot;
}

function function_d5d7db93c58f96b7(var_148a924a1aa2ca69) {
  weapnew = getweaponrootname(var_148a924a1aa2ca69);

  if(!function_89497fa763d431c0(weapnew)) {
    level.weaponmapdata[weapnew] = spawnStruct();
    level.weaponmapdata[weapnew].assetname = var_148a924a1aa2ca69;
    level.weaponmapdata[weapnew].group = "weapon_assault";
  }

  variant = -1;
  hasnvg = scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4();
  var_c88b10f789adf8eb = scripts\cp_mp\weapon::buildweapon_blueprint(weapnew, undefined, undefined, variant, undefined, undefined, hasnvg);

  if(self hasweapon(var_c88b10f789adf8eb)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_c88b10f789adf8eb);
  }

  self giveweapon(var_c88b10f789adf8eb);
  return var_c88b10f789adf8eb;
}