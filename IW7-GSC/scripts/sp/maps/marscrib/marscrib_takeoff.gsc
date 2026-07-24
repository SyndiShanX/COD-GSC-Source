/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrib\marscrib_takeoff.gsc
*********************************************************/

_id_6E6F() {
  scripts\engine\utility::flag_init("takeoff_end");
  scripts\engine\utility::flag_init("player_enters_dropship");
  scripts\engine\utility::flag_init("dropship_scene_continue");
  scripts\engine\utility::flag_init("dropship_salter_continue");
}

_id_10C22() {
  level.player scripts\sp\utility::_id_F526("safe", 1);
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_flyover_start", "targetname"));
}

_id_10D40() {
  _id_F94D();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("dropship_takeoff_plr_start", "targetname"));
  level.player thread scripts\sp\utility::_id_F526("safe", 1);
  level._id_D5DB = scripts\sp\utility::_id_10639("plr_boost", (42944, -80448, -15104));
  level._id_D5DB linkTo(level._id_5D6C);
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "dropship_rig_idle", "stop_salter");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5EFD, "dropship_rig_idle", "stop_ally1");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5EFE, "dropship_idle", "stop_ally2");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5D2E, "dropship_idle_2", "stop_do_2");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_D5DB, "dropship_idle_2", "stop_do_2");
}

_id_B1C5() {
  scripts\sp\utility::_id_2669("mars_dropship");
  _id_F94D();
  _id_5E80();
}

_id_B23C() {
  scripts\sp\utility::_id_2669("mars_takeoff");
  _id_5E79();

  if(getdvarint("skip_nextmission", 0)) {
    return;
  }
  setomnvar("ui_level_transition", 1);
  wait 1.0;
  setomnvar("ui_level_transition", 2);
  scripts\sp\utility::_id_BF95();
}

_id_F94D() {
  setmusicstate("");
  var_0 = spawnStruct();
  var_0._id_10871 = "player_dropship_dday";
  var_0._id_1325F = "dropship_player_parts_dday";
  var_0._id_1325C = "col_dropship_dday";
  level._id_5EE3 = [];
  level._id_5D6C = _id_0BBF::_id_106B8(undefined, "mc_anim_dropship", undefined, undefined, undefined, var_0);
  level._id_5D6C._id_BCDA = getEnt("org_dropship_mover", "targetname");
  level._id_5D6C linkTo(level._id_5D6C._id_BCDA);
  level._id_5D6C _meth_83E8();
  var_1 = scripts\engine\utility::play_loopsound_in_space("shipcrib_dropship_warmup", (48158, -84814, -15465));
  var_1 linkTo(level._id_5D6C);
  level._id_5D6C notify("stop_kicking_up_dust");
  level._id_5D6C _id_0BBC::_id_C5F1(["back"], 0, 0);
  level._id_5D6C scripts\engine\utility::delaythread(0.1, scripts\sp\utility::play_sound_on_tag, "scn_ship_launch_bkdoor_open", "j_lowerbackdoor1");
  level._id_5D6C _id_0BBE::_id_5DFB("down");
  level._id_5D6C scripts\sp\utility::_id_65DD("thrusterEffects");
  level._id_5D6C._id_846A = getEnt("org_dropship_goto", "targetname");
  level._id_5D6C._id_846A linkTo(level._id_5D6C);
  level._id_5D6C _id_0BBF::_id_F451(1);
  level._id_5D6C _id_0BBF::_id_F454(1, "int", "cabin");
  level._id_5D6C _id_0BBF::_id_F455();
  level._id_5D6C _id_0BBF::_id_F454(1, "int", "sunfake");
  scripts\sp\maps\marscrib\marscrib_util::_id_107BE("continue_salter_flyover_takeoff");
  scripts\sp\maps\marscrib\marscrib_util::_id_10653(level._id_5D6C._id_4D94._id_10DED["jump_seat_c2"]);
  scripts\sp\maps\marscrib\marscrib_util::_id_106AE(level._id_5D6C._id_4D94._id_10DED["player_dropship_dropoff"]);
  level._id_EA2C linkTo(level._id_5D6C);
  level._id_2C23 linkTo(level._id_5D6C);
  level._id_5D2E linkTo(level._id_5D6C);
  level._id_5D2E scripts\sp\utility::_id_86E4();
  level._id_EA2C scripts\sp\utility::_id_72EC("iw7_m4", "primary");

  if(isDefined(level._id_EA2C._id_A489)) {
    level._id_EA2C detach(level._id_EA2C._id_A489);
  }

  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_2C23, "dropship_idle", "stop_boggs", "tag_detach");
  level._id_5EFD = scripts\sp\utility::_id_107EA("player_dropship_marine01", 1);
  level._id_5EFE = scripts\sp\utility::_id_107EA("player_dropship_marine02", 1);
  level._id_5EFD._id_1FBB = "ally1";
  level._id_5EFE._id_1FBB = "ally2";
  level._id_5EFD linkTo(level._id_5D6C);
  level._id_5EFE linkTo(level._id_5D6C);
  level._id_5EFD scripts\sp\utility::_id_86E4();
  level._id_5EFD thread scripts\sp\utility::_id_5131();
  var_2 = getEnt("trig_inside_dropship", "targetname");
  var_2 scripts\engine\utility::trigger_on();
  thread _id_D0ED();
}

