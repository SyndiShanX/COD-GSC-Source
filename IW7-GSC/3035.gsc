/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3035.gsc
***************************************/

func_D18D() {
  level.player notifyonplayercommand("pulse_button", "+usereload");
  func_0BDC::func_137D6();
  thread func_D1F6();
}

func_D1F6() {
  self endon("player_exit_jackal");
  wait 0.05;
  var_00 = 0.1;
  var_01 = 1;
  var_02 = 5000;
  var_03 = 0;

  for(;;) {
    var_04 = level.func_D127.origin;
    var_05 = level.func_D127.angles;
    var_06 = scripts\engine\utility::getclosest(var_04, level.func_A056.func_1632);

    if(!isDefined(var_06)) {
      func_412F();
      wait 0.05;
      continue;
    }

    var_07 = var_6.origin;
    var_08 = length(var_04 - var_07);
    var_09 = var_4[2] - var_7[2];
    var_10 = vectordot(vectornormalize(var_6.origin - level.func_D127.origin), anglesToForward(level.func_D127.angles));

    if(self.spaceship_mode == "fly") {
      if(isDefined(var_6.func_EE10))
        var_11 = var_6.func_EE10;
      else
        var_11 = 8000;

      var_12 = 0.5;
      func_0BDC::func_A301(1, var_00, "land_speed");
    } else {
      var_13 = scripts\sp\math::func_C097(700, 4000, var_08);
      var_14 = scripts\sp\math::func_6A8E(0.25, 1, var_13);

      if(isDefined(var_6.func_EE10))
        var_11 = var_6.func_EE10;
      else
        var_11 = 2800;

      var_12 = -2;

      if(func_A7D7(var_06))
        func_0BDC::func_A301(var_14, var_00, "land_speed");
    }

    var_15 = 0;

    if(var_08 < var_11 && var_09 > 10 && var_10 > var_12 && func_A7D7(var_06)) {
      if(bullettracepassed(level.func_D127.origin, var_6.origin + (0, 0, 200), 0, level.func_D127))
        var_15 = 1;
    }

    if(var_15) {
      if(!scripts\engine\utility::flag("jackal_taking_off")) {
        func_DA72();

        if(isDefined(self.func_B36F) && self.func_B36F != var_06)
          self.func_B36F func_4130();

        var_06 func_DA73();
        self.func_B36F = var_06;
      }

      if(level.player usebuttonpressed()) {
        level notify("stop_landingpad_pulse");
        level.player scripts\sp\utility::func_65E1("flag_player_is_landing");
        func_412F();
        var_06 func_4130();
        func_0BDC::func_A301(1, 0, "land_speed");
        thread func_A83E(var_06);

        if(isDefined(level.func_265A))
          thread[[level.func_265A]](var_06);
        else
          thread func_2658(var_06);

        return;
      }
    } else {
      func_412F();
      var_06 func_4130();
      self.func_B36F = undefined;
    }

    wait(var_00);
  }
}

func_A83E(var_00) {
  level.player playSound("autoland_aquired");
  level endon("abort_vtol");
  level.func_D127 endon("jackal_touchdown");
  level notify("jackal_landing");
  wait 0.4;

  for(;;) {
    if(isDefined(var_00))
      playFXOnTag(scripts\engine\utility::getfx("landing_pad_confirmed"), var_0.tag_origin, "tag_origin");

    level.player playSound("autoland_engaged");
    wait 0.8;
  }
}

func_DA72() {
  if(!scripts\engine\utility::flag("jackal_land_hint")) {
    scripts\engine\utility::flag_set("jackal_land_hint");
    scripts\sp\utility::func_56BA("jackal_land");
  }
}

func_412F() {
  if(scripts\engine\utility::flag("jackal_land_hint"))
    scripts\engine\utility::flag_clear("jackal_land_hint");
}

func_DA73() {
  if(!self.func_B36C) {
    thread func_2656();
    self.func_B36C = 1;
  }
}

func_2656() {
  self endon("entitydeleted");
  self endon("stop_autoland_marker");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("landing_pad_marker"), self.tag_origin, "tag_origin");
    level.player playSound("autoland_marker");
    wait 1;
  }
}

func_4130() {
  if(self.func_B36C) {
    self notify("stop_autoland_marker");
    self.func_B36C = 0;
  }
}

func_2658(var_00) {
  level endon("abort_vtol");
  thread func_1393F();
  func_0BDC::func_A15C();
  func_0BDC::func_A153();
  func_0BDC::func_A155();
  func_0BDC::func_A156();
  func_0BDC::func_A164();
  func_0BDC::func_A14A();
  thread func_2657(var_00);
  func_0BDC::func_A1DD("hover");
  func_0BDC::func_A224(1);
  objective_delete(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"));
  var_01 = 250;
  var_02 = 500;
  var_03 = 5000;
  var_04 = level.func_D127.origin[2] - var_0.origin[2];
  var_05 = clamp(var_04, var_01, var_02);
  var_06 = 199;
  level.func_13573 = scripts\engine\utility::spawn_tag_origin();
  level.func_13572 = scripts\engine\utility::spawn_tag_origin();
  var_07 = level.func_13573;
  var_08 = level.func_13572;
  var_7.origin = var_0.origin + anglestoup(var_0.angles) * var_05;
  var_8.origin = var_7.origin + anglesToForward(var_0.angles) * var_03;
  func_0BDC::func_D165(var_08, 0.55, 0, 1);
  func_0BDC::func_D16C(var_07, 0.625, 0, 1);
  var_09 = 250;

  for(;;) {
    var_10 = distance(level.func_D127.origin, var_7.origin);
    var_11 = vectordot(anglesToForward(level.func_D127.angles), vectornormalize(var_8.origin - level.func_D127.origin));
    var_12 = scripts\sp\math::func_C097(var_09, 2000, var_10);
    var_04 = level.func_D127.origin[2] - var_0.origin[2];

    if(var_10 < var_09 && var_11 > 0.5 && var_04 > 10) {
      break;
    }
    wait 0.05;
  }

  func_10FC9();
  func_0BDC::func_A14D();
  var_13 = 1.5;
  var_07 moveto(var_0.origin, var_13, var_13 * 0.4);
  var_08 moveto(var_7.origin + anglesToForward(var_0.angles) * var_03, var_13, var_13 * 0.4);
  func_0BDC::func_D16C(var_07, 1, 0, 1);
  var_14 = undefined;

  for(;;) {
    var_04 = level.func_D127.origin[2] - var_0.origin[2];

    if(!isDefined(var_14))
      var_14 = var_04 - var_06;

    if(var_04 <= var_06) {
      break;
    }
    wait 0.05;
  }

  earthquake(0.35, 0.75, level.func_D127.origin, 3000);
  level.player playrumbleonentity("damage_heavy");
  func_0BDC::func_A1DD();
  level.func_D127 _meth_8491("land");
  level.func_D127 notify("jackal_touchdown");
  var_15 = level.func_D127.origin;
  var_16 = (0, level.func_D127.angles[1], 0);
  var_17 = var_0.origin[2] + 99;
  var_7.origin = (var_15[0], var_15[1], var_17);
  var_8.origin = var_7.origin + anglesToForward(var_16) * 5000;
  level notify("stop_watch_abort_vtol");
  func_0BDC::func_D165(var_08, 1.0, 0, 0.15, 1);
  func_0BDC::func_D16C(var_07, 1.0, 0, 0.15, 1);
  wait 1;
  func_0BDC::func_D165(var_08, 0.0, 1, 0.0, 1);
  func_0BDC::func_D16C(var_07, 0.0, 1, 0.0, 1);
  func_2659();
  func_E073();
}

func_2659() {
  func_0BDC::func_A224(0);
  func_0BDC::func_D165(level.func_13572, 0, 1, 1);
  func_0BDC::func_D16C(level.func_13573, 0, 1, 1);
  func_0BDC::func_A1DD();
  func_0BDC::func_A15C(0);
  func_0BDC::func_A153(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A156(0);
  func_0BDC::func_A164(0);
  func_0BDC::func_A14A(0);
  level.func_13573 delete();
  level.func_13572 delete();
}

func_151F() {
  level notify("abort_vtol");
  level.player scripts\sp\utility::func_65DD("flag_player_is_landing");
  _setsaveddvar("spaceshipcollisionEventThreshold", level.func_A056.func_105E7);
  func_2659();
  thread func_D1F6();
}

func_1393F() {
  level endon("stop_watch_abort_vtol");
  level endon("abort_vtol");
  var_00 = 0;
  _setsaveddvar("spaceshipcollisionEventThreshold", 0);

  for(;;) {
    level.func_D127 waittill("spaceship_collision");
    var_0++;

    if(var_00 >= 2)
      thread func_151F();
  }
}

func_2657(var_00) {
  level endon("stop_vtol_pushup");

  for(;;) {
    var_01 = level.func_D127.origin[2] - var_0.origin[2];
    var_02 = scripts\sp\math::func_C097(-60, 30, var_01);
    var_03 = scripts\sp\math::func_6A8E(80, 0, var_02);
    func_0BDC::func_A078((0, 0, var_03), 0.05, "vtol_pushup");
    wait 0.05;
  }
}

func_10FC9() {
  level notify("stop_vtol_pushup");
  func_0BDC::func_A078((0, 0, 0), 0.5, "vtol_pushup");
}

func_A7D7(var_00) {
  if(level.func_A056.func_1632.size == 0 || !level.player scripts\sp\utility::func_65DB("flag_player_landing_enabled") || !level.player scripts\sp\utility::func_65DB("flag_takeoff_cooldown") || func_0BDC::func_7B9C() > 200 || !var_00 func_0BDC::func_9C1B(0.9))
    return 0;
  else
    return 1;
}

func_F51F() {
  var_00 = level.player;
  func_A2D8();
  level.player _meth_81E3(1);
  func_0BDC::func_104A6(0);
  var_01 = self makeentitysentient("allies", 0);
  func_0BD9::func_D161(var_0.team);
  scripts\engine\utility::waitframe();
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_jackal_weapon_display_temp", 0);
  func_0BDC::func_6B4C("none", 1);
  var_02 = self[[self.func_BBD4]]();
  func_0BDC::func_A2DA();
  thread func_A0F7();
  func_0BD4::func_A329(var_02);
  func_0BDC::jackal_engine_throttle_sfx_volume(1, 2);
  level.player enableweapons();
  level.player getquadrant();
  self thread[[self.func_11474]]();
  level.player scripts\sp\utility::func_65E1("flag_player_is_flying");
}

func_E073(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(!var_00) {
    level.player scripts\sp\utility::func_65E1("flag_player_dismounting");
    self[[self.func_A7B9]]();
    func_5686();
    func_DF4D();
    func_0BD4::func_A2D9();
    level.player _meth_81E3(0);
    self notify("player_exit_jackal");
    func_0BD5::func_4086();
    thread func_0BD9::func_D176(0.0, 0, 0.2, 0.01, 0.3);
  }

  func_0BDC::jackal_engine_throttle_sfx_volume(0, 2);
  var_01 = self[[self.func_5688]]();
  func_569B();
  func_569C();
  func_5683();
  level.func_A056 notify("player_left_jackal");
  level.func_D127 = undefined;
  level.func_D223 = self;

  if(scripts\engine\utility::is_true(self.func_FF24))
    func_0BDC::func_A07D();

  func_0BDC::func_A208();
  func_0BDC::func_A0AF();
  func_0BDC::func_104A6(1);
  func_0BDC::func_6B4D();
  func_0BDC::func_6B4C(var_01);
  func_A328();
  self freeentitysentient();

  if(isDefined(self.func_AD34))
    self.func_AD34 delete();
}

func_A328() {
  if(isDefined(level.func_A056.func_C8F7)) {
    self.func_C8F7 = spawn("script_model", self.origin);
    self.func_C8F7 setModel(level.func_A056.func_C8F7);
    self.func_C8F7 linkto(self, "tag_origin", level.func_A056.func_C8F8, (0, 0, 0));
    self notsolid();
  }
}

func_A2D8() {
  if(isDefined(self.func_C8F7)) {
    self.func_C8F7 delete();
    self solid();
  }
}

func_A0F7() {
  if(self.model != level.vehicle.func_116CE.func_13265[self.classname].func_D375)
    func_A32A();
}

func_A0F8() {
  func_0BDC::func_137DA();

  if(isDefined(level.func_A056.func_DE59))
    level.func_A056.func_DE59 func_0BDC::func_A25B(0, "j_mainroot_ship", (232, 0, 32), (0, 0, 0));
}

func_A1B6() {
  self playSound("plr_foley_exit_jackal_zg_start");
  wait 1.7;
  self playSound("plr_foley_exit_jackal_zg_switch1");
  self playSound("plr_foley_exit_jackal_zg_switch3");
  wait 0.6;
  self playSound("plr_foley_exit_jackal_zg_switch2");
  wait 1.9;
  self playSound("plr_foley_exit_jackal_zg_finish");
  wait 0.1;
  self playSound("plr_foley_exit_jackal_zg_switch4");
}

func_A1B5() {
  wait 2;
  self playSound("plr_foley_exit_jackal_cockpit_zg_lr");
}

func_A1A7() {
  level.player playSound("plr_jackal_zg_canopy_open");
  wait 1;
  level.player playSound("plr_foley_enter_jackal_zg");
}

func_A1A6() {
  wait 3;
  level.player playSound("plr_foley_enter_jackal_cockpit_zg_lr");
  wait 1.45;
  level.player playSound("jackal_warmup_plr");
  wait 0.55;
  level.player playSound("jack_plr_enter_zg_switches");
  wait 0.2;
  wait 0.3;
  level.player playSound("jack_plr_enter_zg_pressurize");
  wait 0.7;
  level.player playSound("jack_plr_enter_zg_boot");
  wait 1;
  level.player _meth_82C0("jackal_cockpit");
}

func_A32A() {
  if(isDefined(level.func_A056.mip_buffer_model))
    level.func_A056.mip_buffer_model delete();

  func_0BDC::func_A144();
  self setModel(level.vehicle.func_116CE.func_13265[self.classname].func_D375);
  self dontcastshadows();
  _setsaveddvar("r_playerShadowProxy0Params", "0 0 0 0");
  _setsaveddvar("r_playerShadowProxy1Params", "0 0 0 0");
}

func_A0F9() {
  if(self.model != level.vehicle.func_116CE.func_13265[self.classname].func_13DCB)
    func_A330();
}

func_A330() {
  self setModel(level.vehicle.func_116CE.func_13265[self.classname].func_13DCB);
  self castshadows();
  _setsaveddvar("r_playerShadowProxy0Params", "0 0 0 4");
  _setsaveddvar("r_playerShadowProxy1Params", "0 0 -8 4");
  func_0BDC::func_A0AF();
  func_0BDC::func_A07D();
}

func_DF4D() {
  if(!isDefined(self.linked_ents)) {
    return;
  }
  foreach(var_01 in self.linked_ents) {
    if(isDefined(var_01))
      var_01 linkto(self, var_1.func_AD42, var_1.func_AD25, var_1.func_AD19);

    self.linked_ents = scripts\engine\utility::array_remove(self.linked_ents, var_01);
  }
}

func_E076() {
  if(isDefined(self.func_AD34))
    self.func_AD34 delete();
}

func_107A1() {
  if(isDefined(self.func_AD34)) {
    return;
  }
  self.func_AD34 = level.player scripts\engine\utility::spawn_tag_origin();
  self.func_AD34 setModel("viewmodel_base_viewhands_iw7");
  self.func_AD34 hide();
  self.func_AD34.origin = self gettagorigin("tag_camera") + anglestoup(self gettagangles("tag_camera")) * -60;
  self.func_AD34.angles = self gettagangles("tag_camera");
  self.func_AD34 linkto(self, "tag_camera");
}

func_5698() {
  if(!isDefined(level.func_A056.func_DE59)) {
    return;
  }
  level.func_A056.func_DE59 func_0BDC::func_A387();
  level.func_A056.func_DE59.func_C73B = (-200000, -200000, -200000);
}

func_569B() {
  level.player scripts\sp\utility::func_65DD("flag_player_is_flying");
  level.player scripts\sp\utility::func_65DD("flag_takeoff_cooldown");
  level.player scripts\sp\utility::func_65DD("flag_player_has_jackal");
  level.player scripts\sp\utility::func_65DD("flag_player_dismounting");
}

func_569C() {
  level.player allowfire(1);
  level.player allowads(1);
  level.player enableoffhandweapons();
}

func_5683() {
  if(isDefined(self.missiles))
    self.missiles.active = 0;
}

func_5686() {
  func_0BDC::func_A14D(0);
  func_0BDC::func_A15C(0);
  func_0BDC::func_A153(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A156(0);
  func_0BDC::func_A14A(0);
  func_0BDC::func_A15D(0);
}

func_569A() {
  func_0BDC::func_D165((0, 0, 0), 0.0, 1, 0.0, 1);
  func_0BDC::func_D16C((0, 0, 0), 0.0, 1, 0.0, 1);
  func_0BDC::func_D165((0, 0, 0), 0.0, 1, 0.0);
  func_0BDC::func_D16C((0, 0, 0), 0.0, 1, 0.0);
}

func_11478() {
  level.player scripts\sp\utility::func_65E1("flag_takeoff_cooldown");
  func_0BDC::jackal_engine_throttle_sfx_volume(1, 0);
  func_0BDC::func_A153(0);
}

func_1148A() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  level.player _meth_8462(level.func_D127.func_BC85, "moveto", "absolute_player", 0.2, 0);
  var_00 = level.func_D127.origin + anglesToForward(level.func_D127.angles) * 1000;
  func_0BDC::func_D165(var_00, 1, 1, 0);
  func_0BDC::func_A14D();
  func_0BDC::func_A155();
  func_0BDC::func_A15C();
  func_0BDC::func_A15B();
  func_0BDC::func_A151();
  func_0BDC::func_A152(0);
  scripts\sp\utility::func_56BA("jackal_takeoff");

  while(!isDefined(level.func_D127.func_7294)) {
    wait 0.05;

    if(level.player gettimeremainingpercentage()) {
      break;
    }
  }

  func_0BDC::func_A302(0.1, 0, "vtol_turn_takeoff");
  func_0BDC::func_D165(var_00, 0, 1, 0);
  thread func_0BDC::func_A07A((0, 0, 50), 0.2, 1, "vtol_takoff_impulse");
  level.player notify("player_takeoff");
  level.player playSound("jackal_vtol_takeoff_plr");
  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_clear, "jackal_taking_off");
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.18, 0.6, level.func_D127.origin, 3000);
  func_0BDC::func_A302(1.0, 7, "vtol_turn_takeoff");
  level.player _meth_8462(level.func_D127.func_BC85, "moveto", "absolute_player", 1, 7);
  level.func_D127 _meth_8491("hover");

  if(!isDefined(level.func_D127.func_7294))
    func_0BDC::func_A14D(0);

  wait 1.2;

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_guns"))
    func_0BDC::func_A19E(0);

  wait 1.8;
  level.player scripts\sp\utility::func_65E1("flag_takeoff_cooldown");
  func_0BDC::func_A155(0);
  func_0BDC::func_A15C(0);
  func_0BDC::func_A15B(0);
  func_0BDC::func_A151(0);
  level.func_D127.func_7294 = undefined;
}

