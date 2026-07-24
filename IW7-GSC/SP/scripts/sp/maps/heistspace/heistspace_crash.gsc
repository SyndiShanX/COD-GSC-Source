/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_crash.gsc
***********************************************************/

_id_A132() {
  level._id_A132 = 1;
  scripts\sp\utility::_id_F5AF("mons_ret_crash_moveto", [level.player]);
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_jackal_crash");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_BC27("jackal_crash_begin");
}

_id_A12F() {
  level.player.health = level.player.maxhealth;
  level.player _meth_80D1();
  level._id_C413 scripts\engine\utility::delaythread(1, _id_0BA9::_id_397B);
  visionsetalternate(7, 0.5);
  setglobalsoundcontext("atmosphere", "space");

  if(isDefined(level._id_A132))
    wait 0.5;

  scripts\engine\utility::flag_set("jackal_crash_begin");
  thread scripts\sp\maps\heistspace\heistspace_audio::_id_C7B8();
  scripts\engine\utility::flag_set("yard_obj_assist_salt_done");
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "1");
  setsaveddvar("sm_sunCascadeSizeMultiplier2", "2");
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C7(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(1);
  level scripts\engine\utility::delaythread(2, scripts\sp\maps\heistspace\heistspace_util::_id_8D2A, "stage3");

  if(_id_0B76::_id_7B95() > 0) {
    foreach(var_1 in level._id_D127._id_93D2) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }

  if(isDefined(level._id_D127)) {
    level._id_D127 _id_0BDC::_id_F358("instant");
    level._id_D127 _id_0BDC::_id_F448("instant");
    level._id_D127 _id_E074();
  }

  level.player _meth_818A();
  level.player disableweapons();
  setomnvar("ui_gettocover_state", 5);
  setomnvar("ui_hide_hud", 1);
  level.player.health = level.player.maxhealth;
  level.player _meth_80D1();
  var_3 = scripts\sp\utility::_id_10639("player_rig");
  var_3 notsolid();
  var_4 = scripts\sp\vehicle::_id_1080C("salter_jackal_cine");
  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, var_4);
  var_4._id_1FBB = "crash_player_jackal";
  thread _id_F97A(var_4);
  _id_0BDC::_id_A156();
  var_5 = scripts\engine\utility::getStruct("retribution_crash_animnode", "targetname");
  var_6 = [];
  var_6[0] = scripts\sp\utility::_id_10639("crash_mons");
  var_6[1] = scripts\sp\utility::_id_10639("crash_ret");
  var_6[2] = scripts\sp\utility::_id_10639("crash_shipyard");
  var_6[3] = var_4;
  level thread _id_13492();
  var_7 = scripts\sp\utility::_id_10639("crash_vista_destroyer", var_5.origin, var_5.angles);
  level thread _id_88A9(var_7);
  level thread _id_B395();
  var_5 scripts\sp\anim::_id_1EC1(var_6, "outro");
  level._id_C412 = scripts\sp\vehicle::_id_1080C("om_2");
  level._id_C412.origin = var_6[0].origin;
  level._id_C412.angles = var_6[0].angles;
  level._id_C412 linkTo(var_6[0], "tag_origin");
  level._id_E35D.origin = var_6[1].origin;
  level._id_E35D.angles = var_6[1].angles;
  level._id_E35D linkTo(var_6[1], "tag_origin");
  level._id_EAA7 = scripts\sp\utility::_id_10639("crash_salter");
  var_5 scripts\sp\anim::_id_1EC3(level._id_EAA7, "outro");
  var_8 = getEntArray("heistspace_stage3", "targetname");
  var_9 = undefined;

  foreach(var_11 in var_8) {
    if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "shipyard_model")
      var_9 = var_11;
  }

  if(isDefined(var_9)) {
    var_9.origin = var_6[2].origin;
    var_9.angles = var_6[2].angles;
    var_9 linkTo(var_6[2], "tag_origin");
  }

  var_3 linkTo(var_4, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player _meth_823B(var_3, "tag_player");
  scripts\engine\utility::waitframe();
  level.player playerlinktodelta(var_3, "tag_player", 0, 30, 30, 30, 10, 1);
  level.player _meth_8392(0.5, 5, 5);
  level.player _meth_81DE(69, 0.05);
  thread _id_4806();
  var_4 thread scripts\sp\maps\heistspace\heistspace_fx::_id_1334D();
  var_4 thread scripts\sp\maps\heistspace\heistspace_fx::_id_13333();
  var_4 thread scripts\sp\maps\heistspace\heistspace_fx::_id_1333D();
  var_4 thread scripts\sp\maps\heistspace\heistspace_fx::_id_1333E();
  var_4 thread scripts\sp\maps\heistspace\heistspace_fx::_id_1334F();
  scripts\engine\utility::flag_set("play_outro_mars_anim");
  var_5 thread scripts\sp\anim::_id_1F2C(var_6, "outro");
  var_5 thread scripts\sp\anim::_id_1F35(var_7, "outro");
  thread _id_ACB9();
  thread _id_C414();
  thread _id_E3AE();
  thread _id_62E0();
  var_5 thread scripts\sp\anim::_id_1F35(level._id_EAA7, "outro");
  var_4 scripts\sp\anim::_id_1F35(var_3, "outro", "tag_player");
  level.player unlink(1);
  var_13 = level.player.origin + (0, 0, 128);
  level.player setOrigin(var_13);
  scripts\engine\utility::flag_set("crash_script_model_clean_up");
  level.player _meth_80A1();
  level.player _meth_82C0("fade_to_black_minus_music", 0.1);
  scripts\sp\utility::_id_BF95();
}

