/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_detonator_challenge.gsc
***********************************************************/

main() {
  if(getdvarint("dvar_FDD2344D2352C119", 0) == 0) {
    return;
  }
  init();
}

init() {
  level._id_C9F26EBE7AFDE859 = spawnStruct();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_bomb_detonator", ::_id_3C29A545ACDC191B);
  level thread initpostmain();
  level thread onplayerconnect();
  level thread _id_CFD5459B660E5398();
  initdialog();
}

initpostmain() {
  waittillframeend;
  scripts\mp\flags::gameflaginit("detonators_spawned", 0);
  _id_DDC77CE649F9E590();
  registerdvars();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_FD571520894A2AE1();
}

initdialog() {
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    game["dialog"]["found_detonator"] = "bmbd_ovld_fond";
    game["dialog"]["near_detonator"] = "bmbd_ovld_near";
  } else {
    game["dialog"]["found_detonator"] = "bmbd_wzan_fond";
    game["dialog"]["near_detonator"] = "bmbd_wzan_near";
  }
}

_id_CFD5459B660E5398() {
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595 = [];
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["castle"] = 4;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["cemetary"] = 9;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["cityhall"] = 7;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["library"] = 3;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["fleamarket"] = 0;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["museum"] = 5;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["shoppingcenter"] = 8;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["stadium"] = 6;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["station"] = 1;
  level._id_C9F26EBE7AFDE859._id_EE778403BEF96595["zoo"] = 2;
}

registerdvars() {
  level._id_C9F26EBE7AFDE859._id_6A4A54401554C4BD = [];

  foreach(_id_171F90B9C4C76D44, _ in level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6) {
    _id_AC6198806E0789A3 = _func_2EF675C13CA1C4AF("dvar_8CC03276A2993C6A", _id_171F90B9C4C76D44);

    if(_func_EC3AEA190C440D29(_id_AC6198806E0789A3))
      level._id_C9F26EBE7AFDE859._id_6A4A54401554C4BD[_id_171F90B9C4C76D44] = getdvarint(_id_AC6198806E0789A3);
  }

  level._id_C9F26EBE7AFDE859._id_EBAEC03AD499250C = getdvarint("dvar_48B16F2ADA78CC12", 1);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread _id_24A832519DF17AC2();
  }
}

_id_24A832519DF17AC2() {
  player = self;
  player endon("disconnect");
  scripts\mp\flags::gameflagwait("detonators_spawned");

  if(!isDefined(self._id_C770D7C80BB5D9AC))
    self waittill("game_flags_set");

  _id_F936F71526162AEF();
  player thread _id_C5773322A0D25ED6();
}

_id_F936F71526162AEF() {
  player = self;
  player._id_6A151ED49516DC4D = [];

  foreach(_id_F41133AAE59839AD, _id_05E65C21B408C962 in level._id_C9F26EBE7AFDE859._id_EE778403BEF96595)
  player._id_6A151ED49516DC4D[_id_F41133AAE59839AD] = scripts\cp_mp\challenges::_id_CFE6DCEDF7278543(_id_05E65C21B408C962);

  foreach(detonator in level._id_C9F26EBE7AFDE859._id_9892D265443ACA89) {
    if(player._id_6A151ED49516DC4D[detonator._id_B205D90302DA2F07]) {
      player _id_5546B121CEB2D07C(detonator);
      continue;
    }

    detonator enablescriptableplayeruse(player);
  }
}

_id_E504E51876AEFE56(player, _id_171F90B9C4C76D44) {
  detonator = self;

  foreach(detonator in level._id_C9F26EBE7AFDE859._id_9892D265443ACA89) {
    if(detonator._id_B205D90302DA2F07 == _id_171F90B9C4C76D44)
      player _id_5546B121CEB2D07C(detonator);
  }
}

_id_5546B121CEB2D07C(detonator) {
  player = self;
  detonator disablescriptableplayeruse(player);
  detonator hudoutlinedisableforclient(player);
}

_id_3C29A545ACDC191B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "on") {
    player scripts\cp_mp\challenges::_id_B7793133DF5FB0DF(level._id_C9F26EBE7AFDE859._id_EE778403BEF96595[instance.entity._id_B205D90302DA2F07]);
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "find_bomb_detonator", 1);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("found_detonator", player, 1, 0, undefined, undefined, "dx_br_bds4_");
    _id_E504E51876AEFE56(player, instance.entity._id_B205D90302DA2F07);
    player._id_6A151ED49516DC4D[instance.entity._id_B205D90302DA2F07] = 1;
  }
}

