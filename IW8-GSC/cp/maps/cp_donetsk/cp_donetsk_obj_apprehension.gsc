/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_obj_apprehension.gsc
**************************************************************/

apprehension_init() {
  level.apprehension_interaction = ::register_interactions;
  scripts\cp\cp_pickup_hostage::init_anims();
  level.suicide_bomber_combat_func = ::suicide_bomber_combat_func;
  thread anim_init_trafficking();
}

register_apprehension_objective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread apprehension_init();
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  var_0 = scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("_encstr_9A0A0FDB134DFA47573BAFED33D7DD584E", ::obj_maj_intro_init, ::obj_maj_intro_start, ::obj_maj_intro_end, ::debugbeatobjective, ::debug_start_apprehension);
  [[var_0]]("_encstr_96FD11AFFBD2D870F09AC33984CDC0065A6735", ::obj_maj_approach_init, ::obj_maj_approach_start, ::obj_maj_approach_end, ::debugbeatobjective);
  [[var_0]]("_encstr_BEC313982AF461E7EBC2BA6F98F5CDC752682618C8", ::obj_maj_grab_init, ::obj_maj_grab_start, ::obj_maj_grab_end, ::debugbeatobjective);
  [[var_0]]("_encstr_BD631510DA535860B79B2733B511F0983B62CBD872EB05", ::obj_maj_rescue_init, ::obj_maj_rescue_start, ::obj_maj_rescue_end, ::debugbeatobjective);
  [[var_0]]("_encstr_BE46153F7E4D375F8B0862CA23A754BB3950AAA5076843", ::obj_maj_defend_init, ::obj_maj_defend_start, ::obj_maj_defend_end, ::debugbeatobjective);
  [[var_0]]("_encstr_91FB16B789A9FAB287A3C90B6CA3D7B4E6CCB727ADB073E8", ::obj_maj_extract_init, ::obj_maj_extract_start, ::obj_maj_extract_end, ::debugbeatobjective);
  [[var_0]]("_encstr_86A914BD2635FAAC3CE8C9C21B8EAF0E36855EAC396E", ::obj_maj_exit_init, ::obj_maj_exit_start, ::obj_maj_exit_end, ::debugbeatobjective);
  [[var_0]]("_encstr_AFD016B7C4A9BE96B9CCDBC9B6C2E6A3AF89C6568CEDD5E8");
  level thread register_spawn_functions();
}

register_interactions() {}

obj_maj_intro_init(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_8C892A135786BB3BAF20323B48DDF99BF83E8C8078A97BC74BD00AB1B0D76A7FB3A5DF0388B03BCD7B28327A") || !scripts\engine\utility::flag("_encstr_8C892A135786BB3BAF20323B48DDF99BF83E8C8078A97BC74BD00AB1B0D76A7FB3A5DF0388B03BCD7B28327A")) {
    scripts\engine\utility::flag_set("_encstr_8463204B1FCEF343D7686A73F01531632086C4C82011A30F83884209780F32377B6D");
    scripts\engine\utility::flag_wait("_encstr_8C892A135786BB3BAF20323B48DDF99BF83E8C8078A97BC74BD00AB1B0D76A7FB3A5DF0388B03BCD7B28327A");
  }
}

obj_maj_intro_start(var_0) {
  foreach(var_2 in getaiarray("_encstr_8E8405EA382B2A")) {
    var_2.dont_kill_off = 0;
    var_2.never_kill_off = 0;
  }

  wait 1;
  level.initlocationcircle = "_encstr_AB1D13872DB83977CFF3235A18AD93EA088F0E2FE3";
  level.initlethalmaxoffsetmap = "_encstr_AB1D13872DB83977CFF3235A18AD93EA088F0E2FE3";
  level._id_139B5 = 1;
  level thread _id_131F0();
}

minigun_shots_per_round() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_8E5709505A9681F9275256", ["_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9", "_encstr_A3990BDBEF05B561FA5A488BD8"]);
}

obj_maj_intro_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_96FD11AFFBD2D870F09AC33984CDC0065A6735", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

obj_maj_approach_init(var_0) {
  scripts\engine\utility::flag_init("_encstr_B16E1563D3401712D4ABAB27817C7B6FB81B5E2B28F8A4");
  scripts\engine\utility::flag_init("_encstr_BA5D1516D863DEDDAF1BBD739DB7E5D74EF6B05B4B739D");
  level thread spawn_intro_soldiers();
  level thread spawn_hvt_in_building();
  level thread spawn_atvs();
  level thread _id_135E1("_encstr_B24D18F388C9474ADF87A291759B520290380F6341A390E2E728");
  level thread first_bleedout();
  level thread _id_131E9();
  scripts\cp\cp_objectives::reset_objective_timers();
  level notify("_encstr_933C1E6B08AB38F713EE0F2488D88744CD380182A825793F485C373291214BCB");

  if(!isDefined(level.hostage_pickup))
    level waittill("_encstr_8B9D101BC0D3B4D2077D0102DF338B66B923");
}

obj_maj_approach_start(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_AB1D13872DB83977CFF3235A18AD93EA088F0E2FE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_0.objectiveindex, &"_encstr_AD8B1D8B89A962FD35579859F32515AF3DBA097769A9CA4DCC156D4678B0C8");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  objective_sethot(var_0.objectiveindex, 0);
  level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
  level thread scripts\cp\cp_objectives::_id_1317E(var_0, level.hostage_pickup.origin);
  level wait_player_near(level.hostage_pickup.origin, 6500, 0);
  scripts\engine\utility::flag_wait("_encstr_B16E1563D3401712D4ABAB27817C7B6FB81B5E2B28F8A4");
  objective_unsetlocation(var_0.objectiveindex, 0);
  level thread convoy_start();
  level thread _id_1240B();
  level thread allow_player_mantles();
}

obj_maj_approach_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_BEC313982AF461E7EBC2BA6F98F5CDC752682618C8", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

obj_maj_grab_init(var_0) {}

obj_maj_grab_start(var_0) {
  level endon("_encstr_82350EE6A37B83F5CEC90B89BEDB9853");
  var_1 = scripts\engine\utility::getStruct("_encstr_AB1D13872DB83977CFF3235A18AD93EA088F0E2FE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_0.objectiveindex, &"_encstr_8D0F28882FF8E12D750F90D94F1FF6B7CA22B7B4A96F70161328735401F55BB9CD2189DB672FC881516B");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  objective_sethot(var_0.objectiveindex, 0);
  objective_addalltomask(var_0.objectiveindex);
  objective_showtoplayersinmask(var_0.objectiveindex);
  level thread hvt_wait_for_pickup();
  level thread play_waitfor_ai_drop_vo(level.hostage_pickup);
  level thread player_grabs_hostage(var_0);
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "_encstr_A77D0FBBE0635F1F964F4237EB989BA2EF");
  var_2 = 30;
  wait(var_2);
}

obj_maj_grab_end(var_0) {
  if(!istrue(level.hostage_pickup.pickedupbyplayer))
    level thread scripts\cp\cp_objectives::run_objective("_encstr_BD631510DA535860B79B2733B511F0983B62CBD872EB05", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
  else {
    if(isDefined(level.hostage_pickup.carrier) && !isPlayer(level.hostage_pickup.carrier)) {
      level thread scripts\cp\cp_objectives::run_objective("_encstr_BD631510DA535860B79B2733B511F0983B62CBD872EB05", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
      return;
    }

    if(istrue(level.hostage_pickup.pickedupbyplayer)) {
      level thread scripts\cp\cp_objectives::run_objective("_encstr_BE46153F7E4D375F8B0862CA23A754BB3950AAA5076843", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
      return;
    }

    level thread scripts\cp\cp_objectives::run_objective("_encstr_BD631510DA535860B79B2733B511F0983B62CBD872EB05", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
  }
}

obj_maj_rescue_init(var_0) {
  scripts\cp\utility::_id_123FE("_encstr_92E81F689BBB317ED3A70733278AB47045B2D6030703982DFABF092FC7638F601D");
}

obj_maj_rescue_start(var_0) {
  level.hostage_pickup scripts\engine\utility::_id_143A5("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", "_encstr_88C60846397B83835919");
}

obj_maj_rescue_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_BE46153F7E4D375F8B0862CA23A754BB3950AAA5076843", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

obj_maj_defend_init(var_0) {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BE471435F621CF5D8398A2DA50A794D71954AB97AF83");
  level thread scripts\cp\cp_convoy_manager::compromise_center_truck();
}

obj_maj_defend_start(var_0) {
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_0.objectiveindex, 0);
  objective_setlabel(var_0.objectiveindex, &"_encstr_A75118C5BAEF2911E9DF4749CFC178814A84CE9D500CF9DFA0FB");
  objective_addalltomask(var_0.objectiveindex);
  objective_hidefromplayersinmask(var_0.objectiveindex);
  level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"_encstr_844E20D713A1FE3135B785FC2FDAEA388893774BD398A8B1751EACF741FCC1C65013");
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  thread kill_rate_watcher();
  level thread location_objective_remover();
  level thread allow_hvt_stealing_by_ai();
  level thread _id_12411();
  level thread first_convoy_lmgs();
  var_1 = scripts\engine\utility::getStructArray("_encstr_995217C551484753B5C7BF631F57FB8F807BBB4129B006DA01", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getvehicleplayerhorn(var_1);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = "_encstr_87E118F626A97D1DEAD9ED99EE85E4FA3467A3F5591ECC4BB1FA" + var_2[var_4].script_noteworthy;
    var_6 = scripts\cp\cp_objectives::requestworldid(var_5, 15);
    onexplode(var_6);
    objective_position(var_6, var_2[var_4].origin);
    level thread wait_for_hvt_near_exfil(var_2[var_4], "_encstr_A71804587AF2");
    var_2[var_4]._id_11F64 = var_6;
    var_3[var_4] = var_6;
  }

  level waittill("_encstr_BAB50F298EEB09D87FF2933E9A2384E085", var_7, var_8);
  level thread _id_1354D(var_7);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_2[var_4].script_noteworthy != var_7) {
      objective_state(var_2[var_4]._id_11F64, "_encstr_8267056410C669");
      scripts\cp\cp_objectives::freeworldidbyobjid(var_2[var_4]._id_11F64);
      var_2[var_4]._id_11F64 = undefined;
      continue;
    }

    level.tugofwar_exfil_location = var_2[var_4];
  }

  level thread getthirdpersonrangeforsize(level.tugofwar_exfil_location.origin, var_7);
  level thread scripts\cp\cp_objectives::_id_1317E(var_0, level.tugofwar_exfil_location.origin);
  level thread wait_for_hvt_near_exfil(level.tugofwar_exfil_location, "_encstr_88950636C6DE9B59");
  level waittill("_encstr_BAB50F298EEB09D87FF2933E9A2384E085", var_7, var_8);
  scripts\cp\utility::_id_123FE("_encstr_B40101");

  if(isDefined(level.hostage_pickup) && isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier)) {
    level.hostage_pickup notify("_encstr_B2B00D0C111046F060178C1C2A0782");
    level.hostage_pickup.carrier thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_ABEC1F70C1FFEA0F9F8C6F6CB547BE256D893928D915553BF4E77E4C506D837D31", 4);
  }

  foreach(var_10 in var_2) {
    if(isDefined(var_10._id_11F64)) {
      objective_state(var_10._id_11F64, "_encstr_8267056410C669");
      scripts\cp\cp_objectives::freeworldidbyobjid(var_10._id_11F64);
    }
  }
}

onexplode(var_0) {
  objective_setplayintro(var_0, 1);
  objective_setplayoutro(var_0, 1);
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0);
  objective_icon(var_0, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_0, 0);
  objective_setlabel(var_0, &"_encstr_A75118C5BAEF2911E9DF4749CFC178814A84CE9D500CF9DFA0FB");
  objective_addalltomask(var_0);
  objective_showtoplayersinmask(var_0);
}

getvehicleplayerhorn(var_0) {
  var_1 = [];
  var_2 = "_encstr_834C02D8";
  var_0 = sortbydistance(var_0, level.hostage_pickup.origin);

  if(var_0[0].script_noteworthy != var_2) {
    var_0 = scripts\engine\utility::array_remove(var_0, var_0[0]);
    var_1[0] = var_0[0];
    var_1[1] = var_0[1];
    level thread _id_12DF1();
    return var_1;
  } else {
    var_0 = scripts\engine\utility::array_remove(var_0, var_0[1]);
    var_1[0] = var_0[0];
    var_1[1] = var_0[1];
    return var_1;
  }

  return;
}

