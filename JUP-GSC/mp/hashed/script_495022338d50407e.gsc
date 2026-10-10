/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_495022338d50407e.gsc
*************************************************/

#using script_15ca41a3fbb0e379;
#using script_4948cdf739393d2d;
#using script_5307834cd39b435c;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_1e6a813ec859b6b9;

function function_80d68c9701e1aea5(data) {
  level.safeprops = spawnStruct();
  level.safeprops.capturetime = getdvarint(@ "hash_40d76dd47f1ffbc5", 75);
  level.safeprops.captureradius = getdvarint(@ "hash_8fd341ad9e996d3a", 150);
  safelocations = getStructArray("dmz_safe", "script_noteworthy");
  validlocations = [];

  foreach(safelocation in safelocations) {
    fortress = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f(safelocation.origin);

    if(!isDefined(fortress)) {
      validlocations[validlocations.size] = safelocation;
    }
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("safe", &function_4071d82a4af35fc);
  function_b713f2d39b34540f(data, &function_ba90393e0583b4f7, validlocations);
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x28>");
}

function function_ba90393e0583b4f7(activity, node) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_42c897c05fdda094;
  task.funcs["onTeamStart"] = &function_f28caa329349bbad;
  task.funcs["onPlayerJoined"] = &function_3436bdadd63e9416;
  task.funcs["onPlayerRemoved"] = &function_d36f7f4e34b1c64d;
  task.funcs["onTeamAssigned"] = &function_eb88f0c1bc2acd7f;
  task.ref = "dmz_safe_find";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;
  return task;
}

function function_42c897c05fdda094() {
  if(!isDefined(self.node)) {
    return;
  }

  self.safe = spawnscriptable("dmz_safe", self.node.origin, self.node.angles);
  self.safe.task = self;
  self.capturetime = level.safeprops.capturetime;

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x3d>", self.activity.name, undefined, "<dev string:x1c>", undefined, undefined, self.activity.poi, self.node.origin);

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x3d>", self.activity.name, undefined, "<dev string:x51>", undefined, undefined, self.activity.poi, self.node.origin);

  trigger = spawn("trigger_radius", self.node.origin, 0, int(level.safeprops.captureradius), int(level.safeprops.captureradius));
  trigger trigger_off();
  self.trigger = trigger;

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x62>", self.activity.name, undefined, "<dev string:x72>", undefined, undefined, self.activity.poi, self.node.origin);

  self.curorigin = self.node.origin;
  self.offset3d = (0, 0, 60);
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_map_icon_obj_recover");
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 4);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
  objective_setshowprogress(self.objidnum, 1);

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x84>", self.activity.name, undefined, "<dev string:x99>", undefined, undefined, self.activity.poi, self.node.origin);

  function_a17b754d1372f83e(2);
  thread function_a765843f381ad171();
  thread function_474e2e9b4a997564(trigger, level.safeprops.captureradius);
}

function function_eb88f0c1bc2acd7f(teamname) {
  function_1759acfd39bb5edf("dmz_safe_defend_assigned", teamname);
  function_c1fd3441ccfba6f8(teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
}

function function_3436bdadd63e9416(player) {
  if(istrue(self.started)) {
    self.safe enablescriptableplayeruse(player);
  }
}

function function_d36f7f4e34b1c64d(player) {
  self.safe disablescriptableplayeruse(player);
}

function function_f28caa329349bbad(teamname) {
  if(self.safe getscriptablepartstate("safe") == "waiting") {
    self.safe setscriptablepartstate("safe", "usable");
  }

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.team) && !array_contains(self.teams, player.team)) {
      self.safe disablescriptableplayeruse(player);
    }
  }
}

