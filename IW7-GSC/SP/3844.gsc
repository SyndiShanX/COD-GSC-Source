/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3844.gsc
**************************************/

_id_FCEE() {
  precachemodel("equipment_sdf_kiosk_01_off");
  precachemodel("equipment_sdf_kiosk_01_red_off");
  precachemodel("sdf_handscanner_screen_02");
  precachemodel("sdf_handscanner_screen_03");
  scripts\engine\utility::flag_init("security_cameras_hacked");
}

_id_9587() {
  level._id_E992 = [];
  level._id_E993 = [];
  var_0 = getEntArray("ship_assault_console", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2._id_4550 = var_2.script_type;

    if(isDefined(var_2.script_parameters)) {
      var_2._id_E1B3 = var_2.script_parameters;
    }

    var_2 thread _id_454E();
  }
}

_id_454E() {
  if(isDefined(self.targetname)) {
    level._id_E993[self.targetname] = self;
  }

  if(!isDefined(level._id_E992[self._id_4550])) {
    level._id_E992[self._id_4550] = spawnStruct();
  }

  if(!isDefined(level._id_E992[self._id_4550]._id_454F)) {
    level._id_E992[self._id_4550]._id_454F = [];
  }

  level._id_E992[self._id_4550]._id_454F = scripts\engine\utility::array_add(level._id_E992[self._id_4550]._id_454F, self);
  self._id_E98B = 1;

  switch (self._id_4550) {
    case "zero_g":
      self.hintstring = &"SHIP_ASSAULT_ACCESS_LIFE_SUPPORT";
      self.usefunc = ::_id_E98E;
      thread _id_E990();
      break;
    case "generic":
      self.hintstring = &"SHIP_ASSAULT_ACTIVATE";
      self.usefunc = ::_id_E98E;
      thread _id_E990();
      break;
    case "ship_log":
      self.hintstring = &"SHIP_ASSAULT_READ_SHIP_LOG";
      self.usefunc = ::_id_E98F;
      thread _id_E990();
      break;
    case "proximity_hack":
      self.hintstring = &"SHIP_ASSAULT_HACK_CONSOLE";
      thread _id_E98D();
      break;
    case "proximity_hack_cameras":
      self.hintstring = &"SHIP_ASSAULT_HACK_SECURITY_CAMERAS";
      self._id_885A = 3;
      self._id_8822 = ::_id_FD30;
      thread _id_E98D();
      break;
  }

  thread _id_AED7();
}

_id_E990() {
  self endon("death");

  for(;;) {
    _id_0E46::_id_48C4("tag_use", undefined, self.hintstring, undefined, 700);
    self waittill("trigger");
    _id_0E46::_id_DFE3();

    if(isDefined(self._id_E1B3)) {
      if(!_id_0F10::_id_E1B4()) {
        wait 0.05;
        continue;
      } else {
        self[[self.usefunc]]();
        _id_12BD4();

        if(isDefined(self._id_13081) && self._id_13081 == 1) {
          if(!issubstr(self.model, "_off")) {
            self setModel(self.model + "_off");
          }

          break;
        }

        continue;
      }
    } else {
      self[[self.usefunc]]();
      _id_12BD4();

      if(isDefined(self._id_13081) && self._id_13081 == 1) {
        if(!issubstr(self.model, "_off")) {
          self setModel(self.model + "_off");
        }

        break;
      }
    }

    wait 0.05;
  }
}

