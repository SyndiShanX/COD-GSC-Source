/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5c607ef7f46f361.gsc
***********************************************/

main() {
  _id_09FAB40ED3326F8B = scripts\engine\utility::ter_op(scripts\mp\utility\game::getsubgametype() == "dmz", "mp/subarea_tuning_mp_sealion.csv", "mp/subarea_tuning_mp_sealion_br.csv");
  level._id_4D8386ECA283E9C4 = "sealion_";
  level._id_09FAB40ED3326F8B = getDvar("dvar_5AED4C98C67B3AF0", _id_09FAB40ED3326F8B);
  level thread _id_5DEF7AF2A9F04234::_id_C08668FE290FC31A();
  _id_73E95DA15C40F0C8::main();
  _id_360BD660B11B2242::main();
  _id_3F5C1D94B8A64D58::main();
  level thread _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("ai_rusher");
  level thread _id_5136472FC0AACC17();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    scripts\common\create_script_utility::initialize_create_script();
    level._id_B32E30F2A469BC5C = ::_id_96B081373B38AE54;
    level._id_D628E0583DB7209E = [];
    level._id_20B5AB3069C073E2 = ::_id_842BCF9C1948E5C7;

    if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      scripts\cp_mp\utility\script_utility::registersharedfunc("dmz_threat_bias", "customNationality", ::_id_90ABDBF9EE65BB1B);
      scripts\cp_mp\utility\script_utility::registersharedfunc("threat_bias", "customFriendlyCheck", ::_id_50848C14636B3377);
      level._id_BBD8A18655D9495B = _id_147448F3F080C636::_id_405BF7CDE917B70E;
      level._id_F29702DDC09D1002 = _id_147448F3F080C636::_id_384465A3A8AA24F7;
      level._id_0FFA48A6A79A7224 = _id_147448F3F080C636::_id_47C84E03DCBC5AA7;
      level._id_A422458EC66A5DFB = ::_id_50D3A34C9A0D882F;
      level._id_2CDF30478FA435FF[0] = (4201, 6905, 627);
      level._id_2CDF30478FA435FF[1] = (4048, -10515, 675);
      level._id_2CDF30478FA435FF[2] = (-5156, -11796, 519);
      level._id_2CDF30478FA435FF[3] = (-10713, 1973, 468);
      level thread _id_951EA748B66156B5();
      level thread _id_61CAC07112E3283A();
      level thread _id_D3C9137FF1EF2963();
      level._id_D628E0583DB7209E["veh9_pwc"] = getdvarfloat("dvar_997A0F390F5B7238", 0.75);
      level._id_D628E0583DB7209E["atv"] = getdvarfloat("dvar_4096BACF26AF7924", 0.75);
      level._id_D628E0583DB7209E["veh9_suv_1996"] = getdvarfloat("dvar_3830C6572FED780F", 0.5);
      level._id_D628E0583DB7209E["veh9_rhib"] = getdvarfloat("dvar_7AD2D2A502E96F5E", 0.5);
      scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_jltv_mg");
      scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_jltv");
      scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_palfa");
      _id_36967CE8EE2EA745::main();
      _id_49314540C657D352::main();
      _id_255133686F2D76C0::main();
    } else {
      if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
        level.brgametype._id_B024F80FC9886FC4 = (-876, -3841, 0);
        level.brgametype._id_92FCC390C4C0ACD7 = 5000;
      }

      _id_283E1E9E47346FDC::_id_F46A4DEEFD8CEAF4(getEnt("power_switch_room", "targetname"));
      level._id_D628E0583DB7209E["veh9_pwc"] = getdvarfloat("dvar_997A0F390F5B7238", 0.5);
    }

    level._id_4B195D3DD0024B9C = "team_hundred_ninety_nine";
  }

  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("nvg_base_mp_sealion");
  thread _id_3394DEA421F7FEB2();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    brinit();
    _id_4FF6C6ED304E05BB::init();

    if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      _id_4480C6CE37B2BDF3::_id_DD432354AF4C9024();
      _func_EB7F544259415A09(level.mapname + "_dmz");
      scripts\cp_mp\tripwire::init();
      _id_60E3273DF6B5F7D1::init();
      _id_72D6AF97CFC97305::init();
      level._id_359D1318419A254D = 1;
    } else {
      level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
      _func_EB7F544259415A09(level.mapname);
    }

    level._id_97206D739FA94A0E = getEnt("bunker_door_0", "targetname");

    if(isDefined(level._id_97206D739FA94A0E)) {
      level._id_97206D739FA94A0E thread initbunkerdoor();
      level._id_02C538F6D4759CA0 = _func_F159C10D5CF8F0B4("bunker_door_trigger", "targetname")[0];

      if(isDefined(level._id_02C538F6D4759CA0))
        level._id_02C538F6D4759CA0 thread _id_403C1A942003B804();

      level._id_0616C0E7CE8A90EA = _func_F159C10D5CF8F0B4("bunker_door_fallback_trigger", "targetname")[0];

      if(isDefined(level._id_0616C0E7CE8A90EA))
        level._id_0616C0E7CE8A90EA thread _id_FA33CC3D2C446C26();
    }

    level.outofboundstriggersplanetrace = getEntArray("OutOfBounds", "targetname");

    if(istrue(level._id_289DF80E1DED586F)) {
      level._id_E429F4A597493802 = [];
      level._id_E429F4A597493802[0] = "star_0_sealion";
      level._id_E429F4A597493802[1] = "star_1_sealion";
      level._id_E429F4A597493802[2] = "star_2_sealion";
      level._id_E429F4A597493802[3] = "star_3_sealion";
      level._id_E429F4A597493802[4] = "star_4_sealion";
      level._id_3EED4E0BC4A30B72 = "br_sealion_aieventlist";
      level._id_37DAFE68077318F5 = getdvarfloat("dvar_0737EFF8009D7396", 0.6);
      level thread _id_48814951E916AF89::_id_C8393014DD7F8AB6();
    }
  }

  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_sealion");
  scripts\cp_mp\utility\game_utility::_id_743719859FBAB899();
  setDvar("fd_helicopter_altitude_limiter", 4500);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("cg_defaultWindFrequencyScale", 0.34);
  setDvar("cg_defaultWindAmplitudeScale", 1.5);
  setDvar("cg_defaultWindAreaScale", 50);
  setDvar("cg_defaultWindNoiseScale", 0.2);
  setDvar("cg_defaultWindStrength", 1);
  setDvar("cg_defaultWindDir", (0.3, -1, 0));
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_B2F8F087CEB71FEA();
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (4070, 8265, 561));
  _id_45428B56EF07EA91 setModel("barrier_traffic_concrete_block_clean_w2_c1s2");
  _id_45428B56EF07EA91.angles = (360, 235.55, 0.38);
}

