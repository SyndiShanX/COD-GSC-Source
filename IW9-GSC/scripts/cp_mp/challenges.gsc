/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\challenges.gsc
***********************************************/

init() {
  if(!challengesenabled()) {
    return;
  }
  _id_5EE013539B0EA23C = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]())
      _id_5EE013539B0EA23C = 1;
  }

  if(!_id_5EE013539B0EA23C && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(isDefined(gametype) && (gametype == "brtdm" || gametype == "brtdm_mgl"))
      _id_5EE013539B0EA23C = 1;
  }

  if(_id_5EE013539B0EA23C) {
    level.challengetimersenabled = 1;
    level setupchallengelocales();
    level thread trackchallengetimers();
  }

  thread _id_FEAA0AC56AD0DEEB();
}

_id_4F4A046A372E8158() {}

setupchallengelocales() {
  level.localetriggers = [];
  _id_D09AECDB0D855501 = getEntArray("location_volume", "targetname");

  if(isDefined(_id_D09AECDB0D855501) && _id_D09AECDB0D855501.size > 0) {
    foreach(area in _id_D09AECDB0D855501) {
      if(!isDefined(area.script_noteworthy)) {
        continue;
      }
      area.sprayid = -1;

      switch (area.script_noteworthy) {
        case "airfield":
          area.localeid = 1;
          area.sprayid = 0;
          break;
        case "boneyard":
          area.localeid = 2;
          area.sprayid = 1;
          break;
        case "coast":
          area.localeid = 3;
          break;
        case "dam":
          area.localeid = 4;
          break;
        case "downtown":
          area.localeid = 5;
          area.sprayid = 2;
          break;
        case "farms":
          area.localeid = 6;
          break;
        case "gulag":
          area.localeid = 7;
          break;
        case "hospital":
          area.localeid = 8;
          area.sprayid = 3;
          break;
        case "junkyard":
          area.localeid = 9;
          break;
        case "layover":
          area.localeid = 10;
          break;
        case "lumber":
          area.localeid = 11;
          break;
        case "maintenance":
          area.localeid = 12;
          break;
        case "outskirts":
          area.localeid = 13;
          break;
        case "park":
          area.localeid = 14;
          break;
        case "port":
          area.localeid = 15;
          area.sprayid = 4;
          break;
        case "quarry":
          area.localeid = 16;
          break;
        case "river_east":
          area.localeid = 17;
          break;
        case "river_north":
          area.localeid = 18;
          break;
        case "river_south":
          area.localeid = 19;
          break;
        case "stadium":
          area.localeid = 20;
          break;
        case "storagetown":
          area.localeid = 21;
          break;
        case "suburbs_airfield":
          area.localeid = 22;
          break;
        case "suburbs_coast":
          area.localeid = 23;
          break;
        case "suburbs_dam":
          area.localeid = 24;
          break;
        case "suburbs_eastriver":
          area.localeid = 25;
          break;
        case "suburbs_hospital":
          area.localeid = 26;
          break;
        case "suburbs_quarry":
          area.localeid = 27;
          break;
        case "suburbs_stadium":
          area.localeid = 28;
          break;
        case "suburbs_super":
          area.localeid = 29;
          break;
        case "suburbs_transit":
          area.localeid = 30;
          break;
        case "super":
          area.localeid = 31;
          break;
        case "transit":
          area.localeid = 32;
          break;
        case "tvstation":
          area.localeid = 33;
          break;
      }
    }

    level.localetriggers = _id_D09AECDB0D855501;
  }
}

challengesenabled() {
  return level.challengesallowed;
}

challengesenabledforplayer() {
  if(!challengesenabled())
    return 0;

  if(!isPlayer(self) || isai(self))
    return 0;

  if(istrue(level.challengesdisabled))
    return 0;

  if(isDefined(self._id_56F36FD7CC3D8098))
    return 0;

  return 1;
}

_id_5C7E8BCDC167FD84() {
  if(!isDefined(level._id_31FE2D8A33B25B91))
    level._id_31FE2D8A33B25B91 = getdvarint("dvar_5FE27D3EFAC4A807", 0);

  return level._id_31FE2D8A33B25B91;
}

challengetimersenabledforplayer() {
  if(!istrue(level.challengetimersenabled))
    return 0;

  if(!challengesenabledforplayer())
    return 0;

  return 1;
}

validchallengetimer(_id_33BE63BF54F72FA9) {
  if(!isDefined(self.challengestarttime))
    return 0;

  if(!isDefined(self.challengestarttime[_id_33BE63BF54F72FA9]))
    return 0;

  return 1;
}

resetchallengetimer(_id_33BE63BF54F72FA9) {
  if(!challengetimersenabledforplayer()) {
    return;
  }
  if(!validchallengetimer(_id_33BE63BF54F72FA9)) {
    return;
  }
  self.challengestarttime[_id_33BE63BF54F72FA9] = 0;
}

startchallengetimer(_id_33BE63BF54F72FA9) {
  if(!challengetimersenabledforplayer()) {
    return;
  }
  if(!isDefined(self.challengestarttime))
    self.challengestarttime = [];

  if(!isDefined(self.challengestarttime[_id_33BE63BF54F72FA9]))
    self.challengestarttime[_id_33BE63BF54F72FA9] = 0;

  self.challengestarttime[_id_33BE63BF54F72FA9] = gettime();
}

stopchallengetimer(_id_33BE63BF54F72FA9) {
  if(!challengetimersenabledforplayer()) {
    return;
  }
  if(!validchallengetimer(_id_33BE63BF54F72FA9)) {
    return;
  }
  if(self.challengestarttime[_id_33BE63BF54F72FA9] > 0) {
    _id_AC846BE90E9552AB = gettime() - self.challengestarttime[_id_33BE63BF54F72FA9];

    if(_id_AC846BE90E9552AB > 0)
      self reportchallengeuserevent(_id_33BE63BF54F72FA9, _id_AC846BE90E9552AB, getoperators());

    self.challengestarttime[_id_33BE63BF54F72FA9] = 0;
  }
}

checkandreportchallengetimer(_id_33BE63BF54F72FA9, _id_E0BA1A2E8FFB8E1E) {
  if(!challengetimersenabledforplayer()) {
    return;
  }
  if(!validchallengetimer(_id_33BE63BF54F72FA9)) {
    return;
  }
  if(self.challengestarttime[_id_33BE63BF54F72FA9] > 0) {
    _id_AC846BE90E9552AB = gettime() - self.challengestarttime[_id_33BE63BF54F72FA9];

    if(_id_AC846BE90E9552AB >= _id_E0BA1A2E8FFB8E1E) {
      self reportchallengeuserevent(_id_33BE63BF54F72FA9, _id_AC846BE90E9552AB, getoperators());
      self.challengestarttime[_id_33BE63BF54F72FA9] = gettime();
    }
  }
}

trackchallengetimers() {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.players)) {
      totalplayers = level.players.size;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < totalplayers; _id_AC0E594AC96AA3A8++) {
        if(isalive(level.players[_id_AC0E594AC96AA3A8]))
          level.players[_id_AC0E594AC96AA3A8] checkandreportchallengetimer("driving", 60000);
      }
    }

    wait 1;
  }
}

_id_011CF26EDF87D512() {}

_id_7D97A2A745E514C4(event, params) {}

onplayerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor))
      attacker = inflictor;
    else
      return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim)) {
      objweapon = attacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
      _id_425D52C81F1883FC = 0;
      _id_425D55C81F188A95 = 0;
      _id_3A33B126031BE677 = 0;
      hitloc = 0;

      if(isDefined(modifiers)) {
        _id_425D52C81F1883FC = modifiers["mask"];

        if(isDefined(modifiers["mask2"]))
          _id_425D55C81F188A95 = modifiers["mask2"];

        _id_3A33B126031BE677 = modifiers["attachment_flags"];
        hitloc = modifiers["hit_loc"];
      }

      _id_18545210159E68C8(attacker, victim, _id_425D52C81F1883FC, _id_425D55C81F188A95, objweapon, damage, meansofdeath, _id_3A33B126031BE677, hitloc);
    }
  }
}

_id_5A0AE8BC2B80C0C0(inflictor, attacker, damage, meansofdeath, objweapon, hitloc, modifiers) {
  if(!isDefined(inflictor)) {
    return;
  }
  if(!isDefined(attacker)) {
    return;
  }
  if(!isDefined(meansofdeath) || meansofdeath.size == 0) {
    return;
  }
  if(!isDefined(objweapon)) {
    return;
  }
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor))
      attacker = inflictor;
    else
      return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim)) {
      objweapon = attacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
      _id_425D52C81F1883FC = 0;
      _id_425D55C81F188A95 = 0;
      _id_3A33B126031BE677 = 0;
      hitloc = 0;

      if(isDefined(modifiers)) {
        _id_425D52C81F1883FC = modifiers["mask"];

        if(isDefined(modifiers["mask2"]))
          _id_425D55C81F188A95 = modifiers["mask2"];

        _id_3A33B126031BE677 = modifiers["attachment_flags"];
        hitloc = modifiers["hit_loc"];
      }

      _id_18545210159E68C8(attacker, victim, _id_425D52C81F1883FC, _id_425D55C81F188A95, objweapon, damage, meansofdeath, _id_3A33B126031BE677, hitloc);
    }
  }
}

vehiclekilled(vehicle, attacker, damage, objweapon) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = vehicle;
  objweapon = attacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
  meansofdeath = "MOD_UNKNOWN";
  _id_425D52C81F1883FC = 0;
  _id_425D55C81F188A95 = 0;
  _id_3A33B126031BE677 = 0;
  hitloc = 0;
  _id_4866E2C44A0B5B1E = attacker scripts\cp_mp\utility\player_utility::getvehicle(1);

  if(isDefined(_id_4866E2C44A0B5B1E)) {
    _id_425D52C81F1883FC = _id_6D40F12A09494350(_id_425D52C81F1883FC, 23);

    if(_id_4866E2C44A0B5B1E scripts\common\vehicle::ishelicopter())
      _id_425D55C81F188A95 = _id_6D40F12A09494350(_id_425D55C81F188A95, 11);
    else if(_id_4866E2C44A0B5B1E.vehiclename == "veh9_mil_lnd_mrap")
      _id_425D55C81F188A95 = _id_6D40F12A09494350(_id_425D55C81F188A95, 27);
  }

  _id_36C12D04A03471D6 = attacker getmovingplatformparent();

  if(isDefined(_id_36C12D04A03471D6) && _id_36C12D04A03471D6 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(istrue(_id_36C12D04A03471D6.isheli)) {
      _id_425D55C81F188A95 = _id_6D40F12A09494350(_id_425D55C81F188A95, 11);
      ref = _id_36C12D04A03471D6 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

      if(ref == "veh9_palfa")
        _id_425D55C81F188A95 = _id_6D40F12A09494350(_id_425D55C81F188A95, 20);
    }

    if(!isDefined(_id_4866E2C44A0B5B1E) || _id_36C12D04A03471D6 != _id_4866E2C44A0B5B1E) {
      ref = scripts\cp_mp\utility\train_utility::_id_E58B746157089C68(_id_36C12D04A03471D6);

      if(isDefined(ref) && (ref == "cargo_train" || ref == "br_passenger_train")) {
        _id_425D52C81F1883FC = _id_6D40F12A09494350(_id_425D52C81F1883FC, 58);

        if(ref == "cargo_train")
          _id_425D55C81F188A95 = _id_6D40F12A09494350(_id_425D55C81F188A95, 9);
        else if(ref == "br_passenger_train")
          _id_425D55C81F188A95 = _id_6D40F12A09494350(_id_425D55C81F188A95, 10);
      } else {
        _id_425D52C81F1883FC = _id_6D40F12A09494350(_id_425D52C81F1883FC, 56);

        if(_id_36C12D04A03471D6.classname == "script_vehicle" && _id_36C12D04A03471D6 vehicle_getspeed() > 25)
          _id_425D52C81F1883FC = _id_6D40F12A09494350(_id_425D52C81F1883FC, 57);
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onVehicleDestroyed"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onVehicleDestroyed")]](vehicle);

  _id_18545210159E68C8(attacker, victim, _id_425D52C81F1883FC, _id_425D55C81F188A95, objweapon, damage, meansofdeath, _id_3A33B126031BE677);
}

equipmentdestroyed(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor))
      attacker = inflictor;
    else
      return;
  }

  if(!isDefined(victim.owner)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim.owner)) {
      objweapon = attacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
      _id_425D52C81F1883FC = 0;
      _id_425D55C81F188A95 = 0;
      _id_3A33B126031BE677 = 0;

      if(isDefined(modifiers)) {
        _id_425D52C81F1883FC = modifiers["mask"];

        if(isDefined(modifiers["mask2"]))
          _id_425D55C81F188A95 = modifiers["mask2"];

        _id_3A33B126031BE677 = modifiers["attachment_flags"];
      }

      _id_18545210159E68C8(attacker, victim, _id_425D52C81F1883FC, _id_425D55C81F188A95, objweapon, damage, meansofdeath, _id_3A33B126031BE677);
    }
  }
}

killstreakkilled(_id_D8061F26B5ECA018, owner, _id_168CF91A2552500C, attacker, damage, _id_D95DA0355CF4CCB4, objweapon, _id_92D090CE35588AD2) {
  if(!isDefined(attacker) || !attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    return;
  }
  if(!isDefined(victim.owner)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim.owner)) {
      objweapon = attacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
      meansofdeath = "MOD_UNKNOWN";
      _id_425D52C81F1883FC = 0;
      _id_425D55C81F188A95 = 0;
      _id_3A33B126031BE677 = 0;

      if(isDefined(attacker.modifiers)) {
        _id_425D52C81F1883FC = attacker.modifiers["mask"];

        if(isDefined(attacker.modifiers["mask2"]))
          _id_425D55C81F188A95 = attacker.modifiers["mask2"];

        _id_3A33B126031BE677 = attacker.modifiers["attachment_flags"];
      }

      _id_18545210159E68C8(attacker, victim, _id_425D52C81F1883FC, _id_425D55C81F188A95, objweapon, damage, meansofdeath, _id_3A33B126031BE677);
    }
  }
}

