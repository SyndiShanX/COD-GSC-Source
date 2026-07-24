/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3035.gsc
**************************************/

_id_D18D() {
  level.player notifyonplayercommand("pulse_button", "+usereload");
  _id_0BDC::_id_137D6();
  thread _id_D1F6();
}

_id_D1F6() {
  self endon("player_exit_jackal");
  wait 0.05;
  var_0 = 0.1;
  var_1 = 1;
  var_2 = 5000;
  var_3 = 0;

  for(;;) {
    var_4 = level._id_D127.origin;
    var_5 = level._id_D127.angles;
    var_6 = scripts\engine\utility::getclosest(var_4, level._id_A056._id_1632);

    if(!isDefined(var_6)) {
      _id_412F();
      wait 0.05;
      continue;
    }

    var_7 = var_6.origin;
    var_8 = length(var_4 - var_7);
    var_9 = var_4[2] - var_7[2];
    var_10 = vectordot(vectorNormalize(var_6.origin - level._id_D127.origin), anglesToForward(level._id_D127.angles));

    if(self.spaceship_mode == "fly") {
      if(isDefined(var_6._id_EE10))
        var_11 = var_6._id_EE10;
      else
        var_11 = 8000;

      var_12 = 0.5;
      _id_0BDC::_id_A301(1, var_0, "land_speed");
    } else {
      var_13 = scripts\sp\math::_id_C097(700, 4000, var_8);
      var_14 = scripts\sp\math::_id_6A8E(0.25, 1, var_13);

      if(isDefined(var_6._id_EE10))
        var_11 = var_6._id_EE10;
      else
        var_11 = 2800;

      var_12 = -2;

      if(_id_A7D7(var_6))
        _id_0BDC::_id_A301(var_14, var_0, "land_speed");
    }

    var_15 = 0;

    if(var_8 < var_11 && var_9 > 10 && var_10 > var_12 && _id_A7D7(var_6)) {
      if(bullettracepassed(level._id_D127.origin, var_6.origin + (0, 0, 200), 0, level._id_D127))
        var_15 = 1;
    }

    if(var_15) {
      if(!scripts\engine\utility::flag("jackal_taking_off")) {
        _id_DA72();

        if(isDefined(self._id_B36F) && self._id_B36F != var_6)
          self._id_B36F _id_4130();

        var_6 _id_DA73();
        self._id_B36F = var_6;
      }

      if(level.player useButtonPressed()) {
        level notify("stop_landingpad_pulse");
        level.player scripts\sp\utility::_id_65E1("flag_player_is_landing");
        _id_412F();
        var_6 _id_4130();
        _id_0BDC::_id_A301(1, 0, "land_speed");
        thread _id_A83E(var_6);

        if(isDefined(level._id_265A))
          thread[[level._id_265A]](var_6);
        else
          thread _id_2658(var_6);

        return;
      }
    } else {
      _id_412F();
      var_6 _id_4130();
      self._id_B36F = undefined;
    }

    wait(var_0);
  }
}

_id_A83E(var_0) {
  level.player playSound("autoland_aquired");
  level endon("abort_vtol");
  level._id_D127 endon("jackal_touchdown");
  level notify("jackal_landing");
  wait 0.4;

  for(;;) {
    if(isDefined(var_0))
      playFXOnTag(scripts\engine\utility::getfx("landing_pad_confirmed"), var_0.tag_origin, "tag_origin");

    level.player playSound("autoland_engaged");
    wait 0.8;
  }
}

_id_DA72() {
  if(!scripts\engine\utility::flag("jackal_land_hint")) {
    scripts\engine\utility::flag_set("jackal_land_hint");
    scripts\sp\utility::_id_56BA("jackal_land");
  }
}

_id_412F() {
  if(scripts\engine\utility::flag("jackal_land_hint"))
    scripts\engine\utility::flag_clear("jackal_land_hint");
}

_id_DA73() {
  if(!self._id_B36C) {
    thread _id_2656();
    self._id_B36C = 1;
  }
}

_id_2656() {
  self endon("entitydeleted");
  self endon("stop_autoland_marker");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("landing_pad_marker"), self.tag_origin, "tag_origin");
    level.player playSound("autoland_marker");
    wait 1;
  }
}

_id_4130() {
  if(self._id_B36C) {
    self notify("stop_autoland_marker");
    self._id_B36C = 0;
  }
}

_id_2658(var_0) {
  level endon("abort_vtol");
  thread _id_1393F();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A153();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A156();
  _id_0BDC::_id_A164();
  _id_0BDC::_id_A14A();
  thread _id_2657(var_0);
  _id_0BDC::_id_A1DD("hover");
  _id_0BDC::_id_A224(1);
  objective_delete(scripts\sp\utility::_id_C264("OBJ_VTOL_LAND"));
  var_1 = 250;
  var_2 = 500;
  var_3 = 5000;
  var_4 = level._id_D127.origin[2] - var_0.origin[2];
  var_5 = clamp(var_4, var_1, var_2);
  var_6 = 199;
  level._id_13573 = scripts\engine\utility::spawn_tag_origin();
  level._id_13572 = scripts\engine\utility::spawn_tag_origin();
  var_7 = level._id_13573;
  var_8 = level._id_13572;
  var_7.origin = var_0.origin + anglestoup(var_0.angles) * var_5;
  var_8.origin = var_7.origin + anglesToForward(var_0.angles) * var_3;
  _id_0BDC::_id_D165(var_8, 0.55, 0, 1);
  _id_0BDC::_id_D16C(var_7, 0.625, 0, 1);
  var_9 = 250;

  for(;;) {
    var_10 = distance(level._id_D127.origin, var_7.origin);
    var_11 = vectordot(anglesToForward(level._id_D127.angles), vectorNormalize(var_8.origin - level._id_D127.origin));
    var_12 = scripts\sp\math::_id_C097(var_9, 2000, var_10);
    var_4 = level._id_D127.origin[2] - var_0.origin[2];

    if(var_10 < var_9 && var_11 > 0.5 && var_4 > 10) {
      break;
    }

    wait 0.05;
  }

  _id_10FC9();
  _id_0BDC::_id_A14D();
  var_13 = 1.5;
  var_7 moveTo(var_0.origin, var_13, var_13 * 0.4);
  var_8 moveTo(var_7.origin + anglesToForward(var_0.angles) * var_3, var_13, var_13 * 0.4);
  _id_0BDC::_id_D16C(var_7, 1, 0, 1);
  var_14 = undefined;

  for(;;) {
    var_4 = level._id_D127.origin[2] - var_0.origin[2];

    if(!isDefined(var_14))
      var_14 = var_4 - var_6;

    if(var_4 <= var_6) {
      break;
    }

    wait 0.05;
  }

  earthquake(0.35, 0.75, level._id_D127.origin, 3000);
  level.player playRumbleOnEntity("damage_heavy");
  _id_0BDC::_id_A1DD();
  level._id_D127 _meth_8491("land");
  level._id_D127 notify("jackal_touchdown");
  var_15 = level._id_D127.origin;
  var_16 = (0, level._id_D127.angles[1], 0);
  var_17 = var_0.origin[2] + 99;
  var_7.origin = (var_15[0], var_15[1], var_17);
  var_8.origin = var_7.origin + anglesToForward(var_16) * 5000;
  level notify("stop_watch_abort_vtol");
  _id_0BDC::_id_D165(var_8, 1.0, 0, 0.15, 1);
  _id_0BDC::_id_D16C(var_7, 1.0, 0, 0.15, 1);
  wait 1;
  _id_0BDC::_id_D165(var_8, 0.0, 1, 0.0, 1);
  _id_0BDC::_id_D16C(var_7, 0.0, 1, 0.0, 1);
  _id_2659();
  _id_E073();
}

_id_2659() {
  _id_0BDC::_id_A224(0);
  _id_0BDC::_id_D165(level._id_13572, 0, 1, 1);
  _id_0BDC::_id_D16C(level._id_13573, 0, 1, 1);
  _id_0BDC::_id_A1DD();
  _id_0BDC::_id_A15C(0);
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A156(0);
  _id_0BDC::_id_A164(0);
  _id_0BDC::_id_A14A(0);
  level._id_13573 delete();
  level._id_13572 delete();
}

_id_151F() {
  level notify("abort_vtol");
  level.player scripts\sp\utility::_id_65DD("flag_player_is_landing");
  setsaveddvar("spaceshipcollisionEventThreshold", level._id_A056._id_105E7);
  _id_2659();
  thread _id_D1F6();
}

_id_1393F() {
  level endon("stop_watch_abort_vtol");
  level endon("abort_vtol");
  var_0 = 0;
  setsaveddvar("spaceshipcollisionEventThreshold", 0);

  for(;;) {
    level._id_D127 waittill("spaceship_collision");
    var_0++;

    if(var_0 >= 2)
      thread _id_151F();
  }
}

_id_2657(var_0) {
  level endon("stop_vtol_pushup");

  for(;;) {
    var_1 = level._id_D127.origin[2] - var_0.origin[2];
    var_2 = scripts\sp\math::_id_C097(-60, 30, var_1);
    var_3 = scripts\sp\math::_id_6A8E(80, 0, var_2);
    _id_0BDC::_id_A078((0, 0, var_3), 0.05, "vtol_pushup");
    wait 0.05;
  }
}

_id_10FC9() {
  level notify("stop_vtol_pushup");
  _id_0BDC::_id_A078((0, 0, 0), 0.5, "vtol_pushup");
}

_id_A7D7(var_0) {
  if(level._id_A056._id_1632.size == 0 || !level.player scripts\sp\utility::_id_65DB("flag_player_landing_enabled") || !level.player scripts\sp\utility::_id_65DB("flag_takeoff_cooldown") || _id_0BDC::_id_7B9C() > 200 || !var_0 _id_0BDC::_id_9C1B(0.9))
    return 0;
  else
    return 1;
}

_id_F51F() {
  var_0 = level.player;
  _id_A2D8();
  level.player _meth_81E3(1);
  _id_0BDC::_id_104A6(0);
  var_1 = self makeentitysentient("allies", 0);
  _id_0BD9::_id_D161(var_0.team);
  scripts\engine\utility::waitframe();
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_jackal_weapon_display_temp", 0);
  _id_0BDC::_id_6B4C("none", 1);
  var_2 = self[[self._id_BBD4]]();
  _id_0BDC::_id_A2DA();
  thread _id_A0F7();
  _id_0BD4::_id_A329(var_2);
  _id_0BDC::jackal_engine_throttle_sfx_volume(1, 2);
  level.player enableweapons();
  level.player disableoffhandweapons();
  self thread[[self._id_11474]]();
  level.player scripts\sp\utility::_id_65E1("flag_player_is_flying");
}

_id_E073(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!var_0) {
    level.player scripts\sp\utility::_id_65E1("flag_player_dismounting");
    self[[self._id_A7B9]]();
    _id_5686();
    _id_DF4D();
    _id_0BD4::_id_A2D9();
    level.player _meth_81E3(0);
    self notify("player_exit_jackal");
    _id_0BD5::_id_4086();
    thread _id_0BD9::_id_D176(0.0, 0, 0.2, 0.01, 0.3);
  }

  _id_0BDC::jackal_engine_throttle_sfx_volume(0, 2);
  var_1 = self[[self._id_5688]]();
  _id_569B();
  _id_569C();
  _id_5683();
  level._id_A056 notify("player_left_jackal");
  level._id_D127 = undefined;
  level._id_D223 = self;

  if(scripts\engine\utility::is_true(self._id_FF24))
    _id_0BDC::_id_A07D();

  _id_0BDC::_id_A208();
  _id_0BDC::_id_A0AF();
  _id_0BDC::_id_104A6(1);
  _id_0BDC::_id_6B4D();
  _id_0BDC::_id_6B4C(var_1);
  _id_A328();
  self freeentitysentient();

  if(isDefined(self._id_AD34))
    self._id_AD34 delete();
}

_id_A328() {
  if(isDefined(level._id_A056._id_C8F7)) {
    self._id_C8F7 = spawn("script_model", self.origin);
    self._id_C8F7 setModel(level._id_A056._id_C8F7);
    self._id_C8F7 linkTo(self, "tag_origin", level._id_A056._id_C8F8, (0, 0, 0));
    self notsolid();
  }
}

_id_A2D8() {
  if(isDefined(self._id_C8F7)) {
    self._id_C8F7 delete();
    self solid();
  }
}

_id_A0F7() {
  if(self.model != level.vehicle._id_116CE._id_13265[self.classname]._id_D375)
    _id_A32A();
}

_id_A0F8() {
  _id_0BDC::_id_137DA();

  if(isDefined(level._id_A056._id_DE59))
    level._id_A056._id_DE59 _id_0BDC::_id_A25B(0, "j_mainroot_ship", (232, 0, 32), (0, 0, 0));
}

