/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_jorgetest\cp_objs_tmtyl.gsc
**************************************************/

registertmtylobjective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_init("_encstr_A9BE1E43A83DEF15E9D54946F3585DC7EFE12AAB7616174A78CB765483F0270B");
  init_anims();
  thread registersquadspawners();
  scripts\cp\cp_objectives::registerobjective("_encstr_A7280AF6C4D4AF8ED68E97D8", ::inittmtylobj, ::starttmtylobj, ::completetmtylobj, undefined, ::debugtmtylobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_82040C6F3160DFAB4053A3C1F672", ::tr_circletick, ::_id_1387A, undefined, undefined, ::debugtmtylobjectivesstart);
  scripts\cp\cp_modular_spawning::register_aitype_setup("_encstr_A7A00D6B8794E24A5E2162A18FB3B8", "_encstr_8B6627273EB540F8D19A28C5C877973727CF07F30B4E55CDB363AA931FD8312BE78277E80F83EC85E6", undefined, undefined, undefined, undefined);
}

registersquadspawners() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(!scripts\engine\utility::flag_exist("_encstr_88441A57E059283153EBF88653D776082A5CA7CF97BD50893FD3D1E9"))
    scripts\engine\utility::flag_init("_encstr_88441A57E059283153EBF88653D776082A5CA7CF97BD50893FD3D1E9");

  if(!scripts\engine\utility::flag_exist("_encstr_A27721A3B61D2FB1EBDC07B0DD37D733EA9B8DA35AF637B9F5C95976D2B9E856935646"))
    scripts\engine\utility::flag_init("_encstr_A27721A3B61D2FB1EBDC07B0DD37D733EA9B8DA35AF637B9F5C95976D2B9E856935646");

  scripts\engine\utility::flag_wait("_encstr_88441A57E059283153EBF88653D776082A5CA7CF97BD50893FD3D1E9");
  scripts\cp\coop_stealth::coop_stealth_init();
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_922C1531B5CB18F9B7F3931BBA333802A91CAB93247788", 1, 1, 1, 0.5, undefined, "_encstr_A7B214D18F7B83203B12FB717F2FF2285237730947C3", undefined, undefined, undefined);
  [[var_0]]("_encstr_918C0ED15BE8BC36D7CD8BEAB023AF13", 0, 8, 8, 0.5, undefined, "_encstr_AA3A0D5CF38870838E13135AD9F0AE", undefined, undefined, undefined);
  [[var_0]]("_encstr_92A9155971A497785F6B4A3B2817FF5AD1E0096F0B777B", 1, 1, 1, 0.5, undefined, "_encstr_836314B9E713EB38133AC35967D702306A2F0B117FDB", undefined, undefined, undefined);
  [[var_0]]("_encstr_AC8C0EE94074F37A19A809B8B2C71762", 0, 8, 8, 0.5, undefined, "_encstr_813A0D8343C399314F91BB4031C72A", undefined, undefined, undefined);
  [[var_0]]("_encstr_922815F9293B490C3737774561045FF2E9F149E8E0D545", 1, 1, 1, 0.5, undefined, "_encstr_84E1140BE075B74DC0831D11B17942E79119D29249CE", undefined, undefined, undefined);
  [[var_0]]("_encstr_B88C0EFBA2A3D308B113BBBB2927C9BE", 0, 8, 8, 0.5, undefined, "_encstr_883A0D93F8E00A707F67AB29E1C9B3", undefined, undefined, undefined);
  [[var_0]]("_encstr_A79115D1DAA3F2C6EBE617ABB023AF687D36955846AC39", 1, 1, 1, 0.5, undefined, "_encstr_8D5114C3970B5EF05A83FB37391F9C49C25AEEC9D293", undefined, undefined, undefined);
  [[var_0]]("_encstr_8E8C0EEBE30DA35CD14B424B2120A7AF", 0, 8, 8, 0.5, undefined, "_encstr_843A0DCB7870A90A7E236F376130D7", undefined, undefined, undefined);
  [[var_0]]("_encstr_A7DB15131B852BD449C3FAC3B9A8DF27C881DFBFE1A523", 1, 1, 1, 0.5, undefined, "_encstr_B47B14FBF5613B83D23FF00923CFE25F81800955E52E", undefined, undefined, undefined);
  [[var_0]]("_encstr_BE8C0E63218B23D151D8B1CB46A11E17", 0, 8, 8, 0.5, undefined, "_encstr_8A3A0D2B907379C2EFB74B46158F6F", undefined, undefined, undefined);
  [[var_0]]("_encstr_9AE915889F5C0AF9E9CAB7BDA6B2571B8F7398A803E523", 1, 1, 1, 0.5, undefined, "_encstr_8CAA14BB6BE309B29FC7DBD6A51FCFE748F86763285B", undefined, undefined, undefined);
  [[var_0]]("_encstr_928C0E0957A35B88AF2AD3AB567CD934", 0, 8, 8, 0.5, undefined, "_encstr_853A0D015FAB53908BA2AB210F7F9A", undefined, undefined, undefined);
  [[var_0]]("_encstr_86C6169B937DD32CC15B727B313057CF40256F77752DAB0B", 2, 2, 2, 0.5, undefined, "_encstr_92B515E8B5A3F2D86E2E5D2C8CF566F54CDE5B4C2B4E6E", undefined, undefined, undefined);
  [[var_0]]("_encstr_81B010EB45D370751708D01268674821B783", 0, 7, 10, 0.5, undefined, "_encstr_81B010EB45D370751708D01268674821B783", ::watchforstopambient6waves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_925C0E7358D9709BCEAF7572B3514BFB", 0, 6, 6, 0.5, undefined, "_encstr_925C0E7358D9709BCEAF7572B3514BFB", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_925C0E7358D9709BCEAF7572B3514BFB", 750, 2000, 5000, 1);
  [[var_0]]("_encstr_8F4B0F786FACFA09395E898577517D83E7", 0, 1, 3, 10, undefined, "_encstr_8F4B0F786FACFA09395E898577517D83E7", undefined, undefined, undefined);
  [[var_0]]("_encstr_848413CBC32D837CF149E5EF0119AB2A0B51375B67", 0, 2, 4, 8, undefined, "_encstr_848413CBC32D837CF149E5EF0119AB2A0B51375B67", undefined, undefined, undefined);
  [[var_0]]("_encstr_B1E6151DB6D1BCC6EBED5DE863F6DEDAAF9B9B5A0EAC93", 0, 1, 1, 0.5, undefined, "_encstr_B1E6151DB6D1BCC6EBED5DE863F6DEDAAF9B9B5A0EAC93", undefined, undefined, undefined);
  [[var_0]]("_encstr_A2241A833038E152206F47AFB355A966B9387F0D28098C9A07691FBB", 1, 1, 1, 0.5, undefined, "_encstr_868F1280975432C1E114B5C9AC193979A92B8008");
  [[var_0]]("_encstr_A2130DB358CD1FE5F9E575709FAA7A", 0, 3, 3, 0.5, undefined, "_encstr_A2130DB358CD1FE5F9E575709FAA7A");
  [[var_0]]("_encstr_95130DD57DCBD93B7F7B1FDC7F8AD2", 0, 3, 3, 0.5, undefined, "_encstr_95130DD57DCBD93B7F7B1FDC7F8AD2");
  [[var_0]]("_encstr_B4130D30428B6B10DFDE1D839F0AB3", 0, 3, 3, 0.5, undefined, "_encstr_B4130D30428B6B10DFDE1D839F0AB3");
  [[var_0]]("_encstr_B6130D65051BABD80F9368784F189B", 0, 3, 3, 0.5, undefined, "_encstr_B6130D65051BABD80F9368784F189B");
  [[var_0]]("_encstr_A6130D1195EB38D9978371D839022D", 0, 3, 3, 0.5, undefined, "_encstr_A6130D1195EB38D9978371D839022D");
  [[var_0]]("_encstr_BEAA137B90730FB81FAECF4FE7713161A7B8FDD07F", 1, 1, 1, 0.5, undefined, "_encstr_BEAA137B90730FB81FAECF4FE7713161A7B8FDD07F");
  [[var_0]]("_encstr_BED9133B91C1BB5CDEA0879F58D137573FBAC3770C", 1, 1, 1, 0.5, undefined, "_encstr_BED9133B91C1BB5CDEA0879F58D137573FBAC3770C");
  [[var_0]]("_encstr_8F8513A35BE8BC36EB6E2E5D2C46D7CC7DD4AE3B9D", 1, 1, 1, 0.5, undefined, "_encstr_8F8513A35BE8BC36EB6E2E5D2C46D7CC7DD4AE3B9D");
  [[var_0]]("_encstr_A69113E58D33CA3139C370A81A0F9FAB4722EDD41F", 1, 1, 1, 0.5, undefined, "_encstr_A69113E58D33CA3139C370A81A0F9FAB4722EDD41F");
  [[var_0]]("_encstr_A3FE13ACB0DB82B006E30FE331AF811ED71A504702", 1, 1, 1, 0.5, undefined, "_encstr_A3FE13ACB0DB82B006E30FE331AF811ED71A504702");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_922C1531B5CB18F9B7F3931BBA333802A91CAB93247788", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_92A9155971A497785F6B4A3B2817FF5AD1E0096F0B777B", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_922815F9293B490C3737774561045FF2E9F149E8E0D545", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A79115D1DAA3F2C6EBE617ABB023AF687D36955846AC39", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A7DB15131B852BD449C3FAC3B9A8DF27C881DFBFE1A523", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9AE915889F5C0AF9E9CAB7BDA6B2571B8F7398A803E523", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2241A833038E152206F47AFB355A966B9387F0D28098C9A07691FBB", ::_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_918C0ED15BE8BC36D7CD8BEAB023AF13", ::any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC8C0EE94074F37A19A809B8B2C71762", ::any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B88C0EFBA2A3D308B113BBBB2927C9BE", ::any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8E8C0EEBE30DA35CD14B424B2120A7AF", ::any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BE8C0E63218B23D151D8B1CB46A11E17", ::any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_928C0E0957A35B88AF2AD3AB567CD934", ::any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_86C6169B937DD32CC15B727B313057CF40256F77752DAB0B", ::_id_13BA2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_848413CBC32D837CF149E5EF0119AB2A0B51375B67", ::playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_848413CBC32D837CF149E5EF0119AB2A0B51375B67", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8F4B0F786FACFA09395E898577517D83E7", ::playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8F4B0F786FACFA09395E898577517D83E7", undefined, 20000, 30000);
  [[var_0]]("_encstr_B4E7135303A7F74B187B23A9895099B61B63586A38", 0, 24, undefined, 0.1, ::unset_pre_wave_spawning, "_encstr_B4011DC8BB37EB8EDDB9D7E02CE8C9DBB1F56E8EE4BAB1E89B7D47B5472FB1", ::init_pre_wave_spawning, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B4E7135303A7F74B187B23A9895099B61B63586A38", scripts\cp\cp_modular_spawning::set_pre_wave_spawning_spawn_funcs);
  scripts\engine\utility::flag_set("_encstr_A27721A3B61D2FB1EBDC07B0DD37D733EA9B8DA35AF637B9F5C95976D2B9E856935646");
}

