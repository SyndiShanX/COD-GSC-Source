/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1890.gsc
*************************************************/

_id_5204(var_0) {
  if(_id_0743::_id_86C8("juggernaut")) {
    self._id_8C71 = undefined;
  }
}

_id_4A13(var_0) {
  if(_id_0743::_id_86C8("juggernaut")) {
    self._id_8C71 = 1;
  }
}

_id_51E7(var_0) {
  self._id_010D = "cover";
}

_id_49ED(var_0) {
  self._id_010D = "no_cover";
}

_id_52B3(var_0, var_1, var_2, var_3) {
  var_0 thread _id_52B4(var_0, var_1, var_2, var_3);
}

_id_52B4(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 waittill("all_group_spawns_dead");

  if(isDefined(var_2)) {
    level notify(var_2);
  }

  if(isDefined(var_1)) {
    _id_0748::_id_44BA(var_1);
  }
}

_id_4A53(var_0) {
  var_0 _id_0743::_id_4A51();
  scripts\engine\utility::_id_10888(self, "death", self._id_71F4, "death");
  var_0 _id_0743::_id_D1BD();
  var_0 _id_0743::_id_5222();
}

_id_C1FA(var_0) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_1 = 0; var_1 < level._id_1676[var_0].size; var_1++) {
        level._id_1676[var_0][var_1]._id_4A54 = 1;
      }
    } else
      level._id_1676[var_0]._id_4A54 = 1;
  }
}

_id_C1E6(var_0, var_1, var_2) {
  if(var_1.size != var_2.size) {
    return;
  }
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_3 = 0; var_3 < level._id_1676[var_0].size; var_3++) {
        level._id_1676[var_0][var_3]._id_7156 = var_1;
        level._id_1676[var_0][var_3]._id_713F = var_2;
      }
    }
  }
}

_id_676C(var_0) {
  var_1 = 0;

  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1 = var_1 + _id_0743::_id_6765(var_3);
  }

  return var_1;
}

_id_A01A() {
  return istrue(self._id_4A54);
}

_id_3ACD(var_0, var_1) {
  if(!isDefined(level._id_3AD0[var_1])) {
    level._id_3AD0[var_1] = [];
  }

  level._id_3AD0[var_1][level._id_3AD0[var_1].size] = var_0;
  var_0._id_3ACE = var_1;
}

_id_C3E9(var_0) {
  var_1 = var_0 _id_64DA();
  var_0._id_3ACE = undefined;

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(level._id_3AD0[var_1])) {
    level._id_3AD0[var_1] = ::scripts\engine\utility::array_remove(level._id_3AD0[var_1], var_0);
  }

  if(isDefined(level._id_3AD0[var_1]) && level._id_3AD0[var_1].size < 1) {
    level._id_3AD0[var_1] = undefined;
  }
}

_id_7214(var_0) {
  var_1 = _id_0743::_id_65B4(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3._id_3ACE)) {
      return 1;
    }
  }

  return 0;
}

_id_64DA() {
  return self._id_3ACE;
}

_id_C1FB(var_0, var_1) {
  if(_func_0107(level._id_1676[var_0])) {
    for(var_2 = 0; var_2 < level._id_1676[var_0].size; var_2++) {
      if(!isDefined(level._id_1676[var_0][var_2]._id_A01C)) {
        level._id_1676[var_0][var_2]._id_A01C = [];
      }

      level._id_1676[var_0][var_2]._id_A01C[level._id_1676[var_0][var_2]._id_A01C.size] = var_1;
    }
  } else {
    if(!isDefined(level._id_1676[var_0]._id_A01C)) {
      level._id_1676[var_0]._id_A01C = [];
    }

    level._id_1676[var_0]._id_A01C[level._id_1676[var_0]._id_A01C.size] = var_1;
  }
}

_id_C1F9(var_0, var_1) {
  if(_func_0107(level._id_1676[var_0])) {
    for(var_2 = 0; var_2 < level._id_1676[var_0].size; var_2++) {
      if(!isDefined(level._id_1676[var_0][var_2]._id_4983)) {
        level._id_1676[var_0][var_2]._id_4983 = [];
      }

      level._id_1676[var_0][var_2]._id_4983[level._id_1676[var_0][var_2]._id_4983.size] = var_1;
    }
  } else {
    if(!isDefined(level._id_1676[var_0]._id_4983)) {
      level._id_1676[var_0]._id_4983 = [];
    }

    level._id_1676[var_0]._id_4983[level._id_1676[var_0]._id_4983.size] = var_1;
  }
}

_id_C9E2() {
  if(isDefined(self._id_9300)) {
    var_0 = self._id_9300;

    if(isDefined(var_0._id_A01C)) {
      for(var_1 = 0; var_1 < var_0._id_A01C.size; var_1++) {
        _id_0743::_id_BD55(self, var_0._id_A01C[var_1]);
      }
    }
  }
}