_id_D0ED() {
  level endon("sa_dropship_cleanup");

  for(;;) {
    scripts\engine\utility::flag_wait("flag_inside_dropship");
    level.player _meth_82C0("marscrib_dropship", 1.5);
    scripts\engine\utility::flag_waitopen("flag_inside_dropship");
    level.player clearclienttriggeraudiozone(1.5);
  }
}

_id_5E80() {
  level._id_13E13 = scripts\sp\utility::_id_10639("xo_boost", (42944, -80448, -15104));
  level._id_D5DB = scripts\sp\utility::_id_10639("plr_boost", (42944, -80448, -15104));
  level._id_D5DB linkTo(level._id_5D6C);
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "ramp_idle", "stop_salter");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5D2E, "dropship_idle", "stop_do");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_D5DB, "dropship_idle", "stop_do");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5EFD, "dropship_idle", "salt_dropship_scene");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_13E13, "dropship_idle", "salt_dropship_scene");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5EFE, "dropship_idle", "stop_ally2");
  wait 0.05;

  while(!scripts\sp\maps\marscrib\marscrib_staging::_id_FC56(level._id_EA2C, 640, 1) || !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, level._id_EA2C.origin, 0.9)) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("flag_dropship_reached");
  level thread _id_5ED4();
  level thread _id_5E7E();
  level waittill("dropoff_anim_ready");

  while(!scripts\sp\maps\marscrib\marscrib_staging::_id_FC56(level._id_5D2E, 320, 1) || !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, level._id_5D2E.origin, 0.9)) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("dropship_scene_continue");
  level thread _id_5DC1();
  wait 3;
  level._id_D5DB _id_0E46::_id_48C4(undefined, (0, 0, 4), &"MARSCRIB_GET_RIG", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level._id_D5DB waittill("trigger");
}

_id_5DC1() {
  level._id_5D6C endon("stop_do_2");
  var_0 = level._id_D5DB scripts\sp\utility::_id_7DC1("dropship_scene");
  var_1 = level._id_5D2E scripts\sp\utility::_id_7DC1("dropship_scene");
  level._id_5D6C notify("stop_do");
  level._id_D5DB scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_0, 0.3);
  level._id_5D2E scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_1, 0.3);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_D5DB, "dropship_scene");
  level._id_5D6C scripts\sp\anim::_id_1F35(level._id_5D2E, "dropship_scene");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5D2E, "dropship_idle_2", "stop_do_2");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_D5DB, "dropship_idle_2", "stop_do_2");
}

