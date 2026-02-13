/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2075.gsc
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
  _id_96AA();
  _id_96A7();
  _id_C2BE();
  _id_82A5();
  _id_0AA3::_id_C28D(::_id_3988);
  thread _id_10B12();

  if(getdvarint("#x3bd48cd5ba48bb5de", 0) > 0) {
    thread _id_10C0D();
  }

  if(level._id_15D8) {
    level thread _id_749C();
  }

  _id_0A19::_id_ECAC();
  _id_0A17::_id_EB72();
  _id_09FE::_id_16F6();
  _id_0A10::_id_9D15();
  _id_09FF::_id_1736();
  _id_0A09::_id_5573();
  _id_0A13::_id_BBD4();
  _id_0A16::_id_E818();
  _id_0AA3::_id_C28D(::_id_EB0F);
  level._id_D6FE = ::_id_D6FE;
}

_id_96AA() {
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("mp/supertable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = spawnStruct();
    level._id_EB2B._id_E76D[var_1] = var_2;
    var_2._id_7C8C = var_0;
    var_2._id_C189 = var_1;
    var_2._id_04F6 = _id_C0A7(var_0, 1);
    var_2._id_8B15 = _id_C0A7(var_0, 38, 1) == 1;
    var_3 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var_3 = _id_C0A7(var_0, 28, 1);
    }

    if(!isDefined(var_3)) {
      var_3 = _id_C0A7(var_0, 2, 1);
    }

    var_2._id_B9BF = var_3;
    var_4 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var_4 = _id_C0A7(var_0, 26, 1);
    }

    if(!isDefined(var_4)) {
      var_4 = _id_C0A7(var_0, 4, 1);
    }

    var_2._id_FEE7 = var_4;
    var_2._id_9C4B = _id_C0A7(var_0, 5, 1);
    var_2._id_C1B0 = _id_C0A7(var_0, 6, 1);
    var_2.useweapon = _id_C0A7(var_0, 11);
    var_2._id_FEF3 = _id_C0A7(var_0, 12, 1);
    var_2._id_FEF4 = _id_C0A7(var_0, 13, 1);
    var_2._id_FEF6 = _id_C0A7(var_0, 31, 1) > 0;
    var_2._id_A25A = _id_C0A7(var_0, 14, 1);
    var_5 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var_5 = _id_C0A7(var_0, 27, 1);
    }

    if(!isDefined(var_5)) {
      var_5 = _id_C0A7(var_0, 15, 1);
    }

    var_2._id_7116 = var_5;
    var_2._id_9C4C = _id_C0A7(var_0, 16, 1);
    var_2._id_FE47 = _id_C0A7(var_0, 18, 1);
    var_2._id_2C3A = _id_C0A7(var_0, 19, 1);
    var_2._id_1A35 = _id_C0A7(var_0, 17);
    var_2._id_8B03 = _id_C0A7(var_0, 20, 1);
    var_2._id_3205 = _id_C0A7(var_0, 32, 1) > 0;
    var_2._id_585A = [];

    if(isDefined(var_2.useweapon)) {
      var_2.useweapon = makeweaponfromstring(var_2.useweapon);
    }

    level._id_EB2B._id_EB40[var_0] = var_1;

    if(!isDefined(var_2._id_04F6)) {
      level._id_EB2B._id_E76D[var_1] = undefined;
    } else {
      level._id_EB2B._id_EB41[var_2._id_04F6] = var_2;
    }

    if(!isDefined(var_2._id_B9BF)) {
      level._id_EB2B._id_E76D[var_1] = undefined;
    }

    if(isDefined(var_2._id_9C4B)) {
      if(var_2._id_9C4B > 0) {
        var_2._id_0EFB = 1.0 / var_2._id_9C4B;
      } else {
        var_2._id_0EFB = 1.0;
      }
    }

    if(isDefined(var_2._id_9C4C)) {
      if(var_2._id_9C4C > 0) {
        var_2._id_0EFC = 1.0 / var_2._id_9C4C;
      }
    }

    if(isDefined(var_2.useweapon)) {
      level._id_EB2B._id_EB52[var_2.useweapon.basename] = var_2;
    }

    if(var_2._id_04F6 == "<default>") {
      var_2._id_04F6 = "s4_super_default_mp";
    }

    if(isDefined(var_2._id_7116)) {
      var_2._id_7116 = var_2._id_7116 * 1000.0;
    } else {
      var_2._id_7116 = 0.0;
    }

    var_0++;
  }

  var_6 = _func_0222("mp/superratetable.csv", 0, scripts\mp\utility\game::getgametype(), 1);

  if(isDefined(var_6) && var_6 != "") {
    level._id_EB2B._id_EB23 = float(var_6);
  }
}

