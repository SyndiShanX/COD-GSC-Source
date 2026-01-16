/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\ai\planner_mp_tdm_commander.gsc
*****************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_generic_commander;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\mp_common\ai\planner_mp_commander_utility;
#include scripts\mp_common\ai\planner_mp_tdm_squad;

#namespace plannermptdmcommander;

private createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset("mp_tdm_commander.ai_htn");
  return planner;
}

createcommander(team) {
  commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermptdmsquad::createsquadplanner(team));
  plannergenericcommander::commanderdaemons(commander);
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage": 15000]);
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
  return commander;
}