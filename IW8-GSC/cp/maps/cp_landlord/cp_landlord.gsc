/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_landlord\cp_landlord.gsc
***********************************************/

main() {
  scripts\cp\cp_compass::setupminimap("_encstr_84E2187AA0F9930EC087371DBB8359179F5E02C228C5BBC5A081");
  _encstr_8C8F35373FCE6280488B150EC3BAD5BAA7773EFF81E0FA496071FD15FBB8AF527F97BB6F1595420FA89939DAD3582B0A5E1107DAFF46FA::main();
  _encstr_8B513437C62796E03A37F2C638E5AD58E06E97B1C1D71B58CD231BBD9332E5B359E6976C38EBD8C2DC8C36BD93327D162747E2D9E6B1::main();
  _encstr_BD522F7A164D3AC03B207E47503885E2E1B6D5F607EFA21940800B6F78890F0AB9D88DEEE031DA2F2BA8CF43C0E83FB377::main();
  _encstr_BE6D356EB193D207A3375EC683F26B580EB9BC36E0EB1BC2CD46C67B2732BCC638BE8D0BB9C8B1BD9C917DB1B4CEA18ED237D9C5D99BD8::main();
  level.default_player_spawns = "_encstr_9BD00F2356CCB0D5C6E8BEB98358DDCDFA" + level.script;
  scripts\cp\cp_compass::setupminimap("_encstr_84E2187AA0F9930EC087371DBB8359179F5E02C228C5BBC5A081");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);

  if(level.createfx_enabled) {
    return;
  }
  registerscriptedagents();
  scripts\cp_mp\tripwire::precache("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_92561EBFCB9DB25070B9951B16488529F52517637FCB4B3DB9414FA46880DEE2");
  scripts\cp_mp\tripwire::precachetrap("_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE", "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23", 1);
  scripts\cp\utility::coop_mode_enable();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  create_level_funcs_tables_and_vars();
  init_global_systems();
  init_objectives();
  init_level_systems();
  level.incorrectcodeentered = 1.5;
  _encstr_8CA138D05F059188B39BAA57D18615333B18E568BA26B18B521542675B957011C0E184C9CE59BD287AF197D6C095088F73A74268CB5FA8B43771::_id_131ED();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_8215098EAD8EBCB1AF1C26", _encstr_8CA138D05F059188B39BAA57D18615333B18E568BA26B18B521542675B957011C0E184C9CE59BD287AF197D6C095088F73A74268CB5FA8B43771::getplatformrankxpmultiplier);
  var_0 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level._id_12B19[var_0]]]();
  } else {
    if(_id_132D6()) {
      _encstr_868025B3E9BE2F92307F8FCB51C21F576941BB9B139D8F9D7061C7C3237063BF0C79B276596E77::mortars_get_enemies();
      var_1 = getDvar("_encstr_86D1161B8B078A43A0B9B4F5D3F1D7BF2C66A31B603FF1D2", "_encstr_BD2D163AA828594A2EAFAFBB355B2287A89135878D7B1A12");
    } else
      var_1 = getDvar("_encstr_86D1161B8B078A43A0B9B4F5D3F1D7BF2C66A31B603FF1D2", "_encstr_BA061352A1B8ED02C893BFFFDF615A2E10A8CD9A79");

    if(var_1 == "_encstr_B40101")
      var_1 = "_encstr_BA061352A1B8ED02C893BFFFDF615A2E10A8CD9A79";

    setDvar("_encstr_86D1161B8B078A43A0B9B4F5D3F1D7BF2C66A31B603FF1D2", var_1);

    if(isDefined(var_1))
      level thread rundebugstartobjective(var_1);
  }

  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread increment_factor();
}

_id_132D6() {
  if(_encstr_868025B3E9BE2F92307F8FCB51C21F576941BB9B139D8F9D7061C7C3237063BF0C79B276596E77::_id_124B9())
    return 0;

  if(getdvarint("_encstr_B1681DDBAB02267845F1A019A52C30E84BEB37791BAA73C88AD908F0CF19E8", 0) == 0)
    return 0;

  return 1;
}

increment_factor() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_BE90135A63C0CF6A8159E9FE51C07573F510F23288", 1);
}