_id_C0A7(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("mp/supertable.csv", var_0, var_1);

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
  var_1 = scripts\mp\utility\game::getgametype();

  for(;;) {
    var_2 = tablelookupbyrow("mp/superpointstable.csv", 0, var_0);

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
    var_4 = tablelookupbyrow("mp/superpointstable.csv", var_3, 0);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = undefined;

    if(isDefined(var_0)) {
      var_5 = tablelookupbyrow("mp/superpointstable.csv", var_3, var_0);

      if(isDefined(var_5) && var_5 == "") {
        var_5 = undefined;
      }
    }

    if(!isDefined(var_5)) {
      var_5 = tablelookupbyrow("mp/superpointstable.csv", var_3, 1);
    }

    var_5 = float(var_5);

    if(var_5 <= 0) {
      continue;
    }
    level._id_EB2B._id_B9B7[var_4] = var_5;
  }
}

_id_C2BE() {
  if(getdvarint("#x3dc5d37554c267193", 0)) {
    _id_C2BC("super_steel_bib", undefined, undefined, ::_id_EB4B, undefined, undefined);
  } else if(getdvarint("#x3af4635af5e253c51", 0)) {
    _id_C2BC("super_equipment_resupply_drop", undefined, undefined, ::_id_EB24, undefined, undefined);
    _id_C2BC("super_steel_bib", undefined, undefined, ::_id_EB4B, undefined, undefined);
    _id_C2BC("super_pac_sentry", undefined, undefined, ::_id_ADD0, undefined, undefined);
    _id_C2BC("super_field_mic", undefined, ::_id_EB29, ::_id_EB28, ::_id_EB27, undefined);
    _id_C2BC("super_deadsilence", undefined, undefined, ::_id_439F, ::_id_43A0, undefined);
  } else {
    _id_C2BC("super_equipment_resupply_drop", undefined, undefined, ::_id_EB24, undefined, undefined);
    _id_C2BC("super_tac_insert", ::_id_ED0A, ::_id_ED0B, undefined, undefined, undefined);
    _id_C2BC("super_preserve_killstreak_drop", undefined, undefined, ::_id_EB35, undefined, undefined);
    _id_C2BC("super_steel_bib", undefined, undefined, ::_id_EB4B, undefined, undefined);
    _id_C2BC("super_pac_sentry", undefined, undefined, ::_id_ADD0, undefined, undefined);
    _id_C2BC("super_field_mic", undefined, ::_id_EB29, ::_id_EB28, ::_id_EB27, undefined);
    _id_C2BC("super_jammer", undefined, ::_id_EB33, ::_id_EB32, ::_id_8B77, undefined);
    _id_C2BC("super_tac_cover", undefined, ::_id_ECEC, ::_id_ECE4, undefined, undefined);
    _id_C2BC("super_deadsilence", undefined, undefined, ::_id_439F, ::_id_43A0, undefined);
    _id_C2BC("super_trophy", undefined, undefined, undefined, undefined, undefined);
  }
}

_id_C2BC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_6)) {
    return;
  }
  var_6._id_C189 = var_0;
  var_6._id_D570 = var_1;
  var_6._id_FA98 = var_2;
  var_6._id_24B9 = var_3;
  var_6._id_5354 = var_4;
  var_6._id_C0AC = var_5;
  var_6._id_89F4 = 1;
}

_id_C2BD(var_0, var_1) {
  if(!_func_0121(var_1)) {
    var_1 = var_1.basename;
  }

  var_2 = level._id_EB2B._id_E76D[var_0];
  var_2._id_585A[var_2._id_585A.size] = var_1;
  level._id_EB2B._id_EB3F[var_1] = var_2;
}

_id_EB0F() {
  _id_FD4A();
  _id_FD4B();
}

givesuper(var_0, var_1, var_2) {
  if(getdvarint("#x3935295ffafedea42") != 0) {
    return;
  }
  if(scripts\mp\utility\game::_id_875D()) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "ftue") {
    return;
  }
  _id_3987(var_1);

  if(var_0 == "") {
    return;
  }
  if(_id_0825::issuperwip(var_0) || _id_0825::issuperbanned(var_0)) {
    return;
  }
  var_3 = level._id_EB2B._id_E76D[var_0];

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = spawnStruct();
  self._id_EB09 = var_4;
  var_4._id_E76B = var_3;
  var_4._id_15CC = 1;
  var_4._id_A78D = 0;
  var_4._id_10A1D = 0;
  var_4._id_31E9 = 0;
  var_4._id_2325 = 0;
  var_4._id_5854 = 0;
  var_4._id_FED5 = undefined;
  var_4._id_FEA3 = 0.0;
  var_4._id_AD58 = undefined;
  _id_D6FB(0);
  _id_EB38(var_0);
  self setclientomnvar("ui_super_ref", var_0);
  var_5 = self.pers["superBasePoints"];

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self.pers["superBasePoints"] = undefined;
  _id_D6F8(var_5);
  var_6 = self.pers["superExtraPoints"];

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  self.pers["superExtraPoints"] = undefined;
  _id_D6FA(var_6);

  if(!isDefined(self.pers["superExpended"])) {
    _id_D6F9(0);
  }

  if(istrue(var_2)) {
    _id_6FF9(_id_6DA3());
    var_4._id_9925 = gettime();
    _id_07A9::_id_978C(var_4._id_9925);
  }

  if(!_id_8A7E()) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3._id_04F6);
    var_7 = scripts\engine\utility::ter_op(_id_8A7B(), 1, 0);
    self setweaponammoclip(var_3._id_04F6, var_7);
    self _meth_84E9(var_3._id_04F6);
  }

  thread _id_10B55(var_0);
  thread _id_7494();

  if(scripts\mp\utility\game::getgametype() != "br" || level._id_15D8) {
    thread _id_10B46();
    thread _id_E9CD();
    thread _id_749D();
  }
}

