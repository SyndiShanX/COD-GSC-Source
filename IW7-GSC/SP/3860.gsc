/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3860.gsc
**************************************/

_id_1139A() {
  precacheshader("hud_ability_life_support");
  precacheshader("hud_ability_security_highlight");
  precacheshader("hud_wrist_pc_hacking");
  precacheshader("hud_wrist_pc_border");
}

_id_FD5D() {
  scripts\engine\utility::flag_init("proximity_hacking");
  scripts\engine\utility::flag_init("hack_life_support_active");
  scripts\engine\utility::flag_init("hack_life_support_cooling");
  scripts\engine\utility::flag_init("hack_robotics_active");
  scripts\engine\utility::flag_init("hack_robotics_cooling");
  scripts\engine\utility::flag_init("hack_activation_paused");
  scripts\engine\utility::flag_init("used_security_cameras");
  scripts\engine\utility::flag_init("defend_in_progress");
  scripts\engine\utility::flag_init("robots_disabled");
  scripts\engine\utility::flag_init("hack_nearby_nag_cooldown");
  scripts\sp\utility::_id_16EB("hint_life_support", &"SHIP_ASSAULT_HINT_LIFE_SUPPORT", ::_id_13061);
  scripts\sp\utility::_id_16EB("hint_robotics", &"SHIP_ASSAULT_HINT_ROBOTICS", ::_id_1306A);
  scripts\sp\utility::_id_16EB("security_highlighting_hint", &"SHIP_ASSAULT_HINT_SECURITY_CAMERAS", ::_id_1306B);
  _id_113A9();
}

_id_113A9() {
  level._id_FD5B = [];
  level._id_8814 = [];
  level._id_FD50 = [];
  level._id_4BC6 = undefined;
  level._id_FD5C = 0;
  var_0 = undefined;
  var_1 = getEntArray("life_support_interior_doors", "targetname");
  var_2 = getEntArray("trigger_zone", "targetname");

  foreach(var_4 in var_2) {
    var_4.doors = [];

    foreach(var_6 in var_1) {
      var_7 = (var_6.origin[0], var_6.origin[1], var_4.origin[2]);

      if(ispointinvolume(var_7, var_4)) {
        var_4.doors = scripts\engine\utility::array_add(var_4.doors, var_6);
      }
    }
  }

  var_10 = scripts\engine\utility::getStructArray("assault_system", "targetname");
  var_11 = scripts\engine\utility::getStructArray("assault_entry", "targetname");
  var_12 = scripts\engine\utility::getStructArray("assault_objective", "targetname");
  var_13 = scripts\engine\utility::array_combine(var_10, var_11);
  _id_0F17::_id_2FA4();

  foreach(var_15 in var_13) {
    if(var_15.targetname == "assault_system") {
      var_15 _id_0F0A::_id_F994();
    } else if(var_15.targetname == "assault_entry") {
      var_0 = var_15 _id_0F06::_id_F95F();
    }

    if(var_15.targetname != "assault_objective" && var_15.targetname != "assault_entry") {
      var_15 thread _id_113A1();
      continue;
    }

    if(var_15.targetname == "assault_entry") {}
  }

  _id_0F12::_id_F9EE(var_12);
  thread _id_E1D1();
}

_id_113A1() {
  self.cooldown = 0;
  self._id_8804 = 0;
  self._id_32D9 = scripts\engine\utility::spawn_tag_origin();
  var_0 = _id_DAC3(0);
  self._id_32D9 makeunusable();
  var_1 = self._id_4D94._id_113AC;

  if(var_1 != "generic" && var_1 != "key") {
    scripts\sp\utility::_id_2669("");
    level.player _id_0F0A::_id_169A(self._id_4D94);
  }

  self._id_32D9 delete();

  if(var_1 != "generic" && var_1 != "key") {
    return;
  }
  self thread[[self._id_4D94._id_8822]]();
  return;
}