function function_a22953d5c684962b(teamname) {
  scripts\mp\gameobjects::releaseid();

  foreach(team in self.teams) {
    function_1759acfd39bb5edf("dmz_safe_defend_complete", teamname);
    function_c1fd3441ccfba6f8(teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  }

  waitframe();
  task_ended(teamname);
}

function function_4071d82a4af35fc(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(state == "usable") {
    instance setscriptablepartstate(part, "unusable");
    var_58acad1090b81311 = array_contains(instance.task.teams, player.team);

    foreach(team in instance.task.teams) {
      instance.task function_1759acfd39bb5edf("dmz_safe_defend_started", team);
    }

    if(!var_58acad1090b81311) {
      instance.task function_1759acfd39bb5edf("dmz_safe_defend_started", player.team);
    }

    waitframe();
    instance.task.trigger trigger_on();
    instance.task function_5314298e777e5688("dmz_safe_defend");

    if(!var_58acad1090b81311) {
      instance.task.activity activity_assign(player.team, undefined, player);
    }

    foreach(team in instance.task.teams) {
      if(team == player.team) {
        namespace_25b25d188ef778c4::function_1c2bd1696d29935b(team, "dmz_mission_safe_opening");
        function_c1fd3441ccfba6f8(team, "dmz_activity_action", 1, "dmz_activity_action_classic");
        continue;
      }

      namespace_25b25d188ef778c4::function_1c2bd1696d29935b(team, "dmz_mission_safe_opening_other_team");
    }

    return;
  }

  if(state == "open_usable") {
    if(!isDefined(instance.contents)) {
      instance.contents = function_d257c9925e2affd2();
      instance.containertype = 4;
      instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents(undefined, 1, player, instance.contents);
      instance.task function_a22953d5c684962b(player.team);
      return;
    }

    instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents(undefined, 1, player, instance.contents);
  }
}

function private function_a17b754d1372f83e(var_6e6ee0d9f73a2999) {
  self.agents = [];
  forwarddist = anglesToForward(self.safe.angles) * 80;
  origin = getclosestpointonnavmesh(self.safe.origin + forwarddist);
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(scripts\mp\ai_mp_controller::function_d5bc07eabf352abb(undefined, undefined, "short_range", undefined, 2), origin, self.safe.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self.poi, 1);

  if(isDefined(agent)) {
    self.agents[0] = agent;
    agent thread scripts\mp\ai_behavior::function_b11c1964f528574b(agent, 0);

    if(isagent(agent)) {
      agent scripts\mp\ai_behavior::function_304da84d9a815c01(origin, 64);
      agent allowedstances("stand");
    }
  }

  for(i = 0; i < var_6e6ee0d9f73a2999; i++) {
    agenttype = scripts\mp\ai_mp_controller::function_d5bc07eabf352abb(undefined, undefined, "short_range");
    var_50fbac14da970ae7 = randomfloatrange(144, 360);
    forward = anglesToForward(self.safe.angles) * var_50fbac14da970ae7;
    right = vectorcross((0, 0, 1), forward);
    facingangle = axistoangles(forward, right, (0, 0, 1));
    var_88b83b0d7a43ea72 = i / var_6e6ee0d9f73a2999 * 360 + randomfloatrange(-30, 30) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, var_88b83b0d7a43ea72);
    origin = getclosestpointonnavmesh(self.safe.origin + offset);
    agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(agenttype, origin, facingangle, "high", "mission", "safe", undefined, undefined, undefined, self.poi);

    if(isDefined(agent)) {
      self.agents[self.agents.size] = agent;
      agent thread scripts\mp\ai_behavior::function_b11c1964f528574b(agent);
    }
  }

  if(isDefined(self.agents)) {
    foreach(agent in self.agents) {
      if(isagent(agent)) {
        thread scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "assignment", self.assignmentname);
      }
    }
  }
}

function private function_a765843f381ad171() {
  level endon("game_ended");
  self endon("task_ended");
  self.progress = 0;
  var_a81135442ee1a731 = 0;
  var_306804c6c85c36b0 = undefined;
  intervalindex = 0;
  alertradius = 512;
  helicalled = 0;
  shownplayers = [];

  while(true) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!isDefined(var_306804c6c85c36b0)) {
        var_306804c6c85c36b0 = [0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75];
      }

      if(self.nearbyplayers.size > 0) {
        progressbefore = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      } else {
        progressbefore = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 2);
      }

      shownplayers = function_75a1596e8181156(self.nearbyplayers, shownplayers);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.progress / self.capturetime);

      if(self.progress >= self.capturetime) {
        function_67abfc6a70af2ccc();
      } else if(self.nearbyplayers.size > 0 && isDefined(var_306804c6c85c36b0[intervalindex]) && self.progress >= var_306804c6c85c36b0[intervalindex]) {
        intervalindex++;
        alertradius += 768;

        if(alertradius > 2816) {
          alertradius = 2816;
        }

        agents = scripts\mp\ai_mp_controller::function_353fecd1549f5f42(self.node.origin, alertradius, undefined, 3, undefined, 64, 128);

        if(isDefined(agents)) {
          self.agents = array_combine(self.agents, agents);
          var_a81135442ee1a731 += agents.size;
        }

        if(!helicalled && intervalindex == 1 && var_a81135442ee1a731 < 4) {
          var_da117ca38efac51b = scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(5, self.node.origin, "high", "mission", "safeReinforcements", undefined, undefined, 1, self.node.poi, "Helicopter", 32, 64, ["shotgun"]);

          if(isDefined(var_da117ca38efac51b) && var_da117ca38efac51b.size > 0) {
            helicalled = 1;
            self.agents = array_combine(self.agents, var_da117ca38efac51b);
          }
        }
      } else if(self.nearbyplayers.size == 0 && intervalindex > 0) {
        intervalindex = 0;
        alertradius = 512;

        foreach(agent in self.agents) {
          agent.var_9f78b0c726e807ff = 0;
        }
      }
    }

    waitframe();
  }
}

