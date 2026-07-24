/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_arrival.gsc
***************************************************/

_id_6DDA() {
  scripts\sp\maps\titan\titan_code::_id_10733();
  thread _id_6DD8();
  scripts\engine\utility::flag_set("first_steps_vision_fx");
  scripts\sp\maps\titan\titan_code::_id_BC52("pod_exit");
  thread scripts\sp\maps\titan\titan_code::_id_D250(1);
  scripts\engine\utility::exploder("fx_landing_zone");
  scripts\engine\utility::exploder("fx_landing_zone2");
  scripts\engine\utility::flag_wait("intro_final_jump");
  wait 0.05;

  if(!level.console)
    waitforalltransients();
}

_id_6DD7() {
  level._id_C47F thread scripts\sp\utility::_id_61F0(200);
  level._id_B33E thread scripts\sp\utility::_id_61F0(175);
  thread _id_6DD8();
  thread _id_134B6();
  scripts\engine\utility::flag_wait("building1_approach");
  scripts\engine\utility::exploder("cell_storm_1");
  scripts\engine\utility::flag_wait("intro_final_jump");
  wait 0.05;

  if(!level.console)
    waitforalltransients();
}

_id_6DD9() {
  var_0 = getEntArray("trigger_multiple_flag_set_touching", "classname");
}

_id_6DD8() {
  var_0 = 0.5;
  scripts\engine\utility::flag_wait("intro_final_jump");
  wait 0.05;

  if(!level.console)
    waitforalltransients();
}

_id_134B6() {
  level endon("wall_scene_vo_start");
  level endon("armory_entered");
  wait 0.25;
  level.player thread scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_1102B);
  level.player scripts\engine\utility::delaycall(2, ::playsound, "ges_plr_radio_off");
  scripts\sp\maps\titan\titan_code::_id_D1D5("titan_plr_greentogo");
  wait 0.75;
  level.player thread scripts\sp\utility::play_sound_on_entity("titan_bgs_hometomamma");
  wait 4.5;
  scripts\sp\maps\titan\titan_code::_id_A556("titan_brk_anyonegetthat");
  level._id_C47F thread scripts\sp\maps\titan\titan_code::_id_1958(level._id_B33E);
  scripts\sp\maps\titan\titan_code::_id_C48A("titan_usf_meetusatthelz");
  level._id_C47F _id_0C4C::_id_1964(0.5);
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_commsignals");
  wait 0.5;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_lookslikehome");
  level._id_B33B thread scripts\sp\maps\titan\titan_code::_id_1958(level._id_C47F);
  level._id_C47F thread scripts\sp\maps\titan\titan_code::_id_1958(level._id_B33B);
  wait 0.1;
  level._id_C47F thread _id_0C4C::_id_1964(0.5);
  level._id_B33B _id_0C4C::_id_1964(0.5);
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_atm_wasnthalfbad");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_tookaboatride");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_seenbetterdays");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_atm_whydidyourdad");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_makeabetterlife");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_atm_didhefight");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_leavethesergeant");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_idontmind");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_32ndarmored");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_victoryordeath");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_survivedtwo");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_appledidntfall");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_fellfarenough");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_32ndwasarmy");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_fellfarenough");
  scripts\engine\utility::flag_wait("intro_final_jump");
  wait 0.05;

  if(!level.console)
    waitforalltransients();
}

_id_1286E() {
  self endon("stop_trying_gesture");
  thread scripts\sp\utility::_id_C12D("stop_trying_gesture", 3);

  for(;;) {
    level.player scripts\engine\utility::allow_offhand_shield_weapons(0);
    var_0 = scripts\sp\utility::_id_D08C("ges_radio");

    if(var_0) {
      level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
      level.player scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_1102B);
      level.player scripts\engine\utility::delaycall(2, ::playsound, "ges_plr_radio_off");
      level.player scripts\engine\utility::delaythread(2, scripts\engine\utility::allow_offhand_shield_weapons, 1);
      return 1;
    }

    wait 0.15;
  }

  scripts\engine\utility::flag_wait("intro_final_jump");
  wait 0.05;

  if(!level.console)
    waitforalltransients();
}

