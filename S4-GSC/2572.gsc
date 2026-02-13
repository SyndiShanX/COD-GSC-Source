/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2572.gsc
*************************************************/

_id_6006() {
  _id_6007();
  _id_6008();
  game["dialog"]["plunder_extract_fail_fulton"] = "plunder_plunder_extract_fail_fulton";
  level._effect["vfx_fulton_explode"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_fulton_destr.vfx");
}

_id_6007() {}

_id_6008() {
  var_0 = scripts\mp\gametypes\br_plunder::_id_B934("equip_mp_fulton", 1);
  var_0.type = 0;
  var_0._id_FEE7 = getdvarfloat("#x382529814632cf175", 0.75);
  var_0._id_FE6A = 2;
  var_0._id_FE68 = getdvarint("#x3c4e79476033650d8", 250);
  var_0._id_EFB6 = 1;
  var_0._id_EF60 = 1;
  var_0._id_FE6C = "MP/CANNOT_DEPOSIT_CASH_BALLOON_FULL";
  var_0._id_FE6D = "MP/CANNOT_DEPOSIT_CASH_BALLOON_LEAVING";
  var_0._id_CF2F = "fulton_use_cache";
  var_0._id_CF30 = "usable";
  var_0._id_CF23 = "unusable";
  var_0._id_5815 = getdvarint("#x370797f2a31754420", 20);
  var_0._id_5816 = "MP/CASH_BALLOON_LEAVING_IN_N";
  var_0._id_3212 = getdvarint("#x3f8c79d10ee6d5ac9", 1500);
  var_0._id_3D9A = ::_id_6011;
  var_0._id_5814 = ::_id_6012;
  var_0._id_1D56 = ::_id_6010;
  var_0._id_5838 = "fulton";
  var_0._id_5051 = getdvarint("#x31e193ad13ee04d6e", 1) > 0;
  var_0._id_31EF = getdvarint("#x32a6e545e97e778b3", 1) > 0;
}

_id_5FFE(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("military_skyhook_far_mp");
  var_1.angles = var_0.angles;
  var_1.owner = self;
  var_1.team = self.team;
  var_1._id_18AF = "fulton";
  var_1 _id_06C6::_id_D47B();
  self._id_5FFC = var_1;
  var_1 thread _id_600E();
}

_id_6000(var_0) {
  var_1 = scripts\mp\gametypes\br_plunder::_id_B934("equip_mp_fulton");
  thread scripts\mp\gametypes\br::_id_EFAD("br_fulton_balloon_shot_down", self.owner, self.team);
  scripts\mp\gametypes\br_plunder::_id_550D(var_1._id_5051);
  playFX(scripts\engine\utility::getfx("vfx_fulton_explode"), self.origin, anglesToForward(self.angles));
  playsoundatpos(self.origin, "br_fulton_extract_exp");
  thread _id_5FFF();
}

_id_5FFF() {
  self notify("death");

  if(isDefined(self.owner)) {
    self.owner._id_5FFC = undefined;
  }

  self hide();
  _id_07C3::_id_A100();
  self setscriptablepartstate("fulton_use_cache", "unusable", 0);
  self setscriptablepartstate("fulton_use_extract", "unusable", 0);
  self setscriptablepartstate("effects", "neutral", 0);
  scripts\mp\gametypes\br_plunder::_id_B930(self);
  self _meth_83EC();

  if(isDefined(self._id_CBD0)) {
    self._id_CBD0 delete();
  }

  waitframe();

  if(isDefined(self)) {
    self delete();
  }
}

_id_6014(var_0) {
  self endon("death_or_disconnect");

  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_0 waittill("missile_stuck", var_1);

  if(isDefined(var_1)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::_id_DCA2("MP/CASH_BALLOON_CANNOT_PLACE");

    if(isDefined(self._id_EB09)) {
      _id_600F();
    }

    var_0 delete();
    return;
  }

  if(!_id_5FFD(var_0)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::_id_DCA2("MP/CASH_BALLOON_BLOCKED");

    if(isDefined(self._id_EB09)) {
      _id_600F();
    }

    var_0 delete();
    return;
  } else if(1 && isDefined(self._id_5FFC)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::_id_DCA2("MP/CASH_BALLOON_TOO_MANY");

    if(isDefined(self._id_EB09)) {
      _id_600F();
    }

    var_0 delete();
    return;
  }

  if(isDefined(self._id_EB09)) {
    scripts\mp\supers::_id_EB50(undefined, undefined, undefined, 1);
  }

  thread _id_5FFE(var_0);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_600E() {
  self endon("death");
  self endon("start_extract");
  playsoundatpos(self.origin, "fulton_bag_drop");
  thread scripts\mp\gametypes\br::_id_EFAD("br_fulton_device_placed", self.owner, self.team);
  var_0 = scripts\mp\utility\teams::_id_6A59(self.team);
  scripts\mp\gametypes\br_plunder::_id_B93D(self, "equip_mp_fulton");
  thread scripts\mp\gametypes\br_plunder::_id_B94A(self, var_0);
  scripts\mp\gametypes\br_plunder::_id_B950(self, var_0);
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1.angles = self.angles * (0, 1, 0);
  var_1._id_5FFC = self;
  self._id_CBD0 = var_1;
  _id_600C();
  var_2 = scripts\mp\gametypes\br_plunder::_id_B934("equip_mp_fulton", 1);

  if(var_2._id_31EF) {
    thread _id_07C3::_id_A0FF(500, "", ::_id_6005, ::_id_6004);
  }
}

_id_600C() {
  self setscriptablepartstate("effects", "fillUp", 0);
  self._id_CBD0 _id_06C6::_id_1845(self, "fulton_open");
  childthread _id_600D();
}

_id_600D() {
  for(;;) {
    self._id_CBD0 _id_06C6::_id_1845(self, "fulton_open_idle");
  }
}

_id_6004(var_0) {
  var_1 = var_0.damage;

  if(!istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_0.attacker, self.owner))) {
    var_1 = 0;
  } else {
    var_1 = _id_07C3::_id_7492(var_0.objweapon, var_0._id_9CD6, var_0.damage);
    var_2 = undefined;

    if(var_0._id_9CD6 == "MOD_MELEE") {
      var_1 = int(_func_0037(self.maxhealth / 6));
    } else if(_func_010F(var_0._id_9CD6)) {
      if(var_0.damage >= 50) {
        var_1 = int(_func_0037(self.maxhealth / 2));
      }
    }
  }

  return var_1;
}

