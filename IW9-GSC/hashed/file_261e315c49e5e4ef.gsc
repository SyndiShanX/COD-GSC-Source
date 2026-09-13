/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_261e315c49e5e4ef.gsc
***********************************************/

init() {
  _id_046CF752D93DC17B::init();

  if(getdvarint("dvar_74ABB928AB13113B", 0) && !getdvarint("dvar_82BDE055B11E6698", 0) && isDefined(level._id_C83AA9DBC3654AFA)) {
    dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("br_elite_arrow_bombsite_drop", "military_carepackage_01_cq");
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_elite_arrow_bombsite_drop", "planeDropRun", ::_id_4583DCD65450A629);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_elite_arrow_bombsite_drop", "spawnDropCrate", ::_id_849AA3A04CEF2D5C);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_elite_arrow_bombsite_drop", "supplyDropFall", ::_id_DAAA2BA7597FE13E);
    dropstruct _id_728FFCEE8CBF30EE::_id_90692628E3F5A1C1();
  }

  if(!getdvarint("dvar_48CBD77125939B20", 1)) {
    dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("legendary_supply_drop");
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("legendary_supply_drop", "planeDropRun", ::_id_4583DCD65450A629);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("legendary_supply_drop", "spawnDropCrate", ::_id_54FED18839FE1A00);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("legendary_supply_drop", "supplyDropFall", ::_id_8E11624A19039380);
    dropstruct _id_20D10AB03CAA7C74();
  }

  if(!getdvarint("dvar_4C8E33496C92CD2E", 0)) {
    dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("br_loadout_drop");
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_loadout_drop", "spawnDropCrate", ::_id_070500B035CE9F1C);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_loadout_drop", "supplyDropFall", ::_id_4D10308E44E23AC2);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_loadout_drop", "onPlayerEnterGulag", ::_id_FD96E89ABD30CC4F);
    dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("br_loadout_drop", "onPlayerRespawn", ::_id_DE7E06E42793BD7F);
    game["dialog"]["dropbag_incoming"] = "dpbi_wzan_gams";
  }
}

_id_4583DCD65450A629(dropstruct) {
  thread _id_046CF752D93DC17B::_id_C28362A9638E7931(dropstruct);
}

_id_849AA3A04CEF2D5C(_id_8EE83E2CBD3D747D, dropstruct) {
  crate = _id_728FFCEE8CBF30EE::_id_8992A7892FE3A42C(_id_8EE83E2CBD3D747D);
  return crate;
}

_id_DAAA2BA7597FE13E(_id_8EE83E2CBD3D747D, dropstruct) {
  crate = self;
  crate thread _id_728FFCEE8CBF30EE::_id_F19FDCE841E05D0D(_id_8EE83E2CBD3D747D, dropstruct);
}

_id_20D10AB03CAA7C74() {
  dropstruct = self;
  dropstruct._id_2E0D8BA0A46CE1B1 = 1;
  dropstruct.zoffset = level._id_5D2AF95280A3CF58 * -0.5;
}

_id_54FED18839FE1A00(_id_8EE83E2CBD3D747D, dropstruct) {
  _id_D4858C7C75F6AB04 = _id_8EE83E2CBD3D747D + (0, 0, level._id_5D2AF95280A3CF58 / 2 - 600);
  angles = (0, 0, 0);
  crate = scripts\cp_mp\killstreaks\airdrop::createcrate(undefined, undefined, "legendary_supply_drop", _id_D4858C7C75F6AB04, angles, _id_8EE83E2CBD3D747D, undefined, 1);

  if(isDefined(crate)) {
    crate._id_329FE561ABC84FDB = 1;
    crate._id_4CD5B8F62D173211 = 1;
  }

  return crate;
}

_id_8E11624A19039380(_id_8EE83E2CBD3D747D, dropstruct) {
  level endon("game_ended");
  level endon("br_ending_start");
  crate = self;

  if(isDefined(crate))
    return;
}

_id_070500B035CE9F1C(_id_8EE83E2CBD3D747D, dropstruct) {
  _id_D4858C7C75F6AB04 = _id_8EE83E2CBD3D747D + (0, 0, level._id_5D2AF95280A3CF58);
  crate = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate("neutral", _id_D4858C7C75F6AB04, _id_8EE83E2CBD3D747D);

  if(isDefined(crate)) {
    crate._id_329FE561ABC84FDB = 1;
    crate._id_4CD5B8F62D173211 = 1;
  }

  return crate;
}

_id_4D10308E44E23AC2(_id_8EE83E2CBD3D747D, dropstruct) {
  level endon("game_ended");
  level endon("br_ending_start");
  crate = self;

  if(isDefined(crate)) {
    crate _id_0A37DB87A4770B8A();
    crate childthread _id_C8A76E7B9D477BCC();
    crate childthread _id_643937A5F43EB434();
    crate childthread _id_9E398892D48BA3A6();
    level notify("loadout_crate_fall", crate);
  }
}

