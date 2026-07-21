/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_eas.gsc
***********************************************/

molotov_get_cast_level_data() {
  var_0 = getdvarint("_encstr_9AB30B7EAB0326154A29C8E0C3", 0) == 1;

  if(!var_0) {
    return;
  }
  level thread aggro_player_weight();
}

aggro_player_weight() {
  level thread advanced_supply_drop_marker_sfx();
  var_0 = getdvarint("_encstr_9585113FBB4A29FE033111999BDFA5A0E605AF", 0) == 1;

  if(var_0)
    level thread afkroundcounted();

  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  var_1 = getdvarint("_encstr_B89C1DDC369CD79893EB590BB9FADD852DE8D799DE9CEB079CACB6B08E3686", 1) == 1;

  if(var_1)
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  scripts\engine\scriptable::_id_12F5A(::ai_anim_relative);
  level thread ai_ascender_animin();
}

advanced_supply_drop_marker_sfx() {
  scripts\mp\utility\sound::besttime("_encstr_93431522DE1F6A1DF88FD17F24A29FAE73C8C946D7204A");
}

ai_ascender_animin() {
  level.monitor_waypoint_objective_on_front_truck = [];
  var_0 = aggressive_melee_charge_init();
  var_1 = level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE";
  var_2 = getdvarint("_encstr_973E247BB64B7F661D09BAF2406F5F07E32EF5DFD533DFE1E90BB3CA394955BF780D7197E0DB", 0) == 1;

  if(var_1 && !var_2)
    var_0 = aggressively_chase_down_target();

  var_3 = var_0.size;
  var_4 = [];

  for(var_5 = 0; var_5 < var_3; var_5++)
    var_4[var_4.size] = var_5;

  var_6 = scripts\engine\utility::array_randomize(var_4);
  var_7 = [];

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_7[var_5] = [];

    for(var_8 = 0; var_8 < var_0[var_5].size; var_8++) {
      var_9 = var_7[var_5].size;
      var_7[var_5][var_9] = var_8;
    }

    var_7[var_5] = scripts\engine\utility::array_randomize(var_7[var_5]);
  }

  var_10 = getdvarint("_encstr_86B31970DA724FB9335FB5BF6B5F80FB58A110D8524163300B8D46", -1);
  var_11 = getdvarint("_encstr_AA14236E36C9AF1393D72B58B9F5735DB5BE953699AF4E569DA5F673B9FA8395E4D7B5580E", 13);
  var_12 = getdvarint("_encstr_8BC9282BF65001357A70FD23530FF8932FB9FD49D73E9A479372F01C501C5ABFA05220173DD0242AC55B", 3);
  var_13 = 0;

  for(var_14 = 0; var_14 < var_12; var_14++) {
    for(var_15 = 0; var_15 < var_11; var_15++) {
      if(var_13 >= var_10 && var_10 != -1) {
        break;
      }

      if(var_15 >= var_6.size) {
        break;
      }

      var_16 = var_6[var_15];
      var_17 = var_7[var_16];

      if(var_14 >= var_17.size) {
        continue;
      }
      var_18 = var_7[var_16][var_14];
      level.monitor_waypoint_objective_on_front_truck[var_13] = spawnStruct();
      level.monitor_waypoint_objective_on_front_truck[var_13].monitor_player_plunder = var_13;
      level.monitor_waypoint_objective_on_front_truck[var_13].armsrace_c4_planter_attack = 0;
      level.monitor_waypoint_objective_on_front_truck[var_13]._id_12AD3 = var_16;
      level.monitor_waypoint_objective_on_front_truck[var_13].first_switch = var_18;
      var_13++;
    }
  }

  after_spawn_func("_encstr_8F820A3E0BDA03BE59F8A8BF" + level.monitor_waypoint_objective_on_front_truck.size + "_encstr_B88007DA2F7B033D56");

  foreach(var_20 in level.monitor_waypoint_objective_on_front_truck) {
    var_21 = var_0[var_20._id_12AD3][var_20.first_switch];
    var_22 = scripts\engine\utility::array_randomize(var_21);
    var_23 = [];
    var_24 = getdvarint("_encstr_8C7015D2E8628705CB8FBD3F07AE535B70B71AEB5C3550", 3);

    for(var_25 = 0; var_25 < var_24; var_25++) {
      if(isDefined(var_22[var_25]))
        var_23[var_23.size] = var_22[var_25];
    }

    var_20._id_13695 = var_23;
    var_20.interaction_get_cost = 0;
  }

  foreach(var_20 in level.monitor_waypoint_objective_on_front_truck)
  level thread ai_ascender_doanims(var_20.monitor_player_plunder);
}

