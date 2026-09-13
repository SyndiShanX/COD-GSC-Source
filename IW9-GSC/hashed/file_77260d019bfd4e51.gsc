/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_77260d019bfd4e51.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_mil_lnd_mrap");
  level._id_09FAB40ED3326F8B = getDvar("dvar_0B282DFF383572B2", "mp/subarea_tuning_mp_saba.csv");
  level thread _id_5DEF7AF2A9F04234::_id_C08668FE290FC31A();
  _id_6FD7EED8F071303C::main();
  _id_6579654744EEAD12::main();
  _id_6B1182680629AD28::main();
  scripts\mp\load::main();
  scripts\common\utility::_id_DA6A5AB17FFC2338("test_observatory", ["before", "after"]);
  scripts\common\utility::_id_D6B99CCF87941A5A(::_id_2C16D7072464DF50);
  level._id_D847EC6FD85E5E49 = 0;
  scripts\common\create_script_utility::initialize_create_script();
  _id_4FF6C6ED304E05BB::init();
  scripts\cp_mp\tripwire::init();
  _id_60E3273DF6B5F7D1::init();
  _id_72D6AF97CFC97305::init();
  _id_7DF5E129E32CD13A();
  thread _id_B2F8F087CEB71FEA();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level.outofboundstriggersplanetrace = getEntArray("OutOfBounds", "targetname");

    if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      _id_4480C6CE37B2BDF3::_id_B71560B07A8F979D("saba");
      level thread _id_4480C6CE37B2BDF3::_id_80BF519FB6395CE2();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_exhume")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_exhume"))
        level thread _id_75FB19B25C990DE5::main();
      else
        level thread _id_204EAD51529B106A::main();

      level thread _id_31A965A3DADB3389::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_fort")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_fort"))
        level thread _id_2E4B6E49CBAFB322::main();
      else
        level thread _id_59D11AF807F7B0E1::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_hydro")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_hydro"))
        level thread _id_4EBE7C8C4335B85F::main();
      else
        level thread _id_456D22A216EEB6F0::main();

      level thread _id_1AB3687FF5C05F23::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_oilfield")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_oilfield"))
        level thread _id_6702135AF75B0875::main();
      else
        level thread _id_0CFFED3D2D53075A::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_caves")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_caves"))
        level thread _id_16493FA980AF042B::main();
      else
        level thread _id_153481CDB86FFB2C::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_observatory")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_observatory"))
        level thread _id_0DBDE1577E9F030D::main();
      else
        level thread _id_02CBC5B0981723C6::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_wartorn")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_wartorn"))
        level thread _id_4C4DBB14E10B5A9C::main();
      else
        level thread _id_1B64AB35A2E7EA1F::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_oldtwn")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_oldtwn"))
        level thread _id_169521985A37809F::main();
      else
        level thread _id_37D1B4F10F751F30::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_mtntwn")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_mtntwn"))
        level thread _id_0004386BC24AA7BF::main();
      else
        level thread _id_65A3E7236580EA10::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_airport")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_airport"))
        level thread _id_1A9F1EE13F1D7BF0::main();
      else
        level thread _id_12E344CB72621823::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_moderncity"))
      level thread _id_330EE044FA0F6F76::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_marshland")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_marshland"))
        level thread _id_7610F9741D7125CF::main();
      else
        level thread _id_5C862C21E2706100::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_sunken")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_sunken"))
        level thread _id_4191B1AC078432C9::main();
      else
        level thread _id_3DF919FB2BDE3C2E::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_lone")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_lone"))
        level thread _id_3A72DC7BF5AA6021::main();
      else
        level thread _id_6DC3887CE4597696::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_fishtwn")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_fishtwn"))
        level thread _id_641729E5D33F0A5C::main();
      else
        level thread _id_35949D3972BE97DF::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_cemetery"))
      level thread _id_4FD891E2B9CB7C3E::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_01"))
      level thread _id_3F6F5EF4FED3E7A4::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_03"))
      level thread _id_65A803A463C36964::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_04"))
      level thread _id_5A98187D8491FAE1::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_05"))
      level thread _id_7C61AF10501B1DF0::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_06"))
      level thread _id_1072F0D1E303E1A1::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburb_09"))
      level thread _id_560E2DF03D3FB71A::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_sira")) {
      if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("saba_sira"))
        level thread _id_405574A8B7CD827E::main();
      else
        level thread _id_740396A1DC93A76D::main();
    }

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_11"))
      level thread _id_2EAB3A714A783C73::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_12"))
      level thread _id_067ACE124630B774::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_13"))
      level thread _id_247F34776B5565A5::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_suburbs_14"))
      level thread _id_0EBD44C70346FD9E::main();

    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_oasis"))
      level thread _id_31B3FEF3131B913D::main();

    level thread _id_68264C6DA17E6008::main();
    level thread _id_0652E60D8140553B::main();
    level thread _id_6A086FC98209B226::main();
    level thread _id_6AE7D0D070C028E7::main();

    if(getdvarint("dvar_2BE93DD484220A45", 0) != 0)
      level thread _id_2DBA79C7EB8E04F9::main();

    _id_552DE918988BE3A5 = getdvarint("dvar_2BE93DD484220A45", 0);
    _id_7C5F03A211489CE5 = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz";

    if(getdvarint("dvar_9D28618B108B5283", 0) != 0 || !_id_552DE918988BE3A5 && _id_7C5F03A211489CE5) {
      if(_id_552DE918988BE3A5)
        level thread _id_237DD13CCB157081::main();
      else
        level thread _id_00D5107AC428658C::main();
    }

    if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "truckwar")
      level thread _id_0DD309A6E2FB4250::main();

    if(scripts\mp\utility\game::getsubgametype() == "dmz")
      _id_4480C6CE37B2BDF3::_id_A1E18F290954A5E9();

    level._id_BBD8A18655D9495B = _id_147448F3F080C636::_id_405BF7CDE917B70E;
    level._id_F29702DDC09D1002 = _id_147448F3F080C636::_id_384465A3A8AA24F7;
    level._id_0FFA48A6A79A7224 = _id_147448F3F080C636::_id_47C84E03DCBC5AA7;
  }

  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  level._id_63A70FF2D38D8BEE = getdvarint("dvar_433FA7CA2836C6F1", 0);
  level._id_F0872E42DAF6D4D5 = getclosestpointonnavmesh((36712, 27556, 2369));
  setDvar("fd_helicopter_altitude_limiter", 7600);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("dvar_CB730D3B86C988B2", -8000);
  setDvar("cg_defaultWindFrequencyScale", 0.68);
  setDvar("cg_defaultWindAmplitudeScale", 3);
  setDvar("cg_defaultWindAreaScale", 100);
  setDvar("cg_defaultWindNoiseScale", 0.4);
  setDvar("cg_defaultWindStrength", 2);
  setDvar("cg_defaultWindDir", (0.3, -1, 0));
  setsaveddvar("dvar_BA5B493D3212E3ED", 0.8);
  setsaveddvar("dvar_61CD8305CCF44791", 1);
  setsaveddvar("r_reactiveMotionActorRadius", 32.5);
  setsaveddvar("r_reactiveMotionPlayerPushAmplitude", 40);
  setsaveddvar("r_reactiveMotionPlayerPushDecay", 0.8);
  setsaveddvar("r_reactiveMotionPlayerPushFrequency", 1);
  setsaveddvar("r_reactiveMotionPlayerRadius", 60);
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 70);
  setsaveddvar("r_reactiveMotionVelocityTailScale", 0.75);
  setDvar("dvar_646CA256ECFF2627", "-65504 -65504 0");
  setDvar("dvar_A734A8DC8EF7627E", "131008 131008");
  setDvar("dvar_023BB35BBC2D79A8", 3000);
  setDvar("dvar_27FA9F4C8976E565", 10000);
  setDvar("dvar_BF2F16BD0028F6E3", "0.90 0.80 0.55");
  setDvar("dvar_33A035C99CB048B1", 0.00005);
  setDvar("dvar_0099863FD36F21E4", 0.15);
  setDvar("dvar_43B1BFE24B9DB3C5", 0.05);
  setDvar("dvar_70640CE906E6D9C2", 0.05);
  setDvar("dvar_5BB234E77E6E8500", 1);
  setDvar("dvar_248D3E2385CACB9B", 1);
  setDvar("dvar_2F948C271D3B0E2E", 2);
  setDvar("dvar_7623BD064C30088C", 0);
  setDvar("dvar_446ED387D5A2467B", 300);
  setDvar("dvar_D5BE9CF5305A87C0", 0.99);
  setDvar("dvar_383EB0DC42A487BE", 20);
  setDvar("dvar_6587B19CDE46756E", "1.0 0.5 0.5");
  setDvar("dvar_198BC49639574B81", 600);
  setDvar("dvar_B7BA2258818C9F3D", 1);
  setDvar("dvar_B7972C5881666D83", 0);
  setDvar("dvar_9E9F4B1CAB77DF95", 0.03038);
  setDvar("dvar_9AD4FF0067A34902", 0.15);
  scripts\mp\compass::setupminimap("compass_map_mp_saba2");

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    _id_4480C6CE37B2BDF3::_id_DD432354AF4C9024();
    level thread _id_54BB40814F676115::_id_B0DAEF016957DF38();
  }

  level thread _id_B827C1DA8FD6655F();
  scripts\cp_mp\utility\game_utility::_id_5258141665FF7B95();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
    _func_EB7F544259415A09("mp_saba_s5_reveal");
  else if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _func_EB7F544259415A09("mp_saba_dmz");
  else
    _func_EB7F544259415A09("mp_saba");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    brinit();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getdvarint("dvar_ED4A71E34E488E86", 0) > 0)
    level thread _id_06AD4F9E2F4C6105::init();

  if(getdvarint("dvar_09A09DDBA14D94DA", 1)) {
    _id_BA145FCD40608D31 = getEntArray("elevator_car_single_door", "targetname");
    scripts\engine\utility::array_delete(_id_BA145FCD40608D31);
    _id_94615694EBBFB2EE = getEntArray("elevator_door_floor_01", "script_noteworthy");
    scripts\engine\utility::array_delete(_id_94615694EBBFB2EE);
    _id_486C21C347BB08D3 = getEntArray("elevator_door_floor_02", "script_noteworthy");
    scripts\engine\utility::array_delete(_id_486C21C347BB08D3);
    _id_CC3906D5D41BF2B1 = getEntArray("elevator_door_car_00", "script_noteworthy");
    scripts\engine\utility::array_delete(_id_CC3906D5D41BF2B1);
  }

  level thread _id_EF079EE3D6B651AD();

  if(istrue(level._id_289DF80E1DED586F))
    level thread _id_48814951E916AF89::_id_C8393014DD7F8AB6();

  level thread _id_5F903436642211AF::_id_D8DE1E0BC05F3B3A();
  setDvar("dvar_9365C7A237EDAA2F", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  level thread _id_B5C9828FD2836DE6();
  level._id_8CF13EF4FD814CCD = 1;
  level _id_3C37E8E4377AA2B3();
  level thread _id_6D890353770DA974();

  if(getdvarint("dvar_8B2E9CAB5EC0C0D8", 1) == 1)
    _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::onplayerconnect);

  level thread _id_151E13C2B2177F68();
  level thread _id_7D41F66902695017();
}