brinit() {
  _id_362C58E8BB39BCDA::enablefeature("circleSnapToNavMesh");
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  level.onlowpopstart = ::_id_0865DD7703C23C87;
  level thread _id_EF079EE3D6B651AD();
  level.br_level = spawnStruct();
  _id_45B2B4A889E633FA::setc130heightoverrides(8500);
  level.br_level.c130_speedoverride = 2500;
  level.br_level.br_corners = [];
  level.br_level.br_corners[0] = (24000, -24000, 200);
  level.br_level.br_corners[1] = (-24000, 24000, 200);
  _id_3C590D0EE220B409 = min(level.br_level.br_corners[0][0], level.br_level.br_corners[1][0]);
  _id_C978C90E8E5AB1F7 = max(level.br_level.br_corners[0][0], level.br_level.br_corners[1][0]);
  _id_3C590C0EE220B1D6 = min(level.br_level.br_corners[1][1], level.br_level.br_corners[0][1]);
  _id_C978C80E8E5AAFC4 = max(level.br_level.br_corners[1][1], level.br_level.br_corners[0][1]);
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  _id_3C590D0EE220B409 = level.br_level.br_corners[0][0] * 0.95;
  _id_C978C90E8E5AB1F7 = level.br_level.br_corners[1][0] * 0.95;
  _id_3C590C0EE220B1D6 = level.br_level.br_corners[0][1] * 0.95;
  _id_C978C80E8E5AAFC4 = level.br_level.br_corners[1][1] * 0.95;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  _id_33DD915945FCA005 = scripts\cp_mp\parachute::getc130sealevel();
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(_id_FDFE2D4AAF8EC33D - _id_33DD915945FCA005));
  level.br_badcircleareas = [];
  _id_50EDE48DCFBB0D68 = scripts\engine\utility::getStructArray("bad_circle", "targetname");

  foreach(struct in _id_50EDE48DCFBB0D68)
  level.br_badcircleareas[level.br_badcircleareas.size] = _id_2695A20D4011076D::createinvalidcirclearea(struct.origin, struct.radius);

  if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    level.br_level.br_circleclosetimes = [1, 200, 130, 90, 50, 100];
    level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0, 0];
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [7500, 6500, 6000, 5000, 3000, 1250, 500, 250];
    level.br_level.br_circleradii = [10000, 8000, 6500, 4500, 3000, 1250, 500, 250, 0];
  } else {
    level.br_level.br_circleclosetimes = [110, 90, 75, 75, 120];
    level.br_level.br_circledelaytimes = [150, 110, 75, 60, 0];
    level.br_level.br_circleshowdelaydanger = [60, 0, 0, 0, 0];
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [7500, 6500, 5500, 5000, 4500];
    level.br_level.br_circleradii = [22000, 15000, 9000, 4500, 1500, 0];
  }

  if(isDefined(level.br_circle_init_func))
    [[level.br_circle_init_func]]();

  _id_2695A20D4011076D::applycirclesettings();
  level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((4251, 5491, 827), 0, 1000), _id_1E4A61DB11011446::createspawnlocation((3817, 1226, 446), 0, 1000), _id_1E4A61DB11011446::createspawnlocation((-3412, 955, 625), 0, 1000), _id_1E4A61DB11011446::createspawnlocation((-11785, 1490, 457), 0, 1000), _id_1E4A61DB11011446::createspawnlocation((-7948, -8166, 588), 0, 1000), _id_1E4A61DB11011446::createspawnlocation((-1181, -6590, 1277), 0, 1000), _id_1E4A61DB11011446::createspawnlocation((5077, -7601, 826), 0, 1000)];
}

