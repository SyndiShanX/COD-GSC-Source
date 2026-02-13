/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2053.gsc
*************************************************/

init() {
  if(scripts\mp\utility\game::getgametype() == "br" || istrue(game["isLaunchChunk"])) {
    level._id_BA8B = 0;
    return;
  }

  if(!isDefined(level._id_BA8B) || level._id_BA8B) {
    level._id_BA8B = level._id_5AA7 == 1;
  }

  if(!level._id_BA8B) {
    return;
  }
  var_0 = spawnStruct();
  level._id_BA8C = var_0;
  var_0._id_4142 = undefined;
  var_0._id_EC4D = 0;
  var_0._id_54EF = [];
  var_0._id_D729 = [];
  var_0._id_D72B = [];
  var_0._id_A4D2 = 0;
  var_0._id_8F8D = -1;
  var_0._id_AF83 = 0;
  _id_9614();
  setdvarifuninitialized("#x3c9056e6262f50631", 5000);
  setdvarifuninitialized("#x3c9296062631d621f", 3000);
  setdvarifuninitialized("#x3e6c800a0e4d843c4", 2500);
  setdvarifuninitialized("#x31f4c52b9df04eec5", 1);
  setdvarifuninitialized("#x3d804391979e6627d", 420);
  thread onplayerconnect();
  _id_0A8E::_id_C285(::_id_AB63);
  _id_0806::init();
}

_id_6B5B() {
  return getdvarint("#x3d804391979e6627d");
}

_id_687F() {
  return getdvarint("#x3c9056e6262f50631");
}

_id_6880() {
  return getdvarint("#x3c9296062631d621f");
}

_id_6D06() {
  return getdvarint("#x3e6c800a0e4d843c4");
}

_id_6E97() {
  return _id_6880() + _id_6D06() * 2;
}

_id_6E96() {
  return _id_687F() + _id_6D06() * 2;
}

_id_6B5C() {
  return getdvarint("#x35d649bfe8c4d97ac");
}

_id_9614() {
  var_0 = level._id_BA8C;
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/potg_event_table.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_0._id_56C3[var_2] = [];
    var_3 = tablelookupbyrow("mp/potg_event_table.csv", var_1, 1);
    var_0._id_56C3[var_2]["score"] = float(var_3);
    var_4 = tablelookupbyrow("mp/potg_event_table.csv", var_1, 2);
    var_0._id_56C3[var_2]["addOn"] = var_4 != "";
    var_1++;
  }
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    _id_C29F(var_0);
    var_0 thread _id_FCFE();
  }
}

_id_FCFE() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    _id_E71C();
    self waittill("death");

    if(!istrue(self._id_59E0)) {
      self waittill("death_delay_finished");
    }

    _id_E937();
  }
}

_id_AB63(var_0) {
  _id_4805(var_0);
}

_id_AB92(var_0) {
  if(!istrue(level._id_BA8B)) {
    return;
  }
  _id_0806::_id_AB92(var_0);
  waitframe();
  thread _id_10822();
}

_id_10822() {
  wait(_id_6D06() / 1000.0);
  waitframe();

  if(!_id_DBD9()) {
    _id_5A9E();
  }
}

_id_DBD9() {
  var_0 = _id_699D();

  if(isDefined(var_0) && isDefined(var_0._id_BCCE)) {
    return var_0._id_038F < _id_6B5B();
  } else {
    return 1;
  }
}

_id_5A9E() {
  level notify("potg_finalize");
  _id_5A9B();
  waittillframeend;

  if(_id_DBD9()) {
    return;
  }
  level._id_BA8C._id_EC4D = 1;

  if(level._id_BA8C._id_AF83) {
    _id_1A3E();
  }

  var_0 = _id_699D();

  if(isDefined(var_0)) {
    _id_5A9F(var_0);
  }
}

_id_8A87() {
  return level._id_BA8C._id_EC4D;
}

_id_C29F(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  var_1 = level._id_BA8C;
  var_2 = _id_6A0C(var_0);
  var_3 = spawnStruct();
  var_3._id_019B = var_0;
  var_3._id_56BC = [];
  var_3._id_C147 = 0;
  var_3._id_9036 = -1;
  var_3._id_A49D = 0;
  var_1._id_54EF[var_2] = var_3;
}