func_11486() {
  func_0BDC::func_A14D();
  func_0BDC::func_A155();
  func_0BDC::func_A15C();
  level.func_D127.anchor = level.func_D127 scripts\engine\utility::spawn_tag_origin();
  func_0BDC::func_D164(level.func_D127.anchor, 0);
  level waittill("forever");
}

func_1147C() {
  func_0BDC::func_A14D();
  func_0BDC::func_A155();
  func_0BDC::func_A15B();
  func_0BDC::func_A151();
  func_0BDC::func_A15C();
  func_0BDC::func_A2FC(0.7, 0.0);
  scripts\engine\utility::flag_set("jackal_hint_ret_launch");
  scripts\engine\utility::delaythread(1, scripts\sp\utility::func_56BA, "jackal_launch_retribution");
  level.player notifyonplayercommand("jackal_ret_launch", "+breath_sprint");
  level.player waittill("jackal_ret_launch");
  scripts\engine\utility::flag_clear("jackal_hint_ret_launch");
  func_0BDC::func_A0BE(1);
  func_0BDC::func_A1DD("fly");
  scripts\engine\utility::delaythread(1, func_0BDC::func_A0BE, 0);
  scripts\engine\utility::delaythread(1, func_0BDC::func_A2FC, 1, 0);
}

func_1147D() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  func_0BDC::jackal_engine_throttle_sfx_volume(0, 0);
  var_00 = spawnvehicle("veh_mil_air_un_jackal_02", "player_sled", "jackal_un", level.func_D127.origin, level.func_D127.angles);
  var_00 _meth_8184();
  var_00 notsolid();
  var_0.func_AFEB = scripts\engine\utility::spawn_tag_origin();
  var_0.func_AFEB.origin = var_0.origin + anglesToForward(var_0.angles) * 15000;
  var_0.func_AFEB linkto(var_00);
  var_00 func_0C24::func_10A49();
  func_0BDC::func_D16C(var_00, 1, 0, 0, 1);
  func_0BDC::func_D16C(var_00, 1, 0, 0);
  func_0BDC::func_D165(var_0.func_AFEB, 1.0, 0, 0);
  func_0BDC::func_D165(var_0.func_AFEB, 1.0, 0.0, 0, 1);
  func_0BDC::func_A38E(0, undefined, undefined, 0);
  var_01 = func_7CCE();
  func_0BDC::func_A14D();
  func_0BDC::func_A155();
  func_0BDC::func_A15B();
  func_0BDC::func_A151();
  func_0BDC::func_A156();
  func_0BDC::func_A15C();
  func_0BDC::func_A14A();
  func_0BDC::func_A152(1);

  if(scripts\engine\utility::flag_exist("takeoff_runway_blocker"))
    scripts\engine\utility::flag_wait("takeoff_runway_blocker");

  func_0BDC::func_A250();
  func_0BDC::jackal_engine_throttle_sfx_volume(1, 1);
  func_11482();
  func_0BDC::func_A250(0);
  func_0BDC::func_D165(var_0.func_AFEB, 0.0, 1.0, 0, 1);
  func_0BDC::func_A38E(undefined, undefined, undefined, 1);
  func_0BDC::func_A0BE();
  func_0BDC::func_A1DC(400);
  func_0BDC::func_A1DD("hover");
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.18, 0.6, level.func_D127.origin, 3000);
  var_00 _meth_8479(var_01);
  var_00 _meth_847B(0.2);
  var_00 playLoopSound("jackal_runway_sled_lp");
  var_00 ghostattack(0.7, 0.0);
  var_00 _meth_8277(0.7, 0.0);
  wait 0.05;
  var_00 ghostattack(1.8, 2.0);
  var_00 _meth_8277(1.3, 2.0);
  var_00 waittill("off_ramp");
  level notify("player_off_ramp");
  var_00 ghostattack(0.0, 0.2);
  func_0BDC::func_A302(0.3, 0.0);
  func_0BDC::func_D16C(var_00, 0.0, 1.0, 0.5, 1);
  func_0BDC::func_D165(var_0.func_AFEB, 1.0, 0.2, 2.5);
  func_0BDC::func_A1DD(0);
  func_0BDC::func_A0BE(0);
  earthquake(0.29, 1.8, self.origin, 10000);
  level.player playrumbleonentity("damage_heavy");
  thread func_0BDC::func_A287(0.2);
  var_00 waittill("return_player_control");
  level notify("return_player_control");
  func_0BDC::func_A14D(0);
  func_0BDC::func_A14A(0);
  func_0BDC::func_A302(1.0, 0.2);
  func_0BDC::func_D16C(var_00, 0, 1, 2.5);
  func_0BDC::func_D16C(var_00, 0, 1.0, 2.5, 1);
  func_0BDC::func_D165(var_0.func_AFEB, 0, 1.0, 2.5);
  func_0BDC::func_A1DC(0);
  earthquake(0.27, 1.5, self.origin, 10000);
  level.player playrumbleonentity("damage_light");
  thread func_0BDC::func_A388(1.0);
  thread func_0BDC::func_D527("jackal_vtol_takeoff_plr", self.origin, undefined, 1.5);
  wait 1.2;

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_guns"))
    func_0BDC::func_A19E(0);

  wait 1.8;
  level.player scripts\sp\utility::func_65E1("flag_takeoff_cooldown");
  func_0BDC::func_A15B(0);
  func_0BDC::func_A151(0);
  func_0BDC::func_A156(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A1DD(0);
  func_0BDC::func_A15C(0);
  var_0.func_AFEB delete();
  var_00 delete();
  scripts\engine\utility::flag_clear("jackal_taking_off");
  func_1147E();
}

func_1147E() {
  foreach(var_01 in level.func_A056.func_E8AD.func_AA83.cleanup) {
    var_01 delete();
    wait 0.05;
  }

  foreach(var_04 in level.func_A056.func_E8AD.func_AA60) {
    foreach(var_01 in var_4.cleanup) {
      var_01 delete();
      wait 0.05;
    }
  }
}

func_11479() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  func_0BDC::func_A14D();
  func_0BDC::func_A155();
  func_0BDC::func_A15B();
  func_0BDC::func_A151();
  func_0BDC::func_A15C();
  func_0BDC::func_A152(0);
  self waittill("notify_player_can_launch");
  func_1147A();
  level.player scripts\sp\utility::func_65E1("flag_player_is_flying");
  self notify("notify_player_launch");
  earthquake(0.29, 1.8, self.origin, 10000);
  level.player playrumbleonentity("damage_heavy");
  level.func_D127 waittill("launch_complete");
  func_0BDC::func_A14D(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A15B(0);
  func_0BDC::func_A151(0);
  func_0BDC::func_A15C(0);

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_guns"))
    func_0BDC::func_A19E(0);

  scripts\engine\utility::flag_clear("jackal_taking_off");
}

func_1147B(var_00) {
  if(!scripts\engine\utility::flag_exist("flag_can_launch"))
    scripts\engine\utility::flag_init("flag_can_launch");

  for(var_01 = 0; var_01 < var_00; var_01 = var_01 + 0.05) {
    level.func_B41D = scripts\sp\math::func_C097(0, var_00, var_01);
    wait 0.05;
  }

  scripts\engine\utility::flag_set("flag_can_launch");
}

func_7CCE() {
  var_00 = getcsplinecount();
  var_01 = [];

  for(var_02 = 1; var_02 <= var_00; var_2++) {
    var_03 = _getcsplinetargetname(var_02);

    if(issubstr(var_03, "jackal_runway_launch_sled")) {
      var_04 = var_02;
      var_01 = scripts\engine\utility::array_add(var_01, var_04);
    }
  }

  if(var_1.size == 0) {}

  var_05 = 99999999;
  var_06 = 0;

  foreach(var_08 in var_01) {
    var_09 = distance(getcsplinepointposition(var_08, 0), level.func_D127.origin);

    if(var_09 < var_05) {
      var_05 = var_09;
      var_06 = var_08;
    }
  }

  if(var_06 == 0) {}

  return var_06;
}

func_11482() {
  var_00 = 0.017;
  var_01 = 0.017;
  var_02 = 0;
  var_03 = 0.0;
  var_04 = 0.47;
  var_05 = 1;
  var_06 = 0.5;
  var_07 = var_06;
  var_08 = 0.05;
  var_09 = 0.1;
  var_10 = 1;
  var_11 = 0.05;
  var_12 = 0.24;
  var_13 = 0.4;
  var_14 = scripts\sp\utility::func_7C23();
  var_14 scripts\sp\utility::func_E7C9(0, 0.05);
  var_15 = scripts\engine\utility::spawn_tag_origin();
  var_15.origin = level.func_D127.origin;
  var_16 = scripts\engine\utility::spawn_tag_origin();
  var_16.origin = level.func_D127.origin;
  var_15 ghostattack(0, 0);
  var_15 _meth_8277(var_06, 0);
  var_17 = 0;
  scripts\engine\utility::flag_set("jackal_reving_hint");
  scripts\engine\utility::delaythread(1, ::func_A2CE);

  for(;;) {
    var_18 = level.player getnormalizedmovement();

    if(var_18[0] > 0.1) {
      break;
    }
    wait 0.05;
  }

  earthquake(0.3, 1.0, level.func_D127.origin, 3000);
  var_16 playSound("jackal_takeoff_build_plr");
  var_15 playLoopSound("jackal_takeoff_build_lp_plr");
  var_19 = 0;
  setomnvar("ui_jackal_booster_charge", 0);
  setomnvar("ui_jackal_boosters_charging", 1);
  var_20 = 0.09;
  var_21 = 0;

  for(;;) {
    var_18 = level.player getnormalizedmovement();
    var_22 = clamp(var_18[0], 0, 1);

    if(var_22 > var_03)
      var_23 = var_00;
    else
      var_23 = var_01;

    var_03 = var_03 + (var_22 - var_03) * var_23;

    if(var_03 > var_04) {
      var_17 = 1;
      scripts\engine\utility::flag_clear("jackal_reving_hint");
    } else {
      var_17 = 0;
      scripts\engine\utility::flag_clear("jackal_launching_hint");
      var_19 = 0;

      if(var_03 < var_20 || var_18[0] < var_04) {
        if(!scripts\engine\utility::flag("jackal_reving_hint")) {
          scripts\engine\utility::flag_set("jackal_reving_hint");
          func_A2CE();
        }
      } else
        scripts\engine\utility::flag_clear("jackal_reving_hint");
    }

    if(var_17 && !var_19) {
      scripts\engine\utility::flag_set("jackal_launching_hint");
      thread scripts\sp\utility::func_56BA("jackal_launch_start");
      var_19 = 1;
    }

    if(func_E8BC()) {
      if(var_17 && !var_21) {
        var_21 = 1;
        level notify("player_clear_for_launch");
        level.player playSound("jackal_runway_takeoff_lights_on");
        thread func_11480(level.func_A056.func_E8AD.func_AA83.lights);
      } else if(!var_17 && var_21) {
        var_21 = 0;
        level.player playSound("jackal_runway_takeoff_lights_off");
        thread func_1147F(level.func_A056.func_E8AD.func_AA83.lights);
      }
    }

    if(level.player _meth_8439()) {
      if(!var_02 && var_17) {
        break;
      }
      var_02 = 1;
    } else
      var_02 = 0;

    var_24 = scripts\sp\math::func_6A8E(var_06, var_05, var_03);
    var_07 = var_07 + (var_24 - var_07) * var_08;
    var_25 = scripts\sp\math::func_6A8E(var_09, var_10, var_03);
    var_26 = scripts\sp\math::func_6A8E(var_11, var_12, var_03);
    var_27 = scripts\sp\math::func_6A8E(0, var_13, var_03);
    var_28 = scripts\sp\math::func_C097(0, var_04, var_03);
    setomnvar("ui_jackal_booster_charge", var_28);
    var_15 ghostattack(var_25, 0.05);
    var_15 _meth_8277(var_07, 0.05);
    earthquake(var_26, 0.3, level.func_D127.origin, 3000);
    var_14 scripts\sp\utility::func_E7C9(var_27, 0.05);
    wait 0.05;
  }

  var_16 playSound("jackal_takeoff_build_plr_stop");
  setomnvar("ui_jackal_boosters_charging", 0);
  setomnvar("ui_jackal_booster_charge", 0);
  scripts\engine\utility::flag_clear("jackal_launching_hint");
  scripts\engine\utility::flag_clear("jackal_reving_hint");
  var_16 scripts\engine\utility::delaycall(0.5, ::stopsounds);
  var_15 thread func_4091();
  var_16 scripts\engine\utility::delaycall(0.6, ::delete);
  var_14 delete();
  level notify("player_runway_takeoff");
}

