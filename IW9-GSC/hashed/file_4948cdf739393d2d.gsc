/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4948cdf739393d2d.gsc
***********************************************/

_id_B6DB5C2031ED059A() {
  level endon("game_ended");

  if(getdvarint("dvar_64D5A12998E68C07", 1) != 1) {
    return;
  }
  setDvar("dvar_43AB4CE9FAA45ADD", 0);

  while(!isDefined(level.struct_class_names))
    waitframe();

  while(!isDefined(level._id_4E8126C3305A5431))
    waitframe();

  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();
  scripts\mp\flags::gameflaginit("fortress_system_init", 0);
  level._id_49A5D647639E781E = [];
  level._id_C7D1916B16F57D7B = [];
  level._id_F1073FBD45B59A06 = spawnStruct();
  level._id_F1073FBD45B59A06._id_224D6C29E9BB566B = [];
  _id_B8B841D5628094E5();
  level._id_45CA3CFB9DCA4F97 = 0;
  level._id_F1073FBD45B59A06._id_CE199E9DE0A90EC9 = getdvarint("dvar_0F9CE5651F5C8DC5", 0);
  _id_6DA7791BE58CC019();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("fortress", "acknowledge"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("fortress", "acknowledge")]]();
  else
    _id_06CE4CD468E93ECD();

  _id_64FAFA59ECA9CA33();
  _id_DE96257D602D3AD8();

  if(!isDefined(level._id_41670C1C65F3D3CF._id_D0497A684E847E4F))
    level._id_41670C1C65F3D3CF._id_D0497A684E847E4F = [];

  level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9["small"] = getdvarint("dvar_44C6B04F31CD85C2", 4);
  level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9["medium"] = getdvarint("dvar_153CEF3A49BCED1C", 7);
  level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9["large"] = getdvarint("dvar_B5A2DCE30D58A61E", 9);
  level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9["hero"] = getdvarint("dvar_489D69BE23C1889F", 13);
  level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9["hero_epic"] = getdvarint("dvar_D951DB3DDBC5F88D", 20);
  level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9["hero_disabled"] = getdvarint("dvar_489D69BE23C1889F", 8);
  level._id_F1073FBD45B59A06._id_6212AE7684246846["small"] = getdvarint("dvar_D058080352ECC66B", 1);
  level._id_F1073FBD45B59A06._id_6212AE7684246846["medium"] = getdvarint("dvar_BDF93D46F026FF4B", 2);
  level._id_F1073FBD45B59A06._id_6212AE7684246846["large"] = getdvarint("dvar_08318724C082EE73", 2);
  level._id_F1073FBD45B59A06._id_6212AE7684246846["hero"] = getdvarint("dvar_08318724C082EE73", 2);
  level._id_F1073FBD45B59A06._id_6212AE7684246846["hero_epic"] = getdvarint("dvar_08318724C082EE73", 2);
  level._id_F1073FBD45B59A06._id_6212AE7684246846["hero_disabled"] = getdvarint("dvar_08318724C082EE73", 1);
  level._id_F1073FBD45B59A06._id_AC0CF04E7AACFADF["small"] = getdvarint("dvar_0FEC8EA1A8159D32", 4);
  level._id_F1073FBD45B59A06._id_AC0CF04E7AACFADF["medium"] = getdvarint("dvar_760EC21FCD642F2C", 6);
  level._id_F1073FBD45B59A06._id_AC0CF04E7AACFADF["large"] = getdvarint("dvar_999086B0D702A14E", 8);
  level._id_F1073FBD45B59A06._id_AC0CF04E7AACFADF["hero"] = getdvarint("dvar_999086B0D702A14E", 8);
  level._id_F1073FBD45B59A06._id_AC0CF04E7AACFADF["hero_disabled"] = getdvarint("dvar_999086B0D702A14E", 4);
  level._id_F1073FBD45B59A06._id_5CD7132D90176250["small"] = getdvarint("dvar_29783938106118C0", 1);
  level._id_F1073FBD45B59A06._id_5CD7132D90176250["medium"] = getdvarint("dvar_64C0716B8B6937F2", 2);
  level._id_F1073FBD45B59A06._id_5CD7132D90176250["large"] = getdvarint("dvar_598ECA83D0E33998", 2);
  level._id_F1073FBD45B59A06._id_5CD7132D90176250["hero"] = getdvarint("dvar_D11C877BDB74184D", 2);
  level._id_F1073FBD45B59A06._id_5CD7132D90176250["hero_epic"] = getdvarint("dvar_F75FADD18816AB4F", 3);
  level._id_F1073FBD45B59A06._id_B450D0AB756E4716 = getdvarint("dvar_22E7107141C60D09", 7);
  level._id_F1073FBD45B59A06._id_5CD7132D90176250["hero_disabled"] = 0;
  level._id_F1073FBD45B59A06._id_33CF4079B4096EB8 = getdvarint("dvar_AD56D65B14EF47E5", 1);
  level._id_F1073FBD45B59A06._id_1BDF3AF6B78DC2CA = getdvarint("dvar_A4F3080295173C53", 2);
  level._id_447A5D19BA3B177A = getdvarint("dvar_9503D7933365675F", 1);
  setDvar("dvar_9D95D1671EEAF942", 0);
  level._id_59CFFB78293FE83C = spawnStruct();
  level._id_59CFFB78293FE83C._id_90CCD093DE8C8C55 = ::_id_4527248D0334A562;
  level._id_59CFFB78293FE83C.ondeath = ::_id_1CBDD3DB07BFF2D6;
  level._id_59CFFB78293FE83C._id_9E729433FD479F19 = ::_id_DE7803621D18C6A8;

  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89)
  _id_4E6DD86684152B17(_id_276AC5E84835EA87);

  level._id_F1073FBD45B59A06._id_F9CF165941D1A5BE = 1;
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("fortress", "spawn"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("fortress", "spawn")]]();
  else
    _id_3BB788D495B1C7A0();

  level thread _id_6D27F6675243F8BE();
  level._id_F1073FBD45B59A06._id_9B87FDB80920F442 = 1;
  scripts\mp\flags::gameflagset("fortress_system_init");
}

_id_3BB788D495B1C7A0() {
  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
    if(istrue(_id_276AC5E84835EA87.isactive)) {
      continue;
    }
    if(isDefined(_id_276AC5E84835EA87._id_B205D90302DA2F07) && isDefined(_id_276AC5E84835EA87._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B) && isDefined(level._id_B205D90302DA2F07[_id_276AC5E84835EA87._id_B205D90302DA2F07]["subAreas"][_id_276AC5E84835EA87._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1))
      _id_276AC5E84835EA87._id_737C25E5BCF0380D = level._id_B205D90302DA2F07[_id_276AC5E84835EA87._id_B205D90302DA2F07]["subAreas"][_id_276AC5E84835EA87._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;

    _id_276AC5E84835EA87._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_276AC5E84835EA87.origin);

    if(!_id_4EC4F39A2E1745F2(_id_276AC5E84835EA87))
      _id_2D916D4AE382A8EB(_id_276AC5E84835EA87);
  }

  _id_CBF0FEDF537CE343();

  if(istrue(level._id_F1073FBD45B59A06._id_CE199E9DE0A90EC9)) {
    foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_8A40FF9ED07BD5F3) {
      if(!scripts\engine\utility::array_contains(level._id_F1073FBD45B59A06._id_DF987907A483DF89, _id_276AC5E84835EA87)) {
        _id_EECB9FD7F5E8181B(_id_276AC5E84835EA87);
        _id_956A7FEEFD3A23AA(_id_276AC5E84835EA87);

        if(isDefined(_id_276AC5E84835EA87._id_B205D90302DA2F07) && isDefined(_id_276AC5E84835EA87._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B) && isDefined(level._id_B205D90302DA2F07[_id_276AC5E84835EA87._id_B205D90302DA2F07]["subAreas"][_id_276AC5E84835EA87._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1))
          _id_276AC5E84835EA87._id_737C25E5BCF0380D = level._id_B205D90302DA2F07[_id_276AC5E84835EA87._id_B205D90302DA2F07]["subAreas"][_id_276AC5E84835EA87._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;

        _id_2D916D4AE382A8EB(_id_276AC5E84835EA87);
      }
    }
  }
}

_id_956A7FEEFD3A23AA(_id_276AC5E84835EA87) {
  if(!isDefined(level._id_41670C1C65F3D3CF._id_D0497A684E847E4F))
    level._id_41670C1C65F3D3CF._id_D0497A684E847E4F = [];

  index = level._id_41670C1C65F3D3CF._id_D0497A684E847E4F.size;
  level._id_41670C1C65F3D3CF._id_D0497A684E847E4F[index] = spawnStruct();
  level._id_41670C1C65F3D3CF._id_D0497A684E847E4F[index]._id_13235D60C661E10B = 0;
  _id_276AC5E84835EA87._id_FDBE1A2317A6A37D = level._id_41670C1C65F3D3CF._id_D0497A684E847E4F[index];
}

_id_6DA7791BE58CC019() {
  _id_C910C1BB857A9D7F = scripts\engine\utility::getStructArray("fortress", "targetname");
  _id_8A40FF9ED07BD5F3 = [];

  foreach(_id_276AC5E84835EA87 in _id_C910C1BB857A9D7F) {
    _id_DA83589DC0B1BB68 = getclosestpointonnavmesh(_id_276AC5E84835EA87.origin);

    if(distance2dsquared(_id_DA83589DC0B1BB68, _id_276AC5E84835EA87.origin) < 1048576) {
      noteworthy = tolower(_id_276AC5E84835EA87.script_noteworthy);

      if(issubstr(noteworthy, "hero") || issubstr(noteworthy, "largetower")) {
        if(issubstr(noteworthy, "notacmap")) {
          _id_276AC5E84835EA87._id_C6CF0A05D2F9B5DF = 1;
          _id_276AC5E84835EA87._id_0C8C070D7375EF1E = "medium";
        } else {
          _id_276AC5E84835EA87._id_732DF8DB084AB0C5 = 1;
          _id_276AC5E84835EA87._id_0C8C070D7375EF1E = "hero";
        }

        _id_9F1E4A5ACAD09F4B(_id_276AC5E84835EA87);
      } else if(issubstr(noteworthy, "small"))
        _id_276AC5E84835EA87._id_0C8C070D7375EF1E = "small";
      else if(issubstr(noteworthy, "medium"))
        _id_276AC5E84835EA87._id_0C8C070D7375EF1E = "medium";
      else if(issubstr(noteworthy, "large"))
        _id_276AC5E84835EA87._id_0C8C070D7375EF1E = "large";
      else
        _id_276AC5E84835EA87._id_0C8C070D7375EF1E = "small";

      if(!isDefined(_id_276AC5E84835EA87.target))
        _id_276AC5E84835EA87._id_5683FB2485637C86 = 1;

      if(!isDefined(_id_276AC5E84835EA87._id_B205D90302DA2F07))
        _id_276AC5E84835EA87._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_276AC5E84835EA87.origin, 1);

      _id_8A40FF9ED07BD5F3[_id_8A40FF9ED07BD5F3.size] = _id_276AC5E84835EA87;
    }
  }

  level._id_F1073FBD45B59A06._id_8A40FF9ED07BD5F3 = _id_8A40FF9ED07BD5F3;
  level._id_F1073FBD45B59A06._id_E5F0869FEDD95408 = [];
}

_id_4D5A3497A81AAA2F(target) {
  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_8A40FF9ED07BD5F3) {
    if(_id_276AC5E84835EA87.target == target)
      return _id_276AC5E84835EA87;
  }

  return undefined;
}

_id_06CE4CD468E93ECD() {
  level._id_F1073FBD45B59A06._id_DF987907A483DF89 = [];
  level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1 = level._id_F1073FBD45B59A06._id_8A40FF9ED07BD5F3;
  _id_DD6DBE56BE1A77FE = _func_356AECA51EC05BC0();

  if(!isDefined(_id_DD6DBE56BE1A77FE)) {
    return;
  }
  foreach(target in _id_DD6DBE56BE1A77FE) {
    _id_276AC5E84835EA87 = _id_4D5A3497A81AAA2F(target);

    if(isDefined(_id_276AC5E84835EA87)) {
      _id_276AC5E84835EA87._id_6A9A1AEEAA7C25DF = "mainFortress";
      level._id_F1073FBD45B59A06._id_DF987907A483DF89[level._id_F1073FBD45B59A06._id_DF987907A483DF89.size] = _id_276AC5E84835EA87;
      level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1 = scripts\engine\utility::array_remove(level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1, _id_276AC5E84835EA87);
    }
  }
}

