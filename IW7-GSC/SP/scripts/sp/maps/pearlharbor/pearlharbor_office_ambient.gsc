/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_office_ambient.gsc
**********************************************************************/

_id_ADE0() {
  _id_ADAD("office_interior_ambient", ::_id_C34A, ::_id_C34B);
}

_id_409F() {
  _id_404E("office_interior_ambient");
}

_id_C34A() {}

_id_C34B(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    switch (var_3) {
      case "hallway_guard_01":
        var_4 = var_0[var_3];
        var_4 _id_2A4A();
        break;
      case "hallway_guard_02":
        var_4 = var_0[var_3];
        var_4 _id_2A4A();
        break;
      case "memorial_guard_01":
        var_4 = var_0[var_3];
        var_4 _id_2A4A();
        break;
      default:
        var_4 = var_0[var_3];
        var_4 thread _id_1F5E(0.0, 0.0);
    }
  }
}

_id_2A4A() {
  scripts\sp\utility::_id_86E2();
  scripts\sp\utility::_id_51E1("casual_gun");
  thread _id_1F5E(0.0, 0.0);
  _id_0EE5::_id_202D();
}

_id_ADC9() {
  _id_ADAD("exterior_balcony_ambient", ::_id_6A32, ::_id_6A37);
}

_id_ADCB() {
  _id_ADAD("exterior_balcony_front_ambient", ::_id_6A32, ::_id_6A37);
  _id_ADAD("exterior_balcony_reactors", ::_id_6A32, ::_id_276C);
  thread _id_F977("balcony_convo_1A", "phparade_un11_okaythisisactually");
}

_id_ADCC() {
  _id_ADAD("exterior_terrace_ambient_front", ::_id_6A32, ::_id_6A37);
  _id_ADAD("exterior_upperterrace_ambient_front", ::_id_6A32, ::_id_6A37);
  disable_ambient_shadows("exterior_upperterrace_ambient_front");
  _id_F972();
  _id_F96F();
}

_id_ADCD() {
  _id_ADAD("exterior_terrace_ambient", ::_id_6A32, ::_id_6A37);
  _id_ADAD("exterior_upperterrace_ambient", ::_id_6A32, ::_id_6A37);
  disable_ambient_shadows("exterior_upperterrace_ambient");
  thread _id_F977("terrace_convo_5B", "phparade_un9_youseehowmany");
}

_id_ADCA() {
  _id_ADAD("exterior_checkpoint_ambient", ::_id_6A32, ::_id_6A37);
  _id_ADAD("exterior_uppercheckpoint_ambient", ::_id_6A32, ::_id_6A37);
  disable_ambient_shadows("exterior_uppercheckpoint_ambient");
  thread _id_F977("terrace_convo_8B", "phparade_un11_hahathatsourship");
}

_id_ADC8() {
  _id_ADAD("exterior_backside_ambient", ::_id_6A32, ::_id_6A37);
}

_id_407B() {
  _id_404E("exterior_balcony_front_ambient");
  _id_404E("exterior_balcony_reactors");
}

_id_4079() {
  _id_404E("exterior_balcony_ambient");
}

_id_407D() {
  _id_404E("exterior_terrace_ambient");
  _id_404E("exterior_upperterrace_ambient");
}

_id_407C() {
  _id_404E("exterior_terrace_ambient_front");
  _id_404E("exterior_upperterrace_ambient_front");
}

_id_407A() {
  _id_404E("exterior_checkpoint_ambient");
  _id_404E("exterior_uppercheckpoint_ambient");
}

_id_4078() {
  _id_404E("exterior_backside_ambient");
}

enable_ambient_shadows(var_0) {
  if(isDefined(level._id_1D6B) && isDefined(level._id_1D6B[var_0])) {
    foreach(var_2 in level._id_1D6B[var_0])
    var_2 castshadows();
  }
}