_id_607167C18661377B(_id_70BCBF0AD5028219, droptype) {
  level notify("loadout_plane_stop");
  level endon("loadout_plane_stop");
  level endon("game_ended");
  level endon("br_ending_start");
  _id_308D5F146D61745D = getdvarint("dvar_4CC81B833E45A79D", 3);

  if(_id_308D5F146D61745D == 0) {
    return;
  }
  if(!isDefined(droptype))
    droptype = "br_loadout_drop";

  _id_07BA2C5F32045574 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_70BCBF0AD5028219.size; _id_AC0E594AC96AA3A8++) {
    _id_74B5B12BB6514385 = _id_70BCBF0AD5028219[_id_AC0E594AC96AA3A8];
    waittime = _id_74B5B12BB6514385 - _id_07BA2C5F32045574;

    if(waittime <= 0) {
      continue;
    }
    wait(waittime);
    _id_07BA2C5F32045574 = _id_74B5B12BB6514385;
    _id_C669C821EE772A3D = 1;

    if(istrue(level._id_2DF69B8E552238B6) && !_id_58F20490049AF6AC::_id_29E8194FF7E13E2E() && !_id_58F20490049AF6AC::_id_D8FBACC18E5D8498())
      _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

    _id_A3F2F28D570440EB = getdvarint("dvar_711A9F3CF948C5C9", 8);

    if(_id_AC0E594AC96AA3A8 > 0) {
      _id_A3F2F28D570440EB = getdvarint("dvar_B3D8A888EEA5F976", 3);
      _id_308D5F146D61745D = 1;
    }

    if(_id_C669C821EE772A3D > 1) {
      _id_2E0D8BA0A46CE1B1 = int(ceil(_id_A3F2F28D570440EB / _id_C669C821EE772A3D));

      for(_id_879103158BBD385A = 0; _id_879103158BBD385A < _id_C669C821EE772A3D; _id_879103158BBD385A++) {
        _id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, _id_879103158BBD385A, undefined, undefined, droptype);
        waitframe();
      }
    } else if(_id_308D5F146D61745D == 2)
      _id_BDC1FB0F306D02FA(_id_A3F2F28D570440EB, droptype);
    else if(_id_308D5F146D61745D == 3)
      _id_F12F1B0FD0C95B97(_id_A3F2F28D570440EB, droptype);
    else
      _id_C3D1F879C57A12A6(_id_A3F2F28D570440EB, 0, undefined, undefined, droptype);

    level childthread _id_792F056FEEA2F3C9();
  }
}

_id_BDC1FB0F306D02FA(_id_A3F2F28D570440EB, droptype) {
  _id_821B13082F214589 = randomfloatrange(0, 360);
  _id_2E0D8BA0A46CE1B1 = int(ceil(_id_A3F2F28D570440EB / 2));
  _id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, 0, _id_821B13082F214589, undefined, droptype);
  _id_8CF8FFDB3D3B7D6E = getdvarfloat("dvar_F96CF03AB951508E", 2.0);

  if(_id_8CF8FFDB3D3B7D6E > 0.0)
    wait(_id_8CF8FFDB3D3B7D6E);

  _id_C3248B9962FE3B35 = 90.0;
  _id_F7B5065A48A75B79 = randomfloatrange(-5, 5);
  _id_821B13082F214589 = angleclamp(_id_821B13082F214589 + _id_C3248B9962FE3B35 + _id_F7B5065A48A75B79);
  _id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, 0, _id_821B13082F214589, undefined, droptype);
}

_id_F12F1B0FD0C95B97(_id_A3F2F28D570440EB, droptype) {
  _id_821B13082F214589 = randomfloatrange(0, 360);

  if(getdvarint("dvar_89202350D7308671", 1)) {
    circlecenter = _id_2695A20D4011076D::getsafecircleorigin();
    _id_821B13082F214589 = vectortoyaw(circlecenter * -1.0);
  }

  _id_2E0D8BA0A46CE1B1 = int(ceil(_id_A3F2F28D570440EB / 3));
  _id_4DA52BFABB572A1D = getdvarfloat("dvar_407D738B9BA721FD", 0.5);
  _id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, 0, _id_821B13082F214589, 0.0, droptype);
  _id_555AD7FD7F889A31 = getdvarfloat("dvar_974235136F18ADEF", 5.0);

  if(_id_555AD7FD7F889A31 > 0.0)
    wait(_id_555AD7FD7F889A31);

  _id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, 0, _id_821B13082F214589, _id_4DA52BFABB572A1D, droptype);
  waitframe();
  _id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, 0, _id_821B13082F214589, -1.0 * _id_4DA52BFABB572A1D, droptype);
}

