/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_auavscan.gsc
************************************************************/

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("disable_public_event");
  level endon("game_ended");

  if(isDefined(level._id_034714CE799B6017) && !level._id_034714CE799B6017) {
    return;
  }
  level waittill("init_public_event");
  init();
}

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_9EFAF906653CE505", 1.0);
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_938D1B74C8AED04C", 1);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("auavscan", "20 201515 10101010");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("auavscan");
  _id_337BD370F7C5E6F9::registerpublicevent(9, _id_7EC7671A1E0C788F);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

_id_C9E871D29702E8CF() {
  game["dialog"]["pe_auavscan_name"] = "scan_wzan_name";
  game["dialog"]["pe_auavscan_boost"] = "scan_wzan_boos";
  game["dialog"]["pe_auavscan_anticipation"] = "scan_wzan_antp";
  game["dialog"]["pe_auavscan_anticipation_water"] = "scan_wzan_antw";
  game["dialog"]["pe_auavscan_clear"] = "scan_wzan_cler";
  game["dialog"]["pe_auavscan_spotted"] = "scan_wzan_sptd";
  game["dialog"]["pe_auavscan_unseen"] = "scan_wzan_unsn";
  game["dialog"]["pe_auavscan_enemies_spotted"] = "scan_wzan_espt";
  game["music"]["pe_auavscan_music_spotted"] = ["auavscan_player_spotted"];
  game["music"]["pe_auavscan_music_not_spotted"] = ["auavscan_player_not_spotted"];
  level._id_E44708D64C7225DB = spawnStruct();
  level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 = getdvarfloat("dvar_C99BFC3E5AFBA5C1", 12.5);
  level._id_E44708D64C7225DB._id_B8A58CDF9FAAA1C5 = getdvarfloat("dvar_2C9CD3EEAC399508", 20.0);
  level._id_E44708D64C7225DB._id_A0018B713CAF9AD7 = getdvarfloat("dvar_412B4E845571F956", 5.0);
  level._id_E44708D64C7225DB._id_11DA4BBB41691F62 = getdvarfloat("dvar_714066E581602C95", 3);
  level._id_E44708D64C7225DB._id_A1A6F1B9F605EAA9 = getdvarfloat("dvar_BFBE620DC5C15A26", 5.0);
  level._id_E44708D64C7225DB._id_A88DCC32D9759428 = getdvarfloat("dvar_2D42A2458E48B139", 5.0);
  level._id_E44708D64C7225DB._id_87940078241E4580 = getdvarfloat("dvar_A03525C8D67DB059", 90);
  level._id_E44708D64C7225DB._id_07AF9598177DC2DE = getdvarfloat("dvar_A01237C8D6579037", 565.0);
  level._id_00C45348B7BB062D = 1;
}