_id_EECB9FD7F5E8181B(_id_256C6B221030FB06, _id_0A18C0F0CAC2A223) {
  if(istrue(_id_256C6B221030FB06._id_5683FB2485637C86)) {
    return;
  }
  _id_55A8CD2462D707DC = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(_id_256C6B221030FB06.target, "targetname"), getEntArray(_id_256C6B221030FB06.target, "targetname"), _func_F159C10D5CF8F0B4(_id_256C6B221030FB06.target, "targetname"));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("fortress", "hideoutRemoveInvalidNodes"))
    _id_55A8CD2462D707DC = [[scripts\cp_mp\utility\script_utility::getsharedfunc("fortress", "hideoutRemoveInvalidNodes")]](_id_256C6B221030FB06, _id_55A8CD2462D707DC);

  _id_256C6B221030FB06._id_2EF873E30A270BCF = [];
  _id_256C6B221030FB06._id_8ADD3FA98E073CE1 = [];
  _id_256C6B221030FB06._id_4E8126C3305A5431 = [];
  _id_256C6B221030FB06._id_E2CD8AA8B46D18AC = [];
  _id_256C6B221030FB06._id_84B0EF6BDDD2907A = [];
  _id_256C6B221030FB06._id_511459D6509633B1 = [];
  _id_256C6B221030FB06._id_DE77472DB7BDD0EC = [];
  _id_256C6B221030FB06._id_6B52C9E8E4FA1496 = [];
  _id_256C6B221030FB06._id_E3519A0E3ACBFEF3 = [];
  _id_256C6B221030FB06._id_CCDDCBADF3611B77 = _id_908EF13B806CC4C2();
  _id_256C6B221030FB06._id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(_id_256C6B221030FB06.origin, _id_256C6B221030FB06._id_B205D90302DA2F07);
  _id_256C6B221030FB06.flags = [];
  _id_256C6B221030FB06._id_E2958F412A7425C0 = [];
  _id_256C6B221030FB06._id_104F87CC51A1138D = [];
  _id_256C6B221030FB06.loadout = [];
  _id_256C6B221030FB06._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_256C6B221030FB06.origin);
  _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = [];
  _id_256C6B221030FB06.lootcaches = [];
  _id_256C6B221030FB06._id_CE9A81D514B212B7 = undefined;
  _id_256C6B221030FB06._id_AF7939A940E9BFAB = [];
  _id_256C6B221030FB06._id_AF7939A940E9BFAB["high"] = [];
  _id_256C6B221030FB06._id_AF7939A940E9BFAB["medium"] = [];
  _id_256C6B221030FB06._id_AF7939A940E9BFAB["low"] = [];

  if(!isDefined(_id_256C6B221030FB06._id_732DF8DB084AB0C5) || !isDefined(_id_256C6B221030FB06._id_C6CF0A05D2F9B5DF)) {
    if(issubstr(_id_256C6B221030FB06.script_noteworthy, "hero")) {
      if(issubstr(_id_256C6B221030FB06.script_noteworthy, "noTacMap"))
        _id_256C6B221030FB06._id_C6CF0A05D2F9B5DF = 1;
      else
        _id_256C6B221030FB06._id_732DF8DB084AB0C5 = 1;
    }
  }

  foreach(node in _id_55A8CD2462D707DC) {
    if(!isDefined(node.script_noteworthy)) {
      continue;
    }
    if(!isDefined(node.angles))
      node.angles = (0, 0, 0);

    if(issubstr(node.script_noteworthy, "flag") && issubstr(node.script_noteworthy, "mayh")) {
      _id_256C6B221030FB06.flags[_id_256C6B221030FB06.flags.size] = node;
      continue;
    }

    if(issubstr(node.script_noteworthy, "boss") || issubstr(node.script_noteworthy, "minion")) {
      if(issubstr(node.script_noteworthy, "boss")) {
        node._id_F28F3885995A439D = _id_256C6B221030FB06;
        _id_256C6B221030FB06._id_E2958F412A7425C0[_id_256C6B221030FB06._id_E2958F412A7425C0.size] = node;
      }

      continue;
    }

    script_noteworthy = tolower(node.script_noteworthy);

    if(issubstr(script_noteworthy, "guard")) {
      if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() && _id_9886567FBAFCD11A(node.origin, (-790, 7085, 434), 64)) {
        continue;
      }
      _id_256C6B221030FB06._id_2EF873E30A270BCF[_id_256C6B221030FB06._id_2EF873E30A270BCF.size] = node;
      continue;
    } else if(issubstr(script_noteworthy, "spawnzone")) {
      struct = spawnStruct();
      struct.volume = node;
      struct._id_2EF873E30A270BCF = [];
      struct._id_FE8754B2FE7EB8EB = 0;

      if(issubstr(script_noteworthy, "high"))
        _id_256C6B221030FB06._id_AF7939A940E9BFAB["high"][_id_256C6B221030FB06._id_AF7939A940E9BFAB["high"].size] = struct;
      else if(issubstr(script_noteworthy, "medium"))
        _id_256C6B221030FB06._id_AF7939A940E9BFAB["medium"][_id_256C6B221030FB06._id_AF7939A940E9BFAB["medium"].size] = struct;
      else if(issubstr(script_noteworthy, "low"))
        _id_256C6B221030FB06._id_AF7939A940E9BFAB["low"][_id_256C6B221030FB06._id_AF7939A940E9BFAB["low"].size] = struct;

      continue;
    }

    switch (script_noteworthy) {
      case "guard_jugg":
        _id_256C6B221030FB06._id_8ADD3FA98E073CE1[_id_256C6B221030FB06._id_8ADD3FA98E073CE1.size] = node;
        break;
      case "lockme":
      case "lockMe":
        _id_8F7EDDC9C0864A1B = "fortress";

        if(isDefined(_id_0A18C0F0CAC2A223))
          _id_8F7EDDC9C0864A1B = _id_0A18C0F0CAC2A223;

        _id_256C6B221030FB06._id_E2CD8AA8B46D18AC = _id_57D3850A12CF1D8F::_id_AD1B6ACCBAAB404E(node, _id_256C6B221030FB06._id_E2CD8AA8B46D18AC, _id_8F7EDDC9C0864A1B, 0);
        break;
      case "lockMe_interior":
      case "lockme_interior":
        break;
      case "lockme_nounlock":
        _id_8F7EDDC9C0864A1B = "stuck";
        _id_256C6B221030FB06._id_84B0EF6BDDD2907A = _id_57D3850A12CF1D8F::_id_AD1B6ACCBAAB404E(node, _id_256C6B221030FB06._id_84B0EF6BDDD2907A, _id_8F7EDDC9C0864A1B, 0);
        break;
      case "ladder":
        _id_256C6B221030FB06._id_3085458C86D06F29[_id_256C6B221030FB06._id_3085458C86D06F29.size] = node;
        break;
      case "fortress_volume":
        _id_256C6B221030FB06._id_AA7C37B8B3EC1F46[_id_256C6B221030FB06._id_AA7C37B8B3EC1F46.size] = node;
        break;
      case "loadout":
        _id_256C6B221030FB06.loadout[_id_256C6B221030FB06.loadout.size] = node;
        break;
      case "music_intro_point":
        _id_256C6B221030FB06._id_DE77472DB7BDD0EC[_id_256C6B221030FB06._id_DE77472DB7BDD0EC.size] = node;
        break;
      case "firebarrel":
        _id_256C6B221030FB06._id_6B52C9E8E4FA1496[_id_256C6B221030FB06._id_6B52C9E8E4FA1496.size] = node;
        break;
      case "gaspuddle":
        _id_256C6B221030FB06._id_E3519A0E3ACBFEF3[_id_256C6B221030FB06._id_E3519A0E3ACBFEF3.size] = node;
        break;
      case "lootcache":
        _id_256C6B221030FB06.lootcaches[_id_256C6B221030FB06.lootcaches.size] = node;
        break;
      case "tacmaplocoverride":
      case "tacMapLocOverride":
        _id_256C6B221030FB06._id_CE9A81D514B212B7 = node;
        break;
      case "lockme_biobunker":
        _id_8F7EDDC9C0864A1B = "biobunker_fortress";
        _id_256C6B221030FB06._id_E2CD8AA8B46D18AC = _id_57D3850A12CF1D8F::_id_AD1B6ACCBAAB404E(node, _id_256C6B221030FB06._id_E2CD8AA8B46D18AC, _id_8F7EDDC9C0864A1B, 0);
        break;
      default:
        _id_256C6B221030FB06._id_104F87CC51A1138D[_id_256C6B221030FB06._id_104F87CC51A1138D.size] = node;
    }
  }

  if(!isDefined(_id_256C6B221030FB06._id_AA7C37B8B3EC1F46) || _id_256C6B221030FB06._id_AA7C37B8B3EC1F46.size == 0) {
    _id_8668CFB45844F507();
    _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = level._id_42D94681E15BBBDD;
    vol = scripts\engine\utility::getclosest(_id_256C6B221030FB06.origin, _id_256C6B221030FB06._id_AA7C37B8B3EC1F46);

    if(isDefined(vol) && isDefined(vol.targetname))
      _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = scripts\engine\utility::array_combine(getEntArray(vol.targetname, "targetname"), _func_F159C10D5CF8F0B4(vol.targetname, "targetname"));
    else
      _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = [vol];
  }

  _id_256C6B221030FB06._id_4E8126C3305A5431 = _id_AF107842F66082BA(_id_256C6B221030FB06.origin, _id_256C6B221030FB06._id_B205D90302DA2F07);
  _id_256C6B221030FB06._id_BCD9D5C8960BBEB5 = _id_E2B80B7FA8ACA2B0(_id_256C6B221030FB06.origin, _id_256C6B221030FB06._id_B205D90302DA2F07, _id_256C6B221030FB06._id_D1CF55B36FACF5A8, 1);
  _id_120270BD0A747A35::_id_B60B5AFFD510926C(_id_256C6B221030FB06, 1);
}

_id_64FAFA59ECA9CA33() {
  foreach(_id_6C01B37E33D16FD8 in level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1)
  _id_9A3E15573892C4A3(_id_6C01B37E33D16FD8);
}

_id_9A3E15573892C4A3(_id_256C6B221030FB06) {
  if(istrue(_id_256C6B221030FB06._id_5683FB2485637C86)) {
    return;
  }
  _id_55A8CD2462D707DC = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(_id_256C6B221030FB06.target, "targetname"), getEntArray(_id_256C6B221030FB06.target, "targetname"));
  _id_256C6B221030FB06._id_30DD991A898ECC38 = [];
  _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = [];
  _id_DA6C688620302099 = [];

  foreach(node in _id_55A8CD2462D707DC) {
    if(!isDefined(node.script_noteworthy)) {
      continue;
    }
    if(!isDefined(node.angles))
      node.angles = (0, 0, 0);

    script_noteworthy = tolower(node.script_noteworthy);

    if(issubstr(script_noteworthy, "window")) {
      _id_256C6B221030FB06._id_30DD991A898ECC38[_id_256C6B221030FB06._id_30DD991A898ECC38.size] = node;
      continue;
    }

    if(issubstr(script_noteworthy, "guard")) {
      _id_DA6C688620302099[_id_DA6C688620302099.size] = node;
      continue;
    }

    if(script_noteworthy == "fortress_volume")
      _id_256C6B221030FB06._id_AA7C37B8B3EC1F46[_id_256C6B221030FB06._id_AA7C37B8B3EC1F46.size] = node;
  }

  if(!isDefined(_id_256C6B221030FB06._id_AA7C37B8B3EC1F46) || _id_256C6B221030FB06._id_AA7C37B8B3EC1F46.size == 0) {
    _id_8668CFB45844F507();
    _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = level._id_42D94681E15BBBDD;
    vol = scripts\engine\utility::getclosest(_id_256C6B221030FB06.origin, _id_256C6B221030FB06._id_AA7C37B8B3EC1F46);

    if(isDefined(vol) && isDefined(vol.targetname))
      _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = scripts\engine\utility::array_combine(getEntArray(vol.targetname, "targetname"), _func_F159C10D5CF8F0B4(vol.targetname, "targetname"));
    else
      _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = [vol];
  }

  foreach(node in _id_DA6C688620302099) {
    if(_id_20F6E9317B1BAF3D(node.origin, _id_256C6B221030FB06)) {
      if(!isDefined(_id_256C6B221030FB06._id_52914617670842A1))
        _id_256C6B221030FB06._id_52914617670842A1 = [];

      _id_256C6B221030FB06._id_52914617670842A1[_id_256C6B221030FB06._id_52914617670842A1.size] = node;
    }
  }

  _id_256C6B221030FB06._id_AA7C37B8B3EC1F46 = undefined;
}

_id_DE96257D602D3AD8() {
  _id_819789CBD076311F = getdvarint("dvar_FC146A67CE24927C", 3);

  if(_id_819789CBD076311F <= 0) {
    return;
  }
  _id_E45D5F2D42BD0730 = getdvarint("dvar_A12A51B8C9C5FAFB", 8);
  _id_3E9FDF9A7C2DEE59 = 0;

  foreach(_id_6C01B37E33D16FD8 in level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1) {
    _id_6C01B37E33D16FD8._id_30DD991A898ECC38 = scripts\engine\utility::array_randomize(_id_6C01B37E33D16FD8._id_30DD991A898ECC38);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_819789CBD076311F; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_6C01B37E33D16FD8._id_30DD991A898ECC38[_id_AC0E594AC96AA3A8])) {
        glassradiusdamage(_id_6C01B37E33D16FD8._id_30DD991A898ECC38[_id_AC0E594AC96AA3A8].origin, 100, 64, 0);
        _id_3E9FDF9A7C2DEE59++;
      }

      if(_id_3E9FDF9A7C2DEE59 == _id_E45D5F2D42BD0730) {
        waitframe();
        _id_3E9FDF9A7C2DEE59 = 0;
      }
    }
  }
}

_id_8668CFB45844F507() {
  if(!isDefined(level._id_42D94681E15BBBDD)) {
    level._id_42D94681E15BBBDD = scripts\engine\utility::array_combine(getEntArray("fortress_volume", "script_noteworthy"), _func_F159C10D5CF8F0B4("fortress_volume", "script_noteworthy"));

    if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
      level._id_42D94681E15BBBDD = scripts\engine\utility::array_combine(level._id_42D94681E15BBBDD, _func_F159C10D5CF8F0B4("mediumWarehouse02", "script_noteworthy"));
      level._id_42D94681E15BBBDD = scripts\engine\utility::array_combine(level._id_42D94681E15BBBDD, _func_F159C10D5CF8F0B4("mediumOffice01", "script_noteworthy"));
      level._id_42D94681E15BBBDD = scripts\engine\utility::array_combine(level._id_42D94681E15BBBDD, _func_F159C10D5CF8F0B4("smallWarehousesmall01", "script_noteworthy"));
    }
  }
}

_id_AF107842F66082BA(origin, _id_171F90B9C4C76D44) {
  if(!isDefined(level._id_4E8126C3305A5431))
    waitframe();

  _id_4E8126C3305A5431 = [];
  _id_032CFA376D02A2C2 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_032CFA376D02A2C2 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["patrolPaths"];
  else
    _id_032CFA376D02A2C2 = level._id_4E8126C3305A5431;

  foreach(pathstruct in _id_032CFA376D02A2C2) {
    if(!pathstruct.claimed && distance2dsquared(origin, pathstruct.path[0].origin) < 6250000)
      _id_4E8126C3305A5431[_id_4E8126C3305A5431.size] = pathstruct;
  }

  return _id_4E8126C3305A5431;
}

_id_E2B80B7FA8ACA2B0(origin, _id_171F90B9C4C76D44, _id_D1CF55B36FACF5A8, _id_F283DDA5BAE047E9) {
  _id_BCD9D5C8960BBEB5 = [];
  _id_91018FAA607CFBB0 = [];

  if(isDefined(_id_D1CF55B36FACF5A8) && _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B != "orphan")
    _id_91018FAA607CFBB0 = _id_D1CF55B36FACF5A8._id_24A2CD19EED8F75D;

  if(istrue(_id_F283DDA5BAE047E9)) {
    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
      _id_91018FAA607CFBB0 = scripts\engine\utility::array_combine(_id_91018FAA607CFBB0, level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["subAreas"]["orphan"]._id_24A2CD19EED8F75D);
  }

  foreach(_id_782866E364DCD2EF in _id_91018FAA607CFBB0) {
    if(!istrue(_id_782866E364DCD2EF.spawned) && distance2dsquared(origin, _id_782866E364DCD2EF.origin) < 4000000)
      _id_BCD9D5C8960BBEB5[_id_BCD9D5C8960BBEB5.size] = _id_782866E364DCD2EF;
  }

  return sortbydistance(_id_BCD9D5C8960BBEB5, origin);
}

