/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_419eebc6f24e287.gsc
************************************************/

#using script_64acb6ce534155b7;
#using script_6d337a1fd1d54c5f;
#using script_6fc415ff6a905dc1;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_7cea3e9e755d99cc;

function function_80d68c9701e1aea5(data) {
  level.huntprops = spawnStruct();
  level.huntprops.poiradius = getdvarint(@ "hash_748ab0bc80934de8", 5000);
  level.huntprops.teamradius = getdvarint(@ "hash_88a9d31f746fdcfd", 3000);
  level.huntprops.teamradiussq = level.huntprops.teamradius * level.huntprops.teamradius;
  level.huntprops.var_feb83d3eed59be1c = getdvarint(@ "hash_c110a96f83421225", 1000);
  level.huntprops.var_e3aa1de9d96e0086 = getdvarint(@ "hash_7dc3a9f8ffacec29", 500);
  level.huntprops.var_58ef8eb47442fbe2 = getdvarint(@ "hash_8dc01b0b3abf0a38", 20);
  level.huntprops.var_6eff6b94778545a = getdvarint(@ "hash_34765b5b6345dae7", 5);
  level.huntprops.timelimit = getdvarint(@ "hash_3995eede69848e9a", 300);
  level.huntprops.scoremaxdist = getdvarfloat(@ "hash_89b6724f76aa6e23", 80000);
  level.huntprops.var_55a75ba6640b59f4 = getdvarint(@ "hash_21134403816f9c13", 3000);
  level.huntprops.var_9fe72f3581fc4d1 = getdvarint(@ "hash_af4ffd6ef7ff488c", 8000);
  level.huntprops.warningdist = getdvarint(@ "hash_be8a7d28964a6dc2", 8000);
  level.huntprops.distmodifier = getdvarfloat(@ "hash_29632d3bfbe41a8", 240);
  level.huntprops.var_5572778d2cffe0fd = getdvarfloat(@ "hash_1c5b121d784df846", 40);
  level.huntprops.var_e01b87efdea9bf3b = getdvarfloat(@ "hash_e6e560e292fa7267", 50);
  level.huntprops.var_69873adaf95b11a = getdvarfloat(@ "hash_c67f8f7bb2b43236", 2.5);
  level.huntprops.var_e8fa4e2bd0433d43 = getdvarfloat(@ "hash_a46ce7a6ed335d5b", 60);
  level.huntprops.var_15b2bbc2239d50e1 = getdvarfloat(@ "hash_db4270e079922c25", 0.05);
  level.huntprops.showtime = getdvarint(@ "hash_9ce7fc426fd9f32e", 900);
  level.huntprops.tasks = [];
  scripts\mp\team_assimilation::registerteamassimilatecallback(&function_6bdc6f56944dc3aa);
  validnodes = [];
  minimumdifficulty = data.difficulty;
  phones = getentitylessscriptablearray("brloot_activity_starter_hunt");

  foreach(phone in phones) {
    origin = phone.origin;
    poiname = scripts\mp\poi::poi_findpoioriginisin(origin);
    subarea = scripts\mp\ai_mp_controller::subarea_findfromorigin(origin, poiname);

    if(isDefined(subarea) && isDefined(subarea.var_7da9883d4168b7f1) && isDefined(subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39) && subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39 >= minimumdifficulty) {
      struct = spawnStruct();
      struct.origin = origin;
      struct.poi = poiname;
      validnodes[validnodes.size] = struct;
    }

    if(level.mapname == "<dev string:x1c>") {
      struct = spawnStruct();
      struct.origin = origin;
      validnodes[validnodes.size] = struct;
    }
  }

  function_b713f2d39b34540f(data, &function_36f0ba14f05e6af, validnodes);
}

function function_a07f7c4c0c4ef8e3() {
  return [];
}

