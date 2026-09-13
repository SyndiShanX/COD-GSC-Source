/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_supply_drops_common.gsc
***********************************************************/

init() {
  level notify("br_supply_drops_init");
  level._id_5D2AF95280A3CF58 = getdvarint("dvar_B2F1A70335C6A20B", 16000);
  level._id_0F13B219A6CB9496 = ["onFirstDrop", "generateFlightPath", "supplyDropFall", "planeDropRun", "spawnDropCrate", "onDropSpawned", "onPlayerEnterGulag", "onPlayerRespawn"];
  cratedata = scripts\cp_mp\killstreaks\airdrop::getleveldata("br_supply_drops_common");
  cratedata.hasnointeraction = 1;
}

_id_69B2E5235BFB7998(name, cratemodel, _id_B55272982C57A2CE, _id_5CC8AC2ED7A3D9FA) {
  if(!isDefined(level._id_EF63E063E320ACFC))
    level._id_EF63E063E320ACFC = [];

  level._id_EF63E063E320ACFC[name] = spawnStruct();
  level._id_EF63E063E320ACFC[name].cratemodel = cratemodel;
  level._id_EF63E063E320ACFC[name].funcs = [];
  level._id_EF63E063E320ACFC[name].planemodel = "veh9_mil_air_cargo_plane_wm";
  level._id_EF63E063E320ACFC[name]._id_F01F4AB1D5D21F9C = getdvarint("dvar_C5003AF4E1EC5349", 0.3);
  level._id_EF63E063E320ACFC[name]._id_62BA925DF2F38D68 = getdvarint("dvar_B35F53A26ED16372", 5);
  level._id_EF63E063E320ACFC[name]._id_2E0D8BA0A46CE1B1 = getdvarint("dvar_9604835948DA8A54", 3);
  level._id_EF63E063E320ACFC[name].userate = getdvarint("dvar_B995FD166E3EC5B0", 1);
  level._id_EF63E063E320ACFC[name].usetime = getdvarint("dvar_B663C9A86F4CA8E3", 4);
  level._id_EF63E063E320ACFC[name].name = name;

  if(!istrue(_id_B55272982C57A2CE)) {
    level._id_EF63E063E320ACFC[name].funcs["generateFlightPath"] = ::_id_4A7C28606A956F8D;
    level._id_EF63E063E320ACFC[name].funcs["supplyDropFall"] = ::_id_7DEC3B199D2E73B8;
    level._id_EF63E063E320ACFC[name].funcs["planeDropRun"] = ::_id_8862805D448B58D4;
    level._id_EF63E063E320ACFC[name].funcs["spawnDropCrate"] = ::_id_52F17E5FBEC318A6;
    level._id_EF63E063E320ACFC[name].funcs["onOpenFunc"] = _id_5CC8AC2ED7A3D9FA;
  }

  return level._id_EF63E063E320ACFC[name];
}

_id_80E49E34FC8D70B8(name, _id_EA847593E957F2B0, func) {
  level._id_EF63E063E320ACFC[name].funcs[_id_EA847593E957F2B0] = func;
}

_id_4B941A30DB41D07E(_id_69E96A4CAA72D794, opener) {
  if(isDefined(_id_69E96A4CAA72D794.entity.smokesignal) && scripts\mp\loot::_id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener))
    _id_69E96A4CAA72D794.entity.smokesignal setscriptablepartstate("smoke_signal", "off", 1);
}

_id_5691429FC16CDDC2() {
  for(;;) {
    wait 2;

    if(getDvar("dvar_26EFC86D59CBD50E", "") != "") {
      _id_1241AFBFB2CFED35(level.players[0].origin, getDvar("dvar_26EFC86D59CBD50E", ""));
      setDvar("dvar_26EFC86D59CBD50E", "");
    }

    if(getDvar("dvar_C3236A6C15B391D3", "") != "") {
      _id_1A01863A6EC2AD05(level.players[0].origin, getDvar("dvar_C3236A6C15B391D3", ""));
      setDvar("dvar_C3236A6C15B391D3", "");
    }

    if(getDvar("dvar_67245232E538D11D", "") != "") {
      droptype = getDvar("dvar_67245232E538D11D", "");
      dropstruct = level._id_EF63E063E320ACFC[droptype];

      if(isDefined(dropstruct)) {
        _id_8EE83E2CBD3D747D = level.players[0].origin;
        _id_D4858C7C75F6AB04 = (_id_8EE83E2CBD3D747D[0], _id_8EE83E2CBD3D747D[1], 500);
        crate = [[dropstruct.funcs["spawnDropCrate"]]](_id_8EE83E2CBD3D747D, dropstruct);
      }

      setDvar("dvar_67245232E538D11D", "");
    }
  }
}

