/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_layover\morales_objective\cp_morales_objective.gsc
*************************************************************************/

registermoralesobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(!scripts\engine\utility::flag_exist("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3"))
    scripts\engine\utility::flag_init("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");

  scripts\cp\cp_objectives::registerobjective("_encstr_93D90AD6F627B036CA6ED7C4", ::initmorales_1, ::startmorales_1, ::completemorales_1, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_ABD90AEAD006C75D60B70752", ::initmorales_2, ::startmorales_2, ::completemorales_2, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_A7D90A771F86AAD498C37152", ::initmorales_3, ::startmorales_3, ::completemorales_3, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_9BD90AAD7BC916D8569BEB43", ::initmorales_4, ::startmorales_4, ::completemorales_4, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_99D90A6DDF905EBBBD7BE977", ::initmorales_5, ::startmorales_5, ::completemorales_5, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_8BD90A15A0D829828DDF4FF2", ::initmorales_6, ::startmorales_6, ::completemorales_6, undefined, ::debugmoralesobjectivesstart);
  level thread initobjspawners();
  scripts\cp\cp_pickup_hostage::registerhvtscriptmodels();
  level thread scripts\cp\cp_hacking::hacking_init();

  if(!scripts\engine\utility::flag_exist("_encstr_A5461305B0A20E98282BB70DC757F868BC5DF301F0"))
    scripts\engine\utility::flag_init("_encstr_A5461305B0A20E98282BB70DC757F868BC5DF301F0");

  scripts\engine\utility::flag_set("_encstr_A5461305B0A20E98282BB70DC757F868BC5DF301F0");
}

watchformoralesnearstruct(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel();

  for(;;) {
    var_3 = 0;

    if(distance(level.moraleshostage.origin, var_2.origin) <= var_1)
      var_3 = 1;

    if(var_3) {
      break;
    } else
      wait 0.5;
  }

  level notify("_encstr_9AF10E6BB79CB0B12B9BD7E6B2C29CAF" + var_0);
}

watchformoralesnearpointarray(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(var_2.size < 1) {
    return;
  }
  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel();

  for(;;) {
    var_3 = 0;

    foreach(var_5 in var_2) {
      if(distance(level.moraleshostage.origin, var_5.origin) <= var_1)
        var_3 = 1;
    }

    if(var_3) {
      break;
    } else
      wait 0.5;
  }

  level notify("_encstr_9AF10E6BB79CB0B12B9BD7E6B2C29CAF" + var_0);
}

waitforoneplayernearpoint(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  for(;;) {
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(distance(var_6.origin, var_0) <= var_1)
        var_3 = 1;
    }

    if(var_2) {
      if(!isDefined(level.moraleshostage))
        initmoraleshvtmodel();

      if(distance(level.moraleshostage.origin, var_0) <= var_1)
        var_4 = 1;

      if(var_3 && var_4) {
        break;
      }
    } else if(var_3) {
      break;
    }

    wait 0.5;
  }
}

initmoraleshvtmodel(var_0) {
  if(!isDefined(var_0))
    var_0 = scripts\engine\utility::getStruct("_encstr_979813D56728E67375A3215A2BD587DD13F55523B9", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  level.moraleshostage = scripts\cp\cp_pickup_hostage::initdefaulthvtmodel(var_0, "_encstr_93021917D8EBC96A7B0E69DC783FA391112067B390C00C5257ADE8", undefined, &"_encstr_8B9923D005D79094D7A6954A5AEBF42125510D514A652A4D97145268D2EB9A3D941462159A", "_encstr_B4E2158C93DE83F5B6DE93581BB2CDFA1ADECD1D859DCA", undefined, "_encstr_ABA6101AF69BE8C2B32BBED6F69C0BD8B2DC", 1);
  level.moraleshostage.nowaypoint = 1;
  objective_setplayintro(level.moraleswid, 0);
  objective_state(level.moraleswid, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(level.moraleswid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_onentity(level.moraleswid, level.moraleshostage);
  objective_setzoffset(level.moraleswid, 32);
  objective_setbackground(level.moraleswid, 2);
  objective_setlabel(level.moraleswid, "_encstr_BD3C1A68A0AF9049BE6A2B49A5FAA7099415D02AA4595435BC90B245");
  level.moraleshostage thread monitormoraleswaypoint();
  level.moraleshostage thread _id_144C0(level.moraleshostage);
  scripts\cp\cp_objectives::_id_11F80(level.moraleswid);
}

monitormoraleswaypoint() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B67E107A409637AD902797B529D0B44BB599");
  self endon("_encstr_8A12060D5BA9C745");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_0);
    wait 0.5;
    objective_onentity(level.moraleswid, var_0);
    self waittill("_encstr_88C60846397B83835919");
    wait 0.5;
    objective_onentity(level.moraleswid, self);
  }
}