playergetspectatingplayer(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self.sightmaxdistance = 2200;
  self.is_on_platform = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  var_2 = 500;
  var_3 = 500;

  while(!istrue(self.entered_combat))
    waitframe();

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(!var_6 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(distancesquared(var_6.origin, self.origin) < var_2 * var_2)
        var_4 = 1;

      wait 0.5;
    }

    if(var_4) {
      break;
    }

    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::set_goal_radius(var_3);
  self.goalheight = 64;

  for(;;) {
    self.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);

    if(istrue(self.entered_combat)) {
      wait 15;
      continue;
    }

    wait 5;
  }
}

init_pre_wave_spawning(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", scripts\cp\cp_modular_spawning::stay_passive_if_not_weapons_free);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", scripts\cp\cp_modular_spawning::set_aggro_flag_on_enter_combat);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", scripts\cp\cp_modular_spawning::watch_for_players, undefined, 1000000, 45);
}

unset_pre_wave_spawning(var_0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("_encstr_8E8405EA382B2A", scripts\cp\cp_modular_spawning::stay_passive_if_not_weapons_free);
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("_encstr_8E8405EA382B2A", scripts\cp\cp_modular_spawning::set_aggro_flag_on_enter_combat);
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("_encstr_8E8405EA382B2A", scripts\cp\cp_modular_spawning::watch_for_players);
}

