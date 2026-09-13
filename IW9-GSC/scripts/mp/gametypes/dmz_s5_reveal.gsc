/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_s5_reveal.gsc
**************************************************/

init() {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  level._id_291B51C7AF8D1204 = 1;
  level._id_45496C9DF00F2BD4 = 1;
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_mil_lnd_mrap");
  scripts\cp_mp\utility\script_utility::registersharedfunc("jupiter_reveal", "onAgentBossDamage", ::_id_501D496BAA6E39FD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("determineReinforceType", "saba_S5Reveal", ::_id_3F683B61E590024F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("determineReinforceOrigin", "saba_S5Reveal", ::_id_223DA18CCBB9A309);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::_id_5DF8C6ABD0B861CD);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onDeadEvent", ::_id_B53617574CFBD41B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dropOnPlayerDeath", ::droponplayerdeath);
  _id_362C58E8BB39BCDA::disablefeature("player_bounty");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("radiation_cannister_s5_reveal", ::_id_561E33CF5FCF6690);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("radiation_cannister_place_prompt_s5_reveal", ::_id_F3EB76C1F716B57A);
  level._id_4FF0A3720D67CCF4 = "saba_s5reveal_silos";
  scripts\engine\utility::create_func_ref("pois_found", ::_id_04876CA4B89BF944);
  scripts\engine\utility::create_func_ref("pois_init", ::_id_DBEABC9A57AB512A);
  scripts\engine\utility::create_func_ref("missile_silos_ready_to_fire", ::_id_E4C1D509B460EE12);
  level._id_9BE6184533891E12 = getdvarfloat("dvar_205CD594960C9B03", 3);
  level._id_72E1667D06AB98DB = 1;
  level._id_45E6A8385ED4F50C = 1;
  level._id_A208B7877B64A61E = 0;
  level._id_1DCF3CD182C5039A = 0;
  level._id_BB3A493B46C82724 = 0;
  level._id_A5ED64EF4E51D0F4 = 0;
  level._id_F82AD22CC10CFB24 = 0;
  level._id_1FD6C0BD5D448B7A = 0;
  level._id_B4F4561FDB86FA25 = 1;
  level._id_8209A75B03499110 = ::_id_8209A75B03499110;
  level._id_272A9167DA8BAB6F = [(-1847.83, -12723.5, 3072), (-497.501, -13184.2, 3072), (-3780.68, -12651.6, 3072), (-1660.33, -12036.4, 3122.47), (-2343.26, -12984.2, 3072), (-8495.27, -12213, 2368), (-6519.02, -12523, 2597.98), (-3398.24, -12672.6, 3072), (648.49, -12987.5, 3175.25), (2520.18, -14302.9, 3570.05)];
  level._id_F79CDCD7196EEF74 = [(1042.81, -12785, 3238.68), (-5548.95, -12505, 2840.52), (-2921.51, -12842.5, 3281.03), (-610.511, -13056.7, 3072), (-3742.58, -12656.6, 3072)];
  level._id_B24A27D9764F8FDD = [(-9058.35, -11681.9, 2368), (2865.01, -14694.6, 3623.48), (-2973.02, -12842.9, 4320)];
  level._id_C5C06152A4FCE37D = 0;
  level._id_66287B06B2B17459 = [(1709.24, -13249.1, 3310.35), (-7678.31, -12512.3, 2368.45), (-2000, -12000, 4700), (3157.76, -14991.9, 3603.9), (-9510.14, -11308.7, 2375.65), (-3500, -14000, 4700)];
  level._id_C5E6F7A1BBEF83D0 = [[(62, -42, -223), (0, 0, 0)], [(80, -48, -223), (0, 0, 0)], [(71, -50, -223), (0, 0, 0)], [(80, -40, -223), (0, 0, 0)], [(71, -41, -223), (0, 0, 0)], [(62, -51, -223), (0, 0, 0)], [(53, -51, -223), (0, 0, 0)], [(53, -42, -223), (0, 0, 0)], [(75, 48, -223), (0, 0, 0)], [(76, 39, -223), (0, 0, 0)], [(67, 39, -223), (0, 0, 0)], [(66, 48, -223), (0, 0, 0)], [(57, 48, -223), (0, 0, 0)], [(58, 39, -223), (0, 0, 0)], [(-36, 52, -223), (0, 0, 0)], [(-36, 43, -223), (0, 0, 0)], [(-36, 34, -223), (0, 0, 0)], [(-128, 52, -223), (0, 0, 0)], [(-128, 43, -223), (0, 0, 0)], [(-128, 34, -223), (0, 0, 0)], [(-120, 45, -213), (90, 0, 0)], [(-120, 35, -213), (90, 0, 0)], [(-80, 45, -213), (90, 0, 0)], [(-80, 35, -213), (90, 0, 0)], [(-28, 45, -213), (90, 0, 0)], [(-28, 35, -213), (90, 0, 0)], [(12, 45, -213), (90, 0, 0)], [(12, 35, -213), (90, 0, 0)], [(-210, 45, -213), (90, 0, 0)], [(-210, 35, -213), (90, 0, 0)], [(-170, 45, -213), (90, 0, 0)], [(-170, 35, -213), (90, 0, 0)]];
  level._id_E0590C3F9664968C = [(-10338, -10702, 2354), (-4303, -14213, 4734), (5224, -15978, 3463)];
  level._id_B928FB4FD62F154D = [(-1265.72, -13066.5, 3072), (-2681.86, -10754.7, 3072), (-3723.86, -11694.1, 3072)];
  level._id_2CBAC3F6932A1512 = [];
  level._id_2CBAC3F6932A1512[level._id_2CBAC3F6932A1512.size] = spawn("trigger_radius", (0, -12000, 3000), 0, 8000, 20000);
  level._id_2CBAC3F6932A1512[level._id_2CBAC3F6932A1512.size] = spawn("trigger_radius", (-3000, -21000, 3000), 0, 6000, 20000);
  level._id_349709753E702CAF = getdvarint("dvar_0573696ED15EA8A0", 30);
  level._id_2C589D7F94E04811 = getdvarint("dvar_6265CBD34EE1F636", 25);
  level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_death", ::respawn);
  level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::onplayerconnect);
  level thread initdialog();
  setomnvar("ui_reveal_mute_players", 1);
  scripts\engine\utility::flag_wait("create_script_initialized");
  _id_E4580E8645FFA310 = scripts\engine\utility::getStructArray("jltv_s5reveal", "script_noteworthy");
  _id_99D884BAC160D29C = scripts\engine\utility::getStructArray("reveal_dirtbike", "script_noteworthy");
  _id_8D05B7AD724A79B9 = scripts\engine\utility::getStructArray("reveal_atv", "script_noteworthy");
  _id_1DC65C29F9FE4EE0 = scripts\engine\utility::getStructArray("missile_silo", "targetname");
  level._id_0F62895BA192058F = scripts\engine\utility::getStructArray("s5_gas_barrel", "script_noteworthy");
  level._id_B94570229276D11F = scripts\engine\utility::getStructArray("s5_gas_canister", "script_noteworthy");
  level._id_C64D4CBA4748D9B1 = scripts\engine\utility::getStructArray("s5_concrete_explosion", "script_noteworthy");
  level._id_613667408830E919 = scripts\engine\utility::getStructArray("exfil_S5reveal", "script_noteworthy");
  level._id_F92F39BCC87A4C65 = scripts\engine\utility::getStructArray("elevator_car", "script_noteworthy");
  level._id_0585B9FBE7037F70 = scripts\engine\utility::getStructArray("ammo_restock_spawn", "script_noteworthy");
  level._id_65C18FB3F0546B98 = _func_F159C10D5CF8F0B4("reveal_bunker_noent_info", "script_noteworthy")[0];
  level._id_E9B21B65FF08BB29 = [];

  foreach(respawn in scripts\engine\utility::getStructArray("reveal_respawn", "script_noteworthy")) {
    _id_3286783A08F63287 = scripts\engine\utility::getStruct(respawn.targetname, "target");
    _id_3286783A08F63287.target = respawn;
    _id_6D399A908D913B0B = _id_3286783A08F63287.origin - respawn.origin;
    respawn.angles = vectortoangles((_id_6D399A908D913B0B[0], _id_6D399A908D913B0B[1], 0));
    level._id_E9B21B65FF08BB29[level._id_E9B21B65FF08BB29.size] = _id_3286783A08F63287;
  }

  level._id_AAB9F6CFC50F372F = ::_id_A5C6FCDA083F1AFF;
  level._id_2C4E8C67F6F62117 = ::_id_7AA3B467CAD0F793;

  foreach(exfil in level._id_613667408830E919)
  exfil.info = _id_5307834CD39B435C::_id_A4181028915C44FA(exfil, 0);

  while(!isDefined(level._id_6A4C9FBD7AA58544) || !isDefined(level._id_6A4C9FBD7AA58544["trapper"]))
    waitframe();

  _id_63B3F723EC33DB92::_id_C3D56FA7478E2954(level._id_6A4C9FBD7AA58544["trapper"]);
  level._id_E4580E8645FFA310 = [];

  foreach(_id_18487FA6F3B655D3 in _id_1DC65C29F9FE4EE0) {
    _id_E4B64CEF78C789DA = sortbydistance(_id_E4580E8645FFA310, _id_18487FA6F3B655D3.origin);
    level._id_E4580E8645FFA310[level._id_E4580E8645FFA310.size] = _id_E4B64CEF78C789DA[0];
    _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_55CF921EFA4CBD09(_id_E4B64CEF78C789DA[1].origin);
    _id_2358D99F280E7480 = "veh9_jltv_mg";

    if(_id_B205D90302DA2F07 == "saba_cemetery" || _id_B205D90302DA2F07 == "saba_fishtwn" || _id_B205D90302DA2F07 == "saba_mtntwn" || _id_B205D90302DA2F07 == "saba_caves") {
      _id_E4B64CEF78C789DA[1].origin = _id_E4B64CEF78C789DA[1].origin + (0, 0, 200);
      _id_2358D99F280E7480 = "little_bird";
    }

    scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_2358D99F280E7480, _id_E4B64CEF78C789DA[1]);
    scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", _id_E4B64CEF78C789DA[2]);
  }

  foreach(_id_2FB89A142BF8CEF4 in _id_99D884BAC160D29C)
  scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_civ_lnd_dirt_bike", _id_2FB89A142BF8CEF4);

  foreach(_id_6E6E897EECC727AD in _id_8D05B7AD724A79B9)
  scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", _id_6E6E897EECC727AD);

  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  setomnvarforallclients("ui_br_inventory_disabled", 0);
  level thread _id_F9769D6C9006EFD1();
  wait 3;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_silo_revealed", level.players);
}

_id_A692B5B8ADAD2899(_id_C45248FDF60A7B9A) {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C45248FDF60A7B9A.origin);
  _id_48814951E916AF89::_id_374ECACAD63BB411(999999, _id_B205D90302DA2F07, "Missile Silo Captured");
  _id_61152018CC47C0C7 = level._id_A2B890D129C64761._id_A9375F419858B31D > 0 && level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF == level._id_A2B890D129C64761._id_A9375F419858B31D;

  if(isDefined(_id_C45248FDF60A7B9A._id_AAC94CE6A0278A36) && isDefined(_id_C45248FDF60A7B9A._id_AAC94CE6A0278A36.triggerenterents)) {
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_silo_captured", _id_C45248FDF60A7B9A._id_AAC94CE6A0278A36.triggerenterents);

    foreach(player in _id_C45248FDF60A7B9A._id_AAC94CE6A0278A36.triggerenterents) {
      if(isPlayer(player)) {
        scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "jupiter_reveal_capture_missile_silo", 1);
        player thread _id_8A61C99BBF018323(scripts\engine\utility::ter_op(_id_61152018CC47C0C7, "s5_missile_silo_secured", "s5_mission_silo_secured_remaining"));
      }
    }
  }

  if(_id_61152018CC47C0C7) {
    thread _id_CDA77FEBC33CD363();

    foreach(_id_A6487FB1572C9B44 in level._id_A2B890D129C64761._id_DE0C0A02B71959F5) {
      if(isDefined(_id_A6487FB1572C9B44.objid)) {
        scripts\mp\objidpoolmanager::returnobjectiveid(_id_A6487FB1572C9B44.objid);
        _id_A6487FB1572C9B44.objid = undefined;
      }
    }
  } else
    thread _id_0333013646A6A2E9(_id_C45248FDF60A7B9A);

  level thread _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("veh9_mil_lnd_mrap", sortbydistance(level._id_E4580E8645FFA310, _id_C45248FDF60A7B9A.origin)[0]);
  setomnvar("ui_reveal_event_silos_captured", level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF);
}

_id_0333013646A6A2E9(_id_A6487FB1572C9B44) {
  waitframe();
  _id_54EBF2CDC6C9DFDC = _id_611B35D0279EB120::_id_8DBD624CAADBBA39(_id_A6487FB1572C9B44);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_54EBF2CDC6C9DFDC);
  scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(_id_54EBF2CDC6C9DFDC, 1, 2);
  objective_setownerteam(_id_54EBF2CDC6C9DFDC, "axis");
}

_id_BD92CC983BD9E5E0() {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  if(!isDefined(level._id_E4580E8645FFA310) || level._id_E4580E8645FFA310.size == 0) {
    return;
  }
  _id_1725B4E531E7EF35 = getdvarint("dvar_997E4BED017BBD26", 600);
  _id_1C2E3619F4154F5F = int(scripts\mp\utility\game::gettimepassed() / 1000 + _id_1725B4E531E7EF35);
  setDvar("scr_br_timelimit", _id_1C2E3619F4154F5F);
  scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", _id_1C2E3619F4154F5F);
  setomnvar("ui_hardpoint_timer", gettime() + _id_1725B4E531E7EF35 * 1000);
  level._id_CEDD53BFC3112D91 = getdvarint("dvar_F9E53CE16E2B5FD0", 30);
  level thread _id_7FC4CA382A1DC4C0(_id_1725B4E531E7EF35);
  level thread _id_2E1897B4338E9597();
  waitframe();
  level._id_F82AD22CC10CFB24 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  level thread _id_4D8595A330859EBA();
  level thread _id_FF7A4950C869224F(_id_1725B4E531E7EF35);
  level thread _id_6C0F6DC7289CD6D5();
  _id_254E23DAB8D883D4 = getdvarfloat("dvar_B96F58967A52016B", 5);
  _id_1174ABEDBEFE9ADA::_id_E97390ED5BC4FE34();
  _id_1174ABEDBEFE9ADA::_id_EA5FB9090223B855(_id_1174ABEDBEFE9ADA::_id_F3FB60F986F267C5(), getdvarfloat("dvar_C2340A9BDE5FBFEB", 6200), _id_254E23DAB8D883D4);
  level thread _id_593D87573BBF3FEF();
  wait(_id_254E23DAB8D883D4);
  level thread _id_EF236D1DE4841E11();
  level._id_AAB9F6CFC50F372F = undefined;
  _id_F86EAEB241979F99 = 100000000;

  foreach(_id_FE4FFC4A768BC0D3 in level._id_0585B9FBE7037F70) {
    if(distance2dsquared(_id_FE4FFC4A768BC0D3.origin, (-2000, -12000, 4700)) < _id_F86EAEB241979F99)
      spawnscriptable("military_ammo_restock_noent", _id_FE4FFC4A768BC0D3.origin, _id_FE4FFC4A768BC0D3.angles);
  }

  level._id_0585B9FBE7037F70 = undefined;
  level thread _id_896104DAF7A5878C();

  foreach(player in level.players) {
    player setclientomnvar("ui_mission_checklist_step", 1);
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "jupiter_reveal_observatory_destroyed", 1);
  }

  level thread _id_8F1B9042D7FDFCDA();
  level thread _id_C52DAA600FD711F2();
  level thread _id_19D088DC832A3F71();
  level._id_27ACC3A1E116209D = getdvarfloat("dvar_DBFE424867AB3E92", 0.05);
  _id_822D3D25B3112ED3();
}

