/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_burn.gsc
*****************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "burn") {
    return;
  }
  init();
}

init() {
  level.brgametype._id_79943FA2C8ED9A11 = getdvarfloat("dvar_A9986764C1F0011B", 10);
  level.brgametype._id_609F193CF1BF9AB8 = getdvarint("dvar_4E9E6905DCB3AF9F", 60);
  level.brgametype._id_6DA51D8D24D53D47 = getdvarint("dvar_207EBF2230809A52", 40);
  level.brgametype._id_CCA94E4718DC4C30 = getdvarint("dvar_207EBE223080981F", 20);
  level.brgametype._id_5FAF0949BF002392 = getdvarint("dvar_106D003B5C146750", 100);
  level.brgametype._id_6A7911463BCB8651 = getdvarfloat("dvar_2AF79CFD5F62EFAC", 0.5);
  level.brgametype._id_60DB8E3906DA00A5 = getdvarfloat("dvar_EF03FA333788AE3E", level.brgametype._id_609F193CF1BF9AB8);
  level.brgametype._id_CAE5CB0C0AABA8A9 = getdvarint("dvar_6D54526901289229", 1);
  level.brgametype._id_D13F0C77C8CA3733 = getdvarint("dvar_1F8A1B00BD97E168", 1);
  level.brgametype._id_DF547D85FD413893 = getdvarint("dvar_D72ABCD03273E9E4", 1);
  level.brgametype._id_5CD43D05CD3BABAF = getdvarint("dvar_AA687C192DD1A42B", 3000);
  level.brgametype._id_AEEADD8AC839E56F = getdvarfloat("dvar_389ACBBBEFF61B00", 1);
  level.brgametype._id_BAF6139A9CA8635D = getdvarfloat("dvar_D2ECB2B6E73ADDB6", 4);

  if(level.brgametype._id_CAE5CB0C0AABA8A9) {
    thread _id_14183DF6F9AF8737::_id_7269C88A927E7937();
    thread _id_14183DF6F9AF8737::_id_D7A7AA9EE1CC1071();
    level.brgametype._id_6420B42C7ADD53CC = 0;
    thread _id_0E6CA3C2CA24B16F();
    level.brgametype._id_2CFDC1D6E92251BF = getdvarint("dvar_B0F7DE3B3668CFD5", 10);
    level.brgametype.funcs["mayConsiderPlayerDead"] = undefined;
    level.brgametype.funcs["playerNakedDropLoadout"] = undefined;
    level.brgametype.funcs["playerKilledSpawn"] = undefined;
    level.brgametype.funcs["markPlayerAsEliminatedOnKilled"] = undefined;
    level.brgametype.funcs["assignLastStandAttacker"] = undefined;
    level.brgametype.funcs["kioskRevivePlayer"] = undefined;
    level.brgametype.funcs["onPlayerKilled"] = undefined;
    level.brgametype.funcs["dropOnPlayerDeath"] = undefined;
    level.brgametype.funcs["playerWelcomeSplashes"] = undefined;
  }

  _id_362C58E8BB39BCDA::registerbrgametypefunc("contractStart", ::_id_AF6B793643D58625);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("contractEnd", ::_id_06CEC56523FB963C);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("contractTimeAddModify", ::_id_F3BC5503E37FB97B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("contractTimeModify", ::_id_0A2B1921D51871C4);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onDeadEvent", ::ondeadevent);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::onplayerkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onSpawnPlayer", ::onspawnplayer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("canTakePickup", ::cantakepickup);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("postUpdateGameEvents", ::postupdategameevents);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnect);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropPlunderOnDeath", ::playerdropplunderondeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerPlunderModifyInventoryDrop", ::_id_8CBFD2ECFD59CEBD);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("giveQuestReward", ::givequestreward);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskValidateItemPurchase", ::_id_6578A6253EB56926);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskHandleSpecialPurchase", ::_id_D0B584FB93B4027E);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("aq_determineTargetTeam", ::_id_F96BB15416298075);

  if(level.brgametype._id_D13F0C77C8CA3733) {
    _id_362C58E8BB39BCDA::registerbrgametypefunc("circleTimerNext", ::circletimernext);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onGrenadeUsed", ::ongrenadeused);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("playerCanSeeDangerCircleWorld", ::playercanseedangercircleworld);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("lootCacheAdjustItems", ::_id_A7AC54D225AD192C);
    scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setArmorOmnvars", ::_id_CF547D762189DEAA);
  }

  if(level.brgametype._id_CAE5CB0C0AABA8A9) {
    _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", ::mayconsiderplayerdead);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::playernakeddroploadout);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKilledSpawn", ::_id_C16252BB9C1CCF13);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", ::_id_AAD53C864BD67F16);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("assignLastStandAttacker", ::_id_635E27145C3615E8);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", ::kioskreviveplayer);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("updateRespawnDelay", ::_id_90D7D14F52E46883);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("resurgenceDisableSkipForPlayer", ::_id_B629CA6173E4E47F);
  }

  level._id_0383825619799549 = 0;
  level.brgametype._id_5183B2A1EADE5F6D = [];
  level.brgametype._id_5E7DDA59E17545F6 = [];
  level.brgametype._id_E9A667EFF217007A = [];
  _id_2D3D2235432ADCD7("classtable:classtable_br_burn_assassin");
  thread initpostmain();
}

initpostmain() {
  waittillframeend;

  if(level.brgametype._id_D13F0C77C8CA3733) {
    _id_65984970C8FD9780::_id_7F51120D757C476D();
    scripts\mp\supers::_id_53110A12409D01DA("super_armory", undefined, ::empty, undefined, undefined, undefined, undefined, undefined);
  }

  _id_7A4D88E14D29AEC9();
  thread _id_FC9492A29BA1AB55();
}

empty() {}

onspawnplayer() {
  if(_id_301EC2DE7600D358(self.team))
    _id_2FD0D56C49031944();
  else if(_id_0194C860F5134A8E(self.team))
    thread _id_1AAFD9DC2686A605();

  _id_756141322510D54A();
  _id_6E348FD6ADD2966D();
  _id_159FCF83EDB29254();
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    _id_7A137583DD54723B = "DEBUG onPlayerKilled: victim = " + scripts\engine\utility::ter_op(isDefined(self), self getentitynumber() + ", team = " + self.team + ", burn = " + _id_301EC2DE7600D358(self.team), "");

    if(isDefined(_id_642470E1ABC1BBF9.attacker)) {
      if(isPlayer(_id_642470E1ABC1BBF9.attacker))
        _id_7A137583DD54723B = _id_7A137583DD54723B + (", player attacker = " + _id_642470E1ABC1BBF9.attacker getentitynumber() + ", team = " + _id_642470E1ABC1BBF9.attacker.team + ", burn = " + _id_0194C860F5134A8E(_id_642470E1ABC1BBF9.attacker.team));
      else
        _id_7A137583DD54723B = _id_7A137583DD54723B + (", non player attacker = " + _id_642470E1ABC1BBF9.attacker getentitynumber());
    } else
      _id_7A137583DD54723B = _id_7A137583DD54723B + ", undefined player attacker";

    logstring(_id_7A137583DD54723B);

    if(_id_301EC2DE7600D358(self.team) && isDefined(_id_642470E1ABC1BBF9.attacker) && isPlayer(_id_642470E1ABC1BBF9.attacker) && _id_0194C860F5134A8E(_id_642470E1ABC1BBF9.attacker.team))
      _id_4E8E7C7B894A161E(_id_642470E1ABC1BBF9.attacker.team, 1);

    if(_id_301EC2DE7600D358(self.team))
      _id_5BC395680182ED50(0);
    else if(_id_0194C860F5134A8E(self.team))
      _id_11A0D9813368CF1D(0);

    _id_07785735C89BD803();

    if(isDefined(_id_642470E1ABC1BBF9.attacker) && isPlayer(_id_642470E1ABC1BBF9.attacker)) {
      attacker = _id_642470E1ABC1BBF9.attacker;
      attacker._id_2160249FF5DEEF30 = clamp(attacker._id_2160249FF5DEEF30 + level.brgametype._id_6A7911463BCB8651, 0.0, level.brgametype._id_609F193CF1BF9AB8);
      attacker _id_70CBFBA1E5479D53();
      attacker _id_93C5F6CD67AF87E2();

      if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(attacker.team)) {
        self._id_6F75C711F7773C67 = 1;
        _id_14183DF6F9AF8737::_id_277C5D414A129608(_id_642470E1ABC1BBF9);
      }

      _id_4E5A0B81AEFB772F = _id_C0569ABDC98DAE19();

      if(_id_4E5A0B81AEFB772F > 0)
        attacker _id_C4F39ED21487C817();
    }

    self._id_2160249FF5DEEF30 = clamp(self._id_2160249FF5DEEF30 - level.brgametype._id_60DB8E3906DA00A5, 0.0, level.brgametype._id_609F193CF1BF9AB8);
  }

  _id_437D6788359394A5(1);
  _id_6927F3AA48579C3F();
  _id_4EF10BA38B16FFB4();
}

ondeadevent(team) {
  if(_id_301EC2DE7600D358(team))
    thread _id_5FBF9DA862E5EBBD(team, 0);
  else if(_id_0194C860F5134A8E(team)) {
    _id_4E8E7C7B894A161E(team, 0);
    return 0;
  }

  thread _id_1D0BCBBCD67F6C50(team);
  return 1;
}

cantakepickup(pickupent) {
  if(_id_0194C860F5134A8E(self.team) && _id_7E52B56769FA7774::isquesttablet(pickupent.scriptablename))
    return 33;

  return 0;
}

onplayerconnect(player) {
  player thread _id_E45F0D0EE72806B8();
}