_id_1422FFCD34611FD1() {
  return 3044;
}

_id_1A01863A6EC2AD05(pos, droptype) {
  _id_A82277E7547CF269 = level._id_EF63E063E320ACFC[droptype];
  planemodel = _id_A82277E7547CF269.planemodel;
  pathstruct = [[_id_A82277E7547CF269.funcs["generateFlightPath"]]](pos, _id_A82277E7547CF269);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_1422FFCD34611FD1();
  time = dist / travelspeed;
  plane = _id_2496CDD7BABAED39(pathstruct, dist, travelspeed, time, planemodel);
  plane setscriptablepartstate("audio_loop", "on", 0);
  plane setscriptablepartstate("objective", "active_yellow", 0);
  plane moveTo(plane.endpt, plane.lifetime);
  plane thread[[_id_A82277E7547CF269.funcs["planeDropRun"]]](_id_A82277E7547CF269);
  plane thread _id_6CC331348E2FAA9A();
}

_id_1241AFBFB2CFED35(pos, droptype) {
  dropstruct = level._id_EF63E063E320ACFC[droptype];
  crate = _id_98E40BECF6AAE51F(pos, dropstruct);
  level._id_C9516B6C38FA7BC8 = crate;
  return crate;
}

_id_8862805D448B58D4(dropstruct) {
  self endon("death");
  _id_BD693DCF6BECE704 = self.lifetime;
  _id_11F20C6978F7D6A6 = _id_BD693DCF6BECE704 * dropstruct._id_F01F4AB1D5D21F9C;
  numcrates = 0;
  wait(_id_11F20C6978F7D6A6);

  while(numcrates < dropstruct._id_2E0D8BA0A46CE1B1) {
    if(dropstruct._id_62BA925DF2F38D68 < _id_BD693DCF6BECE704 - _id_11F20C6978F7D6A6)
      wait(dropstruct._id_62BA925DF2F38D68);
    else
      waitframe();

    _id_76A22C18960F72AF = _id_95A507DC67864770(self.origin + anglesToForward(self.angles) * 500);

    if(!isDefined(_id_76A22C18960F72AF)) {
      if(istrue(dropstruct._id_5214BB02998FF284))
        numcrates++;

      continue;
    }

    crate = _id_98E40BECF6AAE51F(_id_76A22C18960F72AF, dropstruct);

    if(!isDefined(crate)) {
      continue;
    }
    if(numcrates == 0 && isDefined(dropstruct.funcs["onFirstDrop"]))
      [[dropstruct.funcs["onFirstDrop"]]]();

    numcrates++;
  }
}

_id_C28362A9638E7931(dropstruct) {
  level endon("game_ended");
  self endon("death");
  _id_BD693DCF6BECE704 = self.lifetime;
  _id_11F20C6978F7D6A6 = _id_BD693DCF6BECE704 * dropstruct._id_F01F4AB1D5D21F9C;
  _id_00D4DAE76EAC378B = (self.centerpt[0], self.centerpt[1], level._id_5D2AF95280A3CF58);
  _id_F8AAE4B48DFCCACE = _id_95A507DC67864770(_id_00D4DAE76EAC378B);
  _id_6060A1273859D593 = (_id_F8AAE4B48DFCCACE[0], _id_F8AAE4B48DFCCACE[1], level._id_5D2AF95280A3CF58);
  _id_CFF400C8A67610F7 = distance(self.origin, _id_6060A1273859D593);

  for(;;) {
    _id_B0732CE0DDE34A1F = distance(self.origin, self.startpt);

    if(_id_B0732CE0DDE34A1F >= _id_CFF400C8A67610F7) {
      break;
    }

    waitframe();
  }

  crate = _id_98E40BECF6AAE51F(_id_F8AAE4B48DFCCACE, dropstruct);

  if(isDefined(dropstruct.funcs["onFirstDrop"]))
    [[dropstruct.funcs["onFirstDrop"]]]();
}

