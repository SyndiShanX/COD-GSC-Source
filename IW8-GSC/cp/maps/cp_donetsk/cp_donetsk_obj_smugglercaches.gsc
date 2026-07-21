/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_obj_smugglercaches.gsc
****************************************************************/

smugglercache_init() {
  init_building_num();
  level._id_11F66 = 0;
  level._id_11F65 = 0;
  scripts\engine\utility::flag_init("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");
}

init_tripwires() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  wait 3;
  level tripwire_randomize();
  scripts\cp_mp\tripwire::init();
}

register_smugglercache_objective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  smugglercache_init();
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  var_0 = scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("_encstr_8DD40BAF059011477FB95AB283", ::obj_maj_cache_init, ::obj_maj_cache_start, ::obj_maj_cache_end, ::debugbeatobjective, ::debug_start_caches);
  [[var_0]]("_encstr_8DD70FAF059011477FB95AB283588717A8", ::obj_maj_advance_init, ::obj_maj_advance_start, ::obj_maj_advance_end, ::debugbeatobjective);
  [[var_0]]("_encstr_A66A11104AF4CF19FFE3B33DEBDF20739E9278", ::obj_maj_leads_init, ::obj_maj_leads_start, ::obj_maj_leads_end, ::debugbeatobjective);
  [[var_0]]("_encstr_87D70F7BC4A6F53658D80D2BCDAFC8ACCC", ::obj_maj_defense_init, ::obj_maj_defense_start, ::obj_maj_defense_end, ::debugbeatobjective);
  [[var_0]]("_encstr_9AD70FF7A6D8EF564B98FA22F0DF0FF3B1", ::obj_maj_extract_init, ::obj_maj_extract_start, ::obj_maj_extract_end, ::debugbeatobjective);

  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_93580C1B837DB9DAAECED936B239")
    [[var_0]]("_encstr_A196107F3E40779DEBA0A219C805D7677814");

  level thread register_spawn_functions();
}

obj_maj_cache_init(var_0) {
  level._id_139B5 = 1;
  level.global_stealth_broken = 0;
  level thread spawn_intro_soldiers();
  level thread play_intro_vo();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
}

obj_maj_cache_start(var_0) {
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
  level thread init_tripwires();
  level thread setup_comms_obj_a_goals_and_cover();
  level thread _id_131F0();
  level.initlocationcircle = "_encstr_8CC50D1BB0D8D0596EFADB989AD7CC";
  level.initlethalmaxoffsetmap = "_encstr_8CC50D1BB0D8D0596EFADB989AD7CC";
  level waittill("_encstr_99FF0E6CF89042DA88CDA76FC148128D");
}

obj_maj_cache_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_8DD70FAF059011477FB95AB283588717A8", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

obj_maj_advance_init(var_0) {
  level thread scripts\cp\cp_objectives::reset_objective_timers();
  level.obj_found_lead_here_vo = 0;
  level.obj_enemy_incoming_vo = undefined;
  level._id_139B5 = 1;
}

obj_maj_advance_start(var_0) {
  var_1 = get_building_loc();
  var_2 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  switch (get_cache_num()) {
    case 1:
      objective_setdescription(var_0.objectiveindex, &"_encstr_97011807A9A8314D511D3FF57541E7488E35EF87F974587639A5");
      break;
    case 3:
    case 2:
      objective_setdescription(var_0.objectiveindex, &"_encstr_B623197581F936331DC1BFA13756401FFA7C504E5999AFCE0F5F52");
      thread scripts\cp\utility::objective_update("_encstr_91DC10ED89537DB1586C0D2B9BEB85C8B38C", undefined, undefined, undefined, 1);
      break;
    case 4:
      objective_setdescription(var_0.objectiveindex, &"_encstr_A623198F016EDB583B344FB50D1D369F95B9870F39E701B0EFDD5A");
      thread scripts\cp\utility::objective_update("_encstr_8FDC1028D8A2616B1F3630CFFB080FA44DDF", undefined, undefined, undefined, 1);
      break;
  }

  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_0.objectiveindex, &"_encstr_B8DD1D33EB66FA1DCB171D90DF35FA047E52EFB1042BF1853D1FEFFFF7204F");
  objective_setlocation(var_0.objectiveindex, 0, var_2.origin);
  level thread scripts\cp\cp_objectives::_id_1317E(var_0, var_2.origin);
  objective_sethot(var_0.objectiveindex, 0);
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);

  if(get_cache_num() == 1)
    level thread _id_13557();

  level approach_building_wait(var_2.origin);
}

obj_maj_advance_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_A66A11104AF4CF19FFE3B33DEBDF20739E9278", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

obj_maj_leads_init(var_0) {
  var_1 = get_cache_num(1);

  if(var_1 != "_encstr_A34C02BB") {
    level.obj_leads_total_size = undefined;
    level thread handle_leads_creation("_encstr_AC4C024A");
  }

  if(level.obj_cache_num == 1)
    level wait_for_first_lead_pickup(var_0);

  level thread highlight_leads_in_fov_init();
  level thread handle_leads_text();
}

obj_maj_leads_start(var_0) {
  var_1 = get_cache_num(1);
  var_2 = get_building_loc();
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_1 == "_encstr_A34C02BB") {
    var_3 = scripts\engine\utility::getStruct("_encstr_AFC50D4F030E3ADD28467D06D871B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = scripts\engine\utility::getStruct("_encstr_A9C50D1BC28D0D5937BEF6899AD746", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = scripts\engine\utility::getStruct("_encstr_8CC50D1BB0D8D0596EFADB989AD7CC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level thread setup_bot_hq(var_0, "_encstr_A34C02BB");
    level thread setup_bot_hq(var_0, "_encstr_A74C0222");
    level thread setup_bot_hq(var_0, "_encstr_A14C023B");
  } else
    var_3 = scripts\engine\utility::getStruct(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_3))
    objective_setlocation(var_0.objectiveindex, 0, var_3.origin);

  if(isDefined(var_4))
    objective_setlocation(var_0.objectiveindex, 1, var_4.origin);

  if(isDefined(var_5))
    objective_setlocation(var_0.objectiveindex, 2, var_5.origin);

  objective_setlabel(var_0.objectiveindex, &"_encstr_82211ADF291F534067547040ED891D3775FAE195A3B9D95117D0E59F");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level thread handle_hints_vo();
  var_1 = get_cache_num(1);

  if(var_1 == "_encstr_A74C0222" || var_1 == "_encstr_A14C023B")
    level thread _id_123C7();

  if(var_1 == "_encstr_A74C0222" || var_1 == "_encstr_A14C023B" || var_1 == "_encstr_AC4C024A")
    level thread spawn_trickle_soldiers(var_1);

  if(var_1 == "_encstr_AC4C024A")
    level thread play_approach_tripwire_building();

  level waittill(var_2 + "_encstr_9568074F7F324DD073");
}

obj_maj_leads_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_87D70F7BC4A6F53658D80D2BCDAFC8ACCC", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

obj_maj_defense_init(var_0) {
  level notify("_encstr_AB48103FB8D9D0EA7FF5974F700FB36143B8");
  level._id_139B5 = 1;
}

obj_maj_defense_start(var_0) {
  var_1 = get_cache_num(1);
  level.obj_def_time = get_building_def_time();
  var_2 = level.obj_def_time;
  var_3 = int(level.obj_def_time * 0.66);
  var_4 = int(level.obj_def_time * 0.33);
  thread scripts\cp\utility::objective_update("_encstr_87D70F7BC4A6F53658D80D2BCDAFC8ACCC", level.obj_def_time, var_3, var_4, 1);
  var_5 = get_wave_name();
  level thread scripts\cp\cp_wave_spawning::killstreaks(11, var_5);
  level thread keycardlocs(var_1, 15);
  level thread play_enemy_incoming(9);
  var_6 = get_building_loc();
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(var_1 == "_encstr_A34C02BB") {
    var_7 = scripts\engine\utility::getStruct("_encstr_AFC50D4F030E3ADD28467D06D871B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_8 = scripts\engine\utility::getStruct("_encstr_A9C50D1BC28D0D5937BEF6899AD746", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_9 = scripts\engine\utility::getStruct("_encstr_8CC50D1BB0D8D0596EFADB989AD7CC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level thread killprojectileafterdelay();
  } else
    var_7 = scripts\engine\utility::getStruct(var_6, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_7))
    objective_setlocation(var_0.objectiveindex, 0, var_7.origin);

  if(isDefined(var_8))
    objective_setlocation(var_0.objectiveindex, 1, var_8.origin);

  if(isDefined(var_9))
    objective_setlocation(var_0.objectiveindex, 2, var_9.origin);

  objective_setbackground(var_0.objectiveindex, 2);
  objective_sethot(var_0.objectiveindex, 0);
  objective_setlabel(var_0.objectiveindex, &"_encstr_9B1C17E3F16E6E6F611570F885A3F680CA9919F9F71CB54B13");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level.obj_cache_def = 1;
  level.obj_def_cur_time = level.obj_def_time;
  scripts\cp\utility::_id_123FE("_encstr_A29318D6D5E6BEB11CD79BAD57D99DC6ACC9BE37ABC9B34B9D59");
  level thread _id_11E0F();

  while(level.obj_def_cur_time > 0) {
    wait 1;
    level.obj_def_cur_time = level.obj_def_cur_time - 1;
  }
}

