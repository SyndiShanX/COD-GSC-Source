/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p3.gsc
**************************************************************/

main() {
  level.mlp3_obj_func = ::register_ml_p3_objectives;
  scripts\engine\utility::flag_init("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808");
  scripts\engine\utility::flag_init("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549");
  scripts\engine\utility::flag_init("_encstr_851819AD81A049B28FCAB84B7354D0E0483B8D19CABF5890EB88C5");
  scripts\engine\utility::flag_init("_encstr_999721C51061E8A7206F43FF9F50A936E8F8FE0B28888EFB18451FEF8B86636D7861B7");
  scripts\engine\utility::flag_init("_encstr_B232129D2909EA3650CBFAE1D1938B64D0890D1C");
  scripts\engine\utility::flag_init("_encstr_8706137DF959E8DAAE8062AE42A7F2AC17C368D594");
  scripts\engine\utility::flag_init("_encstr_BDEC0A14BFD7A24730508FE3");
  scripts\engine\utility::flag_init("_encstr_BD0912AD2D1C300C87134189E9CBB001F78F0D0B");
  scripts\engine\utility::flag_init("_encstr_92F61640118A5CF98054F142E8E896A0276402F9FC5DDE81");
  scripts\engine\utility::flag_init("_encstr_BD9F1287D1798F3F31D84871CF31081836336FE4");
}

register_ml_p3_objectives() {
  if(!istrue(level.ml_p3_objectives_registered))
    level.ml_p3_objectives_registered = 1;
  else
    return;

  scripts\cp\cp_objectives::registerobjective("_encstr_A6F40CE08A377FDAE951EDC1450D", ::init_ml_p3_intel, ::start_ml_p3_intel, ::end_ml_p3_intel, ::debugbeatobjective, ::debug_m1_p3_obj_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_9A240EDA63F50766D72DE61DB2D8BEC8", ::init_ml_p3_intel_2, ::start_ml_p3_intel_2, ::end_ml_p3_intel_2, ::debugbeatobjective, ::debug_m1_p3_obj_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_8C240E8AD0F0A3AA91A316F443F04966", ::init_ml_p3_intel_3, ::start_ml_p3_intel_3, ::end_ml_p3_intel_3, ::debugbeatobjective, ::debug_m1_p3_obj_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_ABC20CDAC67D83CCD7CA3C332DD8", undefined, ::_id_137D4, ::movingplatforment, ::debugbeatobjective, ::debug_m1_p3_obj_start);
  scripts\cp\cp_pickup_hostage::registerhvtscriptmodels();
  level thread init_cs_ents();
  level thread register_spawn_functions();
}

debugbeatobjective(var_0) {}

init_cs_ents() {
  if(!scripts\engine\utility::flag_exist("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC"))
    scripts\engine\utility::flag_init("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC");

  scripts\engine\utility::flag_wait("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC");
  register_hack_spot_interaction();
}

register_spawn_functions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC"))
    scripts\engine\utility::flag_init("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC");

  scripts\engine\utility::flag_wait("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_85730AF815392FCBA167C030", 0, 0, 0, 0.05, 0, undefined, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9AB50BB6C6BEC1CCBE4BCDD2A3", 6, 6, 6, 0.1, undefined, "_encstr_9AB50BB6C6BEC1CCBE4BCDD2A3", scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9AB50BB6C6BEC1CCBE4BCDD2A3", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9AB50BB6C6BEC1CCBE4BCDD2A3", ::break_cover_after_breached);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BD0411B5E13E130277D84AD38045412FB0DB14", 6, 6, 6, 0.1, undefined, "_encstr_BD0411B5E13E130277D84AD38045412FB0DB14", scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD0411B5E13E130277D84AD38045412FB0DB14", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A7B016E38BC907DA171498707B2FD8BE821B571303724078", 0, 9, 9, 0.1, undefined, "_encstr_A7B016E38BC907DA171498707B2FD8BE821B571303724078", scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B6070B7A4AB9AA8FE1BE6BAC43", 3, 15, 15, 0.1, undefined, "_encstr_B6070B7A4AB9AA8FE1BE6BAC43", scripts\cp\cp_modular_spawning::disable_kill_off, ::questcomplete);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B6070B7A4AB9AA8FE1BE6BAC43", undefined, 5000, 7500, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B240F70C5BF607E193B33D3B3E126A85F", 2, 2, 4, 0.1, undefined, "_encstr_8B240F70C5BF607E193B33D3B3E126A85F", scripts\cp\cp_modular_spawning::disable_kill_off, ::questcomplete);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8B240F70C5BF607E193B33D3B3E126A85F", undefined, 5000, 7500, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B6C00B1579EF536BB620FFC330", 0, 6, 120, [::spawn_wave, 0.1, 45], undefined, "_encstr_B6C00B1579EF536BB620FFC330", scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92AA0E6BF18FB3825F7ACD3D30574B1B", 4, 8, 8, 0.1, undefined, "_encstr_92AA0E6BF18FB3825F7ACD3D30574B1B");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_97DB0C0569DF635B8620AF1FB0FB", 2, 2, 2, 0.1, undefined, "_encstr_97DB0C0569DF635B8620AF1FB0FB");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9AF212A3B2D834BDFA831A97B9BE5B36FA836685", 0, 5, 5, 0.5, undefined, "_encstr_9AF212A3B2D834BDFA831A97B9BE5B36FA836685");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AFF2121B0F2AA4FFC9DBB03FCBD048C1CEE95B02", 0, 5, 5, 0.5, undefined, "_encstr_AFF2121B0F2AA4FFC9DBB03FCBD048C1CEE95B02");

  if(!scripts\engine\utility::flag_exist("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B"))
    scripts\engine\utility::flag_init("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");

  scripts\engine\utility::flag_set("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");
  scripts\engine\utility::flag_set("_encstr_999721C51061E8A7206F43FF9F50A936E8F8FE0B28888EFB18451FEF8B86636D7861B7");
}