_id_10B53(var_0) {
  self endon("disconnect");
  self endon("remove_super");
  self endon("round_ended");

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
  var_2 = self getentitynumber();
  scripts\mp\codcaster_utils::sendcodcasternotification(2, var_2, undefined);
  var_3 = var_1._id_C0AC;

  if(!isDefined(var_3)) {
    return;
  }
  self thread[[var_3]]();
}

_id_749C() {
  level endon("game_ended");

  if(scripts\mp\utility\game::getgametype() != "br") {
    _id_07D1::_id_60C2("prematch_done");
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
        if(!scripts\mp\utility\player::isreallyalive(var_6)) {
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

_id_D6F8(var_0, var_1) {
  var_2 = getcurrentsuper();
  var_2._id_2325 = clamp(var_0, 0, _id_6DA3());

  if(istrue(var_1)) {
    return;
  }
  _id_EB3B();
}

_id_D6FA(var_0, var_1) {
  var_2 = getcurrentsuper();
  var_2._id_5854 = clamp(var_0, 0, _id_6DA3());

  if(istrue(var_1)) {
    return;
  }
  _id_EB3B();
}

_id_EB3B() {
  var_0 = getcurrentsuper();

  if(_id_69AF() >= _id_6DA3()) {
    _id_EB22();
  } else {
    self setweaponammoclip(var_0._id_E76B._id_04F6, 0);
  }

  _id_FD4A();
  _id_FD4B();
}

_id_6FF9(var_0, var_1, var_2, var_3) {
  if(istrue(game["isLaunchChunk"]) || !level._id_15D8 || istrue(self.dead_drop_active)) {
    return;
  }
  if(isDefined(var_1)) {
    var_0 = _id_6DA2(var_1);
  }

  if(isDefined(var_3)) {
    var_0 = var_0 * var_3;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_faster_field_upgrade")) {
    var_0 = var_0 * getdvarfloat("#x373355cc119bbde7f", 1.2);
  }

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

  if(!isDefined(var_5) || _id_8A7B() || var_5._id_88D4 || _id_8A78()) {
    _id_FD39(var_0, 0, var_1);
    return;
  }

  var_6 = min(var_4 + var_5._id_2325, _id_6DA3());
  _id_D6F8(var_6);
  _id_07A9::_id_9782(var_4, gettime());
  _id_FD39(var_0, 1, var_1);
}

_id_FD4A() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\player::_id_88C7() || !isalive(self)) {
    var_0._id_AA3A = undefined;
    return;
  }

  var_1 = 0.0;

  if(var_0._id_88D4) {
    var_1 = _id_6DA8();
  } else if(!_id_8A78()) {
    var_2 = _id_6DA3();
    var_1 = clamp(_id_69AD() / var_2, 0.0, 1.0);
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
  if(scripts\mp\utility\player::_id_88C7() || !isalive(self)) {
    var_0._id_E747 = undefined;
    return;
  }

  var_1 = var_0._id_E747;
  var_2 = 1;

  if(_id_8A78()) {
    var_2 = 4;
  } else if(_id_8A7B()) {
    var_2 = 2;
  } else if(_id_8A79()) {
    var_2 = 3;
  }

  if(!isDefined(var_1) || var_2 != var_1) {
    self setclientomnvar("ui_super_state", var_2);
  }

  var_0._id_E747 = var_2;
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
  _id_07D1::_id_9356("game_over");

  if(istrue(game["practiceRound"])) {
    return;
  }
  _id_E9CE();
}

_id_7494() {
  self endon("disconnect");
  self endon("remove_super");
  self waittill("joined_spectators");
  thread _id_3987(1);
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

_id_7484() {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  var_0 = getcurrentsuper();
  var_1 = getdvarfloat("#x3e3617334c6986090", 6.0) * level._id_5F3A;

  for(;;) {
    if(!_id_8A75()) {
      waitframe();
      continue;
    }

    var_2 = max(var_0._id_5854 - var_1, 0);
    _id_D6FA(var_2);
    waitframe();
  }
}

_id_EB22() {
  var_0 = getcurrentsuper();
  self setweaponammoclip(var_0._id_E76B._id_04F6, 1);
  var_1 = !var_0._id_10A1D;
  self notify("super_ready", var_1);

  if(var_1) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
    _id_C14F(var_0);
  }

  var_0._id_9925 = gettime();
  var_0._id_A78D = 0;
  _id_07A9::_id_978C(var_0._id_9925);
  _id_D6FA(0, 1);
  _id_D6F8(_id_6DA3(), 1);

  if(isDefined(self._id_9BC0)) {
    _id_07A9::_id_9767(self, var_0._id_E76B._id_7C8C);
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
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(var_0.basename != getcurrentsuper()._id_E76B._id_04F6) {
    return 0;
  }

  if(!scripts\common\utility::_id_86DB()) {
    return 0;
  }

  return _id_24B6();
}

_id_24B6() {
  var_0 = getcurrentsuper();
  self notify("super_started");
  var_1 = self getentitynumber();
  scripts\mp\codcaster_utils::sendcodcasternotification(3, var_1, undefined);
  scripts\mp\gamelogic::_id_D58D(self, 1);

  if(var_0._id_E76B._id_04F6 == "support_box_mp" || var_0._id_E76B._id_04F6 == "s4_medkit_box_mp" || var_0._id_E76B._id_04F6 == "s4_ammo_box_mp" || var_0._id_E76B._id_04F6 == "s4_equipment_resupply_box_mp" || var_0._id_E76B._id_04F6 == "s4_dead_drop_mp" || var_0._id_E76B._id_04F6 == "s4_steel_bib_crate_mp") {} else {}

  if(isDefined(var_0) && !var_0._id_88D4) {
    var_2 = !istrue(self.inlaststand) || var_0._id_E76B._id_3205;
    var_3 = 1;

    if(isDefined(var_0._id_E76B.useweapon)) {
      if(_id_07AD::_id_88B6() && _id_EB20(var_0._id_E76B._id_C189)) {
        _id_EB21();
        var_3 = 0;
      } else if(!var_2)
        var_3 = 0;
      else {
        var_3 = _id_F745(var_0._id_E76B.useweapon, var_0._id_E76B._id_FEF3, var_0._id_E76B._id_FEF4);
      }
    }

    if(var_3 && var_2 && (!isDefined(var_0._id_E76B._id_24B9) || istrue(self[[var_0._id_E76B._id_24B9]]()))) {
      var_4 = [];
      var_4[0] = "super_use_finished_lb";
      var_4[1] = "super_switched";
      _id_D6F8(0);
      _id_D6FA(0);
      _id_D6FB(1);
      var_0._id_15CC = scripts\engine\utility::ter_op(var_0._id_E76B._id_7116 > 0, 1, 0);
      var_0._id_FED5 = gettime();
      var_0._id_FEA3 = 1.0;
      self notify("super_use_started");
      thread _id_FD7D();

      if(isDefined(self._id_9BC0)) {
        _id_07A9::_id_9766(self, var_0._id_E76B._id_7C8C);
      }

      _id_3AC2(var_0._id_E76B._id_C189);

      if(level.codcasterenabled) {
        self _meth_80CF(1);
      }

      scripts\mp\utility\print::_id_BD15("super use started - " + var_0._id_E76B._id_C189, self);
      return 1;
    } else {
      if(isDefined(var_0._id_E76B.useweapon) && var_3) {
        thread _id_EC2F();
      }

      self setweaponammoclip(var_0._id_E76B._id_04F6, 1);
    }
  }

  return 0;
}

_id_0F02(var_0, var_1) {
  var_2 = getcurrentsuper();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0 && isDefined(var_2._id_E76B._id_0EFC)) {
    _id_C17E(var_2._id_E76B._id_0EFC, var_1);
  } else if(isDefined(var_2._id_E76B._id_0EFB)) {
    _id_C17E(var_2._id_E76B._id_0EFB, var_1);
  }

  return 1;
}

_id_FD7D() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  var_0 = getcurrentsuper();

  if(!isDefined(var_0._id_E76B._id_FEE7)) {
    waitframe();
    _id_EB50();
    return;
  }

  if(var_0._id_E76B._id_FEE7 < 0) {
    return;
  }
  for(;;) {
    waitframe();

    if(isDefined(var_0._id_E76B._id_FE47)) {
      var_1 = gettime() - var_0._id_FED5;

      if(var_1 < var_0._id_E76B._id_FE47) {
        continue;
      }
    }

    var_2 = level._id_5F3A / var_0._id_E76B._id_FEE7;
    _id_C17E(var_2);
    _id_FD4A();
    _id_FD4B();
  }
}

_id_C17E(var_0, var_1, var_2) {
  var_3 = getcurrentsuper();
  var_3._id_FEA3 = max(var_3._id_FEA3 - var_0, 0.0);

  if(istrue(var_1)) {
    var_3._id_15CC = 0;
  }

  if(!isDefined(var_2) || var_2 == 0) {
    _id_EB4F();
  }
}

_id_C64A() {
  var_0 = getcurrentsuper();
  var_0._id_FEA3 = 1.0;
  _id_EB4F();
}

_id_EB4F() {
  var_0 = getcurrentsuper();

  if(isbot(self)) {
    if(isDefined(var_0._id_E76B.useweapon) && var_0._id_E76B._id_8B03 == 1) {
      var_1 = self _meth_8109(var_0._id_E76B.useweapon);

      if(isDefined(var_1) && var_1 > 0) {
        _id_EB50();
        return;
      }
    }
  }

  if(var_0._id_FEA3 <= 0.0) {
    _id_EB50();
  }
}

_id_EB50(var_0, var_1, var_2, var_3) {
  var_4 = getcurrentsuper();
  self notify("super_use_finished_lb");
  var_5 = self getentitynumber();
  scripts\mp\codcaster_utils::sendcodcasternotification(4, var_5, undefined);
  var_6 = 0;

  if(!isDefined(var_3) || var_3 == 0) {
    var_6 = _id_DBC4();
  }

  _id_D6FB(0);
  var_4._id_31E9 = 0;
  var_7 = undefined;

  if(isDefined(var_4._id_E76B._id_5354)) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    var_7 = self[[var_4._id_E76B._id_5354]](var_1);
  }

  if(var_6 || istrue(var_0) || istrue(var_7)) {
    _id_D6F9(0);
    var_4._id_10A1D = 1;
    _id_D6F8(_id_6DA3());
  } else if(istrue(var_2)) {
    _id_D6F9(0);
    var_8 = _id_6DA3() * var_4._id_FEA3;
    var_4._id_10A1D = 1;
    _id_D6F8(var_8);
  } else {
    _id_D6F9(1);
    var_4._id_8FD3 = gettime();
    var_4._id_10A1D = 0;
  }

  thread _id_EC2F();
  var_9 = var_4._id_FED5 - var_4._id_9925;
  _id_07A9::_id_978D(var_4._id_E76B._id_C189, var_9, 0, var_4._id_A78D);

  if(level.codcasterenabled) {
    self _meth_80CF(0);
  }

  scripts\mp\utility\print::_id_BD15("super use ended - " + var_4._id_E76B._id_C189, self);

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!level._id_15D8) {
      if(!istrue(var_0)) {
        self setclientomnvar("ui_perk_package_state", 0);
        self setclientomnvar("ui_super_progress", 0);
      }
    } else if(var_4._id_E76B._id_2C3A) {
      _id_3987();
      self setclientomnvar("ui_perk_package_state", 0);
      self setclientomnvar("ui_super_progress", 0);
      self setclientomnvar("ui_super_state", 0);
    }
  }

  self notify("super_use_finished");
}

