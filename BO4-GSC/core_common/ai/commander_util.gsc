/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\commander_util.gsc
***********************************************/

#include scripts\core_common\ai\planner_commander;

#namespace commander_util;

function_2c38e191(team) {
  switch (team) {
    case #"allies":
      if(isDefined(level.alliescommander)) {
        plannercommanderutility::function_2974807c(level.alliescommander);
      }

      break;
    case #"axis":
      if(isDefined(level.axiscommander)) {
        plannercommanderutility::function_2974807c(level.axiscommander);
      }

      break;
  }
}

pause_commander(team) {
  switch (team) {
    case #"allies":
      if(isDefined(level.alliescommander)) {
        plannercommanderutility::pausecommander(level.alliescommander);
      }

      break;
    case #"axis":
      if(isDefined(level.axiscommander)) {
        plannercommanderutility::pausecommander(level.axiscommander);
      }

      break;
  }
}