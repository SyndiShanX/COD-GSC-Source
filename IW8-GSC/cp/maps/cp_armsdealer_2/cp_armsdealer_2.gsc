/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_armsdealer_2\cp_armsdealer_2.gsc
*******************************************************/

main() {
  level.default_player_spawns = "_encstr_8A201D232B662CAB363AFADC3816DDE6EB8DE0D78593AD9BAF19560BB1CAC9";
  scripts\cp\cp_compass::setupminimap("_encstr_A31F1CEE4735F3983B2BB75B3A43D1F769E1816E931781FF1FABA3CB2F6A");
  _encstr_8EC43D5F57B61AF82013BDB66B223D520FCFA6871948C2B2C0FB673F61507DDB70A51E0F81900A8AB8C39F0719688593283D573B2D255251E0C8D7DDF178CB::main();
  _encstr_A2853CCDC6274B1C3AE6E5D8E0CB5BB0E06E971B0EF5C2C9B5DC8CB258632B4EF591BC9DCA37CB36077D85C96BB932CAB03695E4D791BE0B9C3A179DB91B::main();
  _encstr_BE2E372BE61BF752A1D8CE02A87F4D8FF356CFB387461F1AABC0027A1821870B4E9E472B1FEE672243E80A72F009FFB3A606AFA6B398B72A07::main();
  _encstr_8CF93DF05AF2A37BABF3103EE81EAD7BDAE39AE803C1EB73E71B4D25D17B49E5C91F22609B69234B9F23452DA943B1ADA1872960A2BF4943A756DCB087D739::main();
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
  level.map_interaction_func = _encstr_ACF541A7769A0B80E377C6211FE61852686668469B27DF08AFE2E0B92FA0F73A0966E7D31A8FF99B053B79322959D7FD0F12B19BCA53200B6F882998B58D635ED14653::register_interactions;
  level.player_interaction_monitor = _encstr_ACF541A7769A0B80E377C6211FE61852686668469B27DF08AFE2E0B92FA0F73A0966E7D31A8FF99B053B79322959D7FD0F12B19BCA53200B6F882998B58D635ED14653::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_ACF541A7769A0B80E377C6211FE61852686668469B27DF08AFE2E0B92FA0F73A0966E7D31A8FF99B053B79322959D7FD0F12B19BCA53200B6F882998B58D635ED14653::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_AB21458F8706AA489043EDC61B726DE2DF3F763749389202302B374FD180AD8B2015EEBFF140DADAE8332F57C9D8F543986DA777B3F7138FD83B669DA0693D7B6D7DB39A27263B";
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
    var_1 = getDvar("_encstr_A2B41A6C0EFA859CD69B912BB0D82B397D8CFAE63A16E41DFADB9853", "_encstr_83821C0AF9E0B54A702B7727172FB3E5E0E10716B02B6AF1D613137F7540");

    if(var_1 == "_encstr_B40101")
      var_1 = "_encstr_83821C0AF9E0B54A702B7727172FB3E5E0E10716B02B6AF1D613137F7540";

    setDvar("_encstr_A2B41A6C0EFA859CD69B912BB0D82B397D8CFAE63A16E41DFADB9853", var_1);

    if(isDefined(var_1))
      level thread rundebugstartobjective(var_1);
  }

  thread increase_hp_from_relic_mythic();
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
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
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_91EE088C2B16632B4EC8");
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
}

levelobjectives_init() {
  level.objectives_table = "_encstr_9B222236C75E5682BE9F65382F8C6529E5F5CBEF6A366266ADB397D4FC93C59B9E9E5F46";
  level.objectivesmatrixtable = "_encstr_8D9729AE4276A0198F7ED363C76408AA893932E15241ED0E3577664053D3DDD811900B33D5A89A685E8F83";
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
  level thread _encstr_8F8B3C8706030AD2DCC7AFC39B9D0DF953AB9E8F30479947EE107B672035A3089F1E2517FBA19A500BEA35F92A2F403C738235AF846FAD436E92B5D827C6::main();
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
  register_create_script_arrays("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E", "_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E", level.scripted_spawner_func.size, _encstr_91F83FB98DC94B38479BBC1B0E795BB0076E97360EAF23DECDCAE8DCD679E08D5837957D0D2DA6B01BDABCC6C1BE1C1B0BB9CAEB0D5A4D0B1B6DD7B1B971EC378D::main);
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
      self.interaction_trigger setusefov(360);
      self.interaction_trigger setuserange(300);
      self.interaction_trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
      self.interaction_trigger sethintdisplayrange(300);
      self.interaction_trigger sethintdisplayfov(90);
      self.interaction_trigger sethintonobstruction("_encstr_BD1805CB69C063");
      self.interaction_trigger sethintrequiresholding(0);
      break;
  }
}

increase_hp_from_relic_mythic() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_AA5116C2AB81A7C779279D0AFFF76273A0F507D00228A4F1", 1);
}