/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_318621981299585a.gsc
***********************************************/

_id_7AAE8CB0D8B0AC6A(data) {
  level._id_86260C6231072E89 = spawnStruct();
  level._id_86260C6231072E89.circleradius = getdvarint("dvar_ED78EECB63877C7C", 2000);
  level._id_86260C6231072E89._id_BF9C07649959C8CB = getdvarint("dvar_B482AFF66D7ABAE4", 1000);
  level._id_86260C6231072E89._id_24972DB4C00B613B = level._id_86260C6231072E89._id_BF9C07649959C8CB * level._id_86260C6231072E89._id_BF9C07649959C8CB;
  level._id_86260C6231072E89._id_ED2E5CF91BFF3A6F = getdvarfloat("dvar_3E60557305F8DA61", 0.65);
  data._id_68E354FCEB08D97B = ::_id_FEFD14A6940E2B99;

  if(!isDefined(level._effect["bomb_squad_explosion"]))
    level._effect["bomb_squad_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
}

_id_FEFD14A6940E2B99(_id_EFA8EF05B190D7D0, owner) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.owner = owner;
  owner._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40.players = [];
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_B883AD642CD900D6;
  _id_B8EBE3F71A08AB40.funcs["onPlayerAssigned"] = ::_id_DD6410A59565D135;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_54FAC7DB1349C874;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_1D932423D5491347;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_7FEF8FE4178F164F;
  _id_B8EBE3F71A08AB40.funcs["onPlayerExitVolume"] = ::_id_6118E2119E160883;
  _id_B8EBE3F71A08AB40.funcs["onPlayerExitTimeout"] = ::_id_E09F977D133BAC40;
  _id_B8EBE3F71A08AB40.funcs["onPlayerReenterVolume"] = ::_id_EE2041010CEE0AFC;
  _id_B8EBE3F71A08AB40.ref = "br_bomb";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40._id_40DBDB41F33299F7 = 0;
  _id_B8EBE3F71A08AB40.tier = _id_B8EBE3F71A08AB40.owner _id_744CAD313ED0A87E::_id_B7A9796C95AA8E8D();

  if(_id_B8EBE3F71A08AB40.tier == "black") {
    _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12 = 17;
    _id_B8EBE3F71A08AB40.mission_complete = 18;
    _id_B8EBE3F71A08AB40.mission_fail = 0;
    _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325 = 0;
  } else {
    _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12 = 17;
    _id_B8EBE3F71A08AB40.mission_complete = 18;
    _id_B8EBE3F71A08AB40.mission_fail = 0;
    _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325 = 0;
  }

  return _id_B8EBE3F71A08AB40;
}

_id_B883AD642CD900D6() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.origin = _id_B8EBE3F71A08AB40.owner.origin;
  _id_79B9C85900392AD6 = _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3.origin;
  _id_B8EBE3F71A08AB40.circlecenter = _id_79B9C85900392AD6;
  _id_B8EBE3F71A08AB40.circleradius = level._id_86260C6231072E89.circleradius;
  _id_B8EBE3F71A08AB40._id_B939ABDEDC45C697 = undefined;
}

_id_DD6410A59565D135(_id_FABF84450735DD93, player) {
  _id_B8EBE3F71A08AB40 = self;
  teams = [_id_FABF84450735DD93];
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_B8EBE3F71A08AB40.owner _id_744CAD313ED0A87E::_id_DACF98A6E7ACADEB(player, player.team);
  _id_4948CDF739393D2D::_id_D95DBF57B47734D9(_id_B8EBE3F71A08AB40.owner, 1);
  _id_B8EBE3F71A08AB40 thread _id_03314ADD7998AB13::_id_A33C10C0682918BD(_id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3, 9000);

  if(!isDefined(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C))
    _id_B8EBE3F71A08AB40._id_E438697DDBDC708C = [];

  if(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size < 1)
    _id_B8EBE3F71A08AB40 thread _id_36B22D1548152DA8();

  if(_id_AA128E29D7C10074) {
    _id_B8EBE3F71A08AB40 thread _id_5CBD566BCB47D26E();
    _id_B8EBE3F71A08AB40 _id_54FAC7DB1349C874(player);
    return;
  }

  _id_B8EBE3F71A08AB40 thread _id_5CBD566BCB47D26E();
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A92867E16C21DA22(_id_FABF84450735DD93);
  _id_B8EBE3F71A08AB40 _id_54FAC7DB1349C874(player);
}

