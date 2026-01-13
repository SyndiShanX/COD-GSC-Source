/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_dps.gsc
***************************************************/

func_107B7() {
  if(!isDefined(level.var_12B67)) {
    level.var_12B67 = scripts\sp\vehicle::func_1080C("un_retribution");
  }

  level.var_12B67 scripts\sp\vehicle::playgestureviewmodel();
  level.var_12B67.var_1FBB = "retribution";
}

func_A0F0() {
  scripts\engine\utility::flag_init("jackals_in_view");
  thread func_A0EF();
  level.var_D127 = scripts\sp\vehicle::func_1080C("jackal_player");
  level.var_D127 motionblurhqenable();
  level.var_D127 func_0BDC::func_104A6(0);
  level.var_D127 func_0BDC::func_F5BD("phspace_launch");
  level.var_D127 func_0BDC::func_F420(500, 135, -30, 0, 1);
  level.var_D127 func_0BDC::func_A19F();
  func_107C1();
  var_0 = scripts\engine\utility::getstruct("jackal_callin_launch_animnode", "targetname");
  var_0 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 = "jackal_callin";

  if(getdvarint("E3", 0)) {
    var_1 = "jackal_callin_dps";
  }

  wait 0.1;
  scripts\sp\vehicle_build::func_31C6("script_vehicle_jackal_friendly_pearl", "default", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::func_31C6("script_vehicle_jackal_friendly", "default", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  var_0 thread func_376C(level.var_D127, var_1);
  var_0 thread func_376E(level.var_EA99, var_1);

  if(!isDefined(level.var_10256)) {
    level waittill("jackals_landed");
    level.var_D127 func_0BDC::func_6B4C("none", 0);
    level.var_D127 func_0BDC::func_104A6(1);

    if(getdvarint("E3", 0)) {
      scripts\sp\utility::func_15F5("jackals_salter_to_jackal_dps");
    } else {
      scripts\sp\utility::func_15F5("jackals_salter_to_jackal");
    }

    func_0BDC::func_137CF();
  }

  if(getdvarint("e3", 0)) {
    thread func_1358D();
  }

  level.var_D127 func_0BDC::func_A167();
  func_0BDC::func_A153(1);
  _setsaveddvar("r_MBEnable", 0);
  var_0 notify("stop_idle");
  thread func_F5A5();
  thread disablelmgmount();
}

func_1358D() {
  wait 3;
  scripts\sp\utility::func_12641("phspace_ground_tr");
  _setsaveddvar("r_usePrebuiltSunShadow", 2);
  wait 0.5;
  _setsaveddvar("r_usePrebuiltSunShadow", 1);
}

disablelmgmount() {
  func_0BDC::func_137DA();
  func_0BDC::func_A156(1);
}

func_6271() {
  wait 7.0;
  _setsaveddvar("r_MBEnable", 1);
}

func_F5A5() {
  wait 4.0;
  func_1050B();
}

func_1050B() {
  _setsaveddvar("r_transShadowEnable", 1);
  _setsaveddvar("r_heightfieldSunShadow", 0);
  _setsaveddvar("sm_sunSampleSizeNear", 1.1);
  _setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
}

func_A0EF() {
  scripts\engine\utility::flag_wait("jackals_in_view");
  scripts\sp\utility::func_10350("dps_s31_jackalstouching");
  scripts\engine\utility::flag_wait("jackals_landed");
  wait 2.2;
  func_0BDC::func_137CF();
}

func_8A02() {
  level.player endon("flag_player_has_jackal");
  wait 8;
  level.allies["salter"] scripts\sp\utility::func_10346("phspace_slt_letsgetamoveont");
  wait 6;
  level.allies["salter"] scripts\sp\utility::func_10346("phspace_slt_hopinletsgetbac");
  wait 10;
  level.allies["eth3n"] scripts\sp\utility::func_10346("phspace_eth_itsmyfirsttimei");
}

func_376C(var_0, var_1) {
  if(!isDefined(level.var_10256)) {
    var_0 scripts\engine\utility::delaythread(1, func_0BDC::func_6B4C, "fly", 1);
    var_0.var_1FBB = "player_jackal";
    var_0 scripts\sp\anim::func_F64A();
    var_0 func_0BDC::func_A2DE(1);
    var_0 scripts\engine\utility::delaythread(4.1, scripts\sp\utility::play_sound_on_tag, "phstreets_jackal_land_plr", "j_canopy");
    var_0 scripts\engine\utility::delaythread(13.8, scripts\sp\utility::play_sound_on_tag, "phstreets_jackal_land_swt", "j_canopy");
    level.player thread func_CA93();
    var_0 scripts\engine\utility::delaythread(11, func_0BDC::func_A1DD, "hover");
    var_0 scripts\engine\utility::delaythread(8.5, func_0BDC::func_6B4C, "hover", 1);
    thread scripts\sp\anim::func_1F35(var_0, var_1);
    var_2 = getanimlength(level.var_EC85["player_jackal"][var_1]);
    thread func_C12F(var_2);
    scripts\engine\utility::delaythread(var_2 - 4, ::func_1130D, "jackal_callin_player_clip_e3");
    var_2 = getanimlength(level.var_EC85["player_jackal"][var_1]);
    scripts\engine\utility::delaythread(var_2 - 9, scripts\engine\utility::flag_set, "jackals_in_view");
    wait(var_2);
    scripts\engine\utility::flag_set("jackals_landed");
  } else {
    var_0.var_1FBB = "player_jackal";
    var_0 scripts\sp\anim::func_F64A();
    var_0 func_0BDC::func_A2DE(1);
    func_0BDC::func_10CD1(var_0, undefined, "land", "phspace_launch");
  }
}

func_376E(var_0, var_1) {
  var_0.var_1FBB = "salter_jackal";
  var_0 scripts\sp\anim::func_F64A();

  if(!isDefined(level.var_10256)) {
    var_0 scripts\engine\utility::delaythread(10, func_0BDC::func_6B4C, "hover", 1);
    var_0 func_0BDC::func_19A0();
    var_2 = getanimlength(level.var_EC85["salter_jackal"][var_1]);
    thread func_C12F(var_2);
    scripts\engine\utility::delaythread(var_2 - 4, ::func_1130D, "jackal_callin_salter_clip_e3");
    scripts\sp\anim::func_1F35(var_0, var_1);
    var_0 func_0BDC::func_19A0();
    var_0 func_0BDC::func_6B4C("landed_mode", 1);
    thread scripts\sp\anim::func_1EEA(var_0, "jackal_callin_dps_idle", "stop_idle");
  } else {
    var_0 func_0BDC::func_19A0();
    var_0 func_0BDC::func_6B4C("landed_mode", 1);
    thread scripts\sp\anim::func_1EEA(var_0, "jackal_callin_dps_idle", "stop_idle");
  }
}

func_C12F(var_0) {
  wait(var_0 - 7);
  level notify("dc_e3_path");
}

func_1130D(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  if(level.player istouching(var_1)) {
    level.player _meth_81D0();
  }

  var_1 solid();
  func_0BDC::func_137CF();
  wait 0.1;
  var_1 delete();
}

func_376D(var_0, var_1) {
  var_0.var_1FBB = "retribution";
  var_0 scripts\sp\anim::func_F64A();

  if(!isDefined(level.var_10256)) {
    scripts\sp\anim::func_1F35(var_0, var_1);
  } else {
    thread scripts\sp\anim::func_1F35(var_0, var_1);
    var_2 = [var_0];
    scripts\sp\anim::func_1F2A(var_2, var_1, 1);
  }
}

func_CA93() {
  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      level.player _meth_82C0("jackal_cockpit", 2);
      level waittill("jackal_landing");
      level.player playSound("jackal_landing_plr");
      level.var_D127 waittill("jackal_touchdown");
      level.player playSound("jackal_landed");
      level.player clearclienttriggeraudiozone(2.0);
      wait 2;
    } else {
      level waittill("jackal_enter");
      wait 1;
      level.player waittill("jackal_vtol_takeoff_plr");
      level.player playSound("jackal_vtol_takeoff_plr");
      wait 2;
    }

    wait 0.1;
  }
}

func_107C1() {
  if(!isDefined(level.var_EA99)) {
    level.var_EA99 = scripts\sp\vehicle::func_1080C("jackal_salter");
  }

  level.var_EA99.var_1FBB = "salter_jackal";
  level.var_EA99.unittype = "jackal";
  level.var_EA99 func_0BDC::func_6B4C("fly", 1);
}