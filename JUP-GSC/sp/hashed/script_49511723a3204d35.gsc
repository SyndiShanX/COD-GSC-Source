/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_49511723a3204d35.gsc
*************************************************/

#using script_389a9d54d8274d2a;
#using script_3ef1b643f06851a8;
#using scripts\anim\dialogue;
#using scripts\asm\gesture;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\loot;
#using scripts\sp\utility;
#namespace namespace_f43c40f7bcbe17e7;

function function_b85fe24f0a9139b2() {}

function function_72cf1844bf828de4() {
  level endon("flg_bomb_defused");

  if(isDefined(level.var_6ef05c49e46d8d70) && isarray(level.var_6ef05c49e46d8d70)) {
    foreach(flag_endon in level.var_6ef05c49e46d8d70) {
      if(utility::flag_exist(flag_endon) && utility::flag(flag_endon)) {
        return 0;
      }
    }

    return;
  }

  if(isDefined(level.var_6ef05c49e46d8d70) && utility::flag_exist(level.var_6ef05c49e46d8d70) && utility::flag(level.var_6ef05c49e46d8d70)) {
    return 0;
  }
}

function function_34b628a5e3beadad() {
  level endon("flg_bomb_defused");

  while(true) {
    level waittill("stop_surge_nags");
    utility::flag_set("flag_surge_stop_nags");
    wait 1;
    utility::flag_clear("flag_surge_stop_nags");
  }
}

function function_4256d29a648763ba() {
  level endon("flg_bomb_defused");
  f_wait = 0;
  var_cb2bef8d2651433f = 3;

  while(level.player dialogue::function_d871f93553913276() && f_wait < var_cb2bef8d2651433f) {
    wait 0.5;
    f_wait += 0.5;
  }
}

function function_7d8f3cd61e8c2384() {}

function function_11a71287b86d1e5c() {
  var_e92a2c7e71663510 = [[level.player, 2.4, "dx_sp_surg_pigc_ghos_bravo07towatchercctv"], [level.var_318c75041f10c73f, 2, "dx_sp_surg_pigc_lasw_copyvisualradiocheck"], [level.var_30ea3080946719e6, 0.4, "dx_sp_surg_pigc_pric_checksixinposition"], [level.var_1e081d778021da22, 0.6, "dx_sp_surg_pigc_soap_soaploudandclear"], [level.var_351f8aca05656919, 0.5, "dx_sp_surg_pigc_gazz_affirmeyesonthemarkb"], [level.var_318c75041f10c73f, 1.5, "dx_sp_surg_pigc_lasw_goodcheckletsgotowor"], [level.var_292c01a9cd0b2818, 0.4, "dx_sp_surg_pigc_ghos_roggetreadytomovesoa"], [level.var_318c75041f10c73f, 0.8, "dx_sp_surg_pigc_lasw_keepalowprofilewelos"]];
  level dialogue::say_sequence(var_e92a2c7e71663510, 1, 0, 0, 0, "team");
}

function function_5efffec1d9fa71a8() {}

function function_a8f8b681ba867e0c() {
  level thread function_d3bda24ae338ed2a();
  level thread function_6b62d6e86dbe829();
  level thread function_c70c4c0f13ee6fb8();
  level thread function_3421ffcf5ba766fb();
  level thread function_34b628a5e3beadad();
  level dialogue::set_nagvars(0, 1, 0, "team");
  var_af36b904b56328b7 = getEntArray("out_of_bounds", "targetname");
  utility::array_thread(var_af36b904b56328b7, &function_e9feeb282fcf3ef8);
}

