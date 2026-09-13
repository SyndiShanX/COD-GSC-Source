/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_ef36a50d9b4627d.gsc
***********************************************/

_id_7AAE8CB0D8B0AC6A(data) {
  level._id_7137DE4E4FB0399B = spawnStruct();
  level._id_7137DE4E4FB0399B.circleradius = getdvarint("dvar_35E83D2A6CDA99B8", 2000);
  level._id_7137DE4E4FB0399B._id_BF9C07649959C8CB = getdvarint("dvar_B3B453252C46E3B0", 1000);
  level._id_7137DE4E4FB0399B._id_24972DB4C00B613B = level._id_7137DE4E4FB0399B._id_BF9C07649959C8CB * level._id_7137DE4E4FB0399B._id_BF9C07649959C8CB;
  level._id_7137DE4E4FB0399B._id_ED2E5CF91BFF3A6F = getdvarfloat("dvar_75C1CF1A1116077D", 0.65);
  data._id_68E354FCEB08D97B = ::_id_FEFD14A6940E2B99;
}

_id_FEFD14A6940E2B99(_id_EFA8EF05B190D7D0, owner) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.owner = owner;
  owner._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40.players = [];
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_0380918284873494;
  _id_B8EBE3F71A08AB40.funcs["onPlayerAssigned"] = ::_id_DD6410A59565D135;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_5F7CD2F25352A816;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_12A444ED47D9C24D;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_0A5870532237F7AD;
  _id_B8EBE3F71A08AB40.funcs["onPlayerExitVolume"] = ::_id_BB405816FB180A81;
  _id_B8EBE3F71A08AB40.funcs["onPlayerExitTimeout"] = ::_id_E09F977D133BAC40;
  _id_B8EBE3F71A08AB40.funcs["onPlayerReenterVolume"] = ::_id_0A0E410E1941CB7A;
  _id_B8EBE3F71A08AB40.ref = "br_poi";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40._id_40DBDB41F33299F7 = 0;
  _id_B8EBE3F71A08AB40.tier = _id_B8EBE3F71A08AB40.owner _id_744CAD313ED0A87E::_id_B7A9796C95AA8E8D();

  if(_id_B8EBE3F71A08AB40.tier == "black") {
    _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12 = 20;
    _id_B8EBE3F71A08AB40.mission_complete = 21;
    _id_B8EBE3F71A08AB40.mission_fail = 36;
    _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325 = 0;
  } else {
    _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12 = 20;
    _id_B8EBE3F71A08AB40.mission_complete = 21;
    _id_B8EBE3F71A08AB40.mission_fail = 36;
    _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325 = 0;
  }

  return _id_B8EBE3F71A08AB40;
}

_id_0380918284873494() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.origin = _id_B8EBE3F71A08AB40.owner.origin;
  _id_79B9C85900392AD6 = _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3.origin;
  _id_B8EBE3F71A08AB40.circlecenter = _id_79B9C85900392AD6;
  _id_B8EBE3F71A08AB40.circleradius = level._id_7137DE4E4FB0399B.circleradius;
}

_id_DD6410A59565D135(_id_FABF84450735DD93, player) {
  _id_B8EBE3F71A08AB40 = self;
  teams = [_id_FABF84450735DD93];
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_B8EBE3F71A08AB40.owner _id_744CAD313ED0A87E::_id_DACF98A6E7ACADEB(player, player.team);
  _id_4948CDF739393D2D::_id_D95DBF57B47734D9(_id_B8EBE3F71A08AB40.owner, 1);
  _id_B8EBE3F71A08AB40 thread _id_03314ADD7998AB13::_id_A33C10C0682918BD(_id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3, 9000);

  if(!istrue(_id_B8EBE3F71A08AB40.owner._id_B6B4E335D507B8B4)) {
    _id_B8EBE3F71A08AB40.owner notify("brStronghold_spawnBoss");
    _id_B8EBE3F71A08AB40.owner waittill("brStronghold_spawnedBoss");
  }

  _id_B8EBE3F71A08AB40.target = _id_B8EBE3F71A08AB40.owner._id_837C4B569AA8A376[randomint(_id_B8EBE3F71A08AB40.owner._id_837C4B569AA8A376.size)];
  _id_B8EBE3F71A08AB40 thread _id_92EFD6EB7EC14081();
  _id_B8EBE3F71A08AB40 _id_B005A227C7052BAB();

  if(_id_AA128E29D7C10074) {
    _id_B8EBE3F71A08AB40 thread _id_5CBD566BCB47D26E();
    _id_B8EBE3F71A08AB40 _id_5F7CD2F25352A816(player);
    return;
  }

  _id_B8EBE3F71A08AB40 thread _id_5CBD566BCB47D26E(player);
  _id_B8EBE3F71A08AB40 thread _id_682E6A05A3109EA1(player);
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A92867E16C21DA22(_id_FABF84450735DD93);
  _id_B8EBE3F71A08AB40 _id_5F7CD2F25352A816(player);
}

