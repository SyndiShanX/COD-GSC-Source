/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include animscripts\anims_table_wounded;
#include animscripts\anims_table_rusher;
#include animscripts\anims_table_cqb;
#include animscripts\anims_table_pistol;
#include animscripts\anims_table_smg;
#include animscripts\anims_table_shotgun;
#include animscripts\anims_table_traverse;
#include animscripts\ai_subclass\anims_table_elite;
#include animscripts\anims_table_civilian;
#include animscripts\anims_table_vc;
#include animscripts\anims_table_digbats;
#include animscripts\anims_table_mpla;
#include animscripts\anims_table_spetsnaz;
#include animscripts\anims;
#include animscripts\anims_table;

setup_anims() {
  if(!isDefined(anim.anim_array)) {
    anim.anim_array = [];
    anim.pre_move_delta_array = [];
    anim.move_delta_array = [];
    anim.post_move_delta_array = [];
    anim.angle_delta_array = [];
    anim.notetrack_array = [];
    anim.longestexposedapproachdist = [];
    anim.longestapproachdist = [];
    setup_cover_trans_split_array();
    setup_anim_array("default");
    thread precache_grenade_offsets();
  }
}

setup_cover_trans_split_array() {
  anim.covertranssplit = [];
  anim.covertranspistolsplit = [];
  anim.covertranssplit["arrive_left"][7] = 0.212212;
  anim.covertranssplit["arrive_left_crouch"][7] = 0.319319;
  anim.covertranssplit["exit_left"][7] = 0.646647;
  anim.covertranssplit["exit_left_crouch"][7] = 0.554555;
  anim.covertranssplit["arrive_left"][8] = 0.272272;
  anim.covertranssplit["arrive_left_crouch"][8] = 0.437437;
  anim.covertranssplit["exit_left"][8] = 0.677678;
  anim.covertranssplit["exit_left_crouch"][8] = 0.451451;
  anim.covertranssplit["arrive_right"][8] = 0.38038;
  anim.covertranssplit["arrive_right_crouch"][8] = 0.248248;
  anim.covertranssplit["exit_right"][8] = 0.626627;
  anim.covertranssplit["exit_right_crouch"][8] = 0.545546;
  anim.covertranssplit["arrive_right"][9] = 0.401401;
  anim.covertranssplit["arrive_right_crouch"][9] = 0.2002;
  anim.covertranssplit["exit_right"][9] = 0.694695;
  anim.covertranssplit["exit_right_crouch"][9] = 0.493493;
  anim.covertranssplit["arrive_left_cqb"][7] = 0.451451;
  anim.covertranssplit["arrive_left_crouch_cqb"][7] = 0.205205;
  anim.covertranssplit["exit_left_cqb"][7] = 0.702703;
  anim.covertranssplit["exit_left_crouch_cqb"][7] = 0.718719;
  anim.covertranssplit["arrive_left_cqb"][8] = 0.479479;
  anim.covertranssplit["arrive_left_crouch_cqb"][8] = 0.286286;
  anim.covertranssplit["exit_left_cqb"][8] = 0.439439;
  anim.covertranssplit["exit_left_crouch_cqb"][8] = 0.621622;
  anim.covertranssplit["arrive_right_cqb"][8] = 0.255255;
  anim.covertranssplit["arrive_right_crouch_cqb"][8] = 0.311311;
  anim.covertranssplit["exit_right_cqb"][8] = 0.540541;
  anim.covertranssplit["exit_right_crouch_cqb"][8] = 0.399399;
  anim.covertranssplit["arrive_right_cqb"][9] = 0.16016;
  anim.covertranssplit["arrive_right_crouch_cqb"][9] = 0.232232;
  anim.covertranssplit["exit_right_cqb"][9] = 0.561562;
  anim.covertranssplit["exit_right_crouch_cqb"][9] = 0.518519;
  anim.covertranssplit["arrive_pillar"][7] = 0.222222;
  anim.covertranssplit["arrive_pillar_crouch"][7] = 0.129032;
  anim.covertranssplit["exit_pillar"][7] = 0.571429;
  anim.covertranssplit["exit_pillar_crouch"][7] = 0.666667;
  anim.covertranssplit["arrive_pillar"][8] = 0.365385;
  anim.covertranssplit["arrive_pillar_crouch"][8] = 0.242424;
  anim.covertranssplit["exit_pillar"][8] = 0.622642;
  anim.covertranssplit["exit_pillar_crouch"][8] = 0.6;
  anim.covertranssplit["arrive_pillar"][9] = 0.283333;
  anim.covertranssplit["arrive_pillar_crouch"][9] = 0.206897;
  anim.covertranssplit["exit_pillar"][9] = 0.5625;
  anim.covertranssplit["exit_pillar_crouch"][9] = 0.461538;
  anim.covertranspistolsplit["arrive_left"][7] = 0.428571;
  anim.covertranspistolsplit["arrive_left_crouch"][7] = 0.309859;
  anim.covertranspistolsplit["exit_left"][7] = 0.5;
  anim.covertranspistolsplit["exit_left_crouch"][7] = 0.736737;
  anim.covertranspistolsplit["arrive_left"][8] = 0.446429;
  anim.covertranspistolsplit["arrive_left_crouch"][8] = 0.33033;
  anim.covertranspistolsplit["exit_left"][8] = 0.5;
  anim.covertranspistolsplit["exit_left_crouch"][8] = 0.574575;
  anim.covertranspistolsplit["arrive_right"][8] = 0.386364;
  anim.covertranspistolsplit["arrive_right_crouch"][8] = 0.262295;
  anim.covertranspistolsplit["exit_right"][8] = 0.45098;
  anim.covertranspistolsplit["exit_right_crouch"][8] = 0.436364;
  anim.covertranspistolsplit["arrive_right"][9] = 0.482143;
  anim.covertranspistolsplit["arrive_right_crouch"][9] = 0.3125;
  anim.covertranspistolsplit["exit_right"][9] = 0.45098;
  anim.covertranspistolsplit["exit_right_crouch"][9] = 0.477273;

  if(!isDefined(level.script)) {
    return;
  }
  if(!issubstr(level.script, "ai_") && !issubstr(level.script, "challenge_") && !issubstr(level.script, "module_cov")) {
    return;
  }
  cover_trans_splits_set_anims();
  cover_trans_splits_calculate_offsets();
}

#using_animtree("generic_human");

cover_trans_splits_set_anims() {
  anim.covertrans = [];
  anim.coverexit = [];
  anim.covertrans["exit_left"][7] = % corner_standl_trans_out_7;
  anim.covertrans["exit_left"][8] = % corner_standl_trans_out_8;
  anim.covertrans["exit_left"][9] = undefined;
  anim.covertrans["exit_left_cqb"][7] = % corner_standl_trans_cqb_out_7;
  anim.covertrans["exit_left_cqb"][8] = % corner_standl_trans_cqb_out_8;
  anim.covertrans["exit_left_cqb"][9] = undefined;
  anim.covertrans["exit_left_crouch"][7] = % cornercrl_trans_out_mf;
  anim.covertrans["exit_left_crouch"][8] = % cornercrl_trans_out_f;
  anim.covertrans["exit_left_crouch"][9] = undefined;
  anim.covertrans["exit_left_crouch_cqb"][7] = % cornercrl_cqb_trans_out_7;
  anim.covertrans["exit_left_crouch_cqb"][8] = % cornercrl_cqb_trans_out_8;
  anim.covertrans["exit_left_crouch_cqb"][9] = undefined;
  anim.covertrans["exit_right"][8] = % corner_standr_trans_out_8;
  anim.covertrans["exit_right"][9] = % corner_standr_trans_out_9;
  anim.covertrans["exit_right"][7] = undefined;
  anim.covertrans["exit_right_cqb"][8] = % corner_standr_trans_cqb_out_8;
  anim.covertrans["exit_right_cqb"][9] = % corner_standr_trans_cqb_out_9;
  anim.covertrans["exit_right_cqb"][7] = undefined;
  anim.covertrans["exit_right_crouch"][8] = % cornercrr_trans_out_f;
  anim.covertrans["exit_right_crouch"][9] = % cornercrr_trans_out_mf;
  anim.covertrans["exit_right_crouch"][7] = undefined;
  anim.covertrans["exit_right_crouch_cqb"][8] = % cornercrr_cqb_trans_out_8;
  anim.covertrans["exit_right_crouch_cqb"][9] = % cornercrr_cqb_trans_out_9;
  anim.covertrans["exit_right_crouch_cqb"][7] = undefined;
  anim.covertrans["exit_pillar"][7] = % ai_pillar2_stand_exit_7;
  anim.covertrans["exit_pillar"][8] = % ai_pillar2_stand_exit_8r;
  anim.covertrans["exit_pillar"][9] = % ai_pillar2_stand_exit_9;
  anim.covertrans["exit_pillar_crouch"][7] = % ai_pillar2_crouch_exit_7;
  anim.covertrans["exit_pillar_crouch"][8] = % ai_pillar2_crouch_exit_8r;
  anim.covertrans["exit_pillar_crouch"][9] = % ai_pillar2_crouch_exit_9;
  anim.covertrans["arrive_left"][7] = % corner_standl_trans_in_7;
  anim.covertrans["arrive_left"][8] = % corner_standl_trans_in_8;
  anim.covertrans["arrive_left"][9] = undefined;
  anim.covertrans["arrive_left_cqb"][7] = % corner_standl_trans_cqb_in_7;
  anim.covertrans["arrive_left_cqb"][8] = % corner_standl_trans_cqb_in_8;
  anim.covertrans["arrive_left_cqb"][9] = undefined;
  anim.covertrans["arrive_left_crouch"][7] = % cornercrl_trans_in_mf;
  anim.covertrans["arrive_left_crouch"][8] = % cornercrl_trans_in_f;
  anim.covertrans["arrive_left_crouch"][9] = undefined;
  anim.covertrans["arrive_left_crouch_cqb"][7] = % cornercrl_cqb_trans_in_7;
  anim.covertrans["arrive_left_crouch_cqb"][8] = % cornercrl_cqb_trans_in_8;
  anim.covertrans["arrive_left_crouch_cqb"][9] = undefined;
  anim.covertrans["arrive_right"][8] = % corner_standr_trans_in_8;
  anim.covertrans["arrive_right"][9] = % corner_standr_trans_in_9;
  anim.covertrans["arrive_right"][7] = undefined;
  anim.covertrans["arrive_right_cqb"][8] = % corner_standr_trans_cqb_in_8;
  anim.covertrans["arrive_right_cqb"][9] = % corner_standr_trans_cqb_in_9;
  anim.covertrans["arrive_right_cqb"][7] = undefined;
  anim.covertrans["arrive_right_crouch"][8] = % cornercrr_trans_in_f;
  anim.covertrans["arrive_right_crouch"][9] = % cornercrr_trans_in_mf;
  anim.covertrans["arrive_right_crouch"][7] = undefined;
  anim.covertrans["arrive_right_crouch_cqb"][8] = % cornercrr_cqb_trans_in_8;
  anim.covertrans["arrive_right_crouch_cqb"][9] = % cornercrr_cqb_trans_in_9;
  anim.covertrans["arrive_right_crouch_cqb"][7] = undefined;
  anim.covertrans["arrive_pillar"][7] = % ai_pillar2_stand_arrive_7;
  anim.covertrans["arrive_pillar"][8] = % ai_pillar2_stand_arrive_8r;
  anim.covertrans["arrive_pillar"][9] = % ai_pillar2_stand_arrive_9;
  anim.covertrans["arrive_pillar_crouch"][7] = % ai_pillar2_crouch_arrive_7;
  anim.covertrans["arrive_pillar_crouch"][8] = % ai_pillar2_crouch_arrive_8r;
  anim.covertrans["arrive_pillar_crouch"][9] = % ai_pillar2_crouch_arrive_9;
  anim.covertranspistol["exit_left"][7] = % ai_pistol_cornerstand_left_exit_7;
  anim.covertranspistol["exit_left"][8] = % ai_pistol_cornerstand_left_exit_8;
  anim.covertranspistol["exit_left"][9] = undefined;
  anim.covertranspistol["exit_left_crouch"][7] = % ai_pistol_cornercrouch_left_exit_7;
  anim.covertranspistol["exit_left_crouch"][8] = % ai_pistol_cornercrouch_left_exit_8;
  anim.covertranspistol["exit_left_crouch"][9] = undefined;
  anim.covertranspistol["exit_right"][8] = % ai_pistol_cornerstand_right_exit_8;
  anim.covertranspistol["exit_right"][9] = % ai_pistol_cornerstand_right_exit_9;
  anim.covertranspistol["exit_right"][7] = undefined;
  anim.covertranspistol["exit_right_crouch"][8] = % ai_pistol_cornercrouch_right_exit_8;
  anim.covertranspistol["exit_right_crouch"][9] = % ai_pistol_cornercrouch_right_exit_9;
  anim.covertranspistol["exit_right_crouch"][7] = undefined;
  anim.covertranspistol["arrive_left"][7] = % ai_pistol_cornerstand_left_arrive_7;
  anim.covertranspistol["arrive_left"][8] = % ai_pistol_cornerstand_left_arrive_8;
  anim.covertranspistol["arrive_left"][9] = undefined;
  anim.covertranspistol["arrive_left_crouch"][7] = % ai_pistol_cornercrouch_left_arrive_7;
  anim.covertranspistol["arrive_left_crouch"][8] = % ai_pistol_cornercrouch_left_arrive_8;
  anim.covertranspistol["arrive_left_crouch"][9] = undefined;
  anim.covertranspistol["arrive_right"][8] = % ai_pistol_cornerstand_right_arrive_8;
  anim.covertranspistol["arrive_right"][9] = % ai_pistol_cornerstand_right_arrive_9;
  anim.covertranspistol["arrive_right"][7] = undefined;
  anim.covertranspistol["arrive_right_crouch"][8] = % ai_pistol_cornercrouch_right_arrive_8;
  anim.covertranspistol["arrive_right_crouch"][9] = % ai_pistol_cornercrouch_right_arrive_9;
  anim.covertranspistol["arrive_right_crouch"][7] = undefined;
}

cover_trans_splits_calculate_offsets() {
  for(i = 7; i <= 9; i++) {
    findbestsplittime(anim.covertrans["arrive_left"][i], 1, 0, "coverTransSplit", "arrive_left", i, "Regular stand left arrival in dir " + i);
    findbestsplittime(anim.covertrans["arrive_left_crouch"][i], 1, 0, "coverTransSplit", "arrive_left_crouch", i, "Regular crouch arrival exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_left"][i], 0, 0, "coverTransSplit", "exit_left", i, "Regular stand left exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_left_crouch"][i], 0, 0, "coverTransSplit", "exit_left_crouch", i, "Regular crouch left exit in dir " + i);
  }

  for(i = 7; i <= 9; i++) {
    findbestsplittime(anim.covertrans["arrive_right"][i], 1, 1, "coverTransSplit", "arrive_right", i, "Regular stand right arrival in dir " + i);
    findbestsplittime(anim.covertrans["arrive_right_crouch"][i], 1, 1, "coverTransSplit", "arrive_right_crouch", i, "Regular crouch arrival exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_right"][i], 0, 1, "coverTransSplit", "exit_right", i, "Regular stand right exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_right_crouch"][i], 0, 1, "coverTransSplit", "exit_right_crouch", i, "Regular crouch right exit in dir " + i);
  }

  for(i = 7; i <= 9; i++) {
    findbestsplittime(anim.covertrans["arrive_left_cqb"][i], 1, 0, "coverTransSplit", "arrive_left_cqb", i, "CQB stand left arrival in dir " + i);
    findbestsplittime(anim.covertrans["arrive_left_crouch_cqb"][i], 1, 0, "coverTransSplit", "arrive_left_crouch_cqb", i, "CQB crouch left arrival in dir " + i);
    findbestsplittime(anim.covertrans["exit_left_cqb"][i], 0, 0, "coverTransSplit", "exit_left_cqb", i, "CQB stand left exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_left_crouch_cqb"][i], 0, 0, "coverTransSplit", "exit_left_crouch_cqb", i, "CQB crouch left exit in dir " + i);
  }

  for(i = 7; i <= 9; i++) {
    findbestsplittime(anim.covertrans["arrive_right_cqb"][i], 1, 1, "coverTransSplit", "arrive_right_cqb", i, "CQB stand right arrival in dir " + i);
    findbestsplittime(anim.covertrans["arrive_right_crouch_cqb"][i], 1, 1, "coverTransSplit", "arrive_right_crouch_cqb", i, "CQB crouch right arrival in dir " + i);
    findbestsplittime(anim.covertrans["exit_right_cqb"][i], 0, 1, "coverTransSplit", "exit_right_cqb", i, "CQB stand right exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_right_crouch_cqb"][i], 0, 1, "coverTransSplit", "exit_right_crouch_cqb", i, "CQB crouch right exit in dir " + i);
  }

  for(i = 7; i <= 9; i++) {
    isright = i == 9;
    findbestsplittime(anim.covertrans["arrive_pillar"][i], 1, isright, "coverTransSplit", "arrive_pillar", i, "Regular stand pillar arrival in dir " + i);
    findbestsplittime(anim.covertrans["arrive_pillar_crouch"][i], 1, isright, "coverTransSplit", "arrive_pillar_crouch", i, "Regular crouch arrival exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_pillar"][i], 0, isright, "coverTransSplit", "exit_pillar", i, "Regular stand pillar exit in dir " + i);
    findbestsplittime(anim.covertrans["exit_pillar_crouch"][i], 0, isright, "coverTransSplit", "exit_pillar_crouch", i, "Regular crouch pillar exit in dir " + i);
  }

  for(i = 7; i <= 9; i++) {
    findbestsplittime(anim.covertranspistol["arrive_left"][i], 1, 0, "coverTransPistolSplit", "arrive_left", i, "Regular stand left arrival in dir " + i);
    findbestsplittime(anim.covertranspistol["arrive_left_crouch"][i], 1, 0, "coverTransPistolSplit", "arrive_left_crouch", i, "Regular crouch arrival exit in dir " + i);
    findbestsplittime(anim.covertranspistol["exit_left"][i], 0, 0, "coverTransPistolSplit", "exit_left", i, "Regular stand left exit in dir " + i);
    findbestsplittime(anim.covertranspistol["exit_left_crouch"][i], 0, 0, "coverTransPistolSplit", "exit_left_crouch", i, "Regular crouch left exit in dir " + i);
  }

  for(i = 7; i <= 9; i++) {
    findbestsplittime(anim.covertranspistol["arrive_right"][i], 1, 1, "coverTransPistolSplit", "arrive_right", i, "Regular stand right arrival in dir " + i);
    findbestsplittime(anim.covertranspistol["arrive_right_crouch"][i], 1, 1, "coverTransPistolSplit", "arrive_right_crouch", i, "Regular crouch arrival exit in dir " + i);
    findbestsplittime(anim.covertranspistol["exit_right"][i], 0, 1, "coverTransPistolSplit", "exit_right", i, "Regular stand right exit in dir " + i);
    findbestsplittime(anim.covertranspistol["exit_right_crouch"][i], 0, 1, "coverTransPistolSplit", "exit_right_crouch", i, "Regular crouch right exit in dir " + i);
  }
}

findbestsplittime(exitanim, isapproach, isright, arrayname, covertype, index, debugname) {
  if(!isDefined(exitanim)) {
    return;
  }
  temparray = [];
  temparray[exitanim] = "";
  exitanimref = getarraykeys(temparray);

  if(!isassetloaded("xanim", exitanimref[0])) {
    return;
  }
  if(animhasnotetrack(exitanim, "cover_split")) {
    times = getnotetracktimes(exitanim, "cover_split");
    assert(times.size > 0);
    bestsplit = times[0];
    bestdelta = getmovedelta(exitanim, 0, bestsplit);
  } else {
    angledelta = getangledelta(exitanim, 0, 1);
    fulldelta = getmovedelta(exitanim, 0, 1);
    bestsplit = -1;
    bestvalue = -100000000;
    bestdelta = (0, 0, 0);

    for(i = 0; i < 1000; i++) {
      splittime = 1.0 * i / (1000 - 1);
      delta = getmovedelta(exitanim, 0, splittime);

      if(isapproach)
        delta = deltarotate(fulldelta - delta, 180 - angledelta);

      if(isright)
        delta = (delta[0], 0 - delta[1], delta[2]);

      val = min(delta[0] - 32, delta[1]);

      if(val > bestvalue || bestsplit < 0) {
        bestvalue = val;
        bestsplit = splittime;
        bestdelta = delta;
      }
    }
  }

  storereportbestsplittime(arrayname, covertype, index, bestsplit, bestdelta);
}

deltarotate(delta, yaw) {
  cosine = cos(yaw);
  sine = sin(yaw);
  return (delta[0] * cosine - delta[1] * sine, delta[1] * cosine + delta[0] * sine, 0);
}

storereportbestsplittime(arrayname, covertype, index, bestsplit, bestdelta) {
  switch (arrayname) {
    case "coverTransSplit":
      if(anim.covertranssplit[covertype][index] != bestsplit)
        assertmsg("bestsplit needs to updated - anim." + arrayname + "[" + covertype + "]" + "[" + index + "]" + " = " + bestsplit + "; // delta of " + bestdelta);

      anim.covertranssplit[covertype][index] = bestsplit;
      break;
    case "coverTransPistolSplit":
      if(anim.covertranspistolsplit[covertype][index] != bestsplit)
        assertmsg("bestsplit needs to updated - anim." + arrayname + "[" + covertype + "]" + "[" + index + "]" + " = " + bestsplit + "; // delta of " + bestdelta);

      anim.covertranspistolsplit[covertype][index] = bestsplit;
      break;
    default:
      assertmsg("Unsupported split array" + arrayname);
  }
}

