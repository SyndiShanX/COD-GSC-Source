/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_exfil.gsc
*****************************************************/

_id_E924() {
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  thread _id_0F16::_id_3E3E("exfil_start");
  thread _id_0F16::_id_3E3D("exfil_start", undefined, 1);
  thread _id_0F16::_id_8EA3();
  thread _id_F905();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_68FD();
  visionsetalternate(5, 0);
  scripts\engine\utility::flag_set("sa01_flag_start_exfil");
  scripts\engine\utility::flag_set("cargobay_amb_end");
  scripts\engine\utility::flag_set("cargobay_main_waves_clear");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(1);
  thread scripts\sp\maps\sa_moon\sa_moon_cargobay::_id_672F(1, 40);
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_138F3(0);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(0);
  thread scripts\sp\maps\sa_moon\sa_moon_cargobay::_id_3A85();
  level thread _id_0E4B::_id_1348D(1);
  var_0 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_0))
    scripts\engine\utility::array_call(var_0, ::delete);

  scripts\sp\utility::_id_F44E(1);
}

_id_E91D() {
  scripts\engine\utility::flag_wait("cargobay_main_waves_clear");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_68FB();
  thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_132B2(1);
  thread _id_E925();
  thread _id_6920();
  scripts\sp\utility::_id_2679();
  level._id_C47F scripts\sp\utility::_id_F3B5("r");
  level._id_EA2C scripts\sp\utility::_id_F3B5("g");
  level._id_6754 scripts\sp\utility::_id_F3B5("b");
  level._id_C47F.maxsightdistsqrd = 256000000;
  level._id_EA2C.maxsightdistsqrd = 256000000;
  level._id_6754.maxsightdistsqrd = 256000000;
  scripts\engine\utility::waitframe();
  var_0 = scripts\sp\utility::_id_22CD("cargobay_wave3", 1);
  thread _id_45BE();
  var_1 = scripts\engine\utility::getStruct("dropbay_doors_trig", "targetname");
  level notify("objective_center_fade_OBJ_DROPBAY_SWITCH");
  wait 0.05;
  level thread scripts\sp\maps\sa_moon\sa_moon_util::_id_119C1(scripts\sp\utility::_id_C264("OBJ_DROPBAY_SWITCH"), var_1.origin, 250000, "dropbay_triggered");
  var_1 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 500, undefined, 1);
  thread _id_6C2D();
  thread _id_63D2("zerog_anim_struct");
  thread _id_AD9C();
  thread _id_43D3();
  thread _id_43E0();
  scripts\engine\utility::flag_wait("final_wave_spawn");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_12BBE();
  var_1 waittill("trigger");
  var_1 _id_0E46::_id_DFE3();
  scripts\engine\utility::flag_set("dropbay_triggered");
  scripts\engine\utility::flag_set("cargobay_zerog_active");
  scripts\sp\utility::_id_F44E(0);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6902();
  thread _id_0E26::_id_DFC1();
  thread _id_0E2D::_id_A5B9();
  scripts\sp\utility::_id_CF8B();
  thread _id_2730();
  thread _id_690B();
  thread _id_68F8();
  thread _id_6933();
  thread _id_6936();
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4))
      var_4 delete();
  }

  scripts\engine\utility::flag_wait("player_in_exfil_jackal");

  if(isDefined(level._id_679E) && isalive(level._id_679E)) {
    level._id_679E scripts\sp\utility::_id_1101B();
    level._id_679E delete();
  }

  if(isDefined(level._id_C49F) && isalive(level._id_C49F)) {
    level._id_C49F scripts\sp\utility::_id_1101B();
    level._id_C49F delete();
  }

  if(isDefined(level._id_EAFE) && isalive(level._id_EAFE)) {
    level._id_EAFE scripts\sp\utility::_id_1101B();
    level._id_EAFE delete();
  }

  if(isDefined(level._id_68F5)) {
    level._id_68F5 _meth_83A1();
    level._id_68F5 delete();
  }

  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4))
      var_4 delete();
  }
}

_id_E925() {
  level endon("player_in_exfil_jackal");
  scripts\engine\utility::flag_wait("dropbay_triggered");
  scripts\sp\utility::_id_1034D("mn_plr_depressurizing");
  setmusicstate("");
  _id_E927();
  _id_E928();
}

_id_E927() {
  level endon("player_jackal_grapple");
  scripts\engine\utility::flag_wait("button_press_done");
  scripts\sp\utility::_id_1034D("mn_plr_need_birds");
  wait 0.5;
  scripts\sp\utility::_id_10350("mn_fer_sending_jackals_294");
  wait 0.25;
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_gunners_approaching");
  wait 0.25;
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_overhead");
}

_id_E928() {
  level endon("player_jackal_grapple");
  scripts\engine\utility::flag_wait("zerog_enemies_dead");
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_jacks_in");
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_plr_load_up_302");
  wait 3;
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_1_2_locked");

  if(!scripts\engine\utility::flag("player_in_exfil_jackal"))
    level thread _id_E926();
}

_id_E926() {
  level endon("player_in_exfil_jackal");
  wait 5.0;
  level._id_C49F scripts\sp\utility::_id_10346("mn_omr_done_here");
  wait 5.0;
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_mount_up");
  wait 5.0;
  scripts\sp\utility::_id_10350("mn_fer_get_out");
  wait 5.0;
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_jackals_ready");
}

_id_2730(var_0) {
  var_1 = [];

  if(!isDefined(var_0)) {
    scripts\engine\utility::flag_wait("spawn_anim_enemies");
    var_2 = getEnt("cargobay_final_wave_check_vol", "targetname");
    var_1 = var_2 scripts\sp\utility::_id_77E3("axis");
  } else
    var_1 = getaiarray("axis");

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 delete();
  }

  var_6 = getcorpsearray();

  foreach(var_8 in var_6) {
    if(isDefined(var_8))
      var_8 delete();
  }

  scripts\sp\utility::_id_28D7();
}