create_level_funcs_tables_and_vars() {
  level.objectivesfunc = ::levelobjectives_init;
  level.map_interaction_func = _encstr_8F81392E3AEBC0A0445BEA1EC3D0677F783BE752F3170411402971508BD27D61F89910710B8830FDC8CABFB8ABF3FF52CEE7442BED301BDEB25BBB::register_interactions;
  level.player_interaction_monitor = _encstr_8F81392E3AEBC0A0445BEA1EC3D0677F783BE752F3170411402971508BD27D61F89910710B8830FDC8CABFB8ABF3FF52CEE7442BED301BDEB25BBB::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_8F81392E3AEBC0A0445BEA1EC3D0677F783BE752F3170411402971508BD27D61F89910710B8830FDC8CABFB8ABF3FF52CEE7442BED301BDEB25BBB::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_9AFA3D732AD3A390137B5F3F802DB07F038340F9830F6940AD44D12FAAA7DA36ABB9A0210A5B91F8C25CAF07A5CEE888ABC39948E25F5D08DF3EF1BDCBB280";
  level.disable_start_spawn_on_navmesh = 1;
  level.additional_laststand_weapon_exclusion = [];
  level.ambientgroupinit = ::register_spawn_modules;
}

init_objectives() {
  level thread scripts\cp\cp_objectives::objectives_init();
  level thread setup_global_event_objectives();
}

levelobjectives_init() {
  level.objectives_table = "_encstr_A3871E91E22F183FF9A3DBFDBBF288D83CB198C90CCDA0F57223DBCFFA6ACE20";
  level.objectivesmatrixtable = "_encstr_86C024AE9A02EA0FC75A5F98D3155FC3DE4836A2D773E973A03D532159FF988591085AF3F3F8";
  level.objectiveregistration = ::levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

init_global_systems() {
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_AB560E05670AE9D86FEB60D0DF619117", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\mkilo23_ai_infil::main("_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_83FF0EA067A1481F49AA9B1B42024F13", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1");
  scripts\vehicle\empty_turret::main("_encstr_96CE0F8D83AF1DABC9C9563AF5C4DB2397", "_encstr_8C2A0D6F68EF6DE92E0B681D764723", "_encstr_AC291C7FFB0AD8B75B71B3D9EAC7E628676FEBCB70F3106863CBCB2302EB");
  scripts\cp\cp_remote_tank::main("_encstr_BE60197393DBEB2F50DA9D27AD609F87204017E5D573216D879BA3", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AAE42838923A7BA363E78475B87F8929A7F970A8C996BFF83BCD07F7B7DF10F30FB208C83221D311AFFC");
  scripts\cp\cp_remote_tank::main("_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AA6E28FF6F7308C395309EDDD0630AC369B1DAFB9E67226A2DC5B91B991F58F197A303A748F143131704");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  setup_create_script();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_BA090995A1F8EC42C89DE3");
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
}

init_level_systems() {
  level thread setup_map_specific_devgui();
  level thread wait_for_pre_game_period();
  level thread heli_crash_path_loc_setup();
  level thread spawn_technicals_for_players();
  level thread _encstr_99A330CDB1E4B4E047DC976C3879B58538CDBCC6C1FA23BD9BCAD1E65BCB36E0D791DE73CA1D37B57D4BE6A32B63B8ECB98D::init_intel_pieces();
}

spawn_technicals_for_players() {
  wait 10;
  var_0 = spawnStruct();
  var_0.origin = (29647.5, -9049.5, -424);
  var_0.angles = (0, 120, 0);
  var_0.team = "_encstr_9A8507BA4040188D08";
  scripts\cp_mp\vehicles\technical::technical_create(var_0);
  var_0 = spawnStruct();
  var_0.origin = (17811.5, -22229.5, -210.101);
  var_0.angles = (0, 135, 0);
  var_0.team = "_encstr_9A8507BA4040188D08";
  scripts\cp_mp\vehicles\technical::technical_create(var_0);
}

heli_crash_path_loc_setup() {
  wait 2;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}

rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.csdependency)) {
      if(!scripts\engine\utility::flag_exist(var_1.csdependency))
        scripts\engine\utility::flag_init(var_1.csdependency);

      scripts\engine\utility::flag_set(var_1.csdependency);

      if(!scripts\engine\utility::flag_exist(var_1.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8"))
        scripts\engine\utility::flag_init(var_1.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8");

      scripts\engine\utility::flag_wait(var_1.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8");
    }

    if(isDefined(var_1.ondebugstartfunc))
      [[var_1.ondebugstartfunc]](var_1);

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
  }
}

levelregisterobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level thread _encstr_A62C388AE6BDCA10EBF0CEF78368F5B251060506D7BF5247F078BB4FC050B3EBB7159DFD3541FB9BFE40EB2349307E628534E6F3AE8166DF8338::overwatch_init();
  level thread _encstr_913D3723FE03EF5AA9A0C61AA0475587FB5EF7AB8F4E03A5B5787B1350AF0E7B764D0F2EAD73176C2F1062BA090BC4BB89A38DD4B590BF327F::main();
  level thread _encstr_BEDC36FA96CDBA40BBA0FEC7D0B8056261365576876FA297C008EB9F3060C3BB67C5CDADE591ABAB0E18BB271001BBF2DDED12E0F8EF63EB::main();
  level thread _encstr_81872FF74B22DABBBB5347B7AAFA1F31C34F655BB807A4AD4DACC973A87321A51FF339E85ECB7FD0892B23C369C6276769::registertmtylobjective();
  level thread _encstr_A62C388AE6BDCA10EBF0CEF78368F5B251060506D7BF5247F078BB4FC050B3EBB7159DFD3541FB9BFE40EB2349307E628534E6F3AE8166DF8338::register_overwatch_objective();
  level thread _encstr_91BC3DB9C69CA53847DC978D1C5EDAC20EB9E58D1CFAC8B7E6CAA36EB579C61C7D46DB73AC3A9BDAAFCDC23395D0BDD56EACD7360BDC461B7B939117EC37B1::registersafehouse();
  scripts\cp\cp_objectives::registerobjective("_encstr_BD2D163AA828594A2EAFAFBB355B2287A89135878D7B1A12", undefined, ::_id_124BA, undefined, undefined);

  if(isDefined(level.airfield_obj_func))
    [[level.airfield_obj_func]]();

  if(isDefined(level.obj_bb_recovery))
    [[level.obj_bb_recovery]]();
}

_id_124BA(var_0) {
  if(_encstr_868025B3E9BE2F92307F8FCB51C21F576941BB9B139D8F9D7061C7C3237063BF0C79B276596E77::_id_124B9())
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_BA061352A1B8ED02C893BFFFDF615A2E10A8CD9A79");
  else {
    level thread _id_123F8();
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_82040C6F3160DFAB4053A3C1F672");
    level waittill("_encstr_A32B1CC3D94F6B9D6083318318A8AFA295531B07A56EB25DE128754F90C0");
  }
}

_id_123F8() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  level thread _encstr_91BC3DB9C69CA53847DC978D1C5EDAC20EB9E58D1CFAC8B7E6CAA36EB579C61C7D46DB73AC3A9BDAAFCDC23395D0BDD56EACD7360BDC461B7B939117EC37B1::managejumpmasterinfodisplay();
}

