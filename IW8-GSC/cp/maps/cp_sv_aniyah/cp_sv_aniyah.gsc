/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_aniyah\cp_sv_aniyah.gsc
*************************************************/

main() {
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  _encstr_AA1A3737364E4B0EE837F2D81C79DA0B0EB9CBC683F5E6ECAF85CDD2CB161AE5B11CFADC67BEC29B962F580D7D07C9ACC62CB1A1AC8B3BCD8D::main();
  _encstr_921F36B98D9CA51CE86EF28D3879AD0B079BE5D8C1D79BD9AF0BDC4BCB0B1AF2D92BB997B183FADCB3F5B0CD2D5E16A1F5C2E4478BD937B1::main();
  _encstr_A2ED31283FC28049E342973E9A8EAB4928874230DB579B0D39EEA8333042E9F8632339385B3F11C56290174B814AF110CFB750::main();
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 1.25);
  setDvar("_encstr_83920A488F414D730D6721C8", 4);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 2048);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 8);

  if(level.createfx_enabled) {
    return;
  }
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = _encstr_85853B93CA334370F39BBF1FA00DD01F63A36019632F8698C1613503C1C6C0F0C72BE683ABD7371064613319FF2C382567E3B90973A778E8BA1E3727EB::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_BD1D3FCB7F28E403FDA326EAEB784F5E90C71F23B199AA5330992A72D2A793857069F7BB05F176EBC3B2D26AFE84FFCE402F4E2243C03C67FD4BEA12A3702F02A8";
  level.player_interaction_monitor = _encstr_85853B93CA334370F39BBF1FA00DD01F63A36019632F8698C1613503C1C6C0F0C72BE683ABD7371064613319FF2C382567E3B90973A778E8BA1E3727EB::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_85853B93CA334370F39BBF1FA00DD01F63A36019632F8698C1613503C1C6C0F0C72BE683ABD7371064613319FF2C382567E3B90973A778E8BA1E3727EB::level_specific_wait_for_interaction_triggered;
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

  var_0 = getDvar("_encstr_97DE176C83D7E6B3D72CDC96F216A17DB9D185938EEBBD3135", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_BE6016278759CFD7A07B51EFEE9051B518A619E8D927D060");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread player_fired_gun_monitor();
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
  register_create_script_arrays("_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3", "_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3", level.scripted_spawner_func.size, _encstr_8E013C976EF270B3CDC3AA3F03671A311838A8F7C130B76C7F393E9BB16E8B16FEBB099F3B495ACD820371537936B5E7B753DD374FB36B0BD1604ACC4B96::main);
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

player_fired_gun_monitor() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_0 setModel("_encstr_A2B91C8EED7BB1D736837D9B3BBE0B37A55E0BD0AF36DE1B635ADC4BBD73");
  var_0.angles = (0, 0, 0);
}