_id_690B() {
  scripts\engine\utility::flag_wait("player_pressed_the_button");
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_611A(1);
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_5D1D();
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_6EBB();
}

_id_68F8() {
  scripts\engine\utility::flag_wait("player_pressed_the_button");
  var_0 = getEnt("runner_clip", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(1);
  level._id_C47F scripts\sp\utility::_id_1101B();
  level._id_C47F delete();
  level._id_EA2C scripts\sp\utility::_id_1101B();
  level._id_EA2C delete();
  level._id_6754 scripts\sp\utility::_id_1101B();
  level._id_6754 delete();
  scripts\engine\utility::waitframe();
  scripts\sp\maps\sa_moon\sa_moon_util::_id_10628();
  level._id_679E scripts\sp\utility::_id_F3B5("y");
  wait 0.2;
  level._id_C49F scripts\sp\utility::_id_F3B5("g");
  level._id_EAFE scripts\sp\utility::_id_F3B5("r");
  var_1 = scripts\engine\utility::getStruct("zerog_cargobay_Omar", "targetname");
  level._id_C49F _meth_80F1(var_1.origin, var_1.angles);
  level._id_C49F.ignoreall = 1;
  level._id_C49F._id_B3E9 = 1;
  var_2 = scripts\engine\utility::getStruct("zerog_cargobay_Salter", "targetname");
  level._id_EAFE _meth_80F1(var_2.origin, var_2.angles);
  level._id_EAFE.ignoreall = 1;
  level._id_EAFE._id_B3E9 = 1;
  var_3 = scripts\engine\utility::getStruct("zerog_cargobay_Ethan", "targetname");
  level._id_679E _meth_80F1(var_3.origin, var_3.angles);
  level._id_679E._id_B3E9 = 1;
  scripts\engine\utility::waitframe();
  level._id_68F5 = scripts\sp\vehicle::_id_1080C("ally_jackal_exfil");
  level._id_68F5 thread _id_F8B5("ally_jackal_exfil", "zerog_anim_struct", "exfil", "exfil_loop", "dropbay_triggered", "omar_salter_anim_arrival");
}

_id_6933() {
  scripts\engine\utility::flag_wait("turn_exfil_gravity_off");
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  thread _id_691D();
  thread _id_F966();
  scripts\sp\utility::_id_F3E4(0, 0);
  level.player thread _id_0F35::_id_D385();
  scripts\engine\utility::waitframe();
  thread _id_63E1("body_toss2", 5000);
  thread _id_63E1("body_toss3", 6000);
  thread _id_63E1("body_toss4", 2000);
  level._id_C49F.ignoreall = 0;
  level._id_EAFE.ignoreall = 0;
  level._id_679E.ignoreall = 0;
  thread _id_FA87();
  thread _id_FA86();
  thread _id_2845();
}

_id_6936() {
  scripts\engine\utility::flag_wait("button_press_done");
  wait 1;
  scripts\sp\utility::_id_15F1("exfil_ally_move1", "targetname");
  thread _id_1CE6();
  thread _id_6772();
  thread _id_6937();
  scripts\engine\utility::flag_set("player_jackal_flyup_trig");
}

_id_E921() {
  thread _id_0F16::_id_3E3E("exfil_flyout_start");
  thread _id_0F16::_id_8EA3();
  thread _id_F966();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_691C();
  thread _id_6920();
  thread _id_0B1E::_id_551D("bulkheadsdf_left");
  scripts\engine\utility::flag_set("exfil_flyout_checkpoint_start");
  visionsetalternate(5, 0);
  scripts\engine\utility::flag_set("sa01_flag_start_exfil");
  scripts\engine\utility::flag_set("dropbay_triggered");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_138F3(1);
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_611A(1);
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_5D1D();
  level._id_6922 = scripts\sp\vehicle::_id_1080C("player_jackal_exfil");
  level._id_6922 thread _id_FA0D("player_jackal_exfil", "zerog_anim_struct", "exfil_start", "exfil_loop", "player_jackal_flyup_trig", "player_jackal_grapple", "vfx_cargobay_exfil_jackal");
  level._id_6922 notsolid();
  level._id_6922 _id_0BDC::_id_A07D();
  level._id_6922 _id_0BDC::_id_6B4C("none");
  scripts\engine\utility::waitframe();
  level._id_6922 scripts\sp\maps\sa_moon\sa_moon_util::_id_871D();
  scripts\engine\utility::flag_set("button_press_done");
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  thread _id_691D();
  scripts\sp\utility::_id_F3E4(0, 0);
  level.player thread _id_0F35::_id_D385();
  level.player thread _id_0F35::_id_136F();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(1, 1);
}

_id_E91F() {
  setsaveddvar("cg_helmetLinearVelocityToAngleRate", (0, 0, 0));
  setsaveddvar("cg_helmetViewSwayRate", 0.0);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_691B();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132B2(1);
  thread _id_E922();
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_611A(0);
  _id_0BB6::_id_39DF();
  scripts\engine\utility::waitframe();
  level._id_3965 notify("delete_cleanup");
  _id_2730(1);
  wait 0.1;
  level thread _id_E923();
  var_0 = _id_0B1E::_id_794D("bulkheadsdf_left");

  if(isDefined(var_0)) {
    thread _id_0B1E::_id_551D("bulkheadsdf_left");
    scripts\engine\utility::waitframe();
    var_0 delete();
  }

  var_1 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_1))
    scripts\engine\utility::array_call(var_1, ::delete);

  scripts\engine\utility::waitframe();
  setsaveddvar("objectiveFadeTooFar", 25);
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("show");
  level thread _id_0B51::_id_E3C6(1, 0, undefined, undefined, 1);
  wait 5;
  level.player scripts\sp\utility::_id_65E1("flag_player_has_jackal");
  wait 3;
  scripts\engine\utility::flag_set("jackal_hint_ret_return");
  wait 9;
  level._id_FD6E._id_E35D _meth_8307("", &"");
  waitforalltransients();
  wait 15;
  level.player lerpviewangleclamp(1, 0.1, 0.1, 0, 0, 0, 0);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_ret"));
}