_id_12DF1() {
  if(!isDefined(level._id_11F78)) {
    level thread scripts\cp\cp_wave_spawning::killstreaks(8, "_encstr_B1CD13CD5BBA3B9D7D0791F5DE07AC73B21ECCD263");
    level._id_11F78 = 1;
  }
}

_id_1354D(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_994C023A":
      var_1 = "_encstr_834A101DACC643DEFA1C34CBDCEBE8F6DDD8";
      var_2 = "_encstr_95F111732396985501800B211049F3E7A30E5A";
      break;
    case "_encstr_8B4C024C":
      var_1 = "_encstr_AF4A10A32BD8D0DBF5C10DCBCDAF1D7BDD66";
      var_2 = "_encstr_A2F11181FF5A5B08276288A24AFF08B7B31681";
      break;
    case "_encstr_834C02D8":
      var_1 = "_encstr_8D4A10D195D886F6F58334F2DCD73AEDBB46";
      var_2 = "_encstr_9B4A10130720FBB5B99A64734E27EB2FDF83";
      break;
    case "_encstr_A14C02D1":
      var_1 = "_encstr_864A1061ED5EC0C80773604A6B2F7D40F314";
      var_2 = "_encstr_B1F111E8DF2B489FC92A1B9BC2E1E11087265A";
      break;
    case "_encstr_934C02B2":
      var_1 = "_encstr_8C4A109B716E433D11119079EFE903978C63";
      var_2 = "_encstr_994A106B2BEF3C9FF62F7871461E3B053F02";
      break;
    case "_encstr_AB4C022B":
      var_1 = "_encstr_A54A105515FF78A7A983C858AB71595017ED";
      var_2 = "_encstr_B4F111E89536A1DEF5C143BC9BBEA3DBEE8923";
      break;
    case "_encstr_A74C0277":
      var_1 = "_encstr_8B4A108EB2360DF6D707A1E537FA47F6DD73";
      var_2 = "_encstr_8CF111380FFB984F799A4BCBB291B1A037F682";
      break;
  }

  level thread _id_12DD5(var_1);

  if(isDefined(var_2))
    level thread _id_12DD5(var_2);
}

_id_12DD5(var_0) {
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
      self stoppath(1);
      return;
    }
  }
}

getthirdpersonrangeforsize(var_0, var_1) {
  if(var_1 == "_encstr_834C02D8") {
    return;
  }
  var_2 = scripts\engine\utility::getStructArray("_encstr_82F610FDAB59379537187B82C8DF4BCFF09A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = sortbydistance(var_2, var_0);
  var_3 = [var_2[0], var_2[1], var_2[2]];
  var_4 = scripts\engine\utility::getclosest(level.hostage_pickup.origin, var_3);
  level thread playerhandlesandboxmenu();
  level thread _id_135ED(var_4);
  level thread _id_12DF1();
}

_id_135ED(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(!isDefined(var_1))
    var_1 = 450;

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
  level._id_13E36 = var_4;
  wait 6.5;
  var_4 thread tank_waittill_death();
  var_4 endon("_encstr_AD75063D571AE108");
  var_4 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 thread tank_hitmarkers();
  setheadiconsnaptoedges(var_4.headicon, 8000);
  var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_4, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_4, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  var_5 notsolid();
  var_6 notsolid();
  wait 5;

  for(;;) {
    var_7 = var_4 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_7)) {
      wait 1;
      continue;
    }

    if(istrue(var_7.binvehicle) && isDefined(var_7.vehicle)) {
      if(var_5 turretcantarget(var_7.vehicle.origin + (0, 0, 50)))
        var_5 settargetentity(var_7.vehicle);

      if(var_6 turretcantarget(var_7.vehicle.origin + (0, 0, 50)))
        var_6 settargetentity(var_7.vehicle);
    } else {
      var_5 _id_130F2(var_7, 9, var_1);
      var_6 settargetentity(var_7);
    }

    var_4 thread tank_shoot_at_target(var_6, 1);
    var_4 thread tank_shoot_at_target(var_5);
    wait(randomfloatrange(0.5, 1.5));
  }
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.headicon))
    setheadiconimage(self.headicon);

  if(isDefined(level._id_13E36))
    level._id_13E36 = undefined;
}

tank_shoot_at_target(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_3 = 0.1;
  var_4 = 1;
  var_5 = 0;

  if(!isDefined(var_2))
    var_2 = 2;

  if(istrue(var_1)) {
    var_4 = randomintrange(15, 25);
    var_5 = 1;
  }

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_0 shootturret();
    wait(weaponfiretime("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83") + var_5);
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

_id_130F2(var_0, var_1, var_2) {
  if(isPlayer(var_0) && isDefined(level.hostage_pickup.carrier) && level.hostage_pickup.carrier == var_0)
    self settargetentity(var_0);
  else {
    if(!isDefined(var_2))
      var_2 = 20;

    var_3 = randomfloatrange(var_2 * -1, var_2);
    var_4 = randomfloatrange(var_2 * -1, var_2);
    var_5 = randomfloatrange(var_2 * -1, var_2);
    self settargetentity(var_0, (var_3, var_4, var_5));
  }
}

first_convoy_lmgs() {
  var_0 = getEntArray("_encstr_931413D9C337B9A8DCEEB7CF1A852874476B53208A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread first_interaction();

  level waittill("_encstr_9A81266A7B1930FDE1859FD112D0486BE706E3FD1BE3F916E83E1FF7369A379BFE928023FF4027D8");
  var_4 = 10;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(level.spawn_module_intro)) {
    var_5 = level.spawn_module_intro.max_size;
    var_6 = level.spawn_module_intro.min_size;
    level.spawn_module_intro.max_size = var_4;
    level.spawn_module_intro.min_size = var_4;
  }

  _id_143A0(18);
  level._id_13593 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B6F119849EE397CB188116DB8983805ADB2770F30B12DD4BFAD709");
  level waittill("_encstr_9A81266A7B1930FDE1859FD112D0486BE706E3FD1BE3F916E83E1FF7369A379BFE928023FF4027D8");
  _id_143A0(18);
  level._id_13594 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B4F119D8892785ECF67D9B380BEE7359E4FA26AE2D63C82D37D9C8");

  foreach(var_2 in var_0)
  var_2 delete();

  if(isDefined(level.spawn_module_intro) && isDefined(var_6) && isDefined(var_5)) {
    level.spawn_module_intro.max_size = var_5;
    level.spawn_module_intro.min_size = var_6;
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

first_interaction() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    for(;;) {
      self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      break;
    }

    level notify("_encstr_9A81266A7B1930FDE1859FD112D0486BE706E3FD1BE3F916E83E1FF7369A379BFE928023FF4027D8");
    wait 1;
  }
}

kill_rate_watcher() {
  wait 10;
  scripts\cp\utility::_id_123FE("_encstr_9BC81FE76F9BB090225E10C9231F076BF183110D0A4AF65CAF6B1387A8B760D9EE");
}

obj_maj_defend_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("_encstr_91FB16B789A9FAB287A3C90B6CA3D7B4E6CCB727ADB073E8", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
  level notify("_encstr_AD771EB896AAB7A9782B60E06FAC2613523F20BE2D728DB377DF58E803C439B1");
}

obj_maj_extract_init(var_0) {
  level thread allow_hvt_stealing_by_ai();
}

obj_maj_extract_start(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_AB1D13872DB83977CFF3235A18AD93EA088F0E2FE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlocation(var_0.objectiveindex, 0, level.tugofwar_exfil_location.origin);
  objective_setlabel(var_0.objectiveindex, &"_encstr_93E11AEE17FF7105E7694753413FAFC83DA7A294F06508428C316B3B");
  objective_addalltomask(var_0.objectiveindex);
  objective_showtoplayersinmask(var_0.objectiveindex);
  level thread handle_hvt_go_outside(level.hostage_pickup);
  level _id_1240F();

  for(;;) {
    if(istrue(level.hostage_pickup.can_fulton)) {
      if(isDefined(level.hostage_pickup.carrier) || istrue(level.hostage_pickup.carried))
        level.hostage_pickup waittill("_encstr_88C60846397B83835919");

      if(istrue(level.hostage_pickup.can_fulton)) {
        break;
      }
    }

    wait 0.1;
  }

  level.hostage_pickup.interaction_handle setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");

  if(isDefined(level.hostage_pickup.sethotfunc))
    level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](0);

  level notify("_encstr_911B144403A2E5EF53B885B1587BB4F6D3417F2F0DC2");
  level._id_13E34 = 1;
  level thread _id_12401();
  objective_setlabel(var_0.objectiveindex, &"_encstr_96CA2A0FB9A009BBD5EAC22982D155989DC9F33929464369B7E3A45BCD93E80E7C81AD7FB0A61FFFA76A4CD4");
  objective_setlocation(var_0.objectiveindex, 0, level.hostage_pickup.origin + (0, 0, 96));
  level notify("_encstr_99A014182673A19EB8C7CD5EB1F36FCF047B5803DF4A");
  level.hostage_pickup.body hudoutlinedisable();
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(0);
  level thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  level thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  level thread scripts\cp\cp_convoy_manager::set_despawn_distance(4000);
  level.hostage_pickup_pos = level.hostage_pickup.origin;
  level thread _id_1356D();
  wait 1;
  little_bird_mg_deletenextframe();
  level thread thread_hostage_fulton_anims(level.hostage_pickup.body);
  wait 0.1;
  little_bird_mg_deletenextframe();
  wait 0.1;
  little_bird_mg_deletenextframe();
  level waittill("_encstr_8E1C0FB675401B1D1D41325A3871D61FD9", var_2, var_3);
  objective_unsetlocation(var_0.objectiveindex, 0);
  objective_addteamtomask(var_0.objectiveindex, "_encstr_AF8C0A1B6A1D6045925B4F7D");
  level _id_123E0();
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(6);
  wait 6;
  scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
}

_id_1356D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStructArray("_encstr_995217C551484753B5C7BF631F57FB8F807BBB4129B006DA01", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getclosest(level.hostage_pickup.origin, var_0);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin - (0, 0, 256));
  var_2 setModel("_encstr_A6541BDA5A8D4BE80B4EF27DE66DBC43EDF65BBE0EB0270B6C34AB3A56");
  var_2 notsolid();
  level waittill("_encstr_8FEB1878E0B997E84ACFBF8FCD4F1B5A11A0F6AEB713C033B047");

  if(isent(var_2))
    var_2 delete();
}

obj_maj_extract_end(var_0) {
  if(isDefined(level._id_13E36))
    level._id_13E36 dodamage(level._id_13E36.health + 100, level._id_13E36.origin);

  level thread nag_player_remind_lore_vo();
  level thread _id_12DEC();
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8D5311B3A74307D05D8B3B354F32CD10532B2D");
}

obj_maj_exit_init(var_0) {
  level notify("_encstr_830F1BACDC23FABB586756F5E8BAD9DE66BB854EBE37C18577375993CD");
}

obj_maj_exit_start(var_0) {
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("_encstr_95EA1D60E9738FF99191FD33B653DF0353EBD08FB8F9E29F3BED2DCC6085F0");
  waitframe();
  level notify("_encstr_91750BE60B41C076B37326D770", level.hostage_pickup_pos);
  level waittill("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  wait 4;
}

obj_maj_exit_end(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++)
    level.players[var_1].ability_invulnerable = 1;

  wait 3;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

debugbeatobjective(var_0) {
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
}

allow_player_mantles() {
  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0].disable_hvt_nomantle = 1;
}

location_objective_remover() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4761C5FE2E4814DA71A889123CF06C93F7DD1339C8F399B27B3E3794AB7");
  level.hostage_pickup endon("_encstr_A36913AC6D396F5727C89B41E84D8BF7F1DD01240B");
  var_0 = 250000;
  var_1 = level.hostage_pickup.origin;

  while(distance2dsquared(level.hostage_pickup.origin, var_1) < var_0)
    wait 1;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(istrue(level.players[var_2].disable_hvt_nomantle)) {
      level.players[var_2].disable_hvt_nomantle = undefined;

      if(isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier) && level.hostage_pickup.carrier == level.players[var_2])
        level.players[var_2] scripts\common\utility::allow_jump(0);
    }
  }
}

allow_hvt_stealing_by_ai() {
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  level thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1, 1);
  level thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
}

delay_allow_pickup() {
  var_0 = 10;
  wait(var_0);
  level notify("_encstr_9B2E154B90E8FBC5EBE90B92E027BB1B260CDFFFBBB3BB");
}

