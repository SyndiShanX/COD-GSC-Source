/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6df94fbd59a7dc9b.gsc
***********************************************/

main() {
  _id_0F6C4FC63EFE1CDD::main();
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_patrol_boat");
  level._id_09FAB40ED3326F8B = getDvar("dvar_6258E21B5B6B6767", "mp/subarea_tuning_mp_delta.csv");
  level._id_4D8386ECA283E9C4 = "delta_";
  level thread _id_5DEF7AF2A9F04234::_id_C08668FE290FC31A();
  setDvar("dvar_62FEF4C88F74AE7C", 0);
  _id_23D7E853EC472C58::main();
  _id_2D6DA4C0E4B3FCB6::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  _id_4FF6C6ED304E05BB::init();
  scripts\cp_mp\tripwire::init();
  _id_60E3273DF6B5F7D1::init();
  _id_72D6AF97CFC97305::init();
  _id_1584D072DD426127::init();
  _id_00FC53EDFA47F13B::init();
  _id_3C24A56641A03789::init();
  _id_648C19EB554A0DD9::init();
  _id_7DF5E129E32CD13A();
  _id_A20B7C0E2A7E1668();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level._id_4B195D3DD0024B9C = "team_hundred_ninety_four";
    level.outofboundstriggersplanetrace = getEntArray("OutOfBounds", "targetname");

    if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      scripts\cp_mp\utility\script_utility::registersharedfunc("dmz_threat_bias", "customNationality", ::_id_90ABDBF9EE65BB1B);
      scripts\cp_mp\utility\script_utility::registersharedfunc("threat_bias", "customFriendlyCheck", ::_id_50848C14636B3377);
      _id_4480C6CE37B2BDF3::_id_B71560B07A8F979D("delta");
    }

    level thread _id_0D6817631CCFAC92::main();
    level thread _id_63B29DB74B692A3D::main();
    level thread _id_7528016A78D6EAB1::main();
    level thread _id_3173CE4FEA90E4BD::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_cemetary"))
      level thread _id_30CED124CA57AB3A::main();
    else
      level thread _id_5349B6AB0EBC00C9::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_fleamarket"))
      level thread _id_0960EF8D3C58D7EE::main();
    else
      level thread _id_7F82F65AFE0DD87D::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_firestation"))
      level thread _id_64CE16563CFF36C4::main();
    else
      level thread _id_2A971F8884D4DB37::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_library"))
      level thread _id_2D3D1272F367BFE5::main();
    else
      level thread _id_423ABE1BE19FA26A::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_museum"))
      level thread _id_73F1052999066D5A::main();
    else
      level thread _id_247EB6498C0A7529::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_stadium"))
      level thread _id_6BEBE84772AE1CA5::main();
    else
      level thread _id_353DFAEB3212012A::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_station"))
      level thread _id_2D51021267F3C2B8::main();
    else
      level thread _id_215E2AC7D2D8179B::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_shoppingcenter"))
      level thread _id_5B47305659DA8DE1::main();
    else
      level thread _id_1522A481BC4F7456::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_terminal"))
      level thread _id_18756873EC8F7626::main();
    else
      level thread _id_5D6C27B395483585::main();

    if(_id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412("delta_zoo"))
      level thread _id_69CC702D97599220::main();
    else
      level thread _id_43DFFB2F38A09AB3::main();

    level thread _id_0EE8675EA1BAC5B3::main();

    if(scripts\mp\utility\game::getsubgametype() == "dmz")
      _id_4480C6CE37B2BDF3::_id_A1E18F290954A5E9();

    level._id_BBD8A18655D9495B = _id_147448F3F080C636::_id_405BF7CDE917B70E;
    level._id_F29702DDC09D1002 = _id_147448F3F080C636::_id_384465A3A8AA24F7;
    level._id_0FFA48A6A79A7224 = _id_147448F3F080C636::_id_47C84E03DCBC5AA7;
  }

  level._id_359D1318419A254D = 1;
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  level._id_529DB71B08D8F57A = getdvarint("scr_br_final_circle_override", 0);
  level._id_12885FA5DED97213 = getdvarint("dvar_433FA7CA2836C6F1", 0);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("cg_defaultWindFrequencyScale", 0.5);
  setDvar("cg_defaultWindAmplitudeScale", 0.2);
  setDvar("cg_defaultWindAreaScale", 50);
  setDvar("cg_defaultWindNoiseScale", 0.7);
  setDvar("cg_defaultWindStrength", 2);
  setDvar("cg_defaultWindDir", (1, 0, 0));
  setDvar("r_vertexDeformCutOffDist", 3000);
  setDvar("r_vertexDeformFadeDist", 1500);
  setDvar("r_st_displacementDistance", 1000);
  setdvarifuninitialized("br_infil_anim_pos", (62000, 62000, 3000));
  scripts\mp\compass::setupminimap("compass_map_mp_delta");
  level._id_1789643B227CF471 = ::_id_1789643B227CF471;
  level._id_FFAE696F4EF77D0E = ::_id_FFAE696F4EF77D0E;
  level._id_CE11405F66C0872E = "cvm2";
  level._id_B58C6275920EDF51 = "bds4";

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    _id_4480C6CE37B2BDF3::_id_DD432354AF4C9024();
    _func_EB7F544259415A09("mp_delta_dmz");
    level._id_E429F4A597493802 = [];
    level._id_E429F4A597493802[0] = "star_0_delta";
    level._id_E429F4A597493802[1] = "star_1_delta";
    level._id_E429F4A597493802[2] = "star_2_delta";
    level._id_E429F4A597493802[3] = "star_3_delta";
    level._id_E429F4A597493802[4] = "star_4_delta";
    level._id_3EED4E0BC4A30B72 = "br_delta_aieventlist";
    level._id_37DAFE68077318F5 = getdvarfloat("dvar_73FF88B5C4070A11", 0.6);
    level._id_B12667EFC8C91C0F = "veh9_jltv";
    level._id_2CDF30478FA435FF[0] = (-12350, 5660, 0);
    level._id_2CDF30478FA435FF[1] = (4020, 7935, 0);
    level._id_2CDF30478FA435FF[2] = (-6750, -9150, 0);
    level._id_2CDF30478FA435FF[3] = (9225, -8765, 0);
    _id_A9AF6F9F7A52E1EE();
    thread _id_F9D293299266375F();
    level thread _id_48730EE83464B3E1();
  } else {
    level._id_319696A4503E0E48 = 1;
    level._id_81A5664BB0C0DD5A = "deltaChopper";
    _func_EB7F544259415A09("mp_delta");
    _id_84347F88E308DBC5("br", ["04", "08", "11"]);
    _id_602A2DA0B869DA90::_id_2941161FA47C4DF0();
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_infils_ac130", "getAnimStruct", _id_602A2DA0B869DA90::_id_756E407AFF47F12F);
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_infils_ac130", "getInfilSoundbank", ::_id_59DC656C638A2D68);
    _id_66238FE4A8132007::_id_953FDF0A232D7882();
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_ending_chopper2", "getAnimPack", _id_66238FE4A8132007::_id_269CED8E728C7D83);
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_ending_chopper2", "getExfilSoundbank", ::_id_F4D75792E9D5C792);
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_ending_chopper2", "getExfilSoundPrefix", ::_id_24D1C09E3CC49748);

    if(getdvarint("dvar_16B617F24D8EEAC2", 1) > 0)
      thread _id_1E59FAB3072AA289();

    thread _id_EAB0655174D960DD();
  }

  scripts\cp_mp\utility\game_utility::_id_4B8E6239B2D87474();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.ttlos_suppressasserts = 1;
  scripts\cp_mp\utility\script_utility::registersharedfunc("mood", "onSetupMoodSet", ::_id_D0056A1B62201452);
  scripts\cp_mp\utility\script_utility::registersharedfunc("mood", "onSetMood", ::_id_1C9404B8B55DEAD7);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    brinit();

  if(getdvarint("scr_wztrain_enable", 0) > 0)
    level thread _id_617950B1774AF3F1::init();

  level thread _id_594757B74170A035::init();
  level thread _id_372D27D48C2FB6F8::init();

  if(istrue(level._id_289DF80E1DED586F)) {
    level thread _id_48814951E916AF89::_id_C8393014DD7F8AB6();
    level thread _id_48814951E916AF89::_id_571151294C1A740B(1, ["overland"]);
    level thread _id_48814951E916AF89::_id_571151294C1A740B(2, ["overland"]);
    level thread _id_48814951E916AF89::_id_571151294C1A740B(3, ["jltv"]);
  }

  level thread _id_5F903436642211AF::_id_D8DE1E0BC05F3B3A();
  level thread _id_713F089988EE955E();
  level thread _id_33B671A71410CC7B();
}

