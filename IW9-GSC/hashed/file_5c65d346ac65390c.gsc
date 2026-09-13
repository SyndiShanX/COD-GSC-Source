/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5c65d346ac65390c.gsc
***********************************************/

_id_7D47BDED29ED7882(_id_92FEA9C582FD2CAA, heliheight, waittime, _id_FE66ECF180EC2613, _id_1A7E969D835799F2, _id_716E36E221F60B56, _id_ABE738473A42706B, _id_1E9ED21B5D947D43, _id_1869AC124BE0CC0B) {
  if(!isDefined(level._id_251923794D7ECF20))
    level._id_251923794D7ECF20 = spawnStruct();

  level._id_251923794D7ECF20._id_92FEA9C582FD2CAA = _id_92FEA9C582FD2CAA;
  level._id_251923794D7ECF20.heliheight = heliheight;
  level._id_251923794D7ECF20._id_7379EAE6423B305D = waittime;
  level._id_251923794D7ECF20._id_52BACFC5CA39B6D3 = _id_FE66ECF180EC2613;
  level._id_251923794D7ECF20._id_1A7E969D835799F2 = _id_1A7E969D835799F2;
  level._id_251923794D7ECF20._id_716E36E221F60B56 = _id_716E36E221F60B56;
  level._id_251923794D7ECF20._id_ABE738473A42706B = _id_ABE738473A42706B;
  level._id_251923794D7ECF20._id_1E9ED21B5D947D43 = _id_1E9ED21B5D947D43;
  level._id_251923794D7ECF20._id_1869AC124BE0CC0B = _id_1869AC124BE0CC0B;
}

_id_3C673414D075EBFC(_id_1D852E7CCE921D79, func) {
  if(isDefined(level._id_251923794D7ECF20))
    scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_exfil", _id_1D852E7CCE921D79, func);
  else {}
}

_id_0ED11AE9FE1ABDEB(ent, endpos) {
  if(!isDefined(ent))
    return undefined;

  if(!isDefined(level._id_251923794D7ECF20._id_12D84B367009674D))
    level._id_251923794D7ECF20._id_12D84B367009674D = [];

  if(isent(ent) && isDefined(level._id_251923794D7ECF20._id_12D84B367009674D[ent getentitynumber()]))
    return level._id_251923794D7ECF20._id_12D84B367009674D[ent getentitynumber()];

  _id_2F58E7950B321302 = _id_8FB6EFC069BF4EF8(ent, level._id_251923794D7ECF20.heliheight, 1);
  _id_D30D83160ADFA539 = _id_2F58E7950B321302 - ent.origin;
  _id_D30D83160ADFA539 = vectorNormalize((_id_D30D83160ADFA539[0], _id_D30D83160ADFA539[1], 0));
  exitangles = vectortoangles(_id_D30D83160ADFA539 * -1);
  startstruct = spawnStruct();
  startstruct.angles = ent.angles;

  if(isDefined(ent.info._id_B44C269EA13F56AE)) {
    endpos = ent.info._id_B44C269EA13F56AE;
    startstruct.angles = ent.info._id_A55FA332B1255E04;
  }

  startstruct.origin = endpos + (0, 0, level._id_251923794D7ECF20._id_716E36E221F60B56);
  startstruct.radius = 500;
  startstruct.speed = 10;

  if(isent(ent))
    startstruct.targetname = "exfil" + ent getentitynumber();

  startstruct.script_anglevehicle = "1";

  if(istrue(ent.info.land))
    startstruct.script_land = "1";

  _id_9E4E5282CB41521F = _id_38E2D21D6F6E393B(startstruct.origin + _id_D30D83160ADFA539 * 100 + (0, 0, level._id_251923794D7ECF20.heliheight), startstruct, startstruct.targetname, 10, 1, ent.angles);
  _id_9E4E5382CB415452 = _id_38E2D21D6F6E393B(_id_9E4E5282CB41521F.origin + _id_D30D83160ADFA539 * 5000, _id_9E4E5282CB41521F, startstruct.targetname, 20, 2, exitangles);
  _id_9E4E5482CB415685 = _id_38E2D21D6F6E393B(_id_9E4E5282CB41521F.origin + _id_D30D83160ADFA539 * 10000, _id_9E4E5382CB415452, startstruct.targetname, 85, 3, exitangles);

  if(isent(ent))
    level._id_251923794D7ECF20._id_12D84B367009674D[ent getentitynumber()] = _id_9E4E5482CB415685;

  return _id_9E4E5482CB415685;
}

