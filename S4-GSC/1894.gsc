/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1894.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  level._id_EB2B = var_0;
  var_0._id_E76D = [];
  var_0._id_EB52 = [];
  var_0._id_EB23 = 1.0;
  var_0._id_EB40 = [];
  var_0._id_EB41 = [];
  var_0._id_EB3F = [];
  var_0._id_B9B7 = [];
  var_0._id_15D7 = 0;
  _id_96AA();
  _id_96A7();
  _id_C2BE();
  _id_82A5();
  _id_06CB::_id_AA65(::_id_3988);
  _id_098C::init();
  _id_098E::init();
  _id_098D::init();
  scripts\cp\zombies\zm_field_upgrades_frost_blast::init();

  if(getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    scripts\cp\zombies\zm_field_upgrades_healing_aura::init();
  }

  thread _id_10B12();

  if(level._id_EB2B._id_15D7) {
    level thread _id_749C();
  }

  _id_06CB::_id_AA65(::_id_EB0F);
  level._id_D6FE = ::_id_D6FE;
}

_id_96AA() {
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("cp/cp_supertable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(getdvarint("#x3dee089cb49164e4e", 0)) {
      var_2 = 42;
    } else {
      var_2 = 2;
    }

    var_3 = spawnStruct();
    level._id_EB2B._id_E76D[var_1] = var_3;
    var_3._id_7C8C = var_0;
    var_3._id_C189 = var_1;
    var_3._id_04F6 = _id_C0A7(var_0, 1);
    var_3._id_9C5C = _id_C0A7(var_0, 3, 1);
    var_3._id_B9BF = _id_C0A7(var_0, var_2, 1);
    var_3._id_A25A = _id_C0A7(var_0, 14, 1);
    var_3._id_3205 = _id_C0A7(var_0, 32, 1) > 0;
    level._id_EB2B._id_EB40[var_0] = var_1;

    if(!isDefined(var_3._id_04F6)) {
      level._id_EB2B._id_E76D[var_1] = undefined;
    } else {
      level._id_EB2B._id_EB41[var_3._id_04F6] = var_3;
    }

    if(var_3._id_04F6 == "<default>") {
      var_3._id_04F6 = "s4_super_default_mp";
    }

    var_0++;
  }

  var_4 = _func_0222("cp/cp_superratetable.csv", 0, scripts\cp\utility::getgametype(), 1);

  if(isDefined(var_4) && var_4 != "") {
    level._id_EB2B._id_EB23 = float(var_4);
  }
}

_id_C0A7(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("cp/cp_supertable.csv", var_0, var_1);

  if(var_3 == "") {
    return undefined;
  }

  if(istrue(var_2)) {
    if(issubstr(var_3, ".")) {
      var_3 = float(var_3);
    } else {
      var_3 = int(var_3);
    }
  }

  return var_3;
}

_id_96A7() {
  var_0 = 2;
  var_1 = scripts\cp\utility::getgametype();

  for(;;) {
    var_2 = tablelookupbyrow("cp/cp_superpointstable.csv", 0, var_0);

    if(!isDefined(var_2) || var_2 == "") {
      var_0 = undefined;
      break;
    }

    if(var_2 == var_1) {
      break;
    }

    var_0++;
  }

  var_3 = 0;

  for(;;) {
    var_3++;
    var_4 = tablelookupbyrow("cp/cp_superpointstable.csv", var_3, 0);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = undefined;

    if(isDefined(var_0)) {
      var_5 = tablelookupbyrow("cp/cp_superpointstable.csv", var_3, var_0);

      if(isDefined(var_5) && var_5 == "") {
        var_5 = undefined;
      }
    }

    if(!isDefined(var_5)) {
      var_5 = tablelookupbyrow("cp/cp_superpointstable.csv", var_3, 1);
    }

    var_5 = float(var_5);

    if(var_5 <= 0) {
      continue;
    }
    level._id_EB2B._id_B9B7[var_4] = var_5;
  }
}