_id_E991() {
  if(!isDefined(level.player._id_8C06) || isDefined(level.player._id_8C06) && level.player._id_8C06 == 0) {
    var_0 = spawnStruct();
    var_0.hintstring = "Life Support Systems";
    var_0._id_885A = 1;
    var_0._id_8851 = 1000;
    var_0._id_8822 = _id_0F0A::_id_554C;
    var_0._id_E47C = 30;
    var_0._id_116C0 = "LIFE SUPPORT";
    var_0._id_116AD = "LIFE SUPPORT:\t\t\t\t\t\t\t\t\t\t\t\t\t\tDisrupt Gravity and Life Support Systems";
    var_0._id_4482 = "ACQUIRED LIFE SUPPORT ACCESS";
    var_0.icon = "hud_ability_life_support";
    var_0._id_113AC = "life_support";
    var_0._id_4BF9 = 0.0;
    level.player _id_0F0A::_id_169A(var_0);
    level.player._id_8C06 = 1;
    self._id_13081 = 1;

    if(!issubstr(self.model, "_off")) {
      self setModel(self.model + "_off");
    }

    _id_0F12::_id_FD0D(self);
  } else if(isDefined(level._id_AC74) && level._id_AC74 < 3) {
    _id_0F0A::_id_12E51(1);
    self._id_13081 = 1;

    if(!issubstr(self.model, "_off")) {
      self setModel(self.model + "_off");
    }

    _id_0F12::_id_FD0D(self);
  } else
    level.player playSound("sa_hack_use_fail");

  wait 0.05;
}

_id_E98D() {
  wait 1.0;

  if(scripts\sp\utility::hastag(self.model, "tag_locked")) {
    self showpart("tag_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_unlocked")) {
    self hidepart("tag_unlocked", self.model);
  }

  var_0 = "assault_system";
  thread _id_87D6();
  self._id_4D94 = spawnStruct();

  if(isDefined(self._id_9026)) {
    self._id_4D94.origin = self._id_9026.origin;
  } else {
    self._id_4D94.origin = self gettagorigin("tag_use");
  }

  if(isDefined(self._id_885A)) {
    self._id_4D94._id_885A = self._id_885A;
  } else if(isDefined(level._id_885A)) {
    self._id_4D94._id_885A = level._id_885A;
  } else {
    self._id_4D94._id_885A = 16;
  }

  if(isDefined(level._id_8851)) {
    self._id_4D94._id_8851 = level._id_8851;
  } else {
    self._id_4D94._id_8851 = 384;
  }

  self._id_4D94._id_116C0 = self.script_objective;
  self._id_4D94.icon = "specialty_hardline";
  self._id_4D94._id_113AC = var_0;
  self._id_4D94.hintstring = "Generic Hack";

  if(isDefined(self._id_8822)) {
    self._id_4D94._id_8822 = self._id_8822;
  } else {
    self._id_4D94._id_8822 = ::_id_7777;
  }

  self._id_4D94._id_113A8 = level._id_FD5B.size;
  self._id_4D94._id_4BF9 = 0.0;
  self._id_4D94._id_DC04 = self._id_4D94.origin - (0, 0, 20);

  if(isDefined(self._id_EF20)) {
    self._id_4D94._id_4C64 = self._id_EF20;
  } else {
    self._id_4D94._id_4C64 = "generic_hack_complete";
  }

  if(isDefined(self._id_E99B) && isDefined(self._id_E99B._id_EDA0)) {
    scripts\engine\utility::flag_wait(self._id_E99B._id_EDA0);
  }

  _id_E98C();
}