_id_0865DD7703C23C87() {
  if(!_id_1E4A61DB11011446::lowpopallowtweaks()) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    level.br_level.br_circleradii = [57000, 27500, 12500, 6500, 3000, 1250, 500, 250, 0];
    level.br_level.br_circleclosetimes = [1, 190, 120, 80, 40, 90];
    level.br_level.br_circledelaytimes = [1, 110, 65, 50, 35, 0];
  } else {
    level.br_level.br_circleradii = [81000, 50000, 30000, 15000, 7500, 3750, 1500, 500, 0];
    level.br_level.br_circleclosetimes = [270, 180, 150, 60, 60, 45, 90];
    level.br_level.br_circledelaytimes = [210, 60, 60, 60, 45, 30, 0];
  }

  _id_2695A20D4011076D::applycirclesettings();
}

_id_EF079EE3D6B651AD() {
  if(getdvarint("dvar_6979A78A1820AC18", 0) != 0) {
    return;
  }
  level waittill("prematch_fade_done");

  while(!isDefined(level.br_ac130))
    wait 0.1;

  _id_90416D079805B8A5 = level.br_ac130.angles;
  _id_90416D079805B8A5 = _id_90416D079805B8A5 + (0, -90, 0);
  level.name_fx = [];
  _id_FD2DBEAE371F9614("castle", (-1262, -5786, 2000), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("port", (-10280.3, -9252, 700), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("beachclub", (-10745, 1987, 700), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("towncenter", (-979, 2803, 800), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("greenhouses", (4300, 5100, 700), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("shipwreck", (-391, -15169, 700), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("residential", (5490, -8980, 750), _id_90416D079805B8A5);
  level thread _id_5ADC69197DE334C3();
}

_id_FD2DBEAE371F9614(scriptablestate, loc, _id_90416D079805B8A5) {
  level thread _id_6482FEB0B7568914(scriptablestate, loc, _id_90416D079805B8A5, "name_fx");
}

_id_6482FEB0B7568914(scriptablestate, loc, _id_90416D079805B8A5, _id_8A46C62F0A756DD3) {
  loc = loc + (0, 0, 500);
  _id_B243306D75CC8719 = spawn("script_model", loc);
  _id_B243306D75CC8719 setModel("iw9_tag_origin_name_fx_sealion");
  _id_B243306D75CC8719.angles = _id_90416D079805B8A5;
  level.name_fx[level.name_fx.size] = _id_B243306D75CC8719;
  _id_B243306D75CC8719 setscriptablepartstate(_id_8A46C62F0A756DD3, scriptablestate + "_jp");
  _id_B243306D75CC8719 forcenetfieldhighlod(1);
  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  wait(randomfloatrange(2.5, 5));
  _id_B243306D75CC8719 setscriptablepartstate(_id_8A46C62F0A756DD3, scriptablestate);
}

_id_5ADC69197DE334C3() {
  level thread _id_6A0DECC2D8FFCAAE();

  while(isDefined(level.br_ac130))
    wait 0.1;

  wait 90;
  level notify("stop_fx_hide_func");

  foreach(_id_F7806D4CF24AACD3 in level.name_fx)
  _id_F7806D4CF24AACD3 delete();
}

_id_6A0DECC2D8FFCAAE() {
  level endon("game_ended");
  level endon("stop_fx_hide_func");
  _id_AF6D3CFEC354E8E9 = 10;
  _id_ACACF8EF0144C237 = 0.25;

  while(level.name_fx.size > 0) {
    _id_2A29B237DCC66FE5 = level.players;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2A29B237DCC66FE5.size; _id_AC0E594AC96AA3A8++) {
      _id_C78BBC68C93BF91B = _id_2A29B237DCC66FE5[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_C78BBC68C93BF91B) && isalive(_id_C78BBC68C93BF91B)) {
        if(isDefined(_id_C78BBC68C93BF91B.vehicle)) {
          for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.name_fx.size; _id_AC0E5C4AC96AAA41++)
            level.name_fx[_id_AC0E5C4AC96AAA41] hidefromplayer(_id_C78BBC68C93BF91B);
        }
      }

      if(_id_AC0E594AC96AA3A8 % _id_AF6D3CFEC354E8E9 == 0)
        wait(_id_ACACF8EF0144C237);
    }

    wait 0.1;
  }
}

_id_90ABDBF9EE65BB1B() {
  level._id_97718BB0CB314F6B = "ru";
  level._id_5D6209C724CFEAC7 = [];
  level._id_5D6209C724CFEAC7["merc"] = "merc";

  foreach(group in level._id_5D6209C724CFEAC7)
  _id_371B4C2AB5861E62::_id_841F001AE930B5E4(group);

  _id_371B4C2AB5861E62::_id_3ACCE87FED325C8F("player_hs1_sc1", "merc");
  _id_371B4C2AB5861E62::_id_3ACCE87FED325C8F("player_hs0_sc1", "merc");
}

_id_50848C14636B3377(agent, attacker, inflictor, meansofdeath) {
  if(!isDefined(level._id_A3DE977788317EF5))
    level._id_A3DE977788317EF5 = getdvarint("dvar_EC07295B05C0FE7B", 10);

  if(!isDefined(level._id_BBB5285E897EB251))
    level._id_BBB5285E897EB251 = getdvarint("dvar_9980CB6476B5A87E", 3);

  if(!isDefined(attacker))
    return 0;

  _id_8E9C295AFDD8B10E = attacker scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(!isPlayer(attacker) && !_id_8E9C295AFDD8B10E)
    return 0;

  vehicle = undefined;

  if(_id_8E9C295AFDD8B10E) {
    vehicle = attacker;
    attacker = attacker.owner;
  }

  if(isDefined(attacker._id_97BEFA07A2CF366E) && istrue(attacker._id_97BEFA07A2CF366E[agent.threatbiasgroup]))
    return 0;

  _id_BB5F8AACF8D1F56A = agent getthreatbiasgroup();
  isenemy = 0;
  _id_869946FB307D9B67 = _id_371B4C2AB5861E62::_id_1BCA33010B895B0B(_id_BB5F8AACF8D1F56A);

  if(isDefined(_id_869946FB307D9B67))
    isenemy = !_id_371B4C2AB5861E62::_id_46C0DE7595D8CAB2(attacker, _id_869946FB307D9B67);

  if(istrue(isenemy))
    return 0;

  if(_id_BB5F8AACF8D1F56A == "merc" && (isPlayer(attacker) || isDefined(inflictor) && isDefined(inflictor.owner) && isPlayer(inflictor.owner))) {
    if(!isDefined(attacker._id_C669906A542B9BAF))
      attacker._id_C669906A542B9BAF = [];

    if(_id_8E9C295AFDD8B10E) {
      if(!isDefined(attacker._id_1C5968F343BD7C04))
        attacker._id_1C5968F343BD7C04 = [];

      entnum = vehicle getentitynumber();

      if(isDefined(attacker._id_1C5968F343BD7C04[entnum])) {
        if(attacker._id_1C5968F343BD7C04[entnum] + 1000 > gettime())
          return 0;
      }

      attacker._id_1C5968F343BD7C04[entnum] = gettime();
    }

    if(!isDefined(attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A]))
      attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A] = 0;

    if(isDefined(vehicle)) {
      if(attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A] < level._id_BBB5285E897EB251)
        attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A] = level._id_BBB5285E897EB251;
      else if(attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A] < level._id_A3DE977788317EF5)
        attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A] = level._id_A3DE977788317EF5;
    } else
      attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A]++;

    _id_4480C6CE37B2BDF3::_id_39ACEB03C0AACE46(attacker, meansofdeath);

    if(isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION")
      return 0;

    return 1;
  }

  return 0;
}

