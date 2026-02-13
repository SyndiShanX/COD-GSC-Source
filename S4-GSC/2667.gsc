/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2667.gsc
*************************************************/

_id_D4A3() {}

_id_FA61() {}

_id_D5A1() {
  thread _id_BF18();
}

_id_BF18() {
  self endon("unset_healer");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  self._id_EF87 = [];

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 = scripts\mp\utility\player::_id_6C5F(self.origin, 350, self.team, self);

      foreach(var_2 in var_0) {
        if(var_2 scripts\mp\utility\perk::_hasperk("specialty_healer")) {
          continue;
        }
        if(self.team == var_2.team && var_2 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_2._id_762A)) {
          var_3 = var_2 getentitynumber();

          if(self._id_EF87.size == 0) {
            scripts\mp\hud_message::_id_DCC6("healing_players");
          }

          var_2._id_762A = self;
          self._id_EF87[var_3] = 1;
          var_2 scripts\mp\utility\perk::_id_6FC2("specialty_regenfaster");
          var_2 scripts\mp\utility\perk::_id_6FC2("specialty_regen_delay_reduced");
          var_2 scripts\mp\hud_message::_id_DCC6("in_healing_range");
          _id_6FA2(var_2);
          thread _id_762C(var_2);
          thread _id_762B(var_2);
        }
      }
    }

    wait 0.3;
  }
}

_id_762C(var_0) {
  level endon("game_ended");
  self endon("unset_healer");
  self endon("death_or_disconnect");
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_1 = 400;

    if(distancesquared(self.origin, var_0.origin) > var_1 * var_1 || var_0.team != self.team) {
      var_0 notify("out_of_healing_range");
      return;
    }

    var_2 = var_0 getentitynumber();

    if(var_0.health < var_0.maxhealth && var_0._id_7626.alpha == var_0._id_7626._id_98B7) {
      var_0 thread _id_7628(var_0._id_7626, self, var_0._id_7626._id_7928);
    } else if(var_0.health == var_0.maxhealth) {
      var_0 thread _id_7628(var_0._id_7626, self, var_0._id_7626._id_98B7);
    }

    wait 0.1;
  }
}

_id_762B(var_0) {
  level endon("game_ended");
  var_1 = var_0 getentitynumber();
  scripts\engine\utility::_id_10888(self, "unset_healer", self, "death_or_disconnect", var_0, "death_or_disconnect", var_0, "out_of_healing_range");

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\perk::removeperk("specialty_regenfaster");
    var_0 scripts\mp\utility\perk::removeperk("specialty_regen_delay_reduced");
    var_0._id_762A = undefined;
    var_0 scripts\mp\hud_message::_id_DCC6("out_of_healing_range");
  }

  if(isDefined(self)) {
    self._id_EF87[var_1] = undefined;

    if(self._id_EF87.size == 0) {
      scripts\mp\hud_message::_id_DCC6("no_healing_players");
    }
  }
}

_id_FAA4() {
  self notify("unset_healer");
}

_id_6FA2(var_0) {
  var_1 = newclienthudelem(var_0);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("overlay_healer", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1._id_98B7 = 0;
  var_1._id_7928 = 0.75;
  var_0._id_7626 = var_1;
  var_0 thread _id_7628(var_1, self, var_1._id_98B7);
  var_0 thread _id_7627(var_1, self);
}

_id_7628(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("out_of_healing_range");
  var_1 endon("death_or_disconnect");
  var_1 endon("unset_healer");
  var_0 fadeovertime(0.5);
  var_0.alpha = var_2;
}

_id_7627(var_0, var_1) {
  scripts\engine\utility::_id_10888(level, "game_ended", var_1, "unset_healer", var_1, "death_or_disconnect", self, "death_or_disconnect", self, "out_of_healing_range");

  if(isDefined(var_0)) {
    var_0 fadeovertime(1);
    var_0.alpha = 0;
    wait 1;
    var_0 destroy();
  }
}

_id_D709() {}

_id_FB13() {}

_id_D703() {}

_id_FB0E() {}

_id_D6EF() {}

_id_FB07() {}

_id_D4A5() {
  _id_07CA::_id_FBFC(self, 1);
}

_id_FA63() {
  _id_07CA::_id_FBFC(self, 0);
}

_id_D700() {}

_id_FB0C() {}

_id_D50E() {}

_id_FA7D() {}

_id_D5BC() {}

_id_FAAB() {}

_id_D5AB() {}

_id_FAA7() {}

_id_D6E6() {}

_id_FB04() {}

_id_D604() {}

_id_FAC1() {}

_id_D623() {
  thread _id_A94D();
}

_id_A94D() {
  level endon("game_ended");
  self endon("unset_offhand_provider");
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = scripts\mp\utility\player::_id_6C5F(self.origin, 144, self.team, self);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2._id_A9E3)) {
        var_2._id_A9E3 = [];
      }

      if(var_2 _id_558C("primary") == 0 && var_2 _id_558C("secondary") == 0) {
        continue;
      }
      if(!isDefined(var_2._id_A9E3[self getentitynumber()]) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_2._id_A9E3[self getentitynumber()] = 1;
        var_3 = var_2 _id_C195();

        for(var_4 = 0; var_4 < var_3["primary"]; var_4++) {
          var_2 thread _id_A9E2(self.name, var_2 scripts\mp\equipment::_id_69A4("primary"));
        }

        for(var_4 = 0; var_4 < var_3["secondary"]; var_4++) {
          var_2 thread _id_A9E2(self.name, var_2 scripts\mp\equipment::_id_69A4("secondary"));
        }

        thread _id_A9E0(var_2);
        var_2 playsoundtoplayer("scavenger_pack_pickup", var_2);
      }
    }

    wait 0.1;
  }
}

_id_A9E0(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = self getentitynumber();
  scripts\engine\utility::_id_1088C(self, "disconnect", var_0, "death");
  var_0._id_A9E3[var_1] = undefined;
}

_id_FAC4() {
  self notify("unset_offhand_provider");
}

_id_C195() {
  var_0 = [];
  var_0["primary"] = _id_558C("primary", 1);
  var_0["secondary"] = _id_558C("secondary", 1);
  return var_0;
}

_id_558C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = scripts\mp\equipment::_id_69A4(var_0);
  var_3 = _id_6A16(var_0);
  var_4 = scripts\mp\equipment::_id_6A0F(var_2);

  if(var_1 && var_3 - var_4 > 0) {
    scripts\mp\equipment::incrementequipmentammo(var_2, var_3 - var_4);
  }

  return var_3 - var_4;
}

_id_6A16(var_0) {
  var_1 = scripts\mp\equipment::_id_69A4(var_0);
  var_2 = scripts\mp\equipment::_id_6A16(var_1);

  if(var_0 == "primary" && scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_2 = scripts\mp\equipment::_id_6A12(var_1);
  }

  return var_2;
}

_id_A9E2(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self._id_A303)) {
    self._id_A303 = [];
  }

  var_2 = self._id_A303.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(var_3 < 2) {
      thread _id_A241(self._id_A303[var_3]);
      continue;
    }

    var_4 = self._id_A303[var_3];
    self._id_A303[var_3] = undefined;
    var_4 notify("delete_icon_elem");
  }

  var_5 = 620;
  var_6 = 360;
  var_7 = 352.0;
  var_8 = 264.0;
  var_9 = newclienthudelem(self);
  var_9.x = var_7;
  var_9.y = var_8;
  var_9.alignx = "right";
  var_9.aligny = "top";
  var_9.sort = 2;
  var_9.alpha = 0;
  var_10 = scripts\mp\equipment::_id_6A17(var_1);
  var_9 setshader(var_10._id_7D40, 25, 25);
  var_9 fadeovertime(0.15);
  var_9 moveovertime(0.35);
  var_9.alpha = 1;
  var_9.x = var_5;
  var_9.y = var_6;
  self._id_A303 = scripts\engine\utility::_id_1BB3(self._id_A303, var_9, 0);
  var_9 endon("delete_icon_elem");
  thread _id_A9E1(var_9);
  var_9._id_8751 = 1;
  wait 0.35;
  var_9._id_8751 = 0;
  wait 3;
  var_9 fadeovertime(0.5);
  var_9.alpha = 0;
  wait 0.5;
  var_9 notify("delete_icon_elem");
}

_id_A9E1(var_0) {
  level endon("game_ended");
  scripts\engine\utility::_id_10888(self, "death_or_disconnect", var_0, "delete_icon_elem");

  if(isDefined(self)) {
    self._id_A303 = scripts\engine\utility::array_remove(self._id_A303, var_0);
  }

  var_0 destroy();
}

_id_A241(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 endon("delete_icon_elem");

  if(!istrue(var_0._id_8751)) {
    var_0 moveovertime(0.35);
  }

  var_0.y = var_0.y - 25;
  wait 0.35;
}

_id_D8D6() {
  if(self._id_6DF0) {
    self waittill("giveLoadout");
  }

  var_0 = scripts\mp\equipment::_id_69A4("primary");

  if(isDefined(var_0) && var_0 != "none") {
    var_1 = istrue(scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) + 1;
    scripts\mp\equipment::incrementequipmentammo(var_0, var_1);
  }
}

_id_D8D8() {
  self endon("death_or_disconnect");
  self endon("unsetVanDemolition");
  level endon("game_ended");

  for(;;) {
    self waittill("offhand_fired", var_0);
    thread _id_A103();
  }
}

_id_A103() {
  self notify("setDemolitionMoveBoost");
  self endon("death_or_disconnect");
  self endon("unsetVanDemolition");
  self endon("setDemolitionMoveBoost");
  level endon("game_ended");

  if(!istrue(self._id_47BD)) {
    scripts\mp\utility\perk::_id_6FC2("specialty_lightweight");
    self._id_47BD = 1;
  }

  wait 5.0;
  scripts\mp\utility\perk::removeperk("specialty_lightweight");
  self._id_47BD = 0;
  self._id_AFD2 = 0;
}

_id_D8D7() {
  self endon("death_or_disconnect");
  self endon("unsetVanDemolition");
  level endon("game_ended");

  for(;;) {
    self _meth_832B(1.25);
    self waittill("grenade_pullback", var_0);
    var_1 = var_0.basename;

    if(var_1 == "airdrop_marker_mp" || var_1 == "deployable_vest_marker_mp" || var_1 == "deployable_weapon_crate_marker_mp") {
      self _meth_832B(1);
    }

    self waittill("grenade_fire", var_2, var_0);
  }
}

_id_FB21() {
  self notify("unsetVanDemolition");

  if(istrue(self._id_47BC)) {
    self _meth_832A(1.0);
  }
}

_id_D6B7() {
  thread monitormovement_ghost();
}

monitormovement_ghost() {
  self endon("remove_gpsjammer");
  self endon("unsetScout");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = getdvarint("#x3876b22d6eddd09e8", 190);
  var_1 = 0;
  self.perkghoston = 0;

  for(;;) {
    var_2 = self._id_EB09;
    var_3 = isDefined(var_2) && isDefined(var_2._id_E76B._id_C189) && isDefined(var_2._id_FEA3);

    if(var_3 && var_2._id_E76B._id_C189 == "super_deadsilence" && var_2._id_FEA3 > 0) {
      if(!self.perkghoston) {
        self.perkghoston = 1;
        var_1 = 0;
        self _meth_854B(1);
      }

      if(var_1 && self.perkghoston) {
        self notify("enable_ghost");
        var_1 = 0;
      }

      waitframe();
      continue;
    }

    var_4 = self getvelocity();
    var_5 = abs(var_4[0]) + abs(var_4[1]) + abs(var_4[2]);

    if(var_5 >= var_0 && !self.perkghoston && !self _meth_846A()) {
      self.perkghoston = 1;
      var_1 = 0;
      self _meth_854B(1);
    } else if(var_5 >= var_0 && var_1 && self.perkghoston) {
      self notify("enable_ghost");
      var_1 = 0;
    } else if(var_5 < var_0 && self.perkghoston && !var_1) {
      thread perkfalloff_ghost();
      var_1 = 1;
    }

    waitframe();
  }
}

perkfalloff_ghost() {
  self endon("enable_ghost");
  self endon("disconnect");
  wait(getdvarfloat("#x3f032d6265e188049", 2.0));

  if(!isDefined(self)) {
    return;
  }
  self.perkghoston = 0;
  self _meth_854B(0);
}

_id_19CD() {
  scripts\mp\utility\perk::_id_6FC2("specialty_quieter");
  scripts\mp\utility\perk::_id_6FC2("specialty_no_battle_chatter");
  _id_07C4::_id_7B6B("scout");
  self.unmarkedactive = 1;
  thread _id_A13C();
}

_id_19CE() {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self _meth_8577("zombiedefault");
  var_0 = 5.0;
  var_1 = var_0 - 2.0;
  scripts\engine\utility::_id_108AE(var_1, "super_use_finished");
  self _meth_8577("default_2seconds");
}

_id_A13C() {
  self notify("setDeadSilenceFromPerk");
  self endon("setDeadSilenceFromPerk");
  scripts\engine\utility::_id_108A8(5.0, "death_or_disconnect", "game_ended");
  self.unmarkedactive = 0;

  if(isDefined(self._id_EB09) && isDefined(self._id_EB09._id_E76B) && isDefined(self._id_EB09._id_E76B._id_C189) && self._id_EB09._id_E76B._id_C189 == "super_deadsilence") {
    if(!isDefined(self._id_EB09._id_FEA3) || self._id_EB09._id_FEA3 == 0 && !scripts\mp\utility\perk::_hasperk("specialty_ninja")) {
      scripts\mp\utility\perk::removeperk("specialty_quieter");
      scripts\mp\utility\perk::removeperk("specialty_no_battle_chatter");
    }
  } else if(!scripts\mp\utility\perk::_hasperk("specialty_ninja")) {
    scripts\mp\utility\perk::removeperk("specialty_quieter");
    scripts\mp\utility\perk::removeperk("specialty_no_battle_chatter");
  }
}

_id_A112() {
  self endon("remove_gpsjammer");
  self endon("unsetScout");
  self endon("death_or_disconnect");
  self._id_AFCE = 0;

  for(;;) {
    var_0 = self getvelocity();

    if(var_0 == (0, 0, 0) && self._id_AFCE == 0) {
      self._id_AFCE = 1;
      self _meth_854B(0);
    } else if(var_0 != (0, 0, 0) && self._id_AFCE) {
      self _meth_854B(1);
      self._id_AFCE = 0;
    }

    waitframe();
  }
}

_id_FAF3() {
  self notify("unsetScout");
}

_id_D629() {}

_id_7DD3() {
  self endon("death_or_disconnect");
  self endon("unsetOperator");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_change");
    thread _id_A124();
  }
}

_id_A124() {
  self notify("setOperatorSMGPerk");
  self endon("setOperatorSMGPerk");
  level endon("game_ended");
  scripts\engine\utility::_id_108A8(3.0, "death_or_disconnect", "unsetOperator");

  if(scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
    scripts\mp\utility\perk::removeperk("specialty_lightweight");
  }
}

_id_D55B() {
  self endon("death_or_disconnect");
  self endon("unsetOperator");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_change");
    scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
    self waittill("reload");
    waitframe();
    scripts\mp\utility\perk::removeperk("specialty_fastreload");
  }
}

_id_C319() {
  self endon("death_or_disconnect");
  self endon("unsetOperator");
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(var_0 != self) {
      continue;
    }
    if(!istrue(self._id_AC3F)) {
      waitframe();
      self._id_AC3F = 1;
    }

    foreach(var_2 in self._id_034A) {
      var_3 = var_2;
      var_4 = _func_0375();

      if(scripts\mp\utility\weapon::_id_88F9(var_3) || scripts\mp\utility\weapon::_id_8A7D(var_3) || scripts\mp\utility\weapon::_id_88F6(var_3) || scripts\mp\utility\weapon::_id_8876(var_3) || _id_080B::_id_8A09(var_3.basename) || scripts\mp\utility\weapon::_id_8A38(var_3.basename) || !_id_0A72::_id_E92C(var_3) || var_3.basename == "s4_me_fists_mp") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");
        }

        return 0;
      }

      var_5 = _id_0A72::_id_E923();

      if(!istrue(var_5)) {
        return 0;
      }

      if(self _meth_8543(var_3)) {
        var_4 = var_3;
        var_3 = var_3 _meth_8628();
      } else
        var_4 = var_3 getaltweapon();

      var_6 = [];
      var_7 = 0;
      var_8 = 0;

      if(!isnullweapon(var_4)) {
        var_6[var_6.size] = var_4;
      }

      var_6[var_6.size] = var_3;

      foreach(var_10 in var_6) {
        var_11 = 0;

        if(var_10 _meth_8624("akimbo", 1)) {
          var_11 = 1;
        }

        if(issameweapon(var_10, var_3, 0)) {
          var_12 = scripts\mp\weapons::_id_68BB(var_10);
          var_13 = var_12 * 1;

          if(var_11) {
            var_13 = var_13 * 2;
          }

          thread _id_0A72::_id_E92A(self, var_10, var_13);
        }
      }

      thread scripts\mp\hud_message::showsplash("stopping_power_loaded");

      if(var_8 > 0) {
        self setweaponammostock(var_3, var_7 + var_8);
      }
    }
  }
}

_id_FAC6() {
  self notify("unsetOperator");
}

_id_D706() {}

_id_FB11() {
  self notify("unsetTactician");
}

_id_D705() {
  thread _id_A13F();
}

_id_FB10() {
  self notify("unsetTacticalOutline");
}

_id_BF13(var_0) {
  self endon("gasExit");
  var_0 endon("death_or_disconnect");
  var_0 endon("unsetTactician");
  level endon("game_ended");

  for(;;) {
    _func_0251(self.origin, var_0, 10);
    wait 2.0;
  }
}

_id_ACF0(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.owner = self;
  var_2._id_8747 = 1;
  var_2.attacker = var_0;
  var_2._id_ACE5 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "outline_depth_orange", "level_script");
  _id_09B5::_id_9B40();
  var_2 thread _id_ED32("gas", var_1);
}

_id_ED32(var_0, var_1) {
  _id_ED2F(var_0, var_1);
  thread _id_ED2E();
}

_id_ED2F(var_0, var_1) {
  self endon("death");
  self.owner endon("death");
  self.attacker endon("death");
  self.owner endon("unsetTactician");
  level endon("game_ended");
  var_1 endon("death");
  var_2 = undefined;

  for(;;) {
    if(var_0 == "gas") {
      self.owner waittill("gasExit", var_2);
    } else if(var_0 == "smoke") {
      self.owner waittill("smoke_exited", var_2);
    }

    if(isDefined(var_2) && var_2 == self.attacker) {
      return;
    }
  }
}

_id_ED2E() {
  self notify("death");
  self._id_8747 = 0;
  var_0 = self._id_ACE5;

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self.attacker;
  scripts\mp\utility\outline::outlinedisable(var_0, self.owner);
}

_id_ED35(var_0) {
  var_1 = spawnStruct();
  var_1.owner = self;
  var_1._id_8747 = 1;
  var_1.attacker = var_0;
  var_1._id_ACE5 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "outline_depth_orange", "level_script");
  _id_09B5::_id_9B40();
  wait 3;
  var_1 _id_ED2E();
}

_id_ED34(var_0, var_1) {
  if(self != var_1) {
    thread _id_ED35(var_1);
  }
}

_id_ED33() {
  scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
  wait 6.0;
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
}