_id_6C0F6DC7289CD6D5() {
  wait 4;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_observatory_destroyed", level.players);
  wait 5.5;
  playcinematicforall("mp_reveal_splash_travel_observatory", 1);

  foreach(player in level.players)
  player thread _id_74697C539EEF5823(15.5);
}

_id_7AA3B467CAD0F793() {
  _id_07C40FA80892A721::givestartingarmor();
}

initdialog() {
  level waittill("br_dialog_initialized");
  game["dialog"]["deploy_squad_leader"] = "";
  game["dialog"]["match_start"] = "";
  _id_6D6D72626F148F1C("reveal_phone_dx_1", "dx_br_bds5_revl_mkrv_drp3");
  _id_6D6D72626F148F1C("reveal_phone_dx_2", "dx_br_bds5_revl_mkrv_drp4");
  _id_6D6D72626F148F1C("reveal_phone_dx_3", "dx_br_bds5_revl_mkrv_drp6");
  _id_6D6D72626F148F1C("reveal_phone_dx_4", "dx_br_bds5_revl_mkrv_drp7");
  _id_6D6D72626F148F1C("reveal_phone_dx_5", "dx_br_bds5_revl_mkrv_drp8");
  _id_6D6D72626F148F1C("s5_missile_silo_mission", "dx_br_bds5_revl_grav_nflm");
  _id_6D6D72626F148F1C("s5_missile_silo_nearby", "dx_br_bds5_revl_grav_slnr");
  _id_6D6D72626F148F1C("s5_missile_silo_halfway", "dx_br_bds5_revl_grav_slcp");
  _id_6D6D72626F148F1C("s5_missile_silo_warning", "dx_br_bds5_revl_grav_slfw");
  _id_6D6D72626F148F1C("s5_missile_silo_failure", "dx_br_bds5_revl_grav_slfl");
  _id_6D6D72626F148F1C("s5_missile_silo_secured", "dx_br_bds5_revl_grav_slct");
  _id_6D6D72626F148F1C("s5_mission_silo_secured_remaining", "dx_br_bds5_revl_grav_scps");
  _id_6D6D72626F148F1C("s5_missile_silo_launching1", "dx_br_bds5_revl_grav_slfr");
  _id_6D6D72626F148F1C("s5_missile_silo_vehicles", "dx_br_bds5_revl_grav_slvh");
  _id_6D6D72626F148F1C("s5_airstrike_friendly", "dx_br_bds5_revl_grav_slmr");
  _id_6D6D72626F148F1C("s5_airstrike_enemy", "dx_br_bds5_revl_grav_sloc");
  _id_6D6D72626F148F1C("s5_reinforcements_enemy", "dx_br_bds5_revl_grav_slrn");
  _id_6D6D72626F148F1C("s5_gas_canisters_mission", "dx_br_bds5_revl_grav_bsrv");
  _id_6D6D72626F148F1C("s5_gas_canister_warning", "dx_br_bds5_revl_grav_cnnw");
  _id_6D6D72626F148F1C("s5_gas_canister_failure", "dx_br_bds5_revl_grav_cnsf");
  _id_6D6D72626F148F1C("s5_gas_canister_success", "dx_br_bds5_revl_grav_cnsl");
  _id_6D6D72626F148F1C("s5_gas_canister_success_time_remaining", "dx_br_bds5_revl_grav_cnss");
  _id_6D6D72626F148F1C("s5_mission_time_warning1", "dx_br_bds5_revl_grav_xfw1");
  _id_6D6D72626F148F1C("s5_mission_time_warning2", "dx_br_bds5_revl_grav_xfw2");
  _id_6D6D72626F148F1C("s5_mission_time_warning3", "dx_br_bds5_revl_grav_xfw3");
  _id_6D6D72626F148F1C("s5_exfil_failure", "dx_br_bds5_revl_grav_xflf");
  _id_6D6D72626F148F1C("s5_exfil_success", "dx_br_bds5_revl_grav_mssc");
}

_id_6D6D72626F148F1C(_id_57E8E2D401F79EF6, _id_28661639ABEDBE9F) {
  _id_4D497C680119802D = getDvar(_func_2EF675C13CA1C4AF("dvar_026E2682098DE833", _id_57E8E2D401F79EF6));

  if(isDefined(_id_4D497C680119802D) && _id_4D497C680119802D != "") {
    if(_id_4D497C680119802D == "UNDEFINED") {
      return;
    }
    _id_28661639ABEDBE9F = _id_4D497C680119802D;
  }

  game["dialog"][_id_57E8E2D401F79EF6] = _id_28661639ABEDBE9F;
}

_id_1DB5FF7063481DA7(_id_A1093166DE09E6B8) {
  return isDefined(_id_A1093166DE09E6B8) && _id_A1093166DE09E6B8 == "brloot_reveal_agent_radio";
}

_id_1FB0A9B18699986B() {
  level endon("game_ended");
  level._id_E7C211560EAA6CD4 = scripts\engine\utility::array_add_safe(level._id_E7C211560EAA6CD4, self);

  while(isDefined(self)) {
    _id_68D9E792FE9DEF4D = self getscriptablepartstate("brloot_reveal_agent_radio");

    if(_id_68D9E792FE9DEF4D == "visible") {
      break;
    }

    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player) && istrue(player._id_082088136972445A))
      _id_E709B8BB0D563DD0(player);
  }
}

_id_1C4B8BC4339E2C48(instance) {
  level endon("game_ended");
  self endon("disconnect");
  instance._id_373BD0CED86AE71E = scripts\engine\utility::array_add_safe(instance._id_373BD0CED86AE71E, self);
  instance thread _id_E264A0919174A689();
  playsoundatpos(instance.origin, "mp_dmz_overseer_radio_sweep");
  thread _id_E8D59D30BD3B2F57(instance);

  if(isPlayer(self))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "jupiter_reveal_phones_used", 1);

  level._id_BB3A493B46C82724 = level._id_BB3A493B46C82724 + 1;
}

_id_E709B8BB0D563DD0(player) {
  self disablescriptableplayeruse(player);
  self._id_9691215B2722B815 = scripts\engine\utility::_id_6D6AF8144A5131F1(self._id_9691215B2722B815, player);
}

_id_04DD1A484EC8C461(player) {
  self enablescriptableplayeruse(player);

  if(isDefined(self._id_9691215B2722B815))
    self._id_9691215B2722B815 = scripts\engine\utility::array_remove(self._id_9691215B2722B815, player);
}

_id_E264A0919174A689() {
  self setscriptablepartstate("brloot_reveal_agent_radio", "pulse");
  wait 1;
  self setscriptablepartstate("brloot_reveal_agent_radio", "visible");

  foreach(player in self._id_9691215B2722B815) {
    if(isDefined(player))
      self disablescriptableplayeruse(player);
  }
}

_id_8A61C99BBF018323(dialog, delay) {
  self endon("disconnect");

  if(isDefined(delay))
    wait(delay);

  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  if(!isDefined(_id_CB3339ECE72DBDEB)) {
    return;
  }
  self queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 10);
  _id_1499E7C2D69E0074 = lookupsoundlength(_id_CB3339ECE72DBDEB, 1);
  wait(scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_1499E7C2D69E0074));
}

_id_13C4FF9B1A423445(dialog, delay) {
  foreach(player in level.players)
  player thread _id_8A61C99BBF018323(dialog, delay);
}

_id_E8D59D30BD3B2F57(instance) {
  _id_D400693A1B60AE2A = 16.5;

  foreach(radio in level._id_E7C211560EAA6CD4) {
    if(isDefined(radio))
      radio _id_E709B8BB0D563DD0(self);
  }

  _id_E505A1368531E194 = self getplayerdata("mp", "revealLinesHeard");

  if(_id_E505A1368531E194 >= 5) {
    return;
  }
  self._id_082088136972445A = 1;
  self endon("disconnect");
  _id_0C3BEF2521F4B67E = _id_E505A1368531E194 + 1;

  switch (_id_0C3BEF2521F4B67E) {
    case 1:
      _id_D400693A1B60AE2A = 13.6;
      break;
    case 2:
      _id_D400693A1B60AE2A = 7;
      break;
    case 3:
      _id_D400693A1B60AE2A = 14.5;
      break;
    case 4:
      _id_D400693A1B60AE2A = 3.3;
      break;
    case 5:
      _id_D400693A1B60AE2A = 16.5;
      break;
  }

  dialog = "reveal_phone_dx_" + _id_0C3BEF2521F4B67E;
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];
  self playcinematicforplayer("mp_reveal_splash_drop_phone", 1);
  wait 1;

  if(isDefined(_id_CB3339ECE72DBDEB)) {
    thread _id_2CF726FDB9AB533B(_id_D400693A1B60AE2A);
    self queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 10, undefined, undefined, self.origin);
    wait(_id_D400693A1B60AE2A);
  }

  _id_E505A1368531E194 = int(min(_id_E505A1368531E194 + 1, 5));
  self setplayerdata("mp", "revealLinesHeard", _id_E505A1368531E194);
  self._id_082088136972445A = undefined;

  foreach(radio in level._id_E7C211560EAA6CD4) {
    if(isDefined(radio)) {
      if(!isDefined(radio._id_373BD0CED86AE71E) || !scripts\engine\utility::array_contains(radio._id_373BD0CED86AE71E, self))
        radio _id_04DD1A484EC8C461(self);
    }
  }
}

_id_2CF726FDB9AB533B(waittime) {
  if(!isDefined(waittime)) {
    return;
  }
  self setsoundsubmix("iw9_mp_jup_reveal_phones", 0.5);
  wait(waittime);
  self clearsoundsubmix("iw9_mp_jup_reveal_phones", 1);
}

_id_74697C539EEF5823(waittime) {
  if(!isDefined(waittime)) {
    return;
  }
  self setsoundsubmix("iw9_mp_jup_reveal_binks", 0.5);
  wait(waittime);
  self clearsoundsubmix("iw9_mp_jup_reveal_binks", 1);
}

_id_F9769D6C9006EFD1() {
  while(!isDefined(level._id_A2B890D129C64761._id_DE0C0A02B71959F5))
    waitframe();

  foreach(_id_A6487FB1572C9B44 in level._id_A2B890D129C64761._id_DE0C0A02B71959F5) {
    thread _id_59015BF72E44EC8E(_id_A6487FB1572C9B44);
    thread _id_1F04C5E36BA534DC(_id_A6487FB1572C9B44);
    thread _id_89E560C0A66002BC(_id_A6487FB1572C9B44);
  }

  thread _id_ED1C6692EACBAD48();
}

_id_59015BF72E44EC8E(_id_A6487FB1572C9B44) {
  level endon("game_ended");
  _id_A6487FB1572C9B44 endon("missile_silo_captured");

  for(;;) {
    wait 0.1;

    if(isDefined(_id_A6487FB1572C9B44._id_20CC28D3805BC6DF) && _id_A6487FB1572C9B44._id_20CC28D3805BC6DF > 0.5) {
      foreach(player in _id_A6487FB1572C9B44._id_AAC94CE6A0278A36.triggerenterents)
      player thread _id_8A61C99BBF018323("s5_missile_silo_halfway");

      return;
    }
  }
}

_id_89E560C0A66002BC(_id_A6487FB1572C9B44) {
  level endon("game_ended");
  _id_A6487FB1572C9B44 endon("missile_silo_captured");
  scripts\mp\flags::_id_1240434F4201AC9D("infil_animatic_complete");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");

  while(scripts\engine\utility::_id_53C4C53197386572(_id_A6487FB1572C9B44._id_20CC28D3805BC6DF, 0.0) <= 0.001)
    waitframe();

  _id_4857D217C112F61C = getdvarfloat("dvar_9487594AB0FAD60A", 1000);
  _id_9619060264EEA3D9 = getdvarfloat("dvar_20D0818069DF40AF", 300);
  _id_B2347D2FDE89E453 = getdvarfloat("dvar_A244079C61CF41B3", 3000.0);
  _id_48814951E916AF89::_id_353FECD1549F5F42(_id_A6487FB1572C9B44.origin, _id_B2347D2FDE89E453, undefined, 20, undefined, _id_4857D217C112F61C, _id_9619060264EEA3D9);
}

