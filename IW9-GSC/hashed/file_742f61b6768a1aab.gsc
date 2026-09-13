/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_742f61b6768a1aab.gsc
***********************************************/

_id_2A96CA08E3426168() {
  while(!isDefined(level.stealth))
    waitframe();

  setDvar("dvar_AE9C969DF88E37E1", 5000);
  setDvar("dvar_F72CE39DD23B00D1", 5000);
  setDvar("dvar_CDA36D9770CF5189", 150);
  level.stealth._id_792E4B9A380ADE11 = 5000;
  level.stealth._id_094F8771062F2161 = 5000;
  level.stealth._id_E2E3C78D7DC88605 = 22500;
  _func_4FF17EFD15D01D3F(2300);
  _func_1611D0F6B5F84B9A(getdvarint("dvar_E6BC59802B9F7F6E", 4000));
  _func_7AFB89FC511BF315("silenced_shot", 128);
  _func_1A3DD0FBFE26893F("silenced_shot", 256);
  _func_7AFB89FC511BF315("gunshot_teammate", 1024);
  _func_1A3DD0FBFE26893F("gunshot_teammate", 1024);
  _func_7AFB89FC511BF315("silenced_shot_impact", 128);
  _func_1A3DD0FBFE26893F("silenced_shot_impact", 128);
  level.stealth._id_3495E2E91301FEBD = [];
  level.stealth._id_3495E2E91301FEBD["idle"] = "cp_hydro";
  level.stealth._id_3495E2E91301FEBD["investigate"] = "cp_hydro";
  level.stealth._id_3495E2E91301FEBD["hunt"] = "cp_hydro";
  _func_7AFB89FC511BF315("death", 250);
  setDvar("dvar_0DF03D7AC5B31599", 0);
  _func_03875866B3A6D349(1);
  level._id_DA217073B223521A = 1;
}

_id_E184434584909B32() {
  self _meth_95D5375059C2A022("cp_hydro");
  self _meth_D493E7FE15E5EAF4("cp_hydro");
  self._id_D4C11C85EE9C6A42 = 1500;
  self._id_A4709D00B598B7BF = 1;
}

_id_C4922551C7DD79EF() {
  level notify("level_setDefaultStealthSettingsHydro");
  level endon("level_setDefaultStealthSettingsHydro");
  _id_7DC093FB71342953["prone"] = 850;
  _id_7DC093FB71342953["crouch"] = 950;
  _id_7DC093FB71342953["stand"] = 1200;
  _id_B6B642CBEFF52B88["prone"] = 150;
  _id_B6B642CBEFF52B88["crouch"] = 350;
  _id_B6B642CBEFF52B88["stand"] = 600;
  _id_7DC093FB71342953["shadow_prone"] = 0.05;
  _id_7DC093FB71342953["shadow_crouch"] = 0.05;
  _id_7DC093FB71342953["shadow_stand"] = 0.3;
  _id_3B0034EB96B13650["prone"] = 1500;
  _id_3B0034EB96B13650["crouch"] = 1950;
  _id_3B0034EB96B13650["stand"] = 3072;
  _id_D0F35FC0A5C3DF79["prone"] = 250;
  _id_D0F35FC0A5C3DF79["crouch"] = 1000;
  _id_D0F35FC0A5C3DF79["stand"] = 1800;
  _id_3B0034EB96B13650["shadow_prone"] = 0.01;
  _id_3B0034EB96B13650["shadow_crouch"] = 0.02;
  _id_3B0034EB96B13650["shadow_stand"] = 0.38;
  _id_8F3F480583606401["prone"] = 1.1;
  _id_8F3F480583606401["crouch"] = 1.15;
  _id_8F3F480583606401["stand"] = 1.2;
  _id_FAC370D058479827["prone"] = 0;
  _id_FAC370D058479827["crouch"] = 0;
  _id_FAC370D058479827["stand"] = 0;
  _id_FB574B7959625BF0["prone"] = 0;
  _id_FB574B7959625BF0["crouch"] = 0;
  _id_FB574B7959625BF0["stand"] = 0;
  scripts\stealth\utility::set_detect_ranges(_id_7DC093FB71342953, _id_3B0034EB96B13650, _id_8F3F480583606401);
  scripts\stealth\utility::set_min_detect_range_darkness(_id_B6B642CBEFF52B88, _id_D0F35FC0A5C3DF79);
  scripts\stealth\utility::_id_0F3883FE06A11269(_id_FAC370D058479827, _id_FB574B7959625BF0);
  _id_04E4F703E8EA149C["spotted"]["explosion"] = 5000;
  _id_04E4F703E8EA149C["hidden"]["explosion"] = 5000;
  _id_04E4F703E8EA149C["spotted"]["gunshot"] = 4000;
  _id_04E4F703E8EA149C["hidden"]["gunshot"] = 4000;
  _id_04E4F703E8EA149C["spotted"]["footstep"] = 100;
  _id_04E4F703E8EA149C["hidden"]["footstep"] = 50;
  _id_04E4F703E8EA149C["spotted"]["footstep_walk"] = 750;
  _id_04E4F703E8EA149C["hidden"]["footstep_walk"] = 100;
  _id_04E4F703E8EA149C["spotted"]["footstep_sprint"] = 1600;
  _id_04E4F703E8EA149C["hidden"]["footstep_sprint"] = 1000;
  _id_04E4F703E8EA149C["spotted"]["silenced_shot"] = 256;
  _id_04E4F703E8EA149C["hidden"]["silenced_shot"] = 128;
  _id_04E4F703E8EA149C["spotted"]["gunshot_teammate"] = 1024;
  _id_04E4F703E8EA149C["hidden"]["gunshot_teammate"] = 1024;
  scripts\stealth\manager::set_custom_distances(_id_04E4F703E8EA149C);
}

main() {
  setDvar("dvar_9EB1E24F643E2711", 1);
  level._id_04056F15D39BCF78 = ::_id_2A96CA08E3426168;
  level._id_2A7A0DD9628AB102 = ::_id_E184434584909B32;
  level thread init_escalation();

  if(scripts\engine\utility::flag_exist("cp_bs_spawners_cs_completed"))
    scripts\engine\utility::flag_wait("cp_bs_spawners_cs_completed");

  level._id_45D5787AF040313A = ::_id_45D5787AF040313A;
  level.disguised = 1;
  level._id_A359CB3E2BFA1964 = [];
  level._id_9EEAB63C54988C55 = [];
  level._id_359C318944444B78 = [];
  level._id_746E72886EBA1382 = [];
  level._id_A63144E6E64B0558 = [];
  level._id_B8615F42FA1FFC45 = [];
  level._id_0B59073F7450E763 = [];
  level._id_A359CB3E2BFA1964["stealth_a"] = 0;
  level._id_9EEAB63C54988C55["stealth_a"] = 0;
  level._id_359C318944444B78["stealth_a"] = 0;
  level._id_A359CB3E2BFA1964["stealth_b"] = 0;
  level._id_9EEAB63C54988C55["stealth_b"] = 0;
  level._id_359C318944444B78["stealth_b"] = 0;
  level._id_A359CB3E2BFA1964["stealth_c"] = 0;
  level._id_9EEAB63C54988C55["stealth_c"] = 0;
  level._id_359C318944444B78["stealth_c"] = 0;
  level._id_359C318944444B78["exfil_area"] = 0;
  level._id_746E72886EBA1382["stealth_a"] = 0;
  level._id_746E72886EBA1382["stealth_b"] = 0;
  level._id_746E72886EBA1382["stealth_c"] = 0;
  level._id_746E72886EBA1382["exfil_area"] = 0;
  level._id_A63144E6E64B0558["stealth_a"] = 0;
  level._id_A63144E6E64B0558["stealth_b"] = 0;
  level._id_A63144E6E64B0558["stealth_c"] = 0;
  level._id_A63144E6E64B0558["exfil_area"] = 0;
  level._id_B8615F42FA1FFC45["stealth_a"] = 0;
  level._id_B8615F42FA1FFC45["stealth_b"] = 0;
  level._id_B8615F42FA1FFC45["stealth_c"] = 0;
  level._id_B8615F42FA1FFC45["exfil_area"] = 0;
  level._id_0B59073F7450E763["stealth_a"] = 0;
  level._id_0B59073F7450E763["stealth_b"] = 0;
  level._id_0B59073F7450E763["stealth_c"] = 0;
  level._id_0B59073F7450E763["exfil_area"] = 0;
  level._id_8E5F9C64412D7B4A = [];
  level._id_8E5F9C64412D7B4A["stealth_a"] = 0;
  level._id_8E5F9C64412D7B4A["stealth_b"] = 0;
  level._id_8E5F9C64412D7B4A["stealth_c"] = 0;
  level._id_8E5F9C64412D7B4A["exfil_area"] = 0;
  level._id_3221D2DB1C467EED = [];
  level._id_3221D2DB1C467EED["ambient_a"] = [];
  level._id_3221D2DB1C467EED["ambient_b"] = [];
  level._id_3221D2DB1C467EED["ambient_c"] = [];
  level._id_3221D2DB1C467EED["stealth_a"] = [];
  level._id_3221D2DB1C467EED["stealth_b"] = [];
  level._id_3221D2DB1C467EED["stealth_c"] = [];
  level._id_3221D2DB1C467EED["stealth_a_interior"] = [];
  level._id_3221D2DB1C467EED["stealth_b_interior"] = [];
  level._id_3221D2DB1C467EED["stealth_c_interior"] = [];
  level._id_94D52412489D4DE7 = [];
  level._id_94D52412489D4DE7["stealth_b"] = getEnt("obj_b_interior_combined_volume", "targetname");
  level._id_94D52412489D4DE7["stealth_a"] = getEnt("obj_a_interior_volume", "targetname");
  level._id_94D52412489D4DE7["stealth_c"] = getEnt("obj_c_interior_volume", "targetname");
  level._id_318CEAE290567709 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
  level._id_8EE9C5604A4FB6C0 = 2048;
  level.vehicle._id_9442D439C225C3FE = ::_id_815A8EBC21BE9A01;
  level._id_B39EB382281F2D25 = getEnt("obj_c_interior_downstairs_volume", "targetname");
  level._id_E603A83D83B0080D = [getEnt("obj_a_interior_upstairs_volume", "targetname"), getEnt("obj_a_interior_downstairs_volume", "targetname")];
  level thread _id_B22C9A7A55685AF2();
  scripts\cp\coop_stealth::coop_stealth_init();
  _id_23CE7347A2D04868();
  sound_distraction_mechanic_init();
  _id_80DA038043AE1F6D();
}

_id_80DA038043AE1F6D() {
  level.astar_node_radius_override = 12;
  _id_C4922551C7DD79EF();
}

_id_38F7442E9C83B9B6() {
  _func_7AFB89FC511BF315("new_enemy", 512.0);
  _func_1A3DD0FBFE26893F("new_enemy", 256.0);
  level.astar_node_radius_override = undefined;
}

_id_577B4A1B65435431() {
  level endon("game_ended");
  level endon("escaped_mission_bs");
  level._id_BC349310EBD33584 = getEnt("jugg_mission_bs_kill_trigger", "targetname");

  for(;;) {
    level._id_BC349310EBD33584 waittill("trigger", entity);

    if(!isagent(entity) && !isPlayer(entity)) {
      waitframe();
      continue;
    } else {
      if(isPlayer(entity)) {
        entity thread scripts\cp\cp_outofbounds::playeroutoftimecallback("oob_timeout_end", "clear_oob");
        continue;
      }

      entity dodamage(entity.health + 10000, entity.origin);
    }
  }
}

_id_99A9683BF9939452(_id_CD977BE97BC0FC1E, event) {
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E endon("enter_combat");
  entnum = _id_CD977BE97BC0FC1E getentitynumber();
  event = spawnStruct();
  event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());

  if(!isDefined(event.entity)) {
    return;
  }
  event.investigate_pos = event.entity.origin;
  _id_CD977BE97BC0FC1E scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.investigate_pos);
}

ai_dogforcegrowl(ai, _id_B96D126FC701024B) {
  ai.forcegrowl = _id_B96D126FC701024B;
}

ai_dogforcebark(ai, _id_B96D126FC701024B) {
  ai.forcebark = _id_B96D126FC701024B;
}

