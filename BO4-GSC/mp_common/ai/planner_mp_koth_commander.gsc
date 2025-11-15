/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\ai\planner_mp_koth_commander.gsc
******************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_generic_commander;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\mp_common\ai\planner_mp_commander_utility;
#include scripts\mp_common\ai\planner_mp_koth_squad;

#namespace plannermpkothcommander;

private createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset("mp_koth_commander.ai_htn");
  return planner;
}

createcommander(team) {
  commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermpkothsquad::createsquadplanner(team), float(function_60d95f53()) / 1000 * 40, float(function_60d95f53()) / 1000 * 100, 3, 3);
  plannergenericcommander::commanderdaemons(commander);
  plannercommanderutility::adddaemon(commander, "daemonKothZone");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreKothZone");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage": 15000]);
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
  return commander;
}