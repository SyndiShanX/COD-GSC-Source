/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_crash\cp_sv_crash.gsc
***********************************************/

main() {
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_A28735CDC6274B1C3AE6E5D8E0CB5BB0E06E971B0EF5E6D97DD84EB0DC43796C07FACDD9BEB19C1637A17DC193B2B1C2B134955CD99BC6::main();
  _encstr_AF4E346E1B272DE0E8CD793607F2B6160ECD79D81CFA37CE7D8D390B9B1AF2D9ACDC791B07AFB9CE7D36932CCDA1BE85E48EB8B33736::main();
  _encstr_A1652FA723A2700FE31BC07113B649F8FAAB977FD841185427726339CB4350B0922FB7DD4F3658174FDADEC163023CF8EE::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.33);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 2);
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1000);
  setDvar("_encstr_846619C2B76BE35FC67FE9F90BD89B0797F07225731F6381C9E8DF", 1);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 6);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
  setDvar("_encstr_82940932CFC1F428B10FC7", 1);
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 3);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 0.5);
  setDvar("_encstr_843D0BF7516E708C19BFBAF5D7", 0.5);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 512);
  setDvar("_encstr_83920A488F414D730D6721C8", 3.5);

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\cp_modular_spawning::mousetrapsfound();
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = _encstr_9A30399BAA0273AB7BC3200EB86E702BEA336A383391BFA3FFFB9677935BF0F7529910183936F51997E8087B96F3E19DFEE2A078920D2F38AF1B2E::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_BDF03D4B1146279A2877B7C349CAE54FEF8B06321B88F7D399BFE2C927983D9F17A65BEB467E3B4EA0B1D7C7130832E7B0FBF2F228D83F433895F49637B0FB";
  level.player_interaction_monitor = _encstr_9A30399BAA0273AB7BC3200EB86E702BEA336A383391BFA3FFFB9677935BF0F7529910183936F51997E8087B96F3E19DFEE2A078920D2F38AF1B2E::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_9A30399BAA0273AB7BC3200EB86E702BEA336A383391BFA3FFFB9677935BF0F7529910183936F51997E8087B96F3E19DFEE2A078920D2F38AF1B2E::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  scripts\cp\cp_gameskill::init_gameskill();
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread _id_13664();
  level thread player_fired_gun_monitor();
  level thread _id_121F5();
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

  var_0 = getDvar("_encstr_B4B1163607BE6ED9BEC6E4586ED0F56E470BC9E8FAED89A6", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_B23216932F98EA7F466BF9C2311F4F65C8E70B0A4B9BB40A");
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
  register_create_script_arrays("_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8", "_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8", level.scripted_spawner_func.size, _encstr_A6CE3ADB03F23803B3C8571809C6D999CB86C0DAFF39B00B3717939B4A997FF2F3D9C7786998AE122ED8A72E63B540187B775BAE0B093341CD511087::main);
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

_id_13664() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-340, 655, 240), 0, 192, 100);
  var_0 thread _id_144FF("_encstr_8BBB069F5C8399CB");
}

_id_144FF(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!isDefined(self._id_126CE))
      self._id_126CE = [];

    if(scripts\engine\utility::array_contains(self._id_126CE, var_1.guid)) {
      continue;
    }
    self._id_126CE = scripts\engine\utility::array_add(self._id_126CE, var_1.guid);

    switch (var_0) {
      case "_encstr_8BBB069F5C8399CB":
        var_1 thread _id_14486(self);
        break;
    }
  }
}

_id_14486(var_0) {}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-912, 2072, 520));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = [(-912, 2072, 530)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}