initmoraleslaptop() {
  if(istrue(level._id_11D26)) {
    return;
  }
  level._id_11D26 = 1;
  var_0 = scripts\engine\utility::getStruct("_encstr_9B081BB57BC95863B2E6D7B1C2C1E8F683D7A5B93ACA9C586CE896DE9B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp\cp_interaction::spawninteractionmodel(var_0, scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 setHintString(&"_encstr_820213DF77C9FF73A440BEDD34EB9D2737A1EF9BE7");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("_encstr_BECC055CF3811A");
  var_1 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_1 thread _id_11D27();
}

_id_11D27() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_AB032281B55120016A3F938F93725950FB412899DAAC90C7E18F9DB1E7AB17D894A4F0F0");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    thread activationmoraleslaptop(self, var_0);
    break;
  }
}

activationmoraleslaptop(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_ABD90AEAD006C75D60B70752");
  var_0 notify("_encstr_8A38124F80B361C2C3B6C10497F78A17FBF8E713");
  var_2 notify("_encstr_99CD1DDBA060C2AB5668EE30D057D857D889600BAA787FD319DAA1731BB783", var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_8B7D0F0852033F194B8BC90948A99F7914");
  level thread scripts\cp\utility::_id_123FE("_encstr_A7E71EE8C868C7C2B7F17F0DD103F8594697689003D025BAB3B8F2B288B99FF7");
  scripts\cp\cp_objective_mechanics::starthackingdefense(var_2, scripts\engine\utility::getStruct("_encstr_841817ED31354CFA242B51AF340B36D6D7D8F6D858A3D2F6E6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin + (0, 150, 50), 120, "_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8", 200);
}

initobjspawners() {
  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31"))
    scripts\engine\utility::flag_init("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_A97E16A0DF904751A25EA92BC6AA58EB718B25F3CAE321D9", 6, 8, 8, 0.5, undefined, "_encstr_93CC0DC3778A18399F331618CA4B4F", undefined, undefined, undefined);
  [[var_0]]("_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A", 12, 20, 200, [::waitbetweenspawnwaveswithtimeout, 0.1, 15], undefined, "_encstr_91CC0D7045F51A8A58BE2F887575AF", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_B8CB17A7CF361A64289321724940B39305173B5391C8671F21", 4, 4, 6, 0.05, undefined, "_encstr_95700F4B2FB327F8C57A465826A24A70F8", undefined, undefined, undefined);
  [[var_0]]("_encstr_ACCB17DAF64E0BC6B2CDD727596EC6ABB2F543ECE8D7CC7D48", 4, 4, 6, 0.05, undefined, "_encstr_B4700F80C8BEB303472BEF785B2AB26E1B", undefined, undefined, undefined);
  [[var_0]]("_encstr_91CB175BED392C63ACE6D739B26E8DD5AC7DA19D8EEB66BE34", 4, 4, 6, 0.05, undefined, "_encstr_B6700FADDE4EC2B1AC6E7DB789A6CCEBA1", undefined, undefined, undefined);
  [[var_0]]("_encstr_8FCB17B6BDE416C6CAE6F593AC9BD8EAACF53467E8F5CCFA22", 4, 4, 6, 0.05, undefined, "_encstr_A6700FD1BD43A3D03D9FB138B35A43A748", undefined, undefined, undefined);
  [[var_0]]("_encstr_95441678E28ADB90B75B808E29D798A37589C8B06AE46F63", 9, 9, 9, 0.05, undefined, "_encstr_B8CC0DD09F75E7E92FDB07EDF21B25", undefined, undefined, undefined);
  [[var_0]]("_encstr_8A03153208DE6FF5D81F5F7FD378FC4F8F03A94A513E0F", 3, 3, 3, 0.05, undefined, "_encstr_8A03153208DE6FF5D81F5F7FD378FC4F8F03A94A513E0F", undefined, undefined, undefined);
  [[var_0]]("_encstr_8EB3167AD04DFE13312ECFFFCFF8C78993D0C14280DF750B", 4, 4, 4, 0.05, undefined, "_encstr_8EB3167AD04DFE13312ECFFFCFF8C78993D0C14280DF750B", undefined, undefined, undefined);
  [[var_0]]("_encstr_B6CD19D6B74E166395E6D7EEB01BADF5B973A50EB293FA982C365B", 4, 4, 4, 0.05, undefined, "_encstr_B6CD19D6B74E166395E6D7EEB01BADF5B973A50EB293FA982C365B", undefined, undefined, undefined);
  [[var_0]]("_encstr_8C061A15A7E8263335E361EB89991711483D9970DBB0E1D366986AE3", 4, 4, 4, 0.05, undefined, "_encstr_8C061A15A7E8263335E361EB89991711483D9970DBB0E1D366986AE3", undefined, undefined, undefined);
  [[var_0]]("_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53", 0, 20, 200, 0.1, undefined, "_encstr_ACCC0D6B7B27B08D59B9EBF62653A9", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B", 0, 6, 6, 0.1, undefined, "_encstr_83501071927B6934B54FF192DDA04B59EB54", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149", 0, 6, 6, 0.1, undefined, "_encstr_8A50101065B2C8F19A1F673F635265F14BF3", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9", 0, 6, 6, 0.1, undefined, "_encstr_A3501099F50BEBA845D7E9708B924B5FE197", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A", 0, 6, 6, 0.1, undefined, "_encstr_974B1792A87ECF5578BF3F07B528CBEF2863EAEBB35D978AB0", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_8BBC1A995FFB19E16773B110AA7DB9905FEC082D97D3EDDB8E7AD0C0", 1, 2, 200, ::waitbetweenbomberwaves, undefined, "_encstr_A24814B398964FC03B97FE78BB7033806EB007B1D8CB", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156", 5, 15, 15, [::waitbetweenspawnwaves, 0.1, 0.1], undefined, "_encstr_AD8D13A57AC0EEDC2D8719A0A15F03BF73A3C0D7AA", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_841C18ADB7395863B2B97D33B09B47BE1BDE1619D743EC47F51B", 5, 15, 15, [::waitbetweenspawnwaves, 0.1, 0.1], undefined, "_encstr_9B4912772FA87F75685AA95FC6F3E21FFD331090", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_A3820FDAED4E0B1B59B9D70D591B4BD74C", 0, 6, 6, 0.1, 0, "_encstr_A3820FDAED4E0B1B59B9D70D591B4BD74C", undefined, ::reset_recharge_after_respawn, undefined);
  [[var_0]]("_encstr_AC820F900A62C3889F63B82B4D8310F7DA", 0, 6, 6, 0.1, 0, "_encstr_AC820F900A62C3889F63B82B4D8310F7DA", undefined, ::reset_recharge_after_respawn, undefined);
  [[var_0]]("_encstr_93801671A703E1098FEB19A8A2E5DBFEA74007760FF7E949", 0, 6, 6, 0.1, 0, "_encstr_93801671A703E1098FEB19A8A2E5DBFEA74007760FF7E949", undefined, ::reset_recharge_after_respawn, undefined);
  [[var_0]]("_encstr_B42F0E7F25A827A9E50FA1FBE268B1CF", 6, 6, 6, 0.1, undefined, "_encstr_B42F0E7F25A827A9E50FA1FBE268B1CF", undefined, undefined, undefined);
  [[var_0]]("_encstr_B40E125D2A0D8ADDE76B19AAD9E2B3EB7A870827", 0, 24, undefined, 0.1, ::unset_pre_wave_spawning, "_encstr_847A1750874A19E97AFAB02F56431DED8CAF58106BE5118163", ::init_pre_wave_spawning, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B40E125D2A0D8ADDE76B19AAD9E2B3EB7A870827", scripts\cp\cp_modular_spawning::set_pre_wave_spawning_spawn_funcs);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B8CB17A7CF361A64289321724940B39305173B5391C8671F21", ::morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_ACCB17DAF64E0BC6B2CDD727596EC6ABB2F543ECE8D7CC7D48", ::morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91CB175BED392C63ACE6D739B26E8DD5AC7DA19D8EEB66BE34", ::morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8FCB17B6BDE416C6CAE6F593AC9BD8EAACF53467E8F5CCFA22", ::morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B6CD19D6B74E166395E6D7EEB01BADF5B973A50EB293FA982C365B", ::watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8C061A15A7E8263335E361EB89991711483D9970DBB0E1D366986AE3", ::watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8EB3167AD04DFE13312ECFFFCFF8C78993D0C14280DF750B", ::watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8A03153208DE6FF5D81F5F7FD378FC4F8F03A94A513E0F", ::watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B", ::watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149", ::watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9", ::watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A", ::watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53", ::spawn_loot_pickups);

  if(!scripts\engine\utility::flag_exist("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3"))
    scripts\engine\utility::flag_init("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");

  scripts\engine\utility::flag_set("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
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

waitbetweenspawnwaves(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount <= var_0.max_size && var_0.activecount)
      wait 0.1;

    wait 1;
  }

  if(var_0.activecount <= var_0.min_size)
    return var_1;
  else
    return var_2;
}

waitbetweenspawnwaveswithtimeout(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = gettime();
  var_5 = var_4 + var_2 * 1000;

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount >= var_0.max_size && gettime() <= var_5)
      wait 0.1;
  }

  return var_1;
}

waitbetweenbomberwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_99D90A6DDF905EBBBD7BE977");

  if(!isDefined(var_1.currentteam)) {
    return;
  }
  while(are_all_players_on_watchtower(var_1.currentteam))
    wait 2;

  return randomint(10) + 5;
}

spawn_loot_pickups(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.goalradius = 1024;
  self.script_origin_other = scripts\engine\utility::getStruct("_encstr_BD8214681DBAC0F982175F094F0A31E94D7673200702", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
}

are_all_players_on_watchtower(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_953313E8DEDD959C89EBAE8338CA39AF8DCAEC561B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_1))
    return 0;

  var_2 = 1;
  var_3 = scripts\cp\utility::getplayersinteam(var_0);

  foreach(var_5 in var_3) {
    if(distance(var_5.origin, var_1.origin) > 300) {
      var_2 = 0;
      break;
    }
  }

  return var_2;
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);

  if(var_0.group_name == "_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A")
    level thread watchforoverseerskilled(var_0);
  else if(issubstr(var_0.group_name, "_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53"))
    level thread swapcoverselector(var_0);
}

