/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_40e63dd222434655.gsc
***********************************************/

_id_81A10B74BFE305A9() {
  level.bot_funcs["player_spawned_gamemode"] = ::spawned;
  level.bot_funcs["gametype_think"] = ::_id_F7453E13040E1140;
  level.bot_funcs["bot_gulag_get_respawn_point"] = _id_3904CFFF5CE7FDCB::_id_A10B82CA662AB815;
  level.bot_funcs["select_class_from_airdrop"] = ::_id_5B54ECC3B227F84D;
  level.bot_funcs["revive_think"] = scripts\engine\utility::void;
  _id_0D74AE0B4AA21186::_id_0232B4A5109DF340(level._id_18C3A736721CD3A4);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("accelerateBotsGulagMatch", ::_id_B5E22620A8778C4A);
}

spawned() {
  _id_7E816FA0720D38A1::_id_543A0A3113FF89F7();
  _id_59FF79D681BB860C::_id_21B2D65575E9C0CC("Skydive");
  self._id_AB5F5270CB22E3C8 = 0;
  _id_2EB0354A11A56B73 = isDefined(self._id_B4ADDE4C68BB0F24) && isDefined(self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C);
  _id_DA17FCD71681C773 = isDefined(self.gulaguses) && self.gulaguses > 0;
  _id_D2C758DFB50B7949 = !_id_2EB0354A11A56B73 && !_id_DA17FCD71681C773 && !istrue(self.respawningfromtoken);

  if(_id_2EB0354A11A56B73)
    self _meth_D7BF524EB1822214(1);

  if(_id_D2C758DFB50B7949)
    _id_D9DCF5D9ABDD5998();

  self._id_A80AB26B5150A5EE = self botgetdifficulty();
  self botsetflag("allow_laststand_decision", 1);
  _id_4C9BD9A3BF3F8CF7::_id_C827480E6D21A271();

  if(_id_D2C758DFB50B7949 && !scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
    _id_21E1F88E3B6C27BB = getdvarint("scr_br_plunder_start_amount", 0);
    _id_D437BEA518F94DD0 = getdvarint("dvar_B26DA3EE25C25A6C", _id_21E1F88E3B6C27BB);
    _id_6AFF3948CF4CCA03::playersetplundercount(_id_D437BEA518F94DD0);
  }
}

_id_F4CD8D89E37B4888() {
  _id_6ACBB2AF086C64FA();
  level waittill("br_prematchEnded");
  _id_6ACBB2AF086C64FA();

  foreach(player in level.players) {
    if(isbot(player))
      player _id_D9DCF5D9ABDD5998();
  }

  if(isDefined(level._id_7B37B2193F163B9B)) {
    foreach(_id_B4ADDE4C68BB0F24 in level._id_7B37B2193F163B9B._id_156F390A5362BC55)
    _id_B4ADDE4C68BB0F24.difficulty = _id_F09BCFCFE853F63F();
  }
}

_id_D9DCF5D9ABDD5998() {
  if(scripts\mp\utility\game::matchmakinggame())
    difficulty = _id_F09BCFCFE853F63F();
  else
    difficulty = _id_59FF79D681BB860C::_id_D55289CEEC7CF934();

  scripts\mp\bots\bots_util::bot_set_difficulty(difficulty);
  _id_8771893F1BCB49BB(self, difficulty);

  if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    _id_3DFE644341DE1E18 = self botgetdifficultysetting("strafeWeaponMaxRangeMultiplier");
    self botsetdifficultysetting("strafeWeaponMaxRangeMultiplier", _id_3DFE644341DE1E18 + 0.5);
    _id_2E222BBAEA1F163A = self botgetdifficultysetting("strafeWeaponMinRangeMultiplier");
    self botsetdifficultysetting("strafeWeaponMinRangeMultiplier", _id_2E222BBAEA1F163A + 0.5);
  }
}

_id_8771893F1BCB49BB(bot, difficulty) {
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.bot = bot;
  _id_7E2C53B0BCF117D9.difficulty = difficulty;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_bot_set_difficulty", _id_7E2C53B0BCF117D9);
}

_id_F09BCFCFE853F63F() {
  _id_4084C1D43F28940F = randomfloat(1);
  _id_4084C1D43F28940F = _id_4084C1D43F28940F - level._id_9F9AEE78F75F1519[0];

  if(_id_4084C1D43F28940F <= 0)
    return "recruit";

  _id_4084C1D43F28940F = _id_4084C1D43F28940F - level._id_9F9AEE78F75F1519[1];

  if(_id_4084C1D43F28940F <= 0)
    return "regular";

  _id_4084C1D43F28940F = _id_4084C1D43F28940F - level._id_9F9AEE78F75F1519[2];

  if(_id_4084C1D43F28940F <= 0)
    return "hardened";

  _id_4084C1D43F28940F = _id_4084C1D43F28940F - level._id_9F9AEE78F75F1519[3];

  if(_id_4084C1D43F28940F <= 0)
    return "veteran";

  return "regular";
}

_id_6ACBB2AF086C64FA() {
  if(getdvarint("online_matchmaking_is_league_play_br", 0)) {
    _id_602223D6E01FD5B5 = _id_45C730EB0C47724E();
    _id_22BA435FE8F3E8F6 = _id_9467E76F2BDBD0EB(_id_602223D6E01FD5B5, _id_6C4F073450168827(1));
  } else {
    _id_17B2DA550C77C426 = _id_DE4DBFC4BF8E46B7();
    _id_17B2DA550C77C426 = _id_17B2DA550C77C426 / 1000.0;
    _id_22BA435FE8F3E8F6 = _id_9467E76F2BDBD0EB(_id_17B2DA550C77C426, _id_6C4F073450168827(0));
  }

  _id_F8793C23A0EC47AB = _id_22BA435FE8F3E8F6[0] + _id_22BA435FE8F3E8F6[1] + _id_22BA435FE8F3E8F6[2] + _id_22BA435FE8F3E8F6[3];
  _id_22BA435FE8F3E8F6[0] = _id_22BA435FE8F3E8F6[0] / _id_F8793C23A0EC47AB;
  _id_22BA435FE8F3E8F6[1] = _id_22BA435FE8F3E8F6[1] / _id_F8793C23A0EC47AB;
  _id_22BA435FE8F3E8F6[2] = _id_22BA435FE8F3E8F6[2] / _id_F8793C23A0EC47AB;
  _id_22BA435FE8F3E8F6[3] = _id_22BA435FE8F3E8F6[3] / _id_F8793C23A0EC47AB;
  level._id_9F9AEE78F75F1519 = _id_22BA435FE8F3E8F6;
}

_id_DE4DBFC4BF8E46B7() {
  _id_786F842D5771CDB6 = _func_538E92208B641725();
  _id_3A8BF6B9F6916E85 = [];

  foreach(_id_E72DFDB2A9343F1B in _id_786F842D5771CDB6) {
    if(!_id_E72DFDB2A9343F1B.isai && isDefined(_id_E72DFDB2A9343F1B._id_CABD9E1D57839959))
      _id_3A8BF6B9F6916E85[_id_3A8BF6B9F6916E85.size] = _id_E72DFDB2A9343F1B._id_CABD9E1D57839959;
  }

  _id_3A8BF6B9F6916E85 = scripts\engine\utility::array_sort_with_func(_id_3A8BF6B9F6916E85, ::_id_6D4897AA01EEC31B);
  return _id_3A8BF6B9F6916E85[int(_id_3A8BF6B9F6916E85.size / 2)];
}

_id_45C730EB0C47724E() {
  if(!isDefined(level.players))
    return 0;

  _id_AEEE933771CE0A24 = [];

  foreach(player in level.players) {
    if(!_id_40034C2FAF09A87B(player)) {
      continue;
    }
    xuid = player getxuid();
    _id_602223D6E01FD5B5 = _func_904672268EB8E3FE(xuid);
    _id_AEEE933771CE0A24[_id_AEEE933771CE0A24.size] = _id_602223D6E01FD5B5;
  }

  _id_AEEE933771CE0A24 = scripts\engine\utility::array_sort_with_func(_id_AEEE933771CE0A24, ::_id_6D4897AA01EEC31B);
  return _id_AEEE933771CE0A24[int(_id_AEEE933771CE0A24.size / 2)];
}

_id_6D4897AA01EEC31B(_id_456C3AB4CCDC8D5D, _id_456C37B4CCDC86C4) {
  return _id_456C3AB4CCDC8D5D < _id_456C37B4CCDC86C4;
}

_id_9467E76F2BDBD0EB(value, table) {
  _id_685C40E8FBD9E877 = -1;
  _id_E4FE8DA17613F261 = -1;

  for(index = 0; index < table.size; index++) {
    maxrange = table[index][0];

    if(value >= _id_685C40E8FBD9E877 && value <= maxrange) {
      _id_E4FE8DA17613F261 = index;
      break;
    }

    _id_685C40E8FBD9E877 = maxrange;
  }

  if(_id_E4FE8DA17613F261 < 0)
    _id_E4FE8DA17613F261 = table.size - 1;

  return [table[_id_E4FE8DA17613F261][1], table[_id_E4FE8DA17613F261][2], table[_id_E4FE8DA17613F261][3], table[_id_E4FE8DA17613F261][4]];
}

