/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_br_syrk\cp_br_syrk_humvee.gsc
****************************************************/

start() {
  if(!scripts\engine\utility::flag_exist("_encstr_B10E15361CEBC493AF34ABADD92B957D5A37A5D1A3AC19"))
    scripts\engine\utility::flag_init("_encstr_B10E15361CEBC493AF34ABADD92B957D5A37A5D1A3AC19");

  _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::init();
  load_vfx();
  setDvar("_encstr_8BFF175289C8BB74389DE4D85B087A0F88A5CACBB7BF9BEF60", 450);
  setDvar("_encstr_82A519305AF9D9389F3275673DAB03A71DA0A820A00D0D13975A0D", 20);
  setDvar("_encstr_A65414C6D9EBA3D04B4EC841CA4EB97BCD340BE4AA38", 150);
  var_0 = scripts\engine\utility::getStruct("_encstr_BD4A0F2A03196BEF907FBBA01B58756F3E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level thread _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::deploy_vehicle(var_0, _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::get_humvee_info(var_0));
  level thread _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::set_up_ieds();
  level thread cp_br_syrk_tutorial_dialogue();
  activate_radius_distance_trigger_markers();
  scripts\engine\utility::flag_set("_encstr_B10E15361CEBC493AF34ABADD92B957D5A37A5D1A3AC19");
}

teleport_players() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B4314137BE24EADEFE10FACA8C308DA273A11E913F8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(var_1 = 0; var_1 < 3; var_1++)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_5, var_3 in level.players) {
    var_4 = var_0[var_5];
    var_3 setOrigin(var_4.origin);
    var_3 setplayerangles(var_4.angles);
  }
}

set_up_suicide_bomber_call_back() {
  level.suicide_bomber_combat_func = ::suicide_bomber_combat_func;
  level.suicide_bomber_explode_func = ::suicide_bomber_explode_func;
}

suicide_bomber_combat_func() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = get_closet_alive_player(self);
  self getenemyinfo(var_0);

  for(;;) {
    self.bomberusegrenade = 0;

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on))
        self.bombertarget = self.enemy.vehicle_riding_on;
      else
        self.bombertarget = undefined;
    }

    wait 0.25;
  }
}

get_closet_alive_player(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::getclosest(var_0.origin, var_1);
}

suicide_bomber_explode_func(var_0) {
  if(isDefined(var_0.bombertarget) && scripts\engine\utility::array_contains(level.vehicle_travel_array, var_0.bombertarget)) {
    var_1 = var_0.bombertarget;
    var_2 = get_closest_ied_triggering_tag(var_1, var_0);

    if(isDefined(var_2)) {
      var_3 = var_1 gettagorigin(var_2);
      var_4 = _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::get_repair_interaction_point_name(var_2);
      var_5 = _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::get_vehicle_interaction_point(var_1, var_4);
      _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::try_enable_repair_interaction(var_1, var_2, var_0.origin, var_4, var_5);
    }
  }
}

get_closest_ied_triggering_tag(var_0, var_1) {
  var_2 = 99999999;
  var_3 = undefined;

  if(isDefined(var_0.ied_triggering_tags)) {
    foreach(var_5 in var_0.ied_triggering_tags) {
      var_6 = distancesquared(var_0 gettagorigin(var_5), var_1.origin);

      if(var_6 < var_2) {
        var_2 = var_6;
        var_3 = var_5;
      }
    }
  }

  return var_3;
}

