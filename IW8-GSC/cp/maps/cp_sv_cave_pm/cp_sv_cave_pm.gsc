/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_cave_pm\cp_sv_cave_pm.gsc
***************************************************/

main() {
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  _encstr_8C2E393718EEE3E04BEBBA3F776EAD59F0B78020D31753BCD880C8E380F1A952B61EABBFA8F5672836F3AFB9E3A3FE08AB6D9207CF12E79EA4779E::main();
  _encstr_9BA238F8EF1270B91392D08E2ADEFB39783792C00BE7CB7D89BEFF0C47F109609F0F58208E73E37793E3F89E5EBB7B6E289F01C0531CF0CFFB4E::main();
  _encstr_A77233A77023197391C64D56AFFF7AD9CB485E7F80FE5B5BEFD6260B1D77E36DF8209B079B73BF32EB742F49FF2BE92E7AD24FCF28::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\cp\utility\player::overridevisionsetnightforlevel("_encstr_978E11CA98E7F1AB31AE755749FB97061370E2");
  level.disable_nvg = undefined;
  scripts\cp\survival\survival_loadout::initnightvisionheadoverrides();
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 500);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 1024);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 45);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 2);
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 5);
  setDvar("_encstr_A7F10BDB5966F39BFA13DB52CD", 2);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  thread destructibletrucksetup("_encstr_959C14E3BBD62B1AC8314B14095855612EE37747B95F", "_encstr_A6FA12E3FA0BA2773C3F71155870C4F23D902F0E", "_encstr_86781A65B5AE057EBBA0430C7EBA6173824D314FDACB20F7321F5A2B", "_encstr_8D301E8C2BB9D127EA6C3AB4318D2B514E5D8DB606267D5691B356E6F591B91D", 51);
  thread destructibletrucksetup("_encstr_BA9C1491B2DCE84E57D8A3A5898D95A2C957C65B6064", "_encstr_8AFA12C572D769DF1C421023EA6C8F408B1B6F9E", "_encstr_87211AFF550FAB825BE0D3AF13904D71A5F586B467F551DD41D86FDF", "_encstr_A66B1E483AB2993BAFE3BD3BFA1301115A83F8A8079A9791C30FCD2EEF5B8BE9", 52);
  thread player_fired_gun_monitor();

  if(level.createfx_enabled) {
    return;
  }
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = _encstr_ACD43D5B966B8702F188FE3278AFBD5FC3069FC3B796A7CBFF30029BC877B22790E648474E1BCF56ABF04A01487BA1EFD0D5A5E2EF412B9C4F28130E889FE6::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_A60A415B0156D76AD867A7F379DAF53FFFBB16C20BB8E7A3A9AFE1EE7B31FAB788515B89F3849FDE20BD1DFF2998C997C589D3F2F85E1F55588715DE2B684B2A7E632B";
  level.player_interaction_monitor = _encstr_ACD43D5B966B8702F188FE3278AFBD5FC3069FC3B796A7CBFF30029BC877B22790E648474E1BCF56ABF04A01487BA1EFD0D5A5E2EF412B9C4F28130E889FE6::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_ACD43D5B966B8702F188FE3278AFBD5FC3069FC3B796A7CBFF30029BC877B22790E648474E1BCF56ABF04A01487BA1EFD0D5A5E2EF412B9C4F28130E889FE6::level_specific_wait_for_interaction_triggered;
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

  var_0 = getDvar("_encstr_82371807B069208CCF9A8953C2F74718B12BA1FB5A0BF9585362", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_8C5E14B1DEDA38586EDCD7D6B083FAB6C1AF6C859D95");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    visionsetpain("_encstr_A2220E0B57101A7187E131FDDADFAB8B", 0);
  else
    visionsetpain("_encstr_9B0E08E058D2B9D7B538", 0);

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

onplayerspawned() {
  thread scripts\cp\equipment\nvg::_id_13830();
}

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
  register_create_script_arrays("_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B", "_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B", level.scripted_spawner_func.size, _encstr_A1443E06669B6BBBC467DA8053A7D0B3638AD0863AE1E723874FA020EF3F4BF3FE36F7AF520BF74961039871A355E62793DFE71DAF3177315A573820F277BB5F::main);
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

destructibletrucksetup(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_5 = getscriptablearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = getEnt(var_3, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = getEntArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 hide();
  scripts\engine\utility::exploder(var_4);

  if(isDefined(var_5) && isDefined(var_5[0])) {
    var_9 = var_5[0];
    var_10 = 1;

    while(var_10) {
      var_9 waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_11, var_12);

      switch (var_11) {
        case "_encstr_99220EEC59A15AD81B95EB91CA853AD0":
        case "_encstr_866307EDCD995AC9AC":
        case "_encstr_86390885FB5A76782D42":
          trucklightsoff(var_8);
          var_10 = 0;
          scripts\engine\utility::kill_exploder(var_4);
          var_7 show();
          var_6 hide();
          return;
        case "_encstr_AF790FF05D41D931214052FCA0E06102C6":
          trucklightsoff(var_8);
          var_10 = 0;
          scripts\engine\utility::kill_exploder(var_4);
          var_7 show();
          var_6 hide();
          return;
      }
    }
  }
}

trucklightsoff(var_0) {
  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

player_fired_gun_monitor() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1592, 561, 176));
  var_0 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_0.angles = (85.3, 326, -11);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1034, 844, 92));
  var_1 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_1.angles = (0, 275, -90);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3715, 1658.5, 262));
  var_2 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_2.angles = (272, 145, -90);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1061, 917.5, 112));
  var_3 setModel("_encstr_A3C722DA7166F3BB60951DDF69F0C077B7289211B9B7D377B93941D7C51A0163BB630BFB");
  var_3.angles = (270, 0, 0);
  var_4 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1768, 2128, 80));
  var_5.angles = (0, 255, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3781.5, 2369, 45));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3773, 2338.5, 46));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3820, 2358.5, 45));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3811.5, 2328, 46));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1480.32, -650.161, 191.671));
  var_5.angles = (0, 14.679, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1418.32, -666.661, 191.671));
  var_5.angles = (0, 14.679, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-896.647, 1289.06, 58.5));
  var_5.angles = (0, 205, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-958.647, 1260.06, 58.5));
  var_5.angles = (0, 205, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
}