_id_4806() {
  wait 1.5;
  _id_0B0A::_id_583F(0, 0.07, 3.9, 30000, 10000, 0.56, 1.5);
  level waittill("crash_blur_out_01");
  wait 1.75;
  _id_0B0A::_id_583F(0, 207.2, 4.3, 58000, 87500, 0.0, 1.0);
  level waittill("crash_blur_out_02");
  wait 0.5;
  _id_0B0A::_id_583F(0, 0.07, 3.9, 58000, 87500, 0.0, 0.25);
  level waittill("crash_blur_out_03");
  level.player _meth_82C0("fade_to_black_minus_music", 5.5);
  _id_0B0A::_id_583F(0, 207.2, 6.0, 300, 1000, 6.0, 12.0);
  scripts\engine\utility::flag_wait("crash_script_model_clean_up");
  _id_0B0A::_id_583D(1.5);
}

_id_F97A(var_0) {
  level.player _meth_8497(1);
  var_0 _id_0BDB::_id_A32A();
}

_id_C414() {
  wait 2;
  level._id_C412 _id_0BB8::_id_39D0("off");
  level._id_C412 _id_0BB8::_id_39CD("heavy");
  wait 13.75;
  level._id_C412 _id_0BB8::_id_39D0("hburst");
}

_id_E3AE() {
  wait 1;
  level._id_E35D _id_0BB8::_id_39D0("off");
}

_id_A137() {}

_id_13492() {
  var_0 = getEntArray("shipyard_capitalship", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

_id_88A9(var_0) {
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_1");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_2");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_3");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_4");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_5");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_6");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_7");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_8");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_9");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_1076D(var_0, "veh_mil_air_ca_destroyer_vista_s0p32", "J_prop_10");
  scripts\engine\utility::flag_wait("crash_script_model_clean_up");
  var_0 delete();
}

_id_B395() {
  var_0 = scripts\engine\utility::getStruct("retribution_crash_animnode", "targetname");
  var_1 = scripts\sp\utility::_id_10639("crash_mars", var_0.origin, var_0.angles);
  var_2 = getEntArray("mars", "script_noteworthy");

  foreach(var_4 in var_2) {
    var_4 = spawn("script_model", var_1 gettagorigin("J_prop_1"));
    var_4.angles = var_1 gettagangles("J_prop_1");
    var_4 linkTo(var_1, "J_prop_1", (0, 0, 0), (0, 0, 0));
  }

  scripts\engine\utility::flag_wait("play_outro_mars_anim");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "outro");
  scripts\engine\utility::flag_wait("crash_script_model_clean_up");
  var_1 delete();
}

_id_ACB9() {
  wait 6.5;
  setsaveddvar("sm_sunSampleSizeNear", 15);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "16");
  setsaveddvar("sm_sunCascadeSizeMultiplier2", "17");
  wait 18;
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "1");
  setsaveddvar("sm_sunCascadeSizeMultiplier2", "2");
}

_id_E074(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!var_0) {
    level.player scripts\sp\utility::_id_65E1("flag_player_dismounting");
    self[[self._id_A7B9]]();
    _id_0BDB::_id_5686();
    _id_0BDB::_id_DF4D();
    _id_0BD4::_id_A2D9();
    level.player _meth_81E3(0);
    self notify("player_exit_jackal");
    _id_0BD5::_id_4086();
    thread _id_0BD9::_id_D176(0.0, 0, 0.2, 0.01, 0.3);
  }

  var_1 = self[[self._id_5688]]();
  _id_0BDB::_id_569B();
  _id_0BDB::_id_569C();
  level._id_A056 notify("player_left_jackal");

  if(scripts\engine\utility::is_true(self._id_FF24))
    _id_0BDC::_id_A07D();

  _id_0BDC::_id_A208();
  _id_0BDC::_id_A0AF();
  _id_0BDC::_id_6B4C(var_1);
  _id_0BDC::_id_104A6(1);
  self freeentitysentient();

  if(isDefined(self._id_AD34))
    self._id_AD34 delete();
}

_id_62E0() {
  clearallcorpses();
  scripts\engine\utility::waitframe();
  thread _id_12BBA();
  scripts\sp\utility::_id_2669("jackal_crash_start");
}

_id_12BBA() {
  scripts\sp\utility::_id_1264E("heistspace_om_ordnance_tr");
  scripts\sp\utility::_id_1264E("heistspace_mons_ext_bridge_tr");
  wait 8;
  scripts\sp\utility::_id_1264E("heistspace_base_tr");
  level thread scripts\sp\utility::_id_BF97();
}