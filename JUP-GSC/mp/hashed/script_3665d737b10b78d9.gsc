/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3665d737b10b78d9.gsc
*************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_3b383680f332db52;

function function_80d68c9701e1aea5(data) {
  if(!istrue(level.supportsai)) {
    return;
  }

  level.elimprops = spawnStruct();
  level.elimprops.circleradius = getdvarint(@ "hash_fff0fc72eb6baf5c", 800);
  level.elimprops.var_e3aa1de9d96e0086 = getdvarint(@ "hash_f1a5f02ed324be1f", 200);
  level.elimprops.wanderradius = getdvarint(@ "hash_bf58de61e69c846b", 200);
  level.elimprops.tier3weight = getdvarint(@ "hash_160d5dea50195723", 30);
  level.elimprops.tier2weight = getdvarint(@ "hash_cbd3439c13338226", 50);
  level.elimprops.var_8ebba99852aa5265 = getdvarint(@ "hash_dc9a41086c28c4c2", 20);
  level.elimprops.tier2keys = getdvarint(@ "hash_6f328864b0b8dc62", 0);
  level.elimprops.var_b68c2a8c7c682857 = getdvarint(@ "hash_18b5f4b80cca8e31", 80);
  level.elimprops.var_92304cbe2f72ae5c = getdvarint(@ "hash_4767a58a76a283f6", 30);
  level.elimprops.var_caad6eda57cd258d = getdvarint(@ "hash_7b8b57c6513edd4f", 5);
  level.elimprops.var_d930bd12aa1fd3f2 = getdvarint(@ "hash_1144299c01007574", 10);
  validnodes = getStructArray("elim_target", "script_noteworthy");
  function_b713f2d39b34540f(data, &function_3c906415e5828995, validnodes);
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x2b>");
}

function function_3c906415e5828995(activity, node) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_4eead3091a075f56;
  task.funcs["onTeamStart"] = &function_250b27b303aee1cf;
  task.funcs["onPlayerJoined"] = &function_fdfe221dcff2f6f4;
  task.funcs["onPlayerRemoved"] = &function_792124e8bd5a56c7;
  task.funcs["onTeamAssigned"] = &function_4b91bb084671306d;
  task.funcs["onCancel"] = &function_9ab1e3e53b4b5816;
  task.ref = "dmz_elimination";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;
  task.spawnreinforcements = 1;
  return task;
}

function function_4eead3091a075f56() {
  self.activity.origin = self.node.origin;
  circlelocation = function_ab50f62a3a730400(self.node.origin, level.elimprops.circleradius);
  function_c847bfd52c064289(circlelocation + (0, 0, 300));
  function_8cd2ac82037f025c("Hostage_Dmz", circlelocation, level.elimprops.circleradius + 200);
  var_30b708220bb23467 = [];
  targetorigin = getclosestpointonnavmesh(self.node.origin);
  aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar");
  elimtarget = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, targetorigin, self.node.angles, "absolute", "mission", "elimTarget", undefined, undefined, undefined, self.node.poi, 0, undefined, 0);

  if(!isDefined(elimtarget)) {
    function_565a5ca9eef7c50();
    return;
  }

  elimtarget.var_b582b10663b5b2a9 = 0;
  var_7e1ff9afa225e8a1 = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];
  grenade_type = random(var_7e1ff9afa225e8a1);
  armor = 500;
  helmet = 3;
  body = random(["body_dmz_opforce_cartel_1_1", "body_dmz_opforce_cartel_1_2", "body_dmz_opforce_cartel_1_3", "body_dmz_opforce_cartel_2_1", "body_dmz_opforce_cartel_2_2", "body_dmz_opforce_cartel_2_3", "body_dmz_opforce_cartel_3_1", "body_dmz_opforce_cartel_3_2", "body_dmz_opforce_cartel_3_3"]);
  head = random(["head_sp_opforce_cartel_tier_2_2_1", "head_sp_opforce_cartel_tier_2_5_1", "head_sp_opforce_cartel_tier_2_6_1"]);
  elimtarget scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(body, head, function_3fa9aa825ada06dd(), grenade_type, 4, armor, helmet);

  if(getdvarint(@ "hash_49b37fc622a4d585", 0) == 1) {
    elimtarget function_3de79443c911d4a5(1, 4, "MP_DMZ_MISSIONS/BOSS_NAME_YEGOR");
  }

  var_30b708220bb23467[0] = elimtarget;
  self.enemy = elimtarget;
  thread function_47ef6b3f2a53e9c1();

  thread function_8eff76549b46f53a();

  thread scripts\mp\ai_behavior::function_b11c1964f528574b(elimtarget, undefined, self.node.origin);
  minions = [];

  if(isDefined(self.node.target)) {
    minions = function_e9591df01126977(self.node.target, self.enemy.origin);

    if(isDefined(minions) && minions.size > 0) {
      var_30b708220bb23467 = array_combine(var_30b708220bb23467, minions);
    }
  }

  foreach(agent in minions) {
    thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, level.elimprops.wanderradius, 0);
  }

  self.enemy thread function_49f737a7c10fb88f();

  function_c704f6b8763d15b4(self.enemy);
  self.enemy.dontkilloff = 1;
  self.enemy thread function_bcad41ab1c2f02b4(self);
  self.name = function_c393b86b6a285acf();
}

