/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_f8531dcf975a7a7.gsc
************************************************/

#using script_1031976741eb6674;
#using script_60add030ce1a42b6;
#using scripts\anim\dialogue;
#using scripts\asm\gesture;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player;
#using scripts\sp\starts;
#namespace namespace_191bb1c1589b3acb;

function function_b85fe24f0a9139b2() {}

function function_c7c0ef06bcce6c3b() {
  if(!isDefined(level.var_64c093dc497ce423)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_tund_shpy_pric_threatneutralized";
    aliases[aliases.size] = "dx_sp_tund_shpy_pric_thatonesonme";
    aliases[aliases.size] = "dx_sp_tund_shpy_pric_eliminated";
    level.var_64c093dc497ce423 = utility::create_deck(aliases, 1, 1);
  }

  function_2bda02148fd703a4();
}

function function_2bda02148fd703a4() {
  if(!isDefined(level.var_9a1fe91cdb332423)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_tund_shpy_fara_goodhitcaptain";
    aliases[aliases.size] = "dx_sp_tund_shpy_fara_goodeffectactual";
    aliases[aliases.size] = "dx_sp_tund_shpy_fara_goodkillcaptain";
    aliases[aliases.size] = "dx_sp_tund_lmtp_fara_goodworkbravo";
    level.var_9a1fe91cdb332423 = utility::create_deck(aliases, 1, 1);
  }

  if(!isDefined(level.var_a6e75687fccaf576)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_tund_shpy_soap_rightontargetcaptain";
    aliases[aliases.size] = "dx_sp_tund_shpy_soap_goodhitsix";
    aliases[aliases.size] = "dx_sp_tund_shpy_soap_niceshotsir";
    aliases[aliases.size] = "dx_sp_tund_shpy_soap_quickanddirtycaptain";
    level.var_a6e75687fccaf576 = utility::create_deck(aliases, 1, 1);
  }

  if(!isDefined(level.var_73375e405a553918)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_tund_fnsn_ghos_niceshot";
    aliases[aliases.size] = "dx_sp_tund_fnsn_ghos_nicework";
    aliases[aliases.size] = "dx_sp_tund_fnsn_ghos_niceone";
    level.var_73375e405a553918 = utility::create_deck(aliases, 1, 1);
  }
}

function function_76a28ae3797d3180(endon_flag) {
  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  level childthread function_57c2f7c3cbeadee3();

  if(!isDefined(level.var_b0a223de1a3b70b0)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_tglb_gazz_weshouldpushtoexfilc"];
    nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_tglb_gazz_exfilwindowisclosing"];
    nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_tglb_fara_exfilisthisway"];
    nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_tglb_fara_wedonthavemuchtime"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_tglb_soap_ghostswaitingatexfil"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_tglb_soap_exfilisntfarsir"];
    level.var_b0a223de1a3b70b0 = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632([endon_flag, "flag_tundra_stop_nags"], level.var_b0a223de1a3b70b0, dialogue::growing_delay(20, 50, 3), 20);
}

function function_62cbcbc0416f8d46() {
  if(!isDefined(level.var_6d36831c89f604fd)) {
    level.var_6d36831c89f604fd = spawnStruct();
    level.var_6d36831c89f604fd.var_8b2fa2dfaf24943b = utility::create_deck(["dx_sp_tund_fw1n_gazz_armoronthehelostoost", "dx_sp_tund_fw1n_gazz_letssaveourbulletsfo", "dx_sp_tund_fw1n_gazz_thatdbeahellofashotc"], 1, 1);
    level.var_6d36831c89f604fd.soap_deck = utility::create_deck(["dx_sp_tund_fw1n_soap_wedonthavetherangeon", "dx_sp_tund_fw1n_soap_nousecaptainhelostoo", "dx_sp_tund_fw1n_soap_wedonthavetherangeca"], 1, 1);
  }

  if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 1.5)) {
    return;
  }

  a_ai_allies = [level.gaz, level.soap];
  ai_ally = utility::random(a_ai_allies);

  switch (ai_ally.animname) {
    case #"hash_df31f98a0b34e496":
      soap_vo = level.var_6d36831c89f604fd.soap_deck utility::deck_draw();
      level.soap dialogue::say_team(soap_vo, 0, 2.5);
      break;
    case #"hash_fb36726c0708cd6d":
    default:
      var_dcf900fef166fcf9 = level.var_6d36831c89f604fd.var_8b2fa2dfaf24943b utility::deck_draw();
      level.gaz dialogue::say_team(var_dcf900fef166fcf9, 0, 2.5);
      break;
  }
}

function function_84746c3250d67674() {
  level endon("flag_finale_holdout_complete");

  while(true) {
    if(function_5fce20631feac9db()) {
      if(namespace_8339f6377b6ba60e::function_7ed882d913504342()) {
        if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 3)) {
          wait 3;
          continue;
        }
      } else if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 10)) {
        wait 10;
        continue;
      }

      function_8ca6116b32daa869();
    }

    wait 10;
  }
}

function function_5fce20631feac9db() {
  threshhold = 0.2;

  foreach(weapon in level.player.primaryweapons) {
    fract = level.player getfractionmaxammo(weapon);

    if(fract < threshhold && level.player.currentweapon == weapon) {
      return true;
    }
  }

  return false;
}

function function_8ca6116b32daa869() {
  level.player endon("death");
  level endon("flag_finale_holdout_complete");
  level endon("flag_finale_holdout_final_enemies_all_dead");

  if(!isDefined(level.var_2c2590f0d2550d58) && !isDefined(level.var_12e50e3f1d544742)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_tund_tglb_pric_lowammo";
    aliases[aliases.size] = "dx_sp_tund_tglb_pric_almostout";
    aliases[aliases.size] = "dx_sp_tund_tglb_pric_lastmag";
    level.var_2c2590f0d2550d58 = utility::create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_sp_tund_tglb_soap_ivegotammo";
    aliases[aliases.size] = "dx_sp_tund_tglb_soap_ammohere";
    aliases[aliases.size] = "dx_sp_tund_tglb_soap_ihaveammohere";
    level.var_12e50e3f1d544742 = utility::create_deck(aliases, 1, 1);
  }

  if(!istrue(level.var_12f33df25cebe4ca)) {
    level.var_12f33df25cebe4ca = 1;
    var_62263695c36ae347 = level.var_2c2590f0d2550d58 utility::deck_draw();
    level.player dialogue::say_team(var_62263695c36ae347, 0, 2);
    var_5eab947d04603099 = level.var_12e50e3f1d544742 utility::deck_draw();
    level.soap dialogue::say_delayed(1, var_5eab947d04603099, 0, 2);
    wait 60;
    level.var_12f33df25cebe4ca = 0;
  }
}

function function_e134158b8d96fa58() {
  if(isDefined(level.var_bd555fa10c4b7506) && isarray(level.var_bd555fa10c4b7506)) {
    foreach(flag_endon in level.var_bd555fa10c4b7506) {
      if(utility::flag_exist(flag_endon) && utility::flag(flag_endon)) {
        return 0;
      }
    }

    return;
  }

  if(isDefined(level.var_bd555fa10c4b7506) && utility::flag_exist(level.var_bd555fa10c4b7506) && utility::flag(level.var_bd555fa10c4b7506)) {
    return 0;
  }
}

function function_7ecaf0dfe8277c39() {
  level endon("flag_finale_exfil_outro_begin");

  while(true) {
    level waittill("stop_tundra_nags");
    utility::flag_set("flag_tundra_stop_nags");
    wait 1;
    utility::flag_clear("flag_tundra_stop_nags");
  }
}

function function_fbab3cc861e5f296(flg_endon) {
  level.player endon("death");
  level endon("flag_finale_exfil_outro_begin");

  if(isDefined(flg_endon)) {
    if(level utility::flag(flg_endon)) {
      return;
    }

    level endon(flg_endon);
  }

  while(level.player dialogue::function_d871f93553913276()) {
    wait 0.5;
  }
}

function function_f64c0d41b6e08572() {}

function function_d97b579a3a1f8fb7() {}

function function_97e97294517bbc58() {
  while(!isDefined(level.ally01) || !isDefined(level.ally02)) {
    waitframe();
  }

  level thread function_bf2eb3cc02fc7a61();
  level thread function_8821596729114cbf();
  level thread function_bdad42f519cc6240();
  level thread function_7ecaf0dfe8277c39();
}

function function_bf2eb3cc02fc7a61() {
  level endon("lake_rescue_complete");
  utility::flag_wait("dof_before_trigger_ready");
  level.ally01 dialogue::function_fc0eb6b81c66c661(2, "dx_sp_tund_ldet_gazz_solidheretheycome", 2, 0);
  utility::flag_wait("flag_lake_detonate_triggered");
  level.player enableplayerbreathsystem(0);
  level.player dialogue::say_team("dx_sp_tund_ldet_pric_fireinthehole", 2, 0);
}

function function_8821596729114cbf() {
  level endon("lake_rescue_complete");
  utility::flag_wait("flag_lake_detonate_success");
  thread function_249b5cdd98d6643b();
  var_b8619477773c8a7f = [[level.ally02, 0.1, "dx_sp_tund_lkmn_soap_allstationsgoodeffec"], [level.laswell, 0.2, "dx_sp_tund_lkmn_lasw_roggotoworkweneedhim"], [level.player, 0.2, "dx_sp_tund_lkmn_pric_onthemovesoapgazflan"], [level.ally01, 0.1, "dx_sp_tund_lkmn_gazz_targetvehiclestakino"]];
  level.player enableplayerbreathsystem(0);
  level dialogue::function_c9a09b3ba9c68f8d(1.8, var_b8619477773c8a7f, 1);
}

function function_249b5cdd98d6643b() {
  wait 3;
  setmusicstate("mx_tundra_lakedetonate");
}

function function_bdad42f519cc6240() {
  level endon("lake_rescue_complete");
  var_26979b581cf7b1ea = [];
  var_26979b581cf7b1ea[var_26979b581cf7b1ea.size] = "dx_sp_tund_ldet_soap_allstationsnojoynega";
  var_26979b581cf7b1ea[var_26979b581cf7b1ea.size] = "dx_sp_tund_ldet_gazz_wemisseditwindowsclo";
  var_26979b581cf7b1ea[var_26979b581cf7b1ea.size] = "dx_sp_tund_ldet_soap_bravotowatchernoeffe";
  react_deck = utility::create_deck(var_26979b581cf7b1ea, 1, 1);
  level waittill("detonation_fail");
  react_vo = react_deck utility::deck_draw();
  level.ally01 dialogue::say_team(react_vo);
}

function function_a58158582ad72a2b() {}

function function_3ccba704d29f93e4() {
  level thread function_3485575a37b7e014();
  level thread function_ee6ccc91cf75e889();
  var_af36b904b56328b7 = getEntArray("trig_tundra_dynamic_oob", "script_noteworthy");
  utility::array_thread(var_af36b904b56328b7, &function_541d7d0035c0e6f8);
  level set_nagvars(0, 2, 0, "team");
}

function function_3485575a37b7e014() {
  level endon("flag_player_reached_final_vehicle");
  utility::flag_wait("flg_lake_soap_takedown_complete");
  level.ally02 dialogue::say_team("dx_sp_tund_lkmn_soap_vehiclesclearnomakar");
  utility::flag_wait("flg_lake_gaz_takedown_complete");
  level.ally01 dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_lkmn_gazz_vehicleclearedmoving");
}

function function_ee6ccc91cf75e889() {
  level endon("flag_player_reached_final_vehicle");
  level endon("flag_allies_reached_final_vehicle");
  utility::flag_wait("lake_detonate_complete");
  wait 3;
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.ally01, "dx_sp_tund_lkmn_gazz_targetsairhasgottabe"];
  nag_aliases[nag_aliases.size] = [level.ally02, "dx_sp_tund_lkmn_soap_gottamoveontargetcap"];
  nag_aliases[nag_aliases.size] = [level.ally02, "dx_sp_tund_lkmn_soap_actuallovetolethimdr"];
  nag_aliases[nag_aliases.size] = [level.ally01, "dx_sp_tund_lkmn_gazz_wererunningoutoftime"];
  nag_deck = utility::create_deck(nag_aliases);
  dialogue::function_91c23782840cf632(["flag_player_reached_final_vehicle", "flag_allies_reached_final_vehicle", "flag_tundra_stop_nags"], nag_aliases, 7, 10);
}

function function_541d7d0035c0e6f8() {
  level endon("lake_rescue_complete");
  level endon("tundra_underwater_rescue_fail");

  while(!flag("targetExtract")) {
    if(level.player istouching(self)) {
      function_33e8c9ea0a5002f1();
      wait randomfloatrange(5, 10);
    }

    wait 1;
  }
}

function function_33e8c9ea0a5002f1() {
  level endon("lake_rescue_complete");

  if(utility::flag("lake_rescue_complete")) {
    return;
  }

  if(!isDefined(level.var_65c0e28903410f7d)) {
    var_d065dbd346f00c55 = [];
    var_d065dbd346f00c55[var_d065dbd346f00c55.size] = "dx_sp_tund_lkmn_gazz_sixstaywithus";
    var_d065dbd346f00c55[var_d065dbd346f00c55.size] = "dx_sp_tund_lkmn_soap_bravo6clockstickinwe";
    var_d065dbd346f00c55[var_d065dbd346f00c55.size] = "dx_sp_tund_lkmn_gazz_capthirdvehicleletsh";
    level.var_65c0e28903410f7d = utility::create_deck(var_d065dbd346f00c55, 1, 1);
  }

  react_vo = level.var_65c0e28903410f7d utility::deck_draw();
  level.ally01 dialogue::function_fc0eb6b81c66c661(0.1, react_vo, 0, 2.5);
}

function function_e118b366b72babfa() {
  level endon("flg_prisoner_location_revealed");
  level endon("lake_rescue_complete");
  react_aliases = [];
  react_aliases[react_aliases.size] = "dx_sp_tund_lkmn_pric_targetsnotinthisvehi";
  react_aliases[react_aliases.size] = "dx_sp_tund_lkmn_pric_nomakarovhere";
  react_aliases[react_aliases.size] = "dx_sp_tund_lkmn_pric_vehicleclearnegative";
  react_deck = utility::create_deck(react_aliases, 1, 1);

  while(true) {
    level.player waittill("msg_underwater_vehicle_checked");
    level.player enableplayerbreathsystem(0);
    react_vo = react_deck utility::deck_draw();
    level.player dialogue::function_fc0eb6b81c66c661(0.2, react_vo, 0, 2);
    waitframe();
  }
}

function function_c77070dbbb9d7929() {}

function function_1a381685fafc883d() {
  level thread function_6e36b4c882b58810();
  level thread function_61ddcc6c631c44bc();
  level thread function_117a7e7c74fc8e94();
  level thread function_8ff41fdf83c7d23e();
  level set_nagvars(0, 3, 0, "team");
  utility::flag_wait("lake_rescue_complete");
  level utility::flag_set("flag_lake_oob");
}

function function_6e36b4c882b58810() {
  level endon("flag_allies_reached_final_vehicle");
  level endon("lake_rescue_complete");
  var_9b821ce1c6e92a09 = getStruct("start_scene_interact_break_window", "targetname");

  while(distance(level.player.origin, var_9b821ce1c6e92a09.origin) > 50) {
    waitframe();
  }

  level notify("stop_tundra_nags");
  utility::flag_set("flg_prisoner_location_revealed");
  utility::flag_set("flag_player_reached_final_vehicle");
  level.player enableplayerbreathsystem(0);
  level.player dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_tund_lrsc_pric_negativeontargetnoma", 2);
  level.ally02 dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_tund_lrsc_soap_rog", 2);
  utility::flag_set("flag_rescue_prisoner_obj_show");
  level thread function_8864abc30929392d();
  level thread function_ea00bc8f3d50e89d();
}

function function_61ddcc6c631c44bc() {
  level endon("flag_player_reached_final_vehicle");
  level endon("lake_rescue_complete");
  utility::flag_wait_all("flg_ally01_reached_vip_veh", "flg_ally02_reached_vip_veh");
  level notify("stop_tundra_nags");
  utility::flag_set("flg_prisoner_location_revealed");
  utility::flag_set("flag_allies_reached_final_vehicle");
  function_fbab3cc861e5f296("lake_rescue_complete");
  var_b4dc69701390312c = [[level.ally01, 0.2, "dx_sp_tund_lrsc_gazz_capwegotaproblem"], [level.ally02, 0.2, "dx_sp_tund_lrsc_soap_nomakarovjustaprison"], [level.player, 0.2, "dx_sp_tund_lrsc_pric_pullhimletsgo"], [level.ally02, 0.1, "dx_sp_tund_lrsc_soap_rog"]];
  level.player enableplayerbreathsystem(0);
  level dialogue::say_sequence(var_b4dc69701390312c, 2);
  utility::flag_set("flag_rescue_prisoner_obj_show");
  level thread function_8864abc30929392d();
  level thread function_ea00bc8f3d50e89d();
}

function function_8864abc30929392d() {
  level endon("targetExtract");
  level endon("lake_rescue_complete");
  level endon("tundra_underwater_rescue_fail");

  if(utility::flag("targetExtract") || utility::flag("lake_rescue_complete")) {
    return;
  }

  var_ca712665096e8a75 = getEnt("t_uw_ambush_prisoner_vehicle_right_side", "targetname");

  while(true) {
    if(level.player istouching(var_ca712665096e8a75)) {
      level.ally02 dialogue::say_team("dx_sp_tund_lrsc_soap_prisonerisontheleftc", 1, 5);
      break;
    }

    waitframe();
  }
}

function function_ea00bc8f3d50e89d() {
  level endon("targetExtract");
  level endon("lake_rescue_complete");
  level endon("tundra_underwater_rescue_fail");

  if(utility::flag("targetExtract") || utility::flag("lake_rescue_complete")) {
    return;
  }

  var_832e913af9e959fa = [];
  var_832e913af9e959fa[var_832e913af9e959fa.size] = [level.ally01, "dx_sp_tund_lrsc_gazz_hesgonnadrownifwedon"];
  var_832e913af9e959fa[var_832e913af9e959fa.size] = [level.ally01, "dx_sp_tund_lrsc_gazz_hewontlastmuchlonger"];
  level.player dialogue::function_91c23782840cf632(["targetExtract", "tundra_underwater_rescue_fail"], var_832e913af9e959fa, dialogue::growing_delay(10, 20, 2), 10);
}

function function_117a7e7c74fc8e94() {
  level endon("lake_rescue_complete");
  var_ed0a251efc5cc1d9 = [];
  var_ed0a251efc5cc1d9[var_ed0a251efc5cc1d9.size] = "dx_sp_tund_lrsc_gazz_allstationsweretoola";
  var_ed0a251efc5cc1d9[var_ed0a251efc5cc1d9.size] = "dx_sp_tund_lrsc_gazz_allbravoprisonerisun";
  var_ed0a251efc5cc1d9[var_ed0a251efc5cc1d9.size] = "dx_sp_tund_lrsc_gazz_allstationsthisnetit";
  var_7da5323f250a134e = utility::create_deck(var_ed0a251efc5cc1d9, 1, 1);
  utility::flag_wait("tundra_underwater_rescue_fail");
  dialogue::function_cb329cf8896edeaa(level.player.team, 1, 1);
  react_vo = var_7da5323f250a134e utility::deck_draw();
  level.ally01 dialogue::say_team(react_vo, 3, 0);
}

function function_8ff41fdf83c7d23e() {
  level endon("lake_rescue_complete");
  level endon("tundra_underwater_rescue_fail");
  utility::flag_wait("targetExtract");
  wait 33;
  level.player enableplayerbreathsystem(0);
  level.player dialogue::say_team("dx_sp_tund_lrsc_pric_prisonersecuremoving", 1);
  level.laswell dialogue::say_team("dx_sp_tund_lrsc_lasw_standingby", 1);
}

function function_4d95517634b3f9db() {}

