/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_dog_tag.gsc
************************************************/

_id_D22B3026C3183EAD() {
  level._id_EC3A072500042491 = [13448, 13445, 13447, 13446];
  level._id_A98214B4BDC952CD = ["brloot_dogtag_bronze", "brloot_dogtag_silver", "brloot_dogtag_gold", "brloot_dogtag_damascus"];

  if(!isDefined(level.br_pickups))
    level waittill("br_pickups_init");

  if(!getdvarint("dvar_EC32CD72EAD6B977", 1)) {
    return;
  }
  level._id_A3E1B091F11CD827 = spawnStruct();
  level._id_A3E1B091F11CD827.objectives = [];
  level._id_A3E1B091F11CD827._id_E8D3998184471EB4 = [];
  level._id_87B2A0265AC86FE0 = getdvarfloat("dvar_5A1B0676E3C6C467", 10.0);
  level._id_37A9B5BBCE714339 = getdvarint("dvar_2F56D4A76DC729E4", 2000);
  _id_7E52B56769FA7774::registerpickupcreatedcallback("brloot_dogtag_bronze", ::_id_AB266CA8693E5618);
  _id_7E52B56769FA7774::registerpickupcreatedcallback("brloot_dogtag_silver", ::_id_AB266CA8693E5618);
  _id_7E52B56769FA7774::registerpickupcreatedcallback("brloot_dogtag_gold", ::_id_AB266CA8693E5618);
  _id_7E52B56769FA7774::registerpickupcreatedcallback("brloot_dogtag_damascus", ::_id_AB266CA8693E5618);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::onplayerconnect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dogtag", "getDogTagVictimAndKiller", ::_id_E92E13020D5EE099);
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_3D8E31FA3CC6EEE5);
}

onplayerconnect(params) {
  self setclientomnvar("ui_dmz_dog_tag", _id_0DE2C669CAF6FB1D(self));
}

_id_3D8E31FA3CC6EEE5(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  _id_AD63323B4B7FDE00 = _id_55B287BE60B2AE11(player);

  if(!isDefined(_id_AD63323B4B7FDE00)) {
    return;
  }
  _id_AD63323B4B7FDE00.team = _id_EB06B338608EF354;

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(_id_EB06B338608EF354, "players")) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(_id_B2810E8D06E0A042); _id_AC0E594AC96AA3A8++) {
      if(!_id_03C17A26CE6A4668(_id_B2810E8D06E0A042 _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8))) {
        continue;
      }
      quantity = _id_B2810E8D06E0A042 _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

      if(!_id_D9F5C5090DE1241B(_id_B2810E8D06E0A042, quantity)) {
        continue;
      }
      _id_B2810E8D06E0A042 _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_AC0E594AC96AA3A8, quantity);
      [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(quantity);
      _id_2EF0B79FD47052F1 = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F];

      if(isDefined(_id_2EF0B79FD47052F1.player))
        _id_8E643D6706DEFEEA(_id_2EF0B79FD47052F1.player, quantity);

      if(!isDefined(_id_2EF0B79FD47052F1.player) || _id_2EF0B79FD47052F1.player != _id_B2810E8D06E0A042)
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_recover_dog_tag", [_id_B2810E8D06E0A042]);
    }
  }
}

_id_2F6772930123576C() {
  return isDefined(level._id_A3E1B091F11CD827);
}

_id_8E643D6706DEFEEA(player, _id_123D6D777458B852) {
  _id_BC03AA369196F2BF(player, 1);

  if(!istrue(level._id_2D15C14A954FF12F))
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_recover_dog_tag", [player], undefined);

  if(_id_2F6772930123576C() && _id_6CD8C4885CB6775C(_id_123D6D777458B852)) {
    objstruct = level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852];
    _id_E98B03B1EC8385FE(objstruct);
  }
}