function function_fdfe221dcff2f6f4(player) {
  if(istrue(self.started)) {
    function_caeaf68ab0e87565([player], "dmz_elimination_start", undefined, "dmz_elimination_start_classic");
  }
}

function function_792124e8bd5a56c7(player) {
  player setplayermusicstate("");
}

function function_4b91bb084671306d(teamname) {
  level endon("game_ended");
  self endon("task_ended");
  players = getteamdata(teamname, "players");
  function_1759acfd39bb5edf("dmz_elim_assigned", teamname);
  function_e54df8560bf7dc64(teamname);
  thread function_9e357e07833a0d1a(teamname);
  function_c1fd3441ccfba6f8(teamname, "dmz_elimination_start", 1, "dmz_elimination_start_classic");

  if(!istrue(self.var_9f3aa3d57fc5acb5)) {
    if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
      thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_assigned_" + random(["hpt", "hvt"]), teamname, 2);
    } else {
      thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_assigned_" + self.name, teamname, 2);
    }

    return;
  }

  if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_enemy_generic", teamname, 2.5);
    return;
  }

  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_enemy", teamname, 2.5);
}

function function_250b27b303aee1cf(teamname) {
  thread function_914887dea271d706(teamname);
}

function function_9ab1e3e53b4b5816(teamname) {
  players = getteamdata(teamname, "players");

  foreach(player in players) {
    player setplayermusicstate("");
  }

  if(!istrue(self.completed)) {
    function_565a5ca9eef7c50();
  }
}

