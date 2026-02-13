/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_public.gsc
*************************************************/

_id_8B00(var_0) {
  return istrue(var_0._id_54D9);
}

_id_890F(var_0) {
  return istrue(var_0._id_7276);
}

_id_8A02(var_0) {
  return istrue(var_0._id_C6A6);
}

_id_8990() {
  var_0 = self;
  return isDefined(var_0) && (istrue(var_0._id_8B5B) || istrue(var_0._id_7263));
}

_id_8991() {
  var_0 = self;
  return isDefined(var_0) && (istrue(var_0._id_8B5B) || istrue(var_0._id_7263) || istrue(var_0._id_7262));
}

_id_8818() {
  var_0 = self;
  return istrue(var_0._id_2A63) && !isalive(var_0) && !istrue(var_0._id_7262);
}

_id_10B7A() {
  self endon("heal_end");
  self endon("death_or_disconnect");
  self endon("armor_plate_done");
  level endon("game_ended");
  childthread _id_7624();
  childthread _id_7623();
}

_id_7624() {
  self notifyonplayercommand("try_heal_cancel", "+weapnext");
  self notifyonplayercommand("try_heal_cancel", "+attack");
  self notifyonplayercommand("try_heal_cancel", "+breath_sprint");
  scripts\engine\utility::waittill_any_2("death", "try_heal_cancel");
  _id_7629();
}

_id_7623() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "br" && (var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_UNKNOWN")) {
      continue;
    }
    _id_7629();
  }
}

_id_7629() {
  self _meth_824C("try_heal_cancel", "+weapnext");
  self _meth_824C("try_heal_cancel", "+attack");
  self _meth_824C("try_heal_cancel", "+breath_sprint");
  self notify("heal_end");
}

_id_C4D7(var_0) {
  self._id_2A62[var_0] = undefined;
}

_id_889B(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "armor" && issubstr(var_0, "helmet");
}

_id_8761(var_0) {
  return _id_889B(var_0);
}

_id_8763(var_0) {
  return var_0 == "brloot_armor_plate";
}

_id_8892(var_0) {
  return var_0 == "brloot_health_bandages" || var_0 == "brloot_health_firstaid" || var_0 == "brloot_health_adrenaline";
}

_id_8835(var_0) {
  return _id_8763(var_0) || _id_8892(var_0) || isDefined(level._id_2A95._id_2A67[var_0]) && (level._id_2A95._id_2A67[var_0] == "lethal" || level._id_2A95._id_2A67[var_0] == "tactical");
}

_id_8750(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "ammo";
}

_id_B66F() {
  if(self isswitchingweapon() || self _meth_81E0() || self _meth_81CE() || self _meth_81EF() || self israisingweapon() || self _meth_81CF() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]() || istrue(self._id_82E8)) {
    return 0;
  }

  var_0 = self getcurrentweapon();

  if(isnullweapon(var_0)) {
    return 0;
  }

  return 1;
}

_id_B741(var_0, var_1) {
  self endon("death_or_disconnect");
  var_2 = makeweapon(var_0);
  self _meth_852A(var_2);
  wait(var_1);

  if(self hasweapon(var_2)) {
    self takeweapon(var_2);
  }
}

_id_75A4() {
  var_0 = self;
  return istrue(var_0._id_75A4);
}

_id_75AF() {
  var_0 = self;
  return istrue(var_0._id_75AF);
}

