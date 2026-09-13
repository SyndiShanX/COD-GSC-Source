/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_doublexp_crate.gsc
******************************************************************/

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("disable_public_event");
  level endon("game_ended");

  if(isDefined(level._id_034714CE799B6017) && !level._id_034714CE799B6017) {
    return;
  }
  level waittill("init_public_event");
  init();
}

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_EC487051294F83C2", 1.0);
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F.validatefunc = ::_id_03E0AB74E4391F51;
  _id_7EC7671A1E0C788F.activatefunc = ::_id_94B6A8CECF4460F4;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_0E7B4A1481598B09", 1);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("doublexp_crate", "10 40 50 50 50 50 50 50 50 50 50 50");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("doublexp_crate");
  _id_337BD370F7C5E6F9::registerpublicevent(19, _id_7EC7671A1E0C788F);
  initdialog();
}

initdialog() {
  game["dialog"]["dbxp_inbound"] = "dbxp_wzan_inbd";
  game["dialog"]["dbxp_boost"] = "dbxp_wzan_boos";
  game["dialog"]["dbxp_active"] = "dbxp_wzan_xpac";
}

_id_C9E871D29702E8CF() {
  level._id_849FBFB162366139 = spawnStruct();
  level._id_849FBFB162366139._id_5B5B63AD1AA0C600 = getdvarint("dvar_9D51F9C0009F08F1", 5);
  level._id_849FBFB162366139._id_244C8B1A0FD7B3F2 = getdvarint("dvar_BC16751BEFCEA55D", 2.0);
  level._id_849FBFB162366139._id_1E5A000C9DD647D9 = getdvarint("dvar_1BA89B1C84FFBFA1", 1);
  level._id_849FBFB162366139._id_E46C4BB389787C4B = getdvarint("dvar_9FFCAA81D06C9318", 1);
  level._id_849FBFB162366139._id_C7B9959DC3806B9D = getdvarint("dvar_9A2D81522AF9D92E", 1);
  level._id_849FBFB162366139._id_87F7CAE714BDEAD2 = getdvarint("dvar_55F79E64C5D2A78C", 1);
  level._id_849FBFB162366139._id_9E26DB7DC8713415 = getdvarint("dvar_220AE379B570305D", 5);
  level._id_849FBFB162366139._id_CB99E35E55B5A678 = getdvarint("dvar_40A3C8AC39A65A2C", 1);
  level._id_849FBFB162366139._id_C23382998980BAE9 = getdvarint("dvar_185B9052B3DEB291", 4000);
  level._id_849FBFB162366139._id_6B4D4E4C82BCC857 = getdvarint("dvar_1F536DE4D89B0D4F", 300);
  level._id_849FBFB162366139._id_8337FDB41FC6F888 = [];
  _id_EA4328915149D5A7 = strtok(getDvar("dvar_7DF719E8123C2C33", "500 750 1000 1250 1500"), " ");
  level._id_849FBFB162366139._id_5D8C02C2769162B1 = [];

  foreach(_id_492CB44147FCF2CE in _id_EA4328915149D5A7)
  level._id_849FBFB162366139._id_5D8C02C2769162B1[level._id_849FBFB162366139._id_5D8C02C2769162B1.size] = int(_id_492CB44147FCF2CE);
}

_id_03E0AB74E4391F51() {
  if(istrue(level._id_2DF69B8E552238B6) && !istrue(level._id_CB9A9BFBBC8B8A0F) && level.br_circle.circleindex > -1 && _id_58F20490049AF6AC::_id_D987886BB9DE9137() > 1 && !_id_58F20490049AF6AC::_id_29E8194FF7E13E2E())
    return 0;

  return 1;
}

_id_92D23849FAC69B79() {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("battle_royale_doublexp_crate");
  _id_962A30A9BB8C0F09.capturestring = &"MP/DOUBLEXP_CRATE_CAPTURE";
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_doublexp";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 1;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
  _id_962A30A9BB8C0F09.activatecallback = ::_id_6A082776D19D52BA;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_C1C2F8B04E6586ED;
  _id_962A30A9BB8C0F09.destroycallback = ::_id_8E6E4E55266FBD15;
}

_id_94B6A8CECF4460F4() {
  _id_92D23849FAC69B79();
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_doublexp_crate_start", "splash_list_br_pe_doublexp_crate");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("dbxp_inbound", 1, undefined, 0, 0, undefined, "dx_br_bds4_");
  _id_59C84EE8014EA5A8(level._id_849FBFB162366139._id_5B5B63AD1AA0C600);
}

