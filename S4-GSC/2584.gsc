/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2584.gsc
*************************************************/

_id_ECFA() {
  level._id_ED0C = [];
  _id_0A97::_id_C28A(::_id_ECFE);

  if(scripts\mp\utility\game::getgametype() == "br") {
    level thread _id_ECF1();
  }
}

_id_ECFE(var_0) {
  foreach(var_2 in level._id_ED0C) {
    var_2 _id_ED06(var_0);
    var_2 _id_ED04(var_0);
  }
}

_id_ECF1() {
  level endon("game_ended");

  for(;;) {
    var_0 = level._id_ED0C;
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(istrue(var_3._id_87FB)) {
        continue;
      }
      if(!isDefined(var_3.owner)) {
        continue;
      }
      var_4 = distance2dsquared(var_3.origin, var_3.owner.origin);

      if(var_4 >= 144000000) {
        var_3.owner thread scripts\mp\hud_message::showsplash("tac_insert_fail_br_too_far");
        var_3 _id_ECF2(0);
      }

      var_1++;

      if(var_1 >= 5) {
        var_1 = 0;
        waitframe();
      }
    }

    waitframe();
  }
}

_id_ED00(var_0, var_1) {
  thread _id_ECFD();
}

_id_ED03(var_0, var_1) {
  self notify("end_monitorTIUse");
}

_id_ECFD() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");
  self._id_F296 = [];

  for(;;) {
    _id_ED07();
    var_0 = self getheldoffhand();
    var_1 = var_0.basename == "s4_hand_flare_mp";
    var_2 = scripts\engine\utility::ter_op(var_1, 0.05, 1.0);
    scripts\engine\utility::_id_108A7(var_2, "offhand_pullback");
  }
}

_id_ED07() {
  var_0 = self.origin;
  var_1 = _id_ECFB(var_0);

  if(istrue(var_1)) {
    _id_ECEE(var_0);
  }
}

_id_ECFB(var_0) {
  var_1 = var_0 + (0, 0, 3);

  if(!_func_0034(var_1)) {
    return 0;
  }

  if(scripts\mp\outofbounds::_id_8AAA()) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  waitframe();

  if(!self isonground()) {
    return 0;
  }

  return 1;
}

_id_ECEE(var_0) {
  var_1 = 0;
  var_2 = gettime() - self._id_904F;

  if(var_2 < 500) {
    var_1 = 1;
  }

  if(isDefined(self._id_F296[0]) && self._id_F296[0] == var_0 && !var_1) {
    return;
  }
  if(var_1) {
    self._id_F296[1] = var_0;
  } else {
    self._id_F296[1] = self._id_F296[0];
  }

  self._id_F296[0] = var_0;
}

_id_ECF7() {
  if(isDefined(self._id_F296)) {
    if(isDefined(self._id_F296[1])) {
      return self._id_F296[1];
    } else if(isDefined(self._id_F296[0])) {
      return self._id_F296[0];
    }
  }

  return undefined;
}

_id_4797() {
  _id_ECF2();
}