_id_4805(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  var_1 = level._id_BA8C;
  var_2 = _id_6A0C(var_0);
  var_1._id_54EF[var_2] = undefined;
  var_0 notify("cleanup_potg_entity");
}

_id_6A0D(var_0) {
  var_1 = _id_6A0C(var_0);
  return level._id_BA8C._id_54EF[var_1];
}

_id_6A0C(var_0) {
  if(isDefined(var_0._id_BA8D)) {
    return var_0._id_BA8D;
  }

  var_0._id_BA8D = var_0 getentitynumber();
  return var_0._id_BA8D;
}

_id_E71C() {
  if(!level._id_BA8B) {
    return;
  }
  if(_id_8A87()) {
    return;
  }
  var_0 = _id_6A0D(self);

  if(var_0._id_C147 == 0) {
    _id_AB86(var_0);
  }

  var_0._id_C147++;
}

_id_AB86(var_0) {
  var_0._id_9036 = gettime();
}

_id_E937() {
  if(!level._id_BA8B) {
    return;
  }
  if(_id_8A87()) {
    return;
  }
  var_0 = _id_6A0D(self);
  var_0._id_C147--;

  if(var_0._id_C147 == 0) {
    _id_AB87(var_0);
  }
}

_id_5ECB(var_0) {
  var_0._id_C147 = 0;
  var_0._id_019B _id_AB87(var_0);
}

_id_AB87(var_0) {
  var_1 = level._id_BA8C;
  _id_0806::_id_AB7E();
  var_0._id_019B notify("potg_stop_recording");
  _id_C46E(var_0);
}

_id_89F2(var_0) {
  if(!level._id_BA8B) {
    return 0;
  }

  if(_id_8A87()) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = _id_6A0D(self);
  }

  return var_0._id_C147 > 0;
}

_id_5A9B() {
  var_0 = level._id_BA8C;

  foreach(var_2 in var_0._id_54EF) {
    _id_5ECB(var_2);
  }
}

_id_BD6C(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level._id_BA8B) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = gettime();
  }

  if(!isDefined(var_2)) {
    var_2 = var_1;
  }

  var_6 = level._id_BA8C;
  var_7 = _id_6A0D(self);
  _id_C4F6(var_7);

  if(!_id_89F2(var_7)) {
    return;
  }
  var_8 = int(max(_id_69B4(), var_7._id_9036));

  if(var_1 <= var_8 || var_2 <= var_8) {
    return;
  }
  var_9 = spawnStruct();
  var_10 = undefined;

  if(isDefined(var_4)) {
    var_10 = var_4;
  } else {
    var_10 = _id_56C4(var_0);
  }

  if(isDefined(var_5)) {
    var_10 = var_10 * var_5;
  }

  var_11 = self;
  var_12 = int(var_11.health / var_11.maxhealth * 127);
  var_9._id_56BB = var_0;
  var_9._id_E72D = var_1;
  var_9._id_534E = var_2;
  var_9._id_038F = var_10;
  var_9._id_0354 = var_3;
  var_9.playerhealthratio = var_12;
  var_13 = var_7._id_A49D;
  var_7._id_A49D++;
  var_7._id_56BC[var_13] = var_9;
  _id_435E(var_9, var_13, self);

  if(!_id_56C5(var_0)) {
    thread _id_107DA(var_7);
  }
}

_id_107DA(var_0) {
  var_1 = var_0._id_019B;
  var_1 endon("disconnect");
  var_1 endon("cleanup_potg_entity");
  var_1 notify("waitAndNominatePOTG()");
  var_1 endon("waitAndNominatePOTG()");
  waittillframeend;

  if(!_id_89F2(var_0)) {
    return;
  }
  var_2 = _id_2EF3(var_0._id_56BC);

  if(var_2 > _id_6B5C() && var_1 _meth_8685()) {}

  if(var_2 > _id_6B5B() && var_2 > _id_6912()) {
    var_3 = _id_4041(var_0, var_2);
    var_1 thread _id_10811(var_3);
  } else {}
}