swapcoverselector(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");

  for(;;) {
    if(!isDefined(var_0.ai_spawned)) {
      wait 3;
      continue;
    }

    foreach(var_2 in var_0.ai_spawned) {
      if(!istrue(var_2.swappedcoverselector)) {
        var_2.defaultcoverselector = "_encstr_958A118DDBECB29C7DDCD0EDA3B3D5B9B92B9C";
        var_2.swappedcoverselector = 1;
      }
    }

    wait 1;
  }
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify(var_0.moduleid + "_encstr_97E315EBBB58E81B1AEBCCF6E4F5CDD1B7C1DD0BCEACCD");
  level endon(var_0.moduleid + "_encstr_97E315EBBB58E81B1AEBCCF6E4F5CDD1B7C1DD0BCEACCD");
  level scripts\engine\utility::_id_143A7("_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8", "_encstr_A94819D67B9CB0B12BB9BE86BDD846F6BA1DEBCC2D734B9B862BC8", "_encstr_B67E107A409637AD902797B529D0B44BB599", "_encstr_AA8120557F53BBFDDFD0874B25BDE2B775C0BCF310573447E9EA73E3775187E88635");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

watchforstep5rushplayertimer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 0;

  while(var_1 <= 10) {
    var_1++;
    wait 1;
  }

  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

watchforstep4chaseplayerstopool(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_95A72717D8EBC96A7B0E695D7D1BC3AF5070D3AF58E1138157AE2C1956D9EA4BF989430F29FB77CAB9");
  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

watchforoverseerskilled(var_0) {
  level endon("_encstr_93671AB6B793B03659DC7D0DB7D891BD5747AF1B7BDA07C6ACE8B28C");
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");

  while(var_0.currentmodulekills < 10)
    wait 0.5;

  if(isDefined(level.objectivestabledata["_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53"]))
    level.objectivestabledata["_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53"].earnedfastexfil = 1;
}

getnextholdoutspawnmodule(var_0) {
  if(!istrue(level.inmoralesholdout))
    return undefined;

  var_1 = 0;

  for(var_2 = getaiarray("_encstr_8E8405EA382B2A").size; var_2 > 20; var_2 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 1;

  var_3 = undefined;

  switch (var_0.group_name) {
    case "_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B":
      var_3 = "_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149";
      break;
    case "_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149":
      var_3 = "_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9";
      break;
    case "_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9":
      var_3 = "_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A";
      break;
    case "_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A":
      var_3 = "_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B";
      break;
    default:
      var_3 = undefined;
      break;
  }

  return var_3;
}

reset_recharge_after_respawn(var_0) {
  if(!istrue(level.inmoralesholdout))
    return undefined;

  wait 10;

  while(var_0.activecount > 1)
    wait 1;

  if(!istrue(level.inmoralesholdout))
    return undefined;

  var_1 = var_0.group_name;

  switch (var_0.group_name) {
    case "_encstr_93801671A703E1098FEB19A8A2E5DBFEA74007760FF7E949":
      var_1 = "_encstr_A3820FDAED4E0B1B59B9D70D591B4BD74C";
      break;
    case "_encstr_A3820FDAED4E0B1B59B9D70D591B4BD74C":
      var_1 = "_encstr_AC820F900A62C3889F63B82B4D8310F7DA";
      break;
    case "_encstr_AC820F900A62C3889F63B82B4D8310F7DA":
      var_1 = "_encstr_93801671A703E1098FEB19A8A2E5DBFEA74007760FF7E949";
      break;
  }

  return var_1;
}

debugmoralesobjectivesstart(var_0) {
  scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");
  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_96F31821F753B179FF9B4998925633098F7335AF4293BEB1A5A2");
}

initmorales_1(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD")))
    scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
  level.initlocationcircle = "_encstr_93D90AD6F627B036CA6ED7C4";
  level.initlethalmaxoffsetmap = "_encstr_93D90AD6F627B036CA6ED7C4";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_AB010880F54238016A8F");

  if(!isDefined(level.moraleswid))
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  level thread initmoraleslaptop();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B40E125D2A0D8ADDE76B19AAD9E2B3EB7A870827");
  level thread scripts\cp\utility::_id_123FE("_encstr_A5C216206DCA81F99347BA0D40CA13632BFDFECA1309AA5B");
  level.little_bird_mg_handleflarerecharge = 1;
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
}

startmorales_1(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  var_2 = scripts\engine\utility::getStruct("_encstr_8E62134790B39FF02BB12B2EC2395387A1D794E066", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  waitforoneplayernearpoint(var_2.origin, 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A97E16A0DF904751A25EA92BC6AA58EB718B25F3CAE321D9");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AF41262520C728279B176018871FEF8AC1731F505801733B8266108DC260496DBB86A893E0FFC33B", "_encstr_9A8507BA4040188D08");
  waitforoneplayernearpoint(var_2.origin, 700, 0);
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AA41268CF07D6C0EB9AF362C6EDCFAC92BB91BEACAFA1A675AF5B5B739B08D56DC7DDC0BECFA1906", "_encstr_9A8507BA4040188D08");
  wait 2;
}

completemorales_1(var_0) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_ABD90AEAD006C75D60B70752");
}

initmorales_2(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD")))
    scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
  level.initlocationcircle = "_encstr_93D90AD6F627B036CA6ED7C4";
  level.initlethalmaxoffsetmap = "_encstr_93D90AD6F627B036CA6ED7C4";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_AB010880F54238016A8F");
  level initmoraleslaptop();
  level notify("_encstr_AB032281B55120016A3F938F93725950FB412899DAAC90C7E18F9DB1E7AB17D894A4F0F0");

  if(!isDefined(level.moraleswid))
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
}

startmorales_2(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  thread nag_player_for_laptop(var_0);
  var_0 waittill("_encstr_99CD1DDBA060C2AB5668EE30D057D857D889600BAA787FD319DAA1731BB783");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A");
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  wait 2;
  level notify("_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8");
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
  wait 2;
}

completemorales_2(var_0) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A7D90A771F86AAD498C37152");
}

nag_player_for_laptop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_99CD1DDBA060C2AB5668EE30D057D857D889600BAA787FD319DAA1731BB783");

  for(;;) {
    wait 30;
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B2772694EBC97FD9F36118E9F2E1E7C562ABB0FB37806BE3F0C970F07520D08FFBBE982927262BC7", "_encstr_9A8507BA4040188D08");
  }
}

initmorales_3(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD")))
    scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
  level.initlocationcircle = "_encstr_93D90AD6F627B036CA6ED7C4";
  level.initlethalmaxoffsetmap = "_encstr_93D90AD6F627B036CA6ED7C4";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_AB010880F54238016A8F");
  var_2 = randomintrange(1, 3);
  var_3 = undefined;

  switch (var_2) {
    case 0:
    default:
      var_3 = "_encstr_994C0238";
      break;
    case 1:
      var_3 = "_encstr_8B4C0248";
      break;
    case 2:
      var_3 = "_encstr_834C02D0";
      break;
  }

  var_4 = scripts\engine\utility::getStructArray("_encstr_B4D410B6F64EB036CA6EFA43B3D1EBB17BC6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(var_7.targetname == var_3) {
      var_5 = var_7;
      break;
    }
  }

  var_0.spawngroup = var_3;

  if(!isDefined(level.moraleswid))
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  initmoraleshvtmodel(var_5.origin);
  var_0 scripts\cp\cp_objectives::_id_1317E(var_0, level.moraleshostage.origin);
}