_id_E923() {
  level notify("preload_started");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 _meth_83A1();
    var_2 delete();
  }

  clearallcorpses();
  wait 5;
  clearallcorpses();
  scripts\sp\utility::_id_12651(["sa_moon_prime_tr", "sa_moon_cargobay_tr"]);
  scripts\sp\utility::_id_12641("sa_moon_ret_land_tr");
  level scripts\sp\utility::_id_BF97();
}

_id_E922() {
  scripts\engine\utility::flag_wait("player_in_exfil_jackal");
  setmusicstate("mx_368c_samoon_exfil");
  wait 1.0;
  scripts\sp\utility::_id_1034D("mn_plr_turn_and_burn");
  wait 2.0;
  scripts\sp\utility::_id_1034D("mn_plr_scars_clear");
  scripts\sp\utility::_id_10350("mn_fer_copy_clear");
  scripts\sp\utility::_id_10350("mn_fer_weapons_loose");
  wait 5;
  scripts\sp\utility::_id_10350("mn_slt_hell_yeah");
  scripts\sp\utility::_id_10350("mn_omr_good_effect");
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_plr_mission_accomplished");
  wait 1.5;
  scripts\sp\utility::_id_10350("moon_fer_stratcomhascleared");
  wait 0.1;
  scripts\sp\utility::_id_10350("moon_plr_thankyoucaptain");
  wait 0.1;
  wait 2;
  scripts\sp\utility::_id_10350("sc_europa_nav_captainreyespri");
  wait 0.1;
  scripts\sp\utility::_id_1034D("sc_europa_plr_rogerpatchit");
  wait 0.1;
  scripts\sp\utility::_id_10350("sc_europa_nav_yessirhereitcom");
}

_id_6C2D() {
  scripts\engine\utility::flag_wait("final_wave_spawn");
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  createthreatbiasgroup("allies");
  level._id_EA2C setthreatbiasgroup("allies");
  level._id_C47F setthreatbiasgroup("allies");
  level._id_6754 setthreatbiasgroup("allies");
  createthreatbiasgroup("unaware_of_player");
  var_0 = scripts\sp\utility::_id_22CD("cargobay_final_wave", 1);

  foreach(var_2 in var_0) {
    var_2.maxsightdistsqrd = 256000000;
    var_2._id_ECE5 = 0.001;
    var_2 setthreatbiasgroup("unaware_of_player");
  }

  setthreatbias("allies", "unaware_of_player", 1000);
  setthreatbias("player", "unaware_of_player", -400);
}

_id_45BE() {
  scripts\engine\utility::flag_wait("final_wave_spawn");
  var_0 = getEnt("final_gold_path_grab_vol", "targetname");
  var_1 = getEnt("final_gold_path_retreat_vol", "targetname");
  var_2 = var_0 scripts\sp\utility::_id_77E3("axis");

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && isalive(var_4)) {
      var_4 scripts\sp\utility::_id_414F();
      var_4 _meth_82F1(var_1);
    }
  }
}

_id_F907() {
  self endon("death");
  self.health = 200;
  var_0 = getnode(self.target, "targetname");
  scripts\sp\utility::_id_F3D9(var_0);
  scripts\sp\utility::_id_F39F();
  self.maxsightdistsqrd = 256000000;
  self._id_ECE5 = 0.001;
  self.allowdeath = 1;
  scripts\sp\utility::_id_5550();
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  createthreatbiasgroup("allies");
  level._id_EA2C setthreatbiasgroup("allies");
  level._id_C47F setthreatbiasgroup("allies");
  level._id_6754 setthreatbiasgroup("allies");
  createthreatbiasgroup("unaware_of_player2");
  self setthreatbiasgroup("unaware_of_player2");
  scripts\engine\utility::waitframe();
  setthreatbias("allies", "unaware_of_player2", 1000);
  setthreatbias("player", "unaware_of_player2", -400);
  scripts\engine\utility::flag_wait("dropbay_triggered");

  if(isDefined(self) && isalive(self))
    scripts\sp\utility::_id_F2A8(1);
}

_id_6937() {
  var_0 = scripts\sp\utility::_id_22CD("exfil_wave1", 1);

  foreach(var_2 in var_0)
  var_2.health = 80;

  scripts\sp\utility::_id_13754(var_0);
  scripts\engine\utility::flag_set("zerog_enemies_dead");
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_15F1("exfil_ally_move2", "targetname");
}

