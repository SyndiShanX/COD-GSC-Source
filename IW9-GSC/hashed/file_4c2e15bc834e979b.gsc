/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4c2e15bc834e979b.gsc
***********************************************/

_id_F7D7FED899EE3228() {
  _id_48DF711E143EAE26 = getEntArray("heli_escort_init_blockers", "script_noteworthy");
  _id_C23C3F7A51CB732F = getEntArray("heli_escort_start_collision", "targetname");
  _id_48DF711E143EAE26 = scripts\cp\utility::array_merge(_id_48DF711E143EAE26, _id_C23C3F7A51CB732F);

  if(!isDefined(_id_48DF711E143EAE26) || _id_48DF711E143EAE26.size <= 0) {
    return;
  }
  foreach(_id_32595262B98E6F31 in _id_48DF711E143EAE26)
  _id_32595262B98E6F31 delete();
}

_id_A9EBFBC94671C0CE() {
  _id_48DF711E143EAE26 = getEntArray("poi_truck_collision", "targetname");

  if(!isDefined(_id_48DF711E143EAE26) || _id_48DF711E143EAE26.size <= 0) {
    return;
  }
  foreach(_id_32595262B98E6F31 in _id_48DF711E143EAE26)
  _id_32595262B98E6F31 moveTo((-28368, -43328, 2180), 0.1, 0, 0);
}

_id_A1460C4B1C8F3004() {
  _id_48DF711E143EAE26 = getEntArray("veh_escape_init_blockers", "targetname");

  if(!isDefined(_id_48DF711E143EAE26) || _id_48DF711E143EAE26.size <= 0) {
    return;
  }
  foreach(_id_32595262B98E6F31 in _id_48DF711E143EAE26)
  _id_32595262B98E6F31 delete();
}

_id_70829DF0E123DCE4() {
  _id_CB89110314447B2F = 0;

  if(!isDefined(level._id_CB71FB22BE469134))
    level._id_CB71FB22BE469134 = [];

  if(!isDefined(level._id_8D6BBD2A7D3244E1))
    level._id_8D6BBD2A7D3244E1 = [];

  if(isDefined(level._id_989A12C372A016F4))
    table = level._id_989A12C372A016F4;
  else
    table = "cp/ally_name_table.csv";

  _id_8E5FA3B3638168C8 = [];

  for(;;) {
    _id_782921312B88FD8F = tablelookupbyrow(table, _id_CB89110314447B2F, 1);

    if(_id_782921312B88FD8F == "") {
      break;
    }

    _id_8E5FA3B3638168C8 = scripts\engine\utility::array_add_safe(_id_8E5FA3B3638168C8, _id_782921312B88FD8F);
    _id_CB89110314447B2F++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_22BF17C0613C5A66 = scripts\engine\utility::random(_id_8E5FA3B3638168C8);
    _id_8E5FA3B3638168C8 = scripts\engine\utility::array_remove(_id_8E5FA3B3638168C8, _id_22BF17C0613C5A66);
    level._id_CB71FB22BE469134 = scripts\engine\utility::array_add_safe(level._id_CB71FB22BE469134, _id_22BF17C0613C5A66);
    level._id_8D6BBD2A7D3244E1 = scripts\engine\utility::array_add_safe(level._id_8D6BBD2A7D3244E1, _id_22BF17C0613C5A66);
  }
}

_id_82BB896A0ADA90E7() {
  level.dogtag_revive = 0;
  level._id_4A2737E9FBC409C2 = 1;
  level._id_D9B24DFD45B657CB = 1;
  level.should_do_damage_check_func = ::_id_CA842817190B441A;
  level._id_FF77C4774821472C = 32;
  level._id_A8DC22C62BA69B88["chase_truck"] = _id_0F3B4A4783EDE654::_id_F4D3D0EDD18649CB;
  level._id_A8DC22C62BA69B88["scripted_rooftop_rpg"] = _id_73B8B21BF4E3319E::_id_51139E209C5666F9;
  level _id_0E1B3BC2552FFDBC();
  level _id_6F86569F3FC91179();
  level._id_7E81A64330ECE925 = ::_id_1DF9FA439B91758F;
  scripts\engine\utility::flag_init("chopper_evading");
  level.enter_spectator_func = undefined;
  scripts\cp\vehicles\cp_heli_trip::initanims();
  _id_9559969BDC0DF2DB();
  setdvarifuninitialized("dvar_4A4DE8B30C5647A8", 1);
}

_id_6F86569F3FC91179() {
  oobtriggers = getEntArray("HeliEscortOOB", "targetname");

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers)
    trigger delete();
  }

  level.outofboundstriggers = [];

  foreach(trigger in oobtriggers) {
    if(scripts\engine\utility::array_contains(level.outofboundstriggers, trigger)) {
      continue;
    }
    level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
    level thread scripts\cp\cp_outofbounds::watchoobtrigger(trigger);
  }
}

_id_1DE23056D804ED55() {
  if(!isDefined(level.pers))
    level.pers = [];

  if(!isDefined(level.pers["completed_hills_locs"]))
    level.pers["completed_hills_locs"] = [];
}