_id_DAC3(var_0) {
  if(scripts\engine\utility::flag_exist("player_inside_ship")) {
    scripts\engine\utility::flag_wait("player_inside_ship");
    _id_0F16::_id_13652();
  }

  _id_87E3();

  for(;;) {
    self._id_32D9 waittill("trigger");
    _id_87AC();
    thread _id_DAB5(self._id_4D94._id_885A, self._id_4D94._id_113AC, self._id_4D94._id_8851, self._id_4D94._id_DC04);
    var_1 = scripts\engine\utility::waittill_any_return("hack_success", "hack_fail");

    if(var_1 == "hack_success") {
      break;
    } else
      _id_87E3();
  }

  return level.player;
}

_id_5075(var_0) {
  scripts\engine\utility::flag_set("defend_in_progress");
}

_id_5074() {
  scripts\engine\utility::flag_clear("defend_in_progress");
}

_id_DAB5(var_0, var_1, var_2, var_3) {
  self notify("hack_start");
  thread _id_0B66::_id_DAC0(var_0, self, var_2, var_3);
  thread _id_DABB();
  thread _id_87C6(var_1);
  thread _id_DABE(var_1);
  thread _id_DAB6();
}

_id_DAB6() {
  self endon("proximity_hack_end");

  for(;;) {
    self waittill("proximity_hack_state_change", var_0, var_1);

    if(var_0 == "losing_signal" && var_1 == "in_range") {
      var_2 = ["ship_assault_eth_imlosingconnect", "ship_assault_eth_connectionfaili"];
      var_3 = scripts\engine\utility::random(var_2);
      thread scripts\sp\utility::_id_10350(var_3, 0.1);
      playworldsound("sa_hack_range", level.player.origin);
    }
  }
}

_id_DABE(var_0) {
  level.player playSound("sa_hack_start");

  switch (var_0) {
    case "life_support":
      var_1 = "sa_hack_lifesupport_lp";
      break;
    case "robotics":
      var_1 = "sa_hack_robotics_lp";
      break;
    case "electrical":
      var_1 = "sa_hack_electrical_lp";
      break;
    default:
      var_1 = "sa_hack_robotics_lp";
      break;
  }

  wait 0.8;

  if(!scripts\engine\utility::flag("proximity_hacking")) {
    return;
  }
  var_2 = scripts\engine\utility::play_loopsound_in_space(var_1, level.player.origin);
  var_2 linkTo(level.player);
  thread _id_DABF(var_0);
  var_3 = level scripts\engine\utility::waittill_any_return("proximity_hack_completed", "proximity_hack_failed", "proximity_hack_stopped");
  var_2 stoploopsound();
  var_2 delete();

  if(var_3 == "proximity_hack_completed") {
    thread scripts\sp\utility::_id_10352("ship_assault_eth_uploadcomplete");
    level.player playSound("sa_hack_finish");
  } else if(var_3 == "proximity_hack_failed") {
    var_4 = ["ship_assault_eth_thehackfailedwe", "ship_assault_eth_couldntcomplete"];
    var_5 = scripts\engine\utility::random(var_4);
    thread scripts\sp\utility::_id_10350(var_5);
    level.player playSound("sa_hack_fail");
  }
}

_id_DABF(var_0) {
  switch (var_0) {
    case "life_support":
      var_1 = "sa_hack_alarm_01";
      break;
    case "robotics":
      var_1 = "sa_hack_alarm_02";
      break;
    case "electrical":
      var_1 = "sa_hack_alarm_02";
      break;
    default:
      var_1 = "sa_hack_alarm_null";
      break;
  }

  var_2 = spawn("script_origin", level.player.origin + (randomfloatrange(300, 700), randomfloatrange(300, 700), 0));
  var_3 = spawn("script_origin", level.player.origin + (randomfloatrange(-1000, -500), randomfloatrange(-1000, -500), 0));
  wait 1;
  var_2 playLoopSound(var_1);
  var_3 playLoopSound(var_1);
  level scripts\engine\utility::waittill_any("proximity_hack_completed", "proximity_hack_failed", "proximity_hack_stopped");
  var_2 stoploopsound();
  var_2 delete();
  var_3 stoploopsound();
  var_3 delete();
}

