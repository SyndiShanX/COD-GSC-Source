/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\init_move_transitions.gsc
*************************************************/

init_move_transition_arrays() {
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

#using_animtree("generic_human");

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
  var_2 = [];
  var_2["right"][1] = % corner_standr_trans_in_1;
  var_2["right"][2] = % corner_standr_trans_in_2;
  var_2["right"][3] = % corner_standr_trans_in_3;
  var_2["right"][4] = % corner_standr_trans_in_4;
  var_2["right"][6] = % corner_standr_trans_in_6;
  var_2["right"][8] = % corner_standr_trans_in_8;
  var_2["right"][9] = % corner_standr_trans_in_9;
  var_2["right_crouch"][1] = % cornercrr_trans_in_ml;
  var_2["right_crouch"][2] = % cornercrr_trans_in_m;
  var_2["right_crouch"][3] = % cornercrr_trans_in_mr;
  var_2["right_crouch"][4] = % cornercrr_trans_in_l;
  var_2["right_crouch"][6] = % cornercrr_trans_in_r;
  var_2["right_crouch"][8] = % cornercrr_trans_in_f;
  var_2["right_crouch"][9] = % cornercrr_trans_in_mf;
  var_2["right_cqb"][1] = % corner_standr_trans_cqb_in_1;
  var_2["right_cqb"][2] = % corner_standr_trans_cqb_in_2;
  var_2["right_cqb"][3] = % corner_standr_trans_cqb_in_3;
  var_2["right_cqb"][4] = % corner_standr_trans_cqb_in_4;
  var_2["right_cqb"][6] = % corner_standr_trans_cqb_in_6;
  var_2["right_cqb"][8] = % corner_standr_trans_cqb_in_8;
  var_2["right_cqb"][9] = % corner_standr_trans_cqb_in_9;
  var_2["right_crouch_cqb"][1] = % cornercrr_cqb_trans_in_1;
  var_2["right_crouch_cqb"][2] = % cornercrr_cqb_trans_in_2;
  var_2["right_crouch_cqb"][3] = % cornercrr_cqb_trans_in_3;
  var_2["right_crouch_cqb"][4] = % cornercrr_cqb_trans_in_4;
  var_2["right_crouch_cqb"][6] = % cornercrr_cqb_trans_in_6;
  var_2["right_crouch_cqb"][8] = % cornercrr_cqb_trans_in_8;
  var_2["right_crouch_cqb"][9] = % cornercrr_cqb_trans_in_9;
  var_2["left"][1] = % corner_standl_trans_in_1;
  var_2["left"][2] = % corner_standl_trans_in_2;
  var_2["left"][3] = % corner_standl_trans_in_3;
  var_2["left"][4] = % corner_standl_trans_in_4;
  var_2["left"][6] = % corner_standl_trans_in_6;
  var_2["left"][7] = % corner_standl_trans_in_7;
  var_2["left"][8] = % corner_standl_trans_in_8;
  var_2["left_crouch"][1] = % cornercrl_trans_in_ml;
  var_2["left_crouch"][2] = % cornercrl_trans_in_m;
  var_2["left_crouch"][3] = % cornercrl_trans_in_mr;
  var_2["left_crouch"][4] = % cornercrl_trans_in_l;
  var_2["left_crouch"][6] = % cornercrl_trans_in_r;
  var_2["left_crouch"][7] = % cornercrl_trans_in_mf;
  var_2["left_crouch"][8] = % cornercrl_trans_in_f;
  var_2["left_cqb"][1] = % corner_standl_trans_cqb_in_1;
  var_2["left_cqb"][2] = % corner_standl_trans_cqb_in_2;
  var_2["left_cqb"][3] = % corner_standl_trans_cqb_in_3;
  var_2["left_cqb"][4] = % corner_standl_trans_cqb_in_4;
  var_2["left_cqb"][6] = % corner_standl_trans_cqb_in_6;
  var_2["left_cqb"][7] = % corner_standl_trans_cqb_in_7;
  var_2["left_cqb"][8] = % corner_standl_trans_cqb_in_8;
  var_2["left_crouch_cqb"][1] = % cornercrl_cqb_trans_in_1;
  var_2["left_crouch_cqb"][2] = % cornercrl_cqb_trans_in_2;
  var_2["left_crouch_cqb"][3] = % cornercrl_cqb_trans_in_3;
  var_2["left_crouch_cqb"][4] = % cornercrl_cqb_trans_in_4;
  var_2["left_crouch_cqb"][6] = % cornercrl_cqb_trans_in_6;
  var_2["left_crouch_cqb"][7] = % cornercrl_cqb_trans_in_7;
  var_2["left_crouch_cqb"][8] = % cornercrl_cqb_trans_in_8;
  var_2["crouch"][1] = % covercrouch_run_in_ml;
  var_2["crouch"][2] = % covercrouch_run_in_m;
  var_2["crouch"][3] = % covercrouch_run_in_mr;
  var_2["crouch"][4] = % covercrouch_run_in_l;
  var_2["crouch"][6] = % covercrouch_run_in_r;
  var_2["stand"][1] = % coverstand_trans_in_ml;
  var_2["stand"][2] = % coverstand_trans_in_m;
  var_2["stand"][3] = % coverstand_trans_in_mr;
  var_2["stand"][4] = % coverstand_trans_in_l;
  var_2["stand"][6] = % coverstand_trans_in_r;
  var_2["stand_saw"][1] = % saw_gunner_runin_ml;
  var_2["stand_saw"][2] = % saw_gunner_runin_m;
  var_2["stand_saw"][3] = % saw_gunner_runin_mr;
  var_2["stand_saw"][4] = % saw_gunner_runin_l;
  var_2["stand_saw"][6] = % saw_gunner_runin_r;
  var_2["crouch_saw"][1] = % saw_gunner_lowwall_runin_ml;
  var_2["crouch_saw"][2] = % saw_gunner_lowwall_runin_m;
  var_2["crouch_saw"][3] = % saw_gunner_lowwall_runin_mr;
  var_2["crouch_saw"][4] = % saw_gunner_lowwall_runin_l;
  var_2["crouch_saw"][6] = % saw_gunner_lowwall_runin_r;
  var_2["prone_saw"][1] = % saw_gunner_prone_runin_ml;
  var_2["prone_saw"][2] = % saw_gunner_prone_runin_m;
  var_2["prone_saw"][3] = % saw_gunner_prone_runin_mr;
  var_2["exposed"] = [];
  var_2["exposed"][1] = % run_2_idle_1;
  var_2["exposed"][2] = % run_2_stand_f_6;
  var_2["exposed"][3] = % run_2_idle_3;
  var_2["exposed"][4] = % run_2_stand_90l;
  var_2["exposed"][6] = % run_2_stand_90r;
  var_2["exposed"][7] = % run_2_idle_7;
  var_2["exposed"][8] = % run_2_stand_180l;
  var_2["exposed"][9] = % run_2_idle_9;
  var_2["exposed_crouch"] = [];
  var_2["exposed_crouch"][1] = % run_2_crouch_idle_1;
  var_2["exposed_crouch"][2] = % run_2_crouch_f;
  var_2["exposed_crouch"][3] = % run_2_crouch_idle_3;
  var_2["exposed_crouch"][4] = % run_2_crouch_90l;
  var_2["exposed_crouch"][6] = % run_2_crouch_90r;
  var_2["exposed_crouch"][7] = % run_2_crouch_idle_7;
  var_2["exposed_crouch"][8] = % run_2_crouch_180l;
  var_2["exposed_crouch"][9] = % run_2_crouch_idle_9;
  var_2["exposed_cqb"] = [];
  var_2["exposed_cqb"][1] = % cqb_stop_1;
  var_2["exposed_cqb"][2] = % cqb_stop_2;
  var_2["exposed_cqb"][3] = % cqb_stop_3;
  var_2["exposed_cqb"][4] = % cqb_stop_4;
  var_2["exposed_cqb"][6] = % cqb_stop_6;
  var_2["exposed_cqb"][7] = % cqb_stop_7;
  var_2["exposed_cqb"][8] = % cqb_stop_8;
  var_2["exposed_cqb"][9] = % cqb_stop_9;
  var_2["exposed_crouch_cqb"] = [];
  var_2["exposed_crouch_cqb"][1] = % cqb_crouch_stop_1;
  var_2["exposed_crouch_cqb"][2] = % cqb_crouch_stop_2;
  var_2["exposed_crouch_cqb"][3] = % cqb_crouch_stop_3;
  var_2["exposed_crouch_cqb"][4] = % cqb_crouch_stop_4;
  var_2["exposed_crouch_cqb"][6] = % cqb_crouch_stop_6;
  var_2["exposed_crouch_cqb"][7] = % cqb_crouch_stop_7;
  var_2["exposed_crouch_cqb"][8] = % cqb_crouch_stop_8;
  var_2["exposed_crouch_cqb"][9] = % cqb_crouch_stop_9;
  var_2["heat"] = [];
  var_2["heat"][1] = % heat_approach_1;
  var_2["heat"][2] = % heat_approach_2;
  var_2["heat"][3] = % heat_approach_3;
  var_2["heat"][4] = % heat_approach_4;
  var_2["heat"][6] = % heat_approach_6;
  var_2["heat"][8] = % heat_approach_8;
  var_2["heat_left"] = [];
  var_2["heat_right"] = [];
  var_2["wall_over_96"][1] = % traverse90_in_ml;
  var_2["wall_over_96"][2] = % traverse90_in_m;
  var_2["wall_over_96"][3] = % traverse90_in_mr;
  anim.traverseinfo["wall_over_96"]["height"] = 96;
  var_2["wall_over_40"][1] = % traverse_window_m_2_run;
  var_2["wall_over_40"][2] = % traverse_window_m_2_run;
  var_2["wall_over_40"][3] = % traverse_window_m_2_run;
  anim.archetypes["soldier"]["cover_trans"] = var_2;
  var_2 = [];
  var_2["right"][1] = % corner_standr_trans_out_1;
  var_2["right"][2] = % corner_standr_trans_out_2;
  var_2["right"][3] = % corner_standr_trans_out_3;
  var_2["right"][4] = % corner_standr_trans_out_4;
  var_2["right"][6] = % corner_standr_trans_out_6;
  var_2["right"][8] = % corner_standr_trans_out_8;
  var_2["right"][9] = % corner_standr_trans_out_9;
  var_2["right_crouch"][1] = % cornercrr_trans_out_ml;
  var_2["right_crouch"][2] = % cornercrr_trans_out_m;
  var_2["right_crouch"][3] = % cornercrr_trans_out_mr;
  var_2["right_crouch"][4] = % cornercrr_trans_out_l;
  var_2["right_crouch"][6] = % cornercrr_trans_out_r;
  var_2["right_crouch"][8] = % cornercrr_trans_out_f;
  var_2["right_crouch"][9] = % cornercrr_trans_out_mf;
  var_2["right_cqb"][1] = % corner_standr_trans_cqb_out_1;
  var_2["right_cqb"][2] = % corner_standr_trans_cqb_out_2;
  var_2["right_cqb"][3] = % corner_standr_trans_cqb_out_3;
  var_2["right_cqb"][4] = % corner_standr_trans_cqb_out_4;
  var_2["right_cqb"][6] = % corner_standr_trans_cqb_out_6;
  var_2["right_cqb"][8] = % corner_standr_trans_cqb_out_8;
  var_2["right_cqb"][9] = % corner_standr_trans_cqb_out_9;
  var_2["right_crouch_cqb"][1] = % cornercrr_cqb_trans_out_1;
  var_2["right_crouch_cqb"][2] = % cornercrr_cqb_trans_out_2;
  var_2["right_crouch_cqb"][3] = % cornercrr_cqb_trans_out_3;
  var_2["right_crouch_cqb"][4] = % cornercrr_cqb_trans_out_4;
  var_2["right_crouch_cqb"][6] = % cornercrr_cqb_trans_out_6;
  var_2["right_crouch_cqb"][8] = % cornercrr_cqb_trans_out_8;
  var_2["right_crouch_cqb"][9] = % cornercrr_cqb_trans_out_9;
  var_2["left"][1] = % corner_standl_trans_out_1;
  var_2["left"][2] = % corner_standl_trans_out_2;
  var_2["left"][3] = % corner_standl_trans_out_3;
  var_2["left"][4] = % corner_standl_trans_out_4;
  var_2["left"][6] = % corner_standl_trans_out_6;
  var_2["left"][7] = % corner_standl_trans_out_7;
  var_2["left"][8] = % corner_standl_trans_out_8;
  var_2["left_crouch"][1] = % cornercrl_trans_out_ml;
  var_2["left_crouch"][2] = % cornercrl_trans_out_m;
  var_2["left_crouch"][3] = % cornercrl_trans_out_mr;
  var_2["left_crouch"][4] = % cornercrl_trans_out_l;
  var_2["left_crouch"][6] = % cornercrl_trans_out_r;
  var_2["left_crouch"][7] = % cornercrl_trans_out_mf;
  var_2["left_crouch"][8] = % cornercrl_trans_out_f;
  var_2["left_cqb"][1] = % corner_standl_trans_cqb_out_1;
  var_2["left_cqb"][2] = % corner_standl_trans_cqb_out_2;
  var_2["left_cqb"][3] = % corner_standl_trans_cqb_out_3;
  var_2["left_cqb"][4] = % corner_standl_trans_cqb_out_4;
  var_2["left_cqb"][6] = % corner_standl_trans_cqb_out_6;
  var_2["left_cqb"][7] = % corner_standl_trans_cqb_out_7;
  var_2["left_cqb"][8] = % corner_standl_trans_cqb_out_8;
  var_2["left_crouch_cqb"][1] = % cornercrl_cqb_trans_out_1;
  var_2["left_crouch_cqb"][2] = % cornercrl_cqb_trans_out_2;
  var_2["left_crouch_cqb"][3] = % cornercrl_cqb_trans_out_3;
  var_2["left_crouch_cqb"][4] = % cornercrl_cqb_trans_out_4;
  var_2["left_crouch_cqb"][6] = % cornercrl_cqb_trans_out_6;
  var_2["left_crouch_cqb"][7] = % cornercrl_cqb_trans_out_7;
  var_2["left_crouch_cqb"][8] = % cornercrl_cqb_trans_out_8;
  var_2["crouch"][1] = % covercrouch_run_out_ml;
  var_2["crouch"][2] = % covercrouch_run_out_m;
  var_2["crouch"][3] = % covercrouch_run_out_mr;
  var_2["crouch"][4] = % covercrouch_run_out_l;
  var_2["crouch"][6] = % covercrouch_run_out_r;
  var_2["stand"][1] = % coverstand_trans_out_ml;
  var_2["stand"][2] = % coverstand_trans_out_m;
  var_2["stand"][3] = % coverstand_trans_out_mr;
  var_2["stand"][4] = % coverstand_trans_out_l;
  var_2["stand"][6] = % coverstand_trans_out_r;
  var_2["stand_saw"][1] = % saw_gunner_runout_ml;
  var_2["stand_saw"][2] = % saw_gunner_runout_m;
  var_2["stand_saw"][3] = % saw_gunner_runout_mr;
  var_2["stand_saw"][4] = % saw_gunner_runout_l;
  var_2["stand_saw"][6] = % saw_gunner_runout_r;
  var_2["prone_saw"][2] = % saw_gunner_prone_runout_m;
  var_2["prone_saw"][4] = % saw_gunner_prone_runout_l;
  var_2["prone_saw"][6] = % saw_gunner_prone_runout_r;
  var_2["prone_saw"][8] = % saw_gunner_prone_runout_f;
  var_2["crouch_saw"][1] = % saw_gunner_lowwall_runout_ml;
  var_2["crouch_saw"][2] = % saw_gunner_lowwall_runout_m;
  var_2["crouch_saw"][3] = % saw_gunner_lowwall_runout_mr;
  var_2["crouch_saw"][4] = % saw_gunner_lowwall_runout_l;
  var_2["crouch_saw"][6] = % saw_gunner_lowwall_runout_r;
  var_2["exposed"] = [];
  var_2["exposed"][1] = % cqb_start_1;
  var_2["exposed"][2] = % stand_2_run_180l;
  var_2["exposed"][3] = % cqb_start_3;
  var_2["exposed"][4] = % stand_2_run_l;
  var_2["exposed"][6] = % stand_2_run_r;
  var_2["exposed"][7] = % cqb_start_7;
  var_2["exposed"][8] = % surprise_start_v1;
  var_2["exposed"][9] = % cqb_start_9;
  var_2["exposed_crouch"] = [];
  var_2["exposed_crouch"][1] = % cqb_crouch_start_1;
  var_2["exposed_crouch"][2] = % crouch_2run_180;
  var_2["exposed_crouch"][3] = % cqb_crouch_start_3;
  var_2["exposed_crouch"][4] = % crouch_2run_l;
  var_2["exposed_crouch"][6] = % crouch_2run_r;
  var_2["exposed_crouch"][7] = % cqb_crouch_start_7;
  var_2["exposed_crouch"][8] = % crouch_2run_f;
  var_2["exposed_crouch"][9] = % cqb_crouch_start_9;
  var_2["exposed_cqb"] = [];
  var_2["exposed_cqb"][1] = % cqb_start_1;
  var_2["exposed_cqb"][2] = % cqb_start_2;
  var_2["exposed_cqb"][3] = % cqb_start_3;
  var_2["exposed_cqb"][4] = % cqb_start_4;
  var_2["exposed_cqb"][6] = % cqb_start_6;
  var_2["exposed_cqb"][7] = % cqb_start_7;
  var_2["exposed_cqb"][8] = % cqb_start_8;
  var_2["exposed_cqb"][9] = % cqb_start_9;
  var_2["exposed_crouch_cqb"] = [];
  var_2["exposed_crouch_cqb"][1] = % cqb_crouch_start_1;
  var_2["exposed_crouch_cqb"][2] = % cqb_crouch_start_2;
  var_2["exposed_crouch_cqb"][3] = % cqb_crouch_start_3;
  var_2["exposed_crouch_cqb"][4] = % cqb_crouch_start_4;
  var_2["exposed_crouch_cqb"][6] = % cqb_crouch_start_6;
  var_2["exposed_crouch_cqb"][7] = % cqb_crouch_start_7;
  var_2["exposed_crouch_cqb"][8] = % cqb_crouch_start_8;
  var_2["exposed_crouch_cqb"][9] = % cqb_crouch_start_9;
  var_2["heat"] = [];
  var_2["heat"][1] = % heat_exit_1;
  var_2["heat"][2] = % heat_exit_2;
  var_2["heat"][3] = % heat_exit_3;
  var_2["heat"][4] = % heat_exit_4;
  var_2["heat"][6] = % heat_exit_6;
  var_2["heat"][7] = % heat_exit_7;
  var_2["heat"][8] = % heat_exit_8;
  var_2["heat"][9] = % heat_exit_9;
  var_2["heat_left"] = [];
  var_2["heat_left"][1] = % heat_exit_1;
  var_2["heat_left"][2] = % heat_exit_2;
  var_2["heat_left"][3] = % heat_exit_3;
  var_2["heat_left"][4] = % heat_exit_4;
  var_2["heat_left"][6] = % heat_exit_6;
  var_2["heat_left"][7] = % heat_exit_8l;
  var_2["heat_left"][8] = % heat_exit_8l;
  var_2["heat_left"][9] = % heat_exit_8r;
  var_2["heat_right"] = [];
  var_2["heat_right"][1] = % heat_exit_1;
  var_2["heat_right"][2] = % heat_exit_2;
  var_2["heat_right"][3] = % heat_exit_3;
  var_2["heat_right"][4] = % heat_exit_4;
  var_2["heat_right"][6] = % heat_exit_6;
  var_2["heat_right"][7] = % heat_exit_8l;
  var_2["heat_right"][8] = % heat_exit_8r;
  var_2["heat_right"][9] = % heat_exit_8r;
  anim.archetypes["soldier"]["cover_exit"] = var_2;

  for(var_3 = 1; var_3 <= 6; var_3++) {
    if(var_3 == 5) {
      continue;
    }
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_5 = var_0[var_4];

      if(isDefined(anim.archetypes["soldier"]["cover_trans"][var_5]) && isDefined(anim.archetypes["soldier"]["cover_trans"][var_5][var_3])) {
        anim.archetypes["soldier"]["cover_trans_dist"][var_5][var_3] = getmovedelta(anim.archetypes["soldier"]["cover_trans"][var_5][var_3], 0, 1);
        anim.archetypes["soldier"]["cover_trans_angles"][var_5][var_3] = getangledelta(anim.archetypes["soldier"]["cover_trans"][var_5][var_3], 0, 1);
      }

      if(isDefined(anim.archetypes["soldier"]["cover_exit"][var_5]) && isDefined(anim.archetypes["soldier"]["cover_exit"][var_5][var_3])) {
        if(animhasnotetrack(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], "code_move")) {
          var_6 = getnotetracktimes(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], "code_move")[0];
        }
        else {
          var_6 = 1;
        }

        anim.archetypes["soldier"]["cover_exit_dist"][var_5][var_3] = getmovedelta(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], 0, var_6);
        anim.archetypes["soldier"]["cover_exit_angles"][var_5][var_3] = getangledelta(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], 0, 1);
      }
    }
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];
    anim.covertranslongestdist[var_5] = 0;

    for(var_3 = 1; var_3 <= 6; var_3++) {
      if(var_3 == 5 || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_5]) || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_5][var_3])) {
        continue;
      }
      var_7 = lengthsquared(anim.archetypes["soldier"]["cover_trans_dist"][var_5][var_3]);

      if(anim.covertranslongestdist[var_5] < var_7) {
        anim.covertranslongestdist[var_5] = var_7;
      }
    }

    anim.covertranslongestdist[var_5] = sqrt(anim.covertranslongestdist[var_5]);
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

  foreach(var_5, var_9 in anim.exposedtransition) {
    for(var_3 = 7; var_3 <= 9; var_3++) {
      if(isDefined(anim.archetypes["soldier"]["cover_trans"][var_5]) && isDefined(anim.archetypes["soldier"]["cover_trans"][var_5][var_3])) {
        anim.archetypes["soldier"]["cover_trans_dist"][var_5][var_3] = getmovedelta(anim.archetypes["soldier"]["cover_trans"][var_5][var_3], 0, 1);
        anim.archetypes["soldier"]["cover_trans_angles"][var_5][var_3] = getangledelta(anim.archetypes["soldier"]["cover_trans"][var_5][var_3], 0, 1);
      }

      if(isDefined(anim.archetypes["soldier"]["cover_exit"][var_5]) && isDefined(anim.archetypes["soldier"]["cover_exit"][var_5][var_3])) {
        var_6 = getnotetracktimes(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], "code_move")[0];
        anim.archetypes["soldier"]["cover_exit_dist"][var_5][var_3] = getmovedelta(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], 0, var_6);
        anim.archetypes["soldier"]["cover_exit_angles"][var_5][var_3] = getangledelta(anim.archetypes["soldier"]["cover_exit"][var_5][var_3], 0, 1);
      }
    }

    for(var_3 = 1; var_3 <= 9; var_3++) {
      if(!isDefined(anim.archetypes["soldier"]["cover_trans"][var_5]) || !isDefined(anim.archetypes["soldier"]["cover_trans"][var_5][var_3])) {
        continue;
      }
      var_10 = length(anim.archetypes["soldier"]["cover_trans_dist"][var_5][var_3]);

      if(var_10 > anim.longestexposedapproachdist) {
        anim.longestexposedapproachdist = var_10;
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