function function_d3bda24ae338ed2a() {
  level endon("flg_park_whiskey_leave_1");

  if(utility::cointoss()) {
    var_db93d267ae7551c2 = [[level.var_318c75041f10c73f, 0.5, "dx_sp_surg_pstl_lasw_beadvisedshelooksski", &function_72cf1844bf828de4], [level.player, 0.2, "dx_sp_surg_pstl_soap_understood", &function_72cf1844bf828de4], [level.var_292c01a9cd0b2818, 0.5, "dx_sp_surg_pstl_ghos_solidnowpressuptogaz", &function_72cf1844bf828de4]];
  } else {
    var_db93d267ae7551c2 = [[level.var_30ea3080946719e6, 1, "dx_sp_surg_pstl_pric_rolleasykonnimaybewa", &function_72cf1844bf828de4], [level.player, 0.2, "dx_sp_surg_pstl_soap_ayeillstayunderthera", &function_72cf1844bf828de4], [level.var_292c01a9cd0b2818, 0.4, "dx_sp_surg_pstl_ghos_solidnowpressuptogaz", &function_72cf1844bf828de4]];
  }

  level.var_6ef05c49e46d8d70 = ["flg_park_blend_tut_start", "flg_park_hacker_exit_early"];
  level dialogue::say_sequence(var_db93d267ae7551c2, 1, 0, 0, 0, "team");
  level thread function_12e23c2499524bff();
  utility::flag_wait("flg_park_blended");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();
  var_5ec75e08d6e8473e = [[level.player, 0.6, "dx_sp_surg_pstl_soap_gotalight", &function_72cf1844bf828de4], [level.var_292c01a9cd0b2818, 0.6, "dx_sp_surg_pstl_ghos_smokingjohnny", &function_72cf1844bf828de4], [level.player, 0.3, "dx_sp_surg_pstl_soap_blendinginlt", &function_72cf1844bf828de4], [level.var_292c01a9cd0b2818, 0.4, "dx_sp_surg_pstl_ghos_yousayso", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_park_whiskey_leave_1";
  level dialogue::say_sequence(var_5ec75e08d6e8473e, 1, 0, 0, 0, "team");
}

function function_12e23c2499524bff() {
  level endon("flg_park_blended");
  level endon("flg_park_whiskey_leave_1");
  aliases = [];
  aliases[aliases.size] = [level.var_292c01a9cd0b2818, "dx_sp_surg_pstl_ghos_movetogaztogeteyeson"];
  aliases[aliases.size] = [level.var_292c01a9cd0b2818, "dx_sp_surg_pstl_ghos_soapcloseongaztilthe"];
  nag_deck = utility::create_deck(aliases, 1, 1);
  var_5e531899936a10f9 = ["flg_park_player_close_to_gaz", "flg_park_blended", "flg_park_whiskey_leave_1", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(15, 30, 3), 15, 1);
  level thread function_ee9dec493e642a75();
  utility::flag_wait("flg_park_gaz_blend_start_nags");
  wait 1.6;

  if(!utility::flag("flg_park_whiskey_leave_1") || !utility::flag("flg_park_hacker_exit_early")) {
    level.var_292c01a9cd0b2818 dialogue::say_team("dx_sp_surg_pstl_ghos_nowjohnnylinkupwithg", 1, 2.5);
  }
}

function function_ee9dec493e642a75() {
  level endon("flg_park_blended");
  level endon("flg_park_whiskey_leave_1");
  utility::flag_wait("flg_park_player_close_to_gaz");
  aliases = [];
  aliases[aliases.size] = [level.var_292c01a9cd0b2818, "dx_sp_surg_pstl_ghos_themarkswearingablac"];
  aliases[aliases.size] = [level.var_292c01a9cd0b2818, "dx_sp_surg_pstl_ghos_marksstandingbythewa"];
  aliases[aliases.size] = [level.var_292c01a9cd0b2818, "dx_sp_surg_pstl_ghos_sheswearingallblackh"];
  nag_deck = utility::create_deck(aliases, 1, 1);
  var_5e531899936a10f9 = ["flg_park_blended", "flg_park_whiskey_leave_1", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(12, 24, 3), 8, 1);
}

function function_6b62d6e86dbe829() {
  level endon("flg_park_whiskey_path_2_arrived");
  level endon("flg_park_failed");
  utility::flag_wait("flg_park_whiskey_leave_1");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();

  if(utility::cointoss()) {
    var_8ba084b9e0b29ed4 = [[level.var_292c01a9cd0b2818, 0.8, "dx_sp_surg_pstl_ghos_targetsmovingsergean", &function_72cf1844bf828de4], [level.var_318c75041f10c73f, 0.4, "dx_sp_surg_pstl_lasw_ifshetakesacallortal", &function_72cf1844bf828de4], [level.player, 0.1, "dx_sp_surg_pstl_soap_copythatshetalksweli", &function_72cf1844bf828de4]];
  } else {
    var_8ba084b9e0b29ed4 = [[level.var_292c01a9cd0b2818, 0.8, "dx_sp_surg_pstl_ghos_targetsmovingsergean", &function_72cf1844bf828de4], [level.var_318c75041f10c73f, 0.5, "dx_sp_surg_pstl_lasw_staywithhersoap", &function_72cf1844bf828de4], [level.var_318c75041f10c73f, 0.2, "dx_sp_surg_pstl_lasw_justdontgettooclose", &function_72cf1844bf828de4], [level.player, 0.2, "dx_sp_surg_pstl_soap_onit", &function_72cf1844bf828de4]];
  }

  level.var_6ef05c49e46d8d70 = ["flg_park_whiskey_shoetie_start", "flg_park_hacker_react_vo_playing", "flg_park_failed"];
  level dialogue::say_sequence(var_8ba084b9e0b29ed4, 1, 0, 0, 0, "team");

  if(!utility::flag("flg_park_follow_hacker_obj_start")) {
    utility::flag_set("flg_park_follow_hacker_obj_start");
  }
}

function function_c70c4c0f13ee6fb8() {
  level endon("flg_park_whiskey_path_2_arrived");
  level endon("flg_park_failed");
  utility::flag_wait("flg_park_whiskey_shoetie_start");
  level.var_292c01a9cd0b2818 dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_pstl_ghos_waitshestyinghershoe", 1, 2.5);
  wait 0.3;

  if(!utility::flag("flg_park_blended") && level.var_27842e9538a928a2 < 1 && !utility::flag("flg_park_hacker_react_vo_playing")) {
    if(utility::cointoss()) {
      level.var_292c01a9cd0b2818 dialogue::say_team("dx_sp_surg_pstl_ghos_makeyourselflookbusy", 0, 1);
    } else {
      level.var_318c75041f10c73f dialogue::say_team("dx_sp_surg_pstl_lasw_useyoursurroundingst", 0, 1);
    }
  } else if(utility::flag("flg_park_blended") && level.var_27842e9538a928a2 < 1 && !utility::flag("flg_park_hacker_react_vo_playing")) {
    level.player dialogue::function_fc0eb6b81c66c661(0.35, "dx_sp_surg_pstl_soap_yeahshescautious", 0, 2.5);
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_surg_pstl_lasw_shesinoverherheadwit", 0, 2.5);
  }

  utility::flag_waitopen("flg_park_whiskey_shoetie_start");
  wait 0.5;

  if(!utility::flag("flg_park_hacker_react_vo_playing")) {
    level.var_292c01a9cd0b2818 dialogue::say_team("dx_sp_surg_pstl_ghos_marksmovingkeeponher", 1, 3);
  }
}

function function_3421ffcf5ba766fb() {
  level endon("flg_park_failed");
  utility::flag_wait("flg_park_whiskey_path_2_arrived");
  level notify("stop_surge_nags");
  level.player dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_pstl_soap_herphonesringing", 1, 2.5);
  wait 0.6;

  if(!utility::flag("flg_park_hacker_react_vo_playing")) {
    level.var_318c75041f10c73f dialogue::say_team("dx_sp_surg_pstl_lasw_getcloseandlistenin", 1, 5);
  }

  utility::flag_set("flg_park_obj_listen_to_call_show");
  level thread function_7767079a237f9772();
  utility::flag_wait_all("flg_park_phonecall_done", "flg_park_whiskey_path_3_started");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();

  if(utility::flag("flg_park_flash_drive_known") && utility::flag("flg_park_meeting_location_known")) {
    while(utility::flag("flg_park_final_blend_in_progress")) {
      waitframe();
    }

    thread function_bde4345e7a4dfbe5();
    var_fc88a5ef0db3fbc5 = [[level.var_318c75041f10c73f, 1.2, "dx_sp_surg_pstl_lasw_whatstheword"], [level.player, 0.3, "dx_sp_surg_pstl_soap_shemadeadeaddropfora"], [level.var_30ea3080946719e6, 0.3, "dx_sp_surg_pstl_pric_weneedeyes"], [level.var_318c75041f10c73f, 0.6, "dx_sp_surg_pstl_lasw_ghosttakepointoncctv"], [level.player, 0.2, "dx_sp_surg_pstl_ghos_rog"]];
    level dialogue::say_sequence(var_fc88a5ef0db3fbc5, 1, 0, 0, 0, "team");
    return;
  }

  var_4b1bacf91219bf53 = [[level.var_318c75041f10c73f, 1.2, "dx_sp_surg_pstl_lasw_whatstheword"], [level.player, 0.5, "dx_sp_surg_pstl_soap_missedtheconversatio"], [level.var_318c75041f10c73f, 0.8, "dx_sp_surg_pstl_lasw_weneededalltheintelb"]];
  level dialogue::say_sequence(var_4b1bacf91219bf53, 1, 0, 0, 0, "team");
  utility::flag_set("flg_park_eavesdrop_fail");
}

function function_7767079a237f9772() {
  level endon("flg_park_failed");
  level thread function_dd2f338da6e5e948();

  while(!utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
    wait 4;

    if(utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
      level.ai_hacker dialogue::say("dx_sp_surg_pstl_hack_keptitsecureitspluga", 1, 5);
      break;
    }

    wait 4;

    if(utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
      level.ai_hacker dialogue::say("dx_sp_surg_pstl_hack_guaranteeditllwork", 1, 5);
    }

    break;
  }

  utility::flag_set("flg_park_phonecall_start");
  wait 3;

  if(utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
    level.ai_hacker dialogue::say("dx_sp_surg_pstl_hack_heyigotthepayment", 1, 5);
  } else {
    wait 2;
  }

  wait 2;

  if(utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
    level.ai_hacker dialogue::say("dx_sp_surg_pstl_hack_droppedtheflashdrive", 1, 5);
    utility::flag_set("flg_park_flash_drive_known");
  } else {
    iprintln("<dev string:x1c>");

    wait 2;
  }

  wait 3;

  if(utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
    level.ai_hacker dialogue::say("dx_sp_surg_pstl_hack_yeahbetweenbistro43a_01", 1, 5);
    utility::flag_set("flg_park_meeting_location_known");
  } else {
    iprintln("<dev string:x1c>");

    wait 2;
  }

  wait 2;

  if(utility::flag("flg_park_eavesdrop_player_close_to_hacker")) {
    level.ai_hacker dialogue::say("dx_sp_surg_pstl_hack_pleasuredoingbusines", 1, 5);
  } else {
    wait 2;
  }

  utility::flag_set("flg_park_phonecall_done");
}

function function_dd2f338da6e5e948() {
  level endon("flg_park_failed");
  level endon("flg_park_phonecall_done");
  aliases = [];
  aliases[aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_pstl_lasw_listentoherconversat"];
  aliases[aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_pstl_lasw_closersergeantweneed"];
  aliases[aliases.size] = [level.var_292c01a9cd0b2818, "dx_sp_surg_pstl_ghos_johnnyweneedtoknowwh"];
  nag_deck = utility::create_deck(aliases, 1, 1);

  while(true) {
    utility::flag_waitopen("flg_park_eavesdrop_player_close_to_hacker");
    level dialogue::nag_wait("flg_park_eavesdrop_player_close_to_hacker", nag_deck, 6, 3, 1);
    wait 3;
  }
}

function function_dc0da5dc4646c321() {
  if(!isDefined(level.var_1cbd781282e0541f)) {
    level.var_1cbd781282e0541f = spawnStruct();
    var_6afb807d5f353d8 = [];
    var_998843e8d5810e46 = [];
    var_6d5b71ac10ae1647 = [];
    var_6afb807d5f353d8[var_6afb807d5f353d8.size] = "dx_sp_surg_pstl_hack_helookingatme";
    var_6afb807d5f353d8[var_6afb807d5f353d8.size] = "dx_sp_surg_pstl_hack_whosthat";
    var_6afb807d5f353d8[var_6afb807d5f353d8.size] = "dx_sp_surg_pstl_hack_thefuckshelookingat";
    level.var_1cbd781282e0541f.spotted_deck = utility::create_deck(var_6afb807d5f353d8, 1, 1);
    var_998843e8d5810e46[var_998843e8d5810e46.size] = "dx_sp_surg_pstl_hack_moveitdude";
    var_998843e8d5810e46[var_998843e8d5810e46.size] = "dx_sp_surg_pstl_hack_oiwatchit";
    var_998843e8d5810e46[var_998843e8d5810e46.size] = "dx_sp_surg_pstl_hack_backoffmate";
    level.var_1cbd781282e0541f.var_8462aa5b86bfbd58 = utility::create_deck(var_998843e8d5810e46, 1, 1);
    var_6d5b71ac10ae1647[var_6d5b71ac10ae1647.size] = "dx_sp_surg_pstl_lasw_shesawyoustayhidden";
    var_6d5b71ac10ae1647[var_6d5b71ac10ae1647.size] = "dx_sp_surg_pstl_lasw_staywithherjustdontg";
    var_6d5b71ac10ae1647[var_6d5b71ac10ae1647.size] = "dx_sp_surg_pstl_lasw_niceandnaturalsergea";
    level.var_1cbd781282e0541f.var_2618c8a568e31c10 = utility::create_deck(var_6d5b71ac10ae1647);
  }
}

function function_42d70b13f4e9e32a() {
  level endon("flg_park_phonecall_done");

  if(utility::flag("flg_park_hacker_react_vo_playing") || utility::flag("flg_park_phonecall_done")) {
    return;
  }

  utility::flag_set("flg_park_hacker_react_vo_playing");
  function_dc0da5dc4646c321();
  react_vo = level.var_1cbd781282e0541f.var_8462aa5b86bfbd58 deck_draw();
  level.ai_hacker dialogue::say_delayed(0.3, react_vo, 2, 2.5);
  wait 0.8;

  if(!utility::flag("flg_park_failed")) {
    var_f16f709264e3ca1b = level.var_1cbd781282e0541f.var_2618c8a568e31c10 deck_draw();
    level.var_318c75041f10c73f dialogue::say_team(var_f16f709264e3ca1b, 2, 5);
  }

  utility::flag_clear("flg_park_hacker_react_vo_playing");
}

function function_ffd1fc2c265a4c38() {
  level endon("flg_park_phonecall_done");

  if(utility::flag("flg_park_hacker_react_vo_playing") || utility::flag("flg_park_phonecall_done")) {
    return;
  }

  utility::flag_set("flg_park_hacker_react_vo_playing");
  function_dc0da5dc4646c321();

  if(!utility::within_fov_of_players(level.ai_hacker.origin, cos(45))) {
    var_1cb2b97cf14b6ff3 = level.var_1cbd781282e0541f.spotted_deck deck_draw_specific("dx_sp_surg_pstl_hack_whosthat");
  } else {
    var_1cb2b97cf14b6ff3 = level.var_1cbd781282e0541f.spotted_deck deck_draw();
  }

  if(isDefined(var_1cb2b97cf14b6ff3)) {
    utility::flag_set("flg_suspicion_vo_cooldown");
    utility::delaythread(3, &flag_clear, "flg_suspicion_vo_cooldown");
    level.ai_hacker dialogue::say_delayed(0.3, var_1cb2b97cf14b6ff3, 2, 1);
  }

  wait 0.8;

  if(!utility::flag("flg_park_failed")) {
    var_f16f709264e3ca1b = level.var_1cbd781282e0541f.var_2618c8a568e31c10 deck_draw();
    level.var_318c75041f10c73f dialogue::say_team(var_f16f709264e3ca1b, 2, 5);
  }

  utility::flag_clear("flg_park_hacker_react_vo_playing");
}

function function_e9feeb282fcf3ef8() {
  level endon("flg_park_whiskey_path_2_arrived");
  aliases = [];
  aliases[aliases.size] = "dx_sp_surg_pstl_ghos_wrongwayjohnnystayon";
  aliases[aliases.size] = "dx_sp_surg_pstl_ghos_thehellreyougoingsoa";
  aliases[aliases.size] = "dx_sp_surg_pstl_ghos_wrongdirectionjohnny";
  var_3ba00da147758d22 = utility::create_deck(aliases, 1, 1);

  while(!utility::flag("flg_park_whiskey_path_2_arrived")) {
    if(level.player istouching(self) && !flag("flg_park_oob_trigger_vo_playing")) {
      utility::flag_set("flg_park_oob_trigger_vo_playing");
      react_vo = var_3ba00da147758d22 deck_draw();
      level.var_292c01a9cd0b2818 function_fc0eb6b81c66c661(0.2, react_vo, 0, 2.5);
      wait randomfloatrange(8, 12);
      utility::flag_clear("flg_park_oob_trigger_vo_playing");
    }

    wait 1;
  }
}

function function_c83e2f5af6504843() {}

function function_2ebf44c80181c535() {
  level.player.name = "Ghost";
  level thread function_7d992c931b3bb28b();
  level thread function_2b6ab3213b6ee8c2();
  level thread function_d5456b7827dca239();
  level thread function_d8658ffb33c211c1();
  level thread function_804d65fe69197985();
  level dialogue::set_nagvars(0, 1, 0, "team");
}

function function_bde4345e7a4dfbe5() {
  wait 6.4;
  setmusicstate("mx_surge_cctv");
}

function function_7d992c931b3bb28b() {
  level endon("flg_rewind_target_seen_entering_tunnel");
  level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_scor_ghos_eyesonthealleyexit", 1);
  level.player dialogue::function_fc0eb6b81c66c661(1.5, "dx_sp_surg_scor_ghos_nosignofkonnimustvea", 1);
  level.var_318c75041f10c73f thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_scor_lasw_goodscrubthefootagef", 1);
  utility::flag_set("flg_cctv_rewind_1_allow");
  level thread function_60048cdc977d4931();
  utility::flag_wait("flg_rewind_target_first_seen");
  level notify("stop_surge_nags");
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_scor_ghos_foundhim", 1);
  level.var_318c75041f10c73f thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_scor_lasw_stayonhimghostwhatev", 1);
  utility::flag_set("flg_cctv_allow_tracking_progress");
  level thread function_c1cd5610ed0b7f6c();
  utility::flag_wait("flg_rewind_target_entered_bistro");
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_scor_ghos_buyerwentinteriorlos", 1);

  if(utility::flag("flg_cctv_1_active")) {
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_scor_lasw_switchtoadifferentca", 1);
  }

  level thread function_eea73119adecbc4e();

  while(true) {
    utility::flag_wait("flg_cctv_target_visible");

    if(!utility::flag("flg_cctv_allow_reacquire_target_cctv_1")) {
      if(!utility::flag("flg_cctv_1_active")) {
        break;
      }
    } else {
      break;
    }

    waitframe();
  }

  dialogue::function_cb329cf8896edeaa(level.player.team);
  utility::flag_set("flg_cctv_reacquired_target_vo_playing");
  level.player dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_surg_scor_ghos_reacquirediseehim", 2);
  utility::flag_clear("flg_cctv_reacquired_target_vo_playing");
  utility::flag_set("flg_cctv_allow_react_vo");
  utility::flag_set("flg_cctv_allow_reacquire_target_cctv_1");
  level thread function_66c82397e9b8dea9();
}

function function_60048cdc977d4931() {
  level endon("flg_rewind_target_first_seen");

  if(utility::flag("flg_rewind_target_first_seen")) {
    return;
  }

  wait 15;
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_scor_ghos_notseeinganyone", 0, 1);
  level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_scor_lasw_tryrewindingthefoota", 0, 1);
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_yourelookingforsomeo"];
  nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_keeprewindingtilwefi"];
  nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_rewindthefootageanyo"];
  nag_deck = utility::create_deck(nag_aliases);
  level dialogue::function_91c23782840cf632(["flg_rewind_target_first_seen", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(16, 48, 4), 10);
}

function function_eea73119adecbc4e() {
  level endon("flg_cctv_reacquired_target_vo_playing");
  level endon("flg_rewind_target_seen_entering_tunnel");

  if(utility::flag("flg_cctv_reacquired_target_vo_playing") || utility::flag("flg_rewind_target_seen_entering_tunnel")) {
    return;
  }

  wait 6;

  if(utility::flag("flg_cctv_1_active")) {
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_scor_lasw_useadifferentcamerag", 0, 1);
    wait 4;
  }

  wait 4;

  while(true) {
    utility::flag_waitopen("flg_cctv_1_active");
    wait 2;

    if(!utility::flag("flg_cctv_target_visible")) {
      utility::flag_set("flg_cctv_player_lost_target");
      break;
    }

    waitframe();
  }

  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_scor_ghos_ithinkilosthim", 0, 1);
  level.var_318c75041f10c73f thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_scor_lasw_gobacktothealleywaya", 0, 1);
  wait 0.5;
  utility::flag_set("flg_cctv_allow_reacquire_target_cctv_1");
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_needtoretracehisfoot"];
  nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_retracebacktowhereyo"];
  nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_rewindtowhereyoulast"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  var_5e531899936a10f9 = ["flg_cctv_reacquired_target_vo_playing", "flg_rewind_target_seen_entering_tunnel"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(16, 48, 4), 10);
}

function function_c1cd5610ed0b7f6c() {
  level endon("flg_rewind_target_seen_entering_tunnel");

  if(!isDefined(level.var_4a0543394aaec1bd)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_fastforwardsowecanse"];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_keepfastforwardinggh"];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_fastforwardweneedtot"];
    level.var_4a0543394aaec1bd = utility::create_deck(nag_aliases, 1, 1);
  }

  while(true) {
    utility::flag_wait("flg_cctv_target_fastforward_footage");
    level dialogue::nag_waitopen("flg_cctv_target_fastforward_footage", level.var_4a0543394aaec1bd, dialogue::growing_delay(16, 32, 4), 12);
    wait 3;
  }
}

function function_66c82397e9b8dea9() {
  level endon("flg_rewind_target_seen_entering_tunnel");

  if(!isDefined(level.var_4bfcde372641d143)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_lookforanothercamera"];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_tryadifferentcamera"];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_findanotherangleandr"];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_checkanothercameragh"];
    nag_aliases[nag_aliases.size] = [level.var_318c75041f10c73f, "dx_sp_surg_scor_lasw_useadifferentcamerag"];
    level.var_4bfcde372641d143 = utility::create_deck(nag_aliases);
  }

  while(true) {
    utility::flag_wait("flg_cctv_target_switch_cameras");
    level dialogue::nag_waitopen("flg_cctv_target_switch_cameras", level.var_4bfcde372641d143, dialogue::growing_delay(10, 25, 3), 5);
    wait 3;
  }
}

function function_13118232dd2c9226() {
  level endon("flg_rewind_target_seen_entering_tunnel");
  level endon("cctv_cancel_react_vo");

  if(!utility::flag("flg_cctv_allow_react_vo")) {
    return;
  }

  if(!isDefined(level.var_5501e7a0906eb74b)) {
    react_aliases = [];
    react_aliases[react_aliases.size] = "dx_sp_surg_scor_ghos_cantseehim";
    react_aliases[react_aliases.size] = "dx_sp_surg_scor_ghos_notseeinghimnow";
    react_aliases[react_aliases.size] = "dx_sp_surg_scor_ghos_ithinkilosthim";
    level.var_5501e7a0906eb74b = utility::create_deck(react_aliases);
  }

  wait 3;

  if(utility::flag("flg_cctv_ghost_react_force_disabled")) {
    utility::flag_waitopen_or_timeout("flg_cctv_ghost_react_force_disabled", 5);
    wait 1.5;
  }

  if(!utility::flag("flg_cctv_target_visible") && !utility::flag("flg_cctv_ghost_react_vo_playing")) {
    utility::flag_set("flg_cctv_ghost_react_vo_playing");
    react_vo = level.var_5501e7a0906eb74b deck_draw();
    level.player dialogue::say_team(react_vo, 0, 1);
    wait 3;
    utility::flag_clear("flg_cctv_ghost_react_vo_playing");
  }
}

function function_c81ef10d3cc37fb2() {
  level endon("flg_rewind_target_seen_entering_tunnel");
  level endon("cctv_cancel_react_vo");

  if(!utility::flag("flg_cctv_allow_react_vo")) {
    return;
  }

  if(!isDefined(level.var_2cf631a829f6c733)) {
    react_aliases = [];
    react_aliases[react_aliases.size] = "dx_sp_surg_scor_ghos_eyesbackon";
    react_aliases[react_aliases.size] = "dx_sp_surg_scor_ghos_regainedvisual";
    react_aliases[react_aliases.size] = "dx_sp_surg_scor_ghos_thereheis";
    level.var_2cf631a829f6c733 = utility::create_deck(react_aliases, 1, 1);
  }

  if(utility::flag("flg_cctv_6_active")) {
    wait 0.2;
  } else {
    wait 1;
  }

  if(utility::flag("flg_cctv_target_visible") && !utility::flag("flg_cctv_ghost_react_vo_playing")) {
    utility::flag_set("flg_cctv_ghost_react_vo_playing");
    react_vo = level.var_2cf631a829f6c733 deck_draw();
    level.player dialogue::say_team(react_vo, 0, 1);
    wait 3;
    utility::flag_clear("flg_cctv_ghost_react_vo_playing");
  }
}

function function_2b6ab3213b6ee8c2() {
  level endon("flg_rewind_target_seen_crossing_street");
  level endon("flg_rewind_target_seen_entering_tunnel");
  utility::flag_wait_all("bus_is_stationary", "flg_cctv_allow_react_vo");
  wait 0.3;

  if(utility::flag("flg_cctv_2_active")) {
    level thread function_8dae2d929d1c8655(5);
    level notify("cctv_cancel_react_vo");
    level.player dialogue::say_team("dx_sp_surg_scor_ghos_gotabusobscuringmyvi", 1);

    if(utility::flag("flg_cctv_target_switch_cameras")) {
      utility::flag_clear("flg_cctv_target_switch_cameras");
    }

    if(utility::flag("flg_cctv_1_active") || utility::flag("flg_cctv_2_active") || utility::flag("flg_cctv_3_active")) {
      level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_scor_lasw_findanewanglethen", 1);
    }
  }
}

function function_d5456b7827dca239() {
  level endon("flg_rewind_target_seen_crossing_street");
  level endon("flg_rewind_target_seen_entering_tunnel");
  utility::flag_wait("flg_rewind_target_seen_on_cartensburg_street");
  level notify("stop_surge_nags");
  level thread function_8dae2d929d1c8655(5);
  level notify("cctv_cancel_react_vo");
  wait 0.4;

  if(utility::flag("flg_cctv_reacquired_target_vo_playing")) {
    utility::flag_set("flg_cctv_target_crossing_vo_playing");
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_scor_lasw_affirmbuyerexitedbis", 1);
    utility::flag_clear("flg_cctv_target_crossing_vo_playing");
    return;
  }

  utility::flag_set("flg_cctv_target_crossing_vo_playing");
  function_4256d29a648763ba();
  var_524a445639fd299f = [[level.player, 0.1, "dx_sp_surg_scor_ghos_youseeinthislaswell"], [level.var_318c75041f10c73f, 0.15, "dx_sp_surg_scor_lasw_affirmbuyerexitedbis"]];
  level dialogue::say_sequence(var_524a445639fd299f, 1, 0, 0, 0, "team");
  utility::flag_clear("flg_cctv_target_crossing_vo_playing");
}

function function_d8658ffb33c211c1() {
  level endon("flg_rewind_target_seen_entering_tunnel");
  utility::flag_wait_all("flg_rewind_target_seen_crossing_street", "flg_cctv_allow_react_vo");
  level thread function_8dae2d929d1c8655(5);
  level notify("cctv_cancel_react_vo");
  level.player function_fc0eb6b81c66c661(0.3, "dx_sp_surg_scor_ghos_targetscrossingthest", 1);

  if(utility::cointoss()) {
    level.var_318c75041f10c73f function_fc0eb6b81c66c661(0.4, "dx_sp_surg_scor_lasw_hescrossingtoaimsley", 1);
    return;
  }

  level.var_1e081d778021da22 dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_scor_soap_keeponhimltwerecount", 1);
}

function function_804d65fe69197985() {
  level endon("flg_hideout_entry_breach_start");
  utility::flag_wait("flg_rewind_target_seen_entering_tunnel");
  utility::flag_set("flg_cctv_end_vo_playing");
  level notify("stop_surge_nags");
  level notify("cctv_cancel_react_vo");
  wait 0.3;
  function_4256d29a648763ba();
  var_b3996da319700933 = [[level.player, 0.1, "dx_sp_surg_scor_ghos_allbravotargetsheadi"], [level.var_318c75041f10c73f, 0.1, "dx_sp_surg_scor_lasw_tunnelsadeadend"], [level.var_351f8aca05656919, 0.3, "dx_sp_surg_scor_gazz_goodplaceforkonnitoh"], [level.var_30ea3080946719e6, 0.2, "dx_sp_surg_scor_pric_andmakarov"]];
  level dialogue::say_sequence(var_b3996da319700933, 1, 0, 0, 0, "team");
  wait 0.8;
  utility::flag_clear("flg_cctv_end_vo_playing");
}

function function_8dae2d929d1c8655(n_timeout) {
  level endon("flg_hideout_entry_breach_start");

  if(utility::flag("flg_cctv_ghost_react_force_disabled")) {
    utility::flag_waitopen_or_timeout("flg_cctv_ghost_react_force_disabled", n_timeout);
  }

  utility::flag_set("flg_cctv_ghost_react_force_disabled");
  utility::flag_set("flg_cctv_ghost_react_vo_playing");
  wait n_timeout;
  utility::flag_clear("flg_cctv_ghost_react_vo_playing");
  utility::flag_clear("flg_cctv_ghost_react_force_disabled");
}

function function_8559dad9732e85aa() {}

function function_6163de672e04d0e2() {
  level endon("flg_hideout_entry_breach_start");
  var_b418b4296e79ec17 = [[level.var_351f8aca05656919, 0.1, "dx_sp_surg_scor_gazz_wehavemetroandsforea"], [level.player, 0.2, "dx_sp_surg_scor_pric_copyallstationsgearu"], [level.var_30ea3080946719e6, 0.2, "dx_sp_surg_scor_pric_rogsixenroute"], [level.var_25932e13dae83dd3, 9.1, "dx_sp_surg_stun_sfo1_tunnelscleartheresal"], [level.var_25932e13dae83dd3, 0.4, "dx_sp_surg_stun_sfo1_atthedoorpreppingfor"]];
  level dialogue::say_sequence(var_b418b4296e79ec17, 1, 0, 0, 0, "team");
  level.player.name = "Price";
  level thread function_9f6a2e447d4f9a36();
}

function function_9f6a2e447d4f9a36() {
  level endon("breach_start");
  level thread function_3685d8d90f8ca4d1();

  while(!isDefined(level.ai_hideout_sfo_interior_1) || !isDefined(level.ai_hideout_sfo_interior_1[0])) {
    waitframe();
  }

  level.ai_hideout_sfo_interior_1[0] thread dialogue::function_fc0eb6b81c66c661(1.4, "dx_sp_surg_stun_sfo1_breachisuponyoursign", 1);
  level thread function_1d948623bcbce24();
  utility::flag_wait("flg_hideout_entry_breach_start");
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_stun_pric_readyletsgetthisdone", 1);
  utility::flag_set("flg_hideout_breach_setup_vo_complete");
}

function function_1d948623bcbce24() {
  level endon("flg_hideout_entry_breach_start");
  wait 10;
  level.ai_soap dialogue::say_team("dx_sp_surg_stun_soap_71holdingforbreach", 0, 2.5);
  wait 10;
  level.var_d18d63c6d75cd1e dialogue::say_team("dx_sp_surg_stun_gazz_6issetonyoucaptain", 0, 2.5);
}

function function_3685d8d90f8ca4d1() {
  level endon("flg_hideout_breached");

  while(!isDefined(level.var_bee15146f952c6ed)) {
    waitframe();
  }

  var_d2b90162c17d78ed = [];
  var_d2b90162c17d78ed[var_d2b90162c17d78ed.size] = "dx_sp_surg_stun_plmn_movealong";
  var_d2b90162c17d78ed[var_d2b90162c17d78ed.size] = "dx_sp_surg_stun_plmn_nothingtoseehereonyo";
  var_d2b90162c17d78ed[var_d2b90162c17d78ed.size] = "dx_sp_surg_stun_plmn_keepitmovingnow";
  var_d2b90162c17d78ed[var_d2b90162c17d78ed.size] = "dx_sp_surg_stun_plmn_keepwalking";
  var_d2b90162c17d78ed[var_d2b90162c17d78ed.size] = "dx_sp_surg_stun_plmn_onyago";
  var_758e41bbf9534044 = utility::create_deck(var_d2b90162c17d78ed, 1, 1);

  while(!utility::flag("flg_hideout_breached")) {
    var_59719e8d22215336 = utility::getclosest(level.player.origin, level.var_bee15146f952c6ed);

    if(isDefined(var_59719e8d22215336)) {
      distance_to_player = distance(level.player.origin, var_59719e8d22215336.origin);

      if(distance_to_player <= 600) {
        react_vo = var_758e41bbf9534044 deck_draw();
        var_59719e8d22215336 dialogue::say(react_vo);
        wait randomfloatrange(8, 12);
      }
    }

    wait 1;
  }
}

function function_458bd40c772ffd84() {}

function function_c5795c615a163823() {
  level thread function_c8a660649befbe28();
  level thread function_581e282f07f1c65c();
  level thread function_49f9c148989d36ca();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_79d20beee276e4d5() {
  level.player endon("death");
  level endon("flg_hideout_final_room_clear");
  aliases = [];
  aliases[aliases.size] = "dx_sp_surg_hcqc_pric_smokeout";
  aliases[aliases.size] = "dx_sp_surg_hcqc_pric_throwingsmoke";
  aliases[aliases.size] = "dx_sp_surg_hcqc_pric_poppingsmoke";
  react_deck = utility::create_deck(aliases, 1, 1);

  while(!utility::flag("flg_hideout_finale_done")) {
    utility::flag_clear("flg_hideout_smoke_occluder_destroyed");
    utility::flag_wait("flg_hideout_smoke_grenade_thrown");
    react_vo = react_deck utility::deck_draw();
    level.player dialogue::say(react_vo, 0, 0.5);
    utility::flag_waitopen("flg_hideout_smoke_grenade_thrown");
    utility::flag_set("flg_hideout_smoke_occluder_destroyed");
    wait 1;
  }
}

function function_56b4ff1dc2f4ee44() {
  foreach(weapon in level.player.offhandinventory) {
    if(weapon.basename == "smoke") {
      current_ammo = level.player getweaponammostock(weapon);

      if(current_ammo > 0) {
        return true;
      }
    }
  }

  return false;
}

function function_c8a660649befbe28() {
  level.player endon("death");
  utility::flag_wait("breach_start");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();

  if(isDefined(level.ai_hideout_sfo_interior_1) && isDefined(level.ai_hideout_sfo_interior_1[0]) && isDefined(level.ai_hideout_sfo_interior_1[1])) {
    level.var_89739451f741631b = level.ai_hideout_sfo_interior_1[0];
    level.var_89739551f741654e = level.ai_hideout_sfo_interior_1[1];
  } else {
    level.var_89739451f741631b = level.var_25932e13dae83dd3;
    level.var_89739551f741654e = level.var_25932e13dae83dd3;
  }

  var_9bf0013dc0e90979 = [[level.var_89739451f741631b, 0, "dx_sp_surg_hint_sfo1_breachin321", &function_72cf1844bf828de4], [level.var_89739451f741631b, 0.3, "dx_sp_surg_hint_sfo1_execute", &function_72cf1844bf828de4], [level.var_89739551f741654e, 0.3, "dx_sp_surg_hint_sfo2_pushingin", &function_72cf1844bf828de4], [level.var_89739451f741631b, 0.2, "dx_sp_surg_hint_sfo1_sweepingleft", &function_72cf1844bf828de4], [level.var_89739551f741654e, 0.2, "dx_sp_surg_hint_sfo2_sweepingright", &function_72cf1844bf828de4], [level.var_89739451f741631b, 0.2, "dx_sp_surg_hint_sfo1_clear_01", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_hideout_breach_vo_complete";
  level dialogue::say_sequence(var_9bf0013dc0e90979, 1, 0, 0, 0, "team");
  utility::flag_set("flg_hideout_breach_vo_complete");
  level thread function_8963466d70b6e6de();
}

function function_8963466d70b6e6de() {
  level.player endon("death");
  level endon("flg_hideout_breached");
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hint_soap_movingonyoucaptain"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hint_gazz_goodbreachcapletsmov"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hint_gazz_onyoucap"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flg_hideout_breached", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(12, 60, 4), 6);
}

function function_581e282f07f1c65c() {
  level.player endon("death");
  utility::flag_wait_all("flg_hideout_breached", "flg_hideout_breach_vo_complete");
  level notify("stop_surge_nags");
  wait 0.6;
  level.player thread function_2a5f16ea78f32af4("noncombat", 2);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hint_pric_laswellwerein", 1);
  level.player thread function_600f9ba1d61f24f0();
  var_9f804d0f6cc677f4 = [[level.var_318c75041f10c73f, &function_d77e33f32ea993a9, "dx_sp_surg_hint_lasw_copyfindthatbuyerand", &function_72cf1844bf828de4], [level.player, &function_d77e33f32ea993a9, "dx_sp_surg_hint_pric_team1pushdownstairsw", &function_72cf1844bf828de4], [level.var_89739451f741631b, 0.1, "dx_sp_surg_hint_sfo1_copy", &function_72cf1844bf828de4], [level.var_25932e13dae83dd3, &function_d77e33f32ea993a9, "dx_sp_surg_hint_sfo2_team2willholdpositio", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_hideout_cqc_hallway_advance_3";
  level dialogue::say_sequence(var_9f804d0f6cc677f4, 1, 0, 0, 0, "team");
  level thread function_d399632309c26504();
}

function function_d77e33f32ea993a9() {
  level.player endon("death");

  if(utility::flag("flg_hideout_intro_pause_vo")) {
    utility::flag_wait("hideout_intro_vo_encounter_done");
  }

  wait randomfloatrange(0.2, 0.4);
}

function function_d399632309c26504() {
  level.player endon("death");
  level endon("flg_hideout_cqc_hallway_advance_3");

  if(utility::flag("flg_hideout_cqc_hallway_advance_3")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hint_soap_letsmovedownstairsan"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hint_gazz_letspushdownstairsca"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hint_soap_letsgetdownstairs"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hint_gazz_downstairscaponyou"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hint_gazz_shouldheaddownsir"];
  nag_deck = utility::create_deck(nag_aliases);
  level dialogue::function_91c23782840cf632(["flg_hideout_intro_done", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(20, 60, 4), 15);
  level thread function_68baa74925bfc558("flg_hideout_cqc_hallway_advance_3");
}

function function_b52f72e5d94144f9() {
  level endon("flg_hideout_cqc_hallway_advance_3");
  utility::flag_wait("flg_hideout_cqc_enemy_stagger");
  wait 0.4;

  if(isalive(self)) {
    dialogue::say_delayed(0.5, "dx_sp_surg_hcqc_kon1_shit", 0, 1);
  }

  wait 1;

  if(isalive(self)) {
    utility::flag_set("flg_hideout_intro_enemies_warned");
    dialogue::say("dx_sp_surg_hcqc_kon1_contactenemiesareher", 0, 1);
  }

  wait 1;

  if(isDefined(self) && isalive(self)) {
    utility::flag_set("flg_hideout_stagger_disappeared");

    if(!utility::flag("flg_hideout_cqc_hallway_advance_1_skip")) {
      level.var_d18d63c6d75cd1e dialogue::say_self("dx_sp_surg_hcqc_gazz_captainwegotmoreenem_01", 2, 0.1);
      level.player dialogue::function_8c1bbaeb5d3fe61a(0.2, "dx_sp_surg_hint_pric_moveup", 2, 0.1);
    }

    wait 1;

    if(utility::flag("flg_hideout_heroes_stairwell_hall_mid_3")) {
      dialogue::function_cb329cf8896edeaa("allies", 1, 1);
    }

    utility::flag_set("hideout_intro_vo_encounter_done");
  }
}

function function_49f9c148989d36ca() {
  level.player endon("death");
  level endon("flg_hideout_stagger_disappeared");
  level endon("flg_hideout_cqc_hallway_advance_3");
  utility::flag_wait("flg_hideout_intro_stagger_enemy_visible");
  level notify("stop_surge_nags");
  level.player dialogue::function_8c1bbaeb5d3fe61a(0.2, "dx_sp_surg_hitl_pric_contact", 2, 0.1);
  utility::flag_wait("flg_hideout_intro_stagger_enemy_dead");
  level.player dialogue::function_8c1bbaeb5d3fe61a(1, "dx_sp_surg_chin_pric_clear", 2, 0.1);
  wait 1;
  utility::flag_set("hideout_intro_vo_encounter_done");
}

function function_9ec8ef33e033f9c8() {}

function function_2c10063300667426() {
  level thread function_f3ea2c2fa1eac9a0();
  level thread function_521ba906759013a();
  level thread function_b1bea1f94f8fa6();
  level thread function_397c1ca360652f1d();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_2a23c0086536dfb2() {
  var_cd0f1921801b6d45 = sortbydistance(getaiarray("allies"), level.player.origin);

  foreach(ally in var_cd0f1921801b6d45) {
    if(ally != level.player && ally != level.ai_soap && ally != level.var_d18d63c6d75cd1e) {
      return ally;
    }
  }

  return level.var_25932e13dae83dd3;
}

function function_f3ea2c2fa1eac9a0() {
  level.player endon("death");
  utility::flag_wait("flg_hideout_cqc_hallway_advance_3");
  utility::flag_wait_any("flg_hideout_cqc_mainhall_turret_visible", "flg_hideout_ab_turret_safety");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();
  var_1138130407ea4f77 = [[level.player, 0.6, "dx_sp_surg_hcqc_pric_contactsinthehallway", &function_72cf1844bf828de4], [level.player, 0.4, "dx_sp_surg_hcqc_pric_gazmovetoflank", &function_72cf1844bf828de4], [level.var_d18d63c6d75cd1e, 0.3, "dx_sp_surg_hcqc_gazz_rogmovingrightside", &function_72cf1844bf828de4], [level.ai_soap, 0.8, "dx_sp_surg_hcqc_soap_needtodisabletheturr", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = ["flg_hideout_bathroom_approach", "flg_hideout_servicehall_start"];
  level dialogue::say_sequence(var_1138130407ea4f77, 1, 0, 0, 0, "team");
  utility::flag_set("flg_hideout_clear_obj_start");
  level thread function_bbd337f65eadf9e();
  level thread function_caa7fd38c109546a();
  wait 1;
  level thread function_674adbcbf9e00855();
  level thread function_a6dbceb3425bba15(["flg_hideout_bathroom_start", "flg_hideout_servicehall_start"]);
}

function function_674adbcbf9e00855() {
  level.player endon("death");
  level endon("flg_hideout_bathroom_approach");
  level endon("flg_hideout_servicehall_start");
  level endon("flg_hideout_main_path_corridor01");
  level endon("flg_mainhall_turret_destroyed");
  var_5e531899936a10f9 = ["flg_hideout_bathroom_approach", "flg_hideout_servicehall_start", "flg_hideout_main_path_corridor01", "flg_mainhall_turret_destroyed"];

  foreach(flag_name in var_5e531899936a10f9) {
    if(utility::flag(flag_name)) {
      return;
    }
  }

  wait 18;
  level.var_d18d63c6d75cd1e dialogue::say_team("dx_sp_surg_hcqc_gazz_wecanflankthroughthe", 0, 2.5);
}

function function_21e9945eedbb7027(var_53596e0c4a3b96aa) {
  level.player endon("death");
  level endon("flg_hideout_bathroom_enter");
  level endon("flg_hideout_servicehall_start");
  level endon("flg_hideout_shop_endpath");
  wait 1.5;

  if(!utility::flag("flg_hideout_intro_enemies_warned")) {
    if(isDefined(var_53596e0c4a3b96aa) && isDefined(var_53596e0c4a3b96aa[0]) && isalive(var_53596e0c4a3b96aa[0])) {
      var_53596e0c4a3b96aa[0] dialogue::say("dx_sp_surg_hcqc_kon1_contactenemiesareher");
    }
  }

  wait 1.5;

  if(isDefined(var_53596e0c4a3b96aa) && isDefined(var_53596e0c4a3b96aa[1]) && isalive(var_53596e0c4a3b96aa[1])) {
    var_53596e0c4a3b96aa[1] dialogue::say("dx_sp_surg_hcqc_kon2_theyrecomingdefensiv");
  }
}

function function_521ba906759013a() {
  level.player endon("death");
  level endon("flg_hideout_servicehall_start");
  level endon("flg_hideout_shop_endpath");
  utility::flag_wait("flg_hideout_bathroom_approach");
  level.player thread dialogue::say_team("dx_sp_surg_hcqc_pric_onmegazlavatoryside", 2);
  level.var_d18d63c6d75cd1e thread dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_surg_hcqc_gazz_rogerthat", 2);
  utility::flag_wait("flg_hideout_bathroom_start");
  level thread function_478aee5c4b9c65a();
  level thread function_87030258af22d221();
  level thread function_cbb20f2499d43199();
}

function function_478aee5c4b9c65a() {
  level.player endon("death");

  while(!isDefined(level.var_2a2df0e9a2dbc5ae)) {
    waitframe();
  }

  var_155dc8d26a79f3a1 = [level.var_2a2df0e9a2dbc5ae, level.var_62ca7774886832a3, level.var_cc456419f1b1cb67];
  var_155dc8d26a79f3a1 = utility::array_removedead_or_dying(var_155dc8d26a79f3a1);

  if(var_155dc8d26a79f3a1.size == 0) {
    return;
  }

  utility::array_thread(var_155dc8d26a79f3a1, &function_aa8c9f3e29f975f0);
  ai_speaker = utility::getclosest(level.player.origin, var_155dc8d26a79f3a1);
  ai_speaker endon("death");
  ai_speaker endon("entitydeleted");
  ai_speaker dialogue::say("dx_sp_surg_hcqc_kon1_theyaregettingcloser", 0, 2.5);

  if(utility::flag("flg_hideout_bathroom_flash_grenade")) {
    wait 0.7;
    ai_speaker dialogue::say("dx_sp_surg_hcqc_kon1_providingcoverforyou");
    return;
  }

  if(utility::flag("flg_hideout_bathroom_enemies_shooting")) {
    wait 1;
    ai_speaker dialogue::say("dx_sp_surg_hcqc_kon1_openingheavyfire", 0, 2.5);
    return;
  }

  wait 0.2;
  ai_speaker dialogue::say("dx_sp_surg_hcqc_kon1_weneedheavyweapons", 0, 2.5);
}

function function_aa8c9f3e29f975f0() {
  level endon("flg_hideout_bathroom_enemies_shooting");
  self endon("death");
  self waittill("weapon_fired");
  utility::flag_set("flg_hideout_bathroom_enemies_shooting");
}

function function_cbb20f2499d43199() {
  level.player endon("death");
  level endon("flg_hideout_servicehall_start");
  level endon("flag_hideout_bathroom_clear");
  level endon("flg_hideout_shop_endpath");

  while(!isDefined(level.var_cc456419f1b1cb67)) {
    waitframe();
  }

  level.var_cc456419f1b1cb67 endon("death");
  level.var_cc456419f1b1cb67 endon("entitydeleted");
  utility::flag_wait("flag_hideout_bathroom_kills");
  wait 1;

  if(isalive(level.var_cc456419f1b1cb67)) {
    level.var_cc456419f1b1cb67 dialogue::say("dx_sp_surg_hcqc_kon3_theyreinhere", 0, 2.5);
  }
}

function function_87030258af22d221() {
  level.player endon("death");
  level endon("flg_hideout_shop_endpath");
  utility::flag_wait("flag_hideout_bathroom_clear");
  level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_hcqc_pric_clearmovingup", 1);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hcqc_soap_copythat", 1);
  level thread function_a6dbceb3425bba15("flg_hideout_bathrooms_exit");
  utility::flag_wait("flg_hideout_bathrooms_exit");
  level.player say_team("dx_sp_surg_hcqc_pric_pushinginrightsidewa", 1);
  utility::flag_wait("flg_mainhall_turret_dead");

  foreach(enemy in level.var_a1e59aafd4d3ebb5) {
    thread function_678ee05eb44c1fb9(enemy, "flg_hideout_shops_enemies_visible", "flg_hideout_shop_endpath");
  }

  utility::flag_wait_or_timeout("flg_hideout_shops_enemies_visible", 8);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(2.5, "dx_sp_surg_hcqc_soap_konnishootersinthesh");
  level thread function_68baa74925bfc558("flg_hideout_shop_enemies_noticed_player");
}

function function_b1bea1f94f8fa6() {
  level.player endon("death");
  level endon("flg_hideout_bathroom_start");
  level endon("flg_hideout_shop_endpath");
  utility::flag_wait("flg_hideout_servicehall_start");
  level.player dialogue::say_team("dx_sp_surg_hcqc_pric_gaztakerightigotleft", 1);
  level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_hcqc_gazz_rogmovingtothelavato", 1);
  level thread function_a6dbceb3425bba15("flg_hideout_servicehall_end");
  utility::flag_wait("flg_hideout_servicehall_end");
  level.player dialogue::say_team("dx_sp_surg_hcqc_pric_servicecorridorclear", 1);
  level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_hcqc_gazz_loosclearmovingup", 1);
  level thread function_68baa74925bfc558("flg_hideout_shop_1_enter");
  utility::flag_wait("flg_hideout_shop_1_enter");
  level.player dialogue::say_team("dx_sp_surg_hcqc_pric_pushinginwatchyourfi");
}

function function_caa7fd38c109546a() {
  level.player endon("death");
  level endon("flg_hideout_bathroom_start");
  level endon("flg_hideout_servicehall_start");
  level endon("flg_hideout_shop_endpath");

  while(!isDefined(level.mainhall_turret)) {
    waitframe();
  }

  if(utility::flag("flg_hideout_bathroom_start") || utility::flag("flg_hideout_servicehall_start") || utility::flag("flg_hideout_shop_endpath")) {
    return;
  }

  while(true) {
    level.mainhall_turret waittill("damage", amount, attacker, direction, point, means_of_death);

    if(attacker == level.player) {
      if(means_of_death == "MOD_PISTOL_BULLET" || means_of_death == "MOD_RIFLE_BULLET") {
        break;
      }
    }

    waitframe();
  }

  level.player dialogue::say_team("dx_sp_surg_hcqc_pric_concentratefireonthe", 1);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hcqc_soap_rog", 1);
  utility::flag_wait_all("flg_hideout_shops_enemies_spawned", "flg_hideout_main_path_corridor01", "flg_mainhall_turret_dead");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_surg_hcqc_soap_konnishootersinthesh", 1);
  level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_surg_hcqc_gazz_loosclearmovingup", 1);
  level thread function_68baa74925bfc558("flg_hideout_shop_enemies_noticed_player");
}

function function_a6dbceb3425bba15(endon_flag) {
  level.player endon("death");
  level endon("flg_mainhall_turret_destroyed");
  level endon("flg_mainhall_turret_hacked");

  if(utility::flag("flg_mainhall_turret_destroyed") || utility::flag("flg_mainhall_turret_hacked")) {
    return;
  }

  if(isarray(endon_flag)) {
    foreach(flag in endon_flag) {
      level endon(flag);
    }

    var_5e531899936a10f9 = utility::array_add(endon_flag, "flg_mainhall_turret_destroyed");
    var_5e531899936a10f9 = utility::array_add(endon_flag, "flg_mainhall_turret_hacked");
  } else {
    level endon(endon_flag);
    var_5e531899936a10f9 = [endon_flag, "flg_mainhall_turret_destroyed", "flg_mainhall_turret_hacked"];
  }

  if(!isDefined(level.var_49579e4b31862e6d)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_needtodisablethattur"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_cantmoveuntiltheturr"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_turretsblockingourad"];
    level.var_49579e4b31862e6d = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, level.var_49579e4b31862e6d, dialogue::growing_delay(30, 60, 3), 15, 1);
}

function function_bbd337f65eadf9e() {
  level.player endon("death");
  level endon("flg_hideout_shop_endpath");
  msg = utility::flag_wait_any_return("flg_mainhall_turret_hacked", "flg_mainhall_turret_destroyed");

  if(msg == "flg_mainhall_turret_hacked") {
    level.player dialogue::function_fc0eb6b81c66c661(1.5, "dx_sp_surg_hcqc_pric_turretdisabled", 1, 5);
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hcqc_soap_nicejobcaptainweremo", 0, 5);
  } else {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_hcqc_soap_turretdownedmovingup", 1, 5);
  }

  utility::flag_set("flg_mainhall_turret_disabled");
}

function function_397c1ca360652f1d() {
  level.player endon("death");
  level endon("flg_shop_and_escalator_enemies_dead");
  level endon("flg_hideout_finale_start");
  utility::flag_wait("flg_hideout_shop_endpath");

  while(!isDefined(level.var_e936e3c84ef59410)) {
    waitframe();
  }

  level thread function_3ab5fafc20b1c37d();
  level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_hcqc_gazz_morekonnidescendingt", 1, 5);
  wait 1.2;

  if(isDefined(level.var_e936e3c84ef59410[0]) && isalive(level.var_e936e3c84ef59410[0])) {
    level.var_e936e3c84ef59410[0] dialogue::say("dx_sp_surg_hcqc_kon1_fallback", 0, 2.5);
  }
}

function function_3ab5fafc20b1c37d() {
  level.player endon("death");
  utility::flag_wait_or_timeout("flg_hideout_shops_enemies_dead", 10);
  msg = utility::flag_wait_any_return("flg_escalator_enemies_some_dead", "flg_shop_and_escalator_enemies_dead", "flg_hideout_escalator_enemies_retreating", "flg_hideout_finale_start");

  if(msg == "flg_shop_and_escalator_enemies_dead") {
    var_89739451f741631b = function_2a23c0086536dfb2();
    var_89739451f741631b dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_hint_sfo1_enemydown", 1);
  }

  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_hcqc_soap_gotmorekonniinthenex", 1);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_hcqc_soap_letspushforwardkillt", 1);
  level thread function_b1247e1992d8a0fb("flg_hideout_finale_start");
}

function function_68baa74925bfc558(endon_flag) {
  level.player endon("death");
  level endon("flg_shop_and_escalator_enemies_dead");
  level endon("flg_hideout_finale_start");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_ba7ca7dd47be0414)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_letspushupandclearth"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_weneedtoclearthisflo"];
    nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_captainwegotmoreenem"];
    level.var_ba7ca7dd47be0414 = utility::create_deck(nag_aliases, 1, 1);
  }

  var_5e531899936a10f9 = ["flg_hideout_finale_start", "flg_shop_and_escalator_enemies_dead", endon_flag, "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, level.var_ba7ca7dd47be0414, dialogue::growing_delay(20, 60, 4), 15);
}

function function_b1247e1992d8a0fb(endon_flag) {
  level.player endon("death");
  level endon("flg_hideout_finale_start");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_gotthemontherunneedt"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_needtomoveupcap"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_whoandwhatwerelookin"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_theyrepushingembackl"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_konnistakingdefensiv"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_letskeeppushingwithh"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  var_5e531899936a10f9 = ["flg_hideout_finale_start", endon_flag, "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(20, 45, 5), 15);
}

function function_2735b9cd7fe18bc8() {
  wait 4;
  setmusicstate("mx_surge_hideoutfight");
}

function function_8b078e35dea40f95() {}

function function_4453ef063b49158() {
  level thread function_3ceb656a657bafc0();
  level thread function_40352b8c0ef81990();
  level thread function_2538c4f7d61069d6();
  level thread function_14da6651117a3a57();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_3ceb656a657bafc0() {
  level.player endon("death");
  level endon("flg_hideout_finale_rpg_early_death");
  level endon("flg_hideout_final_room_clear");
  utility::flag_wait("flg_hideout_finale_rpg_fired");
  level notify("stop_surge_nags");
  thread function_2735b9cd7fe18bc8();
  level.ai_soap dialogue::say_team("dx_sp_surg_hcqc_soap_rpg", 1);
  utility::flag_wait("flg_hideout_finale_rpg_exploded");
  level thread function_7cef749c913bd764();
  utility::flag_wait("hideout_finale_rpg_enemy_dead");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(1.6, "dx_sp_surg_hcqc_soap_rpgdown", 1, 5);
}

function function_7cef749c913bd764() {
  level.player endon("death");
  level endon("flg_hideout_finale_rpg_early_death");
  level endon("hideout_finale_rpg_enemy_dead");

  if(utility::flag("flg_hideout_finale_rpg_early_death") || utility::flag("hideout_finale_rpg_enemy_dead")) {
    return;
  }

  wait 5;
  level.ai_soap dialogue::say_team("dx_sp_surg_hcqc_soap_rpgonthesecondfloorl");
  wait 8;
  level.var_d18d63c6d75cd1e dialogue::say_team("dx_sp_surg_hcqc_gazz_rpgreloadingtakehimo");
  utility::flag_set("flg_hideout_finale_rpg_nags_complete");
}

function function_14da6651117a3a57() {
  level.player endon("death");
  level endon("flg_hideout_finale_turret_hacked");
  level endon("flg_hideout_finale_turret_destroyed");
  level endon("flg_hideout_final_room_clear");
  var_5e531899936a10f9 = ["flg_hideout_finale_turret_hacked", "flg_hideout_finale_turret_destroyed", "flg_hideout_final_room_clear"];

  foreach(flag_msg in var_5e531899936a10f9) {
    if(utility::flag_exist(flag_msg) && utility::flag(flag_msg)) {
      return;
    }
  }

  msg = utility::flag_wait_any_return("flg_hideout_finale_rpg_event", "flg_hideout_finale_force_turret_vo");

  if(msg == "flg_hideout_finale_rpg_event") {
    utility::flag_wait_any("flg_hideout_finale_rpg_early_death", "hideout_finale_rpg_enemy_dead", "flg_hideout_finale_rpg_nags_complete");
  }

  level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(3, "dx_sp_surg_hcqc_gazz_anotherenemyturretba", 1);
  level thread function_b94eece7dbc43470();
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_turretspinninguscapt"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_turretsholdingusback"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_needtodisablethattur"];
  nag_deck = utility::create_deck(nag_aliases);
  var_5e531899936a10f9 = ["flg_hideout_finale_turret_destroyed", "flg_hideout_finale_turret_hacked", "flg_hideout_final_room_clear"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(30, 60, 2), 20, 1);
}

function function_2538c4f7d61069d6() {
  level.player endon("death");
  level endon("flg_hideout_final_room_clear");
  var_d8133d6c703e9742 = utility::flag_wait_any_return("flg_hideout_finale_player_on_left", "flg_hideout_finale_player_in_center", "flg_hideout_finale_player_on_right");

  switch (var_d8133d6c703e9742) {
    case #"hash_bc5e0e287ad34db9":
      level.player dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_surg_hcqc_pric_takingleft", 0, 0.5);
      break;
    case #"hash_1cb768c87143c91a":
      level.player dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_surg_hcqc_pric_takingright", 0, 0.5);
      break;
    case #"hash_5c1466dc2ef3097f":
      level.player dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_surg_hcqc_pric_pushingdowncenter", 0, 0.5);
      break;
  }

  utility::flag_wait("flg_hideout_finale_spawn_stairway_guy");
  level.player dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_surg_hcqc_pric_movingupstairs", 0, 2);
}

function function_b94eece7dbc43470() {
  level.player endon("death");
  level endon("flg_hideout_finale_player_on_left");
  level endon("flg_hideout_finale_player_in_center");
  level endon("flg_hideout_finale_player_on_right");
  level endon("flg_hideout_finale_turret_hacked");
  level endon("flg_hideout_finale_turret_destroyed");
  level endon("flg_hideout_final_room_clear");

  if(utility::flag("flg_hideout_finale_turret_hacked") || utility::flag("flg_hideout_finale_turret_destroyed") || utility::flag("flg_hideout_final_room_clear")) {
    return;
  }

  if(utility::flag("flg_hideout_finale_player_on_left") || utility::flag("flg_hideout_finale_player_in_center") || utility::flag("flg_hideout_finale_player_on_right")) {
    return;
  }

  level thread function_5ee122c505d2f3d9();
  aliases = [];
  aliases[aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_goodscreenpushup"];
  aliases[aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_usethesmokeletsgo"];
  aliases[aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_smokellhideusletsmov"];
  aliases[aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_smokesoutgo"];
  var_3ba00da147758d22 = utility::create_deck(aliases, 1, 1);
  utility::flag_wait_all("flg_hideout_smoke_grenade_thrown", "flg_hideout_smoke_occluder_close_to_allies");
  level dialogue::function_91c23782840cf632(["flg_hideout_smoke_occluder_destroyed", "flg_hideout_final_room_clear"], var_3ba00da147758d22, 10, 1.5);
}

function function_5ee122c505d2f3d9() {
  level.player endon("death");
  level endon("flg_hideout_smoke_grenade_thrown");
  level endon("flg_hideout_finale_player_on_left");
  level endon("flg_hideout_finale_player_in_center");
  level endon("flg_hideout_finale_player_on_right");
  level endon("flg_hideout_finale_turret_hacked");
  level endon("flg_hideout_finale_turret_destroyed");
  level endon("flg_hideout_final_room_clear");

  if(utility::flag("flg_hideout_finale_turret_hacked") || utility::flag("flg_hideout_finale_turret_destroyed") || utility::flag("flg_hideout_final_room_clear")) {
    return;
  }

  if(utility::flag("flg_hideout_finale_player_on_left") || utility::flag("flg_hideout_finale_player_in_center") || utility::flag("flg_hideout_finale_player_on_right")) {
    return;
  }

  wait 8;

  if(istrue(function_56b4ff1dc2f4ee44())) {
    level.var_d18d63c6d75cd1e dialogue::say_team("dx_sp_surg_hcqc_gazz_capifyougotsmokepopi", 0, 5);
  }
}

function function_40352b8c0ef81990() {
  level.player endon("death");
  level endon("flg_hideout_final_room_enemies_clear");
  level endon("flg_hideout_final_room_clear");
  msg = utility::flag_wait_any_return("flg_hideout_finale_turret_hacked", "flg_hideout_finale_turret_destroyed");

  if(msg == "flg_hideout_finale_turret_hacked" && !utility::flag("flg_hideout_final_room_clear")) {
    level.player dialogue::function_fc0eb6b81c66c661(1.5, "dx_sp_surg_hcqc_pric_turretdownfocusfireo", 1, 5);
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_hcqc_soap_rog", 0, 1);
  } else {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_hcqc_soap_turretsdown", 1, 5);

    if(!utility::flag("flg_hideout_final_room_clear")) {
      level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hcqc_pric_focusfireupstairs", 1, 5);
      level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_hcqc_soap_rog", 0, 1);
    }
  }

  wait 1;
  level thread function_4b802549c00b63ce();
}

function function_4b802549c00b63ce() {
  level.player endon("death");
  level endon("flg_hideout_finale_spawn_stairway_guy");
  level endon("flg_hideout_final_room_enemies_clear");
  level endon("flg_hideout_final_room_clear");

  if(utility::flag("flg_hideout_finale_spawn_stairway_guy") || utility::flag("flg_hideout_final_room_enemies_clear") || utility::flag("flg_hideout_final_room_clear")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_konnisretreatedupsta"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hcqc_gazz_hostilesduginontheup"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_enemyholdingposition"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_letsgetupthereandgiv"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  var_5e531899936a10f9 = ["flg_hideout_final_room_enemies_clear", "flg_hideout_final_room_clear", "flg_hideout_finale_spawn_stairway_guy", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(20, 50, 3), 15, 1);
}

function function_105a342681603685() {}

function function_1aad1fb69976739d() {
  level thread function_64fe0e9040981f74();
  level thread function_132b129638f91b8c();
  level thread function_99906247fd78cc39();
  level thread function_e8bc7a9dc82ec93d();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_64fe0e9040981f74() {
  level.player endon("death");
  level endon("flg_hideout_final_guy_aware");
  level endon("flag_hideout_office_enemies_visible");
  level endon("flg_hideout_office_enemies_dead");
  level endon("flg_hideout_intel_enter");
  utility::flag_wait("flg_hideout_final_room_clear");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();
  t_hideout_finale_upstairs = getEnt("t_hideout_finale_upstairs", "targetname");

  if(level.player istouching(t_hideout_finale_upstairs)) {
    utility::flag_set("flg_hideout_finale_player_upstairs");
  } else {
    level thread function_6c8e67f514edf137();
  }

  if(utility::flag("flg_hideout_finale_player_upstairs")) {
    var_89739451f741631b = function_2a23c0086536dfb2();
    var_89739451f741631b dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_hint_sfo2_areasclear");
    level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hitl_gazz_needtosweepandcleart");
  } else {
    var_df60a24ae294c61e = [[level.var_d18d63c6d75cd1e, 1.5, "dx_sp_surg_hitl_gazz_weclear"], [level.player, 0.6, "dx_sp_surg_hitl_pric_allclear"], [level.var_d18d63c6d75cd1e, 0.4, "dx_sp_surg_hitl_gazz_mustvebeenguardingso", &function_72cf1844bf828de4], [level.player, 0.3, "dx_sp_surg_hitl_pric_weneedtofinditsfoloc", &function_72cf1844bf828de4], [level.ai_soap, 0.2, "dx_sp_surg_hitl_soap_copyonyoucaptain", &function_72cf1844bf828de4]];
    level.var_6ef05c49e46d8d70 = ["flg_hideout_finale_player_upstairs", "flag_hideout_office_enemies_visible", "flg_hideout_office_enemies_dead"];
    level dialogue::say_sequence(var_df60a24ae294c61e, 1, 0, 0, 0, "team");
  }

  wait 1;
  level thread function_ef2d567acc982005();
}

function function_6c8e67f514edf137() {
  level.player endon("death");
  level endon("flg_hideout_final_guy_aware");
  level endon("flag_hideout_office_enemies_visible");
  level endon("flg_hideout_office_enemies_dead");
  level endon("flg_hideout_intel_enter");
  t_hideout_finale_upstairs = getEnt("t_hideout_finale_upstairs", "targetname");

  while(true) {
    if(level.player istouching(t_hideout_finale_upstairs)) {
      utility::flag_set("flg_hideout_finale_player_upstairs");
      break;
    }

    wait 1;
  }
}

function function_ef2d567acc982005() {
  level.player endon("death");
  level endon("flg_hideout_final_guy_aware");
  level endon("flag_hideout_office_enemies_visible");
  level endon("flg_hideout_office_enemies_dead");

  if(utility::flag("flg_hideout_final_guy_aware") || utility::flag("flag_hideout_office_enemies_visible") || utility::flag("flg_hideout_office_enemies_dead")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hitl_soap_captainsecondfloorof"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hitl_gazz_leadusinsix"];
  nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hitl_gazz_needtosweepandcleart"];
  nag_deck = utility::create_deck(nag_aliases);
  level dialogue::function_91c23782840cf632(["flg_hideout_final_guy_aware", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(20, 60, 4), 15);
}

function function_132b129638f91b8c() {
  level.player endon("death");
  level endon("flg_hideout_office_enemies_dead");
  utility::flag_wait_all("flg_spawn_final_hideout_guy", "flg_hideout_intel_enemies_spawned");

  if(isDefined(level.var_18907a70deb3ae0f) && isDefined(level.var_18907a70deb3ae0f[0]) && isalive(level.var_18907a70deb3ae0f[0])) {
    level.var_18907a70deb3ae0f[0] dialogue::say("dx_sp_surg_hcqc_kon1_theyaregettingcloser", 0, 1);
  }

  wait 0.5;

  if(isDefined(level.var_60635958d622535c) && isalive(level.var_60635958d622535c)) {
    level.var_60635958d622535c dialogue::say("dx_sp_surg_hcqc_kon1_donotletthemadvance");
  }
}

function function_99906247fd78cc39() {
  level.player endon("death");
  level endon("flg_hideout_office_enemies_dead");
  utility::flag_wait_all("flg_spawn_final_hideout_guy", "flag_hideout_office_enemies_visible");
  level notify("stop_surge_nags");
  level.player dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_surg_hitl_pric_contact", 1);
}

function function_e8bc7a9dc82ec93d() {
  level.player endon("death");
  level endon("hideout_interact_evidence_complete");
  utility::flag_wait("flg_hideout_office_enemies_dead");
  wait 1.2;

  if(utility::flag("flg_hideout_finale_player_saw_buyer_die")) {
    level.player dialogue::say_team("dx_sp_surg_hitl_pric_clear", 1);
    wait 1;
    level.player thread function_2a5f16ea78f32af4("noncombat", 2.5);
    level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hitl_pric_watcherkonnibuyerisd", 1);
    level.player thread function_600f9ba1d61f24f0();
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hitl_lasw_findthatflashdrive", 1);
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hitl_soap_theresgottabeintelon", 1);
    level thread function_7acf324799a7a97e("hideout_interact_evidence_start");
    return;
  }

  level.ai_soap dialogue::say_team("dx_sp_surg_chin_soap_clear", 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hitl_pric_rogspreadoutfindthat", 1);
  utility::flag_set("flg_hideout_office_intro_vo_complete");
  level thread function_7acf324799a7a97e("flg_hideout_finale_player_sees_buyer_corpse");
  wait 1;
  level thread function_c06a37cdc81eff44();
}

function function_c06a37cdc81eff44() {
  level.player endon("death");
  level endon("hideout_interact_evidence_complete");
  utility::flag_wait("flg_hideout_finale_player_sees_buyer_corpse");
  level.player thread function_2a5f16ea78f32af4("noncombat", 2.5);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_hitl_pric_watcherkonnibuyerisd", 1);
  level.player thread function_600f9ba1d61f24f0();
  level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_surg_hitl_lasw_findthatflashdrive", 1);
  level thread function_7acf324799a7a97e("hideout_interact_evidence_start");
}

function function_7acf324799a7a97e(endon_flag) {
  level.player endon("death");
  level endon("hideout_interact_evidence_start");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_83a9d83d684e41b7)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hitl_gazz_needtofindthatflashd"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_hitl_soap_needtofindthatflashd"];
    nag_aliases[nag_aliases.size] = [level.var_d18d63c6d75cd1e, "dx_sp_surg_hitl_gazz_flashdrivesgottabear"];
    level.var_83a9d83d684e41b7 = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632([endon_flag, "hideout_interact_evidence_start"], level.var_83a9d83d684e41b7, dialogue::growing_delay(15, 30, 3), 10);
}

function function_3ebaf8e7b69ad268() {}

function function_91b576b5eeb70436() {
  level thread function_ea2020041a382c26();
  level thread function_1f94726f5f75d4ec();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_d1061513a0f95e85() {
  var_cd0f1921801b6d45 = sortbydistance(getaiarray("allies"), level.player.origin);

  foreach(ally in var_cd0f1921801b6d45) {
    if(ally != level.player && ally != level.ai_soap) {
      return ally;
    }
  }

  return level.var_25932e13dae83dd3;
}

function function_ea2020041a382c26() {
  level.player endon("death");
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  level.var_89739751f74169b4 dialogue::say_team("dx_sp_surg_chin_sfo4_sfoteaminposition", 1);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_chin_soap_onyousir", 1);
  level thread function_12b61c4d56e108e5();
  level thread function_94483c4a3675a8f1();
}

function function_12b61c4d56e108e5() {
  level.player endon("death");
  level endon("flg_chunnel_intro_train_1_driveby_vo");

  if(utility::flag("flg_chunnel_intro_train_1_driveby_vo")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_letsmoveincaptain"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_readytomovesir"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_needtogetgoing"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flg_chunnel_intro_train_1_driveby_vo", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(20, 60, 4), 15);
}

function function_94483c4a3675a8f1(endon_flag) {
  level.player endon("death");
  level endon("flg_chunnel_intro_train_1_driveby");

  if(utility::flag("flg_chunnel_intro_train_1_driveby")) {
    return;
  }

  var_3fb84a9d7a0ae41f = [];
  var_854bab21bedcce82 = [];
  var_3fb84a9d7a0ae41f[var_3fb84a9d7a0ae41f.size] = "dx_sp_surg_chin_ghos_weregoodherepricerig";
  var_3fb84a9d7a0ae41f[var_3fb84a9d7a0ae41f.size] = "dx_sp_surg_chin_ghos_youretakingtherightt";
  var_3fb84a9d7a0ae41f[var_3fb84a9d7a0ae41f.size] = "dx_sp_surg_chin_ghos_gotlefttunnelcovered";
  var_3fb84a9d7a0ae41f[var_3fb84a9d7a0ae41f.size] = "dx_sp_surg_chin_ghos_soapswaitinonyoupric";
  var_854bab21bedcce82[var_854bab21bedcce82.size] = "dx_sp_surg_chin_gazz_weresetherecap";
  var_854bab21bedcce82[var_854bab21bedcce82.size] = "dx_sp_surg_chin_gazz_goodheresirsoapshold";
  var_854bab21bedcce82[var_854bab21bedcce82.size] = "dx_sp_surg_chin_gazz_wegotleftsidesiryour";
  var_854bab21bedcce82[var_854bab21bedcce82.size] = "dx_sp_surg_chin_gazz_regroupwithsoapandle";
  var_854bab21bedcce82[var_854bab21bedcce82.size] = "dx_sp_surg_chin_gazz_youreontherightsidet";
  var_14456d29d9ebf448 = utility::create_deck(var_3fb84a9d7a0ae41f, 1, 1);
  var_3783a1c3e2dcc51f = utility::create_deck(var_854bab21bedcce82, 1, 1);

  while(true) {
    var_939de0bf747d324b = distance(level.player.origin, level.ai_ghost.origin);
    var_c2de5d21b890b1be = distance(level.player.origin, level.var_d18d63c6d75cd1e.origin);

    if(var_939de0bf747d324b <= 60 || var_c2de5d21b890b1be <= 60) {
      if(utility::cointoss()) {
        var_c922bb28af697112 = var_14456d29d9ebf448 utility::deck_draw();
        level.ai_ghost dialogue::say_team(var_c922bb28af697112, 0, 2);
      } else {
        var_e4ce68054bed512d = var_3783a1c3e2dcc51f utility::deck_draw();
        level.var_d18d63c6d75cd1e dialogue::say_team(var_e4ce68054bed512d, 0, 2);
      }

      wait randomfloatrange(8, 12);
    }

    wait 1;
  }
}

function function_1f94726f5f75d4ec() {
  level.player endon("death");
  utility::flag_wait("flg_chunnel_intro_train_1_driveby");
  level notify("stop_surge_nags");
  utility::flag_wait("train_01_near_player");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_chin_soap_steaminjesus", 1);
  utility::flag_wait("flg_chunnel_intro_track_train_single_passed");
  thread function_3a06dcf411a387e8();
  level.player thread function_2a5f16ea78f32af4("noncombat", 3.5);
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_chin_pric_watcherifmakarovscon", 1);
  level.player thread function_600f9ba1d61f24f0();
  level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_chin_lasw_attemptingtobreachth", 1);

  if(utility::flag("flg_chunnel_intro_track_vo_start")) {
    return;
  }

  level endon("flg_chunnel_intro_track_vo_start");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_chin_soap_goodathelpingamadbas", 1);
  level thread function_62a5526bb2c01ed0();
  level thread function_29c5ee5a109ac636("flg_chunnel_intro_track_start");
  level.var_351f8aca05656919 dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_surg_chin_gazz_onthemovecapgoodhunt", 0, 2);
}

function function_3a06dcf411a387e8() {
  wait 2;
  setmusicstate("mx_surge_chunnel");
}

function function_62a5526bb2c01ed0() {
  level endon("flg_chunnel_intro_track_start");

  if(utility::flag("flg_chunnel_intro_track_start")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = "dx_sp_surg_chin_soap_thiswaycaptain";
  nag_aliases[nag_aliases.size] = "dx_sp_surg_chin_soap_crossoversthisway";
  nag_aliases[nag_aliases.size] = "dx_sp_surg_chin_soap_needtofollowthetrack";
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  var_af36b904b56328b7 = getEntArray("out_of_bounds", "targetname");
  var_19489352206d3d26 = getclosest(level.player.origin, var_af36b904b56328b7);
  utility::flag_clear("flg_chunnel_intro_train_1_driveby_vo");

  while(true) {
    if(level.player istouching(var_19489352206d3d26) || utility::flag("flg_chunnel_intro_train_1_driveby_vo")) {
      if(utility::flag("flg_chunnel_intro_train_1_driveby_vo_nags_off")) {
        wait 1;
        continue;
      }

      if(utility::flag("flg_chunnel_intro_train_1_driveby_vo")) {
        level thread function_63e96ea3ddc44e27();
      }

      react_vo = nag_deck utility::deck_draw();
      level.ai_soap dialogue::say_team(react_vo, 0, 2.5);
      wait randomfloatrange(8, 12);
    }

    wait 1;
  }
}

function function_63e96ea3ddc44e27() {
  level endon("flg_chunnel_intro_track_start");
  utility::flag_set("flg_chunnel_intro_train_1_driveby_vo_nags_off");
  utility::flag_clear("flg_chunnel_intro_train_1_driveby");
  utility::flag_wait("flg_chunnel_intro_train_1_driveby");
  utility::flag_clear("flg_chunnel_intro_train_1_driveby_vo_nags_off");
  utility::flag_clear("flg_chunnel_intro_train_1_driveby_vo");
}

function function_b3b19a6662bb1c61(endon_flag) {
  level.player endon("death");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_9f69927475bffc29)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_surg_chin_pric_bloodytrain";
    aliases[aliases.size] = "dx_sp_surg_chin_pric_almosthitme";
    aliases[aliases.size] = "dx_sp_surg_chin_pric_thatwasacloseone";
    level.var_9f69927475bffc29 = utility::create_deck(aliases, 1, 1);
  }

  utility::flag_clear("flg_chunnel_player_almost_hit_by_train");

  while(!utility::flag(endon_flag)) {
    utility::flag_wait("flg_chunnel_player_almost_hit_by_train");
    react_vo = level.var_9f69927475bffc29 deck_draw();
    level.player dialogue::say_team(react_vo, 0, 1);
    utility::flag_waitopen("flg_chunnel_player_almost_hit_by_train");
    wait 5;
  }
}

function function_9ebbf6fd0482c86f(endon_flag) {
  level.player endon("death");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_3488e6107105cb6f)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_surg_chin_pric_cantwalkthatoneoff";
    aliases[aliases.size] = "dx_sp_surg_chin_pric_bloodyhell";
    level.var_3488e6107105cb6f = utility::create_deck(aliases);
  }

  utility::flag_clear("flg_chunnel_player_sees_enemy_die_on_tracks");

  while(true) {
    utility::flag_wait("flg_chunnel_player_sees_enemy_die_on_tracks");
    react_vo = level.var_3488e6107105cb6f deck_draw();
    level.player dialogue::say_team(react_vo, 0, 1);
    utility::flag_waitopen("flg_chunnel_player_sees_enemy_die_on_tracks");
    wait 0.5;
  }
}

function function_63b8ac33d5c8e755() {}

function function_8c51d81cc059da92() {
  level thread function_abf966652d450326();
  level thread function_91b944b3dd33df9();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_29c5ee5a109ac636(endon_flag) {
  level.player endon("death");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_9bb659f120a443f2)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_makarovwontbeatthecr"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_letshooftothecrossov"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_sirweneedtokeepmovin"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_weneedtopushtomakaro"];
    nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_crossoverisupaheadca"];
    level.var_9bb659f120a443f2 = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632([endon_flag, "flag_surge_stop_nags"], level.var_9bb659f120a443f2, dialogue::growing_delay(20, 60, 4), 15);
}

function function_abf966652d450326() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_alerted");

  if(utility::flag("flg_chunnel_intro_track_alerted")) {
    return;
  }

  utility::flag_wait("flg_chunnel_intro_track_start");
  level notify("stop_surge_nags");
  utility::flag_set("flg_chunnel_intro_track_vo_start");
  wait 3;
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  function_4256d29a648763ba();
  var_33718ad7ea90961f = [[level.var_25932e13dae83dd3, 0.2, "dx_sp_surg_chin_sfo4_konnispottedahead", &function_72cf1844bf828de4], [level.ai_soap, 0.6, "dx_sp_surg_chin_soap_theydontseeus", &function_72cf1844bf828de4], [level.player, 0.3, "dx_sp_surg_chin_pric_letskeepitthatwayyea", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_chunnel_intro_track_alerted";
  level dialogue::say_sequence(var_33718ad7ea90961f, 1, 0, 0, 0, "team");
  level thread function_bb2981a6e09bef73();
  level thread function_503fde9e398bbbdd();
  level thread function_d682edc598c0e4f9();
}

function function_503fde9e398bbbdd() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_alerted");

  while(!isDefined(level.var_1181f1897e13785c)) {
    waitframe();
  }

  var_4e232eaf9f60e290 = sortbydistance(level.var_1181f1897e13785c, level.player.origin);

  if(var_4e232eaf9f60e290.size >= 2) {
    var_67dfd6629d45eb90 = var_4e232eaf9f60e290[0];
    var_67dfd9629d45f229 = var_4e232eaf9f60e290[1];
  }

  if(isDefined(var_67dfd6629d45eb90) && isDefined(var_67dfd9629d45f229)) {
    var_67dfd6629d45eb90 endon("death");
    var_67dfd6629d45eb90 endon("entitydeleted");
    var_67dfd9629d45f229 endon("death");
    var_67dfd9629d45f229 endon("entitydeleted");
    var_67dfd6629d45eb90 say_delayed(1.5, "dx_sp_surg_chin_kon1_needthatlastparttoas", 0, 5);
    var_67dfd9629d45f229 say_delayed(0.8, "dx_sp_surg_chin_kon2_shouldbecomingsoon", 0, 5);
    level thread function_b2e86be73a3f6775();
    var_67dfd6629d45eb90 say_delayed(0.6, "dx_sp_surg_chin_kon1_eta", 0, 5);
    var_67dfd9629d45f229 say_delayed(0.6, "dx_sp_surg_chin_kon2_arrivinginfiveminute", 0, 5);
    var_67dfd6629d45eb90 say_delayed(0.8, "dx_sp_surg_chin_kon1_weneeditinthreeenemy", 0, 5);
    var_67dfd9629d45f229 say_delayed(0.2, "dx_sp_surg_chin_kon2_yessir", 0, 5);
  }
}

function function_b2e86be73a3f6775() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_alerted");
  level endon("flg_chunnel_intro_train_2_incoming");

  if(utility::flag("flg_chunnel_intro_track_alerted") || utility::flag("flg_chunnel_intro_train_2_incoming")) {
    return;
  }

  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_chin_soap_theyreassemblingatur", 0, 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_chin_pric_theywontfinishit", 0, 1);
}

function function_d682edc598c0e4f9() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_alerted");

  if(utility::flag("flg_chunnel_intro_track_alerted")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_enemiesaheadshouldta"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_letsambushkonnibefor"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_hostilesareunawarele"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flg_chunnel_intro_track_alerted", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(30, 50, 2), 20, 1);
}

function function_bb2981a6e09bef73() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_complete");
  utility::flag_wait("flg_chunnel_intro_train_2_incoming");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_chin_soap_anothertraincomin", 1, 5);
  level thread function_c7f1c987bdae4ada();
  level thread function_9ebbf6fd0482c86f("flg_chunnel_intro_track_complete");
}

function function_c7f1c987bdae4ada() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_complete");

  if(!isDefined(level.var_56dea5612e5a8782)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_surg_chin_soap_train";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_incomingtrain";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_getoffthetracks";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_watchforthetrain";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_mindthetrain";
    level.var_56dea5612e5a8782 = utility::create_deck(aliases, 1, 1);
  }

  utility::flag_wait("flg_chunnel_intro_track_alerted");

  while(true) {
    utility::flag_wait("flg_chunnel_intro_track_train_danger_vo");

    if(!utility::flag("flg_train_passed_player")) {
      soap_vo = level.var_56dea5612e5a8782 utility::deck_draw();
      level.ai_soap dialogue::say_team(soap_vo, 0, 1);
    }

    utility::flag_waitopen("flg_chunnel_intro_track_train_danger_vo");
    wait 1;
  }
}

function function_91b944b3dd33df9() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_complete");
  level thread function_9792fc5316c5c6f1();
  msg = utility::flag_wait_any_return("flg_chunnel_intro_track_attack_left", "flg_chunnel_intro_track_attack_right", "flg_chunnel_intro_track_alerted");
  level notify("stop_surge_nags");
  wait 0.5;

  if(utility::flag("flg_chunnel_intro_track_player_broke_stealth")) {
    level.ai_soap dialogue::stop_dialogue();
    level.player dialogue::stop_dialogue();
    level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_chin_pric_engagesergeant", 1, 2.5);
  } else {
    var_b5435945531d710d = function_ae7b099ba92c26c4(level.var_1181f1897e13785c);

    if(istrue(var_b5435945531d710d)) {
      if(utility::flag("flg_chunnel_intro_track_enemies_visible")) {
        level.ai_soap dialogue::stop_dialogue();
        level.player dialogue::stop_dialogue();
        level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_chin_pric_engagesergeant", 1, 2.5);
      } else {
        level.ai_soap dialogue::say_team("dx_sp_surg_chin_soap_spottedus", 1);
      }
    } else {
      level.ai_soap dialogue::say_team("dx_sp_surg_chin_soap_spottedus", 1);
    }
  }

  utility::flag_set("flg_chunnel_intro_track_allies_go_loud");
}

function function_9792fc5316c5c6f1() {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_complete");
  level.player utility::waittill_any("weapon_fired", "player_flash", "player_frag");
  utility::flag_set("flg_chunnel_intro_track_player_broke_stealth");
}

function function_ae7b099ba92c26c4(a_ai_enemy) {
  level.player endon("death");
  level endon("flg_chunnel_intro_track_complete");

  for(i = 0; i < a_ai_enemy.size; i++) {
    ai_enemy = a_ai_enemy[i];

    if(isDefined(ai_enemy) && isalive(ai_enemy) && ai_enemy cansee(level.player)) {
      foreach(enemy in a_ai_enemy) {
        thread function_678ee05eb44c1fb9(enemy, "flg_chunnel_intro_track_enemies_visible", "flg_chunnel_intro_vents_01");
      }

      return true;
    }
  }

  return false;
}

function function_55050a18925817e0() {}

function function_19ca5dae7378a648() {
  level thread function_f3e25ed68d5b36f6();
  level thread function_e2e487db292a1385();
  level thread function_ddd71c17b9d1f0e0();
  level thread function_8bf7af918bb38214();
  level dialogue::set_nagvars(0, 3, 0, "team");
}

function function_f3e25ed68d5b36f6() {
  level.player endon("death");
  level endon("flg_chunnel_intro_vents_01");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(1.4, "dx_sp_surg_chin_soap_clear", 1);
  wait 1;
  level.player thread function_2a5f16ea78f32af4("noncombat", 3.6);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_chin_pric_sixtowatchertraintun", 1);
  level.player thread function_600f9ba1d61f24f0();
  level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_chin_lasw_copyadviseusingtheve", 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_chin_pric_checkwilco", 1);
  level thread function_3f6f04839fce8f83();
}

function function_3f6f04839fce8f83() {
  level.player endon("death");
  utility::flag_set("flg_chunnel_vents_checkin_vo_start");
  function_4256d29a648763ba();
  var_31b606456c7fa7d3 = [[level.var_292c01a9cd0b2818, 0.6, "dx_sp_surg_chin_ghos_allbravothisis71taki", &function_72cf1844bf828de4], [level.player, 0.4, "dx_sp_surg_chin_pric_securethemseven", &function_72cf1844bf828de4], [level.var_351f8aca05656919, 0.3, "dx_sp_surg_chin_gazz_wereworkinonitsix", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_chunnel_intro_vents_06";
  level dialogue::say_sequence(var_31b606456c7fa7d3, 1, 0, 0, 0, "team");
  utility::flag_set("flg_chunnel_vents_checkin_vo_complete");

  if(!utility::flag("flg_chunnel_intro_vents_01")) {
    level thread function_fc4dbdc948a8878();
    return;
  }

  level thread function_29c5ee5a109ac636("flg_chunnel_intro_vents_06");
}

function function_fc4dbdc948a8878() {
  level.player endon("death");
  level endon("flg_chunnel_intro_vents_01");
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_ventilationwaysoverh"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_weretakintheventilat"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_ventsareoverherecapt"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flg_chunnel_intro_vents_01", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(20, 60, 4), 15);
}

function function_e2e487db292a1385() {
  level.player endon("death");
  level endon("flg_chunnel_crossover_open_door");
  level notify("stop_vents_train_tunnel_warning");
  level endon("stop_vents_train_tunnel_warning");

  if(!isDefined(level.var_56dea5612e5a8782)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_surg_chin_soap_train";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_incomingtrain";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_getoffthetracks";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_watchforthetrain";
    aliases[aliases.size] = "dx_sp_surg_chin_soap_mindthetrain";
    level.var_56dea5612e5a8782 = utility::create_deck(aliases, 1, 1);
  }

  level thread function_b3b19a6662bb1c61("flg_chunnel_crossover_open_door");
  utility::flag_wait("flg_chunnel_track_intro_to_crossover");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_chin_soap_thiswaycaptainidstay", 0, 2.5);
  wait 1;

  while(true) {
    utility::flag_wait("flg_chunnel_intro_track_train_danger_vo");

    if(!utility::flag("flg_train_passed_player")) {
      soap_vo = level.var_56dea5612e5a8782 deck_draw();
      level.ai_soap dialogue::say_team(soap_vo, 0, 1);
    }

    utility::flag_waitopen_or_timeout("flg_chunnel_intro_track_train_danger_vo", randomfloatrange(5, 8));
  }
}

function function_ddd71c17b9d1f0e0() {
  level.player endon("death");
  level endon("flg_chunnel_intro_vents_13");
  utility::flag_wait("flg_chunnel_intro_vents_01");
  level notify("stop_surge_nags");

  if(!utility::flag("flg_chunnel_vents_checkin_vo_start")) {
    level thread function_3f6f04839fce8f83();
  } else {
    level thread function_29c5ee5a109ac636("flg_chunnel_intro_vents_06");
  }

  utility::flag_wait_all("flg_chunnel_vents_checkin_vo_complete", "flg_chunnel_intro_vents_corpses_in_view");
  level thread function_4aaa8f31212b60fe();
  utility::flag_wait_any("flg_chunnel_vents_corpses_visible", "flg_chunnel_intro_vents_09");
  level notify("stop_surge_nags");
  thread function_7f00fe62ddd4f3bd();
  function_4256d29a648763ba();
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_chin_pric_watcherwereseeingdea", 1);
  level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_chin_lasw_theymaybethefirstofm", 1);

  if(!utility::flag("flg_chunnel_intro_vents_08")) {
    var_1d18da426255d799 = [[level.player, 0.2, "dx_sp_surg_chin_pric_bloodyaffirmativewat", &function_72cf1844bf828de4], [level.var_292c01a9cd0b2818, 0.5, "dx_sp_surg_chin_ghos_weareinthelineoffire", &function_72cf1844bf828de4], [level.player, 0.3, "dx_sp_surg_chin_pric_giveemallyougotwerea", &function_72cf1844bf828de4], [level.var_351f8aca05656919, 0.2, "dx_sp_surg_chin_gazz_betonitsir", &function_72cf1844bf828de4]];
    level.var_6ef05c49e46d8d70 = "flg_chunnel_intro_vents_13";
    level dialogue::say_sequence(var_1d18da426255d799, 1, 0, 0, 0, "team");
  }

  level thread function_29c5ee5a109ac636("flg_chunnel_intro_vents_13");
}

function function_4aaa8f31212b60fe() {
  level.player endon("death");
  level endon("flg_chunnel_vents_corpses_visible");
  level endon("flg_chunnel_intro_vents_09");
  var_266f9e08c50954d6 = getEnt("trig_chunnel_intro_vents_corpses", "targetname");

  while(!utility::flag("flg_chunnel_intro_vents_06")) {
    if(within_fov_of_players(var_266f9e08c50954d6.origin, cos(20)) && level.player getstance() == "stand") {
      wait 0.15;
      utility::flag_set("flg_chunnel_vents_corpses_visible");
      return;
    }

    wait 0.5;
  }

  var_266f9e08c50954d6 = getEnt("trig_chunnel_intro_vents_09", "targetname");

  while(!utility::flag("flg_chunnel_intro_vents_09")) {
    if(within_fov_of_players(var_266f9e08c50954d6.origin, cos(30)) && utility::flag("flg_chunnel_intro_vents_06")) {
      utility::flag_set("flg_chunnel_vents_corpses_visible");
      return;
    }

    wait 0.5;
  }
}

function function_7f00fe62ddd4f3bd() {
  setmusicstate("mx_surge_advance");
}

function function_8bf7af918bb38214() {
  level.player endon("death");
  utility::flag_wait("flg_chunnel_intro_vents_14");
  level notify("stop_surge_nags");
  utility::battlechatter_off("axis");
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  function_4256d29a648763ba();
  level thread function_425f66e0229e8364();
  level thread function_1a07d6f1a272fa5c();
  level thread function_226e73c886a3c67();
  level.player dialogue::function_fc0eb6b81c66c661(2, "dx_sp_surg_chin_pric_hostagesinthenextroo", 1);
  level.var_25932e13dae83dd3 dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_chin_sfo4_rogerthat", 0, 2.5);
  level thread function_7ecb6d66be890858();
}

function function_7ecb6d66be890858() {
  level.player endon("death");
  level endon("flg_chunnel_vents_garage_alerted");
  level endon("stealth_spotted");
  level endon("flg_chunnel_intro_garage_01");

  if(utility::flag("flg_chunnel_vents_garage_alerted") || utility::flag("stealth_spotted") || utility::flag("flg_chunnel_intro_garage_01")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_needtosecurethehosta"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_needtomoveinandsecur"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_chin_soap_thehostagesneedhelpc"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  var_5e531899936a10f9 = ["flg_chunnel_vents_garage_alerted", "stealth_spotted", "flg_chunnel_intro_garage_01", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(10, 30, 2), 10);
}

function function_1a07d6f1a272fa5c() {
  level.player endon("death");
  level endon("flg_chunnel_vents_garage_alerted");
  level endon("stealth_spotted");

  while(!isDefined(level.var_3edf96459054e230) || !isDefined(level.var_b680f0b90d32078b)) {
    waitframe();
  }

  foreach(ai_enemy in level.var_b680f0b90d32078b) {
    ai_enemy endon("death");
    ai_enemy endon("entitydeleted");
  }

  level.var_3edf96459054e230[0] dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_chin_bmc1_pleaseletusgo", 2);
  level.var_b680f0b90d32078b[0] dialogue::function_fc0eb6b81c66c661(1.1, "dx_sp_surg_chin_kon1_stayquiet", 2);
  utility::flag_wait("flg_chunnel_intro_garage_01");
  var_f48358c2edfdb80f = [[level.var_b680f0b90d32078b[1], 1.5, "dx_sp_surg_chin_kon2_icanthinkofagoodwayt"], [level.var_b680f0b90d32078b[0], 1, "dx_sp_surg_chin_kon3_notabadidea"], [level.var_3edf96459054e230[0], 1.5, "dx_sp_surg_chin_bmc1_nonopleaseilldoanyth"], [level.var_b680f0b90d32078b[0], 1, "dx_sp_surg_chin_kon2_wetoldyoutobequiet"]];
  level dialogue::function_b0c2a659a5c2761f([level, "flg_chunnel_vents_garage_alerted", level, "stealth_spotted"], var_f48358c2edfdb80f, 0);
  wait 3;
  utility::flag_set("flg_chunnel_garage_hostage_execution_start");
}

function function_425f66e0229e8364() {
  level.player endon("death");
  level endon("flg_chunnel_intro_garage_complete");
  utility::flag_wait("flg_chunnel_intro_garage_01");
  level.player utility::waittill_any("weapon_fired", "player_flash", "player_frag");
  utility::flag_set("flg_chunnel_vents_garage_player_broke_stealth");
}

function function_226e73c886a3c67() {
  level.player endon("death");
  level endon("flg_chunnel_crossover_open_door");
  msg = utility::flag_wait_any_return("stealth_spotted", "flg_chunnel_vents_garage_alerted", "flg_chunnel_vents_garage_player_broke_stealth");
  utility::battlechatter_on("axis");
  level notify("stop_surge_nags");
  wait 0.5;

  if(msg == "flg_chunnel_vents_garage_player_broke_stealth") {
    level.player dialogue::say_team("dx_sp_surg_chin_pric_fire", 1);
  }

  utility::flag_wait("flg_chunnel_intro_garage_complete");
  utility::flag_set("flg_chunnel_garage_vo_start");
  utility::flag_clear("stealth_spotted");
  utility::battlechatter_off("axis");
  wait 1.2;
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  level.var_89739751f74169b4 dialogue::say_team("dx_sp_surg_chin_sfo4_garageclear", 1);
  thread function_b6861d7bd63868d5();

  if(utility::flag("flg_chunnel_vents_garage_all_hostages_dead")) {
    var_2a0ff7e2d005911c = [[level.var_89739751f74169b4, 1.2, "dx_sp_surg_chin_sfo4_nosurvivors"], [level.ai_soap, 0.3, "dx_sp_surg_chin_soap_nofuckinregardforhum"], [level.player, 0.2, "dx_sp_surg_chin_pric_weneedtofindmakarovn"], [level.var_89739751f74169b4, 0.4, "dx_sp_surg_chin_sfo4_coveringsixcaptain"]];
  } else if(utility::flag("flg_chunnel_vents_garage_hostage_casualties")) {
    var_2a0ff7e2d005911c = [[level.var_89739751f74169b4, 1.2, "dx_sp_surg_chin_sfo4_civiliancasualtieshe"], [level.player, 0.3, "dx_sp_surg_chin_pric_getanysurvivorstosaf"], [level.var_3edf96459054e230[0], 1, "dx_sp_surg_chin_bmc1_ohgodohmygod"], [level.var_89739751f74169b4, 0.2, "dx_sp_surg_chin_sfo4_wellhandlethemrestta"]];
  } else {
    var_2a0ff7e2d005911c = [[level.var_89739751f74169b4, 1.2, "dx_sp_surg_chin_sfo4_securingthehostagesn"], [level.player, 0.3, "dx_sp_surg_chin_pric_getthemtosafety"], [level.var_3edf96459054e230[0], 1, "dx_sp_surg_chin_bmc1_ohgodohmygod"], [level.var_89739751f74169b4, 0.2, "dx_sp_surg_chin_sfo4_wellhandlethemrestta"]];
  }

  level dialogue::say_sequence(var_2a0ff7e2d005911c, 1, 0, 0, 0, "team");
  wait 1;
  level thread function_adc8f9a62f4d402f();
}

function function_adc8f9a62f4d402f() {
  level.player endon("death");
  level.ai_soap dialogue::say_team("dx_sp_surg_chin_soap_thisis71wereatthecro", 1);
  level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_surg_chin_lasw_thatsmakarovslastkno", 1);
  utility::flag_set("flg_chunnel_garage_vo_complete");
  level endon("flg_chunnel_crossover_open_door");
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_chin_pric_letsreadyupmakarovma", 1);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_covr_soap_onyourgosir", 1);
  wait 1;
  level thread function_359f4a7392442dc3();
}

function function_359f4a7392442dc3() {
  level.player endon("death");
  level endon("flg_chunnel_crossover_open_door");
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_covr_soap_waitingonyoucaptain"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_covr_soap_makarovcouldbeherele"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_covr_soap_settobreachcallitcap"];
  nag_deck = utility::create_deck(nag_aliases);
  level dialogue::function_91c23782840cf632(["flg_chunnel_crossover_open_door", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(20, 60, 4), 15);
}

function function_dce43c38c9ffe90b() {}

function function_554b1127c6be10c6() {
  level thread function_b8cfa12c03be1530();
  level thread function_f0d84ee15ee2d715();
  level thread function_7e45588af70fa407();
  level dialogue::set_nagvars(0, 5, 0, "team");
}

function function_b8cfa12c03be1530() {
  level.player endon("death");
  utility::flag_wait("flg_chunnel_crossover_open_door");
  level notify("stop_surge_nags");
  level thread function_f39321bdccb36430();
  level thread function_726ef95054cdb0e7();
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_covr_pric_moving", 0, 1);
  wait 4;
  level thread function_17a9d4c35e5a8363();
}

function function_b6861d7bd63868d5() {
  stopmusicstate("mx_surge_advance");
}

function function_f39321bdccb36430() {
  level.player endon("death");
  level endon("flg_chunnel_middle_crossed");
  level.player utility::waittill_any("weapon_fired", "player_flash", "player_frag");
  utility::flag_set("flg_chunnel_crossover_player_broke_stealth");
}

function function_17a9d4c35e5a8363() {
  level.player endon("death");
  level endon("flg_chunnel_crossover_player_broke_stealth");
  level endon("flg_chunnel_crossover_alerted");
  utility::battlechatter_off("axis");

  while(!isDefined(level.var_337d7d0b877e30c8)) {
    waitframe();
  }

  var_4e232eaf9f60e290 = sortbydistance(level.var_337d7d0b877e30c8, level.player.origin);

  if(var_4e232eaf9f60e290.size >= 2) {
    var_67dfd6629d45eb90 = var_4e232eaf9f60e290[0];
    var_67dfd9629d45f229 = var_4e232eaf9f60e290[1];
  }

  if(isDefined(var_67dfd6629d45eb90) && isDefined(var_67dfd9629d45f229)) {
    var_67dfd6629d45eb90 endon("death");
    var_67dfd6629d45eb90 endon("entitydeleted");
    var_67dfd9629d45f229 endon("death");
    var_67dfd9629d45f229 endon("entitydeleted");
    var_464efcae4fd633b = [[var_67dfd6629d45eb90, 0.4, "dx_sp_surg_covr_kon1_youheardfromtheother"], [var_67dfd9629d45f229, 0.3, "dx_sp_surg_covr_kon2_negative"], [var_67dfd6629d45eb90, 0.5, "dx_sp_surg_covr_kon1_enemycouldbegettingc"], [var_67dfd9629d45f229, 0.3, "dx_sp_surg_covr_kon2_checkyourmagsbeready"], [var_67dfd6629d45eb90, 0.2, "dx_sp_surg_covr_kon1_copythatstayalert"]];
    level dialogue::function_b0c2a659a5c2761f([level, "flg_chunnel_crossover_alerted", level, "flg_chunnel_crossover_player_broke_stealth"], var_464efcae4fd633b, 0);
    utility::battlechatter_on("axis");
    utility::flag_set("flg_chunnel_crossover_alerted");
  }
}

function function_726ef95054cdb0e7() {
  level.player endon("death");
  level endon("flg_crossover_clear_obj_show");
  msg = utility::flag_wait_any_return("flg_chunnel_crossover_alerted", "flg_chunnel_crossover_player_broke_stealth");

  if(msg == "flg_chunnel_crossover_player_broke_stealth") {
    wait 1;
    utility::flag_set("flg_chunnel_crossover_alerted");
    wait 1;
  }

  while(true) {
    ai_enemies = getaiarray("axis");
    ai_enemies = array_removedead_or_dying(ai_enemies, 1);
    ai_enemy_closest = getclosest(level.player.origin, ai_enemies);

    if(isDefined(ai_enemy_closest) && isalive(ai_enemy_closest)) {
      ai_enemy_closest dialogue::say("dx_sp_surg_covr_kon1_theyrehereopenfire");
      utility::flag_set("flg_chunnel_crossover_enemy_surprise_vo_complete");
      break;
    }

    wait 1;
  }
}

function function_f0d84ee15ee2d715() {
  level.player endon("death");
  level endon("flg_crossover_elites_clear");
  msg = utility::flag_wait_any_return("flg_chunnel_crossover_alerted", "flg_chunnel_crossover_exit_garage");
  utility::battlechatter_on("axis");

  if(msg == "flg_chunnel_crossover_alerted") {
    utility::flag_wait_or_timeout("flg_chunnel_crossover_enemy_surprise_vo_complete", 5);
  } else {
    utility::flag_set("flg_chunnel_crossover_alerted");
  }

  level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_covr_pric_pushforwardfireforef", 1);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_covr_soap_youheardhimmove", 1);
  utility::flag_set("flg_crossover_clear_obj_show");
  level thread function_757ff9ac0bb62be8();
  level thread function_b3b19a6662bb1c61("flg_crossover_exit_reached");
  level thread function_9ebbf6fd0482c86f("flg_crossover_exit_reached");
  utility::flag_wait("flg_chunnel_enter_crossover");
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_covr_pric_crossingwatchfortrai", 1);
  utility::flag_wait("flg_chunnel_middle_crossed");
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  level.var_89739751f74169b4 dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_covr_sfo4_advancingbehindyou", 1);
  wait 1;
  level thread function_cd3c5ae1c9b99016();
}

function function_ec3904b43ba2ac4d() {
  level.player endon("death");
  level endon("flg_crossover_second_combat_area");
  level endon("flg_crossover_turret_removed");
  level.var_bfdb4f43205d4328 dialogue::say("dx_sp_surg_hcqc_kon1_deployingturret", 0, 5);
  utility::flag_wait("flg_crossover_turret_active");
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  level.var_89739751f74169b4 dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_surg_hcqc_sfo3_contactenemyturret", 1, 5);
}

function function_757ff9ac0bb62be8() {
  level.player endon("death");
  level endon("flg_crossover_elites_clear");
  level endon("flg_crossover_exit_reached");
  level thread function_f91c5f8491d5b6cc("flg_chunnel_crossover_initial_enemies_cleared");
  utility::flag_wait_any("flg_chunnel_crossover_initial_enemies_cleared", "flg_chunnel_middle_crossed");
  level thread function_9dc1a2cca93b1ac7("flg_chunnel_middle_crossed");
  utility::flag_wait("flg_chunnel_middle_crossed");
  level thread function_f91c628491d5bd65("flg_chunnel_crossover_advance_enemies_cleared");
  utility::flag_wait_all("flg_crossover_second_combat_area", "flg_crossover_juggernaut_both_dead");
  level thread function_f91c618491d5bb32();
}

function function_f91c5f8491d5b6cc(endon_flag) {
  level.player endon("death");
  level endon("flg_crossover_exit_reached");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  var_4b333ee39a0e4a4 = [];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_engaging"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_theyretakingcoverint"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_hcqc_soap_iseeem"];
  var_6ba69ccbacabc34d = utility::create_deck(var_4b333ee39a0e4a4, 1, 1);
  var_5e531899936a10f9 = [endon_flag, "flg_chunnel_middle_crossed", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, var_6ba69ccbacabc34d, dialogue::growing_delay(20, 40, 4), 15, 1);
}

function function_9dc1a2cca93b1ac7(endon_flag) {
  level.player endon("death");
  level endon("flg_crossover_elites_clear");
  level endon("flg_crossover_exit_reached");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_6ba69ccbacabc34d)) {
    var_34869e7fae39e27d = [];
    var_34869e7fae39e27d[var_34869e7fae39e27d.size] = [level.ai_soap, "dx_sp_surg_covr_soap_morekonniupaheadcapt"];
    var_34869e7fae39e27d[var_34869e7fae39e27d.size] = [level.ai_soap, "dx_sp_surg_covr_soap_moveforwardletsstayt"];
    var_34869e7fae39e27d[var_34869e7fae39e27d.size] = [level.ai_soap, "dx_sp_surg_covr_soap_enemiesinfrontletspr"];
    var_34869e7fae39e27d[var_34869e7fae39e27d.size] = [level.ai_soap, "dx_sp_surg_covr_soap_gotmorekonniinourpat"];
    level.var_3550a4c227a44b5a = utility::create_deck(var_34869e7fae39e27d, 1, 1);
  }

  var_5e531899936a10f9 = [endon_flag, "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, level.var_3550a4c227a44b5a, dialogue::growing_delay(20, 60, 4), 15);
}

function function_7542a7d1619df718() {
  level.player endon("death");
  level endon("flg_crossover_second_combat_area");
  utility::flag_wait("flg_crossover_turret_removed");
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_surg_hcqc_soap_turretsdestroyed", 0, 5);
}

function function_f91c628491d5bd65(endon_flag) {
  level.player endon("death");
  level endon("flg_crossover_exit_reached");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  var_4b333ee39a0e4a4 = [];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_theyremovingclose"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_stayoffthetracks"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_seriousfuckinnumbers"];
  var_6ba69ccbacabc34d = utility::create_deck(var_4b333ee39a0e4a4, 1, 1);
  var_5e531899936a10f9 = [endon_flag, "flg_crossover_second_combat_area", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, var_6ba69ccbacabc34d, dialogue::growing_delay(20, 40, 4), 10, 1);
}

function function_cd3c5ae1c9b99016() {
  level.player endon("death");
  utility::flag_wait_any("flg_chunnel_crossover_advance_enemies_cleared", "flg_crossover_combat_a_enemies_rush");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();
  var_4eb0ced8c2bdfa09 = [[level.ai_soap, 1.2, "dx_sp_surg_covr_soap_theyrethinninout"], [level.player, 0.3, "dx_sp_surg_covr_pric_ghostgaztroopsincont"], [level.var_292c01a9cd0b2818, 0.6, "dx_sp_surg_covr_ghos_pushingupthetraintun"], [level.var_351f8aca05656919, 0.3, "dx_sp_surg_covr_gazz_noshortageofhostiles"], [level.player, 0.2, "dx_sp_surg_covr_pric_copyweremovingaheadm"]];
  level dialogue::say_sequence(var_4eb0ced8c2bdfa09, 1, 0, 0, 0, "team");
  level thread function_9dc1a2cca93b1ac7("flg_crossover_second_combat_area");
  level thread function_ab48053cf6e311f2();
}

function function_ab48053cf6e311f2() {
  level.player endon("death");
  level endon("flg_crossover_exit_reached");
  utility::flag_wait_all("flg_crossover_second_combat_area", "flg_chunnel_crossover_sfo_charlie_spawned");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  var_b9e2a48c725b4359 = [[level.var_89739751f74169b4, 0.6, "dx_sp_surg_covr_sfo4_advancing", &function_72cf1844bf828de4], [level.ai_soap, 1.2, "dx_sp_surg_covr_soap_watchthatjugg", &function_72cf1844bf828de4], [level.player, 0.8, "dx_sp_surg_covr_pric_hesheavilyarmoredtak", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_crossover_exit_reached";
  level dialogue::say_sequence(var_b9e2a48c725b4359, 1, 0, 0, 0, "team");
  level thread function_50d9701feaf3d770();
}

function function_f91c618491d5bb32() {
  level.player endon("death");
  level endon("flg_crossover_elites_clear");
  level endon("flg_crossover_exit_reached");
  var_4b333ee39a0e4a4 = [];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_almosttherecaptain"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_onlyafewleft"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_justalittlefurtherca"];
  var_6ba69ccbacabc34d = utility::create_deck(var_4b333ee39a0e4a4, 1, 1);
  var_5e531899936a10f9 = ["flg_crossover_elites_clear", "flg_crossover_exit_reached", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, var_6ba69ccbacabc34d, dialogue::growing_delay(20, 40, 4), 15, 1);
}

function function_50d9701feaf3d770() {
  level.player endon("death");
  level endon("flg_crossover_exit_reached");
  level thread function_fd7644c12da425c0();
  level thread function_474d27bb20b964c8("flg_crossover_juggernaut_one_dead");
  utility::flag_wait("flg_crossover_juggernaut_one_dead");
  level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_covr_pric_enemyjuggernautisdow", 1, 2.5);
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_surg_covr_soap_biggertheyare", 1, 2.5);
  level thread function_474d27bb20b964c8("flg_crossover_juggernaut_both_dead");
  utility::flag_wait("flg_crossover_juggernaut_both_dead");
  level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_covr_pric_hesdown", 2, 0.5);

  if(!utility::flag("flg_crossover_elites_clear")) {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_covr_soap_timetoendthis", 0, 2.5);
  }
}

function function_fd7644c12da425c0() {
  level.player endon("death");
  level endon("flg_crossover_jugg_intro_killed");
  level endon("flg_crossover_juggernaut_both_dead");
  level endon("flg_crossover_exit_reached");

  if(!utility::flag("flg_crossover_jugg_intro_path_complete")) {
    utility::flag_wait("flg_crossover_jugg_intro_path_complete");
  }

  while(distance2dsquared(level.player.origin, level.var_5e64b5358f867b1.origin) < squared(124)) {
    wait 1;
  }

  thread function_678ee05eb44c1fb9(level.var_5e64b5358f867b1, "flg_crossover_intro_jugg_visible", "flg_crossover_jugg_intro_killed");
  utility::flag_wait("flg_crossover_intro_jugg_visible");

  if(utility::flag("flg_crossover_juggernaut_one_dead")) {
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_covr_pric_enemyjuggernaut", 1, 2.5);
  }
}

function function_474d27bb20b964c8(endon_flag) {
  level.player endon("death");
  level endon("flg_crossover_exit_reached");

  if(utility::flag(endon_flag) || utility::flag("flg_crossover_exit_reached")) {
    return;
  }

  level endon(endon_flag);
  var_4b333ee39a0e4a4 = [];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_slotthatbigbastard"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_burnhisdowncaptain"];
  var_4b333ee39a0e4a4[var_4b333ee39a0e4a4.size] = [level.ai_soap, "dx_sp_surg_covr_soap_weneedtofinishhim"];
  var_6ba69ccbacabc34d = utility::create_deck(var_4b333ee39a0e4a4, 1, 1);
  var_5e531899936a10f9 = [endon_flag, "flg_crossover_exit_reached", "flag_surge_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, var_6ba69ccbacabc34d, dialogue::growing_delay(25, 45, 4), 20);
}

function function_7e45588af70fa407() {
  level.player endon("death");
  level endon("flg_bomb_discovered");
  utility::flag_wait_all("flg_crossover_elites_clear", "flg_crossover_juggernaut_both_dead");
  level notify("stop_surge_nags");
  a_remaining_enemies = getaiarray("axis");
  a_remaining_enemies = array_removedead_or_dying(a_remaining_enemies);

  if(a_remaining_enemies.size > 0) {
    level thread function_3025ee051d28ec46(a_remaining_enemies, "flg_crossover_remaining_enemies_dead");
    utility::flag_wait("flg_crossover_remaining_enemies_dead");
  }

  function_4256d29a648763ba();
  level.var_89739751f74169b4 = function_d1061513a0f95e85();
  var_267d89b1fb9e485f = [[level.var_89739751f74169b4, 1.4, "dx_sp_surg_covr_sfo4_clear", &function_72cf1844bf828de4], [level.player, 1.2, "dx_sp_surg_covr_pric_soapletsmovewedontre", &function_72cf1844bf828de4], [level.ai_soap, 0.3, "dx_sp_surg_covr_soap_hesnotgettinoutalive", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_bomb_discovered";
  level dialogue::say_sequence(var_267d89b1fb9e485f, 1, 0, 0, 0, "team");
  wait 1.5;
  level thread function_dc9d12489618855e();
}

function function_dc9d12489618855e() {
  level.player endon("death");
  level endon("flg_bomb_discovered");

  if(utility::flag("flg_bomb_discovered")) {
    return;
  }

  var_a3b1f114361fa3c0 = [[level.var_351f8aca05656919, 0.3, "dx_sp_surg_covr_gazz_captainkonnispressin"], [level.player, 0.2, "dx_sp_surg_covr_pric_meansmakarovsstillhe", &function_72cf1844bf828de4], [level.var_292c01a9cd0b2818, 0.4, "dx_sp_surg_covr_ghos_watchyourbackstheyve", &function_72cf1844bf828de4], [level.ai_soap, 0.2, "dx_sp_surg_covr_soap_rogerthatltnosurrend", &function_72cf1844bf828de4]];
  level.var_6ef05c49e46d8d70 = "flg_bomb_discovered";
  level dialogue::say_sequence(var_a3b1f114361fa3c0, 1, 0, 0, 0, "team");
  level thread function_26ae641aef0e2486("flg_bomb_discovered");
}

function function_26ae641aef0e2486(endon_flag) {
  level.player endon("death");
  level endon("flg_bomb_discovered");

  if(utility::flag("flg_bomb_discovered")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_covr_soap_comeoncaptainwererun"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_covr_soap_whateverhesgonnadodo"];
  nag_aliases[nag_aliases.size] = [level.ai_soap, "dx_sp_surg_covr_soap_wecantletmakarovesca"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flg_bomb_discovered", "flag_surge_stop_nags"], nag_deck, dialogue::growing_delay(20, 60, 4), 10);
}

function function_c591b3fda09c8dd7() {}

function function_f9b3b24c9ce60b99() {
  level endon("flg_chunnel_pre_bomb_player_on_left");
  level endon("flg_chunnel_pre_bomb_player_on_right");
  level endon("flag_chunnel_finale_wave_1_dead");
  level.player utility::waittill_any("weapon_fired", "grenade_fire");
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_pric_contact", 1);
}

function function_7efaee8d944d6157() {
  utility::flag_wait("flag_chunnel_finale_wave_1_dead");
  level notify("stop_surge_nags");
  function_4256d29a648763ba();
  thread function_1eecb9607b53a762();
  level.ai_soap dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_soap_captaineyesonthebomb", 2);
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_pric_copycheckit", 2);
}

function function_1eecb9607b53a762() {
  setmusicstate("mx_surge_hostages");
}

function function_edcb9b6a1989fdad() {
  utility::flag_wait("flag_chunnel_finale_wave_1_dead");
  level.player dialogue::function_fc0eb6b81c66c661(1.4, "dx_sp_surg_ssoa_pric_sfosecureaperimeter", 2);
  level.var_ed5a4d7626f6868 dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_sfo4_yessir", 2);
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_pric_soapgetonthatbomb", 2);
  flag_wait("flg_finale_wave2_ready");
  level.player thread function_2a5f16ea78f32af4("combat", 5);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_ssoa_pric_allbravobomblocatedi", 2);
  level.player thread function_600f9ba1d61f24f0();
  level.var_351f8aca05656919 dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_surg_ssoa_gazz_rogontheway", 2);

  if(!flag("flg_finale_player_in_combat_zone")) {
    flag_wait("flg_finale_player_in_combat_zone");
  }

  utility::flag_set("flg_start_wave_two");
  level thread function_f45a2bf81a3d37b9();
}

function function_f45a2bf81a3d37b9() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  level.var_ed5a4d7626f6868 dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_surg_ssoa_sfo3_contact", 2);
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_pric_fuckinhellstandby", 2);
  thread function_8534b2514ad043c1();
  wait 0.5;
  utility::flag_set("flg_comm_done_from_Price");
  utility::flag_wait("flag_chunnel_finale_wave_2_dead");
  function_4256d29a648763ba();
  level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_surg_ssoa_pric_canyoudisarmit", 2);
  utility::flag_set("flg_start_enter_nags");
}

function function_504bcda7256bc4bf() {
  level endon("flag_chunnel_finale_wave_2_dead");
  animnode = self;
  utility::flag_wait("flg_comm_done_from_Price");
  wait 5;
  animnode thread scene::play([level.ai_soap], "scene_nag04");
  wait 9.2;
  animnode thread scene::play([level.ai_soap], "scene_nag03");
  wait 4;
  utility::flag_set("flg_cannot_save_start");
  wait 4.3;
  animnode thread scene::play([level.ai_soap], "scene_nag05");
  wait 6.9;
  thread function_4fec720fd51f5ca9("flg_snakecam_first_enter_timeout");
}

function function_8534b2514ad043c1() {
  level endon("flg_snakecam_first_enter_timeout");
  level endon("flag_chunnel_finale_wave_2_dead");
  level endon("flg_start_enter_nags");
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  level utility::waittill_dead_or_dying(level.var_3ef7af4c51bb40f9, level.var_3ef7af4c51bb40f9.size - 1);
  var_13f0578e0f5cbd02 scene::play([level.ai_soap], "scene_nag01");
  var_13f0578e0f5cbd02 thread scene::play([level.ai_soap, level.dirty_bomb], "scene_loop");
}

function function_9081dba75d5595c7() {
  level endon("flg_first_bomb_interact_complete");
  animnode = self;
  animnode scene::play([level.ai_soap], "scene_nag02");
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "scene_loop");
  wait 5;
  animnode thread scene::play(level.ai_soap, "scene_nag03_2");
  wait 9.3;
  animnode thread scene::play(level.ai_soap, "scene_nag04_2");
  wait 9.2;
  animnode thread scene::play(level.ai_soap, "scene_nag05_2");
  wait 6.9;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "scene_nag06");
  wait 8.5;
  thread function_4fec720fd51f5ca9("flg_snakecam_first_enter_timeout");
}

function function_4fec720fd51f5ca9(timeout_flag, play_nag) {
  if(!isDefined(play_nag)) {
    play_nag = 0;
  }

  utility::flag_set(timeout_flag);

  if(play_nag == 1) {
    thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag06");
    level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_bloodyhellweretoolat");
  } else {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_bloodyhellweretoolat", 3);
  }

  utility::flag_set("flag_defusal_fail");
}

function function_810d67576ecea89c() {
  level.var_d18d63c6d75cd1e dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_gazz_wereoutoftimecutting", 3);
  function_d74f405076865c15();
  level.var_d18d63c6d75cd1e dialogue::say_team("dx_sp_surg_ssoa_gazz_shit", 3);
  utility::flag_set("flag_defusal_fail");
}

function function_7cefb008a23b6fc0() {
  level endon("flag_defusal_fail");
  function_4256d29a648763ba();
  utility::flag_set("flag_bomb_defusal_coordination_start");
  var_9f6cdd90045d24bf = [[level.player, 0.8, "dx_sp_surg_ssoa_pric_imintalktomesoap"], [level.player, 0.3, "dx_sp_surg_ssoa_soap_bombsdirtycaptainc4a"], [level.player, 0.2, "dx_sp_surg_ssoa_pric_itllimplodethetunnel"], [level.player, 0.5, "dx_sp_surg_ssoa_soap_ineedthemanufacturer"]];
  level dialogue::say_sequence(var_9f6cdd90045d24bf, 2, 0, 0, 0, "team");
  level thread function_af605355f44740e5();
  var_2495974d33de932e = getStruct("s_bomb_bear_logo", "targetname");

  if(!isDefined(var_2495974d33de932e)) {
    var_2495974d33de932e = spawnStruct();
    var_2495974d33de932e.origin = (-54063, 60368, 494);
  }

  var_2495974d33de932e thread function_45a191c0ccc354f0("flag_defusal_1_success");
  level thread function_9b7641928bbab4f7();
  msg = utility::flag_wait_any_return("flg_bomb_puzzle_spotted", "flg_bomb_puzzle_search_timeout");

  if(msg == "flg_bomb_puzzle_search_timeout") {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_bloodyhellweretoolat", 3);
    utility::flag_set("flag_defusal_fail");
    return;
  }

  level.player utility::flag_clear("flg_bomb_puzzle_spotted");
  var_213f147e9d671a83 = function_e607ac7b165d00cb();

  if(!isDefined(var_213f147e9d671a83)) {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_bloodyhellweretoolat", 3);
    utility::flag_set("flag_defusal_fail");
    return;
  }

  switch (var_213f147e9d671a83) {
    case 0:
      level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_soap_copybearcuttingthewi", 2);
      function_d74f405076865c15();
      level.player say_team("dx_sp_surg_ssoa_soap_gotitthatboughtussom", 2);
      break;
    case 1:
    case 2:
    case 3:
    default:
      level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_soap_copycuttingthewire");
      function_d74f405076865c15();
      utility::flag_set("flag_defusal_fail");
      return;
  }

  function_4256d29a648763ba();
  level thread namespace_85a51fd192b9a590::function_a81df2b9565dd07d();
  var_7853a8ce5e65edae = [[level.var_292c01a9cd0b2818, 0.4, "dx_sp_surg_ssoa_ghos_pricebeadvisedmakaro"], [level.player, 0.3, "dx_sp_surg_ssoa_pric_soapyouhearthat"], [level.player, 0.3, "dx_sp_surg_ssoa_soap_affirmimnotleavinthi"]];
  level dialogue::say_sequence(var_7853a8ce5e65edae, 2, 0, 0, 0, "team");
  utility::flag_set("flg_first_bomb_puzzle_complete");
  utility::flag_set("flag_defusal_1_success");
  level.player dialogue::function_fc0eb6b81c66c661(0.7, "dx_sp_surg_ssoa_soap_ughhhimhit", 2, 0.1);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_pric_soapgetyourgunup", 2);
}

function function_af605355f44740e5() {
  level endon("flg_chunnel_finale_snakecam_01_answer_given");
  wait 3;
  level.player dialogue::say_team("dx_sp_surg_ssoa_soap_givemesomethingsirth", 1);
}

function function_e607ac7b165d00cb() {
  var_83df368eecf3cea6 = [0, 1, 2, 3];
  var_83df368eecf3cea6 = utility::array_randomize(var_83df368eecf3cea6);
  var_1b8b2ec73f492162 = [ &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH1_OPTION1", &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH1_OPTION2", &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH1_OPTION3", &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH1_OPTION4"];
  var_1b8b2ec73f492162 = namespace_fc0114e844f0b4c::function_67f411b123f0cf9(var_83df368eecf3cea6, var_1b8b2ec73f492162);
  var_151363a8275820fb = ["dx_sp_surg_ssoa_pric_abearthatsthelogoont", "dx_sp_surg_ssoa_pric_logoisabear"];
  var_151362a827581ec8 = ["dx_sp_surg_ssoa_pric_atriangle"];
  var_151365a827582561 = ["dx_sp_surg_ssoa_pric_ablueflamethatsthelo", "dx_sp_surg_ssoa_pric_blueflameisthelogo"];
  var_151364a82758232e = ["dx_sp_surg_ssoa_pric_adogthatsthelogoonth", "dx_sp_surg_ssoa_pric_doglogoisadog"];
  playerdialoguelines = [var_151363a8275820fb[randomintrange(0, var_151363a8275820fb.size)], var_151362a827581ec8[0], var_151365a827582561[randomintrange(0, var_151365a827582561.size)], var_151364a82758232e[randomintrange(0, var_151364a82758232e.size)]];
  playerdialoguelines = namespace_fc0114e844f0b4c::function_67f411b123f0cf9(var_83df368eecf3cea6, playerdialoguelines);
  var_d9537912526addd1 = namespace_fc0114e844f0b4c::function_945718bb107da39e(playerdialoguelines, var_1b8b2ec73f492162, 15, 0, "flg_chunnel_finale_snakecam_01_answer_given");
  var_213f147e9d671a83 = var_83df368eecf3cea6[var_d9537912526addd1 - 1];
  return var_213f147e9d671a83;
}

function function_d74f405076865c15() {
  wait 0.3;
  playsoundatpos(level.player.origin, "minefield_click");
  wait 0.5;
}

function function_f1a20db8bdb4e9d3() {
  level endon("flag_chunnel_finale_wave_3_dead");
  level endon("flg_script_set_finale_wave_3_dead");
  animnode = self;
  thread function_c622369fc8cc021f();
  function_4256d29a648763ba();
  var_e4f5c03ff0af628e = [[level.ai_soap, 0.2, "dx_sp_surg_ssoa_soap_itllblowifiletgocapt"], [level.player, 0.2, "dx_sp_surg_ssoa_pric_fuuuckbravoweneedsup"], [level.var_351f8aca05656919, 0.4, "dx_sp_surg_ssoa_gazz_werepinneddowncapkon"], [level.player, 0.2, "dx_sp_surg_ssoa_pric_pushthroughem"]];
  level dialogue::say_sequence(var_e4f5c03ff0af628e, 2, 0, 0, 0, "team");
  thread function_287cfa9abfa54df8();
  wait 7;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag01");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_finishemsir", 1);
  wait 7;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag04");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_clearemoutcaptain", 1);
  wait 8.2;
  level utility::flag_set("flg_cannot_save_start");
  wait 10.3;
  thread function_4fec720fd51f5ca9("flg_snakecam_first_enter_timeout");
}

function function_c622369fc8cc021f() {
  level endon("flag_chunnel_finale_wave_3_dead");
  level endon("flg_script_set_finale_wave_3_dead");
  level utility::waittill_dead_or_dying(level.var_3ef7ae4c51bb3ec6, level.var_3ef7ae4c51bb3ec6.size - 1);
  wait 1.5;
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_pric_oneleftalmostclear", 0, 0.5);
}

function function_287cfa9abfa54df8() {
  level endon("flag_chunnel_finale_wave_3_dead");
  level endon("flg_script_set_finale_wave_3_dead");
  count = 0;

  while(count < 2) {
    level.player utility::waittill_any_timeout_1(3, "weapon_fired");
    wait 1;

    if(utility::flag("flag_chunnel_finale_wave_3_dead") || utility::flag("flg_script_set_finale_wave_3_dead")) {
      return;
    }

    if(count == 0) {
      level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_keepemoffmecaptain", 0);
      level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_pric_staydownsergeant", 0);
      wait randomfloatrange(5, 8);
    } else {
      level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_icandothissircoverme", 0);
      level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_pric_imonem", 0);
    }

    count += 1;
    wait 1;
  }
}

function function_9081dca75d5597fa() {
  level endon("flg_third_bomb_interact_complete");
  animnode = self;
  level.player namespace_7c8eb980997d0c0f::function_fc0eb6b81c66c661(1, "dx_sp_surg_ssoa_pric_wereclearpoliceareki", 2);
  wait 0.5;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag01");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_lessthanaminuteleftc", 2);
  wait 8.5;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag02");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_werelosingtimecaptai", 2);
  wait 8.6;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag03");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_timerscoutindownlets", 2);
  wait 8.2;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag04");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_wererunningoutoftime_01", 2);
  wait 7.5;
  animnode thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_nag05");
  level.ai_soap dialogue::say_team("dx_sp_surg_ssoa_soap_ineedyoureyesonthatc", 2);
  wait 8;
  animnode thread function_4fec720fd51f5ca9("flg_snakecam_first_enter_timeout", 1);
}

function function_7cefb308a23b7659() {
  level endon("flag_defusal_fail");
  level endon("flag_defusal_2_success");
  utility::autosave_by_name();
  function_4256d29a648763ba();
  var_b4133984a5178648 = [[level.var_292c01a9cd0b2818, 0.6, "dx_sp_surg_ssoa_ghos_07tosixwerepunchingt"], [level.player, 0.2, "dx_sp_surg_ssoa_pric_gethere"], [level.player, 0.6, "dx_sp_surg_ssoa_pric_whatsnextsoap"], [level.player, 0.5, "dx_sp_surg_ssoa_soap_locatetheblastingcap"]];
  level dialogue::say_sequence(var_b4133984a5178648, 2, 0, 0, 0, "team");
  var_15d48365e45fedfc = getStruct("s_bomb_serial_num", "targetname");

  if(!isDefined(var_15d48365e45fedfc)) {
    var_15d48365e45fedfc = spawnStruct();
    var_15d48365e45fedfc.origin = (-54102.8, 60321.8, 484.5);
  }

  var_15d48365e45fedfc thread function_45a191c0ccc354f0("flag_defusal_2_success");
  msg = utility::flag_wait_any_return("flg_bomb_puzzle_spotted", "flg_bomb_puzzle_search_timeout");

  if(msg == "flg_bomb_puzzle_search_timeout") {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_bloodyhellweretoolat", 3);
    utility::flag_set("flag_defusal_fail");
    return;
  }

  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_pric_copyblastingcapattac", 2);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_ayetheresaserialnumb", 2);
  level thread function_af605055f4473a4c();
  var_213f147e9d671a83 = function_ec88473743bbf110();

  if(!isDefined(var_213f147e9d671a83)) {
    level.ai_soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_soap_bloodyhellweretoolat", 3);
    utility::flag_set("flag_defusal_fail");
    return;
  }

  switch (var_213f147e9d671a83) {
    case 2:
      level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_soap_copygoodworkthisbomb", 2);
      level.player setsoundsubmix("sp_jup_surg_chunnel_finale_mix_makarov_shot");
      utility::flag_set("flag_defusal_2_success");
      break;
    case 0:
    case 1:
    case 3:
    default:
      level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_ssoa_soap_copystandby", 2);
      wait 0.5;
      utility::flag_set("flag_defusal_fail");
      return;
  }
}