_id_54FAC7DB1349C874(player) {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(scripts\engine\utility::array_find(_id_B8EBE3F71A08AB40.players, player))) {
    _id_A61C75B156FC1EE0 = _id_B8EBE3F71A08AB40.players.size;
    _id_B8EBE3F71A08AB40.players[_id_A61C75B156FC1EE0] = player;
  }

  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(_id_AA128E29D7C10074) {
    return;
  }
  _id_D0CB4E7EDBD1A617 = player getclientomnvar("ui_br_stronghold_mission");
  player thread scripts\mp\hud_message::showsplash("stronghold_operation_bomb_disposal");
  wait 4;

  if(!isDefined(player) || !scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.players, player)) {
    return;
  }
  if(_id_D0CB4E7EDBD1A617 == player getclientomnvar("ui_br_stronghold_mission")) {
    player setclientomnvar("ui_br_stronghold_mission", _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12);
    player setclientomnvar("ui_br_stronghold_mission_timer", _id_B8EBE3F71A08AB40.endtime);
  }

  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("br_mission_bomb_assigned", player);

  if(!isDefined(_id_B8EBE3F71A08AB40._id_B939ABDEDC45C697))
    _id_B8EBE3F71A08AB40._id_B939ABDEDC45C697 = player.team;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size; _id_AC0E594AC96AA3A8++)
    _id_B8EBE3F71A08AB40._id_E438697DDBDC708C[_id_AC0E594AC96AA3A8] enableplayeruse(player);
}

_id_1D932423D5491347(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_B8EBE3F71A08AB40.players = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.players, player);

  if(_id_AA128E29D7C10074) {
    return;
  }
  player setclientomnvar("ui_br_stronghold_mission", _id_B8EBE3F71A08AB40.mission_fail);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size; _id_AC0E594AC96AA3A8++)
    _id_B8EBE3F71A08AB40._id_E438697DDBDC708C[_id_AC0E594AC96AA3A8] disableplayeruse(player);
}

_id_7FEF8FE4178F164F(_id_FABF84450735DD93) {}

_id_19809AE1667B5C7A(_id_FABF84450735DD93, _id_B677BBE2241C4E3F, _id_AD590A75663898F3) {
  _id_B8EBE3F71A08AB40 = self;
  _id_A6AB8D0FDA441DC2 = _id_B8EBE3F71A08AB40 _id_03314ADD7998AB13::_id_AD20469C1815A7C7(_id_FABF84450735DD93, 0);
  _id_5F8FC154303502FA = _id_B8EBE3F71A08AB40 _id_03314ADD7998AB13::_id_AD20469C1815A7C7(_id_FABF84450735DD93, 1);
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_83ABCB9B3A5DBE24 = scripts\engine\utility::array_remove(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_83ABCB9B3A5DBE24, _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.id);
  _id_B8EBE3F71A08AB40.teams = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.teams, _id_FABF84450735DD93);
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93].active = 0;

  foreach(player in _id_5F8FC154303502FA) {
    _id_B8EBE3F71A08AB40.players = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.players, player);

    if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
      continue;
    }
    player setclientomnvar("ui_br_stronghold_mission", _id_B677BBE2241C4E3F);

    if(_id_B677BBE2241C4E3F == _id_B8EBE3F71A08AB40.mission_complete) {
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_bomb_disposal_completed");
      continue;
    }

    if(istrue(_id_AD590A75663898F3))
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_bomb_disposal_failed");
    else
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_bomb_disposal_poached");

    player setclientomnvar("ui_br_stronghold_mission", 0);
  }
}

_id_6118E2119E160883(player) {
  _id_B8EBE3F71A08AB40 = self;
  player._id_E09C6EA56555F1ED = 1;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!_id_AA128E29D7C10074)
    player setclientomnvar("ui_br_stronghold_mission", _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325);

  _id_F7A155995AD81EEC = gettime() + 9000;

  if(!_id_AA128E29D7C10074)
    player setclientomnvar("ui_br_stronghold_mission_timer", _id_F7A155995AD81EEC);
}

_id_EE2041010CEE0AFC(player) {
  _id_B8EBE3F71A08AB40 = self;
  player._id_E09C6EA56555F1ED = undefined;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!_id_AA128E29D7C10074) {
    player setclientomnvar("ui_br_stronghold_mission", _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12);
    player setclientomnvar("ui_br_stronghold_mission_timer", _id_B8EBE3F71A08AB40.endtime);
  }
}