_id_31F5() {
  thread scripts\sp\maps\titan\titan_code::_id_D250(1);
  scripts\engine\utility::exploder("fx_landing_zone");
  scripts\engine\utility::exploder("cell_storm_1");
  scripts\sp\maps\titan\titan_code::_id_BC52("building1_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  scripts\sp\maps\titan\titan_code::_id_BC71("building1_ai");
  setaudiotriggerstate("default", "wind_medium", 0);
  setaudiotriggerstate("titan_ext", "wind_medium", 0);
  setaudiotriggerstate("indoorrooms", "wind_medium", 0);
  scripts\sp\utility::_id_15F5("building1_color_trig_05");
  scripts\engine\utility::flag_set("squad_enter_building1");
}

_id_31F3() {
  thread _id_31F6();
  thread _id_31E7();
  thread _id_31E4();
  thread _id_31E8();
  thread _id_31E3();
  thread _id_31F2();
  level._id_C47F scripts\sp\maps\titan\titan_stealth_street::_id_8E36();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_10F2A();
  var_0 = getEntArray("freighter_ships", "targetname");

  foreach(var_2 in var_0)
  var_2 show();

  scripts\sp\utility::_id_E820("ai_demeanor_trig", scripts\sp\maps\titan\titan_code::_id_1939);
  thread _id_225D();
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  scripts\engine\utility::flag_wait("squad_enter_building1");
  thread _id_138C4();
  level._id_C47F thread scripts\sp\utility::_id_5522();
  level._id_B33E thread scripts\sp\utility::_id_5522();
  level._id_B33E thread _id_841D();
  level._id_2429 thread _id_8421();

  foreach(var_5 in level._id_10AC8)
  var_5 thread scripts\sp\utility::_id_F2DA(0);

  thread scripts\sp\maps\titan\titan_stealth_street::_id_D2E0();
  scripts\engine\utility::flag_wait("building1_exit");

  foreach(var_5 in level._id_8E42)
  var_5.script_pushable = 1;
}

_id_8421() {
  var_0 = getnode("wall_scene_ethan", "targetname");
  scripts\sp\utility::_id_F3E0(24);
  self setgoalpos(var_0.origin);
}

_id_31F4() {
  scripts\sp\utility::_id_10FEC("landing_amb_fx");

  if(isDefined(level._id_B33E))
    level._id_B33E scripts\sp\utility::_id_F3B5("orange");

  if(isDefined(level._id_2429))
    level._id_2429 scripts\sp\utility::_id_F3B5("orange");

  level.player scripts\sp\utility::_id_F526("normal");
  thread scripts\sp\maps\titan\titan_stealth_street::_id_D2E0();
}

_id_225D() {
  level endon("building1_exit");
  scripts\engine\utility::flag_wait("armory_entered");
  level endon("building1_entered");
  wait 1;
  var_0 = ["titan_atm_wheredoyoulive", "titan_usf_gotalittleranch", "titan_atm_doyouhavehorses", "titan_usf_twoappaloosas", "titan_atm_rideahorsesomeday", "titan_plr_wannabeacowboy"];

  foreach(var_2 in var_0) {
    scripts\sp\maps\titan\titan_code::_id_134B7(var_2);
    wait(randomfloatrange(0.05, 0.15));
  }

  scripts\sp\maps\titan\titan_code::_id_134B7("titan_atm_cowboyhat");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_atm_iboughtitintexas");
  thread scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_laugh");
  wait 0.7;
  thread scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_hellacrazy");
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_cometomyranch");
  thread scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_idpaytoseethat");
  wait 2.5;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_laugh");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_itsgonnabeabig");
}

_id_31E7() {
  scripts\engine\utility::flag_wait("building1_entered");
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::flag_wait("do_wall_scene_poster");
  level notify("wall_scene_vo_start");
}

_id_31F6() {
  scripts\engine\utility::flag_wait("storm_building_event");
  wait 6;
  thread scripts\sp\maps\titan\titan_code::_id_D24F();
}

