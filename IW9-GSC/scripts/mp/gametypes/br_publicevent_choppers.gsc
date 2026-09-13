/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_choppers.gsc
************************************************************/

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
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_1F5FCBFEB295984D", 1.0);
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_BF462F5CB0733714", 0);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("choppers", "00 0 00 0 0 0");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("choppers");
  _id_92294971F87D4169 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getsubgametype() == "plunder", 120.0, 0);
  lifetime = getdvarint("dvar_98BD89274E7E4312", _id_92294971F87D4169);
  _id_7EC7671A1E0C788F.helilifetime = lifetime;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", ::oncrateuse);
  _id_337BD370F7C5E6F9::registerpublicevent(1, _id_7EC7671A1E0C788F);
}

_id_C9E871D29702E8CF() {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    game["dialog"]["public_events_choppers_start"] = "public_events_supply_choppers_start";
  else
    game["dialog"]["public_events_choppers_start"] = "chpp_wzan_bmvn";
}

validatefunc() {
  _id_8D96339583251A32 = scripts\mp\utility\game::getsubgametype() == "plunder";
  return _id_8D96339583251A32;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  level endon("game_ended");
  _id_7A5DADB6081D4303 = getdvarint("dvar_352A2EBCA39850C0", 6);
  scripts\mp\hud_util::showsplashtoall("br_plunder_pe_attack_choppers_active", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_choppers_start");
  setomnvar("ui_publicevent_timer_type", 12);
  eventduration = self.helilifetime;
  _id_91A988004AA42D31 = gettime() + eventduration * 1000 + 25000;
  setomnvar("ui_publicevent_timer", _id_91A988004AA42D31);
  setomnvar("ui_publicevent_minimap_pulse", 1);
  thread spawnchoppers(_id_7A5DADB6081D4303);
  mintime = 10.0;
  waituntilallchoppersaredead(mintime, _id_91A988004AA42D31);
  setomnvar("ui_publicevent_timer_type", 0);
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("dvar_1EFF74E2CF4C0351", 555.0);
  _id_07AF9598177DC2DE = getdvarfloat("dvar_1F2286E2CF72729F", 765.0);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}

waituntilallchoppersaredead(mintime, _id_91A988004AA42D31) {
  level endon("game_ended");

  if(isDefined(mintime))
    wait(mintime);

  _id_6FBA2EA0EB6D7507 = isDefined(_id_91A988004AA42D31);

  for(;;) {
    _id_BD3D37C841623F9B = level.loot_choppers;

    if(!isDefined(_id_BD3D37C841623F9B)) {
      break;
    }

    _id_BD3D37C841623F9B = scripts\engine\utility::array_removeundefined(_id_BD3D37C841623F9B);

    if(_id_BD3D37C841623F9B.size == 0) {
      break;
    }

    if(_id_6FBA2EA0EB6D7507 && gettime() > _id_91A988004AA42D31) {
      setomnvar("ui_publicevent_timer_type", 0);
      _id_6FBA2EA0EB6D7507 = 0;
    }

    wait 1.0;
  }
}

spawnchoppers(_id_7A5DADB6081D4303) {
  level endon("game_ended");
  circlecenter = undefined;
  circleradius = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    circlecenter = _id_2695A20D4011076D::getdangercircleorigin();
    circleradius = _id_2695A20D4011076D::getdangercircleradius();
  } else {
    level.adjusteventdistributionpadding = 35;
    level.pushdistributiontowardoppositecorner = 1;
    level.buystationsusepaddingdistribution = 0;
    level thread _id_1F6BC044DD1738AB::setupmapquadrantcornersandgrid();
  }

  _id_271667045665E514::init();

  if(!isDefined(level.pe_chopper_zones)) {
    _id_ED09715E306A1455 = _id_271667045665E514::lootchopper_initcircleinfo(circlecenter, circleradius);
    _id_271667045665E514::lootchopper_initspawninfo(_id_ED09715E306A1455);
  }

  _id_35039A9883AB69D2 = getdvarint("dvar_0648FB12CEBA1403", 8000);

  if(level.mapname == "mp_br_mechanics")
    _id_35039A9883AB69D2 = 1000;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7A5DADB6081D4303; _id_AC0E594AC96AA3A8++) {
    patrolzone = undefined;

    if(isDefined(level.pe_chopper_zones))
      patrolzone = level.pe_chopper_zones[_id_AC0E594AC96AA3A8];
    else {
      _id_32B962C704FDE3E7 = _id_AC0E594AC96AA3A8 % 4 + 1;
      patrolzone = _id_271667045665E514::lootchopper_findunoccupiedpatrolzone(level.loot_chopper_spawns["quad_" + _id_32B962C704FDE3E7], _id_35039A9883AB69D2);
    }

    _id_51ABC28B8D72CF10 = _id_271667045665E514::lootchopper_spawn(patrolzone, scripts\engine\utility::ter_op(istrue(level._id_A83A4E71446BFEF7), "veh9_mil_air_heli_hind_nophysics_br", "veh_chopper_support_pe_mp"));

    if(isDefined(_id_51ABC28B8D72CF10)) {
      _id_51ABC28B8D72CF10.lootfunc = ::dropcrate;
      _id_51ABC28B8D72CF10.flaresreservecount = getdvarint("dvar_F572ACB2A1F29288", 0);
      _id_51ABC28B8D72CF10.health = getdvarint("dvar_51CD58C60B7DEF3B", 3000);
      _id_51ABC28B8D72CF10.maxhealth = getdvarint("dvar_51CD58C60B7DEF3B", 3000);

      if(self.helilifetime)
        _id_51ABC28B8D72CF10.lifetime = self.helilifetime;

      scripts\mp\objidpoolmanager::update_objective_icon(_id_51ABC28B8D72CF10.objectiveiconid, "hud_icon_minimap_vehicle_heli_blima");
      scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(_id_51ABC28B8D72CF10.objectiveiconid, &"VEHICLES/LOOT_CHOPPER");
      scripts\mp\objidpoolmanager::update_objective_setbackground(_id_51ABC28B8D72CF10.objectiveiconid, 11);
      _id_51ABC28B8D72CF10._id_7B5E5C2BBC8F9F79 = _id_51ABC28B8D72CF10.objectiveiconid;
      _id_51ABC28B8D72CF10 _meth_1CD1EE312FD03BB4(1);
      _id_51ABC28B8D72CF10 setscriptablepartstate("objective", "hidden");
    }

    wait 1;
  }

  _id_BCC3BC0329135935 = getdvarfloat("dvar_9EF34944BAABA114", 10.0);
  level.br_pe_chopper_damage_time = gettime() + int(_id_BCC3BC0329135935 * 1000.0);
}

