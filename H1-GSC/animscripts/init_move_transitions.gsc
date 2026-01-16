/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\init_move_transitions.gsc
*************************************************/

init_move_transition_arrays() {
  if(isdefined(anim.move_transition_arrays)) {
    return;
  }
  anim.move_transition_arrays = 1;

  if(!isdefined(anim.covertrans))
    anim.covertrans = [];

  if(!isdefined(anim.coverexit))
    anim.coverexit = [];

  anim.maxdirections = [];
  anim.excludedir = [];
  anim.traverseinfo = [];

  if(!isdefined(anim.covertransdist))
    anim.covertransdist = [];

  if(!isdefined(anim.coverexitdist))
    anim.coverexitdist = [];

  anim.coverexitpostdist = [];
  anim.covertranspredist = [];

  if(!isdefined(anim.covertransangles))
    anim.covertransangles = [];

  if(!isdefined(anim.coverexitangles))
    anim.coverexitangles = [];

  anim.arrivalendstance = [];
}

#using_animtree("generic_human");

initsoldierentrance() {
  var_0 = [];
  var_0["right"][1] = % corner_standr_trans_in_1;
  var_0["right"][2] = % corner_standr_trans_in_2;
  var_0["right"][3] = % corner_standr_trans_in_3;
  var_0["right"][4] = % corner_standr_trans_in_4;
  var_0["right"][6] = % corner_standr_trans_in_6;
  var_0["right"][8] = % corner_standr_trans_in_8;
  var_0["right"][9] = % corner_standr_trans_in_9;
  var_0["right_crouch"][1] = % cornercrr_trans_in_ml;
  var_0["right_crouch"][2] = % cornercrr_trans_in_m;
  var_0["right_crouch"][3] = % cornercrr_trans_in_mr;
  var_0["right_crouch"][4] = % cornercrr_trans_in_l;
  var_0["right_crouch"][6] = % cornercrr_trans_in_r;
  var_0["right_crouch"][8] = % cornercrr_trans_in_f;
  var_0["right_crouch"][9] = % cornercrr_trans_in_mf;
  var_0["right_cqb"][1] = % corner_standr_trans_cqb_in_1;
  var_0["right_cqb"][2] = % corner_standr_trans_cqb_in_2;
  var_0["right_cqb"][3] = % corner_standr_trans_cqb_in_3;
  var_0["right_cqb"][4] = % corner_standr_trans_cqb_in_4;
  var_0["right_cqb"][6] = % corner_standr_trans_cqb_in_6;
  var_0["right_cqb"][8] = % corner_standr_trans_cqb_in_8;
  var_0["right_cqb"][9] = % corner_standr_trans_cqb_in_9;
  var_0["right_crouch_cqb"][1] = % cornercrr_cqb_trans_in_1;
  var_0["right_crouch_cqb"][2] = % cornercrr_cqb_trans_in_2;
  var_0["right_crouch_cqb"][3] = % cornercrr_cqb_trans_in_3;
  var_0["right_crouch_cqb"][4] = % cornercrr_cqb_trans_in_4;
  var_0["right_crouch_cqb"][6] = % cornercrr_cqb_trans_in_6;
  var_0["right_crouch_cqb"][8] = % cornercrr_cqb_trans_in_8;
  var_0["right_crouch_cqb"][9] = % cornercrr_cqb_trans_in_9;
  var_0["left"][1] = % corner_standl_trans_in_1;
  var_0["left"][2] = % corner_standl_trans_in_2;
  var_0["left"][3] = % corner_standl_trans_in_3;
  var_0["left"][4] = % corner_standl_trans_in_4;
  var_0["left"][6] = % corner_standl_trans_in_6;
  var_0["left"][7] = % corner_standl_trans_in_7;
  var_0["left"][8] = % corner_standl_trans_in_8;
  var_0["left_crouch"][1] = % cornercrl_trans_in_ml;
  var_0["left_crouch"][2] = % cornercrl_trans_in_m;
  var_0["left_crouch"][3] = % cornercrl_trans_in_mr;
  var_0["left_crouch"][4] = % cornercrl_trans_in_l;
  var_0["left_crouch"][6] = % cornercrl_trans_in_r;
  var_0["left_crouch"][7] = % cornercrl_trans_in_mf;
  var_0["left_crouch"][8] = % cornercrl_trans_in_f;
  var_0["left_cqb"][1] = % corner_standl_trans_cqb_in_1;
  var_0["left_cqb"][2] = % corner_standl_trans_cqb_in_2;
  var_0["left_cqb"][3] = % corner_standl_trans_cqb_in_3;
  var_0["left_cqb"][4] = % corner_standl_trans_cqb_in_4;
  var_0["left_cqb"][6] = % corner_standl_trans_cqb_in_6;
  var_0["left_cqb"][7] = % corner_standl_trans_cqb_in_7;
  var_0["left_cqb"][8] = % corner_standl_trans_cqb_in_8;
  var_0["left_crouch_cqb"][1] = % cornercrl_cqb_trans_in_1;
  var_0["left_crouch_cqb"][2] = % cornercrl_cqb_trans_in_2;
  var_0["left_crouch_cqb"][3] = % cornercrl_cqb_trans_in_3;
  var_0["left_crouch_cqb"][4] = % cornercrl_cqb_trans_in_4;
  var_0["left_crouch_cqb"][6] = % cornercrl_cqb_trans_in_6;
  var_0["left_crouch_cqb"][7] = % cornercrl_cqb_trans_in_7;
  var_0["left_crouch_cqb"][8] = % cornercrl_cqb_trans_in_8;
  var_0["crouch"][1] = % covercrouch_run_in_ml;
  var_0["crouch"][2] = % covercrouch_run_in_m;
  var_0["crouch"][3] = % covercrouch_run_in_mr;
  var_0["crouch"][4] = % covercrouch_run_in_l;
  var_0["crouch"][6] = % covercrouch_run_in_r;
  var_0["stand"][1] = % coverstand_trans_in_ml;
  var_0["stand"][2] = % coverstand_trans_in_m;
  var_0["stand"][3] = % coverstand_trans_in_mr;
  var_0["stand"][4] = % coverstand_trans_in_l;
  var_0["stand"][6] = % coverstand_trans_in_r;
  var_0["stand_saw"][1] = % saw_gunner_runin_ml;
  var_0["stand_saw"][2] = % saw_gunner_runin_m;
  var_0["stand_saw"][3] = % saw_gunner_runin_mr;
  var_0["stand_saw"][4] = % saw_gunner_runin_l;
  var_0["stand_saw"][6] = % saw_gunner_runin_r;
  var_0["stand_unstable"] = [];
  var_0["stand_unstable"][1] = % lag_unstable_moveforward_arrive_1;
  var_0["stand_unstable"][2] = % lag_unstable_moveforward_arrive_2;
  var_0["stand_unstable"][3] = % lag_unstable_moveforward_arrive_3;
  var_0["stand_unstable"][4] = % lag_unstable_moveforward_arrive_4;
  var_0["stand_unstable"][6] = % lag_unstable_moveforward_arrive_6;
  var_0["stand_unstable"][7] = % lag_unstable_moveforward_arrive_7;
  var_0["stand_unstable"][8] = % lag_unstable_moveforward_arrive_8;
  var_0["stand_unstable"][9] = % lag_unstable_moveforward_arrive_9;
  var_0["stand_unstable_run"] = [];
  var_0["stand_unstable_run"][1] = % lag_unstable_run_arrive_1;
  var_0["stand_unstable_run"][2] = % lag_unstable_run_arrive_2;
  var_0["stand_unstable_run"][3] = % lag_unstable_run_arrive_3;
  var_0["stand_unstable_run"][4] = % lag_unstable_run_arrive_4;
  var_0["stand_unstable_run"][6] = % lag_unstable_run_arrive_6;
  var_0["stand_unstable_run"][7] = % lag_unstable_run_arrive_7;
  var_0["stand_unstable_run"][8] = % lag_unstable_run_arrive_8;
  var_0["stand_unstable_run"][9] = % lag_unstable_run_arrive_9;
  var_0["crouch_saw"][1] = % saw_gunner_lowwall_runin_ml;
  var_0["crouch_saw"][2] = % saw_gunner_lowwall_runin_m;
  var_0["crouch_saw"][3] = % saw_gunner_lowwall_runin_mr;
  var_0["crouch_saw"][4] = % saw_gunner_lowwall_runin_l;
  var_0["crouch_saw"][6] = % saw_gunner_lowwall_runin_r;
  var_0["prone_saw"][1] = % saw_gunner_prone_runin_ml;
  var_0["prone_saw"][2] = % saw_gunner_prone_runin_m;
  var_0["prone_saw"][3] = % saw_gunner_prone_runin_mr;
  var_0["exposed"] = [];
  var_0["exposed"][1] = % run_2_idle_1;
  var_0["exposed"][2] = % run_2_stand_f_6;
  var_0["exposed"][3] = % run_2_idle_3;
  var_0["exposed"][4] = % run_2_stand_90l;
  var_0["exposed"][6] = % run_2_stand_90r;
  var_0["exposed"][7] = % run_2_idle_7;
  var_0["exposed"][8] = % run_2_stand_180l;
  var_0["exposed"][9] = % run_2_idle_9;
  var_0["exposed_smg"] = [];
  var_0["exposed_smg"][1] = % cqb_stop_1;
  var_0["exposed_smg"][2] = % smg_run_2_stand_f_6;
  var_0["exposed_smg"][3] = % cqb_stop_3;
  var_0["exposed_smg"][4] = % run_2_stand_90l;
  var_0["exposed_smg"][6] = % run_2_stand_90r;
  var_0["exposed_smg"][7] = % cqb_stop_7;
  var_0["exposed_smg"][8] = % run_2_stand_180l;
  var_0["exposed_smg"][9] = % cqb_stop_9;
  var_0["exposed_crouch"] = [];
  var_0["exposed_crouch"][1] = % run_2_crouch_idle_1;
  var_0["exposed_crouch"][2] = % run_2_crouch_f;
  var_0["exposed_crouch"][3] = % run_2_crouch_idle_3;
  var_0["exposed_crouch"][4] = % run_2_crouch_90l;
  var_0["exposed_crouch"][6] = % run_2_crouch_90r;
  var_0["exposed_crouch"][7] = % run_2_crouch_idle_7;
  var_0["exposed_crouch"][8] = % run_2_crouch_180l;
  var_0["exposed_crouch"][9] = % run_2_crouch_idle_9;
  var_0["exposed_crouch_crouchwalk"] = [];
  var_0["exposed_crouch_crouchwalk"][1] = % crouchwalk_2_crouch_stop_1;
  var_0["exposed_crouch_crouchwalk"][2] = % crouchwalk_2_crouch_stop_2;
  var_0["exposed_crouch_crouchwalk"][3] = % crouchwalk_2_crouch_stop_3;
  var_0["exposed_crouch_crouchwalk"][4] = % crouchwalk_2_crouch_stop_4;
  var_0["exposed_crouch_crouchwalk"][6] = % crouchwalk_2_crouch_stop_6;
  var_0["exposed_crouch_crouchwalk"][7] = % crouchwalk_2_crouch_stop_7;
  var_0["exposed_crouch_crouchwalk"][8] = % crouchwalk_2_crouch_stop_8;
  var_0["exposed_crouch_crouchwalk"][9] = % crouchwalk_2_crouch_stop_9;
  var_0["exposed_cqb"] = [];
  var_0["exposed_cqb"][1] = % cqb_stop_1;
  var_0["exposed_cqb"][2] = % cqb_stop_2;
  var_0["exposed_cqb"][3] = % cqb_stop_3;
  var_0["exposed_cqb"][4] = % cqb_stop_4;
  var_0["exposed_cqb"][6] = % cqb_stop_6;
  var_0["exposed_cqb"][7] = % cqb_stop_7;
  var_0["exposed_cqb"][8] = % cqb_stop_8;
  var_0["exposed_cqb"][9] = % cqb_stop_9;
  var_0["exposed_crouch_cqb"] = [];
  var_0["exposed_crouch_cqb"][1] = % cqb_crouch_stop_1;
  var_0["exposed_crouch_cqb"][2] = % cqb_crouch_stop_2;
  var_0["exposed_crouch_cqb"][3] = % cqb_crouch_stop_3;
  var_0["exposed_crouch_cqb"][4] = % cqb_crouch_stop_4;
  var_0["exposed_crouch_cqb"][6] = % cqb_crouch_stop_6;
  var_0["exposed_crouch_cqb"][7] = % cqb_crouch_stop_7;
  var_0["exposed_crouch_cqb"][8] = % cqb_crouch_stop_8;
  var_0["exposed_crouch_cqb"][9] = % cqb_crouch_stop_9;
  var_0["exposed_unstable"] = [];
  var_0["exposed_unstable"][1] = % lag_unstable_moveforward_arrive_1;
  var_0["exposed_unstable"][2] = % lag_unstable_moveforward_arrive_2;
  var_0["exposed_unstable"][3] = % lag_unstable_moveforward_arrive_3;
  var_0["exposed_unstable"][4] = % lag_unstable_moveforward_arrive_4;
  var_0["exposed_unstable"][6] = % lag_unstable_moveforward_arrive_6;
  var_0["exposed_unstable"][7] = % lag_unstable_moveforward_arrive_7;
  var_0["exposed_unstable"][8] = % lag_unstable_moveforward_arrive_8;
  var_0["exposed_unstable"][9] = % lag_unstable_moveforward_arrive_9;
  var_0["exposed_unstable_run"] = [];
  var_0["exposed_unstable_run"][1] = % lag_unstable_run_arrive_1;
  var_0["exposed_unstable_run"][2] = % lag_unstable_run_arrive_2;
  var_0["exposed_unstable_run"][3] = % lag_unstable_run_arrive_3;
  var_0["exposed_unstable_run"][4] = % lag_unstable_run_arrive_4;
  var_0["exposed_unstable_run"][6] = % lag_unstable_run_arrive_6;
  var_0["exposed_unstable_run"][7] = % lag_unstable_run_arrive_7;
  var_0["exposed_unstable_run"][8] = % lag_unstable_run_arrive_8;
  var_0["exposed_unstable_run"][9] = % lag_unstable_run_arrive_9;
  var_0["heat"] = [];
  var_0["heat"][1] = % heat_approach_1;
  var_0["heat"][2] = % heat_approach_2;
  var_0["heat"][3] = % heat_approach_3;
  var_0["heat"][4] = % heat_approach_4;
  var_0["heat"][6] = % heat_approach_6;
  var_0["heat"][8] = % heat_approach_8;
  var_0["heat_left"] = [];
  var_0["heat_right"] = [];
  var_0["wall_over_96"][1] = % traverse90_in_ml;
  var_0["wall_over_96"][2] = % traverse90_in_m;
  var_0["wall_over_96"][3] = % traverse90_in_mr;
  anim.traverseinfo["wall_over_96"]["height"] = 96;
  var_0["wall_over_40"][1] = % traverse_window_m_2_run;
  var_0["wall_over_40"][2] = % traverse_window_m_2_run;
  var_0["wall_over_40"][3] = % traverse_window_m_2_run;
  anim.archetypes["soldier"]["cover_trans"] = var_0;
}