_id_C1FC(var_0, var_1, var_2) {
  if(_func_0107(level._id_1676[var_0])) {
    for(var_3 = 0; var_3 < level._id_1676[var_0].size; var_3++) {
      if(!isDefined(level._id_1676[var_0][var_3]._id_A01D)) {
        level._id_1676[var_0][var_3]._id_A01D = [];
      }

      level._id_1676[var_0][var_3]._id_A01D[level._id_1676[var_0][var_3]._id_A01D.size] = var_1;

      if(!isDefined(level._id_1676[var_0][var_3]._id_A023)) {
        level._id_1676[var_0][var_3]._id_A023 = [];
      }

      level._id_1676[var_0][var_3]._id_A023[level._id_1676[var_0][var_3]._id_A023.size] = var_2;
    }
  } else {
    if(!isDefined(level._id_1676[var_0]._id_A01D)) {
      level._id_1676[var_0]._id_A01D = [];
    }

    level._id_1676[var_0]._id_A01D[level._id_1676[var_0]._id_A01D.size] = var_1;

    if(!isDefined(level._id_1676[var_0]._id_A023)) {
      level._id_1676[var_0]._id_A023 = [];
    }

    level._id_1676[var_0]._id_A023[level._id_1676[var_0]._id_A023.size] = var_2;
  }
}

_id_C9E3() {
  if(isDefined(self._id_9300)) {
    var_0 = self._id_9300;

    if(isDefined(var_0._id_A01D)) {
      for(var_1 = 0; var_1 < var_0._id_A01D.size; var_1++) {
        _id_0743::_id_BD55(self, var_0._id_A01D[var_1]);
      }
    }
  }
}

_id_C9E4() {
  if(isDefined(self._id_9300)) {
    var_0 = self._id_9300;

    if(isDefined(var_0._id_A023)) {
      for(var_1 = 0; var_1 < var_0._id_A023.size; var_1++) {
        _id_0743::_id_BD55(self, var_0._id_A023[var_1]);
      }
    }
  }
}

_id_3E11(var_0) {
  var_1 = 0;

  if(isent(self) && isPlayer(self)) {
    var_2 = var_0 - self _meth_8169();
    var_3 = anglesToForward(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    if(isDefined(self.angles)) {
      var_4 = self.angles;
    } else {
      var_4 = (0, 0, 0);
    }

    var_2 = var_0 - self.origin;
    var_3 = anglesToForward(var_4);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

_id_3E12(var_0) {
  var_1 = 0;

  if(isPlayer(self)) {
    var_2 = var_0 - self _meth_8169();
    var_3 = anglestoright(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    if(isDefined(self.angles)) {
      var_4 = self.angles;
    } else {
      var_4 = (0, 0, 0);
    }

    var_2 = var_0 - self.origin;
    var_3 = anglestoright(var_4);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

_id_3EC3(var_0) {
  level._id_11ED[var_0] = [];
  level._id_11ED[var_0]["animclass"] = "soldier_cp";
  level._id_11ED[var_0]["asm"] = "soldier_cp";
  level._id_11ED[var_0]["behaviorTree"] = "soldier_agent";
  level._id_11ED[var_0]["health"] = 150;
  level._id_11ED[var_0]["height"] = 70;
  level._id_11ED[var_0]["radius"] = 15;
  level._id_11ED[var_0]["reward"] = 100;
  level._id_11ED[var_0]["setup_func"] = ::_id_A446;
  level._id_11ED[var_0]["setup_model_func"] = ::_id_58E8;
  level._id_11ED[var_0]["species"] = "human";
  level._id_11ED[var_0]["team"] = "axis";
  level._id_11ED[var_0]["traversal_unit_type"] = "soldier";
  level._id_11ED[var_0]["xp"] = 50;
}

_id_A446() {
  self._id_10D2 = "";
  self._id_EAB8 = "regular";
  self._id_0159 = "cover_default";
  self._id_0196 = "enemyselector_default_cp";
  self._id_04B9 = "soldier";
  self _meth_8310(256.0, 0.0);
  self _meth_830F(768.0, 1024.0);
  self._id_001D = 0.2;

  switch (_id_06C4::_id_66E6(3)) {
    case 0:
      self._id_04F6 = scripts\cp\cp_weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self._id_04F6 = scripts\cp\cp_weapon::buildweapon("iw8_ar_falpha_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 2:
      self._id_04F6 = scripts\cp\cp_weapon::buildweapon("iw8_ar_falima_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self._id_04F6);
  self setspawnweapon(self._id_04F6);
  self._id_00CC = weaponclipsize(self._id_04F6);
  self._id_034C = self._id_04F6;
  self._id_020A = makeweapon("frag_grenade_mp");
  self._id_0206 = 2;
}

_id_58E8(var_0) {
  self._id_189C = "soldier_cp";
  self._id_10691 = "alqatala";
  self setModel("body_spetsnaz_ar");
  self attach("head_russian_army_balaclava_1", "", 1);
  self._id_7611 = "head_russian_army_balaclava_1";
}

_id_101D(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2._id_0359 = var_1;
  var_2 _id_079E::_id_1D10();
  level._id_E2D2[var_2._id_F94F] = var_2;
  return var_2._id_F94F;
}

_id_C44B(var_0) {
  if(isDefined(level._id_E2D2[var_0])) {
    level._id_E2D2[var_0] = undefined;
  }
}

_id_F2C7(var_0) {
  level._id_DD9A = var_0;
}

_id_1198(var_0) {
  if(isDefined(var_0)) {
    level._id_4A3F = var_0;
  } else {
    level._id_4A3F = undefined;
  }
}

_id_65B2() {
  var_0 = [];
  var_1 = _id_0743::_id_BD55(self, self._id_E1C5);
  return var_1;
}

_id_D373(var_0, var_1) {
  var_0._id_C0EB = var_1;
}