_id_60E2E00DE592B581() {
  scripts\engine\utility::flag_init("hills_mi_spawners_initted");
  scripts\engine\utility::flag_init("hills_mi_chopper_spawned");
  scripts\engine\utility::flag_init("hills_important_vo_playing");
  scripts\engine\utility::flag_init("heli_warning_sfx_playing");
  scripts\cp\cp_objectives::registerobjective("support_heli_monument", ::_id_8D2BD4145032E443, ::_id_512836F4D3F40F27, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  scripts\cp\cp_objectives::registerobjective("support_heli_house", ::_id_8D2BD4145032E443, ::_id_543B80FCA12B942A, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  scripts\cp\cp_objectives::registerobjective("support_heli_gasstaation", ::_id_8D2BD4145032E443, ::_id_626D69300C9A8FBD, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  scripts\cp\cp_objectives::registerobjective("support_heli_blueroof", ::_id_8D2BD4145032E443, ::_id_E98937A2FC537170, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  scripts\cp\cp_objectives::registerobjective("support_heli_culdesac", ::_id_8D2BD4145032E443, ::_id_AD23899805261586, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  scripts\cp\cp_objectives::registerobjective("support_heli_escape", ::_id_8D2BD4145032E443, ::_id_8E9912E2ABE8339D, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  scripts\cp\cp_objectives::registerobjective("support_heli_pick_hdd", ::_id_97CCE2A74F852B29, ::_id_6601DE63B0A4E905, ::_id_F04BCA12F2787394, scripts\cp\cp_objectives::debugbeatobjective, ::_id_918A9D6CADD29ABA);
  register_spawners();
  _id_82BB896A0ADA90E7();
}

register_spawners() {
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  _id_18A73A64992DD07D::registerambientgroup("test_jugg", 1, 1, 1, 0.1, undefined, "test_jugg", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("test_jugg", ::_id_1353DAB1701CF43B);
  _id_18A73A64992DD07D::registerambientgroup("ally_ai_1", 2, 2, 2, 0.1, undefined, "ally_ai_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ally_ai_1", ::_id_3C1791B14B77F3A7);
  _id_18A73A64992DD07D::registerambientgroup("ally_ai_2", 2, 2, 2, 0.1, undefined, "ally_ai_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ally_ai_2", ::_id_3C1791B14B77F3A7);
  _id_18A73A64992DD07D::registerambientgroup("hvt_ai", 1, 1, 1, 0.1, undefined, "hvt_ai", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("hvt_ai", ::_id_5EDBA34869898153);
  _id_18A73A64992DD07D::registerambientgroup("hvt_ai_culdesac", 1, 1, 1, 0.1, undefined, "hvt_ai_culdesac", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("hvt_ai_culdesac", ::_id_5EDBA34869898153);
  _id_18A73A64992DD07D::registerambientgroup("ag_parking_lot", 6, 6, 6, 0.1, undefined, "ag_parking_lot", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_parking_lot", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::registerambientgroup("ag_monument_1", 3, 3, 3, randomintrange(3, 5), undefined, "ag_monument_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_monument_2", 3, 3, 3, randomintrange(3, 5), undefined, "ag_monument_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_monument_3", 3, 3, 3, randomintrange(3, 5), undefined, "ag_monument_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_monument_4", 3, 3, 3, randomintrange(3, 5), undefined, "ag_monument_4", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_monument_1", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_monument_2", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_monument_3", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_monument_4", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::registerambientgroup("aa_monument_1", 3, 3, 3, randomintrange(3, 5), undefined, "aa_monument_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_monument_2", 3, 3, 3, randomintrange(3, 5), undefined, "aa_monument_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_monument_3", 3, 3, 3, randomintrange(3, 5), undefined, "aa_monument_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_monument_1", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_monument_2", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_monument_3", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::registerambientgroup("stinger_monument", 1, 1, 1, 0.1, undefined, "stinger_monument", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("stinger_monument", ::_id_50A472A61CAFFD1D);
  _id_18A73A64992DD07D::registerambientgroup("shotgun_house", 3, 3, 3, 0.1, undefined, "shotgun_house", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ar_house", 3, 3, 3, 0.1, undefined, "ar_house", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("sniper_house", 2, 2, 30, 0.1, undefined, "sniper_house", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("shotgun_house", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ar_house", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("sniper_house", ::_id_542192C22B46DD2B);
  level._id_3DDA795142421DB8 = 7;
  _id_18A73A64992DD07D::registerambientgroup("ag_house_1", 3, 3, 3, randomintrange(3, 5), undefined, "ag_house_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_house_2", 3, 3, 3, randomintrange(3, 5), undefined, "ag_house_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_house_3", 3, 3, 3, randomintrange(3, 5), undefined, "ag_house_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_house_1", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_house_2", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_house_3", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::registerambientgroup("aa_house_1", 3, 3, 3, randomintrange(3, 5), undefined, "aa_house_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_house_2", 3, 3, 3, randomintrange(3, 5), undefined, "aa_house_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_house_3", 3, 3, 3, randomintrange(3, 5), undefined, "aa_house_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_house_1", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_house_2", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_house_3", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::registerambientgroup("stinger_house", 1, 1, 1, 0.1, undefined, "stinger_house", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("stinger_house", ::_id_50A472A61CAFFD1D);
  _id_18A73A64992DD07D::registerambientgroup("press_house_1", 2, 2, 2, 0.1, undefined, "press_house_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("press_house_2", 2, 2, 2, 0.1, undefined, "press_house_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("press_house_3", 2, 2, 2, 0.1, undefined, "press_house_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("press_house_4", 2, 2, 2, 0.1, undefined, "press_house_4", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("press_house_5", 2, 2, 2, 0.1, undefined, "press_house_5", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("press_house_6", 2, 2, 2, 0.1, undefined, "press_house_6", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("press_house_1", ::_id_958BC0F5EB3F5FAF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("press_house_2", ::_id_958BC0F5EB3F5FAF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("press_house_3", ::_id_958BC0F5EB3F5FAF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("press_house_4", ::_id_958BC0F5EB3F5FAF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("press_house_5", ::_id_958BC0F5EB3F5FAF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("press_house_6", ::_id_958BC0F5EB3F5FAF);
  _id_18A73A64992DD07D::registerambientgroup("shotgun_gasstation", 3, 3, 3, 0.1, undefined, "shotgun_gasstation", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ar_gasstation", 3, 3, 3, 0.1, undefined, "ar_gasstation", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_gasstation_jugg", 1, 1, 1, 0.1, undefined, "ag_gasstation_jugg", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("shotgun_gasstation", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ar_gasstation", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_gasstation_jugg", ::_id_5B4DC6D24D8303DA);
  level._id_04D2A2B1E0F6E547 = 7;
  _id_18A73A64992DD07D::registerambientgroup("aa_gasstation_roof", 2, 2, 6, 0.1, undefined, "aa_gasstation_roof", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_gasstation_roof", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::registerambientgroup("ag_gasstation_1", 3, 3, 3, randomintrange(3, 5), undefined, "ag_gasstation_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_gasstation_2", 3, 3, 3, randomintrange(3, 5), undefined, "ag_gasstation_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_gasstation_3", 3, 3, 3, randomintrange(3, 5), undefined, "ag_gasstation_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("spec_sh_gasstation", 4, 4, 4, 0.1, undefined, "spec_sh_gasstation", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_gasstation_1", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_gasstation_2", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_gasstation_3", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spec_sh_gasstation", ::_id_6B03C96242BFE9E6);
  _id_18A73A64992DD07D::registerambientgroup("aa_gasstation_1", 3, 3, 3, randomintrange(3, 5), undefined, "aa_gasstation_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_gasstation_2", 3, 3, 3, randomintrange(3, 5), undefined, "aa_gasstation_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_gasstation_3", 3, 3, 3, randomintrange(3, 5), undefined, "aa_gasstation_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_gasstation_1", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_gasstation_2", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_gasstation_3", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::registerambientgroup("stinger_gasstation", 1, 1, 1, 0.1, undefined, "stinger_gasstation", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("stinger_gasstation", ::_id_50A472A61CAFFD1D);
  _id_18A73A64992DD07D::registerambientgroup("ar_blueroof", 3, 3, 3, 0.1, undefined, "ar_blueroof", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("smg_blueroof", 5, 5, 5, 0.1, undefined, "smg_blueroof", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_blueroof_jugg", 1, 1, 1, 0.1, undefined, "ag_blueroof_jugg", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("blueroof_sniper", 1, 1, 1, 0.1, undefined, "blueroof_sniper", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ar_blueroof", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("smg_blueroof", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_blueroof_jugg", ::_id_36B45705AC1B4033);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("blueroof_sniper", ::_id_542192C22B46DD2B);
  level._id_CECEE2C5017E4B24 = 10;
  _id_18A73A64992DD07D::registerambientgroup("ag_blueroof_1", 3, 3, 3, 0.1, undefined, "ag_blueroof_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_blueroof_2", 3, 3, 3, 0.1, undefined, "ag_blueroof_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_blueroof_3", 3, 3, 3, 0.1, undefined, "ag_blueroof_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_blueroof_1", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_blueroof_2", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_blueroof_3", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::registerambientgroup("aa_blueroof_1", 3, 3, 3, randomintrange(3, 5), undefined, "aa_blueroof_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_blueroof_2", 3, 3, 3, randomintrange(3, 5), undefined, "aa_blueroof_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_blueroof_3", 3, 3, 3, randomintrange(3, 5), undefined, "aa_blueroof_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_blueroof_1", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_blueroof_2", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_blueroof_3", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::registerambientgroup("stinger_blueroof", 2, 2, 2, 0.1, undefined, "stinger_blueroof", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("stinger_blueroof", ::_id_7788C7DCDE0FF84D);
  _id_18A73A64992DD07D::registerambientgroup("ar_culdesac", 2, 2, 2, 0.1, undefined, "ar_culdesac", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("smg_culdesac", 2, 2, 2, 0.1, undefined, "smg_culdesac", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("shotgun_culdesac", 2, 2, 2, 0.1, undefined, "shotgun_culdesac", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_culdesac_jugg", 1, 1, 1, 0.1, undefined, "ag_culdesac_jugg", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("spec_sh_culdesac", 1, 1, 1, 0.1, undefined, "spec_sh_culdesac", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ar_culdesac", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("smg_culdesac", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("shotgun_culdesac", ::_id_88D06AF5A580DAAA);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_culdesac_jugg", ::_id_36B45705AC1B4033);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("spec_sh_culdesac", ::_id_6B03C96242BFE9E6);
  level._id_9E3BAEA0EEC22EB6 = 7;
  _id_18A73A64992DD07D::registerambientgroup("shotgun_culdesac_house", 6, 6, 6, 0.1, undefined, "shotgun_culdesac_house", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("shotgun_culdesac_house", ::_id_88D06AF5A580DAAA);
  level._id_540595AE886EF817 = 6;
  _id_18A73A64992DD07D::registerambientgroup("ag_culdesac_1", 3, 3, 3, 0.1, undefined, "ag_culdesac_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_culdesac_2", 3, 3, 3, 0.1, undefined, "ag_culdesac_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_culdesac_3", 3, 3, 3, 0.1, undefined, "ag_culdesac_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_culdesac_1", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_culdesac_2", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_culdesac_3", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::registerambientgroup("aa_culdesac_1", 3, 3, 3, randomintrange(3, 5), undefined, "aa_culdesac_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_culdesac_2", 3, 3, 3, randomintrange(3, 5), undefined, "aa_culdesac_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("aa_culdesac_3", 3, 3, 3, randomintrange(3, 5), undefined, "aa_culdesac_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_culdesac_1", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_culdesac_2", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("aa_culdesac_3", ::_id_EECC5FBD7985FABF);
  _id_18A73A64992DD07D::registerambientgroup("ag_culdesac_window", 4, 4, 4, 0.1, undefined, "ag_culdesac_window", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_culdesac_window", ::_id_542192C22B46DD2B);
  _id_18A73A64992DD07D::registerambientgroup("stinger_culdesac", 1, 1, 1, 0.1, undefined, "stinger_culdesac", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("stinger_culdesac", ::_id_50A472A61CAFFD1D);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_house", 4, 4, 4, 0.1, undefined, "ag_escape_house", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_shack", 4, 4, 4, 0.1, undefined, "ag_escape_shack", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_gasstation", 4, 4, 4, 0.1, undefined, "ag_escape_gasstation", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_gasstation2", 4, 4, 4, 0.1, undefined, "ag_escape_gasstation2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_gasstation3", 4, 4, 4, 0.1, undefined, "ag_escape_gasstation3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_blueroof", 4, 4, 4, 0.1, undefined, "ag_escape_blueroof", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_culdesac1", 4, 4, 4, 0.1, undefined, "ag_escape_culdesac1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_escape_culdesac2", 4, 4, 4, 0.1, undefined, "ag_escape_culdesac2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_house", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_shack", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_gasstation", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_gasstation2", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_gasstation3", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_blueroof", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_culdesac1", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_escape_culdesac2", ::_id_2A570A7AD5DF09F1);
  _id_18A73A64992DD07D::registerambientgroup("stinger_escape", 1, 1, 1, 0.1, undefined, "stinger_escape", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("stinger_escape", ::_id_50A472A61CAFFD1D);
  _id_18A73A64992DD07D::registerambientgroup("ag_exfil_1", 2, 2, 6, 0.1, undefined, "ag_exfil_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_exfil_2", 2, 2, 6, 0.1, undefined, "ag_exfil_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ag_exfil_3", 2, 2, 6, 0.1, undefined, "ag_exfil_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_exfil_1", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_exfil_2", ::_id_BEAB1C0B4C385995);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ag_exfil_3", ::_id_BEAB1C0B4C385995);
  scripts\engine\utility::flag_set("hills_mi_spawners_initted");
}

_id_918A9D6CADD29ABA(objectivestruct) {}

_id_97CCE2A74F852B29(objectivestruct) {
  if(!isDefined(level._id_0C88221310333A95))
    level._id_0C88221310333A95 = "support_heli_gasstaation";
}

_id_6601DE63B0A4E905(objectivestruct) {
  switch (level._id_0C88221310333A95) {
    case "support_heli_gasstaation":
    default:
      scripts\engine\utility::flag_wait("house_interaction_destroyed");
      scripts\engine\utility::flag_wait("support_heli_house_hard_drive_picked");
      break;
    case "support_heli_culdesac":
      scripts\engine\utility::flag_wait("gasstation_interaction_destroyed");
      scripts\engine\utility::flag_wait("support_heli_gasstaation_hard_drive_picked");
      break;
    case "support_heli_escape":
      scripts\engine\utility::flag_wait("culdesac_interaction_destroyed");
      scripts\engine\utility::flag_wait("support_heli_culdesac_hard_drive_picked");
      break;
  }

  scripts\cp\cp_objectives::overridenextstep(objectivestruct, level._id_0C88221310333A95);
}

_id_F04BCA12F2787394(objectivestruct) {}

_id_8D2BD4145032E443(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_heli_escort_cs_completed");
  init_anims();
  _id_F92C48D736AA932C();
  _id_6161095BB24A892E();
  _id_9B2F0ED66B9CE35B();
  _id_E85B12D9DA5F8AB9();
  thread _id_4EC859E05D4290A7::_id_2519699D1F9A2D5C();
  level thread _id_B8265CBEF2F13D0D();
  level thread _id_47C5066A988D488A();
  level.removeselfrevivetoken = _id_66122A002AFF5D57::removeselfrevivetoken;
  level.coop_gameshouldendfunc = ::_id_22304B4B146CEB88;
  level._id_313F285051FA8329 = ::_id_22304B4B146CEB88;
  thread _id_07005281D71CEF20();

  if(getdvarint("dvar_A00069D260E69DCA", 0) > 0)
    level thread _id_2BA0DDB95F1DD77F();

  if(!istrue(level._id_A99B452AFA0C3AFB)) {
    level thread _id_18A73A64992DD07D::run_spawn_module("ally_ai_1");
    level thread _id_18A73A64992DD07D::run_spawn_module("ally_ai_2");
    level._id_A99B452AFA0C3AFB = 1;
  }

  thread _id_D7963AF7F592B7D8();
}

_id_441C6F583339AA06(objectivestruct) {
  level notify("heli_escort_objective_completed");
}

_id_0E4B94B2BC844AF8() {
  level endon("game_ended");
  _id_5BDA656DA672EFC3 = scripts\engine\utility::getStruct("hills_spawn_doors", "script_noteworthy").origin;
  level thread _id_57FBAB87F76E9490(_id_5BDA656DA672EFC3, "spawn_door_opened");
  level scripts\engine\utility::waittill_any_timeout_1(30, "spawn_door_opened");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_breaker1birdsarespun");
  wait 1.5;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_onefromthebreakerele");
  wait 2;

  switch (randomint(2)) {
    case 0:
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_groundoperatorgrabso");
      wait 1;
      break;
    case 1:
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_gunupandpickyourbird");
      wait 1.5;
      break;
  }

  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_pickyourpositionlets");
  level thread _id_52211FB5ABE7C4F1();
}

_id_52211FB5ABE7C4F1() {
  level endon("game_ended");
  level endon("all_players_picked_role");

  for(;;) {
    wait 90;

    switch (randomint(7)) {
      case 0:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_letsgowewanttoputaqt");
        break;
      case 1:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_getmoving");
        break;
      case 2:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_breakerfuseislitwene");
        break;
      case 3:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_letsgettowork");
        break;
      case 4:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_waitingonyoubreaker");
        break;
      case 5:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_letsgetmoving");
        break;
      case 6:
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_wereburningdaylight");
        break;
    }
  }
}

_id_2E591248368E725F(objectivestruct, _id_69AD95373289772A, _id_80774CCBD488F5FA) {
  if(istrue(level._id_9C0DB50383D9641A)) {
    return;
  }
  wait 2;
  objective_setdescription(objectivestruct.objectiveindex, &"CP_HILLS_MI/PICKROLE");
  objective_setlabel(objectivestruct.objectiveindex, &"CP_HILLS_MI/PICKROLE");
  objective_state(objectivestruct.objectiveindex, "active");
  objective_removeallfrommask(objectivestruct.objectiveindex);
  waitframe();
  level thread scripts\cp\utility::objective_update(objectivestruct.objname);
  level waittill("all_players_picked_role");
  objective_setdescription(objectivestruct.objectiveindex, _id_69AD95373289772A);
  objective_state(objectivestruct.objectiveindex, "current");
  waitframe();
  objective_setlabel(objectivestruct.objectiveindex, _id_80774CCBD488F5FA);
  objective_addalltomask(objectivestruct.objectiveindex);
}

_id_512836F4D3F40F27(objectivestruct) {
  level thread _id_2E591248368E725F(objectivestruct, &"CP_HILLS_MI/OBJ_INVESTIGATE", &"CP_HILLS_MI/MONUMENT_LABEL");
  level._id_E2FBFF9958341586 = scripts\engine\utility::getStruct("ground_player_infil", "script_noteworthy");
  level thread _id_0E4B94B2BC844AF8();
  level._id_AC4465139E7E9D5B = scripts\engine\utility::getStruct("house_entrance", "script_noteworthy");
  level thread _id_D5C017DF6CFE21D3("at_mine_parking");
  level thread _id_5B0C9451DDD7B1F0();
  _id_9CC01621526E88EE();
  _id_0C134816A7914E32();
  _id_75DAA35A5A19AA29();
  thread _id_BA7657AFDB1EC2A4();
  level thread _id_53D271EE4AC10F0C(objectivestruct);
  thread _id_EFBF8FB765ED650E();
  level.localeid = "locale_heli_escort_2";
  scripts\cp\compass::setupminimap("compass_map_cp_heli_escort_2", 2, 1);
  level._id_FF77C4774821472C = 32 - _id_D43578C37AA09B2D() - 6;

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0)
    level thread _id_18A73A64992DD07D::run_spawn_module("ag_parking_lot");

  level thread _id_D5C017DF6CFE21D3("at_mine_house");
  _id_5B64F4E84DCCCEE0(level._id_AC4465139E7E9D5B.origin, level._id_AC4465139E7E9D5B.radius * 2);
  level._id_FF77C4774821472C = 24;
  level thread _id_35954B3FB5848A5F(1, 0);
  _id_85B8CF0A73E3D246 = scripts\engine\utility::getStruct("house_entrance", "script_noteworthy");
  _id_5B64F4E84DCCCEE0(_id_85B8CF0A73E3D246.origin, level._id_AC4465139E7E9D5B.radius);
  wait 2;
  level.pers["completed_hills_locs"][level.pers["completed_hills_locs"].size] = "support_heli_monument";
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "support_heli_house");
}

_id_543B80FCA12B942A(objectivestruct) {
  level._id_E2FBFF9958341586 = scripts\engine\utility::getStruct("hills_mi_infil_house", "script_noteworthy");
  level._id_AC4465139E7E9D5B = scripts\engine\utility::getStruct("hills_mi_combat_2", "script_noteworthy");
  _id_0C134816A7914E32();
  level thread _id_2E591248368E725F(objectivestruct, &"CP_HILLS_MI/OBJ_INVESTIGATE", &"CP_HILLS_MI/HOUSE_LABEL");

  if(getdvarint("dvar_66536FC4979E735B", 0) > 0)
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_house");

  level thread _id_B708B4E0781BCB90("house");
  _id_C4EA99FA46D27C12 = scripts\engine\utility::getStructArray("claymore_house", "targetname");

  foreach(_id_656F0AE440B1B5D5 in _id_C4EA99FA46D27C12)
  _id_656F0AE440B1B5D5 thread spawn_enemy_claymore(_id_656F0AE440B1B5D5.origin, _id_656F0AE440B1B5D5.angles, 1);

  thread _id_BA7657AFDB1EC2A4();
  thread _id_F8ABF4009B0AA09D(objectivestruct);
  thread _id_E9D36332D52EF533();
  thread _id_67D6E657AF747C32(level._id_AC4465139E7E9D5B);
  _id_AFB66CC0A91D217C();
  thread _id_E1A386425D65056D("support_heli_house");
  objective_addalltomask(objectivestruct.objectiveindex);
  objective_hidefromplayersinmask(objectivestruct.objectiveindex);
  level thread _id_9DB1BE0244D95316();
  level._id_FF77C4774821472C = 32 - _id_D43578C37AA09B2D() - level._id_3DDA795142421DB8;
  _id_5B64F4E84DCCCEE0(level._id_AC4465139E7E9D5B.origin, level._id_AC4465139E7E9D5B.radius);
  level thread _id_35954B3FB5848A5F(2, 0);
  level thread _id_18A73A64992DD07D::stop_module_by_groupname("sniper_house", 0);
  waitframe();
  scripts\engine\utility::flag_wait("house_interaction_destroyed");
  level _id_F7E5243052A70491();
  level notify("stop_chopper_nags");
  level._id_0C88221310333A95 = "support_heli_gasstaation";
  level thread _id_D5C017DF6CFE21D3("at_mine_gasstation");
  wait 2;
  level.pers["completed_hills_locs"][level.pers["completed_hills_locs"].size] = "support_heli_house";
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "support_heli_pick_hdd");
}

_id_626D69300C9A8FBD(objectivestruct) {
  level._id_E2FBFF9958341586 = scripts\engine\utility::getStruct("hills_mi_infil_gasstation", "script_noteworthy");
  level thread _id_B708B4E0781BCB90("gasstation");
  level._id_AC4465139E7E9D5B = scripts\engine\utility::getStruct("hills_mi_combat_3", "script_noteworthy");
  _id_0C134816A7914E32();
  thread _id_361BA19B9A3883AE(objectivestruct);
  level thread _id_2E591248368E725F(objectivestruct, &"CP_HILLS_MI/LOCATE_HVT", &"CP_HILLS_MI/GASSTATION_LABEL");
  objective_setlabel(objectivestruct.objectiveindex, &"CP_HILLS_MI/DESTROY_SERVER");

  if(getdvarint("dvar_66536FC4979E735B", 0) > 0)
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_gasstation");

  level._id_FF77C4774821472C = 32 - _id_D43578C37AA09B2D() - level._id_04D2A2B1E0F6E547;
  objective_addalltomask(objectivestruct.objectiveindex);
  objective_hidefromplayersinmask(objectivestruct.objectiveindex);
  level thread _id_E1A386425D65056D("support_heli_gasstaation");
  thread _id_67D6E657AF747C32(level._id_AC4465139E7E9D5B);
  level thread _id_BA7657AFDB1EC2A4();
  level thread _id_5AA35CEA1874FE3A(2);

  if(!scripts\engine\utility::flag("gasstation_interaction_destroyed")) {
    thread scripts\cp\utility::objective_update("support_heli_gasstaation", undefined, undefined, undefined, undefined, 3);
    _id_5B64F4E84DCCCEE0(level._id_AC4465139E7E9D5B.origin, 2048);
  }

  level thread _id_AA088B7CAD597211();
  _id_AFB66CC0A91D217C();
  waitframe();
  scripts\engine\utility::flag_wait("gasstation_interaction_destroyed");
  level notify("stop_chopper_nags");
  level._id_0C88221310333A95 = "support_heli_culdesac";
  wait 1;
  thread _id_5AA35CEA1874FE3A(4);
  level.pers["completed_hills_locs"][level.pers["completed_hills_locs"].size] = "support_heli_gasstation";
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "support_heli_pick_hdd");
}

_id_E98937A2FC537170(objectivestruct) {
  level thread _id_2E591248368E725F(objectivestruct, &"CP_HILLS_MI/LOCATE_HVT", &"CP_HILLS_MI/BLUEROOF_LABEL");

  if(getdvarint("dvar_66536FC4979E735B", 0) > 0)
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_blueroof");

  objective_setlabel(objectivestruct.objectiveindex, &"CP_HILLS_MI/DESTROY_SERVER");
  level._id_E2FBFF9958341586 = scripts\engine\utility::getStruct("hills_mi_infil_blueroof", "script_noteworthy");
  level thread _id_B708B4E0781BCB90("blueroof");
  level._id_AC4465139E7E9D5B = scripts\engine\utility::getStruct("hills_mi_combat_4", "script_noteworthy");
  level._id_FF77C4774821472C = 32 - _id_D43578C37AA09B2D() - level._id_CECEE2C5017E4B24;
  thread _id_67D6E657AF747C32(level._id_AC4465139E7E9D5B);

  if(getdvarint("dvar_C83A0E74E5726CA9", 0) > 0) {
    level thread _id_18A73A64992DD07D::run_spawn_module("hvt_ai");
    scripts\cp\cp_objectives::overridenextstep(objectivestruct, "support_heli_escape");
  }

  _id_5B64F4E84DCCCEE0(level._id_AC4465139E7E9D5B.origin, 2048);
  _id_AFB66CC0A91D217C();
  objective_addalltomask(objectivestruct.objectiveindex);
  objective_hidefromplayersinmask(objectivestruct.objectiveindex);

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0) {
    level thread _id_18A73A64992DD07D::run_spawn_module("smg_blueroof");
    level thread _id_18A73A64992DD07D::run_spawn_module("ar_blueroof");
    level thread _id_18A73A64992DD07D::run_spawn_module("blueroof_sniper");
    level thread _id_18A73A64992DD07D::run_spawn_module("spec_sh_culdesac");
  }

  level thread _id_35954B3FB5848A5F(4, 0);
  waitframe();
  scripts\engine\utility::flag_wait("blueroof_interaction_destroyed");
  wait 1;
  level.pers["completed_hills_locs"][level.pers["completed_hills_locs"].size] = "support_heli_blueroof";
}

_id_B37F99F67C193570(objective) {
  if(!isDefined(level.pers) || !isDefined(level.pers["completed_hills_locs"]))
    return 0;

  return scripts\engine\utility::array_contains(level.pers["completed_hills_locs"], objective);
}

_id_AD23899805261586(objectivestruct) {
  level._id_E2FBFF9958341586 = scripts\engine\utility::getStruct("hills_mi_infil_culdesac", "script_noteworthy");
  level._id_AC4465139E7E9D5B = scripts\engine\utility::getStruct("hills_mi_combat_5", "script_noteworthy");
  _id_0C134816A7914E32();
  thread _id_21895A7CFC184BB7(objectivestruct);
  level thread _id_2E591248368E725F(objectivestruct, &"CP_HILLS_MI/RESCUE_HVT", &"CP_HILLS_MI/RESCUE_HVT");

  if(getdvarint("dvar_66536FC4979E735B", 0) > 0)
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_culdesac");

  level thread _id_B708B4E0781BCB90("culdesac");
  level _id_F7E5243052A70491();
  level thread _id_D5C017DF6CFE21D3("at_mine_culdesac");
  thread _id_BA7657AFDB1EC2A4();
  objective_addalltomask(objectivestruct.objectiveindex);
  objective_hidefromplayersinmask(objectivestruct.objectiveindex);
  thread _id_5AA35CEA1874FE3A(4);
  thread _id_E1A386425D65056D("support_heli_culdesac");
  thread _id_67D6E657AF747C32(level._id_AC4465139E7E9D5B);
  level._id_FF77C4774821472C = 32 - _id_D43578C37AA09B2D() - level._id_9E3BAEA0EEC22EB6 - level._id_540595AE886EF817 - 1;

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0)
    level thread _id_18A73A64992DD07D::run_spawn_module("stinger_blueroof");

  if(!scripts\engine\utility::flag("culdesac_interaction_destroyed")) {
    thread scripts\cp\utility::objective_update("support_heli_culdesac", undefined, undefined, undefined, undefined, 3);
    _id_5B64F4E84DCCCEE0(level._id_AC4465139E7E9D5B.origin, 2048);
  }

  _id_AFB66CC0A91D217C();

  if(!scripts\engine\utility::flag("culdesac_interaction_destroyed"))
    _id_5B64F4E84DCCCEE0(level._id_AC4465139E7E9D5B.origin, 512);

  level thread _id_35954B3FB5848A5F(5, 0);
  scripts\engine\utility::flag_wait("culdesac_interaction_destroyed");
  level._id_0C88221310333A95 = "support_heli_escape";
  level notify("send_indoor_ai_after_player");
  level notify("all_servers_destroyed");
  level notify("stop_chopper_nags");
  wait 2;
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "support_heli_pick_hdd");
}

_id_8E9912E2ABE8339D(objectivestruct) {
  thread _id_A502C592DCA776EF();
  level._id_E2FBFF9958341586 = scripts\engine\utility::getStruct("hills_mi_infil_escape", "script_noteworthy");
  level notify("delete_global_obj_markers");
  _id_41B23883728EA863 = scripts\engine\utility::getStruct("hills_mi_exfil", "script_noteworthy");
  level._id_AC4465139E7E9D5B = _id_41B23883728EA863;
  level._id_FF77C4774821472C = 32 - _id_D43578C37AA09B2D() - 1;
  thread _id_C0D3489313822760();
  thread _id_BBDFA6036B25F26E(objectivestruct);
  thread _id_7A8A735C6D595E72(20);

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0) {
    level thread _id_18A73A64992DD07D::run_spawn_module("aa_gasstation_roof");
    level thread _id_18A73A64992DD07D::run_spawn_module("smg_blueroof");
    level thread _id_18A73A64992DD07D::run_spawn_module("blueroof_sniper");
    level thread _id_18A73A64992DD07D::run_spawn_module("spec_sh_culdesac");
  }

  _id_5B64F4E84DCCCEE0(_id_41B23883728EA863.origin, 1536);

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0) {
    level thread _id_18A73A64992DD07D::run_spawn_module("ag_exfil_1");
    level thread _id_18A73A64992DD07D::run_spawn_module("ag_exfil_2");
    level thread _id_18A73A64992DD07D::run_spawn_module("ag_exfil_3");
  }

  level waittill("players_onboard_exfil");
  level notify("stop_watching_chopper_lifecycle");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("support_heli_escape");
  _id_450F1EB13B0AC99F();
  thread _id_0FB467EB4C40D080();
  level scripts\engine\utility::waittill_any_timeout_1(15, "outro_vo_done");

  foreach(player in level.players)
  level thread endgame_camera(player);

  wait 5;
  level._id_9D709E54566707E6 clearsoundsubmix("iw9_cp_escort_heli_exfil", 2);

  foreach(player in level.players)
  player scripts\cp\utility::_id_4CBAED764C116A25(0);

  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

endgame_camera(player) {
  level endon("game_ended");
  wait 2;

  if(!isDefined(player) && !_id_7E031905C49F9B9A()) {
    return;
  }
  if(!isDefined(player))
    player = level._id_9D709E54566707E6;

  player.invulnerable = 1;
  player allowmovement(0);
  _id_693EC2852A7DE810 = scripts\engine\utility::getStruct("heli_end_cam", "script_noteworthy");
  pos = _id_693EC2852A7DE810.origin;
  _id_E50DC87B2DB8A9A0 = scripts\engine\utility::getStruct(_id_693EC2852A7DE810.target, "targetname");
  cam = spawn("script_model", pos);
  cam setModel("tag_origin");
  cam.angles = _id_693EC2852A7DE810.angles;
  cam moveTo(_id_E50DC87B2DB8A9A0.origin, 20, 1, 1);
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player allowfire(0);
  player disableoffhandweapons();
  player disableusability();
  player allowmovement(0);
  player setclientomnvar("ui_hide_hud", 1);
  player spawn_endgame_camera(cam);
  player lerpfovscalefactor(0, 0);
}

spawn_endgame_camera(_id_5940F376A254619D) {
  self.ignoreme = 1;
  self cameralinkTo(_id_5940F376A254619D, "tag_origin", 1);
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("cg_fov", "50");
}

_id_C0D3489313822760() {
  level endon("game_ended");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_greatworkbreakersall");
  wait 2.3;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_11banshee64isinbound");
  wait 1.5;
}

_id_3AE59BC200D98AE9() {
  level endon("game_ended");
  level endon("mid_objectives_finished");
  _id_B57027B4C54614AF = scripts\engine\utility::getStruct("hills_mi_combat_3", "script_noteworthy");
  _id_B57028B4C54616E2 = scripts\engine\utility::getStruct("hills_mi_combat_4", "script_noteworthy");
  _id_D86D8D2B9DF959EB = [_id_B57027B4C54614AF, _id_B57028B4C54616E2];
  level._id_AC4465139E7E9D5B = _id_B57027B4C54614AF;

  for(;;) {
    if(!_id_7E031905C49F9B9A()) {
      wait 3;
      continue;
    }

    level._id_AC4465139E7E9D5B = scripts\engine\utility::getclosest(level._id_9D709E54566707E6.origin, _id_D86D8D2B9DF959EB);
    wait 3;
  }
}

_id_D1B2B63DBDA4BCA1() {
  level endon("game_ended");

  if(!isDefined(level.pers))
    level.pers = [];

  if(!isDefined(level.pers["completed_hills_locs"]))
    level.pers["completed_hills_locs"] = [];

  while(!_id_B37F99F67C193570("support_heli_gasstation") || !_id_B37F99F67C193570("support_heli_blueroof"))
    wait 2;

  level notify("mid_objectives_finished");
  level thread scripts\cp\cp_objectives::run_objective("support_heli_culdesac");
}

_id_2CF6F61C1345468C() {
  while(!_id_7E031905C49F9B9A())
    wait 1;

  level thread _id_35954B3FB5848A5F(1);
  level thread _id_35954B3FB5848A5F(2);
  level thread _id_35954B3FB5848A5F(3);
  level thread _id_35954B3FB5848A5F(4);
  level thread _id_35954B3FB5848A5F(5);
  level waittill("forever");
}

_id_663C1EAFCB1374D8(timer) {
  level endon("game_ended");
  starttime = gettime();
  endtime = timer * 1000 + starttime;

  while(!isDefined(level._id_DA40E412E6C89D67) && gettime() <= endtime)
    wait 1;

  if(isDefined(level._id_DA40E412E6C89D67)) {
    return;
  }
  level notify("hvt_spawn_timeout");
}

_id_47C5066A988D488A() {
  if(istrue(level._id_4E9C5B04E41B674B)) {
    return;
  }
  level._id_4E9C5B04E41B674B = 1;
  _id_94F161FAA5D2738E = scripts\engine\utility::getStruct("hills_mi_combat_2", "script_noteworthy");
  _id_45018DFC826EDEB8 = ["sniper_house", "ar_house", "shotgun_house"];
  _id_7FF26A6518C3661F = scripts\engine\utility::getStruct("hills_mi_combat_3", "script_noteworthy");
  _id_FEA35FF29C2AE435 = 2048;
  _id_CFCF7026E3202027 = ["shotgun_gasstation", "ar_gasstation", "ag_gasstation_jugg"];
  _id_4BB5FD1819BD9310 = scripts\engine\utility::getStruct("hills_mi_combat_5", "script_noteworthy");
  _id_D10DDFDD2A83FF0C = 2048;
  _id_95B7A0130214B966 = ["ag_culdesac_jugg", "smg_culdesac", "ar_culdesac", "shotgun_culdesac", "ag_culdesac_window", "shotgun_culdesac_house"];
  level thread _id_80132CBD3C2EC46E(_id_45018DFC826EDEB8, _id_94F161FAA5D2738E.origin, _id_94F161FAA5D2738E.radius);
  level thread _id_80132CBD3C2EC46E(_id_CFCF7026E3202027, _id_7FF26A6518C3661F.origin, _id_FEA35FF29C2AE435);
  level thread _id_80132CBD3C2EC46E(_id_95B7A0130214B966, _id_4BB5FD1819BD9310.origin, _id_D10DDFDD2A83FF0C);
}

_id_80132CBD3C2EC46E(_id_30AB2A49CCE8FB24, _id_AD5215ABE61B9858, radius) {
  level endon("game_ended");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_5B64F4E84DCCCEE0(_id_AD5215ABE61B9858, radius);

  foreach(group in _id_30AB2A49CCE8FB24) {
    level thread _id_18A73A64992DD07D::run_spawn_module(group);
    waitframe();
  }
}

_id_FF14F911E0F0EE69(spawners, _id_1A96C2062BB2E695) {
  level endon("game_ended");
  _id_5E51BFA96973932E = scripts\engine\utility::getStruct(_id_1A96C2062BB2E695, "script_noteworthy");
  dist = _id_5E51BFA96973932E.radius;

  for(;;) {
    if(!_id_7E031905C49F9B9A()) {
      wait 1;
      continue;
    }

    if(distance(level._id_9D709E54566707E6.origin, _id_5E51BFA96973932E.origin) <= dist) {
      break;
    } else
      wait 0.5;
  }

  foreach(_id_D5BF29E2E84970D6 in spawners)
  _id_18A73A64992DD07D::stop_module_by_id(_id_D5BF29E2E84970D6);
}

_id_542192C22B46DD2B(group) {
  waitframe();
  self.fnsetlaserflag = ::_id_EBE9B8368F0502A9;
  self.fnlaseron = ::_id_EBE9B8368F0502A9;
  self.fnlaseroff = ::_id_EBE9B8368F0502A9;
  self.goalradius = 64;
  glintfx = playFXOnTag(level._effect["sniper_glint"], self, "tag_origin");
  thread _id_B3E2F584D25C166A();
}

_id_EBE9B8368F0502A9(_id_CD086B02AD73FAB3) {
  return undefined;
}

_id_B3E2F584D25C166A() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(_id_7E031905C49F9B9A())
      self.favoriteenemy = level._id_9D709E54566707E6;

    wait 5;
  }
}

_id_1353DAB1701CF43B(group) {
  _id_E21279FA90BDF012 = self;
  _id_E21279FA90BDF012._id_BC1CA118EA17B3E6 = 1;
  _id_E21279FA90BDF012._id_61BFAFE53CF69323 = 1;
  thread _id_F6D9CD43D601FFAE(self);
}

_id_F6D9CD43D601FFAE(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 endon("death");
  door = scripts\engine\utility::getStruct("jugg_door", "script_noteworthy");
  _id_E21279FA90BDF012.animationarchetype = "juggernaut";
  _id_E21279FA90BDF012 forceteleport(door.origin, door.angles);
  _id_E21279FA90BDF012 scripts\asm\asm_bb::bb_setanimScripted();
  _id_E21279FA90BDF012 asmsetstate(_id_E21279FA90BDF012.asmname, "animscripted");
  animindex = _id_E21279FA90BDF012 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "jug_com_door_kick");
  xanim = _id_E21279FA90BDF012 scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_E21279FA90BDF012 dontinterpolate();
  level thread _id_5B64F4E84DCCCEE0(door.origin, door.radius, 0, "player_got_close_to_jugg", "jugg_door_is_open");
  level thread _id_57FBAB87F76E9490(door.origin, "jugg_door_is_open", "player_got_close_to_jugg");
  result = level scripts\engine\utility::waittill_any_return_2("jugg_door_is_open", "player_got_close_to_jugg");
  _id_887438C3B4B194B6(0, self.origin);
  _id_E21279FA90BDF012 aisetanim("animscripted", animindex);
  _id_E21279FA90BDF012 animmode("noclip");
  _id_228C1F2F3A2D92F1 = getanimlength(xanim);
  setmusicstate("cp_juggernaut_intro");
  wait(_id_228C1F2F3A2D92F1);
  _id_E21279FA90BDF012 scripts\asm\asm_bb::bb_clearanimScripted();
  setDvar("dvar_4A4DE8B30C5647A8", 0);
  self.goalradius = 2048;
  self._id_9FF99CFC426066A2 = 2048;
  self.dont_enter_combat = 0;
  self.combatmode = "no_cover";
  _id_9743A24AC8368484 = 200;
  self aisetdesiredspeed(_id_9743A24AC8368484);
  self aisettargetspeed(_id_9743A24AC8368484);
  self._id_BC1CA118EA17B3E6 = undefined;
  self.invulnerable = undefined;
  self._id_61BFAFE53CF69323 = 0;

  if(_id_7E031905C49F9B9A()) {
    self setgoalentity(level._id_9D709E54566707E6);
    self.favoriteenemy = level._id_9D709E54566707E6;
    level thread _id_8A44D01BF16E6658(self);
  }
}

_id_57FBAB87F76E9490(pos, _id_2BA11638E3591901, _id_0DF2F39AFAB3B8B9) {
  level endon("game_ended");

  if(isDefined(_id_0DF2F39AFAB3B8B9))
    level endon(_id_0DF2F39AFAB3B8B9);

  _id_AE81DA3A693567A3 = 1;

  while(istrue(_id_AE81DA3A693567A3)) {
    _id_AE81DA3A693567A3 = _id_B8BFBBE166658FFF(pos);
    wait 0.3;
  }

  level notify(_id_2BA11638E3591901);
}

_id_8A44D01BF16E6658(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 endon("death");

  if(!_id_7E031905C49F9B9A()) {
    return;
  }
  wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_CAFA7AD7442C35D5"));
  wait 3;
  wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_8EF3DF121EB09344"));
  wait 3;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shmk_lasw_11drawhimouttothecou");
  wait 2;
  thread _id_3EA57D9EC47227A5(_id_E21279FA90BDF012);
  nags = ["dx_cp_cpes_shmk_lasw_youvegotairsupportus", "dx_cp_cpes_shmk_lasw_getthejuggoutsidethi", "dx_cp_cpes_shmk_lasw_useyourairsupportwor", "dx_cp_cpes_shmk_lasw_youvegotanadvantagew", "dx_cp_cpes_shmk_lasw_feedhimtoyourairsupp", "dx_cp_cpes_shmk_lasw_11lurethatbigboyoutf"];

  for(;;) {
    wait 15;
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(nags));
  }
}

_id_AB7B28E3AD7AF2FD(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 endon("death");

  if(!_id_7E031905C49F9B9A()) {
    return;
  }
  player = level._id_9D709E54566707E6;
  player endon("death");
  player endon("disconnect");

  while(!_id_E21279FA90BDF012 cansee(level._id_9D709E54566707E6))
    wait 0.5;

  wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_CAFA7AD7442C35D5"));
  wait 3;
  wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_8EF3DF121EB09344"));
  wait 4;
  lines = ["dx_cp_cpes_shcp_lasw_breakersyouknowwhatt", "dx_cp_cpes_shcp_lasw_11youknowthedrillrun"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
  wait 1.5;
  thread _id_F126AC14CBE8CE06(_id_E21279FA90BDF012);
}

_id_F126AC14CBE8CE06(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 waittill("death");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_thatshowyougetitdone");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_nowsecurethatharddri");
}

_id_3EA57D9EC47227A5(_id_E21279FA90BDF012) {
  level endon("game_ended");

  while(isalive(_id_E21279FA90BDF012)) {
    _id_E21279FA90BDF012 waittill("damage", damage, attacker);

    if(damage < _id_E21279FA90BDF012.health) {
      continue;
    }
    if(_id_7E031905C49F9B9A() && attacker == level._id_9D709E54566707E6) {
      lines = ["dx_cp_cpes_shmk_lasw_thatwouldvebeeneasie", "dx_cp_cpes_shmk_lasw_airsupportistheretoh"];
      continue;
    }

    if(_id_FB6190FCD263559D()) {
      wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_3A0F5BB16DF88C43"));
      wait 4;
      _id_2E7DA0E187D54C04 = ["dx_cp_cpes_shmk_hlp1_affirmativeoneextinc", "dx_cp_cpes_shmk_hlp1_thosefuckersneedkill", "dx_cp_cpes_shmk_hlp1_highestoffives11jugg"];
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_2E7DA0E187D54C04));
      lines = ["dx_cp_cpes_shmk_lasw_successissweeterwhen", "dx_cp_cpes_shmk_lasw_letsgetbacktobusines"];
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
    }
  }
}

_id_5B4DC6D24D8303DA(group) {
  self.goalradius = 30;
  self._id_9FF99CFC426066A2 = 30;
  self.goalheight = 1024;
  self.dont_enter_combat = 1;
  self._id_BC1CA118EA17B3E6 = 1;
  self._id_61BFAFE53CF69323 = 1;
  self.invulnerable = 1;
  thread _id_887438C3B4B194B6(1, self.origin);
  thread _id_F6D9CD43D601FFAE(self);
}

_id_36B45705AC1B4033(group) {
  self.goalradius = 30;
  self._id_9FF99CFC426066A2 = 30;
  self.goalheight = 1024;
  self.dont_enter_combat = 1;
  thread _id_9649CDFB6408E759(self);
  thread _id_78942AAFDAA59637(2048);
  thread _id_5C4325F409A1BA2C(2048);
  thread _id_D222D2C21D944D83(group);
  thread _id_40C8EFB6F8ED06DF();
}

_id_9649CDFB6408E759(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 endon("death");
  _id_E21279FA90BDF012._id_C833409FB72D15FB = 1;
  _id_5B64F4E84DCCCEE0(_id_E21279FA90BDF012.origin, 512, 1);
  _id_E21279FA90BDF012._id_C833409FB72D15FB = 0;
  _id_9743A24AC8368484 = 200;
  _id_E21279FA90BDF012 aisetdesiredspeed(_id_9743A24AC8368484);
  _id_E21279FA90BDF012 aisettargetspeed(_id_9743A24AC8368484);

  if(_id_7E031905C49F9B9A()) {
    _id_E21279FA90BDF012 setgoalentity(level._id_9D709E54566707E6);
    _id_E21279FA90BDF012.favoriteenemy = level._id_9D709E54566707E6;
    level thread _id_8A44D01BF16E6658(_id_E21279FA90BDF012);
  }
}

_id_B8BFBBE166658FFF(pos) {
  _id_4F6FF34F222B0271 = getentitylessscriptablearray("scriptable_scriptable_door_wooden_panel_03_painted_mp", "classname", pos, 64);
  _id_4F6FF04F222AFBD8 = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_orange_double_l", "classname", pos, 64);
  _id_4F6FF14F222AFE0B = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_orange_double_r", "classname", pos, 64);
  _id_4F6FF64F222B090A = getentitylessscriptablearray("scriptable_scriptable_door_metal_04_flat_painted_clean_mp", "classname", pos, 64);
  _id_4F6FF74F222B0B3D = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_blue_double_l", "classname", pos, 64);
  _id_4F6FF44F222B04A4 = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_blue_double_r", "classname", pos, 64);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF14F222AFE0B);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF64F222B090A);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF74F222B0B3D);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF44F222B04A4);
  door = scripts\engine\utility::getclosest(pos, _id_786FD7C325A6D910);

  if(!isDefined(door))
    return 0;

  return door scriptabledoorisclosed();
}

_id_887438C3B4B194B6(closed, pos) {
  _id_4F6FF34F222B0271 = getentitylessscriptablearray("scriptable_scriptable_door_wooden_panel_03_painted_mp", "classname", pos, 64);
  _id_4F6FF04F222AFBD8 = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_orange_double_l", "classname", pos, 64);
  _id_4F6FF14F222AFE0B = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_orange_double_r", "classname", pos, 64);
  _id_4F6FF64F222B090A = getentitylessscriptablearray("scriptable_scriptable_door_metal_04_flat_painted_clean_mp", "classname", pos, 64);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF14F222AFE0B);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF64F222B090A);

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor()) {
      if(closed) {
        timeout = 0;
        _id_26BAEFB3804B52C3 scriptabledoorclose();

        while(!_id_26BAEFB3804B52C3 scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
        continue;
      }

      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);
      _id_26BAEFB3804B52C3 scriptabledooropen("away", pos);
    }
  }
}

_id_40C8EFB6F8ED06DF() {
  level endon("game_ended");
  self endon("death");
  self waittill("alerted_to_player");

  if(_id_7E031905C49F9B9A())
    self setgoalentity(level._id_9D709E54566707E6);

  thread _id_AB7B28E3AD7AF2FD(self);
}

_id_1DF9FA439B91758F(_id_ACF2963740B6F292, prevweapon) {
  self setweaponammoclip(_id_ACF2963740B6F292, 50);
  self setweaponammostock(_id_ACF2963740B6F292, 50);
}

_id_D222D2C21D944D83(group) {
  level endon("game_ended");
  self waittill("death");
  level notify(group.group_name + "_killed");
}

_id_C5BA38706C958334(ai, _id_DFF8B1B70D60C493) {
  level endon("game_ended");
  ai endon("death");

  if(!isai(ai) || !isDefined(ai.spawner)) {
    return;
  }
  wait 10;
  _id_E68561DC8EFB467C = 80;

  if(!isDefined(level._id_FC669BBECA6D3A7D))
    level._id_FC669BBECA6D3A7D = gettime();

  _id_838DCE3ED0A1A11C = "spawning_vo_marker";

  if(istrue(_id_DFF8B1B70D60C493))
    _id_838DCE3ED0A1A11C = "spawning_vo_marker_aa";

  _id_8A52520CE1A05C16 = getaiarray("axis").size;
  _id_B265C489291659AB = scripts\engine\utility::getStructArray(_id_838DCE3ED0A1A11C, "targetname");

  if(gettime() - level._id_FC669BBECA6D3A7D <= _id_E68561DC8EFB467C * 1000 || _id_8A52520CE1A05C16 <= 6 || _id_B265C489291659AB.size <= 0) {
    return;
  }
  level._id_FC669BBECA6D3A7D = gettime();
  _id_88318301272D82DA = scripts\engine\utility::getclosest(ai.spawner.origin, _id_B265C489291659AB, 2048);

  if(isDefined(_id_88318301272D82DA) && isDefined(_id_88318301272D82DA.script_parameters))
    _id_166B4F052DA169A7::_id_775CD164C569E279(_id_88318301272D82DA.script_parameters);
}

_id_6B03C96242BFE9E6(group) {
  weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_A664AAD02EE98BD2 = "molotov_mp";
  _id_18A73A64992DD07D::give_soldier_armor();
  _id_18A73A64992DD07D::give_soldier_helmet();
  self.allowpain = 0;
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = 840;
  self.goalradius = 2048;

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = weapon;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  thread watchchangeweapon();
  thread _id_8B1A3AD62BA39C38();
  thread _id_EB2924EA4D736217();
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

_id_8B1A3AD62BA39C38() {
  level endon("game_ended");
  weapon = undefined;
  _id_F9FA10E07F13F5FD = self.spawner.aitype;

  switch (_id_F9FA10E07F13F5FD) {
    case "shotgun":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
      break;
    case "sniper":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("alpha50");
      break;
    case "lmg":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mkilo3");
      break;
    case "smg":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
      break;
    case "ar_laser":
    case "ar":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
      break;
    default:
      break;
  }

  self waittill("death");

  if(isDefined(weapon)) {
    _id_CD9ABE0E758CBDF7 = weapon;
    _id_92FCE7B1696254E3 = weapon.basename;

    if(issubstr(tolower(_id_92FCE7B1696254E3), "_ai")) {
      _id_92FCE7B1696254E3 = getsubstr(_id_92FCE7B1696254E3, 0, _id_92FCE7B1696254E3.size - 3);
      _id_CD9ABE0E758CBDF7 = makeweapon(_id_92FCE7B1696254E3, weapon.attachments);
    }

    if(isDefined(level.dropped_weapon_func))
      self thread[[level.dropped_weapon_func]](_id_CD9ABE0E758CBDF7, self.origin);
  }
}

_id_EB2924EA4D736217() {
  level endon("game_ended");
  self endon("death");
  _id_D01C4A7C13A1D961 = 100;

  for(;;) {
    self waittill("damage");

    if(self._id_B5218CF00DAD94EF <= _id_D01C4A7C13A1D961) {
      break;
    }
  }

  _id_9ED4AF47ABD0976E = randomfloatrange(5, 10);
  self allowedstances("crouch");
  wait(_id_9ED4AF47ABD0976E);
  self allowedstances("stand", "crouch");
}

_id_88D06AF5A580DAAA(group) {
  self.maxsightdistsqrd = 65536;
  self.baseaccuracy = 0.5;
  _id_4F2A0297830D644C = strtok(group.group_name, "_");
  self.goalradius = 100;

  switch (_id_4F2A0297830D644C[0]) {
    case "shotgun":
    case "ar":
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 2048);
      self _meth_9215CE6FC83759B9(2000);
      break;
    case "smg":
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 1024);
      self _meth_9215CE6FC83759B9(1000);
      break;
    default:
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 1024);
      self _meth_9215CE6FC83759B9(1000);
      break;
  }

  self.dont_enter_combat = 1;
  self.combatmode = "ambush";
  thread _id_78942AAFDAA59637();
  thread _id_5C4325F409A1BA2C();
  thread _id_FA8A2147A1B93DBA();
}

_id_FA8A2147A1B93DBA() {
  level endon("game_ended");
  self endon("death");
  result = scripts\engine\utility::waittill_any_ents_return(level, "send_indoor_ai_after_player", self, "send_indoor_ai_after_player");

  while(!_id_7E031905C49F9B9A())
    wait 2;

  if(_id_7E031905C49F9B9A())
    self setgoalentity(level._id_9D709E54566707E6);
}

_id_59016F53183FDDBD() {
  self endon("death");
  level endon("game_ended");
  self endon("alerted_to_player");
  self waittill("bulletwhizby", eattacker, _id_081D1B691350B0A1, _id_C9B351269A319209, param4);
  self.goalradius = 250;
  self.dont_enter_combat = 0;
  self.combatmode = "no_cover";
  self.combatmode = "no_cover";
  self notify("alerted_to_player");
}

_id_78942AAFDAA59637(_id_7287EC98AAFB0427) {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");

  if(!isDefined(_id_7287EC98AAFB0427))
    _id_7287EC98AAFB0427 = 250;

  for(;;) {
    playerlist = [];

    if(_id_7E031905C49F9B9A())
      playerlist[playerlist.size] = level._id_9D709E54566707E6;

    if(_id_FB6190FCD263559D())
      playerlist[playerlist.size] = level.chopper_gunner._id_1A92A51A600CEFCB;

    if(isDefined(level._id_9D709E54566707E6))
      self getenemyinfo(level._id_9D709E54566707E6);

    foreach(player in playerlist) {
      if(_id_19B2AC035D02BEB8(player)) {
        self.goalradius = _id_7287EC98AAFB0427;
        self._id_9FF99CFC426066A2 = _id_7287EC98AAFB0427;
        self.dont_enter_combat = 0;
        self.combatmode = "no_cover";

        if(_id_7E031905C49F9B9A())
          self.favoriteenemy = level._id_9D709E54566707E6;

        self notify("send_indoor_ai_after_player");
        self notify("alerted_to_player");
        return;
      }
    }

    wait 0.1;
  }
}

_id_5C4325F409A1BA2C(_id_7287EC98AAFB0427) {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");
  self waittill("damage", idamage, eattacker);

  if(!isDefined(_id_7287EC98AAFB0427))
    _id_7287EC98AAFB0427 = 250;

  self.goalradius = _id_7287EC98AAFB0427;
  self._id_9FF99CFC426066A2 = _id_7287EC98AAFB0427;
  self.dont_enter_combat = 0;
  self.combatmode = "no_cover";

  if(_id_7E031905C49F9B9A())
    self.favoriteenemy = level._id_9D709E54566707E6;

  self notify("send_indoor_ai_after_player");
  self notify("alerted_to_player");
}

_id_19B2AC035D02BEB8(player) {
  _id_ECE9C1126186017B = distance(player.origin, self.origin) <= 256;
  _id_30068470264CDE43 = self cansee(player);
  return _id_ECE9C1126186017B && _id_30068470264CDE43;
}

_id_2A570A7AD5DF09F1(group) {
  self.dont_enter_combat = 1;
  self.maxsightdistsqrd = 250000;
  self.baseaccuracy = 0.5;
  weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_A664AAD02EE98BD2 = "molotov_mp";
  _id_18A73A64992DD07D::give_soldier_armor();
  _id_18A73A64992DD07D::give_soldier_helmet();
  self.allowpain = 0;
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = 840;
  self.goalradius = 2048;

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = weapon;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  thread watchchangeweapon();
  thread _id_8B1A3AD62BA39C38();
  thread _id_EB2924EA4D736217();
  _id_4F2A0297830D644C = strtok(group.group_name, "_");

  switch (_id_4F2A0297830D644C[0]) {
    case "ar":
      self.goalradius = 500;
      break;
    case "smg":
      self.goalradius = 500;
      break;
    default:
      self.goalradius = 500;
      break;
  }

  self.maxfaceenemydist = 2500;
  target_player = _id_F82D01F0436956CA(1);

  if(isDefined(target_player)) {
    self setgoalentity(target_player);
    thread _id_8CE291F83C7E93AB(target_player);
  } else if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    destination = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    thread _id_8CE291F83C7E93AB(destination.origin);
  } else {
    destination = scripts\engine\utility::getStruct("hills_mi_combat_1", "script_noteworthy").origin;
    self setgoalpos(destination);
  }

  thread _id_C5BA38706C958334(self, 0);
}

_id_BEAB1C0B4C385995(group) {
  self.maxsightdistsqrd = 4194304;
  self.baseaccuracy = 0.5;
  self.combatmode = "no_cover";
  _id_4F2A0297830D644C = strtok(group.group_name, "_");

  switch (_id_4F2A0297830D644C[0]) {
    case "ar":
      self setengagementmindist(256, 256);
      self setengagementmaxdist(2048, 2048);
      self _meth_9215CE6FC83759B9(2048);
      self.goalradius = 1500;
      break;
    case "smg":
      self setengagementmindist(256, 256);
      self setengagementmaxdist(4096, 4096);
      self _meth_9215CE6FC83759B9(4096);
      self.goalradius = 1000;
      break;
    default:
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 1024);
      self _meth_9215CE6FC83759B9(1000);
      self.goalradius = 500;
      break;
  }

  self.maxfaceenemydist = 2500;
  target_player = _id_F82D01F0436956CA(1);

  if(isDefined(target_player)) {
    self getenemyinfo(target_player);
    self setgoalentity(target_player);
    thread _id_8CE291F83C7E93AB(target_player);
    thread _id_A0A760B7FC875606(target_player, 1024);
  } else if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    destination = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    thread _id_8CE291F83C7E93AB(destination.origin);
    thread _id_A0A760B7FC875606(destination.origin, 1024);
  }

  thread _id_C5BA38706C958334(self, 0);
}

_id_50A472A61CAFFD1D(group) {
  if(!isDefined(level._id_F873D9B7D89DAF52))
    level._id_F873D9B7D89DAF52 = 0;

  self.goalradius = 512;

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    destination = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    thread _id_8CE291F83C7E93AB(destination.origin);
  } else
    thread _id_283DF23BE68550CB();

  if(level._id_F873D9B7D89DAF52 < 1) {
    thread _id_4EC859E05D4290A7::_id_EE71C0848A6901D2();
    level._id_F873D9B7D89DAF52++;
    level thread _id_71C176D24810724C(self);
  }

  thread _id_C5BA38706C958334(self, 1);
}

_id_71C176D24810724C(ai) {
  level endon("game_ended");
  ai waittill("death");
  level._id_F873D9B7D89DAF52--;
}

_id_958BC0F5EB3F5FAF(group) {
  waitframe();
  thread _id_F2A60739AF70A805();
}

_id_F2A60739AF70A805() {
  self endon("death");
  self endon("goal");
  self endon("goal_reached");

  if(_id_7E031905C49F9B9A())
    self setgoalentity(level._id_9D709E54566707E6);
  else {
    goal = scripts\engine\utility::getStruct("house_global_objective_marker", "script_noteworthy");
    self setgoalpos(goal.origin);
  }
}

_id_7788C7DCDE0FF84D(group) {
  _id_2A140C28069BB952 = ["scriptable_door_wooden_panel_mp_01", "scriptable_ee_door_wooden_entrance_01", "scriptable_door_wooden_hollow_mp_01", "scriptable_door_metal_04_flat_painted_mp_tan", "scriptable_door_wood_ornate_01_green_double_r", "scriptable_door_wood_ornate_01_green_double_l"];
  _id_07BE4DAEEADA81DF = getscriptablearrayinradius("scriptable_me_military_guard_tower", "classname", self.spawner.origin, 512);

  if(_id_07BE4DAEEADA81DF.size <= 0 || !isDefined(_id_07BE4DAEEADA81DF[0].trigger)) {
    destination = scripts\engine\utility::drop_to_ground(self.spawner.origin);
    self dontinterpolate();
    self forceteleport(getclosestpointonnavmesh(destination), (0, 0, 0));
  }
}

_id_EECC5FBD7985FABF(group) {
  self.dont_enter_combat = 1;
  self.maxfaceenemydist = 2500;
  self.goalradius = 3000;

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    destination = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    thread _id_8CE291F83C7E93AB(destination.origin);
  }

  if(_id_FB6190FCD263559D()) {
    thread _id_FBBB03B68D6A7B48();
    self.favoriteenemy = level.chopper_gunner._id_1A92A51A600CEFCB;
    target_player = level.chopper_gunner._id_1A92A51A600CEFCB;
    self _meth_9215CE6FC83759B9(6000);
    self setengagementmaxdist(4096, 4096);
    self setengagementmindist(4096, 4096);
    thread _id_283DF23BE68550CB();
  } else {
    target_player = _id_F82D01F0436956CA(0);

    if(isDefined(target_player))
      thread _id_8CE291F83C7E93AB(target_player);
  }

  thread _id_C5BA38706C958334(self, 1);
  thread _id_738857D8B3F1B0A6();
}

_id_738857D8B3F1B0A6() {
  self endon("death");
  level endon("game_ended");
  _id_814A4BD4876C84F7 = 3000;

  for(;;) {
    if(_id_FB6190FCD263559D() && distance2d(self.origin, level.chopper_gunner._id_1A92A51A600CEFCB.origin) > _id_814A4BD4876C84F7) {
      self.goalradius = 2000;
      goal = getclosestpointonnavmesh(level.chopper_gunner._id_1A92A51A600CEFCB.origin);
      self setgoalpos(goal);
    }

    wait 4;
  }
}

_id_FBBB03B68D6A7B48() {
  level endon("game_ended");
  level endon("stop_systemic_vo");

  if(!_id_FB6190FCD263559D()) {
    return;
  }
  level.chopper_gunner._id_1A92A51A600CEFCB endon("death");

  if(!isDefined(level._id_0701CB0304B11C9B))
    level._id_0701CB0304B11C9B = gettime();

  _id_08358025D0C1B86C = 30000;

  if(gettime() - level._id_0701CB0304B11C9B <= _id_08358025D0C1B86C) {
    return;
  }
  if(istrue(level._id_0FC1F555662DF0B1)) {
    return;
  }
  level._id_0FC1F555662DF0B1 = 1;
  level._id_0701CB0304B11C9B = gettime();
  _id_3F95BA8F54220991 = level.chopper_gunner._id_1A92A51A600CEFCB.origin;
  _id_5625856328A094FB = ["dx_cp_cpes_shhl_hlp1_rpgincomingdeployeva", "dx_cp_cpes_shhl_hlp1_rpgcomininhotletsmov", "dx_cp_cpes_shhl_hlp1_rpgmovetoevasiveacti"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_5625856328A094FB));
  wait 1;
  result = level.chopper_gunner._id_1A92A51A600CEFCB scripts\engine\utility::waittill_any_timeout_1(5, "deploying_flares");

  if(result == "deploying_flares") {
    _id_0CA9479FDA8AD38E = ["dx_cp_cpes_shhl_hlp1_flaresarenogoodwegot", "dx_cp_cpes_shhl_hlp1_countermeasuresareno", "dx_cp_cpes_shhl_hlp1_countermeasureswontw", "dx_cp_cpes_shhl_hlp1_countermeasuresineff", "dx_cp_cpes_shhl_hlp1_noflaresevade"];
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_0CA9479FDA8AD38E));
  } else if(distance(_id_3F95BA8F54220991, level.chopper_gunner._id_1A92A51A600CEFCB.origin) <= 200) {
    _id_98436D2BB7C16B1C = ["dx_cp_cpes_shhl_hlp1_evadeevade", "dx_cp_cpes_shhl_hlp1_pullup", "dx_cp_cpes_shhl_hlp1_shitpulluppullup"];
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_98436D2BB7C16B1C));
  } else if(isDefined(level._id_3F5BA02A05B851C1) && gettime() - level._id_3F5BA02A05B851C1 > 10000) {
    _id_5C88788F843005C2 = ["dx_cp_cpes_shhl_hlp1_goodflying", "dx_cp_cpes_shhl_hlp1_goodmaneuver", "dx_cp_cpes_shhl_hlp1_thatwasslick", "dx_cp_cpes_shhl_hlp1_nicemove", "dx_cp_cpes_shhl_hlp1_notascratch"];
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_5C88788F843005C2));
  }

  level._id_0FC1F555662DF0B1 = 0;
}

_id_283DF23BE68550CB() {
  level endon("game_ended");

  if(_id_FB6190FCD263559D())
    chopper = level.chopper_gunner._id_1A92A51A600CEFCB;
  else
    return;

  chopper endon("death");
  self endon("death");
  self.goalradius = 1000;

  for(;;) {
    self._id_4933AADB33DC20FE = distance2d(self.origin, chopper.origin);

    if(distance2d(self.origin, chopper.origin) > 2500)
      self setgoalpos(scripts\engine\utility::drop_to_ground(chopper.origin));
    else
      self setgoalpos(self.origin);

    wait 3;
  }
}

_id_A0A760B7FC875606(goal, _id_47DB6DD0C3A6BB34) {
  level endon("game_ended");
  self endon("death");
  self endon("goal");
  self endon("goal_reached");
  _id_2FFEE5A8FAEA0317 = isent(goal);
  distsqrd = _id_47DB6DD0C3A6BB34 * _id_47DB6DD0C3A6BB34;

  if(istrue(_id_2FFEE5A8FAEA0317)) {
    goal endon("death");

    if(isPlayer(goal))
      goal endon("disconnect");
  }

  for(;;) {
    if(istrue(_id_2FFEE5A8FAEA0317)) {
      if(scripts\engine\utility::distance_2d_squared(self.origin, goal.origin) <= distsqrd) {
        break;
      }
    } else if(scripts\engine\utility::distance_2d_squared(self.origin, goal) <= distsqrd) {
      break;
    }

    wait 2;
  }

  scripts\engine\utility::set_movement_speed(99);
}

_id_8CE291F83C7E93AB(goal) {
  level endon("game_ended");
  self endon("death");
  self endon("goal");
  self endon("goal_reached");

  if(isent(goal)) {
    goal endon("death");
    self setgoalentity(goal);
  } else
    self setgoalpos(goal);

  while(!_id_FB6190FCD263559D()) {
    wait 1;
    continue;
  }

  player = level.chopper_gunner;
  player endon("death");

  for(;;) {
    player waittill("gunner_turret_impact", position);

    if(distancesquared(position, self.origin) <= 65536) {
      _id_56B0CC11B158491E = _id_A59F06F4B5F8F8B0(self.origin, position, 180);
      _id_6E281DBD69FC980E = getclosestpointonnavmesh(_id_01DF4F4FC6E338CC(self.origin, _id_56B0CC11B158491E, 512));
      self setgoalpos(_id_6E281DBD69FC980E);
      return;
    }
  }
}

_id_636CA83368A7BB7D() {
  level endon("game_ended");
  self endon("death");

  while(!_id_FB6190FCD263559D()) {
    wait 1;
    continue;
  }

  level.chopper_gunner endon("death");
  chopper = level.chopper_gunner._id_1A92A51A600CEFCB;

  for(;;) {
    level.chopper_gunner waittill("gunner_turret_impact", position);
    level thread scripts\engine\utility::draw_circle(position, 64, (1, 0, 0), 1, 0, 60);
  }
}

_id_3C1791B14B77F3A7(group) {
  waitframe();

  if(!isDefined(level._id_3009A6A54E094536))
    level._id_3009A6A54E094536 = [];

  level._id_3009A6A54E094536[level._id_3009A6A54E094536.size] = self;
  self._id_EC7F24B7685542B0 = level._id_3009A6A54E094536.size - 1;
  self.team = "allies";
  self.maxhealth = 300;
  self.health = 300;
  self.maxsightdistsqrd = 65536;
  self.baseaccuracy = 0.5;
  self.goalradius = 128;
  self.goalheight = 1024;
  self.maxfaceenemydist = 512;
  scripts\engine\utility::set_movement_speed(275);
  _id_FEA750D6814B803D = "iw9_ar_mike4_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_mike4_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_pi_papa220_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  self.sidearm = level._id_67B54180A55F70E1[_id_4F04B9C326EB7400];
  scripts\common\utility::initweapon(self.sidearm);
  _id_A68442EBADB66EB1 = "frag_grenade_mp";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 2;
  self.attackeraccuracy = 0;
  thread _id_B3DAE16DDEA1A670();
  thread _id_473371A80215AF61(0.75);
  thread _id_1BCAD12DDB842B66(8000);
  thread _id_9211CFE8D7488EFE();
}

_id_FC8AD3044E1171CD(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname) {
  idamage = 0;
}

_id_B3DAE16DDEA1A670() {
  if(!isDefined(level._id_6664BAC2A45BC0A0)) {
    level._id_6664BAC2A45BC0A0 = [];
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_ADAMSON";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_ARRIZON";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_CECOT";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_DENNY";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_EGAN";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_EGERT";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_CHEN";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_GARRIDO";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_JONES";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_LEEAMIES";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_LIMAYE";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_LUO";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MASON";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MILLER";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_OHARA";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_PARISE";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_PIERRO";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_PIERSON";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_RAMON";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_RIEKE";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_SALOMON";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_SANDOVAL";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_STASICA";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_THIES";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_UYEDA";
    level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_HOLMES";
  }

  if(level._id_6664BAC2A45BC0A0.size > 0) {
    self._id_50C39E58AF7F7018 = scripts\engine\utility::random(level._id_6664BAC2A45BC0A0);
    level._id_6664BAC2A45BC0A0 = scripts\engine\utility::array_remove(level._id_6664BAC2A45BC0A0, self._id_50C39E58AF7F7018);
    self _meth_3DE79443C911D4A5(1, 2, self._id_50C39E58AF7F7018);
  }
}

_id_1BCAD12DDB842B66(maxdistance) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(istrue(self._id_D299274BFC2E5980)) {
      wait 1;
      continue;
    }

    if(_id_7E031905C49F9B9A() && distance2d(self.origin, level._id_9D709E54566707E6.origin) >= maxdistance) {
      _id_4EA8D754FEBA7E51 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(level._id_9D709E54566707E6, (-600, 0, 0)));
      self forceteleport(_id_4EA8D754FEBA7E51, level._id_9D709E54566707E6.angles);
    }

    wait 5;
  }
}