function function_420580be8bab7cfb(endon_flag) {
  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  level childthread function_57c2f7c3cbeadee3();

  if(!isDefined(level.var_cd168c0d50f811fd)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_fw1n_gazz_waitingonyousixwesho"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_sixweneedtogettothet"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_allbravoexfilvehicle"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_konniincomingwecantw"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_transportsjustaheadc"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_weshouldgettothetruc"];
    level.var_cd168c0d50f811fd = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632([endon_flag, "flag_tundra_stop_nags"], level.var_cd168c0d50f811fd, dialogue::growing_delay(25, 45, 3), 20);
}

function function_fdac326045e5d650(endon_flag) {
  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  level childthread function_57c2f7c3cbeadee3();

  if(!isDefined(level.var_c9740406fd3926ee)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_wegottahikeupriver"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_farahswaitingforusat"];
    nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_fw1n_gazz_captainweshouldkeepp"];
    nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_fw1n_gazz_lumbermillsforwardof"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_farahsheadedtothelum"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fw1n_soap_millsupriverfarahsth"];
    level.var_c9740406fd3926ee = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632([endon_flag, "flag_tundra_stop_nags"], level.var_c9740406fd3926ee, dialogue::growing_delay(20, 45, 5), 20);
}

function function_57c2f7c3cbeadee3() {
  var_cf8faeb902efc235 = [level.shepherd, level.soap, level.gaz];

  while(true) {
    var_867db576295c28e5 = utility::array_any_wait_return(var_cf8faeb902efc235, "started_nag");
    wait randomfloatrange(0.5, 1.5);

    if(isDefined(var_867db576295c28e5)) {
      if(utility::cointoss()) {
        var_867db576295c28e5 thread utility::gesture_follow_lookat(level.player);
        var_867db576295c28e5 waittill("nag_done_or_cancelled");
        wait randomfloatrange(0.1, 0.9);
        var_867db576295c28e5 utility::gesture_stop(1);
      } else {
        var_867db576295c28e5 thread gesture::ai_request_gesture("talk");
      }
    }

    wait 1;
  }
}

function function_46a5b8f15ad943a0() {}

function function_92796961c6647625() {
  level thread function_8945e857b602413f();
  level thread function_84746c3250d67674();
  level set_nagvars(0, 5, 0, "team");
}

function function_8945e857b602413f() {
  level.player endon("death");
  level endon("flag_forest_walk_complete");
  registered = "forest_initial_comms";
  level.player val::set(registered, "weapon_switch", 0);
  wait 1.8;
  level.player thread namespace_8339f6377b6ba60e::function_e0f99342614824c0("noncombat", 6);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_fw1i_pric_sixtowatcher", 1);
  level.laswell dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_fw1i_lasw_sendtrafficbravo", 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fw1i_pric_planistohoofittotran", 1);
  level.player thread namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();
  level.player val::set(registered, "weapon_switch", 1);
  thread function_28ff6f19886d9a88();
  var_6a00601ef605c1ad = [[level.laswell, 0.1, "dx_sp_tund_fw1i_lasw_ithinkyourguestmaysl", &function_e134158b8d96fa58], [level.soap, 0.2, "dx_sp_tund_fw1i_soap_laswellsright", &function_e134158b8d96fa58], [level.gaz, 0.2, "dx_sp_tund_fw1i_gazz_usuallyis", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = "flag_forest_walk_02";
  level dialogue::say_sequence(var_6a00601ef605c1ad, 1, 0, 0, 0, "team");
  level thread function_e8d25597dc20182e();
  level thread function_420580be8bab7cfb("flag_forest_walk_02");
}

function function_e8d25597dc20182e() {
  level.player endon("death");
  level endon("flag_forest_walk_complete");

  if(utility::flag("flag_forest_walk_complete")) {
    return;
  }

  utility::flag_wait("flag_forest_walk_02");
  level.soap dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_tund_fw1i_soap_fogsrollingin", 0, 5);
  level.gaz dialogue::function_fc0eb6b81c66c661(0.25, "dx_sp_tund_fw1i_gazz_goodtimeforthermalsi", 0, 5);

  if(function_fa4e3e5505164e66()) {
    function_c3d67a80d6ce5975();
  } else {
    level thread function_ac0f892dc9a90a8f();
  }

  level thread function_85faae27fbd59752();
  level thread function_f9ed316ebcef5da4();
}

function function_f9ed316ebcef5da4() {
  level.player endon("death");
  level endon("flag_forest_walk_player_thermal_used");
  level endon("flag_forest_walk_complete");

  if(utility::flag("flag_forest_walk_complete")) {
    return;
  }

  wait 5;

  if(utility::cointoss()) {
    level.gaz dialogue::say_team("dx_sp_tund_fw1i_gazz_thermalonbravo", 0, 2.5);
  } else {
    level.gaz dialogue::say_team("dx_sp_tund_fw1i_gazz_advisethermalcap", 0, 2.5);
  }

  wait 1.5;

  if(utility::cointoss()) {
    level.soap dialogue::say_team("dx_sp_tund_fw1i_soap_gazisrightusethermal", 0, [level, "flag_forest_walk_player_thermal_used"]);
    return;
  }

  level.soap dialogue::say_team("dx_sp_tund_fw1i_soap_uptoyousirbutthermal", 0, [level, "flag_forest_walk_player_thermal_used"]);
}

function function_85faae27fbd59752() {
  level.player endon("death");
  level endon("flag_forest_walk_complete");

  if(utility::flag("flag_forest_walk_complete")) {
    return;
  }

  vo_aliases = [];
  vo_aliases[vo_aliases.size] = "dx_sp_tund_shpy_pric_usingthermal";
  vo_aliases[vo_aliases.size] = "dx_sp_tund_shpy_pric_onthermal";
  vo_aliases[vo_aliases.size] = "dx_sp_tund_shpy_pric_thermalup";
  level utility::flag_wait("flag_forest_walk_player_thermal_used");
  level.player dialogue::function_fc0eb6b81c66c661(0.2, random(vo_aliases), 1, 2.5);
  level thread function_a42f347485fe5cde();
}

function function_a42f347485fe5cde() {
  level.player endon("death");
  level endon("flag_forest_walk_complete");

  if(utility::flag("flag_forest_walk_complete")) {
    return;
  }

  function_fbab3cc861e5f296("flag_forest_walk_complete");

  if(utility::flag("flag_forest_walk_04") || !function_50f6a8d179cd5108(768)) {
    level thread function_420580be8bab7cfb("flag_forest_walk_complete");
    return;
  }

  var_1d71cbe267b643cf = [[level.shepherd, 2, "dx_sp_tund_fw1i_shep_imfreezingmyassofher", &function_e134158b8d96fa58], [level.soap, 0.25, "dx_sp_tund_fw1i_soap_slightcaseohypotherm", &function_e134158b8d96fa58], [level.shepherd, 0.35, "dx_sp_tund_fw1i_shep_youneedadisciplinead", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = "flag_forest_walk_04";
  level dialogue::say_sequence(var_1d71cbe267b643cf, 0, 0, 0, 0, "team");

  if(!utility::flag("flag_forest_walk_04") && function_50f6a8d179cd5108(512)) {
    level.player dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_fw1i_pric_iwouldntpushhimgener", 0, 2.5);
  }

  level thread function_420580be8bab7cfb("flag_forest_walk_complete");
}

function function_c3d67a80d6ce5975() {
  if(!utility::flag("flag_forest_walk_player_thermal_used")) {
    level utility::flag_set("flag_forest_walk_player_thermal_hint");
    level.player thread utility::display_hint_forced("tundra_thermal_scope", 15, undefined, level, "flag_forest_walk_complete");
  }
}

function function_ac0f892dc9a90a8f() {
  level endon("flag_forest_walk_complete");
  level.player thread utility::display_hint_forced("tundra_switch_weapon", 15, undefined, level, "flag_forest_walk_complete");

  while(!function_fa4e3e5505164e66()) {
    waitframe();
  }

  level thread function_8711d5af7d8ba83();
  function_c3d67a80d6ce5975();
}

function function_8711d5af7d8ba83() {
  count = 15;

  while(count > 0) {
    if(!function_fa4e3e5505164e66()) {
      level.player notify("new_hint");
      break;
    }

    count--;
    wait 1;
  }
}

function function_28ff6f19886d9a88() {
  wait 5.5;
  setmusicstate("mx_tundra_forestwalkmoods");
}

function function_52cff14020bb80ae() {}

function function_14097a99fb04951c() {
  level thread function_c2824b7599758f42();
  level thread function_9412a9d1e456bc30();
  level thread function_af3973791657c8a7();
  level thread function_33513c0b3f7d0b1d();
  level thread function_cb9e1e84826db269();
  level set_nagvars(0, 5, 0, "team");
}

function function_c2824b7599758f42() {
  level notify("stop_tundra_nags");
  utility::battlechatter_off("axis");
  wait 1;
  ai_enemy = utility::get_closest_ai(level.soap.origin, "axis");
  level.soap thread gesture::ai_request_gesture("military_point", ai_enemy);
  level.soap dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_fnc1_soap_konihelodroppedinsom", 1);
  wait 1;
  function_32919758e14ba20e();
  level utility::flag_set("flag_forest_patrol_allies_use_colors");
}

function function_32919758e14ba20e() {
  level.player endon("death");

  if(utility::flag("flag_forest_patrol_combat") || utility::flag("flag_forest_patrol_enemies_curious")) {
    return;
  }

  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_curious");

  if(function_50f6a8d179cd5108(512)) {
    level.shepherd dialogue::say_team("dx_sp_tund_fnc1_shep_theyrelookingforme", 1);
    level.player dialogue::function_fc0eb6b81c66c661(0.35, "dx_sp_tund_fnc1_pric_gothalfamindtoletemf", 1);
  }

  level utility::flag_set("flag_forest_patrol_allies_use_colors");
  level utility::flag_wait_or_timeout("flag_forest_patrol_see_enemies", 5);
  level utility::flag_set("flag_forest_patrol_see_enemies");
  level thread function_fc9dd7bb3b5a6662();
  level thread function_9a47e690442788cc();
}

function function_9a47e690442788cc() {
  level.player endon("death");
  level endon("flag_forest_patrol_complete");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_passed");
  level endon("flag_forest_patrol_enemies_curious");
  level endon("flag_forest_patrol_enemies_approaching_right");

  if(utility::flag("flag_forest_patrol_combat") || utility::flag("flag_forest_patrol_enemies_curious") || utility::flag("flag_forest_patrol_complete")) {
    return;
  }

  wait 1;

  if(function_50f6a8d179cd5108(512)) {
    level.shepherd dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fnc1_shep_weshouldtakeemoutnow", 1);
    level.soap dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_tund_fnc1_soap_youshouldshutthehell", 1);
    level.gaz dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_fnc1_gazz_eitherwayweneedacall", 1);
  } else {
    level.gaz dialogue::say_team("dx_sp_tund_fnc1_gazz_whatsthecallcaptain", 1);
  }

  count = 0;

  while(count < 5) {
    if(level.player getstance() != "stand") {
      level.player dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_fnc1_pric_wecanstaylowletempas", 1, 2.5);
      level utility::flag_set("flag_forest_patrol_allies_stay_low");
      break;
    }

    count++;
    wait 0.5;
  }

  level thread function_fc9dd6bb3b5a642f();
  wait 8;

  if(function_50f6a8d179cd5108(384)) {
    level.shepherd dialogue::say_team("dx_sp_tund_fnc1_shep_shouldveengagedalrea", 0, 5);
    a_lines = [];
    a_lines[a_lines.size] = "dx_sp_tund_shpy_pric_gazshuthimup";
    a_lines[a_lines.size] = "dx_sp_tund_shpy_pric_putacorkinitgeneral";
    a_lines[a_lines.size] = "dx_sp_tund_shpy_pric_zipitshepherd";
    level.player dialogue::function_fc0eb6b81c66c661(0.3, random(a_lines), 0, 2.5);
  }
}

function function_fc9dd7bb3b5a6662() {
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_curious");

  if(utility::flag("flag_forest_patrol_combat") || utility::flag("flag_forest_patrol_enemies_curious")) {
    return;
  }

  wait 2.5;
  a_ai_enemies = utility::get_living_ai_array("ai_forest_patrol_enemy", "targetname");

  if(isDefined(a_ai_enemies[0]) && isalive(a_ai_enemies[0])) {
    a_ai_enemies[0] dialogue::say("dx_sp_tund_fnc1_kon1_theymustbeherekeeplo", 0, 2.5);
  }

  wait 1;

  if(isDefined(a_ai_enemies[1]) && isalive(a_ai_enemies[1])) {
    a_ai_enemies[1] dialogue::say("dx_sp_tund_fnc1_kon2_hardtofindanythingin", 0, 2.5);
  }
}

function function_fc9dd6bb3b5a642f() {
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_curious");

  if(utility::flag("flag_forest_patrol_combat") || utility::flag("flag_forest_patrol_enemies_curious")) {
    return;
  }

  wait 4;
  a_ai_enemies = utility::get_living_ai_array("ai_forest_patrol_enemy", "targetname");

  if(isDefined(a_ai_enemies[0]) && isalive(a_ai_enemies[0])) {
    a_ai_enemies[1] dialogue::say("dx_sp_tund_fnc1_kon2_letsmovefurthereast");
  }
}

function function_cbae8968087844c2() {
  self endon("death");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_curious");

  if(utility::flag("flag_forest_patrol_combat") || utility::flag("flag_forest_patrol_enemies_curious")) {
    return;
  }

  while(true) {
    id = self getinteractionid();

    if(isDefined(id)) {
      break;
    }

    wait 1;
  }

  wait 1;
  dialogue::say_delayed(2.5, "dx_sp_tund_fnc1_kon3_nomovementyetactual", 0, 5);
  wait 5;
  thread dialogue::say("dx_sp_tund_fnc1_kon3_copymovingeast", 0, 5);
}

function function_9412a9d1e456bc30() {
  level.player endon("death");
  level endon("flag_forest_sniper_warning_shot");
  level endon("flag_forest_sniper_complete");
  utility::flag_wait("flag_forest_patrol_combat");
  thread function_c637cfc5b5dc5808();
  utility::battlechatter_on("axis");

  if(!level utility::flag("flag_forest_patrol_enemies_one_dead") && !level utility::flag("flag_forest_patrol_enemies_one_damaged")) {
    wait 2;
  }

  wait 1;
  level.player dialogue::say_team("dx_sp_tund_ffld_pric_weaponsfree", 2);
  function_731e291e81856d27();

  if(utility::flag("flag_forest_patrol_enemies_behind_player")) {
    wait 2.5;

    if(!utility::flag("flag_forest_patrol_enemies_dead")) {
      level.gaz thread dialogue::say_delayed(0.2, "dx_sp_tund_fnc1_gazz_gothostilesclosingin", 0);
    }
  }

  utility::flag_wait("flag_forest_patrol_enemies_dead");
  function_fbab3cc861e5f296("flag_forest_patrol_complete");

  if(level utility::flag("flag_forest_patrol_complete")) {
    level.gaz dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_tund_fnc1_gazz_clear", 1);
    return;
  }

  if(function_50f6a8d179cd5108(512) && !level utility::flag("flag_forest_patrol_04")) {
    var_3d44035a5d6ad185 = [[level.soap, 0.8, "dx_sp_tund_fnc1_soap_enemiesdowncouldbemo", &function_e134158b8d96fa58], [level.player, 0.7, "dx_sp_tund_ffld_pric_canyoustillshootgene", &function_e134158b8d96fa58], [level.shepherd, 0.2, "dx_sp_tund_ffld_shep_doesapolarbearshitin", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_ffld_pric_makesureyouaimstraig", &function_e134158b8d96fa58], [level.shepherd, 0.3, "dx_sp_tund_ffld_shep_countonit", &function_e134158b8d96fa58]];
    level utility::flag_set("flag_forest_patrol_shepherd_still_shoot");
  } else {
    var_3d44035a5d6ad185 = [[level.gaz, 1, "dx_sp_tund_fnc1_gazz_clear", &function_e134158b8d96fa58], [level.gaz, 0.4, "dx_sp_tund_fnc1_gazz_whentheymisscheckins", &function_e134158b8d96fa58], [level.player, 0.5, "dx_sp_tund_fnc1_pric_letsnotbeherewhenthe", &function_e134158b8d96fa58]];
  }

  level.var_bd555fa10c4b7506 = "flag_forest_patrol_complete";
  level dialogue::say_sequence(var_3d44035a5d6ad185, 1, 0, 0, 0, "team");
  level thread function_420580be8bab7cfb("flag_forest_patrol_complete");
}

function function_731e291e81856d27() {
  level.player endon("death");
  level endon("flag_forest_sniper_warning_shot");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_warning_shot") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  count = 0;

  if(flag("flag_forest_patrol_enemies_passing_left")) {
    var_c669baa85e21ef55 = utility::get_living_ai_array("ai_forest_patrol_enemy_left", "script_noteworthy");

    foreach(enemy in var_c669baa85e21ef55) {
      if(!istrue(enemy ent_flag("flag_forest_patrol_enemy_passed"))) {
        count++;
      }
    }
  }

  if(count > 1) {
    flag_set("flag_forest_patrol_enemies_behind_player");
  }
}

function function_c637cfc5b5dc5808() {
  stopmusicstate("mx_tundra_forestwalkmoods");
}

function function_cb9e1e84826db269() {
  level.player endon("death");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_complete");
  utility::flag_wait("flag_forest_patrol_enemies_passed");
  level.soap dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_fnc1_soap_theyremovingonweclea", 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_fnc1_pric_clear", 1);
  utility::flag_set("flag_forest_patrol_allies_exit");

  if(!function_50f6a8d179cd5108(512)) {
    return;
  }

  level.var_bd555fa10c4b7506 = ["flag_forest_patrol_combat", "flag_forest_patrol_complete"];
  function_fbab3cc861e5f296("flag_forest_patrol_complete");

  if(utility::flag("flag_forest_patrol_04")) {
    var_526a6327f20b0319 = [[level.shepherd, 0.2, "dx_sp_tund_fnc1_shep_shouldvekilledthemwh", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_fnc1_pric_ifiwantyouradviceill", &function_e134158b8d96fa58]];
    level dialogue::say_sequence(var_526a6327f20b0319, 0, 0, 0, 0, "team");
  } else {
    var_526a6327f20b0319 = [[level.shepherd, 0.2, "dx_sp_tund_fnc1_shep_shouldvekilledthemwh", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_fnc1_pric_ifiwantyouradviceill", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_fnc1_pric_letsnotforget", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_fnc1_pric_wewouldntbehereifyou", &function_e134158b8d96fa58]];
    level dialogue::say_sequence(var_526a6327f20b0319, 0, 0, 0, 0, "team");

    if(!function_50f6a8d179cd5108(512)) {
      return;
    }

    var_8575c59761b2a19d = [[level.shepherd, 0.3, "dx_sp_tund_fnc1_shep_igotcaughtbecauseiwa", &function_e134158b8d96fa58], [level.gaz, 0.3, "dx_sp_tund_fnc1_gazz_wouldntbetooproudoth", &function_e134158b8d96fa58], [level.soap, 0.2, "dx_sp_tund_fnc1_soap_ideaistogetclosewith", &function_e134158b8d96fa58]];
    level dialogue::say_sequence(var_8575c59761b2a19d, 0, 0, 0, 0, "team");
  }

  level thread function_420580be8bab7cfb("flag_forest_patrol_complete");
}

function function_33513c0b3f7d0b1d() {
  level.player endon("death");
  level endon("flag_forest_patrol_complete");
  level endon("flag_forest_patrol_combat");
  utility::flag_wait("flag_forest_patrol_enemies_curious");
  dialogue::function_cb329cf8896edeaa(level.player.team, 1, 1);

  if(utility::cointoss()) {
    level.gaz dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_fnc1_gazz_theyheardus", 1);
  } else {
    level.gaz dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_fnc1_gazz_theyreonalert", 1);
  }

  wait 1;

  if(utility::cointoss()) {
    level.soap dialogue::function_fc0eb6b81c66c661(1.5, "dx_sp_tund_fnc1_soap_theydontseeusbutthey", 1);
    return;
  }

  level.soap dialogue::function_fc0eb6b81c66c661(1.5, "dx_sp_tund_fnc1_soap_stayhiddenunlessweag", 1);
}

function function_af3973791657c8a7() {
  level.player endon("death");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_complete");
  utility::flag_wait("flag_forest_patrol_enemies_approaching_right");

  if(!utility::flag("flag_forest_player_left")) {
    level.soap dialogue::say_team("dx_sp_tund_fnc1_soap_gotanothersquadclosi", 1);
    utility::flag_wait("flag_forest_patrol_left");
    level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_fvta_pric_onme", 1);
  }
}

function function_d1d6cb50dde5b880() {}

function function_f19c04049620116f() {
  level thread function_711f7b29f32e72ac();
  level thread function_657aa2c319769ae1();
  level thread function_c5202f1255aaa90e();
  level set_nagvars(0, 5, 0, "team");
}

function function_1c647c1a523facb5() {
  level notify("stop_tundra_nags");

  if(!function_50f6a8d179cd5108(768)) {
    return;
  }

  if(level utility::flag("flag_forest_patrol_combat") && !level utility::flag("flag_forest_patrol_enemies_dead")) {
    return;
  }

  level.shepherd dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_fspr_shep_howfaristhetransport", 1);
}

function function_711f7b29f32e72ac() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");
  level utility::flag_wait("flag_forest_sniper_warning_shot");
  thread function_d788201477b217ab();
  level utility::flag_set("flag_forest_sniper_allies_get_down");
  wait 0.3;

  if(level utility::flag("flag_forest_patrol_combat") && !level utility::flag("flag_forest_patrol_enemies_dead")) {
    level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_pric_sniper", 2, 0.5);
    wait 1.5;

    if(!utility::flag("flag_forest_patrol_enemies_dead")) {
      level.gaz thread dialogue::say_team("dx_sp_tund_fnc1_gazz_konnispunchingupbehi", 1);
    }

    level utility::flag_wait_any("flag_forest_patrol_enemies_dead", "flag_forest_sniper_03");
  } else {
    level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_pric_sniper", 2, 0.5);
    level.player dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_fspr_pric_takecovercamefromthe", 2);
  }

  if(level utility::flag("flag_forest_sniper_03")) {
    var_a6a2bf88f86febfb = [[level.gaz, 0.5, "dx_sp_tund_fspr_gazz_nothingonthermals", &function_e134158b8d96fa58], [level.soap, 0.2, "dx_sp_tund_fspr_soap_usingthermalcamo", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_fspr_pric_gazwatchshepherdsoap", &function_e134158b8d96fa58], [level.gaz, 0.15, "dx_sp_tund_fspr_gazz_rogerthatonmegeneral", &function_e134158b8d96fa58]];
  } else {
    var_a6a2bf88f86febfb = [[level.gaz, 0.6, "dx_sp_tund_fspr_gazz_anyonehavevisual", &function_e134158b8d96fa58], [level.soap, 0.3, "dx_sp_tund_fspr_soap_negative", &function_e134158b8d96fa58], [level.gaz, 0.5, "dx_sp_tund_fspr_gazz_nothingonthermals", &function_e134158b8d96fa58], [level.soap, 0.4, "dx_sp_tund_fspr_soap_usingthermalcamo", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_fspr_pric_gazwatchshepherdsoap", &function_e134158b8d96fa58], [level.gaz, 0.15, "dx_sp_tund_fspr_gazz_rogerthatonmegeneral", &function_e134158b8d96fa58]];
  }

  level.var_bd555fa10c4b7506 = "flag_forest_sniper_enemy_dead";
  level dialogue::say_sequence(var_a6a2bf88f86febfb, 2, 0, 0, 0, "team");
  level utility::flag_set("flag_forest_sniper_allies_use_colors");
  level utility::flag_set("flag_forest_obj_sniper");
  wait 1;
  level thread function_9f277fc4509ac7e0();
  level thread function_745ea252bb0bc722();
  level thread function_b8f15a2c314deb95();
  level thread function_19288f7b8703efb2();
  level thread function_4dd1cfcf02a5e322();
  level thread function_366d4de216a8dfb0();
  level thread function_e2d5727f172f8579();
  level thread function_1ae2b19da86e9431();
}

function function_d788201477b217ab() {
  setmusicstate("mx_tundra_forestsniper");
}

function function_9f277fc4509ac7e0() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  while(!isDefined(level.ai_forest_sniper_enemy)) {
    waitframe();
  }

  while(isalive(level.ai_forest_sniper_enemy)) {
    if(level.soap cansee(level.ai_forest_sniper_enemy)) {
      level utility::flag_set("flag_forest_sniper_ally_sees_enemy");
    } else {
      level utility::flag_clear("flag_forest_sniper_ally_sees_enemy");
    }

    wait 2;
  }
}

function function_e2d5727f172f8579() {
  level.player endon("death");
  level endon("flag_forest_sniper_allow_ally_react_vo");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_allow_ally_react_vo") || utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  while(true) {
    while(true) {
      if(utility::flag("flag_forest_sniper_high_ground")) {
        if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 2.5)) {
          wait 1;
          continue;
        }

        break;
      }

      wait 1;
    }

    wait 1;

    if(!utility::flag("flag_forest_sniper_high_ground") && !utility::flag("flag_forest_sniper_progress_vo_playing")) {
      wait 3;
      continue;
    }

    a_lines = [];
    a_lines[a_lines.size] = "dx_sp_tund_fspr_soap_tacticallyadvantageo";
    a_lines[a_lines.size] = "dx_sp_tund_fspr_soap_birdseyegoodmovesir";
    level.soap dialogue::function_fc0eb6b81c66c661(0.2, random(a_lines), 0, 2.5);
    break;
  }
}

function function_b8f15a2c314deb95() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  react_aliases = [];
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_konnisniperisrelocat";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_snipersonthemove";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_enemysnipersrepositi";
  react_deck = utility::create_deck(react_aliases, 1, 1);
  level utility::flag_wait("flag_forest_sniper_allow_ally_react_vo");

  while(true) {
    level.ai_forest_sniper_enemy waittill("flag_sniper_moving");
    wait 0.7;
    level.soap dialogue::stop_dialogue();
    wait 0.3;
    react_vo = react_deck utility::deck_draw();
    level.soap dialogue::function_fc0eb6b81c66c661(0.1, react_vo, 2);
    wait randomfloatrange(10, 15);
  }
}

function function_19288f7b8703efb2() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  react_aliases = [];
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_hesstunnedlightemup";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_flashbanggothimtakeh";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_snipersstunneddrophi";
  react_deck = utility::create_deck(react_aliases);

  while(true) {
    level.ai_forest_sniper_enemy waittill("flag_sniper_flashed");
    wait 1;
    level.soap dialogue::stop_dialogue();
    react_vo = react_deck utility::deck_draw();
    level.soap dialogue::function_fc0eb6b81c66c661(0.1, react_vo, 2);
    wait randomfloatrange(10, 15);
  }
}

function function_745ea252bb0bc722() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  level utility::waittill_any_in_array_or_timeout(["flag_forest_sniper_02", "flag_forest_sniper_04", "flag_forest_sniper_06"], 10);
  count = 0;

  while(count < 5) {
    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 3)) {
      wait 1;
      count++;
      continue;
    }

    if(!utility::flag("flag_forest_sniper_player_sees_enemy") && !utility::flag("flag_forest_sniper_ally_sees_enemy") && !utility::flag("flag_forest_sniper_enemy_hit_by_player")) {
      utility::flag_set("flag_forest_sniper_progress_vo_playing");
      var_335bea585eec822a = [[level.player, 0, "dx_sp_tund_fspr_pric_anymovementsergeant", &function_2a9814518c4df7b5], [level.soap, 0.2, "dx_sp_tund_fspr_soap_negativelooking", &function_2a9814518c4df7b5]];
      level dialogue::say_sequence(var_335bea585eec822a, 1, 0, 0, 0, "team");
      utility::flag_clear("flag_forest_sniper_progress_vo_playing");
      wait 2.5;
      level utility::flag_set("flag_forest_sniper_allow_ally_react_vo");
      wait 5;
    }

    break;
  }

  level utility::flag_set("flag_forest_sniper_allow_ally_react_vo");
  level utility::waittill_any_in_array_or_timeout(["flag_forest_sniper_02", "flag_forest_sniper_04", "flag_forest_sniper_06"], 10);
  count = 0;

  while(count < 5) {
    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 5)) {
      wait 2.5;
      count++;
      continue;
    }

    utility::flag_set("flag_forest_sniper_progress_vo_playing");

    if(!utility::flag("flag_forest_sniper_player_sees_enemy") && !utility::flag("flag_forest_sniper_ally_sees_enemy")) {
      if(level utility::flag("flag_forest_sniper_player_hit")) {
        var_335bea585eec822a = [[level.player, 0, "dx_sp_tund_fspr_pric_wherethehellishe", &function_2a9814518c4df7b5], [level.soap, 0.2, "dx_sp_tund_fspr_soap_hesgottabeclose", &function_2a9814518c4df7b5]];
      } else {
        var_335bea585eec822a = [[level.soap, 0, "dx_sp_tund_fspr_soap_bastardshiding", &function_2a9814518c4df7b5], [level.player, 0.2, "dx_sp_tund_fspr_pric_staysharphesheresome", &function_2a9814518c4df7b5]];
      }

      level dialogue::say_sequence(var_335bea585eec822a, 1, 0, 0, 0, "team");
    }

    utility::flag_clear("flag_forest_sniper_progress_vo_playing");
    break;
  }
}