_id_96B081373B38AE54() {
  if(getdvarint("dvar_2FDA550AD7EC197F", 1) != 0) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("dmzWar", "poiNameFixer", ::_id_DF7EEDCD28DED71E);
    _id_4480C6CE37B2BDF3::_id_B71560B07A8F979D("sealion");
  }

  level thread _id_1E7F5DCAA502938C::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_apartments"))
    level thread _id_746F3EFF2FCDD880::main();
  else
    level thread _id_4E279FEA4D6DDAD3::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_beachclub"))
    level thread _id_14A57F2D4BF1E394::main();
  else
    level thread _id_3EBEBA9723F8DBA7::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_castle"))
    level thread _id_26BAAA540CC0989D::main();
  else
    level thread _id_5C3EBEC1FD1AE912::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_coastalruins"))
    level thread _id_46FB43D4266BAF47::main();
  else
    level thread _id_683F511E5FE06D68::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_port"))
    level thread _id_5BEC9638BE418D34::main();
  else
    level thread _id_6994F37A9978DD87::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_culdesac"))
    level thread _id_59615002D09DC77F::main();
  else
    level thread _id_706B690F643A88D0::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_powerplant"))
    level thread _id_1733783FC7BF4013::main();
  else
    level thread _id_69940BC9EF91BD84::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_residential"))
    level thread _id_6085EAE98ADC8AA3::main();
  else
    level thread _id_00F5FC52B0B31534::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_shipwreck"))
    level thread _id_135B899AE934A6AD::main();
  else
    level thread _id_379A591CE9760302::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_towncenter"))
    level thread _id_592B8BF57A2FDD92::main();
  else
    level thread _id_423811210BA04D71::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_watertreatment"))
    level thread _id_61F2CF526471C926::main();
  else
    level thread _id_4A69CDA079FAD885::main();

  if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("sealion_waterways"))
    level thread _id_5C27DFED43573EF8::main();
  else
    level thread _id_2AF9DCC1EBB9F2DB::main();

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_4480C6CE37B2BDF3::_id_A1E18F290954A5E9();

  level thread _id_14341CB49A502683::main();
  level thread _id_7EE706D27BE1F7BA::main();
}

#using_animtree("animated_props");

initbunkerdoor() {
  parts = getEntArray(self.target, "targetname");

  foreach(part in parts) {
    if(part.script_noteworthy == "right_door_clip") {
      self.clipleft = part;
      self.clipleft setnonstick(1);
      self.clipleft disconnectPaths();
      continue;
    }

    if(part.script_noteworthy == "left_door_clip") {
      self.clipright = part;
      self.clipright setnonstick(1);
      self.clipright disconnectPaths();
    }
  }

  level._id_0FBC38B58F590C7B = getdvarint("dvar_0D19106A9CB51AC1", 30);
  wait 10;
  level.scr_animtree["sealion_bunker_door"] = #animtree;
  level.scr_anim["sealion_bunker_door"]["door_open"] = % mp_bunker_door_01_open;
  level.scr_animname["sealion_bunker_door"]["door_open"] = "mp_bunker_door_01_open";
  self.animname = "sealion_bunker_door";
  scripts\common\anim::setanimtree();

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    level waittill("prematch_fade_done");

  if(getdvarint("dvar_BB8B27FA4E5299D6", 1)) {
    _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_lege", (-1004, -5366, 340), (0, 135, 0));
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
    _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_lege", (-966, -6002, 340), (0, 45, 0));
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
    _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_lege", (-1188, -5568, 340), (0, 225, 0));
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
  }
}