function function_36f0ba14f05e6af(activity, node) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_566816b4f552a1c4;
  task.funcs["onTeamStart"] = &function_43c983b9b250d47d;
  task.funcs["onPlayerJoined"] = &function_241bc6ed8976306;
  task.funcs["onPlayerRemoved"] = &function_87b69c01124f351d;
  task.funcs["onTeamAssigned"] = &function_498b6e96e451e96f;
  task.funcs["onCancel"] = &function_e7c1495d8e3578d4;
  task.ref = "dmz_hunt";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;
  level.huntprops.tasks[level.huntprops.tasks.size] = task;
  return task;
}

function function_566816b4f552a1c4() {
  self.activity.origin = self.node.origin;
  function_325390edb051cd5d("Hostage_Dmz", [self.node.origin], level.huntprops.teamradius + level.huntprops.var_e3aa1de9d96e0086);
  function_c847bfd52c064289(self.node.origin);
}

function function_241bc6ed8976306(player) {
  function_1851e9cfb7687f68(player);
  function_fbf23ae15945ee5a(player);
}

function function_87b69c01124f351d(player) {
  function_556fb3a465f0e978(player);
  function_401535e3fa9e171c(player);
}

function function_6bdc6f56944dc3aa(player, oldteam, newteam) {
  foreach(task in level.huntprops.tasks) {
    if(isDefined(task.targetteam)) {
      if(oldteam == task.targetteam) {
        player.aq_targethudenabled = 0;
        player namespace_1eb3c4e0e28fac71::function_19582ba0dbcc0ab0(undefined, 0);

        if(!istrue(task.var_83c49daeea20a12c) && isDefined(task.targetplayer) && task.targetplayer == player) {
          teammates = task function_e1df4982e78536f1(player.origin);

          if(teammates.size) {
            task.targetplayer = teammates[0];
          } else if(newteam == task.teams[0]) {
            task scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_team_assimilation_all", task.teams[0]);
            task function_a1738a95d7aa8094("dmz_hunt_lost_assimilation", "hunt", 0, task.teams[0]);
            task function_56101aa018565c1b();
          } else {
            task scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_eliminated_external", task.teams[0]);
            task function_a1738a95d7aa8094("dmz_hunt_eliminated_external", "hunt", task.activity.cashreward, task.teams[0]);
            task function_56101aa018565c1b(task.teams[0]);
          }
        }
      }

      if(newteam == task.targetteam) {
        task thread function_80f01b220827b246(player, 0);
      }
    }
  }
}

