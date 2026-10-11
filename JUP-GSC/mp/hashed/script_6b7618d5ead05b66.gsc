/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6b7618d5ead05b66.gsc
*************************************************/

#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_9f2415cf2465a66d;

function function_80d68c9701e1aea5(data) {
  level.clearprops = spawnStruct();
  level.clearprops.circleradius = getdvarint(@ "hash_fe6626ef02d8f40c", 300);
  level.clearprops.var_e3aa1de9d96e0086 = getdvarint(@ "hash_336efda7c2d0eef", 700);
  function_b713f2d39b34540f(data, &function_66ffddabd1acf94d, function_cd188bf0eca0b685());
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x28>");
}

function function_66ffddabd1acf94d(activity, fortress) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_973ed02a7ff4858e;
  task.funcs["onTeamStart"] = &function_9b000e63c2c98e77;
  task.funcs["onTeamAssigned"] = &function_8eaae8654221fdc5;
  task.fortress = fortress;
  task.node = fortress;
  task.ref = "dmz_clear_fortress";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  return task;
}

function function_973ed02a7ff4858e() {
  self.killed = 0;
  circlelocation = function_ab50f62a3a730400(self.fortress.origin, level.clearprops.circleradius);
  function_c847bfd52c064289(self.fortress.origin + (0, 0, 750));
  function_325390edb051cd5d("Hostage_Dmz", [circlelocation], level.clearprops.circleradius + level.clearprops.var_e3aa1de9d96e0086);

  if(!isDefined(self.fortress.spawnedagents) || !self.fortress.spawnedagents) {
    self.fortress waittill("spawned_agents");
  }

  self.var_ffb8dd38bb2fcb3a = function_c084840561571609();

  if(!isDefined(self.var_ffb8dd38bb2fcb3a) || self.var_ffb8dd38bb2fcb3a.size == 0) {
    task_ended();
    return;
  }

  self.var_65240018a4921ea7 = self.var_ffb8dd38bb2fcb3a.size;
  self.activity.origin = self.fortress.origin;
  thread function_9935990849fe88dd();
  self.initialized = 1;
  self notify("task_initialized");
}

function function_9b000e63c2c98e77(teamname) {
  self endon("end_task");

  if(!isDefined(self.initialized) || !self.initialized) {
    self waittill("task_initialized");
  }

  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("clear_fort_approach", teamname);
}

function function_8eaae8654221fdc5(teamname) {
  self endon("end_task");

  if(!isDefined(self.initialized) || !self.initialized) {
    self waittill("task_initialized");
  }

  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("clear_fort_assigned", teamname);
  thread function_c373f127dafc389a(teamname);
  function_1759acfd39bb5edf("dmz_clear_fort_assigned", teamname);
  function_e54df8560bf7dc64(teamname);
  thread function_9e357e07833a0d1a(teamname);
}

function function_2134f4b01729bb9e(agent, killer) {
  if(isDefined(killer) && isDefined(killer.team) && array_contains(self.var_ffb8dd38bb2fcb3a, agent)) {
    function_872ad260cef5cb9a();

    if(self.var_ffb8dd38bb2fcb3a.size == 1) {
      thread function_12f03b76f27611e3(killer.team);
    }

    function_b275bda155c24c12(killer, agent);
  }
}

function function_9935990849fe88dd() {
  while(true) {
    ai = utility::charactersnear(self.fortress.origin, 3000, 0);
    var_c65a4ca6f567404a = [];

    foreach(guy in ai) {
      foreach(volume in self.fortress.var_aa7c37b8b3ec1f46) {
        if(ispointinvolume(guy.origin, volume)) {
          var_c65a4ca6f567404a[var_c65a4ca6f567404a.size] = guy;
        }
      }
    }

    if(!var_c65a4ca6f567404a.size) {
      function_1432b702120e6711(self.teams[0]);
      return;
    }

    wait 1;
  }
}