startmorales_3(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B189290B5876C3A34FAFADE67E37299A59989FF718AE300B5338B59EE711E240A6F05F27D0416303E7E6AA", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_87861630AAC2A3E8FF03D846ED5FF143EF319050B3D17FC6" + var_0.spawngroup);
  thread domoralestiedanim(level.moraleshostage);
  waitforoneplayernearpoint(level.moraleshostage.origin, 200, 0);
  level.moraleshostage thread scripts\cp\utility::playsoundatpos_safe(level.moraleshostage.origin, "_encstr_A22C28C8C3EB36836EFA234E53B6AF4ECA9BC6BA56D7D0D92DBECCF65DCDC8D7C685C6D8BDABA3AF6218");
  level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_2);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "_encstr_950B0CEDC4D47D380BD8B50B9D59");
  level thread scripts\cp\utility::_id_123FE("_encstr_93511F11DD674677AA49C85802020DD98F75B0992F9B49A1D79341507ADEF7939B");
  wait 4;
  level.moraleshostage thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_933E212AA8D7BEA333F8343A0A985782DB98C2B3F87FB443A8C02829966027CA070A7F", "_encstr_9A8507BA4040188D08");
}

completemorales_3(var_0) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_9BD90AAD7BC916D8569BEB43");
}

initmorales_4(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD")))
    scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
  level.initlocationcircle = "_encstr_93D90AD6F627B036CA6ED7C4";
  level.initlethalmaxoffsetmap = "_encstr_93D90AD6F627B036CA6ED7C4";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_AB010880F54238016A8F");
  var_2 = scripts\engine\utility::getStruct("_encstr_BEE91D87487B59FA8BFE994FEDAD23E766D8736B31B39CF2F7809A42C77F4A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.moraleswid))
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel(var_2.origin);

  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("_encstr_AF6511B2885EEF75589FDFFB43A03D3789269F", 15);
  var_3 = scripts\engine\utility::getStruct("_encstr_8D5D17D6ED9CB08DB237D76BB7CEACBE1DBDFA2C6B26AB9B86", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  objective_setplayintro(var_0.customwaypointid, 1);
  objective_setplayoutro(var_0.customwaypointid, 1);
  objective_state(var_0.customwaypointid, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_0.customwaypointid, var_3.origin);
  objective_setdescription(var_0.customwaypointid, &"_encstr_B6711E68A0EB8449EB6A65292DF53D482551A11552651535E56AF4CA2AFA13A5");
  objective_setlabel(var_0.customwaypointid, &"_encstr_B6711E68A0EB8449EB6A65292DF53D482551A11552651535E56AF4CA2AFA13A5");
  objective_icon(var_0.customwaypointid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(var_0.customwaypointid, 0);
  scripts\cp\cp_objectives::_id_11F80(var_0.customwaypointid);
  var_0 scripts\cp\cp_objectives::_id_1317E(var_0, var_3.origin);
}

startmorales_4(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_960221191EAF6C07B9F58D589B6EEB3956B9D8BACA7DA1D92DD7C1961BB557C1D79860", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B6CD19D6B74E166395E6D7EEB01BADF5B973A50EB293FA982C365B");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8A03153208DE6FF5D81F5F7FD378FC4F8F03A94A513E0F");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8C061A15A7E8263335E361EB89991711483D9970DBB0E1D366986AE3");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8EB3167AD04DFE13312ECFFFCFF8C78993D0C14280DF750B");
  level thread watchformoralesnearpointarray("_encstr_A37D1A771F86AAD498C37145D9D8DF42518787AF972DF2AF5828758D", 2500);
  level thread watchformoralesnearstruct("_encstr_BD8214681DBAC0F982175F094F0A31E94D7673200702", 500);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95441678E28ADB90B75B808E29D798A37589C8B06AE46F63");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_93801671A703E1098FEB19A8A2E5DBFEA74007760FF7E949");
  level waittill("_encstr_A95121B6DE39581BAC9BEB9BAC1693D7DAEDC9B01BCACDF50EEDED1BFAD62C93B5564E");
  level notify("_encstr_AAF22DA7382770D5EFB5F845C020E167E15838392397EB1FC8B747D2CE71D9F3D8F0BCBF3DA768A0271FC032EB3503");
  objective_delete(var_0.customwaypointid);
  scripts\cp\cp_objectives::freeworldid("_encstr_AF6511B2885EEF75589FDFFB43A03D3789269F");
  var_2 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "_encstr_AD830CF6264D7D437B8D465ADCB3"));
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_81C422C8C3EB8D83CDAF362CE6B9EBC959CDB15D56D71AD95AD7DCEAB1B1B2376EEB8960", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_821F2143681F6393FF58B292C5BA010A3BC3EEF3B5318118BFE17D97215890A10FB309", "_encstr_9A8507BA4040188D08");
  wait 1;
}