_id_1F04C5E36BA534DC(_id_A6487FB1572C9B44) {
  level endon("game_ended");
  _id_A6487FB1572C9B44 endon("missile_silo_captured");
  scripts\mp\flags::_id_1240434F4201AC9D("infil_animatic_complete");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_08AB4F86F153BF6C = getdvarfloat("dvar_46DD9D05B7B1FEC6", 500);
  _id_4857D217C112F61C = getdvarfloat("dvar_9487594AB0FAD60A", 1000);
  _id_9619060264EEA3D9 = getdvarfloat("dvar_20D0818069DF40AF", 300);
  _id_C9CE98DB0ED15AF6 = getDvar("dvar_05FB91C5197162EA", "0.01,0,0,0,0,NA,1.0,6,9,18,1,mission");

  if(_id_C9CE98DB0ED15AF6 == "") {
    return;
  }
  _id_C9CE98DB0ED15AF6 = strtok(_id_C9CE98DB0ED15AF6, ",", 1);
  _id_A6487FB1572C9B44._id_B7EE101DFA3E88D5 = 0;
  _id_30A19C1C68D105C4 = 6;

  for(_id_000EBC1C0250FDD3 = 0; _id_000EBC1C0250FDD3 < _id_C9CE98DB0ED15AF6.size; _id_000EBC1C0250FDD3 = _id_000EBC1C0250FDD3 + _id_30A19C1C68D105C4) {
    _id_884230D6B8501601 = float(_id_C9CE98DB0ED15AF6[_id_000EBC1C0250FDD3]);
    _id_3CB47C2324044576 = int(_id_C9CE98DB0ED15AF6[_id_000EBC1C0250FDD3 + 1]);
    _id_8D72F0D9DF1C1BFD = int(_id_C9CE98DB0ED15AF6[_id_000EBC1C0250FDD3 + 2]);
    _id_94895238307EF4E9 = int(_id_C9CE98DB0ED15AF6[_id_000EBC1C0250FDD3 + 3]);
    _id_2D5DFE201EB093CF = float(_id_C9CE98DB0ED15AF6[_id_000EBC1C0250FDD3 + 4]);
    _id_5545A6A5723C03EE = _id_C9CE98DB0ED15AF6[_id_000EBC1C0250FDD3 + 5];

    while(scripts\engine\utility::_id_53C4C53197386572(_id_A6487FB1572C9B44._id_20CC28D3805BC6DF, 0.0) < _id_884230D6B8501601) {
      waitframe();

      if(_id_A6487FB1572C9B44._id_B7EE101DFA3E88D5 <= _id_8D72F0D9DF1C1BFD && _id_3CB47C2324044576 > 0) {
        if(_id_2D5DFE201EB093CF > 0)
          wait(_id_2D5DFE201EB093CF);

        while(_id_A6487FB1572C9B44._id_B7EE101DFA3E88D5 < _id_94895238307EF4E9) {
          _id_ECC77591453C1686 = randomfloat(360);
          _id_E7046B13C30B661F = cos(_id_ECC77591453C1686) * _id_08AB4F86F153BF6C;
          _id_A007BC947C01F0EC = sin(_id_ECC77591453C1686) * _id_08AB4F86F153BF6C;
          _id_086A890534BA7BDE = (_id_A6487FB1572C9B44.origin[0] + _id_E7046B13C30B661F, _id_A6487FB1572C9B44.origin[1] + _id_A007BC947C01F0EC, _id_A6487FB1572C9B44.origin[2]);
          agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(_id_3CB47C2324044576, _id_086A890534BA7BDE, "high", _id_5545A6A5723C03EE, "missile_silo", undefined, undefined, undefined, undefined, "Helicopter", undefined, undefined, undefined, "ru");

          if(isDefined(agents)) {
            foreach(agent in agents) {
              if(isDefined(agent) && !istrue(agent.ignoreme)) {
                _id_A6487FB1572C9B44._id_B7EE101DFA3E88D5++;
                agent thread _id_89FA5592C342B6CC(_id_A6487FB1572C9B44);
              }
            }
          }

          wait 0.5;
        }
      }
    }
  }
}

_id_C7C1539889BFC8E8(_id_A6487FB1572C9B44) {
  self endon("death");

  while(isDefined(self.vehicle))
    wait 0.1;

  _id_120270BD0A747A35::_id_A5117518725DA028(self, _id_A6487FB1572C9B44.origin, undefined, 400);
}

_id_89FA5592C342B6CC(_id_A6487FB1572C9B44) {
  self waittill("death");

  if(isDefined(_id_A6487FB1572C9B44))
    _id_A6487FB1572C9B44._id_B7EE101DFA3E88D5--;
}

_id_B49FBD71F84AFFB5(_id_01DB0C612593F172) {
  level endon("game_ended");
  self endon("disconnect");
  _id_01DB0C612593F172 endon("missile_silo_captured");

  for(;;) {
    wait 0.5;

    if(distancesquared(_id_01DB0C612593F172.origin, self.origin) < 9000000) {
      _id_8A61C99BBF018323("s5_missile_silo_nearby");
      return;
    }
  }
}

_id_CDA77FEBC33CD363() {
  _id_371B4C2AB5861E62::_id_841F001AE930B5E4("s5_reveal_agents_ignore");
  _id_371B4C2AB5861E62::_id_841F001AE930B5E4("s5_reveal_agents_hostile");
  _id_371B4C2AB5861E62::_id_841F001AE930B5E4("s5_reveal_players");
  _id_1BC9B0CC6A30018A = [];
  _id_7A27C9558344447A = [];

  foreach(player in level.players) {
    _id_371B4C2AB5861E62::_id_CA2ADCE5C7865C20(player, "s5_reveal_players");
    _id_FE1DC6BEF2E005EC = scripts\common\utility::_id_0A92D0739B2373DF(player.origin, 3000, 0);

    foreach(agent in _id_FE1DC6BEF2E005EC) {
      if(!isagent(agent)) {
        continue;
      }
      if(isPlayer(agent)) {
        continue;
      }
      if(isDefined(_id_1BC9B0CC6A30018A[agent.guid])) {
        continue;
      }
      _id_1BC9B0CC6A30018A[agent.guid] = 1;
      _id_7A27C9558344447A[_id_7A27C9558344447A.size] = [player, agent];
      _id_371B4C2AB5861E62::_id_58203C3739D2D0C6(agent, "s5_reveal_agents_ignore");
    }
  }

  _id_371B4C2AB5861E62::_id_3ACCE87FED325C8F("s5_reveal_agents_ignore", "s5_reveal_players");
  _id_6C38C0053CDDBB5D = 0;
  _id_938583E2CC686885 = 0;
  _id_12AACD7764EE86F5 = 0;

  for(;;) {
    if(_id_12AACD7764EE86F5 == 0 && _id_938583E2CC686885 > 0)
      wait 3.0;
    else
      wait 0.1;

    if(_id_7A27C9558344447A.size == 0) {
      break;
    }

    if(_id_938583E2CC686885 > 5) {
      break;
    }

    _id_12AACD7764EE86F5 = (_id_12AACD7764EE86F5 + 1) % _id_7A27C9558344447A.size;

    if(_id_12AACD7764EE86F5 == 0)
      _id_938583E2CC686885 = _id_938583E2CC686885 + 1;

    _id_F878B50DAB83B45F = _id_7A27C9558344447A[_id_12AACD7764EE86F5];
    player = _id_F878B50DAB83B45F[0];
    target = _id_F878B50DAB83B45F[1];

    if(distance(player.origin, target.origin) < 300) {
      continue;
    }
    if(!isalive(target)) {
      _id_7A27C9558344447A[_id_12AACD7764EE86F5] = _id_7A27C9558344447A[_id_7A27C9558344447A.size - 1];
      _id_7A27C9558344447A[_id_7A27C9558344447A.size - 1] = undefined;
      continue;
    }

    streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", player);
    _id_D77253C873D2B420 = anglesToForward(player getplayerangles());
    _id_558047C7AC5A2D65 = anglesToForward(player.angles);
    _id_3C5A1B26C6973C2A = anglestoright(player.angles);
    _id_FA378E997A33A137 = player scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(target.origin, 150, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A);
    player thread scripts\cp_mp\killstreaks\toma_strike::tomastrike_firestrike(1, _id_FA378E997A33A137, streakinfo);

    if(!_id_6C38C0053CDDBB5D) {
      _id_6C38C0053CDDBB5D = 1;
      player thread _id_8A61C99BBF018323("s5_airstrike_friendly");
    }
  }

  wait 30.0;

  foreach(_id_CBF22C9EDB76E72D in _id_7A27C9558344447A)
  _id_371B4C2AB5861E62::_id_58203C3739D2D0C6(_id_CBF22C9EDB76E72D[1], "s5_reveal_agents_hostile");
}

onplayerconnect(params) {
  self endon("disconnect");
  self setclientomnvar("ui_br_inventory_disabled", 1);
  childthread _id_FC2EA6299C7F8530();
  childthread _id_3E939A9D2BFAD815();
  childthread _id_D6A4E3FDC3E04264();

  for(;;) {
    self waittill("giveLoadout");

    if(!istrue(self._id_902ECDC53E7D43D2)) {
      scripts\mp\utility\player::_freezecontrols(1);
      scripts\mp\utility\player::_freezelookcontrols(1);
      scripts\mp\playerlogic::playerprematchallow(0, "reveal");
    }

    if(getdvarint("dvar_A4A2ADFED27286BB", 1) == 1) {
      self setcustomization("body_dmz_disguised_shadow_company_iw9_1_1", "head_dmz_disguised_shadow_company_iw9_1_1");
      self setclothtype("nylon");
      self _meth_8ABE5A968CC3C220("millghtgr");
    }
  }
}

_id_D6A4E3FDC3E04264() {
  self waittill("br_jump");
  scripts\mp\utility\player::_freezecontrols(0, 1);
  scripts\mp\utility\player::_freezelookcontrols(0, 1);
  scripts\mp\playerlogic::playerprematchallow(1, "reveal");
  self._id_902ECDC53E7D43D2 = 1;
  wait 3.0;
  self playcinematicforplayer("mp_reveal_splash_attack_missile", 1);
  thread _id_74697C539EEF5823(16);
  thread _id_8A61C99BBF018323("s5_missile_silo_mission", 16.0);
}

_id_FC2EA6299C7F8530() {
  for(;;) {
    self waittill("spawned_player");
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(self, "brloot_equip_gasmask_durable", 1);
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(self, "brloot_self_revive", 1);
  }
}

respawn(params) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(self) && isDefined(self.origin) && isDefined(self.angles) && istrue(self._id_5300C8D35F8501D5)) {
    _id_4480C6CE37B2BDF3::_id_6D569066AC5F3DF0();
    _id_0268FD96C35D66DE = self.origin + rotatevector((-70, 0, 0), self.angles);
    _id_E5403EB19D281362 = getclosestpointonnavmesh(_id_0268FD96C35D66DE);

    if(isDefined(_id_E5403EB19D281362) && distance(_id_E5403EB19D281362, _id_0268FD96C35D66DE) < 400) {
      _id_CB921303144E9E43 = scripts\engine\trace::ray_trace(_id_E5403EB19D281362, _id_E5403EB19D281362 - (0, 0, 100), [self], scripts\engine\trace::create_solid_ai_contents(1));

      if(isDefined(_id_CB921303144E9E43["fraction"]) && _id_CB921303144E9E43["fraction"] < 1) {
        angles = generateaxisanglesfromupvector(_id_CB921303144E9E43["normal"], self.angles);
        _id_4E0D9C78FA04CDD4 = spawnscriptable("radiation_cannister_s5_reveal", _id_CB921303144E9E43["position"], angles);
      }
    }

    foreach(exfil in level._id_613667408830E919) {
      if(isDefined(exfil.heli)) {
        if(isDefined(exfil.heli.objid) && !istrue(level._id_B24DF4F49945B8F3))
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(exfil.heli.objid, self);

        if(isDefined(exfil.heli.prompt))
          exfil.heli.prompt disablescriptableplayeruse(self);
      }
    }

    if(getdvarint("dvar_CE52146C424DBEDD", 1) == 1)
      scripts\mp\utility\perk::removeperk("specialty_third_person");
  }

  self._id_5300C8D35F8501D5 = undefined;
  self _meth_1863F51C1339D80F("none");
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 1);

  if(!istrue(level._id_3F015B5018AB9E6D))
    level scripts\engine\utility::waittill_any_timeout_1(level._id_9BE6184533891E12, "s5_force_respawns");

  _id_D09B626A1EACC3D3 = undefined;

  if(scripts\common\utility::_id_76D9F2B9AC5F8307("test_observatory") == "after" && isDefined(self._id_DA28916E7827AF7C) && self._id_DA28916E7827AF7C == "saba_S5Reveal" || self._id_DA28916E7827AF7C == "saba_observatory" || self._id_DA28916E7827AF7C == "saba_suburbs_11") {
    _id_D127253B9B619374 = sortbydistance(level._id_E9B21B65FF08BB29, self.origin)[0];
    _id_D09B626A1EACC3D3 = spawnStruct();
    _id_D09B626A1EACC3D3.origin = _id_D127253B9B619374.target.origin + scripts\engine\utility::randomonunitsphere() * 200;
    _id_D09B626A1EACC3D3.angles = _id_D127253B9B619374.target.angles;
  }

  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  _id_30A91E1938CFD1B2 = _id_5BAB271917698DC4::_id_ADE48AF7C782E202(::_id_260A81DF7CA3956D, "br_ac130_flyby");
  _id_5BAB271917698DC4::_id_D5EE3D3FAD992D43(undefined, _id_30A91E1938CFD1B2, _id_D09B626A1EACC3D3);

  if(isDefined(_id_D09B626A1EACC3D3))
    self skydive_deployparachute();
}

_id_260A81DF7CA3956D(params) {
  self.health = self.maxhealth;
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 0);
}

_id_3E939A9D2BFAD815() {
  if(!isDefined(level._id_AEFE366CF6DDA50A))
    level._id_AEFE366CF6DDA50A = scripts\engine\utility::array_randomize(level._id_A2B890D129C64761._id_DE0C0A02B71959F5);

  if(!isDefined(level._id_E90B44220CB40601))
    level._id_E90B44220CB40601 = [];

  if(!isDefined(level._id_E51E4084CE5A47C3))
    level._id_E51E4084CE5A47C3 = 0;

  if(!isDefined(level._id_E90B44220CB40601[self._id_0FF97225579DE16A])) {
    level._id_E90B44220CB40601[self._id_0FF97225579DE16A] = level._id_AEFE366CF6DDA50A[level._id_E51E4084CE5A47C3];
    level._id_E51E4084CE5A47C3 = (level._id_E51E4084CE5A47C3 + 1) % level._id_AEFE366CF6DDA50A.size;
  }

  _id_BFEEE3159094A0BD = level._id_E90B44220CB40601[self._id_0FF97225579DE16A];
  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  wait 3.5;

  if(!isDefined(self)) {
    return;
  }
  self setclientomnvar("ui_mission_checklist_type", 1);
  thread _id_B49FBD71F84AFFB5(_id_BFEEE3159094A0BD);

  if(isDefined(_id_BFEEE3159094A0BD.objid) && _id_BFEEE3159094A0BD.objid != -1) {
    _id_612589D55CC31E4E(_id_BFEEE3159094A0BD, _id_BFEEE3159094A0BD.usable.origin);

    if(isDefined(_id_BFEEE3159094A0BD._id_C31012441CC7E210) && _id_BFEEE3159094A0BD._id_C31012441CC7E210 != -1) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_BFEEE3159094A0BD.objid, self);
      waitframe();
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_BFEEE3159094A0BD._id_C31012441CC7E210, self);
      waitframe();
      self calloutmarkerping_create(11, _id_BFEEE3159094A0BD.usable.origin + (0, 0, 70), _id_BFEEE3159094A0BD._id_C31012441CC7E210);
    }
  }
}