_id_1093B8F392744E3B(ent, endpos, _id_DCEA0339D68FE36A, _id_B092096C70BCC8E4, _id_C4DF87D140C3E8D3) {
  if(istrue(_id_B092096C70BCC8E4)) {
    _id_A011729D000A28D2 = ent.origin - level._id_33A2175A9A4306BC.origin;
    _id_46E71FCD2D40FAD0 = vectortoangles(_id_A011729D000A28D2);
    _id_2F58E7950B321302 = _id_8FB6EFC069BF4EF8(ent, _id_DCEA0339D68FE36A, 0, _id_46E71FCD2D40FAD0[1]);
  } else
    _id_2F58E7950B321302 = _id_8FB6EFC069BF4EF8(ent, _id_DCEA0339D68FE36A, 0);

  _id_D30D83160ADFA539 = _id_2F58E7950B321302 - endpos;
  _id_D30D83160ADFA539 = vectorNormalize((_id_D30D83160ADFA539[0], _id_D30D83160ADFA539[1], 0));
  exitangles = vectortoangles(_id_D30D83160ADFA539);
  startstruct = spawnStruct();
  startstruct.origin = _id_2F58E7950B321302;
  startstruct.angles = ent.angles;
  startstruct.radius = 500;
  startstruct.speed = 80;

  if(isent(ent))
    startstruct.targetname = "exfilExit" + ent getentitynumber();

  _id_B9FC106959C06C4F = endpos + (0, 0, 900);
  _id_9F481255F2C41D46 = _id_B9FC106959C06C4F + (0, 0, _id_DCEA0339D68FE36A);
  startangles = scripts\engine\utility::_id_53C4C53197386572(_id_C4DF87D140C3E8D3, ent.angles);
  _id_9E4E5182CB414FEC = _id_38E2D21D6F6E393B(_id_9F481255F2C41D46 + _id_D30D83160ADFA539 * 9000 + (0, 0, 9000), startstruct, startstruct.targetname, 40, 1, exitangles);
  _id_9E4E5282CB41521F = _id_38E2D21D6F6E393B(_id_9F481255F2C41D46 + _id_D30D83160ADFA539 * 5000, _id_9E4E5182CB414FEC, startstruct.targetname, 20, 2, exitangles);
  _id_9E4E5382CB415452 = _id_38E2D21D6F6E393B(_id_9F481255F2C41D46, _id_9E4E5282CB41521F, startstruct.targetname, 40, 3, exitangles);
  _id_9E4E5482CB415685 = _id_38E2D21D6F6E393B(_id_9F481255F2C41D46 - (0, 0, 300), _id_9E4E5382CB415452, startstruct.targetname, 10, 4, startangles);
  _id_9E4E4D82CB414720 = _id_38E2D21D6F6E393B(_id_B9FC106959C06C4F, _id_9E4E5482CB415685, startstruct.targetname, 10, 5, startangles);
  return _id_9E4E4D82CB414720;
}

_id_8FB6EFC069BF4EF8(startnode, heliheight, reverse, _id_B092096C70BCC8E4) {
  if(!isDefined(reverse))
    reverse = 0;

  _id_3FB4A86293ED25A6 = 10;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  startpos = startnode.origin + (0, 0, heliheight + 600);
  yaw = scripts\engine\utility::ter_op(isDefined(_id_B092096C70BCC8E4), _id_B092096C70BCC8E4, startnode.angles[1]);
  _id_3674D96C61E2DD0D = scripts\engine\utility::ter_op(reverse, yaw + 180, yaw);
  ignoreents = undefined;

  if(isDefined(level.vehicle) && isDefined(level.vehicle.instances))
    ignoreents = level.vehicle.instances["little_bird"];

  for(yaw = 0; yaw < 360; yaw = yaw + _id_3FB4A86293ED25A6) {
    _id_3674D96C61E2DD0D = _id_3674D96C61E2DD0D + yaw;
    _id_211FC11F4C8566F5 = (0, _id_3674D96C61E2DD0D, 0);
    _id_29006F80487A7787 = startpos;
    _id_DD77D0A6D708AC18 = startpos + anglesToForward(_id_211FC11F4C8566F5) * 18000;
    _id_D4EB961F60968A16 = scripts\engine\trace::sphere_trace(_id_29006F80487A7787, _id_DD77D0A6D708AC18, 100, ignoreents, contents, 1);

    if(_id_D4EB961F60968A16["fraction"] == 1)
      return _id_DD77D0A6D708AC18;

    if(yaw % 3 == 0)
      waitframe();
  }

  return undefined;
}