_id_A1B6() {
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

_id_A1B5() {
  wait 2;
  self playSound("plr_foley_exit_jackal_cockpit_zg_lr");
}

_id_A1A7() {
  level.player playSound("plr_jackal_zg_canopy_open");
  wait 1;
  level.player playSound("plr_foley_enter_jackal_zg");
}

_id_A1A6() {
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

_id_A32A() {
  if(isDefined(level._id_A056.mip_buffer_model))
    level._id_A056.mip_buffer_model delete();

  _id_0BDC::_id_A144();
  self setModel(level.vehicle._id_116CE._id_13265[self.classname]._id_D375);
  self dontcastshadows();
  setsaveddvar("r_playerShadowProxy0Params", "0 0 0 0");
  setsaveddvar("r_playerShadowProxy1Params", "0 0 0 0");
}

_id_A0F9() {
  if(self.model != level.vehicle._id_116CE._id_13265[self.classname]._id_13DCB)
    _id_A330();
}

_id_A330() {
  self setModel(level.vehicle._id_116CE._id_13265[self.classname]._id_13DCB);
  self castshadows();
  setsaveddvar("r_playerShadowProxy0Params", "0 0 0 4");
  setsaveddvar("r_playerShadowProxy1Params", "0 0 -8 4");
  _id_0BDC::_id_A0AF();
  _id_0BDC::_id_A07D();
}

_id_DF4D() {
  if(!isDefined(self.linked_ents)) {
    return;
  }
  foreach(var_1 in self.linked_ents) {
    if(isDefined(var_1))
      var_1 linkTo(self, var_1._id_AD42, var_1._id_AD25, var_1._id_AD19);

    self.linked_ents = scripts\engine\utility::array_remove(self.linked_ents, var_1);
  }
}

_id_E076() {
  if(isDefined(self._id_AD34))
    self._id_AD34 delete();
}

_id_107A1() {
  if(isDefined(self._id_AD34)) {
    return;
  }
  self._id_AD34 = level.player scripts\engine\utility::spawn_tag_origin();
  self._id_AD34 setModel("viewmodel_base_viewhands_iw7");
  self._id_AD34 hide();
  self._id_AD34.origin = self gettagorigin("tag_camera") + anglestoup(self gettagangles("tag_camera")) * -60;
  self._id_AD34.angles = self gettagangles("tag_camera");
  self._id_AD34 linkTo(self, "tag_camera");
}

_id_5698() {
  if(!isDefined(level._id_A056._id_DE59)) {
    return;
  }
  level._id_A056._id_DE59 _id_0BDC::_id_A387();
  level._id_A056._id_DE59._id_C73B = (-200000, -200000, -200000);
}

_id_569B() {
  level.player scripts\sp\utility::_id_65DD("flag_player_is_flying");
  level.player scripts\sp\utility::_id_65DD("flag_takeoff_cooldown");
  level.player scripts\sp\utility::_id_65DD("flag_player_has_jackal");
  level.player scripts\sp\utility::_id_65DD("flag_player_dismounting");
}

_id_569C() {
  level.player allowfire(1);
  level.player allowads(1);
  level.player enableoffhandweapons();
}

_id_5683() {
  if(isDefined(self.missiles))
    self.missiles.active = 0;
}

_id_5686() {
  _id_0BDC::_id_A14D(0);
  _id_0BDC::_id_A15C(0);
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A156(0);
  _id_0BDC::_id_A14A(0);
  _id_0BDC::_id_A15D(0);
}

_id_569A() {
  _id_0BDC::_id_D165((0, 0, 0), 0.0, 1, 0.0, 1);
  _id_0BDC::_id_D16C((0, 0, 0), 0.0, 1, 0.0, 1);
  _id_0BDC::_id_D165((0, 0, 0), 0.0, 1, 0.0);
  _id_0BDC::_id_D16C((0, 0, 0), 0.0, 1, 0.0);
}

_id_11478() {
  level.player scripts\sp\utility::_id_65E1("flag_takeoff_cooldown");
  _id_0BDC::jackal_engine_throttle_sfx_volume(1, 0);
  _id_0BDC::_id_A153(0);
}

_id_1148A() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  level.player _meth_8462(level._id_D127._id_BC85, "moveto", "absolute_player", 0.2, 0);
  var_0 = level._id_D127.origin + anglesToForward(level._id_D127.angles) * 1000;
  _id_0BDC::_id_D165(var_0, 1, 1, 0);
  _id_0BDC::_id_A14D();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A151();
  _id_0BDC::_id_A152(0);
  scripts\sp\utility::_id_56BA("jackal_takeoff");

  while(!isDefined(level._id_D127._id_7294)) {
    wait 0.05;

    if(level.player _meth_81CE()) {
      break;
    }
  }

  _id_0BDC::_id_A302(0.1, 0, "vtol_turn_takeoff");
  _id_0BDC::_id_D165(var_0, 0, 1, 0);
  thread _id_0BDC::_id_A07A((0, 0, 50), 0.2, 1, "vtol_takoff_impulse");
  level.player notify("player_takeoff");
  level.player playSound("jackal_vtol_takeoff_plr");
  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_clear, "jackal_taking_off");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.18, 0.6, level._id_D127.origin, 3000);
  _id_0BDC::_id_A302(1.0, 7, "vtol_turn_takeoff");
  level.player _meth_8462(level._id_D127._id_BC85, "moveto", "absolute_player", 1, 7);
  level._id_D127 _meth_8491("hover");

  if(!isDefined(level._id_D127._id_7294))
    _id_0BDC::_id_A14D(0);

  wait 1.2;

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_guns"))
    _id_0BDC::_id_A19E(0);

  wait 1.8;
  level.player scripts\sp\utility::_id_65E1("flag_takeoff_cooldown");
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A15C(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A151(0);
  level._id_D127._id_7294 = undefined;
}

_id_11486() {
  _id_0BDC::_id_A14D();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A15C();
  level._id_D127.anchor = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  _id_0BDC::_id_D164(level._id_D127.anchor, 0);
  level waittill("forever");
}

_id_1147C() {
  _id_0BDC::_id_A14D();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A151();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A2FC(0.7, 0.0);
  scripts\engine\utility::flag_set("jackal_hint_ret_launch");
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_56BA, "jackal_launch_retribution");
  level.player notifyonplayercommand("jackal_ret_launch", "+breath_sprint");
  level.player waittill("jackal_ret_launch");
  scripts\engine\utility::flag_clear("jackal_hint_ret_launch");
  _id_0BDC::_id_A0BE(1);
  _id_0BDC::_id_A1DD("fly");
  scripts\engine\utility::delaythread(1, _id_0BDC::_id_A0BE, 0);
  scripts\engine\utility::delaythread(1, _id_0BDC::_id_A2FC, 1, 0);
}

_id_1147D() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  _id_0BDC::jackal_engine_throttle_sfx_volume(0, 0);
  var_0 = spawnVehicle("veh_mil_air_un_jackal_02", "player_sled", "jackal_un", level._id_D127.origin, level._id_D127.angles);
  var_0 _meth_8184();
  var_0 notsolid();
  var_0._id_AFEB = scripts\engine\utility::spawn_tag_origin();
  var_0._id_AFEB.origin = var_0.origin + anglesToForward(var_0.angles) * 15000;
  var_0._id_AFEB linkTo(var_0);
  var_0 _id_0C24::_id_10A49();
  _id_0BDC::_id_D16C(var_0, 1, 0, 0, 1);
  _id_0BDC::_id_D16C(var_0, 1, 0, 0);
  _id_0BDC::_id_D165(var_0._id_AFEB, 1.0, 0, 0);
  _id_0BDC::_id_D165(var_0._id_AFEB, 1.0, 0.0, 0, 1);
  _id_0BDC::_id_A38E(0, undefined, undefined, 0);
  var_1 = _id_7CCE();
  _id_0BDC::_id_A14D();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A151();
  _id_0BDC::_id_A156();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A14A();
  _id_0BDC::_id_A152(1);

  if(scripts\engine\utility::flag_exist("takeoff_runway_blocker"))
    scripts\engine\utility::flag_wait("takeoff_runway_blocker");

  _id_0BDC::_id_A250();
  _id_0BDC::jackal_engine_throttle_sfx_volume(1, 1);
  _id_11482();
  _id_0BDC::_id_A250(0);
  _id_0BDC::_id_D165(var_0._id_AFEB, 0.0, 1.0, 0, 1);
  _id_0BDC::_id_A38E(undefined, undefined, undefined, 1);
  _id_0BDC::_id_A0BE();
  _id_0BDC::_id_A1DC(400);
  _id_0BDC::_id_A1DD("hover");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.18, 0.6, level._id_D127.origin, 3000);
  var_0 _meth_8479(var_1);
  var_0 _meth_847B(0.2);
  var_0 playLoopSound("jackal_runway_sled_lp");
  var_0 _meth_8278(0.7, 0.0);
  var_0 _meth_8277(0.7, 0.0);
  wait 0.05;
  var_0 _meth_8278(1.8, 2.0);
  var_0 _meth_8277(1.3, 2.0);
  var_0 waittill("off_ramp");
  level notify("player_off_ramp");
  var_0 _meth_8278(0.0, 0.2);
  _id_0BDC::_id_A302(0.3, 0.0);
  _id_0BDC::_id_D16C(var_0, 0.0, 1.0, 0.5, 1);
  _id_0BDC::_id_D165(var_0._id_AFEB, 1.0, 0.2, 2.5);
  _id_0BDC::_id_A1DD(0);
  _id_0BDC::_id_A0BE(0);
  earthquake(0.29, 1.8, self.origin, 10000);
  level.player playRumbleOnEntity("damage_heavy");
  thread _id_0BDC::_id_A287(0.2);
  var_0 waittill("return_player_control");
  level notify("return_player_control");
  _id_0BDC::_id_A14D(0);
  _id_0BDC::_id_A14A(0);
  _id_0BDC::_id_A302(1.0, 0.2);
  _id_0BDC::_id_D16C(var_0, 0, 1, 2.5);
  _id_0BDC::_id_D16C(var_0, 0, 1.0, 2.5, 1);
  _id_0BDC::_id_D165(var_0._id_AFEB, 0, 1.0, 2.5);
  _id_0BDC::_id_A1DC(0);
  earthquake(0.27, 1.5, self.origin, 10000);
  level.player playRumbleOnEntity("damage_light");
  thread _id_0BDC::_id_A388(1.0);
  thread _id_0BDC::_id_D527("jackal_vtol_takeoff_plr", self.origin, undefined, 1.5);
  wait 1.2;

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_guns"))
    _id_0BDC::_id_A19E(0);

  wait 1.8;
  level.player scripts\sp\utility::_id_65E1("flag_takeoff_cooldown");
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A151(0);
  _id_0BDC::_id_A156(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A1DD(0);
  _id_0BDC::_id_A15C(0);
  var_0._id_AFEB delete();
  var_0 delete();
  scripts\engine\utility::flag_clear("jackal_taking_off");
  _id_1147E();
}

_id_1147E() {
  foreach(var_1 in level._id_A056._id_E8AD._id_AA83.cleanup) {
    var_1 delete();
    wait 0.05;
  }

  foreach(var_4 in level._id_A056._id_E8AD._id_AA60) {
    foreach(var_1 in var_4.cleanup) {
      var_1 delete();
      wait 0.05;
    }
  }
}

_id_11479() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  _id_0BDC::_id_A14D();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A151();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A152(0);
  self waittill("notify_player_can_launch");
  _id_1147A();
  level.player scripts\sp\utility::_id_65E1("flag_player_is_flying");
  self notify("notify_player_launch");
  earthquake(0.29, 1.8, self.origin, 10000);
  level.player playRumbleOnEntity("damage_heavy");
  level._id_D127 waittill("launch_complete");
  _id_0BDC::_id_A14D(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A151(0);
  _id_0BDC::_id_A15C(0);

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_guns"))
    _id_0BDC::_id_A19E(0);

  scripts\engine\utility::flag_clear("jackal_taking_off");
}

_id_1147B(var_0) {
  if(!scripts\engine\utility::flag_exist("flag_can_launch"))
    scripts\engine\utility::flag_init("flag_can_launch");

  for(var_1 = 0; var_1 < var_0; var_1 = var_1 + 0.05) {
    level._id_B41D = scripts\sp\math::_id_C097(0, var_0, var_1);
    wait 0.05;
  }

  scripts\engine\utility::flag_set("flag_can_launch");
}