initsoldierexit() {
  var_0 = [];
  var_0["right"][1] = % corner_standr_trans_out_1;
  var_0["right"][2] = % corner_standr_trans_out_2;
  var_0["right"][3] = % corner_standr_trans_out_3;
  var_0["right"][4] = % corner_standr_trans_out_4;
  var_0["right"][6] = % corner_standr_trans_out_6;
  var_0["right"][8] = % corner_standr_trans_out_8;
  var_0["right"][9] = % corner_standr_trans_out_9;
  var_0["right_crouch"][1] = % cornercrr_trans_out_ml;
  var_0["right_crouch"][2] = % cornercrr_trans_out_m;
  var_0["right_crouch"][3] = % cornercrr_trans_out_mr;
  var_0["right_crouch"][4] = % cornercrr_trans_out_l;
  var_0["right_crouch"][6] = % cornercrr_trans_out_r;
  var_0["right_crouch"][8] = % cornercrr_trans_out_f;
  var_0["right_crouch"][9] = % cornercrr_trans_out_mf;
  var_0["right_cqb"][1] = % corner_standr_trans_cqb_out_1;
  var_0["right_cqb"][2] = % corner_standr_trans_cqb_out_2;
  var_0["right_cqb"][3] = % corner_standr_trans_cqb_out_3;
  var_0["right_cqb"][4] = % corner_standr_trans_cqb_out_4;
  var_0["right_cqb"][6] = % corner_standr_trans_cqb_out_6;
  var_0["right_cqb"][8] = % corner_standr_trans_cqb_out_8;
  var_0["right_cqb"][9] = % corner_standr_trans_cqb_out_9;
  var_0["right_crouch_cqb"][1] = % cornercrr_cqb_trans_out_1;
  var_0["right_crouch_cqb"][2] = % cornercrr_cqb_trans_out_2;
  var_0["right_crouch_cqb"][3] = % cornercrr_cqb_trans_out_3;
  var_0["right_crouch_cqb"][4] = % cornercrr_cqb_trans_out_4;
  var_0["right_crouch_cqb"][6] = % cornercrr_cqb_trans_out_6;
  var_0["right_crouch_cqb"][8] = % cornercrr_cqb_trans_out_8;
  var_0["right_crouch_cqb"][9] = % cornercrr_cqb_trans_out_9;
  var_0["left"][1] = % corner_standl_trans_out_1;
  var_0["left"][2] = % corner_standl_trans_out_2;
  var_0["left"][3] = % corner_standl_trans_out_3;
  var_0["left"][4] = % corner_standl_trans_out_4;
  var_0["left"][6] = % corner_standl_trans_out_6;
  var_0["left"][7] = % corner_standl_trans_out_7;
  var_0["left"][8] = % corner_standl_trans_out_8;
  var_0["left_crouch"][1] = % cornercrl_trans_out_ml;
  var_0["left_crouch"][2] = % cornercrl_trans_out_m;
  var_0["left_crouch"][3] = % cornercrl_trans_out_mr;
  var_0["left_crouch"][4] = % cornercrl_trans_out_l;
  var_0["left_crouch"][6] = % cornercrl_trans_out_r;
  var_0["left_crouch"][7] = % cornercrl_trans_out_mf;
  var_0["left_crouch"][8] = % cornercrl_trans_out_f;
  var_0["left_cqb"][1] = % corner_standl_trans_cqb_out_1;
  var_0["left_cqb"][2] = % corner_standl_trans_cqb_out_2;
  var_0["left_cqb"][3] = % corner_standl_trans_cqb_out_3;
  var_0["left_cqb"][4] = % corner_standl_trans_cqb_out_4;
  var_0["left_cqb"][6] = % corner_standl_trans_cqb_out_6;
  var_0["left_cqb"][7] = % corner_standl_trans_cqb_out_7;
  var_0["left_cqb"][8] = % corner_standl_trans_cqb_out_8;
  var_0["left_crouch_cqb"][1] = % cornercrl_cqb_trans_out_1;
  var_0["left_crouch_cqb"][2] = % cornercrl_cqb_trans_out_2;
  var_0["left_crouch_cqb"][3] = % cornercrl_cqb_trans_out_3;
  var_0["left_crouch_cqb"][4] = % cornercrl_cqb_trans_out_4;
  var_0["left_crouch_cqb"][6] = % cornercrl_cqb_trans_out_6;
  var_0["left_crouch_cqb"][7] = % cornercrl_cqb_trans_out_7;
  var_0["left_crouch_cqb"][8] = % cornercrl_cqb_trans_out_8;
  var_0["crouch"][1] = % covercrouch_run_out_ml;
  var_0["crouch"][2] = % covercrouch_run_out_m;
  var_0["crouch"][3] = % covercrouch_run_out_mr;
  var_0["crouch"][4] = % covercrouch_run_out_l;
  var_0["crouch"][6] = % covercrouch_run_out_r;
  var_0["stand"][1] = % coverstand_trans_out_ml;
  var_0["stand"][2] = % coverstand_trans_out_m;
  var_0["stand"][3] = % coverstand_trans_out_mr;
  var_0["stand"][4] = % coverstand_trans_out_l;
  var_0["stand"][6] = % coverstand_trans_out_r;
  var_0["stand_saw"][1] = % saw_gunner_runout_ml;
  var_0["stand_saw"][2] = % saw_gunner_runout_m;
  var_0["stand_saw"][3] = % saw_gunner_runout_mr;
  var_0["stand_saw"][4] = % saw_gunner_runout_l;
  var_0["stand_saw"][6] = % saw_gunner_runout_r;
  var_0["stand_unstable"] = [];
  var_0["stand_unstable"][1] = % lag_unstable_moveforward_exit_1;
  var_0["stand_unstable"][2] = % lag_unstable_moveforward_exit_2;
  var_0["stand_unstable"][3] = % lag_unstable_moveforward_exit_3;
  var_0["stand_unstable"][4] = % lag_unstable_moveforward_exit_4;
  var_0["stand_unstable"][6] = % lag_unstable_moveforward_exit_6;
  var_0["stand_unstable"][7] = % lag_unstable_moveforward_exit_7;
  var_0["stand_unstable"][8] = % lag_unstable_moveforward_exit_8;
  var_0["stand_unstable"][9] = % lag_unstable_moveforward_exit_9;
  var_0["stand_unstable_run"] = [];
  var_0["stand_unstable_run"][1] = % lag_unstable_run_exit_1;
  var_0["stand_unstable_run"][2] = % lag_unstable_run_exit_2;
  var_0["stand_unstable_run"][3] = % lag_unstable_run_exit_3;
  var_0["stand_unstable_run"][4] = % lag_unstable_run_exit_4;
  var_0["stand_unstable_run"][6] = % lag_unstable_run_exit_6;
  var_0["stand_unstable_run"][7] = % lag_unstable_run_exit_7;
  var_0["stand_unstable_run"][8] = % lag_unstable_run_exit_8;
  var_0["stand_unstable_run"][9] = % lag_unstable_run_exit_9;
  var_0["prone_saw"][2] = % saw_gunner_prone_runout_m;
  var_0["prone_saw"][4] = % saw_gunner_prone_runout_l;
  var_0["prone_saw"][6] = % saw_gunner_prone_runout_r;
  var_0["prone_saw"][8] = % saw_gunner_prone_runout_f;
  var_0["crouch_saw"][1] = % saw_gunner_lowwall_runout_ml;
  var_0["crouch_saw"][2] = % saw_gunner_lowwall_runout_m;
  var_0["crouch_saw"][3] = % saw_gunner_lowwall_runout_mr;
  var_0["crouch_saw"][4] = % saw_gunner_lowwall_runout_l;
  var_0["crouch_saw"][6] = % saw_gunner_lowwall_runout_r;
  var_0["exposed"] = [];
  var_0["exposed"][1] = % cqb_start_1;
  var_0["exposed"][2] = % stand_2_run_180l;
  var_0["exposed"][3] = % cqb_start_3;
  var_0["exposed"][4] = % stand_2_run_l;
  var_0["exposed"][6] = % stand_2_run_r;
  var_0["exposed"][7] = % cqb_start_7;
  var_0["exposed"][8] = % surprise_start_v1;
  var_0["exposed"][9] = % cqb_start_9;
  var_0["exposed_smg"] = [];
  var_0["exposed_smg"][1] = % cqb_start_1;
  var_0["exposed_smg"][2] = % smg_stand_2_run_180l;
  var_0["exposed_smg"][3] = % cqb_start_3;
  var_0["exposed_smg"][4] = % smg_stand_2_run_l;
  var_0["exposed_smg"][6] = % smg_stand_2_run_r;
  var_0["exposed_smg"][7] = % cqb_start_7;
  var_0["exposed_smg"][8] = % smg_stand_2_run_f_2;
  var_0["exposed_smg"][9] = % cqb_start_9;
  var_0["exposed_crouch"] = [];
  var_0["exposed_crouch"][1] = % cqb_crouch_start_1;
  var_0["exposed_crouch"][2] = % crouch_2run_180;
  var_0["exposed_crouch"][3] = % cqb_crouch_start_3;
  var_0["exposed_crouch"][4] = % crouch_2run_l;
  var_0["exposed_crouch"][6] = % crouch_2run_r;
  var_0["exposed_crouch"][7] = % cqb_crouch_start_7;
  var_0["exposed_crouch"][8] = % crouch_2run_f;
  var_0["exposed_crouch"][9] = % cqb_crouch_start_9;
  var_0["exposed_crouch_crouchwalk"] = [];
  var_0["exposed_crouch_crouchwalk"][1] = % crouchwalk_2_crouch_start_1;
  var_0["exposed_crouch_crouchwalk"][2] = % crouchwalk_2_crouch_start_2;
  var_0["exposed_crouch_crouchwalk"][3] = % crouchwalk_2_crouch_start_3;
  var_0["exposed_crouch_crouchwalk"][4] = % crouchwalk_2_crouch_start_4;
  var_0["exposed_crouch_crouchwalk"][6] = % crouchwalk_2_crouch_start_6;
  var_0["exposed_crouch_crouchwalk"][7] = % crouchwalk_2_crouch_start_7;
  var_0["exposed_crouch_crouchwalk"][8] = % crouchwalk_2_crouch_start_8;
  var_0["exposed_crouch_crouchwalk"][9] = % crouchwalk_2_crouch_start_9;
  var_0["exposed_cqb"] = [];
  var_0["exposed_cqb"][1] = % cqb_start_1;
  var_0["exposed_cqb"][2] = % cqb_start_2;
  var_0["exposed_cqb"][3] = % cqb_start_3;
  var_0["exposed_cqb"][4] = % cqb_start_4;
  var_0["exposed_cqb"][6] = % cqb_start_6;
  var_0["exposed_cqb"][7] = % cqb_start_7;
  var_0["exposed_cqb"][8] = % cqb_start_8;
  var_0["exposed_cqb"][9] = % cqb_start_9;
  var_0["exposed_crouch_cqb"] = [];
  var_0["exposed_crouch_cqb"][1] = % cqb_crouch_start_1;
  var_0["exposed_crouch_cqb"][2] = % cqb_crouch_start_2;
  var_0["exposed_crouch_cqb"][3] = % cqb_crouch_start_3;
  var_0["exposed_crouch_cqb"][4] = % cqb_crouch_start_4;
  var_0["exposed_crouch_cqb"][6] = % cqb_crouch_start_6;
  var_0["exposed_crouch_cqb"][7] = % cqb_crouch_start_7;
  var_0["exposed_crouch_cqb"][8] = % cqb_crouch_start_8;
  var_0["exposed_crouch_cqb"][9] = % cqb_crouch_start_9;
  var_0["exposed_unstable"] = [];
  var_0["exposed_unstable"][1] = % lag_unstable_moveforward_exit_1;
  var_0["exposed_unstable"][2] = % lag_unstable_moveforward_exit_2;
  var_0["exposed_unstable"][3] = % lag_unstable_moveforward_exit_3;
  var_0["exposed_unstable"][4] = % lag_unstable_moveforward_exit_4;
  var_0["exposed_unstable"][6] = % lag_unstable_moveforward_exit_6;
  var_0["exposed_unstable"][7] = % lag_unstable_moveforward_exit_7;
  var_0["exposed_unstable"][8] = % lag_unstable_moveforward_exit_8;
  var_0["exposed_unstable"][9] = % lag_unstable_moveforward_exit_9;
  var_0["exposed_unstable_run"] = [];
  var_0["exposed_unstable_run"][1] = % lag_unstable_run_exit_1;
  var_0["exposed_unstable_run"][2] = % lag_unstable_run_exit_2;
  var_0["exposed_unstable_run"][3] = % lag_unstable_run_exit_3;
  var_0["exposed_unstable_run"][4] = % lag_unstable_run_exit_4;
  var_0["exposed_unstable_run"][6] = % lag_unstable_run_exit_6;
  var_0["exposed_unstable_run"][7] = % lag_unstable_run_exit_7;
  var_0["exposed_unstable_run"][8] = % lag_unstable_run_exit_8;
  var_0["exposed_unstable_run"][9] = % lag_unstable_run_exit_9;
  var_0["heat"] = [];
  var_0["heat"][1] = % heat_exit_1;
  var_0["heat"][2] = % heat_exit_2;
  var_0["heat"][3] = % heat_exit_3;
  var_0["heat"][4] = % heat_exit_4;
  var_0["heat"][6] = % heat_exit_6;
  var_0["heat"][7] = % heat_exit_7;
  var_0["heat"][8] = % heat_exit_8;
  var_0["heat"][9] = % heat_exit_9;
  var_0["heat_left"] = [];
  var_0["heat_left"][1] = % heat_exit_1;
  var_0["heat_left"][2] = % heat_exit_2;
  var_0["heat_left"][3] = % heat_exit_3;
  var_0["heat_left"][4] = % heat_exit_4;
  var_0["heat_left"][6] = % heat_exit_6;
  var_0["heat_left"][7] = % heat_exit_8l;
  var_0["heat_left"][8] = % heat_exit_8l;
  var_0["heat_left"][9] = % heat_exit_8r;
  var_0["heat_right"] = [];
  var_0["heat_right"][1] = % heat_exit_1;
  var_0["heat_right"][2] = % heat_exit_2;
  var_0["heat_right"][3] = % heat_exit_3;
  var_0["heat_right"][4] = % heat_exit_4;
  var_0["heat_right"][6] = % heat_exit_6;
  var_0["heat_right"][7] = % heat_exit_8l;
  var_0["heat_right"][8] = % heat_exit_8r;
  var_0["heat_right"][9] = % heat_exit_8r;
  var_0["prone"] = [];
  var_0["prone"][1] = % h1_crawlstart_l90;
  var_0["prone"][2] = % h1_crawlstart_180;
  var_0["prone"][3] = % h1_crawlstart_180;
  var_0["prone"][4] = % h1_crawlstart_l90;
  var_0["prone"][6] = % h1_crawlstart_r90;
  var_0["prone"][7] = % h1_crawlstart_l45;
  var_0["prone"][8] = % h1_crawlstart_f_codemove;
  var_0["prone"][9] = % h1_crawlstart_r45;
  anim.archetypes["soldier"]["cover_exit"] = var_0;
}