_id_5E7E() {
  level thread _id_5DCF();
  level._id_5D6C notify("stop_salter");
  level._id_5D6C scripts\sp\anim::_id_1F35(level._id_EA2C, "ramp_walk");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "dropship_idle", "salt_dropship_scene");
  level thread _id_5E7F();
  scripts\engine\utility::flag_wait_either("dropship_scene_continue", "dropship_salter_continue");
  level._id_5D6C notify("salt_dropship_scene");
  var_0 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("dropship_scene"));
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_EA2C, "dropship_scene");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5EFD, "dropship_scene");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_13E13, "dropship_scene");
  level._id_5D6C scripts\engine\utility::delaythread(var_0, scripts\sp\anim::_id_1EEA, level._id_EA2C, "dropship_rig_idle", "stop_salter");
  level._id_5D6C scripts\engine\utility::delaythread(var_0, scripts\sp\anim::_id_1EEA, level._id_5EFD, "dropship_rig_idle", "stop_ally1");
  level._id_13E13 scripts\engine\utility::delaycall(var_0, ::linkto, level._id_EA2C, "tag_stowed_back");
}

_id_5E7F() {
  level endon("dropship_scene_continue");

  if(scripts\engine\utility::flag("dropship_scene_continue")) {
    return 0;
  }

  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("marscrib_slt_whosgotmyboostr");
  level._id_5EFD scripts\sp\utility::_id_10346("marscrib_unm_rightheremaam");
  scripts\engine\utility::flag_set("dropship_salter_continue");
}

_id_5DCF() {
  level waittill("boggs_fly_low");
  level thread scripts\sp\utility::_id_C12D("dropoff_anim_ready", 1.75);
  wait 2.75;
  level._id_2C23 scripts\sp\utility::_id_10346("marscrib_bgs_ayesir");
}

_id_5ED4() {
  wait 1;
  objective_state(scripts\sp\utility::_id_C264("dropship"), "active");
}

_id_5E79() {
  _id_B3AF();
  setsaveddvar("g_friendlyNameDist", 0);
  level._id_5D6C thread _id_5DE1();
  scripts\sp\maps\marscrib\marscrib_util::_id_10722();
  scripts\sp\maps\marscrib\marscrib_util::_id_106D9();
  scripts\sp\maps\marscrib\marscrib_util::_id_10710();
  scripts\sp\maps\marscrib\marscrib_util::_id_1068C();
  scripts\sp\maps\marscrib\marscrib_util::_id_107BD();
  level._id_8604 scripts\sp\utility::_id_72EC("iw7_devastator", "primary");
  level._id_6754 scripts\sp\utility::_id_72EC("iw7_sdfar", "primary");
  level._id_76FB scripts\sp\utility::_id_72EC("iw7_erad", "primary");
  level._id_444D scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  level._id_EA29 scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  level._id_8604 linkTo(level._id_5D6C);
  level._id_6754 linkTo(level._id_5D6C);
  level._id_76FB linkTo(level._id_5D6C);
  level._id_444D linkTo(level._id_5D6C);
  level._id_EA29 linkTo(level._id_5D6C);
  level._id_5EFF = scripts\sp\utility::_id_107EA("player_dropship_marine06", 1);
  level._id_5F00 = scripts\sp\utility::_id_107EA("player_dropship_marine04", 1);
  level._id_5F01 = scripts\sp\utility::_id_107EA("player_dropship_marine05", 1);
  level._id_5F02 = scripts\sp\utility::_id_107EA("player_dropship_marine03", 1);
  level._id_5F03 = scripts\sp\utility::_id_107EA("player_dropship_marine07", 1);
  level._id_5F04 = scripts\sp\utility::_id_107EA("player_dropship_marine08", 1);
  level._id_5EFF._id_1FBB = "ally3";
  level._id_5F00._id_1FBB = "ally4";
  level._id_5F01._id_1FBB = "ally5";
  level._id_5F02._id_1FBB = "ally6";
  level._id_5F03._id_1FBB = "ally7";
  level._id_5F04._id_1FBB = "ally8";
  level._id_5EFF._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), level._id_5EFF, "J_Lip_Top");
  level._id_5F00._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), level._id_5F00, "J_Lip_Top");
  level._id_5F01._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), level._id_5F01, "J_Lip_Top");
  level._id_5F02._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), level._id_5F02, "J_Lip_Top");
  level._id_5F03._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), level._id_5F03, "J_Lip_Top");
  level._id_5F04._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), level._id_5F04, "J_Lip_Top");
  level._id_5EFF linkTo(level._id_5D6C);
  level._id_5F00 linkTo(level._id_5D6C);
  level._id_5F01 linkTo(level._id_5D6C);
  level._id_5F02 linkTo(level._id_5D6C);
  level._id_5F03 linkTo(level._id_5D6C);
  level._id_5F04 linkTo(level._id_5D6C);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("dropship"));
  var_0 = scripts\sp\utility::_id_10639("player_rig", (42944, -80448, -15104));
  var_0 hide();
  level._id_5D6C scripts\sp\anim::_id_1EC3(var_0, "dropship_rig_act");
  var_0 linkTo(level._id_5D6C);
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_crouch(0);
  level.player freezecontrols(1);
  level.player _meth_823C(var_0, "tag_player", 1, 0.25, 0.25);
  wait 1;
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0 show();
  enableforcednosunshadows();
  level._id_5D6C thread teleport_dropship(getEnt("mc_move_dropship", "targetname"));
  thread scripts\sp\utility::_id_BF97("root");
  var_1 = [level._id_5D2E, level._id_8604, level._id_6754, level._id_76FB, level._id_444D, level._id_EA29, level._id_5EFF, level._id_5F00, level._id_5F01, level._id_5F02];
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_51E1, "casual_gun");
  level scripts\engine\utility::delaythread(5.4, scripts\sp\utility::_id_9145, "fluff_messages_boost_engaged");
  level.player playSound("marscrib_dropship_plr_boost_rig_on");
  level._id_5D6C notify("stop_do_2");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5D2E, "dropship_rig_act");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_D5DB, "dropship_rig_act");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_8604, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_6754, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_76FB, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_444D, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_EA29, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5EFF, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5F00, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5F01, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5F02, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5F03, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5F04, "dropship_rig_act", undefined, 0.2);
  level._id_5D6C thread scripts\sp\anim::_id_1F35(var_0, "dropship_rig_act");
  level scripts\engine\utility::delaythread(25.75, ::_id_5DE0);
  level waittill("good_luck");
  level._id_EA2C thread scripts\sp\utility::_id_7226(level._id_5D6C._id_846A);
  level._id_5EFD scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7226, level._id_5D6C._id_846A);
  wait 1;
}