_id_8359CADD253F9604(player, type, quantity, _id_AFDA85311C8ED272) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(_id_AFDA85311C8ED272))
    _id_AFDA85311C8ED272 = 1;

  gametype = _id_17C5D7FEB226E256();
  typeid = _func_96B7FC7E35353254(type);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(player._id_DA28916E7827AF7C)) {
    location = getlocation(player._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(player._id_DA28916E7827AF7C);
  }

  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  _id_8E81148472FB520A(player, "49", [32, 1, 46, typeid, 31, quantity, 8, _id_B2FF82EC901486E4, 9, gametype, 72, location, 121, _id_0FCF7B6E6D8C41C8], _id_AFDA85311C8ED272);
}

_id_5C3AA65DB46763FF(vehicle, type) {
  if(!challengesenabledforplayer()) {
    return;
  }
  vehiclename = 0;
  _id_49E5A39D5614BEBE = 0;
  [vehiclename, _id_49E5A39D5614BEBE] = findenemytype(vehicle);
  gametype = _id_17C5D7FEB226E256();
  typeid = _func_96B7FC7E35353254(type);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  _id_8E81148472FB520A(self, "571", [8, _id_B2FF82EC901486E4, 9, gametype, 13, vehiclename, 32, 1, 46, typeid, 72, location, 121, _id_0FCF7B6E6D8C41C8, 149, _id_49E5A39D5614BEBE]);
}

_id_070ABD486AE26235(player, type, quantity, _id_AFDA85311C8ED272) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  gametype = _id_17C5D7FEB226E256();
  typeid = _func_96B7FC7E35353254(type);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(player._id_DA28916E7827AF7C)) {
    location = getlocation(player._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(player._id_DA28916E7827AF7C);
  }

  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  _id_8E81148472FB520A(player, "384", [32, 1, 46, typeid, 31, quantity, 8, _id_B2FF82EC901486E4, 9, gametype, 72, location, 121, _id_0FCF7B6E6D8C41C8], _id_AFDA85311C8ED272);
}

_id_B0F754C8A379154E(equipment, player, dist, _id_363274577DC0543E) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  _id_7FB63B7FAC6D1698 = _id_3EA2B9FA713D6ED3(player);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(player._id_DA28916E7827AF7C)) {
    location = getlocation(player._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(player._id_DA28916E7827AF7C);
  }

  _id_F275474AACD30C96 = 0;
  _id_F275474AACD30C96 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(equipment);
  _id_3A7747BC9807F3C0 = 0;
  _id_3A7747BC9807F3C0 = _id_6D40F12A09494350(_id_3A7747BC9807F3C0, _id_363274577DC0543E);
  _id_8E81148472FB520A(player, "64", [8, _id_B2FF82EC901486E4, 9, gametype, 32, 1, 72, location, 121, _id_0FCF7B6E6D8C41C8, 76, _id_F275474AACD30C96, 93, dist, 81, _id_7FB63B7FAC6D1698, 85, _id_3A7747BC9807F3C0]);
}

_id_B5929663421247FA(player, result, winner) {
  if(!isDefined(player)) {
    return;
  }
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_A74FC57FB4A4D3E6 = player _id_AFF35122A61A900B(player.team);

  if(!isDefined(_id_A74FC57FB4A4D3E6))
    _id_A74FC57FB4A4D3E6 = 0;

  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  _id_0774C9CA5D1D6221 = 0;

  if(_id_B2FF82EC901486E4 & 8)
    _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C", 0);

  placement = 0;

  if(isDefined(player.teamplacement) && player.teamplacement > 0)
    placement = player.teamplacement;

  _id_85D8DAEAC55B1742 = getplaylistid();
  _id_156E078B5445FFAA = _func_4F9373A1227DB35C();
  location = getlocation(player._id_DA28916E7827AF7C);
  _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(player._id_DA28916E7827AF7C);
  _id_8142A29197569218 = 0;

  if(isDefined(player.pers) && isDefined(player.pers["kills"])) {
    if(player.pers["kills"] >= 15)
      _id_8142A29197569218 = _id_6D40F12A09494350(_id_8142A29197569218, 12);
  }

  gametype = _id_17C5D7FEB226E256();
  _id_0BB38571CCA0414F = _id_C1945F26D99B0ED9(player);
  params = [8, _id_B2FF82EC901486E4, 9, gametype, 16, result, 18, _id_A74FC57FB4A4D3E6, 5, _id_8142A29197569218, 103, placement, 83, _id_85D8DAEAC55B1742, 117, _id_0774C9CA5D1D6221, 120, _id_156E078B5445FFAA, 126, _id_0BB38571CCA0414F[0], 127, _id_0BB38571CCA0414F[1], 128, _id_0BB38571CCA0414F[2], 129, _id_0BB38571CCA0414F[3], 130, _id_0BB38571CCA0414F[4], 72, location, 121, _id_0FCF7B6E6D8C41C8];
  _id_7D97A2A745E514C4("62", params);
  player _meth_DB073176839D77FB("62", params);
}

_id_8DF2C1C1377B79BE(_id_B87F7FAE01CE754F) {
  return _id_B87F7FAE01CE754F * 10;
}

_id_DC52E14B64052DDA(lootid, quantity) {
  if(isDefined(lootid)) {
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

    if(isDefined(scriptablename)) {
      if(lootid == 8395)
        return _id_8DF2C1C1377B79BE(quantity);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "isDogTag") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "isDogTag")]](scriptablename) || scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "isGasMask") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "isGasMask")]](scriptablename))
        return 1;
    }
  }

  return quantity;
}

_id_1BA256DA09A9878A(player, lootid, _id_A0CE8000D303764C, _id_5577636292591C8B, quantity, _id_B87F7FAE01CE754F, _id_E7D05247043893AD) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  gametype = _id_17C5D7FEB226E256();
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  _id_99BD169488E48AC1 = undefined;
  typeid = undefined;

  if(isDefined(_id_A0CE8000D303764C))
    _id_99BD169488E48AC1 = _func_96B7FC7E35353254(_id_A0CE8000D303764C);

  if(isDefined(lootid))
    typeid = _id_C43D8B7A5461CDCE(lootid);
  else if(isDefined(_id_5577636292591C8B))
    typeid = _func_96B7FC7E35353254(_id_5577636292591C8B);

  quantity = _id_DC52E14B64052DDA(lootid, quantity);
  _id_B87F7FAE01CE754F = _id_8DF2C1C1377B79BE(_id_B87F7FAE01CE754F);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  params = [32, 1, 46, _id_99BD169488E48AC1, 31, quantity, 8, _id_B2FF82EC901486E4, 9, gametype, 76, lootid, 77, typeid, 90, _id_B87F7FAE01CE754F, 89, _id_E7D05247043893AD, 72, location, 121, _id_0FCF7B6E6D8C41C8];
  _id_7D97A2A745E514C4("47", params);
  _id_8E81148472FB520A(player, "47", params);
}

_id_AFFB3AF6AF110594(player, _id_AF0662D6485D5D58, _id_B205D90302DA2F07) {
  gametype = _id_17C5D7FEB226E256();
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(_id_B205D90302DA2F07)) {
    location = getlocation(_id_B205D90302DA2F07);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(_id_B205D90302DA2F07);
  }

  params = [32, 1, 31, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 87, _id_AF0662D6485D5D58, 72, location, 121, _id_0FCF7B6E6D8C41C8];
  _id_7D97A2A745E514C4("108", params);
  player _meth_DB073176839D77FB("108", params);
}

_id_2635CDB5E985EAAB(player, _id_AF0662D6485D5D58, _id_B205D90302DA2F07) {
  gametype = _id_17C5D7FEB226E256();
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(_id_B205D90302DA2F07)) {
    location = getlocation(_id_B205D90302DA2F07);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(_id_B205D90302DA2F07);
  }

  params = [32, 1, 31, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 87, _id_AF0662D6485D5D58, 72, location, 121, _id_0FCF7B6E6D8C41C8];
  _id_7D97A2A745E514C4("61", params);
  player _meth_DB073176839D77FB("61", params);
}

_id_F4D8C689AAF296E5(player, weapon, _id_ED76DB33212E6A92, _id_AE0F808555C671F9) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  if(isagent(player)) {
    return;
  }
  if(!isDefined(weapon)) {
    return;
  }
  _id_0B28608820870666 = _id_CE112254F7CBA89E(weapon);

  if(!isDefined(_id_0B28608820870666)) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  _id_6AE633608E2AD8EE = _id_ED76DB33212E6A92 + _id_AE0F808555C671F9;
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 43, _id_0B28608820870666, 31, _id_6AE633608E2AD8EE];
  _id_7D97A2A745E514C4("511", params);
  player _meth_DB073176839D77FB("511", params);
}

_id_4AB6F9FBA6BB9CC5(player, _id_ED76DB33212E6A92, _id_AE0F808555C671F9) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  if(isagent(player)) {
    return;
  }
  if(!isDefined(_id_ED76DB33212E6A92))
    _id_ED76DB33212E6A92 = 0;

  _id_ED76DB33212E6A92 = int(_id_ED76DB33212E6A92);

  if(!isDefined(_id_AE0F808555C671F9))
    _id_AE0F808555C671F9 = 0;

  _id_AE0F808555C671F9 = int(_id_AE0F808555C671F9);
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  _id_EEFF650640A93FE1 = 0;

  if(_id_ED76DB33212E6A92 > 0)
    _id_EEFF650640A93FE1 = _id_6D40F12A09494350(_id_EEFF650640A93FE1, 0);

  if(_id_AE0F808555C671F9 > 0)
    _id_EEFF650640A93FE1 = _id_6D40F12A09494350(_id_EEFF650640A93FE1, 1);

  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 94, _id_EEFF650640A93FE1, 31, _id_ED76DB33212E6A92 + _id_AE0F808555C671F9];
  _id_7D97A2A745E514C4("222", params);
  player _meth_DB073176839D77FB("222", params);
}

_id_FB2DB8647D693699(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype];
  _id_7D97A2A745E514C4("221", params);
  player _meth_DB073176839D77FB("221", params);
}

_id_B8E86C6DEA0AC027(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype];
  _id_7D97A2A745E514C4("592", params);
  player _meth_DB073176839D77FB("592", params);
}

ondeath(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_0774C9CA5D1D6221 = 0;

  if(_id_B2FF82EC901486E4 & 8)
    _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C", 0);

  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 117, _id_0774C9CA5D1D6221];
  _id_7D97A2A745E514C4("57", params);
  self _meth_DB073176839D77FB("57", params);
}

_id_868B6D4FBEC3938C(player) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype];
  _id_7D97A2A745E514C4("417", params);
  self _meth_DB073176839D77FB("417", params);
}

_id_5D99311B5A7DFFDA() {
  _id_4FD3DF97F86A664C = getdvarint("dvar_BD0F7AD1BB2671A5", -1);

  if(_id_4FD3DF97F86A664C >= 0)
    return _id_4FD3DF97F86A664C;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!isDefined(level._id_67B3435949F31707)) {
      level._id_67B3435949F31707 = 0;

      foreach(team in level.teamnamelist) {
        _id_652F47620AC4713F = level.teamdata[team]["teamCount"];

        if(isDefined(level._id_7B37B2193F163B9B))
          _id_652F47620AC4713F = _id_652F47620AC4713F + level.teamdata[team]["UIBotCount"];

        if(_id_652F47620AC4713F)
          level._id_67B3435949F31707++;
      }
    }

    return level._id_67B3435949F31707 - 1;
  }

  if(isDefined(level.teamswithplayers))
    return int(max(level.teamswithplayers.size - 1, 0));

  return 0;
}

_id_247BA07507F78AC2(victim, attacker) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim)) {
      _id_B2FF82EC901486E4 = getchallengegamemode(attacker);
      gametype = _id_17C5D7FEB226E256();
      _id_3FFF36CAEACE1B84 = _id_5D99311B5A7DFFDA();

      if(isDefined(level._id_C596A10A13C5CD7C))
        _id_3FFF36CAEACE1B84 = [[level._id_C596A10A13C5CD7C]](_id_3FFF36CAEACE1B84, victim);

      _id_904C82687DDFEB02 = undefined;

      if(isDefined(attacker.primaryweaponobj))
        _id_904C82687DDFEB02 = _id_2669878CF5A1B6BC::_id_9C331F88BE5A1478(attacker.primaryweaponobj);

      if(!isDefined(_id_904C82687DDFEB02))
        _id_904C82687DDFEB02 = 0;

      _id_E2AA32C9738D9264 = _id_5AF37CE2C176C946();
      _id_0B28608820870666 = 0;
      _id_0B28608820870666 = _id_CE112254F7CBA89E(attacker.primaryweaponobj);
      _id_9C98419964190A71 = istrue(level._id_1147BBC93EA9B83C);
      params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 43, _id_0B28608820870666, 44, _id_904C82687DDFEB02, 119, _id_3FFF36CAEACE1B84, 137, _id_9C98419964190A71];
      _id_7D97A2A745E514C4("42", params);
      attacker _meth_DB073176839D77FB("42", params);
    }
  }
}

_id_817629C461EA3540(victim, _id_815F9C7C319D9EAC, attacker) {
  if(!_id_815F9C7C319D9EAC challengesenabledforplayer()) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](_id_815F9C7C319D9EAC.team, attacker)) {
      _id_B2FF82EC901486E4 = getchallengegamemode(_id_815F9C7C319D9EAC);
      gametype = _id_17C5D7FEB226E256();
      _id_3FFF36CAEACE1B84 = _id_5D99311B5A7DFFDA();

      if(isDefined(level._id_C596A10A13C5CD7C))
        _id_3FFF36CAEACE1B84 = [[level._id_C596A10A13C5CD7C]](_id_3FFF36CAEACE1B84, victim);

      _id_9C98419964190A71 = istrue(level._id_1147BBC93EA9B83C);
      params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 119, _id_3FFF36CAEACE1B84, 137, _id_9C98419964190A71];
      _id_7D97A2A745E514C4("415", params);
      _id_815F9C7C319D9EAC _meth_DB073176839D77FB("415", params);
    }
  }
}