playerwelcomesplashes() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(game["liveLobbyCompleted"]))
    scripts\mp\hud_message::showsplash("br_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground())
      waitframe();
  } else
    level waittill("prematch_done");

  _id_715028F54BAD19A1::branalytics_landing(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_burn_welcome");
}

_id_F3BC5503E37FB97B(_id_6640C2677653D96F, missiontime) {
  if(!_id_95B492457531B9A9(_id_6640C2677653D96F.type.ref))
    return missiontime;

  _id_98EA5AFB293A76A2 = 1.0;

  switch (_id_6640C2677653D96F.type.ref) {
    case "vip":
      _id_98EA5AFB293A76A2 = getdvarfloat("dvar_D4B42408148972EE", 2.0);
      break;
    case "assassination":
      break;
    case "safecracker":
      missiontime = _id_7AA9FAEB9EEC8DE6(_id_6640C2677653D96F, missiontime, 1);
      break;
    case "intel":
    default:
      _id_98EA5AFB293A76A2 = getdvarfloat("dvar_DEBE6E46D99BF7A2", 0.5);
      break;
  }

  _id_98EA5AFB293A76A2 = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_99F109702FF3DF10", _id_6640C2677653D96F.type.ref), _id_98EA5AFB293A76A2);
  return int(missiontime * _id_98EA5AFB293A76A2);
}

_id_0A2B1921D51871C4(_id_6640C2677653D96F, missiontime) {
  if(!_id_95B492457531B9A9(_id_6640C2677653D96F.type.ref))
    return missiontime;

  switch (_id_6640C2677653D96F.type.ref) {
    case "vip":
      missiontime = _id_913C605BC005F287(_id_6640C2677653D96F, missiontime);
      break;
    case "assassination":
      missiontime = _id_0091C03D70C050B7(_id_6640C2677653D96F, missiontime);
      break;
    case "safecracker":
      missiontime = _id_7AA9FAEB9EEC8DE6(_id_6640C2677653D96F, missiontime, 0);
      break;
    case "intel":
      missiontime = _id_BA3FB66AD5A28FAC(_id_6640C2677653D96F, missiontime);
      break;
    default:
      missiontime = _id_5442EDFA809ADE22(_id_6640C2677653D96F, missiontime, getdvarfloat("dvar_7648F9472A5CE32E", 0.5));
      break;
  }

  return missiontime;
}

_id_5442EDFA809ADE22(_id_6640C2677653D96F, missiontime, _id_98EA5AFB293A76A2) {
  _id_98EA5AFB293A76A2 = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_FA0DC933C7F23AB4", _id_6640C2677653D96F.type.ref), _id_98EA5AFB293A76A2);
  missiontime = int(missiontime * _id_98EA5AFB293A76A2);
  return int(missiontime * _id_98EA5AFB293A76A2);
}

_id_913C605BC005F287(_id_6640C2677653D96F, missiontime) {
  return getdvarint("dvar_E987014278B250B0", 360);
}

_id_0091C03D70C050B7(_id_6640C2677653D96F, missiontime) {
  _id_3C4B5FFB466FC1AE = _id_6640C2677653D96F._id_0D154AC2657C5F44;
  _id_34D0E2FC8153072E = _id_6640C2677653D96F.hunterteam;
  targetplayer = _id_6640C2677653D96F.targetplayer;
  _id_7FAC5B3FFF459084 = scripts\mp\utility\teams::getteamdata(_id_34D0E2FC8153072E, "players");
  _id_00BF97AF9158BCF3 = undefined;

  foreach(player in _id_7FAC5B3FFF459084) {
    if(!isalive(player)) {
      continue;
    }
    dist = distance(player.origin, targetplayer.origin);

    if(!isDefined(_id_00BF97AF9158BCF3) || dist < _id_00BF97AF9158BCF3)
      _id_00BF97AF9158BCF3 = dist;
  }

  if(!isDefined(_id_00BF97AF9158BCF3))
    return missiontime;

  _id_A6C8E8D1B1F9A978 = _id_00BF97AF9158BCF3 / getdvarfloat("dvar_47B697F586B0DCAB", 240);
  _id_2B1B7E016DD5D577 = getdvarint("dvar_05493CDF51A822B4", 15);
  _id_DE14AB730BDC2649 = getdvarint("dvar_8915BDCC191BD174", 20);
  return int(_id_A6C8E8D1B1F9A978 + _id_2B1B7E016DD5D577 + _id_DE14AB730BDC2649);
}

_id_7AA9FAEB9EEC8DE6(_id_6640C2677653D96F, missiontime, addtime) {
  _id_34D0E2FC8153072E = _id_6640C2677653D96F.teams[0];
  players = scripts\mp\utility\teams::getteamdata(_id_34D0E2FC8153072E, "players");
  _id_00BF97AF9158BCF3 = undefined;
  missiontime = 0;

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }
    foreach(_id_65F2E31BA81E1B45 in _id_6640C2677653D96F._id_5344ABD2BA35D7C2) {
      if(isDefined(_id_65F2E31BA81E1B45._id_32605DB102447D94) && istrue(_id_65F2E31BA81E1B45._id_32605DB102447D94.opened)) {
        continue;
      }
      loc = _id_65F2E31BA81E1B45._id_2A438B0332B8A143.origin;
      dist = distance(player.origin, loc);

      if(!isDefined(_id_00BF97AF9158BCF3) || dist < _id_00BF97AF9158BCF3)
        _id_00BF97AF9158BCF3 = dist;
    }
  }

  if(!isDefined(_id_00BF97AF9158BCF3))
    return missiontime;

  _id_A6C8E8D1B1F9A978 = _id_00BF97AF9158BCF3 / getdvarfloat("dvar_9A13C495F7E493EA", 90);
  _id_2B1B7E016DD5D577 = 0;

  if(!istrue(addtime))
    _id_2B1B7E016DD5D577 = getdvarint("dvar_AE06E428F9E90C5B", 15);
  else
    _id_2B1B7E016DD5D577 = getdvarint("dvar_07D0E3BDFBF9A777", 15);

  return int(_id_A6C8E8D1B1F9A978 + _id_2B1B7E016DD5D577);
}

_id_BA3FB66AD5A28FAC(_id_6640C2677653D96F, missiontime) {
  _id_34D0E2FC8153072E = _id_6640C2677653D96F.teams[0];
  players = scripts\mp\utility\teams::getteamdata(_id_34D0E2FC8153072E, "players");
  _id_00BF97AF9158BCF3 = undefined;
  missiontime = 0;

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }
    dist = distance(player.origin, _id_6640C2677653D96F._id_5E5710CA5B795C6B.origin);

    if(!isDefined(_id_00BF97AF9158BCF3) || dist < _id_00BF97AF9158BCF3)
      _id_00BF97AF9158BCF3 = dist;
  }

  if(!isDefined(_id_00BF97AF9158BCF3))
    return missiontime;

  _id_7F281683902BC1F5 = distance(_id_6640C2677653D96F._id_5E5710CA5B795C6B.origin, _id_6640C2677653D96F._id_265CF6F9F157AD08.origin);
  _id_C5814E2A680F4B8B = _id_00BF97AF9158BCF3 / getdvarfloat("dvar_42EF77CDD2A4544D", 150);
  _id_C5814F2A680F4DBE = _id_7F281683902BC1F5 / getdvarfloat("dvar_42EF77CDD2A4544D", 150);
  _id_2B1B7E016DD5D577 = getdvarint("dvar_72469D232CCCDC12", 15);
  return int(_id_C5814E2A680F4B8B + _id_C5814F2A680F4DBE + _id_2B1B7E016DD5D577 + level._id_D6AE5CC7B162C730._id_07383519BDE1C5CE);
}

_id_95B492457531B9A9(_id_5744FAFD565864D7) {
  switch (_id_5744FAFD565864D7) {
    case "safecracker":
    case "vip":
    case "intel":
    case "assassination":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_AF6B793643D58625(_id_5744FAFD565864D7, team) {
  if(!_id_95B492457531B9A9(_id_5744FAFD565864D7)) {
    return;
  }
  _id_6D9C07E1D16F03C0::_id_83FCE66824A454E7(team);

  if(_id_5744FAFD565864D7 == "vip" && !isDefined(self._id_B6E23955B9764CC0))
    _id_2FD0D56C49031944();

  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player _id_FD8F31C3C6BC8F26();
}

_id_06CEC56523FB963C(_id_6640C2677653D96F, team, success) {
  thread _id_E447C95F657D5325(_id_6640C2677653D96F, team, success);
}

_id_E447C95F657D5325(_id_6640C2677653D96F, team, success) {
  level endon("game_ended");
  _id_5744FAFD565864D7 = _id_6640C2677653D96F.type.ref;

  if(!_id_95B492457531B9A9(_id_5744FAFD565864D7)) {
    return;
  }
  wait 2;
  _id_6D9C07E1D16F03C0::_id_C5FBDC2F5659F962(team);

  if(_id_5744FAFD565864D7 == "vip" && isDefined(_id_6640C2677653D96F.vip))
    _id_6640C2677653D96F.vip _id_5BC395680182ED50(0);

  if(success) {
    _id_2388AEAD072361E9(team, 1);
    _id_CDB766CD324E01F1(team);
  } else if(!_id_0194C860F5134A8E(team) && !_id_301EC2DE7600D358(team))
    _id_8100594E66CC40D6(team);

  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player _id_07785735C89BD803();
}

_id_2FD0D56C49031944() {
  _id_C510D53F15EE265D();
  self._id_B6E23955B9764CC0 = spawnStruct();
  _id_B6E23955B9764CC0 = self._id_B6E23955B9764CC0;
  _id_B6E23955B9764CC0.targetplayer = self;
  _id_B6E23955B9764CC0 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Assassination_Br");
  _id_B6E23955B9764CC0 scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794);
  _id_B6E23955B9764CC0 thread _id_AFA30EC076DDE866();
  _id_B6E23955B9764CC0 thread _id_7CF0E71C8AEFBD73();
  _id_B6E23955B9764CC0 thread _id_1F56628E38AB2F50();
  scripts\mp\hud_message::showsplash("br_burn_notice_start");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted", self.team, 1);
}

_id_5BC395680182ED50(_id_0850E83A4AD5D90C) {
  _id_A31123CA9E6292C4();

  if(isDefined(self._id_B6E23955B9764CC0)) {
    self._id_B6E23955B9764CC0 scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
    self._id_B6E23955B9764CC0 notify("task_ended");
    self._id_B6E23955B9764CC0 = undefined;
  }

  if(_id_0850E83A4AD5D90C)
    scripts\mp\hud_message::showsplash("br_burn_notice_end");
}

_id_7CF0E71C8AEFBD73() {
  self endon("task_ended");
  level endon("game_ended");

  for(;;) {
    _id_02BDEFC4B5300716::determinetrackingcircleposition(self.targetplayer);
    wait 10.0;
  }
}

_id_1F56628E38AB2F50() {
  self endon("task_ended");
  level endon("game_ended");
  self.targetplayer waittill("disconnect");
  self.targetplayer _id_5BC395680182ED50(0);
}

_id_AFA30EC076DDE866() {
  foreach(team, value in level.brgametype._id_5E7DDA59E17545F6) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(player))
        scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
    }
  }
}

