/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_arms_dealer\cp_arms_dealer.gsc
*****************************************************/

main() {
  _id_13530("_encstr_A1BB1F4C371DBE0B275B3719590B3656E4AF9B2C99561A7BAEDC957DE6A3B093E8");
  scripts\cp\cp_compass::setupminimap("_encstr_A26A1BB852FD49817FCB1071B11B0E37E2F910B8EA92DFF91FC1817D9A");
  _encstr_B16E3BA211E81173558FDED7B1D0EA51A07BCD2EEB29A18B216717C3F3AFC28D58485672A6207A320627E3DFE3C19AD2894B8ABFD988339A55EDE78FCF::main();
  _encstr_96763A4F98CBE18B792E557E97E712B1D370468798C62173B3C641B775233A7D7B2AEF07C0309B1BFFD712ED66B77205A1D87FD3B151C2A345FC5A66::main();
  _encstr_9A693502E32B4B10A3ABC8F7FB2650D2F33FF7F91079CB8397126F502D5755B7304D7683FFF92A9A5BCFA87D6F7D9FE20E22799AFF16E8::main();
  _encstr_85AE3BEA59A0592B1DC7A69FE968228958A3757693711943F9DF5F9B3B677AC510809E3AEEE8B24ACEEFBB971B99D22AD1709447609861322C35AF3707::main();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8C6A0AAFE187993125FC3337", 1.0);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);

  if(level.createfx_enabled) {
    return;
  }
  registerscriptedagents();
  level.objectivesfunc = ::levelobjectives_init;
  scripts\cp_mp\tripwire::precache("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_92561EBFCB9DB25070B9951B16488529F52517637FCB4B3DB9414FA46880DEE2");
  scripts\cp_mp\tripwire::precachetrap("_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE", "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23", 1);
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_B4A9235E8B79E48A40BBBBAF8FE0524A4073D9E741D0A4E2A637D3CF99933A9F503BCFEA3B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6");
  scripts\cp\utility::coop_mode_enable();
  level.incorrectcodeentered = 1.5;
  scripts\cp_mp\utility\game_utility::registerlargemap();
  level.disable_start_spawn_on_navmesh = 1;
  level.interaction_trigger_properties_func = ::set_interaction_trigger_properties;
  level.map_interaction_func = _encstr_A2AF3F6E1BE44BC18E37CB6C0EBC5B0B07B9CBC60E7D16C9B637AF19B2C2D895C9E56C0ED7B027B6E6BE3259C2362B39F596DC8EAC930BC6E8A5BD9BB917D9DCD8::register_interactions;
  level.player_interaction_monitor = _encstr_A2AF3F6E1BE44BC18E37CB6C0EBC5B0B07B9CBC60E7D16C9B637AF19B2C2D895C9E56C0ED7B027B6E6BE3259C2362B39F596DC8EAC930BC6E8A5BD9BB917D9DCD8::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_A2AF3F6E1BE44BC18E37CB6C0EBC5B0B07B9CBC60E7D16C9B637AF19B2C2D895C9E56C0ED7B027B6E6BE3259C2362B39F596DC8EAC930BC6E8A5BD9BB917D9DCD8::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_95E6436ED8E4A507A3DCE5B107976BB00E6E978D1C7DB04EDA9BF523B20B63CA27976C0EF5589C5BB9FA4659168D5927FABB2B5807BD734E8537AD7D95D956E6A3C5D8CD67";
  level.additional_laststand_weapon_exclusion = [];
  level.ambientgroupinit = ::register_spawn_modules;
  level.init_personal_ent_zones = scripts\cp\coop_personal_ents::init_personal_ent_zones;

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  level thread setup_map_specific_devgui();
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  level thread scripts\cp\cp_objectives::objectives_init();
  level thread _encstr_A9D12FB9364EA5E0E8DC971B075EAD1683E6976C0EFA07B0BC8DDE168CBC8D83F5B798A6DCF507B0CB1B7BB09117CE376C::registerpayloadvfx();
  level thread scripts\cp\cp_relics::_id_12B99();
  level thread _encstr_B44A492B9FC804A35D03864A8B182FFE3027FF8311F94EE3893B4B92F1056EB698F33B1A4BB0978FA071C2DAD9E5AFAB48CFA3809F581A0F566B4AA261A8FFE6E8335B0C6B48673A746362::_id_12B0E();
  level thread _encstr_99A330CDB1E4B4E047DC976C3879B58538CDBCC6C1FA23BD9BCAD1E65BCB36E0D791DE73CA1D37B57D4BE6A32B63B8ECB98D::init_intel_pieces();
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level thread heli_crash_path_loc_setup();
  init_global_systems();
  level thread spawn_technicals_for_players();
  visionsetnaked("_encstr_99640BBF88E674E2C5AD3BF282");
  _encstr_AB5F3EA3FA037340A3CBEF6FD05DE0CFB353B029335FBF68BDA30769ED363085D30EB1B369FF6E58D2B70953115D30D6BFA26899327FA7106C6E217776C77816::_id_131ED();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_87B80821127338B81BE6", _encstr_AB5F3EA3FA037340A3CBEF6FD05DE0CFB353B029335FBF68BDA30769ED363085D30EB1B369FF6E58D2B70953115D30D6BFA26899327FA7106C6E217776C77816::c4_obj_and_progress);
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_A9CA0DDB6A4D88A0C312915919234F", _encstr_AB5F3EA3FA037340A3CBEF6FD05DE0CFB353B029335FBF68BDA30769ED363085D30EB1B369FF6E58D2B70953115D30D6BFA26899327FA7106C6E217776C77816::camera_loadout_showcase_preview_large_sticker_alt2);
  var_0 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level._id_12B19[var_0]]]();
  } else {
    var_1 = getDvar("_encstr_A53D19F2CB684F52B83FBF8C3BF01D8726C60B0B71565341D005B2", "_encstr_822A19B6718BB9C9C573B018C91EB5F0A71C3527C42F835FADEA88");

    if(var_1 == "_encstr_B40101")
      var_1 = "_encstr_822A19B6718BB9C9C573B018C91EB5F0A71C3527C42F835FADEA88";

    setDvar("_encstr_A53D19F2CB684F52B83FBF8C3BF01D8726C60B0B71565341D005B2", var_1);

    if(isDefined(var_1))
      level thread rundebugstartobjective(var_1);
  }

  thread increase_hp_from_relic_mythic();
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level thread _id_13528();
  level thread _id_11E0A();
}