_id_403C1A942003B804() {
  level endon("game_ended");
  level endon("bunker_opening_fallback");
  level waittill("prematch_fade_done");
  wait 5.0;
  self waittill("trigger");
  wait(level._id_0FBC38B58F590C7B);
  level notify("bunker_opening_timer");
  openbunkerdoor();
}

_id_FA33CC3D2C446C26() {
  level endon("game_ended");
  level endon("bunker_opening_timer");
  level waittill("prematch_fade_done");
  wait 5.0;
  self waittill("trigger");
  level notify("bunker_opening_fallback");
  openbunkerdoor();
}

openbunkerdoor() {
  if(isDefined(level._id_97206D739FA94A0E)) {
    level._id_97206D739FA94A0E thread scripts\common\anim::anim_single_solo(level._id_97206D739FA94A0E, "door_open");

    if(soundexists("br_bunker_door_open_01"))
      level._id_97206D739FA94A0E playSound("br_bunker_door_open_01");

    _id_C8767A772842D047 = 130;
    animlength = getanimlength(level.scr_anim["sealion_bunker_door"]["door_open"]);
    _id_413561A0123AAA35 = 0.1;
    wait 3.5;
    _id_5EEBFE6D294222C8 = 2;
    _id_C53E5552CCFCBC2D = _id_C8767A772842D047 / ((animlength - _id_5EEBFE6D294222C8) / _id_413561A0123AAA35);
    _id_D1B3A6AAAE2C18E1 = anglestoleft(level._id_97206D739FA94A0E.angles) * _id_C53E5552CCFCBC2D;
    _id_272E9DCD354E502A = anglestoleft(level._id_97206D739FA94A0E.angles) * _id_C53E5552CCFCBC2D * -1;
    _id_03572E193DBCA166 = _id_5EEBFE6D294222C8;

    while(_id_03572E193DBCA166 < animlength) {
      if(isDefined(level._id_97206D739FA94A0E.clipleft))
        level._id_97206D739FA94A0E.clipleft.origin = level._id_97206D739FA94A0E.clipleft.origin + _id_D1B3A6AAAE2C18E1;

      if(isDefined(level._id_97206D739FA94A0E.clipright))
        level._id_97206D739FA94A0E.clipright.origin = level._id_97206D739FA94A0E.clipright.origin + _id_272E9DCD354E502A;

      _id_03572E193DBCA166 = _id_03572E193DBCA166 + _id_413561A0123AAA35;
      wait(_id_413561A0123AAA35);
    }

    if(soundexists("br_bunker_door_open_02"))
      level._id_97206D739FA94A0E playSound("br_bunker_door_open_02");

    level._id_97206D739FA94A0E.clipleft connectpaths();
    level._id_97206D739FA94A0E.clipright connectpaths();
    waitframe();
    level._id_97206D739FA94A0E.clipleft delete();
    level._id_97206D739FA94A0E.clipright delete();
  }
}

_id_5136472FC0AACC17() {
  if(getdvarint("dvar_18032E89F0F1B405", 1))
    scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_650E9FC3913143DA);
  else {
    level waittill("scriptables_ready");

    foreach(scriptable in getentitylessscriptablearray("scriptable_scriptable_decor_standing_drum", "classname"))
    scriptable setscriptablepartstate("decor_standing_drum", "disabled");
  }
}

_id_650E9FC3913143DA(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isDefined(instance) || !isDefined(instance.classname) || instance.classname != "scriptable_scriptable_decor_standing_drum") {
    return;
  }
  if(!isDefined(smeansofdeath) || smeansofdeath != "MOD_MELEE") {
    return;
  }
  _id_55ECCE40C09913E2 = instance.origin + (0, 0, 60);
  _id_1330BB9A5254D545 = vectordot(vectorNormalize(shitloc - _id_55ECCE40C09913E2), anglesToForward(instance.angles));

  if(_id_1330BB9A5254D545 < -0.75 || _id_1330BB9A5254D545 > 0.75) {
    sfx = spawnscriptable("scriptable_decor_standing_drum_sfx", shitloc);
    waitframe();
    sfx freescriptable();
  }
}

_id_FE49303A869BABBE(dialog, _id_A64CAD1ECC519617, _id_F16321BA668D68F5, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060) {
  _id_2CEDCC356F1B9FC8::brleaderdialog(dialog, _id_A64CAD1ECC519617, _id_F16321BA668D68F5, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060, "dx_br_seal_");
}

_id_F676AFAFAF3764F2(dialog, team, _id_A64CAD1ECC519617, delay, _id_ABB7E1EA2ADCE060) {
  _id_2CEDCC356F1B9FC8::brleaderdialogteam(dialog, team, _id_A64CAD1ECC519617, delay, _id_ABB7E1EA2ADCE060, "dx_br_seal_");
}

_id_4E9ADC9D9FEB74EA(dialog, player, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060) {
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer(dialog, player, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060, "dx_br_seal_");
}

