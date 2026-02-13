/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2377.gsc
*************************************************/

_id_8255() {
  _id_7F36();
}

_id_804A() {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = "cp/alien/perks_tree.csv";
  }

  level._id_1455 = [];
  _id_FBA6(0, "perk_0");
  _id_FBA6(100, "perk_1");
  _id_FBA6(200, "perk_2");
}

_id_80C8() {
  level._id_3D1E = [];
  _id_C207("perk_health", _id_0948::_id_D2FB, _id_0948::_id_F9FE);
  _id_C207("perk_health_1", _id_0948::_id_D2FC, _id_0948::_id_F9FF);
  _id_C207("perk_health_2", _id_0948::_id_D2FD, _id_0948::_id_FA00);
  _id_C207("perk_health_3", _id_0948::_id_D2FE, _id_0948::_id_FA01);
  _id_C207("perk_health_4", _id_0948::_id_D2FF, _id_0948::_id_FA02);
  _id_C207("perk_pistol_znrg", _id_0948::_id_D31C, _id_0948::_id_FA1D);
  _id_C207("perk_pistol_znrg_1", _id_0948::_id_D31D, _id_0948::_id_FA1E);
  _id_C207("perk_pistol_znrg_2", _id_0948::_id_D31E, _id_0948::_id_FA1F);
  _id_C207("perk_pistol_znrg_3", _id_0948::_id_D31F, _id_0948::_id_FA20);
  _id_C207("perk_pistol_znrg_4", _id_0948::_id_D320, _id_0948::_id_FA21);
  _id_C207("perk_pistol_magnum", _id_0948::_id_D30D, _id_0948::_id_FA0E);
  _id_C207("perk_pistol_magnum_1", _id_0948::_id_D30E, _id_0948::_id_FA0F);
  _id_C207("perk_pistol_magnum_2", _id_0948::_id_D30F, _id_0948::_id_FA10);
  _id_C207("perk_pistol_magnum_3", _id_0948::_id_D310, _id_0948::_id_FA11);
  _id_C207("perk_pistol_magnum_4", _id_0948::_id_D311, _id_0948::_id_FA12);
  _id_C207("perk_pistol_zg18", _id_0948::_id_D317, _id_0948::_id_FA18);
  _id_C207("perk_pistol_zg18_1", _id_0948::_id_D318, _id_0948::_id_FA19);
  _id_C207("perk_pistol_zg18_2", _id_0948::_id_D319, _id_0948::_id_FA1A);
  _id_C207("perk_pistol_zg18_3", _id_0948::_id_D31A, _id_0948::_id_FA1B);
  _id_C207("perk_pistol_zg18_4", _id_0948::_id_D31B, _id_0948::_id_FA1C);
  _id_C207("perk_pistol_zemc", _id_0948::_id_D312, _id_0948::_id_FA13);
  _id_C207("perk_pistol_zemc_1", _id_0948::_id_D313, _id_0948::_id_FA14);
  _id_C207("perk_pistol_zemc_2", _id_0948::_id_D314, _id_0948::_id_FA15);
  _id_C207("perk_pistol_zemc_3", _id_0948::_id_D315, _id_0948::_id_FA16);
  _id_C207("perk_pistol_zemc_4", _id_0948::_id_D316, _id_0948::_id_FA17);
  _id_C207("perk_bullet_damage", _id_0948::_id_D2EC, _id_0948::_id_F9EF);
  _id_C207("perk_bullet_damage_1", _id_0948::_id_D2ED, _id_0948::_id_F9F0);
  _id_C207("perk_bullet_damage_2", _id_0948::_id_D2EE, _id_0948::_id_F9F1);
  _id_C207("perk_bullet_damage_3", _id_0948::_id_D2EF, _id_0948::_id_F9F2);
  _id_C207("perk_bullet_damage_4", _id_0948::_id_D2F0, _id_0948::_id_F9F3);
  _id_C207("perk_medic", _id_0948::_id_D305, _id_0948::_id_FA08);
  _id_C207("perk_medic_1", _id_0948::_id_D306, _id_0948::_id_FA09);
  _id_C207("perk_medic_2", _id_0948::_id_D307, _id_0948::_id_FA0A);
  _id_C207("perk_medic_3", _id_0948::_id_D308, _id_0948::_id_FA0B);
  _id_C207("perk_medic_4", _id_0948::_id_D309, _id_0948::_id_FA0C);
  _id_C207("perk_rigger", _id_0948::_id_D321, _id_0948::_id_FA22);
  _id_C207("perk_rigger_1", _id_0948::_id_D322, _id_0948::_id_FA23);
  _id_C207("perk_rigger_2", _id_0948::_id_D323, _id_0948::_id_FA24);
  _id_C207("perk_rigger_3", _id_0948::_id_D324, _id_0948::_id_FA25);
  _id_C207("perk_rigger_4", _id_0948::_id_D325, _id_0948::_id_FA26);
  _id_C207("perk_robotics", _id_0948::_id_D326, _id_0948::_id_FA27);
  _id_C207("perk_robotics_1", _id_0948::_id_D327, _id_0948::_id_FA28);
  _id_C207("perk_robotics_2", _id_0948::_id_D328, _id_0948::_id_FA29);
  _id_C207("perk_robotics_3", _id_0948::_id_D329, _id_0948::_id_FA2A);
  _id_C207("perk_robotics_4", _id_0948::_id_D32A, _id_0948::_id_FA2B);
  _id_C207("perk_demolition", _id_0948::_id_D2F1, _id_0948::_id_F9F4);
  _id_C207("perk_demolition_1", _id_0948::_id_D2F2, _id_0948::_id_F9F5);
  _id_C207("perk_demolition_2", _id_0948::_id_D2F3, _id_0948::_id_F9F6);
  _id_C207("perk_demolition_3", _id_0948::_id_D2F4, _id_0948::_id_F9F7);
  _id_C207("perk_demolition_4", _id_0948::_id_D2F5, _id_0948::_id_F9F8);
  _id_C207("perk_gunslinger", _id_0948::_id_D2F6, _id_0948::_id_F9F9);
  _id_C207("perk_gunslinger_1", _id_0948::_id_D2F7, _id_0948::_id_F9FA);
  _id_C207("perk_gunslinger_2", _id_0948::_id_D2F8, _id_0948::_id_F9FB);
  _id_C207("perk_gunslinger_3", _id_0948::_id_D2F9, _id_0948::_id_F9FC);
  _id_C207("perk_gunslinger_4", _id_0948::_id_D2FA, _id_0948::_id_F9FD);
  _id_C207("perk_hybrid", _id_0948::_id_D300, _id_0948::_id_FA03);
  _id_C207("perk_hybrid_1", _id_0948::_id_D301, _id_0948::_id_FA04);
  _id_C207("perk_hybrid_2", _id_0948::_id_D302, _id_0948::_id_FA05);
  _id_C207("perk_hybrid_3", _id_0948::_id_D303, _id_0948::_id_FA06);
  _id_C207("perk_hybrid_4", _id_0948::_id_D304, _id_0948::_id_FA07);
  _id_C207("perk_none", _id_0948::_id_D30C, _id_0948::_id_FA0D);
  _id_C207("perk_none_1", _id_0948::_id_D30C, _id_0948::_id_FA0D);
  _id_C207("perk_none_2", _id_0948::_id_D30C, _id_0948::_id_FA0D);
  _id_C207("perk_none_3", _id_0948::_id_D30C, _id_0948::_id_FA0D);
  _id_C207("perk_none_4", _id_0948::_id_D30C, _id_0948::_id_FA0D);
}

