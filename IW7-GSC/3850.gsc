/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3850.gsc
**************************************/

_id_F994() {
  var_0 = _id_239B();
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = "forward";

  if(isDefined(self.spawnflags)) {
    if(self.spawnflags & 16) {
      var_1 = 1;

      if(self.spawnflags & 64) {
        var_4 = "forward";
      } else if(self.spawnflags & 128) {
        var_4 = "backward";
      }
    }
  }

  if(!isDefined(self._id_EEE5)) {
    var_3 = 16;
  } else {
    var_3 = self._id_EEE5;
  }

  if(!isDefined(self.radius)) {
    var_5 = 384;
  } else {
    var_5 = self.radius;
  }

  switch (var_0) {
    case "key":
      var_2 = spawnStruct();
      var_2._id_885A = var_3;
      var_2._id_8851 = var_5;
      var_2._id_116C0 = self.script_objective;
      var_2.icon = "breach_icon";
      var_2._id_113AC = var_0;
      var_2.hintstring = "AIRLOCK SYSTEMS CONTROL";
      var_2._id_8822 = _id_0F06::_id_6661;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2._id_4BF9 = 0.0;
      var_2._id_113AC = var_0;

      if(self.spawnflags & 32) {
        var_2._id_595A = 1;
      }

      if(isDefined(var_1)) {
        var_2._id_505A = 1;
      }

      level._id_FD5C = 1;
      break;
    case "generic":
      var_2 = spawnStruct();
      var_2._id_885A = var_3;
      var_2._id_8851 = var_5;
      var_2._id_116C0 = self.script_objective;
      var_2.icon = "specialty_hardline";
      var_2._id_113AC = var_0;
      var_2.hintstring = "Generic Hack";
      var_2._id_8822 = ::_id_7777;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2._id_4BF9 = 0.0;
      var_2._id_113AC = var_0;
      var_2._id_505E = var_4;

      if(self.spawnflags & 32) {
        var_2._id_595A = 1;
      }

      if(isDefined(var_1)) {
        var_2._id_505A = 1;
      }

      if(isDefined(self.script_noteworthy)) {
        var_2._id_4C64 = self.script_noteworthy;
      } else {
        var_2._id_4C64 = "generic_hack_complete";
      }

      break;
    case "life_support":
      var_2 = spawnStruct();
      var_2.hintstring = "Life Support Systems";
      var_2._id_885A = var_3;
      var_2._id_8851 = var_5;
      var_2._id_8822 = ::_id_554C;
      var_2._id_E47C = 30;
      var_2._id_116C0 = "LIFE SUPPORT";
      var_2._id_116AD = "LIFE SUPPORT:\t\t\t\t\t\t\tDisrupt Gravity and Life Support Systems";
      var_2._id_4482 = "ACQUIRED LIFE SUPPORT ACCESS";
      var_2.icon = "hud_ability_life_support";
      var_2._id_113AC = var_0;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2._id_4BF9 = 0.0;
      var_2._id_505E = var_4;

      if(self.spawnflags & 32) {
        var_2._id_595A = 1;
      }

      if(isDefined(var_1)) {
        var_2._id_505A = 1;
      }

      break;
    case "turrets":
      var_2 = spawnStruct();
      var_2.hintstring = "Turret Control Systems";
      var_2._id_885A = var_3;
      var_2._id_8851 = var_5;
      var_2._id_E47C = 2;
      var_2._id_505E = var_4;

      if(isDefined(var_1)) {
        var_2._id_505A = 1;
      }

      var_2._id_116C0 = "SECURITY SYSTEMS";
      var_2._id_116AD = "SECURITY SYSTEMS:\t\t\t\t\t\tDisable Then Retarget Security Turrets";
      var_2.icon = "specialty_saboteur";
      var_2._id_113AC = var_0;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2._id_4BF9 = 0.0;

      if(self.spawnflags & 32) {
        var_2._id_595A = 1;
      }

      break;
    case "robotics":
      var_2 = spawnStruct();
      var_2.hintstring = "Robotics Control Interface";
      var_2._id_885A = var_3;
      var_2._id_8851 = var_5;
      var_2._id_8822 = ::_id_5579;
      var_2._id_E47C = 2;
      var_2._id_505E = var_4;

      if(isDefined(var_1)) {
        var_2._id_505A = 1;
      }

      var_2._id_116C0 = " AI SYSTEMS";
      var_2._id_4482 = "ACQUIRED ROBOTICS SYSTEM ACCESS";
      var_2._id_116AD = "AI SYSTEMS:Disable All Robotics";
      var_2.icon = "specialty_saboteur";
      var_2._id_113AC = var_0;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2._id_4BF9 = 0.0;

      if(self.spawnflags & 32) {
        var_2._id_595A = 1;
      }

      break;
  }

  if(isDefined(var_2)) {
    if(isDefined(self.target)) {
      var_2._id_DC04 = scripts\engine\utility::getStruct(self.target, "targetname").origin;
    } else {
      var_2._id_DC04 = self.origin - (0, 0, 48);
    }

    self._id_4D94 = var_2;

    if(!isDefined(self.angles)) {
      self.angles = (0, 0, 0);
    }

    level._id_FD5B[level._id_FD5B.size] = self;
  }
}

_id_239B() {
  var_0 = self;
  var_1 = undefined;
  var_2 = 0;

  if(self.spawnflags & 1) {
    var_1 = "life_support";
    var_2 = 1;
  }

  if(self.spawnflags & 2) {
    var_1 = "robotics";
    var_2 = 1;
  }

  if(self.spawnflags & 4) {
    var_1 = "turrets";
    var_2 = 1;
  }

  if(self.spawnflags & 8) {
    var_1 = "generic";
    var_2 = 1;
  }

  return var_1;
}

_id_16C8() {
  var_0 = newhudelem();
  var_0.sort = 0;
  var_0.x = -150;
  var_0.y = -30;
  var_0.hidewheninmenu = 1;
  var_0.hidewhendead = 1;
  var_0.alignx = "center";
  var_0.aligny = "bottom";
  var_0.horzalign = "center";
  var_0.vertalign = "bottom";
  var_0.alpha = 0.5;
  var_0 setshader("hud_dpad", 40, 40);
}