_id_BAEF4910ACEA00F0(origin, _id_9262F0F1AD57FEF7, _id_25A3E7E5699EC26B, _id_171F90B9C4C76D44) {
  if(istrue(_id_9262F0F1AD57FEF7))
    _id_8A40FF9ED07BD5F3 = level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1;
  else
    _id_8A40FF9ED07BD5F3 = level._id_F1073FBD45B59A06._id_8A40FF9ED07BD5F3;

  _id_CE5B743E3B2DD235 = [];

  if(istrue(_id_25A3E7E5699EC26B)) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

    foreach(_id_276AC5E84835EA87 in _id_8A40FF9ED07BD5F3) {
      if(isDefined(_id_276AC5E84835EA87._id_B205D90302DA2F07) && _id_276AC5E84835EA87._id_B205D90302DA2F07 == _id_171F90B9C4C76D44)
        _id_CE5B743E3B2DD235[_id_CE5B743E3B2DD235.size] = _id_276AC5E84835EA87;
    }

    if(_id_CE5B743E3B2DD235.size > 0)
      _id_8A40FF9ED07BD5F3 = _id_CE5B743E3B2DD235;
  }

  _id_8A40FF9ED07BD5F3 = sortbydistance(_id_8A40FF9ED07BD5F3, origin);
  return _id_8A40FF9ED07BD5F3[0];
}

_id_BBE42D7091BEDFC5(origin, _id_DE0600B92AD0F1D4, _id_9262F0F1AD57FEF7) {
  _id_BC6FCE51761A976D = _func_F6E735E018927744(_id_DE0600B92AD0F1D4);

  if(!isDefined(_id_BC6FCE51761A976D))
    return undefined;

  _id_55A8CD2462D707DC = [];

  foreach(target in _func_F6E735E018927744(_id_DE0600B92AD0F1D4)) {
    _id_276AC5E84835EA87 = _id_4D5A3497A81AAA2F(target);

    if(isDefined(_id_276AC5E84835EA87)) {
      if(isDefined(_id_9262F0F1AD57FEF7) && istrue(_id_9262F0F1AD57FEF7)) {
        continue;
      }
      _id_55A8CD2462D707DC[_id_55A8CD2462D707DC.size] = _id_276AC5E84835EA87;
    }
  }

  if(_id_55A8CD2462D707DC.size < 1)
    return undefined;

  _id_55A8CD2462D707DC = sortbydistance(_id_55A8CD2462D707DC, origin);
  return _id_55A8CD2462D707DC[0];
}

_id_287B1C363D0AFF09(_id_276AC5E84835EA87) {
  if(!isDefined(level._id_CBA5FA3B3B5130A1))
    level._id_CBA5FA3B3B5130A1 = 0;

  name = "fortressUniqueName" + level._id_CBA5FA3B3B5130A1;
  _id_276AC5E84835EA87._id_D389F1191E609479 = name;
  level._id_CBA5FA3B3B5130A1++;
}

_id_0DEC2A213EE64B9D(_id_276AC5E84835EA87, _id_9CDCC5E51658B7EF, _id_1283DACA8CCBB5E0) {
  _id_543E6EC06C4FFA97(_id_276AC5E84835EA87);
  _id_58A1836E68AC562F = _id_1283DACA8CCBB5E0;
  _id_287B1C363D0AFF09(_id_276AC5E84835EA87);
  _func_572838690D80D959(_id_276AC5E84835EA87._id_D389F1191E609479);
  _id_D95F081254349631 = 0;

  if(_id_276AC5E84835EA87._id_0C8C070D7375EF1E == "hero_epic")
    _id_D95F081254349631 = level._id_F1073FBD45B59A06._id_B450D0AB756E4716;

  if(istrue(level._id_4094A9C5B998313D) && istrue(_id_276AC5E84835EA87._id_933F9685674999FB))
    _id_D95F081254349631 = 0;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    scripts\mp\flags::gameflagwait("start_fortress_spawns");

  if(!istrue(_id_276AC5E84835EA87._id_A49AA0BA3A6824FF)) {
    foreach(_id_AFF03355D9684ED4 in _id_276AC5E84835EA87._id_8ADD3FA98E073CE1) {
      agent = _id_90BFD0310A78F7C9(_id_AFF03355D9684ED4, 0, _id_276AC5E84835EA87, _id_1283DACA8CCBB5E0);
      _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent, _id_276AC5E84835EA87._id_737C25E5BCF0380D);

      if(istrue(_id_9CDCC5E51658B7EF) && _id_20F6E9317B1BAF3D(_id_AFF03355D9684ED4.origin, _id_276AC5E84835EA87))
        _id_C1CA4693A6278BA6(agent);
    }

    if(isDefined(_id_276AC5E84835EA87._id_5B034A098FB968AD))
      _id_D68856E67750E167 = _id_276AC5E84835EA87._id_5B034A098FB968AD;
    else
      _id_D68856E67750E167 = level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9[_id_276AC5E84835EA87._id_0C8C070D7375EF1E];

    _id_E2480C89547BA47A = level._id_F1073FBD45B59A06._id_5CD7132D90176250[_id_276AC5E84835EA87._id_0C8C070D7375EF1E];

    if(istrue(level._id_4094A9C5B998313D) && istrue(_id_276AC5E84835EA87._id_933F9685674999FB))
      _id_E2480C89547BA47A = 0;

    _id_2EF873E30A270BCF = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_2EF873E30A270BCF);
    _id_C4CA84A5019A750B = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D68856E67750E167; _id_AC0E594AC96AA3A8++) {
      node = _id_2EF873E30A270BCF[_id_AC0E594AC96AA3A8];

      if(!isDefined(node)) {
        break;
      }

      if(_id_E2480C89547BA47A > 0 && _id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87)) {
        node.script_noteworthy = "guard_riotshield";
        node.agent_type = "topTier";
        _id_1283DACA8CCBB5E0 = 1;
        _id_E2480C89547BA47A--;
      } else if(_id_D95F081254349631 > 0) {
        _id_C4CA84A5019A750B = 1;
        _id_D95F081254349631--;
      }

      if(istrue(_id_276AC5E84835EA87._id_933F9685674999FB) && istrue(level._id_4094A9C5B998313D)) {
        if(scripts\engine\utility::mod(_id_AC0E594AC96AA3A8, 2) == 0)
          agent = _id_90BFD0310A78F7C9(node, issubstr(node.script_noteworthy, "stationary"), _id_276AC5E84835EA87, _id_1283DACA8CCBB5E0, istrue(_id_C4CA84A5019A750B), 1);
        else
          agent = _id_90BFD0310A78F7C9(node, issubstr(node.script_noteworthy, "stationary"), _id_276AC5E84835EA87, _id_1283DACA8CCBB5E0, istrue(_id_C4CA84A5019A750B), 2);
      } else
        agent = _id_90BFD0310A78F7C9(node, issubstr(node.script_noteworthy, "stationary"), _id_276AC5E84835EA87, _id_1283DACA8CCBB5E0, istrue(_id_C4CA84A5019A750B));

      if(isDefined(agent)) {
        if(istrue(_id_C4CA84A5019A750B)) {
          _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
          _id_C4CA84A5019A750B = 0;
        }

        if(istrue(_id_9CDCC5E51658B7EF) && _id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87))
          _id_C1CA4693A6278BA6(agent);
      }

      _id_1283DACA8CCBB5E0 = _id_58A1836E68AC562F;
    }
  } else {
    _id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"] = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"]);
    _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"] = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"]);
    _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"] = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"]);
    _id_CB3D902A4916E523 = [];

    foreach(zone in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"]) {
      zone._id_2EF873E30A270BCF = scripts\engine\utility::array_randomize(zone._id_2EF873E30A270BCF);
      _id_F25BB8724FFF3684 = scripts\engine\utility::array_slice(zone._id_2EF873E30A270BCF, 0, zone._id_FE8754B2FE7EB8EB);
      _id_CB3D902A4916E523 = scripts\engine\utility::array_combine(_id_CB3D902A4916E523, _id_F25BB8724FFF3684);

      if(zone._id_2EF873E30A270BCF.size < zone._id_FE8754B2FE7EB8EB) {}
    }

    foreach(zone in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"]) {
      zone._id_2EF873E30A270BCF = scripts\engine\utility::array_randomize(zone._id_2EF873E30A270BCF);
      _id_F25BB8724FFF3684 = scripts\engine\utility::array_slice(zone._id_2EF873E30A270BCF, 0, zone._id_FE8754B2FE7EB8EB);
      _id_CB3D902A4916E523 = scripts\engine\utility::array_combine(_id_CB3D902A4916E523, _id_F25BB8724FFF3684);

      if(zone._id_2EF873E30A270BCF.size < zone._id_FE8754B2FE7EB8EB) {}
    }

    foreach(zone in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"]) {
      zone._id_2EF873E30A270BCF = scripts\engine\utility::array_randomize(zone._id_2EF873E30A270BCF);
      _id_F25BB8724FFF3684 = scripts\engine\utility::array_slice(zone._id_2EF873E30A270BCF, 0, zone._id_FE8754B2FE7EB8EB);
      _id_CB3D902A4916E523 = scripts\engine\utility::array_combine(_id_CB3D902A4916E523, _id_F25BB8724FFF3684);

      if(zone._id_2EF873E30A270BCF.size < zone._id_FE8754B2FE7EB8EB) {}
    }

    _id_E2480C89547BA47A = level._id_F1073FBD45B59A06._id_5CD7132D90176250[_id_276AC5E84835EA87._id_0C8C070D7375EF1E];

    if(istrue(level._id_4094A9C5B998313D) && istrue(_id_276AC5E84835EA87._id_933F9685674999FB))
      _id_E2480C89547BA47A = 0;

    _id_CB3D902A4916E523 = scripts\engine\utility::array_randomize(_id_CB3D902A4916E523);
    _id_C4CA84A5019A750B = 0;

    foreach(node in _id_CB3D902A4916E523) {
      if(_id_E2480C89547BA47A > 0 && _id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87)) {
        node.script_noteworthy = "guard_riotshield";
        _id_1283DACA8CCBB5E0 = 1;
        _id_E2480C89547BA47A--;
      } else if(_id_D95F081254349631 > 0 && _id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87)) {
        _id_C4CA84A5019A750B = 1;
        _id_D95F081254349631--;
      }

      agent = _id_90BFD0310A78F7C9(node, issubstr(node.script_noteworthy, "stationary"), _id_276AC5E84835EA87, _id_1283DACA8CCBB5E0, istrue(_id_C4CA84A5019A750B));

      if(isDefined(agent)) {
        if(istrue(_id_C4CA84A5019A750B)) {
          _id_C7A4725D05BB7F22 = 1;

          if(!isagent(agent)) {
            aitype = level._id_879053468F168806[agent].aitype;

            if(issubstr(aitype, "tier2"))
              _id_C7A4725D05BB7F22 = 2;
            else if(issubstr(aitype, "tier3"))
              _id_C7A4725D05BB7F22 = 3;
          } else
            _id_C7A4725D05BB7F22 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");

          _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent, _id_C7A4725D05BB7F22);
          _id_C4CA84A5019A750B = 0;
        }

        if(istrue(_id_9CDCC5E51658B7EF) && _id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87))
          _id_C1CA4693A6278BA6(agent);
      }

      _id_1283DACA8CCBB5E0 = _id_58A1836E68AC562F;
    }
  }

  _id_2B9F49BC95A370D8 = level._id_F1073FBD45B59A06._id_6212AE7684246846[_id_276AC5E84835EA87._id_0C8C070D7375EF1E];
  _id_67776C6CCA58C904 = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_4E8126C3305A5431);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2B9F49BC95A370D8; _id_AC0E594AC96AA3A8++) {
    if(_id_67776C6CCA58C904.size <= 0) {
      break;
    }

    _id_E0C08758EB0006BE = _id_120270BD0A747A35::_id_1A2E58FFAAFB1D40(_id_67776C6CCA58C904);

    if(isDefined(_id_E0C08758EB0006BE)) {
      agent = _id_092FA32EE6185892(_id_E0C08758EB0006BE, _id_276AC5E84835EA87);

      if(istrue(_id_9CDCC5E51658B7EF) && _id_20F6E9317B1BAF3D(_id_E0C08758EB0006BE.origin, _id_276AC5E84835EA87))
        _id_C1CA4693A6278BA6(agent);
    }
  }

  _id_276AC5E84835EA87 notify("spawned_agents");
  _id_276AC5E84835EA87._id_698AB4F1074B4F37 = 1;
}

_id_4527248D0334A562(agent, _id_451A9D27D63C746B) {
  agent._id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B = _id_451A9D27D63C746B;
  _func_C36F897D56E28169(agent, agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_D389F1191E609479);
  _func_E812B7065161DA79(_id_451A9D27D63C746B, agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_D389F1191E609479);

  if(issubstr(agent.agent_type, "riotshield") && !istrue(agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_7BE8B486A10B3DE8))
    _id_B6FAE9E25CE5D86E(agent);
}

_id_93C1FC6CF16329F8(agent) {
  _func_C36F897D56E28169(agent._id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B, agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_D389F1191E609479);
  _func_E812B7065161DA79(agent, agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_D389F1191E609479);

  if(issubstr(agent.agent_type, "riotshield"))
    agent thread _id_70C8A3094CAB3D57(agent);
}

_id_DE7803621D18C6A8(struct, id) {
  _func_C36F897D56E28169(id, struct._id_276AC5E84835EA87._id_D389F1191E609479);
}

_id_1CBDD3DB07BFF2D6(agent, _id_6181DE250AFA5BB6) {
  if(isagent(agent)) {
    _id_A5DAF6A4BAF26AAF = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "agentStruct");

    if(isDefined(_id_A5DAF6A4BAF26AAF)) {
      _func_C36F897D56E28169(agent, _id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_D389F1191E609479);

      if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6) && isDefined(_id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87.contributingplayers) && !scripts\engine\utility::array_contains(_id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87.contributingplayers, _id_6181DE250AFA5BB6))
        _id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87.contributingplayers[_id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87.contributingplayers.size] = _id_6181DE250AFA5BB6;
    }
  } else if(isint(agent)) {
    info = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent);

    if(isDefined(info) && isDefined(info._id_A5DAF6A4BAF26AAF) && isDefined(info._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87))
      _func_C36F897D56E28169(agent, info._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_D389F1191E609479);
  }

  _id_371B4C2AB5861E62::_id_3EA1225BF6192343(agent, undefined);
  _id_371B4C2AB5861E62::_id_97FBD14BBCF19D9C(agent, "fortress_agentPostDormancy", ::_id_93C1FC6CF16329F8);
}