_id_6A082776D19D52BA(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
  }
}

_id_C1C2F8B04E6586ED(player) {
  _id_FA22A58F778274E7();
  _id_61B813C431FCA619();
  player _id_DAA510E2D1CE6F2F();
}

_id_8E6E4E55266FBD15(immediate) {
  _id_61B813C431FCA619();
}

_id_61B813C431FCA619() {
  if(isDefined(self._id_7B5E5C2BBC8F9F79)) {
    objective_delete(self._id_7B5E5C2BBC8F9F79);
    scripts\mp\objidpoolmanager::returnobjectiveid(self._id_7B5E5C2BBC8F9F79);
    self._id_7B5E5C2BBC8F9F79 = undefined;
  }

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(isDefined(level.c130successfulairdrops))
    level.c130successfulairdrops = scripts\engine\utility::array_remove(level.c130successfulairdrops, self);
}

_id_DAA510E2D1CE6F2F() {
  player = self;
  player thread _id_B7BFE6AE470E02C2();
  _id_A18FD119C17C71F9 = player;
  _id_244C8B1A0FD7B3F2 = level._id_849FBFB162366139._id_244C8B1A0FD7B3F2;

  if(level._id_849FBFB162366139._id_1E5A000C9DD647D9) {
    _id_A6AB8D0FDA441DC2 = scripts\engine\utility::array_removeundefined(scripts\mp\utility\teams::getteamdata(player.team, "players"));
    _id_A18FD119C17C71F9 = _id_A6AB8D0FDA441DC2;

    if(level._id_849FBFB162366139._id_E46C4BB389787C4B)
      scripts\mp\rank::addteamrankxpmultiplier(_id_244C8B1A0FD7B3F2, player.team, "battle_royale_doublexp_crate");

    if(level._id_849FBFB162366139._id_C7B9959DC3806B9D) {
      foreach(_id_736D8D9188CCBD45 in _id_A6AB8D0FDA441DC2)
      _id_736D8D9188CCBD45 scripts\mp\weaponrank::addweaponrankxpmultiplier(_id_244C8B1A0FD7B3F2, "battle_royale_doublexp_crate");
    }
  } else {
    if(level._id_849FBFB162366139._id_E46C4BB389787C4B)
      player scripts\mp\rank::addrankxpmultiplier(_id_244C8B1A0FD7B3F2, "battle_royale_doublexp_crate");

    if(level._id_849FBFB162366139._id_C7B9959DC3806B9D)
      player scripts\mp\weaponrank::addweaponrankxpmultiplier(_id_244C8B1A0FD7B3F2, "battle_royale_doublexp_crate");
  }

  player _id_E9E2CF1181EB7177();
  level._id_849FBFB162366139.dlogdata["nbOfCratesUsed"] = level._id_849FBFB162366139.dlogdata["nbOfCratesUsed"] + 1;

  if(player _id_090FBFA0E04230B9()) {
    foreach(_id_55F11FAF1BA04750 in _id_A18FD119C17C71F9) {
      if(level._id_849FBFB162366139._id_E46C4BB389787C4B)
        _id_55F11FAF1BA04750 scripts\mp\hud_message::showsplash("event_double_xp", undefined, self);

      if(level._id_849FBFB162366139._id_C7B9959DC3806B9D)
        _id_55F11FAF1BA04750 scripts\mp\hud_message::showsplash("event_double_weapon_xp", undefined, self);
    }

    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("dbxp_active", undefined, _id_A18FD119C17C71F9, 1, 0, undefined, "dx_br_bds4_");
  } else
    scripts\mp\utility\lower_message::setlowermessageomnvar("doublexp_crate_already_used", undefined, 5);
}

_id_090FBFA0E04230B9() {
  player = self;
  _id_DCF5297E75DF8644 = scripts\engine\utility::ter_op(level._id_849FBFB162366139._id_1E5A000C9DD647D9, player.team, player);

  if(scripts\engine\utility::array_contains(level._id_849FBFB162366139._id_8337FDB41FC6F888, _id_DCF5297E75DF8644))
    return 0;

  level._id_849FBFB162366139._id_8337FDB41FC6F888 = scripts\engine\utility::array_add(level._id_849FBFB162366139._id_8337FDB41FC6F888, _id_DCF5297E75DF8644);
  return 1;
}