completemorales_4(var_0) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_99D90A6DDF905EBBBD7BE977");
}

initmorales_5(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD")))
    scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
  level.initlocationcircle = "_encstr_93D90AD6F627B036CA6ED7C4";
  level.initlethalmaxoffsetmap = "_encstr_93D90AD6F627B036CA6ED7C4";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_AB010880F54238016A8F");
  var_2 = scripts\engine\utility::getStruct("_encstr_BEE91D87487B59FA8BFE994FEDAD23E766D8736B31B39CF2F7809A42C77F4A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.moraleswid))
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel(var_2.origin);
}

startmorales_5(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  level thread scripts\cp\utility::_id_123FE("_encstr_A6BB1D41BBFE81C2E311179AADFBCB184F4DFEDFFFE0E3E7A547F71ECE6B39");
  level.inmoralesholdout = 1;
  thread mark_as_bomb_vest_controller_holder(0);
  waitframe();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A3820FDAED4E0B1B59B9D70D591B4BD74C");
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_93D90AD6F627B036CA6ED7C4");

  if(1)
    wait 60;

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BDD52791C37D1BE0CDFAB116CD9BEBC9CA6E8D5D56AFD0D996EB8C5633CAE6237D6C06DC2B8DBE8C81", "_encstr_9A8507BA4040188D08");
  wait 30;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_812C2741D08FC8EFEB9F31333733A0884DEA29FB3F27C8A422B729338B7A7040DF52BBB3A743B97E8F", "_encstr_9A8507BA4040188D08");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AAFE27F2700F766BCB30F4F13E130FFA93D00A7B30B7EC3BE018C4ED5CF98307BF6A9793A8A7E9D2F3", "_encstr_9A8507BA4040188D08");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_998C24D073213FF3CF5739A753E7DEA5176B70D0DA49610B7FAFBEAD5BEFA041FEE328F9374A", "_encstr_9A8507BA4040188D08");
  togglewavespawning(0);
  level.inmoralesholdout = undefined;
  level notify("_encstr_A94819D67B9CB0B12BB9BE86BDD846F6BA1DEBCC2D734B9B862BC8");
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
}

