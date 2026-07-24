/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3030.gsc
**************************************/

_id_621A() {
  if(!_id_0BDC::_id_A1AC("missile_drone"))
    _id_0BDC::_id_A1AA("missile_drone", ::_id_B7ED, ::_id_B7EF, ::_id_B7EE);
}

disable_missile_drone_event() {
  if(_id_0BDC::_id_A1AC("missile_drone"))
    _id_0BDC::_id_A1AD("missile_drone");

  if(scripts\engine\utility::flag("jackal_supply_drop_hint"))
    scripts\engine\utility::flag_clear("jackal_supply_drop_hint");

  if(scripts\engine\utility::flag("jackal_missile_drone_primed"))
    scripts\engine\utility::flag_clear("jackal_missile_drone_primed");

  level notify("disable_missiledrone");
}

_id_B7ED(var_0) {
  if(level._id_D127.missiles.count > 0)
    return 0;

  if(scripts\engine\utility::flag("jackal_missile_drone_primed"))
    return 0;

  var_1 = 7;

  if(gettime() - level._id_D127.missiles._id_A8E8 < var_1 * 1000)
    return 0;

  if(scripts\engine\utility::flag("jackal_runway_landing_active"))
    return 0;

  return 1;
}

_id_B7EF(var_0) {
  thread missile_drone_event_threaded();
}

missile_drone_event_threaded() {
  scripts\engine\utility::flag_set("jackal_missile_drone_primed");
  _id_B35F();

  if(_id_0BDC::_id_A1AC("missile_drone")) {
    scripts\engine\utility::flag_set("jackal_missile_drone_active");
    _id_0BDC::_id_A14A();
    _id_0BDC::_id_A14E();
    _id_0BDC::_id_A149();
    thread _id_13C10();
    level._id_D127 waittill("missiles_restocked");
    level._id_A056._id_A9BD = gettime();
    _id_0BDC::_id_A14A(0);
    _id_0BDC::_id_A14E(0);
    _id_0BDC::_id_A149(0);
    scripts\engine\utility::flag_clear("jackal_missile_drone_active");
  }

  scripts\engine\utility::flag_clear("jackal_missile_drone_primed");
}

_id_B7EE(var_0) {}

_id_B35F() {
  level endon("disable_missiledrone");
  scripts\engine\utility::flag_set("jackal_supply_drop_hint");

  if(isDefined(level._id_B833))
    thread scripts\sp\utility::_id_56BA("jackal_supply_drop");
  else
    thread scripts\sp\utility::_id_56BE("jackal_supply_drop", 4);

  _id_0BDC::_id_A112("jackal_hud_missile_supply_available", 20);
  level.player notifyonplayercommand("callin_supply_drone", "+actionslot 2");
  level.player waittill("callin_supply_drone");
  scripts\engine\utility::flag_clear("jackal_supply_drop_hint");
  level._id_D127 notify("drone_dropzone_marked");
}

_id_13C10() {
  if(!isDefined(level._id_D127)) {
    return;
  }
  _id_0BDC::_id_A162();
  _id_0BDC::_id_A161();
  scripts\engine\utility::delaythread(0.2, _id_0BDC::_id_A112, "jackal_hud_supplydroneinbo", 2);
  var_0 = (1500, 0, 200);
  var_1 = _id_107E5();
  thread _id_5D07(var_0, var_1);
  var_1 waittill("deployed");
  _id_5BFD(var_0, var_1);
  _id_5CA1(var_1);
  _id_B7EC(var_1);
  _id_0BDC::_id_A162(0);
}

#using_animtree("vehicles");

_id_107E5() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("veh_mil_air_un_support_drone");
  var_0 hide();
  var_0 _meth_83D0(#animtree);
  var_0 _id_13C0C();
  return var_0;
}

_id_10753() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("veh_mil_air_un_landing_drone");
  var_0 _meth_83D0(#animtree);
  var_0 _id_A7D5();
  playFXOnTag(scripts\engine\utility::getfx("landing_drone_light_top"), var_0, "j_mainroot");
  return var_0;
}

_id_106AC(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("veh_mil_air_un_support_drone_pod");
  var_1 playSound("drone_pod_incoming");
  var_1 _id_0BDC::_id_F2FF();
  var_1 notsolid();
  return var_1;
}

