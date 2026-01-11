/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3030.gsc
***************************************/

func_621A() {
  if(!func_0BDC::func_A1AC("missile_drone")) {
    func_0BDC::func_A1AA("missile_drone", ::func_B7ED, ::func_B7EF, ::func_B7EE);
  }
}

disable_missile_drone_event() {
  if(func_0BDC::func_A1AC("missile_drone")) {
    func_0BDC::func_A1AD("missile_drone");
  }

  if(scripts\engine\utility::flag("jackal_supply_drop_hint")) {
    scripts\engine\utility::flag_clear("jackal_supply_drop_hint");
  }

  if(scripts\engine\utility::flag("jackal_missile_drone_primed")) {
    scripts\engine\utility::flag_clear("jackal_missile_drone_primed");
  }

  level notify("disable_missiledrone");
}

func_B7ED(var_00) {
  if(level.func_D127.missiles.count > 0) {
    return 0;
  }

  if(scripts\engine\utility::flag("jackal_missile_drone_primed")) {
    return 0;
  }

  var_01 = 7;

  if(gettime() - level.func_D127.missiles.func_A8E8 < var_01 * 1000) {
    return 0;
  }

  if(scripts\engine\utility::flag("jackal_runway_landing_active")) {
    return 0;
  }

  return 1;
}

func_B7EF(var_00) {
  thread missile_drone_event_threaded();
}

missile_drone_event_threaded() {
  scripts\engine\utility::flag_set("jackal_missile_drone_primed");
  func_B35F();

  if(func_0BDC::func_A1AC("missile_drone")) {
    scripts\engine\utility::flag_set("jackal_missile_drone_active");
    func_0BDC::func_A14A();
    func_0BDC::func_A14E();
    func_0BDC::func_A149();
    thread func_13C10();
    level.func_D127 waittill("missiles_restocked");
    level.func_A056.func_A9BD = gettime();
    func_0BDC::func_A14A(0);
    func_0BDC::func_A14E(0);
    func_0BDC::func_A149(0);
    scripts\engine\utility::flag_clear("jackal_missile_drone_active");
  }

  scripts\engine\utility::flag_clear("jackal_missile_drone_primed");
}

func_B7EE(var_00) {}

func_B35F() {
  level endon("disable_missiledrone");
  scripts\engine\utility::flag_set("jackal_supply_drop_hint");

  if(isDefined(level.func_B833)) {
    thread scripts\sp\utility::func_56BA("jackal_supply_drop");
  }
  else {
    thread scripts\sp\utility::func_56BE("jackal_supply_drop", 4);
  }

  func_0BDC::func_A112("jackal_hud_missile_supply_available", 20);
  level.player notifyonplayercommand("callin_supply_drone", "+actionslot 2");
  level.player waittill("callin_supply_drone");
  scripts\engine\utility::flag_clear("jackal_supply_drop_hint");
  level.func_D127 notify("drone_dropzone_marked");
}

func_13C10() {
  if(!isDefined(level.func_D127)) {
    return;
  }
  func_0BDC::func_A162();
  func_0BDC::func_A161();
  scripts\engine\utility::delaythread(0.2, func_0BDC::func_A112, "jackal_hud_supplydroneinbo", 2);
  var_00 = (1500, 0, 200);
  var_01 = func_107E5();
  thread func_5D07(var_00, var_01);
  var_01 waittill("deployed");
  func_5BFD(var_00, var_01);
  func_5CA1(var_01);
  func_B7EC(var_01);
  func_0BDC::func_A162(0);
}

#using_animtree("vehicles");

func_107E5() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("veh_mil_air_un_support_drone");
  var_00 hide();
  var_00 glinton(#animtree);
  var_00 func_13C0C();
  return var_00;
}

func_10753() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("veh_mil_air_un_landing_drone");
  var_00 glinton(#animtree);
  var_00 func_A7D5();
  playFXOnTag(scripts\engine\utility::getfx("landing_drone_light_top"), var_00, "j_mainroot");
  return var_00;
}