watchforstopambient6waves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopambient6waves(var_0);
}

_watchforstopambient6waves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_AB5A17431A1B7BA069CB5343C18F71640F52B8E83393BD58BF");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

getnextholdoutspawnmodule(var_0) {
  if(scripts\engine\utility::flag("_encstr_A9BE1E43A83DEF15E9D54946F3585DC7EFE12AAB7616174A78CB765483F0270B"))
    return undefined;

  for(var_1 = 0; var_0.activecount > 3 && var_1 <= 6; var_1++)
    wait 1;

  return "_encstr_81B010EB45D370751708D01268674821B783";
}

inittmtylinterrogate(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_93C5082C187F3AA5AB68"));
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 linkTo(var_0);
  var_1 setHintString(&"_encstr_95182271C8991912D3877913FBA9B53F7519CD3149973B3738F7F06FCF1AB537B7E97410");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  level._id_13BA3[var_0.leader_index] = var_1;
  var_0.isplayerindanger_think = "_encstr_BA350853C128FB939DB9";
  var_0 thread watchwindowplayerexit();
}

watchwindowplayerexit() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level._id_13BA3[self.leader_index] waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player() || istrue(var_0.isjuggernaut)) {
      continue;
    }
    level._id_13BA3[self.leader_index] makeunusable();

    if(istrue(var_0.has_gl)) {
      var_0 thread scripts\cp\coop_super::remove_launcher_after_timeout(0);
      var_0 waittill("_encstr_82670F7715C9CBB7A829F397FF6F4BB541");
    }

    self.isplayerindanger_think = "_encstr_972C1E3296B98513D8CA2310982F012DB93A954E581B1D96DE37048E1AD2B9DA";
    self.isremotekillstreaktabletweapon = "_encstr_95DD12C95C660B3916D7CBCDFB6A707005F2D101";
    self notify("_encstr_ABDE1BC193329B2B42E153CB162AC0DD3AF74B756B9AE6F86B0318A0FD");
    level thread managedropbags(var_0);
    lastplundereventtype(self.leader_index);
    var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A7280AF6C4D4AF8ED68E97D8");
    level thread doleaderfinalsurrender(var_0, self.leader_index);
    level thread scripts\cp\utility::_id_123FE("_encstr_8C9F18200707A710B259B053ED32142F1BA00EE8FB81A1A3E288" + var_1.numleadersinterrogated);
    var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A7280AF6C4D4AF8ED68E97D8");
    var_1.leadersinterrogated[self.leader_index] = 1;

    if(var_1.numleadersinterrogated >= 6)
      scripts\engine\utility::flag_set("_encstr_A9BE1E43A83DEF15E9D54946F3585DC7EFE12AAB7616174A78CB765483F0270B");

    break;
  }
}

managedropbags(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_8E1417E822AB5058AE82272BAC1988807BCAC3339AC7F79047");
}

tr_circletick(var_0) {
  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("_encstr_862D1643E989F30441F0BB4BF0B9C32A077C0D7AC1C18A54", 15);
  level thread scripts\cp\utility::_id_123FE("_encstr_B83B1EB7A86B573AF1B8057E18F1823F1348073FD0C3B34237C8C1F27DA35BEC");
  objective_setplayintro(var_0.customwaypointid, 0);
  objective_setplayoutro(var_0.customwaypointid, 0);
  objective_state(var_0.customwaypointid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(var_0.customwaypointid, &"_encstr_8E5122839756B3220F3131B9C937AD7B2CF50B6C83DF173A8759E960E9EB913347489EE4");
  objective_icon(var_0.customwaypointid, "_encstr_820C1B2A6711393A430918D95AC070823E53B18C4833037FCE13C2476B");
  objective_setbackground(var_0.customwaypointid, 1);
  objective_setshowoncompass(var_0.customwaypointid, 1);
  var_1 = scripts\engine\utility::getStruct("_encstr_81D915D1AD3A97B1F537E2AEC28CFADA164ED6ACE4BE4C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  objective_setlocation(var_0.customwaypointid, 0, var_1.origin);
  var_0 scripts\cp\cp_objectives::_id_1317E(var_0, var_1.origin);
  scripts\cp\cp_objectives::_id_11F80(var_0.customwaypointid);
  scripts\cp\utility::skydivestreamhintdvars("_encstr_B28F063A6B8EE5B1");
  level.little_bird_mg_handleflarerecharge = 1;
}

_id_1387A(var_0) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8876102BA9B153E76D72A2991BCE43CC2059")))
    scripts\engine\utility::flag_set("_encstr_8876102BA9B153E76D72A2991BCE43CC2059");

  scripts\engine\utility::flag_wait("_encstr_A27721A3B61D2FB1EBDC07B0DD37D733EA9B8DA35AF637B9F5C95976D2B9E856935646");
  var_1 = scripts\engine\utility::getStruct("_encstr_81D915D1AD3A97B1F537E2AEC28CFADA164ED6ACE4BE4C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B1E6151DB6D1BCC6EBED5DE863F6DEDAAF9B9B5A0EAC93");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A7280AF6C4D4AF8ED68E97D8");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B4E7135303A7F74B187B23A9895099B61B63586A38");
  var_2 = 15000;

  if(getdvarint("_encstr_B1681DDBAB02267845F1A019A52C30E84BEB37791BAA73C88AD908F0CF19E8", 0) > 0)
    var_2 = 10000;

  waitforanyplayersnearpoint(var_1.origin, var_2);
  scripts\cp\cp_objectives::freeworldid("_encstr_862D1643E989F30441F0BB4BF0B9C32A077C0D7AC1C18A54");
}