_id_B5FBE3CB4ED955F4(enemy, _id_123D6D777458B852) {
  if(_id_2F6772930123576C()) {
    if(_id_6CD8C4885CB6775C(_id_123D6D777458B852)) {
      objstruct = level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852];
      _id_E98B03B1EC8385FE(objstruct);
    }

    if(_id_1A21A83169AD19F9(enemy))
      _id_8945131B7B8A89C8(enemy, _id_123D6D777458B852);
    else
      _id_433D4C5BC4DA9EAD(enemy, _id_123D6D777458B852);

    [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);
    info = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F];

    if(isDefined(info) && isDefined(info.team)) {
      _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(info.team, "players");

      if(isDefined(info.player)) {
        _id_7273312620004BC3 = scripts\engine\utility::array_remove(_id_7273312620004BC3, info.player);
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dogtag_stolen_from_you", [info.player]);
      }

      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dogtag_stolen_from_teammate", _id_7273312620004BC3);
    }

    if(isDefined(enemy.team))
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("dogtag_stolen_from_enemy", enemy.team);
  }
}

_id_AB266CA8693E5618() {
  if(_id_2F6772930123576C()) {
    count = _id_7E52B56769FA7774::loot_getitemcount(self);
    countlefthand = _id_7E52B56769FA7774::loot_getitemcountlefthand(self);
    _id_E97D731BEDD44C63 = _id_7E52B56769FA7774::_id_3A5F7703319142DD(self);
    _id_123D6D777458B852 = _id_B5D4FCC3FAB92696(self);

    if(_id_6CD8C4885CB6775C(_id_123D6D777458B852)) {
      objstruct = level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852];

      if(isDefined(objstruct.carryingplayer)) {
        _id_A9E95E007EB70709(objstruct, _id_123D6D777458B852);
        _id_42426B559596AE56(self, _id_123D6D777458B852);
      }
    }
  }
}

_id_EA29BCCF97CB1B9A(_id_6181DE250AFA5BB6, _id_123D6D777458B852) {
  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);

  if(isDefined(_id_C9CCB7804978DC9F) && isDefined(level._id_B287C5D31BEE8267) && isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F]) && !istrue(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F]._id_C9EFB56FDFB33E52)) {
    level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F]._id_C9EFB56FDFB33E52 = 1;
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_kill_confirm_dog_tag", [_id_6181DE250AFA5BB6]);
  }
}

_id_1A21A83169AD19F9(player) {
  if(isDefined(level._id_A3E1B091F11CD827))
    return isDefined(level._id_A3E1B091F11CD827._id_E8D3998184471EB4[player.guid]);
  else
    return 0;
}

_id_6CD8C4885CB6775C(_id_123D6D777458B852) {
  if(isDefined(level._id_A3E1B091F11CD827))
    return isDefined(level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852]);
  else
    return 0;
}

_id_3BFE56FC3C2BB91E(origin, _id_CFCFFC70799935EE) {
  objstruct = spawnStruct();
  objstruct.curorigin = origin;
  objstruct.offset3d = (0, 0, 100);
  objstruct scripts\mp\gameobjects::requestid(1, _id_CFCFFC70799935EE, undefined, 1, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(objstruct.objidnum, "hud_icon_objective_dog_tag");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objstruct.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objstruct.objidnum, 100);
  return objstruct;
}

_id_42426B559596AE56(scriptable, _id_123D6D777458B852) {
  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);
  objstruct = _id_3BFE56FC3C2BB91E(scriptable.origin, 1);
  objstruct.scriptable = scriptable;
  scripts\mp\objidpoolmanager::update_objective_position(objstruct.objidnum, objstruct.scriptable.origin + (0, 0, 50));
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(objstruct.objidnum, level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team);
  objstruct.dogtags = [_id_123D6D777458B852];
  level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852] = objstruct;
}