register_spawn_groups() {
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC041A346DF1CBE1B7D1B80C73B6B87C85D4BF64187D607F69101067", 1, 1, 1, 3, 3, "_encstr_92EB22090B52FCE08FCF300B75A740BBDA9B8799E73BC6B8F7651841D153B8E7032B7B35", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BA972521769836D1C7F8981F9B8199C2C202C798A2730A075730CE8D072A42F7B850BB890FB3A1", 2, 2, 2, 4, 5, "_encstr_A5AD2DEAE31B6BEF4109A7A70519F45F3198D1B2A8EDA7276977AEBD4F187ECFEA96BB2A31CBF391F071D997D518C2", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B041A794EDB38E3BEFAED1460D1FACB59884FC8274B7FB5470B0C8F", 1, 1, 1, 4, 3, "_encstr_977C226C3BE403CA9FBB78D8F8FE837B132A89ABE25B87DAF0B39F2721F8D09A7CA3A92B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9A1B1C234EB49DCAF532DBBBDC7D1A4B63D8EB34DEAE6E2BAF8EA193CA2B", 1, 1, 1, 4, 3, "_encstr_8592249FBE5BEBF57EB81F77C056A04239D92914A8DB733D86203B7BE0495F2BD9E7AB0D053D", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8DEC21B5FA2F435B41DAD810526919F8539C503B4FE72B93B9C3D8209ABFBF51BF3BC2", 4, 4, 4, 4, 3, "_encstr_AD2829FACB7BF3A73F83D2C3B02F99028DBA91AB18F0A331991362ED2B85376E8E31B860F3C3E3CFAECFCA", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_82341FC8934BB356BE917BDDDCD71A4BB136F50DDED59B957D66DED539EB3983CE", 1, 1, 1, 5, 3, "_encstr_8E1823B4F6E0139F7F9842DBD0279427F8510720808BDFA757E04AF318CF8AFB31448EA5A6", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_95AD1F199CA5ECACFA46DEDDCDFA0DB463637D34DB57372B7D99A5B3B2FAB52DE1", 2, 2, 2, 5, 3, "_encstr_A33723E1535785EFFFA197504DEF689B80F8199B10159A78692D604B5B579FA2BA1B65F1CA", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BD9A20234E5AEC56D78CB7DDB9AF43D236B1FAA1B7AEDC95FA332D9D2BD731581BDA", 4, 4, 4, 5, 3, "_encstr_8B7328B9AA51888DB1DB8FB7DB9943C8FC8546B0159568B5E9AB9B8DEF619EC08BDCCE2B7AE910F8A2D3", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BA041A91E44B9D95AF19DEBB73F53496C6C6F543DB5DE656FAE6B40F", 1, 1, 1, 5, 3, "_encstr_92C922914EB4B395AF23BDEE37BE86B4C636AF1A7BABE659AF6ED2F0EBDC0716EEDC59C9", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5FE1F61AB671B8AE134A707EA5958CA440DBFD4AAF526B82133FCEA683D430E13", 3, 3, 3, 5, 3, "_encstr_B4442741A21FC51BC11C47D38D1963588C7B800112F7664D5FDB31E0116E98C00311AB3008403EA8FB", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B81920324E4B6795F519BDEE9BAF34A58DC67DD0DE5DCDCAEBDCAC6756E67DD6A5C3", 3, 3, 3, 5, 3, "_encstr_96A424A2AB5333B709316F7FCDE13C9709C0A9EA90356FEF31079D66E33089B7AF99A312B90E", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_97B12546E4A59DACEB23BDDD73D786D263367D86DBAE3756BE6EBAB4362D192BAF26B7B6C4B2C9", 1, 3, 3, 5, 3, "_encstr_8CE3273763605E72B0D1AFD7DD586A89B048617A3BC813CA75FB678B377992FDE8B6E202D160D6C256", undefined, undefined, undefined);
  level thread drive_down_hill_enemy_spawn_think();
}

drive_down_hill_enemy_spawn_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\engine\utility::_id_143A5("_encstr_AAD517D2CA19EBB339DBEA1CD7DE9B95AF593C07B1BD91CA19", "_encstr_B257159C5958D80D9532EBA45111F5A7EDE659D7DE9BCA");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AC041A346DF1CBE1B7D1B80C73B6B87C85D4BF64187D607F69101067");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BA972521769836D1C7F8981F9B8199C2C202C798A2730A075730CE8D072A42F7B850BB890FB3A1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8B041A794EDB38E3BEFAED1460D1FACB59884FC8274B7FB5470B0C8F");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9A1B1C234EB49DCAF532DBBBDC7D1A4B63D8EB34DEAE6E2BAF8EA193CA2B");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8DEC21B5FA2F435B41DAD810526919F8539C503B4FE72B93B9C3D8209ABFBF51BF3BC2");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_82341FC8934BB356BE917BDDDCD71A4BB136F50DDED59B957D66DED539EB3983CE");
  level scripts\engine\utility::_id_143A5("_encstr_867C17E3B52590F45BC0474AE03B23BDAF455223CD77BDF732", "_encstr_97571583D72F2BC0778821B78D24F8F29FBD15880C7FD0");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95AD1F199CA5ECACFA46DEDDCDFA0DB463637D34DB57372B7D99A5B3B2FAB52DE1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BD9A20234E5AEC56D78CB7DDB9AF43D236B1FAA1B7AEDC95FA332D9D2BD731581BDA");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BA041A91E44B9D95AF19DEBB73F53496C6C6F543DB5DE656FAE6B40F");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A5FE1F61AB671B8AE134A707EA5958CA440DBFD4AAF526B82133FCEA683D430E13");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B81920324E4B6795F519BDEE9BAF34A58DC67DD0DE5DCDCAEBDCAC6756E67DD6A5C3");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_97B12546E4A59DACEB23BDDD73D786D263367D86DBAE3756BE6EBAB4362D192BAF26B7B6C4B2C9");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A5A02634287D2494BE9AAC945AD7D189FA22942813A7A355A879487A3548A249BE529C249EAA2722");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A62D1E4F6BE76A100B91CFA3E066EEF2610B16C55DBF32479040FF4B9B5EE1EF", "_encstr_9A8507BA4040188D08");
}

