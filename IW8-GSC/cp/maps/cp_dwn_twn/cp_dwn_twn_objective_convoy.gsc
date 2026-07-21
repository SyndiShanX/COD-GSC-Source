/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwn_twn_objective_convoy.gsc
**************************************************************/

register_objectives_for_convoy() {
  level.convoy_obj_func = ::register_objectives;
  level thread wait_for_players_near_obj();
}

wait_for_players_near_obj() {
  while(!isDefined(level.mission_select))
    wait 1;

  level.mission_select endon("_encstr_A25A1158A2EADF10FF26E0EE05DBD94793CA88");
  scripts\engine\utility::flag_init("_encstr_8B9C15771891B283777E0D45DC2F6B57B868FF8F188816");
  scripts\engine\utility::flag_wait("_encstr_8B9C15771891B283777E0D45DC2F6B57B868FF8F188816");

  for(;;) {
    if(istrue(level.event_active)) {
      wait 1;
      continue;
    }

    level.event_active = 1;
    level thread spawn_convoy_and_drive();
    scripts\engine\utility::flag_wait("_encstr_9A8C2395D9CAE61DAFED8953B2C63A5AB3CAF5C6EDE69DED5EF526BE6CDB6B1C1B568EAC19");
    level.event_active = 0;
    return;
  }
}

spawn_convoy_and_drive(var_0) {
  level notify("_encstr_820E0E4A64C00D6B7F02A3D93BE03152");
  wait 2;
  level.convoy_speed_override = 12;
  wait 0.1;
  level thread first_intro_text();
  level thread play_mission_end_vo();
  get_proto_convoy_event();
  wait 0.05;
  level thread scripts\cp\cp_objectives_events::try_start_event(level.convoy_proto_event, "_encstr_81843CF74B22DABBBB5347B7AAFA1F31C34F655BB80727AB75B0EBB3F02F0F72EF71BBC811B36F48DF2F7B4A7B8B0153CBED1F67E3BCEF2510F32A5E2F6E", level.convoy_proto_index);
}

register_objectives() {
  scripts\cp\cp_objectives::registerobjective("_encstr_848E130D8540F5A3D811726A5B284F6158398182E9", undefined, ::spawn_convoy_and_drive, undefined, undefined);
}

objective_convoy_init(var_0) {
  wait 0.05;
}

objective_convoy_start(var_0) {
  var_1 = 99999;
  run_convoy_roaming(var_0, var_1);
  return;
}

