/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5c325a0a637fdc2e.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_6fad88ff3ed4ff7d;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\hms_util;
#namespace namespace_7468806b;

function function_79af70ae(var_50cc0d4f) {
  if(var_50cc0d4f) {
    wait 1;
  }

  level.player callback::on_weapon_change(&function_b85233a1);
  level flag::wait_till_any(array("flg_satcom_entered", "flg_mountains_stealth_switched"));
  level.player callback::remove_on_weapon_change(&function_b85233a1);
}

function function_b85233a1(var_6e96c1c2) {
  var_641870d3 = 0;

  if(isDefined(var_6e96c1c2.weapon.attachments)) {
    if(var_6e96c1c2.weapon.attachments.size > 0) {
      foreach(attachment in var_6e96c1c2.weapon.attachments) {
        if(attachment == "suppressed" || attachment == "suppressed2") {
          var_641870d3 = 0;
          break;
        }

        var_641870d3++;
      }
    } else if(var_6e96c1c2.weapon.attachments.size < 1) {
      var_641870d3++;
    }
  } else if(!isDefined(var_6e96c1c2.weapon.attachments)) {
    var_641870d3++;
  }

  if(var_6e96c1c2.weapon.name == # "none") {
    var_641870d3 = 0;
  }

  if(var_641870d3 > 0) {
    level flag::set("flg_mountains_stealth_switched");
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01100_wood_goingloudehilik_79");
  }
}

function function_ba5a28f(var_50cc0d4f = 0) {
  if(var_50cc0d4f) {
    wait 1;
  }

  while(!level flag::get("flg_mountain_vertigo_triggered")) {
    t_result = trigger::wait_till("t_vertigo_monitor");
    var_9a23d58 = struct::get_array(t_result.target, "targetname");

    foreach(struct in var_9a23d58) {
      if(level.player util::is_looking_at(struct.origin, 0.9, 1) && !level flag::get("flg_mountain_vertigo_triggered")) {
        level flag::set("flg_mountain_vertigo_triggered");

        if(math::cointoss()) {
          level.player thread hms_util::dialogue("vox_cp_ymnt_01200_masn_longwaydown_63", undefined, "allies", "Mason");
        } else {
          level.player thread hms_util::dialogue("vox_cp_ymnt_01200_masn_goodthingimnota_17", undefined, "allies", "Mason");
        }

        level.player setcinematicmotionoverride("cinematicmotion_windswept");
        wait 2;
        level.player clearcinematicmotionoverride();
      }
    }
  }
}

function function_ec4c365f() {
  level.player endon(#"death");
  level flag::wait_till("flg_mountain_woods_path_2");
  wait 2;
  level.player hms_util::dialogue("vox_cp_ymnt_01100_masn_thatsourinsidem_ac");
  wait 1;
  var_efbd4bcf = randomintrangeinclusive(0, 2);

  if(var_efbd4bcf == 0) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01100_wood_dontletthesmell_ab");
  } else if(var_efbd4bcf == 1) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01100_wood_dontletthesmell_c2");
  } else if(var_efbd4bcf == 2) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01100_wood_dontletthesmell_22");
  }

  wait 1;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01100_wood_heknowswhereall_b0");
}

function function_97c413c1() {
  e_mountain_warning_vo_source = getent("e_mountain_warning_vo_source", "targetname");
  source = spawn("script_model", e_mountain_warning_vo_source.origin);
  level flag::wait_till("flg_mountain_distant_vo");
  source hms_util::dialogue("vox_cp_ymnt_02500_rms3_whoauthorizedth_7c");
  wait 0.5;
  source hms_util::dialogue("vox_cp_ymnt_02500_rms2_ididntknowhelos_88");
}