_id_301EC2DE7600D358(team) {
  return isDefined(level.brgametype._id_5183B2A1EADE5F6D[team]);
}

_id_8100594E66CC40D6(team) {
  level.brgametype._id_5183B2A1EADE5F6D[team] = spawnStruct();
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(isalive(player)) {
      player _id_2FD0D56C49031944();
      player _id_07785735C89BD803();
    }
  }

  _id_6D9C07E1D16F03C0::_id_00D8A347AD56A61A(team);
}

_id_5FBF9DA862E5EBBD(team, success) {
  waittillframeend;
  _id_2388AEAD072361E9(team, success);
}

_id_2388AEAD072361E9(team, success) {
  if(!_id_301EC2DE7600D358(team)) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    player _id_5BC395680182ED50(success);
    player _id_07785735C89BD803();
  }

  level.brgametype._id_5183B2A1EADE5F6D[team] = undefined;
}

_id_F96BB15416298075(player, _id_86A80A97F4672FC8) {
  hunterteam = player.team;
  _id_3B8219D206004DFA = undefined;
  _id_0774C9CA5D1D6221 = 0;
  _id_12729FF62E52ED4D = level.players;
  _id_EA7CD2B67D803BC4 = level._id_AAB4FBA7A041B281;
  _id_EA7CD5B67D80425D = scripts\mp\utility\teams::getteamdata(hunterteam, "players");
  excludedteams = scripts\engine\utility::array_combine_unique(_id_EA7CD2B67D803BC4, _id_EA7CD5B67D80425D);
  _id_EB362CD8AE206E57 = 0;
  _id_63B9EFF90CD38E5D = level._id_7E12F6EB4FCB4EA1._id_987F2ECCF1688B21;
  _id_877E83278A9F2EAC = level._id_7E12F6EB4FCB4EA1._id_877E83278A9F2EAC;

  while(!isDefined(_id_3B8219D206004DFA)) {
    _id_EB362CD8AE206E57 = _id_EB362CD8AE206E57 + level._id_7E12F6EB4FCB4EA1._id_8718AEB5B6F8EB16;
    _id_64D072985F0A15A5 = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, excludedteams, undefined, _id_63B9EFF90CD38E5D + _id_EB362CD8AE206E57, _id_63B9EFF90CD38E5D);
    playerlist = [];

    foreach(_id_BD73C7ACC56CD20C in _id_64D072985F0A15A5) {
      if(istrue(_id_86A80A97F4672FC8) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418(player.origin, _id_BD73C7ACC56CD20C.origin)) {
        continue;
      }
      if(!istrue(_id_BD73C7ACC56CD20C.hasbeentracked) && !_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_BD73C7ACC56CD20C) && _id_301EC2DE7600D358(_id_BD73C7ACC56CD20C.team))
        playerlist[playerlist.size] = _id_BD73C7ACC56CD20C;
    }

    if(playerlist.size == 0) {
      if(_id_EB362CD8AE206E57 > _id_877E83278A9F2EAC) {
        break;
      }
    }

    _id_3A0D4DA4585D5B22 = [];
    _id_90B91D6205FCE07F = 0;
    _id_29F6D200784F77B3 = (0, 0, 0);

    foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(hunterteam, "players")) {
      if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5)) {
        _id_90B91D6205FCE07F++;
        _id_29F6D200784F77B3 = _id_29F6D200784F77B3 + _id_F0EA4030349A33D5.origin;
      }
    }

    _id_29F6D200784F77B3 = _id_29F6D200784F77B3 / _id_90B91D6205FCE07F;

    foreach(_id_BD73C7ACC56CD20C in playerlist) {
      _id_B54FEA3B6F15223C = 0;

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(_id_BD73C7ACC56CD20C.team, "players")) {
        if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5))
          _id_B54FEA3B6F15223C++;
      }

      if(_id_B54FEA3B6F15223C == 0) {
        continue;
      }
      if(!isDefined(_id_3B8219D206004DFA)) {
        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
        continue;
      }

      _id_0B78E01E4CA8F50A = (0, 0, 0);

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(_id_BD73C7ACC56CD20C.team, "players")) {
        if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5))
          _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A + _id_F0EA4030349A33D5.origin;
      }

      _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A / _id_B54FEA3B6F15223C;
      _id_76E3E3800077282F = (0, 0, 0);

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(_id_3B8219D206004DFA, "players")) {
        if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5))
          _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A + _id_F0EA4030349A33D5.origin;
      }

      _id_76E3E3800077282F = _id_76E3E3800077282F / _id_B54FEA3B6F15223C;

      if(distance2d(_id_29F6D200784F77B3, _id_0B78E01E4CA8F50A) < distance2d(_id_29F6D200784F77B3, _id_76E3E3800077282F)) {
        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
        continue;
      }
    }
  }

  if(!isDefined(_id_3B8219D206004DFA))
    _id_3B8219D206004DFA = _id_02BDEFC4B5300716::determinetargetteam(player, _id_86A80A97F4672FC8);

  return _id_3B8219D206004DFA;
}

_id_1D0BCBBCD67F6C50(team) {
  waittillframeend;
  _id_6F0D345ED7E4F8F4(team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player thread _id_FC3657ADED1E34A8();
}

_id_6F0D345ED7E4F8F4(team) {
  level.brgametype._id_5E7DDA59E17545F6[team] = 1;
  level.teamdata[team]["lastAssassinTime"] = gettime();
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  level.brgametype._id_E9A667EFF217007A = _id_761B14B93E89DE88(level.brgametype._id_E9A667EFF217007A, players);
  _id_6D9C07E1D16F03C0::_id_00D8A347AD56A61A(team);
  [[level.updategameevents]]();
}

_id_FC3657ADED1E34A8() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  _id_30839284ADD41CED = getdvarint("dvar_E59044A69AB2D054", 5.0);
  scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + _id_30839284ADD41CED * 1000));
  fadetogearingup(_id_30839284ADD41CED, 1);
  spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();
  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1, undefined, 0, 0, 1);
  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_B092E3259EC308D8");
  self setclientomnvar("ui_br_transition_type", 0);
}

_id_1AAFD9DC2686A605(_id_53BFCF2DFB38A051) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("assassin_set");
  _id_A19CA380AF33649A();
  _id_E8179510475F215D();
  _id_8829888046CB3AA7();
  _id_1BBCCB89D2717603();
  _id_47B27A1B0BA7BBE8();

  if(!istrue(_id_53BFCF2DFB38A051))
    wait 3;

  _id_C6A1804379378045();
  scripts\mp\hud_message::showsplash("br_burn_assassin_start");
}

_id_11A0D9813368CF1D(success) {
  self notify("assassin_unset");
  _id_CFC27D37C16563C4();
  _id_92FF6FE462B9B5A5();
  _id_9B3400979A6B9D20();
  _id_B8E8000ADD2D62EC();
  _id_FDF0B9769EDEB3BD();
  _id_F1E75963FA57EF16();

  if(success)
    scripts\mp\hud_message::showsplash("br_burn_assassin_end");
}

fadetogearingup(waittime, squadwiped) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0)
    wait(waittime);

  _id_B59F471C2C064E56 = 1.0;
  thread fadeoutin();
  wait(_id_B59F471C2C064E56 - 0.25);

  if(istrue(squadwiped))
    self setclientomnvar("ui_br_transition_type", 6);
  else
    self setclientomnvar("ui_br_transition_type", 2);

  wait 0.25;

  if(getdvarint("dvar_F006294EF8B720A4", 1) == 1) {
    _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
    _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
    _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
  }
}

fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  self waittill("spawned_player");
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

_id_A19CA380AF33649A() {
  foreach(team, _id_B6E23955B9764CC0 in level.brgametype._id_5183B2A1EADE5F6D) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      if(isDefined(player._id_B6E23955B9764CC0))
        player._id_B6E23955B9764CC0 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(self);
    }
  }
}

_id_92FF6FE462B9B5A5() {
  foreach(team, _id_B6E23955B9764CC0 in level.brgametype._id_5183B2A1EADE5F6D) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      if(isDefined(player._id_B6E23955B9764CC0))
        player._id_B6E23955B9764CC0 scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(self);
    }
  }
}