_id_85D16DF4EF394692(ally) {
  if(!isDefined(ally.name)) {
    return;
  }
  switch (ally.name) {
    case "Allen":
      ally._id_7C502D9E3AA55CED = &"CP_HILLS_MI/ALLEN_DOWN";
      break;
    case "Bob":
      ally._id_7C502D9E3AA55CED = &"CP_HILLS_MI/BOB_DOWN";
      break;
    case "Charlie":
      ally._id_7C502D9E3AA55CED = &"CP_HILLS_MI/CHARLIE_DOWN";
      break;
    case "Doug":
      ally._id_7C502D9E3AA55CED = &"CP_HILLS_MI/DOUG_DOWN";
      break;
    case "Ernie":
      ally._id_7C502D9E3AA55CED = &"CP_HILLS_MI/ERNIE_DOWN";
      break;
  }
}

_id_9211CFE8D7488EFE() {
  level endon("game_ended");
  _id_7C502D9E3AA55CED = self._id_7C502D9E3AA55CED;
  self waittill("death");

  if(isDefined(level._id_3009A6A54E094536) && scripts\engine\utility::array_contains(level._id_3009A6A54E094536, self))
    level._id_3009A6A54E094536 = scripts\engine\utility::array_remove(level._id_3009A6A54E094536, self);

  level thread _id_F654D9CCFD39E1AA();
}

_id_D43578C37AA09B2D() {
  if(!isDefined(level._id_3009A6A54E094536))
    return 4;

  return level._id_3009A6A54E094536.size;
}

_id_5EDBA34869898153(group) {
  waitframe();

  if(isDefined(level._id_DA40E412E6C89D67)) {
    return;
  }
  self.team = "allies";
  self.maxhealth = 700;
  self.health = 700;
  self.goalradius = 64;
  self._id_EC7F24B7685542B0 = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  level._id_DA40E412E6C89D67 = self;

  if(isDefined(level._id_8D6BBD2A7D3244E1)) {
    self.name = level._id_8D6BBD2A7D3244E1[0];
    level._id_8D6BBD2A7D3244E1 = scripts\engine\utility::array_remove(level._id_8D6BBD2A7D3244E1, self.name);
  }

  self dropweaponnovelocity(self.weapon, "left");
  thread scripts\common\ai::magic_bullet_shield();
  thread _id_59E7FCFADF43E66E(0.75);
}

_id_59E7FCFADF43E66E(interval) {
  level endon("game_ended");
  self endon("death");
  self endon("stop_hvt_follow_logic");
  _id_5B64F4E84DCCCEE0(self.origin, 128);
  level notify("hvt_started_following");

  for(;;) {
    _id_D94933A1CE5E1AFC();
    wait(interval);
  }
}

_id_B4A480759E24A2B7(ally) {
  level endon("game_ended");
  ally endon("death");
  ally endon("stop_idling");
  self.dont_enter_combat = 1;
  ally.animationarchetype = "soldier";
  ally scripts\asm\asm_bb::bb_setanimScripted();
  ally asmsetstate(ally.asmname, "animscripted");
  animindex = ally scripts\asm\asm::asm_lookupanimfromalias("animscripted", "hills_ally_idle");
  xanim = ally scripts\asm\asm::asm_getxanim("animscripted", animindex);
  ally dontinterpolate();
  ally aisetanim("animscripted", animindex);
  ally animmode("noclip");
}

_id_EA84D8D085290F40() {
  self endon("death");
  self endon("stop_idling");
  level endon("game_ended");
  _id_A5D6F8F39DF53247 = ["dx_cp_cpes_shfb_pmc1_checkyourfire", "dx_cp_cpes_shfb_pmc1_watchyourfire", "dx_cp_cpes_shfb_pmc1_checkfirecheckfire"];
  _id_A4365188C5354890 = ["dx_cp_cpes_shfb_pmc2_checkyourfire", "dx_cp_cpes_shfb_pmc2_watchyourfire", "dx_cp_cpes_shfb_pmc2_checkfirecheckfire"];
  _id_F23BE7BDC2EDD369 = ["dx_cp_cpes_shfb_pmc3_checkyourfire", "dx_cp_cpes_shfb_pmc3_watchyourfire", "dx_cp_cpes_shfb_pmc3_checkfirecheckfire"];
  _id_9E8B17696EB8F5C2 = ["dx_cp_cpes_shfb_pmc4_checkyourfire", "dx_cp_cpes_shfb_pmc4_watchyourfire", "dx_cp_cpes_shfb_pmc4_checkfirecheckfire"];
  _id_37ACF411672394D8 = ["dx_cp_cpes_shfb_lasw_knockitoffbreakercho", "dx_cp_cpes_shfb_lasw_curbthatbreakerweveg", "dx_cp_cpes_shfb_lasw_saveyourbrassforaq", "dx_cp_cpes_shfb_lasw_firedisciplinetilyou"];
  lines = [];

  if(!isDefined(self._id_EC7F24B7685542B0))
    self._id_EC7F24B7685542B0 = -1;

  switch (self._id_EC7F24B7685542B0) {
    case 0:
    default:
      lines = _id_A5D6F8F39DF53247;
      break;
    case 1:
      lines = _id_A4365188C5354890;
      break;
    case 2:
      lines = _id_F23BE7BDC2EDD369;
      break;
    case 3:
      lines = _id_9E8B17696EB8F5C2;
      break;
  }

  thread _id_283263FF48FE8F6C(self, lines);
}

_id_473371A80215AF61(interval) {
  level endon("game_ended");
  self endon("death");
  self._id_D299274BFC2E5980 = 1;
  thread _id_EA84D8D085290F40();
  thread _id_B4A480759E24A2B7(self);
  _id_0C134816A7914E32();
  self notify("stop_idling");
  self._id_D299274BFC2E5980 = 0;
  scripts\engine\utility::disable_pain();
  scripts\common\ai::magic_bullet_shield(1);
  self.invulnerable = 1;

  if(!isDefined(self._id_1EC812B92A31CDD3))
    self._id_1EC812B92A31CDD3 = [];

  self._id_1EC812B92A31CDD3[self._id_1EC812B92A31CDD3.size] = ::_id_FC8AD3044E1171CD;
  scripts\asm\asm_bb::bb_clearanimScripted();
  self.dont_enter_combat = 0;
  thread _id_A416EAE272220C0A(self, 0, 1, "hud_icon_head_equipment_friendly");

  for(;;) {
    _id_D94933A1CE5E1AFC();
    wait(interval);
  }
}

_id_D94933A1CE5E1AFC() {
  if(getdvarint("dvar_5DBBD006238B5AEA", 0) > 0) {}

  if(isDefined(level._id_D15A03198489916D) && isDefined(self._id_EC7F24B7685542B0)) {
    _id_6E281DBD69FC980E = self getclosestreachablepointonnavmesh(level._id_D15A03198489916D[self._id_EC7F24B7685542B0]);

    if(isDefined(self._id_C812E56AAC3CF3F2) && distance2d(self._id_C812E56AAC3CF3F2, _id_6E281DBD69FC980E) <= 64) {
      return;
    }
    self._id_C812E56AAC3CF3F2 = _id_6E281DBD69FC980E;
    self setgoalpos(_id_6E281DBD69FC980E);
    return;
  } else
    return;
}

_id_01DF4F4FC6E338CC(_id_BF6A083C5A5402A4, _id_BF6A0B3C5A54093D, _id_21A2442ADB816DD6) {
  _id_6D455CCA8AC3B436 = distance(_id_BF6A083C5A5402A4, _id_BF6A0B3C5A54093D);
  _id_666D077F74E2DEE6 = _id_21A2442ADB816DD6 / _id_6D455CCA8AC3B436;
  x = _id_BF6A083C5A5402A4[0] - _id_666D077F74E2DEE6 * (_id_BF6A083C5A5402A4[0] - _id_BF6A0B3C5A54093D[0]);
  y = _id_BF6A083C5A5402A4[1] - _id_666D077F74E2DEE6 * (_id_BF6A083C5A5402A4[1] - _id_BF6A0B3C5A54093D[1]);
  z = _id_BF6A083C5A5402A4[2] - _id_666D077F74E2DEE6 * (_id_BF6A083C5A5402A4[2] - _id_BF6A0B3C5A54093D[2]) + 64;
  return getgroundposition((x, y, z), 1);
}

_id_A59F06F4B5F8F8B0(center, point, angle) {
  _id_7F053C4B79E7834A = cos(angle) * (point[0] - center[0]) - sin(angle) * (point[1] - center[1]) + center[0];
  _id_7F053D4B79E7857D = sin(angle) * (point[0] - center[0]) + cos(angle) * (point[1] - center[1]) + center[1];
  _id_7F053A4B79E77EE4 = point[2] + 250;
  return getgroundposition((_id_7F053C4B79E7834A, _id_7F053D4B79E7857D, point[2]), 1);
}

_id_E6E081264B34C544() {
  if(!_id_7E031905C49F9B9A())
    return 0;

  return scripts\cp\utility::is_indoors(level._id_9D709E54566707E6);
}

_id_E9D36332D52EF533() {
  level endon("game_ended");
  _id_D505904CC3241AB2 = scripts\engine\utility::getStruct("house_global_objective_marker", "script_noteworthy");

  for(;;) {
    if(scripts\engine\utility::flag("house_interaction_destroyed")) {
      return;
    }
    if(_id_E6E081264B34C544() && distance2d(_id_D505904CC3241AB2.origin, level._id_9D709E54566707E6.origin) <= _id_D505904CC3241AB2.radius) {
      level _id_F9E850963D284105();
      wait 5;
    }

    wait 1;
  }
}

_id_AB6DFABA852446A9() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("gasstation_global_objective_marker", "script_noteworthy");

  for(;;) {
    if(_id_E6E081264B34C544() && distance2d(marker.origin, level._id_9D709E54566707E6.origin) <= marker.radius) {
      return;
    }
    wait 1;
  }
}

_id_5B4DDC4E0F77D869() {
  level endon("game_ended");

  while(scripts\engine\utility::flag("hills_important_vo_playing"))
    wait 1;

  scripts\engine\utility::flag_set("hills_important_vo_playing");
  _id_D28BB110565C9670 = ["dx_cp_cpes_shof_pmc1_clearthebuilding", "dx_cp_cpes_shof_pmc1_getthisbuildingsecur", "dx_cp_cpes_shof_pmc1_securetheperimeter", "dx_cp_cpes_shof_pmc1_getthisarealockeddow"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_D28BB110565C9670));
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_12usethermaltodetect");
  wait 1.5;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_11oneofthoseserversw");
  wait 1.5;
  scripts\engine\utility::flag_clear("hills_important_vo_playing");
}

_id_F9E850963D284105() {
  level endon("game_ended");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_472B151D674F3B77 = getaiarray("axis").size;

  if(!istrue(level._id_6418BDF17AFF512A)) {
    thread _id_5B4DDC4E0F77D869();
    level._id_6418BDF17AFF512A = 1;
  }

  _id_30AB2A49CCE8FB24 = ["press_house_1", "press_house_2", "press_house_3", "press_house_4", "press_house_5", "press_house_6"];

  foreach(spawngroup in _id_30AB2A49CCE8FB24) {
    _id_58F137A3CCDFFA5E = _id_18A73A64992DD07D::get_module_struct_from_level(spawngroup);
    _id_350FC69B17797361 = _id_58F137A3CCDFFA5E.totalspawns;
    maxcount = level._id_FF77C4774821472C;

    if(maxcount - _id_472B151D674F3B77 >= _id_350FC69B17797361)
      level thread _id_18A73A64992DD07D::run_spawn_module(spawngroup);

    waitframe();
  }
}

_id_352559B3C422FEE2() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(!isDefined(level._id_AC4465139E7E9D5B) || !isalive(self)) {
      wait 1;
      continue;
    }

    if(_id_E6E081264B34C544()) {
      _id_704ADF6FA1D4A8E6 = _id_CB6B6E0FE20B6AF7(level._id_9D709E54566707E6);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
        level._id_D15A03198489916D[_id_AC0E594AC96AA3A8] = _id_704ADF6FA1D4A8E6._id_783C60861D4DFE3C[_id_AC0E594AC96AA3A8].origin;
    } else {
      _id_6CB568FEC1CF255A = 512;
      _id_79E1A5E2979F19A4 = _id_01DF4F4FC6E338CC(self.origin, level._id_AC4465139E7E9D5B.origin, _id_6CB568FEC1CF255A);

      if(!isDefined(level._id_D15A03198489916D))
        level._id_D15A03198489916D = [_id_79E1A5E2979F19A4, _id_79E1A5E2979F19A4, _id_79E1A5E2979F19A4, _id_79E1A5E2979F19A4];

      level._id_D15A03198489916D[0] = _id_79E1A5E2979F19A4;
      _id_B8FDC4D85662301A = [30, 60, -30];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
        level._id_D15A03198489916D[_id_AC0E594AC96AA3A8 + 1] = _id_A59F06F4B5F8F8B0(self.origin, _id_79E1A5E2979F19A4, _id_B8FDC4D85662301A[_id_AC0E594AC96AA3A8]);
    }

    wait 1;
  }
}

_id_E79785B6383D5077() {
  level endon("game_ended");

  if(getdvarint("dvar_5DBBD006238B5AEA", 0) <= 0) {
    return;
  }
  for(;;) {
    if(!isDefined(level._id_D15A03198489916D)) {
      wait 1;
      continue;
    }

    foreach(index, point in level._id_D15A03198489916D) {
      thread scripts\engine\utility::draw_circle(point, 128, (1, 0, 0), 1, 0, int(22.5));
      thread scripts\engine\utility::draw_line_for_time(self.origin, point, 1, 0, 0, 0.75);
    }

    wait 1;
  }
}

_id_1B3513B44EA880C3() {
  _id_1A974339CFA781BC = 4;

  if(isDefined(level.chopper_gunner._id_9F5E257CDE6CE14D) && gettime() - level.chopper_gunner._id_9F5E257CDE6CE14D < _id_1A974339CFA781BC * 1000)
    return 1;

  return 0;
}

_id_FB6190FCD263559D() {
  return isDefined(level.chopper_gunner) && isalive(level.chopper_gunner) && isDefined(level.chopper_gunner._id_1A92A51A600CEFCB);
}

_id_7E031905C49F9B9A() {
  return isDefined(level._id_9D709E54566707E6) && isalive(level._id_9D709E54566707E6);
}

_id_A5F72F6250E7F165(player) {
  level endon("game_ended");
  player endon("rescinded_ground_role");
  player._id_AC19F9B9C6C841B9 = "ground";
  player allowmantle(0);
  _id_8D90A7360EFD3B4B(1);
  player.scriptedattackeraccuracy = 1.5;
  player.attackeraccuracy = 1.75;
  level._id_9D709E54566707E6 = player;
  player thread _id_A416EAE272220C0A(player, 0, 1, "hud_icon_head_equipment_friendly_green");
  player scripts\cp\utility::giveperk("specialty_hack");
  player allowmantle(1);
  thread _id_0EF95D41763E2B3C();

  if(isDefined(level._id_E2FBFF9958341586)) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.2);
    startpoint = level._id_E2FBFF9958341586;
    player setOrigin(startpoint.origin, 1, 1);
    player setplayerangles(startpoint.angles);
    wait 0.5;
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 2);
  }

  player _id_3B64EB40368C1450::set("cant_drive", "vehicle_use", 0);
  player scripts\cp\utility::allow_player_basejumping(0, "role_selected");
  level thread _id_680718095309680F(player);
  level thread _id_5A6BA0BAE970E239(player);
  player thread _id_66122A002AFF5D57::takerevivepickup();
  player thread _id_98B9E84FD7E56B39();
  player thread _id_352559B3C422FEE2();

  if(!istestclient(player)) {
    player thread long_range_laser_ent_think(player);
    player thread long_range_laser_vfx_think(player);
  }
}

long_range_laser_ent_think(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  laser_start_ent = undefined;

  if(!player tagexists("tag_laser_attach")) {
    return;
  }
  laser_start_ent = spawn("script_model", player gettagorigin("tag_laser_attach"));
  laser_start_ent setModel("tag_origin");
  laser_start_ent linkTo(player, "j_wrist_le");
  laser_start_ent thread laser_ent_clean_up_monitor(laser_start_ent, player);
  player.laser_start_ent = laser_start_ent;
  laser_end_ent = spawn("script_model", player gettagorigin("tag_eye"));
  laser_end_ent setModel("tag_origin");
  laser_end_ent thread laser_ent_clean_up_monitor(laser_end_ent, player);
  player.laser_end_ent = laser_end_ent;
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);

  for(;;) {
    _id_7FE710B31B2B752D = player gettagorigin("tag_eye");
    _id_70222FBC47330166 = anglesToForward(player getplayerangles());
    _id_7636B8DC247C7CB4 = _id_7FE710B31B2B752D + _id_70222FBC47330166 * 20000;
    end_pos = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_7636B8DC247C7CB4, undefined, contents)["position"];
    player.laser_end_ent.origin = end_pos;
    waitframe();
  }
}

_id_2BA0DDB95F1DD77F() {
  level endon("game_ended");
  startstruct = scripts\engine\utility::getStruct("laser_start_debug", "script_noteworthy");
  _id_D0697AF2ECA83D63 = scripts\engine\utility::getStruct("laser_end_debug", "script_noteworthy");
  _id_DC0CED26BC5059E0 = spawn("script_model", startstruct.origin);
  _id_4F53600C24E96DC3 = spawn("script_model", _id_D0697AF2ECA83D63.origin);
  _id_DC0CED26BC5059E0 setModel("tag_origin");
  _id_4F53600C24E96DC3 setModel("tag_origin");
  _id_0C134816A7914E32();
  visionsetthermal(game["thermal_vision"]);
  wait 1;

  while(!isDefined(level.chopper_gunner))
    wait 1;

  _id_EB778FFABDA1B1A8 = playfxontagsbetweenclients(level._effect["sniper_laser_brightx"], _id_DC0CED26BC5059E0, "tag_origin", _id_4F53600C24E96DC3, "tag_origin", level.chopper_gunner);

  for(;;)
    wait 2;
}

long_range_laser_vfx_think(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  wait 2;

  while(!_id_FB6190FCD263559D())
    wait 1;

  _id_928AB3155CA46F89 = playfxontagsbetweenclients(level._effect["sniper_laser_bright"], player.laser_start_ent, "tag_origin", player.laser_end_ent, "tag_origin", level.chopper_gunner);
  player._id_F10E44A07D9C4C8D = _id_928AB3155CA46F89;
  player thread laser_ent_clean_up_monitor(_id_928AB3155CA46F89, player);
}

laser_ent_clean_up_monitor(_id_E58D98C4472E2132, player) {
  player scripts\engine\utility::waittill_any_2("disconnect", "last_stand");
  _id_E58D98C4472E2132 delete();
}

_id_680718095309680F(player) {
  level endon("game_ended");
  level endon("game_over_sequence_started");
  player endon("disconnect");

  for(;;) {
    player waittill("last_stand_start");
    wait 2;

    if(istrue(player.hasselfrevivetoken)) {
      lines = ["dx_cp_cpes_shhl_lasw_allstations11isdowng", "dx_cp_cpes_shhl_lasw_12keepyourteammateco", "dx_cp_cpes_shhl_lasw_12laydownsuppressing", "dx_cp_cpes_shhl_lasw_11sdownlaycoveringfi", "dx_cp_cpes_shhl_lasw_11getyourselfbackup", "dx_cp_cpes_shhl_lasw_11ifyouvegotarevivek", "dx_cp_cpes_shhl_lasw_11weneedyoutogetupyo"];
      thread _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
      thread _id_908C4D660D45C60C();
    }
  }
}

_id_5A6BA0BAE970E239(player) {
  level endon("game_ended");
  player notify("single_watch_for_ground_player_disconnect");
  player endon("single_watch_for_ground_player_disconnect");
  player waittill("disconnect");
  wait 5;

  if(!_id_7E031905C49F9B9A()) {
    _id_0C343D2C624504B6();
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }
}

_id_908C4D660D45C60C() {
  level endon("game_ended");
  player = level._id_9D709E54566707E6;

  if(!isDefined(player)) {
    return;
  }
  player endon("death");
  player endon("disconnect");

  while(istrue(player.inlaststand))
    wait 1;

  lines = ["dx_cp_cpes_shhl_lasw_tooclose", "dx_cp_cpes_shhl_lasw_watchforanyrevivekit", "dx_cp_cpes_shhl_lasw_aqmighthavemorereviv"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines), player);
}

_id_C7F2052CD75FD495() {
  level endon("game_ended");

  if(_id_FB6190FCD263559D()) {
    level notify("stop_watching_chopper_lifecycle");
    player = level.chopper_gunner;
    chopper = level.chopper_gunner._id_1A92A51A600CEFCB;
    player._id_0C4F916881A2BFC0 = scripts\engine\utility::getStruct("chopper_player_respawner", "script_noteworthy").origin;
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.5);
    wait 1;
    player setOrigin(player._id_0C4F916881A2BFC0, 1, 1);
    chopper thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_leave(0);
    wait 0.5;
    player unlink();
    player setOrigin(player._id_0C4F916881A2BFC0, 1, 1);
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.5);
  }
}

_id_450F1EB13B0AC99F() {
  if(isDefined(level._id_29BEC1F00993E687)) {
    _id_BF90DBFBC3401210 = level._id_29BEC1F00993E687["explosive"];
    bullet_damage = level._id_29BEC1F00993E687["bullet"];
    total = _id_BF90DBFBC3401210 + bullet_damage;
    _id_7F420AA2EC011CCA = 0;
    _id_87969F5E5C6DC42F = 0;

    if(total > 0) {
      _id_7F420AA2EC011CCA = _id_BF90DBFBC3401210 / total;
      _id_87969F5E5C6DC42F = bullet_damage / total;
    }

    dlog_recordevent("dlog_event_cpdata_heli_damage_tracking", ["explosive_damage", level._id_29BEC1F00993E687["explosive"], "bullet_damage", level._id_29BEC1F00993E687["bullet"]]);
  }
}

_id_C636425FFA2D2B96(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  self.oldgoalradius = self.goalradius;
  self.goalradius = 40;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  self.disablearrivals = 1;
  self setgoalpos(player.origin);

  while(1 && isDefined(player) && isalive(player)) {
    self.disablearrivals = 1;
    self setgoalpos(player.origin);

    if(distancesquared(self.origin, player.origin) <= 2500) {
      if(isDefined(player.reviveent)) {
        _id_0AFB7E332AEE4BF2::clear_last_stand_timer(player);
        player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/BEING_REVIVED", 2);
        player.reviveent notify("revive_success");
        player notify("ai_revive_success");
        self.goalradius = self.oldgoalradius;
        self.dontevershoot = 0;
        self.ignoreall = 0;
        self.disablearrivals = 0;
        break;
      }
    }

    waitframe();
  }
}

_id_8E1ACCFC72A935EE(point) {
  _id_B006538274BDB38E = undefined;
  _id_42CA41C7DADAE0C0 = 999999;

  if(isDefined(level._id_3009A6A54E094536)) {
    foreach(ally in level._id_3009A6A54E094536) {
      if(distance(ally.origin, point) < _id_42CA41C7DADAE0C0) {
        _id_B006538274BDB38E = ally;
        _id_42CA41C7DADAE0C0 = distance(ally.origin, point);
      }
    }
  }

  return _id_B006538274BDB38E;
}