_id_134F9(var_0, var_1) {
  var_2 = "ship_assault_cmp";
  var_3 = 2.1;

  switch (var_0) {
    case "life_support":
      var_4 = "life_support_pa";
      break;
    case "robotics":
      var_4 = "mech_pa";
      break;
    case "electrical":
      var_4 = "elec_pa";
      break;
    default:
      return;
  }

  switch (var_1) {
    case "on":
      var_5 = "on";
      var_3 = var_3 + 1;
      break;
    case "off":
      var_5 = "off";

      if(var_0 == "life_support") {
        var_3 = var_3 - 1;
      }

      break;
    case "hacked":
      var_5 = "ready";
      var_3 = var_3 + 1.5;
      break;
    case "hacking":
      var_5 = "hack";
      var_3 = var_3 + 0.3;
      break;
    default:
      var_5 = "hack";
      break;
  }

  var_6 = var_2 + "_" + var_5 + "_" + var_4;
  wait(var_3);
  _id_0F00::_id_CDBC(var_6, 1);
}

_id_87E3() {
  if(!isDefined(self._id_4D94._id_8EBC)) {
    self._id_8EBC = 0;
  } else {
    self._id_8EBC = max(self._id_8EBC - 1, 0);
  }

  if(self._id_8EBC > 0) {
    return;
  }
  if(!isDefined(self._id_55F2)) {
    self._id_55F2 = 0;
  }

  self._id_13BEE = _id_8796();
  self._id_9028 = _id_8794();
  thread _id_DAB9();
  self._id_32D9 _id_0E46::_id_48C4(undefined, (0, 0, 4), undefined, undefined, 300);
  self notify("hack_show");
}

_id_87AC() {
  if(!isDefined(self._id_8EBC)) {
    self._id_8EBC = 1;
  } else {
    self._id_8EBC = self._id_8EBC + 1;
  }

  if(self._id_8EBC > 1) {
    return;
  }
  self notify("hack_hide");

  if(isDefined(self._id_9028)) {
    self._id_9028 destroy();
    self._id_9028 = undefined;
  }

  if(isDefined(self._id_13BEE)) {
    self._id_13BEE cleartargetEnt();
    self._id_13BEE destroy();
    self._id_13BEE = undefined;
  }

  self._id_32D9 _id_0E46::_id_DFE3();
}

_id_DABB() {
  var_0 = level scripts\engine\utility::waittill_any_return("hack_success", "hack_fail", "proximity_hack_end");

  if(var_0 == "hack_success") {
    thread _id_87C7();
  }

  thread _id_87C2();
}

_id_87C6(var_0) {
  level._id_4BC6 = self;

  if(isDefined(self._id_4D94._id_505A)) {
    _id_5075(self._id_4D94);
  }

  wait 0.8;

  if(scripts\engine\utility::flag("proximity_hacking")) {
    thread _id_134F9(var_0, "hacking");
  }
}

_id_87C2() {
  if(isDefined(self._id_4D94._id_505A)) {
    _id_5074();
  }

  level.player enableweapons();
  level.player freezecontrols(0);
  level._id_4BC6 = undefined;
}

_id_87C7() {
  scripts\sp\utility::_id_2669("system_hacked");
}

_id_8794() {
  var_0 = level.player scripts\sp\hud_util::createfontstring("default", 1.5);
  var_0.alignx = "center";
  var_0.aligny = "bottom";
  var_0.horzalign = "center";
  var_0.vertalign = "bottom";
  var_0.alpha = 0;

  if(isDefined(self._id_4D94.hintstring)) {
    var_1 = self._id_4D94.hintstring;
  } else {
    var_1 = "System Interface";
  }

  var_0 settext(var_1);
  return var_0;
}