player_grabs_hostage(var_0) {
  level endon("_encstr_82350EE6A37B83F5CEC90B89BEDB9853");
  level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");
  level.hostage_pickup.pickedupbyplayer = 1;
  level notify("_encstr_82110E2B659031D94945A3CA98B953E2");
  level thread players_pickedup_hvt(var_0);
}

players_pickedup_hvt(var_0) {
  level notify("_encstr_82350EE6A37B83F5CEC90B89BEDB9853");
  level notify("_encstr_82110E2B659031D94945A3CA98B953E2");
  scripts\engine\utility::flag_set("_encstr_BA5D1516D863DEDDAF1BBD739DB7E5D74EF6B05B4B739D");
  binoculars_onstatemarkedenter(1.3);

  if(!istrue(level.all_convoys["_encstr_911A0B44D282E9AE50C08DB27A"].exiting))
    level spawn_hvt_waypoint();

  if(isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier) || !istrue(level.hostage_pickup.convoy_pickedup))
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"_encstr_844E20D713A1FE3135B785FC2FDAEA388893774BD398A8B1751EACF741FCC1C65013");
}

binoculars_onstatemarkedenter(var_0) {
  level._id_11F7A = var_0;
}

spawn_hvt_waypoint() {
  if(!isDefined(level.hostage_pickup.waypoint)) {
    var_0 = scripts\cp\cp_pickup_hostage::create_objective;
    level.hostage_pickup.nowaypoint = undefined;
    level.hostage_pickup.waypoint = level.hostage_pickup[[var_0]](level.hostage_pickup.origin + (0, 0, 30), "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
    objective_onentity(level.hostage_pickup.waypoint, level.hostage_pickup);
    objective_setzoffset(level.hostage_pickup.waypoint, 32);
    level.hostage_pickup.attach_entity = level.hostage_pickup;
  }
}

spawn_hvt_in_building() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  var_0 = scripts\engine\utility::getStructArray("_encstr_8F93151AB3A3AFE61CB0BB37ACC97D8EEAD9F633DD5893", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::random(var_0);
  var_0 = scripts\engine\utility::array_remove(var_0, var_1);
  level.obj_hvt_spawn_struct = var_1;
  level thread inithvtmodel(var_1.origin);
  scripts\engine\utility::flag_set("_encstr_B16E1563D3401712D4ABAB27817C7B6FB81B5E2B28F8A4");
}

inithvtmodel(var_0) {
  var_1 = "_encstr_A28C1C9BDA5D9D9D362B397DA5DC33B727B5C237D1FACCD5D8C698DBC8E5";
  var_2 = scripts\cp\cp_pickup_hostage::initdefaulthvtmodel;
  level.hostage_pickup = [[var_2]](var_0, var_1, undefined, &"_encstr_964B1D9717F87F7BD70D871C2B27A0512FC3B37D239F9930FDA7A1F191FCA3", "_encstr_8F060FE8EB15313E7F8ED4588AB721C53B", 0, "_encstr_A3CE0D9B4053345287FD8105D7BF2A");
  level.hostage_pickup.nowaypoint = 1;
  level.hostage_pickup.label = &"_encstr_844E20D713A1FE3135B785FC2FDAEA388893774BD398A8B1751EACF741FCC1C65013";

  if(!isDefined(level.hostage_pickup.interaction_handle))
    level.hostage_pickup waittill("_encstr_938B18DC0B609F2A80593F6B5B3EC31110909963233869B36D01");

  level.hostage_pickup.sethotfunc = ::hvtent_sethotfunc;
  level thread players_holding_hvt_handler();
  level notify("_encstr_8B9D101BC0D3B4D2077D0102DF338B66B923");
}

wait_player_near(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = cos(65);
  var_4 = 230;

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = var_4 * var_4;

  for(;;) {
    wait 0.25;

    if(istrue(var_2)) {
      var_6 = scripts\cp\utility::any_player_nearby(var_0, var_5);

      if(!var_6) {
        continue;
      }
      for(var_7 = 0; var_7 < level.players.size; var_7++) {
        var_8 = sighttracepassed(var_0, level.players[var_7] getEye(), 0, level.players[var_7]);

        if(var_8) {
          var_9 = scripts\engine\utility::within_fov(level.players[var_7].origin, level.players[var_7].angles, var_0 + (0, 0, 40), var_3);

          if(var_9)
            return;
        }
      }

      continue;
    }

    if(scripts\cp\utility::any_player_nearby(var_0, var_5))
      return;
  }
}

healthdraining_ui_set() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_92C50F19AC8D275958E6AC8CFA8D2DCC2B");
    var_0 = int(self.life_left * 100);
    level thread scripts\cp\utility::objective_update("_encstr_AB6811D8F6CAD7480EC328D8F759E0C9E15B43", undefined, undefined, undefined, 1, var_0, 2);
  }
}

hvtent_sethotfunc(var_0, var_1) {
  self notify("_encstr_A1BE0BDC561DD07B4799579BD8");
  self endon("_encstr_A1BE0BDC561DD07B4799579BD8");
  self endon("_encstr_BAA50F4626B18F0FCF18A2AAE801840B69");
  level endon("_encstr_911B144403A2E5EF53B885B1587BB4F6D3417F2F0DC2");

  while(!isDefined(self.waypoint))
    wait 1;

  var_2 = 90000;
  objective_setshowprogress(self.waypoint, 1);

  if(!isDefined(self.life_left)) {
    thread healthdraining_ui_set();
    self.life_left = 1;
    objective_setprogress(self.waypoint, 1);
    level._id_11F7A = 2.5;
  }

  if(self.life_left <= 0.01) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  if(istrue(var_0)) {
    objective_sethot(self.waypoint, 1);

    for(;;) {
      if(isDefined(self.carrier) && isPlayer(self.carrier)) {
        break;
      }

      if(!isDefined(self) || !isDefined(self.life_left)) {
        break;
      }

      if(spawnglobalscriptabledelayed(var_2)) {
        self.life_left = self.life_left - 0.01 * var_1;
        self notify("_encstr_92C50F19AC8D275958E6AC8CFA8D2DCC2B");

        if(self.life_left <= 0.01) {
          level thread hvt_death();
          return;
        } else
          objective_setprogress(self.waypoint, self.life_left);

        if(self.life_left % 0.05 == 0 && self.life_left > 0) {
          var_3 = int(self.life_left * 100);
          level thread set_hvt_label_life(var_3);
        }
      }

      wait(level._id_11F7A);
    }
  } else
    objective_sethot(self.waypoint, 0);
}

spawnglobalscriptabledelayed(var_0) {
  if(isDefined(level.tugofwar_exfil_location)) {
    if(distancesquared(self.origin, level.tugofwar_exfil_location.origin) > var_0)
      return 1;
    else {
      self setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
      return 0;
    }
  } else
    return 1;
}

wait_for_hvt_near_exfil(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BAB50F298EEB09D87FF2933E9A2384E085");
  var_2 = 300;
  var_3 = var_0.script_noteworthy;

  if(var_1 == "_encstr_A71804587AF2") {
    var_4 = distance(level.hostage_pickup.origin, var_0.origin);
    var_5 = var_4 * 0.75;

    if(var_2 < var_5)
      var_2 = var_5;
  }

  var_6 = var_2 * var_2;

  for(;;) {
    wait 0.25;

    if(distancesquared(level.hostage_pickup.origin, var_0.origin) < var_6) {
      break;
    }
  }

  level notify("_encstr_BAB50F298EEB09D87FF2933E9A2384E085", var_3, var_1);
}

set_hvt_label_life(var_0) {
  var_1 = &"_encstr_844E20D713A1FE3135B785FC2FDAEA388893774BD398A8B1751EACF741FCC1C65013";

  switch (var_0) {
    case 100:
      var_1 = &"_encstr_95E61D6814BE4DD4AAD1E826542979A4C9C8A7495305278ABE4205FA988181";
      break;
    case 95:
      var_1 = &"_encstr_8BFC1C506FC8273DD9F7C7C41B096D97980528C954AF1B23B1F128CFDB6A";
      break;
    case 90:
      var_1 = &"_encstr_9AFC1C68A0AFD4A6AA8E3AC48AA4CB25938CD3A49A28722AEB4205D7E418";
      break;
    case 85:
      var_1 = &"_encstr_BAFC1C0D28FAD453AA3AA3622A25F2929364A7945350C92AAF0914F5E04D";
      break;
    case 80:
      var_1 = &"_encstr_95FC1C1A0AFAD46A558E74C4514997252719F44953823915FA2414FA0E03";
      break;
    case 75:
      var_1 = &"_encstr_A7FC1C3392283198CF31EFC4EDB390A3DE5C34F34529817F76D0F040E702";
      break;
    case 70:
      var_1 = &"_encstr_A3FC1C9B17BEC7B947D71470B5229DEF930C8193A0F7DE358E43CB5147D7";
      break;
    case 65:
      var_1 = &"_encstr_82FC1C201FB8574D89A77774CBD99D4748B578B9041FEBF30181781F35DA";
      break;
    case 60:
      var_1 = &"_encstr_8EFC1C43A1F9D23FA5FD68E0851EFE1C29E537DA03A12D8348F411D98347";
      break;
    case 55:
      var_1 = &"_encstr_ABFC1C06DF2983186D4FA78323B666C109A58DDA94215641404983D7FBED";
      break;
    case 50:
      var_1 = &"_encstr_93FC1C18A997F217B7B457445DBF568C4DF14081F903FD0BAE0B485F7DCB";
      level thread play_lost_health_vo();
      break;
    case 45:
      var_1 = &"_encstr_AFFC1C6EB0A15FA3BB95874D4FA1C20170181C21052FE54BD9A3DF77637B";
      break;
    case 40:
      var_1 = &"_encstr_83FC1CD18B97AF5BE9670C81CFB1D7543E7B29D10761C45111DC9F308B6F";
      break;
    case 35:
      var_1 = &"_encstr_A9FC1C67B009417187B82D34E0E308D9153EF7FD056651258760C75EAF56";
      break;
    case 30:
      var_1 = &"_encstr_B4FC1C4FE190097599C5F70DBD992F60C055F7F333376024A14C3AC19B62";
      break;
    case 25:
      var_1 = &"_encstr_88FC1C2B1947E9998B9167EC9DC72EE8600D2F51A081E4F107D1AB68FE6E";
      break;
    case 20:
      var_1 = &"_encstr_85FC1C4EFA194F4CB5C7E9A9D7EA48337017D04E0550AD9757D3593962A0";
      level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_8D552178B23801B07B3DFC497595E038A654E7912DA75D1F0DE7A7B564D7A13DF33599", "_encstr_9A8507BA4040188D08", 4);
      break;
    case 15:
      var_1 = &"_encstr_ADFC1C2D701F4E85319F1FCB35C1A881EE50080DF73504970728A7F626A3";
      break;
    case 10:
      var_1 = &"_encstr_96FC1CF73381DE11D557651CCFFACA1B28C3775D3F0808E1077C8F76FAE0";
      break;
    case 5:
      var_1 = &"_encstr_BDFC1C9E2AC99F9C65371979075A1863E447609EF5801DE70763A9E93AD5";
      break;
    case 0:
      var_1 = &"_encstr_844E20D713A1FE3135B785FC2FDAEA388893774BD398A8B1751EACF741FCC1C65013";
      break;
  }

  if(isDefined(var_1))
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(var_1, 1);
}