obj_maj_defense_end(var_0) {
  level thread stop_leads_texts();
  level thread delete_all_leads();
  level.obj_cache_def = 0;
  level.obj_def_time = undefined;
  level notify("_encstr_85C40B3B13EF77B15D25FBF95B");
  level notify("_encstr_849A189DF887F13F278BA279E67A48CB47984B48F7F008F20592");
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  level play_investigation_done();
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");

  if(level.obj_cache_num < 4) {
    if(level.obj_cache_num == 1) {
      iterate_building_num(3);
      scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_838F0806EE826101F766", ["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD"]);
    } else if(level.obj_cache_num == 2)
      iterate_building_num(2);
    else
      iterate_building_num();

    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    reset_totals_texts();
    level thread scripts\cp\cp_objectives::run_objective("_encstr_8DD70FAF059011477FB95AB283588717A8", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
    scripts\cp\utility::_id_123FE("_encstr_823C19ADFB6708B882C77753F5AF5069C763DEAB3387D4F0DDEFFD");
  } else {
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_9A0A0FDB134DFA47573BAFED33D7DD584E");
    scripts\mp\brclientmatchdata::getprophealth("_encstr_8A12071CD08B1F423B");
    level._id_139B5 = 0;
    scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_BE570936C2C6A1B2F5C885", ["_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9", "_encstr_A3990BDBEF05B561FA5A488BD8"]);
    reset_totals_texts();
    level notify("_encstr_ACA914F77398EF73D803E8BF22571377BA77D9412BCD");
    level thread getcircleindexforpoint();
    scripts\cp\utility::_id_123FE("_encstr_BD3C19ADEAB9D78DE0EB6EB5BA3BB3B1CAC9D73A39856756B1BE99");
  }
}

getcircleindexforpoint() {
  var_0 = level._id_11F66;
  var_1 = int(level._id_11F66 * 0.7);
  waitframe();

  if(level._id_11F65 == var_0)
    scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");

  waitframe();

  if(level._id_11F65 >= var_1)
    scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

obj_maj_extract_init(var_0) {}

obj_maj_extract_start(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_99CF1A1A1038EFEFB2EB2A20D12340524D062329FB1E67F2F89A217F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("_encstr_99CF1A1A1038EFEFB2EB2A20D12340524D062329FB1E67F2F89A217F");
  waitframe();
  level notify("_encstr_91750BE60B41C076B37326D770", var_1.origin);
  level thread play_extract_reminders();
  level waittill("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
}

obj_maj_extract_end(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++)
    level.players[var_1].ability_invulnerable = 1;

  wait 1;
  level play_mission_complete();
  wait 1.5;
  wait 3;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

debugbeatobjective(var_0) {
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
}

init_building_num() {
  level.obj_cache_num = 1;
}

iterate_building_num(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  level.obj_cache_num = level.obj_cache_num + var_0;
}

get_cache_num(var_0) {
  var_1 = level.obj_cache_num;

  if(istrue(var_0))
    return scripts\engine\utility::string(var_1);
  else
    return var_1;
}

get_building_loc() {
  return "_encstr_87100C8D16D834B2B9F5F6984DEB" + get_cache_num(1);
}

get_hint_timer() {
  if(!isDefined(level.obj_leads_hint_timer))
    level.obj_leads_hint_timer = 50;

  return level.obj_leads_hint_timer;
}

decrease_hint_timer() {
  if(!isDefined(level.obj_leads_hint_timer))
    level.obj_leads_hint_timer = 50;

  if(level.obj_leads_hint_timer > 33)
    level.obj_leads_hint_timer = level.obj_leads_hint_timer - 3;
}

get_building_def_time() {
  var_0 = get_cache_num(0);
  var_1 = 0;
  var_2 = 0;
  var_2 = level.obj_leads_found_good * 45;

  switch (var_0) {
    case 1:
      var_1 = 720;
      break;
    case 4:
      var_1 = 270;
      break;
  }

  var_1 = var_1 - var_2;
  var_3 = getdvarint("_encstr_860710E76362014677DAE87121078798FFFC", 0);

  if(var_3 != 0) {
    var_1 = var_3;

    if(var_1 < 10)
      var_1 = 10;
  }

  return var_1;
}

get_wave_name() {
  var_0 = undefined;

  switch (get_cache_num(0)) {
    case 3:
    case 2:
    case 1:
      var_0 = "_encstr_A1E00F077D05878709583B695870A3F280";
      break;
    case 4:
      var_0 = "_encstr_ADEF0D1F2D6D84F8E790A1F11F5B10";
      break;
  }

  return var_0;
}

get_building_support_time() {
  var_0 = 0;

  switch (get_cache_num(0)) {
    case 1:
      var_0 = 40;
      break;
    case 3:
    case 2:
      var_0 = 30;
      break;
    case 4:
      var_0 = 20;
      break;
  }

  return var_0;
}

get_num_ambient() {
  var_0 = 0;

  switch (get_cache_num(0)) {
    case 1:
      var_0 = 12;
      break;
    case 3:
    case 2:
      var_0 = 15;
      break;
    case 4:
      var_0 = 18;
      break;
  }

  return var_0;
}

approach_building_wait(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 825;

  if(level.obj_cache_num == 4)
    var_2 = 2200;

  var_3 = var_2 * var_2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_3)) {
      return;
    }
    wait 0.25;
  }
}

play_bonus_time_sound() {
  if(soundexists("_encstr_979719DB5941667FF14082EA6B404B5F18E96F228F102B4730B3DF")) {
    foreach(var_1 in level.players)
    var_1 playlocalsound("_encstr_979719DB5941667FF14082EA6B404B5F18E96F228F102B4730B3DF");
  }
}

update_leads_timer(var_0) {
  var_1 = level.obj_def_time;
  var_2 = undefined;

  if(level.obj_def_cur_time - var_0 <= 0) {
    if(level.obj_def_cur_time > 5)
      level.obj_def_cur_time = 5;
    else
      return;
  } else
    level.obj_def_cur_time = level.obj_def_cur_time - var_0;

  var_2 = level.obj_def_cur_time;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 1;

  if(var_2 < var_1 * 0.33 - var_5) {
    var_3 = var_2 - 1;
    var_4 = var_2 - 2;
  } else if(var_2 < var_1 * 0.66 - var_5) {
    var_3 = var_2 - 1;
    var_4 = int(var_1 * 0.33);
  } else {
    var_3 = int(var_1 * 0.66);
    var_4 = int(var_1 * 0.33);
  }

  thread scripts\cp\utility::objective_update("_encstr_87D70F7BC4A6F53658D80D2BCDAFC8ACCC", var_2, var_3, var_4, 1);
}

handle_leads_creation(var_0, var_1) {
  level.obj_leads_found = 0;

  if(scripts\engine\utility::flag_exist("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD"))
    scripts\engine\utility::flag_clear("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");

  var_2 = get_leads_type(int(var_0));

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = scripts\engine\utility::getStructArray("_encstr_8AE2148718A59F0F28AF18684FCF7052D561A38F79D1" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStructArray("_encstr_814910409D0A90369A91F0C549D812D75191" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\engine\utility::getStructArray("_encstr_961913B896AAB7696177B0C09FB7812D72FF27B5A1" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_7 in var_4) {
    if(isDefined(var_7.script_side) && var_7.script_side != var_2)
      var_4 = scripts\engine\utility::array_remove(var_4, var_7);
  }

  foreach(var_7 in var_3) {
    if(isDefined(var_7.script_side) && var_7.script_side != var_2)
      var_3 = scripts\engine\utility::array_remove(var_3, var_7);
  }

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_11 = 9;
  var_12 = 1;

  if(var_4.size < var_11) {}

  if(get_cache_num(0) == 4) {
    var_11 = var_11 + 2;
    level.print_leads_text_max = 12;
  } else
    level.print_leads_text_max = 10;

  var_13 = 0;

  if(var_5.size > 0) {
    for(var_14 = 0; var_14 < var_5.size; var_14++) {
      level thread spawn_lead_model(var_5[var_14], "_encstr_84FD081FB5C02CC7C5EB", var_0);
      var_13++;
    }

    var_11 = var_11 - var_13;
  }

  for(var_14 = 0; var_14 < var_11; var_14++)
    level thread spawn_lead_model(var_4[var_14], "_encstr_813008928DA89D31A8CA", var_0);

  for(var_14 = 0; var_14 < var_12; var_14++)
    level thread spawn_lead_model(var_3[var_14], "_encstr_867205BF07A0C7", var_0);

  var_15 = 0;

  if(isDefined(level.obj_leads_total_size))
    var_15 = level.obj_leads_total_size;

  level.obj_leads_total_size = var_11 + var_12 + var_13 + var_15;
  level waittill("_encstr_8DB00D373816EECD958CEB362BB019");

  while(level.obj_leads_models.size < level.obj_leads_total_size)
    waitframe();

  level thread give_one_lead_to_each_player(level.obj_leads_models);
  scripts\engine\utility::flag_set("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");
}

wait_for_first_lead_pickup(var_0) {
  scripts\engine\utility::flag_wait("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");

  for(var_1 = 0; var_1 < level.obj_leads_models.size; var_1++)
    level.obj_leads_models[var_1] makeunusable();

  var_2 = undefined;
  var_3 = scripts\engine\utility::getStructArray("_encstr_BD7611A70D98195F67B162BA1EC99F4E238F70", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    if(var_5.script_side == "_encstr_B49005512AF703") {
      var_2 = var_5;
      break;
    }
  }

  level.obj_leads_found_reg = 0;
  var_7 = level spawn_lead_model(var_2, "_encstr_813008928DA89D31A8CA", "_encstr_A34C02BB");
  var_8 = 0.5;

  foreach(var_10 in level.players)
  var_10 thread highlight_leads_loop(var_7, var_8);

  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_0.objectiveindex, &"_encstr_ACE2185B98873EB3FBD7249987620FF1B5C12D0E358499014F0D");
  objective_setlocation(var_0.objectiveindex, 0, var_7.origin + (0, 0, 12));
  objective_sethot(var_0.objectiveindex, 0);
  var_7 makeunusable();
  level waittill("_encstr_9A3810FF46D869863EDAE220F61D409B3223");
  objective_sethot(var_0.objectiveindex, 0);
  objective_setlabel(var_0.objectiveindex, &"_encstr_97D8168E77DF5125C74967B3A1DF8FB82567C5B0DA9BF877");
  level waittill("_encstr_8E920E28EAEA39A1EFA3C10FB2DA69C3");
  var_7 makeusable();
  objective_setlabel(var_0.objectiveindex, &"_encstr_A53414F0417F6A8F1F0CEFEC35C73EA6EBD90969B993");
  objective_sethot(var_0.objectiveindex, 0);
  level waittill("_encstr_821F0F6380E76461BF40C242CD9ACB1D39");
  level._id_13E9F = 1;

  for(var_1 = 0; var_1 < level.obj_leads_models.size; var_1++)
    level.obj_leads_models[var_1] makeusable();
}

get_leads_type(var_0) {
  var_1 = ["_encstr_AAA7064B8083F5B3", "_encstr_B49005512AF703"];
  var_2 = undefined;
  var_3 = level.obj_cache_num;

  if(isDefined(var_0))
    var_3 = var_0;

  switch (var_3) {
    case 1:
      var_2 = "_encstr_B49005512AF703";
      break;
    case 3:
    case 2:
      var_2 = "_encstr_AAA7064B8083F5B3";
      break;
    case 4:
      var_2 = "_encstr_B49005512AF703";
      break;
  }

  level.obj_leads_type = var_2;
  return var_2;
}

spawn_lead_model(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3 setModel(var_0.script_noteworthy);
  var_4 = var_0.angles;

  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_3.angles = var_4;
  var_3.type = var_1;
  waitframe();
  var_5 = &"_encstr_A719197169B9D7DC2FC724A9DDEB483F151081D9300397B447295D";
  var_3 setHintString(var_5);
  var_3 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_3 sethintdisplayrange(70);
  var_3 sethintdisplayfov(40);
  var_3 setuserange(70);
  var_3 setusefov(35);

  if(var_1 == "_encstr_84FD081FB5C02CC7C5EB")
    var_3 sethintdisplayfov(150);

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_AAEF05B83B43EB")
    var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  else
    var_3 sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_0.script_label))
    var_3.script_label = var_0.script_label;

  var_3 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_3 makeusable();
  var_3 thread lead_use_think(var_1, var_2);

  if(!isDefined(level.obj_leads_models))
    level.obj_leads_models = [];

  level.obj_leads_models[level.obj_leads_models.size] = var_3;
  level._id_11F66++;
  level notify("_encstr_8DB00D373816EECD958CEB362BB019");
  return var_3;
}

