/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1879.gsc
*************************************************/

_id_C213() {
  level._id_FCDB = ::_id_FCDA;
  level._id_FCEE = ::_id_FCED;
  level._id_FCD7 = ::_id_FCD6;
  level._id_3E19 = [];
  level._id_FD10 = ::_id_FD0E;
  level._id_C306 = _id_95DC();
  level._id_A00C = [];

  if(!isDefined(level.perks)) {
    level.perks = ["perk_machine_tough", "perk_machine_revive", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_run", "perk_machine_fwoosh", "perk_machine_smack", "perk_machine_zap", "perk_machine_boom"];
  }

  _id_C212("passive_railgun_overload", ::_id_8030, ::_id_D2D5, ::_id_F9E2);
  _id_C212("passive_last_shots_ammo", ::_id_8025, ::_id_D2CA, ::_id_F9D7);
  _id_C212("passive_nuke", ::_id_802F, ::_id_D2D4, ::_id_F9E1);
  _id_C212("passive_headshot_ammo", ::_id_7FAC, ::_id_D241, ::_id_F9BF);
  _id_C212("passive_headshot_super", ::_id_7FAD, ::_id_D242, ::_id_F9C0);
  _id_C212("passive_refresh", ::_id_8033, ::_id_D2D8, ::_id_F9E5);
  _id_C212("passive_double_kill_reload", ::_id_8018, ::_id_D2BD, ::_id_F9CA);
  _id_C212("passive_gore", ::_id_801D, ::_id_D2C2, ::_id_F9CF);
  _id_C212("passive_meleekill", ::_id_8027, ::_id_D2CC, ::_id_F9D9);
  _id_C212("passive_health_on_kill", ::_id_801E, ::_id_D2C3, ::_id_F9D0);
  _id_C212("passive_health_regen_on_kill", ::_id_801F, ::_id_D2C4, ::_id_F9D1);
  _id_C212("passive_move_speed_on_kill", ::_id_802D, ::_id_D2D2, ::_id_F9DF);
  _id_C212("passive_hitman", ::_id_8020, ::_id_D2C5, ::_id_F9D2);
  _id_C212("passive_score_bonus_kills", ::_id_8035, ::_id_D2DA, ::_id_F9E7);
  _id_C212("passive_scorestreak_pack", ::_id_8035, ::_id_D2DA, ::_id_F9E7);
  _id_C212("passive_random_perks", ::_id_8032, ::_id_D2D7, ::_id_F9E4);
  _id_C212("passive_visor_detonation", ::_id_803A, ::_id_D2E0, ::_id_F9EC);
  _id_C212("passive_melee_super", ::_id_8028, ::_id_D2CD, ::_id_F9DA);
  _id_C212("passive_jump_super", ::_id_8024, ::_id_D2C9, ::_id_F9D6);
  _id_C212("passive_double_kill_super", ::_id_8019, ::_id_D2BE, ::_id_F9CB);
  _id_C212("passive_mode_switch_score", ::_id_802B, ::_id_D2D0, ::_id_F9DD);
  _id_C212("passive_melee_cone_expl", ::_id_8026, ::_id_D2CB, ::_id_F9D8);
  _id_C212("passive_berserk", ::_id_8015, ::_id_D2BA, ::_id_F9C7);
  _id_C212("passive_infinite_ammo", ::_id_8023, ::_id_D2C8, ::_id_F9D5);
  _id_C212("passive_crouch_move_speed", ::_id_8017, ::_id_D2BC, ::_id_F9C9);
  _id_C212("passive_slide_blastshield", ::_id_801C, ::_id_D2C1, ::_id_F9CE);
  _id_C212("passive_cold_damage", ::_id_8016, ::_id_D2BB, ::_id_F9C8);
  _id_C212("passive_sonic", ::_id_8039, ::_id_D2DE, ::_id_F9EB);
  _id_C212("passive_below_the_belt", ::_id_8014, ::_id_D2B9, ::_id_F9C6);
  _id_C212("passive_minimap_damage", ::_id_8029, ::_id_D2CE, ::_id_F9DB);
  _id_C212("passive_extra_xp", ::_id_7F7D, ::_id_D1F6, ::_id_F9BA);
  _id_C212("passive_fast_melee", ::_id_801B, ::_id_D2C0, ::_id_F9CD);
  _id_C212("coop_passive_snap_to_head", ::_id_80B0, ::_id_D3AC, ::_id_FA3F);
  _id_C212("passive_empty_reload_speed", ::_id_801A, ::_id_D2BF, ::_id_F9CC);
  _id_C212("passive_increased_scope_breath", ::_id_8022, ::_id_D2C7, ::_id_F9D4);
  _id_C212("passive_hunter_killer", ::_id_8021, ::_id_D2C6, ::_id_F9D3);
  _id_C212("passive_move_speed", ::_id_802C, ::_id_D2D1, ::_id_F9DE);
  _id_C212("passive_miss_refund", ::_id_802A, ::_id_D2CF, ::_id_F9DC);
  _id_C212("passive_scoutping", ::_id_8037, ::_id_D2DC, ::_id_F9E9);
  _id_C212("passive_scrambler", ::_id_8038, ::_id_D2DD, ::_id_F9EA);
  _id_C212("passive_random_attachment", ::_id_8031, ::_id_D2D6, ::_id_F9E3);
  _id_C212("passive_scope_radar", ::_id_8034, ::_id_D2D9, ::_id_F9E6);
  _id_C212("passive_scorestreak_damage", ::_id_8036, ::_id_D2DB, ::_id_F9E8);
  _id_C212("passive_scorestreak_damage_e", ::_id_8036, ::_id_D2DB, ::_id_F9E8);
  _id_C212("relic_collat_dmg", ::_id_8089, ::_id_D37D, ::_id_FA35);
  _id_C212("relic_catch", ::_id_8088, ::_id_D37C, ::_id_FA34);
  _id_C212("relic_boom", ::_id_8087, ::_id_D37B, ::_id_FA33);
  _id_C212("relic_swat", ::_id_8090, ::_id_D385, ::_id_FA3C);
  _id_C212("relic_glasscannon", ::_id_808D, ::_id_D381, ::_id_FA39);
  _id_C212("relic_aggressive_melee", ::_id_8086, ::_id_D379, ::_id_FA31);
  _id_C212("relic_dogtags", ::_id_808A, ::_id_D37E, ::_id_FA36);
  _id_C212("relic_lsmelee", ::_id_808F, ::_id_D384, ::_id_FA3B);
  _id_C212("relic_hideobj", ::_id_808E, ::_id_D382, ::_id_FA3A);
  _id_C212("relic_expldmg", ::_id_808B, ::_id_D37F, ::_id_FA37);
  _id_C212("relic_fastbleed", ::_id_808C, ::_id_D380, ::_id_FA38);
  level._id_AB11 = [];
  level._id_AB11["passive_nuke"] = ::_id_F416;
  level._id_AB11["passive_random_perks"] = ::_id_F417;
  level._id_AB11["passive_railgun_overload"] = ::_id_4D0C;
  level._id_AB11["passive_headshot_ammo"] = ::_id_7454;
  level._id_AB11["passive_headshot_super"] = ::_id_1183;
  level._id_AB11["passive_refresh"] = ::_id_747C;
  level._id_AB11["passive_double_kill_reload"] = ::_id_4EA6;
  level._id_AB11["passive_gore"] = ::_id_7452;
  level._id_AB11["passive_health_regen_on_kill"] = ::_id_7456;
  level._id_AB11["passive_move_speed_on_kill"] = ::_id_746D;
  level._id_AB11["passive_hitman"] = ::_id_7457;
  level._id_AB11["passive_meleekill"] = ::_id_7469;
  level._id_AB11["passive_health_on_kill"] = ::_id_7455;
  level._id_AB11["passive_last_shots_ammo"] = ::_id_741B;
  level._id_AB11["passive_visor_detonation"] = ::_id_74AA;
  level._id_AB11["passive_melee_super"] = ::_id_746B;
  level._id_AB11["passive_jump_super"] = ::_id_741A;
  level._id_AB11["passive_double_kill_super"] = ::_id_743A;
  level._id_AB11["passive_melee_cone_expl"] = ::_id_7467;
  level._id_AB11["passive_berserk"] = ::_id_741F;
  level._id_AB11["passive_ninja"] = ::_id_741B;
  level._id_AB11["relic_collat_dmg"] = ::_id_748A;
  level._id_AB11["relic_catch"] = ::_id_7489;
  level._id_AB11["relic_boom"] = ::_id_7488;
  level._id_B018 = [];
  level._id_B018["passive_infinite_ammo"] = ::_id_7460;
  level._id_B018["passive_fortified"] = ::_id_744B;
  level._id_AAA0 = [];
  level._id_AAA0["passive_sonic"] = ::_id_747E;
  level._id_AAA0["passive_minimap_damage"] = ::_id_FCEC;
  level._id_AAA0["passive_cold_damage"] = ::_id_FCEB;
  level._id_AAA0["relic_swat"] = ::_id_748B;
  level._id_AAA0["relic_collat_dmg"] = ::_id_AA9F;
}

_id_95DC() {
  var_0 = "cp/cp_relic_combos.csv";
  var_1 = [];

  for(var_2 = 1; var_2 <= 10; var_2++) {
    var_3 = _id_EC72(var_0, var_2, 1);

    if(var_3 == "") {
      continue;
    }
    var_1[var_2 - 1] = spawnStruct();
    var_1[var_2 - 1]._id_CBD5 = _id_EC72(var_0, var_2, 1);
    var_1[var_2 - 1]._id_E4DB = _id_EC72(var_0, var_2, 2);
    var_1[var_2 - 1]._id_E4DC = _id_EC72(var_0, var_2, 3);
    var_1[var_2 - 1]._id_E4DD = _id_EC72(var_0, var_2, 4);
    var_1[var_2 - 1]._id_E4DE = _id_EC72(var_0, var_2, 5);
    var_1[var_2 - 1]._id_E4DF = _id_EC72(var_0, var_2, 6);
    var_1[var_2 - 1]._id_E4E0 = _id_EC72(var_0, var_2, 7);
  }

  return var_1;
}

_id_EC72(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, var_1, var_2);
}