questcomplete(var_0) {
  if(scripts\engine\utility::flag("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808"))
    return undefined;

  for(var_1 = getaiarray("_encstr_8E8405EA382B2A").size; var_1 > 24 - var_0.max_size + 3; var_1 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 1;

  return var_0.group_name;
}

spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "_encstr_922406B1A6FD5E05")) {
      if(issubstr(var_1.type, "_encstr_A5AD0568019C63"))
        var_2 = var_2 + (0, 90, 0);
      else if(issubstr(var_1.type, "_encstr_8253061E2B5FE330") || issubstr(var_1.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_1.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_1.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
        var_2 = var_2 - (0, 90, 0);
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.script_radius = 8;
    self.script_origin_other = var_3;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
  } else {}
}

break_cover_after_breached(var_0) {
  level waittill("_encstr_A6D816CA90B0E3EAD1F54D29917004D3C46EB283197757F4");
  self.goalradius = 1024;
  self.fixednode = 0;
}

notify_building_breach() {
  var_0 = scripts\engine\utility::getStruct("_encstr_B6C710C4AED23691D2E63BF5C6ACB9D15993", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.radius;
  var_2 = var_1 * var_1;
  var_3 = 0;
  var_4 = 1;

  while(!var_3) {
    foreach(var_6 in level.players) {
      if(istrue(var_4)) {
        if(distance2dsquared(var_6.origin, var_0.origin) < var_2)
          var_3 = 1;

        continue;
      }

      if(distancesquared(var_6.origin, var_0.origin) < var_2)
        var_3 = 1;
    }

    wait 0.5;
  }

  level notify("_encstr_A6D816CA90B0E3EAD1F54D29917004D3C46EB283197757F4");
}

spawn_wave(var_0, var_1, var_2, var_3) {
  return scripts\cp\cp_modular_spawning::wave_reinforce(var_0, var_1, var_2, var_3);
}

spawn_per_player(var_0, var_1, var_2, var_3) {
  var_4 = max(var_1, var_2 * level.players.size);

  if(isDefined(var_3))
    var_4 = min(var_4, var_3);
  else
    var_4 = min(var_4, 24);

  return var_4;
}

debug_m1_p3_obj_start(var_0) {
  debug_trigger_objective_events(var_0);
  level thread safehouse_debug_func();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_BDFB124511CEE3D2A7305A22503F3117430FC2D4");
}

debug_trigger_objective_events(var_0) {
  scripts\engine\utility::flag_set("_encstr_8FD81F4848F1AF7F2328D04B2A083FAC1F596E315E4DAF9E8C886ED7FEB00B6F60");
  scripts\engine\utility::flag_wait("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");

  switch (var_0.ref) {
    case "_encstr_A6F40CE08A377FDAE951EDC1450D":
      break;
    case "_encstr_9A240EDA63F50766D72DE61DB2D8BEC8":
      break;
    default:
      break;
  }
}

safehouse_debug_func(var_0) {
  while(!scripts\engine\utility::flag_exist("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549"))
    wait 1;

  scripts\engine\utility::flag_wait("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549");
  wait 7;
  scripts\engine\utility::flag_set("_encstr_A15B0B8154473327910A282832");
}

vfx_smoke() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (25571, -12073.5, -180.25);

  while(!scripts\cp\utility::any_player_nearby(var_0, squared(1500)))
    wait 1;

  scripts\cp\cp_modular_spawning::stop_all_groups();
}

_id_11C5D() {
  var_0 = getEntArray("_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 show();

  thread scripts\cp\cp_objectives::run_objective("_encstr_8D5311B3A74307D05D8B3B354F32CD10532B2D", "_encstr_BA7F0830B3A7859B60B0");
  thread vfx_smoke();
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_9673258F016ECCF90D388B738807309294C1F75B51E7056137DC45BB605FC959FD7953AF19BFBD", "_encstr_9A8507BA4040188D08", 5);
}

init_ml_p3_intel(var_0, var_1) {
  scripts\engine\utility::flag_set("_encstr_8FD81F4848F1AF7F2328D04B2A083FAC1F596E315E4DAF9E8C886ED7FEB00B6F60");
  scripts\engine\utility::flag_wait("_encstr_B6F62992201F87475820FCF74086D74DF7B81FE9101DBF573315CF0BEE0B8F121929826218B1359F6B0DFC");
  scripts\engine\utility::flag_wait("_encstr_999721C51061E8A7206F43FF9F50A936E8F8FE0B28888EFB18451FEF8B86636D7861B7");
  level.initlethalmaxoffsetmap = "_encstr_A6F40CE08A377FDAE951EDC1450D";
  scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("_encstr_88241F99F0F7282C631E75574D8F400A99B38F07E293DA47403F8192F6F2BCD054");
  scripts\mp\brclientmatchdata::getprophealth("_encstr_A27A069DF177CBE3");
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_A27A069DF177CBE3");
  level.setovertimeomnvarprogress = 0;
  level.setovertimeomnvarenabled = 2;
  level._id_12DC0 = 0;
  level._id_12DBF = 2;
  scripts\cp\utility::objective_update("_encstr_A6F40CE08A377FDAE951EDC1450D", undefined, undefined, undefined, undefined, 0);
  level.final_hack_locations = scripts\engine\utility::getStructArray("_encstr_A1E30E27FD1DDB676AA8B1B880916673", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_2 = 0; var_2 < level.final_hack_locations.size; var_2++)
    level.final_hack_locations[var_2] = create_final_hack_spot_interaction(level.final_hack_locations[var_2], var_2);

  level.final_hack_location = level.final_hack_locations[0];
  level thread stop_intel_spawning_and_start_p3();
  scripts\cp\utility::skydivestreamhintdvars("_encstr_A27A069DF177CBE3");
  level thread scripts\cp\cp_munitions::_id_12BE1(level.final_hack_location.origin, 200);
  level thread autorespawnwaittime();
  at_mine_test();
}

autorespawnwaittime() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BEC314A029B66CDFBBC22A5529EFDFC1D5E8A2F81095", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_4.angles = var_2.angles;
    var_4 clonebrushmodeltoscriptmodel(var_3);
  }
}