completemorales_5(var_0) {
  level notify("_encstr_93671AB6B793B03659DC7D0DB7D891BD5747AF1B7BDA07C6ACE8B28C");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8BD90A15A0D829828DDF4FF2");
}

initmorales_6(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD")))
    scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");

  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\engine\utility::flag_wait("_encstr_A5E5239BFF63F728358AB60B721938B86933531557AB4B6846E2BE23DFC7F06EB387D59BE3");
  level.initlocationcircle = "_encstr_93D90AD6F627B036CA6ED7C4";
  level.initlethalmaxoffsetmap = "_encstr_93D90AD6F627B036CA6ED7C4";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_AB010880F54238016A8F");
  var_2 = scripts\engine\utility::getStruct("_encstr_BD17144B985A7965AF4BE64B50CD305FC845AD63AF98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_BEE91D87487B59FA8BFE994FEDAD23E766D8736B31B39CF2F7809A42C77F4A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_0.exfilstruct = var_2;

  if(!isDefined(level.moraleswid))
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel(var_3.origin);

  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
}

startmorales_6(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  var_2 = scripts\engine\utility::getStruct("_encstr_922813CB28BA510C0D37CFCB650C8791E2C9C958B0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_8FBE18DAE036970D30C77758F32014275D3B12934E0E1B8660E1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2.vehicletype = "_encstr_8DD90913C62DB585D7D81C";
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156");
  thread _id_13019();
  level.computer_debugtestloop = 1;
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_2, var_0.exfilstruct, var_3, 1);
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B295248A10011FBB6310D391D7ABC9239D8FE8F7A5C79B8B0AFF4108601BE421F0AAC48E71D0", "_encstr_9A8507BA4040188D08");
  level.heli_trip_vehicle waittill("_encstr_935A14831B165EAC9CFA31ED2C9C91CA91AF342B1B5A");
  thread mark_as_bomb_vest_controller_holder(5);
  objective_state(level.moraleswid, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_delete(level.moraleswid);
  level thread _id_1432D();
  level waittill("_encstr_99D81368CB605C77355B8A23C60DFF955BD717EE55");
  thread maxlootleadermarkcount();
  level thread _id_143FF();
  wait 3;
}

completemorales_6(var_0) {
  if(isDefined(level.moraleswid))
    scripts\cp\cp_objectives::freeworldid("_encstr_8BD4103587C806D3D50381F84FA5E773F949");

  scripts\mp\brclientmatchdata::getprophealth("_encstr_87B80821127338B81BE6");
  level.little_bird_mg_handleflarerecharge = 0;
  thread scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
}

_id_1432D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_992621097A3728DDB2DF3F615B0A9F49AF5690062275388D6BF7B12F733270D877ADF9");
  level.moraleshostage thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_857320FDD0390FCBB3C790380BF5666522BAE6FD6FD1C13381AF90601319D8870FF2", "_encstr_9A8507BA4040188D08");
  level thread scripts\cp\utility::_id_123FE("_encstr_A33326300B82DF09AB2FC746E55FD36B6E9229C002DEF1C08B07DDBBC61F584FD6DA20E84AF73959");
}

_id_13019() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    var_2.goal_radius = 256;
    var_2.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);
  }
}