_id_D8F43796D36ED5BF(ref, source) {
  if(!challengesenabledforplayer()) {
    return;
  }
  params = [32, 1];
  _id_7D97A2A745E514C4("77", params);
  self _meth_DB073176839D77FB("77", params);
}

_id_597BC208D923A465(ref, _id_77F3CA6D2F0AAE12) {
  if(!challengesenabledforplayer()) {
    return;
  }
  gametype = _id_17C5D7FEB226E256();
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  _id_3A7747BC9807F3C0 = 0;
  _id_BDBCBE6DDF9167E7 = _id_77F3CA6D2F0AAE12;
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);

  if(!isDefined(_id_A74FC57FB4A4D3E6))
    _id_A74FC57FB4A4D3E6 = 0;

  _id_6FB9CC872B9F6EB3 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
  _id_35529BEECC177A27 = _id_3EA2B9FA713D6ED3(self);
  _id_8E81148472FB520A(self, "78", [8, _id_B2FF82EC901486E4, 9, gametype, 11, _id_BDBCBE6DDF9167E7, 14, _id_A74FC57FB4A4D3E6, 15, _id_3A7747BC9807F3C0, 32, 1, 44, _id_6FB9CC872B9F6EB3, 81, _id_35529BEECC177A27]);
}

_id_D997435895422ECC(ref, _id_363274577DC0543E, value) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_0335BA1EBE269094 = 0;
  gametype = _id_17C5D7FEB226E256();
  _id_B2FF82EC901486E4 = getchallengegamemode(self);

  if(isDefined(value) && value < 0)
    value = 1;

  _id_0335BA1EBE269094 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  _id_7FB63B7FAC6D1698 = _id_3EA2B9FA713D6ED3(self);
  _id_3A7747BC9807F3C0 = 0;
  _id_3A7747BC9807F3C0 = _id_6D40F12A09494350(_id_3A7747BC9807F3C0, _id_363274577DC0543E);
  _id_8E81148472FB520A(self, "66", [8, _id_B2FF82EC901486E4, 9, gametype, 31, value, 32, 1, 76, _id_0335BA1EBE269094, 85, _id_3A7747BC9807F3C0, 72, location, 121, _id_0FCF7B6E6D8C41C8, 81, _id_7FB63B7FAC6D1698]);
}

_id_BD59AA7E8CECE1AB(ref, value) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_D647223842F24DA0 = ref;
  amount = value;
  _id_8E81148472FB520A(self, "65", [32, 1, 46, _id_D647223842F24DA0, 31, amount]);
}

oncapture(modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_425D52C81F1883FC = 0;
  _id_425D55C81F188A95 = 0;

  if(isDefined(modifiers)) {
    _id_425D52C81F1883FC = modifiers["mask"];

    if(isDefined(modifiers["mask2"]))
      _id_425D55C81F188A95 = modifiers["mask2"];
  }

  gametype = _id_17C5D7FEB226E256();
  _id_B6217B906C6BE73E = getoperators();
  self reportchallengeuserevent("capture", gametype, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E);
}

_id_C51330573171A1BE(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  _id_8E81148472FB520A(player, "59", [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype]);
}

onplant() {
  _id_4FB61D33F02E8203(self, 1);
}

onstun(equipment) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("stun", equipment);
}

onstim(_id_6C53F7D5FC456351) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("stim", _id_6C53F7D5FC456351);
}

onhack(equipment) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_8E81148472FB520A(self, "70", [32, 1, "64", equipment, 31, 1, 8, getchallengegamemode(), 9, _id_17C5D7FEB226E256()]);
}

gettouchinglocaletriggers(attacker, victim) {
  _id_750C94BA41F40A47 = "";

  if(!isDefined(level.localetriggers))
    return _id_750C94BA41F40A47;

  found = 0;

  foreach(trigger in level.localetriggers) {
    if(attacker istouching(trigger) || isDefined(victim) && victim istouching(trigger)) {
      if(isDefined(trigger.localeid)) {
        if(found)
          _id_750C94BA41F40A47 = _id_750C94BA41F40A47 + "|";

        _id_750C94BA41F40A47 = _id_750C94BA41F40A47 + trigger.localeid;
        found = 1;
      }
    }
  }

  return _id_750C94BA41F40A47;
}

gettouchingspraylocaletriggers(player) {
  if(!isDefined(level.localetriggers))
    return -1;

  foreach(trigger in level.localetriggers) {
    if(player istouching(trigger)) {
      _id_8F194056385AE0A7 = isDefined(trigger.sprayid) && trigger.sprayid > -1;
      _id_50BA7204DAA28034 = isDefined(player.sprayed) && player.sprayed & 1 << trigger.sprayid;

      if(_id_8F194056385AE0A7 && !_id_50BA7204DAA28034) {
        if(!isDefined(player.sprayed))
          player.sprayed = 0;

        player.sprayed = player.sprayed | 1 << trigger.sprayid;
        return trigger.sprayid;
      }
    }
  }

  return -1;
}

oncontractstart(_id_591000CB6EF11522, _id_A705A5A5884EBF9C) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(_id_A705A5A5884EBF9C) && isDefined(_id_A705A5A5884EBF9C._id_DA28916E7827AF7C)) {
    location = getlocation(_id_A705A5A5884EBF9C._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(_id_A705A5A5884EBF9C._id_DA28916E7827AF7C);
  }

  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 31, _id_591000CB6EF11522, 18, _id_A74FC57FB4A4D3E6, 72, location, 121, _id_0FCF7B6E6D8C41C8];
  _id_7D97A2A745E514C4("52", params);
  self _meth_DB073176839D77FB("52", params);
}

oncontractend(_id_591000CB6EF11522, _id_0AF8D4CC519C65DE, _id_1229758A8A60BA86, _id_CDBB609588AC1FBB) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(_id_CDBB609588AC1FBB)) {
    location = getlocation(_id_CDBB609588AC1FBB);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(_id_CDBB609588AC1FBB);
  }

  _id_98FFDD148B962576 = 0;

  if(isalive(self))
    _id_98FFDD148B962576 = _id_6D40F12A09494350(_id_98FFDD148B962576, 2);

  if(_id_0AF8D4CC519C65DE)
    _id_98FFDD148B962576 = _id_6D40F12A09494350(_id_98FFDD148B962576, 0);
  else
    _id_98FFDD148B962576 = _id_6D40F12A09494350(_id_98FFDD148B962576, 1);

  if(_id_1229758A8A60BA86 == 1)
    _id_98FFDD148B962576 = _id_6D40F12A09494350(_id_98FFDD148B962576, 3);
  else if(_id_1229758A8A60BA86 == 2)
    _id_98FFDD148B962576 = _id_6D40F12A09494350(_id_98FFDD148B962576, 4);

  _id_0BB38571CCA0414F = _id_C1945F26D99B0ED9(self);
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 31, _id_591000CB6EF11522, 18, _id_A74FC57FB4A4D3E6, 72, location, 121, _id_0FCF7B6E6D8C41C8, 105, _id_98FFDD148B962576, 126, _id_0BB38571CCA0414F[0], 127, _id_0BB38571CCA0414F[1], 128, _id_0BB38571CCA0414F[2], 129, _id_0BB38571CCA0414F[3], 130, _id_0BB38571CCA0414F[4]];
  _id_7D97A2A745E514C4("51", params);
  self _meth_DB073176839D77FB("51", params);
}

_id_417907AEEB08BAAC(_id_D0E95C16B3F9546E) {
  switch (_id_D0E95C16B3F9546E) {
    case "cache_bar_cabinet":
      return _id_6D40F12A09494350(0, 0);
    case "cache_cash_register_clean":
    case "cache_cash_register":
      return _id_6D40F12A09494350(0, 20);
    case "cache_hanging_clothes":
      return _id_6D40F12A09494350(0, 2);
    case "cache_computer_tower":
      return _id_6D40F12A09494350(0, 3);
    case "dmz_dead_drop_transaction_drawer":
    case "dmz_dead_drop":
      return _id_6D40F12A09494350(0, 4);
    case "dmz_hidden_container_common":
    case "dmz_hidden_container":
    case "dmz_geiger_puzzle_container":
      return _id_6D40F12A09494350(0, 5);
    case "dmz_secret_stash":
    case "dmz_safe_konni":
    case "dmz_safe":
    case "dmz_biolab_safe":
      return _id_6D40F12A09494350(0, 21);
    case "dmz_crate_wood":
      return _id_6D40F12A09494350(0, 6);
    case "dmz_supply_drop_samsite":
    case "dmz_supply_drop_boss":
    case "dmz_supply_drop":
      return _id_6D40F12A09494350(0, 7);
    case "cache_dresser":
      return _id_6D40F12A09494350(0, 8);
    case "cache_duffel_bag_02":
    case "cache_duffel_bag_01":
      return _id_6D40F12A09494350(0, 1);
    case "cache_medical_box_wall":
      return _id_6D40F12A09494350(0, 9);
    case "cache_fridge_old":
    case "cache_fridge_mini":
    case "cache_fridge_b":
    case "cache_fridge_a":
    case "cache_comm_fridge_02":
    case "cache_comm_fridge_01":
      return _id_6D40F12A09494350(0, 10);
    case "cache_school_locker_b":
    case "cache_school_locker_a":
      return _id_6D40F12A09494350(0, 11);
    case "cyber_revive_pillage":
    case "cache_gulag_west_4":
    case "cache_gulag_west_3":
    case "cache_gulag_east_4":
    case "cache_gulag_east_3":
      return _id_6D40F12A09494350(0, 12);
    case "cache_mail_kiosk":
      return _id_6D40F12A09494350(0, 13);
    case "cache_medicine_cabinet":
      return _id_6D40F12A09494350(0, 14);
    case "cache_office_cabinet":
      return _id_6D40F12A09494350(0, 15);
    case "brloot_backpack_player_small":
    case "brloot_backpack_player_medium":
    case "brloot_backpack_player_large":
    case "brloot_backpack":
      return _id_6D40F12A09494350(0, 16);
    case "br_scavenger_quest_cache":
    case "br_reusable_loot_cache":
    case "br_loot_cache_stronghold":
    case "br_loot_cache_lege":
    case "br_loot_cache_gulag":
    case "br_loot_cache_blacksite":
    case "br_loot_cache":
      return _id_6D40F12A09494350(0, 17);
    case "cache_toolbox":
      return _id_6D40F12A09494350(0, 18);
    case "cache_weapon_locker":
      return _id_6D40F12A09494350(0, 19);
    default:
      return 0;
  }
}

_id_DA9003DF08944B01(instance) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(instance) && !isDefined(instance.type)) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  _id_8F3A85E26344FEDF = _id_417907AEEB08BAAC(instance.type);
  _id_B17708BCDCA61BA6 = 0;
  _id_B17708BCDCA61BA6 = _id_6D40F12A09494350(_id_B17708BCDCA61BA6, 0);
  _id_8E81148472FB520A(self, "380", [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 72, location, 121, _id_0FCF7B6E6D8C41C8, 108, _id_8F3A85E26344FEDF, 109, _id_B17708BCDCA61BA6]);
}

onkioskpurchaseitem(_id_7E1BFBE3F25F5583, _id_CB325DDB4A764623, lootid, quantity, _id_B87F7FAE01CE754F) {
  _id_707BC435F8518B62 = _id_6D40F12A09494350(0, 0);
  _id_1BA256DA09A9878A(self, lootid, _id_CB325DDB4A764623, _id_7E1BFBE3F25F5583, quantity, _id_B87F7FAE01CE754F, _id_707BC435F8518B62);
}

_id_EA50038423FC4CFC(_id_7E1BFBE3F25F5583, _id_CB325DDB4A764623, lootid, quantity, _id_B87F7FAE01CE754F) {
  _id_707BC435F8518B62 = _id_6D40F12A09494350(0, 1);
  _id_1BA256DA09A9878A(self, lootid, _id_CB325DDB4A764623, _id_7E1BFBE3F25F5583, quantity, _id_B87F7FAE01CE754F, _id_707BC435F8518B62);
}

_id_7BA17FB69C312E2C(_id_7E1BFBE3F25F5583, _id_CB325DDB4A764623, lootid, quantity, _id_B87F7FAE01CE754F) {
  _id_707BC435F8518B62 = _id_6D40F12A09494350(0, 3);
  _id_1BA256DA09A9878A(self, lootid, _id_CB325DDB4A764623, _id_7E1BFBE3F25F5583, quantity, _id_B87F7FAE01CE754F, _id_707BC435F8518B62);
  _id_D739AA04B56DC7AD = _id_6D40F12A09494350(0, 0);
  _id_D24138B32084FC3E(self, lootid, _id_7E1BFBE3F25F5583, _id_D739AA04B56DC7AD, quantity);
}

_id_C2C80007AFF49924(_id_7E1BFBE3F25F5583, _id_CB325DDB4A764623, lootid, quantity, _id_B87F7FAE01CE754F) {
  _id_707BC435F8518B62 = _id_6D40F12A09494350(0, 2);
  _id_1BA256DA09A9878A(self, lootid, _id_CB325DDB4A764623, _id_7E1BFBE3F25F5583, quantity, _id_B87F7FAE01CE754F, _id_707BC435F8518B62);
}

_id_3D8A8B0878F9F129(_id_7E1BFBE3F25F5583, _id_CB325DDB4A764623, lootid, quantity, _id_B87F7FAE01CE754F) {
  _id_707BC435F8518B62 = _id_6D40F12A09494350(0, 4);
  _id_1BA256DA09A9878A(self, lootid, _id_CB325DDB4A764623, _id_7E1BFBE3F25F5583, quantity, _id_B87F7FAE01CE754F, _id_707BC435F8518B62);
}

