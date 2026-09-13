/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3aacf02225ca0da5.gsc
***********************************************/

_id_94B502046C767CD1() {
  if(isDefined(level._id_94B502046C767CD1))
    return level._id_94B502046C767CD1;

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    level._id_94B502046C767CD1 = "no_one";
    return level._id_94B502046C767CD1;
  }

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() || level.mapname == "mp_br_mechanics") {
    _id_33967FC4F4CEB489 = getdvarint("dvar_5C2CB9FC4042E027", 40);

    if(_id_33967FC4F4CEB489 > 0 && randomint(100) < _id_33967FC4F4CEB489) {
      level._id_94B502046C767CD1 = "train";
      return level._id_94B502046C767CD1;
    }
  }

  level._id_94B502046C767CD1 = "boss";
  return level._id_94B502046C767CD1;
}

_id_1BAFB1F579534EF6(_id_CB4FAD49263E20C4, player, scriptablename) {
  if(isDefined(level._id_B220727281972841))
    return undefined;

  _id_F9EC88C3D71324CD(scriptablename);
  _id_918249FD5219A579 = _id_7E52B56769FA7774::spawnpickup(level._id_1E8771CAF5122101, _id_CB4FAD49263E20C4, 1, 1);

  if(!isDefined(_id_918249FD5219A579))
    return undefined;

  _id_3E7EE85CB0D3504C(_id_918249FD5219A579, _id_CB4FAD49263E20C4.instance);
}

_id_3E7EE85CB0D3504C(scriptable, instance) {
  if(isDefined(level._id_B220727281972841)) {
    return;
  }
  _id_F9EC88C3D71324CD(scriptable.type);
  level._id_B220727281972841 = spawnStruct();
  level._id_B220727281972841.scriptable = scriptable;
  level._id_B220727281972841.instance = instance;
  scriptable._id_BBC200BC77C5DB2B = 1;

  if(level._id_86B2CFC21B9ABCF8)
    _id_9B0EF508769A0A0F(scriptable.origin);
}

_id_F9EC88C3D71324CD(scriptablename) {
  if(isDefined(level._id_1E8771CAF5122101)) {
    return;
  }
  scriptablename = scripts\engine\utility::_id_53C4C53197386572(scriptablename, "brloot_weaponcase");
  level._id_1E8771CAF5122101 = scriptablename;

  if(scriptablename == "brloot_weaponcase_black")
    level._id_9A327D6CA5E25308 = 1;

  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);
  scripts\cp_mp\utility\script_utility::registersharedfunc(scriptablename, "delete", ::_id_FBAA37F0A39A0D07);
  scripts\cp_mp\utility\script_utility::registersharedfunc(scriptablename, "dropped", ::_id_F69E3D324A1172C6);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "addedToContainer", ::_id_22E6CB66CCB56285);
  scripts\cp_mp\utility\script_utility::registersharedfunc(lootid, "pickedUp", ::_id_803A95E4E6CD2538);
}

_id_FBAA37F0A39A0D07() {
  if(isDefined(self._id_BF8E5F003146AF44) && self._id_BF8E5F003146AF44 scripts\cp_mp\vehicles\vehicle::isvehicle() && self._id_BF8E5F003146AF44 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() == "veh9_palfa")
    return 0;

  contents = scripts\engine\trace::create_itemclip_contents();
  trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 10000), undefined, contents);

  if(!isDefined(trace["position"]) || !isDefined(trace["fraction"]) || trace["fraction"] >= 0.99 || scripts\mp\outofbounds::ispointinoutofbounds(trace["position"])) {
    _id_AB2D20734DD55190 = getclosestpointonnavmesh(self.origin);
    trace = scripts\engine\trace::ray_trace(_id_AB2D20734DD55190, _id_AB2D20734DD55190 - (0, 0, 1000), undefined, contents);
  }

  if(!isDefined(trace["position"]) || !isDefined(trace["normal"]) || !isDefined(trace["fraction"]) || trace["fraction"] >= 0.99)
    return 0;

  scripts\common\utility::_id_CEFC758E6B25A243();
  self.origin = trace["position"];
  return 1;
}

_id_4E271AE7BC17F13C(player, dropstruct) {
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  _id_918249FD5219A579 = _id_7E52B56769FA7774::spawnpickup(level._id_1E8771CAF5122101, _id_CB4FAD49263E20C4, 1);
  _id_F69E3D324A1172C6(_id_918249FD5219A579, player, _id_CB4FAD49263E20C4.origin);
  return _id_918249FD5219A579;
}