_id_13557() {
  level.obj_leads_total_size = undefined;
  level thread handle_leads_creation("_encstr_A34C02BB");
  level thread handle_leads_creation("_encstr_A74C0222");
  level thread handle_leads_creation("_encstr_A14C023B");
  scripts\engine\utility::flag_wait("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");
  wait 1;

  for(var_0 = 0; var_0 < level.obj_leads_models.size; var_0++)
    level.obj_leads_models[var_0] makeunusable();
}

lead_debug_show(var_0, var_1) {
  self endon("_encstr_A2E60BEA819FA3E19883233585");
  var_2 = (1, 0, 0);

  if(var_1 == "_encstr_867205BF07A0C7")
    var_2 = (0, 1, 0);

  for(;;)
    waitframe();
}

lead_use_think(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A2E60BEA819FA3E19883233585");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(var_2.isdeploying)) {
        continue;
      }
      if(istrue(var_2.listen_for_adrenaline_use)) {
        continue;
      }
      level thread collect_lead(self, var_0, var_2, var_1);
    }
  }
}

collect_lead(var_0, var_1, var_2, var_3) {
  var_4 = level.obj_cache_num;
  var_5 = var_0.origin;

  if(var_1 == "_encstr_813008928DA89D31A8CA" || var_1 == "_encstr_84FD081FB5C02CC7C5EB")
    level thread play_find_lead(var_2);
  else if(var_1 == "_encstr_867205BF07A0C7")
    level thread play_find_lead_good(var_2);

  var_2.listen_for_adrenaline_use = 1;
  var_0 makeunusable();

  if(var_2 scripts\cp\utility::playerplaytakephotoanim() == 0) {
    var_0 makeusable();

    if(isDefined(var_2) && isPlayer(var_2))
      var_2.listen_for_adrenaline_use = undefined;

    return;
  }

  level.obj_leads_found++;
  level._id_11F65++;

  if(var_1 == "_encstr_813008928DA89D31A8CA" || var_1 == "_encstr_84FD081FB5C02CC7C5EB") {
    level.obj_leads_found_reg++;
    level thread play_find_lead(undefined, var_4);
  } else if(var_1 == "_encstr_867205BF07A0C7") {
    level.obj_leads_found_good++;
    level thread play_find_lead_good(undefined, var_4);
  }

  if(isDefined(level.obj_def_time)) {
    level thread print_bonus_time_text(var_1, var_2);
    level thread play_bonus_time_sound();
    level thread update_leads_timer(30);
  }

  if(soundexists("_encstr_A7CC1316F76FE2B750807F7F58EE7C4AEB05915AFF")) {
    if(isent(var_0))
      var_0 playSound("_encstr_A7CC1316F76FE2B750807F7F58EE7C4AEB05915AFF");
    else
      playsoundatpos(var_5, "_encstr_A7CC1316F76FE2B750807F7F58EE7C4AEB05915AFF");
  }

  var_2 thread scripts\cp\drone\emp_drone::giverankxp("_encstr_B2A40EE1C613DFAA9991B24AC09F67A3", 50);
  var_2 thread _id_124DF();

  if(isent(var_0))
    var_0 remove_lead();

  level notify("_encstr_821F0F6380E76461BF40C242CD9ACB1D39", var_1, var_3);
  level thread _id_123E6();
  level.smuggler_last_collector = var_2;
}

_id_124DF() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 1;

  if(isDefined(self) && isPlayer(self))
    self.listen_for_adrenaline_use = undefined;
}

remove_lead() {
  playFX(level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"], self.origin);
  self notify("_encstr_A2E60BEA819FA3E19883233585");
  thread hasdonestartmusic();
  var_0 = scripts\engine\utility::array_find(level.obj_leads_models, self);

  if(isDefined(var_0) && isDefined(level.obj_leads_models[var_0].script_label))
    level.obj_leads_models[var_0].script_label = undefined;

  self makeusable();
  var_1 = &"_encstr_8684190D82D7A96AAA1DE862A29497C42A5011BE50982951A0882B";
  self setHintString(var_1);
  self setCursorHint("_encstr_B17F0EB9DFB67F4F0835FE7DDB812764");
  self sethinticon("_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118");
  self sethintdisplayfov(80);
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self hudoutlinedisable();
  self.is_collected = 1;
}

delete_all_leads() {
  foreach(var_1 in level.obj_leads_models) {
    level.obj_leads_models = scripts\engine\utility::array_remove(level.obj_leads_models, var_1);
    var_1 hasdonestartmusic();
    var_1 delete();
  }
}

give_one_lead_to_each_player(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].type == "_encstr_84FD081FB5C02CC7C5EB")
      var_1[var_1.size] = var_0[var_2];
  }

  if(var_1.size == 0) {
    return;
  }
  var_3 = 0;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(level.players[var_2].team == "_encstr_9A8507BA4040188D08") {
      associate_lead_with_player(var_1[var_3], level.players[var_2]);
      thread handle_associated_lead_disconnect(var_1[var_3], level.players[var_2]);
      thread handle_associated_lead_lookat(var_1[var_3], level.players[var_2]);
      var_3++;
    }
  }
}

associate_lead_with_player(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(level.players[var_2] != var_1) {
      var_0 hidefromplayer(var_1);
      continue;
    }

    var_0.associated_player = var_1;
  }
}

dissociate_from_player(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isent(var_0) && isPlayer(level.players[var_1]))
      var_0 showtoplayer(level.players[var_1]);
  }
}

handle_associated_lead_disconnect(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0) && isent(var_0))
    var_0 dissociate_from_player();
}

handle_associated_lead_lookat(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_A2180537ACAC73", var_2);

    if(var_2 != var_1) {
      continue;
    }
    dissociate_from_player(var_0);
    return;
  }
}

handle_leads_text() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_0 = get_building_loc();
  level.obj_leads_found_reg = 0;
  level.obj_leads_found_good = 0;
  level.print_leads_text_max = 3;
  print_total_leads_text(level.obj_leads_found);
  print_type_text(level.obj_leads_type);

  for(;;) {
    level waittill("_encstr_821F0F6380E76461BF40C242CD9ACB1D39", var_1);
    print_total_leads_text(level.obj_leads_found);
    print_type_text(level.obj_leads_type);

    if(level.obj_leads_found == level.obj_leads_total_size)
      level thread change_texts_green();

    if(level.obj_leads_found == 3)
      level thread collected_enough_leads(var_0);
  }
}

collected_enough_leads(var_0) {
  level notify(var_0 + "_encstr_9568074F7F324DD073");
}

print_total_leads_text(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = "_encstr_843A1B0D99808FFA77071B274F30A2E718E00796B3D16CF2D51B73D7F3";
      thread scripts\cp\utility::objective_update(var_1, undefined, undefined, undefined, undefined, var_0);
      break;
    case 12:
    case 11:
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      thread _id_12C63();
      break;
  }
}

print_type_text(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_AAA7064B8083F5B3":
      var_1 = "_encstr_9A791AEDC453D736C28D43599BBEB1B7638D59B11DBED197E056D713";
      break;
    case "_encstr_B49005512AF703":
      var_1 = "_encstr_AF791A804542C0F2A15B54F5AE816B02C470A1A10C1153B3F8B3D6DA";
      break;
  }

  thread scripts\cp\utility::objective_update(var_1);
}

print_bonus_time_text(var_0, var_1) {
  var_2 = &"_encstr_918B1C0D14BEA9A6551D3A98A29297C45405886AFA097A9C5535BE49158E";
  var_3 = 30;
  var_1 thread scripts\cp\cp_hud_message::tutorialprint(var_2, 3.75);
}

fade_text_over_time(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_2))
    var_2 = 0.2;

  if(isDefined(var_3))
    wait(var_3);

  if(var_1 <= 0)
    var_1 = 0.1;

  var_0.alpha = 1;
  var_4 = var_2 / var_1;

  for(var_5 = 1; var_5 > 0; var_5 = var_5 - var_4) {
    var_0.alpha = var_5;
    wait(var_2);
  }

  var_0.alpha = 0;
}