_id_138C4() {
  level endon("building1_exit");
  level._id_C47F._id_240F = 0;
  var_0 = scripts\engine\utility::getStruct("wall_scene", "targetname");
  var_1 = [level._id_C47F, level._id_B33B];

  foreach(var_3 in var_1) {
    var_3._id_1389C = spawnStruct();
    var_3._id_1389C.origin = var_0.origin;
    var_3._id_1389C.angles = var_0.angles;
    var_3 scripts\sp\utility::_id_54F7();
  }

  scripts\engine\utility::array_thread(var_1, ::_id_138C2);
  level._id_2429 thread _id_13641();
  thread _id_138C5();
  thread _id_138C7();
  var_5 = scripts\engine\utility::getStruct("wall_scene_interact", "targetname");
  var_5 thread _id_0E46::_id_48C4();
  var_5 waittill("trigger");
  var_6 = level._id_C47F;
  var_7 = getstartorigin(var_6._id_1389C.origin, var_6._id_1389C.angles, var_6 scripts\sp\utility::_id_7DC1("wall_response"));
  var_8 = distance(var_6.origin, var_7);

  if(level._id_C47F._id_240F || var_8 <= 450)
    scripts\engine\utility::flag_set("do_wall_scene");
  else {
    level.player freezecontrols(1);
    level.player scripts\engine\utility::delaycall(0.15, ::freezecontrols, 0);
    scripts\engine\utility::array_thread(var_1, ::_id_138C3);
  }

  var_9 = [level._id_2429, level._id_B33E];

  foreach(var_6 in var_9) {
    var_8 = distance(var_6.origin, var_5.origin);

    if(var_8 > 550) {
      var_5 = scripts\engine\utility::getStruct(var_6._id_1FBB + "_building1_teleport", "targetname");
      var_6 _meth_80F1(var_5.origin, var_5.angles);
    }
  }
}

_id_138C7() {
  level endon("building1_exit");
  level waittill("wall_scene_vo_start");
  thread scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_igotsomething");
  scripts\engine\utility::delaythread(3, scripts\sp\maps\titan\titan_code::_id_134B7, "titan_eth_thisplacewasnice");
  scripts\engine\utility::delaythread(12.2, scripts\sp\maps\titan\titan_code::_id_134B7, "titan_brk_yeahidont");
  var_0 = 20;
  var_1 = 0;

  foreach(var_3 in level._id_10AC8) {
    var_3 scripts\engine\utility::delaythread(var_0 + var_1, ::_id_841D);
    var_1 = var_1 + 1.5;
  }
}

_id_31E8() {
  level endon("building1_exit");
  var_0 = scripts\sp\maps\titan\titan_code::_id_7988("crib_trigger");
  var_1 = scripts\engine\utility::getStruct("crib_look_at", "targetname");
  var_0 waittill("trigger");
  wait 0.5;
  var_2 = level._id_B33E;
  var_3 = distance(var_2.origin, var_1.origin);

  if(var_3 <= 200)
    level._id_B33E scripts\sp\utility::_id_10346("titan_ksh_thisshitsmessedup");
}

_id_138C2() {
  level endon("building1_exit");
  self endon("wall_scene_instant");
  self endon("buddy_door");
  var_0 = getnode("wall_scene_" + self._id_1FBB, "targetname");
  scripts\sp\utility::_id_54F7();
  self.goalradius = 24;
  self._id_138CF = var_0;
  thread _id_0B77::_id_8409(var_0);
  thread _id_13641();
  scripts\engine\utility::flag_wait("do_wall_scene");
  thread scripts\sp\maps\titan\titan_code::_id_10FC2();
  self._id_1389C scripts\sp\anim::_id_1F17(self, "wall_response");

  if(self == level._id_C47F)
    scripts\engine\utility::flag_set("do_wall_scene_poster");

  self._id_1389C scripts\sp\anim::_id_1F35(self, "wall_response");
  scripts\engine\utility::flag_set("wall_scene_complete");
}

_id_841D() {
  if(!scripts\engine\utility::flag("building1_exit")) {
    var_0 = getnode("room2_" + self._id_1FBB, "targetname");
    self _meth_82EE(var_0);
    thread scripts\sp\maps\titan\titan_code::_id_8CA5();
  }
}

_id_13641() {
  level endon("do_wall_scene");
  level endon("building1_exit");
  self endon("wall_scene_instant");
  self endon("buddy_door");
  self waittill("goal");
  thread _id_119BC();
}