_id_95A507DC67864770(_id_22C4300CE1D248E8, _id_5CE47DE2B275EEC8) {
  _id_76A22C18960F72AF = undefined;
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 - (0, 0, 30000);
  ignorelist = [self];
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignorelist, contents);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    pos = trace["position"];
    _id_76A22C18960F72AF = getclosestpointonnavmesh(pos);
    _id_8391900D9D61FE30 = _id_76A22C18960F72AF - pos;
    _id_8391900D9D61FE30 = (_id_8391900D9D61FE30[0], _id_8391900D9D61FE30[1], 0);
    _id_84D0C5C148DA4A7A = 100;

    if(length2dsquared(_id_8391900D9D61FE30) > _id_84D0C5C148DA4A7A * _id_84D0C5C148DA4A7A)
      _id_8391900D9D61FE30 = _id_8391900D9D61FE30 + vectorNormalize(_id_8391900D9D61FE30) * getdvarint("dvar_ADA223FD974A9D0B", _id_84D0C5C148DA4A7A);

    _id_76A22C18960F72AF = getclosestpointonnavmesh(scripts\engine\utility::drop_to_ground(_id_76A22C18960F72AF + _id_8391900D9D61FE30, 10500));
  }

  if(isDefined(_id_76A22C18960F72AF) && !istrue(_id_5CE47DE2B275EEC8)) {
    _id_5F1F32386B2BA829 = _id_2695A20D4011076D::isvalidpointinbounds(_id_76A22C18960F72AF, 1);

    if(!istrue(_id_5F1F32386B2BA829))
      _id_76A22C18960F72AF = undefined;
  }

  return _id_76A22C18960F72AF;
}

_id_4A7C28606A956F8D(_id_FC60036BA7BF253A, dropstruct) {
  r = level.br_level.br_circleradii[0];
  _id_821B13082F214589 = scripts\engine\utility::_id_53C4C53197386572(dropstruct._id_821B13082F214589, randomfloatrange(0, 360));
  _id_6300D0F047679B46 = scripts\engine\utility::_id_53C4C53197386572(dropstruct._id_6300D0F047679B46, level._id_5D2AF95280A3CF58);
  _id_639828DC8BAC6376 = _id_6300D0F047679B46;

  if(isDefined(dropstruct.zoffset))
    _id_639828DC8BAC6376 = _id_639828DC8BAC6376 + dropstruct.zoffset;

  _id_7D0D99F1231F6085 = (r * cos(_id_821B13082F214589), r * sin(_id_821B13082F214589), _id_639828DC8BAC6376);
  startpt = _id_7D0D99F1231F6085 + _id_FC60036BA7BF253A;
  startpt = (startpt[0], startpt[1], _id_639828DC8BAC6376);
  endpt = _id_FC60036BA7BF253A - _id_7D0D99F1231F6085;
  endpt = (endpt[0], endpt[1], _id_639828DC8BAC6376);
  pathdir = vectorNormalize(endpt - startpt);
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.angle = vectortoangles(pathdir);
  pathstruct.centerpt = _id_FC60036BA7BF253A;
  return pathstruct;
}