_id_7CCE() {
  var_0 = getcsplinecount();
  var_1 = [];

  for(var_2 = 1; var_2 <= var_0; var_2++) {
    var_3 = getcsplinetargetname(var_2);

    if(issubstr(var_3, "jackal_runway_launch_sled")) {
      var_4 = var_2;
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  if(var_1.size == 0) {}

  var_5 = 99999999;
  var_6 = 0;

  foreach(var_8 in var_1) {
    var_9 = distance(getcsplinepointposition(var_8, 0), level._id_D127.origin);

    if(var_9 < var_5) {
      var_5 = var_9;
      var_6 = var_8;
    }
  }

  if(var_6 == 0) {}

  return var_6;
}

_id_11482() {
  var_0 = 0.017;
  var_1 = 0.017;
  var_2 = 0;
  var_3 = 0.0;
  var_4 = 0.47;
  var_5 = 1;
  var_6 = 0.5;
  var_7 = var_6;
  var_8 = 0.05;
  var_9 = 0.1;
  var_10 = 1;
  var_11 = 0.05;
  var_12 = 0.24;
  var_13 = 0.4;
  var_14 = scripts\sp\utility::_id_7C23();
  var_14 scripts\sp\utility::_id_E7C9(0, 0.05);
  var_15 = scripts\engine\utility::spawn_tag_origin();
  var_15.origin = level._id_D127.origin;
  var_16 = scripts\engine\utility::spawn_tag_origin();
  var_16.origin = level._id_D127.origin;
  var_15 _meth_8278(0, 0);
  var_15 _meth_8277(var_6, 0);
  var_17 = 0;
  scripts\engine\utility::flag_set("jackal_reving_hint");
  scripts\engine\utility::delaythread(1, ::_id_A2CE);

  for(;;) {
    var_18 = level.player getnormalizedmovement();

    if(var_18[0] > 0.1) {
      break;
    }

    wait 0.05;
  }

  earthquake(0.3, 1.0, level._id_D127.origin, 3000);
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

    if(var_22 > var_3)
      var_23 = var_0;
    else
      var_23 = var_1;

    var_3 = var_3 + (var_22 - var_3) * var_23;

    if(var_3 > var_4) {
      var_17 = 1;
      scripts\engine\utility::flag_clear("jackal_reving_hint");
    } else {
      var_17 = 0;
      scripts\engine\utility::flag_clear("jackal_launching_hint");
      var_19 = 0;

      if(var_3 < var_20 || var_18[0] < var_4) {
        if(!scripts\engine\utility::flag("jackal_reving_hint")) {
          scripts\engine\utility::flag_set("jackal_reving_hint");
          _id_A2CE();
        }
      } else
        scripts\engine\utility::flag_clear("jackal_reving_hint");
    }

    if(var_17 && !var_19) {
      scripts\engine\utility::flag_set("jackal_launching_hint");
      thread scripts\sp\utility::_id_56BA("jackal_launch_start");
      var_19 = 1;
    }

    if(_id_E8BC()) {
      if(var_17 && !var_21) {
        var_21 = 1;
        level notify("player_clear_for_launch");
        level.player playSound("jackal_runway_takeoff_lights_on");
        thread _id_11480(level._id_A056._id_E8AD._id_AA83.lights);
      } else if(!var_17 && var_21) {
        var_21 = 0;
        level.player playSound("jackal_runway_takeoff_lights_off");
        thread _id_1147F(level._id_A056._id_E8AD._id_AA83.lights);
      }
    }

    if(level.player _meth_8439()) {
      if(!var_2 && var_17) {
        break;
      }

      var_2 = 1;
    } else
      var_2 = 0;

    var_24 = scripts\sp\math::_id_6A8E(var_6, var_5, var_3);
    var_7 = var_7 + (var_24 - var_7) * var_8;
    var_25 = scripts\sp\math::_id_6A8E(var_9, var_10, var_3);
    var_26 = scripts\sp\math::_id_6A8E(var_11, var_12, var_3);
    var_27 = scripts\sp\math::_id_6A8E(0, var_13, var_3);
    var_28 = scripts\sp\math::_id_C097(0, var_4, var_3);
    setomnvar("ui_jackal_booster_charge", var_28);
    var_15 _meth_8278(var_25, 0.05);
    var_15 _meth_8277(var_7, 0.05);
    earthquake(var_26, 0.3, level._id_D127.origin, 3000);
    var_14 scripts\sp\utility::_id_E7C9(var_27, 0.05);
    wait 0.05;
  }

  var_16 playSound("jackal_takeoff_build_plr_stop");
  setomnvar("ui_jackal_boosters_charging", 0);
  setomnvar("ui_jackal_booster_charge", 0);
  scripts\engine\utility::flag_clear("jackal_launching_hint");
  scripts\engine\utility::flag_clear("jackal_reving_hint");
  var_16 scripts\engine\utility::delaycall(0.5, ::stopsounds);
  var_15 thread _id_4091();
  var_16 scripts\engine\utility::delaycall(0.6, ::delete);
  var_14 delete();
  level notify("player_runway_takeoff");
}

_id_E8BC() {
  if(isDefined(level._id_A056)) {
    if(isDefined(level._id_A056._id_E8AD)) {
      if(isDefined(level._id_A056._id_E8AD._id_AA83)) {
        if(isDefined(level._id_A056._id_E8AD._id_AA83.lights))
          return 1;
      }
    }
  }

  return 0;
}

_id_1147A() {
  var_0 = 0.09;
  var_1 = 0.025;
  var_2 = 0;
  var_3 = 0.0;
  var_4 = 0.8;
  var_5 = 1;
  var_6 = 0.5;
  var_7 = var_6;
  var_8 = 0.05;
  var_9 = 0.1;
  var_10 = 1;
  var_11 = 0.05;
  var_12 = 0.24;
  var_13 = 0.4;

  if(!scripts\engine\utility::flag_exist("flag_can_launch"))
    scripts\engine\utility::flag_init("flag_can_launch");

  if(!scripts\engine\utility::flag_exist("flag_launch_fail"))
    scripts\engine\utility::flag_init("flag_launch_fail");

  var_14 = scripts\sp\utility::_id_7C23();
  var_14 scripts\sp\utility::_id_E7C9(0, 0.05);
  var_15 = scripts\engine\utility::spawn_tag_origin();
  var_15.origin = level._id_D127.origin;
  var_16 = scripts\engine\utility::spawn_tag_origin();
  var_16.origin = level._id_D127.origin;
  var_15 _meth_8278(0, 0);
  var_15 _meth_8277(var_6, 0);
  var_17 = 0;
  scripts\engine\utility::flag_set("jackal_reving_hint");
  scripts\engine\utility::delaythread(1, ::_id_A2CE);
  setomnvar("ui_jackal_boosters_charging", 1);
  var_16 playSound("jackal_takeoff_build_plr");
  level._id_D127 playSound("jackal_panel_detach_plr");
  var_15 playLoopSound("jackal_takeoff_build_lp_plr");

  for(;;) {
    var_18 = level.player getnormalizedmovement();

    if(var_18[0] > 0.1 || scripts\engine\utility::flag("flag_launch_fail")) {
      break;
    }

    wait 0.05;
  }

  earthquake(0.3, 1.0, level._id_D127.origin, 3000);
  var_19 = 0;
  var_20 = 0.2;
  var_21 = 0;
  var_22 = 0;

  for(;;) {
    if(!isDefined(level._id_B41D))
      var_23 = 1;
    else
      var_23 = level._id_B41D;

    var_18 = level.player getnormalizedmovement();
    var_24 = clamp(var_18[0], 0, 1) * var_23;

    if(var_24 > var_3)
      var_25 = var_0;
    else
      var_25 = var_1;

    var_3 = var_3 + (var_24 - var_3) * var_25;
    var_22 = scripts\sp\math::_id_C097(0, var_4, var_3);
    setomnvar("ui_jackal_booster_charge", var_22);

    if(var_3 > var_4 && scripts\engine\utility::flag("flag_can_launch")) {
      var_17 = 1;
      scripts\engine\utility::flag_clear("jackal_reving_hint");
    } else {
      var_17 = 0;
      scripts\engine\utility::flag_clear("jackal_launching_hint");
      var_19 = 0;

      if(var_3 < var_20 || var_18[0] < var_4) {
        if(!scripts\engine\utility::flag("jackal_reving_hint")) {
          scripts\engine\utility::flag_set("jackal_reving_hint");
          _id_A2CE();
        }
      } else
        scripts\engine\utility::flag_clear("jackal_reving_hint");
    }

    if(var_17 && !var_19) {
      scripts\engine\utility::flag_set("jackal_launching_hint");
      thread scripts\sp\utility::_id_56BA("jackal_launch_start");
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
      if(!var_2 && var_17) {
        break;
      }

      var_2 = 1;
    } else
      var_2 = 0;

    if(scripts\engine\utility::flag("flag_launch_fail")) {
      break;
    }

    var_26 = scripts\sp\math::_id_6A8E(var_6, var_5, var_3);
    var_7 = var_7 + (var_26 - var_7) * var_8;
    var_27 = scripts\sp\math::_id_6A8E(var_9, var_10, var_3);
    var_28 = scripts\sp\math::_id_6A8E(var_11, var_12, var_3);
    var_29 = scripts\sp\math::_id_6A8E(0, var_13, var_3);
    var_15 _meth_8278(var_27, 0.05);
    var_15 _meth_8277(var_7, 0.05);
    earthquake(var_28, 0.3, level._id_D127.origin, 3000);
    var_14 scripts\sp\utility::_id_E7C9(var_29, 0.05);
    wait 0.05;
  }

  var_16 playSound("jackal_takeoff_build_plr_stop");
  setomnvar("ui_jackal_booster_charge", 0);
  setomnvar("ui_jackal_boosters_charging", 0);
  scripts\engine\utility::flag_clear("jackal_launching_hint");
  scripts\engine\utility::flag_clear("jackal_reving_hint");
  var_16 scripts\engine\utility::delaycall(0.5, ::stopsounds);
  var_15 thread _id_4091();
  var_16 scripts\engine\utility::delaycall(0.6, ::delete);
  var_14 delete();
  level notify("player_runway_takeoff");
}

_id_CFE0(var_0) {
  level._id_D127 endon("notify_player_launch");

  if(!scripts\engine\utility::flag_exist("flag_launch_fail"))
    scripts\engine\utility::flag_init("flag_launch_fail");

  while(var_0 > 0) {
    var_0 = var_0 - 0.05;
    wait 0.05;
  }

  scripts\engine\utility::flag_set("flag_launch_fail");
}

_id_11480(var_0) {
  foreach(var_2 in var_0) {
    killfxontag(scripts\engine\utility::getfx("vfx_hangar_launch_light_red"), var_2, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_hangar_launch_light_green"), var_2, "tag_origin");
  }
}

_id_1147F(var_0) {
  foreach(var_2 in var_0) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_hangar_launch_light_red"), var_2, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("vfx_hangar_launch_light_green"), var_2, "tag_origin");
  }
}

_id_4091() {
  self _meth_8278(0, 0.2);
  wait 0.2;
  self stoploopsound("jackal_boost_lp");
  self delete();
}

_id_11477() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  _id_0BDC::_id_A302(0.1, 0, "vtol_turn_takeoff");
  level.player _meth_8462(level._id_D127._id_BC85, "moveto", "absolute_player", 0.2, 0);
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A151();
  _id_0BDC::_id_A153();
  var_0 = 0;

  while(var_0 < 0.2) {
    var_1 = level.player getnormalizedmovement();
    var_2 = level.player _meth_814B();
    var_0 = abs(var_1[0]) + abs(var_1[1]) + abs(var_2[0]) + abs(var_2[1]);
    wait 0.05;
  }

  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_clear, "jackal_taking_off");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.18, 0.6, level._id_D127.origin, 3000);
  _id_0BDC::_id_A302(1.0, 7, "vtol_turn_takeoff");
  level.player _meth_8462(level._id_D127._id_BC85, "moveto", "absolute_player", 1, 7);
  wait 1.2;
  _id_0BDC::_id_A153(0);
  wait 1.8;
  level.player scripts\sp\utility::_id_65E1("flag_takeoff_cooldown");
  _id_0BDC::_id_A15C(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A151(0);
}

_id_11484() {
  scripts\engine\utility::flag_set("jackal_taking_off");
  level._id_D127 _meth_8491("hover");
  _id_0BDC::_id_A2DE(1, 0);
  var_0 = level.player scripts\engine\utility::spawn_tag_origin();
  var_0.angles = (0, 0, 1);
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_1.origin + anglesToForward(var_1.angles) * 100000;
  _id_0BDC::_id_D165(var_1, 1, 0, 0, 1);
  _id_0BDC::_id_D16C(var_0, 1, 0, 0, 1);
  _id_0BDC::_id_A14D(1);
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A151();
  var_2 = level.player scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(var_2);
  var_3 = var_2.angles[2];
  thread _id_11485(var_2, var_3);
  scripts\engine\utility::flag_wait("flag_jackal_can_takeoff");
  scripts\sp\utility::_id_56BA("jackal_takeoff");

  while(!level.player _meth_81CE())
    wait 0.05;

  self notify("stop_sa_gunner_rotate_think");
  level.player notify("jackal_start_taking_off");
  var_2 rotateTo((var_2.angles[0], var_3, var_2.angles[2]), 0.7, 0.1, 0.2);
  var_0 moveTo(var_0.origin + (0, 0, 100), 1.4, 0.1, 0.2);
  wait 2.0;
  level.player notify("jackal_taking_off");
  _id_0BDC::_id_A2DE(0);
  _id_0BDC::_id_D165(var_1, 0, 1, 0, 1);
  _id_0BDC::_id_D16C(var_0, 0, 1, 0, 1);
  _id_0BDC::_id_A1DD("fly");
  _id_0BDC::_id_D165(var_1.origin, 1, 0, 0.2, 1);
  _id_0BDC::_id_A0BE(1);
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.18, 0.6, level._id_D127.origin, 3000);
  wait 2.0;
  level.player notify("jackal_done_taking_off");
  level.player scripts\sp\utility::_id_65E1("flag_takeoff_cooldown");
  _id_0BDC::_id_D165(var_1.origin, 0, 1, 0.2, 1);
  _id_0BDC::_id_A14D(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A151(0);
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A0BE(0);
  var_0 delete();
  var_1 delete();
}

_id_11485(var_0, var_1) {
  self endon("stop_sa_gunner_rotate_think");
  var_2 = 10.0;
  var_3 = 0.7;
  var_4 = 0.7;
  var_5 = 0;
  var_6 = "none";

  for(;;) {
    var_7 = level.player _meth_814B();

    if(var_7[1] < 0) {
      if(var_6 == "left")
        var_5 = clamp(var_5 + var_3, 0 - var_4, var_4);
      else {
        var_6 = "left";
        var_5 = var_3;
      }
    } else if(var_7[1] > 0) {
      if(var_6 == "right")
        var_5 = clamp(var_5 - var_3, 0 - var_4, var_4);
      else {
        var_6 = "right";
        var_5 = 0 - var_3;
      }
    } else {
      var_6 = "none";
      wait 0.05;
      continue;
    }

    var_8 = clamp(var_0.angles[1] + var_5, var_1 - var_2, var_1 + var_2);
    var_0.angles = (var_0.angles[0], var_8, var_0.angles[2]);
    wait 0.05;
  }
}

_id_A7BB() {}

#using_animtree("jackal");

_id_BBD0(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(self._id_99F5._id_BBE7 == "left") {
    var_5 = % jackal_pilot_mount_01_port;
    var_6 = % jackal_vehicle_mount_01_port;

    if(isDefined(var_1))
      var_5 = var_1;

    if(isDefined(var_2))
      var_6 = var_2;
  } else {
    var_5 = % jackal_pilot_mount_01_starboard;
    var_6 = % jackal_vehicle_mount_01_starboard;

    if(isDefined(var_3))
      var_5 = var_3;

    if(isDefined(var_4))
      var_6 = var_4;
  }

  if(isDefined(self._id_BBC9))
    var_5 = self._id_BBC9;

  if(isDefined(self._id_BBCA))
    var_6 = self._id_BBCA;

  _id_BBE2();
  self _meth_8491("land");

  if(isDefined(self._id_99F5._id_2ADD)) {
    return;
  }
  _id_107A1();
  wait 0.05;
  var_7 = _id_1ED3(var_5, "finish_link");
  level.player scripts\engine\utility::delaycall(0.05, ::_meth_823C, self._id_AD34, "tag_origin", var_7, var_7 * 0.5, var_7 * 0.5);
  level.player scripts\engine\utility::delaycall(var_7, ::playerlinktodelta, self._id_AD34, "tag_origin", 1, 45, 45, 45, 15, 1);
  level.player scripts\engine\utility::delaycall(var_7 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_7 + 0.05, ::_meth_8392, 2, 2.2, 0.6);
  level.player scripts\engine\utility::delaythread(var_7 + 0.05, ::_id_5115, "mount_link_complete");
  var_8 = 1;
  thread _id_BBC8(var_5, var_6, var_8);
  self waittill("start_lerping_view");

  if(!var_0)
    level.player lerpviewangleclamp(var_8, 0.5 * var_8, 0.5 * var_8, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_0) {
    _id_BBE3();
    _id_E076();
  }

  return "land";
}

_id_BBD1(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(self._id_99F5._id_BBE7 == "left") {
    var_1 = % jackal_pilot_mount_01_port;
    var_2 = % jackal_vehicle_mount_01_port;
  } else {
    var_1 = % jackal_pilot_mount_01_starboard;
    var_2 = % jackal_vehicle_mount_01_starboard;
  }

  _id_BBE2();
  self _meth_8491("land");
  wait 0.05;
  var_3 = _id_1ED3(var_1, "finish_link");
  _id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_origin", var_3, var_3 * 0.5, var_3 * 0.5);
  level.player scripts\engine\utility::delaycall(var_3, ::playerlinktodelta, self._id_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_3 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_3 + 0.05, ::_meth_8392, 2, 2.2, 0.6);
  level.player scripts\engine\utility::delaythread(var_3 + 0.05, ::_id_5115, "mount_link_complete");
  var_4 = 1;
  thread _id_BBC8(var_1, var_2, var_4);
  self waittill("start_lerping_view");

  if(!var_0)
    level.player lerpviewangleclamp(var_4, 0.5 * var_4, 0.5 * var_4, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_0) {
    _id_BBE3();
    _id_E076();
  }

  return "land";
}

_id_5115(var_0) {
  self notify(var_0);
}

_id_BBDE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = % ph_jackals_launch_space_plr_starboard_dps;
  var_6 = % ph_jackals_launch_space_jackal_starboard_dps;
  _id_BBD0(var_0, undefined, undefined, var_5, var_6);
}

_id_BBE4() {
  self notify("mount_runway");
  _id_11481();
  return _id_BBD0();
}

_id_BBE5() {
  self notify("mount_runway_moon");
  _id_11481();
  self._id_99F5._id_2ADD = 1;
  _id_BBD0(1);
  wait 500;
}

_id_11481() {
  level._id_A056._id_E8AD = spawnStruct();
  level._id_A056._id_E8AD._id_AA60 = [];
  var_0 = getEntArray("jackal_takeoff_blastshield", "script_noteworthy");

  foreach(var_2 in var_0) {
    level._id_A056._id_E8AD._id_AA60 = scripts\engine\utility::array_add(level._id_A056._id_E8AD._id_AA60, var_2);
    var_2.cleanup = [];
    var_3 = getEntArray(var_2.targetname, "target");

    foreach(var_5 in var_3) {
      var_5 linkTo(var_2);
      var_2.cleanup = scripts\engine\utility::array_add(var_2.cleanup, var_5);

      if(var_5.targetname == "takeoff_blastshield") {
        var_2._id_2B66 = var_5;
        continue;
      }

      if(var_5.targetname == "takeoff_fx")
        var_2._id_11475 = var_5;
    }
  }

  var_8 = scripts\engine\utility::getStructArray("jackal_takeoff_lights", "script_noteworthy");
  var_9 = scripts\engine\utility::getclosest(level._id_D127.origin, var_8);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_9.origin;

  if(isDefined(var_9.angles))
    var_2.angles = var_9.angles;

  if(isDefined(var_9.target))
    var_2.target = var_9.target;

  if(isDefined(var_9.targetname))
    var_2.targetname = var_9.targetname;

  var_2.lights = [];
  var_2.cleanup = [];
  var_10 = scripts\engine\utility::getStructArray(var_2.targetname, "target");

  foreach(var_12 in var_10) {
    var_5 = scripts\engine\utility::spawn_tag_origin();
    var_5.origin = var_12.origin;

    if(isDefined(var_12.angles))
      var_5.angles = var_12.angles;

    var_5.target = var_12.target;
    var_5.targetname = var_12.targetname;
    var_2.cleanup = scripts\engine\utility::array_add(var_2.cleanup, var_5);
    var_2.lights = scripts\engine\utility::array_add(var_2.lights, var_5);
    var_5 linkTo(var_2);
    playFXOnTag(scripts\engine\utility::getfx("vfx_hangar_launch_light_red"), var_5, "tag_origin");
  }

  level._id_A056._id_E8AD._id_AA83 = var_2;
}