disable_ambient_shadows(var_0) {
  if(isDefined(level._id_1D6B) && isDefined(level._id_1D6B[var_0])) {
    foreach(var_2 in level._id_1D6B[var_0])
    var_2 dontcastshadows();
  }
}

#using_animtree("generic_human");

_id_6A32() {
  if(scripts\engine\utility::flag_exist("exterior_anims_loaded"))
    return;
  else
    scripts\engine\utility::flag_init("exterior_anims_loaded");

  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig1_idle1"][0] = % ph_un_rooftop_railing_tk1_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig2_idle1"][0] = % ph_un_rooftop_railing_tk1_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig1_idle2"][0] = % ph_un_rooftop_railing_tk1_rig1_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig2_idle2"][0] = % ph_un_rooftop_railing_tk1_rig2_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk1_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig2_reaction1"][0] = % ph_un_rooftop_railing_tk1_rig2_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig1_reaction2"][0] = % ph_un_rooftop_railing_tk1_rig1_reaction2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig2_reaction2"][0] = % ph_un_rooftop_railing_tk1_rig2_reaction2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk2_rig1_idle1"][0] = % ph_un_rooftop_railing_tk2_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk2_rig2_idle1"][0] = % ph_un_rooftop_railing_tk2_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk2_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk2_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk2_rig2_reaction1"][0] = % ph_un_rooftop_railing_tk2_rig2_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk3_rig1_idle1"][0] = % ph_un_rooftop_railing_tk3_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk3_rig2_idle1"][0] = % ph_un_rooftop_railing_tk3_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk3_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk3_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk3_rig1_reaction4"][0] = % ph_un_rooftop_railing_tk3_rig1_reaction4;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk3_rig2_reaction4"][0] = % ph_un_rooftop_railing_tk3_rig2_reaction4;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk4_rig1_idle1"][0] = % ph_un_rooftop_railing_tk4_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk4_rig2_idle1"][0] = % ph_un_rooftop_railing_tk4_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk4_rig2_idle2"][0] = % ph_un_rooftop_railing_tk4_rig2_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk4_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk4_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk4_rig1_reaction3"][0] = % ph_un_rooftop_railing_tk4_rig1_reaction3;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk4_rig2_reaction3"][0] = % ph_un_rooftop_railing_tk4_rig2_reaction3;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk5_rig1_idle1"][0] = % ph_un_rooftop_railing_tk5_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk5_rig2_idle1"][0] = % ph_un_rooftop_railing_tk5_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk5_rig1_idle2"][0] = % ph_un_rooftop_railing_tk5_rig1_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk5_rig2_idle2"][0] = % ph_un_rooftop_railing_tk5_rig2_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk5_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk5_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk5_rig2_reaction1"][0] = % ph_un_rooftop_railing_tk5_rig2_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig1_idle1"][0] = % ph_un_rooftop_railing_tk6_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig2_idle1"][0] = % ph_un_rooftop_railing_tk6_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig1_idle2"][0] = % ph_un_rooftop_railing_tk6_rig1_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig2_idle2"][0] = % ph_un_rooftop_railing_tk6_rig2_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk6_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig2_reaction1"][0] = % ph_un_rooftop_railing_tk6_rig2_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig1_reaction2"][0] = % ph_un_rooftop_railing_tk6_rig1_reaction2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk6_rig2_reaction2"][0] = % ph_un_rooftop_railing_tk6_rig2_reaction2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk7_rig1_idle1"][0] = % ph_un_rooftop_railing_tk7_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk7_rig2_idle1"][0] = % ph_un_rooftop_railing_tk7_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk7_rig1_idle2"][0] = % ph_un_rooftop_railing_tk7_rig1_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk7_rig2_idle2"][0] = % ph_un_rooftop_railing_tk7_rig2_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig1_idle1"][0] = % ph_un_rooftop_railing_tk8_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig2_idle1"][0] = % ph_un_rooftop_railing_tk8_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig1_idle2"][0] = % ph_un_rooftop_railing_tk8_rig1_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig2_idle2"][0] = % ph_un_rooftop_railing_tk8_rig2_idle2;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig1_reaction1"][0] = % ph_un_rooftop_railing_tk8_rig1_reaction1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig2_reaction1"][0] = % ph_un_rooftop_railing_tk8_rig2_reaction1;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_01"][0] = % shipcrib_stand_stationary_talk_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_02"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_03"][0] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_04"][0] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_05"][0] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EC85["generic"]["ph_parade_un_cheering_01"] = % ph_parade_un_cheering_01;
  level._id_EC85["generic"]["ph_parade_un_cheering_02"] = % ph_parade_un_cheering_02;
  level._id_EC85["generic"]["ph_parade_un_cheering_03"] = % ph_parade_un_cheering_03;
  level._id_EC85["generic"]["ph_parade_un_cheering_04"] = % ph_parade_un_cheering_04;
  level._id_EC85["generic"]["ph_parade_un_cheering_05"] = % ph_parade_un_cheering_05;
  level._id_EC85["generic"]["ph_parade_standing_01_react_01"] = % ph_parade_standing_01_react_01;
  level._id_EC85["generic"]["ph_parade_standing_01_react_02"] = % ph_parade_standing_01_react_02;
  level._id_EC85["generic"]["ph_parade_standing_02_react_01"] = % ph_parade_standing_02_react_01;
  level._id_EC85["generic"]["ph_parade_standing_02_react_02"] = % ph_parade_standing_02_react_02;
  level._id_EC85["generic"]["ph_parade_standing_03_react_01"] = % ph_parade_standing_03_react_01;
  level._id_EC85["generic"]["ph_parade_standing_03_react_02"] = % ph_parade_standing_03_react_02;
  level._id_EC85["generic"]["ph_parade_standing_04_react_01"] = % ph_parade_standing_04_react_01;
  level._id_EC85["generic"]["ph_parade_standing_04_react_02"] = % ph_parade_standing_04_react_02;
  level._id_EC85["generic"]["ph_parade_standing_05_react_01"] = % ph_parade_standing_05_react_01;
  level._id_EC85["generic"]["ph_parade_standing_05_react_02"] = % ph_parade_standing_05_react_02;
  level._id_EC85["generic"]["shipcrib_lounge_lean_idle_02"][0] = % shipcrib_lounge_lean_idle_02;
  level._id_EC85["generic"]["shipcrib_chillwalll_idle_01"][0] = % shipcrib_chillwalll_idle_01;
  level._id_EC85["generic"]["shipcrib_chillwalll_idle_02"][0] = % shipcrib_chillwalll_idle_02;
  level._id_EC85["generic"]["SH4_5_1_TTN_HALLWAY_ALLY01_idle"][0] = % sh4_5_1_ttn_hallway_ally01_idle;
  level._id_EC85["generic"]["SH4_5_1_TTN_HALLWAY_ALLY02_idle"][0] = % sh4_5_1_ttn_hallway_ally02_idle;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig2_idle1"][0] = % ph_un_rooftop_railing_tk8_rig2_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk8_rig1_idle1"][0] = % ph_un_rooftop_railing_tk8_rig1_idle1;
  level._id_EC85["generic"]["ph_un_rooftop_railing_tk1_rig1_idle1"][0] = % ph_un_rooftop_railing_tk1_rig1_idle1;
}