_id_16C9(var_0) {
  var_1 = newhudelem();
  var_1.sort = 0;
  var_1.x = 0;
  var_1.y = 50;
  var_1.hidewheninmenu = 1;
  var_1.hidewhendead = 1;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.alpha = 1;
  var_1 setshader(var_0, 30, 30);
  return var_1;
}

_id_16CA(var_0, var_1) {
  wait 1.0;

  if(var_1 == "right") {
    var_2 = -113;
    var_3 = -35;
  }

  if(var_1 == "up") {
    var_2 = -150;
    var_3 = -60;
  } else {
    var_2 = -150;
    var_3 = 0;
  }

  var_0 moveovertime(1.0);
  var_0.x = var_2;
  var_0.y = var_3;
  var_0.alignx = "center";
  var_0.aligny = "bottom";
  var_0.horzalign = "center";
  var_0.vertalign = "bottom";

  if(isDefined(var_0.children) && var_0.children.size > 0) {
    var_0 scripts\sp\hud_util::updatechildren(1.0);
  }
}

_id_216A(var_0) {
  level.player endon("death");

  if(var_0 == "life support") {
    setomnvar("ui_ship_assault_life_support", 1);
    level.player setweaponhudiconoverride("actionslot1", "hud_ability_life_support");
  }
}

_id_169A(var_0) {
  if(level._id_8814.size < 1) {} else {
    foreach(var_2 in level._id_8814) {
      if(var_2._id_113AC == var_0._id_113AC) {
        return;
      }
    }
  }

  if(var_0._id_113AC == "life_support") {
    scripts\engine\utility::flag_set("hack_life_support_active");
    scripts\engine\utility::waitframe();
    level.player setweaponhudiconoverride("actionslot1", var_0.icon);
    _id_12E51(1);
    level._id_8814 = scripts\engine\utility::array_add(level._id_8814, var_0);
    scripts\engine\utility::flag_clear("hack_life_support_active");
    scripts\engine\utility::delaythread(3, ::_id_216D, "hint_life_support");
    level.player _id_0E44::_id_169B("up", ::_id_216C);
  } else {
    scripts\engine\utility::flag_set("hack_robotics_active");
    var_0._id_9140 = _id_16C9(var_0.icon);
    level._id_8814 = scripts\engine\utility::array_add(level._id_8814, var_0);
    _id_16CA(var_0._id_9140, "down");
    scripts\engine\utility::flag_clear("hack_robotics_active");
    scripts\engine\utility::delaythread(3, ::_id_216D, "hint_robotics");
    thread _id_877D(var_0._id_9140);
    level.player _id_0E44::_id_169B("down", ::_id_216B);
    thread scripts\sp\utility::_id_10350("ship_assault_eth_youcandisableth");
  }
}

_id_12E51(var_0) {
  if(isDefined(var_0) && var_0 == 1) {
    level._id_AC74 = 3;
  } else {
    level._id_AC74 = 3;
  }

  if(level._id_AC74 <= 0) {
    thread _id_877C();
  } else {
    _id_877E();
  }
}

_id_216D(var_0) {
  var_1 = 1;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  level endon("hack_life_support_active");
  level endon("hack_robotics_active");

  while(!scripts\engine\utility::flag("hack_life_support_active") && !scripts\engine\utility::flag("hack_robotics_active")) {
    var_5 = getaiarray("axis");

    foreach(var_7 in var_5) {
      if(var_7.unittype == "c6" || var_7.unittype == "c6i") {
        var_3 = 1;
      }

      if(distance(level.player.origin, var_7.origin) < 1000) {
        if(var_0 == "hint_robotics" && !var_3) {
          var_3 = 0;
          continue;
        }

        var_2++;
      }
    }

    if(var_0 == "hint_robotics") {
      if(isDefined(level._id_FD26) && level._id_FD26.size > 0) {
        foreach(var_10 in level._id_FD26) {
          if(distance(level.player.origin, var_10.origin) < 1000) {
            var_2++;
          }
        }
      }
    }

    if(var_1 == 1 || var_2 > 2) {
      scripts\sp\utility::_id_56BE(var_0, 4);
    }

    var_2 = 0;
    var_1 = 0;
    wait 15;
  }
}

_id_216C() {
  var_0 = undefined;

  foreach(var_2 in level._id_8814) {
    if(var_2._id_113AC == "life_support") {
      var_0 = var_2;
      break;
    }
  }

  if(!scripts\engine\utility::flag("hack_life_support_active") && !scripts\engine\utility::flag("hack_life_support_cooling") && !scripts\engine\utility::flag("hack_activation_paused")) {
    _id_12E51();
    level notify("arm_device_update");
    scripts\engine\utility::flag_set("hack_life_support_active");
    level._id_8845 = 0;
    level.player thread _id_554C();
    wait 10;
    scripts\engine\utility::flag_clear("hack_life_support_active");
    scripts\engine\utility::flag_set("hack_life_support_cooling");
    level._id_8845 = 1;
    wait 20;

    if(level._id_AC74 > 0) {
      level thread _id_216A("life support");
    }

    scripts\engine\utility::flag_clear("hack_life_support_cooling");

    if(!scripts\engine\utility::flag("hack_activation_paused")) {
      level.player playSound("sa_ability_cooldown");
    }
  } else {
    if(level.player adsButtonPressed()) {
      return;
    }
    level.player playSound("sa_hack_use_fail");
    return;
  }
}

_id_216B() {
  var_0 = undefined;

  foreach(var_2 in level._id_8814) {
    if(var_2._id_113AC == "robotics") {
      var_0 = var_2;
      break;
    }
  }

  if(!scripts\engine\utility::flag("hack_robotics_active") && !scripts\engine\utility::flag("hack_robotics_cooling") && !scripts\engine\utility::flag("hack_activation_paused")) {
    level notify("arm_device_update");
    scripts\engine\utility::flag_set("hack_robotics_active");
    level.player playSound("sa_ability_powerdown_lr");
    thread _id_0F14::_id_134F9("robotics", "off");
    level.player thread _id_5579();
    _id_9149(var_0._id_9140, 6);
    level.player notify("arm_item_end_robotics_hack");
    scripts\engine\utility::flag_clear("hack_robotics_active");
    scripts\engine\utility::flag_set("hack_robotics_cooling");
    level.player playSound("sa_ability_poweron_lr");
    thread _id_0F14::_id_134F9("robotics", "on");
    wait 18;
    level thread _id_216A("robotics");
    scripts\engine\utility::flag_clear("hack_robotics_cooling");

    if(!scripts\engine\utility::flag("hack_activation_paused")) {
      level.player playSound("sa_ability_cooldown");
      var_0._id_9140 fadeovertime(0.5);
      var_0._id_9140.alpha = 1.0;
    }
  } else {
    if(level.player adsButtonPressed()) {
      return;
    }
    level.player playSound("sa_hack_use_fail");
    return;
  }
}