_id_BBE9() {
  thread _id_BBEA(6.5);
  _id_BBDD(1);

  if(!getdvarint("titan_newjackal"))
    level waittill("briefing_nearly_complete");

  var_0 = 1.5;
  level.player lerpviewangleclamp(var_0, 0.5, 1, 0, 0, 0, 0);
  wait(var_0);

  if(!getdvarint("titan_newjackal"))
    level waittill("briefing_complete");

  if(soundexists("titan_plr_letsdoit"))
    level.player scripts\sp\utility::_id_10347("titan_plr_letsdoit");

  _id_BBE3();
  return "hover";
}

_id_BBEA(var_0) {
  if(!getdvarint("jackal_video_capture")) {
    if(getdvarint("titan_newjackal"))
      return;
  }

  wait(var_0);

  if(getdvarint("jackal_video_capture")) {
    level thread scripts\sp\utility::_id_C12D("briefing_nearly_complete", 14);
    wait 16;
  } else {
    setomnvar("ui_show_bink", 1);
    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "1");
    var_1 = 0;
    cinematicingame("titan_briefing_mid_mission");
    wait 14;
    level notify("briefing_nearly_complete");

    while(iscinematicplaying())
      wait 0.05;

    wait 0.05;
    setomnvar("ui_show_bink", 0);
    level notify("briefing_complete");
  }
}

_id_BBDD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, %jackal_pilot_mount_02_starboard);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, %jackal_vehicle_mount_02_starboard);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, %jackal_vehicle_assault_motion_idle);
  _id_BBE2();
  self _meth_8491("hover");
  wait 0.05;
  var_7 = _id_1ED3(var_4, "finish_link");
  _id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_origin", var_7, var_7 * 0.5, var_7 * 0.5);
  level.player scripts\engine\utility::delaycall(var_7, ::playerlinktodelta, self._id_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_7 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_7 + 0.05, ::_meth_8392, 2, 2.2, 0.6);
  var_8 = 1;
  thread _id_BBC8(var_4, var_5, var_8, var_6);
  self waittill("start_lerping_view");

  if(!var_0)
    level.player lerpviewangleclamp(var_8, 0.5 * var_8, 0.5 * var_8, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_0) {
    _id_BBE3();
    _id_E076();
  }

  return "hover";
}

_id_BBEF(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(self._id_99F5._id_BBE7 == "left") {
    var_1 = % jackal_pilot_zg_mount_01_port;
    var_2 = % jackal_vehicle_zg_mount_01_port;
    var_3 = % jackal_vehicle_zg_motion_idle;
  } else if(self._id_99F5._id_BBE7 == "right") {
    var_1 = % jackal_pilot_zg_mount_01_starboard;
    var_2 = % jackal_vehicle_zg_mount_01_starboard;
    var_3 = % jackal_vehicle_zg_motion_idle;
  } else {
    var_1 = % jackal_pilot_zg_mount_01_front;
    var_2 = % jackal_vehicle_zg_mount_01_front;
    var_3 = % jackal_vehicle_zg_motion_idle;
  }

  _id_BBE2();
  self _meth_8491("land");
  wait 0.05;
  var_4 = _id_1ED3(var_1, "finish_link");
  _id_107A1();
  level.player _meth_8507();
  level.player scripts\engine\utility::delaycall(var_4 + 0.05, ::_meth_84F0, 0);
  level.player _meth_823C(self._id_AD34, "tag_origin", var_4, var_4 * 0.5, var_4 * 0.5);
  level.player scripts\engine\utility::delaycall(var_4, ::playerlinktodelta, self._id_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_4 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_4 + 0.05, ::_meth_8392, 2, 2.2, 0.6);
  var_5 = 1;
  var_3 = undefined;
  thread _id_BBC8(var_1, var_2, var_5, var_3);
  self waittill("start_lerping_view");

  if(!var_0)
    level.player lerpviewangleclamp(var_5, 0.5 * var_5, 0.5 * var_5, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_0) {
    _id_BBE3();
    _id_E076();
  }

  return "hover";
}

_id_BBF0(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(self._id_99F5._id_BBE7 == "left") {
    var_1 = % sa_emp_jackal_ca_pilot_zg_mount_01_port;
    var_2 = % sa_emp_jackal_ca_vehicle_zg_mount_01_port;
  } else {
    var_1 = % sa_emp_jackal_ca_pilot_zg_mount_01_starboard;
    var_2 = % sa_emp_jackal_ca_vehicle_zg_mount_01_starboard;
  }

  _id_BBE2();
  self _meth_8491("land");
  wait 0.05;
  var_3 = _id_1ED3(var_1, "finish_link");
  _id_107A1();
  level.player _meth_8507();
  level.player _meth_84F0(0);
  level.player _meth_823C(self._id_AD34, "tag_origin", var_3, var_3 * 0.5, var_3 * 0.5);
  level.player scripts\engine\utility::delaycall(var_3, ::playerlinktodelta, self._id_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_3 + 0.05, ::lerpviewangleclamp, 2, 0, 0, 25, 25, 25, 25);
  level.player scripts\engine\utility::delaycall(var_3 + 0.05, ::_meth_8392, 2, 2.2, 0.6);
  var_4 = 1;
  var_5 = undefined;
  thread _id_BBC8(var_1, var_2, var_4, var_5);
  self waittill("start_lerping_view");

  if(!var_0)
    level.player lerpviewangleclamp(var_4, 0.5 * var_4, 0.5 * var_4, 0, 0, 0, 0);

  self waittill("mount_anims_complete");

  if(!var_0) {
    _id_BBE3();
    _id_E076();
  }

  return "hover";
}

_id_BBC8(var_0, var_1, var_2, var_3) {
  level notify("jackal_enter");
  spawn_jackal_mip_buffer(level.vehicle._id_116CE._id_13265[self.classname]._id_D375);
  var_4 = 0.2;
  var_5 = getanimlength(var_0);
  var_6 = 0.2;
  _id_0BDC::_id_A2DE(1, var_6);
  self setanimknob(var_0, 1, var_6);
  self _meth_82A2(var_1, 1, var_6);

  if(isDefined(var_3))
    self _meth_82A2(var_3);

  if(_id_9C2B(var_0)) {
    thread _id_1EC6(var_0, "ps_plr_foley_jumpon_jackal", ::_id_A2C8);
    thread _id_1EC6(var_0, "ps_plr_foley_jumpon_jackal_cockpit_lr", ::_id_A2C9);
  } else if(_id_9D1F(var_0)) {
    thread _id_A1A7();
    thread _id_A1A6();
  } else {
    thread _id_1EC6(var_0, "ps_plr_foley_enter_jackal", ::_id_A2BF, undefined, 1);
    thread _id_1EC6(var_0, "ps_plr_foley_enter_jackal_cockpit_lr", ::_id_A2C0, undefined, 1);
    thread _id_1EC6(var_0, "ps_plr_foley_jackal_mount_europa01", ::_id_A2C5, undefined, 1);
    thread _id_1EC6(var_0, "ps_plr_foley_jackal_mount_europa02", ::_id_A2C6, undefined, 1);
    thread _id_1EC6(var_0, "ps_plr_foley_jackal_mount_europa03", ::_id_A2C7, undefined, 1);
    thread _id_1EC6(var_0, "plr_titan_enter_jackal_cockpit", ::_id_D5E9, undefined, 1);
    thread _id_1EC6(var_0, "plr_sc_enter_jackal_cockpit_a", ::_id_D5E5, undefined, 1);
    thread _id_1EC6(var_0, "plr_sc_enter_jackal_cockpit_b", ::_id_D5E6, undefined, 1);
    thread _id_1EC6(var_0, "ps_plr_helmet_on", ::_id_DADD, undefined, 1);
    thread _id_1EC6(var_0, "heist_mons_mount_sfx", ::_id_8D1C, undefined, 1);
  }

  if(!animhasnotetrack(var_0, "no_hud"))
    thread _id_1EC6(var_0, "hud_boot", _id_0BDC::_id_A228);

  thread _id_1EC6(var_0, "screens_on", _id_0BDC::_id_A110);
  thread _id_1EC6(var_0, "lights_on", ::_id_BBE0);
  thread _id_1EC6(var_0, "canopy_shut", ::_id_BBCE);
  thread _id_1EC6(var_0, "engine_boot", ::_id_BBCB);
  thread _id_1EC6(var_0, "unhide_viewmodel", ::_id_BBEC);
  thread _id_1EC6(var_1, "decomp_fx", ::_id_5689, undefined, 1);
  thread _id_1EC6(var_0, "helmet_on", ::_id_BBD7, undefined, 1);
  thread _id_11316(var_0);
  wait(var_5 - var_2);
  self notify("start_lerping_view");
  wait(var_2 - var_4);
  self _meth_82A2(var_0, 0, 0.2);
  self _meth_82A2(var_1, 0, 0.2);
  self _meth_82A2(%jackal_motion_idle_p, 1, 0.0);
  _id_0BDC::_id_A2DE(0);
  wait 0.05;
  self notify("mount_anims_complete");
}

_id_8D1C() {
  level.player playSound("scn_heist_jackal_mount");
  wait 3.8;
  level.player _meth_82C0("jackal_cockpit", 1);
}

_id_D5E9() {
  level.player playSound("plr_titan_enter_jackal_cockpit");
  wait 4;
  level.player playSound("jackal_warmup_plr");
  wait 2;
  level.player _meth_82C0("jackal_cockpit", 1);
}

_id_D5E5() {
  level.player playSound("plr_sc_enter_jackal_cockpit_a");
}

_id_D5E6() {
  level.player playSound("plr_sc_enter_jackal_cockpit_b");
  wait 3.2;
  level.player _meth_82C0("jackal_cockpit", 0.5);
}

_id_DADD() {
  level.player playSound("plr_helmet_on");
}

_id_9C2B(var_0) {
  if(var_0 == % jackal_pilot_mount_02_starboard)
    return 1;

  return 0;
}

_id_9D1F(var_0) {
  if(var_0 == % jackal_pilot_zg_mount_01_port)
    return 1;

  if(var_0 == % jackal_pilot_zg_mount_01_starboard)
    return 1;

  if(var_0 == % jackal_pilot_zg_mount_01_front)
    return 1;

  if(var_0 == % sa_emp_jackal_ca_vehicle_zg_mount_01_port)
    return 1;

  if(var_0 == % sa_emp_jackal_ca_vehicle_zg_mount_01_starboard)
    return 1;

  return 0;
}

_id_BBDB() {
  _id_BBDA();
  return "fly";
}

_id_BBD8() {
  _id_BBDA();
  return "hover";
}

_id_BBD9() {
  _id_BBDA();
  return "land";
}

_id_BBDA() {
  self clearanim(%root, 0.0);
  scripts\engine\utility::delaythread(0.1, _id_0BDC::_id_A334);
  _id_F919(1);
  level.player _meth_818A();
  level.player _meth_84FE();
  setomnvar("ui_jackal_weapon_display_temp", 1);
}

_id_BBCF() {
  _id_BBD0(1);
  level.player _meth_8391(0);
  self notify("launch_ready");
  level waittill("forever");
}

_id_BBE6() {
  level notify("shipcrib_europa_launch_started");
  _id_0BDC::_id_A153(1);
  var_0 = _id_1ED3(level._id_CB8A, "finish_link");
  level.player scripts\engine\utility::delaycall(var_0 + 0.1, ::lerpviewangleclamp, 1, 0.5, 0.5, 15, 15, 15, 15);

  if(isDefined(level._id_CB8A) && isDefined(level.vehicle_allows_rider_death))
    _id_BBD0(1, level._id_CB8A, level.vehicle_allows_rider_death, level._id_CB8A, level.vehicle_allows_rider_death);
  else
    _id_BBD0(1);

  _id_0BDC::_id_A1DD("land");
  _id_0BDC::_id_A15B(1);
  _id_0BDC::_id_A151(1);
  _id_0BDC::_id_A153(1);
  level.player _meth_8391(0);
  level notify("shipcrib_europa_launch_complete");
  return "land";
}

spawn_jackal_mip_buffer(var_0) {
  if(isDefined(level._id_A056.mip_buffer_model)) {
    return;
  }
  var_1 = -1000;
  var_2 = level.player.origin + anglesToForward(level.player.angles) * var_1;
  level._id_A056.mip_buffer_model = spawn("script_model", var_2);
  level._id_A056.mip_buffer_model setModel(var_0);
  level._id_A056.mip_buffer_model dontcastshadows();
  level._id_A056.mip_buffer_model notsolid();
  level._id_A056.mip_buffer_model thread jackal_mip_buffer_offscreen(var_1);
}

jackal_mip_buffer_offscreen(var_0) {
  level.player endon("death");
  self endon("death");

  for(;;) {
    self.origin = level.player.origin + anglesToForward(level.player getplayerangles()) * var_0;
    wait 0.05;
  }
}

_id_11316(var_0) {
  if(animhasnotetrack(var_0, "swap_jackal_model"))
    wait(scripts\engine\utility::get_notetrack_time(var_0, "swap_jackal_model"));
  else if(animhasnotetrack(var_0, "unhide_viewmodel"))
    wait(scripts\engine\utility::get_notetrack_time(var_0, "unhide_viewmodel"));
  else if(animhasnotetrack(var_0, "finish_link"))
    wait(scripts\engine\utility::get_notetrack_time(var_0, "finish_link"));
  else
    wait 0.2;

  _id_A32A();
}

_id_F919(var_0) {
  if(isDefined(level._id_A056.mount_instant_hud_boot_delay)) {
    setomnvar("ui_hide_hud", 1);
    var_1 = level._id_A056.mount_instant_hud_boot_delay;
    level._id_A056.mount_instant_hud_boot_delay = undefined;
  } else
    var_1 = 0;

  if(var_0)
    thread _id_BBE0();
  else
    thread _id_BBDF();

  if(var_0) {
    _id_0BDC::_id_A110(1);

    if(var_1 > 0)
      scripts\engine\utility::delaythread(var_1, _id_0BDC::_id_A228);
    else
      _id_0BDC::_id_A228();
  } else {
    _id_0BDC::_id_A10F();
    _id_0BDC::_id_A226();
  }
}

_id_1EF4(var_0, var_1, var_2, var_3) {
  if(animhasnotetrack(var_0, var_1))
    wait(scripts\engine\utility::get_notetrack_time(var_0, var_1));
  else {}

  setomnvar(var_2, var_3);
}