_id_6A37(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];
    var_4 thread _id_1F5E(0.0, 0.0);
  }
}

_id_276C(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];

    switch (var_4._id_1D77) {
      case "shipcrib_stand_stationary_talk_idle_01":
        var_4 thread _id_CCA4(1);
        break;
      case "shipcrib_stand_stationary_talk_idle_02":
        var_4 thread _id_CCA4(2);
        break;
      case "shipcrib_stand_stationary_talk_idle_03":
        var_4 thread _id_CCA4(3);
        break;
      case "shipcrib_stand_stationary_talk_idle_04":
        var_4 thread _id_CCA4(4);
        break;
      case "shipcrib_stand_stationary_talk_idle_05":
        var_4 thread _id_CCA4(5);
        break;
      default:
        var_4 thread _id_1F5E(0.0, 0.0);
    }
  }
}

_id_6A3C(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];
    var_4 thread _id_1F5E(0.0, 0.0);
  }
}

_id_CCA4(var_0) {
  self endon("death");

  if(!scripts\engine\utility::flag("ext_first_stop")) {
    var_1 = "ph_parade_un_cheering_0" + var_0;
    var_2 = "ph_parade_standing_0" + var_0 + "_react_0" + randomintrange(1, 3);
    wait 1.75;
    scripts\engine\utility::delaycall(0.1, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_1), randomfloatrange(0.3, 0.5));
    self._id_1EEF scripts\sp\anim::_id_1F35(self, var_1);
    self._id_1EEF scripts\sp\anim::_id_1F35(self, var_2);
    self._id_1EEF scripts\sp\anim::_id_1F35(self, var_1);
    thread _id_0EE5::_id_2036(var_0);
  } else
    thread _id_1F5E(0.0, 0.0);
}