_id_D7963AF7F592B7D8() {
  level endon("game_ended");
  level endon("all_players_picked_role");
  level notify("single_watch_for_rolepick_timeout");
  level endon("single_watch_for_rolepick_timeout");
  timeout = getdvarint("dvar_82D2C9E78B49348B", 900);
  endtime = gettime() + timeout * 1000;
  _id_C4BC13D18C7E492E = gettime() + 180000;

  if(istrue(level._id_9C0DB50383D9641A)) {
    return;
  }
  while(gettime() <= endtime) {
    if(gettime() > _id_C4BC13D18C7E492E && level.players.size < 2) {
      _id_B854975D945B6D67();
      return;
    }

    wait 1;
  }

  if(level.players.size < 2) {
    _id_B854975D945B6D67();
    return;
  }

  if(!_id_2E4C1FC27D9CB66F()) {
    foreach(player in level.players) {
      if(!isDefined(player._id_AC19F9B9C6C841B9) || player._id_AC19F9B9C6C841B9 == "ground") {
        player thread _id_A5F72F6250E7F165(player);
        break;
      }
    }
  }

  if(!_id_5F03887AD1CC584F()) {
    foreach(player in level.players) {
      if(!isDefined(player._id_AC19F9B9C6C841B9) || player._id_AC19F9B9C6C841B9 == "chopper") {
        player thread _id_853250DD0C223884(player);
        break;
      }
    }
  }
}

_id_0C134816A7914E32() {
  level endon("game_ended");
  level endon("all_players_picked_role");

  while(!istrue(level._id_9C0DB50383D9641A))
    waitframe();
}

_id_8D90A7360EFD3B4B(_id_82C6E8CB982A0429) {
  level endon("game_ended");
  level endon("all_players_picked_role");

  if(istrue(level._id_9C0DB50383D9641A)) {
    return;
  }
  if(!isDefined(_id_82C6E8CB982A0429))
    _id_82C6E8CB982A0429 = 1;

  location = scripts\engine\utility::getStruct("hills_ground_crate", "script_noteworthy").origin;
  _id_C92D9B66628A2D3F(1, location);

  if(istrue(_id_82C6E8CB982A0429))
    level thread _id_8CB9CB3171C7F1FF();

  for(;;) {
    players = level.players;
    _id_56FDC0D029EC2B65 = 1;

    foreach(player in players) {
      if(istestclient(player) && !isDefined(player._id_AC19F9B9C6C841B9)) {
        player thread _id_A5F72F6250E7F165(player);
        _id_56FDC0D029EC2B65 = 1;
        continue;
      }

      if(!isDefined(player._id_AC19F9B9C6C841B9) || player._id_AC19F9B9C6C841B9 == "")
        _id_56FDC0D029EC2B65 = 0;
    }

    _id_149A1E58BD10AEDD = 2;

    if(getdvarint("dvar_710F63906BD48FE0", 0) > 0)
      _id_149A1E58BD10AEDD = 1;

    if(istrue(_id_56FDC0D029EC2B65) && level.players.size < _id_149A1E58BD10AEDD)
      _id_56FDC0D029EC2B65 = 0;

    if(istrue(_id_56FDC0D029EC2B65)) {
      _id_C92D9B66628A2D3F(0, location);
      level._id_9C0DB50383D9641A = 1;
      level.custom_shouldtakedamage = undefined;
      level.disable_munitions = 0;
      level notify("all_players_picked_role");
    }

    if(istrue(_id_82C6E8CB982A0429))
      scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HILLS_MI/WAITING_ROLEPICKS", "allies", 2);

    wait 3;
  }
}

_id_5F03887AD1CC584F() {
  foreach(player in level.players) {
    if(isDefined(player._id_AC19F9B9C6C841B9) && player._id_AC19F9B9C6C841B9 == "chopper")
      return 1;
  }

  return 0;
}

_id_2E4C1FC27D9CB66F() {
  foreach(player in level.players) {
    if(isDefined(player._id_AC19F9B9C6C841B9) && player._id_AC19F9B9C6C841B9 == "ground")
      return 1;
  }

  return 0;
}

_id_8CB9CB3171C7F1FF() {
  level endon("game_ended");
  level endon("all_players_picked_role");
  level notify("single_do_role_pick_nags");
  level endon("single_do_role_pick_nags");
  _id_3A3AFB9D6C23F58A = ["dx_cp_cpes_shfb_lasw_11yourewiththeground", "dx_cp_cpes_shfb_lasw_11demondogsarewaitin"];
  _id_F42165AB6FA8638C = ["dx_cp_cpes_shfb_lasw_12mountupforairsuppo", "dx_cp_cpes_shfb_lasw_gettotheairsupporthe"];

  while(!istrue(level._id_9C0DB50383D9641A)) {
    if(_id_2E4C1FC27D9CB66F()) {
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_F42165AB6FA8638C));
      wait 1.5;
    } else {
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_3A3AFB9D6C23F58A));
      wait 1.5;
    }

    wait 10;
  }
}

_id_F9C569AD846449E4() {
  level endon("game_ended");

  if(isDefined(level._id_9D709E54566707E6)) {
    _id_D28BB110565C9670 = ["dx_cp_cpes_shhl_pmc1_moveup", "dx_cp_cpes_shhl_pmc1_pushup", "dx_cp_cpes_shhl_pmc1_pushforward", "dx_cp_cpes_shhl_pmc1_weremoving", "dx_cp_cpes_shhl_pmc1_staysharpoutthere", "dx_cp_cpes_shhl_pmc1_stayfrosty", "dx_cp_cpes_shhl_pmc1_keepittight"];
    _id_AFC592D996C38368 = ["dx_cp_cpes_shhl_pmc3_immovingnow", "dx_cp_cpes_shhl_pmc4_goodhunting", "dx_cp_cpes_shhl_pmc2_copythat"];
    scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), scripts\engine\utility::random(_id_D28BB110565C9670));
    scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), scripts\engine\utility::random(_id_AFC592D996C38368));
  }

  wait 1;
  level notify("ground_player_monument_vo");
}

_id_BA7657AFDB1EC2A4() {
  level endon("game_ended");
  _id_AA1ED8F12D71A7A5 = _id_58A07630FC80E92D();

  switch (_id_AA1ED8F12D71A7A5) {
    case "support_heli_monument":
    default:
      scripts\engine\utility::flag_set("hills_important_vo_playing");
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_alrightbreakerletsdo");
      thread _id_F9C569AD846449E4();
      level waittill("ground_player_monument_vo");
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_hlp1_banshee12inboundforc", level.chopper_gunner);
      wait 4;
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_allbreakerstargetare");
      wait 4;
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_aqwillhaveheardourap");
      wait 1.5;

      if(isDefined(level.chopper_gunner) && isDefined(level._id_9D709E54566707E6)) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_BE6F026064897FCC"));
        wait 3;
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_BCA5E472447F8C73"));
        wait 3;
      }

      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_12usethermaltoidtarg");
      wait 4;

      if(isDefined(level.chopper_gunner)) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_C280C66C7D0377BE"));
        wait 2;
        _id_6DF1ED4743A8EA55 = ["dx_cp_cpes_shhl_lasw_12youareclearedhot", "dx_cp_cpes_shhl_lasw_weaponsfree", "dx_cp_cpes_shhl_lasw_youarecleartoengage"];
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_youarecleartoengage");
        wait 1.5;
      } else
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_banshee12youreapproa");

      if(_id_7E031905C49F9B9A()) {
        _id_3DD6962E6DD36DD4 = ["dx_cp_cpes_shhl_lasw_11beadvisedenemyisin", "dx_cp_cpes_shhl_lasw_11aqforcesaremovingo", "dx_cp_cpes_shhl_lasw_11preparetoreceiveco", "dx_cp_cpes_shhl_lasw_11preparetoengage"];
        _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_3DD6962E6DD36DD4));
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_BCA5E472447F8C73"));
        wait 2;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_11youvegotasingleuse");
        wait 2.5;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_itshelloutthereyoure");
        wait 1.5;
      }

      break;
    case "support_heli_house":
      scripts\engine\utility::flag_set("hills_important_vo_playing");
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shhl_lasw_goodworkbreakerskeep");
      wait 0.5;

      if(_id_066223279EDE7656() || !_id_FB6190FCD263559D()) {
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_11youareapproachinga");
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_9BB2AB32F41B53F0"));
        wait 2;
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_0D19F47E5D34481A"));
        wait 2;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_12getroundsdownandsc");
      } else if(_id_FB6190FCD263559D()) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_9BB2AB32F41B53F0"));
        wait 2;
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_0D19F47E5D34481A"));
        wait 2;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_copy12layfirearoundt");
        wait 1.5;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_groundteamsetforinfi");
        wait 1;
      } else {
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_11youshouldbeseeingt");
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_locateonyourtacmapan");
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_12scanthebuildingtoc");
      }

      break;
    case "support_heli_gasstaation":
      while(_id_E6E081264B34C544())
        wait 0.5;

      scripts\engine\utility::flag_set("hills_important_vo_playing");

      if(_id_FB6190FCD263559D()) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_0D19F37E5D344667"));
        wait 2;
      } else if(_id_7E031905C49F9B9A()) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_0D19F37E5D344667"));
        wait 2;
      } else
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shmk_lasw_11youshouldbeseeingt");

      lines = ["dx_cp_cpes_shmk_lasw_12getcloseaironthatm", "dx_cp_cpes_shmk_lasw_copygetfirearoundtha"];
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shmk_lasw_groundteamfollow12sm");
      wait 1.5;
      break;
    case "support_heli_culdesac":
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shmk_lasw_greatworkbreakerspus");

      while(_id_E6E081264B34C544())
        wait 0.5;

      scripts\engine\utility::flag_set("hills_important_vo_playing");

      if(_id_FB6190FCD263559D()) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_0D19F27E5D3444B4"));
        wait 2;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_12droproundsoutsidet");
      } else if(_id_7E031905C49F9B9A()) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_0D19F27E5D3444B4"));
        wait 2;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_copygetfirearoundtha");
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_11movetotakeemofflin");
      } else
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shcp_lasw_11youshouldhaveeyeso");

      break;
    case "support_heli_escape":
      scripts\engine\utility::flag_set("hills_important_vo_playing");
      break;
  }

  scripts\engine\utility::flag_clear("hills_important_vo_playing");
  level notify("mission_intro_vo_done");
}

_id_066223279EDE7656() {
  _id_B74984F8B12CF978 = level._id_AC4465139E7E9D5B.origin;

  if(!_id_FB6190FCD263559D())
    return 1;

  if(!_id_7E031905C49F9B9A())
    return 0;

  _id_C2FBF9BD3E3320C6 = distance2d(level._id_9D709E54566707E6.origin, _id_B74984F8B12CF978);
  _id_4C7272413E62E8CB = distance2d(level.chopper_gunner._id_1A92A51A600CEFCB.origin, _id_B74984F8B12CF978);
  return _id_C2FBF9BD3E3320C6 < _id_4C7272413E62E8CB;
}

_id_853250DD0C223884(player) {
  level endon("game_ended");
  player endon("rescinded_chopper_role");
  player allowmantle(0);
  player._id_AC19F9B9C6C841B9 = "chopper";
  _id_8D90A7360EFD3B4B(1);
  self.disable_munitions = 1;
  self._id_76FDC69357652407 = 1;
  player _id_0AFB7E332AEE4BF2::_id_EF09962096AA8771();
  player _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
  player scripts\cp\utility::allow_player_basejumping(0, "role_selected");
  startpoint = scripts\engine\utility::getStruct("hills_mi_chopper_infil", "script_noteworthy");
  player takeallweapons();
  player setclientomnvar("ui_hide_hud", 1);
  player thread _id_2BA9D4C6A31FFE21(player);
  player._id_4D572A54ED8571C4 = 1;
  player _id_644C18834356D9DC::remove_munition(3, "nvg");
  player.pers["useNVG"] = 0;
  player._id_250796613B419E6B = 1;
  player allowmantle(1);
  level.chopper_gunner = player;
  player.infinite_chopper = 1;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.0);
  player._id_0C4F916881A2BFC0 = scripts\engine\utility::getStruct("chopper_player_respawner", "script_noteworthy").origin;
  player setOrigin(player._id_0C4F916881A2BFC0);
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_gunner", player);
  streakinfo._id_1C24AB6A14A60F16 = 1;
  streakinfo._id_6411FBC3AFB86BC0 = ::_id_D5A2C310ACD9BDE8;
  player thread scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunnerfromstruct(streakinfo);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.2);
  scripts\cp\cp_outofbounds::registerooboutoftimecallback("hills_chopper_player", ::_id_39A3F212B5612F85);
  player.oobref = "hills_chopper_player";
  player._id_7269DEEBA689CD65 = 1;
  player._id_5D43389756907528 = 1;
  player scripts\cp\utility::_id_4CBAED764C116A25(1);
  player.pers["ignoreWeaponMatchBonus"] = 1;
  player.pers["ignoreKillstreakKillRewards"] = 1;
  player.pers["ignoreWeaponKillXP"] = 1;
}

_id_85E01DE0E4A6732D(_id_AD0C7D143A055484) {
  level endon("game_ended");
  _id_AD0C7D143A055484 endon("death");
  _id_FB33B8965EAF6630 = 5;
  killcount = 0;
  _id_1A9346C482F28D01 = 5;
  _id_D05D36D89E7C8333 = 1;
  starttime = gettime();
  _id_70E2EFB856B2EEBF = starttime + _id_1A9346C482F28D01 * 1000;

  for(;;) {
    level waittill("enemy_killed", eattacker, ai);

    if(isDefined(eattacker) && eattacker == _id_AD0C7D143A055484) {
      killcount++;

      if(gettime() <= _id_70E2EFB856B2EEBF) {
        if(killcount >= _id_FB33B8965EAF6630) {
          thread _id_94F93D200886198B();
          starttime = gettime();
          _id_70E2EFB856B2EEBF = starttime + _id_1A9346C482F28D01 * 1000;
          killcount = 0;
        } else if(killcount == 1) {
          starttime = gettime();
          _id_70E2EFB856B2EEBF = starttime + _id_1A9346C482F28D01 * 1000;
        } else
          _id_70E2EFB856B2EEBF = _id_70E2EFB856B2EEBF + _id_D05D36D89E7C8333 * 1000;
      } else
        _id_70E2EFB856B2EEBF = gettime() + _id_1A9346C482F28D01 * 1000;
    }

    waitframe();
  }
}

_id_94F93D200886198B() {
  lines = ["dx_cp_cpes_shhl_hlp1_directhit", "dx_cp_cpes_shhl_hlp1_direct", "dx_cp_cpes_shhl_hlp1_goodhit", "dx_cp_cpes_shhl_hlp1_positiveimpact", "dx_cp_cpes_shhl_hlp1_goodattack", "dx_cp_cpes_shhl_hlp1_direct_01", "dx_cp_cpes_shhl_hlp1_hellyeah", "dx_cp_cpes_shhl_hlp1_ohthatwasnice", "dx_cp_cpes_shhl_hlp1_halfdayforthatdude", "dx_cp_cpes_shhl_hlp1_boomthatsallshewrote", "dx_cp_cpes_shhl_hlp1_putachalklinearoundt", "dx_cp_cpes_shhl_hlp1_hewontbehomefordinne", "dx_cp_cpes_shhl_hlp1_theyrenotgettinupfro", "dx_cp_cpes_shhl_hlp1_thatspermanent", "dx_cp_cpes_shhl_hlp1_goodkill", "dx_cp_cpes_shhl_hlp1_goodgungoodguns"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
}

_id_39A3F212B5612F85(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  self.oob = 1;
  _id_C92764FB24B40ABF = self._id_1A92A51A600CEFCB;

  if(isDefined(_id_C92764FB24B40ABF))
    _id_C92764FB24B40ABF thread _id_B7EC4A697CA09E35(_id_C92764FB24B40ABF);
  else
    self dodamage(self.maxhealth + 100000, self.origin, self, undefined, "MOD_SUICIDE");
}

_id_B7EC4A697CA09E35(heli) {
  level endon("game_ended");
  heli endon("death");

  while(heli.health > 0) {
    heli dodamage(heli.maxhealth + 100000, heli.origin, undefined, undefined, "MOD_SUICIDE");
    wait 1;
  }
}

_id_D5A2C310ACD9BDE8(owner) {
  _id_C2F78F301F8104E3 = spawnStruct();
  startstruct = scripts\engine\utility::getStruct("hills_chopper_entry_start", "script_noteworthy");
  _id_D0697AF2ECA83D63 = scripts\engine\utility::getStruct("hills_chopper_entry_end", "script_noteworthy");
  _id_07338D684E238A4E = _id_D0697AF2ECA83D63.origin[2];
  _id_2303D36320CA9ADB = _id_D0697AF2ECA83D63.angles;
  _id_1EF2DC5E723DB0E5 = 10000;
  _id_C2F78F301F8104E3.angles = _id_2303D36320CA9ADB;
  _id_C2F78F301F8104E3.pathstart = startstruct.origin;
  _id_C2F78F301F8104E3.pathgoal = _id_D0697AF2ECA83D63.origin;
  return _id_C2F78F301F8104E3;
}

_id_2BA9D4C6A31FFE21(player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("unique_chopper_ks_waiter");
  player endon("unique_chopper_ks_waiter");
  player waittill("killstreak_vehicle_made", chopper);
  player._id_9F5E257CDE6CE14D = gettime();
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player sethidenameplate(1);
  player._id_1A92A51A600CEFCB = chopper;
  player._id_0C4F916881A2BFC0 = scripts\engine\utility::getStruct("chopper_player_respawner", "script_noteworthy").origin;
  player thread _id_D8C7DDDFCA08DDD1(player, chopper);
  scripts\engine\utility::flag_set("hills_mi_chopper_spawned");
  createthreatbiasgroup("heli");
  level.chopper_gunner._id_1A92A51A600CEFCB.occupants = [player];
  level.chopper_gunner.attractor = missile_createattractorent(level.chopper_gunner._id_1A92A51A600CEFCB, 1000, 7000);
  level.chopper_gunner._id_1A92A51A600CEFCB setthreatbiasgroup("heli");
  player setthreatbiasgroup("heli");
  chopper.maxhealth = 1500;
  chopper.health = 1500;
  chopper.currenthealth = 1500;
  chopper._id_2CE864BD06FB0385 = ::_id_C3D9FA309A13788A;
  chopper.teamfriendlyto = "allies";

  if(!isDefined(level._id_29BEC1F00993E687)) {
    level._id_29BEC1F00993E687 = [];
    level._id_29BEC1F00993E687["bullet"] = 0;
    level._id_29BEC1F00993E687["explosive"] = 0;
  }

  player thread _id_B8A7C0E3C804AACB(player, chopper);
  player thread _id_BCDC268C4072984C(player, chopper);
  player thread _id_85E01DE0E4A6732D(player);
  player thread _id_71888E52CCF305B0();
  level thread _id_51034ED216A9DCD4();
  player thread _id_FD30C9F0460FC6AE(player, chopper);
  chopper thread _id_369DE7D81BAC0F1D(chopper);
  chopper thread _id_42455F2EDB49E4B8(player);
  chopper thread _id_7A4F0E445A3E5EB2(player);
  chopper thread _id_ED38E004B98D0008(chopper);
  player notifyonplayercommand("fired_25mm", "+attack");
  player thread _id_B913271EB3CFBAC3(player, chopper);
  player thread _id_5AA09F438EBA117D();
  chopper thread _id_4EC859E05D4290A7::_id_0122642ECA8CA4DB(chopper, player);
  waitframe();
  chopper scripts\engine\utility::waittill_any_timeout_1(10, "start_chopper_use");
  player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/INFORM_THERMAL", 10);
  level._id_F2DEE333497F7E66 = 1;
  player setclientomnvar("ui_hide_hud", 0);
}

_id_B913271EB3CFBAC3(player, chopper) {
  level endon("game_ended");
  chopper endon("death");
  player endon("disconnect");
  player endon("death");
  _id_6BD97CA46E9F8FB8 = ["dx_cp_cpes_shhl_hlp1_goinghottwofive", "dx_cp_cpes_shhl_hlp1_roundsaway", "dx_cp_cpes_shhl_hlp1_goinghot", "dx_cp_cpes_shhl_hlp1_roundsout", "dx_cp_cpes_shhl_hlp1_sendingrounds", "dx_cp_cpes_shhl_hlp1_shotsaway", "dx_cp_cpes_shhl_hlp1_shotsawayonthetwofiv"];
  _id_2D6AC2C2E199367A = ["dx_guid1044a4246b7a4ea2adaeb356b5e80a3e", "dx_cp_cpes_shhl_hlp1_firingmissile", "dx_cp_cpes_shhl_hlp1_missileout", "dx_cp_cpes_shhl_hlp1_missileloose", "dx_cp_cpes_shhl_hlp1_sendingone"];
  _id_7E8546252676EBDD = ["dx_cp_cpes_shhl_hlp1_copyreloading", "dx_cp_cpes_shhl_hlp1_reloadingrocketsstan", "dx_cp_cpes_shhl_hlp1_reloading"];
  _id_DF5D8C9F1F2DA43D = ["dx_cp_cpes_shhl_hlp1_copyreloadingonthetw", "dx_cp_cpes_shhl_hlp1_copytwofivereloading", "dx_cp_cpes_shhl_hlp1_winchestergottareloa", "dx_cp_cpes_shhl_hlp1_reloadingallgunsstan"];

  for(;;) {
    result = player scripts\engine\utility::waittill_any_return_2("shoot_missile", "fired_25mm");

    if(scripts\engine\utility::flag("hills_important_vo_playing")) {
      continue;
    }
    if(result == "shoot_missile") {
      if(chopper.missilesleft <= 1) {
        thread _id_9A3BA294DA6C72B6(player, chopper);
        _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_7E8546252676EBDD), player);

        if(_id_7E031905C49F9B9A()) {
          _id_75426C708107207D = ["dx_cp_cpes_shhl_lasw_copy11airisreloading", "dx_cp_cpes_shhl_lasw_11beadvisedyourairsu"];
          _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_75426C708107207D), level._id_9D709E54566707E6);
        }
      } else
        _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_2D6AC2C2E199367A), player);
    } else if(isDefined(player._id_606E132DDFE3CCF9) && player._id_606E132DDFE3CCF9 <= 5) {
      thread _id_258E3C88C5C04A08(player, chopper);
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_DF5D8C9F1F2DA43D), player);
    } else
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_6BD97CA46E9F8FB8), player);

    wait 20;
  }
}

_id_9A3BA294DA6C72B6(player, chopper) {
  level endon("game_ended");
  player endon("disconnect");
  chopper endon("death");
  lines = ["dx_cp_cpes_shhl_hlp1_rocketsready", "dx_cp_cpes_shhl_hlp1_rocketsaregoodtogo", "dx_cp_cpes_shhl_hlp1_rocketsupgunready"];
  chopper waittill("missiles_refilled");
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines), player);
}

_id_258E3C88C5C04A08(player, chopper) {
  level endon("game_ended");
  player endon("disconnect");
  chopper endon("death");
  lines = ["dx_cp_cpes_shhl_hlp1_twofiverecharged", "dx_cp_cpes_shhl_hlp1_twofiveready", "dx_cp_cpes_shhl_hlp1_twofivereloaded", "dx_cp_cpes_shhl_hlp1_twofivegunready"];
  chopper waittill("turret_reloaded");
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines), player);
}

_id_5BBA33C1749CFFA2(chopper) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 2;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", chopper.owner, "killstreak");
    wait 5;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", chopper.owner, "killstreak");
    wait 2;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", chopper.owner, "killstreak");
    wait 5;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", chopper.owner, "killstreak");
  }
}

_id_ED38E004B98D0008(chopper) {
  chopper._id_35782E0C1036C9A6 = chopper scripts\engine\utility::spawn_tag_origin();
  chopper._id_35782E0C1036C9A6.origin = chopper._id_35782E0C1036C9A6.origin + (anglesToForward(chopper.angles) * 800 + anglestoleft(chopper.angles) + (0, 0, -100));
  chopper._id_35782E0C1036C9A6 linkTo(chopper);
}

_id_5A596AD5F4294EF0(chopper) {
  chopper._id_35782E0C1036C9A6 = chopper scripts\engine\utility::spawn_tag_origin();
  chopper._id_35782E0C1036C9A6.origin = chopper._id_35782E0C1036C9A6.origin + (anglesToForward(chopper.angles) * 800 + anglestoleft(chopper.angles) + (0, 0, -100));
  chopper._id_35782E0C1036C9A6 linkTo(chopper);
  level thread scripts\engine\utility::draw_circle(chopper._id_35782E0C1036C9A6.origin, 64, (1, 0, 0), 1, 0, 6000);
}

_id_7A4F0E445A3E5EB2(_id_142F50AEBE23AC15) {
  level endon("game_ended");
  _id_142F50AEBE23AC15 endon("death");
  self endon("death");
  _id_2145E628348B7530 = scripts\engine\utility::array_remove(level.players, _id_142F50AEBE23AC15);

  while(!isDefined(level._id_3009A6A54E094536))
    wait 1;

  if(isDefined(level._id_3009A6A54E094536))
    _id_2145E628348B7530 = scripts\cp\utility::array_merge(_id_2145E628348B7530, level._id_3009A6A54E094536);

  foreach(player in _id_2145E628348B7530) {
    if(!isDefined(player)) {
      continue;
    }
    fxtag = spawn("script_model", player gettagorigin("j_sling_clavicle"));
    fxtag setModel("tag_origin");
    fxtag linkTo(player, "j_sling_clavicle");
    playfxontagforclients(scripts\engine\utility::getfx("chopper_gunner_friendly_strobe"), fxtag, "tag_origin", _id_142F50AEBE23AC15);
    fxtag thread _id_F10833F905754B3F(self);
  }
}

_id_F10833F905754B3F(_id_B85D8D5A0284FFB7) {
  self endon("death");
  level endon("game_ended");
  _id_B85D8D5A0284FFB7 scripts\engine\utility::waittill_any_2("death", "leaving");
  self delete();
}

_id_42455F2EDB49E4B8(_id_142F50AEBE23AC15) {
  level endon("game_ended");
  _id_142F50AEBE23AC15 endon("death");
  self endon("death");
  _id_2145E628348B7530 = scripts\engine\utility::array_remove(level.players, _id_142F50AEBE23AC15);
  _id_142F50AEBE23AC15.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", _id_142F50AEBE23AC15, _id_2145E628348B7530, _id_142F50AEBE23AC15, 1, 1);
  _id_142F50AEBE23AC15._id_2B883C6AA7EA98AC = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionwhite", _id_142F50AEBE23AC15, undefined, _id_142F50AEBE23AC15, 1, 1);

  if(isDefined(level._id_3009A6A54E094536)) {
    foreach(ally in level._id_3009A6A54E094536) {
      if(!istrue(ally._id_6557F0CE4EBA1735)) {
        scripts\cp\cp_outline::enable_outline_for_player(ally, _id_142F50AEBE23AC15, "shimmer", "high");
        ally._id_6557F0CE4EBA1735 = 1;
      }
    }
  }
}

_id_8782F4F7BE45949F(ent) {
  if(!_id_FB6190FCD263559D()) {
    return;
  }
  player = level.chopper_gunner;

  if(isDefined(player._id_2B883C6AA7EA98AC))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent, player._id_2B883C6AA7EA98AC);
  else {
    player._id_1A92A51A600CEFCB _id_42455F2EDB49E4B8(player);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent, player._id_2B883C6AA7EA98AC);
  }
}

_id_D8C7DDDFCA08DDD1(player, chopper) {
  player endon("death");
  level endon("game_ended");
  chopper waittill("start_chopper_use");
  player setOrigin(chopper.origin);
  player playerlinkTo(chopper);
}

_id_5AA09F438EBA117D() {
  level endon("game_ended");
  player = self;
  player endon("disconnected");
  player endon("death");

  for(;;) {
    player waittill("luinotifyserver", _id_EA3E3B2121E6713A, _id_394466C2DDB208CB, _id_60FDFB1CFD734D00);

    if(_id_EA3E3B2121E6713A == "calloutmarkerping_added") {
      _id_CE1667A8B72F9520(player, player._id_1A92A51A600CEFCB, 10000);
      wait 1;
    }

    wait 2;
  }
}

_id_CE1667A8B72F9520(player, chopper, dist) {
  start = chopper.origin;
  _id_A43B0202C06E0907 = chopper.turret gettagangles("tag_player");
  _id_898F508242FA99F6 = anglesToForward(_id_A43B0202C06E0907);
  end = start + _id_898F508242FA99F6 * dist;

  foreach(_id_DB822A233B460449 in level._id_FE439A2796E44BB5) {
    foreach(_id_3402D60C1EF6B931 in _id_DB822A233B460449) {
      _id_06B6DD1871D5A29A = _id_3402D60C1EF6B931.equipment[0];

      if(!isDefined(_id_06B6DD1871D5A29A)) {
        continue;
      }
      _id_3D7EAEAE6FD4A047 = scripts\cp\utility::_id_28AB2855171F96F0(start, end, _id_06B6DD1871D5A29A.origin);

      if(_id_3D7EAEAE6FD4A047 < 250) {
        _id_06B6DD1871D5A29A notify("tag_for_ground_player");
        _id_D0AE85B60EC1F5F7 = player calloutmarkerping_create(16, _id_06B6DD1871D5A29A.origin);

        if(isDefined(_id_06B6DD1871D5A29A._id_DF3C8403B8632770))
          _id_06B6DD1871D5A29A._id_DF3C8403B8632770._id_A4D50BF2DE617068 = 1;

        thread _id_EFE63F84F1B40441(_id_3402D60C1EF6B931);
        return;
      }
    }
  }
}

_id_67D6E657AF747C32(_id_87AEED9EF390DFBD) {
  level endon("game_ended");
  _id_5B64F4E84DCCCEE0(_id_87AEED9EF390DFBD.origin, 1512, 1);
  level notify("pinging_new_ammo_depot");
  thread _id_B42BEB2E5864A5DD();
}

_id_B42BEB2E5864A5DD() {
  level endon("game_ended");
  level endon("pinging_new_ammo_depot");
  _id_0E9416D3E26B5DB0 = getEntArray("ammo_refil_station", "targetname");
  _id_0E9416D3E26B5DB0 = scripts\engine\utility::array_combine(getEntArray("ammo_refill_station", "targetname"), _id_0E9416D3E26B5DB0);

  while(!_id_7E031905C49F9B9A())
    wait 1;

  _id_C553093318CFAFDB = scripts\engine\utility::getclosest(level._id_9D709E54566707E6.origin, _id_0E9416D3E26B5DB0, 2048);

  if(isDefined(_id_C553093318CFAFDB))
    _id_D0AE85B60EC1F5F7 = level._id_9D709E54566707E6 calloutmarkerping_create(16, _id_C553093318CFAFDB.origin + (0, 0, 64), _id_C553093318CFAFDB);
}

_id_EFE63F84F1B40441(_id_3402D60C1EF6B931) {
  level endon("game_ended");
  _id_FF152E7B0F4F5389 = 5;

  if(!isDefined(level._id_E7D67D75A69D5C73))
    level._id_E7D67D75A69D5C73 = 0;

  if(gettime() - level._id_E7D67D75A69D5C73 < _id_FF152E7B0F4F5389 * 1000) {
    return;
  }
  level._id_E7D67D75A69D5C73 = gettime();
  _id_1CAC522B9A541C68 = ["dx_cp_cpes_shmk_lasw_breaker11serverlocat", "dx_cp_cpes_shcp_lasw_11serverlocationsare", "dx_cp_cpes_shcp_lasw_movefastsecurethatdr"];

  if(isDefined(_id_3402D60C1EF6B931.script_parameters)) {
    _id_166B4F052DA169A7::_id_775CD164C569E279(_id_3402D60C1EF6B931.script_parameters);
    wait 1.5;
  } else {
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_1CAC522B9A541C68));
    wait 1.5;
  }
}

_id_A416EAE272220C0A(ent, _id_7A7BBC77D3FC5036, _id_C506ABB53432EA6C, icon) {
  level endon("game_ended");

  if(!isDefined(icon))
    icon = "hud_icon_head_equipment_friendly_white";

  ent.headicon = createheadicon(ent);
  setheadiconfriendlyimage(ent.headicon, icon);
  setheadiconzoffset(ent.headicon, 0);
  setheadicondrawthroughgeo(ent.headicon, 1);
  setheadiconmaxdistance(ent.headicon, 31999);
  setheadiconnaturaldistance(ent.headicon, 31999);
  setheadiconsnaptoedges(ent.headicon, 1);
  setheadiconteam(ent.headicon, "allies");

  if(istrue(_id_C506ABB53432EA6C)) {
    while(!isDefined(level._id_9D709E54566707E6))
      waitframe();

    player = level._id_9D709E54566707E6;
    addclienttoheadiconmask(ent.headicon, player);
    hideheadiconfromplayersinmask(ent.headicon);
  }

  if(istrue(_id_7A7BBC77D3FC5036)) {
    while(!isDefined(level.chopper_gunner))
      waitframe();

    player = level.chopper_gunner;
    addclienttoheadiconmask(ent.headicon, player);
    hideheadiconfromplayersinmask(ent.headicon);
  }

  level thread remove_headicon_on_death(ent);
}

remove_headicon_on_death(ent) {
  level endon("game_ended");
  headicon = ent.headicon;
  ent waittill("death");
  deleteheadicon(headicon);
}