keep_players_from_using_ascender() {
  foreach(var_1 in level.players)
  var_1.usingascender = 1;
}

stop_intel_spawning_and_start_p3() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43");
  wait 5;
  level notify("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9AB50BB6C6BEC1CCBE4BCDD2A3");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BD0411B5E13E130277D84AD38045412FB0DB14");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7B016E38BC907DA171498707B2FD8BE821B571303724078");
}

start_ml_p3_intel(var_0, var_1) {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A95F25193CEB6CE037FA1B5837CDBEADC67D8399AFB65736E82D0D581BB6F5C44E965633D79860");
  wait 0.5;
  level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
  var_2 = scripts\engine\utility::getStruct("_encstr_A1FE0A6B63FA0E997DB78935", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2;
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_3.origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");

  if(isDefined(level.final_hack_location))
    level.final_hack = level.final_hack_location;

  level thread notify_building_breach();
  level thread setup_test_computer("_encstr_9BF6103A2BDC1D7D367BB538AE47B2C9EB23");

  while(istrue(level.dialogue_playing))
    wait 0.25;

  level update_objective_marker_when_close(var_0, var_2);
  scripts\engine\utility::flag_set("_encstr_BDEC0A14BFD7A24730508FE3");

  while(istrue(level.dialogue_playing))
    wait 0.25;

  scripts\engine\utility::flag_wait("_encstr_92F61640118A5CF98054F142E8E896A0276402F9FC5DDE81");
}

end_ml_p3_intel(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_9AB50BB6C6BEC1CCBE4BCDD2A3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BD0411B5E13E130277D84AD38045412FB0DB14");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_9A240EDA63F50766D72DE61DB2D8BEC8");
}

update_objective_marker_when_close(var_0, var_1) {
  _id_14359(var_1, 1200, 1);
  objective_state(var_0.objectiveindex, "_encstr_8267056410C669");

  for(var_2 = 0; var_2 < level.final_hack_locations.size; var_2++) {
    level thread _id_13F8C(var_2);
    level thread _id_13083(level.final_hack_locations[var_2]);
  }

  scripts\engine\utility::flag_wait("_encstr_BD9F1287D1798F3F31D84871CF31081836336FE4");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_92982F463CAFB10ECDF51B5837CDF55BB1AFC133F5DAD5B18E2D432C36D6F58D7B379BACD83A7D46566C39BC1CA3BE1318");
  wait 0.5;
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
}

_id_13083(var_0) {
  play_vo_when_near("_encstr_ABBD0BB789A6EB675A37AE5863", var_0, 300, undefined, 1);
  scripts\engine\utility::flag_set("_encstr_BD9F1287D1798F3F31D84871CF31081836336FE4");
}

_id_13F8C(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_818D0D34856CADF5AD58275BB227BE" + var_0);
  var_2 = level.final_hack_locations[var_0];
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_1, var_2.origin);
  level waittill("_encstr_A1011423561B568EB2BE34B06CB57DB658936DB293AF" + var_0);
  objective_state(var_1, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::freeworldid("_encstr_818D0D34856CADF5AD58275BB227BE" + var_0);
}

play_vo_when_near(var_0, var_1, var_2, var_3, var_4) {
  _id_14359(var_1, var_2, var_3);

  if(istrue(var_4))
    _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB(var_0);
  else
    scripts\cp\cp_dialogue::play_vo_to_all(var_0);
}

_id_14359(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;
  var_4 = 0;

  while(!var_4) {
    foreach(var_6 in level.players) {
      if(istrue(var_2)) {
        if(distance2dsquared(var_6.origin, var_0.origin) < var_3)
          var_4 = 1;

        continue;
      }

      if(distancesquared(var_6.origin, var_0.origin) < var_3)
        var_4 = 1;
    }

    wait 0.5;
  }
}

init_ml_p3_intel_2(var_0, var_1) {}

start_ml_p3_intel_2(var_0, var_1) {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A39D2939A8E7A087F3B7091B2FDB5810718540D6170E58310BCF2D2B5FF21C301A5E0968BF6688F6815EA1");
  wait 0.5;
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B");
  scripts\engine\utility::flag_set("_encstr_BD0912AD2D1C300C87134189E9CBB001F78F0D0B");
  level thread get_enemies_to_advance_on_players();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B6070B7A4AB9AA8FE1BE6BAC43");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8B240F70C5BF607E193B33D3B3E126A85F");
  scripts\cp\cp_modular_spawning::set_wave_ref_override("_encstr_A27A069DF177CBE3");
  level thread get_rid_of_guys_blocking_path();
  scripts\cp\utility::_id_123FE("_encstr_A2511CE7BBF6B92BC0D66DF5E83069F1C43B6B5F5F08A2EFE878673FE67A");
  level thread hacking_sfx(level.final_hack);
  level thread setobjectivetypesomvarbit();
  level thread _id_11CF1();
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  level notify("_encstr_B23A10B2E85FA6B930BBE3E32F18FE670661");
  is_ai_in_stealth();
  scripts\engine\utility::flag_set("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B6070B7A4AB9AA8FE1BE6BAC43");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B6C00B1579EF536BB620FFC330");
  level notify("_encstr_87D3309BE01677E6D75BED23D536CAEBE6E016DD73D719DB7773C6F60B46D791B266ACDC8C9593DCF5C6EDAD83D82BD1AC19");
}

