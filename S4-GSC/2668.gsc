/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2668.gsc
*************************************************/

_id_AFE0() {
  _id_AFE1();
  thread _id_AFE7();
  thread _id_AFD7();
}

_id_AFD7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  var_0 = 0;

  for(;;) {
    if(!self._id_AFEB._id_8AC4 && scripts\mp\supers::_id_8A7B()) {
      if(self._id_AFEB._id_8ABA) {
        _id_AFE6(1);

        if(1) {
          self._id_AFEB._id_EB09 = "super_select";
          scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 0, 1);

          if(isDefined(level._id_AFD8)) {
            [[level._id_AFD8]]();
          }
        }
      }

      if(var_0) {
        thread scripts\mp\supers::_id_DCEC();
      }
    }

    self waittill("super_ready", var_0);
  }
}

_id_AFE7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  var_0 = _id_AFDA();
  var_1 = _id_AFDC();
  var_2 = isDefined(self._id_EB09);
  var_3 = !isDefined(self._id_AFEB._id_5BE5) || self._id_AFEB._id_5BE5 != var_0;
  var_4 = !isDefined(self._id_AFEB._id_CFF2) || self._id_AFEB._id_CFF2 != var_1;

  if(!var_2 || var_3 || var_4 || self._id_AFEB._id_5EBB) {
    var_5 = scripts\mp\supers::_id_6DA1(var_0);
    self setclientomnvar("ui_perk_package_super1", var_5);
    var_6 = scripts\mp\supers::_id_6DA1(var_1);
    self setclientomnvar("ui_perk_package_super2", var_6);

    if(isDefined(scripts\mp\supers::getcurrentsuper())) {
      if(self._id_AFEB._id_5EBB) {
        scripts\mp\supers::_id_D6F8(0);
      } else {
        var_7 = scripts\mp\supers::_id_69AF();
        var_8 = var_7 - 0;
        var_8 = max(var_8, 0);
        scripts\mp\supers::_id_D6F8(var_8);
      }
    }

    if(var_0 == "none" && var_1 == "none") {
      self._id_AFEB._id_8ABA = 0;
      _id_AFE6(0);
      self._id_AFEB._id_EB09 = undefined;
      scripts\mp\supers::_id_3987();
    } else if(var_1 == "none") {
      self._id_AFEB._id_8ABA = 0;
      _id_AFE6(3);
      self._id_AFEB._id_EB09 = var_0;
      scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 1, 0);
    } else if(var_0 == "none") {
      self._id_AFEB._id_8ABA = 0;
      _id_AFE6(4);
      self._id_AFEB._id_EB09 = var_1;
      scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 1, 0);
    } else {
      self._id_AFEB._id_8ABA = 1;
      _id_AFE6(0);
      self._id_AFEB._id_EB09 = "super_select";
      scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 1, 0);
    }

    if(scripts\mp\supers::_id_8A7B()) {
      thread scripts\mp\supers::_id_DCEC();
    }

    self._id_AFEB._id_5EBB = 0;
    self._id_AFEB._id_5BE5 = var_0;
    self._id_AFEB._id_CFF2 = var_1;
  }
}

_id_AFE2() {
  if(!isDefined(self._id_AFEB)) {
    return 0;
  }

  if(self._id_AFEB._id_E747 != 1) {
    return 0;
  }

  return 1;
}

_id_AFE6(var_0) {
  self setclientomnvar("ui_perk_package_state", var_0);
  self._id_AFEB._id_E747 = var_0;
}

_id_AFDA() {
  var_0 = self._id_9674;

  if(isDefined(self._id_AD4E)) {
    var_0 = self._id_AD4E;
  }

  return var_0;
}

_id_AFDC() {
  var_0 = self._id_9675;

  if(isDefined(self._id_AD4F)) {
    var_0 = self._id_AD4F;
  }

  return var_0;
}

_id_AFE1() {
  self._id_AFEB = self.pers["perkPackageData"];

  if(!isDefined(self._id_AFEB)) {
    self._id_AFEB = spawnStruct();
    self._id_AFEB._id_E747 = 0;
    self._id_AFEB._id_5EBB = 0;
    self._id_AFEB._id_8AC4 = 0;
    self._id_AFEB._id_5BE5 = undefined;
    self._id_AFEB._id_CFF2 = undefined;
    self._id_AFEB._id_EB09 = "super_select";
    self._id_AFEB._id_8ABA = 0;
    self.pers["perkPackageData"] = self._id_AFEB;
    self setclientomnvar("ui_perk_package_state", self._id_AFEB._id_E747);
  }
}

_id_AFDB() {
  return "hud_icon_perk_blast_shield";
}

_id_AFE3() {
  var_0 = _id_AFED();
  var_1 = _id_AFE2();

  if(!var_0) {
    return 0;
  } else if(!var_1) {
    return 0;
  } else {
    thread _id_AFF1();
    self notify("perkPackage_endThink");
    return 1;
  }
}