_id_23CE7347A2D04868() {
  _id_18A73A64992DD07D::registerambientgroup("bs_exfil_stealth_1", 10, 16, 16, 0.05, undefined, "bs_exfil_stealth_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("bs_exfil_stealth_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("bs_exfil_stealth_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("bs_exfil_stealth_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("bs_exfil_stealth_2", 10, 16, 16, 0.05, undefined, "bs_exfil_stealth_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("bs_exfil_stealth_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("bs_exfil_stealth_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("bs_exfil_stealth_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("bs_exfil_stealth_3", 10, 16, 16, 0.05, undefined, "bs_exfil_stealth_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("bs_exfil_stealth_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("bs_exfil_stealth_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("bs_exfil_stealth_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_1", 5, 5, 5, 0.05, undefined, "exfil_exterior_reinforcement_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_1", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_2", 5, 5, 5, 0.05, undefined, "exfil_exterior_reinforcement_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_2", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_3", 5, 5, 5, 0.05, undefined, "exfil_exterior_reinforcement_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_3", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("patrolling_vehicle_ai_b", 3, 3, 3, 0.05, undefined, "patrolling_vehicle_ai_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("patrolling_vehicle_ai_b", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("patrolling_vehicle_ai_c", 3, 3, 3, 0.05, undefined, "patrolling_vehicle_ai_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("patrolling_vehicle_ai_c", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_1", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_1", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_2", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_2", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_3", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_3", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_4", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_4", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_4", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_5", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_5", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_5", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_6", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_6", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_6", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_7", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_7", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_7", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_8", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_8", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_8", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("exfil_exterior_reinforcement_vehicle_9", 4, 10, 12, 0.05, undefined, "exfil_exterior_reinforcement_vehicle_9", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("exfil_exterior_reinforcement_vehicle_9", ::_id_7BB278ADFAC595F5);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_interior_smg_1", 2, 2, 2, 0.05, undefined, "spawner_obj_b_interior_smg_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_interior_smg_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_interior_smg_1", ::_id_31FB1D1A4142F010);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_interior_smg_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_interior_smg_2", 2, 2, 2, 0.05, undefined, "spawner_obj_b_interior_smg_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_interior_smg_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_interior_smg_2", ::_id_31FB1D1A4142F010);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_interior_smg_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_interior_smg_3", 2, 2, 2, 0.05, undefined, "spawner_obj_b_interior_smg_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_interior_smg_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_interior_smg_3", ::_id_31FB1D1A4142F010);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_interior_smg_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_interior_2_smg_1", 4, 4, 4, 0.05, undefined, "spawner_obj_b_interior_2_smg_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_interior_2_smg_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_interior_2_smg_1", ::_id_31FB1D1A4142F010);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_interior_2_smg_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_interior_2_smg_2", 4, 4, 4, 0.05, undefined, "spawner_obj_b_interior_2_smg_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_interior_2_smg_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_interior_2_smg_2", ::_id_31FB1D1A4142F010);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_interior_2_smg_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_interior_2_smg_3", 4, 4, 4, 0.05, undefined, "spawner_obj_b_interior_2_smg_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_interior_2_smg_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_interior_2_smg_3", ::_id_31FB1D1A4142F010);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_interior_2_smg_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_1", 3, 3, 3, 0.05, undefined, "spawner_obj_b_exterior_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_2", 3, 3, 3, 0.05, undefined, "spawner_obj_b_exterior_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_3", 3, 3, 3, 0.05, undefined, "spawner_obj_b_exterior_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_roof_1", 2, 2, 2, 0.05, undefined, "spawner_obj_b_exterior_roof_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_roof_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_roof_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_roof_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_roof_2", 2, 2, 2, 0.05, undefined, "spawner_obj_b_exterior_roof_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_roof_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_roof_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_roof_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_roof_3", 2, 2, 2, 0.05, undefined, "spawner_obj_b_exterior_roof_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_roof_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_roof_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_roof_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_patrol_1", 8, 8, 8, 0.05, undefined, "spawner_obj_b_exterior_patrol_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_patrol_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_patrol_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_patrol_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_patrol_2", 8, 8, 8, 0.05, undefined, "spawner_obj_b_exterior_patrol_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_patrol_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_patrol_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_patrol_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_patrol_3", 8, 8, 8, 0.05, undefined, "spawner_obj_b_exterior_patrol_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_exterior_patrol_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_patrol_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_exterior_patrol_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_reinforcement_1", 0, 4, 4, 0.05, undefined, "spawner_obj_b_exterior_reinforcement_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_reinforcement_1", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_reinforcement_2", 0, 4, 4, 0.05, undefined, "spawner_obj_b_exterior_reinforcement_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_reinforcement_2", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_exterior_reinforcement_3", 0, 4, 4, 0.05, undefined, "spawner_obj_b_exterior_reinforcement_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_exterior_reinforcement_3", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_ambush_1", 3, 3, 3, 0.05, undefined, "spawner_obj_b_ambush_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_ambush_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_ambush_1", ::_id_BCE45E934D877240);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_ambush_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_ambush_2", 3, 3, 3, 0.05, undefined, "spawner_obj_b_ambush_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_ambush_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_ambush_2", ::_id_BCE45E934D877240);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_ambush_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_ambush_3", 3, 3, 3, 0.05, undefined, "spawner_obj_b_ambush_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_ambush_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_ambush_3", ::_id_BCE45E934D877240);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_ambush_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_ambush_smg_1", 1, 1, 1, 0.05, undefined, "spawner_obj_b_ambush_smg_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_ambush_smg_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_ambush_smg_1", ::_id_BCE45E934D877240);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_ambush_smg_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_ambush_smg_2", 1, 1, 1, 0.05, undefined, "spawner_obj_b_ambush_smg_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_ambush_smg_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_ambush_smg_2", ::_id_BCE45E934D877240);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_ambush_smg_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_b_ambush_smg_3", 1, 1, 1, 0.05, undefined, "spawner_obj_b_ambush_smg_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_b_ambush_smg_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_b_ambush_smg_3", ::_id_BCE45E934D877240);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_b_ambush_smg_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("techo_patroller_b", 4, 4, 4, 0.05, undefined, "techo_patroller_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("techo_patroller_b", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::registerambientgroup("techo_patroller_a", 4, 4, 4, 0.05, undefined, "techo_patroller_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("techo_patroller_a", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_upstairs_1", 1, 1, 1, 0.05, undefined, "spawner_obj_a_interior_upstairs_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_upstairs_1", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_upstairs_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_upstairs_2", 1, 1, 1, 0.05, undefined, "spawner_obj_a_interior_upstairs_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_upstairs_2", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_upstairs_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_upstairs_3", 1, 1, 1, 0.05, undefined, "spawner_obj_a_interior_upstairs_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_upstairs_3", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_upstairs_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_upstairs_smg_1", 1, 1, 1, 0.05, undefined, "spawner_obj_a_interior_upstairs_smg_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_upstairs_smg_1", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_upstairs_smg_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_upstairs_smg_2", 1, 1, 1, 0.05, undefined, "spawner_obj_a_interior_upstairs_smg_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_upstairs_smg_2", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_upstairs_smg_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_upstairs_smg_3", 1, 1, 1, 0.05, undefined, "spawner_obj_a_interior_upstairs_smg_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_upstairs_smg_3", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_upstairs_smg_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_smg_1", 5, 5, 5, 0.05, undefined, "spawner_obj_a_interior_smg_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_smg_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_smg_1", ::_id_31FB201A4142F6A9);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_smg_2", 4, 4, 4, 0.05, undefined, "spawner_obj_a_interior_smg_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_smg_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_smg_2", ::_id_31FB201A4142F6A9);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_interior_smg_3", 5, 5, 5, 0.05, undefined, "spawner_obj_a_interior_smg_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_interior_smg_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_interior_smg_3", ::_id_31FB201A4142F6A9);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_1", 4, 4, 4, 0.05, undefined, "spawner_obj_a_exterior_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_2", 4, 4, 4, 0.05, undefined, "spawner_obj_a_exterior_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_3", 4, 4, 4, 0.05, undefined, "spawner_obj_a_exterior_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_patrol_1", 3, 3, 3, 0.05, undefined, "spawner_obj_a_exterior_patrol_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_patrol_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_patrol_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_patrol_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_patrol_2", 3, 3, 3, 0.05, undefined, "spawner_obj_a_exterior_patrol_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_patrol_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_patrol_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_patrol_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_patrol_3", 3, 3, 3, 0.05, undefined, "spawner_obj_a_exterior_patrol_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_patrol_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_patrol_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_patrol_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_patrol_roof_1", 1, 1, 1, 0.05, undefined, "spawner_obj_a_exterior_patrol_roof_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_patrol_roof_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_patrol_roof_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_patrol_roof_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_patrol_roof_2", 1, 1, 1, 0.05, undefined, "spawner_obj_a_exterior_patrol_roof_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_patrol_roof_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_patrol_roof_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_patrol_roof_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_patrol_roof_3", 1, 1, 1, 0.05, undefined, "spawner_obj_a_exterior_patrol_roof_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_exterior_patrol_roof_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_patrol_roof_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_exterior_patrol_roof_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_reinforcement_1", 0, 4, 4, 0.05, undefined, "spawner_obj_a_exterior_reinforcement_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_reinforcement_1", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_reinforcement_2", 0, 4, 4, 0.05, undefined, "spawner_obj_a_exterior_reinforcement_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_reinforcement_2", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_exterior_reinforcement_3", 0, 4, 4, 0.05, undefined, "spawner_obj_a_exterior_reinforcement_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_exterior_reinforcement_3", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_upstairs_ambush_1", 4, 4, 4, 0.05, undefined, "spawner_obj_a_upstairs_ambush_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_upstairs_ambush_1", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_upstairs_ambush_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_upstairs_ambush_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_upstairs_ambush_2", 4, 4, 4, 0.05, undefined, "spawner_obj_a_upstairs_ambush_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_upstairs_ambush_2", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_upstairs_ambush_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_upstairs_ambush_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_a_upstairs_ambush_3", 4, 4, 4, 0.05, undefined, "spawner_obj_a_upstairs_ambush_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_a_upstairs_ambush_3", ::_id_7C24415BEDF6D783);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_a_upstairs_ambush_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_a_upstairs_ambush_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("techo_patroller_c", 4, 4, 4, 0.05, undefined, "techo_patroller_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("techo_patroller_c", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_1", 2, 2, 2, 0.05, undefined, "spawner_obj_c_exterior_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_exterior_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_exterior_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_2", 2, 2, 2, 0.05, undefined, "spawner_obj_c_exterior_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_exterior_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_exterior_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_3", 2, 2, 2, 0.05, undefined, "spawner_obj_c_exterior_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_exterior_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_exterior_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_patrol_1", 5, 5, 5, 0.05, undefined, "spawner_obj_c_exterior_patrol_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_exterior_patrol_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_patrol_1", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_exterior_patrol_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_patrol_2", 5, 5, 5, 0.05, undefined, "spawner_obj_c_exterior_patrol_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_exterior_patrol_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_patrol_2", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_exterior_patrol_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_patrol_3", 5, 5, 5, 0.05, undefined, "spawner_obj_c_exterior_patrol_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_exterior_patrol_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_patrol_3", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_exterior_patrol_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_interior_upstairs_1", 2, 2, 2, 0.05, undefined, "spawner_obj_c_interior_upstairs_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_interior_upstairs_1", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_interior_upstairs_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_interior_upstairs_2", 2, 2, 2, 0.05, undefined, "spawner_obj_c_interior_upstairs_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_interior_upstairs_2", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_interior_upstairs_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_interior_upstairs_3", 2, 2, 2, 0.05, undefined, "spawner_obj_c_interior_upstairs_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_interior_upstairs_3", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_interior_upstairs_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_interior_1", 1, 1, 1, 0.05, undefined, "spawner_obj_c_interior_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_interior_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_interior_1", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_interior_2", 2, 2, 2, 0.05, undefined, "spawner_obj_c_interior_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_interior_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_interior_2", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_interior_3", 2, 2, 2, 0.05, undefined, "spawner_obj_c_interior_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_interior_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_interior_3", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_upstairs_ambush_1", 4, 4, 4, 0.05, undefined, "spawner_obj_c_upstairs_ambush_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_upstairs_ambush_1", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_upstairs_ambush_1", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_upstairs_ambush_1", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_upstairs_ambush_2", 4, 4, 4, 0.05, undefined, "spawner_obj_c_upstairs_ambush_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_upstairs_ambush_2", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_upstairs_ambush_2", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_upstairs_ambush_2", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_upstairs_ambush_3", 4, 4, 4, 0.05, undefined, "spawner_obj_c_upstairs_ambush_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_upstairs_ambush_3", ::_id_7C24435BEDF6DBE9);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("spawner_obj_c_upstairs_ambush_3", 75, 1024, 5000, 1);
  _id_18A73A64992DD07D::register_module_weapons_free_func("spawner_obj_c_upstairs_ambush_3", _id_18A73A64992DD07D::group_reset_goalradius);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_reinforcement_1", 0, 4, 4, 0.05, undefined, "spawner_obj_c_exterior_reinforcement_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_reinforcement_1", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_reinforcement_2", 0, 4, 4, 0.05, undefined, "spawner_obj_c_exterior_reinforcement_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_reinforcement_2", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("spawner_obj_c_exterior_reinforcement_3", 0, 4, 4, 0.05, undefined, "spawner_obj_c_exterior_reinforcement_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spawner_obj_c_exterior_reinforcement_3", ::_id_9F6B90852C4317DD);
  _id_18A73A64992DD07D::registerambientgroup("ambient_ai_barracks", 3, 3, 3, 0.05, undefined, "ambient_ai_barracks", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ambient_ai_barracks", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::registerambientgroup("ambient_ai_comms", 3, 3, 3, 0.05, undefined, "ambient_ai_comms", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ambient_ai_comms", ::_id_D55D81D456A54C2A);
  _id_18A73A64992DD07D::registerambientgroup("ambient_ai_armory", 2, 2, 2, 0.05, undefined, "ambient_ai_armory", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ambient_ai_armory", ::_id_D55D81D456A54C2A);
  scripts\engine\utility::flag_set("ready_for_region_spawning");

  if(_id_476B6443E3798F5E::_id_AB29F5844AA437FB()) {
    if(!scripts\engine\utility::flag_exist("ready_for_objective_trigger"))
      scripts\engine\utility::flag_init("ready_for_objective_trigger");

    scripts\engine\utility::flag_set("ready_for_objective_trigger");
  }
}

_id_E5FDB0920B75744D(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self.sightmaxdistance = 1000;
  self laseron();
  thread _id_3858411D0B73D352::_id_47B83E6A4BD5EAE0();
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

_id_AE8B0FB63A869D2C(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self.fixednode = 1;
  self.diequietly = 1;
  activate_sniper();
}

activate_sniper(group) {
  sniper = self;
  sniper.neverforcesnipermissenemy = 1;
  sniper.sniperaccuracyset = 1;
  sniper.baseaccuracy = 1;
  sniper laseron();
  sniper.gunposeoverride = "ads";
  apply_common_combat_settings(sniper);

  if(!isDefined(level._id_F81E56E009A2E2B2))
    level._id_F81E56E009A2E2B2 = [];

  level._id_F81E56E009A2E2B2 = scripts\engine\utility::array_add(level._id_F81E56E009A2E2B2, sniper);
  sniper thread _id_CECC0BFAD95E3FD5();
  sniper thread _id_51023E7DB5068D92::delay_activate_laser(sniper);
}

_id_CECC0BFAD95E3FD5() {
  self waittill("death");

  if(scripts\engine\utility::array_contains(level._id_F81E56E009A2E2B2, self))
    level._id_F81E56E009A2E2B2 = scripts\engine\utility::array_remove(level._id_F81E56E009A2E2B2, self);

  level._id_F81E56E009A2E2B2 = scripts\engine\utility::array_removeundefined(level._id_F81E56E009A2E2B2);
}

apply_common_combat_settings(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E.maxfaceenemydist = 2000;
  _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::equip_random_grenade();
}

_id_9B4B3A9A2BB10DFB(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self.fixednode = 1;
  self.diequietly = 1;
  self laseron();
  self.gunposeoverride = "ads";
  apply_common_combat_settings(self);
  activate_sniper();
}

_id_9F6B90852C4317DD(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self.baseaccuracy = getdvarfloat("dvar_9F78280356EF4531", 2.0);

  if(_id_18A73A64992DD07D::is_juggernaut_aitype()) {
    _id_18A73A64992DD07D::set_goal_radius(2048);
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
    self enabletraversals(0);
  } else {
    _id_840298CB2CE4C610(group_name);

    if(issubstr(self.group.group_name, "vehicle")) {
      thread _id_07D4F952FAF64021();
      thread scripts\cp\cp_movers::player_unresolved_collision_watch();
      self.stealth.funcs["event_investigate"] = ::_id_740482DD5A644509;
      self.stealth.funcs["event_cover_blown"] = ::_id_740482DD5A644509;
      self.stealth.funcs["event_combat"] = ::_id_740482DD5A644509;
      self.maxfacenewenemydist = 4000;
    }

    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      thread _id_D24590F588A71CA2();
      return;
    }

    foreach(player in level.players) {
      if(!istrue(player.inlaststand))
        scripts\engine\utility::delaycall(0.1, ::getenemyinfo, player);
    }

    player = scripts\cp\utility::get_closest_living_player();

    if(isDefined(player)) {
      self setgoalpos(player.origin);
      event = spawnStruct();
      event.typeorig = "combat";
      event.type = "combat";
      event.origin = player.origin;
      event.investigate_pos = player.origin;
      self[[self.fnsetstealthstate]]("combat", event);
      thread _id_D24590F588A71CA2();
      return;
    }

    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_7BB278ADFAC595F5(_id_60FE8949A2DF739D) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  if(_id_18A73A64992DD07D::is_specified_unittype("dog"))
    thread _id_A09D72E5F0A92E1A();

  self.sightmaxdistance = 1000;
  self laseron();
  thread _id_07D4F952FAF64021();
  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self.maxfacenewenemydist = 4000;

  if(_id_60FE8949A2DF739D) {
    self _meth_95D5375059C2A022("cp_hydro_vehicle_ai");
    self _meth_D493E7FE15E5EAF4("cp_hydro_vehicle_ai");
    self._blackboard._id_30BE514754348695 = 1;
    thread _id_5A38EF4D3816AB49();
  }

  self.stealth.funcs["event_investigate"] = ::_id_740482DD5A644509;
  self.stealth.funcs["event_cover_blown"] = ::_id_740482DD5A644509;
  self.stealth.funcs["event_combat"] = ::_id_740482DD5A644509;
}

_id_5A38EF4D3816AB49() {
  self endon("death");
  level endon("kill_unload_watchers");

  for(;;) {
    if(isDefined(self.vehicle) && istrue(self.vehicle._id_F626B845D8C284E2))
      self.vehicle notify("kill_unload_watchers");

    self waittill("stealth_combat");

    if(isDefined(self.vehicle)) {
      self.vehicle._id_65D1C67ECFD84B03 = 1;
      self.vehicle notify("kill_unload_watchers");
    }

    level notify("kill_unload_watchers");
  }
}

_id_D55D81D456A54C2A(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  if(_id_18A73A64992DD07D::is_specified_unittype("dog"))
    thread _id_A09D72E5F0A92E1A();

  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
    self._id_85A0F6383A5DD784 = 1200;
    _id_18A73A64992DD07D::set_goal_radius(2048);
  }

  if(issubstr(self.group.group_name, "barracks")) {
    level._id_3221D2DB1C467EED["ambient_b"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["ambient_b"], self);
    thread _id_3E25035A1E82FBA5(undefined, "ambient_b");
  }

  if(issubstr(self.group.group_name, "comms")) {
    level._id_3221D2DB1C467EED["ambient_c"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["ambient_c"], self);
    thread _id_3E25035A1E82FBA5(undefined, "ambient_c");
  }

  if(issubstr(self.group.group_name, "armory")) {
    level._id_3221D2DB1C467EED["ambient_a"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["ambient_a"], self);
    thread _id_3E25035A1E82FBA5(undefined, "ambient_a");
  }

  if(issubstr(self.group.group_name, "spawner_obj_c")) {
    level._id_3221D2DB1C467EED["stealth_c"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["stealth_c"], self);
    thread _id_3E25035A1E82FBA5(undefined, "stealth_c");
  }

  if(issubstr(self.group.group_name, "spawner_obj_b")) {
    level._id_3221D2DB1C467EED["stealth_b"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["stealth_b"], self);
    thread _id_3E25035A1E82FBA5(undefined, "stealth_b");
  }

  if(issubstr(self.group.group_name, "spawner_obj_a")) {
    level._id_3221D2DB1C467EED["stealth_a"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["stealth_a"], self);
    thread _id_3E25035A1E82FBA5(undefined, "stealth_b");
  }

  self.sightmaxdistance = 1000;
  thread _id_07D4F952FAF64021();
  thread _id_F52AC2BAB0619753();
  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);

  if(!_id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
    _id_371B4C2AB5861E62::_id_DC01679146E5F53C(self);

  self.stealth.funcs["event_investigate"] = ::_id_740482DD5A644509;
  self.stealth.funcs["event_cover_blown"] = ::_id_740482DD5A644509;
  self.stealth.funcs["event_combat"] = ::_id_740482DD5A644509;
  self.maxfacenewenemydist = 4000;
}

setup_soldier_stealth(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self.sightmaxdistance = 1000;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  _id_DACBB83E655A088F(group_name);
}

jugg_enemy_watcher(group) {
  _id_CD977BE97BC0FC1E = self;
  _id_CD977BE97BC0FC1E.ballowexecutions = 1;

  if(istrue(level.global_stealth_broken)) {
    _id_CD977BE97BC0FC1E thread jugg_death_watcher_internal(_id_CD977BE97BC0FC1E);
    _id_CD977BE97BC0FC1E thread jugg_damage_watcher_internal(_id_CD977BE97BC0FC1E);
    return;
  }

  _id_CD977BE97BC0FC1E.sightmaxdistance = 666;
  _id_CD977BE97BC0FC1E thread jugg_death_watcher_internal(_id_CD977BE97BC0FC1E);
  _id_CD977BE97BC0FC1E thread jugg_damage_watcher_internal(_id_CD977BE97BC0FC1E);
  _id_CD977BE97BC0FC1E thread scripts\cp\coop_stealth::run_common_functions(_id_CD977BE97BC0FC1E, 0, 0);
}

jugg_death_watcher_internal(_id_E21279FA90BDF012) {
  _id_E21279FA90BDF012 waittill("death");
  _id_E21279FA90BDF012._id_B4E73B5C37FE850F = 0;
}

jugg_damage_watcher_internal(_id_E21279FA90BDF012) {
  _id_E21279FA90BDF012 endon("death");
  _id_E21279FA90BDF012 waittill("damage");
}

jugg_enter_combat_callback(event) {
  level notify("players_detected");
  thread _id_99A9683BF9939452(self, event);
  return 0;
}

jugg_go_to_node_callback(nodes, _id_29455CBEA8B9AD83, _id_B7E2619A5C2C393D) {
  if(istrue(self.using_goto_node)) {
    self.node_grid = scripts\engine\utility::getStructArray("jugg_nav_path", "script_noteworthy");
    _id_D5685B7BAEE6505E = self.origin;
    end_pos = scripts\engine\utility::random(self.node_grid).origin;
    _id_17947F4A9AA52B15 = self;
    _id_6EE6C2CA7C64E9C9 = spawnStruct();
    _id_6EE6C2CA7C64E9C9.origin = self.origin;
    self.path_data = scripts\cp\astar::astar_get_path(self.node_grid, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9);

    if(isDefined(self.path_data)) {
      self.path_data_ordered = order_path_data(self.path_data, self);
      level.path_data_ordered = order_path_data(self.path_data, self);
      thread _id_18A73A64992DD07D::go_to_node(self.path_data_ordered[0]);
      thread path_loop();
      return;
    }
  } else
    _id_18A73A64992DD07D::return_to_last_goalRadius();
}

path_loop(_id_24C92924FA8F2CFB) {
  self endon("death");
  self endon("enter_combat");
  level endon("players_detected");
  self notify("path_loop");
  self endon("path_loop");

  for(;;) {
    if(istrue(_id_24C92924FA8F2CFB))
      result = scripts\engine\utility::waittill_any_return_2("goal", "goal_reached");
    else
      result = scripts\engine\utility::waittill_any_return_3("reached_path_end", "stop_going_to_node", "goal_reached");

    self.node_grid = scripts\engine\utility::getStructArray("jugg_nav_path", "script_noteworthy");
    _id_D5685B7BAEE6505E = self.origin;
    end_pos = scripts\engine\utility::random(self.node_grid).origin;
    _id_17947F4A9AA52B15 = self;
    _id_6EE6C2CA7C64E9C9 = spawnStruct();
    _id_6EE6C2CA7C64E9C9.origin = self.origin;
    self.path_data = scripts\cp\astar::astar_get_path(self.node_grid, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9);

    if(isDefined(self.path_data)) {
      self.path_data_ordered = order_path_data(self.path_data, self);

      if(istrue(_id_24C92924FA8F2CFB)) {
        thread _id_18A73A64992DD07D::go_to_node(self.path_data_ordered);
        continue;
      }

      thread _id_18A73A64992DD07D::go_to_node(self.path_data_ordered);
    }
  }
}

order_path_data(path_data, ai) {
  _id_DEC9BCCE93873125 = "jugg_mission_bs_path";
  _id_CF86FC78C966BFBE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < path_data.path.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(path_data.path[_id_AC0E594AC96AA3A8].script_noteworthy)) {
      continue;
    }
    if(isDefined(path_data.path[_id_AC0E594AC96AA3A8 + 1]) && isstruct(path_data.path[_id_AC0E594AC96AA3A8 + 1])) {
      path_data.path[_id_AC0E594AC96AA3A8].target = _id_DEC9BCCE93873125 + "" + _id_AC0E594AC96AA3A8 + ai getentitynumber();
      path_data.path[_id_AC0E594AC96AA3A8 + 1].targetname = _id_DEC9BCCE93873125 + "" + _id_AC0E594AC96AA3A8 + ai getentitynumber();
      _id_CF86FC78C966BFBE = scripts\engine\utility::array_add(_id_CF86FC78C966BFBE, path_data.path[_id_AC0E594AC96AA3A8]);
      continue;
    }

    _id_CF86FC78C966BFBE = scripts\engine\utility::array_add(_id_CF86FC78C966BFBE, path_data.path[_id_AC0E594AC96AA3A8]);

    if(path_data.path[_id_AC0E594AC96AA3A8] != path_data.end_node) {
      path_data.end_node.targetname = _id_DEC9BCCE93873125 + "" + _id_AC0E594AC96AA3A8 + ai getentitynumber();
      _id_CF86FC78C966BFBE = scripts\engine\utility::array_add(_id_CF86FC78C966BFBE, path_data.end_node);
    }
  }

  return _id_CF86FC78C966BFBE;
}

sound_distraction_mechanic_init() {
  level.sound_events = ["dx_vom_bkv_entrance_intercom_10", "dx_vom_bkv_dragons_breath_clear_10"];
  level.pasystems = getEntArray("pa_system", "targetname");
}

turbine_spin() {
  level endon("escaped_mission_bs");
  time = 0.1 + randomfloatrange(0.5, 1.5);

  for(;;) {
    self rotatepitch(360, time);
    wait(time);
  }
}

alarm_audio() {
  self notify("alarm_audio");
  self endon("alarm_audio");
  self endon("stop_alarm");
  level endon("escaped_mission_bs");
  level endon("cleanup_old_sound_events");
  self endon("death");

  for(;;) {
    scripts\engine\utility::play_sound_in_space("indoor_alarm");
    wait 2.5;
  }
}

periodic_sound_events() {
  level endon("escaped_mission_bs");
  level endon("cleanup_old_sound_events");

  for(;;) {
    wait(randomintrange(15, 30));
    play_random_sound_event();
  }
}

play_random_sound_event() {
  _id_78786E87E7996E27 = scripts\engine\utility::random(level.sound_events);

  if(isDefined(_id_78786E87E7996E27)) {
    level.ai_deaf_event_active = 1;
    _id_40CDBACDA5CCA105 = lookupsoundlength(_id_78786E87E7996E27) / 1000;
    level thread play_sound_on_pa_systems(_id_78786E87E7996E27, _id_40CDBACDA5CCA105);
    wait(_id_40CDBACDA5CCA105);
    level.ai_deaf_event_active = undefined;
  }
}

play_sound_on_pa_systems(_id_78786E87E7996E27, _id_40CDBACDA5CCA105) {
  foreach(_id_51567E5C2A1B6703 in level.pasystems) {
    scripts\cp\utility::playsoundatpos_safe(_id_51567E5C2A1B6703.origin, _id_78786E87E7996E27);
    level thread deafen_ai_near_pa_for_duration(_id_51567E5C2A1B6703, _id_40CDBACDA5CCA105);
  }
}

deafen_ai_near_pa_for_duration(_id_51567E5C2A1B6703, _id_40CDBACDA5CCA105) {
  foreach(ai in getaiarray("axis")) {
    if(scripts\engine\utility::distance_2d_squared(ai.origin, _id_51567E5C2A1B6703.origin) <= 11108889)
      ai thread deafen_ai(_id_40CDBACDA5CCA105);
  }
}

deafen_ai(_id_40CDBACDA5CCA105) {
  self endon("death");
  self.bisdeaf = 1;
  wait(_id_40CDBACDA5CCA105);
  self.bisdeaf = undefined;
}

_id_8BFF9A0F28C4A5C8(_id_C2D86B76E49B9E86, _id_B56EC030D65DA906, _id_F96324DD389E3E30) {
  _id_99189C9718781C5D = 2250000;

  if(isDefined(_id_B56EC030D65DA906))
    _id_99189C9718781C5D = _id_B56EC030D65DA906;

  foreach(ai in getaiarray("axis")) {
    if(istrue(_id_F96324DD389E3E30)) {
      if(ai _id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
        continue;
    }

    _id_23E9C2248916F316 = 0;

    foreach(player in level.players) {
      if(isDefined(player calloutmarkerping_getEnt(4)) && isai(player calloutmarkerping_getEnt(4))) {
        if(player calloutmarkerping_getEnt(4) == ai) {
          _id_23E9C2248916F316 = 1;
          continue;
        }
      }

      if(isDefined(player calloutmarkerping_getEnt(5)) && isai(player calloutmarkerping_getEnt(5))) {
        if(player calloutmarkerping_getEnt(5) == ai) {
          _id_23E9C2248916F316 = 1;
          continue;
        }
      }

      if(isDefined(player calloutmarkerping_getEnt(6)) && isai(player calloutmarkerping_getEnt(6))) {
        if(player calloutmarkerping_getEnt(6) == ai) {
          _id_23E9C2248916F316 = 1;
          continue;
        }
      }
    }

    if(istrue(_id_23E9C2248916F316)) {
      _id_23E9C2248916F316 = 0;
      continue;
    }

    _id_4DEA0FF931DAA8BD = 0;

    if(isDefined(_id_C2D86B76E49B9E86)) {
      if(isDefined(ai.group) && isDefined(ai.group.group_name)) {
        if(scripts\engine\utility::array_contains(_id_C2D86B76E49B9E86, ai.group.group_name)) {
          _id_934F2BD9F0E5C04B = ai _id_18A73A64992DD07D::get_see_recently_time_overrides();

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
            _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

            if(_id_678A0776298909D1 scripts\engine\utility::can_trace_to_ai(_id_678A0776298909D1 getEye(), ai)) {
              continue;
            }
            if(distancesquared(_id_678A0776298909D1.origin, ai.origin) < _id_99189C9718781C5D) {
              break;
            }

            if(ai seerecently(_id_678A0776298909D1, _id_934F2BD9F0E5C04B)) {
              break;
            }

            _id_4DEA0FF931DAA8BD = 1;
          }

          if(_id_4DEA0FF931DAA8BD)
            ai _id_7E1A468DA43087E3::delete_ai();
        }
      }

      continue;
    }

    _id_934F2BD9F0E5C04B = ai _id_18A73A64992DD07D::get_see_recently_time_overrides();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

      if(_id_678A0776298909D1 scripts\engine\utility::can_trace_to_ai(_id_678A0776298909D1 getEye(), ai)) {
        continue;
      }
      if(distancesquared(_id_678A0776298909D1.origin, ai.origin) < _id_99189C9718781C5D) {
        break;
      }

      if(ai seerecently(_id_678A0776298909D1, _id_934F2BD9F0E5C04B)) {
        break;
      }

      _id_4DEA0FF931DAA8BD = 1;
    }

    if(_id_4DEA0FF931DAA8BD)
      ai _id_7E1A468DA43087E3::delete_ai();
  }
}

_id_45D5787AF040313A(_id_E3D682E90B56AF2E) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    return;
  }
  switch (_id_E3D682E90B56AF2E.name) {
    case "stealth_sitting_sleep":
      self.stealth.funcs["event_investigate"] = ::_id_5F5A4D2653D12C86;
      self.stealth.funcs["event_cover_blown"] = ::_id_5F5A4D2653D12C86;
      self.stealth.funcs["event_combat"] = ::_id_5F5A4D2653D12C86;
      break;
  }
}