func_E8BC() {
  if(isDefined(level.func_A056)) {
    if(isDefined(level.func_A056.func_E8AD)) {
      if(isDefined(level.func_A056.func_E8AD.func_AA83)) {
        if(isDefined(level.func_A056.func_E8AD.func_AA83.lights))
          return 1;
      }
    }
  }

  return 0;
}

func_1147A() {
  var_00 = 0.09;
  var_01 = 0.025;
  var_02 = 0;
  var_03 = 0.0;
  var_04 = 0.8;
  var_05 = 1;
  var_06 = 0.5;
  var_07 = var_06;
  var_08 = 0.05;
  var_09 = 0.1;
  var_10 = 1;
  var_11 = 0.05;
  var_12 = 0.24;
  var_13 = 0.4;

  if(!scripts\engine\utility::flag_exist("flag_can_launch"))
    scripts\engine\utility::flag_init("flag_can_launch");

  if(!scripts\engine\utility::flag_exist("flag_launch_fail"))
    scripts\engine\utility::flag_init("flag_launch_fail");

  var_14 = scripts\sp\utility::func_7C23();
  var_14 scripts\sp\utility::func_E7C9(0, 0.05);
  var_15 = scripts\engine\utility::spawn_tag_origin();
  var_15.origin = level.func_D127.origin;
  var_16 = scripts\engine\utility::spawn_tag_origin();
  var_16.origin = level.func_D127.origin;
  var_15 ghostattack(0, 0);
  var_15 _meth_8277(var_06, 0);
  var_17 = 0;
  scripts\engine\utility::flag_set("jackal_reving_hint");
  scripts\engine\utility::delaythread(1, ::func_A2CE);
  setomnvar("ui_jackal_boosters_charging", 1);
  var_16 playSound("jackal_takeoff_build_plr");
  level.func_D127 playSound("jackal_panel_detach_plr");
  var_15 playLoopSound("jackal_takeoff_build_lp_plr");

  for(;;) {
    var_18 = level.player getnormalizedmovement();

    if(var_18[0] > 0.1 || scripts\engine\utility::flag("flag_launch_fail")) {
      break;
    }
    wait 0.05;
  }

  earthquake(0.3, 1.0, level.func_D127.origin, 3000);
  var_19 = 0;
  var_20 = 0.2;
  var_21 = 0;
  var_22 = 0;

  for(;;) {
    if(!isDefined(level.func_B41D))
      var_23 = 1;
    else
      var_23 = level.func_B41D;

    var_18 = level.player getnormalizedmovement();
    var_24 = clamp(var_18[0], 0, 1) * var_23;

    if(var_24 > var_03)
      var_25 = var_00;
    else
      var_25 = var_01;

    var_03 = var_03 + (var_24 - var_03) * var_25;
    var_22 = scripts\sp\math::func_C097(0, var_04, var_03);
    setomnvar("ui_jackal_booster_charge", var_22);

    if(var_03 > var_04 && scripts\engine\utility::flag("flag_can_launch")) {
      var_17 = 1;
      scripts\engine\utility::flag_clear("jackal_reving_hint");
    } else {
      var_17 = 0;
      scripts\engine\utility::flag_clear("jackal_launching_hint");
      var_19 = 0;

      if(var_03 < var_20 || var_18[0] < var_04) {
        if(!scripts\engine\utility::flag("jackal_reving_hint")) {
          scripts\engine\utility::flag_set("jackal_reving_hint");
          func_A2CE();
        }
      } else
        scripts\engine\utility::flag_clear("jackal_reving_hint");
    }

    if(var_17 && !var_19) {
      scripts\engine\utility::flag_set("jackal_launching_hint");
      thread scripts\sp\utility::func_56BA("jackal_launch_start");
      var_19 = 1;
    }

    if(var_17 && !var_21) {
      var_21 = 1;
      level notify("player_clear_for_launch");
      level.player playSound("jackal_runway_takeoff_lights_on");
    } else if(!var_17 && var_21) {
      var_21 = 0;
      level.player playSound("jackal_runway_takeoff_lights_off");
    }

    if(level.player _meth_8439()) {
      if(!var_02 && var_17) {
        break;
      }
      var_02 = 1;
    } else
      var_02 = 0;

    if(scripts\engine\utility::flag("flag_launch_fail")) {
      break;
    }
    var_26 = scripts\sp\math::func_6A8E(var_06, var_05, var_03);
    var_07 = var_07 + (var_26 - var_07) * var_08;
    var_27 = scripts\sp\math::func_6A8E(var_09, var_10, var_03);
    var_28 = scripts\sp\math::func_6A8E(var_11, var_12, var_03);
    var_29 = scripts\sp\math::func_6A8E(0, var_13, var_03);
    var_15 ghostattack(var_27, 0.05);
    var_15 _meth_8277(var_07, 0.05);
    earthquake(var_28, 0.3, level.func_D127.origin, 3000);
    var_14 scripts\sp\utility::func_E7C9(var_29, 0.05);
    wait 0.05;
  }

  var_16 playSound("jackal_takeoff_build_plr_stop");
  setomnvar("ui_jackal_booster_charge", 0);
  setomnvar("ui_jackal_boosters_charging", 0);
  scripts\engine\utility::flag_clear("jackal_launching_hint");
  scripts\engine\utility::flag_clear("jackal_reving_hint");
  var_16 scripts\engine\utility::delaycall(0.5, ::stopsounds);
  var_15 thread func_4091();
  var_16 scripts\engine\utility::delaycall(0.6, ::delete);
  var_14 delete();
  level notify("player_runway_takeoff");
}

func_CFE0(var_00) {
  level.func_D127 endon("notify_player_launch");

  if(!scripts\engine\utility::flag_exist("flag_launch_fail"))
    scripts\engine\utility::flag_init("flag_launch_fail");

  while(var_00 > 0) {
    var_00 = var_00 - 0.05;
    wait 0.05;
  }

  scripts\engine\utility::flag_set("flag_launch_fail");
}

func_11480(var_00) {
  foreach(var_02 in var_00) {
    _killfxontag(scripts\engine\utility::getfx("vfx_hangar_launch_light_red"), var_02, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_hangar_launch_light_green"), var_02, "tag_origin");
  }
}

func_1147F(var_00) {
  foreach(var_02 in var_00) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_hangar_launch_light_red"), var_02, "tag_origin");
    _killfxontag(scripts\engine\utility::getfx("vfx_hangar_launch_light_green"), var_02, "tag_origin");
  }
}

func_4091() {
  self ghostattack(0, 0.2);
  wait 0.2;
  self stoploopsound("jackal_boost_lp");
  self delete();
}

func_11477() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  func_0BDC::func_A302(0.1, 0, "vtol_turn_takeoff");
  level.player _meth_8462(level.func_D127.func_BC85, "moveto", "absolute_player", 0.2, 0);
  func_0BDC::func_A15C();
  func_0BDC::func_A15B();
  func_0BDC::func_A151();
  func_0BDC::func_A153();
  var_00 = 0;

  while(var_00 < 0.2) {
    var_01 = level.player getnormalizedmovement();
    var_02 = level.player getsplashtablename();
    var_00 = abs(var_1[0]) + abs(var_1[1]) + abs(var_2[0]) + abs(var_2[1]);
    wait 0.05;
  }

  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_clear, "jackal_taking_off");
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.18, 0.6, level.func_D127.origin, 3000);
  func_0BDC::func_A302(1.0, 7, "vtol_turn_takeoff");
  level.player _meth_8462(level.func_D127.func_BC85, "moveto", "absolute_player", 1, 7);
  wait 1.2;
  func_0BDC::func_A153(0);
  wait 1.8;
  level.player scripts\sp\utility::func_65E1("flag_takeoff_cooldown");
  func_0BDC::func_A15C(0);
  func_0BDC::func_A15B(0);
  func_0BDC::func_A151(0);
}

func_11484() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  level.func_D127 _meth_8491("hover");
  func_0BDC::func_A2DE(1, 0);
  var_00 = level.player scripts\engine\utility::spawn_tag_origin();
  var_0.angles = (0, 0, 1);
  var_01 = var_00 scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_1.origin + anglesToForward(var_1.angles) * 100000;
  func_0BDC::func_D165(var_01, 1, 0, 0, 1);
  func_0BDC::func_D16C(var_00, 1, 0, 0, 1);
  func_0BDC::func_A14D(1);
  func_0BDC::func_A155();
  func_0BDC::func_A15C();
  func_0BDC::func_A15B();
  func_0BDC::func_A151();
  var_02 = level.player scripts\engine\utility::spawn_tag_origin();
  var_01 linkto(var_02);
  var_03 = var_2.angles[2];
  thread func_11485(var_02, var_03);
  scripts\engine\utility::flag_wait("flag_jackal_can_takeoff");
  scripts\sp\utility::func_56BA("jackal_takeoff");

  while(!level.player gettimeremainingpercentage())
    wait 0.05;

  self notify("stop_sa_gunner_rotate_think");
  level.player notify("jackal_start_taking_off");
  var_02 rotateto((var_2.angles[0], var_03, var_2.angles[2]), 0.7, 0.1, 0.2);
  var_00 moveto(var_0.origin + (0, 0, 100), 1.4, 0.1, 0.2);
  wait 2.0;
  level.player notify("jackal_taking_off");
  func_0BDC::func_A2DE(0);
  func_0BDC::func_D165(var_01, 0, 1, 0, 1);
  func_0BDC::func_D16C(var_00, 0, 1, 0, 1);
  func_0BDC::func_A1DD("fly");
  func_0BDC::func_D165(var_1.origin, 1, 0, 0.2, 1);
  func_0BDC::func_A0BE(1);
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.18, 0.6, level.func_D127.origin, 3000);
  wait 2.0;
  level.player notify("jackal_done_taking_off");
  level.player scripts\sp\utility::func_65E1("flag_takeoff_cooldown");
  func_0BDC::func_D165(var_1.origin, 0, 1, 0.2, 1);
  func_0BDC::func_A14D(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A15B(0);
  func_0BDC::func_A151(0);
  func_0BDC::func_A153(0);
  func_0BDC::func_A0BE(0);
  var_00 delete();
  var_01 delete();
}

func_11485(var_00, var_01) {
  self endon("stop_sa_gunner_rotate_think");
  var_02 = 10.0;
  var_03 = 0.7;
  var_04 = 0.7;
  var_05 = 0;
  var_06 = "none";

  for(;;) {
    var_07 = level.player getsplashtablename();

    if(var_7[1] < 0) {
      if(var_06 == "left")
        var_05 = clamp(var_05 + var_03, 0 - var_04, var_04);
      else {
        var_06 = "left";
        var_05 = var_03;
      }
    } else if(var_7[1] > 0) {
      if(var_06 == "right")
        var_05 = clamp(var_05 - var_03, 0 - var_04, var_04);
      else {
        var_06 = "right";
        var_05 = 0 - var_03;
      }
    } else {
      var_06 = "none";
      wait 0.05;
      continue;
    }

    var_08 = clamp(var_0.angles[1] + var_05, var_01 - var_02, var_01 + var_02);
    var_0.angles = (var_0.angles[0], var_08, var_0.angles[2]);
    wait 0.05;
  }
}

func_A7BB() {}

#using_animtree("jackal");

func_BBD0(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(self.func_99F5.func_BBE7 == "left") {
    var_05 = % jackal_pilot_mount_01_port;
    var_06 = % jackal_vehicle_mount_01_port;

    if(isDefined(var_01))
      var_05 = var_01;

    if(isDefined(var_02))
      var_06 = var_02;
  } else {
    var_05 = % jackal_pilot_mount_01_starboard;
    var_06 = % jackal_vehicle_mount_01_starboard;

    if(isDefined(var_03))
      var_05 = var_03;

    if(isDefined(var_04))
      var_06 = var_04;
  }

  if(isDefined(self.func_BBC9))
    var_05 = self.func_BBC9;

  if(isDefined(self.func_BBCA))
    var_06 = self.func_BBCA;

  func_BBE2();
  self _meth_8491("land");

  if(isDefined(self.func_99F5.func_2ADD)) {
    return;
  }
  func_107A1();
  wait 0.05;
  var_07 = func_1ED3(var_05, "finish_link");
  level.player scripts\engine\utility::delaycall(0.05, ::getweaponweight, self.func_AD34, "tag_origin", var_07, var_07 * 0.5, var_07 * 0.5);
  level.player scripts\engine\utility::delaycall(var_07, ::getweightedchanceroll, self.func_AD34, "tag_origin", 1, 45, 45, 45, 15, 1);
  level.player scripts\engine\utility::delaycall(var_07 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_07 + 0.05, ::giveplayerscore, 2, 2.2, 0.6);
  level.player scripts\engine\utility::delaythread(var_07 + 0.05, ::func_5115, "mount_link_complete");
  var_08 = 1;
  thread func_BBC8(var_05, var_06, var_08);
  self waittill("start_lerping_view");

  if(!var_00)
    level.player lerpviewangleclamp(var_08, 0.5 * var_08, 0.5 * var_08, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_00) {
    func_BBE3();
    func_E076();
  }

  return "land";
}

func_BBD1(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(self.func_99F5.func_BBE7 == "left") {
    var_01 = % jackal_pilot_mount_01_port;
    var_02 = % jackal_vehicle_mount_01_port;
  } else {
    var_01 = % jackal_pilot_mount_01_starboard;
    var_02 = % jackal_vehicle_mount_01_starboard;
  }

  func_BBE2();
  self _meth_8491("land");
  wait 0.05;
  var_03 = func_1ED3(var_01, "finish_link");
  func_107A1();
  level.player getweaponweight(self.func_AD34, "tag_origin", var_03, var_03 * 0.5, var_03 * 0.5);
  level.player scripts\engine\utility::delaycall(var_03, ::getweightedchanceroll, self.func_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_03 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_03 + 0.05, ::giveplayerscore, 2, 2.2, 0.6);
  level.player scripts\engine\utility::delaythread(var_03 + 0.05, ::func_5115, "mount_link_complete");
  var_04 = 1;
  thread func_BBC8(var_01, var_02, var_04);
  self waittill("start_lerping_view");

  if(!var_00)
    level.player lerpviewangleclamp(var_04, 0.5 * var_04, 0.5 * var_04, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_00) {
    func_BBE3();
    func_E076();
  }

  return "land";
}

func_5115(var_00) {
  self notify(var_00);
}

func_BBDE(var_00, var_01, var_02, var_03, var_04) {
  var_05 = % ph_jackals_launch_space_plr_starboard_dps;
  var_06 = % ph_jackals_launch_space_jackal_starboard_dps;
  func_BBD0(var_00, undefined, undefined, var_05, var_06);
}

func_BBE4() {
  self notify("mount_runway");
  func_11481();
  return func_BBD0();
}

func_BBE5() {
  self notify("mount_runway_moon");
  func_11481();
  self.func_99F5.func_2ADD = 1;
  func_BBD0(1);
  wait 500;
}