_id_A13F() {
  self endon("death_or_disconnect");
  self endon("unsetTacticalOutline");
  level endon("game_ended");

  for(;;) {
    self waittill("smoke_grenade_explode", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    wait 1;
    thread _id_DE36(var_0, self);
  }
}

_id_DE36(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 8.25;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = spawn("trigger_radius", var_0 + (0, 0, int(-57.75 * var_3)), 0, int(250 * var_3), int(175 * var_3));
  var_4 _id_078E::_id_C2B5(1, ::_id_397C);
  var_4 endon("death");
  var_4.owner = var_1;
  var_4.team = var_1.team;
  var_4._id_B7C0 = [];
  var_4 thread _id_DE49();
  var_4 thread _id_DE4A();
  wait(var_2);
  var_4 thread _id_DE39();
}

_id_397C() {
  thread _id_DE39();
}

_id_DE39() {
  self notify("death");

  foreach(var_1 in self._id_B7C0) {
    if(!isDefined(var_1)) {
      continue;
    }
    self._id_B7C0[var_1 getentitynumber()] = undefined;
    var_1 thread _id_DE43(self getentitynumber());
  }

  _id_078E::_id_4807();
  self delete();
}

_id_DE49() {
  self endon("death");
  self.owner endon("death_or_disconnect");
  self.owner endon("unset_tactician");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0 scripts\mp\utility\killstreak::_id_88DF()) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self._id_B7C0[var_0 getentitynumber()])) {
      continue;
    }
    if(level.teambased) {
      if(isDefined(self.owner)) {
        if(var_0 != self.owner && scripts\cp_mp\utility\player_utility::_id_B78C(var_0, self.owner)) {
          continue;
        }
      } else if(!scripts\mp\utility\player::_id_886C(self.team, var_0))
        continue;
    }

    self._id_B7C0[var_0 getentitynumber()] = var_0;
    var_0 thread _id_DE42(self);
  }
}

_id_DE42(var_0) {
  if(!isDefined(self._id_DE56)) {
    self._id_DE56 = [];
  }

  var_1 = var_0 getentitynumber();
  self._id_DE56[var_1] = var_0;
  var_2 = spawnStruct();
  var_2.owner = self;
  var_2._id_8747 = 1;
  var_2.attacker = var_0.owner;
  var_2._id_ACE5 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0.owner, "outline_depth_orange", "level_script");
  _id_09B5::_id_9B40();
  var_2 thread _id_ED32("smoke", var_0);
  return var_1;
}

_id_DE4A() {
  self endon("death");
  self.owner endon("death_or_disconnect");
  self.owner endon("unset_tactician");
  level endon("game_ended");

  for(;;) {
    foreach(var_2, var_1 in self._id_B7C0) {
      if(!isDefined(var_1)) {
        self._id_B7C0[var_2] = undefined;
        continue;
      }

      if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_1 istouching(self)) {
        continue;
      }
      self._id_B7C0[var_1 getentitynumber()] = undefined;
      var_1 thread _id_DE43(self getentitynumber(), self);
    }

    waitframe();
  }
}

_id_DE43(var_0, var_1) {
  if(!isDefined(self._id_DE56)) {
    return;
  }
  self._id_DE56[var_0] = undefined;

  if(self._id_DE56.size == 0) {
    self notify("smoke_exited", var_1.owner);
    self._id_ED30 = 0;
  }
}

_id_D697() {}

_id_FADD() {
  self notify("unsetReaper");
}

_id_D554() {
  self endon("death_or_disconnect");
  self endon("unset_extra_tactical");
  level endon("game_ended");

  if(self._id_6DF0) {
    self waittill("giveLoadout");
  }

  var_0 = scripts\mp\equipment::_id_69A4("secondary");

  if(isDefined(var_0) && var_0 != "none") {
    var_1 = 1;
    scripts\mp\equipment::incrementequipmentammo(var_0, var_1);
  }
}

_id_FA90() {
  self notify("unset_extra_tactical");
}

_id_D4D2() {}

_id_FA6A() {
  self notify("unsetClandestine");
}

_id_D696() {
  self endon("disconnect");
  self endon("stop_radar_ping_on_spawn");
  level endon("game_ended");
  scripts\engine\utility::_id_10888(self, "spawned_player", level, "prematch_over");
  _func_0251(self.origin, self, 1300);
}

_id_FADC() {
  self notify("stop_radar_ping_on_spawn");
}

_id_BF12(var_0) {
  _func_0251(var_0.origin, self, 10);
}

_id_ACF7(var_0) {
  var_1 = "suppression_overlay";
  var_2 = spawnStruct();
  var_2.owner = var_0;
  var_2.attacker = self;
  var_2._id_ACE5 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self, var_1, "level_script");
  var_2.owner scripts\mp\utility\outline::_id_0C2E(var_1, 0);
  var_2 thread _id_FC60();
}

_id_FC60() {
  self endon("death");
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.attacker endon("death_or_disconnect");
  self.attacker endon("joined_team");
  self.attacker endon("joined_spectators");
  level endon("game_ended");
  thread _id_10AE3();
  var_0 = getdvarint("#x3a185d98da1b18003") / 1000;
  var_1 = getdvarint("#x34978605bd9b30ca4", var_0);
  self.owner _meth_8804(1);
  var_2 = gettime() / 1000;
  var_3 = 0;

  while(var_3 < var_1) {
    waitframe();
    var_4 = gettime() / 1000 - var_2;
    var_2 = gettime() / 1000;
    var_3 = var_3 + var_4;
    var_5 = var_3 / var_1;
    var_6 = (1 - var_5) * (1 - var_5);
    self.owner _meth_8804(var_6);
  }

  thread _id_393D();
}

_id_10AE3() {
  self endon("death");
  _id_10AE2();
  thread _id_393D();
}

_id_10AE2() {
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.attacker endon("death_or_disconnect");
  self.attacker endon("joined_team");
  self.attacker endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

_id_393D() {
  self notify("death");

  if(!isDefined(self._id_ACE5)) {
    return;
  }
  scripts\mp\utility\outline::outlinedisable(self._id_ACE5, self.owner);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\utility\outline::_id_0C2D();
  }
}

_id_84E8(var_0) {
  if(!scripts\mp\utility\perk::_hasperk("specialty_intuition")) {
    return 0;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var_0.team == self.team && scripts\mp\utility\game::getgametype() != "dm") {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "arena_evo" && !scripts\engine\utility::is_equal(var_0.team, scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"]))) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 160000) {
    return 0;
  }

  var_1 = abs(self.origin[2] - var_0.origin[2]);

  if(var_1 > 50) {
    return 0;
  }

  var_2 = self getentitynumber();

  if(!isDefined(var_0._id_84E5)) {
    var_0 thread _id_84E6(self, var_2);
    var_0._id_84E5 = [];
    var_0._id_84E5[var_2] = gettime();
    return 0;
  } else if(!isDefined(var_0._id_84E5[var_2])) {
    var_0 thread _id_84E6(self, var_2);
    var_0._id_84E5[var_2] = gettime();
    return 0;
  }

  if(var_0._id_84E5[var_2] + 1000 > gettime()) {
    return 0;
  }

  var_3 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_3) && isDefined(var_3._id_1031E)) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(var_0);

    if(var_4) {
      if(var_3._id_1031E != "light_tank" && var_3._id_1031E != "apc_russian" && var_3._id_1031E != "s4_tank") {
        return 0;
      }
    } else if(var_3._id_1031E == "apc_russian")
      return 0;
  }

  if(var_0 scripts\mp\utility\player::_id_8ACE()) {
    var_5 = var_0 scripts\mp\utility\player::_id_6CEC();

    if(var_5 == "ball_turret_gunner" || var_5 == "radar_drone_recon" || var_5 == "chopper_gunner" || var_5 == "cruise_predator") {
      return 0;
    }
  }

  return 1;
}

_id_84E6(var_0, var_1) {
  for(;;) {
    if(!isDefined(var_1)) {
      return;
    } else if(!isDefined(var_0) || !isDefined(self) || !isalive(var_0) || !isalive(self) || !var_0 scripts\mp\utility\perk::_hasperk("specialty_intuition")) {
      self._id_84E5[var_1] = undefined;
      return;
    } else if(distancesquared(var_0.origin, self.origin) > 160000) {
      self._id_84E5[var_1] = undefined;
      return;
    }

    waitframe();
  }
}

_id_84EA() {
  var_0 = scripts\engine\trace::_id_3EF6(1);
  var_1 = 0;
  var_2 = 0;
  var_3 = _func_028F();
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_21, var_7 in level._id_84E7) {
    if(!isDefined(var_7)) {
      level._id_84E7[var_21] = undefined;
      break;
    }

    var_8 = 0;
    var_9 = 0;

    if(!isbot(var_7)) {
      if(!var_7 scripts\mp\utility\perk::_hasperk("specialty_intuition")) {
        continue;
      }
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      var_10 = var_7 scripts\mp\utility\player::_id_6D7F();
      var_11 = scripts\mp\utility\player::_id_6C5F(var_7.origin, 400, scripts\mp\utility\game::_id_6BE2(var_7.team)[0], var_7);

      foreach(var_13 in var_11) {
        if(var_2 >= 25) {
          var_2 = 0;
          waitframe();
        }

        if(!isDefined(var_7)) {
          level._id_84E7[var_21] = undefined;
          break;
        }

        if(!var_7 _id_84E8(var_13)) {
          continue;
        }
        var_2++;
        var_14 = var_7 getvieworigin();
        var_15 = anglesToForward(var_7 getplayerangles());
        var_16 = var_13 scripts\mp\utility\player::_id_6D7F();

        if(var_13 _id_DD70(var_7, var_16, var_14, var_15)) {
          var_17 = var_7 getEye();
          var_18 = _id_49CB(var_17, var_7, var_13.origin + (0, 0, 50));

          if(var_18) {
            continue;
          }
        }

        var_19 = var_7 _id_6AC9(var_13);
        var_8 = var_8 | var_19;
        var_4 = var_13 getvieworigin();
        var_5 = anglesToForward(var_13 getplayerangles());

        if(!var_7 _id_DD70(var_13, var_10, var_4, var_5)) {
          continue;
        }
        var_9 = var_9 | var_19;
      }
    }

    var_8 = var_8 &~var_9;
    var_7 _id_FC95(var_8);
    var_7 _id_FD2C(var_9);

    if(var_8 != 0 || var_9 != 0) {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_7, "intuition");
    }
  }
}

_id_84E9() {
  level._id_84E7 = [];

  for(;;) {
    waitframe();
    _id_84EA();
  }
}

_id_D5BE() {
  self._id_84EB = 0;
  self._id_84ED = 0;
  _id_FC95(0);
  var_0 = self getentitynumber();
  level._id_84E7[var_0] = self;
}

_id_FAAC() {
  thread _id_3947();
}

_id_3947() {
  self endon("disconnect");
  self._id_84EB = undefined;
  self._id_84ED = undefined;
  self._id_84EC = undefined;
  self notify("removeIntuition");
  var_0 = self getentitynumber();
  level._id_84E7[var_0] = undefined;
  waitframe();
  _id_FC95(0);
}

_id_49CB(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_2;
  var_5 = physics_createcontents(["physicscontents_ainosight"]);
  var_6 = _func_02C1(var_3, var_4, var_5, var_1, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var_6, 0.0, 1.0);
}

_id_D8D9() {}

_id_FB22() {}

setcoolheaded() {
  self _meth_8390("DogsDontAttack");
}

unsetcoolheaded() {
  self _meth_8390("DogsAttack");
}

_id_B002(var_0, var_1, var_2) {
  if(self._id_41F5 == "prone" || self._id_41F5 == "crouch" || self _meth_826F() >= 1.0) {
    var_0 = var_0 * 0.7;
  } else {
    var_0 = var_0 * 0.85;
  }

  if(!isvanguarddamagecapexempt(var_1, var_2)) {
    var_0 = min(var_0, 80);
  }

  var_3 = strtok(level.gametype, "_");
  var_4 = getdvarint("#x395eaf3392bf4a723", 0);

  if(var_3[0] == "hc" || var_4 || self.maxhealth == 30) {
    var_4 = 1;
  }

  if(var_4) {
    switch (var_1.basename) {
      case "s4_frag_gbr_n82_mp":
        var_0 = min(var_0, 20);
        break;
      default:
        break;
    }
  }

  var_5 = level._id_B6D2 * 0.5;
  scripts\mp\healthoverlay::_id_C17C(var_5);
  return int(var_0);
}

isvanguarddamagecapexempt(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.basename)) {
    return 0;
  }

  if(_id_0A8B::_id_8905(var_0, var_1)) {
    return 1;
  }

  switch (var_0.basename) {
    case "motorcycle_mp":
    case "open_jeep_mp":
    case "bomb_site_mp":
    case "s4_sticky_eng_n74_mp":
    case "s4_v2_mp":
    case "s4_firebombing_run_mp":
    case "s4_ks_ord_ger_mp":
    case "pac_sentry_turret_mp":
    case "s4_glidebomb_fromeo_mp":
    case "s4_tank_tur_mp":
    case "s4_tur_main_tank_mike4_mp":
    case "s4_tank_mp":
      return 1;
    default:
      return 0;
  }
}

perkvanguard_modifyfiredmg(var_0) {
  var_0 = var_0 * 0.7;
  return int(var_0);
}

_id_D4FC() {}

_id_FA7B() {}

perkdauntless_modifyburndmg(var_0) {
  if(isDefined(self._id_EA8D) && isDefined(self._id_EA8D._id_5562) && self._id_EA8D._id_5562 == "equip_thermite") {
    return var_0;
  }

  var_0 = 0;
  return var_0;
}

_id_D690() {
  self endon("death_or_disconnect");
  self endon("quick_unset");
  self notify("setquick_start");
  self endon("setquick_start");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10899("sprint_begin", "sprint_end", "weapon_change", "death");
    thread _id_72C4(var_0);
  }
}

_id_FAD9() {
  self notify("quick_unset");
  self setmovespeedscale(1);
}

_id_72C4(var_0) {
  if(var_0 == "sprint_begin") {
    if(self._id_90CB _meth_8624("gunperk_quick")) {
      self setmovespeedscale(1.04);
    }
  } else if(var_0 == "sprint_end" || var_0 == "death")
    self setmovespeedscale(1);
  else if(var_0 == "weapon_change") {
    waitframe();

    if(!self._id_90CB _meth_8624("gunperk_quick")) {
      self setmovespeedscale(1);
    } else {
      self setmovespeedscale(1.04);
    }
  }
}

_id_D4A4() {
  var_0 = 0;

  if(scripts\mp\utility\weapon::_id_8929(self._id_0133)) {
    self._id_A25F = self._id_A25F + 0.05;
    scripts\mp\weapons::_id_FCCC();
    scripts\mp\utility\perk::_id_6FC2("specialty_extendedmelee");
    var_0 = 1;
  }

  for(;;) {
    self waittill("weapon_change");
    waitframe();

    if(scripts\mp\utility\weapon::_id_8929(self._id_0133) && !var_0) {
      self._id_A25F = self._id_A25F + 0.05;
      scripts\mp\weapons::_id_FCCC();
      scripts\mp\utility\perk::_id_6FC2("specialty_extendedmelee");
    } else if(var_0 && !scripts\mp\utility\weapon::_id_8929(self._id_0133)) {
      self._id_A25F = self._id_A25F - 0.05;
      scripts\mp\weapons::_id_FCCC();

      if(!self._id_0133 _meth_8624("gunperk_reach")) {
        scripts\mp\utility\perk::removeperk("specialty_extendedmelee");
      }
    }

    if(scripts\mp\utility\weapon::_id_8929(self._id_0133)) {
      var_0 = 1;
      continue;
    }

    var_0 = 0;
  }
}

_id_FA62() {
  if(scripts\mp\utility\weapon::_id_8929(self._id_0133)) {
    self._id_A25F = self._id_A25F - 0.05;
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_FC95(var_0) {
  var_1 = self getentitynumber();

  if(!isDefined(level._id_84E7[var_1]) && var_0 != 0) {
    return;
  }
  self setclientomnvar("ui_edge_glow_secondary", var_0);
}

_id_6AC9(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectornormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  } else if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::_id_8909(self.origin, var_2, var_0.origin), 4, 1);
  } else if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::_id_8909(self.origin, var_2, var_0.origin), 128, 64);
  } else if(var_5 >= -0.707107) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::_id_8909(self.origin, var_2, var_0.origin), 32, 8);
  } else {
    return 16;
  }
}

_id_D631() {}

_id_FACC() {}

_id_D53A() {}

_id_FA86() {}

_id_D489() {
  if(!isPlayer(self)) {
    return;
  }
  _id_1F80();
  _id_1F81();
}

_id_1F81() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  self _meth_8024();
}

_id_FA54() {
  if(!isPlayer(self)) {
    return;
  }
  self notify("endAutoSpotAdsWatcher");
  self _meth_8024();
}

_id_1F80() {
  self endon("death_or_disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    waitframe();

    if(self _meth_81F4()) {
      self _meth_8024();
      continue;
    }

    var_1 = self playerads();

    if(var_1 < 1 && var_0) {
      var_0 = 0;
      self _meth_8024();
    }

    if(var_1 < 1 && !var_0) {
      continue;
    }
    if(var_1 == 1 && !var_0) {
      var_0 = 1;
      self _meth_8025();
    }
  }
}

_id_D6A2() {}

_id_FAE6() {}

_id_F237() {
  self._id_75A1 = undefined;
  scripts\mp\utility\perk::removeperk("specialty_regenfaster");
  self setclientdvar("#x37a9f48454563285", 0);
  self notify("timeOutRegenFaster");
}

_id_D58C() {
  self._id_D9D5 = 0.25;
}

_id_FAA2() {
  self._id_D9D5 = 0;
}

_id_D6C6() {
  thread _id_A13B();
}

_id_A13B() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_monitorSharpFocus");

  for(;;) {
    self waittill("update_perk_viewkick");
    _id_FD28();
  }
}

_id_FD28() {
  var_0 = self._id_0133;
  var_1 = undefined;
  var_2 = scripts\mp\utility\weapon::_id_10D87(var_0);

  if(var_2 == 4) {
    var_1 = 0.75;
  } else if(var_2 == 3) {
    var_1 = 0.1;
  } else if(var_2 == 2) {
    var_1 = 0.03;
  } else if(var_2 == 1) {
    var_1 = 0.15;
  } else {
    var_1 = 0.0;
  }

  scripts\mp\weapons::_id_FD7E(var_1);
}

_id_FAF7() {
  self notify("stop_monitorSharpFocus");
  scripts\mp\weapons::_id_FD7E(1.0);
}

_id_FC4E() {
  if(isagent(self)) {
    return;
  }
  var_0 = undefined;
  var_1 = scripts\mp\utility\weapon::_id_10D87(self._id_0133);

  if(var_1 == 4) {
    var_0 = 0.85;
  } else if(var_1 == 3) {
    var_0 = 0.2;
  } else if(var_1 == 2) {
    var_0 = 0.08;
  } else if(var_1 == 1) {
    var_0 = 0.25;
  } else {
    var_0 = 0.05;
  }

  if(issubstr(self._id_0133.basename, "s4_")) {
    var_0 = 1;
  }

  scripts\mp\weapons::_id_FD7E(var_0);
  self notify("update_perk_viewkick");
}

_id_D6C9() {
  thread _id_A13D();
}

_id_A13D() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_monitorSilentFocus");

  for(;;) {
    self waittill("update_perk_viewkick");
    _id_FD2B();
  }
}

_id_D57C() {
  self setclientdvar("#x3cd5a0f499e56b1f9", 1);
}

_id_FA9B() {
  self setclientdvar("#x3cd5a0f499e56b1f9", 0);
}

_id_FD2B() {
  var_0 = self._id_0133;
  var_1 = undefined;
  var_2 = scripts\mp\utility\weapon::_id_10D87(var_0);

  if(var_2 == 4) {
    var_1 = 0.75;
  } else if(var_2 == 3) {
    var_1 = 0.1;
  } else if(var_2 == 2) {
    var_1 = 0.03;
  } else if(var_2 == 1) {
    var_1 = 0.15;
  } else {
    var_1 = 0.0;
  }

  scripts\mp\weapons::_id_FD7E(var_1);
}

_id_FAF9() {
  self notify("stop_monitorSilentFocus");
  scripts\mp\weapons::_id_FD7E(1.0);
}