_id_C3D1F879C57A12A6(_id_2E0D8BA0A46CE1B1, _id_822C3C9BBE304562, _id_D9AA6A35EB465619, _id_EDA78F398E8DFBDE, droptype) {
  if(!isDefined(droptype))
    droptype = "br_loadout_drop";

  dropstruct = level._id_EF63E063E320ACFC[droptype];

  if(!isDefined(dropstruct)) {
    scripts\mp\utility\script::demoforcesre("Supply drop type \"" + droptype + "\" does not exist.");
    return;
  }

  _id_E81E88A0EC548B57 = level.br_level.br_circleradii[0];

  if(_id_2E0D8BA0A46CE1B1 <= 0 || _id_E81E88A0EC548B57 <= 0.0) {
    return;
  }
  _id_5D55352ED330471C = _id_046CF752D93DC17B::_id_1422FFCD34611FD1();
  _id_5BF3E22BDB650432 = _id_2695A20D4011076D::getsafecircleorigin();
  circleradius = _id_2695A20D4011076D::getsafecircleradius();

  if(istrue(level._id_2DF69B8E552238B6)) {
    _id_5BF3E22BDB650432 = _id_58F20490049AF6AC::_id_0799FE4EE850F911(_id_822C3C9BBE304562);
    circleradius = _id_58F20490049AF6AC::_id_8A985543E6853BBD(_id_822C3C9BBE304562);
  } else {
    _id_1F191F72B443BB6D = getdvarint("dvar_DAF294D5B4E5A87A", 0);

    if(_id_1F191F72B443BB6D) {
      _id_5BF3E22BDB650432 = _id_2695A20D4011076D::getnextsafecircleorigin();
      circleradius = _id_2695A20D4011076D::getnextsafecircleradius();
    }
  }

  if(isDefined(level._id_E486ACB8F70C45A2) && scripts\engine\utility::flag("chokehold_closed")) {
    _id_5BF3E22BDB650432 = _id_2695A20D4011076D::getdangercircleorigin();
    circleradius = _id_2695A20D4011076D::getdangercircleradius();
  }

  if(!isDefined(level.br_circle))
    circleradius = level.br_level.br_circleradii[0];

  if(isDefined(_id_D9AA6A35EB465619) && isDefined(_id_EDA78F398E8DFBDE) && _id_EDA78F398E8DFBDE != 0.0) {
    _id_B0915B4828983DF7 = vectorNormalize(anglestoright((0, _id_D9AA6A35EB465619, 0)));
    _id_D2666395E6CF4732 = _id_EDA78F398E8DFBDE * circleradius;
    _id_5BF3E22BDB650432 = _id_5BF3E22BDB650432 + _id_B0915B4828983DF7 * _id_D2666395E6CF4732;
    circleradius = sqrt(squared(circleradius) - squared(_id_D2666395E6CF4732));
  }

  _id_E12D1C28EF3DB42A = circleradius * 2.0;
  _id_43CFC8FE5CF92471 = _id_E81E88A0EC548B57 * 2.0;
  _id_F01F4AB1D5D21F9C = (_id_E81E88A0EC548B57 - circleradius) / _id_43CFC8FE5CF92471;
  _id_58AD628EA64156F9 = _id_E12D1C28EF3DB42A / _id_5D55352ED330471C / (_id_2E0D8BA0A46CE1B1 + 1);
  dropstruct._id_2E0D8BA0A46CE1B1 = _id_2E0D8BA0A46CE1B1;
  dropstruct._id_F01F4AB1D5D21F9C = _id_F01F4AB1D5D21F9C;
  dropstruct._id_62BA925DF2F38D68 = _id_58AD628EA64156F9;
  dropstruct._id_322B7887F80ACC62 = 1;
  dropstruct.zoffset = getdvarfloat("dvar_8F28D4EAD9CEC8EA", 1000) * _id_822C3C9BBE304562;
  dropstruct._id_821B13082F214589 = _id_D9AA6A35EB465619;
  _id_B75B26BD9C0F60AD = getdvarint("dvar_D62B4F29572EBF87", 1);

  if(_id_B75B26BD9C0F60AD)
    dropstruct._id_5214BB02998FF284 = 1;

  _id_046CF752D93DC17B::_id_1A01863A6EC2AD05(_id_5BF3E22BDB650432, droptype);
}

_id_792F056FEEA2F3C9() {
  level notify("crate_fall_watch");
  level endon("crate_fall_watch");
  level waittill("loadout_crate_fall");
  level childthread _id_AD91760F4F41C169(2.5);
  level childthread _id_AB8C6A785614CA99(1.0);
}