_id_5D07(var_0, var_1) {
  level endon("stop_drop_pod_logic");
  var_2 = 3.5;
  var_3 = (4000, 2000, 35000);
  var_4 = level.player _meth_8473();
  var_5 = (0, var_4.angles[1], 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = (0, 0, 1);
  var_9 = var_6 * var_3[0] + var_6 * var_3[1] + var_8 * var_3[2];
  var_10 = _id_106AC(var_4.origin + var_9);
  var_1 linkTo(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("weapon_drone_pod_trail"), var_10, "tag_origin");
  var_11 = 0;
  thread _id_5D04(var_2);
  var_12 = var_2;

  while(isDefined(var_10)) {
    var_4 = level.player _meth_8473();
    var_13 = scripts\sp\math::_id_C097(0, var_2, var_12);
    var_6 = anglesToForward(var_4.angles);
    var_7 = anglesToForward(var_4.angles);
    var_8 = anglesToForward(var_4.angles);
    var_9 = var_3;
    var_14 = var_6 * var_0[0] + var_7 * var_0[1] + var_8 * var_0[2];
    var_15 = scripts\sp\math::_id_6A8E(var_14, var_9, var_13);
    var_10.origin = var_4.origin + var_15;
    var_12 = var_12 - 0.05;

    if(var_12 < 0 && !var_11) {
      playworldsound("drone_pod_open", var_10.origin);
      playFXOnTag(scripts\engine\utility::getfx("weapon_drone_pod_open"), var_10, "tag_origin");
      earthquake(0.15, 0.6, level._id_D127.origin, 5000);
      var_10 hide();
      var_10 thread _id_5D02();
      var_1 notify("deployed");
      var_11 = 1;
    }

    level.player waittill("on_player_update");
  }
}

_id_5D02() {
  wait 0.2;
  stopFXOnTag(scripts\engine\utility::getfx("weapon_drone_pod_trail"), self, "tag_origin");
  wait 2;
  level notify("stop_drop_pod_logic");
  self delete();
}

_id_5D04(var_0) {
  var_1 = (450, 0, 50);

  for(var_2 = undefined; var_0 > 0; var_0 = var_0 - 0.05) {
    var_3 = level.player _meth_8473();
    var_4 = var_1[0];
    var_5 = var_1[2];
    var_6 = anglesToForward(var_3.angles);
    var_7 = anglestoup(var_3.angles);
    var_8 = anglestoright(var_3.angles);

    if(!isDefined(var_2)) {
      var_2 = scripts\engine\utility::spawn_tag_origin(var_3.origin + var_6 * var_4 + var_7 * var_5);
      var_2 thread _id_10CA7(var_0);
      var_2 thread _id_13C0F();
      var_2 _id_0BDC::_id_F2FF();
    }

    var_2.origin = var_3.origin + var_6 * var_4 + var_7 * var_5;
    var_2.angles = axistoangles(var_6 * -1, var_8 * -1, var_7);
    level.player waittill("on_player_update");
  }

  var_2 delete();
}

_id_10CA7(var_0) {
  _id_0BDC::_id_105DB("missile", undefined, "droppod_marker", undefined, 0, undefined, 1);
  wait 0.05;
  wait(var_0 - 0.1);
  _id_0BDC::_id_105DA();
}

_id_13C0F() {
  self endon("entitydeleted");

  for(;;) {
    self playSound("drone_marker_timer");
    wait 1.1;
  }
}

_id_5BFD(var_0, var_1) {
  var_2 = level.player _meth_8473();
  var_1 unlink();
  var_1 _id_0BDC::_id_F2FF();
  var_1 _meth_82B1(%weapon_drone_fly_init, 1);
  var_1._id_FC28 = scripts\engine\utility::spawn_tag_origin();
  var_1._id_FC28 _id_0BDC::_id_F2FF();
  var_1 thread _id_5C87();
  var_1 scripts\sp\utility::_id_75C4("landing_drone_light_top_blink", "j_mainroot");
  var_3 = 0;
  var_4 = (0, 0, 0);
  var_5 = [0, 0];
  var_6 = [0, 0];
  var_7 = 2500;
  var_8 = 375;
  var_9 = [%drone_move_f_overlay, %drone_move_b_overlay, %drone_move_l_overlay, %drone_move_r_overlay];
  var_10 = [%drone_acc_f_overlay, %drone_acc_b_overlay, %drone_acc_l_overlay, %drone_acc_r_overlay];
  var_11 = 4.4;
  var_12 = 1.5;
  var_13 = 3.0;
  var_14 = 0.5;
  var_15 = undefined;
  var_1 thread _id_112AA(var_11, var_12, var_14);
  var_1 _id_0BDC::_id_A25B(var_11, "j_mainroot_ship", (325.491, 0, 14.494), (0, 180, 0));
  var_16 = (0, 0, 0);

  while(var_11 > 0) {
    level.player waittill("on_player_update");

    if(var_3)
      var_1 show();

    var_3 = 1;
    var_2 = level.player _meth_8473();

    if(!isDefined(var_2)) {
      continue;
    }
    var_17 = var_0[0];
    var_18 = var_0[2];
    var_19 = 1.0;
    var_20 = anglesToForward(var_2.angles);
    var_21 = anglestoup(var_2.angles);
    var_22 = anglestoright(var_2.angles);
    var_23 = var_2.origin + var_20 * var_17 + var_21 * var_18;
    var_24 = distance(var_23, var_1.origin);
    var_25 = 100;
    var_26 = 0.15;
    var_27 = 500;
    var_28 = 0.35;
    var_29 = scripts\sp\math::_id_C097(var_25, var_27, var_24);
    var_30 = scripts\sp\math::_id_6A8E(var_26, var_28, var_29);
    var_4 = var_4 - rotatevectorinverted(var_2.spaceship_vel, var_2.angles) * var_19;
    var_31 = var_2.spaceship_rotvel * 0.05;
    var_32 = rotatevectorinverted(var_1.origin - var_2.origin, var_2.angles);
    var_33 = rotatevector(var_32, var_31);
    var_34 = var_33 - var_32;
    var_4 = var_4 - var_34;

    if(var_13 > 0)
      var_35 = 1;
    else {
      if(!isDefined(var_15))
        var_15 = var_11;

      var_35 = scripts\sp\math::_id_C097(0, var_15, var_11);
      var_35 = scripts\sp\math::_id_C09B(var_35);
    }

    var_36 = var_4 - var_16;
    var_37 = scripts\sp\math::_id_C097(0, var_7, length(var_4));
    var_38 = scripts\sp\math::_id_C097(0, var_8, length(var_36));
    var_39 = vectorNormalize(var_4) * var_37;
    var_40 = vectorNormalize(var_36) * var_38;
    var_5 = var_1 _id_5C4D(var_39, var_5, 1, var_9, var_35);
    var_6 = var_1 _id_5C4D(var_40, var_6, 1, var_10, var_35);
    var_4 = var_4 * (1 - var_30);
    var_41 = rotatevector(var_4, var_2.angles);
    var_1.origin = var_23 + var_41;
    var_1._id_FC28.origin = var_23 + var_41;
    var_1.angles = axistoangles(var_20 * -1, var_22 * -1, var_21);
    var_16 = var_4;
    var_11 = var_11 - 0.05;
    var_13 = var_13 - 0.05;
  }

  var_1 scripts\sp\utility::_id_75A0("landing_drone_light_top_blink", "j_mainroot");
  var_1 scripts\sp\utility::_id_75C4("landing_drone_light_top", "j_mainroot");
  var_1._id_FC28 delete();
}

_id_5BFC(var_0) {
  var_1 = self._id_102D1._id_5BD7;
  var_1 endon("notify_drone_reset");
  var_1.active = 1;

  if(!isDefined(var_0))
    var_2 = level.player _meth_8473();
  else
    var_2 = level._id_D127;

  var_1 unlink();
  var_1 _id_0BDC::_id_F2FF();
  var_1 _meth_82B1(%landing_drone_fly_init, 1);
  var_1 thread _id_5C3E();
  var_1 thread _id_5C95();
  var_3 = var_1.origin - var_2.origin;
  var_3 = rotatevectorinverted(var_3, var_2.angles);
  var_4 = 0;
  var_5 = (0, 0, 0);
  var_6 = [0, 0];
  var_7 = [0, 0];
  var_8 = 2500;
  var_9 = 375;
  var_10 = [%drone_move_f_overlay, %drone_move_b_overlay, %drone_move_l_overlay, %drone_move_r_overlay];
  var_11 = [%drone_acc_f_overlay, %drone_acc_b_overlay, %drone_acc_l_overlay, %drone_acc_r_overlay];

  if(!isDefined(var_0)) {
    var_12 = 2.4;
    var_13 = 1.0;
    var_14 = 1.0;
    var_15 = undefined;
  } else {
    var_12 = 0.8;
    var_13 = 0.05;
    var_14 = 0.05;
    var_15 = undefined;
  }

  thread _id_A7D4(var_12, var_13);
  var_16 = (340, 0, 40);
  var_17 = (0, 0, 0);
  var_18 = 0;
  var_19 = 0;
  var_20 = 0.05;
  var_21 = var_12;
  var_1 _id_0BDC::_id_A25B(var_12, "tag_body", (325.491, 0, 14.494), (0, 180, 0), var_0);

  for(;;) {
    if(var_21 <= 0) {
      break;
    }

    level.player waittill("on_player_update");

    if(!isDefined(var_0))
      var_2 = level.player _meth_8473();
    else
      var_2 = level._id_D127;

    if(!isDefined(var_2)) {
      continue;
    }
    var_22 = var_3[0];
    var_23 = -1 * var_3[1];
    var_24 = var_3[2];
    var_25 = 1.0;
    var_26 = anglesToForward(var_2.angles);
    var_27 = anglestoup(var_2.angles);
    var_28 = anglestoright(var_2.angles);
    var_29 = var_2.origin + var_26 * var_22 + var_28 * var_23 + var_27 * var_24;
    var_30 = distance(var_29, var_1.origin);
    var_31 = var_2.origin + var_26 * var_16[0] + var_28 * var_16[1] + var_27 * var_16[2];
    var_32 = 600;
    var_33 = 0.15;
    var_34 = 2500;
    var_35 = 0.25;
    var_36 = scripts\sp\math::_id_C097(var_32, var_34, var_30);
    var_37 = scripts\sp\math::_id_6A8E(var_33, var_35, var_36);

    if(!isDefined(var_0))
      var_5 = var_5 - rotatevectorinverted(var_2.spaceship_vel, var_2.angles) * var_25;
    else
      var_5 = var_5 - rotatevectorinverted(var_2.angles * 100, var_2.angles) * var_25;

    var_38 = var_2.spaceship_rotvel * 0.05;
    var_39 = rotatevectorinverted(var_1.origin - var_2.origin, var_2.angles);
    var_40 = rotatevector(var_39, var_38);
    var_41 = var_40 - var_39;
    var_5 = var_5 - var_41;

    if(var_14 > 0) {
      var_19 = var_19 + var_20;
      var_19 = clamp(var_19, 0, 1);
    } else {
      if(!isDefined(var_15))
        var_15 = var_21;

      var_19 = scripts\sp\math::_id_C097(0, var_15, var_21);
      var_19 = scripts\sp\math::_id_C09B(var_19);
    }

    var_42 = var_5 - var_17;
    var_43 = scripts\sp\math::_id_C097(0, var_8, length(var_5));
    var_44 = scripts\sp\math::_id_C097(0, var_9, length(var_42));
    var_45 = vectorNormalize(var_5) * var_43;
    var_46 = vectorNormalize(var_42) * var_44;
    var_6 = var_1 _id_5C4D(var_45, var_6, 1, var_10, var_19);
    var_7 = var_1 _id_5C4D(var_46, var_7, 1, var_11, var_19);
    var_47 = scripts\sp\math::_id_C097(0, var_12, var_21);
    var_48 = scripts\sp\math::_id_6A8E(var_31, var_29, var_47);
    var_49 = var_29;
    var_5 = var_5 * (1 - var_37);
    var_50 = rotatevector(var_5, var_2.angles);
    var_50 = var_50 * var_47;
    var_1.origin = var_48 + var_50;
    var_1.angles = axistoangles(var_26 * -1, var_28 * -1, var_27);
    var_1._id_1150A = var_48;
    var_1._id_57F4 = var_47;
    var_17 = var_5;
    var_21 = var_21 - 0.05;
    var_14 = var_14 - 0.05;
  }
}

_id_5BE2(var_0) {
  earthquake(0.25, 0.8, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_heavy");
  level.player playSound("landing_drone_attach");
  self._id_102D1 stoploopsound("landing_drone_sled_lp");
  self._id_102D1._id_5BD7 setanimknob(%landing_drone_fly_docked, 1, 0.2);
  self._id_102D1._id_5BD7 _id_0BDC::_id_413B();

  if(!isDefined(var_0)) {
    self._id_102D1._id_5BD7 setviewmodeldepth(1);
    _id_0BDC::_id_D165(self._id_6C1E, 1.0, 0, 0.0);
    _id_0BDC::_id_D16C(self._id_102D1._id_20F1, 0.0, 0, 0.0);
  } else {
    self._id_102D1._id_5BD7 _meth_8291(0.1, 0.1, 0.1, 0.5);
    self._id_102D1._id_5BD7 linkTo(level._id_D127, "tag_body", (325.491, 0, 14.494), (0, -180, 0));
  }
}

_id_5CA1(var_0) {
  var_1 = getanimlength(%weapon_drone_arms_docked);
  thread _id_67ED(var_1, var_0);
  thread _id_6817(var_1, var_0);
  thread _id_9319(var_1, 0);
  thread _id_687C(var_1);
  wait(var_1);
}

_id_112AA(var_0, var_1, var_2) {
  thread _id_E095(var_1, var_0);
  thread _id_5CEF(var_2);
  thread _id_9319(var_2, 1);
  thread _id_68A0(var_0);
}

_id_A7D4(var_0, var_1) {
  thread _id_685E();
  self._id_102D1._id_5BD7 thread _id_E04D(var_1, var_0, "notify_restart_landing progress");
}

_id_5CEF(var_0) {
  wait(var_0);
  _id_0BDC::_id_A153();
}

_id_9319(var_0, var_1) {
  wait(var_0);
  level._id_D127.ignoreme = var_1;
}

_id_68A0(var_0, var_1) {
  if(isDefined(var_1))
    level endon(var_1);

  wait(var_0);
  earthquake(0.3, 0.8, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_heavy");
  level.player playSound("drone_attach");
  self setanimknob(%weapon_drone_fly_docked, 1, 0);
}

_id_685E() {
  var_0 = spawn("script_origin", self._id_102D1.origin);
  var_0 linkTo(self._id_102D1._id_5BD7);
  var_0 playSound("landing_drone_launch", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_685F(var_0) {
  self setanimknob(%landing_drone_recovery);
  wait(var_0);
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.12, 0.35, level._id_D127.origin, 5000);
}

_id_67ED(var_0, var_1) {
  wait 1.23;
  earthquake(0.2, 0.65, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
  var_1 playSound("drone_grab_missiles");
}

_id_6817(var_0, var_1) {
  wait 2.53;
  earthquake(0.26, 0.6, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_heavy");
  wait 3;
  _id_0BDC::_id_A161(0);
  _id_0BDC::_id_A153(0);
}

_id_687C(var_0) {
  wait 4.3;
  level._id_D127 _id_0BDD::_id_A2D5();
  scripts\engine\utility::delaythread(0.1, _id_0BDC::_id_A112, "jackal_hud_missileready");
  level._id_D127 playSound("jackal_missiles_active");
}

_id_6815() {
  earthquake(0.2, 0.6, level._id_D127.origin, 50000);
  level.player playRumbleOnEntity("damage_light");
  _id_5C91();
  _id_5C8D();
}

_id_680F(var_0) {
  wait(var_0);
  earthquake(0.3, 0.7, level._id_D127.origin, 3000);
  level.player playRumbleOnEntity("grenade_rumble");
  _id_5C8F();
  _id_5C90();
}

_id_685D() {
  earthquake(0.25, 0.7, level._id_D127.origin, 3000);
  level.player playSound("jackal_landed");
  level.player playSound("landing_drone_stop");
  level.player playRumbleOnEntity("grenade_rumble");
  _id_5C8E();
  scripts\sp\utility::_id_75A0("landing_drone_light_top", "j_mainroot");
  scripts\sp\utility::_id_75C4("landing_drone_light_top_off", "j_mainroot");
}

_id_E095(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  wait(var_0);
  var_3 = var_1 - var_0;
  self _meth_82A2(%weapon_drone_fly_init, 0, var_3);
  self _meth_82A2(%weapon_drone_fly_static, 1, var_3);
  var_4 = self islegacyagent(%weapon_drone_fly_init);
  self _meth_82B0(%weapon_drone_fly_static, var_4);
}

_id_E04D(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  wait(var_0);
  var_3 = var_1 - var_0;
  self _meth_82A2(%landing_drone_fly_init, 0, var_3);
  self _meth_82A2(%landing_drone_fly_static, 1, var_3, 1);
  var_4 = self islegacyagent(%landing_drone_fly_init);
  self _meth_82B0(%landing_drone_fly_static, var_4);
}

_id_5C4D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1[0] + (var_0[0] - var_1[0]) * var_2;
  var_6 = var_1[1] + (var_0[1] - var_1[1]) * var_2;
  var_7 = _id_1EC0(var_5);
  var_8 = _id_1EC0(var_6);
  self _meth_82A2(var_3[0], var_7[1] * var_4, 0.05);
  self _meth_82A2(var_3[1], var_7[0] * var_4, 0.05);
  self _meth_82A2(var_3[2], var_8[1] * var_4, 0.05);
  self _meth_82A2(var_3[3], var_8[0] * var_4, 0.05);
  return [var_5, var_6];
}

_id_1EC0(var_0) {
  if(var_0 > 0) {
    var_1 = 0;
    var_2 = var_0;
  } else {
    var_1 = abs(var_0);
    var_2 = 0;
  }

  return [var_1, var_2];
}

_id_DC65() {
  var_0 = 1.5;
  var_1 = 0;

  while(var_1 < var_0) {
    self._id_B3D6 = var_1 / var_0;
    var_1 = var_1 + 0.05;
    wait 0.05;
  }

  self._id_B3D6 = 1;
}

_id_EBA2(var_0, var_1) {
  thread _id_EBA3(var_0, var_1);
}

_id_EBA3(var_0, var_1) {
  self endon("death");
  self _meth_8278(0, var_1);
  wait(var_1);
  self stoploopsound(var_0);
}

_id_5C8F() {
  self._id_FB5C _meth_8278(0, 0.0);
  self._id_FB5C playLoopSound("landing_drone_counterthrust2");
  self._id_FB5C _meth_8278(1, 0.2);
  self playSound("landing_drone_counterthrust2_init");
  scripts\sp\utility::_id_75C4("weapon_drone_counterthrust", "TAG_THRUST_8_RI");
  scripts\sp\utility::_id_75C4("weapon_drone_counterthrust", "TAG_THRUST_6_LE");
}

_id_5C8E() {
  playworldsound("landing_drone_counterthrust2_out", self.origin);
  self._id_FB5C _id_EBA3("landing_drone_counterthrust2", 0.3);
  scripts\sp\utility::_id_75C4("weapon_drone_counterthrust_exhaust", "TAG_THRUST_8_RI");
  scripts\sp\utility::_id_75C4("weapon_drone_counterthrust_exhaust", "TAG_THRUST_6_LE");
  scripts\sp\utility::_id_75A0("weapon_drone_counterthrust", "TAG_THRUST_8_RI");
  scripts\sp\utility::_id_75A0("weapon_drone_counterthrust", "TAG_THRUST_6_LE");
}

_id_5C91() {
  self._id_FB5B playLoopSound("landing_drone_counterthrust");
  self._id_FB5B _meth_8278(1, 0.3);
  self playSound("landing_drone_counterthrust_init");
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_small", "TAG_THRUST_7_RI");
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_small", "TAG_THRUST_8_LE");
}

_id_5C90() {
  self._id_FB5B _id_EBA2("landing_drone_counterthrust", 0.3);
  scripts\sp\utility::_id_75F8("weapon_drone_thrust_small", "TAG_THRUST_7_RI");
  scripts\sp\utility::_id_75F8("weapon_drone_thrust_small", "TAG_THRUST_8_LE");
}

_id_5C96() {
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_med", "tag_thrust_4_LE");
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_med", "tag_thrust_4_RI");
}

_id_5C95() {
  scripts\sp\utility::_id_75F8("weapon_drone_thrust_med", "tag_thrust_4_LE");
  scripts\sp\utility::_id_75F8("weapon_drone_thrust_med", "tag_thrust_4_RI");
}

_id_5C87() {
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_RI");
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_LE");
  wait 0.5;
  self._id_FC28 _meth_8278(0, 0.0);
  self._id_FC28 playSound("drone_engine_c");
  self._id_FC28 _meth_8278(1, 0.2);
}

_id_5C3E() {
  self._id_FC28 _meth_8278(0, 0.0);
  self._id_FC28 playSound("drone_engine_c");
  self._id_FC28 _meth_8278(1, 0.2);
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_RI");
  scripts\sp\utility::_id_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_LE");
}

_id_5C8D() {
  self._id_FC28 _id_EBA2("drone_engine_c", 0.2);
  scripts\sp\utility::_id_75A0("weapon_drone_thrust_big", "TAG_THRUST_2_RI");
  scripts\sp\utility::_id_75A0("weapon_drone_thrust_big", "TAG_THRUST_2_LE");
}

_id_13C0C() {
  level endon("kill_old_drone");
  self _meth_82A2(%weapon_drone_fly_move_f, 1, 0, 0);
  self _meth_82A2(%drone_move_f_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_move_b, 1, 0, 0);
  self _meth_82A2(%drone_move_b_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_move_l, 1, 0, 0);
  self _meth_82A2(%drone_move_l_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_move_r, 1, 0, 0);
  self _meth_82A2(%drone_move_r_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_acc_f, 1, 0, 0);
  self _meth_82A2(%drone_acc_f_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_acc_b, 1, 0, 0);
  self _meth_82A2(%drone_acc_b_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_acc_l, 1, 0, 0);
  self _meth_82A2(%drone_acc_l_overlay, 0, 0);
  self _meth_82A2(%weapon_drone_fly_acc_r, 1, 0, 0);
  self _meth_82A2(%drone_acc_r_overlay, 0, 0);
  self _meth_82AE(%weapon_drone_fly_init, 1, 0, 0);
  self _meth_82AE(%weapon_drone_fly_static, 0, 0, 0);
}

_id_A7D5() {
  self _meth_82A2(%landing_drone_fly_move_f, 1, 0, 0);
  self _meth_82A2(%drone_move_f_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_move_b, 1, 0, 0);
  self _meth_82A2(%drone_move_b_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_move_l, 1, 0, 0);
  self _meth_82A2(%drone_move_l_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_move_r, 1, 0, 0);
  self _meth_82A2(%drone_move_r_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_acc_f, 1, 0, 0);
  self _meth_82A2(%drone_acc_f_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_acc_b, 1, 0, 0);
  self _meth_82A2(%drone_acc_b_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_acc_l, 1, 0, 0);
  self _meth_82A2(%drone_acc_l_overlay, 0, 0);
  self _meth_82A2(%landing_drone_fly_acc_r, 1, 0, 0);
  self _meth_82A2(%drone_acc_r_overlay, 0, 0);
  self _meth_82AE(%landing_drone_fly_init, 1, 0, 0);
  self _meth_82AE(%landing_drone_fly_static, 0, 0, 0);
  self _meth_82AE(%landing_drone_fly_fail, 0, 0, 0);
  self _meth_82A2(%landing_drone_fail_overlay, 0, 0, 0);
}

_id_B7EC(var_0) {
  var_0 _id_0BDC::_id_A387();
  var_0 delete();
}

_id_B7F1() {
  wait 2;
  scripts\engine\utility::flag_set("jackal_missile_hint");
  scripts\sp\utility::_id_56BA("jackal_missile");
  level._id_D127 waittill("missile_fired", var_0);
  scripts\engine\utility::flag_clear("jackal_missile_hint");
  scripts\engine\utility::flag_clear("jackal_missile_hint");
}

_id_B7F3() {
  level endon("player_failed_tutorial");
  var_0 = 3;
  scripts\engine\utility::flag_set("jackal_missile_tutorial");
  scripts\engine\utility::flag_set("jackal_missile_hint");
  thread _id_B7F0();

  for(;;) {
    level._id_D127 waittill("missile_fired", var_1);

    if(var_1) {
      level notify("player_shot_locked_missile");
      scripts\engine\utility::flag_clear("jackal_missile_tutorial");
      scripts\engine\utility::flag_clear("jackal_missile_hint");
      break;
    } else if(scripts\engine\utility::flag("jackal_missile_hint")) {
      var_0--;

      if(var_0 <= 0) {
        level notify("player_shot_locked_missile");
        scripts\engine\utility::flag_clear("jackal_missile_tutorial");
        scripts\engine\utility::flag_clear("jackal_missile_hint");
        break;
      }

      thread _id_B7FC();
    }
  }
}

_id_B7F0() {
  level._id_D127 endon("missile_fired");
  wait 2;
  scripts\sp\utility::_id_56BA("jackal_missile");
}

_id_B7FC() {
  level endon("player_shot_locked_missile");
  scripts\engine\utility::flag_clear("jackal_missile_hint");
  wait 2;
  scripts\engine\utility::flag_set("jackal_missile_hint");
  scripts\sp\utility::_id_56BA("jackal_missile");
}

_id_B7F2() {
  level endon("player_shot_locked_missile");
  thread _id_B7F3();
  wait 2.5;
  var_0 = -9999999;

  while(level._id_D127.missiles.count > 0) {
    var_1 = level.player _meth_848A();
    var_2 = gettime();

    if(isDefined(var_1) && isDefined(var_1[0]) && var_1[1] == 0 && !scripts\engine\utility::flag("jackal_missile_hint") && !scripts\engine\utility::flag("jackal_find_lockon")) {
      if(var_2 - var_0 > 1000.0) {
        scripts\engine\utility::flag_set("jackal_ads_hint");
        scripts\sp\utility::_id_56BA("jackal_ads");
      }
    } else if(scripts\engine\utility::flag("jackal_ads_hint")) {
      var_0 = var_2;
      scripts\engine\utility::flag_clear("jackal_ads_hint");
      wait 0.05;
    }

    if(isDefined(var_1) && isDefined(var_1[0]) && var_1[1] == 1 && !scripts\engine\utility::flag("jackal_ads_hint") && !scripts\engine\utility::flag("jackal_find_lockon")) {
      scripts\engine\utility::flag_set("jackal_missile_hint");
      scripts\sp\utility::_id_56BA("jackal_missile");
    } else if(scripts\engine\utility::flag("jackal_missile_hint")) {
      var_0 = var_2;
      scripts\engine\utility::flag_clear("jackal_missile_hint");
      wait 0.05;
    }

    if(!isDefined(var_1) || !isDefined(var_1[0]) && !scripts\engine\utility::flag("jackal_ads_hint") && !scripts\engine\utility::flag("jackal_missile_hint")) {
      if(var_2 - var_0 > 3000.0) {
        scripts\engine\utility::flag_set("jackal_find_lockon");
        scripts\sp\utility::_id_56BA("jackal_find_lockon");
      }
    } else if(scripts\engine\utility::flag("jackal_find_lockon")) {
      var_0 = var_2;
      scripts\engine\utility::flag_clear("jackal_find_lockon");
      wait 0.05;
    }

    wait 0.05;
  }

  level notify("player_failed_tutorial");
}

#using_animtree("script_model");

_id_5C40(var_0) {
  self._id_102D1._id_5BD7 thread _id_5C9F(var_0);

  if(isDefined(self._id_5C6B)) {
    self playSound("landing_drone_detach");
    var_1 = getnotetracktimes(%machinery_landing_drone_recovery, "attach_drone");
    var_1 = var_1[0] * getanimlength(%machinery_landing_drone_recovery);
    self._id_102D1._id_5BD7 thread _id_685F(var_1);
    self._id_5C6B _meth_82B1(%machinery_landing_drone_recovery, 1.0);
    wait(var_1);
    self._id_102D1._id_5BD7 linkTo(self._id_5C6B, "j_arm_L");
  } else {
    wait 1.1;
    self._id_102D1._id_5BD7 linkTo(self);
  }

  wait 1;
}

_id_5C9F(var_0) {
  wait 1;
  var_1 = level._id_D127 gettagorigin("tag_body");
  var_2 = level._id_D127 gettagangles("tag_body");
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2);
  self.origin = var_1 + var_3 * (325.491, 0, 14.494)[0] + var_4 * (325.491, 0, 14.494)[1] + var_5 * (325.491, 0, 14.494)[2];
  self.angles = axistoangles(var_3 * -1, var_4 * -1, var_5);
  wait 0.1;
  self setviewmodeldepth(0);

  if(!isDefined(var_0))
    _id_0BDC::_id_A387();
  else
    self unlink();

  scripts\engine\utility::flag_set("jackal_landing_drone_detached");
}