_id_B00F() {
  self endon("stop_lookat");

  if(!isDefined(level._id_276A)) {
    level._id_276A = scripts\engine\utility::getStructArray("balcony_lookpoint", "targetname");

    if(level._id_276A.size == 0)
      return;
  }

  var_0 = randomint(level._id_276A.size + 1);
  var_1 = level._id_276A[var_0];
  scripts\sp\utility::_id_7799(var_1);

  for(;;) {
    wait(randomfloatrange(3, 12));
    var_0 = _id_7BED(level._id_276A, var_0);
    var_1 = level._id_276A[var_0];
    scripts\sp\utility::_id_779B(var_1);
  }
}

_id_B006(var_0, var_1) {}

_id_7BED(var_0, var_1) {
  for(;;) {
    var_2 = randomint(var_0.size + 1);

    if(var_2 != var_1)
      return var_2;
  }
}

_id_CE5D() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8D9("navy_crew", "lower_terrace_mover1_start");
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8D9("navy_crew", "lower_terrace_mover2_start");
  var_2 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8D9("navy_crew", "lower_terrace_mover3_start");
  var_3 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8D9("navy_crew", "lower_terrace_mover4_start");
  var_4 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8D9("navy_crew", "lower_terrace_mover5_start");
  var_0 endon("death");

  for(;;) {
    var_0 thread _id_0B6A::_id_EC0B("lower_terrace_mover1_end", "shipcrib_stand_stationary_talk_idle_03");
    wait 0.33;
    var_1 thread _id_0B6A::_id_EC0B("lower_terrace_mover2_end", "shipcrib_stand_stationary_talk_idle_03");
    wait 0.33;
    var_2 _id_0B6A::_id_EC0B("lower_terrace_mover3_end", "shipcrib_stand_stationary_talk_idle_03");
    wait 3;
    var_3 thread _id_0B6A::_id_EC0B("lower_terrace_mover4_end", "shipcrib_stand_stationary_talk_idle_03");
    wait 0.33;
    var_4 _id_0B6A::_id_EC0B("lower_terrace_mover5_end", "shipcrib_stand_stationary_talk_idle_03");
    wait 3;
    var_0 thread _id_0B6A::_id_EC0B("lower_terrace_mover1_start", "shipcrib_stand_stationary_talk_idle_03");
    wait 0.33;
    var_1 thread _id_0B6A::_id_EC0B("lower_terrace_mover2_start", "shipcrib_stand_stationary_talk_idle_03");
    wait 0.33;
    var_2 _id_0B6A::_id_EC0B("lower_terrace_mover3_start", "shipcrib_stand_stationary_talk_idle_03");
    wait 3;
    var_3 thread _id_0B6A::_id_EC0B("lower_terrace_mover4_start", "shipcrib_stand_stationary_talk_idle_03");
    wait 0.33;
    var_4 _id_0B6A::_id_EC0B("lower_terrace_mover5_start", "shipcrib_stand_stationary_talk_idle_03");
    wait 3;
  }
}

