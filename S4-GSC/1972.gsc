/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1972.gsc
*************************************************/

init() {
  level._id_2961 = [];
  level._effect["vfx_mo_money_cash_exp"] = loadfx("vfx/iw7/_requests/mp/vfx_mo_money_cash_exp.vfx");

  if(1) {
    thread onplayerconnect();
    _id_0A8E::_id_C285(::_id_AB63);
    _id_0A97::_id_C28A(::_id_AB69);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 _id_2965();
  }
}

_id_2965() {
  if(!isDefined(self._id_2966)) {
    _id_B761();
    _id_B766();
    _id_B767();
  }
}

_id_AB63(var_0) {
  if(isDefined(var_0._id_2961)) {
    level._id_2961[var_0._id_2961] = undefined;
  }
}

_id_AB68(var_0) {
  if(1) {
    if(isDefined(var_0._id_2961)) {
      var_0 _id_B766();
      var_0 _id_B767();
    }
  }
}

_id_AB69(var_0) {
  if(1) {
    if(isDefined(var_0._id_2961)) {
      var_0 _id_B766();
      var_0 _id_B767();
    }
  }
}

_id_B761() {
  for(var_0 = 0; isDefined(level._id_2961[var_0]); var_0++) {}

  level._id_2961[var_0] = self;
  self._id_2961 = var_0;
}

_id_B6B6() {
  return self._id_2966;
}

_id_B79E(var_0) {
  self._id_2966 = var_0;
  level._id_2961[self._id_2961] _meth_81DA(self._id_2966);
}

_id_B766(var_0) {
  if(!1) {
    return;
  }
  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(isDefined(self)) {
    _id_B79E(0);
  }
}

_id_B767(var_0) {
  if(!1) {
    return;
  }
  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(isDefined(self)) {
    self._id_2967 = 0;
  }
}

_id_2964(var_0) {
  if(!1) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_2967 = self._id_2967 + var_0;
  _id_2963();
}

_id_2963() {
  if(!1) {
    return;
  }
  var_0 = _id_B6B6();
  var_1 = int(floor(self._id_2967 / 3));

  if(var_1 > var_0 && var_1 <= 5) {
    _id_B79E(var_1);
  }
}

_id_2962(var_0, var_1) {
  if(!1) {
    return;
  }
  if(scripts\mp\utility\perk::_hasperk("specialty_bounty")) {
    if(var_0 > 0) {
      for(var_2 = 0; var_2 < var_0; var_2++) {
        thread _id_0A9F::_id_7003("bounty");
        _id_2964();
        playFX(scripts\engine\utility::getfx("vfx_mo_money_cash_exp"), var_1 + (0, 0, 45));
      }

      thread scripts\mp\hud_util::_id_EF8D("callout_bounty_collected", self);
    }
  }
}