_id_4C5D9C37EE44EA7C(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1))
        return 1;
      else {}
    }

    if(_id_D4A08728BF86E790(event))
      return 1;
  }

  if(_id_9A9B91C11482389F(event))
    return 1;

  self laseron();

  if(getdvarint("dvar_A025B8F10A93A908", 0) != 0) {
    self.goalradius = 64;
    self setgoalpos(self.origin);
  } else
    _id_F443A992E25EAD4A();

  return 0;
}

_id_7C24415BEDF6D783(group_name, func) {
  thread _id_13869DF22E9149EC("stealth_a");
  _id_2FD3B7F3740D5F23(group_name, func);
}

_id_31FB201A4142F6A9(group_name, func) {
  thread _id_326E629502D6C341();
  _id_2FD3B7F3740D5F23(group_name, func);
}

_id_13869DF22E9149EC(_id_C78FD6612D780DA3) {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");

    if(isDefined(_id_C78FD6612D780DA3)) {
      level thread _id_AA672E8DA9F814D9("upstairs", 0.05, _id_C78FD6612D780DA3);
      continue;
    }

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      level thread _id_AA672E8DA9F814D9("upstairs", 0.05, "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      level thread _id_AA672E8DA9F814D9("upstairs", 0.05, "stealth_b");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      level thread _id_AA672E8DA9F814D9("upstairs", 0.05, "stealth_c");

    level._id_D02CC581558B702B = 1;
  }
}