getmoveend(var_0) {
  var_1 = 0.5;
  var_2 = 0;
  var_3 = 1;
  var_4 = 0.05;

  for (var_5 = getanimlength(var_0);
    (var_3 - var_2) * var_5 > var_4; var_1 = (var_3 - var_2) / 2 + var_2) {
    var_6 = getmovedelta(var_0, var_1, 1);

    if(length2dsquared(var_6) < 1) {
      var_3 = var_1;
      continue;
    }

    var_2 = var_1;
  }

  return var_3;
}

inittransdistandanglesforarchetype(var_0) {
  if(!isdefined(anim.archetypes[var_0])) {
    return;
  }
  var_1 = [];
  var_1[0] = "left";
  var_1[1] = "right";
  var_1[2] = "left_crouch";
  var_1[3] = "right_crouch";
  var_1[4] = "crouch";
  var_1[5] = "stand";
  var_1[6] = "exposed";
  var_1[7] = "exposed_crouch";
  var_1[8] = "stand_saw";
  var_1[9] = "prone_saw";
  var_1[10] = "crouch_saw";
  var_1[11] = "wall_over_40";
  var_1[12] = "right_cqb";
  var_1[13] = "right_crouch_cqb";
  var_1[14] = "left_cqb";
  var_1[15] = "left_crouch_cqb";
  var_1[16] = "exposed_cqb";
  var_1[17] = "exposed_crouch_cqb";
  var_1[18] = "heat";
  var_1[19] = "heat_left";
  var_1[20] = "heat_right";
  var_1[21] = "exposed_ready";
  var_1[22] = "exposed_ready_cqb";
  var_1[23] = "exposed_smg";
  var_1[24] = "exposed_unstable";
  var_1[25] = "stand_unstable";
  var_1[26] = "exposed_unstable_run";
  var_1[27] = "stand_unstable_run";
  var_1[28] = "exposed_crouch_crouchwalk";
  var_1[29] = "prone";

  if(!isdefined(anim.archetypes[var_0]["cover_trans"])) {
    return;
  }
  for (var_2 = 1; var_2 <= 6; var_2++) {
    if(var_2 == 5) {
      continue;
    }
    for (var_3 = 0; var_3 < var_1.size; var_3++) {
      var_4 = var_1[var_3];

      if(isdefined(anim.archetypes[var_0]["cover_trans"][var_4]) && isdefined(anim.archetypes[var_0]["cover_trans"][var_4][var_2])) {
        anim.archetypes[var_0]["cover_trans_dist"][var_4][var_2] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_4][var_2], 0, 1);
        anim.archetypes[var_0]["cover_trans_angles"][var_4][var_2] = getangledelta(anim.archetypes[var_0]["cover_trans"][var_4][var_2], 0, 1);
        anim.archetypes[var_0]["cover_trans_move_end"][var_4][var_2] = getmoveend(anim.archetypes[var_0]["cover_trans"][var_4][var_2]);
      }

      if(isdefined(anim.archetypes[var_0]["cover_exit"][var_4]) && isdefined(anim.archetypes[var_0]["cover_exit"][var_4][var_2])) {
        if(animhasnotetrack(anim.archetypes[var_0]["cover_exit"][var_4][var_2], "code_move"))
          var_5 = getnotetracktimes(anim.archetypes[var_0]["cover_exit"][var_4][var_2], "code_move")[0];
        else
          var_5 = 1;

        anim.archetypes[var_0]["cover_exit_dist"][var_4][var_2] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_4][var_2], 0, var_5);
        anim.archetypes[var_0]["cover_exit_angles"][var_4][var_2] = getangledelta(anim.archetypes[var_0]["cover_exit"][var_4][var_2], 0, 1);
      }
    }
  }

  if(!isdefined(anim.archetypes[var_0]["CoverTransLongestDist"]))
    anim.archetypes[var_0]["CoverTransLongestDist"] = [];

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];
    anim.archetypes[var_0]["CoverTransLongestDist"][var_4] = 0;

    for (var_2 = 1; var_2 <= 6; var_2++) {
      if(var_2 == 5 || !isdefined(anim.archetypes[var_0]["cover_trans"][var_4]) || !isdefined(anim.archetypes[var_0]["cover_trans"][var_4][var_2])) {
        continue;
      }
      var_6 = lengthsquared(anim.archetypes[var_0]["cover_trans_dist"][var_4][var_2]);

      if(anim.archetypes[var_0]["CoverTransLongestDist"][var_4] < var_6)
        anim.archetypes[var_0]["CoverTransLongestDist"][var_4] = var_6;
    }

    anim.archetypes[var_0]["CoverTransLongestDist"][var_4] = sqrt(anim.archetypes[var_0]["CoverTransLongestDist"][var_4]);
  }

  anim.exposedtransition["exposed"] = 1;
  anim.exposedtransition["exposed_crouch"] = 1;
  anim.exposedtransition["exposed_crouch_crouchwalk"] = 1;
  anim.exposedtransition["exposed_cqb"] = 1;
  anim.exposedtransition["exposed_crouch_cqb"] = 1;
  anim.exposedtransition["exposed_ready_cqb"] = 1;
  anim.exposedtransition["exposed_unstable"] = 1;
  anim.exposedtransition["exposed_unstable_run"] = 1;
  anim.exposedtransition["exposed_ready"] = 1;
  anim.exposedtransition["exposed_smg"] = 1;
  anim.exposedtransition["heat"] = 1;

  if(!isdefined(anim.archetypes[var_0]["longestExposedApproachDist"]))
    anim.archetypes[var_0]["longestExposedApproachDist"] = 0;

  foreach(var_4, var_8 in anim.exposedtransition) {
    for (var_2 = 7; var_2 <= 9; var_2++) {
      if(isdefined(anim.archetypes[var_0]["cover_trans"][var_4]) && isdefined(anim.archetypes[var_0]["cover_trans"][var_4][var_2])) {
        anim.archetypes[var_0]["cover_trans_dist"][var_4][var_2] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_4][var_2], 0, 1);
        anim.archetypes[var_0]["cover_trans_angles"][var_4][var_2] = getangledelta(anim.archetypes[var_0]["cover_trans"][var_4][var_2], 0, 1);
        anim.archetypes[var_0]["cover_trans_move_end"][var_4][var_2] = getmoveend(anim.archetypes[var_0]["cover_trans"][var_4][var_2]);
      }

      if(isdefined(anim.archetypes[var_0]["cover_exit"][var_4]) && isdefined(anim.archetypes[var_0]["cover_exit"][var_4][var_2])) {
        var_9 = animhasnotetrack(anim.archetypes[var_0]["cover_exit"][var_4][var_2], "code_move");
        var_5 = getnotetracktimes(anim.archetypes[var_0]["cover_exit"][var_4][var_2], "code_move")[0];
        anim.archetypes[var_0]["cover_exit_dist"][var_4][var_2] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_4][var_2], 0, var_5);
        anim.archetypes[var_0]["cover_exit_angles"][var_4][var_2] = getangledelta(anim.archetypes[var_0]["cover_exit"][var_4][var_2], 0, 1);
      }
    }

    for (var_2 = 1; var_2 <= 9; var_2++) {
      if(!isdefined(anim.archetypes[var_0]["cover_trans"][var_4]) || !isdefined(anim.archetypes[var_0]["cover_trans"][var_4][var_2])) {
        continue;
      }
      var_10 = length(anim.archetypes[var_0]["cover_trans_dist"][var_4][var_2]);

      if(var_10 > anim.archetypes[var_0]["longestExposedApproachDist"])
        anim.archetypes[var_0]["longestExposedApproachDist"] = var_10;
    }
  }
}