_id_612589D55CC31E4E(_id_C45248FDF60A7B9A, origin) {
  if(isDefined(_id_C45248FDF60A7B9A._id_C31012441CC7E210)) {
    return;
  }
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  _id_C45248FDF60A7B9A._id_C31012441CC7E210 = objid;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", origin + (0, 0, 70), "ui_map_icon_missile_silo_red");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::_id_41F90376AB869B9F(objid, 1);
  scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(objid, &"MP_BR_INGAME/MISSILE_SILO");
  scripts\mp\objidpoolmanager::_id_C3C6BFF089DFDD34(objid, "icon_medium");
}

droponplayerdeath() {
  _id_7E52B56769FA7774::_id_75520EA44545C906();
  return 1;
}

_id_B53617574CFBD41B(team) {
  return 1;
}

_id_0ABB493EA69C8133() {
  _id_27AFD7662BC38A81::init();
  level.infilstruct._id_410EB50B35457227 = ::_id_410EB50B35457227;
  level.infilstruct._id_B381E33E977DA440 = ::_id_55F2480B4B819AEA;
}

_id_410EB50B35457227(player) {
  player.infilanimindex = 1;
}

_id_8171B741D99155F8(_id_76AC573DBB08ECE4) {
  level.infilstruct.c130.animstruct _id_27AFD7662BC38A81::_id_5DBA404B985C7D41();
  level.br_ac130 setscriptablepartstate("running_lights", "on");
  level.br_ac130 notify("start_moving");
  level.infilstruct._id_3174C6E96B5630D8 = spawn("script_model", level.infilstruct.c130.origin);
  level.infilstruct._id_3174C6E96B5630D8 setModel("tag_origin");
  level.infilstruct._id_3174C6E96B5630D8.angles = level.infilstruct.c130.angles + (20, 0, 0);

  foreach(_id_07246E37824518C4 in level.infilstruct.players) {
    if(isDefined(_id_07246E37824518C4)) {
      _id_07246E37824518C4 cameraunlink();
      _id_07246E37824518C4 cameralinkTo(level.infilstruct._id_3174C6E96B5630D8, "tag_origin");
    }
  }

  _id_27AFD7662BC38A81::_id_F90E2DB4B34D7F57(_id_76AC573DBB08ECE4);
}