_id_D725() {
  thread _id_A0F4();
}

_id_A0F4() {
  self endon("tight_grip_unset");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(getdvarint("#x3d1a1278cc3494b61", 1000) >= 1000) {
    setDvar("#x3d1a1278cc3494b61", 500);
  }

  self notifyonplayercommand("tightgrip_fire", "+attack");
  self notifyonplayercommand("tightgrip_release", "-attack");

  for(;;) {
    self waittill("tightgrip_fire");

    if(self._id_0133 _meth_8624("gunperk_tightgrip")) {
      if(!scripts\mp\utility\perk::_hasperk("specialty_tightgrip")) {
        scripts\mp\utility\perk::_id_6FC2("specialty_tightgrip");
      } else {
        self notify("tightgrip_continue");
      }

      self waittill("tightgrip_release");
      thread _id_4AF7();
    }
  }
}

_id_4AF7() {
  self endon("tightgrip_continue");
  wait 0.2;
  scripts\mp\utility\perk::removeperk("specialty_tightgrip");
}

_id_FB1B() {
  self notify("tight_grip_unset");
  self _meth_824C("tightgrip_fire", "+attack");
  self _meth_824C("tightgrip_release", "-attack");

  if(self _meth_81A3("specialty_tightgrip")) {
    scripts\mp\utility\perk::removeperk("specialty_tightgrip");
  }
}

_id_D691() {
  thread _id_A137();
}

_id_A137() {
  self endon("quickscope_unset");
  self endon("disconnect");

  for(;;) {
    if(self._id_0133 _meth_8624("gunperk_quickscope") && self playerads() == 1) {
      thread _id_D692();

      while(self playerads() == 1) {
        waitframe();
      }

      if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
        scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
      }
    }

    waitframe();
  }
}

_id_D692() {
  self notify("quickscope_accuracy_start");
  self endon("quickscope_accuracy_start");
  self endon("quickscope_unset");

  if(!scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::_id_6FC2("specialty_increaseaccuracy");
  }

  wait 1.0;

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
  }
}

_id_FADA() {
  self notify("quickscope_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
  }
}

_id_D58A() {
  thread _id_A115();
}

_id_A115() {
  self endon("hardscope_unset");
  self endon("disconnect");

  for(;;) {
    if(self playerads() == 1) {
      thread _id_D58B();

      while(self playerads() == 1) {
        waitframe();
      }

      self notify("hardscope_cancel");

      if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
        scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
      }
    }

    waitframe();
  }
}

_id_D58B() {
  self endon("hardscope_cancel");
  self endon("hardscope_unset");
  wait 0.5;
  scripts\mp\utility\perk::_id_6FC2("specialty_increaseaccuracy");
}

_id_FAA1() {
  self notify("hardscope_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
  }
}

_id_D606() {
  thread _id_A125();
}

_id_A125() {
  self endon("nervesofsteel_unset");

  for(;;) {
    if(isDefined(self.health) && isDefined(self.maxhealth) && self.health < self.maxhealth || isDefined(self._id_0419) && isDefined(self._id_0419._id_0050) && self._id_0419._id_0050 > 0) {
      scripts\mp\utility\perk::_id_6FC2("specialty_increaseaccuracy");

      while(isDefined(self.health) && isDefined(self.maxhealth) && self.health < self.maxhealth || isDefined(self._id_0419._id_0050) && self._id_0419._id_0050 > 0) {
        waitframe();
      }

      scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    }

    waitframe();
  }
}

_id_FAC2() {
  self notify("nervesofsteel_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
  }
}

_id_D45C() {
  self notify("acquisition_set");
  self endon("acquisition_set");
  scripts\mp\utility\perk::_id_6FC2("specialty_increaseaccuracy");
  wait 5.0;
  scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
}

_id_D63B() {
  thread _id_A12F();
}

_id_A12F() {
  if(self._id_0133 _meth_8624("gunperk_panic")) {
    thread _id_D63C();
  }

  for(;;) {
    self waittill("weapon_change");
    waitframe();

    if(self._id_0133 _meth_8624("gunperk_panic")) {
      thread _id_D63C();
      continue;
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
      scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    }
  }
}

_id_D63C() {
  self notify("panic_accuracy_set");
  self endon("panic_accuracy_set");
  self endon("panic_unset");

  if(!scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::_id_6FC2("specialty_increaseaccuracy");
  }

  wait 3.0;
  scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
}

_id_FACE() {
  self notify("panic_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
  }
}

_id_1718(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(var_0._id_4AAA)) {
    return;
  } else if(var_0 scripts\mp\utility\perk::_hasperk("specialty_van_lightweight")) {
    var_0._id_4AAA = -0.05;
  } else {
    var_0._id_4AAA = -0.05;
  }

  var_0 scripts\mp\weapons::_id_FCCC();
  var_0 _id_1716();
  scripts\engine\utility::_id_108A7(0.8, "death");
  var_0 _id_1717();
  var_0._id_4AAA = undefined;
  var_0 scripts\mp\weapons::_id_FCCC();
}

_id_1716() {
  scripts\common\utility::_id_1581(0);
  scripts\common\utility::_id_157F(0);
  scripts\common\utility::_id_154E(0);

  if(self getstance() != "prone") {
    scripts\common\utility::_id_1570(0);
  }
}

_id_1717() {
  scripts\common\utility::_id_1581(1);
  scripts\common\utility::_id_157F(1);
  scripts\common\utility::_id_154E(1);

  if(isDefined(self._id_4AAA) && !scripts\common\utility::_id_868B()) {
    scripts\common\utility::_id_1570(1);
  }
}

_id_D8DE() {
  self._id_AD63 = 0.05;
  self._id_AD64 = 0.05;
  self._id_AD65 = 0.02;
  self._id_AD67 = 0.3;
  self._id_AD66 = 0.05;
  scripts\mp\weapons::_id_FD7E();
}

_id_FB23() {
  self._id_AD63 = undefined;
  self._id_AD64 = undefined;
  self._id_AD65 = undefined;
  self._id_AD67 = undefined;
  self._id_AD66 = undefined;
  scripts\mp\weapons::_id_FD7E();
}

_id_D466() {
  self._id_10D5C = 0.08;
  scripts\mp\weapons::_id_FCCC();
}

_id_FA4D() {
  self._id_10D5C = undefined;
  scripts\mp\weapons::_id_FCCC();
}

_id_D465() {
  self._id_10D5B = 1;
  var_0 = scripts\mp\class::buildweapon(self._id_9683, self._id_9685, self._id_9686, self._id_968C, self._id_968E);
  var_1 = scripts\mp\class::buildweapon(self._id_9692, self._id_9694, self._id_9695, self._id_969A, self._id_969C);

  if(scripts\mp\utility\weapon::getweapongroup(var_0.basename) == "weapon_projectile") {
    self setweaponammoclip(var_0, weaponclipsize(var_0));
  }

  if(scripts\mp\utility\weapon::getweapongroup(var_1.basename) == "weapon_projectile") {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
  }
}

_id_FA4C() {
  self._id_10D5B = undefined;
}

_id_D534() {
  self endon("death_or_disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    var_0 = self _meth_8191("primary");

    foreach(var_2 in var_0) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = weaponclipsize(var_2);
      var_5 = var_4 - var_3;
      var_6 = self getweaponammostock(var_2);

      if(var_3 != var_4 && var_6 > 0) {
        if(var_3 + var_6 >= var_4) {
          self setweaponammoclip(var_2, var_4);
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammoclip(var_2, var_3 + var_6);

        if(var_6 - var_5 > 0) {
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammostock(var_2, 0);
      }
    }
  }
}

_id_FA85() {
  self notify("endDoubleLoad");
}

_id_D5F3(var_0) {
  return;

  if(!isDefined(var_0)) {
    var_0 = 10;
  } else {
    var_0 = int(var_0) * 2;
  }

  scripts\mp\utility\weapon::_id_D69A(var_0);
  self._id_C114 = var_0;
}

_id_FABC() {
  return;
  scripts\mp\utility\weapon::_id_D69A(0);
  self._id_C114 = 0;
}

_id_D55A() {
  thread _id_10AE5();
}

_id_10AE5() {
  self endon("death_or_disconnect");
  self endon("fastcrouch_unset");

  for(;;) {
    var_0 = (self getstance() == "crouch" || self getstance() == "prone") && !self issprintsliding();

    if(!isDefined(self._id_59BC)) {
      if(var_0) {
        self._id_59BC = 0.25;
        scripts\mp\weapons::_id_FCCC();
      }
    } else if(!var_0) {
      self._id_59BC = undefined;
      scripts\mp\weapons::_id_FCCC();
    }

    waitframe();
  }
}

_id_FA91() {
  self notify("fastcrouch_unset");

  if(isDefined(self._id_59BC)) {
    self._id_59BC = undefined;
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_D6AB() {
  self endon("unsetRShieldRadar");
  wait 0.75;
  self _meth_8222();
  thread _id_D6AC();
}

_id_D6AC() {
  self endon("unsetRShieldRadar");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    _id_FAEB();
  }
}

_id_FAEB() {
  self _meth_8081();
  self notify("unsetRShieldRadar");
}

_id_D6AD() {
  self _meth_8223();
  thread _id_D6AE();
}

_id_D6AE() {
  self endon("unsetRShieldScrambler");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    _id_FAEC();
  }
}

_id_FAEC() {
  self _meth_8084();
  self notify("unsetRShieldScrambler");
}

_id_D6F7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  var_0 = int(var_0);

  if(var_0 == 10) {
    self._id_EAAE = 0;
  } else {
    self._id_EAAE = var_0 / 10;
  }
}

_id_FB09() {
  self._id_EAAE = 1;
}

_id_19ED(var_0, var_1, var_2) {
  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && var_0 != var_1) {
    if(isDefined(var_1._id_EAAE) && isDefined(var_2)) {
      var_2 = var_2 * var_1._id_EAAE;
    }

    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.owner), var_0.owner, var_0);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_1.owner), var_1.owner, var_1);

    if(isPlayer(var_3) && var_3 != var_1) {
      var_0 _id_07C4::_id_FC47("hittacresist", undefined, undefined, undefined, 1);
    }

    if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_3, var_4))) {
      var_1 _id_07BC::_id_C670(var_3);
    }
  } else if(!istrue(var_1 scripts\mp\utility\player::_id_8554()))
    var_2 = 0.0;

  if(var_1 scripts\mp\utility\game::_id_8923()) {
    var_2 = var_2 * 0.1;
  }

  return var_2;
}

_id_D8E6() {
  if(isagent(self)) {
    return;
  }
  self endon("unsetWeaponLaser");
  wait 0.5;
  thread _id_D8E8();
}

_id_FB25() {
  self notify("unsetWeaponLaser");

  if(isDefined(self._id_B005) && self._id_B005) {
    scripts\mp\utility\weapon::_id_4AFD();
  }

  self._id_B005 = undefined;
  self._id_B004 = undefined;
}

_id_D8EC(var_0) {
  var_0 = getweaponbasename(var_0);

  for(;;) {
    if(isDefined(var_0) && (var_0 == "iw6_kac_mp" || var_0 == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", var_1);
    var_0 = var_1.basename;
  }
}

_id_D8E8() {
  self endon("death_or_disconnect");
  self endon("unsetWeaponLaser");
  self._id_B005 = 0;
  var_0 = self getcurrentweapon();

  for(;;) {
    _id_D8EC(var_0);

    if(self._id_B005 == 0) {
      self._id_B005 = 1;
      scripts\mp\utility\weapon::_id_5273();
    }

    childthread _id_D8E9();
    childthread _id_D8EA(1.0);
    self._id_B004 = undefined;
    self waittill("weapon_change");

    if(self._id_B005 == 1) {
      self._id_B005 = 0;
      scripts\mp\utility\weapon::_id_4AFD();
    }
  }
}

_id_D8EA(var_0) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread _id_D8EB(var_0);
  }
}

_id_D8EB(var_0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self._id_B005 == 1) {
    self._id_B004 = 1;
    self._id_B005 = 0;
    scripts\mp\utility\weapon::_id_4AFD();
  }

  wait(var_0);
  self._id_B004 = undefined;

  if(self._id_B005 == 0 && self playerads() <= 0.6) {
    self._id_B005 = 1;
    scripts\mp\utility\weapon::_id_5273();
  }
}

_id_D8E9() {
  self endon("weapon_change");

  for(;;) {
    if(!isDefined(self._id_B004) || self._id_B004 == 0) {
      if(self playerads() > 0.6) {
        if(self._id_B005 == 1) {
          self._id_B005 = 0;
          scripts\mp\utility\weapon::_id_4AFD();
        }
      } else if(self._id_B005 == 0) {
        self._id_B005 = 1;
        scripts\mp\utility\weapon::_id_5273();
      }
    }

    waitframe();
  }
}

_id_D6EE() {
  self _meth_82D3(0.5);
}

_id_FB06() {
  self notify("end_SteadyAimPro");
  self _meth_82D3(1.0);
}

_id_B001() {
  self endon("disconnect");
  self waittill("death");
  self._id_0DB2 = undefined;
}

_id_D53C() {
  if(isDefined(self._id_52F7)) {
    return;
  }
  self.maxhealth = scripts\mp\tweakables::_id_6E14("player", "maxhealth") * 4;
  self.health = self.maxhealth;
  self._id_52F7 = 1;
  self._id_1DE2[0] = "";
  self visionsetnakedforplayer("end_game", 5);
  thread _id_5300(7);
  scripts\mp\gamelogic::_id_D58D(self, 1);
}

_id_FA87() {
  self notify("stopEndGame");
  self._id_52F7 = undefined;
  scripts\mp\utility\player::_id_C708(1);

  if(!isDefined(self._id_5304)) {
    return;
  }
  self._id_5304 scripts\mp\hud_util::destroyelem();
  self._id_5302 scripts\mp\hud_util::destroyelem();
}

_id_5300(var_0) {
  self endon("death_or_disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait(var_0 + 1);
  _id_0A8B::_id_0D8A();
}

_id_D6B2() {
  self._id_A8EC = 1.2;
}

_id_FAF0() {
  self._id_A8EC = 1;
}

_id_D4DC() {
  self endon("death_or_disconnect");
  self endon("unsetCombatSpeed");
  self._id_7D9D = 0;
  _id_FA71();

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isDefined(var_1.team)) {
      continue;
    }
    if(level.teambased && var_1.team == self.team) {
      continue;
    }
    if(self._id_7D9D) {
      continue;
    }
    _id_D4DD();
    self._id_7D9D = 1;
    thread _id_5332();
  }
}

_id_5332() {
  self notify("endOfSpeedWatcher");
  self endon("endOfSpeedWatcher");
  self endon("death_or_disconnect");
  self waittill("healed");
  _id_FA71();
  self._id_7D9D = 0;
}

_id_D4DD() {
  if(self._id_10DD9 <= 0.8) {
    self._id_3AC4 = 1.4;
  } else if(self._id_10DD9 <= 0.9) {
    self._id_3AC4 = 1.3;
  } else {
    self._id_3AC4 = 1.2;
  }

  scripts\mp\weapons::_id_FCCC();
}

_id_FA71() {
  self._id_3AC4 = 1;
  scripts\mp\weapons::_id_FCCC();
}

_id_FA70() {
  _id_FA71();
  self notify("unsetCombatSpeed");
}

_id_D5E3() {
  if(!isDefined(self._id_3E59)) {
    self._id_A25F = self._id_A25F + scripts\mp\utility\perk::_id_94CA();
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_FAB7() {
  self._id_A25F = max(1, self._id_A25F - scripts\mp\utility\perk::_id_94CA());
  scripts\mp\weapons::_id_FCCC();
}

_id_D6B0() {
  if(!isDefined(self._id_3E59)) {
    self._id_A25F = self._id_A25F + scripts\mp\utility\perk::_id_CA5B();
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_FAEE() {
  self._id_A25F = max(1, self._id_A25F - scripts\mp\utility\perk::_id_CA5B());
  scripts\mp\weapons::_id_FCCC();
}

_id_D499() {}

_id_FA5C() {}

_id_D6F3() {
  scripts\mp\utility\perk::_id_6FC2("specialty_bulletaccuracy");
  scripts\mp\utility\perk::_id_6FC2("specialty_holdbreath");
}

_id_FB08() {
  scripts\mp\utility\perk::removeperk("specialty_bulletaccuracy");
  scripts\mp\utility\perk::removeperk("specialty_holdbreath");
}

_id_D50A() {}

_id_FA7C() {}

_id_D5E5() {
  if(_id_078D::_id_85B3()) {
    self _meth_8223();
  }
}

_id_FAB8() {
  self _meth_8084();
}

_id_D71F() {
  self _meth_840B();
}

_id_FB17() {
  self _meth_840A();
}

_id_D628() {
  thread _id_AAC0();
}

_id_FAC5() {
  self notify("stop_oneManArmyTracker");
}

_id_AAC0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0.basename != "onemanarmy_mp") {
      continue;
    }
    thread _id_D073();
  }
}

_id_895E(var_0) {
  if(var_0 == game["menu_onemanarmy"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && var_0 == game["menu_onemanarmy_defaults_splitscreen"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && var_0 == game["menu_onemanarmy_custom_splitscreen"]) {
    return 1;
  }

  return 0;
}

_id_D073() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\common\utility::_id_1593(0);
  scripts\common\utility::_id_1562(0);
  scripts\common\utility::_id_158A(0);
  thread _id_39DB();
  self waittill("menuresponse", var_0, var_1);
  scripts\common\utility::_id_1593(1);
  scripts\common\utility::_id_1562(1);
  scripts\common\utility::_id_158A(1);

  if(var_1 == "back" || !_id_895E(var_0) || scripts\mp\utility\player::_id_8ACE()) {
    var_2 = self getcurrentweapon();

    if(var_2.basename == "onemanarmy_mp") {
      scripts\common\utility::_id_1593(0);
      scripts\common\utility::_id_1562(0);
      scripts\common\utility::_id_158A(0);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_0A95::_id_6AF9());
      self waittill("weapon_change");
      scripts\common\utility::_id_1593(1);
      scripts\common\utility::_id_1562(1);
      scripts\common\utility::_id_158A(1);
    }

    return;
  }

  thread _id_6FC0(var_1);
}

_id_39DB() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  scripts\common\utility::_id_1593(1);
  scripts\common\utility::_id_1562(1);
  scripts\common\utility::_id_158A(1);
}

_id_6FC0(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\perk::_hasperk("specialty_omaquickchange")) {
    var_1 = 3.0;
    _id_0AA2::_id_B8BA(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    var_1 = 6.0;
    _id_0AA2::_id_B8BA(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
  }

  thread _id_AA3D(var_1);
  scripts\common\utility::_id_158D(0);
  scripts\common\utility::_id_1562(0);
  scripts\common\utility::_id_158A(0);
  wait(var_1);
  scripts\common\utility::_id_158D(1);
  scripts\common\utility::_id_1562(1);
  scripts\common\utility::_id_158A(1);
  scripts\mp\class::_id_6FB1(self.pers["team"], var_0);

  if(isDefined(self._id_32E6)) {
    self attach(self._id_32E6, "J_spine4", 1);
  }

  self notify("changed_kit");
  level notify("changed_kit");
  scripts\mp\rank::_id_F756();
}

_id_AA3D(var_0) {
  self endon("disconnect");
  var_1 = scripts\mp\hud_util::_id_4035();
  var_2 = scripts\mp\hud_util::_id_4036();
  var_2 settext(&"MPUI_CHANGING_KIT");
  var_1 scripts\mp\hud_util::_id_FC11(0, 1 / var_0);

  for(var_3 = 0; var_3 < var_0 && isalive(self) && !level.gameended; var_3 = var_3 + 0.05) {
    wait 0.05;
  }

  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

_id_D467() {
  self _meth_8486(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 600, 1000));
  self _meth_8482(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 750, 750));
}