brinit() {
  _id_362C58E8BB39BCDA::enablefeature("circleSnapToNavMesh");
  level.onlowpopstart = ::_id_0865DD7703C23C87;
  level.br_level = spawnStruct();
  _id_FDFE2D4AAF8EC33D = 19000;
  _id_47C567A3B8B1E5E0 = getdvarint("dvar_512A3982CFB227FA", -1);

  if(_id_47C567A3B8B1E5E0 != -1)
    _id_FDFE2D4AAF8EC33D = _id_47C567A3B8B1E5E0;

  _id_33DD915945FCA005 = 128;
  _id_549C13B78DE4D368 = getdvarint("dvar_333CBABB21A5EE2A", -1);

  if(_id_549C13B78DE4D368 != -1)
    _id_33DD915945FCA005 = _id_549C13B78DE4D368;

  _id_45B2B4A889E633FA::setc130heightoverrides(_id_FDFE2D4AAF8EC33D, _id_33DD915945FCA005);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1];
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  _id_1642D587A6F7F5EE = getdvarfloat("dvar_575DA0CEF7432907", 0.8);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0] * _id_1642D587A6F7F5EE;
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0] * _id_1642D587A6F7F5EE;
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1] * _id_1642D587A6F7F5EE;
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1] * _id_1642D587A6F7F5EE;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  _id_33DD915945FCA005 = scripts\cp_mp\parachute::getc130sealevel();
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(_id_FDFE2D4AAF8EC33D - _id_33DD915945FCA005));
  level.br_level._id_257DEE2BBC2480F5 = "mp/saba_br_locations.csv";
  level.br_level._id_96BC2CCD011BA845 = (-7000, -5000, 0);

  if(isDefined(level._id_E486ACB8F70C45A2)) {
    level.br_level.br_circleclosetimes = [level._id_E486ACB8F70C45A2._id_04F81729168C0B8A, 3000, 3000];
    level.br_level.br_circledelaytimes = [level._id_E486ACB8F70C45A2._id_74B5B12BB6514385, 3000, 3000];
    level.br_level.br_circleshowdelaydanger = [level._id_E486ACB8F70C45A2._id_74B5B12BB6514385, 0, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    level.br_level.br_circleclosetimes = [1, 200, 140, 100, 70, 100];
    level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
    level.br_level.br_circleclosetimes = [1, 90, 75, 75, 60];
    level.br_level.br_circledelaytimes = [10, 150, 90, 60, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0];
  } else {
    level.br_level.br_circleclosetimes = [215, 220, 170, 110, 70, 50, 50, 100];
    level.br_level.br_circledelaytimes = [90, 60, 60, 45, 45, 30, 30, 0];
    level.br_level.br_circleshowdelaydanger = [0, 0, 0, 0, 0, 0, 0, 0];
  }

  if(isDefined(level._id_E486ACB8F70C45A2)) {
    level.br_level.br_circleshowdelaysafe = [level._id_E486ACB8F70C45A2._id_74B5B12BB6514385, 3000, 3000];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500];
    level.br_level.br_circleradii = [81600, level._id_E486ACB8F70C45A2.circleradius, 200, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 5500];

    if(istrue(level._id_63A70FF2D38D8BEE))
      level.br_level.br_circleradii = [19000, 12500, 7500, 3500, 1000, 250, 0];
    else
      level.br_level.br_circleradii = [75000, 40000, 20000, 8000, 4000, 2000, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [7500, 7500, 6500, 5500, 5000];
    level.br_level.br_circleradii = [81600, 12000, 8000, 5000, 2000, 0];
  } else {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
    level.br_level.br_circleradii = [65000, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0];
  }

  if(isDefined(level.br_circle_init_func))
    [[level.br_circle_init_func]]();

  _id_2695A20D4011076D::applycirclesettings();
  level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((16549.6, 889.246, 366.303), 0, 7000), _id_1E4A61DB11011446::createspawnlocation((-2335.89, -4998.54, 5325.01), 0, 7500), _id_1E4A61DB11011446::createspawnlocation((-28389.8, 2055.94, 2327.41), 0, 9000), _id_1E4A61DB11011446::createspawnlocation((-49294.4, 13365.7, 1464.1), 0, 7000), _id_1E4A61DB11011446::createspawnlocation((-23227.2, 22705.4, 1205.55), 0, 8000), _id_1E4A61DB11011446::createspawnlocation((30543, -32223.1, 1401.72), 0, 8000), _id_1E4A61DB11011446::createspawnlocation((17936, -53630, 1387.23), 0, 6000), _id_1E4A61DB11011446::createspawnlocation((-29022.9, -47307.8, 212), 0, 7000), _id_1E4A61DB11011446::createspawnlocation((-31955.1, -19726.4, 300.002), 0, 9000), _id_1E4A61DB11011446::createspawnlocation((13344, 20488, 648), 0, 8000)];
  level.br_badcircleareas = [_id_2695A20D4011076D::createinvalidcirclearea((-59824, 38510, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-59824, 53870, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-59824, 61166, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-59824, 46190, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-44824, 61166, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-44824, 53870, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-72000, 8750, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((39500, 46600, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((24600, 62400, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((11450, 68000, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-18000, 69500, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((47700, 24750, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((60200, 9100, 0), 20000), _id_2695A20D4011076D::createinvalidcirclearea((-39936, 29184, 0), 8200), _id_2695A20D4011076D::createinvalidcirclearea((-33792, 38400, 0), 8200), _id_2695A20D4011076D::createinvalidcirclearea((-26112, 47616, 0), 8200), _id_2695A20D4011076D::createinvalidcirclearea((-18432, 54272, 0), 8200), _id_2695A20D4011076D::createinvalidcirclearea((-5632, 58880, 0), 8200)];
}

_id_0865DD7703C23C87() {
  if(!_id_1E4A61DB11011446::lowpopallowtweaks()) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    if(istrue(level._id_63A70FF2D38D8BEE))
      level.br_level.br_circleradii = [22500, 12000, 7500, 4000, 1500, 500, 0];
    else
      level.br_level.br_circleradii = [57000, 27500, 12500, 6500, 3000, 1250, 0];

    level.br_level.br_circleclosetimes = [1, 190, 120, 80, 40, 90];
    level.br_level.br_circledelaytimes = [1, 110, 65, 50, 35, 0];
  } else {
    level.br_level.br_circleradii = [81000, 50000, 30000, 15000, 7500, 3750, 1500, 0];
    level.br_level.br_circleclosetimes = [270, 180, 150, 60, 60, 45, 90];
    level.br_level.br_circledelaytimes = [150, 60, 60, 60, 45, 30, 0];
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
  _id_76C8CF4696105491 = [];
  _id_76C8CF4696105491["airport"] = (30401.5, -34148.4, 1929.91);
  _id_76C8CF4696105491["coastaltown"] = (-34418.3, -24026.5, 2199.75);
  _id_76C8CF4696105491["fishingvillage"] = (736.893, -41000.9, 2724.16);
  _id_76C8CF4696105491["hydraulic"] = (-8179.58, 9174.09, 2670.04);
  _id_76C8CF4696105491["marshlands"] = (16525.5, 439.118, 2327.82);
  _id_76C8CF4696105491["moderncity"] = (14227, 24006.5, 4756.87);
  _id_76C8CF4696105491["mountaintown"] = (19621, -14943, 6391);
  _id_76C8CF4696105491["observatory"] = (-2768.98, -14627.6, 7476.9);
  _id_76C8CF4696105491["oilfield"] = (-22122, 23868.6, 1892.07);
  _id_76C8CF4696105491["oldfort"] = (18400.6, -57952.5, 2555.31);
  _id_76C8CF4696105491["oldtown"] = (10852.6, -25943.7, 3983.93);
  _id_76C8CF4696105491["cemetary"] = (-20103.2, -37581.9, 2553.79);
  _id_76C8CF4696105491["quarry"] = (-50630.4, 12947.5, 4511.8);
  _id_76C8CF4696105491["sunkentown"] = (-29212.7, -47137.2, 2237.17);
  _id_76C8CF4696105491["terroristcaves"] = (-22428, -7464.37, 1783.72);
  _id_76C8CF4696105491["oasis"] = (-25955, 45324, 179.5);
  _id_76C8CF4696105491["lone"] = (-45000, -15501, 1466);
  _id_76C8CF4696105491["wartorn"] = (-9455.76, 41875.2, 2211.35);
  _id_B5129C337031DDEC = strtok(getDvar("dvar_D4C64EFD6296E214", ""), " ");

  foreach(_id_171F90B9C4C76D44, _id_8C7D583CF15F5EC7 in _id_76C8CF4696105491) {
    _id_E70229AAAD3AEC6C = scripts\engine\utility::array_contains(_id_B5129C337031DDEC, _id_171F90B9C4C76D44);

    if(_id_B5129C337031DDEC.size == 0 || _id_E70229AAAD3AEC6C)
      _id_FD2DBEAE371F9614(_id_171F90B9C4C76D44, _id_8C7D583CF15F5EC7, _id_90416D079805B8A5);
  }

  level thread _id_5ADC69197DE334C3();
}

_id_FD2DBEAE371F9614(scriptablestate, loc, _id_90416D079805B8A5) {
  if(istrue(level.isx1ops))
    _id_6482FEB0B7568914(scriptablestate + "_re", loc, _id_90416D079805B8A5, "name_fx_re");
  else
    _id_6482FEB0B7568914(scriptablestate, loc, _id_90416D079805B8A5, "name_fx");
}

_id_6482FEB0B7568914(scriptablestate, loc, _id_90416D079805B8A5, _id_8A46C62F0A756DD3) {
  loc = loc + (0, 0, 500);
  _id_B243306D75CC8719 = spawn("script_model", loc);
  _id_B243306D75CC8719 setModel("iw9_tag_origin_name_fx");
  _id_B243306D75CC8719.angles = _id_90416D079805B8A5;
  level.name_fx[level.name_fx.size] = _id_B243306D75CC8719;
  _id_B243306D75CC8719 setscriptablepartstate(_id_8A46C62F0A756DD3, scriptablestate);
  _id_B243306D75CC8719 forcenetfieldhighlod(1);
}

_id_5ADC69197DE334C3() {
  if(getdvarint("dvar_C9C5CF6D66EF03CF", 0) != 0) {
    return;
  }
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

_id_96C2FCDA49A8C581() {
  level.nummistclusters = getdvarint("dvar_4F4CA4F12710744C", 13);

  if(level.nummistclusters <= 0) {
    return;
  }
  _id_0A0743556878BB60 = [];
  _id_0A0743556878BB60[0] = (-17431, 26586, 500);
  _id_0A0743556878BB60[1] = (-22668, 36629, 2600);
  _id_0A0743556878BB60[2] = (-38816, 50972, 7200);
  _id_0A0743556878BB60[3] = (-18276, 45104, 4285);
  _id_0A0743556878BB60[4] = (5900, 26084, 790);
  _id_0A0743556878BB60[5] = (-41485, 338, 2100);
  _id_0A0743556878BB60[6] = (22452, -27194, 1500);
  _id_0A0743556878BB60[7] = (5050, 31027, 1300);
  _id_0A0743556878BB60[8] = (-39730, 12701, 3115);
  _id_0A0743556878BB60[9] = (50871, -47452, 400);
  _id_0A0743556878BB60[10] = (57555, 3350, 1000);
  _id_0A0743556878BB60[11] = (-3316, 30454, 3000);
  _id_0A0743556878BB60[12] = (-48791, 46074, 11207);
  _id_0A0743556878BB60[13] = (100, 23546, 1800);
  _id_0A0743556878BB60[14] = (-9558, -13090, 1100);
  _id_0A0743556878BB60[15] = (20953, 12360, 1800);
  _id_0A0743556878BB60[16] = (12220, 20486, 1600);
  _id_0A0743556878BB60[17] = (-28397, -23638, 860);
  _id_0A0743556878BB60[18] = (-31228, -52488, 1600);
  _id_0A0743556878BB60[19] = (5491, -41903, 800);
  _id_0A0743556878BB60[20] = (21263, -43266, 500);
  _id_0A0743556878BB60[21] = (34000, -45441, 100);
  _id_0A0743556878BB60[22] = (54616, -31712, 900);
  _id_0A0743556878BB60[23] = (34600, 7013, 1300);
  _id_0A0743556878BB60[24] = (57412, 29600, 4200);
  _id_0A0743556878BB60[25] = (11766, 45690, 2147);
  _id_0A0743556878BB60[26] = (-4331, 40541, 2400);
  _id_0A0743556878BB60[27] = (34702, 18568, 1100);
  _id_0A0743556878BB60[28] = (5851, -14938, 1100);
  _id_0A0743556878BB60[29] = (-14690, -26183, 400);
  _id_0A0743556878BB60[30] = (-18244, -46482, 400);
  _id_0A0743556878BB60[31] = (-39043, -25359, 400);
  _id_0A0743556878BB60[32] = (54615, 15943, 2500);

  if(level.nummistclusters > _id_0A0743556878BB60.size)
    level.nummistclusters = _id_0A0743556878BB60.size;

  level waittill("prematch_started");
  _id_0A0743556878BB60 = scripts\engine\utility::array_randomize(_id_0A0743556878BB60);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.nummistclusters; _id_AC0E594AC96AA3A8++) {
    location = _id_0A0743556878BB60[_id_AC0E594AC96AA3A8];
    playFX(scripts\engine\utility::getfx("vfx_br_distant_fog_main"), location);
    _id_F6F6DC0578A5AB9B = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(0, 90));
    _id_F6F6DC0578A5AB9B = _id_F6F6DC0578A5AB9B * randomfloatrange(2048, 9000) + location + (0, 0, randomfloatrange(-500, 500));
    playFX(scripts\engine\utility::getfx("vfx_br_distant_fog_main"), _id_F6F6DC0578A5AB9B);
    _id_F6F6DC0578A5AB9B = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(90, 180));
    _id_F6F6DC0578A5AB9B = _id_F6F6DC0578A5AB9B * randomfloatrange(2048, 9000) + location + (0, 0, randomfloatrange(-500, 500));
    playFX(scripts\engine\utility::getfx("vfx_br_distant_fog_main"), _id_F6F6DC0578A5AB9B);
    _id_F6F6DC0578A5AB9B = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(180, 270));
    _id_F6F6DC0578A5AB9B = _id_F6F6DC0578A5AB9B * randomfloatrange(2048, 9000) + location + (0, 0, randomfloatrange(-500, 500));
    playFX(scripts\engine\utility::getfx("vfx_br_distant_fog_main"), _id_F6F6DC0578A5AB9B);
    _id_F6F6DC0578A5AB9B = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(270, 359));
    _id_F6F6DC0578A5AB9B = _id_F6F6DC0578A5AB9B * randomfloatrange(2048, 9000) + location + (0, 0, randomfloatrange(-500, 500));
    playFX(scripts\engine\utility::getfx("vfx_br_distant_fog_main"), _id_F6F6DC0578A5AB9B);
    waitframe();
  }
}

_id_7DF5E129E32CD13A() {
  if(getdvarint("dvar_645651223591AFC4", 1) == 0) {
    return;
  }
  ents = getEntArray("trigger_multiple_mp_rugby_endzone", "classname");

  foreach(ent in ents)
  ent delete();

  _id_C96993ED5159C61D = [];
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "grnd";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "hardpoint_zone";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "flag_primary";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "ctf_trig_allies";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "ctf_flag_allies";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "ctf_zone_allies";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "ctf_trig_axis";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "ctf_flag_axis";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "ctf_zone_axis";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "bombzone";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "sd_bomb";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "sd_bomb_pickup_trig";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "cyber_emp";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "cyber_emp_pickup_trig";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "grind_location";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "dd_bombzone";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "dd_bombzone_clip_a";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "dd_bombzone_clip_b";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "dd_bombzone_clip_c";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "hqloc";
  _id_C96993ED5159C61D[_id_C96993ED5159C61D.size] = "gunship_shadow_brush";

  foreach(item in _id_C96993ED5159C61D) {
    ents = getEntArray(item, "targetname");

    foreach(ent in ents)
    ent delete();
  }

  _id_164EFEAA7A26864F = [];
  _id_164EFEAA7A26864F[_id_164EFEAA7A26864F.size] = "ks_gunship_light_only";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz")
    _id_164EFEAA7A26864F[_id_164EFEAA7A26864F.size] = "dmz_samsite_brushmodel";

  foreach(item in _id_164EFEAA7A26864F) {
    ents = getEntArray(item, "script_noteworthy");

    foreach(ent in ents)
    ent delete();
  }

  _id_A89B7F0A70BE6A01 = [];
  _id_A89B7F0A70BE6A01[_id_A89B7F0A70BE6A01.size] = "sd_equipment_bombsite_crate";
  _id_A89B7F0A70BE6A01[_id_A89B7F0A70BE6A01.size] = "sd_equipment_bombsite_crate_d";
  ents = getEntArray("script_model", "classname");

  foreach(ent in ents) {
    if(scripts\engine\utility::array_contains(_id_A89B7F0A70BE6A01, ent.model))
      ent delete();
  }

  level._id_48E6357833F85B3B = [];
  _id_7068A34F89153DEE = scripts\engine\utility::getStructArray("gulag_twotwo_spectator_spawn", "script_noteworthy");

  foreach(spawnpoint in _id_7068A34F89153DEE) {
    if(spawnpoint.origin[2] <= -11200)
      level._id_48E6357833F85B3B[level._id_48E6357833F85B3B.size] = spawnpoint;
  }
}

_id_DE9C95E409D17900(_id_171F90B9C4C76D44) {
  for(;;) {
    foreach(node in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["looseGuardNodes"])
    thread scripts\mp\utility\debug::drawsphere(node.origin, 128, 1, (0, 1, 0));

    wait 1;
  }
}

_id_F467F817566C17B4() {
  level._id_3B53C7166674E8E8 = [];
  _id_D17ECCE2B9D7B3E1((4682.94, -15624.5, 3526.55), (5350, -14900, 4119));

  foreach(_id_CBF22C9EDB76E72D in level._id_3B53C7166674E8E8) {
    thread scripts\mp\utility\debug::drawsphere(_id_CBF22C9EDB76E72D.startorigin, 128, 500, (0, 1, 0));
    thread scripts\mp\utility\debug::drawsphere(_id_CBF22C9EDB76E72D.endorigin, 128, 500, (1, 0, 0));
    thread scripts\cp_mp\utility\debug_utility::drawline(_id_CBF22C9EDB76E72D.startorigin, _id_CBF22C9EDB76E72D.endorigin, 500, (0, 0, 1));
  }
}

_id_D17ECCE2B9D7B3E1(startorigin, endorigin) {
  _id_CBF22C9EDB76E72D = spawnStruct();
  _id_CBF22C9EDB76E72D.startorigin = startorigin;
  _id_CBF22C9EDB76E72D.endorigin = endorigin;
  level._id_3B53C7166674E8E8[level._id_3B53C7166674E8E8.size] = _id_CBF22C9EDB76E72D;
}

_id_B5C9828FD2836DE6() {
  level endon("game_ended");
  level waittill("connected", player);
  _id_2B4B28F7AE75B76A = spawn("script_origin", (0, 0, 0));
  _func_5A8DBA516863782A("pa_node_fishtown_tower");

  for(;;) {
    wait(randomfloatrange(8, 12));
    _id_2B4B28F7AE75B76A playSound("emt_dx_fish_paan_ldsp");
  }
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-36445.5, -25729.4, 309), 1);
}

_id_6D890353770DA974() {
  _id_7E6B10E99BB9024F = scripts\engine\utility::getStructArray("hack_stronghold_noTacMap", "script_noteworthy");

  if(!isDefined(_id_7E6B10E99BB9024F)) {
    return;
  }
  foreach(_id_256C6B221030FB06 in _id_7E6B10E99BB9024F) {
    _id_256C6B221030FB06._id_104F87CC51A1138D = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(_id_256C6B221030FB06.target, "targetname"), getEntArray(_id_256C6B221030FB06.target, "targetname"), _func_F159C10D5CF8F0B4(_id_256C6B221030FB06.target, "targetname"));
    wait 1;
    _id_4948CDF739393D2D::_id_401B0949743B45A9(_id_256C6B221030FB06);
  }
}

_id_B827C1DA8FD6655F() {
  _id_BB3F19BC70121044 = (-33503, 36536, -395);

  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  for(;;) {
    if(isDefined(level._id_B205D90302DA2F07["saba_oasis"]["players"])) {
      foreach(player in level._id_B205D90302DA2F07["saba_oasis"]["players"]) {
        if(!istrue(player._id_48113D5C153EF01E))
          player thread _id_A9B425D17236EC78(player, _id_BB3F19BC70121044);
      }
    }

    wait 1;
  }
}

_id_A9B425D17236EC78(player, _id_BB3F19BC70121044) {
  player endon("death");
  player endon("bbEntranceTooFar");
  player._id_48113D5C153EF01E = 1;

  for(;;) {
    _id_80BC91A54F223618 = distance2d(player.origin, _id_BB3F19BC70121044);
    _id_744AF42B66F6D746 = _id_DC3F388A35031758(_id_80BC91A54F223618);

    if(istrue(player.extracted) || !scripts\engine\utility::array_contains(level._id_B205D90302DA2F07["saba_oasis"]["players"], player)) {
      player._id_48113D5C153EF01E = 0;
      player notify("bbEntranceTooFar");
    }

    if(isDefined(_id_744AF42B66F6D746)) {
      player playlocalsound("iw9_mp_radiation_tick");
      wait(_id_744AF42B66F6D746);
    } else
      wait 1;

    waitframe();
  }
}

_id_DC3F388A35031758(_id_80BC91A54F223618) {
  if(_id_80BC91A54F223618 < 16)
    return randomfloatrange(0.05, 0.2);
  else if(_id_80BC91A54F223618 < 32)
    return randomfloatrange(0.1, 0.25);
  else if(_id_80BC91A54F223618 < 1024)
    return randomfloatrange(0.15, 0.45);
  else if(_id_80BC91A54F223618 < 2048)
    return randomfloatrange(0.2, 0.8);

  return undefined;
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (462, 26448, 450));
  _id_45428B56EF07EA91 setModel("me_rock_mp_hydro_formation_01");
  _id_45428B56EF07EA91.angles = (353.667, 98.8343, -5.80179);
  _id_AF5DF9A502E8811A = spawn("script_model", (82, 26412, 444));
  _id_AF5DF9A502E8811A setModel("me_rock_mp_hydro_formation_01");
  _id_AF5DF9A502E8811A.angles = (0, 30, -10);

  if(getdvarint("dvar_DE0ED3FF8D3C7E71", 0) == 1) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    _id_CE8FC891E4BD83C5 = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", (16350, 22650, 1600), 256);

    foreach(ascender in _id_CE8FC891E4BD83C5)
    ascender setscriptablepartstate("top", "off");
  }

  if(getdvarint("dvar_C5FEC8334F8A2FC9", 0)) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    _id_4EAD6B4FF3816236 = getentitylessscriptablearray("scriptable_dmz_hidden_container_common", "classname");

    foreach(_id_B038ED928EC17A81 in _id_4EAD6B4FF3816236)
    _id_4EAD6B4FF3816236 setscriptablepartstate("body", "hidden");
  }

  if(getdvarint("dvar_5B7E4E72322727DA", 1) == 0 || !_func_CBAD1443981C51CD("test_observatory")) {
    return;
  }
  level._id_4DD5018DF125A242[0] = spawnscriptable("un_foliage_tree_olive_large_01", (-18.1494, -10156.7, 5001.85), (0, 11, 0));
  level._id_4DD5018DF125A242[1] = spawnscriptable("un_foliage_tree_olive_large_01", (-721.987, -10175.7, 4789.03), (0, 260, 0));
  level._id_4DD5018DF125A242[2] = spawnscriptable("un_foliage_tree_olive_large_01", (-4262.89, -13609.7, 4729.93), (2, 290, 2));
  level._id_4DD5018DF125A242[3] = spawnscriptable("un_foliage_tree_olive_large_01", (-10536, -12129, 2472), (0, 0, 0));
  level._id_4DD5018DF125A242[4] = spawnscriptable("un_foliage_tree_olive_large_01", (-10161.8, -19828.5, 1932.01), (0, 52, 0));
  level._id_4DD5018DF125A242[5] = spawnscriptable("un_foliage_tree_olive_large_01", (-11399.6, -18393, 1873.1), (0, 232, 0));
  level._id_4DD5018DF125A242[6] = spawnscriptable("un_foliage_tree_olive_large_01", (-11183.7, -20287.1, 1630.4), (0, 284, 0));
  level._id_4DD5018DF125A242[7] = spawnscriptable("un_foliage_tree_olive_large_01", (-3521.91, -19516.1, 4833.43), (0, 350, 0));
  level._id_4DD5018DF125A242[8] = spawnscriptable("un_foliage_tree_olive_large_01", (-3261.4, -18066.7, 5099.09), (0, 254, 0));
  level._id_4DD5018DF125A242[9] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-4520.65, -24115.7, 4156.68), (0, 87, 0));
  level._id_4DD5018DF125A242[10] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-4503.86, -23946.1, 4156.25), (0, 350, 0));
  level._id_4DD5018DF125A242[11] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-4486.03, -23437.3, 4155.56), (0, 187, 0));
  level._id_4DD5018DF125A242[12] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-4771.24, -23183.3, 4302.59), (0, 86, 0));
  level._id_4DD5018DF125A242[13] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-1241.32, -18382.8, 4672.25), (0, 269, 0));
  level._id_4DD5018DF125A242[14] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-678.061, -17331.6, 4559.27), (0, 236, 0));
  level._id_4DD5018DF125A242[15] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-2561.81, -17977.8, 4859.58), (0, 295, 0));
  level._id_4DD5018DF125A242[16] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-2567.55, -17840.8, 4940.13), (0, 260, 0));
  level._id_4DD5018DF125A242[17] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-2533.95, -17570.2, 5013.05), (0, 38, 0));
  level._id_4DD5018DF125A242[18] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-2402.56, -17206.4, 4991.54), (0, 92, 0));
  level._id_4DD5018DF125A242[19] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-4679.14, -13209.7, 4700.92), (0, 283, 0));
  level._id_4DD5018DF125A242[20] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-5132.64, -12263.3, 4513.79), (0, 338, 0));
  level._id_4DD5018DF125A242[21] = spawnscriptable("un_foliage_tree_ponderosapine_small_01", (-2095.91, -10898.1, 4715.86), (0, 136, 0));
  level._id_4DD5018DF125A242[22] = spawnscriptable("un_foliage_tree_aleppopine_large_01_mp", (-2343.75, -17664.7, 4941.32), (0, 150, 0));
  level._id_4DD5018DF125A242[23] = spawnscriptable("un_foliage_tree_aleppopine_large_01_mp", (-3705.91, -13429.6, 4730.15), (0, 30, 0));
  level._id_4DD5018DF125A242[24] = spawnscriptable("un_foliage_tree_aleppopine_large_01_mp", (-540.342, -10595.4, 4884.44), (0, 213, 0));
  level._id_4DD5018DF125A242[25] = spawnscriptable("un_foliage_tree_aleppopine_large_01_mp", (-3197.15, -19217.2, 4800.03), (0, 124, 0));
  level._id_4DD5018DF125A242[26] = spawnscriptable("un_foliage_tree_eucalyptus_large_01", (-15082.8, -14766.7, 1098.2), (2, 304, 0));
  level._id_4DD5018DF125A242[27] = spawnscriptable("un_foliage_tree_aleppopine_large_01_mp", (-2729.64, -24499.8, 4153.75), (0, 0, 0));
  level._id_4DD5018DF125A242[28] = spawnscriptable("un_foliage_tree_aleppopine_large_01_mp", (-13959.9, -5079.5, 1515.37), (0, 180, 0));
  level._id_4DD5018DF125A242[29] = spawnscriptable("un_foliage_tree_juniper_large_01", (-584.049, -20232.9, 3514.14), (322, 140, 24));
  level._id_4DD5018DF125A242[30] = spawnscriptable("un_foliage_tree_juniper_large_01", (-1842.64, -10120, 4694.21), (10, 80, -3));
  level thread _id_C11E9C899803FB74();
  level waittill("area_swap_complete");

  foreach(_id_C15D48F6643B0A69 in level._id_4DD5018DF125A242) {
    if(isDefined(_id_C15D48F6643B0A69)) {
      _id_C15D48F6643B0A69 _id_7E52B56769FA7774::_id_007B67823458CD14();
      _id_C15D48F6643B0A69 freescriptable();
    }
  }

  level._id_4DD5018DF125A242 = undefined;
}

