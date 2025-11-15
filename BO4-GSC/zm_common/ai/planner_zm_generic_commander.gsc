/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\ai\planner_zm_generic_commander.gsc
*********************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_commander_utility;
#include scripts\core_common\ai\planner_generic_commander;
#include scripts\core_common\ai\systems\planner;
#include scripts\core_common\system_shared;
#include scripts\zm_common\ai\planner_zm_commander_utility;
#include scripts\zm_common\ai\planner_zm_generic_squad;

#namespace namespace_42cba673;

autoexec __init__system__() {
  system::register(#"planner_zm_generic_commander", &__init__, undefined, undefined);
}

__init__() {
  level thread createcommander();
}

createcommanderplanner(team) {
  planner = plannerutility::createplannerfromasset(#"zm_commander.ai_htn");
  return planner;
}

createcommander() {
  team = #"allies";
  commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), createsquadplanner(team));
  plannergenericcommander::commanderdaemons(commander);
  plannercommanderutility::adddaemon(commander, #"daemonzmaltars");
  plannercommanderutility::adddaemon(commander, #"daemonzmblockers");
  plannercommanderutility::adddaemon(commander, #"daemonzmchests");
  plannercommanderutility::adddaemon(commander, #"daemonzmpowerups");
  plannercommanderutility::adddaemon(commander, #"daemonzmswitches");
  plannercommanderutility::adddaemon(commander, #"daemonzmwallbuys");
  plannercommanderutility::addsquadevaluator(commander, #"commanderscorebotpresence");
  plannercommanderutility::addsquadevaluator(commander, #"commanderscoreescortpathing");
  plannercommanderutility::addsquadevaluator(commander, #"commanderscoreforcegoal");
  plannercommanderutility::addsquadevaluator(commander, #"commanderscoreteam");
  plannercommanderutility::addsquadevaluator(commander, #"commanderscoreviableescort");
  plannercommanderutility::addsquadevaluator(commander, #"commanderscoreage", [#"maxage": 6000]);
}