_id_1EC6(var_0, var_1, var_2, var_3, var_4) {
  if(animhasnotetrack(var_0, var_1))
    wait(scripts\engine\utility::get_notetrack_time(var_0, var_1));
  else {
    if(isDefined(var_4) && var_4) {
      return;
    }
    if(isDefined(var_3))
      wait(var_3);
    else {}
  }

  [[var_2]]();
}

_id_1ED3(var_0, var_1) {
  if(!animhasnotetrack(var_0, var_1))
    return 0;
  else
    return scripts\engine\utility::get_notetrack_time(var_0, var_1);
}

_id_BBCE() {
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.13, 0.5, level._id_D127.origin, 5000);
}

_id_BBE0() {
  _id_0BDC::_id_4310();
}

_id_A2BF() {
  level.player playSound("plr_foley_enter_jackal");
}

_id_A2C0() {
  level.player playSound("plr_foley_enter_jackal_cockpit_lr");
  wait 2.45;
  level.player playSound("jackal_warmup_plr");
  wait 0.75;
  wait 1;
  level.player _meth_82C0("jackal_cockpit");
}

_id_A2C5() {
  level.player playSound("plr_foley_jackal_mount_europa01");
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "jackal_cockpit_backpack_plr");
  wait 2.12;
  level.player playSound("jackal_warmup_plr");
}

_id_A2C6() {
  level.player playSound("plr_foley_jackal_mount_europa02");
}

_id_A2C7() {
  level.player playSound("plr_foley_jackal_mount_europa03");
  wait 2.38;
  level.player _meth_82C0("jackal_cockpit");
}

_id_A2C8() {
  level.player playSound("plr_foley_jumpon_jackal");
}

_id_A2C9() {
  level.player playSound("plr_foley_jumpon_jackal_cockpit_lr");
  wait 2.45;
  level.player playSound("jackal_warmup_plr");
  wait 0.75;
  wait 1;
  level.player _meth_82C0("jackal_cockpit");
}

_id_A2C1() {
  level.player playSound("plr_foley_exit_jackal");
}

_id_A2C2() {
  if(isDefined(level.script) && level.script == "titanjackal")
    level.player playSound("plr_foley_exit_jackal_cockpit_lr");
}

_id_A2C4() {
  level.player playSound("plr_foley_exit_jackal");
}

_id_A2C3() {
  level.player playSound("plr_foley_exit_jackal_cockpit_lr");
}

_id_BBDF() {
  _id_0BDC::_id_430E();
}

_id_BBD7() {
  thread _id_0E4B::_id_8E05();
  thread _id_0B0B::_id_25C0(0.0);

  if(isDefined(level._id_A056._id_87D8)) {
    wait(level._id_A056._id_87D8);
    _id_0E4B::_id_8DEA();
  }
}

_id_BBCB() {
  level.player playSound("jackal_warmup2_plr");
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.15, 0.5, level._id_D127.origin, 5000);
}

_id_BBEC() {
  _id_0BDC::_id_A208(0);
  level.player _meth_818A();
  level.player _meth_84FE();
}

_id_BBE2() {
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
}

_id_BBE3() {
  level.player unlink(1);
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
}

_id_5699() {
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_818A();
}

_id_569D() {
  level.player unlink(1);
  level.player showviewmodel();
  level.player _meth_84FD();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
}

_id_568A() {
  level.player freezecontrols(0);
  level.player showviewmodel();
  level.player enableweapons();
  level.player enableoffhandweapons();
}

_id_5685() {
  var_0 = self gettagorigin("tag_player");
  var_1 = self gettagangles("tag_player");
  level.player setOrigin(var_0);
  level.player setplayerangles(var_1);
  _id_5699();
  self _meth_848E(1);
  _id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_origin", 0);
  wait 0.05;
  _id_5681(%jackal_pilot_dismount_01_port, %jackal_vehicle_dismount_01_port);
  _id_569D();
  return "landed_mode";
}

_id_56A6() {
  var_0 = self gettagorigin("tag_player");
  var_1 = self gettagangles("tag_player");
  level.player setOrigin(var_0);
  level.player setplayerangles(var_1);
  _id_5699();
  self _meth_848E(1);
  _id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_player", 0);
  wait 0.05;
  level.player playerlinktodelta(self._id_AD34, "tag_player", 1, 20, 20, 5, 5, 1);
  level.player _meth_8392(1, 2.2, 0.6);
  _id_5682(%jackal_pilot_zg_dismount_01, %jackal_vehicle_zg_dismount_01);
  _id_569D();
  level notify("dismount_anim_ended");
  return "hover";
}

_id_568B() {
  var_0 = 0.05;
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player _meth_84FE();
  thread _id_A0F9();
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 0, 0, 0, 0, 1);
  level._id_D267 scripts\engine\utility::delaycall(var_0, ::show);
  level.player thread scripts\sp\utility::_id_65E2("eject_complete", 0.05);
  level.player scripts\engine\utility::delaycall(var_0 + 0.05, ::lerpviewangleclamp, 2, 0.1, 1, 10, 10, 10, 10);
  level notify("dismount_anim_ended");
  return "fly";
}

_id_5695() {
  var_0 = self gettagorigin("tag_player");
  var_1 = self gettagangles("tag_player");
  level.player setOrigin(var_0);
  level.player setplayerangles(var_1);
  _id_5699();
  self _meth_848E(1);
  _id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_player", 0);
  wait 0.05;
  level.player playerlinktodelta(self._id_AD34, "tag_player", 1, 40, 40, 20, 15, 1);
  level.player _meth_8392(1, 2.2, 0.6);
  _id_569D();
  level notify("dismount_anim_ended");
  return "fly";
}

_id_5684() {
  var_0 = self gettagorigin("tag_player");
  var_1 = self gettagangles("tag_player");
  level.player setOrigin(var_0);
  level.player setplayerangles(var_1);
  _id_5699();
  self _meth_848E(1);
  _id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_origin", 0);
  wait 0.05;
  level.player playerlinktodelta(self._id_AD34, "tag_origin", 1, 40, 40, 20, 15, 1);
  level.player _meth_8392(1, 2.2, 0.6);
  _id_5681(%jackal_pilot_dismount_01_port, %jackal_vehicle_dismount_01_port, "player_dismount");
  _id_569D();
  return "landed_mode";
}

_id_56A0() {
  level notify("dismount_shipcrib_moon");
  level waittill("dismount_shipcrib_moon_complete");
  self._id_99F5._id_BBF1 = 0;
  return "landed_mode";
}

_id_569F() {
  level notify("dismount_shipcrib_gravity");
  level waittill("dismount_shipcrib_gravity_complete");
  self._id_99F5._id_BBF1 = 0;
  return "landed_mode";
}

_id_568E() {
  _id_F919(0);
  _id_0BDC::_id_A2DE(1, 0);
  return "landed_mode";
}

_id_5681(var_0, var_1, var_2) {
  var_3 = getanimlength(var_0);
  var_4 = 0.2;
  _id_0BDC::_id_A2DE(1, var_4);
  self setanimknob(var_0, 1, var_4);
  self _meth_82A2(var_1, 1, var_4);

  if(isDefined(var_2)) {
    self _meth_82B1(var_0, 0);
    self _meth_82B1(var_1, 0);
    self waittill(var_2);
    self setanimknob(var_0, 1, 0.2, 1);
    self _meth_82A2(var_1, 1, 0.2, 1);
  }

  thread _id_1EC6(var_0, "hud_off", _id_0BDC::_id_A226);
  thread _id_1EC6(var_0, "ps_plr_foley_exit_jackal", ::_id_A2C1);
  thread _id_1EC6(var_0, "ps_plr_foley_exit_jackal_cockpit_lr", ::_id_A2C2);
  thread _id_1EC6(var_0, "lights_off", ::_id_BBDF);
  thread _id_1EC6(var_0, "screens_off", _id_0BDC::_id_A10F);
  thread _id_1EC6(var_0, "engine_off", ::_id_568F);
  thread _id_1EC6(var_0, "swap_jackal_model", ::_id_A330, 4);
  wait(var_3);
  self _meth_82A2(var_0, 0, 0.2);
  self _meth_82A2(var_1, 0, 0.2);
}

_id_5682(var_0, var_1, var_2) {
  var_3 = getanimlength(var_0);
  var_4 = 0.2;
  _id_0BDC::_id_A2DE(1, var_4);
  self setanimknob(var_0, 1, var_4);
  self _meth_82A2(var_1, 1, var_4);

  if(isDefined(var_2)) {
    self _meth_82B1(var_0, 0);
    self _meth_82B1(var_1, 0);
    self waittill(var_2);
    self setanimknob(var_0, 1, 0.2, 1);
    self _meth_82A2(var_1, 1, 0.2, 1);
  }

  thread _id_1EC6(var_0, "screens_off", _id_0BDC::_id_A10F);
  thread _id_1EC6(var_0, "hud_off", _id_0BDC::_id_A226);
  thread _id_1EC6(var_0, "lights_off", ::_id_BBDF);
  thread _id_1EC6(var_0, "engine_off", ::_id_568F);
  thread _id_1EC6(var_1, "decomp_fx", ::_id_5689);
  thread _id_1EC6(var_0, "swap_jackal_model", ::_id_A32A, 0.05);
  thread _id_1EC6(var_0, "gun_up", ::_id_568A);
  thread _id_A1B6();
  thread _id_A1B5();
  _id_88C8(level.player, self, 0.005, var_3);
  self _meth_82A2(var_0, 0, 0.2);
  self _meth_82A2(var_1, 0, 0.2);
}

_id_88C8(var_0, var_1, var_2, var_3, var_4) {
  var_0 _meth_8239(1);

  if(isDefined(var_3))
    wait(var_3);
  else if(scripts\engine\utility::is_true(var_4))
    var_1 waittillmatch("single anim", "end");
  else
    var_1 waittill("movedone");

  var_5 = var_0 getvelocity();
  var_6 = vectorNormalize(var_5);
  var_7 = length(var_5);

  if(!isDefined(var_2))
    var_2 = 200;

  var_8 = var_7 / var_2;
  var_9 = var_8;
  var_10 = var_7 * var_9 * 0.5;
  var_11 = var_0.origin + var_10 * var_6;
  var_6 = vectorNormalize(var_11 - var_0.origin);
  var_0 unlink();
  var_0 setvelocity(var_6 / var_2);
  thread _id_88B2();
}

_id_88B2() {
  _id_12975();
  wait 2;
  _id_12994();
}

_id_12975() {
  setsaveddvar("bg_viewBobAmplitudeStanding", 0.0);
  setsaveddvar("bg_weaponBobAmplitudeStanding", 0.0);
}

_id_12994() {
  setsaveddvar("bg_viewBobAmplitudeStanding", 0.007);
  setsaveddvar("bg_weaponBobAmplitudeStanding", 0.007);
}

_id_5689() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_cockpit_decomp"), self, "tag_body");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_cockpit_canopy"), self, "j_canopy");
}

_id_568F(var_0) {
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.15, 0.5, level._id_D127.origin, 5000);
}

_id_A2F2(var_0, var_1) {
  if(isDefined(var_0)) {
    if(var_0 == "right")
      var_2 = self._id_E8CB;
    else
      var_2 = self._id_E8AD;
  } else
    var_2 = self._id_E8AD;

  scripts\engine\utility::flag_set("jackal_runway_landing_active");
  scripts\engine\utility::flag_set("jackal_runway_first_attempt");
  scripts\engine\utility::flag_clear("jackal_sees_ret_for_landing");

  if(!scripts\engine\utility::flag_exist("flag_landing_reapproach"))
    scripts\engine\utility::flag_init("flag_landing_reapproach");
  else
    scripts\engine\utility::flag_clear("flag_landing_reapproach");

  wait 3;
  thread _id_E3E0();

  if(!isDefined(var_1))
    thread _id_E3ED();

  scripts\engine\utility::flag_waitopen("jackal_missile_drone_active");
  _id_0BD6::disable_missile_drone_event();
  var_2 _id_3AC2();
  var_2 thread _id_3AE6(var_1);
  var_2 thread _id_3AE8(var_1);
  var_2 thread _id_3AE5();
  var_2 _id_3AD8(var_1);
}

_id_A7EB() {
  level endon("stop_landing_hint");

  for(;;) {
    if(length(level._id_D127.spaceship_vel) < 15)
      _id_A7ED();
    else if(_id_0B76::_id_7A60(self.origin) < 0.3)
      _id_A7ED();
    else if(scripts\engine\utility::flag("jackal_hint_ret_return"))
      _id_A7EC();

    wait 0.05;
  }
}

_id_A7ED() {
  if(!scripts\engine\utility::flag("jackal_hint_ret_return")) {
    scripts\engine\utility::flag_set("jackal_hint_ret_return");
    scripts\sp\utility::_id_56BA("jackal_return_to_ret");
  }
}

_id_A7EC() {
  scripts\engine\utility::flag_clear("jackal_hint_ret_return");
  wait 3;
}

_id_A7EE() {
  level notify("stop_landing_hint");
  scripts\engine\utility::flag_clear("jackal_hint_ret_return");
}

_id_DDA4() {
  level endon("stop_reapproach_hint");

  for(;;) {
    if(length(level._id_D127.spaceship_vel) < 15)
      _id_DDA6();
    else if(_id_0B76::_id_7A60(self.origin) < 0.3)
      _id_DDA6();
    else if(scripts\engine\utility::flag("jackal_hint_ret_reapproach"))
      _id_DDA5();

    wait 0.05;
  }
}

_id_DDA6() {
  if(!scripts\engine\utility::flag("jackal_hint_ret_reapproach")) {
    scripts\engine\utility::flag_set("jackal_hint_ret_reapproach");

    if(scripts\engine\utility::flag("jackal_runway_first_attempt"))
      scripts\sp\utility::_id_56BA("jackal_hint_ret_approach");
    else
      scripts\sp\utility::_id_56BA("jackal_hint_ret_reapproach");
  }
}

_id_DDA5() {
  scripts\engine\utility::flag_clear("jackal_hint_ret_reapproach");
  wait 3;
}

_id_DDA7() {
  level notify("stop_reapproach_hint");
  scripts\engine\utility::flag_clear("jackal_hint_ret_reapproach");
}

_id_A2F1(var_0) {
  if(isDefined(var_0)) {
    if(var_0 == "right")
      var_1 = self._id_E8CB;
    else
      var_1 = self._id_E8AD;
  } else
    var_1 = self._id_E8AD;

  level notify("notify_stop_runway_landing");
  scripts\engine\utility::flag_clear("jackal_runway_landing_active");
  _id_A7EE();
  _id_DDA7();
  var_2 = var_1._id_102D1._id_5BD7;
  var_2 linkTo(self);
  var_2 _id_0BD6::_id_5C95();
  var_1 thread _id_3AC4();
  var_1 _id_3AD4(1);
  _id_D17B();
  var_1 _id_E8D0();
  var_1._id_5BD7 = var_2;
  var_1._id_4074 = scripts\engine\utility::array_remove(var_1._id_4074, var_2);
  level notify("stop_spline_think");

  foreach(var_4 in var_1._id_4074) {
    if(isDefined(var_4))
      var_4 delete();

    var_1._id_4074 = scripts\engine\utility::array_remove(var_1._id_4074, var_4);
  }

  var_1._id_4074 = scripts\engine\utility::array_add(var_1._id_4074, var_2);
}