run_convoy_roaming(var_0, var_1) {
  var_2 = get_far_away_startpath();
  var_2 = "_encstr_BD550E72389DA3871A805B54A743D321" + var_2;
  var_2 = scripts\engine\utility::getStruct(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = get_proto_convoy_type();

  if(getDvar("_encstr_91281468C26A4791BF6634A05957D8AD177BF830CAC7", "_encstr_B40101") != "_encstr_B40101")
    var_3 = getDvar("_encstr_91281468C26A4791BF6634A05957D8AD177BF830CAC7", "_encstr_B40101");

  objective_addteamtomask(var_0.objectiveindex, "_encstr_8E8405EA382B2A");
  level thread play_searching_new_convoy_vo();
  var_4 = level.convoy_proto_event;
  var_5 = level scripts\cp\cp_convoy_manager::spawn_convoy_from_type(level.convoy_proto_event, var_3, var_2, var_0, var_1, var_4);
  objective_addalltomask(var_0.objectiveindex);
  var_5 thread scripts\cp\cp_convoy_manager::set_objective_struct(var_0);
  var_5 thread scripts\cp\cp_convoy_manager::show_objective_icon(0);
  var_5 thread play_new_convoy_vo(var_5);
  wait 2;
  var_5 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var_5 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  var_5 thread scripts\cp\cp_convoy_manager::set_healthdrain_on_lowhealth(50);
  var_5 thread scripts\cp\cp_convoy_manager::set_center_hull_invulnerable(1);
  level thread wait_till_players_near_center(var_5);
  var_5 thread scripts\cp\cp_convoy_manager::set_attach_objective_icon(1, 220);

  if(var_3 == "_encstr_8F480E406FB958091E5A0807F5324561" || var_3 == "_encstr_9B0D15E65BC2B11BB43216379D2B279627ED58DA4B9BEC") {
    var_5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("_encstr_A19A0772BF43C35FD9", 4, 5);
    var_5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("_encstr_A19A0772BF43C35FD9", 0, 0);
  } else if(var_3 == "_encstr_A7670FB5AC19B4AEDAD2C9DB856B5ACD3B") {
    var_5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("_encstr_A19A0772BF43C35FD9", 8, 8);
    var_5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("_encstr_A19A0772BF43C35FD9", 0, 0);
  }

  var_9 = var_5 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount(1);
  var_10 = scripts\cp\cp_convoy_manager_code::get_nitrate_label(var_9);
  var_5 thread scripts\cp\cp_convoy_manager::show_objective_icon(1, 1);
  var_5 thread scripts\cp\cp_convoy_manager::toggle_convoy_wheel_outlines(1);
  level thread set_tires_desc(var_5, var_0);
  var_5 waittill("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  level thread play_mark_barrel_vo(var_5);
  level thread play_secure_barrel_vo(var_5);
  var_5 thread scripts\cp\cp_convoy_manager::delay_kill_main_truck(31);
  var_5 waittill("_encstr_A3E5145B2888AB302AC6B1F8FE15103B3889DD49CB30");
  var_5 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_5 thread scripts\cp\cp_convoy_manager::set_despawn_distance(3500);
  level thread convoy_end_this_event(var_5, var_4);
}

reset_convoy_soon() {
  level waittill("_encstr_BA3D0B7EBDE377DEDF88931A28");
  level thread spawn_convoy_and_drive();
}

convoy_end_this_event(var_0, var_1) {
  level scripts\cp\cp_objectives_events::stop_event(var_1);
  level notify("_encstr_BA3D0B7EBDE377DEDF88931A28");
}

get_far_away_startpath() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A3AA130B984823E7A3C0FF1832062BD7A8B737633F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_AB4E136CDB739D7BF2BE374758C91DBEACC2CDD189", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_82C31431AAE36C281017A7D151BAB8A0CF024B5B4276", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = [];
  var_3[var_3.size] = var_0;
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = var_2;
  var_4 = 6000;
  var_5 = var_4 * var_4;
  var_6 = [];

  foreach(var_8 in var_3) {
    if(!scripts\cp\utility::any_player_nearby(var_8.origin, var_5)) {
      var_9 = strtok(var_8.targetname, "_encstr_BA4C02DF");
      var_10 = var_9[2];
      var_6[var_6.size] = var_10;
    }
  }

  if(var_6.size > 0)
    return scripts\engine\utility::random(var_6);
  else {
    var_12 = scripts\engine\utility::random(var_3);
    return var_12.targetname;
  }
}

set_tires_desc(var_0, var_1) {
  var_2 = 0;

  for(;;) {
    var_3 = undefined;
    var_4 = undefined;

    if(var_2 == 0) {
      var_3 = &"_encstr_A55213D5B9C716C93DFE3F2BC34DD9CB2B542FDE27";
      var_4 = "_encstr_846C15ACD959DCE8EBD8EDE6CEBD2FAF3AB493CACDF506";
    } else if(var_2 == 1) {
      var_3 = &"_encstr_865213A0F3990BB799E10C71299739A7F9A78149BF";
      var_4 = "_encstr_B26C15DF4BA8EE3BD8B7D7DBB5F8D367883092A78321F9";
    } else if(var_2 == 2) {
      var_3 = &"_encstr_8B521334A0F5349E2765F4B2A9E58A52A4A8A9AFC8";
      var_4 = "_encstr_A66C15D5FB32BDD307DF3030E35F0AA74BA4D66D1249CD";
    } else if(var_2 >= 3) {
      var_3 = &"_encstr_8352136661A94B179EDBF0F1BF8A13DC9B5D97C913";
      var_4 = "_encstr_B66C15ACECACDCD1EB6CBD37D9F6E5EB3A5A3959DCF5CC";
    }

    objective_setdescription(var_1.objectiveindex, var_3);
    scripts\cp\utility::objective_update(var_4);

    if(var_2 >= 3) {
      break;
    }

    var_0 waittill("_encstr_ADB413354F5A6BF884B71E70DD63B88843E39BABC3");
    var_2 = var_2 + 1;
  }

  wait 1.5;
  var_0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
  var_4 = "_encstr_8D881589DC4FDB201716381003474F8E7E67AC3BB72372";
  objective_setdescription(var_1.objectiveindex, &"_encstr_B6931B3FE861A90893C174BEB93ED5A94B02C3B774D9894383998D0720");
  scripts\cp\utility::objective_update(var_4, 30, 29, 15);
}

spawn_4player_car(var_0) {
  _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::init();
  _encstr_B2DA317B77ADBFFB89D7D00661A6D1A840D0FA70C0497213E9DB1B623CC04FEF1F98CD19028B26B2AF78D38D535AF52AEF3BBF::load_vfx();
  setDvar("_encstr_8BFF175289C8BB74389DE4D85B087A0F88A5CACBB7BF9BEF60", 450);
  setDvar("_encstr_82A519305AF9D9389F3275673DAB03A71DA0A820A00D0D13975A0D", 20);
  setDvar("_encstr_A65414C6D9EBA3D04B4EC841CA4EB97BCD340BE4AA38", 150);
  var_1 = undefined;

  if(!isDefined(var_1)) {
    var_2 = scripts\engine\utility::getStruct("_encstr_A3AA130B984823E7A3C0FF1832062BD7A8B737633F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = scripts\cp\utility::getcloseststruct(var_2.origin, "_encstr_BD4A0F2A03196BEF907FBBA01B58756F3E");
  }

  if(isDefined(var_1)) {
    var_3 = _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::get_humvee_info(var_1);
    level thread _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::deploy_vehicle(var_1, var_3);
  }
}

spawn_map_technicals() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_93EC1927D060C6424B10DB9766310A916918934FD85B090B4D1522", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\vehicles\technical_cp::technical_cp_createfromstructs(var_0, 3);
}

get_proto_convoy_type() {
  if(!isDefined(level.convoy_proto_type))
    level.convoy_proto_type = 1;

  if(level.convoy_proto_type == 1) {
    level.convoy_proto_type = 2;
    return "_encstr_8F480E406FB958091E5A0807F5324561";
  } else if(level.convoy_proto_type == 2) {
    level.convoy_proto_type = 3;
    return "_encstr_A7670FB5AC19B4AEDAD2C9DB856B5ACD3B";
  } else if(level.convoy_proto_type == 3) {
    level.convoy_proto_type = 1;
    return "_encstr_9B0D15E65BC2B11BB43216379D2B279627ED58DA4B9BEC";
  }
}

get_proto_convoy_event() {
  if(!isDefined(level.convoy_proto_event)) {
    level.convoy_proto_event = "_encstr_96F31320FA333167BB3AB390311607282B6FB3B001";
    level.convoy_proto_index = "_encstr_A34C02BB";
  } else if(level.convoy_proto_event == "_encstr_96F31320FA333167BB3AB390311607282B6FB3B001") {
    level.convoy_proto_event = "_encstr_87F313603A84EB49FB590C8D17DFB0B5EB72585997";
    level.convoy_proto_index = "_encstr_A74C0222";
    return;
  } else {
    if(level.convoy_proto_event == "_encstr_87F313603A84EB49FB590C8D17DFB0B5EB72585997") {
      level.convoy_proto_event = "_encstr_BDF3138A314A175E2843EEC517A86573EC0863F173";
      level.convoy_proto_index = "_encstr_A14C023B";
      return;
      return;
    }

    if(level.convoy_proto_event == "_encstr_BDF3138A314A175E2843EEC517A86573EC0863F173") {
      level.convoy_proto_event = "_encstr_96F31320FA333167BB3AB390311607282B6FB3B001";
      level.convoy_proto_index = "_encstr_A34C02BB";
      return;
    }
  }
}

wait_till_players_near_center(var_0) {
  var_1 = 1680;
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0.main_truck.origin, var_2)) {
      break;
    }

    wait 0.1;
  }

  level thread play_shoot_tires_vo();
}