_id_6C4F073450168827(_id_4DA07EB3D5ED2BE5) {
  if(istrue(_id_4DA07EB3D5ED2BE5)) {
    _id_47EF1080427D4D3A = 2147483647;
    _id_C6F4DD3F470D961E = "scr_sr_based_bot_difficulties_config_";
    _id_64ED35DBEB7BEB76 = getdvarint("dvar_6B701BA59329799B");
  } else {
    _id_47EF1080427D4D3A = 1;
    _id_C6F4DD3F470D961E = "scr_skill_based_bot_difficulties_config_";
    _id_64ED35DBEB7BEB76 = getdvarint("scr_skill_based_bot_difficulties_config_count");
  }

  if(_id_64ED35DBEB7BEB76 <= 0)
    return _id_B5B189C89F00BEB8("The value of config dvar '" + _id_C6F4DD3F470D961E + "count' is invalid.", _id_4DA07EB3D5ED2BE5);

  _id_60CA8D97EB9CAB53 = [];
  _id_E6706C52D7FD2BAF = -1;

  for(index = 1; index <= _id_64ED35DBEB7BEB76; index++) {
    if(istrue(_id_4DA07EB3D5ED2BE5))
      dvar = _func_2EF675C13CA1C4AF("scr_sr_based_bot_difficulties_config_", index);
    else
      dvar = _func_2EF675C13CA1C4AF("scr_skill_based_bot_difficulties_config_", index);

    _id_929A919F782B1C96 = getDvar(dvar);

    if(_id_929A919F782B1C96 == "")
      return _id_B5B189C89F00BEB8("The config dvar '" + _id_C6F4DD3F470D961E + index + "' is empty.", _id_4DA07EB3D5ED2BE5);

    _id_AC5AE676F98D14F8 = [];
    values = strtok(_id_929A919F782B1C96, ",");

    foreach(value in values)
    _id_AC5AE676F98D14F8[_id_AC5AE676F98D14F8.size] = float(value);

    if(_id_AC5AE676F98D14F8.size != 5)
      return _id_B5B189C89F00BEB8("The columns count of the dvar '" + _id_C6F4DD3F470D961E + index + "' is not valid.", _id_4DA07EB3D5ED2BE5);

    if(_id_AC5AE676F98D14F8[0] <= _id_E6706C52D7FD2BAF || _id_AC5AE676F98D14F8[0] > _id_47EF1080427D4D3A)
      return _id_B5B189C89F00BEB8("The performance max range is not valid in the dvar '" + _id_C6F4DD3F470D961E + index + "' .", _id_4DA07EB3D5ED2BE5);

    _id_E6706C52D7FD2BAF = _id_AC5AE676F98D14F8[0];
    _id_60CA8D97EB9CAB53[_id_60CA8D97EB9CAB53.size] = _id_AC5AE676F98D14F8;
  }

  if(istrue(_id_4DA07EB3D5ED2BE5)) {
    _id_1AD0779E6539C287 = _id_60CA8D97EB9CAB53[_id_60CA8D97EB9CAB53.size - 1];
    _id_1AD0779E6539C287[0] = 2147483647;
    _id_60CA8D97EB9CAB53[_id_60CA8D97EB9CAB53.size] = _id_1AD0779E6539C287;
  } else if(_id_E6706C52D7FD2BAF != 1)
    _id_60CA8D97EB9CAB53[_id_60CA8D97EB9CAB53.size - 1][0] = 1;

  return _id_60CA8D97EB9CAB53;
}

_id_B5B189C89F00BEB8(_id_539576F2B677F552, _id_4DA07EB3D5ED2BE5) {
  if(istrue(_id_4DA07EB3D5ED2BE5))
    return [[150, 10, 0, 0, 0], [300, 8, 2, 0, 0], [450, 7, 2, 1, 0], [2147483647, 7, 2, 1, 0]];

  return [[-0.2, 10, 0, 0, 0], [-0.15, 7, 3, 0, 0], [0, 5, 3, 2, 0], [0.3, 3, 3, 3, 1], [0.8, 1, 3, 3, 3], [0.9, 0, 1, 1, 8], [1, 0, 0, 1, 9]];
}

_id_A12DE8D6FA23A4D9() {
  if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C())
    return undefined;

  if(!istrue(level._id_C61AF0E49678F2BA)) {
    level._id_C61AF0E49678F2BA = 1;
    _id_3D1DB28CD6CDD65E = undefined;

    if(scripts\mp\utility\game::matchmakinggame())
      _id_3D1DB28CD6CDD65E = _id_DE4DBFC4BF8E46B7();
    else
      _id_3D1DB28CD6CDD65E = getdvarfloat("dvar_502EA1A19A22A22F", 0);

    level._id_935FC4498C2F463D = clamp(_id_3D1DB28CD6CDD65E / 1000.0, -1, 1);
    level._id_6916D2BB0277DA6E = _id_AC985998F660D63D();
  }

  if(!isDefined(level._id_6916D2BB0277DA6E) || level._id_6916D2BB0277DA6E.size < 1)
    return undefined;

  _id_43F004CCE557F835 = level._id_6916D2BB0277DA6E.size - 1;

  for(index = 0; index < level._id_6916D2BB0277DA6E.size; index++) {
    if(level._id_935FC4498C2F463D <= level._id_6916D2BB0277DA6E[index][0]) {
      _id_43F004CCE557F835 = index;
      break;
    }
  }

  return level._id_6916D2BB0277DA6E[_id_43F004CCE557F835];
}

_id_AC985998F660D63D() {
  _id_64ED35DBEB7BEB76 = getdvarint("dvar_EFF52385B9663477");

  if(_id_64ED35DBEB7BEB76 <= 0)
    return [];

  _id_A95A701FC50363C9 = [];

  for(index = 1; index <= _id_64ED35DBEB7BEB76; index++) {
    dvar = _func_2EF675C13CA1C4AF("dvar_9E9368FDE1B1A498", index);
    _id_929A919F782B1C96 = getDvar(dvar);

    if(_id_929A919F782B1C96 == "")
      return [];

    values = strtok(_id_929A919F782B1C96, ",");

    if(values.size != 3)
      return [];

    _id_A95A701FC50363C9[_id_A95A701FC50363C9.size] = (float(values[0]), float(values[1]), float(values[2]));
  }

  _id_A95A701FC50363C9 = scripts\engine\utility::array_sort_with_func(_id_A95A701FC50363C9, ::_id_41EE7F6310C3975A);
  return _id_A95A701FC50363C9;
}

_id_41EE7F6310C3975A(_id_472D4F042B732E8A, _id_CB730D03142C3F30) {
  return _id_472D4F042B732E8A[0] < _id_CB730D03142C3F30[0];
}

_id_F7453E13040E1140() {
  self._id_0DEB55E4A0429EF1 = 1;
  self notify("bot_br_super_think");
  self endon("bot_br_super_think");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_4C9BD9A3BF3F8CF7::_id_83574001589FB42D();

  if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
    if(_id_26CCBFE3954CACF4::_id_64432AF189B8A177(1, 0))
      return;
  } else if(istrue(level.skipprematch) && !istrue(level.br_infils_disabled)) {
    if(_id_26CCBFE3954CACF4::_id_64432AF189B8A177(2, 0))
      return;
  }

  childthread _id_3B14FD3847FB5FE6();
  childthread _id_290494C263CB346D();
  childthread _id_B4B715FD038025C6();

  for(;;) {
    if(_id_26CCBFE3954CACF4::_id_6ECC7CD453466014()) {
      wait 0.05;
      continue;
    }

    if(!_id_2CEDCC356F1B9FC8::_id_55B494A07469298A()) {
      if(infilthink())
        continue;
    }

    if(_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      _id_3904CFFF5CE7FDCB::_id_88039A31EF9E74DD();
      wait 1;
    }

    if(isDefined(level.br_circle) && isnavmeshloaded() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      _id_A4273E17F90BFBE6 = _id_59FF79D681BB860C::_id_9230BCB84B43D245();
      _id_7E5C62F21600A060 = scripts\mp\gamelogic::_id_1147BBC93EA9B83C();

      switch (_id_A4273E17F90BFBE6) {
        case "Skydive":
          if(self isskydiving() && (istrue(self.jumped) || _id_7E5C62F21600A060)) {
            self botsetflag("disable_all_ai", 0);
            self botclearscriptgoal();

            if(_id_59FF79D681BB860C::_id_DED80385EA7471DB(self._id_69652181699375D4) && !_id_7E5C62F21600A060 && !istrue(self.infil_complete))
              _id_019B63D254615307();

            _id_85686F0D8A5667DA(_id_7E5C62F21600A060);
            parachute(_id_7E5C62F21600A060);

            if(_id_7E5C62F21600A060 && !scripts\mp\gamelogic::_id_1147BBC93EA9B83C())
              _id_59FF79D681BB860C::_id_1E8FE34F5DFDEA49("Skydive");
            else
              _id_59FF79D681BB860C::_id_1E8FE34F5DFDEA49("Combat");
          }

          break;
        case "Combat":
          _id_3B64EB40368C1450::set("brBotCombat", "vehicle_use", 0);
          _id_084930089AF3D03B(_id_7E5C62F21600A060);

          if(_id_7E5C62F21600A060 && !scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
            _id_0D74AE0B4AA21186::_id_CD40E795B7776F14();
            _id_59FF79D681BB860C::_id_1E8FE34F5DFDEA49("Skydive");
          }

          break;
        default:
          break;
      }
    }

    wait 0.05;
  }
}

infilthink() {
  if(!istrue(self.jumped)) {
    _id_1A64CF8EB4B49C7E(1);

    if(_id_15217DC6E3E6AC8E())
      return 1;
  }

  _id_1A64CF8EB4B49C7E(0);
  return 0;
}

_id_15217DC6E3E6AC8E() {
  if(getdvarint("dvar_5270E4999186A160", 0) == 1) {
    _id_6EECA72E3E1F4BE8();
    return 0;
  }

  if(isDefined(level.br_c130spawndone) && !level.br_c130spawndone) {
    if(istrue(level.c130inbounds) && isDefined(self.br_infil_type)) {
      if(!isDefined(self._id_69652181699375D4) && !scripts\mp\gamelogic::_id_1147BBC93EA9B83C() && !istrue(self.infil_complete))
        self._id_69652181699375D4 = _id_56A8312D296B291A();

      if(_id_59FF79D681BB860C::_id_DED80385EA7471DB(self._id_69652181699375D4))
        _id_BD52989C7FD9EAA5();
      else
        _id_88B1BC0A1F68A014();

      _id_6EECA72E3E1F4BE8();
      return 0;
    }

    wait 0.05;
    return 1;
  }

  return 0;
}

_id_6EECA72E3E1F4BE8() {
  self.gulaguses = scripts\engine\utility::ter_op(getdvarint("dvar_3FF738F6200E3A65", 1) != 0, 0, 1);
  self.jumped = 1;

  while(isDefined(self.br_infil_type))
    wait 0.05;
}