onpickupitem(_id_7E1BFBE3F25F5583) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_A700F4673C85C915 = 0;
  _id_455145ACF02E9F8D = 0;

  if(_id_7E1BFBE3F25F5583 == "weapon")
    _id_A700F4673C85C915 = 1;
  else if(_id_7E1BFBE3F25F5583 == "plunder")
    _id_455145ACF02E9F8D = 1;

  self reportchallengeuserevent("pickup", _id_A700F4673C85C915, _id_455145ACF02E9F8D, 0, getoperators());
}

oncollectitem(_id_7E1BFBE3F25F5583) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("collect_item", _id_7E1BFBE3F25F5583, getoperators());
}

onuseitem(type) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_CFEB523FD3AA9ECF(self, undefined, type);
}

onunlockitem(_id_443F88E60A6C1697) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("collect_item", _id_443F88E60A6C1697);
}

onloadout(_id_8691AF1F100B771F) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("loadout", _id_8691AF1F100B771F, getoperators());
}

onping(_id_A1823E6B1CB4B46D) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("ping", _id_A1823E6B1CB4B46D, getoperators());
}

onlaststandrevive(reviver, _id_22F7E3F7E360775B) {
  _id_B2FF82EC901486E4 = getchallengegamemode(reviver);
  gametype = _id_17C5D7FEB226E256();

  if(reviver challengesenabledforplayer()) {
    _id_160460001CC37359 = 0;
    _id_160460001CC37359 = _id_6D40F12A09494350(_id_160460001CC37359, 0);
    _id_A74FC57FB4A4D3E6 = reviver _id_AFF35122A61A900B(reviver.team);

    if(reviver == _id_22F7E3F7E360775B)
      _id_160460001CC37359 = _id_6D40F12A09494350(_id_160460001CC37359, 1);

    _id_8E81148472FB520A(reviver, "104", [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 115, _id_160460001CC37359]);
  }

  if(reviver != _id_22F7E3F7E360775B && _id_22F7E3F7E360775B challengesenabledforplayer()) {
    _id_160460001CC37359 = 0;
    _id_160460001CC37359 = _id_6D40F12A09494350(_id_160460001CC37359, 1);
    _id_A74FC57FB4A4D3E6 = _id_22F7E3F7E360775B _id_AFF35122A61A900B(_id_22F7E3F7E360775B.team);
    _id_8E81148472FB520A(_id_22F7E3F7E360775B, "104", [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 115, _id_160460001CC37359]);
  }
}

_id_B2306D0693BA65C1(_id_7C6311737CB7A0B2) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
  _id_9C46B4C2597D7B03 = 0;

  if(_id_7C6311737CB7A0B2)
    _id_9C46B4C2597D7B03 = _id_6D40F12A09494350(_id_9C46B4C2597D7B03, 0);
  else
    _id_9C46B4C2597D7B03 = _id_6D40F12A09494350(_id_9C46B4C2597D7B03, 1);

  _id_0774C9CA5D1D6221 = 0;

  if(_id_B2FF82EC901486E4 & 8)
    _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C", 0);

  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 104, _id_9C46B4C2597D7B03, 117, _id_0774C9CA5D1D6221];
  _id_7D97A2A745E514C4("369", params);
  self _meth_DB073176839D77FB("369", params);
}

onspray() {
  if(!challengesenabledforplayer()) {
    return;
  }
  locale = gettouchingspraylocaletriggers(self);

  if(locale != -1)
    self reportchallengeuserevent("spray", locale, getoperators());
}

_id_F09E914E200D1A42(objweapon) {
  weaponname = undefined;

  if(!isDefined(objweapon) || !isDefined(objweapon.basename))
    weaponname = "";

  if(!isDefined(weaponname)) {
    weaponname = "";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentRefFromWeapon"))
      weaponname = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentRefFromWeapon")]](objweapon);

    if(!isDefined(weaponname)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName"))
        weaponname = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](objweapon.basename);
    }

    if(weaponname == "equip_throwing_knife_fire" || weaponname == "equip_throwing_knife_electric" || weaponname == "equip_shuriken")
      weaponname = "equip_throwing_knife";
  }

  return weaponname;
}

_id_CE112254F7CBA89E(objweapon) {
  _id_E2AA32C9738D9264 = _id_5AF37CE2C176C946();

  if(!isDefined(objweapon))
    return undefined;

  weaponname = undefined;

  if(isweapon(objweapon))
    weaponname = objweapon.basename;
  else
    weaponname = objweapon;

  if(!isDefined(weaponname))
    return undefined;

  _id_4BB9768282D4260D = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);

  if(isDefined(level.weaponmapdata[_id_4BB9768282D4260D]) && isDefined(level.weaponmapdata[_id_4BB9768282D4260D].group))
    _id_CF4209C200F8BBF4 = level.weaponmapdata[_id_4BB9768282D4260D].group;
  else
    return undefined;

  _id_0B28608820870666 = 0;

  if(_id_4BB9768282D4260D == "iw9_ar_golf3" || weaponname == "iw9_ar_schotel" || weaponname == "iw9_br_msecho" || weaponname == "iw9_br_soscar14") {
    _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["battle"]);
    return _id_0B28608820870666;
  }

  switch (_id_CF4209C200F8BBF4) {
    case "weapon_assault":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["rifle"]);
      break;
    case "weapon_dmr":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["marksman"]);
      break;
    case "weapon_sniper":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["sniper"]);
      break;
    case "weapon_projectile":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["rocketlauncher"]);
      break;
    case "weapon_lmg":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["mg"]);
      break;
    case "weapon_pistol":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["pistol"]);
      break;
    case "weapon_shotgun":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["spread"]);
      break;
    case "weapon_smg":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["smg"]);
      break;
    case "weapon_battle":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["battle"]);
      break;
    case "weapon_melee":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["melee_primary"]);
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["melee"]);
      break;
    case "weapon_melee2":
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["melee_secondary"]);
      _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["melee"]);
      break;
    default:
      return 0;
  }

  return _id_0B28608820870666;
}

_id_6D40F12A09494350(_id_3A7747BC9807F3C0, _id_B5C99E03C0C2DC5C) {
  if(_id_B5C99E03C0C2DC5C > 31 || isstring(_id_3A7747BC9807F3C0))
    return _func_1DB72F37B2E59440(_id_3A7747BC9807F3C0 + "", _id_B5C99E03C0C2DC5C);
  else
    return _id_3A7747BC9807F3C0 | 1 << _id_B5C99E03C0C2DC5C;
}

_id_3005EF56488DF9BE(_id_3A7747BC9807F3C0) {
  _id_CC819DE748CB6689 = _id_3A7747BC9807F3C0 + "";
  _id_6D39D9505A5BD620 = _id_CC819DE748CB6689.size;
  characters = [];

  for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < _id_6D39D9505A5BD620; _id_AC0E5B4AC96AA80E++)
    characters[_id_6D39D9505A5BD620 - _id_AC0E5B4AC96AA80E - 1] = int(_id_CC819DE748CB6689[_id_6D39D9505A5BD620 - _id_AC0E5B4AC96AA80E - 1]);

  _id_CD2A94DBC798FBF0 = _id_6D39D9505A5BD620 - 1;
  result = [];
  _id_2FF1CEF579BA3705 = 0;

  for(;;) {
    _id_1E43090ECBAE17D7 = characters[_id_CD2A94DBC798FBF0] % 2;
    result[_id_2FF1CEF579BA3705] = _id_1E43090ECBAE17D7 == 1;
    _id_2FF1CEF579BA3705 = _id_2FF1CEF579BA3705 + 1;

    if(_id_1E43090ECBAE17D7 == 1)
      characters[_id_CD2A94DBC798FBF0] = characters[_id_CD2A94DBC798FBF0] - 1;

    _id_17C1A7159D6CE06A = 1;

    for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < _id_6D39D9505A5BD620; _id_AC0E5B4AC96AA80E++) {
      _id_7DC3241E7F3C6B24 = characters[_id_6D39D9505A5BD620 - _id_AC0E5B4AC96AA80E - 1];

      if(_id_7DC3241E7F3C6B24 != 0)
        _id_17C1A7159D6CE06A = 0;

      if(_id_7DC3241E7F3C6B24 % 2 == 1)
        characters[_id_6D39D9505A5BD620 - _id_AC0E5B4AC96AA80E] = characters[_id_6D39D9505A5BD620 - _id_AC0E5B4AC96AA80E] + 5;

      characters[_id_6D39D9505A5BD620 - _id_AC0E5B4AC96AA80E - 1] = int(_id_7DC3241E7F3C6B24 / 2);
    }

    if(_id_17C1A7159D6CE06A)
      return result;
  }
}

getchallengegamemode(player) {
  _id_B2FF82EC901486E4 = 0;

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 5);

  if(istrue(level._id_EC2FB549B15AD827)) {
    _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 6);
    return _id_B2FF82EC901486E4;
  }

  if(istrue(level._id_77907D733ABE8B63)) {
    _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 7);
    return _id_B2FF82EC901486E4;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 3);
      return _id_B2FF82EC901486E4;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(isDefined(gametype)) {
      if(gametype == "brtdm" || gametype == "brtdm_mgl") {
        _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 3);
        return _id_B2FF82EC901486E4;
      } else if(scripts\common\utility::iscp()) {
        _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 2);
        return _id_B2FF82EC901486E4;
      } else if(scripts\common\utility::issp()) {
        _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 0);
        return _id_B2FF82EC901486E4;
      } else {
        _id_B2FF82EC901486E4 = _id_6D40F12A09494350(_id_B2FF82EC901486E4, 1);
        return _id_B2FF82EC901486E4;
      }
    }
  }

  return 0;
}

_id_AFF35122A61A900B(team) {
  if(isDefined(team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    operatorref = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](team);
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(operatorref);

    if(!isDefined(lootid) || lootid < 0)
      return 0;

    return lootid;
  }

  return 0;
}

_id_261CFB5C8119EA2B(_id_576499139629F6FA) {
  if(!isDefined(_id_576499139629F6FA))
    return 0;

  if(!isDefined(level.challengeandeventglobals.game_type_col) || !isDefined(level.challengeandeventglobals.game_type_col[_id_576499139629F6FA]))
    return 0;

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
    return 102;

  if(!getdvarint("dvar_78653010D584AA6E")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
        if(isDefined(level.brgametype) && isDefined(level.brgametype.name)) {
          switch (level.brgametype.name) {
            case "plunder":
              return 99;
            case "extract":
              return 98;
            case "evac":
              return 97;
            case "sandbox":
              return 96;
            case "exgm":
            case "dmz":
              return 95;
            case "resurgence":
              return 94;
            case "zonecontrol":
              return 93;
            case "zxp":
              return 92;
            case "aladdin":
            case "":
              break;
            default:
              break;
          }
        }
      }
    }
  }

  return level.challengeandeventglobals.game_type_col[_id_576499139629F6FA];
}

_id_17C5D7FEB226E256() {
  if(!getdvarint("dvar_78653010D584AA6E")) {
    gametype = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType"))
      gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(!isDefined(gametype))
      gametype = getDvar("g_gametype");

    _id_E37D5A134143CC83 = _id_261CFB5C8119EA2B(gametype);
    return _id_E37D5A134143CC83;
  }

  return _id_261CFB5C8119EA2B(level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8);
}

_id_5AF37CE2C176C946() {
  if(!isDefined(level._id_E2AA32C9738D9264)) {
    level._id_E2AA32C9738D9264 = spawnStruct();
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB = [];
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["none"] = 0;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["sniper"] = 1;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["mg"] = 2;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["smg"] = 3;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["spread"] = 4;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["pistol"] = 5;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["grenade"] = 6;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["rocketlauncher"] = 7;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["turret"] = 8;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["throwingknife"] = 9;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["non-player"] = 10;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["item"] = 11;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["beam"] = 12;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["ball"] = 13;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["rifle"] = 14;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["battle"] = 15;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["marksman"] = 16;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["killstreak"] = 17;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["melee_primary"] = 18;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["melee_secondary"] = 19;
    level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB["melee"] = 20;
  }

  return level._id_E2AA32C9738D9264._id_92F35FCFAE58B4EB;
}

_id_D6973792FD45B035() {
  _id_E4F4A057080C0ED5 = [];
  _id_E4F4A057080C0ED5["specialty_survivor"] = 0;
  _id_E4F4A057080C0ED5["specialty_extra_tactical"] = 1;
  _id_E4F4A057080C0ED5["specialty_overwatch"] = 2;
  _id_E4F4A057080C0ED5["specialty_grenade_expert"] = 14;
  _id_E4F4A057080C0ED5["specialty_eod"] = 15;
  _id_E4F4A057080C0ED5["specialty_focus"] = 3;
  _id_E4F4A057080C0ED5["specialty_restock"] = 16;
  _id_E4F4A057080C0ED5["specialty_overcharge_field_upgrade"] = 4;
  _id_E4F4A057080C0ED5["specialty_warhead"] = 5;
  _id_E4F4A057080C0ED5["specialty_munitions_2"] = 6;
  _id_E4F4A057080C0ED5["specialty_scavenger_plus"] = 7;
  _id_E4F4A057080C0ED5["specialty_guerrilla"] = 8;
  _id_E4F4A057080C0ED5["specialty_hardline"] = 9;
  _id_E4F4A057080C0ED5["specialty_huntmaster"] = 10;
  _id_E4F4A057080C0ED5["specialty_tactical_recon"] = 11;
  _id_E4F4A057080C0ED5["specialty_hustle"] = 12;
  _id_E4F4A057080C0ED5["specialty_covert_ops"] = 13;
  _id_E4F4A057080C0ED5["specialty_tac_resist"] = 17;
  _id_E4F4A057080C0ED5["specialty_surveillance"] = 18;
  _id_E4F4A057080C0ED5["specialty_quick_fix"] = 19;
  _id_E4F4A057080C0ED5["specialty_null"] = 20;
  _id_E4F4A057080C0ED5[""] = 20;
  return _id_E4F4A057080C0ED5;
}