_id_62B5F185DE3AB25D(array, objstruct) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_123D6D777458B852, obj in array) {
    if(obj != objstruct)
      _id_BFC65A378A6D8EFE[_id_123D6D777458B852] = obj;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_E98B03B1EC8385FE(objstruct) {
  objstruct notify("stop_tracking");
  objstruct scripts\mp\gameobjects::releaseid();
  objstruct scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

  foreach(_id_123D6D777458B852, obj in level._id_A3E1B091F11CD827.objectives) {
    if(obj == objstruct) {}
  }

  level._id_A3E1B091F11CD827.objectives = _id_62B5F185DE3AB25D(level._id_A3E1B091F11CD827.objectives, objstruct);
  level._id_A3E1B091F11CD827._id_E8D3998184471EB4 = _id_62B5F185DE3AB25D(level._id_A3E1B091F11CD827._id_E8D3998184471EB4, objstruct);
}

_id_77060DA87F0214F7(origin) {
  point = scripts\engine\utility::_id_D553466CF817A4DA();
  point = (point[0] * level._id_37A9B5BBCE714339, point[1] * level._id_37A9B5BBCE714339, 0);
  return point + origin;
}

_id_3DE97C52C88C8A20(objstruct, player) {
  origin = _id_77060DA87F0214F7(player.origin);
  origin = origin + (0, 0, player.origin[2] + 750);
  scripts\mp\objidpoolmanager::update_objective_position(objstruct.objidnum, origin);
  objstruct scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(origin);
}

_id_433D4C5BC4DA9EAD(player, _id_123D6D777458B852) {
  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);

  if(!isDefined(_id_C9CCB7804978DC9F) || !isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F])) {
    return;
  }
  team = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team;
  objstruct = _id_3BFE56FC3C2BB91E(player.origin, 0);
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(objstruct.objidnum, team);
  objstruct.carryingplayer = player;
  objstruct.dogtags = [_id_123D6D777458B852];
  objstruct scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("DogTagObj_Dmz", _id_77060DA87F0214F7(objstruct.carryingplayer.origin), level._id_37A9B5BBCE714339);
  objstruct scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
  objstruct scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(_id_F0EA4030349A33D5);

  objstruct notify("stop_tracking");
  thread _id_8A3A6225B2E11801(objstruct);
  thread _id_DFE0992113030BD0(objstruct);
  level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852] = objstruct;
  level._id_A3E1B091F11CD827._id_E8D3998184471EB4[player.guid] = objstruct;
}

_id_8945131B7B8A89C8(player, _id_123D6D777458B852) {
  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);

  if(!isDefined(_id_C9CCB7804978DC9F) || !isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F])) {
    return;
  }
  team = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team;
  objstruct = level._id_A3E1B091F11CD827._id_E8D3998184471EB4[player.guid];
  objstruct.dogtags = scripts\engine\utility::array_add(objstruct.dogtags, _id_123D6D777458B852);
  level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852] = objstruct;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
  objstruct scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(_id_F0EA4030349A33D5);

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(objstruct.objidnum, team);
}

_id_A9E95E007EB70709(objstruct, _id_123D6D777458B852) {
  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);

  if(!isDefined(_id_C9CCB7804978DC9F) || !isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F])) {
    return;
  }
  team = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team;
  level._id_A3E1B091F11CD827.objectives[_id_123D6D777458B852] = undefined;
  objstruct.dogtags = scripts\engine\utility::array_remove(objstruct.dogtags, _id_123D6D777458B852);

  if(!_id_2E13CC7D90EE5683(objstruct.carryingplayer, team)) {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
    objstruct scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(_id_F0EA4030349A33D5);
  }

  if(objstruct.dogtags.size == 0)
    _id_E98B03B1EC8385FE(objstruct);
}

_id_8A3A6225B2E11801(objstruct) {
  objstruct endon("stop_tracking");
  objstruct.carryingplayer endon("death_or_disconnect");
  objstruct.carryingplayer endon("enter_live_ragdoll");
  level endon("game_ended");

  for(;;) {
    objstruct.carryingplayer waittill("item_added_to_cache", itemtype, _id_3793828403C6873E, lootid, quantity);

    if(isDefined(objstruct) && isDefined(objstruct.carryingplayer) && isDefined(lootid) && isDefined(quantity) && isDefined(level._id_EC3A072500042491) && scripts\engine\utility::array_contains(level._id_EC3A072500042491, lootid))
      thread _id_A9E95E007EB70709(objstruct, quantity);
  }
}