_id_E09F977D133BAC40(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 _id_1D932423D5491347(player);
  player._id_E09C6EA56555F1ED = undefined;
  player._id_ED5A962D857703EC = undefined;

  if(isDefined(level._id_FC0E8C2EA4F84613))
    _id_B8EBE3F71A08AB40[[level._id_FC0E8C2EA4F84613]](player);
}

_id_02344407DC24EE69(_id_FABF84450735DD93, _id_AD590A75663898F3) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 notify("task_ended");
  _id_4948CDF739393D2D::_id_BE5A531F97B7C07E(_id_B8EBE3F71A08AB40.owner);

  if(isDefined(level._id_3AFACC0C3B10B7FE))
    _id_B8EBE3F71A08AB40.owner[[level._id_3AFACC0C3B10B7FE]](_id_FABF84450735DD93, !istrue(_id_AD590A75663898F3));

  _id_ED264F0DF8BF58FB = 0;

  foreach(team in _id_B8EBE3F71A08AB40.teams) {
    _id_0641C32466AF43F9 = 0;

    if(isDefined(_id_FABF84450735DD93) && isDefined(team))
      _id_0641C32466AF43F9 = team == _id_FABF84450735DD93;

    _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_fail;

    if(_id_0641C32466AF43F9) {
      _id_ED264F0DF8BF58FB = 1;
      _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_complete;
    }

    _id_B8EBE3F71A08AB40 _id_19809AE1667B5C7A(team, _id_B677BBE2241C4E3F, _id_AD590A75663898F3);
  }

  if(istrue(_id_AD590A75663898F3)) {
    _id_B8EBE3F71A08AB40.owner.crate thread _id_744CAD313ED0A87E::_id_FAA1ECBC7F0BED85(undefined, 0, 1, 1, 0);

    if(istrue(level._id_4AD06D80F390745E))
      thread _id_744CAD313ED0A87E::_id_182CB0E167AD745A(_id_B8EBE3F71A08AB40.owner, "high", level._id_6565786392240CDF, 0, 1);
  }

  if(!isDefined(_id_AD590A75663898F3))
    _id_AD590A75663898F3 = 0;

  _id_B8EBE3F71A08AB40.starttime = undefined;

  if(isDefined(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0) && isDefined(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129) && _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129.size >= 1 && (_id_ED264F0DF8BF58FB || _id_AD590A75663898F3)) {
    _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 notify("activity_ended");
    level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.id] = undefined;
    _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129 = undefined;
  }
}

_id_7D5530038BB0F3AD(instance, player, _id_EEB138FAE3842A92) {
  success = _id_2A647BF074AF9087(player, _id_EEB138FAE3842A92);

  if(success) {
    _id_E14909A9C0B08D64(player, _id_EEB138FAE3842A92);

    if(instance._id_E438697DDBDC708C.size <= 0) {
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      instance _id_02344407DC24EE69(player.team);
      _id_6C4E8CEA70BF4B6D::_id_6F6F83AB76483811(instance, player);
      instance.owner _id_4F1A578F63D4ED56(dropstruct, player);
      player _id_744CAD313ED0A87E::_id_9D216F4CD30F141D(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0), instance._id_B939ABDEDC45C697);
    }
  } else {
    if(!isDefined(_id_EEB138FAE3842A92)) {
      return;
    }
    _id_E14909A9C0B08D64(player, _id_EEB138FAE3842A92);
    instance thread _id_BA7471068B9CF103(_id_EEB138FAE3842A92);
  }
}

_id_2A647BF074AF9087(player, _id_EEB138FAE3842A92) {
  _id_B8EBE3F71A08AB40 = self;
  item = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(item, undefined, undefined, 0);
  player setweaponammostock(item, 0);
  player setweaponammoclip(item, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(item, 1);
  _id_3B5803E733581858 = 0;

  while(_id_3B5803E733581858 < 3.0 && gettime() < _id_B8EBE3F71A08AB40.endtime) {
    if(!isalive(player) || scripts\mp\utility\player::isinlaststand(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1 || player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      player scripts\cp_mp\utility\inventory_utility::getridofweapon("briefcase_bomb_mp");
      return 0;
    }

    _id_3B5803E733581858 = _id_3B5803E733581858 + level.framedurationseconds;
    waitframe();
  }

  if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player)) {
    player scripts\cp_mp\utility\inventory_utility::getridofweapon("briefcase_bomb_mp");

    if(gettime() < _id_B8EBE3F71A08AB40.endtime) {
      _id_B8EBE3F71A08AB40._id_E438697DDBDC708C = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C, _id_EEB138FAE3842A92);
      return 1;
    }
  }

  return 0;
}