get_vehicle_part_struct(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_1)
      return var_4;
  }
}

activate_radius_distance_trigger_markers() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_84A21FC3D6F4D82DABDF616377837FA88BAFEE9BBA5170EC22431F6357CBB20832", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0)
  var_2 thread radius_detection_monitor(var_2);
}

radius_detection_monitor(var_0) {
  var_1 = var_0.groupname + "_encstr_B40101";
  var_2 = undefined;

  if(isDefined(var_0.name))
    var_2 = var_0.name + "_encstr_B40101";

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_2))
    level endon(var_2);
  else
    level endon(var_1);

  var_3 = var_0.radius;
  var_4 = var_3 * var_3;

  for(;;) {
    if(any_player_within_range(var_0, var_4))
      radius_detection_monitor_send_notify(var_1, var_0, var_2);

    if(any_vehicle_within_range(var_0, var_4))
      radius_detection_monitor_send_notify(var_1, var_0, var_2);

    waitframe();
  }
}

radius_detection_monitor_send_notify(var_0, var_1, var_2) {
  if(isDefined(var_1.script_parameters))
    level notify(var_0, var_1.script_parameters + "_encstr_B40101");
  else
    level notify(var_0);

  if(isDefined(var_2))
    level notify(var_2);
}

any_player_within_range(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(istrue(var_3.unable_to_trigger_radius_detection_monitor)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < var_1)
      return 1;
  }

  return 0;
}

any_vehicle_within_range(var_0, var_1) {
  foreach(var_3 in level.vehicle_travel_array) {
    if(distancesquared(var_0.origin, var_3.origin) < var_1)
      return 1;
  }

  return 0;
}

cp_br_syrk_tutorial_dialogue() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread near_ied_zone_warning_monitor();
  level thread ied_marked_vo_monitor();
  level thread repair_vehicle_intro_vo_monitor();
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level thread vehicle_station_tutorial_vo_monitor();
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AF882BF9330F9D5DAF8FFF8A01B9FDE90927847911278713251FFF4C571B1BF1C447AF59188F2D91E3579E7C93");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BAC11E7FA091098233A9ED4B158984A20809092F2203019AD4EEFE59FF967ACA", "_encstr_9A8507BA4040188D08");
  level waittill("_encstr_BA121E8B9A6130BC42D39FBB2778E8F810B95180C7D1E078AAA7DBE9F712C5B0");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_8C41211901D18D476F4BB30E7B47ADC989283181587D4F7FFF2FB38D0C1F5509E7C0D1");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_96AB20463CAF1BC1B9F5BDB3B1EB3BCA43966CB1B27DDA854EB6F5B42B199BAFC403", "_encstr_9A8507BA4040188D08");
  level thread delay_nag_mark_ied_vo();
}

vehicle_station_tutorial_vo_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_878218AF8D826321FA4F8158D314F9AD6A37B034A76A0BA9DC0F");
  level thread delay_use_gunner_turret_vo();
  level thread delay_use_assault_drone_vo();
}

delay_use_gunner_turret_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_819B22603921EF5FE501A3DBC811191B1993F1EB41C92FE7C3601AB2580F8BAF13064574");
  wait 3;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A785220D147D2425F59ACA29A5EBD189F54492A098A73AAA51CBAAA9A8AFA85594292A51");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BECC1D5F7BF77A203BA1DFB31096FEC2711B66D56D4F436D63D0CFA37183F0", "_encstr_9A8507BA4040188D08");
}