_id_E8179510475F215D() {
  _id_0DDF3A00081440D0();
  _id_4382A3B156CD8CA4();
  _id_98FE366F6B279A76();
  thread _id_F20FDFBFA367BE79();
  thread _id_23B5EBB7355A8F5C();
}

_id_9B3400979A6B9D20() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self._id_629FF37E3487DB6D);
  scripts\mp\objidpoolmanager::returnobjectiveid(self._id_629FF37E3487DB6D);
  _id_98FE366F6B279A76();
}

_id_0DDF3A00081440D0() {
  self._id_629FF37E3487DB6D = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self._id_629FF37E3487DB6D != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self._id_629FF37E3487DB6D, "active", (0, 0, 0), "ui_mp_br_mapmenu_icon_assassin_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(self._id_629FF37E3487DB6D, 1);
    objective_showtoplayersinmask(self._id_629FF37E3487DB6D);
    _func_D76CC64B205084A3(self._id_629FF37E3487DB6D, 1);
    objective_sethideelevation(self._id_629FF37E3487DB6D, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self._id_629FF37E3487DB6D, 0);
    scripts\mp\objidpoolmanager::update_objective_position(self._id_629FF37E3487DB6D, self.origin + (0, 0, 10));
  } else {}
}

_id_4382A3B156CD8CA4() {
  objective_addalltomask(self._id_629FF37E3487DB6D);

  foreach(player in level.players) {
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(player) && isDefined(level.brgametype._id_5E7DDA59E17545F6[player.team])) {
      objective_addclienttomask(self._id_629FF37E3487DB6D, player);
      continue;
    }

    objective_removeclientfrommask(self._id_629FF37E3487DB6D, player);
  }
}

_id_98FE366F6B279A76() {
  _id_D5261CED6984AFAA = 30;
  _id_A658D6895A7CC7E8 = 5000;
  _id_13E94232B2A8E830 = sortbydistancecullbyradius(level.brgametype._id_E9A667EFF217007A, self.origin, _id_A658D6895A7CC7E8);
  count = 0;

  foreach(player in _id_13E94232B2A8E830) {
    if(player.team == self.team) {
      continue;
    }
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(player)) {
      if(isDefined(level.brgametype._id_5E7DDA59E17545F6[self.team]) && count < _id_D5261CED6984AFAA) {
        objective_addclienttomask(player._id_629FF37E3487DB6D, self);
        count++;
        continue;
      }

      objective_removeclientfrommask(player._id_629FF37E3487DB6D, self);
    }
  }
}

_id_F20FDFBFA367BE79() {
  level endon("game_ended");
  self endon("death");
  self waittill("disconnect");
  _id_9B3400979A6B9D20();
}

_id_23B5EBB7355A8F5C() {
  self endon("task_ended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    wait(level.brgametype._id_79943FA2C8ED9A11);
    scripts\mp\objidpoolmanager::update_objective_position(self._id_629FF37E3487DB6D, self.origin + level._id_9462BDE338826062._id_F7DD2C06F9C5E900);
    _id_98FE366F6B279A76();
  }
}

_id_0194C860F5134A8E(team) {
  return isDefined(level.brgametype._id_5E7DDA59E17545F6[team]);
}

_id_4E8E7C7B894A161E(team, success) {
  if(!_id_0194C860F5134A8E(team)) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  level.brgametype._id_E9A667EFF217007A = _id_855518ABC203666B(level.brgametype._id_E9A667EFF217007A, players);
  level.brgametype._id_5E7DDA59E17545F6[team] = undefined;
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(isalive(player))
      player _id_11A0D9813368CF1D(success);
  }
}

_id_6578A6253EB56926(_id_15B89FF206500554, _id_A365E25AA9D7BCDA) {
  if(_id_A365E25AA9D7BCDA.type == "special" && _id_A365E25AA9D7BCDA.ref == "burn_assassin_buyback") {
    if(!_id_0194C860F5134A8E(self.team)) {
      _id_4384ABBF498DF6A7::_closepurchasemenuwithresponse(25);
      return 0;
    } else
      return 1;
  }

  return undefined;
}

_id_D0B584FB93B4027E(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_15B89FF206500554, _id_59CDCDF44A2FA379, _id_B517DF938986556F, quantity) {
  if(_id_A365E25AA9D7BCDA.ref == "burn_assassin_buyback") {
    thread _id_4E8E7C7B894A161E(self.team, 1);
    thread _id_462F857673E82BE1();
    return [1, 1, 0, 1];
  }

  return [0, _id_59CDCDF44A2FA379, _id_B517DF938986556F, quantity];
}

_id_462F857673E82BE1() {
  waitframe();
  _id_4384ABBF498DF6A7::_closepurchasemenuwithresponse(2);
}

_id_2D3D2235432ADCD7(table) {
  if(!isDefined(level._id_D82B2292B1135B83))
    level._id_D82B2292B1135B83 = [];

  _id_A78225C464121E51 = level._id_D82B2292B1135B83.size;
  _id_07D958726E11B327 = scripts\mp\class::_id_DF2933F96D726D71(table);

  for(_id_089688461C79EF11 = 0; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
    level._id_D82B2292B1135B83[_id_089688461C79EF11] = _id_DE39159448AC90A8(_id_089688461C79EF11, table);
}

_id_DE39159448AC90A8(_id_089688461C79EF11, table) {
  _id_CFA6985254954FB3 = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = _id_CFA6985254954FB3.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = _id_CFA6985254954FB3.primaryweapon._id_59F68715C04CE28F;
  loadout["loadoutPrimaryAttachment2"] = _id_CFA6985254954FB3.primaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutPrimaryAttachment3"] = _id_CFA6985254954FB3.primaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutPrimaryAttachment4"] = _id_CFA6985254954FB3.primaryweapon._id_59F68215C04CD790;
  loadout["loadoutPrimaryAttachment5"] = _id_CFA6985254954FB3.primaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutPrimaryCamo"] = _id_CFA6985254954FB3.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = _id_CFA6985254954FB3.primaryweapon.reticle;
  loadout["loadoutSecondary"] = _id_CFA6985254954FB3.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68715C04CE28F;
  loadout["loadoutSecondaryAttachment2"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutSecondaryAttachment3"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutSecondaryAttachment4"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68215C04CD790;
  loadout["loadoutSecondaryAttachment5"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutSecondaryCamo"] = _id_CFA6985254954FB3.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = _id_CFA6985254954FB3.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = _id_CFA6985254954FB3.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = _id_CFA6985254954FB3.equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [_id_CFA6985254954FB3.perks._id_16680ABD1742C050, _id_CFA6985254954FB3.perks._id_16680DBD1742C6E9, _id_CFA6985254954FB3.perks._id_16680CBD1742C4B6, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680ABD1742C050, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680DBD1742C6E9, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

_id_82E9F6D42B55B43F(_id_089688461C79EF11, _id_2FEFED9BB7EA82D8, _id_C179E44BD14D2D12) {
  if(!isDefined(_id_089688461C79EF11))
    _id_089688461C79EF11 = 0;

  if(!isDefined(_id_C179E44BD14D2D12))
    _id_C179E44BD14D2D12 = 0;

  _id_089688461C79EF11 = randomintrange(0, level._id_D82B2292B1135B83.size);
  self.pers["gamemodeLoadout"] = level._id_D82B2292B1135B83[_id_089688461C79EF11];
  self.class = "gamemode";
  self.prevweaponobj = undefined;
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", _id_2FEFED9BB7EA82D8, _id_2FEFED9BB7EA82D8);
  _id_1E4A61DB11011446::givelaststandifneeded(self);
  _id_724736FCF0FB6604::br_ammo_player_clear();

  if(!istrue(_id_C179E44BD14D2D12)) {
    foreach(weaponname in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(weaponname)) {
        clipsize = weaponclipsize(weaponname);
        objweapon = makeweaponfromstring(weaponname);

        if(scripts\mp\utility\weapon::isakimbo(objweapon)) {
          self setweaponammoclip(weaponname, clipsize, "left");
          self setweaponammoclip(weaponname, clipsize, "right");
        } else
          self setweaponammoclip(weaponname, clipsize);

        ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(objweapon);
        _id_724736FCF0FB6604::br_ammo_give_type(self, ammotype, clipsize);
      }
    }
  }
}

_id_FDF0B9769EDEB3BD() {
  _id_55E418C5CC946593::_id_19868614946C4DF4();
}

_id_7A4D88E14D29AEC9() {
  if(!level.brgametype._id_DF547D85FD413893) {
    return;
  }
  level.brgametype._id_1A88403BF3CF52F8 = spawnStruct();
  level.brgametype._id_1A88403BF3CF52F8.powers = [];
  addpowerbutton(level.brgametype._id_1A88403BF3CF52F8, "emp", "+special", undefined, ::_id_4CB4AF756E462BE5, undefined, undefined, undefined, &"BR_BURN/POWER_SNAPSHOT", undefined, 6);
  addpowerbutton(level.brgametype._id_1A88403BF3CF52F8, "thermal", "nightvision", undefined, ::_id_D9840B353D985474, undefined, ::_id_3C1F1C622F6EB134, undefined, &"BR_BURN/POWER_THERMAL", undefined, 1);
}

_id_8829888046CB3AA7() {
  if(!level.brgametype._id_DF547D85FD413893) {
    return;
  }
  thread playerstartpowers(level.brgametype._id_1A88403BF3CF52F8);
}

_id_4CB4AF756E462BE5(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  position = self.origin;
  angles = self.angles;
  _id_7AA1FF687CFC30D1 = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_createoutlinedata(self, position);
  _id_AC93BF0580BB0A75 = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  _id_6B7054210E5DF55D = level.brgametype._id_BAF6139A9CA8635D;
  _id_F835339FB0E0E6E2 = scripts\common\utility::_id_2D7FD59D039FA69B(position, level.brgametype._id_5CD43D05CD3BABAF);

  foreach(player in _id_F835339FB0E0E6E2) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, player, 1))) {
      continue;
    }
    dist = distance(self.origin, player.origin);
    frac = max(0.0, 1.0 - dist / level.brgametype._id_5CD43D05CD3BABAF);
    duration = max(level.brgametype._id_AEEADD8AC839E56F, frac * level.brgametype._id_BAF6139A9CA8635D);
    scripts\mp\equipment\snapshot_grenade::snapshot_grenade_applysnapshot(player, self, _id_7AA1FF687CFC30D1, duration * 1000, undefined, 1);
  }

  if(isPlayer(self))
    triggerportableradarping(position, self, level.brgametype._id_5CD43D05CD3BABAF, 500, "specialty_snapshot_immunity");

  thread _id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_D9840B353D985474(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  _id_093B54405FDA960C = scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB();

  if(istrue(self.isthermalenabled)) {
    self.isthermalenabled = 0;
    scripts\cp_mp\utility\player_utility::setthermalvision(0);
    self playlocalsound("weap_thermal_toggle_click");
  } else {
    self.isthermalenabled = 1;
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_093B54405FDA960C);
    scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
    self playlocalsound("weap_thermal_toggle_click");
  }
}