_id_C2BE() {
  _id_C2BC("field_upgrade_energy_mine", ::energy_mine_set, undefined, ::_id_5435, undefined, ::_id_DCEC, "s4_zm_artifact_chinese_jade_dragon_statue_01", "vfx/s4/zombie_weapon/vfx_fld_energy_mine_artifact_light_3p.vfx", undefined, "s4_zm_vm_ges_artifact_dragon");
  _id_C2BC("field_upgrade_ring_of_fire", undefined, undefined, ::_id_C86B, undefined, ::_id_DCEC, "s4_zm_artifact_greek_broken_bronze_sword_01", "vfx/s4/zombie_weapon/vfx_fld_ring_of_fire_artifact_light_3p.vfx", undefined, "s4_zm_vm_ges_artifact_sword");
  _id_C2BC("field_upgrade_aether_shroud", ::aether_shroud_set, undefined, ::_id_11E1, undefined, ::_id_DCEC, "s4_zm_artifact_mayan_funerary_jade_mask_01", "vfx/s4/zombie_weapon/vfx_fld_aether_shroud_artifact_light_3p.vfx", undefined, "s4_zm_vm_ges_artifact_mask");
  _id_C2BC("field_upgrade_frost_blast", ::frost_blast_set, ::frost_blast_unset, ::frost_blast_begin_use, undefined, ::_id_DCEC, "s4_zm_artifact_viking_drinking_horn_01", "vfx/s4/zombie_weapon/vfx_fld_frost_blast_artifact_light_3p.vfx", undefined, "s4_zm_vm_ges_artifact_horn");

  if(getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    _id_C2BC("field_upgrade_healing_aura", undefined, undefined, ::healing_aura_begin_use, undefined, ::_id_DCEC, "wm_hecho_zm_200", "vfx/s4/zombie_weapon/vfx_fld_healing_aura_artifact_light_3p.vfx", "hecho_zm_200_ani", "s4_zm_vm_ges_artifact_hecho");
  }
}

_id_C2BC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_10)) {
    return;
  }
  var_10._id_C189 = var_0;
  var_10._id_D570 = var_1;
  var_10._id_FA98 = var_2;
  var_10._id_24B9 = var_3;
  var_10._id_5354 = var_4;
  var_10._id_C0AC = var_5;
  var_10.modelname = var_6;
  var_10.modelfxid = loadfx(var_7);
  var_10.modelanimname = var_8;
  var_10.gestureanimweapon = var_9;
  var_10._id_89F4 = 1;
}

_id_EB0F() {
  _id_FD4A();
  _id_FD4B();
}

givesuper(var_0, var_1, var_2) {
  if(getdvarint("#x3935295ffafedea42") != 0) {
    return;
  }
  _id_3987(var_1);
  self.super_level = scripts\cp\utility::_id_459B(self.super_level, 0);
  self setclientomnvar("ui_super_level", self.super_level);

  if(var_0 == "") {
    return;
  }
  var_3 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = spawnStruct();
  self._id_EB09 = var_4;
  var_4._id_E76B = var_3;
  var_4._id_340D = 0;
  var_4._id_2325 = 0;
  var_4._id_9C5C = var_3._id_9C5C;
  _id_D6FB(0);
  _id_EB38(var_0);
  self setclientomnvar("ui_super_ref", var_0);
  var_5 = self.pers["superBasePoints"];

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self.pers["superBasePoints"] = undefined;
  _id_D6F8(var_5);

  if(istrue(var_2)) {
    _id_6FF9(_id_6DA3());
  }

  _id_EB3B();
  self setclientomnvar("ui_super_charges", var_4._id_340D);

  if(!_id_8A7E()) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3._id_04F6);
    var_6 = scripts\engine\utility::ter_op(_id_8A7B(), 1, 0);
    self setweaponammoclip(var_3._id_04F6, var_6);
    self _meth_84E9(var_3._id_04F6);
  }

  thread attachsupermodel();
  _id_0720::set_active_super(var_0);
  thread _id_10B55(var_0);
  thread _id_7494();
  thread watchforselfrevive();
  thread _id_10B46();
  thread _id_E9CD();
  thread _id_749D();
  thread handledisconnect();
  thread _id_10BE6();
}

_id_10B53(var_0) {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    if(_id_8A7B()) {
      _id_EB37(var_0);
      break;
    }

    wait 0.02;
  }
}

_id_EB37(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "none" || var_0 == "") {
    return;
  }
  var_1 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_C0AC;

  if(!isDefined(var_2)) {
    return;
  }
  self thread[[var_2]]();
}

_id_749C() {
  level endon("game_ended");

  if(scripts\cp\utility::getgametype() != "br") {
    scripts\cp\utility::_id_60C2("prematch_done");
  }

  var_0 = gettime();
  waitframe();

  for(;;) {
    var_1 = level.players.size;
    var_2 = (gettime() - var_0) / 50;

    if(var_2 < 11) {
      wait((11 - var_2) * 0.05);
      var_2 = 11;
    }

    var_0 = gettime();

    for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 15) {
      for(var_4 = 0; var_4 < 15; var_4++) {
        var_5 = var_3 + var_4;
        var_6 = level.players[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(istrue(var_6._id_AF71)) {
          continue;
        }
        if(!scripts\cp\utility\player::isreallyalive(var_6)) {
          continue;
        }
        if(isDefined(var_6 getcurrentsuper()) && !var_6 getcurrentsuper()._id_88D4) {
          var_6 _id_6FF9(0, "time", 0, var_2);
        }
      }

      waitframe();
    }

    waitframe();
  }
}