function function_498b6e96e451e96f(teamname) {
  level endon("game_ended");
  self endon("task_ended");
  playersonteam = getteamdata(teamname, "players");
  origin = playersonteam[0].origin;
  nearestplayer = undefined;
  maxscore = -1;
  bestscoretype = "generic";

  foreach(player in level.players) {
    if(player.team != teamname && player scripts\cp_mp\utility\player_utility::_isalive() && !function_1a210f388465478b(player.team) && !namespace_232c174d637e4b1d::function_f35a110d69d42dc9(player.team)) {
      scores = function_3f853155c6ca8319(player, origin);
      totalplayerscore = 0;
      var_ffa9696e9e1067e5 = 0;
      var_9953fcfda245df5b = "generic";

      foreach(type, score in scores) {
        totalplayerscore += score;

        if(type != "generic" && score > var_ffa9696e9e1067e5) {
          var_ffa9696e9e1067e5 = score;
          var_9953fcfda245df5b = type;
        }
      }

      if(totalplayerscore > maxscore) {
        maxscore = totalplayerscore;
        bestscoretype = var_9953fcfda245df5b;
        nearestplayer = player;
      }
    }
  }

  if(!isDefined(nearestplayer)) {
    function_a1738a95d7aa8094("dmz_hunt_no_targets", "hunt", self.activity.cashreward, teamname);
    function_56101aa018565c1b(teamname);
    return;
  }

  self.teamorigins = [];
  function_89951899f85b3465(teamname, 0);
  thread function_995813ad75b83c53(teamname, 0);
  thread function_24d85909c1178470(nearestplayer.team, 0);
  thread function_24d85909c1178470(teamname, 1);
  self.var_2635b7b9e2ae9719 = teamname;
  self.targetteam = nearestplayer.team;
  self.targetplayer = nearestplayer;
  self.targetskilled = 0;
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_assigned_" + bestscoretype, teamname);
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_assigned_others_" + bestscoretype, self.targetteam);
  function_1759acfd39bb5edf("dmz_hunt_assigned", teamname);
  function_1759acfd39bb5edf("dmz_hunt_assigned_others", self.targetteam);
  function_c1fd3441ccfba6f8(teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  thread function_27493477868a1dbb(self.targetteam, 0);
  targetplayers = getteamdata(self.targetteam, "players");
  self.missiontime = gettime() + level.huntprops.timelimit * 1000;

  foreach(player in targetplayers) {
    thread function_80f01b220827b246(player, 0);
    player setclientomnvar("ui_br_assassination_target_timer", self.missiontime);
  }

  foreach(player in playersonteam) {
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
  }

  thread function_53ca0da8b6967dbb(0);
  thread function_17705fc9356447fb();
}

function function_43c983b9b250d47d(teamname) {}

function function_e7c1495d8e3578d4(teamname) {
  players = getteamdata(teamname, "players");

  foreach(player in players) {
    player setplayermusicstate("");
  }

  if(isDefined(self.targetteam)) {
    function_1759acfd39bb5edf("dmz_hunt_target_survived", self.targetteam);
  }

  function_8250fd658e3aae32();
  task_ended();
}

function function_8250fd658e3aae32() {
  self.taskended = 1;
  level.huntprops.tasks = array_remove(level.huntprops.tasks, self);
  function_2476daefa3384c5e();
  function_629ed367d1393020();

  if(isDefined(self.targetteam)) {
    var_7c9cff27853ab50 = getteamdata(self.targetteam, "players");

    foreach(player in var_7c9cff27853ab50) {
      player.aq_targethudenabled = 0;
      player setclientomnvar("ui_br_assassination_target", 0);
    }
  }
}

function private function_56101aa018565c1b(team) {
  function_8250fd658e3aae32();

  if(isDefined(team)) {
    function_cd4f277cf0d6a560(team);
    function_c1fd3441ccfba6f8(team, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  }

  task_ended(team);
}

function function_1a210f388465478b(team) {
  foreach(task in level.huntprops.tasks) {
    if(!istrue(task.taskended) && isDefined(task.targetteam) && task.targetteam == team) {
      return true;
    }
  }

  return false;
}

function function_3f853155c6ca8319(player, origin) {
  scores = [];
  dist = distance(origin, player.origin);
  maxdist = level.huntprops.scoremaxdist;
  distscore = max(level.huntprops.distmodifier * (1 - dist / maxdist), 0);
  teamplayers = getteamdata(player.team, "players");
  var_6d038a7052e9467c = 0;

  foreach(player in teamplayers) {
    if(player scripts\mp\utility\perk::_hasperk("specialty_ghost")) {
      var_6d038a7052e9467c++;
    }
  }

  var_4aa32c116c698ff6 = level.huntprops.var_5572778d2cffe0fd * (teamplayers.size - var_6d038a7052e9467c);
  scores["generic"] = distscore + var_4aa32c116c698ff6;
  scores["civs"] = level.huntprops.var_e01b87efdea9bf3b * ter_op(isDefined(player.civiliankillcount), player.civiliankillcount, 0);
  scores["agents"] = level.huntprops.var_69873adaf95b11a * ter_op(isDefined(player.agentkills), player.agentkills, 0);
  scores["operators"] = level.huntprops.var_e8fa4e2bd0433d43 * ter_op(isDefined(player.pers["kills"]), player.pers["kills"], 0);
  scores["valuables"] = level.huntprops.var_15b2bbc2239d50e1 * (player.plundercount + player namespace_512200f0f9e6ebc9::function_e2f4f470c55123b8(undefined, 1));
  return scores;
}

function function_17705fc9356447fb() {
  level endon("game_ended");
  self endon("task_ended");
  wait level.huntprops.timelimit;

  if(istrue(self.taskended)) {
    return;
  }

  function_a1738a95d7aa8094("dmz_hunt_lost_time", "hunt", 0, self.teams[0]);
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_lose_time", self.teams[0]);
  function_c1fd3441ccfba6f8(self.teams[0], "dmz_activity_lose", 0, "dmz_activity_lose_classic");
  function_1759acfd39bb5edf("dmz_hunt_target_survived", self.targetteam);
  function_56101aa018565c1b();
}

function function_53ca0da8b6967dbb(teamindex) {
  level endon("game_ended");
  self endon("task_ended");
  playeddialog = 0;

  while(true) {
    if(isDefined(self.targetplayer) && isDefined(self.teamorigins[teamindex]) && isDefined(self.targetplayer.guid) && isDefined(self.teamorigins[teamindex][self.targetplayer.guid])) {
      playersonteam = getteamdata(self.teams[0], "players");
      closestplayer = getclosest(self.teamorigins[teamindex][self.targetplayer.guid], playersonteam);
      dist = distance(closestplayer.origin, self.teamorigins[teamindex][self.targetplayer.guid]);
      threatlevel = 0;

      if(dist > level.huntprops.var_9fe72f3581fc4d1) {
        threatlevel = 0;
      } else if(dist > level.huntprops.var_55a75ba6640b59f4) {
        threatlevel = 1;
      } else {
        threatlevel = 2;
      }

      if(!istrue(playeddialog) && dist < level.huntprops.warningdist) {
        totarget = vectornormalize2(self.teamorigins[teamindex][self.targetplayer.guid] - closestplayer.origin);
        cosangle = 0.92388;
        coshalf = 0.707107;
        alias = "hunt_near_generic";

        if(vectordot2(totarget, (1, 0, 0), 1) > cosangle) {
          alias = "hunt_near_east";
        } else if(vectordot2(totarget, (0, 1, 0), 1) > cosangle) {
          alias = "hunt_near_north";
        } else if(vectordot2(totarget, (-1, 0, 0), 1) > cosangle) {
          alias = "hunt_near_west";
        } else if(vectordot2(totarget, (0, -1, 0), 1) > cosangle) {
          alias = "hunt_near_south";
        } else if(vectordot2(totarget, (coshalf, coshalf, 0), 1) > cosangle) {
          alias = "hunt_near_northeast";
        } else if(vectordot2(totarget, (0 - coshalf, coshalf, 0), 1) > cosangle) {
          alias = "hunt_near_northwest";
        } else if(vectordot2(totarget, (0 - coshalf, 0 - coshalf, 0), 1) > cosangle) {
          alias = "hunt_near_southwest";
        } else if(vectordot2(totarget, (coshalf, 0 - coshalf, 0), 1) > cosangle) {
          alias = "hunt_near_southeast";
        }

        scripts\cp_mp\overlord::function_9793a81bc3bc19e9(alias, self.teams[0]);
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_near_others", self.targetteam);
        playeddialog = 1;
        function_c1fd3441ccfba6f8(self.teams[0], "dmz_activity_tension", 0, "dmz_activity_tension_classic");
        function_c1fd3441ccfba6f8(self.targetteam, "dmz_activity_tension", 0, "dmz_activity_tension_classic");
      }

      var_7c9cff27853ab50 = getteamdata(self.targetteam, "players");

      foreach(player in var_7c9cff27853ab50) {
        player.aq_targethudenabled = 1;
        player namespace_1eb3c4e0e28fac71::function_19582ba0dbcc0ab0(self.targetplayer, threatlevel);
      }
    }

    wait 1;
  }
}

function function_27493477868a1dbb(team, followingteamindex) {
  level endon("game_ended");
  self endon("task_ended");
  var_7c9cff27853ab50 = getteamdata(self.targetteam, "players");

  if(!isDefined(self.targetplayer) || self.targetplayer.team != self.targetteam) {
    var_da33c7081faa4a77 = 0;

    foreach(player in var_7c9cff27853ab50) {
      if(player scripts\cp_mp\utility\player_utility::_isalive()) {
        self.targetplayer = player;
        var_da33c7081faa4a77 = 1;
        break;
      }
    }

    if(!istrue(var_da33c7081faa4a77)) {
      return;
    }
  }

  self.lastposition = self.teamorigins[followingteamindex][self.targetplayer.guid];
  var_c7111e2f9f477bec = -999999;

  while(true) {
    currenttime = gettime();
    var_7c9cff27853ab50 = getteamdata(self.targetteam, "players");
    self.targetplayers = [];
    points = [];

    if(!isDefined(self.targetplayer) || self.targetplayer.team != self.targetteam) {
      var_da33c7081faa4a77 = 0;

      foreach(player in var_7c9cff27853ab50) {
        if(player scripts\cp_mp\utility\player_utility::_isalive()) {
          self.targetplayer = player;
          var_da33c7081faa4a77 = 1;
          break;
        }
      }

      if(!istrue(var_da33c7081faa4a77)) {
        return;
      }
    }

    if(!isDefined(self.targetplayer) || !isDefined(self.teamorigins[followingteamindex][self.targetplayer.guid])) {
      return;
    }

    var_f17269c0d177f1eb = level.huntprops.var_58ef8eb47442fbe2;
    invehicle = self.targetplayer scripts\cp_mp\utility\player_utility::isinvehicle(0);

    if(invehicle) {
      var_f17269c0d177f1eb = level.huntprops.var_6eff6b94778545a;
    }

    if(currenttime - var_c7111e2f9f477bec > var_f17269c0d177f1eb * 1000) {
      radius = ter_op(invehicle, level.huntprops.var_feb83d3eed59be1c, level.huntprops.teamradius);
      circleorigin = function_ab50f62a3a730400(self.lastposition, radius);
      circleorigin = (circleorigin[0], circleorigin[1], level.huntprops.teamradius + level.huntprops.var_e3aa1de9d96e0086);
      self.questcircles[0].mapcircle moveTo(circleorigin, 1, 0.25, 0.25);
      thread function_e31ca14144dfa042();
      self.lastposition = self.teamorigins[followingteamindex][self.targetplayer.guid];
      var_c7111e2f9f477bec = currenttime;
    }

    wait 1;
  }
}

function function_e31ca14144dfa042() {
  self endon("task_ended");
  endtime = gettime() + 1200;

  while(gettime() < endtime && isDefined(self.questcircles) && isDefined(self.questcircles[0]) && isDefined(self.questcircles[0].mapcircle) && isDefined(self.questcircles[0].mapcircle.origin)) {
    function_cef2ed613a8338be(self.questcircles[0].mapcircle.origin);
    waitframe();
  }
}

function function_80f01b220827b246(targetplayer, watchingteamindex) {
  level endon("game_ended");
  self endon("task_ended");

  while(true) {
    targetplayer waittill_any_4("death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp");

    if(istrue(self.taskended)) {
      return;
    }

    if(!isDefined(targetplayer) || isDefined(targetplayer.team) && targetplayer.team != self.targetteam) {
      return;
    }

    if(istrue(targetplayer.extracted) || istrue(targetplayer.var_ded04cdd264a7e00)) {
      if(targetplayer == self.targetplayer) {
        teammates = function_e1df4982e78536f1(self.teamorigins[watchingteamindex][targetplayer.guid]);

        if(teammates.size == 0) {
          function_a1738a95d7aa8094("dmz_hunt_lost_exfilled", "hunt", self.activity.cashreward, self.teams[0]);
          function_1759acfd39bb5edf("dmz_hunt_target_over", self.targetteam);
          thread function_56101aa018565c1b();
          return;
        } else {
          self.targetplayer = teammates[0];
        }
      }
    } else if(!targetplayer scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!isDefined(targetplayer.lastkilledby) || !isDefined(targetplayer.lastkilledby.team) || targetplayer.lastkilledby.team != self.teams[0]) {
        if(!istrue(self.var_83c49daeea20a12c)) {
          teammates = function_e1df4982e78536f1(self.teamorigins[watchingteamindex][targetplayer.guid]);

          if(targetplayer == self.targetplayer) {
            if(teammates.size == 0) {
              scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_eliminated_external", self.teams[0]);
              function_a1738a95d7aa8094("dmz_hunt_eliminated_external", "hunt", self.activity.cashreward, self.teams[0]);
              function_1759acfd39bb5edf("dmz_hunt_target_over", self.targetteam);
              thread function_56101aa018565c1b(self.teams[0]);
              return;
            } else {
              self.targetplayer = teammates[0];
            }
          }
        }
      } else {
        self.var_83c49daeea20a12c = 1;

        if(!istrue(self.targetkilled)) {
          self.targetplayer = targetplayer;
          self.targetkilled = 1;
          thread function_d85cc7847f7fc492(self.teamorigins[watchingteamindex][targetplayer.guid]);
        }
      }
    }

    targetplayer waittill("tr_respawned");

    if(isDefined(targetplayer) && isDefined(self.targetplayer) && self.targetplayer == targetplayer) {
      self notify("stop_monitoring_distance");
    }
  }
}

function function_24d85909c1178470(team, index) {
  level endon("game_ended");
  self endon("task_ended");
  self.teamorigins[index] = [];

  while(true) {
    players = getteamdata(team, "players");

    foreach(player in players) {
      self.teamorigins[index][player.guid] = player.origin;
    }

    waitframe();
  }
}

function function_d85cc7847f7fc492(origin) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("stop_monitoring_distance");

  while(true) {
    count = function_a5f450d405d9d197(origin);

    if(count == 0) {
      self.var_4048af728f427ca2 = 1;

      if(getsquadmates(self.targetteam, undefined, 1).size) {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_eliminated_ran_away", self.teams[0]);
        function_1759acfd39bb5edf("dmz_hunt_target_over", self.targetteam);
      } else {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hunt_eliminated_no_dog_tags", self.teams[0]);
      }

      function_a1738a95d7aa8094("dmz_hunt_won", "hunt", self.activity.cashreward, self.teams[0]);
      function_56101aa018565c1b(self.teams[0]);
    }

    self.previouscount = count;
    wait 1;
  }
}

