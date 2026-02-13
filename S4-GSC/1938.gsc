/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1938.gsc
*************************************************/

init(var_0) {
  var_1 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(var_1) {
    var_2 = getdvarint("#x334189a2d44de8a2a", 108);
  } else {
    var_2 = 180;
  }

  if(!isDefined(level._id_61D3)) {
    if(var_1) {
      level._id_61D3 = getdvarfloat("#x36d44f20b3e45108e", 0);
    } else {
      level._id_61D3 = 0.2;
    }
  }

  self._id_61D5 = var_2;

  if(isDefined(var_0)) {
    self._id_61D5 = var_0;
  }

  if(var_1) {
    level._id_61D6 = self._id_61D5 / 6;
  }

  level._id_61D7 = var_2;
  self setclientomnvar("ui_head_equip_class", 2);
  self setclientomnvar("ui_gasmask_damage", self._id_61D5 / var_2);
}

_id_BD65(var_0) {
  var_1 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  var_2 = self._id_61D5 / level._id_61D7;
  self._id_61D5 = self._id_61D5 - var_0;
  self._id_61D5 = max(0, self._id_61D5);

  if(var_1) {
    var_3 = (self._id_61D5 + 1) / level._id_61D7;
  } else {
    var_3 = self._id_61D5 / level._id_61D7;
  }

  self setclientomnvar("ui_gasmask_damage", var_3);

  if(self._id_61D5 <= 0) {
    if(var_1 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("gasmask", "breakGasMaskBR")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("gasmask", "breakGasMaskBR")]]();
    } else {
      _id_2B96();
    }
  } else if(var_1) {
    var_4 = floor(var_2 * 6 + 0.5);
    var_5 = floor(var_3 * 6 + 0.5);

    if(var_4 > var_5) {
      self playsoundtoplayer("br_gas_mask_crack_plr", self);
    }
  }

  if(!isDefined(self._id_61CC)) {
    self._id_61CC = 0;
  }

  self._id_61CC = self._id_61CC + var_0 * level._id_61D3;
  var_6 = floor(self._id_61CC);

  if(var_6 >= 1) {
    self dodamage(var_6, self.origin, self, undefined, "MOD_TRIGGER_HURT");
    self._id_61CC = self._id_61CC - var_6;
  }
}

_id_4970(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(!var_2) {
    return 0;
  }

  if(!isDefined(level._id_61D7)) {
    level._id_61D7 = getdvarint("#x334189a2d44de8a2a", 108);
  }

  var_3 = var_0 / level._id_61D7;
  var_4 = var_1 / level._id_61D7;
  var_5 = floor(var_3 * 6 + 0.5);
  var_6 = floor(var_4 * 6 + 0.5);
  return var_5 != var_6;
}

_id_554F() {
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  var_0 = makeweapon("none");
  var_1 = self getcurrentweapon();

  if(!issameweapon(var_1, var_0)) {
    self _meth_84AF("ges_visor_down");
  }

  self._id_61D9 = 1;
  wait 0.338;
  self._id_61D9 = 0;
  self._id_61D4 = 1;
  _id_09BE::_id_525B();
  self attach("hat_gasmask");
  _id_4029();

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "gasmask_female", 0.1);
  } else {
    self _meth_84A8("gender", "gasmask_male", 0.1);
  }
}

_id_C4C6() {
  self endon("death_or_disconnect");

  if(!istrue(self._id_61D4)) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_off_plr", self);
  var_0 = makeweapon("none");
  var_1 = self getcurrentweapon();

  if(!issameweapon(var_1, var_0)) {
    self _meth_84AF("ges_visor_up");
  }

  self._id_61D9 = 1;
  wait 0.521;
  self._id_61D9 = 0;
  self._id_61D4 = 0;
  _id_09BE::_id_4ACB();
  self detach("hat_gasmask");
  _id_485F();

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "female", 0.1);
  } else {
    self _meth_84A8("gender", "", 0.1);
  }
}

_id_2B96() {
  if(!istrue(self._id_61D4)) {
    return;
  }
  self._id_61D4 = 0;
  self playsoundtoplayer("br_gas_mask_crack_plr", self);
  self detach("hat_gasmask");
  _id_485F();

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "female", 0.1);
  } else {
    self _meth_84A8("gender", "", 0.1);
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
      self._id_61D5 = undefined;
    }
  }
}

_id_4029(var_0, var_1) {
  self._id_61D8 = newclienthudelem(self);
  self._id_61D8.x = 0;
  self._id_61D8.y = 0;
  self._id_61D8.alignx = "left";
  self._id_61D8.aligny = "top";
  self._id_61D8.horzalign = "fullscreen";
  self._id_61D8.vertalign = "fullscreen";
  self._id_61D8 setshader("gasmask_overlay_delta2", 640, 480);
  self._id_61D8.sort = -10;
  self._id_61D8.archived = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br" || self._id_88DF) {
      self._id_61D8.alpha = 0.0;

      if(isDefined(var_0)) {
        if(isDefined(var_1)) {
          wait(var_1);
        }

        if(isDefined(self._id_61D8)) {
          self._id_61D8 fadeovertime(var_0);
        }
      }
    }
  }

  if(isDefined(self._id_61D8)) {
    self._id_61D8.alpha = 1.0;
    self._id_61D8._id_0288 = 1;
  }
}

_id_D4A7() {
  if(isDefined(self._id_61D8)) {
    self._id_61D8 setshader("gasmask_overlay_delta2_broken", 640, 480);
  }
}

_id_58BE(var_0) {
  self._id_61D8.alpha = 1.0;
  self._id_61D8 fadeovertime(var_0);
  self._id_61D8.alpha = 0.0;
}

_id_485F(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self._id_61D8)) {
    return;
  }
  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      wait(var_1);
    }

    if(isDefined(self._id_61D8)) {
      _id_58BE(var_0);
      wait(var_0);
    }
  }

  if(isDefined(self._id_61D8)) {
    self._id_61D8 destroy();
    self._id_61D8 = undefined;
  }
}

_id_DCB2(var_0) {
  if(!var_0) {
    self._id_61D8.alpha = 0.0;
  } else {
    self._id_61D8.alpha = 1.0;
  }
}

_id_7567(var_0) {
  return isDefined(var_0._id_61D5);
}