_id_3987(var_0) {
  var_1 = getcurrentsuper();

  if(isDefined(var_1) && isDefined(var_1._id_E76B)) {
    _id_EB39(var_1._id_E76B._id_C189);
  }

  if(istrue(var_0) && isDefined(var_1)) {
    _id_E9CE();
  }

  self _meth_84EA();

  if(isDefined(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1._id_E76B._id_04F6);
  }

  detachsupermodel();

  if(level.codcasterenabled && !isagent(self)) {
    self _meth_80CF(0);
  }

  self notify("remove_super");
  self._id_EB09 = undefined;
  self setclientomnvar("ui_super_state", 0);
  self setclientomnvar("ui_super_ref", "none");
}

_id_EB38(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "none" || var_0 == "") {
    return;
  }
  var_1 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_D570;

  if(!isDefined(var_2)) {
    return;
  }
  self thread[[var_2]]();
}

_id_EB39(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "none" || var_0 == "") {
    return;
  }
  var_1 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_FA98;

  if(!isDefined(var_2)) {
    return;
  }
  self thread[[var_2]]();
}

_id_D6F8(var_0, var_1, var_2) {
  var_3 = getcurrentsuper();
  var_3._id_2325 = clamp(var_0, 0, _id_6DA3());

  if(istrue(var_1)) {
    return;
  }
  _id_EB3B(var_2);
}

_id_EB3B(var_0) {
  var_1 = getcurrentsuper();

  if(_id_69AF() >= _id_6DA3()) {
    _id_EB22(var_0);
  }

  _id_FD4A();
  _id_FD4B();
}

_id_6FF9(var_0, var_1, var_2, var_3) {
  if(istrue(game["isLaunchChunk"]) || !level._id_15D8) {
    return;
  }
  if(isDefined(var_1)) {
    var_0 = _id_6DA2(var_1);
  }

  if(isDefined(var_3)) {
    var_0 = var_0 * var_3;
  }

  if(scripts\cp\utility::_hasperk("specialty_faster_field_upgrade")) {
    var_0 = var_0 * getdvarfloat("#x373355cc119bbde7f");
  }

  var_0 = var_0 * scripts\cp\utility::_id_459B(_id_0945::_id_664E("field_upgrade_charge"), 1);

  if(getdvarint("#x3e9cb0b2e1f8fcc41", 0) && !istrue(var_2)) {
    return;
  }
  if(isDefined(var_1) && var_1 == "time") {
    var_4 = var_0 * level._id_EB26;
  } else {
    var_4 = var_0 * level._id_EB3C;
  }

  if(var_4 <= 0) {
    return;
  }
  var_5 = getcurrentsuper();

  if(!isDefined(var_5) || _id_8A7B() || var_5._id_88D4) {
    _id_FD39(var_0, 0, var_1);
    return;
  }

  if(var_5._id_340D >= var_5._id_9C5C) {
    return;
  }
  var_6 = min(var_4 + var_5._id_2325, _id_6DA3());
  _id_D6F8(var_6);
  _id_FD39(var_0, 1, var_1);
}

_id_FD4A() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\cp\utility::_id_88C7() || !isalive(self)) {
    var_0._id_AA3A = undefined;
    return;
  }

  var_1 = 0.0;

  if(!var_0._id_88D4) {
    var_2 = _id_6DA3();
    var_1 = clamp(_id_69AF() / var_2, 0.0, 1.0);
  }

  if(!isDefined(var_0._id_AA3A) || var_1 != var_0._id_AA3A) {
    self setclientomnvar("ui_super_progress", var_1);
  }

  self _meth_8456(var_1);
  var_0._id_AA3A = var_1;
}

_id_FD4B() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\cp\utility::_id_88C7() || !isalive(self)) {
    var_0._id_E747 = undefined;
    return;
  }

  var_1 = var_0._id_E747;
  var_2 = 1;

  if(_id_8A7B()) {
    var_2 = 2;
  } else if(_id_8A79()) {
    var_2 = 3;
  }

  if(!isDefined(var_1) || var_2 != var_1) {
    self setclientomnvar("ui_super_state", var_2);
  }

  var_0._id_E747 = var_2;
}