getlocation(_id_B205D90302DA2F07, _id_FB6BAFB61D5C3D4A) {
  location = 0;

  if(isDefined(level.mapname)) {
    switch (level.mapname) {
      case "mp_saba":
      case "mp_saba_pm":
      case "mp_saba2":
        location = _id_6D40F12A09494350(location, 0);
        break;
      case "mp_sealion":
        location = _id_6D40F12A09494350(location, 1);
        break;
      case "mp_bio_lab":
        location = _id_6D40F12A09494350(location, 2);
        break;
      case "mp_delta":
        location = _id_6D40F12A09494350(location, 63);
        break;
      default:
        break;
    }
  }

  if(isDefined(_id_B205D90302DA2F07)) {
    switch (_id_B205D90302DA2F07) {
      case "saba_airport":
        location = _id_6D40F12A09494350(location, 3);
        break;
      case "saba_moderncity":
        location = _id_6D40F12A09494350(location, 4);
        break;
      case "saba_lone":
        location = _id_6D40F12A09494350(location, 5);
        break;
      case "saba_fishtwn":
        location = _id_6D40F12A09494350(location, 6);
        break;
      case "saba_sira":
        location = _id_6D40F12A09494350(location, 7);
        break;
      case "saba_sunken":
        location = _id_6D40F12A09494350(location, 8);
        break;
      case "saba_oasis":
        location = _id_6D40F12A09494350(location, 9);
        break;
      case "saba_oilfield":
        location = _id_6D40F12A09494350(location, 10);
        break;
      case "saba_caves":
        location = _id_6D40F12A09494350(location, 11);
        break;
      case "saba_fort":
        location = _id_6D40F12A09494350(location, 12);
        break;
      case "saba_observatory":
        location = _id_6D40F12A09494350(location, 13);
        break;
      case "saba_wartorn":
        location = _id_6D40F12A09494350(location, 14);
        break;
      case "saba_marshland":
        location = _id_6D40F12A09494350(location, 15);
        break;
      case "saba_oldtwn":
        location = _id_6D40F12A09494350(location, 16);
        break;
      case "saba_mtntwn":
        location = _id_6D40F12A09494350(location, 17);
        break;
      case "saba_exhume":
        location = _id_6D40F12A09494350(location, 18);
        break;
      case "saba_cemetery":
        location = _id_6D40F12A09494350(location, 19);
        break;
      case "saba_hydro":
        location = _id_6D40F12A09494350(location, 20);
        break;
      case "saba_suburbs_01":
        location = _id_6D40F12A09494350(location, 22);
        break;
      case "saba_suburbs_02":
        location = _id_6D40F12A09494350(location, 23);
        break;
      case "saba_suburbs_03":
        location = _id_6D40F12A09494350(location, 24);
        break;
      case "saba_suburbs_04":
        location = _id_6D40F12A09494350(location, 25);
        break;
      case "saba_suburbs_05":
        location = _id_6D40F12A09494350(location, 26);
        break;
      case "saba_suburbs_06":
        location = _id_6D40F12A09494350(location, 27);
        break;
      case "saba_suburbs_07":
        location = _id_6D40F12A09494350(location, 28);
        break;
      case "saba_suburbs_08":
        location = _id_6D40F12A09494350(location, 29);
        break;
      case "saba_suburbs_09":
        location = _id_6D40F12A09494350(location, 30);
        break;
      case "saba_suburbs_10":
        location = _id_6D40F12A09494350(location, 31);
        break;
      case "saba_suburbs_11":
        location = _id_6D40F12A09494350(location, 32);
        break;
      case "saba_suburbs_12":
        location = _id_6D40F12A09494350(location, 33);
        break;
      case "saba_suburbs_13":
        location = _id_6D40F12A09494350(location, 34);
        break;
      case "saba_suburbs_14":
        location = _id_6D40F12A09494350(location, 35);
        break;
      case "sealion_apartments":
        location = _id_6D40F12A09494350(location, 36);
        break;
      case "sealion_beachclub":
        location = _id_6D40F12A09494350(location, 37);
        break;
      case "sealion_castle":
        location = _id_6D40F12A09494350(location, 38);
        break;
      case "sealion_coastalruins":
        location = _id_6D40F12A09494350(location, 39);
        break;
      case "sealion_port":
        location = _id_6D40F12A09494350(location, 40);
        break;
      case "sealion_culdesac":
        location = _id_6D40F12A09494350(location, 41);
        break;
      case "sealion_powerplant":
        location = _id_6D40F12A09494350(location, 42);
        break;
      case "sealion_residential":
        location = _id_6D40F12A09494350(location, 43);
        break;
      case "sealion_shipwreck":
        location = _id_6D40F12A09494350(location, 44);
        break;
      case "sealion_towncenter":
        location = _id_6D40F12A09494350(location, 45);
        break;
      case "sealion_watertreatment":
        location = _id_6D40F12A09494350(location, 46);
        break;
      case "sealion_waterways":
        location = _id_6D40F12A09494350(location, 47);
        break;
      case "delta_castle":
        location = _id_6D40F12A09494350(location, 48);
        break;
      case "delta_cemetary":
        location = _id_6D40F12A09494350(location, 49);
        break;
      case "delta_cityhall":
        location = _id_6D40F12A09494350(location, 50);
        break;
      case "delta_firestation":
        location = _id_6D40F12A09494350(location, 51);
        break;
      case "delta_fleamarket":
        location = _id_6D40F12A09494350(location, 52);
        break;
      case "delta_floatinghouses":
        location = _id_6D40F12A09494350(location, 53);
        break;
      case "delta_library":
        location = _id_6D40F12A09494350(location, 54);
        break;
      case "delta_marina":
        location = _id_6D40F12A09494350(location, 55);
        break;
      case "delta_museum":
        location = _id_6D40F12A09494350(location, 56);
        break;
      case "delta_nemo":
        location = _id_6D40F12A09494350(location, 57);
        break;
      case "delta_policestation":
        location = _id_6D40F12A09494350(location, 58);
        break;
      case "delta_shoppingcenter":
        location = _id_6D40F12A09494350(location, 59);
        break;
      case "delta_stadium":
        location = _id_6D40F12A09494350(location, 60);
        break;
      case "delta_station":
        location = _id_6D40F12A09494350(location, 61);
        break;
      case "delta_terminal":
        location = _id_6D40F12A09494350(location, 62);
        break;
      default:
        break;
    }
  }

  if(isDefined(_id_FB6BAFB61D5C3D4A)) {
    switch (_id_FB6BAFB61D5C3D4A) {
      case "sira_mall":
        location = _id_6D40F12A09494350(location, 21);
        break;
      case "saba_oasis":
        location = _id_6D40F12A09494350(location, 9);
        break;
    }
  }

  return location;
}

_id_55BE16FB0F5F4A19(_id_B205D90302DA2F07, _id_FB6BAFB61D5C3D4A) {
  location = 0;

  if(isDefined(level.mapname)) {
    switch (level.mapname) {
      case "mp_biobunker":
        location = _id_6D40F12A09494350(location, 9);
        break;
      case "mp_mgl_escape4":
        location = _id_6D40F12A09494350(location, 19);
        break;
      case "mp_mgl_verdansk":
        location = _id_6D40F12A09494350(location, 31);
        break;
      default:
        break;
    }
  }

  if(isDefined(_id_B205D90302DA2F07)) {
    switch (_id_B205D90302DA2F07) {
      case "delta_townhouse1":
        location = _id_6D40F12A09494350(location, 0);
        break;
      case "delta_townhouse2":
        location = _id_6D40F12A09494350(location, 1);
        break;
      case "delta_townhouse3":
        location = _id_6D40F12A09494350(location, 2);
        break;
      case "delta_townhouse4":
        location = _id_6D40F12A09494350(location, 3);
        break;
      case "delta_townhouse5":
        location = _id_6D40F12A09494350(location, 4);
        break;
      case "delta_townhouse6":
        location = _id_6D40F12A09494350(location, 5);
        break;
      case "delta_townhouse7":
        location = _id_6D40F12A09494350(location, 6);
        break;
      case "delta_windmill":
        location = _id_6D40F12A09494350(location, 7);
        break;
      case "delta_zoo":
        location = _id_6D40F12A09494350(location, 8);
        break;
      case "biobunker_radiation":
        location = _id_6D40F12A09494350(location, 10);
        break;
      case "biobunker_flooded":
        location = _id_6D40F12A09494350(location, 11);
        break;
      case "biobunker_boss":
        location = _id_6D40F12A09494350(location, 12);
        break;
      case "biobunker_shop":
        location = _id_6D40F12A09494350(location, 13);
        break;
      case "biobunker_dark":
        location = _id_6D40F12A09494350(location, 14);
        break;
      case "biobunker_office":
        location = _id_6D40F12A09494350(location, 15);
        break;
      case "biobunker_controlroom":
        location = _id_6D40F12A09494350(location, 16);
        break;
      case "biobunker_datacenter":
        location = _id_6D40F12A09494350(location, 17);
        break;
      case "escape4_qblock":
        location = _id_6D40F12A09494350(location, 20);
        break;
      case "escape4_factory":
        location = _id_6D40F12A09494350(location, 21);
        break;
      case "escape4_chemplant":
        location = _id_6D40F12A09494350(location, 22);
        break;
      case "escape4_commstower":
        location = _id_6D40F12A09494350(location, 23);
        break;
      case "escape4_control":
        location = _id_6D40F12A09494350(location, 24);
        break;
      case "escape4_harbor":
        location = _id_6D40F12A09494350(location, 25);
        break;
      case "escape4_headquarters":
        location = _id_6D40F12A09494350(location, 26);
        break;
      case "escape4_shore":
        location = _id_6D40F12A09494350(location, 27);
        break;
      case "escape4_biolab":
        location = _id_6D40F12A09494350(location, 28);
        break;
      case "escape4_residence":
        location = _id_6D40F12A09494350(location, 29);
        break;
      case "escape4_deconfacility":
        location = _id_6D40F12A09494350(location, 30);
        break;
      case "verdansk_dam":
        location = _id_6D40F12A09494350(location, 32);
        break;
      case "verdansk_military_base":
        location = _id_6D40F12A09494350(location, 33);
        break;
      case "verdansk_quarry":
        location = _id_6D40F12A09494350(location, 34);
        break;
      case "verdansk_airport":
        location = _id_6D40F12A09494350(location, 35);
        break;
      case "verdansk_tv_station":
        location = _id_6D40F12A09494350(location, 36);
        break;
      case "verdansk_storage_town":
        location = _id_6D40F12A09494350(location, 37);
        break;
      case "verdansk_superstore":
        location = _id_6D40F12A09494350(location, 38);
        break;
      case "verdansk_stadium":
        location = _id_6D40F12A09494350(location, 39);
        break;
      case "verdansk_lumber":
        location = _id_6D40F12A09494350(location, 40);
        break;
      case "verdansk_boneyard":
        location = _id_6D40F12A09494350(location, 41);
        break;
      case "verdansk_train_station":
        location = _id_6D40F12A09494350(location, 42);
        break;
      case "verdansk_hospital":
        location = _id_6D40F12A09494350(location, 43);
        break;
      case "verdansk_downtown":
        location = _id_6D40F12A09494350(location, 44);
        break;
      case "verdansk_farmland":
        location = _id_6D40F12A09494350(location, 45);
        break;
      case "verdansk_promenade_west":
        location = _id_6D40F12A09494350(location, 46);
        break;
      case "verdansk_promenade_east":
        location = _id_6D40F12A09494350(location, 47);
        break;
      case "verdansk_hills":
        location = _id_6D40F12A09494350(location, 48);
        break;
      case "verdansk_park":
        location = _id_6D40F12A09494350(location, 49);
        break;
      case "verdansk_port":
        location = _id_6D40F12A09494350(location, 50);
        break;
      case "verdansk_prison":
        location = _id_6D40F12A09494350(location, 51);
        break;
      default:
        break;
    }
  }

  if(isDefined(_id_FB6BAFB61D5C3D4A)) {
    switch (_id_FB6BAFB61D5C3D4A) {
      case "saba_sandstorm":
        location = _id_6D40F12A09494350(location, 18);
        break;
    }
  }

  return location;
}

_id_3EA2B9FA713D6ED3(player) {
  _id_D064B7165A057B5D = findloadoutperks(player);
  _id_E4F4A057080C0ED5 = _id_D6973792FD45B035();
  _id_7FB63B7FAC6D1698 = 0;

  foreach(perk in _id_D064B7165A057B5D) {
    if(isDefined(_id_E4F4A057080C0ED5[perk]))
      _id_7FB63B7FAC6D1698 = _id_6D40F12A09494350(_id_7FB63B7FAC6D1698, _id_E4F4A057080C0ED5[perk]);
  }

  return _id_7FB63B7FAC6D1698;
}

_id_0B050ED1983293D8(player, _id_363274577DC0543E, perkref, value) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();

  if(isDefined(value) && value < 0)
    value = 1;

  _id_8852E1DA266FEA14 = 0;

  if(isDefined(perkref))
    _id_8852E1DA266FEA14 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(perkref);

  _id_3A7747BC9807F3C0 = 0;
  _id_3A7747BC9807F3C0 = _id_6D40F12A09494350(_id_3A7747BC9807F3C0, _id_363274577DC0543E);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(player._id_DA28916E7827AF7C)) {
    location = getlocation(player._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(player._id_DA28916E7827AF7C);
  }

  _id_8E81148472FB520A(player, "97", [8, _id_B2FF82EC901486E4, 9, gametype, 31, value, 32, 1, 72, location, 121, _id_0FCF7B6E6D8C41C8, 76, _id_8852E1DA266FEA14, 85, _id_3A7747BC9807F3C0]);
}