_id_877C() {
  level notify("hack_pause_repeat_check");
  level endon("hack_pause_repeat_check");
  scripts\engine\utility::flag_set("hack_activation_paused");
  scripts\engine\utility::flag_wait_any("hack_life_support_cooling", "hack_robotics_cooling");
  scripts\engine\utility::flag_clear("hack_life_support_cooling");
  scripts\engine\utility::flag_clear("hack_life_support_active");
  scripts\engine\utility::flag_clear("hack_robotics_cooling");
  scripts\engine\utility::flag_clear("hack_robotics_active");
}

_id_877E() {
  level notify("hack_pause_repeat_check");
  scripts\engine\utility::flag_clear("hack_activation_paused");
}

_id_877D(var_0) {
  level.player endon("death");

  for(;;) {
    scripts\engine\utility::flag_wait("hack_activation_paused");
    var_0 fadeovertime(0.5);
    var_0.alpha = 0.15;
    scripts\engine\utility::flag_waitopen("hack_activation_paused");
    var_0 fadeovertime(0.5);
    var_0.alpha = 1.0;
  }
}

_id_9149(var_0, var_1) {
  thread _id_9148(var_0, var_1);
  wait(var_1);
  level notify("hud_icon_flash_ender");
  var_0 fadeovertime(1);
  var_0.alpha = 0.15;
}

_id_9148(var_0, var_1) {
  level endon("hud_icon_flash_ender");
  level endon("hack_success");
  level endon("hack_fail");

  for(var_2 = var_1; var_2 > 0; var_2--) {
    var_3 = var_2 / var_1 / 2;

    for(var_4 = 1; var_4 >= 0; var_4 = var_4 - var_3) {
      var_0 fadeovertime(var_3);
      var_0.alpha = 0;
      wait(var_3);
      var_0 fadeovertime(var_3);
      var_0.alpha = 1;
      wait(var_3);
    }
  }
}

_id_2169(var_0) {
  var_1 = var_0;
  var_2 = 0;

  for(;;) {
    if(var_2 == var_1) {
      level.player notify("arm_item_end_hack");
      break;
    }

    wait 1.0;
    var_2++;
  }
}

_id_554C() {
  level.player endon("death");
  level.player playSound("sa_ability_lifesupport_off_lr");
  setglobalsoundcontext("atmosphere", "space", 2);
  thread _id_0F14::_id_134F9("life_support", "off");
  level.player thread life_support_cleanup_equipment_disable_use();

  if(isDefined(level._id_13FB1)) {
    level thread[[level._id_13FB1]]();
  } else {
    level thread _id_AC66();
  }

  scripts\engine\utility::flag_set("combat_pause_spawning");
  level.player scripts\sp\utility::_id_1C75(0);
  scripts\sp\utility::_id_F3E4(undefined, 0.1);
  thread _id_AC5D();
  level.player setweaponhudiconoverride("actionslot1", "none");
  setomnvar("ui_ship_assault_life_support", 2);
  level.player playRumbleOnEntity("damage_heavy");
  thread _id_D1D2();
  wait 2;
  level.player thread _id_CD73();
  scripts\engine\utility::flag_wait("hack_life_support_cooling");
  level.player scripts\engine\utility::allow_ads(0);
  setomnvar("ui_ship_assault_life_support", 3);
  scripts\sp\utility::_id_E1F0();
  scripts\engine\utility::flag_clear("combat_pause_spawning");
  level.player scripts\sp\utility::_id_1C75(1);
  level.player scripts\engine\utility::waittill_any_timeout(5, "spacejump_land");
  scripts\engine\utility::waitframe();
  level.player scripts\engine\utility::allow_ads(1);
  level.player life_support_equipment_enable_use();
  wait 5;
  setomnvar("ui_ship_assault_life_support", 0);
}

life_support_cleanup_equipment_disable_use() {
  level thread _id_0E26::_id_DFC1();
  level thread _id_0E21::_id_DFBA();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(0);
  level.player scripts\engine\utility::allow_usability(0);
}

life_support_equipment_enable_use() {
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(1);
  level.player scripts\engine\utility::allow_usability(1);
}

_id_1D0F(var_0) {
  self endon("death");

  if(isDefined(self.enemy)) {
    scripts\anim\combat::_id_6A6F();
    var_1 = "life_support_ally_lift_" + randomintrange(1, 3);
    scripts\sp\anim::_id_1EC7(self, var_1);
    thread scripts\sp\anim::_id_1ECC(self, "life_support_ally_loop_1", "end_zero_g");
    scripts\engine\utility::flag_wait(var_0);
    self notify("end_zero_g");
    scripts\sp\anim::_id_1EC7(self, "life_support_ally_land_" + randomintrange(1, 3));
    return;
  }

  scripts\sp\anim::_id_1EC7(self, "life_support_ally_lift_1_gundown");
  thread scripts\sp\anim::_id_1ECC(self, "life_support_ally_loop_1_gundown", "end_zero_g");
  scripts\engine\utility::flag_wait(var_0);
  self notify("end_zero_g");
  scripts\sp\anim::_id_1EC7(self, "life_support_ally_land_1_gundown");
}