_id_1CE6() {
  level endon("player_jackal_grapple");
  var_0 = scripts\engine\utility::getStruct("zerog_anim_struct", "targetname");
  level._id_C49F._id_1FBB = "omar";
  level._id_EAFE._id_1FBB = "salter";
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, level._id_C49F);
  var_1 = scripts\engine\utility::array_add(var_1, level._id_EAFE);
  var_2 = scripts\sp\utility::_id_10639("mco_rope_exfil");
  var_3 = scripts\sp\utility::_id_10639("xo_rope_exfil");
  thread _id_40BA(var_2, var_3);
  level._id_C49F thread _id_889F(var_2);
  level._id_EAFE thread _id_889F(var_3);
  scripts\engine\utility::flag_wait("zerog_enemies_dead");
  var_0 scripts\sp\anim::_id_1F1A(var_1, "exfil");
  scripts\engine\utility::flag_set("omar_salter_anim_arrival");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "exfil");
  var_0 thread scripts\sp\anim::_id_1F35(var_3, "exfil");
  var_0 scripts\sp\anim::_id_1F2C(var_1, "exfil");

  if(isDefined(level._id_C49F) && isalive(level._id_C49F)) {
    level._id_C49F _meth_83A1();
    level._id_C49F scripts\sp\utility::_id_1101B();
    level._id_C49F delete();
  }

  if(isDefined(level._id_EAFE) && isalive(level._id_EAFE)) {
    level._id_EAFE _meth_83A1();
    level._id_EAFE scripts\sp\utility::_id_1101B();
    level._id_EAFE delete();
  }
}

_id_40BA(var_0, var_1) {
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  var_0 delete();
  var_1 delete();
}

_id_889F(var_0) {
  self waittillmatch("single anim", "grapple_start");
  playFXOnTag(scripts\engine\utility::getfx("zerog_grapple_launch"), var_0, "tag_origin");

  if(self != level._id_C49F) {
    return;
  }
  self waittillmatch("single anim", "grapple_start");
  playFXOnTag(scripts\engine\utility::getfx("zerog_grapple_launch"), var_0, "tag_origin");
}

_id_6772() {
  level endon("player_jackal_grapple");
  var_0 = scripts\engine\utility::getStruct("zerog_anim_struct", "targetname");
  level._id_679E._id_1FBB = "ethan";
  scripts\engine\utility::flag_wait("zerog_enemies_dead");
  var_0 scripts\sp\anim::_id_1F17(level._id_679E, "exfil");
  var_0 scripts\sp\anim::_id_1F35(level._id_679E, "exfil");
  var_0 scripts\sp\anim::_id_1EEA(level._id_679E, "exfil_loop", "player_jackal_grapple");
}

_id_AD9C() {
  scripts\engine\utility::flag_wait("lmg_guy_cleanup");
  var_0 = getEntArray("roof_guys", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 delete();
  }
}

_id_43D3() {
  scripts\engine\utility::flag_wait("player_pressed_the_button");
  var_0 = getEnt("decompression_check_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(!isDefined(var_3._id_B14F)) {
        var_3 _meth_81D0();
        wait(randomfloatrange(0.5, 1));
        continue;
      }

      var_3 scripts\sp\utility::_id_1101B();
      var_3 _meth_81D0();
      wait(randomfloatrange(0.5, 1));
    }
  }

  scripts\engine\utility::waitframe();
  var_5 = getcorpsearray();

  foreach(var_7 in var_5) {
    if(isDefined(var_7))
      var_7 delete();
  }
}

_id_43E0() {
  scripts\engine\utility::flag_wait("player_pressed_the_button");
  var_0 = getEntArray("cargobay_combat_move_triggers", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

_id_F905() {
  thread _id_F944("cargo_bay_doors", "zerog_anim_struct", "exfil", "dropbay_triggered");
  thread _id_F8E3("bounce_props", "zerog_anim_struct", "exfil", "exfil_loop", "dropbay_triggered", "exfil_player_clear");
  thread _id_F968("exfil_jprops", "exfil_props", "zerog_anim_struct", "exfil", "exfil_loop", "dropbay_triggered", "exfil_player_clear");
  thread _id_F8F2("c12_02", "zerog_anim_struct", "exfil", "start_c12_anim", 0.38);
  thread _id_FA43("buggy_01_clip", "buggy_01", "zerog_anim_struct", "exfil", "exfil_loop", "dropbay_triggered", "exfil_player_clear", undefined, 1);
  thread _id_FA43("buggy_02_clip", "buggy_02", "zerog_anim_struct", "exfil", "exfil_loop", "dropbay_triggered", "exfil_player_clear", undefined, 1);
  thread _id_FA43("buggy_03_clip", "buggy_03", "zerog_anim_struct", "exfil", undefined, "dropbay_triggered", undefined, "vfx_cargobay_exfil_atv", 0);
  level.player thread _id_FA0B("zerog_anim_struct", "exfil", "dropbay_triggered", "vfx_cargobay_exfil_player");
  level._id_6922 = scripts\sp\vehicle::_id_1080C("player_jackal_exfil");
  level._id_6922 _id_0BDC::_id_19A0(1);
  level._id_6922 _id_0BDC::_id_1998();
  wait 1;
  level._id_6922 thread _id_FA0D("player_jackal_exfil", "zerog_anim_struct", "exfil_start", "exfil_loop", "player_jackal_flyup_trig", "player_jackal_grapple", "vfx_cargobay_exfil_jackal");
  level._id_6922 notsolid();
  level._id_6922 _id_0BDC::_id_A07D();
  level._id_6922 _id_0BDC::_id_6B4C("none");
  level._id_6922 scripts\sp\maps\sa_moon\sa_moon_util::_id_871D();
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_jackal_rear_thrust_idle_space"), level._id_6922, "tag_thrust_rear_ri");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_jackal_rear_thrust_idle_space"), level._id_6922, "tag_thrust_rear_le");
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_jackal_rear_thrust_idle_space"), level._id_6922, "tag_thrust_rear_ri");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_jackal_rear_thrust_idle_space"), level._id_6922, "tag_thrust_rear_le");
}