_id_3C1F1C622F6EB134(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  self.isthermalenabled = undefined;
  scripts\cp_mp\utility\player_utility::setthermalvision(0);
  scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
}

playerstartpowers(_id_6C9D93D4584E15F7) {
  thread playerpowerssetupkeybindings(_id_6C9D93D4584E15F7);
  thread playerpowershud(_id_6C9D93D4584E15F7);
  thread playerpowersmonitorinput(_id_6C9D93D4584E15F7);
  thread playerpowersupdateongamepadchange(_id_6C9D93D4584E15F7);
  thread _id_539DC27334184E77(_id_6C9D93D4584E15F7);
  thread playerpowerscleanup(_id_6C9D93D4584E15F7);
}

addpowerbutton(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_F6E93DDAB08E9BE9, _id_BCDD0CD7EB4BF7C8, _id_FB3A9F61FC511DB4, _id_1A5269312D3A0B00, cleanupfunc, _id_7939D347ADE41DA0, label, labelpc, cooldownsec) {
  _id_2AFD19924DAD2B4F = _func_2EF675C13CA1C4AF("dvar_AE4B42B00A98018C", _id_EF7579BE51267BDB);

  if(getdvarint(_id_2AFD19924DAD2B4F, 1) == 0) {
    return;
  }
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB] = spawnStruct();
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].binding = _id_F6E93DDAB08E9BE9;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].bindingpc = _id_BCDD0CD7EB4BF7C8;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].func = _id_FB3A9F61FC511DB4;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_1A5269312D3A0B00 = _id_1A5269312D3A0B00;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cleanupfunc = cleanupfunc;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0 = _id_7939D347ADE41DA0;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].label = label;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].labelpc = labelpc;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cooldownsec = cooldownsec;
}

_id_539DC27334184E77(_id_6C9D93D4584E15F7) {
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_8723CFF430A72C82._id_1A5269312D3A0B00))
      self thread[[_id_8723CFF430A72C82._id_1A5269312D3A0B00]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

playerpowerssetupkeybindings(_id_6C9D93D4584E15F7) {
  if(isbot(self)) {
    return;
  }
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    self notifyonplayercommand(_id_EF7579BE51267BDB, _id_8723CFF430A72C82.binding);

    if(isDefined(_id_8723CFF430A72C82.bindingpc))
      self notifyonplayercommand(_id_EF7579BE51267BDB, _id_8723CFF430A72C82.bindingpc);
  }
}

playerpowerscleanupkeybindings(_id_6C9D93D4584E15F7) {
  if(isbot(self)) {
    return;
  }
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    self notifyonplayercommandremove(_id_EF7579BE51267BDB, _id_8723CFF430A72C82.binding);

    if(isDefined(_id_8723CFF430A72C82.bindingpc))
      self notifyonplayercommandremove(_id_EF7579BE51267BDB, _id_8723CFF430A72C82.bindingpc);
  }
}

playerpowersaddhudelem(label, labelpc, currenthudy) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_94480E1669B7FF0D.x = 20;
  _id_94480E1669B7FF0D.y = currenthudy;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "left_adjustable";
  _id_94480E1669B7FF0D.vertalign = "top_adjustable";
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;

  if(isDefined(labelpc) && !scripts\engine\utility::is_player_gamepad_enabled())
    _id_94480E1669B7FF0D.label = labelpc;
  else if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;

  barelem = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  barelem.x = 13;
  barelem.y = currenthudy;
  barelem.alignx = "left";
  barelem.aligny = "top";
  barelem.horzalign = "left_adjustable";
  barelem.vertalign = "top_adjustable";
  barelem shiftbar();
  barelem.archived = 0;
  barelem.hidewheninmenu = 1;
  barelem.bar.archived = 0;
  barelem.bar.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.barelem = barelem;
  return _id_94480E1669B7FF0D;
}

shiftbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

playerpowershud(_id_6C9D93D4584E15F7) {
  _id_6E2C1BD41E3923D6 = 150;
  _id_6D8E1E3CBD28DE50 = 18;
  currenthudy = _id_6E2C1BD41E3923D6;
  self.powershud = [];

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_8723CFF430A72C82.label)) {
      self.powershud[_id_EF7579BE51267BDB] = playerpowersaddhudelem(_id_8723CFF430A72C82.label, _id_8723CFF430A72C82.labelpc, currenthudy);
      self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
      currenthudy = currenthudy + _id_6D8E1E3CBD28DE50;
    }
  }
}

playerpowerscleanuphud(_id_6C9D93D4584E15F7) {
  foreach(_id_94480E1669B7FF0D in self.powershud) {
    if(isDefined(_id_94480E1669B7FF0D)) {
      if(isDefined(_id_94480E1669B7FF0D.barelem))
        _id_94480E1669B7FF0D.barelem scripts\mp\hud_util::destroyelem();

      _id_94480E1669B7FF0D destroy();
    }
  }

  self.powershud = undefined;
}

playerpowerscleanup(_id_6C9D93D4584E15F7) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death", "assassin_unset", "assassin_set");
  thread playerpowerscleanupkeybindings(_id_6C9D93D4584E15F7);
  thread playerpowerscleanuppowers(_id_6C9D93D4584E15F7);
  thread playerpowerscleanuphud(_id_6C9D93D4584E15F7);
}