_id_C11E9C899803FB74() {
  level waittill("br_pickups_init");

  if(!isDefined(level._id_4DD5018DF125A242)) {
    return;
  }
  foreach(_id_C15D48F6643B0A69 in level._id_4DD5018DF125A242) {
    _id_C15D48F6643B0A69._id_BBC200BC77C5DB2B = 1;
    _id_7E52B56769FA7774::registerscriptableinstance(_id_C15D48F6643B0A69);
  }
}

onplayerconnect(params) {
  thread _id_09D8466C63960BBA();
}

_id_09D8466C63960BBA() {
  self endon("disconnect");

  for(;;) {
    self waittill("ascender_detach");

    if(distancesquared(self.origin, (16345, 22643, 428)) < 65536)
      self setOrigin((16348, 22625, 473));
  }
}

_id_151E13C2B2177F68() {
  if(getdvarint("dvar_44C6C09AECBD8177", 1) == 0) {
    return;
  }
  level waittill("br_pickups_init");
  scripts\engine\utility::flag_wait("create_script_initialized");
  _id_AC0E594AC96AA3A8 = 0;
  _id_03C7899636CBA8AB = scripts\engine\utility::getStructArray("loot_cleanup", "script_noteworthy");

  foreach(struct in _id_03C7899636CBA8AB) {
    if(struct.script_parameters == "cache") {
      foreach(loot in getentitylessscriptablearray(undefined, undefined, struct.origin, struct.radius)) {
        _id_7E52B56769FA7774::loothide(loot, loot _meth_EC5F4851431F3382());
        _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1;

        if(_id_AC0E594AC96AA3A8 % 10 == 0)
          waitframe();
      }

      continue;
    }

    foreach(loot in getlootscriptablearrayinradius(undefined, undefined, struct.origin, struct.radius)) {
      _id_7E52B56769FA7774::loothide(loot, loot _meth_EC5F4851431F3382());
      _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1;

      if(_id_AC0E594AC96AA3A8 % 10 == 0)
        waitframe();
    }
  }

  _id_A1BBF4BF77C13F88 = scripts\engine\utility::getStructArray("loot_cleanup_after_swap", "script_noteworthy");
  level waittill("area_swap_complete");
  waitframe();

  foreach(struct in _id_A1BBF4BF77C13F88) {
    foreach(loot in getlootscriptablearrayinradius(undefined, undefined, struct.origin, struct.radius)) {
      _id_7E52B56769FA7774::loothide(loot, loot _meth_EC5F4851431F3382());
      _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1;

      if(_id_AC0E594AC96AA3A8 % 10 == 0)
        waitframe();
    }
  }
}