inittmtylobj(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8876102BA9B153E76D72A2991BCE43CC2059")))
    scripts\engine\utility::flag_set("_encstr_8876102BA9B153E76D72A2991BCE43CC2059");

  scripts\engine\utility::flag_wait("_encstr_88441A57E059283153EBF88653D776082A5CA7CF97BD50893FD3D1E9");
  scripts\engine\utility::flag_wait("_encstr_A27721A3B61D2FB1EBDC07B0DD37D733EA9B8DA35AF637B9F5C95976D2B9E856935646");
  scripts\engine\utility::flag_set("_encstr_83501A7663A96439BE13C292FDD0D1561B4DD17BD9998F41D3946BBB");
  scripts\engine\utility::flag_wait("_encstr_8BF624E92B51F3F8F6E87B37B3F5D167C8C53725CF9973AF52C3839CD9867FAD48C2A8709769");
  level.initlocationcircle = "_encstr_A7280AF6C4D4AF8ED68E97D8";
  level.initlethalmaxoffsetmap = "_encstr_A7280AF6C4D4AF8ED68E97D8";
  level.tmtyl_vips = [];
  level._id_13BA4 = [];
  level._id_13BA3 = [];

  for(var_2 = 1; var_2 <= 6; var_2++)
    level._id_13BA4[var_2] = scripts\cp\cp_objectives::requestworldid("_encstr_A6A0156C41DCE99577CBC36B879821F42571FB4ADB2B69" + var_2);

  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("_encstr_BD540E0328A9608BDE9447522181A7EF", 15);
  var_0.numleadersinterrogated = 0;
  var_0.leadersinterrogated = [];
  var_0.leaderskilledprematurely = 0;

  for(var_2 = 1; var_2 <= 5; var_2++)
    var_0.leadersinterrogated[var_2] = 0;

  level.tmtyl_customworldid = var_0.customwaypointid;
  objective_setplayintro(var_0.customwaypointid, 0);
  objective_setplayoutro(var_0.customwaypointid, 0);
  objective_state(var_0.customwaypointid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(var_0.customwaypointid, &"_encstr_8E5122839756B3220F3131B9C937AD7B2CF50B6C83DF173A8759E960E9EB913347489EE4");
  objective_icon(var_0.customwaypointid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(var_0.customwaypointid, 1);
  objective_setshowoncompass(var_0.customwaypointid, 1);
  scripts\cp\cp_objectives::_id_11F80(var_0.customwaypointid);
  setobjectivemarkerpos(var_0);
}

starttmtylobj(var_0, var_1) {
  thread _id_1434B();
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_848413CBC32D837CF149E5EF0119AB2A0B51375B67");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8F4B0F786FACFA09395E898577517D83E7");
  _id_13F67(var_0);
  thread maxxpcap(var_0, 1);
  waitframe();
  thread maxxpcap(var_0, 4);
  thread _id_14351(8);
  level scripts\engine\utility::waittill_all_in_array(["_encstr_BD3A17E89A53A3D82713DFD5191366FB7182B8B8E3EDC393A7", "_encstr_8DB11747B6472F8D7D6E2EBA0B32D70DEBC6BDB50E1B2B47B2"]);
  wait 4;
  thread maxxpcap(var_0, 2);
  waitframe();
  thread maxxpcap(var_0, 3);
  level scripts\engine\utility::waittill_all_in_array(["_encstr_9A7E170B4B0492F9D7BFB38001B1503AE706FF7D1B93F915F5", "_encstr_8E2017D1AD8E97C6D7CDB85D0B19F5CC7D6CB7B6E063B2D156"]);
  wait 4;
  thread maxxpcap(var_0, 5);
  waitframe();
  thread maxxpcap(var_0, 6);
  level scripts\engine\utility::waittill_all_in_array(["_encstr_83E017E8DA8EE5C6EBE62E57B0C8F56AAF36ED6B838D9547CA", "_encstr_AB5A17431A1B7BA069CB5343C18F71640F52B8E83393BD58BF"]);
  wait 4;

  while(istrue(level.tryweaponswitchnag))
    wait 0.5;

  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8E7D288C1ED7C6E0B97D3685CD23EB8E6B472F36FA8DAC58235639FA1BB0078E57E495BE9A470D7D9860", "_encstr_9A8507BA4040188D08");
  wait 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8BBE281D484F59D9E2B110588A3ECFF33FEC1B81976B41C30F7AD0A142D6494B3772AD905553A8776217", "_encstr_9A8507BA4040188D08");
  wait 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_868128C28A2807920827CCC95720110369636BCAF619D70E484BEAEF0FE8E2CB8D1B226113ED5BC9DA09", "_encstr_9A8507BA4040188D08");
}

completetmtylobj(var_0) {
  scripts\cp\cp_objectives::freeworldid("_encstr_BD540E0328A9608BDE9447522181A7EF");

  for(var_1 = 1; var_1 <= 6; var_1++)
    scripts\cp\cp_objectives::freeworldid("_encstr_A6A0156C41DCE99577CBC36B879821F42571FB4ADB2B69" + var_1);

  level.tmtyl_vips = undefined;
  level._id_13BA4 = undefined;
  level._id_13BA3 = undefined;
  wait 3;
  scripts\mp\brclientmatchdata::getprophealth("_encstr_8215098EAD8EBCB1AF1C26");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8A1B0E5AB87D711F5325E2FFCFFBE744");
  thread scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
  level.little_bird_mg_handleflarerecharge = 0;
}

_id_1434B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_81D915D1AD3A97B1F537E2AEC28CFADA164ED6ACE4BE4C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  waitforanyplayersnearpoint(var_0, 3000);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_93A32B2F3AC9532B9E9FB797D34F019CB043E0B576F81DF2FCE9ABB715E34ACFA08E1E3A0B70AF8AC68157C6B9", "_encstr_9A8507BA4040188D08");
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B"));
}

maxxpcap(var_0, var_1) {
  thread spawnsquads(var_1);
  level waittill("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + var_1 + "_encstr_8B700AC1463F4F994C5A805A");
}

_id_14351(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B4E7135303A7F74B187B23A9895099B61B63586A38", 1);
}

setobjectivemarkerpos(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_922C1531B5CB18F9B7F3931BBA333802A91CAB93247788", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    objective_setlocation(var_0.customwaypointid, 0, var_1.origin);
    var_0 scripts\cp\cp_objectives::_id_1317E(var_0, var_1.origin);
  }
}

