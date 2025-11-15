/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\planner_commander_interface.gsc
**********************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\systems\ai_interface;

#namespace commanderinterface;

registercommanderinterfaceattributes() {
  ai::registerentityinterface(#"commander", #"commander_force_goal", undefined, &plannercommanderutility::setforcegoalattribute);
  ai::registermatchedinterface(#"commander", #"commander_golden_path", 1, array(1, 0), &plannercommanderutility::setgoldenpathattribute);
}