validatefunc() {
  return 1;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

calculateeventstarttime() {
  if(level._id_E44708D64C7225DB._id_07AF9598177DC2DE > level._id_E44708D64C7225DB._id_87940078241E4580)
    return randomfloatrange(level._id_E44708D64C7225DB._id_87940078241E4580, level._id_E44708D64C7225DB._id_07AF9598177DC2DE);
  else
    return level._id_E44708D64C7225DB._id_87940078241E4580;
}

activatefunc() {
  level endon("game_ended");

  if(!istrue(level._id_00C45348B7BB062D)) {
    _id_C736AF73DF2C97C4 = getdvarfloat("dvar_9EFAF906653CE505", -1);

    if(_id_C736AF73DF2C97C4 < 0)
      _id_C736AF73DF2C97C4 = "unset";

    defaultweight = 1.0;
    scripts\mp\utility\script::demoforcesre("auavscan being activated without dialog data, event dvar weight [" + _id_C736AF73DF2C97C4 + "], default weight [" + defaultweight + "], postInitFunc ran [" + istrue(level._id_00C45348B7BB062D) + "]");
    return;
  }

  _id_1CD423B8D20701EC();
  level._id_E44708D64C7225DB._id_5F6360CBCBB6908B = [];
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_auavscan_incoming", "splash_list_br_pe_auavscan");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("pe_auavscan_name", 1, undefined, 0, 0, undefined, "dx_br_bds4_");
  wait 3.5;
  thread _id_A2E49B9AB2A49511();
}

_id_1CD423B8D20701EC() {
  if(isDefined(level.starttimefrommatchstart)) {
    _id_98898CE82F016D8C = level._id_E44708D64C7225DB._id_87940078241E4580 * 1000 + level.starttimefrommatchstart;

    if(_id_98898CE82F016D8C > gettime()) {
      waittime = (_id_98898CE82F016D8C - gettime()) / 1000;
      wait(waittime);
    }
  }
}

_id_A2E49B9AB2A49511() {
  level endon("game_ended");
  _id_148F45EE0122273F = gettime() + level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 * 1000;
  thread _id_ABF0B46D9FA2A191();
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("pe_auavscan_boost", 1, undefined, 0, 0, undefined, "dx_br_bds4_");
  setomnvar("ui_publicevent_timer_type", 7);
  setomnvar("ui_publicevent_timer", _id_148F45EE0122273F);
  setomnvar("ui_publicevent_minimap_pulse", 1);
  level._id_975B837A4FFA005E = 1;
  thread _id_2222CF91CAEC46F1();
  thread _id_EF878C020746EB35();
  wait(level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92);
  _id_28EEDB1A951AF158 = gettime() + level._id_E44708D64C7225DB._id_A0018B713CAF9AD7 * 1000;
  setomnvar("ui_publicevent_timer_type", 8);
  setomnvar("ui_publicevent_timer", _id_28EEDB1A951AF158);

  foreach(player in level.players) {
    if(!istrue(player _id_51C43EA1C9A91A16())) {
      continue;
    }
    player._id_9753FA8FAF6F1587 = 1;
    player thread _id_E4A11B4D5AA01DA9();

    if(player _id_F50D75FA9092AA20()) {
      player thread _id_D1AA45C7C7553C6E(_id_28EEDB1A951AF158);
      continue;
    }

    player thread _id_13E90BA0D8A6E1C3();
  }

  _id_61AC9F37C634F0B7();
}

_id_D1AA45C7C7553C6E(_id_28EEDB1A951AF158) {
  level endon("game_ended");
  thread _id_A3F455B863175CC8(_id_28EEDB1A951AF158);
  thread watchweaponfired(_id_28EEDB1A951AF158);
  self setclientomnvar("ui_publicevent_auavscan_spotted", 0);
  self setclientomnvar("ui_publicevent_fullscreen_atlas_type", 1);
}

_id_E4A11B4D5AA01DA9() {
  level endon("game_ended");
  self playsoundtoplayer("ui_operation_scan_active_lr", self);
  _id_7A08CF3BBDF7AFF6();
}

_id_61AC9F37C634F0B7() {
  wait(level._id_E44708D64C7225DB._id_A0018B713CAF9AD7);
  _id_B639B0BE19E7C1D1();

  if(level._id_E44708D64C7225DB._id_5F6360CBCBB6908B.size == 0)
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("pe_auavscan_unseen", 1, undefined, 0, 0, undefined, "dx_br_bds4_");
  else {
    wait(level._id_E44708D64C7225DB._id_B8A58CDF9FAAA1C5);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("pe_auavscan_clear", 1, level._id_E44708D64C7225DB._id_5F6360CBCBB6908B, 0, 0, undefined, "dx_br_bds4_");
  }

  _id_C74A586DB59DB1E4();
}

_id_B639B0BE19E7C1D1() {
  level notify("public_event_auavscan_prone_phase_ended");
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  _id_844C6DDEC4884800 = level.players.size;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      _id_844C6DDEC4884800--;
      continue;
    }

    if(istrue(player._id_667C153C8F4AAF73))
      _id_844C6DDEC4884800--;

    player _id_D269ABF0E45A98C2();
  }

  _id_81DCD9181C92C508(_id_844C6DDEC4884800, level._id_E44708D64C7225DB._id_5F6360CBCBB6908B.size);
}

_id_D269ABF0E45A98C2() {
  if(!istrue(self._id_13E90BA0D8A6E1C3)) {
    self notify("pe_auavscan_player_unspotted");

    if(isalive(self) && !istrue(_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) && istrue(self._id_9753FA8FAF6F1587)) {
      thread scripts\mp\utility\points::giveunifiedpoints("br_pe_auavscan_unspotted");
      _id_17C8D9E220164807 = game["music"]["pe_auavscan_music_not_spotted"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      self setplayermusicstate(game["music"]["pe_auavscan_music_not_spotted"][_id_DCC499C9734611F8]);
      self setclientomnvar("ui_publicevent_fullscreen_atlas_type", 0);
    }
  }

  if(!istrue(self._id_667C153C8F4AAF73) && level._id_E44708D64C7225DB._id_5F6360CBCBB6908B.size > 0) {
    _id_550D3F458E3BAD84 = undefined;

    foreach(_id_C1123D717A38FAD7 in level._id_E44708D64C7225DB._id_5F6360CBCBB6908B) {
      if(_id_C1123D717A38FAD7.team != self.team) {
        _id_550D3F458E3BAD84 = 1;
        break;
      }
    }

    if(istrue(_id_550D3F458E3BAD84))
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("pe_auavscan_enemies_spotted", self, 1, 0, 0, undefined, "dx_br_bds4_");
  }
}

_id_C74A586DB59DB1E4() {
  level._id_975B837A4FFA005E = undefined;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_BB20D2D613DBB92D();
  }
}