end_ml_p3_intel_2(var_0, var_1) {
  if(isDefined(level.final_hack.model.boxiconid))
    thread scripts\cp\utility::ent_deleteheadicon(level.final_hack.model, level.final_hack.model.boxiconid);

  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8C240E8AD0F0A3AA91A316F443F04966");
}

_id_11CF1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  var_0 = 0.33;

  while(!isDefined(level.hack_progress))
    wait 0.1;

  while(istrue(level.dialogue_playing))
    wait 0.1;

  while(level.hack_progress < 0.1)
    wait 0.1;

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_92AA0E6BF18FB3825F7ACD3D30574B1B");

  while(level.hack_progress < 0.3)
    wait 0.1;

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9AF212A3B2D834BDFA831A97B9BE5B36FA836685");

  while(level.hack_progress < 0.3)
    wait 0.1;

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AFF2121B0F2AA4FFC9DBB03FCBD048C1CEE95B02");

  while(level.hack_progress < 0.5)
    wait 0.1;

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_97DB0C0569DF635B8620AF1FB0FB");

  while(level.hack_progress < 0.7)
    wait 0.1;

  level thread _id_13504();
}

hacking_sfx(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  wait 0.05;
  var_1 playLoopSound("_encstr_A3E8155BD0014A376940F0A0F780A0FBAEABDEEB0110FB");
  level scripts\engine\utility::_id_143A5("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27", "_encstr_ADA60F43C2B15B96E6ECBE3858BADC9519");
  var_1 stoploopsound("_encstr_A3E8155BD0014A376940F0A0F780A0FBAEABDEEB0110FB");
}

setobjectivetypesomvarbit() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.hack_progress))
    wait 0.1;

  while(istrue(level.dialogue_playing))
    wait 0.1;

  while(level.hack_progress < 0.4)
    wait 0.1;

  is_ambient(1);

  while(level.hack_progress < 0.6)
    wait 0.1;

  is_ambient(2);

  while(level.hack_progress < 0.8)
    wait 0.1;

  is_ambient(3);
}

gettimetogulagclosed(var_0) {
  var_1 = scripts\engine\utility::random(var_0);
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

is_any_player_in_region() {
  wait 1;
  var_0 = ["_encstr_833D21DF38779E6FC8211F23B3D3B9BE3A90F4EA03E719814F0C060813A862F7D767DF", "_encstr_933D212AA8D7BEA333F83331073857C6E38072B2407FB41FE9DA072910833B0D070A7F", "_encstr_833D21DF38779E6FC8211F23B3D3B9BE3A90F4EA03E719814F0C060813A862F7D766DF"];
  gettimetogulagclosed(var_0);
  wait 1;
  var_0 = ["_encstr_8BAF26C83CD71BE0E67D8D2FE0A17D36CB0743564ED7C6DBDCE6AC8D474B7B9BAFECBDDEC8FA1318", "_encstr_93AF26884BF7C941AB413E3B62F2D73129837008DB5F8107223525CE7BDAEFD8A747C0E0EB077371", "_encstr_B8AF2687ABAFCB423BDFF393A1E8970998DB2B6740588A7526322A3E80C41095F9470F5017FF976A"];
  gettimetogulagclosed(var_0);
  scripts\engine\utility::flag_set("_encstr_92F61640118A5CF98054F142E8E896A0276402F9FC5DDE81");
}

is_ambient(var_0) {
  while(istrue(level.dialogue_playing))
    wait 0.1;

  switch (var_0) {
    case 1:
      var_1 = "_encstr_835128F5E3A96B28A3FF32F3F9B0D15637C7F06A3B99AFC0A355C97EE98B5565D18F83D3321CAFC98E6A";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      break;
    case 2:
      var_1 = "_encstr_A15128E1702F684F4BFF4F635B22AFA0B1CAE8599A473088B2D34B5F635A50707FE2D35106ACC8A80F92";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      wait 0.5;
      var_1 = "_encstr_AA1A284687EB1B0EE6F5B6585B0BBE1B2F381ACA93F5C6DE37B9ACC6A396DBCDAFDCA35826D8CAD73306";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      break;
    case 3:
      var_1 = "_encstr_9A512849E04707CBCA019FCF09B8F97AD8591AE95D175FCFAB9880B81CDFBAD2A9A313315938E0F91A21";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      wait 0.5;
      var_1 = "_encstr_922628D9A3F153101B87034F73135F7060C9E8C850EF67C883E6774FF47B901297FB836AAE287DEF5D5A";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      break;
    default:
      break;
  }
}

is_ai_in_stealth() {
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  var_0 = ["_encstr_B6FA33E2601F465BFB20EBF94F601F8EBBB8AA4A98473E6F7090F51B656897954FC84242F08977DB4910EB18FD938F1D73C8C91F5A", "_encstr_ADFA33F7D34FC28893F987F798286F0ABB6F7C2FBE279AAF18989797906007621F0E05A5279932FC01293783E0FBFF3A131D810AAF", "_encstr_87FA3319F0AF6CE09B7D1BBC83A1FA36970786CA39AFB17BB9B9CAB11D5ADE73FA36BDB5071BB2D159F59B1AEA1DD77B5747FA990C"];
  gettimetogulagclosed(var_0);
  wait 5;
  var_0 = ["_encstr_A7583077B0C82250D2C9066B6301D7769B603A25EAF911556B7AE831C8A325D8C717709D0113953420D778037335307601BF", "_encstr_A558308CC3AF8D83E6D7B1E5C10DF56CCB0E0D959CBED8B77337B2C6D1B4B737FA6CF66BE0C6AC1D56BEA59BD1CA1B7D8C81", "_encstr_AB58300D20C9FF3B435738D0D360163773CAF3053A61478036FB2B082B89287579B6F899122A032BE527787833DD8DDF070A"];
  gettimetogulagclosed(var_0);
  wait 5;
  var_1 = "_encstr_B228313CA9A186A3DE8642EB8BBBE7FDD07FA0D34F684B9B0578EA92F102AFF398EB261B4580528FA6D0B28B386DDB6F99F3F0";
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
  wait 1;
  var_1 = "_encstr_8F98315773EF62283399DBF7E0EBCF4A7118DA1A48235B4CBB4BC3FF88C097A3E5AFA5824C6BE3B76148EF43C879747AE79EBA";
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

is_ai_facing_point(var_0) {
  switch (var_0) {
    case 0:
      var_1 = ["_encstr_925B2672F08FF6EB4BB07B693FF08F3E2B483AFA0837AEDF8037456BD5F807053F63B213A05FF25A", "_encstr_885B26C83CAFD8E0E6D7B1F2E0A1BE1B5E0E1AAC9CAF36EDCDDC59B13A2DDECDEB63DEE68ED7C803", "_encstr_925B2672F08FF6EB4BB07B693FF08F3E2B483AFA0837AEDF8037456BD5F807053F63B213A05F725A"];
      gettimetogulagclosed(var_1);
    case 1:
      var_2 = "_encstr_A59424B2A23F9A53E0D612D2E3BB8FA9FB5B28550B60FEF76BC5951788AB42381E8A731FCE32";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    case 2:
      var_2 = "_encstr_B40124C83CAF6C0ECD7DD8F20ED07DD8E5070DACE4AFB1DE73B9568D472DBDE6F591C1EB4C0C";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    case 3:
      var_2 = "_encstr_BAA824F968276047B3F7576B632A18D8A9C2E051927F28F0BACB43676B425878778A6B6EEAF8";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    case 4:
      var_2 = "_encstr_B16A24D9F3E1A69853F1411A2220A9EEFBBB595363497E98969589514B19F0903132E19F8667";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    default:
      break;
  }
}

init_ml_p3_intel_3(var_0, var_1) {}

start_ml_p3_intel_3(var_0, var_1) {
  var_2 = level.final_hack_location.model;
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_2.origin);
  scripts\engine\utility::flag_wait("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549");
  level notify("_encstr_BE0F16D3FB7A8FE02D995871BE1B8130B20B7B070372CC20");
  var_3 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

  foreach(var_5 in var_3)
  var_5 scripts\cp\cp_modular_spawning::clear_wave_ref_override();

  scripts\engine\utility::flag_set("_encstr_B232129D2909EA3650CBFAE1D1938B64D0890D1C");
  scripts\engine\utility::flag_set("_encstr_A15B0B8154473327910A282832");
}

end_ml_p3_intel_3(var_0, var_1) {
  level.max_agents_override = undefined;
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_ABC20CDAC67D83CCD7CA3C332DD8");
}

lootleadermarksize() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BDBF3146877D36E0377D8D586E6EAF6B63EBC1CCD76BEA63E82D342C366DD7D65DD81DD2860BB1B6D7E6AB1B8DCAE6E6D72660");
  wait 0.5;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8A482F19C3F5D80ECDF5D60BB6B0BED663AF3866EBDA5DD8E8B4D0856C6DEB3B7BAFE8DBF5B985CCAC43BDEA6E597D6218");
  wait 0.5;
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
}