precache_grenade_offsets() {
  anim.grenadethrowoffsets = [];
  anim.grenadethrowoffsets[%exposed_grenadethrowb] = (48.127, 8.66658, 62.6563);
  anim.grenadethrowoffsets[%exposed_grenadethrowc] = (43.9185, -7.85788, 72.4854);
  anim.grenadethrowoffsets[%corner_standl_grenade_a] = (41.5929, 7.04226, 81.4802);
  anim.grenadethrowoffsets[%corner_standl_grenade_b] = (24.6666, -21.229, 30.6775);
  anim.grenadethrowoffsets[%cornercrl_grenadea] = (36.3435, -10.3157, 25.8047);
  anim.grenadethrowoffsets[%cornercrl_grenadeb] = (36.3435, -10.3157, 25.8047);
  anim.grenadethrowoffsets[%corner_standr_grenade_a] = (44.0309, 3.34701, 68.9354);
  anim.grenadethrowoffsets[%corner_standr_grenade_b] = (18.8496, 16.8684, 19.2463);
  anim.grenadethrowoffsets[%cornercrr_grenadea] = (21.1237, 17.7824, 35.9941);
  anim.grenadethrowoffsets[%covercrouch_grenadea] = (6.92447, 3.03754, 51.5144);
  anim.grenadethrowoffsets[%covercrouch_grenadeb] = (6.92447, 3.03754, 51.5144);
  anim.grenadethrowoffsets[%coverstand_grenadea] = (10.8551, 7.13628, 77.2373);
  anim.grenadethrowoffsets[%coverstand_grenadeb] = (21.1432, 4.86387, 67.3774);
  anim.grenadethrowoffsets[%prone_grenade_a] = (14.9, 1.91703, 29.3096);
  anim.grenadethrowoffsets[%ai_pillar2_stand_idle_grenade_throw_l_01] = (-15.3955, 20.6589, 76.7344);
  anim.grenadethrowoffsets[%ai_pillar2_stand_idle_grenade_throw_l_02] = (-25.0749, 30.8319, 27.4131);
  anim.grenadethrowoffsets[%ai_pillar2_stand_idle_grenade_throw_r_01] = (-0.791503, -23.5507, 36.9277);
  anim.grenadethrowoffsets[%ai_pillar2_stand_idle_grenade_throw_r_02] = (-5.24283, -28.9155, 25.3848);
  anim.grenadethrowoffsets[%ai_pillar2_crouch_idle_grenade_throw_r_01] = (-9.50442, -25.3984, 53.2455);
  anim.grenadethrowoffsets[%ai_pillar2_crouch_idle_grenade_throw_r_02] = (-12.6333, -26.9437, 18.0996);
  anim.grenadethrowoffsets[%ai_pillar2_crouch_idle_grenade_throw_l_01] = (-18.9507, 30.8524, 50.165);
  anim.grenadethrowoffsets[%ai_pillar2_crouch_idle_grenade_throw_l_02] = (-22.1084, 29.8795, 23.4297);
  anim.grenadethrowoffsets[%ai_militia_corner_standl_grenade] = (19.0969, -18.5724, 50.7656);
  anim.grenadethrowoffsets[%ai_militia_corner_standr_grenade] = (35.1794, 23.2719, 53.834);
  anim.grenadethrowoffsets[%ai_militia_cover_crouch_grenadefirea] = (8.83686, -4.33515, 50.0801);
  anim.grenadethrowoffsets[%ai_militia_cover_stand_grenadefirea] = (-0.59787, -17.7311, 27.6133);
  anim.grenadethrowoffsets[%ai_stand_exposed_grenade_throwa] = (25.5368, -4.59055, 82.0342);
  anim.grenadethrowoffsets[%ai_digbat_exposed_grenadethrowb] = (17.9853, -7.97144, 80.4746);
  anim.grenadethrowoffsets[%ai_elite_exposed_grenadethrow_a] = (36.1882, -0.891218, 81.5117);

  if(!isDefined(level.script)) {
    return;
  }
  if(!issubstr(level.script, "ai_") && level.script != "module_covernodes") {
    return;
  }
  wait 2;
  tempmodel = spawn("script_model", vectorscale((0, 0, -1), 9999.0));
  tempmodel setModel("defaultactor");
  tempmodel useanimtree(#animtree);
  tempmodel hide();
  recordent(tempmodel);
  grenadeanims = getarraykeys(anim.grenadethrowoffsets);

  foreach(throwanimname in grenadeanims) {
    forward = anglesToForward(tempmodel.angles);
    right = anglestoright(tempmodel.angles);
    startpos = tempmodel.origin;
    throwanim = findanimbyname("generic_human", throwanimname);

    if(!isDefined(throwanim) || !isanimleaf(throwanim) || !isassetloaded("xanim", throwanimname)) {
      continue;
    }
    tempmodel animscripted("grenadetest", tempmodel.origin, tempmodel.angles, throwanim, "normal", %root, 1.0);

    for(;;) {
      tempmodel waittill("grenadetest", notetrack);

      if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
        break;
      }

      assert(notetrack != "end", "Grenade throwing anim " + throwanimname + " has no grenade_throw notetrack");

      if(notetrack == "end") {
        break;
      }
    }

    pos = tempmodel gettagorigin("tag_inhand");
    baseoffset = pos - startpos;
    offset = (vectordot(baseoffset, forward), -1 * vectordot(baseoffset, right), baseoffset[2]);
    endpos = startpos + forward * offset[0] - right * offset[1] + (0, 0, 1) * offset[2];
    assert(distancesquared(anim.grenadethrowoffsets[throwanim], offset) < 1, "Grenade offset for anim " + throwanimname + " doesn't match. Update precache_grenade_offsets with (" + offset[0] + ", " + offset[1] + ", " + offset[2] + ")");
    anim.grenadethrowoffsets[throwanim] = offset;
  }

  wait 0.2;
  tempmodel delete();
}

