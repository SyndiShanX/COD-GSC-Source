/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn_2\cp_dwn_twn_2.gsc
*************************************************/

main() {
  scripts\cp\cp_compass::setupminimap("_encstr_8C0219C67BDA3885E6B97DB6B0E0FAD81CEBC8BBB9BE3A7773AF8C");
  _encstr_91273768C26A2BF3D37B98A650969883526B12608B49792B63AF3DA4562F2BD77EC3192053DDD7036FB6503E0FBBEB1B263A40C8EA65EF3B07::main();
  _encstr_BA723608B7FEB8B833877228B9E6B557BB5A77919F071F7B0847B3E7F0F9BA06800FD5403FC9D62918A0D101C8C02F6DB0867D5BE847BE5B::main();
  _encstr_A1E7318F86933850B830778FC8E565F968EEDE36A341DDDB75B823070BAF8F3DA023F9015FDD480577CDF72A218FB9903FCFB7::main();
  _encstr_AC2F37B9C6C9B438E837BCB10EBCB6B0E0DCCB6C0EFAC8DD37FAE8DDDCEB46BCC61CFA32DDDC7DA377E6F591D7C62DEC86E84BCD9DC5EC6E1B::main();
  level.default_player_spawns = "_encstr_9BD00F2356CCB0D5C6E8BEB98358DDCDFA" + level.script;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
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
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_ADEA213F304705B88538E4339C9F505153FD552116B533E984830902E2B072D3B7AEB3");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_97021787E9A8426F8859F33AB029A0EA9973033F9F68B95BB8");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_8A1D239A2817BF7F5038E4FF489EE7858DF0C2B388BF32578B1BE8F4C823F34E17A8EABBE0");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_9B85276C1CD7C8779BD78EBBB9F567AC0D5AB1632BEB38C28EA1DCEB1B9C2B2C8E95D79B8D93A51CA3");
  scripts\cp\utility::coop_mode_enable();
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\mkilo23_ai_infil::main("_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_83FF0EA067A1481F49AA9B1B42024F13", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1");
  scripts\vehicle\empty_turret::main("_encstr_96CE0F8D83AF1DABC9C9563AF5C4DB2397", "_encstr_8C2A0D6F68EF6DE92E0B681D764723", "_encstr_AC291C7FFB0AD8B75B71B3D9EAC7E628676FEBCB70F3106863CBCB2302EB");
  scripts\cp\cp_remote_tank::main("_encstr_BE60197393DBEB2F50DA9D27AD609F87204017E5D573216D879BA3", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AAE42838923A7BA363E78475B87F8929A7F970A8C996BFF83BCD07F7B7DF10F30FB208C83221D311AFFC");
  scripts\cp\cp_remote_tank::main("_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AA6E28FF6F7308C395309EDDD0630AC369B1DAFB9E67226A2DC5B91B991F58F197A303A748F143131704");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  level.incorrectcodeentered = 1.5;
  level.disable_start_spawn_on_navmesh = 1;
  level.map_interaction_func = _encstr_AB933BF6A91A7BB7236095E3ABB0D0C8788A40A2A12E51DF2E969B874AD6BE0FC6F0D154C0E5112B632D561AA9518E8323ABD757FD8B0FE37206ECE0B0::register_interactions;
  level.player_interaction_monitor = _encstr_AB933BF6A91A7BB7236095E3ABB0D0C8788A40A2A12E51DF2E969B874AD6BE0FC6F0D154C0E5112B632D561AA9518E8323ABD757FD8B0FE37206ECE0B0::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_AB933BF6A91A7BB7236095E3ABB0D0C8788A40A2A12E51DF2E969B874AD6BE0FC6F0D154C0E5112B632D561AA9518E8323ABD757FD8B0FE37206ECE0B0::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_82DA3FC6CB18BB5744AE478F87C6906897C7A82F2881816B6550357F92FE1A5DC1B9267FC088695DF388FFE2D9D80D3351C7F5C207F844E16A46E93A6B6D3B838B";
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
  level thread setup_create_script();

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  level thread scripts\cp\cp_objectives::objectives_init();
  level thread setup_global_event_objectives();
  level thread _encstr_A7723BA77023197391C64D56AFFF7AD9CB485E7F80FE4C4B8DC8634B989712625010D7ABD073853377FE6A49FC334B24FB5957CFA849ED0AE920B77A6E::main();
  level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::main();
  level thread _encstr_868D30B8AF5230F953D2904EEA1E3BF9B877D2804B27E9BFDAF1354C45366F832FC388608FA4435591652140DABF2DA96B67::main();
  level thread _encstr_A3B73B02B148B1D3F52F7E3751304AF1831BAD8E4BC9447BC05F1B6F45E8922A78A136D380380D73883F13D749ECCA5F704BED91B880EF7BDE4D476FAF::main();
  level thread _encstr_A2183F376C4E4B83E8E6F2B183E5DA2CE06EE56C1CEB91BBE6D7A3DD9BE5BD31D4ACD8E82DD92B6ECB6CC1FA8CEEB9EBE8DDB9FA37B0CCB286DE576ECAB8B3CD1B::main();
  level thread _encstr_9675354F98CBE18B792E557E97E712B1D370468798C62423B5D08B73F0BFCA68DE70AF2B495B8FFAFFD0162C6DCF7309439027A27013D3::levelregisterobjectives();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread _encstr_BEDC36FA96CDBA40BBA0FEC7D0B8056261365576876FA297C008EB9F3060C3BB67C5CDADE591ABAB0E18BB271001BBF2DDED12E0F8EF63EB::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
  scripts\cp\cp_gameskill::init_gameskill();
  level thread heli_crash_path_loc_setup();
  level thread spawn_technicals_for_players();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  _encstr_822F3AB673DB38F9031352283B8D8B71AB0B1026D8C7410F6DF98080B2B9ED404F90502D37DB6E411312E1D2994E114197234F10B1B3B3972DAA8850::_id_131ED();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_B47A06BDB537ABF6", _encstr_822F3AB673DB38F9031352283B8D8B71AB0B1026D8C7410F6DF98080B2B9ED404F90502D37DB6E411312E1D2994E114197234F10B1B3B3972DAA8850::_id_11C58);
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_957A062DA3C7A23F", _encstr_822F3AB673DB38F9031352283B8D8B71AB0B1026D8C7410F6DF98080B2B9ED404F90502D37DB6E411312E1D2994E114197234F10B1B3B3972DAA8850::_id_11C5B);
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_A27A069DF177CBE3", _encstr_822F3AB673DB38F9031352283B8D8B71AB0B1026D8C7410F6DF98080B2B9ED404F90502D37DB6E411312E1D2994E114197234F10B1B3B3972DAA8850::_id_11C5C);
  var_0 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level._id_12B19[var_0]]]();
  } else {
    var_1 = getDvar("_encstr_833C171E3A775FEC20213124CB0F6FA07B94B69BC3E717826B", "_encstr_87B50A6356763823EAF7CFFB");

    if(var_1 == "_encstr_B40101") {
      if(getdvarint("_encstr_A53311F3D8256937BBAFC5C1AF66432E8DF86F") >= 1)
        var_1 = "_encstr_847712E61666CAD0B75DB995FAD9D5376E34F61C";
      else
        var_1 = "_encstr_87B50A6356763823EAF7CFFB";
    }

    setDvar("_encstr_833C171E3A775FEC20213124CB0F6FA07B94B69BC3E717826B", var_1);

    if(isDefined(var_1))
      level thread rundebugstartobjective(var_1);
  }

  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread increase_sequence_tier();
}