change_texts_green() {
  if(isDefined(level.obj_hud_text_leadstotal)) {
    level.obj_hud_text_leadstotal.color = (0, 1, 0);
    level.obj_hud_text_leadstotal thread fade_text_over_time(level.obj_hud_text_leadstotal, 4, undefined, 6);
  }

  if(isDefined(level.obj_hud_text_type)) {
    level.obj_hud_text_type.color = (0, 1, 0);
    level.obj_hud_text_type thread fade_text_over_time(level.obj_hud_text_type, 4, undefined, 6);
  }

  thread reset_totals_texts();
}

reset_totals_texts() {
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_9A791AEDC453D736C28D43599BBEB1B7638D59B11DBED197E056D713");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_AF791A804542C0F2A15B54F5AE816B02C470A1A10C1153B3F8B3D6DA");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_843A1B0D99808FFA77071B274F30A2E718E00796B3D16CF2D51B73D7F3");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_AD3A1B3A81FAAF0ED02780951FF9D6A711B81262EBD85B45100B8CA775");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_853A1B37634A40E8992608A1CA7F308082E3ABB753619DC0A4BE70FEE2");
}

_id_12C63() {
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_843A1B0D99808FFA77071B274F30A2E718E00796B3D16CF2D51B73D7F3");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_AD3A1B3A81FAAF0ED02780951FF9D6A711B81262EBD85B45100B8CA775");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_853A1B37634A40E8992608A1CA7F308082E3ABB753619DC0A4BE70FEE2");
}

stop_leads_texts() {
  if(isDefined(level.obj_hud_text_leadstotal))
    level.obj_hud_text_leadstotal destroy();

  if(isDefined(level.obj_hud_text_type))
    level.obj_hud_text_type destroy();
}

propchangeto() {
  var_0 = "_encstr_AFC50D4F030E3ADD28467D06D871B1";

  switch (level.obj_cache_num) {
    case 1:
      var_0 = "_encstr_AFC50D4F030E3ADD28467D06D871B1";
      break;
    case 2:
      var_0 = "_encstr_A9C50D1BC28D0D5937BEF6899AD746";
      break;
    case 3:
      var_0 = "_encstr_8CC50D1BB0D8D0596EFADB989AD7CC";
      break;
    case 4:
      var_0 = "_encstr_B1C50D1B0BC6A156B9FADB4C35EB43";
      break;
  }

  return var_0;
}

setup_comms_obj_a_goals_and_cover() {
  var_0 = 600;
  var_1 = scripts\engine\utility::getStruct("_encstr_B1C50D1B0BC6A156B9FADB4C35EB43", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = createnavbadplacebybounds(var_1.origin, (var_0, var_0, var_0), (0, 0, 0));
  level waittill("_encstr_85C40B3B13EF77B15D25FBF95B");
  destroynavobstacle(var_2);
}

highlight_leads_in_fov_init() {
  foreach(var_1 in level.players)
  var_1 thread highlight_leads_in_fov_player();
}

highlight_leads_in_fov_player() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 0.5;
  scripts\engine\utility::flag_wait("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");

  for(;;) {
    var_1 = level.obj_leads_models;
    thread highlight_leads_loop(var_1, var_0);
    level waittill("_encstr_821F0F6380E76461BF40C242CD9ACB1D39");
  }
}

setup_bot_hq(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = undefined;
  var_3 = 10;

  if(var_1 == "_encstr_AC4C024A")
    var_3 = 12;

  var_4 = 0;
  var_5 = undefined;

  switch (var_1) {
    case "_encstr_A34C02BB":
      var_5 = 0;
      break;
    case "_encstr_A74C0222":
      var_5 = 1;
      break;
    case "_encstr_A14C023B":
      var_5 = 2;
      break;
  }

  if(!isDefined(var_5)) {
    return;
  }
  scripts\engine\utility::flag_wait("_encstr_AAC612DC07B0EEE62B19D70B1BB1F5D859B019CD");

  for(;;) {
    level waittill("_encstr_821F0F6380E76461BF40C242CD9ACB1D39", var_6, var_2);

    if(isDefined(var_2) && var_2 == var_1)
      var_4++;

    if(var_4 >= var_3)
      objective_unsetlocation(var_0.objectiveindex, var_5);
  }
}

highlight_leads_loop(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  level endon("_encstr_821F0F6380E76461BF40C242CD9ACB1D39");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = 120;
  var_3 = var_2 * var_2;

  if(!isarray(var_0)) {
    var_4 = var_0;
    var_0 = [var_4];
  }

  for(;;) {
    var_5 = self getEye();
    var_6 = self getplayerangles();

    for(var_7 = 0; var_7 < var_0.size; var_7++) {
      if(istrue(var_0[var_7].is_collected)) {
        continue;
      }
      if(distancesquared(var_5, var_0[var_7].origin) > var_3) {
        var_0[var_7] hudoutlinedisableforclient(self);
        continue;
      }

      if(scripts\engine\utility::within_fov(var_5, var_6, var_0[var_7].origin, var_1)) {
        var_0[var_7] hudoutlineenableforclient(self, "_encstr_B1C2167BABE8B196372BD72D378E56D87DB10B1CE8AB4ECA");

        if(isDefined(var_0[var_7].associated_player) && self == var_0[var_7].associated_player)
          var_0[var_7] notify("_encstr_A2180537ACAC73", self);

        continue;
      }

      var_0[var_7] hudoutlinedisableforclient(self);
    }

    waitframe();
  }
}

tripwire_randomize() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A99A0C5D1ACF639F2C5BA81061D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_A29A0C2BD803483BFC6352BB99BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray("_encstr_B19A0C701BB9C3275222051671AF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStructArray("_encstr_B49A0C8EE4960EEE2D4EAC37EB0D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = 0;
  var_5 = 3;
  var_6 = 4;
  var_7 = 18;
  var_8 = var_0.size - var_4;
  var_9 = var_1.size - var_5;
  var_10 = var_2.size - var_6;
  var_11 = var_3.size - var_7;

  for(var_12 = 0; var_12 < var_8; var_12++)
    remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_0[var_12].script_noteworthy, var_0[var_12]);

  for(var_12 = 0; var_12 < var_9; var_12++)
    remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_1[var_12].script_noteworthy, var_1[var_12]);

  for(var_12 = 0; var_12 < var_10; var_12++)
    remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_2[var_12].script_noteworthy, var_2[var_12]);

  for(var_12 = 0; var_12 < var_11; var_12++)
    remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_3[var_12].script_noteworthy, var_3[var_12]);
}

remove_from_struct_array(var_0, var_1, var_2) {
  if(isDefined(level.struct_class_names[var_0]) && isDefined(level.struct_class_names[var_0][var_1]) && scripts\engine\utility::array_contains(level.struct_class_names[var_0][var_1], var_2))
    level.struct_class_names[var_0][var_1] = scripts\engine\utility::array_remove(level.struct_class_names[var_0][var_1], var_2);
}

spawn_trickle_soldiers(var_0) {
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  wait 5;
  level._id_135A2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_85710FE6BD6319D2CA93BE36B01BD056AF" + var_0 + "_encstr_B81A09AF8E93968DB61B95");
}

keycardlocs(var_0, var_1) {
  wait(var_1);
  level.spawn_module_current = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_85710FE6BD6319D2CA93BE36B01BD056AF" + var_0);
}

wait_for_near_extract(var_0, var_1) {
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_2)) {
      break;
    }

    wait 0.5;
  }
}

spawn_intro_soldiers() {
  scripts\engine\utility::flag_wait("_encstr_842130B138EBDCDAD576D9C6AC9CD80B368656CDF5DCB79C4786FA6C4E5958A356AFE6C6C95AE0D17D8DDBD61C63B2A3ACC8");
  wait 0.5;
  level.spawn_module_intro = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_ABBF1333A5276E47D786ED5D9B56FAB3AB164E9137");
}

