/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_72af5a878a9d3397.gsc
***********************************************/

initialize() {
  _id_4D445CD9F16875C6 = getdvarint("dvar_98397926FF200D49", 0);
  logstring("Initialize BBA: enabled = " + _id_4D445CD9F16875C6);

  if(!_id_4D445CD9F16875C6) {
    return;
  }
  level._id_8A9762E276DE8903 = spawnStruct();
  level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953 = 0;
  level._id_8A9762E276DE8903._id_6D3A3F51D84A3787 = getdvarint("dvar_CDD059B09C8BB733", 5);
  level._id_8A9762E276DE8903._id_D3EEC3EAC4C4BA7C = getdvarint("dvar_09EE63CCCA325C7F", 10);
  level._id_8A9762E276DE8903.players = [];
  level._id_8A9762E276DE8903._id_BB15506FA5411BFB = getdvarint("dvar_E594ACB63958E3D9", 1);
  level._id_8A9762E276DE8903._id_605F3BD872DDDFA6 = 0;
  level._id_FA280DF6CFD09D0B = ::_id_0627DD71448D7427;
  _id_7271C4BE51DBF723 = "Header log_version=13";
  _func_8294C13E5683B0A3(_id_7271C4BE51DBF723);
}

_id_0627DD71448D7427() {
  _id_03283FDAC29887DE();
}

_id_03283FDAC29887DE() {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  if(isDefined(self._id_FF1A8C6F49882FE8)) {
    return;
  }
  _id_676624C5FE59606D = -1;

  if(isDefined(self._id_5876CD9FC14AF731) && isDefined(self._id_5876CD9FC14AF731._id_FF1A8C6F49882FE8))
    _id_676624C5FE59606D = self._id_5876CD9FC14AF731._id_FF1A8C6F49882FE8;
  else {
    level._id_8A9762E276DE8903._id_605F3BD872DDDFA6 = level._id_8A9762E276DE8903._id_605F3BD872DDDFA6 + 1;
    _id_676624C5FE59606D = level._id_8A9762E276DE8903._id_605F3BD872DDDFA6;
  }

  self._id_FF1A8C6F49882FE8 = _id_676624C5FE59606D;
}

_id_E60552DD6ABCC4AA() {
  return isDefined(level._id_8A9762E276DE8903);
}

_id_27A7D2350B94908B() {
  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    return 0;

  return level._id_8A9762E276DE8903._id_BB15506FA5411BFB;
}

start() {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_D83AFB9C3F95AA1C();
  thread _id_F4946464D2C19DA2();
  thread _id_4F07546D6992CB73();
  thread _id_CC9C6D5832692006();
  thread _id_01578998A5633D1F();

  if(level.gametype == "br" && !istrue(level.br_circle_disabled))
    thread _id_B9790B63A2EAE9CC();

  if(_id_26CCBFE3954CACF4::_id_E60552DD6ABCC4AA() && _id_27A7D2350B94908B())
    thread _id_CC43CA415DF582DD();

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && getmaxagents() > 0)
    thread _id_C77B4D855737D7AF();

  if(istrue(level._id_034714CE799B6017))
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPublicEvent", ::_id_8698937994D185D0);

  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerTeleport", ::_id_6B1CA7FAEB9FD14A);
}

_id_0F5CFF6DA44A3790(player, eliminated) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_45668C725DC52275 = [];
  _id_41B371CA46E67BFE = _id_D48694033481CF25(player);

  if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "eliminated", eliminated)) {
    _id_45668C725DC52275["id"] = _id_D1F5FF62271C92FE(player);
    _id_45668C725DC52275["eliminated"] = eliminated;
    _id_4603AA41477CA54D("UpdatePlayer", _id_45668C725DC52275);
  }
}

_id_8698937994D185D0(eventtype, _id_D24790A0C26139FD) {
  _id_45668C725DC52275 = [];
  eventname = undefined;

  if(isstring(eventtype))
    eventname = eventtype;
  else {
    eventname = _id_337BD370F7C5E6F9::_id_B73E6FCFACC71AFD(eventtype);
    _id_0032C77BCDFF8BC3 = "CONST_BR_PE_TYPE_";

    if(scripts\engine\utility::string_starts_with(eventname, _id_0032C77BCDFF8BC3))
      eventname = getsubstr(eventname, _id_0032C77BCDFF8BC3.size, eventname.size);
  }

  _id_45668C725DC52275["name"] = _id_905E60070F3E3CBF(eventname);
  _id_45668C725DC52275["status"] = _id_905E60070F3E3CBF(_id_D24790A0C26139FD);
  _id_4603AA41477CA54D("PublicEvent", _id_45668C725DC52275);
}

_id_01578998A5633D1F() {
  level endon("game_ended");

  for(;;) {
    level waittill("post_player_damaged", inflictor, attacker, victim, damage, flags, meansofdeath, objweapon, _id_FCDF19E3CDD29669, point, dir, hitloc, offsettime, modelindex, part);
    _id_433AF73A108EEC49(victim, attacker, meansofdeath, damage, hitloc);
  }
}