_id_C1B1() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    if(var_0._id_88D4) {
      _id_EB50(1);
    } else {
      _id_6FF9(_id_6DA3());
    }
  }
}

_id_7431() {
  self endon("disconnect");

  if(!_id_8A79()) {
    return;
  }
  var_0 = getcurrentsuper();
  var_1 = var_0._id_E76B._id_C1B0;
  _id_EB50(var_1, 1);
}

_id_A14B(var_0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self endon("remove_super");

  for(;;) {
    self waittill("weapon_fired", var_1);

    if(issameweapon(var_1, var_0, 1)) {
      _id_0F02(var_1._id_0245, 1);
    }
  }
}

_id_F745(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self setweaponammoclip(var_0, var_1);
  self setweaponammostock(var_0, var_2);
  var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, isbot(self));

  if(var_3) {
    thread _id_9A34(var_0);
    thread _id_A14B(var_0);
    return 1;
  }

  scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_0);
  return 0;
}

_id_9A34(var_0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  var_1 = getcurrentsuper();
  var_1._id_FEF5 = undefined;
  var_2 = 0;

  for(;;) {
    var_3 = self getcurrentweapon();

    if(!var_1._id_31E9 && !issameweapon(var_0, var_3, 1)) {
      if(var_3.basename == "iw7_uplinkball_mp" || var_3.basename == "iw7_tdefball_mp") {
        var_2 = 1;
      }

      break;
    }

    waitframe();
  }

  if(_id_8A79()) {
    var_1._id_FEF5 = 1;
    _id_EB50(undefined, undefined, var_2);
  }
}