_id_AD91760F4F41C169(_id_74B5B12BB6514385) {
  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0)
    wait(_id_74B5B12BB6514385);

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
      player thread scripts\mp\hud_message::showsplash("br_airdrop_incoming");
  }
}

_id_AB8C6A785614CA99(_id_74B5B12BB6514385) {
  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0)
    wait(_id_74B5B12BB6514385);

  if(!_id_2CEDCC356F1B9FC8::istutorial())
    _id_2CEDCC356F1B9FC8::brleaderdialog("dropbag_incoming", 1, undefined, 0, 0, undefined, "dx_br_dmzc_");
}

_id_0A37DB87A4770B8A() {
  crate = self;
  crate.minimapicon = "ui_map_icon_drop_loadout";
  crate scripts\cp_mp\killstreaks\airdrop::createminimapicon();
  objid = crate.minimapid;

  if(isDefined(objid) && objid != -1) {
    crate setscriptablepartstate("objective_map", "custom");
    objective_state(objid, "current");
    objective_setownerteam(objid, "neutral");
    objective_setlabel(objid, &"MP_INGAME_ONLY/DROP_BAG_CAPS");
    objective_setzoffset(objid, 75);
    objective_setpings(objid, 1);
    _func_A16750CD44F57931(objid, 1);
    _func_865F9C5D005F9A08(objid, 1);
    _id_0467F4D9B8D9063B = getdvarfloat("dvar_E9D0ABFE80024D80", 3937.0);
    _id_D9DB7BE56114E3B9 = getdvarfloat("dvar_EC4ADB02477BC5B2", 0.97);
    _id_A7C6C5D6C3D369AA = _id_0467F4D9B8D9063B * _id_D9DB7BE56114E3B9;
    _func_C047D7FFE7A83501(objid, _id_A7C6C5D6C3D369AA, _id_0467F4D9B8D9063B);

    foreach(player in level.players) {
      if(isalive(player) && !isbot(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
    }

    crate._id_7B5E5C2BBC8F9F79 = objid;
  }
}

_id_C8A76E7B9D477BCC() {
  crate = self;
  crate notify("crate_impact_watch");
  crate endon("crate_impact_watch");
  crate endon("death");
  wait 1;
  crate waittill("collision");
  wait 1;
  _id_49F7615F089F4575 = getdvarint("dvar_1263820AD3A08477", 60);

  if(_id_49F7615F089F4575 > 0) {
    crate setscriptablepartstate("smoke_signal", "drop_plane_on", 0);
    wait(_id_49F7615F089F4575);

    if(getdvarint("dvar_AD77E9F65A2E05C2", 0)) {
      objid = crate.minimapid;

      if(isDefined(objid) && objid != -1)
        objective_state(objid, "active");
    }
  }

  crate setscriptablepartstate("smoke_signal", "off", 0);
}

_id_643937A5F43EB434() {
  if(getdvarint("dvar_33F880A10E8651AE", 0)) {
    return;
  }
  crate = self;
  crate notify("crate_capture_watch");
  crate endon("crate_capture_watch");
  crate endon("death");

  for(;;) {
    crate waittill("brLoadoutPostCapture", player);
    objid = crate.minimapid;

    if(isDefined(player) && isDefined(objid) && objid != -1)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objid, player);
  }
}

_id_9E398892D48BA3A6() {
  crate = self;
  crate notify("crate_death_watch");
  crate endon("crate_death_watch");
  crate waittill("death");
  objid = crate.minimapid;

  if(isDefined(objid) && objid != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(objid);
    crate.minimapid = undefined;
  }
}

_id_FD96E89ABD30CC4F() {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && istrue(crate._id_4CD5B8F62D173211) && isDefined(crate.minimapid))
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.minimapid, player);
  }
}

_id_DE7E06E42793BD7F() {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && istrue(crate._id_4CD5B8F62D173211) && isDefined(crate.minimapid)) {
      if(!isDefined(crate.playersused) || !scripts\engine\utility::array_contains(crate.playersused, player))
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(crate.minimapid, player);
    }
  }
}

_id_3241AFDFEC957CB9(player) {
  switch (self.source) {
    case "vip_quest":
      _id_160D0F1B81840667::_id_2410E069C697BA3C(player);
      break;
    case "windchimes":
      _id_BAB0D10E51188531 = scripts\mp\utility\teams::getteamdata(player.team, "players");

      if(isDefined(level._id_F385B864293E8777) && isDefined(level._id_F385B864293E8777._id_17E70EB167A5DFA6))
        [[level._id_F385B864293E8777._id_17E70EB167A5DFA6]](self._id_08C5EE84D75AB881, self.origin, self.angles, _id_BAB0D10E51188531, 0, self._id_655E8F8E75379DAE, self._id_036685CC32931D3A, self.ammo_count, player);

      break;
    default:
  }
}