function private function_75a1596e8181156(nearbyplayers, shownplayers) {
  allplayers = array_combine(nearbyplayers, shownplayers);

  foreach(player in allplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!array_contains(shownplayers, player) && array_contains(nearbyplayers, player)) {
      scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::function_7299a742781a5030(2, player);
      scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21(&"MP_DMZ_MISSIONS/OPENING_SAFE", player);
      continue;
    }

    if(array_contains(shownplayers, player) && !array_contains(nearbyplayers, player)) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::function_7299a742781a5030(0, player);
    }
  }

  return nearbyplayers;
}

function private function_67abfc6a70af2ccc() {
  self.trigger delete();
  function_42718c89b38e260b(self.objidnum, self.teams);

  foreach(agent in self.agents) {
    agent.var_9f78b0c726e807ff = 0;
  }

  foreach(team in self.teams) {
    function_1759acfd39bb5edf("dmz_safe_defend_unlocked", team);
    function_c1fd3441ccfba6f8(team, "dmz_activity_tension", 1, "dmz_activity_tension_classic");
    namespace_25b25d188ef778c4::function_1c2bd1696d29935b(team, "dmz_mission_safe_unlocked");
  }

  self.safe setscriptablepartstate("safe", "open_usable");
  function_5314298e777e5688("dmz_safe_loot");
}

function private function_474e2e9b4a997564(trigger, radius) {
  level endon("game_ended");
  self endon("task_ended");
  self.nearbyplayers = [];

  while(true) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || array_contains(self.nearbyplayers, player)) {
      continue;
    }

    self.nearbyplayers = array_add(self.nearbyplayers, player);
    thread function_d5720ae15e13ff51(trigger, player, radius);
  }
}

function private function_d257c9925e2affd2() {
  contents = [];
  var_8edb49adf90c641a = randomintrange(50, 75);
  contents[0]["quantity"] = var_8edb49adf90c641a;
  contents[0]["lootID"] = 8395;
  contents[1]["quantity"] = 125 - var_8edb49adf90c641a;
  contents[1]["lootID"] = 8395;

  if(randomint(2) > 0) {
    contents[2]["quantity"] = 1;
    contents[2]["lootID"] = 9230;
  } else {
    contents[2]["quantity"] = 1;
    contents[2]["lootID"] = 9224;
  }

  randomint = randomint(3);

  if(randomint == 0) {
    contents[3]["quantity"] = 5;
    contents[3]["lootID"] = 9111;
  } else if(randomint == 1) {
    contents[3]["quantity"] = 1;
    contents[3]["lootID"] = 8548;
    contents[4]["quantity"] = 1;
    contents[4]["lootID"] = 8548;
  } else {
    contents[3]["quantity"] = 5;
    contents[3]["lootID"] = 8372;
  }

  if(randomfloat(1) < 0.2) {
    randomint = randomint(3);
    index = contents.size;

    if(randomint == 0) {
      contents[index]["quantity"] = 1;
      contents[index]["lootID"] = 8089;
    } else if(randomint == 1) {
      contents[index]["quantity"] = 1;
      contents[index]["lootID"] = 3200;
    } else {
      contents[index]["quantity"] = 1;
      contents[index]["lootID"] = 2696;
    }
  }

  return array_randomize(contents);
}

function private function_d5720ae15e13ff51(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2) {
    wait 0.2;
  }

  self.nearbyplayers = array_remove(self.nearbyplayers, player);
}