/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_50d581b454b6d41d.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_quest_util;
#namespace namespace_8dea0c1922c392c6;

function inittask() {
  function_ac97a4f2ab8c2d53("tablet", "tryAssignTask", &function_8a64133f5d5f7dd);
  function_ac97a4f2ab8c2d53("tablet", "checkTaskValid", &checktaskvalid);
  function_ac97a4f2ab8c2d53("tablet", "tryBindObjective", &trybindobjective);
  function_ac97a4f2ab8c2d53("tablet", "removeObjectiveInfo", &function_53053ea95e1148c2);
}

function function_8a64133f5d5f7dd(taskinstance) {
  representative = level.teamdata[taskinstance.team]["alivePlayers"][0];
  instance = function_e92b6ecc9ab0f07a(taskinstance.info.ref, representative);
  instance.taskinfo = taskinstance.info;
  instance thread oncontractend(taskinstance);
  instance thread function_a24a232718dd45b7(taskinstance);
  scripts\mp\gametypes\br_quest_util::onquesttablethide(instance);
  representative scripts\mp\gametypes\br_quest_util::takequesttablet(instance);
}

function function_e92b6ecc9ab0f07a(taskref, representative) {
  if(!isDefined(representative)) {
    return undefined;
  }

  var_173cbd75083beba4 = level.taskinfo.tabletsearchradius;
  var_441c690181a13ac = var_173cbd75083beba4 * var_173cbd75083beba4;
  targettablet = undefined;
  players = level.teamdata[representative.team]["players"];
  tabletname = scripts\mp\gametypes\br_quest_util::getlootname(taskref);
  targettablets = getlootscriptablearrayinradius(tabletname, undefined, representative.origin, var_173cbd75083beba4);

  foreach(tablet in targettablets) {
    if(!isDefined(level.questinfo.activetablets["" + tablet.index]) || istrue(tablet.startdisabled)) {
      continue;
    }

    foreach(player in players) {
      tabletdistancesq = distance2dsquared(tablet.origin, player.origin);

      if(tabletdistancesq < var_441c690181a13ac) {
        targettablet = tablet;
        var_441c690181a13ac = tabletdistancesq;
      }
    }
  }

  return targettablet;
}

function oncontractend(taskinstance) {
  level endon("game_ended");
  self waittill("questEnded", team, result);

  if(isDefined(result) && result == "success") {
    getscore(taskinstance);
  }

  self.taskinfo = undefined;
  scripts\mp\gametypes\br_quest_util::activatetablet(self);
  ontaskend(taskinstance, result);
}

function function_a24a232718dd45b7(taskinstance) {
  level endon("game_ended");
  self endon("questEnded");
  taskinstance endon("task_end");
  level waittill("quest_objective_updated_" + taskinstance.team, locale);
  taskinstance.locale = locale;
  players = level.teamdata[taskinstance.team]["players"];

  foreach(player in players) {
    if(isDefined(locale.objectiveiconid) && isDefined(player.objectiveinfo) && player.objectiveinfo.taskinstance != taskinstance) {
      locale scripts\mp\gametypes\br_quest_util::hidequestobjiconfromplayer(player);
    }
  }
}

function checktaskvalid(selectedtask, team) {
  representative = level.teamdata[team]["players"][0];
  instance = function_e92b6ecc9ab0f07a(selectedtask.ref, representative);

  if(!isDefined(instance)) {
    return false;
  }

  return true;
}

function trybindobjective(taskinstance) {
  locale = taskinstance.locale;

  if(!isDefined(locale)) {
    return;
  }

  objectiveinfo = spawnStruct();
  objectiveinfo.item = locale;
  objectiveinfo.taskinstance = taskinstance;
  self.objectiveinfo = objectiveinfo;

  if(isDefined(locale.objectiveiconid)) {
    locale scripts\mp\gametypes\br_quest_util::showquestobjicontoplayer(self);
  }

  if(isDefined(locale.mapcircle)) {
    locale scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(self);
  }
}

function function_53053ea95e1148c2() {
  locale = self.objectiveinfo.taskinstance.locale;

  if(!isDefined(locale)) {
    return;
  }

  if(isDefined(locale.objectiveiconid)) {
    locale scripts\mp\gametypes\br_quest_util::hidequestobjiconfromplayer(self);
  }

  if(isDefined(locale.mapcircle)) {
    locale scripts\cp_mp\utility\game_utility::function_d7d113d56ef0ef5b(self);
  }

  self.objectiveinfo notify("objective_removed");
  self.objectiveinfo = undefined;
}