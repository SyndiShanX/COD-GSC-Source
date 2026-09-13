/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1d4b01c1ec829364.gsc
***********************************************/

_id_AA0D1F90DCC5D366() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
}

_id_D23C7C1ADD9FB181() {
  _id_9F098B6FC547A435 = undefined;
  _id_42CA41C7DADAE0C0 = undefined;

  foreach(objective in level.objectives) {
    dist = distancesquared(self.origin, objective.curorigin);

    if(!isDefined(_id_9F098B6FC547A435) || dist < _id_42CA41C7DADAE0C0) {
      _id_9F098B6FC547A435 = objective;
      _id_42CA41C7DADAE0C0 = dist;
    }
  }

  return _id_9F098B6FC547A435;
}

_id_1629419647B0F862() {
  level._id_1E17E3480B1D264D = 1;
  level.armoronweaponswitchlongpress = 1;
  level._id_44334833E57B459B = 1;
  _id_4384ABBF498DF6A7::init();
  level._id_6BEFF7B631AB7E18 = ::_id_6BEFF7B631AB7E18;
  level._id_3C8E175D92BE01EA = ::_id_8529632B1FDB55A6;
  level.modifyvehicledamage = ::modifyvehicledamage;
  level._id_468B95F3865FA8D3 = ::_id_468B95F3865FA8D3;
  level._id_95344EC32AA27F24 = getdvarfloat("dvar_FD13071A3EC6F158", 0.85);
  level._id_953451C32AA285BD = getdvarfloat("dvar_FD130A1A3EC6F7F1", 0.7);
  level._id_38931344C1BE4D04 = getdvarint("dvar_8062B21F870DE073", 12);
  _id_33CFB91C1B214E68 = [];
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "research_upgrade_uav";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "research_upgrade_vehicle";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "research_upgrade_defense";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "uav_ping";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "uav_ping_radius";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "uav_ping_duration";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "uav_ping_global";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 1;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_33CFB91C1B214E68[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_4DF9C45025851E63 = [];
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "defense_spawn_armor_tier_1";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "defense_spawn_armor_tier_2";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "defense_spawn_plate_tier_1";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "defense_spawn_plate_tier_2";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "vehicle_defense_tier_1";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "vehicle_defense_tier_2";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  _id_DAEE941F6CB91F8B = spawnStruct();
  _id_DAEE941F6CB91F8B.ref = "vehicle_apc_improved_ammo";
  _id_DAEE941F6CB91F8B._id_281A794A27857A0E = 0;
  _id_DAEE941F6CB91F8B._id_98EAFCAE335D563A = 0;
  _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF = 1;
  _id_DAEE941F6CB91F8B._id_4B408A373268157D = 0;
  _id_DAEE941F6CB91F8B._id_492DBA79ACAAC7E0 = 10;
  _id_4DF9C45025851E63[_id_DAEE941F6CB91F8B.ref] = _id_DAEE941F6CB91F8B;
  level._id_73E72117ADA9CCE6 = getdvarfloat("dvar_A19BC7851E3C41B6", level.flagcapturetime * 2.0);
  level._id_5B25E7620E424CB2 = [];
  level._id_F2AFBE97539D175D = [];

  foreach(team in level.teamnamelist)
  level._id_F2AFBE97539D175D[team] = [];

  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);

  while(level.objectives.size == 0)
    waitframe();

  _id_198C1217542D88CD = [];
  _id_EADBD277474BB8BD = scripts\engine\utility::getStructArray("buystation_loc", "targetname");

  foreach(ent in _id_EADBD277474BB8BD)
  _id_198C1217542D88CD[ent.script_label] = ent;

  foreach(key, objective in level.objectives) {
    groundorigin = (0, 0, 0);
    spawnangles = (0, 0, 0);

    if(isDefined(_id_198C1217542D88CD[key])) {
      groundorigin = _id_198C1217542D88CD[key].origin;
      spawnangles = _id_198C1217542D88CD[key].angles;
    } else {
      groundorigin = scripts\engine\utility::drop_to_ground(objective.curorigin + anglesToForward(objective.trigger.angles) * 50, 50, -200, undefined, _id_FBCABD62B8F66EB8);
      spawnangles = objective.trigger.angles;
    }

    _id_2FA65F34EB9042F5 = spawnscriptable("br_plunder_box", groundorigin, spawnangles);
    _id_2FA65F34EB9042F5.objectivekey = key;
    level._id_5B25E7620E424CB2[key] = _id_2FA65F34EB9042F5;
    _id_2FA65F34EB9042F5 setscriptablepartstate("br_plunder_box", "visible");
    _id_2FA65F34EB9042F5._id_5CFA621EBF61D8AA = 0;
    _id_661AF64C95CE055D = spawnStruct();
    _id_661AF64C95CE055D.tier = 0;
    _id_661AF64C95CE055D._id_33CFB91C1B214E68 = _id_33CFB91C1B214E68;

    foreach(team in level.teamnamelist)
    level._id_F2AFBE97539D175D[team][key] = _id_661AF64C95CE055D;
  }

  _id_661AF64C95CE055D = spawnStruct();
  _id_661AF64C95CE055D._id_33CFB91C1B214E68 = _id_4DF9C45025851E63;

  foreach(team in level.teamnamelist)
  level._id_F2AFBE97539D175D[team]["global"] = _id_661AF64C95CE055D;

  level thread _id_C800466F69DFC582();
}