hvt_death() {
  level notify("_encstr_A36913AC6D396F5727C89B41E84D8BF7F1DD01240B");
  level._id_11F62 = 1;
  level thread set_hvt_label_life(0);
  level play_hostage_dead_vo();
  scripts\cp\cp_objectives::_id_12868("_encstr_AFD016B7C4A9BE96B9CCDBC9B6C2E6A3AF89C6568CEDD5E8");
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

handle_hvt_go_outside(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_A25F0710622DF3B3D7");
  level endon("_encstr_8E1C0FB675401B1D1D41325A3871D61FD9");

  if(!isDefined(var_0.hostage_drop_override_data))
    var_0.hostage_drop_override_data = spawnStruct();

  var_1 = "_encstr_B40101";

  for(;;) {
    wait 0.1;

    if(istrue(var_0.carried_by_vehicle)) {
      if(var_1 == "_encstr_BD79059C51C351") {
        continue;
      }
      var_1 = "_encstr_BD79059C51C351";
      var_0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"_encstr_8C5B28A1A0BEA953AAD1D1C4A29279A70925EB259319E92935A0398AD7A22C2A4AA03415EB753D49C422");
      var_0.can_fulton = 0;

      if(!isDefined(var_0.hostage_drop_override_data))
        var_0.hostage_drop_override_data = spawnStruct();

      var_0.hostage_drop_override_data.preventuse = 0;
      continue;
    }

    if(!passed_all_sky_traces(var_0)) {
      if(var_1 == "_encstr_BD79059C51C351") {
        continue;
      }
      var_1 = "_encstr_BD79059C51C351";
      var_0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"_encstr_994F22CE17E14BC0A5871FCB7BCE2E9FD1FC71C44C412F6991A333A36718F1DCF1643F5F");
      var_0.can_fulton = 0;

      if(!isDefined(var_0.hostage_drop_override_data))
        var_0.hostage_drop_override_data = spawnStruct();

      var_0.hostage_drop_override_data.preventuse = 0;
      continue;
    }

    if(var_1 == "_encstr_9B0D05E058E6CD") {
      continue;
    }
    var_1 = "_encstr_9B0D05E058E6CD";
    var_0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"_encstr_8C5B28A1A0BEA953AAD1D1C4A29279A70925EB259319E92935A0398AD7A22C2A4AA03415EB753D49C422");
    var_0.can_fulton = 1;

    if(!isDefined(var_0.hostage_drop_override_data))
      var_0.hostage_drop_override_data = spawnStruct();

    var_0.hostage_drop_override_data.preventuse = 1;
    var_0.hostage_drop_override_data.waittime = 3;
  }
}

passed_all_sky_traces(var_0) {
  var_1 = 0;
  var_1 = pos_passes_sky_trace(var_0.origin);

  if(var_1 == 0)
    return 0;

  var_1 = pos_passes_sky_trace(var_0.origin, (500, 0, 3000));

  if(var_1 == 0)
    return 0;

  var_1 = pos_passes_sky_trace(var_0.origin, (-500, 0, 3000));

  if(var_1 == 0)
    return 0;

  var_1 = pos_passes_sky_trace(var_0.origin, (0, 500, 3000));

  if(var_1 == 0)
    return 0;

  var_1 = pos_passes_sky_trace(var_0.origin, (0, -500, 3000));
  return var_1;
}

pos_passes_sky_trace(var_0, var_1) {
  var_2 = (0, 0, 3000);

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = var_0;
  var_4 = var_0 + var_2;

  if(var_4[2] <= var_3[2])
    return 0;

  var_5 = scripts\engine\trace::_bullet_trace_passed(var_3, var_4, 0, undefined);
  return var_5;
}

convoy_start() {
  if(!isDefined(level.hostage_pickup))
    level waittill("_encstr_8B9D101BC0D3B4D2077D0102DF338B66B923");

  level.convoy_speed_override = 30;
  var_0 = scripts\engine\utility::getStruct("_encstr_B84C14277790C3CF507E529B51E01CA9789FFBF3C167", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_AC08175707A281D8ED5A20F98581804CDED7C1F3CF9ADBF0FF";
  var_2 = "_encstr_911A0B44D282E9AE50C08DB27A";
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_2, var_1, var_0, undefined, undefined, undefined);

  if(!isDefined(var_4)) {
    return;
  }
  level thread convoy_init_settings(var_4);
  wait 0.1;
  level thread convoy_think_handler(var_4);
  wait 3;
  level notify("_encstr_A7731DEF08E01F03C7CE5D15AC7F3BE7ABA8536348B95A0BEF5D260A1C03A3");
}

convoy_init_settings(var_0) {
  var_0 thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  var_0 thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  var_0 thread scripts\cp\cp_convoy_manager::set_hide_icon_on_pickup_target(0);
  var_0 thread scripts\cp\cp_convoy_manager::set_convoy_targeted_hvt(level.hostage_pickup);
  var_0 thread scripts\cp\cp_convoy_manager::_id_130ED(1);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_pickup(0);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_convoy_death(0);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_nearby_convoy(0);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_rescued(0);
  var_0 thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1);
  var_0 thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_amount(8);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_time_btwn(3);
  var_0 thread scripts\cp\cp_convoy_manager::set_soldier_backup_deposit_names("_encstr_84041486B34BF5E4EA37E8BDF58DDE1B58E82DB7DCDC");
  var_0 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_can_compromise_before_1st_target(0);
  var_0 thread scripts\cp\cp_convoy_manager::_id_130FE("_encstr_91970A2D893EB8664FC243AB");
  var_0 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_vehicles(0);
  var_0 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_support_vehicles(0);
  var_0 thread scripts\cp\cp_convoy_manager::allow_routing_to_any_vehicles(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(0);
  var_0 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
  var_0 thread play_truck_anim(var_0);
  var_0.convoy_paths_override = "_encstr_88D4166ED6BA76CE1BAC39EB6CB7DC9DBD5EFA380B3A349B";
}

convoy_think_handler(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;
  var_0 thread scripts\cp\cp_convoy_manager::set_convoy_target(level.hostage_pickup, undefined, undefined);
  var_0 thread scripts\cp\cp_convoy_manager::set_unload_at_target(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_stop_all_cars(0);

  if(!istrue(var_1))
    wait 10;

  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_distance(4000);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(12);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(1000);
  var_0 thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(0);

  if(getdvarint("_encstr_ADAE18DBC8624191896340E122A73FDE099BE2707489AC322763", 0) == 0) {
    foreach(var_3 in var_0.spawned_vehicles)
    var_3 thread temp_vehicle_manuallysetspeed();
  }

  if(!istrue(var_0.allowed_to_exit))
    var_0 waittill("_encstr_B2371C528850B3B5B8C7E5F04338FC0B0C26CA8A73BDEBE1C8B31BFB4340");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 scripts\cp\cp_convoy_manager::set_convoy_durations_modifier(425);
  level notify("_encstr_838A10B72E120FC3CD73619337E1D8BBBA97");
  var_0 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-1000);
  var_0 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  var_0.main_truck thread play_convoy_hostage_save_vo();
  var_0 thread hudnumconsumed(var_0);
  var_0.main_truck vehicleshowonminimap(1);
  var_0.main_truck aiupdatecoverexposetype(1);
  level thread setup_waves_truck_section();
  var_0 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_compromise_megahealth(1);
  level thread convoy_damaged_tires(var_0);
  var_5 = scripts\cp\utility::getvehiclearray();
  var_6 = [];

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    if(isDefined(var_5[var_7].team) && var_5[var_7].team == "_encstr_9A8507BA4040188D08")
      var_6[var_6.size] = var_5[var_7];
  }

  var_0 waittill("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  level thread scripts\cp\cp_convoy_manager::toggle_convoy_wheel_outlines(0);
  level thread play_convoy_hostage_vo();
}

temp_vehicle_manuallysetspeed() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_82F90FEBADB95B9369883BF218BF4FDF53");
    self vehicle_setspeed(level.convoy_speed_override, 10, 10);
  }
}

hudnumconsumed(var_0) {
  var_0 endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  var_0 endon("_encstr_A3E5145B2888AB302AC6B1F8FE15103B3889DD49CB30");
  var_1 = var_0.main_truck;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = 22500;

  while(isalive(var_1)) {
    var_3 = var_1.origin;
    wait 5;
    var_4 = var_1.origin;

    if(distancesquared(var_4, var_3) < var_2)
      var_0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
  }
}

hvt_wait_for_pickup() {
  level.hostage_pickup scripts\engine\utility::_id_143A5("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385", "_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");
  level spawn_hvt_waypoint();
  level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"_encstr_844E20D713A1FE3135B785FC2FDAEA388893774BD398A8B1751EACF741FCC1C65013");
}

convoy_damaged_tires(var_0) {
  var_1 = 0;

  for(;;) {
    if(var_1 >= 3) {
      break;
    }

    var_0 waittill("_encstr_ADB413354F5A6BF884B71E70DD63B88843E39BABC3");
    var_1 = var_1 + 1;
  }

  wait 1.5;
  var_0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
}

playerhandlesandboxmenu() {
  level.blueprintextract_trygetreward = 0;
  level.bmoendgameot = "_encstr_A5B00F4AB8E8356BE8A99BA7CDA9827CD0";
  level.blueprintextract_shouldgivereward = "_encstr_AF3B1C2F6B92C3F06E1FE6FB457708061AE3ABB11F699580BD72A8302B35";
  level.blueprintextractchance = 400;
}

spawn_intro_soldiers() {
  level.spawn_module_intro2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47");
  level._id_13595 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A24D1FAD951B7BC123E3F97EAF882616EF33CFD098EB1562CBD958CB076CB35FAF");
  wait 0.1;
  level.spawn_module_intro = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_84FE10129B386DEBCB48FA61711D3722E83F");
  level._id_13596 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A146118EE32A6139D91398615FE6509132CAFE");
  level._id_13597 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B1B20D75C5F4C895077A7966A3BBDC");
}

first_bleedout() {
  var_0 = getEntArray("_encstr_99DE1760A719E0A1F2C5E4E01D2AFF087B77C0784FA69969DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread firing_start_locs();
}

firing_start_locs() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getEnt(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0))
    thread firestation_jugg_test(var_0);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  if(isDefined(var_0))
    var_0 delete();

  var_2 = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = "_encstr_8A78055C8D488C";

  if(isDefined(var_2.script_noteworthy))
    var_3 = var_2.script_noteworthy;

  var_4 = 1000;

  if(isDefined(var_2.script_grenadespeed))
    var_4 = int(var_2.script_grenadespeed);

  var_5 = vectorNormalize(anglesToForward(var_2.angles));
  var_6 = var_5 * var_4;

  if(isDefined(var_2.script_timer)) {
    var_7 = float(var_2.script_timer);
    var_8 = magicgrenademanual("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", var_2.origin, var_6, var_7);
  } else
    var_8 = magicgrenademanual("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", var_2.origin, var_6, 2.25);

  if(isDefined(var_8))
    thread firestation_jugg_spawn(var_8);
}

firestation_jugg_spawn(var_0) {
  var_0 endon("_encstr_8F5C086405E70FBA4B4A");
  var_0 waittill("_encstr_860808CB78E2984063BA", var_1);
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  if(var_2.size > 0) {
    var_3 = scripts\engine\utility::getclosest(var_1, var_2);
    var_3 radiusdamage(var_1, 256, 140, 70, var_3, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", getcompleteweaponname("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B"));
  } else
    radiusdamage(var_1, 256, 140, 70, undefined, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", getcompleteweaponname("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B"));
}

firestation_jugg_test(var_0) {
  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  if(isDefined(var_0)) {
    wait 0.05;
    var_0 delete();
  }

  if(isDefined(self))
    self delete();
}

_id_131E9() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9ADD0D56DCACB6F2AF3756CDA34E97", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0)
  thread _id_131EA(var_2);
}

_id_131EA(var_0) {
  var_1 = "_encstr_AB8E0E73E9709BD298E7141D95E8DF43";
  var_2 = level.sentrysettings[var_1];
  var_3 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0.origin, level.sentrysettings[var_1].weaponinfo);
  var_3.team = "_encstr_8E8405EA382B2A";

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_3.angles = var_0.angles;
  var_3.health = var_2.maxhealth;
  var_3.maxhealth = var_2.maxhealth;
  var_3.sentrytype = var_1;
  var_3.momentum = 0;
  var_3.heatlevel = 0;
  var_3.overheated = 0;
  var_3.cooldownwaittime = 2;
  var_3.turrettype = "_encstr_AB8E0E73E9709BD298E7141D95E8DF43";
  var_3 setModel("_encstr_B12D1BBBEAE62128738F6C69B74711B7CA7240E07338C70377CAF65574");
  var_3 setturretteam("_encstr_8E8405EA382B2A");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 setautorotationdelay(0.2);
  var_3 maketurretinoperable();
  var_3 setleftarc(80);
  var_3 setrightarc(80);
  var_3 setbottomarc(50);
  var_3 settoparc(60);
  var_3 setconvergencetime(0.6, "_encstr_BD6506F36A2B46B0");
  var_3 setconvergencetime(0.6, "_encstr_AF1904C7E3A4");
  var_3 setconvergenceheightpercent(0.65);
  var_3 setdefaultdroppitch(-89.0);
  var_3 setturretmodechangewait(1);
  var_3 solid();
  var_3 scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  var_3 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  var_3 scripts\cp_mp\emp_debuff::allow_emp(0);
  wait 1;
  var_3 setmode("_encstr_97910BA3154320F8EBBA8811A2");
  var_3 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_3 sentryturret_empupdate();
  var_3 thread scripts\mp\carriable::is_attack_available();
  var_3 thread sentry_attacktargets();
  var_3 thread sentry_handledeath();
  var_3 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  return var_3;
}

