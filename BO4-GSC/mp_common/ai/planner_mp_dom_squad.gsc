/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\ai\planner_mp_dom_squad.gsc
*************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\systems\planner;
#include scripts\mp_common\ai\planner_mp_squad_utility;

#namespace plannermpdomsquad;

createsquadplanner(team) {
  planner = plannerutility::createplannerfromasset("mp_dom_squad.ai_htn");
  return planner;
}