_id_B7BFE6AE470E02C2() {
  _id_492CB44147FCF2CE = level._id_849FBFB162366139._id_5D8C02C2769162B1[0];

  if(isDefined(level.br_circle.circleindex) && level.br_circle.circleindex >= 0) {
    index = int(min(level.br_circle.circleindex, level._id_849FBFB162366139._id_5D8C02C2769162B1.size - 1));
    _id_492CB44147FCF2CE = level._id_849FBFB162366139._id_5D8C02C2769162B1[index];
  }

  _id_B01ACA3236595958 = spawnStruct();
  _id_B01ACA3236595958._id_EFE4124EAA21EA43 = _id_492CB44147FCF2CE;
  scripts\mp\rank::giverankxp("stat_795EE672E1287A92", _id_492CB44147FCF2CE, undefined, 0, 1, 1, _id_B01ACA3236595958);
}

_id_FA22A58F778274E7() {
  if(!istrue(level._id_849FBFB162366139._id_CB99E35E55B5A678)) {
    return;
  }
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  droporigin = self.origin;
  dropangles = self.angles;
  itemlist = [];
  itemlist[itemlist.size] = ["brloot_plunder_cash_epic_1", 500];
  itemlist[itemlist.size] = ["brloot_super_munitionsbox", 1];
  itemlist[itemlist.size] = ["brloot_super_armorbox", 1];
  itemlist[itemlist.size] = ["brloot_offhand_deployablekiosk", 1];
  itemlist[itemlist.size] = ["brloot_super_reinforcementflare", 1];

  foreach(item in itemlist) {
    if(_id_552B8E4EA5FF7DF1::canspawnitemname(item[0])) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles, self);
      _id_7E52B56769FA7774::spawnpickup(item[0], _id_CB4FAD49263E20C4, item[1], 1);
    }
  }
}

_id_59C84EE8014EA5A8(_id_5B5B63AD1AA0C600) {
  level endon("game_ended");

  if(_id_5B5B63AD1AA0C600 <= 0) {
    return;
  }
  circle = spawnStruct();

  if(istrue(level._id_2DF69B8E552238B6)) {
    circle.origin = level.br_level.br_circlecenters[level.br_circle.circleindex + 1];
    circle.radius = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  } else {
    circle.origin = _id_2695A20D4011076D::getsafecircleorigin();
    circle.radius = _id_2695A20D4011076D::getsafecircleradius();
  }

  pathstruct = _id_2E385BC294259245::c130airdrop_createpath(undefined, circle.origin);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  _id_184D0A0CE31A2B27.owner = undefined;
  _id_184D0A0CE31A2B27.team = undefined;
  _id_184D0A0CE31A2B27.dropfunc = ::_id_CC9F0006DA726497;
  _id_184D0A0CE31A2B27 _id_2E385BC294259245::c130airdrop_startdelivery(_id_5B5B63AD1AA0C600, "battle_royale_doublexp_crate", "inactive", circle);
}

_id_60E9F1BB94A9D614(point, _id_E81699436572AEE6, _id_42A55D59DA918282) {
  _id_E22310C8BDD48985 = pointonsegmentnearesttopoint(_id_E81699436572AEE6[0], _id_E81699436572AEE6[1], point);
  _id_E2230DC8BDD482EC = pointonsegmentnearesttopoint(_id_42A55D59DA918282[0], _id_42A55D59DA918282[1], point);

  if(distance2dsquared(point, _id_E22310C8BDD48985) > distance2dsquared(point, _id_E2230DC8BDD482EC))
    return _id_E22310C8BDD48985;

  return _id_E2230DC8BDD482EC;
}

_id_B2B7915585A31DC4(dropcircle) {
  _id_B3D62AB023B59BF6 = level.br_level.br_mapcenter + _id_45B2B4A889E633FA::_id_01F389456D7C530A();
  _id_6D7E4CC332C6D081 = _id_45B2B4A889E633FA::getplanepathsaferadiusfromcenter();
  _id_8E0605CB0D8AE85E = scripts\engine\math::_id_D2C0D8330AB7AD7F(self.startpt, self.endpt, dropcircle.origin, dropcircle.radius);
  _id_690B677AE1FF4E7C = scripts\engine\math::_id_D2C0D8330AB7AD7F(self.startpt, self.endpt, _id_B3D62AB023B59BF6, _id_6D7E4CC332C6D081);

  if(!isDefined(_id_8E0605CB0D8AE85E) || !isDefined(_id_690B677AE1FF4E7C) || _id_690B677AE1FF4E7C.size < 2) {
    return;
  }
  _id_D4858C7C75F6AB04 = _id_60E9F1BB94A9D614(self.startpt, _id_8E0605CB0D8AE85E, _id_690B677AE1FF4E7C);
  _id_8EE83E2CBD3D747D = _id_60E9F1BB94A9D614(self.endpt, _id_8E0605CB0D8AE85E, _id_690B677AE1FF4E7C);
  self.centerpt = (_id_D4858C7C75F6AB04 + _id_8EE83E2CBD3D747D) / 2;
  dropcircle.radius = distance2d(_id_D4858C7C75F6AB04, self.centerpt) - 50;
}