increase_sequence_tier() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_93FA1A1B1C7DEDC1EB5BB7CDB2F2BE8D2CBAE68CB24E56C9E2163636", 1);
}

levelobjectives_init() {
  level.objectives_table = "_encstr_B2E91F30EB0749C1E90FB43029B307108F0A49D81BEAC19F03742C4D3A2E77FB0E";
  level.objectivesmatrixtable = "_encstr_86C024AE9A02EA0FC75A5F98D3155FC3DE4836A2D773E973A03D532159FF988591085AF3F3F8";
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
  _encstr_93F537FE2B8360B14B6B1A7073B553B963C3287E908F89C7B512F8E83A6D07D3877C80601D4BD337D1DA402851D433A8F7E418647EFA994F06::register_helidown_objective();
  level thread register_attack_heli_objective();

  if(isDefined(level.vault_assault_objective_func))
    [[level.vault_assault_objective_func]]();

  if(isDefined(level.mlp1_obj_func))
    [[level.mlp1_obj_func]]();

  if(isDefined(level.mlp3_obj_func))
    [[level.mlp3_obj_func]]();

  if(isDefined(level.rooftop_obj_func))
    [[level.rooftop_obj_func]]();

  if(isDefined(level.mlp2_obj_func))
    [[level.mlp2_obj_func]]();

  if(isDefined(level.safehouse_obj_func))
    [[level.safehouse_obj_func]]();

  if(isDefined(level.obj_bb_recovery))
    [[level.obj_bb_recovery]]();
}