_id_EC2F() {
  self endon("death");
  var_0 = getcurrentsuper();
  var_1 = var_0._id_E76B.useweapon;

  if(!isDefined(var_1)) {
    return;
  }
  if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_1);
    return;
  }

  self notify("super_switched");
  scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_1);
}

_id_E9CE() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(_id_8A75() || _id_8A7B()) {
    self.pers["superBasePoints"] = var_0._id_2325;
    self.pers["superExtraPoints"] = var_0._id_5854;
  } else if(_id_8A79() && _id_DBC4()) {
    var_1 = _id_6DA3();
    self.pers["superPoints"] = var_0._id_FEA3 * var_1;
    self.pers["superExtraPoints"] = 0;
  } else {
    self.pers["superBasePoints"] = 0;
    self.pers["superExtraPoints"] = 0;
  }
}

_id_6DA8() {
  var_0 = getcurrentsuper();
  return var_0._id_FEA3;
}

_id_69AD() {
  return getcurrentsuper()._id_2325;
}

_id_69AE() {
  return getcurrentsuper()._id_2325;
}

_id_69AF() {
  var_0 = getcurrentsuper();
  return var_0._id_2325 + var_0._id_5854;
}

_id_6DA3() {
  var_0 = getcurrentsuper();
  var_1 = var_0._id_E76B._id_B9BF;

  if(isDefined(var_0._id_AD58)) {
    var_1 = var_0._id_AD58;
  }

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

_id_8A78() {
  if(getdvarint("#x3666741ae22375081", 1) == 0) {
    return 0;
  }

  return istrue(self.pers["superExpended"]);
}

_id_D6F9(var_0) {
  self.pers["superExpended"] = var_0;
  _id_FD4B();
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

_id_DBC4() {
  var_0 = getcurrentsuper();
  var_1 = var_0._id_E76B._id_7116;
  var_2 = gettime() - var_0._id_FED5;

  if(var_2 >= var_1) {
    return 0;
  }

  if(var_0._id_A78D > 0) {
    return 0;
  }

  return var_0._id_15CC;
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

_id_15D9() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0._id_88D4) {
    return;
  }
  var_0._id_31E9 = 1;
}

_id_FB29() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0._id_31E9) {
    return;
  }
  if(!var_0._id_88D4 || !isDefined(var_0._id_E76B.useweapon)) {
    var_0._id_31E9 = 0;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0._id_E76B.useweapon);
  var_0._id_31E9 = 0;
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

  if(scripts\mp\utility\game::_id_10A16()) {
    foreach(var_1 in level.players) {
      var_1 _id_10FCB();
    }
  }
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
  var_1 = scripts\mp\persistence::_id_E761("round", "timePlayed", 1) / 60.0;
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

  _func_03BF("mpscript_sppm", ["sppm", var_2, "sppm_applied", var_3, "gamemode", scripts\mp\utility\game::getgametype(), "kills", self._id_0267, "time_played", var_1, "best_event", var_4, "script_version", _id_6D14()]);
}