_id_543E6EC06C4FFA97(_id_276AC5E84835EA87) {
  if(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"].size + _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"].size + _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"].size <= 0) {
    return;
  }
  _id_276AC5E84835EA87._id_A49AA0BA3A6824FF = 1;
  _id_F2F08211E515A397 = scripts\engine\utility::array_combine_multiple([_id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"], _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"], _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"]]);

  foreach(zone in _id_F2F08211E515A397) {
    zone.tier = _id_3AF63EBAF6C4FFE4(zone.volume);
    zone.origin = zone.volume.origin;
  }

  foreach(_id_7D5ACB0650804B86 in _id_276AC5E84835EA87._id_2EF873E30A270BCF) {
    _id_2DC6F44641D0CBD3 = 0;

    foreach(zone in _id_F2F08211E515A397) {
      if(ispointinvolume(_id_7D5ACB0650804B86.origin, zone.volume)) {
        _id_7D5ACB0650804B86._id_0BA20D31F7B5CE32 = zone.tier;
        zone._id_2EF873E30A270BCF[zone._id_2EF873E30A270BCF.size] = _id_7D5ACB0650804B86;
        _id_2DC6F44641D0CBD3 = 1;
        break;
      }
    }

    if(_id_2DC6F44641D0CBD3) {
      continue;
    }
    _id_721403DDAC28AE96 = undefined;
    _id_42CA41C7DADAE0C0 = undefined;

    foreach(zone in _id_F2F08211E515A397) {
      dist = distance2dsquared(_id_7D5ACB0650804B86.origin, zone.volume.origin);

      if(!isDefined(_id_721403DDAC28AE96)) {
        _id_721403DDAC28AE96 = zone;
        _id_42CA41C7DADAE0C0 = dist;
        continue;
      }

      if(dist < _id_42CA41C7DADAE0C0) {
        _id_721403DDAC28AE96 = zone;
        _id_42CA41C7DADAE0C0 = dist;
      }
    }

    _id_7D5ACB0650804B86._id_0BA20D31F7B5CE32 = _id_721403DDAC28AE96.tier;
    _id_721403DDAC28AE96._id_2EF873E30A270BCF[_id_721403DDAC28AE96._id_2EF873E30A270BCF.size] = _id_7D5ACB0650804B86;
  }

  foreach(zone in _id_F2F08211E515A397)
  zone.volume delete();

  _id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"] = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"]);
  _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"] = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"]);
  _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"] = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"]);

  if(isDefined(_id_276AC5E84835EA87._id_5B034A098FB968AD))
    _id_D68856E67750E167 = _id_276AC5E84835EA87._id_5B034A098FB968AD;
  else
    _id_D68856E67750E167 = level._id_F1073FBD45B59A06._id_89CC4DE8832D0EA9[_id_276AC5E84835EA87._id_0C8C070D7375EF1E];

  _id_0548D72407774B1F = _id_D68856E67750E167 / _id_F2F08211E515A397.size;
  _id_9EA1D5BB680B2893 = 0;

  foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"]) {
    _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = _id_0548D72407774B1F + 1;
    _id_9EA1D5BB680B2893++;
  }

  foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"]) {
    _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = _id_0548D72407774B1F - 1;
    _id_9EA1D5BB680B2893--;
  }

  if(_id_9EA1D5BB680B2893 > 0) {
    foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"]) {
      if(_id_9EA1D5BB680B2893 > 0) {
        _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = _id_0548D72407774B1F - 0.5;
        _id_9EA1D5BB680B2893 = _id_9EA1D5BB680B2893 - 0.5;
        continue;
      }

      _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = _id_0548D72407774B1F;
    }
  }

  _id_15F3F5398F747F03 = undefined;
  _id_CF8CED66EA8C05BB = 0;

  foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"]) {
    _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = int(ceil(_id_22CEDF10372284DA._id_FE8754B2FE7EB8EB));
    _id_CF8CED66EA8C05BB = _id_CF8CED66EA8C05BB + _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB;

    if(!isDefined(_id_15F3F5398F747F03) || _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB < _id_15F3F5398F747F03)
      _id_15F3F5398F747F03 = _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB;
  }

  foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["low"]) {
    _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = int(floor(_id_22CEDF10372284DA._id_FE8754B2FE7EB8EB));

    if(_id_22CEDF10372284DA._id_FE8754B2FE7EB8EB <= 0)
      _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = 1;

    _id_CF8CED66EA8C05BB = _id_CF8CED66EA8C05BB + _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB;
  }

  _id_92711A544BE783D4 = undefined;

  foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["medium"]) {
    _id_8723D02F6DF13402 = int(ceil(_id_22CEDF10372284DA._id_FE8754B2FE7EB8EB));

    if(_id_8723D02F6DF13402 < _id_15F3F5398F747F03)
      _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = _id_8723D02F6DF13402;
    else
      _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = int(_id_22CEDF10372284DA._id_FE8754B2FE7EB8EB);

    if(!isDefined(_id_92711A544BE783D4) || _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB > _id_92711A544BE783D4)
      _id_92711A544BE783D4 = _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB;

    _id_CF8CED66EA8C05BB = _id_CF8CED66EA8C05BB + _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB;
  }

  if(_id_CF8CED66EA8C05BB > _id_D68856E67750E167) {
    foreach(_id_22CEDF10372284DA in _id_276AC5E84835EA87._id_AF7939A940E9BFAB["high"]) {
      if(_id_22CEDF10372284DA._id_FE8754B2FE7EB8EB - 1 > _id_92711A544BE783D4) {
        _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB = _id_22CEDF10372284DA._id_FE8754B2FE7EB8EB - 1;
        _id_CF8CED66EA8C05BB--;
      }

      if(_id_CF8CED66EA8C05BB <= _id_D68856E67750E167)
        return;
    }
  }
}

_id_3AF63EBAF6C4FFE4(volume) {
  if(issubstr(volume.script_noteworthy, "tier3"))
    return 3;
  else if(issubstr(volume.script_noteworthy, "tier2"))
    return 2;
  else if(issubstr(volume.script_noteworthy, "tier1"))
    return 1;
  else
    return -1;
}

_id_C1CA4693A6278BA6(agent) {
  if(!isDefined(agent)) {
    return;
  }
  if(isagent(agent))
    agent.ignoreall = 1;
  else if(isint(agent))
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "fortressAgent_setIgnoreAgentPostSpawn", ::_id_40448602AED19EB7);
}

_id_40448602AED19EB7() {
  agent = self;
  agent.ignoreall = 1;
}

_id_90BFD0310A78F7C9(node, _id_A784428198C5658B, _id_276AC5E84835EA87, _id_1283DACA8CCBB5E0, _id_15A8207A3C22904B, _id_737C25E5BCF0380D) {
  _id_6EF963F694FE22E0 = 0;
  _id_D00E2F0D8CE26377 = 0;
  _id_F1548C57038E1B7A = [];

  if(_id_20F6E9317B1BAF3D(node.origin, _id_276AC5E84835EA87) || isDefined(_id_276AC5E84835EA87.name) && isstring(_id_276AC5E84835EA87.name) && _id_276AC5E84835EA87.name == "oilfield")
    _id_D00E2F0D8CE26377 = 1;

  if(!istrue(_id_1283DACA8CCBB5E0) && (_id_D00E2F0D8CE26377 || _id_4EC4F39A2E1745F2(_id_276AC5E84835EA87))) {
    _id_5836C6D53A5F99A2 = scripts\engine\utility::array_combine(_id_276AC5E84835EA87._id_E67F0B2EA7AE69ED, _id_276AC5E84835EA87._id_8A055A821DDA7DA0);

    if(_id_5836C6D53A5F99A2.size == 0)
      _id_5836C6D53A5F99A2 = _id_276AC5E84835EA87._id_3288C473E8336AB4;
    else if(_id_5836C6D53A5F99A2.size < 6)
      _id_5836C6D53A5F99A2 = scripts\engine\utility::array_combine(_id_5836C6D53A5F99A2, _id_276AC5E84835EA87._id_3288C473E8336AB4);

    _id_5836C6D53A5F99A2 = scripts\engine\utility::array_randomize(_id_5836C6D53A5F99A2);
    _id_F1548C57038E1B7A = _id_120270BD0A747A35::_id_3A17F0CCDDC999B4(node.origin, _id_5836C6D53A5F99A2, 2, 256);

    if(_id_F1548C57038E1B7A.size > 0)
      _id_6EF963F694FE22E0 = 1;
  }

  node._id_4B0BAD4944A4CBC0 = 1;
  priority = "high";

  if(_id_4EC4F39A2E1745F2(_id_276AC5E84835EA87))
    priority = "high";

  tier = _id_276AC5E84835EA87._id_737C25E5BCF0380D;

  if(isDefined(_id_737C25E5BCF0380D))
    tier = _id_737C25E5BCF0380D;

  if(isDefined(node._id_0BA20D31F7B5CE32) && node._id_0BA20D31F7B5CE32 > 0)
    tier = node._id_0BA20D31F7B5CE32;

  if(istrue(_id_15A8207A3C22904B))
    tier = 3;

  _id_A42C3E0E1B2DC645 = _id_276AC5E84835EA87._id_A42C3E0E1B2DC645;

  if(!isDefined(_id_A42C3E0E1B2DC645))
    _id_A42C3E0E1B2DC645 = level._id_97718BB0CB314F6B;

  aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(node, undefined, undefined, undefined, tier, _id_A42C3E0E1B2DC645);
  groupname = _id_48814951E916AF89::_id_59CDFE39E161A336(node);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, priority, "fortressGuards", undefined, groupname, undefined, undefined, _id_276AC5E84835EA87._id_B205D90302DA2F07, _id_6EF963F694FE22E0);

  if(!isDefined(agent)) {
    return;
  }
  if(istrue(level._id_45CA3CFB9DCA4F97))
    level thread scripts\mp\utility\debug::drawsphere(node.origin, 128, 500, (0, 1, 0));

  _id_276AC5E84835EA87._id_FDBE1A2317A6A37D._id_13235D60C661E10B++;
  _id_A5DAF6A4BAF26AAF = spawnStruct();
  _id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  _id_A5DAF6A4BAF26AAF._id_90CCD093DE8C8C55 = ::_id_4527248D0334A562;
  _id_A5DAF6A4BAF26AAF.ondeath = ::_id_1CBDD3DB07BFF2D6;
  _id_A5DAF6A4BAF26AAF._id_9E729433FD479F19 = ::_id_DE7803621D18C6A8;

  if(isint(agent))
    _id_A5DAF6A4BAF26AAF._id_451A9D27D63C746B = agent;

  _id_371B4C2AB5861E62::_id_3EA1225BF6192343(agent, _id_A5DAF6A4BAF26AAF);
  _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "fortress_agentPostDormancy", ::_id_93C1FC6CF16329F8);
  _func_E812B7065161DA79(agent, _id_276AC5E84835EA87._id_D389F1191E609479);

  if(node.script_noteworthy == "guard_riotshield") {
    _id_EB4E83BDEB266116 = 32;

    if(!isint(agent)) {
      agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
      agent thread _id_70C8A3094CAB3D57(agent);
    }
  } else
    _id_EB4E83BDEB266116 = undefined;

  if(isagent(agent)) {
    if(_id_6EF963F694FE22E0)
      agent thread _id_120270BD0A747A35::_id_C7307D56A1A61172(agent, _id_F1548C57038E1B7A);
    else if(istrue(_id_A784428198C5658B))
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
    else
      agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, _id_EB4E83BDEB266116);
  } else if(isint(agent)) {
    if(_id_6EF963F694FE22E0)
      _id_120270BD0A747A35::_id_29B1F7F88B879860(agent, _id_F1548C57038E1B7A);
    else if(!istrue(_id_A784428198C5658B))
      _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, undefined, _id_EB4E83BDEB266116);
    else
      _id_120270BD0A747A35::_id_D1E130608E4F8487(agent);
  }

  return agent;
}

_id_092FA32EE6185892(pathstruct, _id_276AC5E84835EA87) {
  pathstruct._id_4B0BAD4944A4CBC0 = 1;

  if(!isDefined(pathstruct._id_B205D90302DA2F07))
    pathstruct._id_B205D90302DA2F07 = _id_276AC5E84835EA87._id_B205D90302DA2F07;

  _id_A42C3E0E1B2DC645 = _id_276AC5E84835EA87._id_A42C3E0E1B2DC645;

  if(!isDefined(_id_A42C3E0E1B2DC645))
    _id_A42C3E0E1B2DC645 = level._id_97718BB0CB314F6B;

  if(isDefined(pathstruct.path) && isDefined(pathstruct.path[0]) && !isDefined(pathstruct.path[0]._id_8E5A9B658FA525ED))
    pathstruct.path[0]._id_8E5A9B658FA525ED = _id_A42C3E0E1B2DC645;

  agents = _id_48814951E916AF89::_id_3DCF83BCEF7081BA(pathstruct, level._id_F1073FBD45B59A06._id_33CF4079B4096EB8, level._id_F1073FBD45B59A06._id_1BDF3AF6B78DC2CA, _id_276AC5E84835EA87, "medium", "fortressPatrols");

  if(!isDefined(agents))
    return agents;

  _id_276AC5E84835EA87._id_FDBE1A2317A6A37D._id_13235D60C661E10B = _id_276AC5E84835EA87._id_FDBE1A2317A6A37D._id_13235D60C661E10B + agents.size;
}

_id_2D916D4AE382A8EB(_id_276AC5E84835EA87) {
  _id_5D8264355DB47371(_id_276AC5E84835EA87);
}