_id_6CC331348E2FAA9A() {
  self endon("death");
  level endon("game_ended");
  wait(max(self.lifetime - 1, 0.05));
  self setscriptablepartstate("audio_exit", "on", 0);
  wait 1;
  self setscriptablepartstate("audio_loop", "off", 0);

  if(isDefined(self.minimapid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);

  if(isDefined(self.chassis))
    self.chassis delete();

  if(isDefined(self))
    self delete();
}

_id_2496CDD7BABAED39(_id_41C8BB9AFB483172, pathdist, _id_F0192932004DCE8D, _id_5B16491505732B2B, model) {
  if(!isDefined(model))
    model = "veh9_mil_air_cargo_plane_wm";

  plane = spawn("script_model", _id_41C8BB9AFB483172.startpt);
  plane setModel(model);
  plane setCanDamage(0);
  plane.maxhealth = 100000;
  plane.health = plane.maxhealth;
  plane.startpt = _id_41C8BB9AFB483172.startpt;
  plane.endpt = _id_41C8BB9AFB483172.endpt;
  plane.centerpt = _id_41C8BB9AFB483172.centerpt;
  plane.dir = vectorNormalize(plane.endpt - plane.startpt);
  plane.angles = vectortoangles(plane.dir);
  plane.pathdist = pathdist;
  plane.speed = _id_F0192932004DCE8D;
  plane.lifetime = _id_5B16491505732B2B;
  return plane;
}

_id_52F17E5FBEC318A6(_id_8EE83E2CBD3D747D, dropstruct, _id_D4858C7C75F6AB04) {
  _id_FDFE2D4AAF8EC33D = level._id_5D2AF95280A3CF58;

  if(!isDefined(_id_D4858C7C75F6AB04))
    _id_D4858C7C75F6AB04 = (_id_8EE83E2CBD3D747D[0], _id_8EE83E2CBD3D747D[1], _id_FDFE2D4AAF8EC33D);

  crate = spawn("script_model", _id_D4858C7C75F6AB04);
  crate setModel(dropstruct.cratemodel);
  crate.physicsactivated = 0;
  crate.isdestroyed = 0;
  crate.id = "care_package";
  crate.userate = dropstruct.userate;
  crate.curprogress = 0;
  crate.usetime = dropstruct.usetime;
  crate._id_5CC8AC2ED7A3D9FA = dropstruct._id_5CC8AC2ED7A3D9FA;
  crate.supportsreroll = 0;
  crate.cratetype = "br_supply_drops_common";
  return crate;
}

_id_98E40BECF6AAE51F(_id_8EE83E2CBD3D747D, dropstruct) {
  crate = undefined;

  if(isDefined(dropstruct.funcs["spawnDropCrate"]))
    crate = [[dropstruct.funcs["spawnDropCrate"]]](_id_8EE83E2CBD3D747D, dropstruct);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;

    if(!istrue(crate._id_329FE561ABC84FDB)) {
      chute = spawn("script_model", crate.origin);
      chute.angles = crate.angles;
      chute setModel("veh9_mil_lnd_parachute_carepackage_br");
      crate.chute = chute;
      crate._id_C23CA3472233553D = 1;
      chute linkTo(crate);
    }

    if(isDefined(dropstruct.funcs["onDropSpawned"]))
      crate thread[[dropstruct.funcs["onDropSpawned"]]](_id_8EE83E2CBD3D747D);

    if(isDefined(dropstruct.funcs["supplyDropFall"]))
      crate thread[[dropstruct.funcs["supplyDropFall"]]](_id_8EE83E2CBD3D747D, dropstruct);
  }

  return crate;
}