_id_C4F6(var_0) {
  var_1 = _id_69B4();

  foreach(var_4, var_3 in var_0._id_56BC) {
    if(var_3._id_E72D < var_1) {
      var_0._id_56BC[var_4] = undefined;
    }
  }
}

_id_C46E(var_0) {
  var_0._id_56BC = [];
}

_id_4041(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_BCCE = var_0._id_019B;
  var_2._id_56BC = var_0._id_56BC;
  var_2._id_038F = var_1;
  var_2._id_CBCF = level._id_BA8C._id_A4D2;
  level._id_BA8C._id_A4D2++;
  var_2._id_0E94 = undefined;
  var_2._id_0E89 = undefined;
  var_2.playerhealthratio = undefined;

  foreach(var_4 in var_0._id_56BC) {
    if(!isDefined(var_2._id_0E94) || var_4._id_E72D < var_2._id_0E94) {
      var_2._id_0E94 = var_4._id_E72D;
    }

    if(!isDefined(var_2._id_0E89) || var_4._id_534E > var_2._id_0E89) {
      var_2._id_0E89 = var_4._id_534E;
    }

    if(isDefined(var_4.playerhealthratio)) {
      if(!isDefined(var_2.playerhealthratio) || var_2.playerhealthratio != var_4.playerhealthratio) {
        var_2.playerhealthratio = var_4.playerhealthratio;
      }

      continue;
    }

    var_2.playerhealthratio = 127;
  }

  var_2._id_C148 = var_0._id_9036;
  var_2._id_534E = undefined;
  var_2._id_B364 = undefined;
  var_2._id_B363 = undefined;
  return var_2;
}

_id_4C7C(var_0) {
  return _id_6B4A(var_0) >= _id_6E97();
}

_id_4C7B(var_0) {
  return var_0._id_534E - var_0._id_0E89 >= _id_6D06();
}

_id_6B4A(var_0) {
  var_1 = var_0._id_C148;
  return var_0._id_534E - var_0._id_C148;
}

_id_10811(var_0) {
  self endon("disconnect");
  self endon("cleanup_potg_entity");
  var_1 = var_0._id_C148 + _id_6E97();
  var_2 = var_0._id_0E89 + _id_6D06();
  var_3 = var_0._id_0E94 + _id_6E96();
  var_4 = int(clamp(var_2, var_1, var_3));
  var_5 = "no_wait";

  if(var_4 > gettime()) {
    thread _id_10BCC(var_4);
    var_5 = scripts\engine\utility::_id_1089F("potg_pending_scene_timeout", "potg_stop_recording");
    self notify("potg_scene_finished_pending");
  }

  if(gettime() > var_4) {
    var_0._id_534E = var_4;
  } else {
    var_0._id_534E = gettime();
  }

  if(_id_4C7C(var_0)) {
    if(_id_4C7B(var_0)) {
      if(var_0._id_038F > _id_6B5B() && var_0._id_038F >= _id_6912()) {
        _id_D4F3(var_0);
      } else {}
    } else {}
  } else {}
}

_id_10BCC(var_0) {
  self endon("potg_scene_finished_pending");

  while(gettime() < var_0) {
    waitframe();
  }

  self notify("potg_pending_scene_timeout");
}

_id_2EF3(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 = var_2 + var_4._id_038F;

    if(var_4._id_56BB == "kill") {
      var_1++;
    }
  }

  if(var_1 > 2) {
    var_6 = _id_56C4("triple_kill");
    var_2 = var_2 + var_6;
  }

  return var_2;
}

_id_D4F3(var_0) {
  _id_2EC3(var_0);
  _id_C56B(var_0._id_B364, var_0._id_B363);
  _id_CC6F(var_0, level._id_BA8C._id_4142);
  level._id_BA8C._id_4142 = var_0;
}

_id_699D() {
  if(!level._id_BA8B) {
    return undefined;
  }

  return level._id_BA8C._id_4142;
}

_id_6912() {
  if(!level._id_BA8B) {
    return -1;
  }

  var_0 = level._id_BA8C;

  if(!isDefined(var_0._id_4142)) {
    return -1;
  }

  return var_0._id_4142._id_038F;
}

_id_69B4() {
  return gettime() - _id_6E96();
}