computer_test() {
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  var_0 = tablelookupgetnumrows("_encstr_A23E26C66A86B78005A3F0F0DF32DECF2A924D5D45395F09F1B378084F6A510793BDBDDECD12E713");
  level.cpu_manifest1_idx = randomintrange(1, var_0 + 1);
  setomnvar("_encstr_8F431202FA83E68B57D6534F775E830337BA1209", level.cpu_manifest1_idx);
  level thread scripts\cp\cp_hacking::hacking_init();
  thread setup_test_computer("_encstr_84850BAFC1B81323F16925ADE3");
}

setup_test_computer(var_0) {
  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 delete();
}

fake_world_structs_defend_download() {
  level.fake_structs = [];
  var_0 = [(19487, -9593, 552)];

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    var_3.origin = var_2;
    var_3.angles = (0, 0, 0);
    var_3.script_noteworthy = "_encstr_B1B21361D176F00833CA592162EBC0F84B3AD3EF6C";
    level.fake_structs[level.fake_structs.size] = var_3;
  }
}

pause_hacking(var_0) {
  level notify("_encstr_B23A10B2E85FA6B930BBE3E32F18FE670661");
  level endon("_encstr_B23A10B2E85FA6B930BBE3E32F18FE670661");
  level.hacking_paused = 1;
  level notify("_encstr_ADA60F43C2B15B96E6ECBE3858BADC9519");
  wait(var_0);
  level.hacking_paused = 0;
  level thread hacking_sfx(level.final_hack);
}

remove_from_list_on_death() {
  self waittill("_encstr_AD75063D571AE108");
  remove_from_hack_attackers_list(self);
}

remove_from_hack_attackers_list(var_0) {
  level.hack_attackers = scripts\engine\utility::array_remove(level.hack_attackers, var_0);
}

listen_to_hack_damage() {
  var_0 = 0;
  self.hack_damage = 0;
  var_1 = 100;

  while(!var_0) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team != "_encstr_8E8405EA382B2A") {
      continue;
    }
    self.hack_damage = self.hack_damage + var_2;

    if(self.hack_damage > var_1)
      var_0 = 1;
  }
}

setup_headicon_on_jammer(var_0, var_1) {
  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, var_1, "_encstr_9A8507BA4040188D08", var_0);
  setheadiconzoffset(self.boxiconid, 1);
  setheadiconsnaptoedges(self.boxiconid, 0);
}