_id_F6C977AD89F51B9C(mapname, mapcorners, _id_3C590B0EE220AFA3, _id_C978CB0E8E5AB65D) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_3C590B0EE220AFA3 = scripts\engine\utility::_id_53C4C53197386572(_id_3C590B0EE220AFA3, 0);
  _id_C978CB0E8E5AB65D = scripts\engine\utility::_id_53C4C53197386572(_id_C978CB0E8E5AB65D, 0);
  _id_6C2FE87A3F4D8BC7 = mapcorners[0].origin;
  _id_1996B8BC8D47D84F = mapcorners[1].origin;
  _id_DFC0BF2EB51E62C9 = (_id_6C2FE87A3F4D8BC7[0], _id_6C2FE87A3F4D8BC7[1], _id_3C590B0EE220AFA3);
  _id_DF9DB12EB4F7FC47 = (_id_1996B8BC8D47D84F[0], _id_1996B8BC8D47D84F[1], _id_C978CB0E8E5AB65D);
  northyaw = getnorthyaw();
  x = cos(northyaw);
  y = sin(northyaw);
  _id_80E6C77F14F3B358 = 0.000000119209;

  if(abs(x) <= _id_80E6C77F14F3B358)
    x = 0;

  if(abs(y) <= _id_80E6C77F14F3B358)
    y = 0;

  _id_D1E567A2651B793F = _id_CD70B8FA232889F5(x, y);
  mapname = _id_905E60070F3E3CBF(mapname);
  _id_2A02755326C9546A("LoadMap", ["name", mapname, "min", _id_DFC0BF2EB51E62C9, "max", _id_DF9DB12EB4F7FC47, "north", _id_D1E567A2651B793F]);
}

_id_D83AFB9C3F95AA1C() {
  if(isDefined(level.gulag) && isDefined(level.gulag.arenas))
    _id_6E00E8FB18CD6169 = level.gulag.arenas.size;
  else
    _id_6E00E8FB18CD6169 = 0;

  _id_CA14E613E9BBB09A = _id_905E60070F3E3CBF(scripts\mp\utility\game::getsubgametype());
  _id_F7E96D6052425187 = _id_905E60070F3E3CBF(_func_94C7AE7049488358());
  _id_2A02755326C9546A("GameStart", ["gameType", _id_CA14E613E9BBB09A, "gulagNum", _id_6E00E8FB18CD6169, "matchId", _id_F7E96D6052425187]);
}

_id_F4946464D2C19DA2() {
  _id_DD5BFFA6FD9D6915 = ["start_prematch", "prematch_over", "game_ended", "gulag_closed", "respawn_disabled"];

  for(;;) {
    msg = scripts\engine\utility::waittill_any_in_array_return(_id_DD5BFFA6FD9D6915);

    if(msg == "start_prematch") {
      _id_2A02755326C9546A("PrematchStart");
      continue;
    }

    if(msg == "prematch_over") {
      _id_2A02755326C9546A("PrematchEnd");
      continue;
    }

    if(msg == "game_ended") {
      _id_2A02755326C9546A("GameEnd");
      return;
    } else {
      if(msg == "gulag_closed") {
        _id_2A02755326C9546A("GulagClose");
        continue;
      }

      if(msg == "respawn_disabled")
        _id_2A02755326C9546A("RespawnDisabled");
    }
  }
}

_id_CC9C6D5832692006() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);
    _id_45668C725DC52275 = [];
    _id_41B371CA46E67BFE = _id_D48694033481CF25(player);

    if(isbot(player)) {
      if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "name", player.name))
        _id_45668C725DC52275["name"] = _id_905E60070F3E3CBF(player.name);
    } else {
      _id_593C8D0670688506 = player _meth_7A32B0201993D7F7();

      if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "unoId", _id_593C8D0670688506))
        _id_45668C725DC52275["unoId"] = _id_905E60070F3E3CBF(_id_593C8D0670688506);
    }

    if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "team", player.team))
      _id_45668C725DC52275["team"] = _id_905E60070F3E3CBF(player.team);

    if(isbot(player)) {
      difficulty = player botgetdifficulty();

      if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "difficulty", difficulty))
        _id_45668C725DC52275["difficulty"] = _id_905E60070F3E3CBF(difficulty);
    }

    if(isDefined(player.origin))
      _id_45668C725DC52275["spawnPos"] = player.origin;

    if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      _id_45668C725DC52275["gulagId"] = player.arena.gulagindex;
      _id_3226093417BD3363(_id_41B371CA46E67BFE, "gulagId", player.arena.gulagindex);
    } else
      _id_3226093417BD3363(_id_41B371CA46E67BFE, "gulagId", -1);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_7F788F4B6412959C = player _id_2CEDCC356F1B9FC8::_id_F5446040A93792C3();

      if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "ghost", _id_7F788F4B6412959C))
        _id_45668C725DC52275["ghost"] = _id_7F788F4B6412959C;
    }

    if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "health", player.health))
      _id_45668C725DC52275["health"] = player.health;

    _id_45668C725DC52275["direction"] = _id_9F601132EE8804E7(player);

    if(_id_45668C725DC52275.size > 0) {
      _id_45668C725DC52275["id"] = _id_D1F5FF62271C92FE(player);
      _id_4603AA41477CA54D("UpdatePlayer", _id_45668C725DC52275);
    }

    if(isbot(player)) {
      player thread _id_6D7E0CDC4F3E194A();
      player thread _id_DB80608D78C406B1();
    }
  }
}

