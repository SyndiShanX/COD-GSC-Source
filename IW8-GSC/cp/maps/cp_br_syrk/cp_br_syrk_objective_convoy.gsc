/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_br_syrk\cp_br_syrk_objective_convoy.gsc
**************************************************************/

spawn_convoy_and_drive() {
  wait 0.1;
  get_proto_convoy_event();

  if(scripts\cp\cp_objectives_events::is_event_active(level.convoy_proto_event)) {
    return;
  }
  wait 0.05;
  level thread scripts\cp\cp_objectives_events::try_start_event(level.convoy_proto_event, "_encstr_81383D635FA3893F41930F5019B7D090CB9B254AE21EB862EF82BB3A980E9F4A2FF1F2AF97E8106DC9AA517D170E3BF82B20BAF7D50B4F3BBB237EA0365FC6", level.convoy_proto_index);
}

objective_convoy_init(var_0) {
  wait 0.05;
}

objective_convoy_start(var_0) {
  var_1 = 0;

  if(!isDefined(level.wait_for_repeating_event) || !isDefined(level.wait_for_repeating_event[var_0.ref].min_wait_between_repeat))
    var_1 = 600;
  else
    var_1 = level.wait_for_repeating_event[var_0.ref].min_wait_between_repeat;

  var_1 = 99999;
  var_2 = undefined;

  foreach(var_4 in level.globalobjectives) {
    if(var_4.objname == "_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB") {
      var_2 = var_4;
      break;
    }
  }

  if(getdvarint("_encstr_9B5510E6B139F5D8DBB9D9BDF2AF27ED586B", 0) != 0) {
    set_proto_values(var_0, var_1);
    return;
  } else {
    var_6 = "_encstr_A972062F7FDAF9B0";
    var_7 = level scripts\cp\cp_convoy_manager::spawn_convoy_from_type("_encstr_BAA80819AD16C8C8134E", var_6, "_encstr_95A00AD3BB59FA0C18B3CDC2", var_2, var_1, "_encstr_87F313603A84EB49FB590C8D17DFB0B5EB72585997");
    var_7 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
    var_7 thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(0);
    var_7 thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
    var_7 thread scripts\cp\cp_convoy_manager::set_hide_icon_on_pickup_target(0);
    var_7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_pickup(1);
    var_7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_convoy_death(1);
    var_7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_nearby_convoy(1);
    var_7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_rescued(1);
    var_7 thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1);
    var_7 thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
    var_7 thread scripts\cp\cp_convoy_manager::set_recruiting_amount(8);
    var_7 thread scripts\cp\cp_convoy_manager::set_recruiting_time_btwn(3);
    var_7 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
    var_7 thread scripts\cp\cp_convoy_manager::set_can_compromise_before_1st_target(1);
    var_7 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_vehicles(0);
    var_7 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_support_vehicles(1);
    var_7 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(0);
    var_7 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
    level thread waittill_morales_ends_delete_trucks();
    wait(var_1 - 1);
  }
}

set_proto_values(var_0, var_1) {
  if(getdvarint("_encstr_9B5510E6B139F5D8DBB9D9BDF2AF27ED586B", 0) == 0) {
    return;
  }
  var_2 = get_far_away_startpath();
  var_3 = get_proto_convoy_type();
  var_4 = level.convoy_proto_event;
  var_5 = level scripts\cp\cp_convoy_manager::spawn_convoy_from_type("_encstr_BAA80819AD16C8C8134E", var_3, var_2, var_0, var_1, var_4);
  var_5 thread scripts\cp\cp_convoy_manager::set_objective_struct(var_0);
  var_5 thread scripts\cp\cp_convoy_manager::show_objective_icon(0);
  level thread first_intro_text();
  wait 6;
  var_5 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var_5 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  var_5 thread scripts\cp\cp_convoy_manager::set_healthdrain_on_lowhealth(10);
  var_5 thread scripts\cp\cp_convoy_manager::set_attach_objective_icon(1, 220);
  var_5 thread scripts\cp\cp_convoy_manager::show_health_on_objective_icon(1);

  if(var_3 == "_encstr_8F480E406FB958091E5A0807F5324561") {
    var_5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("_encstr_A19A0772BF43C35FD9", 4, 5);
    var_5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("_encstr_A19A0772BF43C35FD9", 1, 1);
  } else if(var_3 == "_encstr_A7670FB5AC19B4AEDAD2C9DB856B5ACD3B") {
    var_5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("_encstr_A19A0772BF43C35FD9", 7, 7);
    var_5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("_encstr_A19A0772BF43C35FD9", 2, 3);
  }

  var_9 = var_5 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount(1);
  var_10 = scripts\cp\cp_convoy_manager_code::get_nitrate_label(var_9);
  var_5 thread scripts\cp\cp_convoy_manager::set_objective_icon_label(var_10);
  var_5 thread scripts\cp\cp_convoy_manager::show_objective_icon(1);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_815F1C715B490E40BB193813FDAFE0B0F2FBEFB32F334FA8C1AB610EB228", "_encstr_9A8507BA4040188D08", 1);
  var_5 waittill("_encstr_A3E5145B2888AB302AC6B1F8FE15103B3889DD49CB30");
  var_5 scripts\engine\utility::_id_143B9(25, "_encstr_A9C616DF778DA0B8EFF1D1782A9FE1B065C41F79E1B47070");
  var_5 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_5 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
  level thread reset_convoy_soon();
  level thread convoy_end_this_event(var_5, var_4);
}