playerpowerscleanuppowers(_id_6C9D93D4584E15F7) {
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_8723CFF430A72C82.cleanupfunc))
      self thread[[_id_8723CFF430A72C82.cleanupfunc]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

playerpowersmonitorinput(_id_6C9D93D4584E15F7) {
  self endon("death_or_disconnect");
  self endon("assassin_unset");
  self endon("assassin_set");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  for(;;) {
    _id_EF7579BE51267BDB = playerpowerswaittillinputreturn(_id_6C9D93D4584E15F7);

    if(!isDefined(_id_EF7579BE51267BDB)) {
      continue;
    }
    waittillframeend;

    if(isDefined(self.powershud[_id_EF7579BE51267BDB]) && self.powershud[_id_EF7579BE51267BDB].incooldown) {
      continue;
    }
    self thread[[_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].func]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

playerpowerswaittillinputreturn(_id_6C9D93D4584E15F7) {
  ent = spawnStruct();

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers)
  childthread scripts\engine\utility::waittill_string(_id_EF7579BE51267BDB, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

playerpowersupdateongamepadchange(_id_6C9D93D4584E15F7) {
  level endon("game_ended");
  self endon("assassin_unset");
  self endon("assassin_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }
  waittillframeend;
  _id_FD0EFA5C23BE8228 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    _id_890736E866204B96 = scripts\engine\utility::is_player_gamepad_enabled();

    if(_id_890736E866204B96 != _id_FD0EFA5C23BE8228) {
      _id_FD0EFA5C23BE8228 = _id_890736E866204B96;

      if(_id_890736E866204B96) {
        foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
          if(isDefined(_id_8723CFF430A72C82.labelpc))
            self.powershud[_id_EF7579BE51267BDB].label = _id_8723CFF430A72C82.label;
        }
      } else {
        foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
          if(isDefined(_id_8723CFF430A72C82.labelpc))
            self.powershud[_id_EF7579BE51267BDB].label = _id_8723CFF430A72C82.labelpc;
        }
      }
    }

    waitframe();
  }
}

playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("assassin_unset");
  self endon("assassin_set");
  self endon("disableCooldown");

  if(!isDefined(self.powershud[_id_EF7579BE51267BDB]) || istrue(self.powershud[_id_EF7579BE51267BDB].incooldown)) {
    return;
  }
  _id_D671E5BEFA0CFAE3 = self.powershud[_id_EF7579BE51267BDB].barelem;

  if(_id_D671E5BEFA0CFAE3.bar.frac > 0) {
    self.powershud[_id_EF7579BE51267BDB].incooldown = 1;
    cooldownsec = _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cooldownsec;
    _id_B1F7CE0445D66AC9 = _func_2EF675C13CA1C4AF("dvar_10968C493AE2E9CE", _id_EF7579BE51267BDB);

    if(getdvarint(_id_B1F7CE0445D66AC9, 0) != 0)
      cooldownsec = getdvarint(_id_B1F7CE0445D66AC9, 0);

    fraction = _id_D671E5BEFA0CFAE3.bar.frac;
    cooldownsec = cooldownsec * fraction;
    _id_D671E5BEFA0CFAE3.bar.color = (1, 0.6, 0);
    _id_D671E5BEFA0CFAE3.bar scaleovertime(cooldownsec, 0, _id_D671E5BEFA0CFAE3.height);
    wait(cooldownsec);
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
  } else
    _id_D671E5BEFA0CFAE3 scripts\mp\hud_util::updatebar(0, 0);

  _id_D671E5BEFA0CFAE3.bar.color = (1, 1, 1);

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0))
    self[[_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

playerpowerrestartallcooldowns(_id_6C9D93D4584E15F7) {
  if(!isDefined(_id_6C9D93D4584E15F7)) {
    return;
  }
  self notify("disableCooldown");

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(!isDefined(self.powershud[_id_EF7579BE51267BDB])) {
      continue;
    }
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
    thread _id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

playerpowerresetpowers(_id_6C9D93D4584E15F7) {
  if(!isDefined(_id_6C9D93D4584E15F7)) {
    return;
  }
  self notify("disableCooldown");

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(!isDefined(self.powershud[_id_EF7579BE51267BDB])) {
      continue;
    }
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
    _id_D671E5BEFA0CFAE3 = self.powershud[_id_EF7579BE51267BDB].barelem;
    _id_D671E5BEFA0CFAE3.bar.frac = 0.0;
    _id_D671E5BEFA0CFAE3 scripts\mp\hud_util::updatebar(_id_D671E5BEFA0CFAE3.bar.frac, 0);
    thread playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

_id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  _id_D671E5BEFA0CFAE3 = self.powershud[_id_EF7579BE51267BDB].barelem;
  _id_D671E5BEFA0CFAE3.bar.frac = 1.0;
  _id_D671E5BEFA0CFAE3 scripts\mp\hud_util::updatebar(_id_D671E5BEFA0CFAE3.bar.frac, 0);
  thread playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_0E6CA3C2CA24B16F() {
  while(!isDefined(level.brgametype.respawndelay) || !isDefined(level.brgametype.respawndelay["_quads"]))
    waitframe();

  level.brgametype.respawndelay["_quads"][0] = getdvarint("dvar_BAB5E0340D5D8E71", 60);
  level.brgametype.respawndelay["_quads"][1] = getdvarint("dvar_BAB5DF340D5D8C3E", 60);
  level.brgametype.respawndelay["_quads"][2] = getdvarint("dvar_BAB5DE340D5D8A0B", 60);
}

mayconsiderplayerdead(player) {
  if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(player.team)) {
    result = _id_14183DF6F9AF8737::_id_411AF8132CA77D3A(player);

    if(istrue(result))
      player _id_D8899051D444B969();

    return result;
  }

  return undefined;
}

playernakeddroploadout() {
  if(istrue(self._id_538959F1AED7E1D3))
    self._id_538959F1AED7E1D3 = undefined;
  else {
    if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(self.team)) {
      _id_82E9F6D42B55B43F();
      return;
    }

    _id_1E4A61DB11011446::nakeddrophandleloadout();
  }
}

_id_C16252BB9C1CCF13(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(self.team))
    return _id_14183DF6F9AF8737::_id_F99A079543F11BF7(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);

  return undefined;
}

_id_AAD53C864BD67F16() {
  if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(self.team))
    return _id_14183DF6F9AF8737::_id_4001B05BDB048819();

  return undefined;
}

_id_635E27145C3615E8(attackers) {
  if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(self.team))
    return _id_14183DF6F9AF8737::_id_F39FA02F6ED912FC(attackers);

  return undefined;
}

kioskreviveplayer(_id_84E2123AACA9A965, _id_57D71760971F748F) {
  if(level.brgametype._id_CAE5CB0C0AABA8A9 && _id_0194C860F5134A8E(self.team))
    return _id_14183DF6F9AF8737::_id_0F9A2B6AE09E7A00(_id_84E2123AACA9A965, _id_57D71760971F748F);
  else
    thread _id_67708F418B1FAC79::playergulagautowin("burnKioskRevive", _id_84E2123AACA9A965, _id_57D71760971F748F);
}

_id_90D7D14F52E46883(player) {
  player _id_B1EE43D2CD879411();
}

_id_B629CA6173E4E47F(player) {
  return !_id_0194C860F5134A8E(player.team);
}

_id_E45F0D0EE72806B8() {
  self._id_2160249FF5DEEF30 = 0;

  if(getdvarint("dvar_FDC783E5912F90FC", 1) == 1)
    self._id_2160249FF5DEEF30 = randomint(level.brgametype._id_609F193CF1BF9AB8);

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_70CBFBA1E5479D53();
}

_id_45867568ACBB7A73() {
  if(self._id_2160249FF5DEEF30 > level.brgametype._id_6DA51D8D24D53D47)
    return "ui_mp_br_icon_burn_card_1";
  else if(self._id_2160249FF5DEEF30 > level.brgametype._id_CCA94E4718DC4C30)
    return "ui_mp_br_icon_burn_card_2";
  else
    return "ui_mp_br_icon_burn_card_3";
}

_id_93580377567B8F6C() {
  if(self._id_2160249FF5DEEF30 > level.brgametype._id_6DA51D8D24D53D47)
    return 1;
  else if(self._id_2160249FF5DEEF30 > level.brgametype._id_CCA94E4718DC4C30)
    return 2;
  else
    return 3;
}

_id_70CBFBA1E5479D53() {
  if(getdvarint("dvar_D039D0AB185F56AC", 1) == 0) {
    return;
  }
  _id_A3DB2F2F62133E73 = _id_93580377567B8F6C();

  if(_id_A3DB2F2F62133E73 > 3) {
    return;
  }
  _id_8534515023AFC188 = 2;
  _id_64571E3AECCD1A07 = 6;
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (_id_A3DB2F2F62133E73 &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = self.game_extrainfo;
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  self.game_extrainfo = _id_82A90E56E416FA55;
}

_id_8CBFD2ECFD59CEBD(_id_6AEE9C9054F09ED5, _id_B64F283113C99581) {
  _id_B64F283113C99581 = _id_B64F283113C99581 + self._id_2160249FF5DEEF30;
  return [_id_6AEE9C9054F09ED5, _id_B64F283113C99581];
}

playerdropplunderondeath(dropstruct, attacker) {
  _id_CB4FAD49263E20C4 = _id_6AFF3948CF4CCA03::_id_79275E2FAB13F54D();
  _id_6AEE9C9054F09ED5 = _id_CB4FAD49263E20C4._id_6AEE9C9054F09ED5;
  _id_B64F283113C99581 = _id_CB4FAD49263E20C4._id_B64F283113C99581 + self._id_2160249FF5DEEF30;
  _id_6AFF3948CF4CCA03::playersetplundercount(_id_6AEE9C9054F09ED5);

  if(_id_B64F283113C99581 <= 0) {
    return;
  }
  _id_6AFF3948CF4CCA03::dropcondensedplunder(_id_B64F283113C99581, dropstruct, 1);
  return 1;
}

givequestreward(type, value, team, rewardorigin, rewardangles, rewardscriptable, players) {
  if(type == "plunder") {
    _id_E07CC288C1153C7F = level.brgametype._id_5FAF0949BF002392;

    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
        continue;
      }
      if(!isalive(player)) {
        continue;
      }
      player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_E07CC288C1153C7F);
      level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_E07CC288C1153C7F;
      _id_715028F54BAD19A1::trackcashevent(player, "mission", _id_E07CC288C1153C7F);
    }

    return [1, _id_E07CC288C1153C7F];
  }

  return [0, 0];
}

_id_CDB766CD324E01F1(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player _id_C4F39ED21487C817();
}

_id_C4F39ED21487C817() {
  if(!isDefined(self._id_CD064165DD4505E8))
    self._id_CD064165DD4505E8 = 0;

  self._id_CD064165DD4505E8++;
  _id_9ABC53DC212DA3C5();

  switch (self._id_CD064165DD4505E8) {
    case 1:
      _id_7F9954AB9F5E4BEA();
      break;
    case 2:
      _id_7F9953AB9F5E49B7();
      break;
    case 3:
      _id_7F9952AB9F5E4784();
      break;
    default:
      break;
  }
}

_id_C0569ABDC98DAE19() {
  if(!isDefined(self._id_CD064165DD4505E8))
    self._id_CD064165DD4505E8 = 0;

  return self._id_CD064165DD4505E8;
}

_id_437D6788359394A5(_id_4E5A0B81AEFB772F) {
  if(!isDefined(self._id_CD064165DD4505E8))
    self._id_CD064165DD4505E8 = 0;

  if(self._id_CD064165DD4505E8 > 0)
    self._id_CD064165DD4505E8 = self._id_CD064165DD4505E8 - _id_4E5A0B81AEFB772F;
}

_id_7F9954AB9F5E4BEA() {
  if(!isDefined(self._id_E32C201583D2268E)) {
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(self, "brloot_killstreak_precision_airstrike", 0);
    self._id_E32C201583D2268E = 1;
  }
}

_id_7F9953AB9F5E49B7() {
  if(!isDefined(self._id_E32C1F1583D2245B)) {
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(self, "brloot_killstreak_uav", 0);
    self._id_E32C1F1583D2245B = 1;
  }
}

_id_7F9952AB9F5E4784() {
  if(!isDefined(self._id_E32C1E1583D22228))
    self._id_E32C1E1583D22228 = 1;
}