_id_E9ABE9C2BF9878F0() {
  _id_B8EBE3F71A08AB40 = self;
  _id_4EAD6B4FF3816236 = getlootscriptablearrayinradius("br_loot_cache", undefined, _id_B8EBE3F71A08AB40.circlecenter, _id_B8EBE3F71A08AB40.circleradius);

  if(!isDefined(_id_4EAD6B4FF3816236))
    return undefined;

  _id_4EAD6B4FF3816236 = scripts\engine\utility::array_randomize(_id_4EAD6B4FF3816236);
  _id_06E7F9ED0BF7F726 = [0.1, 0.3, 0.5, 0.7, 0.9];
  _id_B038ED928EC17A81 = _id_B8EBE3F71A08AB40 _id_A77CBE5355057772(_id_4EAD6B4FF3816236, _id_06E7F9ED0BF7F726, 0);

  if(!isDefined(_id_B038ED928EC17A81)) {
    _id_06E7F9ED0BF7F726 = [0.1, 0.3, 0.5, 0.7, 0.9, 1.0];
    _id_B038ED928EC17A81 = _id_B8EBE3F71A08AB40 _id_A77CBE5355057772(_id_4EAD6B4FF3816236, _id_06E7F9ED0BF7F726, 0);
    _id_B8EBE3F71A08AB40 thread _id_02344407DC24EE69(undefined, 1);
  }

  _id_B038ED928EC17A81._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40._id_B038ED928EC17A81 = _id_B038ED928EC17A81;
  _id_B038ED928EC17A81.contents = [];
  _id_B038ED928EC17A81 _id_35768A5B1EBBA1A0();
  _id_B038ED928EC17A81.contents[1]["quantity"] = 50;
  _id_B038ED928EC17A81.contents[1]["lootID"] = 8395;
}

_id_A77CBE5355057772(locations, _id_E83038F37B2B5870, _id_8A0186F902BAFAEF) {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(_id_8A0186F902BAFAEF))
    _id_8A0186F902BAFAEF = 0;

  foreach(_id_11065B20B77735A3 in _id_E83038F37B2B5870) {
    foreach(_id_FE8F7703F6313ED4, node in locations) {
      if(istrue(node.inuse) && !_id_8A0186F902BAFAEF) {
        continue;
      }
      dist = distance2d(node.origin, _id_B8EBE3F71A08AB40.circlecenter);

      if(dist < _id_B8EBE3F71A08AB40.circleradius * _id_11065B20B77735A3) {
        if(_id_8A0186F902BAFAEF) {
          node.inuse = 0;
          node freescriptable();
        }

        return node;
      }
    }
  }

  return undefined;
}

_id_35768A5B1EBBA1A0() {
  _id_B038ED928EC17A81 = self;
  _id_B038ED928EC17A81.contents[0]["quantity"] = 1;
  _id_B038ED928EC17A81.contents[0]["lootID"] = 8608;
  _id_B038ED928EC17A81.contents[0]["callback"] = ::_id_7D5530038BB0F3AD;
}

_id_5CBD566BCB47D26E() {
  _id_B8EBE3F71A08AB40 = self;

  if(istrue(_id_B8EBE3F71A08AB40._id_6DFD52FC458DD6A0)) {
    return;
  }
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 endon("task_ended");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("deleted");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("activity_ended");
  waittime = _id_B8EBE3F71A08AB40.owner._id_CAB871D72C8EB111[0];
  _id_B8EBE3F71A08AB40._id_6DFD52FC458DD6A0 = 1;
  _id_B8EBE3F71A08AB40.starttime = gettime();
  _id_B8EBE3F71A08AB40.endtime = _id_B8EBE3F71A08AB40.starttime + waittime * 1000;
  _id_B8EBE3F71A08AB40 thread _id_C98C343E42951EA2(_id_B8EBE3F71A08AB40.endtime, 3000.0);
  wait(waittime);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size; _id_AC0E594AC96AA3A8++)
    _id_B8EBE3F71A08AB40 _id_1991FD659FA220BA(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C[_id_AC0E594AC96AA3A8]);

  _id_B8EBE3F71A08AB40 thread _id_02344407DC24EE69(undefined, 1);
}