register_attack_heli_objective() {
  scripts\cp\cp_objectives::registerobjective("_encstr_A57811BBAB3BCF98E3599831BDD941FD822F19", undefined, ::emptyfunc, undefined, undefined, ::debug_attack_heli_test_start);
}

debug_attack_heli_test_start(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E");
}

emptyfunc(var_0) {
  level thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A57811BBAB3BCF98E3599831BDD941FD822F19");
  level waittill("_encstr_ABA008615A631510C7EA");
}

setup_global_event_objectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_objectives_events::init();
  scripts\cp\cp_objectives_events::register_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB", _encstr_93F537FE2B8360B14B6B1A7073B553B963C3287E908F89C7B512F8E83A6D07D3877C80601D4BD337D1DA402851D433A8F7E418647EFA994F06::objective_heli_down_start, undefined, _encstr_93F537FE2B8360B14B6B1A7073B553B963C3287E908F89C7B512F8E83A6D07D3877C80601D4BD337D1DA402851D433A8F7E418647EFA994F06::heli_down_init);
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
  register_create_script_arrays("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8", "_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8", level.scripted_spawner_func.size, _encstr_834838DC6CE44BE0A3DC971B1CE5DA161CCD79D838AF46EE9BEB3ADDE679B11CEB46DD37BED1DDDCF58D27B20BE8ACBE6ED8E4B41CD18B76CD36::main);
  register_create_script_arrays("_encstr_ADEA213F304705B88538E4339C9F505153FD552116B533E984830902E2B072D3B7AEB3", "_encstr_ADEA213F304705B88538E4339C9F505153FD552116B533E984830902E2B072D3B7AEB3", level.scripted_spawner_func.size, _encstr_AF2342BB768B67A251285E9218CFDDFF63E67F2317F69B2B3D31F3EBF0D7C28E79CF87DC20B8C733EFB8495260AB8D7B11B6054250C00F7DE3E0328BF0D3426FA0949BCB::main);
  register_create_script_arrays("_encstr_8B481C6C38F58CF69B56D1CDB6FA6756A1F5B3C9EDD5DC91F5072C471AB9", "_encstr_8B481C6C38F58CF69B56D1CDB6FA6756A1F5B3C9EDD5DC91F5072C471AB9", level.scripted_spawner_func.size, _encstr_A5793B9FF75BCB83FC5270F1BA9FD077D32FAFC7D3D105300E2F03CB64F7E837D9DBB7553F8B564867C329A00167B8E0D30B29AF83629D9863CD91DB36::main);
  register_create_script_arrays("_encstr_97021787E9A8426F8859F33AB029A0EA9973033F9F68B95BB8", "_encstr_97021787E9A8426F8859F33AB029A0EA9973033F9F68B95BB8", level.scripted_spawner_func.size, _encstr_B21836E6C69C2D381D37F2D883CBD6851CB9F2D8E0BEC8BDE62B1DDC5BE56C1CF5C8BDB92BA3CD5BEBA1B2D84B8CDBBB37FAB19BE2766E8D::main);
  register_create_script_arrays("_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B", "_encstr_8BE115FF4BCEC10F98E569B3635942CB079778EF0D3BC5", level.scripted_spawner_func.size, _encstr_A5A440DA378A8B97A37B5A32E33653A708DAFFF0714E2078666A8B7FFFD26730AFA7CFF2ADFB7F8FF677EAA04D6340B3B3BF9F62607BAAB02FD3B0B73EEB284958E3::main);
  register_create_script_arrays("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", "_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", level.scripted_spawner_func.size, _encstr_A20A380EDB739021DBFBAAC0E3252329D353B88E201FF95705E268784ADDF74317EC10F08DDB4387A1AB40E063A5D79B4782AD78F47F20D792B2::main);
  register_create_script_arrays("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", "_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", level.scripted_spawner_func.size, _encstr_92A233BBE21B7B48DBB3E777D855F837BB5BB8213B57257875BD294FFBBD40075F420808F253E660C19915491D55D946077E81533A::main);
  register_create_script_arrays("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46", "_encstr_97BF19B107FAD8859C951C2C1BB6B0D9567DD84E0B47B2E6AFD86E", level.scripted_spawner_func.size, scripts\cp\crate_drops\cp_crate_drops_cs::main);
  register_create_script_arrays("_encstr_88241F99F0F7282C631E75574D8F400A99B38F07E293DA47403F8192F6F2BCD054", "_encstr_88241F99F0F7282C631E75574D8F400A99B38F07E293DA47403F8192F6F2BCD054", level.scripted_spawner_func.size, _encstr_B6803E9BC19617AA1827E7B3399AB57F3F7BD6024BF8FBA3E017B4AF2D72FE83F0F1EB5A36C5FFDD914BD4BFE9BA89078E490203D90817D6D0ABC09C7D604A5F::main);
  register_create_script_arrays("_encstr_9B85276C1CD7C8779BD78EBBB9F567AC0D5AB1632BEB38C28EA1DCEB1B9C2B2C8E95D79B8D93A51CA3", "_encstr_9B85276C1CD7C8779BD78EBBB9F567AC0D5AB1632BEB38C28EA1DCEB1B9C2B2C8E95D79B8D93A51CA3", level.scripted_spawner_func.size, _encstr_BE7A46F241B8412325FFAE87E1603A8150AB7D7E9B79142B708FCBDF355882E881D1E3851678CF72C0A5B75B0316BA35D9FB9E8B68A85FFAAEABAF2373D0736B58A0521308B03B32::main);
  register_create_script_arrays("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D", "_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D", level.scripted_spawner_func.size, _encstr_BDFD3386E61BEB3B44E75A1BD3275033E30A5006BA614983363F88A843CF49476AB9759495191328F092C9906FCAA081738D641EAE::main);
  register_create_script_arrays("_encstr_8FD81F4848F1AF7F2328D04B2A083FAC1F596E315E4DAF9E8C886ED7FEB00B6F60", "_encstr_8FD81F4848F1AF7F2328D04B2A083FAC1F596E315E4DAF9E8C886ED7FEB00B6F60", level.scripted_spawner_func.size, _encstr_875C3E1B42BBDBE87B13079738F55897DB3B1881DBB78518152789A75EDDE0E7BFE26BA8B1F344A861FDB1FF68223926A36A2153FA07FE0842C191D12E1F10FE::main);
  register_create_script_arrays("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883", "_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883", level.scripted_spawner_func.size, _encstr_B2B0450E5120C4E87D92A03BAA87C5D140A7C70E8B5055C048894403208A68B789B0B7809E7BF3652916AE5AF06E13ED4C58B6E4E1DFBF354706753D0E27B03E4277B32E0A9E1F::main);
  register_create_script_arrays("_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1", "_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1", level.scripted_spawner_func.size, _encstr_BAFD38CDB1935A1CA39B971B83F2D6C21C3797D81CD78CB737AC1D37ADCB5B580ED78CF6BBDCE8DBEE73BEE02CE84EF6B1EB1C2CA3865CD9CD6C::main);
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