_id_FC9492A29BA1AB55() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype._id_1E55730C664289AB = _id_62600EC3D8593CD6("ui_mp_br_icon_burn_assassin", 20, 20, 0, -180, "right", "middle", "center", "middle");
  level.brgametype._id_07CACCC360A3D4CD = _id_BDFB5252E3A45CE2(0, -180, "left", "middle", "center", "middle", (1, 0, 0), &"BR_BURN/NUM_ASSASSINS", 0);
  level.brgametype._id_015EBF08909F87AE = 0;
}

_id_47B27A1B0BA7BBE8() {
  level.brgametype._id_015EBF08909F87AE++;
  level.brgametype._id_07CACCC360A3D4CD setvalue(level.brgametype._id_015EBF08909F87AE);
}

_id_F1E75963FA57EF16() {
  level.brgametype._id_015EBF08909F87AE--;
  level.brgametype._id_07CACCC360A3D4CD setvalue(level.brgametype._id_015EBF08909F87AE);
}

_id_0EB34F4E3E2AAEAC(xoffset, yoffset, alignx, aligny, horzalign, vertalign, color, label, value) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_94480E1669B7FF0D.x = xoffset;
  _id_94480E1669B7FF0D.y = yoffset;
  _id_94480E1669B7FF0D.alignx = alignx;
  _id_94480E1669B7FF0D.aligny = aligny;
  _id_94480E1669B7FF0D.horzalign = horzalign;
  _id_94480E1669B7FF0D.vertalign = vertalign;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;

  if(isDefined(color))
    _id_94480E1669B7FF0D.color = color;

  if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;

  if(isDefined(value))
    _id_94480E1669B7FF0D setvalue(value);

  return _id_94480E1669B7FF0D;
}

_id_BCDAB66C11B1177C(shader, width, height, xoffset, yoffset, alignx, aligny, horzalign, vertalign) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createicon(shader, width, height);
  _id_94480E1669B7FF0D.x = xoffset;
  _id_94480E1669B7FF0D.y = yoffset;
  _id_94480E1669B7FF0D.alignx = alignx;
  _id_94480E1669B7FF0D.aligny = aligny;
  _id_94480E1669B7FF0D.horzalign = horzalign;
  _id_94480E1669B7FF0D.vertalign = vertalign;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;
  return _id_94480E1669B7FF0D;
}

_id_D528348949C55989(_id_80B642A0F8C9659D, xoffset, yoffset, alignx, aligny, horzalign, vertalign) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createtimer("default", 1.5);
  _id_94480E1669B7FF0D.x = xoffset;
  _id_94480E1669B7FF0D.y = yoffset;
  _id_94480E1669B7FF0D.alignx = alignx;
  _id_94480E1669B7FF0D.aligny = aligny;
  _id_94480E1669B7FF0D.horzalign = horzalign;
  _id_94480E1669B7FF0D.vertalign = vertalign;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;
  _id_94480E1669B7FF0D settenthstimer(_id_80B642A0F8C9659D);
  return _id_94480E1669B7FF0D;
}

_id_7EE25BD6F7F9F8AD(color, width, height, xoffset, yoffset, point, relativepoint) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createbar(color, width, height);
  _id_94480E1669B7FF0D.color = (1, 1, 1);
  _id_94480E1669B7FF0D scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;
  return _id_94480E1669B7FF0D;
}

_id_956D392FE3226BD8(shader) {
  _id_94480E1669B7FF0D = newclienthudelem(self);
  _id_94480E1669B7FF0D.x = 0;
  _id_94480E1669B7FF0D.y = 0;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "fullscreen";
  _id_94480E1669B7FF0D.vertalign = "fullscreen";
  _id_94480E1669B7FF0D setshader(shader, 640, 480);
  _id_94480E1669B7FF0D.sort = -10;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.archived = 1;
  return _id_94480E1669B7FF0D;
}

_id_BDFB5252E3A45CE2(xoffset, yoffset, alignx, aligny, horzalign, vertalign, color, label, value) {
  _id_94480E1669B7FF0D = newhudelem();
  _id_94480E1669B7FF0D.elemtype = "font";
  _id_94480E1669B7FF0D.font = "default";
  _id_94480E1669B7FF0D.fontscale = 1.5;
  _id_94480E1669B7FF0D.basefontscale = 1.5;
  _id_94480E1669B7FF0D.x = 0;
  _id_94480E1669B7FF0D.y = 0;
  _id_94480E1669B7FF0D.width = 0;
  _id_94480E1669B7FF0D.height = int(level.fontheight * 1.5);
  _id_94480E1669B7FF0D.xoffset = 0;
  _id_94480E1669B7FF0D.yoffset = 0;
  _id_94480E1669B7FF0D.children = [];
  _id_94480E1669B7FF0D scripts\mp\hud_util::setparent(level.uiparent);
  _id_94480E1669B7FF0D.hidden = 0;
  _id_94480E1669B7FF0D.x = xoffset;
  _id_94480E1669B7FF0D.y = yoffset;
  _id_94480E1669B7FF0D.alignx = alignx;
  _id_94480E1669B7FF0D.aligny = aligny;
  _id_94480E1669B7FF0D.horzalign = horzalign;
  _id_94480E1669B7FF0D.vertalign = vertalign;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;

  if(isDefined(color))
    _id_94480E1669B7FF0D.color = color;

  if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;

  if(isDefined(value))
    _id_94480E1669B7FF0D setvalue(value);

  return _id_94480E1669B7FF0D;
}

_id_62600EC3D8593CD6(shader, width, height, xoffset, yoffset, alignx, aligny, horzalign, vertalign) {
  _id_5B6A2597D526BD27 = newhudelem();
  _id_5B6A2597D526BD27.elemtype = "icon";
  _id_5B6A2597D526BD27.children = [];
  _id_5B6A2597D526BD27 scripts\mp\hud_util::setparent(level.uiparent);
  _id_5B6A2597D526BD27.x = xoffset;
  _id_5B6A2597D526BD27.y = yoffset;
  _id_5B6A2597D526BD27.alignx = alignx;
  _id_5B6A2597D526BD27.aligny = aligny;
  _id_5B6A2597D526BD27.horzalign = horzalign;
  _id_5B6A2597D526BD27.vertalign = vertalign;
  _id_5B6A2597D526BD27.width = width;
  _id_5B6A2597D526BD27.height = height;
  _id_5B6A2597D526BD27.basewidth = _id_5B6A2597D526BD27.width;
  _id_5B6A2597D526BD27.baseheight = _id_5B6A2597D526BD27.height;
  _id_5B6A2597D526BD27.xoffset = 0;
  _id_5B6A2597D526BD27.yoffset = 0;
  _id_5B6A2597D526BD27.hidden = 0;
  _id_5B6A2597D526BD27.archived = 0;

  if(isDefined(shader)) {
    _id_5B6A2597D526BD27 setshader(shader, width, height);
    _id_5B6A2597D526BD27.shader = shader;
  }

  return _id_5B6A2597D526BD27;
}

_id_FA3B1DE81AC5BFA7(_id_A1C90D2E290C03FD) {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }
  _id_CC2C2F3EAC3C7BD2 = 0.5;
  _id_5F2809F4E8852C13 = 4;
  self.pulsing = 1;
  _id_B96028986997E29C = self.fontscale;
  _id_672265C8E01995A1 = self.color;

  if(isDefined(_id_A1C90D2E290C03FD))
    self.color = _id_A1C90D2E290C03FD;

  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_5F2809F4E8852C13;
  wait(_id_CC2C2F3EAC3C7BD2);
  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_B96028986997E29C;
  wait(_id_CC2C2F3EAC3C7BD2);
  self.color = _id_672265C8E01995A1;
  self.pulsing = undefined;
}

_id_6C26362E946BBB8F() {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }
  _id_CC2C2F3EAC3C7BD2 = 0.5;
  _id_5F2809F4E8852C13 = 4;
  self.pulsing = 1;
  self scaleovertime(_id_CC2C2F3EAC3C7BD2, self.width * _id_5F2809F4E8852C13, self.height * _id_5F2809F4E8852C13);
  wait(_id_CC2C2F3EAC3C7BD2);
  self scaleovertime(_id_CC2C2F3EAC3C7BD2, self.width, self.height);
  wait(_id_CC2C2F3EAC3C7BD2);
  self.pulsing = undefined;
}

_id_C510D53F15EE265D() {
  self._id_2C079B7009B70D43 = _id_0EB34F4E3E2AAEAC(0, 140, "center", "middle", "center", "middle", (1, 0, 0), &"BR_BURN/BURN_LABEL");
  self._id_2C079B7009B70D43 thread _id_FA3B1DE81AC5BFA7();
}

_id_A31123CA9E6292C4() {
  if(isDefined(self._id_2C079B7009B70D43))
    self._id_2C079B7009B70D43 destroy();
}

_id_FD8F31C3C6BC8F26() {
  self._id_E8452BB993152518 = _id_0EB34F4E3E2AAEAC(0, 200, "center", "middle", "center", "middle", (1, 1, 0), &"BR_BURN/PMC_CONTRACT");
  self._id_E8452BB993152518 thread _id_FA3B1DE81AC5BFA7();
}

_id_07785735C89BD803() {
  if(isDefined(self._id_E8452BB993152518))
    self._id_E8452BB993152518 destroy();
}

_id_C6A1804379378045() {
  self._id_4BBCE75B6F28E8B7 = _id_0EB34F4E3E2AAEAC(0, 140, "center", "middle", "center", "middle", (1, 0, 0), &"BR_BURN/ASSASSIN_LABEL");
  self._id_4BBCE75B6F28E8B7 thread _id_FA3B1DE81AC5BFA7();
}

_id_CFC27D37C16563C4() {
  if(isDefined(self._id_4BBCE75B6F28E8B7))
    self._id_4BBCE75B6F28E8B7 destroy();
}