_id_467F8B6E641DC16C(rewards, origin, angles, _id_0AD3658A1088AF24, _id_A6293F3144240B99, _id_F0FA3B7B27926553, _id_7FAB0FE3F9477201, ammocount, _id_90C5EAB318BB00D2) {
  if(isDefined(_id_7FAB0FE3F9477201) && _id_7FAB0FE3F9477201) {
    _id_92D8A509637FB29B = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_90C5EAB318BB00D2.primaryweaponobj);

    if(!isDefined(_id_92D8A509637FB29B)) {
      _id_AC384A310FB79ED9 = randomint(5);
      _id_92D8A509637FB29B = _id_724736FCF0FB6604::_id_5A80DBA504420037(_id_AC384A310FB79ED9);
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ammocount; _id_AC0E594AC96AA3A8++)
      rewards[rewards.size] = _id_92D8A509637FB29B;

    rewards = scripts\engine\utility::array_randomize(rewards);
  }

  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  foreach(item in rewards) {
    if(_id_552B8E4EA5FF7DF1::canspawnitemname(item)) {
      _id_A69FFF5222862F26 = level.br_pickups.br_itemrarity[item];
      legendary = 0;

      if(isDefined(_id_A69FFF5222862F26) && _id_A69FFF5222862F26 == 4)
        legendary = 1;

      _id_552B8E4EA5FF7DF1::lootspawnitem(item, dropstruct, origin, angles, _id_A6293F3144240B99, legendary);
    }
  }

  if(isDefined(_id_F0FA3B7B27926553)) {
    eventname = _func_1823FF50BB28148D(_id_F0FA3B7B27926553);

    foreach(player in _id_0AD3658A1088AF24) {
      if(isDefined(player) && isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
        player thread scripts\mp\utility\points::_id_0366980B6A8796AE(eventname);
        player playsoundtoplayer("uin_loot_container_open_epic", player);
      }
    }
  }
}

_id_951EA748B66156B5() {
  waitframe();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("electrical_box", ::_id_979E4F1EA45FF70B);
  level._id_12177FADDACF1082 = [];
  _id_A51B0ADA96915F10 = scripts\engine\utility::getStructArray("dmz_electrical_box", "script_noteworthy");

  foreach(_id_6C6D7CD4100D9309 in _id_A51B0ADA96915F10) {
    scriptable = spawnscriptable("electrical_box", _id_6C6D7CD4100D9309.origin, _id_6C6D7CD4100D9309.angles);
    scriptable setscriptablepartstate("electrical_box", "on");
    scriptable._id_BD8B23E1F8028C20 = 1;
    level._id_12177FADDACF1082[level._id_12177FADDACF1082.size] = scriptable;
  }
}

_id_979E4F1EA45FF70B(scriptable, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  scriptable thread _id_CF3728BD7EF8FFB7();
}

_id_CF3728BD7EF8FFB7() {
  if(self getscriptablepartstate("electrical_box") == "on") {
    self setscriptablepartstate("electrical_box", scripts\engine\utility::ter_op(istrue(self._id_BD8B23E1F8028C20), "unusable_off", "off"));
    wait 0.5;
    self setscriptablepartstate("switch_sfx", "sfx_switch_off");
  } else {
    self setscriptablepartstate("electrical_box", scripts\engine\utility::ter_op(istrue(self._id_BD8B23E1F8028C20), "unusable_on", "on"));
    wait 0.5;
    self setscriptablepartstate("switch_sfx", "sfx_switch_on");
  }
}

_id_61CAC07112E3283A() {
  waitframe();
  _id_03F0A0DF20582182 = scripts\engine\utility::getStructArray("dmz_observation_gates", "targetname");

  foreach(_id_FAEDB78B180470AC in _id_03F0A0DF20582182) {
    scriptable = spawnscriptable("sealion_dmz_observation_gate", _id_FAEDB78B180470AC.origin, _id_FAEDB78B180470AC.angles);
    scriptable setscriptablepartstate("sealion_dmz_observation_gate", "visible");
  }
}

_id_D3C9137FF1EF2963() {
  waitframe();
  _id_F43B7749407E00DB = getscriptablearray("static_sam_site", "targetname");

  foreach(_id_FAC1DD2A5472BECE in _id_F43B7749407E00DB)
  _id_FAC1DD2A5472BECE setscriptablepartstate("sealion_static_sam_site", "hidden");
}

_id_842BCF9C1948E5C7(refname, _id_7A2113183150C910) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz" && refname == "veh9_patrol_boat") {
    foreach(_id_68683154739BEEC7 in _id_7A2113183150C910) {
      if(_id_68683154739BEEC7.origin != (-3856.5, -4979, 312)) {
        continue;
      }
      return [_id_68683154739BEEC7];
    }
  }

  if(isDefined(level._id_D628E0583DB7209E[refname])) {
    _id_D84B5261A4DEF29A = int(_id_7A2113183150C910.size * level._id_D628E0583DB7209E[refname]);
    _id_7A2113183150C910 = scripts\engine\utility::array_randomize(_id_7A2113183150C910);
    _id_7A2113183150C910 = scripts\engine\utility::array_slice(_id_7A2113183150C910, 0, _id_7A2113183150C910.size - _id_D84B5261A4DEF29A);
  }

  return _id_7A2113183150C910;
}

