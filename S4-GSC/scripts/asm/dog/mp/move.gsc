/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\asm\dog\mp\move.gsc
*************************************************/

_id_4CBD(var_0, var_1, var_2) {
  self._id_03BC = 60;
  self _meth_87CE();
  self._id_1C30._id_426A = spawnStruct();
  self._id_E061 = scripts\engine\utility::spawn_tag_origin();
  self._id_E061 linkto(self, "tag_eye");
  self _meth_85E3("speed");
  self _meth_8709();
  thread _id_107FF(self._id_E061);
}

_id_107FF(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 _meth_83F8();
    waitframe();
    var_0 delete();
  }
}

stoprequested(var_0, var_1, var_2, var_3) {
  return !_id_06BD::_id_23E5() && !_id_06BD::_id_23E3();
}

_id_A419(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(self._id_0192)) {
    var_4 = self._id_0192;
  } else if(isDefined(self._id_0B67.target)) {
    var_4 = self._id_0B67.target;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = vectornormalize(var_4.origin - self.origin);
  var_6 = _func_0261(var_5);
  var_7 = _func_000B(var_6 - self.angles[1]);
  var_8 = var_7 < -35 || var_7 > 35;

  if(var_8) {
    self._id_0B67._id_481D = var_6;
  }

  return var_8;
}

_id_A41B(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(distance2dsquared(self.origin, self._id_0323) < 4) {
    return 0;
  }

  var_4 = _func_0261(self._id_027F);
  var_5 = _func_000B(var_4 - self.angles[1]);
  var_6 = var_5 < -46 || var_5 > 46;

  if(var_6) {
    self._id_0B67._id_481D = var_4;
  }

  return var_6;
}

_id_DBE3(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(isDefined(self._id_9D39)) {
    return 0;
  }

  var_4 = self _meth_8473();

  if(var_4 > 128 || var_4 < 96) {
    return 0;
  }

  var_5 = self _meth_84E3();

  if(!isDefined(var_5)) {
    return 0;
  }

  if(istrue(self._id_0B67._id_7557)) {
    return 0;
  }

  return 1;
}

_id_35A5(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = _id_08F1::_id_68D8();
  var_5 = _id_08F1::_id_A57B(var_4);

  if(var_5 && _func_0134(var_4.origin - self.origin) < 16384) {
    var_3 = _id_08F1::_id_6B9D(var_4) - self.angles[1];
  }

  var_3 = _func_000B(var_3);
  var_6 = ["8", "9", "6", "3", "2", "1", "4", "7", "8"];
  var_7 = _func_0326(var_3, 22.5);
  var_8 = var_6[var_7];
  return _id_0009::_id_1C7D(var_1, var_8);
}

_id_B31D(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_8019("zonly_physics", 0);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  var_5 = self._id_0323 - self.origin;
  var_6 = _func_0261(var_5);
  var_7 = _func_00B0(var_4);
  var_8 = _func_0077(var_4);
  var_9 = length(var_5);
  var_10 = length(var_7) / var_9;
  var_11 = self._id_0323;
  var_12 = var_11 - rotatevector(var_7, (0, var_6, 0));
  var_13 = var_6 + var_8;
  var_14 = int(1000 * _func_0079(var_4) - 200);
  self _meth_83D9();
  self _meth_85FB(var_12, (0, var_6, 0), var_11, (0, var_13, 0), var_14);
  self._id_1C30._id_0063 = var_1;
  self _meth_85ED(var_1, var_3, var_10);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1), var_1);
}

_id_B31E(var_0, var_1, var_2) {
  self _meth_8616();
  self _meth_85FC();
}

_id_3639(var_0, var_1, var_2) {
  var_3 = _func_000B(self._id_0B67._id_481D - self.angles[1]);
  var_4 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var_5 = _func_0326(var_3);
  return _id_0009::_id_1C7D(var_1, var_4[var_5]);
}

_id_B912(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);
  self._id_04C2 = 1;
  self._id_0B67._id_F80F = var_3;
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1), var_1);
}