_id_E3ED(var_0) {
  level endon("notify_stop_runway_landing");
  var_1 = 12000;
  var_2 = 25000;
  var_3 = 0.018;
  self._id_B3D5 = 0.0;

  if(!isDefined(self._id_E708))
    self._id_E708 = 1;

  if(!isDefined(self._id_EBA9))
    self._id_EBA9 = 1;

  self._id_EBA9 = clamp(self._id_EBA9, 0, 1);
  self._id_E708 = clamp(self._id_E708, 0, 1);
  thread _id_E3EC();
  var_4 = 8;
  var_5 = -3;
  var_6 = -20 * self._id_EBA9 + var_4 * (1 - self._id_EBA9);
  var_7 = 10 * self._id_EBA9 + var_4 * (1 - self._id_EBA9);
  var_8 = 20 * self._id_EBA9 + var_4 * (1 - self._id_EBA9);
  var_9 = -15 * self._id_EBA9 + var_4 * (1 - self._id_EBA9);
  var_10 = 35000;
  var_11 = -30000;

  for(;;) {
    if(scripts\engine\utility::flag_exist("flag_no_ret_land_rotation") && scripts\engine\utility::flag("flag_no_ret_land_rotation")) {
      wait 0.05;
      continue;
    }

    var_12 = level._id_D127.origin - self.origin;
    var_13 = length(var_12);
    var_14 = vectorNormalize(var_12);
    var_15 = -30;
    var_16 = rotatevector(var_14, (0, var_15, 0));
    var_17 = rotatevector(var_14, (0, var_15 - 90, 0));
    var_18 = (0, 0, 1);
    var_19 = self.origin;
    var_20 = axistoangles(var_16, var_17, var_18);
    var_21 = level._id_D127.origin[2] - self.origin[2];

    if(var_21 > 0) {
      var_22 = scripts\sp\math::_id_C097(0, var_10, var_21);
      var_23 = var_6;
      var_24 = var_7;
    } else {
      var_22 = 1 - scripts\sp\math::_id_C097(var_11, 0, var_21);
      var_23 = var_8;
      var_24 = var_9;
    }

    var_22 = scripts\sp\math::_id_C09B(var_22);
    var_25 = scripts\sp\math::_id_6A8E(var_4, var_23, var_22);
    var_26 = scripts\sp\math::_id_6A8E(var_5, var_24, var_22);

    if(isDefined(self._id_B74F))
      var_27 = clamp(var_20[1], self._id_B74F, self._id_B455);
    else
      var_27 = var_20[1];

    var_20 = (var_25, var_27, var_26);
    var_28 = anglesToForward(self.angles);
    var_29 = anglestoright(self.angles);
    var_30 = anglestoup(self.angles);
    var_31 = anglesToForward(var_20);
    var_26 = anglestoright(var_20);
    var_32 = anglestoup(var_20);
    var_33 = scripts\sp\math::_id_C097(var_1, var_2, var_13);
    var_34 = scripts\sp\math::_id_6A8E(0, var_3, var_33);
    var_16 = vectorNormalize(scripts\sp\math::_id_AB6F(var_28, var_31, var_34 * self._id_B3D5 * self._id_E708));
    var_17 = vectorNormalize(scripts\sp\math::_id_AB6F(var_29, var_26, var_34 * self._id_B3D5 * self._id_E708));
    var_18 = vectorNormalize(scripts\sp\math::_id_AB6F(var_30, var_32, var_34 * self._id_B3D5 * self._id_E708));
    var_20 = axistoangles(var_16, var_17, var_18);
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

_id_E3EC() {
  level endon("notify_stop_runway_landing");
  var_0 = 7.0;
  var_1 = 0;

  while(var_1 < var_0) {
    self._id_B3D5 = var_1 / var_0;
    var_1 = var_1 + 0.05;
    wait 0.05;
  }

  self._id_B3D5 = 1;
}

_id_E3E0() {
  if(!isDefined(self.script_team))
    self.script_team = "allies";

  if(!isDefined(self._id_AEDF))
    _id_0BDC::_id_105DB("capitalship", "JACKAL_RETRIBUTION", "none", "none", 0);

  self._id_AEDF._id_3A5C = "ally_objective";
  _id_0B76::_id_F42C(self._id_AEDF._id_3A5C);
  _id_0BDC::_id_1378D(0.9);
  scripts\engine\utility::flag_clear("jackal_hint_ret_return");
  self._id_AEDF._id_3A5C = "none";
  _id_0B76::_id_F42C(self._id_AEDF._id_3A5C);
  _id_0B76::_id_39C3(3);
  wait 1.2;
  scripts\engine\utility::flag_set("jackal_sees_ret_for_landing");
}

_id_3C3F(var_0) {
  if(self._id_AB5E == var_0) {
    return;
  }
  self._id_AB5E = var_0;
  _id_3AE2();
  thread _id_3AC7(1);
}

_id_3AE2() {
  if(self._id_AB5E == 3)
    var_0 = 27;
  else if(self._id_AB5E == 2)
    var_0 = 22;
  else if(self._id_AB5E == 1)
    var_0 = 17;
  else
    var_0 = 12;

  self._id_C28D linkTo(self.segments[var_0], "tag_origin", (0, 0, 0), (0, 0, 0));
}

_id_3AC2() {
  self._id_4074 = [];
  self._id_11A2A = 28;
  self._id_56E9 = 500;
  self._id_AB5E = _id_E8B2();

  if(isDefined(self._id_E311))
    self._id_E311.parent = self;

  self._id_5C6B = scripts\engine\utility::getclosest(self.origin, self._id_5C6C);
  _id_3ADE(self._id_11A2A);
  self._id_C28D = scripts\engine\utility::spawn_tag_origin();
  self._id_C28D _id_0BDC::_id_105DB("missile", undefined, "none", undefined, 0, undefined, 1);
  _id_3AE2();
  self._id_DDA8 = scripts\engine\utility::spawn_tag_origin();
  self._id_DDA8 _id_0BDC::_id_105DB("missile", undefined, "none", undefined, 0, undefined, 1);
  self._id_DDA8 linkTo(self.segments[0], "tag_origin", (15000, 1500, 2000), (0, 0, 0));
  self._id_A70D = 6;
  self._id_A70C = self._id_11A2A;
  var_0 = (-0, 0, 0);
  self.segments[0].origin = self.origin;
  self.segments[0].angles = self.angles + var_0;
  self.segments[0] linkTo(self);

  for(var_1 = 1; var_1 < self._id_A70D; var_1++) {
    self.segments[var_1].origin = self.segments[var_1 - 1].origin + anglesToForward(self.segments[var_1 - 1].angles) * self._id_56E9;
    self.segments[var_1].angles = self.angles + var_0;
  }

  for(var_1 = 1; var_1 < self._id_11A2A; var_1++) {
    self.segments[var_1].parent = self.segments[var_1 - 1];
    self.segments[var_1] linkTo(self.segments[var_1]._id_AD34);
  }

  _id_3AE3();
  _id_3AB6();
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, self._id_C28D);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, self._id_DDA8);
}

_id_3AE8(var_0) {
  level endon("notify_player_landed");
  level endon("stop_spline_think");
  var_1 = 100;
  var_2 = (self._id_11A2A - self._id_A70D) * self._id_56E9;
  var_3 = 1;
  var_4 = self._id_A70C;
  var_5 = self.segments[0];
  var_6 = -100;
  var_7 = 1;

  for(;;) {
    if(scripts\engine\utility::flag("flag_landing_reapproach"))
      var_8 = -0.007;
    else
      var_8 = 0.007;

    var_7 = var_7 + var_8;
    var_7 = clamp(var_7, 0, 1);
    var_9 = self._id_DDA8.origin;
    var_10 = self._id_DDA8.angles;
    var_11 = anglesToForward(var_10);
    var_12 = anglestoright(var_10);
    var_13 = anglestoup(var_10);
    var_14 = level._id_D127 gettagorigin("j_mainroot_ship") + anglestoup(level._id_D127 gettagangles("j_mainroot_ship")) * var_6;
    var_15 = level._id_D127.angles;
    var_16 = anglesToForward(var_15);
    var_17 = anglestoright(var_15);
    var_18 = anglestoup(var_15);
    var_19 = scripts\sp\math::_id_6A8E(var_11, var_16, var_7);
    var_20 = scripts\sp\math::_id_6A8E(var_12, var_17, var_7);
    var_21 = scripts\sp\math::_id_6A8E(var_13, var_18, var_7);
    var_22 = scripts\sp\math::_id_6A8E(var_9, var_14, var_7);
    var_23 = axistoangles(var_19, var_20, var_21);

    if(!var_3) {
      if(length(self.segments[var_4 - 1].origin - var_22) < self._id_56E9)
        var_4 = var_4 - 1;
      else if(length(self.segments[var_4 - 1].origin - var_22) > 2 * self._id_56E9) {
        if(var_4 < self._id_11A2A - 1)
          var_4 = var_4 + 1;
      }

      if(var_4 < self._id_A70D)
        var_4 = self._id_A70D;
    }

    var_24 = self.segments[self._id_A70D].origin;
    var_25 = self.segments[self._id_11A2A - 1].origin;
    wait 0.05;
    var_5._id_56EA = distance(var_22, var_5.origin);
    var_26 = vectordot(vectorNormalize(var_5.origin - var_22), anglesToForward(var_23));
    var_27 = vectorNormalize(var_22 - var_25);
    var_28 = length(var_22 - var_24);
    var_29 = rotatevectorinverted(var_22 - var_5.origin, var_5.angles);

    if(var_29[2] < var_1)
      var_29 = (var_29[0], var_29[1], var_1);

    var_30 = var_5.origin + rotatevector(var_29, var_5.angles);
    var_5._id_20E7 = vectordot(anglesToForward(var_5.angles), -1 * anglesToForward(var_23));
    var_31 = scripts\sp\math::_id_C097(-1.0, 0.0, var_5._id_20E7);
    var_31 = scripts\sp\math::_id_6A8E(0.2, 1, var_31);

    for(var_32 = self._id_A70D; var_32 < self._id_11A2A; var_32++) {
      self.segments[var_32] unlink();
      self.segments[var_32].origin = self.segments[var_32].parent.origin + anglesToForward(self.segments[var_32].parent.angles) * self._id_56E9;
      self.segments[var_32] _id_3AE7(var_23, var_30, var_23, var_5, var_32, self._id_A70C - 1, self._id_A70D, var_31, var_4);
      self.segments[var_32] linkTo(self.segments[var_32]._id_AD34);
    }

    level notify("notify_spline_update");
    var_3 = 0;
  }
}

_id_3AE6(var_0) {
  if(isDefined(var_0)) {
    return;
  }
  level endon("notify_stop_runway_landing");
  var_1 = 1;

  for(;;) {
    var_2 = pointonsegmentnearesttopoint(self.origin, self.origin + anglesToForward(self.angles) * 3000, level._id_D127.origin);
    var_3 = distance(level._id_D127.origin, var_2);
    var_4 = "runway_landing";
    var_5 = scripts\sp\math::_id_C097(0, 25000, var_3);
    var_5 = scripts\sp\math::_id_C09A(var_5);
    var_6 = scripts\sp\math::_id_6A8E(0.17, 1, var_5);
    var_7 = 1;

    foreach(var_10, var_9 in level._id_A056._id_BBB9["speed"]._id_3C66) {
      if(var_10 != var_4)
        var_7 = var_7 * var_9;
    }

    if(var_7 == 0) {} else
      var_1 = 1 / var_7;

    if(var_7 < var_6)
      var_11 = 1;
    else
      var_11 = var_1 * var_6;

    _id_0BDC::_id_A301(var_11, 0.05, "runway_landing");
    wait 0.05;
  }
}

_id_3AE5() {
  level endon("jackal_taxi_complete");
  level endon("notify_stop_runway_landing");
  self._id_102D1 _meth_8278(0, 0);
  var_0 = 0;
  var_1 = 1.0;
  var_2 = 0;
  self._id_102D1 playLoopSound("landing_drone_sled_lp");

  for(;;) {
    if(self._id_102D1.active && !_id_3AE1()) {
      var_3 = distance(self.origin, level._id_D127.origin);
      var_4 = 2900;
      var_5 = scripts\sp\math::_id_C097(self._id_102D1._id_B740, self._id_102D1._id_B42D + var_4, var_3);
      var_6 = scripts\sp\math::_id_6A8E(self._id_102D1._id_B740, self._id_102D1._id_B42D, var_5);
      var_7 = self.origin + anglesToForward(self.angles) * var_6;
      var_4 = (var_7 - self._id_102D1.origin) * self._id_102D1._id_AB99;
      var_8 = length(var_4);

      if(var_8 > var_1 && !self._id_102D1._id_5BD7.active) {
        if(!var_0) {
          var_0 = 1;
          thread _id_0BDC::_id_D527("landing_drone_sled_start", self._id_102D1.origin, 1, 0.7);
        }

        if(!var_2) {
          self._id_102D1._id_5BD7 _id_0BD6::_id_5C96();
          var_2 = 1;
        }

        var_9 = scripts\sp\math::_id_C097(0, 30, var_8);
        var_10 = scripts\sp\math::_id_6A8E(0.5, 1.8, var_9);
        var_11 = scripts\sp\math::_id_6A8E(0.2, 0.4, var_9);
        self._id_102D1 _meth_8278(var_10, 0.05);
        self._id_102D1 _meth_8277(var_11, 0.05);
      } else if(var_0) {
        self._id_102D1 _meth_8278(0, 0.5);
        var_0 = 0;
      }

      self._id_102D1.origin = self._id_102D1.origin + var_4;
      self._id_102D1.angles = self.angles;
    } else {
      self._id_102D1.origin = self.origin + anglesToForward(self.angles) * self._id_102D1._id_B42D;
      self._id_102D1.angles = self.angles;

      if(var_0) {
        self._id_102D1 _meth_8278(0, 0.5);
        var_0 = 0;
      }

      if(var_2) {
        self._id_102D1._id_5BD7 _id_0BD6::_id_5C95();
        var_2 = 0;
      }
    }

    wait 0.05;
  }
}