_id_C98C343E42951EA2(_id_F28399727742EB23, offset) {
  _id_B8EBE3F71A08AB40 = self;
  level endon("game_ended");
  self endon("task_ended");
  currenttime = gettime();
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(_id_C301D652D9A73075 > 0 && isDefined(_id_B8EBE3F71A08AB40._id_EEB138FAE3842A92)) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 <= 7000 + offset) {
      if(_id_C301D652D9A73075 <= 250) {
        if(soundexists("breach_warning_beep_05"))
          _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 playSound("breach_warning_beep_05");
      } else if(_id_C301D652D9A73075 <= 750) {
        if(soundexists("breach_warning_beep_04"))
          _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 playSound("breach_warning_beep_04");
      } else if(_id_C301D652D9A73075 <= 1500) {
        if(soundexists("breach_warning_beep_03"))
          _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 playSound("breach_warning_beep_03");
      } else if(soundexists("breach_warning_beep_02"))
        _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 playSound("breach_warning_beep_02");

      wait 0.25;
      continue;
    }

    if(_id_C301D652D9A73075 <= 15000 + offset) {
      if(soundexists("breach_warning_beep_02"))
        _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 playSound("breach_warning_beep_02");

      wait 0.5;
      continue;
    }

    if(soundexists("breach_warning_beep_01"))
      _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 playSound("breach_warning_beep_01");

    wait 1.0;
  }
}

_id_682E6A05A3109EA1(_id_EEB138FAE3842A92) {
  _id_B8EBE3F71A08AB40 = self;
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 endon("task_ended");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("deleted");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("activity_ended");

  if(!isDefined(_id_EEB138FAE3842A92)) {
    return;
  }
  if(istrue(_id_EEB138FAE3842A92._id_D7BE9C77CE31B93D)) {
    return;
  }
  origin = _id_EEB138FAE3842A92.origin + (0, 0, 40);
  _id_EEB138FAE3842A92._id_D7BE9C77CE31B93D = 1;
  waitframe();
  waittillframeend;

  while(_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(origin) || _id_58F20490049AF6AC::_id_A465E3C1371D7DAB(origin))
    wait 0.5;

  _id_B8EBE3F71A08AB40 _id_1991FD659FA220BA(_id_EEB138FAE3842A92);

  if(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size <= 0)
    _id_B8EBE3F71A08AB40 thread _id_02344407DC24EE69(undefined, 1);

  return;
}

_id_1991FD659FA220BA(_id_EEB138FAE3842A92) {
  _id_B8EBE3F71A08AB40 = self;
  origin = _id_EEB138FAE3842A92.origin + (0, 0, 80);
  physicsexplosionsphere(origin, _id_B8EBE3F71A08AB40.circleradius, _id_B8EBE3F71A08AB40.circleradius / 2, 400);
  _id_EEB138FAE3842A92 radiusdamage(origin, 1024, 700, 100, _id_EEB138FAE3842A92, "MOD_EXPLOSIVE", "c4_mp");
  playsoundatpos(origin, "exp_bombsite_lr");
  playFX(level._effect["bomb_squad_explosion"], origin);
  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(origin, undefined, 3.5, _id_B8EBE3F71A08AB40.circleradius);

  if(isDefined(_id_EEB138FAE3842A92.visuals) && isDefined(_id_EEB138FAE3842A92.visuals[0]))
    _id_EEB138FAE3842A92.visuals[0] delete();

  _id_EEB138FAE3842A92 delete();

  foreach(player in _id_B8EBE3F71A08AB40.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

    if(_id_AA128E29D7C10074) {
      continue;
    }
    player thread scripts\mp\equipment\flash_grenade::applyflash(player, 1.0);
    player._id_E09C6EA56555F1ED = undefined;
    player._id_ED5A962D857703EC = undefined;
  }

  if(isDefined(_id_EEB138FAE3842A92))
    _id_B8EBE3F71A08AB40._id_E438697DDBDC708C = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C, _id_EEB138FAE3842A92);
  else if(isDefined(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C) && isDefined(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size) && _id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size <= 1)
    _id_B8EBE3F71A08AB40._id_E438697DDBDC708C = [];
}

