/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\ai.gsc
**************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\spawner;
#namespace ai;

function function_72b2f4dfbf66e9f9(aigroup_name) {
  assert(isDefined(aigroup_name), "<dev string:x24>");
  guys = utility_sp::get_ai_group_ai(aigroup_name);
  guys_touching = function_e5440f2149523194(guys);
  return guys_touching;
}

function function_e5440f2149523194(array) {
  guys_touching = [];
  assert(isarray(array), "<dev string:x69>");

  foreach(guy in array) {
    if(isalive(guy) && self istouching(guy)) {
      guys_touching[guys_touching.size] = guy;
    }
  }

  return guys_touching;
}

function function_3e227531b54311aa(array, deadcount, flagname, timeout) {
  if(isDefined(flagname)) {
    level endon(flagname);
  }

  utility_sp::waittill_dead_or_dying(array, deadcount, timeout);
}

function go_to_node_targetname(targetname) {
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(targetname), "<dev string:xa6>");
  self cleargoalvolume();
  goals = spawner::get_target_goals(targetname);
  assert(goals.size > 0, "<dev string:xd8>" + targetname);
  thread spawner::go_to_node(goals);
  utility::waittill_any("\x83\xd6\xaf\x11", "\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
}

function function_9849a628f3423eb4(array, targetname, randomdelay) {
  assert(isDefined(array), "<dev string:x124>");
  assert(isDefined(targetname), "<dev string:x14a>");

  foreach(ai in array) {
    if(isalive(ai)) {
      if(isDefined(randomdelay) && randomdelay > 0) {
        ai utility::delaythread(randomfloat(randomdelay), &go_to_node_targetname, targetname);
        continue;
      }

      ai thread go_to_node_targetname(targetname);
    }
  }
}

function function_91f99f9b7be5a557(array, targetname, deadcount, flagname, timeout, randomdelay) {
  assert(isDefined(targetname), "<dev string:x175>");

  if(isDefined(deadcount) && deadcount > 0) {
    function_3e227531b54311aa(array, deadcount, flagname, timeout);
  }

  array = utility::array_removedead_or_dying(array);
  level thread function_9849a628f3423eb4(array, targetname, randomdelay);
}

function function_1776b3116ab891b2(team, species, targetname, deadcount, flagname, timeout, randomdelay) {
  assert(isDefined(team) || isDefined(species), "<dev string:x1a9>");
  assert(isDefined(targetname), "<dev string:x1d9>");

  if(!isDefined(species)) {
    species = "\xc0\xc6J";
  }

  guys = getaispeciesarray(team, species);
  function_91f99f9b7be5a557(guys, targetname, deadcount, flagname, timeout, randomdelay);
}

function function_9a017e3c5b526368(aigroup_name, targetname, deadcount, flagname, timeout, randomdelay) {
  assert(isDefined(aigroup_name), "<dev string:x203>");
  assert(isDefined(targetname), "<dev string:x240>");
  guys = utility_sp::get_ai_group_ai(aigroup_name);
  function_91f99f9b7be5a557(guys, targetname, deadcount, flagname, timeout, randomdelay);
}

function function_bc627d2efc3461fa(array, deadcount, flagname) {
  assert(isDefined(array) && isarray(array), "<dev string:x26e>");
  assert(isDefined(deadcount) && deadcount >= 0, "<dev string:x2b0>");
  assert(isDefined(flagname), "<dev string:x2f5>");
  utility_sp::waittill_dead_or_dying(array, deadcount);
  utility::flag_set(flagname);
}