_id_D1D2(var_0, var_1) {
  level notify("gravity_special_case");

  if(!isDefined(var_0)) {
    var_0 = "hack_life_support_cooling";
  }

  setsaveddvar("ai_corpsesynch", 1);
  _id_0F35::_id_FB24(1, level.player);
  _id_0F35::_id_FB26(0, 1);
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("sa_ability_lifesupport_heartbeat_lp");
  thread _id_FBB5();

  foreach(var_3 in level.allies) {
    var_3 thread _id_1D0F(var_0);
  }

  level.player _meth_8512(0);
  level.player allowwallrun(0);
  scripts\engine\utility::waitframe();
  level.player setvelocity((0, 0, 85));
  scripts\engine\utility::flag_wait(var_0);
  level thread _id_0F09::_id_88FA(1);
  scripts\engine\utility::flag_wait("player_in_gravity");
  scripts\engine\utility::waitframe();

  if(!isDefined(var_1)) {
    level.player thread _id_0F35::_id_D3CD(level._id_AC72);
  }

  _id_CB0E();
  setsaveddvar("ai_corpsesynch", scripts\engine\utility::flag_exist("stealth_enabled") && scripts\engine\utility::flag("stealth_enabled"));
  level.player _meth_8512(1);
  level.player allowwallrun(1);
  level.player thread scripts\engine\utility::stop_loop_sound_on_entity("sa_ability_lifesupport_heartbeat_lp");
}

_id_CB0E() {
  var_0 = getcorpsearray();

  foreach(var_2 in var_0) {
    physicsjolt(var_2 _meth_82CC(), 60, 60, (0, 0, 0.01));
  }

  var_4 = getaiarray();

  foreach(var_2 in var_4) {
    if(isalive(var_2)) {
      continue;
    }
    physicsjolt(var_2.origin, 60, 60, (0, 0, 0.01));
  }
}

_id_AC61(var_0, var_1) {
  var_2 = var_0 - level._id_104AE;
  var_3 = var_1 * 20;
  var_4 = var_2 / var_3;

  while(level._id_104AE < var_0) {
    level._id_104AE = level._id_104AE + var_4;
    wait 0.05;
  }

  level._id_104AE = var_0;
}

_id_AC5D() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("fx_org_view");
  var_0 _meth_81E2(level.player, "tag_origin", (11, 0, 0), (180, 0, 0), 1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_eu_visor_frost_3"), var_0, "tag_origin");
  level waittill("stop_blinking");
  wait 10;
  var_0 delete();
}

_id_FCDC(var_0) {
  level endon("stop_blinking");
  var_0.alpha = 0;
  wait 0.25;
  var_0.alpha = 1;
  wait 0.25;
  var_0.alpha = 0;
  wait 0.25;
  var_0.alpha = 1;
  wait 0.25;
  var_0.alpha = 0;
  wait 0.25;
  var_0.alpha = 1;
  wait 0.25;
  var_0.alpha = 0;
  wait 0.25;
  var_0.alpha = 1;
  wait 0.25;
  var_0.alpha = 0;
  wait 0.25;
  var_0.alpha = 1;
  wait 0.25;
  var_0.alpha = 0;
  wait 0.25;
  var_0.alpha = 1;
}

_id_CD73() {
  self endon("death");

  while(scripts\engine\utility::flag("hack_life_support_active")) {
    self playSound("space_breathe_player_exhale_slomo");
    var_0 = lookupsoundlength("space_breathe_player_exhale_slomo");
    wait(var_0 / 1000 + 1);
    self playSound("space_breathe_player_inhale_slomo");
    var_0 = lookupsoundlength("space_breathe_player_inhale_slomo");
    wait(var_0 / 1000 + 1);
  }
}

_id_AC66(var_0) {
  level.player endon("death");
  var_1 = level._id_4BA7;
  var_2 = [];
  var_3 = [];

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::array_combine(var_1.path["forward"], var_1.path["backward"]);
    var_3 = scripts\engine\utility::array_add(var_2, var_1);
  }

  if(isDefined(level._id_1640) && level._id_1640.size >= 1) {
    foreach(var_5 in level._id_1640) {
      var_3 = scripts\engine\utility::array_add(var_3, getEnt(var_5, "targetname"));
    }
  }

  if(scripts\engine\utility::flag_exist("ship_lock_doors")) {
    scripts\engine\utility::flag_set("ship_lock_doors");
  }

  var_7 = [];

  foreach(var_9 in var_2) {
    foreach(var_11 in var_9._id_1AE3["all"]) {
      if(scripts\engine\utility::array_contains(var_1._id_1AE3["all"], var_11)) {
        continue;
      }
      while(isDefined(var_11._id_4A33)) {
        wait 0.05;
      }

      var_11 show();
      var_11 solid();
      var_12 = var_11.script_index;
      var_11 thread scripts\sp\utility::play_sound_on_entity("sa_breach_door_close");
      var_11 movez(var_12 * -1, 0.5);
      var_11 scripts\engine\utility::delaycall(0.5, ::disconnectpaths);
      var_7[var_7.size] = var_11;
    }
  }

  foreach(var_9 in var_3) {
    scripts\engine\utility::array_thread(var_9._id_13D76, _id_0F17::_id_13D3F);
  }

  if(!isDefined(var_0) || var_0 == 0) {
    level thread _id_AC50(var_3);
  }

  level thread _id_AC5C(var_3);
  scripts\engine\utility::flag_wait("hack_life_support_cooling");
  level.player playSound("sa_ability_lifesupport_on_lr");
  setglobalsoundcontext("atmosphere", "", 2);
  thread _id_0F14::_id_134F9("life_support", "on");
  wait 2;

  if(scripts\engine\utility::flag_exist("ship_lock_doors")) {
    scripts\engine\utility::flag_clear("ship_lock_doors");
  }

  foreach(var_11 in var_7) {
    var_12 = var_11.script_index;
    var_11 thread scripts\sp\utility::play_sound_on_entity("sa_breach_door_open");
    var_11 movez(var_12, 0.5);
    var_11 scripts\engine\utility::delaycall(0.5, ::connectpaths);
    var_11 scripts\engine\utility::delaycall(0.5, ::hide);
    var_11 scripts\engine\utility::delaycall(0.5, ::notsolid);
  }

  foreach(var_9 in var_3) {
    scripts\engine\utility::array_thread(var_9._id_13D76, _id_0F17::_id_13D42);
  }
}