func_11481() {
  level.func_A056.func_E8AD = spawnStruct();
  level.func_A056.func_E8AD.func_AA60 = [];
  var_00 = getEntArray("jackal_takeoff_blastshield", "script_noteworthy");

  foreach(var_02 in var_00) {
    level.func_A056.func_E8AD.func_AA60 = scripts\engine\utility::array_add(level.func_A056.func_E8AD.func_AA60, var_02);
    var_2.cleanup = [];
    var_03 = getEntArray(var_2.targetname, "target");

    foreach(var_05 in var_03) {
      var_05 linkto(var_02);
      var_2.cleanup = scripts\engine\utility::array_add(var_2.cleanup, var_05);

      if(var_5.targetname == "takeoff_blastshield") {
        var_2.func_2B66 = var_05;
        continue;
      }

      if(var_5.targetname == "takeoff_fx")
        var_2.func_11475 = var_05;
    }
  }

  var_08 = scripts\engine\utility::getstructarray("jackal_takeoff_lights", "script_noteworthy");
  var_09 = scripts\engine\utility::getclosest(level.func_D127.origin, var_08);
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_9.origin;

  if(isDefined(var_9.angles))
    var_2.angles = var_9.angles;

  if(isDefined(var_9.target))
    var_2.target = var_9.target;

  if(isDefined(var_9.targetname))
    var_2.targetname = var_9.targetname;

  var_2.lights = [];
  var_2.cleanup = [];
  var_10 = scripts\engine\utility::getstructarray(var_2.targetname, "target");

  foreach(var_12 in var_10) {
    var_05 = scripts\engine\utility::spawn_tag_origin();
    var_5.origin = var_12.origin;

    if(isDefined(var_12.angles))
      var_5.angles = var_12.angles;

    var_5.target = var_12.target;
    var_5.targetname = var_12.targetname;
    var_2.cleanup = scripts\engine\utility::array_add(var_2.cleanup, var_05);
    var_2.lights = scripts\engine\utility::array_add(var_2.lights, var_05);
    var_05 linkto(var_02);
    playFXOnTag(scripts\engine\utility::getfx("vfx_hangar_launch_light_red"), var_05, "tag_origin");
  }

  level.func_A056.func_E8AD.func_AA83 = var_02;
}

func_BBE9() {
  thread func_BBEA(6.5);
  func_BBDD(1);

  if(!getdvarint("titan_newjackal"))
    level waittill("briefing_nearly_complete");

  var_00 = 1.5;
  level.player lerpviewangleclamp(var_00, 0.5, 1, 0, 0, 0, 0);
  wait(var_00);

  if(!getdvarint("titan_newjackal"))
    level waittill("briefing_complete");

  if(soundexists("titan_plr_letsdoit"))
    level.player scripts\sp\utility::func_10347("titan_plr_letsdoit");

  func_BBE3();
  return "hover";
}

func_BBEA(var_00) {
  if(!getdvarint("jackal_video_capture")) {
    if(getdvarint("titan_newjackal"))
      return;
  }

  wait(var_00);

  if(getdvarint("jackal_video_capture")) {
    level thread scripts\sp\utility::func_C12D("briefing_nearly_complete", 14);
    wait 16;
  } else {
    setomnvar("ui_show_bink", 1);
    _setsaveddvar("bg_cinematicFullScreen", "0");
    _setsaveddvar("bg_cinematicCanPause", "1");
    var_01 = 0;
    _cinematicingame("titan_briefing_mid_mission");
    wait 14;
    level notify("briefing_nearly_complete");

    while(iscinematicplaying())
      wait 0.05;

    wait 0.05;
    setomnvar("ui_show_bink", 0);
    level notify("briefing_complete");
  }
}

func_BBDD(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00))
    var_00 = 0;

  var_04 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, % jackal_pilot_mount_02_starboard);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, % jackal_vehicle_mount_02_starboard);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, % jackal_vehicle_assault_motion_idle);
  func_BBE2();
  self _meth_8491("hover");
  wait 0.05;
  var_07 = func_1ED3(var_04, "finish_link");
  func_107A1();
  level.player getweaponweight(self.func_AD34, "tag_origin", var_07, var_07 * 0.5, var_07 * 0.5);
  level.player scripts\engine\utility::delaycall(var_07, ::getweightedchanceroll, self.func_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_07 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_07 + 0.05, ::giveplayerscore, 2, 2.2, 0.6);
  var_08 = 1;
  thread func_BBC8(var_04, var_05, var_08, var_06);
  self waittill("start_lerping_view");

  if(!var_00)
    level.player lerpviewangleclamp(var_08, 0.5 * var_08, 0.5 * var_08, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_00) {
    func_BBE3();
    func_E076();
  }

  return "hover";
}

func_BBEF(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(self.func_99F5.func_BBE7 == "left") {
    var_01 = % jackal_pilot_zg_mount_01_port;
    var_02 = % jackal_vehicle_zg_mount_01_port;
    var_03 = % jackal_vehicle_zg_motion_idle;
  } else if(self.func_99F5.func_BBE7 == "right") {
    var_01 = % jackal_pilot_zg_mount_01_starboard;
    var_02 = % jackal_vehicle_zg_mount_01_starboard;
    var_03 = % jackal_vehicle_zg_motion_idle;
  } else {
    var_01 = % jackal_pilot_zg_mount_01_front;
    var_02 = % jackal_vehicle_zg_mount_01_front;
    var_03 = % jackal_vehicle_zg_motion_idle;
  }

  func_BBE2();
  self _meth_8491("land");
  wait 0.05;
  var_04 = func_1ED3(var_01, "finish_link");
  func_107A1();
  level.player _meth_8507();
  level.player scripts\engine\utility::delaycall(var_04 + 0.05, ::_meth_84F0, 0);
  level.player getweaponweight(self.func_AD34, "tag_origin", var_04, var_04 * 0.5, var_04 * 0.5);
  level.player scripts\engine\utility::delaycall(var_04, ::getweightedchanceroll, self.func_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_04 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_04 + 0.05, ::giveplayerscore, 2, 2.2, 0.6);
  var_05 = 1;
  var_03 = undefined;
  thread func_BBC8(var_01, var_02, var_05, var_03);
  self waittill("start_lerping_view");

  if(!var_00)
    level.player lerpviewangleclamp(var_05, 0.5 * var_05, 0.5 * var_05, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_00) {
    func_BBE3();
    func_E076();
  }

  return "hover";
}

func_BBF0(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(self.func_99F5.func_BBE7 == "left") {
    var_01 = % sa_emp_jackal_ca_pilot_zg_mount_01_port;
    var_02 = % sa_emp_jackal_ca_vehicle_zg_mount_01_port;
  } else {
    var_01 = % sa_emp_jackal_ca_pilot_zg_mount_01_starboard;
    var_02 = % sa_emp_jackal_ca_vehicle_zg_mount_01_starboard;
  }

  func_BBE2();
  self _meth_8491("land");
  wait 0.05;
  var_03 = func_1ED3(var_01, "finish_link");
  func_107A1();
  level.player _meth_8507();
  level.player _meth_84F0(0);
  level.player getweaponweight(self.func_AD34, "tag_origin", var_03, var_03 * 0.5, var_03 * 0.5);
  level.player scripts\engine\utility::delaycall(var_03, ::getweightedchanceroll, self.func_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_03 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_03 + 0.05, ::giveplayerscore, 2, 2.2, 0.6);
  var_04 = 1;
  var_05 = undefined;
  thread func_BBC8(var_01, var_02, var_04, var_05);
  self waittill("start_lerping_view");

  if(!var_00)
    level.player lerpviewangleclamp(var_04, 0.5 * var_04, 0.5 * var_04, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_00) {
    func_BBE3();
    func_E076();
  }

  return "hover";
}

func_BBC8(var_00, var_01, var_02, var_03) {
  level notify("jackal_enter");
  spawn_jackal_mip_buffer(level.vehicle.func_116CE.func_13265[self.classname].func_D375);
  var_04 = 0.2;
  var_05 = getanimlength(var_00);
  var_06 = 0.2;
  func_0BDC::func_A2DE(1, var_06);
  self setanimknob(var_00, 1, var_06);
  self give_attacker_kill_rewards(var_01, 1, var_06);

  if(isDefined(var_03))
    self give_attacker_kill_rewards(var_03);

  if(func_9C2B(var_00)) {
    thread func_1EC6(var_00, "ps_plr_foley_jumpon_jackal", ::func_A2C8);
    thread func_1EC6(var_00, "ps_plr_foley_jumpon_jackal_cockpit_lr", ::func_A2C9);
  } else if(func_9D1F(var_00)) {
    thread func_A1A7();
    thread func_A1A6();
  } else {
    thread func_1EC6(var_00, "ps_plr_foley_enter_jackal", ::func_A2BF, undefined, 1);
    thread func_1EC6(var_00, "ps_plr_foley_enter_jackal_cockpit_lr", ::func_A2C0, undefined, 1);
    thread func_1EC6(var_00, "ps_plr_foley_jackal_mount_europa01", ::func_A2C5, undefined, 1);
    thread func_1EC6(var_00, "ps_plr_foley_jackal_mount_europa02", ::func_A2C6, undefined, 1);
    thread func_1EC6(var_00, "ps_plr_foley_jackal_mount_europa03", ::func_A2C7, undefined, 1);
    thread func_1EC6(var_00, "plr_titan_enter_jackal_cockpit", ::func_D5E9, undefined, 1);
    thread func_1EC6(var_00, "plr_sc_enter_jackal_cockpit_a", ::func_D5E5, undefined, 1);
    thread func_1EC6(var_00, "plr_sc_enter_jackal_cockpit_b", ::func_D5E6, undefined, 1);
    thread func_1EC6(var_00, "ps_plr_helmet_on", ::func_DADD, undefined, 1);
    thread func_1EC6(var_00, "heist_mons_mount_sfx", ::func_8D1C, undefined, 1);
  }

  if(!animhasnotetrack(var_00, "no_hud"))
    thread func_1EC6(var_00, "hud_boot", func_0BDC::func_A228);

  thread func_1EC6(var_00, "screens_on", func_0BDC::func_A110);
  thread func_1EC6(var_00, "lights_on", ::func_BBE0);
  thread func_1EC6(var_00, "canopy_shut", ::func_BBCE);
  thread func_1EC6(var_00, "engine_boot", ::func_BBCB);
  thread func_1EC6(var_00, "unhide_viewmodel", ::func_BBEC);
  thread func_1EC6(var_01, "decomp_fx", ::func_5689, undefined, 1);
  thread func_1EC6(var_00, "helmet_on", ::func_BBD7, undefined, 1);
  thread func_11316(var_00);
  wait(var_05 - var_02);
  self notify("start_lerping_view");
  wait(var_02 - var_04);
  self give_attacker_kill_rewards(var_00, 0, 0.2);
  self give_attacker_kill_rewards(var_01, 0, 0.2);
  self give_attacker_kill_rewards( % jackal_motion_idle_p, 1, 0.0);
  func_0BDC::func_A2DE(0);
  wait 0.05;
  self notify("mount_anims_complete");
}

func_8D1C() {
  level.player playSound("scn_heist_jackal_mount");
  wait 3.8;
  level.player _meth_82C0("jackal_cockpit", 1);
}

func_D5E9() {
  level.player playSound("plr_titan_enter_jackal_cockpit");
  wait 4;
  level.player playSound("jackal_warmup_plr");
  wait 2;
  level.player _meth_82C0("jackal_cockpit", 1);
}

func_D5E5() {
  level.player playSound("plr_sc_enter_jackal_cockpit_a");
}

func_D5E6() {
  level.player playSound("plr_sc_enter_jackal_cockpit_b");
  wait 3.2;
  level.player _meth_82C0("jackal_cockpit", 0.5);
}

func_DADD() {
  level.player playSound("plr_helmet_on");
}

func_9C2B(var_00) {
  if(var_00 == % jackal_pilot_mount_02_starboard)
    return 1;

  return 0;
}

func_9D1F(var_00) {
  if(var_00 == % jackal_pilot_zg_mount_01_port)
    return 1;

  if(var_00 == % jackal_pilot_zg_mount_01_starboard)
    return 1;

  if(var_00 == % jackal_pilot_zg_mount_01_front)
    return 1;

  if(var_00 == % sa_emp_jackal_ca_vehicle_zg_mount_01_port)
    return 1;

  if(var_00 == % sa_emp_jackal_ca_vehicle_zg_mount_01_starboard)
    return 1;

  return 0;
}

func_BBDB() {
  func_BBDA();
  return "fly";
}

func_BBD8() {
  func_BBDA();
  return "hover";
}

func_BBD9() {
  func_BBDA();
  return "land";
}

func_BBDA() {
  self clearanim( % root, 0.0);
  scripts\engine\utility::delaythread(0.1, func_0BDC::func_A334);
  func_F919(1);
  level.player _meth_818A();
  level.player _meth_84FE();
  setomnvar("ui_jackal_weapon_display_temp", 1);
}

func_BBCF() {
  func_BBD0(1);
  level.player giveplayerpassive(0);
  self notify("launch_ready");
  level waittill("forever");
}

func_BBE6() {
  level notify("shipcrib_europa_launch_started");
  func_0BDC::func_A153(1);
  var_00 = func_1ED3(level.func_CB8A, "finish_link");
  level.player scripts\engine\utility::delaycall(var_00 + 0.1, ::lerpviewangleclamp, 1, 0.5, 0.5, 15, 15, 15, 15);

  if(isDefined(level.func_CB8A) && isDefined(level.vehicle_allows_rider_death))
    func_BBD0(1, level.func_CB8A, level.vehicle_allows_rider_death, level.func_CB8A, level.vehicle_allows_rider_death);
  else
    func_BBD0(1);

  func_0BDC::func_A1DD("land");
  func_0BDC::func_A15B(1);
  func_0BDC::func_A151(1);
  func_0BDC::func_A153(1);
  level.player giveplayerpassive(0);
  level notify("shipcrib_europa_launch_complete");
  return "land";
}

spawn_jackal_mip_buffer(var_00) {
  if(isDefined(level.func_A056.mip_buffer_model)) {
    return;
  }
  var_01 = -1000;
  var_02 = level.player.origin + anglesToForward(level.player.angles) * var_01;
  level.func_A056.mip_buffer_model = spawn("script_model", var_02);
  level.func_A056.mip_buffer_model setModel(var_00);
  level.func_A056.mip_buffer_model dontcastshadows();
  level.func_A056.mip_buffer_model notsolid();
  level.func_A056.mip_buffer_model thread jackal_mip_buffer_offscreen(var_01);
}

jackal_mip_buffer_offscreen(var_00) {
  level.player endon("death");
  self endon("death");

  for(;;) {
    self.origin = level.player.origin + anglesToForward(level.player getplayerangles()) * var_00;
    wait 0.05;
  }
}

func_11316(var_00) {
  if(animhasnotetrack(var_00, "swap_jackal_model"))
    wait(scripts\engine\utility::get_notetrack_time(var_00, "swap_jackal_model"));
  else if(animhasnotetrack(var_00, "unhide_viewmodel"))
    wait(scripts\engine\utility::get_notetrack_time(var_00, "unhide_viewmodel"));
  else if(animhasnotetrack(var_00, "finish_link"))
    wait(scripts\engine\utility::get_notetrack_time(var_00, "finish_link"));
  else
    wait 0.2;

  func_A32A();
}