_id_E98C() {
  self endon("stop_sa_console_armory_hack_think");
  self.cooldown = 0;
  self._id_8804 = 0;
  self._id_32D9 = scripts\engine\utility::spawn_tag_origin(self._id_4D94.origin, self.angles);

  if(isDefined(self.collision)) {
    self.collision disconnectPaths();
  }

  for(;;) {
    if(scripts\engine\utility::is_true(self._id_7274)) {
      break;
    }

    self._id_32D9 _id_0E46::_id_48C4("tag_origin", undefined, self.hintstring);
    self._id_32D9 waittill("trigger");
    level notify("hack_started");
    thread _id_CF6B();
    wait 0.5;
    self._id_32D9 _id_0E46::_id_DFE3();

    if(_id_0F10::_id_8B8A()) {
      break;
    } else {
      thread _id_0F14::_id_DAB5(self._id_4D94._id_885A, self._id_4D94._id_113AC, self._id_4D94._id_8851, self._id_4D94._id_DC04);
      var_0 = scripts\engine\utility::waittill_any_return("hack_success", "hack_fail");

      if(var_0 == "hack_success") {
        break;
      } else
        continue;
    }
  }

  if(scripts\sp\utility::hastag(self.model, "tag_locked")) {
    self hidepart("tag_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_unlocked")) {
    self showpart("tag_unlocked", self.model);
  }

  if(isDefined(self._id_32D9)) {
    self._id_32D9 _id_0E46::_id_DFE3();
  }

  if(isDefined(self._id_4550)) {
    if(!issubstr(self.model, "_off")) {
      self setModel(self.model + "_off");
    }
  }

  if(isDefined(self._id_5A57) && self._id_5A57 == "sa_armory_loot_door") {
    thread scripts\sp\utility::play_sound_on_entity("sa_armory_door_unlock_01");
  }

  self thread[[self._id_4D94._id_8822]]();
  _id_12BD4();
  level notify("armory_loot_door_hacked");
}

_id_CF6B() {
  setomnvar("ui_wrist_pc", 5);
  level.player forceplaygestureviewmodel("ges_door_hack", undefined, 0.05);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_autoreload(0);
  level.player thread scripts\sp\utility::play_sound_on_entity("sa_armory_door_hack_start_01");
  wait 2.5;
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_autoreload(1);
  setomnvar("ui_wrist_pc", 1);
}

_id_87D6() {
  var_0 = getEntArray("vault_screen", "targetname");

  foreach(var_2 in var_0) {
    foreach(var_4 in level._id_E99C) {
      if(var_2 istouching(var_4)) {
        var_2 thread _id_87D7();
      }
    }
  }
}

_id_87D7() {
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("sdf_handscanner_screen_02");
  var_0 hide();
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("sdf_handscanner_screen_03");
  var_1 hide();
  level waittill("hack_started");
  wait 2;
  self hide();
  var_0 show();
  level waittill("proximity_hack_end");
  wait 3;
  self hide();
  var_0 hide();
  var_1 show();
  thread scripts\sp\utility::play_sound_on_entity("sa_armory_door_ui_open_01");
}

_id_7777() {
  level notify(self._id_4D94._id_4C64);
}

_id_E98E() {
  if(isDefined(self._id_EF20) && isDefined(level._id_74D5[self._id_EF20])) {
    [[level._id_74D5[self._id_EF20]]]();
  }

  wait 0.05;
}

_id_E98F() {
  _id_56C7(self._id_EF20);
  wait 0.05;
}

_id_4544() {
  self disableweapons();
  self freezecontrols(1);
  self setstance("stand");
  self allowprone(0);
  self allowcrouch(0);
  self allowsprint(0);
  self _meth_80D1();
}

_id_4545() {
  self enableweapons();
  self allowsprint(1);
  self freezecontrols(0);
  self allowprone(1);
  self allowcrouch(1);
  self _meth_80A1();
}

_id_7987(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE52)) {
      if(var_5._id_EE52 == var_2) {
        return var_5;
      }
    }
  }
}

_id_A597(var_0) {
  wait 3.0;
  var_1 = spawnStruct();
  var_1.keyname = var_0;
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.model = "beacon_intel_tablet";
  var_1._id_FFFE = 0;
  var_1._id_CB2B = "captain_key_pickedUp";
  var_1.owner = self;
  var_1._id_4F4C = "Captain's Key Acquired!";
  var_1._id_4F58 = "Captain's Key Used!";
  level thread _id_0F10::_id_FCFC(var_1);
}