register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("_encstr_842130B138EBDCDAD576D9C6AC9CD80B368656CDF5DCB79C4786FA6C4E5958A356AFE6C6C95AE0D17D8DDBD61C63B2A3ACC8"))
    scripts\engine\utility::flag_init("_encstr_842130B138EBDCDAD576D9C6AC9CD80B368656CDF5DCB79C4786FA6C4E5958A356AFE6C6C95AE0D17D8DDBD61C63B2A3ACC8");

  scripts\engine\utility::flag_wait("_encstr_842130B138EBDCDAD576D9C6AC9CD80B368656CDF5DCB79C4786FA6C4E5958A356AFE6C6C95AE0D17D8DDBD61C63B2A3ACC8");
  scripts\cp\cp_destruction::destructible_interactions();
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\coop_stealth::coop_stealth_init();
  [[var_0]]("_encstr_ABBF1333A5276E47D786ED5D9B56FAB3AB164E9137", 10, 10, 10, 0.1, 0, "_encstr_ABBF1333A5276E47D786ED5D9B56FAB3AB164E9137", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_ABBF1333A5276E47D786ED5D9B56FAB3AB164E9137", ::_id_1320C);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_ABBF1333A5276E47D786ED5D9B56FAB3AB164E9137", scripts\cp\coop_stealth::regular_enemy_death_func);
  [[var_0]]("_encstr_A609105B8059E32C5065D7F35BB8B42F68F3", 10, 10, 30, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_A609105B8059E32C5065D7F35BB8B42F68F3", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_8A0910DB42039DE0FFD22757E9A630D5276F", 10, 10, 30, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_8A0910DB42039DE0FFD22757E9A630D5276F", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_839E18FFEF196A410853C1D629E098B278ADC77B7D33420B2899", 2, 5, 100, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_8A0910DB42039DE0FFD22757E9A630D5276F", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_840910A367F9EBC891324927DF51D969A787", 10, 10, 30, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_840910A367F9EBC891324927DF51D969A787", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_9356189B7BB132D2ACE4D7B1B0B186CAEB99AF3AE4D26C6D3695", 2, 5, 100, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_840910A367F9EBC891324927DF51D969A787", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_A7D70EB96C867BDBD8D7CEBA583919CD", 8, 10, 40, 0.1, 0, "_encstr_A7D70EB96C867BDBD8D7CEBA583919CD", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A7D70EB96C867BDBD8D7CEBA583919CD", ::_id_12EE9);
  [[var_0]]("_encstr_AD09106BD05A58E17FD3A111B9BAFBCD5975", 10, 10, 30, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_AD09106BD05A58E17FD3A111B9BAFBCD5975", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_BEA618A88F5CA1FB7282B8BE5ECA2149871A410853E119B78A6F", 3, 6, 100, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_AD09106BD05A58E17FD3A111B9BAFBCD5975", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_826C169B56E85F050129BA93B055BF5766CE180F7733BF8A", 6, 6, 6, 0.1, 0, "_encstr_826C169B56E85F050129BA93B055BF5766CE180F7733BF8A", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_826C169B56E85F050129BA93B055BF5766CE180F7733BF8A", undefined, 20000, 30000);
  setup_enemy_sentry(var_0, "_encstr_92AC126FF6BA0F1B617B0C3FD913170BA2F84E47");
  setup_enemy_sentry(var_0, "_encstr_87AC1267CD58D99FA771A27ADE05DF8E20AFDFA2");
  setup_enemy_sentry(var_0, "_encstr_86D312CB1F2B08F8A19BB19BBF893698C3B4118B");
  setup_enemy_sentry(var_0, "_encstr_A5D3128ECAC6D0BDF50786F2CDF536581B4359CC");
  setup_enemy_sentry(var_0, "_encstr_83D312EDBD57D03F31EBB03033D9DF09BF28FD45");
  setup_enemy_sentry(var_0, "_encstr_AFD31224359BC01F01974B33633148A7C6D8C8D3");
  setup_enemy_sentry(var_0, "_encstr_8BD3122C934044DFC863F2EBEB2017FEA811B5D5");
  setup_enemy_sentry(var_0, "_encstr_99D312D4FFDE901566F078C10B39F66FB838BDE4");
}

_id_12EE9(var_0) {
  var_1 = "_encstr_B62E15DF4EFC382F19174785E7A370B7615733338E1D37";
  thread _id_12EEA(var_1);
  thread _id_12EEC(var_1);
  thread _id_12EED(var_1);
}

_id_12EEC(var_0) {
  self endon(var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.aitype) || self.aitype != "_encstr_A11904E483B3") {
    return;
  }
  if(!isDefined(level._id_12EEB))
    level._id_12EEB = [];

  level._id_12EEB[level._id_12EEB.size] = self;

  if(!isDefined(level._id_12DCA)) {
    level._id_12DCA = getEntArray("_encstr_88AA12520A5FB91768C7A7EB1F415B7F2C7BCBAF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(level._id_12DCA) || level._id_12DCA.size == 0) {
      return;
    }
    foreach(var_2 in level._id_12DCA)
    var_2 thread _id_12DC9();
  }

  for(;;) {
    self waittill("_encstr_A1FC0C334B93ACAFC9389DAF85A3", var_4);
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    self setentitytarget(var_5, 1);
    var_6 = scripts\engine\utility::_id_143B9(5, "_encstr_938C091AC8B8AFFB036D37");
    self clearentitytarget();
    var_5 delete();
  }
}

_id_12DC9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_B83318F0E8C179AFABA5E7DBA769E31078829C8F1FF329D11E74");
  self endon("_encstr_B83318F0E8C179AFABA5E7DBA769E31078829C8F1FF329D11E74");
  level._id_11FA7 = undefined;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isDefined(level._id_12EEB) || level._id_12EEB.size == 0) {
      continue;
    }
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1 = sortbydistance(var_1, var_0.origin);
      level._id_12EEB = scripts\engine\utility::array_randomize(level._id_12EEB);
      var_2 = 0;

      foreach(var_4 in level._id_12EEB) {
        if(isDefined(var_4) && isalive(var_4)) {
          for(var_5 = 0; var_5 < var_1.size; var_5++) {
            var_6 = var_1[var_5];

            if(sighttracepassed(var_4.origin + (0, 0, 62), var_6.origin, 0, var_4, 0)) {
              var_4 notify("_encstr_A1FC0C334B93ACAFC9389DAF85A3", var_6);
              var_7 = var_4 getEye();
              var_8 = var_4 scripts\engine\utility::_id_143B9(5, "_encstr_938C091AC8B8AFFB036D37");

              if(isDefined(var_8) && var_8 == "_encstr_938C091AC8B8AFFB036D37")
                var_2 = 1;

              break;
            }
          }
        }

        if(var_2) {
          break;
        }

        waitframe();
      }
    }

    wait(randomintrange(6, 10));
  }
}

_id_12EEA(var_0) {
  self endon(var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1)) {
      self.script_origin_other = var_1.origin;
      scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
      var_2 = 128;

      if(isDefined(var_1.radius))
        var_2 = int(var_1.radius);

      for(;;) {
        scripts\cp\cp_modular_spawning::set_goal_radius(var_2);
        var_3 = 280;
        var_4 = 48;
        var_5 = scripts\cp\utility::get_closest_living_player(36000000);

        if(isDefined(var_5)) {
          var_6 = var_5.origin - self.origin;
          var_7 = length2dsquared(var_6) < var_3 * var_3;
          var_8 = abs(var_5.origin[2] - self.origin[2]) < var_4;

          if(var_7 && var_8) {
            self notify(var_0);
            return;
          }
        }

        wait 2;
      }
    }
  }
}

_id_12EED(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait 1;
  self waittill(var_0);
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(900);
  thread scripts\cp\cp_modular_spawning::prepdoorsforunload();
  level waittill("_encstr_85C40B3B13EF77B15D25FBF95B");

  while(scripts\cp\cp_modular_spawning::has_seen_any_player_recently())
    wait 0.5;

  scripts\cp\cp_modular_spawning::script_kill_ai();
}

setup_enemy_sentry(var_0, var_1) {
  [[var_0]](var_1, 6, 6, 6, 0.1, 0, var_1, ::watchforstopwaves, undefined, undefined);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, var_1);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(var_1, undefined, 20000, 30000);
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_849A189DF887F13F278BA279E67A48CB47984B48F7F008F20592");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

stopwaveandstartthisone(var_0) {
  level notify("_encstr_849A189DF887F13F278BA279E67A48CB47984B48F7F008F20592");
  wait 0.5;
  [[var_0]]();
}

_id_1320C(var_0, var_1) {
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

spawn_support_wave_handler() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_0 = get_cache_num(1);
  var_1 = get_building_support_time();
  var_2 = 0;
  var_3 = get_num_ambient();

  for(;;) {
    var_4 = level scripts\engine\utility::_id_143BA(var_1, "_encstr_821F0F6380E76461BF40C242CD9ACB1D39", "_encstr_AB48103FB8D9D0EA7FF5974F700FB36143B8");

    if(var_4 == "_encstr_995408F398012F656821" || var_4 == "_encstr_AB48103FB8D9D0EA7FF5974F700FB36143B8") {
      if(var_4 == "_encstr_AB48103FB8D9D0EA7FF5974F700FB36143B8")
        wait 10;

      return;
    }
  }
}

_id_12DF9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_0 = get_cache_num(1);

  if(var_0 == "_encstr_A34C02BB") {
    level thread play_vo_delay("_encstr_999C2F1428C1AE9F083FC90673325FF387FE78471F9A3F458BCF9193BCD72897BBBDDD59D7F7732806B7455CC5AC79CF98");
    level thread _id_12DD5("_encstr_92AC126FF6BA0F1B617B0C3FD913170BA2F84E47");
    level thread _id_12DD5("_encstr_87AC1267CD58D99FA771A27ADE05DF8E20AFDFA2");
    wait 60;
    level thread _id_12DD5("_encstr_A5D3128ECAC6D0BDF50786F2CDF536581B4359CC");
    level thread _id_12DD5("_encstr_83D312EDBD57D03F31EBB03033D9DF09BF28FD45");
    level thread watchbrc130airdropchuteanimend();
  } else if(var_0 == "_encstr_A74C0222" || var_0 == "_encstr_A14C023B") {
    level thread _id_12DD5("_encstr_86D312CB1F2B08F8A19BB19BBF893698C3B4118B");
    level thread _id_12DD5("_encstr_A5D3128ECAC6D0BDF50786F2CDF536581B4359CC");
    level thread watchbrc130airdropchuteanimend();
  } else if(var_0 == "_encstr_AC4C024A") {
    level thread _id_12E01("_encstr_AFD31224359BC01F01974B33633148A7C6D8C8D3", 45, 2);
    level thread _id_12E01("_encstr_8BD3122C934044DFC863F2EBEB2017FEA811B5D5", 45, 2);
    level thread _id_12E01("_encstr_99D312D4FFDE901566F078C10B39F66FB838BDE4", 100, 2);
  }
}

_id_12DEB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_0 = get_cache_num(1);

  if(var_0 == "_encstr_AC4C024A") {
    for(;;) {
      var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_826C169B56E85F050129BA93B055BF5766CE180F7733BF8A");
      wait 45;
      _id_143A0(18);
    }
  }
}

_id_143A0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = 0;
    var_2 = 0;

    if(!isDefined(level.agentarray)) {
      break;
    }

    foreach(var_4 in level.agentarray) {
      if(isDefined(var_4.isactive) && var_4.isactive)
        var_1++;

      if(isDefined(var_4.never_kill_off) && var_4.never_kill_off)
        var_2++;
    }

    if(var_1 < var_0) {
      break;
    }

    wait 1;
  }
}

_id_12DE5() {
  var_0 = get_cache_num(1);

  if(var_0 == "_encstr_AC4C024A")
    var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7D70EB96C867BDBD8D7CEBA583919CD");
}

watchbrc130airdropchuteanimend() {
  wait 10;
  level thread _id_12DD5("_encstr_83D312EDBD57D03F31EBB03033D9DF09BF28FD45");
}