initmovestartstoptransitions() {
  init_move_transition_arrays();
  anim.approach_types = [];
  anim.approach_types["Cover Left"] = [];
  anim.approach_types["Cover Left"]["stand"] = "left";
  anim.approach_types["Cover Left"]["crouch"] = "left_crouch";
  anim.approach_types["Cover Wide Left"] = anim.approach_types["Cover Left"];
  anim.maxdirections["Cover Left"] = 9;
  anim.excludedir["Cover Left"] = 9;
  anim.approach_types["Cover Right"] = [];
  anim.approach_types["Cover Right"]["stand"] = "right";
  anim.approach_types["Cover Right"]["crouch"] = "right_crouch";
  anim.approach_types["Cover Wide Right"] = anim.approach_types["Cover Right"];
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
  anim.approach_types["Guard"]["prone"] = "prone";
  anim.approach_types["Ambush"] = anim.approach_types["Path"];
  anim.approach_types["Scripted"] = anim.approach_types["Path"];
  anim.approach_types["Exposed"] = anim.approach_types["Path"];
  anim.iscombatpathnode["Guard"] = 1;
  anim.iscombatpathnode["Ambush"] = 1;
  anim.iscombatpathnode["Exposed"] = 1;
  anim.iscombatscriptnode["Guard"] = 1;
  anim.iscombatscriptnode["Exposed"] = 1;
  initsoldierentrance();
  initsoldierexit();

  if(maps\_utility::s1_motionset_avaliable()) {
    animscripts\s1_common_anims::initsoliders1entrance();
    animscripts\s1_common_anims::initsoliders1exit();
  }

  inittransdistandanglesforarchetype("soldier");

  if(maps\_utility::s1_motionset_avaliable())
    inittransdistandanglesforarchetype("s1_soldier");

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

  if(maps\_utility::s1_motionset_avaliable())
    getsplittimes("s1_soldier");

  anim.arrivalendstance["left"] = "stand";
  anim.arrivalendstance["left_cqb"] = "stand";
  anim.arrivalendstance["right"] = "stand";
  anim.arrivalendstance["right_cqb"] = "stand";
  anim.arrivalendstance["stand"] = "stand";
  anim.arrivalendstance["stand_saw"] = "stand";
  anim.arrivalendstance["stand_unstable"] = "stand";
  anim.arrivalendstance["exposed"] = "stand";
  anim.arrivalendstance["exposed_cqb"] = "stand";
  anim.arrivalendstance["exposed_smg"] = "stand";
  anim.arrivalendstance["exposed_unstable"] = "stand";
  anim.arrivalendstance["exposed_unstable_run"] = "stand";
  anim.arrivalendstance["heat"] = "stand";
  anim.arrivalendstance["left_crouch"] = "crouch";
  anim.arrivalendstance["left_crouch_cqb"] = "crouch";
  anim.arrivalendstance["right_crouch"] = "crouch";
  anim.arrivalendstance["right_crouch_cqb"] = "crouch";
  anim.arrivalendstance["crouch_saw"] = "crouch";
  anim.arrivalendstance["crouch"] = "crouch";
  anim.arrivalendstance["exposed_crouch"] = "crouch";
  anim.arrivalendstance["exposed_crouch_crouchwalk"] = "crouch";
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

getsplitdeltas(var_0, var_1) {
  var_2 = 1;

  if(animhasnotetrack(var_0, "code_move"))
    var_2 = getnotetracktimes(var_0, "code_move")[0];

  var_3 = spawnstruct();
  var_3.predist = getmovedelta(var_0, 0, var_1);
  var_3.postdist = getmovedelta(var_0, 0, var_2) - var_3.predist;
  var_3.angledelta = getangledelta(var_0, 0, 1);
  return var_3;
}

getsplittimesside(var_0, var_1, var_2, var_3, var_4, var_5) {
  for (var_6 = var_1; var_6 <= var_2; var_6++) {
    if(isdefined(anim.archetypes[var_0]["cover_trans"])) {
      foreach(var_11, var_8 in var_4) {
        if(issubstr(var_11, "heat")) {
          continue;
        }
        if(isdefined(anim.archetypes[var_0]["cover_trans"][var_11]) && isdefined(anim.archetypes[var_0]["cover_trans"][var_11][var_6])) {
          var_9 = findbestsplittime(anim.archetypes[var_0]["cover_trans"][var_11][var_6], 1, var_3);
          var_10 = getsplitdeltas(anim.archetypes[var_0]["cover_trans"][var_11][var_6], var_9);
          anim.archetypes[var_0]["cover_trans_predist"][var_11][var_6] = var_10.predist;
          anim.archetypes[var_0]["cover_trans_dist"][var_11][var_6] = var_10.postdist;
          anim.archetypes[var_0]["cover_trans_angles"][var_11][var_6] = var_10.angledelta;
          anim.archetypes[var_0]["cover_trans_move_end"][var_11][var_6] = getmoveend(anim.archetypes[var_0]["cover_trans"][var_11][var_6]);
        }
      }
    }

    if(isdefined(anim.archetypes[var_0]["cover_exit"])) {
      foreach(var_11, var_8 in var_5) {
        if(issubstr(var_11, "heat")) {
          continue;
        }
        if(isdefined(anim.archetypes[var_0]["cover_exit"][var_11]) && isdefined(anim.archetypes[var_0]["cover_exit"][var_11][var_6])) {
          var_9 = findbestsplittime(anim.archetypes[var_0]["cover_exit"][var_11][var_6], 0, var_3);
          var_10 = getsplitdeltas(anim.archetypes[var_0]["cover_exit"][var_11][var_6], var_9);
          anim.archetypes[var_0]["cover_exit_dist"][var_11][var_6] = var_10.predist;
          anim.archetypes[var_0]["cover_exit_postdist"][var_11][var_6] = var_10.postdist;
          anim.archetypes[var_0]["cover_exit_angles"][var_11][var_6] = var_10.angledelta;
        }
      }
    }
  }
}

findbestsplittime(var_0, var_1, var_2) {
  var_3 = getangledelta(var_0, 0, 1);
  var_4 = getmovedelta(var_0, 0, 1);
  var_5 = 1000;
  var_6 = -1;
  var_7 = -100000000;
  var_8 = (0, 0, 0);

  for (var_9 = 0; var_9 < var_5; var_9++) {
    var_10 = 1.0 * var_9 / (var_5 - 1);
    var_11 = getmovedelta(var_0, 0, var_10);

    if(var_1)
      var_11 = deltarotate(var_4 - var_11, 180 - var_3);

    if(var_2)
      var_11 = (var_11[0], 0 - var_11[1], var_11[2]);

    var_12 = min(var_11[0] - 32, var_11[1]);

    if(var_12 > var_7 || var_6 < 0) {
      var_7 = var_12;
      var_6 = var_10;
      var_8 = var_11;
    }
  }

  return var_6;
}

deltarotate(var_0, var_1) {
  var_2 = cos(var_1);
  var_3 = sin(var_1);
  return (var_0[0] * var_2 - var_0[1] * var_3, var_0[1] * var_2 + var_0[0] * var_3, 0);
}