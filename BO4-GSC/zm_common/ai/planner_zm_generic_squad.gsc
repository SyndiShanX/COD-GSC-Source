/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\ai\planner_zm_generic_squad.gsc
*****************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\systems\planner;
#include scripts\zm_common\ai\planner_zm_squad_utility;

#namespace namespace_42cba673;

createsquadplanner(team) {
  planner = plannerutility::createplannerfromasset("zm_squad.ai_htn");
  return planner;
}