_id_870E3C2A791610F3(origin) {
  _id_D0F14661A27F60F4 = origin[0] >= level._id_2FF408BEB21CAFA6[0];
  _id_704960EB3F63E7F3 = origin[1] >= level._id_2FF408BEB21CAFA6[1];

  if(_id_D0F14661A27F60F4 > 0) {
    if(_id_704960EB3F63E7F3 > 0)
      return 0;
    else
      return 1;
  } else if(_id_704960EB3F63E7F3 > 0)
    return 2;
  else
    return 3;
}

_id_C5F5B2049D60C525(_id_B205D90302DA2F07) {
  _id_8FADA96E8B0CCC67 = [];

  switch (_id_B205D90302DA2F07) {
    case "sealion_apartments":
      _id_8FADA96E8B0CCC67[0] = (0.02, 0.25, 0);
      _id_8FADA96E8B0CCC67[1] = (0.5, 0.65, 0);
      _id_8FADA96E8B0CCC67[2] = (0.75, 0, 0);
      break;
    case "sealion_beachclub":
      _id_8FADA96E8B0CCC67[0] = (0.02, 0.13, 0);
      _id_8FADA96E8B0CCC67[1] = (0.28, 0.5, 0);
      _id_8FADA96E8B0CCC67[2] = (0.78, 0, 0);
      break;
    case "sealion_port":
      _id_8FADA96E8B0CCC67[0] = (0.02, 0.08, 0);
      _id_8FADA96E8B0CCC67[1] = (0.22, 0.4, 0);
      _id_8FADA96E8B0CCC67[2] = (0.6, 0, 0);
      break;
    case "sealion_residential":
      _id_8FADA96E8B0CCC67[0] = (0.02, 0.15, 0);
      _id_8FADA96E8B0CCC67[1] = (0.2, 0.45, 0);
      _id_8FADA96E8B0CCC67[2] = (0.6, 0, 0);
      break;
    default:
      _id_8FADA96E8B0CCC67[0] = (0.02, 0.3, 0);
      _id_8FADA96E8B0CCC67[1] = (0.3, 0.65, 0);
      _id_8FADA96E8B0CCC67[2] = (0.65, 0, 0);
      break;
  }

  if(getdvarint("dvar_E952680BCA3E5322", 0)) {
    _id_C399FED814CE0B54 = getdvarfloat("dvar_BD94D43D8D4F9CF1", 0.0);
    _id_049EE47567AAF48D = getdvarfloat("dvar_4222C2EA1DA11710", 0.15);
    _id_92EA5650306B2B39 = getdvarfloat("dvar_6DC31B39E8BA25C2", 0.15);
    _id_D2C8A28A0DEFC128 = getdvarfloat("dvar_FF7F5773D0E50067", 0.67);
    _id_D372E80DABEE147E = getdvarfloat("dvar_1D06CBD43E6F148F", _id_D2C8A28A0DEFC128);
    _id_8FADA96E8B0CCC67[0] = (_id_C399FED814CE0B54, _id_049EE47567AAF48D, 0.0);
    _id_8FADA96E8B0CCC67[1] = (_id_92EA5650306B2B39, _id_D2C8A28A0DEFC128, 0.0);
    _id_8FADA96E8B0CCC67[2] = (_id_D372E80DABEE147E, 0.0, 0.0);
  }

  return _id_8FADA96E8B0CCC67;
}

_id_50D3A34C9A0D882F(_id_FBF457EC2D19C2B1, _id_B95A019FC748357A, _id_27144879B0C7BEED, _id_8C2F68D314A6C3DD, _id_33A2175A9A4306BC) {
  level._id_2FF408BEB21CAFA6 = _id_7E38EED85BFD1153(_id_B95A019FC748357A);
  _id_900402F29CBF004A = _id_33A2175A9A4306BC.origin;
  _id_B8029919A84A02B5 = _id_27144879B0C7BEED.origin;
  _id_05CE8C4F8D4D8B5A = _id_870E3C2A791610F3(_id_B8029919A84A02B5);
  _id_5D1A8DC029C6D0C8 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_900402F29CBF004A);
  _id_8FADA96E8B0CCC67 = _id_C5F5B2049D60C525(_id_5D1A8DC029C6D0C8);
  _id_825A79A9D97263C9 = distance2dsquared(_id_B8029919A84A02B5, _id_900402F29CBF004A);
  _id_1EEA0B008843DA21 = sortbydistance(_id_FBF457EC2D19C2B1, _id_900402F29CBF004A);
  _id_8731A0D1FA272EE0 = [];

  foreach(exfil in _id_1EEA0B008843DA21) {
    _id_7701A9DC3018BEC1 = distance2dsquared(exfil.origin, _id_900402F29CBF004A);
    _id_6CC280BD0D433DF7 = _id_7701A9DC3018BEC1 / _id_825A79A9D97263C9;
    info = spawnStruct();
    info.exfil = exfil;
    info._id_6C8D21B2E54B2478 = _id_6CC280BD0D433DF7;
    info._id_9D308880669C09EA = _id_870E3C2A791610F3(exfil.origin);

    if(_id_6CC280BD0D433DF7 >= _id_8FADA96E8B0CCC67[0][0] && _id_6CC280BD0D433DF7 < _id_8FADA96E8B0CCC67[0][1]) {
      _id_8731A0D1FA272EE0[0] = scripts\engine\utility::array_add_safe(_id_8731A0D1FA272EE0[0], info);
      continue;
    }

    if(_id_6CC280BD0D433DF7 >= _id_8FADA96E8B0CCC67[1][0] && _id_6CC280BD0D433DF7 < _id_8FADA96E8B0CCC67[1][1]) {
      _id_8731A0D1FA272EE0[1] = scripts\engine\utility::array_add_safe(_id_8731A0D1FA272EE0[1], info);
      continue;
    }

    if(_id_6CC280BD0D433DF7 >= _id_8FADA96E8B0CCC67[2][0])
      _id_8731A0D1FA272EE0[2] = scripts\engine\utility::array_add_safe(_id_8731A0D1FA272EE0[2], info);
  }

  if(_id_8731A0D1FA272EE0[0].size == 0 || _id_8731A0D1FA272EE0[1].size == 0)
    return undefined;
  else if(_id_8731A0D1FA272EE0[0].size + _id_8731A0D1FA272EE0[1].size < _id_8C2F68D314A6C3DD)
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8731A0D1FA272EE0.size; _id_AC0E594AC96AA3A8++)
    _id_8731A0D1FA272EE0[_id_AC0E594AC96AA3A8] = scripts\engine\utility::array_randomize(_id_8731A0D1FA272EE0[_id_AC0E594AC96AA3A8]);

  _id_9F66A1722927F185 = [];
  _id_A1EEC49E983E56FC = _id_8731A0D1FA272EE0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8C2F68D314A6C3DD * 2; _id_AC0E594AC96AA3A8++) {
    if(_id_9F66A1722927F185.size == _id_8C2F68D314A6C3DD)
      return _id_9F66A1722927F185;

    index = _id_9F66A1722927F185.size + 1 == _id_8C2F68D314A6C3DD;
    _id_456459AE5B03B514 = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_A1EEC49E983E56FC[index]);
    _id_9F66A1722927F185 = scripts\engine\utility::array_add(_id_9F66A1722927F185, _id_456459AE5B03B514.exfil);
    _id_A1EEC49E983E56FC[index] = scripts\engine\utility::array_remove(_id_A1EEC49E983E56FC[index], _id_456459AE5B03B514);
  }

  return undefined;
}