_id_7DEC3B199D2E73B8(point, dropstruct) {
  self endon("death");
  _id_81986B2D8E843970 = scripts\engine\utility::ter_op(isDefined(dropstruct._id_81986B2D8E843970), dropstruct._id_81986B2D8E843970, 10000000);
  _id_EB4187DD85E05B36 = scripts\engine\utility::ter_op(isDefined(dropstruct._id_EB4187DD85E05B36), dropstruct._id_EB4187DD85E05B36, 1000);
  _id_623DB0CC7C389A05 = scripts\engine\utility::ter_op(isDefined(dropstruct._id_623DB0CC7C389A05), dropstruct._id_623DB0CC7C389A05, 1);

  if(_id_EB4187DD85E05B36 > 0) {
    _id_A8708D55FBEA7FC2 = scripts\engine\utility::randomvector(1) * _id_EB4187DD85E05B36;
    point = scripts\engine\utility::drop_to_ground(point + _id_A8708D55FBEA7FC2);
  }

  if(istrue(dropstruct._id_F453AECD14B7F921))
    thread _id_D982CB8F96BA4D30();

  for(_id_4D7F0C602124BB0A = distancesquared(scripts\engine\utility::drop_to_ground(self.origin, -100), self.origin); _id_4D7F0C602124BB0A > _id_81986B2D8E843970 && !istrue(self._id_69C5E9413F4BDB05); _id_4D7F0C602124BB0A = distancesquared(scripts\engine\utility::drop_to_ground(self.origin, -100), self.origin)) {
    thread _id_3A64EC0C7632F6CC(point, dropstruct);
    waitframe();
  }

  self notify("crate_drift_end");
  self._id_661D71D55253757D = undefined;
  self._id_69C5E9413F4BDB05 = undefined;

  if(isDefined(self.chute))
    self.chute delete();

  if(!istrue(self.physicsactivated)) {
    self unlink();
    self physicslaunchserver((0, 0, 0), (0, 0, 0));
    _id_212A44A5393C3B34 = self physics_getbodyid(0);
    physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, -0.75));
    self.physicsactivated = 1;
  }

  endpos = scripts\engine\utility::drop_to_ground(self.origin, 25, -5000);
  self physics_registerforcollisioncallback();
  thread scripts\cp_mp\killstreaks\airdrop::monitorimpactinternal(0.1);

  if(istrue(_id_623DB0CC7C389A05)) {
    scriptable = scripts\engine\utility::ter_op(isDefined(self._id_13BA232EEE7E6069), self._id_13BA232EEE7E6069, "ks_airdrop_crate_dmz");
    self.smokesignal = spawn("script_model", endpos);
    self.smokesignal setModel(scriptable);
    self.smokesignal setscriptablepartstate("smoke_signal", "on", 0);
  }

  wait 3;

  if(!istrue(dropstruct._id_30DAF66A65A215E7))
    self setscriptablepartstate("dmz_supply_drop", "usable");

  childthread scripts\cp_mp\killstreaks\airdrop::monitoraveragevelocities(0.1, 8);
  _id_0717E0CFD076F91D = 0;

  for(;;) {
    wait 0.1;
    avlinvel = scripts\cp_mp\killstreaks\airdrop::getaveragelinearvelocity();
    avangvel = scripts\cp_mp\killstreaks\airdrop::getaverageangularvelocity();

    if(!isDefined(avlinvel) || !isDefined(avangvel)) {
      continue;
    }
    if(avlinvel > scripts\cp_mp\killstreaks\airdrop::_id_3C4492046080FAA9() || avangvel > scripts\cp_mp\killstreaks\airdrop::_id_F7E3F128296AC3B6()) {
      _id_0717E0CFD076F91D = 0;
      continue;
    }

    _id_0717E0CFD076F91D++;

    if(_id_0717E0CFD076F91D != scripts\cp_mp\killstreaks\airdrop::_id_D4833B6C916DB9C6()) {
      continue;
    }
    self.physicssettled = 1;
    break;
  }
}

_id_D982CB8F96BA4D30() {
  self endon("death");
  self endon("crate_drift_end");
  wait 3.0;
  self waittill("collision");
  self._id_69C5E9413F4BDB05 = 1;
}

_id_3A64EC0C7632F6CC(point, dropstruct) {
  self endon("death");
  self endon("crate_drift_end");

  if(isDefined(self._id_661D71D55253757D)) {
    return;
  }
  self._id_661D71D55253757D = 1;
  _id_CD743003D3F4F0CA = scripts\engine\utility::ter_op(isDefined(dropstruct._id_CD743003D3F4F0CA), dropstruct._id_CD743003D3F4F0CA, 3);
  _id_3077F6D3D97BB34B = scripts\engine\utility::ter_op(isDefined(dropstruct._id_3077F6D3D97BB34B), dropstruct._id_3077F6D3D97BB34B, 400);
  _id_3C3ED534C61A56E4 = scripts\engine\utility::ter_op(isDefined(dropstruct._id_3C3ED534C61A56E4), dropstruct._id_3C3ED534C61A56E4, 100);
  _id_94AE57FE158C3C29 = scripts\engine\utility::ter_op(isDefined(dropstruct._id_94AE57FE158C3C29), dropstruct._id_94AE57FE158C3C29, 100);
  _id_9612B650D147F458 = scripts\engine\utility::ter_op(isDefined(dropstruct._id_9612B650D147F458), dropstruct._id_9612B650D147F458, 500);
  _id_191EBD2DD0D5F975 = randomfloat(_id_94AE57FE158C3C29) + _id_3077F6D3D97BB34B;
  _id_67A81E668B8A7DBD = randomfloat(_id_9612B650D147F458) + _id_3C3ED534C61A56E4;
  dir = point - self.origin;
  _id_6EF6398383AE0CF6 = vectorNormalize((dir[0], dir[1], 0));
  _id_EA13048AE45874C6 = (_id_6EF6398383AE0CF6[0] * _id_67A81E668B8A7DBD, _id_6EF6398383AE0CF6[1] * _id_67A81E668B8A7DBD, 0 - _id_191EBD2DD0D5F975);
  startpoint = self.origin;
  timer = 0;

  while(timer < _id_CD743003D3F4F0CA) {
    _id_CE254178F5785581 = level.framedurationseconds;
    t = timer / _id_CD743003D3F4F0CA;
    _id_531E349AD5675163 = t * t * (3 - 2 * t);
    _id_E3E0425BF610E7B4 = t * t * 0.5 + 0.5 * t;

    if(!isDefined(_id_EA13048AE45874C6) || !isDefined(_id_531E349AD5675163) || !isDefined(_id_E3E0425BF610E7B4)) {
      break;
    }

    _id_868FBF655BD5E977 = (_id_EA13048AE45874C6[0] * _id_531E349AD5675163, _id_EA13048AE45874C6[1] * _id_531E349AD5675163, _id_EA13048AE45874C6[2] * _id_E3E0425BF610E7B4);
    self.origin = startpoint + _id_868FBF655BD5E977;
    timer = timer + _id_CE254178F5785581;
    waitframe();
  }

  self._id_661D71D55253757D = undefined;
}