_id_38E2D21D6F6E393B(pos, _id_C013CFD919A1A62D, _id_A95CF9509CE0D814, speed, num, _id_B092096C70BCC8E4) {
  struct = spawnStruct();
  struct.speed = speed;
  struct.origin = pos;
  struct.angles = scripts\engine\utility::ter_op(isDefined(_id_B092096C70BCC8E4), _id_B092096C70BCC8E4, _id_C013CFD919A1A62D.angles);
  struct.radius = 500;
  struct.target = _id_C013CFD919A1A62D;
  struct.script_anglevehicle = "1";
  return struct;
}

_id_D05F47D864F18196(owner, pos, angles, _id_4FFFC035C8679B98, _id_7E6513B2AE0D5C1D) {
  if(!isDefined(_id_4FFFC035C8679B98))
    _id_4FFFC035C8679B98 = 1;

  if(!isDefined(_id_7E6513B2AE0D5C1D))
    _id_7E6513B2AE0D5C1D = 0;

  spawndata = spawnStruct();
  spawndata.origin = pos;
  spawndata.angles = angles;
  spawndata.spawntype = "GAME_MODE";

  if(!_id_4FFFC035C8679B98)
    spawndata._id_14CDE247AC3313A4 = "dmzwhite";

  if(istrue(level._id_291B51C7AF8D1204)) {
    spawndata.team = "axis";
    spawndata._id_35FD13041DDE93E8 = "v013";
  }

  heli = undefined;

  while(!isDefined(heli)) {
    heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);

    if(!isDefined(heli))
      wait 1.0;
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
  heli._id_135A33623C519457 = 1;
  heli.health = scripts\engine\utility::ter_op(isDefined(level._id_251923794D7ECF20._id_1E9ED21B5D947D43), level._id_251923794D7ECF20._id_1E9ED21B5D947D43, 1000);
  heli.maxhealth = heli.health;
  heli._id_0902A7FFCFF8AA65 = [];
  heli._id_75ADB7F3CBE5D522 = level._id_251923794D7ECF20._id_7379EAE6423B305D + level._id_251923794D7ECF20._id_52BACFC5CA39B6D3;

  if(istrue(_id_4FFFC035C8679B98))
    heli._id_1E897AE1C018B2C2 = owner.team;

  heli._id_878914B0358BC7B5 = [];
  heli._id_675F44ED226AED7D = ::_id_1E04F8A9053512A4;
  heli._id_7B468990DA46C73C = ::_id_6519494290B58824;
  heli._id_C547488F80D3EB28 = 1;
  heli.unload_land_offset = 255;
  heli.script_disconnectpaths = 1;
  heli._id_746334C2AC85AACC = 10000;
  heli.handleeventcallback = ::_id_AD65EA51CE655F42;
  heli._id_A2BA7043631B3392 = 1;
  heli _id_264031B20E04A07C();
  heli _meth_247AD6A91F6A4FFE(1);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "setup_gas_masks", heli);
  heli scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onSpawnExfilHeli", _id_7E6513B2AE0D5C1D);
  return heli;
}

_id_264031B20E04A07C() {
  _id_2A94A31F5C16A229 = ["body_sp_ally_pilot_western_vm_fullbody", "body_sp_ally_pilot_western_vm_fullbody"];
  _id_30F2BDD1710C71FB = ["iw9_mp_heli_palfa_seat_0_idle", "iw9_heli_palfa_seat_1_idle"];
  _id_A6FE8CE5D2C31D36 = ["tag_seat_0", "tag_seat_1"];
  _id_C2A106D998C9F3BE = 2;
  self._id_B23E608EF55DB7FA = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C2A106D998C9F3BE; _id_AC0E594AC96AA3A8++) {
    _id_514D9E806D48B808 = _id_8C5DD82B28A2C584(_id_AC0E594AC96AA3A8, _id_A6FE8CE5D2C31D36[_id_AC0E594AC96AA3A8], _id_30F2BDD1710C71FB[_id_AC0E594AC96AA3A8], _id_2A94A31F5C16A229[_id_AC0E594AC96AA3A8], undefined);
    self._id_B23E608EF55DB7FA[self._id_B23E608EF55DB7FA.size] = _id_514D9E806D48B808;
  }
}