setup_delta_arrays(source_array, dest) {
  assert(isDefined(source_array));
  assert(source_array.size > 0);
  assert(isDefined(dest.pre_move_delta_array) && isarray(dest.pre_move_delta_array));
  assert(isDefined(dest.move_delta_array) && isarray(dest.move_delta_array));
  assert(isDefined(dest.post_move_delta_array) && isarray(dest.post_move_delta_array));
  assert(isDefined(dest.angle_delta_array) && isarray(dest.angle_delta_array));
  assert(isDefined(dest.notetrack_array) && isarray(dest.notetrack_array));
  assert(isDefined(dest.longestexposedapproachdist) && isarray(dest.longestexposedapproachdist));
  assert(isDefined(dest.longestapproachdist) && isarray(dest.longestapproachdist));
  animtypekeys = getarraykeys(source_array);

  for(animtypeindex = 0; animtypeindex < animtypekeys.size; animtypeindex++) {
    animtype = animtypekeys[animtypeindex];
    animtype_array = source_array[animtype];

    if(isarray(animtype_array) && isDefined(animtype_array["move"])) {
      script_array = animtype_array["move"];
      posekeys = getarraykeys(script_array);

      for(poseindex = 0; poseindex < posekeys.size; poseindex++) {
        animpose = posekeys[poseindex];
        pose_array = script_array[animpose];
        weaponkeys = getarraykeys(pose_array);

        for(weaponindex = 0; weaponindex < weaponkeys.size; weaponindex++) {
          animweapon = weaponkeys[weaponindex];
          weapon_array = pose_array[animweapon];
          animkeys = getarraykeys(weapon_array);

          for(animindex = 0; animindex < animkeys.size; animindex++) {
            animname = animkeys[animindex];
            anim_array = weapon_array[animname];

            if(isarray(anim_array)) {
              transkeys = getarraykeys(anim_array);

              for(transindex = 0; transindex < transkeys.size; transindex++) {
                trans = transkeys[transindex];
                movedelta = getmovedelta(anim_array[trans], 0, 1);
                angledelta = getangledelta(anim_array[trans], 0, 1);
                notetracks = getnotetracksindelta(anim_array[trans], 0, 9999);

                if(issubstr(animname, "exposed") || trans >= 1 && trans <= 9) {
                  dest.move_delta_array[animtype]["move"][animpose][animweapon][animname][trans] = movedelta;
                  dest.angle_delta_array[animtype]["move"][animpose][animweapon][animname][trans] = angledelta;

                  if(issubstr(animname, "arrive") && trans >= 1 && trans <= 6) {
                    movelength = length(movedelta);

                    if(!isDefined(dest.longestapproachdist[animtype])) {
                      dest.longestapproachdist[animtype] = [];
                      dest.longestapproachdist[animtype][animname] = 0;
                    }

                    if(!isDefined(dest.longestapproachdist[animtype][animname])) {
                      assert(isDefined(dest.longestapproachdist[animtype]));
                      dest.longestapproachdist[animtype][animname] = 0;
                    }

                    if(movelength > dest.longestapproachdist[animtype][animname])
                      dest.longestapproachdist[animtype][animname] = movelength;
                  }
                }

                if(issubstr(animname, "exposed")) {
                  movelength = length(movedelta);

                  if(!isDefined(dest.longestexposedapproachdist[animtype]))
                    dest.longestexposedapproachdist[animtype] = 0;

                  if(movelength > dest.longestexposedapproachdist[animtype])
                    dest.longestexposedapproachdist[animtype] = movelength;

                  continue;
                }

                if(issubstr(animname, "left") || issubstr(animname, "right") || issubstr(animname, "pillar")) {
                  if(trans >= 7 && trans <= 9) {
                    if(animweapon == "pistol" && !issubstr(animname, "pillar"))
                      splittime = dest.covertranspistolsplit[animname][trans];
                    else
                      splittime = dest.covertranssplit[animname][trans];

                    premovedelta = getmovedelta(anim_array[trans], 0, splittime);
                    postmovedelta = movedelta - premovedelta;

                    if(issubstr(animname, "arrive")) {
                      dest.pre_move_delta_array[animtype]["move"][animpose][animweapon][animname][trans] = premovedelta;
                      dest.move_delta_array[animtype]["move"][animpose][animweapon][animname][trans] = postmovedelta;
                      continue;
                    }

                    dest.move_delta_array[animtype]["move"][animpose][animweapon][animname][trans] = premovedelta;
                    dest.post_move_delta_array[animtype]["move"][animpose][animweapon][animname][trans] = postmovedelta;
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

setup_default_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array = setup_default_cqb_anim_array(animtype, array);

  if(isDefined(level.supportspistolanimations) && level.supportspistolanimations)
    array = animscripts\anims_table_pistol::setup_pistol_anim_array(animtype, array);

  array = animscripts\anims_table_smg::setup_smg_anim_array(animtype, array);
  array = animscripts\anims_table_shotgun::setup_shotgun_anim_array(animtype, array);
  array = animscripts\anims_table_traverse::setup_traversal_anim_array(animtype, array);

  if(isDefined(level.supportseliteanimations) && level.supportseliteanimations)
    array = animscripts\ai_subclass\anims_table_elite::setup_elite_anim_array("elite", array);

  array[animtype]["combat"]["stand"]["rifle"]["exposed_idle"] = array(%exposed_idle_alert_v1, %exposed_idle_alert_v3);
  array[animtype]["combat"]["stand"]["rifle"]["idle_trans_out"] = % ai_casual_stand_v2_idle_trans_out;
  array[animtype]["combat"]["stand"]["rifle"]["fire"] = % exposed_shoot_auto_v3;
  array[animtype]["combat"]["stand"]["rifle"]["single"] = array(%exposed_shoot_semi1);
  array[animtype]["combat"]["stand"]["rifle"]["burst2"] = % exposed_shoot_burst3;
  array[animtype]["combat"]["stand"]["rifle"]["burst3"] = % exposed_shoot_burst3;
  array[animtype]["combat"]["stand"]["rifle"]["burst4"] = % exposed_shoot_burst4;
  array[animtype]["combat"]["stand"]["rifle"]["burst5"] = % exposed_shoot_burst5;
  array[animtype]["combat"]["stand"]["rifle"]["burst6"] = % exposed_shoot_burst6;
  array[animtype]["combat"]["stand"]["rifle"]["semi2"] = % exposed_shoot_semi2;
  array[animtype]["combat"]["stand"]["rifle"]["semi3"] = % exposed_shoot_semi3;
  array[animtype]["combat"]["stand"]["rifle"]["semi4"] = % exposed_shoot_semi4;
  array[animtype]["combat"]["stand"]["rifle"]["semi5"] = % exposed_shoot_semi5;
  array[animtype]["combat"]["stand"]["rifle"]["reload"] = array(%exposed_reload, %exposed_reloada);
  array[animtype]["combat"]["stand"]["rifle"]["reload_crouchhide"] = array(%exposed_reloadb);
  array[animtype]["combat"]["stand"]["rifle"]["weapon_switch"] = % ai_stand_exposed_weaponswitch;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_45"] = % exposed_tracking_turn45l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_90"] = % exposed_tracking_turn90l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_135"] = % exposed_tracking_turn135l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_180"] = % exposed_tracking_turn180l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_45"] = % exposed_tracking_turn45r;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_90"] = % exposed_tracking_turn90r;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_135"] = % exposed_tracking_turn135r;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_180"] = % exposed_tracking_turn180l;
  array[animtype]["combat"]["stand"]["rifle"]["straight_level"] = % exposed_aim_5;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_up"] = % exposed_aim_8;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_down"] = % exposed_aim_2;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_left"] = % exposed_aim_4;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_right"] = % exposed_aim_6;
  array[animtype]["combat"]["stand"]["rifle"]["add_turn_aim_up"] = % exposed_turn_aim_8;
  array[animtype]["combat"]["stand"]["rifle"]["add_turn_aim_down"] = % exposed_turn_aim_2;
  array[animtype]["combat"]["stand"]["rifle"]["add_turn_aim_left"] = % exposed_turn_aim_4;
  array[animtype]["combat"]["stand"]["rifle"]["add_turn_aim_right"] = % exposed_turn_aim_6;
  array[animtype]["combat"]["stand"]["rifle"]["crouch_2_stand"] = % exposed_crouch_2_stand;
  array[animtype]["combat"]["stand"]["rifle"]["stand_2_crouch"] = % exposed_stand_2_crouch;
  array[animtype]["combat"]["stand"]["rifle"]["crouch_2_prone"] = % crouch_2_prone;
  array[animtype]["combat"]["stand"]["rifle"]["stand_2_prone"] = % stand_2_prone_nodelta;
  array[animtype]["combat"]["stand"]["rifle"]["prone_2_crouch"] = % prone_2_crouch;
  array[animtype]["combat"]["stand"]["rifle"]["prone_2_stand"] = % prone_2_stand_nodelta;
  array[animtype]["combat"]["stand"]["rifle"]["grenade_throw"] = % ai_stand_exposed_grenade_throwa;
  array[animtype]["combat"]["stand"]["rifle"]["grenade_throw_1"] = % exposed_grenadethrowb;
  array[animtype]["combat"]["stand"]["rifle"]["grenade_throw_2"] = % exposed_grenadethrowc;
  array[animtype]["combat"]["stand"]["rifle"]["pistol_pullout"] = % pistol_stand_pullout;
  array[animtype]["combat"]["stand"]["rifle"]["throw_down_weapon"] = % rpg_stand_throw;
  array[animtype]["combat"]["stand"]["pistol"]["idle_trans_out"] = % ai_pistol_casual_stand_idle_trans_out;
  array[animtype]["combat"]["stand"]["pistol"]["exposed_idle"] = array(%ai_pistol_stand_exposed_idle);
  array[animtype]["combat"]["stand"]["pistol"]["fire"] = % ai_tactical_walk_pistol_f_auto;
  array[animtype]["combat"]["stand"]["pistol"]["single"] = array(%pistol_stand_fire_a);
  array[animtype]["combat"]["stand"]["pistol"]["semi2"] = % ai_tactical_walk_pistol_f_semi_2;
  array[animtype]["combat"]["stand"]["pistol"]["semi3"] = % ai_tactical_walk_pistol_f_semi_3;
  array[animtype]["combat"]["stand"]["pistol"]["semi4"] = % ai_tactical_walk_pistol_f_semi_4;
  array[animtype]["combat"]["stand"]["pistol"]["semi5"] = % ai_tactical_walk_pistol_f_semi_5;
  array[animtype]["move"]["stand"]["pistol"]["fire"] = % ai_tactical_walk_pistol_f_auto;
  array[animtype]["move"]["stand"]["pistol"]["burst2"] = % ai_tactical_walk_pistol_f_burst_3;
  array[animtype]["move"]["stand"]["pistol"]["burst3"] = % ai_tactical_walk_pistol_f_burst_3;
  array[animtype]["move"]["stand"]["pistol"]["burst4"] = % ai_tactical_walk_pistol_f_burst_4;
  array[animtype]["move"]["stand"]["pistol"]["burst5"] = % ai_tactical_walk_pistol_f_burst_5;
  array[animtype]["move"]["stand"]["pistol"]["burst6"] = % ai_tactical_walk_pistol_f_burst_6;
  array[animtype]["move"]["stand"]["pistol"]["semi2"] = % ai_tactical_walk_pistol_f_semi_2;
  array[animtype]["move"]["stand"]["pistol"]["semi3"] = % ai_tactical_walk_pistol_f_semi_3;
  array[animtype]["move"]["stand"]["pistol"]["semi4"] = % ai_tactical_walk_pistol_f_semi_4;
  array[animtype]["move"]["stand"]["pistol"]["semi5"] = % ai_tactical_walk_pistol_f_semi_2;
  array[animtype]["move"]["stand"]["pistol"]["single"] = array(%pistol_stand_fire_a);
  array[animtype]["combat"]["stand"]["pistol"]["reload"] = array(%pistol_stand_reload_a, %ai_pistol_stand_exposed_reload);
  array[animtype]["combat"]["stand"]["pistol"]["reload_crouchhide"] = array(%ai_pistol_stand_exposed_reload);
  array[animtype]["combat"]["stand"]["pistol"]["turn_left_45"] = % pistol_stand_turn45l;
  array[animtype]["combat"]["stand"]["pistol"]["turn_right_45"] = % pistol_stand_turn45r;
  array[animtype]["combat"]["stand"]["pistol"]["turn_left_90"] = % pistol_stand_turn90l;
  array[animtype]["combat"]["stand"]["pistol"]["turn_right_90"] = % pistol_stand_turn90r;
  array[animtype]["combat"]["stand"]["pistol"]["turn_left_135"] = % pistol_stand_turn180l;
  array[animtype]["combat"]["stand"]["pistol"]["turn_right_135"] = % pistol_stand_turn180r;
  array[animtype]["combat"]["stand"]["pistol"]["turn_left_180"] = % pistol_stand_turn180l;
  array[animtype]["combat"]["stand"]["pistol"]["turn_right_180"] = % pistol_stand_turn180r;
  array[animtype]["combat"]["stand"]["pistol"]["straight_level"] = % pistol_stand_aim_5;
  array[animtype]["combat"]["stand"]["pistol"]["add_aim_up"] = % pistol_stand_aim_8_add;
  array[animtype]["combat"]["stand"]["pistol"]["add_aim_down"] = % pistol_stand_aim_2_add;
  array[animtype]["combat"]["stand"]["pistol"]["add_aim_left"] = % pistol_stand_aim_4_add;
  array[animtype]["combat"]["stand"]["pistol"]["add_aim_right"] = % pistol_stand_aim_6_add;
  array[animtype]["combat"]["stand"]["pistol"]["add_turn_aim_up"] = % pistol_stand_aim_8_alt;
  array[animtype]["combat"]["stand"]["pistol"]["add_turn_aim_down"] = % pistol_stand_aim_2_alt;
  array[animtype]["combat"]["stand"]["pistol"]["add_turn_aim_left"] = % pistol_stand_aim_4_alt;
  array[animtype]["combat"]["stand"]["pistol"]["add_turn_aim_right"] = % pistol_stand_aim_6_alt;
  array[animtype]["combat"]["stand"]["pistol"]["pistol_putaway"] = % pistol_stand_switch;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["straight_level"] = % rpg_stand_aim_5;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["add_aim_up"] = % rpg_stand_aim_8;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["add_aim_down"] = % rpg_stand_aim_2;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["add_aim_left"] = % rpg_stand_aim_4;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["add_aim_right"] = % rpg_stand_aim_6;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["fire"] = % rpg_stand_fire;
  array[animtype]["combat"]["stand"]["rocketlauncher"]["single"] = array(%rpg_stand_fire);
  array[animtype]["combat"]["stand"]["rocketlauncher"]["reload"] = array(%rpg_stand_reload);
  array[animtype]["combat"]["stand"]["rocketlauncher"]["reload_crouchhide"] = array(%rpg_stand_reload);
  array[animtype]["combat"]["stand"]["rocketlauncher"]["exposed_idle"] = array(%rpg_stand_idle);
  array[animtype]["combat"]["stand"]["gas"]["exposed_idle"] = array(%ai_flamethrower_stand_idle_alert_v1);
  array[animtype]["combat"]["stand"]["gas"]["idle1"] = % ai_flamethrower_stand_idle_alert_v1;
  array[animtype]["combat"]["stand"]["gas"]["fire"] = % ai_flame_fire_center;
  array[animtype]["combat"]["stand"]["gas"]["single"] = % ai_flame_fire_center;
  array[animtype]["combat"]["stand"]["gas"]["turn_left_45"] = % ai_flamethrower_turn45l;
  array[animtype]["combat"]["stand"]["gas"]["turn_left_90"] = % ai_flamethrower_turn90l;
  array[animtype]["combat"]["stand"]["gas"]["turn_left_135"] = % ai_flamethrower_turn135l;
  array[animtype]["combat"]["stand"]["gas"]["turn_left_180"] = % ai_flamethrower_turn180;
  array[animtype]["combat"]["stand"]["gas"]["turn_right_45"] = % ai_flamethrower_turn45r;
  array[animtype]["combat"]["stand"]["gas"]["turn_right_90"] = % ai_flamethrower_turn90r;
  array[animtype]["combat"]["stand"]["gas"]["turn_right_135"] = % ai_flamethrower_turn135r;
  array[animtype]["combat"]["stand"]["gas"]["turn_right_180"] = % ai_flamethrower_turn180;
  array[animtype]["combat"]["stand"]["gas"]["straight_level"] = % ai_flamethrower_aim_5;
  array[animtype]["combat"]["stand"]["gas"]["add_aim_up"] = % ai_flamethrower_aim_8;
  array[animtype]["combat"]["stand"]["gas"]["add_aim_down"] = % ai_flamethrower_aim_2;
  array[animtype]["combat"]["stand"]["gas"]["add_aim_left"] = % ai_flamethrower_aim_4;
  array[animtype]["combat"]["stand"]["gas"]["add_aim_right"] = % ai_flamethrower_aim_6;
  array[animtype]["combat"]["stand"]["gas"]["crouch_2_stand"] = % ai_flamethrower_crouch_2_stand;
  array[animtype]["combat"]["stand"]["gas"]["stand_2_crouch"] = % ai_flamethrower_stand_2_crouch;
  array[animtype]["combat"]["stand"]["rifle"]["melee_0"] = % melee_1;
  array[animtype]["combat"]["stand"]["rifle"]["stand_2_melee_0"] = % stand_2_melee_1;
  array[animtype]["combat"]["stand"]["rifle"]["run_2_melee_0"] = % run_2_melee_charge;
  array[animtype]["combat"]["stand"]["rifle"]["melee_1"] = % ai_melee_02;
  array[animtype]["combat"]["stand"]["rifle"]["stand_2_melee_1"] = % ai_stand_2_melee_02;
  array[animtype]["combat"]["stand"]["rifle"]["run_2_melee_1"] = % ai_run_2_melee_02_charge;
  array[animtype]["combat"]["stand"]["pistol"]["melee_0"] = % ai_pistol_melee;
  array[animtype]["combat"]["stand"]["pistol"]["stand_2_melee_0"] = % ai_pistol_stand_2_melee;
  array[animtype]["combat"]["stand"]["pistol"]["run_2_melee_0"] = % ai_pistol_run_2_melee_charge;
  array[animtype]["combat"]["crouch"]["rifle"]["exposed_idle"] = array(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  array[animtype]["combat"]["crouch"]["rifle"]["fire"] = % exposed_crouch_shoot_auto_v2;
  array[animtype]["combat"]["crouch"]["rifle"]["single"] = array(%exposed_crouch_shoot_semi1);
  array[animtype]["combat"]["crouch"]["rifle"]["burst2"] = % exposed_crouch_shoot_burst3;
  array[animtype]["combat"]["crouch"]["rifle"]["burst3"] = % exposed_crouch_shoot_burst3;
  array[animtype]["combat"]["crouch"]["rifle"]["burst4"] = % exposed_crouch_shoot_burst4;
  array[animtype]["combat"]["crouch"]["rifle"]["burst5"] = % exposed_crouch_shoot_burst5;
  array[animtype]["combat"]["crouch"]["rifle"]["burst6"] = % exposed_crouch_shoot_burst6;
  array[animtype]["combat"]["crouch"]["rifle"]["semi2"] = % exposed_crouch_shoot_semi2;
  array[animtype]["combat"]["crouch"]["rifle"]["semi3"] = % exposed_crouch_shoot_semi3;
  array[animtype]["combat"]["crouch"]["rifle"]["semi4"] = % exposed_crouch_shoot_semi4;
  array[animtype]["combat"]["crouch"]["rifle"]["semi5"] = % exposed_crouch_shoot_semi5;
  array[animtype]["combat"]["crouch"]["rifle"]["reload"] = array(%exposed_crouch_reload);
  array[animtype]["combat"]["crouch"]["rifle"]["weapon_switch"] = % ai_crouch_exposed_weaponswitch;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_left_45"] = % ai_crouch_exposed_turn_45l;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_left_90"] = % ai_crouch_exposed_turn_90l;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_left_135"] = % ai_crouch_exposed_turn_135l;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_left_180"] = % ai_crouch_exposed_turn_180l;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_right_45"] = % ai_crouch_exposed_turn_45r;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_right_90"] = % ai_crouch_exposed_turn_90r;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_right_135"] = % ai_crouch_exposed_turn_135r;
  array[animtype]["combat"]["crouch"]["rifle"]["turn_right_180"] = % ai_crouch_exposed_turn_180l;
  array[animtype]["combat"]["crouch"]["rifle"]["straight_level"] = % exposed_crouch_aim_5;
  array[animtype]["combat"]["crouch"]["rifle"]["add_aim_up"] = % exposed_crouch_aim_8;
  array[animtype]["combat"]["crouch"]["rifle"]["add_aim_down"] = % exposed_crouch_aim_2;
  array[animtype]["combat"]["crouch"]["rifle"]["add_aim_left"] = % exposed_crouch_aim_4;
  array[animtype]["combat"]["crouch"]["rifle"]["add_aim_right"] = % exposed_crouch_aim_6;
  array[animtype]["combat"]["crouch"]["rifle"]["add_turn_aim_up"] = % exposed_crouch_turn_aim_8;
  array[animtype]["combat"]["crouch"]["rifle"]["add_turn_aim_down"] = % exposed_crouch_turn_aim_2;
  array[animtype]["combat"]["crouch"]["rifle"]["add_turn_aim_left"] = % exposed_crouch_turn_aim_4;
  array[animtype]["combat"]["crouch"]["rifle"]["add_turn_aim_right"] = % exposed_crouch_turn_aim_6;
  array[animtype]["combat"]["crouch"]["rifle"]["crouch_2_stand"] = % exposed_crouch_2_stand;
  array[animtype]["combat"]["crouch"]["rifle"]["stand_2_crouch"] = % exposed_stand_2_crouch;
  array[animtype]["combat"]["crouch"]["rifle"]["crouch_2_prone"] = % crouch_2_prone;
  array[animtype]["combat"]["crouch"]["rifle"]["stand_2_prone"] = % stand_2_prone_nodelta;
  array[animtype]["combat"]["crouch"]["rifle"]["prone_2_crouch"] = % prone_2_crouch;
  array[animtype]["combat"]["crouch"]["rifle"]["prone_2_stand"] = % prone_2_stand_nodelta;
  array[animtype]["combat"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["combat"]["crouch"]["rifle"]["throw_down_weapon"] = % rpg_crouch_throw;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["straight_level"] = % rpg_crouch_aim_5;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["add_aim_up"] = % rpg_crouch_aim_8;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["add_aim_down"] = % rpg_crouch_aim_2;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["add_aim_left"] = % rpg_crouch_aim_4;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["add_aim_right"] = % rpg_crouch_aim_6;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["fire"] = % rpg_crouch_fire;
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["single"] = array(%rpg_crouch_fire);
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["reload"] = array(%rpg_crouch_reload);
  array[animtype]["combat"]["crouch"]["rocketlauncher"]["exposed_idle"] = array(%rpg_crouch_idle);
  array[animtype]["combat"]["crouch"]["gas"]["exposed_idle"] = array(%ai_flamethrower_crouch_idle_a_alert_v1);
  array[animtype]["combat"]["crouch"]["gas"]["fire"] = % ai_flame_crouch_fire_center;
  array[animtype]["combat"]["crouch"]["gas"]["single"] = % ai_flame_crouch_fire_center;
  array[animtype]["combat"]["crouch"]["gas"]["turn_left_45"] = % ai_flamethrower_crouch_turn90l;
  array[animtype]["combat"]["crouch"]["gas"]["turn_left_90"] = % ai_flamethrower_crouch_turn90l;
  array[animtype]["combat"]["crouch"]["gas"]["turn_left_135"] = % ai_flamethrower_crouch_turn90l;
  array[animtype]["combat"]["crouch"]["gas"]["turn_left_180"] = % ai_flamethrower_crouch_turn90l;
  array[animtype]["combat"]["crouch"]["gas"]["turn_right_45"] = % ai_flamethrower_crouch_turn90r;
  array[animtype]["combat"]["crouch"]["gas"]["turn_right_90"] = % ai_flamethrower_crouch_turn90r;
  array[animtype]["combat"]["crouch"]["gas"]["turn_right_135"] = % ai_flamethrower_crouch_turn90r;
  array[animtype]["combat"]["crouch"]["gas"]["turn_right_180"] = % ai_flamethrower_crouch_turn90r;
  array[animtype]["combat"]["crouch"]["gas"]["straight_level"] = % ai_flamethrower_crouch_aim_5;
  array[animtype]["combat"]["crouch"]["gas"]["add_aim_up"] = % ai_flamethrower_crouch_aim_8;
  array[animtype]["combat"]["crouch"]["gas"]["add_aim_down"] = % ai_flamethrower_crouch_aim_2;
  array[animtype]["combat"]["crouch"]["gas"]["add_aim_left"] = % ai_flamethrower_crouch_aim_4;
  array[animtype]["combat"]["crouch"]["gas"]["add_aim_right"] = % ai_flamethrower_crouch_aim_6;
  array[animtype]["combat"]["crouch"]["gas"]["crouch_2_stand"] = % ai_flamethrower_crouch_2_stand;
  array[animtype]["combat"]["crouch"]["gas"]["stand_2_crouch"] = % ai_flamethrower_stand_2_crouch;
  array[animtype]["combat"]["prone"]["rifle"]["add_aim_up"] = % prone_aim_8_add;
  array[animtype]["combat"]["prone"]["rifle"]["add_aim_down"] = % prone_aim_2_add;
  array[animtype]["combat"]["prone"]["rifle"]["add_aim_left"] = % prone_aim_4_add;
  array[animtype]["combat"]["prone"]["rifle"]["add_aim_right"] = % prone_aim_6_add;
  array[animtype]["combat"]["prone"]["rifle"]["straight_level"] = % prone_aim_5;
  array[animtype]["combat"]["prone"]["rifle"]["fire"] = % prone_fire_1;
  array[animtype]["combat"]["prone"]["rifle"]["single"] = array(%prone_fire_1);
  array[animtype]["combat"]["prone"]["rifle"]["reload"] = array(%prone_reload);
  array[animtype]["combat"]["prone"]["rifle"]["burst2"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["burst3"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["burst4"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["burst5"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["burst6"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["semi2"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["semi3"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["semi4"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["semi5"] = % prone_fire_burst;
  array[animtype]["combat"]["prone"]["rifle"]["exposed_idle"] = array(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  array[animtype]["combat"]["prone"]["rifle"]["crouch_2_prone"] = % crouch_2_prone;
  array[animtype]["combat"]["prone"]["rifle"]["crouch_2_stand"] = % exposed_crouch_2_stand;
  array[animtype]["combat"]["prone"]["rifle"]["stand_2_crouch"] = % exposed_stand_2_crouch;
  array[animtype]["combat"]["prone"]["rifle"]["stand_2_prone"] = % stand_2_prone_nodelta;
  array[animtype]["combat"]["prone"]["rifle"]["prone_2_crouch"] = % prone_2_crouch;
  array[animtype]["combat"]["prone"]["rifle"]["prone_2_stand"] = % prone_2_stand_nodelta;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_f"] = % run_lowready_f;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_r"] = % run_lowready_r;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_l"] = % run_lowready_l;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_b"] = % run_lowready_b;
  array[animtype]["move"]["stand"]["rifle"]["crouch_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_bR"] = % ai_run_f2b_a;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_bL"] = % ai_run_f2b;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_R"] = % ai_run_lowready_f_2_tactical_walk_r;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_L"] = % ai_run_lowready_f_2_tactical_walk_l;
  array[animtype]["move"]["stand"]["rifle"]["walk_f"] = % walk_lowready_f;
  array[animtype]["move"]["stand"]["rifle"]["walk_r"] = % walk_lowready_r;
  array[animtype]["move"]["stand"]["rifle"]["walk_l"] = % walk_lowready_l;
  array[animtype]["move"]["stand"]["rifle"]["walk_b"] = % walk_lowready_b;
  array[animtype]["move"]["stand"]["rifle"]["sprint"] = array(%ai_sprint_f_04, %ai_sprint_f);
  array[animtype]["move"]["stand"]["rifle"]["reload"] = % run_lowready_reload;
  array[animtype]["move"]["stand"]["rifle"]["run_n_gun_f"] = % run_n_gun_f;
  array[animtype]["move"]["stand"]["rifle"]["run_n_gun_r"] = % run_n_gun_r;
  array[animtype]["move"]["stand"]["rifle"]["run_n_gun_l"] = % run_n_gun_l;
  array[animtype]["move"]["stand"]["rifle"]["run_n_gun_b"] = % run_n_gun_b;
  array[animtype]["move"]["stand"]["rifle"]["run_n_gun_l_120"] = % ai_run_n_gun_l_120;
  array[animtype]["move"]["stand"]["rifle"]["run_n_gun_r_120"] = % ai_run_n_gun_r_120;
  array[animtype]["move"]["stand"]["rifle"]["add_f_aim_up"] = % ai_run_n_gun_f_aim_8;
  array[animtype]["move"]["stand"]["rifle"]["add_f_aim_down"] = % ai_run_n_gun_f_aim_2;
  array[animtype]["move"]["stand"]["rifle"]["add_f_aim_left"] = % ai_run_n_gun_f_aim_4;
  array[animtype]["move"]["stand"]["rifle"]["add_f_aim_right"] = % ai_run_n_gun_f_aim_6;
  array[animtype]["move"]["stand"]["rifle"]["add_l_aim_up"] = % run_n_gun_l_aim8;
  array[animtype]["move"]["stand"]["rifle"]["add_l_aim_down"] = % run_n_gun_l_aim2;
  array[animtype]["move"]["stand"]["rifle"]["add_l_aim_left"] = % run_n_gun_l_aim4;
  array[animtype]["move"]["stand"]["rifle"]["add_l_aim_right"] = % run_n_gun_l_aim6;
  array[animtype]["move"]["stand"]["rifle"]["add_r_aim_up"] = % run_n_gun_r_aim8;
  array[animtype]["move"]["stand"]["rifle"]["add_r_aim_down"] = % run_n_gun_r_aim2;
  array[animtype]["move"]["stand"]["rifle"]["add_r_aim_left"] = % run_n_gun_r_aim4;
  array[animtype]["move"]["stand"]["rifle"]["add_r_aim_right"] = % run_n_gun_r_aim6;
  array[animtype]["move"]["stand"]["rifle"]["add_l_120_aim_up"] = % ai_run_n_gun_l_120_aim8;
  array[animtype]["move"]["stand"]["rifle"]["add_l_120_aim_down"] = % ai_run_n_gun_l_120_aim2;
  array[animtype]["move"]["stand"]["rifle"]["add_l_120_aim_left"] = % ai_run_n_gun_l_120_aim4;
  array[animtype]["move"]["stand"]["rifle"]["add_l_120_aim_right"] = % ai_run_n_gun_l_120_aim6;
  array[animtype]["move"]["stand"]["rifle"]["add_r_120_aim_up"] = % ai_run_n_gun_r_120_aim8;
  array[animtype]["move"]["stand"]["rifle"]["add_r_120_aim_down"] = % ai_run_n_gun_r_120_aim2;
  array[animtype]["move"]["stand"]["rifle"]["add_r_120_aim_left"] = % ai_run_n_gun_r_120_aim4;
  array[animtype]["move"]["stand"]["rifle"]["add_r_120_aim_right"] = % ai_run_n_gun_r_120_aim6;
  array[animtype]["move"]["stand"]["rifle"]["tactical_walk_f"] = % ai_tactical_walk_f;
  array[animtype]["move"]["stand"]["rifle"]["tactical_walk_r"] = % ai_tactical_walk_l;
  array[animtype]["move"]["stand"]["rifle"]["tactical_walk_l"] = % ai_tactical_walk_r;
  array[animtype]["move"]["stand"]["rifle"]["tactical_walk_b"] = % ai_tactical_walk_b;
  array[animtype]["move"]["stand"]["rifle"]["tactical_b_aim_up"] = % ai_tactical_walk_b_aim8;
  array[animtype]["move"]["stand"]["rifle"]["tactical_b_aim_down"] = % ai_tactical_walk_b_aim2;
  array[animtype]["move"]["stand"]["rifle"]["tactical_b_aim_left"] = % ai_tactical_walk_b_aim4;
  array[animtype]["move"]["stand"]["rifle"]["tactical_b_aim_right"] = % ai_tactical_walk_b_aim6;
  array[animtype]["move"]["stand"]["rifle"]["tactical_f_aim_up"] = % ai_tactical_walk_f_aim8;
  array[animtype]["move"]["stand"]["rifle"]["tactical_f_aim_down"] = % ai_tactical_walk_f_aim2;
  array[animtype]["move"]["stand"]["rifle"]["tactical_f_aim_left"] = % ai_tactical_walk_f_aim4;
  array[animtype]["move"]["stand"]["rifle"]["tactical_f_aim_right"] = % ai_tactical_walk_f_aim6;
  array[animtype]["move"]["stand"]["rifle"]["tactical_l_aim_up"] = % ai_tactical_walk_l_aim8;
  array[animtype]["move"]["stand"]["rifle"]["tactical_l_aim_down"] = % ai_tactical_walk_l_aim2;
  array[animtype]["move"]["stand"]["rifle"]["tactical_l_aim_left"] = % ai_tactical_walk_l_aim4;
  array[animtype]["move"]["stand"]["rifle"]["tactical_l_aim_right"] = % ai_tactical_walk_l_aim6;
  array[animtype]["move"]["stand"]["gas"]["combat_run_f"] = % ai_flamethrower_combatrun_c;
  array[animtype]["move"]["crouch"]["rifle"]["combat_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["crouch"]["rifle"]["combat_run_r"] = % crouch_fastwalk_r;
  array[animtype]["move"]["crouch"]["rifle"]["combat_run_l"] = % crouch_fastwalk_l;
  array[animtype]["move"]["crouch"]["rifle"]["combat_run_b"] = % crouch_fastwalk_b;
  array[animtype]["move"]["crouch"]["rifle"]["crouch_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["crouch"]["rifle"]["add_f_aim_up"] = % ai_crouch_fastwalk_f_aim_8;
  array[animtype]["move"]["crouch"]["rifle"]["add_f_aim_down"] = % ai_crouch_fastwalk_f_aim_2;
  array[animtype]["move"]["crouch"]["rifle"]["add_f_aim_left"] = % ai_crouch_fastwalk_f_aim_4;
  array[animtype]["move"]["crouch"]["rifle"]["add_f_aim_right"] = % ai_crouch_fastwalk_f_aim_6;
  array[animtype]["move"]["stand"]["rifle"]["start_stand_run_f"] = % run_lowready_f;
  array[animtype]["move"]["crouch"]["rifle"]["start_stand_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["prone"]["rifle"]["start_stand_run_f"] = % run_lowready_f;
  array[animtype]["move"]["stand"]["rifle"]["start_crouch_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["crouch"]["rifle"]["start_crouch_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["prone"]["rifle"]["start_crouch_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["crouch"]["rifle"]["walk_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["crouch"]["rifle"]["walk_r"] = % crouch_fastwalk_r;
  array[animtype]["move"]["crouch"]["rifle"]["walk_l"] = % crouch_fastwalk_l;
  array[animtype]["move"]["crouch"]["rifle"]["walk_b"] = % crouch_fastwalk_b;
  array[animtype]["move"]["stand"]["rifle"]["run_2_prone_dive"] = % crouch_2_prone;
  array[animtype]["move"]["stand"]["rifle"]["run_2_prone_gunsupport"] = % crouch2prone_gunsupport;
  array[animtype]["move"]["crouch"]["rifle"]["run_2_prone_dive"] = % crouch_2_prone;
  array[animtype]["move"]["crouch"]["rifle"]["run_2_prone_gunsupport"] = % crouch2prone_gunsupport;
  array[animtype]["move"]["crouch"]["pistol"]["crouch_2_stand"] = % pistol_crouchaimstraight2stand;
  array[animtype]["move"]["crouch"]["rifle"]["crouch_2_stand"] = % exposed_crouch_2_stand;
  array[animtype]["move"]["crouch"]["rifle"]["crouch_2_prone"] = % crouch_2_prone;
  array[animtype]["move"]["prone"]["rifle"]["combat_run_f"] = % prone_crawl;
  array[animtype]["move"]["prone"]["rifle"]["prone_2_crouch_run"] = % prone2crouchrun_straight;
  array[animtype]["move"]["prone"]["rifle"]["prone_2_crouch"] = % prone_2_crouch;
  array[animtype]["move"]["prone"]["rifle"]["prone_2_stand"] = % prone_2_stand;
  array[animtype]["move"]["prone"]["rifle"]["crouch_run_f"] = % crouch_fastwalk_f;
  array[animtype]["move"]["prone"]["rifle"]["aim_2_crawl"] = % prone_aim2crawl;
  array[animtype]["move"]["prone"]["rifle"]["crawl_2_aim"] = % prone_crawl2aim;
  array[animtype]["move"]["stand"]["rifle"]["stand_2_prone_onehand"] = % stand2prone_onehand;
  array[animtype]["move"]["stand"]["rifle"]["stand_2_prone"] = % stand_2_prone;
  array[animtype]["move"]["stand"]["rifle"]["stand_2_crouch"] = % exposed_stand_2_crouch;
  array[animtype]["move"]["stand"]["rifle"]["fire"] = % exposed_shoot_auto_v3;
  array[animtype]["move"]["stand"]["rifle"]["burst2"] = % exposed_shoot_burst3;
  array[animtype]["move"]["stand"]["rifle"]["burst3"] = % exposed_shoot_burst3;
  array[animtype]["move"]["stand"]["rifle"]["burst4"] = % exposed_shoot_burst4;
  array[animtype]["move"]["stand"]["rifle"]["burst5"] = % exposed_shoot_burst5;
  array[animtype]["move"]["stand"]["rifle"]["burst6"] = % exposed_shoot_burst6;
  array[animtype]["move"]["stand"]["rifle"]["semi2"] = % exposed_shoot_semi2;
  array[animtype]["move"]["stand"]["rifle"]["semi3"] = % exposed_shoot_semi3;
  array[animtype]["move"]["stand"]["rifle"]["semi4"] = % exposed_shoot_semi4;
  array[animtype]["move"]["stand"]["rifle"]["semi5"] = % exposed_shoot_semi5;
  array[animtype]["move"]["stand"]["rifle"]["single"] = array(%exposed_shoot_semi1);
  array[animtype]["move"]["stand"]["rifle"]["throw_down_weapon"] = % rpg_stand_throw;
  array[animtype]["move"]["crouch"]["rifle"]["throw_down_weapon"] = % rpg_crouch_throw;
  array[animtype]["move"]["stand"]["rifle"]["weapon_switch"] = % ai_run_lowready_f_weaponswitch;
  array[animtype]["move"]["crouch"]["rifle"]["fire"] = % exposed_shoot_auto_v3;
  array[animtype]["move"]["crouch"]["rifle"]["burst2"] = % exposed_shoot_burst3;
  array[animtype]["move"]["crouch"]["rifle"]["burst3"] = % exposed_shoot_burst3;
  array[animtype]["move"]["crouch"]["rifle"]["burst4"] = % exposed_shoot_burst4;
  array[animtype]["move"]["crouch"]["rifle"]["burst5"] = % exposed_shoot_burst5;
  array[animtype]["move"]["crouch"]["rifle"]["burst6"] = % exposed_shoot_burst6;
  array[animtype]["move"]["crouch"]["rifle"]["semi2"] = % exposed_shoot_semi2;
  array[animtype]["move"]["crouch"]["rifle"]["semi3"] = % exposed_shoot_semi3;
  array[animtype]["move"]["crouch"]["rifle"]["semi4"] = % exposed_shoot_semi4;
  array[animtype]["move"]["crouch"]["rifle"]["semi5"] = % exposed_shoot_semi5;
  array[animtype]["move"]["crouch"]["rifle"]["single"] = array(%exposed_shoot_semi1);
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][1] = % corner_standr_trans_in_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][2] = % corner_standr_trans_in_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][3] = % corner_standr_trans_in_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][4] = % corner_standr_trans_in_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][6] = % corner_standr_trans_in_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][8] = % corner_standr_trans_in_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][9] = % corner_standr_trans_in_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][1] = % cornercrr_trans_in_ml;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][2] = % cornercrr_trans_in_m;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][3] = % cornercrr_trans_in_mr;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][4] = % cornercrr_trans_in_l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][6] = % cornercrr_trans_in_r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][8] = % cornercrr_trans_in_f;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][9] = % cornercrr_trans_in_mf;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][1] = % corner_standl_trans_in_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][2] = % corner_standl_trans_in_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][3] = % corner_standl_trans_in_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][4] = % corner_standl_trans_in_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][6] = % corner_standl_trans_in_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][7] = % corner_standl_trans_in_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][8] = % corner_standl_trans_in_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][1] = % cornercrl_trans_in_ml;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][2] = % cornercrl_trans_in_m;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][3] = % cornercrl_trans_in_mr;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][4] = % cornercrl_trans_in_l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][6] = % cornercrl_trans_in_r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][7] = % cornercrl_trans_in_mf;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][8] = % cornercrl_trans_in_f;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][1] = % covercrouch_run_in_ml;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][2] = % covercrouch_run_in_m;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][3] = % covercrouch_run_in_mr;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][4] = % covercrouch_run_in_l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][6] = % covercrouch_run_in_r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][1] = % coverstand_trans_in_ml;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][2] = % coverstand_trans_in_m;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][3] = % coverstand_trans_in_mr;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][4] = % coverstand_trans_in_l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][6] = % coverstand_trans_in_r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][1] = % ai_pillar2_stand_arrive_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][2] = % ai_pillar2_stand_arrive_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][3] = % ai_pillar2_stand_arrive_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][4] = % ai_pillar2_stand_arrive_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][6] = % ai_pillar2_stand_arrive_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][7] = % ai_pillar2_stand_arrive_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][8] = % ai_pillar2_stand_arrive_8r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar"][9] = % ai_pillar2_stand_arrive_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][1] = % ai_pillar2_crouch_arrive_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][2] = % ai_pillar2_crouch_arrive_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][3] = % ai_pillar2_crouch_arrive_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][4] = % ai_pillar2_crouch_arrive_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][6] = % ai_pillar2_crouch_arrive_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][7] = % ai_pillar2_crouch_arrive_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][8] = % ai_pillar2_crouch_arrive_8r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_pillar_crouch"][9] = % ai_pillar2_crouch_arrive_9;
  array[animtype]["move"]["stand"]["mg"]["arrive_stand"][1] = % saw_gunner_runin_ml;
  array[animtype]["move"]["stand"]["mg"]["arrive_stand"][2] = % saw_gunner_runin_m;
  array[animtype]["move"]["stand"]["mg"]["arrive_stand"][3] = % saw_gunner_runin_mr;
  array[animtype]["move"]["stand"]["mg"]["arrive_stand"][4] = % saw_gunner_runin_l;
  array[animtype]["move"]["stand"]["mg"]["arrive_stand"][6] = % saw_gunner_runin_r;
  array[animtype]["move"]["stand"]["mg"]["arrive_crouch"][1] = % saw_gunner_lowwall_runin_ml;
  array[animtype]["move"]["stand"]["mg"]["arrive_crouch"][2] = % saw_gunner_lowwall_runin_m;
  array[animtype]["move"]["stand"]["mg"]["arrive_crouch"][3] = % saw_gunner_lowwall_runin_mr;
  array[animtype]["move"]["stand"]["mg"]["arrive_crouch"][4] = % saw_gunner_lowwall_runin_l;
  array[animtype]["move"]["stand"]["mg"]["arrive_crouch"][6] = % saw_gunner_lowwall_runin_r;
  array[animtype]["move"]["stand"]["mg"]["arrive_prone"][1] = % saw_gunner_prone_runin_ml;
  array[animtype]["move"]["stand"]["mg"]["arrive_prone"][2] = % saw_gunner_prone_runin_m;
  array[animtype]["move"]["stand"]["mg"]["arrive_prone"][3] = % saw_gunner_prone_runin_mr;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][1] = % ai_stand_exposed_arrival_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][2] = % ai_stand_exposed_arrival_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][3] = % ai_stand_exposed_arrival_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][4] = % ai_stand_exposed_arrival_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][6] = % ai_stand_exposed_arrival_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][7] = % ai_stand_exposed_arrival_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][8] = % ai_stand_exposed_arrival_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][9] = % ai_stand_exposed_arrival_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][1] = % cqb_crouch_stop_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][2] = % run_2_crouch_f;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][3] = % cqb_crouch_stop_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][4] = % run_2_crouch_90l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][6] = % run_2_crouch_90r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][7] = % cqb_crouch_stop_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][8] = % run_2_crouch_180l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch"][9] = % cqb_crouch_stop_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][1] = % corner_standr_trans_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][2] = % corner_standr_trans_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][3] = % corner_standr_trans_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][4] = % corner_standr_trans_out_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][6] = % corner_standr_trans_out_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][8] = % corner_standr_trans_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][9] = % corner_standr_trans_out_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][1] = % cornercrr_trans_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][2] = % cornercrr_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][3] = % cornercrr_trans_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][4] = % cornercrr_trans_out_l;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][6] = % cornercrr_trans_out_r;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][8] = % cornercrr_trans_out_f;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][9] = % cornercrr_trans_out_mf;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][1] = % corner_standl_trans_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][2] = % corner_standl_trans_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][3] = % corner_standl_trans_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][4] = % corner_standl_trans_out_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][6] = % corner_standl_trans_out_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][7] = % corner_standl_trans_out_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][8] = % corner_standl_trans_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][1] = % cornercrl_trans_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][2] = % cornercrl_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][3] = % cornercrl_trans_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][4] = % cornercrl_trans_out_l;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][6] = % cornercrl_trans_out_r;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][7] = % cornercrl_trans_out_mf;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][8] = % cornercrl_trans_out_f;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][1] = % covercrouch_run_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][2] = % covercrouch_run_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][3] = % covercrouch_run_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][4] = % covercrouch_run_out_l;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][6] = % covercrouch_run_out_r;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][1] = % coverstand_trans_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][2] = % coverstand_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][3] = % coverstand_trans_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][4] = % coverstand_trans_out_l;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][6] = % coverstand_trans_out_r;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][1] = % ai_pillar2_stand_exit_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][2] = % ai_pillar2_stand_exit_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][3] = % ai_pillar2_stand_exit_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][4] = % ai_pillar2_stand_exit_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][6] = % ai_pillar2_stand_exit_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][7] = % ai_pillar2_stand_exit_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][8] = % ai_pillar2_stand_exit_8r;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar"][9] = % ai_pillar2_stand_exit_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][1] = % ai_pillar2_crouch_exit_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][2] = % ai_pillar2_crouch_exit_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][3] = % ai_pillar2_crouch_exit_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][4] = % ai_pillar2_crouch_exit_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][6] = % ai_pillar2_crouch_exit_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][7] = % ai_pillar2_crouch_exit_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][8] = % ai_pillar2_crouch_exit_8r;
  array[animtype]["move"]["stand"]["rifle"]["exit_pillar_crouch"][9] = % ai_pillar2_crouch_exit_9;
  array[animtype]["move"]["stand"]["mg"]["exit_stand"][1] = % saw_gunner_runout_ml;
  array[animtype]["move"]["stand"]["mg"]["exit_stand"][2] = % saw_gunner_runout_m;
  array[animtype]["move"]["stand"]["mg"]["exit_stand"][3] = % saw_gunner_runout_mr;
  array[animtype]["move"]["stand"]["mg"]["exit_stand"][4] = % saw_gunner_runout_l;
  array[animtype]["move"]["stand"]["mg"]["exit_stand"][6] = % saw_gunner_runout_r;
  array[animtype]["move"]["stand"]["mg"]["exit_crouch"][1] = % saw_gunner_lowwall_runout_ml;
  array[animtype]["move"]["stand"]["mg"]["exit_crouch"][2] = % saw_gunner_lowwall_runout_m;
  array[animtype]["move"]["stand"]["mg"]["exit_crouch"][3] = % saw_gunner_lowwall_runout_mr;
  array[animtype]["move"]["stand"]["mg"]["exit_crouch"][4] = % saw_gunner_lowwall_runout_l;
  array[animtype]["move"]["stand"]["mg"]["exit_crouch"][6] = % saw_gunner_lowwall_runout_r;
  array[animtype]["move"]["stand"]["mg"]["exit_prone"][2] = % saw_gunner_prone_runout_m;
  array[animtype]["move"]["stand"]["mg"]["exit_prone"][4] = % saw_gunner_prone_runout_l;
  array[animtype]["move"]["stand"]["mg"]["exit_prone"][6] = % saw_gunner_prone_runout_r;
  array[animtype]["move"]["stand"]["mg"]["exit_prone"][8] = % saw_gunner_prone_runout_f;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][1] = % ai_stand_exposed_exit_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][2] = % ai_stand_exposed_exit_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][3] = % ai_stand_exposed_exit_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][4] = % ai_stand_exposed_exit_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][6] = % ai_stand_exposed_exit_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][7] = % ai_stand_exposed_exit_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][8] = % ai_stand_exposed_exit_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][9] = % ai_stand_exposed_exit_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][1] = % cqb_crouch_start_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][2] = % crouch_2run_180;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][3] = % cqb_crouch_start_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][4] = % crouch_2run_l;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][6] = % crouch_2run_r;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][7] = % cqb_crouch_start_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][8] = % crouch_2run_f;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch"][9] = % cqb_crouch_start_9;
  arrivalkeys = getarraykeys(array[animtype]["move"]["stand"]["rifle"]);

  for(i = 0; i < arrivalkeys.size; i++) {
    arrivaltype = arrivalkeys[i];

    if(isarray(array[animtype]["move"]["stand"]["rifle"][arrivaltype]))
      array[animtype]["move"]["crouch"]["rifle"][arrivaltype] = array[animtype]["move"]["stand"]["rifle"][arrivaltype];
  }

  array[animtype]["move"]["stand"]["rifle"]["coverStand_shuffleR_start"] = % ai_coverstand_hide_2_shuffler;
  array[animtype]["move"]["stand"]["rifle"]["coverStand_shuffleR"] = % ai_coverstand_shuffler;
  array[animtype]["move"]["stand"]["rifle"]["coverStand_shuffleR_end"] = % ai_coverstand_shuffler_2_hide;
  array[animtype]["move"]["stand"]["rifle"]["coverStand_shuffleL_start"] = % ai_coverstand_hide_2_shufflel;
  array[animtype]["move"]["stand"]["rifle"]["coverStand_shuffleL"] = % ai_coverstand_shufflel;
  array[animtype]["move"]["stand"]["rifle"]["coverStand_shuffleL_end"] = % ai_coverstand_shufflel_2_hide;
  array[animtype]["move"]["crouch"]["rifle"]["shuffleR_start"] = % ai_covercrouch_hide_2_shuffler;
  array[animtype]["move"]["crouch"]["rifle"]["shuffleR"] = % ai_covercrouch_shuffler;
  array[animtype]["move"]["crouch"]["rifle"]["shuffleR_end"] = % ai_covercrouch_shuffler_2_hide;
  array[animtype]["move"]["crouch"]["rifle"]["shuffleL_start"] = % ai_covercrouch_hide_2_shufflel;
  array[animtype]["move"]["crouch"]["rifle"]["shuffleL"] = % ai_covercrouch_shufflel;
  array[animtype]["move"]["crouch"]["rifle"]["shuffleL_end"] = % ai_covercrouch_shufflel_2_hide;
  array[animtype]["move"]["crouch"]["rifle"]["cornerL_shuffle_start"] = % ai_cornercrl_alert_2_shuffle;
  array[animtype]["move"]["crouch"]["rifle"]["cornerL_shuffle_end"] = % ai_cornercrl_shuffle_2_alert;
  array[animtype]["move"]["crouch"]["rifle"]["cornerR_shuffle_start"] = % ai_cornercrr_alert_2_shuffle;
  array[animtype]["move"]["crouch"]["rifle"]["cornerR_shuffle_end"] = % ai_cornercrr_shuffle_2_alert;
  array[animtype]["move"]["stand"]["rifle"]["corner_door_R2L"] = % ai_corner_standr_door_r2l;
  array[animtype]["move"]["stand"]["rifle"]["corner_door_L2R"] = % ai_corner_standl_door_l2r;
  array[animtype]["move"]["crouch"]["rifle"]["corner_door_R2L"] = % ai_corner_standr_door_r2l;
  array[animtype]["move"]["crouch"]["rifle"]["corner_door_L2R"] = % ai_corner_standl_door_l2r;
  array[animtype]["stop"]["stand"]["rifle"]["stand_2_crouch"] = % exposed_stand_2_crouch;
  array[animtype]["stop"]["stand"]["rifle"]["stand_2_prone_onehand"] = % stand2prone_onehand;
  array[animtype]["stop"]["stand"]["rifle"]["stand_2_prone"] = % stand_2_prone;
  array[animtype]["stop"]["stand"]["rifle"]["idle_trans_in"] = % casual_stand_idle_trans_in;
  array[animtype]["stop"]["stand"]["rifle"]["idle"] = array(array(%casual_stand_idle, %casual_stand_idle, %casual_stand_idle_twitch, %casual_stand_idle_twitchb), array(%casual_stand_v2_idle, %casual_stand_v2_idle, %casual_stand_v2_twitch_radio, %casual_stand_v2_twitch_shift, %casual_stand_v2_twitch_shift, %casual_stand_v2_twitch_talk));
  array[animtype]["stop"]["stand"]["rifle"]["idle_trans_hmg"] = % ai_mg_shoulder_run2stand;
  array[animtype]["stop"]["stand"]["rifle"]["idle_hmg"] = array(array(%ai_mg_shoulder_stand_idle));
  array[animtype]["stop"]["crouch"]["rifle"]["idle_trans_in"] = % casual_crouch_idle_in;
  array[animtype]["stop"]["crouch"]["rifle"]["idle"] = array(array(%casual_crouch_idle, %casual_crouch_idle, %casual_crouch_idle, %casual_crouch_idle, %casual_crouch_twitch, %casual_crouch_twitch, %casual_crouch_point));
  array[animtype]["stop"]["crouch"]["rifle"]["idle_trans_hmg"] = % ai_mg_shoulder_run2crouch;
  array[animtype]["stop"]["crouch"]["rifle"]["idle_hmg"] = array(array(%ai_mg_shoulder_crouch_idle));
  array[animtype]["stop"]["crouch"]["rifle"]["crouch_2_stand"] = % exposed_crouch_2_stand;
  array[animtype]["stop"]["crouch"]["rifle"]["crouch_2_prone"] = % crouch_2_prone;
  array[animtype]["stop"]["prone"]["rifle"]["crawl_2_aim"] = % prone_crawl2aim;
  array[animtype]["stop"]["prone"]["rifle"]["prone_2_crouch"] = % prone_2_crouch;
  array[animtype]["stop"]["prone"]["rifle"]["prone_2_stand"] = % prone_2_stand;
  array[animtype]["stop"]["prone"]["rifle"]["twitch"] = array(%prone_twitch_ammocheck, %prone_twitch_ammocheck2, %prone_twitch_look, %prone_twitch_lookfast, %prone_twitch_lookup, %prone_twitch_scan, %prone_twitch_scan2);
  array[animtype]["stop"]["prone"]["rifle"]["straight_level"] = % prone_aim_5;
  array[animtype]["stop"]["prone"]["rifle"]["idle"] = array(array(%prone_idle));
  array[animtype]["stop"]["stand"]["gas"]["idle"] = array(array(%ai_flamethrower_stand_idle_casual_v1, %ai_flamethrower_stand_idle_casual_v1, %ai_flamethrower_stand_idle_casual_v1, %ai_flamethrower_stand_twitch));
  array[animtype]["stop"]["crouch"]["gas"]["idle"] = array(array(%ai_flamethrower_crouch_idle_a, %ai_flamethrower_crouch_idle_a, %ai_flamethrower_crouch_idle_a, %ai_flamethrower_crouch_idle_b, %ai_flamethrower_crouch_idle_b, %ai_flamethrower_crouch_idle_b, %ai_flamethrower_crouch_twitch));
  array[animtype]["stop"]["stand"]["pistol"]["idle_trans_in"] = % ai_pistol_casual_stand_idle_trans_in;
  array[animtype]["stop"]["stand"]["pistol"]["idle"] = array(array(%ai_pistol_casual_stand_idle, %ai_pistol_casual_stand_idle_twitch_v1, %ai_pistol_casual_stand_idle_twitch_v2, %ai_pistol_casual_stand_idle_twitch_v3));
  array[animtype]["stop"]["stand"]["pistol"]["stand_2_crouch"] = % ai_pistol_stand_2_crouch;
  array[animtype]["stop"]["crouch"]["pistol"]["idle"] = array(array(%ai_pistol_casual_crouch_idle, %ai_pistol_casual_crouch_idle_twitch_v1, %ai_pistol_casual_crouch_idle_twitch_v2, %ai_pistol_casual_crouch_idle_twitch_v3));
  array[animtype]["stop"]["crouch"]["pistol"]["crouch_2_stand"] = % ai_pistol_crouch_2_stand;
  array[animtype]["stop"]["stand"]["bipod"]["aim"] = % standsawgunner_aim;
  array[animtype]["stop"]["stand"]["bipod"]["idle"] = % saw_gunner_idle;
  array[animtype]["stop"]["stand"]["bipod"]["fire"] = % saw_gunner_firing_add;
  array[animtype]["stop"]["crouch"]["bipod"]["aim"] = % crouchsawgunner_aim;
  array[animtype]["stop"]["crouch"]["bipod"]["idle"] = % saw_gunner_idle;
  array[animtype]["stop"]["crouch"]["bipod"]["fire"] = % saw_gunner_firing_add;
  array[animtype]["stop"]["prone"]["bipod"]["aim"] = % pronesawgunner_aim;
  array[animtype]["stop"]["prone"]["bipod"]["idle"] = % saw_gunner_idle;
  array[animtype]["stop"]["prone"]["bipod"]["fire"] = % saw_gunner_firing_add;
  array[animtype]["stop"]["stand"]["auto_gun_turret_sp"]["aim"] = % standsawgunner_aim;
  array[animtype]["stop"]["stand"]["auto_gun_turret_sp"]["idle"] = % saw_gunner_idle;
  array[animtype]["stop"]["stand"]["auto_gun_turret_sp"]["fire"] = % saw_gunner_firing_add;
  array[animtype]["cover_left"]["stand"]["rifle"]["reload"] = array(%corner_standl_reload_v1);
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_fire"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_semi2"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_semi3"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_semi4"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_semi5"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_burst2"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_burst3"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_burst4"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_burst5"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_burst6"] = % cornerstndl_lean_auto;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_single"] = array(%cornerstndl_lean_fire);
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_aim_down"] = % cornerstndl_lean_aim_2;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_aim_left"] = % cornerstndl_lean_aim_4;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_aim_straight"] = % cornerstndl_lean_aim_5;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_aim_right"] = % cornerstndl_lean_aim_6;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_aim_up"] = % cornerstndl_lean_aim_8;
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_idle"] = array(%cornerstndl_lean_idle);
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_idle"] = % corner_standl_alert_idle;
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_idle_twitch"] = array(%corner_standl_alert_twitch01, %corner_standl_alert_twitch02, %corner_standl_alert_twitch03, %corner_standl_alert_twitch04, %corner_standl_alert_twitch05, %corner_standl_alert_twitch06, %corner_standl_alert_twitch07);
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_idle_flinch"] = array(%corner_standl_flinch);
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_to_A"] = array(%corner_standl_trans_alert_2_a, %corner_standl_trans_alert_2_a_v2, %corner_standl_trans_alert_2_a_v3);
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_to_B"] = array(%corner_standl_trans_alert_2_b, %corner_standl_trans_alert_2_b_v2);
  array[animtype]["cover_left"]["stand"]["rifle"]["A_to_alert"] = array(%corner_standl_trans_a_2_alert, %corner_standl_trans_a_2_alert_v2);
  array[animtype]["cover_left"]["stand"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_left"]["stand"]["rifle"]["A_to_B"] = array(%corner_standl_trans_a_2_b, %corner_standl_trans_a_2_b_v2);
  array[animtype]["cover_left"]["stand"]["rifle"]["B_to_alert"] = array(%corner_standl_trans_b_2_alert, %corner_standl_trans_b_2_alert_v2);
  array[animtype]["cover_left"]["stand"]["rifle"]["B_to_alert_reload"] = array(%corner_standl_reload_b_2_alert);
  array[animtype]["cover_left"]["stand"]["rifle"]["B_to_A"] = array(%corner_standl_trans_b_2_a, %corner_standl_trans_b_2_a_v2);
  array[animtype]["cover_left"]["stand"]["rifle"]["lean_to_alert"] = array(%cornerstndl_lean_2_alert);
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_to_lean"] = array(%cornerstndl_alert_2_lean);
  array[animtype]["cover_left"]["stand"]["rifle"]["grenade_exposed"] = % corner_standl_grenade_a;
  array[animtype]["cover_left"]["stand"]["rifle"]["grenade_safe"] = % corner_standl_grenade_b;
  array[animtype]["cover_left"]["stand"]["rifle"]["grenade_throw"] = % stand_grenade_throw;
  array[animtype]["cover_left"]["stand"]["rifle"]["blind_fire"] = array(%corner_standl_blindfire_v2);
  array[animtype]["cover_left"]["stand"]["rifle"]["blind_fire_add_aim_up"] = % ai_cornerstndl_blindfire_v2_aim8;
  array[animtype]["cover_left"]["stand"]["rifle"]["blind_fire_add_aim_down"] = % ai_cornerstndl_blindfire_v2_aim2;
  array[animtype]["cover_left"]["stand"]["rifle"]["blind_fire_add_aim_left"] = % ai_cornerstndl_blindfire_v2_aim4;
  array[animtype]["cover_left"]["stand"]["rifle"]["blind_fire_add_aim_right"] = % ai_cornerstndl_blindfire_v2_aim6;
  array[animtype]["cover_left"]["stand"]["rifle"]["alert_to_look"] = % corner_standl_alert_2_look;
  array[animtype]["cover_left"]["stand"]["rifle"]["look_to_alert"] = % corner_standl_look_2_alert;
  array[animtype]["cover_left"]["stand"]["rifle"]["look_to_alert_fast"] = % corner_standl_look_2_alert_fast_v1;
  array[animtype]["cover_left"]["stand"]["rifle"]["look_idle"] = % corner_standl_look_idle;
  array[animtype]["cover_left"]["stand"]["rifle"]["stance_change"] = % cornercrl_stand_2_alert;
  array[animtype]["cover_left"]["stand"]["rifle"]["weapon_switch"] = % ai_stand_exposed_weaponswitch;
  array[animtype]["cover_left"]["stand"]["rifle"]["weapon_switch_cover"] = % ai_corner_left_weaponswitch;
  array[animtype]["cover_left"]["stand"]["rifle"]["death_react"] = array(%ai_exposed_backpedal);
  array[animtype]["cover_left"]["stand"]["rifle"]["death_react_ik"] = array(%ai_look_at_corner_stand_left_flinch);
  array[animtype]["cover_left"]["crouch"]["rifle"]["reload"] = array(%cornercrl_reloada, %cornercrl_reloadb);
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_fire"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_semi2"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_semi3"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_semi4"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_semi5"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_burst2"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_burst3"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_burst4"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_burst5"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_burst6"] = % cornercrl_lean_auto;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_single"] = array(%cornercrl_lean_fire);
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_aim_down"] = % ai_cornercrl_lean_aim_2;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_aim_left"] = % ai_cornercrl_lean_aim_4;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_aim_straight"] = % ai_cornercrl_lean_aim_5;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_aim_right"] = % ai_cornercrl_lean_aim_6;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_aim_up"] = % ai_cornercrl_lean_aim_8;
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_idle"] = array(%cornercrl_lean_idle);
  array[animtype]["cover_left"]["crouch"]["rifle"]["over_aim_straight"] = % covercrouch_aim5;
  array[animtype]["cover_left"]["crouch"]["rifle"]["over_aim_up"] = % covercrouch_aim2_add;
  array[animtype]["cover_left"]["crouch"]["rifle"]["over_aim_down"] = % covercrouch_aim4_add;
  array[animtype]["cover_left"]["crouch"]["rifle"]["over_aim_left"] = % covercrouch_aim6_add;
  array[animtype]["cover_left"]["crouch"]["rifle"]["over_aim_right"] = % covercrouch_aim8_add;
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_idle"] = % cornercrl_alert_idle;
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_idle_twitch"] = array();
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_idle_flinch"] = array();
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_to_A"] = array(%cornercrl_trans_alert_2_a);
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_to_B"] = array(%cornercrl_trans_alert_2_b);
  array[animtype]["cover_left"]["crouch"]["rifle"]["A_to_alert"] = array(%cornercrl_trans_a_2_alert);
  array[animtype]["cover_left"]["crouch"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_left"]["crouch"]["rifle"]["A_to_B"] = array(%cornercrl_trans_a_2_b);
  array[animtype]["cover_left"]["crouch"]["rifle"]["B_to_alert"] = array(%cornercrl_trans_b_2_alert);
  array[animtype]["cover_left"]["crouch"]["rifle"]["B_to_alert_reload"] = array();
  array[animtype]["cover_left"]["crouch"]["rifle"]["B_to_A"] = array(%cornercrl_trans_b_2_a);
  array[animtype]["cover_left"]["crouch"]["rifle"]["lean_to_alert"] = array(%cornercrl_lean_2_alert);
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_to_lean"] = array(%ai_cornercrl_alert_2_lean);
  array[animtype]["cover_left"]["crouch"]["rifle"]["over_to_alert"] = array(%cornercrl_over_2_alert);
  array[animtype]["cover_left"]["crouch"]["rifle"]["alert_to_over"] = array(%cornercrl_alert_2_over);
  array[animtype]["cover_left"]["crouch"]["rifle"]["look"] = % cornercrl_look_fast;
  array[animtype]["cover_left"]["crouch"]["rifle"]["grenade_safe"] = % cornercrl_grenadea;
  array[animtype]["cover_left"]["crouch"]["rifle"]["grenade_exposed"] = % cornercrl_grenadeb;
  array[animtype]["cover_left"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_over"] = array(%ai_cornercrl_blindfire_over);
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_over_add_aim_up"] = % ai_cornercrl_blindfire_over_aim8;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_over_add_aim_down"] = % ai_cornercrl_blindfire_over_aim2;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_over_add_aim_left"] = % ai_cornercrl_blindfire_over_aim4;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_over_add_aim_right"] = % ai_cornercrl_blindfire_over_aim6;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_fire"] = array(%ai_cornercrl_blindfire);
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_fire_add_aim_up"] = % ai_cornercrl_blindfire_aim8;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_fire_add_aim_down"] = % ai_cornercrl_blindfire_aim2;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_fire_add_aim_left"] = % ai_cornercrl_blindfire_aim4;
  array[animtype]["cover_left"]["crouch"]["rifle"]["blind_fire_add_aim_right"] = % ai_cornercrl_blindfire_aim6;
  array[animtype]["cover_left"]["crouch"]["rifle"]["stance_change"] = % cornercrl_alert_2_stand;
  array[animtype]["cover_left"]["crouch"]["rifle"]["weapon_switch"] = % ai_crouch_exposed_weaponswitch;
  array[animtype]["cover_left"]["crouch"]["rifle"]["weapon_switch_cover"] = % ai_crouch_corner_left_weaponswitch;
  array[animtype]["cover_right"]["stand"]["rifle"]["reload"] = array(%corner_standr_reload_v1);
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_fire"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_semi2"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_semi3"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_semi4"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_semi5"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_burst2"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_burst3"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_burst4"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_burst5"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_burst6"] = % cornerstndr_lean_auto;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_single"] = array(%cornerstndr_lean_fire);
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_aim_down"] = % cornerstndr_lean_aim_2;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_aim_left"] = % cornerstndr_lean_aim_4;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_aim_straight"] = % cornerstndr_lean_aim_5;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_aim_right"] = % cornerstndr_lean_aim_6;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_aim_up"] = % cornerstndr_lean_aim_8;
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_idle"] = array(%cornerstndr_lean_idle);
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_idle"] = % corner_standr_alert_idle;
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_idle_twitch"] = array(%corner_standr_alert_twitch01, %corner_standr_alert_twitch02, %corner_standr_alert_twitch03, %corner_standr_alert_twitch04, %corner_standr_alert_twitch05, %corner_standr_alert_twitch06, %corner_standr_alert_twitch07);
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_idle_flinch"] = array(%corner_standr_flinch, %corner_standr_flinchb);
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_to_A"] = array(%corner_standr_trans_alert_2_a, %corner_standr_trans_alert_2_a_v2);
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_to_B"] = array(%corner_standr_trans_alert_2_b, %corner_standr_trans_alert_2_b_v2, %corner_standr_trans_alert_2_b_v3);
  array[animtype]["cover_right"]["stand"]["rifle"]["A_to_alert"] = array(%corner_standr_trans_a_2_alert, %corner_standr_trans_a_2_alert_v2);
  array[animtype]["cover_right"]["stand"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_right"]["stand"]["rifle"]["A_to_B"] = array(%corner_standr_trans_a_2_b, %corner_standr_trans_a_2_b_v2);
  array[animtype]["cover_right"]["stand"]["rifle"]["B_to_alert"] = array(%corner_standr_trans_b_2_alert, %corner_standr_trans_b_2_alert_v2, %corner_standr_trans_b_2_alert_v3);
  array[animtype]["cover_right"]["stand"]["rifle"]["B_to_alert_reload"] = array(%corner_standr_reload_b_2_alert);
  array[animtype]["cover_right"]["stand"]["rifle"]["B_to_A"] = array(%corner_standr_trans_b_2_a);
  array[animtype]["cover_right"]["stand"]["rifle"]["lean_to_alert"] = array(%cornerstndr_lean_2_alert);
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_to_lean"] = array(%cornerstndr_alert_2_lean);
  array[animtype]["cover_right"]["stand"]["rifle"]["grenade_exposed"] = % corner_standr_grenade_a;
  array[animtype]["cover_right"]["stand"]["rifle"]["grenade_safe"] = % corner_standr_grenade_b;
  array[animtype]["cover_right"]["stand"]["rifle"]["grenade_throw"] = % stand_grenade_throw;
  array[animtype]["cover_right"]["stand"]["rifle"]["blind_fire"] = array(%corner_standr_blindfire_v1, %corner_standr_blindfire_v2);
  array[animtype]["cover_right"]["stand"]["rifle"]["blind_fire_add_aim_up"] = % ai_cornerstndr_blindfire_v2_aim8;
  array[animtype]["cover_right"]["stand"]["rifle"]["blind_fire_add_aim_down"] = % ai_cornerstndr_blindfire_v2_aim2;
  array[animtype]["cover_right"]["stand"]["rifle"]["blind_fire_add_aim_left"] = % ai_cornerstndr_blindfire_v2_aim4;
  array[animtype]["cover_right"]["stand"]["rifle"]["blind_fire_add_aim_right"] = % ai_cornerstndr_blindfire_v2_aim6;
  array[animtype]["cover_right"]["stand"]["rifle"]["alert_to_look"] = % corner_standr_alert_2_look;
  array[animtype]["cover_right"]["stand"]["rifle"]["look_to_alert"] = % corner_standr_look_2_alert;
  array[animtype]["cover_right"]["stand"]["rifle"]["look_to_alert_fast"] = % corner_standr_look_2_alert_fast;
  array[animtype]["cover_right"]["stand"]["rifle"]["look_idle"] = % corner_standr_look_idle;
  array[animtype]["cover_right"]["stand"]["rifle"]["stance_change"] = % cornercrr_stand_2_alert;
  array[animtype]["cover_right"]["stand"]["rifle"]["weapon_switch"] = % ai_stand_exposed_weaponswitch;
  array[animtype]["cover_right"]["stand"]["rifle"]["weapon_switch_cover"] = % ai_corner_right_weaponswitch;
  array[animtype]["cover_right"]["stand"]["rifle"]["death_react"] = array(%ai_exposed_backpedal);
  array[animtype]["cover_right"]["stand"]["rifle"]["death_react_ik"] = array(%ai_look_at_corner_stand_right_flinch);
  array[animtype]["cover_right"]["crouch"]["rifle"]["reload"] = array(%cornercrr_reloada, %cornercrr_reloadb);
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_fire"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_semi2"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_semi3"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_semi4"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_semi5"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_burst2"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_burst3"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_burst4"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_burst5"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_burst6"] = % cornercrr_lean_auto;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_single"] = array(%cornercrr_lean_fire);
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_aim_down"] = % ai_cornercrr_lean_aim_2;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_aim_left"] = % ai_cornercrr_lean_aim_4;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_aim_straight"] = % ai_cornercrr_lean_aim_5;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_aim_right"] = % ai_cornercrr_lean_aim_6;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_aim_up"] = % ai_cornercrr_lean_aim_8;
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_idle"] = array(%cornercrr_lean_idle);
  array[animtype]["cover_right"]["crouch"]["rifle"]["over_aim_straight"] = % covercrouch_aim5;
  array[animtype]["cover_right"]["crouch"]["rifle"]["over_aim_up"] = % covercrouch_aim2_add;
  array[animtype]["cover_right"]["crouch"]["rifle"]["over_aim_down"] = % covercrouch_aim4_add;
  array[animtype]["cover_right"]["crouch"]["rifle"]["over_aim_left"] = % covercrouch_aim6_add;
  array[animtype]["cover_right"]["crouch"]["rifle"]["over_aim_right"] = % covercrouch_aim8_add;
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_idle"] = % cornercrr_alert_idle;
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_idle_twitch"] = array(%cornercrr_alert_twitch_v1, %cornercrr_alert_twitch_v2, %cornercrr_alert_twitch_v3);
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_idle_flinch"] = array();
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_to_A"] = array(%cornercrr_trans_alert_2_a);
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_to_B"] = array(%cornercrr_trans_alert_2_b);
  array[animtype]["cover_right"]["crouch"]["rifle"]["A_to_alert"] = array(%cornercrr_trans_a_2_alert);
  array[animtype]["cover_right"]["crouch"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_right"]["crouch"]["rifle"]["A_to_B"] = array(%cornercrr_trans_a_2_b);
  array[animtype]["cover_right"]["crouch"]["rifle"]["B_to_alert"] = array(%cornercrr_trans_b_2_alert);
  array[animtype]["cover_right"]["crouch"]["rifle"]["B_to_alert_reload"] = array(%cornercrr_reload_b_2_alert);
  array[animtype]["cover_right"]["crouch"]["rifle"]["B_to_A"] = array(%cornercrr_trans_b_2_a);
  array[animtype]["cover_right"]["crouch"]["rifle"]["lean_to_alert"] = array(%cornercrr_lean_2_alert);
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_to_lean"] = array(%ai_cornercrr_alert_2_lean);
  array[animtype]["cover_right"]["crouch"]["rifle"]["over_to_alert"] = array(%cornercrr_over_2_alert);
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_to_over"] = array(%cornercrr_alert_2_over);
  array[animtype]["cover_right"]["crouch"]["rifle"]["alert_to_look"] = % cornercrr_alert_2_look;
  array[animtype]["cover_right"]["crouch"]["rifle"]["look_to_alert"] = % cornercrr_look_2_alert;
  array[animtype]["cover_right"]["crouch"]["rifle"]["look_to_alert_fast"] = % cornercrr_look_2_alert_fast;
  array[animtype]["cover_right"]["crouch"]["rifle"]["look_idle"] = % cornercrr_look_idle;
  array[animtype]["cover_right"]["crouch"]["rifle"]["grenade_safe"] = % cornercrr_grenadea;
  array[animtype]["cover_right"]["crouch"]["rifle"]["grenade_exposed"] = % cornercrr_grenadea;
  array[animtype]["cover_right"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_over"] = array(%ai_cornercrr_blindfire_over);
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_over_add_aim_up"] = % ai_cornercrr_blindfire_over_aim8;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_over_add_aim_down"] = % ai_cornercrr_blindfire_over_aim2;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_over_add_aim_left"] = % ai_cornercrr_blindfire_over_aim4;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_over_add_aim_right"] = % ai_cornercrr_blindfire_over_aim6;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_fire"] = array(%ai_cornercrr_blindfire);
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_fire_add_aim_up"] = % ai_cornercrr_blindfire_aim8;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_fire_add_aim_down"] = % ai_cornercrr_blindfire_aim2;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_fire_add_aim_left"] = % ai_cornercrr_blindfire_aim4;
  array[animtype]["cover_right"]["crouch"]["rifle"]["blind_fire_add_aim_right"] = % ai_cornercrr_blindfire_aim6;
  array[animtype]["cover_right"]["crouch"]["rifle"]["stance_change"] = % cornercrr_alert_2_stand;
  array[animtype]["cover_right"]["crouch"]["rifle"]["weapon_switch"] = % ai_crouch_exposed_weaponswitch;
  array[animtype]["cover_right"]["crouch"]["rifle"]["weapon_switch_cover"] = % ai_crouch_corner_right_weaponswitch;
  array[animtype]["cover_stand"]["stand"]["rifle"]["hide_idle"] = % coverstand_hide_idle;
  array[animtype]["cover_stand"]["stand"]["rifle"]["hide_idle_twitch"] = array(%coverstand_hide_idle_twitch01, %coverstand_hide_idle_twitch02, %coverstand_hide_idle_twitch03, %coverstand_hide_idle_twitch04, %coverstand_hide_idle_twitch05);
  array[animtype]["cover_stand"]["stand"]["rifle"]["hide_idle_flinch"] = array(%coverstand_react01, %coverstand_react02, %coverstand_react03, %coverstand_react04);
  array[animtype]["cover_stand"]["stand"]["rifle"]["hide_2_stand"] = % coverstand_hide_2_aim;
  array[animtype]["cover_stand"]["stand"]["rifle"]["stand_2_hide"] = % coverstand_aim_2_hide;
  array[animtype]["cover_stand"]["stand"]["rifle"]["hide_2_over"] = % ai_coverstand_2_coverstandaim;
  array[animtype]["cover_stand"]["stand"]["rifle"]["over_2_hide"] = % ai_coverstandaim_2_coverstand;
  array[animtype]["cover_stand"]["stand"]["rifle"]["stand_aim"] = % exposed_aim_5;
  array[animtype]["cover_stand"]["stand"]["rifle"]["crouch_aim"] = % covercrouch_aim5;
  array[animtype]["cover_stand"]["stand"]["rifle"]["lean_aim"] = % exposed_aim_5;
  array[animtype]["cover_stand"]["stand"]["rifle"]["over_aim"] = % ai_coverstandaim_aim5;
  array[animtype]["cover_stand"]["stand"]["rifle"]["over_add_aim_up"] = % ai_coverstandaim_aim8_add;
  array[animtype]["cover_stand"]["stand"]["rifle"]["over_add_aim_down"] = % ai_coverstandaim_aim2_add;
  array[animtype]["cover_stand"]["stand"]["rifle"]["over_add_aim_left"] = % ai_coverstandaim_aim4_add;
  array[animtype]["cover_stand"]["stand"]["rifle"]["over_add_aim_right"] = % ai_coverstandaim_aim6_add;
  array[animtype]["cover_stand"]["stand"]["rifle"]["fire"] = % ai_coverstandaim_fire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["single"] = array(%ai_coverstandaim_fire);
  array[animtype]["cover_stand"]["stand"]["rifle"]["burst2"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["burst3"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["burst4"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["burst5"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["burst6"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["semi2"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["semi3"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["semi4"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["semi5"] = % ai_coverstandaim_autofire;
  array[animtype]["cover_stand"]["stand"]["rifle"]["blind_fire"] = array(%coverstand_blindfire_1, %coverstand_blindfire_2);
  array[animtype]["cover_stand"]["stand"]["rifle"]["blind_fire_add_aim_up"] = % ai_coverstand_blindfire_2_aim8;
  array[animtype]["cover_stand"]["stand"]["rifle"]["blind_fire_add_aim_down"] = % ai_coverstand_blindfire_2_aim2;
  array[animtype]["cover_stand"]["stand"]["rifle"]["blind_fire_add_aim_left"] = % ai_coverstand_blindfire_2_aim4;
  array[animtype]["cover_stand"]["stand"]["rifle"]["blind_fire_add_aim_right"] = % ai_coverstand_blindfire_2_aim6;
  array[animtype]["cover_stand"]["stand"]["rifle"]["look"] = array(%coverstand_look_quick, %coverstand_look_quick_v2);
  array[animtype]["cover_stand"]["stand"]["rifle"]["hide_to_look"] = % coverstand_look_moveup;
  array[animtype]["cover_stand"]["stand"]["rifle"]["look_idle"] = % coverstand_look_idle;
  array[animtype]["cover_stand"]["stand"]["rifle"]["look_to_hide"] = % coverstand_look_movedown;
  array[animtype]["cover_stand"]["stand"]["rifle"]["look_to_hide_fast"] = % coverstand_look_movedown_fast;
  array[animtype]["cover_stand"]["stand"]["rifle"]["grenade_safe"] = array(%coverstand_grenadea, %coverstand_grenadeb);
  array[animtype]["cover_stand"]["stand"]["rifle"]["grenade_exposed"] = array(%coverstand_grenadea, %coverstand_grenadeb);
  array[animtype]["cover_stand"]["stand"]["rifle"]["grenade_throw"] = % stand_grenade_throw;
  array[animtype]["cover_stand"]["stand"]["rifle"]["reload"] = % coverstand_reloada;
  array[animtype]["cover_stand"]["stand"]["rifle"]["weapon_switch"] = % ai_stand_exposed_weaponswitch;
  array[animtype]["cover_stand"]["stand"]["rifle"]["weapon_switch_cover"] = % ai_stand_cover_hide_weaponswitch;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_idle"] = % covercrouch_hide_idle;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_idle_twitch"] = array(%covercrouch_twitch_1, %covercrouch_twitch_2, %covercrouch_twitch_3, %covercrouch_twitch_4);
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_idle_flinch"] = array();
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_2_crouch"] = % covercrouch_hide_2_aim;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_2_stand"] = % covercrouch_hide_2_stand;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_2_lean"] = % covercrouch_hide_2_lean;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_2_left"] = % ai_covercrouch_hide_2_left;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["hide_2_right"] = % ai_covercrouch_hide_2_right;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["crouch_2_hide"] = % ai_covercrouch_hide_2_coverstand;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["stand_2_hide"] = % covercrouch_stand_2_hide;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["lean_2_hide"] = % covercrouch_lean_2_hide;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["left_2_hide"] = % ai_covercrouch_left_2_hide;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["right_2_hide"] = % ai_covercrouch_right_2_hide;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["stand_aim"] = % exposed_aim_5;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["crouch_aim"] = % covercrouch_aim5;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["lean_aim"] = % exposed_aim_5;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["add_aim_up"] = % covercrouch_aim2_add;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["add_aim_down"] = % covercrouch_aim4_add;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["add_aim_left"] = % covercrouch_aim6_add;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["add_aim_right"] = % covercrouch_aim8_add;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["blind_fire"] = array(%covercrouch_blindfire_1, %covercrouch_blindfire_2, %covercrouch_blindfire_3, %covercrouch_blindfire_4);
  array[animtype]["cover_stand"]["crouch"]["rifle"]["look"] = array(%covercrouch_hide_look);
  array[animtype]["cover_stand"]["crouch"]["rifle"]["grenade_safe"] = array(%covercrouch_grenadea, %covercrouch_grenadeb);
  array[animtype]["cover_stand"]["crouch"]["rifle"]["grenade_exposed"] = array(%covercrouch_grenadea, %covercrouch_grenadeb);
  array[animtype]["cover_stand"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["reload"] = % covercrouch_reload_hide;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["weapon_switch"] = % ai_crouch_exposed_weaponswitch;
  array[animtype]["cover_stand"]["crouch"]["rifle"]["weapon_switch_cover"] = % ai_crouch_cover_hide_weaponswitch;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_idle"] = % covercrouch_hide_idle;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_idle_twitch"] = array(%covercrouch_twitch_1, %covercrouch_twitch_2, %covercrouch_twitch_3, %covercrouch_twitch_4);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_idle_flinch"] = array();
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["exposed_idle"] = array(%covercrouch_hide_idlea, %covercrouch_hide_idleb);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["fire"] = % covercrouch_hide_burst6;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["single"] = array(%covercrouch_hide_burst1);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["burst2"] = % covercrouch_hide_semiauto_burst2;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["burst3"] = % covercrouch_hide_burst3;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["burst4"] = % covercrouch_hide_burst4;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["burst5"] = % covercrouch_hide_burst5;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["burst6"] = % covercrouch_hide_burst6;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["semi2"] = % covercrouch_hide_semiauto_burst2;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["semi3"] = % covercrouch_hide_burst3;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["semi4"] = % covercrouch_hide_burst4;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["semi5"] = % covercrouch_hide_burst5;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_2_crouch"] = % covercrouch_hide_2_aim;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_2_stand"] = % covercrouch_hide_2_stand;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_2_lean"] = % covercrouch_hide_2_lean;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_2_left"] = % ai_covercrouch_hide_2_left;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["hide_2_right"] = % ai_covercrouch_hide_2_right;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["crouch_2_hide"] = % covercrouch_aim_2_hide;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["stand_2_hide"] = % covercrouch_stand_2_hide;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["lean_2_hide"] = % covercrouch_lean_2_hide;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["left_2_hide"] = % ai_covercrouch_left_2_hide;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["right_2_hide"] = % ai_covercrouch_right_2_hide;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["stand_aim"] = % exposed_aim_5;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["crouch_aim"] = % covercrouch_aim5;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["lean_aim"] = % exposed_aim_5;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["add_aim_up"] = % covercrouch_aim2_add;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["add_aim_down"] = % covercrouch_aim4_add;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["add_aim_left"] = % covercrouch_aim6_add;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["add_aim_right"] = % covercrouch_aim8_add;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["blind_fire"] = array(%covercrouch_blindfire_1, %covercrouch_blindfire_2);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["blind_fire_add_aim_up"] = % ai_covercrouch_blindfire_1_aim8;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["blind_fire_add_aim_down"] = % ai_covercrouch_blindfire_1_aim2;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["blind_fire_add_aim_left"] = % ai_covercrouch_blindfire_1_aim4;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["blind_fire_add_aim_right"] = % ai_covercrouch_blindfire_1_aim6;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["look"] = array(%covercrouch_hide_look);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["grenade_safe"] = array(%covercrouch_grenadea, %covercrouch_grenadeb);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["grenade_exposed"] = array(%covercrouch_grenadea, %covercrouch_grenadeb);
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["reload"] = % covercrouch_reload_hide;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["weapon_switch"] = % ai_crouch_exposed_weaponswitch;
  array[animtype]["cover_crouch"]["crouch"]["rifle"]["weapon_switch_cover"] = % ai_crouch_cover_hide_weaponswitch;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_idle"] = % coverstand_hide_idle;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_idle_twitch"] = array(%coverstand_hide_idle_twitch01, %coverstand_hide_idle_twitch02, %coverstand_hide_idle_twitch03, %coverstand_hide_idle_twitch04, %coverstand_hide_idle_twitch05);
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_idle_flinch"] = array(%coverstand_react01, %coverstand_react02, %coverstand_react03, %coverstand_react04);
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_2_crouch"] = % covercrouch_hide_2_aim;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_2_stand"] = % coverstand_hide_2_aim;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_2_lean"] = % covercrouch_hide_2_lean;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["crouch_2_hide"] = % covercrouch_aim_2_hide;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["stand_2_hide"] = % covercrouch_stand_2_hide;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["lean_2_hide"] = % covercrouch_lean_2_hide;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["stand_aim"] = % exposed_aim_5;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["crouch_aim"] = % covercrouch_aim5;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["lean_aim"] = % exposed_aim_5;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["blind_fire"] = array(%coverstand_blindfire_1, %coverstand_blindfire_2);
  array[animtype]["cover_crouch"]["stand"]["rifle"]["look"] = array(%coverstand_look_quick, %coverstand_look_quick_v2);
  array[animtype]["cover_crouch"]["stand"]["rifle"]["hide_to_look"] = % coverstand_look_moveup;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["look_idle"] = % coverstand_look_idle;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["look_to_hide"] = % coverstand_look_movedown;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["look_to_hide_fast"] = % coverstand_look_movedown_fast;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["grenade_safe"] = array(%coverstand_grenadea, %coverstand_grenadeb);
  array[animtype]["cover_crouch"]["stand"]["rifle"]["grenade_exposed"] = array(%coverstand_grenadea, %coverstand_grenadeb);
  array[animtype]["cover_crouch"]["stand"]["rifle"]["grenade_throw"] = % stand_grenade_throw;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["reload"] = % coverstand_reloada;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["weapon_switch"] = % ai_stand_exposed_weaponswitch;
  array[animtype]["cover_crouch"]["stand"]["rifle"]["weapon_switch_cover"] = % ai_stand_cover_hide_weaponswitch;
  array[animtype]["cover_prone"]["prone"]["rifle"]["straight_level"] = % prone_aim_5;
  array[animtype]["cover_prone"]["prone"]["rifle"]["fire"] = % prone_fire_1;
  array[animtype]["cover_prone"]["prone"]["rifle"]["semi2"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["semi3"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["semi4"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["semi5"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["single"] = array(%prone_fire_1);
  array[animtype]["cover_prone"]["prone"]["rifle"]["burst2"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["burst3"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["burst4"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["burst5"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["burst6"] = % prone_fire_burst;
  array[animtype]["cover_prone"]["prone"]["rifle"]["reload"] = % prone_reload;
  array[animtype]["cover_prone"]["prone"]["rifle"]["straight_level"] = % prone_aim_5;
  array[animtype]["cover_prone"]["prone"]["rifle"]["add_aim_up"] = % prone_aim_8_add;
  array[animtype]["cover_prone"]["prone"]["rifle"]["add_aim_down"] = % prone_aim_2_add;
  array[animtype]["cover_prone"]["prone"]["rifle"]["add_aim_left"] = % prone_aim_4_add;
  array[animtype]["cover_prone"]["prone"]["rifle"]["add_aim_right"] = % prone_aim_6_add;
  array[animtype]["cover_prone"]["prone"]["rifle"]["look"] = array(%prone_twitch_look, %prone_twitch_lookfast, %prone_twitch_lookup);
  array[animtype]["cover_prone"]["prone"]["rifle"]["grenade_safe"] = array(%prone_grenade_a, %prone_grenade_a);
  array[animtype]["cover_prone"]["prone"]["rifle"]["grenade_exposed"] = array(%prone_grenade_a, %prone_grenade_a);
  array[animtype]["cover_prone"]["prone"]["rifle"]["prone_idle"] = array(%prone_idle);
  array[animtype]["cover_prone"]["prone"]["rifle"]["hide_to_look"] = % coverstand_look_moveup;
  array[animtype]["cover_prone"]["prone"]["rifle"]["look_idle"] = % coverstand_look_idle;
  array[animtype]["cover_prone"]["prone"]["rifle"]["look_to_hide"] = % coverstand_look_movedown;
  array[animtype]["cover_prone"]["prone"]["rifle"]["look_to_hide_fast"] = % coverstand_look_movedown_fast;
  array[animtype]["cover_prone"]["stand"]["rifle"]["stand_2_prone"] = % stand_2_prone_nodelta;
  array[animtype]["cover_prone"]["crouch"]["rifle"]["crouch_2_prone"] = % crouch_2_prone;
  array[animtype]["cover_prone"]["prone"]["rifle"]["prone_2_stand"] = % prone_2_stand_nodelta;
  array[animtype]["cover_prone"]["prone"]["rifle"]["prone_2_crouch"] = % prone_2_crouch;
  array[animtype]["cover_prone"]["stand"]["rifle"]["stand_2_prone_firing"] = % stand_2_prone_firing;
  array[animtype]["cover_prone"]["crouch"]["rifle"]["crouch_2_prone_firing"] = % crouch_2_prone_firing;
  array[animtype]["cover_prone"]["prone"]["rifle"]["prone_2_stand_firing"] = % prone_2_stand_firing;
  array[animtype]["cover_prone"]["prone"]["rifle"]["prone_2_crouch_firing"] = % prone_2_crouch_firing;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_fire"] = % ai_pillar2_stand_alert_l_auto;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_semi2"] = % ai_pillar2_stand_alert_l_semi_2;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_semi3"] = % ai_pillar2_stand_alert_l_semi_3;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_semi4"] = % ai_pillar2_stand_alert_l_semi_4;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_semi5"] = % ai_pillar2_stand_alert_l_semi_5;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_burst2"] = % ai_pillar2_stand_alert_l_burst_3;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_burst3"] = % ai_pillar2_stand_alert_l_burst_3;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_burst4"] = % ai_pillar2_stand_alert_l_burst_4;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_burst5"] = % ai_pillar2_stand_alert_l_burst_5;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_burst6"] = % ai_pillar2_stand_alert_l_burst_6;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_single"] = array(%ai_pillar2_stand_alert_l_semi_1);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_aim_down"] = % ai_pillar2_stand_alert_l_aim2;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_aim_left"] = % ai_pillar2_stand_alert_l_aim4;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_aim_straight"] = % ai_pillar2_stand_alert_l_aim5;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_aim_right"] = % ai_pillar2_stand_alert_l_aim6;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_aim_up"] = % ai_pillar2_stand_alert_l_aim8;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["alert_to_A"] = array(%ai_pillar2_stand_idle_2_a_left);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["alert_to_B"] = array(%ai_pillar2_stand_idle_2_b_left);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["A_to_alert"] = array(%ai_pillar2_stand_a_left_2_idle);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["A_to_B"] = array(%ai_pillar2_stand_a_left_2_b_left);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["B_to_alert"] = array(%ai_pillar2_stand_b_left_2_idle);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["B_to_alert_reload"] = array();
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["B_to_A"] = array(%ai_pillar2_stand_b_left_2_a_left);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["alert_idle"] = % ai_pillar2_stand_idle;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["alert_idle_twitch"] = array(%ai_pillar2_stand_idle_twitch_01, %ai_pillar2_stand_idle_twitch_04, %ai_pillar2_stand_idle_twitch_03);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_idle"] = array(%ai_pillar2_stand_alert_l_idle);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["alert_to_lean"] = array(%ai_pillar2_stand_idle_2_alert_l);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["lean_to_alert"] = array(%ai_pillar2_stand_alert_l_2_idle);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_fire"] = array(%ai_pillar2_stand_alert_l_blindfire);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_fire_add_aim_up"] = % ai_pillar2_stand_alert_l_blindfire_aim8;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_fire_add_aim_down"] = % ai_pillar2_stand_alert_l_blindfire_aim2;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_fire_add_aim_left"] = % ai_pillar2_stand_alert_l_blindfire_aim4;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_fire_add_aim_right"] = % ai_pillar2_stand_alert_l_blindfire_aim6;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_over"] = array(%ai_pillar2_stand_alert_o_blindfire);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_over_add_aim_up"] = % ai_pillar2_stand_alert_o_blindfire_aim8;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_over_add_aim_down"] = % ai_pillar2_stand_alert_o_blindfire_aim2;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_over_add_aim_left"] = % ai_pillar2_stand_alert_o_blindfire_aim4;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["blind_over_add_aim_right"] = % ai_pillar2_stand_alert_o_blindfire_aim2;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["look"] = array(%ai_pillar2_stand_idle_peek_l_01);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["reload"] = array(%ai_pillar2_stand_reload_02, %ai_pillar2_stand_reload_03);
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["stance_change"] = % ai_pillar2_stand_2_crouch;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["grenade_exposed"] = % ai_pillar2_stand_idle_grenade_throw_l_01;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["grenade_safe"] = % ai_pillar2_stand_idle_grenade_throw_l_02;
  array[animtype]["cover_pillar_left"]["stand"]["rifle"]["grenade_throw"] = % stand_grenade_throw;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_fire"] = % ai_pillar2_crouch_alert_l_auto;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_semi2"] = % ai_pillar2_crouch_alert_l_semi_2;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_semi3"] = % ai_pillar2_crouch_alert_l_semi_3;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_semi4"] = % ai_pillar2_crouch_alert_l_semi_4;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_semi5"] = % ai_pillar2_crouch_alert_l_semi_5;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_burst2"] = % ai_pillar2_crouch_alert_l_burst_3;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_burst3"] = % ai_pillar2_crouch_alert_l_burst_3;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_burst4"] = % ai_pillar2_crouch_alert_l_burst_4;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_burst5"] = % ai_pillar2_crouch_alert_l_burst_5;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_burst6"] = % ai_pillar2_crouch_alert_l_burst_6;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_single"] = array(%ai_pillar2_crouch_alert_l_semi_1);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_aim_down"] = % ai_pillar2_crouch_alert_l_aim2;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_aim_left"] = % ai_pillar2_crouch_alert_l_aim4;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_aim_straight"] = % ai_pillar2_crouch_alert_l_aim5;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_aim_right"] = % ai_pillar2_crouch_alert_l_aim6;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_aim_up"] = % ai_pillar2_crouch_alert_l_aim8;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["alert_to_A"] = array(%ai_pillar2_crouch_idle_2_a_left);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["alert_to_B"] = array(%ai_pillar2_crouch_idle_2_b_left);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["A_to_alert"] = array(%ai_pillar2_crouch_a_left_2_idle);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["A_to_B"] = array(%ai_pillar2_crouch_a_left_2_b_left);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["B_to_alert"] = array(%ai_pillar2_crouch_b_left_2_idle);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["B_to_alert_reload"] = array();
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["B_to_A"] = array(%ai_pillar2_crouch_b_left_2_a_left);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["alert_idle"] = % ai_pillar2_crouch_idle;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["alert_idle_twitch"] = array(%ai_pillar2_crouch_idle_twitch_01, %ai_pillar2_crouch_idle_twitch_02);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_idle"] = array(%ai_pillar2_crouch_alert_l_idle);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["reload"] = array(%ai_pillar2_crouch_reload_01);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["alert_to_lean"] = array(%ai_pillar2_crouch_idle_2_alert_l);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["lean_to_alert"] = array(%ai_pillar2_crouch_alert_l_2_idle);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_fire"] = array(%ai_pillar2_crouch_alert_l_blindfire);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_fire_add_aim_up"] = % ai_pillar2_crouch_alert_l_blindfire_aim8;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_fire_add_aim_down"] = % ai_pillar2_crouch_alert_l_blindfire_aim2;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_fire_add_aim_left"] = % ai_pillar2_crouch_alert_l_blindfire_aim4;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_fire_add_aim_right"] = % ai_pillar2_crouch_alert_l_blindfire_aim6;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over"] = array(%ai_pillar2_crouch_alert_o_blindfire);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_up"] = % ai_pillar2_crouch_alert_o_blindfire_aim8;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_down"] = % ai_pillar2_crouch_alert_o_blindfire_aim2;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_left"] = % ai_pillar2_crouch_alert_o_blindfire_aim4;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_right"] = % ai_pillar2_crouch_alert_o_blindfire_aim6;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["look"] = array(%ai_pillar2_crouch_idle_twitch_03);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["stance_change"] = % ai_pillar2_crouch_2_stand;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["grenade_exposed"] = % ai_pillar2_crouch_idle_grenade_throw_l_01;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["grenade_safe"] = % ai_pillar2_crouch_idle_grenade_throw_l_02;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_fire"] = % ai_pillar2_stand_alert_r_auto;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_semi2"] = % ai_pillar2_stand_alert_r_semi_2;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_semi3"] = % ai_pillar2_stand_alert_r_semi_3;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_semi4"] = % ai_pillar2_stand_alert_r_semi_4;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_semi5"] = % ai_pillar2_stand_alert_r_semi_5;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_burst2"] = % ai_pillar2_stand_alert_r_burst_3;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_burst3"] = % ai_pillar2_stand_alert_r_burst_3;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_burst4"] = % ai_pillar2_stand_alert_r_burst_4;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_burst5"] = % ai_pillar2_stand_alert_r_burst_5;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_burst6"] = % ai_pillar2_stand_alert_r_burst_6;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_single"] = array(%ai_pillar2_stand_alert_r_semi_1);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_aim_down"] = % ai_pillar2_stand_alert_r_aim2;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_aim_left"] = % ai_pillar2_stand_alert_r_aim4;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_aim_straight"] = % ai_pillar2_stand_alert_r_aim5;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_aim_right"] = % ai_pillar2_stand_alert_r_aim6;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_aim_up"] = % ai_pillar2_stand_alert_r_aim8;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["alert_to_A"] = array(%ai_pillar2_stand_idle_2_a_right);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["alert_to_B"] = array(%ai_pillar2_stand_idle_2_b_right);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["A_to_alert"] = array(%ai_pillar2_stand_a_right_2_idle);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["A_to_B"] = array(%ai_pillar2_stand_a_right_2_b_right);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["B_to_alert"] = array(%ai_pillar2_stand_b_right_2_idle);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["B_to_alert_reload"] = array();
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["B_to_A"] = array(%ai_pillar2_stand_b_right_2_a_right);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["alert_idle"] = % ai_pillar2_stand_idle;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["alert_idle_twitch"] = array(%ai_pillar2_stand_idle_twitch_01, %ai_pillar2_stand_idle_twitch_04, %ai_pillar2_stand_idle_twitch_03);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_idle"] = array(%ai_pillar2_stand_alert_r_idle);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["alert_to_lean"] = array(%ai_pillar2_stand_idle_2_alert_r);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["lean_to_alert"] = array(%ai_pillar2_stand_alert_r_2_idle);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_fire"] = array(%ai_pillar2_stand_alert_r_blindfire);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_fire_add_aim_up"] = % ai_pillar2_stand_alert_r_blindfire_aim8;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_fire_add_aim_down"] = % ai_pillar2_stand_alert_r_blindfire_aim2;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_fire_add_aim_left"] = % ai_pillar2_stand_alert_r_blindfire_aim4;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_fire_add_aim_right"] = % ai_pillar2_stand_alert_r_blindfire_aim6;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_over"] = array(%ai_pillar2_stand_alert_o_blindfire);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_over_add_aim_up"] = % ai_pillar2_stand_alert_o_blindfire_aim8;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_over_add_aim_down"] = % ai_pillar2_stand_alert_o_blindfire_aim2;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_over_add_aim_left"] = % ai_pillar2_stand_alert_o_blindfire_aim4;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["blind_over_add_aim_right"] = % ai_pillar2_stand_alert_o_blindfire_aim2;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["look"] = array(%ai_pillar2_stand_idle_peek_r_01);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["reload"] = array(%ai_pillar2_stand_reload_02, %ai_pillar2_stand_reload_03);
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["stance_change"] = % ai_pillar2_stand_2_crouch;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["grenade_exposed"] = % ai_pillar2_stand_idle_grenade_throw_r_01;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["grenade_safe"] = % ai_pillar2_stand_idle_grenade_throw_r_02;
  array[animtype]["cover_pillar_right"]["stand"]["rifle"]["grenade_throw"] = % stand_grenade_throw;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_fire"] = % ai_pillar2_crouch_alert_r_auto;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_semi2"] = % ai_pillar2_crouch_alert_r_semi_2;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_semi3"] = % ai_pillar2_crouch_alert_r_semi_3;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_semi4"] = % ai_pillar2_crouch_alert_r_semi_4;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_semi5"] = % ai_pillar2_crouch_alert_r_semi_5;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_burst2"] = % ai_pillar2_crouch_alert_r_burst_3;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_burst3"] = % ai_pillar2_crouch_alert_r_burst_3;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_burst4"] = % ai_pillar2_crouch_alert_r_burst_4;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_burst5"] = % ai_pillar2_crouch_alert_r_burst_5;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_burst6"] = % ai_pillar2_crouch_alert_r_burst_6;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_single"] = array(%ai_pillar2_crouch_alert_r_semi_1);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_aim_down"] = % ai_pillar2_crouch_alert_r_aim2;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_aim_left"] = % ai_pillar2_crouch_alert_r_aim4;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_aim_straight"] = % ai_pillar2_crouch_alert_r_aim5;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_aim_right"] = % ai_pillar2_crouch_alert_r_aim6;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_aim_up"] = % ai_pillar2_crouch_alert_r_aim8;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["alert_to_A"] = array(%ai_pillar2_crouch_idle_2_a_right);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["alert_to_B"] = array(%ai_pillar2_crouch_idle_2_b_right);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["A_to_alert"] = array(%ai_pillar2_crouch_a_right_2_idle);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["A_to_alert_reload"] = array();
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["A_to_B"] = array(%ai_pillar2_crouch_a_right_2_b_right);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["B_to_alert"] = array(%ai_pillar2_crouch_b_right_2_idle);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["B_to_alert_reload"] = array();
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["B_to_A"] = array(%ai_pillar2_crouch_b_right_2_a_right);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["alert_idle"] = % ai_pillar2_crouch_idle;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["alert_idle_twitch"] = array(%ai_pillar2_crouch_idle_twitch_01, %ai_pillar2_crouch_idle_twitch_02, %ai_pillar2_crouch_idle_twitch_03, %ai_pillar2_crouch_idle_twitch_04);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_idle"] = array(%ai_pillar2_crouch_alert_r_idle);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["reload"] = array(%ai_pillar2_crouch_reload_01);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["alert_to_lean"] = array(%ai_pillar2_crouch_idle_2_alert_r);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["lean_to_alert"] = array(%ai_pillar2_crouch_alert_r_2_idle);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["blind_fire"] = array(%ai_pillar2_crouch_alert_r_blindfire);
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["blind_fire_add_aim_up"] = % ai_pillar2_crouch_alert_r_blindfire_aim8;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["blind_fire_add_aim_down"] = % ai_pillar2_crouch_alert_r_blindfire_aim2;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["blind_fire_add_aim_left"] = % ai_pillar2_crouch_alert_r_blindfire_aim4;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["blind_fire_add_aim_right"] = % ai_pillar2_crouch_alert_r_blindfire_aim6;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over"] = array(%ai_pillar2_crouch_alert_o_blindfire);
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_up"] = % ai_pillar2_crouch_alert_o_blindfire_aim8;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_down"] = % ai_pillar2_crouch_alert_o_blindfire_aim2;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_left"] = % ai_pillar2_crouch_alert_o_blindfire_aim4;
  array[animtype]["cover_pillar_left"]["crouch"]["rifle"]["blind_over_add_aim_right"] = % ai_pillar2_crouch_alert_o_blindfire_aim6;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["look"] = % ai_pillar2_crouch_idle_twitch_04;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["stance_change"] = % ai_pillar2_crouch_2_stand;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["grenade_exposed"] = % ai_pillar2_crouch_idle_grenade_throw_r_01;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["grenade_safe"] = % ai_pillar2_crouch_idle_grenade_throw_r_02;
  array[animtype]["cover_pillar_right"]["crouch"]["rifle"]["grenade_throw"] = % crouch_grenade_throw;
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar"] = array(%ai_pillar2_stand_idle_pain, %ai_pillar2_stand_idle_pain_03);
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar_l_return"] = array(%ai_pillar2_stand_alert_l_pain_return_02);
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar_r_return"] = array(%ai_pillar2_stand_alert_r_pain_return_03);
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar"] = array(%ai_pillar2_crouch_idle_pain, %ai_pillar2_crouch_idle_pain_02, %ai_pillar2_crouch_idle_pain_03);
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar_l_return"] = array(%ai_pillar2_crouch_alert_l_pain_return_02);
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar_r_return"] = array(%ai_pillar2_crouch_alert_r_pain_return);
  array[animtype]["death"]["stand"]["rifle"]["cover_pillar_front"] = array(%ai_pillar2_stand_idle_death_01, %ai_pillar2_stand_idle_death_02);
  array[animtype]["death"]["stand"]["rifle"]["cover_pillar_right"] = array(%ai_pillar2_stand_alert_r_death_01, %ai_pillar2_stand_alert_r_death_02);
  array[animtype]["death"]["stand"]["rifle"]["cover_pillar_left"] = array(%ai_pillar2_stand_alert_l_death_01, %ai_pillar2_stand_alert_l_death_02);
  array[animtype]["death"]["crouch"]["rifle"]["cover_pillar_left"] = array(%ai_pillar2_crouch_alert_l_death_01, %ai_pillar2_crouch_alert_l_death_02);
  array[animtype]["death"]["crouch"]["rifle"]["cover_pillar_right"] = array(%ai_pillar2_crouch_alert_r_death_01, %ai_pillar2_crouch_alert_r_death_02);
  array[animtype]["death"]["crouch"]["rifle"]["cover_pillar_front"] = array(%ai_pillar2_crouch_idle_death_01, %ai_pillar2_crouch_idle_death_02);
  array[animtype]["pain"]["stand"]["pistol"]["chest"] = % ai_pistol_stand_exposed_pain_chest;
  array[animtype]["pain"]["stand"]["pistol"]["groin"] = % ai_pistol_stand_exposed_pain_groin;
  array[animtype]["pain"]["stand"]["pistol"]["head"] = % ai_pistol_stand_exposed_pain_head;
  array[animtype]["pain"]["stand"]["pistol"]["left_arm"] = % ai_pistol_stand_exposed_pain_leftshoulder;
  array[animtype]["pain"]["stand"]["pistol"]["right_arm"] = % ai_pistol_stand_exposed_pain_rightshoulder;
  array[animtype]["pain"]["stand"]["pistol"]["leg"] = array(%ai_pistol_stand_exposed_pain_leftleg, %ai_pistol_stand_exposed_pain_rightleg);
  array[animtype]["pain"]["stand"]["rifle"]["chest"] = % exposed_pain_back;
  array[animtype]["pain"]["stand"]["rifle"]["groin"] = % exposed_pain_groin;
  array[animtype]["pain"]["stand"]["rifle"]["head"] = % ai_stand_exposed_pain_face;
  array[animtype]["pain"]["stand"]["rifle"]["left_arm"] = % exposed_pain_left_arm;
  array[animtype]["pain"]["stand"]["rifle"]["right_arm"] = % exposed_pain_right_arm;
  array[animtype]["pain"]["stand"]["rifle"]["leg"] = array(%exposed_pain_leg);
  array[animtype]["pain"]["stand"]["rifle"]["big"] = % exposed_pain_2_crouch;
  array[animtype]["pain"]["stand"]["rifle"]["drop_gun"] = % exposed_pain_dropgun;
  array[animtype]["pain"]["stand"]["gas"]["chest"] = % ai_flamethrower_stand_pain;
  array[animtype]["pain"]["stand"]["rifle"]["upper_torso_extended"] = array(%ai_stand_exposed_pain_face, %ai_stand_exposed_extendedpain_b);
  array[animtype]["pain"]["stand"]["rifle"]["lower_torso_extended"] = array(%ai_stand_exposed_extendedpain_hip_2_crouch, %ai_stand_exposed_extendedpain_gut);
  array[animtype]["pain"]["stand"]["rifle"]["legs_extended"] = array(%ai_stand_exposed_extendedpain_thigh, %ai_stand_exposed_extendedpain_hip);
  array[animtype]["pain"]["prone"]["rifle"]["chest"] = array(%prone_reaction_a, %prone_reaction_b);
  array[animtype]["pain"]["back"]["rifle"]["chest"] = % back_pain;
  array[animtype]["pain"]["stand"]["rifle"]["burn_chest"] = array(%ai_flame_wounded_stand_a, %ai_flame_wounded_stand_b, %ai_flame_wounded_stand_c, %ai_flame_wounded_stand_d);
  array[animtype]["pain"]["stand"]["gas"]["burn_chest"] = array(%ai_flamethrower_wounded_stand_arm, %ai_flamethrower_wounded_stand_chest, %ai_flamethrower_wounded_stand_head, %ai_flamethrower_wounded_stand_leg);
  array[animtype]["pain"]["stand"]["pistol"]["run_long"] = array(%ai_pistol_run_lowready_f_pain_head, %ai_pistol_run_lowready_f_pain_chest);
  array[animtype]["pain"]["stand"]["pistol"]["run_medium"] = array(%ai_pistol_run_lowready_f_pain_groin);
  array[animtype]["pain"]["stand"]["pistol"]["run_short"] = array(%ai_pistol_run_lowready_f_pain_groin);
  array[animtype]["pain"]["stand"]["rifle"]["run_long"] = array(%ai_run_pain_leg, %ai_run_pain_stomach_stumble, %ai_run_pain_head, %ai_run_pain_shoulder);
  array[animtype]["pain"]["stand"]["rifle"]["run_medium"] = array(%run_pain_fallonknee_02, %run_pain_stomach, %ai_run_pain_stomach_fast, %ai_run_pain_leg_fast, %ai_run_pain_fall);
  array[animtype]["pain"]["stand"]["rifle"]["run_short"] = array(%run_pain_fallonknee, %run_pain_fallonknee_03);
  array[animtype]["pain"]["crouch"]["gas"]["chest"] = % ai_flamethrower_crouch_pain;
  array[animtype]["pain"]["crouch"]["rifle"]["chest"] = % exposed_crouch_pain_chest;
  array[animtype]["pain"]["crouch"]["rifle"]["head"] = % exposed_crouch_pain_headsnap;
  array[animtype]["pain"]["crouch"]["rifle"]["left_arm"] = % exposed_crouch_pain_left_arm;
  array[animtype]["pain"]["crouch"]["rifle"]["right_arm"] = % exposed_crouch_pain_right_arm;
  array[animtype]["pain"]["crouch"]["rifle"]["flinch"] = % exposed_crouch_pain_flinch;
  array[animtype]["pain"]["crouch"]["pistol"]["chest"] = % ai_pistol_crouch_exposed_pain_chest;
  array[animtype]["pain"]["crouch"]["pistol"]["head"] = % ai_pistol_crouch_exposed_pain_head;
  array[animtype]["pain"]["crouch"]["pistol"]["left_arm"] = % ai_pistol_crouch_exposed_pain_left_arm;
  array[animtype]["pain"]["crouch"]["pistol"]["right_arm"] = % ai_pistol_crouch_exposed_pain_right_arm;
  array[animtype]["pain"]["crouch"]["pistol"]["flinch"] = % ai_pistol_crouch_exposed_pain_groin;
  array[animtype]["pain"]["crouch"]["rifle"]["burn_chest"] = array(%ai_flame_wounded_crouch_a, %ai_flame_wounded_crouch_b, %ai_flame_wounded_crouch_c, %ai_flame_wounded_crouch_d);
  array[animtype]["combat"]["stand"]["rifle"]["balcony"] = array(%ai_balcony_death_01, %ai_balcony_death_02, %ai_balcony_death_03, %ai_balcony_death_04, %ai_balcony_death_05);
  array[animtype]["combat"]["stand"]["rifle"]["balcony_norailing"] = array(%ai_roof_death_01, %ai_roof_death_02, %ai_roof_death_04, %ai_roof_death_05, %ai_roof_death_06, %ai_roof_death_07);
  array[animtype]["pain"]["stand"]["rifle"]["stand_2_crawl"] = array(%dying_stand_2_crawl_v1, %dying_stand_2_crawl_v2, %dying_stand_2_crawl_v3);
  array[animtype]["pain"]["crouch"]["rifle"]["crouch_2_crawl"] = array(%dying_crouch_2_crawl);
  array[animtype]["pain"]["prone"]["rifle"]["prone_2_back"] = array(%dying_crawl_2_back);
  array[animtype]["pain"]["stand"]["rifle"]["stand_2_back"] = array(%dying_stand_2_back_v1, %dying_stand_2_back_v2, %dying_stand_2_back_v3);
  array[animtype]["pain"]["crouch"]["rifle"]["crouch_2_back"] = array(%dying_crouch_2_back);
  array[animtype]["pain"]["back"]["rifle"]["back_idle"] = % dying_back_idle;
  array[animtype]["pain"]["back"]["rifle"]["back_idle_twitch"] = array(%dying_back_twitch_a, %dying_back_twitch_b);
  array[animtype]["pain"]["back"]["rifle"]["back_crawl"] = % dying_crawl_back;
  array[animtype]["pain"]["back"]["rifle"]["back_fire"] = % dying_back_fire;
  array[animtype]["pain"]["back"]["rifle"]["back_death"] = array(%dying_back_death_v1, %dying_back_death_v2, %dying_back_death_v3);
  array[animtype]["pain"]["prone"]["rifle"]["crawl"] = % dying_crawl;
  array[animtype]["pain"]["prone"]["rifle"]["death"] = array(%dying_crawl_death_v1, %dying_crawl_death_v2);
  array[animtype]["pain"]["back"]["pistol"]["aim_left"] = % dying_back_aim_4;
  array[animtype]["pain"]["back"]["pistol"]["aim_right"] = % dying_back_aim_6;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_head"] = % corner_standl_pain;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_groin"] = % corner_standl_painb;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_chest"] = % corner_standl_painc;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_left_leg"] = % corner_standl_paind;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_right_leg"] = % corner_standl_paine;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_A"] = % ai_cornerstnd_l_pain_a_2_alert;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_B"] = % ai_cornerstnd_l_pain_b_2_alert;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_lean"] = % ai_cornerstnd_l_pain_lean_2_alert;
  array[animtype]["pain"]["stand"]["rifle"]["cover_left_blindfire"] = % ai_cornerstnd_l_pain_blindfire_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left"] = % ai_cornercrl_pain_b;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left_left_leg"] = % ai_cornercrl_pain_b;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left_right_leg"] = % ai_cornercrl_pain_b;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left_A"] = % ai_cornercrl_pain_a_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left_B"] = % ai_cornercrl_pain_b_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left_lean"] = % ai_cornercrl_pain_lean_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_left_over"] = % ai_cornercrl_pain_over_2_alert;
  array[animtype]["pain"]["stand"]["rifle"]["cover_right_chest"] = % corner_standr_pain;
  array[animtype]["pain"]["stand"]["rifle"]["cover_right_groin"] = % corner_standr_painc;
  array[animtype]["pain"]["stand"]["rifle"]["cover_right_right_leg"] = % corner_standr_painb;
  array[animtype]["pain"]["stand"]["rifle"]["cover_right_A"] = % ai_cornerstnd_r_pain_a_2_alert;
  array[animtype]["pain"]["stand"]["rifle"]["cover_right_B"] = % ai_cornerstnd_r_pain_b_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_right"] = array(%ai_cornercrr_alert_pain_a, %ai_cornercrr_alert_pain_c);
  array[animtype]["pain"]["crouch"]["rifle"]["cover_right_A"] = % ai_cornercrr_pain_a_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_right_B"] = % ai_cornercrr_pain_b_2_alert;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_right_over"] = % ai_cornercrr_pain_over_2_alert;
  array[animtype]["pain"]["stand"]["rifle"]["cover_stand_chest"] = % coverstand_pain_groin;
  array[animtype]["pain"]["stand"]["rifle"]["cover_stand_groin"] = % coverstand_pain_groin;
  array[animtype]["pain"]["stand"]["rifle"]["cover_stand_left_leg"] = % coverstand_pain_leg;
  array[animtype]["pain"]["stand"]["rifle"]["cover_stand_right_leg"] = % coverstand_pain_leg;
  array[animtype]["pain"]["stand"]["rifle"]["cover_stand_aim"] = array(%ai_coverstand_aim_pain_2_hide_01, %ai_coverstand_aim_pain_2_hide_02);
  array[animtype]["pain"]["crouch"]["rifle"]["cover_stand_chest"] = % coverstand_pain_groin;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_stand_groin"] = % coverstand_pain_groin;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_stand_left_leg"] = % coverstand_pain_leg;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_stand_right_leg"] = % coverstand_pain_leg;
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar_left_A"] = % ai_pillar2_stand_left_a_pain;
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar_left_B"] = % ai_pillar2_stand_left_b_pain;
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar_right_A"] = % ai_pillar2_stand_right_a_pain;
  array[animtype]["pain"]["stand"]["rifle"]["cover_pillar_right_B"] = % ai_pillar2_stand_right_b_pain;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar_left_A"] = % ai_pillar2_crouch_left_a_pain;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar_left_B"] = % ai_pillar2_crouch_left_b_pain;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar_right_A"] = % ai_pillar2_crouch_right_a_pain;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_pillar_right_B"] = % ai_pillar2_crouch_right_b_pain;
  array[animtype]["pain"]["stand"]["rifle"]["cover_crouch_front"] = % covercrouch_pain_front;
  array[animtype]["pain"]["stand"]["rifle"]["cover_crouch_left"] = % covercrouch_pain_left_3;
  array[animtype]["pain"]["stand"]["rifle"]["cover_crouch_right"] = % covercrouch_pain_right;
  array[animtype]["pain"]["stand"]["rifle"]["cover_crouch_back"] = % covercrouch_pain_right_2;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_front"] = % covercrouch_pain_front;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_left"] = % covercrouch_pain_left_3;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_right"] = % covercrouch_pain_right;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_back"] = % covercrouch_pain_right_2;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_aim"] = % ai_covercrouch_pain_aim_2_hide_01;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_aim_right"] = % ai_covercrouch_pain_aim_2_hide_01_r;
  array[animtype]["pain"]["crouch"]["rifle"]["cover_crouch_aim_left"] = % ai_covercrouch_pain_aim_2_hide_01_l;
  array[animtype]["pain"]["stand"]["rifle"]["saw_chest"] = % saw_gunner_pain;
  array[animtype]["pain"]["crouch"]["rifle"]["saw_chest"] = % saw_gunner_lowwall_pain_02;
  array[animtype]["pain"]["prone"]["rifle"]["saw_chest"] = % saw_gunner_prone_pain;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_back_explode_v1"] = % ai_death_crossbow_back_panic_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_back_explode_v2"] = % ai_death_crossbow_back_reach_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_front_explode_v1"] = % ai_death_crossbow_front_panic_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_front_explode_v2"] = % ai_death_crossbow_front_warn_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_l_arm_explode_v1"] = % ai_death_crossbow_l_arm_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_l_arm_explode_v2"] = % ai_death_crossbow_l_arm_panic_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_l_leg_explode_v1"] = % ai_death_crossbow_l_leg_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_l_leg_explode_v2"] = % ai_death_crossbow_l_leg_hop_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_r_arm_explode_v1"] = % ai_death_crossbow_r_arm_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_r_arm_explode_v2"] = % ai_death_crossbow_r_arm_panic_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_r_leg_explode_v1"] = % ai_death_crossbow_r_leg_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_r_leg_explode_v2"] = % ai_death_crossbow_r_leg_hop_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_run_back_explode"] = % ai_death_crossbow_run_back_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_run_front_explode"] = % ai_death_crossbow_run_front_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_run_l_arm_explode"] = % ai_death_crossbow_run_l_arm_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_run_l_leg_explode"] = % ai_death_crossbow_run_l_leg_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_run_r_arm_explode"] = % ai_death_crossbow_run_r_arm_explode;
  array[animtype]["pain"]["stand"]["rifle"]["crossbow_run_r_leg_explode"] = % ai_death_crossbow_run_r_leg_explode;
  array[animtype]["react"]["stand"]["rifle"]["cover_left_ne"] = array(%ai_corner_stand_l_react_a);
  array[animtype]["react"]["stand"]["rifle"]["cover_crouch_ne"] = array(%ai_crouch_cover_reaction_a, %ai_crouch_cover_reaction_b);
  array[animtype]["react"]["crouch"]["rifle"]["cover_crouch_ne"] = array(%ai_crouch_cover_reaction_a, %ai_crouch_cover_reaction_b);
  array[animtype]["react"]["stand"]["rifle"]["cover_right_ne"] = array(%ai_corner_stand_r_react_a);
  array[animtype]["react"]["stand"]["rifle"]["cover_stand_ne"] = array(%ai_stand_cover_reaction_a, %ai_stand_cover_reaction_b);
  array[animtype]["react"]["stand"]["rifle"]["run_head"] = % ai_run_lowready_f_miss_detect_head;
  array[animtype]["react"]["stand"]["rifle"]["run_lower_torso_fast"] = % ai_run_lowready_f_miss_detect_legs;
  array[animtype]["react"]["stand"]["rifle"]["run_lower_torso_stop"] = % ai_run_lowready_f_miss_detect_stop;
  array[animtype]["react"]["stand"]["rifle"]["sprint_head"] = % ai_sprint_f_miss_detect_head;
  array[animtype]["react"]["stand"]["rifle"]["sprint_lower_torso_fast"] = % ai_sprint_f_miss_detect_legs;
  array[animtype]["react"]["stand"]["rifle"]["sprint_lower_torso_stop"] = % ai_sprint_f_miss_detect_stop;
  array[animtype]["react"]["stand"]["rifle"]["combat_ne"] = array(%ai_exposed_backpedal, %ai_exposed_idle_react_b);
  array[animtype]["react"]["crouch"]["rifle"]["combat_ne"] = array(%ai_exposed_backpedal, %ai_exposed_idle_react_b);
  array[animtype]["death"]["stand"]["pistol"]["front"] = % pistol_death_1;
  array[animtype]["death"]["stand"]["pistol"]["back"] = % pistol_death_2;
  array[animtype]["death"]["stand"]["pistol"]["groin"] = % pistol_death_3;
  array[animtype]["death"]["stand"]["pistol"]["head"] = % pistol_death_4;
  array[animtype]["death"]["stand"]["gas"]["front"] = % ai_flamethrower_stand_death;
  array[animtype]["death"]["stand"]["gas"]["back"] = % death_explosion_up10;
  array[animtype]["death"]["crouch"]["gas"]["front"] = % ai_flamethrower_crouch_death;
  array[animtype]["death"]["stand"]["saw"]["front"] = % saw_gunner_death;
  array[animtype]["death"]["crouch"]["saw"]["front"] = % saw_gunner_lowwall_death;
  array[animtype]["death"]["prone"]["saw"]["front"] = % saw_gunner_prone_death;
  array[animtype]["death"]["stand"]["rifle"]["front"] = % ai_death_fallforward;
  array[animtype]["death"]["stand"]["rifle"]["back"] = % ai_death_fallforward_b;
  array[animtype]["death"]["stand"]["rifle"]["front_2"] = % ai_death_deadfallknee;
  array[animtype]["death"]["stand"]["rifle"]["firing_1"] = % exposed_death_firing;
  array[animtype]["death"]["stand"]["rifle"]["firing_2"] = % exposed_death_firing;
  array[animtype]["death"]["stand"]["rifle"]["groin"] = % exposed_death_groin;
  array[animtype]["death"]["stand"]["rifle"]["left_leg_start"] = % ai_deadly_wounded_leg_l_hit;
  array[animtype]["death"]["stand"]["rifle"]["left_leg_loop"] = % ai_deadly_wounded_leg_l_loop;
  array[animtype]["death"]["stand"]["rifle"]["left_leg_end"] = % ai_deadly_wounded_leg_l_die;
  array[animtype]["death"]["stand"]["rifle"]["right_leg_start"] = % ai_deadly_wounded_leg_r_hit;
  array[animtype]["death"]["stand"]["rifle"]["right_leg_loop"] = % ai_deadly_wounded_leg_r_loop;
  array[animtype]["death"]["stand"]["rifle"]["right_leg_end"] = % ai_deadly_wounded_leg_r_die;
  array[animtype]["death"]["stand"]["rifle"]["torso_start"] = % ai_deadly_wounded_torso_hit;
  array[animtype]["death"]["stand"]["rifle"]["torso_loop"] = % ai_deadly_wounded_torso_loop;
  array[animtype]["death"]["stand"]["rifle"]["torso_end"] = % ai_deadly_wounded_torso_die;
  array[animtype]["death"]["stand"]["rifle"]["head_1"] = % exposed_death_headshot;
  array[animtype]["death"]["stand"]["rifle"]["head_2"] = % exposed_death_headtwist;
  array[animtype]["death"]["stand"]["rifle"]["nerve"] = % exposed_death_nerve;
  array[animtype]["death"]["stand"]["rifle"]["neckgrab"] = % exposed_death_neckgrab;
  array[animtype]["death"]["stand"]["rifle"]["fall_to_knees_1"] = % exposed_death_falltoknees;
  array[animtype]["death"]["stand"]["rifle"]["fall_to_knees_2"] = % exposed_death_falltoknees_02;
  array[animtype]["death"]["stand"]["rifle"]["twist"] = % exposed_death_twist;
  array[animtype]["death"]["stand"]["rifle"]["head"] = % exposed_death_headshot;
  array[animtype]["death"]["stand"]["rifle"]["armslegsforward"] = % ai_death_armslegsforward;
  array[animtype]["death"]["stand"]["rifle"]["flyback"] = array(%ai_death_flyback, %ai_death_shotgun_back_v1);
  array[animtype]["death"]["stand"]["rifle"]["flyback_far"] = array(%ai_death_flyback_far, %ai_death_shotgun_back_v2, %ai_death_sniper_2);
  array[animtype]["death"]["stand"]["rifle"]["jackiespin_inplace"] = % ai_death_jackiespin_inplace;
  array[animtype]["death"]["stand"]["rifle"]["jackiespin_left"] = array(%ai_death_jackiespin_left, %ai_death_shotgun_spinr);
  array[animtype]["death"]["stand"]["rifle"]["jackiespin_right"] = array(%ai_death_jackiespin_right, %ai_death_shotgun_spinl);
  array[animtype]["death"]["stand"]["rifle"]["jackiespin_vertical"] = array(%ai_death_jackiespin_vertical, %ai_death_sniper_4);
  array[animtype]["death"]["stand"]["rifle"]["heavy_flyback"] = array(%ai_death_stand_heavyshot_back, %ai_death_shotgun_back_v2, %ai_stand_exposed_death_blowback);
  array[animtype]["death"]["stand"]["rifle"]["faceplant"] = % ai_death_faceplant;
  array[animtype]["death"]["stand"]["rifle"]["flatonback"] = array(%ai_death_flatonback, %ai_stand_exposed_death_blowback);
  array[animtype]["death"]["stand"]["rifle"]["legsout_left"] = array(%ai_death_legsout_left, %ai_death_shotgun_legs);
  array[animtype]["death"]["stand"]["rifle"]["legsout_right"] = array(%ai_death_legsout_right, %ai_death_shotgun_legs);
  array[animtype]["death"]["stand"]["rifle"]["upontoback"] = array(%ai_death_flatonback, %ai_stand_exposed_death_blowback);
  array[animtype]["death"]["stand"]["rifle"]["collapse"] = % ai_death_deadfallknee;
  array[animtype]["death"]["stand"]["rifle"]["deadfallknee"] = % ai_death_deadfallknee;
  array[animtype]["death"]["stand"]["rifle"]["fallforward"] = % ai_death_fallforward;
  array[animtype]["death"]["stand"]["rifle"]["fallforward_b"] = % ai_death_fallforward_b;
  array[animtype]["death"]["stand"]["rifle"]["forwardtoface"] = % ai_death_forwardtoface;
  array[animtype]["death"]["stand"]["rifle"]["gutshot"] = % ai_death_gutshot_fallback;
  array[animtype]["death"]["stand"]["rifle"]["stumblefall"] = % ai_death_stumblefall;
  array[animtype]["death"]["stand"]["rifle"]["neckgrab2"] = % exposed_death_neckgrab;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_back"] = % ai_death_crossbow_back;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_front"] = % ai_death_crossbow_front;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_l_arm"] = % ai_death_crossbow_l_arm;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_l_leg"] = % ai_death_crossbow_l_leg;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_r_arm"] = % ai_death_crossbow_r_arm;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_r_leg"] = % ai_death_crossbow_r_leg;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_run_back"] = % ai_death_crossbow_run_back;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_run_front"] = % ai_death_crossbow_run_front;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_run_l_arm"] = % ai_death_crossbow_run_l_arm;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_run_l_leg"] = % ai_death_crossbow_run_l_leg;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_run_r_arm"] = % ai_death_crossbow_run_r_arm;
  array[animtype]["death"]["stand"]["rifle"]["crossbow_run_r_leg"] = % ai_death_crossbow_run_r_leg;
  array[animtype]["death"]["crouch"]["rifle"]["front"] = % exposed_crouch_death_fetal;
  array[animtype]["death"]["crouch"]["rifle"]["front_2"] = % exposed_crouch_death_twist;
  array[animtype]["death"]["crouch"]["rifle"]["front_3"] = % exposed_crouch_death_flip;
  array[animtype]["death"]["prone"]["rifle"]["front"] = % prone_death_quickdeath;
  array[animtype]["death"]["prone"]["rifle"]["crawl"] = array(%dying_crawl_death_v1, %dying_crawl_death_v2);
  array[animtype]["death"]["back"]["rifle"]["front"] = array(%dying_back_death_v1, %dying_back_death_v2, %dying_back_death_v3, %dying_back_death_v4);
  array[animtype]["death"]["back"]["rifle"]["crawl"] = array(%dying_back_death_v2, %dying_back_death_v3, %dying_back_death_v4);
  array[animtype]["death"]["stand"]["rifle"]["run_front_1"] = % run_death_fallonback;
  array[animtype]["death"]["stand"]["rifle"]["run_front_2"] = % run_death_fallonback_02;
  array[animtype]["death"]["stand"]["rifle"]["run_front_3"] = % run_death_flop;
  array[animtype]["death"]["stand"]["rifle"]["run_back_1"] = % run_death_facedown;
  array[animtype]["death"]["stand"]["rifle"]["run_back_2"] = % run_death_roll;
  array[animtype]["death"]["stand"]["rocketlauncher"]["front"] = % rpg_stand_death;
  array[animtype]["death"]["stand"]["rocketlauncher"]["stagger"] = % rpg_stand_death_stagger;
  array[animtype]["death"]["crouch"]["rocketlauncher"]["front"] = % rpg_stand_death;
  array[animtype]["death"]["crouch"]["rocketlauncher"]["stagger"] = % rpg_stand_death_stagger;
  array[animtype]["death"]["prone"]["rocketlauncher"]["front"] = % rpg_stand_death;
  array[animtype]["death"]["prone"]["rocketlauncher"]["stagger"] = % rpg_stand_death_stagger;
  array[animtype]["death"]["back"]["rocketlauncher"]["front"] = % rpg_stand_death;
  array[animtype]["death"]["back"]["rocketlauncher"]["stagger"] = % rpg_stand_death_stagger;
  array[animtype]["death"]["stand"]["rocketlauncher"]["firing_1"] = % rpg_stand_death;
  array[animtype]["death"]["stand"]["rocketlauncher"]["firing_2"] = % rpg_stand_death;
  array[animtype]["death"]["stand"]["rifle"]["chest_blowback"] = % stand_death_chest_blowback;
  array[animtype]["death"]["stand"]["rifle"]["chest_spin"] = % stand_death_chest_spin;
  array[animtype]["death"]["stand"]["rifle"]["chest_stunned"] = % stand_death_chest_stunned;
  array[animtype]["death"]["stand"]["rifle"]["crotch"] = % stand_death_crotch;
  array[animtype]["death"]["stand"]["rifle"]["face"] = % stand_death_face;
  array[animtype]["death"]["stand"]["rifle"]["fallside"] = % stand_death_fallside;
  array[animtype]["death"]["stand"]["rifle"]["guts"] = % stand_death_chest_blowback;
  array[animtype]["death"]["stand"]["rifle"]["head_straight_back"] = % stand_death_head_straight_back;
  array[animtype]["death"]["stand"]["rifle"]["headshot_slowfall"] = % stand_death_headshot_slowfall;
  array[animtype]["death"]["stand"]["rifle"]["leg"] = % stand_death_head_straight_back;
  array[animtype]["death"]["stand"]["rifle"]["shoulder_spin"] = % stand_death_shoulder_spin;
  array[animtype]["death"]["stand"]["rifle"]["shoulder_stumble"] = % stand_death_shoulder_stumble;
  array[animtype]["death"]["stand"]["rifle"]["shoulderback"] = % stand_death_shoulderback;
  array[animtype]["death"]["stand"]["rifle"]["tumbleback"] = % stand_death_tumbleback;
  array[animtype]["death"]["stand"]["rifle"]["tumbleforward"] = % stand_death_tumbleforward;
  array[animtype]["death"]["stand"]["rifle"]["sniper_uncharged"] = array(%ai_death_flyback, %stand_death_tumbleforward, %ai_death_sniper_2, %ai_death_jackiespin_left, %ai_death_jackiespin_right, %ai_death_sniper_4, %ai_stand_exposed_death_blowback);
  array[animtype]["death"]["stand"]["rifle"]["charged_front_low"] = array(%ai_death_armslegsforward, %ai_death_flyback_far, %ai_death_shotgun_back_v1, %ai_death_shotgun_back_v2, %death_explosion_run_b_v2, %ai_death_stand_heavyshot_back);
  array[animtype]["death"]["stand"]["rifle"]["charged_front_high"] = array(%death_explosion_stand_up_v2, %death_explosion_stand_b_v2, %death_explosion_stand_b_v4, %ai_death_sniper_charged_b_05);
  array[animtype]["death"]["stand"]["rifle"]["charged_right"] = array(%death_explosion_stand_l_v1, %ai_death_shotgun_spinl);
  array[animtype]["death"]["stand"]["rifle"]["charged_left"] = array(%death_explosion_stand_r_v2, %ai_death_shotgun_spinr);
  array[animtype]["death"]["stand"]["rifle"]["charged_back"] = array(%death_explosion_stand_f_v4);
  array[animtype]["death"]["stand"]["rifle"]["tazer"] = array(%ai_death_taser_stand_01, %ai_death_taser_stand_02, %ai_death_taser_stand_03, %ai_death_taser_stand_04);
  array[animtype]["death"]["stand"]["rifle"]["tazer_running"] = array(%ai_death_taser_run_01, %ai_death_taser_run_02);
  array[animtype]["death"]["crouch"]["rifle"]["tazer"] = array(%ai_death_taser_crouch_01, %ai_death_taser_crouch_02);
  array[animtype]["death"]["crouch"]["rifle"]["tazer_running"] = array(%ai_death_taser_crouch_01, %ai_death_taser_crouch_02);
  array[animtype]["death"]["stand"]["rifle"]["cover_right_front"] = array(%corner_standr_deatha, %corner_standr_deathb);
  array[animtype]["death"]["crouch"]["rifle"]["cover_right_front"] = array(%ai_cornercrr_alert_death_back, %ai_cornercrr_alert_death_slideout);
  array[animtype]["death"]["stand"]["rifle"]["cover_left_front"] = array(%corner_standl_deatha, %corner_standl_deathb);
  array[animtype]["death"]["crouch"]["rifle"]["cover_left_front"] = array(%ai_cornercrl_death_back, %ai_cornercrl_death_side);
  array[animtype]["death"]["stand"]["rifle"]["cover_stand_front"] = array(%coverstand_death_left, %coverstand_death_right);
  array[animtype]["death"]["stand"]["rifle"]["cover_crouch_front_1"] = % covercrouch_death_1;
  array[animtype]["death"]["stand"]["rifle"]["cover_crouch_front_2"] = % covercrouch_death_2;
  array[animtype]["death"]["stand"]["rifle"]["cover_crouch_back"] = % covercrouch_death_3;
  array[animtype]["death"]["crouch"]["rifle"]["cover_crouch_front_1"] = % covercrouch_death_1;
  array[animtype]["death"]["crouch"]["rifle"]["cover_crouch_front_2"] = % covercrouch_death_2;
  array[animtype]["death"]["crouch"]["rifle"]["cover_crouch_back"] = % covercrouch_death_3;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_1"] = % ai_flame_death_a;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_2"] = % ai_flame_death_b;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_3"] = % ai_flame_death_c;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_4"] = % ai_flame_death_d;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_5"] = % ai_flame_death_e;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_6"] = % ai_flame_death_f;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_7"] = % ai_flame_death_g;
  array[animtype]["death"]["stand"]["rifle"]["flame_front_8"] = % ai_flame_death_h;
  array[animtype]["death"]["stand"]["rifle"]["flameA_start"] = % ai_deadly_wounded_flameda_hit;
  array[animtype]["death"]["stand"]["rifle"]["flameA_loop"] = % ai_deadly_wounded_flameda_loop;
  array[animtype]["death"]["stand"]["rifle"]["flameA_end"] = % ai_deadly_wounded_flameda_die;
  array[animtype]["death"]["stand"]["rifle"]["flameB_start"] = % ai_deadly_wounded_flamedb_hit;
  array[animtype]["death"]["stand"]["rifle"]["flameB_loop"] = % ai_deadly_wounded_flamedb_loop;
  array[animtype]["death"]["stand"]["rifle"]["flameB_end"] = % ai_deadly_wounded_flamedb_die;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_1"] = % ai_flame_death_crouch_a;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_2"] = % ai_flame_death_crouch_b;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_3"] = % ai_flame_death_crouch_c;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_4"] = % ai_flame_death_crouch_d;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_5"] = % ai_flame_death_crouch_e;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_6"] = % ai_flame_death_crouch_f;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_7"] = % ai_flame_death_crouch_g;
  array[animtype]["death"]["crouch"]["gas"]["flame_front_8"] = % ai_flame_death_crouch_h;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_1"] = % ai_flame_death_crouch_a;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_2"] = % ai_flame_death_crouch_b;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_3"] = % ai_flame_death_crouch_c;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_4"] = % ai_flame_death_crouch_d;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_5"] = % ai_flame_death_crouch_e;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_6"] = % ai_flame_death_crouch_f;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_7"] = % ai_flame_death_crouch_g;
  array[animtype]["death"]["crouch"]["rifle"]["flame_front_8"] = % ai_flame_death_crouch_h;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_1"] = % ai_gas_death_a;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_2"] = % ai_gas_death_b;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_3"] = % ai_gas_death_c;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_4"] = % ai_gas_death_d;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_5"] = % ai_gas_death_e;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_6"] = % ai_gas_death_f;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_7"] = % ai_gas_death_g;
  array[animtype]["death"]["stand"]["rifle"]["gas_front_8"] = % ai_gas_death_h;
  array[animtype]["death"]["stand"]["rifle"]["gasA_start"] = % ai_deadly_wounded_gasseda_hit;
  array[animtype]["death"]["stand"]["rifle"]["gasA_loop"] = % ai_deadly_wounded_gasseda_loop;
  array[animtype]["death"]["stand"]["rifle"]["gasA_end"] = % ai_deadly_wounded_gasseda_die;
  array[animtype]["death"]["stand"]["rifle"]["gasB_start"] = % ai_deadly_wounded_gassedb_hit;
  array[animtype]["death"]["stand"]["rifle"]["gasB_loop"] = % ai_deadly_wounded_gassedb_loop;
  array[animtype]["death"]["stand"]["rifle"]["gasB_end"] = % ai_deadly_wounded_gassedb_die;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_1"] = % ai_gas_death_a;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_2"] = % ai_gas_death_b;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_3"] = % ai_gas_death_c;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_4"] = % ai_gas_death_d;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_5"] = % ai_gas_death_e;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_6"] = % ai_gas_death_f;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_7"] = % ai_gas_death_g;
  array[animtype]["death"]["crouch"]["rifle"]["gas_front_8"] = % ai_gas_death_h;
  array[animtype]["death"]["crouch"]["rifle"]["gasA_start"] = % ai_deadly_wounded_gasseda_hit;
  array[animtype]["death"]["crouch"]["rifle"]["gasA_loop"] = % ai_deadly_wounded_gasseda_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gasA_end"] = % ai_deadly_wounded_gasseda_die;
  array[animtype]["death"]["crouch"]["rifle"]["gasB_start"] = % ai_deadly_wounded_gassedb_hit;
  array[animtype]["death"]["crouch"]["rifle"]["gasB_loop"] = % ai_deadly_wounded_gassedb_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gasB_end"] = % ai_deadly_wounded_gassedb_die;
  array[animtype]["death"]["stand"]["rifle"]["gib_guts_start"] = % ai_gib_torso_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_guts_loop"] = % ai_gib_torso_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_guts_end"] = % ai_gib_torso_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_no_legs_start"] = % ai_gib_bothlegs_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_no_legs_loop"] = % ai_gib_bothlegs_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_no_legs_end"] = % ai_gib_bothlegs_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_leg_front_start"] = % ai_gib_leftleg_front_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_leg_front_loop"] = % ai_gib_leftleg_front_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_leg_front_end"] = % ai_gib_leftleg_front_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_leg_back_start"] = % ai_gib_leftleg_back_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_leg_back_loop"] = % ai_gib_leftleg_back_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_leg_back_end"] = % ai_gib_leftleg_back_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_leg_front_start"] = % ai_gib_rightleg_front_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_leg_front_loop"] = % ai_gib_rightleg_front_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_leg_front_end"] = % ai_gib_rightleg_front_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_leg_back_start"] = % ai_gib_rightleg_back_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_leg_back_loop"] = % ai_gib_rightleg_back_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_leg_back_end"] = % ai_gib_rightleg_back_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_arm_front_start"] = % ai_gib_leftarm_front_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_arm_front_loop"] = % ai_gib_leftarm_front_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_arm_front_end"] = % ai_gib_leftarm_front_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_arm_back_start"] = % ai_gib_leftarm_back_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_arm_back_loop"] = % ai_gib_leftarm_back_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_left_arm_back_end"] = % ai_gib_leftarm_back_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_arm_front_start"] = % ai_gib_rightarm_front_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_arm_front_loop"] = % ai_gib_rightarm_front_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_arm_front_end"] = % ai_gib_rightarm_front_death;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_arm_back_start"] = % ai_gib_rightarm_back_gib;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_arm_back_loop"] = % ai_gib_rightarm_back_loop;
  array[animtype]["death"]["stand"]["rifle"]["gib_right_arm_back_end"] = % ai_gib_rightarm_back_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_guts_start"] = % ai_gib_torso_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_guts_loop"] = % ai_gib_torso_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_guts_end"] = % ai_gib_torso_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_no_legs_start"] = % ai_gib_bothlegs_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_no_legs_loop"] = % ai_gib_bothlegs_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_no_legs_end"] = % ai_gib_bothlegs_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_leg_front_start"] = % ai_gib_leftleg_front_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_leg_front_loop"] = % ai_gib_leftleg_front_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_leg_front_end"] = % ai_gib_leftleg_front_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_leg_back_start"] = % ai_gib_leftleg_back_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_leg_back_loop"] = % ai_gib_leftleg_back_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_leg_back_end"] = % ai_gib_leftleg_back_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_leg_front_start"] = % ai_gib_rightleg_front_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_leg_front_loop"] = % ai_gib_rightleg_front_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_leg_front_end"] = % ai_gib_rightleg_front_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_leg_back_start"] = % ai_gib_rightleg_back_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_leg_back_loop"] = % ai_gib_rightleg_back_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_leg_back_end"] = % ai_gib_rightleg_back_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_arm_front_start"] = % ai_gib_leftarm_front_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_arm_front_loop"] = % ai_gib_leftarm_front_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_arm_front_end"] = % ai_gib_leftarm_front_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_arm_back_start"] = % ai_gib_leftarm_back_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_arm_back_loop"] = % ai_gib_leftarm_back_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_left_arm_back_end"] = % ai_gib_leftarm_back_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_arm_front_start"] = % ai_gib_rightarm_front_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_arm_front_loop"] = % ai_gib_rightarm_front_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_arm_front_end"] = % ai_gib_rightarm_front_death;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_arm_back_start"] = % ai_gib_rightarm_back_gib;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_arm_back_loop"] = % ai_gib_rightarm_back_loop;
  array[animtype]["death"]["crouch"]["rifle"]["gib_right_arm_back_end"] = % ai_gib_rightarm_back_death;
  array[animtype]["death"]["stand"]["rifle"]["explode_up_1"] = % death_explosion_stand_up_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_up_2"] = % death_explosion_stand_up_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_back_1"] = % death_explosion_stand_b_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_back_2"] = % death_explosion_stand_b_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_back_3"] = % death_explosion_stand_b_v3;
  array[animtype]["death"]["stand"]["rifle"]["explode_back_4"] = % death_explosion_stand_b_v4;
  array[animtype]["death"]["stand"]["rifle"]["explode_right_1"] = % death_explosion_stand_l_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_right_2"] = % death_explosion_stand_l_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_right_3"] = % death_explosion_stand_l_v3;
  array[animtype]["death"]["stand"]["rifle"]["explode_front_1"] = % death_explosion_stand_f_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_front_2"] = % death_explosion_stand_f_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_front_3"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["stand"]["rifle"]["explode_front_4"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["stand"]["rifle"]["explode_left_1"] = % death_explosion_stand_r_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_left_2"] = % death_explosion_stand_r_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_up_1"] = % death_explosion_stand_up_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_up_2"] = % death_explosion_stand_up_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_back_1"] = % death_explosion_stand_b_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_back_2"] = % death_explosion_stand_b_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_back_3"] = % death_explosion_stand_b_v3;
  array[animtype]["death"]["crouch"]["rifle"]["explode_back_4"] = % death_explosion_stand_b_v4;
  array[animtype]["death"]["crouch"]["rifle"]["explode_right_1"] = % death_explosion_stand_l_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_right_2"] = % death_explosion_stand_l_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_right_3"] = % death_explosion_stand_l_v3;
  array[animtype]["death"]["crouch"]["rifle"]["explode_front_1"] = % death_explosion_stand_f_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_front_2"] = % death_explosion_stand_f_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_front_3"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["crouch"]["rifle"]["explode_front_4"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["crouch"]["rifle"]["explode_left_1"] = % death_explosion_stand_r_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_left_2"] = % death_explosion_stand_r_v2;
  array[animtype]["death"]["prone"]["rifle"]["explode_up_1"] = % death_explosion_stand_up_v1;
  array[animtype]["death"]["prone"]["rifle"]["explode_up_2"] = % death_explosion_stand_up_v2;
  array[animtype]["death"]["prone"]["rifle"]["explode_front_1"] = % death_explosion_stand_b_v1;
  array[animtype]["death"]["prone"]["rifle"]["explode_front_2"] = % death_explosion_stand_b_v2;
  array[animtype]["death"]["prone"]["rifle"]["explode_front_3"] = % death_explosion_stand_b_v3;
  array[animtype]["death"]["prone"]["rifle"]["explode_front_4"] = % death_explosion_stand_b_v4;
  array[animtype]["death"]["prone"]["rifle"]["explode_right_1"] = % death_explosion_stand_l_v1;
  array[animtype]["death"]["prone"]["rifle"]["explode_right_2"] = % death_explosion_stand_l_v2;
  array[animtype]["death"]["prone"]["rifle"]["explode_right_3"] = % death_explosion_stand_l_v3;
  array[animtype]["death"]["prone"]["rifle"]["explode_back_1"] = % death_explosion_stand_f_v1;
  array[animtype]["death"]["prone"]["rifle"]["explode_back_2"] = % death_explosion_stand_f_v2;
  array[animtype]["death"]["prone"]["rifle"]["explode_back_3"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["prone"]["rifle"]["explode_back_4"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["prone"]["rifle"]["explode_left_1"] = % death_explosion_stand_r_v1;
  array[animtype]["death"]["prone"]["rifle"]["explode_left_2"] = % death_explosion_stand_r_v2;
  array[animtype]["death"]["back"]["rifle"]["explode_up_1"] = % death_explosion_stand_up_v1;
  array[animtype]["death"]["back"]["rifle"]["explode_up_2"] = % death_explosion_stand_up_v2;
  array[animtype]["death"]["back"]["rifle"]["explode_front_1"] = % death_explosion_stand_b_v1;
  array[animtype]["death"]["back"]["rifle"]["explode_front_2"] = % death_explosion_stand_b_v2;
  array[animtype]["death"]["back"]["rifle"]["explode_front_3"] = % death_explosion_stand_b_v3;
  array[animtype]["death"]["back"]["rifle"]["explode_front_4"] = % death_explosion_stand_b_v4;
  array[animtype]["death"]["back"]["rifle"]["explode_right_1"] = % death_explosion_stand_l_v1;
  array[animtype]["death"]["back"]["rifle"]["explode_right_2"] = % death_explosion_stand_l_v2;
  array[animtype]["death"]["back"]["rifle"]["explode_right_3"] = % death_explosion_stand_l_v3;
  array[animtype]["death"]["back"]["rifle"]["explode_back_1"] = % death_explosion_stand_f_v1;
  array[animtype]["death"]["back"]["rifle"]["explode_back_2"] = % death_explosion_stand_f_v2;
  array[animtype]["death"]["back"]["rifle"]["explode_back_3"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["back"]["rifle"]["explode_back_4"] = % death_explosion_stand_f_v3;
  array[animtype]["death"]["back"]["rifle"]["explode_left_1"] = % death_explosion_stand_r_v1;
  array[animtype]["death"]["back"]["rifle"]["explode_left_2"] = % death_explosion_stand_r_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_front_1"] = % death_explosion_run_b_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_front_2"] = % death_explosion_run_b_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_right_1"] = % death_explosion_run_l_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_right_2"] = % death_explosion_run_l_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_left_1"] = % death_explosion_run_r_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_left_2"] = % death_explosion_run_r_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_back_1"] = % death_explosion_run_f_v1;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_back_2"] = % death_explosion_run_f_v2;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_back_3"] = % death_explosion_run_f_v3;
  array[animtype]["death"]["stand"]["rifle"]["explode_run_back_4"] = % death_explosion_run_f_v4;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_front_1"] = % death_explosion_run_b_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_front_2"] = % death_explosion_run_b_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_right_1"] = % death_explosion_run_l_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_right_2"] = % death_explosion_run_l_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_left_1"] = % death_explosion_run_r_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_left_2"] = % death_explosion_run_r_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_back_1"] = % death_explosion_run_f_v1;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_back_2"] = % death_explosion_run_f_v2;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_back_3"] = % death_explosion_run_f_v3;
  array[animtype]["death"]["crouch"]["rifle"]["explode_run_back_4"] = % death_explosion_run_f_v4;
  array[animtype]["flashed"]["stand"]["rifle"]["flashed"] = array(%exposed_flashbang_v1, %exposed_flashbang_v2, %exposed_flashbang_v4, %exposed_flashbang_v5);
  array[animtype]["flashed"]["crouch"]["rifle"]["flashed"] = array(%exposed_flashbang_v1, %exposed_flashbang_v2, %exposed_flashbang_v4, %exposed_flashbang_v5);
  array[animtype]["flashed"]["prone"]["rifle"]["flashed"] = array(%exposed_flashbang_v1, %exposed_flashbang_v2, %exposed_flashbang_v4, %exposed_flashbang_v5);
  array[animtype]["grenadecower"]["stand"]["rifle"]["cower_start"] = % exposed_squat_down_grenade_f;
  array[animtype]["grenadecower"]["stand"]["rifle"]["dive_backward"] = % exposed_dive_grenade_f;
  array[animtype]["grenadecower"]["stand"]["rifle"]["dive_forward"] = % exposed_dive_grenade_b;
  array[animtype]["grenadecower"]["crouch"]["rifle"]["cower_idle"] = % exposed_squat_idle_grenade_f;
  array[animtype]["grenade_return_throw"]["stand"]["rifle"]["throw_short"] = % grenade_return_running_throw_forward;
  array[animtype]["grenade_return_throw"]["stand"]["rifle"]["throw_medium"] = % grenade_return_standing_throw_forward_1;
  array[animtype]["grenade_return_throw"]["stand"]["rifle"]["throw_far"] = % grenade_return_standing_throw_forward_2;
  array[animtype]["grenade_return_throw"]["stand"]["rifle"]["throw_very_far"] = % grenade_return_standing_throw_overhand_forward;
  array[animtype]["grenade_return_throw"]["crouch"]["rifle"]["throw_short"] = % grenade_return_running_throw_forward;
  array[animtype]["grenade_return_throw"]["crouch"]["rifle"]["throw_medium"] = % grenade_return_standing_throw_forward_1;
  array[animtype]["grenade_return_throw"]["crouch"]["rifle"]["throw_far"] = % grenade_return_standing_throw_forward_2;
  array[animtype]["grenade_return_throw"]["crouch"]["rifle"]["throw_very_far"] = % grenade_return_standing_throw_overhand_forward;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_45"] = % ai_run_lowready_f_turn_45_l;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_90"] = % ai_run_lowready_f_turn_90_l;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_135"] = % ai_run_lowready_f_turn_135_l;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_180"] = % ai_run_lowready_f_turn_180_l_02;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_45"] = % ai_run_lowready_f_turn_45_r;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_90"] = % ai_run_lowready_f_turn_90_r;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_135"] = % ai_run_lowready_f_turn_135_r;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_180"] = % ai_run_lowready_f_turn_180_r_02;
  array[animtype]["turn"]["stand"]["rifle"]["turn_b_l_180"] = % ai_run_b2f;
  array[animtype]["turn"]["stand"]["rifle"]["turn_b_r_180"] = % ai_run_b2f_a;
  array[animtype]["turn"]["stand"]["rifle"]["turn_b_l_180_sprint"] = % ai_run_b2f;
  array[animtype]["turn"]["stand"]["rifle"]["turn_b_r_180_sprint"] = % ai_run_b2f_a;
  array[animtype]["turn"]["stand"]["rifle"]["add_aim_up"] = % ai_run_f_aim_8;
  array[animtype]["turn"]["stand"]["rifle"]["add_aim_down"] = % ai_run_f_aim_2;
  array[animtype]["turn"]["stand"]["rifle"]["add_aim_left"] = % ai_run_f_aim_4;
  array[animtype]["turn"]["stand"]["rifle"]["add_aim_right"] = % ai_run_f_aim_6;
  return array;
}

