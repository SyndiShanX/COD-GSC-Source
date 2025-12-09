/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_642f4870fb9fcc8a.gsc
***********************************************/

#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_generic_commander;
#using scripts\core_common\ai\systems\planner;
#namespace namespace_ceda4ee8;

private _createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset("tdm_commander.ai_htn");
  return planner;
}

private _createsquadplanner(team) {
  planner = plannerutility::createplannerfromasset("tdm_squad.ai_htn");
  return planner;
}

createcommander(team) {
  commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
  plannergenericcommander::commanderdaemons(commander);
  plannergenericcommander::commanderutilityevaluators(commander);
  return commander;
}