_id_ED08(var_0) {
  var_0 delete();
  var_1 = _id_ECF7();

  if(!isDefined(var_1)) {
    return 0;
  }

  if(scripts\mp\utility\entity::_id_F38F()) {
    return 0;
  }

  _id_E343(0, 0, 1);
  var_2 = var_1 + (0, 0, 16);
  var_3 = var_1 + (0, 0, -16);
  var_4 = [];
  var_4[0] = self;
  var_5 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 0, 0, 1);
  var_6 = scripts\engine\trace::_id_C051(var_2, var_3, var_4, var_5, 0);

  if(var_6["hittype"] == "hittype_none") {
    waitframe();
    var_7 = 14;
    var_6 = scripts\engine\trace::_id_E409(var_2, var_3, var_7, var_4, var_5, 0);
  }

  var_8 = var_6["normal"];
  var_9 = var_6["position"] + var_8 * (0, 0, 0.5);
  var_10 = var_6["entity"];
  self._id_EB09._id_15CC = 0;

  if(isDefined(var_10) && istrue(var_10._id_A1C0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/TAC_COVER_CANNOT_PLACE");
    }

    self._id_EB09._id_15CC = 1;
    return 0;
  }

  var_11 = anglesToForward(self.angles);
  var_12 = -1 * var_8;
  var_13 = scripts\engine\utility::_id_5CDB(var_11, var_8);
  var_14 = _func_025B(var_13, var_12);
  var_15 = _func_0017(var_12, var_14, var_13);
  var_16 = self.angles;
  var_17 = spawn("script_model", var_9);
  var_17.angles = var_15;
  var_17.team = self.team;
  var_17.owner = self;
  var_17 _id_078E::_id_C2B5(3, ::_id_4797);
  var_17 setModel("wm_tact_gen_handflare");
  var_17 setscriptablepartstate("smoke", "active", 0);
  var_17 _meth_8851(3, self.team);
  var_17._id_8A74 = isDefined(self._id_EB09) && self._id_EB09._id_E76B._id_04F6 == "s4_hand_flare_mp";
  var_17._id_EB31 = level._id_EB2B._id_E76D["super_tac_insert"]._id_7C8C;
  var_17 thread _id_ED01(self);
  var_17 thread _id_ECF3();
  var_17 thread scripts\mp\equipment::equipmentwatchoob(::_id_ECF2);
  var_17 setotherent(self);
  var_17.weapon_name = "tac_insert_trigger";
  var_17 _id_0812::_id_C2B2("Tactical_Static", self);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_tac_insert");
  scripts\mp\weapons::_id_AACF(var_17, "equip_tac_insert", ::_id_ECF2);
  thread scripts\mp\weapons::_id_A105(self, var_17);
  var_17 _id_078D::_id_D15E(::_id_ECF5);
  _id_E346(var_1, var_16, var_17, 1);
  var_18 = var_17 getentitynumber();
  level._id_ED0C[var_18] = var_17;
  return 1;
}

_id_ED01(var_0) {
  self._id_75E9 = thread _id_078F::_id_D594(0, 0);
  thread _id_ECEF(var_0);
  thread _id_ECF4(var_0);

  if(!self._id_8A74) {
    thread _id_ECFF(var_0);
  }
}

_id_ECEF(var_0) {
  _id_07C3::_id_A0FF(10, "hitequip", ::_id_ECFC, ::_id_ECF9, 1);
}

_id_ECFC(var_0) {
  var_1 = var_0.objweapon;
  var_2 = var_0._id_9CD6;
  return _id_07C3::_id_7468(var_1, var_2);
}

_id_ECF9(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    _id_ECF8(var_1);
    self.owner thread _id_0A8D::_id_9137("ti_destroyed");
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.objweapon), var_0.objweapon, "");

  if(var_1.team != self.team) {
    var_1 thread _id_07BC::createfieldupgradechallengeevent("destroy", var_2);
  }

  thread _id_ECF2(1);
}

_id_ECFF(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self._id_B0B5 = spawn("script_origin", self.origin);
  self._id_B0B5 makeuseable();
  self._id_B0B5 setcursorhint("HINT_NOICON");
  self._id_B0B5 sethintstring(&"MP_PATCH/PICKUP_TI");

  foreach(var_2 in level.players) {
    _id_ED06(var_2);
  }

  for(;;) {
    self._id_B0B5 waittill("trigger", var_2);
    var_2 playSound("iw8_tactical_insert_flare_pu");
    var_2 scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
    thread _id_ECF2(0, 0, 1);
  }
}

_id_ED06(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self) || !isDefined(self._id_B0B5)) {
    return;
  }
  if(istrue(self._id_87FB)) {
    return;
  }
  var_1 = isDefined(self.owner) && var_0 == self.owner;

  if(var_1) {
    self._id_B0B5 _meth_80E0(var_0);
  } else {
    self._id_B0B5 disableplayeruse(var_0);
  }
}