_id_119BC() {
  level endon("building1_exit");
  self endon("wall_scene_instant");
  self endon("buddy_door");

  for(;;) {
    thread scripts\sp\utility::_id_7799(level.player, 1, 0.25);
    thread scripts\sp\utility::_id_7792(level.player);
    wait(randomfloatrange(2.8, 7.6));
    scripts\sp\utility::_id_77B9(0.5);
    wait(randomfloatrange(3.2, 8.5));
  }
}

_id_138C3() {
  self endon("buddy_door");
  self notify("wall_scene_instant");
  scripts\engine\utility::flag_set("do_wall_scene");
  scripts\engine\utility::flag_set("do_wall_scene_poster");
  self._id_1389C scripts\sp\anim::_id_1F35(self, "wall_response");
  scripts\engine\utility::flag_set("wall_scene_complete");
}

_id_138C5() {
  var_0 = scripts\engine\utility::getStruct("wall_scene", "targetname");
  var_1 = scripts\sp\utility::_id_10639("poster_rip", var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "wall_response");
  scripts\engine\utility::flag_wait("do_wall_scene_poster");
  var_0 scripts\sp\anim::_id_1F35(var_1, "wall_response");
}

_id_62EC() {
  if(scripts\engine\utility::flag("wall_scene_complete")) {
    return;
  }
  level notify("stop_wall_scene");

  foreach(var_1 in level._id_10AC8)
  var_1 _id_10FC0();
}

_id_10FC0() {
  self notify("buddy_door");
  scripts\sp\utility::anim_stopanimScripted();
  self notify("single_anim", "end");
  self notify("stop_going_to_node");
  self notify("new_anim_reach");
  scripts\sp\utility::_id_F3DC(self.origin);
}

_id_31E3() {
  scripts\engine\utility::flag_wait("first_building_blocker_flag");
  setsaveddvar("cg_drawplayershadow", 0);
  var_0 = getEnt("first_building_blocker", "targetname");
  var_0 moveTo(var_0.origin + (0, 35, 700), 0.5);

  if(isDefined(level._id_5D6C))
    level._id_5D6C delete();
}

#using_animtree("player");

_id_31E4() {
  scripts\engine\utility::flag_wait("building1_entered");
  var_0 = scripts\engine\utility::getStruct("building1_exit_door_anim_ent", "targetname");
  var_1 = scripts\sp\utility::_id_10639("building1_debris", var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "building1_exit");
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_0.origin, var_0.angles);
  level.player._id_1E9C hide();
  level.player._id_1E9C dontcastshadows();
  level.player scripts\sp\utility::_id_65E0("ready_to_open_door");
  var_2 = [level.player._id_1E9C, var_1];
  var_3 = [level._id_B33B, level._id_B33E, level._id_C47F, level._id_2429];
  var_4 = scripts\engine\utility::array_combine(var_2, var_3);

  foreach(var_6 in var_4) {
    if(isDefined(var_6._id_1EB7))
      var_6._id_1EB7 delete();

    var_6._id_1EB7 = spawnStruct();
    var_6._id_1EB7.origin = var_0.origin;
    var_6._id_1EB7.angles = var_0.angles;
  }

  level.player._id_1E9C._id_1EB7 scripts\sp\anim::_id_1EC3(level.player._id_1E9C, "building1_exit");
  var_8 = getanimlength(%titan_abandoned_building_plr_buddy_door_open);
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  var_9 = scripts\engine\utility::getStruct("building1_exit_door_interact", "targetname");
  var_9 thread _id_0E46::_id_48C4();
  scripts\sp\utility::_id_B979(var_9, "stand");
  thread _id_FB46();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\titan\titan_code::_id_11003);
  scripts\engine\utility::flag_set("building1_exit");
  level notify("building1_exit");
  _id_62EC();
  scripts\engine\utility::exploder("cell_storm_2");
  scripts\engine\utility::exploder("fx_falling_dust_exit");
  scripts\sp\maps\titan\titan_code::_id_D85C();
  level.player _meth_823C(level.player._id_1E9C, "tag_player", 0.4, 0.2, 0.2);
  wait 0.4;
  level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 0, 5, 5, 5, 5, 1);
  level.player._id_1E9C scripts\engine\utility::delaycall(0.1, ::show);
  thread scripts\sp\maps\titan\gen\titan_art::_id_99F6(0.1, 13.0);

  foreach(var_11 in var_4)
  var_11._id_1EB7 thread scripts\sp\anim::_id_1F35(var_11, "building1_exit");

  foreach(var_11 in var_3) {
    var_14 = getanimlength(var_11 scripts\sp\utility::_id_7DC1("building1_exit"));
    var_11 thread _id_31F0(var_14);
  }

  scripts\sp\utility::_id_10FEC("fx_landing_zone");
  scripts\sp\utility::_id_10FEC("fx_landing_zone2");
  thread _id_31E5();
  scripts\engine\utility::delaythread(var_8, scripts\sp\maps\titan\titan_code::_id_DF3E);
  level.player._id_1E9C scripts\engine\utility::delaycall(var_8, ::delete);
  thread scripts\engine\utility::flag_set_delayed("building1_buddy_door_complete", var_8);
  thread _id_FB45();
  wait(var_8 + 1);
  scripts\sp\utility::_id_10FEC("landing_amb_fx");
  scripts\sp\utility::_id_10FEC("cell_storm_1");
  scripts\engine\utility::flag_wait("player_exits_building1");
  level notify("stealth_section_started");
  scripts\sp\utility::_id_266F();
}