_id_8C5DD82B28A2C584(_id_DCEF536353EA980B, tag, animname, model, headmodel) {
  _id_2626560098D08682 = self gettagorigin(tag);
  _id_B7850001037AA074 = self gettagangles(tag);
  spawned = spawn("script_model", _id_2626560098D08682);
  spawned.angles = _id_B7850001037AA074;
  spawned setModel(model);
  _id_2626560098D08682 = spawned gettagorigin("j_spine4");
  _id_B7850001037AA074 = spawned gettagangles("j_spine4");
  spawned.linkedents = [];

  if(isDefined(headmodel)) {
    head = spawn("script_model", _id_2626560098D08682);
    head.angles = _id_B7850001037AA074;
    head setModel(headmodel);
    head linkTo(spawned, "j_spine4");
    spawned.linkedents[spawned.linkedents.size] = head;
    spawned.head = head;
  }

  spawned linkTo(self);

  if(isDefined(animname))
    spawned scriptmodelplayanim(animname);

  return spawned;
}

_id_423F49E2512A5F53() {
  if(istrue(self._id_A09B2CB47A28054A))
    self._id_A09B2CB47A28054A = undefined;
}

_id_1E04F8A9053512A4(player) {
  player._id_8A38603863A78B8E = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("haunting", "shouldDropArtifact"))
    player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("haunting", "shouldDropArtifact")]]();

  if(!scripts\engine\utility::array_contains_key(self._id_878914B0358BC7B5, player.guid)) {
    self._id_878914B0358BC7B5[player.guid] = player;
    scripts\mp\outofbounds::enableoobimmunity(player);

    if(!istrue(self._id_7C9D9334F407B6DF) || self._id_75ADB7F3CBE5D522 < 1) {
      return;
    }
    if(!isDefined(player._id_A09B2CB47A28054A)) {
      self._id_0902A7FFCFF8AA65[self._id_0902A7FFCFF8AA65.size] = player;
      player._id_A09B2CB47A28054A = 1;
      _id_48F1DBF87DD99400 = self._id_75ADB7F3CBE5D522 + level._id_251923794D7ECF20._id_52BACFC5CA39B6D3;

      if(isDefined(self._id_6881781E87586753) && isDefined(level._id_251923794D7ECF20._id_52BACFC5CA39B6D3) && self._id_6881781E87586753 < level._id_251923794D7ECF20._id_52BACFC5CA39B6D3)
        _id_48F1DBF87DD99400 = self._id_6881781E87586753;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_exfil", "player_exfil_timer"))
        player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_exfil", "player_exfil_timer")]](self.origin, _id_48F1DBF87DD99400, 2000);
    }

    _id_189B67B2735B981D::_id_55B08D6D71B41402(player, "enter_exfil_heli");
  }

  _id_3995EC6A46BD14DF = 0;

  if(isDefined(self._id_1E897AE1C018B2C2) && player.team == self._id_1E897AE1C018B2C2) {
    if(isDefined(self._id_6881781E87586753) && isDefined(level._id_251923794D7ECF20._id_52BACFC5CA39B6D3) && self._id_6881781E87586753 < level._id_251923794D7ECF20._id_52BACFC5CA39B6D3) {
      return;
    }
    players = scripts\mp\utility\teams::getteamdata(self._id_1E897AE1C018B2C2, "players");

    foreach(_id_B2810E8D06E0A042 in players) {
      if(scripts\mp\utility\player::isreallyalive(_id_B2810E8D06E0A042) && !isDefined(self._id_878914B0358BC7B5[_id_B2810E8D06E0A042.guid]) && !istrue(_id_B2810E8D06E0A042.extracted))
        return;
    }

    foreach(player in self._id_0902A7FFCFF8AA65) {
      if(istrue(player._id_A09B2CB47A28054A)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_exfil", "player_exfil_timer"))
          player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_exfil", "player_exfil_timer")]](self.origin, level._id_251923794D7ECF20._id_52BACFC5CA39B6D3, 2000);
      }
    }
  } else
    return;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_exfil", "dialog_shortcut"))
    player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_exfil", "dialog_shortcut")]]();

  self notify("chopper_exfil_team_ready");
}

