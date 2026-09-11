/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops\hvt_utility.gsc
***********************************************/

function spawnhvt(var0) {
  level endon("game_ended");
  wait 1;
  var1 = scripts\engine\utility::getStructArray("hvt", "targetname");
  var2 = undefined;
  var3 = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(var2)) {
    var2 = scripts\mp\agents\agent_common::connectnewagent("player", "allies");

    if(isDefined(var2)) {
      foreach(var5 in var1) {
        if(var5.script_label == var0) {
          var3 = var5.origin;
        }
      }

      var2 thread[[var2 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var3, (0, 0, 0));
      var2.team = "axis";
      var2 scripts\mp\bots\bots_util::bot_set_difficulty("veteran");
      var2.outlineid = scripts\mp\utility\outline::outlineenableforteam(var2, var2.team, "outline_nodepth_cyan", "lowest");
      continue;
    }

    waitframe();
  }

  var2.trackedobject = var2 scripts\mp\gameobjects::createtrackedobject(var2, (0, 0, 0));
  var2.trackedobject.objidpingfriendly = 0;
  var2.trackedobject.objidpingenemy = 1;
  var2.trackedobject.objpingdelay = 4;
  var2.trackedobject.visibleteam = "friendly";
  var2.invulnerable = 1;
  var2.trackedobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend");
  thread hvtclearmove(var2);
  thread hvtdeathwatcher();

  if(!isDefined(level.hvtcount)) {
    level.hvtcount = 0;
  }

  level.hvtcount++;
  var2 scripts\mp\equipment::clearallequipment();
  level.to_ddhvt = var2;
}

function hvtclearmove(var0) {
  self botsetscriptgoal(var0, 20, "critical");
  var1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

function hvtreveal(var0) {
  var0.killoutlineid = scripts\mp\utility\outline::outlineenableforteam(var0, scripts\mp\utility\game::getotherteam(var0.team)[0], "outline_depth_orange", "lowest");
  var0.trackedobject.visibleteam = "any";
  var0.trackedobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_capture_kill");
  thread hvtdelayedendinvulnerability();
}

function hvtdelayedendinvulnerability() {
  self endon("game_ended");
  wait 1;
  self.invulnerable = 0;
}

function hvtcleanup(var0) {
  if(isDefined(var0.killoutlineid)) {
    scripts\mp\utility\outline::outlinedisable(var0.killoutlineid, var0);
  }

  if(isDefined(var0.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(var0.outlineid, var0);
  }

  var0 notify("hvt_timeout");
  var0.nocorpse = 1;
  var0 suicide();
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
  var0 = 0;

  for(;;) {
    var1 = self getnearestnode();
    self botsetscriptgoalnode(var1, "critical");
    wait 0.25;
  }
}