_id_ADE1() {}

_id_C34F() {}

_id_C350(var_0) {}

_id_F96D() {
  _id_F96F();
  _id_F970();
  _id_F972();
  thread _id_F977("terrace_convo_5B", "phparade_un9_youseehowmany");
  thread _id_F977("terrace_convo_8B", "phparade_un11_hahathatsourship");
  thread _id_F977("balcony_convo_1A", "phparade_un11_okaythisisactually");
}

_id_CD0A(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("death");
  var_3 endon("death");
  _id_4602(var_1);

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    _id_4602(var_1);
    var_6 = var_0[var_5];

    if(issubstr(var_6, var_2)) {
      var_1 _id_CD78(var_6);
      continue;
    }

    if(issubstr(var_6, var_4))
      var_3 _id_CD78(var_6);
  }
}

_id_4602(var_0) {
  var_1 = 128;

  while(distance2d(level.player.origin, var_0.origin) > var_1)
    scripts\engine\utility::waitframe();
}

_id_CD78(var_0) {
  self endon("death");
  thread scripts\sp\utility::_id_77B7("salute");
  self setanimknob(%facial_talk_1, 10, 0.33, 1);
  scripts\sp\utility::_id_10346(var_0);
  self setanimknob(%facial_talk_1, 0, 0.33, 0);
}

_id_F977(var_0, var_1) {
  if(scripts\engine\utility::flag_exist(var_1 + "_fired")) {
    return;
  }
  var_2 = _id_780D(var_0);
  var_2 endon("death");
  _id_4602(var_2);
  scripts\engine\utility::flag_init(var_1 + "_fired");
  var_2 _id_CD78(var_1);
}

_id_F96E() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un8_justtakeabottle";
  var_0[var_0.size] = "phparade_un7_imnotdoingit";
  var_0[var_0.size] = "phparade_un8_imthelookoutjust";
  var_0[var_0.size] = "phparade_un7_yeahandthenraines";
  var_0[var_0.size] = "phparade_un8_geezyoureparanoidits";
  var_0[var_0.size] = "phparade_un7_thenyoudoit";
  var_0[var_0.size] = "phparade_un8_ialreadygota";
  var_0[var_0.size] = "phparade_un7_hedoesnthateyou";
  var_0[var_0.size] = "phparade_un8_willyoukeepyour";
  var_0[var_0.size] = "phparade_un8_ialreadygota";
  var_1 = _id_780D();
  var_2 = _id_780D();
  thread _id_CD0A(var_0, var_1, "_un8_", var_2, "_un7_");
}

_id_F96F() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un12_gotfireworksgoinoff";
  var_0[var_0.size] = "phparade_un13_unsassparingnoexpense";
  var_0[var_0.size] = "phparade_un12_prettycoolgottaadmit";
  var_0[var_0.size] = "phparade_un13_yeahviewsnotbad";
  var_1 = _id_780D("terrace_convo_2A");
  var_2 = _id_780D("terrace_convo_2B");
  thread _id_CD0A(var_0, var_1, "_un13_", var_2, "_un12_");
}

_id_F970() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un9_sharonhereyet";
  var_0[var_0.size] = "phparade_un10_onherwayshes";
  var_1 = _id_780D("terrace_convo_4A");
  var_2 = _id_780D("terrace_convo_4B");
  thread _id_CD0A(var_0, var_1, "_un9_", var_2, "_un10_");
}

