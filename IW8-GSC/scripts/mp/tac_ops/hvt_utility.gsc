/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops\hvt_utility.gsc
***********************************************/

function spawnhvt(var_0) {
  level endon("game_ended");
  wait 1;
  var_1 = scripts\engine\utility::getStructArray("hvt", "targetname");
  var_2 = undefined;
  var_3 = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(var_2)) {
    var_2 = scripts\mp\agents\agent_common::connectnewagent("player", "allies");

    if(isDefined(var_2)) {
      foreach(var_5 in var_1) {
        if(var_5.script_label == var_0) {
          var_3 = var_5.origin;
        }
      }

      var_2 thread[[var_2 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var_3, (0, 0, 0));
      var_2.team = "axis";
      var_2 scripts\mp\bots\bots_util::bot_set_difficulty("veteran");
      var_2.outlineid = scripts\mp\utility\outline::outlineenableforteam(var_2, var_2.team, "outline_nodepth_cyan", "lowest");
      continue;
    }

    waitframe();
  }

  var_2.trackedobject = var_2 scripts\mp\gameobjects::createtrackedobject(var_2, (0, 0, 0));
  var_2.trackedobject.objidpingfriendly = 0;
  var_2.trackedobject.objidpingenemy = 1;
  var_2.trackedobject.objpingdelay = 4;
  var_2.trackedobject.visibleteam = "friendly";
  var_2.invulnerable = 1;
  var_2.trackedobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend");
  thread hvtclearmove(var_2);
  thread hvtdeathwatcher();

  if(!isDefined(level.hvtcount)) {
    level.hvtcount = 0;
  }

  level.hvtcount++;
  var_2 scripts\mp\equipment::clearallequipment();
  level.to_ddhvt = var_2;
}

function hvtclearmove(var_0) {
  self botsetscriptgoal(var_0, 20, "critical");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

function hvtreveal(var_0) {
  var_0.killoutlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, scripts\mp\utility\game::getotherteam(var_0.team)[0], "outline_depth_orange", "lowest");
  var_0.trackedobject.visibleteam = "any";
  var_0.trackedobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_capture_kill");
  thread hvtdelayedendinvulnerability();
}

function hvtdelayedendinvulnerability() {
  self endon("game_ended");
  wait 1;
  self.invulnerable = 0;
}

function hvtcleanup(var_0) {
  if(isDefined(var_0.killoutlineid)) {
    scripts\mp\utility\outline::outlinedisable(var_0.killoutlineid, var_0);
  }

  if(isDefined(var_0.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(var_0.outlineid, var_0);
  }

  var_0 notify("hvt_timeout");
  var_0.nocorpse = 1;
  var_0 suicide();
}

function hvtdeathwatcher() {
  self endon("game_ended");
  self endon("hvt_timeout");
  self waittill("death");
  level.hvtkilled++;
  self.trackedobject scripts\mp\gameobjects::releaseid();

  if(level.hvtkilled == 1) {
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if(isDefined(level.onphaseend)) {
      [[level.onphaseend]]("allies");
    }

    setomnvar("ui_hardpoint_timer", 0);
    setomnvar("ui_hardpoint", -1);
    return;
  }
}

function hvtthreatwatcher() {
  self endon("death");
  self endon("game_ended");
  var_0 = 0;

  for(;;) {
    var_1 = self getnearestnode();
    self botsetscriptgoalnode(var_1, "critical");
    wait 0.25;
  }
}