_id_1A64CF8EB4B49C7E(_id_EA111DE8E9327C27) {
  if(_id_EA111DE8E9327C27) {
    self botclearscriptgoal();
    _id_59FF79D681BB860C::_id_2C2B5B435027F895(undefined);
  }

  self.ignoreall = _id_EA111DE8E9327C27;
  self botsetflag("suspended", _id_EA111DE8E9327C27);
}

_id_56A8312D296B291A() {
  if(!_id_6DD2DFEB41384764())
    return undefined;

  _id_D6EE3E704C6731D4 = _id_58BE75C518BF0D40::getsquadleader(self.team, self._id_0FF97225579DE16A);

  if(_id_40034C2FAF09A87B(_id_D6EE3E704C6731D4) && !istrue(_id_D6EE3E704C6731D4.jumped))
    return _id_D6EE3E704C6731D4;

  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(player == self || isDefined(_id_D6EE3E704C6731D4) && player == _id_D6EE3E704C6731D4) {
      continue;
    }
    if(_id_40034C2FAF09A87B(player) && !istrue(player.jumped))
      return player;
  }

  return undefined;
}

_id_BD52989C7FD9EAA5() {
  self endon("br_jump");
  msg = self._id_69652181699375D4 scripts\engine\utility::waittill_any_in_array_return(["br_jump", "death_or_disconnect"]);

  if(isDefined(msg) && msg == "br_jump") {
    _id_D17925E505D5039D = 500;
    _id_0CDB1D6030CFEA6B = 3000;
    _id_CCB34012FBA88C34 = randomintrange(_id_D17925E505D5039D, _id_0CDB1D6030CFEA6B);
    wait(_id_CCB34012FBA88C34 * 0.001);
    self notify("halo_jump_solo_c130");
  } else
    _id_88B1BC0A1F68A014();
}

_id_88B1BC0A1F68A014() {
  self._id_281AA410A3A5E229 = _id_B7799AE6D79C86C9();
  _id_4FA3D43B222D0428 = _id_1D4567718CB3AD12(self._id_281AA410A3A5E229);
  wait(_id_4FA3D43B222D0428);

  if(_id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
    self notify("halo_jump_c130");
  else
    self notify("halo_jump_solo_c130");
}

_id_85686F0D8A5667DA(_id_7E5C62F21600A060) {
  _id_221FA3AC27E4925E = undefined;

  if(_id_59FF79D681BB860C::_id_DED80385EA7471DB(self._id_6601CCD8EC4B0356)) {
    _id_221FA3AC27E4925E = self._id_6601CCD8EC4B0356.origin;
    self._id_281AA410A3A5E229 = _id_89B90EAAC28334C7(_id_221FA3AC27E4925E);
  } else if(!isDefined(self._id_281AA410A3A5E229)) {
    if(_id_7E5C62F21600A060)
      self._id_281AA410A3A5E229 = _id_3023EEEF223A5594();
    else
      self._id_281AA410A3A5E229 = _id_E39354EBECA71C56();
  }

  self._id_38DF06A438DF2608 = _id_9816D841F0F205E2(_id_7E5C62F21600A060, _id_221FA3AC27E4925E);
  _id_518BD7FFA76F3234 = 30;
  self._id_38DF06A438DF2608 = self._id_38DF06A438DF2608 + scripts\engine\utility::randomvector(_id_518BD7FFA76F3234);

  if(isDefined(self._id_6601CCD8EC4B0356))
    self._id_6601CCD8EC4B0356 = undefined;
}

_id_3B14FD3847FB5FE6() {
  self endon("bot_suspended");
  _id_7E816FA0720D38A1::ammo_manager(::_id_DA84567CDA38847E);
}

_id_290494C263CB346D() {
  for(;;) {
    msg = scripts\engine\utility::waittill_any_in_array_return(["last_stand_start", "last_stand_finished"]);
    self botsetflag("ignore_script_weapon", msg == "last_stand_finished");

    if(msg == "last_stand_start")
      _id_59FF79D681BB860C::_id_2C2B5B435027F895(undefined);
  }
}

_id_B4B715FD038025C6() {
  if(isDefined(self._id_A80AB26B5150A5EE)) {
    if(self._id_A80AB26B5150A5EE != self botgetdifficulty())
      _id_0D74AE0B4AA21186::_id_B4C45ED36FA851D5();

    self._id_A80AB26B5150A5EE = undefined;
  }

  for(;;) {
    _id_0C31923566C85F07 = self botgetdifficulty();
    self waittill("bot_difficulty_updated");
    _id_21EC7A51A6627B28 = self botgetdifficulty();

    if(_id_21EC7A51A6627B28 != _id_0C31923566C85F07)
      _id_0D74AE0B4AA21186::_id_B4C45ED36FA851D5();
  }
}

_id_9816D841F0F205E2(_id_7BF0BA85EC52E893, closestpoint) {
  if(isDefined(level.br_circle) && isnavmeshloaded()) {
    _id_F3FCF5AF579ACD60 = undefined;
    _id_FE02B20F9AC0BD11 = self._id_281AA410A3A5E229;

    if(isDefined(level._id_0DBCB33D81F7D48D) && isDefined(_id_FE02B20F9AC0BD11) && isDefined(level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]) && isDefined(level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]._id_301D639DA97100C9)) {
      if(_id_7BF0BA85EC52E893)
        _id_301D639DA97100C9 = level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]._id_301D639DA97100C9;
      else
        _id_301D639DA97100C9 = _id_1C7137099A813AE1(level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]._id_301D639DA97100C9);

      _id_58C7087BBB70385C = [];

      if(_id_301D639DA97100C9.size == 0) {
        level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]._id_BD664214823FBF8D = 1;

        foreach(index, zone in level._id_0DBCB33D81F7D48D.zones) {
          if(index != _id_FE02B20F9AC0BD11 && !istrue(zone._id_BD664214823FBF8D))
            _id_58C7087BBB70385C[_id_58C7087BBB70385C.size] = index;
        }
      }

      while(_id_301D639DA97100C9.size == 0 && _id_58C7087BBB70385C.size > 0) {
        _id_FE02B20F9AC0BD11 = scripts\engine\utility::random(_id_58C7087BBB70385C);
        zone = level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11];
        _id_301D639DA97100C9 = _id_1C7137099A813AE1(zone._id_301D639DA97100C9);

        if(_id_301D639DA97100C9.size == 0) {
          zone._id_BD664214823FBF8D = 1;
          _id_58C7087BBB70385C = scripts\engine\utility::array_remove(_id_58C7087BBB70385C, _id_FE02B20F9AC0BD11);
        }
      }

      if(_id_FE02B20F9AC0BD11 != self._id_281AA410A3A5E229)
        self._id_281AA410A3A5E229 = _id_FE02B20F9AC0BD11;

      if(isDefined(closestpoint)) {
        mindistancesq = undefined;

        foreach(_id_0C3EA9B1A20FF199 in _id_301D639DA97100C9) {
          _id_4EB801042B324702 = distancesquared(_id_0C3EA9B1A20FF199.origin, closestpoint);

          if(!isDefined(mindistancesq) || mindistancesq > _id_4EB801042B324702) {
            _id_F3FCF5AF579ACD60 = _id_0C3EA9B1A20FF199;
            mindistancesq = _id_4EB801042B324702;
          }
        }
      } else
        _id_F3FCF5AF579ACD60 = scripts\engine\utility::random(_id_301D639DA97100C9);
    }

    if(isDefined(_id_F3FCF5AF579ACD60))
      _id_332BFCF7ECA6F520 = _id_F3FCF5AF579ACD60.origin;
    else
      _id_332BFCF7ECA6F520 = _id_2695A20D4011076D::getrandompointincurrentcircle();

    return getclosestpointonnavmesh(_id_332BFCF7ECA6F520, self);
  }

  return undefined;
}

_id_1C7137099A813AE1(_id_D845B94E50A75D37) {
  radius = _id_2695A20D4011076D::getdangercircleradius();
  origin = _id_2695A20D4011076D::getdangercircleorigin();
  return scripts\engine\utility::get_array_of_closest(origin, _id_D845B94E50A75D37, undefined, undefined, radius);
}

_id_89B90EAAC28334C7(origin) {
  _id_73A56D219E2F275A = undefined;

  if(isDefined(level._id_0DBCB33D81F7D48D)) {
    _id_84D4866087B00608 = undefined;

    foreach(_id_FE02B20F9AC0BD11, zone in level._id_0DBCB33D81F7D48D.zones) {
      distsq = distancesquared(origin, _id_774E0B129D4D22B8(_id_FE02B20F9AC0BD11));

      if(!isDefined(_id_84D4866087B00608) || _id_84D4866087B00608 > distsq) {
        _id_84D4866087B00608 = distsq;
        _id_73A56D219E2F275A = _id_FE02B20F9AC0BD11;
      }
    }
  }

  return _id_73A56D219E2F275A;
}

_id_1D4567718CB3AD12(_id_FE02B20F9AC0BD11) {
  _id_26910AE9F2257DF0 = _id_774E0B129D4D22B8(_id_FE02B20F9AC0BD11);

  if(!isDefined(_id_26910AE9F2257DF0))
    return _id_7E816FA0720D38A1::_id_A4091EF2BE7E55B0();

  startpos = level.br_ac130.origin;
  endpos = level.infilstruct.c130pathstruct.endpt;
  closestpoint = _id_26910AE9F2257DF0 - vectorfromlinetopoint(startpos, endpos, _id_26910AE9F2257DF0);
  _id_A51AF1F3806E4039 = 0;
  _id_471F3B81B2B07590 = 0;

  if(vectordot(closestpoint - startpos, endpos - startpos) < 0)
    _id_A51AF1F3806E4039 = 1;
  else {
    _id_945228A8CC480F69 = length(closestpoint - _id_26910AE9F2257DF0) / tan(75);
    _id_471F3B81B2B07590 = length(closestpoint - startpos) - _id_945228A8CC480F69;

    if(_id_471F3B81B2B07590 <= 0)
      _id_A51AF1F3806E4039 = 1;
  }

  if(_id_A51AF1F3806E4039) {
    _id_A711BA4A09F83D90 = level.infilstruct.c130pathstruct.startptui;

    if(vectordot(_id_A711BA4A09F83D90 - startpos, endpos - startpos) < 0)
      return 0;

    _id_471F3B81B2B07590 = length(_id_A711BA4A09F83D90 - startpos);
  }

  _id_7FABD515955682D9 = _id_471F3B81B2B07590 / _id_45B2B4A889E633FA::getc130speed();
  return _id_7FABD515955682D9;
}