_id_6519494290B58824(player) {
  self._id_878914B0358BC7B5[player.guid] = undefined;
  player notify("exited_chopper");
  player._id_8A38603863A78B8E = undefined;

  if(isDefined(player) && isint(player.oobimmunity) && !istrue(player.extracted))
    scripts\mp\outofbounds::disableoobimmunity(player);
}

_id_A5FC6E8F9DF1CCEA(heli, endpoint, ent) {
  heli endon("death");

  if(isDefined(ent))
    ent endon("disable");

  while(distance(heli.origin, endpoint) > 2500)
    wait 0.1;

  if(!istrue(level._id_291B51C7AF8D1204))
    heli setscriptablepartstate("dmz_exfil_dust_sounds", "landing");

  while(distance(heli.origin, endpoint) > 1500)
    wait 0.1;

  if(isDefined(ent))
    ent setscriptablepartstate("dmz_exfil_smoke", "dissipate");

  heli _meth_247AD6A91F6A4FFE(0);

  while(distance(heli.origin, endpoint) > 800)
    wait 0.1;

  heli setscriptablepartstate("dmz_exfil_turbine_sounds", "landing");

  while(distance(heli.origin, endpoint) < 1500)
    wait 0.1;

  heli _meth_247AD6A91F6A4FFE(1);
}

_id_72D275D574BD23DD(heli, endpoint) {
  heli endon("death");

  while(distance2d(heli.origin, endpoint) > 500)
    wait 0.1;

  if(isDefined(self))
    scripts\cp_mp\calloutmarkerping::_id_FFD6EED18C767472(self, heli, 6, 21, (0, 0, 72));
}

_id_55D37B18154A058E(waittime) {
  self endon("chopper_exfil_team_ready");
  self._id_7C9D9334F407B6DF = 1;
  _id_940A3890AC273220 = int(waittime);
  players = level.players;

  if(isDefined(self._id_1E897AE1C018B2C2))
    players = scripts\mp\utility\teams::getteamdata(self._id_1E897AE1C018B2C2, "players");

  if(self._id_878914B0358BC7B5.size > 0)
    players = scripts\engine\utility::array_combine(players, self._id_878914B0358BC7B5);

  foreach(_id_80EF668C09FFB70F in players) {
    if(!isDefined(_id_80EF668C09FFB70F._id_A09B2CB47A28054A) && scripts\mp\utility\player::isreallyalive(_id_80EF668C09FFB70F)) {
      self._id_0902A7FFCFF8AA65[self._id_0902A7FFCFF8AA65.size] = _id_80EF668C09FFB70F;
      _id_80EF668C09FFB70F._id_A09B2CB47A28054A = 1;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_exfil", "player_exfil_timer"))
        _id_80EF668C09FFB70F thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_exfil", "player_exfil_timer")]](self.origin, _id_940A3890AC273220 + level._id_251923794D7ECF20._id_52BACFC5CA39B6D3, undefined);
    }
  }

  self._id_75ADB7F3CBE5D522 = _id_940A3890AC273220;
  self._id_6881781E87586753 = level._id_251923794D7ECF20._id_52BACFC5CA39B6D3;

  while(self._id_75ADB7F3CBE5D522 > 0) {
    self._id_75ADB7F3CBE5D522--;

    if(!isDefined(self._id_1E897AE1C018B2C2) && self._id_75ADB7F3CBE5D522 == 60 - level._id_251923794D7ECF20._id_52BACFC5CA39B6D3) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_exfil", "dialog_final_warning"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_exfil", "dialog_final_warning")]](players);
    }

    wait 1;
  }
}

_id_18D68B06FA34264B(heli) {
  if(!istrue(level._id_291B51C7AF8D1204))
    heli setscriptablepartstate("dmz_exfil_dust_sounds", "landing");

  if(!isDefined(heli._id_6881781E87586753))
    heli._id_6881781E87586753 = level._id_251923794D7ECF20._id_52BACFC5CA39B6D3;

  heli _id_02B68FD672B6B021();
  heli _id_C05648D95863318A();

  if(!istrue(level._id_291B51C7AF8D1204))
    heli setscriptablepartstate("dmz_exfil_dust_sounds", "liftoff");
}

_id_02B68FD672B6B021() {
  wait(self._id_6881781E87586753 * 0.75);
  self setscriptablepartstate("dmz_exfil_turbine_sounds", "liftoff");
}