setup_barnes_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array[animtype]["move"]["stand"]["rifle"]["combat_run_f"] = % ai_barnes_run_f;
  return array;
}

setup_reznov_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array[animtype]["move"]["stand"]["rifle"]["combat_run_f"] = % ai_reznov_run_f;
  return array;
}

setup_anim_array(animtype) {
  assert(isDefined(anim.anim_array) && isarray(anim.anim_array));

  if(isDefined(anim.anim_array[animtype])) {
    return;
  }
  switch (animtype) {
    case "default":
      anim.anim_array = setup_default_anim_array(animtype, anim.anim_array);
      break;
    case "civilian":
      anim.anim_array = animscripts\anims_table_civilian::setup_civilian_anim_array(animtype, anim.anim_array);
      break;
    case "female":
      break;
    case "barnes":
    case "woods":
      anim.anim_array = setup_barnes_anim_array(animtype, anim.anim_array);
      break;
    case "reznov":
      anim.anim_array = setup_reznov_anim_array(animtype, anim.anim_array);
      break;
    case "vc":
      anim.anim_array = animscripts\anims_table_vc::setup_vc_anim_array(animtype, anim.anim_array);
      break;
    case "digbat":
      anim.anim_array = animscripts\anims_table_digbats::setup_digbat_anim_array(animtype, anim.anim_array);
      break;
    case "mpla":
      anim.anim_array = animscripts\anims_table_mpla::setup_mpla_anim_array(animtype, anim.anim_array);
      break;
    case "spetsnaz":
      anim.anim_array = animscripts\anims_table_spetsnaz::setup_spetsnaz_anim_array(animtype, anim.anim_array);
      break;
    default:

      println("^3Unknown animType: " + animtype + ". Can't setup anim array");

      return;
  }

  setup_delta_arrays(anim.anim_array, anim);
}