_id_8031(var_0) {
  var_1 = _id_6E8E(var_0, "passive_random_attachment");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = scripts\cp\utility::_id_6CE3(var_4);
    var_6 = scripts\cp\utility::getweaponrootname(var_4);
    var_7 = scripts\cp\utility::_id_6E6B(var_6);
    var_8 = scripts\cp\utility::_id_6E6E(var_6);
    var_9 = scripts\cp\utility::_id_6E88(var_6);
    var_10 = scripts\cp\utility::_id_6E7F(var_6);
    var_0._id_10CEA[var_5] = ::scripts\cp\utility::_id_A2AE(var_6, var_2, var_7, var_9, scripts\cp\utility::_id_6859(var_0, var_4), self getentitynumber(), self._id_399D, var_10, var_8);
  }
}

_id_D2D6(var_0) {}

_id_F9E3(var_0) {}

_id_6E8E(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(var_0._id_10D0F);

  foreach(var_5 in var_3) {
    for(var_6 = 0; var_6 < var_0._id_10D0F[var_5].size; var_6++) {
      if(var_0._id_10D0F[var_5][var_6].name == var_1) {
        var_2[var_2.size] = var_5;
      }
    }
  }

  var_2 = scripts\engine\utility::_id_1BC1(var_2);
  return var_2;
}

_id_801B(var_0) {}

_id_D2C0(var_0) {
  var_0._id_7DD1 = 150;
}

_id_F9CD(var_0) {
  var_0._id_7DD1 = undefined;
}

_id_7F7D(var_0) {
  var_0._id_10D0E = 1;
  var_0._id_8D5A = 0;
}

_id_D1F6(var_0) {
  var_0._id_10D0E = 1.25;
}

_id_F9BA(var_0) {
  var_0._id_10D0E = 1;
  var_0._id_8D5A = 0;
}

_id_8014(var_0) {
  var_0._id_40A0 = undefined;
}

_id_D2B9(var_0) {
  var_0._id_40A0 = 3.75;
}

_id_F9C6(var_0) {
  var_0._id_40A0 = undefined;
}

_id_802C(var_0) {
  var_0._id_10D0E = 1;
}

_id_D2D1(var_0) {
  var_0._id_10DBB = 0.05;
  var_0[[level._id_A201]]();
}

_id_F9DE(var_0) {
  var_0._id_10DBB = undefined;
  var_0[[level._id_A201]]();
}

_id_801A(var_0) {}

_id_D2BF(var_0) {
  var_0 scripts\cp\utility::_setperk("specialty_fastreload_empty");
}

_id_F9CC(var_0) {
  var_0 scripts\cp\utility::_unsetperk("specialty_fastreload_empty");
}

_id_8022(var_0) {}

_id_D2C7(var_0) {
  var_0 scripts\cp\utility::_setperk("specialty_holdbreath");
}

_id_F9D4(var_0) {
  var_0 scripts\cp\utility::_unsetperk("specialty_holdbreath");
}

_id_80B0(var_0) {}

_id_D3AC(var_0) {
  var_0 scripts\cp\utility::_setperk("specialty_autoaimhead");
}

_id_FA3F(var_0) {
  var_0 scripts\cp\utility::_unsetperk("specialty_autoaimhead");
}

_id_8021(var_0) {
  self._id_7BD6 = 0;
}

_id_D2C6(var_0) {
  self endon("passive_hunter_killer_cancel");
  var_1 = _id_06FE::_id_68A1("axis");
  thread _id_FC89(var_1);
  thread _id_7BD2();

  foreach(var_0 in var_1) {
    thread _id_7BD4(var_0);
    thread _id_7BD3(var_0);
  }
}

_id_F9D3(var_0) {
  self notify("passive_hunter_killer_cancel");

  foreach(var_2 in self._id_7BD1) {
    var_0 = self._id_7BD0[var_2];
    _id_074A::_id_4A30(var_0, level.players);
  }

  self._id_7BD1 = undefined;
  self._id_7BD0 = undefined;
}

_id_FC89(var_0) {
  if(!isDefined(self._id_7BD1)) {
    self._id_7BD1 = [];
  }

  if(!isDefined(self._id_7BD0)) {
    self._id_7BD0 = [];
  }

  foreach(var_2 in var_0) {
    if(var_2 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_2) || !isDefined(var_2.team)) {
      continue;
    }
    var_3 = _id_6AAC(var_2);

    if(level.teambased && self.team != var_2.team && var_2.health / var_2.maxhealth <= 0.5 && var_2.health > 0) {
      if(var_3 < 0) {
        self._id_7BD6++;
        _id_074A::_id_520F(var_2, self, 1, 0, 1, "high");
        var_4 = self._id_7BD6;
        self._id_7BD1[self._id_7BD1.size] = var_4;
        self._id_7BD0[var_4] = var_2;
        thread _id_7BD5(var_2);
      }

      continue;
    }

    if(var_3 >= 0) {
      var_5 = [];
      var_6 = [];
      _id_074A::_id_4A2F(var_2, self);

      foreach(var_4 in self._id_7BD1) {
        var_8 = self._id_7BD0[var_4];

        if(var_8 == var_2) {
          continue;
        }
        var_5[var_5.size] = var_4;
        var_6[var_4] = var_8;
      }

      self._id_7BD1 = var_5;
      self._id_7BD0 = var_6;
      var_2 notify("passive_hunter_killer_listen_cancel");
    }
  }
}

_id_7BD5(var_0) {
  self endon("passive_hunter_killer_cancel");
  var_0 endon("passive_hunter_killer_listen_cancel");

  for(;;) {
    wait 1.0;
    thread _id_FC88(var_0);
  }
}

_id_6AAC(var_0) {
  if(!isDefined(self._id_7BD1) || !isDefined(self._id_7BD0)) {
    return -1;
  }

  foreach(var_2 in self._id_7BD1) {
    var_3 = self._id_7BD0[var_2];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_0) {
      return var_2;
    }
  }

  return -1;
}

_id_7BD2() {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    level waittill("agent_spawned", var_0);
    thread _id_FC88(var_0);
    thread _id_7BD3(var_0);
  }
}

_id_7BD4(var_0) {
  self endon("passive_hunter_killer_cancel");
  var_0 waittill("disconnect");
  thread _id_FC88(var_0);
}

_id_7BD3(var_0) {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread _id_FC88(var_0);
  }
}

_id_FC88(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;
  thread _id_FC89(var_1);
}

_id_8033(var_0) {
  var_0._id_A4C1 = 0;
}

_id_D2D8(var_0) {
  var_0._id_AB11["passive_refresh"] = 1;
}

_id_F9E5(var_0) {
  var_0._id_AB11["passive_refresh"] = 0;
}

_id_747C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1._id_A4C1++;

  if(var_1._id_A4C1 >= 50) {
    if(isDefined(level._id_BA96)) {
      var_1[[level._id_BA96]](undefined, "primary", 1);
    }

    var_1._id_A4C1 = 0;
  }
}

_id_8018(var_0) {}

_id_D2BD(var_0) {
  var_0._id_AB11["passive_double_kill_reload"] = 1;
}

_id_F9CA(var_0) {
  var_0._id_AB11["passive_double_kill_reload"] = 0;
}

_id_4EA6(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_1._id_C0F3 >= 4) {
    var_0 = var_1 getcurrentweapon();
    var_6 = weaponclipsize(var_0);
    var_7 = var_1 getweaponammostock(var_0);
    var_8 = var_1 getweaponammoclip(var_0);
    var_9 = min(var_6 - var_8, var_7);
    var_10 = min(var_8 + var_9, var_6);
    var_1 setweaponammoclip(var_0, int(var_10));
    var_1 setweaponammostock(var_0, int(var_7 - var_9));

    if(var_1 _meth_81BC()) {
      var_7 = var_1 getweaponammostock(var_0);
      var_8 = var_1 getweaponammoclip(var_0, "left");
      var_9 = min(var_6 - var_8, var_7);
      var_10 = min(var_8 + var_9, var_6);
      var_1 setweaponammoclip(var_0, int(var_10), "left");
      var_1 setweaponammostock(var_0, int(var_7 - var_9));
    }
  }
}

_id_8027(var_0) {
  var_0._id_AEA2 = 0;
}

_id_D2CC(var_0) {
  var_0._id_DDA0 = 1;
  var_0._id_AEA2 = 1000;
  var_0._id_AB11["passive_meleekill"] = 1;
}

_id_F9D9(var_0) {
  var_0._id_DDA0 = undefined;
  var_0._id_AEA2 = 0;
  var_0._id_AB11["passive_meleekill"] = 0;
}