_id_D48694033481CF25(player) {
  _id_676624C5FE59606D = _id_C1FB465742657A02(player);

  if(!isDefined(_id_676624C5FE59606D))
    _id_676624C5FE59606D = "bad_" + player getentitynumber();

  return _id_C6C4818485D70FFE(_id_676624C5FE59606D);
}

_id_C6C4818485D70FFE(_id_676624C5FE59606D) {
  _id_41B371CA46E67BFE = level._id_8A9762E276DE8903.players[_id_676624C5FE59606D];

  if(!isDefined(_id_41B371CA46E67BFE)) {
    _id_41B371CA46E67BFE = spawnStruct();
    _id_41B371CA46E67BFE.id = _id_676624C5FE59606D;
    _id_41B371CA46E67BFE._id_104F87CC51A1138D = [];
    level._id_8A9762E276DE8903.players[_id_676624C5FE59606D] = _id_41B371CA46E67BFE;
  }

  return _id_41B371CA46E67BFE;
}

_id_3226093417BD3363(_id_41B371CA46E67BFE, key, value) {
  if(isDefined(_id_41B371CA46E67BFE._id_104F87CC51A1138D[key]) && _id_41B371CA46E67BFE._id_104F87CC51A1138D[key] == value)
    return 0;

  _id_41B371CA46E67BFE._id_104F87CC51A1138D[key] = value;
  return 1;
}

_id_6D7E0CDC4F3E194A() {
  self endon("death");

  for(;;) {
    self waittill("bot_difficulty_updated");
    _id_676624C5FE59606D = _id_C1FB465742657A02(self);

    if(!isDefined(_id_676624C5FE59606D) || !_id_371E37CB66601D58(self) || !isDefined(level._id_8A9762E276DE8903.players[_id_676624C5FE59606D])) {
      continue;
    }
    str = "";
    difficulty = self botgetdifficulty();
    _id_41B371CA46E67BFE = _id_D48694033481CF25(self);

    if(_id_3226093417BD3363(_id_41B371CA46E67BFE, "difficulty", difficulty))
      str = str + (";difficulty=" + _id_905E60070F3E3CBF(difficulty));

    if(str.size > 0) {
      _id_81A6DCF8641471F7 = _id_D1F5FF62271C92FE(self);
      str = "id=" + _id_81A6DCF8641471F7 + str;
      _id_35CB42962526710E("UpdatePlayer", [str]);
    }
  }
}

_id_DB80608D78C406B1() {
  self endon("death_or_disconnect");
  _id_DD5BFFA6FD9D6915 = ["bot_action_start", "bot_action_end"];

  for(;;) {
    scripts\engine\utility::waittill_any_in_array_return(_id_DD5BFFA6FD9D6915);
    _id_D707F8DE7D23362D();
  }
}

_id_B1C37E649A5CD380(to, from) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  if(!isDefined(from)) {
    from = "active";

    if(_id_26CCBFE3954CACF4::_id_D012729EAC1E7053())
      from = "dormant";
    else if(_id_26CCBFE3954CACF4::_id_6ECC7CD453466014())
      from = "uibot";
  }

  if(from == to) {
    return;
  }
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["id"] = _id_D1F5FF62271C92FE(self);
  _id_45668C725DC52275["from"] = _id_905E60070F3E3CBF(from);
  _id_45668C725DC52275["to"] = _id_905E60070F3E3CBF(to);

  if(to == "active" && from == "uibot")
    _id_45668C725DC52275["pos"] = self.origin;

  _id_41B371CA46E67BFE = _id_D48694033481CF25(self);
  _id_3226093417BD3363(_id_41B371CA46E67BFE, "botStatus", to);
  _id_4603AA41477CA54D("UpdateBotStatus", _id_45668C725DC52275);
}

_id_1968D5899AA0A0CB(_id_89A675C5BDE8848F, to, from) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_676624C5FE59606D = _id_89A675C5BDE8848F._id_FF1A8C6F49882FE8;
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["id"] = _id_592C6F38A6569FEC(_id_676624C5FE59606D, 1);
  _id_45668C725DC52275["from"] = _id_905E60070F3E3CBF(from);
  _id_45668C725DC52275["to"] = _id_905E60070F3E3CBF(to);
  _id_41B371CA46E67BFE = _id_C6C4818485D70FFE(_id_676624C5FE59606D);
  _id_3226093417BD3363(_id_41B371CA46E67BFE, "botStatus", to);
  _id_4603AA41477CA54D("UpdateBotStatus", _id_45668C725DC52275);
}