function private function_bcad41ab1c2f02b4(task) {
  task endon("task_ended");
  level endon("game_ended");
  self waittill("death", killer);

  if(isDefined(task.activity.activitystarter)) {
    task.activity.activitystarter function_66da9365bbfea8b7();
  }

  killerteam = undefined;
  killedbyplayer = 0;
  nearbyteammate = undefined;
  origin = self.origin;

  if(killer scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    killerteam = killer.ownerteam;
    killedbyplayer = 1;
  } else if(isPlayer(killer)) {
    killerteam = killer.team;
    killedbyplayer = 1;
  }

  if(isDefined(task.teams[0])) {
    nearbyteammate = task function_4fdc05ffda09146e(origin, 300, task.teams[0]);
  } else if(isDefined(killerteam)) {
    nearbyteammate = task function_4fdc05ffda09146e(origin, 300, killerteam);
  }

  wait 1;

  if(isDefined(task.teams[0])) {
    if(isDefined(nearbyteammate) && nearbyteammate.team == task.teams[0]) {
      task function_cd4f277cf0d6a560(task.teams[0]);
      task function_a1738a95d7aa8094("dmz_elim_complete", "elim", task.activity.cashreward, task.teams[0]);
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_yegor_kia_confirmed", task.teams[0], 2.5);
      function_c1fd3441ccfba6f8(task.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      task thread function_565a5ca9eef7c50(task.teams[0]);
      return;
    } else if(isDefined(killerteam) && killerteam == task.teams[0]) {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_yegor_killed", task.teams[0], 2.5);
      function_c1fd3441ccfba6f8(task.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
    } else {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_enemy", task.teams[0], 2.5);
      function_c1fd3441ccfba6f8(task.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
    }

    if(!isDefined(nearbyteammate)) {
      task function_6fea61f1f7158926(origin, task.teams[0]);
      task function_a1738a95d7aa8094("dmz_elim_complete", "elim", task.activity.cashreward, task.teams[0]);
      task function_cd4f277cf0d6a560(task.teams[0]);

      if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_confirmed_no_contract_" + random(["hpt", "hvt"]), task.teams[0], 2.5);
      } else {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_confirmed_no_contract_" + task.name, task.teams[0], 2.5);
      }

      function_c1fd3441ccfba6f8(task.teams[0], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      task thread function_565a5ca9eef7c50(task.teams[0]);
    }

    return;
  }

  if(isDefined(killerteam)) {
    if(isDefined(nearbyteammate)) {
      if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_not_assigned_" + random(["hpt", "hvt"]), killerteam, 2.5);
      } else {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_not_assigned_" + task.name, killerteam, 2.5);
      }

      function_c1fd3441ccfba6f8(killerteam, "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
      task function_cd4f277cf0d6a560(killerteam);
      task thread function_565a5ca9eef7c50(undefined);
      return;
    }

    if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_no_contract_no_confirmation_" + random(["hpt", "hvt"]), killerteam, 2.5);
    } else {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_killed_no_contract_no_confirmation_" + task.name, killerteam, 2.5);
    }

    task function_6fea61f1f7158926(origin, killerteam);

    if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_confirmed_no_contract_" + random(["hpt", "hvt"]), killerteam, 2.5);
    } else {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_confirmed_no_contract_" + task.name, killerteam, 2.5);
    }

    function_c1fd3441ccfba6f8(killerteam, "dmz_elimination_win", 0.5, "dmz_elimination_win_classic");
    task function_cd4f277cf0d6a560(killerteam);
    task thread function_565a5ca9eef7c50();
  }
}

function private function_6fea61f1f7158926(origin, team) {
  function_5314298e777e5688("dmz_confirm_kill");
  self.var_9f3aa3d57fc5acb5 = 1;
  function_cef2ed613a8338be(origin + (0, 0, 50));
  function_2476daefa3384c5e();

  while(true) {
    teammate = function_4fdc05ffda09146e(origin, 200, team);

    if(isDefined(teammate)) {
      break;
    }

    wait 1;
  }
}

function private function_565a5ca9eef7c50(winningteam) {
  self.completed = 1;
  function_629ed367d1393020();
  function_2476daefa3384c5e();
  task_ended(winningteam);
}

function private function_4fdc05ffda09146e(origin, range, team) {
  foreach(player in getteamdata(team, "players")) {
    if(distance(player.origin, origin) < range) {
      return player;
    }
  }

  return undefined;
}

function private function_c704f6b8763d15b4(agent) {
  categories = [1, 2, 3, 4];

  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    categories = ["1_sealion", "2_sealion", "3_sealion", "4_sealion"];
  } else if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
    categories = ["1_delta", "2_delta", "3_delta", "4_delta"];
  }

  weights = [level.elimprops.var_b68c2a8c7c682857, level.elimprops.var_92304cbe2f72ae5c, level.elimprops.var_caad6eda57cd258d, level.elimprops.var_d930bd12aa1fd3f2];
  randomkey = scripts\mp\locksandkeys::function_f4c3a9c8da53fbc9(categories, weights, 20, 60, 20);

  if(isDefined(randomkey)) {
    scripts\mp\ai_mp_controller::function_63a043d47490f90d(agent, randomkey);
  }

  scripts\mp\ai_mp_controller::function_63a043d47490f90d(agent, undefined, 8395, undefined, 50);
  scripts\mp\ai_mp_controller::function_63a043d47490f90d(agent, "loot_key_fortress", undefined, 0.35);
}

function private function_914887dea271d706(teamname) {
  level endon("game_ended");
  self endon("task_ended");

  while(true) {
    wait 1;

    if(!isDefined(self.enemy)) {
      continue;
    }

    if(!isalive(self.enemy)) {
      return;
    }

    function_4c66c3b205357c89(self.enemy.origin, teamname);
  }
}

function function_47ef6b3f2a53e9c1() {
  level endon("game_ended");
  self endon("task_ended");
  self.enemy endon("death");

  while(true) {
    circle = self.questcircles[0].mapcircle.origin;
    radius = circle[2];
    origin = (circle[0], circle[1], 0);
    dist = distance2dsquared(self.enemy.origin, origin);

    if(dist > level.elimprops.circleradius * level.elimprops.circleradius) {
      circlelocation = function_ab50f62a3a730400(self.enemy.origin, level.elimprops.circleradius);
      newcircle = (circlelocation[0], circlelocation[1], radius);
      self.questcircles[0].mapcircle moveTo(newcircle, 1, 0.25, 0.25);
      function_cef2ed613a8338be((circlelocation[0], circlelocation[1], self.enemy.origin[2] + 300));
    }

    wait 1;
  }
}