_id_7469(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");

  if(var_3 != "MOD_MELEE") {
    return;
  }
  level thread _id_7451(var_2);
  wait 0.05;
  var_6 = var_2 _meth_8122();

  if(isDefined(var_6)) {
    var_6 hide();
    var_6._id_B00A = 1;
  }
}

_id_7451(var_0) {
  var_1 = var_0 gettagorigin("j_spine4");
  playFX(level._effect["gore"], var_1, (1, 0, 0));
  playsoundatpos(var_1, "gib_fullbody");

  foreach(var_3 in level.players) {
    var_3 earthquakeforplayer(0.5, 1.5, var_1, 120);
  }
}

_id_801D(var_0) {}

_id_D2C2(var_0) {
  var_0._id_AB11["passive_gore"] = 1;
}

_id_F9CF(var_0) {
  var_0._id_AB11["passive_gore"] = 0;
}

_id_7452(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 endon("diconnect");
  wait 0.05;
  var_6 = var_2 _meth_8122();

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_6.origin;
  earthquake(0.5, 1.5, var_7, 120);
  playFX(level._effect["corpse_pop"], var_7 + (0, 0, 12));

  if(isDefined(var_6)) {
    var_6 hide();
    var_6._id_B00A = 1;
  }
}

_id_801E(var_0) {
  var_0._id_AEA3 = 0;
}

_id_D2C3(var_0) {
  var_0._id_AB11["passive_health_on_kill"] = 1;
}

_id_F9D0(var_0) {
  var_0._id_AB11["passive_health_on_kill"] = 0;
}

_id_7455(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1._id_AEA3++;

  if(var_1._id_AEA3 >= 2) {
    var_1 notify("force_regeneration");
    var_1._id_AEA3 = 0;
  }
}

_id_801F(var_0) {
  var_0._id_AEA3 = 0;
}

_id_D2C4(var_0) {
  var_0._id_AB11["passive_health_regen_on_kill"] = 1;
}

_id_F9D1(var_0) {
  var_0._id_AB11["passive_health_regen_on_kill"] = 0;
}

_id_7456(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_1._id_AEA3 >= 2) {
    var_1 notify("force_regeneration");
    var_1._id_AEA3 = 0;
  } else
    var_1._id_AEA3++;
}

_id_802D(var_0) {
  var_0._id_10DBC = 0;
}

_id_D2D2(var_0) {
  var_0._id_AB11["passive_move_speed_on_kill"] = 1;
}

_id_F9DF(var_0) {
  var_0._id_AB11["passive_move_speed_on_kill"] = 0;
}

_id_746D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "passive_move_speed_on_kill";
  var_1 notify(var_6);
  var_1 endon(var_6);

  if(var_1._id_10DBC != 0.075) {
    var_1._id_10DBC = 0.075;
    var_1[[level._id_A201]]();
  }

  var_1 scripts\engine\utility::_id_108A8(5, "death", "disconnect");

  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_10DBC = 0;
  var_1[[level._id_A201]]();
}

_id_8035(var_0) {}

_id_D2DA(var_0) {
  var_0._id_32FF = var_0._id_32FF + 0.1;
  var_0._id_3301 = scripts\cp\utility::_id_6CE3(var_0 getcurrentweapon());
}

_id_F9E7(var_0) {
  var_0._id_32FF = var_0._id_32FF - 0.1;
  var_0._id_3301 = undefined;
}

_id_8020(var_0) {}

_id_D2C5(var_0) {
  var_0._id_AB11["passive_hitman"] = 1;
}

_id_F9D2(var_0) {
  var_0._id_AB11["passive_hitman"] = 0;
}

_id_7457(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !var_1 scripts\cp_mp\utility\player_utility::_isalive() || !isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1._id_79AD)) {
    var_1._id_79AD = [];
  } else if(_id_79AC(var_1, var_2._id_0094)) {
    return;
  }
  var_1 thread _id_C618();
  var_1._id_79AD[var_1._id_79AD.size] = var_2._id_0094;

  if(var_1._id_79AD.size >= 10) {
    var_1 notify("consumable_charge", 200);
    var_1._id_79AD = [];
  }
}

_id_C618() {
  self notify("hitman_timeout");
  self endon("hitman_timeout");
  self endon("death");
  level endon("game_ended");
  wait 10;
  self._id_79AD = [];
}

_id_79AC(var_0, var_1) {
  if(!isDefined(var_0._id_79AD)) {
    return 0;
  }

  foreach(var_3 in var_0._id_79AD) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_79AE() {
  self endon("disconnect");
  self waittill("death");
  self._id_79AD = undefined;
}

_id_802F(var_0) {
  var_0._id_AEA9 = 0;
  var_0._id_9027 = 0;
  var_0 thread _id_F418(var_0);
}

_id_D2D4(var_0) {
  var_0._id_AB11["passive_nuke"] = 1;
}

_id_F9E1(var_0) {
  var_0._id_AB11["passive_nuke"] = 0;
}

_id_F416(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1._id_AEA9++;

  if(var_1._id_AEA9 >= 3) {
    var_6 = spawn("script_model", var_1.origin);
    var_6 thread scripts\cp\utility::_id_46C7(10);
    var_7 = _id_06FE::_id_6884("allies");
    var_8 = 0;

    foreach(var_10 in var_7) {
      var_10 _meth_81FA();
    }

    var_1._id_AEA9 = 0;
  }
}

_id_F418(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("last_stand");
    var_0._id_AEA9 = 0;
  }
}

_id_7FAC(var_0) {}

_id_D241(var_0) {
  var_0._id_AB11["passive_headshot_ammo"] = 1;
}

_id_F9BF(var_0) {
  var_0._id_AB11["passive_headshot_ammo"] = 0;
}

_id_7454(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isDefined(var_0)) {
    return;
  }
  if(!scripts\cp\utility::_id_8891(var_0, var_4, var_3, var_1)) {
    return;
  }
  var_6 = weaponclipsize(var_0);
  _id_118E(var_1, var_0, "right", var_6);

  if(var_1 _meth_81BC()) {
    _id_118E(var_1, var_0, "left", var_6);
  }
}

_id_118E(var_0, var_1, var_2, var_3) {
  var_4 = var_0 getweaponammostock(var_1);

  if(var_4 < 1) {
    return;
  }
  var_5 = var_0 getweaponammoclip(var_1, var_2);
  var_6 = var_3 - var_5;

  if(var_4 >= var_6) {
    var_0 setweaponammostock(var_1, var_4 - var_6);
  } else {
    var_6 = var_4;
    var_0 setweaponammostock(var_1, 0);
  }

  var_7 = min(var_5 + var_6, var_3);
  var_0 setweaponammoclip(var_1, int(var_7), var_2);
}

_id_801C(var_0) {
  var_0._id_74F2 = 0;
}

_id_D2C1(var_0) {
  var_0._id_B018["passive_fortified"] = 1;
  var_0._id_74F2 = 1;
}

_id_F9CE(var_0) {
  var_0._id_B018["passive_fortified"] = 0;
  var_0._id_74F2 = 0;
}

_id_744B(var_0, var_1, var_2) {}

_id_802E(var_0) {}

_id_D2D3(var_0) {
  var_0._id_B018["passive_ninja"] = 1;
}

_id_F9E0(var_0) {
  var_0._id_B018["passive_ninja"] = 0;
}

_id_7472(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_3 = weaponclipsize(var_1);
  var_4 = var_0 getweaponammoclip(var_1, "right");

  if(var_4 == 0) {
    var_0 thread _id_D352();
  }

  if(var_4 == 0 && !scripts\engine\utility::array_contains(var_0._id_E7EB, "right")) {
    var_0 thread _id_D352();
  } else if(var_4 > 0) {
    var_0._id_E7EB = scripts\engine\utility::array_remove(var_0._id_E7EB, "right");
  }

  if(var_0 _meth_81BC()) {
    var_5 = var_0 getweaponammoclip(var_1, "left");

    if(var_5 == 0 && !scripts\engine\utility::array_contains(var_0._id_E7EB, "left")) {
      var_0 thread _id_D352();
    } else if(var_5 > 0) {
      var_0._id_E7EB = scripts\engine\utility::array_remove(var_0._id_E7EB, "left");
    }
  }
}

_id_D352() {
  self notify("reset_stealth");
  self endon("reset_stealth");
  self endon("disconnect");

  if(!scripts\cp\utility::_id_88B5()) {
    scripts\cp\utility::_id_1566(1);
  }

  playFX(level._effect["stimulus_glow_burst"], scripts\engine\utility::_id_5000(self.origin) - (0, 0, 30));
  scripts\engine\utility::_id_B2DA("zmb_fnf_stimulus", scripts\engine\utility::_id_5000(self.origin));

  if(self _meth_81BC()) {
    wait 3.0;
  } else {
    wait 4.0;
  }

  if(scripts\cp\utility::_id_88B5()) {
    scripts\cp\utility::_id_1566(0);
  }
}

_id_8025(var_0) {}

_id_D2CA(var_0) {
  var_0._id_AB11["passive_last_shots_ammo"] = 1;
}

_id_F9D7(var_0) {
  var_0._id_AB11["passive_last_shots_ammo"] = 0;
}

_id_741B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isDefined(var_0)) {
    return;
  }
  var_6 = weaponclipsize(var_0);
  var_7 = var_1 getweaponammoclip(var_0, "right");

  if(var_7 <= int(var_6 * 0.2)) {
    _id_118E(var_1, var_0, "right", var_6);
  }

  if(var_1 _meth_81BC()) {
    var_7 = var_1 getweaponammoclip(var_0, "left");

    if(var_7 <= int(var_6 * 0.2)) {
      _id_118E(var_1, var_0, "left", var_6);
    }
  }
}