_id_4F1A578F63D4ED56(dropstruct, player) {
  _id_276AC5E84835EA87 = self;
  _id_276AC5E84835EA87 _id_744CAD313ED0A87E::_id_5C26662D5381E975(player, undefined, undefined, 1);
  _id_84348B61E96B6C3C(dropstruct, player, _id_276AC5E84835EA87.crate);
}

_id_36B22D1548152DA8(_id_C3E0E015DE4435FD) {
  _id_B8EBE3F71A08AB40 = self;

  if(isDefined(_id_B8EBE3F71A08AB40.owner) && isDefined(_id_B8EBE3F71A08AB40.owner.crate)) {
    success = _id_1FB399BCAEB556A1(_id_B8EBE3F71A08AB40.owner.crate.origin, _id_C3E0E015DE4435FD);

    if(!istrue(success)) {
      logstring("BR STRONGHOLD " + scripts\engine\utility::array_find(level._id_F1073FBD45B59A06._id_DF987907A483DF89, _id_B8EBE3F71A08AB40.owner) + " : Failed to plant bomb.");
      return;
    }

    return;
  }

  _id_B8EBE3F71A08AB40._id_336A7187172CE931 = undefined;

  if(_id_B8EBE3F71A08AB40.owner._id_8ADD3FA98E073CE1.size > 0)
    _id_B8EBE3F71A08AB40._id_336A7187172CE931 = _id_B8EBE3F71A08AB40.owner._id_8ADD3FA98E073CE1;
  else if(_id_B8EBE3F71A08AB40.owner._id_2EF873E30A270BCF.size > 0)
    _id_B8EBE3F71A08AB40._id_336A7187172CE931 = _id_B8EBE3F71A08AB40.owner._id_2EF873E30A270BCF;

  while(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size < 1) {
    success = _id_B8EBE3F71A08AB40 _id_FFDE3EE5AE09D317(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C.size);

    if(!istrue(success)) {
      logstring("BR STRONGHOLD " + scripts\engine\utility::array_find(level._id_F1073FBD45B59A06._id_DF987907A483DF89, _id_B8EBE3F71A08AB40.owner) + " : Failed to plant bomb.");
      return;
    }
  }
}

_id_17608C84BBCDDD1C(_id_A68180FAAEBB813B) {
  _id_B8EBE3F71A08AB40 = self;
  _id_06E7F9ED0BF7F726 = [0.1, 0.3, 0.5, 0.7, 0.9];

  foreach(_id_11065B20B77735A3 in _id_06E7F9ED0BF7F726) {
    success = _id_7DF1F88002CC047E(_id_A68180FAAEBB813B, _id_11065B20B77735A3);

    if(istrue(success))
      return 1;
  }

  return 0;
}

_id_7DF1F88002CC047E(_id_A68180FAAEBB813B, _id_11065B20B77735A3) {
  _id_B8EBE3F71A08AB40 = self;
  safeorigin = undefined;

  for(_id_C4B448E975A0779B = 0; _id_C4B448E975A0779B < 10; _id_C4B448E975A0779B++) {
    safeorigin = _id_B8EBE3F71A08AB40.circlecenter + scripts\engine\utility::randomonunitsphere() * _id_B8EBE3F71A08AB40.circleradius * _id_11065B20B77735A3;
    safeorigin = getclosestpointonnavmesh(safeorigin);

    if(_id_31FFDCA84C5AA051(safeorigin)) {
      _id_B8EBE3F71A08AB40 _id_60F28D93D054020E(safeorigin, _id_A68180FAAEBB813B);
      return 1;
    }
  }

  return 0;
}

_id_31FFDCA84C5AA051(point) {
  if(isDefined(point)) {
    if(ispointonnavmesh(point))
      return 1;
  }

  return 0;
}