_id_12E01(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_3 = 30;

  if(isDefined(var_1))
    wait(var_1);

  for(var_4 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0); var_3 > 0; var_3--) {
    if(isDefined(var_4.module_vehicles[0]) && isent(var_4.module_vehicles[0])) {
      break;
    }

    wait 1;
  }

  if(var_3 <= 0) {
    return;
  }
  var_5 = var_4.module_vehicles[0];
  var_5 thread _id_14350();

  if(isDefined(var_2) && var_2 > 0)
    var_5 thread _id_12CAE(var_4, var_0, var_2);

  var_5 scripts\engine\utility::_id_143A5("_encstr_A9210A283BEC90BB323450EC", "_encstr_AD75063D571AE108");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);
}

_id_12CAE(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_3 = scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_BD82096B5DA4B07F924F29");
  var_4 = self.origin;

  if(isDefined(var_3) && var_3 == "_encstr_AD75063D571AE108") {
    wait 1;

    if(isDefined(var_0) && isDefined(var_0.ai_spawned)) {
      var_5 = 0;

      foreach(var_7 in var_0.ai_spawned) {
        if(isDefined(var_7) && isalive(var_7) && !var_7 scripts\engine\utility::doinglongdeath())
          var_5++;
      }

      if(var_5 <= 1) {
        var_2--;
        level thread _id_12E01(var_1, 1, var_2);
      }
    }
  }
}

_id_12DD5(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);

  if(isDefined(var_1.module_vehicles[0]) && isent(var_1.module_vehicles[0])) {
    var_2 = var_1.module_vehicles[0];
    var_2 thread _id_14350();
  }
}

_id_14350() {
  self endon("_encstr_AD75063D571AE108");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      scripts\common\vehicle::vehicle_unload("_encstr_8B1608EC43B8D647A113");
      self stoppath(1);
      return;
    }
  }
}

play_intro_vo() {
  wait 4;
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  thread max_steps_before_stability_loss();

  if(getdvarint("_encstr_831409792835B3A07E4B18") < 1) {
    scripts\mp\vehicles\vehicle_damage_mp::_id_12409("_encstr_A9D705DF574899");
    level play_vo_delay("_encstr_A12E2640833F31B96399F28F6D3A9F796977A8F0B7DB4849BA3FFE0D44F23526D25B3878AB4FCBA9");
    wait 0.1;
    level play_vo_delay("_encstr_BEA9267938DF673B33B8BB1FAF93313399F073C047183FC3D9D1E8E9D838C6E902B5093A67A99682");
    wait 0.4;
    level play_vo_delay("_encstr_A72E2632E1F56C3837EBB50B5B85D76CC28D1A2BD76C7BC6B1563647967B73FA31E4B4AC997D6681");
    wait 0.1;
    scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
    level thread play_vo_delay("_encstr_8AA92646C3F56C38E6BE8DC29BCDD78DC2D8A156AF1B7BD88DACC63AB4DBE6FA98C9A55699BE0D03");
    setDvar("_encstr_831409792835B3A07E4B18", 1);
  }

  level notify("_encstr_99FF0E6CF89042DA88CDA76FC148128D");
  var_0 = scripts\engine\utility::getStruct("_encstr_AFC50D4F030E3ADD28467D06D871B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 7840000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_1))
    wait 0.2;

  wait 0.2;
  level play_vo_delay("_encstr_AA3F268CF07D6C0EB9AF362C6EDCFA8D0BB143CABE1BDBC61B568D3AB4B7CDF55AB9E893EDFA9806");
  var_2 = scripts\engine\utility::getStruct("_encstr_86C818F78D72B1233059347FF69A576AD80D470F592BFA19C0E1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 9216;
  var_3 = undefined;

  for(;;) {
    var_3 = var_2 scripts\cp\utility::get_closest_living_player(var_1);

    if(isDefined(var_3)) {
      break;
    }

    wait 0.1;
  }

  level notify("_encstr_9A3810FF46D869863EDAE220F61D409B3223");
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_3, "_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE");
  level thread play_vo_delay("_encstr_8D642BF461694E5B264E1AA21077AF06E03F607D972095D3412192FBF858B3F108BDF4D21F19DEAFF67869D7EB");
  wait 3.4;
  level notify("_encstr_8E920E28EAEA39A1EFA3C10FB2DA69C3");
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
}

previouscarepackagekillstreaks() {
  wait 1;
}

max_steps_before_stability_loss() {
  level waittill("_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7");
  scripts\cp\utility::_id_123FE("_encstr_91CA165BAEB9EB1B0EBEDCB6BAEC9DB1ACC97DDC8E2CE4E8");
}

_id_123E5(var_0) {
  if(isDefined(level._id_11F58)) {
    return;
  }
  level._id_11F58 = 1;
  wait 0.1;
  level play_vo_delay("_encstr_8BA72B241B063F28D809DC598F678F8FBFEFE27F607F9F8BC4B5BA11245286BEC948CB148BC181177BC0D743E7", undefined, undefined);
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B");
  level thread _id_119DA();
}

_id_119DA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_821F0F6380E76461BF40C242CD9ACB1D39");
  wait 3;
  var_0 = randomint(3);
  var_1 = 10;

  for(;;) {
    var_2 = undefined;

    if(var_0 == 0)
      var_2 = "_encstr_ABCD2B1987D736076EAF5BC2B6857DB1586CD0CA7D36ED8D8D2B8DE8B47BCDFACDB258931B1AF5DC58ECAF9881";
    else if(var_0 == 1)
      var_2 = "_encstr_A7D92B5331108AC82846BDC6FB10DF42D79FEBAF97A6F29CB869768B501826D9B63B577B575BB9460831610263";
    else if(var_0 == 2)
      var_2 = "_encstr_92CD2BD41A6188EBBE47EF3FB801593B59F7D8A7597177934CDFAA5BAC355898B31276935699D7E086A7F1B792";

    var_0++;

    if(var_0 >= 3)
      var_0 = 0;

    if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount))
      level play_vo_delay(var_2, undefined, undefined);

    wait(var_1);
    var_1 = var_1 + 2;
  }
}

play_enemy_incoming(var_0) {
  if(isDefined(level.obj_enemy_incoming_vo)) {
    return;
  }
  level.obj_enemy_incoming_vo = 1;
  var_1 = undefined;
  var_2 = propchangeto();

  switch (level.obj_cache_num) {
    case 1:
      var_1 = "_encstr_9B9C2F0B6938A2E0106E652E03F8077A8FF78387BF5E2AA4D0315E7378404EF155153F3F9BE8B26EC058D53CF028B7AF97";
      break;
    case 2:
      var_1 = "_encstr_8F9C2FB2304F362B8B70B4B17ED3CF7E5B90FA3AA18FED93804583BC1B78C3898B505232081F24E359B885A9A0813F9A89";
      break;
    case 4:
    case 3:
      var_1 = "_encstr_869F2FC5E80137E39B9F80D87FA15E6F8A564BDD897AE7A87C6FF86817F7B0DF12BDB551985153905BAF80882317AE71EF";
      break;
  }

  wait(var_0);
  level thread _id_12DEB();
  level thread _id_12DF9();
  level thread _id_12DE5();
  wait 12;
  level thread play_vo_delay(var_1, undefined, undefined);
  var_3 = scripts\engine\utility::getStruct(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait(vo_length(var_1));
  var_4 = var_3 scripts\cp\utility::get_closest_living_player();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_4, "_encstr_A75B1620FA337647FCEB2090C31937C92B65A0A644C71B81", undefined, 1.0);
}

play_extract_reminders() {
  level endon("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  wait 60;
  level thread play_vo_delay("_encstr_BA852BB5A0D86ED39B71ADED0829233702C8457FB60FF3F81511F3CA0FD26121D3AB202B3A811F70A3C1596791", undefined, undefined);
}

player_attempt_say_foundlead(var_0) {
  if(level.obj_found_lead_here_vo > 0)
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_B44814379D0889EFD0E0B22AE9B5E7FEC01FA4883B90");
}

play_find_lead(var_0, var_1) {
  if(isDefined(var_0)) {
    if(level.obj_found_lead_here_vo > 0) {
      if(level.obj_leads_found == level.obj_leads_total_size) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_AD2015ED894DFAC6B7B18DCAB147F536DBB50EC6B2E8CA");
        return;
      }

      level thread player_attempt_say_foundlead(var_0);
      level.obj_found_lead_here_vo++;
      return;
    }

    if(level.obj_cache_num != 1)
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_8F87127B98D4AFB1ED8D8D596C47D799A5E46EA3");

    level.obj_found_lead_here_vo++;
  } else if(level.obj_found_lead_here_vo <= 1 && level.obj_cache_num == 1)
    level thread _id_123E5(var_0);
}

play_find_lead_good(var_0, var_1) {
  if(isDefined(var_0))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_8E6A0CD728386FE7DA207E89BAE9");
  else {}
}

_id_123E6() {
  var_0 = level.obj_cache_num;

  switch (var_0) {
    case 1:
      _id_123E7();
      break;
    case 3:
    case 2:
      _id_123E9();
      break;
    case 4:
      _id_123E8();
      break;
  }
}

_id_123E7() {
  var_0 = level.obj_leads_found;

  if(!istrue(level._id_13E9F)) {
    return;
  }
  switch (var_0) {
    case 1:
      play_vo_delay("_encstr_B82033C81EF5D8C1E6AFD60B5B0BBE1B166C4395BE1B7BD86359363AB4DBDCEB99D29B322D9BECFAC6952C3237F5B1163734D7620C", undefined, undefined, undefined, 1);
      break;
    case 2:
      play_vo_delay("_encstr_872033FFDB57DA809B01AF8F7831770283FE4437D05752D440C877C360A80E8955034DEFA3E52ADF28E0778BD886FBD2172B99F2B7", undefined, undefined, undefined, 1);
      break;
    case 3:
      play_vo_delay("_encstr_9A0B3219C3EB1B0737FA362C9BDCD7D82CC61A95BE1BDB1B8D59B1472DF6377D99DB57CDC87DB2DCDE579D43EB6C2CB9D0EB1381", undefined, undefined, undefined, 1);
      break;
  }
}