_id_8030(var_0) {}

_id_D2D5(var_0) {
  var_0._id_AB11["passive_railgun_overload"] = 1;
}

_id_F9E2(var_0) {
  var_0._id_AB11["passive_railgun_overload"] = 0;
}

_id_4D0C(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2._id_79A2)) {
    return 0;
  }

  if(!scripts\engine\utility::_id_8794(var_3)) {
    return 0;
  }

  if(isDefined(var_2._id_1210) && (var_2._id_1210 == "zombie_brute" || var_2._id_1210 == "zombie_grey" || var_2._id_1210 == "slasher" || var_2._id_1210 == "superslasher" || var_2._id_1210 == "zombie_sasquatch" || var_2._id_1210 == "lumberjack")) {
    return;
  }
  var_6 = istrue(var_2._id_86D9);
  var_2._id_75DE = 1;
  var_7 = var_2 gettagorigin("j_spine4");
  playsoundatpos(var_2.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_7);

  if(isDefined(var_2._id_7611)) {
    var_2 detach(var_2._id_7611);
  }

  if(!var_6) {
    var_2 setscriptablepartstate("head", "hide");
  }

  var_2._id_79A2 radiusdamage(var_2.origin, 64, var_2.maxhealth, var_2.maxhealth, var_2._id_79A2, "MOD_EXPLOSIVE", "iw7_zombieDoors_zm");
  var_2._id_79A2 = undefined;
}

_id_7FAD(var_0) {
  var_0._id_46C4 = 0;
}

_id_D242(var_0) {
  var_0._id_AB11["passive_headshot_super"] = 1;
}

_id_F9C0(var_0) {
  var_0._id_AB11["passive_headshot_super"] = 0;
}

_id_1183(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1._id_46C4++;
  wait(0.05 * var_1._id_46C4);
  var_1._id_46C4--;

  if(var_1._id_46C4 < 0) {
    var_1._id_46C4 = 0;
  }

  var_1 notify("consumable_charge", 10);
}

_id_8039(var_0) {
  var_0._id_E01E = 0;
}

_id_D2DE(var_0) {
  var_0._id_AAA0["passive_sonic"] = 1;
}

_id_F9EB(var_0) {
  var_0._id_AAA0["passive_sonic"] = 0;
}

_id_747E(var_0, var_1, var_2) {
  var_3 = gettime();

  if(var_2 scripts\cp\utility::_id_1216()) {
    return;
  }
  if(var_3 <= var_0._id_E01E) {
    return;
  }
  if(distance2dsquared(var_0.origin, var_2.origin) <= 62500) {
    thread scripts\cp\cp_weapon::_id_607A(var_2, var_0);
  }

  var_0._id_E01E = var_3 + 1000;
}

_id_8017(var_0) {}

_id_D2BC(var_0) {
  var_0 thread _id_1196(var_0);
  var_0 thread _id_1197(var_0);
}

_id_F9C9(var_0) {
  var_0 notify("remove_crouch_speed_mod");
  var_0._id_10DBB = undefined;
}

_id_1197(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("remove_crouch_speed_mod");

  for(;;) {
    self waittill("sprint_slide_end");

    if(var_0 getstance() == "crouch") {
      if(isDefined(level._id_A201)) {
        var_0._id_10DBB = 0.5;
        var_0[[level._id_A201]]();
      }
    }

    while(var_0 getstance() == "crouch") {
      wait 0.1;
    }

    var_0._id_10DBB = undefined;
    var_0[[level._id_A201]]();
  }
}

_id_1196(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("remove_crouch_speed_mod");

  for(;;) {
    if(var_0 getstance() == "crouch") {
      if(isDefined(level._id_A201)) {
        var_0._id_10DBB = 0.5;
        var_0[[level._id_A201]]();
      }
    }

    while(var_0 getstance() == "crouch") {
      wait 0.1;
    }

    var_0._id_10DBB = undefined;
    var_0[[level._id_A201]]();
    var_0 waittill("adjustedStance");
  }
}

_id_8023(var_0) {}

_id_D2C8(var_0) {
  var_0 scripts\cp\utility::_id_5201(1);
  var_0._id_B018["passive_infinite_ammo"] = 1;
}

_id_F9D5(var_0) {
  var_0 scripts\cp\utility::_id_5201(0);
  var_0._id_B018["passive_infinite_ammo"] = 0;
  var_0 notify("cleanup_watcher_threads_passive_infinite_ammo");
}

_id_7460(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("cleanup_watcher_threads_passive_infinite_ammo");

  for(;;) {
    var_0 waittill("weapon_fired", var_2);
    var_0 thread _id_9547();
    var_3 = 4;
    var_4 = self.health;

    if(var_4 - var_3 < 1) {
      var_3 = 0;
    }

    if(var_3 > 0) {
      var_0 dodamage(var_3, var_0 gettagorigin("j_wrist_ri"), var_0, undefined, "MOD_RIFLE_BULLET");
    }

    var_0 _id_FC8E(var_2);
  }
}

_id_9547() {
  self endon("disconnect");
  self endon("last_stand");
  self notify("infinite_ammo_fire");
  self endon("infinite_ammo_fire");
  self._id_D081 = 1;
  wait 0.2;
  self._id_D081 = 0;
}

_id_FC8E(var_0) {
  var_1 = self.health;
  var_2 = weaponclipsize(var_0);
  self setweaponammoclip(var_0, var_2);

  if(self _meth_81BC()) {
    self setweaponammoclip(var_0, var_2, "left");
  }
}

_id_802A(var_0) {}

_id_D2CF(var_0) {
  var_1 = var_0 getcurrentweapon();
  var_0 thread _id_9FA2(var_1);
}

_id_F9DC(var_0) {
  var_0 notify("removeMissRefundPassive");
}

_id_9FA2(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  for(;;) {
    self waittill("shot_missed", var_1);

    if(var_1 == var_0) {
      if(randomfloat(1.0) > 0.75) {
        var_2 = self getweaponammostock(var_0);
        self setweaponammostock(var_0, var_2 + 1);
      }
    }
  }
}

_id_8038(var_0) {}

_id_D2DD(var_0) {
  var_0 thread _id_747D(var_0);
}

_id_F9EA(var_0) {
  var_0 notify("handlePassiveScrambler");
}