_id_AA672E8DA9F814D9(region, delay, obj) {
  wait(delay);

  switch (region) {
    case "exterior":
      if(region == "stealth_a") {
        _id_2A54763B46ECD8D7 = _func_9D30FD63965BAFA9("gunshot");
        _id_CC4B9CFA93202799 = _id_9AB3FDD93B0C8D1C("a");

        if(distance2d(_id_CC4B9CFA93202799.origin, self.origin) < _id_2A54763B46ECD8D7)
          level._id_359C318944444B78[obj]++;
      } else
        level._id_359C318944444B78[obj]++;

      break;
    case "downstairs":
      level._id_A359CB3E2BFA1964[obj]++;
      break;
    case "upstairs":
      level._id_9EEAB63C54988C55[obj]++;
      break;
  }
}

_id_9AB3FDD93B0C8D1C(region) {
  level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);

  foreach(_id_96477DA1695E035B in level._id_E7B157FD6CF95460) {
    if(_id_96477DA1695E035B.script_noteworthy == region)
      return _id_96477DA1695E035B;
  }

  return undefined;
}

_id_A55D4E07A9C77DEC() {
  objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");
  _id_E61AF03C9E384F0F = 0;
  _id_E7758D1CEF59FBF6 = 0;
  _id_E4189F6142F280F1 = 0;
  _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
  _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
  _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");

  if(self istouching(_id_5EAD7CD5BD2A23C3))
    _id_E61AF03C9E384F0F = 1;

  if(self istouching(_id_046CF58102043E30))
    _id_E7758D1CEF59FBF6 = 1;

  if(self istouching(_id_867B6418DD3354E1))
    _id_94A36A51659A7A2E = 1;

  if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1) {
    _id_C837AD627899C30C = scripts\engine\utility::getclosest(self.origin, getEntArray("objective_trigger", "targetname"));

    if(!isDefined(_id_C837AD627899C30C)) {
      return;
    }
    objname = _id_C837AD627899C30C.script_noteworthy;
  } else {
    if(_id_E61AF03C9E384F0F)
      objname = "stealth_a";

    if(_id_E7758D1CEF59FBF6)
      objname = "stealth_b";

    if(_id_E4189F6142F280F1)
      objname = "stealth_c";
  }

  return objname;
}

_id_F52AC2BAB0619753() {
  thread _id_E874052924505024();
  thread _id_25A90CE1FE4B68A2();
  thread _id_D5224EAF43013F9F();
  thread _id_73F5CC526DFD2E76();
}

_id_3E25035A1E82FBA5(_id_B8E63723A1B8C7BB, _id_46EC06A26F6781A0) {
  self waittill("death");

  if(self.damagemod == "MOD_SUICIDE" || self.damagemod == "MOD_UNKNOWN") {
    _id_96833BEC3E33C856();
    return;
  }

  _id_96833BEC3E33C856();
  _id_64A42C1E7DBDF9CB = self.origin;
  attacker = self.attacker;

  if(level._id_3221D2DB1C467EED[_id_46EC06A26F6781A0].size == 0)
    level notify("area_cleared", _id_46EC06A26F6781A0, attacker, _id_B8E63723A1B8C7BB);
}

_id_73F5CC526DFD2E76() {
  self waittill("death");
  thread _id_617B57B7F5FB10EE("killed", 0.05, _id_A55D4E07A9C77DEC());
}

_id_E874052924505024() {
  for(;;) {
    scripts\engine\utility::waittill_any_2("stealth_update_investigate", "stealth_investigate");
    thread _id_617B57B7F5FB10EE("investigate", 0.05, _id_A55D4E07A9C77DEC());
  }
}

_id_25A90CE1FE4B68A2() {
  for(;;) {
    self waittill("stealth_hunt");
    thread _id_617B57B7F5FB10EE("hunt", 0.05, _id_A55D4E07A9C77DEC());
  }
}

_id_D5224EAF43013F9F() {
  for(;;) {
    self waittill("stealth_combat");
    thread _id_617B57B7F5FB10EE("combat", 0.05, _id_A55D4E07A9C77DEC());
  }
}