sentryturret_empstarted(var_0) {
  sentryturret_empupdate();
}

sentryturret_empcleared(var_0) {
  if(var_0) {
    return;
  }
  sentryturret_empupdate();
}

sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode("_encstr_97910BA3154320F8EBBA8811A2");
  }
}

node_fields_after_goal_skit() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.origin;
  var_1 = 0.05;
  var_2 = int(var_1 * 20);

  for(;;)
    wait(var_1);
}

sentry_attacktargets() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F", "_encstr_A36A07BB6038639701");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_targetlocksound() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  wait 0.1;
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  wait 0.1;
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      self shootturret();
      self notify("_encstr_8FCA0D31D5D8C656E8BE664B4E2B19");
      self.heatlevel = self.heatlevel + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

sentry_burstfirestop() {
  self notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
}

sentry_heatmonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1)
      wait(var_0);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    var_1 = self.heatlevel;
    wait 0.05;
  }
}

playheatfx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");
  self endon("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"), self, "_encstr_A14F0AE336178944BA076F41");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

sentry_beepsounds() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  }
}

sentry_handledeath() {
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  self setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_88B20850478F501332D3");

  if(isDefined(self))
    thread sentry_deleteturret();
}

sentry_deleteturret() {
  self notify("_encstr_8C79155A3555CBE2BA61333FD011BC825FD5A39226FB03");
  self endon("_encstr_8C79155A3555CBE2BA61333FD011BC825FD5A39226FB03");
  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self, "_encstr_8E300878E04AE8B18198");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
  self playSound("_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
  wait 0.1;
  self notify("_encstr_990D093256B156D1B4B93B");

  if(isDefined(self))
    self delete();
}

spawn_escalation_soldiers() {
  level thread handle_escalation_increases();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

anim_init_trafficking() {
  level.scr_animtree["_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883"] = #animtree;
  level.scr_anim["_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"] = % _encstr_AA952E6E32E4D71B0EAFD0BDDC1D163B597DC89CDE1CF66633F5DA6DB41BB719CCF53616399CF2D7E65BAB3BD98DCA4E;
  level.scr_animname["_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"] = "_encstr_AA952E6E32E4D71B0EAFD0BDDC1D163B597DC89CDE1CF66633F5DA6DB41BB719CCF53616399CF2D7E65BAB3BD98DCA4E";
  level.scr_eventanim["_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"] = "_encstr_AA952E6E32E4D71B0EAFD0BDDC1D163B597DC89CDE1CF66633F5DA6DB41BB719CCF53616399CF2D7E65BAB3BD98DCA4E";
  level.scr_animtree["_encstr_BDC91355331AB7A917DFC0B1E756E1FF335D47D0CB"] = #animtree;
  level.scr_anim["_encstr_BDC91355331AB7A917DFC0B1E756E1FF335D47D0CB"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"] = % _encstr_826F279BD5AB9F0639294A322059FE0721D01412F833978FCD11020AE851B59A53B890B70E1BF797E3;
  level.scr_animname["_encstr_BDC91355331AB7A917DFC0B1E756E1FF335D47D0CB"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"] = "_encstr_826F279BD5AB9F0639294A322059FE0721D01412F833978FCD11020AE851B59A53B890B70E1BF797E3";
  level.scr_eventanim["_encstr_BDC91355331AB7A917DFC0B1E756E1FF335D47D0CB"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"] = "_encstr_826F279BD5AB9F0639294A322059FE0721D01412F833978FCD11020AE851B59A53B890B70E1BF797E3";
  anim_init_truck();
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

anim_init_truck() {
  level.scr_animtree["_encstr_82E90F3A579DF699DD164E7DA393BA36D6"] = #animtree;
  level.scr_anim["_encstr_82E90F3A579DF699DD164E7DA393BA36D6"]["_encstr_A5E0101DBA73E77047B30BA0779808399A25"] = % _encstr_A23829C3EB924FE38723215202F05E41BBD64C5C047AEF087E6719687BED11B7B12A9F48DD5243D1679F68;
  level.scr_anim["_encstr_82E90F3A579DF699DD164E7DA393BA36D6"]["_encstr_A1910CCC8E1B3F7417B85AC28065"] = % _encstr_919826399C7F19E767D326C39F72083812E1BDAD39E670A3BB9A3E33835FDE08E1289B67D44D787D;
}

play_truck_anim(var_0) {
  while(!isDefined(var_0.main_truck))
    wait 0.1;

  wait 0.1;
  var_1 = var_0.main_truck;
  var_1 thread truck_waittill_death();
  var_2 = (-80, 0, 82);
  var_3 = scripts\cp\cp_vehicles::spawn_ai_in_truck;
  level thread[[var_3]](var_1, 1, undefined, 0, undefined, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", var_2, 1, ::_id_144AA);
  var_1 endon("_encstr_AD75063D571AE108");
  var_4 = level.scr_anim["_encstr_82E90F3A579DF699DD164E7DA393BA36D6"]["_encstr_A5E0101DBA73E77047B30BA0779808399A25"];
  var_5 = level.scr_anim["_encstr_82E90F3A579DF699DD164E7DA393BA36D6"]["_encstr_A1910CCC8E1B3F7417B85AC28065"];

  while(isent(var_1)) {
    var_1 vehicleplayanim(var_5);
    waitframe();
    var_1 vehicleplayanim(var_4);
    wait 20;
  }
}

truck_waittill_death() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  var_0 = scripts\cp\utility::get_closest_living_player();
  wait 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_B619103363B09DDE93F5387B37A5474B3BCA", undefined, 1.0);
}

setup_trafficking_soldier_anims(var_0, var_1) {
  level endon("_encstr_B2371C528850B3B5B8C7E5F04338FC0B0C26CA8A73BDEBE1C8B31BFB4340");
  self waittill("_encstr_81551253E51F5715132A6AA6FBFC875A6925A0C8");
  thread anim_trafficking_soldier_play();
}

anim_trafficking_soldier_play() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = level.all_convoys["_encstr_911A0B44D282E9AE50C08DB27A"].main_truck;
  var_1 = (0, 0, 0);
  var_2 = (-185, 18, -64);
  var_3 = rotatevector(var_2, var_0.angles);
  var_4 = var_0 gettagorigin("_encstr_93011173A849F7BA7706E71A7607C389168ADE") + var_3;
  var_5 = getstartorigin(var_0.origin, var_0.angles, level.scr_anim["_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883"]["_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97"]);

  if(isent(var_0))
    var_1 = var_0.angles;

  level.hostage_pickup.body hide();
  self hide();
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self.og_health = self.health;
  self.og_maxhealth = self.maxhealth;
  self.maxhealth = 99999;
  self.health = 99999;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_6 setModel(self.model);
  var_6.angles = self.angles;
  var_6.animname = "_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97";
  var_6 useanimtree(level.scr_animtree["_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883"]);
  var_6.head = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_6.head setModel(self.headmodel);

  if(var_6.model == "_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B")
    var_6.head linkTo(var_6, "_encstr_BDAB07BA596A43E9EB", (-8, 1, 0), (0, 0, 0));
  else
    var_6.head linkTo(var_6, "_encstr_BDAB07BA596A43E9EB", (-21, 1, 0), (0, 0, 0));

  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.hostage_pickup.origin);
  var_7 setModel(level.hostage_pickup.bodymodel);
  var_7.angles = level.hostage_pickup.angles;
  var_7.animname = "_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97";
  var_7 useanimtree(level.scr_animtree["_encstr_BDC91355331AB7A917DFC0B1E756E1FF335D47D0CB"]);
  var_8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_6, "_encstr_8CD2115BB0D7CD8BE3B772A756086BD7139883");
  var_8 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_9 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_7, "_encstr_BDC91355331AB7A917DFC0B1E756E1FF335D47D0CB");
  var_9 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_10 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  thread scripts\cp\utility::drawsphere(var_10.origin, 5, 9999, (0, 1, 1));
  thread buildweapon_blueprint();
  level thread bunker_initinteraction(var_10, var_8, var_9);
  wait 11;
  level.hostage_pickup.body show();
  var_10 scripts\cp_mp\anim_scene::anim_scene_stop(1);
  var_6.head delete();
  reset_guy(self, var_5, var_1);
  wait 1;
  var_6 delete();
  var_7 delete();
}

buildweapon_blueprint() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  self hide();
  wait 0.5;
  self hide();
  wait 0.5;
  self hide();
  wait 0.5;
  self hide();
}

anim_trafficking_play_scene_soldier(var_0, var_1) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97", undefined, undefined, undefined, 0, 0);
}

anim_trafficking_play_scene_informant(var_0, var_1) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97", undefined, undefined, undefined, 0, 0);
}

bunker_initinteraction(var_0, var_1, var_2) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1, var_2], "_encstr_B29415CBB0E21FEAA18BBB338F0ADA3B98D750EBB5BF97", undefined, undefined, undefined, 0, 0);
}

