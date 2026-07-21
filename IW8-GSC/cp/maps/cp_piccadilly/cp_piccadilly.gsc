/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_piccadilly\cp_piccadilly.gsc
***************************************************/

main() {
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  _encstr_8B9A39DC369C5A1C1DE6F26C83E5D6B038DCBC8D83F583A5B1D8588C5A8DD8E5CB36837D8396D8C6B0239636C6F2BEC1E4561B858DA159E2D99B1B::main();
  _encstr_B83238F8FB631AA3A5A2A7AA88A0720F58830D9F417138EB1EB60229BA65485088F19F986EF133290BC8BF38A73190B011E0910F1013485FC732::main();
  _encstr_B84A33676F9E32D038FB455E730A054A77A78EAFF150EBB1D8C1CE6748285C83601F7BE799E30273E049C46DC0E8A7AAA32DDFDF27::main();
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
  level.map_interaction_func = _encstr_A38C3DA32118490343E3961B7957E3AF7756859F73A953A92B9F0E37508022999FBF80D90BE0F372833B53984AB8A0A0F0DB5F4ED08FD994D07DFE1DD7A3B9::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_8D6F41F8DB265B0A0BCB77BF3BE0075F58CB95688A1F2F598BB8304C5069E2EBBAEE67F7F78951811F1A9415A3B730AFC737128FDAE6A9621841188BA53DD31D631A8C";
  level.player_interaction_monitor = _encstr_A38C3DA32118490343E3961B7957E3AF7756859F73A953A92B9F0E37508022999FBF80D90BE0F372833B53984AB8A0A0F0DB5F4ED08FD994D07DFE1DD7A3B9::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_A38C3DA32118490343E3961B7957E3AF7756859F73A953A92B9F0E37508022999FBF80D90BE0F372833B53984AB8A0A0F0DB5F4ED08FD994D07DFE1DD7A3B9::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  scripts\cp\cp_gameskill::init_gameskill();
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  thread play_movie("_encstr_BEB20F37836EF81A5738427E967392BEB3");
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

  var_0 = getDvar("_encstr_A1FB183B68DF035328E751BC6A59780BA723FB52BAD311EDB218", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_95011AC6DED6E00B6E9BAFB50BE0AFDAE0EB0E4BD86C16325A6336BC");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level thread _id_121F5();
  level thread _id_12F82();
  level thread _id_121F0();
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

play_movie(var_0) {
  if(getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF") == 1) {
    return;
  }
  for(;;) {
    playcinematicforalllooping(var_0);
    wait 3;
  }
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

    stunboltdelete();
  }
}

stunboltdelete() {
  var_0 = getEntArray("_encstr_A569148FF57E1B196C3F5039AD8BC080153F53357993", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    level thread scripts\cp\cp_outofbounds::basic_combat(var_0[var_1]);
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
  register_create_script_arrays("_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3", "_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3", level.scripted_spawner_func.size, _encstr_A7E93E1878601FF3B5FA462F5F886B59CFCF50B88F49AF3CB3D8B662E8B8F97356FE4361C31F99B6196A4BF48A916036A338E95179912B17EA74BBCBC08FFE0E::main);
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

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = [(1953, -996, 87)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}

_id_12F82() {
  while(!istrue(level.doorsetupfinished))
    waitframe();

  wait 2.0;

  foreach(var_1 in level.doors) {
    var_1 notify("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
    var_2 = 0;
    var_3 = 90;

    if(distancesquared(var_1.origin, (214, 745, 132)) < 12)
      var_3 = -110;
    else if(distancesquared(var_1.origin, (854, 1254, 140)) < 12)
      var_3 = 110;
    else if(distancesquared(var_1.origin, (795, 1339, 140)) < 12)
      var_2 = 1;
    else if(distancesquared(var_1.origin, (-116, 1025, 128)) < 12)
      var_3 = 105;

    var_1.angles = (var_1.angles[0], var_1.angles[1] + var_3, var_1.angles[2]);
    var_1.useprompt makeunusable();

    if(isDefined(var_1.lockprompt))
      var_1.lockprompt makeunusable();

    if(var_2) {
      var_1.clipent delete();
      var_1 delete();
    }
  }
}

_id_121F0() {
  var_0 = getEntArray("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3246.5, -3351, 56));
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3118.5, -3351, 56));
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2854.5, -3351, 56));
  var_1 clonebrushmodeltoscriptmodel(var_0[0]);
  var_1.angles = (360, 0, 90);
  var_2 clonebrushmodeltoscriptmodel(var_0[0]);
  var_2.angles = (360, 0, 90);
  var_3 clonebrushmodeltoscriptmodel(var_0[0]);
  var_3.angles = (360, 0, 90);
}