_id_1BC0B4CB2C52BFD4() {
  if(scripts\stealth\manager::anyone_in_combat())
    return 2;

  if(scripts\stealth\manager::anyone_in_hunt())
    return 1;

  obj = _id_A55D4E07A9C77DEC();

  if(obj == "stealth_a") {
    _id_41ABE0908B86B235 = ["spawner_obj_a_exterior_", "spawner_obj_a_exterior_patrol_"];
    ai_spawned = [];

    foreach(group_name in _id_41ABE0908B86B235) {
      _id_63EBA43A116802D9 = group_name + _id_D70F981E9EBE2A90();
      _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_63EBA43A116802D9, 1)[0];

      if(isDefined(_id_5571AE8A9C277A18)) {
        ai_spawned = scripts\engine\utility::array_combine(ai_spawned, _id_5571AE8A9C277A18.ai_spawned);
        ai_spawned = scripts\engine\utility::array_removedead_or_dying(ai_spawned);
      }
    }

    if(ai_spawned.size > 0) {
      if(_func_EAC0CD99C9C6D8EE() == "spotted")
        return 2;
      else if(scripts\stealth\manager::anyone_in_hunt())
        return 1;
      else
        return 0;
    }

    if(level._id_A63144E6E64B0558[obj] > 1) {
      if(level._id_359C318944444B78[obj] > 0)
        return 1;
    }

    if(level._id_B8615F42FA1FFC45[obj] > 1) {
      if(level._id_359C318944444B78[obj] > 0)
        return 1;
    }

    if(level._id_0B59073F7450E763[obj] > 4)
      return 0;
  }

  if(level._id_A63144E6E64B0558[obj] > 1) {
    if(level._id_359C318944444B78[obj] > 0)
      return 2;
  }

  if(level._id_B8615F42FA1FFC45[obj] > 1) {
    if(level._id_359C318944444B78[obj] > 0)
      return 1;
  }

  if(level._id_0B59073F7450E763[obj] > 4)
    return 0;

  return 0;
}

_id_617B57B7F5FB10EE(type, delay, obj) {
  wait(delay);

  switch (type) {
    case "hunt":
      level._id_B8615F42FA1FFC45[obj]++;
      break;
    case "combat":
      level._id_A63144E6E64B0558[obj]++;
      break;
    case "investigate":
      level._id_0B59073F7450E763[obj]++;
      break;
    case "killed":
      level._id_746E72886EBA1382[obj]++;
      break;
  }
}

_id_07D4F952FAF64021() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_container") || scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
      _id_E61AF03C9E384F0F = 0;
      _id_E7758D1CEF59FBF6 = 0;
      _id_E4189F6142F280F1 = 0;
      _id_2795910EA142BEBD = 0;
      _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
      _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
      _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");
      _id_A5AE61DD930BF2A5 = getEnt("exfil_area", "script_noteworthy");

      if(self istouching(_id_5EAD7CD5BD2A23C3))
        _id_E61AF03C9E384F0F = 1;

      if(self istouching(_id_046CF58102043E30))
        _id_E7758D1CEF59FBF6 = 1;

      if(self istouching(_id_867B6418DD3354E1))
        _id_94A36A51659A7A2E = 1;

      if(self istouching(_id_A5AE61DD930BF2A5))
        _id_2795910EA142BEBD = 1;

      if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1 && !_id_2795910EA142BEBD) {
        _id_C837AD627899C30C = scripts\engine\utility::getclosest(self.origin, getEntArray("objective_trigger", "targetname"));

        if(!isDefined(_id_C837AD627899C30C)) {
          continue;
        }
        objname = _id_C837AD627899C30C.script_noteworthy;
      } else {
        if(_id_E61AF03C9E384F0F)
          objname = "stealth_a";

        if(_id_E7758D1CEF59FBF6)
          objname = "stealth_b";

        if(_id_E4189F6142F280F1)
          objname = "stealth_c";

        if(_id_2795910EA142BEBD)
          objname = "exfil_area";
      }
    }

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a") || objname == "stealth_a")
      thread _id_AA672E8DA9F814D9("exterior", 0.05, "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_b") || objname == "stealth_b")
      thread _id_AA672E8DA9F814D9("exterior", 0.05, "stealth_b");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_c") || objname == "stealth_c")
      thread _id_AA672E8DA9F814D9("exterior", 0.05, "stealth_c");

    if(scripts\cp\cp_objectives::is_objective_active("exfil_area") || objname == "exfil_area")
      thread _id_AA672E8DA9F814D9("exterior", 0.05, "exfil_area");

    level._id_26678298A0072160 = 1;
  }
}

_id_326E629502D6C341() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");
    _id_E61AF03C9E384F0F = 0;
    _id_E7758D1CEF59FBF6 = 0;
    _id_E4189F6142F280F1 = 0;
    _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
    _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
    _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");

    if(self istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(self istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(self istouching(_id_867B6418DD3354E1))
      _id_94A36A51659A7A2E = 1;

    if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1) {
      _id_C837AD627899C30C = scripts\engine\utility::getclosest(self.origin, getEntArray("objective_trigger", "targetname"));

      if(!isDefined(_id_C837AD627899C30C)) {
        continue;
      }
      objname = _id_C837AD627899C30C.script_noteworthy;
    } else {
      if(_id_E61AF03C9E384F0F)
        objname = "stealth_a";

      if(_id_E7758D1CEF59FBF6)
        objname = "stealth_b";

      if(_id_E4189F6142F280F1)
        objname = "stealth_c";
    }

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a") || objname == "stealth_a")
      thread _id_AA672E8DA9F814D9("downstairs", 0.1, "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_b") || objname == "stealth_b")
      thread _id_AA672E8DA9F814D9("downstairs", 0.1, "stealth_b");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_c") || objname == "stealth_c")
      thread _id_AA672E8DA9F814D9("downstairs", 0.1, "stealth_c");
  }
}

_id_31FB1D1A4142F010(group_name, func) {
  thread _id_326E629502D6C341();
  _id_2FD3B7F3740D5F23(group_name, func);
}

_id_11B4E3B230C2BEF3() {
  self endon("death");
  _id_7B64EABBDC923F61 = ["footstep", "footstep_walk", "silenced_shot", "seek_backup", "window_open", "door_bash", "landing", "missile_spawned"];

  for(;;) {
    self waittill("ai_events", events);

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }
    if(self.ignoreall || self isragdoll()) {
      continue;
    }
    foreach(event in events) {
      if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.type)) {
        continue;
      }
      self.script_combatmode = "cover";
      self.combatmode = self.script_combatmode;
      _id_F443A992E25EAD4A();
      return;
    }
  }
}

_id_A0210E7B1BCAC21F(group) {
  self.goalradius = 300;
  self.combatmode = "ambush";
  thread _id_78942AAFDAA59637();
  thread _id_5C4325F409A1BA2C();
}

_id_78942AAFDAA59637(obj) {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");

  for(;;) {
    playerlist = [];

    foreach(player in playerlist) {
      if(_id_19B2AC035D02BEB8(player)) {
        self.goalradius = 250;
        self.combatmode = "no_cover";
        self notify("alerted_to_player");
        return;
      }
    }

    wait 0.1;
  }
}

_id_5C4325F409A1BA2C(obj) {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");
  self waittill("damage", idamage, eattacker);
  self.goalradius = 250;
  self.combatmode = "no_cover";
  self notify("alerted_to_player");
}

_id_19B2AC035D02BEB8(player) {
  _id_ECE9C1126186017B = distance(player.origin, self.origin) <= 256;
  _id_30068470264CDE43 = self cansee(player);
  return _id_ECE9C1126186017B && _id_30068470264CDE43;
}

_id_BCE45E934D877240(group_name, func) {
  thread _id_326E629502D6C341();
  _id_2FD3B7F3740D5F23(group_name, func);
}

_id_12FF41AFC888CF59(event) {
  if(_id_9A9B91C11482389F(event))
    return 1;

  if(event.typeorig == "grenade danger")
    return 1;

  if(event.typeorig == "explosion")
    return 1;

  if(event.typeorig == "gunshot_teammate")
    return 1;

  return 0;
}

_id_9A9B91C11482389F(event) {
  _id_9AE80645C2B78E8A = [];

  if(isDefined(self.stealth._id_90CDC499FC2BDDD7))
    _id_9AE80645C2B78E8A = scripts\cp\utility::array_merge(_id_9AE80645C2B78E8A, self.stealth._id_90CDC499FC2BDDD7);

  if(scripts\engine\utility::array_contains(_id_9AE80645C2B78E8A, event.typeorig))
    return 1;

  if(isDefined(event.typeorig) && event.typeorig == "missile_spawned" || event.typeorig == "grenade danger")
    return 1;

  _id_1C01519BD9CEC9A6 = (event.typeorig == "grenade danger" || event.typeorig == "missile_spawned") && isDefined(event.entity) && isDefined(event.entity.weapon_name) && scripts\engine\utility::is_equal(event.entity.weapon_name, "geiger_counter_mp");

  if(_id_1C01519BD9CEC9A6)
    return 1;

  return 0;
}

_id_23CC696DDB16AB42() {
  return 1;
}

_id_F161C068112045E3(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "gunshot_impact", "projectile_impact", "door_open", "window_open", "door_bash", "landing", "missile_spawned"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(_id_D4A08728BF86E790(event))
        return 1;

      if(!self hastacvis(event.origin, 1) && !_id_CA53F38B1EB70113(event.origin, 1, level._id_8EE9C5604A4FB6C0))
        return 1;
      else {}
    }
  }

  if(_id_9A9B91C11482389F(event))
    return 1;

  self laseron();

  if(isDefined(event.type) && event.type == "combat" || event.type == "cover_blown") {
    self.goalradius = 128;
    return 0;
  }

  return 0;
}

_id_D4A08728BF86E790(ent) {
  return abs(ent.origin[2] - self.origin[2]) > 120;
}

_id_2F5B3F79C587787F(event) {
  dist = 1024;

  if(event.typeorig == "explosion") {
    offhand = undefined;

    if(isPlayer(event.entity)) {
      if(isDefined(level.last_molotov_explode_time) && gettime() - level.last_molotov_explode_time <= 50)
        offhand = "molotov";
      else if(isDefined(level.last_flash_explode_time) && gettime() - level.last_flash_explode_time <= 50)
        offhand = "flash";
      else if(isDefined(level._id_DB1B17B1CAAD25DB) && gettime() - level._id_DB1B17B1CAAD25DB <= 50)
        offhand = "throwingknife";
      else if(isDefined(level._id_012A10C9B8E19DF0) && gettime() - level._id_012A10C9B8E19DF0 <= 50)
        offhand = "concussion";
      else if(isDefined(level._id_2445992238654014) && gettime() - level._id_2445992238654014 <= 50) {
        offhand = "snapshotgrenade";
        dist = 256;
      }
    }

    if(isDefined(offhand)) {
      if(distancesquared(self.origin, event.origin) > dist * dist)
        return 1;
    }
  }

  return 0;
}

_id_740482DD5A644509(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "projectile_impact", "door_bash", "landing", "missile_spawned"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1) && !_id_CA53F38B1EB70113(event.origin, 1, level._id_8EE9C5604A4FB6C0))
        return 1;
      else {}
    }
  }

  if(_id_9A9B91C11482389F(event))
    return 1;

  if(event.typeorig == "saw_corpse") {
    if(isDefined(self.vehicle) && isDefined(self.vehicle._id_F626B845D8C284E2)) {
      self.vehicle._id_F626B845D8C284E2 = 1;
      self.vehicle._id_FDA9EA513D557243 = event;
      return 0;
    }
  }

  if(event.type == "combat") {
    if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
      self.combatmode = "no_cover";
      self._id_2626D6897D71B728 = 2000;
      _id_18A73A64992DD07D::set_goal_radius(4096);
      self setgoalpos(event.origin);
      return 0;
    }

    self laseron();
    self.goalradius = 1024;
    self setgoalpos(event.origin);
    return 0;
  }

  return 0;
}

_id_5F5A4D2653D12C86(event) {
  _id_7B64EABBDC923F61 = ["footstep", "footstep_walk", "unresponsive_teammate", "saw_corpse", "found_corpse", "seek_backup", "silenced_shot", "sight", "seek_backup", "window_open", "ally_hurt_peripheral", "sight_drone", "grenade danger", "bulletwhizby", "door_bash", "landing", "missile_spawned"];

  if(_id_9A9B91C11482389F(event))
    return 1;

  if(event.typeorig == "ally_killed") {}

  if(event.typeorig == "ally_damaged") {}

  if(event.typeorig == "bulletwhizby") {
    _id_47C9BD4C15F7C147 = self getEye();
    _id_5B637804196456BA = vectorNormalize(event.origin - _id_47C9BD4C15F7C147);
    event.origin = _id_47C9BD4C15F7C147 + _id_5B637804196456BA * 200;
  }

  if(event.type == "combat") {
    volume = getEnt("stealth_room_5", "targetname");

    if(isDefined(volume)) {}
  }

  return 0;
}