get_enemies_to_advance_on_players() {
  level endon("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 1200;
  var_1 = var_0 * var_0;
  var_2 = scripts\engine\utility::getStruct("_encstr_A1FE0A6B63FA0E997DB78935", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

    foreach(var_5 in var_3) {
      if(var_5.origin[2] > 0) {
        continue;
      }
      if(distancesquared(var_5.origin, var_2.origin) > var_1) {
        continue;
      }
      var_5.combatmode = "_encstr_821109FAE81117DA568730";
      var_5.goalradius = 32;
    }

    wait 30;
  }
}

create_final_hack_spot_interaction(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";
  var_2.script_noteworthy = "_encstr_88191066B437B036FA86858DB5EBDCE0DEA3";
  var_2.requires_power = 0;
  var_2.spend_type = "_encstr_A3BA05E0735C50";
  var_2.setnewabilitycount = var_1;
  var_3 = scripts\engine\utility::getStructArray("_encstr_A1950CCAB71B63F74D59AB93F069", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getclosest(var_2.origin, var_3, 1000);
  var_2.model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_2.model setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(!isDefined(var_4.angles))
    var_5 = (0, 0, 0);
  else
    var_5 = var_4.angles;

  var_2.model.angles = var_5;
  var_2.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  return var_2;
}

register_hack_spot_interaction() {
  scripts\cp\cp_interaction::register_interaction("_encstr_88191066B437B036FA86858DB5EBDCE0DEA3", "_encstr_A3BA05E0735C50", undefined, ::final_hack_spot_hint, ::final_hack_spot_activate, 0, 0, undefined);
}

final_hack_spot_hint(var_0, var_1) {
  if(!scripts\engine\utility::flag("_encstr_BDEC0A14BFD7A24730508FE3"))
    return "_encstr_B40101";

  if(scripts\engine\utility::flag("_encstr_BD9F1287D1798F3F31D84871CF31081836336FE4")) {
    if(!istrue(var_0.setnexthistorydestination))
      return &"_encstr_878921415989E98F532F5DD4C6EF742D2490C94160939347FE154928F0763E77DDF8C9";
  }

  if(scripts\engine\utility::flag("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808") && !scripts\engine\utility::flag("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549"))
    return &"_encstr_AC0B2337F34195018E11473F4DB789DEA80FAF916F39CD19B7FD4C36E223D16E90D7094BAB";
  else
    return "_encstr_B40101";
}

final_hack_spot_activate(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\engine\utility::flag("_encstr_BDEC0A14BFD7A24730508FE3")) {
    return;
  }
  if(scripts\engine\utility::flag("_encstr_BD9F1287D1798F3F31D84871CF31081836336FE4")) {
    if(!istrue(var_0.setnexthistorydestination)) {
      var_0.setnexthistorydestination = 1;
      level.setovertimeomnvarprogress++;
      level thread _id_135C2(var_0);
      scripts\cp\utility::objective_update("_encstr_A6F40CE08A377FDAE951EDC1450D", undefined, undefined, undefined, undefined, level.setovertimeomnvarprogress);
      level notify("_encstr_A1011423561B568EB2BE34B06CB57DB658936DB293AF" + var_0.setnewabilitycount);

      if(level.setovertimeomnvarprogress >= level.setovertimeomnvarenabled) {
        scripts\engine\utility::flag_set("_encstr_8706137DF959E8DAAE8062AE42A7F2AC17C368D594");
        level thread lootleadermarkweaksize();
      }
    }
  }

  if(scripts\engine\utility::flag("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808") && !scripts\engine\utility::flag("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549")) {
    if(!istrue(var_0._id_12DBC)) {
      var_0._id_12DBC = 1;
      level._id_12DC0++;
      scripts\cp\utility::objective_update("_encstr_8C240E8AD0F0A3AA91A316F443F04966", undefined, undefined, undefined, undefined, level._id_12DC0);
      var_0.model delete();

      if(level._id_12DC0 >= level._id_12DBF) {
        scripts\engine\utility::flag_set("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549");
        scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_91C812DB4C35EB23ACEC5AB1B2EBC1A56CADD51C");
      }
    }
  }
}

lootleadermarkweaksize() {
  _id_123F7();
  _id_137BC();
}

_id_135C2(var_0) {
  var_0.model setModel("_encstr_9B14166787ABD238E078E3B3913BEFDB71152A11E431EA64");
  var_0.model setup_headicon_on_jammer("_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 20);
}

_id_123F7() {
  is_any_player_in_region();
}

init_hacking_table() {
  scripts\cp\cp_hacking::parsehackingtable("_encstr_924523E750D51B2F6F1BABD1D3236329DCD96F4FE1ED58E087024059EA131338377EF7F786");
}

_id_137BC() {
  level.hackingfunc = ::init_hacking_table;
  level.hack_duration = 300;
  level thread _id_11CE1();
  level thread scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
}

_id_11CE1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8B9E100FD856B0F777FB8E06524FBA67D808");
  level endon("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  var_0 = 250;
  var_1 = var_0 * var_0;
  var_2 = level.final_hack_locations;
  var_3 = gettime() + 15000;

  for(;;) {
    var_4 = 0;

    foreach(var_6 in var_2) {
      var_6._id_11F20 = 0;

      foreach(var_8 in level.players) {
        if(distancesquared(var_8.origin, var_6.origin) < var_1) {
          var_4++;
          var_6._id_11F20++;
        }
      }
    }

    var_11 = 0;

    foreach(var_6 in var_2) {
      if(var_6._id_11F20 == 0) {
        var_11 = 1;
        break;
      }
    }

    setomnvar("_encstr_96CD138D83BAD743858DB6B4E6CED79B969DE6851B", var_4);
    level.hacking_paused = var_11;
    level.hack_multiplier = 1 + var_4 * 0.25;

    if(gettime() > var_3) {
      var_3 = var_3 + 15000;
      var_15 = int(max(0, var_4 - 1));

      if(var_4 == 0)
        level thread is_ai_facing_point(var_15);
    }

    waitframe();
  }
}

claymore_test() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_82160E6C8D2CBCB5B79CACAFD156DC8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2 spawn_claymore();
    wait 0.1;
  }
}