_id_9F1E4A5ACAD09F4B(_id_276AC5E84835EA87) {
  _id_276AC5E84835EA87.script_noteworthy = tolower(_id_276AC5E84835EA87.script_noteworthy);

  if(!isDefined(_id_276AC5E84835EA87._id_B205D90302DA2F07) && _id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_276AC5E84835EA87._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_276AC5E84835EA87.origin, 1);
  else
    _id_276AC5E84835EA87._id_B205D90302DA2F07 = "none";

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "cave") || issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "cave")) {
      _id_276AC5E84835EA87.name = "cave";
      _id_276AC5E84835EA87._id_1A4D8A1DF4DA9847 = 4500;
    } else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "center"))
      _id_276AC5E84835EA87.name = "civic_center";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "embassy"))
      _id_276AC5E84835EA87.name = "embassy";
    else if(issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "fort"))
      _id_276AC5E84835EA87.name = "fort";
    else if((issubstr(_id_276AC5E84835EA87.script_noteworthy, "mall") || issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "sira")) && !issubstr(_id_276AC5E84835EA87.script_noteworthy, "small")) {
      _id_276AC5E84835EA87.name = "mall";
      _id_276AC5E84835EA87._id_1283DACA8CCBB5E0 = 1;
      _id_276AC5E84835EA87._id_FE7DE213C314772A = 20;
      _id_276AC5E84835EA87._id_5B034A098FB968AD = 25;
    } else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "marshland") || issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "marshland") && !issubstr(_id_276AC5E84835EA87.script_noteworthy, "postoffice"))
      _id_276AC5E84835EA87.name = "marshland";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "oilfield") || issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "oilfield"))
      _id_276AC5E84835EA87.name = "oilfield";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "policeacademy"))
      _id_276AC5E84835EA87.name = "police_academy";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "postoffice"))
      _id_276AC5E84835EA87.name = "post_office";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "ship") || issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "lone"))
      _id_276AC5E84835EA87.name = "ship";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "terminal"))
      _id_276AC5E84835EA87.name = "terminal";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "tower")) {
      _id_276AC5E84835EA87.name = "tower";
      _id_276AC5E84835EA87._id_1A4D8A1DF4DA9847 = 4500;
    } else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "warehouse") || issubstr(_id_276AC5E84835EA87._id_B205D90302DA2F07, "exhume"))
      _id_276AC5E84835EA87.name = "warehouse";
  } else if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "castle"))
      _id_276AC5E84835EA87.name = "sealion_castle";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "cityhall"))
      _id_276AC5E84835EA87.name = "sealion_cityhall";
  } else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "aquarium"))
      _id_276AC5E84835EA87.name = "delta_aquarium";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "castle"))
      _id_276AC5E84835EA87.name = "delta_castle";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "cityhall"))
      _id_276AC5E84835EA87.name = "delta_cityhall";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "firestation"))
      _id_276AC5E84835EA87.name = "delta_firestation";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "oldmuseum"))
      _id_276AC5E84835EA87.name = "delta_oldmuseum";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "stadium"))
      _id_276AC5E84835EA87.name = "delta_stadium";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "terminal"))
      _id_276AC5E84835EA87.name = "delta_terminal";
    else if(issubstr(_id_276AC5E84835EA87.script_noteworthy, "trainstation"))
      _id_276AC5E84835EA87.name = "delta_trainstation";
  }

  if(!isDefined(_id_276AC5E84835EA87.name))
    _id_276AC5E84835EA87.name = "unnamed";

  level._id_F1073FBD45B59A06._id_224D6C29E9BB566B[_id_276AC5E84835EA87.name] = _id_276AC5E84835EA87;
}

_id_4E6DD86684152B17(_id_276AC5E84835EA87, _id_0A18C0F0CAC2A223) {
  if(!isDefined(_id_276AC5E84835EA87._id_6A9A1AEEAA7C25DF)) {
    _id_276AC5E84835EA87._id_6A9A1AEEAA7C25DF = "nonMainFortress";

    if(!isDefined(level._id_F1073FBD45B59A06._id_E5F0869FEDD95408))
      level._id_F1073FBD45B59A06._id_E5F0869FEDD95408 = [];

    level._id_F1073FBD45B59A06._id_E5F0869FEDD95408[level._id_F1073FBD45B59A06._id_E5F0869FEDD95408.size] = _id_276AC5E84835EA87;
  }

  _id_EECB9FD7F5E8181B(_id_276AC5E84835EA87, _id_0A18C0F0CAC2A223);
  _id_956A7FEEFD3A23AA(_id_276AC5E84835EA87);
}

_id_5D8264355DB47371(_id_276AC5E84835EA87, _id_B98EADE21726C5F3, _id_42293210DEC86D6D, _id_7A020BEED970E537, _id_4C71F8833F27A882, _id_0A18C0F0CAC2A223, _id_F2FD46AB32DB5810, _id_BC2C2D8E7A8CCE59, _id_D61CB609D8479D4C, _id_29550A90EEB9CED8, _id_911F1509A5F9328B, _id_1283DACA8CCBB5E0) {
  level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1 = scripts\engine\utility::array_remove(level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1, _id_276AC5E84835EA87);

  if(!scripts\engine\utility::array_contains(level._id_F1073FBD45B59A06._id_DF987907A483DF89, _id_276AC5E84835EA87))
    level._id_F1073FBD45B59A06._id_DF987907A483DF89[level._id_F1073FBD45B59A06._id_DF987907A483DF89.size] = _id_276AC5E84835EA87;

  _id_276AC5E84835EA87.isactive = 1;

  if(!isDefined(_id_B98EADE21726C5F3) || _id_B98EADE21726C5F3)
    _id_68A6379D51E7DBC2(_id_276AC5E84835EA87, _id_0A18C0F0CAC2A223, _id_F2FD46AB32DB5810);

  if(!_id_744CAD313ED0A87E::_id_A9B26D3ED078E149()) {
    if(!issubstr(_id_276AC5E84835EA87.script_noteworthy, "noTacMap") && (!isDefined(_id_7A020BEED970E537) || _id_7A020BEED970E537))
      _id_FB256F37D5E18AEB(_id_276AC5E84835EA87);

    if(!isDefined(_id_4C71F8833F27A882) || _id_4C71F8833F27A882) {
      if(isDefined(_id_BC2C2D8E7A8CCE59) && isfunction(_id_BC2C2D8E7A8CCE59))
        [[_id_BC2C2D8E7A8CCE59]](_id_276AC5E84835EA87);
      else
        thread _id_0DEC2A213EE64B9D(_id_276AC5E84835EA87, undefined, _id_1283DACA8CCBB5E0);
    }
  }

  if(istrue(level._id_447A5D19BA3B177A) && (!isDefined(_id_D61CB609D8479D4C) || _id_D61CB609D8479D4C)) {
    _id_B941EE96C15C2B44(_id_276AC5E84835EA87);
    _id_EB55B7B980BCA63C(_id_276AC5E84835EA87);
    thread _id_2A0231B6EDCAFA35(_id_276AC5E84835EA87);
  }

  if(!isDefined(_id_911F1509A5F9328B) || _id_911F1509A5F9328B)
    thread _id_8D2765F0CE279C28(_id_276AC5E84835EA87);

  _id_3F213275327CF454(_id_276AC5E84835EA87, _id_29550A90EEB9CED8);
  thread _id_7FDB1A4CF3B80584(_id_276AC5E84835EA87);
}

_id_5FDEEF1AFF6DD31C(_id_276AC5E84835EA87) {
  _id_276AC5E84835EA87._id_DDB9ADC01816D747 = 1;
  _id_5D8264355DB47371(_id_276AC5E84835EA87, 0, undefined, 1, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

_id_F88DB9C7AC59F910(origin, _id_B98EADE21726C5F3, _id_42293210DEC86D6D, _id_7A020BEED970E537, _id_4C71F8833F27A882, _id_0A18C0F0CAC2A223, _id_F2FD46AB32DB5810, _id_BC2C2D8E7A8CCE59) {
  _id_276AC5E84835EA87 = _id_BAEF4910ACEA00F0(origin);

  if(!isDefined(_id_276AC5E84835EA87) || istrue(_id_276AC5E84835EA87._id_5683FB2485637C86)) {
    return;
  }
  _id_4E6DD86684152B17(_id_276AC5E84835EA87);

  if(!isDefined(_id_B98EADE21726C5F3))
    _id_B98EADE21726C5F3 = 1;

  if(!isDefined(_id_42293210DEC86D6D))
    _id_42293210DEC86D6D = 1;

  if(!isDefined(_id_7A020BEED970E537))
    _id_7A020BEED970E537 = 1;

  if(!isDefined(_id_4C71F8833F27A882))
    _id_4C71F8833F27A882 = 1;

  _id_5D8264355DB47371(_id_276AC5E84835EA87, _id_B98EADE21726C5F3, _id_42293210DEC86D6D, _id_7A020BEED970E537, _id_4C71F8833F27A882, _id_0A18C0F0CAC2A223, _id_F2FD46AB32DB5810, _id_BC2C2D8E7A8CCE59, undefined, undefined, 0);
}

_id_B672261B8246A1E5(origin, _id_DE0600B92AD0F1D4, _id_B98EADE21726C5F3, _id_42293210DEC86D6D, _id_7A020BEED970E537, _id_4C71F8833F27A882, _id_0A18C0F0CAC2A223, _id_F2FD46AB32DB5810, _id_BC2C2D8E7A8CCE59) {
  _id_276AC5E84835EA87 = _id_BBE42D7091BEDFC5(origin, _id_DE0600B92AD0F1D4);

  if(!isDefined(_id_276AC5E84835EA87) || istrue(_id_276AC5E84835EA87._id_5683FB2485637C86)) {
    return;
  }
  _id_4E6DD86684152B17(_id_276AC5E84835EA87);

  if(!isDefined(_id_B98EADE21726C5F3))
    _id_B98EADE21726C5F3 = 1;

  if(!isDefined(_id_42293210DEC86D6D))
    _id_42293210DEC86D6D = 1;

  if(!isDefined(_id_7A020BEED970E537))
    _id_7A020BEED970E537 = 1;

  if(!isDefined(_id_4C71F8833F27A882))
    _id_4C71F8833F27A882 = 1;

  _id_5D8264355DB47371(_id_276AC5E84835EA87, _id_B98EADE21726C5F3, _id_42293210DEC86D6D, _id_7A020BEED970E537, _id_4C71F8833F27A882, _id_0A18C0F0CAC2A223, _id_F2FD46AB32DB5810, _id_BC2C2D8E7A8CCE59, undefined, undefined, 0);
}

_id_51B43A371A041049(_id_276AC5E84835EA87) {
  switch (_id_276AC5E84835EA87.name) {
    case "civic_center":
      return "civic_center";
    case "embassy":
      return "embassy";
    case "fort":
      return "fort";
    case "mall":
      return "sira_mall";
    case "marshland":
      return "resort_entrance";
    case "police_academy":
      return "police_academy";
    case "post_office":
      return "post_office_stronghold";
    case "tower":
      return "control_tower";
    case "warehouse":
      return "exhume_warehouse";
    case "sealion_castle":
      return "sealion_castle";
    case "sealion_cityhall":
      return "sealion_cityhall";
    case "delta_aquarium":
      return "delta_aquarium";
    case "delta_castle":
      return "delta_castle";
    case "delta_cityhall":
      return "delta_cityhall";
    case "delta_firestation":
      return "delta_firestation";
    case "delta_oldmuseum":
      return "delta_oldmuseum";
    case "delta_stadium":
      return "delta_stadium";
    case "delta_terminal":
      return "delta_terminal";
    case "delta_trainstation":
      return "delta_trainstation";
    default:
      return "fortress";
  }
}

_id_05BABA80D74039D3(_id_276AC5E84835EA87, _id_8F7EDDC9C0864A1B) {
  foreach(door in _id_276AC5E84835EA87._id_E2CD8AA8B46D18AC)
  door._id_8F7EDDC9C0864A1B = _id_8F7EDDC9C0864A1B;
}

_id_5BCF13B1577B232C(_id_276AC5E84835EA87, _id_14DCEA3D745E5B2B) {
  foreach(door in _id_276AC5E84835EA87._id_E2CD8AA8B46D18AC) {
    _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
    door._id_276AC5E84835EA87 = _id_276AC5E84835EA87;

    if(isDefined(_id_14DCEA3D745E5B2B)) {
      door._id_DEF557E8FD5C6763 = _id_14DCEA3D745E5B2B;
      continue;
    }

    door._id_DEF557E8FD5C6763 = ::_id_3C65E3630088B116;
  }

  foreach(door in _id_276AC5E84835EA87._id_84B0EF6BDDD2907A) {
    _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
    door._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  }
}

_id_A113CF2BE454F78D(_id_276AC5E84835EA87) {
  foreach(door in _id_276AC5E84835EA87._id_E2CD8AA8B46D18AC)
  _id_57D3850A12CF1D8F::_id_B092780F9EC4496E(door);
}

_id_68A6379D51E7DBC2(_id_276AC5E84835EA87, _id_8F7EDDC9C0864A1B, _id_F2FD46AB32DB5810) {
  if(isDefined(_id_8F7EDDC9C0864A1B))
    _id_05BABA80D74039D3(_id_276AC5E84835EA87, _id_8F7EDDC9C0864A1B);

  _id_5BCF13B1577B232C(_id_276AC5E84835EA87, _id_F2FD46AB32DB5810);
}

_id_F01E587E03E81414(_id_14DCEA3D745E5B2B) {
  if(!istrue(level._id_94D533FB4F4E5728)) {
    return;
  }
  _id_276AC5E84835EA87 = self;

  foreach(door in _id_276AC5E84835EA87._id_511459D6509633B1) {
    _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
    door._id_276AC5E84835EA87 = _id_276AC5E84835EA87;

    if(isDefined(_id_14DCEA3D745E5B2B)) {
      door._id_DEF557E8FD5C6763 = _id_14DCEA3D745E5B2B;
      continue;
    }

    door._id_DEF557E8FD5C6763 = ::_id_42C99AF4FAAC0AEE;
  }
}

_id_FB256F37D5E18AEB(_id_276AC5E84835EA87, _id_A6AB8D0FDA441DC2) {
  if(istrue(level._id_C62D39D6E6AFB119)) {
    if(istrue(level._id_3F29C197A71F3BE9) && isDefined(level._id_F1073FBD45B59A06._id_F1AB12C7E26976DB) && scripts\engine\utility::array_contains(level._id_F1073FBD45B59A06._id_F1AB12C7E26976DB, _id_276AC5E84835EA87)) {
      _id_670492475C1687B9 = "ui_map_icon_loot_cache";
      _id_276AC5E84835EA87._id_192F741C1625715E = scripts\mp\objidpoolmanager::requestobjectiveid(99);
      scripts\mp\objidpoolmanager::objective_add_objective(_id_276AC5E84835EA87._id_192F741C1625715E, "active", _id_276AC5E84835EA87.origin + (0, -350, 0), _id_670492475C1687B9);
      scripts\mp\objidpoolmanager::update_objective_setbackground(_id_276AC5E84835EA87._id_192F741C1625715E, 8);
      scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(_id_276AC5E84835EA87._id_192F741C1625715E, 1);
      scripts\mp\objidpoolmanager::_id_098BA077848896A3(_id_276AC5E84835EA87._id_192F741C1625715E, 1);
      objective_setlabel(_id_276AC5E84835EA87._id_192F741C1625715E, &"MP_BR_INGAME/ABANDONEDCACHE");
    } else {
      _id_276AC5E84835EA87 _id_64ACB6CE534155B7::createquestobjicon(_id_276AC5E84835EA87._id_2EA336A7EBDEDE49, "active", _id_276AC5E84835EA87.origin + (0, -350, 0));
      scripts\mp\objidpoolmanager::update_objective_setbackground(_id_276AC5E84835EA87.objectiveiconid, 1);
      scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(_id_276AC5E84835EA87.objectiveiconid, 1);
      scripts\mp\objidpoolmanager::_id_098BA077848896A3(_id_276AC5E84835EA87.objectiveiconid, 1);

      if(istrue(_id_276AC5E84835EA87._id_933F9685674999FB) && isDefined(_id_A6AB8D0FDA441DC2)) {
        scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(_id_276AC5E84835EA87.objectiveiconid);
        scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(_id_276AC5E84835EA87.objectiveiconid, 18);
        objective_setlabel(_id_276AC5E84835EA87.objectiveiconid, &"MP_BR_INGAME/BLACK_SITE");
      } else {
        scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_276AC5E84835EA87.objectiveiconid);
        scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(_id_276AC5E84835EA87.objectiveiconid, 17);
        objective_setlabel(_id_276AC5E84835EA87.objectiveiconid, &"MP_BR_INGAME/FORTRESS");
      }

      thread _id_5130ED243B288A07(_id_276AC5E84835EA87);
      return;
    }

    return;
  }

  offset = (0, 0, 0);
  scriptable = undefined;
  _id_8E98A1B3E95386A5 = _id_276AC5E84835EA87.origin;

  if(isDefined(_id_276AC5E84835EA87._id_CE9A81D514B212B7))
    _id_8E98A1B3E95386A5 = _id_276AC5E84835EA87._id_CE9A81D514B212B7.origin;

  if(!isDefined(_id_276AC5E84835EA87.script_noteworthy) || !issubstr(tolower(_id_276AC5E84835EA87.script_noteworthy), "notacmap")) {
    if(_id_4EC4F39A2E1745F2(_id_276AC5E84835EA87)) {
      if(isDefined(_id_276AC5E84835EA87.name) && _id_276AC5E84835EA87.name != "unnamed") {
        scriptable = spawnscriptable("fortress_hero_tacmap_location_" + _id_276AC5E84835EA87.name, _id_8E98A1B3E95386A5 + offset);

        if(istrue(_id_276AC5E84835EA87._id_DDB9ADC01816D747))
          scriptable setscriptablepartstate("fortress_hero_tacmap_location", "disabled");
        else if(_id_276AC5E84835EA87._id_0C8C070D7375EF1E == "hero_epic")
          scriptable setscriptablepartstate("fortress_hero_tacmap_location", "epic");
      } else
        scriptable = spawnscriptable("fortress_tacmap_location_scriptable", _id_8E98A1B3E95386A5 + offset);
    } else
      scriptable = spawnscriptable("fortress_tacmap_location_scriptable", _id_8E98A1B3E95386A5 + offset);
  }

  _id_276AC5E84835EA87._id_6451879E18908224 = scriptable;
}

_id_D1EC6D522C8102D9(_id_276AC5E84835EA87) {
  _id_276AC5E84835EA87._id_6451879E18908224 setscriptablepartstate("fortress_tacmap_location_scriptable", "hidden");
}

_id_50AA951AB3C71FA4() {
  _id_276AC5E84835EA87 = self;
  _id_276AC5E84835EA87 _id_64ACB6CE534155B7::deletequestobjicon();

  if(isDefined(_id_276AC5E84835EA87._id_A274FC61BEDE1A17)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(_id_276AC5E84835EA87._id_A274FC61BEDE1A17);
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_276AC5E84835EA87._id_A274FC61BEDE1A17);
  }
}