_id_55F2480B4B819AEA(movingc130) {
  animstruct = spawnStruct();
  animstruct.origin = getdvarvector("dvar_223915C6339DBC10", (0, 0, 0));
  animstruct.angles = (0, 0, 0);
  animstruct._id_7A2AF7FE0EF35BAA = getdvarint("dvar_4EE80A43D1C50CA2", 1);
  animstruct._id_03772737101AA4AF = level._id_2655050B4D075E87;
  animstruct.cleanupfunc = _id_27AFD7662BC38A81::_id_72145194F4F38714;
  animstruct._id_AB8494260B910B51 = _id_27AFD7662BC38A81::_id_52BEDAE2CED8E191;
  animstruct.movingc130 = movingc130;

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130.animname = "movingC130";
    animstruct.movingc130.innards.animname = "movingC130";
    animstruct.movingc130.animstruct = animstruct;
    animstruct.movingc130._id_6A704063A0555C1D = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_infils_ac130", "getAnimStruct"))
    animstruct = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_infils_ac130", "getAnimStruct")]](animstruct);
  else {
    animstruct.staticc130 = getEnt("infil_ac130_exterior", "targetname");

    if(isDefined(animstruct.staticc130)) {
      animstruct.staticc130.animname = "c130";
      animstruct.staticc130._id_662EFE6105E9F585 = 1;
    } else
      animstruct.staticc130 = animstruct _id_0930A1E7BD882C1D::spawn_script_model("black::veh9_mil_air_cargo_plane_exterior_infil", "c130");

    animstruct.staticc130 hide();
    animstruct.staticc130._id_6A704063A0555C1D = 1;
    animstruct._id_E73CE295AE9D4104 = animstruct _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x30", "camera");
    animstruct._id_E73CE295AE9D4104 linkTo(animstruct.staticc130, "tag_body_animate", (0, 0, 0), (0, 0, 0));
    animstruct._id_6F8BCD4A2212597D = animstruct _id_0930A1E7BD882C1D::spawn_script_model("black::veh9_mil_air_cargo_plane", "introPlane");
    animstruct._id_6F8BCD4A2212597D linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_30");
    animstruct._id_6F8BCD4A2212597D hide();
    _id_83796D798B3F41BD = "fu_disguise_shadow";
    animstruct._id_0B50860E78D9E1E5 = [];
    animstruct._id_0B50860E78D9E1E5[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag1");
    animstruct._id_0B50860E78D9E1E5[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag2");
    animstruct._id_0B50860E78D9E1E5[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag3");
    animstruct._id_0B50860E78D9E1E5[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag4");
    animstruct._id_0B50860E78D9E1E5[4] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag5");
    animstruct._id_0B50860E78D9E1E5[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_2", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[1] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_3", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[2] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_4", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[3] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_5", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[4] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_15", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E = [];
    animstruct._id_A552EC61E51ECE6E[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
    animstruct._id_A552EC61E51ECE6E[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player2");
    animstruct._id_A552EC61E51ECE6E[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player3");
    animstruct._id_A552EC61E51ECE6E[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player4");
    animstruct._id_A552EC61E51ECE6E[4] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player5");
    animstruct._id_A552EC61E51ECE6E[0] linkTo(animstruct._id_0B50860E78D9E1E5[0], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[1] linkTo(animstruct._id_0B50860E78D9E1E5[1], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[2] linkTo(animstruct._id_0B50860E78D9E1E5[2], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[3] linkTo(animstruct._id_0B50860E78D9E1E5[3], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[4] linkTo(animstruct._id_0B50860E78D9E1E5[4], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[0] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_A552EC61E51ECE6E[1] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_A552EC61E51ECE6E[2] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_A552EC61E51ECE6E[3] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_A552EC61E51ECE6E[4] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_2668FB5D52D6438D = [];
    animstruct._id_2668FB5D52D6438D[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc1");
    animstruct._id_2668FB5D52D6438D[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc2");
    animstruct._id_2668FB5D52D6438D[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc3");
    animstruct._id_2668FB5D52D6438D[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc4");
    animstruct._id_2668FB5D52D6438D[4] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc5");
    animstruct._id_2668FB5D52D6438D[5] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc6");
    animstruct._id_2668FB5D52D6438D[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_9", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[1] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_10", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[2] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_11", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[3] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_12", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[4] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_13", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[5] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_14", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[0] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_2668FB5D52D6438D[1] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_2668FB5D52D6438D[2] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_2668FB5D52D6438D[3] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_2668FB5D52D6438D[4] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct._id_2668FB5D52D6438D[5] _id_27AFD7662BC38A81::_id_66B13900C5013DE5(_id_83796D798B3F41BD);
    animstruct.packs = [];
    n = 0;
    _id_E92AED86E7DD8B76 = 45.0;
    _id_630E1DFE2A5B41CA = 45.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("looping", 1);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_8171B741D99155F8);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_E718BA63D511FCDE([], _id_27AFD7662BC38A81::_id_60240BEEDE5E1AB8);
    animstruct.packs[n] _id_27AFD7662BC38A81::_id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, _id_27AFD7662BC38A81::_id_E128261218FAFDAA);
  }

  return animstruct;
}

_id_5DF8C6ABD0B861CD() {
  setomnvar("ui_br_c130_path_start_x", -54100);
  setomnvar("ui_br_c130_path_start_y", -38503);
  setomnvar("ui_br_c130_path_end_x", 33296);
  setomnvar("ui_br_c130_path_end_y", -3063);
  pathstruct = spawnStruct();
  pathstruct.startpt = (-75949, -47363, 23000);
  pathstruct.endpt = (33296, -3063, 23000);
  pathstruct.startptui = pathstruct.startpt;
  pathstruct.endptui = pathstruct.endpt;
  pathstruct.centerpt = (-10402, -20783, 23000);
  return pathstruct;
}

_id_9215E3A9DFE8A262(player) {
  player._id_3B2791644531CAC8 = 1;
  _id_81DD3F3F6241212B = isDefined(level._id_A208B7877B64A61E) && level._id_A208B7877B64A61E >= getdvarint("dvar_634D99B1D241C565", 70);

  if(istrue(level._id_B24DF4F49945B8F3) || _id_81DD3F3F6241212B) {
    player setclientomnvar("ui_mission_checklist_step", 3);
    player setclientomnvar("ui_reveal_on_exfil", 1);
  }
}

_id_83EA10956EF420C4(player) {
  if(!isDefined(player)) {
    return;
  }
  player._id_3B2791644531CAC8 = undefined;
}

_id_04876CA4B89BF944() {
  level._id_DBB3DD5AB77CCD48[level._id_DBB3DD5AB77CCD48.size] = "saba_S5Reveal";
  level._id_ACF99124377543BB["saba_S5Reveal"] = (-1004, -17168, 1000);
}

_id_8209A75B03499110(_id_171F90B9C4C76D44) {
  if(_id_171F90B9C4C76D44 == "saba_S5Reveal")
    return 3;
  else
    return _id_48814951E916AF89::_id_AA34A142B7664DD1(_id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));
}

_id_3F683B61E590024F() {
  if(isDefined(level._id_265FD51BA245ADFD)) {
    _id_95CF8C20B345E817 = 0;

    foreach(_id_EEC55FABA21F3653 in level._id_265FD51BA245ADFD) {
      if(!istrue(_id_EEC55FABA21F3653.inuse) && (!isDefined(_id_EEC55FABA21F3653._id_6EC188424F7A3018) || gettime() - _id_EEC55FABA21F3653._id_6EC188424F7A3018 > 20000))
        return "Elevator";
    }
  }

  return "Helicopter";
}

_id_223DA18CCBB9A309(_id_5631F1278F51BA66) {
  if(_id_5631F1278F51BA66 == "Helicopter")
    return scripts\engine\utility::random(level._id_66287B06B2B17459);
}

_id_DBEABC9A57AB512A() {
  level._id_B205D90302DA2F07["saba_S5Reveal"]["subAreas"]["orphan"]._id_1673E56336A38D1B = 1;
}

_id_A5C6FCDA083F1AFF() {
  if(istrue(level._id_5C1D75E47C6AC564)) {
    return;
  }
  level._id_5C1D75E47C6AC564 = 1;

  if(!istrue(level._id_863221A01F7A8258) && !scripts\common\utility::_id_42F93A2901D58B66() && scripts\common\utility::_id_76D9F2B9AC5F8307("test_observatory") != "after") {
    level._id_EF3E0EB58D1263C5 = 0;

    if(!istrue(level._id_D98078B55AF92898)) {
      level._id_D98078B55AF92898 = 1;
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_silo_failed", level.players);
      wait 2.0;
      _id_13C4FF9B1A423445("s5_missile_silo_failure");
      wait 6.0;
    }

    level notify("dmz_radiation_complete");

    if(!istrue(level._id_1DCF3CD182C5039A)) {
      level._id_E8CE6AE6F3F1F783 = "stat_71222FA55F9BAECF";
      _id_F95D6A095F14CD9C();
      level._id_1DCF3CD182C5039A = 1;
    }
  }
}

_id_2676819F01AE14ED() {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  self waittill("death", _id_6181DE250AFA5BB6);
  level._id_A5ED64EF4E51D0F4 = level._id_A5ED64EF4E51D0F4 + 1;
  _id_9DC2394FEE4A29EA = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "s5_reveal_attackers");

  if(isDefined(_id_9DC2394FEE4A29EA))
    _id_C2A2E571C8927D32(_id_9DC2394FEE4A29EA.attackers);
}

_id_501D496BAA6E39FD(attacker, _id_3D2A165F057F047A) {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  if(!isDefined(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "s5_reveal_attackers")))
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "s5_reveal_attackers", spawnStruct());

  if(isPlayer(attacker)) {
    _id_9E8FCAC6728AA14F = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "s5_reveal_attackers");

    if(!isDefined(_id_9E8FCAC6728AA14F.attackers))
      _id_9E8FCAC6728AA14F.attackers = [];

    if(!isDefined(_id_9E8FCAC6728AA14F.attackers[attacker.guid]))
      _id_9E8FCAC6728AA14F.attackers[attacker.guid] = [attacker, 0];

    [_, _id_535FD96FD1B3C9BC] = _id_9E8FCAC6728AA14F.attackers[attacker.guid];
    _id_9E8FCAC6728AA14F.attackers[attacker.guid] = [attacker, _id_535FD96FD1B3C9BC + _id_3D2A165F057F047A];
  }
}

_id_D2352921AB60AAC8(attacker, _id_3D2A165F057F047A) {
  if(!isDefined(self._id_EE85C6B53E17CE57)) {
    self._id_EE85C6B53E17CE57 = spawnStruct();
    self._id_EE85C6B53E17CE57.attackers = [];
  }

  if(isPlayer(attacker)) {
    if(!isDefined(self._id_EE85C6B53E17CE57.attackers[attacker.guid]))
      self._id_EE85C6B53E17CE57.attackers[attacker.guid] = [attacker, 0];

    [_, _id_535FD96FD1B3C9BC] = self._id_EE85C6B53E17CE57.attackers[attacker.guid];
    self._id_EE85C6B53E17CE57.attackers[attacker.guid] = [attacker, _id_535FD96FD1B3C9BC + _id_3D2A165F057F047A];
  }
}

_id_1B81D33201A1832D(player) {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  squad = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getSquadmates")]](player.team, player._id_0FF97225579DE16A, 0);

  foreach(_id_80EF668C09FFB70F in squad) {
    if(isPlayer(_id_80EF668C09FFB70F))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_80EF668C09FFB70F, "jupiter_reveal_canister_collected", 1);
  }
}

_id_C2A2E571C8927D32(playerlist) {
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    return;
  }
  foreach(_id_F90358454413407F in playerlist) {
    if(isPlayer(_id_F90358454413407F[0]) && _id_F90358454413407F[1] >= 150)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_F90358454413407F[0], "jupiter_reveal_boss_assist", 1);
  }
}

_id_E4C1D509B460EE12() {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_missiles_firing", level.players);
  _id_13C4FF9B1A423445("s5_missile_silo_launching1");
  wait 4;
  _id_82E23742B00A821E = getdvarint("dvar_3A8E6799017BC392", 10);

  foreach(player in level.players)
  player playlocalsound("iw9_jup_rvl_missile_countdown");

  for(_id_AC0E594AC96AA3A8 = _id_82E23742B00A821E; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    foreach(player in level.players)
    player setclientomnvar("ui_match_start_countdown", _id_AC0E594AC96AA3A8);

    wait 1;
  }
}

_id_ED1C6692EACBAD48() {
  level endon("game_ended");

  for(;;) {
    wait 1;
    _id_6BFD1B09F9DB911C = level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF >= level._id_A2B890D129C64761._id_A9375F419858B31D;

    if(_id_6BFD1B09F9DB911C)
      return;
    else {
      timeremaining = scripts\mp\gamelogic::gettimeremaining();

      if(timeremaining < scripts\engine\utility::_id_A5B14435E3229BED(120)) {
        _id_13C4FF9B1A423445("s5_missile_silo_warning");
        return;
      }
    }
  }
}

_id_2E1897B4338E9597() {
  level endon("game_ended");
  _id_D1A911B71F8BD838 = getdvarint("dvar_634D99B1D241C565", 70);
  _id_2918A83E348933FB = scripts\engine\utility::_id_A5B14435E3229BED(getdvarfloat("dvar_9527C9289506B6C8", 300));
  _id_AB7E0F7A5ACBCAAB = scripts\engine\utility::_id_A5B14435E3229BED(getdvarfloat("dvar_57B0B43C6443C958", 120));
  _id_52AEFEEF79E2902D = 0;
  _id_480BF93A036BD3B5 = 0;

  for(;;) {
    wait 1;
    _id_73E5C162546BEE5A = isDefined(level._id_A208B7877B64A61E) && level._id_A208B7877B64A61E >= _id_D1A911B71F8BD838;

    if(_id_73E5C162546BEE5A)
      return;
    else {
      timeremaining = scripts\mp\gamelogic::gettimeremaining();

      if(!_id_52AEFEEF79E2902D && timeremaining < _id_2918A83E348933FB) {
        _id_52AEFEEF79E2902D = 1;
        _id_13C4FF9B1A423445("s5_gas_canister_warning");
      }

      if(!_id_480BF93A036BD3B5 && timeremaining < _id_AB7E0F7A5ACBCAAB) {
        _id_480BF93A036BD3B5 = 1;
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_find_canisters_warning", level.players);
        setmusicstate("mx_jup_rvl_canister_run");
      }
    }
  }
}

_id_7FC4CA382A1DC4C0(endtime) {
  countdowntimer = getdvarint("dvar_5EF8835A22BAA359", 60);
  _id_9E1C20940C3F56D6(endtime, countdowntimer);
  level notify("radiation_starting_in_a_minute");

  foreach(_id_164E7E721F38101C in level._id_E0590C3F9664968C)
  sortbydistance(level._id_613667408830E919, _id_164E7E721F38101C)[2] thread _id_0AB5767121AB2CB0(0);

  foreach(exfil in level._id_613667408830E919) {
    if(isDefined(exfil.heli) && isDefined(exfil.heli.objid))
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(exfil.heli.objid);
  }

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_exfil_yourself", level.players);

  foreach(_id_2269AFA92E822ECA in level.players) {
    _id_2269AFA92E822ECA setclientomnvar("ui_mission_checklist_step", 3);

    if(istrue(_id_2269AFA92E822ECA._id_3B2791644531CAC8))
      _id_2269AFA92E822ECA setclientomnvar("ui_reveal_on_exfil", 1);
  }

  level._id_B24DF4F49945B8F3 = 1;

  for(_id_AC0E594AC96AA3A8 = countdowntimer; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    foreach(player in level.players)
    player setclientomnvar("ui_match_start_countdown", _id_AC0E594AC96AA3A8);

    if(_id_AC0E594AC96AA3A8 == countdowntimer - 3) {
      playcinematicforall("mp_reveal_splash_exfil", 1);

      foreach(player in level.players)
      player thread _id_74697C539EEF5823(9);
    }

    wait 1;
  }
}

_id_896104DAF7A5878C() {
  level._id_FAA9E7AE89A6F25A = [];

  foreach(_id_0D32078955171127 in level._id_B24A27D9764F8FDD) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    objective_setdescription(objid, &"MP_INGAME_ONLY/REVEAL_BUNKER_ENTRANCE");
    objective_setpings(objid, 1);
    objective_icon(objid, "ui_map_icon_bunker");
    objective_setbackground(objid, 1);
    objective_state(objid, "current");
    objective_position(objid, _id_0D32078955171127 + (0, 0, 100));
    objective_setownerteam(objid, undefined);
    objective_setprogressteam(objid, undefined);
    objective_setplayintro(objid, 1);

    foreach(player in level.players)
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);

    struct = spawnStruct();
    struct.origin = _id_0D32078955171127;
    struct.objid = objid;
    level._id_FAA9E7AE89A6F25A[level._id_FAA9E7AE89A6F25A.size] = struct;
  }

  waitframe();

  foreach(_id_0D32078955171127 in level._id_FAA9E7AE89A6F25A)
  objective_setplayintro(_id_0D32078955171127.objid, 0);

  wait 2;

  if(getdvarint("dvar_F2116D12FEDDCCE6", 1) == 1) {
    foreach(player in level.players)
    player thread _id_2C1AC0EAC625F0D2();
  }

  level waittill("radiation_starting_in_a_minute");

  foreach(_id_0D32078955171127 in level._id_FAA9E7AE89A6F25A)
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(_id_0D32078955171127.objid);
}

_id_2C1AC0EAC625F0D2() {
  self endon("disconnect");
  level endon("radiation_starting_in_a_minute");
  _id_114AB88507847C50 = undefined;
  self._id_F9805DB091F70CA8 = undefined;

  while(isDefined(self) && isDefined(self.origin)) {
    if(istrue(level._id_B24DF4F49945B8F3)) {
      return;
    }
    _id_D41E352930AE6A14 = sortbydistance(level._id_FAA9E7AE89A6F25A, self.origin)[0];

    if(distancesquared(_id_D41E352930AE6A14.origin, self.origin) < 160000) {
      if(isDefined(_id_114AB88507847C50) && isDefined(self._id_F9805DB091F70CA8))
        self calloutmarkerping_delete(self._id_F9805DB091F70CA8);

      if(!istrue(self._id_61B2F83DC87E1205) && !istrue(self._id_5300C8D35F8501D5)) {
        self._id_61B2F83DC87E1205 = 1;
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_find_canister", [self]);
        self setplayermusicstate("mx_jup_rvl_canister_run");
        childthread _id_50D1C6EC3F56B73B();
        self setclientomnvar("ui_mission_checklist_step", 2);
        self setclientomnvar("ui_reveal_entered_bunker", 1);
      }

      foreach(_id_0D32078955171127 in level._id_FAA9E7AE89A6F25A)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_0D32078955171127.objid, self);

      wait 2;

      while(isDefined(self) && isDefined(self.origin) && ispointinvolume(self.origin, level._id_65C18FB3F0546B98))
        wait 1;

      foreach(_id_0D32078955171127 in level._id_FAA9E7AE89A6F25A)
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_0D32078955171127.objid, self);

      waitframe();
      _id_114AB88507847C50 = undefined;
      continue;
    }

    if(!isDefined(_id_114AB88507847C50) || _id_114AB88507847C50 != _id_D41E352930AE6A14) {
      if(isDefined(_id_114AB88507847C50) && isDefined(self._id_F9805DB091F70CA8))
        self calloutmarkerping_delete(self._id_F9805DB091F70CA8);

      self._id_F9805DB091F70CA8 = self calloutmarkerping_create(11, _id_D41E352930AE6A14.origin + (0, 0, 100), _id_D41E352930AE6A14.objid);
      thread _id_DD1E5CB0E4A14F69();
      _id_114AB88507847C50 = _id_D41E352930AE6A14;
    }

    wait 0.5;
  }
}

_id_50D1C6EC3F56B73B() {
  wait 3;
  self playcinematicforplayer("mp_reveal_splash_inside_observatory", 1);
  thread _id_74697C539EEF5823(18);
}

_id_DD1E5CB0E4A14F69() {
  _id_394466C2DDB208CB = self._id_F9805DB091F70CA8;
  self notify("new_bunker_pinged");
  self endon("new_bunker_pinged");
  self waittill("predictiveCalloutClear_" + _id_394466C2DDB208CB);

  if(scripts\engine\utility::is_equal(_id_394466C2DDB208CB, self._id_F9805DB091F70CA8))
    self._id_F9805DB091F70CA8 = undefined;
}

_id_9E1C20940C3F56D6(endtime, countdowntimer) {
  level endon("radiation_starting_in_a_minute");
  wait(endtime - countdowntimer - 1);
}

_id_EF236D1DE4841E11() {
  level endon("game_ended");
  radius = _id_1174ABEDBEFE9ADA::_id_5CE400665EE103F9();
  _id_30D23C23CE42FCFA = spawn("script_model", _id_1174ABEDBEFE9ADA::_id_F3FB60F986F267C5());
  _id_30D23C23CE42FCFA.team = "team_fifty";
  level.activecounteruavs[_id_30D23C23CE42FCFA.team] = 0;
  _id_30D23C23CE42FCFA scripts\cp_mp\killstreaks\helper_drone::scramblerdrone_counteruavmodeon();

  while(isDefined(level.players) && level.players.size > 0) {
    owner = scripts\engine\utility::random(level.players);
    _id_30D23C23CE42FCFA makescrambler(owner, "large", int(radius), 1);
    owner waittill("disconnect");
    _id_30D23C23CE42FCFA clearscrambler();
  }
}

_id_822D3D25B3112ED3() {
  level thread _id_EE53F7F413A93F86();
  level waittill("radiation_starting_in_a_minute");
  wait 55;
  _id_8C75C28DA153BEC6 = _id_1174ABEDBEFE9ADA::_id_F3FB60F986F267C5();

  foreach(exfil in sortbydistance(level._id_613667408830E919, _id_8C75C28DA153BEC6)) {
    if(isDefined(exfil.heli)) {
      exfil thread _id_D21AA44758FC341B();
      wait 1;
    }
  }
}

_id_EE53F7F413A93F86() {
  level waittill("dmz_radiation_started");

  foreach(player in level.players) {
    if(istrue(player._id_3B2791644531CAC8))
      _id_13C4FF9B1A423445("s5_exfil_success");
  }

  level scripts\engine\utility::delaythread(9.0, ::_id_BE5AAF2A07108194);
  wait(getdvarint("dvar_F9E53CE16E2B5FD0", 30) - 3.5);

  foreach(player in level.players) {
    if(istrue(player.inlaststand))
      player thread scripts\mp\laststand::onrevive();

    player.plotarmor = 1;
    player setsoundsubmix("iw9_jup_reveal_lower_weapons", 2.0);
  }

  level._id_3F015B5018AB9E6D = 1;
  level notify("s5_force_respawns");
  explosion = spawn("script_model", (-2234.41, -12693.7, 4740.11));
  explosion setModel("iw9_br_observatory_ab_xfil_explosions1");
  explosion.angles = (0, 177.998, 0);
  explosion setscriptablepartstate("observatory_ab_fx", "observatory_fx");
  explosion forcenetfieldhighlod(1);
  explosion = spawn("script_model", (-9430.22, -11282.9, 2550.33));
  explosion setModel("iw9_br_observatory_ab_xfil_explosions2");
  explosion.angles = (288.439, 301.385, 12.5449);
  explosion setscriptablepartstate("observatory_ab_fx", "observatory_fx");
  explosion forcenetfieldhighlod(1);
  explosion = spawn("script_model", (2943.39, -14738.2, 3814.68));
  explosion setModel("iw9_br_observatory_ab_xfil_explosions3");
  explosion.angles = (286.074, 119.587, 10.2848);
  explosion setscriptablepartstate("observatory_ab_fx", "observatory_fx");
  explosion forcenetfieldhighlod(1);

  foreach(player in level.players)
  player thread _id_354E73009978ED73();

  wait 3.5;
  _func_D5131497D473CB79("");

  foreach(player in level.players) {
    player setclientomnvar("ui_br_bink_overlay_state", 7);
    player setsoundsubmix("fade_to_black_all_except_music", 4.0);
    player setscriptablepartstate("juggernaut", "neutral", 0);
  }

  wait 2;
  _id_9C86EF496A723865 = spawnStruct();
  _id_9C86EF496A723865.origin = (40000, 5000, 15000);
  _id_9C86EF496A723865.angles = (20, 208, 0);

  foreach(player in level.players) {
    player setclientomnvar("ui_br_bink_overlay_state", 9);
    player scripts\mp\playerlogic::spawnintermission(_id_9C86EF496A723865, undefined, 0);
    player setclientdvars("cg_everyoneHearsEveryone", 0);
  }

  if(!istrue(level._id_1DCF3CD182C5039A)) {
    if(!isDefined(level._id_E8CE6AE6F3F1F783))
      level._id_E8CE6AE6F3F1F783 = "stat_2C7D2425089E51D8";

    _id_F95D6A095F14CD9C();
    level._id_1DCF3CD182C5039A = 1;
  }

  setDvar("dvar_ACB4DF9F0D3F8F6B", 1);
  setomnvar("ui_reveal_mute_players", 1);
  playcinematicforall("wz_s5_event_cine_outro", 1);
  duration = getdvarint("dvar_728E248BEDA8A7EE", 173);
  wait(duration);
  setDvar("dvar_ACB4DF9F0D3F8F6B", 0);
  setomnvar("ui_reveal_mute_players", 0);

  foreach(player in level.players) {
    player setclientdvars("cg_everyoneHearsEveryone", 1);
    player setclientomnvar("ui_br_bink_overlay_state", 5);
  }

  scripts\mp\gamelogic::endgame_regularmp("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
}

_id_BE5AAF2A07108194() {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_mission_success", level.players);
  setmusicstate("");

  foreach(player in level.players) {
    if(istrue(player._id_3B2791644531CAC8))
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "jupiter_reveal_successful_exfil", 1);
  }
}

_id_354E73009978ED73() {
  self endon("disconnect");
  _id_CA16950260700BDD = (-1500, -15000, 0);
  _id_D0EB1456103AB1E3 = distance2d(self.origin, _id_CA16950260700BDD);
  _id_74B5B12BB6514385 = _id_D0EB1456103AB1E3 / 13798.4;
  wait(_id_74B5B12BB6514385);
  self earthquakeforplayer(0.4, 6.0, self.origin, 300);
}

_id_4D8595A330859EBA() {
  if(!isDefined(level._id_265FD51BA245ADFD))
    level._id_265FD51BA245ADFD = [];

  _id_40E610580F1CBAF8 = getentitylessscriptablearray("elevator_stop", "script_noteworthy");

  foreach(_id_AC0E594AC96AA3A8, point in level._id_B928FB4FD62F154D) {
    struct = spawnStruct();
    struct.origin = point;
    level._id_B928FB4FD62F154D[_id_AC0E594AC96AA3A8] = struct;
  }

  foreach(stop in _id_40E610580F1CBAF8) {
    if(isDefined(stop.open)) {
      continue;
    }
    _id_68333DFC5840CBD8 = _id_5F903436642211AF::_id_B0811DEBA3748E9D(stop);
    _id_EEC55FABA21F3653 = _id_5F903436642211AF::_id_C0032A2E585D337B([stop], level._id_F92F39BCC87A4C65, "building_biobunker_elevator_car_frame_one_way");
    _id_EEC55FABA21F3653.id = _id_68333DFC5840CBD8;
    stop._id_90DABE3606074803 = _func_F159C10D5CF8F0B4(stop.target, "targetname")[0];
    stop._id_0907E66D3BF42C5A = _func_F159C10D5CF8F0B4(stop._id_0E4118BDA122B112.target, "targetname")[0];
    stop._id_3B5E36C5E7A1BDA6 = getclosestpointonnavmesh(sortbydistance(level._id_B928FB4FD62F154D, stop.origin)[0].origin);
    level thread scripts\mp\outofbounds::watchoobtrigger(stop._id_0907E66D3BF42C5A);
    _id_EEC55FABA21F3653.origin = stop.origin;
    stop thread _id_12E5641A71FDDAC0();
    _id_EEC55FABA21F3653._id_B586C70B173DD02B = [];

    foreach(_id_AD3758FD3576AE97 in [(30, 35, 0), (-30, -35, 0), (-30, 35, 0), (30, -35, 0), (30, 0, 0), (-30, 0, 0)]) {
      _id_FB1DEF007972B25A = spawnStruct();
      _id_FB1DEF007972B25A.origin = getclosestpointonnavmesh(rotatevector(_id_AD3758FD3576AE97, _id_EEC55FABA21F3653.car.angles) + _id_EEC55FABA21F3653.car.origin);
      _id_FB1DEF007972B25A.angles = _id_EEC55FABA21F3653.car.angles;
      _id_FB1DEF007972B25A._id_B205D90302DA2F07 = "saba_S5Reveal";
      _id_EEC55FABA21F3653._id_B586C70B173DD02B[_id_EEC55FABA21F3653._id_B586C70B173DD02B.size] = _id_FB1DEF007972B25A;
    }

    _id_EEC55FABA21F3653.exitposition = getclosestpointonnavmesh(rotatevector((100, 0, 0), _id_EEC55FABA21F3653.car.angles) + _id_EEC55FABA21F3653.car.origin);
    level._id_265FD51BA245ADFD[level._id_265FD51BA245ADFD.size] = _id_EEC55FABA21F3653;
  }

  level._id_F92F39BCC87A4C65 = undefined;
  level._id_B928FB4FD62F154D = undefined;
}

_id_12E5641A71FDDAC0() {
  _id_5C118165D3E98A42::_id_88C392696FD02DC4();
  _id_5C118165D3E98A42::_id_D32C693D3A04F8F8();
}

_id_19D088DC832A3F71() {
  _id_20FC47823E95E4AF::_id_A98B4087642D8E07();
  _id_B586C70B173DD02B = [(-9633.09, -11060.9, 2378.24), (3185.05, -15031.2, 3603.86), (-3560.25, -25431.7, 4251.62), (-2901.72, -12625.2, 4732.93)];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < getdvarint("dvar_1D0B18D2BE8ECF30", 3); _id_AC0E594AC96AA3A8++) {
    wait(randomfloatrange(4.0, 6.0));
    level._id_103B912267715093 = 6000 + 1500 * _id_AC0E594AC96AA3A8;
    level._id_F7CA3F03D0ED22A9 = 1;

    if(getdvarint("dvar_12D90734562B99F6", 1) == 1) {
      instance = _id_AE71C0FB003CF6C8(_id_B586C70B173DD02B[_id_AC0E594AC96AA3A8 % _id_B586C70B173DD02B.size]);
      continue;
    }

    instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("chopper", 1);
    instance._id_47BDE44B1ACEC603 = "chopper";
    instance.spawned = 0;
    instance._id_FB1DEF007972B25A = _id_B586C70B173DD02B[_id_AC0E594AC96AA3A8 % _id_B586C70B173DD02B.size];
    instance._id_91403901A31FA2F8 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(instance._id_FB1DEF007972B25A);
    chopper = instance _id_20FC47823E95E4AF::_id_3EAD0708199BA214();

    if(isDefined(chopper)) {
      chopper.flaresreservecount = 0;
      scripts\mp\vehicles\damage::set_post_mod_damage_callback(chopper.vehiclename, ::_id_C5B0038C0543931B);
      scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, ::_id_8BA07C7F8F6194BD);
    }
  }
}

_id_AE71C0FB003CF6C8(pos) {
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("chopper", 1);
  instance.spawned = 0;
  instance._id_FB1DEF007972B25A = pos;
  instance._id_91403901A31FA2F8 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(pos);
  chopper = instance _id_20FC47823E95E4AF::_id_978010E5FF5D52BC(instance._id_FB1DEF007972B25A, 1);

  if(isDefined(chopper)) {
    chopper._id_0566868292EE2A1B = instance;
    instance.spawned = 1;
    instance._id_E2958F412A7425C0 = chopper;
    instance.chopper = chopper;
    scripts\mp\vehicles\damage::set_post_mod_damage_callback(chopper.vehiclename, ::_id_C5B0038C0543931B);
    scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, ::_id_8BA07C7F8F6194BD);
    chopper._id_C4A638123AC8796E = spawn("script_model", pos);
    chopper._id_CE5E3646C55AB5AB = 1;
    chopper._id_CAEBA03B8375C432 = 1;
    chopper.currentstate = "idle";
    chopper.funcs["attack"] = ::_id_63CCE55FA638900D;
    chopper.funcs["idle"] = ::_id_CD41B53D40324B83;
    chopper.flaresreservecount = 0;
    chopper._id_59BCC0EE54CDB593 = ::_id_25FF40AB41CE824E;
    scripts\mp\weapons::_id_E00B77A9CB4D8322(chopper);
  }

  return instance;
}

_id_63CCE55FA638900D() {
  self endon("death");
  self endon("state_change");
  _id_25FF40AB41CE824E(undefined);
}

_id_25FF40AB41CE824E(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  for(;;) {
    target = _id_DC271CF3D11361EB();

    if(!isDefined(target))
      target = self._id_C4A638123AC8796E;

    thread _id_D738226A67914431(target);
    self setturrettargetvec(target.origin);
    wait 0.2;
    self._id_E0BF649E3B37455D = 1;

    if(istrue(self._id_BE373AC064A5BBD3)) {
      if(self._id_580BA3BE57AF233E > level._id_6884E659BD874ED9) {
        if(level._id_920D2D352811F372 > 0 && self.damagestate < 3)
          _id_784AA75D4A32FA24::_id_9F656E924A854C1B(target, 4000, 8, randomint(360), 1000);
        else
          _id_20FC47823E95E4AF::_id_E278235100ED92F4(target);
      } else {
        _id_20FC47823E95E4AF::_id_E278235100ED92F4(target);

        if(level._id_920D2D352811F372 > 0 && self.damagestate < 3)
          _id_784AA75D4A32FA24::_id_9F656E924A854C1B(target, 4000, 8, randomint(360), 1000);
        else
          self._id_580BA3BE57AF233E = 0;
      }
    } else
      _id_20FC47823E95E4AF::_id_E278235100ED92F4(target);

    wait 1;
  }
}

_id_D738226A67914431(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");
  target endon("death_or_disconnect");
  self setlookatent(target);
  _id_29AE2ED56E057510 = 0;
  timer = 0;

  for(;;) {
    if(!istrue(self._id_652BF3292E2A7755)) {
      if(!isDefined(target) || !isDefined(target.origin))
        _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");

      _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0);
      canseetarget = scripts\engine\trace::ray_trace_passed(target.origin, self.origin, self.ignorelist, _id_C3FBB6661B91750F);

      if(timer > level._id_808F834A75546C5C || !canseetarget) {
        timer = 0;

        if(!_id_784AA75D4A32FA24::_id_E9CB677B6BA63162(target, 3000, 8, randomint(360))) {
          _id_29AE2ED56E057510++;

          if(_id_29AE2ED56E057510 > 0)
            self._id_E0BF649E3B37455D = 1;

          if(_id_29AE2ED56E057510 > 10)
            self.shouldshoot = 0;

          if(_id_29AE2ED56E057510 > 1) {
            _id_784AA75D4A32FA24::_id_03BE784D69CC30A0(target, -500);
            _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
          }
        } else {
          self._id_E0BF649E3B37455D = 0;
          self.shouldshoot = 1;
        }
      } else {
        self._id_E0BF649E3B37455D = 0;
        self.shouldshoot = 1;
      }
    }

    timer = timer + 0.5;
    wait 0.5;
  }
}

_id_CD41B53D40324B83() {
  if(self._id_CAEBA03B8375C432) {
    target = _id_DC271CF3D11361EB();

    if(isPlayer(target)) {
      self._id_CAEBA03B8375C432 = 0;
      self.currentstate = "attack";
      return;
    }

    self.currentstate = "patrol";
    return;
  } else
    self.currentstate = "attack";
}

_id_DC271CF3D11361EB() {
  self endon("death");
  self endon("state_change");
  self.currenttarget = undefined;
  _id_708956C7DE3434F3 = -1;
  target = undefined;
  _id_12729FF62E52ED4D = scripts\mp\utility\player::getplayersinradius(self._id_C4A638123AC8796E.origin, 1000);

  foreach(_id_BD73C7ACC56CD20C in _id_12729FF62E52ED4D) {
    canseetarget = _id_784AA75D4A32FA24::_id_1098BD14CAE74365(_id_BD73C7ACC56CD20C);

    if(canseetarget) {
      threat = 0;

      if(isDefined(self._id_023CB38899CBA861[_id_BD73C7ACC56CD20C.guid]))
        threat = self._id_023CB38899CBA861[_id_BD73C7ACC56CD20C.guid].threat;

      if(istrue(_id_BD73C7ACC56CD20C._id_5300C8D35F8501D5))
        threat = threat + 500;

      if(threat > _id_708956C7DE3434F3) {
        _id_708956C7DE3434F3 = threat;
        target = _id_BD73C7ACC56CD20C;
      }
    }
  }

  return target;
}

_id_C5B0038C0543931B(data) {
  result = _id_784AA75D4A32FA24::_id_C23BF5E680C0B0FC(data);
  _id_D2352921AB60AAC8(data.attacker, data.damage);
  return result;
}

_id_8BA07C7F8F6194BD(data) {
  _id_784AA75D4A32FA24::_id_31529A6224103B1A(data);

  if(isDefined(self._id_EE85C6B53E17CE57.attackers))
    _id_C2A2E571C8927D32(self._id_EE85C6B53E17CE57.attackers);

  level thread _id_1946AD0E8518602B(self._id_0566868292EE2A1B);
}

_id_1946AD0E8518602B(_id_0566868292EE2A1B) {
  if(istrue(_id_0566868292EE2A1B._id_4DBD654EFFB6B4AA)) {
    return;
  }
  _id_0566868292EE2A1B._id_4DBD654EFFB6B4AA = 1;
  level._id_A5ED64EF4E51D0F4 = level._id_A5ED64EF4E51D0F4 + 1;
  _id_FB1DEF007972B25A = _id_0566868292EE2A1B._id_FB1DEF007972B25A;
  _id_2A54ADD44D7DDF42 = getdvarint("dvar_A98AAB774D14D096", 45);

  if(_id_2A54ADD44D7DDF42 > 0 && isDefined(_id_FB1DEF007972B25A)) {
    wait(_id_2A54ADD44D7DDF42);

    if(getdvarint("dvar_12D90734562B99F6", 1) == 1)
      instance = _id_AE71C0FB003CF6C8(_id_FB1DEF007972B25A);
    else {
      instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("chopper", 1);
      instance._id_47BDE44B1ACEC603 = "chopper";
      instance.spawned = 0;
      instance._id_FB1DEF007972B25A = _id_FB1DEF007972B25A;
      instance._id_91403901A31FA2F8 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(instance._id_FB1DEF007972B25A);
      chopper = instance _id_20FC47823E95E4AF::_id_3EAD0708199BA214();

      if(isDefined(chopper)) {
        scripts\mp\vehicles\damage::set_post_mod_damage_callback(chopper.vehiclename, ::_id_C5B0038C0543931B);
        scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, ::_id_8BA07C7F8F6194BD);
      }
    }
  }
}

