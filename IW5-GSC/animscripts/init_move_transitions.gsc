/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\init_move_transitions.gsc
*************************************************/

_id_2082() {
  if(isDefined(anim._id_2083)) {
    return;
  }
  anim._id_2083 = 1;

  if(!isDefined(anim.covertrans)) {
    anim.covertrans = [];
  }
  if(!isDefined(anim.coverexit)) {
    anim.coverexit = [];
  }
  anim.maxdirections = [];
  anim.excludedir = [];
  anim._id_2084 = [];

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
  anim._id_2085 = [];
  anim._id_2086 = [];
  anim.arrivalendstance = [];
}

#using_animtree("generic_human");

_id_2087() {
  _id_2082();
  level.newarrivals = 1;
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
  anim.covertrans["right"][1] = % corner_standr_trans_in_1;
  anim.covertrans["right"][2] = % corner_standr_trans_in_2;
  anim.covertrans["right"][3] = % corner_standr_trans_in_3;
  anim.covertrans["right"][4] = % corner_standr_trans_in_4;
  anim.covertrans["right"][6] = % corner_standr_trans_in_6;
  anim.covertrans["right"][8] = % corner_standr_trans_in_8;
  anim.covertrans["right"][9] = % corner_standr_trans_in_9;
  anim.covertrans["right_crouch"][1] = % cornercrr_trans_in_ml;
  anim.covertrans["right_crouch"][2] = % cornercrr_trans_in_m;
  anim.covertrans["right_crouch"][3] = % cornercrr_trans_in_mr;
  anim.covertrans["right_crouch"][4] = % cornercrr_trans_in_l;
  anim.covertrans["right_crouch"][6] = % cornercrr_trans_in_r;
  anim.covertrans["right_crouch"][8] = % cornercrr_trans_in_f;
  anim.covertrans["right_crouch"][9] = % cornercrr_trans_in_mf;
  anim.covertrans["right_cqb"][1] = % corner_standr_trans_cqb_in_1;
  anim.covertrans["right_cqb"][2] = % corner_standr_trans_cqb_in_2;
  anim.covertrans["right_cqb"][3] = % corner_standr_trans_cqb_in_3;
  anim.covertrans["right_cqb"][4] = % corner_standr_trans_cqb_in_4;
  anim.covertrans["right_cqb"][6] = % corner_standr_trans_cqb_in_6;
  anim.covertrans["right_cqb"][8] = % corner_standr_trans_cqb_in_8;
  anim.covertrans["right_cqb"][9] = % corner_standr_trans_cqb_in_9;
  anim.covertrans["right_crouch_cqb"][1] = % cornercrr_cqb_trans_in_1;
  anim.covertrans["right_crouch_cqb"][2] = % cornercrr_cqb_trans_in_2;
  anim.covertrans["right_crouch_cqb"][3] = % cornercrr_cqb_trans_in_3;
  anim.covertrans["right_crouch_cqb"][4] = % cornercrr_cqb_trans_in_4;
  anim.covertrans["right_crouch_cqb"][6] = % cornercrr_cqb_trans_in_6;
  anim.covertrans["right_crouch_cqb"][8] = % cornercrr_cqb_trans_in_8;
  anim.covertrans["right_crouch_cqb"][9] = % cornercrr_cqb_trans_in_9;
  anim.covertrans["left"][1] = % corner_standl_trans_in_1;
  anim.covertrans["left"][2] = % corner_standl_trans_in_2;
  anim.covertrans["left"][3] = % corner_standl_trans_in_3;
  anim.covertrans["left"][4] = % corner_standl_trans_in_4;
  anim.covertrans["left"][6] = % corner_standl_trans_in_6;
  anim.covertrans["left"][7] = % corner_standl_trans_in_7;
  anim.covertrans["left"][8] = % corner_standl_trans_in_8;
  anim.covertrans["left_crouch"][1] = % cornercrl_trans_in_ml;
  anim.covertrans["left_crouch"][2] = % cornercrl_trans_in_m;
  anim.covertrans["left_crouch"][3] = % cornercrl_trans_in_mr;
  anim.covertrans["left_crouch"][4] = % cornercrl_trans_in_l;
  anim.covertrans["left_crouch"][6] = % cornercrl_trans_in_r;
  anim.covertrans["left_crouch"][7] = % cornercrl_trans_in_mf;
  anim.covertrans["left_crouch"][8] = % cornercrl_trans_in_f;
  anim.covertrans["left_cqb"][1] = % corner_standl_trans_cqb_in_1;
  anim.covertrans["left_cqb"][2] = % corner_standl_trans_cqb_in_2;
  anim.covertrans["left_cqb"][3] = % corner_standl_trans_cqb_in_3;
  anim.covertrans["left_cqb"][4] = % corner_standl_trans_cqb_in_4;
  anim.covertrans["left_cqb"][6] = % corner_standl_trans_cqb_in_6;
  anim.covertrans["left_cqb"][7] = % corner_standl_trans_cqb_in_7;
  anim.covertrans["left_cqb"][8] = % corner_standl_trans_cqb_in_8;
  anim.covertrans["left_crouch_cqb"][1] = % cornercrl_cqb_trans_in_1;
  anim.covertrans["left_crouch_cqb"][2] = % cornercrl_cqb_trans_in_2;
  anim.covertrans["left_crouch_cqb"][3] = % cornercrl_cqb_trans_in_3;
  anim.covertrans["left_crouch_cqb"][4] = % cornercrl_cqb_trans_in_4;
  anim.covertrans["left_crouch_cqb"][6] = % cornercrl_cqb_trans_in_6;
  anim.covertrans["left_crouch_cqb"][7] = % cornercrl_cqb_trans_in_7;
  anim.covertrans["left_crouch_cqb"][8] = % cornercrl_cqb_trans_in_8;
  anim.covertrans["crouch"][1] = % covercrouch_run_in_ml;
  anim.covertrans["crouch"][2] = % covercrouch_run_in_m;
  anim.covertrans["crouch"][3] = % covercrouch_run_in_mr;
  anim.covertrans["crouch"][4] = % covercrouch_run_in_l;
  anim.covertrans["crouch"][6] = % covercrouch_run_in_r;
  anim.covertrans["stand"][1] = % coverstand_trans_in_ml;
  anim.covertrans["stand"][2] = % coverstand_trans_in_m;
  anim.covertrans["stand"][3] = % coverstand_trans_in_mr;
  anim.covertrans["stand"][4] = % coverstand_trans_in_l;
  anim.covertrans["stand"][6] = % coverstand_trans_in_r;
  anim.covertrans["stand_saw"][1] = % saw_gunner_runin_ml;
  anim.covertrans["stand_saw"][2] = % saw_gunner_runin_m;
  anim.covertrans["stand_saw"][3] = % saw_gunner_runin_mr;
  anim.covertrans["stand_saw"][4] = % saw_gunner_runin_l;
  anim.covertrans["stand_saw"][6] = % saw_gunner_runin_r;
  anim.covertrans["crouch_saw"][1] = % saw_gunner_lowwall_runin_ml;
  anim.covertrans["crouch_saw"][2] = % saw_gunner_lowwall_runin_m;
  anim.covertrans["crouch_saw"][3] = % saw_gunner_lowwall_runin_mr;
  anim.covertrans["crouch_saw"][4] = % saw_gunner_lowwall_runin_l;
  anim.covertrans["crouch_saw"][6] = % saw_gunner_lowwall_runin_r;
  anim.covertrans["prone_saw"][1] = % saw_gunner_prone_runin_ml;
  anim.covertrans["prone_saw"][2] = % saw_gunner_prone_runin_m;
  anim.covertrans["prone_saw"][3] = % saw_gunner_prone_runin_mr;
  anim.covertrans["exposed"] = [];
  anim.covertrans["exposed"][1] = % cqb_stop_1;
  anim.covertrans["exposed"][2] = % run_2_stand_f_6;
  anim.covertrans["exposed"][3] = % cqb_stop_3;
  anim.covertrans["exposed"][4] = % run_2_stand_90l;
  anim.covertrans["exposed"][6] = % run_2_stand_90r;
  anim.covertrans["exposed"][7] = % cqb_stop_7;
  anim.covertrans["exposed"][8] = % run_2_stand_180l;
  anim.covertrans["exposed"][9] = % cqb_stop_9;
  anim.covertrans["exposed_crouch"] = [];
  anim.covertrans["exposed_crouch"][1] = % cqb_crouch_stop_1;
  anim.covertrans["exposed_crouch"][2] = % run_2_crouch_f;
  anim.covertrans["exposed_crouch"][3] = % cqb_crouch_stop_3;
  anim.covertrans["exposed_crouch"][4] = % run_2_crouch_90l;
  anim.covertrans["exposed_crouch"][6] = % run_2_crouch_90r;
  anim.covertrans["exposed_crouch"][7] = % cqb_crouch_stop_7;
  anim.covertrans["exposed_crouch"][8] = % run_2_crouch_180l;
  anim.covertrans["exposed_crouch"][9] = % cqb_crouch_stop_9;
  anim.covertrans["exposed_cqb"] = [];
  anim.covertrans["exposed_cqb"][1] = % cqb_stop_1;
  anim.covertrans["exposed_cqb"][2] = % cqb_stop_2;
  anim.covertrans["exposed_cqb"][3] = % cqb_stop_3;
  anim.covertrans["exposed_cqb"][4] = % cqb_stop_4;
  anim.covertrans["exposed_cqb"][6] = % cqb_stop_6;
  anim.covertrans["exposed_cqb"][7] = % cqb_stop_7;
  anim.covertrans["exposed_cqb"][8] = % cqb_stop_8;
  anim.covertrans["exposed_cqb"][9] = % cqb_stop_9;
  anim.covertrans["exposed_crouch_cqb"] = [];
  anim.covertrans["exposed_crouch_cqb"][1] = % cqb_crouch_stop_1;
  anim.covertrans["exposed_crouch_cqb"][2] = % cqb_crouch_stop_2;
  anim.covertrans["exposed_crouch_cqb"][3] = % cqb_crouch_stop_3;
  anim.covertrans["exposed_crouch_cqb"][4] = % cqb_crouch_stop_4;
  anim.covertrans["exposed_crouch_cqb"][6] = % cqb_crouch_stop_6;
  anim.covertrans["exposed_crouch_cqb"][7] = % cqb_crouch_stop_7;
  anim.covertrans["exposed_crouch_cqb"][8] = % cqb_crouch_stop_8;
  anim.covertrans["exposed_crouch_cqb"][9] = % cqb_crouch_stop_9;
  anim.covertrans["heat"] = [];
  anim.covertrans["heat"][1] = % heat_approach_1;
  anim.covertrans["heat"][2] = % heat_approach_2;
  anim.covertrans["heat"][3] = % heat_approach_3;
  anim.covertrans["heat"][4] = % heat_approach_4;
  anim.covertrans["heat"][6] = % heat_approach_6;
  anim.covertrans["heat"][8] = % heat_approach_8;
  anim.covertrans["heat_left"] = [];
  anim.covertrans["heat_right"] = [];
  anim._id_2088 = [];
  anim._id_2088["right"] = % corner_standr_trans_b_2_alert;
  anim._id_2088["right_crouch"] = % cornercrr_trans_b_2_alert;
  anim._id_2088["left"] = % corner_standl_trans_b_2_alert_v2;
  anim._id_2088["left_crouch"] = % cornercrl_trans_b_2_alert;
  anim._id_2088["crouch"] = % covercrouch_aim_2_hide;
  anim._id_2088["stand"] = % coverstand_aim_2_hide;
  anim._id_2089 = [];
  anim._id_208A = [];

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = var_0[var_2];
    anim._id_2089[var_3] = getmovedelta(anim._id_2088[var_3], 0, 1);
    anim._id_208A[var_3] = getangledelta(anim._id_2088[var_3], 0, 1);
  }

  anim._id_208A["right"] = anim._id_208A["right"] + 90;
  anim._id_208A["right_crouch"] = anim._id_208A["right_crouch"] + 90;
  anim._id_208A["left"] = anim._id_208A["left"] - 90;
  anim._id_208A["left_crouch"] = anim._id_208A["left_crouch"] - 90;
  anim.covertrans["wall_over_96"][1] = % traverse90_in_ml;
  anim.covertrans["wall_over_96"][2] = % traverse90_in_m;
  anim.covertrans["wall_over_96"][3] = % traverse90_in_mr;
  anim._id_2084["wall_over_96"]["height"] = 96;
  anim.covertrans["wall_over_40"][1] = % traverse_window_m_2_run;
  anim.covertrans["wall_over_40"][2] = % traverse_window_m_2_run;
  anim.covertrans["wall_over_40"][3] = % traverse_window_m_2_run;
  anim.coverexit["right"][1] = % corner_standr_trans_out_1;
  anim.coverexit["right"][2] = % corner_standr_trans_out_2;
  anim.coverexit["right"][3] = % corner_standr_trans_out_3;
  anim.coverexit["right"][4] = % corner_standr_trans_out_4;
  anim.coverexit["right"][6] = % corner_standr_trans_out_6;
  anim.coverexit["right"][8] = % corner_standr_trans_out_8;
  anim.coverexit["right"][9] = % corner_standr_trans_out_9;
  anim.coverexit["right_crouch"][1] = % cornercrr_trans_out_ml;
  anim.coverexit["right_crouch"][2] = % cornercrr_trans_out_m;
  anim.coverexit["right_crouch"][3] = % cornercrr_trans_out_mr;
  anim.coverexit["right_crouch"][4] = % cornercrr_trans_out_l;
  anim.coverexit["right_crouch"][6] = % cornercrr_trans_out_r;
  anim.coverexit["right_crouch"][8] = % cornercrr_trans_out_f;
  anim.coverexit["right_crouch"][9] = % cornercrr_trans_out_mf;
  anim.coverexit["right_cqb"][1] = % corner_standr_trans_cqb_out_1;
  anim.coverexit["right_cqb"][2] = % corner_standr_trans_cqb_out_2;
  anim.coverexit["right_cqb"][3] = % corner_standr_trans_cqb_out_3;
  anim.coverexit["right_cqb"][4] = % corner_standr_trans_cqb_out_4;
  anim.coverexit["right_cqb"][6] = % corner_standr_trans_cqb_out_6;
  anim.coverexit["right_cqb"][8] = % corner_standr_trans_cqb_out_8;
  anim.coverexit["right_cqb"][9] = % corner_standr_trans_cqb_out_9;
  anim.coverexit["right_crouch_cqb"][1] = % cornercrr_cqb_trans_out_1;
  anim.coverexit["right_crouch_cqb"][2] = % cornercrr_cqb_trans_out_2;
  anim.coverexit["right_crouch_cqb"][3] = % cornercrr_cqb_trans_out_3;
  anim.coverexit["right_crouch_cqb"][4] = % cornercrr_cqb_trans_out_4;
  anim.coverexit["right_crouch_cqb"][6] = % cornercrr_cqb_trans_out_6;
  anim.coverexit["right_crouch_cqb"][8] = % cornercrr_cqb_trans_out_8;
  anim.coverexit["right_crouch_cqb"][9] = % cornercrr_cqb_trans_out_9;
  anim.coverexit["left"][1] = % corner_standl_trans_out_1;
  anim.coverexit["left"][2] = % corner_standl_trans_out_2;
  anim.coverexit["left"][3] = % corner_standl_trans_out_3;
  anim.coverexit["left"][4] = % corner_standl_trans_out_4;
  anim.coverexit["left"][6] = % corner_standl_trans_out_6;
  anim.coverexit["left"][7] = % corner_standl_trans_out_7;
  anim.coverexit["left"][8] = % corner_standl_trans_out_8;
  anim.coverexit["left_crouch"][1] = % cornercrl_trans_out_ml;
  anim.coverexit["left_crouch"][2] = % cornercrl_trans_out_m;
  anim.coverexit["left_crouch"][3] = % cornercrl_trans_out_mr;
  anim.coverexit["left_crouch"][4] = % cornercrl_trans_out_l;
  anim.coverexit["left_crouch"][6] = % cornercrl_trans_out_r;
  anim.coverexit["left_crouch"][7] = % cornercrl_trans_out_mf;
  anim.coverexit["left_crouch"][8] = % cornercrl_trans_out_f;
  anim.coverexit["left_cqb"][1] = % corner_standl_trans_cqb_out_1;
  anim.coverexit["left_cqb"][2] = % corner_standl_trans_cqb_out_2;
  anim.coverexit["left_cqb"][3] = % corner_standl_trans_cqb_out_3;
  anim.coverexit["left_cqb"][4] = % corner_standl_trans_cqb_out_4;
  anim.coverexit["left_cqb"][6] = % corner_standl_trans_cqb_out_6;
  anim.coverexit["left_cqb"][7] = % corner_standl_trans_cqb_out_7;
  anim.coverexit["left_cqb"][8] = % corner_standl_trans_cqb_out_8;
  anim.coverexit["left_crouch_cqb"][1] = % cornercrl_cqb_trans_out_1;
  anim.coverexit["left_crouch_cqb"][2] = % cornercrl_cqb_trans_out_2;
  anim.coverexit["left_crouch_cqb"][3] = % cornercrl_cqb_trans_out_3;
  anim.coverexit["left_crouch_cqb"][4] = % cornercrl_cqb_trans_out_4;
  anim.coverexit["left_crouch_cqb"][6] = % cornercrl_cqb_trans_out_6;
  anim.coverexit["left_crouch_cqb"][7] = % cornercrl_cqb_trans_out_7;
  anim.coverexit["left_crouch_cqb"][8] = % cornercrl_cqb_trans_out_8;
  anim.coverexit["crouch"][1] = % covercrouch_run_out_ml;
  anim.coverexit["crouch"][2] = % covercrouch_run_out_m;
  anim.coverexit["crouch"][3] = % covercrouch_run_out_mr;
  anim.coverexit["crouch"][4] = % covercrouch_run_out_l;
  anim.coverexit["crouch"][6] = % covercrouch_run_out_r;
  anim.coverexit["stand"][1] = % coverstand_trans_out_ml;
  anim.coverexit["stand"][2] = % coverstand_trans_out_m;
  anim.coverexit["stand"][3] = % coverstand_trans_out_mr;
  anim.coverexit["stand"][4] = % coverstand_trans_out_l;
  anim.coverexit["stand"][6] = % coverstand_trans_out_r;
  anim.coverexit["stand_saw"][1] = % saw_gunner_runout_ml;
  anim.coverexit["stand_saw"][2] = % saw_gunner_runout_m;
  anim.coverexit["stand_saw"][3] = % saw_gunner_runout_mr;
  anim.coverexit["stand_saw"][4] = % saw_gunner_runout_l;
  anim.coverexit["stand_saw"][6] = % saw_gunner_runout_r;
  anim.coverexit["prone_saw"][2] = % saw_gunner_prone_runout_m;
  anim.coverexit["prone_saw"][4] = % saw_gunner_prone_runout_l;
  anim.coverexit["prone_saw"][6] = % saw_gunner_prone_runout_r;
  anim.coverexit["prone_saw"][8] = % saw_gunner_prone_runout_f;
  anim.coverexit["crouch_saw"][1] = % saw_gunner_lowwall_runout_ml;
  anim.coverexit["crouch_saw"][2] = % saw_gunner_lowwall_runout_m;
  anim.coverexit["crouch_saw"][3] = % saw_gunner_lowwall_runout_mr;
  anim.coverexit["crouch_saw"][4] = % saw_gunner_lowwall_runout_l;
  anim.coverexit["crouch_saw"][6] = % saw_gunner_lowwall_runout_r;
  anim.coverexit["exposed"] = [];
  anim.coverexit["exposed"][1] = % cqb_start_1;
  anim.coverexit["exposed"][2] = % stand_2_run_180l;
  anim.coverexit["exposed"][3] = % cqb_start_3;
  anim.coverexit["exposed"][4] = % stand_2_run_l;
  anim.coverexit["exposed"][6] = % stand_2_run_r;
  anim.coverexit["exposed"][7] = % cqb_start_7;
  anim.coverexit["exposed"][8] = % surprise_start_v1;
  anim.coverexit["exposed"][9] = % cqb_start_9;
  anim.coverexit["exposed_crouch"] = [];
  anim.coverexit["exposed_crouch"][1] = % cqb_crouch_start_1;
  anim.coverexit["exposed_crouch"][2] = % crouch_2run_180;
  anim.coverexit["exposed_crouch"][3] = % cqb_crouch_start_3;
  anim.coverexit["exposed_crouch"][4] = % crouch_2run_l;
  anim.coverexit["exposed_crouch"][6] = % crouch_2run_r;
  anim.coverexit["exposed_crouch"][7] = % cqb_crouch_start_7;
  anim.coverexit["exposed_crouch"][8] = % crouch_2run_f;
  anim.coverexit["exposed_crouch"][9] = % cqb_crouch_start_9;
  anim.coverexit["exposed_cqb"] = [];
  anim.coverexit["exposed_cqb"][1] = % cqb_start_1;
  anim.coverexit["exposed_cqb"][2] = % cqb_start_2;
  anim.coverexit["exposed_cqb"][3] = % cqb_start_3;
  anim.coverexit["exposed_cqb"][4] = % cqb_start_4;
  anim.coverexit["exposed_cqb"][6] = % cqb_start_6;
  anim.coverexit["exposed_cqb"][7] = % cqb_start_7;
  anim.coverexit["exposed_cqb"][8] = % cqb_start_8;
  anim.coverexit["exposed_cqb"][9] = % cqb_start_9;
  anim.coverexit["exposed_crouch_cqb"] = [];
  anim.coverexit["exposed_crouch_cqb"][1] = % cqb_crouch_start_1;
  anim.coverexit["exposed_crouch_cqb"][2] = % cqb_crouch_start_2;
  anim.coverexit["exposed_crouch_cqb"][3] = % cqb_crouch_start_3;
  anim.coverexit["exposed_crouch_cqb"][4] = % cqb_crouch_start_4;
  anim.coverexit["exposed_crouch_cqb"][6] = % cqb_crouch_start_6;
  anim.coverexit["exposed_crouch_cqb"][7] = % cqb_crouch_start_7;
  anim.coverexit["exposed_crouch_cqb"][8] = % cqb_crouch_start_8;
  anim.coverexit["exposed_crouch_cqb"][9] = % cqb_crouch_start_9;
  anim.coverexit["heat"] = [];
  anim.coverexit["heat"][1] = % heat_exit_1;
  anim.coverexit["heat"][2] = % heat_exit_2;
  anim.coverexit["heat"][3] = % heat_exit_3;
  anim.coverexit["heat"][4] = % heat_exit_4;
  anim.coverexit["heat"][6] = % heat_exit_6;
  anim.coverexit["heat"][7] = % heat_exit_7;
  anim.coverexit["heat"][8] = % heat_exit_8;
  anim.coverexit["heat"][9] = % heat_exit_9;
  anim.coverexit["heat_left"] = [];
  anim.coverexit["heat_left"][1] = % heat_exit_1;
  anim.coverexit["heat_left"][2] = % heat_exit_2;
  anim.coverexit["heat_left"][3] = % heat_exit_3;
  anim.coverexit["heat_left"][4] = % heat_exit_4;
  anim.coverexit["heat_left"][6] = % heat_exit_6;
  anim.coverexit["heat_left"][7] = % heat_exit_8l;
  anim.coverexit["heat_left"][8] = % heat_exit_8l;
  anim.coverexit["heat_left"][9] = % heat_exit_8r;
  anim.coverexit["heat_right"] = [];
  anim.coverexit["heat_right"][1] = % heat_exit_1;
  anim.coverexit["heat_right"][2] = % heat_exit_2;
  anim.coverexit["heat_right"][3] = % heat_exit_3;
  anim.coverexit["heat_right"][4] = % heat_exit_4;
  anim.coverexit["heat_right"][6] = % heat_exit_6;
  anim.coverexit["heat_right"][7] = % heat_exit_8l;
  anim.coverexit["heat_right"][8] = % heat_exit_8r;
  anim.coverexit["heat_right"][9] = % heat_exit_8r;

  for(var_2 = 1; var_2 <= 6; var_2++) {
    if(var_2 == 5) {
      continue;
    }
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_3 = var_0[var_4];

      if(isDefined(anim.covertrans[var_3]) && isDefined(anim.covertrans[var_3][var_2])) {
        anim.covertransdist[var_3][var_2] = getmovedelta(anim.covertrans[var_3][var_2], 0, 1);
        anim.covertransangles[var_3][var_2] = getangledelta(anim.covertrans[var_3][var_2], 0, 1);
      }

      if(isDefined(anim.coverexit[var_3]) && isDefined(anim.coverexit[var_3][var_2])) {
        if(animhasnotetrack(anim.coverexit[var_3][var_2], "code_move")) {
          var_5 = getnotetracktimes(anim.coverexit[var_3][var_2], "code_move")[0];
        } else {
          var_5 = 1;
        }
        anim.coverexitdist[var_3][var_2] = getmovedelta(anim.coverexit[var_3][var_2], 0, var_5);
        anim.coverexitangles[var_3][var_2] = getangledelta(anim.coverexit[var_3][var_2], 0, 1);
      }
    }
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_3 = var_0[var_4];
    anim.covertranslongestdist[var_3] = 0;

    for(var_2 = 1; var_2 <= 6; var_2++) {
      if(var_2 == 5 || !isDefined(anim.covertrans[var_3]) || !isDefined(anim.covertrans[var_3][var_2])) {
        continue;
      }
      var_6 = lengthsquared(anim.covertransdist[var_3][var_2]);

      if(anim.covertranslongestdist[var_3] < var_6) {
        anim.covertranslongestdist[var_3] = var_6;
      }
    }

    anim.covertranslongestdist[var_3] = sqrt(anim.covertranslongestdist[var_3]);
  }

  anim.exposedtransition["exposed"] = 1;
  anim.exposedtransition["exposed_crouch"] = 1;
  anim.exposedtransition["exposed_cqb"] = 1;
  anim.exposedtransition["exposed_crouch_cqb"] = 1;
  anim.exposedtransition["exposed_ready_cqb"] = 1;
  anim.exposedtransition["exposed_ready"] = 1;
  anim.exposedtransition["heat"] = 1;

  if(!isDefined(anim.longestexposedapproachdist)) {
    anim.longestexposedapproachdist = 0;
  }
  foreach(var_3, var_8 in anim.exposedtransition) {
    for(var_2 = 7; var_2 <= 9; var_2++) {
      if(isDefined(anim.covertrans[var_3]) && isDefined(anim.covertrans[var_3][var_2])) {
        anim.covertransdist[var_3][var_2] = getmovedelta(anim.covertrans[var_3][var_2], 0, 1);
        anim.covertransangles[var_3][var_2] = getangledelta(anim.covertrans[var_3][var_2], 0, 1);
      }

      if(isDefined(anim.coverexit[var_3]) && isDefined(anim.coverexit[var_3][var_2])) {
        var_5 = getnotetracktimes(anim.coverexit[var_3][var_2], "code_move")[0];
        anim.coverexitdist[var_3][var_2] = getmovedelta(anim.coverexit[var_3][var_2], 0, var_5);
        anim.coverexitangles[var_3][var_2] = getangledelta(anim.coverexit[var_3][var_2], 0, 1);
      }
    }

    for(var_2 = 1; var_2 <= 9; var_2++) {
      if(!isDefined(anim.covertrans[var_3]) || !isDefined(anim.covertrans[var_3][var_2])) {
        continue;
      }
      var_9 = length(anim.covertransdist[var_3][var_2]);

      if(var_9 > anim.longestexposedapproachdist) {
        anim.longestexposedapproachdist = var_9;
      }
    }
  }

  anim._id_2086["left"][7] = 0.369369;
  anim._id_2086["left_crouch"][7] = 0.319319;
  anim._id_2086["left_cqb"][7] = 0.451451;
  anim._id_2086["left_crouch_cqb"][7] = 0.246246;
  anim._id_2085["left"][7] = 0.547548;
  anim._id_2085["left_crouch"][7] = 0.593594;
  anim._id_2085["left_cqb"][7] = 0.702703;
  anim._id_2085["left_crouch_cqb"][7] = 0.718719;
  anim._id_2085["heat_left"][7] = 0.42;
  anim._id_2086["left"][8] = 0.525526;
  anim._id_2086["left_crouch"][8] = 0.428428;
  anim._id_2086["left_cqb"][8] = 0.431431;
  anim._id_2086["left_crouch_cqb"][8] = 0.33033;
  anim._id_2085["left"][8] = 0.614615;
  anim._id_2085["left_crouch"][8] = 0.451451;
  anim._id_2085["left_cqb"][8] = 0.451451;
  anim._id_2085["left_crouch_cqb"][8] = 0.603604;
  anim._id_2085["heat_left"][8] = 0.42;
  anim._id_2086["right"][8] = 0.458458;
  anim._id_2086["right_crouch"][8] = 0.248248;
  anim._id_2086["right_cqb"][8] = 0.458458;
  anim._id_2086["right_crouch_cqb"][8] = 0.311311;
  anim._id_2085["right"][8] = 0.457457;
  anim._id_2085["right_crouch"][8] = 0.545546;
  anim._id_2085["right_cqb"][8] = 0.540541;
  anim._id_2085["right_crouch_cqb"][8] = 0.399399;
  anim._id_2085["heat_right"][8] = 0.4;
  anim._id_2086["right"][9] = 0.546547;
  anim._id_2086["right_crouch"][9] = 0.2002;
  anim._id_2086["right_cqb"][9] = 0.546547;
  anim._id_2086["right_crouch_cqb"][9] = 0.232232;
  anim._id_2085["right"][9] = 0.483483;
  anim._id_2085["right_crouch"][9] = 0.493493;
  anim._id_2085["right_cqb"][9] = 0.565566;
  anim._id_2085["right_crouch_cqb"][9] = 0.518519;
  anim._id_2085["heat_right"][9] = 0.4;
  var_10 = [];
  var_10["left"] = 1;
  var_10["left_crouch"] = 1;
  var_10["left_crouch_cqb"] = 1;
  var_10["left_cqb"] = 1;
  var_11 = [];
  var_11["left"] = 1;
  var_11["left_crouch"] = 1;
  var_11["left_crouch_cqb"] = 1;
  var_11["left_cqb"] = 1;
  var_11["heat_left"] = 1;
  _id_208B(7, 8, 0, var_10, var_11);
  var_10 = [];
  var_10["right"] = 1;
  var_10["right_crouch"] = 1;
  var_10["right_cqb"] = 1;
  var_10["right_crouch_cqb"] = 1;
  var_11 = [];
  var_11["right"] = 1;
  var_11["right_crouch"] = 1;
  var_11["right_cqb"] = 1;
  var_11["right_crouch_cqb"] = 1;
  var_11["heat_right"] = 1;
  _id_208B(8, 9, 1, var_10, var_11);
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

_id_208B(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = var_0; var_5 <= var_1; var_5++) {
    foreach(var_8, var_7 in var_3) {
      anim.covertranspredist[var_8][var_5] = getmovedelta(anim.covertrans[var_8][var_5], 0, _id_208D(var_8, var_5));
      anim.covertransdist[var_8][var_5] = getmovedelta(anim.covertrans[var_8][var_5], 0, 1) - anim.covertranspredist[var_8][var_5];
      anim.covertransangles[var_8][var_5] = getangledelta(anim.covertrans[var_8][var_5], 0, 1);
    }

    foreach(var_8, var_7 in var_4) {
      anim.coverexitdist[var_8][var_5] = getmovedelta(anim.coverexit[var_8][var_5], 0, _id_208C(var_8, var_5));
      anim.coverexitpostdist[var_8][var_5] = getmovedelta(anim.coverexit[var_8][var_5], 0, 1) - anim.coverexitdist[var_8][var_5];
      anim.coverexitangles[var_8][var_5] = getangledelta(anim.coverexit[var_8][var_5], 0, 1);
    }
  }
}

_id_208C(var_0, var_1) {
  return anim._id_2085[var_0][var_1];
}

_id_208D(var_0, var_1) {
  return anim._id_2086[var_0][var_1];
}