_id_D707F8DE7D23362D() {
  _id_C38FCEA73953365E = self._id_3C59090EE220AB3D._id_C38FCEA73953365E;
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["id"] = _id_D1F5FF62271C92FE(self);
  _id_21B72418E16677FB = _id_0D74AE0B4AA21186::_id_E60ECE723E993125(self._id_3C59090EE220AB3D._id_F0A8822DCC782C9D._id_577F45571C039A54);
  _id_B2056D26CC9EAA76 = min(_id_21B72418E16677FB.size, 3);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B2056D26CC9EAA76; _id_AC0E594AC96AA3A8++) {
    _id_A0185A724941F02F = _id_21B72418E16677FB[_id_AC0E594AC96AA3A8];
    key = "decision" + _id_AC0E594AC96AA3A8;
    description = "";

    if(isDefined(_id_A0185A724941F02F._id_DF9D35D9B4BEE654) && isDefined(_id_A0185A724941F02F._id_DF9D35D9B4BEE654.description) && _id_A0185A724941F02F._id_DF9D35D9B4BEE654.description.size > 0)
      description = _id_A0185A724941F02F._id_DF9D35D9B4BEE654.description;
    else
      description = _id_A0185A724941F02F.name;

    str = _id_905E60070F3E3CBF(_id_A0185A724941F02F.score + "/" + description);
    _id_45668C725DC52275[key] = str;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C38FCEA73953365E.actions.size; _id_AC0E594AC96AA3A8++) {
    action = _id_C38FCEA73953365E.actions[_id_AC0E594AC96AA3A8];
    key = "action" + _id_AC0E594AC96AA3A8;
    str = _id_905E60070F3E3CBF(action.description);
    _id_45668C725DC52275[key] = str;

    if(isDefined(action._id_292813F5FF278031))
      _id_45668C725DC52275["lastError" + _id_AC0E594AC96AA3A8] = _id_905E60070F3E3CBF(action._id_292813F5FF278031);
  }

  _id_45668C725DC52275["direction"] = _id_9F601132EE8804E7(self);
  _id_4603AA41477CA54D("UpdateBotMind", _id_45668C725DC52275);
}

_id_4F07546D6992CB73() {
  level endon("game_ended");

  for(;;) {
    _id_5B234F9FF418F161 = [];
    _id_0892C7A42BE39E66 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(!_id_371E37CB66601D58(player) || player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
        continue;
      }
      _id_676624C5FE59606D = _id_C1FB465742657A02(player);

      if(!isDefined(_id_676624C5FE59606D)) {
        continue;
      }
      _id_81A6DCF8641471F7 = _id_D1F5FF62271C92FE(player);
      str = "id=" + _id_81A6DCF8641471F7 + ";pos=" + _id_DCCBDDF82525092D(player) + ";direction=" + _id_9F601132EE8804E7(player);
      _id_0892C7A42BE39E66[_id_676624C5FE59606D] = player;
      _id_5B234F9FF418F161[_id_5B234F9FF418F161.size] = str;
    }

    if(_id_5B234F9FF418F161.size > 0)
      _id_35CB42962526710E("UpdatePlayerPos", _id_5B234F9FF418F161);

    if(_id_27A7D2350B94908B())
      _id_170E36088569C2A5(_id_0892C7A42BE39E66);

    wait(level._id_8A9762E276DE8903._id_6D3A3F51D84A3787);
  }
}

_id_6B1CA7FAEB9FD14A(player, _id_182038C1B0416C06, _id_31771BA889BCACE0, _id_401C3A2E68AAB0FD) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  if(!_id_371E37CB66601D58(player, 1) || player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["id"] = _id_D1F5FF62271C92FE(player);
  _id_45668C725DC52275["pos"] = _id_182038C1B0416C06;
  _id_45668C725DC52275["teleportPos"] = _id_31771BA889BCACE0;
  _id_45668C725DC52275["teleportReason"] = _id_905E60070F3E3CBF(_id_401C3A2E68AAB0FD);
  _id_4603AA41477CA54D("UpdatePlayerPos", _id_45668C725DC52275);
}

_id_371E37CB66601D58(player, _id_FD412339838644D8) {
  return _id_59FF79D681BB860C::_id_DED80385EA7471DB(player) && !player _id_40E63DD222434655::_id_A9CBF557DC66D201() && (istrue(_id_FD412339838644D8) || !player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014());
}

_id_9F601132EE8804E7(player) {
  return vectorNormalize(anglesToForward(player.angles));
}

_id_DCCBDDF82525092D(player) {
  if(isDefined(player.c130))
    return player.c130.origin;

  return player.origin;
}