_id_F971() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un12_asacmcyou";
  var_0[var_0.size] = "phparade_un8_getalotof";
  var_0[var_0.size] = "phparade_un12_allthetimecaught";
  var_0[var_0.size] = "phparade_un8_hehhowdoi";
  var_0[var_0.size] = "phparade_un12_giveagoodtwenty";
  var_1 = _id_780D();
  var_2 = _id_780D();
  thread _id_CD0A(var_0, var_1, "_un12_", var_2, "_un8_");
}

_id_F972() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un13_yougotreassigned";
  var_0[var_0.size] = "phparade_un7_yeahtothetunguska";
  var_0[var_0.size] = "phparade_un13_beatstheorionid";
  var_0[var_0.size] = "phparade_un7_sowhatareyou";
  var_0[var_0.size] = "phparade_un13_ohdontworryabout";
  var_1 = _id_780D("terrace_convo_1A");
  var_2 = _id_780D("terrace_convo_1B");
  var_2 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  thread _id_CD0A(var_0, var_2, "_un13_", var_1, "_un7_");
}

_id_F973() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un9_somegrapewasstanding";
  var_0[var_0.size] = "phparade_un8_luckyhedidntget";
  var_0[var_0.size] = "phparade_un9_forrealneverseen";
  var_1 = _id_780D();
  var_2 = _id_780D();
  thread _id_CD0A(var_0, var_1, "_un9_", var_2, "_un8_");
}

_id_F974() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un10_shesaidstandnear";
  var_0[var_0.size] = "phparade_un11_yousureshemeant";
  var_0[var_0.size] = "phparade_un10_definitelywaitit";
  var_0[var_0.size] = "phparade_un11_woahhhh";
  var_0[var_0.size] = "phparade_un10_hahahayeah";
  var_0[var_0.size] = "phparade_un11_boom";
  var_0[var_0.size] = "phparade_un10_whatditellyou";
  var_1 = _id_780D();
  var_2 = _id_780D();
  thread _id_CD0A(var_0, var_1, "_un10_", var_2, "_un11_");
}

_id_F975() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un12_nowaymancall";
  var_0[var_0.size] = "phparade_un7_iveheardsomegood";
  var_0[var_0.size] = "phparade_un12_likewhatghostthey";
  var_0[var_0.size] = "phparade_un7_whatsyourcallsign";
  var_0[var_0.size] = "phparade_un12_grunchdell";
  var_0[var_0.size] = "phparade_un7_laughswhatdoesthat";
  var_0[var_0.size] = "phparade_un12_justforgetaboutit";
  var_1 = _id_780D();
  var_2 = _id_780D();
  thread _id_CD0A(var_0, var_1, "_un12_", var_2, "_un7_");
}

_id_F976() {
  var_0 = [];
  var_0[var_0.size] = "phparade_un8_andthewholetime";
  var_0[var_0.size] = "phparade_un13_laughsyouneedto";
  var_0[var_0.size] = "phparade_un8_forgetthattheguy";
  var_0[var_0.size] = "phparade_un13_laughstohimselfyou";
  var_1 = _id_780D();
  var_2 = _id_780D();
  thread _id_CD0A(var_0, var_1, "_un8_", var_2, "_un13_");
}

_id_ADAD(var_0, var_1, var_2) {
  [[var_1]]();
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_4 = _id_1062F(var_3);
  _id_DE95(var_0, var_4);
  [[var_2]](var_4);
}

_id_1062F(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = _id_C8BD(var_4);
    var_5._id_1D77 = var_4.animation;
    var_5._id_1EEF = var_4;

    if(isDefined(var_4.target))
      var_6 = getEnt(var_4.target, "targetname");

    if(isDefined(var_4.script_noteworthy))
      var_7 = var_4.script_noteworthy;
    else {
      var_2++;
      var_7 = "auto" + var_2;
    }

    var_5._id_1DCA = var_7;
    var_1[var_7] = var_5;
  }

  return var_1;
}