_id_123E9() {
  var_0 = level.obj_leads_found;

  switch (var_0) {
    case 1:
      play_vo_delay("_encstr_959830C81EF5C61CB9EBC62CE6CD7DC6B08D34B2EB36B7C6B1B2D8474BF69BAFA14BDCE86ED7C8DE8DD56B2BB9E8E6BE8918", undefined, undefined, undefined, 1);
      break;
    case 2:
      play_vo_delay("_encstr_86E338463C7DB1E06EFA6DC26B0BEBC60B1B34B2F536F6D8C695C647D2EDE6BECCD273325A9B3BBE1BCA168CCDFAC8DE6CABD6CA7347DCFA19C0", undefined, undefined, undefined, 1);
      break;
    case 3:
      play_vo_delay("_encstr_A3FF37BC12BEC15083CF81A2736A81472F9EB84F817FFF29E8D5079BFB7828771DF7D03371E8F155EA45A7E0FF796FBE1B31123EDB9B36030B", undefined, undefined, undefined, 1);
      break;
    case 4:
      play_vo_delay("_encstr_8CE3383722D14B23A6A7BF8FDB471983D8A9ACFF7E981F9A71FB97D33B7852C74870A507D0A8DF615983A76B37083A3F385B9DCFA89073390F01", undefined, undefined, undefined, 1);
      break;
  }
}

_id_123E8() {
  var_0 = level.obj_leads_found;

  switch (var_0) {
    case 1:
      play_vo_delay("_encstr_8CB43A460FF5D80E9B7DDA586B0BBE1BB0B10D597DC6BD8D63CA363AB4F6CDBE66D2B919A5E6ECEB1B560B32E6D73736D0DBDBC643F65D37B2BE1381", undefined, undefined, undefined, 1);
      break;
    case 2:
      play_vo_delay("_encstr_83B43A9A18670E13A368ABD91989E7564368E202B9F7C5BB786DABC42390DB91E5400A8AE055BF3F9045B1CCC6BEE72601D88282503FF3B7E9A0EA90", undefined, undefined, undefined, 1);
      break;
    case 3:
      play_vo_delay("_encstr_A71439C390BE3B5B87C8752EC66F61C381A06B4F11917FE2E1FDBE63236F2AB7C95897DBA04EAD0ACF8D879CAF3F3258B0F00B4B60E3F3E257875A", undefined, undefined, undefined, 1);
      break;
  }
}

play_found_enough_leads() {
  var_0 = undefined;

  switch (level.obj_cache_num) {
    case 1:
      var_0 = "_encstr_97C42CB5F0F7E1714A69D81872690FF96F984DA0438FC88137B238F83A7DBFD1872D40A5E74F30FF1B1AD041F702";
      break;
    case 2:
      var_0 = "_encstr_B6C42C5773EF62283399D7AB186EF38A6F839F015627CA4C9950B3DFE8609782DFA5A547D06B2287A308FBFF3AD3";
      break;
    case 3:
      var_0 = "_encstr_ADC42C049199BEABD69E8AE38D382FF6A019BDB73F700583F531331A4888A76F68DB3E142F984D47A5A9EA61DBFF";
      break;
    case 4:
      var_0 = "_encstr_A1C42C15505741D1EAC938F89289AF590FF82DAFA36F6821571298189A1D1F71678D200507EF501FBB7A70A1C7A2";
      break;
  }

  level thread play_vo_delay(var_0, undefined, undefined);
  wait(vo_length(var_0));
  wait 1;
  level thread play_enemy_incoming();
}

play_investigation_done() {
  var_0 = undefined;
  var_1 = "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB";

  switch (level.obj_cache_num) {
    case 1:
      var_0 = "_encstr_85DC2EC28A2807920827CCC95720115F6F817A5AF69EFF4D084BFBC41B98656786B8A29338652B47B9AFF1CB31F17AA2";
      break;
    case 3:
    case 2:
      var_0 = "_encstr_87F533389BC9E72BE76F018F3B9FB6AF2EB2D088411E0760B37D9E7D09C7580F161A60A88A377919A76490FE0D1761253B63793AE7";
      break;
    case 4:
      var_0 = "_encstr_AB94357DCA516FB73F0184E1089741D8F08EE3C2FFA930B32CD1C7843AD090EFC608404018F3DB09E16AD17328578C8437DB9F5B683B72";
      var_1 = "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350";
      level thread _id_11E1F();
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
      break;
  }

  var_2 = undefined;

  if(isDefined(level.smuggler_last_collector))
    var_2 = level.smuggler_last_collector;

  level play_vo_delay(var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, var_1, undefined, 0.75);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "_encstr_81151065425CDFC72748FFD8E35059AB10CF", undefined, 5);
}

_id_123C7() {
  level play_vo_delay("_encstr_96213067433FB2F8E3693727C0999FFA1B56EC5FB8EFCA3CE8501F7B883096E1E3787312186FB27751C83F27A88B43A9EBAF");
  wait 1;
  level play_vo_delay("_encstr_87252EBBD988125080FED45E50F8B7EA7F0713372FCE9A342081CEE3C8B0DE61C393AB67316082E56BE985EBA359494F");
}

play_approach_tripwire_building() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_ACA914F77398EF73D803E8BF22571377BA77D9412BCD");
  level play_vo_delay("_encstr_822F323D686F79F9C2D148380B9AEF31EF1BB325F7372039ED5A3898C2B5554E678EC5262F1FEB6FD4026020EA4D2B838F17EFBF", undefined, undefined, undefined, 2);
  var_0 = propchangeto();
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 4000000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
    wait 0.2;

  wait 0.5;
  level play_vo_delay("_encstr_97CC30E2601F465BFB20E3E1C1411F8E8B20AA4AF13F3D633015F30CEBA893D923F8F261E89734B70889F01FFD736711FBEA");
  var_2 = 2560000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
    wait 0.2;

  wait 1;
  level play_vo_delay("_encstr_965A32C887AF1BE0DCD736B0CDCDF58DB01B1A95BE1BDB1B63B28D1DD2DB73FAA1B4E6A3CDF56EC60DBD7BB186F6BA9B59BE4C03");
  wait 1;
  var_1 = scripts\engine\utility::getStruct("_encstr_99C1106645D3C26C2060875F8ADE22BA91DB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 16384;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
    wait 0.1;

  level play_vo_delay("_encstr_85313670B30F21A973E9019FFA2BAF69996798E0C7CB7859AA0F8E1D54020556C62710605F62307103B9FEAEEC3A7FF820A740201F070391");
}

handle_hints_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_0 = get_hint_timer();

  for(;;) {
    var_1 = undefined;
    var_0 = get_hint_timer();
    var_2 = level scripts\engine\utility::_id_143B9(var_0, "_encstr_821F0F6380E76461BF40C242CD9ACB1D39");

    if(var_2 == "_encstr_995408F398012F656821") {
      for(var_3 = 0; var_3 < level.obj_leads_models.size; var_3++) {
        if(istrue(var_1)) {
          break;
        }

        if(isDefined(level.obj_leads_models[var_3].associated_player)) {
          continue;
        }
        if(istrue(level.obj_leads_models[var_3].is_collected)) {
          continue;
        }
        if(istrue(level.obj_leads_models[var_3].type == "_encstr_867205BF07A0C7")) {
          if(level.obj_leads_found < level.obj_leads_total_size - 1)
            continue;
        }

        if(isDefined(level.obj_leads_models[var_3].script_label)) {
          level.obj_leads_models[var_3] thread hints_vo_visual_send_to();
          var_1 = level.obj_leads_models[var_3] spawn_group_in_safe_region();
          level decrease_hint_timer();
        }
      }
    }
  }
}

spawn_group_in_safe_region() {
  var_0 = undefined;
  var_1 = ["_encstr_ABCD2B1987D736076EAF5BC2B6857DB1586CD0CA7D36ED8D8D2B8DE8B47BCDFACDB258931B1AF5DC58ECAF9881", "_encstr_A7D92B5331108AC82846BDC6FB10DF42D79FEBAF97A6F29CB869768B501826D9B63B577B575BB9460831610263", "_encstr_92CD2BD41A6188EBBE47EF3FB801593B59F7D8A7597177934CDFAA5BAC355898B31276935699D7E086A7F1B792"];

  switch (self.script_label) {
    case "_encstr_928808AB60380B8BE041":
      if(get_cache_num() == 4) {
        var_0 = "_encstr_8E5A3232F0EB1BC19BFA63C2DC9BD7B1C2361A59FAD8DED81BCA6C8ED27BB9F5A1A5731DCDFADC1B43B7F6C6437BAEE6ACFA2360";
        break;
      }
    case "_encstr_B4C00ABB93577B581BA56169":
      var_0 = scripts\engine\utility::random(var_1);
      break;
    case "_encstr_B6FB08520849423F193D":
      var_0 = "_encstr_8C2C266BC078E6E0AB6E983BF9574619E1976810212B92B141B0D8A3E0FD9571AB1B4AE9A8A7BBB2";
      break;
    case "_encstr_9165090D124F9B2A516D0F":
      var_0 = "_encstr_8B2C2668CB99975B973FD2DF1507665FFE8280F8112ED790832DEE4DF917085FE48A48F84B49A5E3";
      break;
  }

  if(isDefined(var_0)) {
    if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount))
      level thread play_vo_delay(var_0, undefined, undefined);

    wait(vo_length(var_0));
    return 1;
  } else
    return 0;
}

hints_vo_visual_send_to() {
  self endon("_encstr_821F0F6380E76461BF40C242CD9ACB1D39");
  self endon("_encstr_AFE20FD04B23ACBED859C223F543A5E61D");
  self endon("_encstr_AD75063D571AE108");
  var_0 = "_encstr_A722129B3BE0E497A80D82FAAB80E31CC88B11EC";
  var_1 = scripts\cp\cp_objectives::requestworldid(var_0, 2);
  self.spawn_finale_wave = var_0;
  self.spawn_field_ai_manager_wall = var_1;
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 0);
  objective_position(var_1, self.origin);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_1);
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_1, &"_encstr_ACE2185B98873EB3FBD7249987620FF1B5C12D0E358499014F0D");
  objective_setownerteam(var_1, "_encstr_9A8507BA4040188D08");
  objective_addalltomask(var_1);
  objective_showtoplayersinmask(var_1);
  var_2 = get_hint_timer();

  if(var_2 > 44) {
    thread _id_1431F(self, 0.4);
    objective_setbackground(var_1, 0);
    wait 6;
  } else if(var_2 > 38) {
    thread _id_1431F(self, 0.25);
    objective_setbackground(var_1, 0);
    wait 10;
  } else if(var_2 > 35) {
    thread _id_1431F(self, 0.25);
    objective_setbackground(var_1, 0);
    objective_sethot(var_1, 0);
    wait 18;
  } else {
    thread _id_1431F(self, 0.25);
    objective_setbackground(var_1, 0);
    objective_sethot(var_1, 0);
    wait 30;
  }

  thread hasdonestartmusic();
}