_id_CC43CA415DF582DD() {
  level endon("game_ended");
  wait 1;

  for(;;) {
    wait(level._id_8A9762E276DE8903._id_6D3A3F51D84A3787);
    _id_156F390A5362BC55 = _id_26CCBFE3954CACF4::_id_749723C2A45A0233();
    _id_5B234F9FF418F161 = [];

    foreach(_id_89A675C5BDE8848F in _id_156F390A5362BC55) {
      _id_0C177F509325ADBF = _id_592C6F38A6569FEC(_id_89A675C5BDE8848F._id_FF1A8C6F49882FE8, 1);
      str = "id=" + _id_0C177F509325ADBF + ";name=" + _id_905E60070F3E3CBF(_id_89A675C5BDE8848F.name);
      _id_5B234F9FF418F161[_id_5B234F9FF418F161.size] = str;
    }

    _id_35CB42962526710E("DebugUpdateUIBots", _id_5B234F9FF418F161);
  }
}

_id_C77B4D855737D7AF() {
  level endon("game_ended");

  while(!isDefined(level.agentarray))
    waitframe();

  _id_D69AC11220FDB07E = 1;

  for(;;) {
    _id_5B234F9FF418F161 = [];

    foreach(agent in level.agentarray) {
      if(isalive(agent)) {
        agentname = _id_62945C3D6792D0EE(agent);
        str = "id=" + agentname + ";pos=" + agent.origin;
        _id_5B234F9FF418F161[_id_5B234F9FF418F161.size] = str;
      }
    }

    if(_id_5B234F9FF418F161.size > 0) {
      _id_D69AC11220FDB07E = 0;
      _id_35CB42962526710E("UpdateAgentPos", _id_5B234F9FF418F161);
    } else {
      if(!_id_D69AC11220FDB07E)
        _id_35CB42962526710E("UpdateAgentPos");

      _id_D69AC11220FDB07E = 1;
    }

    wait(level._id_8A9762E276DE8903._id_6D3A3F51D84A3787);
  }
}

_id_B9790B63A2EAE9CC() {
  level endon("game_ended");
  _id_61C7C88E85221081 = ["br_circle_set", "br_circle_started", "br_circle_closed", "circle_paused", "circle_unpaused"];

  for(;;) {
    scripts\engine\utility::waittill_any_in_array_or_timeout(_id_61C7C88E85221081, level._id_8A9762E276DE8903._id_D3EEC3EAC4C4BA7C);

    if(!isDefined(level.br_circle)) {
      continue;
    }
    _id_11BF09A7197D1290();
  }
}

_id_11BF09A7197D1290() {
  circleindex = level.br_circle.circleindex;

  if(!isDefined(circleindex) || circleindex < 0) {
    return;
  }
  if(istrue(level._id_2DF69B8E552238B6) && isDefined(level._id_B31733F431ED12E0)) {
    for(index = 0; index < level._id_B31733F431ED12E0._id_209967C144016964; index++) {
      _id_E681932897D7F299 = _id_58F20490049AF6AC::_id_755C691F70EAFE3B(index);
      _id_E681932897D7F299 = _id_CD70B8FA232889F5(_id_E681932897D7F299[0], _id_E681932897D7F299[1]);
      circleradius = _id_58F20490049AF6AC::_id_0A835B5DFF878F77(index);
      targetpos = _id_58F20490049AF6AC::_id_0799FE4EE850F911(index);
      targetpos = _id_CD70B8FA232889F5(targetpos[0], targetpos[1]);
      _id_154EF61B7A7F747A = _id_58F20490049AF6AC::_id_8A985543E6853BBD(index);
      _id_2A02755326C9546A("UpdateCircle", ["id", circleindex, "circle_id", index, "pos", _id_E681932897D7F299, "radius", circleradius, "target_pos", targetpos, "target_radius", _id_154EF61B7A7F747A]);
    }
  } else {
    _id_E681932897D7F299 = _id_2695A20D4011076D::getdangercircleorigin();
    _id_E681932897D7F299 = _id_CD70B8FA232889F5(_id_E681932897D7F299[0], _id_E681932897D7F299[1]);
    circleradius = _id_2695A20D4011076D::getdangercircleradius();
    targetpos = _id_2695A20D4011076D::getsafecircleorigin();
    targetpos = _id_CD70B8FA232889F5(targetpos[0], targetpos[1]);
    _id_154EF61B7A7F747A = _id_2695A20D4011076D::getsafecircleradius();
    _id_2A02755326C9546A("UpdateCircle", ["id", circleindex, "circle_id", 0, "pos", _id_E681932897D7F299, "radius", circleradius, "target_pos", targetpos, "target_radius", _id_154EF61B7A7F747A]);
  }
}

