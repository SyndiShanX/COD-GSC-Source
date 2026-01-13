/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\init_move_transitions.gsc
**************************************************/

func_968D() {
  if(isDefined(level.var_BC99)) {
    return;
  }

  anim.var_BC99 = 1;
  if(!isDefined(level.var_4751)) {
    anim.var_4751 = [];
  }

  if(!isDefined(level.var_4719)) {
    anim.var_4719 = [];
  }

  anim.var_B490 = [];
  anim.var_68CA = [];
  anim.var_126E7 = [];
  if(!isDefined(level.var_4754)) {
    anim.var_4754 = [];
  }

  if(!isDefined(level.var_4753)) {
    anim.var_4753 = [];
  }

  if(!isDefined(level.var_471B)) {
    anim.var_471B = [];
  }

  anim.var_471D = [];
  anim.var_4755 = [];
  if(!isDefined(level.var_4752)) {
    anim.var_4752 = [];
  }

  if(!isDefined(level.var_471A)) {
    anim.var_471A = [];
  }

  anim.var_22E7 = [];
}

func_98A0() {
  func_968D();
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
  anim.var_20EB = [];
  level.var_20EB["Cover Left"] = [];
  level.var_20EB["Cover Left"]["stand"] = "left";
  level.var_20EB["Cover Left"]["crouch"] = "left_crouch";
  level.var_B490["Cover Left"] = 9;
  level.var_68CA["Cover Left"] = 9;
  level.var_20EB["Cover Right"] = [];
  level.var_20EB["Cover Right"]["stand"] = "right";
  level.var_20EB["Cover Right"]["crouch"] = "right_crouch";
  level.var_B490["Cover Right"] = 9;
  level.var_68CA["Cover Right"] = 7;
  level.var_20EB["Cover Crouch"] = [];
  level.var_20EB["Cover Crouch"]["stand"] = "crouch";
  level.var_20EB["Cover Crouch"]["crouch"] = "crouch";
  level.var_20EB["Conceal Crouch"] = level.var_20EB["Cover Crouch"];
  level.var_20EB["Cover Crouch Window"] = level.var_20EB["Cover Crouch"];
  level.var_B490["Cover Crouch"] = 6;
  level.var_68CA["Cover Crouch"] = -1;
  level.var_B490["Conceal Crouch"] = 6;
  level.var_68CA["Conceal Crouch"] = -1;
  level.var_20EB["Cover Stand"] = [];
  level.var_20EB["Cover Stand"]["stand"] = "stand";
  level.var_20EB["Cover Stand"]["crouch"] = "stand";
  level.var_20EB["Conceal Stand"] = level.var_20EB["Cover Stand"];
  level.var_B490["Cover Stand"] = 6;
  level.var_68CA["Cover Stand"] = -1;
  level.var_B490["Conceal Stand"] = 6;
  level.var_68CA["Conceal Stand"] = -1;
  level.var_20EB["Cover Prone"] = [];
  level.var_20EB["Cover Prone"]["stand"] = "exposed";
  level.var_20EB["Cover Prone"]["crouch"] = "exposed";
  level.var_20EB["Conceal Prone"] = level.var_20EB["Cover Prone"];
  level.var_68CA["Conceal Prone"] = -1;
  level.var_20EB["Path"] = [];
  level.var_20EB["Path"]["stand"] = "exposed";
  level.var_20EB["Path"]["crouch"] = "exposed_crouch";
  level.var_20EB["Guard"] = level.var_20EB["Path"];
  level.var_20EB["Ambush"] = level.var_20EB["Path"];
  level.var_20EB["Scripted"] = level.var_20EB["Path"];
  level.var_20EB["Exposed"] = level.var_20EB["Path"];
  level.var_9D8D["Guard"] = 1;
  level.var_9D8D["Ambush"] = 1;
  level.var_9D8D["Exposed"] = 1;
  level.var_9D8E["Guard"] = 1;
  level.var_9D8E["Exposed"] = 1;
  for(var_2 = 1; var_2 <= 6; var_2++) {
    if(var_2 == 5) {
      continue;
    }

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];
      if(isDefined(level.archetypes["soldier"]["cover_trans"][var_4]) && isDefined(level.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        level.archetypes["soldier"]["cover_trans_dist"][var_4][var_2] = getmovedelta(level.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
        level.archetypes["soldier"]["cover_trans_angles"][var_4][var_2] = getangledelta(level.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
      }

      if(isDefined(level.archetypes["soldier"]["cover_exit"][var_4]) && isDefined(level.archetypes["soldier"]["cover_exit"][var_4][var_2])) {
        if(animhasnotetrack(level.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")) {
          var_5 = getnotetracktimes(level.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")[0];
        } else {
          var_5 = 1;
        }

        level.archetypes["soldier"]["cover_exit_dist"][var_4][var_2] = getmovedelta(level.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, var_5);
        level.archetypes["soldier"]["cover_exit_angles"][var_4][var_2] = getangledelta(level.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, 1);
      }
    }
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    level.var_4754[var_4] = 0;
    for(var_2 = 1; var_2 <= 6; var_2++) {
      if(var_2 == 5 || !isDefined(level.archetypes["soldier"]["cover_trans"][var_4]) || !isDefined(level.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        continue;
      }

      var_6 = lengthsquared(level.archetypes["soldier"]["cover_trans_dist"][var_4][var_2]);
      if(level.var_4754[var_4] < var_6) {
        level.var_4754[var_4] = var_6;
      }
    }

    level.var_4754[var_4] = sqrt(level.var_4754[var_4]);
  }

  level.var_6A1B["exposed"] = 1;
  level.var_6A1B["exposed_crouch"] = 1;
  level.var_6A1B["exposed_cqb"] = 1;
  level.var_6A1B["exposed_crouch_cqb"] = 1;
  level.var_6A1B["exposed_ready_cqb"] = 1;
  level.var_6A1B["exposed_ready"] = 1;
  level.var_6A1B["heat"] = 1;
  if(!isDefined(level.var_AFE8)) {
    anim.var_AFE8 = 0;
  }

  foreach(var_4, var_8 in level.var_6A1B) {
    for(var_2 = 7; var_2 <= 9; var_2++) {
      if(isDefined(level.archetypes["soldier"]["cover_trans"][var_4]) && isDefined(level.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        level.archetypes["soldier"]["cover_trans_dist"][var_4][var_2] = getmovedelta(level.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
        level.archetypes["soldier"]["cover_trans_angles"][var_4][var_2] = getangledelta(level.archetypes["soldier"]["cover_trans"][var_4][var_2], 0, 1);
      }

      if(isDefined(level.archetypes["soldier"]["cover_exit"][var_4]) && isDefined(level.archetypes["soldier"]["cover_exit"][var_4][var_2])) {
        var_5 = getnotetracktimes(level.archetypes["soldier"]["cover_exit"][var_4][var_2], "code_move")[0];
        level.archetypes["soldier"]["cover_exit_dist"][var_4][var_2] = getmovedelta(level.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, var_5);
        level.archetypes["soldier"]["cover_exit_angles"][var_4][var_2] = getangledelta(level.archetypes["soldier"]["cover_exit"][var_4][var_2], 0, 1);
      }
    }

    for(var_2 = 1; var_2 <= 9; var_2++) {
      if(!isDefined(level.archetypes["soldier"]["cover_trans"][var_4]) || !isDefined(level.archetypes["soldier"]["cover_trans"][var_4][var_2])) {
        continue;
      }

      var_9 = length(level.archetypes["soldier"]["cover_trans_dist"][var_4][var_2]);
      if(var_9 > level.var_AFE8) {
        anim.var_AFE8 = var_9;
      }
    }
  }

  level.archetypes["soldier"]["cover_trans_split"]["left"][7] = 0.369369;
  level.archetypes["soldier"]["cover_trans_split"]["left_crouch"][7] = 0.321321;
  level.archetypes["soldier"]["cover_trans_split"]["left_crouch_cqb"][7] = 0.2002;
  level.archetypes["soldier"]["cover_trans_split"]["left_cqb"][7] = 0.275275;
  level.archetypes["soldier"]["cover_exit_split"]["left"][7] = 0.550551;
  level.archetypes["soldier"]["cover_exit_split"]["left_crouch"][7] = 0.558559;
  level.archetypes["soldier"]["cover_exit_split"]["left_cqb"][7] = 0.358358;
  level.archetypes["soldier"]["cover_exit_split"]["left_crouch_cqb"][7] = 0.359359;
  level.archetypes["soldier"]["cover_exit_split"]["heat_left"][7] = 0.42;
  level.archetypes["soldier"]["cover_trans_split"]["left"][8] = 0.525526;
  level.archetypes["soldier"]["cover_trans_split"]["left_crouch"][8] = 0.448448;
  level.archetypes["soldier"]["cover_trans_split"]["left_crouch_cqb"][8] = 0.251251;
  level.archetypes["soldier"]["cover_trans_split"]["left_cqb"][8] = 0.335335;
  level.archetypes["soldier"]["cover_exit_split"]["left"][8] = 0.616617;
  level.archetypes["soldier"]["cover_exit_split"]["left_crouch"][8] = 0.453453;
  level.archetypes["soldier"]["cover_exit_split"]["left_crouch_cqb"][8] = 0.572573;
  level.archetypes["soldier"]["cover_exit_split"]["left_cqb"][8] = 0.336336;
  level.archetypes["soldier"]["cover_exit_split"]["heat_left"][8] = 0.42;
  level.archetypes["soldier"]["cover_trans_split"]["right"][8] = 0.472472;
  level.archetypes["soldier"]["cover_trans_split"]["right_crouch"][8] = 0.248248;
  level.archetypes["soldier"]["cover_trans_split"]["right_cqb"][8] = 0.345345;
  level.archetypes["soldier"]["cover_trans_split"]["right_crouch_cqb"][8] = 0.428428;
  level.archetypes["soldier"]["cover_exit_split"]["right"][8] = 0.431431;
  level.archetypes["soldier"]["cover_exit_split"]["right_crouch"][8] = 0.545546;
  level.archetypes["soldier"]["cover_exit_split"]["right_cqb"][8] = 0.335335;
  level.archetypes["soldier"]["cover_exit_split"]["right_crouch_cqb"][8] = 0.4004;
  level.archetypes["soldier"]["cover_exit_split"]["heat_right"][8] = 0.4;
  level.archetypes["soldier"]["cover_trans_split"]["right"][9] = 0.551552;
  level.archetypes["soldier"]["cover_trans_split"]["right_crouch"][9] = 0.2002;
  level.archetypes["soldier"]["cover_trans_split"]["right_cqb"][9] = 0.3003;
  level.archetypes["soldier"]["cover_trans_split"]["right_crouch_cqb"][9] = 0.224224;
  level.archetypes["soldier"]["cover_exit_split"]["right"][9] = 0.485485;
  level.archetypes["soldier"]["cover_exit_split"]["right_crouch"][9] = 0.493493;
  level.archetypes["soldier"]["cover_exit_split"]["right_cqb"][9] = 0.438438;
  level.archetypes["soldier"]["cover_exit_split"]["right_crouch_cqb"][9] = 0.792793;
  level.archetypes["soldier"]["cover_exit_split"]["heat_right"][9] = 0.4;
  anim.var_10A50 = [];
  level.var_10A50["left"] = 1;
  level.var_10A50["left_crouch"] = 1;
  level.var_10A50["left_crouch_cqb"] = 1;
  level.var_10A50["left_cqb"] = 1;
  anim.var_10A52 = [];
  level.var_10A52["left"] = 1;
  level.var_10A52["left_crouch"] = 1;
  level.var_10A52["left_crouch_cqb"] = 1;
  level.var_10A52["left_cqb"] = 1;
  level.var_10A52["heat_left"] = 1;
  anim.var_10A51 = [];
  level.var_10A51["right"] = 1;
  level.var_10A51["right_crouch"] = 1;
  level.var_10A51["right_cqb"] = 1;
  level.var_10A51["right_crouch_cqb"] = 1;
  anim.var_10A53 = [];
  level.var_10A53["right"] = 1;
  level.var_10A53["right_crouch"] = 1;
  level.var_10A53["right_cqb"] = 1;
  level.var_10A53["right_crouch_cqb"] = 1;
  level.var_10A53["heat_right"] = 1;
  _meth_814D("soldier");
  level.var_22E7["left"] = "stand";
  level.var_22E7["left_cqb"] = "stand";
  level.var_22E7["right"] = "stand";
  level.var_22E7["right_cqb"] = "stand";
  level.var_22E7["stand"] = "stand";
  level.var_22E7["stand_saw"] = "stand";
  level.var_22E7["exposed"] = "stand";
  level.var_22E7["exposed_cqb"] = "stand";
  level.var_22E7["heat"] = "stand";
  level.var_22E7["left_crouch"] = "crouch";
  level.var_22E7["left_crouch_cqb"] = "crouch";
  level.var_22E7["right_crouch"] = "crouch";
  level.var_22E7["right_crouch_cqb"] = "crouch";
  level.var_22E7["crouch_saw"] = "crouch";
  level.var_22E7["crouch"] = "crouch";
  level.var_22E7["exposed_crouch"] = "crouch";
  level.var_22E7["exposed_crouch_cqb"] = "crouch";
  level.var_22E7["prone_saw"] = "prone";
  level.var_22E7["exposed_ready"] = "stand";
  level.var_22E7["exposed_ready_cqb"] = "stand";
  level.var_E1B7["Cover Stand"] = "stand";
  level.var_E1B7["Conceal Stand"] = "stand";
  level.var_E1B7["Cover Crouch"] = "crouch";
  level.var_E1B7["Conceal Crouch"] = "crouch";
}

_meth_814D(var_0) {
  _meth_814E(var_0, 7, 8, 0, level.var_10A50, level.var_10A52);
  _meth_814E(var_0, 8, 9, 1, level.var_10A51, level.var_10A53);
}

_meth_814E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;
  for(var_7 = var_1; var_7 <= var_2; var_7++) {
    if(!var_6) {
      foreach(var_0A, var_9 in var_4) {
        if(isDefined(level.archetypes[var_0]["cover_trans"]) && isDefined(level.archetypes[var_0]["cover_trans"][var_0A]) && isDefined(level.archetypes[var_0]["cover_trans"][var_0A][var_7])) {
          level.archetypes[var_0]["cover_trans_predist"][var_0A][var_7] = getmovedelta(level.archetypes[var_0]["cover_trans"][var_0A][var_7], 0, _meth_81D6(var_0, var_0A, var_7));
          level.archetypes[var_0]["cover_trans_dist"][var_0A][var_7] = getmovedelta(level.archetypes[var_0]["cover_trans"][var_0A][var_7], 0, 1) - level.archetypes[var_0]["cover_trans_predist"][var_0A][var_7];
          level.archetypes[var_0]["cover_trans_angles"][var_0A][var_7] = getangledelta(level.archetypes[var_0]["cover_trans"][var_0A][var_7], 0, 1);
        }
      }

      foreach(var_0A, var_9 in var_5) {
        if(isDefined(level.archetypes[var_0]["cover_exit"]) && isDefined(level.archetypes[var_0]["cover_exit"][var_0A]) && isDefined(level.archetypes[var_0]["cover_exit"][var_0A][var_7])) {
          level.archetypes[var_0]["cover_exit_dist"][var_0A][var_7] = getmovedelta(level.archetypes[var_0]["cover_exit"][var_0A][var_7], 0, func_7EA4(var_0, var_0A, var_7));
          level.archetypes[var_0]["cover_exit_postdist"][var_0A][var_7] = getmovedelta(level.archetypes[var_0]["cover_exit"][var_0A][var_7], 0, 1) - level.archetypes[var_0]["cover_exit_dist"][var_0A][var_7];
          level.archetypes[var_0]["cover_exit_angles"][var_0A][var_7] = getangledelta(level.archetypes[var_0]["cover_exit"][var_0A][var_7], 0, 1);
        }
      }

      continue;
    }
  }
}

func_7EA4(var_0, var_1, var_2) {
  return level.archetypes[var_0]["cover_exit_split"][var_1][var_2];
}

_meth_81D6(var_0, var_1, var_2) {
  return level.archetypes[var_0]["cover_trans_split"][var_1][var_2];
}