/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\init_move_transitions.gsc
**************************************************/

function init_move_transition_arrays() {
  if(isDefined(anim.move_transition_arrays)) {
    return;
  }

  anim.move_transition_arrays = 1;

  if(!isDefined(anim.covertrans)) {
    anim.covertrans = [];
  }

  if(!isDefined(anim.coverexit)) {
    anim.coverexit = [];
  }

  anim.maxdirections = [];
  anim.excludedir = [];
  anim.traverseinfo = [];

  if(!isDefined(anim.covertranslongestdist)) {
    anim.covertranslongestdist = [];
  }

  if(!isDefined(anim.covertransdist)) {
    anim.covertransdist = [];
  }

  if(!isDefined(anim.coverexitdist)) {
    anim.coverexitdist = [];
  }

  anim.coverexitpostdist = [];
  anim.covertranspredist = [];

  if(!isDefined(anim.covertransangles)) {
    anim.covertransangles = [];
  }

  if(!isDefined(anim.coverexitangles)) {
    anim.coverexitangles = [];
  }

  anim.arrivalendstance = [];
}

function initmovestartstoptransitions() {
  init_move_transition_arrays();
  var_0 = [];
  GscBinSkip0(0x2e, 0, "left");
}

function getsplittimes(var_0) {
  getsplittimesside(var_0, 7, 8, 0, anim.splitarrivalsleft, anim.splitexitsleft);
  getsplittimesside(var_0, 8, 9, 1, anim.splitarrivalsright, anim.splitexitsright);
}

function getsplittimesside(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  for(var_7 = var_1; var_7 <= var_2; var_7++) {
    if(!var_6) {
      foreach(var_10, var_9 in var_4) {
        if(isDefined(anim.archetypes[var_0]["cover_trans"]) && isDefined(anim.archetypes[var_0]["cover_trans"][var_10]) && isDefined(anim.archetypes[var_0]["cover_trans"][var_10][var_7])) {
          anim.archetypes[var_0]["cover_trans_predist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_10][var_7], 0, gettranssplittime(var_0, var_10, var_7));
          anim.archetypes[var_0]["cover_trans_dist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_10][var_7], 0, 1) - anim.archetypes[var_0]["cover_trans_predist"][var_10][var_7];
          anim.archetypes[var_0]["cover_trans_angles"][var_10][var_7] = getangledelta(anim.archetypes[var_0]["cover_trans"][var_10][var_7], 0, 1);
        }
      }

      foreach(var_10, var_9 in var_5) {
        if(isDefined(anim.archetypes[var_0]["cover_exit"]) && isDefined(anim.archetypes[var_0]["cover_exit"][var_10]) && isDefined(anim.archetypes[var_0]["cover_exit"][var_10][var_7])) {
          anim.archetypes[var_0]["cover_exit_dist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_10][var_7], 0, getexitsplittime(var_0, var_10, var_7));
          anim.archetypes[var_0]["cover_exit_postdist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_10][var_7], 0, 1) - anim.archetypes[var_0]["cover_exit_dist"][var_10][var_7];
          anim.archetypes[var_0]["cover_exit_angles"][var_10][var_7] = getangledelta(anim.archetypes[var_0]["cover_exit"][var_10][var_7], 0, 1);
        }
      }
    }
  }
}

function getexitsplittime(var_0, var_1, var_2) {
  return anim.archetypes[var_0]["cover_exit_split"][var_1][var_2];
}

function gettranssplittime(var_0, var_1, var_2) {
  return anim.archetypes[var_0]["cover_trans_split"][var_1][var_2];
}