spawn_claymore() {
  var_0 = magicgrenademanual("_encstr_ACC40CC1F8A321601715CFBFE0EA", self.origin + (0, 0, 100), (0, 0, 10));
  var_0.owner = var_0;
  var_0.team = "_encstr_8E8405EA382B2A";
  var_0 thread scripts\cp\cp_claymore::claymore_plant();
}

at_mine_test() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A32D0D87E9502A91804131C37950B4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2 spawn_at_mine();
    wait 0.1;
  }
}

spawn_at_mine() {
  var_0 = magicgrenademanual("_encstr_81430B218B3F7018458997D78A", self.origin + (0, 0, 100), (0, 0, 10));
  var_0.owner = var_0;
  var_0.team = "_encstr_8E8405EA382B2A";
  thread scripts\cp\equipment\cp_at_mine::at_mine_plant(var_0);
}

get_rid_of_guys_blocking_path() {
  level endon("_encstr_85AD17307081DB4289D3577BE3AFED97708A87F7B7032FD549");

  for(;;) {
    foreach(var_1 in level.spawned_enemies) {
      if(!isDefined(var_1.listening_for_blocked_path))
        var_1 thread listen_for_blocked_path();
    }

    wait 0.5;
  }
}

listen_for_blocked_path() {
  self endon("_encstr_AD75063D571AE108");
  self.listening_for_blocked_path = 1;
  var_0 = self getentitynumber();

  for(;;) {
    self waittill("_encstr_91890973ED32B2AFC485C8", var_1, var_2, var_3);

    if(var_1 != "_encstr_A6C10D18A7D30C6F9D314826026D48") {
      continue;
    }
    if(isDefined(var_3) && var_3 < 2000) {
      continue;
    }
    var_4 = var_2 getentitynumber();

    if(isalive(var_2)) {
      if(isDefined(var_2.enemy)) {
        var_2 thread send_guy_to_org(var_2.enemy.origin);
        continue;
      }

      foreach(var_6 in level.players) {
        if(isDefined(var_6) && isalive(var_6))
          var_2 thread send_guy_to_org(var_6.origin);
      }
    }
  }
}

send_guy_to_org(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self setgoalpos(var_0);
  self.goalradius = 16;
  thread stop_ignoring_after_timer(5);
  var_1 = scripts\engine\utility::_id_143AD("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958");
  self.goalradius = 512;
}

stop_ignoring_after_timer(var_0) {
  self.ignoreall = 1;
  wait(var_0);
  self.ignoreall = 0;
}

_id_13504() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_A19B117D39E6CBCABFB8A22AA8671203991CF6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_997911B6C6FAC1CC7D43AC3696BE6EE8BD38C4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_8CC0106B36D7E0CCEB43591B5AD7B156338E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_82AE12BD0929CA1670E8BA32D0A89F4758D12D2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStruct("_encstr_BA0111B5D8FA1CCCAF1ACA364BF53996768647", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.final_hack_location.origin);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_6.death_fx_on_self = 1;
  var_6.circle_radius = 2500;
  var_6 scripts\cp\helicopter\cp_helicopter::heli_mg_create("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED", "_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753", "_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_6.isheli = 1;
  var_6.health = 25000;
  var_6.maxhealth = 25000;
  var_6.team = "_encstr_8E8405EA382B2A";
  var_6 setvehicleteam("_encstr_8E8405EA382B2A");
  var_6 setmaxpitchroll(15, 15);
  var_6.health_remaining = 25000;
  var_6 sethoverparams(25, 15, 10);
  var_6 setlookatent(var_5);
  var_6 vehicle_setspeed(90, 30);
  var_6 setvehgoalpos(var_1.origin, 1);
  var_6 waittill("_encstr_8B7205D9ED5958");
  var_6 setvehgoalpos(var_3.origin, 1);
  var_6 waittill("_encstr_8B7205D9ED5958");
  var_6.instantbleedoutsquadwipe = "_encstr_A5C407E1658D3339B3";
  var_6 vehicle_setspeed(15, 10);
  var_6._id_11E98 = 1;
  var_6 thread skip_navmesh_check(var_6);
  var_6 thread skipburndownforvehicle(var_6);
  level thread _id_14454(var_6);

  if(!isDefined(level.vo_paratroopers))
    level.vo_paratroopers = [];

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_6);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_6);
  level waittill("_encstr_8F2B12B6D8D71C33AF32B263CAE8CAAF86B2C6B4");
}