_id_433AF73A108EEC49(victim, attacker, meansofdeath, damage, hitloc) {
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["victim"] = _id_62945C3D6792D0EE(victim);
  _id_45668C725DC52275["victimDirection"] = _id_9F601132EE8804E7(victim);

  if(isDefined(attacker)) {
    _id_45668C725DC52275["attacker"] = _id_62945C3D6792D0EE(attacker);

    if(isPlayer(attacker))
      _id_45668C725DC52275["attackerDirection"] = _id_9F601132EE8804E7(attacker);
  }

  _id_45668C725DC52275["damageType"] = _id_905E60070F3E3CBF(meansofdeath);
  _id_45668C725DC52275["damageValue"] = damage;

  if(isDefined(hitloc))
    _id_45668C725DC52275["hitLoc"] = _id_905E60070F3E3CBF(hitloc);

  _id_45668C725DC52275["health"] = victim.health;

  if(isPlayer(victim)) {
    _id_41B371CA46E67BFE = _id_D48694033481CF25(victim);
    _id_3226093417BD3363(_id_41B371CA46E67BFE, "health", victim.health);
  }

  _id_4603AA41477CA54D("DoDamage", _id_45668C725DC52275);
}

_id_2EA4C1DB39176769(attacker, victim, meansofdeath, damage) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["victim"] = _id_62945C3D6792D0EE(victim);

  if(isDefined(attacker))
    _id_45668C725DC52275["attacker"] = _id_62945C3D6792D0EE(attacker);

  if(isDefined(meansofdeath))
    _id_45668C725DC52275["meansOfDeath"] = _id_905E60070F3E3CBF(meansofdeath);

  if(isDefined(damage))
    _id_45668C725DC52275["damage"] = damage;

  if(isPlayer(victim)) {
    _id_41B371CA46E67BFE = _id_D48694033481CF25(victim);
    _id_3226093417BD3363(_id_41B371CA46E67BFE, "health", victim.health);
  }

  _id_4603AA41477CA54D("PlayerKilled", _id_45668C725DC52275);
}

_id_C622E0EA21D494FE(_id_89A675C5BDE8848F, _id_401C3A2E68AAB0FD) {
  if(!_id_E60552DD6ABCC4AA() || !_id_27A7D2350B94908B()) {
    return;
  }
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["id"] = _id_592C6F38A6569FEC(_id_89A675C5BDE8848F._id_FF1A8C6F49882FE8, 1);
  _id_45668C725DC52275["name"] = _id_905E60070F3E3CBF(_id_89A675C5BDE8848F.name);
  _id_45668C725DC52275["reason"] = _id_905E60070F3E3CBF(_id_401C3A2E68AAB0FD);
  _id_4603AA41477CA54D("DebugActivateUIBot", _id_45668C725DC52275);
}

_id_8303A56B1EE268B2(status, _id_401C3A2E68AAB0FD, _id_B7880B390F019131) {
  if(!_id_E60552DD6ABCC4AA() || !_id_27A7D2350B94908B()) {
    return;
  }
  _id_45668C725DC52275 = [];
  _id_45668C725DC52275["status"] = _id_905E60070F3E3CBF(status);
  _id_45668C725DC52275["reason"] = _id_905E60070F3E3CBF(_id_401C3A2E68AAB0FD);
  _id_156F390A5362BC55 = _id_26CCBFE3954CACF4::_id_749723C2A45A0233();
  _id_45668C725DC52275["remain"] = _id_156F390A5362BC55.size;

  if(isDefined(_id_B7880B390F019131))
    _id_45668C725DC52275["deployCount"] = _id_B7880B390F019131;

  _id_4603AA41477CA54D("DebugDeployUIBotStatus", _id_45668C725DC52275);
}

_id_873C0BE4897BD6C8(_id_3EAA9F644DBE7834) {
  if(!_id_E60552DD6ABCC4AA() || !_id_27A7D2350B94908B()) {
    return;
  }
  _id_5B234F9FF418F161 = [];
  str = "method=" + _id_3EAA9F644DBE7834;
  _id_5B234F9FF418F161[0] = str;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];
    playerid = _id_D1F5FF62271C92FE(player);
    str = "id=" + playerid;
    str = str + (";isAlive=" + _id_59FF79D681BB860C::_id_DED80385EA7471DB(player));
    str = str + (";eliminated=" + player _id_40E63DD222434655::_id_A9CBF557DC66D201());

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      str = str + (";ghost=" + player _id_2CEDCC356F1B9FC8::_id_F5446040A93792C3());

    str = str + (";UIBot=" + player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014());

    if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      str = str + (";gulagId=" + player.arena.gulagindex);
    else
      str = str + ";gulagId=-1";

    _id_5B234F9FF418F161[_id_5B234F9FF418F161.size] = str;
  }

  if(_id_26CCBFE3954CACF4::_id_E60552DD6ABCC4AA()) {
    _id_156F390A5362BC55 = _id_26CCBFE3954CACF4::_id_749723C2A45A0233();

    foreach(_id_89A675C5BDE8848F in _id_156F390A5362BC55) {
      _id_0C177F509325ADBF = _id_592C6F38A6569FEC(_id_89A675C5BDE8848F._id_FF1A8C6F49882FE8, 1);
      str = "uibot=1;id=" + _id_0C177F509325ADBF + ";name=" + _id_905E60070F3E3CBF(_id_89A675C5BDE8848F.name);
      _id_5B234F9FF418F161[_id_5B234F9FF418F161.size] = str;
    }
  }

  if(_id_5B234F9FF418F161.size > 0)
    _id_35CB42962526710E("DebugForceEndGame", _id_5B234F9FF418F161);
}