function function_3325b147() {
  level.player endon(#"death");
  level endon(#"mountain_summit_sniper_clear");
  level endon(#"flg_mountains_sniper_exit_anim");
  level endon(#"flg_rooftop_death_playing");
  var_11bc1793 = 150;
  var_3c91873d = struct::get("woods_zipline_teleport", "targetname");
  var_f8f33108 = distance2d(level.player.origin, var_3c91873d.origin);
  var_28e6f2a6 = distance2d(level.ai_woods.origin, var_3c91873d.origin) + var_11bc1793;
  level flag::wait_till("flg_mountain_player_entered_ruins");
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_headsupscoutson_18");

  if(math::cointoss()) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_weshoulddropemn_cd");
  } else {
    if(math::cointoss()) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_wedothisquietma_47");
    } else {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_doitallquietlik_44");
    }

    level.player hms_util::dialogue("vox_cp_ymnt_02800_masn_yeahyouretheexp_d6");

    if(math::cointoss()) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_imacomplicatedm_61");
    } else {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_imagoddamnonion_d1");
    }
  }

  level flag::set("flg_summit_sniper_intro_vo_done");
}

function function_93e6003d() {
  if(level flag::get("flg_summit_sniper_intro_vo_done")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_goodkill_83");
  }
}

function function_4b868d7e() {
  if(!level flag::get("flg_mountain_spotter_woods_kill")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_niceletskeepmov_03");
    return;
  }

  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_notbadletskeepm_fc");
}

function function_a4f7d6e() {
  var_11bc1793 = 150;
  s_zipline_intro_distance_ref = struct::get("s_zipline_intro_distance_ref", "targetname");
  var_f8f33108 = distance2d(level.player.origin, s_zipline_intro_distance_ref.origin);
  var_28e6f2a6 = distance2d(level.ai_woods.origin, s_zipline_intro_distance_ref.origin) + var_11bc1793;
  setDvar(#"hash_7fb1be9520b9a725", 1200);
  setDvar(#"hash_6b57212fd4fcdd3a", 1800);

  if(isalive(level.var_d596a87f) && isalive(level.var_a06bbe2a) && !level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_engaging")) {
    level.var_d596a87f thread function_2cf32df9();
    level.var_d596a87f thread function_253ffb1d();
    level.var_a06bbe2a thread function_2cf32df9();
    level.var_a06bbe2a thread function_253ffb1d();
    level.var_d596a87f hms_util::dialogue("vox_cp_ymnt_01200_rms1_makesurethatlin_ba");
    level flag::wait_till_timeout(1, "flg_zipline_intro_cleared");

    if(isalive(level.var_d596a87f) && isalive(level.var_a06bbe2a) && !level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_engaging")) {
      level.var_a06bbe2a hms_util::dialogue("vox_cp_ymnt_01200_rms2_yescomrade_59");
    }

    level flag::wait_till_timeout(1, "flg_zipline_intro_cleared");

    if(isalive(level.var_d596a87f) && isalive(level.var_a06bbe2a) && !level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_engaging")) {
      level.var_d596a87f hms_util::dialogue("vox_cp_ymnt_01200_rms1_hurryupitscolda_90");
    }

    level flag::wait_till_timeout(1, "flg_zipline_intro_cleared");

    while(isalive(level.ai_mountain_summit_2) || isalive(level.var_52be209f)) {
      waitframe(1);
    }

    if(isalive(level.var_d596a87f) && isalive(level.var_a06bbe2a) && !level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_engaging")) {
      if(math::cointoss()) {
        level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01200_wood_youtakeoneillge_ff");
      } else {
        level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01200_wood_youtakeonefuckw_49");
        level flag::set("flg_zipline_intro_woods_fuckwit_active");
      }

      level.var_3369117 = 0;
    }
  }

  level.allowbattlechatter[# "axis"] = 1;
}

function function_478cabb9() {
  level.player endon(#"death");

  if(level.var_3369117 == 0) {
    wait 0.5;

    if(level flag::get("flg_zipline_intro_rus_weapon_fired")) {
      str_vo_line = array::random(array("vox_cp_ymnt_01200_wood_somuchforthesil_a2", "vox_cp_ymnt_01200_wood_wellthatwasloud_bb", "vox_cp_ymnt_01200_wood_yousupposeanybo_b6"));
      level.ai_woods hms_util::dialogue(str_vo_line);
    } else if(level flag::get("flg_zipline_intro_woods_fuckwit_active")) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_orilltakebothfu_ed");
    } else {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_ohhellmasondont_4f");
    }

    return;
  }

  if(level.var_3369117 == 1) {
    wait 0.5;

    if(level flag::get("flg_zipline_intro_rus_weapon_fired")) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_goodkillhopeful_58");
    } else {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_goodkill_83");
    }

    return;
  }

  if(level.var_3369117 >= 2) {
    wait 0.5;

    if(level flag::get("flg_zipline_intro_rus_weapon_fired")) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_youreaseagerasy_f2");
      level.player hms_util::dialogue("vox_cp_ymnt_01200_masn_lookswhostalkin_2d");
      return;
    }

    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_savesomeforme_ea");
  }
}

function function_4d86101b() {
  level.player endon(#"death");
  level flag::wait_till("flg_mountains_zipline_dialogue");
  level.ai_woods notify(#"flg_mountains_zipline_dialogue");

  if(isalive(level.var_89f99146)) {
    level flag::set("flg_zipline_intro_zipliner_crossed");
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_shitthislooksdi_12");
    wait 2;

    if(!level flag::get("flg_zipline_intro_used")) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_youbettergofirs_4f");
    }
  } else {
    var_efbd4bcf = randomintrangeinclusive(1, 3);

    if(var_efbd4bcf == 1) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_huhthelinelooks_d5");
      wait 2;

      if(!level flag::get("flg_zipline_intro_used")) {
        level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_yougofirstillco_52");
      }
    } else if(var_efbd4bcf == 2) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_itsalongwaydown_f3");
      wait 2;

      if(!level flag::get("flg_zipline_intro_used")) {
        level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_letshopethereds_cc");
      }
    } else if(var_efbd4bcf == 3) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_thislooksdiceyc_86");
      wait 2;

      if(!level flag::get("flg_zipline_intro_used")) {
        level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_yougofirstillco_52");
      }
    }
  }

  level flag::set("flg_zipline_intro_woods_attach_dialogue_done");
}

function function_32d5f643() {
  level flag::wait_till_timeout(3, "flg_zipline_intro_woods_attach_dialogue_done");

  if(level flag::get("flg_zipline_intro_zipliner_crossed") && isalive(level.var_89f99146)) {
    level.player hms_util::dialogue("vox_cp_ymnt_01200_masn_timetopayivanav_a8");
    return;
  }

  level.player hms_util::dialogue("vox_cp_ymnt_01200_masn_hopethisholds_28");
}

function function_9bd1eb5e() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01200_wood_seepieceofcake_39");
}