_id_5F7CD2F25352A816(player) {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(scripts\engine\utility::array_find(_id_B8EBE3F71A08AB40.players, player))) {
    _id_A61C75B156FC1EE0 = _id_B8EBE3F71A08AB40.players.size;
    _id_B8EBE3F71A08AB40.players[_id_A61C75B156FC1EE0] = player;
  }

  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(_id_AA128E29D7C10074) {
    return;
  }
  player thread scripts\mp\hud_message::showsplash("stronghold_operation_person_of_interest");
  wait 4;

  if(!isDefined(player) || !scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.players, player)) {
    return;
  }
  if(!istrue(level._id_870ABCBF773FBD8C))
    player setclientomnvar("ui_br_stronghold_mission_timer", 0);
  else
    player setclientomnvar("ui_br_stronghold_mission_timer", _id_B8EBE3F71A08AB40.endtime);
}

_id_12A444ED47D9C24D(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_B8EBE3F71A08AB40.players = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.players, player);

  if(_id_AA128E29D7C10074)
    return;
}

_id_0A5870532237F7AD(_id_FABF84450735DD93) {}

_id_AD51A965D4943B34(_id_FABF84450735DD93, _id_B677BBE2241C4E3F, _id_775B616D3BF0BF29) {
  _id_B8EBE3F71A08AB40 = self;
  _id_6E3C5FD99F4FCFB1 = scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.teams, _id_FABF84450735DD93);
  _id_5F8FC154303502FA = scripts\mp\utility\player::getteamarray(_id_FABF84450735DD93);
  _id_DB62C0CFC8A661CC = level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93];

  if(isDefined(_id_DB62C0CFC8A661CC)) {
    _id_DB62C0CFC8A661CC._id_83ABCB9B3A5DBE24 = scripts\engine\utility::array_remove(_id_DB62C0CFC8A661CC._id_83ABCB9B3A5DBE24, _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.id);
    _id_DB62C0CFC8A661CC.active = 0;
  }

  foreach(player in _id_5F8FC154303502FA) {
    if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
      continue;
    }
    if(_id_B677BBE2241C4E3F == _id_B8EBE3F71A08AB40.mission_complete) {
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_person_of_interest_completed");
      continue;
    }

    if(_id_6E3C5FD99F4FCFB1) {
      if(istrue(_id_775B616D3BF0BF29))
        player thread scripts\mp\hud_message::showsplash("stronghold_operation_person_of_interest_failed");
    }
  }
}

_id_BB405816FB180A81(player) {
  _id_B8EBE3F71A08AB40 = self;
  player._id_E09C6EA56555F1ED = 1;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_F7A155995AD81EEC = gettime() + 9000;

  if(!_id_AA128E29D7C10074)
    player setclientomnvar("ui_br_stronghold_mission_timer", _id_F7A155995AD81EEC);
}

_id_0A0E410E1941CB7A(player) {
  _id_B8EBE3F71A08AB40 = self;
  player._id_E09C6EA56555F1ED = undefined;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!_id_AA128E29D7C10074) {
    if(!istrue(level._id_870ABCBF773FBD8C))
      player setclientomnvar("ui_br_stronghold_mission_timer", 0);
    else
      player setclientomnvar("ui_br_stronghold_mission_timer", _id_B8EBE3F71A08AB40.endtime);
  }
}

_id_E09F977D133BAC40(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 _id_12A444ED47D9C24D(player);
  player._id_E09C6EA56555F1ED = undefined;
  player._id_ED5A962D857703EC = undefined;

  if(isDefined(level._id_FC0E8C2EA4F84613))
    _id_B8EBE3F71A08AB40[[level._id_FC0E8C2EA4F84613]](player);
}