aggressively_chase_down_target() {
  var_0 = [];
  var_1 = 0;
  var_2 = 0;

  for(var_3 = 0; var_3 < 6; var_3++) {
    var_4 = var_1 + 1000 * var_3;
    var_5 = var_2 - 1000 * var_3;
    var_0[var_3] = [];
    var_0[var_3][0] = [];
    var_6 = 4;

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_8 = spawnStruct();
      var_8._id_12812 = var_4 + 100 * var_7;
      var_8._id_12813 = var_5 - 100 * var_7;
      var_8._id_12814 = 100;
      var_8.building_roof_chopper_reenforce_watch = randomintrange(-180, 180);
      var_8.building_roof_jugg_behavior = randomintrange(-180, 180);
      var_8.building_roof_jugg_protect_roof_then_chase = randomintrange(-180, 180);
      var_8.busbpulledout = var_3;
      var_9 = var_0[var_3][0].size;
      var_0[var_3][0][var_9] = var_8;
    }
  }

  return var_0;
}

aggressive_melee_charge_init() {
  var_0 = [];
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 4;
  var_6 = 5;
  var_7 = 6;
  var_8 = 7;
  var_9 = 8;
  var_10 = 9;
  var_11 = "_encstr_A73F18277118AAFA79D12EB28E383F7287C1BFB7255E36A3305B";
  var_12 = tablelookupgetnumrows(var_11);

  for(var_13 = 0; var_13 < var_12; var_13++) {
    var_14 = int(tablelookupbyrow(var_11, var_13, var_1));
    var_15 = getdvarint("_encstr_A2BA1EB9C639AF4C9CD7592CB9F5958D33D70EB737EB1363B0D8D6D8B4DC1DEB" + var_14, 0) == 1;

    if(var_15) {
      continue;
    }
    var_16 = int(tablelookupbyrow(var_11, var_13, var_2));
    var_17 = getdvarint("_encstr_99F9216E36C9D7139C7DCA16DCBEACD833BE9359764BB7CDBE4C63168DD6B1966E47D7" + var_16, 0) == 1;

    if(var_17) {
      continue;
    }
    if(!isDefined(var_0[var_16]))
      var_0[var_16] = [];

    var_18 = int(tablelookupbyrow(var_11, var_13, var_3));
    var_19 = getdvarint("_encstr_841D236EB139D71339AF95B0B9FA56D899BE265D5A63C896E6B37D4CB10BC6DA36D237E87D" + var_16 + "_encstr_BA4C02DF" + var_18, 0) == 1;

    if(var_17) {
      continue;
    }
    if(!isDefined(var_0[var_16][var_18]))
      var_0[var_16][var_18] = [];

    var_20 = spawnStruct();
    var_20._id_12812 = int(tablelookupbyrow(var_11, var_13, var_4));
    var_20._id_12813 = int(tablelookupbyrow(var_11, var_13, var_5));
    var_20._id_12814 = int(tablelookupbyrow(var_11, var_13, var_6));
    var_20.building_roof_chopper_reenforce_watch = int(tablelookupbyrow(var_11, var_13, var_7));
    var_20.building_roof_jugg_behavior = int(tablelookupbyrow(var_11, var_13, var_8));
    var_20.building_roof_jugg_protect_roof_then_chase = int(tablelookupbyrow(var_11, var_13, var_9));
    var_20.busbpulledout = int(tablelookupbyrow(var_11, var_13, var_10));
    var_21 = var_0[var_16][var_18].size;
    var_0[var_16][var_18][var_21] = var_20;
  }

  return var_0;
}