_id_C05648D95863318A() {
  while(self._id_6881781E87586753 > 0) {
    self._id_6881781E87586753--;
    wait 1;
  }
}

_id_0ED686FCBC5363B3() {
  if(isDefined(self._id_B23E608EF55DB7FA)) {
    foreach(pilot in self._id_B23E608EF55DB7FA) {
      foreach(ent in pilot.linkedents)
      ent delete();

      pilot delete();
    }
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_death(self);
}

_id_D1478474B036B87F(ent, part, state, player, waittime, _id_4FFFC035C8679B98, _id_27144879B0C7BEED) {
  if(!isDefined(_id_4FFFC035C8679B98))
    _id_4FFFC035C8679B98 = 1;

  if(!isDefined(ent) || istrue(ent.disabled)) {
    return;
  }
  if(isDefined(ent.heli)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_exfil", "airspace_too_crowded")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_exfil", "airspace_too_crowded")]](player);
      return;
    }
  }

  _id_BEDB769CC0E5E018 = 0;
  _id_01230EA36A300368 = getgroundposition(ent.origin, 1) + (0, 0, 2);
  ent.inuse = 1;
  players = level.players;
  team = undefined;

  if(!istrue(_id_27144879B0C7BEED)) {
    team = player.team;
    players = scripts\mp\utility\teams::getteamdata(player.team, "players");
    exfilstruct = _id_730C660D9FC6808E(players, _id_27144879B0C7BEED, 0, istrue(ent.info._id_02312C613DAC6449), 0);
    ent scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onSignalExfil", player, exfilstruct);
  }

  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("match_exfil_inbound", players);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "initial_splash", players, ent.info._id_B205D90302DA2F07, istrue(_id_27144879B0C7BEED));
  _id_64ACB6CE534155B7::utilflare_shootflare(ent.origin, "dmz_exfil");
  wait 3.75;
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "music_start", players, _id_27144879B0C7BEED);
  wait 1.25;
  _id_2C728460E4C9349D = level._id_251923794D7ECF20._id_92FEA9C582FD2CAA;

  if(isDefined(player) && !istrue(_id_27144879B0C7BEED)) {
    _id_5332CDA4054641DA = scripts\engine\utility::_id_53C4C53197386572(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("instanceInventory", "getUpgradeCount", player, 27), 0);
    _id_2C728460E4C9349D = _id_2C728460E4C9349D - _id_5332CDA4054641DA * getdvarfloat("dvar_32085370522FBF3F", 30);
    _id_2C728460E4C9349D = max(0, _id_2C728460E4C9349D);
  }

  if(!isDefined(_id_2C728460E4C9349D))
    _id_2C728460E4C9349D = 60;

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && isDefined(level._id_06FC3398B5A13400) && istrue(_id_27144879B0C7BEED)) {
    remainingtime = (level._id_06FC3398B5A13400 - gettime()) / 1000;

    if(remainingtime > _id_2C728460E4C9349D * 2) {
      thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "dialog_start_exfil", players, team, _id_27144879B0C7BEED, ent, _id_2C728460E4C9349D);
      wait(_id_2C728460E4C9349D);
    }
  } else {
    thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "dialog_start_exfil", players, team, _id_27144879B0C7BEED, ent, _id_2C728460E4C9349D);
    wait(_id_2C728460E4C9349D);
  }

  path = _id_0ED11AE9FE1ABDEB(ent, _id_01230EA36A300368);

  if(!isDefined(path)) {
    return;
  }
  _id_A3010F9814A40C8D = player;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size && !isDefined(_id_A3010F9814A40C8D); _id_AC0E594AC96AA3A8++)
    _id_A3010F9814A40C8D = players[_id_AC0E594AC96AA3A8];

  if(!isDefined(_id_A3010F9814A40C8D)) {
    return;
  }
  heli = _id_D05F47D864F18196(_id_A3010F9814A40C8D, path.origin, ent.angles, _id_4FFFC035C8679B98, _id_27144879B0C7BEED);
  heli._id_27144879B0C7BEED = _id_27144879B0C7BEED;
  thread _id_A5FC6E8F9DF1CCEA(heli, _id_01230EA36A300368, ent);
  ent thread _id_72D275D574BD23DD(heli, _id_01230EA36A300368);
  heli scripts\common\vehicle_paths::vehicle_paths_helicopter(path);

  if(!istrue(ent.info.land))
    heli sethoverparams(2, 1, 1);

  thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "dialog_handle_touchdown", players, heli);

  if(!istrue(_id_4FFFC035C8679B98) && isDefined(level._id_251923794D7ECF20._id_1A7E969D835799F2))
    waittime = (level._id_251923794D7ECF20._id_1A7E969D835799F2 - gettime()) / 1000 - level._id_251923794D7ECF20._id_6881781E87586753 - level._id_251923794D7ECF20._id_ABE738473A42706B;

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && isDefined(level._id_06FC3398B5A13400) && istrue(_id_27144879B0C7BEED)) {
    remainingtime = (level._id_06FC3398B5A13400 - gettime()) / 1000;
    waittime = remainingtime - level._id_251923794D7ECF20._id_52BACFC5CA39B6D3 - 1;
    _id_EEA954761967701F = _func_C5CF558181E12D1F(remainingtime % 1, level.framedurationseconds);

    if(_id_EEA954761967701F >= level.framedurationseconds) {
      waittime = waittime - _id_EEA954761967701F;
      wait(_id_EEA954761967701F);
    }
  }

  heli _id_55D37B18154A058E(scripts\engine\utility::ter_op(isDefined(waittime), waittime, level._id_251923794D7ECF20._id_7379EAE6423B305D));
  _id_18D68B06FA34264B(heli);
  thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "music_stop", heli._id_878914B0358BC7B5, _id_27144879B0C7BEED);
  thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "dialog_final_leaving", players, _id_27144879B0C7BEED);

  foreach(player in heli._id_878914B0358BC7B5) {
    if(isDefined(player))
      player _id_2CEDCC356F1B9FC8::_id_9552337123064304(1);
  }

  heli._id_94CF3A68B99AE841 = 1;
  heli notify("exfil_path_started");

  if(istrue(level._id_251923794D7ECF20._id_1869AC124BE0CC0B))
    heli _id_2BC0B0102F9B7751::_id_FC805EC1E7B08264(heli.currentnode);
  else {
    path = _id_1093B8F392744E3B(ent, _id_01230EA36A300368, level._id_251923794D7ECF20.heliheight, !istrue(_id_4FFFC035C8679B98));
    heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
    wait 10;
  }

  scripts\cp_mp\calloutmarkerping::_id_C068EFDF0ABD5258(ent);
  wait 1.5;
  thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "music_exfil_end", heli._id_878914B0358BC7B5);
  wait 6.5;
  heli._id_9AB1B62A59F15DE7 = [];

  foreach(player in heli._id_878914B0358BC7B5) {
    if(!isDefined(player)) {
      continue;
    }
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      player _id_2CEDCC356F1B9FC8::_id_C2AFA687BC871D71(1);

    heli._id_9AB1B62A59F15DE7[heli._id_9AB1B62A59F15DE7.size] = player;
    _id_BEDB769CC0E5E018 = 1;
  }

  info = _id_730C660D9FC6808E(heli._id_9AB1B62A59F15DE7, _id_27144879B0C7BEED, 0, istrue(ent.info._id_02312C613DAC6449), 0);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "exfil_players", heli._id_9AB1B62A59F15DE7, info);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "music_reset", players);
  wait 15;
  heli _id_0ED686FCBC5363B3();
  ent thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "remove_exfil", ent, _id_BEDB769CC0E5E018);

  if(isDefined(ent) && !istrue(ent.disabled) && isDefined(team)) {
    ent.inuse = 0;
    ent thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "reset_exfil", team);
  }
}

_id_730C660D9FC6808E(players, _id_27144879B0C7BEED, _id_6086028A8DFDE29E, _id_5FDA164731E59C13, _id_21584999AB948530) {
  info = spawnStruct();
  info.players = players;
  info._id_27144879B0C7BEED = _id_27144879B0C7BEED;
  info._id_6086028A8DFDE29E = _id_6086028A8DFDE29E;
  info._id_5FDA164731E59C13 = _id_5FDA164731E59C13;
  info._id_21584999AB948530 = _id_21584999AB948530;
  return info;
}

entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

_id_AD65EA51CE655F42(vehicle) {
  if(self vehicle_getspeed() == 0) {
    return;
  }
  if(istrue(vehicle._id_496A5E00D32AF675)) {
    return;
  }
  vehicle._id_496A5E00D32AF675 = 1;
  vehicle._id_A8F4BB03B366AA80 = 1;
  vehicle thread scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
}