teleport_dropship(var_0) {
  wait 2;
  self._id_BCDA _meth_83BA(self, var_0);
  teleportscene();
}

_id_5DE1() {
  level waittill("dropship_close_door");
  level._id_5D6C thread _id_0BBC::_id_4265(["back"]);
  level._id_5D6C thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_close", "j_lowerbackdoor1");
  level._id_5D2E delete();
  level._id_5EFE delete();
  level._id_2C23 delete();
  level._id_EA2C hide();
  level._id_5EFD hide();
  level waittill("dropship_takeoff");
  level.player playSound("scn_marscrib_dropship_exfil_lr");
  level.player scripts\engine\utility::delaycall(5.0, ::_meth_82C0, "marscrib_dropship_launch_to_marsbase", 5.0);
  level._id_5D6C scripts\engine\utility::delaythread(0.25, ::_id_5DAD);
  level._id_5D6C _id_0BBF::_id_F454(1, "int", "cabin");
  level._id_5D6C _id_0BBF::_id_F455();
  wait 3;
  level thread _id_5DE0();
  var_0 = scripts\engine\utility::getStruct("dropship_exit_start", "targetname");
  level._id_5D6C._id_BCDA moveTo(var_0.origin, 8);
  level._id_5D6C._id_BCDA rotateTo(var_0.angles, 8.05, 1, 2);
  wait 8.0;
  level._id_5D6C unlink();
  level._id_EA2C show();
  level._id_5EFD show();
  level._id_5D6C notify("stop_salter");
  level._id_5D6C notify("stop_ally1");
  level._id_5EFD thread scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  scripts\engine\utility::array_thread([level._id_EA2C, level._id_5EFD], scripts\sp\utility::anim_stopanimscripted);
  scripts\engine\utility::array_thread([level._id_EA2C, level._id_5EFD], scripts\sp\utility::_id_51E1, "casual_gun");
  scripts\engine\utility::array_thread([level._id_EA2C, level._id_5EFD], scripts\asm\asm::_id_237B, randomfloatrange(0.75, 0.8));
  scripts\engine\utility::array_call([level._id_EA2C, level._id_5EFD], ::unlink);
  wait 0.05;
}