_id_56C7(var_0) {
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_fire(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_mantle(0);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_sprint(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\engine\utility::allow_wallrun(0);
  level.player scripts\engine\utility::allow_usability(0);
  level.player scripts\engine\utility::allow_lean(0);
  var_1 = pow(120, 2);
  setomnvar("ui_shiplog_text", var_0);
  setomnvar("ui_shiplog", 1);

  for(;;) {
    var_2 = level.player scripts\sp\utility::_id_137A4("luinotifyserver", "shipLogClose", 0.05);

    if(isDefined(var_2) && var_2 == "shipLogClose") {
      break;
    }

    if(distancesquared(level.player.origin, self.origin) > var_1 || vectordot(vectorNormalize(self.origin - level.player.origin), anglesToForward(level.player getplayerangles())) < 0.707) {
      break;
    }
  }

  setomnvar("ui_shiplog", 0);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_melee(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player scripts\engine\utility::allow_fire(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_mantle(1);
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_sprint(1);
  level.player scripts\engine\utility::allow_weapon_switch(1);
  level.player scripts\engine\utility::allow_wallrun(1);
  level.player scripts\engine\utility::allow_usability(1);
  level.player scripts\engine\utility::allow_lean(1);
}

_id_AED7() {
  var_0 = scripts\sp\utility::_id_7A8F();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      switch (var_2.script_noteworthy) {
        case "sa_door_in_use_trigger":
          if(isDefined(var_2._id_5978)) {
            var_2._id_5978 _id_0F05::_id_AED6(0);
          }

          break;
        default:
          break;
      }
    }
  }
}

_id_12BD4() {
  var_0 = scripts\sp\utility::_id_7A8F();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      switch (var_2.script_noteworthy) {
        case "sa_door_in_use_trigger":
          if(isDefined(var_2._id_5978)) {
            var_2._id_5978 _id_0F05::_id_12BD3(1);
          }

          break;
        default:
          break;
      }
    }
  }
}

_id_FD30() {
  level thread _id_37CA();

  foreach(var_1 in level._id_E992["proximity_hack_cameras"]._id_454F) {
    var_1 notify("stop_sa_console_armory_hack_think");

    if(isDefined(var_1._id_32D9)) {
      var_1 setModel("equipment_sdf_kiosk_01_off");
      var_1._id_32D9 _id_0E46::_id_DFE3();
    }
  }

  var_3 = scripts\sp\utility::_id_7A97();
  var_4 = 85;
  var_5 = 0;

  if(isDefined(var_3)) {
    foreach(var_7 in var_3) {
      var_7._id_37C2 = scripts\engine\utility::spawn_tag_origin(var_7.origin, var_7.angles);
      var_7._id_37C2 thread _id_FD2D();
    }

    foreach(var_7 in var_3) {
      scripts\sp\pip_util::_id_CBB5(var_7._id_37C2, "tag_origin", var_4);
      level._id_CB9C.aspectratio = 1.84;
      wait 0.75;
      scripts\sp\pip_util::_id_CBA3();
    }

    foreach(var_7 in var_3) {
      if(isDefined(var_7._id_37C2)) {
        var_7._id_37C2 delete();
      }
    }
  }

  level.player _id_0F16::_id_FCF5();
  wait 0.05;
  scripts\engine\utility::flag_set("security_cameras_hacked");
}

_id_37CA() {
  scripts\sp\utility::_id_10350("vip_eth_interfacing");
}

_id_11409() {
  var_0 = [];
  var_0[var_0.size] = "vip_eth_marking_targets";
  var_0[var_0.size] = "vip_eth_accessing_feeds";
  var_0[var_0.size] = "vip_eth_tracking_sdf";
  var_0[var_0.size] = "vip_eth_tracking_targets";

  for(;;) {
    level waittill("spawn_room_and_tag_guys");
    scripts\sp\utility::_id_10350(scripts\engine\utility::random(var_0));
    wait 10;
  }
}

_id_FD2D() {
  self endon("death");
  var_0 = 6;
  var_1 = 4;
  self.angles = (self.angles[0], self.angles[1] - 45, self.angles[2]);

  for(;;) {
    self rotateYaw(90, var_0, 2, 2);
    wait(var_0 + var_1);
    self rotateYaw(-90, var_0, 2, 2);
    wait(var_0 + var_1);
  }
}