watchforselfrevive() {
  var_0 = getcurrentsuper();
  var_1 = self;
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    level waittill("revive_success", var_2);

    if(var_2 == var_1) {
      var_2 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0._id_E76B._id_04F6);
      var_2 _id_6FFB(var_0);
    }
  }
}

_id_10B46() {
  var_0 = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("spawned_player");
    _id_6FFB(var_0);
  }
}

_id_E9CD() {
  self endon("disconnect");
  self endon("remove_super");
  scripts\cp\utility::_id_9356("game_over");

  if(istrue(game["practiceRound"])) {
    return;
  }
  _id_E9CE();
}

_id_7494() {
  self endon("disconnect");
  self endon("remove_super");
  self waittill("joined_spectators");
  thread _id_3987(0);
}

_id_749D() {
  self endon("disconnect");
  self endon("remove_super");
  var_0 = self.team;
  self waittill("joined_team");

  if(self.team != var_0) {
    self._id_41C4 = undefined;
    thread _id_3987(0);
  }
}

handledisconnect() {
  level endon("end_game");
  self endon("remove_super");
  self waittill("disconnect");
  detachsupermodel();
}

_id_EB22(var_0) {
  var_1 = getcurrentsuper();
  var_1._id_340D++;
  self setclientomnvar("ui_super_charges", var_1._id_340D);
  self setweaponammoclip(var_1._id_E76B._id_04F6, var_1._id_340D);

  if(!istrue(var_0)) {
    _id_0720::_id_BEC0("field_upgrade_ready", 1);
  }

  self notify("super_ready", 1);
  self.pers["supersEarned"]++;
  self notify("super_earned");

  if(var_1._id_340D < var_1._id_9C5C) {
    _id_D6F8(0, 1);
  }
}

_id_10B55(var_0) {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    thread _id_10B53(var_0);
    self waittill("special_weapon_fired", var_1);
    var_2 = _id_F760(var_1);

    if(!istrue(var_2)) {
      continue;
    }
    self waittill("super_use_finished");
  }
}

_id_F760(var_0) {
  if(!scripts\cp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(var_0.basename != getcurrentsuper()._id_E76B._id_04F6) {
    return 0;
  }

  if(!scripts\common\utility::_id_86DB()) {
    return 0;
  }

  return _id_24B6(0);
}

_id_0C3E() {
  if(isPlayer(self)) {
    if(self _meth_8541() != (0, 0, 0)) {
      return 1;
    }
  }

  return 0;
}

_id_CA23(var_0) {
  if(!isDefined(var_0._id_E76B._id_24B9)) {
    return 1;
  }

  var_1 = self[[var_0._id_E76B._id_24B9]]();
  return var_1;
}

_id_24B6(var_0, var_1) {
  var_2 = getcurrentsuper();
  self notify("super_started");
  _id_0752::_id_D58D(self, 1);

  if(isDefined(var_2) && !var_2._id_88D4) {
    var_3 = !istrue(self.inlaststand) || var_2._id_E76B._id_3205;

    if(var_3 && _id_CA23(var_2)) {
      var_4 = [];
      var_4[0] = "super_use_finished_lb";
      var_4[1] = "super_switched";

      if(!istrue(var_0)) {
        if(var_2._id_340D == var_2._id_9C5C) {
          _id_D6F8(0, 1);
          _id_FD4A();
          _id_FD4B();
        }

        var_2._id_340D = int(max(var_2._id_340D - 1, 0));
        self setclientomnvar("ui_super_charges", var_2._id_340D);
      }

      self setweaponammoclip(var_2._id_E76B._id_04F6, var_2._id_340D);
      _id_D6FB(1);
      self notify("super_use_started");
      thread _id_FD7D();
      _id_3AC2(var_2._id_E76B._id_C189);

      if(level.codcasterenabled) {
        self _meth_80CF(1);
      }

      scripts\cp\utility::_id_BD15("super use started - " + var_2._id_E76B._id_C189, self);
      _id_0720::_id_BEC0("field_upgrade_activated", 1);
      var_5 = self getcurrentweapon();

      if(var_5.type == "riotshield" || istrue(var_1)) {
        return 1;
      } else {
        thread playgesture(var_2);
      }

      return 1;
    } else
      self setweaponammoclip(var_2._id_E76B._id_04F6, var_2._id_340D);
  } else {}

  return 0;
}

playgesture(var_0) {
  self endon("death_or_disconnect");
  level endon("end_game");
  detachsupermodel();
  scripts\cp\utility::playgestureweaponanim(var_0._id_E76B.gestureanimweapon);
  thread attachsupermodel();
}

_id_0F02() {
  var_0 = getcurrentsuper();
  _id_EB50();
  return 1;
}

_id_FD7D() {
  self endon("death_or_disconnect");
  level endon("end_game");
  self endon("super_use_finished");
  var_0 = getcurrentsuper();
  waitframe();
  _id_EB50();
}

_id_EB50(var_0) {
  var_1 = getcurrentsuper();
  self notify("super_use_finished_lb");
  _id_D6FB(0);

  if(isDefined(var_1._id_E76B._id_5354)) {
    if(!isDefined(var_0)) {
      var_0 = 0;
    }

    self[[var_1._id_E76B._id_5354]](var_0);
  }

  if(level.codcasterenabled) {
    self _meth_80CF(0);
  }

  scripts\cp\utility::_id_BD15("super use ended - " + var_1._id_E76B._id_C189, self);
  level.b_field_upgrade_used = 1;
  self notify("super_use_finished");
}

_id_7431() {
  self endon("disconnect");

  if(!_id_8A79()) {
    return;
  }
  _id_EB50(1);
}

_id_A14B(var_0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self endon("remove_super");

  for(;;) {
    self waittill("weapon_fired", var_1);

    if(issameweapon(var_1, var_0, 1)) {
      _id_0F02();
    }
  }
}

_id_E9CE() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(_id_8A75() || _id_8A7B()) {
    self.pers["superBasePoints"] = var_0._id_2325;
  } else {
    self.pers["superBasePoints"] = 0;
  }
}