_id_E2204593B34B4333() {
  _id_CF627BF100B5BAFC = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++)
    _id_CF627BF100B5BAFC[_id_CF627BF100B5BAFC.size] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF("strikeunit", 3);

  _id_92DFFF01879248E6 = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_CF627BF100B5BAFC, "Helicopter");
  _id_A620CB0E6444887F = 2;
  _id_4748BBEC25D20331 = [0, 3];
  _id_73BD26998C9911B0 = [1, 4];

  while(_id_A620CB0E6444887F > 0) {
    origin = scripts\engine\utility::ter_op(_id_A620CB0E6444887F == 2, level._id_66287B06B2B17459[scripts\engine\utility::random(_id_4748BBEC25D20331)], level._id_66287B06B2B17459[scripts\engine\utility::random(_id_73BD26998C9911B0)]);

    if(isDefined(_id_48814951E916AF89::_id_77ACC10C4823DD8A(6, origin, "absolute", "bosses", "juggHelp", undefined, undefined, undefined, "saba_S5Reveal", "Helicopter", undefined, undefined, _id_92DFFF01879248E6, "ru"))) {
      _id_A620CB0E6444887F = _id_A620CB0E6444887F - 1;
      continue;
    }

    wait 1;
  }

  wait 10;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_boss_juggernaut_inbound", level.players, "saba_observatory");
  _id_CF627BF100B5BAFC = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < getdvarint("dvar_4A73270CCA0DA879", 2); _id_AC0E594AC96AA3A8++)
    _id_CF627BF100B5BAFC[_id_CF627BF100B5BAFC.size] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF("jugg", 3, "ru");

  for(_id_AC0E594AC96AA3A8 = 0; _id_CF627BF100B5BAFC.size < 6; _id_AC0E594AC96AA3A8++)
    _id_CF627BF100B5BAFC[_id_CF627BF100B5BAFC.size] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF("strikeunit", 3);

  _id_92DFFF01879248E6 = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_CF627BF100B5BAFC, "Elevator");
  _id_A620CB0E6444887F = 2;

  while(_id_A620CB0E6444887F > 0) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(6, scripts\engine\utility::random(level._id_272A9167DA8BAB6F), "absolute", "bosses", "jugg", undefined, undefined, undefined, "saba_S5Reveal", "Elevator", undefined, undefined, _id_92DFFF01879248E6, "ru");

    if(isDefined(agents)) {
      _id_A620CB0E6444887F = _id_A620CB0E6444887F - 1;

      foreach(agent in agents) {
        if(isagent(agent) && issubstr(agent.agent_type, "jugg"))
          agent thread _id_2676819F01AE14ED();
      }

      continue;
    }

    wait 1;
  }
}