reset_guy(var_0, var_1, var_2) {
  var_0 allowedstances("_encstr_922406F1A6FD5E05", "_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0 setCanDamage(1);
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
  var_0.origin = getclosestpointonnavmesh(var_1);
  var_0.angles = var_2;
  var_0.health = int(min(var_0.og_health, 400));
  var_0.maxhealth = int(min(var_0.og_maxhealth, 400));
  var_0 show();

  if(istrue(var_0.never_kill_off))
    var_0.never_kill_off = 0;
}

register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("_encstr_8C892A135786BB3BAF20323B48DDF99BF83E8C8078A97BC74BD00AB1B0D76A7FB3A5DF0388B03BCD7B28327A") || !scripts\engine\utility::flag("_encstr_8C892A135786BB3BAF20323B48DDF99BF83E8C8078A97BC74BD00AB1B0D76A7FB3A5DF0388B03BCD7B28327A")) {
    scripts\engine\utility::flag_set("_encstr_8463204B1FCEF343D7686A73F01531632086C4C82011A30F83884209780F32377B6D");
    scripts\engine\utility::flag_wait("_encstr_8C892A135786BB3BAF20323B48DDF99BF83E8C8078A97BC74BD00AB1B0D76A7FB3A5DF0388B03BCD7B28327A");
  }

  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\coop_stealth::coop_stealth_init();
  var_1 = 18;
  [[var_0]]("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", var_1, var_1, var_1, 0.1, 0, "_encstr_84FE10129B386DEBCB48FA61711D3722E83F", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", undefined, 10000, 20000);
  [[var_0]]("_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47", 1, 1, 1, 0.1, 0, "_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47", undefined, 20000, 30000);
  [[var_0]]("_encstr_A24D1FAD951B7BC123E3F97EAF882616EF33CFD098EB1562CBD958CB076CB35FAF", 1, 1, 1, 0.1, 0, "_encstr_A24D1FAD951B7BC123E3F97EAF882616EF33CFD098EB1562CBD958CB076CB35FAF", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47", undefined, 20000, 30000);
  [[var_0]]("_encstr_A146118EE32A6139D91398615FE6509132CAFE", 2, 2, 2, 8, 0, "_encstr_A146118EE32A6139D91398615FE6509132CAFE", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A146118EE32A6139D91398615FE6509132CAFE", ::playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A146118EE32A6139D91398615FE6509132CAFE", undefined, 20000, 30000);
  [[var_0]]("_encstr_B1B20D75C5F4C895077A7966A3BBDC", 2, 2, 2, 12, 0, "_encstr_B1B20D75C5F4C895077A7966A3BBDC", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1B20D75C5F4C895077A7966A3BBDC", ::playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B1B20D75C5F4C895077A7966A3BBDC", undefined, 20000, 30000);
  [[var_0]]("_encstr_B6F119849EE397CB188116DB8983805ADB2770F30B12DD4BFAD709", 4, 4, 4, 0.1, 0, "_encstr_B6F119849EE397CB188116DB8983805ADB2770F30B12DD4BFAD709", undefined, undefined, undefined);
  [[var_0]]("_encstr_B4F119D8892785ECF67D9B380BEE7359E4FA26AE2D63C82D37D9C8", 4, 4, 4, 0.1, 0, "_encstr_B4F119D8892785ECF67D9B380BEE7359E4FA26AE2D63C82D37D9C8", undefined, undefined, undefined);
  [[var_0]]("_encstr_BE471435F621CF5D8398A2DA50A794D71954AB97AF83", 0, 1, 250, 20, 0, "_encstr_BE471435F621CF5D8398A2DA50A794D71954AB97AF83", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_A33710EF824B85C7D9C6AF90CD034883701B", 0, 10, 250, 20, 0, "_encstr_A33710EF824B85C7D9C6AF90CD034883701B", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_9A8E13D1D5CEF699BB2CC9FAB2F0335A63BE86EC8E", 1, 1, 1, 0.1, 0, "_encstr_9A8E13D1D5CEF699BB2CC9FAB2F0335A63BE86EC8E", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9A8E13D1D5CEF699BB2CC9FAB2F0335A63BE86EC8E", ::setup_hostage_fulton_anims);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_9A8E13D1D5CEF699BB2CC9FAB2F0335A63BE86EC8E", undefined, 20000, 30000);
  [[var_0]]("_encstr_920F1AA58E25D2BE20291723E01B6E5AFD88EA1E64A3FAFF0B20472E", 4, 4, 4, 0.1, 0, "_encstr_920F1AA58E25D2BE20291723E01B6E5AFD88EA1E64A3FAFF0B20472E", undefined, undefined, undefined);
  [[var_0]]("_encstr_870F1AB1269CB03BB7F5371C2CEECD95E4BE9B2CCCCAD0BD5D6EB219", 4, 4, 4, 0.1, 0, "_encstr_870F1AB1269CB03BB7F5371C2CEECD95E4BE9B2CCCCAD0BD5D6EB219", undefined, undefined, undefined);
  [[var_0]]("_encstr_8C4A109B716E433D11119079EFE903978C63", 6, 6, 6, 0.1, 0, "_encstr_8C4A109B716E433D11119079EFE903978C63", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8C4A109B716E433D11119079EFE903978C63", ::playerhumanconcusspush);
  [[var_0]]("_encstr_8D4A10D195D886F6F58334F2DCD73AEDBB46", 6, 6, 6, 0.1, 0, "_encstr_8D4A10D195D886F6F58334F2DCD73AEDBB46", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8D4A10D195D886F6F58334F2DCD73AEDBB46", ::playerhumanconcusspush);
  [[var_0]]("_encstr_AF4A10A32BD8D0DBF5C10DCBCDAF1D7BDD66", 6, 6, 6, 0.1, 0, "_encstr_AF4A10A32BD8D0DBF5C10DCBCDAF1D7BDD66", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AF4A10A32BD8D0DBF5C10DCBCDAF1D7BDD66", ::playerhumanconcusspush);
  [[var_0]]("_encstr_864A1061ED5EC0C80773604A6B2F7D40F314", 6, 6, 6, 0.1, 0, "_encstr_864A1061ED5EC0C80773604A6B2F7D40F314", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_864A1061ED5EC0C80773604A6B2F7D40F314", ::playerhumanconcusspush);
  [[var_0]]("_encstr_A54A105515FF78A7A983C858AB71595017ED", 6, 6, 6, 0.1, 0, "_encstr_A54A105515FF78A7A983C858AB71595017ED", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A54A105515FF78A7A983C858AB71595017ED", ::playerhumanconcusspush);
  [[var_0]]("_encstr_834A101DACC643DEFA1C34CBDCEBE8F6DDD8", 6, 6, 6, 0.1, 0, "_encstr_834A101DACC643DEFA1C34CBDCEBE8F6DDD8", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_834A101DACC643DEFA1C34CBDCEBE8F6DDD8", ::playerhumanconcusspush);
  [[var_0]]("_encstr_8B4A108EB2360DF6D707A1E537FA47F6DD73", 6, 6, 6, 0.1, 0, "_encstr_8B4A108EB2360DF6D707A1E537FA47F6DD73", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8B4A108EB2360DF6D707A1E537FA47F6DD73", ::playerhumanconcusspush);
  [[var_0]]("_encstr_994A106B2BEF3C9FF62F7871461E3B053F02", 6, 6, 6, 0.1, 0, "_encstr_994A106B2BEF3C9FF62F7871461E3B053F02", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_994A106B2BEF3C9FF62F7871461E3B053F02", ::playerhumanconcusspush);
  [[var_0]]("_encstr_9B4A10130720FBB5B99A64734E27EB2FDF83", 6, 6, 6, 0.1, 0, "_encstr_9B4A10130720FBB5B99A64734E27EB2FDF83", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9B4A10130720FBB5B99A64734E27EB2FDF83", ::playerhumanconcusspush);
  [[var_0]]("_encstr_A2F11181FF5A5B08276288A24AFF08B7B31681", 6, 6, 6, 0.1, 0, "_encstr_A2F11181FF5A5B08276288A24AFF08B7B31681", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2F11181FF5A5B08276288A24AFF08B7B31681", ::playerhumanconcusspush);
  [[var_0]]("_encstr_B1F111E8DF2B489FC92A1B9BC2E1E11087265A", 6, 6, 6, 0.1, 0, "_encstr_B1F111E8DF2B489FC92A1B9BC2E1E11087265A", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1F111E8DF2B489FC92A1B9BC2E1E11087265A", ::playerhumanconcusspush);
  [[var_0]]("_encstr_B4F111E89536A1DEF5C143BC9BBEA3DBEE8923", 6, 6, 6, 0.1, 0, "_encstr_B4F111E89536A1DEF5C143BC9BBEA3DBEE8923", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B4F111E89536A1DEF5C143BC9BBEA3DBEE8923", ::playerhumanconcusspush);
  [[var_0]]("_encstr_95F111732396985501800B211049F3E7A30E5A", 6, 6, 6, 0.1, 0, "_encstr_95F111732396985501800B211049F3E7A30E5A", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_95F111732396985501800B211049F3E7A30E5A", ::playerhumanconcusspush);
  [[var_0]]("_encstr_8CF111380FFB984F799A4BCBB291B1A037F682", 6, 6, 6, 0.1, 0, "_encstr_8CF111380FFB984F799A4BCBB291B1A037F682", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8CF111380FFB984F799A4BCBB291B1A037F682", ::playerhumanconcusspush);
  targets_killed();
}

targets_killed(var_0) {
  var_1 = getEntArray("_encstr_860D0E536BD7B7F58991F2E15FA0FF7B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 thread targetoverride(var_0);
}

targetoverride(var_0) {
  var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.size;
  scripts\cp\cp_modular_spawning::registerambientgroup(self.target, var_2, var_2, var_2, 0.1, undefined, self.target);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(self.target, 200, 20000, 30000);

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "_encstr_95CC134C57A51B8C5AE6B3F539DBB733EB4DAE3BEC":
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, ::first_move);
        break;
      case "_encstr_81E7122273D1A103906B0F19C89FED635BA0CB75":
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, ::broadcast_carry_items);
        break;
      case "_encstr_889A146C86B71C83AC27FA93F67BCCF536163723B2E4":
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, ::_id_12D86);
        break;
    }
  }

  thread trigger_spawn(var_0);
  thread _id_13DB0();
}

_id_13DB0() {
  var_0 = getEntArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.classname) && issubstr(var_2.classname, "_encstr_8F5C086405E70FBA4B4A"))
      var_2 thread _id_13DB1(self);
  }
}

_id_13DB1(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  var_0 scripts\engine\utility::delaycall(0.1, ::delete);
  self delete();
}

trigger_spawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8F110E9BE8DB83EBB90785DDB95A9B76");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(var_1 isparachuting() || var_1 isskydiving()) {
      continue;
    }
    break;
  }

  var_2 = self.target;
  var_3 = scripts\cp\cp_modular_spawning::run_spawn_module(var_2);
  self delete();
}

first_move(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var_2 = scripts\engine\utility::getStruct(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2)) {
      var_3 = 600;

      if(isDefined(var_2.radius))
        var_3 = var_2.radius;

      thread first_pressure_switch_triggered(var_2, var_3);
    }
  }
}

watch_for_player_damage() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(isPlayer(var_1)) {
      self._id_132B8 = 1;
      return;
    }
  }
}

first_pressure_switch_triggered(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.combat_func_active = 1;
  var_2 = 5;
  var_3 = var_2;
  thread watch_for_player_damage();

  while(isDefined(var_0)) {
    if(var_3 <= 0) {
      scripts\cp\cp_modular_spawning::set_goal_radius(var_1);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
      var_3 = var_2;
    }

    var_4 = 300;

    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_4 * var_4)) {
      break;
    }

    var_5 = 500;

    if(buystationtrig(self.origin, var_5 * var_5, 128)) {
      break;
    }

    var_6 = scripts\engine\utility::getStruct("_encstr_BD231889AED2C6C84B9BD9EBC9F6DE99BED4D5B33B7DA7EDB9CA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = 1100;
    var_8 = 500;

    if(!buystationtrig(var_6.origin, var_7 * var_7, var_8)) {
      break;
    }

    if(istrue(self._id_132B8)) {
      break;
    }

    var_3--;
    wait 1;
  }

  self.combat_func_active = undefined;

  for(;;) {
    var_9 = randomintrange(4, 7);
    var_10 = int(var_9 * 20);
    var_11 = scripts\cp\utility::get_closest_living_player(16000000);

    if(isDefined(var_11)) {
      scripts\cp\cp_modular_spawning::set_goal_radius(500);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_11.origin);
    }

    wait(var_9);
  }
}

buystationtrig(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 64;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0) < var_1) {
      if(abs(var_4.origin[2] - var_0[2]) < var_2)
        return 1;
    }
  }

  return 0;
}

broadcast_carry_items(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  var_2 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_2)) {
    self getenemyinfo(var_2);
    self setgoalpos(var_2.origin);
  }
}

_id_12D86(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  var_2 = scripts\cp\utility::get_closest_living_player();
  self getenemyinfo(var_2);
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

setup_manual_goalpos(var_0, var_1) {
  thread setup_trafficking_soldier_anims(var_0, var_1);
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "_encstr_84FE10129B386DEBCB48FA61711D3722E83F":
      self notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
    case "_encstr_A6421AC4EA5A8D8C4BB9B37DCEAB169C3237FAA5B583DB4E1DC29B47":
      self.dontkilloff = 1;
      self.never_kill_off = 1;
      self.maxhealth = 600;
      self.health = 600;
      self.ignoreall = 1;
      thread _id_144AA();
      self.script_origin_other = self.origin;
      break;
    case "_encstr_A24D1FAD951B7BC123E3F97EAF882616EF33CFD098EB1562CBD958CB076CB35FAF":
      self.dontkilloff = 1;
      self.never_kill_off = 1;
      self.ignoreall = 1;
      thread _id_144AA(600);
      break;
    default:
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
  }
}

playerhumanconcusspush(var_0, var_1) {
  self.grenadeweapon = getcompleteweaponname("_encstr_A93010035F88EE71B82FAD78F10352C7C518");
  self.grenadeammo = 2;
}

_id_144AA(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 810000;

  if(isDefined(var_0))
    var_1 = var_0 * var_0;

  for(;;) {
    wait 0.3;

    if(scripts\cp\utility::any_player_nearby(self.origin, var_1)) {
      break;
    }

    if(self.health < self.maxhealth - 1) {
      break;
    }
  }

  if(istrue(self.ignoreall))
    self.ignoreall = 0;
}

setup_waves_truck_section() {
  level notify("_encstr_830F1BACDC23FABB586756F5E8BAD9DE66BB854EBE37C18577375993CD");
  wait 1;
  level thread scripts\cp\cp_wave_spawning::killstreaks(10, "_encstr_868A0FB89755F1D7E1121E50EBCB0BB9A3");
  wait 10;
  level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_830F1BACDC23FABB586756F5E8BAD9DE66BB854EBE37C18577375993CD");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

stopwaveandstartthisone(var_0) {
  level notify("_encstr_849A189DF887F13F278BA279E67A48CB47984B48F7F008F20592");
  wait 0.5;
  [[var_0]]();
}

players_holding_hvt_handler() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_99A014182673A19EB8C7CD5EB1F36FCF047B5803DF4A");

  for(;;) {
    level.hostage_pickup waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_0);

    if(isDefined(level.hostage_pickup.waypoint)) {
      objective_addclienttomask(level.hostage_pickup.waypoint, var_0);
      objective_hidefromplayersinmask(level.hostage_pickup.waypoint);

      if(isDefined(level.hostage_pickup.sethotfunc))
        level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](0);
    }

    if(isDefined(level.hostage_pickup.body))
      level.hostage_pickup.body hudoutlineenable("_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40");

    var_1 = level.hostage_pickup scripts\engine\utility::_id_143AD("_encstr_88C60846397B83835919", "_encstr_B46B1B4BD0D1AF37F928BB4ABB9FB7F83119F8AF96BEA58FA15477A963");

    if(isDefined(level.hostage_pickup.waypoint)) {
      objective_addalltomask(level.hostage_pickup.waypoint);
      objective_showtoplayersinmask(level.hostage_pickup.waypoint);

      if(isDefined(level.hostage_pickup.sethotfunc)) {
        if(isDefined(var_1) && var_1 == "_encstr_88C60846397B83835919") {
          level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](1);
          level thread allow_hvt_stealing_by_ai();
          level.hostage_pickup.interaction_handle sethintdisplayfov(120);
          level.hostage_pickup.interaction_handle sethintdisplayrange(220);
          level.hostage_pickup.interaction_handle setuserange(120);
        } else if(isDefined(var_1) && var_1 == "_encstr_B46B1B4BD0D1AF37F928BB4ABB9FB7F83119F8AF96BEA58FA15477A963")
          level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](1, 0.5);
      }
    }

    if(isDefined(level.hostage_pickup.body))
      level.hostage_pickup.body hudoutlinedisable();
  }
}