mark_as_bomb_vest_controller_holder(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  var_1 = scripts\engine\utility::getStruct("_encstr_9B5E1719758B6B28C55769802727C0A3639A9895CA3233D3AD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_4 in var_2)
  var_4 thread _id_12CD0(var_1.origin);
}

_id_12CD0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_B25F1728395AC2CCDD05CB69D6153893DBB8AC3E300381075B");
  self.ignoreall = 1;
  self.goalradius = 64;
  self setgoalpos(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8B7205D9ED5958", 40);
  self dodamage(self.health + 100, self.origin);
}

_id_143FF() {
  level endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_set("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A");
  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  scripts\engine\utility::flag_wait("_encstr_AF06233B6E41588852DBEFBFA37ACCF0CF0703701694B8B0FAFFF785EFE21B509C5F6BE97F");
  thread scripts\cp\cp_objectives::run_objective("_encstr_8D390C38162A378BE19F1010E73C", "_encstr_BA7F0830B3A7859B60B0");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8F7711073340377375F7E783D91EEA4F90FB3F");
}

maxlootleadermarkcount() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_139B5 = 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_811F2070B30F21A973E9019FFA2BAF4B9D27C0602FF7986DFA818D1B976201569242", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_857320FDD0390FCBB3C790380BF5666522BAE6FD6FD1C13381AF90601319D8872FF2", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8BF31932B0CFB6AB0BF03331F1114F7EF91009CA481BEF3B66EF50", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_862E194763DF52180389EB4BD838FFBA5976017ECEDB4A56AECAB2", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_83F31907239F125843C997C720793F7A9936413E8E1B8A96EE82F2", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AD5D19321EFAD8E06EFA8D58E6DCD75883D8D74C9C5A5999FAD00C", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B8F31970D3819F53AF37DAC7ED0F7E63B28A31C8CBA4DBE947657F", "_encstr_9A8507BA4040188D08");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AD5D19321EFAD8E06EFA8D58E6DCD75883D8D74C9C5A5999FAD80C", "_encstr_9A8507BA4040188D08");
  wait 2;
  level._id_139B5 = 0;
  level notify("_encstr_AC08166B0F9307D8A51A2638839C6048F9C3F787DBAA58A8");
}