_id_774E0B129D4D22B8(_id_FE02B20F9AC0BD11) {
  if(!isDefined(level._id_0DBCB33D81F7D48D) || !isDefined(_id_FE02B20F9AC0BD11) || !isDefined(level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]))
    return undefined;

  zone = level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11];
  _id_26910AE9F2257DF0 = zone._id_26910AE9F2257DF0;

  if(!isDefined(_id_26910AE9F2257DF0)) {
    if(zone._id_301D639DA97100C9.size > 0)
      _id_26910AE9F2257DF0 = zone._id_301D639DA97100C9[0].origin;
  }

  if(!isDefined(_id_26910AE9F2257DF0)) {
    if(zone._id_005B8D15B94E3CD0.size > 0)
      _id_26910AE9F2257DF0 = zone._id_005B8D15B94E3CD0[0].origin;
  }

  return _id_26910AE9F2257DF0;
}

_id_B7799AE6D79C86C9() {
  if(_id_58BE75C518BF0D40::issquadmode()) {
    squad = level.squaddata[self.team][self._id_0FF97225579DE16A];
    _id_FE02B20F9AC0BD11 = squad._id_21C2F79E8BFA9162;

    if(isDefined(_id_FE02B20F9AC0BD11)) {} else {
      _id_FE02B20F9AC0BD11 = _id_E39354EBECA71C56();
      squad._id_21C2F79E8BFA9162 = _id_FE02B20F9AC0BD11;
    }

    return _id_FE02B20F9AC0BD11;
  }

  return _id_E39354EBECA71C56();
}

_id_3023EEEF223A5594() {
  if(isDefined(level.prematchspawnorigins) && level.prematchspawnorigins.size > 0)
    return _id_89B90EAAC28334C7(self.origin);

  return _id_E39354EBECA71C56();
}

_id_E39354EBECA71C56() {
  if(isDefined(level._id_0DBCB33D81F7D48D) && level._id_0DBCB33D81F7D48D._id_F51F037FB790E57C > 0) {
    result = randomint(level._id_0DBCB33D81F7D48D._id_F51F037FB790E57C);
    left = 0;
    right = level._id_0DBCB33D81F7D48D.zones.size - 1;

    while(left <= right) {
      pivot = left + int((right - left) / 2);

      if(pivot == 0)
        _id_6870E4A8E64329AA = 0;
      else
        _id_6870E4A8E64329AA = level._id_0DBCB33D81F7D48D.zones[pivot - 1]._id_68E87685AA19DA24;

      _id_6893EEA8E6698760 = level._id_0DBCB33D81F7D48D.zones[pivot]._id_68E87685AA19DA24;

      if(result < _id_6870E4A8E64329AA) {
        right = pivot - 1;
        continue;
      }

      if(result >= _id_6893EEA8E6698760) {
        left = pivot + 1;
        continue;
      }

      return pivot;
    }
  }

  return undefined;
}

_id_019B63D254615307() {
  self._id_69652181699375D4 endon("death_or_disconnect");
  self.ignoreall = 1;
  _id_59FF79D681BB860C::_id_142B713A2846F9AC("Parachuting - Following");
  _id_82B713438181C528 = 3000;
  _id_8D8B1541818E49BC = 1000;
  _id_DB0E9F8BCD027630 = 500;
  _id_F68B4C88FDD8234E = 1;
  _id_696BA03DD97C3224 = 1;

  while(self isskydiving()) {
    _id_D459F6D98BFB8AAD = _id_82DC476C43087820();

    if(_id_D459F6D98BFB8AAD < _id_82B713438181C528) {
      self._id_6601CCD8EC4B0356 = self;
      break;
    }

    if(!self._id_69652181699375D4 isskydiving()) {
      self._id_6601CCD8EC4B0356 = self._id_69652181699375D4;
      break;
    }

    _id_9FDDA7532CD6D8A2 = self.origin[2] - self._id_69652181699375D4.origin[2];

    if(self isparachuting()) {
      if(_id_9FDDA7532CD6D8A2 > _id_8D8B1541818E49BC)
        self botpressbutton("cut_chute");
    } else if(_id_9FDDA7532CD6D8A2 <= 0 || _id_9FDDA7532CD6D8A2 <= _id_8D8B1541818E49BC && self._id_69652181699375D4 isparachuting())
      self botpressbutton("jump");

    _id_3840F75FD5FC4336 = distance2d(self.origin, self._id_69652181699375D4.origin);

    if(_id_3840F75FD5FC4336 <= _id_DB0E9F8BCD027630) {
      _id_56AFF2CB796714DD = anglesToForward(self._id_69652181699375D4.angles);
      self botlookatpoint(self.origin + _id_56AFF2CB796714DD * 1000, _id_F68B4C88FDD8234E, "script_forced");
      _id_3E1F9C45395E389F = self._id_69652181699375D4 getvelocity();
      velocity = self getvelocity();
      _id_F0D4F34E58368F52 = _id_3E1F9C45395E389F - velocity;
      _id_B2BEE1AED960F257 = vectortoangles(vectorNormalize(_id_F0D4F34E58368F52));
      self botsetscriptmove(_id_B2BEE1AED960F257[1], _id_F68B4C88FDD8234E, _id_696BA03DD97C3224);
    } else {
      _id_C43469E7A5AE4BA4(self._id_69652181699375D4.origin, _id_F68B4C88FDD8234E);
      _id_B2BEE1AED960F257 = _id_7E816FA0720D38A1::bot_get_angles_to_goal(self, self._id_69652181699375D4.origin);
      self botsetscriptmove(_id_B2BEE1AED960F257[1], _id_F68B4C88FDD8234E, _id_696BA03DD97C3224);
    }

    wait(_id_F68B4C88FDD8234E);
  }
}

parachute(_id_7BF0BA85EC52E893) {
  if(_id_7BF0BA85EC52E893)
    level endon("prematch_over");

  self.ignoreall = 1;
  _id_C4672D91A23583FB = 1200;
  _id_C4442391A20F2645 = 3000;
  _id_15F70B9B7E9402E3 = randomfloatrange(_id_C4672D91A23583FB, _id_C4442391A20F2645);
  _id_9CD127607FBA42B1 = 0;
  _id_6EC7D15CA86B6B0A = 0;
  _id_DABF4CF09B2C06CA = undefined;
  _id_B012001B3448E7C7 = undefined;
  _id_7DBDA545F37B475F = 0;
  self._id_18B21E1E1191BCEA = 2147483647;
  _id_59FF79D681BB860C::_id_142B713A2846F9AC("Parachuting");

  while(self isskydiving()) {
    _id_D0539E08120FCB08();
    _id_B2BEE1AED960F257 = _id_7E816FA0720D38A1::bot_get_angles_to_goal(self, self._id_38DF06A438DF2608);
    speed = 1;
    _id_26555D95DC188E56 = self._id_38DF06A438DF2608 - self getEye();

    if(_id_26555D95DC188E56[2] > 0 && !_id_41A2827FB8521C44(_id_26555D95DC188E56))
      self._id_38DF06A438DF2608 = self.origin - (0, 0, 100);

    _id_C43469E7A5AE4BA4(self._id_38DF06A438DF2608, 0.05);
    self botsetscriptmove(_id_B2BEE1AED960F257[1], 0.05, speed);
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_D459F6D98BFB8AAD = _id_82DC476C43087820();

    if(_id_D459F6D98BFB8AAD <= _id_15F70B9B7E9402E3 && _id_9CD127607FBA42B1 <= 0) {
      self botpressbutton("jump");
      _id_9CD127607FBA42B1 = _id_6B7BEE46F2C6DA28;
      self._id_18B21E1E1191BCEA = _id_6B7BEE46F2C6DA28;
    }

    if(_id_9CD127607FBA42B1 <= 0 && self isparachuting()) {
      _id_9CD127607FBA42B1 = _id_6B7BEE46F2C6DA28;
      self._id_18B21E1E1191BCEA = _id_6B7BEE46F2C6DA28;
    }

    if(!_id_6EC7D15CA86B6B0A && _id_9CD127607FBA42B1 > 0 && _id_26555D95DC188E56[2] < 0 && _id_6B7BEE46F2C6DA28 - _id_9CD127607FBA42B1 > 1000)
      _id_6EC7D15CA86B6B0A = _id_AC55A70C78EC6AA5();

    if(_id_9CD127607FBA42B1 > 0 && self _meth_3C6BB30AE7106B7A())
      _id_4473B5AF345C0B75(_id_D459F6D98BFB8AAD);

    if(isDefined(_id_DABF4CF09B2C06CA) && distancesquared(self.origin, _id_DABF4CF09B2C06CA) > 10)
      _id_B012001B3448E7C7 = _id_6B7BEE46F2C6DA28;

    _id_DABF4CF09B2C06CA = self.origin;

    if(isDefined(_id_B012001B3448E7C7) && _id_6B7BEE46F2C6DA28 - _id_B012001B3448E7C7 > 1000) {
      _id_7DBDA545F37B475F = 1;
      break;
    }

    wait 0.05;
  }

  if(!self._id_AB5F5270CB22E3C8 && !scripts\mp\gamelogic::_id_1147BBC93EA9B83C())
    thread _id_916E2512538553DB();

  self botlookatpoint(undefined);
  self.ignoreall = 0;
  _id_4A564EBB47167DC9 = 0;

  if(!_id_7BF0BA85EC52E893 && !istrue(self.infil_complete)) {
    self._id_281AA410A3A5E229 = undefined;
    self.infil_complete = 1;

    if(_id_7DBDA545F37B475F)
      _id_1A645E724209AC4A = 3;
    else
      _id_1A645E724209AC4A = 0;

    _id_487D2CC72334743D = _id_26CCBFE3954CACF4::_id_64432AF189B8A177(_id_1A645E724209AC4A, 1);

    if(_id_487D2CC72334743D) {
      if(_id_1A645E724209AC4A == 0)
        return;
    } else if(_id_7DBDA545F37B475F)
      _id_4A564EBB47167DC9 = 1;
  }

  if(_id_7DBDA545F37B475F) {
    while(self isskydiving()) {
      if(_id_26CCBFE3954CACF4::_id_64432AF189B8A177(3, _id_4A564EBB47167DC9)) {
        return;
      }
      wait 1;
    }
  }
}