convoy_end_this_event(var_0, var_1) {
  var_0 waittill("_encstr_8DA60E3357366397BE27B2DABDECB28C");
  level scripts\cp\cp_objectives_events::stop_event(var_1);
}

get_far_away_startpath() {
  var_0 = scripts\engine\utility::getStruct("_encstr_9A7A176CDE739DF6F27D9B1D0BE43AAF43AC1BB419DEDDE664", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_BA38165F8FE5D5676329209C31AD70A9D198FB1947ABDBD7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_B23D126CDE3767BDBCEB6E3A582747F5192C5B62", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_BA171769DD66B8B88367C7C1B71B7DA91374508382D9B064FF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = [];
  var_4[var_4.size] = var_0;
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = var_2;
  var_4[var_4.size] = var_3;
  var_5 = 6000;
  var_6 = var_5 * var_5;
  var_7 = [];

  foreach(var_9 in var_4) {
    if(!scripts\cp\utility::any_player_nearby(var_9.origin, var_6)) {
      var_10 = strtok(var_9.targetname, "_encstr_BA4C02DF");
      var_11 = var_10[2];
      var_7[var_7.size] = var_11;
    }
  }

  if(var_7.size > 0)
    return scripts\engine\utility::random(var_7);
  else {
    var_13 = scripts\engine\utility::random(var_4);
    return var_13.targetname;
  }
}

first_intro_text() {
  if(!isDefined(level.convoy_proto_text))
    level.convoy_proto_text = 1;
  else
    return;

  wait 6;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_9755269003D70A87F93141DB8A3FF4E95FE93987349FC4E5738E5F6C5EC49801EF5AF4978578A9EF");
}

reset_convoy_soon() {
  wait 1;
  level thread spawn_convoy_and_drive();
}

get_proto_convoy_type() {
  if(!isDefined(level.convoy_proto_type))
    level.convoy_proto_type = 1;

  if(level.convoy_proto_type == 1) {
    level.convoy_proto_type = 2;
    return "_encstr_8F480E406FB958091E5A0807F5324561";
  } else if(level.convoy_proto_type == 2) {
    level.convoy_proto_type = 1;
    return "_encstr_A7670FB5AC19B4AEDAD2C9DB856B5ACD3B";
  }
}

get_proto_convoy_event() {
  if(!isDefined(level.convoy_proto_event)) {
    level.convoy_proto_event = "_encstr_96F31320FA333167BB3AB390311607282B6FB3B001";
    level.convoy_proto_index = "_encstr_A74C0222";
  }

  if(level.convoy_proto_event == "_encstr_96F31320FA333167BB3AB390311607282B6FB3B001") {
    level.convoy_proto_event = "_encstr_87F313603A84EB49FB590C8D17DFB0B5EB72585997";
    level.convoy_proto_index = "_encstr_A14C023B";
  } else if(level.convoy_proto_event == "_encstr_87F313603A84EB49FB590C8D17DFB0B5EB72585997") {
    level.convoy_proto_event = "_encstr_96F31320FA333167BB3AB390311607282B6FB3B001";
    level.convoy_proto_index = "_encstr_A74C0222";
  }
}

convoy_go_to_helidown_location() {
  wait 1;

  if(getdvarint("_encstr_9B5510E6B139F5D8DBB9D9BDF2AF27ED586B", 0) != 0) {
    return;
  }
  var_0 = (6885.69, -8717.95, 440);
  var_1 = (6897.75, -11041.2, 440);
  var_2 = (6889.89, -12625.3, 440);
  var_3 = [];
  var_4 = set_convoy_path_from_helidown();
  var_5 = (0, 0, 0);

  if(var_4 == "_encstr_95A00AD3BB59FA0C18B3CDC2")
    var_5 = (-10619.5, 14275, 511.782);
  else if(var_4 == "_encstr_A2A00A862BC65A19F6773733") {
    var_3[var_3.size] = var_0;
    var_3[var_3.size] = var_1;
    var_3[var_3.size] = var_2;
    var_5 = (8948.84, -13110.5, 440);
  }

  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-200);
  wait 0.05;
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_convoy_target(var_5, var_3);
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] waittill("_encstr_B44117C6F0686EE2B3B787331553BBB5E05EFE8B6E50057B0D");
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_unload_at_target(1);
  level thread convoy_attempt_pickup();
}