skipburndownforvehicle(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 vehicle_setspeed(50, 30);
  var_1 = scripts\engine\utility::getStruct("_encstr_8CC0106B36D7E0CCEB43591B5AD7B156338E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_82AE12BD0929CA1670E8BA32D0A89F4758D12D2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_BA0111B5D8FA1CCCAF1ACA364BF53996768647", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStruct("_encstr_835F11384DAF7B2F31A2C77BF2AFA4BBED981B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = [var_1, var_2, var_3, var_4];

  for(;;) {
    var_5 = [var_1, var_2, var_3, var_4];
    var_6 = var_5;

    switch (var_0.instantbleedoutsquadwipe) {
      case "_encstr_A5C407E1658D3339B3":
      default:
        var_6 = scripts\engine\utility::array_remove(var_5, var_2);
        var_7 = scripts\engine\utility::random(var_6);
        break;
      case "_encstr_A5AD056A019C63":
        var_6 = scripts\engine\utility::array_remove(var_5, var_1);
        var_7 = scripts\engine\utility::random(var_6);
        break;
      case "_encstr_8253060E2B5FE330":
        var_6 = scripts\engine\utility::array_remove(var_5, var_3);
        var_7 = scripts\engine\utility::random(var_6);
        break;
      case "_encstr_AA5606FD1AF05085":
        var_6 = scripts\engine\utility::array_remove(var_5, var_4);
        var_7 = scripts\engine\utility::random(var_6);
        break;
    }

    var_0 setvehgoalpos(var_7.origin, 1);
    var_0 waittill("_encstr_8B7205D9ED5958");
    var_0.instantbleedoutsquadwipe = var_7.script_noteworthy;
    wait 2;
  }
}

skip_navmesh_check(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level notify("_encstr_ADDC11BF2C0EC075EFA2D1DE1A93A50B658501");
  var_0.minigun setturretteam("_encstr_8E8405EA382B2A");
  var_0.minigun setmode("_encstr_849007B268BD03DFD8");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = scripts\engine\utility::getStruct("_encstr_B1A311A3B3EB373A851D5ADE73FA3695D9B2C6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = var_0 quarry_wave_spawn_scoring(var_3.origin);

    if(!isDefined(var_4)) {
      var_0.minigun cleartargetentity();
      wait 0.2;
      continue;
    }

    var_0.minigun settargetentity(var_4);
    var_5 = var_0.minigun scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB", 3);

    if(var_5 == "_encstr_995408F398012F656821") {
      var_0.minigun cleartargetentity();
      continue;
    } else if(gettime() > var_1) {
      for(var_6 = 0; var_6 < 35; var_6++) {
        var_0.minigun shootturret();
        wait 0.1;
      }

      var_1 = gettime() + 1000;
    }
  }
}

quarry_wave_spawn_scoring(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 25000000;

  var_2 = level.players;
  var_2 = sortbydistance(var_2, self.origin);

  foreach(var_4 in var_2) {
    if(!isalive(var_4)) {
      continue;
    }
    if(distancesquared(var_4.origin, var_0) < var_1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var_4.origin + (0, 0, 100), var_2))
      return var_4;
  }

  return undefined;
}

_id_14454(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_AD75063D571AE108");
  playFX(level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"], var_0.origin);

  if(isDefined(var_0.minigun)) {
    var_0.minigun makeunusable();
    var_0.minigun maketurretinoperable();
    var_0.minigun delete();
  }

  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, var_0);
  wait 1;

  if(isDefined(var_0))
    var_0 delete();
}

_id_137D4(var_0) {
  thread _id_13547();
  thread lootleadermarksize();
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A6EF23A770C939BC2BF98F17109778C154FD2F31C1E349E68670063D48F308C93F11B99BA2", "_encstr_9A8507BA4040188D08", 5);
  level waittill("_encstr_99D81368CB605C77355B8A23C60DFF955BD717EE55");
  wait 4;
}

movingplatforment(var_0) {
  wait 2;
  thread scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
  level thread mp_shipment_patch();
  wait 3;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3)
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_9A680F44F50B719381EBEFD579E75032A3");
      else
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_AD7113355D37A327CAEE853923BE5BB7467D6795D1");
    }

    var_2 scripts\cp_mp\xmike109::scriptable_callback("_encstr_88F20B46BDBBDCE8BDBBB9F50D");
  }

  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

mp_shipment_patch() {
  foreach(var_1 in level.players)
  var_1 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_1 in level.players) {
    if(!istrue(var_1.try_to_punish_with_jugg)) {
      var_1.invulnerable = 1;
      var_1 allowmovement(0);
    }

    var_4 = scripts\engine\utility::getStruct("_encstr_992413C87D18F2C042FF5B435B8A0898AED7F02027", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_1 spawn_endgame_camera(var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}

screen_fade_to_black(var_0) {
  if(!isDefined(var_0.kidnap_black_screen)) {
    var_0.kidnap_black_screen = newclienthudelem(var_0);
    var_0.kidnap_black_screen.x = 0;
    var_0.kidnap_black_screen.y = 0;
    var_0.kidnap_black_screen setshader("_encstr_83AB065EE1391A7B", 640, 480);
    var_0.kidnap_black_screen.alignx = "_encstr_A5AD056A019C63";
    var_0.kidnap_black_screen.aligny = "_encstr_AC190479FF92";
    var_0.kidnap_black_screen.sort = 1;
    var_0.kidnap_black_screen.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.kidnap_black_screen.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.kidnap_black_screen.foreground = 1;
  }

  var_0.kidnap_black_screen.alpha = 0;
  var_0.kidnap_black_screen fadeovertime(2);
  var_0.kidnap_black_screen.alpha = 1;
}

_id_13547() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_973C176531EEC33247D86B829009111B01A9F9DFD653CFEBFD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_961D14B915F9E9635F6F30D847B42611E2BD23286DC3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_8857165078871ACA27FA233450C1E86BB321960364F73B9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.vehicletype = "_encstr_8DD90913C62DB585D7D81C";
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_0, var_1, var_2, 0);
  wait 3;

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }
  var_3 = level.heli_trip_vehicle;
  var_4 = scripts\cp\cp_objectives::requestworldid("_encstr_ABC20CDAC67D83CCD7CA3C332DD8");
  objective_state(var_4, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_4, var_1.origin);
  objective_icon(var_4, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_4, &"_encstr_A6EF23A770C939BC2BF98F17109778C154FD2F31C1E349E68670063D48F308C93F11B99BA2");
  objective_setshowoncompass(var_4, 1);
  objective_setminimapiconsize(var_4, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  var_3 waittill("_encstr_8B4611FB437F1BCBF029B7922708928B93F832");
  scripts\cp\cp_objectives::_id_11F80(var_4);
  var_3 waittill("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  objective_delete(var_4);
  scripts\cp\cp_objectives::freeworldid("_encstr_ABC20CDAC67D83CCD7CA3C332DD8");
}