_id_C43469E7A5AE4BA4(_id_91BE2B7482F940BA, _id_CC748B6D457627FE) {
  _id_91BE2B7482F940BA = _id_FC1A8616655393A5(_id_91BE2B7482F940BA);
  self botlookatpoint(_id_91BE2B7482F940BA, _id_CC748B6D457627FE, "script_forced");
}

_id_FC1A8616655393A5(_id_91BE2B7482F940BA) {
  if(!isDefined(_id_91BE2B7482F940BA))
    return undefined;

  if(_id_79EB95C7588F2191(_id_91BE2B7482F940BA))
    return _id_91BE2B7482F940BA;

  _id_EEFE5EC3AECF7FA3 = self getEye();
  _id_C74535E72311F8B0 = _id_91BE2B7482F940BA - _id_EEFE5EC3AECF7FA3;
  height = _id_C74535E72311F8B0[2];

  if(height < 1)
    return undefined;

  _id_7443F3542B52786A = length2dsquared(_id_C74535E72311F8B0);

  if(_id_7443F3542B52786A < 1)
    _id_4821E22D1E800BF1 = anglesToForward(self.angles);
  else
    _id_4821E22D1E800BF1 = _id_C74535E72311F8B0;

  _id_4821E22D1E800BF1 = vectorNormalize((_id_4821E22D1E800BF1[0], _id_4821E22D1E800BF1[1], 0));
  _id_D9A4E368B3862C16 = 0.46631;
  _id_78ED320E488C3260 = height * _id_D9A4E368B3862C16;
  _id_9309D9EF2E527FFF = _id_78ED320E488C3260 * _id_4821E22D1E800BF1;
  _id_A7C61B8EEA2709C3 = _id_9309D9EF2E527FFF + (0, 0, height);
  return _id_EEFE5EC3AECF7FA3 + _id_A7C61B8EEA2709C3;
}

_id_79EB95C7588F2191(_id_91BE2B7482F940BA) {
  _id_C74535E72311F8B0 = _id_91BE2B7482F940BA - self getEye();
  return _id_41A2827FB8521C44(_id_C74535E72311F8B0);
}

_id_41A2827FB8521C44(_id_FDEF162DAF80093B) {
  _id_C7086D1AD1CBD95D = 0.939693;
  return vectordot(vectorNormalize(_id_FDEF162DAF80093B), (0, 0, 1)) <= _id_C7086D1AD1CBD95D;
}

_id_AC55A70C78EC6AA5() {
  _id_26555D95DC188E56 = self._id_38DF06A438DF2608 - self.origin;
  velocity = self getvelocity();
  _id_1A094E3A2254B084 = abs(_id_26555D95DC188E56[2]);
  _id_87511E2908A85FE2 = abs(velocity[2]);

  if(_id_87511E2908A85FE2 > 50 && _id_1A094E3A2254B084 > 200) {
    _id_4CF0E4661298ED8A = _id_1A094E3A2254B084 / _id_87511E2908A85FE2;
    _id_5C530F8B9AFD0804 = length2d(velocity);
    _id_3840F75FD5FC4336 = length2d(_id_26555D95DC188E56);

    if(_id_5C530F8B9AFD0804 < 200)
      _id_5C530F8B9AFD0804 = 700;

    _id_8105AF709F0ADC35 = _id_3840F75FD5FC4336 / _id_5C530F8B9AFD0804;

    if(_id_4CF0E4661298ED8A < _id_8105AF709F0ADC35 && _id_4CF0E4661298ED8A > 1.0 && _id_3840F75FD5FC4336 > 0) {
      _id_2127D880E420797F = _id_5C530F8B9AFD0804 * (_id_4CF0E4661298ED8A - 1.0) / 2.0;
      _id_365B4B90D1E6A26C = _func_30DDBFD5E5E2A771(self.origin, velocity, self._id_38DF06A438DF2608, _id_2127D880E420797F, 1.0, 200, 700);

      if(isDefined(_id_365B4B90D1E6A26C)) {
        self._id_38DF06A438DF2608 = _id_365B4B90D1E6A26C;
        return 1;
      }
    }
  }

  return 0;
}

_id_D0539E08120FCB08() {
  _id_F42D549E3BE7E8A1();
  _id_9DD97FD712F1F9DE();
}

_id_F42D549E3BE7E8A1() {
  if(level.br_circle.circleindex > 0 && istrue(level.circleclosing) && !_id_2695A20D4011076D::ispointincurrentsafecircle(self._id_38DF06A438DF2608))
    self._id_38DF06A438DF2608 = _id_2695A20D4011076D::getrandompointinsafecircle();
}

_id_9DD97FD712F1F9DE() {
  if(!isDefined(self._id_18B21E1E1191BCEA) || gettime() < self._id_18B21E1E1191BCEA) {
    return;
  }
  _id_5A131F8F7A5ADD85 = 1000;
  self._id_18B21E1E1191BCEA = gettime() + _id_5A131F8F7A5ADD85;
  _id_B57907E360347347 = 800;
  _id_94264830825789E8 = 900;
  _id_364D2E6C896F4667 = _id_B57907E360347347 * 2;
  _id_74005C948F0BEF90 = _id_B57907E360347347 * _id_B57907E360347347;
  _id_23788B3A59F98F59 = _id_94264830825789E8 * _id_94264830825789E8;
  _id_E6C45DAD3F36FCF0 = _id_364D2E6C896F4667 * _id_364D2E6C896F4667;
  _id_6D622E482D3D314D = [];
  _id_A871590CB205E828 = [];
  _id_3C58660908436303 = undefined;

  foreach(player in level.players) {
    if(player.team == self.team || player isskydiving() || !_id_40034C2FAF09A87B(player)) {
      continue;
    }
    distsq = distance2dsquared(player.origin, self._id_38DF06A438DF2608);

    if(distsq <= _id_E6C45DAD3F36FCF0) {
      if(distsq <= _id_74005C948F0BEF90) {
        _id_6D622E482D3D314D[_id_6D622E482D3D314D.size] = player.origin;

        if(!isDefined(_id_3C58660908436303) || distsq < _id_3C58660908436303)
          _id_3C58660908436303 = distsq;

        continue;
      }

      _id_A871590CB205E828[_id_A871590CB205E828.size] = player.origin;
    }
  }

  if(_id_6D622E482D3D314D.size == 0) {
    return;
  }
  if(_id_6D622E482D3D314D.size == 1) {
    _id_BCD3907D1BEE5B81 = _id_6D622E482D3D314D[0];
    _id_06A3A1033FFC2699 = self._id_38DF06A438DF2608 - _id_BCD3907D1BEE5B81;

    if(length2dsquared(_id_06A3A1033FFC2699) < 10)
      _id_06A3A1033FFC2699 = _id_2695A20D4011076D::getdangercircleorigin() - _id_BCD3907D1BEE5B81;

    _id_06A3A1033FFC2699 = _func_767CEA82B001F645(_id_06A3A1033FFC2699) * _id_94264830825789E8;
    _id_6C53D859D582A421 = _id_BCD3907D1BEE5B81 + _id_06A3A1033FFC2699;

    if(_id_2695A20D4011076D::ispointincurrentsafecircle(_id_6C53D859D582A421)) {
      _id_6C53D859D582A421 = scripts\common\utility::groundpos((_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], self.origin[2]));

      if(isDefined(_id_6C53D859D582A421)) {
        _id_6C53D859D582A421 = getclosestpointonnavmesh(_id_6C53D859D582A421);

        if(isDefined(_id_6C53D859D582A421)) {
          foreach(origin in _id_A871590CB205E828) {
            if(distance2dsquared(origin, _id_6C53D859D582A421) <= _id_3C58660908436303)
              return;
          }

          self._id_38DF06A438DF2608 = _id_6C53D859D582A421;
        }
      }
    }

    return;
  }

  _id_3220296428C5AC4D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D622E482D3D314D.size - 1; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_6D622E482D3D314D.size; _id_AC0E5C4AC96AAA41++) {
      _id_B1A9B1030275146C = (_id_6D622E482D3D314D[_id_AC0E594AC96AA3A8][0], _id_6D622E482D3D314D[_id_AC0E594AC96AA3A8][1], 0);
      _id_B1A9B40302751B05 = (_id_6D622E482D3D314D[_id_AC0E5C4AC96AAA41][0], _id_6D622E482D3D314D[_id_AC0E5C4AC96AAA41][1], 0);
      _id_7040F2F2A3D4BEFE = _id_B1A9B40302751B05 - _id_B1A9B1030275146C;
      _id_7040EFF2A3D4B865 = 0.5 * _id_7040F2F2A3D4BEFE;
      _id_7038F4F2A3CCD7B6 = (-1 * _id_7040EFF2A3D4B865[1], _id_7040EFF2A3D4B865[0], 0);
      _id_7038F4F2A3CCD7B6 = _func_767CEA82B001F645(_id_7038F4F2A3CCD7B6) * sqrt(_id_23788B3A59F98F59 - length2dsquared(_id_7040EFF2A3D4B865));
      _id_3220296428C5AC4D[_id_3220296428C5AC4D.size] = _id_B1A9B1030275146C + _id_7040EFF2A3D4B865 + _id_7038F4F2A3CCD7B6;
      _id_3220296428C5AC4D[_id_3220296428C5AC4D.size] = _id_B1A9B1030275146C + _id_7040EFF2A3D4B865 - _id_7038F4F2A3CCD7B6;
    }
  }

  _id_6DFF6BE8C8798910 = undefined;
  _id_366212EA1A52E19B = undefined;
  _id_3AAE82B8DAC4E50E = 0;

  foreach(_id_221FD849D726170C in _id_3220296428C5AC4D) {
    if(!_id_2695A20D4011076D::ispointincurrentsafecircle(_id_221FD849D726170C)) {
      continue;
    }
    _id_FAC4E1AA13AA4D48 = 0;

    foreach(origin in _id_6D622E482D3D314D) {
      if(distance2dsquared(origin, _id_221FD849D726170C) <= _id_74005C948F0BEF90) {
        _id_FAC4E1AA13AA4D48 = 1;
        break;
      }
    }

    if(_id_FAC4E1AA13AA4D48) {
      continue;
    }
    _id_445FFD719165EB75 = undefined;

    foreach(origin in _id_A871590CB205E828) {
      distsq = distance2dsquared(origin, _id_221FD849D726170C);

      if(!isDefined(_id_445FFD719165EB75) || distsq < _id_445FFD719165EB75)
        _id_445FFD719165EB75 = distsq;

      if(_id_445FFD719165EB75 <= _id_3C58660908436303) {
        break;
      }
    }

    if(!isDefined(_id_445FFD719165EB75) || _id_445FFD719165EB75 > _id_74005C948F0BEF90) {
      _id_6DFF6BE8C8798910 = _id_221FD849D726170C;
      break;
    } else if(_id_445FFD719165EB75 <= _id_3C58660908436303)
      continue;
    else if(!isDefined(_id_366212EA1A52E19B) || _id_445FFD719165EB75 > _id_3AAE82B8DAC4E50E) {
      _id_366212EA1A52E19B = _id_221FD849D726170C;
      _id_3AAE82B8DAC4E50E = _id_445FFD719165EB75;
    }
  }

  _id_A72A1923FC04F151 = scripts\engine\utility::_id_53C4C53197386572(_id_6DFF6BE8C8798910, _id_366212EA1A52E19B);

  if(isDefined(_id_A72A1923FC04F151)) {
    _id_6C53D859D582A421 = scripts\common\utility::groundpos((_id_A72A1923FC04F151[0], _id_A72A1923FC04F151[1], self.origin[2]));

    if(isDefined(_id_6C53D859D582A421)) {
      _id_6C53D859D582A421 = getclosestpointonnavmesh(_id_6C53D859D582A421);

      if(isDefined(_id_6C53D859D582A421))
        self._id_38DF06A438DF2608 = _id_6C53D859D582A421;
    }
  }
}