_id_F443A992E25EAD4A() {
  _id_B73684B0020214EE = strtok(self.group.group_name, "_");
  obj = _id_B73684B0020214EE[2];
  _id_BD44CBBE9FA4A1F1 = issubstr(self.group.group_name, "interior");

  switch (obj) {
    case "a":
      if(issubstr(self.group.group_name, "roof")) {
        self setgoalvolumeauto(getEnt("obj_a_interior_volume", "targetname"));
        return;
      }

      if(issubstr(self.group.group_name, "upstairs")) {
        if(scripts\engine\utility::cointoss())
          self setgoalvolumeauto(getEnt("obj_a_stealth_room_6", "targetname"));
        else
          self setgoalvolumeauto(getEnt("obj_a_stealth_room_7", "targetname"));

        return;
      } else if(issubstr(self.group.group_name, "interior")) {
        self setgoalvolumeauto(getEnt("obj_a_stealth_room_hall", "targetname"));
        return;
      }

      _id_58D857B570D41016 = getEnt("obj_a_interior_volume", "targetname");

      if(isDefined(_id_58D857B570D41016))
        self setgoalvolumeauto(_id_58D857B570D41016);

      break;
    case "b":
      if(issubstr(self.group.group_name, "roof")) {
        self setgoalvolumeauto(getEnt("stealth_room_8", "targetname"));
        return;
      }

      if(issubstr(self.group.group_name, "ambush")) {
        self setgoalvolumeauto(getEnt("stealth_room_4", "targetname"));
        return;
      }

      if(issubstr(self.group.group_name, "interior_2")) {
        if(scripts\engine\utility::cointoss())
          self setgoalvolumeauto(getEnt("stealth_room_upper", "targetname"));
        else if(scripts\engine\utility::cointoss())
          self setgoalvolumeauto(getEnt("stealth_room_ground", "targetname"));
        else
          self setgoalvolumeauto(getEnt("obj_b_interior_volume_2", "targetname"));

        return;
      } else if(issubstr(self.group.group_name, "interior")) {
        if(scripts\engine\utility::cointoss())
          self setgoalvolumeauto(getEnt("stealth_room_3", "targetname"));
        else if(scripts\engine\utility::cointoss())
          self setgoalvolumeauto(getEnt("stealth_room_4", "targetname"));
        else
          self setgoalvolumeauto(getEnt("stealth_room_2", "targetname"));

        return;
      }

      _id_58D857B570D41016 = getEnt("obj_b_interior_volume", "targetname");

      if(isDefined(_id_58D857B570D41016))
        self setgoalvolumeauto(_id_58D857B570D41016);

      break;
    case "c":
      if(istrue(_id_BD44CBBE9FA4A1F1)) {
        if(issubstr(self.group.group_name, "upstairs")) {
          if(scripts\engine\utility::cointoss())
            self setgoalvolumeauto(getEnt("stealth_room_12", "targetname"));
          else
            self setgoalvolumeauto(getEnt("stealth_room_11", "targetname"));

          return;
        } else if(issubstr(self.group.group_name, "interior")) {
          if(scripts\engine\utility::cointoss())
            self setgoalvolumeauto(getEnt("stealth_room_5", "targetname"));
          else
            self setgoalvolumeauto(getEnt("stealth_room_4", "targetname"));

          return;
        }

        _id_58D857B570D41016 = getEnt("obj_c_interior_volume", "targetname");

        if(isDefined(_id_58D857B570D41016))
          self setgoalvolumeauto(_id_58D857B570D41016);
      }

      break;
    default:
      break;
  }
}

_id_1BC335885E29F048(guy) {
  if(!isDefined(level._id_A786A02A10DB3CE4))
    level._id_A786A02A10DB3CE4 = [];

  guy.ignoreme = 1;
  guy.ignoreall = 1;
  guy.fixednode = 1;
  guy thread _id_1D435A0ECDF29F24();
}

_id_14D1B3C1FC80C027() {
  self._id_71C2F70CA88921B0 = spawn("script_model", self getmuzzlepos());
  self._id_71C2F70CA88921B0.angles = (0, self.angles[1], 0);
  self._id_71C2F70CA88921B0 setModel("tag_laser");
  temp = makeweapon("iw8_green_beam_ir_scripted");
  self._id_71C2F70CA88921B0 setmoverlaserweapon(temp);
  self._id_71C2F70CA88921B0 setotherent(self);
  self.mover = scripts\engine\utility::spawn_tag_origin(self._id_71C2F70CA88921B0.origin, self._id_71C2F70CA88921B0.angles);
  self.mover.targetname = "laser_rotator";
  self._id_71C2F70CA88921B0 linkTo(self.mover, "tag_origin", (-5, 0, 0), (0, 0, 0));
}

_id_1D435A0ECDF29F24() {
  if(scripts\engine\utility::array_contains(level._id_A786A02A10DB3CE4, self)) {
    return;
  }
  level._id_A786A02A10DB3CE4[level._id_A786A02A10DB3CE4.size] = self;
  self endon("death");
  childthread _id_4F2EF7DA91F80363();
  childthread _id_856A74CF0F38B7E4();
}

_id_BC62CC1ADFB69F41() {
  array = [];
  array["all"] = [];
  array["left"] = [];
  array["right"] = [];
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(s in _id_9E4E1482CB40C9C5) {
    array["all"][array["all"].size] = s;
    value = s.script_noteworthy;
    array[value][array[value].size] = s;
  }

  self._id_51AF9D68ABAA12AF = array;
}

_id_4F2EF7DA91F80363() {
  if(isDefined(self._id_71C2F70CA88921B0)) {
    return;
  }
  _id_14D1B3C1FC80C027();
  _id_71C2F70CA88921B0 = self._id_71C2F70CA88921B0;
  mover = self.mover;
  _id_BC62CC1ADFB69F41();
  _id_A66BA9B157533F5A = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "left", "right");
  _id_71C2F70CA88921B0 childthread _id_D032680573CBD4A9();
  array = self._id_51AF9D68ABAA12AF[_id_A66BA9B157533F5A];
  array = scripts\engine\utility::array_randomize(array);
  _id_C0A590ED14F737C6 = array[randomint(array.size)];
  mover.angles = vectortoangles(_id_C0A590ED14F737C6.origin - mover.origin);
  _id_71C2F70CA88921B0 laseron();
  wait 1;

  for(;;) {
    if(array.size == 0)
      array = self._id_51AF9D68ABAA12AF[_id_A66BA9B157533F5A];

    array = sortbydistance(array, _id_C0A590ED14F737C6.origin);
    _id_5FF31D70B5B91505 = array[array.size - 1];
    array = scripts\engine\utility::array_remove(array, _id_5FF31D70B5B91505);
    mover _id_7CAA16DC3E64F485(_id_C0A590ED14F737C6, _id_5FF31D70B5B91505, self);

    if(randomint(100) < 66) {
      holdtime = 1.4 + randomfloat(2);
      wait(holdtime);
    }

    _id_C0A590ED14F737C6 = _id_5FF31D70B5B91505;
  }
}

_id_7CAA16DC3E64F485(_id_C0A590ED14F737C6, _id_5FF31D70B5B91505, ai) {
  ai endon("spotted_player");
  targetangles = vectortoangles(_id_5FF31D70B5B91505.origin - self.origin);
  movetime = _id_7E1A468DA43087E3::mph_travel_time(randomintrange(9, 13), distance(_id_C0A590ED14F737C6.origin, _id_5FF31D70B5B91505.origin));
  movetime = int(movetime);
  movetime = scripts\engine\utility::ter_op(movetime <= 0, 1, movetime);
  _id_B5EE5C3A1C45A91F = randomintrange(4, 8);
  accel = movetime / _id_B5EE5C3A1C45A91F;
  decel = movetime - accel;
  self rotateTo(targetangles, movetime, accel, decel);

  if(isDefined(ai.laser_end_ent))
    ai.laser_end_ent moveTo(_id_5FF31D70B5B91505.origin, movetime, accel, decel);

  wait(movetime);
}

_id_D032680573CBD4A9() {
  self endon("entitydeleted");

  for(;;) {
    _id_67E8CE953C9E7E15 = randomfloatrange(0.025, 0.035);
    _id_6F3DBB030FA5B575 = (_id_67E8CE953C9E7E15, 0, 0);
    baseangles = (_id_67E8CE953C9E7E15 * -1, 0, 0);
    time = randomfloatrange(0.1, 0.35);
    self rotateby(_id_6F3DBB030FA5B575, time);
    wait(time);
    self rotateby(baseangles, time);
    wait(time);

    if(randomint(100) < 25) {
      wait(1 + randomfloat(2));
      continue;
    }

    waitframe();
  }
}

_id_856A74CF0F38B7E4() {
  wait 5;
  self.state = "on";
  self._id_F60C0E508092ED9E = 0;
  _id_51023E7DB5068D92::_id_FBC73A3AAC841ADA(self);
  childthread _id_8CEF0D23445290F2();

  for(;;) {
    wait(randomintrange(3, 6) + randomfloat(1.3));

    if(self.state == "on") {
      self notify("stop_tracing_for_player");
      self._id_F60C0E508092ED9E--;
      self._id_71C2F70CA88921B0 laseroff();
      self.state = "off";
      continue;
    }

    childthread _id_8CEF0D23445290F2();
    self._id_71C2F70CA88921B0 laseron();
    self.state = "on";
    _id_51023E7DB5068D92::turn_on_sniper_laser(self);
  }
}

_id_8CEF0D23445290F2() {
  self endon("stop_tracing_for_player");
  self notify("laser_trace_for_player");
  self endon("laser_trace_for_player");
  self._id_F60C0E508092ED9E++;

  for(;;) {
    end = self.laser_start_ent.origin + anglesToForward(self.laser_start_ent.angles) * 5000;
    trace = scripts\engine\trace::ray_trace(self.laser_start_ent.origin, self.laser_end_ent.origin, [self.mover, self._id_71C2F70CA88921B0, self.laser_start_ent, self.laser_end_ent]);

    if(isDefined(trace["entity"]) && isPlayer(trace["entity"]))
      trace["entity"] thread _id_DDD74CD9A69B2E94(self);

    wait(0.25 + randomfloat(0.15));
  }
}

_id_DDD74CD9A69B2E94() {
  self notify("new_laser_hit");
  self endon("new_laser_hit");
  scripts\engine\utility::ent_flag_set("laser_spotted_player");
  wait 2;
  scripts\engine\utility::ent_flag_clear("laser_spotted_player");
}

_id_439E128CD216930C(ai) {
  _id_9E4E1482CB40C9C5 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    _id_320CD48AB1661901 = randomintrange(0, 60);
    _id_02A5FDF6A565D925 = _id_C67D23B26AE2B9AD(5000, _id_320CD48AB1661901);
    struct = spawnStruct();

    if(ai scripts\cp\cp_spawning_util::cp_is_point_on_right(_id_02A5FDF6A565D925))
      struct.script_noteworthy = "right";
    else
      struct.script_noteworthy = "left";

    struct.origin = _id_02A5FDF6A565D925;
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::array_add(_id_9E4E1482CB40C9C5, struct);
  }

  return _id_9E4E1482CB40C9C5;
}

_id_C67D23B26AE2B9AD(radius, angle) {
  _id_CB920E03144E9344 = scripts\engine\math::degrees_to_radians(angle);
  position = (sin(_id_CB920E03144E9344), 0, cos(_id_CB920E03144E9344));
  return position * radius;
}

init_escalation() {
  level._id_A3A9959B0A31F7BC = spawnStruct();
  level._id_A3A9959B0A31F7BC._id_8FF4765EAC369993 = 1;
  level._id_A3A9959B0A31F7BC._id_E830EBCF792A5EF2 = [];
  level._id_A3A9959B0A31F7BC._id_100597AD2C6DA3E7 = "";
  level thread _id_FB5931DD79D98737();
  _id_1DF28248BEB48C09(::_id_1DFE74D683CC942D, 1);
  _id_1DF28248BEB48C09(::_id_1DFE74D683CC942D, 2);
  _id_1DF28248BEB48C09(::_id_1DFE74D683CC942D, 3);
}

_id_D70F981E9EBE2A90() {
  return getdvarint("dvar_2967FDD4515A6756", level._id_A3A9959B0A31F7BC._id_8FF4765EAC369993);
}

_id_86B3E62128DEF56C(value) {
  level._id_A3A9959B0A31F7BC._id_8FF4765EAC369993 = getdvarint("dvar_2967FDD4515A6756", value);
}

_id_B69E8D7955DFB262(_id_EB7B7D47D5339C45, objname) {
  spawn_group = "";

  if(isDefined(_id_EB7B7D47D5339C45) && isstring(_id_EB7B7D47D5339C45))
    spawn_group = _id_EB7B7D47D5339C45 + "_" + _id_D70F981E9EBE2A90();
  else if(objname == "stealth_a") {
    if(isDefined(level._id_BB07CFB91B5A51E8) && istrue(level._id_BB07CFB91B5A51E8["a"]))
      return "";

    spawn_group = "spawner_obj_a_exterior_reinforcement_" + _id_D70F981E9EBE2A90();
  } else if(objname == "stealth_b") {
    if(isDefined(level._id_BB07CFB91B5A51E8) && istrue(level._id_BB07CFB91B5A51E8["b"]))
      return "";

    spawn_group = "spawner_obj_b_exterior_reinforcement_" + _id_D70F981E9EBE2A90();
  } else if(objname == "stealth_c") {
    if(isDefined(level._id_BB07CFB91B5A51E8) && istrue(level._id_BB07CFB91B5A51E8["c"]))
      return "";

    spawn_group = "spawner_obj_c_exterior_reinforcement_" + _id_D70F981E9EBE2A90();
  } else
    spawn_group = "exfil_exterior_reinforcement_" + _id_D70F981E9EBE2A90();

  return spawn_group;
}

