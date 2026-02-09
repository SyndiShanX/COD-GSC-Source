/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_harbor_code_vo.gsc
**********************************************/

_id_4AD8(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }
  common_scripts\utility::flag_wait("npcs_spawned");
  maps\_utility::_id_11F4("nyharbor_rno_inposition");
  maps\_utility::_id_11F4("nyharbor_lns_radiocheck");
  maps\_utility::_id_11F4("nyharbor_sel_fivebyfive");
  maps\_utility::_id_11F4("nyharbor_lns_starttheparty");
  maps\_utility::_id_11F4("nyharbor_sel_copythat");
  maps\_utility::_id_11F4("nyharbor_rno_dontstart");
  wait 1;
  maps\_utility::_id_11F4("nyharbor_lns_almostthrough");
  common_scripts\utility::flag_wait("tunnel_linkup_dialogue");
  maps\_utility::_id_11F4("nyharbor_rno_gotout");
  maps\_utility::_id_11F4("nyharbor_lns_forthem");
  wait 4;
  maps\_utility::_id_11F4("nyharbor_lns_linkup");
  common_scripts\utility::flag_wait("tunnel_tracker_dialogue");
  maps\_utility::_id_11F4("nyharbor_sel_ontracker");
  maps\_utility::_id_11F4("nyharbor_lns_approachingrv");
  common_scripts\utility::flag_wait("up_ahead_vo");
  maps\_utility::_id_11F4("nyharbor_lns_upahead");
  maps\_utility::_id_11F4("nyharbor_rno_iseethem");
  common_scripts\utility::flag_wait("leaving_tunnel");
  wait 2;
  maps\_utility::_id_11F4("nyharbor_sel_intercept");
  maps\_utility::_id_11F4("nyharbor_lns_leadtheway");
  common_scripts\utility::flag_set("light_toggle_on_1");
}

_id_4AD9(var_0) {
  maps\_utility::_id_11F4("nyharbor_lns_entrypoint");
}

_id_4ADA(var_0) {
  level endon("russian_sub_event");

  if(isDefined(var_0)) {
    wait(var_0);
  }
  maps\_utility::_id_11F4("nyharbor_sel_watchsonar");
  wait 2;
  maps\_utility::_id_11F4("nyharbor_lns_eyesonsonar");
  common_scripts\utility::flag_wait("mine_2");
  maps\_utility::_id_11F4("nyharbor_rno_mine");
  maps\_utility::_id_11F4("nyharbor_lns_keepitsteady");
  common_scripts\utility::flag_wait("mine_3");
  maps\_utility::_id_11F4("nyharbor_lns_right");
  common_scripts\utility::flag_wait("mine_5");
  maps\_utility::_id_11F4("nyharbor_lns_anothermine");
  wait 1;
  maps\_utility::_id_11F4("nyharbor_lns_clear");
}

_id_4ADB(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }
  maps\_utility::_id_11F4("nyharbor_lns_powerdown");
  wait 3;
  maps\_utility::_id_11F4("nyharbor_sel_targetapproaching");
  wait 8;
  maps\_utility::_id_11F4("nyharbor_sel_steady");
  wait 8;
  maps\_utility::_id_11F4("nyharbor_lns_waittilpasses");
  common_scripts\utility::flag_wait("sdvs_chase_sub");
  maps\_utility::_id_11F4("nyharbor_lns_okaygo");
  thread _id_4ADD();
  wait 3;
  maps\_utility::_id_11F4("nyharbor_lns_getinposition");
  maps\_utility::_id_11F4("nyharbor_sel_planting");
  wait 1.5;
  maps\_utility::_id_11F4("nyharbor_rno_planting");

  if(!common_scripts\utility::flag("vo_stop_mine_nag")) {
    maps\_utility::_id_11F4("nyharbor_lns_plantjaywick");
  }
  common_scripts\utility::flag_wait("submine_planted");
  wait 3;
  maps\_utility::_id_11F4("nyharbor_lns_minesarmed");
  maps\_utility::_id_11F4("nyharbor_sel_goodjob");
  maps\_utility::_id_11F4("nyharbor_lns_goingexplosive");
  wait 1;
  maps\_utility::_id_11F4("nyharbor_lns_commencingassault");
  maps\_utility::_id_11F4("nyharbor_hqr_primaryobjective");
  wait 2.5;
  maps\_utility::_id_11F4("nyharbor_lns_holdposition");
}