_id_4473B5AF345C0B75(_id_EDED8B6C3565A24C) {
  _id_75BB4DA43489D9AE = distance2d(self.origin, self._id_38DF06A438DF2608);
  _id_E5DA52AE39BE43F3 = 1000;
  _id_E5FEF95B22EEC246 = 350;

  if(_id_75BB4DA43489D9AE < _id_E5DA52AE39BE43F3 && _id_EDED8B6C3565A24C > _id_E5FEF95B22EEC246) {
    self botpressbutton("cut_chute");
    _id_AA17A2B26EAF935F = 10000;
    endtime = gettime() + _id_AA17A2B26EAF935F;

    while(gettime() < endtime) {
      _id_D0539E08120FCB08();
      _id_19ED8A8A2A03E81A = 50;
      _id_D459F6D98BFB8AAD = _id_82DC476C43087820();
      _id_C6F79A0DCB0ACA65 = self.origin[2] - self._id_38DF06A438DF2608[2];

      if(_id_C6F79A0DCB0ACA65 < _id_E5FEF95B22EEC246 && self isparachuting() || _id_D459F6D98BFB8AAD < _id_19ED8A8A2A03E81A) {
        break;
      }

      _id_6A8DA31C699EF658 = 1;
      _id_B8996303B685A203 = 800;
      gravity = getdvarint("bg_gravity", _id_B8996303B685A203);
      velocity = self getvelocity();
      _id_966B732F6569A932 = abs(velocity[2]) * _id_6A8DA31C699EF658 + gravity * _id_6A8DA31C699EF658 * _id_6A8DA31C699EF658 * 0.5;
      _id_EF86AB5709584341 = max(abs(velocity[2]) * _id_6A8DA31C699EF658, _id_E5FEF95B22EEC246);
      _id_4E25DDB1D88D3B34 = randomfloat(1) > 0.1;

      if(!self isparachuting() && _id_D459F6D98BFB8AAD < _id_966B732F6569A932)
        self botpressbutton("jump");
      else if(self _meth_3C6BB30AE7106B7A() && _id_D459F6D98BFB8AAD > _id_EF86AB5709584341 && _id_4E25DDB1D88D3B34)
        self botpressbutton("cut_chute");

      _id_C43469E7A5AE4BA4(self._id_38DF06A438DF2608, 0.05);
      _id_237D4AB7B21367F0 = max(abs(velocity[2]), 0.1);
      _id_642A9B3CE402EC00 = _id_C6F79A0DCB0ACA65 / _id_237D4AB7B21367F0;
      _id_75BB4DA43489D9AE = distance2d(self.origin, self._id_38DF06A438DF2608);
      _id_4A1FB03882E4E567 = _id_75BB4DA43489D9AE / _id_642A9B3CE402EC00;
      _id_734A884DF1A36225 = self._id_38DF06A438DF2608 - self.origin;
      _id_734A884DF1A36225 = vectorNormalize((_id_734A884DF1A36225[0], _id_734A884DF1A36225[1], 0));
      _id_3E1F9C45395E389F = _id_734A884DF1A36225 * _id_4A1FB03882E4E567;
      _id_F0D4F34E58368F52 = _id_3E1F9C45395E389F - velocity;
      _id_B2BEE1AED960F257 = vectortoangles(vectorNormalize(_id_F0D4F34E58368F52));
      self botsetscriptmove(_id_B2BEE1AED960F257[1], 0.05, 1);
      wait 0.05;
    }
  }
}

_id_82DC476C43087820() {
  _id_C1D1FC4D9D46438D = -25000;
  groundpos = scripts\engine\utility::drop_to_ground(self.origin, 0, _id_C1D1FC4D9D46438D);

  if(isDefined(groundpos))
    return self.origin[2] - groundpos[2];

  return 0;
}

_id_916E2512538553DB() {
  self notify("bot_delay_give_loadout");
  self endon("bot_delay_give_loadout");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_9641FF6635273009 = getdvarint("dvar_B18793F70E0F6B34", 30);
  wait(_id_9641FF6635273009);
  dist = getdvarint("dvar_3DA4EFD986F095DE", 3900);

  while(!self._id_AB5F5270CB22E3C8 && !scripts\mp\utility\player::isinlaststand(self)) {
    if(!_id_A094B75E2AB2C597(dist) && !_id_B74CF5EB822312CB() && !_id_DA84567CDA38847E()) {
      _id_0532C9AA14C794FF(_id_3032314D524A3487());
      return;
    }

    wait 1;
  }
}

_id_3032314D524A3487() {
  if(!isDefined(level.br_circle._id_5B8569581E64D55A))
    return level.br_level._id_61321B51908D55CB;

  if(!isDefined(level.br_level._id_67BA7C3C6B03A843)) {
    level.br_level._id_67BA7C3C6B03A843 = 0;

    for(circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount; circleindex++) {
      level.br_level._id_67BA7C3C6B03A843 = level.br_level._id_67BA7C3C6B03A843 + level.br_level.br_circleclosetimes[circleindex];
      level.br_level._id_67BA7C3C6B03A843 = level.br_level._id_67BA7C3C6B03A843 + level.br_level.br_circledelaytimes[circleindex];
    }
  }

  _id_027A51444298629D = (gettime() - level.br_circle._id_5B8569581E64D55A) / 1000.0;

  if(_id_027A51444298629D < level.br_level._id_67BA7C3C6B03A843 * 0.4)
    return level.br_level._id_61321B51908D55CB;
  else
    return level.br_level._id_61321C51908D57FE;
}

_id_A094B75E2AB2C597(_id_0667B3EEF65D8914) {
  radiussq = squared(_id_0667B3EEF65D8914);

  foreach(player in level.players) {
    if(_id_40034C2FAF09A87B(player)) {
      if(distancesquared(self.origin, player.origin) <= radiussq)
        return 1;
    }
  }

  return 0;
}

_id_0532C9AA14C794FF(table) {
  if(istrue(self._id_AB5F5270CB22E3C8)) {
    return;
  }
  self._id_AB5F5270CB22E3C8 = 1;
  _id_91774B01BC741D01(table);
}

_id_91774B01BC741D01(table) {
  if(_id_2CEDCC356F1B9FC8::_id_F5446040A93792C3()) {
    return;
  }
  _id_07D958726E11B327 = scripts\mp\class::_id_DF2933F96D726D71(table);
  _id_1A0FE414F9014246 = randomintrange(0, _id_07D958726E11B327);
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::_id_1D52554D28B51CBC(struct, _id_1A0FE414F9014246, table);

  if(self.class == "gamemode")
    scripts\mp\class::loadout_updateclassgamemode(struct, self.class);

  _id_E2154DBDE4BD1CAC = strtok(struct.loadoutprimary, "|");
  struct.loadoutprimary = _id_E2154DBDE4BD1CAC[0];
  _id_63CBF0BE53790618 = strtok(struct.loadoutsecondary, "|");
  struct.loadoutsecondary = _id_63CBF0BE53790618[0];
  struct = scripts\mp\class::loadout_updateclass(struct, "juggernaut");

  if(isDefined(_id_E2154DBDE4BD1CAC[1])) {
    _id_1B47EC827F34BD5B = _id_8673B301658F7E88(struct.loadoutprimary, _id_E2154DBDE4BD1CAC[1]);

    if(isDefined(_id_1B47EC827F34BD5B)) {
      struct.loadoutprimaryfullname = _id_1B47EC827F34BD5B;
      struct.loadoutprimaryobject = makeweaponfromstring(struct.loadoutprimaryfullname);
    }
  }

  if(isDefined(_id_63CBF0BE53790618[1])) {
    _id_1B47EC827F34BD5B = _id_8673B301658F7E88(struct.loadoutsecondary, _id_63CBF0BE53790618[1]);

    if(isDefined(_id_1B47EC827F34BD5B)) {
      struct.loadoutsecondaryfullname = _id_1B47EC827F34BD5B;
      struct.loadoutsecondaryobject = makeweaponfromstring(struct.loadoutsecondaryfullname);
    }
  }

  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "juggernaut", 1, 1);
  self switchtoweapon(self.primaryweapons[0]);
  scripts\mp\class::loadout_updateplayerkillstreaks(struct, "juggernaut");
}