func_F919(var_00) {
  if(isDefined(level.func_A056.mount_instant_hud_boot_delay)) {
    setomnvar("ui_hide_hud", 1);
    var_01 = level.func_A056.mount_instant_hud_boot_delay;
    level.func_A056.mount_instant_hud_boot_delay = undefined;
  } else
    var_01 = 0;

  if(var_00)
    thread func_BBE0();
  else
    thread func_BBDF();

  if(var_00) {
    func_0BDC::func_A110(1);

    if(var_01 > 0)
      scripts\engine\utility::delaythread(var_01, func_0BDC::func_A228);
    else
      func_0BDC::func_A228();
  } else {
    func_0BDC::func_A10F();
    func_0BDC::func_A226();
  }
}

func_1EF4(var_00, var_01, var_02, var_03) {
  if(animhasnotetrack(var_00, var_01))
    wait(scripts\engine\utility::get_notetrack_time(var_00, var_01));
  else {}

  setomnvar(var_02, var_03);
}

func_1EC6(var_00, var_01, var_02, var_03, var_04) {
  if(animhasnotetrack(var_00, var_01))
    wait(scripts\engine\utility::get_notetrack_time(var_00, var_01));
  else {
    if(isDefined(var_04) && var_04) {
      return;
    }
    if(isDefined(var_03))
      wait(var_03);
    else {}
  }

  [
    [var_02]
  ]();
}

func_1ED3(var_00, var_01) {
  if(!animhasnotetrack(var_00, var_01))
    return 0;
  else
    return scripts\engine\utility::get_notetrack_time(var_00, var_01);
}

func_BBCE() {
  level.player playrumbleonentity("damage_light");
  earthquake(0.13, 0.5, level.func_D127.origin, 5000);
}

func_BBE0() {
  func_0BDC::func_4310();
}

func_A2BF() {
  level.player playSound("plr_foley_enter_jackal");
}

func_A2C0() {
  level.player playSound("plr_foley_enter_jackal_cockpit_lr");
  wait 2.45;
  level.player playSound("jackal_warmup_plr");
  wait 0.75;
  wait 1;
  level.player _meth_82C0("jackal_cockpit");
}

func_A2C5() {
  level.player playSound("plr_foley_jackal_mount_europa01");
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "jackal_cockpit_backpack_plr");
  wait 2.12;
  level.player playSound("jackal_warmup_plr");
}

func_A2C6() {
  level.player playSound("plr_foley_jackal_mount_europa02");
}

func_A2C7() {
  level.player playSound("plr_foley_jackal_mount_europa03");
  wait 2.38;
  level.player _meth_82C0("jackal_cockpit");
}

func_A2C8() {
  level.player playSound("plr_foley_jumpon_jackal");
}

func_A2C9() {
  level.player playSound("plr_foley_jumpon_jackal_cockpit_lr");
  wait 2.45;
  level.player playSound("jackal_warmup_plr");
  wait 0.75;
  wait 1;
  level.player _meth_82C0("jackal_cockpit");
}

func_A2C1() {
  level.player playSound("plr_foley_exit_jackal");
}

func_A2C2() {
  if(isDefined(level.script) && level.script == "titanjackal")
    level.player playSound("plr_foley_exit_jackal_cockpit_lr");
}

func_A2C4() {
  level.player playSound("plr_foley_exit_jackal");
}

func_A2C3() {
  level.player playSound("plr_foley_exit_jackal_cockpit_lr");
}

func_BBDF() {
  func_0BDC::func_430E();
}

func_BBD7() {
  thread func_0E4B::func_8E05();
  thread func_0B0B::func_25C0(0.0);

  if(isDefined(level.func_A056.func_87D8)) {
    wait(level.func_A056.func_87D8);
    func_0E4B::func_8DEA();
  }
}

func_BBCB() {
  level.player playSound("jackal_warmup2_plr");
  level.player playrumbleonentity("damage_light");
  earthquake(0.15, 0.5, level.func_D127.origin, 5000);
}

func_BBEC() {
  func_0BDC::func_A208(0);
  level.player _meth_818A();
  level.player _meth_84FE();
}

func_BBE2() {
  level.player getroundswon(1);
  level.player getradiuspathsighttestnodes();
  level.player getnumberoffrozenticksfromwave(0);
  level.player getnumownedactiveagents(0);
}

func_BBE3() {
  level.player unlink(1);
  level.player getroundswon(0);
  level.player enableweapons();
  level.player getnumberoffrozenticksfromwave(1);
  level.player getnumownedactiveagents(1);
}

func_5699() {
  level.player getroundswon(1);
  level.player getradiuspathsighttestnodes();
  level.player getnumberoffrozenticksfromwave(0);
  level.player getnumownedactiveagents(0);
  level.player _meth_818A();
}

func_569D() {
  level.player unlink(1);
  level.player giveperkoffhand();
  level.player _meth_84FD();
  level.player getroundswon(0);
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player getnumberoffrozenticksfromwave(1);
  level.player getnumownedactiveagents(1);
}

func_568A() {
  level.player getroundswon(0);
  level.player giveperkoffhand();
  level.player enableweapons();
  level.player enableoffhandweapons();
}

func_5685() {
  var_00 = self gettagorigin("tag_player");
  var_01 = self gettagangles("tag_player");
  level.player setorigin(var_00);
  level.player setplayerangles(var_01);
  func_5699();
  self _meth_848E(1);
  func_107A1();
  level.player getweaponweight(self.func_AD34, "tag_origin", 0);
  wait 0.05;
  func_5681( % jackal_pilot_dismount_01_port, % jackal_vehicle_dismount_01_port);
  func_569D();
  return "landed_mode";
}

func_56A6() {
  var_00 = self gettagorigin("tag_player");
  var_01 = self gettagangles("tag_player");
  level.player setorigin(var_00);
  level.player setplayerangles(var_01);
  func_5699();
  self _meth_848E(1);
  func_107A1();
  level.player getweaponweight(self.func_AD34, "tag_player", 0);
  wait 0.05;
  level.player getweightedchanceroll(self.func_AD34, "tag_player", 1, 20, 20, 5, 5, 1);
  level.player giveplayerscore(1, 2.2, 0.6);
  func_5682( % jackal_pilot_zg_dismount_01, % jackal_vehicle_zg_dismount_01);
  func_569D();
  level notify("dismount_anim_ended");
  return "hover";
}

func_568B() {
  var_00 = 0.05;
  level.player setstance("stand");
  level.player getnumownedactiveagents(0);
  level.player getnumberoffrozenticksfromwave(0);
  level.player _meth_84FE();
  thread func_A0F9();
  level.player getweightedchanceroll(level.func_D267, "tag_player", 1, 0, 0, 0, 0, 1);
  level.func_D267 scripts\engine\utility::delaycall(var_00, ::show);
  level.player thread scripts\sp\utility::func_65E2("eject_complete", 0.05);
  level.player scripts\engine\utility::delaycall(var_00 + 0.05, ::lerpviewangleclamp, 2, 0.1, 1, 10, 10, 10, 10);
  level notify("dismount_anim_ended");
  return "fly";
}

func_5695() {
  var_00 = self gettagorigin("tag_player");
  var_01 = self gettagangles("tag_player");
  level.player setorigin(var_00);
  level.player setplayerangles(var_01);
  func_5699();
  self _meth_848E(1);
  func_107A1();
  level.player getweaponweight(self.func_AD34, "tag_player", 0);
  wait 0.05;
  level.player getweightedchanceroll(self.func_AD34, "tag_player", 1, 40, 40, 20, 15, 1);
  level.player giveplayerscore(1, 2.2, 0.6);
  func_569D();
  level notify("dismount_anim_ended");
  return "fly";
}

func_5684() {
  var_00 = self gettagorigin("tag_player");
  var_01 = self gettagangles("tag_player");
  level.player setorigin(var_00);
  level.player setplayerangles(var_01);
  func_5699();
  self _meth_848E(1);
  func_107A1();
  level.player getweaponweight(self.func_AD34, "tag_origin", 0);
  wait 0.05;
  level.player getweightedchanceroll(self.func_AD34, "tag_origin", 1, 40, 40, 20, 15, 1);
  level.player giveplayerscore(1, 2.2, 0.6);
  func_5681( % jackal_pilot_dismount_01_port, % jackal_vehicle_dismount_01_port, "player_dismount");
  func_569D();
  return "landed_mode";
}

func_56A0() {
  level notify("dismount_shipcrib_moon");
  level waittill("dismount_shipcrib_moon_complete");
  self.func_99F5.func_BBF1 = 0;
  return "landed_mode";
}

func_569F() {
  level notify("dismount_shipcrib_gravity");
  level waittill("dismount_shipcrib_gravity_complete");
  self.func_99F5.func_BBF1 = 0;
  return "landed_mode";
}

func_568E() {
  func_F919(0);
  func_0BDC::func_A2DE(1, 0);
  return "landed_mode";
}

func_5681(var_00, var_01, var_02) {
  var_03 = getanimlength(var_00);
  var_04 = 0.2;
  func_0BDC::func_A2DE(1, var_04);
  self setanimknob(var_00, 1, var_04);
  self give_attacker_kill_rewards(var_01, 1, var_04);

  if(isDefined(var_02)) {
    self _meth_82B1(var_00, 0);
    self _meth_82B1(var_01, 0);
    self waittill(var_02);
    self setanimknob(var_00, 1, 0.2, 1);
    self give_attacker_kill_rewards(var_01, 1, 0.2, 1);
  }

  thread func_1EC6(var_00, "hud_off", func_0BDC::func_A226);
  thread func_1EC6(var_00, "ps_plr_foley_exit_jackal", ::func_A2C1);
  thread func_1EC6(var_00, "ps_plr_foley_exit_jackal_cockpit_lr", ::func_A2C2);
  thread func_1EC6(var_00, "lights_off", ::func_BBDF);
  thread func_1EC6(var_00, "screens_off", func_0BDC::func_A10F);
  thread func_1EC6(var_00, "engine_off", ::func_568F);
  thread func_1EC6(var_00, "swap_jackal_model", ::func_A330, 4);
  wait(var_03);
  self give_attacker_kill_rewards(var_00, 0, 0.2);
  self give_attacker_kill_rewards(var_01, 0, 0.2);
}

func_5682(var_00, var_01, var_02) {
  var_03 = getanimlength(var_00);
  var_04 = 0.2;
  func_0BDC::func_A2DE(1, var_04);
  self setanimknob(var_00, 1, var_04);
  self give_attacker_kill_rewards(var_01, 1, var_04);

  if(isDefined(var_02)) {
    self _meth_82B1(var_00, 0);
    self _meth_82B1(var_01, 0);
    self waittill(var_02);
    self setanimknob(var_00, 1, 0.2, 1);
    self give_attacker_kill_rewards(var_01, 1, 0.2, 1);
  }

  thread func_1EC6(var_00, "screens_off", func_0BDC::func_A10F);
  thread func_1EC6(var_00, "hud_off", func_0BDC::func_A226);
  thread func_1EC6(var_00, "lights_off", ::func_BBDF);
  thread func_1EC6(var_00, "engine_off", ::func_568F);
  thread func_1EC6(var_01, "decomp_fx", ::func_5689);
  thread func_1EC6(var_00, "swap_jackal_model", ::func_A32A, 0.05);
  thread func_1EC6(var_00, "gun_up", ::func_568A);
  thread func_A1B6();
  thread func_A1B5();
  func_88C8(level.player, self, 0.005, var_03);
  self give_attacker_kill_rewards(var_00, 0, 0.2);
  self give_attacker_kill_rewards(var_01, 0, 0.2);
}

func_88C8(var_00, var_01, var_02, var_03, var_04) {
  var_00 _meth_8239(1);

  if(isDefined(var_03))
    wait(var_03);
  else if(scripts\engine\utility::is_true(var_04))
    var_01 waittillmatch("single anim", "end");
  else
    var_01 waittill("movedone");

  var_05 = var_00 getvelocity();
  var_06 = vectornormalize(var_05);
  var_07 = length(var_05);

  if(!isDefined(var_02))
    var_02 = 200;

  var_08 = var_07 / var_02;
  var_09 = var_08;
  var_10 = var_07 * var_09 * 0.5;
  var_11 = var_0.origin + var_10 * var_06;
  var_06 = vectornormalize(var_11 - var_0.origin);
  var_00 unlink();
  var_00 giveflagcapturexp(var_06 / var_02);
  thread func_88B2();
}

func_88B2() {
  func_12975();
  wait 2;
  func_12994();
}

func_12975() {
  _setsaveddvar("bg_viewBobAmplitudeStanding", 0.0);
  _setsaveddvar("bg_weaponBobAmplitudeStanding", 0.0);
}

func_12994() {
  _setsaveddvar("bg_viewBobAmplitudeStanding", 0.007);
  _setsaveddvar("bg_weaponBobAmplitudeStanding", 0.007);
}

func_5689() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_cockpit_decomp"), self, "tag_body");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_cockpit_canopy"), self, "j_canopy");
}

func_568F(var_00) {
  level.player playrumbleonentity("damage_light");
  earthquake(0.15, 0.5, level.func_D127.origin, 5000);
}

func_A2F2(var_00, var_01) {
  if(isDefined(var_00)) {
    if(var_00 == "right")
      var_02 = self.func_E8CB;
    else
      var_02 = self.func_E8AD;
  } else
    var_02 = self.func_E8AD;

  scripts\engine\utility::flag_set("jackal_runway_landing_active");
  scripts\engine\utility::flag_set("jackal_runway_first_attempt");
  scripts\engine\utility::flag_clear("jackal_sees_ret_for_landing");

  if(!scripts\engine\utility::flag_exist("flag_landing_reapproach"))
    scripts\engine\utility::flag_init("flag_landing_reapproach");
  else
    scripts\engine\utility::flag_clear("flag_landing_reapproach");

  wait 3;
  thread func_E3E0();

  if(!isDefined(var_01))
    thread func_E3ED();

  scripts\engine\utility::flag_waitopen("jackal_missile_drone_active");
  func_0BD6::disable_missile_drone_event();
  var_02 func_3AC2();
  var_02 thread func_3AE6(var_01);
  var_02 thread func_3AE8(var_01);
  var_02 thread func_3AE5();
  var_02 func_3AD8(var_01);
}

func_A7EB() {
  level endon("stop_landing_hint");

  for(;;) {
    if(length(level.func_D127.spaceship_vel) < 15)
      func_A7ED();
    else if(func_0B76::func_7A60(self.origin) < 0.3)
      func_A7ED();
    else if(scripts\engine\utility::flag("jackal_hint_ret_return"))
      func_A7EC();

    wait 0.05;
  }
}

func_A7ED() {
  if(!scripts\engine\utility::flag("jackal_hint_ret_return")) {
    scripts\engine\utility::flag_set("jackal_hint_ret_return");
    scripts\sp\utility::func_56BA("jackal_return_to_ret");
  }
}

func_A7EC() {
  scripts\engine\utility::flag_clear("jackal_hint_ret_return");
  wait 3;
}

func_A7EE() {
  level notify("stop_landing_hint");
  scripts\engine\utility::flag_clear("jackal_hint_ret_return");
}

func_DDA4() {
  level endon("stop_reapproach_hint");

  for(;;) {
    if(length(level.func_D127.spaceship_vel) < 15)
      func_DDA6();
    else if(func_0B76::func_7A60(self.origin) < 0.3)
      func_DDA6();
    else if(scripts\engine\utility::flag("jackal_hint_ret_reapproach"))
      func_DDA5();

    wait 0.05;
  }
}

func_DDA6() {
  if(!scripts\engine\utility::flag("jackal_hint_ret_reapproach")) {
    scripts\engine\utility::flag_set("jackal_hint_ret_reapproach");

    if(scripts\engine\utility::flag("jackal_runway_first_attempt"))
      scripts\sp\utility::func_56BA("jackal_hint_ret_approach");
    else
      scripts\sp\utility::func_56BA("jackal_hint_ret_reapproach");
  }
}