_id_947515FBDC68B22B(_id_FABF84450735DD93, failed) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 notify("task_ended");
  _id_4948CDF739393D2D::_id_BE5A531F97B7C07E(_id_B8EBE3F71A08AB40.owner);
  _id_ED264F0DF8BF58FB = 0;
  _id_276AC5E84835EA87 = _id_B8EBE3F71A08AB40.owner;
  teams = _id_B8EBE3F71A08AB40.teams;

  if(isDefined(_id_276AC5E84835EA87._id_0E2BDCA417396359))
    teams = scripts\engine\utility::array_combine_unique(teams, _id_276AC5E84835EA87._id_0E2BDCA417396359);

  foreach(team in teams) {
    _id_0641C32466AF43F9 = 0;

    if(isDefined(_id_FABF84450735DD93))
      _id_0641C32466AF43F9 = team == _id_FABF84450735DD93;

    _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_fail;

    if(_id_0641C32466AF43F9) {
      _id_ED264F0DF8BF58FB = 1;
      _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_complete;
    }

    _id_B8EBE3F71A08AB40 _id_AD51A965D4943B34(team, _id_B677BBE2241C4E3F, failed);
  }

  _id_B8EBE3F71A08AB40.players = [];
  _id_B8EBE3F71A08AB40.teams = [];
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  if(isDefined(_id_B8EBE3F71A08AB40.headicon))
    deleteheadicon(_id_B8EBE3F71A08AB40.headicon);

  if(!isDefined(failed))
    failed = 0;

  _id_B8EBE3F71A08AB40.starttime = undefined;

  if(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129.size >= 1 && (_id_ED264F0DF8BF58FB || failed)) {
    _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 notify("activity_ended");
    level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.id] = undefined;
    _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129 = undefined;
  }

  if(isDefined(level._id_3AFACC0C3B10B7FE))
    _id_B8EBE3F71A08AB40.owner[[level._id_3AFACC0C3B10B7FE]](_id_FABF84450735DD93, !istrue(failed));
}

_id_5CBD566BCB47D26E(player) {
  _id_B8EBE3F71A08AB40 = self;

  if(!istrue(level._id_870ABCBF773FBD8C)) {
    return;
  }
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
  wait(waittime);
  player._id_E09C6EA56555F1ED = undefined;
  player._id_ED5A962D857703EC = undefined;
  _id_B8EBE3F71A08AB40 thread _id_947515FBDC68B22B(undefined, 1);
}

_id_682E6A05A3109EA1(player) {
  _id_B8EBE3F71A08AB40 = self;
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 endon("task_ended");

  if(istrue(level._id_B2A3E71C256922AC) && istrue(_id_B8EBE3F71A08AB40.owner._id_933F9685674999FB)) {
    return;
  }
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("deleted");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("activity_ended");
  origin = _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.origin + (0, 0, 40);

  while(_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(origin) || _id_58F20490049AF6AC::_id_A465E3C1371D7DAB(origin))
    wait 0.5;

  player._id_E09C6EA56555F1ED = undefined;
  player._id_ED5A962D857703EC = undefined;
  _id_B8EBE3F71A08AB40 thread _id_947515FBDC68B22B(undefined, 1);
  return;
}

_id_385995505B4FD624(dropstruct, player, _id_276AC5E84835EA87) {
  _id_B8EBE3F71A08AB40 = self;
  _id_276AC5E84835EA87 _id_744CAD313ED0A87E::_id_5C26662D5381E975(player, undefined, "directional_uav", 0);
  _id_501265B5FE210821 = _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11;

  foreach(player in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_501265B5FE210821);
    player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(1, _id_501265B5FE210821);
  }

  _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, player.team);

  foreach(player in level.players) {
    if(getdvarint("dvar_90582331A88CC477", 0))
      player thread scripts\mp\hud_message::showsplash("stronghold_complete_no_gamertags_blacksite");
    else
      player thread scripts\mp\hud_message::showsplash("stronghold_complete_blacksite", _id_3EDA0EF65C9478AC);

    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("blacksite_clear", player);
  }

  if(!istrue(_id_276AC5E84835EA87._id_933F9685674999FB))
    player _id_744CAD313ED0A87E::_id_9D216F4CD30F141D(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0));
}

_id_92EFD6EB7EC14081() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 endon("task_ended");
  _id_B8EBE3F71A08AB40.target waittill("death");
  ent = _id_B8EBE3F71A08AB40.target.lastattacker;
  player = ent;

  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ent.owner))
    player = ent.owner;

  isvalidplayer = isDefined(player) && isPlayer(player) && isalive(player);

  if(isvalidplayer) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_A91D0874AFB8A157(dropstruct, _id_B8EBE3F71A08AB40.target, player);
    _id_6C4E8CEA70BF4B6D::_id_6F6F83AB76483811(_id_B8EBE3F71A08AB40, player);
    _id_B8EBE3F71A08AB40 _id_385995505B4FD624(dropstruct, player, _id_B8EBE3F71A08AB40.owner);
    _id_B8EBE3F71A08AB40 thread _id_947515FBDC68B22B(player.team);
  } else
    _id_B8EBE3F71A08AB40 thread _id_947515FBDC68B22B(undefined, 1);
}