setup_hostage_fulton_anims(var_0, var_1) {
  self.maxhealth = 99999;
  self.health = 99999;
  level.obj_tugofwar_civ_hvt = self;
}

_id_13B34() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B6C00E5474B9A12BD318AB0F3009FCCA");
  var_0 = 4;

  for(;;) {
    self stopuseanimtree();
    self scriptmodelclearanim();
    self scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
    wait(var_0);
  }
}

thread_hostage_fulton_anims(var_0) {
  level scripts\cp\cp_hostage::anim_init_hostage();
  level.hostage_pickup.interaction_handle makeunusable();
  little_bird_mg_deletenextframe();
  level notify("_encstr_B4761C5FE2E4814DA71A889123CF06C93F7DD1339C8F399B27B3E3794AB7");
  level.playertimedinvunerable = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.hostage_pickup_pos);
  level.playertimedinvunerable.angles = var_0.angles;
  level.playertimedinvunerable setModel("_encstr_A28C1C9BDA5D9D9D362B397DA5DC33B727B5C237D1FACCD5D8C698DBC8E5");
  level.playertimedinvunerable.animname = "_encstr_8E1C0FB675401B1D1D41325A3871D61FD9";
  level.playertimedinvunerable useanimtree(level.scr_animtree["_encstr_8E1C0FB675401B1D1D41325A3871D61FD9"]);
  level.playertimedinvunerable dontinterpolate();
  level.playertimedinvunerable hide();
  little_bird_mg_deletenextframe();
  level.hostage_pickup.interaction_handle makeunusable();
  level.playerthrowsmokesignal = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.playertimedinvunerable.origin);
  level.playerthrowsmokesignal setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.hostage_pickup.body delete();
  level.hostage_pickup thread scripts\cp\cp_pickup_hostage::deletepickuphostage();
  level.playertimedinvunerable show();
  little_bird_mg_deletenextframe();
  level.playertimedinvunerable thread _id_13B34();
  level thread scripts\cp\cp_hostage::create_vip_fulton_trigger(level.playertimedinvunerable, (0, 180, 0));
  level thread scripts\cp\cp_hostage::anim_fulton_hostage_player_scene(level.playertimedinvunerable, level.playerthrowsmokesignal, 11.2);
}

little_bird_mg_deletenextframe() {
  if(isDefined(level.hostage_pickup) && isDefined(level.hostage_pickup.interaction_handle)) {
    level.hostage_pickup.interaction_handle makeunusable();
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label("_encstr_B40101");
    level.hostage_pickup scripts\cp\cp_pickup_hostage::togglehvtusable(0);
    level.hostage_pickup.interaction_handle makeunusable();
  }
}

handle_escalation_increases() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.hostage_pickup.origin;
  var_1 = 0;
  var_2 = 1000;
  var_3 = 1700;
  var_4 = 4;
  var_5 = undefined;

  for(;;) {
    if(!isDefined(level.hostage_pickup)) {
      return;
    }
    var_5 = var_4;
    var_1 = distance2d(level.hostage_pickup.origin, var_0);

    if(var_1 > var_2) {
      var_6 = var_1 / var_2;
      var_5 = var_5 * var_6;
    }

    if(var_1 < var_3)
      level thread scripts\cp\cp_escalation::increase_escalation_counter();

    wait(var_5);
  }
}

suicide_bomber_combat_func() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = get_closet_alive_player(self);
  self getenemyinfo(var_0);

  for(;;) {
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

spawn_atvs() {
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 3;

  if(!isDefined(level.atvs))
    level.atvs = [];

  var_0 = scripts\engine\utility::getStructArray("_encstr_8AB213986BE79F8997316EF009A3B3374AA3B87832", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
}

_id_135E1(var_0) {
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 3;

  if(!isDefined(level.tacrovers))
    level.tacrovers = [];

  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_createfromstructs(var_1, 1);
}

_id_131F0() {
  scripts\cp\utility::skydivestreamhintdvars("_encstr_82270965032A879927CFD0");
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
}

vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 / 1000;
  return var_1;
}

_id_12DEC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.watchremoveminigunrestrictions = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_920F1AA58E25D2BE20291723E01B6E5AFD88EA1E64A3FAFF0B20472E");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_920F1AA58E25D2BE20291723E01B6E5AFD88EA1E64A3FAFF0B20472E");
  wait 10;
  level.watchsnowballpickup = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_870F1AB1269CB03BB7F5371C2CEECD95E4BE9B2CCCCAD0BD5D6EB219");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_870F1AB1269CB03BB7F5371C2CEECD95E4BE9B2CCCCAD0BD5D6EB219");
}

nag_player_remind_lore_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;
  level scripts\engine\utility::delaythread(3, scripts\cp\cp_vo::try_to_play_vo_on_team, "_encstr_A5E52889A3B1F6C8238130493519793E8A1B61170FAB507847A2DB411AFFB0EDB397F787D7720421312A", "_encstr_9A8507BA4040188D08");
  level scripts\engine\utility::delaythread(16, scripts\cp\cp_vo::try_to_play_vo_on_team, "_encstr_B1E528193C7DB1076EEBDAC26B16BED8B0631BDBAE8EFAD6ED9C4716277D851D8EB06CDAD29BD9D79118", "_encstr_9A8507BA4040188D08");
  level._id_12E5C = scripts\engine\utility::getStruct("_encstr_935C119B5866590DDBABB9ACEBDCD1E4D5B13A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::getStructArray("_encstr_82B41778B24F8B90FF37D9C0F25BB945797AC0700A26C189F3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", scripts\engine\utility::random(var_0).origin);
  var_1 setModel("_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  var_2 = 1;
  var_3 = 4;
  var_4 = 7;
  var_5 = 0.5;
  var_6 = 1;
  var_7 = 1000;
  var_8 = 300;

  for(var_9 = 6; var_7 > 0; var_2--) {
    var_10 = quarry_intro1_chopper(var_9, var_2, var_8);

    foreach(var_12 in var_10) {
      var_13 = scripts\engine\utility::random(var_0).origin;
      var_14 = 2600;
      var_1 thread _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::launch_mortar(var_13, var_12, undefined, var_14);
      wait(randomfloatrange(var_5, var_6));
    }

    if(var_2 > 0 || trial_turrets_killed())
      wait(var_3);
    else
      wait(randomfloatrange(var_3, var_4));

    var_7--;
  }
}

trial_turrets_killed() {
  var_0 = getEnt("_encstr_92011CBFEF0BEC5804373B965AF1A815327F3B0767F10ED1368DE02BC5DD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\mp\vehicles\vehicle_damage_mp::_id_11F27(var_0);
  return var_1 > 0;
}

quarry_intro1_chopper(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_1) && var_1 > 0)
    var_2 = var_2 * 4;

  foreach(var_5 in level.players) {
    if(isDefined(var_5) && isalive(var_5) && !scripts\cp\cp_laststand::player_in_laststand(var_5) && !var_5 isspectatingplayer()) {
      if(istrue(var_5.bspawningviaac130)) {
        continue;
      }
      if(scripts\engine\utility::distance_2d_squared(var_5.origin, level._id_12E5C.origin) < int(level._id_12E5C.radius) * int(level._id_12E5C.radius)) {
        continue;
      }
      var_6 = 1;

      if(scripts\engine\utility::cointoss())
        var_6++;

      for(var_7 = 0; var_7 < var_6; var_7++)
        var_3[var_3.size] = race_ui_critical_message_timer(var_5.origin, var_2);
    }
  }

  if(var_3.size < var_0) {
    var_9 = var_0 - var_3.size;
    var_10 = scripts\engine\utility::getStructArray("_encstr_995217C551484753B5C7BF631F57FB8F807BBB4129B006DA01", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_7 = 0; var_7 < var_9; var_7++) {
      var_11 = scripts\engine\utility::random(var_10);
      var_12 = var_11.origin;

      if(isDefined(level.hostage_pickup_pos))
        var_12 = level.hostage_pickup_pos;

      var_3[var_3.size] = race_ui_critical_message_update(var_12, level._id_12E5C.origin);
    }
  }

  return var_3;
}

race_ui_critical_message_update(var_0, var_1) {
  var_2 = randomfloatrange(0.5, 0.85);
  var_3 = vectorlerp(var_0, var_1, var_2);
  var_4 = scripts\engine\utility::drop_to_ground(var_3, 500, -1000);

  if(!isDefined(var_4))
    var_4 = var_3;

  if(var_0[2] > var_1[2]) {
    var_5 = var_1[2];
    var_6 = var_0[2];
  } else {
    var_5 = var_0[2];
    var_6 = var_1[2];
  }

  var_4 = (var_4[0], var_4[1], clamp(var_4[2], var_5, var_6));
  return var_4;
}

race_ui_critical_message_timer(var_0, var_1) {
  var_2 = randomfloatrange(var_1 / -2, var_1 / 2);
  var_3 = randomfloatrange(var_1 / -2, var_1 / 2);
  var_4 = (var_2, var_3, 0);
  var_5 = scripts\engine\utility::drop_to_ground(var_0 + var_4, 500, -1000);

  if(!isDefined(var_5))
    var_5 = var_0 + var_4;

  return var_5;
}

debug_start_apprehension(var_0) {
  thread threaded_start_tugofwar();
}

threaded_start_tugofwar() {
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_8F1E1D39D8D9C34043395657E3AFF0A945F0560317DF5B939732E88F51FF98", 1);
  level waittill("_encstr_91FC13D6727A87A805CBA9C8F35902EB33D146574A");
  var_0 = scripts\engine\utility::getStruct("_encstr_B4051AC238384EACA1959BE62DDEB9D7A157ADCECAB2AFE6A38527D1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::teleport_humvee_to_struct(var_0);
}

_id_1240B() {
  var_0 = level.hostage_pickup scripts\cp\utility::get_closest_living_player();
  level play_vo_delay("_encstr_8B6720A5F820C1E8DA3929C70B5F9719A5F718FFE94EDCCFA317BAF3C750B44EC647");
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
  level thread _id_12410();

  if(!isDefined(level.all_convoys["_encstr_911A0B44D282E9AE50C08DB27A"].main_truck))
    level waittill("_encstr_B17D13F86783D9EA48858BD8A3892F5A592C60DA7B");

  level thread _id_123C0();
}

_id_12410() {
  level.hostage_pickup endon("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385");
  var_0 = 40000;

  while(!scripts\cp\utility::any_player_nearby(level.hostage_pickup.origin, var_0))
    wait 0.2;

  level notify("_encstr_B4C2145B834F78F81BA15D0FDE45693EFF1BB6405BFB");
  level thread spawn_module_intro3("_encstr_99A930C4A376178A7771129A408D8983EB847777341E3F965D59EA82F09D3F77C0F8D6FF56E0AF9D0941129AE0D3F5BFB37F");
  var_1 = level.hostage_pickup scripts\cp\utility::get_closest_living_player();
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_1, "_encstr_ABBD0BB789A6EB675A37AE5863");
  level play_vo_delay("_encstr_B29C30D1DB27E6D0921799FB43FAE135D7820E38A2CF2480EA3F85EF6D65C0680F6AA1A00BBF57B0832781F7748FC8D09A27");
}

_id_123C0() {
  var_0 = level.all_convoys["_encstr_911A0B44D282E9AE50C08DB27A"].main_truck;

  if(!isDefined(var_0)) {
    return;
  }
  level.all_convoys["_encstr_911A0B44D282E9AE50C08DB27A"] endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  level.all_convoys["_encstr_911A0B44D282E9AE50C08DB27A"] endon("_encstr_A3E5145B2888AB302AC6B1F8FE15103B3889DD49CB30");
  var_1 = 90000;

  while(distance2dsquared(level.hostage_pickup.origin, var_0.origin) > var_1)
    wait 0.2;

  level thread play_vo_delay("_encstr_BACD31D160C10837C7F170D9DB2F7868E3D71F4FE6B9E0F7FBE9C9ED8303AD793C26E5D79A9DA8488BC161085A4BD0F0D9D1D1");
}