_id_CC55(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = spawn("script_model", self gettagorigin("tag_eye"));
  var_1 setModel("prop_mp_optic_wave_scr");
  var_1.angles = self getplayerangles();
  var_1 setotherent(self);
  var_1 setscriptablepartstate("effects", "active", 0);
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 256;
  var_1 moveto(var_2, var_0);
  scripts\engine\utility::_id_108A8(var_0, "last_stand", "death");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_747D(var_0) {
  var_0 notify("handlePassiveScrambler");
  var_0 endon("handlePassiveScrambler");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");

  for(;;) {
    if(randomint(100) > 85) {
      var_1 = _id_06FE::_id_68A1("axis");
      var_2 = scripts\engine\utility::_id_6369(var_0.origin, var_1, undefined, 24, 256);
      var_3 = 0;

      foreach(var_5 in var_2) {
        if(scripts\engine\utility::_id_10E76(var_0 getEye(), var_0.angles, var_5.origin, cos(65))) {
          if(!var_3) {
            var_0 thread _id_CC55(0.8);
          }

          thread _id_CC56(var_5, var_0);
          var_3++;
        }

        if(var_3 >= 5) {
          break;
        }
      }
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

_id_CC56(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(var_0._id_EAA4)) {
    if(gettime() > var_0._id_EAA4) {
      var_0._id_0043 = 1;
      var_0._id_EAA4 = gettime() + 1000;
      var_0._id_EAAB = 1;
    } else
      return;
  } else {
    var_0._id_0043 = 1;
    var_0._id_EAA4 = gettime() + 1000;
    var_0._id_EAAB = 1;
  }

  var_0 dodamage(1, var_0.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_scrambler_zm");
  var_0 thread _id_10B8(var_0);
  wait 1;
  var_0._id_0043 = 0;
  var_0._id_EAAB = undefined;
}

_id_10B8(var_0) {
  var_0 endon("death");
  waittillframeend;

  if(var_0.health < var_0.maxhealth) {
    var_0.health = var_0.health + 1;
  }
}

_id_8032(var_0) {
  var_0._id_AEAB = 0;
  var_0 thread _id_F419(var_0);
}

_id_F419(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("last_stand");
    var_0._id_AEAB = 0;
  }
}

_id_D2D7(var_0) {
  var_0._id_AB11["passive_random_perks"] = 1;
}

_id_F417(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_1 endon("death");
  var_1._id_AEAB++;

  if(var_1._id_AEAB >= 75) {
    var_6 = level.perks;
    var_1._id_AEAB = 0;

    if(!isDefined(var_1._id_11086) || var_1._id_11086.size < 5) {
      for(;;) {
        var_7 = scripts\engine\utility::random(var_6);

        if(!var_1 scripts\cp\utility::_id_7531(var_7)) {
          var_1 iprintln(" zombies_perk_machines is disabled for now!. Can be reenabled based on requirements. ");
          break;
        } else
          var_6 = scripts\engine\utility::array_remove(var_6, var_7);

        waitframe();
      }
    }
  }
}

_id_F9E4(var_0) {
  var_0._id_AB11["passive_random_perks"] = 0;
}

_id_8028(var_0) {}

_id_D2CD(var_0) {
  var_0._id_DDA0 = 1;
  var_0._id_AB11["passive_melee_super"] = 1;
}

_id_F9DA(var_0) {
  var_0._id_DDA0 = undefined;
  var_0._id_AB11["passive_melee_super"] = 0;
}

_id_746B(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_1 endon("disconnect");

  if(isDefined(var_3) && var_3 == "MOD_MELEE") {
    var_1 notify("consumable_charge", 125);
  }
}

_id_8024(var_0) {}

_id_D2C9(var_0) {
  var_0._id_AB11["passive_jump_super"] = 1;
  var_0._id_41AB = scripts\cp\utility::_id_6CE3(var_0 getcurrentweapon());
}

_id_F9D6(var_0) {
  var_0._id_AB11["passive_jump_super"] = 0;
  var_0._id_41AB = undefined;
}

_id_741A(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_1 endon("disconnect");

  if(!var_1 isonground() && (isDefined(var_1._id_41AB) && scripts\cp\utility::_id_6CE3(var_0) == var_1._id_41AB)) {
    var_1 notify("consumable_charge", 75);
  }
}

_id_8019(var_0) {}

_id_D2BE(var_0) {
  var_0._id_AB11["passive_double_kill_super"] = 1;
  var_0._id_41AA = scripts\cp\utility::_id_6CE3(var_0 getcurrentweapon());
}

_id_F9CB(var_0) {
  var_0._id_AB11["passive_double_kill_super"] = 0;
  var_0._id_41AA = undefined;
}

_id_743A(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_1 endon("disconnect");

  if(isDefined(var_1._id_C0F3) && (isDefined(var_1._id_41AA) && scripts\cp\utility::_id_6CE3(var_0) == var_1._id_41AA)) {
    if(var_1._id_C0F3 == 2) {
      var_1 notify("consumable_charge", 125);
    }
  }
}

_id_802B(var_0) {}

_id_D2D0(var_0) {
  var_0._id_1647 = 1;
  var_0._id_3300 = scripts\cp\utility::_id_6CE3(var_0 getcurrentweapon());
  var_0._id_32FF = var_0._id_32FF + 0.1;
}

_id_F9DD(var_0) {
  var_0._id_32FF = var_0._id_32FF - 0.1;
  var_0._id_3300 = undefined;
  var_0._id_1647 = 0;
}

_id_803A(var_0) {}

_id_D2E0(var_0) {
  var_0._id_AB11["passive_visor_detonation"] = 1;
}

_id_F9EC(var_0) {
  var_0._id_AB11["passive_visor_detonation"] = 0;
}

_id_74AA(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!scripts\engine\utility::_id_8794(var_3)) {
    return 0;
  }

  if(!scripts\cp\utility::_id_8891(var_0, var_4, var_3, var_1)) {
    return 0;
  }

  if(isDefined(var_2._id_1210) && (var_2._id_1210 == "zombie_brute" || var_2._id_1210 == "zombie_grey" || var_2._id_1210 == "slasher" || var_2._id_1210 == "superslasher" || var_2._id_1210 == "zombie_sasquatch" || var_2._id_1210 == "lumberjack")) {
    return;
  }
  var_6 = istrue(var_2._id_86D9);
  var_2._id_75DE = 1;
  var_7 = var_2 gettagorigin("j_spine4");
  playsoundatpos(var_2.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_7);

  if(isDefined(var_2._id_7611)) {
    var_2 detach(var_2._id_7611);
  }

  if(!var_6) {
    var_2 setscriptablepartstate("head", "hide");
  }
}

_id_AEA4() {
  self endon("death");
  self endon("disconnect");
  self endon("end_passive_visor_detonation");

  for(;;) {
    self waittill("headshot_done_with_this_weapon", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    waitframe();
  }
}

_id_8015(var_0) {}

_id_D2BA(var_0) {
  var_0._id_AB11["passive_berserk"] = 1;
}

_id_F9C7(var_0) {
  var_0._id_AB11["passive_berserk"] = 0;
}

_id_741F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!istrue(var_1._id_24CD)) {
    var_1._id_24CD = 1;
    var_1 _meth_8612(65);
    var_6 = var_1 _meth_8611();

    if(var_6 < 0) {
      var_6 = 100;
    }

    var_6 = max(var_6 - 20, 0);
    var_1 player_recoilscaleon(int(var_6));
  }

  var_1 notify("stop_berserk_timer");
  var_1 thread _id_C383(2);
}

_id_C383(var_0) {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("death");
  self endon("disconnect");
  thread _id_9541();
  wait(var_0);
  _id_F9B6();
}

_id_9541() {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "weapon_change");
  _id_F9B6();
}

_id_F9B6() {
  if(istrue(self._id_24CD)) {
    self._id_24CD = 0;
    self _meth_8613();
    var_0 = self _meth_8611();
    var_0 = min(var_0 + 20, 100);
    self player_recoilscaleon(int(var_0));
    self notify("end_berserk");
  }
}

_id_FAD8() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  _id_F9B6();
}

_id_8026(var_0) {}

_id_D2CB(var_0) {
  var_0._id_AB11["passive_melee_cone_expl"] = 1;
  var_0._id_DDA0 = 1;
}

_id_F9D8(var_0) {
  var_0._id_AB11["passive_melee_cone_expl"] = 0;
  var_0._id_DDA0 = undefined;
}

_id_7467(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_3 != "MOD_MELEE") {
    return;
  }
  if(!issubstr(var_0, "meleervn") && !var_1 _meth_8543(var_0)) {
    return;
  }
  var_6 = var_2 gettagorigin("j_spineupper");
  var_7 = var_1 getplayerangles();
  var_8 = anglesToForward(var_7);
  var_9 = anglestoup(var_7);
  var_10 = var_6 - var_8 * 128;
  var_11 = 384;
  playFX(level._effect["cone_expl_fx"], var_6 + (0, 2, 0), var_8, var_9);
  var_12 = _id_06FE::_id_6322();

  foreach(var_14 in var_12) {
    if(isDefined(var_14._id_5D22) || isDefined(var_14._id_1210) && (var_14._id_1210 == "zombie_brute" || var_14._id_1210 == "zombie_ghost" || var_14._id_1210 == "zombie_grey" || var_14._id_1210 == "slasher" || var_14._id_1210 == "superslasher")) {
      continue;
    }
    if(!scripts\engine\math::_id_B9C2(var_14 gettagorigin("tag_origin"), var_10, var_8, var_9, var_11, 128, 12)) {
      continue;
    }
    if(var_14 _meth_8096(var_6, var_1) <= 0) {
      continue;
    }
    var_15 = int(1500 * var_1 scripts\cp\cp_weapon::_id_683D(var_0));
    wait 0.05;
    var_14 dodamage(var_15, var_6, var_1, var_1, "MOD_EXPLOSIVE", var_0);
  }
}

_id_8029(var_0) {}

_id_D2CE(var_0) {
  var_0._id_AAA0["passive_minimap_damage"] = 1;
}

_id_F9DB(var_0) {
  var_0._id_AAA0["passive_minimap_damage"] = 0;
}

_id_FCEC(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return;
  }
  var_3 = "outlinefill_depth_orange";

  if(isDefined(var_2._id_42EE)) {
    var_3 = "outlinefill_depth_yellow";
  }

  if(isDefined(var_2._id_9B32)) {
    var_3 = "outlinefill_depth_white";
  } else {
    var_3 = "outlinefill_depth_orange";
  }

  level thread _id_D2B7(var_0, var_2, var_3);
}

_id_5210(var_0, var_1, var_2, var_3) {
  var_0 _meth_81B2(var_1, var_2);
}

_id_D2B7(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = "outlinefill_depth_orange";
  }

  _id_5210(var_1, level.players, var_2, "high");
  wait 10;
  _id_F9C5(var_1);
}

_id_4A30(var_0, var_1) {
  var_0 _meth_81AF(var_1);
}

_id_F9C5(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_074A::_id_4A30(var_0, level.players);
}

_id_0E98(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 scripts\cp\utility::_id_10A2("health_boost", 0.2, 0);
  var_0 notify("force_regeneration");
  var_0 playlocalsound("breathing_heartbeat_alt");
  wait 5;
  var_0 scripts\cp\utility::_id_C48A("health_boost", 0);
  var_0 playlocalsound("breathing_limp");
}

_id_11AA(var_0) {
  var_0 notify("updatepassiveminimapdamage");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");

  for(;;) {
    if(randomint(100) > 30) {
      thread _id_C9A4(var_0, 5);
      thread _id_0E98(var_0);
    }

    wait(randomfloatrange(5.0, 15.0));
  }
}

_id_C36F(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 visionsetnakedforplayer("", 0.5);
}

_id_C9A4(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 endon("remove_adrenaline_visuals");
  var_0 visionsetnakedforplayer("missilecam", scripts\engine\utility::ter_op(1, 0.1, 0.0));
  var_0 scripts\engine\utility::_id_108A7(var_1, "last_stand");
  var_0 thread _id_C36F(var_0);
}

_id_8016(var_0) {}

_id_D2BB(var_0) {
  var_0._id_AAA0["passive_cold_damage"] = 1;
  var_0._id_3A32 = var_0 getcurrentweapon();
}