_id_56C4(var_0) {
  return level._id_BA8C._id_56C3[var_0]["score"];
}

_id_56C5(var_0) {
  return level._id_BA8C._id_56C3[var_0]["addOn"];
}

_id_56C6(var_0) {
  return isDefined(level._id_BA8C._id_56C3[var_0]);
}

_id_5A9F(var_0) {
  var_0._id_5A9C = 1;
  _id_2EC4(var_0);
  _id_C63E();
  _id_435F(var_0);
}

_id_C63E() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_potg_score_event_control", -1);
    var_1 setclientomnvar("ui_score_event_list_0", -1);
    var_1 setclientomnvar("ui_score_event_list_1", -1);
    var_1 setclientomnvar("ui_score_event_list_2", -1);
    var_1 setclientomnvar("ui_score_event_list_3", -1);
    var_1 setclientomnvar("ui_score_event_list_4", -1);
  }
}

_id_2EC3(var_0) {
  var_1 = gettime() - 13000;
  var_2 = var_0._id_534E - _id_6E96();
  var_3 = int(max(var_2, max(var_0._id_C148, var_1)));
  var_4 = var_0._id_0E94 - _id_6D06();
  var_5 = int(min(var_0._id_0E94, var_0._id_534E - _id_6E97()));
  var_0._id_B364 = int(clamp(var_4, var_3, var_5));
  var_0._id_B363 = var_0._id_534E;
  var_6 = var_0._id_B363 - var_0._id_B364;
}

_id_2EC4(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_56BC) {
    if(isDefined(var_3._id_0354) && !isDefined(var_1[var_3._id_534E])) {
      var_1[var_3._id_534E] = var_3._id_0354;
    }
  }

  if(var_1.size <= 0) {
    var_0._id_0354 = 0;
    return;
  }

  var_5 = 0.0;

  foreach(var_7 in var_1) {
    var_5 = var_5 + var_7;
  }

  var_9 = var_5 / var_1.size;
  var_0._id_0354 = int(var_9);
}

_id_6A37() {
  var_0 = _id_699D();

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = spawnStruct();
  var_1._id_E72D = var_0._id_B364;
  var_1._id_534E = var_0._id_B363;
  var_1._id_E3E1 = var_0._id_BCCE;
  var_1._id_0354 = var_0._id_0354;
  return var_1;
}

_id_C56B(var_0, var_1) {
  level thread _id_1A40(var_0, var_1);
}

_id_1A40(var_0, var_1) {
  level endon("potg_finalize");
  level notify("potg_archiveRequestHelper()");
  level endon("potg_archiveRequestHelper()");
  level._id_BA8C._id_AF83 = 1;
  var_2 = var_0 + 13000 - 100;
  var_3 = var_2 - gettime();
  scripts\engine\utility::_id_107AE(var_3);
  level._id_BA8C._id_AF83 = 0;
  _id_1A3E();
}

_id_1A3E() {
  thread _id_44B5(_func_039A(), _id_699D());
  _func_0399();
  var_0 = level._id_BA8C._id_8F8D;
  level._id_BA8C._id_8F8D = gettime();
  var_1 = -1;

  if(var_0 > 0) {
    var_1 = level._id_BA8C._id_8F8D - var_0;
  }
}

_id_6CE2() {
  return 13000 - _id_6E96() - 250;
}

_id_4C7A(var_0) {
  var_1 = level._id_BA8C._id_8F8D;

  if(var_1 < 0) {
    return 0;
  }

  var_2 = var_1 - 13000;
  return var_0._id_B364 >= var_2 && var_0._id_B363 <= var_1;
}

_id_CC6F(var_0, var_1) {
  if(getdvarint("#x38fa7782d9ac5013a") == 0) {
    return;
  }
  if(var_0._id_038F <= 250) {
    return;
  }
  var_2 = undefined;

  if(isPlayer(var_0._id_BCCE)) {
    var_2 = var_0._id_BCCE.name;
  } else {
    var_2 = "(GameObject)";
  }

  if(isPlayer(var_0._id_BCCE)) {
    var_0._id_BCCE iprintlnbold("POTG Nominee! (" + var_0._id_038F + ")");
  }

  if(isDefined(var_1) && isPlayer(var_1._id_BCCE) && var_1._id_BCCE != var_0._id_BCCE) {
    var_1._id_BCCE iprintlnbold("Your POTG was bested by +" + var_2 + "! (" + var_0._id_038F + ")");
  }

  level._id_BA8C._id_8FAA = gettime();
}