_id_AC50(var_0) {
  level.player endon("death");
  var_1 = getaiarray("axis");
  var_2 = getaiarray("neutral");

  if(var_2.size > 0) {
    var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  }

  foreach(var_4 in var_1) {
    if(var_4.unittype != "c8" || var_4.unittype != "c12") {
      if(var_0.size > 0) {
        foreach(var_6 in var_0) {
          if(var_4 istouching(var_6)) {
            if(var_4.unittype == "c6" || var_4.unittype == "c6i") {
              var_4 thread _id_AC52();
              break;
            } else {
              var_4 thread _id_AC4F();
              break;
            }
          }
        }

        continue;
      }

      if(var_4.unittype == "c6" || var_4.unittype == "c6i") {
        var_4 thread _id_AC52();
        continue;
      }

      var_4 thread _id_AC4F();
    }
  }
}

clean_tag_on_death(var_0) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    if(isDefined(self)) {
      self.space = 1;
    }

    var_0 delete();
  }
}

_id_AC4F(var_0) {
  level.player endon("death");
  self endon("death");
  var_1 = self;

  if(var_1 scripts\sp\utility::_id_58DA()) {
    var_1 _meth_81D0();
    return;
  }

  var_2 = issubstr(self.model, "space");

  if(!var_2) {
    var_2 = issubstr(self.classname, "zerog");
  }

  var_3 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 thread clean_tag_on_death(var_3);
  var_1 linkTo(var_3, "tag_origin");
  var_1.ignoreall = 1;
  var_1.allowdeath = 1;
  var_1.forceragdollimmediate = 1;
  var_1._id_1FBB = "generic";
  var_4 = randomintrange(1, 3);

  if(!scripts\engine\utility::is_true(var_0)) {
    wait(randomfloatrange(0.0, 0.25));
  }

  var_5 = 0;

  if(var_2 && isalive(var_1)) {
    var_3 thread _id_AC5A(var_1);

    if(!scripts\engine\utility::is_true(var_0)) {
      var_3 thread scripts\sp\anim::_id_1F35(var_1, "life_support_lift_" + var_4);
    }

    var_6 = getanimlength(scripts\sp\utility::_id_7DC1("life_support_lift_" + var_4));
    var_7 = randomfloatrange(4, 6);

    if(!scripts\engine\utility::is_true(var_0)) {
      wait(var_7);
    }

    if(isalive(var_1)) {
      var_3 thread _id_AC59(var_1);
    }

    if(!scripts\engine\utility::is_true(var_0)) {
      wait(var_6 - var_7);
    }

    if(isalive(var_1)) {
      var_3 thread scripts\sp\anim::_id_1ECC(var_1, "life_support_shoot", "end_float");
    }

    scripts\engine\utility::flag_wait("hack_life_support_cooling");
    var_3 waittill("float_movement_complete");
  } else if(isalive(var_1)) {
    var_4 = randomintrange(1, 3);
    var_3 thread _id_AC5A(var_1);

    if(!scripts\engine\utility::is_true(var_0)) {
      var_3 thread scripts\sp\anim::_id_1F35(var_1, "life_support_lift_" + var_4);
    }

    var_6 = getanimlength(scripts\sp\utility::_id_7DC1("life_support_lift_" + var_4));

    if(!scripts\engine\utility::is_true(var_0)) {
      wait(var_6);
    }

    if(isalive(var_1)) {
      var_4 = randomintrange(1, 2);
      var_3 thread scripts\sp\anim::_id_1ECC(var_1, "life_support_float_loop_" + var_4, "end_float");
    }

    scripts\engine\utility::flag_wait("hack_life_support_cooling");
    var_1 _meth_83A1();

    if(isalive(var_1)) {
      var_4 = randomintrange(1, 3);
      var_3 scripts\sp\anim::_id_1F35(var_1, "life_support_land_" + var_4);
    }
  }

  var_3 notify("end_float");

  if(isalive(var_1)) {
    var_1 _meth_83A1();
    var_1.ignoreall = 0;
    var_1.forceragdollimmediate = 0;
    var_1 getenemyinfo(level.player);

    if(isDefined(var_1._id_10E6D)) {
      var_1 thread _id_0F1B::_id_F5C9();
    }
  }

  var_1 unlink();
  var_3 delete();
}

_id_AC52(var_0) {
  level.player endon("death");
  self endon("death");
  var_1 = self;

  if(var_1 scripts\sp\utility::_id_58DA()) {
    var_1 _meth_81D0();
    return;
  }

  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(var_2, "tag_origin");
  var_1.ignoreall = 1;
  var_1.allowdeath = 1;
  var_1._id_1FBB = "generic";
  var_3 = randomintrange(1, 3);

  if(!scripts\engine\utility::is_true(var_0)) {
    wait(randomfloatrange(0.0, 0.25));
  }

  var_4 = 0;

  if(isalive(var_1)) {
    var_3 = randomintrange(1, 3);
    var_2 thread _id_AC5A(var_1);
    var_1._id_1FBB = "robot";

    if(!scripts\engine\utility::is_true(var_0)) {
      var_2 scripts\sp\anim::_id_1F35(var_1, "life_support_C6_lift_" + var_3);
    }

    if(isalive(var_1)) {
      var_2 thread _id_AC59(var_1);
    }

    scripts\engine\utility::flag_wait("hack_life_support_cooling");
    var_2 notify("end_float");
    wait 1;

    if(isalive(var_1) && !scripts\engine\utility::is_true(var_1._id_939E)) {
      var_1 _meth_83A1();
      var_1 unlink();
      var_1.ignoreall = 0;
      var_1.forceragdollimmediate = 0;
      var_1 getenemyinfo(level.player);

      if(isDefined(var_1._id_10E6D)) {
        var_1 thread _id_0F1B::_id_F5C9();
      }
    }
  }

  var_2 delete();
}