_id_3AD8(var_0) {
  level endon("notify_stop_runway_landing");
  level notify("notify_restart_landing progress");
  level._id_D127 notify("notify_restart_landing");
  level endon("notify_restart_landing progress");

  if(!isDefined(var_0))
    _id_0BDC::_id_A2FC(0.75, 0, "landing");

  _id_3ADB();
  _id_3AD0();
  thread _id_3AE9();
  thread _id_D17A(var_0);
  var_1 = 1;

  if(self._id_AB5E == 3) {
    var_1 = _id_3AD7(28, var_0);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  if(self._id_AB5E >= 2) {
    var_1 = _id_3AD7(23, var_0);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  if(self._id_AB5E >= 1) {
    var_1 = _id_3AD7(18, var_0);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  _id_3AD2(var_0);

  if(self._id_AB5E == 0) {
    var_1 = _id_3AD7(13, var_0);
    scripts\engine\utility::flag_set("jackal_landing_active");
  }

  if(_id_3AE1()) {
    return;
  }
  if(!var_1 && !isDefined(var_0)) {
    _id_3AD9();
    wait 1;
  }

  _id_3AD1(var_0);
  scripts\engine\utility::flag_set("player_jackal_drone_dock");
  level notify("notify_player_landed");
  _id_A7EE();
  _id_3AD6(var_0);
}

_id_3AE9() {
  level endon("jackal_taxi_complete");
  level endon("notify_stop_runway_landing");

  for(;;) {
    self._id_12713 waittill("trigger", var_0);

    if(!isDefined(level._id_D127) || !isDefined(var_0) || var_0 != level._id_D127) {
      continue;
    }
    scripts\engine\utility::flag_set("flag_player_on_runway");

    while(isalive(var_0) && isDefined(self._id_12713) && var_0 istouching(self._id_12713) && isDefined(level._id_D127))
      wait 0.05;

    scripts\engine\utility::flag_clear("flag_player_on_runway");
  }
}

_id_3AE1() {
  if(scripts\engine\utility::flag_exist("flag_scipted_jackal_landing") && scripts\engine\utility::flag("flag_scipted_jackal_landing"))
    return 1;
  else
    return 0;
}

_id_3ADB() {
  level endon("notify_stop_runway_landing");
  self._id_DDA8 thread _id_DDA4();

  for(;;) {
    var_0 = distance(self._id_DDA8.origin, self.origin);
    var_1 = level._id_D127.origin - self.origin;
    var_2 = rotatevectorinverted(var_1, self.angles);
    var_3 = var_2[0];

    if(var_3 > var_0 - 5000) {
      break;
    }

    if(!scripts\engine\utility::flag("flag_landing_reapproach") && scripts\engine\utility::flag("jackal_sees_ret_for_landing")) {
      scripts\engine\utility::flag_set("flag_landing_reapproach");
      self._id_DDA8 _id_0B76::_id_F42C("ally_objective");
    }

    wait 0.05;
  }

  if(scripts\engine\utility::flag("flag_landing_reapproach")) {
    scripts\engine\utility::flag_clear("flag_landing_reapproach");
    self._id_DDA8 _id_0B76::_id_F42C("none");
  }

  scripts\engine\utility::flag_clear("jackal_runway_first_attempt");
  _id_DDA7();
}

_id_3AD0() {
  level endon("notify_restart_landing progress");
  wait 0.1;
  var_0 = 0;
  self._id_C28D thread _id_A7EB();

  if(self._id_AB5E == 3) {
    var_1 = 22000;
    var_2 = 22000;
    var_3 = 17000;
  } else if(self._id_AB5E == 2) {
    var_1 = 17000;
    var_2 = 17000;
    var_3 = 13000;
  } else if(self._id_AB5E == 1) {
    var_1 = 12000;
    var_2 = 12000;
    var_3 = 8000;
  } else {
    var_1 = 12000;
    var_2 = 12000;
    var_3 = 7000;
  }

  for(;;) {
    var_4 = length(self.origin - level._id_D127.origin);
    var_5 = vectordot(vectorNormalize(self.segments[15].origin - level._id_D127.origin), anglesToForward(level._id_D127.angles));
    var_6 = vectordot(anglesToForward(self.segments[15].angles), vectorNormalize(level._id_D127.origin - self.segments[15].origin));

    if(var_4 < var_1 && var_5 > 0.92) {
      if(var_0) {
        self._id_C28D _id_0B76::_id_F42C("none");
        var_0 = 0;
      }
    } else if(!var_0 && scripts\engine\utility::flag("jackal_sees_ret_for_landing")) {
      self._id_C28D _id_0B76::_id_F42C("ally_objective");
      var_0 = 1;
    }

    if(var_4 < var_2 && var_5 > 0.95) {
      break;
    }

    if(var_4 < var_3) {
      if(var_6 < 0.95) {
        if(var_0)
          self._id_C28D _id_0B76::_id_F42C("none");

        _id_3AD9();
      }

      if(var_5 < 0.7) {
        if(var_0)
          self._id_C28D _id_0B76::_id_F42C("none");

        _id_3AD9();
      }
    }

    wait 0.05;
  }

  if(var_0)
    self._id_C28D _id_0B76::_id_F42C("none");

  _id_A7EE();
}

_id_3AD2(var_0) {
  self._id_102D1.active = 1;

  if(!isDefined(var_0)) {
    _id_0BDC::_id_D165(self._id_6C1E, 1.0, 3.0, 6.0);
    _id_0BDC::_id_D16C(self._id_102D1._id_20F1, 1.0, 3.0, 6.0);
  }
}

_id_3AD4(var_0) {
  self._id_102D1.active = 0;

  if(isDefined(var_0)) {
    _id_0BDC::_id_D165(self._id_6C1E, 0.0, 1.0, 0.0);
    _id_0BDC::_id_D16C(self._id_102D1._id_20F1, 0.0, 1.0, 0.0);
  }
}

_id_3AD1(var_0) {
  level endon("notify_stop_runway_landing");
  level endon("notify_restart_landing progress");
  thread _id_3AE4();
  thread _id_3AC6();
  _id_3AD3();
  _id_3ADF(7500);

  while(scripts\engine\utility::flag("jackal_landing_never_launch_drone"))
    wait 0.05;

  _id_0BD6::_id_5BFC(var_0);
  _id_0BD6::_id_5BE2(var_0);
}

_id_3ADF(var_0) {
  var_1 = 99999999;

  while(var_1 > var_0) {
    var_1 = distance(level._id_D127.origin, self._id_6C1E.origin);
    wait 0.05;
  }
}

_id_3AD6(var_0) {
  wait 0.5;
  thread _id_3ACF(var_0);
  _id_3ADC(var_0);
  thread _id_3ACE();
  thread _id_3ACA(var_0);
  thread _id_3AE0();
  level waittill("jackal_taxi_complete");
  thread _id_3ACB();
  self._id_102D1._id_5BD7 thread _id_0BD6::_id_685D();
  _id_0BD6::_id_5C40(var_0);
}

_id_3ACA(var_0) {
  thread _id_3ACD(var_0);
  thread _id_3ACC(var_0);
}

_id_3ACD(var_0) {
  var_1 = 999999;

  while(var_1 > 650) {
    if(!isDefined(var_0))
      var_1 = distance(self._id_11593.origin, self._id_6C1E.origin);
    else
      var_1 = distance(level._id_D127.origin, self._id_6C1E.origin);

    wait 0.05;
  }

  var_2 = 3.5;

  if(isDefined(level._id_A056._id_A7EA))
    var_3 = level._id_A056._id_A7EA;
  else
    var_3 = "jackal_landing_default";

  visionsetnaked(var_3, var_2);
}

_id_3ACE() {
  _id_0BDC::_id_A226(1);
}

_id_3ACC(var_0) {
  var_1 = 999999;

  while(var_1 > 1300) {
    if(!isDefined(var_0))
      var_1 = distance(self._id_11593.origin, self._id_6C1E.origin);
    else
      var_1 = distance(level._id_D127.origin, self._id_6C1E.origin);

    wait 0.05;
  }

  var_2 = 2.0;
  thread _id_AB9F(var_2);
  thread _id_AB80(var_2);
}

#using_animtree("script_model");

_id_3ACB() {
  if(self._id_2AD8.size == 0 || self._id_2ADB.size == 0) {
    return;
  }
  foreach(var_1 in self._id_2AD8) {
    var_1._id_C385 = var_1 _meth_8134();
    var_1 thread scripts\sp\lights::_id_AB83(0.2, 0.2);
    var_1 scripts\engine\utility::delaythread(1, scripts\sp\lights::_id_AB83, var_1._id_C385, 7);
  }

  foreach(var_1 in self._id_2ADA) {
    var_1 scripts\sp\utility::_id_65E0("light_pulsing");
    var_1 scripts\sp\utility::_id_65E1("light_pulsing");
    var_1 thread _id_3AC1();
  }

  foreach(var_1 in self._id_2ADA)
  var_1 scripts\sp\utility::_id_65E8("light_pulsing");

  foreach(var_8 in self._id_2ADB) {
    var_8 show();
    var_8._id_A6EC hide();

    foreach(var_1 in var_8.lights) {
      var_1 _meth_82FC((1, 0.085294, 0.03137));
      var_1 thread scripts\sp\lights::_id_AB83(var_1.script_intensity_01, 1);
    }

    var_8 _meth_82A2(%claxon_spin_loop);
  }
}

_id_3AC1() {
  var_0 = self _meth_8134();
  var_1 = 90;
  var_2 = self _meth_8136();
  var_3 = var_2 * 2;
  var_4 = 0.2;
  var_5 = 0.5;
  var_6 = 0.3;
  var_7 = 0.5;
  _id_3AB1(var_1, var_3, var_4);
  wait(var_6);
  _id_3AB1(var_0, var_2, var_5);
  wait(var_7);
  _id_3AB1(var_1, var_3, var_4);
  wait(var_6);
  _id_3AB1(var_0, var_2, var_5);
  scripts\sp\utility::_id_65DD("light_pulsing");
}

_id_3AB1(var_0, var_1, var_2) {
  var_3 = self _meth_8134();
  var_4 = self _meth_8136();
  var_5 = int(var_2 * 20);
  var_6 = (var_1 - var_4) / var_5;
  var_7 = (var_0 - var_3) / var_5;

  for(var_8 = 0; var_8 < var_5; var_8++) {
    self setlightintensity(var_3 + var_8 * var_7);
    self _meth_8300(var_4 + var_8 * var_6);
    wait 0.05;
  }

  self setlightintensity(var_0);
  self _meth_8300(var_1);
}

_id_3AE0() {
  var_0 = 999999;

  while(var_0 > 1000) {
    var_0 = distance(self._id_11593.origin, self._id_6C1E.origin);
    wait 0.05;
  }

  _id_0BDC::_id_A38E(0, undefined, undefined, 6);
}

_id_AB9F(var_0) {
  var_1 = int(var_0 * 20);

  if(isDefined(level._id_111D0) && isDefined(level._id_111D0._id_99E5))
    var_2 = level._id_111D0._id_99E5;
  else {
    var_2 = getmapsuncolorandintensity();
    var_2 = var_2[3];
  }

  var_3 = (0 - var_2) / var_1;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_2 + var_4 * var_3;
    setsuncolorandintensity(var_5);

    if(isDefined(level._id_111D0) && isDefined(level._id_111D0._id_99E5))
      level._id_111D0._id_99E5 = var_5;

    wait 0.05;
  }

  if(isDefined(level._id_111D0) && isDefined(level._id_111D0._id_99E5))
    level._id_111D0._id_99E5 = 0;

  setsuncolorandintensity(0);
}

_id_AB80(var_0) {
  foreach(var_2 in level._id_A056._id_A7E8)
  var_2 thread scripts\sp\lights::_id_AB83(0, var_0);
}

_id_3AD9(var_0) {
  scripts\engine\utility::flag_clear("jackal_landing_active");
  killfxontag(scripts\engine\utility::getfx("jackal_runway_hoop"), self._id_102D1, "tag_origin");

  if(self._id_102D1._id_5BD7.active)
    thread _id_5BFA();

  thread _id_3ADA();
  thread _id_3AC4();
  thread _id_D17B();
  _id_3AD4(1);
  var_1 = _id_E8B2();
  _id_3C3F(var_1);
  thread _id_3AD8();
}

_id_E8B2() {
  var_0 = level._id_D127.origin - self.origin;
  var_1 = rotatevectorinverted(var_0, self.angles);
  var_2 = var_1[0];

  if(var_2 > 25000)
    return 3;
  else if(var_2 > 20000)
    return 2;
  else if(var_2 > 15000)
    return 1;
  else
    return 0;
}

_id_3ADA() {
  level.player playSound("landing_hoop_fail");
}

_id_3AE4() {
  level endon("notify_player_landed");
  level endon("notify_restart_landing progress");
  var_0 = 0;

  for(;;) {
    level waittill("notify_spline_update");
    var_1 = self._id_6C1E.origin - level._id_D127.origin;
    var_2 = length(self.origin - level._id_D127.origin);
    var_3 = vectordot(anglesToForward(level._id_D127.angles), vectorNormalize(var_1));

    if(scripts\engine\utility::flag("flag_player_on_runway") && !var_0)
      var_0 = 1;

    var_4 = scripts\sp\math::_id_C097(5000, 9500, var_2);
    var_5 = scripts\sp\math::_id_6A8E(0.97, 0.82, var_4);

    if(var_3 < var_5) {
      _id_3AD9("dot");
      continue;
    }

    if(var_0 && !scripts\engine\utility::flag("flag_player_on_runway"))
      _id_3AD9("flag");
  }
}

_id_2F16() {
  self endon("entitydeleted");

  for(;;)
    wait 0.05;
}

_id_3AD3() {
  level endon("notify_restart_landing progress");
  level.player playSound("landing_hoop_active");
  playFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), self._id_102D1, "tag_origin");
}

_id_3AD7(var_0, var_1) {
  var_2 = self.segments[var_0 - 1];
  var_3 = self.segments[var_0 - 3];
  playFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), var_2, "tag_origin");
  level.player playSound("landing_hoop_active");
  var_4 = 1000;
  level notify("landing_hoop_active");

  for(;;) {
    level waittill("notify_spline_update");
    var_5 = vectorNormalize(var_3.origin - level._id_D127.origin);
    var_6 = anglesToForward(level._id_D127.angles);
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.6 && !isDefined(var_1)) {
      stopFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), var_2, "tag_origin");
      _id_3AD9();
    }

    var_8 = var_2.origin + anglestoup(var_2.angles) * 75;
    var_9 = var_8 + anglesToForward(var_2.angles) * 2000;
    var_10 = pointonsegmentnearesttopoint(var_8, var_9, level._id_D127.origin);
    var_11 = distance(var_8, var_10);

    if(var_11 < var_4) {
      break;
    }
  }

  stopFXOnTag(scripts\engine\utility::getfx("jackal_runway_hoop"), var_2, "tag_origin");
  var_12 = var_8 + anglesToForward(var_2.angles) * var_4;
  var_13 = distance(level._id_D127.origin, var_12);

  if(var_13 < 250) {
    level.player playSound("landing_hoop_success");
    return 1;
  } else {
    level.player playSound("landing_hoop_fail");
    return 0;
  }
}