_id_18545210159E68C8(attacker, victim, _id_425D52C81F1883FC, _id_425D55C81F188A95, objweapon, damage, meansofdeath, _id_3A33B126031BE677, hitloc) {
  if(!isDefined(attacker)) {
    return;
  }
  _id_425D52C81F1883FC = scripts\engine\utility::_id_53C4C53197386572(_id_425D52C81F1883FC, 0);
  _id_425D55C81F188A95 = scripts\engine\utility::_id_53C4C53197386572(_id_425D55C81F188A95, 0);
  _id_3A33B126031BE677 = scripts\engine\utility::_id_53C4C53197386572(_id_3A33B126031BE677, 0);
  hitloc = scripts\engine\utility::_id_53C4C53197386572(hitloc, 0);
  gametype = _id_17C5D7FEB226E256();
  _id_349E390338192305 = findgunsmithattachments(objweapon);
  _id_7FB63B7FAC6D1698 = _id_3EA2B9FA713D6ED3(attacker);
  _id_B5EEC3B49CF346D2 = [damage, 0];
  _id_C5B28F88D9B3BFD7 = 0;
  _id_7B718EF6C64F049F = 0;
  [_id_C5B28F88D9B3BFD7, _id_7B718EF6C64F049F] = findenemytype(victim);
  distance = undefined;

  if(isDefined(victim) && isDefined(victim.origin) && isDefined(attacker.origin))
    distance = int(distance(attacker.origin, victim.origin));

  _id_A5958DC7369199C7 = "none";

  if(isDefined(attacker.super) && isDefined(attacker.super.staticdata) && isDefined(attacker.super.staticdata.ref) && attacker.super.isactive)
    _id_A5958DC7369199C7 = attacker.super.staticdata.ref;

  _id_C0D251F100091822 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_A5958DC7369199C7);
  _id_B2FF82EC901486E4 = getchallengegamemode(attacker);
  _id_A74FC57FB4A4D3E6 = attacker _id_AFF35122A61A900B(attacker.team);

  if(!isDefined(_id_A74FC57FB4A4D3E6))
    _id_A74FC57FB4A4D3E6 = 0;

  _id_904C82687DDFEB02 = _id_2669878CF5A1B6BC::_id_89A83AE9A4C4142A(objweapon);

  if(!isDefined(_id_904C82687DDFEB02))
    _id_904C82687DDFEB02 = 0;

  _id_9EEB614F9AEE06B3 = 0;
  _id_91F46FFD5296EEE1 = 0;

  if(isDefined(objweapon) && isDefined(objweapon.camo)) {
    _id_A79C87A31042789A = objweapon.camo;

    if(issubstr(_id_A79C87A31042789A, "_comp_01"))
      _id_91F46FFD5296EEE1 = 1;
    else if(issubstr(_id_A79C87A31042789A, "_comp_02"))
      _id_91F46FFD5296EEE1 = 2;
    else if(issubstr(_id_A79C87A31042789A, "_comp_03"))
      _id_91F46FFD5296EEE1 = 3;
    else if(issubstr(_id_A79C87A31042789A, "_comp_04"))
      _id_91F46FFD5296EEE1 = 4;
  }

  _id_E2AA32C9738D9264 = _id_5AF37CE2C176C946();
  _id_0B28608820870666 = 0;
  _id_0B28608820870666 = _id_CE112254F7CBA89E(objweapon);
  iskillstreak = _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon);
  isvehicle = scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "isVehicleWeapon") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "isVehicleWeapon")]](objweapon);
  isequipment = 0;
  _id_F275474AACD30C96 = 0;

  if(_id_904C82687DDFEB02 == 0) {
    _id_84CAEF0D45386390 = _id_F09E914E200D1A42(objweapon);
    _id_5C32B638BB67C982 = level.equipment.table[_id_84CAEF0D45386390];

    if(isDefined(_id_5C32B638BB67C982)) {
      _id_904C82687DDFEB02 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_5C32B638BB67C982.ref);
      isequipment = 1;
    }
  }

  if(isequipment) {
    if(!isDefined(_id_0B28608820870666)) {
      _id_0B28608820870666 = 0;

      if(isDefined(attacker) && isDefined(objweapon) && isDefined(_id_E2AA32C9738D9264[weaponclass(objweapon)]))
        _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264[weaponclass(objweapon)]);
    }
  }

  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(attacker._id_DA28916E7827AF7C)) {
    location = getlocation(attacker._id_DA28916E7827AF7C, attacker._id_FB6BAFB61D5C3D4A);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(attacker._id_DA28916E7827AF7C, attacker._id_FB6BAFB61D5C3D4A);
  }

  if(iskillstreak) {
    if(!isDefined(_id_0B28608820870666))
      _id_0B28608820870666 = 0;

    _id_0B28608820870666 = _id_6D40F12A09494350(_id_0B28608820870666, _id_E2AA32C9738D9264["killstreak"]);

    if(isDefined(level.killstreakweaponmap)) {
      _id_F4DB485B689515A8 = level.killstreakweaponmap[objweapon.basename];

      if(isDefined(_id_F4DB485B689515A8))
        _id_904C82687DDFEB02 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_F4DB485B689515A8);
    }
  }

  _id_0BB38571CCA0414F = _id_C1945F26D99B0ED9(attacker);
  _id_3FFF36CAEACE1B84 = _id_5D99311B5A7DFFDA();

  if(isDefined(level._id_C596A10A13C5CD7C))
    _id_3FFF36CAEACE1B84 = [[level._id_C596A10A13C5CD7C]](_id_3FFF36CAEACE1B84, victim);

  _id_9C98419964190A71 = istrue(level._id_1147BBC93EA9B83C);
  _id_0774C9CA5D1D6221 = 0;

  if(_id_B2FF82EC901486E4 & 8)
    _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onEnemyKilled"))
    attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onEnemyKilled")]](attacker, victim, objweapon, _id_425D52C81F1883FC);

  _id_8E81148472FB520A(attacker, "75", [8, _id_B2FF82EC901486E4, 14, _id_A74FC57FB4A4D3E6, 44, _id_904C82687DDFEB02, 9, gametype, 32, 1, 33, _id_349E390338192305[0], 35, _id_349E390338192305[1], 36, _id_349E390338192305[2], 37, _id_349E390338192305[3], 38, _id_349E390338192305[4], 39, _id_349E390338192305[5], 40, _id_349E390338192305[6], 41, _id_349E390338192305[7], 42, _id_349E390338192305[8], 34, _id_349E390338192305[9], 43, _id_0B28608820870666, 12, _id_425D52C81F1883FC, 100, _id_425D55C81F188A95, 13, _id_C5B28F88D9B3BFD7, 72, location, 121, _id_0FCF7B6E6D8C41C8, 81, _id_7FB63B7FAC6D1698, 76, _id_C0D251F100091822, 93, distance, 95, _id_3A33B126031BE677, 102, _id_91F46FFD5296EEE1, 112, hitloc, 117, _id_0774C9CA5D1D6221, 119, _id_3FFF36CAEACE1B84, 126, _id_0BB38571CCA0414F[0], 127, _id_0BB38571CCA0414F[1], 128, _id_0BB38571CCA0414F[2], 129, _id_0BB38571CCA0414F[3], 130, _id_0BB38571CCA0414F[4], 137, _id_9C98419964190A71, 149, _id_7B718EF6C64F049F]);
}

_id_C43D8B7A5461CDCE(lootid) {
  _id_25978461C6E4F61B = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  itemtype = undefined;

  if(!isDefined(_id_25978461C6E4F61B)) {
    itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

    if(!isDefined(itemtype))
      return undefined;
  } else
    itemtype = level.br_pickups.br_itemtype[_id_25978461C6E4F61B];

  switch (itemtype) {
    case "ammo":
      return 3;
    case "gear":
      return 4;
    case "health":
      return 6;
    case "revive":
      return 8;
    case "lethal":
      return 12;
    case "tactical":
      return 13;
    case "killstreak":
      return 11;
    case "super":
      return 19;
    case "weapon":
      return 1;
    case "plunder":
      return 7;
    case "attachment":
      return 18;
    case "plate_carrier":
      return 5;
    case "keycard":
      return 9;
    case "key":
      return 10;
    case "valuable":
      return 14;
    case "personal":
      return 15;
    case "dogtag":
      return 16;
    case "weaponcase":
      return 17;
    default:
      return undefined;
  }
}

_id_CFEB523FD3AA9ECF(player, lootid, type, _id_3EAA9F644DBE7834, quantity) {
  if(!player challengesenabledforplayer())
    return 0;

  if(!isDefined(quantity))
    quantity = 1;

  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  typeid = undefined;

  if(isDefined(type))
    typeid = _func_96B7FC7E35353254(type);

  if(!isDefined(_id_3EAA9F644DBE7834)) {
    _id_3EAA9F644DBE7834 = 0;
    _id_3EAA9F644DBE7834 = _id_6D40F12A09494350(_id_3EAA9F644DBE7834, 0);
  }

  _id_A74FC57FB4A4D3E6 = player _id_AFF35122A61A900B(player.team);
  _id_8E81148472FB520A(player, "113", [32, 1, 31, quantity, 76, lootid, 8, _id_B2FF82EC901486E4, 9, gametype, 46, typeid, 85, _id_3EAA9F644DBE7834, 18, _id_A74FC57FB4A4D3E6]);
}

_id_D24138B32084FC3E(player, lootid, type, _id_3EAA9F644DBE7834, quantity, source, _id_B205D90302DA2F07) {
  if(!player challengesenabledforplayer())
    return 0;

  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  typeid = undefined;

  if(isDefined(type))
    typeid = _func_96B7FC7E35353254(type);

  _id_5577636292591C8B = undefined;

  if(isDefined(lootid))
    _id_5577636292591C8B = _id_C43D8B7A5461CDCE(lootid);

  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;
  location = getlocation(scripts\engine\utility::ter_op(isDefined(_id_B205D90302DA2F07), _id_B205D90302DA2F07, player._id_DA28916E7827AF7C));
  _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(scripts\engine\utility::ter_op(isDefined(_id_B205D90302DA2F07), _id_B205D90302DA2F07, player._id_DA28916E7827AF7C));
  quantity = _id_DC52E14B64052DDA(lootid, quantity);

  if(isDefined(typeid) && typeid < 0)
    logstring("IW9-592971: reportLootItemEvent::typeID is negative");

  if(isDefined(quantity) && quantity < 0)
    logstring("IW9-592971: reportLootItemEvent::quantity is negative");

  if(isDefined(_id_B2FF82EC901486E4) && _id_B2FF82EC901486E4 < 0)
    logstring("IW9-592971: reportLootItemEvent::gameMode is negative");

  if(isDefined(gametype) && gametype < 0)
    logstring("IW9-592971: reportLootItemEvent::gameType is negative");

  if(isDefined(location) && isint(location) && location < 0)
    logstring("IW9-592971: reportLootItemEvent::location is negative");

  if(isDefined(lootid) && lootid < 0)
    logstring("IW9-592971: reportLootItemEvent::lootID is negative");

  if(isDefined(_id_3EAA9F644DBE7834) && isint(_id_3EAA9F644DBE7834) && _id_3EAA9F644DBE7834 < 0)
    logstring("IW9-592971: reportLootItemEvent::method is negative");

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B < 0)
    logstring("IW9-592971: reportLootItemEvent::lootType is negative");

  if(isDefined(source) && isint(source) && source < 0)
    logstring("IW9-592971: reportLootItemEvent::source is negative");

  _id_8E81148472FB520A(player, "91", [32, 1, 46, typeid, 31, quantity, 8, _id_B2FF82EC901486E4, 9, gametype, 72, location, 121, _id_0FCF7B6E6D8C41C8, 76, lootid, 78, _id_3EAA9F644DBE7834, 77, _id_5577636292591C8B, 91, source]);

  if(isDefined(level._id_97EA4DAF8989E0C6))
    return [[level._id_97EA4DAF8989E0C6]](player, lootid, _id_5577636292591C8B);
}

_id_B7DE4AFAF79FF9B5(_id_629757F5C9E770D8, amount) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(amount <= 0) {
    return;
  }
  _id_E3FBCE1C8509474F = _func_2EF675C13CA1C4AF("dvar_AF7CFD1E80E4FB55", _id_629757F5C9E770D8);
  _id_A75E138CB4BCFEF8 = getdvarint(_id_E3FBCE1C8509474F, 0);

  if(_id_A75E138CB4BCFEF8 > 0) {
    return;
  }
  _id_FDD8ABEE94D24E72 = 0;
  _id_763565CB1EBE7F95 = 0;
  _id_CFB8AB0EB8945DBE = 0;

  switch (_id_629757F5C9E770D8) {
    case "damage":
      _id_763565CB1EBE7F95 = amount;
      _id_FDD8ABEE94D24E72 = 1;
      break;
    case "score":
      _id_CFB8AB0EB8945DBE = amount;
      _id_FDD8ABEE94D24E72 = 1;
      break;
    case "time_driving":
      break;
    case "time_alive_in_br_gas":
      break;
    case "time_alive_before_downed":
      break;
    case "distance":
      break;
    case "distance_foot":
      break;
    case "distance_sprint":
      break;
    case "distance_crouch":
      break;
    case "distance_vehicle":
      break;
    case "spray":
      break;
    case "gesture":
      break;
  }

  if(_id_FDD8ABEE94D24E72) {
    _id_B2FF82EC901486E4 = getchallengegamemode(self);
    gametype = _id_17C5D7FEB226E256();
    _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
    _id_0774C9CA5D1D6221 = 0;

    if(_id_B2FF82EC901486E4 & 8)
      _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C", 0);

    params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 101, _id_763565CB1EBE7F95, 88, _id_CFB8AB0EB8945DBE, 117, _id_0774C9CA5D1D6221];
    _id_7D97A2A745E514C4("362", params);
    self _meth_DB073176839D77FB("362", params);
  }
}