func_DDA5() {
  scripts\engine\utility::flag_clear("jackal_hint_ret_reapproach");
  wait 3;
}

func_DDA7() {
  level notify("stop_reapproach_hint");
  scripts\engine\utility::flag_clear("jackal_hint_ret_reapproach");
}

func_A2F1(var_00) {
  if(isDefined(var_00)) {
    if(var_00 == "right")
      var_01 = self.func_E8CB;
    else
      var_01 = self.func_E8AD;
  } else
    var_01 = self.func_E8AD;

  level notify("notify_stop_runway_landing");
  scripts\engine\utility::flag_clear("jackal_runway_landing_active");
  func_A7EE();
  func_DDA7();
  var_02 = var_1.func_102D1.func_5BD7;
  var_02 linkto(self);
  var_02 func_0BD6::func_5C95();
  var_01 thread func_3AC4();
  var_01 func_3AD4(1);
  func_D17B();
  var_01 func_E8D0();
  var_1.func_5BD7 = var_02;
  var_1.func_4074 = scripts\engine\utility::array_remove(var_1.func_4074, var_02);
  level notify("stop_spline_think");

  foreach(var_04 in var_1.func_4074) {
    if(isDefined(var_04))
      var_04 delete();

    var_1.func_4074 = scripts\engine\utility::array_remove(var_1.func_4074, var_04);
  }

  var_1.func_4074 = scripts\engine\utility::array_add(var_1.func_4074, var_02);
}

func_E3ED(var_00) {
  level endon("notify_stop_runway_landing");
  var_01 = 12000;
  var_02 = 25000;
  var_03 = 0.018;
  self.func_B3D5 = 0.0;

  if(!isDefined(self.func_E708))
    self.func_E708 = 1;

  if(!isDefined(self.func_EBA9))
    self.func_EBA9 = 1;

  self.func_EBA9 = clamp(self.func_EBA9, 0, 1);
  self.func_E708 = clamp(self.func_E708, 0, 1);
  thread func_E3EC();
  var_04 = 8;
  var_05 = -3;
  var_06 = -20 * self.func_EBA9 + var_04 * (1 - self.func_EBA9);
  var_07 = 10 * self.func_EBA9 + var_04 * (1 - self.func_EBA9);
  var_08 = 20 * self.func_EBA9 + var_04 * (1 - self.func_EBA9);
  var_09 = -15 * self.func_EBA9 + var_04 * (1 - self.func_EBA9);
  var_10 = 35000;
  var_11 = -30000;

  for(;;) {
    if(scripts\engine\utility::flag_exist("flag_no_ret_land_rotation") && scripts\engine\utility::flag("flag_no_ret_land_rotation")) {
      wait 0.05;
      continue;
    }

    var_12 = level.func_D127.origin - self.origin;
    var_13 = length(var_12);
    var_14 = vectornormalize(var_12);
    var_15 = -30;
    var_16 = rotatevector(var_14, (0, var_15, 0));
    var_17 = rotatevector(var_14, (0, var_15 - 90, 0));
    var_18 = (0, 0, 1);
    var_19 = self.origin;
    var_20 = _axistoangles(var_16, var_17, var_18);
    var_21 = level.func_D127.origin[2] - self.origin[2];

    if(var_21 > 0) {
      var_22 = scripts\sp\math::func_C097(0, var_10, var_21);
      var_23 = var_06;
      var_24 = var_07;
    } else {
      var_22 = 1 - scripts\sp\math::func_C097(var_11, 0, var_21);
      var_23 = var_08;
      var_24 = var_09;
    }

    var_22 = scripts\sp\math::func_C09B(var_22);
    var_25 = scripts\sp\math::func_6A8E(var_04, var_23, var_22);
    var_26 = scripts\sp\math::func_6A8E(var_05, var_24, var_22);

    if(isDefined(self.func_B74F))
      var_27 = clamp(var_20[1], self.func_B74F, self.func_B455);
    else
      var_27 = var_20[1];

    var_20 = (var_25, var_27, var_26);
    var_28 = anglesToForward(self.angles);
    var_29 = anglestoright(self.angles);
    var_30 = anglestoup(self.angles);
    var_31 = anglesToForward(var_20);
    var_26 = anglestoright(var_20);
    var_32 = anglestoup(var_20);
    var_33 = scripts\sp\math::func_C097(var_01, var_02, var_13);
    var_34 = scripts\sp\math::func_6A8E(0, var_03, var_33);
    var_16 = vectornormalize(scripts\sp\math::func_AB6F(var_28, var_31, var_34 * self.func_B3D5 * self.func_E708));
    var_17 = vectornormalize(scripts\sp\math::func_AB6F(var_29, var_26, var_34 * self.func_B3D5 * self.func_E708));
    var_18 = vectornormalize(scripts\sp\math::func_AB6F(var_30, var_32, var_34 * self.func_B3D5 * self.func_E708));
    var_20 = _axistoangles(var_16, var_17, var_18);
    var_23 = 30;
    var_24 = 20;

    if(var_20[0] > 180)
      var_35 = clamp(var_20[0], 360 - var_23, 360);
    else
      var_35 = clamp(var_20[0], 0, var_23);

    var_36 = clamp(var_20[2], -1 * var_24, var_24);
    var_20 = (var_35, var_20[1], var_36);
    self.angles = var_20;
    wait 0.05;
  }
}

func_E3EC() {
  level endon("notify_stop_runway_landing");
  var_00 = 7.0;
  var_01 = 0;

  while(var_01 < var_00) {
    self.func_B3D5 = var_01 / var_00;
    var_01 = var_01 + 0.05;
    wait 0.05;
  }

  self.func_B3D5 = 1;
}

func_E3E0() {
  if(!isDefined(self.script_team))
    self.script_team = "allies";

  if(!isDefined(self.func_AEDF))
    func_0BDC::func_105DB("capitalship", "JACKAL_RETRIBUTION", "none", "none", 0);

  self.func_AEDF.func_3A5C = "ally_objective";
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);
  func_0BDC::func_1378D(0.9);
  scripts\engine\utility::flag_clear("jackal_hint_ret_return");
  self.func_AEDF.func_3A5C = "none";
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);
  func_0B76::func_39C3(3);
  wait 1.2;
  scripts\engine\utility::flag_set("jackal_sees_ret_for_landing");
}

func_3C3F(var_00) {
  if(self.func_AB5E == var_00) {
    return;
  }
  self.func_AB5E = var_00;
  func_3AE2();
  thread func_3AC7(1);
}

func_3AE2() {
  if(self.func_AB5E == 3)
    var_00 = 27;
  else if(self.func_AB5E == 2)
    var_00 = 22;
  else if(self.func_AB5E == 1)
    var_00 = 17;
  else
    var_00 = 12;

  self.func_C28D linkto(self.segments[var_00], "tag_origin", (0, 0, 0), (0, 0, 0));
}

func_3AC2() {
  self.func_4074 = [];
  self.func_11A2A = 28;
  self.func_56E9 = 500;
  self.func_AB5E = func_E8B2();

  if(isDefined(self.func_E311))
    self.func_E311.parent = self;

  self.func_5C6B = scripts\engine\utility::getclosest(self.origin, self.func_5C6C);
  func_3ADE(self.func_11A2A);
  self.func_C28D = scripts\engine\utility::spawn_tag_origin();
  self.func_C28D func_0BDC::func_105DB("missile", undefined, "none", undefined, 0, undefined, 1);
  func_3AE2();
  self.func_DDA8 = scripts\engine\utility::spawn_tag_origin();
  self.func_DDA8 func_0BDC::func_105DB("missile", undefined, "none", undefined, 0, undefined, 1);
  self.func_DDA8 linkto(self.segments[0], "tag_origin", (15000, 1500, 2000), (0, 0, 0));
  self.func_A70D = 6;
  self.func_A70C = self.func_11A2A;
  var_00 = (-0, 0, 0);
  self.segments[0].origin = self.origin;
  self.segments[0].angles = self.angles + var_00;
  self.segments[0] linkto(self);

  for(var_01 = 1; var_01 < self.func_A70D; var_1++) {
    self.segments[var_01].origin = self.segments[var_01 - 1].origin + anglesToForward(self.segments[var_01 - 1].angles) * self.func_56E9;
    self.segments[var_01].angles = self.angles + var_00;
  }

  for(var_01 = 1; var_01 < self.func_11A2A; var_1++) {
    self.segments[var_01].parent = self.segments[var_01 - 1];
    self.segments[var_01] linkto(self.segments[var_01].func_AD34);
  }

  func_3AE3();
  func_3AB6();
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_C28D);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_DDA8);
}

func_3AE8(var_00) {
  level endon("notify_player_landed");
  level endon("stop_spline_think");
  var_01 = 100;
  var_02 = (self.func_11A2A - self.func_A70D) * self.func_56E9;
  var_03 = 1;
  var_04 = self.func_A70C;
  var_05 = self.segments[0];
  var_06 = -100;
  var_07 = 1;

  for(;;) {
    if(scripts\engine\utility::flag("flag_landing_reapproach"))
      var_08 = -0.007;
    else
      var_08 = 0.007;

    var_07 = var_07 + var_08;
    var_07 = clamp(var_07, 0, 1);
    var_09 = self.func_DDA8.origin;
    var_10 = self.func_DDA8.angles;
    var_11 = anglesToForward(var_10);
    var_12 = anglestoright(var_10);
    var_13 = anglestoup(var_10);
    var_14 = level.func_D127 gettagorigin("j_mainroot_ship") + anglestoup(level.func_D127 gettagangles("j_mainroot_ship")) * var_06;
    var_15 = level.func_D127.angles;
    var_16 = anglesToForward(var_15);
    var_17 = anglestoright(var_15);
    var_18 = anglestoup(var_15);
    var_19 = scripts\sp\math::func_6A8E(var_11, var_16, var_07);
    var_20 = scripts\sp\math::func_6A8E(var_12, var_17, var_07);
    var_21 = scripts\sp\math::func_6A8E(var_13, var_18, var_07);
    var_22 = scripts\sp\math::func_6A8E(var_09, var_14, var_07);
    var_23 = _axistoangles(var_19, var_20, var_21);

    if(!var_03) {
      if(length(self.segments[var_04 - 1].origin - var_22) < self.func_56E9)
        var_04 = var_04 - 1;
      else if(length(self.segments[var_04 - 1].origin - var_22) > 2 * self.func_56E9) {
        if(var_04 < self.func_11A2A - 1)
          var_04 = var_04 + 1;
      }

      if(var_04 < self.func_A70D)
        var_04 = self.func_A70D;
    }

    var_24 = self.segments[self.func_A70D].origin;
    var_25 = self.segments[self.func_11A2A - 1].origin;
    wait 0.05;
    var_5.func_56EA = distance(var_22, var_5.origin);
    var_26 = vectordot(vectornormalize(var_5.origin - var_22), anglesToForward(var_23));
    var_27 = vectornormalize(var_22 - var_25);
    var_28 = length(var_22 - var_24);
    var_29 = rotatevectorinverted(var_22 - var_5.origin, var_5.angles);

    if(var_29[2] < var_01)
      var_29 = (var_29[0], var_29[1], var_01);

    var_30 = var_5.origin + rotatevector(var_29, var_5.angles);
    var_5.func_20E7 = vectordot(anglesToForward(var_5.angles), -1 * anglesToForward(var_23));
    var_31 = scripts\sp\math::func_C097(-1.0, 0.0, var_5.func_20E7);
    var_31 = scripts\sp\math::func_6A8E(0.2, 1, var_31);

    for(var_32 = self.func_A70D; var_32 < self.func_11A2A; var_32++) {
      self.segments[var_32] unlink();
      self.segments[var_32].origin = self.segments[var_32].parent.origin + anglesToForward(self.segments[var_32].parent.angles) * self.func_56E9;
      self.segments[var_32] func_3AE7(var_23, var_30, var_23, var_05, var_32, self.func_A70C - 1, self.func_A70D, var_31, var_04);
      self.segments[var_32] linkto(self.segments[var_32].func_AD34);
    }

    level notify("notify_spline_update");
    var_03 = 0;
  }
}

func_3AE6(var_00) {
  if(isDefined(var_00)) {
    return;
  }
  level endon("notify_stop_runway_landing");
  var_01 = 1;

  for(;;) {
    var_02 = pointonsegmentnearesttopoint(self.origin, self.origin + anglesToForward(self.angles) * 3000, level.func_D127.origin);
    var_03 = distance(level.func_D127.origin, var_02);
    var_04 = "runway_landing";
    var_05 = scripts\sp\math::func_C097(0, 25000, var_03);
    var_05 = scripts\sp\math::func_C09A(var_05);
    var_06 = scripts\sp\math::func_6A8E(0.17, 1, var_05);
    var_07 = 1;

    foreach(var_10, var_09 in level.func_A056.func_BBB9["speed"].func_3C66) {
      if(var_10 != var_04)
        var_07 = var_07 * var_09;
    }

    if(var_07 == 0) {} else
      var_01 = 1 / var_07;

    if(var_07 < var_06)
      var_11 = 1;
    else
      var_11 = var_01 * var_06;

    func_0BDC::func_A301(var_11, 0.05, "runway_landing");
    wait 0.05;
  }
}

func_3AE5() {
  level endon("jackal_taxi_complete");
  level endon("notify_stop_runway_landing");
  self.func_102D1 ghostattack(0, 0);
  var_00 = 0;
  var_01 = 1.0;
  var_02 = 0;
  self.func_102D1 playLoopSound("landing_drone_sled_lp");

  for(;;) {
    if(self.func_102D1.active && !func_3AE1()) {
      var_03 = distance(self.origin, level.func_D127.origin);
      var_04 = 2900;
      var_05 = scripts\sp\math::func_C097(self.func_102D1.func_B740, self.func_102D1.func_B42D + var_04, var_03);
      var_06 = scripts\sp\math::func_6A8E(self.func_102D1.func_B740, self.func_102D1.func_B42D, var_05);
      var_07 = self.origin + anglesToForward(self.angles) * var_06;
      var_04 = (var_07 - self.func_102D1.origin) * self.func_102D1.func_AB99;
      var_08 = length(var_04);

      if(var_08 > var_01 && !self.func_102D1.func_5BD7.active) {
        if(!var_00) {
          var_00 = 1;
          thread func_0BDC::func_D527("landing_drone_sled_start", self.func_102D1.origin, 1, 0.7);
        }

        if(!var_02) {
          self.func_102D1.func_5BD7 func_0BD6::func_5C96();
          var_02 = 1;
        }

        var_09 = scripts\sp\math::func_C097(0, 30, var_08);
        var_10 = scripts\sp\math::func_6A8E(0.5, 1.8, var_09);
        var_11 = scripts\sp\math::func_6A8E(0.2, 0.4, var_09);
        self.func_102D1 ghostattack(var_10, 0.05);
        self.func_102D1 _meth_8277(var_11, 0.05);
      } else if(var_00) {
        self.func_102D1 ghostattack(0, 0.5);
        var_00 = 0;
      }

      self.func_102D1.origin = self.func_102D1.origin + var_04;
      self.func_102D1.angles = self.angles;
    } else {
      self.func_102D1.origin = self.origin + anglesToForward(self.angles) * self.func_102D1.func_B42D;
      self.func_102D1.angles = self.angles;

      if(var_00) {
        self.func_102D1 ghostattack(0, 0.5);
        var_00 = 0;
      }

      if(var_02) {
        self.func_102D1.func_5BD7 func_0BD6::func_5C95();
        var_02 = 0;
      }
    }

    wait 0.05;
  }
}

