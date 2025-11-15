/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\region_utility.gsc
***********************************************/

#namespace region_utility;

function_755c26d1() {
  level.lanedata = spawnStruct();
  i = 0;
  level.lanedata.var_23e0aef1 = [];

  for(var_23e0aef1 = getEntArray("vol_tregion_lane_" + i, "targetname"); isDefined(var_23e0aef1) && isarray(var_23e0aef1) && var_23e0aef1.size > 0; var_23e0aef1 = getEntArray("vol_tregion_lane_" + i, "targetname")) {
    level.lanedata.var_23e0aef1[i] = var_23e0aef1;
    waitframe(1);
    i++;
  }

  level.lanedata.numlanes = i;
}

function_9fe18733() {
  if(!isDefined(level.lanedata) || !isDefined(level.lanedata.numlanes)) {
    return 0;
  }

  return level.lanedata.numlanes;
}

function_a129ecda(startpos, endpos, lanenum) {
  function_871ecf05();
  volumes = function_8373f930(lanenum);
  function_c5b9e623(volumes, 0.2);
  return function_e86822f4(startpos, endpos);
}

function_b0f112ca(var_55e8adf1, var_d3547bb1, lanenum) {
  function_871ecf05();
  volumes = function_8373f930(lanenum);
  function_c5b9e623(volumes, 0.2);
  return function_afd64b51(var_55e8adf1, var_d3547bb1);
}

private function_871ecf05() {
  for(i = 1; i < 128; i++) {
    info = function_b507a336(i);

    if(!isDefined(info)) {
      break;
    }

    function_e563d6b7(i, 1);
  }
}

private function_8373f930(lanenum) {
  return level.lanedata.var_23e0aef1[lanenum];
}

private function_c5b9e623(volumes, score) {
  if(!isarray(volumes)) {
    return;
  }

  for(i = 1; i < 128; i++) {
    info = function_b507a336(i);

    if(!isDefined(info)) {
      break;
    }

    desired = 0;

    foreach(volume in volumes) {
      if(volume istouching(info.origin)) {
        desired = 1;
        break;
      }
    }

    if(desired) {
      function_e563d6b7(i, score);
    }
  }
}