_id_AC5A(var_0) {
  var_0 endon("death");
  var_1 = self;
  var_2 = issubstr(self.model, "space");
  var_0 thread clean_tag_on_death(var_1);
  var_0 endon("death");
  var_3 = scripts\common\trace::ray_trace(var_0.origin, var_0.origin + (0, 0, 1000), var_0);
  var_4 = distance(var_0.origin, var_3["position"]);

  if(var_4 > 0) {
    var_5 = var_4 / 4;
    var_6 = var_5 * 0.5;
    var_7 = randomfloatrange(var_6, var_5);
  } else
    var_7 = 0;

  var_8 = var_0.origin[2];
  var_9 = randomintrange(-200, 200);

  if(var_2 && isalive(var_0)) {
    var_10 = var_0.origin + (0, 0, 32);
  } else {
    var_10 = var_0.origin;
  }

  var_11 = 1.25;
  var_12 = randomfloatrange(var_11 - 0.5, var_11);
  var_1 movez(var_7, var_12, var_12 * 0.5, var_12 * 0.5);
  scripts\engine\utility::flag_wait("hack_life_support_cooling");
  var_1 moveTo((var_1.origin[0], var_1.origin[1], var_8), var_12 * 0.5, var_12 * 0.25, var_12 * 0.25);
  wait(var_12 * 0.5);
  var_1 notify("float_movement_complete");
}

_id_AC59(var_0) {
  level.player endon("death");
  self endon("end_float");
  var_0 endon("death");
  var_0 thread _id_6F37(self);

  for(;;) {
    var_1 = self;
    var_2 = vectortoangles(level.player.origin - var_1.origin);
    var_1 rotateTo(var_2, 1, 0.5, 0.5);
    wait(randomfloatrange(0.05, 0.5));
    var_3 = randomintrange(1, 3);

    for(var_4 = 0; var_4 < var_3; var_4++) {
      wait(randomfloatrange(0.25, 0.5));
      var_0 shoot();
    }
  }
}

#using_animtree("c6");

_id_6F37(var_0) {
  var_0 endon("end_float");
  self endon("death");
  var_1 = [];
  self._id_1FBB = "robot";

  if(self.unittype == "c6" || self.unittype == "c6i") {
    if(!scripts\engine\utility::flag("hack_robotics_active")) {
      var_0 thread _id_AC56();
    } else {
      return;
    }

    var_1 = [%c6_zg_org_grav_grenade_exposed_aim_idle_ar, %c6_zg_org_grav_grenade_exposed_aim_2_ar, %c6_zg_org_grav_grenade_exposed_aim_4_ar, %c6_zg_org_grav_grenade_exposed_aim_5_ar, %c6_zg_org_grav_grenade_exposed_aim_6_ar, %c6_zg_org_grav_grenade_exposed_aim_8_ar];
  } else {
    var_1 = [];
    return;
  }

  var_2 = 0.2;
  self _meth_82AE(var_1[0], 1, var_2);
  var_0 thread scripts\sp\anim::_id_1EEA(self, "life_support_C6_float_aim_5", "end_float");
  self _meth_82AC(var_1[1], 1, var_2);
  self _meth_82AC(var_1[2], 1, var_2);
  self _meth_82AC(var_1[4], 1, var_2);
  self _meth_82AC(var_1[5], 1, var_2);
  var_3 = 10;
  var_4 = 0;
  var_5 = 0;
  var_6 = 1;

  while(self.weapon != "none") {
    var_7 = self gettagorigin("tag_flash");
    var_8 = level.player getplayerangles();
    var_9 = level.player getorigin() + anglestoup(var_8) * 32;
    var_10 = scripts\sp\utility::_id_13DCC(var_9) - scripts\sp\utility::_id_13DCC(var_7);
    var_11 = vectortoangles(var_10);
    var_12 = angleclamp180(var_11[0]);
    var_13 = angleclamp180(var_11[1]);

    if(var_12 < self.upaimlimit || var_12 > self.downaimlimit || var_13 < self.rightaimlimit || var_13 > self.leftaimlimit) {
      var_12 = 0;
      var_13 = 0;
    }

    if(!var_6) {
      var_14 = var_13 - var_4;

      if(abs(var_14) > var_3) {
        var_13 = var_4 + clamp(var_14, -1 * var_3, var_3);
      }

      var_15 = var_12 - var_5;

      if(abs(var_15) > var_3) {
        var_12 = var_5 + clamp(var_15, -1 * var_3, var_3);
      }
    }

    var_12 = clamp(var_12, self.upaimlimit, self.downaimlimit);
    var_13 = clamp(var_13, self.rightaimlimit, self.leftaimlimit);
    var_6 = 0;
    var_4 = var_13;
    var_5 = var_12;
    _id_6F38(var_1[1], var_1[2], var_1[4], var_1[5], var_12, var_13);
    wait 0.05;
  }
}

_id_6F38(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 1;
  var_8 = 0;

  if(var_5 < 0) {
    var_8 = var_5 / self.rightaimlimit * var_7;
    self _meth_82AC(var_1, 0, var_6, 1, 1);
    self _meth_82AC(var_2, var_8, var_6, 1, 1);
  } else if(var_5 > 0) {
    var_8 = var_5 / self.leftaimlimit * var_7;
    self _meth_82AC(var_1, var_8, var_6, 1, 1);
    self _meth_82AC(var_2, 0, var_6, 1, 1);
  }

  if(var_4 < 0) {
    var_8 = var_4 / self.upaimlimit * var_7;
    self _meth_82AC(var_0, 0, var_6, 1, 1);
    self _meth_82AC(var_3, var_8, var_6, 1, 1);
  } else if(var_4 > 0) {
    var_8 = var_4 / self.downaimlimit * var_7;
    self _meth_82AC(var_0, var_8, var_6, 1, 1);
    self _meth_82AC(var_3, 0, var_6, 1, 1);
  }
}

_id_AC56() {
  self endon("end_float");
  scripts\engine\utility::flag_wait("hack_robotics_active");
  self notify("end_float");
}