_id_FA4E() {
  self _meth_8486(0, 400);
  self _meth_8482(0, 900);
}

_id_D49A() {}

_id_FA5D() {}

_id_F2DC(var_0) {}

_id_2545(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("end_perkUseTracker");
  level endon("game_ended");

  for(;;) {
    self waittill("empty_offhand");

    if(!scripts\common\utility::_id_8650()) {
      continue;
    }
    self[[var_1]](scripts\mp\utility\perk::_hasperk("specialty_blastshield"));
  }
}

_id_D56C() {}

_id_FA96() {}

_id_D704() {
  scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
}

_id_FB0F() {}

_id_D63A(var_0) {
  if(isPlayer(self)) {
    var_1 = 0.5;

    if(!scripts\mp\utility\perk::_hasperk("specialty_engineer") && !scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      self._id_ADF3 = 1;
      _func_0251(self.origin, var_0, 10, 100);
      var_2 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "outline_nodepth_orange", "perk");
      thread _id_10BC8(var_2, var_1);
      thread _id_10BC9(var_2);
    }
  }
}

_id_10BC8(var_0, var_1) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::_id_108A7(var_1, "death");
  self._id_ADF3 = 0;
  scripts\mp\utility\outline::outlinedisable(var_0, self);
  self notify("painted_end");
}

_id_10BC9(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("painted_again", "painted_end");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

_id_896E() {
  return isDefined(self._id_ADF3) && self._id_ADF3;
}

_id_D486() {}

_id_FA51() {}

_id_D6A0() {
  if(isDefined(self._id_BCD1)) {
    self givemaxammo(self._id_BCD1);
  }

  if(isDefined(self._id_CFE2)) {
    self givemaxammo(self._id_CFE2);
  }
}

_id_FAE4() {}

_id_D69F() {
  if(isDefined(self._id_034C)) {
    self givemaxammo(self._id_034C);
  }

  if(isDefined(self._id_03B5)) {
    self givemaxammo(self._id_03B5);
  }
}

_id_FAE3() {}

_id_D4DE() {}

_id_FA72() {}

_id_D707() {
  thread _id_D708();
}

_id_D708() {
  self endon("death_or_disconnect");
  self endon("unsetTagger");
  level endon("game_ended");

  for(;;) {
    self waittill("eyesOn");
    var_0 = self _meth_8171();

    foreach(var_2 in var_0) {
      if(level.teambased && var_2.team == self.team) {
        continue;
      }
      if(isalive(var_2) && var_2.sessionstate == "playing") {
        if(!isDefined(var_2._id_AFD4)) {
          var_2._id_AFD4 = 0;
        }

        if(!var_2._id_AFD4) {
          var_2._id_AFD4 = 1;
        }

        var_2 thread _id_AD05(self);
      }
    }
  }
}

_id_AD05(var_0) {
  self endon("death_or_disconnect");
  self endon("eyesOff");
  level endon("game_ended");

  for(;;) {
    var_1 = 1;
    var_2 = var_0 _meth_8171();

    foreach(var_4 in var_2) {
      if(var_4 == self) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      self._id_AFD4 = 0;
      self notify("eyesOff");
    }

    wait 0.5;
  }
}

_id_FB12() {
  self notify("unsetTagger");
}

_id_D653() {
  thread _id_D654();
}

_id_D654() {
  self endon("death_or_disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");
  self _meth_832A(1.5);

  for(;;) {
    self _meth_832B(1.25);
    self waittill("grenade_pullback", var_0);
    var_1 = var_0.basename;

    if(var_1 == "airdrop_marker_mp" || var_1 == "deployable_vest_marker_mp" || var_1 == "deployable_weapon_crate_marker_mp") {
      self _meth_832B(1);
    }

    self waittill("grenade_fire", var_2, var_0);
  }
}

_id_FAD6() {
  self _meth_832A(1);
  self _meth_832B(1);
  self notify("unsetPitcher");
}

_id_D4A1() {}

_id_D4A2(var_0) {
  self endon("death_or_disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  waitframe();
  _func_0251(self.origin, var_0, 800, 1500);
  var_0 _id_26B7(self.origin, self);
}

_id_26B7(var_0, var_1) {
  var_2 = scripts\common\utility::_id_B7BF(var_0, 700);

  foreach(var_4 in var_2) {
    if(var_1 == var_4) {
      continue;
    }
    if(scripts\mp\utility\player::isenemy(var_4) && isalive(var_4) && !var_4 scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {}
  }
}

_id_26B6(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("removearchetype");
  var_2 = scripts\engine\utility::_id_108A7(7.0, "death");

  if(var_2 == "timeout" && isDefined(self._id_9B35[var_1])) {
    self._id_9B35[var_1] = undefined;
  } else {
    self waittill("spawned_player");
    self._id_9B35 = undefined;
  }
}

_id_FA60() {
  self notify("unsetBoom");
}

_id_4275(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("unset_custom_juiced");
  level endon("game_ended");
  self._id_88E6 = 1;
  self._id_A25F = 1.1;
  scripts\mp\weapons::_id_FCCC();
  scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
  scripts\mp\utility\perk::_id_6FC2("specialty_stalker");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastoffhand");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickswap");
  thread _id_FA77();
  thread _id_FA79();
  thread _id_FA78();
  var_1 = var_0 * 1000 + gettime();

  if(!isai(self)) {}

  wait(var_0);
  _id_FA76();
}

_id_FA76(var_0) {
  if(!isDefined(var_0)) {
    self._id_A25F = 1;

    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
      self._id_A25F = self._id_A25F + scripts\mp\utility\perk::_id_94CA();
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_runner")) {
      self._id_A25F = self._id_A25F + scripts\mp\utility\perk::_id_CA5B();
    }

    scripts\mp\weapons::_id_FCCC();
  }

  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_stalker");
  scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self._id_88E6 = undefined;

  if(!isai(self)) {}

  self notify("unset_custom_juiced");
}

_id_FA79() {
  self endon("disconnect");
  self endon("unset_custom_juiced");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::_id_8ACE()) {
      thread _id_FA76();
      break;
    }
  }
}

_id_FA77() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  scripts\engine\utility::waittill_any_2("death", "faux_spawn");
  thread _id_FA76(1);
}

_id_FA78() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level scripts\engine\utility::waittill_any_2("round_end_finished", "game_ended");
  thread _id_FA76();
}

_id_D734() {}

_id_D735() {
  self endon("death_or_disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");
  var_0 = self._id_8FC2;
  var_1 = self getweaponammostock(var_0);
  var_2 = self getweaponammoclip(var_0);
  self _meth_819C(var_0);
  var_3 = self getweaponammoclip(var_0);
  var_4 = var_3 - var_2;
  var_5 = var_1 - var_4;

  if(var_4 > var_1) {
    self setweaponammoclip(var_0, var_2 + var_1);
    var_5 = 0;
  }

  self setweaponammostock(var_0, var_5);
  self playlocalsound("ammo_crate_use");
  self setclientomnvar("ui_trigger_happy", 1);
  wait 0.2;
  self setclientomnvar("ui_trigger_happy", 0);
}

_id_FB1F() {
  self setclientomnvar("ui_trigger_happy", 0);
  self notify("unsetTriggerHappy");
}

_id_D5B4() {}

_id_FAAA() {}

_id_D49B() {}

_id_FA5E() {}

_id_D693() {}

_id_FADB() {}

_id_D54B() {
  self endon("death_or_disconnect");
  self endon("unset_extraammo");
  level endon("game_ended");

  if(self._id_6DF0) {
    self waittill("giveLoadout");
  }

  var_0 = scripts\mp\utility\weapon::_id_6E2E();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !isnullweapon(var_2) && var_2 _meth_8624("maxammo", 1) && !istrue(var_2._id_5BAB)) {
      self givemaxammo(var_2);
      var_2._id_5BAB = 1;
    }
  }
}

_id_FA8C() {
  self notify("unset_extraammo");
}

_id_D54F() {
  self endon("death_or_disconnect");
  self endon("unset_extraequipment");
  level endon("game_ended");

  if(self._id_6DF0) {
    self waittill("giveLoadout");
  }

  var_0 = self._id_967E;

  if(isDefined(var_0) && var_0 != "specialty_null") {
    if(var_0 != "specialty_tacticalinsertion" && var_0 != "s4_smoke_usa_m18_mp") {
      self setweaponammoclip(var_0, 2);
    }
  }
}

_id_FA8F() {
  self notify("unset_extraequipment");
}

_id_D54D() {
  self endon("death_or_disconnect");
  self endon("unset_extradeadly");
  level endon("game_ended");

  if(self._id_6DF0) {
    self waittill("giveLoadout");
  }

  var_0 = scripts\mp\equipment::_id_69A4("primary");

  if(isDefined(var_0) && var_0 != "none") {
    scripts\mp\equipment::incrementequipmentammo(var_0);
  }
}

_id_FA8D() {
  self notify("unset_extradeadly");
}

_id_D493() {}

_id_FA58() {}

_id_D630() {}

_id_FACB() {}

_id_D460() {}

_id_FA49() {}

_id_D5DE() {
  if(!isDefined(level._effect["life_pack_pickup"])) {
    level._effect["life_pack_pickup"] = undefined;
  }

  thread _id_10B9F();
}

_id_10B9F() {
  self endon("death_or_disconnect");
  self notify("unset_lifepack");
  self endon("unset_lifepack");

  for(;;) {
    self waittill("got_a_kill", var_0, var_1, var_2);
    var_3 = self.origin;
    var_4 = 20;
    var_5 = 20;
    var_6 = spawn("script_model", self.origin + (0, 0, 10));
    var_6 setModel("weapon_life_pack");
    var_6.owner = self;
    var_6.team = self.team;
    var_6 hidefromplayer(self);
    var_7 = spawn("trigger_radius", self.origin, 0, var_4, var_5);
    var_7 thread _id_10BA3(var_6);
    var_7 thread _id_10B9E(var_6);
    var_6 thread _id_7B11();
    var_6 rotateyaw(1000, 30, 0.2, 0.2);
    var_6 thread _id_10BA0(10, var_7);
    var_6 thread _id_10BA2();

    foreach(var_9 in level.players) {
      var_6 _id_D5E0(var_9);
    }
  }
}

_id_0EF7(var_0, var_1, var_2) {
  self._id_936B = 1;

  if(isDefined(var_1) && var_1 > 0) {
    thread _id_10B9D(var_1);
  }

  if(isDefined(var_2) && var_2) {
    thread _id_10BA4();
  }

  scripts\mp\utility\perk::_id_6FC2("specialty_regenfaster");
  self setclientomnvar("ui_life_link", 1);
  self notify("enabled_life_pack_boost");
  self._id_9370 = var_0;
  scripts\mp\gamescore::_id_F3F3(var_0, self, "medic_lifepack");
}

_id_10B9D(var_0) {
  self endon("death_or_disconnect");
  wait(var_0);

  if(isDefined(self._id_936B)) {
    _id_4AC1();
  }
}

_id_4AC1() {
  if(isDefined(self) && isDefined(self._id_936B)) {
    self._id_936B = undefined;
    self setclientomnvar("ui_life_link", 0);
    self notify("disabled_life_pack_boost");
    scripts\mp\utility\perk::removeperk("specialty_regenfaster");
    scripts\mp\gamescore::_id_FB2B(self._id_9370, self, "medic_lifepack");
    self._id_9370 = undefined;
  }
}

_id_D5E0(var_0) {
  if(level.teambased && var_0.team == self.team && var_0 != self.owner) {
    _id_D5DF(var_0);
    self showtoplayer(var_0);
    thread _id_10BA1(var_0);
  } else
    self hidefromplayer(var_0);
}

_id_D5DF(var_0) {
  if(isDefined(var_0._id_936B)) {
    if(isDefined(var_0._id_936F) && var_0._id_936F.size > 0) {
      foreach(var_2 in var_0._id_936F) {
        if(self == var_2._id_ADC7) {
          scripts\mp\utility\outline::outlinedisable(var_2._id_7C8C, var_2._id_ADC7);
          var_0._id_936F = scripts\engine\utility::array_remove(var_0._id_936F, var_2);
          var_2 = undefined;
        }
      }
    }
  } else {
    if(!isDefined(var_0._id_936F)) {
      var_0._id_936F = [];
    }

    var_4 = spawnStruct();
    var_4._id_7C8C = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "outline_depth_cyan", "equipment");
    var_4._id_ADC7 = self;
    var_0._id_936F = scripts\engine\utility::_id_1B8D(var_0._id_936F, var_4);
  }
}

_id_10BA1(var_0) {
  self endon("death");

  for(;;) {
    var_0 scripts\engine\utility::waittill_any_2("enabled_life_pack_boost", "disabled_life_pack_boost");
    _id_D5DF(var_0);
  }
}

_id_7B11() {
  self endon("death");
  self endon("phase_resource_pickup");
  var_0 = self.origin;

  for(;;) {
    self moveto(var_0 + (0, 0, 15), 1, 0.2, 0.2);
    wait 1;
    self moveto(var_0, 1, 0.2, 0.2);
    wait 1;
  }
}

_id_10BA3(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(var_1.team != var_0.team) {
      continue;
    }
    if(isDefined(var_1._id_936B)) {
      continue;
    }
    if(var_1 == var_0.owner) {
      continue;
    }
    var_1 _id_0EF7(var_0.owner, 5, 1);
    var_1 playsoundtoplayer("scavenger_pack_pickup", var_1, var_1);
    var_2 = spawnfx(scripts\engine\utility::getfx("life_pack_pickup"), self.origin);
    triggerfx(var_2);
    var_2 thread scripts\mp\utility\script::_id_46C7(2);

    foreach(var_4 in level.players) {
      if(var_4.team == var_1.team) {
        continue;
      }
      var_2 hidefromplayer(var_4);
    }

    var_0 delete();
  }
}

_id_10B9E(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

_id_10BA0(var_0, var_1) {
  self endon("death");
  wait(var_0);
  var_1 delete();
  self delete();
}

_id_10BA2() {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(self)) {
    self delete();
  }
}

_id_10BA4() {
  self endon("disconnect");
  self waittill("death");
  _id_4AC1();
}

_id_FAB5() {
  _id_4AC1();
  self notify("unset_lifepack");
}

_id_D72E() {
  if(!isDefined(level._effect["toughen_up_screen"])) {
    level._effect["toughen_up_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_toughen_up_scrn");
  }

  thread _id_10C1B();
}

_id_10C1B() {
  self endon("death_or_disconnect");
  self endon("unsetToughenUp");
  level endon("game_ended");
  var_0 = 0;
  var_1 = 15;
  var_2 = 7.5;
  var_3 = 4;
  var_4 = 5;
  var_5 = 2;
  var_6 = [];
  var_6 = scripts\engine\utility::_id_1B8D(var_6, (35, 0, 10));
  var_6 = scripts\engine\utility::_id_1B8D(var_6, (0, 35, 10));
  var_6 = scripts\engine\utility::_id_1B8D(var_6, (-35, 0, 10));
  var_6 = scripts\engine\utility::_id_1B8D(var_6, (0, -35, 10));
  self waittill("spawned_player");

  for(;;) {
    self waittill("got_a_kill", var_7, var_8, var_9);

    if(!isDefined(self._id_F399)) {
      self._id_F399 = 1;
      var_10 = _func_020D(scripts\engine\utility::getfx("toughen_up_screen"), self getEye(), self);
      triggerfx(var_10);
      thread _id_1DBD("j_forehead", level._id_2D3A["section"]._id_5FB8);
      thread _id_1DBD("tag_reflector_arm_le", level._id_2D3A["section"]._id_5FB8);
      thread _id_1DBD("tag_reflector_arm_ri", level._id_2D3A["section"]._id_5FB8);
      thread _id_1DBD("j_spineupper", level._id_2D3A["section"]._id_5FB8);
      thread _id_1DBD("tag_shield_back", level._id_2D3A["section"]._id_5FB8);
      thread _id_1DBD("j_hip_le", level._id_2D3A["section"]._id_5FB8);
      thread _id_1DBD("j_hip_ri", level._id_2D3A["section"]._id_5FB8);

      if(var_5 == 1) {
        _id_0A8B::_id_D5A2(var_1);
        thread _id_10C1D(var_4);
      } else {
        _id_07EA::_id_D5E2(self, 100);
        thread _id_10C1E();
      }

      var_10 thread _id_10C20(self);
      continue;
    }

    if(var_5 == 1) {
      self notify("toughen_up_reset");
      thread _id_10C1D(var_4);
    }
  }
}

_id_1DBD(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_0);
  var_6 = spawn("script_model", var_5);
  var_6 setModel(var_1);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  var_6.angles = self.angles;
  var_6 linkto(self, var_0, var_7, var_8);
  var_6 thread _id_10C20(self);
  var_6 thread _id_10C1C();
  return var_6;
}

_id_D72F(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", self.origin + (0, 0, 50));
  var_4.team = self.owner.team;

  if(var_3 == "friendly") {
    var_4 setModel(level._id_2D3A["section"]._id_5FB8);
  } else {
    var_4 setModel(level._id_2D3A["section"]._id_5420);
  }

  var_4 linkto(self, "tag_origin", var_1, (0, 90 * (var_2 + 1), 0));
  var_4 hide();
  var_4 thread _id_10C20(self.owner);
  var_4 thread _id_10C1C();
  var_4 thread _id_D730(var_3, self.owner);
}

_id_10C1E() {
  self endon("disconnect");
  self waittill("remove_light_armor");
}

_id_10C20(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_2("death_or_disconnect", "toughen_up_end");
  var_0._id_F399 = undefined;

  if(var_0 _id_07EA::_id_7580(var_0)) {
    var_0 _id_FAB6();
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_10C1C() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self delete();
  }
}

_id_10C1D(var_0) {
  self endon("death");
  self endon("toughen_up_reset");

  while(var_0 > 0) {
    var_0 = var_0 - 1;
    wait 1;
  }

  self notify("toughen_up_end");
}

_id_D730(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(_id_31D8(var_3, var_0)) {
      self showtoplayer(var_3);
    }

    thread _id_10C1F(var_3, var_0);
  }
}

_id_10C1F(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 waittill("spawned_player");
    self hidefromplayer(var_0);

    if(_id_31D8(var_0, var_1)) {
      self showtoplayer(var_0);
    }
  }
}

_id_31D8(var_0, var_1) {
  var_2 = 0;

  if(var_1 == "friendly" && var_0.team == self.team || var_1 == "enemy" && var_0.team != self.team) {
    var_2 = 1;
  }

  return var_2;
}

_id_FB1C() {
  _id_0A8B::_id_3943();
  _id_FAB6();
  self notify("unsetToughenUp");
}

_id_D6B8() {
  thread _id_FD1D();
}

_id_FD1D() {
  self endon("death_or_disconnect");
  self endon("unsetScoutPing");
  var_0 = 50;
  var_1 = 1200;

  for(;;) {
    var_2 = var_0;
    var_3 = var_1;

    if(isDefined(self._id_CC2F)) {
      var_2 = self._id_CC2F;
    }

    if(isDefined(self._id_CC30)) {
      var_3 = self._id_CC30;
    }

    var_2 = int(var_2);
    var_3 = int(var_3);

    if(var_2 != var_0) {
      _func_02DC(self.origin, self.team, var_2, var_3);
    }

    wait(var_1 / 1200);
  }
}