_id_4ADC() {
  level endon("stop_sdv_follow_nag");
  var_0 = [];
  var_0[var_0.size] = "nyharbor_lns_hurryup";
  var_0[var_0.size] = "nyharbor_lns_frostmove";
  var_1 = undefined;
  var_2 = 10;
  var_3 = 20;

  for(;;) {
    common_scripts\utility::flag_wait("vo_sdv_follow_nag");
    var_4 = randomfloatrange(var_2, var_3);
    var_5 = common_scripts\utility::random(var_0);

    if(isDefined(var_1) && var_5 == var_1) {
      continue;
    } else {
      var_1 = var_5;
      maps\_utility::_id_11F4(var_5);
      wait(var_4);
    }
  }
}

_id_4ADD() {
  var_0 = [];
  var_0[var_0.size] = "nyharbor_lns_plantyourmine";
  var_0[var_0.size] = "nyharbor_lns_frostgetinposition";
  var_0[var_0.size] = "nyharbor_lns_hurryup";
  var_0[var_0.size] = "nyharbor_lns_frostmove";
  var_1 = undefined;
  var_2 = 10;
  var_3 = 20;

  while(!common_scripts\utility::flag("vo_stop_mine_nag")) {
    var_4 = randomfloatrange(var_2, var_3);
    var_5 = common_scripts\utility::random(var_0);

    if(isDefined(var_1) && var_5 == var_1) {
      continue;
    } else {
      var_1 = var_5;
      wait(var_4);

      if(!common_scripts\utility::flag("vo_stop_mine_nag")) {
        maps\_utility::_id_11F4(var_5);
      }
    }
  }
}

_id_4ADE() {
  common_scripts\utility::flag_wait("vo_hatch_open");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_hatchopening");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_comingout");
  common_scripts\utility::flag_wait("vo_frag_out");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_fragout");
  common_scripts\utility::flag_wait("vo_frag_out_clear");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_clearheaddown");
  common_scripts\utility::flag_set("sandman_talking_on_deck");
}

_id_4ADF() {
  level endon("hatch_player_using_ladder");
  common_scripts\utility::flag_wait("sub_exterior_guys_dead");
  common_scripts\utility::flag_wait("sandman_talking_on_deck");
  wait 1;
  level._id_4AE0 maps\_utility::_id_168C("nyharbor_trk_decksecured");
  wait 3.0;

  if(!common_scripts\utility::flag("hatch_player_using_ladder")) {
    level._id_4AE1 maps\_utility::_id_168C("nyharbor_rno_headdown");
  }
  wait 5;

  if(!common_scripts\utility::flag("hatch_player_using_ladder")) {
    level._id_4AE0 maps\_utility::_id_168C("nyharbor_trk_jobtodo");
  }
  wait 5;

  if(!common_scripts\utility::flag("hatch_player_using_ladder")) {
    level._id_4AE1 maps\_utility::_id_168C("nyharbor_rno_downthere");
  }
  common_scripts\utility::flag_wait("sub_exterior_hind_1_fire");
  level._id_4AE0 maps\_utility::_id_168C("nyharbor_trk_incominghind");
}

_id_4AE2() {
  common_scripts\utility::flag_wait("vo_sub_interior_1");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_unknowns");
  common_scripts\utility::flag_wait("vo_go_downstairs");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_rvdownstairs");
}

_id_00AA() {
  common_scripts\utility::flag_wait("barracks_exit_nag_vo");
  var_0 = [];
  var_0[0] = "nyharbor_snd_downstairs";
  var_0[1] = "nyharbor_lns_rvdownstairs";
  var_1 = 0;

  while(!common_scripts\utility::flag("sandman_paired_kill") && !common_scripts\utility::flag("barracks_move_sandman")) {
    level._id_45C0 maps\_utility::_id_168C(var_0[var_1]);

    if(var_1 == 0) {
      var_1 = 1;
    } else {
      var_1 = 0;
    }
    wait 6;
  }
}

_id_4AE3() {
  common_scripts\utility::flag_wait("barracks_vo");
}

_id_4AE4() {
  common_scripts\utility::flag_wait("sandman_paired_kill_complete");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_stairsclear");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_takeleft");
  common_scripts\utility::flag_wait("reactor_room_announcement");
  thread _id_4AE5();
  maps\_utility::_id_11F4("nyharbor_rpa_evacuate");
}

_id_4AE5() {
  wait 2.5;
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_scuttle");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_takepoint");
}