_id_ECF2(var_0, var_1, var_2) {
  if(istrue(self._id_87FB)) {
    return;
  }
  self._id_87FB = 1;
  _id_078F::_id_D593(self._id_75E9);
  self._id_75E9 = undefined;

  if(isDefined(self.owner)) {
    if(istrue(var_1)) {
      thread _id_ECED();
      self.owner scripts\mp\utility\stats::_id_7DAE("tacticalInsertionSpawns", 1);
      self.owner scripts\mp\supers::_id_3AC1("super_tac_insert");
      self.owner _id_07BC::_id_AAE7("super_tac_insert", 1);
      _id_07A9::_id_9768(self.owner, self._id_EB31, 1, istrue(var_0));
      self.owner.lifecycle_modifiers["tac_insert_spawn"] = 1;
    } else {
      self.owner _id_07BC::_id_AAE7("super_tac_insert", 0);
      _id_07A9::_id_9768(self.owner, self._id_EB31, 0, istrue(var_0));
    }

    if(!istrue(var_1) && !istrue(var_2)) {
      self.owner thread _id_ED02();
    }

    self.owner._id_D6DA = undefined;
  }

  self makeunusable();

  if(isDefined(self._id_B0B5)) {
    self._id_B0B5 delete();
  }

  self notify("death");
  self setscriptablepartstate("smoke", "neutral", 0);

  if(istrue(var_0)) {
    self setscriptablepartstate("destroy", "active", 0);
    self setscriptablepartstate("visibility", "hide", 0);
  }

  thread _id_ECF0();
}

_id_ED02() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 0;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::_id_88C7()) {
    var_0 = 1;
    waitframe();
  }

  if(var_0) {
    wait 0.3;
  }
}

_id_ECED() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }
  var_0 = self.owner;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  wait 1.5;
  var_0 thread scripts\mp\hud_message::showsplash("tac_insert_success_br");
}

_id_ECF3() {
  self endon("death");
  level waittill("game_ended");
  thread _id_ECF2(0, 0, 1);
}

_id_ECF0() {
  wait 1;
  _id_078E::_id_4807();
  self delete();
}

_id_ECF4(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self makeuseable();
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_PATCH/DESTROY_TI");

  foreach(var_2 in level.players) {
    _id_ED04(var_2);
  }

  for(;;) {
    self waittill("trigger", var_2);
    var_2 notify("destroyed_insertion", var_0);
    var_2 notify("destroyed_equipment");
    _id_ECF8(var_2);
    self.owner thread _id_0A8D::_id_9137("ti_destroyed");
    thread _id_ECF2(1);
  }
}

_id_ED04(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self._id_87FB)) {
    return;
  }
  var_1 = scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0);

  if(var_1) {
    self _meth_80E0(var_0);
  } else {
    self disableplayeruse(var_0);
  }
}

_id_ECF5(var_0) {
  var_1 = var_0.attacker;
  _id_ECF8(var_1);

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    self.owner thread _id_0A8D::_id_9137("ti_destroyed");
  }

  thread _id_ECF2(1);
}

_id_ECF8(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\killstreaks\killstreaks::_id_6FE6();
    var_0 scripts\mp\battlechatter_mp::_id_555B(self);
  }
}

_id_E346(var_0, var_1, var_2, var_3) {
  _id_E343();
  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = spawn("script_model", var_0);
  }

  var_4._id_B7D1 = var_0;
  var_4._id_B7CB = var_1;
  var_4._id_A6C0 = !istrue(var_3);
  var_4._id_8A74 = isDefined(var_2) && istrue(var_2._id_8A74);
  self._id_D6DA = var_4;
}

_id_E343(var_0, var_1, var_2) {
  if(isDefined(self._id_D6DA)) {
    if(istrue(self._id_D6DA._id_A6C0)) {
      self._id_D6DA delete();
    } else {
      self._id_D6DA _id_ECF2(var_0, var_1, var_2);
    }
  }
}