_id_13F67(var_0) {
  objective_delete(var_0.customwaypointid);
}

any_enemy_nearby(var_0) {
  thread _id_13BA5(var_0);
}

_id_13BA5(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  var_1.script_goal_radius = 20;
  self waittill("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_1.script_goal_radius = 2000;
  var_1.script_origin_other = var_1.origin;
  var_2 = var_0.group_name[12];
  level waittill("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + var_2 + "_encstr_8B700AC1463F4F994C5A805A");
  var_1.script_origin_other = undefined;
  var_1.script_goal_radius = 512;
  var_1 thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

_leaderafterspawnfunc(var_0) {
  thread leaderafterspawnfunc(var_0);
}

leaderafterspawnfunc(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");
  var_1 = self;
  var_1.leader_index = int(var_1.enemy_group[12]);
  level.tmtyl_vips[var_1.leader_index] = var_1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  objective_setplayintro(level._id_13BA4[var_1.leader_index], 0);
  objective_setplayoutro(level._id_13BA4[var_1.leader_index], 0);
  objective_state(level._id_13BA4[var_1.leader_index], "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(level._id_13BA4[var_1.leader_index], &"_encstr_8E5122839756B3220F3131B9C937AD7B2CF50B6C83DF173A8759E960E9EB913347489EE4");
  objective_icon(level._id_13BA4[var_1.leader_index], "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(level._id_13BA4[var_1.leader_index], 1);
  objective_setshowoncompass(level._id_13BA4[var_1.leader_index], 1);
  var_2 = scripts\engine\utility::getStruct("_encstr_81D915D1AD3A97B1F537E2AEC28CFADA164ED6ACE4BE4C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  objective_onentity(level._id_13BA4[var_1.leader_index], var_1);
  objective_setzoffset(level._id_13BA4[var_1.leader_index], 70);
  scripts\cp\cp_objectives::_id_11F80(level._id_13BA4[var_1.leader_index]);
  var_1.a.disablelongdeath = 1;
  var_1.never_kill_off = 1;

  if(isDefined(var_1.unittype) && var_1.unittype != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    var_1.maxhealth = 250;
    var_1.health = var_1.maxhealth;
  }

  var_1 scripts\cp\cp_modular_spawning::give_soldier_armor();
  var_1 scripts\cp\cp_modular_spawning::give_soldier_helmet();
  var_1.script_goal_radius = 2000;
  var_1.script_origin_other = var_1.origin;
  var_1.isremotekillstreaktabletweapon = "_encstr_BA350853C128FB939DB9";
  var_1 thread scripts\cp\cp_squadmanager::removefromsquad();
  var_1 thread watchforvipdeath(var_1.leader_index);

  if(var_1.leader_index == 5)
    thread _id_14452(var_1);

  if(var_1.leader_index == 3)
    var_1 thread createkillchallengeevent();
}

_id_13E07(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_84960C15798393242E4AA3886599" + var_0 + "_encstr_92480869F853CE0321BE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    if(istrue(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(var_1.origin)))
      level thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + var_0 + "_encstr_8D9706B0C41F8037");
  }
}

_id_14452(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = getEnt("_encstr_AD1B148B5D7CC039E183F9EBFFBAE8681237B0A187D5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    magicgrenademanual("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", var_1.origin, (0, 0, 0), 0.2, var_0);
    break;
  }
}

createkillchallengeevent() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_8E2017D1AD8E97C6D7CDB85D0B19F5CC7D6CB7B6E063B2D156");
  self.suicidebomberchants = 0;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self.scripted_mode = 1;
  waitforanyplayersnearpoint(self.origin, 500, 1);
  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
  self.ignoreall = 0;
  self.dontevershoot = 0;
  self.scripted_mode = 0;
}

_id_13BA2(var_0) {
  thread any_alive_player_in_kill_zone_or_under_bridge_zone(var_0);
}

any_alive_player_in_kill_zone_or_under_bridge_zone(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.suicidebomberchants = 0;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self.scripted_mode = 1;
  waitforanyplayersnearpoint(self.origin, 300, 1);
  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
  self.ignoreall = 0;
  self.dontevershoot = 0;
  self.scripted_mode = 0;
}

changeheadicontext(var_0, var_1) {
  switch (var_1) {
    case "_encstr_A6C7065BACB1CA95":
      objective_setlabel(level._id_13BA4[var_0], "_encstr_81DF1C23C199B5634A9E3950073B9379995B99A467314B27D0F420480D1D");
      break;
    case "_encstr_9BDA0D2D738D16E0161B2D47C2D12B":
      objective_setlabel(level._id_13BA4[var_0], "_encstr_B4BC1F6814BEA709947D2A6A2AAC62FA225214629EE8AA54E55129547D11D3AB27");
      break;
    case "_encstr_B1550795F7FAFB3034":
    default:
      objective_setlabel(level._id_13BA4[var_0], "_encstr_A9DE2090211F4D93DC20DCCD5D465381C17138D87177B3C75885DF3675AE075C69B1");
      break;
  }
}

lastplundereventtype(var_0) {
  objective_delete(level._id_13BA4[var_0]);
}

doleadersurrender(var_0, var_1, var_2) {
  if(isalive(var_2)) {
    var_2.isremotekillstreaktabletweapon = "_encstr_83860CDABDED2B75D838B7E318B1";
    var_2 notify("_encstr_83860CDABDED2B75D838B7E318B1");
    var_2.scripted_mode = 0;
    var_2.ignoreall = 1;
    var_2.dropweapon = 1;
    var_2 scripts\asm\shared\mp\utility::burndowntime("_encstr_974611FB48E03F6A6FEF8797DD167276285172");
    var_2 thread manageparachute(var_2, var_1);
    thread changeheadicontext(var_0, "_encstr_9BDA0D2D738D16E0161B2D47C2D12B");
    level._id_13BA3[var_0] makeusable();
    var_2.isplayerindanger_think = "_encstr_A18008BD35E222F01BD0";
    var_2 thread loopidlesurrenderanimation("_encstr_9969166304F341B1E09F2650259B1198B5F7B668AB5DB520");
    waitframe();
    var_2 thread watchfornearfriendliesandrevive();
  }
}

manageparachute(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");
  var_0 endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");
  wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_8E1417E822AB5058AE82272BAC1988807BCAC3339AC7F79047"));

  for(;;) {
    var_2 = scripts\engine\utility::ter_op(randomint(2) > 0, "_encstr_A5FA278CC3D71B0EE6EBD62CAD58EBD16BA3CBD8FAD8CA0BC859C9FACDB2584E36D07DCD85B3AF98C0", "_encstr_BAFA27C8C3F53607CDAF5B58D6C27DD16BD1BC8DD7D8560B9156937D372BC293C60DFA73169DF5190C");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_2, "_encstr_9A8507BA4040188D08");
    wait 15;
  }
}

doleaderstun(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.isremotekillstreaktabletweapon = "_encstr_8ED90887F39B73AD5BFF";
  var_1.scripted_mode = 0;
  var_1.ignoreall = 1;
  var_1 scripts\asm\shared\mp\utility::burndowntime("_encstr_8C711293B86087078B8FB93D39E97FF9809C8BE5");
  wait 0.1;
  var_1 thread doleaderreturntocombat();
}

_id_136B9(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2D9154FD2C1AFD1A556D71AB0CD91C6ABCC33B9D7DD5B");
  var_1.angles = var_0.angles;
  var_0.ziptie = var_1;
  return var_1;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

doleaderfinalsurrender(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.tmtyl_vips[var_1]) && isalive(level.tmtyl_vips[var_1]))
    var_2 = level.tmtyl_vips[var_1];
  else
    return;

  var_2 endon("_encstr_AD75063D571AE108");
  var_2 notify("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");
  var_2 takeweapon(var_2.weapon);
  var_2.invulnerable = 1;
  var_0.ability_invulnerable = 1;
  var_0.restoreweapon = var_0 getcurrentweapon();
  var_3 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0.gunlessweapon = var_3;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_5 = var_0.angles;
  var_6 = var_0.origin;
  var_0 cameraset("_encstr_ADF219108F65A9E5EA215E5D02931710EF1F9390D714A65DD1D6CF");
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  _id_12DA0(var_2, var_0);
  waitframe();
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_7 = var_2 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_A7E415302870C7C2B7F137035E234056C597FE5905C0A5");
  var_8 = var_2 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_7);
  var_0 thread create_player_rig(var_0, "_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C");
  var_2 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_955B0CA2F80DAFA2D09737398940");
  link_player_to_rig(var_0);
  var_0.player_rig hide();
  var_9 = getanimlength(%_encstr_9A602686174107C7055258C1E5B18634482B787A4A60BFB18B0AF02EC781D237C801636B51114DCB);
  var_2.scripted_mode = 1;
  var_2.ignoreall = 1;
  var_10 = _id_136B9(var_2);
  var_10 useanimtree(#animtree);
  var_10.animname = "_encstr_958F07E95AE03A5A95";
  var_11 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_2.origin);
  var_11.origin = var_2.origin;
  var_11.angles = var_2.angles;
  var_12 = getstartorigin(var_11.origin, var_11.angles, var_8);
  var_13 = getstartangles(var_11.origin, var_11.angles, var_8);
  var_2 dontinterpolate();
  var_2 forceteleport(var_12, var_13);
  var_0 setplayerangles(var_13);
  var_0 setOrigin(var_12);
  var_10.origin = var_12;
  var_10.angles = var_13;
  waitframe();
  var_0 thread _id_13BCB(var_0, 1);
  var_11 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_955B0CA2F80DAFA2D09737398940");
  var_11 thread scripts\common\anim::anim_single_solo(var_10, "_encstr_955B0CA2F80DAFA2D09737398940");
  var_2 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_7);
  wait(var_9);
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 cameradefault();
  var_0 setplayerangles(var_5);
  var_0 setOrigin(var_6);
  var_0 thread _id_13BCB(var_0, 0);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_3);
  var_0 switchtoweapon(var_0.restoreweapon);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0.ability_invulnerable = undefined;
  level thread give_surrendered_intel(var_0);
  var_2.angles = var_2.angles + (0, 180, 0);
  var_2 thread loopidlesurrenderanimation("_encstr_994D1A4B60C9F1AF13B8637DC6BB7F4519E89351B85D7727681D7465", 1);
  var_2 thread viphud_setupvisibility(120);
  level thread midtruck();
  level notify("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + var_1 + "_encstr_8B700AC1463F4F994C5A805A");
  var_11 delete();
}