_id_F69E3D324A1172C6(scriptable, owner, _id_D7A9FDC121364C8D) {
  if(!isDefined(level._id_B220727281972841)) {
    return;
  }
  level._id_B220727281972841._id_C0B463E7D8CBFB91 = undefined;
  level._id_B220727281972841.scriptable = scriptable;
  scriptable._id_BBC200BC77C5DB2B = 1;

  if(level._id_86B2CFC21B9ABCF8 && level._id_B220727281972841.objidnum != -1) {
    level notify("interuptWeaponCaseShow");
    objective_setplayintro(level._id_B220727281972841.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(level._id_B220727281972841.objidnum);
  }
}

_id_22E6CB66CCB56285(_id_69E96A4CAA72D794, owner) {
  if(!isDefined(level._id_B220727281972841)) {
    return;
  }
  level._id_B220727281972841._id_C0B463E7D8CBFB91 = undefined;
  level._id_B220727281972841.scriptable = _id_69E96A4CAA72D794;

  if(level._id_B220727281972841.objidnum != -1) {
    level notify("interuptWeaponCaseShow");
    objective_setplayintro(level._id_B220727281972841.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(level._id_B220727281972841.objidnum);
  }
}

_id_803A95E4E6CD2538(scriptable, player) {
  if(!isDefined(level._id_B220727281972841)) {
    _id_F9EC88C3D71324CD("brloot_weaponcase_black");
    level._id_B220727281972841 = spawnStruct();
    level._id_B220727281972841._id_C0B463E7D8CBFB91 = player;

    if(level._id_86B2CFC21B9ABCF8)
      _id_9B0EF508769A0A0F(player.origin);
  }

  objid = level._id_B220727281972841.objidnum;
  _id_2DB2F4DFA0A0D05F = 0;

  if(!isDefined(level._id_B220727281972841._id_78B7973779EAE62C) || isDefined(player.team) && player.team != level._id_B220727281972841._id_78B7973779EAE62C) {
    if(objid != -1) {
      objective_setownerteam(objid, player.team);
      objective_setprogressteam(objid, player.team);
      objective_setpulsate(objid, 1);
    }

    if(level._id_509664F56A31278F) {
      _id_2DB2F4DFA0A0D05F = 1;
      _id_F84975DD9CA58AB9 = "dmz_weaponCase_picked_up";

      if(isDefined(level._id_9D7687867D52AC75))
        _id_F84975DD9CA58AB9 = [[level._id_9D7687867D52AC75]]();

      _id_1B4ADA49A21B51CA = scripts\engine\utility::ter_op(istrue(level._id_B220727281972841._id_50B1B1A351F6095B), "dmz_weaponCase_ownership_transfer", _id_F84975DD9CA58AB9);
      level._id_B220727281972841._id_50B1B1A351F6095B = 1;
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, level.players, _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, undefined, undefined, 1));
      level thread _id_031A079A1FE9CAA2(player);
    }

    if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1() && _id_6A8EC730B2BFA844::_id_BEBCEFBD95A287EC(player))
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("faction_e_fearless_on_weaponcase_pickup", player.team);
    else
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("weapon_case_pickup_self", player.team);

    if(level.mapname != "mp_bio_lab")
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("weapon_case_pickup_enemy", scripts\engine\utility::array_difference(level.players, scripts\mp\utility\teams::getteamdata(player.team, "players")));

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_CEE0C6760060DFF8 = scripts\mp\utility\teams::getteamdata(player.team, "exfils");

      if(_id_CEE0C6760060DFF8.size > 0) {
        _id_EF5C2361236A6BA9 = sortbydistance(_id_CEE0C6760060DFF8, player.origin)[0].ent;

        if(isDefined(_id_EF5C2361236A6BA9))
          player calloutmarkerping_create(18, _id_EF5C2361236A6BA9.origin, _id_EF5C2361236A6BA9 getlinkedscriptableinstance().index);
      }
    }
  }

  if(objid != -1 && !_id_2DB2F4DFA0A0D05F)
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);

  level._id_B220727281972841._id_C0B463E7D8CBFB91 = player;
  level._id_B220727281972841._id_78B7973779EAE62C = player.team;
  _id_04545674E87C5795(player, "stat_29B82735431B6F0D");
  level._id_B220727281972841.scriptable = undefined;
}

_id_C320904C58171311() {
  if(_id_094333580DC2B96B(self) && isalive(self) && !istrue(self.extracted) && !istrue(self._id_DED04CDD264A7E00)) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(self.origin, self.angles);
    _id_918249FD5219A579 = _id_7E52B56769FA7774::spawnpickup(level._id_1E8771CAF5122101, _id_CB4FAD49263E20C4, 1);
    _id_04545674E87C5795(self, "stat_4C2EBC6200233F7C");
    _id_F69E3D324A1172C6(_id_918249FD5219A579, self, _id_CB4FAD49263E20C4.origin);
  }
}