_id_F9C8(var_0) {
  var_0._id_AAA0["passive_cold_damage"] = 0;
  var_0._id_3A32 = undefined;
}

_id_FCEB(var_0, var_1, var_2) {
  var_3 = isDefined(var_2._id_1210) && var_2._id_1210 == "zombie_brute";
  var_4 = isDefined(var_2._id_1210) && var_2._id_1210 == "zombie_grey";
  var_5 = istrue(var_2._id_86D9);

  if(var_3 || var_4 || var_5) {
    return;
  }
  if(isDefined(var_0._id_3A32)) {
    if(scripts\cp\utility::_id_6CE3(var_0._id_3A32) == scripts\cp\utility::_id_6CE3(var_1)) {
      var_2 thread _id_FAFB(var_2, var_2._id_02D6);
      var_2._id_02D6 = "slow_walk";
      var_2 _id_06BD::_id_23F3("slow_walk");
    }
  }
}

_id_FAFB(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  wait 10;

  if(isDefined(var_1)) {
    var_0._id_02D6 = var_1;
    var_0 _id_06BD::_id_23F3(var_1);
  }
}

_id_8036(var_0) {}

_id_D2DB(var_0) {
  var_0._id_E3C7 = 1.1;
}

_id_F9E8(var_0) {
  var_0._id_E3C7 = undefined;
}

_id_8034(var_0) {
  var_0._id_0ECA = 0;
  var_0 notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  var_0 notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
}

_id_D2D9(var_0) {
  var_0 thread _id_FD1A(var_0);
}

_id_F9E6(var_0) {
  var_0 notify("unsetScopeRadar");
  var_0 thread _id_385F(var_0);
}

_id_FD1A(var_0) {
  var_0 notify("updateScopeRadar");
  var_0 endon("updateScopeRadar");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("unsetScopeRadar");
  var_1 = 2.4;
  var_2 = 1750;

  for(;;) {
    if(!var_0 adsbuttonpressed()) {
      var_3 = var_0 scripts\engine\utility::_id_108A2("scope_radar_ads_in", "scope_radar_ads_out", "last_stand", "death", "weapon_change");
    } else {
      var_3 = "scope_radar_ads_in";
    }

    if(var_3 == "scope_radar_ads_in") {
      _id_CA70(var_0, var_1, var_2);
    }

    var_0 thread _id_C45D(var_0);
  }
}

_id_CA70(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 notify("runScopeRadarInLoop");
  var_0 endon("runScopeRadarInLoop");
  var_0 endon("scope_radar_ads_out");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_3 = 0.75;

  while(var_0 adsbuttonpressed()) {
    if(var_0 playerads() >= var_3) {
      var_0 playlocalsound("uav_ping");
      var_0 thread _id_CBD8(var_0, var_1, var_2);
      var_0 _id_CBD9(var_0, var_1);
    }

    waitframe();
  }
}

_id_CBD8(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("scope_radar_ads_out");
  var_3 = 0;
  var_4 = _id_06FE::_id_68A1("axis");
  var_5 = scripts\engine\utility::_id_6369(var_0.origin, var_4, undefined, 24, var_2);
  var_0._id_39F0 = var_5;
  var_6 = 0;

  foreach(var_8 in var_0._id_39F0) {
    var_8._id_8655 = 0;

    if(scripts\engine\utility::_id_10E76(var_0 getEye(), var_0.angles, var_8.origin, cos(65))) {
      var_6++;
      var_9 = var_8.origin - var_0.origin;

      if(1 && vectordot(anglesToForward(var_0.angles), var_9) < 0) {
        continue;
      }
      var_10 = var_2 * var_2;

      if(_func_0134(var_9) > var_10) {
        continue;
      }
      var_0 thread _id_ACF6(var_8, var_0, distance2d(var_0.origin, var_8.origin) / var_2, var_1);
      var_3 = 1;
    }
  }
}

_id_520F(var_0, var_1, var_2, var_3) {
  var_0 _meth_81B1(var_1, var_2);
}

_id_ACF6(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("scope_radar_ads_out");
  var_1 endon("last_stand");
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("weapon_change");
  wait(var_3 * var_2);
  var_4 = 1;
  var_0._id_8655 = 1;
  _id_520F(var_0, var_1, var_4, 1, 1, "high");
}

_id_10B7E(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 scripts\engine\utility::_id_108AE(var_2);

  if(isDefined(var_1)) {
    _id_4A2F(var_1, var_0);
  }
}

_id_4A2F(var_0, var_1) {
  var_0 _meth_81AE(var_1);
}

_id_CBD9(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 visionsetnakedforplayer("opticwave_mp", 0.2);
  var_0._id_6089 = spawn("script_model", var_0 gettagorigin("tag_eye"));
  var_0._id_6089 setModel("prop_mp_optic_wave_scr");
  var_0._id_6089.angles = var_0 getplayerangles();
  var_0._id_6089 setotherent(var_0);
  var_0._id_6089 setscriptablepartstate("effects", "active", 0);
  var_2 = var_0._id_6089.origin + anglesToForward(var_0._id_6089.angles) * 1750;
  var_0._id_6089 moveto(var_2, var_1);
  var_0 scripts\engine\utility::_id_108B2(var_1, "last_stand", "death", "scope_radar_ads_out", "weapon_change", "unsetScopeRadar");

  if(isDefined(var_0._id_39F0)) {
    foreach(var_4 in var_0._id_39F0) {
      if(isDefined(var_4)) {
        if(istrue(var_4._id_8655)) {
          _id_4A2F(var_4, var_0);
          var_4._id_8655 = 0;
        }
      }
    }
  }

  var_0 visionsetnakedforplayer("", 0.1);

  if(isDefined(var_0._id_6089)) {
    var_0._id_6089 delete();
  }
}

_id_C45D(var_0) {
  var_1 = _id_06FE::_id_68A1("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(istrue(var_3._id_8655)) {
        _id_4A2F(var_3, var_0);
        var_3._id_8655 = 0;
      }
    }
  }

  if(isDefined(var_0._id_6089)) {
    var_0._id_6089 delete();
  }
}

_id_385F(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_1 = _id_06FE::_id_68A1("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(istrue(var_3._id_8655)) {
        _id_4A2F(var_3, var_0);
        var_3._id_8655 = 0;
      }
    }
  }
}

_id_8037(var_0) {}

_id_D2DC(var_0) {
  var_0 thread _id_FD1D(var_0);
}

_id_F9E9(var_0) {
  var_0 notify("unsetScoutPing");
}

_id_FD1D(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("unsetScoutPing");
  var_1 = 1000;
  var_2 = 0.1;

  for(;;) {
    var_3 = _id_06FE::_id_68A1("axis");
    var_4 = var_1;
    var_5 = var_2;
    var_4 = int(var_4);
    var_5 = float(var_5);

    if(isDefined(var_3)) {
      var_6 = scripts\engine\utility::_id_6369(var_0.origin, var_3, undefined, 24, var_4);
    } else {
      waitframe();
      continue;
    }

    if(var_6.size >= 1) {
      foreach(var_8 in var_6) {
        _id_074A::_id_5210(var_8, level.players, "outline_nodepth_red", "low");
        wait(var_5);
      }

      continue;
    }

    waitframe();
  }
}

_id_FCDA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = getarraykeys(var_1._id_AB11);

  if(!isDefined(var_1._id_AB11)) {
    return;
  }
  if(!isDefined(var_6)) {
    return;
  }
  foreach(var_8 in var_6) {
    if(istrue(var_1._id_AB11[var_8])) {
      thread[[level._id_AB11[var_8]]](var_0, var_1, var_2, var_3, var_4, var_5);
    }
  }
}

_id_FCED(var_0) {
  var_1 = gettime();
  var_2 = getarraykeys(var_0._id_B018);

  if(!isDefined(var_2)) {
    return;
  }
  foreach(var_4 in var_2) {
    if(istrue(var_0._id_B018[var_4])) {
      var_0 thread[[level._id_B018[var_4]]](var_0);
    }
  }
}

_id_FCD6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isPlayer(var_2)) {
    var_6 = var_2;
  } else if(isPlayer(var_0)) {
    var_6 = var_0;
  }

  if(!isDefined(var_6)) {
    return;
  }
  if(!isDefined(var_6._id_AAA0)) {
    return;
  }
  var_5 = gettime();
  var_7 = getarraykeys(var_6._id_AAA0);

  if(!isDefined(var_7)) {
    return;
  }
  foreach(var_9 in var_7) {
    if(istrue(var_6._id_AAA0[var_9])) {
      thread[[level._id_AAA0[var_9]]](var_0, var_1, var_2, var_3, var_4, var_5);
    }
  }
}

init() {
  _id_95DF();
  _id_C213();
  _id_C30B();
  level thread _id_B3F8();
}

_id_95DF() {
  level._effect["headshot_explode"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode.vfx");
  level._effect["headshot_explode_jugg"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode_jug.vfx");
}

_id_B3F8() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    _id_8091(var_0);
    var_0 thread _id_C30C();
  }
}

_id_8091(var_0) {
  var_0._id_AB11 = [];
  var_0._id_B018 = [];
  var_0._id_AAA0 = [];
  var_0._id_C30A = [];
}

_id_C30B() {
  level endon("game_ended");
  _id_95DE();
}