ai_anim_relative(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2) || var_2.type != "_encstr_B8A61060857D182AF8C87FF428F89BA710E3") {
    return;
  }
  level thread ai_array(level.monitor_waypoint_objective_on_front_truck[var_2.monitor_player_plunder], var_3, var_0);
}

ai_array(var_0, var_1, var_2) {
  var_3 = var_0.collision;
  var_4 = getdvarint("_encstr_9AB30B7EAB0326154A29C8E0C3", 500);
  var_0.armsrace_c4_planter_attack = var_0.armsrace_c4_planter_attack + var_1;

  if(var_0.armsrace_c4_planter_attack > var_4) {
    var_0.interaction_get_cost++;
    var_0.scriptable setscriptablepartstate("_encstr_A5640CE6BDAB9BC8F54796D695E4", "_encstr_93910A9EA80FCB7049D0C9B1");

    if(isDefined(var_2) && isPlayer(var_2))
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_vehicle_if_driver_dies(var_2, var_0.interaction_get_cost);

    if(var_0.interaction_get_cost < var_0._id_13695.size)
      level thread ai_ascender_doanims(var_0.monitor_player_plunder);
    else
      level thread aggressive_melee_active(var_0.monitor_player_plunder, var_2);
  }

  waitframe();
}

aggressive_melee_active(var_0, var_1) {
  var_2 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_2.scriptable notify("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
  var_2.scriptable setscriptablepartstate("_encstr_8374089D4BE6ABC2D8E6", "_encstr_95DF070DD22319CA9B");
  var_2.collision setscriptablepartstate("_encstr_96190434978B", "_encstr_A76A0AD9CC1EAF8CCA16D11A");
  var_2.scriptable setscriptablepartstate("_encstr_85080B77A79DD074D10C0F05A5", "_encstr_AF3E0FBE17CD413DB73B2171EBAFAFBEA5");

  if(isDefined(var_1) && isPlayer(var_1))
    var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_1301E("_encstr_AC8E11CBC173E0EA2A332730F2472DF825B56B", 1);

  waitframe();
  level thread ai_ascender_animloop(var_2.scriptable.origin, var_2.scriptable.angles);
  var_3 = 6;
  wait(var_3);
  var_2.scriptable freescriptable();
}

ai_ascender_animloop(var_0, var_1) {
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_3 = 10;
  var_4 = verifybunkercode("_encstr_8CF41BA80FEB1B43EBDFD0443743B5A0324F8870D382F177820237550F", randomint(var_3));
  var_4[var_4.size] = "_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A";

  if(_encstr_8A0E28B7504BB4F9B39BBED567EE912625A1FB335B055A179923CEE1F028B188BD684DC6738BA6EC7FF3::airlock_button_l())
    var_4[var_4.size] = _encstr_8A0E28B7504BB4F9B39BBED567EE912625A1FB335B055A179923CEE1F028B188BD684DC6738BA6EC7FF3::airlock_button_think();

  var_1 = var_1 + (0, -90, 0);
  var_5 = getdvarint("_encstr_BAD51EB3EA1378C052970B7BC371083D5F622BD9B1BFA80BEDBF0F61F9E578F5", 50);
  var_6 = randomint(100) < var_5;

  if(var_6)
    var_4[var_4.size] = "_encstr_BDBE0C2627B1F6DE477D6CDB2C8D";
  else
    var_4[var_4.size] = "_encstr_AC4D10130810CF5241AF6A25703FFA897860";

  if(getdvarint("_encstr_8D1310208A227F89038FE4ECB76770E54F13", 0) > 0) {
    var_4[var_4.size] = "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253";
    var_4[var_4.size] = "_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3";
  }

  foreach(var_8 in var_4) {
    if(_encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::get_bonus_targets(var_8))
      var_9 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_8, var_2, var_0, var_1, 0, 1);
  }
}