_id_AC5C(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = scripts\engine\utility::getStructArray("sa_beacon_fx_struct", "targetname");

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      foreach(var_8 in var_0) {
        if(ispointinvolume(var_6.origin, var_8)) {
          if(isDefined(var_6.target)) {
            var_9 = getEnt(var_6.target, "targetname");

            if(isDefined(var_9)) {
              var_9 _id_AC57("on");
              var_3 = scripts\engine\utility::array_add(var_3, var_9);
            }
          }
        }
      }
    }
  }

  var_12 = scripts\engine\utility::getStructArray("sa_vent_fx_struct", "targetname");

  if(var_12.size > 0) {
    foreach(var_14 in var_12) {
      foreach(var_8 in var_0) {
        if(ispointinvolume(var_14.origin, var_8)) {
          var_16 = var_14 _id_AC58("on");
          var_2 = scripts\engine\utility::array_add(var_2, var_16);
        }
      }
    }
  }

  earthquake(0.3, 1, level.player.origin, 800);
  var_19 = getEntArray("life_support_floater", "targetname");

  if(var_19.size > 0) {
    foreach(var_21 in var_19) {
      var_21 thread _id_AC60();
    }
  }

  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_8 in var_0) {
    var_24 = 200;
    var_25 = 0;
    var_26 = 0;
    var_27 = undefined;
    var_28 = undefined;
    var_29 = 0;
    var_30 = getclosestpointonnavmesh(var_8.origin);
    var_31 = 0;
    var_32 = var_30;
    var_31 = var_24;

    while(var_29 < 9) {
      var_33 = [var_30, var_30 + (var_31, 0, 0), var_30 + (0, var_31, 0), var_30 - (var_31, 0, 0), var_30 - (0, var_31, 0), var_30 - (var_31, 0, 0) + (var_30 + (0, var_31, 0)), var_30 + (var_31, 0, 0) + (var_30 + (0, var_31, 0)), var_30 - (0, var_31, 0) + (var_30 + (var_31, 0, 0)), var_30 - (0, var_31, 0) + (var_30 - (var_31, 0, 0))];
      var_32 = var_33[var_29];

      if(ispointinvolume(var_32, var_8)) {
        physicsexplosionsphere(var_32, 351, 350, 0.1);
        var_31 = var_31 + var_24;
        wait 0.01;
      } else {
        var_29++;
        var_31 = var_24;
      }

      if(var_32 == var_30) {
        var_29++;
      }
    }
  }

  if(isDefined(var_1)) {
    scripts\engine\utility::flag_wait(var_1);
  } else {
    scripts\engine\utility::flag_wait("hack_life_support_cooling");
  }

  earthquake(0.2, 0.5, level.player.origin, 800);
  wait 1.0;
  scripts\engine\utility::array_thread(var_3, ::_id_AC57, "off");
  scripts\engine\utility::array_thread(var_2, ::_id_AC58, "off");
}

_id_AC57(var_0) {
  if(var_0 == "on") {
    thread _id_611F();
  } else {
    self notify("stop_emergency_lightstrobe");
    wait 0.05;
    self setlightintensity(0);
  }
}

_id_611F() {
  self endon("stop_emergency_lightstrobe");
  var_0 = 2;
  var_1 = 360 / var_0;
  var_2 = 0;
  var_3 = 55;
  var_4 = 500;

  for(;;) {
    self setlightintensity(0);
    self _meth_8300(12);
    self _meth_82FC((1, 1, 1));
    wait 1;
    var_5 = sin(var_2 * var_1) * 0.5 + 0.5;
    self setlightintensity(var_3 + (var_4 - var_3) * var_5);
    wait 0.05;
    var_2 = var_2 + 0.05;

    if(var_2 > var_0) {
      var_2 = var_2 - var_0;
    }

    wait 0.05;
    self setlightintensity(1000);
    self _meth_8300(300);
    wait 0.05;
  }
}

_id_AC58(var_0) {
  var_1 = self;

  if(var_0 == "on") {
    if(!isDefined(var_1.angles)) {
      var_1.angles = (0, 0, 0);
    }

    var_2 = anglestoup(var_1.angles);
    var_3 = vectortoangles(var_2);
    var_4 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_3 + (90, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("airlock_steam"), var_4, "tag_origin");
    return var_4;
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("airlock_steam"), var_1, "tag_origin");
    var_1 delete();
  }
}

_id_AC60() {
  var_0 = self;
  var_1 = getEnt(var_0.target, "targetname");

  if(isDefined(var_1)) {
    var_1 linkTo(var_0);
  }

  var_2 = 8;
  var_3 = 12;
  var_4 = var_0._id_EDE7;
  var_5 = randomfloatrange(3, 4);
  var_6 = var_4;

  if(!isDefined(var_0._id_C393)) {
    var_0._id_C393 = var_0.angles[1];
  }

  if(var_4 > 0) {
    var_4 = var_0._id_EDE7 / 2;
    var_4 = randomfloatrange(var_4 / 2, var_4);

    if(randomintrange(0, 100) >= 50) {
      var_4 = var_4 * -1;
    }

    if(var_0._id_C393 / 2 + var_4 > abs(var_0.angles[1])) {
      var_4 = 0;
    }

    var_6 = var_5 + randomfloatrange(4, 8);
  }

  if(var_0.script_noteworthy == "top") {
    var_2 = var_3;
    var_3 = var_2 + 12;
  }

  var_7 = randomfloatrange(var_2, var_3);
  var_0 movez(var_7, var_5, var_5 / 4, var_5 * 3 / 4);

  if(var_6 > 0) {
    var_0 rotateYaw(var_4, var_6, var_5 / 4, var_5 * 3 / 4);
  }

  scripts\engine\utility::flag_wait("hack_life_support_cooling");

  if(var_0.script_noteworthy == "top") {
    var_0 movez(var_7 * -1, var_5 / 12);
  } else {
    var_0 movez(var_7 * -1, var_5 / 13);
  }
}

_id_557E() {
  if(!isDefined(level._id_FD26)) {
    return 0;
  }
}

_id_5579() {
  var_0 = undefined;
  var_1 = getaiunittypearray("axis", "c6");
  thread _id_557A();
  visionsetnaked("ship_assault_robotics", 0.5);
  thread _id_557B();
  thread _id_557E();

  foreach(var_0 in var_1) {
    var_0 thread _id_5577();
  }

  level.player scripts\sp\utility::_id_65E1("player_zero_attacker_accuracy");
  level.player.attackeraccuracy = 0.2;
  scripts\engine\utility::flag_wait("hack_robotics_cooling");
  visionsetnaked("", 0.5);
  wait 0.5;
  level.player.attackeraccuracy = level.player.gs._id_CF81;
  level.player scripts\sp\utility::_id_65DD("player_zero_attacker_accuracy");
}