_id_8124() {
  level._id_3D1E = [];
  _id_C207("perk_health", ::_id_253B, ::_id_253B);
  _id_C207("perk_health_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_health_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_health_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_health_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_znrg", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_znrg_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_znrg_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_znrg_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_znrg_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_magnum", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_magnum_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_magnum_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_magnum_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_magnum_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zg18", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zg18_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zg18_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zg18_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zg18_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zemc", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zemc_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zemc_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zemc_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_pistol_zemc_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_bullet_damage", ::_id_253B, ::_id_253B);
  _id_C207("perk_bullet_damage_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_bullet_damage_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_bullet_damage_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_bullet_damage_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_medic", ::_id_253B, ::_id_253B);
  _id_C207("perk_medic_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_medic_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_medic_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_medic_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_rigger", ::_id_253B, ::_id_253B);
  _id_C207("perk_rigger_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_rigger_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_rigger_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_rigger_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_robotics", ::_id_253B, ::_id_253B);
  _id_C207("perk_robotics_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_robotics_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_robotics_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_robotics_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_demolition", ::_id_253B, ::_id_253B);
  _id_C207("perk_demolition_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_demolition_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_demolition_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_demolition_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_gunslinger", ::_id_253B, ::_id_253B);
  _id_C207("perk_gunslinger_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_gunslinger_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_gunslinger_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_gunslinger_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_hybrid", ::_id_253B, ::_id_253B);
  _id_C207("perk_hybrid_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_hybrid_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_hybrid_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_hybrid_4", ::_id_253B, ::_id_253B);
  _id_C207("perk_none", ::_id_253B, ::_id_253B);
  _id_C207("perk_none_1", ::_id_253B, ::_id_253B);
  _id_C207("perk_none_2", ::_id_253B, ::_id_253B);
  _id_C207("perk_none_3", ::_id_253B, ::_id_253B);
  _id_C207("perk_none_4", ::_id_253B, ::_id_253B);

  if(isDefined(level._id_60C8)) {
    [[level._id_60C8]]();
  }
}