_id_780D(var_0) {
  if(isDefined(level._id_1D6B)) {
    foreach(var_2 in level._id_1D6B) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4._id_1DCA) && var_4._id_1DCA == var_0)
          return var_4;
      }
    }
  } else
    return undefined;
}

_id_DE95(var_0, var_1) {
  if(!isDefined(level._id_1D6B))
    level._id_1D6B = [];

  level._id_1D6B[var_0] = var_1;
}

_id_404E(var_0) {
  if(isDefined(level._id_1D6B) && isDefined(level._id_1D6B[var_0]))
    _id_EA08(level._id_1D6B[var_0]);
}

_id_C8BD(var_0) {
  var_1 = _id_7B67(var_0.script_parameters);
  var_2 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8D9(var_1, var_0, 1);
  return var_2;
}

_id_7B67(var_0) {
  if(!isDefined(var_0))
    var_0 = "navy_crew";

  return var_0;
}

_id_1F5E(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(var_2))
    scripts\engine\utility::flag_wait(var_2);

  if(isDefined(var_3)) {
    if(var_3)
      _id_137C5();
  }

  wait(var_0);
  _id_9867();

  if(_id_9E86(self._id_1D77))
    _id_CC81(self._id_1D77, var_0, var_1);
  else {
    _id_CC7C(self._id_1D77, var_0, var_1);
    _id_404F();
  }
}

_id_CC81(var_0, var_1, var_2) {
  self._id_1EEF thread scripts\sp\anim::_id_1ECC(self, var_0, "stop_loop");
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, _id_7DC7(var_0), var_2);
  play_looping_skit_anim(var_2);
}

_id_CC7C(var_0, var_1, var_2) {
  var_3 = getanimlength(scripts\sp\utility::_id_7DC1(var_0));
  self._id_1EEF thread scripts\sp\anim::_id_1EC7(self, var_0);
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0), var_2);
  _id_CE0E(var_2);
  wait(var_3 - var_2 * var_3);
}

_id_404F() {
  _id_40C4();
  _id_EA07(self);
}

_id_EA07(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  if(isai(var_0))
    var_0 _meth_81D0();

  var_0 delete();
}

_id_EA08(var_0) {
  foreach(var_2 in var_0)
  _id_EA07(var_2);
}

_id_9E86(var_0) {
  if(isDefined(level._id_EC85[self._id_1FBB][var_0])) {
    if(isarray(level._id_EC85[self._id_1FBB][var_0]))
      return 1;
    else
      return 0;
  } else
    return 0;
}

_id_7DC7(var_0) {
  return level._id_EC85[self._id_1FBB][var_0][0];
}

_id_9867() {
  self._id_DA9E = _id_781D(self._id_1D77);

  if(self._id_DA9E.size > 0)
    self._id_DA9C = _id_1063B(self._id_DA9E);
}