func_3AD8(var_00) {
  level endon("notify_stop_runway_landing");
  level notify("notify_restart_landing progress");
  level.func_D127 notify("notify_restart_landing");
  level endon("notify_restart_landing progress");

  if(!isDefined(var_00))
    func_0BDC::func_A2FC(0.75, 0, "landing");

  func_3ADB();
  func_3AD0();
  thread func_3AE9();
  thread func_D17A(var_00);
  var_01 = 1;

  if(self.func_AB5E == 3) {
    var_01 = func_3AD7(28, var_00);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  if(self.func_AB5E >= 2) {
    var_01 = func_3AD7(23, var_00);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  if(self.func_AB5E >= 1) {
    var_01 = func_3AD7(18, var_00);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  func_3AD2(var_00);

  if(self.func_AB5E == 0) {
    var_01 = func_3AD7(13, var_00);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  if(func_3AE1()) {
    return;
  }
  if(!var_01 && !isDefined(var_00)) {
    func_3AD9();
    wait 1;
  }

  func_3AD1(var_00);
  scripts\engine\utility::flag_set("player_jackal_drone_dock");
  level notify("notify_player_landed");
  func_A7EE();
  func_3AD6(var_00);
}

func_3AE9() {
  level endon("jackal_taxi_complete");
  level endon("notify_stop_runway_landing");

  for(;;) {
    self.func_12713 waittill("trigger", var_00);

    if(!isDefined(level.func_D127) || !isDefined(var_00) || var_00 != level.func_D127) {
      continue;
    }
    scripts\engine\utility::flag_set("flag_player_on_runway");

    while(isalive(var_00) && isDefined(self.func_12713) && var_00 istouching(self.func_12713) && isDefined(level.func_D127))
      wait 0.05;

    scripts\engine\utility::flag_clear("flag_player_on_runway");
  }
}

func_3AE1() {
  if(scripts\engine\utility::flag_exist("flag_scipted_jackal_landing") && scripts\engine\utility::flag("flag_scipted_jackal_landing"))
    return 1;
  else
    return 0;
}

func_3ADB() {
  level endon("notify_stop_runway_landing");
  self.func_DDA8 thread func_DDA4();

  for(;;) {
    var_00 = distance(self.func_DDA8.origin, self.origin);
    var_01 = level.func_D127.origin - self.origin;
    var_02 = rotatevectorinverted(var_01, self.angles);
    var_03 = var_2[0];

    if(var_03 > var_00 - 5000) {
      break;
    }
    if(!scripts\engine\utility::flag("flag_landing_reapproach") && scripts\engine\utility::flag("jackal_sees_ret_for_landing")) {
      scripts\engine\utility::flag_set("flag_landing_reapproach");
      self.func_DDA8 func_0B76::func_F42C("ally_objective");
    }

    wait 0.05;
  }

  if(scripts\engine\utility::flag("flag_landing_reapproach")) {
    scripts\engine\utility::flag_clear("flag_landing_reapproach");
    self.func_DDA8 func_0B76::func_F42C("none");
  }

  scripts\engine\utility::flag_clear("jackal_runway_first_attempt");
  func_DDA7();
}

func_3AD0() {
  level endon("notify_restart_landing progress");
  wait 0.1;
  var_00 = 0;
  self.func_C28D thread func_A7EB();

  if(self.func_AB5E == 3) {
    var_01 = 22000;
    var_02 = 22000;
    var_03 = 17000;
  } else if(self.func_AB5E == 2) {
    var_01 = 17000;
    var_02 = 17000;
    var_03 = 13000;
  } else if(self.func_AB5E == 1) {
    var_01 = 12000;
    var_02 = 12000;
    var_03 = 8000;
  } else {
    var_01 = 12000;
    var_02 = 12000;
    var_03 = 7000;
  }

  for(;;) {
    var_04 = length(self.origin - level.func_D127.origin);
    var_05 = vectordot(vectornormalize(self.segments[15].origin - level.func_D127.origin), anglesToForward(level.func_D127.angles));
    var_06 = vectordot(anglesToForward(self.segments[15].angles), vectornormalize(level.func_D127.origin - self.segments[15].origin));

    if(var_04 < var_01 && var_05 > 0.92) {
      if(var_00) {
        self.func_C28D func_0B76::func_F42C("none");
        var_00 = 0;
      }
    } else if(!var_00 && scripts\engine\utility::flag("jackal_sees_ret_for_landing")) {
      self.func_C28D func_0B76::func_F42C("ally_objective");
      var_00 = 1;
    }

    if(var_04 < var_02 && var_05 > 0.95) {
      break;
    }
    if(var_04 < var_03) {
      if(var_06 < 0.95) {
        if(var_00)
          self.func_C28D func_0B76::func_F42C("none");

        func_3AD9();
      }

      if(var_05 < 0.7) {
        if(var_00)
          self.func_C28D func_0B76::func_F42C("none");

        func_3AD9();
      }
    }

    wait 0.05;
  }

  if(var_00)
    self.func_C28D func_0B76::func_F42C("none");

  func_A7EE();
}

func_3AD2(var_00) {
  self.func_102D1.active = 1;

  if(!isDefined(var_00)) {
    func_0BDC::func_D165(self.func_6C1E, 1.0, 3.0, 6.0);
    func_0BDC::func_D16C(self.func_102D1.func_20F1, 1.0, 3.0, 6.0);
  }
}

func_3AD4(var_00) {
  self.func_102D1.active = 0;

  if(isDefined(var_00)) {
    func_0BDC::func_D165(self.func_6C1E, 0.0, 1.0, 0.0);
    func_0BDC::func_D16C(self.func_102D1.func_20F1, 0.0, 1.0, 0.0);
  }
}

func_3AD1(var_00) {
  level endon("notify_stop_runway_landing");
  level endon("notify_restart_landing progress");
  thread func_3AE4();
  thread func_3AC6();
  func_3AD3();
  func_3ADF(7500);

  while(scripts\engine\utility::flag("jackal_landing_never_launch_drone"))
    wait 0.05;

  func_0BD6::func_5BFC(var_00);
  func_0BD6::func_5BE2(var_00);
}

func_3ADF(var_00) {
  var_01 = 99999999;

  while(var_01 > var_00) {
    var_01 = distance(level.func_D127.origin, self.func_6C1E.origin);
    wait 0.05;
  }
}

func_3AD6(var_00) {
  wait 0.5;
  thread func_3ACF(var_00);
  func_3ADC(var_00);
  thread func_3ACE();
  thread func_3ACA(var_00);
  thread func_3AE0();
  level waittill("jackal_taxi_complete");
  thread func_3ACB();
  self.func_102D1.func_5BD7 thread func_0BD6::func_685D();
  func_0BD6::func_5C40(var_00);
}

func_3ACA(var_00) {
  thread func_3ACD(var_00);
  thread func_3ACC(var_00);
}

func_3ACD(var_00) {
  var_01 = 999999;

  while(var_01 > 650) {
    if(!isDefined(var_00))
      var_01 = distance(self.func_11593.origin, self.func_6C1E.origin);
    else
      var_01 = distance(level.func_D127.origin, self.func_6C1E.origin);

    wait 0.05;
  }

  var_02 = 3.5;

  if(isDefined(level.func_A056.func_A7EA))
    var_03 = level.func_A056.func_A7EA;
  else
    var_03 = "jackal_landing_default";

  visionsetnaked(var_03, var_02);
}

func_3ACE() {
  func_0BDC::func_A226(1);
}

func_3ACC(var_00) {
  var_01 = 999999;

  while(var_01 > 1300) {
    if(!isDefined(var_00))
      var_01 = distance(self.func_11593.origin, self.func_6C1E.origin);
    else
      var_01 = distance(level.func_D127.origin, self.func_6C1E.origin);

    wait 0.05;
  }

  var_02 = 2.0;
  thread func_AB9F(var_02);
  thread func_AB80(var_02);
}

#using_animtree("script_model");

func_3ACB() {
  if(self.func_2AD8.size == 0 || self.func_2ADB.size == 0) {
    return;
  }
  foreach(var_01 in self.func_2AD8) {
    var_1.func_C385 = var_01 _meth_8134();
    var_01 thread scripts\sp\lights::func_AB83(0.2, 0.2);
    var_01 scripts\engine\utility::delaythread(1, scripts\sp\lights::func_AB83, var_1.func_C385, 7);
  }

  foreach(var_01 in self.func_2ADA) {
    var_01 scripts\sp\utility::func_65E0("light_pulsing");
    var_01 scripts\sp\utility::func_65E1("light_pulsing");
    var_01 thread func_3AC1();
  }

  foreach(var_01 in self.func_2ADA)
  var_01 scripts\sp\utility::func_65E8("light_pulsing");

  foreach(var_08 in self.func_2ADB) {
    var_08 show();
    var_8.func_A6EC hide();

    foreach(var_01 in var_8.lights) {
      var_01 _meth_82FC((1, 0.085294, 0.03137));
      var_01 thread scripts\sp\lights::func_AB83(var_1.script_intensity_01, 1);
    }

    var_08 give_attacker_kill_rewards( % claxon_spin_loop);
  }
}

func_3AC1() {
  var_00 = self _meth_8134();
  var_01 = 90;
  var_02 = self getspawnpoint();
  var_03 = var_02 * 2;
  var_04 = 0.2;
  var_05 = 0.5;
  var_06 = 0.3;
  var_07 = 0.5;
  func_3AB1(var_01, var_03, var_04);
  wait(var_06);
  func_3AB1(var_00, var_02, var_05);
  wait(var_07);
  func_3AB1(var_01, var_03, var_04);
  wait(var_06);
  func_3AB1(var_00, var_02, var_05);
  scripts\sp\utility::func_65DD("light_pulsing");
}

func_3AB1(var_00, var_01, var_02) {
  var_03 = self _meth_8134();
  var_04 = self getspawnpoint();
  var_05 = int(var_02 * 20);
  var_06 = (var_01 - var_04) / var_05;
  var_07 = (var_00 - var_03) / var_05;

  for(var_08 = 0; var_08 < var_05; var_8++) {
    self setlightintensity(var_03 + var_08 * var_07);
    self give_player_explosive_armor(var_04 + var_08 * var_06);
    wait 0.05;
  }

  self setlightintensity(var_00);
  self give_player_explosive_armor(var_01);
}

func_3AE0() {
  var_00 = 999999;

  while(var_00 > 1000) {
    var_00 = distance(self.func_11593.origin, self.func_6C1E.origin);
    wait 0.05;
  }

  func_0BDC::func_A38E(0, undefined, undefined, 6);
}

func_AB9F(var_00) {
  var_01 = int(var_00 * 20);

  if(isDefined(level.func_111D0) && isDefined(level.func_111D0.func_99E5))
    var_02 = level.func_111D0.func_99E5;
  else {
    var_02 = _getmapsuncolorandintensity();
    var_02 = var_2[3];
  }

  var_03 = (0 - var_02) / var_01;

  for(var_04 = 0; var_04 < var_01; var_4++) {
    var_05 = var_02 + var_04 * var_03;
    _setsuncolorandintensity(var_05);

    if(isDefined(level.func_111D0) && isDefined(level.func_111D0.func_99E5))
      level.func_111D0.func_99E5 = var_05;

    wait 0.05;
  }

  if(isDefined(level.func_111D0) && isDefined(level.func_111D0.func_99E5))
    level.func_111D0.func_99E5 = 0;

  _setsuncolorandintensity(0);
}

func_AB80(var_00) {
  foreach(var_02 in level.func_A056.func_A7E8)
  var_02 thread scripts\sp\lights::func_AB83(0, var_00);
}

func_3AD9(var_00) {
  scripts\engine\utility::flag_clear("jackal_landing_active");
  _killfxontag(scripts\engine\utility::getfx("jackal_runway_hoop"), self.func_102D1, "tag_origin");

  if(self.func_102D1.func_5BD7.active)
    thread func_5BFA();

  thread func_3ADA();
  thread func_3AC4();
  thread func_D17B();
  func_3AD4(1);
  var_01 = func_E8B2();
  func_3C3F(var_01);
  thread func_3AD8();
}

func_E8B2() {
  var_00 = level.func_D127.origin - self.origin;
  var_01 = rotatevectorinverted(var_00, self.angles);
  var_02 = var_1[0];

  if(var_02 > 25000)
    return 3;
  else if(var_02 > 20000)
    return 2;
  else if(var_02 > 15000)
    return 1;
  else
    return 0;
}

func_3ADA() {
  level.player playSound("landing_hoop_fail");
}

func_3AE4() {
  level endon("notify_player_landed");
  level endon("notify_restart_landing progress");
  var_00 = 0;

  for(;;) {
    level waittill("notify_spline_update");
    var_01 = self.func_6C1E.origin - level.func_D127.origin;
    var_02 = length(self.origin - level.func_D127.origin);
    var_03 = vectordot(anglesToForward(level.func_D127.angles), vectornormalize(var_01));

    if(scripts\engine\utility::flag("flag_player_on_runway") && !var_00)
      var_00 = 1;

    var_04 = scripts\sp\math::func_C097(5000, 9500, var_02);
    var_05 = scripts\sp\math::func_6A8E(0.97, 0.82, var_04);

    if(var_03 < var_05) {
      func_3AD9("dot");
      continue;
    }

    if(var_00 && !scripts\engine\utility::flag("flag_player_on_runway"))
      func_3AD9("flag");
  }
}

func_2F16() {
  self endon("entitydeleted");

  for(;;)
    wait 0.05;
}

func_3AD3() {
  level endon("notify_restart_landing progress");
  level.player playSound("landing_hoop_active");
  playFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), self.func_102D1, "tag_origin");
}

func_3AD7(var_00, var_01) {
  var_02 = self.segments[var_00 - 1];
  var_03 = self.segments[var_00 - 3];
  playFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), var_02, "tag_origin");
  level.player playSound("landing_hoop_active");
  var_04 = 1000;
  level notify("landing_hoop_active");

  for(;;) {
    level waittill("notify_spline_update");
    var_05 = vectornormalize(var_3.origin - level.func_D127.origin);
    var_06 = anglesToForward(level.func_D127.angles);
    var_07 = vectordot(var_05, var_06);

    if(var_07 < 0.6 && !isDefined(var_01)) {
      stopFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), var_02, "tag_origin");
      func_3AD9();
    }

    var_08 = var_2.origin + anglestoup(var_2.angles) * 75;
    var_09 = var_08 + anglesToForward(var_2.angles) * 2000;
    var_10 = pointonsegmentnearesttopoint(var_08, var_09, level.func_D127.origin);
    var_11 = distance(var_08, var_10);

    if(var_11 < var_04) {
      break;
    }
  }

  stopFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), var_02, "tag_origin");
  var_12 = var_08 + anglesToForward(var_2.angles) * var_04;
  var_13 = distance(level.func_D127.origin, var_12);

  if(var_13 < 250) {
    level.player playSound("landing_hoop_success");
    return 1;
  } else {
    level.player playSound("landing_hoop_fail");
    return 0;
  }
}

