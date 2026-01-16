/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_37e409875b3ab3b6.gsc
***********************************************/

#include script_37e409875b3ab3b6;
#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_generic_commander;
#include scripts\core_common\ai\planner_generic_squad;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\zm_common\ai\planner_zm_commander_utility;
#include scripts\zm_common\ai\planner_zm_generic_commander;
#include scripts\zm_common\ai\planner_zm_generic_squad;
#include scripts\zm_common\ai\planner_zm_squad_utility;

#namespace namespace_4932f496;

private _createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset("zm_commander.ai_htn");
  return planner;
}

private _createsquadplanner(team) {
  planner = plannerutility::createplannerfromasset("zm_squad.ai_htn");
  return planner;
}

createcommander() {
  team = #"allies";
  commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
  plannergenericcommander::commanderdaemons(commander);
  plannercommanderutility::adddaemon(commander, "daemonZmBlockers");
  plannercommanderutility::adddaemon(commander, "daemonZmWallBuys");
  plannergenericcommander::commanderutilityevaluators(commander);
}