delay_use_assault_drone_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8ABE1FDB88A373C550C110B3CD0A119B8D8B8B66986FE8E2C8A5B7611C83985E05");
  wait 7;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_915D290911C19D575F7B831E0B37BDF9B938C191686D5F4FEF3F8D961D0FA50F12F0A94101B101E7EFB6BD");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BEEF1CFC696146631E4642DB486003BFB0D3734CFBB94FA3C858FA31FBEF", "_encstr_9A8507BA4040188D08");
}

delay_nag_mark_ied_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8FDA0B19E14061651FBE28CF8A");
  level endon("_encstr_A6010D50FBC0ABAF2770974F300ACF");

  for(;;) {
    wait(randomintrange(20, 30));
    level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_83BC240B6FAE4BAA87A9B90141AFD7CB06FD998189749723EB32D00839579DB7DFD20771B57D");
    scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_ADAB20A91889406F9FB9A8F3F25724381C912F01AD61C83FB3D2A6184A935E3122A0", "_encstr_9A8507BA4040188D08");
  }
}

repair_vehicle_intro_vo_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_974C1523E973EF9630933F06BB509F5F30E3EACBF15BCB");
    level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AF1E2C8BEF2ECB2A07293981C12F574B867D190109F417A36BB291C801EB1C7BFEDC9DF0331D637FB7A958D1F9DF");
    scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A1011D2387D7360EB9BEB73B8DAFD9B21A4B6C362BAF4EB2C1162D27D72618", "_encstr_9A8507BA4040188D08");
  }
}

ied_marked_vo_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 120;
  var_1 = gettime();

  for(;;) {
    level waittill("_encstr_8FDA0B19E14061651FBE28CF8A");
    var_2 = gettime();

    if(var_2 > var_1) {
      scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_966A2151C0BFF8DFDB8F27EDBBE1242B501C39E82FD7D01D82174FC59F6B6050CFE2CB", "_encstr_9A8507BA4040188D08");
      var_1 = var_2 + var_0 * 1000;
    }
  }
}

near_ied_zone_warning_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_BA540E3795584EFA295111F5A7B7DCAC", var_0);

    if(any_ied_left_unidentified_in_zone(var_0)) {
      level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A54129F0CF68C35A297FB9BA6701D723B0A5A858D4C89FC3819F8FB1A1392C27D03FF1213DB07389C92394");
      scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BDF2203A72D00F9A102FF7D67149235FE3C8C2C2B988A31410B1CFC10BF82A6FB74B", "_encstr_9A8507BA4040188D08");
    }

    waitframe();
  }
}

any_ied_left_unidentified_in_zone(var_0) {
  foreach(var_2 in level.unidentified_ieds) {
    if(isDefined(var_2.ied_controller) && isDefined(var_2.ied_controller.groupname) && var_2.ied_controller.groupname == var_0)
      return 1;
  }

  return 0;
}

load_vfx() {
  load_surface_speed_vfx("_encstr_A1710F4327F68B4FD748F2096023464748", "_encstr_8B1608EC43B8D647A113", "_encstr_A11805E663B7BB", "_encstr_8D403104A7BB671847CAD91BD327F31512CA508C3F133F602DF798386FBF4B4DDA367D1C1019010BF38BC99053D7633D539FEB");
  load_surface_speed_vfx("_encstr_A1710F4327F68B4FD748F2096023464748", "_encstr_8B1608EC43B8D647A113", "_encstr_8F7905C4AEC319", "_encstr_828F313B6F80824B73EAAFDFE3DE0FD03F4288B317D849F38B47E5EBAFA15518CD9E69C938174835830BBFE5D74B9DA276B752");
  load_surface_speed_vfx("_encstr_A1710F4327F68B4FD748F2096023464748", "_encstr_A16605C8AB6E47", "_encstr_A11805E663B7BB", "_encstr_8D403104A7BB671847CAD91BD327F31512CA508C3F133F602DF798386FBF4B4DDA367D1C1019010BF38BC99053D7633D539FEB");
  load_surface_speed_vfx("_encstr_A1710F4327F68B4FD748F2096023464748", "_encstr_A16605C8AB6E47", "_encstr_8F7905C4AEC319", "_encstr_828F313B6F80824B73EAAFDFE3DE0FD03F4288B317D849F38B47E5EBAFA15518CD9E69C938174835830BBFE5D74B9DA276B752");
}

load_surface_speed_vfx(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle.templates.surface_effects[var_0]))
    level.vehicle.templates.surface_effects[var_0] = [];

  var_4 = var_1 + "_encstr_BA4C02DF" + var_2;
  level.vehicle.templates.surface_effects[var_0][var_4] = loadfx(var_3);
}