_id_31E5() {
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_givemeahand");
  wait 6;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_objectivenag1");
  level notify("start_building1_exit_vo");
}

_id_31F0(var_0) {
  wait(var_0 + 0.5);

  if(self == level._id_2429) {
    level._id_2429 scripts\sp\utility::_id_F3B5("o");
    scripts\engine\utility::flag_set("ethan_start_group_split");
  }

  if(self == level._id_C47F) {
    level._id_C47F scripts\sp\utility::_id_F3B5("r");
    scripts\sp\utility::_id_15F5("squad_exit_pos");
  }

  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_51E1("combat");

  if(self == level._id_B33B || self == level._id_B33E)
    self notify(self._id_1FBB + "_start_group_split");
}

_id_869C() {
  var_0 = [];
  var_0[0] = level._id_2429;
  var_0[1] = level._id_B33B;
  var_0[2] = level._id_B33E;
  var_1 = scripts\engine\utility::getStruct("group_split_animnode", "targetname");
  level._id_B33B thread _id_8699("group_split_marine_1_node", "marine1_start_group_split");
  level._id_B33E thread _id_8699("group_split_marine_2_node", "marine2_start_group_split");
  scripts\engine\utility::flag_wait("ethan_start_group_split");
  var_1 scripts\sp\anim::_id_1F17(level._id_2429, "group_split");
  var_1 scripts\sp\anim::_id_1F35(level._id_2429, "group_split");
  level._id_2429 scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_15F5("overwatch_cliff_color_trig");
}

_id_8699(var_0, var_1) {
  level endon("stealth_street_entered");
  self endon("stop_group_split_idle");
  self waittill(var_1);
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F3DD(4);
  scripts\sp\utility::_id_F3D9(getnode(var_0, "targetname"));
  self waittill("goal");
  thread scripts\sp\anim::_id_1EEA(self, "group_split_idle", "stop_group_split_idle");
  scripts\sp\utility::_id_61C7();
}

_id_31F2() {
  level endon("building1_exit");
  scripts\engine\utility::flag_wait("building1_start_room2");

  if(!scripts\engine\utility::flag("do_wall_scene"))
    scripts\engine\utility::array_thread(level._id_10AC8, ::_id_841D);
}

_id_FB46() {
  level.player playSound("scn_titan_debris_lerp");
  wait 0.3;
  level.player playSound("scn_titan_beam_lift");
  level.player _meth_82C0("titan_building_one_exit", 3.0);
  wait 5.0;
  level.player clearclienttriggeraudiozone(20.0);
}

_id_FB45() {
  wait 13;
  level.player playSound("scn_titan_beam_under_plr");
  wait 1;
  level.player playSound("scn_titan_beam_fall");
}