dropcrate() {
  _id_76A22C18960F72AF = _id_271667045665E514::lootchopper_finddroplocation(self.origin + (0, 0, 500));

  if(isDefined(_id_76A22C18960F72AF)) {
    _id_0E38F5EC33ED2CB0 = scripts\cp_mp\killstreaks\airdrop::dropbrlootchoppercrateforpublicevent(self.origin, _id_76A22C18960F72AF);
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(_id_0E38F5EC33ED2CB0);
    _id_EF5D5141FDB51174.usetimeoverride = 10;

    if(!isDefined(level.br_pe_chopper_crates))
      level.br_pe_chopper_crates = [];

    level.br_pe_chopper_crates[level.br_pe_chopper_crates.size] = _id_0E38F5EC33ED2CB0;
  }
}

oncrateuse(player) {
  self.itemsdropped = 0;

  if(!isDefined(level.br_pe_chopper_crate_index))
    level.br_pe_chopper_crate_index = 0;
  else
    level.br_pe_chopper_crate_index = (level.br_pe_chopper_crate_index + 1) % 10;

  items = getscriptcachecontents("pe_chopper_crate", level.br_pe_chopper_crate_index);

  if(isDefined(items) && player scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance"))
    items = _id_552B8E4EA5FF7DF1::lootcontentsadjustkillchain(items, player);

  if(isDefined(items))
    _id_E05413A53B5D9167 = _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 0, player);

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder")
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_70E5DE61CFAA916B");
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(!isDefined(level.br_pe_chopper_damage_time) || gettime() < level.br_pe_chopper_damage_time) {
    return;
  }
  _id_C4C191BEFB977DB0 = getdvarfloat("dvar_A8E8E154BAF8B969", 500.0);
  _id_96B0FFDC6A2B8E6F = 240.0;
  helis = level.loot_choppers;

  if(isDefined(helis)) {
    helis = scripts\engine\utility::array_removeundefined(helis);

    foreach(heli in helis) {
      _id_13D5B2AC0E7C768B = 0;
      _id_6F3A90A6B2B8799D = heli.origin;
      _id_24135B85B8E536B8 = distance2d(_id_819EDACDACB810E4, _id_6F3A90A6B2B8799D);

      if(_id_24135B85B8E536B8 + _id_96B0FFDC6A2B8E6F > _id_E86632D645C137D0)
        _id_13D5B2AC0E7C768B = 1;

      if(_id_13D5B2AC0E7C768B) {
        _id_6DA37E0E07826838 = heli.health;
        maxhealth = heli.maxhealth;
        heli dodamage(_id_C4C191BEFB977DB0, _id_6F3A90A6B2B8799D, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }

  _id_94A346917FF9B52F = getdvarfloat("dvar_D6D1181CD67D957D", 1000.0);
  crates = level.br_pe_chopper_crates;

  if(isDefined(crates)) {
    crates = scripts\engine\utility::array_removeundefined(crates);

    foreach(crate in crates) {
      _id_E2F2BF8AB2D5EBEF = distance2dsquared(crate.origin, _id_819EDACDACB810E4);
      _id_EE54DA4D2E801049 = max(0, _id_E86632D645C137D0 + _id_94A346917FF9B52F);

      if(_id_E2F2BF8AB2D5EBEF > _id_EE54DA4D2E801049 * _id_EE54DA4D2E801049)
        crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }
}

calculatehelispawndata(_id_7A5DADB6081D4303) {
  level endon("game_ended");

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return;
  }
  circlecenter = _id_2695A20D4011076D::getdangercircleorigin();
  circleradius = _id_2695A20D4011076D::getdangercircleradius();
  _id_8970EF161276A714 = 0.3;
  _id_1848FFDBD8A2E93E = 0.8;
  _id_5D186451F21D7020 = circleradius * _id_8970EF161276A714;
  maxrange = circleradius * _id_1848FFDBD8A2E93E;
  [_id_183D5EEC52A67366, _id_3C5DF5BF59ED9678] = findminmaxangleovertime(circlecenter, _id_5D186451F21D7020, maxrange);

  if(_id_183D5EEC52A67366 == _id_3C5DF5BF59ED9678) {
    return;
  }
  if(_id_183D5EEC52A67366 != 0.0 || _id_3C5DF5BF59ED9678 != 360.0) {
    _id_183D5EEC52A67366 = _id_183D5EEC52A67366 + 20.0;
    _id_3C5DF5BF59ED9678 = _id_3C5DF5BF59ED9678 - 20.0;

    if(_id_3C5DF5BF59ED9678 <= _id_183D5EEC52A67366)
      return;
  } else {
    _id_DEE36AD33D9E9755 = randomfloatrange(0.0, 360.0);
    _id_183D5EEC52A67366 = _id_183D5EEC52A67366 + _id_DEE36AD33D9E9755;
    _id_3C5DF5BF59ED9678 = _id_3C5DF5BF59ED9678 + _id_DEE36AD33D9E9755;
  }

  _id_D4F701560EE8C241 = (_id_3C5DF5BF59ED9678 - _id_183D5EEC52A67366) / max(1.0, _id_7A5DADB6081D4303 - 1);
  level.pe_chopper_zones = [];

  for(_id_4AD9EC5075055058 = 0; _id_4AD9EC5075055058 < _id_7A5DADB6081D4303; _id_4AD9EC5075055058++) {
    _id_B462E2FC8C0AF4F7 = _id_183D5EEC52A67366 + _id_D4F701560EE8C241 * _id_4AD9EC5075055058;
    _id_FCE68BFCC1305446 = anglesToForward((0.0, _id_B462E2FC8C0AF4F7, 0.0));
    _id_10739FB6C68C8B21 = randomfloatrange(_id_5D186451F21D7020, maxrange);
    _id_59E351E865CCBA66 = circlecenter + _id_FCE68BFCC1305446 * _id_10739FB6C68C8B21;

    if(isnavmeshloaded())
      _id_59E351E865CCBA66 = getclosestpointonnavmesh(_id_59E351E865CCBA66);

    _id_517C110706561D2F = spawnStruct();
    _id_517C110706561D2F.origin = _id_59E351E865CCBA66;
    level.pe_chopper_zones[_id_4AD9EC5075055058] = _id_517C110706561D2F;
  }
}

findminmaxangleovertime(circlecenter, _id_5D186451F21D7020, maxrange) {
  level endon("game_ended");
  _id_C473BEC43FE7F606 = level.mapcenter - circlecenter;
  _id_C473BEC43FE7F606 = (_id_C473BEC43FE7F606[0], _id_C473BEC43FE7F606[1], 0.0);
  _id_C473BEC43FE7F606 = vectorNormalize(_id_C473BEC43FE7F606);
  _id_7BF015C40AC296B7 = vectortoyaw(_id_C473BEC43FE7F606);
  _id_1DEDB65EB8B4CFC6 = circlecenter + _id_C473BEC43FE7F606 * _id_5D186451F21D7020;
  _id_1E10C85EB8DB3F14 = circlecenter + _id_C473BEC43FE7F606 * maxrange;
  _id_68037475D59ABAA0 = !scripts\mp\outofbounds::ispointinoutofbounds(_id_1DEDB65EB8B4CFC6) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_1E10C85EB8DB3F14);

  if(!_id_68037475D59ABAA0)
    return [0.0, 0.0];

  _id_D1B3A6AAAE2C18E1 = 45.0;
  _id_272E9DCD354E502A = 45.0;
  _id_DA21DB3F5D1FCF57 = _id_7BF015C40AC296B7;
  _id_E7B8FE64CD569F72 = _id_7BF015C40AC296B7 + _id_D1B3A6AAAE2C18E1;
  _id_BA526B477F9C97F6 = _id_7BF015C40AC296B7;
  _id_3C634C6AD0BCECFB = _id_7BF015C40AC296B7 - _id_272E9DCD354E502A;
  _id_5D511DFB0DA42511 = 0;
  _id_B824BC967D25C7BA = 180 / int(_id_D1B3A6AAAE2C18E1);
  _id_BC9D9453C5E0620C = 0;
  _id_12030CE1E85C94A8 = 1.0;

  for(;;) {
    if(_id_D1B3A6AAAE2C18E1 >= _id_12030CE1E85C94A8) {
      _id_FD4F35F18AEE7B46 = anglesToForward((0.0, _id_E7B8FE64CD569F72, 0.0));
      _id_4086ED7C12722006 = circlecenter + _id_FD4F35F18AEE7B46 * _id_5D186451F21D7020;
      _id_40A9FF7C12988F54 = circlecenter + _id_FD4F35F18AEE7B46 * maxrange;
      _id_BFDD77649EA019E0 = !scripts\mp\outofbounds::ispointinoutofbounds(_id_4086ED7C12722006) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_40A9FF7C12988F54);

      if(_id_BFDD77649EA019E0) {
        _id_DA21DB3F5D1FCF57 = _id_E7B8FE64CD569F72;
        _id_E7B8FE64CD569F72 = _id_DA21DB3F5D1FCF57 + _id_D1B3A6AAAE2C18E1;
      } else {
        _id_BC9D9453C5E0620C = 1;
        _id_D1B3A6AAAE2C18E1 = _id_D1B3A6AAAE2C18E1 * 0.5;
        _id_E7B8FE64CD569F72 = _id_DA21DB3F5D1FCF57 + _id_D1B3A6AAAE2C18E1;
      }
    }

    if(_id_272E9DCD354E502A >= _id_12030CE1E85C94A8) {
      _id_6F0E7A5743E7A561 = anglesToForward((0.0, _id_3C634C6AD0BCECFB, 0.0));
      _id_309AC60E318FE157 = circlecenter + _id_6F0E7A5743E7A561 * _id_5D186451F21D7020;
      _id_30BDD40E31B647D9 = circlecenter + _id_6F0E7A5743E7A561 * maxrange;
      _id_D132BF554650B07F = !scripts\mp\outofbounds::ispointinoutofbounds(_id_309AC60E318FE157) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_30BDD40E31B647D9);

      if(_id_D132BF554650B07F) {
        _id_BA526B477F9C97F6 = _id_3C634C6AD0BCECFB;
        _id_3C634C6AD0BCECFB = _id_BA526B477F9C97F6 - _id_272E9DCD354E502A;
      } else {
        _id_BC9D9453C5E0620C = 1;
        _id_272E9DCD354E502A = _id_272E9DCD354E502A * 0.5;
        _id_3C634C6AD0BCECFB = _id_BA526B477F9C97F6 - _id_272E9DCD354E502A;
      }
    }

    if(!_id_BC9D9453C5E0620C) {
      _id_5D511DFB0DA42511++;

      if(_id_5D511DFB0DA42511 >= _id_B824BC967D25C7BA)
        return [0.0, 360.0];
    }

    if(_id_D1B3A6AAAE2C18E1 < _id_12030CE1E85C94A8 && _id_272E9DCD354E502A < _id_12030CE1E85C94A8)
      return [_id_BA526B477F9C97F6, _id_DA21DB3F5D1FCF57];

    waitframe();
  }
}