_id_94FF06D2DB58E807(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!istrue(instance.entity.open)) {
    if(istrue(instance.entity _id_6B3BFD072D1FAAFB(player))) {
      instance.entity.open = 1;
      instance.entity.playerusing = undefined;
      instance.entity notify("crate_opened");
    } else
      return;
  }

  if(isDefined(instance.entity.smokesignal) && !isDefined(instance._id_CEB543956C7203E7))
    instance._id_CEB543956C7203E7 = ::_id_4B941A30DB41D07E;

  instance setscriptablepartstate("dmz_supply_drop", "partially_open_in_use_unusable");

  if(isDefined(instance.entity._id_5CC8AC2ED7A3D9FA))
    [[instance.entity._id_5CC8AC2ED7A3D9FA]](instance, player);

  if(isDefined(level._id_2FF67632074BC957))
    instance[[level._id_2FF67632074BC957]](player);

  items = getscriptablelootcachecontents(instance);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onOpenSupplyDrop"))
    items = [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onOpenSupplyDrop")]](player, instance, items);

  if(!isDefined(instance.contents)) {
    instance._id_46A3A8565AC0C17C = 3;
    instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, player, instance.contents);
  } else
    instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;
}

_id_6B3BFD072D1FAAFB(player) {
  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");
  self endon("crate_opened");
  level endon("game_ended");

  if(istrue(self.playerusing))
    return 0;

  thread _id_B8BFC63550A2B619(player);

  while(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate(player) && player useButtonPressed()) {
    if(!isDefined(self.playerusing))
      self.playerusing = 1;

    self.curprogress = self.curprogress + level.framedurationseconds * self.userate;

    if(self.curprogress >= self.usetime) {
      self.curprogress = 0.0;
      stopusingcrate(player);
      return 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](self, 1);

    waitframe();
  }

  self.playerusing = undefined;
  stopusingcrate(player);
  self.curprogress = 0.0;
  return 0;
}

_id_B8BFC63550A2B619(player) {
  level endon("game_ended");
  self endon("crate_opened");
  player scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self.playerusing = undefined;
}

stopusingcrate(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](self, 0);
}

cankeepusingcrate(player) {
  if(!player scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(player meleeButtonPressed())
    return 0;

  if(player isinexecutionvictim())
    return 0;

  if(istrue(player.inlaststand))
    return 0;

  if(distancesquared(player.origin, self.origin) >= 10000)
    return 0;

  return 1;
}

_id_D545B198B75385F6() {
  if(!isDefined(level._id_EF63E063E320ACFC)) {
    return;
  }
  foreach(dropstruct in level._id_EF63E063E320ACFC) {
    if(isDefined(dropstruct.funcs["onPlayerEnterGulag"]))
      self[[dropstruct.funcs["onPlayerEnterGulag"]]]();
  }
}

_id_F5D7F1682F6FC578() {
  if(!isDefined(level._id_EF63E063E320ACFC)) {
    return;
  }
  foreach(dropstruct in level._id_EF63E063E320ACFC) {
    if(isDefined(dropstruct.funcs["onPlayerRespawn"]))
      self thread[[dropstruct.funcs["onPlayerRespawn"]]]();
  }
}