_id_69AF() {
  var_0 = getcurrentsuper();
  return var_0._id_2325;
}

getcurrentsuperlevel() {
  return self.super_level;
}

_id_6DA3() {
  var_0 = getcurrentsuper();
  var_1 = var_0._id_E76B._id_B9BF;
  return var_1;
}

_id_8A7B() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || var_0._id_88D4) {
    return 0;
  }

  return _id_69AF() >= _id_6DA3();
}

_id_8A79() {
  return isDefined(getcurrentsuper()) && getcurrentsuper()._id_88D4;
}

_id_D6FB(var_0) {
  var_1 = getcurrentsuper();
  var_1._id_88D4 = var_0;
  _id_FD4B();
}

_id_8A75() {
  return !_id_8A7B() && !_id_8A79();
}

getcurrentsuper() {
  return self._id_EB09;
}

_id_69B0() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0._id_E76B._id_C189;
}

_id_6DA6(var_0) {
  if(!_func_0121(var_0)) {
    var_0 = var_0.basename;
  }

  if(!isDefined(level._id_EB2B) || !isDefined(level._id_EB2B._id_EB52) || !isDefined(level._id_EB2B._id_EB52[var_0])) {
    return undefined;
  }

  return level._id_EB2B._id_EB52[var_0]._id_C189;
}

_id_6DA5(var_0) {
  if(!_func_0121(var_0)) {
    var_0 = var_0.basename;
  }

  if(!isDefined(level._id_EB2B._id_EB41[var_0])) {
    return undefined;
  }

  return level._id_EB2B._id_EB41[var_0]._id_C189;
}

_id_6DA4(var_0) {
  if(!_func_0121(var_0)) {
    var_0 = var_0.basename;
  }

  if(!isDefined(level._id_EB2B._id_EB3F[var_0])) {
    return undefined;
  }

  return level._id_EB2B._id_EB3F[var_0]._id_C189;
}