_id_C30C() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("relics_monitor");
  var_0 endon("relics_monitor");
  var_0._id_0EEE = [];
  scripts\engine\utility::_id_5C24("create_script_initialized");
  var_0 _id_7EC4(var_0);

  for(;;) {
    var_0 waittill("relic_update", var_1, var_2);

    if(isDefined(var_2)) {
      if(!istrue(var_2)) {
        _id_FA3D(var_0, var_1);
        continue;
      }

      _id_D386(var_0, var_1);
    }
  }
}

_id_95DE() {
  level._id_D386 = [];
  var_0 = getDvar("#x3359dcde5b6e0e6ac", "");
  var_1 = strtok(var_0, ",");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && var_3 != "") {
      level._id_D386[var_3] = 1;
    }
  }
}

_id_95E0() {
  level endon("game_ended");
  level._id_D386 = [];

  for(;;) {
    var_0 = getDvar("#x3359dcde5b6e0e6ac", "");
    var_1 = strtok(var_0, ",");

    foreach(var_3 in var_1) {
      if(istrue(level._id_D386[var_3])) {
        waitframe();
        continue;
      }

      if(isDefined(var_3) && var_3 != "") {
        level._id_D386[var_3] = 1;

        foreach(var_5 in level.players) {
          var_5 notify("relic_update", var_3, 1);
        }
      }
    }

    waitframe();
  }
}

_id_D400(var_0) {
  var_1 = _func_0222("cp/cp_relic_table.csv", 1, var_0, 0);
  var_2 = int(var_1);
  self _meth_82F8("cp_active_relics", var_2 - 1, 1);
}

_id_F976() {
  level endon("game_ended");

  for(;;) {
    var_0 = getDvar("#x3857d32c992adc5db", "");
    var_1 = strtok(var_0, ",");

    foreach(var_3 in var_1) {
      if(istrue(level._id_D386[var_3])) {
        if(isDefined(var_3) && var_3 != "") {
          foreach(var_5 in level.players) {
            var_5 notify("relic_update", var_3, 0);
          }

          level._id_D386[var_3] = undefined;
        }
      }
    }

    waitframe();
  }
}

_id_4486(var_0, var_1) {
  if(isDefined(var_1) && isDefined(level._id_3E19[var_1])) {
    var_0._id_C30A[var_1] = level._id_3E19[var_1];
    _id_D386(var_0, var_1);
  }
}

_id_44A8(var_0, var_1) {
  if(isDefined(var_1) && isDefined(level._id_3E19[var_1])) {
    var_0._id_C30A[var_1] = level._id_3E19[var_1];
    _id_FA3D(var_0, var_1);
  }
}

_id_7EC4(var_0) {
  foreach(var_4, var_2 in level._id_D386) {
    var_3 = level._id_3E19[var_4];
    var_4 = var_3.name;
    _id_D386(var_0, var_4);
  }
}

_id_FA3D(var_0, var_1) {
  var_2 = level._id_3E19[var_1];

  if(isDefined(var_2)) {
    if(isDefined(var_2) && isDefined(var_2._id_F9BC)) {
      [[var_2._id_F9BC]](var_0);
    }

    var_0._id_0EEE = scripts\engine\utility::array_remove(var_0._id_0EEE, var_2.name);
  }
}

_id_D386(var_0, var_1) {
  var_2 = level._id_3E19[var_1];

  if(isDefined(var_2)) {
    if(isDefined(var_2) && isDefined(var_2._id_7F8B)) {
      [[var_2._id_7F8B]](var_0);
    }
  }

  if(isDefined(var_2) && isDefined(var_2._id_D21C)) {
    [[var_2._id_D21C]](var_0);
  }

  if(isDefined(level._id_FCEE)) {
    level thread[[level._id_FCEE]](var_0);
  }

  var_0._id_0EEE = scripts\engine\utility::array_add(var_0._id_0EEE, var_2.name);
  var_0 _id_D400(var_2.name);
}

_id_C212(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_7F8B = var_1;
  var_4._id_D21C = var_2;
  var_4._id_F9BC = var_3;
  var_4.name = var_0;
  level._id_3E19[var_0] = var_4;
}

_id_AE75() {
  if(!isDefined(level._id_9897)) {
    level._id_9897 = [];
  }

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 1);
    var_3 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 2);
    var_4 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 12);
    var_5 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 13);
    var_6 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 15);
    var_7 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 23);
    var_8 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 24);
    var_9 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 25);
    var_10 = spawnStruct();
    var_10.name = var_2;
    var_10._id_AEAD = var_3;
    var_10._id_AEA7 = int(var_1);
    var_10._id_10DE7 = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 8) == "", 0, 1);
    var_10._id_8DEC = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 9) == "", 0, 1);
    var_10._id_91E7 = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 10) == "", 0, 1);
    var_10._id_ED2D = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 11) == "", 0, 1);

    if(var_4 != "") {
      var_10._id_1DAE = var_4;
    }

    if(getDvar("#x3a30c33efc8281eb1") == "zombie" || getDvar("#x3a30c33efc8281eb1") == "cp_strike") {
      var_11 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var_0, 22);

      if(var_11 != "") {
        var_10._id_1DAE = var_11;
      }
    }

    if(var_5 != "") {
      var_10._id_AFF6 = var_5;
    }

    if(var_6 != "") {
      var_10._id_9DE9 = var_6;
    }

    if(isDefined(var_7)) {
      var_10._id_BB30 = int(var_7);
    }

    if(isDefined(var_8)) {
      var_10._id_BB2F = float(var_8);
    }

    if(isDefined(var_9)) {
      var_10._id_9C9E = int(var_9);
    }

    if(!isDefined(level._id_9897[var_2])) {
      level._id_9897[var_2] = var_10;
    }

    var_0++;
  }
}

_id_FD0E(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self._id_C0F3++;
  var_2 = getweaponbasename(var_1);

  if(!isDefined(self._id_8DA4[var_2])) {
    self._id_8DA4[var_2] = 1;
  } else {
    self._id_8DA4[var_2]++;
  }

  if(!isDefined(self._id_C0F4)) {
    self._id_C0F4 = [];
  }

  if(!isDefined(self._id_C0F4[var_2])) {
    self._id_C0F4[var_2] = 1;
  } else {
    self._id_C0F4[var_2]++;
  }

  wait 3.5;
  self._id_C0F3 = 0;
  self._id_C0F4 = undefined;
}

_id_8089(var_0) {}

_id_D37D(var_0) {
  var_0._id_AAA0["relic_collat_dmg"] = 1;
  level._id_57E7 = 0.4;
  var_0._id_AB11["relic_collat_dmg"] = 1;
}

_id_FA35(var_0) {
  level._id_57E7 = undefined;
  var_0._id_AAA0["relic_collat_dmg"] = 0;
  var_0._id_AB11["relic_collat_dmg"] = 0;
}

_id_AA9F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isagent(var_2)) {
    return;
  }
  if(!scripts\cp\utility::_id_8891(var_1, var_4, var_3, var_0)) {
    return;
  }
  var_2._id_5EAA = 1;
}

_id_748A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!scripts\cp\utility::_id_8891(var_0, var_4, var_3, var_1) && (var_3 != "MOD_MELEE" && var_3 != "MOD_EXECUTION")) {
    return;
  }
  var_6 = isDefined(var_2._id_04B9) && var_2._id_04B9 == "juggernaut";
  var_7 = var_2.origin;

  if(var_2 tagexists("j_head")) {
    var_7 = var_2 gettagorigin("j_head");
  } else if(var_2 tagexists("tag_eye")) {
    var_7 = var_2 gettagorigin("tag_eye");
  }

  if(var_6) {
    _func_01BA(var_2.origin + (0, 0, 60), 512, 666, 69, undefined, "MOD_RIFLE_BULLET");
    _id_0956::_id_CA2A("Earthquake", 1.0, 0.6, var_2.origin, 84);
    playFX(level._effect["headshot_explode_jugg"], var_7);
    var_2 playSound("gib_fullbody");
  } else {
    _func_01BA(var_2.origin + (0, 0, 60), 333, 333, 33, undefined, "MOD_RIFLE_BULLET");
    _id_0956::_id_CA2A("Earthquake", 1.0, 0.6, var_2.origin, 84);
    playFX(level._effect["headshot_explode"], var_7);
    var_2 playSound("gib_fullbody");
  }

  playrumbleonposition("grenade_rumble", var_2.origin);
}

_id_8088(var_0) {
  level._id_7142 = [];
}

_id_D37C(var_0) {
  var_0._id_AB11["relic_catch"] = 1;
  _id_06FC::_id_C1DE("grenade", ::_id_4FE5, ::_id_DA94, 0);
  _id_0743::_id_0FDD("axis", ::_id_95DB);
}

_id_FA34(var_0) {
  var_0._id_AB11["relic_catch"] = 0;
  _id_0743::_id_C3E5("axis", ::_id_95DB);
}