_id_C3D9FA309A13788A(data) {
  if(isDefined(self.owner) && isDefined(data.attacker) && data.attacker == self.owner && isDefined(data.meansofdeath) && data.meansofdeath == "MOD_SUICIDE") {
    data.damage = 0;
    return;
  }

  if(scripts\engine\utility::isbulletdamage(data.meansofdeath)) {
    if(!isDefined(self._id_7E38DEC37E9E3486))
      self._id_7E38DEC37E9E3486 = -1;

    canbedamaged = gettime() >= self._id_7E38DEC37E9E3486;

    if(istrue(canbedamaged)) {
      data.damage = data.damage / 2;
      self._id_7E38DEC37E9E3486 = gettime() + 1500.0;
    } else
      data.damage = 0;
  }
}

_id_BCDC268C4072984C(player, chopper) {
  level endon("game_ended");
  chopper endon("death");
  player endon("disconnect");

  if(!isDefined(player.damage.bloodoverlay))
    player _id_25845ACA699D038D::initbloodoverlay();

  for(;;) {
    chopper waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    level._id_3F5BA02A05B851C1 = gettime();

    if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
      chopper _id_F336846A1669B218("bullet", damage);
      thread _id_417BA5F2D4D4D112("bullet", 0);
    } else {
      chopper _id_F336846A1669B218("explosive", damage);
      thread _id_417BA5F2D4D4D112("explosive", 0);
    }

    player thread _id_8012F6DC6C665F16(damage);
  }
}

_id_417BA5F2D4D4D112(type, _id_4FC7A28F98ADB334) {
  level endon("game_ended");

  if(!_id_FB6190FCD263559D()) {
    return;
  }
  lines = [];

  if(istrue(_id_4FC7A28F98ADB334)) {
    lines = ["dx_cp_cpes_shhl_hlp1_banshee12isgoingdown", "dx_cp_cpes_shhl_hlp1_12isgoingdown", "dx_cp_cpes_shhl_hlp1_wevelostpower12isgoi", "dx_cp_cpes_shhl_hlp1_12ishitwearegoingdow", "dx_cp_cpes_shhl_hlp1_braceforimpact"];
    _id_AC2C5AB094E31AF6 = ["dx_cp_cpes_shhl_lasw_11airsupportisdownyo", "dx_cp_cpes_shhl_lasw_11yourairsupportisof"];
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
    wait 1.5;
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_AC2C5AB094E31AF6));
    wait 2;

    if(isDefined(level._id_9D709E54566707E6))
      wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_BCA5E472447F8C73"));

    return;
  } else if(type == "rpg") {
    lines = ["dx_cp_cpes_shhl_lasw_breakertakeoutthatrp", "dx_cp_cpes_shhl_lasw_returnfireonthatrpg", "dx_cp_cpes_shhl_lasw_breakerthoserocketsc", "dx_cp_cpes_shhl_lasw_thoserocketswillleav", "dx_cp_cpes_shhl_lasw_returnfireonthoseene", "dx_cp_cpes_shhl_lasw_11keepyourairsupport", "dx_cp_cpes_shhl_lasw_followthesmoketrailt"];
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
    return;
  }

  if(!isDefined(level._id_1E0B7CD665818799))
    level._id_1E0B7CD665818799 = gettime();

  _id_EE982CFA69083107 = 20;

  if(gettime() - level._id_1E0B7CD665818799 <= _id_EE982CFA69083107 * 1000) {
    return;
  }
  level._id_1E0B7CD665818799 = gettime();

  if(type == "bullet")
    lines = ["dx_cp_cpes_shhl_hlp1_takingsmallarmsfire", "dx_cp_cpes_shhl_hlp1_takingfire_01", "dx_cp_cpes_shhl_hlp1_12istakingfire"];
  else if(type == "explosive")
    lines = ["dx_cp_cpes_shhl_hlp1_werehitwerehit", "dx_cp_cpes_shhl_hlp1_banshee12ishitwerehi", "dx_cp_cpes_shhl_hlp1_sonofabitchtheyretea", "dx_cp_cpes_shhl_hlp1_shitwehavecriticalda"];

  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
}

_id_F336846A1669B218(type, damage) {
  level._id_29BEC1F00993E687[type] = level._id_29BEC1F00993E687[type] + damage;
}

_id_8012F6DC6C665F16(damage) {
  if(istrue(self._id_3BDAE78A4302B30F)) {
    return;
  }
  self endon("death_or_disconnect");
  self._id_3BDAE78A4302B30F = 1;

  if(damage >= 300)
    thread _id_25845ACA699D038D::bloodoverlay(1, 5, 0.5);

  wait 2;
  self._id_3BDAE78A4302B30F = undefined;
}

_id_B8A7C0E3C804AACB(player, chopper) {
  level endon("game_ended");
  player endon("disconnect");
  level endon("stop_watching_chopper_lifecycle");
  chopper scripts\engine\utility::waittill_any_2("explode", "crashing");
  thread _id_417BA5F2D4D4D112("bullet", 1);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  player.shouldskipdeathsshield = 1;
  player.shouldskiplaststand = 1;
  player._id_A14C34F117DAF30A = 1;
  player unlink();
  player setOrigin(player._id_0C4F916881A2BFC0);
  player setclientomnvar("ui_hide_hud", 1);
  player notifyonplayercommandremove("fired_25mm", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "killstreak");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", player, "killstreak");
  level._id_B534B6EE2D5271D4 = 1;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(player.friendlytargetmarkergroup);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(player._id_2B883C6AA7EA98AC);
  waitframe();
  player setclientomnvar("ui_hide_hud", 0);
  player thread _id_6E899299D5C417AD(player);
  thread _id_05305096E603BFBB();
  wait 1.5;
  level thread chopper_respawn_timer(15);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0);
  wait 2;
  wait 15;
  _id_973F06F4FD9A6FB8();
  player.shouldskipdeathsshield = 0;
  player _id_644FA2AE4EBE0D3E(player);
  waitframe();
  player setOrigin(player._id_0C4F916881A2BFC0);

  while(!isalive(player))
    waitframe();

  player thread _id_853250DD0C223884(player);
  thread _id_868D4102A3805021();
}

_id_6E899299D5C417AD(pilot) {
  level endon("game_ended");
  pilot endon("death_or_disconnect");

  while(isalive(pilot)) {
    pilot dodamage(pilot.maxhealth + 100000, pilot.origin, pilot, undefined, "MOD_TRIGGER_HURT");
    waitframe();
  }
}

_id_B3FEAD76E9EBA8A2() {
  level endon("game_ended");
  lines = ["dx_cp_cpes_shhl_lasw_12isbackupforcloseai", "dx_cp_cpes_shhl_lasw_11airsupportisbackon", "dx_cp_cpes_shhl_lasw_12weaponsfreegettheg"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
}

_id_644FA2AE4EBE0D3E(player) {
  if(_id_0AFB7E332AEE4BF2::is_being_revived(player)) {
    return;
  }
  if(!isDefined(player) || !isent(player)) {
    return;
  }
  player.instant_revived = 1;
  player.instant_revive_buffer = 1;
  player notify("last_stand_finished");

  if(isDefined(player.reviveent))
    player.reviveent notify("last_stand_finished");
}

_id_05305096E603BFBB() {
  wait 1;

  foreach(player in level.players)
  player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/NEW_CHOPPER_COMING", 7);
}

chopper_respawn_timer(time) {
  level endon("game_ended");
  level endon("end_chopper_timer");
  self.timerstarttime = gettime();
  _id_A078D13EC42BEF78();

  for(;;) {
    _id_22BAC1FE6F3BA75D = self.timerstarttime + time * 1000;
    setomnvar("cp_auto_respawn_timer", _id_22BAC1FE6F3BA75D);
    wait 0.05;
  }
}

_id_A078D13EC42BEF78() {
  setomnvar("cp_team_respawn_display", 5);
}

_id_973F06F4FD9A6FB8() {
  level notify("end_chopper_timer");
  setomnvar("cp_team_respawn_display", 0);
}

_id_1E6C3C45C641021C(point, ent, radius) {
  level endon("game_ended");
  _id_5B64F4E84DCCCEE0(point, radius);

  for(;;) {
    player = level._id_9D709E54566707E6;

    if(getdvarint("dvar_5344780755F5902C", 0) > 0) {
      player = level.chopper_gunner;

      if(isDefined(player))
        player = level.chopper_gunner._id_1A92A51A600CEFCB;
    }

    if(!isDefined(player)) {
      wait 1;
      continue;
    }

    tracestart = player getEye();
    _id_3C70A7175FBFA3FC = player getplayerangles();
    _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
    _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 10000;
    results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, player, 0, 0, 0, 0, 0);
    _id_9595F9643C69A295 = results["entity"];

    if(isDefined(_id_9595F9643C69A295) && _id_9595F9643C69A295 == ent) {
      return;
    }
    wait 0.3;
  }
}

_id_462AFF2B6BF6ABDB(trigger) {
  level endon("game_ended");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isDefined(level._id_9D709E54566707E6) || player != level._id_9D709E54566707E6) {
      continue;
    }
    return;
  }
}

_id_5B64F4E84DCCCEE0(point, radius, _id_925BE0548554E3A0, _id_5B53918FF7675DE1, _id_7190656CB19ADC6B, _id_0DF2F39AFAB3B8B9) {
  level endon("game_ended");

  if(isDefined(_id_0DF2F39AFAB3B8B9))
    level endon(_id_0DF2F39AFAB3B8B9);

  if(!isDefined(_id_925BE0548554E3A0))
    _id_925BE0548554E3A0 = 1;

  for(;;) {
    player = level._id_9D709E54566707E6;

    if(getdvarint("dvar_5344780755F5902C", 0) > 0) {
      player = level.chopper_gunner;

      if(isDefined(player))
        player = level.chopper_gunner._id_1A92A51A600CEFCB;
    }

    if(!isDefined(player)) {
      wait 1;
      continue;
    }

    _id_49BE45F83BE0135E = 0;

    if(isDefined(player) && distance(player.origin, point) <= radius) {
      if(istrue(_id_925BE0548554E3A0))
        _id_49BE45F83BE0135E = 1;
      else {
        _id_088E380F714003A9 = 100;

        if(abs(player.origin[2] - point[2]) <= _id_088E380F714003A9)
          _id_49BE45F83BE0135E = 1;
      }
    }

    if(_id_49BE45F83BE0135E) {
      if(isDefined(_id_7190656CB19ADC6B))
        level notify(_id_7190656CB19ADC6B);

      return;
    }

    waitframe();
  }
}

_id_5B0C9451DDD7B1F0() {
  level endon("game_ended");
  _id_EFD95771163F3365 = scripts\engine\utility::getStruct("mine_proximity_marker", "script_noteworthy");

  if(!isDefined(_id_EFD95771163F3365)) {
    return;
  }
  level waittill("mission_intro_vo_done");
  _id_5B64F4E84DCCCEE0(_id_EFD95771163F3365.origin, _id_EFD95771163F3365.radius);

  while(scripts\engine\utility::flag("hills_important_vo_playing"))
    wait 1;

  lines = ["dx_cp_cpes_shhl_lasw_12hitthoseminesinthe", "dx_cp_cpes_shhl_lasw_12dropfireonthosemin", "dx_cp_cpes_shhl_lasw_12fireonthoseminesto", "dx_cp_cpes_shhl_lasw_12clearoutthosemines", "dx_cp_cpes_shhl_lasw_12helpyourteamcleart", "dx_cp_cpes_shhl_lasw_groundteamstandbyair", "dx_cp_cpes_shhl_lasw_12droproundsonthosem", "dx_cp_cpes_shhl_lasw_12droproundstodetona"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
}

_id_D5C017DF6CFE21D3(targetname) {
  if(!isDefined(level._id_1C93A3856E7E4B68))
    level._id_1C93A3856E7E4B68 = [];

  _id_602D16D6AB82D9E0 = scripts\engine\utility::getStructArray(targetname, "targetname");

  foreach(loc in _id_602D16D6AB82D9E0) {
    loc _id_4EED81006F8C8E25();
    wait 0.1;
  }
}

_id_4EED81006F8C8E25() {
  _id_E020078567E41613 = magicgrenademanual("at_mine_mp", self.origin + (0, 0, 100), (0, 0, 10));
  _id_E020078567E41613.owner = _id_E020078567E41613;
  _id_E020078567E41613.team = "axis";
  thread scripts\cp\equipment\cp_at_mine::at_mine_plant(_id_E020078567E41613);
  wait 1;
  _id_E020078567E41613 setscriptablepartstate("visibility", "show", 0);
  _id_E020078567E41613.weapon_object = makeweapon("at_mine_mp");
  wait 1;
  _id_E020078567E41613 thread _id_9FBE65BEDE503AF9(_id_E020078567E41613);
  level._id_1C93A3856E7E4B68[level._id_1C93A3856E7E4B68.size] = _id_E020078567E41613;
}

_id_F7E5243052A70491() {
  if(isDefined(level._id_1C93A3856E7E4B68)) {
    foreach(mine in level._id_1C93A3856E7E4B68) {
      if(isDefined(mine))
        mine delete();
    }
  }
}

_id_E4B8308D0A07398D(mine) {
  level endon("game_ended");
  _id_E3AC35F83FE23A46 = 100;
  _id_0468201688129220 = getclosestpointonnavmesh(mine.origin);
  navobstacle = createnavobstaclebybounds(_id_0468201688129220, (_id_E3AC35F83FE23A46, _id_E3AC35F83FE23A46, _id_E3AC35F83FE23A46), (0, 0, 0));
  mine waittill("death");
  destroynavobstacle(navobstacle);
}

_id_9FBE65BEDE503AF9(mine) {
  level endon("game_ended");
  wait 2;

  if(!isDefined(mine)) {
    return;
  }
  _id_9AF72BBDFDEACE5D = spawn("script_model", mine.origin + (0, 0, 5));
  _id_9AF72BBDFDEACE5D setModel("tag_origin");
  _id_9AF72BBDFDEACE5D.angles = scripts\engine\utility::ter_op(isDefined(_id_9AF72BBDFDEACE5D.angles), _id_9AF72BBDFDEACE5D.angles, (0, 0, 0));
  waitframe();
  fx = undefined;
  playFXOnTag(level._effect["mine_red_light"], _id_9AF72BBDFDEACE5D, "tag_origin");
  mine waittill("death");
  stopFXOnTag(level._effect["mine_red_light"], _id_9AF72BBDFDEACE5D, "tag_origin");
  _id_9AF72BBDFDEACE5D delete();
}

_id_07005281D71CEF20() {
  level endon("game_ended");
  level notify("single_watch_for_mine_explode_callouts");
  level endon("single_watch_for_mine_explode_callouts");
  lines = ["dx_cp_cpes_shhl_hlp1_headsupgroundteamsin", "dx_cp_cpes_shhl_hlp1_enemyminesintheroad", "dx_cp_cpes_shhl_hlp1_aqsplantedminesintha", "dx_cp_cpes_shhl_hlp1_allgunsyouareinproxi", "dx_cp_cpes_shhl_lasw_11stayclearofthosemi"];

  for(;;) {
    level waittill("at_mine_exploded_near_player");

    if(istrue(level._id_7BCA58EBC45C1D47) || istrue(level.isteamvoplaying) || scripts\engine\utility::flag("hills_important_vo_playing"))
      continue;
    else
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));

    wait 30;
  }
}

_id_4817BD03F8E1DAEF() {
  _id_962A30A9BB8C0F09 = level.vehicle.lighttank;
  _id_7347012BC49A4F59 = ["hills_tank", "hills_tank_loop", "house_tank", "gasstation_tank", "return_tank"];
  dropspawns = _id_962A30A9BB8C0F09.dropspawns;

  foreach(_id_838DCE3ED0A1A11C in _id_7347012BC49A4F59)
  dropspawns = scripts\cp\utility::array_merge(dropspawns, scripts\engine\utility::getStructArray(_id_838DCE3ED0A1A11C, "targetname"));

  _id_962A30A9BB8C0F09.dropspawns = dropspawns;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "filterDropSpawns"))
    _id_962A30A9BB8C0F09.dropspawns = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "filterDropSpawns")]](_id_962A30A9BB8C0F09.dropspawns);
}

spawn_enemy_tanks(targetname, loop) {
  if(getdvarint("dvar_ACF80FB3BAB1760E", 0) > 0) {
    return;
  }
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(targetname, "targetname");

  if(!isDefined(level.enemy_tanks))
    level.enemy_tanks = [];

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(isDefined(struct._id_061513667F818F8B))
      struct._id_061513667F818F8B delete();

    struct.model = "veh9_mil_lnd_tank";
    struct._id_F97A3D3FD021563B = 1;
    struct._id_90DC04DAC96D07ED = ::_id_D550DE35DF87D450;
    struct._id_2CE864BD06FB0385 = ::_id_47448E6203E3970D;
    struct._id_C38ADC61B2A4738E = ::_id_D83EC3E75447373D;
    struct._id_1AEA8EAACA8ADC25 = "iw9_tur_light_tank_mp";
    struct._id_379C00DC6E8F2235 = 3;
    struct._id_297E28A8CE9F0F97 = ::_id_FB03CA04A734713A;
    struct.spawnmethod = "place_at_position_unsafe";

    if(istrue(loop))
      struct._id_DD838ED8E5DC7123 = 1;

    tank = level scripts\cp\cp_enemy_tank::spawn_enemy_tank(struct);
    waitframe();
    tank.isactivated = 1;
    tank setCanDamage(1);
    wait(randomintrange(3, 7));
  }
}

_id_667562B6B52BDCC4() {
  _id_3B77CA060F09B517 = getEntArray("heli_escort_init_blockers", "script_noteworthy");
  marker = scripts\engine\utility::getStruct("hills_clonebrush_marker", "script_noteworthy");
  brush = scripts\engine\utility::getclosest(marker.origin, _id_3B77CA060F09B517, 512);
  _id_AB93D69209E4E7C0 = (-2511.67, 13532.8, 6403.18);

  if(isDefined(brush)) {
    collision = spawn("script_model", _id_AB93D69209E4E7C0);
    collision dontinterpolate();
    collision.angles = (0, 0, 0);
    collision clonebrushmodeltoscriptmodel(brush);
  }
}

_id_FB03CA04A734713A(tank) {
  body = spawn("script_model", tank.origin);
  body.angles = scripts\engine\utility::ter_op(isDefined(tank.angles), tank.angles, (0, 0, 0));
  turret = spawn("script_model", tank.origin);
  turret.angles = scripts\engine\utility::ter_op(isDefined(tank.angles), tank.angles, (0, 0, 0));
  body setModel("ee_debris_mil_lnd_tango72_body_dst_lm");
  turret setModel("ee_debris_mil_lnd_tango72_turret_dst_lm");
  _id_58A1456D94249CB1 = getEnt("care_package_col", "targetname");

  if(isDefined(_id_58A1456D94249CB1)) {
    collision = spawn("script_model", tank.origin);
    collision dontinterpolate();
    collision.angles = tank.angles;
    collision clonebrushmodeltoscriptmodel(_id_58A1456D94249CB1);
  }
}

_id_D550DE35DF87D450() {}

_id_A20CEF955B4C9801() {
  ent = self;
  level endon("game_ended");
  ent endon("death");

  while(!_id_FB6190FCD263559D()) {
    wait 1;
    continue;
  }

  if(!isDefined(level.chopper_gunner.enemytargetmarkergroup))
    level.chopper_gunner.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", level.chopper_gunner, ent, level.chopper_gunner);
  else
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent, level.chopper_gunner.enemytargetmarkergroup, 0);
}

_id_B29AA52E8C564367() {
  tank = self;
  tank endon("death");
  wait 5;

  for(;;) {
    players = [];

    if(_id_FB6190FCD263559D())
      players[players.size] = level.chopper_gunner._id_1A92A51A600CEFCB;

    if(_id_7E031905C49F9B9A())
      players[players.size] = level._id_9D709E54566707E6;

    _id_9118391A58B75D1F = self._id_1F7846011C111ECD gettagorigin("tag_flash");
    contents = scripts\engine\trace::create_all_contents();

    foreach(player in players) {
      _id_E83BA27C59314884 = scripts\engine\trace::ray_trace(_id_9118391A58B75D1F, player.origin, [self, self._id_1F7846011C111ECD], contents, 0, 1, 1);
      thread scripts\engine\trace::draw_trace(_id_E83BA27C59314884, (1, 0, 1), 1, 120);
    }

    wait 1;
  }
}

_id_D83EC3E75447373D() {
  tank = self;
  tank endon("death");
  thread _id_F708C971DB402388(self);

  for(;;) {
    _id_13BF80F34B682603 = tank _id_F82D01F0436956CA(1);

    if(!isDefined(_id_13BF80F34B682603)) {
      tank._id_1F7846011C111ECD cleartargetentity();
      tank.gunnerturret cleartargetentity();
      wait 0.1;
      continue;
    }

    if(_id_7E031905C49F9B9A() && _id_B0DB2C1FC0F80FA7(level._id_9D709E54566707E6))
      thread scripts\cp\cp_enemy_tank::tank_turret_get_target_and_fire(tank.gunnerturret, level._id_9D709E54566707E6);

    if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free"))
      scripts\engine\utility::flag_set("weapons_free");

    level notify("weapons_free");
    wait(randomfloatrange(1, 2));
  }
}

_id_F708C971DB402388(tank) {
  self endon("death");
  tank endon("death");
  turret = tank._id_1F7846011C111ECD;
  _id_FA2483033790AF38 = makeweapon("iw8_la_sidewinder_gs_medium");

  for(;;) {
    if(!_id_FB6190FCD263559D()) {
      wait 1;
      continue;
    }

    _id_13BF80F34B682603 = tank _id_F82D01F0436956CA(1);

    if(!isDefined(_id_13BF80F34B682603)) {
      turret cleartargetentity();
      wait 0.1;
      continue;
    }

    turret settargetentity(_id_13BF80F34B682603);
    _id_9118391A58B75D1F = turret gettagorigin("tag_flash");
    _id_3B08CCDEEC5500CB = 1;

    if(istrue(_id_3B08CCDEEC5500CB)) {
      self notify("locking_onto_chopper");
      waitframe();
      thread _id_393A6FE30CAB2027(_id_FA2483033790AF38, turret);

      while(!istrue(self._id_D0FCBCDCDC4C4345))
        waitframe();
    } else
      projectile = magicbullet(_id_FA2483033790AF38, _id_9118391A58B75D1F, _id_13BF80F34B682603.origin);

    wait(randomfloatrange(10, 11));
  }
}

_id_393A6FE30CAB2027(_id_FA2483033790AF38, turret) {
  self endon("death");
  self endon("damage");
  self endon("locking_onto_chopper");
  self endon("lost_target_lock");
  wait 1.3;
  level thread _id_4EC859E05D4290A7::_id_8DBBB045AE5B880B();
  wait 0.3;
  _id_6A8D944A59B4538D(_id_FA2483033790AF38, turret);
}

_id_6A8D944A59B4538D(_id_FA2483033790AF38, turret) {
  self._id_D0FCBCDCDC4C4345 = 1;
  self endon("death");

  if(!isDefined(level.chopper_gunner._id_1A92A51A600CEFCB)) {
    return;
  }
  _id_9118391A58B75D1F = turret gettagorigin("tag_flash");
  projectile = magicbullet(_id_FA2483033790AF38, _id_9118391A58B75D1F, level.chopper_gunner._id_1A92A51A600CEFCB.origin);
  wait 3;
  self._id_D0FCBCDCDC4C4345 = 0;
}

_id_697E013714C47E57(projectile, _id_3702CBA57F844507) {
  level endon("game_ended");
  projectile endon("death");
  wait(_id_3702CBA57F844507);
  projectile detonate();
}

_id_F82D01F0436956CA(_id_3FA0461E203F5795) {
  if(istrue(_id_3FA0461E203F5795)) {
    if(_id_7E031905C49F9B9A())
      return level._id_9D709E54566707E6;
    else if(_id_FB6190FCD263559D())
      return level.chopper_gunner._id_1A92A51A600CEFCB;
  } else if(_id_FB6190FCD263559D())
    return level.chopper_gunner._id_1A92A51A600CEFCB;
  else if(_id_7E031905C49F9B9A())
    return level._id_9D709E54566707E6;

  return undefined;
}

_id_B0DB2C1FC0F80FA7(player, maxdist) {
  if(!isDefined(player))
    return 0;

  if(isDefined(maxdist) && distance2d(self.origin, player.origin) > maxdist)
    return 0;

  _id_9118391A58B75D1F = self._id_1F7846011C111ECD gettagorigin("tag_flash");
  _id_752388878DCDAB77 = 0.9;
  contents = scripts\engine\trace::create_all_contents();
  trace = scripts\engine\trace::ray_trace(_id_9118391A58B75D1F, player.origin, [self, self._id_1F7846011C111ECD], contents, 0, 1, 1);

  if(isDefined(trace["entity"]) && trace["entity"] == player && trace["fraction"] >= _id_752388878DCDAB77)
    return 1;
  else
    return 0;
}

_id_847C79657B7ED227(data) {
  if(!isDefined(data.objweapon))
    return 0;

  return data.objweapon.basename == "chopper_gunner_proj_mp" || data.objweapon.classname == "rocketlauncher" || data.objweapon.basename == "chopper_gunner_turret_cp" || data.meansofdeath == "MOD_EXPLOSIVE" || data.meansofdeath == "MOD_GRENADE_SPLASH";
}

_id_47448E6203E3970D(data) {
  if(data.objweapon.basename == "iw8_la_sidewinder_gs_medium")
    data.damage = 0;
  else {
    if(!_id_847C79657B7ED227(data)) {
      _id_BC00864B4F27FCEE = isDefined(data.inflictor) && data.inflictor.classname == "grenade";

      if(!istrue(_id_BC00864B4F27FCEE))
        data.attacker thread _id_F3D832784180A9A9();

      data.damage = 0;
      return;
    }

    if(data.objweapon.basename == "chopper_gunner_proj_mp")
      data.damage = self.maxhealth / 5;

    self.lasttimedamaged = gettime();
  }
}

_id_F3D832784180A9A9() {
  self endon("death");
  self endon("disconnect");

  if(!isPlayer(self) || istrue(self._id_366CD29CF84CD70E)) {
    return;
  }
  self._id_366CD29CF84CD70E = 1;
  scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/ONLYEXPLOSIVES", 2);
  wait 2;
  self._id_366CD29CF84CD70E = undefined;
}

_id_9559969BDC0DF2DB() {
  level._id_56BAB1DE7ECC4D9C = [];
  level._id_56BAB1DE7ECC4D9C["monument"] = spawn("script_model", scripts\engine\utility::getStruct("monument_marker", "script_noteworthy").origin);
  level._id_56BAB1DE7ECC4D9C["house"] = spawn("script_model", scripts\engine\utility::getStruct("house_marker", "script_noteworthy").origin);
  level._id_56BAB1DE7ECC4D9C["gasstation"] = spawn("script_model", scripts\engine\utility::getStruct("gasstation_marker", "script_noteworthy").origin);
  level._id_56BAB1DE7ECC4D9C["culdesac"] = spawn("script_model", scripts\engine\utility::getStruct("culdesac_marker", "script_noteworthy").origin);
  level._id_56BAB1DE7ECC4D9C["monument"]._id_1FA568DF10F3260E = ["aa_monument_1", "aa_monument_2", "aa_monument_3"];
  level._id_56BAB1DE7ECC4D9C["house"]._id_1FA568DF10F3260E = ["aa_house_1", "aa_house_2", "aa_house_3"];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_1FA568DF10F3260E = ["aa_gasstation_1", "aa_gasstation_2", "aa_gasstation_3"];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_1FA568DF10F3260E = ["aa_culdesac_1", "aa_culdesac_2", "aa_culdesac_3"];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_F5FBD58C90F9FAC9 = ["ag_monument_1", "ag_monument_2", "ag_monument_3", "ag_monument_4"];
  level._id_56BAB1DE7ECC4D9C["house"]._id_F5FBD58C90F9FAC9 = ["ag_house_1", "ag_house_2", "ag_house_3"];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_F5FBD58C90F9FAC9 = ["ag_gasstation_1", "ag_gasstation_2", "ag_gasstation_3"];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_F5FBD58C90F9FAC9 = ["ag_culdesac_1", "ag_culdesac_2", "ag_culdesac_3"];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_1940D203101C0BF9 = ["ag_escape_house", "ag_escape_shack"];
  level._id_56BAB1DE7ECC4D9C["house"]._id_1940D203101C0BF9 = ["ag_escape_house", "ag_escape_shack"];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_1940D203101C0BF9 = ["ag_escape_gasstation", "ag_escape_gasstation2", "ag_escape_gasstation3"];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_1940D203101C0BF9 = ["ag_escape_culdesac1", "ag_escape_culdesac2"];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_EED8392B8FEE6290 = ["stinger_monument"];
  level._id_56BAB1DE7ECC4D9C["house"]._id_EED8392B8FEE6290 = ["stinger_house"];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_EED8392B8FEE6290 = ["stinger_gasstation"];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_EED8392B8FEE6290 = ["stinger_escape"];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_5C257F3915F937CA = [];
  level._id_56BAB1DE7ECC4D9C["house"]._id_5C257F3915F937CA = [];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_5C257F3915F937CA = [];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_5C257F3915F937CA = [];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_CB45278C0D50241C = [];
  level._id_56BAB1DE7ECC4D9C["house"]._id_CB45278C0D50241C = [];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_CB45278C0D50241C = [];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_CB45278C0D50241C = [];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_2656B0834E624AFA = [];
  level._id_56BAB1DE7ECC4D9C["house"]._id_2656B0834E624AFA = [];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_2656B0834E624AFA = [];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_2656B0834E624AFA = [];
  level._id_56BAB1DE7ECC4D9C["monument"]._id_2C0FADC4890E4BA4 = [];
  level._id_56BAB1DE7ECC4D9C["house"]._id_2C0FADC4890E4BA4 = [];
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_2C0FADC4890E4BA4 = [];
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_2C0FADC4890E4BA4 = [];
  level._id_56BAB1DE7ECC4D9C["monument"].name = "monument";
  level._id_56BAB1DE7ECC4D9C["house"].name = "house";
  level._id_56BAB1DE7ECC4D9C["gasstation"].name = "gasstation";
  level._id_56BAB1DE7ECC4D9C["culdesac"].name = "culdesac";
  level._id_56BAB1DE7ECC4D9C["monument"]._id_D2217D650E46F0F2 = 15;
  level._id_56BAB1DE7ECC4D9C["house"]._id_D2217D650E46F0F2 = 15;
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_D2217D650E46F0F2 = 10;
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_D2217D650E46F0F2 = 7;
  level._id_56BAB1DE7ECC4D9C["monument"]._id_783C60861D4DFE3C = scripts\engine\utility::getStructArray("house_ally_goal", "script_noteworthy");
  level._id_56BAB1DE7ECC4D9C["house"]._id_783C60861D4DFE3C = scripts\engine\utility::getStructArray("house_ally_goal", "script_noteworthy");
  level._id_56BAB1DE7ECC4D9C["gasstation"]._id_783C60861D4DFE3C = scripts\engine\utility::getStructArray("gasstation_ally_goal", "script_noteworthy");
  level._id_56BAB1DE7ECC4D9C["culdesac"]._id_783C60861D4DFE3C = scripts\engine\utility::getStructArray("culdesac_ally_goal", "script_noteworthy");
}

_id_733037996A1E86D1(_id_799015587FCDDA8F) {
  _id_09500F7593EECCC8 = _id_799015587FCDDA8F._id_EED8392B8FEE6290;
  _id_972A859C276DA843 = undefined;

  if(_id_09500F7593EECCC8.size > 0)
    _id_972A859C276DA843 = _id_09500F7593EECCC8[randomint(_id_09500F7593EECCC8.size)];

  return _id_972A859C276DA843;
}

_id_E19EA796C0F3083C(_id_799015587FCDDA8F, _id_65FAE0FAF76F5C4E) {
  _id_D446F708102173EC = _id_799015587FCDDA8F._id_5C257F3915F937CA;
  _id_E7CE9A7DEDE84AF6 = _id_799015587FCDDA8F._id_CB45278C0D50241C;
  _id_5E9B61E2EDD4B6A7 = _id_799015587FCDDA8F._id_2656B0834E624AFA;
  _id_972A859C276DA843 = "";

  if(istrue(_id_65FAE0FAF76F5C4E))
    _id_972A859C276DA843 = _id_E7CE9A7DEDE84AF6[randomint(_id_E7CE9A7DEDE84AF6.size)];
  else if(istrue(_id_E6D98B19400D050D()) && _id_5E9B61E2EDD4B6A7.size > 0)
    _id_972A859C276DA843 = _id_5E9B61E2EDD4B6A7[randomint(_id_5E9B61E2EDD4B6A7.size)];
  else if(_id_D446F708102173EC.size > 0)
    _id_972A859C276DA843 = _id_D446F708102173EC[randomint(_id_D446F708102173EC.size)];

  return _id_972A859C276DA843;
}

_id_58A07630FC80E92D() {
  _id_5634333FDFCEF66F = ["support_heli_monument", "support_heli_house", "support_heli_gasstaation", "support_heli_culdesac", "support_heli_escape"];

  foreach(obj in _id_5634333FDFCEF66F) {
    if(istrue(scripts\cp\cp_objectives::is_objective_active(obj)))
      return obj;
  }

  return undefined;
}

_id_E6D98B19400D050D() {
  return scripts\cp\cp_objectives::is_objective_active("support_heli_escape");
}