_id_6DA7(var_0) {
  if(!isDefined(level._id_EB2B)) {
    return undefined;
  }

  if(!_func_0121(var_0)) {
    var_0 = var_0.basename;
  }

  var_1 = _id_6DA6(var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = _id_6DA5(var_0);

  if(isDefined(var_2)) {
    return var_2;
  }

  var_2 = _id_6DA4(var_0);

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

_id_DBFC(var_0) {
  var_1 = _id_6DA7(var_0);

  if(isDefined(var_1)) {
    var_2 = level._id_EB2B._id_E76D[var_1];
    return var_2._id_FEF6;
  }

  return undefined;
}

_id_6DA1(var_0) {
  if(!isDefined(var_0) || !isDefined(level._id_EB2B) || !isDefined(level._id_EB2B._id_E76D) || !isDefined(level._id_EB2B._id_E76D[var_0]) || var_0 == "none") {
    return 0;
  }

  return level._id_EB2B._id_E76D[var_0]._id_7C8C;
}

_id_6B69(var_0) {
  var_1 = _id_6DA7(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return level._id_EB2B._id_E76D[var_1]._id_A25A;
}

_id_6CFD(var_0) {
  return _func_00D6(var_0, 6);
}

_id_6DA2(var_0) {
  var_1 = level._id_EB2B._id_B9B7[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

_id_10B12() {
  level waittill("game_ended");
}

_id_6D73() {
  if(getdvarint("#x3ffbf6d545fb125ae", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(self._id_E448)) {
    self._id_E448 = self.pers["sppmData"];

    if(!isDefined(self._id_E448)) {
      self._id_E448 = spawnStruct();
      self._id_E448._id_F37C = 0;
      self._id_E448._id_F370 = 0;
      self._id_E448._id_56C7 = [];
      self.pers["sppmData"] = self._id_E448;
    }
  }

  return self._id_E448;
}

_id_FD39(var_0, var_1, var_2) {
  if(getdvarint("#x3ffbf6d545fb125ae", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_3 = _id_6D73();
  var_3._id_F37C = var_3._id_F37C + var_0;

  if(istrue(var_1)) {
    var_3._id_F370 = var_3._id_F370 + var_0;
  }

  if(!isDefined(var_2)) {
    var_2 = "undefined";
  }

  if(!isDefined(var_3._id_56C7[var_2])) {
    var_3._id_56C7[var_2] = var_0;
  } else {
    var_3._id_56C7[var_2] = var_3._id_56C7[var_2] + var_0;
  }
}

_id_10FCB() {
  if(getdvarint("#x3ffbf6d545fb125ae", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_0 = _id_6D73();
  var_1 = 0;
  var_2 = 0.0;
  var_3 = 0.0;

  if(var_1 > 0.0) {
    var_2 = var_0._id_F37C / var_1;
    var_3 = var_0._id_F370 / var_1;
  }

  var_4 = "";
  var_5 = -1;

  foreach(var_8, var_7 in var_0._id_56C7) {
    if(var_7 > var_5) {
      var_5 = var_7;
      var_4 = var_8;
    }
  }

  _func_03BF("mpscript_sppm", ["sppm", var_2, "sppm_applied", var_3, "gamemode", scripts\cp\utility::getgametype(), "kills", self._id_0267, "time_played", var_1, "best_event", var_4, "script_version", _id_6D14()]);
}

_id_10C09() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");
  level._id_EB1C = getdvarfloat("#x3bed29963fe941eeb", 0);
  scripts\cp\utility::_id_60C2("prematch_done");

  if(level._id_EB1C == 0) {
    level._id_EB1F = gettime();
    level._id_EB1D = level._id_EB1F;
    level notify("super_delay_end");
  }

  level._id_EB1F = gettime();
  level._id_EB1D = level._id_EB1F + level._id_EB1C * 1000;
  level notify("super_delay_start");

  while(gettime() < level._id_EB1D) {
    waitframe();
  }

  level notify("super_delay_end");
}

_id_10BE6() {
  level endon("round_end");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("clear_all_allow_info");
  self notify("watchPlayerSuperDelayWeapon");

  if(_id_EB1E()) {
    return;
  }
  scripts\common\utility::_id_1587(0, "super_delay");
  scripts\engine\utility::_id_10888(level, "super_delay_end", self, "watchPlayerSuperDelayWeapon");
  scripts\common\utility::_id_1587(1, "super_delay");
}

_id_EB1E() {
  return isDefined(level._id_EB1D) && gettime() > level._id_EB1D;
}

_id_3165() {
  level._id_EB1C = 0;
  level._id_EB1F = gettime();
  level._id_EB1D = level._id_EB1F;
  level notify("super_delay_end");
}

_id_D6FE(var_0) {
  self._id_8A77 = var_0;

  if(!var_0) {
    _id_534C();
  } else {
    self notify("super_disable_start");
    thread _id_10C0B();
  }
}

_id_8A7E() {
  return istrue(self._id_8A77);
}

_id_10C0B() {
  self endon("remove_super");
  self endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  self notify("super_disable_end");
  self endon("super_disable_end");
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    var_1 = var_0._id_E76B._id_04F6;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    _id_6FF8();
  }

  thread _id_389E();

  if(!istrue(scripts\cp\utility::_id_60BE("prematch_done"))) {
    level waittill("super_delay_start");
  }

  for(;;) {
    self waittill("special_weapon_fired", var_2);

    if(var_2.basename != "super_delay_mp") {
      continue;
    }
    self setweaponammoclip(var_2, 99);

    if(_id_8A7B()) {
      var_3 = (level._id_EB1D - gettime()) / 1000;
      var_3 = int(max(0, _func_0037(var_3)));

      if(var_3 > 0) {
        scripts\cp\cp_hud_message::_id_DCA2("CP_ZMB/SUPERS_UNAVAILABLE_FOR_N", var_3);
      } else {
        scripts\cp\cp_hud_message::_id_DCA2("CP_ZMB/SUPERS_UNAVAILABLE");
      }
    }
  }
}

_id_389E() {
  self endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  level endon("super_disable_end");
  self notify("watchSuperDelayWeaponCleanup");
  self endon("watchSuperDelayWeaponCleanup");

  for(;;) {
    self waittill("remove_super");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("super_delay_mp");
  }
}

_id_534C() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    var_1 = var_0._id_E76B._id_04F6;
    var_2 = scripts\engine\utility::ter_op(_id_8A7B(), 1, 0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
    self setweaponammoclip(var_1, var_2);
    self _meth_84E9(var_1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("super_delay_mp");
  }

  self notify("super_disable_end");
}

_id_6FF8() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("super_delay_mp");
  self setweaponammoclip("super_delay_mp", 99);
  self _meth_84E9("super_delay_mp");
}

_id_6FFB(var_0) {
  if(_id_EB1E()) {
    if(!self hasweapon(var_0._id_E76B._id_04F6)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0._id_E76B._id_04F6);
      self setweaponammoclip(var_0._id_E76B._id_04F6, var_0._id_340D);
      self _meth_84E9(var_0._id_E76B._id_04F6);
    }
  } else
    _id_6FF8();
}

_id_3AC2(var_0) {
  if(!_id_0740::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata("cp", "playerStats", "superStats", var_0, "uses");
  self setplayerdata("cp", "playerStats", "superStats", var_0, "uses", var_1 + 1);
}

_id_3AC0(var_0) {
  if(!_id_0740::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata("cp", "playerStats", "superStats", var_0, "kills");
  self setplayerdata("cp", "playerStats", "superStats", var_0, "kills", var_1 + 1);
}

_id_3AC1(var_0, var_1) {
  if(!_id_0740::_id_31BA()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = _id_697D(var_0);
  self setplayerdata("cp", "playerStats", "superStats", var_0, "misc1", var_2 + var_1);
}

_id_697D(var_0) {
  return self getplayerdata("cp", "playerStats", "superStats", var_0, "misc1");
}

_id_EB20(var_0) {
  if(var_0 == "super_microturret" || var_0 == "super_supertrophy") {
    return 1;
  }

  return 0;
}

_id_EB21() {
  return scripts\cp\cp_hud_message::_id_DCA2("CP_ZMB/SUPERS_UNAVAILABLE_ARB_UP");
}

_id_C86B() {
  scripts\cp\cp_playerstats::incrementcategorystat(self, "artifactStats", "field_upgrade_ring_of_fire", "uses", 1);
  return _id_098E::_id_4C1C();
}

_id_11E1() {
  scripts\cp\cp_playerstats::incrementcategorystat(self, "artifactStats", "field_upgrade_aether_shroud", "uses", 1);
  return _id_098C::_id_4BDD();
}

aether_shroud_set() {
  _id_098C::set_aether_shroud();
}

_id_5435() {
  scripts\cp\cp_playerstats::incrementcategorystat(self, "artifactStats", "field_upgrade_energy_mine", "uses", 1);
  return _id_098D::_id_4BF5();
}

energy_mine_set() {
  _id_098D::set_energy_mine();
}

frost_blast_begin_use() {
  scripts\cp\cp_playerstats::incrementcategorystat(self, "artifactStats", "field_upgrade_frost_blast", "uses", 1);
  return scripts\cp\zombies\zm_field_upgrades_frost_blast::do_frost_blast();
}

frost_blast_set() {
  scripts\cp\zombies\zm_field_upgrades_frost_blast::set_frost_blast();
}

frost_blast_unset() {
  scripts\cp\zombies\zm_field_upgrades_frost_blast::unset_frost_blast();
}

healing_aura_begin_use() {
  return scripts\cp\zombies\zm_field_upgrades_healing_aura::do_healing_aura();
}

_id_DCEC() {
  self endon("disconnect");

  if(!istrue(self._id_EB3D)) {
    self notify("showSuperReminderSplash");
    self endon("showSuperReminderSplash");
    self._id_EB3D = 1;
    self setclientomnvar("ui_super_reminder", 1);
    wait 0.5;
    thread _id_398A();
  } else {
    thread _id_398A();
    self endon("showSuperReminderSplash");
    waitframe();
    thread _id_DCEC();
    return;
  }
}

_id_398A() {
  self notify("showSuperReminderSplash");
  self._id_EB3D = undefined;
  self setclientomnvar("ui_super_reminder", 0);
}

_id_3988() {
  var_0 = self;

  if(!isPlayer(var_0)) {
    return;
  }
  thread _id_3989(var_0);
}

_id_3989(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("death");
  var_0 _id_398A();
}

_id_82A5() {}

_id_6D14() {
  if(getdvarint("#x37e2e030552f91206", 0) != 0) {
    return 254;
  }

  if(getdvarint("#x3decf448ab3afab5f", 0) != 0) {
    return 7;
  }

  return 254;
}

attachsupermodel() {
  self notify("attach_super_model");
  self endon("attach_super_model");
  self endon("detach_super_model");
  self endon("death_or_disconnect");

  while(!self tagexists("tag_shield_back")) {
    waitframe();
  }

  if(!isDefined(self._id_EB09) || !isDefined(self._id_EB09._id_E76B) || !isDefined(self._id_EB09._id_E76B.modelname) || !isDefined(self._id_25E4)) {
    return;
  }
  var_0 = self._id_EB09._id_E76B.modelname;
  var_1 = self._id_EB09._id_E76B.modelanimname;
  var_2 = isDefined(var_1);

  if(var_2) {
    if(!isDefined(self._id_EB09.animatedmodel)) {
      var_3 = spawn("script_model", self.origin);
      var_3 hidefromplayer(self);
      var_3 setModel(var_0);
      var_3.origin = self gettagorigin("tag_shield_back");
      var_3.angles = self gettagangles("tag_shield_back");
      var_3 _meth_82CB(var_1);
      var_3 linkto(self, "tag_shield_back");
      self._id_EB09.animatedmodel = var_3;
    }
  } else if(!isDefined(self._id_EB09.modelname)) {
    self attach(var_0, "tag_shield_back", 1);
    self._id_EB09.modelname = var_0;
  }

  if(isDefined(self)) {
    playFXOnTag(self._id_EB09._id_E76B.modelfxid, self, "tag_shield_back");
  }
}

detachsupermodel() {
  if(isDefined(self)) {
    self notify("detach_super_model");
  }

  if(!isDefined(self._id_EB09) || !isDefined(self._id_EB09._id_E76B)) {
    return;
  }
  var_0 = isDefined(self._id_EB09._id_E76B.modelanimname);

  if(var_0) {
    if(!isDefined(self._id_EB09.animatedmodel)) {
      return;
    }
    self._id_EB09.animatedmodel unlink();
    self._id_EB09.animatedmodel delete();
    self._id_EB09.animatedmodel = undefined;
  } else {
    if(!isDefined(self) || !isDefined(self._id_EB09.modelname)) {
      return;
    }
    var_1 = self _meth_8117();

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = self _meth_8115(var_2);
      var_4 = self _meth_8118(var_2);

      if(var_3 == self._id_EB09.modelname && var_4 == "tag_shield_back") {
        self detach(self._id_EB09.modelname, var_4);
        break;
      }
    }

    self._id_EB09.modelname = undefined;
  }

  if(isDefined(self)) {
    stopFXOnTag(self._id_EB09._id_E76B.modelfxid, self, "tag_shield_back");
  }
}

_id_8A7D(var_0) {
  if(isDefined(var_0) && isDefined(var_0.basename)) {
    return var_0.basename == "s4_frost_blast_zm" || var_0.basename == "s4_energy_mine_zm";
  }

  return 0;
}

restoresuperammo() {
  var_0 = getcurrentsuper();
  self setweaponammoclip(var_0._id_E76B._id_04F6, var_0._id_340D);
}

can_upgrade_super() {
  return self.super_level < 4;
}

upgrade_super() {
  var_0 = getcurrentsuper();
  self.super_level++;
  self setclientomnvar("ui_super_level", self.super_level);
  var_1 = var_0._id_340D == var_0._id_9C5C;
  _id_EB38(var_0._id_E76B._id_C189);

  if(var_1 && var_0._id_340D < var_0._id_9C5C) {
    _id_D6F8(0, 1);
    _id_FD4A();
    _id_FD4B();
  }
}

is_artifact_weapon(var_0) {
  var_1 = 0;
  var_2 = scripts\cp\utility::getweaponrootname(var_0);

  if(var_2 == "s4_energy" || var_2 == "s4_frost" || var_2 == "s4_ring" || var_2 == "s4_aether") {
    var_1 = 1;
  }

  return var_1;
}