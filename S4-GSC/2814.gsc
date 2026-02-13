/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2814.gsc
*************************************************/

main() {
  self endon("death");
  self endon("killanimscript");
  self._id_012F endon("disconnect");
  var_0 = self._id_012F.origin - self.origin;
  var_1 = length(var_0);
  var_2 = 1;

  if(var_1 < self._id_1DF5) {
    var_3 = self.origin;
    var_2 = 0;
  } else {
    var_0 = var_0 / var_1;
    var_3 = self._id_012F.origin - var_0 * self._id_1DF5;
  }

  var_4 = 0;
  var_5 = self.origin + (0, 0, 30);
  var_6 = self._id_012F.origin + (0, 0, 30);
  var_7 = _func_0198(var_5, var_6);

  if(distancesquared(var_7, var_6) > 1) {
    _id_9D85();
  } else {
    if(var_2) {
      var_8 = _id_06E0::_id_3199(self.origin, var_3);
    } else {
      var_8 = 1;
    }

    var_9 = undefined;

    if(!var_8) {
      var_10 = 0;
    } else {
      var_9 = _id_DB30(self._id_012F);
      var_10 = isDefined(var_9);
    }

    self._id_2596 = 1;

    if(var_10) {
      _id_4C84(var_9);
      return;
    }

    _id_4E7E(var_3, var_8);
  }
}

_id_0191() {
  self _meth_82BA(1, 1);
  self._id_2596 = 0;
}

_id_6B51() {
  return "attack_run_and_jump";
}

_id_DB30(var_0) {
  if(!self._id_5253) {
    return undefined;
  }

  var_1 = 4;
  var_2 = self.origin - var_0.origin;

  if(abs(var_2[2]) > var_1) {
    return undefined;
  }

  var_3 = vectornormalize((var_2[0], var_2[1], 0));
  var_4 = anglesToForward(var_0.angles);
  var_5 = vectordot(var_4, var_3);

  if(var_5 > 0.707) {
    var_6 = 0;
    var_7 = rotatevector((1, 0, 0), var_0.angles);
  } else if(var_5 < -0.707) {
    var_6 = 1;
    var_7 = rotatevector((-1, 0, 0), var_0.angles);
  } else {
    var_8 = _id_0B00::_id_4094(var_2, var_4);

    if(var_8 > 0) {
      var_6 = 3;
      var_7 = rotatevector((0, -1, 0), var_0.angles);
    } else {
      var_6 = 2;
      var_7 = rotatevector((0, 1, 0), var_0.angles);
    }
  }

  if(var_6 == 1) {
    var_9 = 128;
  } else {
    var_9 = 96;
  }

  var_10 = var_0.origin - var_9 * var_7;
  var_11 = _id_06E0::_id_5056(var_10);

  if(!isDefined(var_11)) {
    return undefined;
  }

  if(abs(var_11[2] - var_10[2]) > var_1) {
    return undefined;
  }

  if(!scripts\engine\trace::_id_12F4(var_0.origin + (0, 0, 4), var_11 + (0, 0, 4), undefined, self, scripts\engine\trace::_id_3F70(1))) {
    return undefined;
  }

  return var_6;
}

_id_4C84(var_0) {
  var_1 = "attack_extended";
  _id_4D17(self._id_012F, self._id_012F.health, "MOD_MELEE_DOG");
  var_2 = self _meth_810C(var_1, var_0);
  thread _id_57F9(var_2, self._id_012F.origin, self._id_012F.angles);

  if(var_0 == 1) {
    self _meth_827E(scripts\engine\utility::ter_op(self._id_252B, "mp_wolf_attack_quick_back_npc", "mp_dog_attack_quick_back_npc"));
  } else {
    self _meth_827E(scripts\engine\utility::ter_op(self._id_252B, "mp_wolf_attack_short_npc", "mp_dog_attack_short_npc"));
  }

  _id_0017::_id_B356(var_1, var_0, "attack", "end");
  self notify("kill_stick");
  self._id_012F = undefined;
  self _meth_82B9("anim deltas");
  self unlink();
}

_id_57F9(var_0, var_1, var_2) {
  self endon("death");
  self endon("killanimscript");
  self endon("kill_stick");
  wait 0.05;

  if(isalive(self._id_012F)) {
    return;
  }
  var_3 = self._id_012F _meth_8122();
  self linkto(var_3);
  self _meth_82B4(var_0, var_1, var_2);
}

_id_4E7E(var_0, var_1) {
  var_2 = _id_6B51();
  self notsolid();
  var_3 = 0;

  if(!var_1) {
    if(self _meth_8006(self._id_012F)) {
      var_4 = _id_06E0::_id_5056(self._id_012F.origin);

      if(isDefined(var_4)) {
        var_3 = 1;
        var_0 = var_4;
      } else {
        _id_9D85();
        return;
      }
    } else {
      _id_9D85();
      return;
    }
  }

  self._id_9011 = undefined;
  self._id_9012 = undefined;
  var_5 = self _meth_810C(var_2, 0);
  var_6 = _func_0079(var_5);
  var_7 = _func_00BB(var_5, "dog_melee");

  if(var_7.size > 0) {
    var_8 = var_7[0] * var_6;
  } else {
    var_8 = var_6;
  }

  self _meth_82B3(self.origin, var_0, var_8);
  thread _id_FCA8(self._id_012F, var_8, var_1);
  _id_0017::_id_B356(var_2, 0, "attack", "finish");
  self notify("cancel_updatelerppos");
  var_9 = 0;

  if(isDefined(self._id_012F)) {
    var_9 = self._id_012F.health;
  }

  if(isDefined(self._id_9D7E)) {
    var_9 = self._id_9D7E;
  }

  if(isDefined(self._id_012F)) {
    _id_4D17(self._id_012F, var_9, "MOD_IMPACT");
  }

  self._id_012F = undefined;

  if(var_3) {
    self _meth_82BA(0, 1);
  } else {
    self _meth_82BA(1, 1);
  }

  self _meth_82C2("gravity");
  self _meth_82B9("anim deltas");
  _id_0017::_id_10980("attack", "end");
}

_id_FCA8(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("death_or_disconnect");
  var_3 = var_1;
  var_4 = 0.05;

  for(;;) {
    wait(var_4);
    var_3 = var_3 - var_4;

    if(var_3 <= 0) {
      break;
    }

    var_5 = _id_6E27(var_0, var_2);

    if(!isDefined(var_5)) {
      break;
    }

    self _meth_82B3(self.origin, var_5, var_3);
  }
}

_id_6E27(var_0, var_1) {
  if(!var_1) {
    var_2 = _id_06E0::_id_5056(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self._id_1DF5) {
      return self.origin;
    } else {
      var_3 = var_3 / var_4;
      var_5 = var_0.origin - var_3 * self._id_1DF5;

      if(_id_06E0::_id_3199(self.origin, var_5)) {
        return var_5;
      } else {
        return undefined;
      }
    }
  }
}

_id_4D17(var_0, var_1, var_2) {
  if(scripts\common\utility::_id_89CF(var_0)) {
    return;
  }
  if(scripts\common\utility::issp()) {
    var_3 = scripts\engine\utility::_id_CD61("get_difficultySetting", "player_dogMeleeDamageMultiplier");

    if(!isDefined(var_3)) {
      var_3 = 1;
    }

    var_0 dodamage(var_1 * var_3, self.origin, self, self, var_2);
  } else
    var_0 dodamage(var_1, self.origin, self, self, var_2);
}

_id_9D85() {
  self._id_9011 = self.origin;
  self._id_9012 = self._id_012F.origin;
}