_id_FD1E(var_0) {
  var_1 = 0;
  var_2 = 150;
  var_3 = 3000;

  if(isDefined(self._id_CC2D)) {
    var_1 = self._id_CC2D;
  }

  if(isDefined(self._id_CC2E)) {
    if(var_0 > self._id_CC2E) {
      var_4 = var_0 - self._id_CC2E;
      var_1 = var_1 + var_4 / 10;
    } else if(var_0 < self._id_CC2E) {
      var_4 = self._id_CC2E - var_0;
      var_1 = var_1 - var_4 / 10;
    }
  }

  if(isDefined(self._id_CC2D)) {
    if(var_1 > self._id_CC2D || var_1 < self._id_CC2D) {
      var_2 = var_2 + var_2 * var_1 * 1.5;
      var_3 = var_3 - var_3 * var_1 / 1.5;
      self._id_CC2F = var_2;
      self._id_CC30 = var_3;
    }
  }

  if(var_0 == 0) {
    self._id_CC2F = undefined;
    self._id_CC30 = undefined;
  }

  self._id_CC2D = var_1;
  self._id_CC2E = var_0;
}

_id_FAF4() {
  self._id_CC2F = undefined;
  self._id_CC30 = undefined;
  self._id_CC2D = undefined;
  self._id_CC2E = undefined;
  self notify("unsetScoutPing");
}

_id_D64E() {
  thread _id_10BCE();
  thread _id_10BCD();
}

_id_10BCE() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("phase_shift_start");
    self._id_B035 = 0.2;
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_10BCD() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("phase_shift_completed");
    self._id_B035 = undefined;
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_FAD4() {
  self._id_B035 = undefined;
}

_id_D516() {
  self allowdodge(1);
}

_id_FA7F() {
  self allowdodge(0);
}

_id_D54E() {
  self _meth_8480(1, 100);
  self _meth_847E(1, 100);
}

_id_FA8E() {
  self _meth_8480(1, 50);
  self _meth_847E(1, 50);
}

_id_DD72(var_0) {
  if(!scripts\mp\utility\perk::_hasperk("specialty_sixth_sense")) {
    return 0;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  var_1 = scripts\mp\utility\game::getgametype();

  if(var_1 != "dm" && var_0.team == self.team) {
    return 0;
  }

  if(var_1 == "arena_evo" && !scripts\engine\utility::is_equal(var_0.team, scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"]))) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 16000000) {
    return 0;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_sixth_sense_immune")) {
    return 0;
  }

  var_2 = var_0 getentitynumber();

  if(!isDefined(self.sixthsenseotherplayers)) {
    self.sixthsenseotherplayers = [];
  }

  if(!isDefined(self.sixthsenseotherplayers[var_2])) {
    self.sixthsenseotherplayers[var_2] = gettime();
    thread clearsixthsensedelay(var_0, var_2);
    return 0;
  }

  if(self.sixthsenseotherplayers[var_2] + 200 > gettime()) {
    return 0;
  }

  var_3 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_3) && isDefined(var_3._id_1031E)) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(var_0);

    if(var_4) {
      if(var_3._id_1031E != "light_tank" && var_3._id_1031E != "apc_russian" && var_3._id_1031E != "s4_tank") {
        return 0;
      }
    } else if(var_3._id_1031E == "apc_russian")
      return 0;
  }

  if(var_0 scripts\mp\utility\player::_id_8ACE()) {
    var_5 = var_0 scripts\mp\utility\player::_id_6CEC();

    if(var_5 == "ball_turret_gunner" || var_5 == "radar_drone_recon" || var_5 == "chopper_gunner" || var_5 == "cruise_predator") {
      return 0;
    }
  }

  return 1;
}

clearsixthsensedelay(var_0, var_1) {
  for(;;) {
    var_2 = self _meth_8171();

    if(!isDefined(var_1)) {
      return;
    } else if(!isDefined(var_0) || !isDefined(self) || !isalive(var_0) || !isalive(self) || !scripts\mp\utility\perk::_hasperk("specialty_sixth_sense")) {
      self.sixthsenseotherplayers[var_1] = undefined;
      return;
    } else if(distancesquared(var_0.origin, self.origin) > 16000000) {
      self.sixthsenseotherplayers[var_1] = undefined;
      return;
    } else if(!scripts\engine\utility::array_contains(var_2, var_0)) {
      self.sixthsenseotherplayers[var_1] = undefined;
      return;
    }

    waitframe();
  }
}

_id_DD70(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_2;
  var_5 = vectordot(var_4, var_3);

  if(var_5 <= 0) {
    return 0;
  }

  var_6 = length(var_4);
  var_7 = 12;
  var_7 = var_7 + -0.12 * _func_0218(var_6);
  var_8 = scripts\engine\math::_id_4647(var_7);
  var_9 = 1 - 0.5 * var_8 * var_8;

  if(var_6 < 200) {
    var_5 = var_5 + 15 * (1 - var_6 / 200);
  }

  var_10 = var_9 * var_6;

  if(var_5 < var_9 * var_6) {
    return 0;
  }

  return 1;
}

_id_DD71(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = vectordot(var_0, vectornormalize(var_3));

  if(var_4 < 0.382683) {
    return 1;
  }

  return 0;
}

_id_DD74() {
  var_0 = scripts\engine\trace::_id_3EF6(1);
  var_1 = 0;
  var_2 = getdvarint("#x3870dc777315705e3") == 1;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = _func_028F();

  foreach(var_29, var_8 in level._id_DD6F) {
    if(!isDefined(var_8)) {
      level._id_DD6F[var_29] = undefined;
      break;
    }

    var_9 = 0;

    if(var_2 && !isbot(var_8)) {
      if(!var_8 scripts\mp\utility\perk::_hasperk("specialty_sixth_sense")) {
        continue;
      }
      if(!var_8 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      var_10 = var_8 scripts\mp\utility\player::_id_6D7F();
      var_11 = var_8 _meth_8171();

      foreach(var_13 in var_11) {
        if(var_3 >= 25) {
          var_3 = 0;
          waitframe();
        }

        if(!isDefined(var_8)) {
          level._id_DD6F[var_29] = undefined;
          break;
        }

        if(!var_8 _id_DD72(var_13)) {
          continue;
        }
        var_3++;
        var_14 = var_13 getvieworigin();
        var_15 = anglesToForward(var_13 getplayerangles());

        if(!var_8 _id_DD70(var_13, var_10, var_14, var_15)) {
          continue;
        }
        var_9 = var_9 | var_8 _id_6D2D(var_13);
      }
    } else {
      var_10 = var_8 gettagorigin("j_spinelower");
      var_17 = var_8 getEye();
      var_18 = anglesToForward(var_8 getplayerangles());

      foreach(var_13 in level.players) {
        if(var_3 >= 25) {
          var_3 = 0;
          waitframe();
        }

        if(!isDefined(var_8)) {
          level._id_DD6F[var_29] = undefined;
          break;
        }

        if(!var_8 _id_DD72(var_13)) {
          continue;
        }
        var_3++;
        var_14 = var_13 getvieworigin();
        var_15 = anglesToForward(var_13 getplayerangles());

        if(!var_8 _id_DD70(var_13, var_10, var_14, var_15)) {
          continue;
        }
        if(_id_DD71(var_18, var_10, var_14)) {
          var_3 = var_3 + 2;
          var_20 = [var_8];
          var_21 = var_13 scripts\cp_mp\utility\player_utility::getvehicle();

          if(isDefined(var_21)) {
            var_22 = _id_6958(var_21);

            foreach(var_24 in var_22) {
              var_20[var_20.size] = var_24;
            }
          }

          var_26 = var_13._id_4205;

          if(isDefined(var_26)) {
            var_20[var_20.size] = var_26;
          }

          if(scripts\engine\trace::_id_C052(var_14, var_17, var_20, var_0)) {
            var_9 = 255;
            break;
          }
        }
      }
    }

    var_28 = 2;
    var_9 = var_9 &~var_28;
    var_8 _id_FD2C(var_9);

    if(var_9 != 0) {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_8, "high_alert");
    }
  }
}

_id_DD73() {
  level._id_DD6F = [];

  for(;;) {
    waitframe();
    _id_DD74();
  }
}

_id_D6CA() {
  if(getdvarint("#x3f2c086c700c2968b", 0) == 1) {
    return;
  }
  self._id_DD75 = 0;
  self._id_DD77 = 0;
  _id_FD2C(0);
  var_0 = self getentitynumber();
  level._id_DD6F[var_0] = self;
  self.sixthsenseotherplayers = [];
}

_id_FAFA() {
  thread _id_397A();
}

_id_397A() {
  self endon("disconnect");
  self._id_DD75 = undefined;
  self._id_DD77 = undefined;
  self._id_DD76 = undefined;
  self notify("removeSixthSense");
  var_0 = self getentitynumber();
  level._id_DD6F[var_0] = undefined;
  waitframe();
  _id_FD2C(0);
}

_id_D541() {}

_id_FA89() {}

_id_FD2C(var_0) {
  self setclientomnvar("ui_edge_glow", var_0);
}

_id_6D2D(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectornormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  } else if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::_id_8909(self.origin, var_2, var_0.origin), 4, 1);
  } else if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::_id_8909(self.origin, var_2, var_0.origin), 128, 64);
  } else if(var_5 >= -0.707107) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::_id_8909(self.origin, var_2, var_0.origin), 32, 8);
  } else {
    return 16;
  }
}

_id_9B28(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("markAsSixthSenseSource");
  self endon("markAsSixthSenseSource");
  var_1 = var_0 getentitynumber();
  self._id_DD76[var_1] = 1;
  var_0 scripts\engine\utility::_id_10890(["death"], 10);
  self._id_DD76[var_1] = 0;
}

_id_D4B0() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");

  for(;;) {
    var_0 = 0;
    var_1 = level.players;
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isDefined(var_4) || !var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_4.team == self.team) {
        continue;
      }
      if(var_4 scripts\mp\utility\perk::_hasperk("specialty_empimmune")) {
        continue;
      }
      var_5 = self.origin - var_4.origin;
      var_6 = anglesToForward(var_4 getplayerangles());
      var_7 = vectordot(var_5, var_6);

      if(var_7 <= 0) {
        continue;
      }
      var_8 = vectornormalize(var_5);
      var_9 = vectornormalize(var_6);
      var_7 = vectordot(var_8, var_9);

      if(var_7 < 12) {
        continue;
      }
      var_0++;
      var_10 = var_4 getEye();
      var_11 = self getEye();

      if(scripts\engine\trace::ray_trace_passed(var_10, var_11, self, scripts\engine\trace::_id_3EF6(1))) {
        var_2 = 1;
        break;
      }

      if(var_0 >= 10) {
        waitframe();
        var_0 = 0;
      }
    }

    _id_FC23(var_2);
    waitframe();
  }
}

_id_FC23(var_0) {}

_id_FA67() {}

_id_D4B4() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("airdrop_assault", 0, 0, self);
}

_id_FA68() {}

_id_D739() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("uav", 0, 0, self);
}

_id_FB20() {}

_id_D5C4(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("unset_juiced");
  level endon("game_ended");
  self._id_88E6 = 1;
  self._id_A25F = 1.25;
  scripts\mp\weapons::_id_FCCC();
  scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
  scripts\mp\utility\perk::_id_6FC2("specialty_stalker");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastoffhand");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickswap");
  thread _id_FAAE();
  thread _id_FAB0();
  thread _id_FAAF();

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = var_0 * 1000 + gettime();

  if(!isai(self)) {}

  wait(var_0);
  _id_FAAD();
}

_id_FAAD(var_0) {
  if(!isDefined(var_0)) {
    self._id_A25F = 1;

    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
      self._id_A25F = self._id_A25F + scripts\mp\utility\perk::_id_94CA();
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_runner")) {
      self._id_A25F = self._id_A25F + scripts\mp\utility\perk::_id_CA5B();
    }

    scripts\mp\weapons::_id_FCCC();
  }

  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_stalker");
  scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self._id_88E6 = undefined;

  if(!isai(self)) {}

  self notify("unset_juiced");
}

_id_FAB0() {
  self endon("disconnect");
  self endon("unset_juiced");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::_id_8ACE()) {
      thread _id_FAAD();
      break;
    }
  }
}

_id_FAAE() {
  self endon("disconnect");
  self endon("unset_juiced");
  scripts\engine\utility::waittill_any_2("death", "faux_spawn");
  thread _id_FAAD(1);
}

_id_FAAF() {
  self endon("disconnect");
  self endon("unset_juiced");
  level scripts\engine\utility::waittill_any_2("round_end_finished", "game_ended");
  thread _id_FAAD();
}

_id_7579() {
  return isDefined(self._id_88E6);
}

_id_D4DB() {
  self endon("death_or_disconnect");
  self endon("unset_combathigh");
  level endon("end_game");
  self._id_42E5 = 0;

  if(level.splitscreen) {
    var_0 = 56;
    var_1 = 21;
  } else {
    var_0 = 112;
    var_1 = 32;
  }

  if(isDefined(self._id_8C90)) {
    self._id_8C90 destroy();
  }

  if(isDefined(self._id_8C8F)) {
    self._id_8C8F destroy();
  }

  self._id_3AB2 = newclienthudelem(self);
  self._id_3AB2.x = 0;
  self._id_3AB2.y = 0;
  self._id_3AB2.alignx = "left";
  self._id_3AB2.aligny = "top";
  self._id_3AB2.horzalign = "fullscreen";
  self._id_3AB2.vertalign = "fullscreen";
  self._id_3AB2 setshader("combathigh_overlay", 640, 480);
  self._id_3AB2.sort = -10;
  self._id_3AB2.archived = 1;
  self._id_3AB3 = scripts\mp\hud_util::_id_4065("hudsmall", 1.0);
  self._id_3AB3 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_0);
  self._id_3AB3 _meth_8391(10.0);
  self._id_3AB3.color = (0.8, 0.8, 0);
  self._id_3AB3.archived = 0;
  self._id_3AB3._id_01D6 = 1;
  self._id_3AB1 = scripts\mp\hud_util::createicon("specialty_painkiller", var_1, var_1);
  self._id_3AB1.alpha = 0;
  self._id_3AB1 scripts\mp\hud_util::setparent(self._id_3AB3);
  self._id_3AB1 scripts\mp\hud_util::setpoint("BOTTOM", "TOP");
  self._id_3AB1.archived = 1;
  self._id_3AB1.sort = 1;
  self._id_3AB1._id_01D6 = 1;
  self._id_3AB2.alpha = 0.0;
  self._id_3AB2 fadeovertime(1.0);
  self._id_3AB1 fadeovertime(1.0);
  self._id_3AB2.alpha = 1.0;
  self._id_3AB1.alpha = 0.85;
  thread _id_FA6E();
  thread _id_FA6F();
  wait 8;
  self._id_3AB1 fadeovertime(2.0);
  self._id_3AB1.alpha = 0.0;
  self._id_3AB2 fadeovertime(2.0);
  self._id_3AB2.alpha = 0.0;
  self._id_3AB3 fadeovertime(2.0);
  self._id_3AB3.alpha = 0.0;
  wait 2;
  self._id_42E5 = undefined;
  scripts\mp\utility\perk::removeperk("specialty_combathigh");
}

_id_FA6E() {
  self endon("disconnect");
  self endon("unset_combathigh");
  self waittill("death");
  thread scripts\mp\utility\perk::removeperk("specialty_combathigh");
}

_id_FA6F() {
  self endon("disconnect");
  self endon("unset_combathigh");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::_id_8ACE()) {
      thread scripts\mp\utility\perk::removeperk("specialty_combathigh");
      break;
    }
  }
}

_id_FA6D() {
  self notify("unset_combathigh");
  self._id_3AB2 destroy();
  self._id_3AB1 destroy();
  self._id_3AB3 destroy();
}

_id_D5E1() {
  _id_07EA::_id_D5E2(self, 150);
}

_id_FAB6() {
  _id_07EA::_id_9455(self);
}

_id_D6A7() {
  self notify("stopRevenge");
  waitframe();

  if(!isDefined(self._id_8FFD)) {
    return;
  }
  if(level.teambased && self.team == self._id_8FFD.team) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_DCF3 = self;
  var_0._id_7C3B = "compassping_revenge";
  var_0._id_A97D = (0, 0, 64);
  var_0.width = 10;
  var_0.height = 10;
  var_0.archived = 0;
  var_0._id_4649 = 1.5;
  var_0._id_3B8C = 0;
  var_0._id_B0E8 = 1;
  var_0._id_58BF = 0;
  var_0._id_853E = 0;
  self._id_C7B4 = var_0;
  self._id_8FFD thread _id_078F::_id_D59B(var_0._id_DCF3, var_0._id_7C3B, var_0._id_A97D, undefined, undefined, undefined, var_0._id_4649);
  thread _id_10BF3();
  thread _id_10BF5();
  thread _id_10BF4();
  thread _id_10BF6();
  thread _id_10C07();
}

_id_10BF3() {
  self endon("stopRevenge");
  self endon("disconnect");
  var_0 = self._id_8FFD;

  for(;;) {
    var_0 waittill("spawned_player");
    var_0 thread _id_078F::_id_D59B(self._id_C7B4._id_DCF3, self._id_C7B4._id_7C3B, self._id_C7B4._id_A97D, undefined, undefined, undefined, self._id_C7B4._id_4649);
  }
}

_id_10BF5() {
  self endon("stopRevenge");
  self waittill("killed_enemy");
  self notify("stopRevenge");
}

_id_10BF4() {
  self endon("stopRevenge");
  self._id_8FFD waittill("disconnect");
  self notify("stopRevenge");
}

_id_10C07() {
  var_0 = self._id_8FFD;
  self waittill("stopRevenge");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3, var_2 in var_0._id_5504) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 destroy();
  }
}

_id_10BF6() {
  var_0 = self._id_A907;
  var_1 = self._id_8FFD;
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");
  self waittill("disconnect");

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_4, var_3 in var_1._id_5504) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 destroy();
  }
}

_id_FAE8() {
  self notify("stopRevenge");
}

_id_D64D() {
  self._id_31AB = 1;
}

_id_FAD3() {
  self._id_31AB = 0;
}

_id_D71D() {
  self._id_31F3 = 1;
}

_id_FB16() {
  self._id_31F3 = 0;
}

_id_D64C() {
  self._id_75A2 = 1;
}

_id_FAD2() {
  self._id_75A2 = 0;
}

_id_D649() {}

_id_FAD0() {}

_id_D54A() {}

_id_FA8B() {}

_id_D487() {
  _id_09F0::_id_1F05();
}

_id_FA52() {}

_id_D488() {}

_id_FA53() {}

_id_D5F4() {
  _id_0A6A::_id_9B88();
}

_id_FABD() {}

_id_D491() {}

_id_FA57() {}

_id_D4AF() {}

_id_FA66() {}

_id_D49C() {
  self._id_7647 = 1;
  self notify("force_regeneration");
}

_id_FA5F() {
  self._id_7647 = undefined;
  self notify("force_regeneration");
}

_id_D6B5() {}

_id_FAF2() {}

_id_D6FC() {}

_id_FB0A() {}

_id_D6D6() {}

_id_FAFF() {}

_id_D517() {
  _id_09BF::_id_10A2("dodgeDefense", 0.5, 0, ::_id_4C61);
}

_id_FA80() {
  _id_09BF::_id_C48A("dodgeDefense", 0);
}

_id_4C61(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!(isDefined(var_2._id_4C66) && var_2._id_4C66 && var_2 scripts\mp\utility\perk::_hasperk("specialty_dodge_defense"))) {
    return 1;
  }

  return 0;
}

_id_D518() {}

_id_FA81() {}

_id_D57E() {}

_id_FA9C() {}

_id_D5F6() {
  self giveweapon("iw7_fistsperk_mp");
  self _meth_8514("iw7_fistsperk_mp");

  if(self hasweapon("s4_me_fists_mp")) {
    var_0 = self getcurrentweapon();
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_me_fists_mp");
    self giveweapon("iw7_fistslethal_mp");

    if(var_0.basename == "s4_me_fists_mp") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("iw7_fistslethal_mp");

      if(isDefined(self._id_6DF0) && self._id_6DF0 && isDefined(self._id_E3A8) && self._id_E3A8.basename == "s4_me_fists_mp") {
        self._id_E3A8 = makeweapon("iw7_fistslethal_mp");
        self setspawnweapon(self._id_E3A8);
      }
    }
  }
}