_id_8ACA() {
  if(istrue(level._id_7E69)) {
    switch (level._id_7E77) {
      case "exclusion":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

_id_745F() {
  var_0 = level._id_7E77;
  var_1 = _id_6ABD(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  return level[[var_1]]();
}

_id_745E() {
  var_0 = level._id_7E77;
  var_1 = _id_6ABC(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  return level[[var_1]]();
}

_id_6ABD(var_0) {
  if(!isDefined(level._id_2A5F)) {
    return undefined;
  }

  var_1 = level._id_2A5F[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1._id_E379;
}

_id_6ABC(var_0) {
  if(!isDefined(level._id_2A5F)) {
    return undefined;
  }

  var_1 = level._id_2A5F[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1._id_E36B;
}

_id_383E(var_0) {
  if(isDefined(var_0._id_B7C2)) {
    if(isDefined(var_0._id_B7C2._id_75DA)) {
      var_0._id_B7C2._id_75DA delete();
    }

    if(isDefined(var_0._id_B7C2._id_77F3)) {
      var_0._id_B7C2._id_77F3 delete();
    }

    var_0._id_B7C2 delete();
  }

  if(isDefined(var_0._id_B7C3)) {
    if(isDefined(var_0._id_B7C3._id_75DA)) {
      var_0._id_B7C3._id_75DA delete();
    }

    var_0._id_B7C3 delete();
  }

  if(isDefined(var_0._id_B7C4)) {
    var_0._id_B7C4 delete();
  }

  if(isDefined(var_0._id_B7C5)) {
    var_0._id_B7C5 delete();
  }

  if(isDefined(var_0._id_1314)) {
    var_0._id_1314 delete();
  }

  if(isDefined(var_0._id_3085)) {
    var_0._id_3085 delete();
  }

  if(isDefined(var_0._id_3087)) {
    var_0._id_3087 delete();
  }

  if(isDefined(var_0._id_B758)) {
    foreach(var_2 in var_0._id_B758) {
      var_2 delete();
    }
  }

  if(isDefined(var_0._id_39FF)) {
    var_0._id_39FF delete();
  }

  if(isDefined(var_0._id_E76A) && istrue(var_0._id_E76A._id_3841)) {
    var_0._id_E76A delete();
  }

  if(isDefined(var_0._id_A289) && istrue(var_0._id_A289._id_3841)) {
    if(istrue(var_0._id_A289._id_82CD._id_3841)) {
      var_0._id_A289._id_82CD delete();
    }

    var_0._id_A289 delete();
  }
}

_id_FC1A(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  switch (var_0) {
    case "armorHealthRatio":
      [var_3, var_4, var_5] = [0, 8, 2];
      break;
    case "missionsCompleted":
      [var_3, var_4, var_5] = [8, 4, 2];
      break;
    case "hasSelfReviveToken":
      [var_3, var_4, var_5] = [13, 1, 2];
      break;
    case "hasRespawnToken":
      [var_3, var_4, var_5] = [14, 1, 2];
      break;
    case "isInInfilPlane":
      [var_3, var_4, var_5] = [15, 1, 2];
      break;
    case "damageDealt":
      [var_3, var_4, var_5] = [0, 16, 3];
      break;
    case "playersDowned":
    case "isBeingRevived":
    case "isRespawning":
    case "jumpMasterState":
    case "cleanups":
    case "isDowned":
    case "activeSpectators":
      break;
    default:
      return;
  }

  var_2 _id_ADCF(var_1, var_3, var_4, var_5);
}

_id_ADCF(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = [var_4._id_01A5, var_4._id_01A6, var_4._id_01A7, var_4._id_01A8];
  var_6 = int(_func_01A6(2, var_2)) - 1;
  var_7 = (var_0 &var_6) << var_1;
  var_8 = ~(var_6 << var_1);
  var_9 = var_5[var_3];
  var_10 = var_9 &var_8;
  var_11 = var_10 + var_7;

  switch (var_3) {
    case 0:
      var_4._id_01A5 = var_11;
      break;
    case 1:
      var_4._id_01A6 = var_11;
      break;
    case 2:
      var_4._id_01A7 = var_11;
      break;
    case 3:
      var_4._id_01A8 = var_11;
      break;
    default:
      break;
  }
}

_id_D65F(var_0) {
  if(istrue(var_0)) {
    self._id_01F1 = self._id_01F1 | 2048;
  } else {
    self._id_01F1 = self._id_01F1 &~2048;
  }
}

_id_D659(var_0) {
  if(istrue(var_0)) {
    self._id_01F1 = self._id_01F1 | 4096;
  } else {
    self._id_01F1 = self._id_01F1 &~4096;
  }
}

_id_D670(var_0) {
  if(istrue(var_0)) {
    self._id_01F1 = self._id_01F1 | 8192;
  } else {
    self._id_01F1 = self._id_01F1 &~8192;
  }
}

_id_7DF3() {
  var_0 = self;

  if(!isDefined(var_0._id_2A99)) {
    var_0._id_2A99 = 0;
  }

  var_0._id_2A99++;
  var_0 _id_FC1A("playersDowned", var_0._id_2A99);
  var_0 scripts\mp\utility\stats::_id_7DAE("downs", 1);
}

_id_898B() {
  var_0 = self;
  return istrue(var_0._id_8793) && var_0._id_01F1 & 256;
}

_id_2B3F(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isPlayer(var_3)) {
      continue;
    }
    if(var_3 _id_8990()) {
      continue;
    }
    var_3 thread scripts\mp\hud_message::showsplash(var_0, var_1, var_3);
  }
}

_id_2BDF(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level._id_EF6A[var_1]["players"]) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(var_7 != var_2) {
      _id_2BDD(var_0, var_7, var_3, var_4, var_5);
    }
  }
}

_id_2BDE(var_0, var_1, var_2, var_3, var_4) {
  _id_2BDC(var_0, var_2, level._id_EF6A[var_1]["players"], undefined, var_3, var_4);
}

_id_2BDC(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  var_6 = level.players;

  if(isDefined(var_2)) {
    var_6 = var_2;
  }

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = var_6[var_7];
    thread _id_2BDD(var_0, var_8, var_1, var_3, var_4, var_5);
  }
}

_id_9FEC(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(istrue(var_1) && _id_8990()) {
    return 1;
  }

  if(istrue(self._id_B863)) {
    return 1;
  }

  if(_id_878D()) {
    if(istrue(self._id_B86A)) {
      return 1;
    }

    if(var_0 == "deploy_squad_leader" || var_0 == "prematch_enter") {
      return 1;
    }

    if((var_0 == "circle_closing" || var_0 == "first_circle") && !istrue(level._id_B807)) {
      return 1;
    }
  }

  var_2 = level.maxteamsize == 1;

  if(var_2) {
    switch (var_0) {
      case "deploy_squad_leader":
        return 1;
    }
  }

  return 0;
}

_id_2BBB(var_0) {
  var_1 = var_0._id_45BD;

  if(isai(var_0)) {
    var_1 = var_0._id_293B;
  }

  if(_id_8AB8() || _id_878D()) {
    var_1 = "allies";
  }

  return var_1;
}

_id_2BDD(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isalive(var_1) && !istrue(var_3)) {
    return;
  }
  if(var_1 _meth_81E2() && !var_1 _meth_81E3()) {
    return;
  }
  if(var_1 _id_9FEC(var_0, var_2)) {
    return;
  }
  if(_id_8AB8() || _id_878D()) {
    if(var_0 == "mission_scav_accept" || var_0 == "mission_obj_next_nptarget") {
      return;
    }
  }

  var_6 = _id_2BBB(var_1);
  var_7 = "dx_bra_" + game["voice"][var_6] + "_" + game["dialog"][var_0];
  var_7 = tolower(var_7);
  var_8 = _func_0142(var_7, 1) / 1000.0;

  if(isDefined(var_4)) {
    wait(var_4);
  }

  var_1 _meth_8287(var_7, var_0, var_8);
}

_id_8805() {
  return isDefined(level.script) && level.script == "mp_bm_tut";
}

_id_8AB8() {
  return isDefined(level.script) && (level.script == "mp_br_tut" || level.script == "mp_lc_br_tut");
}

_id_878D() {
  return isDefined(level.script) && level.script == "mp_br_quarry";
}

_id_8804() {
  return isDefined(level.script) && level.script == "mp_br_money";
}

_id_8758() {
  return _id_8AB8() || _id_8805() || _id_878D() || _id_8804();
}

_id_B6B7() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = var_2.basename;

    if(weaponclass(var_2) == "pistol" && var_3 != "s4_me_fists_mp" && var_3 != "iw8_knifestab_mp" && var_3 != "s4_me_rindigo_mp") {
      return var_2;
    }
  }
}