convoy_attempt_pickup() {
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_convoy_target("_encstr_BEF6186B7BF29008EFAC11489487C0588BB3D3E1474BEB10E783");

  if(level.event_heli_type == "_encstr_8C440795DC8DED271D") {
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_recruiting_distance(8000);
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(25);
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(2000);
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(1);
  } else {
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_recruiting_distance(4000);
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(12);
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(1000);
    level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(0);
  }

  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] waittill("_encstr_8CEE121FB74D60782F31B07BEB37A028A903ABB9");
  var_0 = level.all_convoys["_encstr_BAA80819AD16C8C8134E"] scripts\cp\cp_convoy_manager::get_convoy_targeted_hvt();
  var_0 childthread convoy_set_can_pickup_hvt();
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread convoy_send_out_after_hvt_onboard();
}

set_convoy_path_from_helidown() {
  var_0 = undefined;

  if(isDefined(level.last_helidown_loc)) {
    var_1 = level.last_helidown_loc;
    var_2 = var_1.script_noteworthy;

    if(var_2 == "_encstr_85B60699AFC89F5E")
      var_0 = "_encstr_95A00AD3BB59FA0C18B3CDC2";
    else if(var_2 == "_encstr_ADB6060167EA707A")
      var_0 = "_encstr_A2A00A862BC65A19F6773733";
  } else if(getdvarint("_encstr_A65C114B609DA1D3C151093CF8AB83F9F96832") > 0) {
    var_3 = getdvarint("_encstr_A65C114B609DA1D3C151093CF8AB83F9F96832");

    if(var_3 == 2)
      var_0 = "_encstr_95A00AD3BB59FA0C18B3CDC2";
    else if(var_3 == 3)
      var_0 = "_encstr_A2A00A862BC65A19F6773733";
  } else if(getDvar("_encstr_91BF0FB9C69C7DB237D8B7C91DBED8DE6C", "_encstr_B40101") != "_encstr_B40101") {
    var_3 = getDvar("_encstr_91BF0FB9C69C7DB237D8B7C91DBED8DE6C");
    var_4 = strtok(var_3, "_encstr_BA4C02DF");
    var_3 = var_4[0];

    if(var_3 == "_encstr_A74C0222")
      var_0 = "_encstr_95A00AD3BB59FA0C18B3CDC2";
    else if(var_3 == "_encstr_A14C023B")
      var_0 = "_encstr_A2A00A862BC65A19F6773733";
  }

  return var_0;
}

convoy_set_can_pickup_hvt() {
  if(!isDefined(self.tracking_time_to_pickup))
    self.tracking_time_to_pickup = 1;
  else
    return;

  if(level.event_heli_type != "_encstr_8C440795DC8DED271D")
    childthread convoy_set_helidown_pickup_hvt("_encstr_BEBA0860360273C54B4F");
  else
    childthread convoy_set_helidown_pickup_hvt("_encstr_8C440795DC8DED271D");
}

convoy_set_helidown_pickup_hvt(var_0) {
  if(var_0 == "_encstr_BEBA0860360273C54B4F") {
    if(!isDefined(self.carried))
      level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");
  } else if(var_0 == "_encstr_8C440795DC8DED271D") {
    if(!isDefined(self.followingplayer))
      self waittill("_encstr_B1DA09D3DB3FF1756059F7");
  }

  wait 5;
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  level thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(1);
}

convoy_send_out_after_hvt_onboard() {
  self waittill("_encstr_B2371C528850B3B5B8C7E5F04338FC0B0C26CA8A73BDEBE1C8B31BFB4340");
  thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-1000);
  wait 0.05;
  var_0 = (-4909.5, -9203.03, 576);
  thread scripts\cp\cp_convoy_manager::set_convoy_target(var_0);
}

waittill_morales_ends_delete_trucks() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 10;
  level waittill("_encstr_A9ED14D2BD5AF317D8F7C1E3CCDFB028E6612609F529");
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  level.all_convoys["_encstr_BAA80819AD16C8C8134E"] thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
  level thread scripts\cp\cp_objectives_events::stop_event("_encstr_87F313603A84EB49FB590C8D17DFB0B5EB72585997");
}