_id_60F28D93D054020E(safeorigin, _id_A68180FAAEBB813B, _id_F9CBFF5134DA960B, _id_C3E0E015DE4435FD) {
  _id_B8EBE3F71A08AB40 = self;
  _id_EEB138FAE3842A92 = undefined;
  _id_9B7391DBE8E49AE7 = undefined;
  _id_6D2552E5D036E732 = "offhand_2h_wm_briefcase_bomb_v0";

  if(istrue(_id_C3E0E015DE4435FD) && isDefined(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C) && isDefined(_id_B8EBE3F71A08AB40._id_E438697DDBDC708C[_id_A68180FAAEBB813B]))
    _id_EEB138FAE3842A92 = _id_B8EBE3F71A08AB40._id_E438697DDBDC708C[_id_A68180FAAEBB813B];

  offset = (0, 0, 22);
  safeorigin = safeorigin + offset;

  if(!istrue(_id_C3E0E015DE4435FD) || !isDefined(_id_EEB138FAE3842A92)) {
    _id_EEB138FAE3842A92 = spawn("script_model", safeorigin);
    _id_9B7391DBE8E49AE7 = 1;
  }

  _id_EEB138FAE3842A92.origin = safeorigin;

  if(isDefined(_id_F9CBFF5134DA960B)) {
    _id_6D2552E5D036E732 = "tag_origin";
    _id_EEB138FAE3842A92.startorigin = safeorigin;
  }

  if(!istrue(_id_C3E0E015DE4435FD) || istrue(_id_9B7391DBE8E49AE7)) {
    _id_EEB138FAE3842A92 setModel(_id_6D2552E5D036E732);
    _id_EEB138FAE3842A92.visuals = [];
    _id_EEB138FAE3842A92.visuals[0] = spawn("script_model", _id_EEB138FAE3842A92.origin);
    _id_EEB138FAE3842A92.visuals[0] setModel("tag_origin");
    _id_EEB138FAE3842A92.trigger = spawnStruct();
    _id_EEB138FAE3842A92.objidnum = -1;
    _id_B8EBE3F71A08AB40._id_E438697DDBDC708C[_id_A68180FAAEBB813B] = _id_EEB138FAE3842A92;
  }

  _id_EEB138FAE3842A92.curorigin = _id_EEB138FAE3842A92.origin;
  _id_EEB138FAE3842A92.safeorigin = _id_EEB138FAE3842A92.origin;
  _id_EEB138FAE3842A92 scripts\mp\gameobjects::setdropped(undefined, undefined);
  _id_B8EBE3F71A08AB40 thread _id_682E6A05A3109EA1(_id_EEB138FAE3842A92);
  _id_B8EBE3F71A08AB40 thread _id_BA7471068B9CF103(_id_EEB138FAE3842A92);
}

_id_BA62E3F440DC0288(player) {
  bomb = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(bomb, undefined, undefined, 0);
  player setweaponammostock(bomb, 0);
  player setweaponammoclip(bomb, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(bomb, 1);
  return bomb;
}

_id_BA7471068B9CF103(_id_EEB138FAE3842A92) {
  _id_B8EBE3F71A08AB40 = self;
  _id_EEB138FAE3842A92 makeusable();
  _id_EEB138FAE3842A92 disableplayeruseforallplayers();

  foreach(player in _id_B8EBE3F71A08AB40.players)
  _id_EEB138FAE3842A92 enableplayeruse(player);

  _id_EEB138FAE3842A92 setHintString(&"MP_DMZ_MISSIONS/DMZ_DESTROY_SAM_SAMSITE_DEFUSE_HINT");
  _id_EEB138FAE3842A92 sethinticon("ui_map_icon_obj_sh_bomb_defuse");
  _id_EEB138FAE3842A92 sethintdisplayrange(1024);
  _id_EEB138FAE3842A92 setuserange(90);
  _id_EEB138FAE3842A92 setCursorHint("HINT_BUTTON");
  _id_EEB138FAE3842A92 sethintdisplayfov(120);
  _id_EEB138FAE3842A92 setusefov(120);
  _id_EEB138FAE3842A92 sethintrequiresholding(1);
  _id_EEB138FAE3842A92 setuseholdduration("duration_short");
  _id_B8EBE3F71A08AB40._id_EEB138FAE3842A92 = _id_EEB138FAE3842A92;
  _id_EEB138FAE3842A92 waittill("trigger", player);
  _id_BA62E3F440DC0288(player);
  _id_EEB138FAE3842A92 hide();
  _id_EEB138FAE3842A92 makeunusable();
  _id_7D5530038BB0F3AD(_id_B8EBE3F71A08AB40, player, _id_EEB138FAE3842A92);
}

_id_E14909A9C0B08D64(player, _id_EEB138FAE3842A92) {
  droporigin = player.origin;

  if(isDefined(_id_EEB138FAE3842A92.startorigin)) {
    droporigin = _id_EEB138FAE3842A92.startorigin;
    _id_EEB138FAE3842A92 show();
    _id_EEB138FAE3842A92.trigger.origin = droporigin;
  } else {
    safeorigin = getclosestpointonnavmesh(droporigin);
    _id_EEB138FAE3842A92.origin = safeorigin;
    _id_EEB138FAE3842A92.trigger.origin = safeorigin;
  }
}

_id_FFDE3EE5AE09D317(_id_A68180FAAEBB813B) {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(_id_B8EBE3F71A08AB40._id_336A7187172CE931))
    return 0;

  _id_BAC262A232C827C2 = _id_B8EBE3F71A08AB40._id_336A7187172CE931[randomint(_id_B8EBE3F71A08AB40._id_336A7187172CE931.size)];
  safeorigin = getclosestpointonnavmesh(_id_BAC262A232C827C2.origin);

  if(_id_31FFDCA84C5AA051(safeorigin)) {
    _id_B8EBE3F71A08AB40 _id_60F28D93D054020E(safeorigin, _id_A68180FAAEBB813B);
    _id_B8EBE3F71A08AB40._id_336A7187172CE931 = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40._id_336A7187172CE931, _id_BAC262A232C827C2);
    return 1;
  }

  return 0;
}