_id_DFE0992113030BD0(objstruct) {
  objstruct endon("stop_tracking");
  objstruct.carryingplayer endon("death_or_disconnect");
  objstruct.carryingplayer endon("enter_live_ragdoll");
  level endon("game_ended");

  for(;;) {
    if(isDefined(objstruct.carryingplayer) && isDefined(objstruct.carryingplayer.origin))
      _id_3DE97C52C88C8A20(objstruct, objstruct.carryingplayer);

    wait(level._id_87B2A0265AC86FE0);
  }
}

_id_2E13CC7D90EE5683(player, team) {
  if(isDefined(level._id_A3E1B091F11CD827) && _id_1A21A83169AD19F9(player)) {
    objstruct = level._id_A3E1B091F11CD827._id_E8D3998184471EB4[player.guid];

    foreach(_id_123D6D777458B852 in objstruct.dogtags) {
      [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);

      if(isDefined(_id_C9CCB7804978DC9F) && isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F]) && isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team) && level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team == team)
        return 1;
    }
  }

  return 0;
}

_id_C07675F2CE32FCB5(player) {
  if(!_id_2D9D24F7C63AC143::_id_720D227D0E55A960())
    return 0;

  if(player _id_2CEDCC356F1B9FC8::isplayeringulag())
    return 0;

  if(!isDefined(level._id_B287C5D31BEE8267))
    level._id_B287C5D31BEE8267 = [];

  if(!isDefined(level._id_9A595FC01AD18995))
    level._id_9A595FC01AD18995 = [];

  _id_567CD0E51048FF1F = _id_FB2923D9D7EB7AAC(player);
  return !isDefined(_id_567CD0E51048FF1F) || !istrue(level._id_9A595FC01AD18995[player.guid]);
}

_id_59771B0CC100410A(player) {
  if(scripts\mp\utility\game::getsubgametype() != "dmz" && getdvarint("dvar_7BEA5A5CF88445DC", 0))
    return "brloot_dogtag";

  tier = _id_0DE2C669CAF6FB1D(player);

  if(isDefined(level._id_A98214B4BDC952CD))
    return level._id_A98214B4BDC952CD[tier];

  return "brloot_dogtag_bronze";
}

_id_777013E79BE19C16(player) {
  tier = _id_0DE2C669CAF6FB1D(player);

  if(isDefined(level._id_EC3A072500042491))
    return level._id_EC3A072500042491[tier];

  return 13448;
}

_id_2D2F7E8A6547AE42(lootid) {
  switch (lootid) {
    case 13448:
      return 0;
    case 13445:
      return 1;
    case 13447:
      return 2;
    case 13446:
      return 3;
    default:
      return 0;
  }
}

_id_0DE2C669CAF6FB1D(player) {
  if(!isDefined(level._id_A98214B4BDC952CD) && isDefined(level._id_EC3A072500042491))
    return 0;

  if(!isDefined(player))
    return 0;

  [_id_153FDEE861E0F06F, _] = _id_0B7A9CE0A2282B79::_id_1558F8FB859C492A(player);

  if(!isDefined(_id_153FDEE861E0F06F))
    return 0;

  if(_id_153FDEE861E0F06F >= 10)
    return 3;
  else if(_id_153FDEE861E0F06F >= 5)
    return 2;
  else if(_id_153FDEE861E0F06F >= 2)
    return 1;

  return 0;
}

_id_BC03AA369196F2BF(player, hastag) {
  if(!isDefined(level._id_9A595FC01AD18995))
    level._id_9A595FC01AD18995 = [];

  if(istrue(hastag)) {
    level._id_9A595FC01AD18995[player.guid] = undefined;
    _id_5C9DDCF56D36F133 = _id_0DE2C669CAF6FB1D(player);
  } else {
    level._id_9A595FC01AD18995[player.guid] = 1;
    _id_5C9DDCF56D36F133 = -1;
  }

  player setclientomnvar("ui_dmz_dog_tag", _id_5C9DDCF56D36F133);
}