_id_B817() {
  if(istrue(self._id_BC02)) {
    self waittill("playerPrestreamComplete");
  }
}

_id_B7E5(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = scripts\mp\gametypes\br_infils::_id_6ABB();
  }

  var_2 = getdvarint("#x3b00f328be4f2f61", 4500);

  if(var_2 >= 0) {
    var_3 = var_1 - var_2;
    var_4 = scripts\engine\trace::_id_3EF6(1);
    var_0 = scripts\engine\utility::_id_5000(var_0, 0, -1 * var_3, undefined, var_4);
  }

  return var_0;
}

_id_B7E6(var_0, var_1, var_2, var_3) {
  thread _id_B7E7(var_0, var_1, var_2, var_3);
}

_id_B7E7(var_0, var_1, var_2, var_3) {
  self notify("playerPrestreamLocationWait");
  self endon("playerPrestreamLocationWait");
  self endon("disconnect");
  var_4 = !self _meth_878F();

  if(!isDefined(var_1)) {
    var_1 = _id_69D7();
  }

  var_5 = gettime() + var_1;
  self._id_BC02 = 1;

  if(!self _meth_8284()) {
    self _meth_8283();
  }

  var_6 = gettime();

  if(var_4) {
    while(!istrue(self.pers["streamSyncComplete"]) && gettime() < var_5) {
      waitframe();
    }
  }

  self _meth_8282(var_0, 1);

  if(istrue(var_2)) {
    self _meth_8215(self);
  }

  if(var_4) {
    waitframe();

    while((!self _meth_8284() || istrue(var_2) && !self _meth_81A2(self)) && gettime() < var_5) {
      waitframe();
    }

    if(istrue(var_3)) {
      var_8 = gettime() + getdvarint("#x3e94996fd8b07e5", 5000);

      while(gettime() < var_8) {
        waitframe();
      }
    }
  }

  self._id_BC02 = undefined;
  self notify("playerPrestreamComplete");
}

