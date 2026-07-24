/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\init_move_transitions.gsc
**************************************************/

_id_968D() {
  if(isDefined(anim._id_BC99)) {
    return;
  }
  anim._id_BC99 = 1;

  if(!isDefined(anim._id_4751)) {
    anim._id_4751 = [];
  }

  if(!isDefined(anim._id_4719)) {
    anim._id_4719 = [];
  }

  anim._id_B490 = [];
  anim._id_68CA = [];
  anim._id_126E7 = [];

  if(!isDefined(anim._id_4754)) {
    anim._id_4754 = [];
  }

  if(!isDefined(anim._id_4753)) {
    anim._id_4753 = [];
  }

  if(!isDefined(anim._id_471B)) {
    anim._id_471B = [];
  }

  anim._id_471D = [];
  anim._id_4755 = [];

  if(!isDefined(anim._id_4752)) {
    anim._id_4752 = [];
  }

  if(!isDefined(anim._id_471A)) {
    anim._id_471A = [];
  }

  anim._id_22E7 = [];
}

_id_98A0() {
  _id_968D();
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
  anim._id_20EB = [];
  anim._id_20EB["Cover Left"] = [];
  anim._id_20EB["Cover Left"]["stand"] = "left";
  anim._id_20EB["Cover Left"]["crouch"] = "left_crouch";
  anim._id_B490["Cover Left"] = 9;
  anim._id_68CA["Cover Left"] = 9;
  anim._id_20EB["Cover Right"] = [];
  anim._id_20EB["Cover Right"]["stand"] = "right";
  anim._id_20EB["Cover Right"]["crouch"] = "right_crouch";
  anim._id_B490["Cover Right"] = 9;
  anim._id_68CA["Cover Right"] = 7;
  anim._id_20EB["Cover Crouch"] = [];
  anim._id_20EB["Cover Crouch"]["stand"] = "crouch";
  anim._id_20EB["Cover Crouch"]["crouch"] = "crouch";
  anim._id_20EB["Conceal Crouch"] = anim._id_20EB["Cover Crouch"];
  anim._id_20EB["Cover Crouch Window"] = anim._id_20EB["Cover Crouch"];
  anim._id_B490["Cover Crouch"] = 6;
  anim._id_68CA["Cover Crouch"] = -1;
  anim._id_B490["Conceal Crouch"] = 6;
  anim._id_68CA["Conceal Crouch"] = -1;
  anim._id_20EB["Cover Stand"] = [];
  anim._id_20EB["Cover Stand"]["stand"] = "stand";
  anim._id_20EB["Cover Stand"]["crouch"] = "stand";
  anim._id_20EB["Conceal Stand"] = anim._id_20EB["Cover Stand"];
  anim._id_B490["Cover Stand"] = 6;
  anim._id_68CA["Cover Stand"] = -1;
  anim._id_B490["Conceal Stand"] = 6;
  anim._id_68CA["Conceal Stand"] = -1;
  anim._id_20EB["Cover Prone"] = [];
  anim._id_20EB["Cover Prone"]["stand"] = "exposed";
  anim._id_20EB["Cover Prone"]["crouch"] = "exposed";
  anim._id_20EB["Conceal Prone"] = anim._id_20EB["Cover Prone"];
  anim._id_68CA["Conceal Prone"] = -1;
  anim._id_20EB["Path"] = [];
  anim._id_20EB["Path"]["stand"] = "exposed";
  anim._id_20EB["Path"]["crouch"] = "exposed_crouch";
  anim._id_20EB["Guard"] = anim._id_20EB["Path"];
  anim._id_20EB["Ambush"] = anim._id_20EB["Path"];
  anim._id_20EB["Scripted"] = anim._id_20EB["Path"];
  anim._id_20EB["Exposed"] = anim._id_20EB["Path"];
  anim._id_9D8D["Guard"] = 1;
  anim._id_9D8D["Ambush"] = 1;
  anim._id_9D8D["Exposed"] = 1;
  anim._id_9D8E["Guard"] = 1;
  anim._id_9D8E["Exposed"] = 1;

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
        if(animhasnotetrack(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")) {
          var_5 = getnotetracktimes(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")[0];
        } else {
          var_5 = 1;
        }

        anim.archetypes["soldier"]["cover_exit_dist"][var_4][var_2] = getmovedelta(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, var_5);
        anim.archetypes["soldier"]["cover_exit_angles"][var_4][var_2] = getangledelta(anim.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, 1);
      }
    }
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    anim._id_4754[var_4] = 0;

    for(var_2 = 1; var_2 <= 6; var_2++) {
      if(var_2 == 5 || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_4]) || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        continue;
      }
      var_6 = lengthsquared(anim.archetypes["soldier"]["cover_trans_dist"][var_4][var_2]);

      if(anim._id_4754[var_4] < var_6) {
        anim._id_4754[var_4] = var_6;
      }
    }

    anim._id_4754[var_4] = sqrt(anim._id_4754[var_4]);
  }

  anim._id_6A1B["exposed"] = 1;
  anim._id_6A1B["exposed_crouch"] = 1;
  anim._id_6A1B["exposed_cqb"] = 1;
  anim._id_6A1B["exposed_crouch_cqb"] = 1;
  anim._id_6A1B["exposed_ready_cqb"] = 1;
  anim._id_6A1B["exposed_ready"] = 1;
  anim._id_6A1B["heat"] = 1;

  if(!isDefined(anim._id_AFE8)) {
    anim._id_AFE8 = 0;
  }

  foreach(var_4, var_8 in anim._id_6A1B) {
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

      if(var_9 > anim._id_AFE8) {
        anim._id_AFE8 = var_9;
      }
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
  anim._id_10A50 = [];
  anim._id_10A50["left"] = 1;
  anim._id_10A50["left_crouch"] = 1;
  anim._id_10A50["left_crouch_cqb"] = 1;
  anim._id_10A50["left_cqb"] = 1;
  anim._id_10A52 = [];
  anim._id_10A52["left"] = 1;
  anim._id_10A52["left_crouch"] = 1;
  anim._id_10A52["left_crouch_cqb"] = 1;
  anim._id_10A52["left_cqb"] = 1;
  anim._id_10A52["heat_left"] = 1;
  anim._id_10A51 = [];
  anim._id_10A51["right"] = 1;
  anim._id_10A51["right_crouch"] = 1;
  anim._id_10A51["right_cqb"] = 1;
  anim._id_10A51["right_crouch_cqb"] = 1;
  anim._id_10A53 = [];
  anim._id_10A53["right"] = 1;
  anim._id_10A53["right_crouch"] = 1;
  anim._id_10A53["right_cqb"] = 1;
  anim._id_10A53["right_crouch_cqb"] = 1;
  anim._id_10A53["heat_right"] = 1;
  _id_814D("soldier");
  anim._id_22E7["left"] = "stand";
  anim._id_22E7["left_cqb"] = "stand";
  anim._id_22E7["right"] = "stand";
  anim._id_22E7["right_cqb"] = "stand";
  anim._id_22E7["stand"] = "stand";
  anim._id_22E7["stand_saw"] = "stand";
  anim._id_22E7["exposed"] = "stand";
  anim._id_22E7["exposed_cqb"] = "stand";
  anim._id_22E7["heat"] = "stand";
  anim._id_22E7["left_crouch"] = "crouch";
  anim._id_22E7["left_crouch_cqb"] = "crouch";
  anim._id_22E7["right_crouch"] = "crouch";
  anim._id_22E7["right_crouch_cqb"] = "crouch";
  anim._id_22E7["crouch_saw"] = "crouch";
  anim._id_22E7["crouch"] = "crouch";
  anim._id_22E7["exposed_crouch"] = "crouch";
  anim._id_22E7["exposed_crouch_cqb"] = "crouch";
  anim._id_22E7["prone_saw"] = "prone";
  anim._id_22E7["exposed_ready"] = "stand";
  anim._id_22E7["exposed_ready_cqb"] = "stand";
  anim._id_E1B7["Cover Stand"] = "stand";
  anim._id_E1B7["Conceal Stand"] = "stand";
  anim._id_E1B7["Cover Crouch"] = "crouch";
  anim._id_E1B7["Conceal Crouch"] = "crouch";
}

