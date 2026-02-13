/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2570.gsc
*************************************************/

_id_5A1B() {
  level._id_5A20 = [];
  level._effect["field_mic_destroyed"] = loadfx("vfx/s4/equipment/vfx_field_mic_damaged.vfx");
}

_id_5A15() {
  var_0 = 0;

  foreach(var_2 in level._id_5A20) {
    foreach(var_4 in var_2) {
      var_0++;

      if(var_0 > 200) {
        return 0;
      }
    }
  }

  return 1;
}

_id_5A16(var_0) {
  var_0 field_mic_give_to_owner(self);
  var_1 = getgroundposition(self.origin, 1);
  var_2 = spawn("script_model", var_1);
  var_0._id_5A22 = var_2;
  var_0._id_5A22.owner = self;
  var_0._id_5A22.team = self.team;
  var_0._id_5A22 setotherent(self);
  thread _id_084C::field_mic_plant(var_2);
  var_0 _meth_86FE("equipment");

  if(level.teambased) {
    var_0 _meth_8706(self.team);
  } else {
    var_0 _meth_8706(self);
  }

  var_0.owner = self;
  var_0._id_75E9 = var_0 thread _id_078F::_id_D594(0, 22);
  var_0 thread _id_07CD::_id_C33E(::_id_5A18, 1, 1);
  var_0 thread _id_5A17(self);
  var_0 thread field_mic_watch_for_disowned();
  var_0 thread field_mic_watch_lifetime();
  var_0 thread scripts\mp\equipment::equipmentwatchoob(::_id_5A18);
  var_0._id_5A22 _id_5A1E();
}

field_mic_watch_lifetime() {
  self endon("death");
  wait 30;
  _id_5A18();
}

field_mic_watch_for_disowned() {
  self endon("death");
  self._id_5A22.owner scripts\engine\utility::_id_10882("joined_team", "joined_spectators", "disconnect", "game_ended");
  _id_5A18();
}

_id_5A19() {}

_id_5A1F() {
  var_0 = self getentitynumber();

  if(!isDefined(level._id_5A20[var_0])) {
    return;
  }
  foreach(var_2 in level._id_5A20[var_0]) {
    var_2 _id_5A18();
  }
}

_id_5A17(var_0) {
  _id_07C3::_id_A0FF(100, "hitequip", ::_id_5A1A, ::_id_5A1C, 0);
}

_id_5A1C(var_0) {
  var_1 = var_0.objweapon;
  var_2 = var_0._id_9CD6;
  return _id_07C3::_id_7468(var_1, var_2, var_0.damage);
}

_id_5A1A(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 scripts\mp\battlechatter_mp::_id_555B(self);
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);
    var_2 = self.owner getentitynumber();

    if(level._id_5A20[var_2].size > 1) {
      self.owner thread _id_0A8D::_id_9137("fm_destroyed_m");
    } else {
      self.owner thread _id_0A8D::_id_9137("fm_destroyed_s");
    }
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.objweapon), var_0.objweapon, "");

  if(var_1.team != self.team && isDefined(self._id_014E) && self._id_014E >= self.maxhealth) {
    var_1 thread _id_07BC::createfieldupgradechallengeevent("destroy", var_3);
  }

  _id_5A18();
}

_id_5A18() {
  if(isDefined(self.owner)) {
    field_mic_remove_from_owner(self.owner);
  }

  _id_09B5::_id_781E();
  _id_078F::_id_D593(self._id_75E9);

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  if(isDefined(self._id_B7AB)) {
    self._id_B7AB delete();
  }

  if(isDefined(self._id_CC54)) {
    self._id_CC54 delete();
  }

  if(isDefined(self._id_5423)) {
    _id_07F9::_id_C799(self._id_5423);
  }

  if(isDefined(self._id_BE23) && self._id_BE23.size > 0) {
    foreach(var_1 in self._id_BE23) {
      var_1 notify("death");
    }
  }

  self setscriptablepartstate("hacked", "neutral", 0);
  self setscriptablepartstate("hack_usable", "off");
  thread _id_084C::field_mic_explode(self);
  playFX(level._effect["field_mic_destroyed"], self.origin);
  earthquake(0.5, 1, self.origin, 512);
  self._id_5A22 delete();
  self delete();
}

_id_5A1E() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  var_0 = 700;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_0 = 700;
  }

  var_1 = 0;

  for(;;) {
    _func_0251(self.origin, self.owner, var_0, 3000);
    wait 3;
  }
}

_id_5A1D(var_0) {
  field_mic_remove_from_owner(var_0);
  field_mic_give_to_owner(self.owner);
  self._id_5A22.owner = self.owner;
  self setscriptablepartstate("hacked", "active", 0);
}

field_mic_remove_from_owner(var_0) {
  var_1 = [];
  var_2 = var_0 getentitynumber();

  for(var_3 = 0; var_3 < level._id_5A20[var_2].size; var_3++) {
    var_4 = level._id_5A20[var_2][var_3];

    if(var_4 != self) {
      var_1[var_1.size] = var_4;
    }
  }

  level._id_5A20[var_2] = var_1;
  var_0.pers["fieldMicActive"] = 0;
}

field_mic_give_to_owner(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level._id_5A20[var_1])) {
    level._id_5A20[var_1] = [];
  }

  var_2 = level._id_5A20[var_1].size;

  if(var_2 + 1 > 2) {
    level._id_5A20[var_1][0] _id_5A18();
    var_2--;
  }

  level._id_5A20[var_1][var_2] = self;
  var_0.pers["fieldMicActive"] = 1;
}