_id_13BCB(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"));
    var_2 setModel("_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365");
    var_2 linkTo(var_0, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
    var_0._id_14044 = var_2;
  } else if(isDefined(var_0._id_14044))
    var_0._id_14044 delete();
}

_id_12DA0(var_0, var_1) {
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 linkTo(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_4 = vectortoangles(var_3);
  var_2 rotateTo(var_4, 0.4);
  wait 0.4;
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 forceteleport(var_0.origin, var_4);
  var_2 delete();
}

viphud_setupvisibility(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);

  if(isDefined(self.ziptie))
    self.ziptie delete();

  if(isalive(self))
    self kill();
}

give_surrendered_intel(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 1;
  var_0 scripts\cp\intel\cp_intel::give_intel_weapon("_encstr_B65F184BDC3AB236EBE05D8ED75D6E13BEA5CDFA4758C46359A3");
}

doleaderreturntocombat() {
  scripts\asm\shared\mp\utility::bunkercounteruav();
  self.ignoreall = 0;
  self.entered_combat = 1;
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A7280AF6C4D4AF8ED68E97D8");
  thread changeheadicontext(self.leader_index, "_encstr_B1550795F7FAFB3034");
  thread leaderwaitformelee(self.leader_index);
  thread _id_144E4(self.leader_index);
  self notify("_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");
  self.isremotekillstreaktabletweapon = "_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83";
}