_id_B913(var_0, var_1, var_2) {
  self._id_04C2 = 0;
  self._id_0B67._id_481D = undefined;
  self._id_0B67._id_F80F = undefined;
}

_id_B332(var_0, var_1, var_2) {
  _id_0009::_id_1C81(var_0, var_1, 1, 0);
}

_id_B330(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    while((!isDefined(self._id_0408) || !isDefined(self._id_0408._id_24F2) || !self._id_0408._id_24F2) && !istrue(self._id_5EA9)) {
      waitframe();
    }

    self._id_E061 playSound("anml_dog_growl", "dog_growl", 1);
    self._id_E061 waittill("dog_growl");

    if(istrue(self._id_5EA9)) {
      self._id_5EA9 = undefined;
    }

    waitframe();
  }
}

_id_DB70(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self._id_0408) && isDefined(self._id_0408._id_241D) && self._id_0408._id_241D;
  return istrue(self._id_5E7C) || var_4;
}

_id_A6BC(var_0, var_1, var_2, var_3) {
  return !_id_DB70(var_0, var_1, var_2, var_3);
}

_id_B321(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);

  for(;;) {
    thread scripts\sound\snd_dogs::play_dog_bark_sounds();
    _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1), var_1);
    var_3 = _id_0009::_id_1C5C(var_0, var_1);
    self _meth_85ED(var_1, var_3);
  }
}

_id_7437(var_0) {
  switch (var_0) {
    case "fs_fr_r_lg":
    case "fs_fr_l_lg":
    case "fs_bk_r_lg":
    case "fs_bk_l_lg":
    case "fs_bk_r_sm":
    case "fs_bk_l_sm":
    case "fs_fr_r_sm":
    case "fs_fr_l_sm":
      var_1 = undefined;

      if(isDefined(self._id_020C)) {
        var_1 = self._id_020C;
        self._id_8FE2 = var_1;
      } else if(isDefined(self._id_8FE2))
        var_1 = self._id_8FE2;
      else {
        var_1 = "dirt";
      }

      if(var_1 != "dirt" && var_1 != "concrete" && var_1 != "wood" && var_1 != "metal") {
        var_1 = "dirt";
      }

      if(var_1 == "concrete") {
        var_1 = "cement";
      }

      var_2 = self._id_0B67._id_02D7;
      return 1;
  }

  return 0;
}

_id_7479(var_0, var_1) {
  switch (var_0) {
    case "orient_start":
      if(isDefined(self._id_0B67._id_F80F) && isDefined(self._id_0B67._id_481D)) {
        var_2 = _id_0009::_id_1C6E(var_1, self._id_0B67._id_F80F);
        var_3 = self _meth_85F7(var_2);
        var_4 = _func_0077(var_2, var_3, 1);
        self _meth_8251("face angle", self._id_0B67._id_481D - var_4);
      }

      break;
    default:
      return 0;
  }

  return 1;
}

_id_4CC4(var_0, var_1) {
  if(_id_7437(var_0)) {
    return;
  }
  if(_id_7479(var_0, var_1)) {
    return;
  }
  if(var_0 == "dog_melee") {
    if(isDefined(self._id_0192) && distance2dsquared(self.origin, self._id_0192.origin) < self._id_9D99) {
      var_2 = 50;
      var_3 = undefined;

      if(isDefined(self._id_F930)) {
        var_2 = self._id_F930;
      }

      if(_id_080B::_id_8A09(self._id_0192._id_0133)) {
        var_4 = vectordot(anglesToForward(self getplayerangles()), anglesToForward(self._id_0192 getplayerangles()));
        var_5 = var_4 < -0.5;

        if(var_5) {
          var_3 = "shield";
        }
      }

      self._id_0192 dodamage(var_2, self getEye(), self, self, "MOD_MELEE", makeweapon("s4_ks_dog_bite_mp"), var_3);
    }

    return;
  }

  var_6 = _func_00D6(var_0, 0, 3);

  if(var_6 != "ps_") {
    return;
  }
  var_7 = _func_00D6(var_0, 3);
  self playSound(var_7);
}