_id_5DAD() {
  self endon("death");
  var_0 = undefined;
  var_1 = [];
  var_2 = getEntArray("dropship_player_parts_dday", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_EE52)) {
      if(var_4._id_EE52 == "decompression_claxon_rr") {
        var_0 = var_4;
      }

      if(var_4._id_EE52 == "klaxon_light_rr") {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }
    }
  }

  _id_A6E3(var_0, var_1, 1);
  level waittill("stop_dropship_intro_klaxon");
  _id_A6E3(var_0, var_1, 0);
  scripts\sp\utility::_id_228A(var_1);
}

_id_5DE0() {
  level notify("dropship_rumble_start");
  level endon("dropship_rumble_start");
  _id_5FCB(0.4, 0.2, 8);
  var_0 = 0.3;

  for(;;) {
    var_1 = randomfloatrange(0.15, 0.25);
    _id_5FCB(var_0, var_1, randomfloatrange(2, 4));
    var_0 = var_1;
    wait 0.05;
  }
}

_id_A6E3(var_0, var_1, var_2) {
  var_0 scripts\sp\utility::_id_23B7("klaxon");

  if(scripts\engine\utility::is_true(var_2)) {
    scripts\engine\utility::array_thread(var_1, scripts\sp\lights::_id_AB83, 100, 0.5);
    scripts\engine\utility::array_call(var_1, ::linkto, var_0, "j_spin");
    var_0 thread scripts\sp\anim::_id_1EEA(var_0, "klaxon_spin");
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_klaxon_flare"), var_0, "j_spin");
    var_0 _meth_83A1();
  }
}

_id_5FCB(var_0, var_1, var_2) {
  level notify("earthquake_scale_start");
  level endon("earthquake_scale_start");
  var_3 = var_2 / 0.05;
  var_4 = (var_1 - var_0) / var_3;

  for(var_5 = 1; var_5 < var_3; var_5++) {
    earthquake(var_0 + var_3 * var_4, 0.05, level.player.origin, 10240);
    wait 0.05;
  }

  earthquake(var_1, 0.05, level.player.origin, 10240);
}

_id_B3AF() {
  level notify("sa_dropship_cleanup");

  if(isDefined(level._id_A6F4)) {
    level._id_A6F4 scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_EA29)) {
    level._id_EA29 scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_76FB)) {
    level._id_76FB scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_444D)) {
    level._id_444D scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_2BFF)) {
    level._id_2BFF scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_30F6)) {
    level._id_30F6 scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_8604)) {
    level._id_8604 scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_B4F1)) {
    level._id_B4F1 scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  if(isDefined(level._id_6754)) {
    level._id_6754 scripts\sp\maps\marscrib\marscrib_util::_id_4046();
  }

  var_0 = scripts\engine\utility::array_removeundefined(level._id_E97A);
  scripts\sp\utility::_id_228A(var_0);
  var_1 = scripts\engine\utility::array_removeundefined(level._id_E97E);
  scripts\sp\utility::_id_228A(var_1);
  var_2 = scripts\engine\utility::array_removeundefined(level._id_E9BD);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.gun)) {
      var_4.gun delete();
    }
  }

  scripts\sp\utility::_id_228A(var_2);
  var_6 = scripts\engine\utility::array_removeundefined(level._id_E9BE);
  scripts\engine\utility::array_thread(var_6, scripts\sp\maps\marscrib\marscrib_util::_id_1101C);
  scripts\sp\utility::_id_228A(var_6);
  var_7 = scripts\engine\utility::array_removeundefined(level._id_E9AC);
  scripts\sp\utility::_id_228A(var_7);
  wait 0.1;
}