midtruck() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A7280AF6C4D4AF8ED68E97D8");
  var_0.numleadersinterrogated++;
  var_1 = var_0.numleadersinterrogated;

  while(istrue(level.tryweaponswitchnag) || istrue(level.announcer_vo_playing))
    wait 1;

  level.tryweaponswitchnag = 1;

  switch (var_1) {
    case 1:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_96E128CD83613F4B4B277440808A81139F7CEB3AE93408C95F0782B95F09A868EBE3816FB25F8089BA4A", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_934B293287BE1BE0B9AF2C5C634B56D7A3D68EF28D7DD8B2C223CA27FA6C580E475D9CAC7DC437E8BE6418", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B6E12881882090A9561F2B5FF3A90E90031BF13C4610ADB1CDBF56AF77C6C7D3D503F990C29BE5A13398", "_encstr_9A8507BA4040188D08");
      break;
    case 2:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8A322975303721B18AA968E0B224437E73DD85738C8F88D3760270E0797E03D32B6D0EE527527029D13FD2", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9BC528ECBB6E0F629F89DA72309391EB8025696C40505FEE69A053A958EB12237B8EFD274EF88339AD22", "_encstr_9A8507BA4040188D08");
      break;
    case 3:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8A322975303721B18AA968E0B224437E73DD85738C8F88D3760270E0797E03D32B6D0EE527527029D13FD2", "_encstr_9A8507BA4040188D08");
      break;
    case 4:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9BC528ECBB6E0F629F89DA72309391EB8025696C40505FEE69A053A958EB12237B8EFD274EF88339AD22", "_encstr_9A8507BA4040188D08");
      break;
    case 5:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_82AF28B421290E1B660E2AE230356F0340D13134D718D7278561C309799F8B7B2845A5BF67B05F1717B3", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_924928DA58274E53E328EB19D94927539B90B3D2F929874F392DFA2FE611E31B0358FA79F2AD3F7F9BAF", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B2DD280A1BF797FB878FB8866763C8A3A8E84808EF85757127190D293E0969EDB718E319129D2DA877BA", "_encstr_9A8507BA4040188D08");
      break;
    case 6:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A21828460FEB1B83E6BEC6B0738CBE8EDA8E2F8DD78D95B04659937DD82CC13AEA4E59BE86D143EB4C06", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_82F428B25B877A5943E908612071F15D7AE0A30159D38A239777DB99DAF953A1BD6D5D301BDDFA5653D2", "_encstr_9A8507BA4040188D08");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AD0228C8C3FA8D0E6ED71BB0E6CDF5D15BD12F63F5B1562C9156C9BE36C2E0D1D593CAAFA13AA1D7CC03", "_encstr_9A8507BA4040188D08");
      break;
  }

  level.tryweaponswitchnag = 0;
}

loopidlesurrenderanimation(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");
  self endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");
  var_2 = self;
  self.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self.anchor.angles = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_3 = var_2 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_4 = var_2 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
  var_5 = getanimlength(var_4);
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_2.origin);
  var_6.angles = var_2.angles;
  var_7 = getstartorigin(var_6.origin, var_6.angles, var_4);
  var_8 = getstartangles(var_6.origin, var_6.angles, var_4);
  var_2.anchor.origin = var_7;
  var_2.anchor.angles = var_8;
  var_2 dontinterpolate();
  var_2 forceteleport(var_7, var_8);
  var_2 linkTo(self.anchor);
  var_2.scripted_mode = 0;
  var_2.ignoreall = 1;
  thread _id_144B5();

  for(;;) {
    if(istrue(var_1) && isDefined(var_2.ziptie)) {
      var_9 = var_7;
      var_10 = var_8;
      var_6 thread scripts\common\anim::anim_single_solo(var_2.ziptie, "_encstr_A7C5056BD931D1");
    }

    var_2 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
    wait(var_5);
  }
}

_id_144B5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A6("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693", "_encstr_AD75063D571AE108", "_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");

  if(isDefined(self.anchor))
    self.anchor delete();
}

watchfornearfriendliesandrevive() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");
  self endon("_encstr_ABDE1BC193329B2B42E153CB162AC0DD3AF74B756B9AE6F86B0318A0FD");
  self endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");

  for(;;) {
    if(arefriendliesnear()) {
      level._id_13BA3[self.leader_index] makeunusable();
      self.isplayerindanger_think = "_encstr_99F51E8C2DCD0B26B1AC2380C4E50273B20BC998BC40664E5AB2CD32B12DAC9B";
      doleaderreturntocombat();
    }

    wait 2;
  }
}

arefriendliesnear() {
  var_0 = 0;
  var_1 = getaiarrayinradius(self.origin, 300, "_encstr_8E8405EA382B2A");
  var_1 = scripts\engine\utility::array_remove(var_1, self);

  if(var_1.size > 0)
    var_0 = 1;

  return var_0;
}

calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(distance2d(var_3.origin, var_0) <= 400)
      return 1;
  }

  return 0;
}

watchforvipdeath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");
  self waittill("_encstr_AD75063D571AE108", var_1);

  if(isDefined(level.tmtyl_customworldid))
    objective_unsetlocation(level.tmtyl_customworldid, var_0);

  level.tmtyl_vips[var_0] = undefined;
  level notify("_encstr_B29F08D00ADF6578D217" + var_0 + "_encstr_9A6508899AF07BD92B82");
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A7280AF6C4D4AF8ED68E97D8");

  if(isDefined(level._id_13BA3[var_0])) {
    level._id_13BA3[var_0] makeunusable();
    level._id_13BA3[var_0] delete();
  }

  lastplundereventtype(var_0);
  thread minigun_tag(var_0);
}

waittoshameplayer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 3;
}

_id_135F1(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_970F0C6937C33BE8CF0B31A87988" + var_0);
}

spawnsquads(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0 == 3)
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_86C6169B937DD32CC15B727B313057CF40256F77752DAB0B");

  thread _id_13E07(var_0);

  if(var_0 < 6)
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_970F0C6937C33BE8CF0B31A87988" + var_0);

  wait 1;
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + var_0);
  wait 1;
  var_2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + var_0 + "_encstr_92480869F853CE0321BE");
}

_id_144E4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_83860CDABDED2B75D838B7E318B1");
  self endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");

  for(;;) {
    if(arefriendliesnear())
      thread changeheadicontext(var_0, "_encstr_B1550795F7FAFB3034");
    else
      thread changeheadicontext(var_0, "_encstr_A6C7065BACB1CA95");

    wait 0.5;
  }
}