_id_AFF1() {
  scripts\common\utility::_id_154F(0);
  scripts\common\utility::_id_1562(0);
  self notifyonplayercommand("perkPackageMenu_option1", "+smoke");
  self notifyonplayercommand("perkPackageMenu_option2", "+frag");
  thread _id_AFEE();
  var_0 = _id_AFF0();
  var_0 = istrue(var_0);

  if(isDefined(self)) {
    self notify("perkPackage_endMenuThink");

    if(isalive(self)) {
      self _meth_824C("perkPackageMenu_option1", "+smoke");
      self _meth_824C("perkPackageMenu_option2", "+frag");
      scripts\mp\supers::_id_EB50(0, 1);
      scripts\common\utility::_id_154F(1);
      scripts\common\utility::_id_1562(1);
    }

    if(var_0) {
      _id_AFD6();
    } else {
      self._id_AFEB._id_EB09 = "super_select";
      scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 0, 1);
    }
  }
}

_id_AFF0() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  _id_AFE6(2);
  wait 0.3;
  var_0 = scripts\engine\utility::_id_10899("perkPackageMenu_option1", "perkPackageMenu_option2", "perkPackageMenu_close", "death");
  var_1 = 0;

  if(var_0 == "perkPackageMenu_option1") {
    _id_AFE6(3);
    var_1 = 1;
  } else if(var_0 == "perkPackageMenu_option2") {
    _id_AFE6(4);
    var_1 = 1;
  } else {
    _id_AFE6(1);
    var_1 = 0;
    wait 0.3;
  }

  if(!_id_AFED()) {
    var_1 = 0;
  }

  return var_1;
}

_id_AFEE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  self endon("perkPackage_endMenuThink");

  for(;;) {
    if(!_id_AFED()) {
      self notify("perkPackageMenu_close");
    }

    wait 0.05;
  }
}

_id_AFED() {
  if(self useButtonPressed() || self attackButtonPressed() || self adsButtonPressed() || self meleeButtonPressed()) {
    return 0;
  }

  if(!scripts\common\utility::_id_86DB()) {
    return 0;
  }

  if(self isonladder()) {
    return 0;
  }

  return 1;
}

_id_AFD6() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  var_0 = undefined;

  if(self._id_AFEB._id_E747 == 3) {
    var_0 = _id_AFDA();
  } else if(self._id_AFEB._id_E747 == 4) {
    var_0 = _id_AFDC();
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0)) {
      var_1 = scripts\mp\supers::getcurrentsuper();

      if(!isDefined(var_1) || var_1._id_E76B._id_C189 != var_0) {
        self._id_AFEB._id_EB09 = var_0;
        scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 0, 1);

        if(1) {
          var_2 = _id_AFD9();

          if(!istrue(var_2)) {
            self notify("perkPackage_failed_super");
            return;
          }
        } else
          thread _id_AFEF(0.3);
      }
    }
  }
}

_id_AFD9() {
  thread _id_AFE9();
  var_0 = scripts\mp\supers::_id_69B0();
  var_1 = level._id_EB2B._id_E76D[var_0]._id_04F6;
  var_2 = makeweapon(var_1);
  thread _id_AFEF(0.3);
  var_3 = 0;

  if("s4_super_default_mp" != var_1) {
    self _meth_852A(var_2);
    var_3 = _id_AFE8(var_2);
  }

  if(istrue(var_3)) {
    var_4 = 0;
  } else {
    var_4 = scripts\mp\supers::_id_F760(var_2);
  }

  if(!istrue(var_4)) {
    _id_AFE6(1);
    self._id_AFEB._id_EB09 = "super_select";
    scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 0, 1);
  }

  return var_4;
}

_id_AFE9() {
  self endon("disconnect");
  self._id_AFEB._id_8AC4 = 1;
  _id_AFEA();
  self._id_AFEB._id_8AC4 = 0;
}

_id_AFEA() {
  level endon("game_ended");
  self endon("giveLoadout_start");
  self endon("perkPackage_failed_super");
  self waittill("super_use_finished");
}

_id_AFE8(var_0) {
  self endon("offhand_fired");
  var_1 = undefined;
  var_2 = gettime();

  for(;;) {
    var_3 = self getheldoffhand();

    if(isDefined(var_3) && var_3 == var_0) {
      var_1 = var_3;
      break;
    }

    var_4 = gettime();

    if(var_4 - var_2 > 400.0) {
      return 1;
    }

    wait 0.05;
  }

  for(;;) {
    var_3 = self getheldoffhand();

    if(!isDefined(var_3) || var_3 != var_1) {
      return 1;
    }

    wait 0.05;
  }
}

_id_AFEF(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  scripts\common\utility::_id_155E(0, "field_upgrade_pro");
  scripts\common\utility::_id_155F(0, "field_upgrade_pro");
  wait(var_0);
  scripts\common\utility::_id_155E(1, "field_upgrade_pro");
  scripts\common\utility::_id_155F(1, "field_upgrade_pro");
}

_id_AFDD(var_0) {
  _id_AFDE(var_0);
}

_id_AFDE(var_0) {
  _id_AFE1();
  self._id_AFEB._id_8ABA = 0;
  self._id_AFEB._id_EB09 = var_0;
  scripts\mp\supers::givesuper(self._id_AFEB._id_EB09, 0, 1);
}

_id_AFDF(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  self._id_AD4E = var_0;
  self._id_AD4F = var_1;
  _id_AFE7();
}

_id_AFE5() {
  self._id_AD4E = undefined;
  self._id_AD4F = undefined;
}

_id_AFE4() {
  self._id_AFEB._id_5EBB = 1;
  _id_AFE7();
}