_id_4AE6() {
  common_scripts\utility::flag_wait("vo_to_bridge");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_tothebridge2");
}

_id_4AE7() {
  common_scripts\utility::flag_wait("vo_wait_at_door");
  wait 1;

  if(!common_scripts\utility::flag("ready_for_breach")) {
    level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_atthedoor2");
    wait 0.05;
  }

  common_scripts\utility::flag_wait("vo_breach");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_kickercharge");
  level._id_45C0 setlookatentity();
  common_scripts\utility::flag_wait("breach_guys_dead");
  wait 2;
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_areasecure");
}

_id_4AE8(var_0) {
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_launchkeys");
}

_id_4AE9() {
  level waittill("start_missilekey");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_missilekey");
  level notify("gridcoords");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_launchin30");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_console");
  common_scripts\utility::flag_set("sub_control_room_player_to_controls");
  maps\_utility::delaythread(6, ::_id_4AED);
}

_id_4AEA(var_0) {
  thread _id_4AE9();
  common_scripts\utility::flag_set("vo_sandman_checkpointneptune");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_checkpointneptune");
  maps\_utility::_id_11F4("nyharbor_hqr_copyneptune");
  level waittill("gridcoords");
  maps\_utility::_id_11F4("nyharbor_hqr_coordinates");
}

_id_4AEB(var_0) {
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_321turn");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_missiles");
  common_scripts\utility::flag_set("vo_bridge_is_done");
  maps\_utility::_id_11F4("nyharbor_hqr_teaminposition");
  level._id_45C0 maps\_utility::_id_168C("nyharbor_lns_gogo");
  maps\_audio::aud_send_msg("mus_to_the_zodiac");
}

_id_4AEC() {
  common_scripts\utility::flag_wait("vo_sub_interior_6");
}

_id_4AED() {
  wait 1;
  var_0 = [];
  var_0[0] = "nyharbor_lns_overhere";
  var_0[1] = "nyharbor_lns_console";
  var_1 = 0;

  while(!common_scripts\utility::flag("player_at_controls")) {
    level._id_45C0 maps\_utility::_id_168C(var_0[var_1]);

    if(var_1 == 0) {
      var_1 = 1;
    } else {
      var_1 = 0;
    }
    wait 6;
  }
}

_id_4AEE(var_0) {
  if(isalive(self)) {
    maps\_utility::_id_168C(var_0);
  } else {
    wait 100;
  }
}

_id_4AEF(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }
  common_scripts\utility::flag_wait("sub_exit_player_going_out_hatch");
  wait 3;
  level._id_45C0 _id_4AEE("nyharbor_lns_letsroll");
  maps\_utility::_id_11F4("nyharbor_rno_amentothat");
  common_scripts\utility::flag_wait("player_on_boat");
  level._id_45C0 _id_4AEE("nyharbor_lns_punchit");
  wait 1;
  level._id_45C0 _id_4AEE("nyharbor_lns_missileslaunching");
  common_scripts\utility::flag_wait("zubrs");
  level._id_45C0 _id_4AEE("nyharbor_lns_keepup");
  common_scripts\utility::flag_wait("spawn_hind01");
  wait 4;
  level._id_45C0 _id_4AEE("nyharbor_lns_gunit");
  common_scripts\utility::flag_wait("vo_missiles_incoming");
  level._id_45C0 _id_4AEE("nyharbor_lns_missilescoming");
  wait 2;
  level._id_45C0 _id_4AEE("nyharbor_lns_keepongoing");
  common_scripts\utility::flag_wait("start_boat_crash");
  wait 1;
  level._id_45C0 _id_4AEE("nyharbor_lns_lookout");
  wait 0.5;
  level._id_45C0 _id_4AEE("nyharbor_lns_shootmines");
  common_scripts\utility::flag_wait("spawn_chinook");
  wait 2;
  level._id_45C0 _id_4AEE("nyharbor_lns_theresourbird");
  common_scripts\utility::flag_wait("switch_chinook");
  wait 3;
  level._id_45C0 _id_4AEE("nyharbor_lns_theresheis");
  wait 0;
  maps\_utility::_id_11F4("nyharbor_plt_feetwet");
  common_scripts\utility::flag_wait("finale_dialogue");
  wait 3;
  level._id_45C0 _id_4AEE("nyharbor_lns_missioncomplete");
  maps\_utility::_id_11F4("nyharbor_hqr_oneforbooks");
  level._id_45C0 _id_4AEE("nyharbor_lns_easyday");
}