function function_af605055f4473a4c() {
  level endon("flg_chunnel_finale_snakecam_02_answer_given");
  wait 3;
  level.player dialogue::say_team("dx_sp_surg_ssoa_soap_thirdnumbercaptainfi", 1);
}

function function_ec88473743bbf110() {
  var_30f7cf84cdc85242 = [0, 1, 2, 3];
  var_30f7cf84cdc85242 = array_randomize(var_30f7cf84cdc85242);
  var_1b8b2ec73f492162 = [ &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH2_OPTION1", &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH2_OPTION2", &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH2_OPTION3", &"SP_JUP_SURGE/CHUNNEL_BOMB_DEFUSE_DIALOG_BRANCH2_OPTION4"];
  var_1b8b2ec73f492162 = function_67f411b123f0cf9(var_30f7cf84cdc85242, var_1b8b2ec73f492162);
  var_151363a8275820fb = ["dx_sp_surg_ssoa_pric_thirdnumbersasix", "dx_sp_surg_ssoa_pric_numbersix"];
  var_151365a827582561 = ["dx_sp_surg_ssoa_pric_thethirdnumberisanin", "dx_sp_surg_ssoa_pric_numbernine"];
  var_151362a827581ec8 = ["dx_sp_surg_ssoa_pric_thirdnumberisafive", "dx_sp_surg_ssoa_pric_itsafive"];
  var_151364a82758232e = ["dx_sp_surg_ssoa_pric_thethirdnumberisaone", "dx_sp_surg_ssoa_pric_oneitsaone"];
  playerdialoguelines = [var_151363a8275820fb[randomintrange(0, var_151363a8275820fb.size)], var_151362a827581ec8[randomintrange(0, var_151362a827581ec8.size)], var_151365a827582561[randomintrange(0, var_151365a827582561.size)], var_151364a82758232e[randomintrange(0, var_151364a82758232e.size)]];
  playerdialoguelines = function_67f411b123f0cf9(var_30f7cf84cdc85242, playerdialoguelines);
  var_d9537912526addd1 = function_945718bb107da39e(playerdialoguelines, var_1b8b2ec73f492162, 15, 0, "flg_chunnel_finale_snakecam_02_answer_given");
  var_213f147e9d671a83 = var_30f7cf84cdc85242[var_d9537912526addd1 - 1];
  return var_213f147e9d671a83;
}

function function_ef8381859b661508() {
  thread function_582c8ff6886854cb();
  thread autosave_by_name();
  utility::flag_wait("flg_door_closed");
  level.ai_ghost dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_surg_ssoa_ghos_bloodyhell", 2);
}

function function_582c8ff6886854cb() {
  setmusicstate("mx_surge_soap");
}

function function_ca3c3c9efac4f12() {
  level.ai_makarov waittill("konni_call_out");
  utility::flag_set("flg_price_hand_crush");

  while(!isDefined(level.var_fc28037722b41a8a)) {
    waitframe();
  }

  utility::battlechatter_off("axis");
  level.var_fc28037722b41a8a endon("death");
  level.var_fc28037722b41a8a endon("entitydeleted");
  wait 1.25;
  level.var_fc28037722b41a8a dialogue::say("dx_sp_surg_ssoa_kon1_enemysmovingup", 0);
  wait 0.5;
  level.var_fc28037722b41a8a dialogue::say("dx_sp_surg_hcqc_kon1_openingheavyfire", 0);
  wait 1.2;
  level.var_fc28037722b41a8a dialogue::say("dx_sp_surg_ssoa_kon3_igotyoumove", 0);
  wait 2.5;
  level.var_fc28037722b41a8a dialogue::say("dx_sp_surg_hcqc_kon1_slowthemdown", 0);
  utility::battlechatter_on("axis");
}

function function_b4f901f92a5157d4() {
  level.ai_ghost waittill("ghost_calling_johnny");
  utility::battlechatter_on("axis");
  level.ai_ghost dialogue::say_team("dx_sp_surg_ssoa_ghos_johnny", 2);
  utility::flag_wait("flg_final_defuse_interact_triggered");
  level.var_d18d63c6d75cd1e waittill("outro_price_final_comms");
  wait 7.25;
  level.var_f76b2ac280893f92 thread scene::play(undefined, undefined, undefined, 0.1);
}

function function_b0229a7f1a5b90c8() {
  level endon("flg_final_defuse_interact_triggered");
  b_repeat = 1;
  animnode = self;

  while(b_repeat == 1 && isDefined(level.ai_soap)) {
    var_865048328835e385 = utility::within_fov_of_players(level.ai_soap getEye(), cos(45));

    if(isDefined(level.ai_soap)) {
      var_ac080aa961b986fe = level.player utility::can_trace_to_ai(level.player getEye(), level.ai_soap);

      if(flag("flg_gaz_nag3")) {
        b_repeat = 0;
      } else if((flag("flg_gaz_nag1") || flag("flg_gaz_nag2")) && istrue(var_865048328835e385) && istrue(var_ac080aa961b986fe)) {
        level flag_set("flg_soap_dead_remind");
        b_repeat = 0;
      }
    }

    wait 1;
  }
}

function function_e7f1c451b53b8ad2() {
  level endon("flg_final_defuse_interact_triggered");
  animnode = self;
  animnode thread function_b0229a7f1a5b90c8();
  wait 3;
  level flag_set("flg_gaz_nag1");
  wait 2;

  if(!flag("flg_soap_dead_remind")) {
    animnode thread scene::play(level.var_d18d63c6d75cd1e, "nag1");
    wait 5.5;
  } else {
    animnode thread scene::play(level.var_d18d63c6d75cd1e, "nag3_alt");
    level flag_clear("flg_soap_dead_remind");
    wait 6.9;
  }

  level flag_set("flg_gaz_nag2");
  wait 1;

  if(!flag("flg_soap_dead_remind")) {
    animnode thread scene::play(level.var_d18d63c6d75cd1e, "nag2");
    wait 4.5;
  } else {
    animnode thread scene::play(level.var_d18d63c6d75cd1e, "nag3_alt");
    level flag_clear("flg_soap_dead_remind");
    wait 6.9;
  }

  level flag_set("flg_gaz_nag3");
  animnode thread scene::play(level.var_d18d63c6d75cd1e, "nag3");
  wait 6.3;
  utility::flag_set("flg_snakecam_first_enter_timeout");
  level thread function_810d67576ecea89c();
}

function function_be9033d931c1127e() {
  level endon("flg_play_outro_time");
  animnode = self;
  wait 4;
  animnode thread scene::play(level.var_d18d63c6d75cd1e, "scene_nag2");
  level.var_d18d63c6d75cd1e dialogue::say_team("dx_sp_surg_ssoa_gazz_5secondscapcomeon", 1);
  wait 3;
  level thread function_810d67576ecea89c();
}