_id_031A079A1FE9CAA2(_id_480F8576BE141BB4) {
  objid = level._id_B220727281972841.objidnum;

  if(level._id_86B2CFC21B9ABCF8 && objid != -1) {
    objective_setplayintro(level._id_B220727281972841.objidnum, 0);
    level notify("interuptWeaponCaseShow");
    level endon("interuptWeaponCaseShow");
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
    wait 3.8;
    objective_setplayintro(objid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
    waitframe();
    objective_setplayintro(objid, 0);
  }
}

_id_5704AB2A9381630F(player) {
  if(_id_094333580DC2B96B(player)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level._id_B220727281972841.objidnum);
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("weapon_case_extract_self", player.team);
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("weapon_case_extract_enemy", scripts\engine\utility::array_difference(level.players, scripts\mp\utility\teams::getteamdata(player.team, "players")));
    _id_04545674E87C5795(player, "Weapon Case Extracted");
    level notify("weaponCase_extracted");
  }
}

_id_025A4B6A2083E2AB(players) {
  if(!isDefined(level._id_B220727281972841)) {
    return;
  }
  if(!isDefined(level._id_8FC589B1EDFF1FB2))
    level._id_8FC589B1EDFF1FB2 = [];

  owner = level._id_B220727281972841._id_C0B463E7D8CBFB91;

  if(isDefined(owner) && scripts\engine\utility::array_contains(players, owner)) {
    foreach(_id_B2810E8D06E0A042 in players) {
      if(!isDefined(_id_B2810E8D06E0A042)) {
        continue;
      }
      if(!scripts\engine\utility::is_equal(_id_B2810E8D06E0A042.team, owner.team)) {
        continue;
      }
      level._id_8FC589B1EDFF1FB2[_id_B2810E8D06E0A042.guid] = 1;
    }

    _id_D64BEF4DD271A622 = scripts\engine\utility::array_remove_array(level.players, players);

    if(isDefined(level._id_B220727281972841.instance) && isDefined(level._id_B220727281972841.instance._id_9329E0D3CE1D5CA8))
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_lootbox_extracted_" + level._id_B220727281972841.instance._id_9329E0D3CE1D5CA8, _id_D64BEF4DD271A622, owner._id_DA28916E7827AF7C);
    else
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_lootbox_extracted_generic", _id_D64BEF4DD271A622, owner._id_DA28916E7827AF7C);
  }
}

_id_BAF5E17D7033A223(player) {
  if(!isDefined(level._id_8FC589B1EDFF1FB2))
    level._id_8FC589B1EDFF1FB2 = [];

  _id_5B6D15E33CB2EB51 = level._id_8FC589B1EDFF1FB2[player.guid];
  _id_F260F6AFF9AC7F06 = scripts\engine\utility::ter_op(isDefined(_id_84D052FBD32E9C5B(player)), 1, 0);

  if(!isDefined(_id_5B6D15E33CB2EB51))
    return 0;

  if(isDefined(level._id_8FC589B1EDFF1FB2[player.guid]))
    return (_id_5B6D15E33CB2EB51 - _id_F260F6AFF9AC7F06) * level.br_pickups._id_D93566A78E29D583[level._id_1E8771CAF5122101];

  return 0;
}

_id_8F6753648E94E7EC(player) {
  if(!isDefined(level._id_8FC589B1EDFF1FB2))
    level._id_8FC589B1EDFF1FB2 = [];

  _id_5B6D15E33CB2EB51 = level._id_8FC589B1EDFF1FB2[player.guid];

  if(!isDefined(_id_5B6D15E33CB2EB51) || _id_5B6D15E33CB2EB51 == 0)
    return [];

  if(!isDefined(level.br_pickups) || !isDefined(level.br_pickups.br_weapontoscriptable))
    return [];

  if(!isDefined(level._id_4CB4BDE4AE44ACBA))
    level._id_4CB4BDE4AE44ACBA = scripts\engine\utility::array_randomize(scripts\engine\utility::array_convert_keys_to_ints(level.br_pickups.br_weapontoscriptable));

  if(!isDefined(level._id_A03D3949856A0AC2))
    level._id_A03D3949856A0AC2 = 0;

  rewards = [];
  rewards[0] = level.br_pickups._id_7B2BFF2D04EE1017[level._id_4CB4BDE4AE44ACBA[level._id_A03D3949856A0AC2]];
  level._id_A03D3949856A0AC2 = (level._id_A03D3949856A0AC2 + 1) % level._id_4CB4BDE4AE44ACBA.size;
  return rewards;
}

_id_FC1CE25282BCBA83() {
  return isDefined(level._id_B220727281972841);
}

_id_094333580DC2B96B(player) {
  return isDefined(_id_84D052FBD32E9C5B(player));
}

