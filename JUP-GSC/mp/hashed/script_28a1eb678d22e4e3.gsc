/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_28a1eb678d22e4e3.gsc
*************************************************/

#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using script_744cad313ed0a87e;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\teams;
#namespace namespace_9e6997f014dd0798;

function getcontractdata(data) {
  level.var_11cf2e43f74913df = spawnStruct();
  level.var_11cf2e43f74913df.time = getdvarint(@ "hash_f3296f3f7c79bfb8", 240);
  level.var_11cf2e43f74913df.maxrange = getdvarint(@ "hash_79550894c085d1db", 45000);
  level.var_11cf2e43f74913df.var_8f7c18f3dcce9dff = getdvarint(@ "hash_1b3cc7a99c2f33e5", 25000);
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["mission_infiltration_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_infiltration_fail"] = "mission_mission_time_failed";
  data.funcs["onInit"] = &function_712cf8277bcbd463;
  data.funcs["onTeamAssigned"] = &function_c53c8c4438de68a4;
}

function function_712cf8277bcbd463() {
  if(namespace_bd614c3c2275579a::function_a9b26d3ed078e149()) {
    self.tablet.startdisabled = 1;
  }

  self.tablet.strongholdcontract = 1;
  return true;
}

function function_c53c8c4438de68a4() {
  if(!isDefined(self.fortress)) {
    fortress = self.tablet function_fb13f636f30f3817();

    if(!isDefined(fortress)) {
      thread function_34bd31f3beba8f5a(1);
      return;
    }

    self.fortress = fortress;
  }

  uiobjectiveshowtoteam("strongholdInfil", self.teams[0]);
  time = level.var_11cf2e43f74913df.time;
  time = function_9b6275085fbcb8f4(time);
  function_5a15174d34f0670c(time);
  thread function_b8bab058c4c9ccb4(time);
  thread function_3b7d7950dda9e2b5();
  displayteamsplash(self.teams[0], "stronghold_infil_contract_accepted");
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_infiltration_accept", self.teams[0], 1, 1);
  self.curorigin = self.fortress.origin;
  createquestobjicon("ui_map_icon_obj_fortress", "current", self.curorigin + (0, 0, 65));
  players = getteamdata(self.teams[0], "players");

  foreach(player in players) {
    showquestobjicontoplayer(player);
  }

  thread function_e3eef0b907523e1d();
}

function function_34bd31f3beba8f5a(success) {
  self notify("task_ended");

  if(isDefined(self.objectiveiconid)) {
    deletequestobjicon();
  }

  wait 1;
  endcontract(ter_op(istrue(success), self.teams[0], undefined));

  if(isDefined(self.fortress) && istrue(success)) {
    self.fortress.infiltrated = 1;
    self.fortress.var_21d7def7d337f552 = self.teams[0];
    self.fortress notify("stronghold_infiltrated");
    namespace_9823ee6035594d67::function_d95dbf57b47734d9(self.fortress, 1);
    logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, self.fortress) + ": Fortress Infiltrated!");
    return;
  }

  if(istrue(success)) {
    params = spawnStruct();
    rewardcash = function_d282041688c032b5("strongholdInfil");
    params.intvar = rewardcash;
    function_878ebcc241b54505("stronghold_infil_contract_none", function_3d262d56274bd22e("strongholdInfil"), rewardcash, self.teams[0]);

    foreach(player in getteamdata(self.teams[0], "players")) {
      player scripts\mp\gametypes\br_plunder::playerplunderpickup(rewardcash);
      player scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(1, rewardcash);
    }

    logstring("BR STRONGHOLDS ERROR: Undefined Fortress Infiltrated!");
  }
}

function function_b8bab058c4c9ccb4(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait time;
  function_832b654e4b84c000();
}

function function_3b7d7950dda9e2b5() {
  self endon("task_ended");
  level endon("game_ended");
  self.fortress waittill("stronghold_infiltrated");
  function_832b654e4b84c000(1);
}

function function_832b654e4b84c000(enemycaptured) {
  if(!isDefined(enemycaptured)) {
    enemycaptured = 0;
  }

  params = spawnStruct();
  params.intvar = 0;
  splash = "stronghold_infil_contract_failed";

  if(istrue(enemycaptured)) {
    splash = "stronghold_infil_contract_poached";
  }

  displayteamsplash(self.teams[0], splash, params);
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_infiltration_fail", self.teams[0], 1, 1);
  thread function_34bd31f3beba8f5a(0);
}

function function_fb13f636f30f3817(var_d83087ec1b2d5259) {
  locations = array_randomize(level.var_f1073fbd45b59a06.var_df987907a483df89);
  fortress = undefined;
  bestlocindex = undefined;
  var_be0f4d48fa40793f = level.var_11cf2e43f74913df.maxrange;

  foreach(location in locations) {
    if(istrue(location.infiltrated)) {
      continue;
    }

    if(istrue(location.isblacksite) && !istrue(var_d83087ec1b2d5259)) {
      continue;
    }

    incircle = scripts\mp\gametypes\br_circle_util::function_a465e3c1371d7dab(location.origin);

    if(!istrue(incircle)) {
      continue;
    }

    if(istrue(location.unspawned)) {
      continue;
    }

    dist = distance2d(location.origin, self.origin);
    var_5435995e95681b89 = 0;

    if(dist > level.var_11cf2e43f74913df.var_8f7c18f3dcce9dff) {
      var_5435995e95681b89 = dist - level.var_11cf2e43f74913df.var_8f7c18f3dcce9dff;
    }

    if(var_5435995e95681b89 < var_be0f4d48fa40793f) {
      var_be0f4d48fa40793f = var_5435995e95681b89;
      fortress = location;

      if(var_5435995e95681b89 <= 0) {
        break;
      }
    }
  }

  return fortress;
}

function function_1cf1557a05b2ae73(spawn_origin, team) {
  finishlinevfx = spawnfx(level._effect["vfx_marker_base_orange_pulse"], spawn_origin + (0, 0, 10));
  finishlinevfx.angles = vectortoangles((0, 0, 1));
  finishlinevfx hide();
  wait 0.5;
  triggerfx(finishlinevfx);

  foreach(player in getteamdata(team, "players")) {
    finishlinevfx showtoplayer(player);
  }

  self.finishlinevfx = finishlinevfx;
}

function function_e3eef0b907523e1d() {
  self endon("task_ended");
  level endon("game_ended");

  while(true) {
    foreach(player in getteamdata(self.teams[0], "players")) {
      if(distance2d(player.origin, self.fortress.missiontrigger.origin) < self.fortress.missiontrigger.radius) {
        params = spawnStruct();
        rewardcash = function_d282041688c032b5("strongholdInfil");
        params.intvar = rewardcash;

        foreach(player in getteamdata(self.teams[0], "players")) {
          player scripts\mp\gametypes\br_plunder::playerplunderpickup(rewardcash);
          player scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(1, rewardcash);
        }

        function_878ebcc241b54505("stronghold_infil_contract_completed", function_3d262d56274bd22e("strongholdInfil"), rewardcash, self.teams[0]);
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_misc_success", self.teams[0], 1, 1);
        squadmembers = getteamdata(self.teams[0], "players");
        self.rewardmodifier = undefined;
        self.result = "success";
        thread function_34bd31f3beba8f5a(1);
        return;
      }
    }

    waitframe();
  }
}