_id_BB20D2D613DBB92D() {
  self notify("pe_auavscan_end");
  self _meth_D7BF524EB1822214(0);
  self setplayeradvanceduavdot(0);
  self _meth_B267CBAC73E99F49(0);
  self._id_13E90BA0D8A6E1C3 = undefined;
  self._id_9753FA8FAF6F1587 = undefined;
  self._id_667C153C8F4AAF73 = undefined;
  self setclientomnvar("ui_publicevent_auavscan_spotted", 0);
  self setclientomnvar("ui_publicevent_fullscreen_atlas_type", 0);
  _id_B1F3E9A415B3CAC8();
}

_id_A3F455B863175CC8(_id_28EEDB1A951AF158) {
  level endon("game_ended");
  level endon("public_event_auavscan_prone_phase_ended");
  self endon("death_or_disconnect");
  self _meth_D7BF524EB1822214(1);
  self _meth_B267CBAC73E99F49(0);

  while(_id_28EEDB1A951AF158 > gettime()) {
    if(!_id_F50D75FA9092AA20()) {
      thread _id_13E90BA0D8A6E1C3();
      break;
    }

    waitframe();
  }
}

watchweaponfired(_id_28EEDB1A951AF158) {
  level endon("game_ended");
  level endon("public_event_auavscan_prone_phase_ended");
  self endon("pe_auavscan_player_spotted");
  self endon("death_or_disconnect");

  while(_id_28EEDB1A951AF158 > gettime()) {
    self waittill("weapon_fired", objweapon);

    if(istrue(self._id_13E90BA0D8A6E1C3)) {
      break;
    }

    if(scripts\mp\class::isweaponsilenced(objweapon)) {
      continue;
    }
    self _meth_D7BF524EB1822214(0);
    self _meth_B267CBAC73E99F49(0);
    self setplayeradvanceduavdot(1);
    wait(level._id_E44708D64C7225DB._id_A88DCC32D9759428);
    self setplayeradvanceduavdot(0);
    self _meth_B267CBAC73E99F49(istrue(self._id_13E90BA0D8A6E1C3));
    self _meth_D7BF524EB1822214(!istrue(self._id_13E90BA0D8A6E1C3));
  }
}

onplayerspawned() {
  if(istrue(level._id_975B837A4FFA005E)) {
    _id_F5720CAC60CA8410();
    _id_B1F3E9A415B3CAC8();
    self _meth_D7BF524EB1822214(1);
    self _meth_B267CBAC73E99F49(0);
    self setplayeradvanceduavdot(0);
    self._id_13E90BA0D8A6E1C3 = undefined;
    self._id_9753FA8FAF6F1587 = undefined;
  }
}

_id_2222CF91CAEC46F1() {
  level endon("game_ended");

  if(level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 >= level._id_E44708D64C7225DB._id_11DA4BBB41691F62) {
    _id_1E6C2CB81CC42E5A = level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 - level._id_E44708D64C7225DB._id_11DA4BBB41691F62;
    wait(_id_1E6C2CB81CC42E5A);

    foreach(player in level.players) {
      if(!player _id_51C43EA1C9A91A16() || player _id_F50D75FA9092AA20()) {
        continue;
      }
      _id_29E0B91847C5CA63 = scripts\engine\utility::ter_op(player _meth_E40102956C887F7C(), "pe_auavscan_anticipation_water", "pe_auavscan_anticipation");
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer(_id_29E0B91847C5CA63, player, 1, 0, 0, undefined, "dx_br_bds4_");
    }
  }
}

_id_EF878C020746EB35() {
  level endon("game_ended");

  if(level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 >= level._id_E44708D64C7225DB._id_A1A6F1B9F605EAA9) {
    _id_AB64E25EA06BAC54 = level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 - level._id_E44708D64C7225DB._id_A1A6F1B9F605EAA9;
    wait(_id_AB64E25EA06BAC54);
  }

  foreach(player in level.players) {
    if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      continue;
    }
    player _id_F5720CAC60CA8410();
  }
}

