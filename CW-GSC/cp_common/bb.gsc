/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\bb.gsc
***********************************************/

#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace bb;

function private autoexec __init__system__() {
  system::register(#"bb", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  callback::on_spawned(&function_3872d0f0);
  callback::on_spawned(&function_70635e9d);
  callback::on_spawned(&function_88a4e45c);
  callback::on_spawned(&function_85a6ae83);
}

function private function_3872d0f0() {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self notify("676c2f77e9785ef0");
  self endon("676c2f77e9785ef0");
  self notifyonplayercommand("objective_ping", "+scores");

  while(true) {
    self waittill(#"objective_ping");
    function_cd497743("show_objectives", self);
  }
}

function private function_70635e9d() {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self notify("757ff94f2b51b3cb");
  self endon("757ff94f2b51b3cb");
  waitframe(1);

  while(isDefined(level.var_a8072505)) {
    event = self waittill(#"stealth_alert");
    enemies = getaiteamarray("axis");
    var_f5c94561 = -1;

    foreach(var_9e578de5 in enemies) {
      if(var_9e578de5 === event.receiver) {
        continue;
      }

      var_e081fa2b = [[level.var_a8072505]](var_9e578de5.alertlevelscript);

      if(var_f5c94561 < var_e081fa2b) {
        var_f5c94561 = var_e081fa2b;
      }
    }

    if(event.var_c0659057 > var_f5c94561) {
      function_8fca6a2e(event, self);
    }
  }
}

function private function_88a4e45c() {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self notify("51e343fcfe3f702b");
  self endon("51e343fcfe3f702b");

  while(true) {
    waitresult = self waittill(#"weapon_switch_started");
    curweap = self getcurrentweapon();

    if(waitresult.weapon !== curweap) {
      if(curweap.name !== "none") {
        function_141c945e("stop", curweap, self);

        if(curweap.type !== "melee" && self getammocount(curweap) == 0) {
          function_141c945e("noammo", curweap, self);
          function_cd497743("out_of_ammo", self);
        }
      }

      if(waitresult.weapon.name !== "none") {
        function_141c945e("start", waitresult.weapon, self);

        if(waitresult.weapon.name === # "gadget_health_regen") {
          function_cd497743("heal", self);
        }
      }
    }
  }
}

function private function_85a6ae83() {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self notify("6d685e8e8bf91248");
  self endon("6d685e8e8bf91248");

  while(true) {
    if(getdvarint(#"hash_7b899094cda20ec3", 1)) {
      recordbreadcrumbdataforplayer(self);
    }

    wait getdvarfloat(#"hash_48fe774d185ff64a", 2);
  }
}

function private function_56f03b13(player) {
  var_4f1ec5c = "";

  if(isDefined(player.var_efc688f7)) {
    for(index = 0; index < player.var_efc688f7.size; index++) {
      if(isDefined(player.var_efc688f7[index]) && player.var_efc688f7[index]) {
        if(isDefined(var_4f1ec5c) && var_4f1ec5c != "") {
          var_4f1ec5c += ";";
        }

        var_4f1ec5c += index;
      }
    }
  }

  return var_4f1ec5c;
}

function private function_bb412e85() {
  var_2084f739 = {};
  var_2084f739.gametime = gettime();
  var_2084f739.level_name = level.script;

  if(!isDefined(var_2084f739.level_name)) {
    var_2084f739.level_name = util::get_map_name();
  }

  return var_2084f739;
}

function function_74cad77c(player) {
  if(!isPlayer(player)) {
    return;
  }

  var_604bf865 = 1;

  if(isDefined(player.deaths) && player.deaths > 0) {
    var_604bf865 = player.deaths;
  }

  kdratio = player.kills / var_604bf865;
  playertime = 0;

  if(isDefined(player.var_c2287847)) {
    playertime = gettime() - player.var_c2287847;
  }

  totalshots = 0;
  shotshit = 0;

  if(isDefined(player._bbdata)) {
    totalshots = isDefined(player._bbdata[# "shots"]) ? player._bbdata[# "shots"] : 0;
    shotshit = isDefined(player._bbdata[# "hits"]) ? player._bbdata[# "hits"] : 0;
  }

  accuracy = 0;

  if(totalshots > 0) {
    accuracy = shotshit / totalshots;
  }

  var_4f1ec5c = function_56f03b13(player);
  corners = getEntArray("minimap_corner", "targetname");
  var_94ab7d87 = 0;
  var_82a3d984 = 0;

  if(isDefined(corners) && corners.size >= 2) {
    var_94ab7d87 = corners[1].origin[0] - corners[0].origin[0];
    var_82a3d984 = corners[1].origin[1] - corners[0].origin[1];
  }

  rankxp = 0;
  rank = 0;

  if(isDefined(player.pers)) {
    if(isDefined(player.pers[# "rank"])) {
      rank = player.pers[# "rank"];
    }

    if(isDefined(player.pers[# "rankxp"])) {
      rankxp = player.pers[# "rankxp"];
    }
  }

  var_18e1bf78 = 0;
  var_34a1cd0e = 0;
  var_8ee7643d = 0;
  var_3ce237d6 = 0;
  var_1940d7af = 0;
  var_da1d706e = 0;
  var_64170450 = 0;
  var_766d092d = 0;
  var_d703cc3c = 0;

  if(isDefined(player.movementtracking)) {
    if(isDefined(player.movementtracking.doublejump)) {
      var_18e1bf78 = player.movementtracking.doublejump.distance;
      var_34a1cd0e = player.movementtracking.doublejump.count;
      var_8ee7643d = player.movementtracking.doublejump.time;
    }

    if(isDefined(player.movementtracking.wallrunning)) {
      var_3ce237d6 = player.movementtracking.wallrunning.distance;
      var_1940d7af = player.movementtracking.wallrunning.count;
      var_da1d706e = player.movementtracking.wallrunning.time;
    }

    if(isDefined(player.movementtracking.sprinting)) {
      var_64170450 = player.movementtracking.sprinting.distance;
      var_766d092d = player.movementtracking.sprinting.count;
      var_d703cc3c = player.movementtracking.sprinting.time;
    }
  }

  playerid = getplayerspawnid(player);
  bestkillstreak = isDefined(player.pers[# "best_kill_streak"]) ? player.pers[# "best_kill_streak"] : 0;
  meleekills = isDefined(player.meleekills) ? player.meleekills : 0;
  headshots = isDefined(player.headshots) ? player.headshots : 0;
  var_f71b6142 = isDefined(player.primaryloadoutweapon) ? player.primaryloadoutweapon.name : "undefined";
  currentweapon = isDefined(player.currentweapon) ? player.currentweapon.name : "undefined";
  grenadesused = isDefined(player.grenadesused) ? player.grenadesused : 0;
  playername = isDefined(player.name) ? player.name : "undefined";
  kills = isDefined(player.kills) ? player.kills : 0;
  deaths = isDefined(player.deaths) ? player.deaths : 0;
  incaps = isDefined(player.pers[# "incaps"]) ? player.pers[# "incaps"] : 0;
  assists = isDefined(player.assists) ? player.assists : 0;
  score = isDefined(player.score) ? player.score : 0;
  var_2084f739 = function_bb412e85();
  var_2084f739.spawnid = playerid;
  var_2084f739.username = playername;
  var_2084f739.kills = kills;
  var_2084f739.deaths = deaths;
  var_2084f739.incaps = incaps;
  var_2084f739.kd = kdratio;
  var_2084f739.shotshit = shotshit;
  var_2084f739.totalshots = totalshots;
  var_2084f739.accuracy = accuracy;
  var_2084f739.assists = assists;
  var_2084f739.score = score;
  var_2084f739.playertime = playertime;
  var_2084f739.meleekills = meleekills;
  var_2084f739.headshots = headshots;
  var_2084f739.primaryloadoutweapon = hash(var_f71b6142);
  var_2084f739.currentweapon = currentweapon;
  var_2084f739.grenadesused = grenadesused;
  var_2084f739.bestkillstreak = bestkillstreak;
  var_2084f739.dj_dist = var_18e1bf78;
  var_2084f739.var_5f11b3b0 = var_34a1cd0e;
  var_2084f739.dj_time = var_8ee7643d;
  var_2084f739.var_eeb75a04 = var_3ce237d6;
  var_2084f739.var_c595ee7d = var_1940d7af;
  var_2084f739.wallrun_time = var_da1d706e;
  var_2084f739.var_f38de5a4 = var_64170450;
  var_2084f739.var_5983424f = var_766d092d;
  var_2084f739.sprint_time = var_d703cc3c;
  var_2084f739.var_ee83c52b = var_94ab7d87;
  var_2084f739.var_c1e9a7 = var_82a3d984;
  var_2084f739.rank = rank;
  var_2084f739.rankxp = rankxp;
  var_2084f739.collectibles = var_4f1ec5c;
  function_92d1707f(#"hash_616fb54063760a91", var_2084f739);
}

function function_47cb52f6(objectivename, player, status) {
  if(!isPlayer(player)) {
    return;
  }

  playerid = -1;

  if(isPlayer(player)) {
    playerid = getplayerspawnid(player);
  } else {
    return;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.spawnid = playerid;
  var_2084f739.username = player.name;
  var_2084f739.var_ad68ffd3 = objectivename;
  var_2084f739.eventtype = status;
  var_2084f739.originx = player.origin[0];
  var_2084f739.originy = player.origin[1];
  var_2084f739.originz = player.origin[2];
  var_2084f739.kills = player.kills;
  var_2084f739.revives = player.revives;
  var_2084f739.deathcount = player.deathcount;
  var_2084f739.deaths = player.deaths;
  var_2084f739.headshots = player.headshots;
  var_2084f739.hits = player.hits;
  var_2084f739.score = player.score;
  var_2084f739.shotshit = player.shotshit;
  var_2084f739.shotsmissed = player.shotsmissed;
  var_2084f739.suicides = player.suicides;
  var_2084f739.downs = player.downs;
  var_2084f739.difficulty = level.currentdifficulty;
  function_92d1707f(#"hash_1c8379f2cae4ae9a", var_2084f739);
}

function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {
  if(!isPlayer(victim) || !is_true(victimkilled)) {
    return;
  }

  victimid = -1;
  victimname = "";
  victimtype = "";
  victimorigin = (0, 0, 0);
  var_b318ef7a = 0;
  var_dec66cf0 = 0;
  var_4d5bb08b = 0;
  var_f8a2358b = 0;
  var_f3e621df = "";
  victimlaststand = 0;
  var_a9d101f1 = 0;
  attackerid = -1;
  attackername = "";
  attackertype = "";
  attackerorigin = (0, 0, 0);
  var_599f95b5 = 0;
  var_b88cee53 = 0;
  var_7aafb2d3 = 0;
  var_e80b2895 = 0;
  var_3b40bee = "";
  var_2f2881c5 = 0;
  var_f0277724 = "";
  var_8bdcd848 = "";
  var_e6a5332b = "";
  var_53b48f29 = "";
  var_e2e23f7e = "";
  var_60fae37b = "";

  if(isDefined(attacker)) {
    if(isPlayer(attacker)) {
      attackerid = getplayerspawnid(attacker);
      attackertype = "_player";
      attackername = attacker.name;
    } else if(isai(attacker)) {
      attackertype = "_ai";
      var_60fae37b = attacker.combatmode;
      attackerid = attacker.actor_id;
    } else {
      attackertype = "_other";
    }

    attackerorigin = attacker.origin;
    var_599f95b5 = attacker.ignoreme;
    var_7aafb2d3 = attacker.fovcosine;
    var_e80b2895 = attacker.maxsightdistsqrd;

    if(isDefined(attacker.animname)) {
      var_3b40bee = attacker.animname;
    }

    if(isDefined(attacker.laststand)) {
      var_2f2881c5 = attacker.laststand;
    }
  }

  if(isDefined(victim)) {
    if(isPlayer(victim)) {
      victimid = getplayerspawnid(victim);
      victimtype = "_player";
      victimname = victim.name;
      var_a9d101f1 = victim.downs;
    } else if(isai(victim)) {
      victimtype = "_ai";
      var_e6a5332b = victim.combatmode;
      victimid = victim.actor_id;
    } else {
      victimtype = "_other";
    }

    victimorigin = victim.origin;
    var_b318ef7a = victim.ignoreme;
    var_4d5bb08b = victim.fovcosine;
    var_f8a2358b = victim.maxsightdistsqrd;

    if(isDefined(victim.animname)) {
      var_f3e621df = victim.animname;
    }

    if(isDefined(victim.laststand)) {
      victimlaststand = victim.laststand;
    }
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.attackerid = attackerid;
  var_2084f739.attackertype = attackertype;
  var_2084f739.attackername = attackername;
  var_2084f739.attackerweapon = weapon.name;
  var_2084f739.attackerx = attackerorigin[0];
  var_2084f739.attackery = attackerorigin[1];
  var_2084f739.attackerz = attackerorigin[2];
  var_2084f739.var_6116a39c = var_60fae37b;
  var_2084f739.var_599f95b5 = var_599f95b5;
  var_2084f739.var_b88cee53 = var_b88cee53;
  var_2084f739.var_7aafb2d3 = var_7aafb2d3;
  var_2084f739.var_e80b2895 = var_e80b2895;
  var_2084f739.var_3b40bee = var_3b40bee;
  var_2084f739.var_2f2881c5 = var_2f2881c5;
  var_2084f739.victimid = victimid;
  var_2084f739.victimtype = victimtype;
  var_2084f739.victimname = victimname;
  var_2084f739.originx = victimorigin[0];
  var_2084f739.originy = victimorigin[1];
  var_2084f739.originz = victimorigin[2];
  var_2084f739.var_e6a5332b = var_e6a5332b;
  var_2084f739.var_b318ef7a = var_b318ef7a;
  var_2084f739.var_dec66cf0 = var_dec66cf0;
  var_2084f739.var_4d5bb08b = var_4d5bb08b;
  var_2084f739.var_f8a2358b = var_f8a2358b;
  var_2084f739.var_f3e621df = var_f3e621df;
  var_2084f739.victimlaststand = victimlaststand;
  var_2084f739.damage = damage;
  var_2084f739.damagetype = damagetype;
  var_2084f739.damagelocation = hitlocation;
  var_2084f739.death = victimkilled;
  var_2084f739.victimdowned = victimdowned;
  var_2084f739.downs = var_a9d101f1;
  function_92d1707f(#"hash_1daf9dd7ac61d60e", var_2084f739);
}

function logaispawn(aient, spawner) {}

function function_cd497743(notificationtype, player = getplayers()[0]) {
  if(!isPlayer(player) && !isai(player)) {
    return;
  }

  playerid = -1;
  playertype = "";
  playerposition = (0, 0, 0);
  playername = "";
  playeryaw = player.angles[1];

  if(isai(player)) {
    playerid = player.actor_id;
    playertype = "_ai";
    playerposition = player.origin;
  } else if(isPlayer(player)) {
    playerid = getplayerspawnid(player);
    playertype = "_player";
    playerposition = player.origin;
    playername = player.name;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.notificationtype = notificationtype;
  var_2084f739.spawnid = playerid;
  var_2084f739.username = playername;
  var_2084f739.spawnidtype = playertype;
  var_2084f739.originx = playerposition[0];
  var_2084f739.originy = playerposition[1];
  var_2084f739.originz = playerposition[2];
  var_2084f739.angleyaw = playeryaw;
  function_92d1707f(#"hash_a2e7d42c6175a49", var_2084f739);
}

function function_7977c093(scriptbundle, selection, player) {
  if(!isPlayer(player)) {
    return;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.choice = selection;
  var_2084f739.scriptbundle = scriptbundle;
  var_2084f739.originx = player.origin[0];
  var_2084f739.originy = player.origin[1];
  var_2084f739.originz = player.origin[2];
  function_92d1707f(#"hash_682f461dfce7bcc", var_2084f739);
}

function function_a0d15803(prompt_text, var_393b6e18, player) {
  if(!isPlayer(player)) {
    return;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.prompt = prompt_text;
  var_2084f739.originx = player.origin[0];
  var_2084f739.originy = player.origin[1];
  var_2084f739.originz = player.origin[2];

  if(!isDefined(var_393b6e18)) {
    var_393b6e18 = player.origin;
  }

  var_2084f739.var_8fdde989 = var_393b6e18[0];
  var_2084f739.var_822b4e24 = var_393b6e18[1];
  var_2084f739.var_9018e9fb = var_393b6e18[2];
  function_92d1707f(#"hash_7dc6fbfa7d872255", var_2084f739);
}

function function_8fca6a2e(event, player) {
  if(!isPlayer(player)) {
    return;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.event = isDefined(event.type) ? event.type : isDefined(event.typeorig) ? event.typeorig : "<unknown>";
  var_2084f739.originx = player.origin[0];
  var_2084f739.originy = player.origin[1];
  var_2084f739.originz = player.origin[2];
  otherpos = isDefined(event.receiver.origin) ? event.receiver.origin : player.origin;
  var_2084f739.var_808bfef8 = otherpos[0];
  var_2084f739.var_727ec7 = otherpos[1];
  var_2084f739.var_1239a255 = otherpos[2];
  var_2084f739.alertlevel = isDefined(event.var_c0659057) ? event.var_c0659057 : -1;
  function_92d1707f(#"hash_7cf37e2bb4f129ae", var_2084f739);
}

function function_141c945e(action, weapon, player) {
  if(!isPlayer(player)) {
    return;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.weapname = weapon.name;
  var_2084f739.action = action;
  var_2084f739.originx = player.origin[0];
  var_2084f739.originy = player.origin[1];
  var_2084f739.originz = player.origin[2];
  function_92d1707f(#"hash_62009457b268d346", var_2084f739);
}

function function_248394b9(event, num, player = getplayers()[0]) {
  if(!isfloat(num) && !isint(num)) {
    return;
  }

  if(!isPlayer(player)) {
    return;
  }

  var_2084f739 = function_bb412e85();
  var_2084f739.event = event;

  if(isint(num)) {
    var_2084f739.var_f2ebb6e1 = num;
    var_2084f739.var_dac812c9 = float(num);
  } else if(isfloat(num)) {
    var_2084f739.var_dac812c9 = num;
    var_2084f739.var_f2ebb6e1 = int(num);
  }

  var_2084f739.playerid = getplayerspawnid(player);
  var_2084f739.playername = player.name;
  var_2084f739.var_df592595 = player.angles[1];
  var_2084f739.originx = player.origin[0];
  var_2084f739.originy = player.origin[1];
  var_2084f739.originz = player.origin[2];
  function_92d1707f(#"hash_16eb11423f4573a7", var_2084f739);
}