_id_84D052FBD32E9C5B(player) {
  if(isDefined(level._id_B220727281972841) && scripts\engine\utility::is_equal(level._id_B220727281972841._id_C0B463E7D8CBFB91, player))
    return level._id_B220727281972841;
}

_id_9B0EF508769A0A0F(origin) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level._id_B220727281972841.objidnum = objid;

  if(objid == -1) {
    return;
  }
  objective_setlabel(objid, "MP_INGAME_ONLY/WEAPON_CASE_NAME");
  objective_setpings(objid, 1);
  objective_setzoffset(objid, (0, 0, 80)[2]);
  objective_icon(objid, "hud_icon_loot_squad_loot_box");
  objective_setbackground(objid, 1);
  objective_state(objid, "current");
  objective_position(objid, origin + (0, 0, -50));
  objective_setownerteam(objid, undefined);
  objective_setprogressteam(objid, undefined);
  scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(objid, 16);
  objective_setplayintro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  level thread _id_3DE46C194CCD92D8();
}

_id_3DE46C194CCD92D8() {
  level endon("game_ended");
  level endon("weaponCase_extracted");
  _id_B6B08A6A6F96B5C4 = scripts\engine\utility::ter_op(istrue(level._id_9A327D6CA5E25308), getdvarfloat("dvar_886C13ADE3501EDF", 6), 1.25);

  for(;;) {
    if(isDefined(level._id_B220727281972841._id_C0B463E7D8CBFB91)) {
      if(istrue(level._id_9A327D6CA5E25308))
        objective_position(level._id_B220727281972841.objidnum, level._id_B220727281972841._id_C0B463E7D8CBFB91.origin + (0, 0, -50));
      else
        objective_onentity(level._id_B220727281972841.objidnum, level._id_B220727281972841._id_C0B463E7D8CBFB91);
    } else if(isDefined(level._id_B220727281972841.scriptable))
      objective_position(level._id_B220727281972841.objidnum, level._id_B220727281972841.scriptable.origin + (0, 0, -50));
    else {
      scripts\mp\objidpoolmanager::returnobjectiveid(level._id_B220727281972841.objidnum);
      return;
    }

    objective_ping(level._id_B220727281972841.objidnum);
    wait(_id_B6B08A6A6F96B5C4);
  }
}

_id_04545674E87C5795(player, _id_905CDBC3CCF67283) {
  if(!isDefined(_id_905CDBC3CCF67283)) {
    logprint("'newInteraction' is undefined. Parameter [1], 'newInteraction'");
    return;
  }

  if(!isDefined(player)) {
    logprint("'player' is undefined. Parameter [0], 'player'");
    return;
  }

  if(!isPlayer(player)) {
    logprint("'player' object passed in is not a Player . Parameter [0], 'player'");
    return;
  }

  _id_67A1C616557C292F = scripts\engine\utility::_id_53C4C53197386572(_id_905CDBC3CCF67283, "stat_22A0E850ADD468A3");
  playerid = player _meth_7A32B0201993D7F7();

  if(!isDefined(playerid))
    playerid = -1;

  _id_6F8E00E25EB68CA5 = player.origin[0];
  _id_6F8DFFE25EB68A72 = player.origin[1];
  _id_6F8DFEE25EB6883F = player.origin[2];
  _id_2FCDAA176A5BC982 = "stat_22A0E850ADD468A3";

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_2FCDAA176A5BC982 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, 1);

  _id_FF9358B3AC96C7AB = scripts\engine\utility::_id_53C4C53197386572(_id_4A6760982B403BAD::_id_1B15450E092933CF(gettime()), 0.0);
  _id_7552DFBA10FB266C = scripts\engine\utility::_id_53C4C53197386572(level._id_B220727281972841._id_78B7973779EAE62C, "stat_22A0E850ADD468A3");
  _id_0672820B647EC78D = scripts\engine\utility::_id_53C4C53197386572(_id_45F403E1732217D3::_id_260DF5DDBFEBAC5F(player), "stat_22A0E850ADD468A3");
  player dlog_recordplayerevent("dlog_event_dmz_weapons_case", ["interact_time_stamp", _id_FF9358B3AC96C7AB, "player_position_x", _id_6F8E00E25EB68CA5, "player_position_y", _id_6F8DFFE25EB68A72, "player_position_z", _id_6F8DFEE25EB6883F, "point_of_interest", _id_2FCDAA176A5BC982, "weapon_case_interaction", _func_1823FF50BB28148D(_id_905CDBC3CCF67283), "carrier_client_uno_id", playerid, "previous_carrier_party_team", _func_1823FF50BB28148D(_id_7552DFBA10FB266C), "current_carrier_party_team", _func_1823FF50BB28148D(_id_0672820B647EC78D)]);
}