apc_horn(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

ai_ascender_doanims(var_0) {
  var_1 = "_encstr_8A210AB33387EB2B373A2B9C";
  var_2 = "_encstr_8AD909B3993CEBCA3C961D";
  var_3 = "_encstr_95DF070DD22319CA9B";
  var_4 = "_encstr_95DF070DD22319CA9B";
  var_5 = 0.25;
  var_6 = level.monitor_waypoint_objective_on_front_truck[var_0];

  if(isDefined(var_6.scriptable) &isDefined(var_6.collision)) {
    var_6.scriptable notify("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
    var_6.collision setscriptablepartstate("_encstr_96190434978B", var_2);
    var_6.scriptable setscriptablepartstate("_encstr_85080B77A79DD074D10C0F05A5", "_encstr_AF3E0FBE17CD413DB73B2171EBAFAFBEA5");
    var_7 = getdvarfloat("_encstr_B13516B3768B9FE99B196928931FBF601029D1018352337B", 0.25);
    wait(var_7);
    var_6.scriptable setscriptablepartstate("_encstr_8374089D4BE6ABC2D8E6", var_4);
    var_8 = getdvarfloat("_encstr_AFEE19835EA3977E052182DA580776133937161D6FAEA347D1F84B", 3.0);
    wait(var_8);
  }

  if(isDefined(var_6.scriptable))
    var_6.scriptable freescriptable();

  if(isDefined(var_6.collision))
    var_6.collision freescriptable();

  var_9 = var_6._id_13695[var_6.interaction_get_cost];
  var_10 = var_9._id_12812;
  var_11 = var_9._id_12813;
  var_12 = var_9._id_12814;
  var_13 = (var_10, var_11, var_12);
  var_14 = var_9.building_roof_chopper_reenforce_watch;
  var_15 = var_9.building_roof_jugg_behavior;
  var_16 = var_9.building_roof_jugg_protect_roof_then_chase;
  var_17 = (var_14, var_15, var_16);
  var_6.scriptable = easepower("_encstr_ABC406CEE6BD6B59", var_13, var_17);
  var_6.scriptable setscriptablepartstate("_encstr_8374089D4BE6ABC2D8E6", var_4);
  var_6.armsrace_c4_planter_attack = 0;
  waitframe();
  var_18 = var_9.busbpulledout;
  var_19 = "_encstr_B2CD068BA84A58C7" + var_18;
  var_20 = [];
  var_20[0] = 20;
  var_20[1] = -20;
  var_20[2] = 20;
  var_20[3] = 10;
  var_20[4] = 10;
  var_20[5] = 10;
  var_21 = var_20[var_18];
  var_22 = vectorNormalize(anglestoup(var_6.scriptable.angles));
  var_23 = apc_horn(var_22, var_21);
  var_24 = getdvarint("_encstr_88521608BAF2F3798B25E8FD34FB86BF5D52C0F8F38C3730", 0) == 1;

  if(!var_24)
    var_6.collision = easepower("_encstr_B8A61060857D182AF8C87FF428F89BA710E3", var_13 + var_23, var_6.scriptable.angles);

  var_6.collision.monitor_player_plunder = var_0;
  var_6.collision setscriptablepartstate("_encstr_96190434978B", var_1);
  wait(var_5);
  var_6.scriptable setscriptablepartstate("_encstr_8374089D4BE6ABC2D8E6", var_19);
  var_25 = getdvarint("_encstr_9B1B1DD397CB68D31316522A439742E2FBC0F0A9779093CFD7D24D1370BB15", 0) == 0;

  if(var_25) {
    if(var_6.interaction_get_cost == 0)
      level thread ai_ascender_animout(var_0);
    else
      level thread advanced_supply_drop_refund_on_death(var_0);
  }
}

advanced_supply_drop_refund_on_death(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_1.scriptable notify("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
  var_1.scriptable endon("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
  var_1.scriptable setscriptablepartstate("_encstr_A5640CE6BDAB9BC8F54796D695E4", "_encstr_81A5097BD7A09583B8F0C2");
  var_3 = getdvarint("_encstr_A32014E64BF201803AAEC3431BA643EF372F01618B3F", 7);
  var_4 = getdvarint("_encstr_9BC115FB36CBFFE69D893A72C0EF9E8783286464583373", 15);
  var_4 = max(var_4, var_3);
  wait(var_3);
  var_5 = randomint(6);
  var_6 = "_encstr_A2190467EDEB" + var_5;
  var_1.scriptable setscriptablepartstate("_encstr_87320FEB30655BFF112F9665B78804970D", var_6);
  var_7 = var_4 - var_3;
  wait(var_7);
  var_1.scriptable setscriptablepartstate("_encstr_A5640CE6BDAB9BC8F54796D695E4", "_encstr_93910A9EA80FCB7049D0C9B1");
  thread ai_aggro_goal_shrink(var_0);
}

ai_aggro_goal_shrink(var_0) {
  var_1 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_1.scriptable notify("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
  var_2 = [];
  var_2[var_2.size] = "_encstr_B1DF1B230FAFC4276BAF9DDCB7DAAF769BDED659BE630BAB76A1F59818";
  var_2[var_2.size] = "_encstr_AFDF1BC8C3FA4CE4DAD7CE73F66B7D769BED5B597DD82CAE9D43AF64C0";
  var_3 = var_2[randomint(var_2.size)];
  var_4 = getdvarint("_encstr_BE2C162BE61B2FD6ADB96A22B09FCADB53D8BFA20F6007DF", 900);
  var_5 = scripts\mp\utility\player::getplayersinradius(var_1.scriptable.origin, var_4);

  foreach(var_7 in var_5) {
    if(!istrue(var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())) {
      var_7 playsoundtoplayer(var_3, var_7, var_7);
      var_7 playsoundtoplayer("_encstr_8FE115D38837347F6B70BDA8FF300FBF53714BBA50912D", var_7, var_7);
      pinglocationenemyteams(var_7.origin, var_7.team);
      var_8 = getdvarint("_encstr_869D194E2ED34FA19A9FF0D8079FDB41CB15D05D036BFBAB794790", 6);
      var_7 scripts\mp\weapons::setplayerstunned();
      var_7 thread scripts\mp\weapons::cleanupconcussionstun(var_8);
      var_7 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_7 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_A146078E65FB5158DD", var_8, 1);
    }
  }

  var_1.scriptable freescriptable();
  var_1.collision freescriptable();
}

ai_ascender_animout(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_1.scriptable notify("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
  var_1.scriptable endon("_encstr_B4A410680AB998D30B131DD3319E70BAD0E2");
  var_2 = 5;
  var_3 = randomint(var_2);
  wait(var_3);

  for(;;) {
    wait(var_2);
    var_4 = getdvarint("_encstr_931317FBA25B20981ADFB3B31B89C87DBF0B93E6DB6FE0F8F7", 90);
    var_5 = scripts\mp\utility\player::getplayersinradius(var_1.scriptable.origin, var_4);

    if(var_5.size > 0) {
      var_7 = [];
      var_7[var_7.size] = "_encstr_B1DF1B230FAFC4276BAF9DDCB7DAAF769BDED659BE630BAB76A1F59818";
      var_7[var_7.size] = "_encstr_AFDF1BC8C3FA4CE4DAD7CE73F66B7D769BED5B597DD82CAE9D43AF64C0";
      var_8 = var_7[randomint(var_7.size)];

      foreach(var_10 in var_5)
      var_10 playsoundtoplayer(var_8, var_10, var_10);

      level thread advanced_supply_drop_refund_on_death(var_0);
      return;
    }
  }
}

affect_hvt_healthdrain(var_0) {
  var_1 = spawnStruct();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    switch (var_2) {
      case 0:
        break;
      case 1:
        var_1._id_12812 = int(var_0[var_2]);
        break;
      case 2:
        var_1._id_12813 = int(var_0[var_2]);
        break;
      case 3:
        var_1._id_12814 = int(var_0[var_2]);
        break;
      case 4:
        break;
      case 5:
        var_1.building_roof_chopper_reenforce_watch = int(var_0[var_2]);
        break;
      case 6:
        var_1.building_roof_jugg_behavior = int(var_0[var_2]);
        break;
      case 7:
        var_1.building_roof_jugg_protect_roof_then_chase = int(var_0[var_2]);
        break;
      case 8:
        break;
      case 9:
        var_1.bunkeralt_playeridlewatch = int(var_0[var_2]);
        break;
    }
  }

  return var_1;
}

agent_pickup_hostage_scene() {
  var_0 = level.istwohandedoffhand;
  var_1 = "_encstr_ADF10A0A377A28CF6A6DF2F7" + var_0._id_12812 + "_encstr_974C0246" + var_0._id_12813 + "_encstr_974C0246" + var_0._id_12814;
  var_1 = var_1 + ("_encstr_9AB70A1014DC9DB1CA9B4740" + var_0.building_roof_chopper_reenforce_watch + "_encstr_974C0246" + var_0.building_roof_jugg_behavior + "_encstr_974C0246" + var_0.building_roof_jugg_protect_roof_then_chase);
  var_1 = var_1 + ("_encstr_86FD0AF06FCD6F9D539917AE" + var_0.bunkeralt_playeridlewatch);
  iprintlnbold(var_1);
  var_1 = "_encstr_B61915B92B3A08E61B27AF13277D560BB9BEE68358EEB9" + var_1;
  var_1 = "_encstr_972933C3A7FA2E667E91CE366986AEE6220F7B4B3F92563E56B9C63E41AED6BE8AF7F3D3572A9EF60EA1DE2659F61EB6EA596858E9" + var_1;
  logstring(var_1);
}

agentclasscallback() {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }
  level.isspecialcaseweapon = easepower("_encstr_B8A61060857D182AF8C87FF428F89BA710E3", level.players[0].origin, level.players[0].angles);
}

agentsinsphere(var_0) {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }
  if(!isDefined(level._id_13845)) {
    level.players[0] thread after_hit_by_emp_func();
    level._id_13845 = 1;
  }

  var_1 = level.istwohandedoffhand;

  if(isDefined(var_0)) {
    var_2 = 10;
    var_3 = strtok(var_0, "_encstr_974C0246");

    if(var_3.size == var_2)
      var_1 = affect_hvt_healthdrain(var_3);
    else {
      iprintlnbold("_encstr_8BA77E097A23373408C7901DFF1F478B38E1A66AFD7396BFDDBCCB2BE5D2C8DBC702B30C99A3415B4EA3A3C9C55A6D9773FD709D1AB051834D9262DA0AB55B4E3E515B212E92771738CAF05720227B784271DD1BFBF7D166D2A823B616073E223ABA19A7F337F37013BA0E598AF63EA20AEE8ABFE3884E2BD35902D31D65212F");
      var_1 = spawnStruct();
      var_1._id_12812 = int(level.players[0].origin[0]);
      var_1._id_12813 = int(level.players[0].origin[1]);
      var_1._id_12814 = int(level.players[0].origin[2]) + 40;
      var_1.building_roof_chopper_reenforce_watch = int(level.players[0].angles[0]);
      var_1.building_roof_jugg_behavior = int(level.players[0].angles[1]);
      var_1.building_roof_jugg_protect_roof_then_chase = int(level.players[0].angles[2]);
      var_1.bunkeralt_playeridlewatch = 0;
    }
  }

  var_4 = (var_1._id_12812, var_1._id_12813, var_1._id_12814);
  var_5 = (var_1.building_roof_chopper_reenforce_watch, var_1.building_roof_jugg_behavior, var_1.building_roof_jugg_protect_roof_then_chase);

  if(!isDefined(level.isspawningstopped))
    level.isspawningstopped = easepower("_encstr_ABC406CEE6BD6B59", var_4, var_5);
  else {
    level.isspawningstopped.origin = var_4;
    level.isspawningstopped.angles = var_5;
  }

  level.istwohandedoffhand = var_1;
  var_6 = "_encstr_B2CD068BA84A58C7" + var_1.bunkeralt_playeridlewatch;
  level.isspawningstopped setscriptablepartstate("_encstr_8374089D4BE6ABC2D8E6", var_6);
  agent_pickup_hostage_scene();
}

agentthink(var_0, var_1) {
  var_2 = 4;
  var_3 = 15;

  switch (var_0) {
    case "_encstr_B60D055B8D2B99":
      level.istwohandedoffhand._id_12812 = level.istwohandedoffhand._id_12812 + var_2 * var_1;
      break;
    case "_encstr_B40D05402A0F09":
      level.istwohandedoffhand._id_12813 = level.istwohandedoffhand._id_12813 + var_2 * var_1;
      break;
    case "_encstr_B20D0541D03388":
      level.istwohandedoffhand._id_12814 = level.istwohandedoffhand._id_12814 + var_2 * var_1;
      break;
    case "_encstr_AC660860FAA2B16FC711":
      level.istwohandedoffhand.building_roof_chopper_reenforce_watch = level.istwohandedoffhand.building_roof_chopper_reenforce_watch + var_3 * var_1;
      break;
    case "_encstr_B866082B78EF03AA8306":
      level.istwohandedoffhand.building_roof_jugg_behavior = level.istwohandedoffhand.building_roof_jugg_behavior + var_3 * var_1;
      break;
    case "_encstr_8F660885CDCE3695DC2D":
      level.istwohandedoffhand.building_roof_jugg_protect_roof_then_chase = level.istwohandedoffhand.building_roof_jugg_protect_roof_then_chase + var_3 * var_1;
      break;
    case "_encstr_A1D80733259231EB45":
      level.istwohandedoffhand.bunkeralt_playeridlewatch = level.istwohandedoffhand.bunkeralt_playeridlewatch + var_1;

      if(level.istwohandedoffhand.bunkeralt_playeridlewatch == -1)
        level.istwohandedoffhand.bunkeralt_playeridlewatch = 5;

      level.istwohandedoffhand.bunkeralt_playeridlewatch = level.istwohandedoffhand.bunkeralt_playeridlewatch % 6;
      break;
  }

  agentsinsphere();
}

agenttargetloadout(var_0) {
  var_1 = ["_encstr_B60D055B8D2B99", "_encstr_B40D05402A0F09", "_encstr_B20D0541D03388", "_encstr_AC660860FAA2B16FC711", "_encstr_B866082B78EF03AA8306", "_encstr_8F660885CDCE3695DC2D", "_encstr_A1D80733259231EB45"];
  level.istutorial = level.istutorial + var_0;

  if(level.istutorial == -1)
    level.istutorial = var_1.size - 1;

  level.istutorial = level.istutorial % var_1.size;
  level.istripwiredamagetype = var_1[level.istutorial];
  iprintlnbold("_encstr_A7D813C707852ACE98A9B2C6DB80ED225D9383D269" + level.istripwiredamagetype);
}

after_hit_by_emp_func() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;
  var_0 notifyonplayercommand("_encstr_B607038BAA", "_encstr_9B0D065699E485D9");
  var_0 notifyonplayercommand("_encstr_960703D0C0", "_encstr_8E5F0795E6AD7BAD2B");
  var_0 notifyonplayercommand("_encstr_9AD00AB79773F2E731B8176B", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  var_0 notifyonplayercommand("_encstr_95110A91696A69B10BBFD47B", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_in_array_return(["_encstr_B607038BAA", "_encstr_960703D0C0", "_encstr_9AD00AB79773F2E731B8176B", "_encstr_95110A91696A69B10BBFD47B"]);

    switch (var_1) {
      case "_encstr_B607038BAA":
        agentthink(level.istripwiredamagetype, 1);
        break;
      case "_encstr_960703D0C0":
        agentthink(level.istripwiredamagetype, -1);
        break;
      case "_encstr_9AD00AB79773F2E731B8176B":
        agenttargetloadout(1);
        break;
      case "_encstr_95110A91696A69B10BBFD47B":
        agenttargetloadout(-1);
        break;
    }
  }
}

agentsnear() {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }
  ai_ascender_animloop(level.players[0].origin, level.players[0].angles);
}

agent_pickup_hostage_scene_body() {
  if(!isDefined(level.monitor_waypoint_objective_on_front_truck)) {
    return;
  }
  var_0 = 100;
  var_1 = (1, 0, 0);
  var_2 = 10;

  foreach(var_4 in level.monitor_waypoint_objective_on_front_truck) {
    var_5 = var_4._id_13695[var_4.interaction_get_cost];

    if(!isDefined(var_5) || !isDefined(var_4.scriptable)) {
      continue;
    }
    var_6 = var_5._id_12812;
    var_7 = var_5._id_12813;
    var_8 = var_5._id_12814;
    var_9 = (var_6, var_7, var_8);
    thread scripts\mp\utility\debug::drawsphere(var_9, var_0, var_2, var_1);
  }
}

after_spawn_func(var_0) {
  var_1 = getdvarint("_encstr_9585113FBB4A29FE033111999BDFA5A0E605AF", 0) == 1;

  if(var_1) {
    iprintlnbold(var_0);
    logprint(var_0);
  }
}

afkroundcounted() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.istripwiredamagetype = "_encstr_B60D055B8D2B99";
  level.istutorial = 0;

  for(;;) {
    var_0 = getDvar("_encstr_A5441182D0A281E890AEC32B42B72870A94F83", "_encstr_B40101");

    if(var_0 != "_encstr_B40101")
      agentsinsphere(var_0);

    var_1 = getDvar("_encstr_ABC11BE636C9FA989CBEB2B06EBECD1C16BBE6AFB1ED8DD8A5B9B4F673", "_encstr_B40101");

    if(var_1 != "_encstr_B40101")
      agentclasscallback();

    var_2 = getDvar("_encstr_B635161633C3B7F51EF0BFC077217E2098671E88F83098B3", "_encstr_B40101");

    if(var_2 != "_encstr_B40101")
      agentsnear();

    var_3 = getDvar("_encstr_81EA1ACD36C9FA899CD7951637D76ED0EDEEBED8BDB1B0D14BF6B937", "_encstr_B40101");

    if(var_3 != "_encstr_B40101")
      agent_pickup_hostage_scene_body();

    var_4 = getDvar("_encstr_A18B10E63693D798C9EB952CB9FAB5B41BD8", "_encstr_B40101");

    if(var_4 != "_encstr_B40101" && isDefined(level.monitor_waypoint_objective_on_front_truck) && isDefined(level.monitor_waypoint_objective_on_front_truck[0]))
      ai_array(level.monitor_waypoint_objective_on_front_truck[0], 99999);

    waitframe();
  }
}