_id_1431F(var_0, var_1) {
  self endon("_encstr_821F0F6380E76461BF40C242CD9ACB1D39");
  self endon("_encstr_AFE20FD04B23ACBED859C223F543A5E61D");
  self endon("_encstr_AD75063D571AE108");
  var_2 = scripts\cp\utility::get_closest_living_player();
  var_3 = distance2dsquared(var_2.origin, var_0.origin);

  if(!isDefined(var_1))
    var_1 = 0.25;

  var_3 = var_3 * var_1;

  for(;;) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_3)) {
      break;
    }
  }

  var_0 thread hasdonestartmusic();
}

hasdonestartmusic() {
  if(isDefined(self.spawn_field_ai_manager_wall)) {
    self notify("_encstr_AFE20FD04B23ACBED859C223F543A5E61D");
    objective_state(self.spawn_field_ai_manager_wall, "_encstr_8267056410C669");
    scripts\cp\cp_objectives::freeworldid(self.spawn_finale_wave);
    self.spawn_field_ai_manager_wall = undefined;
    self.spawn_finale_wave = undefined;
  }
}

_id_131F0() {
  scripts\cp\utility::skydivestreamhintdvars("_encstr_8FC307AB0BD0D4476E");
}

play_mission_complete() {
  level thread play_vo_delay("_encstr_84AB308BD8F64323CF80EDA371EF6A0919C007DFA828B42ACBA6331CE8A561DDE070C78F30A0CF8207493A55C5499AA703D2", undefined, undefined);
  wait(vo_length("_encstr_84AB308BD8F64323CF80EDA371EF6A0919C007DFA828B42ACBA6331CE8A561DDE070C78F30A0CF8207493A55C5499AA703D2"));
  wait 0.1;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
}

_id_11E1F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87F41DB84BC7FFE9F7510E9038E3719B2FA30859A2DA39A3BF799E7309C379");
  level endon("_encstr_933C1E6B08AB38F713EE0F2488D88744CD380182A825793F485C373291214BCB");

  for(;;) {
    level play_vo_delay("_encstr_AB94357DCA516FB73F0184E1089741D8F08EE3C2FFA930B32CD1C7843AD090EFC608404018F3DB09E16AD17328578C8437DB9F5B683B72");
    wait(randomfloatrange(90, 110));
  }
}

_id_1446C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87F41DB84BC7FFE9F7510E9038E3719B2FA30859A2DA39A3BF799E7309C379");
  var_0 = scripts\engine\utility::getStruct("_encstr_B24D13F388C9474ADF87A291FE9B8213D1E8E773C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 64000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_1)) {
      break;
    }

    wait 1;
  }

  level notify("_encstr_87F41DB84BC7FFE9F7510E9038E3719B2FA30859A2DA39A3BF799E7309C379");
}

play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0))
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08", var_3, var_5, var_6);

  if(isDefined(var_1))
    wait(var_1);

  if(isDefined(var_2))
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);

  previouscarepackagekillstreaks();
}

vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 / 1000;
  return var_1;
}

_id_11E0F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");

  for(var_0 = get_hint_timer(); var_0 > 10; var_0 = get_hint_timer())
    wait 1;

  scripts\cp\utility::_id_123FE("_encstr_963C19238D2A095E2B11B3789B5F04C8C7E23F9912168895A309C3");
}

debug_start_caches(var_0) {
  thread debug_start_caches_threaded();
}

debug_start_caches_threaded() {
  scripts\engine\utility::flag_wait("_encstr_842130B138EBDCDAD576D9C6AC9CD80B368656CDF5DCB79C4786FA6C4E5958A356AFE6C6C95AE0D17D8DDBD61C63B2A3ACC8");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A9F3176C856C0DAC9BBEC89589AEECBEE6D1B03947F5D8DBB1", 1);
}

killprojectileafterdelay() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85C40B3B13EF77B15D25FBF95B");
  var_0 = 45;

  if(getdvarint("_encstr_A30D1808D7D8811B6953D4D2E7F123D288A74A2BA56BE1B35908", 0) > 0)
    var_0 = getdvarint("_encstr_A30D1808D7D8811B6953D4D2E7F123D288A74A2BA56BE1B35908", 0);

  level._id_11F57 = [];
  wait(var_0);
  var_1 = spawnStruct();
  var_1.origin = (-6888, 32484, -136);
  var_1.angles = (0, 0, 0);
  level thread _id_13516(var_1);
  wait(var_0);
  var_2 = spawnStruct();
  var_2.origin = (-5832, 31152, -203.252);
  var_2.angles = (0, 0, 0);
  level thread _id_13516(var_2);
  wait(var_0);
  level _id_1433D();
  var_3 = spawnStruct();
  var_3.origin = (-4372, 32680, 121.278);
  var_3.angles = (0, 0, 0);
  level thread _id_13516(var_3);
  wait(var_0);
  level _id_1433D();
  var_4 = spawnStruct();
  var_4.origin = (-4824, 31836, -162.932);
  var_4.angles = (0, 0, 0);
  level thread _id_13516(var_4);
}

_id_1433D() {
  var_0 = level.obj_leads_found;

  while(getcirclerangemax(var_0))
    wait 5;
}

getcirclerangemax(var_0) {
  if(level.obj_leads_found > var_0 + 5) {
    if(level._id_11F57.size <= 3)
      return 0;
  }

  if(level._id_11F57.size > 1)
    return 1;

  return 0;
}

_id_13516(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(!isDefined(var_1))
    var_1 = 50;

  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_2.owner = undefined;
  var_2.team = "_encstr_8E8405EA382B2A";
  var_2.faceawayfromowner = 0;
  var_2.cancapture = 0;
  var_2.cancaptureimmediately = 0;
  var_2.activateimmediately = 1;
  var_2.cantimeout = 0;
  var_2.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_2);
  var_2.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";
  var_4 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_2, var_3);

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = ["_encstr_BE1E254C0B08D80B02477A991551778F27B17BED0B8C2789309287E65B822684626878FA198B43", "_encstr_AF1E25ACFB2E4FA25F491AB2F05351F741693C2F959377EB23B80269188916EFD843B6DF383392", "_encstr_8134251703698B3F3881C091B3EB4FAA7E942D6775F3413123CB8A11836A108F823872BFA91F8A", "_encstr_823425C8C3FA1B07E67D6385E6DCD71B8536C6EDEAD1FAD185E6D67DB90EB0BBDC5AE6EC7D460C"];
  level thread play_vo_delay(scripts\engine\utility::random(var_5), undefined, undefined, undefined, 1);
  level._id_11F57[level._id_11F57.size] = var_4;
  wait 6.5;
  var_4 thread tank_waittill_death();
  var_4 endon("_encstr_AD75063D571AE108");
  var_4 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 thread tank_hitmarkers();
  setheadiconsnaptoedges(var_4.headicon, 8000);
  var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_4, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_4, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  var_8 = 250000;
  var_9 = 4840000;
  wait 5;

  for(;;) {
    var_10 = var_4 scripts\cp\utility::get_closest_living_player(var_9);

    if(!isDefined(var_10)) {
      wait 1;
      continue;
    }

    var_11 = var_4.origin + (0, 0, 160);
    var_12 = var_10.origin + (0, 0, 32);
    var_13 = scripts\engine\trace::_bullet_trace(var_11, var_12, 1, var_7);

    if(!isDefined(var_13["_encstr_850E077B0BF30318B9"]) || !isPlayer(var_13["_encstr_850E077B0BF30318B9"])) {
      wait 1;
      continue;
    }

    if(istrue(var_10.binvehicle) && isDefined(var_10.vehicle)) {
      if(var_6 turretcantarget(var_10.vehicle.origin + (0, 0, 50)))
        var_6 settargetentity(var_10.vehicle);

      if(var_7 turretcantarget(var_10.vehicle.origin + (0, 0, 50)))
        var_7 settargetentity(var_10.vehicle);
    } else {
      var_6 _id_130F2(var_10, 9, var_1, var_8);
      var_7 settargetentity(var_10);
    }

    var_4 thread tank_shoot_at_target(var_7, 1);
    var_4 thread tank_shoot_at_target(var_6, undefined, 0.5);
    wait(randomfloatrange(11, 16));
  }
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.headicon))
    setheadiconimage(self.headicon);

  if(isDefined(level._id_11F57))
    level._id_11F57 = scripts\engine\utility::array_remove(level._id_11F57, self);
}

tank_shoot_at_target(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_3 = 4;
  var_4 = 4;

  if(istrue(var_1)) {
    var_3 = randomintrange(80, 120);
    var_4 = 0.05;
  }

  if(isDefined(var_2))
    wait(var_2);

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_0 shootturret();
    wait(weaponfiretime("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83") + var_4);
  }
}

tank_hitmarkers() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
    }
  }
}

_id_130F2(var_0, var_1, var_2, var_3) {
  if(distancesquared(self.origin, var_0.origin) < var_3)
    self settargetentity(var_0);
  else {
    if(var_1 > randomint(9)) {
      if(!isDefined(var_2))
        var_2 = 20;

      var_4 = randomfloatrange(var_2 * -1, var_2);
      var_5 = randomfloatrange(var_2 * -1, var_2);
      var_6 = randomfloatrange(var_2 * -1, var_2);
      self settargetentity(var_0, (var_4, var_5, var_6));
      return;
    }

    self settargetentity(var_0);
  }
}