_id_3AC7(var_0) {
  var_1 = self.segments;
  level notify("stop_jackal_landing_segments");
  level endon("stop_jackal_landing_segments");
  var_2 = 27;
  var_3 = var_2;
  var_4 = undefined;

  if(self._id_AB5E == 3)
    var_4 = 27;
  else if(self._id_AB5E == 2)
    var_4 = 22;
  else if(self._id_AB5E == 1)
    var_4 = 17;
  else if(self._id_AB5E == 0)
    var_4 = 12;
  else {}

  var_5 = 12;

  if(var_0) {
    while(var_2 >= 0) {
      if(isDefined(var_1[var_2]._id_22F9))
        killfxontag(scripts\engine\utility::getfx(var_1[var_2]._id_22F9), var_1[var_2]._id_7601, "tag_origin");

      if(var_2 > var_5 && var_2 <= var_4)
        var_1[var_2]._id_22F9 = "jackal_runway_arrows";
      else if(var_2 == var_5 && var_2 <= var_4)
        var_1[var_2]._id_22F9 = "jackal_runway_arrow_end";
      else
        var_1[var_2]._id_22F9 = undefined;

      if(isDefined(var_1[var_2]._id_22F9))
        playFXOnTag(scripts\engine\utility::getfx(var_1[var_2]._id_22F9), var_1[var_2]._id_7601, "tag_origin");

      var_2--;
    }
  } else {
    foreach(var_7 in var_1) {
      if(isDefined(var_1[var_2]._id_22F9))
        killfxontag(scripts\engine\utility::getfx(var_7._id_22F9), var_7._id_7601, "tag_origin");
    }
  }

  wait 0.05;
  var_2 = var_3;

  if(var_0) {
    while(var_2 >= 0) {
      if(isDefined(var_1[var_2].fx))
        killfxontag(scripts\engine\utility::getfx(var_1[var_2].fx), var_1[var_2]._id_7601, "tag_origin");

      if(var_2 == 0)
        var_1[var_2].fx = "jackal_runway_segment_end";
      else if(var_2 == var_4)
        var_1[var_2].fx = "jackal_runway_segment_start";
      else if(var_2 < var_4)
        var_1[var_2].fx = "jackal_runway_segment";
      else
        var_1[var_2].fx = undefined;

      if(isDefined(var_1[var_2].fx)) {
        playFXOnTag(scripts\engine\utility::getfx(var_1[var_2].fx), var_1[var_2]._id_7601, "tag_origin");
        wait 0.25;
      }

      var_2--;
    }
  } else {
    foreach(var_7 in var_1)
    killfxontag(scripts\engine\utility::getfx(var_7.fx), var_7._id_7601, "tag_origin");
  }
}

_id_3AE7(var_0, var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_3 >= var_7)
    var_0 = self.parent.angles;
  else {
    var_8 = vectorNormalize(var_1 - self.origin);
    var_9 = anglestoup(var_2.angles);
    var_10 = anglestoright(self.parent.angles);
    var_11 = anglesToForward(var_2.angles);
    var_12 = anglestoup(var_2.angles);
    var_13 = anglestoright(self.parent.angles);
    self._id_56EA = distance(self.origin, var_1);
    self._id_5ABB = vectordot(vectorNormalize(self.origin - var_1), anglesToForward(var_0));
    var_14 = scripts\sp\math::_id_C097(0, 0.1, self._id_5ABB);
    var_6 = scripts\sp\math::_id_6A8E(0.1, 1, var_6);
    var_15 = scripts\sp\math::_id_C097(var_5, var_4, var_3);
    var_16 = scripts\sp\math::_id_C09B(var_15);
    var_17 = vectorNormalize(var_11 * (1 - var_16) + var_8 * var_16);
    var_18 = vectorNormalize(var_13 * (1 - var_15) + var_10 * var_15);
    var_19 = vectorNormalize(var_12 * (1 - var_15) + var_9 * var_15);
    var_0 = axistoangles(var_17, var_18, var_19);
  }

  var_0 = (_id_0BDC::_id_12D71(var_0, self.angles, 0), _id_0BDC::_id_12D71(var_0, self.angles, 1), _id_0BDC::_id_12D71(var_0, self.angles, 2));
  self.angles = self.angles + (var_0 - self.angles) * self._id_AB99;
  self._id_AB99 = 0.2;
}

_id_3ADE(var_0) {
  var_1 = 0;

  for(var_2 = []; var_1 < var_0; var_1++) {
    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_3._id_11AE0 = 1;
    var_3._id_AB99 = 1;
    var_3._id_7601 = scripts\engine\utility::spawn_tag_origin();
    var_3._id_7601.origin = var_3.origin;
    var_3._id_7601.angles = axistoangles(anglestoup(var_3.angles), -1 * anglestoright(var_3.angles), anglesToForward(var_3.angles));
    var_3._id_7601 linkTo(var_3);
    var_2 = scripts\engine\utility::array_add(var_2, var_3);
    var_3._id_AD34 = self;
    self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_3);
    self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_3._id_7601);
  }

  self.segments = var_2;
  thread _id_3AC7(1);
  return var_2;
}

_id_3AE3() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_B42D = 5200;
  var_0._id_B740 = 0;
  var_0._id_AB99 = 0.2;
  var_0.active = 0;
  var_0._id_20F1 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_20F1 linkTo(var_0, "tag_origin", (900, 0, 75), (0, 0, 0));

  if(isDefined(self._id_5BD7)) {
    var_0._id_5BD7 = self._id_5BD7;
    var_0._id_5BD7 unlink();
  } else {
    var_0._id_5BD7 = _id_0BD6::_id_10753();
    var_0._id_5BD7._id_4074 = [];
    var_0._id_5BD7._id_FC28 = scripts\engine\utility::spawn_tag_origin();
    var_0._id_5BD7._id_FC28 linkTo(var_0._id_5BD7, "j_mainroot", (0, 0, 0), (0, 0, 0));
    var_0._id_5BD7._id_FB5B = scripts\engine\utility::spawn_tag_origin();
    var_0._id_5BD7._id_FB5B linkTo(var_0._id_5BD7, "j_mainroot", (0, 0, 0), (0, 0, 0));
    var_0._id_5BD7._id_FB5C = scripts\engine\utility::spawn_tag_origin();
    var_0._id_5BD7._id_FB5C linkTo(var_0._id_5BD7, "j_mainroot", (0, 0, 0), (0, 0, 0));
    var_0._id_5BD7._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0._id_5BD7._id_FC28);
    var_0._id_5BD7._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0._id_5BD7._id_FB5B);
    var_0._id_5BD7._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0._id_5BD7._id_FB5C);
  }

  var_0._id_5BD7.origin = var_0.origin + (0, 0, 35);
  var_0._id_5BD7.angles = var_0.angles;
  var_0._id_5BD7 linkTo(var_0);
  var_0._id_5BD7.active = 0;
  var_0._id_11AE0 = 1;
  var_0._id_7601 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_7601.origin = var_0.origin;
  var_0._id_7601.angles = axistoangles(anglestoup(var_0.angles), -1 * anglestoright(var_0.angles), anglesToForward(var_0.angles));
  var_0._id_7601 linkTo(var_0);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0._id_7601);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0._id_5BD7);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_0._id_20F1);
  var_0._id_5BD7 thread _id_5BEA();
  self._id_102D1 = var_0;
}

_id_5BEA() {
  self waittill("death");

  foreach(var_1 in self._id_4074) {
    if(isDefined(var_1))
      var_1 delete();
  }
}

#using_animtree("vehicles");

_id_5BFA() {
  self._id_102D1._id_5BD7 _meth_82A2(%landing_drone_fail_overlay, 1);
  self._id_102D1._id_5BD7 _meth_82A2(%landing_drone_fly_fail, 1, 1);
  wait 1;
  self._id_102D1._id_5BD7 notify("notify_drone_reset");
  self._id_102D1._id_5BD7.active = 0;
  self._id_102D1._id_5BD7.origin = self._id_102D1.origin + (0, 0, 35);
  self._id_102D1._id_5BD7.angles = self._id_102D1.angles;
  self._id_102D1._id_5BD7 linkTo(self._id_102D1);
  self._id_102D1._id_5BD7 _id_0BD6::_id_A7D5();
  self._id_102D1._id_5BD7 _id_0BD6::_id_5C8D();
}

_id_3AC4() {
  if(isDefined(self._id_E311))
    self._id_E311 thread _id_3AC5(self._id_E311.end, self._id_E311.start, 3.5);
}

_id_3AC6() {
  if(isDefined(self._id_E311))
    self._id_E311 thread _id_3AC5(self._id_E311.start, self._id_E311.end, 3);
}

_id_3AC5(var_0, var_1, var_2) {
  self notify("door_change_dir");
  self endon("door_change_dir");

  for(;;) {
    self unlink();
    var_3 = var_1.origin - self.origin;

    if(length(var_3) <= var_2) {
      self.origin = var_1.origin;
      self.angles = var_1.angles;
      break;
    } else {
      self.origin = self.origin + vectorNormalize(var_3) * var_2;
      self.angles = var_1.angles;
    }

    self linkTo(self.parent);
    wait 0.05;
  }

  self linkTo(self.parent);
}

_id_3AB6() {
  var_0 = [];

  if(!isDefined(self._id_8A9D)) {
    return;
  }
  foreach(var_2 in self._id_8A9D) {
    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_0 = scripts\engine\utility::array_add(var_0, var_3);
    var_3 linkTo(var_2);
    self._id_4074 = scripts\engine\utility::array_add(self._id_4074, var_3);
  }

  self._id_4556 = var_0;
}

_id_E8D0() {
  var_0 = self.segments;

  for(var_1 = self.segments.size - 1; var_1 >= 0; var_1--) {
    if(isDefined(var_0[var_1].fx))
      killfxontag(scripts\engine\utility::getfx(var_0[var_1].fx), var_0[var_1]._id_7601, "tag_origin");

    var_0[var_1].fx = undefined;

    if(isDefined(var_0[var_1]._id_22F9))
      killfxontag(scripts\engine\utility::getfx(var_0[var_1]._id_22F9), var_0[var_1]._id_7601, "tag_origin");

    var_0[var_1]._id_22F9 = undefined;
  }
}

_id_EA01() {
  if(isDefined(self))
    self delete();
}

_id_3ADC(var_0) {
  var_1 = length(self._id_11593.origin - level._id_D127.origin);
  var_2 = scripts\sp\math::_id_C097(50, 300, var_1);
  var_3 = scripts\sp\math::_id_6A8E(0.3, 2.7, var_2);

  if(!isDefined(var_0)) {
    _id_0BDC::_id_D164(self._id_11593, var_3);
    _id_0BDC::_id_A38E(0);
  }

  self._id_102D1._id_5BD7 _id_0BD6::_id_6815();
  wait(var_3 * 0.5);

  if(!isDefined(var_0))
    _id_0BDC::_id_A14D();

  self._id_11593 playSound("jackal_land");
  level._id_D127 playSound("jackal_tire_skid_long_plr");

  if(!isDefined(var_0))
    _id_0BDC::_id_A38E(33, 9, 3, 2);

  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.35, 1.3, level._id_D127.origin, 5000);

  if(!isDefined(var_0)) {
    _id_0BDC::_id_D164(self._id_11593, 0.3);
    _id_0BDC::_id_A1DD("land");
  }

  level notify("notify_land_jet");

  if(!isDefined(var_0))
    _id_3AD4();

  self._id_102D1._id_5BD7 thread _id_0BD6::_id_680F(1.1);
}

_id_3ACF(var_0) {
  level endon("notify_stop_runway_landing");

  if(!isDefined(var_0))
    var_1 = level._id_D127 gettagorigin("j_mainroot");
  else
    var_1 = level._id_D127 gettagorigin("j_canopy");

  if(level._id_D127.classname == "script_vehicle_jackal_enemy_prototype")
    var_2 = -52;
  else
    var_2 = 0;

  self._id_11593 = scripts\engine\utility::spawn_tag_origin();
  var_3 = level._id_D127.origin - self._id_6C1E.origin;
  var_3 = rotatevectorinverted(var_3, self._id_6C1E.angles);
  var_3 = (var_3[0], var_3[1], 0);
  var_4 = rotatevector(var_3, self._id_6C1E.angles);
  self._id_11593.origin = self._id_6C1E.origin + var_4 + anglestoup(self._id_6C1E.angles) * var_2;
  self._id_11593.angles = self._id_6C1E.angles;
  self._id_11593 linkTo(self);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, self._id_11593);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, self._id_11593._id_B017);
  var_5 = length(level._id_D127.spaceship_vel);
  var_5 = scripts\engine\utility::mph_to_ips(var_5);
  var_5 = var_5 * 0.05;

  for(;;) {
    var_6 = self._id_6C1E.origin + anglestoup(self._id_6C1E.angles) * var_2;

    if(!isDefined(var_0)) {
      var_7 = vectorNormalize(var_6 - self._id_11593.origin);
      var_8 = distance(self._id_11593.origin, var_6);
    } else {
      var_7 = vectorNormalize(var_6 - level._id_D127.origin);
      var_8 = distance(level._id_D127.origin, var_6);
    }

    var_9 = scripts\sp\math::_id_C097(20, 3000, var_8);
    var_9 = scripts\sp\math::_id_C09B(var_9);
    var_10 = scripts\sp\math::_id_6A8E(0.7, var_5, var_9);
    var_11 = scripts\sp\math::_id_6A8E(0.2, 1, var_9);
    var_12 = scripts\sp\math::_id_6A8E(0.2, 1.2, var_9);
    var_13 = scripts\sp\math::_id_6A8E(0.3, 1, var_9);
    self._id_11593 unlink();
    self._id_11593.origin = self._id_11593.origin + var_7 * var_10;
    self._id_11593.angles = self._id_6C1E.angles;
    self._id_11593 linkTo(self);
    self._id_102D1._id_5BD7._id_FB5C _meth_8278(var_12, 0.05);
    self._id_102D1._id_5BD7._id_FB5C _meth_8277(var_13, 0.05);

    if(var_8 < 5) {
      break;
    } else if(isDefined(var_0) && var_8 < 40) {
      break;
    }

    wait 0.05;
  }

  thread _id_C139();
  wait 2;
}

_id_C139() {
  if(isDefined(level._id_A056._id_A7E9)) {
    scripts\sp\hud_util::_id_6AA3(level._id_A056._id_A7E9, "black");
    wait(level._id_A056._id_A7E9);
  }

  level notify("jackal_taxi_complete");
}

#using_animtree("jackal");

_id_D17A(var_0) {
  level endon("notify_restart_landing progress");
  level endon("notify_stop_runway_landing");

  for(;;) {
    var_1 = distance(self.segments[15].origin, level._id_D127.origin);

    if(var_1 < 14000) {
      break;
    }

    wait 0.05;
  }

  if(!isDefined(var_0))
    thread _id_0BDC::_id_A2B0(%jackal_pilot_runway_prep, %jackal_vehicle_runway_prep, 1.1, 0.5);

  wait 2.5;

  if(!isDefined(var_0)) {
    _id_0BDC::_id_A153();
    _id_0BDC::_id_A14A();
    _id_0BDC::_id_A15B();
    _id_0BDC::_id_A151();
    _id_0BDC::_id_A1DD("fly");
    _id_0BDC::_id_A155();
    _id_0BDC::_id_A1DC(350);
    _id_0BDC::_id_A161();
    _id_0BD9::_id_A323();
  }
}

_id_D17B() {
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A14A(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A151(0);
  _id_0BDC::_id_A1DD(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A1DC(0);
  _id_0BDC::_id_A161(0);
  _id_0BDC::_id_A2FC(1, 0, "landing");
  _id_0BD9::_id_A318(level._id_A056._id_9B6F);
}

_id_A2CE() {
  if(level.console || level.player usinggamepad())
    scripts\sp\utility::_id_56BA("jackal_launch_rev");
  else
    scripts\sp\utility::_id_56BA("jackal_launch_rev_pc");
}