_id_8673B301658F7E88(_id_5C3F9357F11D2223, rarity) {
  foreach(fullweaponname, _id_6180DA62AD446599 in level.br_pickups.br_weapontoscriptable) {
    if(issubstr(fullweaponname, _id_5C3F9357F11D2223) && issubstr(_id_6180DA62AD446599, rarity))
      return fullweaponname;
  }

  if(scripts\mp\utility\game::getsubgametype() != "aladdin") {}

  return undefined;
}

_id_5B54ECC3B227F84D() {
  _id_00CEBA6EC7E8CA50 = "classtable:classtable_br_bot_loadouts_airdrop_" + self.difficulty;
  _id_91774B01BC741D01(_id_00CEBA6EC7E8CA50);
  return 1;
}

_id_084930089AF3D03B(_id_7BF0BA85EC52E893) {
  if(_id_7BF0BA85EC52E893)
    level endon("prematch_over");
  else
    self notify("start_combat");

  _id_59FF79D681BB860C::_id_142B713A2846F9AC("Mind");
  self botsetflag("enable_deploy_parachute", 1);
  _id_0D74AE0B4AA21186::_id_555C24CBDE8F72C6();

  for(;;) {
    if(getdvarint("dvar_40D69A9ED755F536", 0))
      _id_AB1937128F48283F();

    _id_0D74AE0B4AA21186::update();
  }
}

_id_AB1937128F48283F() {
  if(_id_1E4A61DB11011446::_id_72CE5F47DA0F5661() && !_id_26CCBFE3954CACF4::_id_6ECC7CD453466014() && self botgetdifficulty() == "recruit") {
    if(_id_C4053E29135C5D27()) {
      self botsetdifficulty("regular");
      _id_8771893F1BCB49BB(self, "regular");
    }
  }
}

kickplayer(_id_891A45DDC315B75E, _id_F0F6D13C70D13C4F) {
  if(!isDefined(_id_891A45DDC315B75E))
    _id_891A45DDC315B75E = "kickout";

  _id_72AF5A878A9D3397::_id_B1C37E649A5CD380(_id_891A45DDC315B75E, _id_F0F6D13C70D13C4F);
  self._id_06A91D0E80CC504E = _id_891A45DDC315B75E == "uibot";
  kick(self getentitynumber());
}

_id_B74CF5EB822312CB(_id_D0EF19BB4272812A) {
  foreach(player in level.players) {
    if(istrue(_id_D0EF19BB4272812A) && self.team == player.team) {
      continue;
    }
    if(_id_40034C2FAF09A87B(player)) {
      _id_0C907D6A55798B4E = anglesToForward(player.angles);
      _id_87C3BE94EB77030F = self.origin - player.origin;

      if(vectordot(_id_87C3BE94EB77030F, _id_0C907D6A55798B4E) > 0) {
        if(player _id_5480D301BBDB5DA1(self))
          return 1;
      }
    }
  }

  return 0;
}

_id_16A5388D4963E316() {
  if(!isDefined(self._id_23DF2E87F39050F5) || self._id_23DF2E87F39050F5 != gettime()) {
    self._id_23DF2E87F39050F5 = gettime();
    self._id_0FFF6E27DEA20881 = _id_B74CF5EB822312CB();
  }

  return self._id_0FFF6E27DEA20881;
}

_id_DA84567CDA38847E() {
  foreach(player in level.players) {
    if(!isai(player)) {
      playertospectate = player _id_6489FCDFE6FA2E36::playergetspectatingplayer();

      if(isDefined(playertospectate) && playertospectate == self)
        return 1;
    }
  }

  return 0;
}

_id_5480D301BBDB5DA1(targetplayer) {
  return targetplayer sightconetrace(self getEye(), self) > 0;
}

_id_A9CBF557DC66D201() {
  return istrue(self.br_iseliminated);
}

_id_36FD4F80D95CD0C4(player) {
  return _id_59FF79D681BB860C::_id_DED80385EA7471DB(player) && !player _id_A9CBF557DC66D201() && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();
}

_id_40034C2FAF09A87B(player) {
  return _id_59FF79D681BB860C::isvalidplayer(player) && !isai(player);
}

_id_2CEE00BF93CE58E6(player) {
  return _id_59FF79D681BB860C::isvalidplayer(player) && isbot(player) && !player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014();
}

_id_056FB6EEA7E566A2(player) {
  return _id_59FF79D681BB860C::isvalidplayer(player) && !player isskydiving();
}

_id_81B00A2BA10C143A(type) {
  if(!istrue(level.br_armory_kiosk_enabled))
    return 0;

  _id_16EFCF27E6EFCBE8 = _id_4384ABBF498DF6A7::_id_601181692F53E4ED(type);

  if(!isDefined(_id_16EFCF27E6EFCBE8))
    return 0;

  return _id_7E52B56769FA7774::_id_81B00A2BA10C143A(_id_16EFCF27E6EFCBE8.ref);
}

_id_C4053E29135C5D27() {
  _id_0B8BBA9CCD960781 = getdvarint("dvar_946321D51F80B343", 3000);
  _id_C3F669F8CD557637 = _id_A0FBE39135AB0D35();
  _id_AE5632495DFCA986 = gettime() - _id_C3F669F8CD557637;
  return _id_AE5632495DFCA986 > _id_0B8BBA9CCD960781;
}

_id_A0FBE39135AB0D35() {
  _id_C3F669F8CD557637 = 0;

  if(isDefined(self.lastdamagedtime))
    _id_C3F669F8CD557637 = max(_id_C3F669F8CD557637, self.lastdamagedtime);

  if(isDefined(self._id_C826AB9D43C24233))
    _id_C3F669F8CD557637 = max(_id_C3F669F8CD557637, self._id_C826AB9D43C24233);

  if(!isai(self)) {
    _id_44F4FB2FDD683FFA = self._id_44F4FB2FDD683FFA;

    if(isDefined(_id_44F4FB2FDD683FFA._id_F315B15BF1BD4B5E))
      _id_C3F669F8CD557637 = max(_id_C3F669F8CD557637, _id_44F4FB2FDD683FFA._id_F315B15BF1BD4B5E);
  }

  return _id_C3F669F8CD557637;
}

_id_5F352FB76C54705C() {
  _id_AEA051C033B84A83 = undefined;
  _id_7A8B23E91AF57C28 = undefined;

  if(getdvarint("dvar_82BDE055B11E6698", 0)) {
    _id_AEA051C033B84A83 = _id_110FD2130C2ED1FE::_id_5F352FB76C54705C();
    _id_7A8B23E91AF57C28 = _id_6388860E9E2A83BD::_id_5F352FB76C54705C();
  } else {
    _id_AEA051C033B84A83 = _id_02BDEFC4B5300716::_id_5F352FB76C54705C();
    _id_7A8B23E91AF57C28 = _id_160D0F1B81840667::_id_5F352FB76C54705C();
  }

  return _id_AEA051C033B84A83 || istrue(_id_7A8B23E91AF57C28);
}

_id_0BBC2D6967287DC7(_id_2B7395B3855CE24F, _id_02F96C6A3FAD9912) {
  _id_5577636292591C8B = level.br_pickups.br_itemtype[_id_2B7395B3855CE24F];

  if(_id_2B7395B3855CE24F == "military_ammo_restock")
    _id_5577636292591C8B = "ammo_restock";

  switch (_id_5577636292591C8B) {
    case "ammo":
      return _id_7E52B56769FA7774::canholdammobox(_id_2B7395B3855CE24F);
    case "gear":
      return !scripts\cp_mp\gasmask::hasgasmask(self);
    case "health":
      return _id_5BA1E582607305E4("health", _id_2B7395B3855CE24F);
    case "revive":
      return !_id_2CEDCC356F1B9FC8::hasselfrevivetoken();
    case "lethal":
      return _id_5BA1E582607305E4("primary", _id_2B7395B3855CE24F, _id_02F96C6A3FAD9912);
    case "tactical":
      return _id_5BA1E582607305E4("secondary", _id_2B7395B3855CE24F, _id_02F96C6A3FAD9912);
    case "killstreak":
      if(!_id_7E52B56769FA7774::hasanykillstreak())
        return 1;
      else if(isDefined(_id_02F96C6A3FAD9912)) {
        _id_FC8AFB765C52482B = _id_02F96C6A3FAD9912._id_03A436BD812A2B86["killstreak"];
        _id_D1455A0DB0E3389E = level.br_pickups._id_838863C4848D4C26[self.streakdata.streaks[1].streakname];
        _id_82650800F1C44914 = scripts\engine\utility::ter_op(isDefined(_id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_D1455A0DB0E3389E]), _id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_D1455A0DB0E3389E], _id_FC8AFB765C52482B);
        _id_452A165D9F2F19B3 = scripts\engine\utility::ter_op(isDefined(_id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_2B7395B3855CE24F]), _id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_2B7395B3855CE24F], _id_FC8AFB765C52482B);
        return _id_452A165D9F2F19B3 > _id_82650800F1C44914;
      } else
        return 0;
    case "super":
      return _id_5BA1E582607305E4("super", _id_2B7395B3855CE24F, _id_02F96C6A3FAD9912);
    case "weapon":
      classname = level.br_lootiteminfo[_id_2B7395B3855CE24F].fullweaponobj.classname;
      _id_F8A42B1FC9705ECF = undefined;

      if(!isDefined(classname))
        _id_F8A42B1FC9705ECF = 0;
      else
        _id_F8A42B1FC9705ECF = classname == "pistol" || classname == "rocketlauncher";

      _id_B68C8DFAC38718AB = 0;
      currentprimaryweapon = self getcurrentprimaryweapon();
      _id_D8B029B01E855CFC = weaponclass(currentprimaryweapon);

      if(_id_D8B029B01E855CFC == "pistol" || _id_D8B029B01E855CFC == "melee")
        _id_B68C8DFAC38718AB = -1;
      else
        _id_B68C8DFAC38718AB = _id_7E52B56769FA7774::_id_96B5A34CD1572D60(currentprimaryweapon);

      _id_167E430A395B12BA = level.br_pickups.br_itemrarity[_id_2B7395B3855CE24F];
      _id_C946BB8BD070CC8B = _id_B68C8DFAC38718AB < _id_167E430A395B12BA;
      return !_id_F8A42B1FC9705ECF && _id_C946BB8BD070CC8B;
    case "cache":
      return 1;
    case "ammo_restock":
      return 1;
    case "plunder":
      return 1;
    case "tablet":
      return !_id_64ACB6CE534155B7::_id_7094C7010C5E3827(self.team);
  }

  return 0;
}