func_106AC(var_00) {
  var_01 = spawn("script_model", var_00);
  var_01 setModel("veh_mil_air_un_support_drone_pod");
  var_01 playSound("drone_pod_incoming");
  var_01 func_0BDC::func_F2FF();
  var_01 notsolid();
  return var_01;
}

func_5D07(var_00, var_01) {
  level endon("stop_drop_pod_logic");
  var_02 = 3.5;
  var_03 = (4000, 2000, 35000);
  var_04 = level.player _meth_8473();
  var_05 = (0, var_4.angles[1], 0);
  var_06 = anglesToForward(var_05);
  var_07 = anglestoright(var_05);
  var_08 = (0, 0, 1);
  var_09 = var_06 * var_3[0] + var_06 * var_3[1] + var_08 * var_3[2];
  var_10 = func_106AC(var_4.origin + var_09);
  var_01 linkto(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("weapon_drone_pod_trail"), var_10, "tag_origin");
  var_11 = 0;
  thread func_5D04(var_02);
  var_12 = var_02;

  while(isDefined(var_10)) {
    var_04 = level.player _meth_8473();
    var_13 = scripts\sp\math::func_C097(0, var_02, var_12);
    var_06 = anglesToForward(var_4.angles);
    var_07 = anglesToForward(var_4.angles);
    var_08 = anglesToForward(var_4.angles);
    var_09 = var_03;
    var_14 = var_06 * var_0[0] + var_07 * var_0[1] + var_08 * var_0[2];
    var_15 = scripts\sp\math::func_6A8E(var_14, var_09, var_13);
    var_10.origin = var_4.origin + var_15;
    var_12 = var_12 - 0.05;

    if(var_12 < 0 && !var_11) {
      _playworldsound("drone_pod_open", var_10.origin);
      playFXOnTag(scripts\engine\utility::getfx("weapon_drone_pod_open"), var_10, "tag_origin");
      earthquake(0.15, 0.6, level.func_D127.origin, 5000);
      var_10 hide();
      var_10 thread func_5D02();
      var_01 notify("deployed");
      var_11 = 1;
    }

    level.player waittill("on_player_update");
  }
}

func_5D02() {
  wait 0.2;
  stopFXOnTag(scripts\engine\utility::getfx("weapon_drone_pod_trail"), self, "tag_origin");
  wait 2;
  level notify("stop_drop_pod_logic");
  self delete();
}

func_5D04(var_00) {
  var_01 = (450, 0, 50);

  for(var_02 = undefined; var_00 > 0; var_00 = var_00 - 0.05) {
    var_03 = level.player _meth_8473();
    var_04 = var_1[0];
    var_05 = var_1[2];
    var_06 = anglesToForward(var_3.angles);
    var_07 = anglestoup(var_3.angles);
    var_08 = anglestoright(var_3.angles);

    if(!isDefined(var_02)) {
      var_02 = scripts\engine\utility::spawn_tag_origin(var_3.origin + var_06 * var_04 + var_07 * var_05);
      var_02 thread func_10CA7(var_00);
      var_02 thread func_13C0F();
      var_02 func_0BDC::func_F2FF();
    }

    var_2.origin = var_3.origin + var_06 * var_04 + var_07 * var_05;
    var_2.angles = _axistoangles(var_06 * -1, var_08 * -1, var_07);
    level.player waittill("on_player_update");
  }

  var_02 delete();
}

func_10CA7(var_00) {
  func_0BDC::func_105DB("missile", undefined, "droppod_marker", undefined, 0, undefined, 1);
  wait 0.05;
  wait(var_00 - 0.1);
  func_0BDC::func_105DA();
}

func_13C0F() {
  self endon("entitydeleted");

  for(;;) {
    self playSound("drone_marker_timer");
    wait 1.1;
  }
}