function function_1432b702120e6711(teamname) {
  self notify("end_task");
  scripts\mp\ai_mp_controller::function_66a6064fad612bf3(&function_2134f4b01729bb9e);
  function_629ed367d1393020();
  function_2476daefa3384c5e();

  if(isDefined(teamname)) {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("clear_fort_success", teamname);
    function_a1738a95d7aa8094("dmz_clear_fort_complete", "clear", self.activity.cashreward, teamname);
    function_cd4f277cf0d6a560(teamname);
    thread scripts\mp\music_and_dialog::dmz_activity_win(getteamdata(teamname, "players"));
  }

  waitframe();
  task_ended(teamname);
}

function private function_12f03b76f27611e3(teamname) {
  self endon("end_task");
  wait 15;

  while(true) {
    players = getteamdata(teamname, "players");

    foreach(ai in self.var_ffb8dd38bb2fcb3a) {
      playertotarget = undefined;
      mindist = 1000000000;

      foreach(player in players) {
        distancetoplayer = distance(ai.origin, player.origin);

        if(distancetoplayer < mindist) {
          mindist = distancetoplayer;
          playertotarget = player;
        }
      }

      if(!isDefined(playertotarget)) {
        continue;
      }

      if(!ai cansee(playertotarget) && mindist > 50 && mindist < 500) {
        scripts\mp\ai_behavior::function_a5117518725da028(ai, playertotarget.origin);
      }
    }

    wait 1;
  }
}

function private function_cd188bf0eca0b685() {
  possiblefortresses = function_afa1f5bf0de4e4d1();
  nodes = [];

  if(!isDefined(possiblefortresses)) {
    return nodes;
  }

  foreach(fort in possiblefortresses) {
    if(function_4ec4f39a2e1745f2(fort)) {
      continue;
    }

    fort.fortress = fort;
    nodes[nodes.size] = fort;
  }

  return nodes;
}

function private function_c084840561571609() {
  if(!isDefined(self.fortress)) {
    return undefined;
  }

  allai = level.agentarray;

  if(!isDefined(allai) || allai.size == 0) {
    return undefined;
  }

  validai = [];

  if(self.fortress.var_aa7c37b8b3ec1f46.size == 0) {
    return validai;
  }

  foreach(guy in allai) {
    if(!isalive(guy)) {
      continue;
    }

    foreach(volume in self.fortress.var_aa7c37b8b3ec1f46) {
      if(ispointinvolume(guy.origin, volume)) {
        validai[validai.size] = guy;
      }
    }
  }

  return validai;
}

function private function_872ad260cef5cb9a() {
  numdead = 0;
  var_9e249e6fe9f695d5 = [];

  foreach(ai in self.var_ffb8dd38bb2fcb3a) {
    if(!isalive(ai)) {
      var_9e249e6fe9f695d5[var_9e249e6fe9f695d5.size] = ai;
      numdead++;
    }
  }

  foreach(ai in var_9e249e6fe9f695d5) {
    self.var_ffb8dd38bb2fcb3a = array_remove(self.var_ffb8dd38bb2fcb3a, ai);
  }

  self.killed += numdead;
}

function private function_b275bda155c24c12(killer, agent) {
  if(self.killed >= self.var_65240018a4921ea7 || self.var_ffb8dd38bb2fcb3a.size == 0) {
    if(isDefined(agent)) {
      self.mission.objpos = agent.origin;
      self.mission.var_1dce29aa33fc1faa = agent.angles;
    }

    if(isDefined(killer) && isDefined(killer.team) && isDefined(function_73fd6fe2488e3ebf(self.activity, killer.team)) && function_73fd6fe2488e3ebf(self.activity, killer.team) == self) {
      function_1432b702120e6711(killer.team);
      return;
    }

    function_1432b702120e6711();
  }
}

function private function_c373f127dafc389a(team) {
  self endon("end_task");

  while(true) {
    players = getteamdata(team, "players");
    mindistsq = 100000;
    minorigin = (0, 0, 0);

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      distsq = distance2dsquared(self.fortress.origin, player.origin);

      if(mindistsq > distsq) {
        mindistsq = distsq;
        minorigin = player.origin;
      }
    }

    foreach(volume in self.fortress.var_aa7c37b8b3ec1f46) {
      if(ispointinvolume(minorigin, volume)) {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("clear_fort_entered", team);
        return;
      }
    }

    wait 1;
  }
}