_id_5BA1E582607305E4(slot, _id_A1093166DE09E6B8, _id_02F96C6A3FAD9912) {
  _id_A79A5A265CAFAE46 = self.equipment[slot];

  if(!isDefined(_id_A79A5A265CAFAE46))
    return 1;

  _id_58F7650E8DEF9A65 = level.br_pickups.br_equipnametoscriptable[_id_A79A5A265CAFAE46];

  if(!isDefined(_id_58F7650E8DEF9A65))
    return 0;

  if(_id_58F7650E8DEF9A65 == _id_A1093166DE09E6B8) {
    _id_5324597EDFAFF57C = scripts\mp\equipment::getequipmentslotammo(slot);
    _id_B5CDF4D935E6AC13 = scripts\mp\equipment::getequipmentmaxammo(_id_A79A5A265CAFAE46);
    return _id_5324597EDFAFF57C < _id_B5CDF4D935E6AC13;
  } else if(isDefined(_id_02F96C6A3FAD9912)) {
    _id_5577636292591C8B = level.br_pickups.br_itemtype[_id_A1093166DE09E6B8];
    _id_FC8AFB765C52482B = _id_02F96C6A3FAD9912._id_03A436BD812A2B86[_id_5577636292591C8B];
    _id_82650800F1C44914 = scripts\engine\utility::ter_op(isDefined(_id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_58F7650E8DEF9A65]), _id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_58F7650E8DEF9A65], _id_FC8AFB765C52482B);
    _id_452A165D9F2F19B3 = scripts\engine\utility::ter_op(isDefined(_id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_A1093166DE09E6B8]), _id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_A1093166DE09E6B8], _id_FC8AFB765C52482B);
    return _id_452A165D9F2F19B3 > _id_82650800F1C44914;
  } else
    return 0;
}

ispointincurrentsafecircle(point) {
  circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
  circleradius = _id_2695A20D4011076D::getsafecircleradius();
  return scripts\engine\utility::ispointinsidecircle(point, circleorigin, circleradius);
}

_id_8B201BCCC0AA3695(point) {
  _id_EFC827705C52531E = 150;
  _id_265C780D8E6C9D91 = (point[0], point[1], 0) - (self.origin[0], self.origin[1], 0);
  _id_EAA942F06DE73823 = scripts\engine\math::anglebetweenvectors(anglesToForward(self.angles), _id_265C780D8E6C9D91);
  _id_79F69C15F3E2C3F5 = _id_EAA942F06DE73823 / _id_EFC827705C52531E;
  _id_C43469E7A5AE4BA4(point, _id_79F69C15F3E2C3F5);
  wait(_id_79F69C15F3E2C3F5);
}

_id_D1ACAD1EE42B2B2F(entity, _id_CC748B6D457627FE, _id_185569FEBC7F5481) {
  _id_2390DA28FA1AEC9B = randomintrange(_id_185569FEBC7F5481 * -1, _id_185569FEBC7F5481);
  self botsetscriptmove(entity.angles[1] + _id_2390DA28FA1AEC9B, _id_CC748B6D457627FE, 0.1);
  wait(_id_CC748B6D457627FE);
}

_id_6DD2DFEB41384764() {
  if(!_id_58BE75C518BF0D40::issquadmode())
    return 0;

  if(scripts\mp\utility\game::matchmakinggame())
    return _func_48DC7B5F7E9E4061();
  else
    return !getdvarint("dvar_D356A7876F773136", 0);
}

_id_8A0FA223B19E44F4(_id_B25F7BC9B6613CC9, _id_75AD6E9F04E92544, _id_330C401BD2801F95, _id_3B233CDE4ADF9CD0, _id_BEF59D5B603763B0, _id_6681CEBD53B80D74) {
  _id_9A2062C443CB9C3A = undefined;
  _id_0F599866086FF8BE = 0;

  if(istrue(_id_3B233CDE4ADF9CD0))
    _id_7DE0EFBF334063A9 = ::ispointincurrentsafecircle;
  else
    _id_7DE0EFBF334063A9 = _id_7E816FA0720D38A1::ispointincurrentcircle;

  foreach(_id_E6D7DE89AE05A160 in _id_B25F7BC9B6613CC9) {
    if(![[_id_7DE0EFBF334063A9]](_id_E6D7DE89AE05A160.origin)) {
      continue;
    }
    _id_5FFE906C9D39A37F = distance(self.origin, _id_E6D7DE89AE05A160.origin);
    _id_C7CBB0C4D50EAE12 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_5FFE906C9D39A37F, _id_75AD6E9F04E92544, _id_330C401BD2801F95);

    if(isDefined(_id_BEF59D5B603763B0)) {
      _id_7D9A6D00A336393B = _id_2695A20D4011076D::getmintimetillpointindangercircle(_id_E6D7DE89AE05A160.origin);
      _id_40F4B7920A0CA8A0 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_7D9A6D00A336393B, _id_BEF59D5B603763B0, _id_6681CEBD53B80D74);
      _id_C7CBB0C4D50EAE12 = _id_C7CBB0C4D50EAE12 + _id_40F4B7920A0CA8A0;
    }

    if(_id_C7CBB0C4D50EAE12 > _id_0F599866086FF8BE) {
      _id_0F599866086FF8BE = _id_C7CBB0C4D50EAE12;
      _id_9A2062C443CB9C3A = _id_E6D7DE89AE05A160;
    }
  }

  if(!isDefined(_id_9A2062C443CB9C3A))
    return undefined;

  _id_1F83DD662A0DC9DC = spawnStruct();
  _id_1F83DD662A0DC9DC.score = _id_0F599866086FF8BE;
  _id_1F83DD662A0DC9DC.target = _id_9A2062C443CB9C3A;
  return _id_1F83DD662A0DC9DC;
}

_id_813A1A6F2C5ABDDB(weaponobj, _id_6C8D21B2E54B2478) {
  ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);

  if(!isDefined(ammotype))
    return 0;

  _id_B76E538AEE4D17AA = !isDefined(self.br_ammo) || !isDefined(self.br_ammo[ammotype]) || !isDefined(level._id_E6EA72FC5E3FCD00[ammotype]);

  if(_id_B76E538AEE4D17AA)
    return 0;

  _id_156B27CC0DA0F727 = self.br_ammo[ammotype] + self getweaponammoclip(weaponobj);
  _id_AB0EE360900BCB85 = level._id_E6EA72FC5E3FCD00[ammotype];
  _id_49FFFC1CE970E26D = _id_156B27CC0DA0F727 / _id_AB0EE360900BCB85 > _id_6C8D21B2E54B2478;
  return _id_49FFFC1CE970E26D;
}

_id_1C51F7C46A848DDD() {
  return float(level.br_circle.circleindex) / (level.br_level.br_circledelaytimes.size - level.br_level.br_movingcirclecount);
}

_id_C38398385AFC10FC() {
  level waittill("player_spawned", player);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    _id_F4343E072926C2F9 = getdvarint("dvar_116700C9B39C1EBA", 0);
    level thread _id_F166B9F78BECA5E6(_id_F4343E072926C2F9);
  }
}

_id_F166B9F78BECA5E6(count) {
  _id_50ADE409B1E5EFCB = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= count; _id_AC0E594AC96AA3A8++) {
    _id_DD4614803231D30A = spawnStruct();
    _id_DD4614803231D30A.name = "";
    _id_50ADE409B1E5EFCB[_id_50ADE409B1E5EFCB.size] = _id_DD4614803231D30A;
  }

  level _id_59FF79D681BB860C::_id_7D92B857142DBDC6(_id_50ADE409B1E5EFCB, "autoassign", undefined, undefined, "spawned_bots");
}

_id_B5E22620A8778C4A(arena) {
  if(!isDefined(arena)) {
    return;
  }
  if(arena.arenaplayers.size < 2) {
    return;
  }
  _id_F7A309109C19A8EB = scripts\engine\utility::array_combine(arena.arenaplayers, arena.jailedplayers);

  foreach(player in _id_F7A309109C19A8EB) {
    if(!isbot(player))
      return;
  }

  foreach(player in _id_F7A309109C19A8EB) {
    if(player _id_DA84567CDA38847E())
      return;
  }

  winners = [];
  _id_93B3B06A17CC437B = [];
  _id_037E0FE1F4E33613 = arena.arenaplayers[scripts\engine\utility::ter_op(randomint(2) == 0, 0, 1)].team;

  foreach(player in arena.arenaplayers) {
    if(player.team == _id_037E0FE1F4E33613) {
      winners[winners.size] = player;
      continue;
    }

    _id_93B3B06A17CC437B[_id_93B3B06A17CC437B.size] = player;
  }

  foreach(_id_CB981323A7D441EA in _id_93B3B06A17CC437B)
  _id_CB981323A7D441EA dodamage(_id_CB981323A7D441EA.health + 1000, winners[0].origin, winners[0], winners[0], "MOD_RIFLE_BULLET", winners[0] getcurrentweapon());
}