_id_F966() {
  scripts\engine\utility::flag_wait("button_press_done");
  level.player thread _id_FA06("zerog_anim_struct", "exfil_flyout", "player_jackal_grapple");
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  level._id_68FF = scripts\sp\vehicle::_id_1080C("exfil_carrier");
  scripts\engine\utility::waitframe();
  level._id_68FF._id_B904 = "veh_mil_air_ca_carrier";
  level._id_68FF thread _id_0B53::_id_B909();
  level._id_68FF setCanDamage(1);
  var_0 = getEnt("carrier_damage_model", "targetname");
  var_0 show();
  var_0 linkTo(level._id_68FF, "tag_origin", (0, 0, 0), (0, 0, 0));
  level._id_6930 = _id_0F0E::_id_88BE(undefined, 1, "exfil_tigris", undefined, 6, 1, "cannon_large_lock_ca,1,1,amb_turret_l_1,amb_turret_l_2,amb_turret_m_1,amb_turret_m_2,amb_turret_r_1,amb_turret_r_2", 1, 1);
  thread _id_F965("capitalships_props", "zerog_anim_struct", "exfil_flyout");
  level._id_6930 notsolid();
  level._id_6930 thread _id_0BB6::_id_F5C0(level._id_68FF, 1);
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_68FF gettagorigin("tag_origin"), level._id_68FF gettagangles("tag_origin"));
  level._id_6930 thread _id_0BB6::_id_F5C0(var_1, 10);
  var_2 = undefined;

  foreach(var_4 in level._id_6930.turrets)
  var_2 = var_4;

  var_6 = scripts\sp\maps\sa_moon\sa_moon_util::_id_FA71();
  thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13307(var_2, var_6);
  level._id_691A = scripts\sp\vehicle::_id_1080C("ally_jackal_exfil");
  level._id_691A thread _id_F8B4("ally_jackal_exfil", "zerog_anim_struct", "exfil_flyout");
  level._id_691A _id_0BDC::_id_6B4C("fly_space");
  wait 18;
  level notify("vfx_exfil_tigris_turrets_loop_stop");
  scripts\engine\utility::waitframe();

  if(isDefined(level._id_6930)) {
    level._id_6930 _id_0BB6::_id_39E1();
    level._id_6930 _id_0BB8::_id_39C5();

    if(isDefined(level._id_6930._id_4074)) {
      foreach(var_8 in level._id_6930._id_4074) {
        if(isDefined(var_8))
          var_8 delete();
      }

      level._id_6930._id_4074 = [];
    }

    level._id_6930 delete();
  }

  if(isDefined(level._id_68FF))
    level._id_68FF delete();
}

_id_6920() {
  scripts\engine\utility::flag_wait("button_press_done");
  var_0 = level._id_6922;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(var_0, "tag_origin", (200, 0, 20), (0, 0, 0));
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("OBJ_PLAYER_GRAPPLE", "current", &"SA_MOON_OBJ_ESCAPE");
  objective_current(scripts\sp\utility::_id_C264("OBJ_PLAYER_GRAPPLE"));
  objective_onentity(scripts\sp\utility::_id_C264("OBJ_PLAYER_GRAPPLE"), var_1);
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  level notify("player_jackal_grapple");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_PLAYER_GRAPPLE"));
  var_1 delete();
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_ret", "current", &"SA_MOON_RET");
}