_id_756141322510D54A() {
  _id_4C45B3AD92E6AEFB = _id_45867568ACBB7A73();
  self._id_06B9DF8285D16300 = _id_BCDAB66C11B1177C(_id_4C45B3AD92E6AEFB, 15, 20, -60, 190, "center", "middle", "center", "middle");
}

_id_93C5F6CD67AF87E2() {
  _id_4C45B3AD92E6AEFB = _id_45867568ACBB7A73();
  self._id_06B9DF8285D16300 setshader(_id_4C45B3AD92E6AEFB, 15, 20);
}

_id_6927F3AA48579C3F() {
  if(isDefined(self._id_06B9DF8285D16300))
    self._id_06B9DF8285D16300 destroy();
}

_id_D8899051D444B969() {
  if(isDefined(self.respawndelay) && self.respawndelay > 0)
    self._id_F0599A3D6BD9AB33 = _id_D528348949C55989(self.respawndelay, 0, 0, "center", "middle", "center", "middle");
}

_id_159FCF83EDB29254() {
  if(isDefined(self._id_F0599A3D6BD9AB33))
    self._id_F0599A3D6BD9AB33 destroy();
}

_id_B1EE43D2CD879411() {
  if(isDefined(self._id_F0599A3D6BD9AB33) && self.respawndelay > 0)
    self._id_F0599A3D6BD9AB33 settenthstimer(self.respawndelay);
}

_id_6E348FD6ADD2966D() {
  _id_CD064165DD4505E8 = _id_C0569ABDC98DAE19();
  self._id_672CAC19C1E0662C = _id_BCDAB66C11B1177C("ui_mp_br_icon_burn_crypto", 20, 20, 0, 190, "right", "middle", "center", "middle");
  self._id_F2D78D5183AAB412 = _id_0EB34F4E3E2AAEAC(5, 190, "left", "middle", "center", "middle", (0, 1, 0), &"BR_BURN/NUM_ASSASSINS", _id_CD064165DD4505E8);
}

_id_9ABC53DC212DA3C5() {
  _id_CD064165DD4505E8 = _id_C0569ABDC98DAE19();

  if(isDefined(self._id_F2D78D5183AAB412)) {
    self._id_F2D78D5183AAB412 setvalue(_id_CD064165DD4505E8);
    self._id_F2D78D5183AAB412 thread _id_FA3B1DE81AC5BFA7();
  }

  if(isDefined(self._id_672CAC19C1E0662C))
    self._id_672CAC19C1E0662C thread _id_6C26362E946BBB8F();
}

_id_4EF10BA38B16FFB4() {
  if(isDefined(self._id_672CAC19C1E0662C))
    self._id_672CAC19C1E0662C destroy();

  if(isDefined(self._id_F2D78D5183AAB412))
    self._id_F2D78D5183AAB412 destroy();
}

_id_E8D143F10B79AE82() {
  self._id_CADB26946A9A97E0 = _id_BCDAB66C11B1177C("ui_mp_br_icon_burn_increased_health", 20, 20, 60, 190, "right", "middle", "center", "middle");
}

_id_B2502A42DB5D61D0() {
  self._id_3AE7E713D5A3A2AA = _id_7EE25BD6F7F9F8AD((0.4, 0.2, 0.7), 20, 8, 65, 225, "CENTER", "LEFT");
}

_id_1BBCCB89D2717603() {
  self._id_1848EA31BC5D32FD = _id_956D392FE3226BD8("overlay_burn_assassin");
}

_id_B8E8000ADD2D62EC() {
  if(isDefined(self._id_1848EA31BC5D32FD))
    self._id_1848EA31BC5D32FD destroy();
}

circletimernext(circleindex) {
  if(circleindex == 0)
    thread _id_65984970C8FD9780::_id_3C238BA7323E4681();

  thread _id_65984970C8FD9780::circletimer(circleindex);
}

ongrenadeused(weaponname, grenade) {
  if(weaponname == "armory_drop_marker_mp")
    thread _id_65984970C8FD9780::_id_6BA5BA23432E39C5(grenade);
}

_id_C8BA91C46F16AB44(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player _id_1C1A01BC7CCDED4C();
}

_id_1C1A01BC7CCDED4C() {
  _id_7E52B56769FA7774::forcegivesuper("super_armory", 1, 0, 0, 0);
}

playercanseedangercircleworld() {
  if(istrue(self._id_D13F0C77C8CA3733))
    return 0;
}

_id_A7AC54D225AD192C(items, instance) {
  if(instance.type == "br_loot_cache_lege" || randomint(100) < getdvarint("dvar_A6D179847C9C63AE", 20))
    items = scripts\engine\utility::array_add(items, "brloot_offhand_armory");

  return items;
}

_id_CF547D762189DEAA() {
  if(!isPlayer(self)) {
    return;
  }
  if(!istrue(self._id_4D90DDC000519B22)) {
    _id_07C40FA80892A721::_id_CF547D762189DEAA();
    return;
  }

  _id_16A1E0FD0154C3DA = int(max(0, self.armorhealth - 150));
  _id_42086FD1EB195952 = _id_16A1E0FD0154C3DA / 50.0;
  self._id_3AE7E713D5A3A2AA scripts\mp\hud_util::updatebar(_id_42086FD1EB195952);
  armorhealth = int(min(150, self.armorhealth));
  _id_CE50C3E3E9D89E29 = armorhealth / 150;
  self setclientomnvar("ui_armor_percent", _id_CE50C3E3E9D89E29);
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(!isDefined(squadmemberindex) || !isDefined(self.team) || squadmemberindex == -1) {
    return;
  }
  _id_1B593D5E688A409C();
}

_id_1B593D5E688A409C() {
  _id_607DA387F3617ED1 = level.teamdata[self.team]["players"];

  if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self._id_0FF97225579DE16A]))
    _id_607DA387F3617ED1 = level.squaddata[self.team][self._id_0FF97225579DE16A].players;

  if(!isDefined(_id_607DA387F3617ED1))
    _id_607DA387F3617ED1 = level.players;

  armorhealth = int(min(150, self.armorhealth));
  _id_388CDEBC14DD4AA4 = self._id_8790C077C95DB752 - 50;
  _id_5524B1700566D195 = 0;
  _id_8ED19FD39D6993CF = 150;
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(squadmemberindex == -1) {
    return;
  }
  _id_388CDEBC14DD4AA4 = 150;
  _id_5524B1700566D195 = 256;
  _id_8ED19FD39D6993CF = 1023;
  _id_0E9CFD120B0B43EF = int(min(3, self._id_BED158A6DFAC230D));
  _id_CABC886D846DD979 = int(armorhealth * 150 / _id_388CDEBC14DD4AA4);
  _id_CABC886D846DD979 = _id_CABC886D846DD979 + (_id_0E9CFD120B0B43EF << 8);
  _id_CABC886D846DD979 = int(clamp(_id_CABC886D846DD979, _id_5524B1700566D195, _id_8ED19FD39D6993CF));

  foreach(player in _id_607DA387F3617ED1) {
    if(isDefined(player))
      player setclientomnvar("ui_armor_squad_index_" + squadmemberindex, _id_CABC886D846DD979);
  }
}

postupdategameevents() {
  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }
  _id_BCB771FB860C96A0 = undefined;

  foreach(team in level.teamnamelist) {
    _id_652F47620AC4713F = level.teamdata[team]["teamCount"];

    if(_id_652F47620AC4713F > 0) {
      if(!_id_0194C860F5134A8E(team)) {
        if(isDefined(_id_BCB771FB860C96A0)) {
          return;
        }
        _id_BCB771FB860C96A0 = team;
      }
    }
  }

  _id_5060A0D098E58D5A = scripts\mp\utility\script::quicksort(getarraykeys(level.brgametype._id_5E7DDA59E17545F6), ::_id_D59C5D855E587A1C);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5060A0D098E58D5A.size; _id_AC0E594AC96AA3A8++) {
    team = _id_5060A0D098E58D5A[_id_AC0E594AC96AA3A8];
    teamplacement = _id_AC0E594AC96AA3A8 + 2;
    thread _id_1E4A61DB11011446::onsquadeliminatedplacement(team, teamplacement, 0, 1);
  }

  thread scripts\mp\gamelogic::endgame(_id_BCB771FB860C96A0, game["end_reason"]["enemies_eliminated"]);
}

_id_D59C5D855E587A1C(left, right) {
  _id_10374502ED47925D = level.teamdata[left]["lastAssassinTime"];
  _id_1B1911B9658C8A60 = level.teamdata[right]["lastAssassinTime"];
  return _id_10374502ED47925D >= _id_1B1911B9658C8A60;
}

_id_761B14B93E89DE88(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  foreach(item in _id_4F6FF04F222AFBD8)
  _id_4F6FF34F222B0271[_id_4F6FF34F222B0271.size] = item;

  return _id_4F6FF34F222B0271;
}

_id_855518ABC203666B(_id_4F6FF34F222B0271, _id_8F445B88C8C227A3) {
  _id_4F6FF04F222AFBD8 = [];

  foreach(_id_F7806D4CF24AACD3 in _id_4F6FF34F222B0271) {
    if(!isDefined(_id_F7806D4CF24AACD3)) {
      continue;
    }
    found = 0;

    foreach(_id_F7E215BD10CC45E9 in _id_8F445B88C8C227A3) {
      if(!isDefined(_id_F7E215BD10CC45E9)) {
        continue;
      }
      if(_id_F7806D4CF24AACD3 == _id_F7E215BD10CC45E9) {
        found = 1;
        break;
      }
    }

    if(!found)
      _id_4F6FF04F222AFBD8[_id_4F6FF04F222AFBD8.size] = _id_F7806D4CF24AACD3;
  }

  return _id_4F6FF04F222AFBD8;
}