function private function_4c66c3b205357c89(enemyloc, teamname) {
  if(!istrue(self.var_47caa213efe9fd6a)) {
    players = getteamdata(teamname, "players");

    foreach(player in players) {
      if(isalive(player) && distancesquared(player.origin, enemyloc) < 1000000) {
        self.var_47caa213efe9fd6a = 1;
        player thread function_46e515bf7f51fc5a(self.enemy.origin, teamname);

        if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
          thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_near_generic", teamname, 2);
        } else {
          thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("elim_target_near", teamname, 2);
        }

        break;
      }
    }
  }
}

function private function_46e515bf7f51fc5a(enemyloc, teamname) {
  if(!istrue(self.var_1dc3b597975d2719)) {
    teamplayers = getteamdata(teamname, "players");
    nearplayers = [];

    foreach(player in teamplayers) {
      if(isalive(player) && distancesquared(player.origin, enemyloc) < 2250000) {
        nearplayers[nearplayers.size] = player;
        player.var_1dc3b597975d2719 = 1;
      }
    }

    function_caeaf68ab0e87565(nearplayers, "dmz_elimination_approach", 0, "dmz_elimination_approach_classic");
  }
}

function private function_3fa9aa825ada06dd() {
  weaponscriptable = random(["brloot_weapon_ar_akilo105_epic", "brloot_weapon_ar_mike4_rare", "brloot_weapon_ar_scharlie_elim_hvt"]);
  return level.br_lootiteminfo[weaponscriptable].fullweaponobj;
}

function private function_e9591df01126977(target, var_6c8ee20b233ca1aa) {
  var_bd0799062ead03a4 = getStructArray(target, "targetname");
  minions = [];
  totalweight = level.elimprops.tier3weight + level.elimprops.tier2weight + level.elimprops.var_8ebba99852aa5265;
  tier3chance = level.elimprops.tier3weight / totalweight;
  tier2chance = level.elimprops.tier2weight / totalweight + tier3chance;
  var_25baf6dc730b79ad = level.elimprops.var_8ebba99852aa5265 / totalweight;
  basetier = scripts\mp\ai_mp_controller::function_9b6306b0cd33bd79(self.node.origin);

  foreach(node in var_bd0799062ead03a4) {
    rand = randomfloat(1);
    spawnset = "guard";
    basetype = undefined;
    tier = basetier + 1;

    if(rand < tier3chance) {} else if(rand < tier2chance) {
      tier = basetier;
    } else {
      basetype = "strikeunit";
      tier = basetier + 1;
    }

    aitype = scripts\mp\ai_mp_controller::function_d5bc07eabf352abb(undefined, undefined, spawnset, basetype, tier);
    agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, node.origin, node.angles, "high", "mission", "elimGuards", undefined, undefined, undefined, undefined, 0);

    if(isDefined(agent)) {
      minions[minions.size] = agent;
    }
  }

  return minions;
}

function function_c393b86b6a285acf() {
  if(!isDefined(level.elimnameindex)) {
    level.elimnameindex = 0;
  }

  names = ["machado", "crybaby", "montoya", "navarro", "estrada", "romero", "toreador", "chavez"];
  name = names[level.elimnameindex % names.size];
  level.elimnameindex++;
  return name;
}

function private function_49f737a7c10fb88f() {
  self endon("death");

  while(true) {
    if(getdvarint(@ "hash_beea5652fd628e2e", 0) == 1) {
      if(isalive(self)) {
        thread scripts\mp\utility\debug::drawsphere(self.origin, 64, 1, (1, 0, 1));
      }
    }

    wait 1;
  }
}

function function_8eff76549b46f53a() {
  while(true) {
    if(getdvarint(@ "hash_f0492c0f6c817512", 0)) {
      setDvar(@ "hash_f0492c0f6c817512", 0);

      if(distance2d(self.enemy.origin, level.players[0].origin) < 2000) {
        self.enemy setOrigin(level.players[0].origin, 1);
      }
    }

    waitframe();
  }
}

# /