/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_155b17ff7c8b315c.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_97b74052c477c23;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_4bd68414;

function general_woods_take_random_photo_react_dialogue() {
  if(level flag::get("flg_woods_radio") || isDefined(level.woods.enemy) || level.woods.istalking === 1 || level.woods scene::function_c935c42()) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_dontthinkthatqu_e0");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_youmustbeseeing_06");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_werenotmakingas_29");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_saveyourfilm_74");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_dontbotherwitht_0f");
  hms_util::vo_knockout_manager("general_woods_take_random_photo_react_dialogue", var_ffbbfc35);
}

function function_b27f23a4(var_ebc9fa6c) {
  if(level flag::get("flg_woods_radio") || isDefined(level.woods.enemy) || level.woods.istalking === 1 || level.woods scene::function_c935c42()) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = "vox_cp_amrk_02900_wood_lookslikeyoufou_53";
  var_ffbbfc35[1] = "vox_cp_amrk_02900_wood_youfoundanother_bb";
  var_ffbbfc35[2] = "vox_cp_amrk_02900_wood_anothersectorpi_47";
  var_ffbbfc35[3] = "vox_cp_amrk_02900_wood_anothersectorpi_b4";
  var_ffbbfc35[4] = "vox_cp_amrk_02900_wood_lookyoufoundwhe_28";
  var_ffbbfc35[5] = "vox_cp_amrk_02900_wood_hellyeahyoufoun_31";
  num = level.var_81357431.n_progress;
  level.woods hms_util::dialogue(var_ffbbfc35[num]);
}