function function_e1df4982e78536f1(origin) {
  players = getteamdata(self.targetteam, "players");
  teammates = [];

  foreach(player in players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive() && !istrue(player.extracted) && !istrue(player.var_ded04cdd264a7e00) && distancesquared(player.origin, origin) < level.huntprops.teamradiussq) {
      teammates[teammates.size] = player;
    }
  }

  return teammates;
}

function function_a5f450d405d9d197(origin) {
  return function_e1df4982e78536f1(origin).size;
}

function function_7562a66c42d923dc() {
  if(isDefined(level.huntprops) && isDefined(level.huntprops.tasks)) {
    foreach(task in level.huntprops.tasks) {
      if(!isDefined(task.teams[0])) {
        task.activity.activitystarter function_66da9365bbfea8b7();
      }
    }

    scripts\mp\flags::gameflagwait("prematch_done");
    wait level.huntprops.showtime;

    foreach(task in level.huntprops.tasks) {
      if(!isDefined(task.teams[0])) {
        task.activity.activitystarter function_5220f38b5239eac8();
      }
    }

    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hunt_contracts_revealed", level.players);
  }
}

function function_9afa2021a101589a() {
  if(isDefined(level.huntprops) && isDefined(level.huntprops.tasks)) {
    foreach(task in level.huntprops.tasks) {
      if(!isDefined(task.teams) || !isDefined(task.teams[0])) {
        task function_56101aa018565c1b();
      }
    }
  }
}

function function_5fac7d775590ecdd(var_2635b7b9e2ae9719, huntedteam) {
  if(!isDefined(var_2635b7b9e2ae9719) || !isDefined(huntedteam)) {
    return false;
  }

  if(!isDefined(level.huntprops) || !isDefined(level.huntprops.tasks)) {
    return false;
  }

  foreach(task in level.huntprops.tasks) {
    if(isDefined(task.teams[0]) && task.teams[0] == var_2635b7b9e2ae9719 && isDefined(task.targetteam) && task.targetteam == huntedteam) {
      return true;
    }
  }

  return false;
}