_id_563606223EF09517(player, amount) {
  _id_3EAA9F644DBE7834 = _id_6D40F12A09494350(0, 0);
  _id_D24138B32084FC3E(player, 8395, 7, _id_3EAA9F644DBE7834, amount, 0);
}

findgunsmithattachments(objweapon) {
  _id_349E390338192305 = [];

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "isCACPrimaryOrSecondary") || [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "isCACPrimaryOrSecondary")]](objweapon)) {
    if(isDefined(objweapon.attachments)) {
      _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_7208E21EA18240FB = 0;

      foreach(attachment in objweapon.attachments) {
        if(issubstr(attachment, "snprscope"))
          _id_7208E21EA18240FB = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentIsSelectable")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentIsSelectable")]](objweapon, attachment))
            _id_349E390338192305[_id_349E390338192305.size] = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(_id_49E6EF3EDADD524E, attachment);
        }
      }

      if(_id_7208E21EA18240FB)
        _id_349E390338192305[_id_349E390338192305.size] = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(_id_49E6EF3EDADD524E, "default_sniper_scope");
    }
  }

  for(_id_40E4B9C48B36C9EC = _id_349E390338192305.size; _id_40E4B9C48B36C9EC < 10; _id_40E4B9C48B36C9EC++)
    _id_349E390338192305[_id_40E4B9C48B36C9EC] = 0;

  return _id_349E390338192305;
}

findloadoutperks(attacker) {
  _id_D064B7165A057B5D = [];

  if(isDefined(attacker.classstruct)) {
    if(isDefined(attacker.classstruct.loadoutperks)) {
      foreach(perk in attacker.classstruct.loadoutperks)
      _id_D064B7165A057B5D = scripts\engine\utility::array_add(_id_D064B7165A057B5D, perk);
    }

    if(isDefined(attacker.classstruct._id_15F3E6DF722FB1CF))
      _id_D064B7165A057B5D = scripts\engine\utility::array_add(_id_D064B7165A057B5D, attacker.classstruct._id_15F3E6DF722FB1CF);

    if(isDefined(attacker.classstruct._id_15F3E5DF722FAF9C))
      _id_D064B7165A057B5D = scripts\engine\utility::array_add(_id_D064B7165A057B5D, attacker.classstruct._id_15F3E5DF722FAF9C);
  }

  return _id_D064B7165A057B5D;
}

findenemytype(victim) {
  _id_C5B28F88D9B3BFD7 = 0;
  _id_7B718EF6C64F049F = 0;

  if(isPlayer(victim))
    _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 0);

  _id_4C20E5ABF3CE9872 = 0;
  _id_AE8EB6D66C120397 = 0;
  _id_B786822D9A87AB34 = 0;
  _id_B93834C5C289DCDC = 0;

  if(isDefined(victim.streakinfo)) {
    _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 1);
    _id_D8061F26B5ECA018 = victim.streakinfo.streakname;
    _id_B93834C5C289DCDC = iskillstreakvehicle(_id_D8061F26B5ECA018);

    switch (_id_D8061F26B5ECA018) {
      case "sentry_gun":
      case "manual_turret":
      case "bradley":
      case "pac_sentry":
      case "juggernaut":
        _id_4C20E5ABF3CE9872 = 1;
        break;
      case "white_phosphorus":
      case "toma_strike":
      case "precision_airstrike":
      case "hover_jet":
      case "gunship":
      case "cruise_predator":
      case "chopper_support":
      case "chopper_gunner":
      case "nuke":
        _id_AE8EB6D66C120397 = 1;
        break;
      case "uav_bigmap":
      case "directional_uav":
      case "radar_drone_overwatch":
      case "scrambler_drone_guard":
      case "uav":
        _id_AE8EB6D66C120397 = 1;
        _id_B786822D9A87AB34 = 1;
        break;
      case "airdrop_multiple":
      case "airdrop":
        _id_B786822D9A87AB34 = 1;
        break;
    }

    if(_id_4C20E5ABF3CE9872)
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 4);

    if(_id_AE8EB6D66C120397)
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 3);

    if(_id_B786822D9A87AB34)
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 5);
  }

  if(isDefined(victim.vehiclename)) {
    _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 6);
    canfly = istrue(victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly());
    _id_941D95491D4D4817 = istrue(victim scripts\cp_mp\vehicles\vehicle::_id_7C62CA52F72901A1());

    if(_id_4C20E5ABF3CE9872 && !canfly && !_id_941D95491D4D4817)
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 4);
    else if(_id_AE8EB6D66C120397 || canfly)
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 3);

    if(victim.vehiclename == "dmz_boss_chopper") {
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 21);
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 24);
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 3);
    } else if(victim.vehiclename == "pac_sentry") {
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 21);
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 49);
    } else if(victim.vehiclename == "veh9_armored_acv_6x6") {
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 61);
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 21);
    }

    vehicletype = undefined;

    switch (victim.vehiclename) {
      case "atv":
        vehicletype = 28;
        break;
      case "light_tank":
        vehicletype = 29;
        break;
      case "little_bird":
        vehicletype = 30;
        break;
      case "veh9_acv_6x6":
        vehicletype = 31;
        break;
      case "veh9_apc_8x8":
        vehicletype = 32;
        break;
      case "veh9_blima":
        vehicletype = 33;
        break;
      case "veh9_chopped_pickup":
        vehicletype = 34;
        break;
      case "veh9_cougar":
        vehicletype = 35;
        break;
      case "veh9_hummer":
        vehicletype = 36;
        break;
      case "veh9_jltv_mg":
        vehicletype = 18;
        break;
      case "veh9_jltv":
        vehicletype = 37;
        break;
      case "veh9_mil_cargo_truck":
        vehicletype = 38;
        break;
      case "veh9_overland_2016":
        vehicletype = 39;
        break;
      case "veh9_palfa":
        vehicletype = 40;
        break;
      case "veh9_patrol_boat":
        vehicletype = 41;
        break;
      case "veh9_pickup_2014":
        vehicletype = 42;
        break;
      case "veh9_pwc":
        vehicletype = 43;
        break;
      case "veh9_rhib":
        vehicletype = 44;
        break;
      case "veh9_sedan_hatchback_1985":
        vehicletype = 45;
        break;
      case "veh9_suv_1996":
        vehicletype = 46;
        break;
      case "veh9_techo_rebel_armor":
        vehicletype = 47;
        break;
      case "veh9_utv":
        vehicletype = 48;
        break;
    }

    if(isDefined(vehicletype))
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, vehicletype);

    if(isDefined(victim.riders)) {
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 26);

      if(victim.vehiclename == "little_bird" || victim.vehiclename == "veh9_blima")
        _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 25);
    }

    if(scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(victim, self))
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 27);
  } else if(_id_B93834C5C289DCDC)
    _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 6);

  if(isDefined(victim.equipmentref))
    _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 7);

  if(istrue(victim.iszombie) || isDefined(victim._id_521FAC03E5F3A11B))
    _id_7B718EF6C64F049F = _id_6D40F12A09494350(_id_7B718EF6C64F049F, 4);

  if(isagent(victim)) {
    if(isDefined(victim.aitype))
      _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);
    else if(isDefined(victim.agent_type))
      [_id_C5B28F88D9B3BFD7, _id_7B718EF6C64F049F] = _id_0E9DC49603AC403D(_id_C5B28F88D9B3BFD7, _id_7B718EF6C64F049F, victim);
  }

  return [_id_C5B28F88D9B3BFD7, _id_7B718EF6C64F049F];
}

_id_C7496288999AC847(_id_DCF5E15C58C4152A, _id_1C9CB43BCF3EB16D) {
  return issubstr(_id_DCF5E15C58C4152A, "cartel") || scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() && isDefined(_id_1C9CB43BCF3EB16D) && _id_1C9CB43BCF3EB16D == "elimTarget";
}

_id_0E9DC49603AC403D(_id_C5B28F88D9B3BFD7, _id_7B718EF6C64F049F, victim) {
  _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 2);

  if(issubstr(victim.agent_type, "civilian"))
    _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 13);
  else {
    _id_86DF29145C484D9C = issubstr(victim.agent_type, "biolab") || issubstr(victim.agent_type, "merc");

    if(!_id_86DF29145C484D9C)
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 14);

    if(issubstr(victim.agent_type, "jugg"))
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 8);
    else if(issubstr(victim.agent_type, "riotshield"))
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 9);
    else if(issubstr(victim.agent_type, "velikan")) {
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 21);
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 50);
    } else if(issubstr(victim.agent_type, "firebug"))
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 58);
    else if(issubstr(victim.agent_type, "butcher"))
      _id_7B718EF6C64F049F = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 1);
    else if(issubstr(victim.agent_type, "swamp"))
      _id_7B718EF6C64F049F = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 3);
    else if(issubstr(victim.agent_type, "mummy"))
      _id_7B718EF6C64F049F = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 2);
    else
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 12);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ai_mp_controller", "agentPers_getAgentPersData")) {
      _id_3B341F9DC3B7FFB4 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "agentPers_getAgentPersData");

      if(istrue([[_id_3B341F9DC3B7FFB4]](victim, "elite")))
        _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 11);

      tier = [[_id_3B341F9DC3B7FFB4]](victim, "tier");

      if(isDefined(tier)) {
        if(tier == 1)
          _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 15);
        else if(tier == 2)
          _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 16);
        else
          _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 17);

        if(tier == 2 || tier == 3)
          _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 19);
      }

      category = [[_id_3B341F9DC3B7FFB4]](victim, "category");
      _id_1C9CB43BCF3EB16D = [[_id_3B341F9DC3B7FFB4]](victim, "subcategory");

      if(issubstr(victim.agent_type, "aq"))
        _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 52);
      else if(_id_86DF29145C484D9C)
        _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 53);
      else if(_id_C7496288999AC847(victim.agent_type, _id_1C9CB43BCF3EB16D))
        _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 54);
      else if(issubstr(victim.agent_type, "ru"))
        _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 62);

      if(isDefined(category) && isDefined(_id_1C9CB43BCF3EB16D)) {
        if(category == "mission" && _id_1C9CB43BCF3EB16D == "elimTarget")
          _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 20);

        if(category == "bosses") {
          _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 21);

          if(_id_1C9CB43BCF3EB16D == "jugg")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 22);
          else if(_id_1C9CB43BCF3EB16D == "chemistBoss")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 23);
          else if(_id_1C9CB43BCF3EB16D == "trapperBoss")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 51);
          else if(_id_1C9CB43BCF3EB16D == " pyroBoss")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 55);
          else if(_id_1C9CB43BCF3EB16D == "ratBoss")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 56);
          else if(_id_1C9CB43BCF3EB16D == "sniperBoss")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 59);
          else if(_id_1C9CB43BCF3EB16D == "rusherBoss")
            _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 60);
          else if(_id_1C9CB43BCF3EB16D == "jailerBoss")
            _id_7B718EF6C64F049F = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 0);
        }

        if(_id_1C9CB43BCF3EB16D == "jailerBossMinion")
          _id_7B718EF6C64F049F = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 63);
      }
    }
  }

  return [_id_C5B28F88D9B3BFD7, _id_7B718EF6C64F049F];
}

return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim) {
  if(!isDefined(victim.aitype))
    return _id_C5B28F88D9B3BFD7;

  switch (victim.aitype) {
    case "soldier":
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 12);
      break;
    case "juggernaut":
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 8);
      break;
    case "suicidebomber":
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 10);
      break;
    case "riotshield":
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 9);
      break;
    default:
      _id_C5B28F88D9B3BFD7 = _id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 2);
      break;
  }

  return _id_C5B28F88D9B3BFD7;
}

_id_742DECC7F891BB0E(_id_9C46B4C2597D7B03) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 72, location, 121, _id_0FCF7B6E6D8C41C8, 107, _id_9C46B4C2597D7B03];
  _id_7D97A2A745E514C4("374", params);
  self _meth_DB073176839D77FB("374", params);
}

_id_3D871E989C0BDB6D() {
  if(!isDefined(self._id_D405F79D63134727))
    self._id_D405F79D63134727 = 0;

  return self._id_D405F79D63134727;
}

_id_CA0AB723EBCF6D79() {
  if(!isDefined(self._id_D405F79D63134727))
    self._id_D405F79D63134727 = 0;

  self._id_D405F79D63134727 = self._id_D405F79D63134727 + 1;
  _id_F0B126B5B59EAE44 = 0;
  _id_F0B126B5B59EAE44 = _id_6D40F12A09494350(_id_F0B126B5B59EAE44, 0);
  _id_742DECC7F891BB0E(_id_F0B126B5B59EAE44);
}

_id_8935E658D461FC50() {
  if(!isDefined(self._id_D405F79D63134727))
    self._id_D405F79D63134727 = 0;

  if(self._id_D405F79D63134727 > 0) {
    self._id_D405F79D63134727 = self._id_D405F79D63134727 - 1;
    _id_BC2C612DD7D7CF33 = 0;
    _id_BC2C612DD7D7CF33 = _id_6D40F12A09494350(_id_BC2C612DD7D7CF33, 1);
    _id_742DECC7F891BB0E(_id_BC2C612DD7D7CF33);
  }
}

_id_8FEB2DC462CFC7F4(_id_10D8148F3496F8DE, _id_9C46B4C2597D7B03, _id_9C46B5C2597D7D36) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  gametype = _id_17C5D7FEB226E256();
  _id_A74FC57FB4A4D3E6 = _id_AFF35122A61A900B(self.team);
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 72, location, 121, _id_0FCF7B6E6D8C41C8, 140, _id_10D8148F3496F8DE, 141, _id_9C46B4C2597D7B03, 142, _id_9C46B5C2597D7D36];
  self _meth_DB073176839D77FB("531", params);
}

initgameflags(_id_C770D7C80BB5D9AC) {
  self._id_C770D7C80BB5D9AC = _id_C770D7C80BB5D9AC;
}