setup_global_event_objectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_objectives_events::init();
  level thread scripts\cp\cp_objectives_events::run("_encstr_880C3C3BB35631C950FFEF1ED84E55AE898282F758FFAC08F2E9603BCA081BD9B823C8F505CBE08A390FDE0A57A92BF0436848F73594D5505C5BE6DAFFF3");
}

setup_create_script() {
  level.threadedscriptspawners = 1;
  level.create_script_file_ids = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  register_cs_inits();
  register_create_script_arrays("_encstr_AC8F20C7E35F7D4A0A180C88120924F828B44BA7AB1818A16844402E8F088BC3CACA", "_encstr_AC8F20C7E35F7D4A0A180C88120924F828B44BA7AB1818A16844402E8F088BC3CACA", level.scripted_spawner_func.size, _encstr_99A340CDB1E4B4E047DC976C3879B58538CDBCC6C1FA63859BC8B1DE9319F2C61C7DC87BDC5947B9ADFAC60B7323B1ED39917D34B21B5A1BF61C3A56279B8BCEE68D::main);
  register_create_script_arrays("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B", "_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B", level.scripted_spawner_func.size, _encstr_99083AB85FAA787721EEF8F14932F5A64353D6AED82940B2D24CBAA5091F77A95B57D13C1282288353A556BF2E95E19CFDEE1F662B9AD1439062F722::main);
  register_create_script_arrays("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", "_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", level.scripted_spawner_func.size, _encstr_A20A380EDB739021DBFBAAC0E3252329D353B88E201FF95705E268784ADDF74317EC10F08DDB4387A1AB40E063A5D79B4782AD78F47F20D792B2::main);
  register_create_script_arrays("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", "_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", level.scripted_spawner_func.size, _encstr_92A233BBE21B7B48DBB3E777D855F837BB5BB8213B57257875BD294FFBBD40075F420808F253E660C19915491D55D946077E81533A::main);
  register_create_script_arrays("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46", "_encstr_97BF19B107FAD8859C951C2C1BB6B0D9567DD84E0B47B2E6AFD86E", level.scripted_spawner_func.size, scripts\cp\crate_drops\cp_crate_drops_cs::main);
  register_create_script_arrays("_encstr_AAEA1B1B1BC9FFEBBF428C8F3CDF50D7AEA3B8A8F39F67838F6A9B7F14", "_encstr_AAEA1B1B1BC9FFEBBF428C8F3CDF50D7AEA3B8A8F39F67838F6A9B7F14", level.scripted_spawner_func.size, _encstr_B1843A5780D3C9A341167D66FF8F0A89FB98AEAFB0AE3C9A5D25B31A6AA72240A610533F580371739F4B7116CEEB5A0C0929CFBFF0B8B8BB6DD4420E::main);
  register_create_script_arrays("_encstr_83501A7663A96439BE13C292FDD0D1561B4DD17BD9998F41D3946BBB", "_encstr_83501A7663A96439BE13C292FDD0D1561B4DD17BD9998F41D3946BBB", level.scripted_spawner_func.size, _encstr_81763A4F98CBE18B792E557E97E712B1D370468798C62C42B54D8D75FE290E7B3BA9C317C05994EAA555596EE6C3221421412797D850C0A345FC5A66::main);
  register_create_script_arrays("_encstr_8876102BA9B153E76D72A2991BCE43CC2059", "_encstr_8876102BA9B153E76D72A2991BCE43CC2059", level.scripted_spawner_func.size, _encstr_A9443117A7D34B22F83820A2934049D6D3A80E11DBCFDB35B08751AB0D8F898A06830EA9D1FC731A21F61B46C7338158297B07::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("_encstr_8876102BA9B153E76D72A2991BCE43CC2059", (0, 0, 0), (0, 0, 0));
  register_create_script_arrays("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF", "_encstr_84A81E9798F644D2F59D2BE2F2EF6B09B9A8331F18ABBD19D9A7B55F69A7B3D4", level.scripted_spawner_func.size, _encstr_9B81409BC64E96E0A36E5E6CC1E56BB0C1CDF26CC1D78CEDDC95A3E6B5793607AFC87B372BD1E65BFADC2C66B234EDAB372BF58D0BB9238DB73923AFD8DCB83B37C6::main);
  register_create_script_arrays("_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1", "_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1", level.scripted_spawner_func.size, _encstr_BAFD38CDB1935A1CA39B971B83F2D6C21C3797D81CD78CB737AC1D37ADCB5B580ED78CF6BBDCE8DBEE73BEE02CE84EF6B1EB1C2CA3865CD9CD6C::main);

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
}

register_create_script_arrays(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;

  if(isDefined(var_1))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;

  if(isDefined(var_2))
    level.create_script_file_ids[var_0] = "_encstr_8A0703D983" + var_2;

  if(isDefined(var_3))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
}

register_cs_inits() {
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_83501A7663A96439BE13C292FDD0D1561B4DD17BD9998F41D3946BBB");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_AC8F20C7E35F7D4A0A180C88120924F828B44BA7AB1818A16844402E8F088BC3CACA");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
}