_id_170E36088569C2A5(_id_0892C7A42BE39E66) {
  foreach(key, _id_41B371CA46E67BFE in level._id_8A9762E276DE8903.players) {
    if(scripts\engine\utility::_id_53C4C53197386572(_id_41B371CA46E67BFE._id_104F87CC51A1138D["health"], -1) <= 0) {
      continue;
    }
    if(scripts\engine\utility::_id_53C4C53197386572(_id_41B371CA46E67BFE._id_104F87CC51A1138D["eliminated"], 0) == 1) {
      continue;
    }
    if(scripts\engine\utility::_id_53C4C53197386572(_id_41B371CA46E67BFE._id_104F87CC51A1138D["gulagId"], -1) >= 0) {
      continue;
    }
    status = scripts\engine\utility::_id_53C4C53197386572(_id_41B371CA46E67BFE._id_104F87CC51A1138D["botStatus"], "");

    if(status == "kickout" || status == "uibot") {
      continue;
    }
    if(!isDefined(_id_0892C7A42BE39E66[key])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        player = level.players[_id_AC0E594AC96AA3A8];
        _id_FF1A8C6F49882FE8 = _id_C1FB465742657A02(player);

        if(isDefined(_id_FF1A8C6F49882FE8) && _id_FF1A8C6F49882FE8 == _id_41B371CA46E67BFE.id) {
          _id_45668C725DC52275 = [];
          _id_45668C725DC52275["id"] = _id_D1F5FF62271C92FE(player);
          _id_45668C725DC52275["isAlive"] = _id_59FF79D681BB860C::_id_DED80385EA7471DB(player);
          _id_45668C725DC52275["isEliminated"] = player _id_40E63DD222434655::_id_A9CBF557DC66D201();

          if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
            _id_45668C725DC52275["isGhost"] = player _id_2CEDCC356F1B9FC8::_id_F5446040A93792C3();

          _id_45668C725DC52275["isUIBot"] = player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014();
          _id_45668C725DC52275["health"] = player.health;

          if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
            _id_45668C725DC52275["gulagId"] = player.arena.gulagindex;

          _id_4603AA41477CA54D("DebugRemovedPlayerStatus", _id_45668C725DC52275);
          break;
        }
      }
    }
  }
}

_id_4603AA41477CA54D(type, _id_85C7FEE55D069E31) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953++;
  _id_73DB6DE3FCDAC953 = level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953;

  if(!isDefined(_id_85C7FEE55D069E31) || _id_85C7FEE55D069E31.size == 0)
    return _id_9E0BF4E5541C261C(type, "", _id_73DB6DE3FCDAC953);

  _id_668A4BBDD722031B = "";

  foreach(key, value in _id_85C7FEE55D069E31) {
    str = _id_14D1CB139426211A(key, value);

    if(_id_668A4BBDD722031B.size + str.size >= 1920) {
      _id_9E0BF4E5541C261C(type, _id_668A4BBDD722031B, _id_73DB6DE3FCDAC953, 1);
      _id_668A4BBDD722031B = "";
    }

    _id_668A4BBDD722031B = _id_668A4BBDD722031B + str;
  }

  _id_9E0BF4E5541C261C(type, _id_668A4BBDD722031B, _id_73DB6DE3FCDAC953);
}

_id_2A02755326C9546A(type, _id_31FE7A6ADF854D98) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953++;
  _id_73DB6DE3FCDAC953 = level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953;

  if(!isDefined(_id_31FE7A6ADF854D98) || _id_31FE7A6ADF854D98.size == 0)
    return _id_9E0BF4E5541C261C(type, "", _id_73DB6DE3FCDAC953);

  _id_8A73A0E5B873C7CD = _id_2CFBE3D9B897E187(_id_31FE7A6ADF854D98);
  _id_C92C78259FABCC48 = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8A73A0E5B873C7CD.size; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 == _id_8A73A0E5B873C7CD.size - 1)
      _id_C92C78259FABCC48 = 0;

    _id_9E0BF4E5541C261C(type, _id_8A73A0E5B873C7CD[_id_AC0E594AC96AA3A8], _id_73DB6DE3FCDAC953, _id_C92C78259FABCC48);
  }
}