_id_566104D4A92E17D4() {
  return scripts\cp\cp_objectives::is_objective_active("support_heli_gasstaation") || scripts\cp\cp_objectives::is_objective_active("support_heli_blueroof") || scripts\cp\cp_objectives::is_objective_active("support_heli_culdesac") || scripts\cp\cp_objectives::is_objective_active("support_heli_escape");
}

_id_9E7A47DC3217CF72() {
  level endon("game_ended");
  level endon("stop_location_spawning");
  level notify("global_spawning_lulls_single_thread");
  level endon("global_spawning_lulls_single_thread");

  while(!istrue(_id_566104D4A92E17D4()))
    wait 2;

  level._id_B3BBFAA01606AE7B = 0;
  _id_D7E73180EFBC42D3 = gettime() + 30;

  for(;;) {
    if(gettime() >= _id_D7E73180EFBC42D3) {
      if(istrue(level._id_B3BBFAA01606AE7B)) {
        _id_D7E73180EFBC42D3 = gettime() + 30000;
        level._id_B3BBFAA01606AE7B = 0;
      } else {
        _id_D7E73180EFBC42D3 = gettime() + 50000;
        level._id_B3BBFAA01606AE7B = 1;
      }
    }

    wait 1;
  }
}

_id_18A18042AE39C368(player) {
  level endon("game_ended");
  level endon("stop_location_spawning");
  player waittill("disconnect");
  level._id_84688AD4A74AFA7B = 0;
}

_id_B8265CBEF2F13D0D() {
  level endon("game_ended");
  level endon("stop_location_spawning");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  if(istrue(level._id_84688AD4A74AFA7B)) {
    return;
  }
  level._id_84688AD4A74AFA7B = 1;
  scripts\engine\utility::flag_wait("hills_mi_spawners_initted");
  _id_0C134816A7914E32();
  _id_736A254FE30CB4B1 = isDefined(level._id_9D709E54566707E6);
  _id_A17F2BEA54C66581 = scripts\engine\utility::ter_op(istrue(_id_736A254FE30CB4B1), level._id_9D709E54566707E6, level.chopper_gunner);
  player = _id_A17F2BEA54C66581;
  level thread _id_18A18042AE39C368(player);
  player endon("disconnect");
  _id_6EF41B6A20C1BC2F = level._id_56BAB1DE7ECC4D9C["monument"];
  _id_3E1E924EEAA726D6(_id_6EF41B6A20C1BC2F);
  level thread _id_9E7A47DC3217CF72();
  level thread _id_5A3B2A42C7D1A736();

  for(;;) {
    if(istrue(level._id_B3BBFAA01606AE7B))
      wait 1;

    if(istrue(_id_736A254FE30CB4B1) && _id_7E031905C49F9B9A())
      _id_A79A645A016AAD25 = _id_CB6B6E0FE20B6AF7(player);
    else if(!istrue(_id_736A254FE30CB4B1) && _id_FB6190FCD263559D())
      _id_A79A645A016AAD25 = _id_CB6B6E0FE20B6AF7(level.chopper_gunner._id_1A92A51A600CEFCB);
    else
      _id_A79A645A016AAD25 = _id_6EF41B6A20C1BC2F;

    _id_3E1E924EEAA726D6(_id_6EF41B6A20C1BC2F);
    _id_3E1E924EEAA726D6(_id_A79A645A016AAD25);
    _id_6EF41B6A20C1BC2F = _id_A79A645A016AAD25;
    _id_8C54931B99866151 = int(3.0);
    _id_D6495EC0E7AD8B25 = [];
    _id_70FC9CE103BCD0C5 = scripts\engine\utility::ter_op(_id_FB6190FCD263559D(), int(_id_8C54931B99866151 / 3), 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8C54931B99866151 - _id_70FC9CE103BCD0C5; _id_AC0E594AC96AA3A8++)
      _id_D6495EC0E7AD8B25[_id_D6495EC0E7AD8B25.size] = _id_E19EA796C0F3083C(_id_6EF41B6A20C1BC2F, 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_70FC9CE103BCD0C5; _id_AC0E594AC96AA3A8++)
      _id_D6495EC0E7AD8B25[_id_D6495EC0E7AD8B25.size] = _id_E19EA796C0F3083C(_id_6EF41B6A20C1BC2F, 1);

    maxcount = level._id_FF77C4774821472C;
    _id_8B1185C8B0697456 = 0;

    foreach(spawngroup in _id_D6495EC0E7AD8B25) {
      _id_58F137A3CCDFFA5E = _id_18A73A64992DD07D::get_module_struct_from_level(spawngroup);
      _id_8A52520CE1A05C16 = _id_150A7ABD0622A853();
      _id_350FC69B17797361 = _id_58F137A3CCDFFA5E.totalspawns;

      if(maxcount - _id_8A52520CE1A05C16 >= _id_350FC69B17797361) {
        level thread _id_1366DD101ACDDCD3(spawngroup, _id_6EF41B6A20C1BC2F._id_D2217D650E46F0F2);
        waitframe();
        continue;
      }

      _id_8B1185C8B0697456 = 1;
    }

    if(istrue(_id_8B1185C8B0697456)) {
      wait 20;
      continue;
    }

    if(_id_E6D98B19400D050D()) {
      wait 6;
      continue;
    }

    if(_id_E6E081264B34C544()) {
      wait 6;
      continue;
    }

    wait(_id_6EF41B6A20C1BC2F._id_D2217D650E46F0F2);
  }
}

_id_150A7ABD0622A853() {
  _id_CD207438E3E764E6 = getaiarray("axis");
  aicount = 0;

  foreach(ai in _id_CD207438E3E764E6) {
    if(isalive(ai) && isDefined(ai.enemy_group) && _id_CB5D78E88C512012(ai.enemy_group))
      aicount++;
  }

  return aicount;
}

_id_CB5D78E88C512012(enemy_group) {
  if(enemy_group == "")
    return 0;

  _id_7EE250310F30FEBD = enemy_group[enemy_group.size - 1];
  _id_98F11B043F32F9FF = ["1", "2", "3", "4", "5", "6"];
  return istrue(scripts\engine\utility::array_contains(_id_98F11B043F32F9FF, _id_7EE250310F30FEBD));
}

_id_5A3B2A42C7D1A736() {
  level endon("game_ended");
  level endon("stop_location_spawning");
  level notify("single_stinger_spawn_loop");
  level endon("single_stinger_spawn_loop");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  scripts\engine\utility::flag_wait("hills_mi_spawners_initted");
  _id_0C134816A7914E32();

  while(!isDefined(level.chopper_gunner))
    waitframe();

  player = level.chopper_gunner;
  player endon("disconnect");
  _id_6EF41B6A20C1BC2F = level._id_56BAB1DE7ECC4D9C["monument"];

  if(istrue(level._id_B3BBFAA01606AE7B) || !_id_FB6190FCD263559D())
    wait 1;

  wait 12;

  for(;;) {
    if(istrue(level._id_B3BBFAA01606AE7B) || !_id_FB6190FCD263559D()) {
      wait 1;
      continue;
    }

    _id_6EF41B6A20C1BC2F = _id_CB6B6E0FE20B6AF7(level.chopper_gunner._id_1A92A51A600CEFCB);
    spawngroup = _id_733037996A1E86D1(_id_6EF41B6A20C1BC2F);
    _id_58F137A3CCDFFA5E = _id_18A73A64992DD07D::get_module_struct_from_level(spawngroup);
    _id_8A52520CE1A05C16 = getaiarray("axis").size;
    _id_350FC69B17797361 = _id_58F137A3CCDFFA5E.totalspawns;
    maxcount = level._id_FF77C4774821472C;

    if(maxcount - _id_8A52520CE1A05C16 >= _id_350FC69B17797361) {
      level thread _id_1366DD101ACDDCD3(spawngroup, _id_6EF41B6A20C1BC2F._id_D2217D650E46F0F2);
      waitframe();
    }

    if(_id_E6D98B19400D050D()) {
      wait 10;
      continue;
    }

    wait 30;
  }
}

_id_1366DD101ACDDCD3(_id_3E2A73CF57C32C7C, _id_2695272BAD5F6186) {
  level endon("game_ended");
  level thread _id_18A73A64992DD07D::run_spawn_module(_id_3E2A73CF57C32C7C);
  wait(_id_2695272BAD5F6186);
  level thread _id_18A73A64992DD07D::stop_module_by_groupname(_id_3E2A73CF57C32C7C, 1);
}

_id_3E1E924EEAA726D6(_id_EEE21F761B034CE7, _id_C4A0ACDB397AA3EE, _id_40BEBC6BA8DCAD7C) {
  if(!isDefined(_id_C4A0ACDB397AA3EE))
    _id_C4A0ACDB397AA3EE = 1;

  if(!isDefined(_id_40BEBC6BA8DCAD7C))
    _id_40BEBC6BA8DCAD7C = 1;

  if(istrue(_id_C4A0ACDB397AA3EE)) {
    _id_EEE21F761B034CE7._id_5C257F3915F937CA = _id_EEE21F761B034CE7._id_F5FBD58C90F9FAC9;
    _id_EEE21F761B034CE7._id_2656B0834E624AFA = _id_EEE21F761B034CE7._id_1940D203101C0BF9;
  }

  if(istrue(_id_C4A0ACDB397AA3EE))
    _id_EEE21F761B034CE7._id_CB45278C0D50241C = _id_EEE21F761B034CE7._id_1FA568DF10F3260E;
}

_id_CB6B6E0FE20B6AF7(player) {
  return scripts\engine\utility::getclosest(player.origin, level._id_56BAB1DE7ECC4D9C);
}

_id_71888E52CCF305B0() {
  level endon("game_ended");
  player = level.chopper_gunner;
  player endon("disconnect");
  player endon("death");

  if(istrue(level._id_20764A3B824FAA83)) {
    return;
  }
  _id_421681406E479DAF = scripts\engine\utility::getStruct("intel_door", "script_noteworthy");
  _id_7BBFBA27ED088E3B = undefined;

  if(isDefined(_id_421681406E479DAF))
    _id_7BBFBA27ED088E3B = _id_421681406E479DAF.origin;
  else
    _id_7BBFBA27ED088E3B = (-1115.75, 9903.25, 4733.25);

  _id_887438C3B4B194B6(1, _id_7BBFBA27ED088E3B);

  for(;;) {
    player waittill("gunner_turret_impact", position);

    if(distance2d(position, _id_7BBFBA27ED088E3B) <= 100) {
      level._id_20764A3B824FAA83 = 1;
      thread _id_887438C3B4B194B6(0, _id_7BBFBA27ED088E3B);
      return;
    }
  }
}

_id_07253F9BC526B00D() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(!_id_FB6190FCD263559D()) {
      wait 1;
      continue;
    }

    player = level.chopper_gunner;
    chopper = level.chopper_gunner._id_1A92A51A600CEFCB;
    player waittill("gunner_turret_impact", position);

    if(distancesquared(position, self.origin) <= 65536)
      self notify("detonateExplosive", chopper);

    waitframe();
  }
}

_id_390C7142F8505232(_id_5BC3D67FD90EC10D) {
  level endon("game_ended");

  if(istrue(_id_5BC3D67FD90EC10D._id_3BB7A59939480F9D)) {
    return;
  }
  wait 3;
  _id_AD0C7D143A055484 = level.chopper_gunner;

  if(!isDefined(_id_AD0C7D143A055484)) {
    return;
  }
  chopper = _id_AD0C7D143A055484._id_1A92A51A600CEFCB;
  _id_AD0C7D143A055484 endon("disconnect");
  chopper endon("death");

  for(;;) {
    if(!isDefined(chopper)) {
      wait 1;
      continue;
    }

    chopper waittill("fired_missile", missile);
    waitframe();
    missile waittill("explode", position);

    if(distance(position, _id_5BC3D67FD90EC10D.origin) <= 256) {
      _id_5BC3D67FD90EC10D._id_3BB7A59939480F9D = 1;
      _id_C92D9B66628A2D3F(0, _id_5BC3D67FD90EC10D.origin);

      if(isDefined(_id_5BC3D67FD90EC10D.objective_id)) {
        objective_delete(_id_5BC3D67FD90EC10D.objective_id);
        scripts\cp\cp_objectives::freeworldid("doorbreach_" + _id_5BC3D67FD90EC10D.index);
        _id_5BC3D67FD90EC10D.objective_id = undefined;
      }

      return;
    }
  }
}

_id_51034ED216A9DCD4() {
  _id_27CDEDDE15834909 = scripts\engine\utility::getStructArray("blocked_door", "script_noteworthy");

  foreach(loc in _id_27CDEDDE15834909)
  loc thread _id_390C7142F8505232(loc);
}

_id_C92D9B66628A2D3F(closed, pos) {
  _id_2A140C28069BB952 = ["scriptable_door_wooden_panel_mp_01", "scriptable_ee_door_wooden_entrance_01", "scriptable_door_wooden_hollow_mp_01", "scriptable_door_metal_04_flat_painted_mp_tan", "scriptable_door_wood_ornate_01_green_double_r", "scriptable_door_wood_ornate_01_green_double_l"];
  _id_786FD7C325A6D910 = [];

  foreach(doortype in _id_2A140C28069BB952)
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, getentitylessscriptablearray("scriptable_" + doortype, "classname", pos, 256));

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor()) {
      if(closed) {
        timeout = 0;
        _id_26BAEFB3804B52C3 scriptabledoorclose();

        while(!_id_26BAEFB3804B52C3 scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
        continue;
      }

      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);
      _id_26BAEFB3804B52C3 scriptabledooropen("away", pos);
    }
  }
}

_id_CA842817190B441A(eattacker, idamage, smeansofdeath, sweapon, shitloc, victim) {
  if(!isai(victim))
    return 0;

  if(istrue(victim.magic_bullet_shield))
    return 0;

  return 1;
}

_id_057D85DBFBD24236() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(!isalive(self))
      waitframe();

    level._id_9149AA09E5534D8B = _id_7C2D0E47D44A53A6();
    level._id_E8A53778EB5C127D = _id_F0772B50FC376504();
    waitframe();
  }
}

_id_7C2D0E47D44A53A6() {
  tracestart = self getEye();
  _id_3C70A7175FBFA3FC = self getplayerangles();
  _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 10000;
  results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, self, 0, 0, 0, 0, 0);
  _id_9595F9643C69A295 = results["entity"];

  if(isDefined(_id_9595F9643C69A295) && issentient(_id_9595F9643C69A295) && !isPlayer(_id_9595F9643C69A295)) {
    if(isDefined(_id_9595F9643C69A295.team) && _id_9595F9643C69A295.team == self.team && isDefined(_id_9595F9643C69A295.entity_number)) {
      self setclientomnvar("ui_target_entity_num", _id_9595F9643C69A295.entity_number);
      return _id_9595F9643C69A295.entity_number;
    }
  }

  self setclientomnvar("ui_target_entity_num", -1);
  return -1;
}

_id_F0772B50FC376504() {
  tracestart = self getEye();
  _id_3C70A7175FBFA3FC = self getplayerangles();
  _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 10000;
  results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, self, 0, 0, 0, 0, 0);
  _id_9595F9643C69A295 = results["entity"];

  if(isDefined(_id_9595F9643C69A295) && issentient(_id_9595F9643C69A295) && !isPlayer(_id_9595F9643C69A295)) {
    if(isDefined(_id_9595F9643C69A295.team) && _id_9595F9643C69A295.team == self.team) {
      _id_83DAC78C767951B5 = _id_EC4BBA595B3AF91E(_id_9595F9643C69A295);
      self setclientomnvar("ui_target_name_index", _id_83DAC78C767951B5);
      return _id_9595F9643C69A295.name;
    }
  }

  return undefined;
}

_id_EC4BBA595B3AF91E(_id_9595F9643C69A295) {
  index = -1;
  _id_AC0E594AC96AA3A8 = 0;

  foreach(_id_9CAA3D289889DDE4 in level._id_CB71FB22BE469134) {
    if(isDefined(_id_9595F9643C69A295.name) && _id_9CAA3D289889DDE4 == _id_9595F9643C69A295.name) {
      index = _id_AC0E594AC96AA3A8;
      return index;
    }

    _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1;
  }

  return index;
}

_id_FD30C9F0460FC6AE(player, chopper) {
  level endon("game_ended");
  level endon("game_over_sequence_started");
  chopper endon("death");
  player endon("death");
  player notify("single_monitor_chopper_damage_indicators");
  player endon("single_monitor_chopper_damage_indicators");

  for(;;) {
    chopper waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, shitloc, partname, idflags, sweapon, origin, angles, normal, einflictor);
    _id_90D06984580A3902 = chopper.origin[0] - player.origin[0];
    _id_90D06A84580A3B35 = chopper.origin[1] - player.origin[1];
    _id_58857A75C610E24D = vpoint;
    _id_F4DE64E7E1762529[0] = vpoint[0] - _id_90D06984580A3902;
    _id_F4DE64E7E1762529[1] = vpoint[1] - _id_90D06A84580A3B35;

    if(!isDefined(partname))
      partname = "tag_origin";

    if(!isDefined(idflags))
      idflags = 0;

    if(isDefined(sweapon))
      player finishplayerdamage(einflictor, eattacker, 1, idflags, smeansofdeath, sweapon, _id_58857A75C610E24D, vdir, 0, 0, 0, 0, partname, 1);

    waitframe();

    if(player.health < player.maxhealth)
      player.health++;
  }
}

_id_98B9E84FD7E56B39() {
  player = self;
  _id_2622298F62890966 = player getweaponslistprimaries();

  foreach(weapon in _id_2622298F62890966) {
    self setweaponammoclip(weapon, weaponclipsize(weapon));
    self setweaponammostock(weapon, scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon));
    _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
  }

  _id_7EF95BBA57DC4B82::_id_1AB06E1478168800();
}

_id_369DE7D81BAC0F1D(chopper) {
  chopper endon("death");
  level endon("game_ended");
  level notify("chopper_beeps_single_thread");
  level endon("chopper_beeps_single_thread");

  for(;;) {
    if(chopper.health > chopper.maxhealth / 4 || !_id_FB6190FCD263559D()) {
      wait 2;
      continue;
    }

    _id_F7DD536EB8B3D570 = 0.5;

    if(!soundexists("breach_warning_beep_01")) {
      return;
    }
    level.chopper_gunner playsoundtoplayer("breach_warning_beep_01", level.chopper_gunner);
    wait(_id_F7DD536EB8B3D570);
  }
}

_id_7B3CA8860EB6C4FC(chopper) {
  chopper endon("death");
  level endon("game_ended");
  level notify("chopper_lhwarning_single_thread");
  level endon("chopper_lhwarning_single_thread");

  for(;;) {
    if(chopper.health > chopper.maxhealth / 4 || !_id_FB6190FCD263559D()) {
      wait 2;
      continue;
    }

    break;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", chopper.owner, "killstreak");
}

_id_0D9C1A4DD2B3C2EC() {
  allies = level._id_3009A6A54E094536;

  if(!isDefined(allies)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_3009A6A54E094536.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(allies[_id_AC0E594AC96AA3A8] && !istrue(allies[_id_AC0E594AC96AA3A8].magic_bullet_shield)))
      allies[_id_AC0E594AC96AA3A8] dodamage(900, allies[_id_AC0E594AC96AA3A8].origin);
  }
}

_id_39B652C93829B527() {
  if(!isDefined(level._id_3009A6A54E094536))
    return (0, 0, 0);

  _id_4084C1D43F28940F = scripts\engine\utility::random(level._id_3009A6A54E094536);

  if(isDefined(_id_4084C1D43F28940F))
    return _id_4084C1D43F28940F.origin;
  else
    return (0, 0, 0);
}

_id_F654D9CCFD39E1AA() {
  level endon("game_ended");
  allies = level._id_3009A6A54E094536;

  if(!isDefined(allies)) {
    return;
  }
  while(istrue(level._id_7BCA58EBC45C1D47) || istrue(level.isteamvoplaying))
    wait 1;

  _id_25A9244766641CE2 = allies.size;

  switch (_id_25A9244766641CE2) {
    case 3:
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc3_ohfuck");
      wait 0.2;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc2_eric");
      wait 0.1;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc4_motherfucker");
      wait 0.4;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc1_wegotacasualty");
      wait 0.1;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc1_mandown");
      wait 1;
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_werelosingshooterswe");
      wait 2;
      break;
    case 2:
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc4_contact");
      wait 0.3;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc2_trey");
      wait 0.5;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc1_wegotacasualty_01");
      wait 2;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shof_pmc1_mandown_01");
      wait 3;
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shof_lasw_breaker1yourelosings");
      break;
    case 1:
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shmk_pmc2_imhit");
      wait 0.3;
      level thread scripts\cp\utility::playsoundatpos_safe(_id_39B652C93829B527(), "dx_cp_cpes_shmk_pmc1_geoff");
      wait 3;
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_shmk_pmc1_mandown", "dx_cp_cpes_shmk_pmc1_weretakingcasualties"]));
      break;
    default:
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_shmk_pmc1_takingcontact", "dx_cp_cpes_shmk_pmc1_ohfuck", "dx_cp_cpes_shmk_pmc1_motherfucker"]));

      if(_id_FB6190FCD263559D())
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_FC10CE08437AEECD"));

      lines = ["dx_cp_cpes_shmk_lasw_werenotgonnaletthemd", "dx_cp_cpes_shmk_lasw_theyshedbloodforthis"];
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
      wait 1.5;
      break;
  }
}

_id_5AA35CEA1874FE3A(_id_FCA1EFC6C5FEA87C) {
  level endon("game_ended");
  allies = level._id_3009A6A54E094536;

  if(!isDefined(allies)) {
    return;
  }
  _id_DED0C3D1434DA178 = 0;

  if(_id_FCA1EFC6C5FEA87C > level._id_3009A6A54E094536.size)
    _id_FCA1EFC6C5FEA87C = level._id_3009A6A54E094536.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_3009A6A54E094536.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(allies[_id_AC0E594AC96AA3A8].magic_bullet_shield)) {
      _id_DED0C3D1434DA178++;
      allies[_id_AC0E594AC96AA3A8] scripts\common\ai::stop_magic_bullet_shield();
      allies[_id_AC0E594AC96AA3A8].invulnerable = undefined;
      allies[_id_AC0E594AC96AA3A8]._id_1EC812B92A31CDD3 = undefined;
      allies[_id_AC0E594AC96AA3A8].maxhealth = 100;
      allies[_id_AC0E594AC96AA3A8].health = 5;
      _id_8FDE386D4BE381AE(allies[_id_AC0E594AC96AA3A8]);
    } else
      _id_DED0C3D1434DA178++;

    if(_id_DED0C3D1434DA178 >= _id_FCA1EFC6C5FEA87C) {
      return;
    }
    wait 2;
  }
}

_id_8FDE386D4BE381AE(ally) {
  level endon("game_ended");
  wait(randomintrange(10, 30));
  ally dodamage(999, ally.origin, ally);
}

_id_B708B4E0781BCB90(location) {
  _id_F0D286D6DAD77AAD = scripts\engine\utility::getStruct("hills_selfrevive_" + location, "script_noteworthy");

  if(isDefined(_id_F0D286D6DAD77AAD)) {
    _id_F0D286D6DAD77AAD.angles = scripts\engine\utility::ter_op(isDefined(_id_F0D286D6DAD77AAD.angles), _id_F0D286D6DAD77AAD.angles, (0, 0, 0));
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(_id_F0D286D6DAD77AAD.origin, _id_F0D286D6DAD77AAD.angles);
    player = level.players[0];
    _id_0D05AB15E99D41D9 = _id_66122A002AFF5D57::spawnpickup("brloot_self_revive", _id_CB4FAD49263E20C4, 1, 1);
  }
}

_id_2A7CEBC730ABE77A(location) {
  _id_A2F87793F0A25C06 = scripts\engine\utility::getStructArray("hills_armor_" + location, "script_noteworthy");

  foreach(_id_0D87FBB7F6E0E991 in _id_A2F87793F0A25C06) {
    _id_0D87FBB7F6E0E991.angles = scripts\engine\utility::ter_op(isDefined(_id_0D87FBB7F6E0E991.angles), _id_0D87FBB7F6E0E991.angles, (0, 0, 0));
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(_id_0D87FBB7F6E0E991.origin, _id_0D87FBB7F6E0E991.angles);
    _id_29BED75FB4428CD5 = _id_66122A002AFF5D57::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4);
  }
}

_id_F814B0A9C4E7CEBB(struct) {
  level endon("game_ended");
  model = spawn("script_model", struct.origin);
  model setModel("tag_origin");
  model.headicon = createheadicon(model);
  setheadiconimage(model.headicon, "hud_icon_killstreak_chopper_support");
  setheadiconsnaptoedges(model.headicon, 0);
  setheadiconmaxdistance(model.headicon, 1024);
  setheadiconnaturaldistance(model.headicon, 30);
  setheadiconzoffset(model.headicon, 10);
  model makeusable();
  model setHintString(&"CP_HILLS_MI/PICK_CHOPPER");
  model setCursorHint("HINT_BUTTON");
  model sethintdisplayrange(200);
  model sethintdisplayfov(90);
  model setuserange(72);
  model setusefov(90);
  model sethintonobstruction("show");
  model setuseholdduration("duration_short");

  for(;;) {
    model waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    model _meth_DFB78B3E724AD620(0);

    if(!isDefined(player._id_AC19F9B9C6C841B9) && !_id_F08445D722105387("chopper")) {
      player._id_AC19F9B9C6C841B9 = "chopper";
      player playlocalsound("cp_heli_esc_role_select");
      wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_8C3EE5893C1EE640"));
      wait 1;
      _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_12isairsupport");
      wait 1.5;
      player thread _id_853250DD0C223884(player);
      model setHintString(&"CP_HILLS_MI/RELEASE_CHOPPER");
    } else if(isDefined(player._id_AC19F9B9C6C841B9) && player._id_AC19F9B9C6C841B9 != "chopper") {
      player playlocalsound("cp_heli_esc_role_deny");
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/RESCIND_FIRST", 2);
    } else if(!isDefined(player._id_AC19F9B9C6C841B9) && _id_F08445D722105387("chopper")) {
      player playlocalsound("cp_heli_esc_role_deny");
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/ROLE_ALREADY_PICKED", 2);
    } else {
      player notify("rescinded_chopper_role");
      player._id_AC19F9B9C6C841B9 = undefined;
      player playlocalsound("cp_heli_esc_role_rescind");
      model setHintString(&"CP_HILLS_MI/PICK_CHOPPER");
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/CHOPPER_RESCINDED", 2);
    }

    wait 3;
    model _meth_DFB78B3E724AD620(1);
  }
}

_id_22304B4B146CEB88(_id_47E569777F8BB300) {
  _id_E0BEA36347BB5650 = _id_0AFB7E332AEE4BF2::everyone_else_all_in_laststand(_id_47E569777F8BB300);

  if(istrue(_id_E0BEA36347BB5650)) {
    _id_0C343D2C624504B6();
    return 1;
  } else
    return 0;
}

_id_0C343D2C624504B6() {
  level endon("game_ended");

  if(istrue(level._id_6630B696E81130ED)) {
    return;
  }
  level._id_6630B696E81130ED = 1;

  foreach(player in level.players)
  player.disable_health_regen = 1;

  level notify("game_over_sequence_started");
  lines = ["dx_cp_cpes_shhl_lasw_groundteamisdownmiss", "dx_cp_cpes_shhl_lasw_11iskiamissionfailed", "dx_cp_cpes_shhl_lasw_welost11itsover"];
  thread _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
  wait 3;
  _id_C7F2052CD75FD495();

  foreach(player in level.players)
  level thread endgame_camera(player);

  _id_450F1EB13B0AC99F();
}

_id_B854975D945B6D67() {
  lines = ["dx_cp_cpes_shhl_lasw_groundteamisdownmiss", "dx_cp_cpes_shhl_lasw_11iskiamissionfailed", "dx_cp_cpes_shhl_lasw_welost11itsover"];
  thread _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
  wait 3;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_F08445D722105387(role) {
  foreach(player in level.players) {
    if(isDefined(player._id_AC19F9B9C6C841B9) && player._id_AC19F9B9C6C841B9 == role)
      return 1;
  }

  return 0;
}

_id_BB5B415F5461948D(struct) {
  level endon("game_ended");
  model = spawn("script_model", struct.origin);
  model setModel("tag_origin");
  model makeusable();
  model setHintString(&"CP_HILLS_MI/PICK_GROUND");
  model setCursorHint("HINT_BUTTON");
  model sethintdisplayrange(200);
  model sethintdisplayfov(90);
  model setuserange(72);
  model setusefov(90);
  model sethintonobstruction("show");
  model setuseholdduration("duration_short");
  model.headicon = createheadicon(model);
  setheadiconimage(model.headicon, "hud_icon_loadout_specialist");
  setheadiconsnaptoedges(model.headicon, 0);
  setheadiconmaxdistance(model.headicon, 1024);
  setheadiconnaturaldistance(model.headicon, 30);
  setheadiconzoffset(model.headicon, 10);

  for(;;) {
    model waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    model _meth_DFB78B3E724AD620(0);

    if(!isDefined(player._id_AC19F9B9C6C841B9) && !_id_F08445D722105387("ground")) {
      player._id_AC19F9B9C6C841B9 = "ground";
      player playlocalsound("cp_heli_esc_role_select");
      wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_A28675F4D0958451"));

      if(randomint(2) > 0) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BA319E2ACFE6AC4C"));
        wait 1;
        _id_D28BB110565C9670 = ["dx_cp_cpes_shfb_pmc1_copythatgotyoucovere", "dx_cp_cpes_shfb_pmc1_copythatgamefacesonp"];
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_11istheraidelement");
        wait 1;
      } else {
        wait 1;
        _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shfb_lasw_11istheraidelement");
        wait 1;
      }

      player thread _id_A5F72F6250E7F165(player);
      model setHintString(&"CP_HILLS_MI/RELEASE_GROUND");
    } else if(isDefined(player._id_AC19F9B9C6C841B9) && player._id_AC19F9B9C6C841B9 != "ground") {
      player playlocalsound("cp_heli_esc_role_deny");
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/RESCIND_FIRST", 2);
    } else if(!isDefined(player._id_AC19F9B9C6C841B9) && _id_F08445D722105387("ground")) {
      player playlocalsound("cp_heli_esc_role_deny");
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/ROLE_ALREADY_PICKED", 2);
    } else {
      player notify("rescinded_ground_role");
      player._id_AC19F9B9C6C841B9 = undefined;
      player playlocalsound("cp_heli_esc_role_rescind");
      model setHintString(&"CP_HILLS_MI/PICK_GROUND");
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/GROUND_RESCINDED", 2);
    }

    wait 3;
    model _meth_DFB78B3E724AD620(1);
  }
}

_id_9B2F0ED66B9CE35B() {
  if(istrue(level._id_102FD3491CDFC22C)) {
    return;
  }
  level._id_102FD3491CDFC22C = 1;
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("dvar_16C27BD9C165F4D6")) {
    return;
  }
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical"]);
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["silencer", "reddot"]);
  _id_CDE2EE78F52F055F = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_lm_kilo21_mp");
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00("belt_lm_large");
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_large", "stock_sm_light"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_xlarge", "stock_sm_heavy"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "ub_"]);
  _id_F90ED803365EBC3E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("rpapa7");
  weapons = [_id_CDE2EC78F52F00F9, _id_CDE2E978F52EFA60, _id_CDE2EA78F52EFC93, _id_CDE2EF78F52F0792, _id_CDE2F078F52F09C5, _id_CDE2ED78F52F032C, _id_CDE2EE78F52F055F, _id_CDE2F378F52F105E, _id_CDE2F478F52F1291, _id_F90ED703365EBA0B, _id_F90ED603365EB7D8, _id_F90ED903365EBE71, _id_F90ED803365EBC3E];
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("start_weapon", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "weapon_wm_ar_mike4_brprop":
        weapon_object = _id_CDE2EC78F52F00F9;
        break;
      case "weapon_wm_sn_sbeta_brprop":
        weapon_object = _id_CDE2E978F52EFA60;
        break;
      case "weapon_wm_sn_mike14_brprop":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "weapon_wm_sn_alpha50_brprop":
        weapon_object = _id_CDE2EF78F52F0792;
        break;
      case "weapon_wm_ar_akilo47_brprop":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "weapon_wm_pi_mike1911_brprop":
        weapon_object = _id_CDE2ED78F52F032C;
        break;
      case "weapon_wm_lm_kilo121_brprop":
        weapon_object = _id_CDE2EE78F52F055F;
        break;
      case "weapon_wm_sm_mpapa5_brprop":
        weapon_object = _id_CDE2F378F52F105E;
        break;
      case "weapon_wm_sm_beta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sh_charlie725_brprop":
        weapon_object = _id_F90ED703365EBA0B;
        break;
      case "weapon_wm_sm_mpapa7_brprop":
        weapon_object = _id_F90ED603365EB7D8;
        break;
      case "weapon_wm_ar_kilo433_brprop":
        weapon_object = _id_F90ED903365EBE71;
        break;
      case "weapon_wm_la_rpapa7":
        weapon_object = _id_F90ED803365EBC3E;
        break;
    }

    if(isDefined(weapon_object)) {
      _id_28A6B68460F4FD6B _id_2531C3CE4182E7AA(undefined, weapon_object);
      continue;
    }
  }
}

_id_2531C3CE4182E7AA(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  if(getdvarint("dvar_BAC49DC689DDA280", 0)) {
    weapon = _id_66122A002AFF5D57::createspawnweaponatpos(self.origin + (12, 0, 0), self.angles + (0, 0, -90), objweapon, 1);

    if(isDefined(weapon)) {
      weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
      weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
      return weapon;
    }
  }

  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06();
  return _id_B8F5AC23CE0DFDE3;
}