_id_7C36558FF1376EA2(spawngroup, objname) {
  spawn_group = _id_B69E8D7955DFB262(spawngroup, objname);

  if(!isDefined(spawn_group) || spawn_group == "") {
    return;
  }
  if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group))
    _id_18A73A64992DD07D::run_spawn_module(spawn_group);
}

_id_1DFE74D683CC942D() {}

_id_1DF28248BEB48C09(function, _id_D2B4BF70079CBEDE) {
  level._id_A3A9959B0A31F7BC._id_E830EBCF792A5EF2["escalation_" + _id_D2B4BF70079CBEDE] = function;
}

_id_A61FBDC458CDBB1E() {
  level._id_A3A9959B0A31F7BC._id_8FF4765EAC369993++;

  if(level._id_A3A9959B0A31F7BC._id_8FF4765EAC369993 > 3)
    level._id_A3A9959B0A31F7BC._id_8FF4765EAC369993 = 3;

  level notify("escalation_increased");
}

_id_FB5931DD79D98737() {
  for(;;) {
    level waittill("escalation_increased");

    switch (_id_D70F981E9EBE2A90()) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        return;
    }

    thread[[level._id_A3A9959B0A31F7BC._id_E830EBCF792A5EF2["escalation_" + _id_D70F981E9EBE2A90()]]]();
  }
}

_id_B334A03939C3F82E() {
  return getDvar("dvar_7E0FFC2916596C38", level._id_A3A9959B0A31F7BC._id_100597AD2C6DA3E7);
}

_id_6643E94DC5217B92(value) {
  level._id_A3A9959B0A31F7BC._id_100597AD2C6DA3E7 = getdvarint("dvar_7E0FFC2916596C38", value);
}

_id_A09D72E5F0A92E1A() {
  self endon("death");

  for(;;) {
    message = scripts\engine\utility::waittill_any_return_3("stealth_investigate", "stealth_combat", "stealth_idle");

    switch (message) {
      case "stealth_investigate":
        break;
      case "stealth_combat":
        self.soundent scripts\engine\utility::playsoundonentity("anml_dog_growl", "dog_growl");
        break;
      case "stealth_idle":
        break;
    }
  }
}

_id_65C9904722289CF4(group) {
  models = [];
  models[models.size] = "head_sas_urban_ar_nvg";
  models[models.size] = "head_sas_urban_ar_nvg_2";
  models[models.size] = "head_sas_woodland_ar_nvg";
  models[models.size] = "head_sas_woodland_ar_nvg_2";
  body = "body_al_qatala_urban_ar";

  if(istrue(self.wearing_armor)) {
    body = undefined;
    head = undefined;
    _id_16C92180949DB961(body, head, undefined, "molotov_mp", undefined, group);
  } else {}
}

_id_DACBB83E655A088F(group) {
  if(_id_18A73A64992DD07D::is_juggernaut_aitype()) {
    return;
  }
  _id_65C9904722289CF4(group);
}

_id_840298CB2CE4C610(group) {
  body = undefined;
  head = undefined;
  _id_A664AAD02EE98BD2 = undefined;

  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
    return;
  }

  _id_16C92180949DB961(body, head, undefined, _id_A664AAD02EE98BD2, undefined, group);
}

_id_6546612710E27275(groupname) {
  if(!isDefined(groupname))
    obj = _id_A55D4E07A9C77DEC();

  _id_1F8084006CD437C9 = groupname.group_name;
  _id_A8233E81EC4E5C04 = strtok(_id_1F8084006CD437C9, "_");
  obj = _id_A8233E81EC4E5C04[2];

  switch (obj) {
    case "a":
      return "stealth_a";
    case "b":
      return "stealth_b";
    case "c":
      return "stealth_c";
    default:
      return scripts\engine\utility::random(["stealth_a", "stealth_b", "stealth_c"]);
  }
}

_id_16C92180949DB961(body, head, weapon, _id_A664AAD02EE98BD2, helmet, groupname) {
  _id_E90003941479AD66 = _id_6546612710E27275(groupname);
  _id_411EAC2736313C66 = _id_D70F981E9EBE2A90();
  _id_EA7FEFB7F6C07FEE = 2;

  switch (_id_411EAC2736313C66) {
    case 1:
      _id_EA7FEFB7F6C07FEE = 2;
      break;
    case 2:
      _id_EA7FEFB7F6C07FEE = 2;
      break;
    case 3:
      _id_EA7FEFB7F6C07FEE = 2;
      break;
  }

  if(level._id_8E5F9C64412D7B4A[_id_E90003941479AD66] < _id_EA7FEFB7F6C07FEE) {
    _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(self);

    if(isDefined(head)) {
      if(isDefined(self.headmodel))
        self detach(self.headmodel);

      self attach(head, "", 1);
      self.headmodel = head;
    }

    level._id_8E5F9C64412D7B4A[_id_E90003941479AD66]++;
  } else {}

  self.grenadeammo = 6;
  self.script_forcegrenade = 1;
  self laseron();
}

_id_D5B6AA8EEA07BA9F() {
  laser = spawn("script_model", (0, 0, 0));
  laser linkTo(self, "tag_flash", (0, 0, 0), (0, 0, 0));
  laser setModel("tag_laser");
  laser setmoverlaserweapon(makeweapon("iw9_armored_enemy_laser_cp"));
  laser setotherent(self);
  self laseron();
  self waittill("death");
  laser delete();
}

_id_9C0FBE62C1B9D660(_id_875864798EFD8038, _id_E941AE2BB06F82B8, _id_BA9824D8903E7718) {
  self endon("death");
  self endon("stop_hunting");

  if(istrue(_id_BA9824D8903E7718))
    self waittill("unload");

  player = scripts\engine\utility::random(level.players);
  count = 0;

  for(;;) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(_id_4A27F44F23590C6F in level.players) {
        if(istrue(_id_4A27F44F23590C6F.inlaststand)) {
          continue;
        }
        player = _id_4A27F44F23590C6F;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    if(!istrue(_id_E941AE2BB06F82B8)) {
      if(!self cansee(player) && !scripts\cp\utility::ifcanseeplayer(self, player)) {
        waitframe();
        player = scripts\engine\utility::random(level.players);
        continue;
      }
    }

    scripts\engine\utility::delaycall(0.05, ::aieventlistenerevent, "combat", player, player.origin);
    scripts\engine\utility::delaycall(0.1, ::getenemyinfo, player);
    org = player.origin;
    self setgoalpos(player.origin);
    _id_18A73A64992DD07D::set_goal_radius(1500);
    count++;

    if(isDefined(_id_875864798EFD8038) && _id_875864798EFD8038 < count) {
      return;
    }
    wait 4;
  }
}

watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon))
      dochangeweapon(objweapon);

    self waittill("weapon_change");
  }
}

dochangeweapon(objweapon) {
  _id_74502A9E0EF1F19C::updatelauncherusage();
  _id_74502A9E0EF1F19C::updatedragonsbreath(objweapon);
}

_id_7C24435BEDF6DBE9(group_name, func) {
  thread _id_13869DF22E9149EC("stealth_c");
  _id_2FD3B7F3740D5F23(group_name, func);
}

_id_31FB1E1A4142F243(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self.sightmaxdistance = 1000;
  self laseron();
  thread _id_326E629502D6C341();

  if(getdvarint("dvar_C3AB26A07F44395A", 0) == 0)
    scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);

  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("should_hunt", ::_id_23CC696DDB16AB42);

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("combat");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      self getenemyinfo(level.players[_id_AC0E594AC96AA3A8]);
  } else if(_id_51023E7DB5068D92::_id_A565F7E6BB57FB0F()) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_2FD3B7F3740D5F23(group_name, func, _id_8CE65CDA3BA648CD) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  _id_371B4C2AB5861E62::_id_DC01679146E5F53C(self);

  if(issubstr(self.group.group_name, "barracks")) {
    level._id_3221D2DB1C467EED["ambient_b"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["ambient_b"], self);
    thread _id_3E25035A1E82FBA5(1, "ambient_b");
  }

  if(issubstr(self.group.group_name, "comms")) {
    level._id_3221D2DB1C467EED["ambient_c"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["ambient_c"], self);
    thread _id_3E25035A1E82FBA5(1, "ambient_c");
  }

  if(issubstr(self.group.group_name, "armory")) {
    level._id_3221D2DB1C467EED["ambient_a"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["ambient_a"], self);
    thread _id_3E25035A1E82FBA5(1, "ambient_a");
  }

  if(issubstr(self.group.group_name, "spawner_obj_c")) {
    level._id_3221D2DB1C467EED["stealth_c_interior"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["stealth_c_interior"], self);
    thread _id_3E25035A1E82FBA5(1, "stealth_c_interior");
  }

  if(issubstr(self.group.group_name, "spawner_obj_b")) {
    level._id_3221D2DB1C467EED["stealth_b_interior"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["stealth_b_interior"], self);
    thread _id_3E25035A1E82FBA5(1, "stealth_b_interior");
  }

  if(issubstr(self.group.group_name, "spawner_obj_a")) {
    level._id_3221D2DB1C467EED["stealth_a_interior"] = scripts\engine\utility::array_add(level._id_3221D2DB1C467EED["stealth_a_interior"], self);
    thread _id_3E25035A1E82FBA5(1, "stealth_a_interior");
  }

  self.stealth.funcs["event_investigate"] = ::_id_F161C068112045E3;
  self.stealth.funcs["event_cover_blown"] = ::_id_F161C068112045E3;
  self.stealth.funcs["event_combat"] = ::_id_F161C068112045E3;
  self.stealth.funcs["should_hunt"] = ::_id_23CC696DDB16AB42;
  _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
  _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
  _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");
  _id_A5AE61DD930BF2A5 = getEnt("exfil_area", "script_noteworthy");
  obj = "";

  if(self istouching(_id_5EAD7CD5BD2A23C3))
    obj = "stealth_a";

  if(self istouching(_id_046CF58102043E30))
    obj = "stealth_b";

  if(self istouching(_id_867B6418DD3354E1))
    obj = "stealth_c";

  if(self istouching(_id_A5AE61DD930BF2A5))
    obj = "exfil_area";

  _id_5FDF098FCB65A12E = _id_1BC0B4CB2C52BFD4();

  switch (_id_5FDF098FCB65A12E) {
    case 1:
      self[[self.fnsetstealthstate]]("hunt");
      break;
    case 2:
      self[[self.fnsetstealthstate]]("combat");
      break;
    default:
      break;
  }

  self.goalradius = 128;
}

_id_C93FF42EDD424B43(_id_F8E5E3AA5762A8E7) {
  self endon("death");
  level endon("game_ended");
  scripts\stealth\utility::set_event_override("combat", ::_id_3019518037F6F828);
  scripts\stealth\utility::set_event_override("cover_blown", ::_id_74029165F1B9193E);
}

_id_3019518037F6F828(event) {
  if(scripts\engine\utility::flag("stealth_spotted_perm"))
    level thread _id_18A73A64992DD07D::run_spawn_module("general_reinforcements");

  self.goalradius = 1024;
  scripts\stealth\utility::set_event_override("combat", undefined);
  scripts\stealth\utility::set_event_override("cover_blown", undefined);
  return 0;
}

_id_74029165F1B9193E(event) {
  self.goalradius = 1024;
  scripts\stealth\utility::set_event_override("combat", undefined);
  scripts\stealth\utility::set_event_override("cover_blown", undefined);
  return 0;
}

_id_CA53F38B1EB70113(origin, _id_7E6761D0C6470CA2, dist) {
  if(!isDefined(_id_7E6761D0C6470CA2))
    _id_7E6761D0C6470CA2 = 1;

  if(_id_7E6761D0C6470CA2 && !scripts\engine\utility::within_fov(self.origin, self.angles, origin, cos(180)))
    return 0;

  _id_67245ACC80F2296D = _id_CABCC7C3E8682497();
  _id_C127D102DD2295C3 = _id_0B071913D4B91319();

  if(!isDefined(dist))
    dist = 1024;

  if(!_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, dist))
    return 0;

  if(_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, level.stealth.damage_sight_range))
    return 1;

  if(_id_7E6761D0C6470CA2) {
    if(isai(self) && !self aipointinfov(origin))
      return 0;
  }

  _id_125435EA93CCA389 = level._id_318CEAE290567709;
  return scripts\engine\trace::ray_trace_passed(_id_67245ACC80F2296D, origin, [self], _id_125435EA93CCA389);
}

_id_86C6AFB41A6C383B(start, end, dist) {
  if(!isDefined(start) || !isDefined(end))
    return 0;

  return distancesquared(start, end) <= dist * dist;
}