onplayerspawneddevguisetup(var_0) {
  var_1 = var_0.name;
  var_2 = undefined;

  foreach(var_5, var_4 in level.players) {
    if(var_4 == var_0) {
      var_2 = int(var_5);
      break;
    }
  }

  if(isDefined(var_2))
    var_0 thread setupdevguientries(var_0, var_1, var_2);
}

setupdevguientries(var_0, var_1, var_2) {}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  wait 0.2;
  scripts\cp\cp_objectives::registerobjective("_encstr_8F560CB32953C96271EFFB03033C", undefined, undefined, undefined, undefined, undefined);
}

registerscriptedagents() {
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

onplayerconnect(var_0) {
  var_0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
  var_0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();

  if(getdvarint("_encstr_BA5A1066DE93C695AF9BC10BDD377D9DAC86", 0) != 0) {
    var_1 = [(20120, -24623, 1000), (19554, -24184, 1000), (18935, -23685, 1000), (18319, -22907, 1000), (13692, 15239, 1000), (14316, 16296, 1000)];

    foreach(var_3 in var_1)
    scripts\cp\vehicles\little_bird_cp::spawn_little_bird_at_location(var_3, (0, 0, 0), "_encstr_9A8507BA4040188D08");
  }
}

onplayerspawned() {}

setup_map_specific_devgui() {}

register_spawn_modules() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", 0, 24, undefined, 0.1, undefined, "_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", scripts\cp\cp_modular_spawning::init_wave_settings);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92EC1C070331F5B0BE8F538B34A740BDDA8F87AF9B7AC4E0DB695B41DA54", 0, 6, undefined, 0.1, undefined, "_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", scripts\cp\cp_modular_spawning::toggle_teleport_enemy_info_loop);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_92EC1C070331F5B0BE8F538B34A740BDDA8F87AF9B7AC4E0DB695B41DA54", scripts\cp\cp_modular_spawning::toggle_teleport_enemy_info_loop);
  scripts\cp\cp_modular_spawning::register_module_as_passive("_encstr_92EC1C070331F5B0BE8F538B34A740BDDA8F87AF9B7AC4E0DB695B41DA54");
  scripts\cp\cp_modular_spawning::register_module_as_passive("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9");
}

set_vehicle_settings_on_spawners(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::process_module_var(var_0, var_0.spawn_points);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] scripts\cp\cp_modular_spawning::initialize_as_veh_spawner();
}