_id_4E1B724288222A0F(_id_6EB04909CB5CA84D) {
  door = _id_6EB04909CB5CA84D.door;
  _id_57D3850A12CF1D8F::_id_B092780F9EC4496E(door);
}

_id_E9EAC965D8CF5767(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_87706707D1A8F420 = 2;
  _id_B5056FD27D24527A = 0;
  _id_1DF19819FC6EF3F7 = scripts\engine\utility::ter_op(istrue(instance._id_7FB2B43C09485D2C), "_model", "");
  instance setscriptablepartstate(part, "off" + _id_1DF19819FC6EF3F7);
  player _id_7D625073C6379D53::keypad_playerinteractwithkeypadloop(instance);

  if(isDefined(player))
    player _id_0B8A0932FDC35B80::playersetkeypadstateindex(_id_B5056FD27D24527A);

  wait 1;

  if(instance._id_B50F7CB6D7639B3A != _id_87706707D1A8F420)
    instance setscriptablepartstate(part, "on" + _id_1DF19819FC6EF3F7);
}

_id_525695B62DA3796F(code, _id_B075106686DFD0DF) {
  self._id_885780D268327BA4 = code.size;
  self.code = [];
  self.code["string"] = "";
  self.successfunction = _id_B075106686DFD0DF;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < code.size; _id_AC0E594AC96AA3A8++)
    self.code["string"] = self.code["string"] + code[_id_AC0E594AC96AA3A8];
}