_id_A00F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(self.owner) && isDefined(var_0) && var_0 == self.owner) {
    var_5 = int(_func_0037(var_3 * 0.5));
  }

  return var_5;
}

_id_FBF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isPlayer(var_0);
  var_9 = var_5.basename == "s4_throwing_knife_mp";
  var_10 = var_9 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade";
  var_11 = isDefined(var_1) && isPlayer(var_1) && var_1 != var_2;

  if(var_11) {
    var_12 = var_1 getcurrentsuper();

    if(var_8 || var_10) {
      if(isDefined(var_12) && var_12._id_E76B._id_C189 == "super_deadsilence" && var_1 _id_8A79()) {
        var_1 thread _id_0A71::_id_EB18();
      }
    }

    if(var_8 && var_0 scripts\mp\utility\perk::_hasperk("specialty_bulletdamage")) {
      var_1 thread _id_0A72::_id_E92E(var_5);
    }
  }
}

_id_10C09() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");

  if(scripts\mp\utility\game::isanymlgmatch()) {
    level._id_EB1C = 0;
  } else {
    level._id_EB1C = getdvarfloat("#x3bed29963fe941eeb", 0);
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    _id_07D1::_id_60C2("prematch_done");
  }

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

  if(!istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("super_delay_start");
  }

  for(;;) {
    self waittill("special_weapon_fired", var_2);

    if(var_2.basename != "s4_super_delay_mp") {
      continue;
    }
    self setweaponammoclip(var_2, 99);

    if(_id_8A7B()) {
      var_3 = (level._id_EB1D - gettime()) / 1000;
      var_3 = int(max(0, _func_0037(var_3)));

      if(var_3 > 0) {
        scripts\mp\hud_message::_id_DCA2("MP/SUPERS_UNAVAILABLE_FOR_N", var_3);
      } else {
        scripts\mp\hud_message::_id_DCA2("MP/SUPERS_UNAVAILABLE");
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
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_super_delay_mp");
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
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_super_delay_mp");
  }

  self notify("super_disable_end");
}

_id_6FF8() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("s4_super_delay_mp");
  self setweaponammoclip("s4_super_delay_mp", 99);
  self _meth_84E9("s4_super_delay_mp");
}

_id_6FFB(var_0) {
  if(_id_EB1E()) {
    if(!self hasweapon(var_0._id_E76B._id_04F6)) {
      var_1 = scripts\engine\utility::ter_op(_id_8A7B(), 1, 0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0._id_E76B._id_04F6);
      self setweaponammoclip(var_0._id_E76B._id_04F6, var_1);
      self _meth_84E9(var_0._id_E76B._id_04F6);
    }
  } else
    _id_6FF8();
}

_id_10BB3(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");

  if(scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd") {
    if(istrue(var_1)) {
      self waittill("super_obj_drain");
    }
  } else if(!isDefined(self._id_32EC))
    self waittill("obj_picked_up");
  else {
    wait 0.05;
  }

  while(_id_8A79()) {
    _id_C17E(var_0);
    wait 0.05;
  }
}