_id_7BED63E134C9AE06() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player))
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(self);
  }
}

_id_8AD91A6FF3CB527A(org, _id_C5A5F99C1F13A6DA) {
  if(_id_C5A5F99C1F13A6DA.size <= 0)
    return undefined;

  _id_0DA9D76F5A9B4145 = _id_C5A5F99C1F13A6DA[0];

  if(_id_C5A5F99C1F13A6DA.size == 1)
    return _id_0DA9D76F5A9B4145;

  _id_42CA41C7DADAE0C0 = distance(org, _id_0DA9D76F5A9B4145.origin);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_C5A5F99C1F13A6DA.size; _id_AC0E594AC96AA3A8++) {
    if(distance(org, _id_C5A5F99C1F13A6DA[_id_AC0E594AC96AA3A8].origin) < _id_42CA41C7DADAE0C0) {
      _id_0DA9D76F5A9B4145 = _id_C5A5F99C1F13A6DA[_id_AC0E594AC96AA3A8];
      _id_42CA41C7DADAE0C0 = distance(org, _id_C5A5F99C1F13A6DA[_id_AC0E594AC96AA3A8].origin);
    }
  }

  return _id_0DA9D76F5A9B4145;
}

_id_A0B7EBEEA70BC3C2() {
  _id_B6C5C558B074A2D7 = scripts\engine\utility::getStructArray("hills_startarea_dummy_ally", "script_noteworthy");
  _id_A5D6F8F39DF53247 = ["dx_cp_cpes_shfb_pmc1_checkyourfire", "dx_cp_cpes_shfb_pmc1_watchyourfire", "dx_cp_cpes_shfb_pmc1_checkfirecheckfire"];
  _id_A4365188C5354890 = ["dx_cp_cpes_shfb_pmc2_checkyourfire", "dx_cp_cpes_shfb_pmc2_watchyourfire", "dx_cp_cpes_shfb_pmc2_checkfirecheckfire"];
  _id_F23BE7BDC2EDD369 = ["dx_cp_cpes_shfb_pmc3_checkyourfire", "dx_cp_cpes_shfb_pmc3_watchyourfire", "dx_cp_cpes_shfb_pmc3_checkfirecheckfire"];
  _id_9E8B17696EB8F5C2 = ["dx_cp_cpes_shfb_pmc4_checkyourfire", "dx_cp_cpes_shfb_pmc4_watchyourfire", "dx_cp_cpes_shfb_pmc4_checkfirecheckfire"];
  _id_C70EF01F81E274D3 = getEntArray("heli_escort_init_blockers", "script_noteworthy");

  foreach(_id_89CD85F6F0F79D1E in _id_B6C5C558B074A2D7) {
    _id_349B1ADB8E32FD9A = _id_8AD91A6FF3CB527A(_id_89CD85F6F0F79D1E.origin, _id_C70EF01F81E274D3);

    if(isDefined(_id_349B1ADB8E32FD9A))
      _id_349B1ADB8E32FD9A delete();

    _id_C70EF01F81E274D3 = getEntArray("heli_escort_init_blockers", "script_noteworthy");
    waitframe();
  }
}

_id_F2EBD428672D71F4(dummy, animation) {
  level endon("game_ended");

  for(;;) {
    dummy scriptmodelplayanimdeltamotion(animation);
    wait(getanimlength(animation));
  }
}

_id_283263FF48FE8F6C(dummy, _id_FA8CD388F6359091) {
  level endon("game_ended");
  _id_48DF711E143EAE26 = getEntArray("dummy_damage_trigger", "targetname");
  _id_60C7869645CE49FF = scripts\engine\utility::getclosest(dummy.origin, _id_48DF711E143EAE26, 200);
  _id_60C7869645CE49FF.health = 999999;
  _id_60C7869645CE49FF setCanDamage(1);
  _id_37ACF411672394D8 = ["dx_cp_cpes_shfb_lasw_knockitoffbreakercho", "dx_cp_cpes_shfb_lasw_curbthatbreakerweveg", "dx_cp_cpes_shfb_lasw_saveyourbrassforaq", "dx_cp_cpes_shfb_lasw_firedisciplinetilyou"];

  for(;;) {
    _id_60C7869645CE49FF waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, shitloc, partname, idflags, sweapon, origin, angles, normal, einflictor);

    if(!isPlayer(eattacker)) {
      continue;
    }
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_FA8CD388F6359091));
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_37ACF411672394D8));
    _id_60C7869645CE49FF.health = 99999;
    wait 3;
  }
}

_id_9A7741A090D8D596(player) {
  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(player istouching(trigger))
        return 1;
    }
  }

  return 0;
}

_id_6161095BB24A892E() {
  if(istrue(level._id_F6D7CED3597FBDCA)) {
    return;
  }
  level._id_F6D7CED3597FBDCA = 1;
  level.custom_shouldtakedamage = ::_id_9A7741A090D8D596;
  level.disable_munitions = 1;

  foreach(player in level.players)
  player allowmantle(0);

  _id_A0B7EBEEA70BC3C2();
  thread _id_FF93A680D8274DA7();
  _id_D5D319005CFAAC82 = scripts\engine\utility::getStruct("hills_ground_crate", "script_noteworthy");
  _id_27725A760446CAC4 = scripts\engine\utility::getStruct("hills_chopper_crate", "script_noteworthy");
  level thread _id_F814B0A9C4E7CEBB(_id_27725A760446CAC4);
  level thread _id_BB5B415F5461948D(_id_D5D319005CFAAC82);
}

_id_FF93A680D8274DA7() {
  level endon("game_ended");
  helis = scripts\engine\utility::getStructArray("hills_interactive_heli", "script_noteworthy");

  foreach(heli in helis) {
    _id_F98416D816CEEC66 = spawn("script_model", heli.origin);
    _id_F98416D816CEEC66.angles = heli.angles;
    _id_F98416D816CEEC66 setModel(heli.targetname);
    waitframe();
    _id_F98416D816CEEC66 setscriptablepartstate("engine", "off");
  }
}

_id_AFB66CC0A91D217C() {
  _id_D980639C2D48E46A = ["enable_house_interaction", "enable_gasstation_interaction", "enable_culdesac_interaction"];

  foreach(_id_EA3E3B2121E6713A in _id_D980639C2D48E46A) {
    level notify(_id_EA3E3B2121E6713A);
    waitframe();
  }
}

_id_E85B12D9DA5F8AB9() {
  if(istrue(level._id_4BBE42AD91D578DA)) {
    return;
  }
  level._id_4BBE42AD91D578DA = 1;
  clips = getEntArray("heli_servers", "targetname");

  foreach(clip in clips)
  clip notsolid();

  _id_4D2705C290B2A3C6 = scripts\engine\utility::getStructArray("house_obj_interaction", "script_noteworthy");
  _id_6CC27C9AB178C22F = scripts\engine\utility::getStructArray("gasstation_obj_interaction", "script_noteworthy");
  _id_940B2290E7C8D892 = scripts\engine\utility::getStructArray("blueroof_obj_interaction", "script_noteworthy");
  _id_C2C2589CF179B188 = scripts\engine\utility::getStructArray("culdesac_obj_interaction", "script_noteworthy");
  _id_BD17CFABA7C4520F = ["dx_cp_cpes_shof_lasw_gooddestroyitifithas", "dx_cp_cpes_shof_lasw_takeitofflineextract", "dx_cp_cpes_shof_lasw_greatbreakitifithasa", "dx_cp_cpes_shof_lasw_destroythatcomputers"];
  level thread _id_496BBC8E557FB8CE(_id_4D2705C290B2A3C6, 3, "enable_house_interaction", "house_interaction", _id_BD17CFABA7C4520F, "support_heli_house");
  level thread _id_496BBC8E557FB8CE(_id_6CC27C9AB178C22F, 3, "enable_gasstation_interaction", "gasstation_interaction", undefined, "support_heli_gasstaation", 2);
  level thread _id_496BBC8E557FB8CE(_id_C2C2589CF179B188, 3, "enable_culdesac_interaction", "culdesac_interaction", undefined, "support_heli_culdesac");
  wait 1;
}

_id_496BBC8E557FB8CE(_id_6071184F8A3861B3, _id_BB938D563589526C, _id_F230F39369EE396A, _id_61F8B2A73DC311E4, _id_3E4BD503B685AC64, _id_4EC5C2066D483464, _id_498970CF5D921A56) {
  level endon("game_ended");
  _id_D2DA01C5E209B969 = _id_61F8B2A73DC311E4 + "_used";
  _id_F6C9AE42F3A20F30 = _id_61F8B2A73DC311E4 + "_destroyed";

  if(!scripts\engine\utility::flag_exist(_id_F6C9AE42F3A20F30))
    scripts\engine\utility::flag_init(_id_F6C9AE42F3A20F30);

  if(!scripts\engine\utility::flag_exist(_id_4EC5C2066D483464 + "_hard_drive_picked"))
    scripts\engine\utility::flag_init(_id_4EC5C2066D483464 + "_hard_drive_picked");

  for(_id_A1CFB14D7BFD8718 = []; _id_A1CFB14D7BFD8718.size < _id_BB938D563589526C; _id_6071184F8A3861B3 = scripts\engine\utility::array_remove(_id_6071184F8A3861B3, _id_8A6120CFF04E34FB)) {
    _id_8A6120CFF04E34FB = scripts\engine\utility::random(_id_6071184F8A3861B3);
    _id_A1CFB14D7BFD8718[_id_A1CFB14D7BFD8718.size] = _id_8A6120CFF04E34FB;
  }

  _id_416817621640FBC2 = [];

  foreach(_id_DF071553D0996FF9 in _id_A1CFB14D7BFD8718) {
    _id_DF071553D0996FF9.equipment = [];
    _id_DF071553D0996FF9._id_4EC5C2066D483464 = _id_4EC5C2066D483464;
    _id_DF071553D0996FF9._id_CE0520C640CE0FF0 = _id_DF071553D0996FF9.targetname;

    if(isDefined(_id_DF071553D0996FF9.target)) {
      _id_98FA4B76D957B210 = scripts\engine\utility::getStructArray(_id_DF071553D0996FF9.target, "targetname");

      foreach(equipment in _id_98FA4B76D957B210) {
        if(isDefined(equipment.script_noteworthy) && equipment.script_noteworthy == "hard_drive") {
          _id_DF071553D0996FF9._id_7F0442648C2403C9 = equipment;
          continue;
        }

        _id_CD2FE080475CD3B4 = spawn("script_model", equipment.origin);
        _id_CD2FE080475CD3B4.angles = scripts\engine\utility::ter_op(isDefined(equipment.angles), equipment.angles, (0, 0, 0));
        _id_CD2FE080475CD3B4 setModel(equipment.script_noteworthy);
        _id_DF071553D0996FF9.equipment[_id_DF071553D0996FF9.equipment.size] = _id_CD2FE080475CD3B4;
        _id_CD2FE080475CD3B4._id_DF3C8403B8632770 = _id_DF071553D0996FF9;
      }

      _id_416817621640FBC2[_id_416817621640FBC2.size] = _id_DF071553D0996FF9;
    }

    clips = _id_E9AE48BBD2FC47B5(_id_DF071553D0996FF9.origin);

    if(isDefined(clips)) {
      foreach(clip in clips)
      clip solid();
    }

    if(getdvarint("dvar_DB68B935C2DCE511", 0) > 0)
      level thread _id_0D11DC6CDD0D3D6E(_id_DF071553D0996FF9.origin);
  }

  if(!isDefined(level._id_FE439A2796E44BB5))
    level._id_FE439A2796E44BB5 = [];

  level._id_FE439A2796E44BB5[_id_4EC5C2066D483464] = _id_416817621640FBC2;
  level thread _id_B18FFC8ABED074C9(_id_416817621640FBC2, _id_F230F39369EE396A, _id_3E4BD503B685AC64);
  level thread _id_6DC9D1BF3862C7AF(_id_416817621640FBC2, _id_F230F39369EE396A, _id_F6C9AE42F3A20F30, _id_4EC5C2066D483464, _id_498970CF5D921A56);
}

_id_0D11DC6CDD0D3D6E(origin) {
  level endon("game_ended");

  for(;;)
    wait 1;
}

_id_E9AE48BBD2FC47B5(_id_5A30BDA676923D15) {
  _id_3E79CAEEA633A5A7 = getEntArray("heli_servers", "targetname");
  _id_76E17519DE5C48BA = [];

  foreach(clip in _id_3E79CAEEA633A5A7) {
    if(distance(_id_5A30BDA676923D15, clip.origin) <= 128)
      _id_76E17519DE5C48BA[_id_76E17519DE5C48BA.size] = clip;
  }

  return _id_76E17519DE5C48BA;
}

_id_5FF04AC03F95AA63() {
  if(istrue(level._id_8D59315287901F76)) {
    return;
  }
  level._id_8D59315287901F76 = 1;
  thread _id_E1A386425D65056D("support_heli_house");
  thread _id_E1A386425D65056D("support_heli_gasstaation");
  thread _id_E1A386425D65056D("support_heli_culdesac");
}

_id_868D4102A3805021() {
  level endon("game_ended");
  _id_08AFCD15BF7BB71E = "";

  if(scripts\cp\cp_objectives::is_objective_active("support_heli_house"))
    _id_08AFCD15BF7BB71E = "support_heli_house";
  else if(scripts\cp\cp_objectives::is_objective_active("support_heli_gasstaation"))
    _id_08AFCD15BF7BB71E = "support_heli_gasstaation";
  else if(scripts\cp\cp_objectives::is_objective_active("support_heli_culdesac"))
    _id_08AFCD15BF7BB71E = "support_heli_culdesac";

  if(_id_08AFCD15BF7BB71E != "")
    _id_E1A386425D65056D(_id_08AFCD15BF7BB71E);
}

_id_E1A386425D65056D(_id_B81C89CDE4E926BA) {
  level endon("game_ended");

  while(!_id_FB6190FCD263559D())
    wait 1;

  if(isDefined(level._id_FE439A2796E44BB5) && isDefined(level._id_FE439A2796E44BB5[_id_B81C89CDE4E926BA])) {
    foreach(_id_3F4DA04C8BF7D5A3 in level._id_FE439A2796E44BB5[_id_B81C89CDE4E926BA])
    level thread _id_8782F4F7BE45949F(_id_3F4DA04C8BF7D5A3.equipment[0]);
  }
}

_id_52DE8936DE10FEEA() {
  level endon("game_ended");

  while(!_id_FB6190FCD263559D())
    wait 1;

  _id_CFE9D8CE6CC04C0B = ["support_heli_house", "support_heli_gasstaation", "support_heli_culdesac"];
  _id_20CB16EB67E7A203 = [];

  foreach(name in _id_CFE9D8CE6CC04C0B) {
    if(isDefined(level._id_FE439A2796E44BB5) && isDefined(level._id_FE439A2796E44BB5[name]))
      _id_20CB16EB67E7A203 = scripts\cp\utility::array_merge(_id_20CB16EB67E7A203, level._id_FE439A2796E44BB5[name]);
  }

  player = level.chopper_gunner;
  player endon("death");
  player endon("disconnect");

  for(;;) {
    player waittill("chopper_gunner_toggled_flir", _id_66532CAED12A4965);

    if(!isalive(player)) {
      continue;
    }
    foreach(_id_3F4DA04C8BF7D5A3 in _id_20CB16EB67E7A203) {
      foreach(equipment in _id_3F4DA04C8BF7D5A3.equipment) {
        if(istrue(_id_66532CAED12A4965)) {
          scripts\cp\cp_outline::enable_outline_for_player(equipment, player, "outlinefill_nodepth_white", "high");
          continue;
        }

        scripts\cp\cp_outline::disable_outline_for_player(equipment, player);
      }
    }
  }
}

_id_DD6A7AADEC7B3EE9() {
  level endon("game_ended");
  level endon("stop_chopper_nags");
  level endon("stop_systemic_vo");
  lines = ["dx_cp_cpes_shof_lasw_12yourirlenswillreve", "dx_cp_cpes_shof_lasw_12pingthoseservers", "dx_cp_cpes_shof_lasw_12getthoseserversmar"];

  for(;;) {
    wait 35;

    if(!_id_FB6190FCD263559D()) {
      wait 35;
      continue;
    }

    level.chopper_gunner thread scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/INFORM_PING", 8);
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
  }
}

_id_08AA8B30529C951E(equipment) {
  level endon("game_ended");

  while(!isDefined(level.chopper_gunner))
    waitframe();

  scripts\cp\cp_outline::disable_outline_for_player(equipment, level.chopper_gunner);
}

_id_917922B61E177298(_id_850AB69BFC46BCF6, objectiveindex, _id_5C66A1D0D8E81C85) {
  level endon("game_ended");
  _id_850AB69BFC46BCF6 waittill("death");
  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid(_id_5C66A1D0D8E81C85);
}

_id_B18FFC8ABED074C9(_id_416817621640FBC2, _id_F230F39369EE396A, _id_3E4BD503B685AC64) {
  level endon("game_ended");
  level waittill(_id_F230F39369EE396A);
  _id_CA58034A244DF631 = 0;

  while(!istrue(_id_CA58034A244DF631)) {
    foreach(_id_850AB69BFC46BCF6 in _id_416817621640FBC2) {
      if(_id_0CD33DF268F05E1F(_id_850AB69BFC46BCF6)) {
        wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_FC10CE08437AEECD"));

        if(isDefined(_id_3E4BD503B685AC64)) {
          _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_3E4BD503B685AC64));
          wait 1;
        }

        _id_CA58034A244DF631 = 1;
      }
    }

    wait 0.5;
  }
}

_id_0CD33DF268F05E1F(_id_DF3C8403B8632770) {
  player = level._id_9D709E54566707E6;

  if(!isDefined(player))
    return 0;

  foreach(equipment in _id_DF3C8403B8632770.equipment) {
    if(_id_000C497EE2D51155(player, equipment))
      return 1;
  }

  return 0;
}

_id_000C497EE2D51155(player, ent) {
  tracestart = player getEye();
  _id_3C70A7175FBFA3FC = player getplayerangles();
  _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 10000;
  results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, player, 0, 0, 0, 0, 0);
  _id_9595F9643C69A295 = results["entity"];

  if(isDefined(_id_9595F9643C69A295) && _id_9595F9643C69A295 == ent)
    return 1;
  else
    return 0;
}

_id_C7124DC6942FCF3C(_id_DF3C8403B8632770) {
  level endon("game_ended");

  while(!_id_E6E081264B34C544())
    wait 1;

  _id_DF3C8403B8632770._id_A4D50BF2DE617068 = 1;
}

_id_6DC9D1BF3862C7AF(_id_416817621640FBC2, _id_F230F39369EE396A, _id_F6C9AE42F3A20F30, _id_4EC5C2066D483464, _id_498970CF5D921A56) {
  level endon("game_ended");
  level waittill(_id_F230F39369EE396A);
  _id_EEFD86EDC53EA1DD = _id_416817621640FBC2.size;
  _id_6FA43C1B39DD1E79 = 0;
  _id_D86913115D5557C6 = "single_" + _id_F6C9AE42F3A20F30;
  _id_3F710AF97B7D5D0B = 1;

  foreach(_id_850AB69BFC46BCF6 in _id_416817621640FBC2) {
    _id_850AB69BFC46BCF6._id_3F710AF97B7D5D0B = _id_3F710AF97B7D5D0B;
    _id_3F710AF97B7D5D0B++;
    level thread _id_D3A585BBF5C4C066(_id_850AB69BFC46BCF6, _id_D86913115D5557C6, _id_4EC5C2066D483464);
    level thread _id_C7124DC6942FCF3C(_id_850AB69BFC46BCF6);
  }

  if(scripts\cp\cp_objectives::is_objective_active(_id_4EC5C2066D483464))
    thread scripts\cp\utility::objective_update(_id_4EC5C2066D483464, undefined, undefined, undefined, undefined, _id_EEFD86EDC53EA1DD);

  while(_id_EEFD86EDC53EA1DD > _id_6FA43C1B39DD1E79) {
    level waittill(_id_D86913115D5557C6, _id_1108EC7E67D55152);
    _id_6FA43C1B39DD1E79++;

    if(_id_6FA43C1B39DD1E79 >= _id_EEFD86EDC53EA1DD) {
      thread _id_FD473BD7B5E67967(_id_4EC5C2066D483464);
      thread _id_39D698704029F84E(_id_1108EC7E67D55152, _id_4EC5C2066D483464);
    } else
      thread _id_57FBFBA1948F77EC(_id_4EC5C2066D483464, _id_6FA43C1B39DD1E79, _id_498970CF5D921A56);

    if(scripts\cp\cp_objectives::is_objective_active(_id_4EC5C2066D483464))
      thread scripts\cp\utility::objective_update(_id_4EC5C2066D483464, undefined, undefined, undefined, undefined, _id_EEFD86EDC53EA1DD - _id_6FA43C1B39DD1E79);
  }

  wait 1;
  level notify(_id_F6C9AE42F3A20F30);
  scripts\engine\utility::flag_set(_id_F6C9AE42F3A20F30);
}

_id_FD473BD7B5E67967(_id_4EC5C2066D483464) {
  level endon("game_ended");
  lines = [];

  switch (_id_4EC5C2066D483464) {
    case "support_heli_house":
    default:
      lines = ["dx_cp_cpes_shof_lasw_thatswhatweneedsecur", "dx_cp_cpes_shof_lasw_grabitandletskeepmov", "dx_cp_cpes_shof_lasw_greatjobcollectthatd"];
      break;
    case "support_heli_gasstaation":
      break;
    case "support_heli_culdesac":
      break;
  }

  if(lines.size > 0)
    thread _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
}

_id_57FBFBA1948F77EC(_id_4EC5C2066D483464, _id_E6EB68659F2E64E7, _id_498970CF5D921A56) {
  level endon("game_ended");
  _id_54BA98048BB7FCA2 = ["dx_cp_cpes_shof_lasw_confirmedserversoffl", "dx_cp_cpes_shof_lasw_serversdown", "dx_cp_cpes_shof_lasw_thatonesdone", "dx_cp_cpes_shof_lasw_serversignalsdeadgoo", "dx_cp_cpes_shof_lasw_anotheronedown", "dx_cp_cpes_shof_lasw_thatlldoforthatone", "dx_cp_cpes_shof_lasw_thatonesfried", "dx_cp_cpes_shof_lasw_serverdestroyed11", "dx_cp_cpes_shof_lasw_serverdownnosignal", "dx_cp_cpes_shof_lasw_thatonesoffline", "dx_cp_cpes_shof_lasw_thatonescooked", "dx_cp_cpes_shof_lasw_serveroffline", "dx_cp_cpes_shof_lasw_nosignalserversout", "dx_cp_cpes_shof_lasw_signalsoutserverdown"];

  if(_id_4EC5C2066D483464 == "support_heli_house") {
    if(_id_E6EB68659F2E64E7 == 1) {
      lines = ["dx_cp_cpes_shof_lasw_goodworkdidithavethe", "dx_cp_cpes_shof_lasw_welldonewasthereahar", "dx_cp_cpes_shof_lasw_solid11didthatsystem"];
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
      wait 1.5;
      wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_69EB281E78451991"));
      lines = ["dx_cp_cpes_shof_lasw_copytherestwomoreser", "dx_cp_cpes_shof_lasw_itmustbeononeoftheot", "dx_cp_cpes_shof_lasw_alrightonedowntwotog"];
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
      return;
    } else
      _id_54BA98048BB7FCA2 = ["dx_cp_cpes_shof_lasw_thatstwodownthreesac", "dx_cp_cpes_shof_lasw_onlyoneotherplaceitc"];
  }

  if(isDefined(_id_498970CF5D921A56))
    thread _id_F3EB0F92A4D83744(_id_498970CF5D921A56, scripts\engine\utility::random(_id_54BA98048BB7FCA2));
  else
    thread _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_54BA98048BB7FCA2));
}

_id_063A00F9B90F5EDB() {
  level endon("game_ended");
  lines = ["dx_cp_cpes_shof_lasw_nicefindkeepaneyeout", "dx_cp_cpes_shof_lasw_goodworkwellcombover", "dx_cp_cpes_shof_lasw_goodworkallintelsgoo", "dx_cp_cpes_shof_lasw_anythingthatkeepsusa", "dx_cp_cpes_shof_lasw_nicenowsecurethoseha", "dx_cp_cpes_shof_lasw_waytobevigilant", "dx_cp_cpes_shof_lasw_goodeyenowletsgettha"];

  for(;;) {
    level waittill("pickedupintel");

    if(!_id_7E031905C49F9B9A()) {
      continue;
    }
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
  }
}

_id_39D698704029F84E(_id_1108EC7E67D55152, _id_4EC5C2066D483464) {
  if(isDefined(_id_1108EC7E67D55152._id_7F0442648C2403C9)) {
    _id_D721C12A2C2586AF = spawn("script_model", _id_1108EC7E67D55152._id_7F0442648C2403C9.origin);
    _id_D721C12A2C2586AF.angles = scripts\engine\utility::ter_op(isDefined(_id_1108EC7E67D55152._id_7F0442648C2403C9.angles), _id_1108EC7E67D55152._id_7F0442648C2403C9.angles, (0, 0, 0));
    _id_D721C12A2C2586AF setModel("misc_hard_drive_v0_rig");
    _id_5C66A1D0D8E81C85 = _id_4EC5C2066D483464 + "_harddrive";
    objectiveindex = scripts\cp\cp_objectives::requestworldid(_id_5C66A1D0D8E81C85);
    objective_setminimapiconsize(objectiveindex, "icon_regular");
    objective_setlabel(objectiveindex, &"CP_HILLS_MI/PICK_HD");
    objective_position(objectiveindex, _id_D721C12A2C2586AF.origin + (0, 0, 20));
    objective_setshowoncompass(objectiveindex, 1);
    objective_icon(objectiveindex, "icon_waypoint_objective_general");
    objective_state(objectiveindex, "current");
    objective_setplayintro(objectiveindex, 1);
    objective_setplayoutro(objectiveindex, 1);
    level thread _id_0BCADF19F8CE8754(_id_D721C12A2C2586AF, objectiveindex, _id_4EC5C2066D483464);
  }
}

_id_0BCADF19F8CE8754(_id_D721C12A2C2586AF, objectiveindex, _id_4EC5C2066D483464) {
  level endon("game_ended");
  _id_D721C12A2C2586AF makeusable();
  _id_D721C12A2C2586AF setHintString(&"CP_HILLS_MI/PICK_HD");
  _id_D721C12A2C2586AF setCursorHint("HINT_BUTTON");
  _id_D721C12A2C2586AF sethintdisplayrange(200);
  _id_D721C12A2C2586AF sethintdisplayfov(90);
  _id_D721C12A2C2586AF setuserange(72);
  _id_D721C12A2C2586AF setusefov(90);
  _id_D721C12A2C2586AF sethintonobstruction("show");
  _id_D721C12A2C2586AF setuseholdduration("duration_short");
  _id_D721C12A2C2586AF _meth_DFB78B3E724AD620(1);
  _id_34C73A07C2AA2577 = _id_4EC5C2066D483464 + "_hard_drive_picked";
  thread _id_34ED100C7B809A14(_id_34C73A07C2AA2577);

  for(;;) {
    _id_D721C12A2C2586AF waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");

    switch (_id_4EC5C2066D483464) {
      case "support_heli_house":
      default:
        thread _id_5990AF7AE754551E();
        break;
      case "support_heli_gasstaation":
        thread _id_A200C178B6F029D7();
        break;
      case "support_heli_culdesac":
        thread _id_8615A6B7CD263577();
        break;
    }

    player playlocalsound("cp_generic_pickup");
    thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_6A6FCDCC9BBE2CB7");
    level notify(_id_34C73A07C2AA2577);
    scripts\engine\utility::flag_set(_id_34C73A07C2AA2577);
    wait 0.3;
    objective_delete(objectiveindex);
    _id_D721C12A2C2586AF delete();
    return;
  }
}

_id_34ED100C7B809A14(_id_34C73A07C2AA2577) {
  level endon("game_ended");
  level endon(_id_34C73A07C2AA2577);
  wait 3;
  lines = ["dx_cp_cpes_shof_lasw_11weneedthatharddriv", "dx_cp_cpes_shof_lasw_11themissionisthoseh", "dx_cp_cpes_shof_lasw_wecantcompletethemis"];

  for(;;) {
    if(!scripts\engine\utility::flag("hills_important_vo_playing"))
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));

    wait 20;
  }
}

_id_F3EB0F92A4D83744(waittime, vo) {
  level endon("game_ended");
  wait(waittime);
  thread _id_166B4F052DA169A7::_id_775CD164C569E279(vo);
}

_id_D3A585BBF5C4C066(_id_DF3C8403B8632770, _id_FF5CCEDE2521CB13, _id_4EC5C2066D483464) {
  level endon("game_ended");
  failsafetimeout = 300000;
  endtime = gettime() + failsafetimeout;

  while(!_id_0CD33DF268F05E1F(_id_DF3C8403B8632770)) {
    if(!scripts\cp\cp_objectives::is_objective_active(_id_4EC5C2066D483464)) {
      endtime = gettime() + failsafetimeout;
      waitframe();
      continue;
    } else if(gettime() >= endtime || istrue(_id_DF3C8403B8632770._id_A4D50BF2DE617068)) {
      break;
    }

    wait 0.1;
  }

  _id_5C66A1D0D8E81C85 = "server" + _id_DF3C8403B8632770._id_3F710AF97B7D5D0B;
  objectiveindex = scripts\cp\cp_objectives::requestworldid(_id_5C66A1D0D8E81C85);
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_HILLS_MI/HOUSE_LABEL");
  objective_position(objectiveindex, _id_DF3C8403B8632770.origin + (0, 0, 20));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 0);
  objective_setplayoutro(objectiveindex, 0);
  _id_DF3C8403B8632770.objid = objectiveindex;
  _id_4514B73A08FD47E6(_id_DF3C8403B8632770);

  foreach(equipment in _id_DF3C8403B8632770.equipment)
  equipment thread _id_F831B524CC2E3FC7(_id_DF3C8403B8632770);

  while(_id_DF3C8403B8632770.equipment.size > 0)
    wait 1;

  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid(_id_5C66A1D0D8E81C85);
  scripts\engine\utility::exploder(_id_DF3C8403B8632770._id_CE0520C640CE0FF0);

  if(soundexists("cp_esc_computer_server_rack_destroy"))
    playsoundatpos(_id_DF3C8403B8632770.origin + (-10, -10, 0), "cp_esc_computer_server_rack_destroy");

  thread _id_08D081782391B97E(_id_DF3C8403B8632770);

  if(isDefined(_id_FF5CCEDE2521CB13))
    level notify(_id_FF5CCEDE2521CB13, _id_DF3C8403B8632770);
}

_id_08D081782391B97E(_id_DF3C8403B8632770) {
  level endon("game_ended");
  _id_644D9155DA88C625 = _id_DF3C8403B8632770.origin + (-18, -18, 0);
  wait 0.5;
  _id_4CF58793CC4F1AD6 = spawn("script_origin", _id_644D9155DA88C625);
  _id_4CF58793CC4F1AD6 playLoopSound("cp_esc_computer_server_rack_destroy_sparks_loop");
  wait 22.5;
  playsoundatpos(_id_644D9155DA88C625, "cp_esc_computer_server_rack_destroy_sparks_end");
  _id_4CF58793CC4F1AD6 stoploopsound("cp_esc_computer_server_rack_destroy_sparks_loop");
  _id_4CF58793CC4F1AD6 delete();
}

_id_F831B524CC2E3FC7(_id_3402D60C1EF6B931) {
  level endon("game_ended");
  equipment = self;
  equipment setCanDamage(1);
  equipment.health = 100;
  equipment thread _id_70BC5A268495E668(equipment);
  _id_DBF17E782EFCAB89 = equipment.origin;
  _id_C0CE1DCA33FD7417 = equipment.angles;
  model = equipment.model;
  equipment waittill("death");
  _id_3402D60C1EF6B931.equipment = scripts\engine\utility::array_remove(_id_3402D60C1EF6B931.equipment, equipment);
  _id_4514B73A08FD47E6(_id_3402D60C1EF6B931);

  foreach(_id_A7BC0EA83E06C77A in _id_3402D60C1EF6B931.equipment)
  _id_A7BC0EA83E06C77A dodamage(50, self.origin);

  thread _id_08AA8B30529C951E(equipment);
}

_id_70BC5A268495E668(equipment) {
  level endon("game_ended");
  equipment endon("death");

  for(;;) {
    equipment waittill("damage", amount, attacker);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
      _id_F56FB412974C87C8 = scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback");
      attacker thread[[_id_F56FB412974C87C8]]("standard");
    }
  }
}

_id_4514B73A08FD47E6(_id_3402D60C1EF6B931) {
  if(!isDefined(_id_3402D60C1EF6B931.equipment) && _id_3402D60C1EF6B931.equipment.size <= 0) {
    return;
  }
  foreach(equipment in _id_3402D60C1EF6B931.equipment) {
    if(isDefined(equipment))
      objective_position(_id_3402D60C1EF6B931.objid, equipment.origin);
  }
}