function function_2a9814518c4df7b5() {
  if(utility::flag("flag_forest_sniper_player_sees_enemy")) {
    return false;
  }

  return true;
}

function function_4dd1cfcf02a5e322() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  react_aliases = [];
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_getdown";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_hesseesyousir";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_findcoveractual";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_soap_hesgotyousightedcapt";
  react_deck = utility::create_deck(react_aliases);

  while(true) {
    level waittill("tundra_sniper_shot_player", sniper);
    level utility::flag_set("flag_forest_sniper_player_hit");
    react_vo = react_deck utility::deck_draw();
    level.soap dialogue::function_fc0eb6b81c66c661(0.15, react_vo, 0, 1);
    wait randomfloatrange(4, 8);
  }
}

function function_366d4de216a8dfb0() {
  level.player endon("death");
  level.ai_forest_sniper_enemy endon("death");
  level endon("flag_forest_sniper_player_hit_by_enemy");
  level endon("flag_forest_sniper_enemy_hit_by_player");
  level endon("flag_forest_sniper_player_sees_enemy");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  react_aliases = [];
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_pric_snipersclose";
  react_aliases[react_aliases.size] = "dx_sp_tund_fspr_pric_hescloseby";
  react_deck = utility::create_deck(react_aliases, 1, 1);
  n_near_dist_sq = squared(3072);

  while(true) {
    level.ai_forest_sniper_enemy waittill("weapon_fired");
    var_d106ee7682f26f4b = function_73881ce0cf3cc035(level.ai_forest_sniper_enemy, n_near_dist_sq);

    if(istrue(var_d106ee7682f26f4b) || dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 5)) {
      wait 1;
      continue;
    }

    react_vo = react_deck deck_draw();
    level.player say_team(react_vo, 0, 2);
    wait randomfloatrange(12, 18);
  }
}

function function_1ae2b19da86e9431() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level endon("flag_forest_sniper_enemy_longdeath");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_enemy_dead") || utility::flag("flag_forest_sniper_enemy_longdeath") || utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  utility::flag_wait("flag_forest_sniper_player_sees_enemy");
  dialogue::function_cb329cf8896edeaa(level.player.team, 1, 1);
  wait 0.2;
  a_lines = [];
  a_lines[a_lines.size] = "dx_sp_tund_fspr_pric_visualonthesniper";
  a_lines[a_lines.size] = "dx_sp_tund_fspr_pric_iseehim";
  level.player dialogue::say_team(random(a_lines), 2, 1);
}

