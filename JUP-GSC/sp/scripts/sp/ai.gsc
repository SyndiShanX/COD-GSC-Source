/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\ai.gsc
***********************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\spawner;
#namespace ai;

function function_b1e9f30ceb841994(aigroup_name) {
  assertex(isDefined(aigroup_name), "get_group_touching_volume: aigroup_name is undefined to get group");
  guys = get_ai_group_ai(aigroup_name);
  guys_touching = function_359a5497e23b8f79(guys);
  return guys_touching;
}

function function_359a5497e23b8f79(array) {
  guys_touching = [];
  assertex(isarray(array), "array_touching_volume: array is undefined or not an array");

  foreach(guy in array) {
    if(isalive(guy) && self istouching(guy)) {
      guys_touching[guys_touching.size] = guy;
    }
  }

  return guys_touching;
}

function function_b602e9a854dcd12f(array, deadcount, flagname, timeout) {
  if(isDefined(flagname)) {
    level endon(flagname);
  }

  waittill_dead_or_dying(array, deadcount, timeout);
}

function go_to_node_targetname(targetname) {
  self endon("death");
  assertex(isDefined(targetname), "go_to_node_targetname: targetname is undefined");
  self cleargoalvolume();
  goals = get_target_goals(targetname);
  assertex(goals.size > 0, "go_to_node_targetname: could not find goal of any type with targetname: " + targetname);
  thread go_to_node(goals);
  waittill_either("goal", "stop_going_to_node");
}

function function_70c375ef912c3fc1(array, targetname, randomdelay) {
  assertex(isDefined(array), "array_set_goal: array is undefined");
  assertex(isDefined(targetname), "array_set_goal: targetname is undefined");

  foreach(ai in array) {
    if(isalive(ai)) {
      if(isDefined(randomdelay) && randomdelay > 0) {
        ai delaythread(randomfloat(randomdelay), &go_to_node_targetname, targetname);
        continue;
      }

      ai thread go_to_node_targetname(targetname);
    }
  }
}

function function_12c55fcbaa7c5346(array, targetname, deadcount, flagname, timeout, randomdelay) {
  assertex(isDefined(targetname), "array_set_goal_on_death: targetname is undefined");

  if(isDefined(deadcount) && deadcount > 0) {
    function_b602e9a854dcd12f(array, deadcount, flagname, timeout);
  }

  array = array_removedead_or_dying(array);
  level thread function_70c375ef912c3fc1(array, targetname, randomdelay);
}

function function_f2222194b84d7787(team, species, targetname, deadcount, flagname, timeout, randomdelay) {
  assertex(isDefined(team) || isDefined(species), "team_set_goal: team and species is undefined");
  assertex(isDefined(targetname), "team_set_goal: targetname is undefined");

  if(!isDefined(species)) {
    species = "all";
  }

  guys = getaispeciesarray(team, species);
  function_12c55fcbaa7c5346(guys, targetname, deadcount, flagname, timeout, randomdelay);
}

function function_105b3c0f7ba8cd09(aigroup_name, targetname, deadcount, flagname, timeout, randomdelay) {
  assertex(isDefined(aigroup_name), "group_ai_set_goal: aigroup_name for group_ai is undefined");
  assertex(isDefined(targetname), "group_ai_set_goal: targetname is undefined");
  guys = get_ai_group_ai(aigroup_name);
  function_12c55fcbaa7c5346(guys, targetname, deadcount, flagname, timeout, randomdelay);
}

function function_807f22c65e631b07(array, deadcount, flagname) {
  assertex(isDefined(array) && isarray(array), "flag_set_on_group_ai_count: array is undefined or not an array");
  assertex(isDefined(deadcount) && deadcount >= 0, "flag_set_on_group_ai_count: deadCount is undefined or less than 0");
  assertex(isDefined(flagname), "flag_set_on_group_ai_count: flagName is undefined");
  waittill_dead_or_dying(array, deadcount);
  flag_set(flagname);
}