_id_69D7() {
  return getdvarint("#x336b27ddc5e9ffb82", 9000);
}

_id_B67D() {
  self notify("playerPrestreamLocationWait");
  self _meth_8283();
}

_id_2EBB() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}

_id_753A() {
  return isDefined(self._id_2A0E) && self._id_2A0E > 0;
}

_id_7572() {
  return isDefined(self._id_2A5A);
}

_id_42E2(var_0, var_1) {
  var_2 = int(min(self._id_2A0E, var_0));
  var_3 = var_0 - var_2;
  var_4 = self._id_2A0E / self._id_2A7D;
  self._id_2A0E = self._id_2A0E - var_2;
  self._id_2A0E = max(0, self._id_2A0E);
  var_5 = self._id_2A0E / self._id_2A7D;

  if(!istrue(var_1)) {
    if(self._id_2A0E == 0 && var_2 > 0) {
      self playsoundtoplayer("hit_marker_3d_armor_break", self);
      self setscriptablepartstate("armor_break", "armor_break", 0);
    }
  }

  if(!getdvarint("#x319d0418d7f12962d", 0)) {
    self setclientomnvar("ui_br_armor_damage", var_5);
  }

  _id_FC1A("armorHealthRatio", int(self._id_2A0E));
  return var_3;
}

_id_889C() {
  if(getdvarint("#x39b26cd147564b353", 1)) {
    return 1;
  }

  return 0;
}

_id_2B98() {
  self._id_2A5A = undefined;
  self setclientomnvar("ui_br_helmet_class", 0);
}

_id_4306(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !_id_889C()) {
    var_1 = 0;
  }

  var_3 = 1;

  switch (self._id_2A5A) {
    case 1:
      var_3 = 0.85;
      break;
    case 2:
      var_3 = 0.7;
      break;
    case 3:
      var_3 = 0.7;
      break;
    default:
  }

  if(var_1) {
    _id_2B98();

    if(isDefined(level._id_AAFF)) {
      [[level._id_AAFF]](self, var_2);
    }
  }

  return var_3;
}

_id_BBAC(var_0) {
  _func_02E3("lobby_fade", "on", 3);

  if(level._id_9BAA > 13) {
    var_1 = level._id_9BAA - 13;
    wait(var_1);
    var_2 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

    foreach(var_4 in var_2) {
      var_5 = game["music"]["br_lobby_outro"].size - 1;
      var_6 = randomint(var_5);
      var_4 setplayermusicstate(game["music"]["br_lobby_outro"][var_6]);
      var_4 _meth_867F("mp_br_lobby_fade", 8);
    }

    wait(level._id_9BAA);
  } else {}
}

_id_BBA3(var_0) {
  if(_id_8AB8()) {
    return;
  }
  if(level._id_9BAA > 3) {
    var_1 = level._id_9BAA - 3;
    wait(var_1);
    _id_2BDE("prematch_end", var_0);
  }
}

_id_19E5() {
  if(getdvarint("#x365a8c680db84cc2d", 1) == 0) {
    return;
  }
  var_0 = level._id_9BAA - 5;

  if(var_0 > 0) {
    wait(var_0);
  }

  foreach(var_2 in level.players) {
    var_2._id_B928 = 1;
  }
}

_id_2A81() {
  var_0 = self;
  var_0 _id_42E2(150, 1);
}