_id_253B() {}

_id_C207(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_D12B = var_1;
  var_3._id_F9B2 = var_2;
  level._id_3D1E[var_0] = var_3;
}

_id_FBA6(var_0, var_1) {
  level._id_1455[var_1] = [];

  for(var_2 = var_0; var_2 <= var_0 + 100; var_2++) {
    var_3 = _id_6657(var_2);

    if(var_3 == "") {
      break;
    }

    if(!isDefined(level._id_1455[var_3])) {
      var_4 = spawnStruct();
      var_4._id_FD9C = [];
      var_4._id_F981 = _id_67FF(var_3);
      var_4.name = _id_65C5(var_3);
      var_4._id_7C3B = _id_6501(var_3);
      var_4._id_C189 = var_3;
      var_4.type = var_1;
      var_4._id_2F52 = level._id_3D1E[var_3];
      var_4._id_22BE = var_2;
      level._id_1455[var_1][var_3] = var_4;
    }

    for(var_5 = var_2; var_5 <= var_0 + 100; var_5++) {
      var_6 = _id_6657(var_5);

      if(var_6 == "") {
        break;
      }

      if(var_6 == var_3 || _id_8660(var_3, var_6)) {
        var_7 = spawnStruct();
        var_7._id_C189 = var_6;
        var_7._id_4808 = _id_6441(var_6);
        var_7._id_B9A7 = _id_66AC(var_6);
        level._id_1455[var_1][var_3]._id_FD9C[var_5 - var_2] = var_7;
        continue;
      }

      break;
    }

    var_2 = var_5 - 1;
  }
}

_id_8660(var_0, var_1) {
  if(var_0 == var_1) {
    return 0;
  }

  if(!issubstr(var_1, var_0)) {
    return 0;
  }

  var_2 = strtok(var_0, "_");
  var_3 = strtok(var_1, "_");

  if(var_3.size - var_2.size != 1) {
    return 0;
  }

  for(var_4 = 0; var_4 < var_3.size - 1; var_4++) {
    if(var_3[var_4] != var_2[var_4]) {
      return 0;
    }
  }

  return 1;
}

_id_6657(var_0) {
  return _func_0222(level._id_1456, 0, var_0, 1);
}

_id_65C5(var_0) {
  return _func_0222(level._id_1456, 1, var_0, 4);
}

_id_6501(var_0) {
  return _func_0222(level._id_1456, 1, var_0, 6);
}

_id_6441(var_0) {
  return _func_0222(level._id_1456, 1, var_0, 5);
}

_id_66AC(var_0) {
  return int(_func_0222(level._id_1456, 1, var_0, 3));
}

_id_67FF(var_0) {
  return int(_func_0222(level._id_1456, 1, var_0, 2));
}

_id_652F(var_0) {
  return int(_func_0222(level._id_1456, 1, var_0, 7));
}

_id_7F36() {
  level._id_AFFB = [];
  level._id_CF95 = [];
  level._id_AFFB = [];
  level._id_B000 = [];
  level._id_CF95["specialty_falldamage"] = 1;
  level._id_CF95["specialty_armorpiercing"] = 1;
  level._id_CF95["specialty_gung_ho"] = 1;
  level._id_CF95["specialty_momentum"] = 1;
  level._id_AFFB["specialty_momentum"] = ::_id_D5FF;
  level._id_B000["specialty_momentum"] = ::_id_FABF;
  level._id_AFFB["specialty_falldamage"] = ::_id_D56C;
  level._id_B000["specialty_falldamage"] = ::_id_FA96;
}

_id_D56C() {}

_id_FA96() {}

_id_D5FF() {
  thread _id_CA50();
}

_id_CA50() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      _id_7119();
      self._id_A25F = 1;

      if(isDefined(level._id_A201)) {
        self[[level._id_A201]]();
      }
    }

    wait 0.1;
  }
}

_id_7119() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread _id_A0B5();
  thread _id_A0B4();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self._id_A25F = self._id_A25F + 0.01;

    if(isDefined(level._id_A201)) {
      self[[level._id_A201]]();
    }

    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread _id_A0B3();
  self waittill("momentum_reset");
}

_id_A0B3() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

_id_A0B5() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self _meth_8498()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self _meth_8498()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

_id_A0B4() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

_id_FABF() {
  self notify("momentum_unset");
}