_id_6BEFF7B631AB7E18(instance, player) {
  if(istrue(instance._id_5CFA621EBF61D8AA) || istrue(level._id_8E9DABA162280A8E))
    player setclientomnvar("ui_buystation_override", _id_600B944A95C3A7BF::_id_54B046AA3BA2678A("personalOnly"));

  _id_F4802CADF5F79275 = getDvar(_func_2EF675C13CA1C4AF("dvar_0DE61CD75A31AB28", instance.objectivekey), "");

  if(_id_F4802CADF5F79275 != "") {
    _id_47DF3A792140C443 = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(_id_F4802CADF5F79275 + "_tier_" + level._id_F2AFBE97539D175D[player.team][instance.objectivekey].tier);

    if(!isDefined(_id_47DF3A792140C443))
      _id_47DF3A792140C443 = _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(_id_F4802CADF5F79275);

    if(isDefined(_id_47DF3A792140C443))
      player setclientomnvar("ui_buystation_override", _id_47DF3A792140C443);
  }

  player _id_E29957ADFBE3C040(instance.objectivekey);
}

_id_E29957ADFBE3C040(objectivekey) {
  _id_5C9DDCF56D36F133 = 0;

  if(istrue(level._id_F2AFBE97539D175D[self.team][objectivekey]._id_33CFB91C1B214E68["uav_ping"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 1;

  if(istrue(level._id_F2AFBE97539D175D[self.team][objectivekey]._id_33CFB91C1B214E68["uav_ping_radius"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 2;

  if(istrue(level._id_F2AFBE97539D175D[self.team][objectivekey]._id_33CFB91C1B214E68["uav_ping_duration"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 4;

  if(istrue(level._id_F2AFBE97539D175D[self.team][objectivekey]._id_33CFB91C1B214E68["uav_ping_global"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 8;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["defense_spawn_armor_tier_1"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 16;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["defense_spawn_armor_tier_2"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 32;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["defense_spawn_plate_tier_1"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 64;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["defense_spawn_plate_tier_2"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 128;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["vehicle_defense_tier_1"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 256;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["vehicle_defense_tier_2"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 512;

  if(istrue(level._id_F2AFBE97539D175D[self.team]["global"]._id_33CFB91C1B214E68["vehicle_apc_improved_ammo"]._id_281A794A27857A0E))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 1024;

  self setclientomnvar("ui_upgrade_status", _id_5C9DDCF56D36F133);
}

_id_C800466F69DFC582() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level._id_7F5BE0207E7457B1)) {
    return;
  }
  foreach(key, _id_2FA65F34EB9042F5 in level._id_5B25E7620E424CB2) {
    foreach(team in level.teamnamelist)
    _id_2FA65F34EB9042F5 _id_8D03978A31FABA3A(key, team);
  }
}

_id_6ED651811C936A22() {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(istrue(level._id_7F5BE0207E7457B1)) {
    return;
  }
  foreach(key, _id_2FA65F34EB9042F5 in level._id_5B25E7620E424CB2) {
    ownerteam = level.objectives[key] scripts\mp\gameobjects::getownerteam();

    if(self.team == ownerteam) {
      _id_2FA65F34EB9042F5 enablescriptableplayeruse(self);
      continue;
    }

    _id_2FA65F34EB9042F5 disablescriptableplayeruse(self);
  }
}

_id_E8A6E840EF663C81(key, team) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(istrue(level._id_7F5BE0207E7457B1)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  foreach(player in level.players) {
    if(player.team == team) {
      level._id_5B25E7620E424CB2[key] enablescriptableplayeruse(player);
      continue;
    }

    level._id_5B25E7620E424CB2[key] disablescriptableplayeruse(player);
  }
}

_id_8D03978A31FABA3A(key, team) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  level._id_5B25E7620E424CB2[key] disablescriptableplayeruse(player);
}

_id_4DE8052758F986F3(objectivekey, team, ref) {
  if(!istrue(level._id_44334833E57B459B))
    return 0;

  if(scripts\engine\utility::array_contains_key(level._id_F2AFBE97539D175D[team]["global"]._id_33CFB91C1B214E68, ref))
    _id_639A73C27056BE13 = level._id_F2AFBE97539D175D[team]["global"]._id_33CFB91C1B214E68[ref];
  else
    _id_639A73C27056BE13 = level._id_F2AFBE97539D175D[team][objectivekey]._id_33CFB91C1B214E68[ref];

  return _id_639A73C27056BE13._id_281A794A27857A0E;
}

_id_3CE1055115EDCBBB(player, ref) {
  if(!istrue(level._id_44334833E57B459B))
    return 0;

  objective = player _id_D23C7C1ADD9FB181();

  if(objective.ownerteam != player.team)
    return 0;

  _id_362ACC2689BEBAE8(objective.objectivekey, player.team, ref);
  return 1;
}

_id_362ACC2689BEBAE8(objectivekey, team, ref) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(scripts\engine\utility::array_contains_key(level._id_F2AFBE97539D175D[team]["global"]._id_33CFB91C1B214E68, ref))
    objectivekey = "global";

  _id_639A73C27056BE13 = level._id_F2AFBE97539D175D[team][objectivekey]._id_33CFB91C1B214E68[ref];

  if(isDefined(_id_639A73C27056BE13) && _id_639A73C27056BE13._id_281A794A27857A0E == 0) {
    _id_639A73C27056BE13._id_4B408A373268157D++;
    self iprintlnbold("Upgrade contribution " + _id_639A73C27056BE13._id_4B408A373268157D + "/" + _id_639A73C27056BE13._id_492DBA79ACAAC7E0);

    if(_id_639A73C27056BE13._id_4B408A373268157D == _id_639A73C27056BE13._id_492DBA79ACAAC7E0) {
      _id_639A73C27056BE13._id_281A794A27857A0E = 1;

      switch (ref) {
        case "research_upgrade_defense":
        case "research_upgrade_vehicle":
        case "research_upgrade_uav":
          _id_639A73C27056BE13._id_281A794A27857A0E = 0;
          _id_639A73C27056BE13._id_4B408A373268157D = 0;
          level._id_F2AFBE97539D175D[team][objectivekey].tier++;
          break;
      }
    } else
      return;
  }

  switch (ref) {
    case "longer_capture_time":
      level.objectives[objectivekey] scripts\mp\gameobjects::setusetime(level._id_73E72117ADA9CCE6);
      _func_FCE61CB0E2F1FC68(level.objectives[objectivekey].objidnum, 1);
      break;
    case "ammo_depot":
      _id_805AA14814FE1FF2(objectivekey, team);
      break;
    case "uav_ping":
      level.objectives[objectivekey] thread _id_C929FB023D29DE5E(team);
      break;
    case "ai_squad":
      _id_2F4866552F0BA818::_id_E7AD80F4A663B94B(objectivekey, 5, team);
      break;
    case "ai_jugg":
      groupname = _id_48814951E916AF89::_id_78759441C259F58A();
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", level.objectives[objectivekey].trigger.origin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, team);
      _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
      break;
    case "deploy_minefield":
      break;
    case "research_upgrade_defense":
    case "research_upgrade_vehicle":
    case "research_upgrade_uav":
      level._id_5B25E7620E424CB2[objectivekey] thread _id_ADA6203DE7E0AD2F();
      break;
  }
}

_id_ADA6203DE7E0AD2F() {
  self setscriptablepartstate("br_plunder_box", "disabled");
  wait 1.0;
  self setscriptablepartstate("br_plunder_box", "opening");
  _id_4384ABBF498DF6A7::kioskfixupproneplayers();
}

_id_6E2299D954003D6C(team, objectivekey) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  foreach(ref, _id_DAEE941F6CB91F8B in level._id_F2AFBE97539D175D[team][objectivekey]._id_33CFB91C1B214E68) {
    if(_id_DAEE941F6CB91F8B._id_281A794A27857A0E && _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF)
      _id_362ACC2689BEBAE8(team, objectivekey, ref);
  }
}

_id_666A2979DEF5D705(team, objectivekey) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  foreach(ref, _id_DAEE941F6CB91F8B in level._id_F2AFBE97539D175D[team][objectivekey]._id_33CFB91C1B214E68)
  _id_3D186B2B2EE293BB(team, objectivekey, ref);
}

_id_3D186B2B2EE293BB(team, objectivekey, ref) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  _id_DAEE941F6CB91F8B = level._id_F2AFBE97539D175D[team][objectivekey]._id_33CFB91C1B214E68[ref];

  if(!_id_DAEE941F6CB91F8B._id_98EAFCAE335D563A || _id_DAEE941F6CB91F8B._id_C5F581EB3B2342AF) {
    return;
  }
  level._id_F2AFBE97539D175D[team][objectivekey]._id_33CFB91C1B214E68[ref] = 0;

  switch (ref) {
    case "longer_capture_time":
      level.objectives[objectivekey] scripts\mp\gameobjects::setusetime(level.flagcapturetime);
      _func_FCE61CB0E2F1FC68(level.objectives[objectivekey].objidnum, 0);
      break;
    case "ammo_depot":
      foreach(team in level.teamnamelist)
      _id_87215631AACDABE9(objectivekey, team);

      break;
    case "uav_ping":
      level.objectives[objectivekey] thread _id_2F936733AA3FF4C5();
      break;
    case "deploy_minefield":
    case "ai_jugg":
    case "ai_squad":
      break;
  }
}

_id_805AA14814FE1FF2(key, team) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  level._id_F08DF4288EEE30F5[key] show();
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  level._id_F08DF4288EEE30F5[key] enablescriptableplayeruse(player);
}

_id_87215631AACDABE9(key, team) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  level._id_F08DF4288EEE30F5[key] hide();
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  level._id_F08DF4288EEE30F5[key] disablescriptableplayeruse(player);
}

_id_C929FB023D29DE5E(team) {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  self endon("disableUAVPing");

  for(;;) {
    radius = scripts\engine\utility::ter_op(istrue(level._id_F2AFBE97539D175D[team][self.objectivekey]._id_33CFB91C1B214E68["uav_ping_radius"]._id_281A794A27857A0E), getdvarint("dvar_6BBB6D984BA826B4", 3000), getdvarint("dvar_00BBF08A38C88577", 1000));
    duration = scripts\engine\utility::ter_op(istrue(level._id_F2AFBE97539D175D[team][self.objectivekey]._id_33CFB91C1B214E68["uav_ping_duration"]._id_281A794A27857A0E), getdvarfloat("dvar_D3E12B5A75C3AADA", 2.0), getdvarfloat("dvar_E34E9EA29B7CC0A9", 4.0));

    if(istrue(level._id_F2AFBE97539D175D[team][self.objectivekey]._id_33CFB91C1B214E68["uav_ping_global"]._id_281A794A27857A0E)) {
      foreach(objective in level.objectives) {
        if(objective.ownerteam == team)
          triggerportableradarpingteam(objective.curorigin, team, radius, int(duration * 1000));
      }
    } else
      triggerportableradarpingteam(self.curorigin, team, radius, int(duration * 1000));

    wait(duration);
  }
}

_id_2F936733AA3FF4C5() {
  if(!istrue(level._id_44334833E57B459B)) {
    return;
  }
  self notify("disableUAVPing");
}

_id_EFBC646224FDA4FA() {
  level thread _id_64ACB6CE534155B7::utilflare_shootflare(self.origin, "revive");
  spawnheight = getdvarfloat("dvar_3DB53FBBAD853FFC", 8000);
  spawnorigin = self.origin;
  spawnorigin = spawnorigin + (0, 0, spawnheight);
  _id_AD4DD16F29E24B77 = 0.0;
  _id_DFAB0807D83A77FE = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE);

  if(_id_AD4DD16F29E24B77 > 0)
    self waittill("fadeDown_complete");

  _id_851F0CE8DF2EB27D = (level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5;
  _id_9B4F42CA197744FE = _id_851F0CE8DF2EB27D - spawnorigin;
  spawnangles = vectortoangles(vectorNormalize(_id_9B4F42CA197744FE));
  self setOrigin(spawnorigin);
  self setplayerangles(spawnangles);

  if(level.parachutecancutautodeploy)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(level.parachutecancutparachute)
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  thread scripts\cp_mp\parachute::startfreefall(level.parachutedeploydelay, 0, undefined, undefined, 1);
}

_id_5A1699B27399A21E() {
  level endon("game_ended");
  _id_929A6DF466DC4F22 = undefined;
  _id_AC865A705B3E1162 = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::updatefobindanger();

  while(!level.gameended) {
    wait(getdvarint("dvar_AC8E27080E51148B", 20));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    domflags = getowneddomflags();

    if(!isDefined(level._id_9461E150CBB24A1B))
      level._id_9461E150CBB24A1B = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    level._id_9461E150CBB24A1B[_id_F90358454413407F] = 0;

    if(domflags.size) {
      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < domflags.size; _id_AC0E594AC96AA3A8++) {
        domflag = domflags[_id_AC0E594AC96AA3A8];
        _id_C2B268E253C97D27 = gettime() - domflag.capturetime;

        for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && _id_C2B268E253C97D27 > gettime() - domflags[_id_AC0E5C4AC96AAA41].capturetime; _id_AC0E5C4AC96AAA41--)
          domflags[_id_AC0E5C4AC96AAA41 + 1] = domflags[_id_AC0E5C4AC96AAA41];

        domflags[_id_AC0E5C4AC96AAA41 + 1] = domflag;
      }

      foreach(domflag in domflags) {
        team = domflag scripts\mp\gameobjects::getownerteam();
        _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);

        if(_id_FEE716687DD29378 >= level.flagsrequiredtoscore)
          level._id_9461E150CBB24A1B[team] = level._id_9461E150CBB24A1B[team] + level._id_1F42DAB41EFF5CB2;
      }
    }

    _id_D1B78E4D5310CD3B();
  }
}

_id_D1B78E4D5310CD3B() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(level._id_9461E150CBB24A1B[_id_F90358454413407F] > 0) {
      foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players"))
      player[[level._id_9C1E3C18B99409E9]](level._id_9461E150CBB24A1B[_id_F90358454413407F]);
    }
  }
}

getowneddomflags() {
  domflags = [];

  foreach(domflag in level.objectives) {
    if(domflag scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(domflag.capturetime))
      domflags[domflags.size] = domflag;
  }

  return domflags;
}

_id_8529632B1FDB55A6(player) {
  _id_D16569F10048FCE9 = undefined;
  _id_10FD8ED3FED0E0AE = undefined;

  if(istrue(level._id_F2AFBE97539D175D[player.team]["global"]._id_33CFB91C1B214E68["defense_spawn_armor_tier_2"]._id_281A794A27857A0E))
    _id_D16569F10048FCE9 = player._id_8790C077C95DB752;
  else if(istrue(level._id_F2AFBE97539D175D[player.team]["global"]._id_33CFB91C1B214E68["defense_spawn_armor_tier_1"]._id_281A794A27857A0E))
    _id_D16569F10048FCE9 = level._id_34867328231CA54B + level._id_4B78859BACC88808;

  if(istrue(level._id_F2AFBE97539D175D[player.team]["global"]._id_33CFB91C1B214E68["defense_spawn_plate_tier_2"]._id_281A794A27857A0E))
    _id_10FD8ED3FED0E0AE = _id_07C40FA80892A721::_id_047320A25B8EE003();
  else if(istrue(level._id_F2AFBE97539D175D[player.team]["global"]._id_33CFB91C1B214E68["defense_spawn_plate_tier_1"]._id_281A794A27857A0E))
    _id_10FD8ED3FED0E0AE = level._id_BF6C149BC4124962 + 1;

  return [_id_D16569F10048FCE9, _id_10FD8ED3FED0E0AE];
}

modifyvehicledamage(data) {
  switch (data.victim.vehiclename) {
    case "apc_russian":
    case "light_tank":
      if(istrue(level._id_F2AFBE97539D175D[data.victim.team]["global"]._id_33CFB91C1B214E68["vehicle_defense_tier_2"]._id_281A794A27857A0E))
        data.damage = int(data.damage * level._id_953451C32AA285BD);
      else if(istrue(level._id_F2AFBE97539D175D[data.victim.team]["global"]._id_33CFB91C1B214E68["vehicle_defense_tier_1"]._id_281A794A27857A0E))
        data.damage = int(data.damage * level._id_95344EC32AA27F24);

      break;
  }

  return data.damage;
}

_id_468B95F3865FA8D3(vehicle) {
  if(istrue(level._id_F2AFBE97539D175D[vehicle.team]["global"]._id_33CFB91C1B214E68["vehicle_apc_improved_ammo"]._id_281A794A27857A0E))
    return level._id_38931344C1BE4D04;

  return undefined;
}