leaderwaitformelee(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8B721A986F54108DB1EB83B11F9A4079FDC7201197BFB8B1CAE795AB", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!arefriendliesnear()) {
      level thread doleadersurrender(var_0, var_1, self);
      return;
    } else {
      thread doleaderstun(var_0);
      return;
    }
  }
}

waitforanyplayersnearpoint(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_2))
    var_2 = 0;

  for(;;) {
    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) <= var_1) {
        if(istrue(var_2)) {
          if(abs(var_4.origin[2] - var_0[2]) <= 100)
            return;
        } else
          return;
      }
    }

    wait 0.5;
  }
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1))
    var_0 setOrigin(var_1);
  else
    var_0 setOrigin(var_0.origin + (0, 0, 100));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

link_player_to_rig(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0.2;

  var_0 playerlinktoblend(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", var_1, 0.25, 0.25);
  wait(var_1);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 1, 1);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_anims() {
  level.scr_animtree["_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C"] = #animtree;
  level.scr_anim["_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C"]["_encstr_955B0CA2F80DAFA2D09737398940"] = % _encstr_9A602686174107C7055258C1E5B18634482B787A4A60BFB18B0AF02EC781D237C801636B51114DCB;
  level.scr_eventanim["_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C"]["_encstr_955B0CA2F80DAFA2D09737398940"] = "_encstr_82AB168653A12892FFBBD7F38F93FA6428BB7A0D29B8D4DA";
  level.scr_animtree["_encstr_958F07E95AE03A5A95"] = #animtree;
  level.scr_anim["_encstr_958F07E95AE03A5A95"]["_encstr_955B0CA2F80DAFA2D09737398940"] = % _encstr_8FAA27C3485FB2800AD78A631F3DF7EB6D836066E8B87F6E63F0B7B67FB7D5A6839F4834A296914EB7;
  level.scr_animname["_encstr_958F07E95AE03A5A95"]["_encstr_955B0CA2F80DAFA2D09737398940"] = "_encstr_8FAA27C3485FB2800AD78A631F3DF7EB6D836066E8B87F6E63F0B7B67FB7D5A6839F4834A296914EB7";
  level.scr_anim["_encstr_958F07E95AE03A5A95"]["_encstr_A7C5056BD931D1"] = % _encstr_95422B0813C1FF71EB41170D25DBBEB3F53BA0088B651FC92B79900807A3A063DF114823823F37E2778825F717;
  level.scr_animname["_encstr_958F07E95AE03A5A95"]["_encstr_A7C5056BD931D1"] = "_encstr_95422B0813C1FF71EB41170D25DBBEB3F53BA0088B651FC92B79900807A3A063DF114823823F37E2778825F717";
}

debugtmtylobjectivesstart(var_0) {
  scripts\engine\utility::flag_set("_encstr_8876102BA9B153E76D72A2991BCE43CC2059");
  scripts\engine\utility::flag_wait("_encstr_88441A57E059283153EBF88653D776082A5CA7CF97BD50893FD3D1E9");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AB3E16EF45D0515B391B0B62468557567027A77BF120A283");
}

istrialslevel(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;)
    waitframe();
}

minigun_tag(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 5));
  var_1 setModel("_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365");
  var_1.index = var_0;
  waitframe();
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A7280AF6C4D4AF8ED68E97D8");
  _id_11A99(var_1);
  _id_13A24(var_1);
}

_id_11A99(var_0) {
  var_1 = &"_encstr_95182271C8991912D3877913FBA9B53F7519CD3149973B3738F7F06FCF1AB537B7E97410";
  var_0 setHintString(var_1);
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(500);
  var_0 sethintdisplayfov(90);
  var_0 setuserange(128);
  var_0 setusefov(90);
  var_0 sethintonobstruction("_encstr_BECC055CF3811A");
  var_0 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_0 makeusable();
  var_0 thread use_think();
  var_0 thread _id_11CE8();
  return var_0;
}

use_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AF760F09BD7B3759E3CA3F6A4DA81EFD98");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player() || istrue(var_0.isjuggernaut)) {
        continue;
      }
      if(scripts\cp\cp_weapon::_id_124AD(var_0)) {
        scripts\cp\cp_weapon::minigamefinishcount(var_0);
        continue;
      }

      level thread give_surrendered_intel(var_0);
      level thread midtruck();
      level notify("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + self.index + "_encstr_8B700AC1463F4F994C5A805A");
      remove_intel_piece();
    }
  }
}

_id_11CE8() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F5C086405E70FBA4B4A");
  var_0 = 5;
  self.heli_yaw = undefined;
  var_1 = 0;

  for(;;) {
    var_2 = scripts\cp\utility::give_closest_player_nearby(self.origin, 16384, "_encstr_9A8507BA4040188D08");

    if(!isDefined(var_2) || istrue(var_2.isjuggernaut)) {
      var_1 = 0;
      wait 1;
      continue;
    } else {
      if(isDefined(self.heli_yaw) && self.heli_yaw == var_2) {
        wait 0.5;
        var_1 = var_1 + 0.5;

        if(var_1 >= var_0) {
          self notify("_encstr_AF760F09BD7B3759E3CA3F6A4DA81EFD98");
          level thread give_surrendered_intel(self.heli_yaw);
          level thread midtruck();
          level notify("_encstr_AAE90DA372BB5B20CFCB077DB14B0E" + self.index + "_encstr_8B700AC1463F4F994C5A805A");
          remove_intel_piece();
        }

        continue;
      }

      self.heli_yaw = var_2;
      wait 0.5;
      var_1 = 0.5;
    }
  }
}

_id_13A24(var_0) {
  var_0.head_icon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.head_icon, "_encstr_8E781B0D5D19BED2B1BD377D0D0B4E8C83F62D37A3EB8C5A0BD6B77323");
  setheadiconsnaptoedges(var_0.head_icon, 0);
  setheadicondrawthroughgeo(var_0.head_icon, 1);
}

remove_intel_piece() {
  playFX(level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"], self.origin);

  if(isDefined(self.head_icon))
    setheadiconimage(self.head_icon);

  self delete();
}