_id_5130ED243B288A07(_id_276AC5E84835EA87) {
  _id_D95DBF57B47734D9(_id_276AC5E84835EA87, 0);
  _id_E929ACD9485C3641 = getdvarint("dvar_5633AE4F34076C54", 0);

  if(_id_276AC5E84835EA87._id_0C8C070D7375EF1E == "large" && istrue(_id_E929ACD9485C3641)) {
    scripts\mp\flags::gameflagwait("br_ready_to_jump");
    _id_64ACB6CE534155B7::showquestobjicontoall(_id_276AC5E84835EA87.objectiveiconid);
  }
}

_id_D95DBF57B47734D9(_id_276AC5E84835EA87, active) {
  if(istrue(active))
    scripts\mp\objidpoolmanager::update_objective_icon(_id_276AC5E84835EA87.objectiveiconid, _id_276AC5E84835EA87._id_CEF34ADBE3F8CAAB);
  else
    scripts\mp\objidpoolmanager::update_objective_icon(_id_276AC5E84835EA87.objectiveiconid, _id_276AC5E84835EA87._id_2EA336A7EBDEDE49);
}

_id_BE5A531F97B7C07E(_id_276AC5E84835EA87) {
  scripts\mp\objidpoolmanager::update_objective_icon(_id_276AC5E84835EA87.objectiveiconid, _id_276AC5E84835EA87._id_9B65E6A548478E7C);
}

_id_B663F29079A15C71(_id_276AC5E84835EA87, _id_6DFAEE5EE2B3FA4B, player) {
  if(istrue(_id_6DFAEE5EE2B3FA4B)) {
    if(istrue(level._id_25E8B4AFE5E06169) && isDefined(_id_276AC5E84835EA87._id_A274FC61BEDE1A17)) {
      scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(_id_276AC5E84835EA87._id_A274FC61BEDE1A17);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_276AC5E84835EA87.objectiveiconid);

      foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players"))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, _id_B2810E8D06E0A042);

      return;
    }

    _id_276AC5E84835EA87._id_A274FC61BEDE1A17 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(_id_276AC5E84835EA87._id_A274FC61BEDE1A17 == -1) {
      return;
    }
    scripts\mp\objidpoolmanager::objective_add_objective(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, "active", _id_276AC5E84835EA87.origin + (0, -350, 0), _id_276AC5E84835EA87._id_2253390A6BA835C3);
    scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, 1);
    scripts\mp\objidpoolmanager::_id_098BA077848896A3(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, 1);
    scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(_id_276AC5E84835EA87._id_A274FC61BEDE1A17);
    scripts\mp\objidpoolmanager::update_objective_icon(_id_276AC5E84835EA87.objectiveiconid, _id_276AC5E84835EA87._id_9B65E6A548478E7C);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_276AC5E84835EA87.objectiveiconid);

    foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players"))
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, _id_B2810E8D06E0A042);

    return;
  } else
    _id_BE5A531F97B7C07E(_id_276AC5E84835EA87);
}

_id_917D94CC077CA94E(_id_276AC5E84835EA87, player) {
  if(isDefined(_id_276AC5E84835EA87.objectiveiconid) && _id_276AC5E84835EA87.objectiveiconid != -1)
    objective_removeclientfrommask(_id_276AC5E84835EA87.objectiveiconid, player);

  if(isDefined(_id_276AC5E84835EA87._id_A274FC61BEDE1A17) && _id_276AC5E84835EA87._id_A274FC61BEDE1A17 != -1)
    objective_addclienttomask(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, player);
}

_id_7EE5340D1A5A2CA9(_id_276AC5E84835EA87, player) {
  if(isDefined(_id_276AC5E84835EA87._id_A274FC61BEDE1A17) && _id_276AC5E84835EA87._id_A274FC61BEDE1A17 != -1)
    objective_removeclientfrommask(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, player);

  if(isDefined(_id_276AC5E84835EA87.objectiveiconid) && _id_276AC5E84835EA87.objectiveiconid != -1)
    objective_addclienttomask(_id_276AC5E84835EA87.objectiveiconid, player);
}

_id_C7DCBB4C3AC66791(_id_276AC5E84835EA87, player) {
  if(isDefined(_id_276AC5E84835EA87._id_A274FC61BEDE1A17) && _id_276AC5E84835EA87._id_A274FC61BEDE1A17 != -1)
    objective_removeclientfrommask(_id_276AC5E84835EA87._id_A274FC61BEDE1A17, player);

  if(isDefined(_id_276AC5E84835EA87.objectiveiconid) && _id_276AC5E84835EA87.objectiveiconid != -1)
    objective_removeclientfrommask(_id_276AC5E84835EA87.objectiveiconid, player);
}

_id_401B0949743B45A9(_id_276AC5E84835EA87) {
  foreach(node in _id_276AC5E84835EA87._id_104F87CC51A1138D) {
    scriptable = spawnscriptable("fortress_scriptable_props", node.origin, node.angles);
    _id_C1A15365E9E1280F = scriptable getscriptableparthasstate("scriptable_prop", node.script_noteworthy);

    if(!istrue(_id_C1A15365E9E1280F)) {
      scriptable freescriptable();
      continue;
    }

    scriptable setscriptablepartstate("scriptable_prop", node.script_noteworthy);

    if(node.script_noteworthy == "door_metal_roller_01_closed_large_01_emb") {
      createnavobstaclebybounds(node.origin, (16, 64, 55), node.angles);
      continue;
    }

    if(node.script_noteworthy == "door_metal_barn_02_sliding") {
      left = anglestoleft(node.angles);
      origin = node.origin + left * 128;
      createnavobstaclebybounds(origin, (16, 100, 55), node.angles);
      continue;
    }

    if(node.script_noteworthy == "fence_corrugated_metal_03_128") {
      right = anglestoright(node.angles);
      origin = node.origin + right * 45;
      createnavobstaclebybounds(origin, (16, 80, 55), node.angles);
      continue;
    }

    if(node.script_noteworthy == "door_security_gate_double_mp_01_green") {
      createnavobstaclebybounds(node.origin, (16, 64, 55), node.angles);
      continue;
    }

    if(node.script_noteworthy == "fence_corrugated_metal_03_256") {
      right = anglestoright(node.angles);
      origin = node.origin + right * 90;
      createnavobstaclebybounds(origin, (16, 128, 55), node.angles);
      continue;
    }

    if(node.script_noteworthy == "uk_scaffold_kit_128x64_01") {
      left = anglestoleft(node.angles);
      origin = node.origin + left * 80;
      createnavobstaclebybounds(origin, (16, 64, 55), node.angles);
    }
  }

  if(isDefined(_id_276AC5E84835EA87.flags)) {
    if(getdvarint("dvar_EB46A7DB8733A155", 0) != 1) {
      foreach(node in _id_276AC5E84835EA87.flags) {
        if(issubstr(node.script_noteworthy, "texas")) {
          continue;
        }
        if(node.script_noteworthy == "vfx_mayh_gameplay_dmz_long_thin_aq_flag_wind_1")
          node.script_noteworthy = "vfx_mayh_gameplay_dmz_long_thin_aq_flag_wind_2";

        if(node.script_noteworthy == "vfx_mayh_gameplay_dmz_rectangular_aq_flag_wind_1")
          node.script_noteworthy = "vfx_mayh_gameplay_dmz_rectangular_aq_flag_wind_2";

        scriptable = spawnscriptable("fortress_scriptable_flags", node.origin, node.angles);
        scriptable setscriptablepartstate("scriptable_flag", node.script_noteworthy);
      }
    }
  }
}

_id_908EF13B806CC4C2() {
  return 0;
}

_id_E9D20F2E232BAF6E(agent, _id_276AC5E84835EA87, origin) {
  agent.goalradius = 10;
  agent setgoalpos(getclosestpointonnavmesh(origin + (10000, 0, 0)));
  waitframe();

  if(isDefined(_id_276AC5E84835EA87._id_2CA6167878674ADF)) {
    if(ispointinvolume(origin, _id_276AC5E84835EA87._id_2CA6167878674ADF))
      agent setgoalvolume(_id_276AC5E84835EA87._id_2CA6167878674ADF);
  } else if(isDefined(_id_276AC5E84835EA87._id_AE966FC594D6BC10)) {
    if(ispointinvolume(origin, _id_276AC5E84835EA87._id_AE966FC594D6BC10))
      agent setgoalvolume(_id_276AC5E84835EA87._id_AE966FC594D6BC10);
  }
}

_id_7B62BCD7E8786051(_id_276AC5E84835EA87) {
  foreach(node in _id_276AC5E84835EA87.lootcaches)
  _id_C872D24014C40B47(node);
}

_id_C872D24014C40B47(node) {
  spawnscriptable("br_loot_cache_lege", node.origin, node.angles);
}

_id_3C65E3630088B116(door, player) {
  if(isDefined(door._id_276AC5E84835EA87) && !istrue(door._id_276AC5E84835EA87._id_7BE8B486A10B3DE8)) {
    door._id_276AC5E84835EA87._id_7BE8B486A10B3DE8 = 1;
    _id_6A8EC730B2BFA844::_id_01D1DF26DF05A6C8(door, player);

    if(isDefined(door._id_783CE7DF56CE2748))
      self thread[[door._id_783CE7DF56CE2748]](player);

    wait(randomfloatrange(1, 3));
    _id_7AB5B649FA408138::_id_FDD0934F1A32F70D(player.origin, 128, "dmz_stronghold_unlock", player.team, undefined, "dmz_stronghold_unlock_classic");
    level thread _id_D83E81EA09406450(door._id_276AC5E84835EA87);
    wait(randomintrange(15, 25));
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, door.origin, "medium", "reinforcements", "fortressDoorOpened");
  }
}

_id_42C99AF4FAAC0AEE(door, player) {
  if(isDefined(door._id_276AC5E84835EA87) && !istrue(door._id_276AC5E84835EA87._id_7BE8B486A10B3DE8))
    door._id_276AC5E84835EA87._id_7BE8B486A10B3DE8 = 1;
}

_id_2CDE636A73AEAD3D(origin) {
  return isDefined(_id_C0A211A69F5F8F2F(origin));
}

_id_F59F68ADC71D49B3(origin) {
  if(isDefined(level._id_49A5D647639E781E) && level._id_49A5D647639E781E.size > 0) {
    foreach(volume in level._id_49A5D647639E781E) {
      if(!isDefined(volume)) {
        continue;
      }
      if(ispointinvolume(origin, volume))
        return 1;
    }
  }

  return 0;
}

_id_AE011F52B2B15BAF(origin, _id_925BE0548554E3A0) {
  if(isDefined(level._id_F1073FBD45B59A06)) {
    foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
      foreach(volume in _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) {
        if(scripts\mp\utility\game::getsubgametype() == "aladdin" && !isDefined(volume)) {
          continue;
        }
        if(istrue(_id_925BE0548554E3A0)) {
          _id_58E222086A2D297E = (origin[0], origin[1], volume.origin[2]);

          if(ispointinvolume(_id_58E222086A2D297E, volume))
            return 1;

          continue;
        }

        if(ispointinvolume(origin, volume))
          return 1;
      }
    }
  }

  return 0;
}

_id_F0201365C368CF88(origin) {
  if(isDefined(level._id_C7D1916B16F57D7B) && level._id_C7D1916B16F57D7B.size > 0) {
    foreach(volume in level._id_C7D1916B16F57D7B) {
      if(ispointinvolume(origin, volume))
        return 1;
    }
  }

  return 0;
}