_id_CC6E() {
  if(getdvarint("#x38fa7782d9ac5013a") == 0) {
    return;
  }
  var_0 = _id_699D();
  var_1 = gettime() - int(self._id_0060 * 1000);
  var_2 = 0.15;
  var_3 = [];

  for(;;) {
    foreach(var_6, var_5 in var_0._id_56BC) {
      if(var_5._id_E72D <= var_1 && !isDefined(var_3[var_6])) {
        iprintlnbold(var_5._id_56BB);
        iprintln(var_5._id_56BB);
        var_3[var_6] = 1;
        break;
      }
    }

    wait(var_2);
    var_1 = var_1 + int(var_2 * 1000);
  }
}

_id_435C() {
  if(getdvarint("#x37e2e030552f91206", 0) != 0) {
    return -1;
  }

  if(getdvarint("#x3decf448ab3afab5f", 0) != 0) {
    return 9;
  }

  return -1;
}

_id_435D() {
  return getdvarint("#x3a248bf9760e623f1") != 0;
}

_id_435F(var_0) {
  if(!_id_435D()) {
    return;
  }
  var_1 = _id_435C();
  _func_03BF("mpscript_potg", ["score", var_0._id_038F, "duration", var_0._id_B363 - var_0._id_B364, "start_time", var_0._id_B364, "action_start_offset", var_0._id_0E94 - var_0._id_B364, "action_end_offset", var_0._id_0E89 - var_0._id_B364, "entity_id", _id_6A0C(var_0._id_BCCE), "script_version", var_1]);

  foreach(var_3 in var_0._id_56BC) {
    _func_03BF("mpscript_potg_final_events", ["event_ref", var_3._id_56BB, "score", var_3._id_038F, "start_time", var_3._id_B364, "end_time", var_3._id_B363, "script_version", var_1]);
  }
}

_id_435E(var_0, var_1, var_2) {
  if(!_id_435D()) {
    return;
  }
  _func_03BF("mpscript_potg_events", ["event_ref", var_0._id_56BB, "score", var_0._id_038F, "start_time", var_0._id_E72D, "end_time", var_0._id_534E, "event_id", var_1, "entity_id", _id_6A0C(var_2), "script_version", _id_435C()]);
}

_id_435B(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("#x31f4c52b9df04eec5", 0) == 0) {
    return;
  }
  var_5 = _id_435C();
  _func_03BF("mpscript_potg_archive", ["requestTime", var_0, "archiveStartTime", var_1, "archiveDuration", var_2, "desiredSceneStartTime", var_3, "desiredSceneEndTime", var_4, "playerCount", level.players.size, "tickRate", int(1.0 / level._id_5F3A), "dedi", scripts\engine\utility::ter_op(isdedicatedserver(), 1, 0), "version", 0]);
}

_id_44B5(var_0, var_1) {
  var_2 = gettime();
  thread _id_44B3(var_2, var_0, var_1);
  thread _id_44B4(var_2, var_1);
}

_id_44B3(var_0, var_1, var_2) {
  level notify("watching_potg_archive_request");
  level endon("watching_potg_archive_request");

  if(getdvarint("#x31f4c52b9df04eec5") == 0) {
    return;
  }
  for(;;) {
    var_3 = _func_039A();

    if(var_3 != var_1) {
      level notify("potg_archive_request_finished");
      _id_445D(1, var_2, var_0, var_3, _func_039B());
      break;
    }

    waitframe();
  }
}

_id_44B4(var_0, var_1) {
  level endon("potg_archive_request_finished");
  level waittill("watching_potg_archive_request");
  _id_445D(0, var_1, var_0);
}

_id_445D(var_0, var_1, var_2, var_3, var_4) {
  if(var_0) {
    thread _id_435B(var_2, var_3, var_4, var_1._id_B364, var_1._id_B363);
  }

  if(var_0) {
    return;
  }
}