func_3AC7(var_00) {
  var_01 = self.segments;
  level notify("stop_jackal_landing_segments");
  level endon("stop_jackal_landing_segments");
  var_02 = 27;
  var_03 = var_02;
  var_04 = undefined;

  if(self.func_AB5E == 3)
    var_04 = 27;
  else if(self.func_AB5E == 2)
    var_04 = 22;
  else if(self.func_AB5E == 1)
    var_04 = 17;
  else if(self.func_AB5E == 0)
    var_04 = 12;
  else {}

  var_05 = 12;

  if(var_00) {
    while(var_02 >= 0) {
      if(isDefined(var_1[var_02].func_22F9))
        _killfxontag(scripts\engine\utility::getfx(var_1[var_02].func_22F9), var_1[var_02].func_7601, "tag_origin");

      if(var_02 > var_05 && var_02 <= var_04)
        var_1[var_02].func_22F9 = "jackal_runway_arrows";
      else if(var_02 == var_05 && var_02 <= var_04)
        var_1[var_02].func_22F9 = "jackal_runway_arrow_end";
      else
        var_1[var_02].func_22F9 = undefined;

      if(isDefined(var_1[var_02].func_22F9))
        playFXOnTag(scripts\engine\utility::getfx(var_1[var_02].func_22F9), var_1[var_02].func_7601, "tag_origin");

      var_2--;
    }
  } else {
    foreach(var_07 in var_01) {
      if(isDefined(var_1[var_02].func_22F9))
        _killfxontag(scripts\engine\utility::getfx(var_7.func_22F9), var_7.func_7601, "tag_origin");
    }
  }

  wait 0.05;
  var_02 = var_03;

  if(var_00) {
    while(var_02 >= 0) {
      if(isDefined(var_1[var_02].fx))
        _killfxontag(scripts\engine\utility::getfx(var_1[var_02].fx), var_1[var_02].func_7601, "tag_origin");

      if(var_02 == 0)
        var_1[var_02].fx = "jackal_runway_segment_end";
      else if(var_02 == var_04)
        var_1[var_02].fx = "jackal_runway_segment_start";
      else if(var_02 < var_04)
        var_1[var_02].fx = "jackal_runway_segment";
      else
        var_1[var_02].fx = undefined;

      if(isDefined(var_1[var_02].fx)) {
        playFXOnTag(scripts\engine\utility::getfx(var_1[var_02].fx), var_1[var_02].func_7601, "tag_origin");
        wait 0.25;
      }

      var_2--;
    }
  } else {
    foreach(var_07 in var_01)
    _killfxontag(scripts\engine\utility::getfx(var_7.fx), var_7.func_7601, "tag_origin");
  }
}

func_3AE7(var_00, var_01, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(var_03 >= var_07)
    var_01 = self.parent.angles;
  else {
    var_08 = vectornormalize(var_01 - self.origin);
    var_09 = anglestoup(var_2.angles);
    var_10 = anglestoright(self.parent.angles);
    var_11 = anglesToForward(var_2.angles);
    var_12 = anglestoup(var_2.angles);
    var_13 = anglestoright(self.parent.angles);
    self.func_56EA = distance(self.origin, var_01);
    self.func_5ABB = vectordot(vectornormalize(self.origin - var_01), anglesToForward(var_01));
    var_14 = scripts\sp\math::func_C097(0, 0.1, self.func_5ABB);
    var_06 = scripts\sp\math::func_6A8E(0.1, 1, var_06);
    var_15 = scripts\sp\math::func_C097(var_05, var_04, var_03);
    var_16 = scripts\sp\math::func_C09B(var_15);
    var_17 = vectornormalize(var_11 * (1 - var_16) + var_08 * var_16);
    var_18 = vectornormalize(var_13 * (1 - var_15) + var_10 * var_15);
    var_19 = vectornormalize(var_12 * (1 - var_15) + var_09 * var_15);
    var_01 = _axistoangles(var_17, var_18, var_19);
  }

  var_01 = (func_0BDC::func_12D71(var_01, self.angles, 0), func_0BDC::func_12D71(var_01, self.angles, 1), func_0BDC::func_12D71(var_01, self.angles, 2));
  self.angles = self.angles + (var_01 - self.angles) * self.func_AB99;
  self.func_AB99 = 0.2;
}

func_3ADE(var_00) {
  var_01 = 0;

  for(var_02 = []; var_01 < var_00; var_1++) {
    var_03 = scripts\engine\utility::spawn_tag_origin();
    var_3.func_11AE0 = 1;
    var_3.func_AB99 = 1;
    var_3.func_7601 = scripts\engine\utility::spawn_tag_origin();
    var_3.func_7601.origin = var_3.origin;
    var_3.func_7601.angles = _axistoangles(anglestoup(var_3.angles), -1 * anglestoright(var_3.angles), anglesToForward(var_3.angles));
    var_3.func_7601 linkto(var_03);
    var_02 = scripts\engine\utility::array_add(var_02, var_03);
    var_3.func_AD34 = self;
    self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_03);
    self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_3.func_7601);
  }

  self.segments = var_02;
  thread func_3AC7(1);
  return var_02;
}

func_3AE3() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_0.func_B42D = 5200;
  var_0.func_B740 = 0;
  var_0.func_AB99 = 0.2;
  var_0.active = 0;
  var_0.func_20F1 = scripts\engine\utility::spawn_tag_origin();
  var_0.func_20F1 linkto(var_00, "tag_origin", (900, 0, 75), (0, 0, 0));

  if(isDefined(self.func_5BD7)) {
    var_0.func_5BD7 = self.func_5BD7;
    var_0.func_5BD7 unlink();
  } else {
    var_0.func_5BD7 = func_0BD6::func_10753();
    var_0.func_5BD7.func_4074 = [];
    var_0.func_5BD7.func_FC28 = scripts\engine\utility::spawn_tag_origin();
    var_0.func_5BD7.func_FC28 linkto(var_0.func_5BD7, "j_mainroot", (0, 0, 0), (0, 0, 0));
    var_0.func_5BD7.func_FB5B = scripts\engine\utility::spawn_tag_origin();
    var_0.func_5BD7.func_FB5B linkto(var_0.func_5BD7, "j_mainroot", (0, 0, 0), (0, 0, 0));
    var_0.func_5BD7.func_FB5C = scripts\engine\utility::spawn_tag_origin();
    var_0.func_5BD7.func_FB5C linkto(var_0.func_5BD7, "j_mainroot", (0, 0, 0), (0, 0, 0));
    var_0.func_5BD7.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_0.func_5BD7.func_FC28);
    var_0.func_5BD7.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_0.func_5BD7.func_FB5B);
    var_0.func_5BD7.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_0.func_5BD7.func_FB5C);
  }

  var_0.func_5BD7.origin = var_0.origin + (0, 0, 35);
  var_0.func_5BD7.angles = var_0.angles;
  var_0.func_5BD7 linkto(var_00);
  var_0.func_5BD7.active = 0;
  var_0.func_11AE0 = 1;
  var_0.func_7601 = scripts\engine\utility::spawn_tag_origin();
  var_0.func_7601.origin = var_0.origin;
  var_0.func_7601.angles = _axistoangles(anglestoup(var_0.angles), -1 * anglestoright(var_0.angles), anglesToForward(var_0.angles));
  var_0.func_7601 linkto(var_00);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_00);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_0.func_7601);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_0.func_5BD7);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_0.func_20F1);
  var_0.func_5BD7 thread func_5BEA();
  self.func_102D1 = var_00;
}

func_5BEA() {
  self waittill("death");

  foreach(var_01 in self.func_4074) {
    if(isDefined(var_01))
      var_01 delete();
  }
}

#using_animtree("vehicles");

func_5BFA() {
  self.func_102D1.func_5BD7 give_attacker_kill_rewards( % landing_drone_fail_overlay, 1);
  self.func_102D1.func_5BD7 give_attacker_kill_rewards( % landing_drone_fly_fail, 1, 1);
  wait 1;
  self.func_102D1.func_5BD7 notify("notify_drone_reset");
  self.func_102D1.func_5BD7.active = 0;
  self.func_102D1.func_5BD7.origin = self.func_102D1.origin + (0, 0, 35);
  self.func_102D1.func_5BD7.angles = self.func_102D1.angles;
  self.func_102D1.func_5BD7 linkto(self.func_102D1);
  self.func_102D1.func_5BD7 func_0BD6::func_A7D5();
  self.func_102D1.func_5BD7 func_0BD6::func_5C8D();
}

func_3AC4() {
  if(isDefined(self.func_E311))
    self.func_E311 thread func_3AC5(self.func_E311.end, self.func_E311.start, 3.5);
}

func_3AC6() {
  if(isDefined(self.func_E311))
    self.func_E311 thread func_3AC5(self.func_E311.start, self.func_E311.end, 3);
}

func_3AC5(var_00, var_01, var_02) {
  self notify("door_change_dir");
  self endon("door_change_dir");

  for(;;) {
    self unlink();
    var_03 = var_1.origin - self.origin;

    if(length(var_03) <= var_02) {
      self.origin = var_1.origin;
      self.angles = var_1.angles;
      break;
    } else {
      self.origin = self.origin + vectornormalize(var_03) * var_02;
      self.angles = var_1.angles;
    }

    self linkto(self.parent);
    wait 0.05;
  }

  self linkto(self.parent);
}

func_3AB6() {
  var_00 = [];

  if(!isDefined(self.func_8A9D)) {
    return;
  }
  foreach(var_02 in self.func_8A9D) {
    var_03 = scripts\engine\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_00 = scripts\engine\utility::array_add(var_00, var_03);
    var_03 linkto(var_02);
    self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_03);
  }

  self.func_4556 = var_00;
}

func_E8D0() {
  var_00 = self.segments;

  for(var_01 = self.segments.size - 1; var_01 >= 0; var_1--) {
    if(isDefined(var_0[var_01].fx))
      _killfxontag(scripts\engine\utility::getfx(var_0[var_01].fx), var_0[var_01].func_7601, "tag_origin");

    var_0[var_01].fx = undefined;

    if(isDefined(var_0[var_01].func_22F9))
      _killfxontag(scripts\engine\utility::getfx(var_0[var_01].func_22F9), var_0[var_01].func_7601, "tag_origin");

    var_0[var_01].func_22F9 = undefined;
  }
}

func_EA01() {
  if(isDefined(self))
    self delete();
}

func_3ADC(var_00) {
  var_01 = length(self.func_11593.origin - level.func_D127.origin);
  var_02 = scripts\sp\math::func_C097(50, 300, var_01);
  var_03 = scripts\sp\math::func_6A8E(0.3, 2.7, var_02);

  if(!isDefined(var_00)) {
    func_0BDC::func_D164(self.func_11593, var_03);
    func_0BDC::func_A38E(0);
  }

  self.func_102D1.func_5BD7 func_0BD6::func_6815();
  wait(var_03 * 0.5);

  if(!isDefined(var_00))
    func_0BDC::func_A14D();

  self.func_11593 playSound("jackal_land");
  level.func_D127 playSound("jackal_tire_skid_long_plr");

  if(!isDefined(var_00))
    func_0BDC::func_A38E(33, 9, 3, 2);

  level.player playrumbleonentity("damage_heavy");
  earthquake(0.35, 1.3, level.func_D127.origin, 5000);

  if(!isDefined(var_00)) {
    func_0BDC::func_D164(self.func_11593, 0.3);
    func_0BDC::func_A1DD("land");
  }

  level notify("notify_land_jet");

  if(!isDefined(var_00))
    func_3AD4();

  self.func_102D1.func_5BD7 thread func_0BD6::func_680F(1.1);
}

func_3ACF(var_00) {
  level endon("notify_stop_runway_landing");

  if(!isDefined(var_00))
    var_01 = level.func_D127 gettagorigin("j_mainroot");
  else
    var_01 = level.func_D127 gettagorigin("j_canopy");

  if(level.func_D127.classname == "script_vehicle_jackal_enemy_prototype")
    var_02 = -52;
  else
    var_02 = 0;

  self.func_11593 = scripts\engine\utility::spawn_tag_origin();
  var_03 = level.func_D127.origin - self.func_6C1E.origin;
  var_03 = rotatevectorinverted(var_03, self.func_6C1E.angles);
  var_03 = (var_3[0], var_3[1], 0);
  var_04 = rotatevector(var_03, self.func_6C1E.angles);
  self.func_11593.origin = self.func_6C1E.origin + var_04 + anglestoup(self.func_6C1E.angles) * var_02;
  self.func_11593.angles = self.func_6C1E.angles;
  self.func_11593 linkto(self);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_11593);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_11593.func_B017);
  var_05 = length(level.func_D127.spaceship_vel);
  var_05 = scripts\engine\utility::mph_to_ips(var_05);
  var_05 = var_05 * 0.05;

  for(;;) {
    var_06 = self.func_6C1E.origin + anglestoup(self.func_6C1E.angles) * var_02;

    if(!isDefined(var_00)) {
      var_07 = vectornormalize(var_06 - self.func_11593.origin);
      var_08 = distance(self.func_11593.origin, var_06);
    } else {
      var_07 = vectornormalize(var_06 - level.func_D127.origin);
      var_08 = distance(level.func_D127.origin, var_06);
    }

    var_09 = scripts\sp\math::func_C097(20, 3000, var_08);
    var_09 = scripts\sp\math::func_C09B(var_09);
    var_10 = scripts\sp\math::func_6A8E(0.7, var_05, var_09);
    var_11 = scripts\sp\math::func_6A8E(0.2, 1, var_09);
    var_12 = scripts\sp\math::func_6A8E(0.2, 1.2, var_09);
    var_13 = scripts\sp\math::func_6A8E(0.3, 1, var_09);
    self.func_11593 unlink();
    self.func_11593.origin = self.func_11593.origin + var_07 * var_10;
    self.func_11593.angles = self.func_6C1E.angles;
    self.func_11593 linkto(self);
    self.func_102D1.func_5BD7.func_FB5C ghostattack(var_12, 0.05);
    self.func_102D1.func_5BD7.func_FB5C _meth_8277(var_13, 0.05);

    if(var_08 < 5) {
      break;
    } else if(isDefined(var_00) && var_08 < 40) {
      break;
    }
    wait 0.05;
  }

  thread func_C139();
  wait 2;
}

func_C139() {
  if(isDefined(level.func_A056.func_A7E9)) {
    scripts\sp\hud_util::func_6AA3(level.func_A056.func_A7E9, "black");
    wait(level.func_A056.func_A7E9);
  }

  level notify("jackal_taxi_complete");
}

#using_animtree("jackal");

func_D17A(var_00) {
  level endon("notify_restart_landing progress");
  level endon("notify_stop_runway_landing");

  for(;;) {
    var_01 = distance(self.segments[15].origin, level.func_D127.origin);

    if(var_01 < 14000) {
      break;
    }
    wait 0.05;
  }

  if(!isDefined(var_00))
    thread func_0BDC::func_A2B0( % jackal_pilot_runway_prep, % jackal_vehicle_runway_prep, 1.1, 0.5);

  wait 2.5;

  if(!isDefined(var_00)) {
    func_0BDC::func_A153();
    func_0BDC::func_A14A();
    func_0BDC::func_A15B();
    func_0BDC::func_A151();
    func_0BDC::func_A1DD("fly");
    func_0BDC::func_A155();
    func_0BDC::func_A1DC(350);
    func_0BDC::func_A161();
    func_0BD9::func_A323();
  }
}

func_D17B() {
  func_0BDC::func_A153(0);
  func_0BDC::func_A14A(0);
  func_0BDC::func_A15B(0);
  func_0BDC::func_A151(0);
  func_0BDC::func_A1DD(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A1DC(0);
  func_0BDC::func_A161(0);
  func_0BDC::func_A2FC(1, 0, "landing");
  func_0BD9::func_A318(level.func_A056.func_9B6F);
}

func_A2CE() {
  if(level.console || level.player global_fx())
    scripts\sp\utility::func_56BA("jackal_launch_rev");
  else
    scripts\sp\utility::func_56BA("jackal_launch_rev_pc");
}