_id_557A() {
  level endon("hack_robotics_cooling");
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = level._id_4BA7;
  var_5 = scripts\engine\utility::array_combine(var_4.path["forward"], var_4.path["backward"]);
  var_6 = scripts\engine\utility::array_add(var_5, var_4);
  var_3 = getEntArray("flicker_hack_lights", "targetname");

  if(var_3.size > 0) {
    foreach(var_8 in var_3) {
      foreach(var_10 in var_6) {
        if(ispointinvolume(var_8.origin, var_10)) {
          var_8 thread _id_AC24();
        }
      }
    }
  }

  var_13 = getEntArray("emergency_hack_lights", "targetname");

  if(var_13.size > 0) {
    foreach(var_15 in var_13) {
      foreach(var_10 in var_6) {
        if(ispointinvolume(var_15.origin, var_10)) {
          var_15 setlightintensity(800);
        }
      }
    }
  }

  var_19 = scripts\engine\utility::array_combine(var_3, var_13);
  var_19 thread _id_E5BB(var_6);
  var_20 = scripts\engine\utility::getStructArray("sa_beacon_fx_struct", "targetname");

  if(var_20.size > 0) {
    foreach(var_22 in var_20) {
      foreach(var_10 in var_6) {
        if(ispointinvolume(var_22.origin, var_10)) {
          var_24 = anglestoup(var_22.angles);
          var_25 = vectortoangles(var_24);
          var_26 = scripts\engine\utility::spawn_tag_origin(var_22.origin, var_25 + (0, 0, 90));
          var_1 = scripts\engine\utility::array_add(var_1, var_26);
        }
      }
    }
  }

  var_29 = scripts\engine\utility::getStructArray("sa_vent_fx_struct", "targetname");

  if(var_29.size > 0) {
    foreach(var_31 in var_29) {
      foreach(var_10 in var_6) {
        if(ispointinvolume(var_31.origin, var_10)) {
          var_24 = anglestoup(var_31.angles);
          var_25 = vectortoangles(var_24);
          var_33 = scripts\engine\utility::spawn_tag_origin(var_31.origin, var_25 + (0, 0, 90));
          var_0 = scripts\engine\utility::array_add(var_0, var_33);
        }
      }
    }
  }

  var_36 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_10 in var_6) {
    var_38 = 200;
    var_39 = 0;
    var_40 = 0;
    var_41 = undefined;
    var_42 = undefined;
    var_43 = 0;
    var_44 = getclosestpointonnavmesh(var_10.origin);
    var_45 = 0;
    var_46 = var_44;
    var_45 = var_38;

    while(var_43 < 9) {
      var_47 = [var_44, var_44 + (var_45, 0, 0), var_44 + (0, var_45, 0), var_44 - (var_45, 0, 0), var_44 - (0, var_45, 0), var_44 - (var_45, 0, 0) + (var_44 + (0, var_45, 0)), var_44 + (var_45, 0, 0) + (var_44 + (0, var_45, 0)), var_44 - (0, var_45, 0) + (var_44 + (var_45, 0, 0)), var_44 - (0, var_45, 0) + (var_44 - (var_45, 0, 0))];
      var_46 = var_47[var_43];

      if(ispointinvolume(var_46, var_10)) {
        var_48 = scripts\engine\utility::spawn_tag_origin(var_46);
        var_49 = randomint(360);
        var_48.angles = var_48.angles + (0, 0, var_49);
        var_2 = scripts\engine\utility::array_add(var_2, var_48);
        var_45 = var_45 + var_38;
        wait 0.01;
      } else {
        var_43++;
        var_45 = var_38;
      }

      if(var_46 == var_44) {
        var_43++;
      }
    }
  }

  var_51 = scripts\engine\utility::array_combine(var_36, var_2);
  var_51 = scripts\engine\utility::array_randomize(var_51);
  thread _id_5578(var_51);

  foreach(var_53 in var_51) {
    wait(randomfloatrange(0.05, 0.25));
    playFXOnTag(scripts\engine\utility::getfx("robotics_shocks"), var_53, "tag_origin");
  }
}

_id_5578(var_0) {
  scripts\engine\utility::flag_wait("hack_robotics_cooling");
  scripts\sp\utility::_id_228A(var_0);
}

_id_5577() {
  var_0 = self;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_0 _meth_83A1();
  var_1 delete();
}

_id_557B() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 show();
  var_0 _meth_81E2(level.player, "tag_ads", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(scripts\engine\utility::getfx("flashlight_player"), var_0, "tag_origin");
  scripts\engine\utility::flag_wait("hack_robotics_cooling");
  wait 3;
  stopFXOnTag(scripts\engine\utility::getfx("flashlight_player"), var_0, "tag_origin");
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_AC24() {
  self endon("stop_hack_flicker");

  for(;;) {
    _id_F45B(randomfloatrange(30, 50), (0.996, 0.933, 0.839));
    wait(randomfloatrange(0.1, 1) / 20);
    _id_F45B(0, (0, 0, 0));
    wait(randomfloatrange(0.01, 0.75) / 1);
  }
}

_id_E5BB(var_0) {
  var_1 = self;
  scripts\engine\utility::flag_wait("hack_robotics_cooling");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_0) {
        if(ispointinvolume(var_3.origin, var_5)) {
          wait(randomfloatrange(0.25, 0.75));
          var_3 notify("stop_hack_flicker");
          var_3 setlightintensity(0);
        }
      }
    }
  }
}

_id_F45B(var_0, var_1) {
  self setlightintensity(var_0);
  self _meth_82FC(var_1);
}

_id_6230() {}

_id_7777() {
  level notify(self._id_4D94._id_4C64);
}

_id_FBB5() {
  var_0 = spawn("script_origin", level.player.origin + (randomfloatrange(300, 700), randomfloatrange(300, 700), 0));
  var_1 = spawn("script_origin", level.player.origin + (randomfloatrange(-1000, -500), randomfloatrange(-1000, -500), 0));
  wait 1.2;
  var_0 playLoopSound("sa_ability_lifesupport_alarm_lp");
  var_1 playLoopSound("sa_ability_lifesupport_alarm_lp");
  scripts\engine\utility::flag_wait("hack_life_support_cooling");
  var_0 stoploopsound();
  var_0 delete();
  var_1 stoploopsound();
  var_1 delete();
}