try_heat() {
  randomchance = 0;

  switch (self.animtype) {
    case "default":
      randomchance = 33;
      break;
    case "spetsnaz":
      randomchance = 66;
      break;
  }

  if(randomint(100) < randomchance)
    self setup_heat_anim_array();
}

setup_heat_anim_array() {
  if(isDefined(self.heat) && self.heat) {
    return;
  }
  if(self.team == "allies") {
    return;
  }
  if(isDefined(self.noheatanims) && self.noheatanims) {
    return;
  }
  self animscripts\anims::clearanimcache();

  if(!isDefined(self.anim_array))
    self.anim_array = [];

  if(!isDefined(self.pre_move_delta_array)) {
    self.pre_move_delta_array = [];
    self.move_delta_array = [];
    self.post_move_delta_array = [];
    self.angle_delta_array = [];
    self.notetrack_array = [];
    self.longestexposedapproachdist = [];
    self.longestapproachdist = [];
  }

  self.heat = 1;
  self.anim_array[self.animtype]["stop"]["stand"]["rifle"]["idle"] = array(array(%heat_stand_twitcha, %heat_stand_twitchb, %heat_stand_scana, %heat_stand_scanb));
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["straight_level"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_up"] = % heat_stand_aim_8;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_down"] = % heat_stand_aim_2;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_left"] = % heat_stand_aim_4;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_right"] = % heat_stand_aim_6;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["reload"] = array(%heat_exposed_reload);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["reload_crouchhide"] = array(%heat_exposed_reload);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["fire"] = % heat_stand_fire_auto;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["single"] = array(%heat_stand_fire_single);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["burst2"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["burst3"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["burst4"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["burst5"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["burst6"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["semi2"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["semi3"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["semi4"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["semi5"] = % heat_stand_fire_burst;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["exposed_idle"] = array(%heat_stand_idle);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_45"] = % exposed_tracking_turn45l;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_90"] = % heat_stand_turn_l;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_135"] = % exposed_tracking_turn135l;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_180"] = % heat_stand_turn_180;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_45"] = % exposed_tracking_turn45r;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_90"] = % heat_stand_turn_r;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_135"] = % exposed_tracking_turn135r;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_180"] = % heat_stand_turn_180;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["arrive_exposed"][1] = % heat_approach_1;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["arrive_exposed"][2] = % heat_approach_2;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["arrive_exposed"][3] = % heat_approach_3;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["arrive_exposed"][4] = % heat_approach_4;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["arrive_exposed"][6] = % heat_approach_6;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["arrive_exposed"][8] = % heat_approach_8;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][1] = % heat_exit_1;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][2] = % heat_exit_2;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][3] = % heat_exit_3;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][4] = % heat_exit_4;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][6] = % heat_exit_6;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][7] = % heat_exit_7;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][8] = % heat_exit_8;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["exit_exposed"][9] = % heat_exit_9;
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["straight_level"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["straight_level"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_pillar_left"]["stand"]["rifle"]["straight_level"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_pillar_right"]["stand"]["rifle"]["straight_level"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_stand"]["stand"]["rifle"]["stand_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_stand"]["stand"]["rifle"]["lean_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_stand"]["crouch"]["rifle"]["stand_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_stand"]["crouch"]["rifle"]["lean_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_crouch"]["stand"]["rifle"]["stand_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_crouch"]["stand"]["rifle"]["lean_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_crouch"]["crouch"]["rifle"]["stand_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_crouch"]["crouch"]["rifle"]["lean_aim"] = % heat_stand_aim_5;
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["alert_to_A"] = array(%heat_cornerstndl_trans_alert_2_a);
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["alert_to_B"] = array(%heat_cornerstndl_trans_alert_2_b);
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["A_to_alert"] = array(%heat_cornerstndl_trans_a_2_alert);
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["A_to_alert_reload"] = array();
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["A_to_B"] = array(%heat_cornerstndl_trans_a_2_b);
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["B_to_alert"] = array(%heat_cornerstndl_trans_b_2_alert);
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["B_to_alert_reload"] = array(%heat_cornerstndl_reload_b_2_alert);
  self.anim_array[self.animtype]["cover_left"]["stand"]["rifle"]["B_to_A"] = array(%heat_cornerstndl_trans_b_2_a);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["alert_to_A"] = array(%heat_cornerstndr_trans_alert_2_a);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["alert_to_B"] = array(%heat_cornerstndr_trans_alert_2_b);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["A_to_alert"] = array(%heat_cornerstndr_trans_a_2_alert);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["A_to_alert_reload"] = array();
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["A_to_B"] = array(%heat_cornerstndr_trans_a_2_b);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["B_to_alert"] = array(%heat_cornerstndr_trans_b_2_alert);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["B_to_alert_reload"] = array(%heat_cornerstndr_reload_b_2_alert);
  self.anim_array[self.animtype]["cover_right"]["stand"]["rifle"]["B_to_A"] = array(%heat_cornerstndr_trans_b_2_a);
  animscripts\anims_table::setup_delta_arrays(self.anim_array, self);
}

reset_heat_anim_array() {
  if(isDefined(self.heat) && self.heat) {
    self.heat = 0;
    self.anim_array = undefined;
    self.pre_move_delta_array = undefined;
    self.move_delta_array = undefined;
    self.post_move_delta_array = undefined;
    self.angle_delta_array = undefined;
    self.notetrack_array = undefined;
    self.longestexposedapproachdist = undefined;
    self.longestapproachdist = undefined;
    self animscripts\anims::clearanimcache();
  }
}