_id_9293FC45CC7E5634() {
  return isDefined(self._id_C770D7C80BB5D9AC);
}

_id_CFE6DCEDF7278543(_id_DF866E95F432CBD7) {
  if(!isDefined(self._id_C770D7C80BB5D9AC)) {
    self._id_C770D7C80BB5D9AC = 0;
    return 0;
  }

  _id_8295378FD0A88106 = 0;
  _id_8295378FD0A88106 = _id_6D40F12A09494350(_id_8295378FD0A88106, _id_DF866E95F432CBD7);
  _id_F5CEAA932B332407 = (self._id_C770D7C80BB5D9AC &_id_8295378FD0A88106) != 0;
  return _id_F5CEAA932B332407;
}

_id_B7793133DF5FB0DF(_id_DF866E95F432CBD7) {
  if(!isDefined(self._id_C770D7C80BB5D9AC))
    self._id_C770D7C80BB5D9AC = 0;

  _id_8295378FD0A88106 = 0;
  _id_8295378FD0A88106 = _id_6D40F12A09494350(_id_8295378FD0A88106, _id_DF866E95F432CBD7);
  _id_8FEB2DC462CFC7F4(1, _id_8295378FD0A88106);
  self._id_C770D7C80BB5D9AC = self._id_C770D7C80BB5D9AC | _id_8295378FD0A88106;
}

_id_5B58181F4C00BA56(_id_DF866E95F432CBD7) {
  if(!isDefined(self._id_C770D7C80BB5D9AC))
    self._id_C770D7C80BB5D9AC = 0;

  _id_8295378FD0A88106 = 0;
  _id_8295378FD0A88106 = _id_6D40F12A09494350(_id_8295378FD0A88106, _id_DF866E95F432CBD7);
  _id_8FEB2DC462CFC7F4(2, _id_8295378FD0A88106);
  self._id_C770D7C80BB5D9AC = self._id_C770D7C80BB5D9AC &~_id_8295378FD0A88106;
}

_id_38E2BCA264061AA0() {
  gametype = _id_17C5D7FEB226E256();
  _id_8359CADD253F9604(self, "complete_blacksite", 1);
}

_id_45AB928FBC73F76C() {
  gametype = _id_17C5D7FEB226E256();
  _id_8359CADD253F9604(self, "complete_stronghold", 1);
}

_id_6E6D8BFB3754C12D() {
  location = 0;
  _id_0FCF7B6E6D8C41C8 = 0;

  if(isDefined(self._id_DA28916E7827AF7C)) {
    location = getlocation(self._id_DA28916E7827AF7C);
    _id_0FCF7B6E6D8C41C8 = _id_55BE16FB0F5F4A19(self._id_DA28916E7827AF7C);
  }

  _id_8E81148472FB520A(self, "576", [72, location, 121, _id_0FCF7B6E6D8C41C8]);
}

_id_8DA0EE76BC366B83(objweapon, shitloc) {
  _id_742C9CA4175A2518 = _id_6D40F12A09494350(0, 5);
  _id_B2FF82EC901486E4 = getchallengegamemode(self);
  _id_85D8DAEAC55B1742 = getplaylistid();
  _id_0B28608820870666 = _id_CE112254F7CBA89E(objweapon);
  _id_14C5D0F57741804C = int(scripts\engine\math::round_float(distance(self.origin, shitloc) / 39.37, 2));
  _id_349E390338192305 = findgunsmithattachments(objweapon);
  _id_8E81148472FB520A(self, "75", [149, _id_742C9CA4175A2518, 8, _id_B2FF82EC901486E4, 83, _id_85D8DAEAC55B1742, 43, _id_0B28608820870666, 93, _id_14C5D0F57741804C, 33, _id_349E390338192305[0], 35, _id_349E390338192305[1], 36, _id_349E390338192305[2], 37, _id_349E390338192305[3], 38, _id_349E390338192305[4], 39, _id_349E390338192305[5], 40, _id_349E390338192305[6], 41, _id_349E390338192305[7], 42, _id_349E390338192305[8], 34, _id_349E390338192305[9]]);
}

onplayerteamrevive(reviver, _id_22F7E3F7E360775B) {
  _id_B2FF82EC901486E4 = getchallengegamemode(reviver);
  gametype = _id_17C5D7FEB226E256();

  if(reviver challengesenabledforplayer()) {
    _id_160460001CC37359 = 0;
    _id_160460001CC37359 = _id_6D40F12A09494350(_id_160460001CC37359, 0);
    _id_A74FC57FB4A4D3E6 = reviver _id_AFF35122A61A900B(reviver.team);

    if(reviver == _id_22F7E3F7E360775B)
      _id_160460001CC37359 = _id_6D40F12A09494350(_id_160460001CC37359, 1);

    _id_8E81148472FB520A(reviver, "104", [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 115, _id_160460001CC37359]);
  }

  if(reviver != _id_22F7E3F7E360775B && _id_22F7E3F7E360775B challengesenabledforplayer()) {
    _id_160460001CC37359 = 0;
    _id_160460001CC37359 = _id_6D40F12A09494350(_id_160460001CC37359, 1);
    _id_A74FC57FB4A4D3E6 = _id_22F7E3F7E360775B _id_AFF35122A61A900B(_id_22F7E3F7E360775B.team);
    _id_8E81148472FB520A(_id_22F7E3F7E360775B, "104", [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype, 18, _id_A74FC57FB4A4D3E6, 115, _id_160460001CC37359]);
  }
}

onsuccessfulhit(objweapon) {}

onspawn() {
  thread _id_BA687469F675EFCC();
}

_id_BA687469F675EFCC() {
  player = self;
  player notify("watchPlayerUnderwater");
  player endon("watchPlayerUnderwater");
  player endon("death_or_disconnect");
  player endon("game_ended");

  for(;;) {
    if(player _id_4B87F2871B6B025C::_id_1CF18F5E612E68C5())
      player childthread _id_F71341A16372F41C();

    player waittill("scr_change_breath_state");
  }
}

_id_F71341A16372F41C() {
  player = self;
  player endon("scr_change_breath_state");
  wait 35;
  _id_8359CADD253F9604(player, "underwater_challenge_completed", 1);
}

updatesuperweaponkills(objweapon, inflictor) {}

updatesuperkills(_id_EBEC497FF8B18A45, meansofdeath, _id_B34CDA8A56DD46C5) {}

resistedstun(attacker) {}

triggereddelayedexplosion() {}

minedestroyed(mine, attacker, type) {}

roundbegin() {}

roundend(_id_8415802B3CFB809B) {}

playerdamaged(inflictor, attacker, damage, meansofdeath, objweapon, shitloc) {}

processuavassist(owner, uavtype) {}

killstreakdamaged(_id_D8061F26B5ECA018, owner, attacker, weapon, damage) {}

iskillstreakvehicle(_id_D8061F26B5ECA018) {
  switch (_id_D8061F26B5ECA018) {
    case "cruise_predator":
    case "sentry_gun":
    case "manual_turret":
    case "juggernaut":
      return 0;
  }

  return 1;
}

processfinalkillchallenges(attacker, victim) {}

usedkillstreak(streakname) {}

getoperators() {
  _id_B6217B906C6BE73E = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator"))
    _id_B6217B906C6BE73E[0] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team);
  else
    _id_B6217B906C6BE73E[0] = "";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupOtherOperator"))
    _id_B6217B906C6BE73E[1] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupOtherOperator")]](self.team);
  else
    _id_B6217B906C6BE73E[1] = "";

  return _id_B6217B906C6BE73E;
}

_id_73317C391C8E6D10(player, amount) {
  player _id_B7DE4AFAF79FF9B5("damage", amount);
}

_id_CF995E658AB79867(player, points) {
  player _id_B7DE4AFAF79FF9B5("score", points);
}

_id_4FB61D33F02E8203(player, _id_2F977E27FA739602) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype];
  _id_7D97A2A745E514C4("48", params);
  player _meth_DB073176839D77FB("48", params);
}

_id_58E830149FCB9A1E(player, _id_2F977E27FA739602) {
  if(!player challengesenabledforplayer()) {
    return;
  }
  _id_B2FF82EC901486E4 = getchallengegamemode(player);
  gametype = _id_17C5D7FEB226E256();
  params = [32, 1, 8, _id_B2FF82EC901486E4, 9, gametype];
  _id_7D97A2A745E514C4("345", params);
  player _meth_DB073176839D77FB("345", params);
}

_id_8E81148472FB520A(_id_196EF0FA8094FCBA, event, params, _id_AFDA85311C8ED272) {
  _id_7D97A2A745E514C4(event, params);

  if(!isDefined(_id_AFDA85311C8ED272))
    _id_AFDA85311C8ED272 = 1;

  _id_196EF0FA8094FCBA _meth_DB073176839D77FB(event, params);

  if(_id_5C7E8BCDC167FD84() && istrue(_id_AFDA85311C8ED272)) {
    if(isDefined(_id_196EF0FA8094FCBA.team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
      players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](_id_196EF0FA8094FCBA.team, "players");
      params[params.size] = 71;
      params[params.size] = 1;

      foreach(player in players) {
        if(_id_196EF0FA8094FCBA != player) {
          _id_7D97A2A745E514C4(event, params);
          player _meth_DB073176839D77FB(event, params);
        }
      }
    }
  }
}

_id_C1945F26D99B0ED9(player) {
  _id_A8AF9A2935DD804F = [];

  if(isagent(player) || !istrue(level.onlinegame)) {
    for(index = 0; index < 5; index++)
      _id_A8AF9A2935DD804F[index] = 0;

    return _id_A8AF9A2935DD804F;
  }

  _id_607DA387F3617ED1 = player getfireteammembers();

  for(index = 0; index < 5; index++) {
    if(isDefined(_id_A8AF9A2935DD804F) && isDefined(_id_607DA387F3617ED1[index]) && _id_607DA387F3617ED1[index] _meth_7A32B0201993D7F7() != "") {
      _id_A8AF9A2935DD804F[index] = _id_607DA387F3617ED1[index] _meth_7A32B0201993D7F7();
      continue;
    }

    _id_A8AF9A2935DD804F[index] = 0;
  }

  return _id_A8AF9A2935DD804F;
}

_id_607400C13E44E916(vehicle) {
  if(!challengesenabledforplayer()) {
    return;
  }
  level endon("game_ended");
  self endon("disconnect");
  self endon("vehicle_exit");
  vehicle endon("death ");
  self._id_32FF9D9DB61743D3 = 0;
  self._id_18255753932D92AE = vehicle getorigin();
  _id_BEB714E6E2FB20E2 = gettime();

  for(;;) {
    wait 0.5;
    curorigin = vehicle getorigin();
    _id_3777ECE6A73EADA5 = distance(curorigin, self._id_18255753932D92AE);
    self._id_32FF9D9DB61743D3 = self._id_32FF9D9DB61743D3 + _id_3777ECE6A73EADA5;
    self._id_18255753932D92AE = curorigin;
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_0AFAF35803AA52BE = getdvarint("online_challenge_cache_flush_time");

    if(_id_6B7BEE46F2C6DA28 - _id_BEB714E6E2FB20E2 >= _id_0AFAF35803AA52BE && self._id_32FF9D9DB61743D3 > 0) {
      _id_0BBAC93205FB2FF7(self, self._id_32FF9D9DB61743D3);
      self._id_32FF9D9DB61743D3 = 0;
      _id_BEB714E6E2FB20E2 = _id_6B7BEE46F2C6DA28;
    }
  }
}

_id_DDE9993EDD2D9834(vehicle) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_3777ECE6A73EADA5 = 0;

  if(isDefined(vehicle)) {
    curorigin = vehicle getorigin();
    _id_3777ECE6A73EADA5 = distance(curorigin, self._id_18255753932D92AE);
  }

  self._id_32FF9D9DB61743D3 = self._id_32FF9D9DB61743D3 + _id_3777ECE6A73EADA5;

  if(self._id_32FF9D9DB61743D3 > 0) {
    _id_0BBAC93205FB2FF7(self, self._id_32FF9D9DB61743D3);
    self._id_32FF9D9DB61743D3 = 0;
  }
}

_id_0BBAC93205FB2FF7(player, _id_692FCF8A627FF61A) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_B7387D4815BAC7AD = 0.0254;
  _id_37E9606EE83E0537 = int(scripts\engine\math::round_float(_id_B7387D4815BAC7AD * _id_692FCF8A627FF61A, 2));

  if(_id_37E9606EE83E0537 > 0) {
    _id_B2FF82EC901486E4 = getchallengegamemode(player);
    gametype = _id_17C5D7FEB226E256();
    params = [8, _id_B2FF82EC901486E4, 9, gametype, 93, _id_37E9606EE83E0537];
    player _meth_DB073176839D77FB("587", params);
  }
}

_id_9266A0EE3CFB3A75() {
  if(!isDefined(level._id_BA98D05085E326D0))
    level._id_BA98D05085E326D0 = 0;

  level._id_BA98D05085E326D0 = level._id_BA98D05085E326D0 + 1;

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(!player challengesenabledforplayer()) {
      continue;
    }
    if(!scripts\mp\flags::gameflag("br_ready_to_jump")) {
      continue;
    }
    _id_B2FF82EC901486E4 = getchallengegamemode(player);
    gametype = _id_17C5D7FEB226E256();
    params = [8, _id_B2FF82EC901486E4, 9, gametype, 31, level._id_BA98D05085E326D0];
    player _meth_DB073176839D77FB("584", params);
  }
}

_id_FEAA0AC56AD0DEEB() {
  scripts\engine\utility::flag_wait("jump_scares_ready");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_44B8991C2B01716A::_id_CCEA398392B4BF1C("challenges", ::_id_2E41236011E257BB);
}

_id_2E41236011E257BB(ref, player) {
  _id_8359CADD253F9604(player, "jumpscare", 1);
}