_id_8796() {
  var_0 = scripts\sp\hud_util::createicon(self._id_4D94.icon, 100, 100);
  var_0 settargetEnt(self._id_32D9);
  var_0 setwaypoint(1, 1, 1);
  var_0.alpha = 0.0;
  return var_0;
}

_id_DAB9() {
  self endon("hack_hide");
  var_0 = 1;
  thread _id_DAB8();

  for(;;) {
    var_1 = level.player.origin[2] - self.origin[2];
    var_1 = abs(var_1);

    if(scripts\sp\utility::_id_D40E(1000, self.origin) && var_1 < 80) {
      if(self._id_13BEE.alpha < 1) {
        if(var_0) {
          level.player playSound("sa_found_system");

          for(var_2 = 0; var_2 < 6; var_2++) {
            self._id_13BEE.alpha = 1;
            self._id_13BEE fadeovertime(0.1);
            wait 0.1;
            self._id_13BEE.alpha = 0;
            self._id_13BEE fadeovertime(0.1);
            wait 0.1;
          }

          self._id_13BEE.alpha = 1;
          self._id_13BEE fadeovertime(0.5);
          var_0 = 0;
        } else {
          self._id_13BEE fadeovertime(1);
          self._id_13BEE.alpha = 1;
        }
      }

      if(!scripts\engine\utility::flag("hack_nearby_nag_cooldown") && self._id_55F2 == 0) {
        if(self._id_4D94._id_113AC == "life_support") {
          thread scripts\sp\utility::_id_10350("ship_assault_eth_lifesupportsyst", 0.05);
        }

        if(self._id_4D94._id_113AC == "robotics") {
          thread scripts\sp\utility::_id_10350("ship_assault_eth_roboticssystems", 0.05);
        }

        scripts\engine\utility::flag_set("hack_nearby_nag_cooldown");
        level thread scripts\sp\utility::_id_6E2B("hack_nearby_nag_cooldown", randomfloatrange(20.0, 25.0));
      }
    } else if(self._id_13BEE.alpha > 0) {
      self._id_13BEE fadeovertime(1);
      self._id_13BEE.alpha = 0;
    }

    wait 0.05;
  }
}

_id_DAB8() {
  self endon("hack_hide");

  for(;;) {
    if(scripts\sp\utility::_id_D40E(100, self.origin)) {
      if(self._id_9028.alpha < 1) {
        self._id_9028 fadeovertime(0.5);
        self._id_9028.alpha = 1;
      }
    } else if(self._id_9028.alpha > 0) {
      self._id_9028 fadeovertime(0.5);
      self._id_9028.alpha = 0;
    }

    wait 0.05;
  }
}

_id_DAB7(var_0) {
  self endon("panel_hacked_unused");
  self endon("hack_complete");
  var_1 = self;
  var_2 = 1;
  var_3 = 1;

  if(isDefined(var_0.icon)) {
    var_4 = scripts\sp\hud_util::createicon(var_0.icon, 5, 5);
    var_4 setwaypoint(1, 1, 1);
    var_4 settargetEnt(var_1);
    var_4.alpha = 0.0;
    thread _id_517D(var_4, "panel_hacked_unused");
    thread _id_517D(var_4, "hack_complete");
  } else
    return;

  while(isDefined(var_1)) {
    var_5 = level.player.origin[2] - self.origin[2];
    var_5 = abs(var_5);

    while(scripts\sp\utility::_id_D40E(1000, self.origin) && !scripts\engine\utility::flag("proximity_hacking") && var_5 < 80) {
      if(var_4.alpha < 1) {
        var_4 fadeovertime(1);
        var_4.alpha = 1;
      }

      if(var_0._id_113AC == "life_support" && var_2) {
        thread scripts\sp\utility::_id_16C5("Eth3n", "Life support systems are nearby.");
        var_2 = 0;
      }

      if(var_0._id_113AC == "robotics" && var_3) {
        thread scripts\sp\utility::_id_16C5("Eth3n", "Robotics systems are nearby.");
        var_3 = 0;
      }

      wait 0.5;
    }

    if(var_4.alpha > 0) {
      var_4 fadeovertime(1);
      var_4.alpha = 0;
    }

    wait 0.5;
  }
}