_id_8413D24B1DE421B0() {
  game["dialog"]["mood_clear"] = "mood_wzan_wrnc";
  game["dialog"]["mood_light"] = "mood_wzan_wrnm";
  game["dialog"]["mood_heavy"] = "mood_wzan_wrnx";
  level._id_D5950E8123827E35 = [];
  level._id_D5950E8123827E35["mood_clear"] = 0;
  level._id_D5950E8123827E35["mood_light"] = 0;
  level._id_D5950E8123827E35["mood_heavy"] = 0;
}

brinit() {
  level.onlowpopstart = ::_id_0865DD7703C23C87;
  level thread _id_EF079EE3D6B651AD();
  level.br_level = spawnStruct();
  level.br_level.c130_speedoverride = 1800;
  _id_45B2B4A889E633FA::setc130heightoverrides(9500, 0);
  level._id_269C8213B2C00D6B = "mp_delta_infil";
  level._id_5621A5132074DA11 = "mp_delta_infil_exterior";
  level._id_02FBC45A120A095D = "mp_delta_exfil";
  level._id_556C00D8EA5240B9 = "body_animate_jnt";
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1];
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  level.br_level._id_96BC2CCD011BA845 = (-1500, -3400, 0);
  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  _id_33DD915945FCA005 = scripts\cp_mp\parachute::getc130sealevel();
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(_id_FDFE2D4AAF8EC33D - _id_33DD915945FCA005));
  _id_2A4FBC2A0576365A();

  if(isDefined(level.br_circle_init_func))
    [[level.br_circle_init_func]]();

  _id_2695A20D4011076D::applycirclesettings();
  level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((0, 0, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((-1200, 8358, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((5175, 2242, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((-9026, 9120, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((12343, 1800, 0), 0, 2550), _id_1E4A61DB11011446::createspawnlocation((-7034, -10133, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((-13725, -4946, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((1993, -12764, 0), 0, 3000), _id_1E4A61DB11011446::createspawnlocation((10757, -6562, 0), 0, 3000)];
  level.br_badcircleareas = [_id_2695A20D4011076D::createinvalidcirclearea((24848.5, -5220.5, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((2817, 22093.5, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((-24375, -16427, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((-17130, 19891, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((-26365.5, 3116.5, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((-6159.5, -24125.5, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((13619.5, -20311, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((21578.5, 14561, 0), 10000), _id_2695A20D4011076D::createinvalidcirclearea((10939, 12186, 0), 4000), _id_2695A20D4011076D::createinvalidcirclearea((-14809, -16589, 0), 5000), _id_2695A20D4011076D::createinvalidcirclearea((10121, -2369.5, 0), 600), _id_2695A20D4011076D::createinvalidcirclearea((9077, -785.5, 0), 600), _id_2695A20D4011076D::createinvalidcirclearea((-19435, -7309, 0), 2500), _id_2695A20D4011076D::createinvalidcirclearea((-19435, -3798, 0), 2500), _id_2695A20D4011076D::createinvalidcirclearea((-17607, 9236, 0), 2500), _id_2695A20D4011076D::createinvalidcirclearea((-7210, 19140, 0), 2500), _id_2695A20D4011076D::createinvalidcirclearea((6397, 13592, 0), 4000), _id_2695A20D4011076D::createinvalidcirclearea((16964, -10943, 0), 4000), _id_2695A20D4011076D::createinvalidcirclearea((3772, -20266, 0), 4000), _id_2695A20D4011076D::createinvalidcirclearea((-3763, -347.5, 0), 800), _id_2695A20D4011076D::createinvalidcirclearea((-2921.25, -3119.75, 0), 325)];

  if(istrue(level._id_C62D39D6E6AFB119))
    _id_8E61CD66A8BF3A15();

  if(getdvarint("scr_br_mood_manager", 1) == 1) {
    _id_8413D24B1DE421B0();
    _id_5F23C51AA82AF90A = getDvar("dvar_814A58E4F810F2D8");
    _id_17E4F9DE4E9C7906 = getDvar("scr_br_moodlist_set", "delta_moodlist_fog_to_clear");

    if(isDefined(_id_5F23C51AA82AF90A) && _id_5F23C51AA82AF90A != "")
      thread _id_3099E12A7555BF85::_id_AFD4C1E75AEE7F02(_id_5F23C51AA82AF90A);
    else if(isDefined(_id_17E4F9DE4E9C7906) && _id_17E4F9DE4E9C7906 != "")
      thread _id_3099E12A7555BF85::init(_id_17E4F9DE4E9C7906);
  }

  level thread _id_3A013C09686A5016();
  _id_0D02A37FF8F86CD3 = "brstageditems:" + getDvar("dvar_804F682E65BAC1A6", "wz2_delta_staged_blueprints");
  _id_428C9AAD17E4E279 = "brstageditems:" + getDvar("dvar_85EB36AC6B2287DA", "wz2_delta_staged_items");
  level thread _id_15074130DA8A935C::init(_id_0D02A37FF8F86CD3, _id_428C9AAD17E4E279);
  level thread _id_75B994F10201E95C::init();
}

_id_0865DD7703C23C87() {
  if(!_id_1E4A61DB11011446::lowpopallowtweaks()) {
    return;
  }
  _id_2A4FBC2A0576365A(1);
  _id_2695A20D4011076D::applycirclesettings();
}

_id_2A4FBC2A0576365A(_id_E891C8F4915DFF8A) {
  _id_C4FDD0A586C8AE61 = getDvar("scr_br_circlesettings", "");

  if(!isDefined(_id_C4FDD0A586C8AE61) || _id_C4FDD0A586C8AE61 == "")
    _id_C4FDD0A586C8AE61 = "brcirclesettings:mp_delta_br_circle_settings";

  _id_2695A20D4011076D::_id_C96B267DC4F7E14A(_id_C4FDD0A586C8AE61, _id_E891C8F4915DFF8A);
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
  _id_FD2DBEAE371F9614("castle", (-9246, 9678, 1900), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("station", (14024, 3378, 1800), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("market", (-400, -200, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("zoo", (-7026, -9606, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("library", (-734, 9260, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("oldmuseum", (8740, -5344, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("firedept", (-12338, -5688, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("cemetery", (-7202, 2756, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("newmuseum", (13658, -6700, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("stadium", (1008, -9386, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("cityhall", (8070, 6954, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("floatinghouses", (-13042, -12030, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("cruiseterminal", (1418, -15260, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("shoppingcenter", (6730, 1954, 1600), _id_90416D079805B8A5);
  _id_FD2DBEAE371F9614("policestation", (4346, -2900, 1600), _id_90416D079805B8A5);
  level thread _id_5ADC69197DE334C3();
}

_id_FD2DBEAE371F9614(scriptablestate, loc, _id_90416D079805B8A5) {
  _id_6482FEB0B7568914(scriptablestate, loc, _id_90416D079805B8A5, "name_fx");
}

_id_6482FEB0B7568914(scriptablestate, loc, _id_90416D079805B8A5, _id_8A46C62F0A756DD3) {
  loc = loc + (0, 0, 500);
  _id_B243306D75CC8719 = spawn("script_model", loc);
  _id_B243306D75CC8719 setModel("iw9_tag_origin_name_fx_delta");
  _id_B243306D75CC8719.angles = _id_90416D079805B8A5;
  level.name_fx[level.name_fx.size] = _id_B243306D75CC8719;
  _id_B243306D75CC8719 setscriptablepartstate(_id_8A46C62F0A756DD3, scriptablestate);
  _id_B243306D75CC8719 forcenetfieldhighlod(1);
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

_id_EAB0655174D960DD() {
  level endon("game_ended");
  level endon("prematch_done");
  level waittill("player_spawned");
  thread scripts\engine\utility::exploder("infil_explo_fire_station_smk_column", level.players);
  thread scripts\engine\utility::exploder("infil_explo_police_station_smk_column", level.players);
  thread scripts\engine\utility::exploder("infil_explo_crash_site_smk_column", level.players);
  level._id_6AACDFCF837D5269 = level.players;

  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  while(scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
    level waittill("player_spawned", player);

    if(!scripts\engine\utility::array_contains(level._id_6AACDFCF837D5269, player)) {
      thread scripts\engine\utility::exploder("infil_explo_fire_station_smk_column", player);
      thread scripts\engine\utility::exploder("infil_explo_police_station_smk_column", player);
      thread scripts\engine\utility::exploder("infil_explo_crash_site_smk_column", player);
      level._id_6AACDFCF837D5269 = scripts\engine\utility::array_add(level._id_6AACDFCF837D5269, player);
    }
  }
}

_id_F9D293299266375F() {
  level endon("game_ended");
  level waittill("prematch_done");
  thread scripts\engine\utility::exploder("infil_explo_fire_station_smk_column");
  thread scripts\engine\utility::exploder("infil_explo_police_station_smk_column");
  thread scripts\engine\utility::exploder("infil_explo_crash_site_smk_column");
}

_id_713F089988EE955E() {
  level endon("game_ended");

  if(getdvarint("dvar_742F605ED5F90DF9", 0)) {
    return;
  }
  _id_994221FD735CA3BB = getEnt("delta_windmill_01_axle", "targetname");
  parts = getEntArray("delta_windmill_01_part", "targetname");
  _id_994221FD735CA3BB forcenetfieldhighlod(1);

  foreach(part in parts) {
    part linkTo(_id_994221FD735CA3BB);
    part forcenetfieldhighlod(1);
  }

  for(;;) {
    _id_994221FD735CA3BB rotateroll(360, 60);
    wait 60;
  }
}

_id_84347F88E308DBC5(mode, _id_58E50AEE46852766) {
  level._id_04294E392C776520 = "scn_" + mode + "_delta_c17_infil_int";
  level._id_983AB0DFCD3F73F3 = [];

  foreach(_id_698DA5AF57B757E7 in _id_58E50AEE46852766) {
    _id_438EA5A61379D529 = [];
    _id_438EA5A61379D529[0] = ["scn_" + mode + "_delta_c17_infil_solos_plr1_shot" + _id_698DA5AF57B757E7];
    _id_438EA5A61379D529[1] = ["scn_" + mode + "_delta_c17_infil_duos_plr1_shot" + _id_698DA5AF57B757E7, "scn_" + mode + "_delta_c17_infil_duos_plr2_shot" + _id_698DA5AF57B757E7];
    _id_438EA5A61379D529[2] = ["scn_" + mode + "_delta_c17_infil_trios_plr1_shot" + _id_698DA5AF57B757E7, "scn_" + mode + "_delta_c17_infil_trios_plr2_shot" + _id_698DA5AF57B757E7, "scn_" + mode + "_delta_c17_infil_trios_plr3_shot" + _id_698DA5AF57B757E7];
    _id_438EA5A61379D529[3] = ["scn_" + mode + "_delta_c17_infil_quads_plr1_shot" + _id_698DA5AF57B757E7, "scn_" + mode + "_delta_c17_infil_quads_plr2_shot" + _id_698DA5AF57B757E7, "scn_" + mode + "_delta_c17_infil_quads_plr3_shot" + _id_698DA5AF57B757E7, "scn_" + mode + "_delta_c17_infil_quads_plr4_shot" + _id_698DA5AF57B757E7];
    level._id_983AB0DFCD3F73F3[_id_698DA5AF57B757E7] = _id_438EA5A61379D529;
  }
}

_id_1E59FAB3072AA289() {
  level waittill("startChopperCrashSequence");
  thread _id_82B1CD7821DFD814();
}

_id_82B1CD7821DFD814() {
  node = spawnStruct();
  node.origin = (-648, -419, 149);
  node.angles = (0, 0, 0);
  _id_6D9B3DCB65BC5897 = node _id_0930A1E7BD882C1D::spawn_script_model("veh9_mil_air_heli_medium_delta__scripted_event", "chopper");
  _id_692FC766D262881A = node _id_0930A1E7BD882C1D::spawn_script_model("weapon_wm_missile_rpapa7", "missile");
  _id_692FC666D26285E7 = node _id_0930A1E7BD882C1D::spawn_script_model("weapon_wm_missile_rpapa7", "missile");
  scripts\engine\utility::stop_exploder("infil_explo_fire_station_smk_column");
  scripts\engine\utility::stop_exploder("infil_explo_police_station_smk_column");
  scripts\engine\utility::stop_exploder("infil_explo_crash_site_smk_column");
  thread _id_0022CC08CC134CB1("infil_explo_train_station_1", 9.3);
  thread _id_0022CC08CC134CB1("infil_explo_train_station_3", 9.45);
  thread _id_0022CC08CC134CB1("infil_explo_train_station_2", 9.9);
  thread _id_0022CC08CC134CB1("infil_explo_fire_station", 10.5);
  thread _id_0022CC08CC134CB1("infil_explo_fire_station_smk_column", 10.5);
  thread _id_0022CC08CC134CB1("infil_explo_police_station", 10.75);
  thread _id_0022CC08CC134CB1("infil_explo_police_station_smk_column", 10.75);
  thread _id_0022CC08CC134CB1("infil_explo_crash_site_smk_column", 15);
  thread _id_B005F04EA125B239(15);
  _id_6D9B3DCB65BC5897 scriptmodelplayanimdeltamotionfrompos(getanimname(level._id_1A209BD995A7FA83["wz_iw9_delta_infil_heli_crash"]), node.origin, node.angles);
  _id_692FC766D262881A scriptmodelplayanimdeltamotionfrompos(getanimname(level._id_1A209BD995A7FA83["wz_iw9_delta_infil_heli_missile"]), node.origin, node.angles);
  _id_692FC666D26285E7 scriptmodelplayanimdeltamotionfrompos(getanimname(level._id_1A209BD995A7FA83["wz_iw9_delta_infil_heli_missile_miss"]), node.origin, node.angles);
  scripts\engine\utility::delaythread(getanimlength(level._id_1A209BD995A7FA83["wz_iw9_delta_infil_heli_crash"]), ::_id_9F0672F84070205C, _id_6D9B3DCB65BC5897);
}

_id_9F0672F84070205C(chopper) {
  if(isDefined(chopper))
    chopper delete();
}

_id_0022CC08CC134CB1(_id_8927E0F5F68E6073, _id_74B5B12BB6514385) {
  wait(_id_74B5B12BB6514385);
  scripts\engine\utility::exploder(_id_8927E0F5F68E6073);
}

_id_B005F04EA125B239(_id_74B5B12BB6514385) {
  _id_7C4B8A85B234A2EA = spawn("script_model", (-2469.75, -1198, 56.5));
  _id_7C4B8A85B234A2EA setModel("art_de_intro_crash_imposter");
  wait(_id_74B5B12BB6514385);
  _id_7C4B8A85B234A2EA delete();
}

_id_D0056A1B62201452(_id_BE7C088A50041A3B) {
  if(getdvarint("dvar_67381DC877D1C2B1", 1) == 1)
    thread _id_75B994F10201E95C::_id_F7DEDAA26220B51C(_id_BE7C088A50041A3B[_id_BE7C088A50041A3B.size - 1].state.data, undefined);
}

_id_1C9404B8B55DEAD7(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD) {
  if(!isDefined(_id_1E6AB50ECBD9CFAA.state) || !isDefined(_id_1E6AB50ECBD9CFAA.state.data)) {
    return;
  }
  _id_8D3C350FD48A1EA4(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD);
  thread _id_C13FACA8A4967F71(_id_1E6AB50ECBD9CFAA, _id_1B5734DF4FC898FF(_id_1E6AB50ECBD9CFAA));
}

_id_D99FCD897DB56715(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD) {
  _id_DA17B6DEB943C805 = undefined;

  if(_id_7B22E5EA1C5758F0(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD))
    _id_DA17B6DEB943C805 = "mood_clear";
  else {
    switch (_id_1E6AB50ECBD9CFAA.state.data) {
      case "WMainlySunny":
      case "WSunny":
        _id_DA17B6DEB943C805 = undefined;
        break;
      case "WCloudy":
      case "WPartlyCloudy":
        _id_DA17B6DEB943C805 = "mood_light";
        break;
      case "WOvercast":
      case "WFog":
        _id_DA17B6DEB943C805 = "mood_heavy";
        break;
    }
  }

  return _id_DA17B6DEB943C805;
}

_id_7B22E5EA1C5758F0(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD) {
  _id_55ABBC682025A5BE = _id_826882453002D54D(_id_1E6AB50ECBD9CFAA);
  _id_68E059296B03DDC3 = _id_826882453002D54D(_id_4D896F562D6E92BD);
  return _id_55ABBC682025A5BE < _id_68E059296B03DDC3;
}

_id_826882453002D54D(_id_1E6AB50ECBD9CFAA) {
  if(!isDefined(_id_1E6AB50ECBD9CFAA) || !isDefined(_id_1E6AB50ECBD9CFAA.state) || !isDefined(_id_1E6AB50ECBD9CFAA.state.data))
    return 0;

  switch (_id_1E6AB50ECBD9CFAA.state.data) {
    case "WSunny":
      return 0;
    case "WMainlySunny":
      return 1;
    case "WPartlyCloudy":
      return 2;
    case "WCloudy":
      return 3;
    case "WFog":
      return 4;
    case "WOvercast":
      return 5;
  }
}

_id_A9AF6F9F7A52E1EE() {
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_jltv_mg");
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_jltv");
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_palfa");
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_armored_acv_6x6");
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_overland_2016");
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_mil_cargo_truck");
  _id_36967CE8EE2EA745::main();
  _id_49314540C657D352::main();
  _id_255133686F2D76C0::main();
  _id_49B221D3E244DD94::main();
  _id_261F1B574C15EAB1::main();
  _id_1D1428A3B7B402B0::main();
}

_id_59DC656C638A2D68() {
  return "mp_gamemode_br_infils_delta";
}

_id_F4D75792E9D5C792() {
  return "mp_gamemode_br_exfils_delta";
}

_id_24D1C09E3CC49748() {
  return "scn_br_delta_palfa_exfil_";
}

_id_A20B7C0E2A7E1668() {
  if(getdvarint("dvar_7FCD5131F6DBA619", 0) == 0) {
    return;
  }
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01", (-13309.5, -2060.52, 83.2672), (0, 15, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01", (6671.75, -6230.75, 228.5), (0, 194.926, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01", (6509.5, -5624.75, 229.25), (0, 194.926, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01", (8583.91, -5858.83, 348.207), (360, 14.9999, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01", (8369.41, -5062.83, 348.207), (360, 14.9999, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01b", (6435, -5347, 229.5), (0, 194.926, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01b", (6597.25, -5952, 229.5), (0, 194.926, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01b", (8543.41, -5704.08, 348.207), (360, 14.9999, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_01b", (8346.42, -4913.16, 348.207), (360, 285, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_02", (-13145.1, -1326.31, 87.1841), (0, 176.6, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_02", (7880.75, -5775, 352.75), (0, 15, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_02", (-13143.3, -1680.91, 86.9254), (0, 176.6, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_02", (7765.5, -5345.19, 352.75), (0, 15, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_03", (9542.88, -6415.5, 585), (0.699983, 285, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_03", (8767.24, -6623.34, 585), (0.699983, 285, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_03b", (8625.25, -6661.38, 585), (0.699983, 285, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_03b", (9400.89, -6453.55, 585), (0.699983, 285, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_banner_04", (7692.85, -5596.42, 455), (0, 15, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_graffiti_01", (-12852, -2283.72, 419.75), (0, 269.93, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_graffiti_02", (-13074, -2281.84, 572.5), (0, 270, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_graffiti_02", (2551.5, -3896.25, 326.75), (0, 194.72, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_graffiti_02", (5670.75, 2104.75, 346.25), (0, 165, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_giant_sign_01", (-1438.86, 11435.9, 376.148), (0, 15, 0));
  scripts\common\utility::_id_22490AAEBAAC105E("sign_event_giant_sign_02", (8376.25, -5264.75, 550.5), (0, 15.079, 0));
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
}

_id_1789643B227CF471(node) {
  return "dmz_safe_konni";
}

_id_FFAE696F4EF77D0E() {
  return "br_quest_safe_delta";
}

_id_C13FACA8A4967F71(_id_1E6AB50ECBD9CFAA, _id_CD5C6191EB926B3C) {
  level endon("game_ended");
  level notify("weather_changed");
  level endon("weather_changed");

  if(getdvarint("dvar_A2E5C5B61A91125A", 1) == 0) {
    return;
  }
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");

  if(!isDefined(_id_CD5C6191EB926B3C) || _id_CD5C6191EB926B3C == "") {
    _id_11780AFC24088D99();
    return;
  }

  for(;;) {
    _id_F0B057D390880526(_id_1E6AB50ECBD9CFAA.state.data, _id_CD5C6191EB926B3C);
    wait 1;
  }
}

_id_8D3C350FD48A1EA4(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz" || !scripts\mp\flags::gameflagexists("br_ready_to_jump") || !scripts\mp\flags::gameflag("br_ready_to_jump")) {
    return;
  }
  _id_DA17B6DEB943C805 = _id_D99FCD897DB56715(_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD);

  if(isDefined(_id_DA17B6DEB943C805) && !level._id_D5950E8123827E35[_id_DA17B6DEB943C805]) {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog(_id_DA17B6DEB943C805, 1, undefined, 0, 0, undefined, "dx_br_bds4_");
    level._id_D5950E8123827E35[_id_DA17B6DEB943C805] = 1;
  }
}

_id_F0B057D390880526(data, config) {
  foreach(agent in level.agentarray) {
    if(!isalive(agent) || isint(agent)) {
      continue;
    }
    if(!isDefined(agent._id_8E2EB9369A5EA792) || agent._id_8E2EB9369A5EA792 != data) {
      agent._id_8E2EB9369A5EA792 = data;
      _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(agent.origin);
      _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_B205D90302DA2F07);
      _id_0469C0474CA81122 = level._id_E429F4A597493802[_id_ACA1544C91A292FD];
      _id_48814951E916AF89::_id_C9DAD3876B9D8755(agent, _id_0469C0474CA81122 + config);
    }
  }
}

_id_11780AFC24088D99() {
  foreach(agent in level.agentarray) {
    if(!isalive(agent) || isint(agent)) {
      continue;
    }
    if(isDefined(agent._id_8E2EB9369A5EA792)) {
      agent._id_8E2EB9369A5EA792 = undefined;
      _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(agent.origin);
      _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_B205D90302DA2F07);
      _id_41BA451876D0900C::_id_E04DBE0BD8A25BE7(agent, _id_ACA1544C91A292FD);
    }
  }
}

_id_1B5734DF4FC898FF(_id_1E6AB50ECBD9CFAA) {
  if(!isDefined(_id_1E6AB50ECBD9CFAA.state.data)) {
    return;
  }
  switch (_id_1E6AB50ECBD9CFAA.state.data) {
    case "WPartlyCloudy":
    case "WMainlySunny":
    case "WSunny":
      return "";
    case "WOvercast":
    case "WFog":
    case "WCloudy":
      return "_fog";
    default:
      return "";
  }
}

_id_48730EE83464B3E1() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  origin = (8331.05, -5459.39, 941.5);
  angles = (0, 105.594, 90);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8356.88, -5473.21, 845.594);
  angles = (0, 15.595, 0);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8418.52, -5456.01, 845.594);
  angles = (0, 15.595, 0);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8326.12, -5456.61, 850.5);
  angles = (0, 105.594, 90);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8308.92, -5394.97, 850.5);
  angles = (0, 105.594, 90);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8393.54, -5349.81, 845.594);
  angles = (0, 195.595, 0);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8327.08, -5368.36, 845.594);
  angles = (0, 195.595, 0);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8313.84, -5397.75, 941.5);
  angles = (0, 105.594, 90);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "hardware_plywood_bare_01");
  origin = (8450.44, -5471.64, 875.5);
  angles = (275.206, 137.671, 16.469);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "un_industrial_wooden_pallet_01");
  origin = (8420.17, -5332.53, 855);
  angles = (0, 15.185, 0);
  scriptable = spawnscriptable("fortress_scriptable_props", origin, angles);
  waitframe();
  scriptable setscriptablepartstate("scriptable_prop", "fence_corrugated_metal_03_128");
}

_id_8E61CD66A8BF3A15() {
  level._id_8B96EB6B6159E33B = ["cruiseterminal_hotzone_01", "firestation_hotzone_01", "trainstation_hotzone_01", "cityhall_hotzone_01"];
  level._id_6A9278E0AE8F035A = ["townhouses_1_hotzone_01", "townhouses_1_hotzone_02", "townhouses_1_hotzone_03", "townhouses_4_hotzone_01", "townhouses_5_hotzone_01", "floatinghouses_hotzone_01", "floatinghouses_hotzone_02", "castle_hotzone_greenhouse", "castle_hotzone_stables", "moderntheater_hotzone_01", "library_hotzone_shops", "zoo_hotzone_animalcare", "zoo_hotzone_aquarium", "fleamarket_hotzone_01", "stadium_hotzone_01", "old_museum_hotzone_01", "new_museum_hotzone_01"];
  level._id_39F9E8588D3D9832 = [];
  level._id_FCA1CCEB2EA53F9E = [];
  level._id_3F257583A3D3D122 = [];
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

_id_28F1742658768328(origin, radius) {
  struct = spawnStruct();
  struct.origin = origin;
  struct.radius = radius;
  return struct;
}

_id_3A013C09686A5016() {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_FC94DCB6F87B385B = [_id_28F1742658768328((9245, -7080, 250), 50), _id_28F1742658768328((12284, 2988, 1449), 50), _id_28F1742658768328((-2993, -9956, 4), 50)];

  foreach(_id_CBF22C9EDB76E72D in _id_FC94DCB6F87B385B) {
    _id_BCB418497D44610B = getunusedlootcachepoints(_id_CBF22C9EDB76E72D.origin, _id_CBF22C9EDB76E72D.radius, 0);

    foreach(node in _id_BCB418497D44610B)
    disablelootspawnpoint(node.index);
  }
}

_id_33B671A71410CC7B() {
  level endon("game_ended");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_8F905A85FFAE1FAD = getdvarint("dvar_0F47B70EEC2C8E4E", 0);

  if(!_id_8F905A85FFAE1FAD) {
    return;
  }
  _id_56AF67819C70D986 = 0;
  _id_84F47BB1718F14B8 = getdvarint("dvar_07586FB03C6365A2", 3);
  _id_4F83B5FF49924D6A = getdvarint("dvar_81C68E87E0E2E411", 240);
  _id_4FA6BFFF49B8AB20 = getdvarint("dvar_81E9A087E109535F", 350);

  for(_id_CCFF5936325B8F9B = _id_A2F74DA500A4CE58(); _id_56AF67819C70D986 < _id_84F47BB1718F14B8; _id_56AF67819C70D986++) {
    _id_70F53C8F4C6D411E = randomintrange(_id_4F83B5FF49924D6A, _id_4FA6BFFF49B8AB20);
    wait(_id_70F53C8F4C6D411E);
    _id_1B9DE89552DD5E60(_id_CCFF5936325B8F9B);
  }

  if(isDefined(_id_CCFF5936325B8F9B))
    _id_CCFF5936325B8F9B delete();
}

_id_A2F74DA500A4CE58() {
  _id_DC02AFC36355D6F3 = getdvarvector("dvar_468B7DA57A32B94F", (627, -1742, 8041));
  _id_CCFF5936325B8F9B = spawn("script_model", _id_DC02AFC36355D6F3);
  _id_CCFF5936325B8F9B setModel("mp_delta_codbowl_basemodel");
  return _id_CCFF5936325B8F9B;
}

_id_1B9DE89552DD5E60(_id_CCFF5936325B8F9B) {
  level endon("game_ended");

  if(!isDefined(_id_CCFF5936325B8F9B)) {
    return;
  }
  _id_CCFF5936325B8F9B setscriptablepartstate("skywriter", "write");
  wait 10;
  _id_CCFF5936325B8F9B setscriptablepartstate("skywriter", "rest");
  wait 4;
}