function function_657aa2c319769ae1() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level utility::flag_wait("flag_forest_sniper_enemy_longdeath");
  function_fbab3cc861e5f296("flag_forest_sniper_complete");
  var_92b6c399f5364451 = [[level.soap, 0.8, "dx_sp_tund_fspr_soap_sniperswoundedcaptai", &function_e134158b8d96fa58], [level.player, 0.15, "dx_sp_tund_fspr_pric_letsfinishhimoff", &function_e134158b8d96fa58], [level.soap, 0.25, "dx_sp_tund_fspr_soap_gladly", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = "flag_forest_sniper_enemy_dead";
  level dialogue::say_sequence(var_92b6c399f5364451, 1, 0, 0, 0, "team");
}

function function_c5202f1255aaa90e() {
  level.player endon("death");
  level endon("flag_forest_sniper_complete");

  while(!isDefined(level.ai_forest_sniper_enemy)) {
    waitframe();
  }

  level.ai_forest_sniper_enemy waittill("death", killer);
  killer_name = killer.name;

  if(!isDefined(killer_name)) {
    killer_name = "Soap";
  }

  function_fbab3cc861e5f296("flag_forest_sniper_complete");

  switch (killer_name) {
    case #"hash_cdcc1d2789d3b46a":
      var_24a079f8b633fc49 = [[level.player, 1, "dx_sp_tund_fspr_pric_sniperdownwereclear", &function_e134158b8d96fa58], [level.soap, 0.2, "dx_sp_tund_fspr_soap_niceworkcaptain", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_fspr_pric_gazregrouponme", &function_e134158b8d96fa58], [level.gaz, 0.15, "dx_sp_tund_fspr_gazz_rog", &function_e134158b8d96fa58]];
      break;
    case #"hash_156ffa4f8b089876":
    default:
      var_24a079f8b633fc49 = [[level.soap, 1, "dx_sp_tund_fspr_soap_sniperdownwereclears", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_fspr_pric_gazregrouponus", &function_e134158b8d96fa58], [level.gaz, 0.15, "dx_sp_tund_fspr_gazz_rogercomintoya", &function_e134158b8d96fa58]];
      break;
  }

  level.var_bd555fa10c4b7506 = "flag_forest_sniper_complete";
  level dialogue::say_sequence(var_24a079f8b633fc49, 1, 0, 0, 0, "team");
  level utility::flag_set("flag_forest_obj_sniper_complete");
  level.soap dialogue::function_fc0eb6b81c66c661(2, "dx_sp_tund_fspr_soap_thisisafuckinshitsho", 0, 5);
  level.shepherd dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fspr_shep_myintelsalwaysgoodso", 0, 5);
  level thread function_420580be8bab7cfb("flag_forest_sniper_complete");
}

function function_cbdaead51c1114b6() {}

function function_a3b894933a5fd560() {
  level thread function_7afae80bc724a9ae();
  level thread function_18ad128e96355c9();
  level set_nagvars(0, 5, 0, "team");
}

function function_7afae80bc724a9ae() {
  level.player endon("death");
  level notify("stop_tundra_nags");
  function_fbab3cc861e5f296("flag_forest_field_complete");
  var_51ae1943e64d3c42 = [[level.gaz, 0.2, "dx_sp_tund_ffld_gazz_eyesonourtruckaheada", &function_e134158b8d96fa58], [level.soap, 0.3, "dx_sp_tund_ffld_soap_affirmassaultteam", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = ["flag_forest_field_shack_enemies_combat", "flag_forest_field_complete"];
  level dialogue::say_sequence(var_51ae1943e64d3c42, 1, 0, 0, 0, "team");
  level thread function_cae34073509e0fee();
  level thread function_d874f11596e5bd97();
  level thread function_420580be8bab7cfb("flag_forest_field_01");
}

function function_cae34073509e0fee() {
  level.player endon("death");
  level endon("flag_forest_field_shack_enemies_combat");
  level endon("flag_forest_field_complete");

  if(utility::flag("flag_forest_field_shack_enemies_combat")) {
    return;
  }

  level utility::flag_wait("flag_forest_field_01");
  wait 0.8;
  level.player thread namespace_8339f6377b6ba60e::function_e0f99342614824c0("noncombat", 3);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_ffld_pric_sixtofarahandghostou", 1);
  level.player thread namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();

  if(flag("flag_forest_field_02")) {
    utility::flag_set("flag_forest_secondary_route_confirmed");
    level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_ffld_fara_letscircleupatthemil", 1, &function_e134158b8d96fa58);
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_ffld_pric_checkgoodcall", 1, &function_e134158b8d96fa58);
  } else {
    utility::flag_set("flag_forest_secondary_route_confirmed");
    level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_ffld_fara_ghostissecuringlzill", 1, &function_e134158b8d96fa58);
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_ffld_pric_copywithourluckwellf", 1, &function_e134158b8d96fa58);
  }

  level utility::flag_set("flag_forest_obj_secondary_route");
  var_f4f127c61bbfe5c = [[level.soap, 0.7, "dx_sp_tund_ffld_soap_transportsgotammoand", &function_e134158b8d96fa58], [level.gaz, 0.3, "dx_sp_tund_ffld_gazz_wecouldslipbyifwehug", &function_e134158b8d96fa58]];
  level dialogue::say_sequence(var_f4f127c61bbfe5c, 1, 0, 0, 0, "team");
  utility::flag_set("flag_forest_field_supplies_vo_complete");
  level thread function_58c4bde0e7696e30();
  function_ae7e75fae8abe41e();
  wait 1;
  level thread function_fdac326045e5d650("flag_forest_field_shack_enemies_combat");
}

function function_58c4bde0e7696e30() {
  level.player endon("death");
  level endon("flag_forest_field_shack_enemies_combat");

  if(level utility::flag("flag_forest_field_shack_enemies_combat")) {
    return;
  }

  ai_sniper = utility::get_living_ai("ai_forest_field_enemy_sniper_center", "targetname");
  var_389633c461172a1e = squared(512);
  level utility::flag_wait("flag_forest_field_03");
  dist_sq = distance2dsquared(level.player.origin, ai_sniper.origin);

  if(dist_sq < var_389633c461172a1e) {
    return;
  }

  count = 0;

  while(count < 5) {
    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 5)) {
      wait 5;
      count++;
      continue;
    }

    utility::flag_set("flag_forest_field_go_around");
    var_2ec8077c2db85632 = [[level.gaz, 0.2, "dx_sp_tund_ffld_gazz_whatstheplancaptain", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_ffld_pric_movequickandquiet", &function_e134158b8d96fa58]];
    level dialogue::say_sequence(var_2ec8077c2db85632, 1, 0, 0, 0, "team");

    if(function_50f6a8d179cd5108(512)) {
      var_c729422e2a6e36aa = [[level.shepherd, 0.4, "dx_sp_tund_ffld_shep_smartmoveson", &function_e134158b8d96fa58], [level.soap, 0.2, "dx_sp_tund_fnc1_soap_quiet", &function_e134158b8d96fa58]];
      level dialogue::say_sequence(var_c729422e2a6e36aa, 1, 0, 0, 0, "team");
    }

    break;
  }
}

function function_ae7e75fae8abe41e() {
  level.player endon("death");
  level endon("flag_forest_field_shack_enemies_combat");
  level endon("flag_forest_field_go_around");
  level endon("flag_forest_field_complete");

  if(level utility::flag("flag_forest_field_shack_enemies_combat") || level utility::flag("flag_forest_field_go_around")) {
    return;
  }

  wait 20;

  if(cointoss()) {
    level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_engagethemorslippast", 1);
    return;
  }

  level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_cancutthroughthefiel", 1);
}

function function_d874f11596e5bd97() {
  level.player endon("death");
  level endon("flag_forest_field_shack_enemies_combat");
  level endon("flag_forest_field_complete");

  if(level utility::flag("flag_forest_field_shack_enemies_combat")) {
    return;
  }

  level utility::flag_wait_any("flag_forest_field_03", "flag_forest_field_supplies_vo_complete");
  ai_sniper = utility::get_living_ai("ai_forest_field_enemy_sniper_center", "targetname");

  if(!isDefined(ai_sniper) || !isalive(ai_sniper)) {
    return;
  }

  ai_sniper endon("death");
  struct = utility::getStruct("s_forest_field_shack_transport_center", "targetname");
  a_ai_enemies = utility::get_living_ai_array("ai_enemy_forest_field_shack", "targetname");
  a_ai_enemies = sortbydistance(a_ai_enemies, struct.origin);

  if(!isDefined(a_ai_enemies[0]) || !isalive(a_ai_enemies[0])) {
    return;
  }

  a_ai_enemies[0] endon("death");
  level.var_442a45e91375be89 = ai_sniper;
  level.var_5a93b62737612ed3 = a_ai_enemies[0];
  var_14330aa5c2a6a5a2 = [[level.var_442a45e91375be89, 1.3, "dx_sp_tund_ffld_kon1_controlwelocatedaveh", &function_7add8b41d6d3e197], [level.var_442a45e91375be89, 3.2, "dx_sp_tund_ffld_kon1_nosignofthemsearchin", &function_7add8b41d6d3e197], [level.var_442a45e91375be89, 2.1, "dx_sp_tund_ffld_kon1_findanything", &function_7add8b41d6d3e197], [level.var_5a93b62737612ed3, 1.8, "dx_sp_tund_ffld_kon2_justweaponstheyrenot", &function_7add8b41d6d3e197], [level.var_442a45e91375be89, 1.3, "dx_sp_tund_ffld_kon1_destroythetruckwellk", &function_7add8b41d6d3e197]];
  level dialogue::say_sequence(var_14330aa5c2a6a5a2, 0, 0, 0, 0, "self");
  badplace_cylinder("bp_forest_field_transport_all", -1, struct.origin, 320, 64, "axis", "allies");
  level utility::flag_set("flag_forest_field_shack_enemies_destroy_transport");

  while(true) {
    var_7eaba67d48079f1e = getaiarrayinradius(struct.origin, 256, "axis");

    if(var_7eaba67d48079f1e.size == 0) {
      break;
    }

    wait 1;
  }

  wait 3;
  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size > 0) {
    level utility::flag_set("flag_forest_field_shack_enemies_grenade_transport", a_ai_enemies[0]);
  }

  level utility::flag_wait("flag_forest_field_shack_transport_destroyed");
  level.gaz dialogue::function_fc0eb6b81c66c661(2, "dx_sp_tund_ffld_gazz_theregoesourtranspor", 0, 2.5);
}

function function_7add8b41d6d3e197() {
  if(!isalive(level.var_442a45e91375be89) || !isalive(level.var_5a93b62737612ed3)) {
    return 0;
  }

  if(utility::flag("flag_forest_field_shack_enemies_combat")) {
    return 0;
  }
}

function function_18ad128e96355c9() {
  level.player endon("death");
  level endon("flag_forest_field_sniper_all_dead");
  level endon("flag_forest_field_complete");
  level utility::flag_wait("flag_forest_field_shack_enemies_combat");
  thread function_7c3969e4c5026dfc();
  level notify("stop_tundra_nags");
  utility::battlechatter_on("axis");
  var_e65603ed8ea5d5c7 = 0;
  var_2e95ba7dae3d65a2 = 0;
  wait 1;

  if(utility::flag("flag_forest_field_shack_enemies_one_dead") || utility::flag("flag_forest_field_sniper_one_dead")) {
    var_e65603ed8ea5d5c7 = 1;

    if(utility::cointoss()) {
      level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_goodkillcaptainthere", 1);
    } else {
      level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_goodeffectsnipersare", 1);
      var_2e95ba7dae3d65a2 = 1;
    }
  } else if(utility::cointoss()) {
    level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_weremadeengage", 2);
    var_e65603ed8ea5d5c7 = 1;
  } else {
    level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_shitwerecompromised", 2);
    level.player dialogue::say_team("dx_sp_tund_ffld_pric_openfire", 2);
  }

  wait 1.5;

  if(!level utility::flag("flag_forest_field_sniper_one_remaining") && !istrue(var_2e95ba7dae3d65a2)) {
    if(istrue(var_e65603ed8ea5d5c7)) {
      ai_ally = level.soap;
    } else {
      ai_ally = utility::getclosest(level.player.origin, [level.gaz, level.soap]);
    }

    switch (ai_ally.animname) {
      case #"hash_df31f98a0b34e496":
        level.soap dialogue::say_team("dx_sp_tund_ffld_soap_headsupsnipersaresti", 2);
        break;
      case #"hash_fb36726c0708cd6d":
      default:
        level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_beadvisedbravomultip", 2);
        break;
    }
  }

  level utility::flag_set("flag_forest_obj_field_snipers");
  level.player dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_ffld_pric_spreadoutgeneralyour", 2);
  level utility::flag_set("flag_forest_field_allies_spread_out");

  if(!utility::flag("flag_forest_secondary_route_confirmed")) {
    level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_ffld_fara_letscircleupatthemil", 2, 5);
  }

  level thread function_e4173c0fd10acba();
  level thread function_644fe3cc59aea158();
  level thread function_78f6a0760559bf0();
  level thread function_360f5afa2679adc3();
  level thread function_e7c01c398d13f577();
  level thread function_7d34ff6edf9ccfd3();
  level thread function_5c0d51c72ee1d040();
}

function function_644fe3cc59aea158() {
  level.player endon("death");
  level endon("flag_forest_field_complete");

  if(utility::flag("flag_forest_field_shack_transport_destroyed")) {
    return;
  }

  level utility::flag_wait("flag_forest_field_shack_enemies_grenade_transport_warning");

  if(utility::cointoss()) {
    level.soap dialogue::say_team("dx_sp_tund_ffld_soap_grenadetakecover", 1, 2.5);
  } else {
    level.soap dialogue::say_team("dx_sp_tund_ffld_soap_grenadestandclear", 1, 2.5);
  }

  level utility::flag_wait("flag_forest_field_shack_transport_destroyed");

  if(utility::cointoss()) {
    level.gaz dialogue::function_fc0eb6b81c66c661(2, "dx_sp_tund_ffld_gazz_vehicledestroyedther", 0, 5);
    return;
  }

  level.gaz dialogue::function_fc0eb6b81c66c661(2, "dx_sp_tund_ffld_gazz_vehicledestryedwelos", 0, 5);
}

function function_e4173c0fd10acba() {
  level.player endon("death");
  level endon("flag_forest_field_05");
  level endon("flag_forest_field_complete");

  if(utility::flag("flag_forest_field_05")) {
    return;
  }

  level utility::flag_wait("flag_forest_field_player_near_transport");
  count = 0;

  while(count < 5) {
    if(!flag("flag_forest_field_player_near_transport")) {
      wait 1;
      count = 0;
      continue;
    }

    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 2.5)) {
      wait 3;
      count++;
      continue;
    }

    if(utility::flag("flag_forest_field_shack_transport_destroyed")) {
      level.soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_ffld_soap_vehiclestoast", 1, 5);
      level.player dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_ffld_pric_westayonfoot", 1, 5);
    } else {
      if(utility::flag("flag_forest_field_shack_enemies_grenade_transport")) {
        return;
      }

      utility::flag_set("flag_forest_field_vo_approach_transport_playing");
      level.soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_ffld_soap_theenginesgrilled", 1, 5);
      level.gaz dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_ffld_gazz_suppliesinsidearesti", 1, 5);
      wait 3;
      utility::flag_clear("flag_forest_field_vo_approach_transport_playing");
      wait 12;

      if(!utility::flag("flag_forest_field_supplies_vo_complete") && !utility::flag("flag_forest_field_player_pickup_transport") && !utility::flag("flag_forest_field_shack_transport_destroyed")) {
        level.soap dialogue::say_team("dx_sp_tund_ffld_soap_trucksfullofweaponsa", 2, 10);
      }
    }

    break;
  }
}

function function_5c0d51c72ee1d040() {
  level.player endon("death");
  level endon("flag_forest_field_sniper_all_dead");
  level endon("flag_forest_field_complete");
  player_aliases = [];
  player_aliases[player_aliases.size] = "dx_sp_tund_shpy_pric_gotasniper";
  player_aliases[player_aliases.size] = "dx_sp_tund_shpy_pric_sniperspotted";
  player_aliases[player_aliases.size] = "dx_sp_tund_shpy_pric_visualonasniper";
  player_deck = utility::create_deck(player_aliases, 1, 1);
  a_ai_snipers = level.var_2f9f697bc727f253;
  str_position = undefined;
  a_vols = getEntArray("vol_forest_field_enemy_sniper_position", "targetname");
  a_positions = ["field_tree_stump", "field_shack", "field_log_piles", "field_fallen_tree", "field_machinery", "field_frozen_stream", "field_far_side", "field_cliff", "field_trees", "field_prone"];
  wait 3;

  while(true) {
    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 5)) {
      wait 5;
      continue;
    }

    var_ab1f993d05c3500e = str_position;
    str_position = undefined;
    sniper = undefined;
    sniper = level function_ae673a2b9f6f1813();
    a_vols = array_randomize(a_vols);

    if(!isDefined(sniper)) {
      sniper = function_7bf58c5387d12e18(a_ai_snipers, a_vols, var_ab1f993d05c3500e);
    }

    if(!isDefined(sniper)) {
      wait 1;
      continue;
    }

    str_position = sniper function_ed139ddd9225914a(a_vols);

    if(isDefined(str_position)) {
      if(!utility::array_contains(a_positions, str_position)) {
        wait 1;
        continue;
      }

      switch (str_position) {
        case #"hash_6e2f2d05ed18dbc0":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_snipersbehindthestum");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_snipersbehindthestum");
          }

          break;
        case #"hash_b65e236c94050b24":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_snipershidingbehindt");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_snipershidingbehindt");
          }

          break;
        case #"hash_c028f38b5b63e294":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_snipersbesidethelogp");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_snipersbesidethelogp");
          }

          break;
        case #"hash_3184ce115dd55ac7":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_snipersbehindthefall");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_snipersbehindthefall");
          }

          break;
        case #"hash_2ce45b860bc8e32c":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_snipersusingthemachi");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_snipersusingthemachi");
          }

          break;
        case #"hash_ec2e22d0873aecf7":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_snipersbythefrozenst");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_snipersnearthefrozen");
          }

          break;
        case #"hash_35e61de5895b621":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_eyesonsniperfarsideo");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_eyesonsniperfarsideo");
          }

          break;
        case #"hash_3ab56ee64e20a046":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_sniperonthecliff");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_sniperonthecliff");
          }

          break;
        case #"hash_bc7b718e8f1fdab9":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_gotvisonsniperinthet");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_gotasniperinthetrees");
          }

          break;
        case #"hash_38fb56bb10d2fd46":
          if(sniper ent_flag("flag_sniper_seen_by_player")) {
            level.player dialogue::say_team("dx_sp_tund_fspr_pric_sniperslyingprone");
          } else {
            level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_sniperslyingprone");
          }

          break;
      }

      a_positions = utility::array_remove(a_positions, str_position);
      wait randomfloatrange(8, 16);
      level.player waittill_notify_or_timeout("tundra_player_sees_sniper", randomfloatrange(4, 6));
    } else if(sniper ent_flag("flag_sniper_seen_by_player")) {
      player_vo = player_deck utility::deck_draw();
      level.player dialogue::say_team(player_vo);
      wait randomfloatrange(8, 16);
    }

    wait 1;
  }
}

function function_7c3969e4c5026dfc() {
  setmusicstate("mx_tundra_field");
}

function function_78f6a0760559bf0() {
  level.player endon("death");
  level endon("flag_forest_field_sniper_all_dead");
  level endon("flag_forest_field_complete");
  var_b9c059671c239ec9 = utility::create_deck(["dx_sp_tund_ffld_gazz_flashout", "dx_sp_tund_ffld_gazz_throwingflashbang", "dx_sp_tund_ffld_gazz_throwingstungrenade"], 1, 1);
  soap_lines = utility::create_deck(["dx_sp_tund_ffld_soap_flashout", "dx_sp_tund_ffld_soap_deployingstungrenade", "dx_sp_tund_ffld_soap_throwingflash"], 1, 1);

  while(true) {
    level waittill("forest_field_ally_threw_flashbang", ai_ally);

    switch (ai_ally.animname) {
      case #"hash_fb36726c0708cd6d":
        var_dcf900fef166fcf9 = var_b9c059671c239ec9 utility::deck_draw();
        level.gaz dialogue::function_fc0eb6b81c66c661(1, var_dcf900fef166fcf9, 0, 2.5);
        break;
      case #"hash_df31f98a0b34e496":
        soap_vo = soap_lines utility::deck_draw();
        level.soap dialogue::function_fc0eb6b81c66c661(1, soap_vo, 0, 2.5);
        break;
      default:
        break;
    }
  }
}

function function_e7c01c398d13f577() {
  level.player endon("death");
  level endon("flag_forest_field_sniper_all_dead");
  level endon("flag_forest_field_complete");
  string_array = ["flag_forest_field_05", "flag_forest_field_07", "flag_forest_field_09"];
  var_4caf35e9283006da = [level.gaz, level.soap];
  level utility::waittill_any_in_array_or_timeout(string_array, 20);
  count = 0;

  while(count < 5) {
    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 10)) {
      wait 10;
      count++;
      continue;
    }

    var_cb536dcb6fbcd74f = ["rifle", "sniper", "battle", "marksman"];
    var_2ce197064beba684 = 0;
    var_71f3bca5b359e7a2 = 0;

    foreach(weapon in level.player getweaponslistprimaries()) {
      weapon_class = weaponclass(weapon);

      if(array_contains(var_cb536dcb6fbcd74f, weapon_class)) {
        if(weapon == level.player getcurrentweapon()) {
          var_2ce197064beba684 = 1;
          continue;
        }

        var_71f3bca5b359e7a2 = 1;
      }
    }

    if(istrue(var_2ce197064beba684)) {
      ai_ally = utility::random(var_4caf35e9283006da);

      switch (ai_ally.animname) {
        case #"hash_df31f98a0b34e496":
          level.soap dialogue::say_team("dx_sp_tund_ffld_soap_sniperscouldbeanywhe", 0, 10);
          break;
        case #"hash_fb36726c0708cd6d":
        default:
          level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_stayfocusedactualsni", 0, 10);
          break;
      }
    } else if(istrue(var_71f3bca5b359e7a2)) {
      if(function_50f6a8d179cd5108(512)) {
        level.shepherd dialogue::say_team("dx_sp_tund_ffld_shep_thispistolwontcutity", 0, 10);
      } else {
        level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_capifyougotasniperri", 0, 10);
      }
    } else {
      level.soap dialogue::say_team("dx_sp_tund_ffld_soap_needalongerrangerifl", 0, 10);
    }

    break;
  }

  wait 20;
  count = 0;

  while(count < 5) {
    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 10)) {
      wait 10;
      count++;
      continue;
    }

    ai_ally = utility::random(var_4caf35e9283006da);

    if(!utility::flag("flag_forest_field_sniper_one_remaining")) {
      switch (ai_ally.animname) {
        case #"hash_df31f98a0b34e496":
          level.soap dialogue::say_team("dx_sp_tund_ffld_soap_theyrehidingbuttheyr", 0, 10);
          break;
        case #"hash_fb36726c0708cd6d":
        default:
          level.gaz dialogue::say_team("dx_sp_tund_ffld_gazz_flushemoutofcover", 0, 10);
          break;
      }
    }

    break;
  }
}

function function_360f5afa2679adc3() {
  level.player endon("death");
  level endon("flag_forest_field_sniper_all_dead");
  level endon("flag_forest_field_complete");
  var_4caf35e9283006da = [level.gaz, level.soap];
  var_457dfa81656298e = utility::create_deck(["dx_sp_tund_ffld_shep_takecoversir", "dx_sp_tund_ffld_shep_captainshitrepositio"], 1, 1);
  var_b9c059671c239ec9 = utility::create_deck(["dx_sp_tund_ffld_gazz_getdownsix", "dx_sp_tund_ffld_gazz_captaintakingeffecti", "dx_sp_tund_ffld_gazz_findcovercaptainyouc"], 1, 1);
  soap_lines = utility::create_deck(["dx_sp_tund_ffld_soap_getoutofthereactual", "dx_sp_tund_ffld_soap_gettocovercaptain", "dx_sp_tund_ffld_soap_staylowsiryouneedtol", 1, 1]);
  n_count = 0;
  var_214d28d4910e2a73 = 0;

  while(true) {
    level waittill("tundra_sniper_shot_player", sniper);
    n_count++;

    if(n_count >= 3) {
      level utility::flag_set("flag_forest_field_player_hit_multiple");
    }

    wait 1;

    if(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 5) || utility::cointoss()) {
      wait 1;
      continue;
    }

    if(function_50f6a8d179cd5108(384) && !istrue(var_214d28d4910e2a73) || utility::cointoss()) {
      ai_ally = level.shepherd;
    } else {
      ai_ally = utility::random(var_4caf35e9283006da);
    }

    switch (ai_ally.animname) {
      case #"hash_831c7a280af6bbca":
        var_522769e4f963a5a0 = var_457dfa81656298e utility::deck_draw();
        level.shepherd dialogue::say_team(var_522769e4f963a5a0);
        var_214d28d4910e2a73 = 1;
        break;
      case #"hash_df31f98a0b34e496":
        soap_vo = soap_lines utility::deck_draw();
        level.soap dialogue::say_team(soap_vo);
        var_214d28d4910e2a73 = 0;

        if(isDefined(sniper)) {
          level notify("tundra_sniper_position_callout", sniper);
        }

        break;
      case #"hash_fb36726c0708cd6d":
      default:
        var_dcf900fef166fcf9 = var_b9c059671c239ec9 utility::deck_draw();
        level.gaz dialogue::say_team(var_dcf900fef166fcf9);
        var_214d28d4910e2a73 = 0;

        if(isDefined(sniper)) {
          level notify("tundra_sniper_position_callout", sniper);
        }

        break;
    }

    wait randomfloatrange(6, 12);
  }
}

function function_7d34ff6edf9ccfd3() {
  level.player endon("death");
  react_aliases = [];
  react_aliases[react_aliases.size] = "dx_sp_tund_ffld_pric_snipereliminated";
  react_aliases[react_aliases.size] = "dx_sp_tund_ffld_pric_sniperdown";
  react_aliases[react_aliases.size] = "dx_sp_tund_ffld_pric_shooterneutralized";
  react_aliases[react_aliases.size] = "dx_sp_tund_shpy_pric_konnisnipereliminate";
  react_deck = utility::create_deck(react_aliases, 1, 1);

  for(var_cdf2e3e6f6b08b18 = 0; !level utility::flag("flag_forest_field_sniper_one_remaining"); var_cdf2e3e6f6b08b18 = 0) {
    level waittill("tundra_sniper_dead");

    if(!istrue(var_cdf2e3e6f6b08b18) || utility::cointoss()) {
      react_vo = react_deck utility::deck_draw();
      level.player dialogue::function_fc0eb6b81c66c661(1, react_vo, 0, 2.5);
      var_cdf2e3e6f6b08b18 = 1;
      continue;
    }

    waitframe();
  }

  a_lines = [];
  a_lines[a_lines.size] = "dx_sp_tund_ffld_gazz_goodshotonetogo";
  a_lines[a_lines.size] = "dx_sp_tund_ffld_gazz_goodkillsironeleft";
  a_lines[a_lines.size] = "dx_sp_tund_ffld_gazz_onexrayleft";
  level.gaz dialogue::function_fc0eb6b81c66c661(1.6, random(a_lines), 0, 5);
  level utility::flag_wait_all("flag_forest_field_sniper_all_dead", "flag_forest_field_shack_enemies_dead");
  level utility::flag_set("flag_forest_obj_field_snipers_complete");
  thread function_d42e171768dd46ac();
  wait 1;
  level thread function_adef66528012769b();
}