_id_0DD15435220E4207(player, _id_123D6D777458B852) {
  if(!isDefined(_id_123D6D777458B852))
    return 0;

  _id_F3C7C0CFC3E37302 = _id_FB2923D9D7EB7AAC(player);

  if(!isDefined(_id_F3C7C0CFC3E37302))
    return 0;

  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);
  return isDefined(_id_C9CCB7804978DC9F) && _id_C9CCB7804978DC9F == _id_F3C7C0CFC3E37302;
}

_id_03C17A26CE6A4668(lootid) {
  return isDefined(lootid) && isDefined(level._id_EC3A072500042491) && scripts\engine\utility::array_contains(level._id_EC3A072500042491, lootid);
}

_id_D9F5C5090DE1241B(player, _id_123D6D777458B852) {
  if(!isDefined(player.team) || !isDefined(level._id_B287C5D31BEE8267))
    return 0;

  [_id_C9CCB7804978DC9F, _] = _id_E92E13020D5EE099(_id_123D6D777458B852);
  return isDefined(_id_C9CCB7804978DC9F) && isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F]) && isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team) && level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].team == player.team;
}

_id_1129BA5718D33025(_id_6181DE250AFA5BB6, _id_123D6D777458B852) {
  if(!isDefined(_id_6181DE250AFA5BB6) || !isDefined(_id_6181DE250AFA5BB6.guid) || !isDefined(level._id_B287C5D31BEE8267))
    return 0;

  [_, _id_DD612E75937756FA] = _id_E92E13020D5EE099(_id_123D6D777458B852);
  return isDefined(_id_DD612E75937756FA) && isDefined(level._id_B287C5D31BEE8267[_id_DD612E75937756FA]) && isDefined(level._id_B287C5D31BEE8267[_id_DD612E75937756FA].guid) && level._id_B287C5D31BEE8267[_id_DD612E75937756FA].guid == _id_6181DE250AFA5BB6.guid;
}

_id_57711583C5D26490(victim) {
  if(!isDefined(victim))
    return 0;

  _id_C9CCB7804978DC9F = _id_FB2923D9D7EB7AAC(victim);

  if(!isDefined(_id_C9CCB7804978DC9F))
    return 3965;

  _id_AD63323B4B7FDE00 = _id_55B287BE60B2AE11(victim);
  _id_DD612E75937756FA = 61;

  if(isDefined(_id_AD63323B4B7FDE00) && isDefined(_id_AD63323B4B7FDE00._id_6181DE250AFA5BB6))
    _id_DD612E75937756FA = _id_AD63323B4B7FDE00._id_6181DE250AFA5BB6;

  return _id_99CBBC040233BE98(_id_C9CCB7804978DC9F, _id_DD612E75937756FA);
}

_id_379463A84ADB07B4(count) {
  if(!isDefined(count))
    return [61, 61, 0];

  return [count & 63, count >> 6, 0];
}

_id_B5D4FCC3FAB92696(pickup) {
  if(istrue(pickup._id_5754163E12F63FA7) || pickup.count > 61)
    return pickup.count;

  pickup._id_5754163E12F63FA7 = 1;
  result = 0;

  if(isDefined(pickup.count))
    result = result + pickup.count;

  if(isDefined(pickup.countlefthand))
    result = result + (pickup.countlefthand << 6);

  pickup.count = result;
  return result;
}