_id_CC9F0006DA726497(_id_5B5B63AD1AA0C600, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle) {
  _id_B2B7915585A31DC4(dropcircle);
  _id_0BD34ECAC3ADA85B = self.startpt;
  droppoint = self.centerpt;
  _id_5D55352ED330471C = self.speed;
  _id_800DF1B7C6E3AA60 = (distance2d(_id_0BD34ECAC3ADA85B, droppoint) - dropcircle.radius) / _id_5D55352ED330471C;
  cratedroptime = dropcircle.radius * 2 / _id_5B5B63AD1AA0C600 / _id_5D55352ED330471C;
  _id_2119E0B45206E4B2 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5B5B63AD1AA0C600; _id_AC0E594AC96AA3A8++) {
    wait(_id_800DF1B7C6E3AA60);
    _id_800DF1B7C6E3AA60 = cratedroptime;
    _id_76A22C18960F72AF = _id_2E385BC294259245::c130airdrop_findvaliddroplocation(self.origin + anglesToForward(self.angles) * 500, 0, 1);

    if(!isDefined(_id_76A22C18960F72AF)) {
      continue;
    }
    crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(_id_76A22C18960F72AF + (0, 0, level.c130airdrop_heightoverride - 100), _id_76A22C18960F72AF, self.angles, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, level._id_849FBFB162366139._id_87F7CAE714BDEAD2, undefined, "ks_airdrop_crate_br_pe_doublexp");

    if(!isDefined(crate)) {
      continue;
    }
    crate setscriptablepartstate("objective_map", "hidden");
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", crate.origin, "ui_map_icon_drop_doublexp");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
      scripts\mp\objidpoolmanager::update_objective_onentity(objid, crate);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 75);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
      scripts\mp\objidpoolmanager::_id_098BA077848896A3(objid, 1);
      scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(objid, level._id_849FBFB162366139._id_C23382998980BAE9 - level._id_849FBFB162366139._id_6B4D4E4C82BCC857, level._id_849FBFB162366139._id_C23382998980BAE9);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
      scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(objid, &"MP/DOUBLEXP_CRATE_NAME");
      crate._id_7B5E5C2BBC8F9F79 = objid;
    }

    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
    _id_EF5D5141FDB51174.usetimeoverride = level._id_849FBFB162366139._id_9E26DB7DC8713415;
    level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
    _id_2119E0B45206E4B2 = _id_2119E0B45206E4B2 + 1;
  }

  if(getdvarint("dvar_55F79E64C5D2A78C", 1) == 0) {
    level waittill("battle_royale_doublexp_cratedrop_anim_completed");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("dbxp_boost", 1, undefined, 0, 0, undefined, "dx_br_bds4_");
  }

  _id_BDFEA1628154E7E3(_id_2119E0B45206E4B2);
}

_id_BDFEA1628154E7E3(_id_2119E0B45206E4B2) {
  if(isDefined(level._id_849FBFB162366139.dlogdata)) {
    return;
  }
  level._id_849FBFB162366139.dlogdata = [];
  level._id_849FBFB162366139.dlogdata["nbOfCratesDropped"] = _id_2119E0B45206E4B2;
  level._id_849FBFB162366139.dlogdata["nbOfCratesUsed"] = 0;
  thread _id_68E995ABE7E84297();
}

_id_68E995ABE7E84297() {
  level waittill("game_ended");
  dlog_recordevent("dlog_event_doublexp_crate_match_event", ["nb_of_crates_dropped", level._id_849FBFB162366139.dlogdata["nbOfCratesDropped"], "nb_of_crates_used", level._id_849FBFB162366139.dlogdata["nbOfCratesUsed"], "crate_benefits_entire_team", level._id_849FBFB162366139._id_1E5A000C9DD647D9]);
}

_id_E9E2CF1181EB7177() {
  circleindex = 0;

  if(isDefined(level.br_circle.circleindex) && level.br_circle.circleindex >= 0)
    circleindex = level.br_circle.circleindex;

  self dlog_recordplayerevent("dlog_event_doublexp_crate_participation", ["player_x", self.origin[0], "player_y", self.origin[1], "player_z", self.origin[2], "team", self.team, "circle_index", circleindex]);
}