function function_adef66528012769b() {
  level.player endon("death");
  level endon("flag_forest_field_complete");

  if(level utility::flag("flag_forest_field_complete")) {
    return;
  }

  if(utility::flag("flag_forest_field_player_hit_multiple")) {
    level.player dialogue::function_fc0eb6b81c66c661(1.8, "dx_sp_tund_ffld_pric_allcleardoneandduste", 1);
  } else {
    level.player dialogue::function_fc0eb6b81c66c661(1.8, "dx_sp_tund_ffld_pric_werecleargoodwork", 1);
  }

  if(!function_50f6a8d179cd5108(654)) {
    var_ddf1088d07cd1b8b = [[level.player, 1, "dx_sp_tund_ffld_pric_trucksdeadwehoofitto", &function_e134158b8d96fa58], [level.gaz, 0.2, "dx_sp_tund_ffld_gazz_wellrallyupwithfarah", &function_e134158b8d96fa58], [level.soap, 0.15, "dx_sp_tund_ffld_soap_speakinmylanguagegaz", &function_e134158b8d96fa58]];
  } else if(utility::flag("flag_forest_field_player_hit_multiple")) {
    var_ddf1088d07cd1b8b = [[level.shepherd, 0.35, "dx_sp_tund_ffld_shep_goodjobyoulostyourtr", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_ffld_pric_luckilyyourlegsstill", &function_e134158b8d96fa58], [level.gaz, 0.15, "dx_sp_tund_ffld_gazz_themillsjustaheadalo", &function_e134158b8d96fa58]];
  } else {
    var_ddf1088d07cd1b8b = [[level.shepherd, 0.35, "dx_sp_tund_ffld_shep_expectednothinglessp", &function_e134158b8d96fa58], [level.player, 0.5, "dx_sp_tund_ffld_pric_trucksdeadwehoofitto", &function_e134158b8d96fa58], [level.gaz, 0.2, "dx_sp_tund_ffld_gazz_wellrallyupwithfarah", &function_e134158b8d96fa58], [level.soap, 0.15, "dx_sp_tund_ffld_soap_speakinmylanguagegaz", &function_e134158b8d96fa58]];
  }

  level.var_bd555fa10c4b7506 = "flag_forest_field_complete";
  level dialogue::say_sequence(var_ddf1088d07cd1b8b, 1, 0, 0, 0, "team");
  wait 3;
  level.soap dialogue::say_team("dx_sp_tund_fspr_soap_soaptoghostwereafewm", 0, 5);
  level.ghost dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_fspr_ghos_copylzissecurewillre", 0, 5);
  level thread function_fdac326045e5d650("flag_forest_field_complete");
}

function function_d42e171768dd46ac() {
  stopmusicstate("mx_tundra_field");
}

function function_7bf58c5387d12e18(a_ai_snipers, a_vols, var_ab1f993d05c3500e) {
  a_ai_snipers = array_removedead_or_dying(a_ai_snipers);

  if(a_ai_snipers.size == 0) {
    return;
  } else if(a_ai_snipers.size > 1) {
    a_ai_snipers = array_sort_with_func(a_ai_snipers, &function_ea0afb15893376f1);
  } else {
    a_ai_snipers = array_sort_with_func(a_ai_snipers, &function_6f9550218f9e01b0);
  }

  foreach(ai_sniper in a_ai_snipers) {
    str_position = ai_sniper function_ed139ddd9225914a(a_vols);

    if(isDefined(str_position)) {
      if(isDefined(var_ab1f993d05c3500e) && str_position == var_ab1f993d05c3500e) {
        continue;
      }

      return ai_sniper;
    }
  }

  return undefined;
}

function function_ae673a2b9f6f1813() {
  level.player endon("death");
  level endon("flag_forest_field_sniper_all_dead");
  level endon("flag_forest_field_complete");
  level endon("tundra_sniper_position_timeout");
  level thread utility::notify_delay("tundra_sniper_position_timeout", randomfloatrange(5, 10));
  level waittill("tundra_sniper_position_callout", sniper);
  return sniper;
}

function function_ed139ddd9225914a(a_vols) {
  foreach(vol in a_vols) {
    if(self istouching(vol) && isDefined(vol.script_noteworthy)) {
      return vol.script_noteworthy;
    }
  }

  if(isDefined(self.currentpose) && self.currentpose == "prone") {
    return "field_prone";
  } else if(isDefined(self.node) && (self.node.type == "Cover Prone" || self.node.type == "Conceal Prone")) {
    return "field_prone";
  }

  return undefined;
}

function function_25b0ab66b612ccea() {}

function function_6cbbd1bad5361adb() {
  level thread function_a26d0652f55c7039();
  level thread function_d851993c9cc1131a();
  level set_nagvars(0, 5, 0, "team");
}

function function_a26d0652f55c7039() {
  level.player endon("death");
  level endon("flag_forest_vista_05");
  level utility::flag_wait_all("flag_forest_field_complete", "flag_forest_field_allies_moving_to_exit");
  level notify("stop_tundra_nags");
  function_fbab3cc861e5f296("flag_forest_vista_complete");
  wait 2;
  thread namespace_93635c21ec57253a::function_e93afe911221b883();
  var_4f54b6815ca7e047 = [[level.soap, 2, "dx_sp_tund_fvta_soap_hearthat", &function_e134158b8d96fa58], [level.gaz, 0.4, "dx_sp_tund_fvta_gazz_camefromthelumbermil", &function_e134158b8d96fa58], [level.soap, 0.6, "dx_sp_tund_fvta_soap_comeinkilo", &function_e134158b8d96fa58], [level.farah, 1.2, "dx_sp_tund_fvta_fara_konnipatrolssurround", &function_e134158b8d96fa58], [level.soap, 0.6, "dx_sp_tund_fvta_soap_letsjointhefightcapt", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = "flag_forest_vista_05";
  level dialogue::say_sequence(var_4f54b6815ca7e047, 1, 0, 0, 0, "team");
  level notify("audio_clear_heli_attenuate");
  level utility::flag_set("flag_forest_vista_intro_vo_done");
  level thread function_6dc6c8d564958435();
}

function function_6dc6c8d564958435() {
  level.player endon("death");
  level endon("flag_forest_vista_05");

  if(utility::flag("flag_forest_vista_05")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fvta_soap_farahsupahead"];
  nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_fvta_gazz_theexplosionhappened"];
  nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_fvta_gazz_millsthatway"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flag_forest_vista_05", "flag_tundra_stop_nags"], nag_deck, dialogue::growing_delay(15, 45, 3), 15);
}

function function_d851993c9cc1131a() {
  level.player endon("death");
  level endon("flag_forest_vista_complete");
  utility::flag_wait("flag_forest_vista_05");
  level notify("stop_tundra_nags");
  level notify("audio_clear_heli_attenuate");
  level.gaz dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fvta_gazz_farahwhatsyourstatus", 1);
  level.farah dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_fvta_fara_takingenemyfirefarsi", 1);
  utility::flag_set("flag_lumbermill_vista_explosions");
  level.player thread namespace_8339f6377b6ba60e::function_e0f99342614824c0("noncombat", 4);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fvta_pric_copyholdyourposition", 1);
  level.player thread namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();
  level.farah dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_fvta_fara_copythat", 1);
  utility::flag_set("flag_forest_vista_allies_continue");
  level thread function_b27d049f4bc0f7d();
  level thread function_c7c5846ac5ebbec9();
  level thread function_7cff02f9e255961c("flag_forest_vista_08");
}

function function_7cff02f9e255961c(endon_flag) {
  level.player endon("death");
  level endon("flag_forest_vista_complete");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fvta_soap_farahneedsbackupbrav"];
  nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_fvta_soap_wereneededatthemills"];
  nag_aliases[nag_aliases.size] = [level.gaz, "dx_sp_tund_fvta_gazz_farahswaitingcaptain"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632([endon_flag, "flag_forest_vista_complete", "flag_tundra_stop_nags"], nag_deck, dialogue::growing_delay(15, 30, 3), 15);
}

function function_c7c5846ac5ebbec9() {
  level.player endon("death");
  level endon("flag_forest_vista_08");
  level endon("flag_forest_vista_complete");

  if(utility::flag("flag_forest_vista_08")) {
    return;
  }

  var_ca63728f991facd0 = [];
  var_ca63728f991facd0[var_ca63728f991facd0.size] = "dx_sp_tund_fvta_soap_needtogetinthereclos";
  var_ca63728f991facd0[var_ca63728f991facd0.size] = "dx_sp_tund_fvta_soap_letsgetupcloseforthi";
  var_ca63728f991facd0[var_ca63728f991facd0.size] = "dx_sp_tund_fvta_soap_werenoteffectivefrom";
  var_e228fe7d65925f71 = utility::create_deck(var_ca63728f991facd0, 1, 1);
  cliff_aliases = [];
  cliff_aliases[cliff_aliases.size] = "dx_sp_tund_fvta_soap_watchthatedgesirlong";
  cliff_aliases[cliff_aliases.size] = "dx_sp_tund_fvta_soap_thatwaysriskyactuall";
  cliff_aliases[cliff_aliases.size] = "dx_sp_tund_fvta_soap_bravo6advisetakingth";
  cliff_deck = utility::create_deck(cliff_aliases, 1, 1);
  var_afa30e7e11567109 = 0;

  while(!flag("flag_lumbermill_ambient_enemies_cleared")) {
    msg = level utility::flag_wait_any_return("flag_forest_vista_cliff_too_close", "flag_lumbermill_ambient_enemies_player_kill");

    while(dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 5)) {
      wait 1;
      continue;
    }

    if(msg == "flag_forest_vista_cliff_too_close" && !istrue(var_afa30e7e11567109)) {
      cliff_vo = cliff_deck utility::deck_draw();
      level.soap dialogue::say_team(cliff_vo, 0, 2.5);
      var_afa30e7e11567109 = 1;
    } else {
      var_4b63be7a1d7e815f = var_e228fe7d65925f71 utility::deck_draw();
      level.soap dialogue::function_fc0eb6b81c66c661(0.15, var_4b63be7a1d7e815f, 0, 2.5);
      var_afa30e7e11567109 = 0;
    }

    level flag_wait_or_timeout("flag_lumbermill_ambient_enemies_cleared", randomfloatrange(5, 15));
  }

  wait 5;

  if(utility::cointoss()) {
    level.farah dialogue::say_team("dx_sp_tund_fvta_fara_clearbutmoreincoming", 0, 2.5);
    return;
  }

  level.farah dialogue::say_team("dx_sp_tund_fvta_fara_millsclearfornowlets", 0, 2.5);
}

function function_b27d049f4bc0f7d() {
  level.player endon("death");
  level endon("flag_lumbermill_player_gave_orders");
  utility::flag_wait("flag_forest_vista_08");

  if(level utility::flag("flag_lumbermill_ambient_enemies_cleared")) {
    if(utility::cointoss()) {
      level.farah dialogue::function_fc0eb6b81c66c661(1.4, "dx_sp_tund_fvta_fara_bravoenemyreinforcem", 1);
      level.gaz dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_fvta_gazz_rogpressingtothelumb", 1);
    } else {
      level.farah dialogue::function_fc0eb6b81c66c661(1.4, "dx_sp_tund_fvta_fara_morekonniincomingbra", 1);
      level.gaz dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_fvta_gazz_copyapproachingwellh", 1);
    }
  }

  level thread function_7cff02f9e255961c("flag_forest_vista_complete");
}

function function_93cc485097380eb1() {}

function function_2d2ffb46cf33661e() {
  level thread function_7a1cd5e5ef770d08();
  level thread function_d8068c34ba9b653a();
  level thread function_f48299c91e352cbf();
  level thread function_eac13aafeb6037f7();
  level thread function_9d2a772b0c7980bd();
  level set_nagvars(0, 5, 0, "team");
}

function function_28c8444a64c1ce48() {
  setmusicstate("mx_tundra_lumbermill");
}

function function_7a1cd5e5ef770d08() {
  level.player endon("death");
  utility::flag_wait("flag_forest_vista_complete");
  level notify("stop_tundra_nags");
  thread function_28c8444a64c1ce48();
  level thread function_24436f33189e0be4();
  function_fbab3cc861e5f296("flag_lumbermill_complete");
  var_f2fdbe614fbb96e2 = [[level.player, 0.8, "dx_sp_tund_lmtp_pric_konniseverywherefara", &function_e134158b8d96fa58], [level.farah, 0.5, "dx_sp_tund_lmtp_fara_ontherooftopkeeppush", &function_e134158b8d96fa58], [level.player, 0.3, "dx_sp_tund_lmtp_pric_gaztakeshepherdandfi", &function_e134158b8d96fa58], [level.soap, 0.15, "dx_sp_tund_lmtp_soap_aye", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = "flag_lumbermill_complete";
  level dialogue::say_sequence(var_f2fdbe614fbb96e2, 1, 0, 0, 0, "team");
  level utility::flag_set("flag_lumbermill_player_gave_orders");
  level thread function_57e49125ebaef50f();
  level thread function_35dd89577ff17a8a();
}

function function_57e49125ebaef50f() {
  level.player endon("death");
  level endon("flag_lumbermill_gaz_shepherd_moveup");
  level endon("flag_lumbermill_complete");
  utility::flag_wait("flag_lumbermill_trailer_playerinside");

  if(utility::cointoss()) {
    level.shepherd dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_lmtp_shep_gearupinhere", 0, 5);
  } else {
    level.shepherd dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_fvta_shep_gotweaponsherejohn", 0, 5);
  }

  level thread function_b5bf6c650f5ff53a();
  utility::flag_waitopen("flag_lumbermill_trailer_playerinside");
  utility::flag_set("flag_lumbermill_trailer_playeroutside");
}

function function_b5bf6c650f5ff53a() {
  level.player endon("death");
  level endon("flag_lumbermill_gaz_shepherd_moveup");
  level endon("flag_lumbermill_complete");
  wait 2;

  while(true) {
    utility::flag_wait("flag_lumbermill_trailer_playerinside");
    function_fbab3cc861e5f296("flag_lumbermill_complete");
    wait 2;

    if(utility::flag("flag_lumbermill_trailer_playerinside")) {
      if(utility::cointoss() && !level utility::flag("flag_forest_patrol_shepherd_still_shoot")) {
        var_1b983f9524bb73dd = [[level.shepherd, 0.3, "dx_sp_tund_fvta_shep_idontneedachaperonej", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_fvta_pric_youreluckyyournotinz", &function_e134158b8d96fa58]];
      } else {
        var_1b983f9524bb73dd = [[level.player, 0.3, "dx_sp_tund_ffld_pric_canyoustillshootgene", &function_e134158b8d96fa58], [level.shepherd, 0.2, "dx_sp_tund_ffld_shep_doesapolarbearshitin", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_ffld_pric_makesureyouaimstraig", &function_e134158b8d96fa58], [level.shepherd, 0.2, "dx_sp_tund_ffld_shep_countonit", &function_e134158b8d96fa58]];
      }

      level.var_bd555fa10c4b7506 = "flag_lumbermill_trailer_playeroutside";
      level dialogue::say_sequence(var_1b983f9524bb73dd, 1, 0, 0, 0, "team");
      break;
    }
  }

  wait 2;
  level thread function_487706f7cc0d1f95();
}

function function_487706f7cc0d1f95() {
  level.player endon("death");
  level endon("flag_lumbermill_gaz_shepherd_moveup");
  level endon("flag_lumbermill_complete");
  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.shepherd, "dx_sp_tund_lmtp_shep_soapswaitingonyouout"];
  nag_aliases[nag_aliases.size] = [level.shepherd, "dx_sp_tund_lmtp_shep_resupplyandgetbackou"];
  nag_aliases[nag_aliases.size] = [level.shepherd, "dx_sp_tund_lmtp_shep_imnotgoinganywherejo"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);

  while(true) {
    utility::flag_wait("flag_lumbermill_trailer_playerinside");
    level dialogue::nag_waitopen("flag_lumbermill_trailer_playerinside", nag_deck, dialogue::growing_delay(10, 20, 2), 5);
    wait 1;
  }
}

function function_35dd89577ff17a8a() {
  level.player endon("death");
  level endon("flag_lumbermill_farah_callout_snipersnest");
  level endon("flag_lumbermill_vehicle_spectacle");
  level endon("flag_lumbermill_complete");
  utility::flag_wait_or_timeout("flag_lumbermill_allymovement_soap_2", randomfloatrange(15, 25));

  while(utility::flag("flag_lumbermill_trailer_playerinside")) {
    wait 1;
  }

  if(level utility::flag("flag_lumbermill_logsstorage_enemies_cleared")) {
    level.soap dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_lmtp_soap_gotroundscominfromth", 1, 10);
    level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_lmtp_pric_shootanythingthatmov", 1, 10);
  } else {
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_lmtp_pric_headonaswivelthisisa", 1, 10);
    level.soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_lmtp_soap_affirmativesirletsgi", 1, 10);
  }

  var_5e531899936a10f9 = ["flag_lumbermill_farah_callout_snipersnest", "flag_lumbermill_vehicle_spectacle", "flag_tundra_stop_nags"];
  level thread function_f6a23036659ae65(var_5e531899936a10f9);
}

function function_f6a23036659ae65(flg_endon) {
  level.player endon("death");
  level endon("flag_lumbermill_complete");

  if(!isarray(flg_endon)) {
    str_flag = flg_endon;
    flg_endon = [str_flag];
  }

  foreach(msg in flg_endon) {
    if(level utility::flag(msg)) {
      return;
    }

    level endon(msg);
  }

  if(!isDefined(level.var_6ebd9b2c3bc17115)) {
    nag_aliases = [];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_lmtp_soap_moreenemiesaheadcapt"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_lmtp_soap_pushinguponyousir"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_lmtp_soap_morehostilesahead"];
    nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_lmtp_soap_makarovsgotmanpoweri"];
    level.var_6ebd9b2c3bc17115 = utility::create_deck(nag_aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632(flg_endon, level.var_6ebd9b2c3bc17115, dialogue::growing_delay(20, 50, 3), 20, 1);
}

function function_24436f33189e0be4() {
  level.player endon("death");
  level endon("flag_lumbermill_warehouse_room2_enemies");
  level endon("flag_lumbermill_vehicle_spectacle");
  level endon("flag_lumbermill_complete");
  aliases = [];
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_holdshellcomeoutofhi";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_dispersefocusfireont";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_targethasexplosivesf";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_takeherdownbeforebac";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_enemysalonetakeherdo";
  var_994c50ba4dd9df95 = utility::create_deck(aliases, 1, 1);

  while(true) {
    wait randomfloatrange(5, 10);
    ai_enemy_closest = utility::get_closest_ai(level.player.origin, "axis");

    if(isDefined(ai_enemy_closest) && isalive(ai_enemy_closest)) {
      if(!istrue(ai_enemy_closest ent_flag("flag_lumbermill_enemy_attacking_player"))) {
        react_vo = var_994c50ba4dd9df95 deck_draw();
        ai_enemy_closest dialogue::say(react_vo, 0, 5);
      } else {
        break;
      }
    }

    wait 1;
  }
}

function function_ac3003763e67403a() {
  level.player endon("death");
  level endon("flag_lumbermill_warehouse_room2_enemies");
  level endon("flag_lumbermill_vehicle_spectacle");
  level endon("flag_lumbermill_complete");
  aliases = [];
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_hostilesbehindus";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_enemyreinforcementsa";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_wereflanked";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_dontletthemtrapus";
  aliases[aliases.size] = "dx_sp_tund_lmtp_kon1_watchyourbacksmoreho";
  var_f9812cc0213c2931 = utility::create_deck(aliases, 1, 1);

  if(isalive(self) && !flag("flag_lumbermill_enemy_react_vo_playing")) {
    utility::flag_set("flag_lumbermill_enemy_react_vo_playing");
    react_vo = var_f9812cc0213c2931 deck_draw();
    dialogue::say(react_vo, 0);
    wait 3;
    utility::flag_clear("flag_lumbermill_enemy_react_vo_playing");
  }
}

function function_d8068c34ba9b653a() {
  level.player endon("death");
  level endon("flag_lumbermill_vehicle_spectacle");
  utility::flag_wait_any("flag_lumbermill_farah_callout_snipersnest", "flag_lumbermill_warehouse_room1_enemies_cleared", "flag_lumbermill_warehouse_room2_enemies_cleared");

  if(!utility::flag("flag_lumbermill_snipersnest_enemies_cleared")) {
    level utility::flag_set("flag_lumbermill_farah_callout_snipersnest");
    level.farah dialogue::say_team("dx_sp_tund_lmtp_fara_captaingottwosnipers", 1);
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_lmtp_pric_copyilltakeittoem", 1, 5);
    level thread function_c590e57c8385b13a();
  } else {
    var_5e531899936a10f9 = ["flag_lumbermill_allymovement_soap_6", "flag_lumbermill_vehicle_spectacle", "flag_tundra_stop_nags"];
    level thread function_f6a23036659ae65(var_5e531899936a10f9);
  }

  utility::flag_wait_all("flag_lumbermill_allymovement_soap_4", "flag_lumbermill_playerpath_right");
  level thread function_58d26574ebf66c9e();
  utility::flag_wait_all("flag_lumbermill_allymovement_soap_6", "flag_lumbermill_playerpath_right");
  level notify("stop_tundra_nags");
  level.player dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_tund_lmtp_pric_movingtoseconddeck", 1, 5);
  utility::flag_wait("flag_lumbermill_snipersnest_enemies_cleared");
  level.player dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_lmtp_pric_snipersneutralized", 2, 5);
}

function function_58d26574ebf66c9e() {
  level.player endon("death");
  level endon("flag_lumbermill_snipersnest_enemies_cleared");
  level endon("flag_lumbermill_vehicle_spectacle");

  if(utility::flag("flag_lumbermill_snipersnest_enemies_cleared") || utility::flag("flag_lumbermill_vehicle_spectacle")) {
    return;
  }

  utility::flag_wait("flag_lumbermill_stairs_grenade_thrown");
  var_8d474944dae8a65a = utility::get_living_ai("ai_lumbermill_warehouse_shotgun_spawners", "targetname");

  if(!isDefined(var_8d474944dae8a65a)) {
    iprintln("<dev string:x1c>");

    return;
  }

  var_8d474944dae8a65a endon("death");
  var_8d474944dae8a65a dialogue::say("dx_sp_tund_lmtp_kon1_throwinggrenade", 0, 0.5);
}

function function_c590e57c8385b13a() {
  level.player endon("death");
  level endon("flag_lumbermill_player_insnipersnest");
  level endon("flag_lumbermill_snipersnest_enemies_cleared");
  level endon("flag_lumbermill_vehicle_spectacle");

  if(utility::flag("flag_lumbermill_player_insnipersnest") || utility::flag("flag_lumbermill_snipersnest_enemies_cleared") || utility::flag("flag_lumbermill_vehicle_spectacle")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_lmtp_fara_snipersinthewarehous"];
  nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_lmtp_fara_snipersonthesecondfl"];
  nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_lmtp_fara_bravo6konnisduginont"];
  nag_deck = utility::create_deck(nag_aliases);
  var_5e531899936a10f9 = ["flag_lumbermill_player_insnipersnest", "flag_lumbermill_snipersnest_enemies_cleared", "flag_lumbermill_vehicle_spectacle", "flag_tundra_stop_nags"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nag_deck, dialogue::growing_delay(30, 50, 2), 20, 1);
}

function function_f48299c91e352cbf() {
  level.player endon("death");
  level endon("flag_lumbermill_all_enemies_cleared");
  level endon("flag_lumbermill_player_at_exit");
  var_242410025da2c3e9 = 0;
  utility::flag_wait("flag_lumbermill_vehicle_spectacle");
  level.soap dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_lmtp_soap_gotanenemyvehicleinb", 1);
  function_c7c0ef06bcce6c3b();
  level thread function_cbf8a5eda3c4405f();
  level thread function_aab05b95e1cb9b6c();
  msg = level utility::flag_wait_any_return("flag_lumbermill_vehicle_spectacle_end_path", "flag_lumbermill_vehicle_spectacle_dead");

  if(msg == "flag_lumbermill_vehicle_spectacle_end_path") {
    var_242410025da2c3e9 = 1;
    level.farah dialogue::say_team("dx_sp_tund_lmtp_fara_copyiseeitmorekonnic", 1);
    level thread function_efcc552e6de4a0b8();
  }

  utility::flag_wait("flag_lumbermill_vehicle_reinforcement_begin");

  if(!istrue(var_242410025da2c3e9)) {
    level.soap dialogue::function_fc0eb6b81c66c661(2.5, "dx_sp_tund_lmtp_soap_moreenemiesincoming", 1);
  }
}

function function_cbf8a5eda3c4405f() {
  level.player endon("death");
  level endon("flag_lumbermill_all_enemies_cleared");
  level endon("flag_lumbermill_player_at_exit");

  if(utility::flag("flag_lumbermill_all_enemies_cleared") || utility::flag("flag_lumbermill_player_at_exit")) {
    return;
  }

  level waittill("lumbermill_vehicle_player_kill");

  if(utility::cointoss()) {
    player_vo = level.var_64c093dc497ce423 utility::deck_draw();
    level.player dialogue::function_fc0eb6b81c66c661(0.6, player_vo, 1, 5);
  }

  if(utility::cointoss()) {
    soap_vo = level.var_a6e75687fccaf576 utility::deck_draw();
    level.soap dialogue::function_fc0eb6b81c66c661(0.6, soap_vo, 0, 5);
    return;
  }

  var_846fd87dc8e24893 = level.var_9a1fe91cdb332423 utility::deck_draw();
  level.farah dialogue::function_fc0eb6b81c66c661(0.6, var_846fd87dc8e24893, 0, 5);
}

function function_aab05b95e1cb9b6c() {
  level.player endon("death");
  level endon("flag_lumbermill_all_enemies_cleared");
  level endon("flag_lumbermill_player_at_exit");

  if(utility::flag("flag_lumbermill_all_enemies_cleared") || utility::flag("flag_lumbermill_player_at_exit")) {
    return;
  }

  var_56f9f744acd981ad = 0;

  while(true) {
    level waittill("lumbermill_explosive_player_kill");

    if(level dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 2.5)) {
      wait 1;
      continue;
    }

    if(utility::cointoss() || !istrue(var_56f9f744acd981ad)) {
      soap_vo = level.var_a6e75687fccaf576 utility::deck_draw();
      level.soap dialogue::function_fc0eb6b81c66c661(0.8, soap_vo, 0, 1);
      var_56f9f744acd981ad = 1;
    } else {
      var_846fd87dc8e24893 = level.var_9a1fe91cdb332423 utility::deck_draw();
      level.farah dialogue::function_fc0eb6b81c66c661(0.8, var_846fd87dc8e24893, 0, 1);
      var_56f9f744acd981ad = 0;
    }

    wait randomfloatrange(6, 12);
  }
}

function function_efcc552e6de4a0b8() {
  level.player endon("death");
  level endon("flag_lumbermill_vehicle_spectacle_dead");
  level endon("flag_lumbermill_all_enemies_cleared");
  level endon("flag_lumbermill_exit_farah_rappel_ready");
  utility::flag_wait("flag_lumbermill_vehicle_farah_intervention");
  level.farah dialogue::say_team("dx_sp_tund_lmtp_fara_gotyourbacksbravo", 1);
}

function function_eac13aafeb6037f7() {
  level.player endon("death");
  level endon("flag_lumbermill_exit_farah_rappel_ready");
  level endon("flag_lumbermill_complete");
  utility::flag_wait("flag_lumbermill_all_enemies_cleared");
  function_fbab3cc861e5f296("flag_lumbermill_complete");
  level.soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_lmtp_soap_clearareasecure", 1);

  if(utility::flag("flag_lumbermill_lower_forward") && utility::flag("flag_lumbermill_player_on_road")) {
    var_6cdb1ee44ac5c197 = [[level.farah, 0.8, "dx_sp_tund_lmtp_fara_circleupbehindthesaw", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_lmtp_pric_copyrearofthesawmill", &function_e134158b8d96fa58]];
  } else {
    var_6cdb1ee44ac5c197 = [[level.farah, 0.8, "dx_sp_tund_lmtp_fara_goodworkbravo", &function_e134158b8d96fa58], [level.soap, 0.3, "dx_sp_tund_lmtp_soap_youtookilo", &function_e134158b8d96fa58], [level.farah, 0.6, "dx_sp_tund_lmtp_fara_circleupbehindthesaw", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_lmtp_pric_copyrearofthesawmill", &function_e134158b8d96fa58]];
  }

  level.var_bd555fa10c4b7506 = ["flag_lumbermill_exit_farah_rappel_ready", "flag_lumbermill_complete"];
  level dialogue::say_sequence(var_6cdb1ee44ac5c197, 1, 0, 0, 0, "team");
  level thread function_ea1f5e1cb2656ab2();
}

function function_ea1f5e1cb2656ab2() {
  level.player endon("death");
  level endon("flag_lumbermill_exit_farah_rappel_ready");
  level endon("flag_lumbermill_complete");

  if(utility::flag("flag_lumbermill_exit_farah_rappel_ready") || utility::flag("flag_lumbermill_complete")) {
    return;
  }

  nag_aliases = [];
  nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_lmtp_fara_captainwaitinonyoure"];
  nag_aliases[nag_aliases.size] = [level.soap, "dx_sp_tund_lmtp_soap_letsregroupwithkiloc"];
  nag_aliases[nag_aliases.size] = [level.farah, "dx_sp_tund_lmtp_fara_behindthesawmillgeth"];
  nag_deck = utility::create_deck(nag_aliases, 1, 1);
  level dialogue::function_91c23782840cf632(["flag_lumbermill_exit_farah_rappel_ready", "flag_lumbermill_complete", "flag_tundra_stop_nags"], nag_deck, dialogue::growing_delay(20, 50, 3), 15);
}

function function_9d2a772b0c7980bd() {
  level.player endon("death");
  utility::flag_wait("flag_lumbermill_player_approaching_exit");

  if(!utility::flag("flag_lumbermill_all_enemies_cleared")) {
    level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_lmtp_pric_leavethestragglersle", 1);
    level.soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_lmtp_soap_movingaheadtoexfil", 1, 5);
  }

  utility::flag_wait("flag_lumbermill_exit_farah_rappel_ready");
  level.farah dialogue::say_team("dx_sp_tund_lmtp_fara_checkfiredescending", 1);
  msg = level utility::flag_wait_any_return("flag_lumbermill_farah_on_ground", "flag_lumbermill_complete");
  level.farah dialogue::say_team("dx_sp_tund_lmtp_fara_exfilisjustbelowthis", 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_lmtp_pric_letsgettohim", 1);

  if(msg == "flag_lumbermill_farah_on_ground") {
    level thread function_76a28ae3797d3180("flag_lumbermill_complete");
    level utility::flag_wait("flag_lumbermill_complete");
  }

  utility::flag_set("flag_lumbermill_obj_clear_complete");
  level thread function_8900520dba6be4f2();
}

function function_98189a472232d75c() {}

function function_e11990259b9f9756() {
  level thread function_17345a322a7697d7();
  level thread function_48406d9eec7c7818();
  level thread function_d880a496e2d9b013();
  level set_nagvars(0, 5, 0, "team");
}

function function_8900520dba6be4f2() {
  level.player endon("death");
  level endon("flag_cliff_allies_move_5");
  utility::flag_wait("flag_lumbermill_all_enemies_cleared");
  function_fbab3cc861e5f296("flag_cliff_complete");

  if(!function_50f6a8d179cd5108(640)) {
    level thread function_76a28ae3797d3180("flag_cliff_helo_flyby_1");
    return;
  }

  if(getdvarint(@ "loc_language") != 0 && getdvarint(@ "loc_language") != 1) {
    var_1936ae7e96435164 = [[level.shepherd, 2, "dx_sp_tund_lmtp_shep_yourealongwayfromhom", &function_e134158b8d96fa58], [level.farah, 0.2, "dx_sp_tund_clif_fara_soareyougoldeagle", &function_e134158b8d96fa58]];
    level.var_bd555fa10c4b7506 = "flag_cliff_allies_move_5";
    level dialogue::say_sequence(var_1936ae7e96435164, 0, 0, 0, 0, "team");
  } else {
    var_1936ae7e96435164 = [[level.shepherd, 2, "dx_sp_tund_lmtp_shep_yourealongwayfromhom", &function_e134158b8d96fa58], [level.farah, 0.2, "dx_sp_tund_clif_fara_soareyougoldeagle", &function_e134158b8d96fa58], [level.shepherd, 0.4, "dx_sp_tund_lmtp_shep_imgladtoseeyoufarah", &function_e134158b8d96fa58], [level.farah, 0.2, "dx_sp_tund_clif_fara_staysharpandtrynotto", &function_e134158b8d96fa58]];
    level.var_bd555fa10c4b7506 = "flag_cliff_allies_move_5";
    level dialogue::say_sequence(var_1936ae7e96435164, 0, 0, 0, 0, "team");
    wait 1.5;

    if(!utility::flag("flag_cliff_allies_move_5")) {
      level.shepherd thread dialogue::say_team("dx_sp_tund_lmtp_shep_farahihavealwaysha", 1);
      level.farah dialogue::say_team("dx_sp_tund_clif_fara_theresatimeandplacef", 1, 2.8);
    }
  }

  utility::flag_set("flag_cliff_shepherd_farah_vo_complete");
  level thread function_76a28ae3797d3180("flag_cliff_helo_flyby_1");
}

function function_17345a322a7697d7() {
  level.player endon("death");
  level endon("flag_cliff_allies_move_6");
  utility::flag_wait("flag_cliff_helo_flyby_1");
  level thread utility::flag_set_delayed("flag_cliff_helo_flyby_1_complete", 10);
  utility::flag_wait("flag_cliff_shepherd_farah_vo_complete");

  if(utility::flag("flag_cliff_helo_flyby_1_complete") || utility::flag("flag_cliff_helo_flyby_2")) {
    level thread function_76a28ae3797d3180("flag_cliff_snowdrift_start");
    return;
  }

  level notify("stop_tundra_nags");
  level.ghost dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_clif_ghos_allstationswehaveene", 1);
  level.player thread namespace_8339f6377b6ba60e::function_e0f99342614824c0("noncombat", 4);
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_clif_pric_copyholdyourgroundsh", 1);
  level.player thread namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();

  if(!utility::flag("flag_cliff_snowdrift_vo_start") && !utility::flag("flag_cliff_allies_move_5")) {
    level.ghost dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_clif_ghos_rogbringitonthen", 1);
    level thread function_76a28ae3797d3180("flag_cliff_snowdrift_start");
  }
}

function function_48406d9eec7c7818() {
  level.player endon("death");
  level endon("flag_cliff_allies_move_6");
  utility::flag_wait("flag_cliff_snowdrift_start");
  level thread utility::flag_set_delayed("flag_cliff_snowdrift_vo_start", 1.5);
  utility::flag_wait_or_timeout("flag_cliff_allies_move_5", 6);
  level.gaz dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_clif_gazz_windspickingupsnow", 1);
  level thread function_76a28ae3797d3180("flag_cliff_allies_move_6");
}

function function_d880a496e2d9b013() {
  level.player endon("death");
  level endon("flag_end_cliff");
  s_cliff_corpses = getStruct("s_cliff_corpses", "targetname");
  level.soap thread function_1e2fc888d8837d(s_cliff_corpses, "flag_cliff_soap_see_corpses", "flag_shipyard_advance_01");
  msg = utility::flag_wait_any_return("flag_cliff_soap_see_corpses", "flag_cliff_allies_move_6");

  if(msg == "flag_cliff_soap_see_corpses") {
    utility::flag_wait("flag_cliff_allies_move_6");
  }

  level.soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_clif_soap_lookslikekonnidroppe", 0);
  level.ghost dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_clif_ghos_wasntinthemoodforvis", 0);
  level thread function_76a28ae3797d3180("flag_end_cliff");
}

function function_c6ee041d418a7b21() {}

function function_598e0fa2479604b0() {
  level thread function_4d13d32bee820d1e();
  level thread function_e73740513fc54cea();
  level thread function_95e973cb199438b4();
  level thread function_d36065f282f4ef2b();
  level set_nagvars(0, 5, 0, "team");
}

function function_4d13d32bee820d1e() {
  level.player endon("death");
  level endon("flag_shipyard_go_loud");
  level notify("stop_tundra_nags");
  function_fbab3cc861e5f296("flag_shipyard_complete");
  var_6e96161965d302d8 = [[level.farah, 0.4, "dx_sp_tund_shpy_fara_gotmovementahead", &function_e134158b8d96fa58], [level.shepherd, 0.8, "dx_sp_tund_shpy_shep_likelyanambush", &function_e134158b8d96fa58], [level.gaz, 0.4, "dx_sp_tund_shpy_gazz_notanambushifwehitth", &function_e134158b8d96fa58], [level.player, 0.2, "dx_sp_tund_shpy_pric_goodcallgazfarahands", &function_e134158b8d96fa58]];
  level.var_bd555fa10c4b7506 = "flag_shipyard_go_loud";
  level dialogue::say_sequence(var_6e96161965d302d8, 0, 0, 0, 0, "team");
  utility::flag_set("flag_shipyard_intro_allies_move");
  utility::flag_set("flag_shipyard_obj_start");

  if(utility::cointoss()) {
    level.soap dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_shpy_soap_onthemove", 0, 5);
  } else {
    level.gaz dialogue::function_fc0eb6b81c66c661(0.15, "dx_sp_tund_shpy_gazz_letsgogeneral", 0, 5);
  }

  wait 1;
  level thread function_48740263cb40da07(1);
  level thread function_cdf4e1bf2ff03108();
  level thread function_56ef97fc8668418b();
  level thread function_bcb92264050950d5();
  level thread function_ee84d88a7b0c5ad6();
}

function function_48740263cb40da07(var_52bb27ff383611a1) {
  level.player endon("death");
  var_52bb27ff383611a1 = utility::default_to(var_52bb27ff383611a1, 1);

  if(level utility::flag("flag_shipyard_shepherd_feels_good")) {
    return;
  }

  if(istrue(var_52bb27ff383611a1)) {
    str_endon = "flag_shipyard_go_loud";
  } else {
    str_endon = "flag_finale_obj_rendezvous";
  }

  level endon(str_endon);

  while(true) {
    if(function_50f6a8d179cd5108(768)) {
      break;
    }

    wait 1;
  }

  wait randomfloatrange(4, 6);

  if(level utility::flag(str_endon)) {
    return;
  }

  level utility::flag_set("flag_shipyard_shepherd_feels_good");
  level notify("stop_tundra_nags");

  if(istrue(var_52bb27ff383611a1)) {
    var_457dfa81656298e = utility::create_deck(["dx_sp_tund_shpy_shep_feelsgoodtobebehindt", "dx_sp_tund_shpy_shep_elementofsurpriseiso", "dx_sp_tund_shpy_shep_gottheupperhandnow", "dx_sp_tund_shpy_shep_nothinglikehuntinthe", "dx_sp_tund_shpy_shep_everybodyready"], 1, 1);
    var_522769e4f963a5a0 = var_457dfa81656298e utility::deck_draw();
    level.shepherd dialogue::function_fc0eb6b81c66c661(0.2, var_522769e4f963a5a0, 1, 5);
    level.soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_soap_somebodytapehisheads", 1, 2.5);
    wait 3;
    var_522769e4f963a5a0 = var_457dfa81656298e utility::deck_draw();
    level.shepherd dialogue::function_fc0eb6b81c66c661(0.5, var_522769e4f963a5a0, 1, 5);
    level.soap thread dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_tund_shpy_soap_shhhhh", 1, 0.1);
    level.player thread dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_shpy_pric_shhhhh", 1, 0.1);
    level.gaz dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_tund_shpy_gazz_shhhhh", 1, 0.1);
    level.gaz dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_gazz_justpointandshootwhe", 1);
  } else {
    level.shepherd dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_shpy_shep_feelsgoodtobebehindt", 1, 5);
    level.soap dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_soap_somebodytapehisheads", 1, 2.5);
  }

  if(istrue(var_52bb27ff383611a1)) {
    level thread function_cdf4e1bf2ff03108();
    return;
  }

  level thread function_1f5eb9c64a24e71f("flag_finale_obj_rendezvous");
}

function function_56ef97fc8668418b() {
  level.player endon("death");
  level endon("flag_shipyard_go_loud");

  if(utility::flag("flag_shipyard_go_loud")) {
    return;
  }

  var_cd3ab50a2ea9d648 = getStructArray("s_shipyard_icehole", "targetname");
  var_8fc2e8a546bc28d0 = squared(256);
  var_5c2ae70aa4770c13 = squared(512);

  while(true) {
    var_12a30b0065cb3175 = utility::getclosest(level.player.origin, var_cd3ab50a2ea9d648);
    n_dist_sq = distance2dsquared(level.player.origin, var_12a30b0065cb3175.origin);

    if(n_dist_sq < var_8fc2e8a546bc28d0) {
      break;
    } else if(n_dist_sq < var_5c2ae70aa4770c13 && utility::within_fov_of_players(var_12a30b0065cb3175.origin, cos(45))) {
      break;
    }

    wait 1;
  }

  var_4caf35e9283006da = [level.gaz, level.soap, level.farah];

  if(function_50f6a8d179cd5108() && utility::cointoss()) {
    ai_ally = level.shepherd;
  } else {
    ai_ally = utility::getclosest(level.player.origin, var_4caf35e9283006da);
  }

  switch (ai_ally.animname) {
    case #"hash_831c7a280af6bbca":
      level.shepherd dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_shep_theresfissuresinthei", 0, 5);
      break;
    case #"hash_4ba1525745ce470f":
      level.farah dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_fara_couldusetheopenwater", 0, 5);
      break;
    case #"hash_df31f98a0b34e496":
      level.soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_soap_crackintheicecouldma", 0, 5);
      break;
    case #"hash_fb36726c0708cd6d":
    default:
      level.gaz dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_gazz_wecouldswimintotheop", 0, 5);
      break;
  }
}

function function_cdf4e1bf2ff03108() {
  level.player endon("death");
  level endon("flag_shipyard_go_loud");
  level endon("flag_player_ads_on_enemy_long");
  level endon("flag_tundra_stop_nags");

  if(utility::flag("flag_shipyard_go_loud") || utility::flag("flag_player_ads_on_enemy_long")) {
    return;
  }

  var_b9c059671c239ec9 = utility::create_deck(["dx_sp_tund_shpy_gazz_nothinyet", "dx_sp_tund_shpy_gazz_nomovement"], 1, 1);
  soap_lines = utility::create_deck(["dx_sp_tund_shpy_soap_nothingonthermals", "dx_sp_tund_shpy_soap_theyregettinreadytop", "dx_sp_tund_shpy_soap_sneakybastards"], 1, 1);
  var_d2b22935887224a7 = utility::create_deck(["dx_sp_tund_shpy_fara_novisual", "dx_sp_tund_shpy_fara_preparetoengage", "dx_sp_tund_shpy_fara_stayready"], 1, 1);
  var_4caf35e9283006da = [level.gaz, level.soap, level.farah];

  while(true) {
    wait randomfloatrange(8, 16);
    ai_ally = utility::random(var_4caf35e9283006da);

    switch (ai_ally.animname) {
      case #"hash_fb36726c0708cd6d":
        var_dcf900fef166fcf9 = var_b9c059671c239ec9 utility::deck_draw();
        level.gaz dialogue::function_fc0eb6b81c66c661(0.2, var_dcf900fef166fcf9, 0, 5);
        break;
      case #"hash_df31f98a0b34e496":
        soap_vo = soap_lines utility::deck_draw();
        level.soap dialogue::function_fc0eb6b81c66c661(0.2, soap_vo, 0, 5);
        break;
      case #"hash_4ba1525745ce470f":
      default:
        var_846fd87dc8e24893 = var_d2b22935887224a7 utility::deck_draw();
        level.farah dialogue::function_fc0eb6b81c66c661(0.2, var_846fd87dc8e24893, 0, 5);
        break;
    }
  }
}

function function_bcb92264050950d5() {
  level.player endon("death");
  level endon("flag_shipyard_go_loud");

  if(utility::flag("flag_shipyard_go_loud")) {
    return;
  }

  price_lines = utility::create_deck(["dx_sp_tund_shpy_pric_iseeem", "dx_sp_tund_shpy_pric_gotavisual", "dx_sp_tund_shpy_pric_eyesonenemies"], 1, 1);
  level.player waittill("player_ads_on_enemy_long");
  price_vo = price_lines utility::deck_draw();
  level.player dialogue::function_fc0eb6b81c66c661(0.4, price_vo, 0, 5);
  level utility::flag_set("flag_player_ads_on_enemy_long");
}

function function_8a8ad7a837f87ab4() {
  level.player endon("death");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");
  var_be1fab89f09416c7 = [level.soap, level.gaz, level.farah, level.player];
  price_lines = utility::create_deck(["dx_sp_tund_shpy_pric_xraydown", "dx_sp_tund_shpy_pric_terminated", "dx_sp_tund_shpy_pric_dispatched", "dx_sp_tund_shpy_pric_droppedhimforyou", "dx_sp_tund_shpy_pric_baggedhim", "dx_sp_tund_shpy_pric_goodbloodyeffectonta", "dx_sp_tund_shpy_pric_gothim", "dx_sp_tund_shpy_pric_downedhim", "dx_sp_tund_shpy_pric_konnidown", "dx_sp_tund_shpy_pric_burnedanother", "dx_sp_tund_shpy_pric_yourewelcome", "dx_sp_tund_shpy_pric_tookanotherout", "dx_sp_tund_shpy_pric_dontmindifido"], 1, 1);

  while(true) {
    level.player waittill("player_killed_shipyard_enemy");

    if(level dialogue::function_6c31b0b0edd184ed(var_be1fab89f09416c7, 2.5)) {
      wait 3;
      continue;
    }

    price_vo = price_lines utility::deck_draw();
    level.player dialogue::function_fc0eb6b81c66c661(0.8, price_vo, 0, 1);
    wait randomfloatrange(6, 8);
  }
}

function function_ee84d88a7b0c5ad6() {
  level.player endon("death");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");

  while(!level utility::flag("flag_shipyard_player_killed_crane_sniper")) {
    level waittill("shipyard_player_spotted_crane_sniper");

    if(level dialogue::function_6c31b0b0edd184ed(level.var_7a299357d55b1167, 2.5)) {
      wait 1;
      continue;
    }

    if(!utility::flag("flag_shipyard_go_loud")) {
      var_1331595fab8d68f9 = "dx_sp_tund_shpy_pric_eyesonthecranesniper";
    } else if(utility::cointoss()) {
      var_1331595fab8d68f9 = "dx_sp_tund_shpy_pric_sniperonthecrane";
    } else {
      var_1331595fab8d68f9 = "dx_sp_tund_shpy_pric_headsuponthecranesni";
    }

    level utility::flag_set("flag_shipyard_player_spotted_crane_sniper");
    wait 0.4;

    if(!utility::flag("flag_shipyard_player_killed_crane_sniper")) {
      level.player dialogue::say_team(var_1331595fab8d68f9, 1);
    }

    break;
  }

  level utility::flag_wait("flag_shipyard_player_killed_crane_sniper");

  if(utility::cointoss()) {
    level.player dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_tund_shpy_pric_enemysnipersdone", 1, 5);
    return;
  }

  level.player dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_tund_shpy_pric_sniperdown", 1, 5);
}

function function_95e973cb199438b4() {
  level.player endon("death");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");
  ally = level utility::flag_wait("flag_shipyard_go_loud");
  level notify("stop_tundra_nags");
  wait 2;
  ai_enemy_closest = get_closest_ai(level.player.origin, "axis");

  if(isalive(ai_enemy_closest)) {
    ai_enemy_closest dialogue::say("dx_sp_tund_shpy_kon1_openfire", 2, 5);
  }

  dialogue::function_cb329cf8896edeaa(level.player.team, 1, 1);
  thread function_cf7e19a58be845f();

  if(!isDefined(ally) || isPlayer(ally)) {
    ally_name = "price";
  } else {
    ally_name = ally.animname;
  }

  switch (ally_name) {
    case #"hash_4ba1525745ce470f":
      level.farah dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_fara_engaging", 2, 5);
      break;
    case #"hash_fb36726c0708cd6d":
      level.gaz dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_gazz_stitchemup", 2, 5);
      break;
    case #"hash_df31f98a0b34e496":
      level.soap dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_soap_shoottokill", 2, 5);
      break;
    case #"hash_831c7a280af6bbca":
      level.shepherd dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_shep_fireatwill", 2, 5);
      break;
    case #"hash_5b7c6433642710a":
    default:
      level.player dialogue::function_fc0eb6b81c66c661(1, "dx_sp_tund_shpy_pric_slotthem", 2, 5);
      break;
  }

  wait 2;
  level utility::flag_set("flag_shipyard_combat_start");
  level thread function_d6c086816640a7e7();
  level thread function_8a8ad7a837f87ab4();
  level thread function_739fb6bb11fd8d62();
  level thread function_4f4ff55580e5f321();
  level thread function_6d6336a5d54ce677();
}

function function_cf7e19a58be845f() {
  setmusicstate("mx_tundra_shipyard");
}

function function_739fb6bb11fd8d62() {
  level.player endon("death");
  level endon("flag_shipyard_rpgs_spawn");
  level endon("flag_shipyard_advance_06");

  if(utility::flag("flag_shipyard_advance_06") || utility::flag("flag_shipyard_rpgs_spawn")) {
    return;
  }

  level utility::flag_wait("flag_shipyard_right_jltv_1_spawn");
  level.gaz dialogue::function_fc0eb6b81c66c661(3, "dx_sp_tund_shpy_gazz_headsupenemyvehiclea", 2, 10);
  level utility::flag_wait_any_timeout(20, "flag_shipyard_jltv_1_enemies_player_killed", "flag_shipyard_jltv_2_enemies_player_killed");

  if(level utility::flag("flag_shipyard_jltv_1_enemies_player_killed") || level utility::flag("flag_shipyard_jltv_2_enemies_player_killed")) {
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_shpy_pric_gotyourback", 2, 10);
    level.gaz dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_gazz_thanksfortheassistca", 2, 5);
    return;
  }

  level.gaz dialogue::function_fc0eb6b81c66c661(3, "dx_sp_tund_shpy_gazz_takingeffectivefirea", 2, 10);
  level utility::flag_wait_any("flag_shipyard_jltv_1_enemies_player_killed", "flag_shipyard_jltv_2_enemies_player_killed");
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_shpy_pric_gotyourback", 2, 10);
  level.gaz dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_gazz_thanksfortheassistca", 2, 5);
}

function function_4f4ff55580e5f321() {
  level.player endon("death");
  level endon("flag_shipyard_rpgs_spawn");
  level endon("flag_shipyard_advance_06");

  if(utility::flag("flag_shipyard_advance_06") || utility::flag("flag_shipyard_rpgs_spawn")) {
    return;
  }

  level utility::flag_wait("flag_shipyard_left_cargo_ship_spawn");
  level.farah dialogue::function_fc0eb6b81c66c661(3, "dx_sp_tund_shpy_fara_enemiesspottedonthec", 2, 10);
  level utility::flag_wait_or_timeout("flag_shipyard_cargo_ship_enemies_player_killed", 20);

  if(level utility::flag("flag_shipyard_cargo_ship_enemies_player_killed")) {
    level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_shpy_pric_gotyourback", 2, 10);
    level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_fara_targetsdownniceone", 2, 5);
    return;
  }

  level.soap dialogue::function_fc0eb6b81c66c661(3, "dx_sp_tund_shpy_soap_takinheatfromthecarg", 2, 10);
  level utility::flag_wait("flag_shipyard_cargo_ship_enemies_player_killed");
  level.player dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_shpy_pric_gotyourback", 2, 10);
  level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_shpy_fara_targetsdownniceone", 2, 5);
}

function function_6d6336a5d54ce677() {
  level.player endon("death");
  level endon("flag_shipyard_rpgs_dead");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");
  utility::flag_wait("flag_shipyard_rpgs_spawn");
  level.soap dialogue::function_fc0eb6b81c66c661(2, "dx_sp_tund_shpy_soap_rpgsupahead", 3);
  level thread function_3e2101a6eacfed18();
  wait randomfloatrange(10, 15);
  level.gaz dialogue::say_team("dx_sp_tund_shpy_gazz_rpgreloadingtakehimo", 1, 5);
}

function function_3e2101a6eacfed18() {
  level.player endon("death");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");
  killer = level utility::flag_wait("flag_shipyard_rpgs_dead");

  if(isDefined(killer) && isDefined(killer.name)) {
    killer_name = killer.name;
  } else {
    killer_name = "Price";
  }

  switch (killer_name) {
    case #"hash_cdcc1d2789d3b46a":
      level.player dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_shpy_pric_rpgsdown", 1, 5);
      break;
    case #"hash_82f0a93f8012d56f":
      level.farah dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_shpy_fara_rpgseliminated", 1, 5);
      break;
    case #"hash_156ffa4f8b089876":
      level.soap dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_shpy_soap_rpgisdownandout", 1, 5);
      break;
    case #"hash_911a182f27f7afaa":
      level.shepherd dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_shpy_shep_thatrpgsisoutgoodwor", 1, 5);
      break;
    case #"hash_e9e6926c847ca2cd":
    default:
      level.gaz dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_shpy_gazz_rpgsneutralized", 1, 5);
      break;
  }
}

function function_d6c086816640a7e7() {
  level.player endon("death");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");
  var_d3f553759508129a = [level.soap, level.gaz, level.farah];
  level utility::flag_wait("flag_shipyard_mid_enemies_spawn");
  count = 0;

  while(count < 10) {
    if(level utility::flag("flag_shipyard_mid_right_fallback") || level utility::flag("flag_shipyard_mid_left_fallback")) {
      break;
    }

    if(level dialogue::function_6c31b0b0edd184ed(var_d3f553759508129a, 2.5)) {
      count++;
      wait 3;
      continue;
    }

    ai_ally = utility::random(var_d3f553759508129a);

    switch (ai_ally.name) {
      case #"hash_156ffa4f8b089876":
        if(utility::cointoss()) {
          level.soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_soap_theyrepushingupwithr", 1, 10);
        } else {
          level.soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_soap_morekonnigunnerscomi", 1, 10);
        }

        break;
      case #"hash_e9e6926c847ca2cd":
        if(utility::cointoss()) {
          level.gaz dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_gazz_morekonniclosing", 1, 10);
        } else {
          level.gaz dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_gazz_enemyreinforcementsi", 1, 10);
        }

        break;
      case #"hash_82f0a93f8012d56f":
      default:
        if(utility::cointoss()) {
          level.farah dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_fara_theyresendingmoretro", 1, 10);
        } else {
          level.farah dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_fara_youvegotmoreenemyrei", 1, 10);
        }

        break;
    }

    break;
  }

  utility::flag_wait_any("flag_shipyard_mid_right_fallback", "flag_shipyard_mid_left_fallback");
  count = 0;

  while(count < 10) {
    if(level dialogue::function_6c31b0b0edd184ed(var_d3f553759508129a, 2.5)) {
      count++;
      wait 3;
      continue;
    }

    ai_ally = utility::random(var_d3f553759508129a);

    switch (ai_ally.name) {
      case #"hash_156ffa4f8b089876":
        level.soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_soap_theirranksarethinnin", 1, 10);
        break;
      case #"hash_e9e6926c847ca2cd":
        level.gaz dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_gazz_keeppushingthemback", 1, 10);
        break;
      case #"hash_82f0a93f8012d56f":
      default:
        level.farah dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_fara_theyrefallingback", 1, 10);
        break;
    }

    break;
  }
}

function function_11cdb259bdf39829() {
  struct = spawnStruct();
  struct.var_c3009147dcf60068 = [level.soap, level.farah, level.gaz];
  struct.var_c10d2942800a1777 = utility::create_deck(["dx_sp_tund_shpy_soap_rogerthermals", "dx_sp_tund_shpy_soap_usethesnowforcover"], 1, 1);
  struct.var_a2247dfd13c8839c = utility::create_deck(["dx_sp_tund_shpy_fara_switchingtothermals", "dx_sp_tund_shpy_fara_theycantseeusthrough"], 1, 1);
  struct.var_308f717582aec896 = utility::create_deck(["dx_sp_tund_shpy_gazz_thermalsup", "dx_sp_tund_shpy_gazz_theyllloseusintheflu"], 1, 1);
  struct.var_64d82867a3e6dfb1 = utility::create_deck(["dx_sp_tund_shpy_kon1_icanbarelyseeouthere", "dx_sp_tund_shpy_kon2_lostvisualsdamnsnow", "dx_sp_tund_shpy_kon2_cantseethemthroughth", "dx_sp_tund_shpy_kon3_weathersnotonourside"], 1, 1);
  struct.var_32aa95a919f88e69 = utility::create_deck(["dx_sp_tund_shpy_kon1_targetsobscuredbythe", "dx_sp_tund_shpy_kon2_thinkiseemovement", "dx_sp_tund_shpy_kon2_dontlosevisual", "dx_sp_tund_shpy_kon3_thinkiseeone"], 1, 1);
  return struct;
}

function function_e73740513fc54cea() {
  level.player endon("death");
  level endon("flag_shipyard_advance_06");
  level endon("flag_shipyard_complete");

  if(utility::flag("flag_shipyard_advance_06")) {
    return;
  }

  struct = function_11cdb259bdf39829();
  var_4caf35e9283006da = [level.gaz, level.soap, level.farah];
  var_70a3b0ab307a153e = level.gaz;
  level utility::flag_wait("flag_shipyard_snowdrift_on");
  var_74385e8102cf05f2 = utility::getclosest(level.player.origin, var_4caf35e9283006da);

  switch (var_74385e8102cf05f2.name) {
    case #"hash_82f0a93f8012d56f":
      level.farah dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_fara_snowincoming", 0, 5);
      var_70a3b0ab307a153e = level.farah;
      break;
    case #"hash_156ffa4f8b089876":
      level.soap dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_soap_windspickingup", 0, 5);
      var_70a3b0ab307a153e = level.soap;
      break;
    case #"hash_911a182f27f7afaa":
      level.shepherd dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_shep_thatllkillyourvisibi", 0, 5);
      var_70a3b0ab307a153e = level.shepherd;
      break;
    case #"hash_e9e6926c847ca2cd":
    default:
      level.gaz dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_shpy_gazz_flurryscomingin", 0, 5);
      break;
  }

  level utility::flag_wait_all("flag_shipyard_start_first_encounter", "flag_shipyard_go_loud", "flag_shipyard_combat_start");
  count = 0;

  while(count < 8) {
    level utility::flag_wait_all("flag_shipyard_snowdrift_vo", "flag_shipyard_snowdrift_on");

    if(utility::cointoss()) {
      level utility::flag_wait_or_timeout("flag_shipyard_snowdrift_off", 10);
      continue;
    }

    ai_enemy_closest = get_closest_ai(level.player.origin, "axis");
    var_4caf35e9283006da = array_remove(var_4caf35e9283006da, var_70a3b0ab307a153e);
    var_dce8d1a7bd6241a0 = random(var_4caf35e9283006da);
    waitframe();
    var_4caf35e9283006da = array_add(var_4caf35e9283006da, var_70a3b0ab307a153e);
    var_70a3b0ab307a153e = var_dce8d1a7bd6241a0;

    if(isDefined(ai_enemy_closest) && cointoss()) {
      if(utility::cointoss()) {
        var_dce8d1a7bd6241a0 function_7d1e811a6492e59(struct);
        wait randomfloatrange(1, 3);
        ai_enemy_closest function_288bc6a79ae2cf4d(struct);
      } else {
        ai_enemy_closest function_288bc6a79ae2cf4d(struct);
        wait randomfloatrange(1, 3);
        var_dce8d1a7bd6241a0 function_7d1e811a6492e59(struct);
      }
    } else {
      var_dce8d1a7bd6241a0 function_7d1e811a6492e59(struct);
    }

    count++;
    utility::flag_wait_or_timeout("flag_shipyard_snowdrift_off", 10);
  }
}

function function_7d1e811a6492e59(struct) {
  level.player endon("death");

  if(utility::flag("flag_shipyard_advance_06")) {
    return;
  }

  switch (self.name) {
    case #"hash_156ffa4f8b089876":
      var_21fe59cc8a1876a9 = struct.var_c10d2942800a1777 deck_draw();
      break;
    case #"hash_82f0a93f8012d56f":
      var_21fe59cc8a1876a9 = struct.var_a2247dfd13c8839c deck_draw();
      break;
    case #"hash_e9e6926c847ca2cd":
    default:
      var_21fe59cc8a1876a9 = struct.var_308f717582aec896 deck_draw();
      break;
  }

  dialogue::function_fc0eb6b81c66c661(0.2, var_21fe59cc8a1876a9, 0, 5);
}

function function_288bc6a79ae2cf4d(struct) {
  self endon("death");

  if(utility::flag("flag_shipyard_advance_06")) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.enemy)) {
    var_21fe59cc8a1876a9 = struct.var_32aa95a919f88e69 utility::deck_draw();
  } else {
    var_21fe59cc8a1876a9 = struct.var_64d82867a3e6dfb1 utility::deck_draw();
  }

  dialogue::say_delayed(0.2, var_21fe59cc8a1876a9, 0, 5);
}

function function_d36065f282f4ef2b() {
  level.player endon("death");
  utility::flag_wait_any("flag_shipyard_all_enemies_dead", "flag_shipyard_complete");
  function_fbab3cc861e5f296("flag_finale_holdout_02");
  thread function_c05cf05fd797df97();

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    var_51303fab85a0d55b = [[level.farah, 1.2, "dx_sp_tund_shpy_fara_shipyardsallclear", &function_e134158b8d96fa58], [level.player, 0.4, "dx_sp_tund_shpy_pric_goodgunsbravosolidsh", &function_e134158b8d96fa58], [level.shepherd, 0.4, "dx_sp_tund_shpy_shep_thisisntoveruntilwer", &function_e134158b8d96fa58], [level.player, 0.6, "dx_sp_tund_fnsg_pric_ghostwerecomingtoyou", &function_e134158b8d96fa58], [level.ghost, 0.3, "dx_sp_tund_fnsg_ghos_ropinglzneartheboatn", &function_e134158b8d96fa58]];
  } else {
    var_51303fab85a0d55b = [[level.player, 0.2, "dx_sp_tund_lmtp_pric_leavethestragglersle", &function_e134158b8d96fa58], [level.soap, 0.4, "dx_sp_tund_lmtp_soap_movingaheadtoexfil", &function_e134158b8d96fa58], [level.player, 0.6, "dx_sp_tund_fnsg_pric_ghostwerecomingtoyou", &function_e134158b8d96fa58], [level.ghost, 0.3, "dx_sp_tund_fnsg_ghos_ropinglzneartheboatn", &function_e134158b8d96fa58]];
  }

  level.var_bd555fa10c4b7506 = "flag_finale_holdout_04";
  level dialogue::say_sequence(var_51303fab85a0d55b, 2, 0, 0, 0, "team");
  level utility::flag_set("flag_shipyard_outro_vo_complete");
  level utility::flag_set("flag_shipyard_obj_clear_complete");
  level thread function_1f5eb9c64a24e71f("flag_finale_obj_rendezvous");
  wait 1;
  level thread function_48740263cb40da07(0);
}

function function_c05cf05fd797df97() {
  stopmusicstate("mx_tundra_shipyard");
}

function function_9f50f8e62d96949() {}

function function_3ec4cb695ece5957() {
  level thread function_9d56e644d304f4dd();
  level thread function_d23cfeaab5555a56();
  level thread function_f17ed5a52ae9ceb3();
  level thread function_ddbda0e54912d315();
  level set_nagvars(0, 5, 0, "team");
}

function function_9d56e644d304f4dd() {
  level.player endon("death");
  utility::flag_wait("flag_shipyard_outro_vo_complete");
  level notify("stop_tundra_nags");
  level.soap dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_tund_fnsg_soap_spottedeyesonlt", 1, 10);
  level utility::flag_wait("flag_finale_holdout_allies_start_moving");

  if(level utility::flag("flag_finale_holdout_02")) {
    if(utility::cointoss()) {
      level.farah dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fnsg_fara_onyoucaptainexfilism", 1, 10);
    } else {
      level.gaz dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fnsg_gazz_exfilpointaheadonyou", 1, 10);
    }
  } else {
    level.soap dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fnsg_soap_ghostswaitingonussix", 1, 10);
  }

  wait 1;
  level thread function_1f5eb9c64a24e71f("flag_finale_player_near_holdout");
}

function function_1f5eb9c64a24e71f(endon_flag) {
  level.player endon("death");

  if(utility::flag(endon_flag)) {
    return;
  }

  level endon(endon_flag);

  if(!isDefined(level.var_9720dd089e63e575)) {
    aliases = [];
    aliases[aliases.size] = [level.gaz, "dx_sp_tund_fnsg_gazz_thelieutenantsholdin"];
    aliases[aliases.size] = [level.ghost, "dx_sp_tund_fnsg_ghos_holdinguphereforyous"];
    aliases[aliases.size] = [level.ghost, "dx_sp_tund_fnsg_ghos_movetothemarkprice"];
    aliases[aliases.size] = [level.farah, "dx_sp_tund_fnsg_fara_weshouldgettoghostca"];
    aliases[aliases.size] = [level.soap, "dx_sp_tund_fnsg_soap_readywhenyouaresir"];
    aliases[aliases.size] = [level.soap, "dx_sp_tund_fnsg_soap_letsnotstickaroundca"];
    level.var_9720dd089e63e575 = utility::create_deck(aliases, 1, 1);
  }

  level dialogue::function_91c23782840cf632([endon_flag, "flag_tundra_stop_nags"], level.var_9720dd089e63e575, dialogue::growing_delay(20, 45, 5), 15);
}

function function_d23cfeaab5555a56() {
  level.player endon("death");
  utility::flag_wait("flag_finale_holdout_intro_enemies_all_dead");
  level notify("stop_tundra_nags");
  level.gaz dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_fnc1_gazz_allclear", 1);

  if(!utility::flag("flag_finale_obj_rendezvous_complete")) {
    level.ghost dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_fnsg_ghos_thiswaybravo", 1, 5);
  }

  level thread function_1f5eb9c64a24e71f("flag_finale_obj_rendezvous_complete");
  utility::flag_wait("flag_finale_obj_rendezvous_complete");
  level notify("stop_tundra_nags");

  if(utility::cointoss()) {
    level.laswell dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_fnsn_lasw_johnwhatsyourstatus", 1);
    level.player thread namespace_8339f6377b6ba60e::function_e0f99342614824c0("noncombat", 4);
    level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_fnsn_pric_atthelzneedtoholdpos", 1);
    level.player thread namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();
  } else {
    level.laswell dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_fnsn_lasw_johnwhatsthesitrep", 1);
    level.player thread namespace_8339f6377b6ba60e::function_e0f99342614824c0("noncombat", 4);
    level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_fnsn_pric_lzishotgetnikinbound", 1);
    level.player thread namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();
  }

  level.ghost dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_tund_fnsn_ghos_gearuptheyllbemoreof", 1);
  utility::flag_set("flag_finale_holdout_intro_dialogue_complete");
  level notify("stop_tundra_nags");
}

function function_f17ed5a52ae9ceb3() {
  level.player endon("death");
  level endon("flag_finale_holdout_final_enemies_all_dead");
  level endon("flag_finale_holdout_complete");
  utility::flag_wait_all("flag_finale_holdout_intro_dialogue_complete", "flag_finale_holdout_wave_1_incoming");
  thread signal_music();
  level.farah dialogue::function_fc0eb6b81c66c661(1.8, "dx_sp_tund_fnsn_fara_konnireinforcementso", 1);
  level thread function_86a4bed491761b54();
  level thread function_2c5fd8fdbab39976();
  level thread function_af31315b4b3819d1();
  utility::flag_wait("flag_finale_holdout_wave_2_incoming");
  level.ghost dialogue::function_fc0eb6b81c66c661(2.5, "dx_sp_tund_fnsn_ghos_konnivehiclesincomin", 1);
  level.shepherd dialogue::function_fc0eb6b81c66c661(1.2, "dx_sp_tund_fnsn_shep_theysentawholegoddam", 1);

  if(level utility::flag("flag_finale_holdout_wave_1_enemies_most_dead")) {
    level.player dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_fnsn_pric_keeplayingdownfirewe", 1, 5);
  }

  utility::flag_wait("flag_finale_holdout_wave_3_incoming");
  level.ghost dialogue::function_fc0eb6b81c66c661(2.5, "dx_sp_tund_fnsn_ghos_gotmorekonnivehicles", 1);
  utility::flag_wait("flag_finale_holdout_wave_3_flank");
  level.shepherd dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_fnsn_gazz_theyreflankingus", 1);
  level.player dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_fnsn_pric_bravoshiftleft", 1);
  wait randomfloatrange(15, 25);

  if(!level utility::flag("flag_finale_holdout_final_enemies_most_dead")) {
    n_nag = randomint(5);

    switch (n_nag) {
      case 0:
        level.gaz dialogue::say_team("dx_sp_tund_fnsn_gazz_needtoclearthelz", 0, 5);
        break;
      case 1:
        level.farah dialogue::say_team("dx_sp_tund_fnsn_fara_stillhavetargetsinsi", 0, 5);
        break;
      case 2:
        level.shepherd dialogue::say_team("dx_sp_tund_fnsn_shep_weneedaclearhlz", 0, 5);
        break;
      case 3:
        level.ghost dialogue::say_team("dx_sp_tund_fnsn_ghos_laydownfire", 0, 5);
        break;
      case 4:
      default:
        level.soap dialogue::say_team("dx_sp_tund_fnsn_soap_clearthelz", 0, 5);
        break;
    }
  }
}

function function_ddbda0e54912d315() {
  level.player endon("death");
  level endon("flag_finale_holdout_complete");
  utility::flag_wait("flag_finale_holdout_final_enemies_all_dead");
  level.player dialogue::function_fc0eb6b81c66c661(1.4, "dx_sp_tund_fnex_pric_bravoweclear", 2);
  level.ghost dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_fnex_ghos_clear", 2);
  utility::flag_set("flag_finale_holdout_clear_dialogue_played");
}

function function_af31315b4b3819d1() {
  level.player endon("death");
  level endon("flag_finale_holdout_player_shot_something");
  level endon("flag_finale_holdout_final_enemies_all_dead");
  level endon("flag_finale_holdout_complete");
  wait 10;
  aliases = [];
  aliases[aliases.size] = [level.ghost, "dx_sp_tund_fnsn_ghos_priceweneedtoputfire"];
  aliases[aliases.size] = [level.ghost, "dx_sp_tund_fnsn_ghos_priceweneedfocusedfi"];
  aliases[aliases.size] = [level.shepherd, "dx_sp_tund_fnsn_shep_stayinthisgunfightca"];
  aliases[aliases.size] = [level.shepherd, "dx_sp_tund_fnsn_shep_needyourguntoclearth"];
  aliases[aliases.size] = [level.gaz, "dx_sp_tund_fnsn_gazz_weneedyourgunonthisc"];
  aliases[aliases.size] = [level.gaz, "dx_sp_tund_fnsn_gazz_priceweneedyourgunon"];
  aliases[aliases.size] = [level.soap, "dx_sp_tund_fnsn_soap_needtoshootthesebast"];
  aliases[aliases.size] = [level.soap, "dx_sp_tund_fnsn_soap_helpusburythesebasta"];
  aliases[aliases.size] = [level.farah, "dx_sp_tund_fnsn_fara_letsclearforexfilcap"];
  aliases[aliases.size] = [level.farah, "dx_sp_tund_fnsn_fara_captainyouneedtoenga"];
  aliases[aliases.size] = [level.farah, "dx_sp_tund_fnsn_fara_captainpriceweneedyo"];
  nags = utility::create_deck(aliases, 1, 0);
  var_5e531899936a10f9 = ["flag_finale_holdout_player_shot_something", "flag_finale_holdout_wave_1_enemies_most_dead", "flag_finale_holdout_wave_2_incoming"];
  level dialogue::function_91c23782840cf632(var_5e531899936a10f9, nags, dialogue::growing_delay(10, 30, 4), 5);
}

function function_2c5fd8fdbab39976() {
  level.player endon("death");
  level endon("flag_finale_holdout_complete");
  level endon("flag_finale_holdout_final_enemies_all_dead");
  var_bdba4b1e9813ab3c = utility::create_deck(["dx_sp_tund_fnsn_pric_enemyvehiclesareclea", "dx_sp_tund_fnsn_pric_targetseliminated"]);
  function_c7c0ef06bcce6c3b();
  var_cfaa87260584477 = "soap";
  count = 0;

  while(true) {
    level waittill("player_killed_jltv");
    count++;

    if(count >= 7) {
      break;
    }

    if(utility::cointoss()) {
      player_vo = level.var_64c093dc497ce423 utility::deck_draw();
      level.player dialogue::function_fc0eb6b81c66c661(0.8, player_vo, 0, 5);
    }

    if(var_cfaa87260584477 != "ghost") {
      ghost_vo = level.var_73375e405a553918 utility::deck_draw();
      level.ghost dialogue::function_fc0eb6b81c66c661(0.6, ghost_vo, 0, 2.5);
      var_cfaa87260584477 = "ghost";
    } else if(utility::cointoss()) {
      var_846fd87dc8e24893 = level.var_9a1fe91cdb332423 utility::deck_draw();
      level.farah dialogue::function_fc0eb6b81c66c661(0.6, var_846fd87dc8e24893, 0, 2.5);
      var_cfaa87260584477 = "farah";
    } else {
      soap_vo = level.var_a6e75687fccaf576 utility::deck_draw();
      level.soap dialogue::function_fc0eb6b81c66c661(0.6, soap_vo, 0, 2.5);
      var_cfaa87260584477 = "soap";
    }

    wait randomfloatrange(6, 12);
  }

  player_vo = var_bdba4b1e9813ab3c utility::deck_draw();
  level.player dialogue::function_fc0eb6b81c66c661(0.8, player_vo, 0, 5);
}

function function_86a4bed491761b54() {
  level.player endon("death");
  level endon("flag_finale_holdout_final_enemies_all_dead");
  level endon("flag_finale_holdout_complete");
  var_ed511c0053908091 = utility::create_deck(["dx_sp_tund_fnsn_ghos_stayneartheboat", "dx_sp_tund_fnsn_ghos_stayneartheboat", "dx_sp_tund_fnsn_ghos_stickclosetotheboat", "dx_sp_tund_fnsn_ghos_meetbackattheboat", "dx_sp_tund_fnsn_ghos_needyouonstationcapt"], 1, 1);
  var_569e6aa271bccb17 = utility::create_deck(["dx_sp_tund_fnsn_shep_sticktotheboatjohn", "dx_sp_tund_fnsn_shep_coulduseyoursupporta"], 1, 1);

  while(true) {
    utility::flag_waitopen("flag_finale_player_near_holdout");
    var_602b675bc7e0b70f = 0;

    while(!utility::flag("flag_finale_player_near_holdout")) {
      if(utility::cointoss()) {
        var_522769e4f963a5a0 = var_569e6aa271bccb17 utility::deck_draw();
        level.shepherd dialogue::function_fc0eb6b81c66c661(0.3, var_522769e4f963a5a0, 2, 5);
      } else {
        ghost_vo = var_ed511c0053908091 utility::deck_draw();
        level.ghost dialogue::function_fc0eb6b81c66c661(0.3, ghost_vo, 2, 5);
      }

      var_602b675bc7e0b70f += 5;
      wait randomfloatrange(10, 20) + var_602b675bc7e0b70f;
    }

    wait 1;
  }
}

function signal_music() {
  setmusicstate("mx_tundra_signal");
}

function function_d2c16582a6060fe5() {
  stopmusicstate("mx_tundra_signal");
}

function function_1bbbfa7ea42e346f() {}

function function_b8d9607e1e2b1692() {
  level thread function_9ed9cd232d9905f4();
  level thread function_dcd4b4138cae1b7();
  level set_nagvars(0, 0, 0, "team");

  if(scripts\sp\starts::is_after_start("finale_holdout")) {
    thread signal_music();
  }
}

function function_9ed9cd232d9905f4() {
  level.player endon("death");
  level endon("flag_finale_exfil_heli_land_end");
  thread function_d2c16582a6060fe5();
  level.player dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_fnex_pric_nikwhatsyoureta", 2);
  level.nikolai dialogue::function_fc0eb6b81c66c661(0.6, "dx_sp_tund_fnex_niko_touchingdowninthirty", 2);
  a_ai_enemies = getaiarray("axis");
  var_10a2dfb59e0d9ef4 = utility::getclosest(level.player.origin, a_ai_enemies, 2048);

  if(utility::flag("flag_finale_holdout_final_enemies_all_dead") || utility::flag("flag_finale_holdout_final_enemies_most_dead") && !isDefined(var_10a2dfb59e0d9ef4)) {
    var_f1dad81169c01e1e = [[level.player, 0.4, "dx_sp_tund_fnex_pric_lzsclear", &function_e134158b8d96fa58], [level.nikolai, 0.4, "dx_sp_tund_fnex_niko_copyapproachingnowca", &function_e134158b8d96fa58]];
  } else if(utility::flag("flag_finale_holdout_final_enemies_most_dead") && isDefined(var_10a2dfb59e0d9ef4)) {
    var_f1dad81169c01e1e = [[level.nikolai, 0.6, "dx_sp_tund_fnex_niko_looksliketheressomes", &function_e134158b8d96fa58], [level.player, 0.4, "dx_sp_tund_fnex_pric_welltakecareofthemju", &function_e134158b8d96fa58], [level.nikolai, 0.3, "dx_sp_tund_fnex_niko_cominginhot", &function_e134158b8d96fa58]];
  } else {
    var_f1dad81169c01e1e = [[level.nikolai, 0.6, "dx_sp_tund_fnex_niko_youstillhavecontactb", &function_e134158b8d96fa58], [level.player, 0.4, "dx_sp_tund_fnex_pric_wellholdemoffjustget", &function_e134158b8d96fa58], [level.nikolai, 0.3, "dx_sp_tund_fnex_niko_cominginhot", &function_e134158b8d96fa58]];
  }

  level.var_bd555fa10c4b7506 = "flag_finale_exfil_heli_land_end";
  level dialogue::say_sequence(var_f1dad81169c01e1e, 1, 0, 0, 0, "team");
}

function function_dcd4b4138cae1b7() {
  level.player endon("death");
  level endon("flag_finale_exfil_outro_begin");
  utility::flag_wait("flag_finale_exfil_heli_land_end");
  utility::flag_set("flag_finale_obj_exfil");

  if(utility::cointoss()) {
    level.nikolai dialogue::say_team("dx_sp_tund_fnex_niko_landed", 2);
  } else {
    level.nikolai dialogue::say_team("dx_sp_tund_fnex_niko_touchdown", 2);
  }

  a_ai_enemies = getaiarray("axis");
  var_10a2dfb59e0d9ef4 = utility::getclosest(level.player.origin, a_ai_enemies, 2048);

  if(isDefined(var_10a2dfb59e0d9ef4)) {
    level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_tund_fnex_pric_theyreretreatinggett_01", 2);
  } else {
    level.nikolai dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_tund_fnex_niko_readywhenyouarecapta", 2);
  }

  level thread function_ecd724ad539bcdf9();
}

function function_ecd724ad539bcdf9() {
  level endon("flag_finale_exfil_outro_begin");
  aliases = [];
  aliases[aliases.size] = [level.nikolai, "dx_sp_tund_fnex_niko_getincaptain"];
  aliases[aliases.size] = [level.nikolai, "dx_sp_tund_fnex_niko_comeoncaptain"];
  aliases[aliases.size] = [level.nikolai, "dx_sp_tund_fnex_niko_letsgosix"];
  aliases[aliases.size] = [level.shepherd, "dx_sp_tund_fnex_shep_weneedtogetthisbirdi"];
  aliases[aliases.size] = [level.shepherd, "dx_sp_tund_fnex_shep_itistimetogocapn"];
  aliases[aliases.size] = [level.shepherd, "dx_sp_tund_fnex_shep_getaboardjohn"];
  aliases[aliases.size] = [level.gaz, "dx_sp_tund_fnex_gazz_nikswaiting"];
  aliases[aliases.size] = [level.gaz, "dx_sp_tund_fnex_gazz_sixweneedtogo"];
  aliases[aliases.size] = [level.gaz, "dx_sp_tund_fnex_gazz_captainweneedtogo"];
  aliases[aliases.size] = [level.farah, "dx_sp_tund_fnex_fara_weneedtoleavebeforem"];
  aliases[aliases.size] = [level.soap, "dx_sp_tund_fnex_soap_letsgocaptain"];
  nags = utility::create_deck(aliases, 1, 1);
  level dialogue::nag_wait("flag_finale_exfil_outro_begin", nags, dialogue::growing_delay(10, 20, 5), 5);
}