_id_FABE() {
  scripts\cp_mp\utility\inventory_utility::_takeweapon("iw7_fistsperk_mp");

  if(self hasweapon("iw7_fistslethal_mp")) {
    var_0 = self._id_0133;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw7_fistslethal_mp");
    self giveweapon("s4_me_fists_mp");

    if(var_0.basename == "iw7_fistslethal_mp") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("s4_me_fists_mp");
    }
  }
}

_id_D686() {}

_id_FAD7() {}

_id_D589() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
  scripts\mp\killstreaks\killstreaks::_id_FD45();
  scripts\mp\killstreaks\killstreaks::_id_3561(self._id_EA13);
  scripts\mp\killstreaks\killstreaks::_id_FD47();
  self._id_74C6["assists"] = 0;
}

_id_10B78() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
}

_id_FAA0() {
  self._id_74C6 = undefined;
  self notify("perk_end_hardline");
}

_id_D62F() {}

_id_FACA() {}

_id_D62E() {
  self setclientomnvar("ui_overcharge", 1);
}

_id_FAC9() {
  self setclientomnvar("ui_overcharge", 0);
}

_id_D6FD() {
  thread _id_10B54();
}

_id_FB0B() {
  self notify("unsetSuperSprintEnhanced");
}

_id_10B54() {
  self endon("unsetSuperSprintEnhanced");
  self endon("disconnect");
  var_0 = 0;

  while(2000 > var_0) {
    waitframe();

    if(isDefined(self) && istrue(self _meth_86CF())) {
      var_1 = level._id_01E2;
      var_0 = var_0 + var_1;
    }
  }

  scripts\mp\gamelogic::_id_D58D(self, 1);
}

_id_D732() {}

_id_FB1D() {}

_id_D647() {}

_id_FACF() {}

_id_D515() {}

_id_FA7E() {}

_id_D544() {
  if(!scripts\mp\utility\game::_id_98D3()) {
    level._id_5561 = 1;
  }
}

_id_FA8A() {}

_id_D6AF() {}

_id_FAED() {}

_id_5A01(var_0, var_1, var_2, var_3) {}

_id_D5EC() {}

_id_FABA() {}

_id_D62D() {
  thread _id_ACEC();
}

_id_ACEC() {
  self endon("unsetOutlineKillstreak");
  self endon("disconnect");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = 1000000;

  if(level.gametype == "br") {
    var_0 = 1000;
  }

  if(isDefined(self)) {
    self _meth_8700("killstreak", var_0);
    self _meth_8700("air_killstreak", var_0);
    self._id_AFD5 = 1;
    _id_09DE::_id_1001D(self);
  }
}

_id_FAC8() {
  if(istrue(self._id_AFD5)) {
    self _meth_8701("killstreak");
    self _meth_8701("air_killstreak");
    self._id_AFD5 = undefined;
  }

  _id_09DE::_id_1001D(self);
  self notify("unsetOutlineKillstreak");
}

_id_D540() {
  thread _id_545F();
}

_id_545F() {
  self endon("unsetEngineer");
  self endon("disconnect");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = 1000000;

  if(level.gametype == "br") {
    var_0 = 1000;
  }

  if(isDefined(self)) {
    self _meth_8700("equipment", var_0);
    self._id_AFCC = 1;
  }
}

_id_FA88() {
  if(istrue(self._id_AFCC)) {
    self _meth_8701("equipment");
    self._id_AFCC = undefined;
  }

  self notify("unsetEngineer");
}

_id_D60F() {
  if(!isDefined(level._id_A5D3)) {
    level._id_A5D3 = [];
    level._id_A5D4 = [];
    level thread _id_BD78();
    level thread _id_BD79();
  }

  level._id_A5D3[level._id_A5D3.size] = self;
}

_id_FAC3() {
  level._id_A5D4[level._id_A5D4.size] = self;
}

_id_BD78() {
  level endon("game_ended");

  for(;;) {
    if(level._id_A5D3.size > 0) {
      var_0 = 0;

      while(isDefined(level._id_A5D3[var_0])) {
        level notify("set_noscopeoutline", level._id_A5D3[var_0]);
        level._id_A5D3[var_0] notify("set_noscopeoutline");
        var_0++;
        waitframe();
      }

      level._id_A5D3 = [];
      continue;
    }

    waitframe();
  }
}

_id_BD79() {
  level endon("game_ended");

  for(;;) {
    if(level._id_A5D4.size > 0) {
      var_0 = 0;

      while(isDefined(level._id_A5D4[var_0])) {
        level notify("unset_noscopeoutline", level._id_A5D4[var_0]);
        level._id_A5D4[var_0] notify("unset_noscopeoutline");
        var_0++;
        waitframe();
      }

      level._id_A5D4 = [];
      continue;
    }

    waitframe();
  }
}

_id_D4D4() {}

_id_FA6B() {}

_id_D8E4() {}

_id_FB24() {}

_id_D6B1() {}

_id_FAEF() {
  self notify("removeCombatHigh");
  self._id_E3FB = undefined;
}

_id_D5A8() {
  thread _id_CA42();
}

_id_FAA6() {}

_id_D5FF() {
  self._id_A0B8 = 0;
  scripts\mp\weapons::_id_FCCC();

  for(;;) {
    self waittill("killed_enemy");
    thread _id_A0B7();
  }
}

_id_FABF() {
  self notify("momentum_unset");
  self._id_A0B8 = undefined;
  scripts\mp\weapons::_id_FCCC();
}

_id_A0B7() {
  self._id_A0B8 = self._id_A0B8 + 0.04;
  self._id_A0B8 = min(self._id_A0B8, 0.12);
  scripts\mp\weapons::_id_FCCC();
  thread _id_A0B6();
}

_id_A0B6() {
  self notify("momentum_reset_speed");
  self endon("momentum_reset_speed");
  wait 5.0;
  self._id_A0B8 = 0;
  scripts\mp\weapons::_id_FCCC();
}

_id_D6B3() {}

_id_FAF1() {}

_id_D6DE() {}

_id_FB01() {
  foreach(var_1 in level.players) {
    var_1 notify("end_spawnview");
  }
}

_id_D58E(var_0) {}

_id_FAA3() {}

_id_D56F() {}

_id_FA97() {}

_id_D5B3() {}

_id_FAA9() {}

_id_D575() {
  thread _id_E6B4();
}

_id_FA9A() {
  thread _id_C4CB();
}

_id_D701() {
  self endon("disconnect");
  self waittill("equipKillstreaksFinished");

  if(!isDefined(self._id_E9FF._id_EA14[1])) {
    foreach(var_1 in self._id_E9FF._id_EA14["killstreaks"]) {
      var_1._id_50E6 = 0;
    }
  }
}

_id_FB0D() {
  self notify("end_support_killstreaks");
}

_id_D634() {
  self._id_AD6C = 0.98;
  scripts\mp\weapons::_id_FCCC();
}

_id_FACD() {
  self._id_AD6C = undefined;
}

_id_D4D5() {}

_id_FA6C() {}

_id_D6DB() {
  self._id_75B5 = 1;
}

_id_FB00() {
  self._id_75B5 = 1;
}

_id_D5B2() {}

_id_FAA8() {}

_id_D721() {}

_id_FB18() {}

_id_D463() {
  thread _id_CA1F();
  self setscriptablepartstate("heightened_senses", "default");
}

_id_CA1F() {
  self endon("death_or_disconnect");
  self endon("unsetADSAwareness");
  self._id_1FD3 = 256;
  self._id_1FD2 = 2.0;
  thread _id_1FD1();

  for(;;) {
    wait(self._id_1FD2);
    var_0 = scripts\common\utility::_id_B7BF(self.origin, self._id_1FD3);

    foreach(var_2 in level.players) {
      if(var_2.team == self.team) {
        continue;
      }
      if(var_2 scripts\mp\utility\perk::_hasperk("specialty_coldblooded")) {
        continue;
      }
      if(var_2 isonground() && !var_2 issprinting() && !var_2 _meth_8498() && !var_2 issprintsliding()) {
        continue;
      }
      thread _id_B854(var_2);
    }
  }
}

_id_B854(var_0) {
  self setscriptablepartstate("heightened_senses", "scrn_pulse");
  self playrumbleonentity("damage_heavy");
  var_0 playsoundtoplayer("ghost_senses_ping", self);
  wait 0.2;

  if(isDefined(self)) {
    self setscriptablepartstate("heightened_senses", "default");

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self playrumbleonentity("damage_heavy");

      if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_0 playsoundtoplayer("ghost_senses_ping", self);
      }
    }
  }
}

_id_1FD1() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getstance();
    var_1 = self getvelocity();

    switch (var_0) {
      case "stand":
        self._id_1FD3 = 400;
        self._id_1FD2 = 2.0;
        break;
      case "crouch":
        self._id_1FD3 = 650;
        self._id_1FD2 = 1.0;
        break;
      case "prone":
        self._id_1FD3 = 700;
        self._id_1FD2 = 0.5;
        break;
    }

    wait 0.01;
  }
}

_id_1FD0() {
  self endon("death_or_disconnect");
  self endon("stop_awareness");

  for(;;) {
    playsoundatpos(self.origin + (0, 0, 5), "ghost_senses_ping");
    wait 2.0;
  }
}

_id_FA4A() {
  self notify("unsetADSAwareness");
  self setscriptablepartstate("heightened_senses", "default");
}

_id_D698() {}

_id_FADE() {
  self._id_759F = undefined;
}

_id_D6D1() {
  self._id_75B3 = 1;
}

_id_FAFD() {
  self._id_75B3 = undefined;
}

_id_D723() {
  self giveweapon("s4_knifestab_mp");
  self _meth_8514("s4_knifestab_mp");
  thread _id_10C18();
}

_id_FB19() {
  self takeweapon("s4_knifestab_mp");
  self notify("specialty_equip_throwingKnife_end");
}

_id_10C18() {
  self endon("death_or_disconnect");
  self endon("equipment_taken_s4_throwing_knife_mp");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("offhand_fired", var_0);

    if(var_0.basename == "s4_throwing_knife_mp") {
      var_1 = scripts\mp\equipment::_id_6A0F("equip_throwing_knife");

      if(var_1 == 0) {
        self takeweapon("s4_knifestab_mp");
      }

      while(scripts\mp\equipment::_id_6A0F("equip_throwing_knife") == 0) {
        wait 0.05;
      }

      self giveweapon("s4_knifestab_mp");
      self _meth_8514("s4_knifestab_mp");
    }
  }
}

_id_D4A9() {
  self._id_2D31 = spawnStruct();
  self._id_2D31.player = self;
  self._id_2D31._id_535F = [];
  self._id_2D31._id_5416 = [];
  self._id_2D31._id_540F = [];
  self._id_2D31 thread _id_10A9F();
  self._id_2D31 thread _id_10AA0();
}

_id_FA64() {
  self notify("unsetBulletOutline");
  self._id_2D31 = undefined;
}

_id_10A9F() {
  self.player endon("death_or_disconnect");
  self.player endon("unsetBulletOutline");

  while(isDefined(self.player)) {
    var_0 = gettime();

    foreach(var_3, var_2 in self._id_535F) {
      if(!isDefined(var_2)) {
        _id_2D34(undefined, var_3);
        continue;
      }

      if(var_2 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
        _id_2D34(var_2, var_3);
        continue;
      }

      if(var_0 >= self._id_540F[var_3]) {
        _id_2D34(var_2, var_3);
      }
    }

    waitframe();
  }
}

_id_10AA0() {
  self.player scripts\engine\utility::waittill_any_2("disconnect", "unsetBulletOutline");

  foreach(var_2, var_1 in self._id_535F) {
    if(isDefined(var_1)) {
      _id_2D34(var_1, var_2);
    }
  }
}

_id_2D32(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_4 = gettime() + var_1 * 1000;
  self._id_535F[var_3] = var_0;

  if(!isDefined(self._id_5416[var_3])) {
    self._id_5416[var_3] = ::scripts\mp\utility\outline::outlineenableforplayer(var_0, self.player, "outline_depth_red", "perk");
  }

  if(!isDefined(self._id_540F[var_3]) || !isDefined(var_2) || var_2) {
    self._id_540F[var_3] = var_4;
  }
}

_id_2D34(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0 getentitynumber();
  }

  self._id_535F[var_1] = undefined;
  self._id_540F[var_1] = undefined;

  if(isDefined(var_0)) {
    scripts\mp\utility\outline::outlinedisable(self._id_5416[var_1], var_0);
  }

  self._id_5416[var_1] = undefined;
}

_id_2D33(var_0, var_1, var_2, var_3) {
  if(!(var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_EXPLOSIVE_BULLET")) {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_0) || !isPlayer(var_1)) {
    return;
  }
  var_4 = var_0;

  if(isDefined(var_0.owner)) {
    var_4 = var_0.owner;
  }

  var_5 = var_1;

  if(isDefined(var_1.owner)) {
    var_5 = var_1.owner;
  }

  if(!istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_4, var_5))) {
    return;
  }
  if(isPlayer(var_0) && isPlayer(var_1) && scripts\mp\utility\outline::_id_ACED(var_0 getEye(), var_1 getEye())) {
    return;
  }
  if(isDefined(var_0._id_2D31) && !var_1 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
    var_0._id_2D31 _id_2D32(var_1, 1);
  }

  if(isDefined(var_1._id_2D31) && !var_0 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
    var_1._id_2D31 _id_2D32(var_0, 2.0, 0);
  }
}

_id_9B41(var_0, var_1) {
  if(!isDefined(var_0._id_51B8)) {
    var_0._id_51B8 = [];
  }

  if(isDefined(var_0._id_51B8[var_1]) && var_0._id_51B8[var_1] == "active") {
    return;
  }
  var_0._id_51B8[var_1] = "active";
  thread _id_51CE(var_0, var_1);
  var_0 scripts\engine\utility::waittill_any_2("death", "cloak_end");
  var_0._id_51B8[var_1] = undefined;
}

_id_51CE(var_0, var_1) {
  var_2 = ["j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le"];
  var_0._id_51B8[var_1] = undefined;
}

_id_E6B4() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");

  if(isai(self)) {
    while(isDefined(self._id_1FAF) && self._id_1FAF > 0) {
      waitframe();
    }
  }

  if(level._id_9F3F == 0) {
    return;
  }
  if(level._id_F240 < 0.05) {
    return;
  }
  self._id_F273 = 0.0;
  thread _id_6EA8();
  self._id_F273 = 0.0;
  self _meth_854B(1);

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(scripts\mp\class::_id_8B0D(var_0)) {
      continue;
    }
    _id_4CCA();
  }
}

_id_4CCA() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");
  self _meth_854B(0);
  thread _id_3507();

  while(self._id_F273 < 3.0) {
    wait(level._id_F240);
    self._id_F273 = self._id_F273 + level._id_F240;
  }

  self notify("ghost_restored");
  self._id_F273 = 0.0;
  self _meth_854B(1);
}

_id_3507() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  self endon("ghost_restored");

  for(;;) {
    self waittill("weapon_fired");
    self._id_F273 = 0.0;
  }
}

_id_6EA8() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");

  for(;;) {
    if(isDefined(level._id_0F36) && isDefined(level._id_0F37)) {
      if(level.teambased) {
        if(isDefined(level._id_0F37[self.team])) {
          var_0 = level._id_0F36 - level._id_0F37[self.team] > 0;

          if(var_0) {
            self _meth_8735(1);
            self _meth_854B(0);

            while(var_0) {
              waitframe();
              var_0 = level._id_0F36 - level._id_0F37[self.team] > 0;
            }

            self _meth_854B(1);
            self _meth_8735(0);
          }
        }
      } else {
        foreach(var_2 in level.players) {
          if(var_2 == self) {
            continue;
          }
          if(istrue(level._id_0F37[var_2.guid]) && level._id_0F37[var_2.guid] > 0) {
            self _meth_8735(1);
            self _meth_854B(0);

            while(istrue(level._id_0F37[var_2.guid]) && level._id_0F37[var_2.guid] > 0) {
              level waittill("uav_update");
            }

            self _meth_854B(1);
            self _meth_8735(0);
          }
        }
      }
    }

    waitframe();
  }
}

_id_C4CB() {
  self notify("remove_gpsjammer");
  self _meth_854B(0);
  self _meth_8735(0);
}

_id_D580() {
  level._effect["groundPoundShield_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

_id_FA9E() {
  self notify("groundPoundShield_unset");
}

_id_71E4(var_0) {
  thread _id_71E6();
}

_id_71E6() {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundLand");
  wait 0.25;
  _id_71E5();
}

_id_71E5() {
  if(isDefined(self._id_71D7)) {
    thread _id_71DD(self._id_71D7);
  }

  var_0 = self.origin + anglesToForward(self.angles) * 5;
  var_1 = self.angles + (0, 90, 0);
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("weapon_shinguard_col_wm");
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel("weapon_shinguard_fr_wm");
  var_3._id_ACE5 = scripts\mp\utility\outline::_id_ACCF(var_3, "outline_nodepth_cyan", "equipment");
  var_4 = spawn("script_model", var_0);
  var_4.angles = var_1;
  var_4 setModel("weapon_shinguard_en_wm");
  var_4._id_ACE5 = scripts\mp\utility\outline::_id_ACCF(var_4, "outline_nodepth_orange", "equipment");
  var_2._id_10412 = var_3;
  var_2._id_10411 = var_4;
  var_2.owner = self;
  var_2 setCanDamage(1);
  var_2.health = 9999;
  var_2._id_D9DA = 210;
  self._id_71D7 = var_2;
  var_5 = level.characters;

  foreach(var_7 in var_5) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(level.teambased && var_7.team == self.team) {
      var_4 hidefromplayer(var_7);
      continue;
    }

    var_3 hidefromplayer(var_7);
  }

  thread _id_71E3(var_2);
  thread _id_71E0(var_2);
  thread _id_71E1(var_2, 3.25);
  thread _id_71DF(var_2);
  thread _id_71DB(var_2);
  thread _id_71E2(var_2);
  thread _id_71D5();
  return var_2;
}

_id_71DD(var_0) {
  self notify("groundPoundShield_end");

  if(!isDefined(var_0)) {
    return;
  }
  thread _id_71DE();
  thread _id_71DC(var_0);
}

_id_71D8(var_0) {
  self notify("groundPoundShield_end");

  if(!isDefined(var_0)) {
    return;
  }
  thread _id_71D9();
  thread _id_71DC(var_0);
}

_id_71E2(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_2)) {
      if(var_2 == self || var_2.team != self.team) {
        var_0._id_D9DA = var_0._id_D9DA - var_1;
      }
    }

    var_0.health = 9999;
    thread _id_71DA(var_2, var_4, var_3);

    if(var_0._id_D9DA <= 0) {
      thread _id_71D8(var_0);
      return;
    } else if(var_0._id_D9DA <= 105.0) {
      if(var_0._id_10412.model != "weapon_shinguard_dam_wm") {
        var_0._id_10412 setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\outline::_id_ACF9(var_0._id_10412);
      }

      if(var_0._id_10411.model != "weapon_shinguard_dam_wm") {
        var_0._id_10411 setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\outline::_id_ACF9(var_0._id_10411);
      }
    }
  }
}

_id_71DF(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  var_1 = self _meth_846A();
  var_2 = undefined;

  for(;;) {
    var_2 = var_1;
    var_1 = self _meth_846A();

    if(!var_2 && var_1) {
      thread _id_71DD(var_0);
      return;
    }

    waitframe();
  }
}

_id_71E1(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  wait(var_1);
  thread _id_71DD(var_0);
}

_id_71E0(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  while(isDefined(var_0)) {
    if(_func_0135(var_0.origin - self.origin) > 11664) {
      thread _id_71DD(var_0);
      return;
    }

    waitframe();
  }
}

_id_71DB(var_0) {
  self endon("groundPoundShield_deleteShield");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "groundPound_unset");
  thread _id_71DC(var_0);
}