_id_7D41F66902695017() {
  if(getdvarint("dvar_4A89DF8C0A399C51", 1) == 0) {
    return;
  }
  scripts\engine\utility::flag_wait("create_script_initialized");
  scripts\engine\utility::flag_wait("scriptables_ready");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_interior", ::_id_E9EAC965D8CF5767);
  _id_07919BB8D7505A92 = scripts\engine\utility::getStructArray("bunker_back_keypad", "script_noteworthy");

  foreach(_id_6EFE0C080EEEDD55 in _id_07919BB8D7505A92) {
    _id_6EB04909CB5CA84D = spawnscriptable("maphint_keypad_bunker_interior", _id_6EFE0C080EEEDD55.origin, _id_6EFE0C080EEEDD55.angles);

    if(_id_6EFE0C080EEEDD55.script_label == "pmc_unobserved") {
      setDvar("dvar_76EF48365C179A40", 1);
      code = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
      _id_DDDC705D1DA7078A = scripts\engine\utility::_id_7A2AAA4A09A4D250(code);
      _id_DDDC6F5D1DA70557 = scripts\engine\utility::_id_7A2AAA4A09A4D250(code);
      _id_DDDC6E5D1DA70324 = scripts\engine\utility::_id_7A2AAA4A09A4D250(code);
      _id_6EB04909CB5CA84D _id_525695B62DA3796F([_id_DDDC705D1DA7078A, _id_DDDC6F5D1DA70557, _id_DDDC6E5D1DA70324], ::_id_4E1B724288222A0F);
      _id_29EEB793C67C5C1D = scripts\engine\utility::getStruct(_id_6EFE0C080EEEDD55.target, "targetname");
      door = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(_id_29EEB793C67C5C1D.origin, 100);
      door[0]._id_8CC59FC7249E7F0F = 1;
      _id_6EB04909CB5CA84D.door = door[0];
      level._id_CC75A90D4B9108B1 = _id_6EB04909CB5CA84D.code["string"];
      _id_6EB04909CB5CA84D._id_7FB2B43C09485D2C = 1;
    }

    _id_1DF19819FC6EF3F7 = scripts\engine\utility::ter_op(istrue(_id_6EB04909CB5CA84D._id_7FB2B43C09485D2C), "_model", "");
    _id_6EB04909CB5CA84D setscriptablepartstate("maphint_keypad_bunker_interior", "on" + _id_1DF19819FC6EF3F7);
  }
}

