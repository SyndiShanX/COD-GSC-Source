/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\ai\planner_mp_sd_commander.gsc
****************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_generic_commander;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\mp_common\ai\planner_mp_commander_utility;
#include scripts\mp_common\ai\planner_mp_sd_squad;

#namespace plannermpsdcommander;

private createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset("mp_sd_commander.ai_htn");
  return planner;
}

createcommander(team) {
  commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermpsdsquad::createsquadplanner(team), float(function_60d95f53()) / 1000 * 40, float(function_60d95f53()) / 1000 * 100, 3, 3);
  plannergenericcommander::commanderdaemons(commander);
  plannercommanderutility::adddaemon(commander, "daemonSdBomb");
  plannercommanderutility::adddaemon(commander, "daemonSdBombZones");
  plannercommanderutility::adddaemon(commander, "daemonSdDefuseObj");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage": 6000]);
  return commander;
}