_id_71E3(var_0) {}

_id_71DC(var_0) {
  self notify("groundPoundShield_deleteShield");
  scripts\mp\utility\outline::outlinedisable(var_0._id_10411._id_ACE5, var_0._id_10411);
  scripts\mp\utility\outline::outlinedisable(var_0._id_10412._id_ACE5, var_0._id_10412);
  var_0._id_10412 delete();
  var_0._id_10411 delete();
  var_0 delete();
}

_id_71D5() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

_id_71DE() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

_id_71DA(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  playFX(scripts\engine\utility::getfx("groundPoundShield_impact"), var_1, -1 * var_2);
  playsoundatpos(var_1, "ds_shield_impact");
  var_0 _id_07C4::_id_FC47("hitbulletstorm");
}

_id_71D9() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

_id_D581() {
  level._effect["groundPoundShock_impact_sm"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["groundPoundShock_impact_lrg"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

_id_FA9F() {
  self notify("groundPoundShock_unset");
}

_id_71E8(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShock_unset");
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "groundPoundLandTier0":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_1 = 144;
      break;
    case "groundPoundLandTier1":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_1 = 180;
      break;
    case "groundPoundLandTier2":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_lrg");
      var_1 = 216;
      break;
  }

  thread _id_71E9(var_1, var_2);
  var_3 = undefined;

  if(level.teambased) {
    var_3 = scripts\mp\utility\teams::_id_69FD(self.team, 1);
  } else {
    var_3 = level.characters;
  }

  var_4 = var_1 * var_1;
  var_5 = scripts\engine\trace::_id_3EE5(0, 1, 0, 0, 1, 0, 0);

  foreach(var_7 in var_3) {
    if(_func_0135(var_7 getEye() - self getEye()) > var_4) {
      continue;
    }
    var_8 = _func_02C1(self getEye(), var_7 getEye(), var_5, undefined, 0, "physicsquery_closest");

    if(isDefined(var_8) && var_8.size > 0) {
      continue;
    }
    thread _id_71E7(var_7);
  }
}

_id_71E7(var_0) {
  var_0 endon("death_or_disconnect");
  scripts\mp\gamescore::_id_F3FA(self, var_0, "groundpound_mp");
  wait 3;

  if(isDefined(self)) {
    scripts\mp\gamescore::_id_FB2C(self, var_0, "groundpound_mp");
  }
}

_id_71E9(var_0, var_1) {
  playFX(var_1, self.origin + (0, 0, 20), (0, 0, 1));
}

_id_D57F() {}

_id_FA9D() {
  self notify("groundPoundBoost_unset");
}

_id_71D6(var_0) {
  scripts\common\utility::_id_D1E7(self _meth_847F(0));
}

_id_D495() {
  level._effect["battleSlideShield_damage"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  thread _id_23A1();
}

_id_FA5A() {
  self notify("battleSlideShield_unset");
}

_id_23A1() {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self notify("battleSlideShield_monitor");
  self endon("battleSlideShield_monitor");

  for(;;) {
    self waittill("sprint_slide_begin");
    thread _id_23A3();
  }
}

_id_23A2(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");

  while(isDefined(var_0)) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread _id_2398(var_0, var_2, var_4, var_3);

    if(var_0.health <= 0) {
      thread _id_2396(var_0);
      var_0 delete();
      continue;
    }

    if(var_0.health <= 125.0) {
      if(var_0.model != "weapon_shinguard_dam_wm") {
        var_0 setModel("weapon_shinguard_dam_wm");
      }

      continue;
    }

    if(var_0.model != "weapon_shinguard_wm") {
      var_0 setModel("weapon_shinguard_wm");
    }
  }
}

_id_23A3() {
  if(isDefined(self._id_2395)) {
    thread _id_239D(self._id_2395);
  }

  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 setModel("weapon_shinguard_wm");
  var_0 setCanDamage(1);
  var_0.health = 250;
  var_0 linkto(self, "tag_origin", (30, 0, 0), (0, 90, 0));
  var_0 show();
  self._id_2395 = var_0;
  thread _id_239A(var_0);
  thread _id_239B(var_0);
  thread _id_239C(var_0);
  thread _id_23A6(var_0);
  thread _id_23A2(var_0);
  thread _id_2399(var_0);
  thread _id_23A4(var_0);
  return var_0;
}

_id_239D(var_0) {
  self notify("battleSlideShield_end");

  if(!isDefined(var_0)) {
    return;
  }
  thread _id_239E(var_0);
  var_0 delete();
}

_id_2399(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "battleSlide_unset");
  var_0 delete();
}

_id_239A(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");

  for(;;) {
    if(!self isonground()) {
      var_0 delete();
      self notify("battleSlideShield_end");
      return;
    }

    waitframe();
  }
}

_id_239B(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_begin");
  var_0 delete();
  self notify("battleSlideShield_end");
}

_id_239F(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  var_0 endon("death");

  for(;;) {
    if(_func_0135(var_0.origin - self.origin) > 11664) {
      thread _id_239D(var_0);
      return;
    }

    waitframe();
  }
}

_id_23A0(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  wait 3.5;
  thread _id_239D(var_0);
}

_id_23A5(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 unlink();
  self notify("battleSlideShield_unlink");
  thread _id_23A0(var_0);
  thread _id_239F(var_0);
  self notify("battleSlideShield_unlink");
}

_id_239C(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_slide_end");
  wait 0.75;
  var_0 delete();
  self notify("battleSlideShield_end");
}

_id_23A6(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_slide_end");

  for(;;) {
    if(_func_0135(self getvelocity()) < 100) {
      thread _id_23A5(var_0);
      return;
    }

    waitframe();
  }
}

_id_2396(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  thread _id_2397(var_0);
  self notify("battleSlideShield_end");
}

_id_23A4(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
}

_id_239E(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
}

_id_2398(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
  playFX(scripts\engine\utility::getfx("battleSlideShield_damage"), var_2, -1 * var_3);
  playsoundatpos(var_2, "ds_shield_impact");
  var_1 _id_07C4::_id_FC47("hitbulletstorm");
}

_id_2397(var_0) {}

_id_D494() {}

_id_FA59() {}

_id_6906() {
  return 100;
}

_id_D724() {
  level._effect["thrusterRadFr"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr");
  level._effect["thrusterRadEn"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en");
  _id_F1D7();
}

_id_FB1A() {
  if(isDefined(self._id_F1D8)) {
    self._id_F1D8 delete();
  }

  self notify("thruster_unset");
}

_id_F1D7() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");

  for(;;) {
    self waittill("doubleJumpBoostBegin");
    thread _id_F1D5();
    thread _id_F1D4();
  }
}

_id_F1D5() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");
  thread _id_F1D6();

  if(!isDefined(self._id_F1D8)) {
    self._id_F1D8 = spawn("script_model", self.origin);
    self._id_F1D8 setModel("tag_origin");
  } else
    self._id_F1D8.origin = self.origin;

  waitframe();

  for(;;) {
    self playrumbleonentity("damage_light");
    earthquake(0.1, 0.3, self.origin, 120);
    var_0 = _func_019A(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self._id_F1D8.origin = var_0;
    self._id_F1D8.angles = (90, 0, 0);
    waitframe();
    wait 0.33;
  }
}

_id_F1D4() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");

  for(;;) {
    _id_0A8B::_id_BF42(self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1);
    wait 0.05;
  }
}

_id_F1D6() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("doubleJumpBoostEnd", "thruster_unset");
  waitframe();
}

_id_CA42() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");

  for(;;) {
    if(self _meth_846B() && self playerads() > 0.3 && self _meth_847D(0) > 0) {
      _id_56ED();
      thread _id_10B84();
      self waittill("hover_ended");
      _id_5306();
    }

    wait 0.1;
  }
}

_id_10B84() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");

  while(self playerads() > 0.3) {
    waitframe();
  }

  self notify("hover_ended");
}

_id_56ED() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self._id_88AC = 1;
  self allowmovement(0);
  self allowjump(0);
  self playlocalsound("ghost_wall_attach");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self playerlinkto(var_0);
  thread _id_9A33(var_0);
}

_id_9A33(var_0) {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  var_1 = self _meth_8485(0);
  self _meth_8486(0, 1.0);
  wait 2;
  self notify("hover_ended");
  self _meth_8486(0, var_1);
  self _meth_847E(0, 0);
}

_id_5306() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self._id_88AC = undefined;
  self allowmovement(1);
  self allowjump(1);
  self playlocalsound("ghost_wall_detach");
  self unlink();
}

_id_D464() {}

_id_AFA8() {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");

  for(;;) {
    if(self playerads() > 0.5) {
      foreach(var_1 in level.players) {
        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
          continue;
        }
        if(var_1.team == self.team) {
          continue;
        }
        if(istrue(var_1._id_897A)) {
          continue;
        }
        if(istrue(var_1._id_87AC)) {
          continue;
        }
        var_1._id_87AC = 1;
        thread _id_AFA9(var_1);
        var_1 thread _id_AFA9(var_1);

        if(_id_AFA6(var_1)) {
          thread _id_AFA7(var_1);
          continue;
        }

        var_1._id_87AC = 0;
      }
    }

    wait 0.2;
  }
}

_id_AFA6(var_0) {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");
  var_1 = physics_createcontents(["physicscontents_playernosight", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_2 = distance(var_0.origin, self.origin);
  var_3 = 0;

  if(var_2 != 0) {
    var_3 = 1000 * (10 / var_2);
  }

  var_4 = var_0 getEye();

  if(var_0.team != self.team && (self _meth_845E(var_0.origin + (0, 0, 24), 90, var_3) || self _meth_845E(var_4, 90, var_3))) {
    var_5 = self getEye();
    var_6 = var_4;
    var_7 = _func_02C1(var_5, var_6, var_1, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size == 0) {
      return 1;
    }

    waitframe();
    var_6 = var_0.origin + (0, 0, 24);
    var_8 = _func_02C1(var_5, var_6, var_1, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_8) && var_8.size == 0) {
      return 1;
    }
  }

  return 0;
}

_id_AFA7(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  self endon("ADSTargetMarkUnset");
  var_1 = undefined;
  var_2 = getdvarfloat("#x37f3ccb78cfcb2272");

  if(scripts\mp\utility\perk::_hasperk("specialty_improved_target_mark")) {
    var_2 = var_2 * getdvarfloat("#x323fe09d60e43de73");
  }

  wait(var_2);

  if(self playerads() > 0.5 && _id_AFA6(var_0)) {
    var_3 = spawn("script_model", var_0.origin);

    if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
      var_4 = 0;
      var_5 = 5000;
      var_6 = 100;
    } else {
      var_4 = 1;
      var_5 = 5000;
      var_6 = 0;
    }

    var_7 = var_3 thread _id_078F::_id_D59B(_id_6B14(self.team), "icon_navbar_enemy", 35, var_4, var_5, var_6, undefined, 1);
    var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self, "outlinefill_nodepth_orange", "equipment");
    var_0 scripts\mp\utility\outline::_id_0C2E("outline_nodepth_orange", 0);
    var_0._id_897A = 1;
    thread _id_AFC7(var_7, var_3, var_1, var_0);
  } else
    var_0._id_87AC = 0;
}

_id_AFC7(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait 0.6;
  scripts\mp\utility\outline::outlinedisable(var_2, var_3);

  if(isDefined(var_3)) {
    var_3 scripts\mp\utility\outline::_id_0C2D();
  }

  var_4 = getdvarfloat("#x33dfc501672cfa32e");

  if(scripts\mp\utility\perk::_hasperk("specialty_improved_target_mark")) {
    var_4 = var_4 * getdvarfloat("#x36b87504ff491b356");
  }

  wait(var_4 - 0.6);
  _id_078F::_id_D593(var_0);
  var_1 delete();

  if(isDefined(var_3)) {
    var_3._id_897A = 0;
    var_3._id_87AC = 0;
  }

  self notify("adsmark_ended");
}