_id_C0A211A69F5F8F2F(origin) {
  if(!isDefined(level._id_F1073FBD45B59A06) || !isDefined(level._id_F1073FBD45B59A06._id_DF987907A483DF89))
    return undefined;

  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
    if(_id_20F6E9317B1BAF3D(origin, _id_276AC5E84835EA87))
      return _id_276AC5E84835EA87;
  }

  return undefined;
}

_id_20F6E9317B1BAF3D(origin, _id_276AC5E84835EA87) {
  if(!isDefined(_id_276AC5E84835EA87) || !isDefined(_id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) || _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46.size == 0)
    return 0;

  if(!isDefined(_id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) || _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46.size == 0)
    return 0;

  foreach(volume in _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) {
    if(isDefined(volume) && ispointinvolume(origin, volume))
      return 1;
  }

  return 0;
}

_id_AFA1F5BF0DE4E4D1() {
  if(!_id_2D421D1F793F6F93()) {
    return;
  }
  return level._id_F1073FBD45B59A06._id_DF987907A483DF89;
}

_id_888D8429A71C944C(name) {
  if(!_id_2D421D1F793F6F93()) {
    return;
  }
  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
    if(isDefined(_id_276AC5E84835EA87.name) && name == _id_276AC5E84835EA87.name)
      return _id_276AC5E84835EA87;
  }

  return undefined;
}

_id_54BB7CF730D65649() {
  return scripts\engine\utility::random(_id_AFA1F5BF0DE4E4D1());
}

_id_2D421D1F793F6F93() {
  return isDefined(level._id_F1073FBD45B59A06);
}

_id_771F278C8C749A28(_id_276AC5E84835EA87) {
  return !istrue(_id_276AC5E84835EA87._id_7BE8B486A10B3DE8) && !isDefined(_id_276AC5E84835EA87._id_732DF8DB084AB0C5) && !isDefined(_id_276AC5E84835EA87._id_C6CF0A05D2F9B5DF);
}

_id_B941EE96C15C2B44(_id_276AC5E84835EA87) {
  tripwires = scripts\engine\utility::array_randomize(getentitylessscriptablearray("scriptable_dmz_tripwire", "classname"));

  foreach(_id_801C53C0ED06495B in tripwires) {
    if(!isDefined(_id_801C53C0ED06495B.target)) {
      continue;
    }
    _id_3A6B42AB825A103E = _id_801C53C0ED06495B.origin + anglesToForward(_id_801C53C0ED06495B.angles) * 45;

    if(_id_20F6E9317B1BAF3D(_id_3A6B42AB825A103E, _id_276AC5E84835EA87)) {
      if(!isDefined(_id_276AC5E84835EA87.tripwires))
        _id_276AC5E84835EA87.tripwires = [];

      _id_276AC5E84835EA87.tripwires[_id_276AC5E84835EA87.tripwires.size] = _id_801C53C0ED06495B;
      _id_801C53C0ED06495B._id_AAD14F891FB70D86 = 1;
    }
  }
}

_id_EB55B7B980BCA63C(_id_276AC5E84835EA87) {
  if(!isDefined(_id_276AC5E84835EA87.tripwires)) {
    return;
  }
  _id_F5B8DE0D5E57483D = 0;
  _id_B48F729A413E45F3 = 0;

  if(isDefined(_id_276AC5E84835EA87._id_FE7DE213C314772A)) {
    _id_F5B8DE0D5E57483D = _id_276AC5E84835EA87._id_FE7DE213C314772A - 1;
    _id_B48F729A413E45F3 = _id_276AC5E84835EA87._id_FE7DE213C314772A;
  } else {
    switch (_id_276AC5E84835EA87._id_0C8C070D7375EF1E) {
      case "small":
        _id_F5B8DE0D5E57483D = 1;
        _id_B48F729A413E45F3 = 2;
        break;
      case "medium":
        _id_F5B8DE0D5E57483D = 2;
        _id_B48F729A413E45F3 = 3;
        break;
      case "large":
        _id_F5B8DE0D5E57483D = 2;
        _id_B48F729A413E45F3 = 4;
        break;
      case "hero":
        _id_F5B8DE0D5E57483D = 3;
        _id_B48F729A413E45F3 = 6;
        break;
      case "hero_epic":
        _id_F5B8DE0D5E57483D = 6;
        _id_B48F729A413E45F3 = 8;
        break;
      case "hero_disabled":
        _id_F5B8DE0D5E57483D = 0;
        _id_B48F729A413E45F3 = 1;
        break;
    }
  }

  _id_7F964221BFB0DAE1 = randomintrange(_id_F5B8DE0D5E57483D, _id_B48F729A413E45F3);
  _id_276AC5E84835EA87.tripwires = scripts\engine\utility::array_randomize(_id_276AC5E84835EA87.tripwires);

  foreach(index, _id_801C53C0ED06495B in _id_276AC5E84835EA87.tripwires) {
    if(index < _id_7F964221BFB0DAE1) {
      if(isDefined(level._id_E9A6FC11B0AA7EB2))
        [[level._id_E9A6FC11B0AA7EB2]](_id_801C53C0ED06495B);

      continue;
    }

    if(isDefined(level._id_D9D80893720B39DF))
      [[level._id_D9D80893720B39DF]](_id_801C53C0ED06495B);
  }
}

_id_2A0231B6EDCAFA35(_id_276AC5E84835EA87) {
  if(!isDefined(level._id_D49FE7F07F2BA493)) {
    return;
  }
  _id_E54FABB89186A3E8 = 0;

  foreach(_id_DDC4E4BDECFF28CD in _id_276AC5E84835EA87._id_6B52C9E8E4FA1496) {
    if(_id_E54FABB89186A3E8 >= 5) {
      break;
    }

    if(!isDefined(level._id_D49FE7F07F2BA493.traps["fireBarrel"]._id_BED6AB8862CF09D4)) {
      break;
    }

    _id_993F213B7E366216 = [[level._id_D49FE7F07F2BA493.traps["fireBarrel"]._id_BED6AB8862CF09D4]](_id_DDC4E4BDECFF28CD);

    if(isDefined(_id_993F213B7E366216)) {
      _id_993F213B7E366216._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
      _id_E54FABB89186A3E8++;
    }
  }

  foreach(_id_8DD57CBF74F6D032 in _id_276AC5E84835EA87._id_E3519A0E3ACBFEF3) {
    if(!isDefined(level._id_D49FE7F07F2BA493.traps["fireBarrel"]._id_BED6AB8862CF09D4)) {
      break;
    }

    _id_CAF7F0D9711E0A49 = [[level._id_D49FE7F07F2BA493.traps["gasPuddle"]._id_BED6AB8862CF09D4]](_id_8DD57CBF74F6D032);

    if(isDefined(_id_CAF7F0D9711E0A49))
      _id_CAF7F0D9711E0A49._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  }
}

_id_8D2765F0CE279C28(_id_276AC5E84835EA87) {
  level endon("game_ended");
  _id_276AC5E84835EA87.contributingplayers = [];

  if(!istrue(_id_276AC5E84835EA87._id_698AB4F1074B4F37))
    _id_276AC5E84835EA87 waittill("spawned_agents");

  for(;;) {
    agents = _func_B4B9401715CF98EA(_id_276AC5E84835EA87._id_D389F1191E609479);
    numagents = agents.size;
    _id_FA8D978E0F21C38A = 0;
    _id_276AC5E84835EA87._id_FA8D978E0F21C38A = 0;

    foreach(agent in agents) {
      origin = undefined;

      if(isagent(agent))
        origin = agent.origin;
      else if(isint(agent)) {
        info = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent);

        if(isDefined(info))
          origin = info.origin;
      }

      _id_C79DCA57049C64D4 = isDefined(origin) && _id_20F6E9317B1BAF3D(origin, _id_276AC5E84835EA87);
      _id_4076D436F9878FDF = isDefined(origin) && distance2d(origin, _id_276AC5E84835EA87.origin) < 1000;

      if(_id_C79DCA57049C64D4 || _id_4076D436F9878FDF) {
        _id_FA8D978E0F21C38A++;

        if(istrue(_id_276AC5E84835EA87._id_2FB79D99876506A7))
          _id_276AC5E84835EA87._id_2FB79D99876506A7 = 0;

        continue;
      }

      if(!istrue(level._id_C62D39D6E6AFB119))
        _id_1CBDD3DB07BFF2D6(agent);
    }

    _id_276AC5E84835EA87._id_FA8D978E0F21C38A = _id_FA8D978E0F21C38A;

    if(_id_FA8D978E0F21C38A == 0) {
      _id_095CFA82FFCDA809 = [];
      _id_7DA5B2082E28AB9D = [];

      foreach(player in _id_276AC5E84835EA87.contributingplayers) {
        if(isDefined(player.team) && !scripts\engine\utility::array_contains(_id_095CFA82FFCDA809, player.team)) {
          _id_095CFA82FFCDA809[_id_095CFA82FFCDA809.size] = player.team;
          _id_7DA5B2082E28AB9D[_id_7DA5B2082E28AB9D.size] = player;
        }
      }

      foreach(player in _id_7DA5B2082E28AB9D)
      _id_6A8EC730B2BFA844::_id_59FE5E0D7D5E7947(player, _id_276AC5E84835EA87);

      if(istrue(level._id_C62D39D6E6AFB119) && !istrue(_id_276AC5E84835EA87._id_2FB79D99876506A7))
        _id_276AC5E84835EA87._id_2FB79D99876506A7 = 1;
      else
        return;
    }

    wait 1.0;
  }
}

_id_3F213275327CF454(_id_276AC5E84835EA87, _id_29550A90EEB9CED8) {
  foreach(volume in _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46)
  level._id_49A5D647639E781E[level._id_49A5D647639E781E.size] = volume;

  if(istrue(_id_29550A90EEB9CED8)) {
    foreach(volume in _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46)
    level._id_C7D1916B16F57D7B[level._id_C7D1916B16F57D7B.size] = volume;
  }
}

_id_7FDB1A4CF3B80584(_id_276AC5E84835EA87) {
  foreach(loc in _id_276AC5E84835EA87._id_DE77472DB7BDD0EC)
  thread _id_EFD7A7C699AB2828(loc);
}

_id_EFD7A7C699AB2828(loc) {
  level endon("game_ended");

  for(;;) {
    playersinrange = scripts\mp\utility\player::getplayersinradius(loc.origin, 128);

    foreach(player in playersinrange) {
      if(isPlayer(player) && !isagent(player)) {
        if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          player setplayermusicstate("dmz_stronghold_unlock_classic");
          continue;
        }

        player setplayermusicstate("dmz_stronghold_unlock");
      }
    }

    wait 2;
  }
}

_id_CBF0FEDF537CE343() {
  _id_725DDBE5849A247D = getdvarint("dvar_F2A7D1ED476ED0E1", 4);
  _id_B6C736EC6AE3CA66 = scripts\engine\utility::array_randomize(getarraykeys(level._id_F1073FBD45B59A06._id_224D6C29E9BB566B));

  foreach(key in _id_B6C736EC6AE3CA66) {
    if(level._id_F1073FBD45B59A06._id_224D6C29E9BB566B[key].name != "unnamed") {
      level._id_F1073FBD45B59A06._id_224D6C29E9BB566B[key]._id_0C8C070D7375EF1E = "hero_epic";
      _id_725DDBE5849A247D--;
    }

    if(_id_725DDBE5849A247D <= 0) {
      break;
    }
  }

  foreach(_id_E45AC70BA6569D32 in level._id_F1073FBD45B59A06._id_224D6C29E9BB566B) {
    if(istrue(_id_E45AC70BA6569D32.isactive)) {
      continue;
    }
    if(_id_E45AC70BA6569D32.name == "unnamed") {
      continue;
    }
    if(!istrue(level._id_4CFD75AA6DDDE156)) {
      if(!isDefined(_id_E45AC70BA6569D32._id_B205D90302DA2F07) || !_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_E45AC70BA6569D32._id_B205D90302DA2F07))
        continue;
    }

    _id_4E6DD86684152B17(_id_E45AC70BA6569D32);

    if(!istrue(level._id_4CFD75AA6DDDE156)) {
      if(isDefined(_id_E45AC70BA6569D32._id_B205D90302DA2F07) && isDefined(_id_E45AC70BA6569D32._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B) && isDefined(level._id_B205D90302DA2F07[_id_E45AC70BA6569D32._id_B205D90302DA2F07]["subAreas"][_id_E45AC70BA6569D32._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1))
        _id_E45AC70BA6569D32._id_737C25E5BCF0380D = level._id_B205D90302DA2F07[_id_E45AC70BA6569D32._id_B205D90302DA2F07]["subAreas"][_id_E45AC70BA6569D32._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B]._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;
    }

    if(!scripts\engine\utility::array_contains(level._id_F1073FBD45B59A06._id_DF987907A483DF89, _id_E45AC70BA6569D32)) {
      _id_E45AC70BA6569D32._id_0C8C070D7375EF1E = "hero_disabled";
      level thread _id_5FDEEF1AFF6DD31C(_id_E45AC70BA6569D32);
    } else {
      level thread _id_5D8264355DB47371(_id_E45AC70BA6569D32, 1, 1, 1, 1, _id_51B43A371A041049(_id_E45AC70BA6569D32), undefined, undefined, 1, 0, 1, _id_E45AC70BA6569D32._id_1283DACA8CCBB5E0);
      level thread _id_64017446DB1EBF75(_id_E45AC70BA6569D32);

      if(_id_E45AC70BA6569D32._id_0C8C070D7375EF1E == "hero_epic")
        _id_36F2D57A4D831748(_id_E45AC70BA6569D32.origin);
    }

    _id_2C1F8E18242DE1F5(_id_E45AC70BA6569D32);
  }
}

_id_4EC4F39A2E1745F2(_id_276AC5E84835EA87) {
  return istrue(_id_276AC5E84835EA87._id_732DF8DB084AB0C5) || istrue(_id_276AC5E84835EA87._id_C6CF0A05D2F9B5DF);
}