_id_7E38EED85BFD1153(array) {
  origin = (0, 0, 0);

  foreach(_id_80EF668C09FFB70F in array) {
    if(isvector(_id_80EF668C09FFB70F)) {
      origin = origin + _id_80EF668C09FFB70F;
      continue;
    }

    if(isDefined(_id_80EF668C09FFB70F.origin) && isvector(_id_80EF668C09FFB70F.origin))
      origin = origin + _id_80EF668C09FFB70F.origin;
  }

  return origin / array.size;
}

_id_DF7EEDCD28DED71E() {
  index = scripts\engine\utility::array_find(level._id_34858BA8086735C6, "sealion_beach");

  if(isDefined(index)) {
    _id_27E046012350A0E9 = level._id_34858BA8086735C6[index];

    if(isDefined(_id_27E046012350A0E9))
      level._id_34858BA8086735C6[_id_27E046012350A0E9] = "sealion_beachclub";
  }

  index = scripts\engine\utility::array_find(level._id_34858BA8086735C6, "sealion_ruins02");

  if(isDefined(index)) {
    _id_27E046012350A0E9 = level._id_34858BA8086735C6[index];

    if(isDefined(_id_27E046012350A0E9))
      level._id_34858BA8086735C6[_id_27E046012350A0E9] = "sealion_coastalruins";
  }

  index = scripts\engine\utility::array_find(level._id_34858BA8086735C6, "sealion_ruins01");

  if(isDefined(index)) {
    _id_27E046012350A0E9 = level._id_34858BA8086735C6[index];

    if(isDefined(_id_27E046012350A0E9))
      level._id_34858BA8086735C6[_id_27E046012350A0E9] = "sealion_culdesac";
  }

  index = scripts\engine\utility::array_find(level._id_34858BA8086735C6, "sealion_power");

  if(isDefined(index)) {
    _id_27E046012350A0E9 = level._id_34858BA8086735C6[index];

    if(isDefined(_id_27E046012350A0E9))
      level._id_34858BA8086735C6[_id_27E046012350A0E9] = "sealion_powerplant";
  }

  index = scripts\engine\utility::array_find(level._id_34858BA8086735C6, "sealion_town");

  if(isDefined(index)) {
    _id_27E046012350A0E9 = level._id_34858BA8086735C6[index];

    if(isDefined(_id_27E046012350A0E9))
      level._id_34858BA8086735C6[_id_27E046012350A0E9] = "sealion_towncenter";
  }

  index = scripts\engine\utility::array_find(level._id_34858BA8086735C6, "sealion_treatment");

  if(isDefined(index)) {
    _id_27E046012350A0E9 = level._id_34858BA8086735C6[index];

    if(isDefined(_id_27E046012350A0E9))
      level._id_34858BA8086735C6[_id_27E046012350A0E9] = "sealion_watertreatment";
  }
}

_id_3394DEA421F7FEB2() {
  if(getdvarint("dvar_F45B12D5EFBB99A4", 0) > 0)
    thread _id_5D7295326419A859();
}

_id_5D7295326419A859() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    if(!isbot(player))
      player thread _id_1458E25928C3B85B();
  }
}

_id_1458E25928C3B85B() {
  player = self;
  player endon("disconnect");
  player waittill("spawned_player");
  player _meth_EB0326E0C8803F41(0, "_hunt");
}