play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0))
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08", var_3, var_5, var_6);

  if(isDefined(var_1))
    wait(var_1);

  if(isDefined(var_2))
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
}

vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 / 1000;
  return var_1;
}

first_intro_text() {
  level endon("_encstr_82110E2B659031D94945A3CA98B953E2");

  if(!isDefined(level.convoy_proto_text))
    level.convoy_proto_text = 1;
  else
    return;

  level thread spawn_map_technicals();
  wait 4;
  level thread play_intro_texts();
  level thread play_vo_delay("_encstr_950420C8F0F5C6836EFAB7D963BEB1DEDCCEEDCBD74EF6B05BFA3139D25633BE4C0C", undefined, undefined);
  wait(vo_length("_encstr_950420C8F0F5C6836EFAB7D963BEB1DEDCCEEDCBD74EF6B05BFA3139D25633BE4C0C"));
  wait 0.2;
  level thread play_vo_delay("_encstr_93042033604ECBAB5718655BF967D29F30B8A7CFC1030F6253302E5253CB7A6713F2", undefined, undefined);
  wait(vo_length("_encstr_93042033604ECBAB5718655BF967D29F30B8A7CFC1030F6253302E5253CB7A6713F2"));
  wait 0.2;
  level thread play_vo_delay("_encstr_830420911EFAD8C1DCBEBD6736AFD8F6E6ECDECB7D93BD166BF5C4275A9533FA9981", undefined, undefined);
  wait(vo_length("_encstr_830420911EFAD8C1DCBEBD6736AFD8F6E6ECDECB7D93BD166BF5C4275A9533FA9981"));
  wait 0.2;
}