function function_7163fd33() {
  level.player endon(#"death");

  if(level flag::get("flg_zipline_intro_zipliner_killed")) {
    if(math::cointoss()) {
      level.ai_woods dialogue::queue("vox_cp_ymnt_02500_wood_theoldsatcombui_03", undefined, 1);
    } else {
      level.ai_woods dialogue::queue("vox_cp_ymnt_02500_wood_thatstheolsatco_d9", undefined, 1);
    }

    wait 0.5;

    if(math::cointoss()) {
      level.ai_woods dialogue::queue("vox_cp_ymnt_02500_wood_lookslikeitshan_0a", undefined, 1);
    } else {
      level.ai_woods dialogue::queue("vox_cp_ymnt_02500_wood_stillstandinaft_fc", undefined, 1);
    }

    level thread function_62d575ad();
  }
}

function function_62d575ad() {
  level endon(#"flg_satcom_player_exiting");
  level flag::wait_till_all(array("flg_satcom_vista", "flg_satcom_woods_vantage_arrived"));
  wait 2.5;

  if(!level flag::get("flg_satcom_player_exiting")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01200_wood_letskeepmoving_36");
    wait 0.75;
    trigger::use("t_satcom_vista_woods_advance", "targetname", level.player, 0);
  }
}

function function_c4f4d5d3() {
  if(!level flag::get("flg_satcom_kill_confirmed_vo_ready")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01300_wood_herewego_97");
    level thread function_62f47007(4);
  }
}

function function_292d47f7() {
  level endon(#"flg_satcom_entered");
  level.player endon(#"death");
  level waittill(#"hash_57905ea8dffbbcca");

  if(level flag::get("flg_satcom_kill_confirmed_vo_ready")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01300_wood_cleankill_dd");
    level thread function_62f47007(5);
  }

  level waittill(#"hash_57905ea8dffbbcca");

  if(level flag::get("flg_satcom_kill_confirmed_vo_ready")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01300_wood_tangodown_ff");
    level thread function_62f47007(5);
  }
}

function function_d3bb1c27(ai) {
  ai waittill(#"death");

  if(!level flag::get("flg_satcom_entered")) {
    level notify(#"hash_57905ea8dffbbcca");
  }
}

function function_aae80daa(ai) {
  level.player endon(#"death");
  ai waittill(#"death");

  if(level flag::get("flg_satcom_stealth_broken") && !level flag::get("flg_satcom_entered") && !level flag::get("flg_satcom_sniper_alert_killed") && level flag::get("flg_satcom_kill_confirmed_vo_ready")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_sniperdownnices_08");
    level thread function_62f47007(8);
    level flag::set("flg_satcom_sniper_alert_killed");
    return;
  }

  if(!level flag::get("flg_satcom_entered") && !level flag::get("flg_satcom_sniper_unalert_killed") && level flag::get("flg_satcom_kill_confirmed_vo_ready")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_goodkillseeanym_3a");
    level thread function_62f47007(8);
    level flag::set("flg_satcom_sniper_unalert_killed");
  }
}

function function_62f47007(f_delay) {
  level flag::clear("flg_satcom_kill_confirmed_vo_ready");
  wait f_delay;
  level flag::set("flg_satcom_kill_confirmed_vo_ready");
}

function function_c2968902() {
  if(!level flag::get("flg_satcom_entered") && level flag::get("flg_satcom_stealth_broken") && !level flag::get("flg_satcom_kill_confirmed_vo_ready")) {
    wait 0.75;

    if(math::cointoss()) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02500_wood_tangosdownpushi_e2");
    } else if(math::cointoss()) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02500_wood_clearpushinside_85");
    } else {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_wereclear_d6");
    }

    return;
  }

  if(!level flag::get("flg_satcom_entered") && !level flag::get("flg_satcom_stealth_broken")) {
    wait 0.75;
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01300_wood_nicepushinside_37");
  }
}

function function_88430eb0(var_a83c59d7) {
  level flag::wait_till_any(array("flg_satcom_approach_sniper_warn", "flg_satcom_stealth_broken"));
  function_1eaaceab(var_a83c59d7, 0);

  if(var_a83c59d7.size > 0) {
    if(!level flag::get("flg_satcom_stealth_broken")) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_theygotsnipersd_ca");
    } else {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_snipertakecover_97");
    }
  }

  wait 3;
  function_1eaaceab(var_a83c59d7, 0);

  if(var_a83c59d7.size > 0) {
    if(!level flag::get("flg_satcom_stealth_broken")) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_staylowkeepouto_c0");
      return;
    }

    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_shiticantgetash_c9");
  }
}

function function_c55af47c() {
  level endon(#"flg_satcom_entered");
  var_d200934d = array("vox_cp_ymnt_02800_wood_masongettocover_ed", "vox_cp_ymnt_02800_wood_movetocover_fa", "vox_cp_ymnt_02800_wood_useyourcover_7c", "vox_cp_ymnt_02800_wood_stayincover_f8");
  var_ab62169d = 0;

  while(true) {
    s_notify = level.player waittill(#"damage");

    if(isDefined(s_notify.attacker) && isDefined(s_notify.attacker.weapon) && isDefined(s_notify.attacker.weapon.name) && s_notify.attacker.weapon.name == "sniper_quickscope_t9") {
      if(var_ab62169d < var_d200934d.size) {
        level.ai_woods thread hms_util::dialogue(var_d200934d[var_ab62169d]);
        var_ab62169d++;
        wait randomfloatrange(8, 12);
      } else {
        break;
      }
    }

    wait 1;
  }
}

function function_ab379219() {
  if(!level flag::get("flg_satcom_stealth_broken")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_goodkillseeanym_3a");
    return;
  }

  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02800_wood_sniperdownnices_08");
}

function function_967c94ee() {
  level.player endon(#"death");

  if(level flag::get("flg_satcom_cleared")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01300_wood_ithinkwereinthe_02");
  }

  var_747d02b1 = distance2dsquared(struct::get("s_satcom_entrance_ref", "targetname").origin, level.player.origin);
  var_928fa7ac = distance2dsquared(struct::get("s_satcom_entrance_ref", "targetname").origin, level.ai_woods.origin);

  if(var_747d02b1 >= var_928fa7ac) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_masn_damnlookatthisp_df");
    wait 1.5;
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_whistlesinawe_18");
    return;
  }

  level.player hms_util::dialogue("vox_cp_ymnt_02800_wood_damnlookatthisp_df");
  wait 1;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_whistlesinawe_18");
}

function function_a7286428() {
  level flag::wait_till("flg_satcom_radio");

  if(!level flag::get("flg_satcom_interior_dialog_active")) {
    level flag::set("flg_satcom_interior_dialog_active");
    level function_d32d0447();
    level flag::clear("flg_satcom_interior_dialog_active");
  } else {
    level flag::wait_till_clear("flg_satcom_interior_dialog_active");

    if(!level flag::get("flg_satcom_exiting")) {
      level function_d32d0447();
    }
  }

  wait 10;

  if(!level flag::get("flg_satcom_interior_dialog_active") && !level flag::get("flg_satcom_exiting")) {
    level flag::set("flg_satcom_interior_dialog_active");
    level function_6a13a361();
    level flag::clear("flg_satcom_interior_dialog_active");
    return;
  }

  level flag::wait_till_clear("flg_satcom_interior_dialog_active");

  if(!level flag::get("flg_satcom_exiting")) {
    level function_6a13a361();
  }
}

function function_d32d0447() {
  level.player endon(#"death");
  e_satcom_radio = getent("e_satcom_radio", "targetname");
  e_satcom_radio hms_util::dialogue("vox_cp_ymnt_02800_rms2_thecraneisnearl_b3", undefined, "axis");
  e_satcom_radio hms_util::dialogue("vox_cp_ymnt_02800_rms3_copythatthemain_8b", undefined, "axis");
  e_satcom_radio hms_util::dialogue("vox_cp_ymnt_02800_rms2_yescomrade_59", undefined, "axis");

  if(math::cointoss()) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_myrussianisrust_e5");
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_wefindthecranew_4f");
    return;
  }

  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_youhearthatthey_bd");
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02800_wood_webettermove_67");
}

function function_6b5bf445(str_location) {
  level.player hms_util::dialogue("vox_cp_ymnt_01100_masn_hmmcrossbowbolt_c1");

  if(str_location === "satcom" && !level flag::get("flg_satcom_interior_dialog_active")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01100_wood_natureisonecrue_60");
    level.player hms_util::dialogue("vox_cp_ymnt_01100_masn_youthinknatured_43");
  }
}

function function_6a13a361() {
  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01300_wood_trythestairwell_c5");
}

function function_9abd347e() {
  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01400_wood_ughsovietengine_89");
}

function function_dc6c4109() {
  if(math::cointoss()) {
    self thread hms_util::dialogue("vox_cp_ymnt_01400_rms1_areyouidiotssho_27");
    return;
  }

  self thread hms_util::dialogue("vox_cp_ymnt_01400_rms1_whatisgoingonov_a0");
}

function function_f39da57c() {
  self thread hms_util::dialogue("vox_cp_ymnt_01700_rms1_intruder_6e");
}

function function_b8f90aa9() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01400_wood_grenade_d7");
}

function function_67cb4f06() {
  level.player endon(#"death");
  level.player endon(#"player_zipline_start");

  while(distancesquared(level.ai_woods.origin, level.player.origin) > 62500) {
    wait 0.1;
  }

  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01500_wood_thatsthedoomsda_d1");
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01500_wood_wellcrossonthat_ec");
  level flag::set("zipline_fall_helipad_dialog_finished");
  wait 1;
  a_str_lines = array("vox_cp_ymnt_02800_wood_redsonthehelipa_c7", "vox_cp_ymnt_02800_wood_thoseredsnearth_48", "vox_cp_ymnt_02800_wood_thoseredsontheh_64");
  level.ai_woods hms_util::dialogue(array::random(a_str_lines));
  level flag::wait_till("helipad_enemy_all_dead");
  level thread function_7dcbc98d();
}

function function_7dcbc98d() {
  wait 1;

  if(math::cointoss()) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01500_wood_agebeforebeauty_78");
  } else {
    level.player hms_util::dialogue("vox_cp_ymnt_01500_masn_iwentfirstlastt_40");
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01500_wood_whychangeitupno_73");
  }

  level thread function_daea8ba();
  wait 1;
  level flag::set("flg_zipline_snap_mason_retort_allowed");
  wait 6;
  level notify(#"hash_3f8c55f1b89ecb8a");
}

function function_daea8ba() {
  level endon(#"hash_3f8c55f1b89ecb8a");
  level.player waittill(#"player_zipline_start");
  level flag::wait_till("flg_zipline_snap_mason_retort_allowed");
  level.player hms_util::dialogue("vox_cp_ymnt_01500_masn_whatever_74");
  level notify(#"hash_3f8c55f1b89ecb8a");
}

function function_e208410b() {
  level waittill(#"hash_3ede0d97e45af550");
  level.player thread hms_util::dialogue("vox_cp_ymnt_01100_masn_shit_b9");
}

function function_e15849a0() {
  level waittill(#"hash_3ede0d97e45af550");
  level thread breadcrumb::function_e261021e("bc_zipline_fall_1");
  level.player clientfield::set_to_player("zipline_postfx", 1);
  wait 1;
  level.player clientfield::set_to_player("zipline_postfx", 0);
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01600_wood_mason_1f");
}

function function_ac37051f() {
  level.player endon(#"death");

  while(!isalive(level.player)) {
    waitframe(1);
  }

  wait 1;
  level.player hms_util::dialogue("vox_cp_ymnt_02500_wood_masonwhatsyours_33", 1);
  wait 1;
  level.player hms_util::dialogue("vox_cp_ymnt_02500_masn_lostmydamngun_00");
  wait 1;

  if(!level flag::get("flg_bunker_explore_entered")) {
    level.player hms_util::dialogue("vox_cp_ymnt_01600_masn_youregoingfirst_5a");
    wait 1;
  }

  level flag::wait_till("flg_bunker_explore_entered");
  level.player hms_util::dialogue("vox_cp_ymnt_01600_masn_iseeatunneldown_ab");
  wait 1;

  if(level flag::get("flg_bunker_player_outside")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01600_wood_copythatstaysha_2c", 1);
  } else {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01600_wood_copythatstay_b5", 1);
    wait 0.25;
    snd::play("evt_yam_radio_static_fade_in");
    wait 1;
    level.ai_woods dialogue::function_9e580f95();
    snd::play("evt_yam_radio_static_burst");
    wait 1;
    level.player hms_util::dialogue("vox_cp_ymnt_01600_masn_woodsgreat_8c");
  }

  level thread function_1acabfd8();
}

function function_51facb7e() {
  level.player hms_util::dialogue("vox_cp_ymnt_01600_masn_thanksbuddy_fb");
}

function function_1acabfd8() {
  level flag::wait_till("flg_bunker_explore_elevator_creak");
  level thread function_309cdab5();
  level flag::wait_till("flg_end_zipline_state");

  if(!level flag::get("flg_bunker_mason_breathing_vo_done")) {
    level dialogue::function_3db52a33();
  }

  if(math::cointoss()) {
    level.player thread hms_util::dialogue("vox_cp_ymnt_02800_masn_damnitscold_07");
  } else {
    level.player thread hms_util::dialogue("vox_cp_ymnt_02800_masn_damnitscoldinhe_c2");
  }

  wait 0.75;
  level.player playgestureviewmodel("ges_t9_cp_yam_its_cold");
}

function function_309cdab5() {
  level.player hms_util::dialogue("vox_cp_ymnt_02800_masn_heavybreathing_42");
  level flag::set("flg_bunker_mason_breathing_vo_done");
}

function function_1bf4e6d0() {
  self hms_util::dialogue("vox_cp_ymnt_01700_rms1_iheardmovementd_a0");
}

function function_b0f63343(ai) {
  ai hms_util::dialogue("vox_cp_ymnt_01700_rms2_comradesbeadvis_22");
  wait 1;

  if(isalive(ai) && !is_true(ai.in_melee_death)) {
    ai hms_util::dialogue("vox_cp_ymnt_01700_rms1_copythatcomrade_f0");
  }
}

function function_d87fc317(var_e37ea03f, var_8933ebaf) {
  level endon(#"flg_stop_bunker_encounter_stealth_scavenger_vo");
  var_e37ea03f thread function_2cf32df9("flg_stop_bunker_encounter_stealth_scavenger_vo");
  var_e37ea03f thread function_253ffb1d("flg_stop_bunker_encounter_stealth_scavenger_vo");
  var_8933ebaf thread function_2cf32df9("flg_stop_bunker_encounter_stealth_scavenger_vo");
  var_8933ebaf thread function_253ffb1d("flg_stop_bunker_encounter_stealth_scavenger_vo");
  setDvar(#"hash_7fb1be9520b9a725", 800);
  setDvar(#"hash_6b57212fd4fcdd3a", 1000);

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_e37ea03f hms_util::dialogue("vox_cp_ymnt_02800_rms3_thisplacewasaba_6c");
  }

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_8933ebaf hms_util::dialogue("vox_cp_ymnt_02800_rms2_comradeareyousa_2a");
  }

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_e37ea03f hms_util::dialogue("vox_cp_ymnt_02800_rms3_avalanchesdontf_d5");
  }

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_8933ebaf hms_util::dialogue("vox_cp_ymnt_02800_rms2_bahweshouldntbe_5f");
  }

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_e37ea03f hms_util::dialogue("vox_cp_ymnt_02800_rms3_afraidofghostsc_3a");
  }

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_8933ebaf hms_util::dialogue("vox_cp_ymnt_02800_rms2_ifanythingimafr_84");
  }

  if(isalive(var_e37ea03f) && isalive(var_8933ebaf) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_8933ebaf hms_util::dialogue("vox_cp_ymnt_02800_rms2_letsfinishthisp_ee");
  }
}

function function_ca0f56e7() {
  self hms_util::dialogue("vox_cp_ymnt_01700_rms1_whatissoimporta_c8");
}

function function_aa09d92b() {
  if(math::cointoss()) {
    level.player hms_util::dialogue("vox_cp_ymnt_01800_masn_itslocked_eb");
    return;
  }

  level.player hms_util::dialogue("vox_cp_ymnt_01800_masn_huhitslocked_5e");
}

function function_c21ee7c3() {
  level.player hms_util::dialogue("vox_cp_ymnt_01800_masn_iwonderwhatthis_ff");
}

function function_2712fa2e() {
  var_77947f7f = 0;

  while(var_77947f7f == 0) {
    ai_speaker = array::random(level.var_5ceb0850);

    if(isalive(ai_speaker)) {
      var_77947f7f = 1;
      continue;
    }

    waitframe(1);
  }

  var_d200934d = array("vox_cp_ymnt_01700_rms1_iheardmovementd_a0", "vox_cp_ymnt_01700_rms1_comradehaveyouf_fa", "vox_cp_ymnt_02500_rms3_youguysfindanyt_a7", "vox_cp_ymnt_02500_rms3_keeplookingiwan_95", "vox_cp_ymnt_02500_rms2_markyourareaass_f4", "vox_cp_ymnt_02500_rms3_keepyourguardup_da");
  var_73ed8f7d = randomintrange(0, var_d200934d.size);

  if(isalive(ai_speaker) && !level flag::get("stealth_spotted")) {
    ai_speaker hms_util::dialogue(var_d200934d[var_73ed8f7d]);
  }
}

function function_26ebe6d8() {
  level endon(#"flg_bunker_encounter_patrol_cleared");
  level flag::wait_till("flg_bunker_encounter_key_hint");

  if(isalive(level.var_20529448[0]) && !level flag::get("flg_bunker_stealth_fail")) {
    var_8fb62d7c = randomint(3);
    str_vo = "";

    switch (var_8fb62d7c) {
      case 0:
        str_vo = "vox_cp_ymnt_02800_masn_huhalockerkeywo_c1";
        break;
      case 1:
        str_vo = "vox_cp_ymnt_02800_masn_huhakeywonderwh_9b";
        break;
      default:
        str_vo = "vox_cp_ymnt_02800_masn_thislookspretty_19";
        break;
    }

    level.var_20529448[0] thread hms_util::dialogue(str_vo);
  }
}

function function_4acd5495() {
  level endon(#"flg_bunker_encounter_end");
  level flag::wait_till("flg_bunker_encounter_patrol_cleared");
  wait 2;

  if(!level flag::get("flg_bunker_encounter_end")) {
    level.player hms_util::dialogue("vox_cp_ymnt_01900_wood_masondoyoureadm_d8", 1);
    wait 0.5;
    level.player hms_util::dialogue("vox_cp_ymnt_01900_masn_ireadyouyoumust_41");
  }
}

function function_e9a2030c() {
  level.player thread hms_util::dialogue("vox_cp_ymnt_01800_masn_huhbetthisopens_67");
}

function function_9cfeeedb(var_f01bc0fc, var_f507e604) {
  level endon(#"flg_stop_bunker_encounter_optional_encounter_vo");
  var_f01bc0fc thread function_2cf32df9("flg_stop_bunker_encounter_optional_encounter_vo");
  var_f01bc0fc thread function_253ffb1d("flg_stop_bunker_encounter_optional_encounter_vo");
  var_f507e604 thread function_2cf32df9("flg_stop_bunker_encounter_optional_encounter_vo");
  var_f507e604 thread function_253ffb1d("flg_stop_bunker_encounter_optional_encounter_vo");
  level flag::wait_till("flg_bunker_optional_encounter_alert");

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f01bc0fc hms_util::dialogue("vox_cp_ymnt_01800_rms1_areyousurethisi_4a");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f507e604 hms_util::dialogue("vox_cp_ymnt_01800_rms2_ofcourseimsuren_8c");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f01bc0fc hms_util::dialogue("vox_cp_ymnt_01800_rms1_openit_b0");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f507e604 hms_util::dialogue("vox_cp_ymnt_01800_rms2_youhavethekey_f9");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f01bc0fc hms_util::dialogue("vox_cp_ymnt_01800_rms1_iithoughtyouhad_d7");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f507e604 hms_util::dialogue("vox_cp_ymnt_01800_rms2_idiotthenhoware_d0");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f01bc0fc hms_util::dialogue("vox_cp_ymnt_01800_rms1_useagrenadeblow_76");
  }

  if(isalive(var_f01bc0fc) && isalive(var_f507e604) && !namespace_979752dc::any_groups_in_combat(array("sg_bunker_optional"))) {
    var_f507e604 hms_util::dialogue("vox_cp_ymnt_01800_rms2_idiotthenwerisk_e5");
  }
}

function function_fc9043bb() {
  level.player thread hms_util::dialogue("vox_cp_ymnt_01800_masn_welllookatthis_ec");
}

function function_20b65fc7() {
  var_efbd4bcf = randomintrangeinclusive(0, 3);

  if(var_efbd4bcf == 0) {
    self thread hms_util::dialogue("vox_cp_ymnt_01700_rms1_whathappenedher_3f");
    return;
  }

  if(var_efbd4bcf == 1) {
    self thread hms_util::dialogue("vox_cp_ymnt_01700_rms1_whatisthisalpha_e0");
    return;
  }

  if(var_efbd4bcf == 2) {
    self thread hms_util::dialogue("vox_cp_ymnt_01700_rms1_whatalertthecom_5c");
    return;
  }

  if(var_efbd4bcf == 3) {
    self thread hms_util::dialogue("vox_cp_ymnt_01700_rms1_whatisthisalert_f7");
  }
}

function function_117649d4() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01900_wood_followtheglowst_0c");
}

function function_8f4e51f7() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01900_wood_upherecomeonyou_e9");
}

function function_e7b6bd1f() {
  if(!level flag::get("flg_bunker_stealth_fail") && !level flag::get("flg_woods_regroup_stealth_dialogue_complete")) {
    level.ai_woods thread dialogue::queue("vox_cp_ymnt_01900_wood_yousneakysonofa_8f", undefined, 1);
    level.player notify(#"bunker_stealth_successful");
    level flag::set("flg_woods_regroup_stealth_dialogue_complete");
  } else if(!level flag::get("flg_woods_regroup_stealth_dialogue_complete") && level.player getcurrentweapon() == getweapon(#"knife_loadout")) {
    level.ai_woods thread dialogue::queue("vox_cp_ymnt_01900_wood_shityoudidallth_04", undefined, 1);
    level flag::set("flg_woods_regroup_stealth_dialogue_complete");
  } else if(!level flag::get("flg_woods_regroup_stealth_dialogue_complete")) {
    level.ai_woods thread dialogue::queue("vox_cp_ymnt_01900_wood_hurryupwithther_96", undefined, 1);
    level flag::set("flg_woods_regroup_stealth_dialogue_complete");
  }

  level flag::set("flg_start_regroup_dialog");
}

function function_1363110() {
  level flag::wait_till("flg_bunker_survey_dialogue_start");
  level.player dialogue::queue("vox_cp_ymnt_01900_masn_youvebeenbusy_de", undefined, 1);
  wait 0.5;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_01900_wood_thatswhattheypa_9e");
  level flag::wait_till("flg_regroup_woods_entered_office");
  wait 1.5;

  if(!level flag::get("flg_bunker_office_entered")) {
    level.ai_woods dialogue::queue("vox_cp_ymnt_01900_wood_inhere_a9", undefined, 1);
  }
}

function function_2a8819d1() {
  level thread function_6d020c38(4);
  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01900_wood_seethathugecran_81");
}

function function_8cc6c411() {
  level endon(#"survey_equipment_exit");

  if(!level flag::get("flg_survey_speaking")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_therewhatsthat_58");
    level.player dialogue::queue("vox_cp_ymnt_02500_masn_bingo_1d", undefined, 1);
  } else {
    wait 2;

    if(!level flag::get("flg_survey_speaking")) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_therewhatsthat_58");
      level.player dialogue::queue("vox_cp_ymnt_02500_masn_bingo_1d", undefined, 1);
    }
  }

  var_efbd4bcf = randomintrangeinclusive(0, 2);

  if(var_efbd4bcf == 0) {
    level thread function_6d020c38(2);
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_thatcranematche_3e");
  } else if(var_efbd4bcf == 1) {
    level thread function_6d020c38(3);
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_mapsaysthatcran_a4");
  } else if(var_efbd4bcf == 2) {
    level thread function_6d020c38(4);
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_mapsaysthatcran_92");
  }

  if(math::cointoss()) {
    level thread function_6d020c38(2);
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01900_wood_thatswherewenee_19");
    return;
  }

  level thread function_6d020c38(2);
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_thatsgottabeit_50");
}

function function_297633ed() {
  level endon(#"survey_equipment_crane_line_said");

  if(!level flag::get("flg_survey_speaking")) {
    level thread function_6d020c38(2);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02500_wood_seeanydigsites_60");
  }

  wait 8;

  if(!level flag::get("flg_survey_speaking")) {
    level thread function_6d020c38(4);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02500_wood_ifimreadinthism_c3");
  }

  wait 4;

  if(!level flag::get("flg_survey_speaking")) {
    level thread function_6d020c38(2);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02500_wood_morenorth_ec");
  }

  wait 8;

  if(!level flag::get("flg_survey_speaking")) {
    level thread function_6d020c38(4);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01900_wood_youaskmetheyreh_fc");
  }

  wait 8;

  if(!level flag::get("flg_survey_speaking")) {
    level thread function_6d020c38(4);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01900_wood_steinerhadallso_95");
    wait 1;
    level thread function_6d020c38(4);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01900_wood_nova6wasjustthe_7e");
  }

  wait 8;

  if(!level flag::get("flg_survey_speaking")) {
    level thread function_6d020c38(4);
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_01900_wood_looksliketheyre_95");
  }

  wait 8;
  e_survey_radio_vo_source = getent("e_survey_radio_vo_source", "targetname");
  source = spawn("script_model", e_survey_radio_vo_source.origin);
  source hms_util::dialogue("vox_cp_ymnt_01300_rms3_reporttothedata_00");
  level notify(#"hash_6b2091e6c001e49a");
}

function function_6d020c38(f_delay) {
  level flag::set("flg_survey_speaking");
  wait f_delay;
  level flag::clear("flg_survey_speaking");
}

function function_8d5b3937() {
  level endon(#"flg_excavation_descent_started");
  e_survey_loudspeaker_source = getent("e_survey_loudspeaker_source", "targetname");
  source = spawn("script_model", e_survey_loudspeaker_source.origin);

  while(true) {
    source hms_util::dialogue("vox_cp_ymnt_01900_rms1_letspackitupwes_99");
    wait randomfloatrange(10, 14);
    source hms_util::dialogue("vox_cp_ymnt_01900_rms2_comradesbeadvis_07");
    wait randomfloatrange(10, 14);
    source hms_util::dialogue("vox_cp_ymnt_01900_rms2_markyourareaass_fa");
    wait randomfloatrange(10, 14);
    source hms_util::dialogue("vox_cp_ymnt_01900_rms3_keeplookingiwan_9d");
    wait randomfloatrange(10, 14);
  }
}

function function_dd08d77() {
  level.player endon(#"death");
  hms_util::dialogue("vox_cp_ymnt_02000_blkv_haveyoufoundthe_ad", 1);
  wait 0.4;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02000_wood_theresabigcrane_b6");
  wait 0.5;
  hms_util::dialogue("vox_cp_ymnt_02000_blkv_excusememywinch_09", 1);
  wait 0.2;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02000_wood_sorryyourebreak_23");
  wait 0.3;
  level flag::set("flg_excavation_exit_dialogue_complete");
}

function function_23b5ec00() {
  level endon(#"flg_excavation_descent_started");
  level flag::wait_till("flg_excavation_exit_dialogue_complete");
  wait 10;

  while(!level flag::get("flg_excavation_woods_descend_start")) {
    wait 10;
    str_nag = function_120f824d();
    level.ai_woods hms_util::dialogue(str_nag);
    wait 8;
  }
}

function function_120f824d() {
  var_1752ca8e = ["vox_cp_ymnt_02500_wood_masonheaddownth_4d", "vox_cp_ymnt_02500_wood_masonletsgo_14", "vox_cp_ymnt_02500_wood_downthecablemas_22", "vox_cp_ymnt_02500_wood_downthecablemas_7b"];

  if(level.var_38332ffe >= var_1752ca8e.size) {
    level.var_38332ffe = 0;
  }

  var_2bbd3a17 = var_1752ca8e[level.var_38332ffe];
  level.var_38332ffe++;
  return var_2bbd3a17;
}

function function_21e7292a(ai_speaker) {
  ai_speaker hms_util::dialogue("vox_cp_ymnt_02000_rms1_letspackitupwes_41");
}

function function_df5b726(ai_speaker) {
  if(math::cointoss()) {
    ai_speaker hms_util::dialogue("vox_cp_ymnt_02000_rms1_theintrudersare_5e");
    return;
  }

  ai_speaker hms_util::dialogue("vox_cp_ymnt_01700_rms1_intruder_6e");
}

function function_52a8784() {
  level.var_38332ffe = 0;
  level flag::wait_till("excavation_chopper_strafe_complete");
  wait 10;

  while(!level flag::get("flg_excavation_alpha_right_rein_spawn")) {
    wait 10;
    str_nag = function_e19c38aa();
    level.ai_woods hms_util::dialogue(str_nag);
    wait 8;
  }

  wait 10;
  s_excavation_nag_bravo = struct::get("s_excavation_nag_bravo", "targetname");

  while(!level flag::get("flg_excavation_alpha_lower_spawn")) {
    while(distance2d(level.player.origin, s_excavation_nag_bravo.origin) > 1500) {
      wait 8;
      str_nag = function_e19c38aa();
      level.ai_woods hms_util::dialogue(str_nag);
      wait 8;
    }

    waitframe(1);
  }

  wait 10;
  s_excavation_nag_charlie = struct::get("s_excavation_nag_charlie", "targetname");

  while(!level flag::get("flg_excavation_charlie_entered")) {
    while(distance2d(level.player.origin, s_excavation_nag_charlie.origin) > 1500) {
      wait 8;
      str_nag = function_e19c38aa();
      level.ai_woods hms_util::dialogue(str_nag);
      wait 8;
    }

    waitframe(1);
  }

  wait 10;
  s_excavation_nag_delta = struct::get("s_excavation_nag_delta", "targetname");

  while(!level flag::get("flg_excavation_delta_zipline_used")) {
    while(distance2d(level.player.origin, s_excavation_nag_delta.origin) > 1500) {
      wait 8;
      str_nag = function_e19c38aa();
      level.ai_woods hms_util::dialogue(str_nag);
      wait 8;
    }

    waitframe(1);
  }
}

function function_e19c38aa() {
  var_1752ca8e = ["vox_cp_ymnt_02000_wood_masonwegottaget_b8", "vox_cp_ymnt_02000_wood_keepmoving_56", "vox_cp_ymnt_02000_wood_pickthepaceupma_11", "vox_cp_ymnt_02000_wood_wegottagettotha_07", "vox_cp_ymnt_02000_wood_moveitmason_ff"];

  if(level.var_38332ffe >= var_1752ca8e.size) {
    level.var_38332ffe = 0;
  }

  var_2bbd3a17 = var_1752ca8e[level.var_38332ffe];
  level.var_38332ffe++;
  return var_2bbd3a17;
}

function function_e5859acb() {
  var_78ee896 = ["vox_cp_ymnt_02800_wood_dimitriwerepinn_66", "vox_cp_ymnt_02800_wood_belikovwerepinn_6c", "vox_cp_ymnt_02800_wood_dimitriwerepinn_c2", "vox_cp_ymnt_02800_wood_belikovwerepinn_e7", "vox_cp_ymnt_02800_wood_dimitriwerepinn_a7"];
  var_d89d0037 = ["vox_cp_ymnt_02800_blkv_copythatwoods_e5", "vox_cp_ymnt_02800_blkv_thoughtyoudneve_7f", "vox_cp_ymnt_02800_blkv_areyoukiddingho_b7", "vox_cp_ymnt_02800_blkv_theydontcallita_61"];
  var_c828af17 = ["vox_cp_ymnt_02800_blkv_thereproblemsol_d8", "vox_cp_ymnt_02800_blkv_likeyour4thofju_c5"];
  level flag::wait_till("excavation_start_chopper_strafe_run_timer");
  wait 1;
  level.ai_woods hms_util::dialogue(array::random(var_78ee896));
  hms_util::dialogue(array::random(var_d89d0037), 1);
  level flag::wait_till("excavation_chopper_strafe_complete");
  hms_util::dialogue("vox_cp_ymnt_02800_blkv_likeyour4thofju_c5", 1);
  hms_util::dialogue("vox_cp_ymnt_02800_blkv_yourewelcome_3c", 1);
}

function function_4b1535c7() {
  self endon(#"hash_4c7ded9d08b15793", #"death");
  s_notify = self waittill(#"damage");

  if(s_notify.attacker == level.player) {
    wait 1;

    if(!is_true(level.ai_woods.istalking)) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_niceshot_7e");
    }

    return;
  }

  if(s_notify.attacker == level.ai_woods) {
    wait 1;

    if(!is_true(level.ai_woods.istalking)) {
      level.player thread hms_util::dialogue("vox_cp_ymnt_02000_masn_niceshootingwoo_90");
    }
  }
}

function function_4ef400c0() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02000_wood_watchtherooftop_a2");
}

function function_8ee23971(var_69c603d9) {
  wait 5;
  f_dist = distance2d(level.player.origin, level.ai_woods.origin);

  while(f_dist > 500) {
    wait 0.1;
  }

  if(isalive(var_69c603d9) && !level flag::get("flg_excavation_alpha_bunker_retreat")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02000_wood_wegotincomingca_36");
  }
}

function function_1b881326() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02000_wood_hostilesonthezi_e6");
}

function function_7337a5cc() {
  var_ecf165d2 = ["vox_cp_ymnt_02700_rms3_alertarmedintru_55", "vox_cp_ymnt_02700_rms3_repeatarmedintr_2d", "vox_cp_ymnt_02700_rms3_requestingaddit_c2", "vox_cp_ymnt_02700_rms3_allavailableuni_2d"];
  var_da51ecaf = getEntArray("e_excavation_loudspeaker", "targetname");
  var_f5d09ba7 = 0;

  while(!level flag::get("flg_excavation_zipline_exit")) {
    if(var_f5d09ba7 >= var_ecf165d2.size) {
      var_f5d09ba7 = 0;
    }

    n_wait_time = function_ec870a71(var_da51ecaf, var_ecf165d2, var_f5d09ba7);
    var_f5d09ba7++;
    wait n_wait_time;
    wait randomfloatrange(10, 15);
  }
}

function function_ec870a71(var_da51ecaf, var_ecf165d2, var_f5d09ba7) {
  foreach(var_21c17c08 in var_da51ecaf) {
    var_21c17c08 thread hms_util::dialogue(var_ecf165d2[var_f5d09ba7]);
  }

  n_wait_time = soundgetplaybacktime(var_ecf165d2[var_f5d09ba7]) * 0.001;

  if(n_wait_time < 0) {
    n_wait_time = 4;
  }

  return n_wait_time;
}

function function_d6e3ed97() {
  self endon(#"death");
  level flag::wait_till_all(array("flg_excavation_turret_approached", "flg_excavation_turret_shooting"));

  if(!level flag::get("flg_excavation_turret_detach")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_turret12oclock_e1");
  }

  wait 5;

  if(!level flag::get("flg_excavation_turret_detach")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_shitfindcover_ba");
  }

  wait 5;

  if(!level flag::get("flg_excavation_turret_detach")) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_findcoverthattu_9f");
  }
}

function function_c492928b() {
  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_nicework_83");
}

function function_c05409c7() {
  var_efbd4bcf = randomintrangeinclusive(0, 2);

  if(var_efbd4bcf == 0) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_shithopethisone_fa");
    return;
  }

  if(var_efbd4bcf == 1) {
    level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02000_wood_letshopethisone_05");
    return;
  }

  if(var_efbd4bcf == 2) {
    level.player thread hms_util::dialogue("vox_cp_ymnt_02000_masn_damnthingbetter_ef");
  }
}

function function_18babf5c() {
  hms_util::dialogue("vox_cp_ymnt_02100_blkv_comradewoodsimo_96", 1);

  while(level.ai_woods.istalking === 1) {
    wait 0.1;
  }

  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02100_wood_weseeyoudimitri_9a");

  while(level.ai_woods.is_ziplining === 1) {
    wait 0.1;
  }

  if(!level flag::get("flg_server_reveal_jump_start")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02100_wood_wereoutoftimewe_98");
  }

  wait 5;

  if(!level flag::get("flg_server_reveal_jump_start")) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02500_wood_slidedown_ea");
  }
}

function function_86c78d49() {
  level.player endon(#"death");
  wait 5;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02100_wood_letsgomason_f4");
}

function function_7cf87afb() {
  level endon(#"flg_server_woods_slide", #"flg_server_woods_front");
  wait 12;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02100_wood_gettothemainfra_75");
}

function function_38d13158() {
  level notify(#"hash_5eb6abccef31804a");
  level endon(#"hash_5eb6abccef31804a");
  wait 2;
  level.ai_woods dialogue::function_47b06180();
  hms_util::dialogue("vox_cp_ymnt_02100_blkv_isserverbigbeca_97", 1);
  wait 2;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02100_wood_uhhhhnoitsregul_12");
}

function function_49572f9a() {
  level notify(#"hash_5eb6abccef31804a");
  level endon(#"hash_5eb6abccef31804a");
  level.ai_woods dialogue::function_47b06180();
  wait 2;
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02100_wood_dimitriwereinpo_5d");
  level thread scene::play("scene_yam_8005_srv_server_hook_drop", array(level.e_server_cable, level.e_server_hook));
  wait 1;
  hms_util::dialogue("vox_cp_ymnt_02100_blkv_lowering_68", 1);
}

function function_d5600243(str_flag) {
  level endon(str_flag);
  var_1752ca8e = ["vox_cp_ymnt_02000_wood_masonwegottaget_b8", "vox_cp_ymnt_02000_wood_keepmoving_56", "vox_cp_ymnt_02000_wood_pickthepaceupma_11", "vox_cp_ymnt_02000_wood_wegottagettotha_07", "vox_cp_ymnt_02000_wood_moveitmason_ff"];
  level.ai_woods.var_9680b06e = 0;

  while(true) {
    wait 8;
    str_nag = function_b2261971(var_1752ca8e);
    level.ai_woods hms_util::dialogue(str_nag);
    wait 8;
  }
}

function function_b2261971(var_1752ca8e) {
  if(level.ai_woods.var_9680b06e >= var_1752ca8e.size) {
    level.ai_woods.var_9680b06e = 0;
  }

  var_2bbd3a17 = var_1752ca8e[level.ai_woods.var_9680b06e];
  level.ai_woods.var_9680b06e++;
  return var_2bbd3a17;
}

function function_b9120b48() {
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02200_wood_comeonmason_ec");
}

function function_f7bb5f39() {
  while(!level flag::get("flg_server_cable_attaching")) {
    flag::wait_till_timeout(8, "flg_server_cable_attaching");

    if(!level flag::get("flg_server_cable_attaching")) {
      level.ai_woods hms_util::dialogue("vox_cp_ymnt_02200_wood_masonattachthis_a4");
    }

    flag::wait_till_timeout(5, "flg_server_cable_attaching");

    if(!level flag::get("flg_server_cable_attaching")) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02200_wood_comeonmason_ec");
    }

    flag::wait_till_timeout(8, "flg_server_cable_attaching");

    if(!level flag::get("flg_server_cable_attaching")) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02200_wood_wedontgotallday_ce");
    }

    flag::wait_till_timeout(8, "flg_server_cable_attaching");

    if(!level flag::get("flg_server_cable_attaching")) {
      level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02200_wood_attachthatfucki_65");
    }
  }
}

function function_a603f109() {
  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02200_wood_werelockedindim_29");
}

function function_4175d4c2() {
  hms_util::dialogue("vox_cp_ymnt_02200_blkv_goingup_1a", 1);
  level waittill(#"woods_stumble_forward");

  if(level.var_decec793 < 2) {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02300_wood_damnitthatserve_ab");
  } else {
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_02300_wood_woahshitcareful_c9");
  }

  level thread hms_util::dialogue("vox_cp_ymnt_02300_blkv_thisweightismos_e4", 1);
  level waittill(#"hash_7fd5af6a8ecf4f70");
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02300_wood_pickupthepacebe_df");
  level thread hms_util::dialogue("vox_cp_ymnt_02300_blkv_hangon_9c", 1);
  level waittill(#"hash_7fd5b16a8ecf52d6");
  level.ai_woods thread hms_util::dialogue("vox_cp_ymnt_02300_wood_shit_b9");
  level waittill(#"hash_7fd5b46a8ecf57ef");
  level.ai_woods hms_util::dialogue("vox_cp_ymnt_02300_wood_fuckslowdownslo_26");
  level hms_util::dialogue("vox_cp_ymnt_02300_blkv_speedupslowdown_03", 1);
}

function function_2cf32df9(str_flag) {
  self endon(#"death");
  self waittill(#"takedown_begin");

  if(isDefined(str_flag)) {
    level flag::set(str_flag);
  }

  self dialogue::function_47b06180();
}

function function_253ffb1d(str_flag) {
  self endon(#"death");
  level flag::wait_till("stealth_spotted");

  if(isDefined(str_flag)) {
    level flag::set(str_flag);
  }

  self dialogue::function_47b06180();
}