_id_6005(var_0) {
  thread _id_6000(var_0);
}

_id_6013(var_0, var_1, var_2) {
  var_3 = scripts\mp\gametypes\br_plunder::_id_B934("equip_mp_fulton");
  var_1 thread scripts\mp\gametypes\br_plunder::_id_B74D(var_2, var_3._id_FE6A, var_0);
}

_id_6011(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0.owner._id_5FFC = undefined;
  }

  scripts\mp\gametypes\br_plunder::_id_B943(var_0);
}

_id_6012(var_0) {
  var_0 endon("death");
  var_1 = scripts\mp\gametypes\br_plunder::_id_B934("equip_mp_fulton");
  var_2 = undefined;
  var_0 _id_07C3::_id_A100();
  var_2 = scripts\mp\gametypes\br_plunder::_id_550C();
  thread scripts\mp\gametypes\br::_id_EFAD("br_fulton_balloon_successfully_away", self.owner, self.team);
  self notify("fulton_takeoff");
  self _meth_827E("br_fulton_balloon_away");
  self._id_CBD0 _id_06C6::_id_1845(self, "fulton_takeoff");
  thread _id_5FFF();
}

_id_6010(var_0) {
  thread scripts\mp\gametypes\br::_id_EFAD("br_fulton_balloon_full", var_0.owner, var_0.team);
}

_id_5FFD(var_0) {
  if(scripts\mp\gametypes\br_public::_id_8805()) {
    return 1;
  }

  var_1 = 25;
  var_2 = _id_0797::_id_693D();
  var_3 = var_0.origin + (0, 0, var_1 + 1);
  var_4 = (var_0.origin[0], var_0.origin[1], var_2);
  var_5 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);
  var_6 = scripts\engine\trace::_id_E409(var_3, var_4, var_1, var_0, var_5);
  return var_6["fraction"] == 1.0;
}

_id_600F() {
  self setweaponammoclip(self._id_EB09._id_E76B._id_04F6, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  var_0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::_id_D6FB(0);
  scripts\mp\supers::_id_D6F9(0);
  var_0._id_10A1D = 1;
  scripts\mp\supers::_id_D6F8(scripts\mp\supers::_id_6DA3());
}