_id_B005A227C7052BAB() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40.headicon = createheadicon(_id_B8EBE3F71A08AB40.target);
  setheadiconenemyimage(_id_B8EBE3F71A08AB40.headicon, "ui_map_icon_boss_juggernaut");
  setheadicondrawthroughgeo(_id_B8EBE3F71A08AB40.headicon, 1);
  setheadiconsnaptoedges(_id_B8EBE3F71A08AB40.headicon, 0);
  setheadiconmaxdistance(_id_B8EBE3F71A08AB40.headicon, 2048);
  setheadiconnaturaldistance(_id_B8EBE3F71A08AB40.headicon, 30);
  setheadiconzoffset(_id_B8EBE3F71A08AB40.headicon, 10);
}

_id_A91D0874AFB8A157(dropstruct, _id_E2958F412A7425C0, player) {
  _id_87D58FDCEDCFE1B6 = getdvarint("dvar_623A5FBF8A2EDA3E", -1);
  _id_9D966F1AC46CFB6A = getdvarint("dvar_763D715FF5888239", 1);
  _id_6A2E08F957D1B294 = getscriptcachecontents("blacksite_boss_backpack", 0);

  if(level._id_60FDD9E24D99E3CE)
    _id_DF2F68507645906F = ["brloot_self_revive", "brloot_plunder_cash_rare_2"];
  else
    _id_DF2F68507645906F = ["brloot_redeploy_token", "brloot_self_revive"];

  _id_F2B8863302006284 = undefined;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  if(isDefined(_id_6D5ED003AF1F9612))
    _id_F2B8863302006284 = _id_6D5ED003AF1F9612.size;

  if(_id_87D58FDCEDCFE1B6 >= 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_87D58FDCEDCFE1B6; _id_AC0E594AC96AA3A8++) {
      _id_610520BE555433B2 = randomintrange(0, 25);
      _id_6A2E08F957D1B294 = getscriptcachecontents("blacksite_boss_backpack", _id_610520BE555433B2);
      _id_A47BC792E66B0FB7(dropstruct, _id_E2958F412A7425C0, _id_6A2E08F957D1B294);
    }
  } else if(isDefined(_id_F2B8863302006284)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F2B8863302006284; _id_AC0E594AC96AA3A8++) {
      _id_610520BE555433B2 = randomintrange(0, 25);
      _id_6A2E08F957D1B294 = getscriptcachecontents("blacksite_boss_backpack", _id_610520BE555433B2);
      _id_6A2E08F957D1B294[_id_6A2E08F957D1B294.size] = _id_DF2F68507645906F[_id_AC0E594AC96AA3A8 % _id_DF2F68507645906F.size];
      _id_A47BC792E66B0FB7(dropstruct, _id_E2958F412A7425C0, _id_6A2E08F957D1B294);
    }
  } else
    _id_A47BC792E66B0FB7(dropstruct, _id_E2958F412A7425C0, _id_6A2E08F957D1B294);

  if(_id_9D966F1AC46CFB6A) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_E2958F412A7425C0.origin, _id_E2958F412A7425C0.angles, _id_E2958F412A7425C0);
    spawned = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_auav", _id_CB4FAD49263E20C4);

    if(isDefined(spawned))
      spawned setscriptablepartstate("brloot_killstreak_auav", "dropped");
  }
}

_id_A47BC792E66B0FB7(dropstruct, _id_E2958F412A7425C0, _id_6A2E08F957D1B294) {
  count = undefined;

  foreach(_id_5B63AED4A779B0AA in _id_6A2E08F957D1B294) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_E2958F412A7425C0.origin, _id_E2958F412A7425C0.angles, _id_E2958F412A7425C0);
    count = level.br_pickups.counts[_id_5B63AED4A779B0AA];
    spawned = _id_7E52B56769FA7774::spawnpickup(_id_5B63AED4A779B0AA, _id_CB4FAD49263E20C4, count);

    if(isDefined(spawned))
      spawned setscriptablepartstate(_id_5B63AED4A779B0AA, "dropped");
  }
}