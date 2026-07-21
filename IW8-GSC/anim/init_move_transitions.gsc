/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\init_move_transitions.gsc
***********************************************/

init_move_transition_arrays() {
  if(isDefined(anim.move_transition_arrays)) {
    return;
  }
  anim.move_transition_arrays = 1;

  if(!isDefined(anim.covertrans))
    anim.covertrans = [];

  if(!isDefined(anim.coverexit))
    anim.coverexit = [];

  anim.maxdirections = [];
  anim.excludedir = [];
  anim.traverseinfo = [];

  if(!isDefined(anim.covertranslongestdist))
    anim.covertranslongestdist = [];

  if(!isDefined(anim.covertransdist))
    anim.covertransdist = [];

  if(!isDefined(anim.coverexitdist))
    anim.coverexitdist = [];

  anim.coverexitpostdist = [];
  anim.covertranspredist = [];

  if(!isDefined(anim.covertransangles))
    anim.covertransangles = [];

  if(!isDefined(anim.coverexitangles))
    anim.coverexitangles = [];

  anim.arrivalendstance = [];
}

initmovestartstoptransitions() {
  init_move_transition_arrays();
  var_0 = [];
  var_0[0] = "left";
  var_0[1] = "right";
  var_0[2] = "left_crouch";
  var_0[3] = "right_crouch";
  var_0[4] = "crouch";
  var_0[5] = "stand";
  var_0[6] = "exposed";
  var_0[7] = "exposed_crouch";
  var_0[8] = "stand_saw";
  var_0[9] = "prone_saw";
  var_0[10] = "crouch_saw";
  var_0[11] = "wall_over_40";
  var_0[12] = "right_cqb";
  var_0[13] = "right_crouch_cqb";
  var_0[14] = "left_cqb";
  var_0[15] = "left_crouch_cqb";
  var_0[16] = "exposed_cqb";
  var_0[17] = "exposed_crouch_cqb";
  var_0[18] = "heat";
  var_0[19] = "heat_left";
  var_0[20] = "heat_right";
  var_0[21] = "exposed_ready";
  var_0[22] = "exposed_ready_cqb";
  var_1 = 6;
  anim.approach_types = [];
  anim.approach_types["Cover Left"] = [];
  anim.approach_types["Cover Left"]["stand"] = "left";
  anim.approach_types["Cover Left"]["crouch"] = "left_crouch";
  anim.maxdirections["Cover Left"] = 9;
  anim.excludedir["Cover Left"] = 9;
  anim.approach_types["Cover Right"] = [];
  anim.approach_types["Cover Right"]["stand"] = "right";
  anim.approach_types["Cover Right"]["crouch"] = "right_crouch";
  anim.maxdirections["Cover Right"] = 9;
  anim.excludedir["Cover Right"] = 7;
  anim.approach_types["Cover Crouch"] = [];
  anim.approach_types["Cover Crouch"]["stand"] = "crouch";
  anim.approach_types["Cover Crouch"]["crouch"] = "crouch";
  anim.approach_types["Conceal Crouch"] = anim.approach_types["Cover Crouch"];
  anim.approach_types["Cover Crouch Window"] = anim.approach_types["Cover Crouch"];
  anim.maxdirections["Cover Crouch"] = 6;
  anim.excludedir["Cover Crouch"] = -1;
  anim.maxdirections["Conceal Crouch"] = 6;
  anim.excludedir["Conceal Crouch"] = -1;
  anim.approach_types["Cover Stand"] = [];
  anim.approach_types["Cover Stand"]["stand"] = "stand";
  anim.approach_types["Cover Stand"]["crouch"] = "stand";
  anim.approach_types["Conceal Stand"] = anim.approach_types["Cover Stand"];
  anim.maxdirections["Cover Stand"] = 6;
  anim.excludedir["Cover Stand"] = -1;
  anim.maxdirections["Conceal Stand"] = 6;
  anim.excludedir["Conceal Stand"] = -1;
  anim.approach_types["Cover Prone"] = [];
  anim.approach_types["Cover Prone"]["stand"] = "exposed";
  anim.approach_types["Cover Prone"]["crouch"] = "exposed";
  anim.approach_types["Conceal Prone"] = anim.approach_types["Cover Prone"];
  anim.excludedir["Conceal Prone"] = -1;
  anim.approach_types["Path"] = [];
  anim.approach_types["Path"]["stand"] = "exposed";
  anim.approach_types["Path"]["crouch"] = "exposed_crouch";
  anim.approach_types["Guard"] = anim.approach_types["Path"];
  anim.approach_types["Ambush"] = anim.approach_types["Path"];
  anim.approach_types["Scripted"] = anim.approach_types["Path"];
  anim.approach_types["Exposed"] = anim.approach_types["Path"];
  anim.iscombatpathnode["Guard"] = 1;
  anim.iscombatpathnode["Ambush"] = 1;
  anim.iscombatpathnode["Exposed"] = 1;
  anim.iscombatscriptnode["Guard"] = 1;
  anim.iscombatscriptnode["Exposed"] = 1;

  for(var_2 = 1; var_2 <= 6; var_2++) {
    if(var_2 == 5) {
      continue;
    }
    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(isDefined(anim.archetypes["soldier"]["cover_trans"][var_4]) && isDefined(anim.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        anim.archetypes["soldier"]["cover_trans_dist"][var_4][var_2] = getmovedelta(anim.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
        anim.archetypes["soldier"]["cover_trans_angles"][var_4][var_2] = getangledelta(anim.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
      }

      if(isDefined(anim.archetypes["soldier"]["cover_exit"][var_4]) && isDefined(anim.archetypes["soldier"]["cover_exit"][var_4][var_2])) {
        if(animhasnotetrack(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move"))
          var_5 = getnotetracktimes(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")[0];
        else
          var_5 = 1;

        anim.archetypes["soldier"]["cover_exit_dist"][var_4][var_2] = getmovedelta(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, var_5);
        anim.archetypes["soldier"]["cover_exit_angles"][var_4][var_2] = getangledelta(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, 1);
      }
    }
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    anim.covertranslongestdist[var_4] = 0;

    for(var_2 = 1; var_2 <= 6; var_2++) {
      if(var_2 == 5 || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_4]) || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        continue;
      }
      var_6 = lengthsquared(anim.archetypes["soldier"]["cover_trans_dist"][var_4][var_2]);

      if(anim.covertranslongestdist[var_4] < var_6)
        anim.covertranslongestdist[var_4] = var_6;
    }

    anim.covertranslongestdist[var_4] = sqrt(anim.covertranslongestdist[var_4]);
  }

  anim.exposedtransition["exposed"] = 1;
  anim.exposedtransition["exposed_crouch"] = 1;
  anim.exposedtransition["exposed_cqb"] = 1;
  anim.exposedtransition["exposed_crouch_cqb"] = 1;
  anim.exposedtransition["exposed_ready_cqb"] = 1;
  anim.exposedtransition["exposed_ready"] = 1;
  anim.exposedtransition["heat"] = 1;

  if(!isDefined(anim.longestexposedapproachdist))
    anim.longestexposedapproachdist = 0;

  foreach(var_4, var_8 in anim.exposedtransition) {
    for(var_2 = 7; var_2 <= 9; var_2++) {
      if(isDefined(anim.archetypes["soldier"]["cover_trans"][var_4]) && isDefined(anim.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        anim.archetypes["soldier"]["cover_trans_dist"][var_4][var_2] = getmovedelta(anim.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
        anim.archetypes["soldier"]["cover_trans_angles"][var_4][var_2] = getangledelta(anim.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
      }

      if(isDefined(anim.archetypes["soldier"]["cover_exit"][var_4]) && isDefined(anim.archetypes["soldier"]["cover_exit"][var_4][var_2])) {
        var_5 = getnotetracktimes(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")[0];
        anim.archetypes["soldier"]["cover_exit_dist"][var_4][var_2] = getmovedelta(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, var_5);
        anim.archetypes["soldier"]["cover_exit_angles"][var_4][var_2] = getangledelta(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, 1);
      }
    }

    for(var_2 = 1; var_2 <= 9; var_2++) {
      if(!isDefined(anim.archetypes["soldier"]["cover_trans"][var_4]) || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        continue;
      }
      var_9 = length(anim.archetypes["soldier"]["cover_trans_dist"][var_4][var_2]);

      if(var_9 > anim.longestexposedapproachdist)
        anim.longestexposedapproachdist = var_9;
    }
  }

  anim.archetypes["soldier"]["cover_trans_split"]["left"][7] = 0.369369;
  anim.archetypes["soldier"]["cover_trans_split"]["left_crouch"][7] = 0.321321;
  anim.archetypes["soldier"]["cover_trans_split"]["left_crouch_cqb"][7] = 0.2002;
  anim.archetypes["soldier"]["cover_trans_split"]["left_cqb"][7] = 0.275275;
  anim.archetypes["soldier"]["cover_exit_split"]["left"][7] = 0.550551;
  anim.archetypes["soldier"]["cover_exit_split"]["left_crouch"][7] = 0.558559;
  anim.archetypes["soldier"]["cover_exit_split"]["left_cqb"][7] = 0.358358;
  anim.archetypes["soldier"]["cover_exit_split"]["left_crouch_cqb"][7] = 0.359359;
  anim.archetypes["soldier"]["cover_exit_split"]["heat_left"][7] = 0.42;
  anim.archetypes["soldier"]["cover_trans_split"]["left"][8] = 0.525526;
  anim.archetypes["soldier"]["cover_trans_split"]["left_crouch"][8] = 0.448448;
  anim.archetypes["soldier"]["cover_trans_split"]["left_crouch_cqb"][8] = 0.251251;
  anim.archetypes["soldier"]["cover_trans_split"]["left_cqb"][8] = 0.335335;
  anim.archetypes["soldier"]["cover_exit_split"]["left"][8] = 0.616617;
  anim.archetypes["soldier"]["cover_exit_split"]["left_crouch"][8] = 0.453453;
  anim.archetypes["soldier"]["cover_exit_split"]["left_crouch_cqb"][8] = 0.572573;
  anim.archetypes["soldier"]["cover_exit_split"]["left_cqb"][8] = 0.336336;
  anim.archetypes["soldier"]["cover_exit_split"]["heat_left"][8] = 0.42;
  anim.archetypes["soldier"]["cover_trans_split"]["right"][8] = 0.472472;
  anim.archetypes["soldier"]["cover_trans_split"]["right_crouch"][8] = 0.248248;
  anim.archetypes["soldier"]["cover_trans_split"]["right_cqb"][8] = 0.345345;
  anim.archetypes["soldier"]["cover_trans_split"]["right_crouch_cqb"][8] = 0.428428;
  anim.archetypes["soldier"]["cover_exit_split"]["right"][8] = 0.431431;
  anim.archetypes["soldier"]["cover_exit_split"]["right_crouch"][8] = 0.545546;
  anim.archetypes["soldier"]["cover_exit_split"]["right_cqb"][8] = 0.335335;
  anim.archetypes["soldier"]["cover_exit_split"]["right_crouch_cqb"][8] = 0.4004;
  anim.archetypes["soldier"]["cover_exit_split"]["heat_right"][8] = 0.4;
  anim.archetypes["soldier"]["cover_trans_split"]["right"][9] = 0.551552;
  anim.archetypes["soldier"]["cover_trans_split"]["right_crouch"][9] = 0.2002;
  anim.archetypes["soldier"]["cover_trans_split"]["right_cqb"][9] = 0.3003;
  anim.archetypes["soldier"]["cover_trans_split"]["right_crouch_cqb"][9] = 0.224224;
  anim.archetypes["soldier"]["cover_exit_split"]["right"][9] = 0.485485;
  anim.archetypes["soldier"]["cover_exit_split"]["right_crouch"][9] = 0.493493;
  anim.archetypes["soldier"]["cover_exit_split"]["right_cqb"][9] = 0.438438;
  anim.archetypes["soldier"]["cover_exit_split"]["right_crouch_cqb"][9] = 0.792793;
  anim.archetypes["soldier"]["cover_exit_split"]["heat_right"][9] = 0.4;
  anim.splitarrivalsleft = [];
  anim.splitarrivalsleft["left"] = 1;
  anim.splitarrivalsleft["left_crouch"] = 1;
  anim.splitarrivalsleft["left_crouch_cqb"] = 1;
  anim.splitarrivalsleft["left_cqb"] = 1;
  anim.splitexitsleft = [];
  anim.splitexitsleft["left"] = 1;
  anim.splitexitsleft["left_crouch"] = 1;
  anim.splitexitsleft["left_crouch_cqb"] = 1;
  anim.splitexitsleft["left_cqb"] = 1;
  anim.splitexitsleft["heat_left"] = 1;
  anim.splitarrivalsright = [];
  anim.splitarrivalsright["right"] = 1;
  anim.splitarrivalsright["right_crouch"] = 1;
  anim.splitarrivalsright["right_cqb"] = 1;
  anim.splitarrivalsright["right_crouch_cqb"] = 1;
  anim.splitexitsright = [];
  anim.splitexitsright["right"] = 1;
  anim.splitexitsright["right_crouch"] = 1;
  anim.splitexitsright["right_cqb"] = 1;
  anim.splitexitsright["right_crouch_cqb"] = 1;
  anim.splitexitsright["heat_right"] = 1;
  getsplittimes("soldier");
  anim.arrivalendstance["left"] = "stand";
  anim.arrivalendstance["left_cqb"] = "stand";
  anim.arrivalendstance["right"] = "stand";
  anim.arrivalendstance["right_cqb"] = "stand";
  anim.arrivalendstance["stand"] = "stand";
  anim.arrivalendstance["stand_saw"] = "stand";
  anim.arrivalendstance["exposed"] = "stand";
  anim.arrivalendstance["exposed_cqb"] = "stand";
  anim.arrivalendstance["heat"] = "stand";
  anim.arrivalendstance["left_crouch"] = "crouch";
  anim.arrivalendstance["left_crouch_cqb"] = "crouch";
  anim.arrivalendstance["right_crouch"] = "crouch";
  anim.arrivalendstance["right_crouch_cqb"] = "crouch";
  anim.arrivalendstance["crouch_saw"] = "crouch";
  anim.arrivalendstance["crouch"] = "crouch";
  anim.arrivalendstance["exposed_crouch"] = "crouch";
  anim.arrivalendstance["exposed_crouch_cqb"] = "crouch";
  anim.arrivalendstance["prone_saw"] = "prone";
  anim.arrivalendstance["exposed_ready"] = "stand";
  anim.arrivalendstance["exposed_ready_cqb"] = "stand";
  anim.requiredexitstance["Cover Stand"] = "stand";
  anim.requiredexitstance["Conceal Stand"] = "stand";
  anim.requiredexitstance["Cover Crouch"] = "crouch";
  anim.requiredexitstance["Conceal Crouch"] = "crouch";
}

getsplittimes(var_0) {
  getsplittimesside(var_0, 7, 8, 0, anim.splitarrivalsleft, anim.splitexitsleft);
  getsplittimesside(var_0, 8, 9, 1, anim.splitarrivalsright, anim.splitexitsright);
}

getsplittimesside(var_0, var_1, var_2, var_3, var_4, var_5) {
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

      continue;
    }
  }
}

getexitsplittime(var_0, var_1, var_2) {
  return anim.archetypes[var_0]["cover_exit_split"][var_1][var_2];
}

gettranssplittime(var_0, var_1, var_2) {
  return anim.archetypes[var_0]["cover_trans_split"][var_1][var_2];
}