_id_35CB42962526710E(type, _id_5B234F9FF418F161) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953++;
  _id_73DB6DE3FCDAC953 = level._id_8A9762E276DE8903._id_73DB6DE3FCDAC953;

  if(!isDefined(_id_5B234F9FF418F161) || _id_5B234F9FF418F161.size == 0)
    return _id_9E0BF4E5541C261C(type, "", _id_73DB6DE3FCDAC953);

  _id_668A4BBDD722031B = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5B234F9FF418F161.size; _id_AC0E594AC96AA3A8++) {
    str = _id_5B234F9FF418F161[_id_AC0E594AC96AA3A8];

    if(_id_668A4BBDD722031B.size + str.size >= 1920) {
      _id_9E0BF4E5541C261C(type, _id_668A4BBDD722031B, _id_73DB6DE3FCDAC953, 1);
      _id_668A4BBDD722031B = "";
    }

    if(_id_AC0E594AC96AA3A8 == _id_5B234F9FF418F161.size - 1) {
      _id_668A4BBDD722031B = _id_668A4BBDD722031B + str;
      continue;
    }

    _id_668A4BBDD722031B = _id_668A4BBDD722031B + (str + "|");
  }

  _id_9E0BF4E5541C261C(type, _id_668A4BBDD722031B + ";", _id_73DB6DE3FCDAC953);
}

_id_9E0BF4E5541C261C(type, string, _id_73DB6DE3FCDAC953, _id_C92C78259FABCC48) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_85DA9F739E923EF0 = " ";

  if(istrue(_id_C92C78259FABCC48))
    _id_85DA9F739E923EF0 = "/ ";

  _id_1999C8DDB43D1637 = "[REPLAY] " + _id_73DB6DE3FCDAC953 + _id_85DA9F739E923EF0 + type + " " + string;
  _func_8294C13E5683B0A3(_id_1999C8DDB43D1637);
}

_id_2CFBE3D9B897E187(_id_31FE7A6ADF854D98) {
  _id_CBA40E031462D0A0 = [];

  if(_id_31FE7A6ADF854D98.size == 0)
    return _id_CBA40E031462D0A0;

  str = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_31FE7A6ADF854D98.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
    key = _id_31FE7A6ADF854D98[_id_AC0E594AC96AA3A8];
    val = _id_31FE7A6ADF854D98[_id_AC0E594AC96AA3A8 + 1];

    if(!isDefined(key)) {
      break;
    }

    _id_21B0EA321183EFE8 = _id_14D1CB139426211A(key, val);

    if(str.size + _id_21B0EA321183EFE8.size >= 1920) {
      _id_CBA40E031462D0A0[_id_CBA40E031462D0A0.size] = str;
      str = "";
    }

    str = str + _id_21B0EA321183EFE8;
  }

  _id_CBA40E031462D0A0[_id_CBA40E031462D0A0.size] = str;
  return _id_CBA40E031462D0A0;
}

_id_14D1CB139426211A(key, val) {
  result = key + "=";

  if(!isDefined(val))
    result = result + "undefined;";
  else if(isint(val) || isfloat(val) || isvector(val) || isstring(val))
    result = result + (val + ";");
  else {}

  return result;
}

_id_62945C3D6792D0EE(ent) {
  if(isPlayer(ent))
    return _id_D1F5FF62271C92FE(ent);
  else if(isagent(ent))
    return _id_905E60070F3E3CBF(ent._id_8AA9EFE6383C1D5A);

  _id_DEC9BCCE93873125 = ent.classname + ": ";
  id = ent getentitynumber();
  _id_DF6EDF345D8E8653 = _id_905E60070F3E3CBF(_id_DEC9BCCE93873125 + id);
  return _id_DF6EDF345D8E8653;
}

_id_D1F5FF62271C92FE(player) {
  return _id_592C6F38A6569FEC(_id_C1FB465742657A02(player), isbot(player));
}

_id_C1FB465742657A02(player) {
  _id_FF1A8C6F49882FE8 = undefined;

  if(!isDefined(player._id_5876CD9FC14AF731))
    _id_FF1A8C6F49882FE8 = player._id_FF1A8C6F49882FE8;
  else
    _id_FF1A8C6F49882FE8 = player._id_5876CD9FC14AF731._id_FF1A8C6F49882FE8;

  return _id_FF1A8C6F49882FE8;
}

_id_592C6F38A6569FEC(_id_676624C5FE59606D, isbot) {
  _id_DEC9BCCE93873125 = scripts\engine\utility::ter_op(isbot, "b_", "h_");

  if(!isDefined(_id_676624C5FE59606D))
    _id_676624C5FE59606D = "undefined";

  return _id_905E60070F3E3CBF(_id_DEC9BCCE93873125 + _id_676624C5FE59606D);
}

_id_905E60070F3E3CBF(str) {
  if(!isstring(str))
    return "";

  str = _id_10E35F6C482BD1B5(str);
  return "\"" + str + "\"";
}

_id_CD70B8FA232889F5(x, y) {
  return "(" + x + ", " + y + ")";
}

_id_10E35F6C482BD1B5(string) {
  _id_9ED0722E50272D8E = ["|", ";", "\""];

  foreach(_id_CE174B78F56823FA in _id_9ED0722E50272D8E)
  string = _func_95C6391212A25F7C(string, _id_CE174B78F56823FA);

  return string;
}