_id_12411() {
  if(istrue(level._id_13E35)) {
    return;
  }
  level._id_13E35 = 1;
  level thread spawn_module_intro3("_encstr_8C552B8C0FD71BC1CDFA969B994EF5A3EAD97DDE66BEDDC29CAFB4DCCCF64E5B58B9D1D79C56CD36572BBE4C06");
  level thread play_vo_delay("_encstr_96953432E17D1BC1DCEB1B58B9DC7DE8AED9F5DE33AFEEC239EBA537CCDE4E5BC2CD1D7D074B1B5BABE0FADBCECA2736DE9C19AF260C");
  wait 15;
  level._id_139B5 = 0;
}

play_convoy_hostage_save_vo() {
  scripts\engine\utility::flag_init("_encstr_B4E11D8EABCE7B66BBC293D79DB77D831BC2E55AB99DBE23B4DCC23163CA46");
  var_0 = 1;
  wait(var_0);
  thread play_player_follow_truck();
  wait(6 - var_0);

  if(istrue(level.hostage_pickup.pickedupbyplayer)) {
    return;
  }
  if(!istrue(level.hostage_pickup.convoy_pickedup)) {
    return;
  }
  level thread play_vo_delay("_encstr_AD6B291987AF1BE09BF5632CDC37BE47D5EC7DEDCCD7EE589CF5D8F6B93BDE97AFB12B169D5AB9B37D890C", undefined, undefined);
  level thread _id_123FA();
}

_id_123FA() {
  level.hostage_pickup endon("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");
  level.hostage_pickup endon("_encstr_A36913AC6D396F5727C89B41E84D8BF7F1DD01240B");
  var_0 = [];
  var_0[var_0.size] = "_encstr_8ECF2512883766BB4BDF01975A1F8E59035067E06D3F1797A689684F08871B90F564159BF8EA1A";
  var_0[var_0.size] = "_encstr_A3CF25ABF8D62343AFE04D06DE9789FC3B98CF7FE00E8F1AC598D53ECC2782BF20B897AF91CB80";
  var_0[var_0.size] = "_encstr_8AE1258CC8CF6F29B8D71B482BD776E35D77D78839D1181772A9A84F10DF76F0DEABCFA3779330";
  var_1 = randomint(var_0.size - 1);

  for(;;) {
    wait 5;
    level thread _id_12400();
    wait(randomfloatrange(10, 25));

    if(scripts\engine\utility::flag("_encstr_B4E11D8EABCE7B66BBC293D79DB77D831BC2E55AB99DBE23B4DCC23163CA46"))
      wait 5;

    var_1 = var_1 + 1;

    if(var_1 >= var_0.size)
      var_1 = 0;

    if(istrue(level._id_11F62)) {
      return;
    }
    level play_vo_delay(var_0[var_1]);
  }
}

_id_12400() {
  var_0 = 4000000;
  var_1 = 10;

  if(scripts\cp\utility::any_player_nearby(level.hostage_pickup.origin, var_0)) {
    if(isDefined(level.spawn_ml_p2_sentries) && gettime() > level.spawn_ml_p2_sentries + var_1 || !isDefined(level.spawn_ml_p2_sentries)) {
      var_2 = [];
      var_2[var_2.size] = "_encstr_B41A2B23E1FAC683CDD74BB96627D71D5DD9EBED337DDD854E7D4BE699ED4EB60B9BE8D783B4B1D6AE83FA4C60";
      var_2[var_2.size] = "_encstr_8A1A2BEA68177E63F338F9E64C3B1743BB78C1D220BF335F8BAFF1EE54A0FB4D3BA8FB69F88BEEBF43FFFF4A57";
      var_2[var_2.size] = "_encstr_881A2B463CAFB1389BF5A5B9334ED7E8EA3BF5BD99AF77C293AF2DB9CCBDE45B8573A3D7C1968DB5BA83F53381";
      var_2[var_2.size] = "_encstr_A11A2BC8C3AF1B07DCF52DCDCC27BE8EBA767DBD99BEDDB093AF4B9BCCBD9C6B58E6E8F5074BC6D6570EBE4306";
      var_2[var_2.size] = "_encstr_831A2BF1DBF7E73FB22798F3015B50330D0C5707D94FA3C8389F7018CD17864918D0D348372216F4A7C0713D81";
      var_3 = scripts\engine\utility::random(var_2);
      level thread spawn_module_intro3("_encstr_99A930C4A376178A7771129A408D8983EB847777341E3F965D59EA82F09D3F77C0F8D6FF56E0AF9D0941129AE0D3F5BFB37F");
      level.spawn_ml_p2_sentries = gettime();
    }
  }
}

play_player_follow_truck() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp\utility::get_closest_living_player();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_AC1F12285EA231F5C2132F232309B1685674F0A1");
  wait 11;

  if(isDefined(self))
    var_0 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_0))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_96410F3594AE40582311D07BEB0B0BAB82");
}

play_lost_health_vo() {}

play_waitfor_ai_drop_vo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_99A014182673A19EB8C7CD5EB1F36FCF047B5803DF4A");

  if(istrue(level.vo_played_waitforaidrop)) {
    return;
  }
  level.vo_played_waitforaidrop = 1;
  var_0 waittill("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385");
  var_0 waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");
  wait 2;
  level thread _id_12411();

  for(;;) {
    var_0 waittill("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385");
    var_1 = ["_encstr_99842C911EF58D836ED7A5DC99C9FA8E5D3BF5F699FABB0B93F5A573337B935BB0E68EF59D4E0B8913CA23AF1303", "_encstr_8F842C231EBEB1386EEB2D9BCC27D71DD5CEEB7B99D7DD2C4EEBA5E666ED39B6B0E6E87D7693B0313195327DC818", "_encstr_AB842C19F0EB6C076EF5A537999C7DE8EA3BFABD66AFBB8593F5B473337B9C6BC29BE8D73B27B08926AC8CAF9906"];
    var_2 = scripts\engine\utility::random(var_1);
    level thread spawn_module_intro3(var_2);
    wait(randomfloatrange(1, 2));
    var_3 = ["_encstr_8E2D354AC8B7DEC393589C8966BBB7A35B98617240DF93BF6BA0918EF4405B2D9B485B09E05DCEFB01956487184BCFB2D9A88332B973D2", "_encstr_B14A359187AF8D386ED7ADB06BC2D7D1AB9DFAB799EBEE854EF55AE633B7C9DAB09B47FAB39385894C568CBEBDD92B93B1DB2791EB9181", "_encstr_AF4A3523C3D7C61C377D6D0BB5B0D7A3D5CEF5ED99FADD584ED7B4E6CCED9CAD0BE6D1D79DC958314CB223F5B7CE569363B7C991AFCC03"];
    var_4 = scripts\engine\utility::random(var_3);
    level play_vo_delay(var_4);
  }
}

play_convoy_hostage_vo() {
  if(istrue(level.hostage_pickup.pickedupbyplayer)) {
    return;
  }
  if(!istrue(level.hostage_pickup.convoy_pickedup)) {
    return;
  }
  scripts\engine\utility::flag_set("_encstr_B4E11D8EABCE7B66BBC293D79DB77D831BC2E55AB99DBE23B4DCC23163CA46");
  level play_vo_delay("_encstr_BDEB2A1733AF226873D99BB7A02B0F1B83C4514D9407BB81BBF1AF8720A3E7337FEDA4C28FA542CD4109DE82");
  wait 3;
  scripts\engine\utility::flag_clear("_encstr_B4E11D8EABCE7B66BBC293D79DB77D831BC2E55AB99DBE23B4DCC23163CA46");
}

_id_1240F() {
  var_0 = level.hostage_pickup.carrier;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_950B0CEDC4D47D380BD8B50B9D59");
  level play_vo_delay("_encstr_BD592F0280FFE6FB5B804441AE637FEB03E0394A98275BF713E85976CC0803F5537313C13801D363A9EE4C795070EF2A59");
  wait 1;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
  level thread _id_12402();
}

_id_12402() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_911B144403A2E5EF53B885B1587BB4F6D3417F2F0DC2");
  wait 3;

  if(istrue(level._id_13E34)) {
    return;
  }
  var_0 = 20;
  var_1 = ["_encstr_A51729AF8B078AB0AB31635F7883A743FBACF9E57CDF03E9D3497367C0FE55CB81BEFE1EDDDBDA3E9E1202", "_encstr_AD172919F0F51BC1B9D78D169B37FA475DB3BEB7CCEBEE0BC97D9B859DAF95878EE4C26C1D96DBDCFA9118"];

  for(;;) {
    level play_vo_delay(scripts\engine\utility::random(var_1));
    wait(randomfloatrange(10, var_0));

    if(var_0 < 50)
      var_0 = var_0 + 2;
  }
}

_id_12401() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8E1C0FB675401B1D1D41325A3871D61FD9");
  var_0 = 20;
  var_1 = ["_encstr_83942A7CE9E1C6E39EC6822AE8FF277BD84FCFCF7D390B6FC6FECA52B1D80BF3A8016746F7E81227EF16374F", "_encstr_A1942ADC8B5E3FB24F592A82E043A1BBF3FC1F5F2CE627BE3541429A48E7A7F788DDA7C6286B8B4719298F87"];

  for(;;) {
    level play_vo_delay(scripts\engine\utility::random(var_1));
    wait(randomfloatrange(10, var_0));

    if(var_0 < 50)
      var_0 = var_0 + 2;
  }
}

play_mission_complete_vo() {
  level play_vo_delay("_encstr_93FB2B231E7D6CC16ED7B52CB6C2BE8EAEB3F5ED33EB778527F5B6B4E6DC5ABD37BEC6DBAD078DAC3A56D7C40C");
  wait 4;
  level thread _id_123EF();
  level waittill("_encstr_82A21DA8EA76C399F31FF5782CF723B39F6138B8A28F3910C75B8DF8063728");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BD2B2B3F2AD9431BAEAFBB871F5611AC6051794541811F4206979F473BFF6AF5D0F9E10F59C0C21AD58D6736A9", "_encstr_9A8507BA4040188D08");
}

_id_123EF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A55313D36A6F0488B5CD4527E2DF4056DF034B9962");
  level notify("_encstr_8FEB1878E0B997E84ACFBF8FCD4F1B5A11A0F6AEB713C033B047");
  var_0 = scripts\engine\utility::getStruct("_encstr_A2B9216EADAB9DD9C62BC9FAB9C233B2A1DBABE6B2F564D79359D993BDAB1CFA0EB7E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 1000000;

  for(;;) {
    if(!scripts\cp\utility::any_player_nearby(var_0.origin, var_1))
      level play_vo_delay("_encstr_A7782ACA48375E4313D81B09E97937E2F3104282880B122F4EB61D14FD63AB213FB0FA2A18E74B3F6108B268");

    wait 30;
  }
}

play_hostage_dead_vo() {
  level play_vo_delay("_encstr_95272AA7EBE1689043C1720F59AE771B9B573FD7A587B4B15BCFF9246097C4A855C9EF52F70BB54D0780FF9F");
  wait 1;
}

_id_123E0() {
  wait 2;
  wait 3.1;
  level thread spawn_module_intro3("_encstr_A55E26D073213FF3CF57BB2046E3DEA9132A917BEA495FE913AF34A55483805571C3702823910B8B");
  wait 7.5;
  level thread play_vo_delay("_encstr_83BD252C7BAECF22DFC9EA3280F7D12B436C8FAF9C76572E85B1629BA00D963F1BC33756B8D312");
  wait 1.6;
  level thread spawn_module_intro3("_encstr_87BC25E471795E4B367E0A42618EBFD37027A767D5D1E3D75E96C22B4BE67FCE90831FFE0F42FA");
  wait 14;
  level thread play_mission_complete_vo();
}

spawn_module_intro3(var_0) {
  if(!isDefined(level.hostage_pickup) || !isent(level.hostage_pickup)) {
    if(isDefined(level.playerthrowsmokesignal)) {
      level.playerthrowsmokesignal playsoundonmovingent(var_0);
      return;
    }

    if(isDefined(level.playertimedinvunerable)) {
      level.playertimedinvunerable playsoundonmovingent(var_0);
      return;
    } else
      return;
  }

  if(!soundexists(var_0)) {
    return;
  }
  level.hostage_pickup playsoundonmovingent(var_0);
}