_id_F55282FA2112A119() {
  _id_343D58EC0ED77AA9 = level._id_6A4C9FBD7AA58544["trapper"];
  _id_8A28FD9DF2F03764 = _id_743E6C2D23E7F91F::_id_906E0BECC84C065B(_id_343D58EC0ED77AA9._id_9E6EB7678F5C7FF3.path[0].origin, _id_343D58EC0ED77AA9._id_9E6EB7678F5C7FF3);
  _id_8A28FD9DF2F03764.damagecallback = ::_id_E23D27F12CE15EA3;
  _id_8A28FD9DF2F03764.deathcallback = ::_id_8782C70D4C26AF45;
  _id_8A28FD9DF2F03764._id_0AF81370570C04CA = 8;
  _id_8A28FD9DF2F03764._id_7CFE1B189BCF3CAD = getdvarint("dvar_EABE89E8B533A4A0", 10);
  _id_8A28FD9DF2F03764._id_D04BB72230A5A308 = getdvarint("dvar_1A99D8007C05D39B", 3);
  _id_8A28FD9DF2F03764 vehicle_turnengineon();
  _id_8A28FD9DF2F03764 thread scripts\mp\killstreaks\remotetank::_id_CF71EB6E0611096C();
}

_id_E23D27F12CE15EA3(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  _id_D2352921AB60AAC8(attacker, damage);
  _id_743E6C2D23E7F91F::_id_96B758D589365EF6(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
}

_id_8782C70D4C26AF45(inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  self notify("death");

  if(isDefined(self._id_EE85C6B53E17CE57.attackers))
    _id_C2A2E571C8927D32(self._id_EE85C6B53E17CE57.attackers);

  self.health = 1;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  self _meth_1CD1EE312FD03BB4(1);
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\killstreaks\remotetank::_id_6ADD0F629E59F222();
  self setscriptablepartstate("body_damage_heavy", "on", 0);
  self setscriptablepartstate("turret_damage", "on", 0);
  thread scripts\mp\killstreaks\remotetank::_id_C5B2E0BB2A8D5F68();
  _id_0DB78384599E4B42 = anglesToForward(self gettagangles("tag_flash"));
  self setturrettargetvec(_id_0DB78384599E4B42 * 500 + (0, -800, 0));
  wait 0.4;
  self _meth_77320E794D35465A("p2p", "pause", 1);
  wait 2.6;
  _id_9113BC9BB0599BAC = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  _id_DED28A42C0E9322E = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("atv");
  _id_9113BC9BB0599BAC._id_14090BC312DBF6C8 = _id_DED28A42C0E9322E._id_EB61D7C4087C9207;
  _id_9113BC9BB0599BAC._id_FB41D1CA75009BF0 = spawnStruct();
  _id_9113BC9BB0599BAC.weapon = "pac_sentry_turret_mp";
  scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
}

_id_8F1B9042D7FDFCDA() {
  level._id_41670C1C65F3D3CF._id_B205D90302DA2F07["saba_S5Reveal"]._id_D6EF83D5D956AFF0 = getdvarint("dvar_2E04C33F5C07E563", 10);
  level._id_8A7245A12448052F = getdvarint("dvar_A2DFB5FD5CCEEDEA", 60);
  level._id_A3A884994E83CDBA = getdvarint("dvar_9285AAF20718845D", 25);
  level._id_B205D90302DA2F07["saba_S5Reveal"]["elevatorReinforceLocs"] = [];

  foreach(loc in level._id_272A9167DA8BAB6F) {
    struct = spawnStruct();
    struct.origin = loc;
    _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D("saba_S5Reveal", "elevatorReinforceLocs", struct);
  }

  _id_6172179F6BD0769E::_id_D05835744FF53415();
  _id_D1CF55B36FACF5A8 = level._id_B205D90302DA2F07["saba_S5Reveal"]["subAreas"]["orphan"];
  _id_48814951E916AF89::_id_567F8F8CD379059C(_id_D1CF55B36FACF5A8);
  _id_48814951E916AF89::_id_B2B01599B30CFE2F(_id_D1CF55B36FACF5A8);
  _id_F55282FA2112A119();
  _id_959FE8457B7B73A9 = [(4090.96, -14855.1, 3590.81), (-9765.78, -10784.9, 2369.31), (-490.841, -11671.1, 4824), (-1514.02, -16465.9, 4671.01)];
  team = _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("ru");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < getdvarint("dvar_117C0A8500D9F0C4", 3); _id_AC0E594AC96AA3A8++) {
    wait(randomfloatrange(12.0, 18.0));
    origin = getclosestpointonnavmesh(_id_959FE8457B7B73A9[_id_AC0E594AC96AA3A8 % _id_959FE8457B7B73A9.size]);
    agents = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(5, origin, "high", "reinforcements", "postObservatoryDestruction", undefined, team, 1, _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin), 512, 1024, undefined, 1, 0, "ru");

    if(isDefined(agents)) {
      foreach(agent in agents)
      _id_48814951E916AF89::_id_C9B9FE3F7F739586(agent);
    }
  }

  _id_47B530EDBA54E625 = getdvarfloat("dvar_9DEA483AD3F25DB7", 10);
  _id_0090D3A97DB6299D = getdvarfloat("dvar_AF65E795C040B57B", 5);
  _id_C23330B945E2CC35 = 0;
  _id_17350BFD4F1FABEC = getdvarint("dvar_BB1474F55490C0D0", 2);
  _id_4B4186DFB00C3C44 = 0;

  for(;;) {
    if(_id_48814951E916AF89::_id_8C6DBB64C8E1603C(6, "low", scripts\engine\utility::random(level._id_272A9167DA8BAB6F), "saba_S5Reveal", 0, _id_D1CF55B36FACF5A8)) {
      if(istrue(level._id_425DF8E23AAEF18C) && (scripts\engine\utility::cointoss() || _id_C23330B945E2CC35 >= _id_17350BFD4F1FABEC)) {
        _id_2770AF6F8CECFC40 = level._id_66287B06B2B17459[level._id_C5C06152A4FCE37D];
        level._id_C5C06152A4FCE37D = (level._id_C5C06152A4FCE37D + 1) % level._id_66287B06B2B17459.size;
        agents = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(6, _id_2770AF6F8CECFC40, "low", "reinforcements", "s5Loop", undefined, team, undefined, "saba_S5Reveal", 512, 1024, undefined, undefined, undefined, "ru", undefined, 1);

        if(isDefined(agents)) {
          foreach(agent in agents)
          _id_48814951E916AF89::_id_C9B9FE3F7F739586(agent);

          wait(_id_47B530EDBA54E625);
          _id_C23330B945E2CC35 = 0;
          _id_4B4186DFB00C3C44 = 0;
        } else {
          wait 1;
          _id_4B4186DFB00C3C44++;
        }

        if(_id_4B4186DFB00C3C44 > 2) {
          _id_C23330B945E2CC35 = 0;
          _id_4B4186DFB00C3C44 = 0;
        }
      } else if(isDefined(level._id_265FD51BA245ADFD)) {
        agents = _id_6153E980B3EB0E1B::_id_892161AB9AD430E3(6, undefined, scripts\engine\utility::random(level._id_272A9167DA8BAB6F), "low", "reinforcements", "s5Loop", undefined, team, undefined, "saba_S5Reveal", undefined, undefined, undefined, "ru", 1);

        if(isDefined(agents)) {
          foreach(agent in agents)
          _id_48814951E916AF89::_id_C9B9FE3F7F739586(agent);

          wait(_id_47B530EDBA54E625);
          _id_C23330B945E2CC35++;
        } else
          wait 1;
      } else
        wait(_id_0090D3A97DB6299D);

      continue;
    }

    wait(_id_0090D3A97DB6299D);
  }
}

_id_FF7A4950C869224F(_id_1725B4E531E7EF35) {
  origin = getdvarvector("dvar_7BF5626F299D2840", (-2000, -12760, -4200));
  radius = getdvarfloat("dvar_7165562A8FEC9EB4", 8500);
  _id_3316A207B0665854(_id_1725B4E531E7EF35, origin, radius);
  level thread _id_6A0702EC7D611813(origin, radius);
}

_id_3316A207B0665854(_id_1725B4E531E7EF35, origin, radius) {
  level endon("radiation_starting_in_a_minute");
  level._id_250A6B25B3DE9016 = spawn("script_model", origin);
  level._id_250A6B25B3DE9016 setModel("iw9_br_observatory_ab_end_scamera_fx");
  waitframe();
  level childthread _id_8B10CDEC2B044153(_id_1725B4E531E7EF35);
  waitframe();
  level._id_9B652D14E7172892 = [];

  foreach(_id_B82575F1EA5B7619 in level._id_C64D4CBA4748D9B1)
  level._id_9B652D14E7172892[level._id_9B652D14E7172892.size] = spawnscriptable("reveal_concrete_explosion", _id_B82575F1EA5B7619.origin, _id_B82575F1EA5B7619.angles);

  level._id_C64D4CBA4748D9B1 = undefined;
  _id_00A515EF8C5AFAB1 = 0;
  _id_3B5803E733581858 = 0;
  level._id_250A6B25B3DE9016 setscriptablepartstate("observatory_ab_fx", "Stage1");
  _id_5F97BBE9C1D611FC = getdvarfloat("dvar_E236E2224285A33E", 0.1);
  _id_EC17E44B59E990E0 = int(getdvarint("dvar_634D99B1D241C565", 70) * _id_5F97BBE9C1D611FC);
  _id_D5DBCC6F379E7170 = _id_1725B4E531E7EF35 / 2;

  while(_id_3B5803E733581858 < _id_D5DBCC6F379E7170 && level._id_A208B7877B64A61E < _id_EC17E44B59E990E0) {
    playsoundatpos(origin + (0, 0, 7000), "iw9_jup_rvl_escalation_quake");
    earthquake(0.25, randomfloatrange(0.75, 1.5), origin, radius);
    time = randomfloatrange(6, 12);
    wait(time);
    _id_3B5803E733581858 = _id_3B5803E733581858 + time;

    if(!_id_00A515EF8C5AFAB1 && _id_3B5803E733581858 > _id_D5DBCC6F379E7170 / 2) {
      _id_00A515EF8C5AFAB1 = 1;
      _id_13C4FF9B1A423445("s5_mission_time_warning1");
    }
  }

  _id_13C4FF9B1A423445("s5_mission_time_warning2");

  foreach(_id_5D95D9D133CAD755 in level._id_9B652D14E7172892)
  _id_5D95D9D133CAD755 setscriptablepartstate("reveal_concrete_explosion", "Stage2");

  level._id_250A6B25B3DE9016 setscriptablepartstate("observatory_ab_fx", "Stage2");
  level thread _id_28E9D164538D3D3F();
  _id_1720FBD7B159B59D = getdvarfloat("dvar_F9FC6B8A11790003", 0.5);

  for(_id_EC17E54B59E99313 = int(getdvarint("dvar_634D99B1D241C565", 70) * _id_1720FBD7B159B59D); level._id_A208B7877B64A61E < _id_EC17E54B59E99313; _id_3B5803E733581858 = _id_3B5803E733581858 + time) {
    playsoundatpos(origin + (0, 0, 7000), "iw9_jup_rvl_escalation_quake2");
    earthquake(0.3, randomfloatrange(0.75, 1.5), origin, radius);
    time = randomfloatrange(3, 6);
    wait(time);
  }
}

_id_28E9D164538D3D3F() {
  level endon("radiation_starting_in_a_minute");

  for(;;) {
    foreach(origin in level._id_F79CDCD7196EEF74) {
      _id_5C362DCAAA44CDF0 = scripts\common\utility::agentsnear(origin, 450);
      _id_5E079C73D13D3F85 = _id_5C362DCAAA44CDF0.size <= 1;

      if(_id_5E079C73D13D3F85)
        agents = _id_48814951E916AF89::_id_353FECD1549F5F42(origin, 2000, _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("ru"), 5, undefined, 250);

      wait(getdvarfloat("dvar_7583D901039F2D41", 3));
    }
  }
}

_id_6A0702EC7D611813(origin, radius) {
  level thread _id_9C96AA833E6DFB6A();
  _id_1174ABEDBEFE9ADA::_id_E32A9BA4AA8F9FA8();

  foreach(_id_5D95D9D133CAD755 in level._id_9B652D14E7172892)
  _id_5D95D9D133CAD755 setscriptablepartstate("reveal_concrete_explosion", "Stage3");

  playrumbleonposition("s5_reveal_bunker_meltdown", origin);
  playsoundatpos(origin + (0, 0, 7000), "emt_obsv_destroyed_long_quake");
  level._id_250A6B25B3DE9016 setscriptablepartstate("observatory_ab_fx", "Stage3");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 60; _id_AC0E594AC96AA3A8++) {
    playsoundatpos(origin + (0, 0, 7000), "iw9_jup_rvl_escalation_quake3");

    if(randomfloat(100) < 20)
      earthquake(scripts\engine\math::lerp(0.3, 0.7, _id_AC0E594AC96AA3A8 / 60), randomfloatrange(0.75, 1.5), origin, radius);

    earthquake(scripts\engine\math::lerp(0.15, 0.25, _id_AC0E594AC96AA3A8 / 60), 3, origin, radius);
    wait 1;
  }

  _func_275C4CEFDE273B1A("s5_reveal_bunker_exploding", origin);
  playsoundatpos(origin + (0, 0, 7000), "emt_obsv_destroyed_long_quake");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 60; _id_AC0E594AC96AA3A8++) {
    playsoundatpos(origin + (0, 0, 7000), "iw9_jup_rvl_escalation_quake3");
    earthquake(scripts\engine\math::lerp(0.6, 1.0, _id_AC0E594AC96AA3A8 / 60), randomfloatrange(0.5, 1.0), origin, radius);
    earthquake(0.25, 4, origin, radius);
    wait(randomfloatrange(0.75, 2.5));
  }
}