_id_3AC2(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata(level.progressiongroup, "playerStats", "superStats", var_0, "uses");
  self setplayerdata(level.progressiongroup, "playerStats", "superStats", var_0, "uses", var_1 + 1);
}

_id_3AC0(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata(level.progressiongroup, "playerStats", "superStats", var_0, "kills");
  self setplayerdata(level.progressiongroup, "playerStats", "superStats", var_0, "kills", var_1 + 1);
}

_id_3AC1(var_0, var_1) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = _id_697D(var_0);
  self setplayerdata(level.progressiongroup, "playerStats", "superStats", var_0, "misc1", var_2 + int(var_1));
}

_id_697D(var_0) {
  return self getplayerdata(level.progressiongroup, "playerStats", "superStats", var_0, "misc1");
}

_id_EB20(var_0) {
  if(var_0 == "super_microturret" || var_0 == "super_supertrophy") {
    return 1;
  }

  return 0;
}

_id_EB21() {
  scripts\mp\hud_message::_id_DCA2("MP/SUPERS_UNAVAILABLE_ARB_UP");
}

_id_2ADF() {
  return _id_09D6::_id_9424();
}

_id_36AD() {
  return scripts\mp\killstreaks\killstreaks::_id_F763("chopper_gunner");
}

_id_40E1() {
  return scripts\mp\killstreaks\killstreaks::_id_F763("cruise_predator");
}

_id_CC50() {}

_id_CC5E(var_0) {}

_id_ED0A() {
  _id_0A18::_id_ED00();
}

_id_ED0B() {
  _id_0A18::_id_ED03();
}

_id_C33B() {}

_id_C33A() {}

_id_BB72() {
  return scripts\mp\killstreaks\killstreaks::_id_F763("precision_airstrike");
}

_id_F333() {
  return scripts\mp\killstreaks\killstreaks::_id_F763("toma_strike");
}

_id_ADD0() {
  var_0 = scripts\mp\killstreaks\killstreaks::_id_F763("pac_sentry");

  if(istrue(var_0)) {
    _id_07BC::createfieldupgradechallengeevent("activate");
  }

  return var_0;
}

_id_2B47() {}

_id_F8F1() {
  return scripts\mp\killstreaks\killstreaks::_id_F763("uav");
}

_id_ECE4() {
  return _id_0A19::_id_ECAE();
}

_id_ECEC() {
  return _id_0A19::_id_ECB1();
}

_id_C12B() {
  return _id_09B5::_id_C11C();
}

_id_C12C(var_0) {
  return _id_09B5::_id_C11F(var_0);
}

_id_C133() {
  _id_09B5::_id_C125();
}

_id_51B0() {
  return _id_09B1::_id_5195();
}

_id_439F() {
  _id_07BC::createfieldupgradechallengeevent("activate");
  return _id_0A71::_id_EB15();
}

_id_43A0(var_0) {
  return _id_0A71::_id_EB17(var_0);
}

_id_EB98() {
  _id_0A17::_id_EB86();
}

_id_9071() {
  return _id_0A6F::_id_906A();
}

_id_9073() {
  return _id_0A6F::_id_906D();
}

_id_906F() {
  return _id_0A6F::_id_9065();
}

_id_E934() {
  return _id_0A72::_id_E921();
}

_id_EB51() {
  return _id_0A1E::_id_10D73();
}

_id_EB43() {
  var_0 = _id_0A6C::_id_AFDA();
  _id_EB38(var_0);
  self._id_EB09._id_5BE5 = var_0;
  var_1 = _id_0A6C::_id_AFDC();
  _id_EB38(var_1);
  self._id_EB09._id_CFF2 = var_1;
  var_2 = level._id_EB2B._id_E76D[var_0];
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2._id_B9BF;
  }

  var_2 = level._id_EB2B._id_E76D[var_1];
  var_4 = 0;

  if(isDefined(var_2)) {
    var_4 = var_2._id_B9BF;
  }

  var_5 = max(var_3, var_4);
  self._id_EB09._id_AD58 = var_5;
}

_id_EB44() {
  var_0 = self._id_EB09._id_5BE5;
  _id_EB39(var_0);
  var_1 = self._id_EB09._id_CFF2;
  _id_EB39(var_1);
}

_id_EB42() {
  return _id_0A6C::_id_AFE3();
}

_id_F0E2() {
  thread _id_F0E3();
  return 1;
}

_id_EB2A() {
  return 1;
}

_id_EB4D() {
  return 1;
}

_id_EB36() {
  return 1;
}

_id_EB14() {
  return 1;
}

_id_EB24() {
  _id_07BC::createfieldupgradechallengeevent("activate");
  return 1;
}

_id_EB35() {
  _id_07BC::createfieldupgradechallengeevent("activate");
  return scripts\mp\supers\dead_drop::dead_drop_try_use();
}

_id_EB4B() {
  _id_07BC::createfieldupgradechallengeevent("activate");
  return _id_0A15::_id_E805();
}

_id_EB4C() {
  return 1;
}