init_global_systems() {
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_AB560E05670AE9D86FEB60D0DF619117", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\mkilo23_ai_infil::main("_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_83FF0EA067A1481F49AA9B1B42024F13", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1");
  scripts\vehicle\empty_turret::main("_encstr_96CE0F8D83AF1DABC9C9563AF5C4DB2397", "_encstr_8C2A0D6F68EF6DE92E0B681D764723", "_encstr_AC291C7FFB0AD8B75B71B3D9EAC7E628676FEBCB70F3106863CBCB2302EB");
  scripts\cp\cp_remote_tank::main("_encstr_BE60197393DBEB2F50DA9D27AD609F87204017E5D573216D879BA3", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AAE42838923A7BA363E78475B87F8929A7F970A8C996BFF83BCD07F7B7DF10F30FB208C83221D311AFFC");
  scripts\cp\cp_remote_tank::main("_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AA6E28FF6F7308C395309EDDD0630AC369B1DAFB9E67226A2DC5B91B991F58F197A303A748F143131704");
  scripts\vehicle\decho::main("_encstr_8F741BC3F11860A1FE9B9B47E9105A4F20593ECC2849D2DA46ABFB4F7D", "_encstr_AB560E05670AE9D86FEB60D0DF619117", "_encstr_B1B31F57D332E09F73695B2102DFDE630F17EBC720D1D06D4732706E1BF383B8A7");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  setup_create_script();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_8D06078C95858DAC27");
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
}