play_intro_texts() {
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_85F71B0F5AB126970BEFF9132AAF2D01A96CF709AEA395F7E2D05F83E6");
  wait(vo_length("_encstr_950420C8F0F5C6836EFAB7D963BEB1DEDCCEEDCBD74EF6B05BFA3139D25633BE4C0C"));
  wait 0.2;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AAF71B7EA751EB50B835AFEF27E0282959CCE5F7FE49BE99EE2FE7420D");
  wait(vo_length("_encstr_93042033604ECBAB5718655BF967D29F30B8A7CFC1030F6253302E5253CB7A6713F2") / 2);
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_97F71B0D28EB1A7A9CB29ECA4D9711945013F4A3D7A472A2299EF518CC");
  wait(vo_length("_encstr_93042033604ECBAB5718655BF967D29F30B8A7CFC1030F6253302E5253CB7A6713F2") / 2);
  wait 0.2;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_88F71B7E3937F9E7CC1D1859F60F3341AB1CC7BF4F9948C99228D01AC4");
}

play_shoot_tires_vo() {
  level notify("_encstr_82110E2B659031D94945A3CA98B953E2");

  if(scripts\engine\utility::cointoss())
    level thread play_vo_delay("_encstr_852729321E7DD8386EEB7BCEB1FAC6DB73ECF6CBFA27DE0BDAD7D1A5E495E6FAE60DEDDB8E5AE6CEF59881", undefined, undefined);
  else
    level thread play_vo_delay("_encstr_9627298150598630329637B6CB2729620503F8E88F72E847BD584939C2480B81A77BC8153840256AB17A09", undefined, undefined);
}

play_searching_new_convoy_vo() {
  if(isDefined(level.vo_skipped_first_location))
    level thread play_vo_delay("_encstr_8A872BF140E12817E7D1F0DBCA7F469045A61F43FF127BD7E7C94B61E26388E81D0FF7E569BCA025B302C623DF", undefined, undefined);
}