_id_EB33() {
  _id_0A0F::_id_8B74();
}

_id_EB32() {
  _id_07BC::createfieldupgradechallengeevent("activate");
  return _id_0A0F::_id_8B65();
}

_id_8B77(var_0) {
  _id_0A0F::_id_8B6A();
}

_id_EB29() {
  _id_0A0A::_id_5A1F();
}

_id_EB28() {
  _id_07BC::createfieldupgradechallengeevent("activate");
  return _id_0A0A::_id_5A15();
}

_id_EB27(var_0) {
  _id_0A0A::_id_5A19();
}

_id_EB30() {
  self._id_793D = undefined;

  if(scripts\mp\utility\perk::_hasperk("specialty_hack")) {
    scripts\mp\utility\perk::removeperk("specialty_hack");
  }
}

_id_EB2F() {
  scripts\mp\utility\perk::_id_6FC2("specialty_hack");
}

_id_EB2D() {
  if(isDefined(self._id_793D) && self._id_793D) {
    return 1;
  }

  return 0;
}

_id_EB2E(var_0) {
  self._id_793D = undefined;

  if(scripts\mp\utility\perk::_hasperk("specialty_hack")) {
    scripts\mp\utility\perk::removeperk("specialty_hack");
  }
}

_id_F0E3() {
  self endon("super_use_finished");

  for(;;) {
    if(self _meth_805E("BUTTON_X")) {
      _id_EB50(0, 0, 1);
    } else if(self _meth_805E("BUTTON_Y")) {
      _id_EB50(1);
    }

    waitframe();
  }
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

_id_3988(var_0) {
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

_id_82A5() {
  setdvarifuninitialized("#x3e3617334c6986090", 6.0);
}

_id_10C0D() {
  level endon("game_ended");
  var_0 = getdvarint("#x3e939a6d8fc43d8f8", 60);
  var_1 = getdvarint("#x332e053d555d93054", 45);
  var_2 = getdvarint("#x3330341d555ff5076", 90);
  var_3 = var_2 - var_1;
  waitframe();

  if(!istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("prematch_over");
  }

  wait(var_0);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];
  var_7 = [];

  foreach(var_9 in level._id_EF89) {
    var_6[var_9] = undefined;
    var_7[var_9] = [];
  }

  for(;;) {
    var_4 = var_5;
    var_5 = getdvarint("#x3bd48cd5ba48bb5de", 0) > 0;

    if(!isDefined(var_4) || var_4 != var_5) {
      if(var_5) {
        level notify("superLotteryEnabled");
      } else {
        level notify("superLotteryDisabled");
      }
    }

    foreach(var_9 in level._id_EF89) {
      if(!isDefined(var_6[var_9])) {
        var_6[var_9] = gettime() + (var_1 + randomint(var_3)) * 1000;
        continue;
      }

      if(var_6[var_9] <= gettime()) {
        var_12 = scripts\mp\utility\teams::_id_6DCA(var_9, "players");

        if(var_12.size > 0) {
          var_12 = scripts\engine\utility::array_randomize(var_12);
          var_13 = [];
          var_14 = undefined;

          foreach(var_16 in var_12) {
            if(!scripts\engine\utility::array_contains(var_7[var_9], var_16)) {
              if(isDefined(var_16 getcurrentsuper())) {
                var_14 = var_16;
                break;
              }
            } else if(isDefined(var_16 getcurrentsuper()))
              var_13[var_13.size] = var_16;
          }

          if(!isDefined(var_14)) {
            if(isDefined(var_13[0])) {
              var_14 = var_13[0];
            } else {
              var_14 = var_12[0];
            }
          }

          if(var_5) {
            childthread _id_1FCE(var_14);
          }

          var_7[var_7.size] = var_14;
        }

        var_6[var_9] = undefined;
      }
    }

    waitframe();
  }
}

_id_1FCE(var_0) {
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  level endon("superLotteryDisabled");
  var_0 notify("awardSuperLottery");
  var_0 endon("awardSuperLottery");

  for(;;) {
    var_1 = var_0 getcurrentsuper();

    if(!isDefined(var_1)) {
      return;
    }
    if(!var_0 _id_8A79()) {
      break;
    }

    waitframe();
  }

  var_0 _id_6FF9(_id_6DA3(), undefined, 1);
}

_id_6D14() {
  if(getdvarint("#x37e2e030552f91206", 0) != 0) {
    return 254;
  }

  if(getdvarint("#x3decf448ab3afab5f", 0) != 0) {
    return 7;
  }

  return 254;
}

_id_C14F(var_0) {
  if(getdvarint("#x3f388a937f4fb9b34", 0) == 0) {
    return;
  }
  var_1 = scripts\mp\persistence::_id_E761("round", "timePlayed", 1) / 60.0;
  _func_03BF("mpscript_super_earning", ["super_ref", var_0._id_E76B._id_C189, "earn_time", var_1, "gamemode", scripts\mp\utility\game::getgametype(), "script_version", _id_6D14(), "earned_count", self.pers["supersEarned"]]);
}