_id_6D27F6675243F8BE() {
  while(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  _id_7BBCDC05C49E9B86 = [];

  foreach(_id_272BB004283094C7 in level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1) {
    _id_8668CFB45844F507();
    _id_0421E96E09A60042 = scripts\engine\utility::getclosest(_id_272BB004283094C7.origin, level._id_42D94681E15BBBDD);

    if(!isDefined(_id_0421E96E09A60042)) {
      continue;
    }
    if(distance2dsquared(_id_0421E96E09A60042.origin, _id_272BB004283094C7.origin) > 2359296) {
      continue;
    }
    volumes = [_id_0421E96E09A60042];

    if(isDefined(_id_0421E96E09A60042.targetname))
      volumes = getEntArray(_id_0421E96E09A60042.targetname, "targetname");

    _id_7BBCDC05C49E9B86 = scripts\engine\utility::array_combine(_id_7BBCDC05C49E9B86, volumes);
  }

  scripts\engine\utility::array_delete(_id_7BBCDC05C49E9B86);
}

_id_64017446DB1EBF75(_id_276AC5E84835EA87) {
  if(getdvarint("dvar_A13F3213C557F5FD", 1) == 0) {
    return;
  }
  foreach(volume in _id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) {
    volume.name = _id_276AC5E84835EA87.name;
    volume._id_B205D90302DA2F07 = _id_276AC5E84835EA87._id_B205D90302DA2F07;
    level thread _id_63DFC24DB0D4F1A4(volume);
  }
}

_id_63DFC24DB0D4F1A4(volume) {
  volume._id_B670211E29D8308D = [];
  volume._id_DD410313D5C4F27B = [];

  for(;;) {
    wait 1;

    if(!isDefined(volume._id_B205D90302DA2F07))
      _id_FE16F116477F0084 = level.players;
    else
      _id_FE16F116477F0084 = level._id_B205D90302DA2F07[volume._id_B205D90302DA2F07]["players"];

    if(!isDefined(_id_FE16F116477F0084) || _id_FE16F116477F0084.size == 0) {
      continue;
    }
    foreach(player in _id_FE16F116477F0084) {
      if(distance2dsquared(volume.origin, player.origin) < 25000000) {
        playerid = player getentitynumber();

        if(ispointinvolume(player.origin, volume)) {
          if(isDefined(volume._id_E2F9CB96D8A5C8D1) && !isDefined(volume._id_B670211E29D8308D[playerid]))
            volume thread[[volume._id_E2F9CB96D8A5C8D1]](player);

          if(_id_EC1E1BBE558AC28B(playerid, volume))
            player thread _id_60C9F8DB44495EF1(player, volume.name);
        } else {
          if(isDefined(volume._id_3177443FCF724AF1) && isDefined(volume._id_B670211E29D8308D[playerid]))
            volume thread[[volume._id_3177443FCF724AF1]](player);

          volume._id_B670211E29D8308D[playerid] = undefined;
        }
      }
    }
  }
}

_id_EC1E1BBE558AC28B(playerid, volume) {
  time = gettime();

  if(istrue(volume._id_B670211E29D8308D[playerid])) {
    volume._id_DD410313D5C4F27B[playerid] = time;
    return 0;
  } else
    volume._id_B670211E29D8308D[playerid] = 1;

  _id_6737D550C9B4C95F = 45000;

  if(isDefined(volume._id_DD410313D5C4F27B[playerid])) {
    if(volume._id_DD410313D5C4F27B[playerid] + _id_6737D550C9B4C95F < time) {
      volume._id_DD410313D5C4F27B[playerid] = time;
      return 1;
    }

    return 0;
  } else {
    volume._id_DD410313D5C4F27B[playerid] = time;
    return 1;
  }
}

_id_60C9F8DB44495EF1(player, _id_7D02860466ABA0C4) {
  if(!isDefined(player) || !isDefined(_id_7D02860466ABA0C4)) {
    return;
  }
  _id_7D02860466ABA0C4 = tolower(_id_7D02860466ABA0C4);
  _id_BAB0D10E51188531 = [player];
  splashname = undefined;

  if(issubstr(_id_7D02860466ABA0C4, "cave"))
    splashname = "stronghold_hero_cave";
  else if(issubstr(_id_7D02860466ABA0C4, "center"))
    splashname = "stronghold_hero_civic_center";
  else if(issubstr(_id_7D02860466ABA0C4, "embassy"))
    splashname = "stronghold_hero_embassy";
  else if(issubstr(_id_7D02860466ABA0C4, "fort"))
    splashname = "stronghold_hero_fort_underground";
  else if(issubstr(_id_7D02860466ABA0C4, "mall") && !issubstr(_id_7D02860466ABA0C4, "small"))
    splashname = "stronghold_hero_sira_mall";
  else if(issubstr(_id_7D02860466ABA0C4, "marshland"))
    splashname = "stronghold_hero_resort_entrance";
  else if(issubstr(_id_7D02860466ABA0C4, "oilfield"))
    splashname = "stronghold_hero_oilfield";
  else if(issubstr(_id_7D02860466ABA0C4, "police_academy"))
    splashname = "stronghold_hero_police_academy";
  else if(issubstr(_id_7D02860466ABA0C4, "post_office"))
    splashname = "stronghold_hero_post_office_stronghold";
  else if(issubstr(_id_7D02860466ABA0C4, "ship"))
    splashname = "stronghold_hero_ship";
  else if(issubstr(_id_7D02860466ABA0C4, "terminal"))
    splashname = "stronghold_hero_terminal";
  else if(issubstr(_id_7D02860466ABA0C4, "tower"))
    splashname = "stronghold_hero_control_tower";
  else if(issubstr(_id_7D02860466ABA0C4, "warehouse"))
    splashname = "stronghold_hero_exhume_warehouse";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    if(issubstr(_id_7D02860466ABA0C4, "castle"))
      splashname = "stronghold_hero_sealion_castle";
    else if(issubstr(_id_7D02860466ABA0C4, "cityhall"))
      splashname = "stronghold_hero_sealion_cityhall";
  }

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    if(issubstr(_id_7D02860466ABA0C4, "aquarium"))
      splashname = "stronghold_hero_delta_aquarium";
    else if(issubstr(_id_7D02860466ABA0C4, "castle"))
      splashname = "stronghold_hero_delta_castle";
    else if(issubstr(_id_7D02860466ABA0C4, "cityhall"))
      splashname = "stronghold_hero_delta_cityhall";
    else if(issubstr(_id_7D02860466ABA0C4, "firestation"))
      splashname = "stronghold_hero_delta_firestation";
    else if(issubstr(_id_7D02860466ABA0C4, "oldmuseum"))
      splashname = "stronghold_hero_delta_oldmuseum";
    else if(issubstr(_id_7D02860466ABA0C4, "stadium"))
      splashname = "stronghold_hero_delta_stadium";
    else if(issubstr(_id_7D02860466ABA0C4, "terminal"))
      splashname = "stronghold_hero_delta_terminal";
    else if(issubstr(_id_7D02860466ABA0C4, "trainstation"))
      splashname = "stronghold_hero_delta_trainstation";
  }

  if(!isDefined(splashname)) {
    return;
  }
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(splashname, _id_BAB0D10E51188531);
  thread _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("denied_area_enter", _id_BAB0D10E51188531);
}

_id_2C1F8E18242DE1F5(_id_276AC5E84835EA87) {
  if(_id_276AC5E84835EA87.name == "fort") {
    _id_CE8FC891E4BD83C5 = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", (18607, -55932, 1081), 1024);

    foreach(ascender in _id_CE8FC891E4BD83C5)
    ascender setscriptablepartstate("top", "off");
  } else if(_id_276AC5E84835EA87.name == "delta_oldmuseum") {
    _id_CE8FC891E4BD83C5 = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", (8366.5, -5415.5, 882), 1024);

    foreach(ascender in _id_CE8FC891E4BD83C5)
    ascender setscriptablepartstate("top", "off");
  }
}

_id_B8B841D5628094E5() {
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400 = [];
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"] = [];
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"] = [];
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"] = [];
  level._id_F1073FBD45B59A06._id_1EC347B0FE6B96D0 = [];
  level._id_F1073FBD45B59A06._id_1EC347B0FE6B96D0["valuables"] = 60;
  level._id_F1073FBD45B59A06._id_1EC347B0FE6B96D0["rare"] = 35;
  level._id_F1073FBD45B59A06._id_1EC347B0FE6B96D0["epic"] = 5;
  level._id_F1073FBD45B59A06._id_06381D686975B2F8 = [];
  level._id_F1073FBD45B59A06._id_06381D686975B2F8["valuables"] = "consumable";
  level._id_F1073FBD45B59A06._id_06381D686975B2F8["rare"] = "weapon";
  level._id_F1073FBD45B59A06._id_06381D686975B2F8["epic"] = "weapon";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_plunder_cash_epic_1";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_plunder_cash_epic_2";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_plunder_cash_legendary_1";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_plate_carrier_3";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_killstreak_clusterstrike";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_killstreak_precision_airstrike";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_killstreak_uav";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["valuables"].size] = "brloot_valuable_goldbar";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_br_msecho_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_la_rpapa7_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_dm_pgolf1_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_dm_la700_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_br_soscar14_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sh_charlie725_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sh_mviktor_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_pi_golf17_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_lm_ahotel_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_lm_kilo21_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_ar_mike4_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_ar_kilo53_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["rare"].size] = "brloot_weapon_sm_papa90_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_golf3_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_br_msecho_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_dm_mike14_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_dm_sa700_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_dm_scromeo_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_sh_mbravo_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_pi_decho_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_lm_foxtrot_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_lm_rkilo_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_kilo53_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_augolf_epic";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_ar_akilo_lege";
  level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"][level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400["epic"].size] = "brloot_weapon_sm_victor_lege";
}

_id_DA4ADEA9B5215A37() {
  _id_EB6F2E9E793E992E = 0;

  foreach(_id_5355D2B661F2F93A in level._id_F1073FBD45B59A06._id_1EC347B0FE6B96D0)
  _id_EB6F2E9E793E992E = _id_EB6F2E9E793E992E + _id_5355D2B661F2F93A;

  roll = randomint(_id_EB6F2E9E793E992E);
  _id_F812AB39EF6B4406 = 0;
  _id_ED881975D628C656 = undefined;

  foreach(category, _id_5355D2B661F2F93A in level._id_F1073FBD45B59A06._id_1EC347B0FE6B96D0) {
    _id_F812AB39EF6B4406 = _id_F812AB39EF6B4406 + _id_5355D2B661F2F93A;

    if(roll <= _id_F812AB39EF6B4406) {
      _id_ED881975D628C656 = category;
      break;
    }
  }

  if(!isDefined(_id_ED881975D628C656))
    return [undefined, undefined];

  item = scripts\engine\utility::random(level._id_F1073FBD45B59A06._id_E0FFFA1AF7503400[_id_ED881975D628C656]);
  _id_CE27CBABE010181E = level._id_F1073FBD45B59A06._id_06381D686975B2F8[_id_ED881975D628C656];
  return [item, _id_CE27CBABE010181E];
}

_id_36F2D57A4D831748(_id_590672F7B5711C59) {
  _id_C4F53E871DF9789D = getlootscriptablearrayinradius("br_loot_cache_lege", undefined, _id_590672F7B5711C59, 2048);
  _id_2F7339E0FABE6594 = getentitylessscriptablearray("dmz_crate_wood", undefined, _id_590672F7B5711C59, 2048);
  _id_C54E8A88506815AA = scripts\engine\utility::array_combine(_id_C4F53E871DF9789D, _id_2F7339E0FABE6594);

  foreach(_id_B038ED928EC17A81 in _id_C54E8A88506815AA) {
    if(istrue(_id_B038ED928EC17A81._id_C93EA8F612F4AABA)) {
      continue;
    }
    items = getscriptablelootcachecontents(_id_B038ED928EC17A81);
    _id_B038ED928EC17A81._id_46A3A8565AC0C17C = 3;
    _id_B038ED928EC17A81.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
    [_id_D8CD9C1941A88194, _id_CE27CBABE010181E] = _id_DA4ADEA9B5215A37();

    if(!isDefined(_id_D8CD9C1941A88194)) {
      return;
    }
    ref = undefined;

    if(_id_CE27CBABE010181E == "weapon") {
      lootid = level.br_pickups._id_7B2BFF2D04EE1017[_id_D8CD9C1941A88194];
      _id_EA346AD3175AA7EA = 0;
      count = 1;
      ref = _id_D8CD9C1941A88194;
    } else {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_D8CD9C1941A88194);
      _id_EA346AD3175AA7EA = scripts\engine\utility::ter_op(items.size < 3, items.size, 3);
      count = tablelookup(level.brloottablename, 1, _id_D8CD9C1941A88194, 4);

      if(count == "")
        count = tablelookup(level.brloottablename, 1, _id_D8CD9C1941A88194, 4);
    }

    _id_B038ED928EC17A81.contents = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F(_id_B038ED928EC17A81.contents, count, lootid, ref, _id_EA346AD3175AA7EA);
  }
}

_id_70C8A3094CAB3D57(agent) {
  agent endon("death");

  while(!isDefined(agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87))
    waitframe();

  _id_276AC5E84835EA87 = agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87;

  if(istrue(_id_276AC5E84835EA87._id_7BE8B486A10B3DE8)) {
    return;
  }
  agent._id_C833409FB72D15FB = 1;

  if(!isDefined(_id_276AC5E84835EA87._id_54FA4E2EF227341C))
    _id_276AC5E84835EA87._id_54FA4E2EF227341C = [];

  _id_276AC5E84835EA87._id_54FA4E2EF227341C[_id_276AC5E84835EA87._id_54FA4E2EF227341C.size] = agent;
}

_id_B6FAE9E25CE5D86E(agent) {
  agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_54FA4E2EF227341C = scripts\engine\utility::array_remove(agent._id_A5DAF6A4BAF26AAF._id_276AC5E84835EA87._id_54FA4E2EF227341C, agent);
}

_id_D83E81EA09406450(_id_276AC5E84835EA87) {
  if(!isDefined(_id_276AC5E84835EA87._id_54FA4E2EF227341C) || _id_276AC5E84835EA87._id_54FA4E2EF227341C.size <= 0) {
    return;
  }
  foreach(agent in _id_276AC5E84835EA87._id_54FA4E2EF227341C) {
    if(isDefined(agent) && isagent(agent) && isalive(agent))
      agent thread _id_234C1CAE9AA83D1E(agent);
  }
}

_id_234C1CAE9AA83D1E(agent, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772) {
  agent endon("death");

  if(!isDefined(_id_CD40AC65A2951F58))
    _id_CD40AC65A2951F58 = 2;

  if(!isDefined(_id_CD63C265A2BB9772))
    _id_CD63C265A2BB9772 = 8;

  wait(randomintrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772));

  if(isalive(agent))
    agent._id_C833409FB72D15FB = 0;
}

_id_9886567FBAFCD11A(_id_12B397CBEAAB23B6, origin2, tolerance) {
  return distancesquared(_id_12B397CBEAAB23B6, origin2) <= tolerance * tolerance;
}

_id_687B1A056A415976(_id_276AC5E84835EA87) {}

_id_98C9446690331268() {}