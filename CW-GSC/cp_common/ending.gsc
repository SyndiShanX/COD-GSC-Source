/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ending.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\snd;
#namespace ending;

function private autoexec __init__system__() {
  system::register("ending_montage", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.var_3cf0e895)) {
    level.var_3cf0e895 = [];
  }

  util::init_dvar("<dev string:x38>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x4f>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x6a>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x83>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x9a>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xb2>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xcf>", -1, &function_db698ba5);
}

function private function_db698ba5(dvar) {
  level.var_3cf0e895[dvar.name] = dvar.value;
}

function function_103cd64c() {
  if(level.var_3cf0e895[#"hash_244a98ad9954177e"] >= 1) {
    return;
  }

  snd::client_msg("end_montage");
  level flag::init("flag_video_finished");

  if(!isDefined(level.player)) {
    level.player = getplayers()[0];
  }

  level.var_ae3bb477 = 1;

  if(level.var_3cf0e895[#"hash_cb74cb1ec96ff41"] >= 1) {
    level.var_ae3bb477 = 1;
  }

  if(!isDefined(level.map_name)) {
    return;
  }

  level.player val::set("ending_montage_controls", "freezecontrols", 1);
  level.player val::set("ending_montage_weapons", "disable_weapons", 1);

  if(level.map_name == "cp_rus_siege") {
    music::setmusicstate("8.1_good_ending_montage_title");
  } else {
    music::setmusicstate("8.0_bad_ending_montage");
  }

  level function_b029aa08();
  level function_a3694b1c();
  level function_eeb15395();
  level function_52e90476();
  level function_9bb5d1d8();
  music::setmusicstate("");
  level.player val::reset("ending_montage_controls", "freezecontrols");
  level.player val::reset("ending_montage_weapons", "disable_weapons");
  snd::client_msg("end_montage_end");
}

function function_b029aa08() {
  if(level.var_3cf0e895[#"hash_9f87e8c9152584a"] >= 1 || level.var_3cf0e895[#"hash_1ec1b7c6632fb450"] >= 1 || level.var_3cf0e895[#"hash_378064960a84d05b"] >= 1 || level.var_3cf0e895[#"hash_5fb1dc41b5d1876e"] >= 1) {
    return;
  }

  level thread function_7c927add(#"hash_728ac2c0929fbffe");

  if(level.map_name == "cp_rus_siege") {
    level function_491ef059();
  } else {
    level function_1a7218fb();
  }

  level flag::wait_till("flag_video_finished");
  wait 0.5;
}

function function_491ef059() {
  wait 1;

  if(isDefined(level.var_ae3bb477)) {
    dialogue::radio("vox_cp_mont_01215_blck_youhaveanupdate_59");
    wait 0.5;
  } else {
    wait 1;
  }

  if(level.player player_decision::function_251a57bb()) {
    if(isDefined(level.var_ae3bb477)) {
      dialogue::radio("vox_cp_mont_01215_hdsn_yeahwithbothhea_af");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01215_hdsn_approximately72_df");
    } else {
      dialogue::radio("vox_cp_mont_01210_blck_ihavetosayimdis_37");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01210_hdsn_yourenotgonnabe_8f");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01210_blck_wellwithbothhea_66");
    }

    return;
  }

  if(isDefined(level.var_ae3bb477)) {
    dialogue::radio("vox_cp_mont_01215_hdsn_yeahaftercaptur_e1");
    wait 0.5;
    dialogue::radio("vox_cp_mont_01215_hdsn_hellgiveusadeep_d6");
    return;
  }

  dialogue::radio("vox_cp_mont_01210_blck_imlookingforwar_be");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01210_hdsn_whatyouactually_17");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01210_blck_hellbeavaluable_15");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01210_hdsn_maybeifhedoesnt_3f");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01210_blck_ithinkyoullbepl_4a");
}

function function_1a7218fb() {
  wait 5;

  if(level.player player_decision::function_251a57bb()) {
    if(level.player player_decision::function_d9f060cc()) {
      dialogue::radio("vox_cp_mont_01110_pers_qasimjavadiiamn_73");
    } else {
      dialogue::radio("vox_cp_mont_01110_pers_qasimjavadinoon_a9");
    }

    return;
  }

  if(level.player player_decision::function_d9f060cc()) {
    dialogue::radio("vox_cp_mont_01110_pers_qasimjavadiyoul_c2");
    return;
  }

  dialogue::radio("vox_cp_mont_01110_pers_qasimjavadifell_39");
}

function function_a3694b1c() {
  if(level.var_3cf0e895[#"hash_1ec1b7c6632fb450"] >= 1 || level.var_3cf0e895[#"hash_378064960a84d05b"] >= 1 || level.var_3cf0e895[#"hash_5fb1dc41b5d1876e"] >= 1) {
    return;
  }

  level thread function_7c927add(#"hash_4f17e7146f08aabe");
  level flag::clear("flag_video_finished");

  if(level.map_name == "cp_rus_siege") {
    level function_abc6fa12();
  } else {
    level function_f23deb5();
  }

  level flag::wait_till("flag_video_finished");
  wait 0.5;
}

function function_abc6fa12() {
  wait 1;

  if(isDefined(level.var_ae3bb477)) {
    dialogue::radio("vox_cp_mont_01225_blck_andantonvolkov_13");
    wait 0.5;
  } else {
    wait 1;
  }

  if(level.player player_decision::function_5584c739()) {
    if(isDefined(level.var_ae3bb477)) {
      dialogue::radio("vox_cp_mont_01225_hdsn_afterthedeathof_28");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01225_hdsn_menwomenandchil_ba");
    } else {
      dialogue::radio("vox_cp_mont_01220_hdsn_volkovontheothe_ae");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01220_blck_ithinkadlerpref_7a");
      wait 1;
      dialogue::radio("vox_cp_mont_01220_hdsn_atleastwithvolk_0b");
    }

    return;
  }

  if(isDefined(level.var_ae3bb477)) {
    dialogue::radio("vox_cp_mont_01225_hdsn_volkovhasbecome_51");
    wait 1;
    dialogue::radio("vox_cp_mont_01225_hdsn_theyvealreadyin_26");
    return;
  }

  dialogue::radio("vox_cp_mont_01220_hdsn_volkovontheothe_da");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01220_blck_thatswhatifinds_6f");
}

function function_f23deb5() {
  wait 5;

  if(level.player player_decision::function_5584c739()) {
    if(level.player player_decision::function_d9f060cc()) {
      dialogue::radio("vox_cp_mont_01120_pers_itisashameyouha_15");
    } else {
      dialogue::radio("vox_cp_mont_01120_pers_itisashamewelos_5a");
    }

    return;
  }

  if(level.player player_decision::function_d9f060cc()) {
    if(level.player player_decision::function_251a57bb()) {
      dialogue::radio("vox_cp_mont_01120_pers_itpleasesmethat_fd");
    } else {
      dialogue::radio("vox_cp_mont_01120_pers_aswithqasimthec_e0");
    }

    return;
  }

  if(level.player player_decision::function_251a57bb()) {
    dialogue::radio("vox_cp_mont_01120_pers_iamrelievedthat_17");
    return;
  }

  dialogue::radio("vox_cp_mont_01120_pers_aswithqasimthec_0b");
}

function function_eeb15395() {
  if(level.var_3cf0e895[#"hash_378064960a84d05b"] >= 1 || level.var_3cf0e895[#"hash_5fb1dc41b5d1876e"] >= 1) {
    return;
  }

  var_1584d516 = level.player player_decision::function_1c4fb6d4();

  switch (var_1584d516) {
    case 0:
      level thread function_7c927add(#"hash_1396a11eae4b6d17");
      level flag::clear("flag_video_finished");
      break;
    case 1:
      level thread function_7c927add(#"hash_739ebef66711bb91");
      level flag::clear("flag_video_finished");
      break;
    case 2:
      level thread function_10ca8022();
      break;
  }

  if(level.map_name == "cp_rus_siege") {
    level function_a0610bbf(var_1584d516);
  } else {
    level function_f057699(var_1584d516);
  }

  level flag::wait_till("flag_video_finished");
  wait 0.5;
}

function function_10ca8022() {
  level function_7c927add(#"hash_1396a11eae4b6d17");
  level flag::clear("flag_video_finished");
  waitframe(1);
  level thread function_7c927add(#"hash_739ebef66711bb91");
  level flag::clear("flag_video_finished");
}

function function_a0610bbf(var_1584d516) {
  if(var_1584d516 == 2) {
    wait 2;
  } else {
    wait 0.5;
  }

  dialogue::radio("vox_cp_mont_01230_blck_howdidcleanupin_4f");
  wait 0.5;

  if(var_1584d516 == 0) {
    dialogue::radio("vox_cp_mont_01230_hdsn_wewereabletorec_fa");
    wait 0.5;
    dialogue::radio("vox_cp_mont_01230_hdsn_asyouknowhelenp_08");
  }

  if(var_1584d516 == 1) {
    dialogue::radio("vox_cp_mont_01230_hdsn_wewereabletorec_28");
    wait 0.5;
    dialogue::radio("vox_cp_mont_01230_blck_wevespokentomi6_86");
    wait 1;
    dialogue::radio("vox_cp_mont_01230_hdsn_lazarazoulayisr_88");
  }

  if(var_1584d516 == 2) {
    wait 1;
    dialogue::radio("vox_cp_mont_01230_hdsn_wewereabletorec_c3");
    wait 1;
    dialogue::radio("vox_cp_mont_01230_hdsn_theircasketsare_d2");
    wait 2;
    level function_726c99a5(2);
    wait 2;
    dialogue::radio("vox_cp_mont_01230_blck_wevespokentomi6_86");
  }

  wait 1;
  dialogue::radio("vox_cp_mont_01230_blck_whatabouttheres_6a");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01230_hdsn_theygotoffsolov_55");
}

function function_f057699(var_1584d516) {
  wait 3;

  if(var_1584d516 == 0) {
    if(level.player player_decision::function_d9f060cc()) {
      dialogue::radio("vox_cp_mont_01130_pers_yousaythateleaz_9b");
    } else {
      dialogue::radio("vox_cp_mont_01130_pers_eleazarazoulayp_00");
    }
  }

  if(var_1584d516 == 1) {
    if(level.player player_decision::function_d9f060cc()) {
      dialogue::radio("vox_cp_mont_01130_pers_yousaythathelen_69");
    } else {
      dialogue::radio("vox_cp_mont_01130_pers_helenparkperish_ce");
    }

    dialogue::radio("vox_cp_mont_01130_pers_shehadbeensniff_27");
  }

  if(var_1584d516 == 2) {
    if(level.player player_decision::function_d9f060cc()) {
      wait 3;
      dialogue::radio("vox_cp_mont_01130_pers_yousaythateleaz_9b");
      wait 3;
      level function_726c99a5(2);
      wait 2;
      dialogue::radio("vox_cp_mont_01130_pers_andhelenparkwas_51");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01130_pers_shehadbeensniff_27");
    } else {
      wait 3;
      dialogue::radio("vox_cp_mont_01130_pers_eleazarazoulayp_00");
      wait 3;
      level function_726c99a5(2);
      wait 2;
      dialogue::radio("vox_cp_mont_01130_pers_andhelenparkwas_51");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01130_pers_shehadbeensniff_27");
    }
  }

  wait 1;

  if(level.player player_decision::function_d9f060cc()) {
    dialogue::radio("vox_cp_mont_01130_pers_asfortherestitw_4c");
    return;
  }

  dialogue::radio("vox_cp_mont_01130_pers_theothershoweve_2d");
}

function function_52e90476() {
  if(level.var_3cf0e895[#"hash_5fb1dc41b5d1876e"] >= 1) {
    return;
  }

  level thread function_7c927add(#"hash_394855f758700797");
  level flag::clear("flag_video_finished");

  if(level.map_name == "cp_rus_siege") {
    level function_a0223881();
  } else {
    level function_a08b9968();
  }

  level flag::wait_till("flag_video_finished");
  wait 0.5;
}

function function_a0223881() {
  if(!player_decision::function_c8718964() && !player_decision::function_ee124ba3()) {
    wait 1;
  } else {
    wait 3;
  }

  dialogue::radio("vox_cp_mont_01240_blck_wemayhavestoppe_ec");
  wait 0.5;

  if(player_decision::function_c8718964()) {
    if(player_decision::function_ee124ba3()) {
      wait 1;
      dialogue::radio("vox_cp_mont_01240_hdsn_notanymorewetoo_b4");
    } else {
      wait 1;
      dialogue::radio("vox_cp_mont_01240_hdsn_wellwedidfinall_8d");
    }

    return;
  }

  if(player_decision::function_ee124ba3()) {
    wait 1;
    dialogue::radio("vox_cp_mont_01240_hdsn_weeliminatedsom_f7");
    return;
  }

  wait 0.5;
  dialogue::radio("vox_cp_mont_01240_hdsn_truehisnetworkh_07");
  wait 0.5;
  dialogue::radio("vox_cp_mont_01240_blck_notyet_d1");
}

function function_a08b9968() {
  wait 5;

  if(player_decision::function_c8718964()) {
    if(player_decision::function_ee124ba3()) {
      dialogue::radio("vox_cp_mont_01140_pers_eventhoughwehav_47");
      wait 0.5;
      dialogue::radio("vox_cp_mont_01140_pers_robertaldrichha_ad");
    } else {
      dialogue::radio("vox_cp_mont_01140_pers_unfortunatelyou_a1");
    }

    return;
  }

  if(player_decision::function_ee124ba3()) {
    dialogue::radio("vox_cp_mont_01140_pers_theciamanagedto_a9");
    return;
  }

  dialogue::radio("vox_cp_mont_01140_pers_withthewestinch_fb");
  wait 2;
  level function_726c99a5(3);
}

function function_9bb5d1d8() {
  level thread function_7c927add(#"hash_596ad799563eca3a");
  level flag::clear("flag_video_finished");

  if(level.map_name == "cp_rus_siege") {
    level function_7cb1accf();
  } else {
    level function_6dcbf617();
  }

  level flag::wait_till("flag_video_finished");
}

function function_7cb1accf() {
  wait 2;
  dialogue::radio("vox_cp_mont_01250_blck_whatabouteurope_9e");
  wait 0.5;

  if(player_decision::function_fc8e281d()) {
    dialogue::radio("vox_cp_mont_01250_hdsn_notonlydidwesto_1d");
    wait 0.5;
    var_220ead81 = level.player player_decision::function_e40c7d56();

    switch (var_220ead81) {
      case 0:
        dialogue::radio("vox_cp_mont_01250_hdsn_wedidnteliminat_19");
        break;
      case 1:
        dialogue::radio("vox_cp_mont_01250_hdsn_wealsoflushedon_49");
        wait 0.5;
        dialogue::radio("vox_cp_mont_01250_blck_youreawordsmith_7c");
        break;
      case 2:
        dialogue::radio("vox_cp_mont_01250_hdsn_wealsoflushedtw_9a");
        wait 0.5;
        dialogue::radio("vox_cp_mont_01250_blck_suchpoetryhudso_41");
        break;
      case 3:
        dialogue::radio("vox_cp_mont_01250_hdsn_wealsoflushedal_ca");
        wait 0.5;
        dialogue::radio("vox_cp_mont_01250_blck_hudsonyourethes_e8");
        break;
    }
  } else {
    wait 1;
    dialogue::radio("vox_cp_mont_01250_hdsn_wemayhavesavedi_bc");
    wait 3;
  }

  wait 2;
  music::setmusicstate("");
  dialogue::radio("vox_cp_mont_01230_blck_andbell_f1");
}

function function_6dcbf617() {
  wait 1;

  if(player_decision::function_fc8e281d()) {
    dialogue::radio("vox_cp_mont_01150_pers_thedeathofmajor_ff");
    wait 0.5;
    var_220ead81 = level.player player_decision::function_e40c7d56();

    switch (var_220ead81) {
      case 0:
        util::delay(5, undefined, &music::setmusicstate, "");
        dialogue::radio("vox_cp_mont_01150_pers_fortunatelythec_f8");
        break;
      case 1:
        util::delay(4.1, undefined, &music::setmusicstate, "");
        dialogue::radio("vox_cp_mont_01150_pers_theciaalsomanag_5c");
        break;
      case 2:
        util::delay(4.5, undefined, &music::setmusicstate, "");
        dialogue::radio("vox_cp_mont_01150_pers_theciaalsomanag_f4");
        break;
      case 3:
        util::delay(9.1, undefined, &music::setmusicstate, "");
        dialogue::radio("vox_cp_mont_01150_pers_theciaalsomanag_8a");
        break;
    }

    music::setmusicstate("");
    wait 1;
    dialogue::radio("vox_cp_mont_01150_pers_buthavenodoubtt_59");
    return;
  }

  wait 2;
  util::delay(4, undefined, &music::setmusicstate, "");
  dialogue::radio("vox_cp_mont_01150_pers_nowthateuropeis_09");
}

function function_7c927add(var_ec670c03) {
  if(isDefined(var_ec670c03)) {
    level lui::play_movie(var_ec670c03, "fullscreen_additive", 1, 0, 0);
  }

  level flag::set("flag_video_finished");
}

function function_726c99a5(fade_out_time) {
  level thread lui::screen_fade_out(fade_out_time, "black");
  wait fade_out_time;
  level.player notify(#"menuresponse", {
    #menu: # "full_screen_movie", #response: # "finished_movie_playback", #value: 1
  });
  level thread lui::screen_fade_in(0, "black");
}