_id_CABCC7C3E8682497() {
  if(isDefined(self._id_18718F98529A77D8)) {
    if(self._id_695601297697AB71 == gettime())
      return self._id_18718F98529A77D8;

    if(isDefined(self._id_DF2EC152343705D2) && self._id_DF2EC152343705D2 == self.origin)
      return self._id_18718F98529A77D8;
  }

  if(isai(self))
    self._id_18718F98529A77D8 = self getapproxeyepos();
  else {
    self._id_18718F98529A77D8 = self gettagorigin("tag_eye");
    self._id_DF2EC152343705D2 = self.origin;
  }

  self._id_695601297697AB71 = gettime();
  return self._id_18718F98529A77D8;
}

_id_0B071913D4B91319() {
  if(isDefined(self._id_2B5F8CE7DE8E2AF2)) {
    if(self._id_BE76BF1CCA511D73 == gettime())
      return self._id_2B5F8CE7DE8E2AF2;

    if(isDefined(self._id_87B23FA7022B1C46) && self._id_87B23FA7022B1C46 == self.angles)
      return self._id_2B5F8CE7DE8E2AF2;
  }

  self._id_2B5F8CE7DE8E2AF2 = self gettagangles("tag_eye");
  self._id_BE76BF1CCA511D73 = gettime();
  return self._id_2B5F8CE7DE8E2AF2;
}

_id_B89C504333CED26E() {
  if(isDefined(self.enemy))
    self _meth_8A144CB1601C409A();

  self _meth_EA50442798FCA4C1("idle");
  self.bisincombat = 0;
  self.alertlevel = "noncombat";
}

_id_BA0801276542946B() {
  if(!isDefined(level._id_61312C4C9C8A7CAE))
    level._id_61312C4C9C8A7CAE = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "molotov_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];

  return scripts\engine\utility::random(level._id_61312C4C9C8A7CAE);
}

_id_1734DE9810F8E785(agent) {
  if(!isDefined(agent)) {
    return;
  }
  body = undefined;
  head = undefined;
  armor = 2500;
  helmet = 1;
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_mkilo3_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  _id_A664AAD02EE98BD2 = _id_BA0801276542946B();
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);
  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent._id_98ADD129A7ECB962 = 0;
  agent.allowpain = 1;
  agent.baseaccuracy = getdvarfloat("dvar_BF81930E3FF6D7EB", 1.2);
}

_id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, _id_E7DF46025EC50EAC) {
  if(isDefined(body))
    self setModel(body);

  if(isDefined(head)) {
    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach(head, "", 1);
    self.headmodel = head;
  }

  if(isDefined(weapon)) {
    _id_B003E2C45A4BF6F7 = undefined;
    weaponname = undefined;

    if(isDefined(self.weapon)) {
      self takeweapon(self.weapon);
      weaponname = getcompleteweaponname(self.weapon);

      if(isDefined(self.weaponinfo[weaponname])) {
        _id_B003E2C45A4BF6F7 = self.weaponinfo[weaponname].position;
        self.weaponinfo = scripts\engine\utility::array_remove_key(self.weaponinfo, weaponname);
      }
    }

    self.weapon = weapon;
    scripts\common\utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;

    if(isDefined(self.a.weaponpos[_id_B003E2C45A4BF6F7])) {
      weaponname = getcompleteweaponname(self.weapon);
      self.weaponinfo[weaponname].position = _id_B003E2C45A4BF6F7;
      self.a.weaponpos[_id_B003E2C45A4BF6F7] = weapon;
    }
  }

  if(isDefined(_id_A664AAD02EE98BD2)) {
    if(!isDefined(level._id_E36AF3BFA3484A15))
      level._id_E36AF3BFA3484A15 = [];

    if(!isDefined(level._id_E36AF3BFA3484A15[_id_A664AAD02EE98BD2]))
      level._id_E36AF3BFA3484A15[_id_A664AAD02EE98BD2] = makeweapon(_id_A664AAD02EE98BD2);

    self.grenadeweapon = level._id_E36AF3BFA3484A15[_id_A664AAD02EE98BD2];

    if(!isDefined(grenadeammo))
      grenadeammo = 2;

    self.grenadeammo = grenadeammo;
  }

  if(isDefined(armor)) {
    self._id_B5218CF00DAD94EF = armor;
    self.equip_armor = 1;
  }

  if(isDefined(helmet))
    self.helmet = helmet;

  if(istrue(_id_E7DF46025EC50EAC)) {}

  if(isDefined(armor) && armor > 0)
    _id_1920867DDF76810C(self, armor);
}

_id_1920867DDF76810C(agent, armor) {
  if(isDefined(armor) && armor > 0) {
    agent._id_9AA77AB756FDCA82 = 1000;
    agent._id_43E2AD424676B8D4 = 100;
    agent._id_BDC4A284F9421FFC = 2000;
  } else {
    agent._id_9AA77AB756FDCA82 = 200;
    agent._id_43E2AD424676B8D4 = 10;
    agent._id_BDC4A284F9421FFC = 1000;
  }
}

_id_D24590F588A71CA2() {
  if(_id_18A73A64992DD07D::is_juggernaut_aitype() || _id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    return;
  }
  _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

  if(!isDefined(_id_C729D49D406ACED8))
    _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(self.origin, level.players);

  thread _id_43A45E199254CE4F(_id_C729D49D406ACED8);
}

_id_43A45E199254CE4F(player) {
  self endon("death");
  self getenemyinfo(player);
  self.lastenemysightpos = player.origin;
  self._id_5323A94889EFF1DE = 1;
  self.goalradius = 1024;
  self.aggressivemode = 1;
  self setgoalentity(player);
  thread _id_6DAE2816A58B8A6D(player);
}

_id_6DAE2816A58B8A6D(player) {
  self endon("death");
  self endon("stop_player_seek");
  _id_7E1EC739AE6C0015 = 1200;
  _id_016D0BB7FD27FCFC = distance(self.origin, player.origin);

  for(;;) {
    wait 2;
    self getenemyinfo(player);
    self setgoalentity(player);
    _id_016D0BB7FD27FCFC = _id_016D0BB7FD27FCFC - 175;

    if(_id_016D0BB7FD27FCFC < _id_7E1EC739AE6C0015) {
      _id_016D0BB7FD27FCFC = _id_7E1EC739AE6C0015;
      return;
    }
  }
}

set_favoriteenemy(enemy) {
  self.favoriteenemy = enemy;
}

#using_animtree("mp_vehicles_always_loaded");

_id_815A8EBC21BE9A01(veh) {
  spawndata = spawnStruct();
  spawndata.angles = veh.angles;
  spawndata.origin = veh.origin;

  if(istrue(self._id_2007F5A5A462CD9D))
    return 0;

  self._id_2007F5A5A462CD9D = 1;
  _id_998BE083DDA4BA35 = 0;
  _id_5D61F034B126CBCA = undefined;

  switch (veh.model) {
    case "veh9_mil_lnd_jltv_turret_vehphys_mp":
      if(getdvarint("dvar_1D8B8C45BBA6A4D6", 1) > 0) {
        while(isDefined(veh.gunner) && isalive(veh.gunner))
          wait 0.25;

        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(veh, "neutral");
        veh.door_open = 1;
        veh vehicleplayanim(%vh_decho_driver_exit_patrol);
        veh._id_CF1E271394C5DC95 = 850;
        _id_998BE083DDA4BA35 = 0;
        waitframe();
        veh.health = 2250;
        _id_5E69D629FB22356B = 0;
        level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_remove(level._id_6E5FF6CAE14C4081, veh);

        if(isDefined(veh._id_393832BCEC3AFD03)) {
          foreach(guy in veh._id_393832BCEC3AFD03)
          guy thread _id_26A109763948086A();
        }

        veh _id_0F3B4A4783EDE654::_id_AB23AE9A33E231FE();
        wait 1;
        veh vehicle_settopspeedforward(35);
        veh vehicle_settopspeedreverse(35);
      }

      break;
  }

  if(_id_998BE083DDA4BA35) {
    if(isDefined(_id_5D61F034B126CBCA)) {
      _id_74502A9E0EF1F19C::add_to_special_lockon_target_list(_id_5D61F034B126CBCA);

      if(isDefined(veh.vehicle_spawner._id_72772FA651ECBE2B)) {
        funcs = strtok(veh.vehicle_spawner._id_72772FA651ECBE2B, "+");

        foreach(func in funcs) {
          if(func != "ammo_cache") {
            continue;
          }
          _id_5D61F034B126CBCA thread[[level._id_A8DC22C62BA69B88[func]]]();
        }
      }
    }

    veh _id_0E80538EF14D00E1::delete_nav_obstacle();
    veh delete();
  }

  return _id_998BE083DDA4BA35;
}

_id_26A109763948086A() {
  player = scripts\cp\utility::get_closest_living_player();

  if(isDefined(player)) {
    self setgoalpos(player.origin);
    event = spawnStruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = player.origin;
    event.investigate_pos = player.origin;
    self[[self.fnsetstealthstate]]("combat", event);
    thread _id_D24590F588A71CA2();
  } else
    self[[self.fnsetstealthstate]]("hunt");
}

_id_B22C9A7A55685AF2() {
  level endon("kill_barracks_reinforcements_check_thread");

  for(;;) {
    waitframe();
    _id_6643ADB792E6BD9A = 0;

    foreach(volume in level._id_E603A83D83B0080D) {
      foreach(player in level.players) {
        if(player istouching(volume)) {
          if(!istrue(level._id_37DBED10A6D2831C)) {
            if(isDefined(level._id_2BD31BDC94B899B0) && istrue(level._id_29496147124CF052)) {
              foreach(ai in level._id_2BD31BDC94B899B0) {
                if(isDefined(ai.fnisinstealthcombat) && ai[[ai.fnisinstealthcombat]]())
                  _id_6643ADB792E6BD9A = 1;
              }
            } else if(level._id_A359CB3E2BFA1964["stealth_a"] > 0 || level._id_9EEAB63C54988C55["stealth_a"] > 0 || level._id_359C318944444B78["stealth_a"] > 0)
              _id_6643ADB792E6BD9A = 1;

            if(_func_EAC0CD99C9C6D8EE() == "spotted" && istrue(_id_6643ADB792E6BD9A)) {
              if(!isDefined(level._id_F75A58E27E264659))
                level._id_F75A58E27E264659 = getEntArray("pa_system", "targetname");

              if(!istrue(level._id_B4987EEEBA421B86)) {
                level._id_B4987EEEBA421B86 = 1;

                foreach(_id_CDCD3C78F5177DB6 in level._id_F75A58E27E264659) {
                  if(isDefined(_id_CDCD3C78F5177DB6.struct.script_label) && _id_CDCD3C78F5177DB6.struct.script_label == "stealth_a")
                    thread scripts\cp\coop_stealth::_id_C72B7181608C8607(_id_CDCD3C78F5177DB6, 1, 5);
                }
              }

              spawn_group = _id_B69E8D7955DFB262(undefined, "stealth_a");

              if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group)) {
                _id_18A73A64992DD07D::run_spawn_module(spawn_group);
                level._id_37DBED10A6D2831C = 1;
                level notify("reinforcements_spawned_for_objstealth_a");
              }

              break;
            }
          } else
            return;
        }
      }
    }
  }
}

_id_96833BEC3E33C856() {
  level._id_3221D2DB1C467EED["ambient_b"] = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3221D2DB1C467EED["ambient_b"]);
  level._id_3221D2DB1C467EED["ambient_b"] = scripts\engine\utility::array_removedead_or_dying(level._id_3221D2DB1C467EED["ambient_b"]);
  level._id_3221D2DB1C467EED["ambient_c"] = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3221D2DB1C467EED["ambient_c"]);
  level._id_3221D2DB1C467EED["ambient_c"] = scripts\engine\utility::array_removedead_or_dying(level._id_3221D2DB1C467EED["ambient_c"]);
  level._id_3221D2DB1C467EED["ambient_a"] = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3221D2DB1C467EED["ambient_a"]);
  level._id_3221D2DB1C467EED["ambient_a"] = scripts\engine\utility::array_removedead_or_dying(level._id_3221D2DB1C467EED["ambient_a"]);
  level._id_3221D2DB1C467EED["stealth_c"] = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3221D2DB1C467EED["stealth_c"]);
  level._id_3221D2DB1C467EED["stealth_c"] = scripts\engine\utility::array_removedead_or_dying(level._id_3221D2DB1C467EED["stealth_c"]);
  level._id_3221D2DB1C467EED["stealth_b"] = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3221D2DB1C467EED["stealth_b"]);
  level._id_3221D2DB1C467EED["stealth_b"] = scripts\engine\utility::array_removedead_or_dying(level._id_3221D2DB1C467EED["stealth_b"]);
  level._id_3221D2DB1C467EED["stealth_a"] = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3221D2DB1C467EED["stealth_a"]);
  level._id_3221D2DB1C467EED["stealth_a"] = scripts\engine\utility::array_removedead_or_dying(level._id_3221D2DB1C467EED["stealth_a"]);
}