/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_casino.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\core_common\struct;
#include scripts\mp\mp_casino_scripted;
#include scripts\mp_common\load;

#namespace mp_casino;

function_1fb8a998(originallocation, newlocation) {
  movepoint = spawnStruct();
  movepoint.originallocation = originallocation;
  movepoint.newlocation = newlocation;
  return movepoint;
}

function_9bcbe7e1() {
  if(level.gametype !== "bounty") {
    return;
  }

  var_7331db53 = [];
  var_7331db53[var_7331db53.size] = function_1fb8a998((-2049, -1718, -2), (-3425, -1142, 4));
  var_7331db53[var_7331db53.size] = function_1fb8a998((0, -1024, 8), (1080, -1776, 4));
  var_7331db53[var_7331db53.size] = function_1fb8a998((0, 512, 8), (108, 948, 4));
  var_7331db53[var_7331db53.size] = function_1fb8a998((-2482, 849, 0), (-2796, 1511, 4));
  var_4ae5bbef = struct::get_array("bounty_deposit_location", "variantname");

  foreach(var_7f648714 in var_4ae5bbef) {
    foreach(movepoint in var_7331db53) {
      distance = distancesquared(var_7f648714.origin, movepoint.originallocation);

      if(distance > 1) {
        continue;
      }

      var_7f648714.origin = movepoint.newlocation;
      break;
    }
  }
}

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((108, 948, 8), (2054, 980, 8), (2557, -1878, -120), (-2796, 1511, 8), (-3425, -1142, 8), (1080, -1778, 10));
  function_9bcbe7e1();
  level.var_65f7e97e = 8;
}