_id_FA43(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = scripts\engine\utility::getStruct(var_2, "targetname");
  var_10 = scripts\sp\utility::_id_10639(var_1, var_9.origin, var_9.angles);

  if(isDefined(var_0)) {
    var_0 = getEnt(var_0, "targetname");
    var_0 linkTo(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_9 scripts\sp\anim::_id_1EC3(var_10, var_3);

  if(!var_8) {
    var_11 = level._id_128F[var_7];
    var_10 thread[[var_11]]();
  }

  scripts\engine\utility::flag_wait(var_5);

  if(isDefined(var_7) && var_8) {
    var_11 = level._id_128F[var_7];
    var_10 thread[[var_11]]();
  }

  var_9 scripts\sp\anim::_id_1F35(var_10, var_3);

  if(isDefined(var_6))
    var_9 scripts\sp\anim::_id_1EEA(var_10, var_4, var_6);
}

_id_F8F2(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::flag_wait("spawn_anim_enemies");
  var_5 = scripts\engine\utility::getStruct(var_1, "targetname");

  if(isDefined(level._id_43CF) && isalive(level._id_43CF)) {
    level._id_43CF _id_0A05::_id_3555("right", 0);
    level._id_43CF _id_0A05::_id_3555("left", 0);
    scripts\engine\utility::waitframe();
    level._id_43CF delete();
    var_6 = scripts\sp\utility::_id_10639(var_0, var_5.origin, var_5.angles);
    scripts\engine\utility::flag_wait(var_3);
    var_5 scripts\sp\anim::_id_1F35(var_6, var_2);
  }
}

_id_F8E3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_7 = scripts\sp\utility::_id_10639(var_0, var_6.origin, var_6.angles);
  var_8 = spawn("script_model", var_7 gettagorigin("J_prop_1"));
  var_8.angles = var_7 gettagangles("J_prop_1");
  var_8 setModel("atlas_stabilize_crate_static");
  var_9 = getEnt("bounce_large_crate_clip", "targetname");
  var_9 linkTo(var_7, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_8 linkTo(var_7, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_10 = spawn("script_model", var_7 gettagorigin("J_prop_2"));
  var_10.angles = var_7 gettagangles("J_prop_2");
  var_10 setModel("research_crate_01");
  var_11 = getEnt("bounce_small_crate_clip", "targetname");
  var_11 linkTo(var_7, "J_prop_2", (0, 0, 0), (0, 0, 0));
  var_10 linkTo(var_7, "J_prop_2", (0, 0, 0), (0, 0, 0));
  var_12 = spawn("script_model", var_7 gettagorigin("J_prop_3"));
  var_12.angles = var_7 gettagangles("J_prop_3");
  var_12 setModel("sdf_container_space_barrel_01");
  var_13 = getEnt("bounce_barrel_clip", "targetname");
  var_13 linkTo(var_7, "J_prop_3", (0, 0, 0), (0, 0, 0));
  var_12 linkTo(var_7, "J_prop_3", (0, 0, 0), (0, 0, 0));
  var_6 scripts\sp\anim::_id_1EC3(var_7, var_2);
  scripts\engine\utility::flag_wait(var_4);
  var_6 scripts\sp\anim::_id_1F35(var_7, var_2);
  var_6 scripts\sp\anim::_id_1EEA(var_7, var_3, var_5);
}

_id_F944(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = scripts\sp\utility::_id_10639("cargo_bay_doors", var_4.origin, var_4.angles);
  var_6 = getEnt("cargobay_door_left", "targetname");
  var_7 = getEnt("cargobay_door_left_clip", "targetname");
  var_7 linkTo(var_6);
  var_6 linkTo(var_5, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_8 = getEnt("cargobay_door_right", "targetname");
  var_9 = getEnt("cargobay_door_right_clip", "targetname");
  var_9 linkTo(var_8);
  var_8 linkTo(var_5, "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_4 scripts\sp\anim::_id_1EC3(var_5, var_2);
  scripts\engine\utility::flag_wait(var_3);
  var_5 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_132EE();
  var_4 scripts\sp\anim::_id_1F35(var_5, var_2);
}

_id_F968(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::getStruct(var_2, "targetname");
  var_8 = scripts\sp\utility::_id_10639(var_1, var_7.origin, var_7.angles);
  level._id_DA9C = getEntArray(var_0, "targetname");
  var_7 scripts\sp\anim::_id_1EC3(var_8, var_3);

  foreach(var_10 in level._id_DA9C) {
    if(isDefined(var_10.script_linkto)) {
      var_11 = strtok(var_10.script_linkto, " ");
      var_12 = [];

      foreach(var_14 in var_11)
      var_12[var_12.size] = getEnt(var_14, "script_linkname");

      if(var_12.size) {
        for(var_16 = 0; var_16 < var_12.size; var_16++)
          var_12[var_16] linkTo(var_10);
      }
    }

    if(isDefined(var_10.script_noteworthy)) {
      var_10 linkTo(var_8, "j_prop_" + var_10.script_noteworthy, (0, 0, 0), (0, 0, 0));
      var_10 scripts\engine\utility::delaycall(0.1, ::unlink);
    }
  }

  scripts\engine\utility::flag_wait(var_5);

  foreach(var_10 in level._id_DA9C) {
    if(isDefined(var_10.script_noteworthy))
      var_10 linkTo(var_8, "j_prop_" + var_10.script_noteworthy, (0, 0, 0), (0, 0, 0));
  }

  var_7 scripts\sp\anim::_id_1F35(var_8, var_3);

  foreach(var_10 in level._id_DA9C) {
    if(isDefined(var_10.script_parameters)) {
      var_7 scripts\sp\anim::_id_1EEA(var_8, var_4, var_6);
      var_8 disconnectPaths();
    }
  }
}

#using_animtree("generic_human");

_id_63D2(var_0) {
  level endon("preload_started");
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = [];
  scripts\engine\utility::flag_wait("final_wave_spawn");
  var_2[4] = scripts\sp\utility::_id_107EA("exfil_anim_enemy5", 1);
  var_2[4] thread _id_F907();
  var_2[4]._id_1FBB = "generic";
  var_2[5] = scripts\sp\utility::_id_107EA("exfil_anim_enemy6", 1);
  var_2[5] thread _id_F907();
  var_2[5]._id_1FBB = "generic";
  var_2[6] = scripts\sp\utility::_id_107EA("exfil_anim_enemy7", 1);
  var_2[6] thread _id_F907();
  var_2[6]._id_1FBB = "generic";
  scripts\engine\utility::flag_wait("spawn_anim_enemies");
  scripts\engine\utility::waitframe();
  var_2[0] = scripts\sp\utility::_id_107EA("exfil_anim_enemy1", 1);
  var_2[0]._id_1FBB = "generic";
  var_2[1] = scripts\sp\utility::_id_107EA("exfil_anim_enemy2", 1);
  var_2[1]._id_1FBB = "generic";
  var_2[2] = scripts\sp\utility::_id_107EA("exfil_anim_enemy3", 1);
  var_2[2]._id_1FBB = "generic";
  var_2[3] = scripts\sp\utility::_id_107EA("exfil_anim_enemy4", 1);
  var_2[3]._id_1FBB = "generic";
  var_1 thread scripts\sp\anim::_id_1F35(var_2[0], "exfil_enemy1");
  var_1 thread scripts\sp\anim::_id_1F35(var_2[1], "exfil_enemy2");
  var_1 thread scripts\sp\anim::_id_1F35(var_2[2], "exfil_enemy3");
  var_1 thread scripts\sp\anim::_id_1F35(var_2[3], "exfil_enemy4");

  if(isDefined(var_2[4]) && isalive(var_2[4])) {
    var_1 thread scripts\sp\anim::_id_1F35(var_2[4], "exfil_enemy5");
    var_2[4] thread _id_6AFA();
  }

  if(isDefined(var_2[5]) && isalive(var_2[5]))
    var_1 thread scripts\sp\anim::_id_1F35(var_2[5], "exfil_enemy6");

  if(isDefined(var_2[6]) && isalive(var_2[6]))
    var_1 thread scripts\sp\anim::_id_1F35(var_2[6], "exfil_enemy7");

  var_3 = getanimlength(%sa_moon_cargobay_outro_ememy7_alive_start);
  wait(var_3);

  foreach(var_5 in var_2) {
    if(isDefined(var_5) && isalive(var_5))
      var_5 delete();
  }
}

_id_F965(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 = scripts\sp\utility::_id_10639("capitalships_props", var_3.origin, var_3.angles);
  level._id_68FF linkTo(var_4, "j_prop_1", (0, 0, 0), (0, 0, 0));
  level._id_6930 linkTo(var_4, "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_3 scripts\sp\anim::_id_1F35(var_4, var_2);
}

_id_FA0D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::getStruct(var_1, "targetname");
  self._id_1FBB = var_0;

  if(isDefined(var_6)) {
    var_8 = level._id_128F[var_6];
    self thread[[var_8]]();
  }

  if(!scripts\engine\utility::flag("exfil_flyout_checkpoint_start")) {
    var_7 scripts\sp\anim::_id_1EC3(self, var_2);
    scripts\engine\utility::flag_wait(var_4);
    var_7 scripts\sp\anim::_id_1F35(self, var_2);
  }

  scripts\engine\utility::flag_set("player_jackal_ready");
  var_7 scripts\sp\anim::_id_1EEA(self, var_3, var_5);
}

_id_F8B5(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("player_in_exfil_jackal");
  var_6 = scripts\engine\utility::getStruct(var_1, "targetname");
  self._id_1FBB = var_0;
  var_6 thread scripts\sp\anim::_id_1EEA(self, var_3);
  scripts\engine\utility::flag_wait(var_5);
  var_6 scripts\sp\anim::_id_1F35(self, var_2);

  if(isDefined(self))
    self delete();
}

_id_F8B4(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  self._id_1FBB = var_0;
  var_3 scripts\sp\anim::_id_1F35(self, var_2);
}

_id_FA0B(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_5 = scripts\sp\utility::_id_10639("player_rig", var_4.origin, var_4.angles);
  var_6 = var_5;
  var_6 hide();
  var_7 = scripts\sp\utility::_id_10639("cargo_bay_button", var_4.origin, var_4.angles);
  var_8 = scripts\sp\utility::_id_10639("cargo_bay_lever", var_4.origin, var_4.angles);
  var_4 scripts\sp\anim::_id_1EC3(var_8, var_1);
  var_4 scripts\sp\anim::_id_1EC3(var_7, var_1);
  var_4 scripts\sp\anim::_id_1EC3(var_5, var_1);
  scripts\engine\utility::flag_wait(var_2);
  _id_D85C();
  level.player _meth_823C(var_6, "tag_player", 0.5, 0.25);
  wait 0.5;
  level.player playerlinktodelta(var_6, "tag_player", 1.0, 0, 0, 0, 0, 1);
  var_6 show();

  if(isDefined(var_3)) {
    var_9 = level._id_128F[var_3];
    var_5 thread[[var_9]]();
  }

  var_4 thread scripts\sp\anim::_id_1F35(var_6, var_1);
  var_4 thread scripts\sp\anim::_id_1F35(var_7, var_1);
  var_4 thread scripts\sp\anim::_id_1F35(var_8, var_1);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A88();
  wait 0.25;
  level.player lerpviewangleclamp(1, 0.5, 0, 10, 10, 5, 5);
  var_6 waittillmatch("single anim", "guys_spawn");
  scripts\engine\utility::flag_set("spawn_anim_enemies");
  var_6 waittillmatch("single anim", "button_press");
  scripts\engine\utility::flag_set("player_pressed_the_button");
  var_6 waittillmatch("single anim", "show_robot");
  scripts\engine\utility::flag_set("start_c12_anim");
  var_6 waittillmatch("single anim", "gunfire_off");
  scripts\engine\utility::flag_set("stop_fake_player_gunfire");
  var_6 waittillmatch("single anim", "gravity_off");
  scripts\engine\utility::flag_set("turn_exfil_gravity_off");
  var_6 waittillmatch("single anim", "end");
  var_6 hide();
  _id_DF3E();
  scripts\engine\utility::flag_set("button_press_done");
  var_5 delete();
}

_id_FA06(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_5 = scripts\sp\utility::_id_10639("player_rig");
  var_6 = var_5;
  var_6 hide();
  var_4 thread scripts\sp\anim::_id_1EC3(var_6, var_1);
  level._id_D127 = level._id_6922;
  var_7 = level._id_D127;
  var_6 linkTo(var_7, "tag_player", (0, 0, 0), (0, 0, 0));
  thread _id_F967(var_7);
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  scripts\engine\utility::flag_waitopen("player_using_grapple");
  setDvar("grapple_kill_idx", -1);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6919();
  _id_D85C();
  self _meth_823C(var_6, "tag_player", 0.1);
  wait 0.1;
  level.player playerlinktodelta(var_6, "tag_player", 1, 5, 5, 5, 5, 1);
  level.player _meth_8392(3);
  var_6 show();

  if(isDefined(var_3)) {
    var_8 = level._id_128F[var_3];
    var_7 thread[[var_8]]();
  }

  var_4 thread scripts\sp\anim::_id_1F35(var_7, var_1);
  scripts\engine\utility::flag_set("player_in_exfil_jackal");
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132B2(0);
  var_7 thread scripts\sp\anim::_id_1F35(var_6, var_1, "tag_player");
  var_7 waittillmatch("single anim", "sa_moon_flyout_outro_jackal_plr_start");
  scripts\engine\utility::flag_set("carrier_dead");
}

_id_D85C() {
  level.player _meth_80D1();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player._id_5610 = 1;
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player _meth_84FE();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_81DE(65, 1);
}

_id_DF3E() {
  level.player unlink();
  level.player showviewmodel();
  level.player _meth_84FD();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player._id_5610 = 0;
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player _meth_80A1();
}

_id_FA87(var_0) {
  if(!isDefined(var_0))
    var_0 = "cargobay_cover_float";

  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = randomfloatrange(80, 220);
  var_3 = randomfloatrange(3, 8);

  foreach(var_5 in var_1) {
    if(isDefined(var_5.target)) {
      var_6 = getEntArray(var_5.target, "targetname");

      foreach(var_8 in var_6)
      var_8 linkTo(var_5);

      var_10 = scripts\engine\utility::getStruct(var_6[0].target, "targetname");
      scripts\engine\utility::waitframe();

      if(!isDefined(var_10.script_parameters))
        var_5 moveTo(var_10.origin, var_3, 1, var_3 - 1);
      else
        var_5 movez(var_2, 1);
    }

    var_5 thread _id_6F3F();
    var_5 thread _id_4385(800);
  }
}

_id_6F3F() {
  var_0 = randomint(2);

  if(var_0 == 0)
    var_1 = randomint(361);
  else
    var_1 = -1 * randomint(361);

  if(var_0 == 0)
    var_2 = randomint(361);
  else
    var_2 = -1 * randomint(361);

  if(var_0 == 0)
    var_3 = randomint(361);
  else
    var_3 = -1 * randomint(361);

  var_4 = randomfloatrange(20, 50);

  for(;;) {
    self rotateby((var_1, var_2, var_3), var_4, 0, 0);
    self waittill("rotatedone");
  }
}

_id_4385(var_0) {
  var_1 = var_0 * var_0;
  var_2 = 0;

  for(;;) {
    var_3 = distancesquared(self.origin, level.player.origin);

    if(var_2 && var_3 > var_1) {
      var_2 = 0;
      self notsolid();
    } else if(!var_2 && var_3 < var_1) {
      var_2 = 1;
      self solid();
    }

    wait(randomfloatrange(0.2, 0.4));
  }
}

_id_FA86() {
  var_0 = scripts\sp\utility::_id_22CD("exfil_float_enemy", 1);

  foreach(var_2 in var_0) {
    scripts\engine\utility::waitframe();
    var_2 scripts\sp\utility::_id_54C6();
  }
}

_id_63E1(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 scripts\sp\utility::_id_10619(1);
  scripts\engine\utility::waitframe();
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  scripts\engine\utility::waitframe();
  var_3 _meth_83B9(var_4.origin);
  scripts\engine\utility::waitframe();
  var_5 = anglesToForward(var_4.angles) * var_1;
  var_3 scripts\sp\utility::_id_54C6();
  var_3 scripts\anim\shared::_id_5D1A();
  var_3 _meth_839B("torso_upper", var_5);
}

_id_2845() {
  var_0 = getEnt("red_barrel_toss", "targetname");
  var_1 = scripts\engine\utility::getStruct("red_barrel_toss_pos", "targetname");
  var_0 scripts\sp\utility::_id_11624(var_1);
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * randomfloatrange(200, 500);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = randomfloatrange(10, 100);
  radiusdamage(var_0.origin, 10, 100, 1);
  var_0 _meth_8224(var_0.origin, (var_3, var_4, var_5));
}

_id_6AFA() {
  level endon("preload_started");
  level endon("stop_fake_player_gunfire");

  for(;;) {
    if(isDefined(self))
      thread _id_B14C();

    wait(randomfloatrange(0.1, 0.3));
  }
}

_id_B14C() {
  if(isDefined(self.weapon) && self.weapon != "none") {
    var_0 = getweaponflashtagname(self.weapon);
    var_1 = self gettagorigin(var_0);
    var_2 = scripts\engine\utility::getStructArray("player_lever_fake_attack_end", "targetname");
    playFXOnTag(scripts\engine\utility::getfx("ak47_muzzleflash"), self, "tag_flash");
    magicbullet("iw7_ar57", var_1, var_2[randomintrange(0, var_2.size)].origin);
    bullettracer(var_1, var_2[randomintrange(0, var_2.size)].origin, "iw7_ar57", 1);
  }
}

_id_691D() {
  level endon("player_in_exfil_jackal");
  scripts\engine\utility::flag_wait("player_jackal_ready");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_F979("exfil_grapple_point", "player_using_grapple");
}

_id_F967(var_0) {
  var_1 = spawn("Script_model", (0, 0, 0));
  var_1 setModel(level.vehicle._id_116CE._id_13265[var_0.classname]._id_D375);
  var_1 _id_0BDC::_id_4310();
  var_1 _id_0BDC::_id_4323();
  var_1 linkTo(var_0, "tag_body", (-0.01, 0, 0), (0, 0, 0));
  var_1 hide();
  var_1 notsolid();
  scripts\engine\utility::flag_wait("player_in_exfil_jackal");
  var_0 scripts\engine\utility::delaythread(0.05, _id_0BDC::_id_A2DE, 0);
  var_0 _id_0C20::_id_A3B7("none", 0);
  wait 2;
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_515E();
  var_0 thread _id_0BDC::_id_4323();
  var_0 scripts\sp\maps\sa_moon\sa_moon_util::_id_A32B();
  wait 2;
  var_0 thread scripts\sp\maps\sa_moon\sa_moon_intro::_id_F978(0);
  _id_0BDC::_id_A228();
  level.player scripts\sp\utility::_id_65E1("disable_jackal_overheat");
  setomnvar("ui_jackal_weapon_display_temp", 0);
  setomnvar("ui_jackal_show_horizon", 0);
  thread _id_0BDC::_id_A224(1, 1);
  setomnvar("ui_jackal_current_weapon", "spaceship_30mm_projectile");
  _id_0BDC::_id_A224(1, 0);
}