togglewavespawning(var_0) {
  return;

  if(istrue(var_0))
    thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  else
    thread scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
}

morales_guard_post_func(var_0) {
  waitframe();
  self.maxfaceenemydist = 768;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  thread dorandomguardanim(self);
  thread watchforguardclosetoplayers(self, "_encstr_9A8507BA4040188D08");
  thread watchfordamage(self);
  thread waitformoralesguardgoinghot(self);
}

dorandomguardanim(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");
  var_1 = "_encstr_97281A8301193F3F5FBBBAF1632DA7B5189B360FC7C087037536F71F";
  var_0 scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_1);
}

watchforguardclosetoplayers(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");
  var_2 = 2250000;

  for(;;) {
    var_3 = scripts\cp\utility::getplayersinteam(var_1);
    var_4 = 0;

    foreach(var_6 in var_3) {
      if(scripts\engine\utility::distance_2d_squared(var_6.origin, var_0.origin) <= var_2 && var_0 cansee(var_6))
        var_4 = 1;
    }

    if(var_4)
      level notify("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");

    wait 0.5;
  }
}

watchfordamage(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");
  var_0 scripts\engine\utility::_id_143A8("_encstr_AD75063D571AE108", "_encstr_BA22087EA808525BA5D9", "_encstr_B2BE0788BAF573592F", "_encstr_860808CB78E2984063BA", "_encstr_BD471036164E9DACBE56F083B1DBCDB4F69B");
  level notify("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");
}

waitformoralesguardgoinghot(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");
  var_0.dontevershoot = 0;
  var_0.ignoreall = 0;
  var_0.scripted_mode = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
}

domoralestiedanim(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.body scriptmodelplayanim("_encstr_82C8151F71205AE710516D370BA124D285E1679B275C32");
  level waittill("_encstr_A1EC18A87FB29161E272082CCB9A65F91B27F010936CEE212ADB");
  var_0.body scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
}

markedentitieslifeindices() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");

  for(;;) {
    wait 15;
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B88F1FF9F30FDEE8BA3F81933BE2C91E8F3B91438AB78310D427819B53CC50E7BF" + randomintrange(1, 6) + "_encstr_934C0218", "_encstr_9A8507BA4040188D08");
  }
}

_id_144C0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B67E107A409637AD902797B529D0B44BB599");
  var_0 endon("_encstr_8A12060D5BA9C745");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_1);
    var_1 thread _id_144C1(var_1, var_0);
  }
}

_id_144C1(var_0, var_1) {
  level endon("_encstr_B67E107A409637AD902797B529D0B44BB599");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8A12060D5BA9C745");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_88C60846397B83835919");

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F");
    level.moraleshostage scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_95842311A001C8F7073131FB0A1738182703A7BB25F9583C5729ABA062ABF0D07F692F21F7" + randomintrange(1, 7) + "_encstr_934C0218", "_encstr_9A8507BA4040188D08");
    wait 10;
  }
}