_id_F5720CAC60CA8410() {
  self._id_667C153C8F4AAF73 = 1;
  self setclientomnvar("ui_publicevent_auavscan_spotted", -1);
  self setclientomnvar("ui_publicevent_fullscreen_atlas_type", 0);
}

_id_51C43EA1C9A91A16() {
  return isDefined(self) && isalive(self) && !_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && !istrue(self._id_667C153C8F4AAF73);
}

_id_13E90BA0D8A6E1C3() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("pe_auavscan_player_spotted");
  level._id_E44708D64C7225DB._id_5F6360CBCBB6908B[level._id_E44708D64C7225DB._id_5F6360CBCBB6908B.size] = self;
  self._id_13E90BA0D8A6E1C3 = 1;
  self setclientomnvar("ui_publicevent_auavscan_spotted", 1);
  self setclientomnvar("ui_publicevent_fullscreen_atlas_type", 2);
  scripts\mp\hud_message::showsplash("br_pe_auavscan_spotted", undefined, undefined, undefined, undefined, "splash_list_br_pe_auavscan");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("pe_auavscan_spotted", self, 1, 0, 0, undefined, "dx_br_bds4_");
  self setplayeradvanceduavdot(0);
  self _meth_D7BF524EB1822214(0);
  self _meth_B267CBAC73E99F49(1);
  thread _id_D4FC77FECF5FC687();
  wait 0.25;
  _id_17C8D9E220164807 = game["music"]["pe_auavscan_music_spotted"].size;
  _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
  self setplayermusicstate(game["music"]["pe_auavscan_music_spotted"][_id_DCC499C9734611F8]);
  self playsoundtoplayer("sfx_occupation_scan_spotted_flash", self);
}

_id_D4FC77FECF5FC687() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(self.iszombie)) {
    self visionsetnakedforplayer("pe_auavscan_flash", 0.075);
    wait 0.1;
    scripts\mp\utility\player::restorebasevisionset(2.5);
  }
}

_id_7A08CF3BBDF7AFF6() {
  _id_4AB6BD0A2EF31735 = level.uavbestid;
  _id_2DBCBBE66AA95FAF = "constant_radar";
  activeadvanceduavs = 1;
  skipuavupdate = 1;
  _id_4E456DDBB9897441(_id_2DBCBBE66AA95FAF, _id_4AB6BD0A2EF31735, activeadvanceduavs, skipuavupdate);
  self.hasradar = 1;
}

_id_B1F3E9A415B3CAC8() {
  _id_4AB6BD0A2EF31735 = level.uavnoneid;
  _id_2DBCBBE66AA95FAF = "normal_radar";
  activeadvanceduavs = 0;
  skipuavupdate = undefined;
  _id_4E456DDBB9897441(_id_2DBCBBE66AA95FAF, _id_4AB6BD0A2EF31735, activeadvanceduavs, skipuavupdate);
  self.hasradar = 0;
}

_id_4E456DDBB9897441(_id_2DBCBBE66AA95FAF, _id_4AB6BD0A2EF31735, activeadvanceduavs, skipuavupdate) {
  level.radarmode[self.guid] = _id_2DBCBBE66AA95FAF;
  self.radarstrength = _id_4AB6BD0A2EF31735;
  level.activeuavs[self.guid + "_radarStrength"] = _id_4AB6BD0A2EF31735;
  level.activeadvanceduavs[self.guid] = activeadvanceduavs;
  self.skipuavupdate = skipuavupdate;
  level.activeadvanceduavcount = level.teamnamelist.size;
  scripts\cp_mp\killstreaks\uav::_id_F9CAA46AA98B7C6B();
}

_id_ABF0B46D9FA2A191() {
  level endon("game_ended");

  if(level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 >= 13)
    wait(level._id_E44708D64C7225DB._id_6CA66F9BCE1F7E92 - 13);

  foreach(player in level.players) {
    if(isDefined(player) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && scripts\cp_mp\utility\player_utility::isreallyalive(player))
      player thread _id_7FA74F68012BF419();
  }

  wait 13;
}

_id_7FA74F68012BF419() {
  level endon("game_ended");
  self playlocalsound("sfx_occupation_pre_scan_timer");
  scripts\engine\utility::waittill_any_timeout_2(13, "death", "disconnect");
  self stoplocalsound("sfx_occupation_pre_scan_timer");
}

_id_81DCD9181C92C508(_id_476884B28A3A6C55, _id_DDBFC7A44986FB3B) {
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "available_players_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_476884B28A3A6C55;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "spotted_players_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DDBFC7A44986FB3B;
}

_id_F50D75FA9092AA20() {
  return self getstance() == "prone" || self _meth_6F55D55CCFF20D14();
}