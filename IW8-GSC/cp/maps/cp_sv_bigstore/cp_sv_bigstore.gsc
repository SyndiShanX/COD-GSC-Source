/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_bigstore\cp_sv_bigstore.gsc
*****************************************************/

main() {
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  _encstr_A2803B5F88DBF19B491E656E87970281E360B697A8D62303C7BEFC676E19FA5AE91A0F63398B7ED995C3471AD5C76315764833BF40A1A372E3484F12B6::main();
  _encstr_9AEE3A0BBFE82443BDE366AAAB380F9E5007DF63F1D9EA93F0391AD2D3ED4F922B170FED75B236D39833E359994BB78A206F9275FF783A0B18A94B82::main();
  _encstr_971B356636E3722098B716C031E7519341BF5FE7A277C6EB8761E0B0880C48DB47EE3E43605B1B56A98F2F1BAB6FEBF8A7A3D8CE206728::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.4);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 2);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1000);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 6);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\cp_modular_spawning::mousetrapsfound();
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = _encstr_BE4F3F6B468BBB02F4D8D07FD1CF12C9A7937FD8409F034551B24A9F0B2B3FA5B7E057A02FB78CA9C317E756B1F04265EFBAC593F02E1F713081E8FD673E876367::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_87E84337C693A51C3AE65EC6E0F25B0BC1E6798DE07DB99DEBC4A5769B3A7B9C56CB3683BECD67FA4CA5D9CD47F627ACF5EECA2C0EF6CD9CB073B5D72BB3CA9B47B8B1DCD9";
  level.player_interaction_monitor = _encstr_BE4F3F6B468BBB02F4D8D07FD1CF12C9A7937FD8409F034551B24A9F0B2B3FA5B7E057A02FB78CA9C317E756B1F04265EFBAC593F02E1F713081E8FD673E876367::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_BE4F3F6B468BBB02F4D8D07FD1CF12C9A7937FD8409F034551B24A9F0B2B3FA5B7E057A02FB78CA9C317E756B1F04265EFBAC593F02E1F713081E8FD673E876367::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  scripts\cp\cp_gameskill::init_gameskill();
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_objectives::objectives_init();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  level thread setup_map_specific_devgui();
  setup_create_script();
  level.devgui_setup_func = ::onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 = getDvar("_encstr_9B65198B0911322B58B1927A7B2597AA68EF13044393BBC778A95A", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_8A441878F060588A46533EF8F633F755ABF017D73B87536BD71D");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
}

rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.ondebugstartfunc))
      [[var_1.ondebugstartfunc]](var_1);

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
  }
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
}

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

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

onplayerconnect(var_0) {
  level thread bug_test_move_startpoint();
}

onplayerspawned() {}

bug_test_move_startpoint() {
  if(getdvarint("_encstr_829910CF5E203138B80B9FF8309F40F9FFA4", 0)) {
    var_0 = scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_2 in var_0) {
      var_2.origin = (3743, -1008, 384);
      var_2.angles = (6, 265, 0);
    }
  }
}

should_run_event(var_0) {
  return 0;
}

setup_map_specific_devgui() {}

interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration))
        self.interaction_trigger setuseholdduration(var_1.useduration);

      break;
  }
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
  register_create_script_arrays("_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74", "_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74", level.scripted_spawner_func.size, _encstr_AF614053095ECF72D09FAFEB71E2FD3787A32EDAF3A0EFABB1A511F74F600533A5D062737E0E0329309B17EB29908AD7C0F1EBAA0165071160F71AC939B0C5177E69::main);
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