_id_F6D685CABFAD2CE9(victim, _id_6181DE250AFA5BB6, weapon) {
  if(!isDefined(level._id_B287C5D31BEE8267))
    level._id_B287C5D31BEE8267 = [];

  if(!isDefined(_id_FB2923D9D7EB7AAC(victim)))
    _id_AD150EE445D765A6(victim);

  if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6) && !isDefined(_id_FB2923D9D7EB7AAC(_id_6181DE250AFA5BB6)))
    _id_AD150EE445D765A6(_id_6181DE250AFA5BB6);

  if(isDefined(victim) && isDefined(_id_6181DE250AFA5BB6) && (victim == _id_6181DE250AFA5BB6 || !isPlayer(_id_6181DE250AFA5BB6)))
    _id_6181DE250AFA5BB6 = undefined;

  _id_056995ECB525C7B1(victim, _id_6181DE250AFA5BB6);
}

_id_AD150EE445D765A6(player) {
  if(level._id_B287C5D31BEE8267.size >= 60) {
    return;
  }
  info = spawnStruct();
  info.xuid = _func_B362C4581E1071BB(player getxuid());
  info.team = player.team;
  info.guid = player.guid;
  info.player = player;

  foreach(player in level.players)
  player setplayerdata(level._id_5D69837CF4DB0407, "dogTagInfo", level._id_B287C5D31BEE8267.size, "deadPlayerXuid", info.xuid);

  level._id_B287C5D31BEE8267[level._id_B287C5D31BEE8267.size] = info;
}

_id_E92E13020D5EE099(_id_123D6D777458B852) {
  if(!isDefined(_id_123D6D777458B852))
    return [undefined, undefined];

  _id_123D6D777458B852 = _id_123D6D777458B852 - 1;
  _id_C9CCB7804978DC9F = _id_123D6D777458B852 & 63;
  _id_DD612E75937756FA = _id_123D6D777458B852 >> 6;

  if(_id_DD612E75937756FA > 60)
    _id_DD612E75937756FA = undefined;

  return [_id_C9CCB7804978DC9F, _id_DD612E75937756FA];
}

_id_99CBBC040233BE98(_id_C9CCB7804978DC9F, _id_DD612E75937756FA) {
  if(!isDefined(_id_C9CCB7804978DC9F) || !isDefined(_id_DD612E75937756FA))
    return undefined;

  return (_id_DD612E75937756FA << 6 | _id_C9CCB7804978DC9F) + 1;
}

_id_FB2923D9D7EB7AAC(player) {
  if(isDefined(player) && isDefined(level._id_B287C5D31BEE8267)) {
    foreach(index, info in level._id_B287C5D31BEE8267) {
      if(info.guid == player.guid)
        return index;
    }
  }
}

_id_55B287BE60B2AE11(player) {
  if(isDefined(player) && isDefined(level._id_B287C5D31BEE8267)) {
    foreach(index, info in level._id_B287C5D31BEE8267) {
      if(info.guid == player.guid)
        return info;
    }
  }
}

_id_056995ECB525C7B1(victim, _id_6181DE250AFA5BB6) {
  if(isDefined(victim) && isDefined(level._id_B287C5D31BEE8267)) {
    foreach(index, info in level._id_B287C5D31BEE8267) {
      if(info.guid == victim.guid) {
        info._id_C9EFB56FDFB33E52 = 0;

        if(isDefined(_id_6181DE250AFA5BB6))
          info._id_6181DE250AFA5BB6 = _id_FB2923D9D7EB7AAC(_id_6181DE250AFA5BB6);
        else
          info._id_6181DE250AFA5BB6 = 61;

        break;
      }
    }
  }
}

_id_941FE2B16D6FFF9D(player) {
  if(!isDefined(level._id_B287C5D31BEE8267))
    level._id_B287C5D31BEE8267 = [];

  for(index = 0; index < 60; index++) {
    xuid = "0";

    if(isDefined(level._id_B287C5D31BEE8267[index]) && isDefined(level._id_B287C5D31BEE8267[index].xuid))
      xuid = level._id_B287C5D31BEE8267[index].xuid;

    player setplayerdata(level._id_5D69837CF4DB0407, "dogTagInfo", index, "deadPlayerXuid", xuid);
  }
}

_id_20D00ACCAA12C27F() {
  return 3965;
}