func_5BFD(var_00, var_01) {
  var_02 = level.player _meth_8473();
  var_01 unlink();
  var_01 func_0BDC::func_F2FF();
  var_01 _meth_82B1( % weapon_drone_fly_init, 1);
  var_1.func_FC28 = scripts\engine\utility::spawn_tag_origin();
  var_1.func_FC28 func_0BDC::func_F2FF();
  var_01 thread func_5C87();
  var_01 scripts\sp\utility::func_75C4("landing_drone_light_top_blink", "j_mainroot");
  var_03 = 0;
  var_04 = (0, 0, 0);
  var_05 = [0, 0];
  var_06 = [0, 0];
  var_07 = 2500;
  var_08 = 375;
  var_09 = [ % drone_move_f_overlay, % drone_move_b_overlay, % drone_move_l_overlay, % drone_move_r_overlay];
  var_10 = [ % drone_acc_f_overlay, % drone_acc_b_overlay, % drone_acc_l_overlay, % drone_acc_r_overlay];
  var_11 = 4.4;
  var_12 = 1.5;
  var_13 = 3.0;
  var_14 = 0.5;
  var_15 = undefined;
  var_01 thread func_112AA(var_11, var_12, var_14);
  var_01 func_0BDC::func_A25B(var_11, "j_mainroot_ship", (325.491, 0, 14.494), (0, 180, 0));
  var_16 = (0, 0, 0);

  while(var_11 > 0) {
    level.player waittill("on_player_update");

    if(var_03) {
      var_01 show();
    }

    var_03 = 1;
    var_02 = level.player _meth_8473();

    if(!isDefined(var_02)) {
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
    var_29 = scripts\sp\math::func_C097(var_25, var_27, var_24);
    var_30 = scripts\sp\math::func_6A8E(var_26, var_28, var_29);
    var_04 = var_04 - rotatevectorinverted(var_2.spaceship_vel, var_2.angles) * var_19;
    var_31 = var_2.spaceship_rotvel * 0.05;
    var_32 = rotatevectorinverted(var_1.origin - var_2.origin, var_2.angles);
    var_33 = rotatevector(var_32, var_31);
    var_34 = var_33 - var_32;
    var_04 = var_04 - var_34;

    if(var_13 > 0) {
      var_35 = 1;
    }
    else {
      if(!isDefined(var_15)) {
        var_15 = var_11;
      }

      var_35 = scripts\sp\math::func_C097(0, var_15, var_11);
      var_35 = scripts\sp\math::func_C09B(var_35);
    }

    var_36 = var_04 - var_16;
    var_37 = scripts\sp\math::func_C097(0, var_07, length(var_04));
    var_38 = scripts\sp\math::func_C097(0, var_08, length(var_36));
    var_39 = vectornormalize(var_04) * var_37;
    var_40 = vectornormalize(var_36) * var_38;
    var_05 = var_01 func_5C4D(var_39, var_05, 1, var_09, var_35);
    var_06 = var_01 func_5C4D(var_40, var_06, 1, var_10, var_35);
    var_04 = var_04 * (1 - var_30);
    var_41 = rotatevector(var_04, var_2.angles);
    var_1.origin = var_23 + var_41;
    var_1.func_FC28.origin = var_23 + var_41;
    var_1.angles = _axistoangles(var_20 * -1, var_22 * -1, var_21);
    var_16 = var_04;
    var_11 = var_11 - 0.05;
    var_13 = var_13 - 0.05;
  }

  var_01 scripts\sp\utility::func_75A0("landing_drone_light_top_blink", "j_mainroot");
  var_01 scripts\sp\utility::func_75C4("landing_drone_light_top", "j_mainroot");
  var_1.func_FC28 delete();
}

func_5BFC(var_00) {
  var_01 = self.func_102D1.func_5BD7;
  var_01 endon("notify_drone_reset");
  var_1.active = 1;

  if(!isDefined(var_00)) {
    var_02 = level.player _meth_8473();
  }
  else {
    var_02 = level.func_D127;
  }

  var_01 unlink();
  var_01 func_0BDC::func_F2FF();
  var_01 _meth_82B1( % landing_drone_fly_init, 1);
  var_01 thread func_5C3E();
  var_01 thread func_5C95();
  var_03 = var_1.origin - var_2.origin;
  var_03 = rotatevectorinverted(var_03, var_2.angles);
  var_04 = 0;
  var_05 = (0, 0, 0);
  var_06 = [0, 0];
  var_07 = [0, 0];
  var_08 = 2500;
  var_09 = 375;
  var_10 = [ % drone_move_f_overlay, % drone_move_b_overlay, % drone_move_l_overlay, % drone_move_r_overlay];
  var_11 = [ % drone_acc_f_overlay, % drone_acc_b_overlay, % drone_acc_l_overlay, % drone_acc_r_overlay];

  if(!isDefined(var_00)) {
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

  thread func_A7D4(var_12, var_13);
  var_16 = (340, 0, 40);
  var_17 = (0, 0, 0);
  var_18 = 0;
  var_19 = 0;
  var_20 = 0.05;
  var_21 = var_12;
  var_01 func_0BDC::func_A25B(var_12, "tag_body", (325.491, 0, 14.494), (0, 180, 0), var_00);

  for(;;) {
    if(var_21 <= 0) {
      break;
    }
    level.player waittill("on_player_update");

    if(!isDefined(var_00)) {
      var_02 = level.player _meth_8473();
    }
    else {
      var_02 = level.func_D127;
    }

    if(!isDefined(var_02)) {
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
    var_36 = scripts\sp\math::func_C097(var_32, var_34, var_30);
    var_37 = scripts\sp\math::func_6A8E(var_33, var_35, var_36);

    if(!isDefined(var_00)) {
      var_05 = var_05 - rotatevectorinverted(var_2.spaceship_vel, var_2.angles) * var_25;
    }
    else {
      var_05 = var_05 - rotatevectorinverted(var_2.angles * 100, var_2.angles) * var_25;
    }

    var_38 = var_2.spaceship_rotvel * 0.05;
    var_39 = rotatevectorinverted(var_1.origin - var_2.origin, var_2.angles);
    var_40 = rotatevector(var_39, var_38);
    var_41 = var_40 - var_39;
    var_05 = var_05 - var_41;

    if(var_14 > 0) {
      var_19 = var_19 + var_20;
      var_19 = clamp(var_19, 0, 1);
    } else {
      if(!isDefined(var_15)) {
        var_15 = var_21;
      }

      var_19 = scripts\sp\math::func_C097(0, var_15, var_21);
      var_19 = scripts\sp\math::func_C09B(var_19);
    }

    var_42 = var_05 - var_17;
    var_43 = scripts\sp\math::func_C097(0, var_08, length(var_05));
    var_44 = scripts\sp\math::func_C097(0, var_09, length(var_42));
    var_45 = vectornormalize(var_05) * var_43;
    var_46 = vectornormalize(var_42) * var_44;
    var_06 = var_01 func_5C4D(var_45, var_06, 1, var_10, var_19);
    var_07 = var_01 func_5C4D(var_46, var_07, 1, var_11, var_19);
    var_47 = scripts\sp\math::func_C097(0, var_12, var_21);
    var_48 = scripts\sp\math::func_6A8E(var_31, var_29, var_47);
    var_49 = var_29;
    var_05 = var_05 * (1 - var_37);
    var_50 = rotatevector(var_05, var_2.angles);
    var_50 = var_50 * var_47;
    var_1.origin = var_48 + var_50;
    var_1.angles = _axistoangles(var_26 * -1, var_28 * -1, var_27);
    var_1.func_1150A = var_48;
    var_1.func_57F4 = var_47;
    var_17 = var_05;
    var_21 = var_21 - 0.05;
    var_14 = var_14 - 0.05;
  }
}

func_5BE2(var_00) {
  earthquake(0.25, 0.8, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_heavy");
  level.player playSound("landing_drone_attach");
  self.func_102D1 stoploopsound("landing_drone_sled_lp");
  self.func_102D1.func_5BD7 setanimknob( % landing_drone_fly_docked, 1, 0.2);
  self.func_102D1.func_5BD7 func_0BDC::func_413B();

  if(!isDefined(var_00)) {
    self.func_102D1.func_5BD7 givegrabscore(1);
    func_0BDC::func_D165(self.func_6C1E, 1.0, 0, 0.0);
    func_0BDC::func_D16C(self.func_102D1.func_20F1, 0.0, 0, 0.0);
  } else {
    self.func_102D1.func_5BD7 _meth_8291(0.1, 0.1, 0.1, 0.5);
    self.func_102D1.func_5BD7 linkto(level.func_D127, "tag_body", (325.491, 0, 14.494), (0, -180, 0));
  }
}

func_5CA1(var_00) {
  var_01 = getanimlength( % weapon_drone_arms_docked);
  thread func_67ED(var_01, var_00);
  thread func_6817(var_01, var_00);
  thread func_9319(var_01, 0);
  thread func_687C(var_01);
  wait(var_01);
}

func_112AA(var_00, var_01, var_02) {
  thread func_E095(var_01, var_00);
  thread func_5CEF(var_02);
  thread func_9319(var_02, 1);
  thread func_68A0(var_00);
}

func_A7D4(var_00, var_01) {
  thread func_685E();
  self.func_102D1.func_5BD7 thread func_E04D(var_01, var_00, "notify_restart_landing progress");
}

func_5CEF(var_00) {
  wait(var_00);
  func_0BDC::func_A153();
}

func_9319(var_00, var_01) {
  wait(var_00);
  level.func_D127.ignoreme = var_01;
}

func_68A0(var_00, var_01) {
  if(isDefined(var_01)) {
    level endon(var_01);
  }

  wait(var_00);
  earthquake(0.3, 0.8, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_heavy");
  level.player playSound("drone_attach");
  self setanimknob( % weapon_drone_fly_docked, 1, 0);
}

func_685E() {
  var_00 = spawn("script_origin", self.func_102D1.origin);
  var_00 linkto(self.func_102D1.func_5BD7);
  var_00 playSound("landing_drone_launch", "sounddone");
  var_00 waittill("sounddone");
  var_00 delete();
}

func_685F(var_00) {
  self setanimknob( % landing_drone_recovery);
  wait(var_00);
  level.player playrumbleonentity("damage_light");
  earthquake(0.12, 0.35, level.func_D127.origin, 5000);
}

func_67ED(var_00, var_01) {
  wait 1.23;
  earthquake(0.2, 0.65, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_light");
  var_01 playSound("drone_grab_missiles");
}

func_6817(var_00, var_01) {
  wait 2.53;
  earthquake(0.26, 0.6, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_heavy");
  wait 3;
  func_0BDC::func_A161(0);
  func_0BDC::func_A153(0);
}

func_687C(var_00) {
  wait 4.3;
  level.func_D127 func_0BDD::func_A2D5();
  scripts\engine\utility::delaythread(0.1, func_0BDC::func_A112, "jackal_hud_missileready");
  level.func_D127 playSound("jackal_missiles_active");
}

func_6815() {
  earthquake(0.2, 0.6, level.func_D127.origin, 50000);
  level.player playrumbleonentity("damage_light");
  func_5C91();
  func_5C8D();
}

func_680F(var_00) {
  wait(var_00);
  earthquake(0.3, 0.7, level.func_D127.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  func_5C8F();
  func_5C90();
}

func_685D() {
  earthquake(0.25, 0.7, level.func_D127.origin, 3000);
  level.player playSound("jackal_landed");
  level.player playSound("landing_drone_stop");
  level.player playrumbleonentity("grenade_rumble");
  func_5C8E();
  scripts\sp\utility::func_75A0("landing_drone_light_top", "j_mainroot");
  scripts\sp\utility::func_75C4("landing_drone_light_top_off", "j_mainroot");
}

func_E095(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    level endon(var_02);
  }

  wait(var_00);
  var_03 = var_01 - var_00;
  self give_attacker_kill_rewards( % weapon_drone_fly_init, 0, var_03);
  self give_attacker_kill_rewards( % weapon_drone_fly_static, 1, var_03);
  var_04 = self islegacyagent( % weapon_drone_fly_init);
  self _meth_82B0( % weapon_drone_fly_static, var_04);
}

func_E04D(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    level endon(var_02);
  }

  wait(var_00);
  var_03 = var_01 - var_00;
  self give_attacker_kill_rewards( % landing_drone_fly_init, 0, var_03);
  self give_attacker_kill_rewards( % landing_drone_fly_static, 1, var_03, 1);
  var_04 = self islegacyagent( % landing_drone_fly_init);
  self _meth_82B0( % landing_drone_fly_static, var_04);
}

func_5C4D(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_1[0] + (var_0[0] - var_1[0]) * var_02;
  var_06 = var_1[1] + (var_0[1] - var_1[1]) * var_02;
  var_07 = func_1EC0(var_05);
  var_08 = func_1EC0(var_06);
  self give_attacker_kill_rewards(var_3[0], var_7[1] * var_04, 0.05);
  self give_attacker_kill_rewards(var_3[1], var_7[0] * var_04, 0.05);
  self give_attacker_kill_rewards(var_3[2], var_8[1] * var_04, 0.05);
  self give_attacker_kill_rewards(var_3[3], var_8[0] * var_04, 0.05);
  return [var_05, var_06];
}

func_1EC0(var_00) {
  if(var_00 > 0) {
    var_01 = 0;
    var_02 = var_00;
  } else {
    var_01 = abs(var_00);
    var_02 = 0;
  }

  return [var_01, var_02];
}

func_DC65() {
  var_00 = 1.5;
  var_01 = 0;

  while(var_01 < var_00) {
    self.func_B3D6 = var_01 / var_00;
    var_01 = var_01 + 0.05;
    wait 0.05;
  }

  self.func_B3D6 = 1;
}

func_EBA2(var_00, var_01) {
  thread func_EBA3(var_00, var_01);
}

func_EBA3(var_00, var_01) {
  self endon("death");
  self ghostattack(0, var_01);
  wait(var_01);
  self stoploopsound(var_00);
}

func_5C8F() {
  self.func_FB5C ghostattack(0, 0.0);
  self.func_FB5C playLoopSound("landing_drone_counterthrust2");
  self.func_FB5C ghostattack(1, 0.2);
  self playSound("landing_drone_counterthrust2_init");
  scripts\sp\utility::func_75C4("weapon_drone_counterthrust", "TAG_THRUST_8_RI");
  scripts\sp\utility::func_75C4("weapon_drone_counterthrust", "TAG_THRUST_6_LE");
}

func_5C8E() {
  _playworldsound("landing_drone_counterthrust2_out", self.origin);
  self.func_FB5C func_EBA3("landing_drone_counterthrust2", 0.3);
  scripts\sp\utility::func_75C4("weapon_drone_counterthrust_exhaust", "TAG_THRUST_8_RI");
  scripts\sp\utility::func_75C4("weapon_drone_counterthrust_exhaust", "TAG_THRUST_6_LE");
  scripts\sp\utility::func_75A0("weapon_drone_counterthrust", "TAG_THRUST_8_RI");
  scripts\sp\utility::func_75A0("weapon_drone_counterthrust", "TAG_THRUST_6_LE");
}

func_5C91() {
  self.func_FB5B playLoopSound("landing_drone_counterthrust");
  self.func_FB5B ghostattack(1, 0.3);
  self playSound("landing_drone_counterthrust_init");
  scripts\sp\utility::func_75C4("weapon_drone_thrust_small", "TAG_THRUST_7_RI");
  scripts\sp\utility::func_75C4("weapon_drone_thrust_small", "TAG_THRUST_8_LE");
}

func_5C90() {
  self.func_FB5B func_EBA2("landing_drone_counterthrust", 0.3);
  scripts\sp\utility::func_75F8("weapon_drone_thrust_small", "TAG_THRUST_7_RI");
  scripts\sp\utility::func_75F8("weapon_drone_thrust_small", "TAG_THRUST_8_LE");
}

func_5C96() {
  scripts\sp\utility::func_75C4("weapon_drone_thrust_med", "tag_thrust_4_LE");
  scripts\sp\utility::func_75C4("weapon_drone_thrust_med", "tag_thrust_4_RI");
}

func_5C95() {
  scripts\sp\utility::func_75F8("weapon_drone_thrust_med", "tag_thrust_4_LE");
  scripts\sp\utility::func_75F8("weapon_drone_thrust_med", "tag_thrust_4_RI");
}

func_5C87() {
  scripts\sp\utility::func_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_RI");
  scripts\sp\utility::func_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_LE");
  wait 0.5;
  self.func_FC28 ghostattack(0, 0.0);
  self.func_FC28 playSound("drone_engine_c");
  self.func_FC28 ghostattack(1, 0.2);
}

func_5C3E() {
  self.func_FC28 ghostattack(0, 0.0);
  self.func_FC28 playSound("drone_engine_c");
  self.func_FC28 ghostattack(1, 0.2);
  scripts\sp\utility::func_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_RI");
  scripts\sp\utility::func_75C4("weapon_drone_thrust_big", "TAG_THRUST_2_LE");
}

func_5C8D() {
  self.func_FC28 func_EBA2("drone_engine_c", 0.2);
  scripts\sp\utility::func_75A0("weapon_drone_thrust_big", "TAG_THRUST_2_RI");
  scripts\sp\utility::func_75A0("weapon_drone_thrust_big", "TAG_THRUST_2_LE");
}

func_13C0C() {
  level endon("kill_old_drone");
  self give_attacker_kill_rewards( % weapon_drone_fly_move_f, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_f_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_move_b, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_b_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_move_l, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_l_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_move_r, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_r_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_acc_f, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_f_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_acc_b, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_b_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_acc_l, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_l_overlay, 0, 0);
  self give_attacker_kill_rewards( % weapon_drone_fly_acc_r, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_r_overlay, 0, 0);
  self give_capture_credit( % weapon_drone_fly_init, 1, 0, 0);
  self give_capture_credit( % weapon_drone_fly_static, 0, 0, 0);
}

func_A7D5() {
  self give_attacker_kill_rewards( % landing_drone_fly_move_f, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_f_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_move_b, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_b_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_move_l, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_l_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_move_r, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_move_r_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_acc_f, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_f_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_acc_b, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_b_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_acc_l, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_l_overlay, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fly_acc_r, 1, 0, 0);
  self give_attacker_kill_rewards( % drone_acc_r_overlay, 0, 0);
  self give_capture_credit( % landing_drone_fly_init, 1, 0, 0);
  self give_capture_credit( % landing_drone_fly_static, 0, 0, 0);
  self give_capture_credit( % landing_drone_fly_fail, 0, 0, 0);
  self give_attacker_kill_rewards( % landing_drone_fail_overlay, 0, 0, 0);
}

func_B7EC(var_00) {
  var_00 func_0BDC::func_A387();
  var_00 delete();
}

func_B7F1() {
  wait 2;
  scripts\engine\utility::flag_set("jackal_missile_hint");
  scripts\sp\utility::func_56BA("jackal_missile");
  level.func_D127 waittill("missile_fired", var_00);
  scripts\engine\utility::flag_clear("jackal_missile_hint");
  scripts\engine\utility::flag_clear("jackal_missile_hint");
}

func_B7F3() {
  level endon("player_failed_tutorial");
  var_00 = 3;
  scripts\engine\utility::flag_set("jackal_missile_tutorial");
  scripts\engine\utility::flag_set("jackal_missile_hint");
  thread func_B7F0();

  for(;;) {
    level.func_D127 waittill("missile_fired", var_01);

    if(var_01) {
      level notify("player_shot_locked_missile");
      scripts\engine\utility::flag_clear("jackal_missile_tutorial");
      scripts\engine\utility::flag_clear("jackal_missile_hint");
      break;
    } else if(scripts\engine\utility::flag("jackal_missile_hint")) {
      var_0--;

      if(var_00 <= 0) {
        level notify("player_shot_locked_missile");
        scripts\engine\utility::flag_clear("jackal_missile_tutorial");
        scripts\engine\utility::flag_clear("jackal_missile_hint");
        break;
      }

      thread func_B7FC();
    }
  }
}

func_B7F0() {
  level.func_D127 endon("missile_fired");
  wait 2;
  scripts\sp\utility::func_56BA("jackal_missile");
}

func_B7FC() {
  level endon("player_shot_locked_missile");
  scripts\engine\utility::flag_clear("jackal_missile_hint");
  wait 2;
  scripts\engine\utility::flag_set("jackal_missile_hint");
  scripts\sp\utility::func_56BA("jackal_missile");
}

func_B7F2() {
  level endon("player_shot_locked_missile");
  thread func_B7F3();
  wait 2.5;
  var_00 = -9999999;

  while(level.func_D127.missiles.count > 0) {
    var_01 = level.player _meth_848A();
    var_02 = gettime();

    if(isDefined(var_01) && isDefined(var_1[0]) && var_1[1] == 0 && !scripts\engine\utility::flag("jackal_missile_hint") && !scripts\engine\utility::flag("jackal_find_lockon")) {
      if(var_02 - var_00 > 1000.0) {
        scripts\engine\utility::flag_set("jackal_ads_hint");
        scripts\sp\utility::func_56BA("jackal_ads");
      }
    } else if(scripts\engine\utility::flag("jackal_ads_hint")) {
      var_00 = var_02;
      scripts\engine\utility::flag_clear("jackal_ads_hint");
      wait 0.05;
    }

    if(isDefined(var_01) && isDefined(var_1[0]) && var_1[1] == 1 && !scripts\engine\utility::flag("jackal_ads_hint") && !scripts\engine\utility::flag("jackal_find_lockon")) {
      scripts\engine\utility::flag_set("jackal_missile_hint");
      scripts\sp\utility::func_56BA("jackal_missile");
    } else if(scripts\engine\utility::flag("jackal_missile_hint")) {
      var_00 = var_02;
      scripts\engine\utility::flag_clear("jackal_missile_hint");
      wait 0.05;
    }

    if(!isDefined(var_01) || !isDefined(var_1[0]) && !scripts\engine\utility::flag("jackal_ads_hint") && !scripts\engine\utility::flag("jackal_missile_hint")) {
      if(var_02 - var_00 > 3000.0) {
        scripts\engine\utility::flag_set("jackal_find_lockon");
        scripts\sp\utility::func_56BA("jackal_find_lockon");
      }
    } else if(scripts\engine\utility::flag("jackal_find_lockon")) {
      var_00 = var_02;
      scripts\engine\utility::flag_clear("jackal_find_lockon");
      wait 0.05;
    }

    wait 0.05;
  }

  level notify("player_failed_tutorial");
}

#using_animtree("script_model");

func_5C40(var_00) {
  self.func_102D1.func_5BD7 thread func_5C9F(var_00);

  if(isDefined(self.func_5C6B)) {
    self playSound("landing_drone_detach");
    var_01 = getnotetracktimes( % machinery_landing_drone_recovery, "attach_drone");
    var_01 = var_1[0] * getanimlength( % machinery_landing_drone_recovery);
    self.func_102D1.func_5BD7 thread func_685F(var_01);
    self.func_5C6B _meth_82B1( % machinery_landing_drone_recovery, 1.0);
    wait(var_01);
    self.func_102D1.func_5BD7 linkto(self.func_5C6B, "j_arm_L");
  } else {
    wait 1.1;
    self.func_102D1.func_5BD7 linkto(self);
  }

  wait 1;
}

func_5C9F(var_00) {
  wait 1;
  var_01 = level.func_D127 gettagorigin("tag_body");
  var_02 = level.func_D127 gettagangles("tag_body");
  var_03 = anglesToForward(var_02);
  var_04 = anglestoright(var_02);
  var_05 = anglestoup(var_02);
  self.origin = var_01 + var_03 * (325.491, 0, 14.494)[0] + var_04 * (325.491, 0, 14.494)[1] + var_05 * (325.491, 0, 14.494)[2];
  self.angles = _axistoangles(var_03 * -1, var_04 * -1, var_05);
  wait 0.1;
  self givegrabscore(0);

  if(!isDefined(var_00)) {
    func_0BDC::func_A387();
  }
  else {
    self unlink();
  }

  scripts\engine\utility::flag_set("jackal_landing_drone_detached");
}