levelobjectives_init() {
  level.objectives_table = "_encstr_B1282106C806D12111DA40B0D33931A9974C9D060FDF395DC78268A89B4FD788E7FB9C";
  level.objectivesmatrixtable = "_encstr_977A286B1B75469B9FAF90085BFEB37D272A58C3E118A52AED5193216848C879719F8B2B89B18E2E7BA5";
  level.objectiveregistration = ::levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
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

_id_11E0A() {
  wait 10;
  var_0 = (-18200, 1423, -100);
  level scripts\cp\cp_munitions::_id_12BE1(var_0, 50);
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
  level thread _encstr_B29746D8CF3210D973F2B0AE0AFEDBD99817B2A06BC708B3CB9D14A562161340E2F73018DFAF206D22078635BCDB5B805BCB21C0C73A3939FAAA90B0563293719407D0085AC733DF::registermoralesobjectives();
  level thread _encstr_B44A492B9FC804A35D03864A8B182FFE3027FF8311F94EE3893B4B92F1056EB698F33B1A4BB0978FA071C2DAD9E5AFAB48CFA3809F581A0F566B4AA261A8FFE6E8335B0C6B48673A746362::registerobjectives();
  level thread _encstr_A9D12FB9364EA5E0E8DC971B075EAD1683E6976C0EFA07B0BC8DDE168CBC8D83F5B798A6DCF507B0CB1B7BB09117CE376C::registerpayloadobjective();
  level thread _encstr_AA4B3F734EB35FEA197016EA5097E537AB2EA71B5FBED3F5C528ABE3E0FF5EABA61D7F9E7D2347BCFF80E2AA88A995F79B75C7090EA81F87A3383A92180DCF17F1::registersafehouse();
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
  register_create_script_arrays("_encstr_B4A9235E8B79E48A40BBBBAF8FE0524A4073D9E741D0A4E2A637D3CF99933A9F503BCFEA3B", "_encstr_B4A9235E8B79E48A40BBBBAF8FE0524A4073D9E741D0A4E2A637D3CF99933A9F503BCFEA3B", level.scripted_spawner_func.size, _encstr_8DFF4627F0A399F31146CDD62F7FFA594BC8DEFF837EC99B0B5E290F9D8BA2E5D3C2573BE1B10F6263F52AC4E8B3BBA59BD9C317B8687D6B3F83B73DEB5F2260C3A003C73A61A322::main);
  register_create_script_arrays("_encstr_8B481C6C38F58CF69B56D1CDB6FA6756A1F5B3C9EDD5DC91F5072C471AB9", "_encstr_8B481C6C38F58CF69B56D1CDB6FA6756A1F5B3C9EDD5DC91F5072C471AB9", level.scripted_spawner_func.size, _encstr_A5793B9FF75BCB83FC5270F1BA9FD077D32FAFC7D3D105300E2F03CB64F7E837D9DBB7553F8B564867C329A00167B8E0D30B29AF83629D9863CD91DB36::main);
  register_create_script_arrays("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", "_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", level.scripted_spawner_func.size, _encstr_A20A380EDB739021DBFBAAC0E3252329D353B88E201FF95705E268784ADDF74317EC10F08DDB4387A1AB40E063A5D79B4782AD78F47F20D792B2::main);
  register_create_script_arrays("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", "_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", level.scripted_spawner_func.size, _encstr_92A233BBE21B7B48DBB3E777D855F837BB5BB8213B57257875BD294FFBBD40075F420808F253E660C19915491D55D946077E81533A::main);
  register_create_script_arrays("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46", "_encstr_97BF19B107FAD8859C951C2C1BB6B0D9567DD84E0B47B2E6AFD86E", level.scripted_spawner_func.size, scripts\cp\crate_drops\cp_crate_drops_cs::main);
  register_create_script_arrays("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD", "_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD", level.scripted_spawner_func.size, _encstr_8F0E3F9BC69C4B0E3A37BCD8C1CB5B1683E65E361CFAB1B02FDEEC959C796BDEE4C2B1B26EAFBD1353B28D474BB35697D807F5B5F69C0B632B6EAF36DC17EC3736::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD", (-25600, 18944, 0), (0, 270, 0));
  register_create_script_arrays("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37", "_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37", level.scripted_spawner_func.size, _encstr_B86F42D753B2601FF32BF061034659E8CABBE76FE8517866FF035329DA472090E20DA7C561069038CF6A6851E27BCBE07FD70F79376E907957430199EAFFF69045F7B7D7::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37", (0, 0, 0), (0, 0, 0));
  register_create_script_arrays("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A", "_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A", level.scripted_spawner_func.size, _encstr_A1E7368F86933850B830778FC8E565F968EEDE36A341D7195B214F1123DF9AEA41231AA2699D570D4781C277E20B9B9B3B7FB783FD3A8F7F::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A", (0, 0, 0), (0, 0, 0));
  register_create_script_arrays("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB", "_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB", level.scripted_spawner_func.size, _encstr_998D4268C26A2BF3D37B98A650969883526B12608B49792863953DA653EE016971829870725B8FE0CFAB4F1435DB483B227AA1809BB5C7D91FA1C19D1ADFB1FFDDE24808::main);
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

wait_for_strike_init_complete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD")) {
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    var_0 = getDvar("_encstr_A70910FF7B8AE9B6DB23D098BA9FE0C0E5D5");
    var_1 = undefined;

    switch (var_0) {
      case "_encstr_91CC11D3C3F9EA1AC8BE04606377DA1C3FF361":
        break;
      default:
        break;
    }
  }
}

setup_map_specific_devgui() {}

register_spawn_modules() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.ambientgroups = [];
  level.active_spawn_modules = [];

  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", 0, 24, undefined, 0.1, undefined, "_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", scripts\cp\cp_modular_spawning::init_wave_settings);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", 0, 24, undefined, 0.1, undefined, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", ::set_vehicle_settings_on_spawners);
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

set_interaction_trigger_properties(var_0, var_1, var_2) {
  if(!isDefined(var_1.script_noteworthy)) {
    return;
  }
  switch (var_1.script_noteworthy) {
    case "_encstr_83BA0D3AF7C9C7A287A86B03B0D71B":
      self.interaction_trigger setuserange(150);
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);
      break;
  }
}

_id_13530(var_0) {
  var_1 = [(-18360.7, 1475.66, -137.77), (-18410, 1542.62, -138.89), (-18325.6, 1527.95, -139.84), (-18355, 1611.21, -139.26)];
  var_2 = (0, 180, 0);

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = spawnStruct();
    scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_0, var_4);
    var_4.origin = var_1[var_3];
    var_4.angles = var_2;
  }

  level.default_player_spawns = var_0;
}

increase_hp_from_relic_mythic() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_AA5116C2AB81A7C779279D0AFFF76273A0F507D00228A4F1", 1);
}

_id_13528() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-18465.6, 1731.25, -146));
  var_0.angles = (0, 204.785, 0);
  var_0 setModel("_encstr_8F242E8005D61D01E64E880388CD4D1A62930F79C56B60DAE044CB2F66E197D84830109F79C9AA1BABB9C66F0201B762");
}