_id_2C16D7072464DF50(_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C) {
  _id_56A15DF9CD0E7727 = getdvarint("dvar_83654F181998EB67", 5);
  _id_CCC820D8A3CBF276 = scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_56A15DF9CD0E7727 * _func_676CFE2AB64EA758());
  _id_193BA10DFA6671B4 = max(_id_7D52B05C966F0D1C - _id_CCC820D8A3CBF276, 0.0);

  if(_id_193BA10DFA6671B4 > 0)
    scripts\engine\utility::delaythread(_id_193BA10DFA6671B4, ::_id_BEAC48B4AC816417, _id_56A15DF9CD0E7727);
  else
    _id_BEAC48B4AC816417(_id_56A15DF9CD0E7727);
}

_id_BEAC48B4AC816417(_id_56A15DF9CD0E7727) {
  _id_62A9E105632784D0 = _func_F159C10D5CF8F0B4("observatory_kill_trigger", "targetname");

  if(isDefined(_id_62A9E105632784D0) && _id_62A9E105632784D0.size > 0) {
    _id_F22FB09A173DCC1C = [];
    _id_1C4F7B19D2E73AE7 = [];

    foreach(player in level.players) {
      foreach(_id_B58B1D878321B783 in _id_62A9E105632784D0) {
        if(player istouching(_id_B58B1D878321B783)) {
          _id_F22FB09A173DCC1C[_id_F22FB09A173DCC1C.size] = player;
          _id_1C4F7B19D2E73AE7[_id_1C4F7B19D2E73AE7.size] = scripts\engine\utility::_id_53C4C53197386572(player.deathtime, 0);
          break;
        }
      }
    }

    _id_8D306100D2A6CED5 = max(1, getdvarint("dvar_A9F6F791C295DCF6", 10));
    _id_B0C1DC0D743B23E0 = ceil(_id_F22FB09A173DCC1C.size / _id_8D306100D2A6CED5);
    _id_604801C77B06CBA3 = _id_56A15DF9CD0E7727 - _id_B0C1DC0D743B23E0;

    if(_id_604801C77B06CBA3 > 0)
      wait(scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_604801C77B06CBA3 * _func_676CFE2AB64EA758()));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F22FB09A173DCC1C.size; _id_AC0E594AC96AA3A8++) {
      _id_E3D55ABD84AD4CA9 = _id_F22FB09A173DCC1C[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_E3D55ABD84AD4CA9)) {
        _id_1201549466DC94BD = scripts\engine\utility::_id_53C4C53197386572(_id_E3D55ABD84AD4CA9.deathtime, 0);

        if(_id_1C4F7B19D2E73AE7[_id_AC0E594AC96AA3A8] != _id_1201549466DC94BD) {
          continue;
        }
        _id_E3D55ABD84AD4CA9._id_29A5B3784B34A6BC = 1;
        _id_E3D55ABD84AD4CA9 scripts\mp\utility\damage::_suicide(undefined, 1);
        level._id_E15EC031B92951C8 = scripts\engine\utility::_id_53C4C53197386572(level._id_E15EC031B92951C8, 0) + 1;
      }

      if(_id_AC0E594AC96AA3A8 > 0 && _id_AC0E594AC96AA3A8 % _id_8D306100D2A6CED5 == 0)
        waitframe();
    }
  }
}