_id_517D(var_0, var_1) {
  self waittill(var_1);

  if(isDefined(var_0)) {
    var_0 destroy();
    var_0 = undefined;
  }
}

_id_10DE1(var_0, var_1) {
  if(isDefined(var_1)) {
    self._id_D9E4 = _id_4A0E();
  } else {
    self._id_DA58 = _id_4A0E();
  }

  if(isDefined(var_1)) {
    self._id_D9E3 = _id_4A0D();
  } else {
    self._id_D9E1 = _id_4A0D();
  }
}

_id_F80E(var_0, var_1) {
  if(var_0 > 1) {
    var_0 = 1;
  }

  if(isDefined(var_1)) {
    var_1 scripts\sp\hud_util::updatebar(var_0);
  } else {
    self._id_D9E1 scripts\sp\hud_util::updatebar(var_0);
  }
}

_id_6379() {
  self notify("progress_bar_ended");
  self._id_DA58 scripts\sp\hud_util::destroyelem();
  self._id_D9E1 scripts\sp\hud_util::destroyelem();
}

_id_4A0D() {
  var_0 = scripts\sp\hud_util::_id_4997("white", "black", level._id_F0C1, level._id_F0BF);
  var_0 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, level._id_F0C2);
  return var_0;
}

_id_4A0E() {
  var_0 = scripts\sp\hud_util::_id_4999("default", level._id_F0BE);
  var_0 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, level._id_F0C0);
  return var_0;
}

_id_13061() {
  return scripts\engine\utility::flag("hack_life_support_active");
}

_id_1306A() {
  return scripts\engine\utility::flag("hack_robotics_active");
}

_id_1306B() {
  return scripts\engine\utility::flag("used_security_cameras");
}

_id_882B(var_0) {
  self endon("stop_door_logic");
  var_1 = 0;

  switch (self.script_parameters) {
    case "lock_1":
      var_1 = 1;
      break;
    case "lock_2":
      var_1 = 2;
      break;
    case "lock_3":
      var_1 = 3;
      break;
    case "lock_4":
      var_1 = 4;
      break;
    case "lock_open":
      var_0._id_8804 = 1;
      return;
    case "lock_broken":
      self setModel("ship_assault_broken_door_scanner");
      var_1 = 10;
      return;
    default:
      break;
  }

  if(var_1 == 0) {
    self setModel("bi_command_center_handscanner_c");
    var_2 = scripts\engine\utility::get_target_ent();
    var_2 setModel("bi_command_center_handscanner_c");
    return;
  }

  self makeusable();
  self setHintString("Hold [{+activate}] to initiate proximity hack.");
  var_3 = var_1 - getdvarint("player_hack_skill", 0);
  _id_DAC3(self, 4 * var_3, 384);
  self setModel("bi_command_center_handscanner_c");
  var_0._id_8804 = 1;
  self makeunusable();
  var_2 = scripts\engine\utility::get_target_ent();
  var_2 makeunusable();
  var_2 setModel("bi_command_center_handscanner_c");
  wait 0.05;
}

_id_E1D1() {
  var_0 = getEntArray("life_support_interior_doors", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_EDE7 - 4;
    var_2 _id_AD11();
    var_2 movez(var_3, 0.5);

    if(!isDefined(var_2.script_parameters)) {
      var_2 connectpaths();
    }
  }
}

_id_AD11() {
  var_0 = self;
  var_1 = var_0 scripts\sp\utility::_id_7A8F();

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);
  }
}

_id_78C7(var_0) {
  var_1 = sortbydistance(level._id_FD5B, var_0);
  return var_1[0];
}