_id_6B14(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_AFA9(var_0) {
  scripts\engine\utility::waittill_any_2("ADSTargetMarkUnset", "death_or_disconnect");

  if(isDefined(var_0)) {
    var_0._id_87AC = 0;
  }
}

_id_FA4B() {
  self notify("ADSTargetMarkUnset");
}

_id_D5A5() {}

_id_FAA5() {}

_id_D482() {
  self._id_F33B = 0;
}

_id_FA50() {}

_id_D5D8() {}

_id_FAB4() {}

_id_D532() {
  _id_07C7::_id_15C9(self);
  _id_07CA::_id_FBFC(self, 1);
}

_id_FA83() {
  _id_07C7::_id_15C9(self);
}

_id_D533() {
  if(!isDefined(level._id_B7ED)) {
    level._id_B7ED = 1;
  } else {
    level._id_B7ED = level._id_B7ED + 1;
  }
}

_id_FA84() {
  level._id_B7ED = level._id_B7ED - 1;
}

_id_D8F3() {
  _id_FD8A();
}

_id_FB26() {
  _id_FD8A(1);
}

_id_FD8A(var_0) {
  if(!isDefined(self._id_10DA5)) {
    self._id_10DA5 = 0;
  }

  var_1 = -25;

  if(scripts\mp\utility\perk::_hasperk("specialty_worsenedgunkick") && !istrue(var_0)) {
    if(isDefined(self._id_0133)) {
      switch (self._id_0133.classname) {
        case "rifle":
          var_1 = -20;
          break;
        case "mg":
          var_1 = -20;
          break;
      }
    }
  } else
    var_1 = 0;

  if(var_1 != self._id_10DA5) {
    scripts\mp\utility\weapon::_id_D69A(-1 * self._id_10DA5);
    scripts\mp\utility\weapon::_id_D69A(var_1);
    self._id_10DA5 = var_1;
  }
}

_id_D5D3() {
  var_0 = undefined;

  if(isDefined(self.pers["killstreakToScorestreak_lifeId"]) && self.pers["killstreakToScorestreak_lifeId"] == self._id_936C) {
    var_0 = self.pers["killstreakToScorestreak"];
    self.pers["killstreakToScorestreak"] = undefined;
    self.pers["killstreakToScorestreak_lifeId"] = undefined;
  } else
    var_0 = _id_8DE9(self._id_EA13);

  scripts\mp\killstreaks\killstreaks::_id_FD45();
  scripts\mp\killstreaks\killstreaks::_id_D6F6(var_0);
  scripts\mp\killstreaks\killstreaks::_id_3561(self._id_EA13);
  scripts\mp\killstreaks\killstreaks::_id_FD47();
}

_id_FAB1() {
  self.pers["killstreakToScorestreak"] = self._id_EA13;
  self.pers["killstreakToScorestreak_lifeId"] = self._id_936C;
  var_0 = _id_8DEA(self._id_EA13);
  scripts\mp\killstreaks\killstreaks::_id_FD45();
  scripts\mp\killstreaks\killstreaks::_id_D6F6(var_0);
  scripts\mp\killstreaks\killstreaks::_id_3561(self._id_EA13);
  scripts\mp\killstreaks\killstreaks::_id_FD47();
}

_id_8DE9(var_0) {
  return var_0 * 125;
}

_id_8DEA(var_0) {
  return int(var_0 / 125);
}

_id_D4BD() {
  if(self._id_EA13 <= 0) {
    self.pers["canKillChain"] = 1;
  }
}

_id_FA69() {
  if(!istrue(level.gameended)) {
    self.pers["canKillChain"] = undefined;
  }
}

_id_D6BC() {
  if(getdvarint("#x3155ed9afd83eb598") == 1) {
    self setclientomnvar("ui_graverobber", 1);
  }
}

_id_FAF6() {
  self setclientomnvar("ui_graverobber", 0);
}

_id_D531() {
  self._id_141D = [];
  _id_07CA::_id_FBFB(self, 1);
}

_id_FA82() {
  foreach(var_1 in self._id_141D) {
    var_1 _id_07CA::_id_C46A(0);
  }

  self._id_141D = undefined;
  _id_07CA::_id_FBFB(self, 0);
}

_id_D6A8() {
  thread _id_BDDA();
}

_id_BDDA() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");

  if(!isDefined(self._id_BDD9)) {
    var_0 = spawnStruct();
    var_0._id_FEE7 = getdvarfloat("#x32c934f652434d3aa") * scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer");
    var_0._id_4143 = 0;
    var_0.owner = undefined;
    var_0._id_7C8C = "laststand_reviver";
    var_0.trigger = spawnStruct();
    var_0.trigger._id_7C8C = "laststand_reviver";
    self._id_BDD9 = var_0;
  }

  var_0 = self._id_BDD9;

  if(!isDefined(self._id_7888)) {
    self._id_7888 = [];
  }

  self._id_31BF = 1;

  if(isDefined(level._id_C7F4)) {
    foreach(var_3, var_2 in level._id_C7F4) {
      if(!isDefined(self._id_7888[var_3])) {
        var_2.trigger disableplayeruse(self);
        self._id_7888[var_3] = var_2.trigger;
      }
    }
  }

  foreach(var_3, var_2 in level._id_9089) {
    if(!isDefined(self._id_7888[var_3])) {
      var_2 disableplayeruse(self);
      self._id_7888[var_3] = var_2;
    }
  }

  for(;;) {
    var_5 = scripts\mp\utility\player::_id_6C5F(self.origin, 150, self.team, self);

    foreach(var_7 in var_5) {
      if(istrue(var_7.inlaststand) && !istrue(var_7._id_EA91) && !istrue(var_7._id_9070) && !istrue(var_7 scripts\mp\playerlogic::_id_690A()) && !isDefined(var_0.owner)) {
        thread _id_BDD8(var_7, var_0);
      }
    }

    if(isDefined(level._id_C7F4)) {
      foreach(var_10 in level._id_C7F4) {
        if(var_10._id_ADAE == self.team) {
          if(!istrue(var_10.trigger.owner scripts\mp\playerlogic::_id_690A()) && !isDefined(var_0.owner)) {
            if(distancesquared(var_10.trigger.origin, self.origin) <= 22500) {
              thread _id_BDD8(var_10.trigger.owner, var_0, var_10);
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

_id_BDD8(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_finished");
  var_0 scripts\mp\playerlogic::_id_D496(1);
  var_1.owner = var_0;
  var_1.trigger.owner = var_0;
  thread _id_10BEB(var_0, var_1, var_2);

  if(isDefined(var_2)) {
    var_2.trigger hide();
    var_2.trigger makeunusable();
    var_2 _id_081F::_id_C7F1(self, 1);
  } else if(isDefined(var_0._id_9088)) {
    var_0._id_9088 hide();
    var_0._id_9088 makeunusable();
  }

  var_0 notify("handle_revive_message");
  var_0 scripts\mp\utility\player::_freezecontrols(1);

  while(var_1._id_4143 < var_1._id_FEE7) {
    if(distancesquared(self.origin, var_0.origin) > 90000) {
      self notify("prox_revive_fail");
      return;
    }

    _id_07D6::_id_FD75(var_1, 1);
    var_1._id_4143 = var_1._id_4143 + level._id_5F3A;
    waitframe();
  }

  _id_07D6::_id_FD75(var_1, 0);
  var_0 _id_07D6::_id_FD75(var_1, 0);
  var_0 scripts\mp\utility\player::_freezecontrols(0);
  var_1._id_4143 = 0;
  var_1.owner = undefined;
  var_1.trigger.owner = undefined;

  if(istrue(var_0.inlaststand)) {
    var_0 notify("last_stand_revived");
  } else {
    var_2 _id_081F::_id_C7F2(self.team, self, 1, 1);
    var_2 _id_081F::_id_C7F0(self);
  }
}

_id_10BEB(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("last_stand_revived");
  var_0 endon("spawned_player");
  var_3 = var_0.team;
  scripts\engine\utility::_id_1088C(self, "death_or_disconnect", self, "unset_revive_use_weapon", self, "prox_revive_fail", var_0, "death_or_disconnect", var_0, "last_stand_finished");

  if(isDefined(var_2)) {
    var_2.trigger show();
    var_2.trigger makeuseable();
    var_2 _id_081F::_id_C7F2(var_3, self, 0, 1);
  }

  if(isDefined(var_0)) {
    var_0 scripts\mp\playerlogic::_id_D496(0);
    var_0 _id_07D6::_id_FD75(var_1, 0);
    var_0 scripts\mp\utility\player::_freezecontrols(0);

    if(isDefined(var_0._id_9088)) {
      var_0._id_9088 show();
      var_0._id_9088 makeuseable();
    }

    var_0 notify("handle_revive_message");
  }

  if(isDefined(self)) {
    var_1.owner = undefined;
    var_1.trigger.owner = undefined;
    var_1._id_4143 = 0;
    _id_07D6::_id_FD75(var_1, 0);
  }
}

_id_FAE9() {
  self notify("unset_revive_use_weapon");
  self._id_31BF = undefined;

  foreach(var_2, var_1 in self._id_7888) {
    if(isDefined(var_1) && var_1.owner != self) {
      var_1 showtoplayer(self);
      var_1 _meth_80E0(self);
    }
  }
}

_id_D5E6() {}

_id_FAB9() {}

_id_D6A6() {}

_id_FAE7() {}

_id_D46D() {
  scripts\mp\utility\player::_id_DCC4();
}

_id_FA4F() {
  scripts\mp\utility\player::_id_7908();
}

_id_EB47() {
  level._effect["super_sprint_refresh"] = loadfx("vfx/iw8_mp/perk/vfx_hustle.vfx");
  level._effect["super_sprint_refresh_night"] = loadfx("vfx/iw8_mp/perk/vfx_hustle_night.vfx");
}

_id_EB48() {
  self _meth_86CE();
}

_id_D574() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  _id_0A0D::_id_61A5();
}

_id_FA99() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  _id_0A0D::_id_61A5();
}

_id_D55C() {}

_id_FA92() {
  if(istrue(self._id_59BE)) {
    scripts\mp\utility\perk::removeperk("specialty_fastreload");
    self._id_59BE = undefined;
  }
}

_id_D69C() {
  self._id_C1B9 = 2;
}

_id_FAE0() {
  self._id_C1B9 = 1;
}

_id_C1B6() {
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_1 = self _meth_8632();
  var_2 = var_0 && !var_1;
  var_3 = scripts\engine\utility::ter_op(var_2, scripts\engine\utility::getfx("super_sprint_refresh_night"), scripts\engine\utility::getfx("super_sprint_refresh"));
  _func_019D(var_3, self, "tag_eye", self);
  thread _id_C1B5();
}

_id_C1B5() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("regenDelayReduce_delayedRegen");
  self endon("regenDelayReduce_delayedRegen");
  var_0 = gettime();

  while(var_0 + 140 > gettime()) {
    scripts\mp\healthoverlay::_id_C17C(10000);
    waitframe();
  }
}

_id_D69E() {
  _id_FD11();
  thread _id_A138();
}

_id_FAE2() {
  self notify("unsetReduceRegenDelayOnObjective");
  _id_FD11(1);
}

_id_A138() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unsetReduceRegenDelayOnObjective");

  for(;;) {
    wait 0.5;
    _id_FD11();
  }
}

_id_FD11(var_0) {
  var_1 = isDefined(self._id_32EC);
  var_2 = isDefined(self._id_F392) && self._id_F392.size > 0;
  var_3 = isDefined(self._id_FF0C) && self._id_FF0C.size > 0;
  var_4 = var_1 || var_2 || var_3;

  if(var_4 && !istrue(var_0)) {
    if(!istrue(self._id_8963)) {
      self._id_8963 = 1;
      scripts\mp\utility\perk::_id_6FC2("specialty_regen_delay_reduced");
    }
  } else if(istrue(self._id_8963)) {
    self._id_8963 = 0;
    scripts\mp\utility\perk::removeperk("specialty_regen_delay_reduced");
  }
}

_id_D699() {
  if(!isDefined(level._id_AFF5)) {
    return;
  }
  self notify("setRechargeEquipment");
  level._id_AFF5 = scripts\engine\utility::array_add(level._id_AFF5, self);
}

_id_FADF() {
  if(!isDefined(level._id_AFF5)) {
    return;
  }
  level._id_AFF5 = scripts\engine\utility::array_remove(level._id_AFF5, self);
  thread _id_C10A(self);
}

_id_C10F() {
  level._id_AFF5 = [];
  var_0 = int(_func_0037(0.5 / level._id_5F3A));

  for(;;) {
    var_1 = level._id_AFF5;
    var_2 = int(_func_0037(var_1.size / var_0));

    for(var_3 = 0; var_3 < var_0; var_3++) {
      for(var_4 = 0; var_4 < var_2; var_4++) {
        var_5 = var_3 * var_2 + var_4;

        if(var_5 > var_1.size) {
          break;
        }

        var_6 = var_1[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(!var_6 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_6.inlaststand) || istrue(self._id_EA91)) {
          continue;
        }
        _id_C10C(var_6);
      }

      waitframe();
    }
  }
}

_id_C10C(var_0) {
  if(!isDefined(var_0._id_C10E)) {
    var_0._id_C10E = spawnStruct();
    var_0._id_C10E._id_BD88 = [];
    var_0._id_C10E._id_C109 = [];
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_tactician")) {
    _id_C10B(var_0, "secondary");
  } else if(var_0 scripts\mp\utility\perk::_hasperk("specialty_van_demolition")) {
    _id_C10B(var_0, "primary");
  } else {
    _id_C10B(var_0, "primary");
    _id_C10B(var_0, "secondary");
  }

  _id_C10D(var_0);
}

_id_C10B(var_0, var_1) {
  var_2 = var_0._id_C10E;

  if(!isDefined(var_2._id_BD88[var_1])) {
    var_2._id_BD88[var_1] = 0;
  }

  var_2._id_C109[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::_id_69A4(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 scripts\mp\equipment::_id_6A0F(var_3);
  var_5 = var_0 scripts\mp\equipment::_id_6A12(var_3);
  var_6 = var_0 scripts\mp\equipment::_id_6A16(var_3);
  var_7 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "br", 0.01, 0.0166667);

  if(var_1 == "secondary" && var_4 < var_6 && var_6 > 1) {
    var_2._id_BD88[var_1] = var_2._id_BD88[var_1] + var_7;
  } else if(var_4 < var_6) {
    var_2._id_BD88[var_1] = var_2._id_BD88[var_1] + var_7;
  } else {
    var_2._id_BD88[var_1] = 0;
  }

  if(var_2._id_BD88[var_1] >= 1) {
    var_0 scripts\mp\equipment::_id_7DEE(var_1, 1);
    var_2._id_BD88[var_1] = 0;
    var_2._id_C109[var_1] = 1;
  }
}

_id_C10A(var_0) {
  var_0 endon("setRechargeEquipment");
  var_0 endon("disconnect");
  var_0._id_C10E = undefined;
  waitframe();
  _id_C10D(var_0);
}

_id_C10D(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0._id_C10E)) {
    var_0 scripts\mp\utility\stats::_id_8257("restockCount");
    var_4 = var_0._id_C10E;

    if(isDefined(var_4._id_BD88["primary"])) {
      var_1 = var_4._id_BD88["primary"];
    }

    if(isDefined(var_4._id_BD88["secondary"])) {
      var_2 = var_4._id_BD88["secondary"];
    }

    foreach(var_7, var_6 in var_4._id_C109) {
      if(var_7 == "primary") {
        var_3 = var_3 + 1;
        var_0 scripts\mp\utility\stats::_id_7DAE("restockCount", 1);
      }

      if(var_7 == "secondary") {
        var_3 = var_3 + 2;
        var_0 scripts\mp\utility\stats::_id_7DAE("restockCount", 1);
      }
    }
  }

  var_0 setclientomnvar("ui_lethal_recharge_progress", var_1);
  var_0 setclientomnvar("ui_tactical_recharge_progress", var_2);
  var_0 setclientomnvar("ui_recharge_notify", var_3);
  var_0 _meth_875A("primary", var_1);
  var_0 _meth_875A("secondary", var_2);
}

_id_9B4A() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  _id_07D1::_id_60C2("prematch_done");

  if(!isDefined(self._id_9B4C)) {
    self._id_9B4C = spawnStruct();
    self._id_9B4C._id_9B81 = 0;
    self._id_9B4C._id_9B7F = undefined;
    self._id_9B4C._id_9B3A = [];
    self._id_9B4C._id_9B36 = 0;
    self._id_9B4C._id_AEBA = [];
    self._id_9B4C._id_AEB9 = 0;
  }

  for(;;) {
    self waittill("marks_target_changed", var_0);
    var_1 = isDefined(var_0) && !isDefined(self._id_9B4C._id_9B7F);
    self._id_9B4C._id_9B7F = var_0;
    self._id_9B4C._id_9B81 = 0;

    if(var_1) {
      thread _id_9B4B();
    }
  }
}

_id_9B4B() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  var_0 = gettime();
  var_1 = 0;

  if(self _meth_8702("air_killstreak", self._id_9B4C._id_9B7F)) {
    var_1 = getdvarint("#x3d9f0a5437fab5010");
  } else if(self _meth_8702("killstreak", self._id_9B4C._id_9B7F)) {
    var_1 = getdvarint("#x39384b2bef03631db");
  } else if(self _meth_8702("equipment", self._id_9B4C._id_9B7F)) {
    var_1 = getdvarint("#x3a6eab37486ce3d7b");
  } else {}

  var_2 = var_1 * var_1;

  while(isDefined(self._id_9B4C._id_9B7F) && !istrue(self._id_888B)) {
    if(self _meth_8703(self._id_9B4C._id_9B7F)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self._id_9B4C._id_9B7F) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(self)) {
      break;
    }

    if(distancesquared(self.origin, self._id_9B4C._id_9B7F.origin) > var_2) {
      break;
    }

    if(isDefined(self._id_9B4C._id_9B7F.owner) && self._id_9B4C._id_9B7F.owner scripts\mp\utility\perk::_hasperk("specialty_armory")) {
      break;
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    self._id_9B4C._id_9B81 = self._id_9B4C._id_9B81 + var_4;

    if(!scripts\engine\utility::array_contains(self._id_9B4C._id_9B3A, self._id_9B4C._id_9B7F)) {
      if(scripts\mp\utility\player::_id_8989()) {
        var_5 = self._id_9B4C._id_9B36;
        var_6 = self._id_9B4C._id_9B3A[var_5];

        if(isDefined(var_6)) {
          var_6 _meth_8707(undefined);
          _id_ACE2(var_6);
        }

        if(level.teambased) {
          self._id_9B4C._id_9B7F _meth_8707(self.team);
        } else {
          self._id_9B4C._id_9B7F _meth_8707(self);
        }

        _id_ACE2(self._id_9B4C._id_9B7F);

        if(isDefined(self._id_9B4C._id_9B7F.weapon_name)) {
          scripts\mp\battlechatter_mp::calloutequipment(self._id_9B4C._id_9B7F.weapon_name);
        }

        if(level.teambased && _id_09DE::_id_10013(self._id_9B4C._id_9B7F)) {
          self._id_9B4C._id_9B7F._id_EF82 = self.team;
          var_7 = scripts\mp\utility\player::_id_6DC4(self._id_9B4C._id_9B7F._id_EF82);

          foreach(var_9 in var_7) {
            _id_09DE::_id_1001F(self._id_9B4C._id_9B7F, var_9);
          }
        }

        self._id_9B4C._id_9B3A[var_5] = self._id_9B4C._id_9B7F;
        self._id_9B4C._id_9B36 = (var_5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self._id_9B4C._id_AEBA, self._id_9B4C._id_9B7F)) {
          scripts\mp\killstreaks\killstreaks::_id_6FEC(1);
          self._id_9B4C._id_AEBA[self._id_9B4C._id_AEB9] = self._id_9B4C._id_9B7F;
          self._id_9B4C._id_AEB9++;
        } else
          scripts\mp\killstreaks\killstreaks::_id_6FEC(0);

        thread _id_F993(self._id_9B4C._id_9B7F);
        break;
      }
    }

    var_0 = var_3;
    waitframe();
  }

  if(!istrue(self._id_888B)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self._id_9B4C._id_9B7F = undefined;
  self._id_9B4C._id_9B81 = 0;
}

_id_F993(var_0) {
  level endon("game_ended");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  var_0 endon("death");
  var_1 = getdvarint("#x3310d3a0a2be69660");
  scripts\engine\utility::_id_108AE(var_1, "disconnect");
  _id_F995(var_0);
}

_id_F995(var_0) {
  var_0 _meth_8707(undefined);

  if(isDefined(var_0._id_EF82)) {
    if(level.teambased && _id_09DE::_id_10013(var_0)) {
      var_1 = scripts\mp\utility\player::_id_6DC4(var_0._id_EF82);

      foreach(var_3 in var_1) {
        _id_09DE::_id_1001F(var_0, var_3);
      }
    }

    var_0._id_EF82 = undefined;
  }

  if(isDefined(self)) {
    self._id_9B4C._id_9B3A = scripts\engine\utility::array_remove(self._id_9B4C._id_9B3A, var_0);
    var_0 notify("unmarkEnt_" + self getentitynumber());
  }
}

_id_D5F1() {
  if(!level.teambased) {
    return;
  }
  self _meth_870B();
  thread _id_9B4A();
}

_id_FABB() {
  if(!level.teambased) {
    return;
  }
  if(isDefined(self._id_9B4C)) {
    foreach(var_1 in self._id_9B4C._id_9B3A) {
      if(isDefined(var_1)) {
        _id_F995(var_1);
      }
    }
  }

  self._id_9B4C = undefined;
  self _meth_870C();
  self notify("mark_equip_ended");
}

_id_6958(var_0) {
  if(!isDefined(var_0)) {
    return [];
  }

  if(!isDefined(var_0._id_357A)) {
    return [var_0];
  }

  return var_0._id_357A;
}

_id_ACE1(var_0, var_1) {
  return level.players;
}

_id_ACE3(var_0) {
  return 1;
}

_id_ACE4(var_0) {
  if(!isDefined(var_0._id_6C5C)) {
    var_0._id_6C5C = ::_id_ACE1;
  }

  if(!isDefined(var_0._id_FF62)) {
    var_0._id_FF62 = ::_id_ACE3;
  }

  if(!isDefined(var_0._id_7B8A)) {
    var_0._id_7B8A = "spotter_notarget";
  }

  if(!isDefined(var_0._id_BD2C)) {
    var_0._id_BD2C = "perk";
  }

  if(!isDefined(var_0._id_10971)) {
    var_0._id_10971 = 0.1;
  }
}

_id_ACE2(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 getentitynumber();
    _id_ACDF(var_1);
    _id_ACE0(var_0);
  }
}

_id_ACE0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 getentitynumber();
  var_2 = self._id_550B[var_1];

  if(isDefined(var_2)) {
    return;
  }
  var_3 = undefined;

  if(self _meth_8703(var_0)) {
    var_3 = spawnStruct();
    var_3._id_BD2C = "perk_superior";
    var_3._id_7B8A = "spotter_target";
    _id_ACE4(var_3);
  }

  var_4 = self _meth_8703(var_0);

  if(self _meth_8702("air_killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3._id_BD2C = "perk_superior";
      var_3._id_7B8A = "spotter_target_killstreak_air";
    } else {
      var_3._id_BD2C = "perk";
      var_3._id_7B8A = "spotter_notarget_killstreak_air";
    }

    _id_ACE4(var_3);
  } else if(self _meth_8702("killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3._id_BD2C = "perk_superior";
      var_3._id_7B8A = "spotter_target_killstreak";
    } else {
      var_3._id_BD2C = "perk";
      var_3._id_7B8A = "spotter_notarget_killstreak";
    }

    _id_ACE4(var_3);
  } else if(self _meth_8702("equipment", var_0)) {
    var_3 = spawnStruct();

    if(var_4) {
      var_3._id_BD2C = "perk_superior";
      var_3._id_7B8A = "spotter_target_equipment";
    } else {
      var_3._id_BD2C = "perk";
      var_3._id_7B8A = "spotter_notarget_equipment";
    }

    _id_ACE4(var_3);
  }

  if(isDefined(var_3) && !(isDefined(var_0.owner) && var_0.owner scripts\mp\utility\perk::_hasperk("specialty_armory"))) {
    var_2 = spawnStruct();
    self._id_550B[var_1] = var_2;
    var_2._id_951C = [];
    var_2._id_5469 = var_0;
    var_5 = _id_6958(var_0);

    foreach(var_7 in var_5) {
      var_8 = scripts\mp\utility\outline::outlineenableforplayer(var_7, self, var_3._id_7B8A, var_3._id_BD2C);
      var_9 = spawnStruct();
      var_9._id_5469 = var_7;
      var_9._id_7C8C = var_8;
      var_10 = var_7 getentitynumber();
      var_2._id_951C[var_10] = var_9;
    }
  }
}

_id_ACDF(var_0) {
  if(isDefined(var_0)) {
    var_1 = self._id_550B[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1._id_951C) {
        scripts\mp\utility\outline::outlinedisable(var_3._id_7C8C, var_3._id_5469);
      }

      self._id_550B[var_0] = undefined;
    }
  }
}

_id_9B37(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = var_4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var_1, var_5)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_9B38() {
  self endon("disconnect");
  level endon("game_ended");
  self._id_550B = [];

  for(;;) {
    self waittill("marks_changed", var_0, var_1, var_2);

    if(isDefined(var_0)) {
      foreach(var_4 in var_0) {
        _id_ACDF(var_4);
      }

      if(isDefined(self._id_9B4C)) {
        self._id_9B4C._id_9B3A = _id_9B37(self._id_9B4C._id_9B3A, var_0);

        if(self._id_9B4C._id_9B36 > self._id_9B4C._id_9B3A.size) {
          self._id_9B4C._id_9B36 = self._id_9B4C._id_9B3A.size;
        }
      }
    }

    if(isDefined(var_1)) {
      foreach(var_7 in var_1) {
        _id_ACDF(var_7);
      }
    }

    if(isDefined(var_2)) {
      foreach(var_10 in var_2) {
        _id_ACE0(var_10);
      }
    }
  }
}

_id_D498() {
  self notify("cancel_better_mission_rewards_unset");
  self._id_7546 = 1;
  _id_FD56(self.team);
  thread _id_46C5();
}

_id_FA5B() {}

_id_46C5() {
  var_0 = self.team;
  self endon("cancel_better_mission_rewards_unset");
  scripts\engine\utility::waittill_any_2("spawned_player", "disconnect");

  if(isDefined(self)) {
    self._id_7546 = undefined;
  }

  _id_FD56(var_0);
}

_id_FD56(var_0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }
  var_1 = scripts\mp\gametypes\br_quest_util::_id_6C97(var_0);

  if(!isDefined(level._id_24D9)) {
    level._id_24D9 = [];
  }

  var_2 = 0;

  if(isDefined(level._id_24D9[var_0])) {
    var_2 = level._id_24D9[var_0];
  }

  var_3 = var_1 - var_2;

  if(var_3 != 0) {
    scripts\mp\gametypes\br_quest_util::_id_1119(var_0, var_3);
  }

  level._id_24D9[var_0] = var_1;
}

_id_D6DF() {
  self _meth_87A7(1);
  self setclientomnvar("ui_specialist_bonus_active", 1);
}

_id_FB02() {
  self _meth_87A7(0);
  self setclientomnvar("ui_specialist_bonus_active", 0);
}

setevasive() {
  self endon("end_specialty_evalsive");
  var_0 = 0;

  for(;;) {
    if((self issprintsliding() || self _meth_846A()) && var_0) {
      self _meth_86CE();
    }

    var_0 = self _meth_86CF() || self issprinting();
    waitframe();
  }
}

unsetevasive() {
  self notify("end_specialty_evalsive");
}