function function_4c8c8596(n_counter) {
  if(level flag::get("flg_woods_radio") || isDefined(level.woods.enemy) || level.woods.istalking === 1 || level.woods scene::function_c935c42()) {
    return;
  }

  level.woods flag::set("flg_woods_photo_react");
  var_64e8a759 = [];
  var_64e8a759[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_thatthingworkin_2b");
  var_64e8a759[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_hopeyougotmygoo_35");
  var_64e8a759[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_enoughalready_96");
  var_64e8a759[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_iknowthecameral_f5");
  var_64e8a759[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_iwantacopyoftha_73");
  var_cc30df30 = [];
  var_cc30df30[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_getseriousbell_43");
  var_cc30df30[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_stopwastingfilm_b9");
  var_cc30df30[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_stoppissingarou_9a");
  var_cc30df30[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_pointthatthings_fb");

  if(n_counter < 5) {
    hms_util::vo_knockout_manager("general_woods_take_woods_photo_react_fun_dialogue", var_64e8a759);
  } else {
    hms_util::vo_knockout_manager("general_woods_take_woods_photo_react_annoyed_dialogue", var_cc30df30);
  }

  level.woods flag::clear("flg_woods_photo_react");
}

function function_66d2375f() {
  wait 3;
  level.park hms_util::dialogue("vox_cp_amrk_01000_park_imnotpickingupa_ed", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_01000_wood_copythatparksta_fd");
  level flag::wait_till("flg_forest_woods_begin_moving");
  level waittill(#"hash_e6162fcb323c4c7");
  level thread forest_woods_nags_dialogue("flg_forest_approaching_tree");
}

function function_fb933f91() {
  level.park hms_util::dialogue("vox_cp_amrk_01000_park_thebaseisjustov_f0", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_01000_wood_shitparkidplann_30");
  level.park hms_util::dialogue("vox_cp_amrk_01000_park_dothatafterwele_4b", 1);
}

function forest_woods_nags_dialogue(var_64a96c71) {
  level endon(var_64a96c71);
  wait 15;

  if(flag::get(var_64a96c71)) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01000_wood_bellweneedtomov_6b");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_wedonthavealoto_32");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_moveup_ca");

  while(true) {
    hms_util::vo_knockout_manager("forest_woods_nags_dialogue", var_ffbbfc35, 0, 0);
    wait 15;
  }
}

function function_6686a3e9() {
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_redscouldbehidi_8b");
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_snapapictureops_c7");
}

function function_b9e6f11a() {
  level endon(#"flg_perimeter_tower_enemies_alerted");
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_righttimetogeto_5c");
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_03000_wood_imseeingguardsh_a5");
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_chooseyourtarge_25");
  level thread function_73fa3a41();
}

function function_73fa3a41() {
  level.player endon(#"death");
  level endon(#"flg_perimeter_tower_enemies_alerted");
  wait 10;

  if(flag::get("flg_perimeter_tower_enemies_alerted")) {
    return;
  }

  var_87aea179 = [];
  var_87aea179[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_putyourcameraaw_b1");
  var_87aea179[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_picturetimeisov_b1");
  var_87aea179[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_drawyourweapont_e1");
  var_5183c646 = [];
  var_5183c646[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_onyourmarkbell_70");
  var_5183c646[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_firewhenready_bb");
  var_5183c646[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_droptheguards_ca");
  var_5183c646[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_takeyourpick_69");
  var_5183c646[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_wedothisrealqui_86");
  var_5183c646[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_wegottabequick_4d");
  var_5183c646[6] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_theyallgottadie_b2");

  while(true) {
    if(level.player getcurrentweapon() == level.var_e3f5eafc) {
      hms_util::vo_knockout_manager("perimeter_woods_guard_tower_camera_nags_dialogue", var_87aea179, 0, 0);
    } else {
      hms_util::vo_knockout_manager("perimeter_woods_guard_tower_kill_nags_dialogue", var_5183c646, 0, 0);
    }

    wait 15;
  }
}

function function_9ee2fa9c() {
  if(isDefined(level.woods.enemy) || level.woods.istalking === 1 || level.woods scene::function_c935c42()) {
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_03000_wood_damnbell_6c");
}

function function_94ec56f3() {
  if(isDefined(level.woods.enemy) || level.woods.istalking === 1 || level.woods scene::function_c935c42()) {
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_02800_wood_whatareyoudoing_a4");
}

function function_60f53b98() {
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_twomoreoutofthe_52");
}

function function_ff8d98f1(var_ebc9fa6c = 0) {
  var_2878dc27 = ["vox_cp_amrk_01100_wood_holyhellwheredi_2b", "vox_cp_amrk_01100_wood_damn_ae", "vox_cp_amrk_03000_wood_thatsolvesthatp_5d"];
  level.woods hms_util::dialogue(array::random(var_2878dc27), var_ebc9fa6c);
}

function function_75011fc4(var_ebc9fa6c = 0) {
  var_2878dc27 = ["vox_cp_amrk_01100_wood_niceandclean_23", "vox_cp_amrk_01100_wood_textbook_7e", "vox_cp_amrk_01100_wood_goodshooting_42"];
  level.woods hms_util::dialogue(array::random(var_2878dc27), var_ebc9fa6c);
}

function function_876349be(var_ebc9fa6c = 0) {
  var_2878dc27 = ["vox_cp_amrk_01100_wood_yourerusty_a4", "vox_cp_amrk_01100_wood_booksometimeont_c6", "vox_cp_amrk_01100_wood_tightenitupfrom_10"];
  level.woods hms_util::dialogue(array::random(var_2878dc27), var_ebc9fa6c);
}

function function_6ebfb88e() {
  var_cbf1c338 = ["vox_cp_amrk_03000_wood_wellthatworkedt_2b", "vox_cp_amrk_03000_wood_oryoucoulddotha_67", "vox_cp_amrk_03000_wood_thatsonewaytodo_f3"];
  var_6ebf5bc2 = ["vox_cp_amrk_03000_wood_guessilltakethe_ba", "vox_cp_amrk_03000_wood_uhyeahguessills_67", "vox_cp_amrk_03000_wood_didyoujustwhate_3c"];

  if(level flag::get("flg_perimeter_slide_downhill") == 1) {
    level.woods hms_util::dialogue(array::random(var_6ebf5bc2), 1);
    return;
  }

  level.woods hms_util::dialogue(array::random(var_cbf1c338), 0);
}

function function_f287c5ff() {
  level thread perimeter_woods_player_wander_react_dialogue();
  level thread function_5e58ac0e();
  level endon(#"flg_perimeter_approaching_fence");
  wait 1;

  if(level flag::get("flg_perimeter_slide_downhill") == 0) {
    level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_takepointandhea_e9");
    level thread perimeter_woods_downhill_slide_nags_dialogue();
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_03000_wood_movefastbellill_d2");
}

function perimeter_woods_downhill_slide_nags_dialogue() {
  level endon(#"flg_perimeter_slide_downhill", #"flg_perimeter_approaching_fence");
  wait 10;

  if(flag::get_any(["flg_perimeter_slide_downhill", "flg_perimeter_approaching_fence"])) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_moveup_ca");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_igotyoucovered_66");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01100_wood_moveupyourecove_2f");

  while(true) {
    hms_util::vo_knockout_manager("perimeter_woods_downhill_slide_nags_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_37f6c1ad(var_f4f28ccb = 0) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_perimeter_end");
  wait 1;

  if(!var_f4f28ccb) {
    level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_snappicturesofa_56", 1);
    level thread function_5ec5ed94();
    level.player waittill(#"hash_39e8eb6815359328");
  }

  level flag::set("flg_perimeter_inside_gatehouse_photo");
  wait 4;
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_moveintothebase_bb", 1);
  level thread perimeter_woods_enter_base_nag_dialogue();
}

function perimeter_woods_player_wander_react_dialogue() {
  level.player endon(#"death");
  level endon(#"hash_54a52131919d9687");
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_bellwhereareyou_03");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_bellstayonmissi_cc");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_wherethehelldoy_91");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_thisisnotthetim_45");

  while(true) {
    if(level.player oob::isoutofbounds()) {
      hms_util::vo_knockout_manager("perimeter_woods_player_wander_react_dialogue", var_ffbbfc35, 1);
      wait 10;
    }

    wait 1;
  }
}

function function_5e58ac0e() {
  level endon(#"hash_54a52131919d9687");
  level flag::wait_till("flg_perimeter_player_wander_fail");
  var_2878dc27 = ["vox_cp_amrk_01100_wood_parkwevegotapro_8d", "vox_cp_amrk_01100_wood_parkbellhasdese_be", "vox_cp_amrk_01100_wood_missionabortbel_9d", "vox_cp_amrk_01100_wood_scrubthemission_11"];
  level.woods hms_util::dialogue(array::random(var_2878dc27), 1);
  util::missionfailedwrapper();
}

function function_5ec5ed94() {
  level.player endon(#"death");
  level endon(#"flg_perimeter_end", #"flg_perimeter_inside_gatehouse_photo");
  wait 10;

  if(flag::get_any(["flg_perimeter_end", "flg_perimeter_inside_gatehouse_photo"])) {
    return;
  }

  var_624c4a0 = [];
  var_624c4a0[0] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_trysearchingtha_4e");
  var_624c4a0[1] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_getacloserlooka_11");
  var_624c4a0[2] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_takeacloserlook_43");
  var_5bd7faaf = [];
  var_5bd7faaf[0] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_lookforanything_51");
  var_5bd7faaf[1] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_ifyouspotanygoo_48");
  var_5bd7faaf[2] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_bethorough_65");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    if(!level.player flag::get(#"lockpicking")) {
      if(level flag::get("flg_perimeter_inside_gatehouse") == 1) {
        hms_util::vo_knockout_manager("perimeter_woods_gatehouse_inside_nag_dialogue", var_5bd7faaf, 1, 0);
      } else {
        hms_util::vo_knockout_manager("perimeter_woods_gatehouse_outside_nag_dialogue", var_624c4a0, 1, 0);
      }
    }

    wait 20;
  }
}

function perimeter_woods_enter_base_nag_dialogue() {
  level endon(#"flg_perimeter_end");
  level.player endon(#"death");
  wait 10;

  if(flag::get("flg_perimeter_end")) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_moveupivegotove_94");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, undefined, "vox_cp_amrk_01100_wood_wedonthaveallni_11");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    if(!level.player flag::get(#"lockpicking")) {
      hms_util::vo_knockout_manager("perimeter_woods_enter_base_nag_dialogue", var_ffbbfc35, 1, 0);
    }

    wait 20;
  }
}

function function_8b403488() {
  level.woods hms_util::dialogue("vox_cp_amrk_01200_wood_findawayintothe_0f", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_01200_wood_illtrailanddisa_48", 1);
}

function function_8a5d9832() {
  level.woods hms_util::dialogue("vox_cp_amrk_01200_wood_gotyoucovered_dd", 1);
}

function function_19e4681b() {
  level.woods hms_util::dialogue("vox_cp_amrk_01200_wood_quickthinking_a7", 1);
}

function function_1c74ea6e() {
  level endon(#"flg_helipad_enemies_alerted");
  wait 3;
  level flag::set("flg_helipad_woods_awol");
  level.woods hms_util::dialogue("vox_cp_amrk_01200_wood_shitapatrolisap_49", 1);
}

function function_d1ebb0b9(var_78d6f873, var_9d4ecd2b) {
  if(isDefined(var_9d4ecd2b.guy)) {
    speaker = var_9d4ecd2b.guy;
  } else {
    function_1eaaceab(var_78d6f873);
    var_78d6f873 = array::get_all_closest(level.player.origin, var_78d6f873);
    speaker = var_78d6f873[0];
  }

  speaker.name = "Russian Soldier";
  var_2878dc27 = ["vox_cp_amrk_01200_svs1_intruder_6e", "vox_cp_amrk_01200_svs1_ineedbackup_dc", "vox_cp_amrk_01200_svs1_enemyspotted_42", "vox_cp_amrk_01200_svs1_callforbackup_9a", "vox_cp_amrk_01200_svs1_anintruder_5d"];
  speaker hms_util::dialogue(array::random(var_2878dc27));
}

function function_bad8f79d() {
  level.park hms_util::dialogue("vox_cp_amrk_01200_park_belllaylowtheyr_72", 1);
  level thread helipad_park_incoming_heli_nag_dialogue();
}

function helipad_park_incoming_heli_nag_dialogue() {
  level.player endon(#"death");
  level endon(#"flg_helipad_end", #"flg_vig_heli_shooting_player");

  if(flag::get_any(["flg_helipad_end", "flg_vig_heli_shooting_player"])) {
    return;
  }

  wait 10;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.park, undefined, "vox_cp_amrk_01200_park_getoutoftherebe_b1");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.park, undefined, "vox_cp_amrk_01200_park_dontletthechopp_c6");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.park, undefined, "vox_cp_amrk_01200_park_youcannotbecapt_2b");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.park, undefined, "vox_cp_amrk_01200_park_ifyourespottedi_b5");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.park, undefined, "vox_cp_amrk_01200_park_stayintheshadow_fb");

  while(true) {
    if(level.park.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("helipad_park_incoming_heli_nag_dialogue", var_ffbbfc35, 1, 0);
    wait 20;
  }
}

function function_d4e6ea3d() {
  var_72a2a358 = array("vox_cp_amrk_01200_park_abortthemission_56", "vox_cp_amrk_01200_park_allteamsabortmi_77", "vox_cp_amrk_01200_park_missionabortthe_c7");
  level.park thread hms_util::dialogue(array::random(var_72a2a358), 1);
}

function function_b7dac1e6(var_2963bf2f) {
  level endon(#"flg_helipad_enemies_alerted", #"flg_helipad_end", #"hash_2915c0ce8ab308fd");
  level.player endon(#"death");
  function_1eaaceab(var_2963bf2f);

  foreach(ai in var_2963bf2f) {
    ai endon(#"death");
  }

  s_scene = struct::get("s_scene_helipad_talking_trio", "targetname");
  var_411be2d5 = 640000;
  var_c1765c9d = 400000000;

  while(var_c1765c9d > var_411be2d5) {
    var_c1765c9d = distance2dsquared(level.player.origin, s_scene.origin);
    wait 0.2;
  }

  if(!isDefined(var_2963bf2f[0]) || !isDefined(var_2963bf2f[1])) {
    return;
  }

  var_2963bf2f[0].name = "Russian Soldier 1";
  var_2963bf2f[1].name = "Russian Soldier 2";
  var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01200_svs1_besuretocheckth_49");
  var_2963bf2f[1] hms_util::dialogue("vox_cp_amrk_01200_svs1_thepilotreporte_6a");
  var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01200_svs2_again_1f");
  var_2963bf2f[1] hms_util::dialogue("vox_cp_amrk_01200_svs2_comradebelskysa_53");
  var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01200_svs1_alliknowisthatt_3d");
  var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01200_svs1_makethemright_b8");
  var_2963bf2f[1] hms_util::dialogue("vox_cp_amrk_01200_svs2_atoncecomrade_a2");
  var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01200_svs1_donotletcomrade_51");
}

function function_bd0df055() {
  if(level flag::get("flg_helipad_enemies_alerted") == 1) {
    level.park hms_util::dialogue("vox_cp_amrk_01300_park_impickingupalot_b9", 1);
    level.park hms_util::dialogue("vox_cp_amrk_01300_park_butivestillnowo_bb", 1);
    return;
  }

  level.park hms_util::dialogue("vox_cp_amrk_01300_park_theredsarestayi_70", 1);
  level.park hms_util::dialogue("vox_cp_amrk_01300_park_staythecoursean_30", 1);
}

function side_door_apc_attacked_dialogue() {
  if(self.speaking == 1) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_arewetakingfire_b7");
  var_ffbbfc35[1] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs2_enemyfirestopth_2d");
  var_ffbbfc35[2] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_searchthearea_91");
  var_ffbbfc35[3] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs2_getthelightover_ee");
  self.speaking = 1;
  hms_util::vo_knockout_manager("side_door_apc_attacked_dialogue", var_ffbbfc35);
  self.speaking = 0;
}

function side_door_apc_spotted_player_dialogue() {
  if(self.speaking == 1) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_movementonthele_95");
  var_ffbbfc35[1] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_youbythefenceid_1d");
  var_ffbbfc35[2] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_whatsthatstopth_5a");
  self.speaking = 1;
  hms_util::vo_knockout_manager("side_door_apc_spotted_player_dialogue", var_ffbbfc35);
  self.speaking = 0;
}

function side_door_apc_shoot_player_dialogue() {
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_enemyspotted_42");
  var_ffbbfc35[1] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_openfire_79");
  var_ffbbfc35[2] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_fireontarget_4b");
  var_ffbbfc35[3] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_targetacquiredc_fd");
  self.speaking = 1;
  hms_util::vo_knockout_manager("side_door_apc_shoot_player_dialogue", var_ffbbfc35);
  self.speaking = 0;
}

function side_door_apc_resume_movement_dialogue() {
  if(self.speaking == 1) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_nothingthere_3d");
  var_ffbbfc35[1] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_nocontactcontin_3c");
  var_ffbbfc35[2] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_letskeepmoving_36");
  var_ffbbfc35[3] = hms_util::function_e1449992(self, "vox_cp_amrk_01300_svs1_keeppatrollinga_81");
  self.speaking = 1;
  hms_util::vo_knockout_manager("side_door_apc_resume_movement_dialogue", var_ffbbfc35);
  self.speaking = 0;
}

function function_f382f395() {
  wait 1;
  self thread hms_util::dialogue("vox_cp_amrk_01400_svs1_russianintruder_c4");
  wait 5;
  self thread hms_util::dialogue("vox_cp_amrk_01400_svs2_russianwhoareyo_98");
}

function function_ef47326() {
  level.woods hms_util::dialogue("vox_cp_amrk_01500_wood_bellfoundusaway_7f");
  level.woods hms_util::dialogue("vox_cp_amrk_01500_wood_itsonlyamattero_61");
  level.park hms_util::dialogue("vox_cp_amrk_01500_park_getmoving_fe", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_01500_wood_noargumentsther_19");
}

function function_47262ea1() {
  level.woods hms_util::dialogue("vox_cp_amrk_01500_wood_guardsdownbelow_01");

  if(level flag::get_all(["flg_tunnels_enemies_one_dead", "flg_tunnels_rush_guards", "flg_tunnels_enemies_alerted"]) == 0) {
    level.woods hms_util::dialogue("vox_cp_amrk_01500_wood_illmovetothelow_16");
  } else {
    level.woods hms_util::dialogue("vox_cp_amrk_02800_wood_whatthefuckbell_c8");
    level flag::wait_till("flg_tunnels_woods_at_lower_level");

    if(level flag::get("flg_tunnels_enemies_dead") == 0) {
      level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_shit_b9");
    }

    return;
  }

  level flag::wait_till_any(["flg_tunnels_woods_at_lower_level", "flg_tunnels_enemies_one_dead", "flg_tunnels_rush_guards", "flg_tunnels_enemies_alerted"]);

  if(level flag::get_all(["flg_tunnels_enemies_one_dead", "flg_tunnels_rush_guards", "flg_tunnels_enemies_alerted"]) == 0) {
    level.woods hms_util::dialogue("vox_cp_amrk_03000_wood_alrightimset_64");
    level thread tunnels_woods_walkway_nag_dialogue();
    return;
  }

  if(level flag::get("flg_tunnels_enemies_dead") == 0) {
    level.woods hms_util::dialogue("vox_cp_amrk_01700_wood_shitherewego_9b");
  }
}

function tunnels_woods_walkway_nag_dialogue() {
  level.player endon(#"death");
  level endon(#"flg_tunnels_enemies_one_dead", #"flg_tunnels_rush_guards", #"flg_tunnels_enemies_alerted");

  if(flag::get_any(["flg_tunnels_enemies_one_dead", "flg_tunnels_rush_guards", "flg_tunnels_enemies_alerted"])) {
    return;
  }

  wait 10;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01500_wood_onyourmarkbell_70");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01500_wood_whenyoureready_44");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01500_wood_taketheguardsbe_85");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("tunnels_woods_walkway_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_a9537895() {
  level.woods hms_util::dialogue("vox_cp_amrk_01700_wood_shitherewego_9b");
}

function function_2e47decc() {
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_01500_wood_allclearmovingu_31");
}

function function_26861bc8(var_2963bf2f) {
  level endon(#"flg_tunnels_enemies_alerted", #"flg_tunnels_talking_trio_end");
  function_1eaaceab(var_2963bf2f);
  waitframe(1);

  if(var_2963bf2f.size < 2) {
    return;
  }

  foreach(ai in var_2963bf2f) {
    ai endon(#"death");
  }

  level thread function_b79cc444(var_2963bf2f);

  if(level flag::get("flg_tunnels_enemies_alerted") == 1) {
    return;
  }

  var_2963bf2f[0].name = "Russian Soldier 1";
  var_2963bf2f[1].name = "Russian Soldier 2";

  while(!level flag::get("flg_tunnels_enemies_alerted")) {
    wait 1;

    if(isalive(var_2963bf2f[0]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01500_svs2_youknowwhatallt_1e");
    }

    if(isalive(var_2963bf2f[1]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[1] hms_util::dialogue("vox_cp_amrk_01500_svs1_anotherdrilltob_38");
    }

    wait 1;

    if(isalive(var_2963bf2f[0]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01500_svs1_comradeyourunif_03");
    }

    if(isalive(var_2963bf2f[1]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[1] hms_util::dialogue("vox_cp_amrk_01500_svs2_yousoundlikemym_2e");
    }

    level flag::set("flg_tunnels_talking_trio_midpoint");

    if(isalive(var_2963bf2f[0]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01500_svs1_hehdontlettheca_6c");
    }

    if(isalive(var_2963bf2f[1]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[1] hms_util::dialogue("vox_cp_amrk_01500_svs1_thatwouldntsurp_76");
    }

    wait 1;

    if(isalive(var_2963bf2f[0]) && !level flag::get("flg_tunnels_enemies_alerted")) {
      var_2963bf2f[0] hms_util::dialogue("vox_cp_amrk_01500_svs2_didyouhearthat_5e");
    }

    break;
  }

  level flag::set("flg_tunnels_talking_trio_end");
}

function function_b79cc444(var_2963bf2f) {
  level flag::wait_till_any(["flg_tunnels_enemies_alerted", "flg_tunnels_talking_trio_end"]);

  foreach(ai in var_2963bf2f) {
    if(isDefined(ai)) {
      ai dialogue::function_47b06180();
      ai dialogue::function_9e580f95();
    }
  }

  function_1eaaceab(var_2963bf2f);

  if(var_2963bf2f.size <= 0) {
    return;
  }

  waitframe(1);

  if(isalive(var_2963bf2f[0])) {
    var_2963bf2f[0].name = "Russian Soldier";
    var_2878dc27 = ["vox_cp_amrk_01200_svs1_intruder_6e", "vox_cp_amrk_01200_svs1_anintruder_5d"];
    var_2963bf2f[0] hms_util::dialogue(array::random(var_2878dc27));
  }
}

function function_8d96d73c() {
  wait 1;
  level.woods dialogue::function_47b06180();
  waitframe(1);
  level.woods hms_util::dialogue("vox_cp_amrk_02800_wood_whatthefuckbell_c8");
}

function function_fbdbf09b() {
  var_2878dc27 = ["vox_cp_amrk_01600_wood_thisplacegivesm_1e", "vox_cp_amrk_01600_wood_letsseewhatsbeh_3d", "vox_cp_amrk_01600_wood_bereadycouldbea_4d", "vox_cp_amrk_01600_wood_hearthatthatsmy_eb"];
  level.woods hms_util::dialogue(array::random(var_2878dc27));
  level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_illtakethedoorc_83");
  wait 8;
  level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_dontyousayafuck_0c");
}

function function_cab80a31() {
  if(!isDefined(level.var_5db33212)) {
    level.var_12c31784 = spawn("script_model", (3251, 1842, 15));
    level.var_12c31784.team = "axis";
    level.var_12c31784.name = "roof_commander";
  }

  wait 5;
  thread function_c616b02b();
  level.var_12c31784 hms_util::dialogue("vox_cp_amrk_01600_rms1_comradesbeadvis_07");
  wait randomfloatrange(2, 4);
  level.var_12c31784 hms_util::dialogue("vox_cp_amrk_01600_rms1_remembercomrade_ec");
  wait randomfloatrange(4, 7);
  level.var_12c31784 hms_util::dialogue("vox_cp_amrk_01600_rms1_keeppatrollinga_19");
  wait randomfloatrange(3, 6);
  level.var_12c31784 hms_util::dialogue("vox_cp_amrk_01600_rms1_targetacquiredc_87");
}

function function_c616b02b() {
  if(!isDefined(level.var_76bcc2eb)) {
    level.var_76bcc2eb = spawn("script_model", (2988, 2424, -266));
    level.var_76bcc2eb.team = "axis";
    level.var_76bcc2eb.name = "street_commander";
  }

  wait 5;
  level.var_76bcc2eb hms_util::dialogue("vox_cp_amrk_01600_rms2_commencinglivef_a9");
  wait randomfloatrange(1, 3);
  level.var_76bcc2eb hms_util::dialogue("vox_cp_amrk_01600_rms2_comrademishkare_66");
  wait randomfloatrange(3, 5);
  level.var_76bcc2eb hms_util::dialogue("vox_cp_amrk_01600_rms2_searchthearea_10");
}

function function_70faa3a2() {
  if(level flag::get("flg_arcade_camera_out") == 1) {
    level.woods thread hms_util::dialogue("vox_cp_amrk_01600_wood_checkoutthespet_84");
    return;
  }

  if(math::cointoss()) {
    level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_takealookatthis_c0");
    level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_fuckinganytownu_3a");
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_itsaspetznaztra_79");
  level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_madetolooklikef_6e");
}

function function_33d3327a() {
  wait 3;

  if(!flag::get("flg_arcade_street_photo_taken")) {
    level.woods hms_util::dialogue("vox_cp_amrk_01600_wood_getapictureofth_7c");
  }
}

function function_b2a8e57e() {
  level.player endon(#"death");
  level endon(#"flg_arcade_street_photo_taken");
  wait 10;
  var_3d9adee4 = [];
  var_3d9adee4[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_noonesgonnabeli_1e");
  var_3d9adee4[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_weneedpicsofthi_42");
  var_3d9adee4[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_snapapictureoft_35");
  var_3d9adee4[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_belltakeapictur_3b");
  var_87aea179 = [];
  var_87aea179[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_getoutyourcamer_3e");
  var_87aea179[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_yourcamerabell_31");
  var_87aea179[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_wedonthavealoto_32");
  var_87aea179[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01600_wood_weneedthatintel_a6");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    if(level.player flag::get("playing_arcade_game") == 0) {
      if(level.player getcurrentweapon() == level.var_e3f5eafc) {
        hms_util::vo_knockout_manager("arcade_woods_window_photo_nag_dialogue", var_3d9adee4, 0, 0);
      } else {
        hms_util::vo_knockout_manager("arcade_woods_window_camera_nag_dialogue", var_87aea179, 0, 0);
      }
    }

    wait 20;
  }
}

function function_e960ffea() {
  wait 1;
  level function_fe3ae815("vox_cp_amrk_01600_svs1_commencinglivef_ee");
}

function arcade_woods_play_game_start_dialogue() {
  self notify("60b6c51ba0418425");
  self endon("60b6c51ba0418425");

  if(!level.woods flag::get("flg_arcade_nags_begin")) {
    level.woods flag::wait_till("flg_arcade_nags_begin");
    wait 10;

    if(!level.player flag::get(#"playing_arcade_game")) {
      return;
    }

    level thread arcade_woods_play_game_nag_dialogue();
  } else {
    level thread arcade_woods_play_game_nag_dialogue();

    if(math::cointoss()) {
      return;
    }

    wait 1;
  }

  if(level.woods flag::get(#"hash_ef3856d6deed76") || level.woods namespace_fc3e8cb::function_5b19aae2(7)) {
    return;
  }

  var_d6215a9a = [];
  var_d6215a9a[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youanerdorsomet_b5");
  var_d6215a9a[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_igotnext_c0");
  var_d6215a9a[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_ohshitipumpedal_aa");
  var_d6215a9a[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youeverplaythis_40");
  var_d6215a9a[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_shittheyevengot_4f");
  var_d6215a9a[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_whatareyoufineb_8b");
  var_d6215a9a[6] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_ohsuresavingthe_f4");
  var_d6215a9a[7] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_thisonesatrip_f6");
  var_d6215a9a[8] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_nowthisthisisav_81");
  hms_util::vo_knockout_manager("arcade_woods_play_game_start_dialogue", var_d6215a9a, 0, 0);
}

function arcade_woods_play_game_nag_dialogue() {
  self notify("677e60817fe103f7");
  self endon("677e60817fe103f7");
  wait 10;
  var_7bacba78 = [];
  var_7bacba78[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_yousuckatthis_0e");
  var_7bacba78[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_yougottahittheb_df");
  var_7bacba78[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_bellyoustink_ed");
  var_7bacba78[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_ohniceone_25");
  var_7bacba78[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_yougottaquarter_df");
  var_7bacba78[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_parkwouldbesopi_15");
  var_7bacba78[6] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_thisshitwillrot_79");
  var_7bacba78[7] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_wellfuckifyoure_fb");
  var_7bacba78[8] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_whatssofunabout_bf");
  var_7bacba78[9] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youredoingitwro_b8");

  while(level.player flag::get(#"playing_arcade_game")) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    if(math::cointoss() && level.woods flag::get("flg_arcade_nags_begin")) {
      hms_util::vo_knockout_manager("arcade_woods_play_game_nag_dialogue", var_7bacba78, 0, 0);
    }

    wait 20;
  }
}

function arcade_woods_play_game_end_dialogue() {
  if(math::cointoss() || !level.woods flag::get("flg_arcade_nags_begin")) {
    return;
  }

  wait 1;

  if(level.woods flag::get(#"hash_ef3856d6deed76") || level.woods namespace_fc3e8cb::function_5b19aae2(7)) {
    return;
  }

  var_26727dcd = [];
  var_26727dcd[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youreatruenerd_67");
  var_26727dcd[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_illneverunderst_46");
  var_26727dcd[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_pongnowthatisav_83");
  var_26727dcd[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_thataintmybag_d6");
  var_26727dcd[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_pfftvideogamesn_96");
  var_26727dcd[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youknowifyoupla_9d");
  var_26727dcd[6] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_thisonesawastea_ab");
  hms_util::vo_knockout_manager("arcade_woods_play_game_end_dialogue", var_26727dcd, 0, 0);
}

function function_e3e98e84(var_5b07db82) {
  wait 1;
  var_1c658538 = [];
  var_1c658538[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_ohfuckmyearsare_5d");
  var_1c658538[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youcallthatmusi_4a");
  var_1c658538[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_yougotbeatupinh_cd");
  var_1c658538[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_fuckthat_88");
  var_1c658538[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_illneverunderst_fa");
  var_1c658538[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_turnthatshitoff_db");
  var_b090758f = [];
  var_b090758f[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_groovynowcanweg_8c");
  var_b090758f[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_takesmeback_c9");
  var_b090758f[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_yougottasteillg_99");
  var_b090758f[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_classic_f0");
  var_b090758f[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_canwefocushere_7d");
  var_b090758f[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_wegotmoreimport_c8");
  var_3a7c2adf = [];
  var_3a7c2adf[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_shitnowiminthem_40");
  var_3a7c2adf[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_tryingtorelivey_4e");
  var_3a7c2adf[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_youwannakissmeb_f8");
  var_3a7c2adf[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_imprettysureigo_50");
  var_3a7c2adf[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_yougonnaaskmeto_b6");
  var_3a7c2adf[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_huhnowthatssome_42");
  var_d9dd9165 = [];
  var_d9dd9165[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_ohyeahthatswick_5d");
  var_d9dd9165[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_turnthatshitup_85");
  var_d9dd9165[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_itsmusiclikethi_93");
  var_d9dd9165[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_thissongputhair_14");
  var_d9dd9165[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02800_wood_ohilovethisnext_de");

  switch (var_5b07db82) {
    case # "hash_2d5df218d441759a":
      hms_util::vo_knockout_manager("arcade_woods_play_music_sexy_dialogue", var_3a7c2adf, 0, 0);
      break;
    case # "hash_bc60e911959a7fc":
      hms_util::vo_knockout_manager("arcade_woods_play_music_cool_dialogue", var_b090758f, 0, 0);
      break;
    case # "suck":
      hms_util::vo_knockout_manager("arcade_woods_play_music_suck_dialogue", var_1c658538, 0, 0);
      break;
    case # "hash_49267ce28db47b91":
      hms_util::vo_knockout_manager("arcade_woods_play_music_badass_dialogue", var_d9dd9165, 0, 0);
      break;
    default:
      assertmsg("<dev string:x38>");
      break;
  }
}

function function_7bd5886a() {
  level endon(#"flg_video_store_alert");
  level function_fe3ae815("vox_cp_amrk_01700_svs1_repeatlivefired_9a");
  level flag::wait_till("flg_video_store_at_catwalk");
  level thread function_fe3ae815("vox_cp_amrk_01700_svs1_remembercomrade_eb");
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_01700_wood_iftheywantalive_f3");
  level flag::wait_till("flg_video_store_enemies_aware2");
  level.woods hms_util::dialogue("vox_cp_amrk_01700_wood_theyrecomingthi_73");
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_01700_wood_gonnaseeusifwed_c9");
}

function function_59872c12() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  a_ai_enemies = getaiarray("sp_enemy_video_store_wave1", "targetname");

  if(a_ai_enemies.size > 0) {
    a_ai_enemies = array::get_all_closest(level.player.origin, a_ai_enemies);
    var_500d582[0] = "vox_cp_amrk_01700_svs1_whatthe_34";
    var_500d582[0] = "vox_cp_amrk_01700_svs2_aretheypartofth_95";

    if(isDefined(a_ai_enemies[0])) {
      a_ai_enemies[0].name = "Russian Soldier";
      a_ai_enemies[0] hms_util::dialogue(array::random(var_500d582));
    }

    a_ai_enemies = array::remove_index(a_ai_enemies, 0);
    function_1eaaceab(a_ai_enemies);
    var_68879c92[0] = "vox_cp_amrk_01700_svs1_notpartofthedri_8c";
    var_68879c92[1] = "vox_cp_amrk_01700_svs2_wehaveasecurity_3f";

    if(isDefined(a_ai_enemies[0])) {
      a_ai_enemies[0].name = "Russian Soldier";
      a_ai_enemies[0] hms_util::dialogue(array::random(var_68879c92));
    }
  }

  level function_fe3ae815("vox_cp_amrk_01700_svs1_russianshootthe_52");
}

function function_849737a4() {
  if(!isDefined(self.name)) {
    self.name = "Russian Soldier";
  }

  self hms_util::dialogue(self.var_cd319755 + "_order_move");
}

function function_ffebd43c() {
  if(!isDefined(self.name)) {
    self.name = "Russian Soldier";
  }

  self hms_util::dialogue(self.var_cd319755 + "_action_moving");
}

function function_437af554() {
  if(!isDefined(self.name)) {
    self.name = "Russian Soldier";
  }

  self hms_util::dialogue(self.var_cd319755 + "_melee_kill");
}

function function_6aa4492a() {
  t_main_street_start = getent("t_main_street_start", "targetname");

  if(istouching(level.player.origin, t_main_street_start)) {
    level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_keepmovingupthe_73");
  } else {
    level.woods hms_util::dialogue("vox_cp_amrk_02700_wood_advance_d3");
  }

  level thread function_765acb16();
  level flag::wait_till_any(["flg_main_street_parking_lot_clear", "flg_burger_town_resistance", "flg_burger_town_resistance_pizza_store"]);
  wait 1;

  if(level flag::get("flg_burger_town_resistance") == 0 && level flag::get("flg_burger_town_resistance_pizza_store") == 0) {
    var_2878dc27 = ["vox_cp_amrk_03000_wood_nowwheredthosef_36", "vox_cp_amrk_03000_wood_nowwheredtheres_65"];
    level.woods hms_util::dialogue(array::random(var_2878dc27));
    wait 3;
    level flag::set("flg_woods_commented_on_lack_of_enemies");
    level thread main_street_woods_all_clear_nags_dialogue();
  }

  level flag::wait_till_any(["flg_burger_town_resistance", "flg_burger_town_resistance_pizza_store"]);

  if(level flag::get("flg_woods_commented_on_lack_of_enemies")) {
    var_2878dc27 = ["vox_cp_amrk_03000_wood_watchout_90", "vox_cp_amrk_03000_wood_ihadtoask_19", "vox_cp_amrk_03000_wood_iknewit_3c", "vox_cp_amrk_03000_wood_theretheyare_4b", "vox_cp_amrk_03000_wood_ihadtoopenmybig_38"];
    level.woods hms_util::dialogue(array::random(var_2878dc27));
  }

  level flag::wait_till("flg_main_street_3_start");
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_bellheadforthat_28");
  level thread main_street_woods_tower_nags_dialogue("flg_main_street_end");
}

function function_765acb16() {
  level endon(#"flg_main_street_parking_lot_clear", #"flg_burger_town_resistance", #"flg_burger_town_resistance_pizza_store");
  level.player endon(#"death");
  wait 20;

  if(level flag::get_any(["flg_main_street_parking_lot_clear", "flg_burger_town_resistance"]) || level.woods.istalking === 1) {
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_03000_wood_thatallyougot_10");
}

function main_street_woods_all_clear_nags_dialogue() {
  level endon(#"flg_burger_town_resistance", #"flg_burger_town_resistance_pizza_store");
  level.player endon(#"death");
  wait 15;

  if(level flag::get("flg_burger_town_resistance") || level flag::get("flg_burger_town_resistance_pizza_store")) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_huhithoughtther_df");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_wheredtheyallgo_c2");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_wegottakeepmovi_9e");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_takepointbell_c8");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("main_street_woods_all_clear_nags_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function main_street_woods_tower_nags_dialogue(var_7928fb3d) {
  level endon(var_7928fb3d);
  level.player endon(#"death");
  wait 15;

  if(level flag::get(var_7928fb3d)) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_pushup_c6");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_moveup_bd");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01800_wood_headtowardtheco_17");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01800_wood_seethatcontrolt_04");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("main_street_woods_tower_nags_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_a4c61d8d() {
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_rpgrpg_34");
}

function function_20228cc() {
  wait 2;
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_russianvehiclei_15");
}

function function_aaa79e50() {
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_contactontheroo_e8");
}

function function_92d726be() {
  level endon(#"flg_main_street_end");

  for(var_ecf165d2 = ["vox_cp_amrk_01300_svs1_enemyspotted_42", "vox_cp_amrk_01300_svs1_openfire_79", "vox_cp_amrk_01300_svs1_fireontarget_4b", "vox_cp_amrk_01300_svs1_targetacquiredc_fd"]; level flag::get("flg_main_street_end") == 0 && var_ecf165d2.size > 0; var_ecf165d2 = array::remove_index(var_ecf165d2, 0)) {
    wait randomfloatrange(15, 20);

    if(level.var_cf584ebf.speaking === 1) {
      continue;
    }

    if(level flag::get("flg_main_street_parking_lot_clear") == 1 && level flag::get("flg_burger_town_resistance") == 0 && level flag::get("flg_burger_town_resistance_pizza_store") == 0) {
      continue;
    }

    var_ecf165d2 = array::randomize(var_ecf165d2);
    level function_fe3ae815(var_ecf165d2[0]);
  }
}

function function_88753bbe() {
  level endon(#"flg_main_street_end");
  level flag::wait_till("flg_main_street_theater_loudspeaker_vo");
  level function_fe3ae815("vox_cp_amrk_01800_svs1_theyarehidingin_0b");

  if(math::cointoss() || level.woods.istalking === 1) {
    return;
  }

  var_2878dc27 = ["vox_cp_amrk_01800_wood_whattheyrenotfa_3d", "vox_cp_amrk_01800_wood_twoguysathousan_b4"];
  level.woods hms_util::dialogue(array::random(var_2878dc27));
}

function function_cb23defe() {
  level endon(#"flg_main_street_end");
  level flag::wait_till("flg_main_street_burger_town_loudspeaker_vo");
  level function_fe3ae815("vox_cp_amrk_01800_svs1_searchtheburger_e8");

  if(math::cointoss() || level.woods.istalking === 1) {
    return;
  }

  var_2878dc27 = ["vox_cp_amrk_01800_wood_greatimhungryfo_b8", "vox_cp_amrk_01800_wood_isnothingsacred_54", "vox_cp_amrk_01800_wood_iusedtolovethis_30"];
  level.woods hms_util::dialogue(array::random(var_2878dc27));
}

function function_68bed476() {
  level endon(#"flg_main_street_end");
  level flag::wait_till("flg_main_street_bar_loudspeaker_vo");
  level function_fe3ae815("vox_cp_amrk_01800_svs1_thebartheyarein_fc");

  if(math::cointoss() || level.woods.istalking === 1) {
    return;
  }

  var_2878dc27 = ["vox_cp_amrk_01800_wood_youthinkthetaps_6c", "vox_cp_amrk_01800_wood_godicoulduseadr_3a"];
  level.woods hms_util::dialogue(array::random(var_2878dc27));
}

function main_street_bubby_optional_dialogue() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_elevator_fight_start");
  var_a064b967 = ["vox_cp_amrk_01800_wood_shititsbubbyifu_0b", "vox_cp_amrk_01800_wood_awwwshittheytur_dc", "vox_cp_amrk_01800_wood_whattheygotbubb_ca"];
  level flag::wait_till("flg_burger_town_bubby_vo");
  level function_44e2b9f9();
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_yourchoiceismea_21");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wouldyouliketot_18");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_mayirecommendth_36");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_haveyoutriedour_83");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_its30meat100fun_1b");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wedonthaveavega_dc");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_soooomuchmeat_c4");
  var_ffbbfc35[7] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_paramedicsarest_e5");
  var_ffbbfc35[8] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_youlooklikesome_5b");
  var_ffbbfc35[9] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_ourmeateventast_2c");
  var_ffbbfc35[10] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_imsoalone_03");
  var_ffbbfc35[11] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_bubbyislonely_c4");
  var_ffbbfc35[12] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_willyoubemyfrie_d9");
  var_ffbbfc35[13] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_justpushmybutto_69");
  var_ffbbfc35[14] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_whatsthematterb_d8");
  var_ffbbfc35[15] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_whysoglumchum_47");
  var_ffbbfc35[16] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_trytheczarburge_f8");
  var_ffbbfc35[17] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_trytheoktoberbu_3e");
  var_ffbbfc35[18] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_eatlikereagan_6e");
  var_ffbbfc35[19] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_youarewhatyouea_61");
  level thread main_street_bubby_damage_react_dialogue();
  var_72bada08 = 0;
  s_bubby = struct::get("s_bubby", "targetname");

  while(true) {
    dist = distance2dsquared(level.player getplayercamerapos(), s_bubby.origin);

    if(dist < sqr(700)) {
      if(var_72bada08 == 0) {
        within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), s_bubby.origin, 0.707107);

        if(within_fov == 1) {
          level.var_c39cfb7a hms_util::dialogue("vox_cp_amrk_02800_bbby_hitherewelcomet_88");
          level.woods hms_util::dialogue(array::random(var_a064b967));
          var_72bada08 = 1;
          wait 20;
        }
      } else {
        hms_util::vo_knockout_manager("main_street_bubby_optional_dialogue", var_ffbbfc35, 0, 0);
        wait 20;
      }
    }

    wait 0.2;
  }
}

function main_street_bubby_damage_react_dialogue() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_elevator_fight_start");
  level function_44e2b9f9();
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_haveaniceday_43");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_yayforyou_38");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_super_30");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_superduper_70");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_yay_54");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_thatsthespirit_3c");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wow_5e");
  var_ffbbfc35[7] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_idrinkyourmilks_6a");
  var_ffbbfc35[8] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_tryagain_80");
  var_ffbbfc35[9] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_hathattickles_ab");
  var_4baf0b18 = 0;
  t_bubby_damage = getent("t_bubby_damage", "targetname");

  while(true) {
    trigger_hit = t_bubby_damage trigger::wait_till();
    var_4baf0b18 += 1;

    if(var_4baf0b18 > 3 && trigger_hit.who === level.player) {
      hms_util::vo_knockout_manager("main_street_bubby_damage_react_dialogue", var_ffbbfc35, 0, 0);
      wait 10;
      var_4baf0b18 = 0;
    }

    waitframe(1);
  }
}

function main_street_bubby_button_react_dialogue() {
  level function_44e2b9f9();
  wait 0.5;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_imsorrywedontse_d8");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_areyousureyouwa_db");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wowitsrainingsa_a6");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wouldyoulikeext_41");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_perfectoneheart_b9");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_hathattickles_ab");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wouldyouliketos_ca");
  var_ffbbfc35[7] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_greatyouregonna_53");
  var_ffbbfc35[8] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_tasty_36");
  var_ffbbfc35[9] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_ithinkyouwantmo_d2");
  var_ffbbfc35[10] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_ordermorecapita_4f");
  var_ffbbfc35[11] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_whynotjusteatth_31");
  var_ffbbfc35[12] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wouldyouliketom_18");
  var_ffbbfc35[13] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_areyousure_b3");
  var_ffbbfc35[14] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_wouldyoulikecom_11");
  var_ffbbfc35[15] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_iquestionyourli_af");
  var_ffbbfc35[16] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_pulluptothenext_65");
  var_ffbbfc35[17] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_itsyourfuneral_48");
  var_ffbbfc35[18] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_imsorrycouldyou_76");
  hms_util::vo_knockout_manager("main_street_bubby_button_react_dialogue", var_ffbbfc35, 0, 0);
}

function main_street_bubby_button_prize_react_dialogue() {
  level function_44e2b9f9();
  wait 1;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_ohhhhgoodchoice_90");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_mmmmmmsooooogoo_17");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_sooooogoodhurra_24");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_havesuperduperd_92");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_ourmostpopularc_e8");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_youwon_d2");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.var_c39cfb7a, "vox_cp_amrk_02800_bbby_congratulations_5e");
  hms_util::vo_knockout_manager("main_street_bubby_button_prize_react_dialogue", var_ffbbfc35, 0, 0);
}

function function_44e2b9f9() {
  if(!isDefined(level.var_c39cfb7a)) {
    s_bubby = struct::get("s_bubby", "targetname");
    level.var_c39cfb7a = spawn("script_model", s_bubby.origin);
    level.var_c39cfb7a.origin = s_bubby.origin;
    level.var_c39cfb7a.team = "allies";
    level.var_c39cfb7a.name = # "hash_66e82142aa59cdb0";
  }
}

function function_a57510fb() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_elevator_fight_mantle");
  wait 1;
  level flag::wait_till("flg_elevator_fight_woods_start");

  if(level flag::get("flg_elevator_fight_mantle") == 0) {
    level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_thatelevatorlea_b9");
    wait 15;
    level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_headforthatelev_4d");
    level thread main_street_woods_tower_nags_dialogue("flg_elevator_fight_mantle");
  }
}

function function_163c82e7() {
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_grenade_d7");
  level flag::wait_till("flg_elevator_fight_jugg_intro_at_goal");
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_shitthatguylook_90");
}

function function_41f45773() {
  level function_fe3ae815("vox_cp_amrk_01800_svs1_dealwiththesein_ac");
  wait 1;
  var_2878dc27 = ["vox_cp_amrk_03000_wood_morecomingdownt_0c", "vox_cp_amrk_03000_wood_headsupreinforc_93", "vox_cp_amrk_03000_wood_bellwatchtheele_e6", "vox_cp_amrk_03000_wood_incomingontheel_35"];
  level.woods hms_util::dialogue(array::random(var_2878dc27));
}

function function_9ab4952e() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"death");
  var_2878dc27 = ["vox_cp_amrk_01800_wood_grenadefindcove_d8", "vox_cp_amrk_01800_wood_enemywithheavya_66", "vox_cp_amrk_01800_wood_findcover_e1"];

  while(true) {
    self waittill(#"grenade_fire");
    level.woods hms_util::dialogue(array::random(var_2878dc27));
    wait 15;
  }
}

function function_31c14ca2(n_health_threshold) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"death");
  level endon(#"flg_elevator_player_interact", #"hash_214f63fa54f97944");
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_helmetsoff_49");
  wait 10;

  while(true) {
    if(self.health < n_health_threshold) {
      break;
    }

    waitframe(1);
  }

  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_heshurtkeepthep_dc");
  wait 20;
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_aimforthehead_b2");
}

function function_aa33d336() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"death");
  level endon(#"flg_elevator_player_interact");
  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_heshurtkeepthep_dc");
  wait 10;
  var_63d2d7ec = level flag::wait_till_timeout(5, "flg_elevator_fight_jugg_helmet_off");

  if(var_63d2d7ec._notify === # "flg_elevator_fight_jugg_helmet_off") {
    level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_helmetsoff_49");
    wait 20;
    level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_aimfortheface_af");
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_aimforthehead_b2");
}

function function_951c664b() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");

  if(level flag::get("flg_elevator_player_interact") == 1) {
    return;
  }

  wait 2;
  var_2878dc27 = ["vox_cp_amrk_03000_wood_hellyeah_6d", "vox_cp_amrk_03000_wood_timber_84", "vox_cp_amrk_03000_wood_timbermotherfuc_df"];
  level.woods hms_util::dialogue(array::random(var_2878dc27), 1);
}

function function_ffca973f() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  wait 2;
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_nowheretogobutu_6f");
  level thread elevator_woods_interact_nag_dialogue();
}

function elevator_woods_interact_nag_dialogue() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_elevator_player_interact");
  level flag::wait_till("flg_control_tower_woods_on_elevator");
  wait 10;

  if(flag::get("flg_elevator_player_interact")) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_letsgetuptheele_0b");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_theelevatorshou_28");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_comeonbellhitth_9d");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_goingup_27");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    dist = distance2dsquared(level.player.origin, level.woods.origin);

    if(dist > sqr(200)) {
      hms_util::vo_knockout_manager("elevator_woods_interact_nag_dialogue", var_ffbbfc35, 0, 0);
    }

    wait 20;
  }
}

function function_da4cb613() {
  level endon(#"flg_elevator_player_interact");

  if(level flag::get("flg_main_street_burger_town_loudspeaker_vo") == 1) {
    level flag::clear("flg_main_street_burger_town_loudspeaker_vo");
  }

  level flag::wait_till("flg_main_street_burger_town_loudspeaker_vo");
  var_2878dc27 = ["vox_cp_amrk_01900_wood_youhungryorsome_f3", "vox_cp_amrk_01900_wood_youknowyoucantr_1d", "vox_cp_amrk_01900_wood_thinkwithyourhe_17"];
  level.woods hms_util::dialogue(array::random(var_2878dc27), 1);
}

function function_45ef7fd3() {
  wait 0.5;
  level.park hms_util::dialogue("vox_cp_amrk_01900_park_woodsbellimpick_2a", 1);
  level.park hms_util::dialogue("vox_cp_amrk_01900_park_whatsyourstatus_f4", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_wegotcaughtupin_48");
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_placeiscrawling_ea");
  level.park hms_util::dialogue("vox_cp_amrk_01900_park_bloodyhellimput_93", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_shesoundsmaddoe_41");
}

function function_55a0cc3d() {
  wait 2;
  level function_fe3ae815("vox_cp_amrk_01900_svs1_theyrecomingupt_12");
}

function function_13e6b28c() {
  a_ai_enemies = getaiarray("ai_enemy_elevator_top", "targetname");
  a_ai_enemies = array::get_all_closest(level.player.origin, a_ai_enemies);
  var_2878dc27 = ["vox_cp_amrk_03000_rms2_theintrudersare_5e", "vox_cp_amrk_03000_rms2_comequicklythei_45", "vox_cp_amrk_03000_rms2_alertweneedback_68"];

  if(isDefined(a_ai_enemies[0])) {
    a_ai_enemies[0].name = "Russian Soldier";
    a_ai_enemies[0] hms_util::dialogue(array::random(var_2878dc27));
  }
}

function function_24aa0543() {
  level endon(#"flg_elevator_end");

  if(flag::get("flg_elevator_end")) {
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_looksliketheirc_a6");
  level thread elevator_woods_terminal_door_nag_dialogue();
}

function elevator_woods_terminal_door_nag_dialogue() {
  level.player endon(#"death");
  level endon(#"flg_elevator_end");
  wait 10;

  if(flag::get("flg_elevator_end")) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_hereyoureup_14");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_takepointbell_c8");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_letsdothis_8c");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("elevator_woods_terminal_door_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_bfaea1c4() {
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_jackpotcomputer_93_1");
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_letsseewhatther_66");
  wait 1;

  if(flag::get("flg_terminal_player_interact") == 0) {
    level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_bellhoponthatte_37");
    level thread terminal_woods_interact_nag_dialogue();
  }
}

function terminal_woods_interact_nag_dialogue() {
  level.player endon(#"death");
  level endon(#"flg_terminal_player_interact");
  wait 10;

  if(flag::get("flg_terminal_player_interact")) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_getonthatcomput_69");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_bellcheckthemai_b7");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_wedonthavealoto_75");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("terminal_woods_interact_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 15;
  }
}

function function_e85255c2() {
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_01900_comp_thesovietpeople_16");
}

function function_51448d9f() {
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_01900_comp_tacticalurbanco_e8");
  level function_58edca49();
  wait 0.75;
  level.woods thread hms_util::dialogue("vox_cp_amrk_01900_wood_thatskidsstuffk_21");
}

function function_892d5a11() {
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_01900_comp_kgbdailyreports_c0");
  level function_58edca49();
  wait 0.75;
  level.woods thread hms_util::dialogue("vox_cp_amrk_01900_wood_boringwhatelsei_7f");
}

function function_e79f4ae2() {
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_01900_comp_operationgreenl_64");
  wait 0.25;
  level function_58edca49();
}

function function_58edca49() {
  snd::play("evt_terminal_ui_access_denied", (6278, 4476, 304));
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_01900_comp_restrictedacces_15");
}

function function_692fbedf() {
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_ofcoursetheresa_48");
  wait 0.5;
  level.woods thread hms_util::dialogue("vox_cp_amrk_01900_wood_maybetheressome_d5");
}

function function_7b7422db() {
  level.player endon(#"death");
  level endon(#"flg_terminal_password_cracked");
  wait 5;

  if(flag::get("flg_terminal_password_cracked")) {
    return;
  }

  while(level flag::get("flg_terminal_password_cracked") == 0) {
    if(level.woods.istalking === 1 || level flag::get("flg_terminal_block_password_input") == 1) {
      wait 15;
      continue;
    }

    level terminal_greenlight_wrong_password_dialogue();
    wait 10;
  }
}

function terminal_greenlight_wrong_password_dialogue() {
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_probablythebirt_71");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_thatpictureofth_f3");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_whataboutstalin_5e");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_itsprobablystal_2c");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_stalinsbirthday_8f");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_dateoftheoktobe_bf");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_idontknowkeeplo_2a");
  var_ffbbfc35[7] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_wedonthaveallgo_4f");
  var_ffbbfc35[8] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_ithoughtyouwere_41");
  var_ffbbfc35[9] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_comeonbellyoure_bd");
  hms_util::vo_knockout_manager("terminal_greenlight_wrong_password_dialogue", var_ffbbfc35, 0, 0);
}

function function_5c2e9683() {
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_operationgreenl_22");
  level.woods hms_util::dialogue("vox_cp_amrk_01900_wood_bellprintthatsh_52");
}

function function_f0072474() {
  level.player endon(#"hash_609f4e8c28b6821");
  snd::client_msg("audio_start_terminal_computer_duck");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_hdsn_weconfirmeditth_00");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_blck_ifthatgetsout_55");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_hdsn_noonewillknowno_32");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_blck_highisanunderst_ce");
}

function function_29b017c5() {
  level.player endon(#"hash_609f4e8c28b6821");
  snd::client_msg("audio_start_terminal_computer_duck");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_blck_itstoorisky_1d");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_hdsn_theplayhasbeenc_93");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_blck_iftheassetlearn_37");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_hdsn_youreworriedabo_70");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_blck_imconcernedabou_a2");
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_02900_hdsn_ifwecantcontrol_20");
}

function function_defae9e0() {
  snd::play("evt_terminal_ui_access_denied", (6278, 4476, 304));
  level.var_32fb1de5 hms_util::dialogue("vox_cp_amrk_01900_comp_unauthorizedacc_95");
}

function function_7959f57d() {
  level.var_32fb1de5 dialogue::function_47b06180();
}

function function_fe1cd4ee() {
  level function_fe3ae815("vox_cp_amrk_01900_svs1_attentionattent_ce");
  level function_fe3ae815("vox_cp_amrk_01900_svs1_therehasbeenabr_2d");
  level function_fe3ae815("vox_cp_amrk_01900_svs1_repeattherehasb_cf");
}

function function_892bda90() {
  wait 2.5;
  level.woods hms_util::dialogue("vox_cp_amrk_01100_wood_nice_ad");
}

function function_1a1db78c() {
  level function_fe3ae815("vox_cp_amrk_02000_svs2_lockeverythingd_73");
  level.woods hms_util::dialogue("vox_cp_amrk_02000_wood_wereallykickedt_6a");
  wait 0.5;
  level.woods hms_util::dialogue("vox_cp_amrk_02000_wood_parkcomeinparkh_9e");
  level.park hms_util::dialogue("vox_cp_amrk_02000_park_woodsyourebreak_03", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_02000_wood_imtalkingaboutg_9a");
  level.park hms_util::dialogue("vox_cp_amrk_02000_park_woodsyourebreak_22", 1);
  level thread observation_woods_catwalk_nag_dialogue();
}

function observation_woods_catwalk_nag_dialogue() {
  level.player endon(#"death");
  level endon(#"flg_observation_end");
  wait 10;

  if(flag::get("flg_observation_end")) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02000_wood_thiswaybell_02");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02000_wood_redsarentgonnal_77");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02000_wood_ifwemakeitoutta_2c");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("observation_woods_catwalk_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_ff520414() {
  level flag::wait_till("flg_facades_start");
  wait 2;
  level.woods hms_util::dialogue("vox_cp_amrk_02100_wood_shit_b9");
  level.woods hms_util::dialogue("vox_cp_amrk_02100_wood_thatapcisgonnat_b9");
  wait 1;
  level flag::wait_till("flg_facades_intro_apc");
  level thread namespace_fc3e8cb::function_61774174("flg_facades_end");
  level.woods hms_util::dialogue("vox_cp_amrk_02100_wood_usethefacadesas_c9");
  level thread courtyard_woods_player_damage_apc_react_dialogue("flg_facades_end");
  level thread courtyard_woods_apc_damage_player_react_dialogue("flg_facades_end");
  level thread courtyard_woods_move_nag_dialogue("flg_facades_end");
  level flag::wait_till("flg_facades_corridor_enter");
  level.woods hms_util::dialogue("vox_cp_amrk_02100_wood_dontstoporwered_14");
  level flag::wait_till("flg_facades_end");
  level.woods.var_55fb21c1 = 0;
}

function function_75a9fa51() {
  self.speaking = 1;
  self hms_util::dialogue("vox_cp_amrk_01300_svs1_targetacquiredc_fd");
  self.speaking = 0;
}

function function_c7c2eb9c() {
  self.speaking = 1;
  self hms_util::dialogue("vox_cp_amrk_01300_svs1_openfire_79");
  self.speaking = 0;
}

function courtyard_woods_move_nag_dialogue(var_7928fb3d) {
  level.player endon(#"death");
  level endon(var_7928fb3d);
  wait 5;

  if(flag::get(var_7928fb3d)) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_run_56");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_pushup_c6");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_gottakeepmoving_95");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_advance_d3");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_pushtotheexit_ff");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_yourelaggingbel_f4");

  while(true) {
    if(level flag::get("flg_courtyard_player_slow") == 1 && level.woods.var_55fb21c1 === 0) {
      level.vh_town_square_apc hms_util::function_c21ef1d8("kill_player");
      wait 1;

      if(level flag::get("flg_courtyard_player_slow") == 1 && level.woods.var_55fb21c1 === 0) {
        level.woods.var_55fb21c1 = 1;
        hms_util::vo_knockout_manager("courtyard_woods_move_nag_dialogue", var_ffbbfc35, 0, 0);
        wait 1;
        level.woods.var_55fb21c1 = 0;
        wait 15;
      }
    }

    wait 0.1;
  }
}

function courtyard_woods_player_damage_apc_react_dialogue(var_7928fb3d) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"hash_648518eba0f64676");
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_thatthingistooh_76");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_dontwasteyourbu_16");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_wellneedbiggerg_33");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_armorstoostrong_70");

  while(level flag::get(var_7928fb3d) == 0) {
    waitresult = level.vh_town_square_apc waittill(#"damage");

    if(isDefined(waitresult.attacker) && waitresult.attacker == level.player && level.woods.var_55fb21c1 === 0) {
      level.woods.var_55fb21c1 = 1;
      hms_util::vo_knockout_manager("courtyard_woods_player_damage_apc_react_dialogue", var_ffbbfc35, 0, 0);
      wait 1;
      level.woods.var_55fb21c1 = 0;
      wait 10;
      continue;
    }

    wait 1;
  }
}

function courtyard_woods_apc_damage_player_react_dialogue(var_7928fb3d) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"hash_648518eba0f64676");
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_bellmoveyourass_f9");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_dontmakeforanea_3e");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_youwannagetshot_c7");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02100_wood_keepmoving_56");

  while(level flag::get(var_7928fb3d) == 0) {
    waitresult = level.player waittill(#"damage");

    if(isDefined(waitresult.attacker) && waitresult.attacker == level.vh_town_square_apc && level.woods.var_55fb21c1 === 0) {
      level.woods.var_55fb21c1 = 1;
      hms_util::vo_knockout_manager("courtyard_woods_apc_damage_player_react_dialogue", var_ffbbfc35, 0, 0);
      wait 1;
      level.woods.var_55fb21c1 = 0;
      wait 15;
      continue;
    }

    wait 1;
  }
}

function function_c948bfdd() {
  level.woods hms_util::dialogue("vox_cp_amrk_02200_wood_upaheadtheyretr_35");
  snd::client_msg("audio_stop_terminal_alarms");
}

function function_be7fb8d0() {
  level thread function_761ae4fb();
  level thread function_74b51651();
  level.park hms_util::dialogue("vox_cp_amrk_02300_park_woodswhatsyours_41", 1);
  level.woods hms_util::dialogue("vox_cp_amrk_02300_wood_itwentfrombadto_2a");
  level.woods hms_util::dialogue("vox_cp_amrk_02300_wood_justhaveadleran_53");
  level thread courtyard_woods_player_damage_apc_react_dialogue("flg_storage_advance_1");
  level thread courtyard_woods_move_nag_dialogue("flg_storage_advance_1");
  level thread namespace_fc3e8cb::function_61774174("flg_storage_advance_1");
}

function function_d6d8868f() {
  self.speaking = 1;
  self hms_util::dialogue("vox_cp_amrk_01300_svs1_fireontarget_4b");
  self.speaking = 0;
}

function function_761ae4fb() {
  level endon(#"hash_1f362d2a951fad88");
  level flag::wait_till("flg_bank_near_windows");
  level.woods dialogue::function_47b06180();
  waitframe(1);
  level.woods hms_util::dialogue("vox_cp_amrk_02700_wood_youwannagetshot_c7");
}

function function_74b51651() {
  level flag::wait_till("flg_storage_advance_2");
  level.woods hms_util::dialogue("vox_cp_amrk_02300_wood_wevegottoreacht_ee");
}

function function_7dec07c8() {
  wait 1;
  level function_fe3ae815("vox_cp_amrk_02800_rms1_allsquadsformup_b8");
  level.woods hms_util::dialogue("vox_cp_amrk_02400_wood_bastardsarebloc_54");
  level thread motor_pool_woods_start_nag_dialogue();
}

function motor_pool_woods_start_nag_dialogue() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_motor_pool_entry_door_open");
  wait 10;

  if(flag::get("flg_motor_pool_entry_door_open") == 1) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_hereyoureup_14");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_letsdothis_8c");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_01900_wood_takepointbell_c8");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02700_wood_igotabigtempera_7e");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("motor_pool_woods_start_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_bd85f877() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  wait 1;
  level thread function_fe3ae815("vox_cp_amrk_02800_rms1_donotlettheintr_9c");
}

function function_6e5fd7a7() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  wait 2;
  var_fea4d2d6 = ["vox_cp_amrk_03000_wood_headsupgotanoth_a4", "vox_cp_amrk_03000_wood_fuckmetheygotan_49", "vox_cp_amrk_03000_wood_watchthatguyint_91"];
  level.woods hms_util::dialogue(array::random(var_fea4d2d6));
  level thread motor_pool_woods_juggernaut_nag_dialogue();
  level thread function_938c905a();
}

function motor_pool_woods_juggernaut_nag_dialogue() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_motor_pool_one_juggernaut_dead");
  wait 15;

  if(flag::get("flg_motor_pool_one_juggernaut_dead") == 1) {
    return;
  }

  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_rememberaimfort_3c");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_focusfireonthei_32");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("motor_pool_woods_juggernaut_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_938c905a() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_escape_apc_interact_triggered");
  var_18ea3076 = getaiarray("ai_juggernaut_motor_pool", "targetname");

  if(var_18ea3076.size > 1) {
    level flag::wait_till("flg_motor_pool_one_juggernaut_dead");
    wait 2;
    var_f4f8b7b0 = ["vox_cp_amrk_03000_wood_yeahthatsshowin_90", "vox_cp_amrk_03000_wood_onedown_1b", "vox_cp_amrk_03000_wood_niceshot_7e", "vox_cp_amrk_03000_wood_dontletupbell_e6"];
    level.woods hms_util::dialogue(array::random(var_f4f8b7b0));
  }

  level flag::wait_till("flg_motor_pool_all_juggernauts_dead");
  wait 2;
  var_fb8759c2 = ["vox_cp_amrk_03000_wood_twodown_33", "vox_cp_amrk_03000_wood_niceworkbell_4e"];
  level.woods hms_util::dialogue(array::random(var_fb8759c2));
}

function function_3bcf30f9() {
  level function_fe3ae815("vox_cp_amrk_02800_rms2_theyreheresealt_99");
  level.woods hms_util::dialogue("vox_cp_amrk_02400_wood_shitshitshitthe_7b");
}

function function_616aaf6e() {
  level.woods hms_util::dialogue("vox_cp_amrk_02400_wood_newplanbellgeto_f6");
  level thread motor_pool_woods_apc_nag_dialogue();
}

function motor_pool_woods_apc_nag_dialogue() {
  level.player endon(#"death");
  level endon(#"flg_escape_apc_interact_triggered");

  if(flag::get("flg_escape_apc_interact_triggered")) {
    return;
  }

  wait 15;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_bellhopinmanthe_ae");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_bellgetonthattu_c0");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_belltheapcletsg_c0");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_bellilldriveyou_02");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_headtotheapcimd_f0");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_thatapcisourtic_cd");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_03000_wood_yeahhopinthatme_62");

  while(true) {
    if(level.woods.istalking === 1) {
      wait 5;
      continue;
    }

    hms_util::vo_knockout_manager("motor_pool_woods_apc_nag_dialogue", var_ffbbfc35, 0, 0);
    wait 20;
  }
}

function function_1da50f50() {
  level.woods hms_util::dialogue("vox_cp_amrk_02400_wood_goodideailldriv_01");
}

function function_1569400a() {
  level.woods hms_util::dialogue("vox_cp_amrk_02500_wood_whatareyouwaiti_4c", 1);
}

function function_bcf74cb9() {
  level.woods hms_util::dialogue("vox_cp_amrk_02500_wood_letsseeignition_4e", 1);
}

function function_750cab2() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  flag::wait_till("flg_apc_ride_town_square_start");
  wait 2;
  level.woods hms_util::dialogue("vox_cp_amrk_02500_wood_holdonbell_70", 1);
  level flag::wait_till("flg_apc_ride_town_square_enter");
  wait 1;
  level.woods hms_util::dialogue("vox_cp_amrk_02900_wood_bellwatchthatfu_c7", 1);
  level flag::wait_till("flg_apc_ride_town_square_crash");
  wait 0.5;
  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_goddamnit_d8", 1);
  level flag::wait_till_any(["flg_apc_ride_town_square_see_exit", "flg_apc_ride_gazebo_destroyed"]);
  wait 0.5;

  if(level flag::get("flg_apc_ride_gazebo_destroyed") == 1) {
    level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_itscalledurbanr_42", 1);
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_dealwiththatapc_03", 1);
}

function function_cd66d03e() {
  self.speaking = 1;
  self hms_util::dialogue("vox_cp_amrk_01300_svs1_enemyspotted_42");
  self.speaking = 0;
}

function function_c9327de3() {
  wait 0.5;

  if(level flag::get("flg_apc_ride_town_square_curb") == 1) {
    level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_comeonbabyholdi_fe", 1);
    return;
  }

  level.woods hms_util::dialogue("vox_cp_amrk_01800_wood_fuckthatguy_fd", 1);
}

function function_44f82a6d() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  wait 0.5;
  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_bellkeepshootin_51", 1);
  wait 0.2;
  level.woods hms_util::dialogue("vox_cp_amrk_02900_wood_wouldithavekill_3c", 1);
  level flag::wait_till("flg_apc_ride_mall_turn_end");
  wait 0.1;
  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_therethebaydoor_48", 1);
  wait 0.2;
  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_shitlookout_07", 1);
  level flag::wait_till("flg_apc_ride_mall_blockade_start");
  wait 0.5;
  s_apc_ride_exit = struct::get("s_apc_ride_exit", "targetname");
  var_e88b5bd1 = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), s_apc_ride_exit.origin, 0.707107);

  if(var_e88b5bd1 == 1) {
    level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_bellfocusfireon_4e", 1);
  } else {
    level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_12oclockapcstak_a2", 1);
  }

  level flag::wait_till("flg_apc_ride_mall_car_hit_3");
  wait 0.5;
  s_apc_ride_exit = struct::get("s_apc_ride_exit", "targetname");
  var_e88b5bd1 = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), s_apc_ride_exit.origin, 0.707107);

  if(var_e88b5bd1 == 1) {
    level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_clearmeapathimg_ac", 1);
  } else {
    level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_bellineedforwar_cc", 1);
  }

  level flag::wait_till("flg_apc_ride_mall_break_gate_1");
  wait 0.1;
  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_hellyeah_6d", 1);
  level flag::wait_till("flg_apc_ride_exit_up_ramp");
  wait 2;
  level.park hms_util::dialogue("vox_cp_amrk_02300_park_woodswhatsyours_41", 1);
  level flag::delay_set(2, "flg_apc_ride_exit_fade_start");
  level.woods hms_util::dialogue("vox_cp_amrk_02600_wood_gathereveryonep_c7", 1);
  wait 2;
  level flag::set("flg_apc_ride_duck_audio");
  wait 1;
  level flag::set("flg_apc_ride_end");
}

function apc_ride_woods_damage_nag_dialogue() {
  n_current_time = gettime();

  if(isDefined(level.vh_escape_apc.var_252fd679) && n_current_time - level.vh_escape_apc.var_252fd679 < 8000) {
    return;
  }

  level.vh_escape_apc.var_252fd679 = n_current_time;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02600_wood_comeonbabyholdi_fe");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02600_wood_dealwiththosegu_5e");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02600_wood_wecantkeeptakin_6f");
  hms_util::vo_knockout_manager("apc_ride_woods_damage_nag_dialogue", var_ffbbfc35);
}

function apc_ride_woods_death_dialogue() {
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02600_wood_goddamnit_d8");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.woods, "vox_cp_amrk_02600_wood_weretakingtoomu_52");
  hms_util::vo_knockout_manager("apc_ride_woods_death_dialogue", var_ffbbfc35);
}

function function_c836a913() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level flag::wait_till("flg_apc_ride_town_square_steps");
  wait 1;
  level function_fe3ae815("vox_cp_amrk_01800_svs1_dealwiththesein_ac");
  level flag::wait_till("flg_apc_ride_town_square_near_exit");
  wait 1;
  level function_fe3ae815("vox_cp_amrk_01700_svs1_russianshootthe_52");
}

function function_ea681b17() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level flag::wait_till("flg_apc_ride_mall_transition_rpg");
  wait 1;
  level function_fe3ae815("vox_cp_amrk_02000_svs2_lockeverythingd_73");
  level flag::wait_till("flg_apc_ride_mall_turn_end");
  wait 1;
  level function_fe3ae815("vox_cp_amrk_02800_rms1_allsquadsformup_b8");
  level flag::wait_till("flg_apc_ride_mall_blockade_start");
  wait 1;
  level function_fe3ae815("vox_cp_amrk_02800_rms1_donotlettheintr_9c");
  level flag::wait_till("flg_apc_ride_mall_break_gate_2");
  wait 1;
  level function_fe3ae815("vox_cp_amrk_02800_rms2_theyreheresealt_99");
}

function function_fe3ae815(var_8a9a3456) {
  self notify("1b67f014cd0bfe54");
  self endon("1b67f014cd0bfe54");
  assert(isDefined(level.var_cf584ebf));
  assert(isDefined(var_8a9a3456));
  assert(isarray(level.var_cf584ebf.locations));
  v_player_pos = level.player getplayercamerapos();
  var_b3c855f9 = arraysortclosest(level.var_cf584ebf.locations, v_player_pos, 3, 0, 2500);

  if(var_b3c855f9.size <= 0) {
    var_48969072 = 2500;

    while(var_b3c855f9.size <= 0 && var_48969072 <= 10000) {
      var_48969072 += 500;
      var_b3c855f9 = arraysortclosest(level.var_cf584ebf.locations, v_player_pos, 3, 0, var_48969072);
    }
  }

  var_3eb1acf5 = [];

  foreach(index, location in var_b3c855f9) {
    var_3eb1acf5[index] = spawn("script_model", location);
    var_3eb1acf5[index].team = level.var_cf584ebf.team;
    var_3eb1acf5[index].name = level.var_cf584ebf.name;
    var_3eb1acf5[index] thread function_32e2276(var_8a9a3456);
  }

  level.var_cf584ebf.speaking = 1;
  n_wait_time = soundgetplaybacktime(var_8a9a3456) * 0.001;

  if(n_wait_time > 0) {
    wait n_wait_time;
  }

  level.var_cf584ebf.speaking = undefined;
}

function private function_32e2276(alias) {
  self hms_util::dialogue(alias);
  self deletedelay();
}