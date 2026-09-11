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
  var0 = [];
  GscBinSkip0(0x2e, 0, "left");
}

function getsplittimes(var0) {
  getsplittimesside(var0, 7, 8, 0, anim.splitarrivalsleft, anim.splitexitsleft);
  getsplittimesside(var0, 8, 9, 1, anim.splitarrivalsright, anim.splitexitsright);
}

function getsplittimesside(var0, var1, var2, var3, var4, var5) {
  var6 = 0;

  for(var7 = var1; var7 <= var2; var7++) {
    if(!var6) {
      foreach(var10, var9 in var4) {
        if(isDefined(anim.archetypes[var0]["cover_trans"]) && isDefined(anim.archetypes[var0]["cover_trans"][var10]) && isDefined(anim.archetypes[var0]["cover_trans"][var10][var7])) {
          anim.archetypes[var0]["cover_trans_predist"][var10][var7] = getmovedelta(anim.archetypes[var0]["cover_trans"][var10][var7], 0, gettranssplittime(var0, var10, var7));
          anim.archetypes[var0]["cover_trans_dist"][var10][var7] = getmovedelta(anim.archetypes[var0]["cover_trans"][var10][var7], 0, 1) - anim.archetypes[var0]["cover_trans_predist"][var10][var7];
          anim.archetypes[var0]["cover_trans_angles"][var10][var7] = getangledelta(anim.archetypes[var0]["cover_trans"][var10][var7], 0, 1);
        }
      }

      foreach(var10, var9 in var5) {
        if(isDefined(anim.archetypes[var0]["cover_exit"]) && isDefined(anim.archetypes[var0]["cover_exit"][var10]) && isDefined(anim.archetypes[var0]["cover_exit"][var10][var7])) {
          anim.archetypes[var0]["cover_exit_dist"][var10][var7] = getmovedelta(anim.archetypes[var0]["cover_exit"][var10][var7], 0, getexitsplittime(var0, var10, var7));
          anim.archetypes[var0]["cover_exit_postdist"][var10][var7] = getmovedelta(anim.archetypes[var0]["cover_exit"][var10][var7], 0, 1) - anim.archetypes[var0]["cover_exit_dist"][var10][var7];
          anim.archetypes[var0]["cover_exit_angles"][var10][var7] = getangledelta(anim.archetypes[var0]["cover_exit"][var10][var7], 0, 1);
        }
      }
    }
  }
}

function getexitsplittime(var0, var1, var2) {
  return anim.archetypes[var0]["cover_exit_split"][var1][var2];
}

function gettranssplittime(var0, var1, var2) {
  return anim.archetypes[var0]["cover_trans_split"][var1][var2];
}