_id_7489(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_4FE5(var_0, var_1, var_2) {
  var_3 = self.origin;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = "offhand_wm_grenade_mike67";

  if(isDefined(level._id_125F)) {
    var_4 = level._id_125F;
  }

  var_5 = 1;

  if(isDefined(level._id_1260)) {
    var_5 = level._id_1260;
  }

  var_6 = 200;

  if(isDefined(level._id_1261)) {
    var_6 = level._id_1261;
  }

  var_7 = &"COOP_GAME_PLAY/PICK_GRENADE";

  if(isDefined(level._id_1262)) {
    var_7 = level._id_1262;
  }

  var_8 = scripts\cp\utility::_id_3FF0(var_3, "HINT_BUTTON", "cp_crate_icon_lethalrefill", var_7, 5, "duration_short", "show", var_6, undefined, 100, 360);
  var_8 setModel(var_4);
  var_8 thread _id_0EB1();
  var_8 thread scripts\cp\utility::_id_46C7(30);

  if(isDefined(var_2) && istrue(var_5)) {
    foreach(var_10 in level.players) {
      if(var_10 != var_2) {
        var_8 hidefromplayer(var_10);
      }
    }
  }
}

_id_0EB1() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 _meth_84AF("ges_pickup");
    var_0 playlocalsound("weap_ammo_pickup");

    foreach(var_2 in var_0._id_BADE) {
      if(isDefined(level._id_1263)) {
        var_3 = 0;

        if(isDefined(var_0._id_BADE[level._id_1263])) {
          var_3 = var_0._id_BADE[level._id_1263]._id_3411;
        }

        var_4 = var_0 _id_073C::_id_65FC(var_0, "primary");

        if(var_3 >= var_4) {
          var_3 = var_4 - 1;
        }

        var_0 _id_0753::_id_6FD3(level._id_1263, "primary", undefined, undefined, undefined, 0, 0, var_3 + 1);
      } else
        var_0 notify("pickup_equipment", var_2._id_10DE9);

      waitframe();
    }

    self delete();
  }
}

_id_DA94(var_0) {
  var_1 = getdvarint("#x324254eb05d3ae67f");

  if(var_1) {
    return 1;
  }

  if(!isDefined(level._id_7142)) {
    return 0;
  }

  if(isDefined(self._id_04B9) && self._id_04B9 == "suicidebomber") {
    return 0;
  }

  if(!isDefined(var_0._id_50FF)) {
    return 0;
  }

  var_2 = 15;
  var_3 = gettime();
  var_4 = var_0._id_50FF getentitynumber();

  if(!isDefined(level._id_7142[var_4])) {
    level._id_7142[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  if(var_3 > level._id_7142[var_4]) {
    level._id_7142[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  return 0;
}

_id_95DB() {
  self._id_CD57 = 1;
  self._id_0206 = 255;
}

_id_8087(var_0) {}

_id_D37B(var_0) {
  var_0._id_AB11["relic_boom"] = 1;
}

_id_FA33(var_0) {
  var_0._id_AB11["relic_boom"] = 0;
}

_id_7488(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = magicgrenademanual("thermite_mp", var_2.origin, (0, 0, 0));
  var_6.owner = var_2;
  var_2 thread _id_0920::_id_F0FB(var_6);
}

_id_8090(var_0) {
  _id_0956::_id_C24B("Earthquake", ::earthquake, 5, ::_id_1537, 0, 0, 0, 1, 1);
}

_id_1537(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return 1;
}

_id_D385(var_0) {
  var_0._id_AAA0["relic_swat"] = 1;

  if(!scripts\engine\utility::array_contains(level._id_A00C, ::_id_C309)) {
    level._id_A00C = scripts\engine\utility::array_add(level._id_A00C, ::_id_C309);
  }
}

_id_869A() {
  return istrue(level._id_D386["relic_swat"]);
}

_id_8699() {
  return istrue(level._id_D386["relic_collat_dmg"]);
}

_id_FA3C(var_0) {
  var_0._id_AAA0["relic_swat"] = 0;
  level._id_A00C = scripts\engine\utility::array_remove(level._id_A00C, ::_id_C309);
}

_id_C309(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    return var_2;
  }

  if(isDefined(var_1.owner)) {
    if(!isPlayer(var_1.owner)) {
      return var_2;
    }
  }

  if(!isPlayer(var_1)) {
    return var_2;
  }

  var_8 = var_3 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_7) && var_7 == "none") || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH";
  var_9 = var_3 == "MOD_FIRE";
  var_10 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_11 = var_10 && var_3 == "MOD_CRUSH";
  var_12 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && !isDefined(var_1.owner);
  var_13 = var_12 && var_3 == "MOD_CRUSH";
  var_14 = var_3 == "MOD_CRUSH";
  var_15 = var_3 == "MOD_EXECUTION";
  var_16 = var_3 == "MOD_MELEE";
  var_17 = var_15 || var_16 || var_14 || var_10 || var_11 || var_12 || var_13 || _id_8619(var_4) || scripts\cp\utility::_id_8891(var_4, var_7, var_3, var_1);

  if(1) {
    if(isPlayer(var_1) && isai(var_0)) {
      if(var_17) {
        return var_2;
      } else {
        return 0;
      }
    } else
      return var_2;
  } else if(var_17)
    return var_2;
  else {
    return 0;
  }
}

_id_8619(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0.basename) {
    case "nuke_mp":
    case "cruise_proj_mp":
      return 1;
    case "fuelstrike_proj_mp":
    case "bradley_tow_proj_ks_mp":
    case "emp_drone_non_player_direct_mp":
    case "hover_jet_proj_mp":
    case "bradley_tow_proj_mp":
    case "apache_proj_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "ac130_105mm_mp":
    case "at_mine_mp":
    case "emp_drone_non_player_mp":
      return 1;
    case "white_phosphorus_proj_mp":
    case "lighttank_tur_ks_mp":
    case "lighttank_mp":
    case "lighttank_tur_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mp":
    case "technical_mp":
    case "toma_proj_mp":
    case "ac130_40mm_mp":
      return 1;
    case "pac_sentry_turret_mp":
    case "thermite_bolt_mp":
    case "thermite_av_mp":
    case "artillery_mp":
    case "at_mine_ap_mp":
    case "ac130_25mm_mp":
    case "claymore_mp":
    case "c4_mp_p":
    case "frag_grenade_mp":
    case "semtex_mp":
      return 1;
    default:
      return 0;
  }
}

_id_748B(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_808D(var_0) {}

_id_D381(var_0) {
  while(!isDefined(var_0._id_7235)) {
    waitframe();
  }

  var_0._id_A997 = var_0.maxhealth;
  var_0._id_A995 = var_0._id_7235._id_7644;
  var_0._id_A996 = var_0._id_7235._id_764A;
  var_0.maxhealth = 100;
  var_0._id_7235._id_7644 = 1.5;
  var_0._id_7235._id_764A = 50;
}

_id_FA39(var_0) {
  var_0.maxhealth = var_0._id_A997;
  var_0._id_7235._id_7644 = var_0._id_A995;
  var_0._id_7235._id_764A = var_0._id_A996;
}

_id_8086(var_0) {}

_id_D379(var_0) {
  _id_0743::_id_0FDD("axis", ::_id_D37A);

  foreach(var_2 in level._id_E2A4) {
    var_2 _id_D37A();
  }
}

_id_FA31(var_0) {
  _id_0743::_id_C3E5("axis", ::_id_D37A);

  foreach(var_2 in level._id_E2A4) {
    var_2 _id_FA32();
  }
}

_id_D37A() {
  thread _id_1226(self);
  self._id_5DA4 = ::_id_1222;

  if(self._id_02A4 < 3000) {
    self._id_1221 = 1;
    self._id_AC88 = self._id_02A4;
    self._id_02A4 = 3000;
  }
}

_id_FA32() {
  self._id_5DA4 = undefined;
  self notify("stop_aggressively_chase_down_target");

  if(istrue(self._id_1221)) {
    self._id_02A4 = self._id_AC88;
    self._id_AC88 = undefined;
    self._id_1221 = undefined;
  }
}

_id_1222(var_0) {
  self._id_9D39._id_2505 = 1;
  self._id_9D39._id_2504 = 1;
}

_id_1226(var_0) {
  var_0 endon("death");
  var_0 endon("stop_aggressively_chase_down_target");

  for(;;) {
    if(isDefined(var_0._id_0192) && isPlayer(var_0._id_0192)) {
      var_1 = _func_02AB(var_0._id_0192.origin);
      var_0 _meth_8326(var_1);
    }

    wait 1;
  }
}

_id_808A(var_0) {}

_id_D37E(var_0) {
  level._id_C307 = 1;
  level._id_4A0B = 1;
  level._id_4CE0 = 1;
}

_id_FA36(var_0) {
  level._id_C307 = 0;
  level._id_4A0B = 0;
  level._id_4CE0 = 0;
}

_id_808F(var_0) {}

_id_D384(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var_0._id_5E85 = var_1;
}

_id_FA3B(var_0) {
  var_0._id_5E85 = undefined;
}

_id_808C(var_0) {}

_id_D380(var_0) {
  level._id_57E7 = 7;
  level._id_6399 = ::_id_C308;
}

_id_C308() {
  return 17;
}

_id_FA38(var_0) {
  level._id_6399 = undefined;
}

_id_808E(var_0) {}

_id_D382(var_0) {
  level endon("game_ended");
  level endon("relic_hideobjicons_ender");

  for(;;) {
    level scripts\engine\utility::waittill_any_2("worldObjIDPool_requested", "objective_minimapUpdate");

    foreach(var_2 in level._id_10F4E._id_0026) {
      _func_016B(var_2._id_A906, "active");
    }
  }
}

_id_FA3A(var_0) {
  level notify("relic_hideobjicons_ender");
}

_id_808B(var_0) {}

_id_D37F(var_0) {
  level._id_57E7 = 7;
}

_id_FA37(var_0) {
  level._id_57E7 = undefined;
}

_id_1A49() {
  if(getDvar("#x3359dcde5b6e0e6ac", "") != "") {
    return 1;
  }

  return 0;
}