_id_1FB399BCAEB556A1(origin, _id_C3E0E015DE4435FD) {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(origin))
    return 0;

  safeorigin = getclosestpointonnavmesh(origin);

  if(_id_31FFDCA84C5AA051(safeorigin)) {
    _id_B8EBE3F71A08AB40 _id_60F28D93D054020E(safeorigin, 0, 1, _id_C3E0E015DE4435FD);
    return 1;
  }

  return 0;
}

_id_84348B61E96B6C3C(dropstruct, player, crate) {
  _id_557E3AE920E08A75 = getdvarint("dvar_3174D9A2553A5FA7", -1);
  _id_75EA56AC509FED3B = getscriptcachecontents("bomb_defuse_reward", 0);
  _id_DF2F68507645906F = ["brloot_super_munitionsbox", "brloot_super_armorbox"];
  _id_F2B8863302006284 = undefined;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team, player._id_0FF97225579DE16A, 0);

  if(isDefined(_id_6D5ED003AF1F9612))
    _id_F2B8863302006284 = _id_6D5ED003AF1F9612.size;

  if(_id_557E3AE920E08A75 >= 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_557E3AE920E08A75; _id_AC0E594AC96AA3A8++) {
      _id_610520BE555433B2 = randomintrange(0, 25);
      _id_75EA56AC509FED3B = getscriptcachecontents("bomb_defuse_reward", _id_610520BE555433B2);
      _id_38BF039A4DF5D1AC(dropstruct, player, crate, _id_75EA56AC509FED3B);
    }
  } else if(isDefined(_id_F2B8863302006284)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F2B8863302006284; _id_AC0E594AC96AA3A8++) {
      _id_610520BE555433B2 = randomintrange(0, 25);
      _id_75EA56AC509FED3B = getscriptcachecontents("bomb_defuse_reward", _id_610520BE555433B2);
      _id_75EA56AC509FED3B[_id_75EA56AC509FED3B.size] = _id_DF2F68507645906F[_id_AC0E594AC96AA3A8 % _id_DF2F68507645906F.size];
      _id_38BF039A4DF5D1AC(dropstruct, player, crate, _id_75EA56AC509FED3B);
    }
  } else
    _id_38BF039A4DF5D1AC(dropstruct, player, crate, _id_75EA56AC509FED3B);

  if(getdvarint("dvar_81E631C248118CD6", 1) != 1)
    return;
  else {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
    count = undefined;
    spawned = _id_7E52B56769FA7774::spawnpickup("brloot_gascan_palfa", _id_CB4FAD49263E20C4, count);
  }
}

_id_38BF039A4DF5D1AC(dropstruct, player, crate, _id_75EA56AC509FED3B) {
  if(isDefined(crate) && getdvarint("dvar_13C3754911CCA521", 1)) {
    crate.itemsdropped = 0;
    crate _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, _id_75EA56AC509FED3B, 1, player);
    return;
  }

  count = undefined;

  foreach(_id_5B63AED4A779B0AA in _id_75EA56AC509FED3B) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
    count = level.br_pickups.counts[_id_5B63AED4A779B0AA];
    spawned = _id_7E52B56769FA7774::spawnpickup(_id_5B63AED4A779B0AA, _id_CB4FAD49263E20C4, count);

    if(isDefined(spawned))
      spawned setscriptablepartstate(_id_5B63AED4A779B0AA, "dropped");
  }
}