_id_DDC77CE649F9E590() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();
  _id_C9228E300CD096C4 = scripts\engine\utility::getStructArray("bomb_detonator_location", "targetname");
  level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6 = [];

  foreach(detonator in _id_C9228E300CD096C4)
  _id_6625A1C91934A540(detonator.origin, detonator.angles);
}

_id_6625A1C91934A540(origin, angles) {
  _id_F41133AAE59839AD = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

  if(!isDefined(_id_F41133AAE59839AD)) {
    return;
  }
  _id_F41133AAE59839AD = strtok(_id_F41133AAE59839AD, "_")[1];

  if(!isDefined(level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6[_id_F41133AAE59839AD]))
    level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6[_id_F41133AAE59839AD] = [];

  _id_160DE4CE31830901 = spawnStruct();
  _id_160DE4CE31830901.origin = origin;
  _id_160DE4CE31830901.angles = angles;
  level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6[_id_F41133AAE59839AD][level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6[_id_F41133AAE59839AD].size] = _id_160DE4CE31830901;
}

_id_FD571520894A2AE1() {
  level._id_C9F26EBE7AFDE859._id_9892D265443ACA89 = [];

  foreach(_id_171F90B9C4C76D44, _id_0397A376E32DC5B6 in level._id_C9F26EBE7AFDE859._id_0397A376E32DC5B6) {
    _id_0397A376E32DC5B6 = scripts\engine\utility::array_randomize(_id_0397A376E32DC5B6);
    _id_9785ED991A5E89DB = int(min(level._id_C9F26EBE7AFDE859._id_EBAEC03AD499250C, _id_0397A376E32DC5B6.size));

    if(isDefined(level._id_C9F26EBE7AFDE859._id_6A4A54401554C4BD[_id_171F90B9C4C76D44])) {
      _id_39ADBD994DF460B8 = level._id_C9F26EBE7AFDE859._id_6A4A54401554C4BD[_id_171F90B9C4C76D44];
      _id_257B34BCCDBBB227(_id_171F90B9C4C76D44, _id_0397A376E32DC5B6[_id_39ADBD994DF460B8]);
      _id_9785ED991A5E89DB--;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9785ED991A5E89DB; _id_AC0E594AC96AA3A8++)
      _id_257B34BCCDBBB227(_id_171F90B9C4C76D44, _id_0397A376E32DC5B6[_id_AC0E594AC96AA3A8]);
  }

  scripts\mp\flags::gameflagset("detonators_spawned");
}

_id_257B34BCCDBBB227(_id_171F90B9C4C76D44, _id_160DE4CE31830901) {
  scriptable = spawn("script_model", _id_160DE4CE31830901.origin);
  scriptable.angles = _id_160DE4CE31830901.angles;
  scriptable setModel("offhand_2h_wm_briefcase_bomb_delta");
  scriptable hudoutlineenable("shimmer_default");
  scriptable._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
  level._id_C9F26EBE7AFDE859._id_9892D265443ACA89[level._id_C9F26EBE7AFDE859._id_9892D265443ACA89.size] = scriptable;
}

_id_C5773322A0D25ED6() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  _id_AE8B7A0C078105EC = getdvarint("dvar_F952180D2A24D4C9", 450);
  cooldowntime = getdvarint("dvar_58B55AEB05B4D7AE", 60);

  if(cooldowntime == 0) {
    return;
  }
  _id_650E55A2C05FF4F8 = _id_AE8B7A0C078105EC * _id_AE8B7A0C078105EC;

  for(;;) {
    if(istrue(_id_E7E2118107268B89(player, _id_650E55A2C05FF4F8))) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("near_detonator", player, 1, 0, undefined, undefined, "dx_br_bds4_");
      wait(cooldowntime);
      _id_56932F10BF26D33F(player, _id_650E55A2C05FF4F8);
      continue;
    }

    wait 1;
  }
}

_id_E7E2118107268B89(player, _id_650E55A2C05FF4F8) {
  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  foreach(detonator in level._id_C9F26EBE7AFDE859._id_9892D265443ACA89) {
    found = player._id_6A151ED49516DC4D[detonator._id_B205D90302DA2F07];

    if(!found && distancesquared(detonator.origin, player.origin) <= _id_650E55A2C05FF4F8)
      return 1;
  }

  return 0;
}

_id_56932F10BF26D33F(player, _id_650E55A2C05FF4F8) {
  while(istrue(_id_E7E2118107268B89(player, _id_650E55A2C05FF4F8)))
    wait 1;
}