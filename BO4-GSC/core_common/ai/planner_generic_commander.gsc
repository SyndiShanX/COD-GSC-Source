/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\planner_generic_commander.gsc
********************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\strategic_command;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;

#namespace plannergenericcommander;

private _createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset("strategic_commander.ai_htn");
  return planner;
}

private _createsquadplanner(team) {
  planner = plannerutility::createplannerfromasset("strategic_squad.ai_htn");
  return planner;
}

createcommander(team) {
  commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
  commanderdaemons(commander);
  commanderutilityevaluators(commander);
  blackboard::setstructblackboardattribute(commander, #"gameobjects_exclude", array("ammo_cache", "mobile_armory", "trap"));
  return commander;
}

commanderdaemons(commander) {
  assert(isstruct(commander));
  plannercommanderutility::adddaemon(commander, "daemonClients");
  plannercommanderutility::adddaemon(commander, "daemonGameobjects");
}

commanderutilityevaluators(commander) {
  assert(isstruct(commander));
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotChain");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotVehiclePresence");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreEscortPathing");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectsValidity");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPathing");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreNoTarget");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreViableEscort");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreProgressThrottling");
  plannercommanderutility::addsquadevaluator(commander, "commanderScoreTarget");
}

function_6549878f() {
  function_321afadc();
  level.axiscommander = createcommander(#"axis");
  level.alliescommander = createcommander(#"allies");
}

function_321afadc() {
  strategiccommandutility::function_1852d313("default_strategicbundle", "sidea");
  strategiccommandutility::function_1852d313("default_strategicbundle", "sideb");
}