_id_5C5948A67E8E39F0(origin, angles, _id_219565F84953DCAA, model) {
  level endon("game_ended");
  timelimit = _id_219565F84953DCAA * 1000;
  endtime = gettime() + timelimit;
  _id_9AF72BBDFDEACE5D = spawn("script_model", origin);
  _id_9AF72BBDFDEACE5D setModel("tag_origin");
  _id_9AF72BBDFDEACE5D.angles = angles;
  waitframe();
  waitframe();
  _id_9E847F3574B2B2AB = issubstr(model, "computer_server_rack");

  if(istrue(_id_9E847F3574B2B2AB)) {
    _id_9AF72BBDFDEACE5D.angles = angles + (90, 0, 0);

    while(gettime() <= endtime) {
      playFXOnTag(level._effect["heli_comp_cluster_1"], _id_9AF72BBDFDEACE5D, "tag_origin");
      wait 3;
    }
  } else {
    while(gettime() <= endtime) {
      playFXOnTag(level._effect["heli_comp_cluster_2"], _id_9AF72BBDFDEACE5D, "tag_origin");
      playFXOnTag(level._effect["heli_comp_cluster_3"], _id_9AF72BBDFDEACE5D, "tag_origin");
      wait 3;
    }
  }

  _id_9AF72BBDFDEACE5D delete();
}

_id_F27328540D45B5C5() {
  level endon("game_ended");
  level endon("delete_global_obj_markers");

  if(istrue(level._id_DB01A4707C706D52)) {
    return;
  }
  level._id_DB01A4707C706D52 = 1;
  _id_0C134816A7914E32();
  _id_3ABDC511AEF237BA = scripts\cp\cp_objectives::requestworldid("house_global_marker", 10);
  _id_52A6CA0411495FD6 = scripts\engine\utility::getStruct("house_global_objective_marker", "script_noteworthy");
  objective_state(_id_3ABDC511AEF237BA, "current");
  objective_icon(_id_3ABDC511AEF237BA, "icon_waypoint_objective_general");
  objective_position(_id_3ABDC511AEF237BA, _id_52A6CA0411495FD6.origin);
  objective_setplayintro(_id_3ABDC511AEF237BA, 0);
  objective_setplayoutro(_id_3ABDC511AEF237BA, 0);
  objective_setlabel(_id_3ABDC511AEF237BA, &"CP_HILLS_MI/OFFICE");
  objective_setzoffset(_id_3ABDC511AEF237BA, 50);
  _id_5B64F4E84DCCCEE0(_id_52A6CA0411495FD6.origin, 1024, 1);
  objective_delete(_id_3ABDC511AEF237BA);
  scripts\cp\cp_objectives::freeworldid("house_global_marker");
}

_id_D8F31D502050D023(_id_541878648E708E66) {
  level endon("game_ended");
  level waittill("delete_global_obj_markers");

  foreach(objid in _id_541878648E708E66)
  objective_delete(objid);

  scripts\cp\cp_objectives::freeworldid("house_global_marker");
  scripts\cp\cp_objectives::freeworldid("gasstation_global_marker");
  scripts\cp\cp_objectives::freeworldid("culdesac_global_marker");
}

_id_75DAA35A5A19AA29() {
  level._id_A3E60D4FD52EFC95 = undefined;
  level.all_players_skip_last_stand = 0;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;

  foreach(player in level.players) {
    player.respawn_index = undefined;
    player.shouldskiplaststand = 0;
  }
}

_id_9CC01621526E88EE() {
  level._id_A3E60D4FD52EFC95 = 1;
  level.enter_spectator_func = ::_id_E40394473F0573FF;
  level.all_players_skip_last_stand = 1;
  level.skip_nav_check_on_spectate_respawn = 1;

  foreach(player in level.players)
  player.shouldskiplaststand = 1;
}

_id_E40394473F0573FF(downed_player) {
  _id_9B89BBAFD117F579 = scripts\engine\utility::getStructArray("heli_escort_spawners", "targetname");
  _id_E0CBA2B0A5510D09 = scripts\engine\utility::random(_id_9B89BBAFD117F579);
  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  timer = 2;
  wait(timer);

  foreach(key, value in downed_player.br_ammo)
  downed_player.br_ammo[key] = 0;

  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

#using_animtree("script_model");

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = scripts\engine\utility::ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  player watch_remove_rig();
  remove_player_rig(player);
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  player.player_rig delete();
  player.player_rig = undefined;
}

link_player_to_rig(player, _id_D180B535A33B044D) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  if(!isDefined(_id_D180B535A33B044D))
    _id_D180B535A33B044D = 0.2;

  player playerlinktoblend(player.player_rig, "tag_player", _id_D180B535A33B044D, 0.25, 0.25);
  wait(_id_D180B535A33B044D);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
}

_id_BD05A80725C4B6C3(_id_6DA1C2F942D288FD) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  restoreweapon = self getcurrentweapon();
  gunless = makeweapon("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  thread create_player_rig(self, "player");
  scripts\common\anim::anim_first_frame_solo(self.player_rig, "check_deadbody");
  link_player_to_rig(self, 0.4);
  thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "check_deadbody", "tag_origin");
  wait(getanimlength(%sdr_cp_veh_lbravo_seat_2_getin));
  self stopanimscriptsceneevent();
  self notify("remove_rig");
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  self switchtoweapon(restoreweapon);
  self takeweapon(gunless);
}

_id_86908C557DC75DC5(_id_6DA1C2F942D288FD) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  restoreweapon = self getcurrentweapon();
  gunless = makeweapon("iw9_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  thread create_player_rig(self, "player");
  scripts\common\anim::anim_first_frame_solo(self.player_rig, "check_deadbody");
  link_player_to_rig(self, 0.4);
  _id_6DA1C2F942D288FD thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "check_deadbody", "tag_origin");
  wait(getanimlength(%iw9_cp_heli_escort_npc_check_front_player));
  self stopanimscriptsceneevent();
  self notify("remove_rig");
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  self switchtoweapon(restoreweapon);
  self takeweapon(gunless);
}

_id_0E1B3BC2552FFDBC() {
  _id_263A0A2BDCA91038 = ["hills_tank", "hills_tank_loop", "house_tank", "gasstation_tank", "blueroof_tank", "return_tank"];

  foreach(_id_2D990AF941DEA69B in _id_263A0A2BDCA91038) {
    spawners = scripts\engine\utility::getStructArray(_id_2D990AF941DEA69B, "targetname");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawners.size; _id_AC0E594AC96AA3A8++) {
      spawner = spawners[_id_AC0E594AC96AA3A8];
      spawner._id_061513667F818F8B = spawner scripts\engine\utility::spawn_tag_origin();
      spawner._id_061513667F818F8B setModel("veh9_mil_lnd_tank");
    }
  }
}

_id_B4CADF961498C8BA() {
  level endon("game_ended");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shex_lasw_exfilbirdisonemikeou");
  wait 0.5;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shex_lasw_12keepemcovered");
}

_id_6652A87C35A56329(heli) {
  level endon("game_ended");

  while(_id_7E031905C49F9B9A()) {
    if(_id_E7C30095A6CDC3EF(level._id_9D709E54566707E6, heli)) {
      wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_0AB3839C038DF043"));
      return;
    }

    wait 2;
  }
}

_id_E7C30095A6CDC3EF(player, ent) {
  if(!isDefined(player)) {
    return;
  }
  _id_7FE710B31B2B752D = player gettagorigin("tag_eye");
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  _id_7636B8DC247C7CB4 = _id_7FE710B31B2B752D + _id_70222FBC47330166 * 20000;
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);
  trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_7636B8DC247C7CB4, undefined, contents);

  if(isDefined(trace["entity"]) && trace["entity"] == ent)
    return 1;
  else
    return 0;
}

_id_9DE6CC27B38B11FE(heli) {
  level endon("game_ended");
  level endon("players_onboard_exfil");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shex_hlp2_breaker11banshee64is");
  _id_A0B2CE232807DE90 = ["dx_cp_cpes_shex_lasw_11youremovingawayfro", "dx_cp_cpes_shex_lasw_11lzcoordinatesarema", "dx_cp_cpes_shex_lasw_jobsalmostdone11", "dx_cp_cpes_shex_lasw_breaker11movetoextra", "dx_cp_cpes_shex_lasw_dontstopnow11keepmov", "dx_cp_cpes_shex_lasw_breakersaqscomingaty", "dx_cp_cpes_shex_hlp2_allstationsbanshee64", "dx_cp_cpes_shex_hlp2_imrunninonfumeshere", "dx_cp_cpes_shex_hlp2_letsgo11", "dx_cp_cpes_shex_lasw_11getonthatbird", "dx_cp_cpes_shex_lasw_getonthehelosecureth", "dx_cp_cpes_shex_lasw_notimetowastebreaker"];
  _id_5A6C269584F2AD3F = ["dx_cp_cpes_shex_lasw_12keepyourteammateco", "dx_cp_cpes_shex_lasw_12laysuppressingfire", "dx_cp_cpes_shex_lasw_aircrewfinishthemiss", "dx_cp_cpes_shex_lasw_dontclockoutnow12the"];

  for(;;) {
    wait 40;

    if(_id_7E031905C49F9B9A() && _id_FB6190FCD263559D() && distance2d(level._id_9D709E54566707E6.origin, heli.origin) > 1000) {
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_5A6C269584F2AD3F));
      continue;
    }

    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_A0B2CE232807DE90));
  }
}

_id_0EF95D41763E2B3C() {
  level endon("game_ended");
  _id_EA0FBAC82EEC8FC1 = scripts\engine\utility::getStruct("ground_heli_spawn", "targetname");
  spawndata = spawnStruct();
  spawndata.origin = _id_EA0FBAC82EEC8FC1.origin + (0, 0, 100);
  spawndata.angles = _id_EA0FBAC82EEC8FC1.angles;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);
  vehicle scripts\common\vehicle_build::build_is_helicopter();
  path = scripts\engine\utility::getStruct(_id_EA0FBAC82EEC8FC1.target, "targetname");
  vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
  vehicle vehicle_setspeed(25, 5, 5);
  vehicle setCanDamage(0);
  vehicle scripts\engine\utility::waittill_any_timeout_1(600, "reached_dynamic_path_end");
  vehicle delete();
}

_id_CB9008087C11290E(heli) {
  level endon("game_ended");
  heli scripts\cp\utility::play_sound_on_entity("cp_heli_esc_exfillheli_takeoff");
}

_id_D22BD24D0367B401(heli) {
  level endon("game_ended");
  heli scripts\cp\utility::play_sound_on_entity("cp_heli_esc_exfillheli_land");
}

_id_A502C592DCA776EF() {
  level endon("game_ended");
  thread _id_B4CADF961498C8BA();
  _id_EA0FBAC82EEC8FC1 = scripts\engine\utility::getStruct("hills_heli_spawn", "targetname");
  spawndata = spawnStruct();
  spawndata.origin = _id_EA0FBAC82EEC8FC1.origin;
  spawndata.angles = _id_EA0FBAC82EEC8FC1.angles;
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);
  heli scripts\common\vehicle_build::build_is_helicopter();
  heli vehicle_setspeed(25, 5, 5);
  heli setCanDamage(0);
  thread _id_53552A06E16F50DA(heli);
  heli thread _id_6652A87C35A56329(heli);
  path = scripts\engine\utility::getStruct(_id_EA0FBAC82EEC8FC1.target, "targetname");
  heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
  heli vehicle_setspeed(25, 5, 5);
  heli.unload_land_offset = 260;
  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);

  if(isent(_id_EA0FBAC82EEC8FC1))
    _id_EA0FBAC82EEC8FC1 delete();

  level._id_DF588BF29C7FF9BC = heli;
  heli sethoverparams(0, 0, 0);
  heli setvehicleteam("allies");
  _id_3988BF4DBD68EDE4 = spawn("script_model", heli.origin);
  _id_3988BF4DBD68EDE4 dontinterpolate();
  _id_D05FF9F12BA1E1A0 = getEnt("care_package_col", "targetname");

  if(isDefined(_id_D05FF9F12BA1E1A0)) {
    _id_3988BF4DBD68EDE4 clonebrushmodeltoscriptmodel(_id_D05FF9F12BA1E1A0);
    _id_3988BF4DBD68EDE4 linkTo(heli, "tag_origin", (-144, 16, -192), (0, 0, 0));
  }

  heli scripts\common\vehicle::godon();
  _id_145B9114A0239C0F = 1500;
  _id_1B71ADB5DD5F240C = 0;
  heli thread keep_from_crushing_players();
  heli waittill("reached_dynamic_path_end");
  heli thread _id_D22BD24D0367B401(heli);
  heli vehicle_setspeedimmediate(0, 0.1, 0.1);
  heli notify("stop_looking_for_crushing");
  _id_99048828F621B4F0 = getEnt("heli_exfil_chopper_mark", "script_noteworthy");
  _id_99048828F621B4F0 enablelinkTo();
  _id_99048828F621B4F0 linkTo(heli, "tag_origin", (0, 0, -215), (0, 0, 0));
  thread _id_9DE6CC27B38B11FE(heli);
  _id_462AFF2B6BF6ABDB(_id_99048828F621B4F0);
  level._id_9D709E54566707E6 setsoundsubmix("iw9_cp_escort_heli_exfil", 2);
  heli thread _id_CB9008087C11290E(heli);
  thread _id_C9FFF0FC320C005D();

  if(isDefined(level.outofboundstriggers)) {
    foreach(_id_311721647A970021 in level.outofboundstriggers)
    _id_311721647A970021.origin = _id_311721647A970021.origin - (0, 0, 10000);
  }

  if(_id_7E031905C49F9B9A()) {
    _id_4CADAFE0DB5700B3 = level._id_9D709E54566707E6 scripts\engine\utility::spawn_tag_origin();
    _id_4CADAFE0DB5700B3 linkTo(heli);
    level._id_9D709E54566707E6 playerlinktodelta(_id_4CADAFE0DB5700B3, "tag_origin", 0, 180, 180, 180, 180, 0);
  }

  level notify("players_onboard_exfil");
  _id_A0EEC69077D8135E = scripts\engine\utility::getStruct("final_exfil_path", "targetname");
  heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_A0EEC69077D8135E);
  heli vehicle_setspeed(25, 5, 5);
  wait 3;
}

keep_from_crushing_players() {
  self endon("goal");
  self endon("stop_looking_for_crushing");

  for(;;) {
    foreach(player in level.players) {
      if(player istouching(self))
        thread move_player_from_under_heli(player);
    }

    waitframe();
  }
}

move_player_from_under_heli(player) {
  _id_06A3A1033FFC2699 = player.origin - self.origin;
  _id_06A3A1033FFC2699 = vectorNormalize(_id_06A3A1033FFC2699);
  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * 200;
  _id_06A3A1033FFC2699 = (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], 0);
  player setOrigin(player.origin + _id_06A3A1033FFC2699, 1);
}

_id_53552A06E16F50DA(heli) {
  _id_F204DACE25365C76 = "TAG_SEAT_0";
  heli.driver = spawn("script_model", heli gettagorigin(_id_F204DACE25365C76));
  heli.driver setModel("fullbody_sp_ally_pilot_western_vm");
  heli.driver linkTo(heli, _id_F204DACE25365C76, (0, 0, 17), (0, 0, 0));
  heli.driver scriptmodelplayanimdeltamotion("reb_vh_palfa_driver_idle_search01");
  heli.driver notsolid();
}

_id_C9FFF0FC320C005D() {
  level endon("game_ended");
  level notify("stop_systemic_vo");
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shex_hlp1_breaker11hasreachedt");
  wait 1.5;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shma_hlp2_watcher1personneland");
  wait 2;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpes_shma_lasw_excellentworkteamaql");

  if(_id_7E031905C49F9B9A())
    wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level._id_9D709E54566707E6, "stat_9E386F581CA5BFF5"));

  if(_id_FB6190FCD263559D())
    wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(level.chopper_gunner, "stat_BCA5E472447F8C73"));

  wait 1;
  level notify("outro_vo_done");
}

_id_91AAF446346613DA(points) {
  level endon("game_ended");
  self endon("flyaway");
  self endon("death");
  self endon("crashing");
  self notify("circle");
  level endon("hover_lz");
  self._id_7C8EBCD9C1AFA8D2 = 1;
  self clearlookatent();
  circle_radius = 2500;

  if(isDefined(self.circle_radius))
    circle_radius = self.circle_radius;

  nextpoint = points[0];
  target_ent = scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);
  chopper_height = scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B();

  if(!isDefined(target_ent))
    target_ent = self;

  self setneargoalnotifydist(100);
  self vehicle_setspeed(50, 20, 20);
  _id_9DBC893FB4BE54F2 = nextpoint.angles;

  while(isDefined(nextpoint)) {
    self setvehgoalpos(nextpoint.origin, 1);
    self.goalpos = nextpoint.origin;
    _id_9DBC893FB4BE54F2 = nextpoint.angles;
    scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");

    if(isDefined(nextpoint.target)) {
      nextpoint = scripts\engine\utility::getStruct(nextpoint.target, "targetname");
      continue;
    }

    nextpoint = undefined;
  }

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);
  self notify("finished_landing");
}

_id_9DB1BE0244D95316() {
  level endon("game_ended");

  if(getdvarint("dvar_E08048A55E1B7A16", 0) > 0) {
    return;
  }
  spawner = scripts\engine\utility::getStruct("house_car_1", "targetname");
  spawner._id_72772FA651ECBE2B = "chase_truck";
  spawner.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  spawner.vehicletype = "veh9_techo_physics_cp";
  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
  spawner = scripts\engine\utility::getStruct("house_car_2", "targetname");
  spawner._id_72772FA651ECBE2B = "chase_truck";
  spawner.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  spawner.vehicletype = "veh9_techo_physics_cp";

  if(getdvarint("dvar_3467F9DB6FCA4638", 0) > 0) {
    spawner.classname_mp = "script_vehicle_veh9_jltv_mg_ai";
    spawner.vehicletype = "veh9_jltv_mg_physics_mp";
  }

  truck = scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
  thread _id_BDAFAF234DED98D6(truck);
}

_id_7A8A735C6D595E72(waittime) {
  if(getdvarint("dvar_E08048A55E1B7A16", 0) > 0) {
    return;
  }
  wait(waittime);
  _id_7FE30A00DB94335E = scripts\engine\utility::getStruct("escape_car_1", "targetname");
  _id_7FE30900DB94312B = scripts\engine\utility::getStruct("escape_car_2", "targetname");
  _id_7FE30A00DB94335E._id_72772FA651ECBE2B = "chase_truck";
  _id_7FE30900DB94312B._id_72772FA651ECBE2B = "chase_truck";
  _id_7FE30A00DB94335E.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  _id_7FE30A00DB94335E.vehicletype = "veh9_techo_physics_cp";
  _id_7FE30900DB94312B.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  _id_7FE30900DB94312B.vehicletype = "veh9_techo_physics_cp";
  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_7FE30A00DB94335E);
  truck = thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_7FE30900DB94312B);
  thread _id_BDAFAF234DED98D6(truck);
}

_id_AA088B7CAD597211() {
  level endon("game_ended");
  thread _id_35954B3FB5848A5F(3, 0);
  _id_AB6DFABA852446A9();
  spawner = scripts\engine\utility::getStruct("indoor_market_veh", "targetname");
  _id_5B8046E7D2F07129 = scripts\engine\utility::getStructArray(spawner.spawngroup, "targetname");
  spawner._id_72772FA651ECBE2B = "chase_truck";
  spawner.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  spawner.vehicletype = "veh9_techo_physics_cp";
  truck = thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
}

_id_35954B3FB5848A5F(_id_F940C1E878A94160, _id_2CDA6F0237D6306D) {
  if(getdvarint("dvar_E08048A55E1B7A16", 0) > 0) {
    return;
  }
  if(!isDefined(_id_2CDA6F0237D6306D))
    _id_2CDA6F0237D6306D = 0;

  _id_F940C1E878A94160 = int(clamp(_id_F940C1E878A94160, 1, 5));
  spawner = scripts\engine\utility::getStruct("chase_car_" + _id_F940C1E878A94160, "targetname");
  _id_5B8046E7D2F07129 = scripts\engine\utility::getStructArray(spawner.spawngroup, "targetname");
  spawner._id_72772FA651ECBE2B = "chase_truck";
  spawner.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  spawner.vehicletype = "veh9_techo_physics_cp";

  if(istrue(_id_2CDA6F0237D6306D)) {
    spawner.classname_mp = "script_vehicle_veh9_jltv_mg_ai";
    spawner.vehicletype = "veh9_jltv_mg_physics_mp";
  }

  truck = thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
  thread _id_BDAFAF234DED98D6(truck);
}

_id_BDAFAF234DED98D6(truck) {
  level endon("game_ended");

  if(scripts\engine\utility::flag("hills_important_vo_playing")) {
    return;
  }
  lines = ["dx_cp_cpes_shhl_hlp1_enemytruckincoming", "dx_cp_cpes_shhl_hlp1_shootersonthattruck", "dx_cp_cpes_shhl_hlp1_letstakeoutthattruck", "dx_cp_cpes_shhl_hlp1_letshitthatvehicle"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));

  if(!isDefined(truck)) {
    return;
  }
  msg = truck scripts\engine\utility::waittill_any_timeout_1(10, "death");

  if(msg == "death")
    lines = ["dx_cp_cpes_shhl_hlp1_kafuckinboomdirect", "dx_cp_cpes_shhl_hlp1_lookedtoastyfromhere", "dx_cp_cpes_shhl_hlp1_niceshots", "dx_cp_cpes_shhl_lasw_nicelydone", "dx_cp_cpes_shhl_lasw_goodshooting", "dx_cp_cpes_shhl_lasw_thatswhyyoureupthere"];
  else
    lines = ["dx_cp_cpes_shhl_lasw_anyaqvehiclescouldbe", "dx_cp_cpes_shhl_lasw_dontleaveanyaqunatte", "dx_cp_cpes_shhl_lasw_allaqvehiclesneedtob", "dx_cp_cpes_shhl_lasw_putroundsdownonthata", "dx_cp_cpes_shhl_lasw_hitthosevehicles", "dx_cp_cpes_shhl_lasw_fireonthatvehicle"];

  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines));
}

_id_A1F2D3EB5A7E739B(_id_B00DB70717B51F1E, _id_5B8046E7D2F07129) {
  _id_B00DB70717B51F1E.classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
  level thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_B00DB70717B51F1E, _id_5B8046E7D2F07129);
}

spawn_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A) {
  _id_656F0AE440B1B5D5 = magicgrenademanual("claymore_mp", origin + (0, 0, 10), (0, 0, 10));
  _id_656F0AE440B1B5D5 childthread plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A);
  return _id_656F0AE440B1B5D5;
}

plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.angles = angles;
  self.owner = spawnStruct();
  self.owner.angles = angles;
  self.owner.team = "neutral";
  self.team = "neutral";
  owner = self.owner;
  self.weapon_object = makeweapon("claymore_mp");

  if(!isDefined(level._id_C4EA99FA46D27C12))
    level._id_C4EA99FA46D27C12 = [];

  level._id_C4EA99FA46D27C12[level._id_C4EA99FA46D27C12.size] = self;
  self._id_3DBA99677FD840CD = ::_id_16B65EE43D765196;
  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 1.3);
  thread minedamagemonitor();
  thread scripts\cp\cp_claymore::claymore_explodeonnotify();
  thread scripts\cp\cp_claymore::claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  wait 0.1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  self.equipmentref = "equip_claymore";
  _id_6159D9FD44490F13::_hacksetup();
  thread custom_explode_mine(origin);
  thread scripts\cp\cp_claymore::enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A);
}

_id_16B65EE43D765196() {
  self notify("clean_custom_explode");

  if(isDefined(self.useobj))
    self.useobj delete();

  thread _id_74502A9E0EF1F19C::deleteexplosive();
}

custom_explode_mine(origin) {
  self endon("clean_custom_explode");
  _id_B9CE53DAD043E9E4 = origin + (0, 0, 50) + anglesToForward(self.angles) * 95;
  _id_419BFD33C72E7EF9 = origin + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");
  attacker = getaiarray("axis")[0];
  radiusdamage(_id_419BFD33C72E7EF9, 30, 1000, 200, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(_id_B9CE53DAD043E9E4, 100, 1000, 20, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

makeexplosiveusabletag(tagname, isgrenade) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;

  if(!isDefined(isgrenade))
    isgrenade = 0;

  self makeusable();

  if(isgrenade)
    self enablemissilehint(1);
  else
    self setCursorHint("HINT_NOICON");

  self sethinttag(tagname);
  self setuserange(72);
  _id_1DB8D0E02A99C5E2::setexplosiveusablehintstring(self.weapon_name);
  self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player scripts\cp\utility::_id_BD4D8A169D79E52B();
    self setscriptablepartstate("hacked", "active", 0);
    self playSound("cp_claymore_disable");
    wait 0.25;
    self notify("clean_custom_explode");

    if(isDefined(self.useobj))
      self.useobj delete();

    thread _id_74502A9E0EF1F19C::deleteexplosive();
    return;
  }
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  self waittill("damage", damage, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
  self notify("mine_destroyed");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(idflags) && idflags &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isDefined(attacker))
    self.damagedby = attacker;

  self notify("detonateExplosive", attacker);
}

enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water"]);

  for(;;) {
    _id_00AF3B9624C6AB60 = level.players;
    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    _id_2CC97E113610CA14 = self.origin;
    ignorelist = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(struct in level.dynamicladders)
      ignorelist[ignorelist.size] = struct.ents[0];
    }

    if(istrue(_id_F8F2EBF05B9AF55A))
      _id_00AF3B9624C6AB60 = scripts\engine\utility::array_combine(_id_00AF3B9624C6AB60, getaiarray("allies"));

    foreach(_id_548B9F6609CE3883 in _id_00AF3B9624C6AB60) {
      if(!isDefined(_id_548B9F6609CE3883)) {
        continue;
      }
      if(isPlayer(_id_548B9F6609CE3883) && _id_0AFB7E332AEE4BF2::player_in_laststand(_id_548B9F6609CE3883) || isagent(_id_548B9F6609CE3883) && !isalive(_id_548B9F6609CE3883)) {
        continue;
      }
      if(lengthsquared(_id_548B9F6609CE3883 getentityvelocity()) < 10) {
        continue;
      }
      if(distance2dsquared(_id_548B9F6609CE3883.origin, self.origin) > 50625) {
        continue;
      }
      _id_AD283A45677A1EA3 = _id_548B9F6609CE3883 gettagorigin("j_mainroot");
      _id_44060504F23C16AF = [_id_AD283A45677A1EA3];
      _id_340D59422336E85A = _id_2CC97E113610CA14 - _id_AD283A45677A1EA3;

      if(vectordot(_id_340D59422336E85A, (0, 0, 1)) >= 0)
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883 gettagorigin("j_spineupper");
      else
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883.origin;

      foreach(_id_A00164B06F60F5E6 in _id_44060504F23C16AF) {
        _id_340D59422336E85A = _id_A00164B06F60F5E6 - self.origin;
        _id_CC00B910BD1D69C8 = vectordot(_id_340D59422336E85A, forward);

        if(_id_CC00B910BD1D69C8 > 192 || _id_CC00B910BD1D69C8 < 20) {
          continue;
        }
        _id_69211973F7D7BBD6 = vectordot(_id_340D59422336E85A, up);

        if(abs(_id_69211973F7D7BBD6) > 32) {
          continue;
        }
        _id_A3D051EF761EFD24 = vectorNormalize(_id_340D59422336E85A);
        _id_74876E67651C79A6 = vectordot(_id_A3D051EF761EFD24, forward);

        if(_id_74876E67651C79A6 < 0.86) {
          continue;
        }
        _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_A00164B06F60F5E6, contents, ignorelist, 0, "physicsquery_closest", 1);

        if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
          continue;
        }
        thread scripts\cp\cp_claymore::claymore_trigger(_id_548B9F6609CE3883);
      }
    }

    wait 0.05;
  }
}

_id_53D271EE4AC10F0C(objstruct) {
  level endon("game_ended");
  objstruct endon("objective_completed");
  _id_A0B2CE232807DE90 = ["dx_cp_cpes_shhl_lasw_11youneedtopushuptha", "dx_cp_cpes_shhl_lasw_keeppushingforward", "dx_cp_cpes_shhl_lasw_advanceonthetargeten", "dx_cp_cpes_shhl_lasw_11stayoncourseyounee", "dx_cp_cpes_shhl_lasw_11getbackonmission", "dx_cp_cpes_shhl_lasw_stayontargetyouneedt"];

  for(;;) {
    wait 90;
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_A0B2CE232807DE90));
  }
}

_id_F8ABF4009B0AA09D(objstruct) {
  level endon("game_ended");
  objstruct endon("objective_completed");
  _id_2A76F001E81D41DB = ["dx_cp_cpes_shof_lasw_11youremovingwideofy", "dx_cp_cpes_shof_lasw_11checkyourtacmapfor", "dx_cp_cpes_shof_lasw_11youremovingpastalp", "dx_cp_cpes_shof_lasw_11yourmovingpastalph"];
  _id_CFAB7DBDF9D0431E = ["dx_cp_cpes_shof_lasw_11youneedtokeepmovin", "dx_cp_cpes_shof_lasw_keepmovingandtakeout", "dx_cp_cpes_shof_lasw_11movetodestroythose", "dx_cp_cpes_shof_lasw_11airteammarkedthose", "dx_cp_cpes_shof_lasw_11youreneartheobject", "dx_cp_cpes_shof_lasw_11youshouldbecloseto", "dx_cp_cpes_shof_lasw_11follow11smarktoloc"];

  for(;;) {
    wait 90;

    if(_id_E6E081264B34C544()) {
      _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_CFAB7DBDF9D0431E));
      continue;
    }

    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_2A76F001E81D41DB));
  }
}

_id_361BA19B9A3883AE(objstruct) {
  level endon("game_ended");
  objstruct endon("objective_completed");
  _id_2A76F001E81D41DB = ["dx_cp_cpes_shmk_lasw_11yourewideofthemark", "dx_cp_cpes_shmk_lasw_11checkyourtacmapfor", "dx_cp_cpes_shmk_lasw_11youremissingbravo", "dx_cp_cpes_shmk_lasw_breaker11serverlocat"];

  for(;;) {
    wait 90;
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_2A76F001E81D41DB));
  }
}

_id_21895A7CFC184BB7(objstruct) {
  level endon("game_ended");
  objstruct endon("objective_completed");
  _id_2A76F001E81D41DB = ["dx_cp_cpes_shcp_lasw_11youredriftingwideo", "dx_cp_cpes_shcp_lasw_11checkyourtacmaptoc", "dx_cp_cpes_shcp_lasw_11youremissingthecom", "dx_cp_cpes_shcp_lasw_11serverlocationsare"];

  for(;;) {
    wait 90;
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_2A76F001E81D41DB));
  }
}

_id_BBDFA6036B25F26E(objstruct) {
  level endon("game_ended");
  level endon("players_onboard_exfil");
  objstruct endon("objective_completed");
  _id_2A76F001E81D41DB = ["dx_cp_cpes_shcp_lasw_11aqhasreinforcement", "dx_cp_cpes_shcp_lasw_11movetoextraction", "dx_cp_cpes_shcp_lasw_gettothelznow"];

  for(;;) {
    wait 90;
    _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_2A76F001E81D41DB));
  }
}

_id_EFBF8FB765ED650E() {
  wait 1;
  setmusicstate("mx_cp_mission_esc_hills_infil");
}

_id_5990AF7AE754551E() {
  setmusicstate("mx_cp_mission_esc_hills_founddrive1");
}

_id_A200C178B6F029D7() {
  setmusicstate("mx_cp_mission_esc_hills_founddrive2");
}

_id_8615A6B7CD263577() {
  setmusicstate("mx_cp_mission_esc_hills_exfil");
}

_id_0FB467EB4C40D080() {
  _func_A3901A965FC1D7DD("mx_cp_mission_esc_hills_exfil");
}

#using_animtree("generic_human");

init_anims() {
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["dead1"] = % mp_ambient_deadbody_01;
  level.scr_animname["hvt"]["dead1"] = "mp_ambient_deadbody_01";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["deadsit"] = % iw9_cp_heli_escort_npc_check_front_victim;
  level.scr_animname["hvt"]["deadsit"] = "iw9_cp_heli_escort_npc_check_front_victim";
  level.scr_animtree["ally"] = #animtree;
  level.scr_anim["ally"]["smoking"] = % reb_stl_idle_stand_smoking;
  level.scr_animname["ally"]["smoking"] = "reb_stl_idle_stand_smoking";
  level.scr_animtree["ally"] = #animtree;
  level.scr_anim["ally"]["waterbottle"] = % reb_stl_idle_stand_waterbottle;
  level.scr_animname["ally"]["waterbottle"] = "reb_stl_idle_stand_waterbottle";
  level.scr_animtree["ally"] = #animtree;
  level.scr_anim["ally"]["cellphone"] = % reb_stl_idle_stand_cellphone;
  level.scr_animname["ally"]["cellphone"] = "reb_stl_idle_stand_cellphone";
  level.scr_animtree["ally"] = #animtree;
  level.scr_anim["ally"]["ghost_idle"] = % iw9_fe_op_select_ghost_west_idle_01;
  level.scr_animname["ally"]["ghost_idle"] = "iw9_fe_op_select_ghost_west_idle_01";
  level.scr_animtree["jugg"] = #animtree;
  level.scr_anim["jugg"]["kick"] = % jug_com_door_kick;
  level.scr_animname["jugg"]["kick"] = "jug_com_door_kick";
}

#using_animtree("script_model");

_id_F92C48D736AA932C() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["check_deadbody"] = % iw9_cp_heli_escort_npc_check_front_player;
  level.scr_animname["player"]["check_deadbody"] = "iw9_cp_heli_escort_npc_check_front_player";
  level.scr_eventanim["player"]["check_deadbody"] = "check_deadbody";
}