_id_31EB() {
  scripts\sp\maps\titan\titan_code::_id_BC52("building1_exit_player");
  scripts\engine\utility::flag_set("exit_building_1_vision_fx");
  scripts\sp\maps\titan\titan_code::_id_10733();
  scripts\sp\maps\titan\titan_code::_id_BC71("building1_exit_ai");
  level._id_C47F scripts\sp\maps\titan\titan_stealth_street::_id_8E36();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_10F2A();
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_15F5, "gate_guys_trigger");
  scripts\engine\utility::flag_set("building1_buddy_door_complete");
  setaudiotriggerstate("default", "wind_heavy", 0);
  setaudiotriggerstate("titan_ext", "wind_heavy", 0);
  setaudiotriggerstate("indoorrooms", "wind_heavy", 0);
  scripts\engine\utility::exploder("cell_storm_2");
  scripts\sp\utility::_id_15F5("squad_exit_pos");
  level waittill("group_split_has_run");
  scripts\engine\utility::flag_set("ethan_start_group_split");
  level._id_B33B notify("marine1_start_group_split");
  level._id_B33E notify("marine2_start_group_split");
}

_id_31E9() {
  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  thread _id_D5E7();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_76E7();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_F10F("gate_guys");
  thread scripts\sp\maps\titan\titan_stealth_street::_id_6ED1("gate_guys");
  thread scripts\sp\maps\titan\titan_stealth_street::_id_10F2E();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_35B3();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_10F05();
  thread scripts\sp\maps\titan\titan_code::_id_5195("gate_guys", "stealth2_start");
  thread scripts\sp\maps\titan\titan_code::_id_5195("reinforce_1", "stealth2_start");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_51E1, "combat");
  thread _id_31EC();
  thread _id_869C();
  level notify("group_split_has_run");
  level._id_C47F thread scripts\sp\maps\titan\titan_stealth_street::_id_11126();
  scripts\engine\utility::flag_wait("omar_heads_to_slide");
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  level._id_C47F thread scripts\sp\maps\titan\titan_stealth_street::_id_C48E();
  thread scripts\sp\maps\titan\titan_stealth_street::_id_C491();
  scripts\engine\utility::flag_wait("stealth_street_approach");
  level._id_C47F scripts\sp\maps\titan\titan_code::_id_8DEC(1);
  scripts\engine\utility::flag_wait("stealth_street_arrive");
}

_id_D5E7() {
  level endon("stealth_street3_started");
  level.player waittill("is_sliding");
  var_0 = scripts\engine\utility::play_loopsound_in_space("titan_hill_slide_plr_loop_lr", level.player.origin);
  var_0 linkTo(level.player);

  for(;;) {
    if(level.player scripts\sp\utility::_id_65DF("is_sliding") && level.player scripts\sp\utility::_id_65DB("is_sliding")) {
      wait 0.05;
      continue;
    }

    break;
  }

  var_0 stoploopsound();
}

_id_31EA() {
  var_0 = getEntArray("convo_trigger", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_off);

  if(isDefined(level._id_C47F))
    level._id_C47F scripts\sp\maps\titan\titan_code::_id_8DEC(1);
}

_id_31EC() {
  level waittill("start_building1_exit_vo");
  setmusicstate("mx_239_titan_first_bunker");
  thread stealth_broken_music();
  var_0 = ["titan_omr_brookskashimapr", "titan_ksh_check,", "titan_brk_sergeant", "titan_plr_ethanbackemup", "titan_eth_sir"];
  scripts\sp\maps\titan\titan_code::_id_48BD(var_0);
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_enemyactivityde");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_theseguardshave");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_siryourhudcantr");
  scripts\engine\utility::flag_wait("stealth_street_approach");

  if(!scripts\engine\utility::flag("stealth_spotted")) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_beadvisedscouts");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_rogletsswingwid");
  }
}

stealth_broken_music() {
  scripts\engine\utility::flag_wait("stealth_spotted");
  setmusicstate("mx_382_titan_stealth");
  wait 6;
  scripts\engine\utility::flag_waitopen("stealth_spotted");
  setmusicstate("");
}

_id_1351F() {
  level endon("squad_to_reveal");
  scripts\engine\utility::flag_set("vista_scene_started");
  var_0[0] = "titan_usf_dontseeeveryday";
  var_0[1] = "titan_atm_onedayontitan";
  var_0[2] = "titan_ksh_threedaysunset";
  var_0[3] = "titan_brk_evenkashima";
  var_0[4] = "titan_usf_keepheadingup";
  var_0[5] = "titan_usf_leadtheway";
  wait 1;
  childthread scripts\sp\maps\titan\titan_code::_id_48BD(var_0);
}