_id_781D(var_0) {
  var_1 = [];
  var_2 = getarraykeys(level._id_EC8C);

  foreach(var_4 in var_2) {
    if(isDefined(level._id_EC85[var_4])) {
      if(isDefined(level._id_EC85[var_4][var_0]))
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

_id_1063B(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1 = scripts\engine\utility::array_add(var_1, scripts\sp\utility::_id_10639(var_3));

  return var_1;
}

play_looping_skit_anim(var_0) {
  if(isDefined(self._id_DA9C)) {
    foreach(var_2 in self._id_DA9C) {
      self._id_1EEF thread scripts\sp\anim::_id_1EEA(var_2, self._id_1D77, "stop_loop");
      var_2 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_2 _id_7DC7(self._id_1D77), var_0);
      thread _id_DB7A(var_2, self);
    }
  }
}

_id_CE0E(var_0) {
  if(isDefined(self._id_DA9C)) {
    foreach(var_2 in self._id_DA9C) {
      self._id_1EEF thread scripts\sp\anim::_id_1F35(var_2, self._id_1D77, "stop_loop");
      var_2 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_2 scripts\sp\utility::_id_7DC1(self._id_1D77), var_0);
    }
  }
}

_id_40C4() {
  if(isDefined(self._id_DA9C)) {
    foreach(var_1 in self._id_DA9C)
    var_1 delete();
  }
}

_id_DB7A(var_0, var_1) {
  var_1 waittill("death");
  var_0 delete();
}

_id_CC87(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_F272 = _id_8113();
  _id_9867();
  _id_CC81(self._id_F272["start"], 0, var_1);

  if(isDefined(var_2))
    scripts\engine\utility::flag_wait(var_2);

  if(isDefined(var_3)) {
    if(var_3)
      _id_137C5();
  }

  wait(var_0);
  self._id_1EEF notify("stop_loop");
  _id_CC7C(self._id_1D77, var_0, var_1);
  _id_CC81(self._id_F272["end"], 0, var_1);
}

_id_8113() {
  if(isDefined(self._id_1EEF.script_side)) {
    var_0 = strtok(self._id_1EEF.script_side, ",");
    var_1 = [];

    if(isDefined(var_0[0]) && isDefined(var_0[1])) {
      var_1["start"] = var_0[0];
      var_1["end"] = var_0[1];
    } else {}

    return var_1;
  } else {}
}

_id_137C5() {
  var_0 = 0;

  while(var_0 == 0) {
    if(level.player scripts\sp\utility::_id_D637(self.origin))
      var_0 = 1;

    wait 0.1;
  }
}

_id_1D6C(var_0, var_1) {
  if(!isDefined(level._id_45E7)) {
    level._id_45E7 = [];
    _id_DEA6();
  }

  if(scripts\engine\utility::array_contains(level._id_45E7, var_0)) {
    var_0._id_1912 = scripts\engine\utility::array_add(var_0._id_1912, var_1);
    return;
  }

  level._id_45E7 = scripts\engine\utility::array_add(level._id_45E7, var_0);
  var_0._id_1912 = [var_1];
  var_2 = var_0.script_parameters;
  var_0 waittill("trigger");

  foreach(var_1 in var_0._id_1912) {
    if(!isDefined(var_1)) {
      return;
    }
    var_1 endon("entitydeleted");
  }

  var_5 = level._id_45E8[var_2];
  var_6 = 0;

  foreach(var_8 in var_5._id_ACF2) {
    var_1 = var_0._id_1912[var_6];
    var_1 scripts\sp\utility::play_sound_on_entity(var_8);
    var_6++;

    if(var_6 >= var_0._id_1912.size)
      var_6 = 0;
  }
}

_id_DEA6() {
  level._id_45E8 = [];
  level._id_45E8["convo2"] = spawnStruct();
  level._id_45E8["convo2"]._id_ACF2 = ["phparade_un12_gotfireworksgoinoff", "phparade_un13_unsassparingnoexpense", "phparade_un12_prettycoolgottaadmit", "phparade_un13_yeahviewsnotbad"];
  level._id_45E8["convo4"] = spawnStruct();
  level._id_45E8["convo4"]._id_ACF2 = ["phparade_un12_asacmcyou", "phparade_un8_getalotof", "phparade_un12_allthetimecaught", "phparade_un8_hehhowdoi", "phparade_un12_giveagoodtwenty"];
  level._id_45E8["convo5"] = spawnStruct();
  level._id_45E8["convo5"]._id_ACF2 = ["phparade_un13_yougotreassigned", "phparade_un7_yeahtothetunguska", "phparade_un13_beatstheorionid", "phparade_un7_sowhatareyou", "phparade_un13_ohdontworryabout"];
  level._id_45E8["convo7"] = spawnStruct();
  level._id_45E8["convo7"]._id_ACF2 = ["phparade_un10_shesaidstandnear", "phparade_un11_yousureshemeant", "phparade_un10_definitelywaitit", "phparade_un11_woahhhh", "phparade_un10_hahahayeah", "phparade_un11_boom", "phparade_un10_whatditellyou"];
}