_id_8B10CDEC2B044153(_id_1725B4E531E7EF35) {
  if(isDefined(level._id_D49FE7F07F2BA493) && isDefined(level._id_D49FE7F07F2BA493._id_325F9F15252B4928))
    level thread[[level._id_D49FE7F07F2BA493._id_325F9F15252B4928]]();

  if(!isDefined(level._id_247B22E11B648F93)) {
    return;
  }
  level._id_247B22E11B648F93 = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(level._id_247B22E11B648F93), 0, int(level._id_247B22E11B648F93.size * 2 / 3));
  _id_448A485356686EB3 = level._id_247B22E11B648F93.size * 3;
  waittime = (_id_1725B4E531E7EF35 - 60) / _id_448A485356686EB3;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    foreach(_id_A0501ED78566F669 in level._id_247B22E11B648F93) {
      wait(waittime);
      _id_A0501ED78566F669 _id_72D6AF97CFC97305::_id_53B4A8ACE69C59EA();
    }

    level._id_247B22E11B648F93 = scripts\engine\utility::array_randomize(level._id_247B22E11B648F93);
  }
}

_id_9C96AA833E6DFB6A() {
  if(isDefined(level._id_247B22E11B648F93)) {
    foreach(_id_A0501ED78566F669 in scripts\engine\utility::array_randomize(level._id_247B22E11B648F93)) {
      wait 1;
      _id_A0501ED78566F669 _id_72D6AF97CFC97305::_id_7FDB264C9E19B7B8();
    }
  }
}

_id_C52DAA600FD711F2() {
  _id_ACBCC50DD8904645 = [];

  foreach(point in level._id_0F62895BA192058F) {
    _id_ACBCC50DD8904645[_id_ACBCC50DD8904645.size] = spawnscriptable("radiation_cannister_s5_reveal", point.origin, point.angles);
    _id_ACBCC50DD8904645[_id_ACBCC50DD8904645.size - 1] setscriptablepartstate("radiation_cannister_s5_reveal", "usable_in_container");
    spawnscriptable("radiation_cannister_cover_s5_reveal", point.origin, point.angles);

    if(_id_ACBCC50DD8904645.size % 3 == 0)
      waitframe();
  }

  foreach(point in level._id_B94570229276D11F) {
    _id_ACBCC50DD8904645[_id_ACBCC50DD8904645.size] = spawnscriptable("radiation_cannister_s5_reveal", point.origin, point.angles);

    if(_id_ACBCC50DD8904645.size % 3 == 0)
      waitframe();
  }

  level._id_0F62895BA192058F = undefined;
  level._id_B94570229276D11F = undefined;
}

_id_561E33CF5FCF6690(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state != "usable" && state != "usable_in_container") {
    return;
  }
  if(istrue(player._id_5300C8D35F8501D5) || istrue(player._id_46F5AF715F280C8C)) {
    player scripts\mp\hud_message::showerrormessage("DMZ/CANT_USE_GAS_CANISTER");
    return;
  }

  player thread _id_7E52B56769FA7774::playerplaypickupanim();

  if(state == "usable_in_container") {
    player playSound("iw9_jup_rvl_gas_pickup_inPod");
    instance setscriptablepartstate(part, "unusable_taken_out_of_container");
    player._id_46F5AF715F280C8C = 1;
    player endon("death_or_disconnect");
    wait 0.6;
    player._id_46F5AF715F280C8C = undefined;
  } else {
    instance freescriptable();
    player playSound("iw9_jup_rvl_gas_pickup_onGround");
  }

  player._id_5300C8D35F8501D5 = 1;

  if(getdvarint("dvar_CE52146C424DBEDD", 1) == 1)
    player scripts\mp\utility\perk::giveperk("specialty_third_person");

  player _meth_1863F51C1339D80F("bgfull");
  player _id_4480C6CE37B2BDF3::_id_0C3F3FCEEDDDA6F6("jup_military_chemical_weapon_canister_01_back_att");

  if(!istrue(level._id_B24DF4F49945B8F3)) {
    if(!istrue(player._id_9548059E69CE7D8C))
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_exfil_canister", [player]);

    player._id_9548059E69CE7D8C = 1;
  }

  foreach(exfil in level._id_613667408830E919) {
    if(isDefined(exfil.heli)) {
      if(isDefined(exfil.heli.objid) && !istrue(level._id_B24DF4F49945B8F3))
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(exfil.heli.objid, player);

      if(isDefined(exfil.heli.prompt))
        exfil.heli.prompt enablescriptableplayeruse(player);
    }
  }

  if(!istrue(level._id_627C34C41EADB784) && !_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE()) {
    level._id_627C34C41EADB784 = 1;
    level thread _id_448B3B5440C12A11();
  }
}

_id_F3EB76C1F716B57A(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!istrue(player._id_5300C8D35F8501D5)) {
    player scripts\mp\hud_message::showerrormessage("DMZ/CANT_PLACE_GAS_CANISTER");
    return;
  }

  player._id_5300C8D35F8501D5 = undefined;

  if(getdvarint("dvar_CE52146C424DBEDD", 1) == 1)
    player scripts\mp\utility\perk::removeperk("specialty_third_person");

  player _meth_1863F51C1339D80F("none");
  player _id_4480C6CE37B2BDF3::_id_6D569066AC5F3DF0();
  player thread _id_7E52B56769FA7774::playerplaypickupanim();

  if(!istrue(player._id_AD6208F9F0689AE6)) {
    player._id_AD6208F9F0689AE6 = 1;
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("s5_reveal_find_more_canisters", [player]);
  }

  if(instance._id_BF8E5F003146AF44._id_ACBCC50DD8904645.size > 0) {
    _id_3085F735A2B64F01 = sortbydistance(instance._id_BF8E5F003146AF44._id_ACBCC50DD8904645, player.origin)[0];
    _id_3085F735A2B64F01 setscriptablepartstate("radiation_cannister_s5_reveal", "unusable");
    instance._id_BF8E5F003146AF44._id_ACBCC50DD8904645 = scripts\engine\utility::array_remove(instance._id_BF8E5F003146AF44._id_ACBCC50DD8904645, _id_3085F735A2B64F01);
  }

  _id_1B81D33201A1832D(player);
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E2005424F0CFB53E");
  level._id_A208B7877B64A61E = level._id_A208B7877B64A61E + 1;
  _id_64E83843CDA5F175 = level._id_A208B7877B64A61E == level._id_349709753E702CAF;
  _id_BDFAA0236C3A6B7E = level._id_A208B7877B64A61E > level._id_349709753E702CAF && (level._id_A208B7877B64A61E - level._id_349709753E702CAF) % level._id_2C589D7F94E04811 == 0;
  _id_D1A911B71F8BD838 = getdvarint("dvar_634D99B1D241C565", 70);

  if((_id_64E83843CDA5F175 || _id_BDFAA0236C3A6B7E) && level._id_A208B7877B64A61E < _id_D1A911B71F8BD838)
    level thread _id_E2204593B34B4333();

  _id_054E12604C8147FA = int(min(level._id_A208B7877B64A61E, _id_D1A911B71F8BD838));
  setomnvar("ui_reveal_canisters_exfiled", _id_054E12604C8147FA);

  if(!istrue(level._id_B24DF4F49945B8F3) && level._id_A208B7877B64A61E >= _id_D1A911B71F8BD838) {
    level._id_B24DF4F49945B8F3 = 1;
    _id_1C2E3619F4154F5F = int(scripts\mp\utility\game::gettimepassed() / 1000 + 61);
    scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", _id_1C2E3619F4154F5F);
    setDvar("scr_br_timelimit", _id_1C2E3619F4154F5F);
    setomnvar("ui_hardpoint_timer", gettime() + 61000);
    level notify("radiation_starting_in_a_minute");
    level._id_E8CE6AE6F3F1F783 = "stat_E939079CC62192B5";
    level._id_1FD6C0BD5D448B7A = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  }

  foreach(exfil in level._id_613667408830E919) {
    if(isDefined(exfil.heli)) {
      if(isDefined(exfil.heli.objid) && !istrue(level._id_B24DF4F49945B8F3))
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(exfil.heli.objid, player);

      if(isDefined(exfil.heli.prompt))
        exfil.heli.prompt disablescriptableplayeruse(player);
    }
  }
}

_id_593D87573BBF3FEF() {
  wait 0.5;
  _id_8B9AFA01884639A9 = spawn("script_origin", (-2134, -15572, 5152));
  wait 0.1;
  _id_6624633D92085438 = spawn("script_origin", (-3306, -12656, 3202));
  _id_8B9AFA01884639A9 playLoopSound("emt_obsv_destroyed_alarm_bell_lp");
  wait 0.1;
  _id_1F18BE354CCFDA37 = spawn("script_origin", (-1735, -12133, 4551));
  _id_6624633D92085438 playLoopSound("emt_obsv_destroyed_alarm_bell_lp");
  wait 0.1;
  _id_4A57D99296405E5E = spawn("script_origin", (-3964, -11560, 3201));
  _id_1F18BE354CCFDA37 playLoopSound("emt_obsv_destroyed_alarm_lp");
  wait 0.1;
  _id_4A57D99296405E5E playLoopSound("emt_obsv_destroyed_alarm_smoke_lp");
}

_id_D21AA44758FC341B() {
  self.heli endon("death");
  _id_5C65D346AC65390C::_id_18D68B06FA34264B(self.heli);
  _id_4D58B9543986F1CA = _id_5C65D346AC65390C::_id_1093B8F392744E3B(self, self.origin, level._id_251923794D7ECF20.heliheight, 1, self.heli.angles);
  self.heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_4D58B9543986F1CA);
  wait 2;

  if(!_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE())
    self.heli scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("veh9_palfa", "forceOOBEnable");

  wait 60;
  self.heli thread _id_5C65D346AC65390C::_id_0ED686FCBC5363B3();
  self.heli = undefined;
}

_id_448B3B5440C12A11() {
  foreach(_id_164E7E721F38101C in level._id_E0590C3F9664968C) {
    sortbydistance(level._id_613667408830E919, _id_164E7E721F38101C)[0] thread _id_0AB5767121AB2CB0(1);
    wait(randomfloatrange(4.0, 7.0));
  }
}

_id_0AB5767121AB2CB0(_id_C52DAA600FD711F2) {
  _id_4D58B9543986F1CA = _id_5C65D346AC65390C::_id_0ED11AE9FE1ABDEB(self, self.origin);
  self.heli = _id_5C65D346AC65390C::_id_D05F47D864F18196(undefined, _id_4D58B9543986F1CA.origin, _id_4D58B9543986F1CA.angles, 0, 0);
  self.heli.exfil = self;
  self.heli._id_675F44ED226AED7D = ::_id_9215E3A9DFE8A262;
  self.heli._id_7B468990DA46C73C = ::_id_83EA10956EF420C4;
  self.heli._id_ACBCC50DD8904645 = [];

  if(_id_C52DAA600FD711F2) {
    foreach(location in level._id_C5E6F7A1BBEF83D0) {
      [origin, angles] = location;
      _id_4E0D9C78FA04CDD4 = spawnscriptable("radiation_cannister_s5_reveal", origin, angles);
      _id_4E0D9C78FA04CDD4 setscriptablepartstate("radiation_cannister_s5_reveal", "invisible_unusable");
      _id_4E0D9C78FA04CDD4 scripts\common\utility::_id_6E506F39F121EA8A(self.heli, origin, angles);
      self.heli._id_ACBCC50DD8904645[self.heli._id_ACBCC50DD8904645.size] = _id_4E0D9C78FA04CDD4;
    }
  }

  self.heli.prompt = spawnscriptable("radiation_cannister_place_prompt_s5_reveal", self.heli.origin);
  self.heli.prompt scripts\common\utility::_id_6E506F39F121EA8A(self.heli, (-75, 0, -150));
  self.heli thread _id_5C65D346AC65390C::_id_A5FC6E8F9DF1CCEA(self.heli, self.origin);
  self.heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_4D58B9543986F1CA);
  self.heli endon("death");
  wait 20;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    self.heli.objid = objid;
    objective_setdescription(objid, &"MP_INGAME_ONLY/EXFIL_CHOPPER");
    objective_icon(objid, "ui_map_icon_extraction_fulton");
    objective_setbackground(objid, 1);
    objective_state(objid, "current");
    objective_onentity(objid, self.heli);
    objective_setzoffset(objid, -150);
    objective_setownerteam(objid, undefined);
    objective_setprogressteam(objid, undefined);
    objective_setplayintro(objid, 0);

    if(!istrue(level._id_B24DF4F49945B8F3)) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);

      foreach(player in level.players) {
        if(istrue(player._id_5300C8D35F8501D5)) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
          continue;
        }

        if(isDefined(self.heli.prompt))
          self.heli.prompt disablescriptableplayeruse(player);
      }
    } else {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);

      foreach(player in level.players) {
        if(isDefined(self.heli.prompt))
          self.heli.prompt disablescriptableplayeruse(player);
      }
    }
  }
}

_id_E3E997EA578B5F54() {
  if(isDefined(self.objid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objid);
    self.objid = undefined;
  }

  self.exfil thread _id_D21AA44758FC341B(level._id_B9F31FABCB241505[self.exfil.target]);

  for(;;) {
    foreach(exfil in self.exfil._id_DC8ACEF80DBBBDFB) {
      if(isDefined(exfil.heli)) {
        continue;
      }
      exfil thread _id_0AB5767121AB2CB0(1);
      return;
    }

    wait 2;
  }
}

_id_F95D6A095F14CD9C() {
  _id_6C8F3693DDC4B4CF = 0;

  if(isDefined(level._id_A2B890D129C64761) && isDefined(level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF))
    _id_6C8F3693DDC4B4CF = level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF;

  dlog_recordevent("dlog_event_jupiter_reveal_totals", ["match_end_result", level._id_E8CE6AE6F3F1F783, "bosses_killed", level._id_A5ED64EF4E51D0F4, "canisters_collected", level._id_A208B7877B64A61E, "makarov_radios_used", level._id_BB3A493B46C82724, "silos_captured", _id_6C8F3693DDC4B4CF, "time_canisters_collected", level._id_1FD6C0BD5D448B7A, "time_map_swap", level._id_F82AD22CC10CFB24]);
}