play_new_convoy_vo(var_0) {
  if(!isDefined(level.vo_skipped_first_location)) {
    level.vo_skipped_first_location = 1;
    return;
  }

  foreach(var_2 in level.players) {
    var_3 = "_encstr_A9891EE043110FC31F8768DC9C8769CF854B4080A9F25FB91F9FE05D7F5F1B39";
    var_4 = &"_encstr_B40101";
    var_5 = scripts\cp\cp_battlechatter::getdirectioncompass(var_2.origin, var_0.main_truck.origin);

    switch (var_5) {
      case "_encstr_99960A057008EC123D4B4FAB":
      case "_encstr_882B0A73DB9CD1D0DD95B98E":
      case "_encstr_887106DCEDC93A34":
        var_3 = "_encstr_832F2479E301F82A7289E82539768EAF954B40E8BE331852FA2ECA35C3C89570A3E39861AA72";
        var_4 = &"_encstr_93FF1C18A997F61FD43C5F515610FB8C53A140D06919BD576D055D444804";
        break;
      case "_encstr_9A6005079F201B":
        var_3 = "_encstr_86FC23B4F32647DA274142CBC027563FB85C3731986BAFA633295AF230CF0FBF73C5BFF187";
        var_4 = &"_encstr_A5FF1C85EFBFBD28F00627BF395E39C86905FF1FA9CC3889D1D7F76D6873";
        break;
      case "_encstr_87790ACB570D8853BFD12E88":
      case "_encstr_A76006DCF6EAE886":
      case "_encstr_99E40A0E08AB6BD2B725AED5":
        var_3 = "_encstr_A346240D383F29A992A120D0AAA1476023DEB77B872310D37DC92040F3495F3827641BE04152";
        var_4 = &"_encstr_B4FF1C4FE190087741E7F5487F7244604741F7A717B1703351CF7F071679";
        break;
      case "_encstr_88F60573538740":
        var_3 = "_encstr_8DEB23B5F0F7E1714A69D81872690F385B8648B37FFBA89B3571E898BB31EFB1F72CD80F88";
        var_4 = &"_encstr_84FF1C33D189A647584F7801F730A3ECC141A7BFB779FD4FF7E7D0D85E64";
        break;
      default:
        break;
    }

    level thread scripts\cp\cp_vo::try_to_play_vo_for_one_player(var_3, var_2);
    level thread scripts\cp\utility::cp_add_dialogue_line(var_4);
  }
}

play_mark_barrel_vo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread play_vo_delay("_encstr_86F62791E1F5D883CDFA7BD936D7C67BE6677BF2BEC9DB856BAF63BDF6E8FA194EB783835932D78903", undefined, undefined);
  wait(vo_length("_encstr_86F62791E1F5D883CDFA7BD936D7C67BE6677BF2BEC9DB856BAF63BDF6E8FA194EB783835932D78903"));
  wait 0.1;
  level thread play_vo_delay("_encstr_BAB22B53E91156E0DB5075F8C80147A00E7B78E057AA2FD78286D3CEB9FBA03F50190FC230AA02C0D873B1C352", undefined, undefined);
  wait 7;
  level thread play_vo_delay("_encstr_87B22B9033617FB30F9778EC8C9799DF957B50F0B9C2AFA92FEF7E6E99ABE09BFDF259D0F29ACDE1C3EB107F20", undefined, undefined);
  wait 7;
  level thread play_vo_delay("_encstr_ACB22BF38B19EFF84EB1805ED1AFAEC0ADB6205BB75A5A99DD786336D31526B87E7CA7F98813136734985F3682", undefined, undefined);
}

play_secure_barrel_vo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B17D13F86783D9EA48858BD8A3892F5A592C60DA7B");

  if(!isDefined(level.vo_collect_id))
    level.vo_collect_id = 1;

  level waittill("_encstr_A98213D0DF701B5763486527C78B9EEFFE8624F10F");

  if(isent(var_0.main_truck))
    var_0 waittill("_encstr_A3E5145B2888AB302AC6B1F8FE15103B3889DD49CB30");

  wait 2;

  if(level.vo_collect_id == 1) {
    level.vo_collect_id = 2;
    level thread play_vo_delay("_encstr_86D22CC9581750776327BF85C38936E8CE3350E2098278A7FA3FBFB70F42889096CFDE39ADF538E952FB9BC766CF", undefined, undefined);
  } else if(level.vo_collect_id == 2) {
    level.vo_collect_id = 1;
    level thread play_vo_delay("_encstr_ABD22C237B4923910B7F2FBBC58F4108F5A827FB6F0577718889C85F17E848F9F560E6B6A80827981590E1FF7ADF", undefined, undefined);
  }
}

play_mission_end_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.vo_mission_end)) {
    return;
  }
  level.vo_mission_end = 1;
  level waittill("_encstr_A3E01807AF2508B7575908B0A347CB08FD078FE7450A605D0B92");
  level thread play_vo_delay("_encstr_BA4E2B9FBB37BAE0FB611F73D056AB223DD42550B0D5B239C0792F17508B69EAE5F8AE4D01393A45CB40EF7E62", undefined, &"_encstr_96EE231A827DD0A793CAF495A6CB22921413E9A3AF5392A64D927A727DD0E96A28C4152AA8");
}