_id_814D(var_0) {
  _id_814E(var_0, 7, 8, 0, anim._id_10A50, anim._id_10A52);
  _id_814E(var_0, 8, 9, 1, anim._id_10A51, anim._id_10A53);
}

_id_814E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  for(var_7 = var_1; var_7 <= var_2; var_7++) {
    if(!var_6) {
      foreach(var_10, var_9 in var_4) {
        if(isDefined(anim.archetypes[var_0]["cover_trans"]) && isDefined(anim.archetypes[var_0]["cover_trans"][var_10]) && isDefined(anim.archetypes[var_0]["cover_trans"][var_10][var_7])) {
          anim.archetypes[var_0]["cover_trans_predist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_10][var_7], 0, _id_81D6(var_0, var_10, var_7));
          anim.archetypes[var_0]["cover_trans_dist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_10][var_7], 0, 1) - anim.archetypes[var_0]["cover_trans_predist"][var_10][var_7];
          anim.archetypes[var_0]["cover_trans_angles"][var_10][var_7] = getangledelta(anim.archetypes[var_0]["cover_trans"][var_10][var_7], 0, 1);
        }
      }

      foreach(var_10, var_9 in var_5) {
        if(isDefined(anim.archetypes[var_0]["cover_exit"]) && isDefined(anim.archetypes[var_0]["cover_exit"][var_10]) && isDefined(anim.archetypes[var_0]["cover_exit"][var_10][var_7])) {
          anim.archetypes[var_0]["cover_exit_dist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_10][var_7], 0, _id_7EA4(var_0, var_10, var_7));
          anim.archetypes[var_0]["cover_exit_postdist"][var_10][var_7] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_10][var_7], 0, 1) - anim.archetypes[var_0]["cover_exit_dist"][var_10][var_7];
          anim.archetypes[var_0]["cover_exit_angles"][var_10][var_7] = getangledelta(anim.archetypes[var_0]["cover_exit"][var_10][var_7], 0, 1);
        }
      }

      continue;
    }
  }
}

_id_7EA4(var_0, var_1, var_2) {
  return anim.archetypes[var_0]["cover_exit_split"][var_1][var_2];
}

_id_81D6(var_0, var_1, var_2) {
  return anim.archetypes[var_0]["cover_trans_split"][var_1][var_2];
}