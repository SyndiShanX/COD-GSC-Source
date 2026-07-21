/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\vehicle_code.gsc
***********************************************/

vehicle_initlevelvariables() {
  setdvarifuninitialized("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F", 1);

  if(!isDefined(level.vehicle))
    level.vehicle = spawnStruct();

  level.vehicle.templates = spawnStruct();
  level.vehicle.helicopter_crash_locations = getEntArray("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  level.vehicle.templates.team = [];
  level.vehicle.templates.deathmodel = [];
  level.vehicle.templates.death_thread = [];
  level.vehicle.templates.driveidle = [];
  level.vehicle.templates.driveidle_r = [];
  level.vehicle.templates.rumble = [];
  level.vehicle.templates.mainturret = [];
  level.vehicle.templates.mgturret = [];
  level.vehicle.templates.death_earthquake = [];
  level.vehicle.templates.surface_effects = [];
  level.vehicle.templates.unloadgroups = [];
  level.vehicle.templates.aianims = [];
  level.vehicle.templates.landanims = [];
  level.vehicle.templates.exhaust_fx = [];
  level.vehicle.templates.engine_fx = [];
  level.vehicle.templates.shoot_shock = [];
  level.vehicle.templates.hide_part_list = [];
  level.vehicle.templates.destructible_model = [];
  level.vehicle.templates.grenade_shield = [];
  level.vehicle.templates.bullet_shield = [];
  level.vehicle.templates.death_jolt = [];
  level.vehicle.templates.death_badplace = [];
  level.vehicle.templates.idle_anim = [];
  level.vehicle.templates.helicopter_list = [];
  level.vehicle.templates.airplane_list = [];
  level.vehicle.templates.single_tread_list = [];
  level.vehicle.templates.deathanimations = [];
  level.vehicle.templates.vehicle_death_fx = [];
  level.vehicle.templates.vehicle_rocket_death_fx = [];
  level.vehicle.templates.death_radiusdamage = [];
  level.vehicle.templates.model = [];
}

ishelicopter_internal() {
  if(isDefined(self.isheli))
    return 1;

  if(!isDefined(self.vehicletype))
    return 0;

  return isDefined(level.vehicle.templates.helicopter_list[self.vehicletype]);
}

isairplane_internal() {
  return isDefined(level.vehicle.templates.airplane_list[self.vehicletype]);
}

vehicle_setuplevelvariables() {
  if(!scripts\engine\utility::add_init_script("_encstr_96960D3017E850BFB237C8640E6BA7", ::vehicle_setuplevelvariables)) {
    return;
  }
  scripts\engine\utility::init_struct_class();
  vehicle_initlevelvariables();
  scripts\common\vehicle_aianim::setup_aianimthreads();
}

vehicle_precachescripts() {
  var_0 = [];
  level.needsprecaching = [];

  if(!isDefined(level.vehicleinitthread))
    level.vehicleinitthread = [];

  var_1 = getEntArray("_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", "_encstr_956D0F572FD22561C3BD81DB62A6D869BA");

  foreach(var_3 in var_1) {
    var_3.vehicletype = tolower(var_3.vehicletype);

    if(var_3.vehicletype == "_encstr_83B306C13570D0CB" || var_3.vehicletype == "_encstr_BEDC0B7F91C96B49DE78D7FB18") {
      continue;
    }
    var_0[var_0.size] = var_3;
    vehicle_precachesetup(var_3.classname, var_3);
  }

  if(level.needsprecaching.size > 0) {
    var_5 = "_encstr_8E740572767E39";

    foreach(var_14, var_7 in level.needsprecaching) {
      foreach(var_9 in var_7) {
        foreach(var_11 in var_9.reasons) {}
      }
    }

    level waittill("_encstr_911E0605B80E912D");
  }

  return var_0;
}

vehicle_precachesetup(var_0, var_1) {
  if(isDefined(level.vehicleinitthread[var_1.vehicletype]) && isDefined(level.vehicleinitthread[var_1.vehicletype][var_1.classname])) {
    return;
  }
  if(var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    return;
  }
  var_2 = [];

  if(isDefined(level.needsprecaching[var_0]))
    var_2 = level.needsprecaching[var_0];

  var_3 = spawnStruct();
  var_3.pos = var_1.origin;
  var_3.reasons = [];

  if(!isDefined(level.vehicleinitthread[var_1.vehicletype]))
    var_3.reasons[var_3.reasons.size] = "_encstr_AB830EC309930F76D073B4B131F0EE7A" + var_1.vehicletype + "_encstr_AB8A8D6641F387462087144897509B47A7A9BBEB30D7978A48B3765013A8E0534511A3A2DB87138398C170166BE0EFA27590AEFBA1A9B3FEC0C729E7730A26579EE1B3920BF78B36B33360E991893E234B617AAB393E5F2A40BF48F10FE0C77AE3DB2323792747E4482D55B8F3108BC29B31EBAA69E5F39F3A5F5ACFC5A80653B58892B28835DBD0905320DBFB1889";
  else if(!isDefined(level.vehicleinitthread[var_1.vehicletype][var_1.classname]))
    var_3.reasons[var_3.reasons.size] = "_encstr_963A0CB67A07BAAEC849A3FA902A" + var_1.classname + "_encstr_A7F16B6A28088317669B2F1B9647E164E020B6A9336FFB38526C5030DA9941C06621D0B04F25F69CA31233119D4A91FD594B983726CD90A70F2EA899679578E970E60233B95209CBD541CA49BC970EFFD8EF0D614771F526FBE720B8F2480F2A8A54A393F64926303ABB5BE0B8";

  var_2[var_2.size] = var_3;
  level.needsprecaching[var_0] = var_2;
}

vehicle_setupspawners() {
  var_0 = _getvehiclespawnerarray();

  foreach(var_2 in var_0)
  var_2 thread vehicle_spawnerlogic();
}

vehicle_spawnerlogic() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(isDefined(self.script_deathflag))
    thread scripts\engine\utility::script_func("_encstr_ABED1A23689164B7B89D77532F21DF6D234839FA805B9BD39171517F");

  self.count = 1;
  self.spawn_functions = [];

  for(;;) {
    self waittill("_encstr_BA350853C128FB939DB9", var_0);
    self.count--;

    if(!isDefined(var_0)) {
      continue;
    }
    var_0.spawn_funcs = self.spawn_functions;
    var_0.spawner = self;
    var_0 thread scripts\engine\utility::script_func("_encstr_BE1A149CEAB9F59B3816EE37FA33D5CDD8D12D7BDC9B");
  }
}

vehicle_triggerkillspawner(var_0) {
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");

  foreach(var_2 in vehicle_getspawnerarray()) {
    if(scripts\engine\utility::is_equal(var_2.script_kill_vehicle_spawner, var_0.script_kill_vehicle_spawner))
      var_2 delete();
  }
}

vehicle_spawnaiarray(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::ent_flag_exist("_encstr_A3BC17E0F56FA0837AD7ADB7273358D8E18D4E1B5DB4904F52") && scripts\engine\utility::ent_flag("_encstr_A3BC17E0F56FA0837AD7ADB7273358D8E18D4E1B5DB4904F52");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;

    if(isDefined(var_4.script_drone)) {
      var_5 = 1;
      var_6 = scripts\engine\utility::script_func("_encstr_850A14ABDD80D255B02B46CBC0F99A1AED237F0B7933", var_4);
      var_6 scripts\engine\utility::script_func("_encstr_92221032C9DBB959BEEC96D9B2FA6E7B5763");
    } else if(isDefined(var_4.script_fakeactor) || isDefined(var_4.script_bodyonly)) {
      var_5 = 1;
      var_6 = scripts\engine\utility::script_func("_encstr_A10D0EB052BF5B400BD4037EA05F0B2D", var_4);
      var_6 scripts\engine\utility::script_func("_encstr_A7F0147B69439B5FB6F32F9A4917606660596297D369");
    } else
      var_6 = var_4 scripts\engine\utility::script_func("_encstr_878C09270957938E21F994", var_2);

    if(!var_5 && !isalive(var_6)) {
      continue;
    }
    var_1 = scripts\engine\utility::array_add(var_1, var_6);
  }

  var_8 = vehicle_removenonridersfromaiarray(var_1);
  return var_8;
}

vehicle_removenonridersfromaiarray(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!ai_should_be_added(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

ai_should_be_added(var_0) {
  if(isalive(var_0))
    return 1;

  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_0.classname))
    return 0;

  return var_0.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
}

spawn_riders() {
  if(scripts\engine\utility::ent_flag_exist("_encstr_A3BC17E0F56FA0837AD7ADB7273358D8E18D4E1B5DB4904F52") && !scripts\engine\utility::ent_flag("_encstr_A3BC17E0F56FA0837AD7ADB7273358D8E18D4E1B5DB4904F52")) {
    self notify("_encstr_92FC0E6B1809EB7D6084BF222B493B63");
    return [];
  }

  var_0 = get_vehicle_riders_spawners();

  if(!var_0.size) {
    self notify("_encstr_92FC0E6B1809EB7D6084BF222B493B63");
    return [];
  }

  var_1 = spawn_group(var_0);
  self notify("_encstr_92FC0E6B1809EB7D6084BF222B493B63", var_1);
  return var_1;
}

spawn_group(var_0) {
  var_1 = vehicle_spawnaiarray(var_0);
  var_1 = sort_by_startingpos(var_1);

  foreach(var_3 in var_1)
  thread scripts\common\vehicle_aianim::guy_enter(var_3);

  thread set_loaded_when_full(var_1);
  return var_1;
}

set_loaded_when_full(var_0) {
  scripts\engine\utility::array_wait(var_0, "_encstr_92D20741F7CEB03D1B", 1);
  scripts\common\vehicle_aianim::vehicle_loaded_if_full(self);
}

spawn_unload_group(var_0) {
  if(!isDefined(var_0))
    return spawn_riders();

  var_1 = get_vehicle_riders_spawners();

  if(!var_1.size)
    return [];

  var_2 = [];
  var_3 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.unloadgroups[var_3]) && isDefined(level.vehicle.templates.unloadgroups[var_3][var_0])) {
    var_4 = level.vehicle.templates.unloadgroups[var_3][var_0];

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(isDefined(var_1[var_5]))
        var_1[var_5].script_startingposition = var_4[var_5];
    }

    var_1 = sort_by_startingpos(var_1);

    foreach(var_7 in var_4) {
      foreach(var_9 in var_1) {
        if(var_9.script_startingposition == var_7)
          var_2[var_2.size] = var_9;
      }
    }

    var_12 = vehicle_spawnaiarray(var_2);

    foreach(var_14 in var_12)
    thread scripts\common\vehicle_aianim::guy_enter(var_14);

    self notify("_encstr_92FC0E6B1809EB7D6084BF222B493B63", var_12);
    return var_12;
  } else
    return spawn_riders();
}

sort_by_startingpos(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_startingposition)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return scripts\engine\utility::array_combine(var_1, var_2);
}

remove_vehicle_spawned_thisframe() {
  waitframe();
  self.vehicle_spawned_thisframe = undefined;
}

vehicle_init(var_0) {
  var_1 = var_0 get_vehicle_classname();

  if(isDefined(level.vehicle.templates.hide_part_list[var_1])) {
    foreach(var_3 in level.vehicle.templates.hide_part_list[var_1])
    var_0 hidepart(var_3);
  }

  if(var_0.vehicletype == "_encstr_83B306C13570D0CB" || var_0.vehicletype == "_encstr_BEDC0B7F91C96B49DE78D7FB18") {
    var_0 thread scripts\common\vehicle_paths::getonpath();
    return;
  }

  var_0 scripts\engine\utility::set_ai_number();
  var_5 = var_0.vehicletype;
  var_0 vehicle_setstartinghealth();
  var_0 vehicle_setteam();

  if(!isDefined(level.vehicleinitthread[var_0.vehicletype][var_1])) {}

  var_0 thread[[level.vehicleinitthread[var_0.vehicletype][var_1]]]();
  var_0 thread vehicle_playexhausteffect();
  var_0 thread vehicle_playengineeffect();

  if(!isDefined(var_0.script_avoidplayer))
    var_0.script_avoidplayer = 0;

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal)
      var_0 thermaldrawenable();
  }

  var_0 scripts\engine\utility::ent_flag_init("_encstr_BD82096B5DA4B07F924F29");
  var_0 scripts\engine\utility::ent_flag_init("_encstr_92D20741F7CEB03D1B");
  var_0 scripts\engine\utility::ent_flag_init("_encstr_9A93071D297064AAC5");
  var_0.riders = [];
  var_0.unloadque = [];
  var_0.unload_group = "_encstr_8B1608EC43B8D647A113";
  var_0.fastroperig = [];

  if(isDefined(level.vehicle.templates.attachedmodels) && isDefined(level.vehicle.templates.attachedmodels[var_1])) {
    var_6 = level.vehicle.templates.attachedmodels[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0.fastroperig[var_9] = undefined;
      var_0.fastroperiganimating[var_9] = 0;
    }
  }

  if(isDefined(var_0.script_vehicle_lights_on))
    var_0 thread scripts\common\vehicle_lights::lights_on(var_0.script_vehicle_lights_on);

  if(isDefined(var_0.script_godmode))
    var_0.godmode = 1;

  var_0 thread vehicle_damagelogic();
  var_0 thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(var_0.script_friendname))
    var_0 setvehiclelookattext(var_0.script_friendname, &"_encstr_B40101");

  var_0 thread vehicle_handleunloadevent();

  if(isDefined(var_0.script_dontunloadonend))
    var_0.dontunloadonend = 1;

  var_0 thread vehicle_rumble();
  var_0 thread scripts\engine\utility::script_func("_encstr_88BF0FEE199A6B9EA8C19173A53167AC57");
  var_0 thread idle_animations();
  var_0 thread animate_drive_idle();

  if(isDefined(var_0.script_deathflag))
    var_0 thread scripts\engine\utility::script_func("_encstr_816E129495D36B8E7C1F1160B55F11BA6C64392F");

  var_0 thread mainturretinit();
  var_0 thread mginit();

  if(isDefined(level.vehicle.spawn_callback_thread))
    level thread[[level.vehicle.spawn_callback_thread]](var_0);

  if(isDefined(var_0.script_team))
    var_0 setvehicleteam(var_0.script_team);

  if(var_0 scripts\common\vehicle::ishelicopter())
    var_0 thread vehicle_ai_avoidance_heli();
  else
    var_0 thread vehicle_ai_avoidance_logic();

  var_0 thread scripts\common\vehicle_paths::getonpath();

  if(isDefined(level.ignorewash))
    var_11 = level.ignorewash;
  else
    var_11 = 0;

  if(scripts\common\utility::issp() && var_0 vehicle_hasdustkickup() && !var_11)
    var_0 thread aircraft_wash_thread();

  if(var_0 vehicle_isphysveh()) {
    var_0.veh_pathtype = "_encstr_BA730C88AFF0FB9853CF40409352";

    if(isDefined(var_0.script_pathtype))
      var_0.veh_pathtype = var_0.script_pathtype;
  }

  var_0 spawn_riders();
  var_0 thread vehicle_deathlogic();
}

get_vehicle_classname() {
  if(isDefined(self.classname_mp))
    return self.classname_mp;

  return self.classname;
}

#using_animtree("_encstr_A35F099B8B0BAA5B5081FA");

vehicle_deathcleanup() {
  self notify("_encstr_82CF1668B32D1916B367B82F4993D9FF570A60D80A497DCA");
  self notify("_encstr_A2CE0F32B2B0D11AD766969B4B371A5946");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  destroynavrepulsor("_encstr_B6010584E73A07" + self getentitynumber());

  if(isDefined(self.rumbletrigger))
    self.rumbletrigger delete();

  if(isDefined(self.mgturret))
    scripts\engine\utility::array_delete(self.mgturret);

  if(isDefined(self.mainturret))
    self.mainturret delete();

  if(istrue(level.vehicle.templates.has_main_turret[self.model]))
    self clearturrettarget();

  var_0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rumble[var_0]))
    self stoprumble(level.vehicle.templates.rumble[var_0].rumble);

  if(!scripts\common\utility::issp()) {
    return;
  }
  self useanimtree(#animtree);

  if(isDefined(level.vehicle.templates.driveidle[self.model]))
    self clearanim(level.vehicle.templates.driveidle[self.model], 0);

  if(isDefined(level.vehicle.templates.driveidle_r[self.model]))
    self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
}

vehicle_deathlogic() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self endon("_encstr_97CF0F42D869C71F1BBBD7F44323F70E81");
  thread helicopter_unloading_watcher();
  self waittill("_encstr_AD75063D571AE108", var_0, var_1, var_2, var_3);
  vehicle_deathcustomlogic(var_0, var_1, var_2);
  vehicle_playdeatheffects(var_0, var_1, var_3);
  thread vehicle_killriders();
  vehicle_setdeathmodel();
  vehicle_docrash(var_0, var_1);

  if(vehicle_iscorpse())
    self notify("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", self.origin, self.angles);
  else {
    vehicle_deathcleanup();
    self notify("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", self.origin, self.angles);

    if(istrue(self.vehicle_skipdeathmodel)) {
      if(scripts\common\utility::iscp())
        wait 0.1;

      self delete();
      return;
    }

    self makecorpse();
    createnavbadplacebyent(self);
  }
}

vehicle_deathcustomlogic(var_0, var_1, var_2) {
  if(isDefined(self.custom_death_script))
    self thread[[self.custom_death_script]]();

  if(isDefined(level.vehicle.templates.death_thread[self.vehicletype]))
    thread[[level.vehicle.templates.death_thread[self.vehicletype]]]();

  var_3 = isDefined(var_0) && isDefined(var_1) && isDefined(var_2);

  if(var_3) {
    var_4 = createheadicon(var_2);
    var_0 scripts\engine\utility::script_func("_encstr_A1E60E8D85313853B880CD7FD3C825F4", self, var_1, var_4);
  }
}

vehicle_iscrashing() {
  return istrue(self.vehiclecrashing);
}

vehicle_killriders() {
  if(istrue(self.pilot_killed) && !istrue(self.unloading))
    self waittill("_encstr_A1600C8D2C668880FBD9A9F0F29F");

  foreach(var_1 in self.riders) {
    if(!isalive(var_1)) {
      continue;
    }
    if(!isDefined(var_1.ridingvehicle)) {
      continue;
    }
    if(isDefined(var_1.magic_bullet_shield))
      var_1 scripts\common\ai::stop_magic_bullet_shield();

    if(isDefined(var_1._blackboard) && isDefined(var_1._blackboard.chosenvehicleanimpos) && istrue(var_1._blackboard.chosenvehicleanimpos.isincircle)) {
      var_2 = 100.0;
      var_3 = self vehicle_getvelocity();
      var_1.do_immediate_ragdoll = 1;
      var_1.ragdollhitloc = "_encstr_9B7A0CF35815C3971660B7CF306B";
      var_1.ragdollimpactvector = (var_1.origin - self.origin) * var_2 + var_3;
    }

    if(scripts\common\utility::iscp() && isDefined(self.is_area_in_verdansk)) {
      if(isDefined(self.is_area_in_verdansk.attacker) && isPlayer(self.is_area_in_verdansk.attacker))
        var_1 dodamage(var_1.maxhealth, self.is_area_in_verdansk.attacker.origin, self.is_area_in_verdansk.attacker, self.is_area_in_verdansk.attacker, self.is_area_in_verdansk.meansofdeath, self.is_area_in_verdansk.objweapon);
      else
        var_1 kill();

      continue;
    }

    var_1 kill();
  }
}

vehicle_rider_death_detection(var_0) {
  if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
    return;
  }
  self.health = 1;
  var_0 endon("_encstr_AD75063D571AE108");
  self.baseaccuracy = 0.15;
  self waittill("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_B89E0C19275A9D5993EB194BB223");
  var_0 vehicle_killriders();
}

vehicle_becomes_crashable() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8E5013A5889133AD7B51939BF05BE5E78E6F294C13");
  waittillframeend;
  self.riders = scripts\engine\utility::array_removedead(self.riders);

  if(self.riders.size) {
    scripts\engine\utility::array_thread(self.riders, ::vehicle_rider_death_detection, self);
    scripts\engine\utility::waittill_either("_encstr_85720EF4974A77A9AF0BD0E06FF1605D", "_encstr_B89E0C19275A9D5993EB194BB223");
    vehicle_killriders();
    wait 0.25;
  }

  self notify("_encstr_A375153736934B078EAFC6935837437DECACA1D2363695");
  self vehphys_crash();
}

_vehicle_landvehicle(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_87DE08E656DDC158E81A");

  if(!isDefined(var_0))
    var_0 = 2;

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(scripts\engine\utility::flat_angle(self.angles)[1]);

  if(isDefined(self.unload_land_offset))
    _setvehgoalpos_wrap(scripts\common\utility::groundpos(self.origin) + (0, 0, self.unload_land_offset), 1);
  else
    _setvehgoalpos_wrap(scripts\common\utility::groundpos(self.origin), 1);

  self waittill("_encstr_8B7205D9ED5958");
}

vehicle_landanims(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.landanims[var_2])) {
    return;
  }
  var_3 = level.vehicle.templates.landanims[var_2];

  foreach(var_5 in var_3)
  self setanim(var_5.land, 1, 0.2, 1);

  if(!var_1) {
    return;
  }
  if(isDefined(var_0))
    self waittill("_encstr_BD82096B5DA4B07F924F29");
  else
    self waittill("_encstr_B4EC0D2F7FA8DBF1E023DF6259C808");

  foreach(var_5 in var_3) {
    self clearanim(var_5.land, 0);
    self setanim(var_5.takeoff, 1, 0.2, 1);
  }
}

vehicle_landvehicle(var_0, var_1) {
  return _vehicle_landvehicle(var_0, var_1);
}

spawn_vehicle_and_attach_to_spline_path(var_0) {
  var_1 = scripts\common\utility::spawn_vehicle();

  if(isDefined(var_0))
    var_1 vehicle_setspeed(var_0);

  var_1 thread vehicle_becomes_crashable();
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.dontunloadonend = 1;
  var_1 scripts\common\vehicle_paths::gopath(var_1);
  var_1 leave_path_for_spline_path();
}

leave_path_for_spline_path() {
  self endon("_encstr_A375153736934B078EAFC6935837437DECACA1D2363695");
  scripts\engine\utility::waittill_either("_encstr_8E5013A5889133AD7B51939BF05BE5E78E6F294C13", "_encstr_8EE01139CA2C6C0D958CAF2B7346D737ED8CAC");
  var_0 = get_my_spline_node(self.origin);

  if(isDefined(level.drive_spline_path_fun))
    var_0 thread[[level.drive_spline_path_fun]](self);
}

get_my_spline_node(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = scripts\engine\utility::get_array_of_closest(var_0, level.snowmobile_path);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++)
    var_2[var_3] = var_1[var_3];

  foreach(var_5 in level.snowmobile_path) {
    foreach(var_7 in var_2) {
      if(var_7 == var_5)
        return var_7;
    }
  }
}

waittill_stable(var_0) {
  var_1 = 12;
  var_2 = 400;
  var_3 = gettime() + var_2;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_1 || abs(self.angles[2]) > var_1)
      var_3 = gettime() + var_2;

    if(gettime() > var_3) {
      break;
    }

    wait 0.05;
  }
}

_vehicle_unload(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    self.unload_group = var_0;

  if(scripts\engine\utility::ent_flag_exist("_encstr_A3BC17E0F56FA0837AD7ADB7273358D8E18D4E1B5DB4904F52")) {
    scripts\engine\utility::ent_flag_set("_encstr_A3BC17E0F56FA0837AD7ADB7273358D8E18D4E1B5DB4904F52");
    var_1 = spawn_unload_group(self.unload_group);

    foreach(var_3 in var_1)
    scripts\common\ai::spawn_failed(var_3);

    waittillframeend;
  }

  self notify("_encstr_A9210A283BEC90BB323450EC");
  var_1 = [];
  var_5 = level.vehicle.templates.unloadgroups[get_vehicle_classname()];

  if(isDefined(var_5)) {
    var_6 = scripts\common\vehicle_aianim::get_unload_group();

    if(istrue(self.vehiclesetuprope)) {
      for(var_7 = 0; var_7 < level.vehicle.templates.aianims[get_vehicle_classname()].size; var_7++) {
        var_8 = level.vehicle.templates.aianims[get_vehicle_classname()][var_7];

        if(istrue(var_8.setuprope)) {
          var_9 = 0;

          foreach(var_11 in self.riders) {
            if(isDefined(var_6[var_11.vehicle_position]) && var_11.vehicle_position != var_7) {
              var_12 = scripts\common\vehicle_aianim::anim_pos(self, var_11.vehicle_position);

              if(var_12.fastroperig == var_8.fastroperig) {
                var_9 = 1;
                break;
              }
            }
          }

          if(var_9) {
            foreach(var_11 in self.riders) {
              if(var_11.vehicle_position == var_7) {
                scripts\common\vehicle_aianim::guy_setup_rope(var_11, var_8);
                break;
              }
            }
          }
        }
      }
    }

    foreach(var_11 in self.riders) {
      if(isalive(var_11) && isDefined(var_6[var_11.vehicle_position])) {
        if(isDefined(level.vehicle.aianimcheck["_encstr_81A8077D3088BFA631"]) && ![[level.vehicle.aianimcheck["_encstr_81A8077D3088BFA631"]]](var_11, var_11.vehicle_position)) {
          continue;
        }
        var_8 = scripts\common\vehicle_aianim::anim_pos(self, var_11.vehicle_position);

        if(isDefined(var_8) && istrue(var_8.lootspawnitem)) {
          continue;
        }
        if(isDefined(level.vehicle.aianimthread["_encstr_81A8077D3088BFA631"])) {
          if(!istrue(var_8.setuprope)) {
            var_11 notify("_encstr_815B08652FCB0FB0A195");
            thread[[level.vehicle.aianimthread["_encstr_81A8077D3088BFA631"]]](var_11, var_11.vehicle_position);
            var_11 notify("_encstr_81A8077D3088BFA631");

            if(isDefined(var_8.mgturret))
              var_11 scripts\common\ai::stop_use_turret();

            var_1 = scripts\engine\utility::array_add(var_1, var_11);
          }
        }
      }
    }
  }

  return var_1;
}

_setvehgoalpos_wrap(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.originheightoffset))
    var_0 = var_0 + (0, 0, self.originheightoffset);

  self setvehgoalpos(var_0, var_1);
}

vehicle_kill_badplace_forever() {
  self notify("_encstr_AF69168B6B506B0115C082BBD06B46076E44072AF5FBB792");
}

vehicle_isdestructible() {
  return isDefined(self.destructible_type);
}

_kill_fx_play_direction(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = self getentityvelocity();
    var_2 = vectorNormalize(var_2);
    var_0 = vectorNormalize(var_0);
    var_3 = vectorlerp(var_2, var_0, var_1);
    return var_3;
  } else
    return undefined;
}

vehicle_playdeatheffects(var_0, var_1, var_2) {
  if(vehicle_isdestructible()) {
    return;
  }
  level notify("_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9", self.origin);
  self notify("_encstr_860808CB78E2984063BA", self.origin);
  thread vehicle_deathearthquake();
  thread vehicle_deathradiusdamage();
  thread vehicle_deathkilllights();
  thread vehicle_deathjolt(var_2);
  thread vehicle_deathvfx(var_0, var_1);
}

vehicle_deathvfx(var_0, var_1) {
  var_2 = get_vehicle_classname();

  if(vehicle_shoulddorocketdeath(var_0, var_1, var_2)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 3;
    var_3 = level.vehicle.templates.vehicle_rocket_death_fx[var_2];
  } else if(istrue(self.pilot_killed)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 4;
    var_3 = level.vehicle.templates.vehicle_rocket_death_fx[var_2];
  } else
    var_3 = level.vehicle.templates.vehicle_death_fx[var_2];

  foreach(var_5 in var_3)
  thread kill_fx_thread(self.model, var_5, self.vehicletype, var_0);
}

vehicle_deathearthquake() {
  var_0 = level.vehicle.templates.death_earthquake[get_vehicle_classname()];

  if(isDefined(var_0))
    earthquake(var_0.scale, var_0.duration, self.origin, var_0.radius);
}

vehicle_deathradiusdamage() {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }
  var_0 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.death_radiusdamage) || !isDefined(level.vehicle.templates.death_radiusdamage[var_0])) {
    return;
  }
  var_1 = level.vehicle.templates.death_radiusdamage[var_0].maxdamage;
  var_2 = level.vehicle.templates.death_radiusdamage[var_0].mindamage;
  self radiusdamage(self.origin + level.vehicle.templates.death_radiusdamage[var_0].offset, level.vehicle.templates.death_radiusdamage[var_0].range, var_1, var_2, self);
}

vehicle_deathkilllights() {
  scripts\common\vehicle_lights::lights_off_internal("_encstr_AF1904A7F929", self.model, get_vehicle_classname());
}

vehicle_deathjolt(var_0) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }
  if(!scripts\common\utility::issp() && self issuspendedvehicle()) {
    return;
  }
  self joltbody(var_0, 3.0);
}

vehicle_shoulddorocketdeath(var_0, var_1, var_2) {
  if(!vehicle_hasrocketdeath(var_2))
    return 0;

  if(istrue(self.vehicle_forcerocketdeath))
    return 1;

  if(scripts\engine\utility::is_equal(var_1, "_encstr_84670F0D974DCF124E3F7A931851A1FB9F"))
    return 1;

  if(scripts\engine\utility::is_equal(var_1, "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B"))
    return 1;

  if(scripts\engine\utility::is_equal(var_1, "_encstr_911B0C7DA090E9A7F799FD50DD48"))
    return 1;

  return 0;
}

vehicle_hasrocketdeath(var_0) {
  return isDefined(level.vehicle.templates.vehicle_rocket_death_fx[var_0]);
}

kill_fx_thread(var_0, var_1, var_2, var_3) {
  if(isDefined(self.pilot_killed))
    self waittill("_encstr_A1600C8D2C668880FBD9A9F0F29F");

  if(isDefined(self.nodeath)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  if(isDefined(var_1.waitdelay)) {
    if(var_1.waitdelay >= 0)
      wait(var_1.waitdelay);
    else
      self waittill("_encstr_A2CE0F32B2B0D11AD766969B4B371A5946");
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1.notifystring))
    self notify(var_1.notifystring);

  var_4 = vectorNormalize(self.origin - var_3.origin);

  if(isDefined(var_1.selfdeletedelay))
    scripts\engine\utility::delaycall(var_1.selfdeletedelay, ::delete);

  if(isDefined(var_1.effect)) {
    if(var_1.beffectlooping) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1.stayontag) && var_1.stayontag == 1)
          thread loop_fx_on_vehicle_tag(var_1.effect, var_1.delay, var_1.tag);
        else
          thread playloopedfxontag(var_1.effect, var_1.delay, var_1.tag);
      } else {
        var_5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_5);
      }
    } else if(isDefined(var_1.tag)) {
      var_5 = _kill_fx_play_direction(var_4, var_1.attacker_velocity_lerp);

      if(isDefined(var_5)) {
        var_6 = deathfx_ent();
        playFX(var_1.effect, var_6 gettagorigin(var_1.tag), var_5);

        if(isDefined(var_1.remove_deathfx_entity_delay))
          var_6 scripts\engine\utility::delaycall(var_1.remove_deathfx_entity_delay, ::delete);
      } else {
        var_6 = deathfx_ent();
        playFXOnTag(var_1.effect, var_6, var_1.tag);
        thread stop_fx_on_vehicle_watcher(var_1.effect, var_6, var_1.tag);

        if(isDefined(var_1.remove_deathfx_entity_delay))
          deathfx_ent() scripts\engine\utility::delaycall(var_1.remove_deathfx_entity_delay, ::delete);
      }
    } else {
      var_5 = _kill_fx_play_direction(var_4, var_1.attacker_velocity_lerp);

      if(isDefined(var_5))
        playFX(var_1.effect, self.origin, var_5);
      else {
        var_5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_5);
      }
    }
  }

  if(isDefined(var_1.sound)) {
    if(var_1.bsoundlooping)
      thread death_firesound(var_1.sound);
    else
      scripts\engine\utility::play_sound_in_space(var_1.sound);
  }
}

stop_fx_on_vehicle_watcher(var_0, var_1, var_2) {
  var_1 waittill("_encstr_AFAA127223D0D8512F4123F749C57A1410AEAF38");
  stopFXOnTag(var_0, var_1, var_2);
}

loop_fx_on_vehicle_tag(var_0, var_1, var_2) {
  self endon("_encstr_82CF1668B32D1916B367B82F4993D9FF570A60D80A497DCA");

  while(isDefined(self)) {
    playFXOnTag(var_0, deathfx_ent(), var_2);
    wait(var_1);
  }
}

death_firesound(var_0) {
  thread scripts\engine\utility::script_func("_encstr_87F01598DA46D3A8975F0F86278790A1A172E059F39E17", var_0, undefined, 0, 1);
  scripts\engine\utility::_id_143A5("_encstr_973A10CC5A93ACBE56871D4B37ECBA2DE6A1", "_encstr_A96616DC3AF60EAF8D4E2C6E1AFAB1F6F60EBECDDBEAE623");

  if(!isDefined(self)) {
    return;
  }
  self notify("_encstr_9B8F0BAE0BE2F1097BBF50807B" + var_0);
}

deathfx_ent() {
  if(isDefined(self.death_fx_on_self) && self.death_fx_on_self)
    return self;

  if(!isDefined(self.deathfx_ent)) {
    var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_0 setModel(self.model);
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkTo(self);
    var_0.death_fx = 1;
    self.deathfx_ent = var_0;
  } else
    self.deathfx_ent setModel(self.model);

  return self.deathfx_ent;
}

playloopedfxontag(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self endon("_encstr_973A10CC5A93ACBE56871D4B37ECBA2DE6A1");
  thread playloopedfxontag_originupdate(var_2, var_3);

  for(;;) {
    playFX(var_0, var_3.origin, var_3.upvec);
    wait(var_1);
  }
}

playloopedfxontag_originupdate(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1.forwardvec = anglesToForward(var_1.angles);
  var_1.upvec = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && self vehicle_getspeed() > 0) {
    var_1.angles = self gettagangles(var_0);
    var_1.origin = self gettagorigin(var_0);
    var_1.forwardvec = anglesToForward(var_1.angles);
    var_1.upvec = anglestoup(var_1.angles);
    wait 0.05;
  }
}

_getvehiclespawnerarray(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = 1;
    var_4 = getEntArray(var_0, var_1);
  } else {
    var_3 = 0;
    var_4 = getEntArray("_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", "_encstr_956D0F572FD22561C3BD81DB62A6D869BA");
  }

  foreach(var_6 in var_4) {
    if(var_3 && var_6.code_classname != "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    if(isspawner(var_6))
      var_2[var_2.size] = var_6;
  }

  return var_2;
}

update_steering(var_0) {
  if(var_0.update_time == gettime())
    return var_0.steering;

  var_0.update_time = gettime();

  if(var_0.steering_enable) {
    var_1 = clamp(0 - var_0.angles[2], 0 - var_0.steering_maxroll, var_0.steering_maxroll) / var_0.steering_maxroll;

    if(isDefined(var_0.leanasitturns) && var_0.leanasitturns) {
      var_2 = var_0 vehicle_getsteering();
      var_2 = var_2 * -1.0;
      var_1 = var_1 + var_2;

      if(var_1 != 0) {
        var_3 = 1.0 / abs(var_1);

        if(var_3 < 1)
          var_1 = var_1 * var_3;
      }
    }

    var_4 = var_1 - var_0.steering;

    if(var_4 != 0) {
      var_5 = var_0.steering_maxdelta / abs(var_4);

      if(var_5 < 1)
        var_4 = var_4 * var_5;

      var_0.steering = var_0.steering + var_4;
    }
  } else
    var_0.steering = 0;

  return var_0.steering;
}

get_from_spawnStruct(var_0) {
  return scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1) && var_1.size > 0)
    return var_1[randomint(var_1.size)];

  return undefined;
}

get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

damage_hint_bullet_only() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "_encstr_A6260731BAD8D82BD1":
      case "_encstr_A68211E38F83592A6FFBE1F15F060B586B6BB8":
      case "_encstr_950A12ADDEC87D384BDC3A7BB1D74CEAD8C6B21D":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          var_1 scripts\engine\utility::script_func("_encstr_A9020DA9C7535F0811289688D4F6A3", "_encstr_AF2314A1F00B17A57320BA82F85B51F3C3693C251573");
          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self))
            self.displayingdamagehints = 0;

          break;
        }
    }
  }
}

damage_hints() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "_encstr_950B13ADDEC87DB39359370B9159EBE6E0C6B0DCA1":
      case "_encstr_911B0C5DA292E9AFF398BD52D94A":
      case "_encstr_A6260731BAD8D82BD1":
      case "_encstr_A68211E38F83592A6FFBE1F15F060B586B6BB8":
      case "_encstr_950A12ADDEC87D384BDC3A7BB1D74CEAD8C6B21D":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;

          if(var_4 == "_encstr_911B0C5DA292E9AFF398BD52D94A" || var_4 == "_encstr_950B13ADDEC87DB39359370B9159EBE6E0C6B0DCA1")
            var_1 scripts\engine\utility::script_func("_encstr_A9020DA9C7535F0811289688D4F6A3", "_encstr_A2D8122DDCD9BAB19527589836AC7DCC93C2B3B9", 5);
          else
            var_1 scripts\engine\utility::script_func("_encstr_A9020DA9C7535F0811289688D4F6A3", "_encstr_AF2314A1F00B17A57320BA82F85B51F3C3693C251573", 5);

          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self))
            self.displayingdamagehints = 0;

          break;
        }
    }
  }
}

damage_hints_cleanup() {
  self waittill("_encstr_AD75063D571AE108");

  if(self.displayingdamagehints)
    level.armordamagehints = 0;
}

aircraft_wash_thread(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A2CE0F32B2B0D11AD766969B4B371A5946");
  self notify("_encstr_8EF3150E84607851B233B3DCA07E77872F903F8F3D53EB");
  self endon("_encstr_8EF3150E84607851B233B3DCA07E77872F903F8F3D53EB");
  var_1 = 2000;

  if(isDefined(level.treadfx_maxheight))
    var_1 = level.treadfx_maxheight;

  var_2 = 80 / var_1;
  var_3 = 0.5;

  if(isairplane_internal())
    var_3 = 0.15;

  var_4 = self;

  if(isDefined(var_0))
    var_4 = var_0;

  var_5 = 3;

  for(;;) {
    wait(var_3);

    if(1) {
      if(isDefined(self.disable_wash) && self.disable_wash) {
        continue;
      }
      if(isDefined(self.treadfx_maxheight))
        var_1 = self.treadfx_maxheight;

      var_6 = anglestoup(var_4.angles) * -1;
      var_7 = undefined;
      var_5++;

      if(var_5 > 3) {
        var_5 = 3;
        var_7 = scripts\engine\trace::ray_trace(var_4.origin, var_4.origin + var_6 * var_1, var_4, undefined, 1);
      }

      if(var_7["_encstr_A53009A25003666B9818C6"] == 1 || var_7["_encstr_A53009A25003666B9818C6"] < var_2) {
        continue;
      }
      var_8 = distance(var_4.origin, var_7["_encstr_BD260953AA97E3F014279D"]);
      var_9 = get_wash_fx(self, var_7, var_6, var_8);

      if(!isDefined(var_9)) {
        continue;
      }
      var_3 = (var_8 - 350) / (var_1 - 350) * 0.1 + 0.05;
      var_3 = max(var_3, 0.05);

      if(!isDefined(var_7)) {
        continue;
      }
      if(!isDefined(var_7["_encstr_BD260953AA97E3F014279D"])) {
        continue;
      }
      var_10 = var_7["_encstr_BD260953AA97E3F014279D"];
      var_11 = var_7["_encstr_820E07FAE8780B3A4C"];
      var_8 = vectordot(var_10 - var_4.origin, var_11);
      var_12 = var_4.origin + (0, 0, var_8);
      var_13 = var_10 - var_12;

      if(isDefined(self.treadfx_orient_to_player))
        var_13 = var_10 - level.player.origin;

      if(vectordot(var_7["_encstr_820E07FAE8780B3A4C"], (0, 0, 1)) == -1) {
        continue;
      }
      if(length(var_13) < 1)
        var_13 = var_4.angles + (0, 180, 0);

      playFX(var_9, var_10, var_11, var_13);
    }
  }
}

get_wash_fx(var_0, var_1, var_2, var_3) {
  var_4 = var_1["_encstr_8BCA0C2BFD504F333E6D7513637B"];
  var_5 = undefined;
  var_6 = vectordot((0, 0, -1), var_2);

  if(var_6 >= 0.97)
    var_5 = undefined;
  else if(var_6 >= 0.92)
    var_5 = "_encstr_85D80671C9373354";
  else
    var_5 = "_encstr_8D2309E159A7A3C4D9F157";

  return get_wash_effect(var_0 get_vehicle_classname(), var_4, var_5);
}

get_wash_effect(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_1 + var_2;

    if(!isDefined(level.vehicle.templates.surface_effects[var_0][var_3]) && var_1 != "_encstr_8B1608EC43B8D647A113")
      return get_wash_effect(var_0, "_encstr_8B1608EC43B8D647A113", var_2);
    else
      return level.vehicle.templates.surface_effects[var_0][var_3];
  }

  return get_vehicle_effect(var_0, var_1);
}

get_vehicle_effect(var_0, var_1) {
  if(!isDefined(level.vehicle.templates.surface_effects[var_0][var_1]) && var_1 != "_encstr_8B1608EC43B8D647A113")
    return get_vehicle_effect(var_0, "_encstr_8B1608EC43B8D647A113");
  else
    return level.vehicle.templates.surface_effects[var_0][var_1];

  return undefined;
}

no_treads() {
  return ishelicopter_internal() || isairplane_internal();
}

vehicle_hasdustkickup() {
  if(!ishelicopter_internal() && !isairplane_internal())
    return 0;

  return 1;
}

hashelicopterturret() {
  if(!isDefined(self.vehicletype))
    return 0;

  if(self.vehicletype == "_encstr_A38E06A1A0985212")
    return 1;

  if(self.vehicletype == "_encstr_B6CF0D36B74C270B7DE01BC2BC59C9")
    return 1;

  if(self.vehicletype == "_encstr_8751061B1387EACA")
    return 1;

  return 0;
}

_id_14101() {
  self endon("_encstr_8D08126ED1BD0EEB16D2AFB0B3BD2D320BE6D856");
  self waittill("_encstr_AD75063D571AE108");
  vehicle_remove_navobstacle();
  vehicle_remove_navrepulsor();
}

vehicle_ai_avoidance_logic() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D08126ED1BD0EEB16D2AFB0B3BD2D320BE6D856");
  thread _id_14101();
  var_0 = self vehicle_isphysveh();
  var_1 = 25.0;

  for(;;) {
    vehicle_navobstacle();
    var_2 = self.origin;

    while(vehicle_is_stopped() && (!var_0 || self vehicle_isonground())) {
      wait 0.1;

      if(lengthsquared(self.origin - var_2) > var_1) {
        vehicle_remove_navobstacle();
        vehicle_navobstacle();
        var_2 = self.origin;
      }
    }

    vehicle_remove_navobstacle();
    vehicle_navrepulsor();

    while(!vehicle_is_stopped() || var_0 && !self vehicle_isonground())
      wait 0.1;

    vehicle_remove_navrepulsor();
  }
}

vehicle_is_stopped() {
  if(!scripts\common\utility::issp() && self issuspendedvehicle())
    return 1;

  if(self vehicle_isphysveh())
    return self vehicle_getspeed() < 0.01;

  return self vehicle_getspeed() == 0;
}

vehicle_ai_avoidance_heli() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D08126ED1BD0EEB16D2AFB0B3BD2D320BE6D856");
  thread _id_14101();

  for(;;) {
    vehicle_navobstacle();

    while(self vehicle_getspeed() == 0 && (!isDefined(self.script_disconnectpaths) || istrue(self.script_disconnectpaths)))
      wait 0.1;

    vehicle_remove_navobstacle();

    while(self vehicle_getspeed() != 0 || isDefined(self.script_disconnectpaths) && !istrue(self.script_disconnectpaths))
      wait 0.1;
  }
}

vehicle_navrepulsor() {
  if(isDefined(self.script_badplace) && !istrue(self.script_badplace)) {
    return;
  }
  createnavrepulsor(self.unique_id + "_encstr_9B0C11EC59D0A5D8B1B2F53185230736166C59", -1, self, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
}

vehicle_remove_navrepulsor() {
  destroynavrepulsor(self.unique_id + "_encstr_9B0C11EC59D0A5D8B1B2F53185230736166C59");
}

vehicle_navobstacle() {
  if(isDefined(self.script_disconnectpaths) && !istrue(self.script_disconnectpaths)) {
    return;
  }
  self.navobstacleid = createnavbadplacebyent(self);
}

vehicle_remove_navobstacle() {
  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
    self.navobstacleid = undefined;
  }
}

vehicle_disable_navrepulsors() {
  self.script_badplace = 0;
  vehicle_remove_navrepulsor();
}

vehicle_enable_navrepulsors() {
  self.script_badplace = undefined;

  if(!vehicle_is_stopped())
    vehicle_navrepulsor();
}

vehicle_disable_navobstacles() {
  self.script_disconnectpaths = 0;
  vehicle_remove_navobstacle();
}

vehicle_enable_navobstacles() {
  self.script_disconnectpaths = undefined;

  if(vehicle_is_stopped())
    vehicle_navobstacle();
}

vehicle_badplace() {
  vehicle_navrepulsor();
}

vehicle_remove_badplace() {
  vehicle_remove_navrepulsor();
}

disconnect_paths_whenstopped() {
  self endon("_encstr_AD75063D571AE108");
  self.pathsdisconnected = 0;
  var_0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
    var_0 = 1;

  if(var_0) {
    self.dontdisconnectpaths = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
        self.pathsdisconnected = 1;
      } else {}

      self notify("_encstr_BDEE1BD237DB427CF6F0BFFB40AE204A8143518F135FFA8F3878B7B7F0");

      while(self vehicle_getspeed() < 1) {
        if(isDefined(self.dontdisconnectpaths) && self.dontdisconnectpaths) {
          break;
        }

        wait 0.05;
      }
    }

    self connectpaths();
    self.pathsdisconnected = 0;
    wait 1;
  }
}

_encstr_8E0D1B1C7FA2F3717487F1982B91AB3139E61B30D61BB77824AF60E077() {
  if(getdvarint("_encstr_8A4E24D366B239F6EBAF352B4B624E687DF119688109C838322B13358F4A98781ED6E140B774", 1) == 0) {
    return;
  }
  foreach(var_5, var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      if(istrue(var_3.isheli)) {
        var_3 thread vehicle_ai_avoidance_heli();
        continue;
      }

      var_3 thread vehicle_ai_avoidance_logic();
    }
  }
}

_encstr_A9F51ACE950D2D6C63CABECDD1ED0EBEC2A5AFB067F6D219B0B98DB2() {
  if(getdvarint("_encstr_8A4E24D366B239F6EBAF352B4B624E687DF119688109C838322B13358F4A98781ED6E140B774", 1) == 0) {
    return;
  }
  foreach(var_5, var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      var_3 notify("_encstr_8D08126ED1BD0EEB16D2AFB0B3BD2D320BE6D856");
      var_3 vehicle_remove_navobstacle();
      var_3 vehicle_remove_navrepulsor();
    }
  }
}

mainturretinit() {
  var_0 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.mainturret[var_0])) {
    return;
  }
  var_1 = level.vehicle.templates.mainturret[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = "_encstr_B40101";

  if(isDefined(self.script_turrets))
    var_2 = self.script_turrets;

  self.mainturret = turretinitshared(var_1);

  if(!isDefined(self.script_turretmain))
    self.script_turretmain = 1;

  if(self.script_turretmain == 0)
    thread _mainturretoff();
  else {
    self.script_turretmain = 1;
    thread _mainturreton();
  }
}

mginit() {
  var_0 = get_vehicle_classname();

  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }
  if(!isDefined(level.vehicle.templates.mgturret[var_0])) {
    return;
  }
  var_1 = level.vehicle.templates.mgturret[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = "_encstr_B40101";

  if(isDefined(self.script_turrets))
    var_2 = self.script_turrets;

  foreach(var_5, var_4 in var_1) {
    if(isDefined(var_4.referencename) && !issubstr(var_2, var_4.referencename)) {
      continue;
    }
    self.mgturret[var_5] = turretinitshared(var_4);
  }

  if(!isDefined(self.script_turretmg))
    self.script_turretmg = 1;

  if(self.script_turretmg == 0)
    thread _mgoff();
  else {
    self.script_turretmg = 1;
    thread _mgon();
  }
}

turretinitshared(var_0) {
  var_1 = 0;

  if(isDefined(self.script_mg_angle))
    var_1 = self.script_mg_angle;

  var_2 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", (0, 0, 0), var_0.info);
  var_3 = (0, 0, 0);

  if(isDefined(var_0.offset_tag))
    var_3 = (0, 0, 0);

  var_4 = self;

  if(isDefined(var_0.mainturretchild)) {
    if(!isDefined(self.mainturret)) {}

    var_4 = self.mainturret;
  }

  var_2 linkTo(var_4, var_0.tag, var_3, (0, -1 * var_1, 0));
  var_2 setModel(var_0.model);
  var_2.angles = self.angles;
  var_2.isvehicleattached = 1;
  var_2.ownervehicle = self;
  var_2.weaponinfo = var_0.info;
  var_2.script_team = self.script_team;
  var_2 makeusable();
  set_turret_team(var_2);
  level thread vehicle_turret_difficulty(var_2, scripts\common\utility::getdifficulty());

  if(isDefined(self.script_fireondrones))
    var_2.script_fireondrones = self.script_fireondrones;

  if(isDefined(var_0.deletedelay))
    var_2.deletedelay = var_0.deletedelay;

  if(isDefined(var_0.defaultdroppitch))
    var_2 setdefaultdroppitch(var_0.defaultdroppitch);

  if(isDefined(var_0.referencename))
    var_2.referencename = var_0.referencename;

  if(isDefined(var_0.defaultonmode))
    var_2 turret_set_default_on_mode(var_0.defaultonmode);

  return var_2;
}

vehicle_turret_difficulty(var_0, var_1) {
  var_0.convergencetime = level.mgturretsettings[var_1]["_encstr_B4B81020CAA5ADE98337E5680BE7F75BCDF2"];
  var_0.suppressiontime = level.mgturretsettings[var_1]["_encstr_B24210A33BAF5B02884FC3D11FB8C3475951"];
  var_0.accuracy = level.mgturretsettings[var_1]["_encstr_82DD09CFCB90B55651A6EB"];
  var_0.aispread = level.mgturretsettings[var_1]["_encstr_B6F309895C67D3CA48709D"];
  var_0.playerspread = level.mgturretsettings[var_1]["_encstr_A5DC0D071B58975993A9C19395588C"];
}

turret_set_default_on_mode(var_0) {
  self.defaultonmode = var_0;
}

set_turret_team(var_0) {
  switch (self.script_team) {
    case "_encstr_ACFC091AE8AB2FCBE15119":
    case "_encstr_9A8507BA4040188D08":
      var_0 setturretteam("_encstr_9A8507BA4040188D08");
      break;
    case "_encstr_88BF06FD784A6393":
    case "_encstr_8E8405EA382B2A":
      var_0 setturretteam("_encstr_8E8405EA382B2A");
      break;
    case "_encstr_B848067B63177293":
      var_0 setturretteam("_encstr_B848067B63177293");
      break;
    default:
      break;
  }
}

#using_animtree("_encstr_B40101");

animate_drive_idle() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  self endon("_encstr_959D14BF9BD66B0D10D181570B704672B8CB434F037E");

  if(!isDefined(self.vehiclewheeldirection))
    self.vehiclewheeldirection = 1;

  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;

  if(!isDefined(level.vehicle.templates.driveidle[var_0])) {
    return;
  }
  self useanimtree(#animtree);

  if(!isDefined(level.vehicle.templates.driveidle_r[var_0]))
    level.vehicle.templates.driveidle_r[var_0] = level.vehicle.templates.driveidle[var_0];

  self endon("_encstr_AD75063D571AE108");
  var_3 = level.vehicle.templates.driveidle_normal_speed[var_0];
  var_4 = 1.0;

  if(isDefined(level.vehicle.templates.driveidle_animrate) && isDefined(level.vehicle.templates.driveidle_animrate[var_0]))
    var_4 = level.vehicle.templates.driveidle_animrate[var_0];

  var_5 = self.vehiclewheeldirection;
  var_6 = level.vehicle.templates.driveidle[var_0];

  for(;;) {
    if(!var_3) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      self setanim(level.vehicle.templates.driveidle[var_0], 1, 0.2, var_4);
      return;
    }

    var_7 = self vehicle_getspeed();

    if(var_5 != self.vehiclewheeldirection) {
      var_8 = 0;

      if(self.vehiclewheeldirection) {
        var_6 = level.vehicle.templates.driveidle[var_0];
        var_8 = 1 - get_normal_anim_time(level.vehicle.templates.driveidle_r[var_0]);
        self clearanim(level.vehicle.templates.driveidle_r[var_0], 0);
      } else {
        var_6 = level.vehicle.templates.driveidle_r[var_0];
        var_8 = 1 - get_normal_anim_time(level.vehicle.templates.driveidle[var_0]);
        self clearanim(level.vehicle.templates.driveidle[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0)
        var_2 = 0.01;

      var_5 = self.vehiclewheeldirection;
    }

    var_9 = var_7 / var_3;

    if(var_9 != var_1) {
      self setanim(var_6, 1, 0.05, var_9);
      var_1 = var_9;
    }

    if(isDefined(var_2)) {
      self setanimtime(var_6, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

setup_vehicles(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isspawner(var_3))
      continue;
    else
      var_1[var_1.size] = var_3;
  }

  foreach(var_6 in var_1)
  thread vehicle_init(var_6);
}

vehicle_setstartinghealth() {
  var_0 = get_vehicle_classname();

  if(isDefined(self.script_startinghealth))
    self.health = self.script_startinghealth;
  else {
    if(level.vehicle.templates.life[var_0] == -1) {
      return;
    }
    if(isDefined(level.vehicle.templates.life_range_low[var_0]) && isDefined(level.vehicle.templates.life_range_high[var_0]))
      self.health = randomint(level.vehicle.templates.life_range_high[var_0] - level.vehicle.templates.life_range_low[var_0]) + level.vehicle.templates.life_range_low[var_0];
    else
      self.health = level.vehicle.templates.life[var_0];
  }
}

get_normal_anim_time(var_0) {
  var_1 = self getanimtime(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0)
    return 0;

  return self getanimtime(var_0) / getanimlength(var_0);
}

suspend_drive_anims() {
  self notify("_encstr_959D14BF9BD66B0D10D181570B704672B8CB434F037E");
  self clearanim(level.vehicle.templates.driveidle[self.model], 0);
  self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
}

#using_animtree("_encstr_B40101");

idle_animations() {
  if(!isDefined(level.vehicle.templates.idle_anim[self.model])) {
    return;
  }
  self useanimtree(#animtree);

  foreach(var_1 in level.vehicle.templates.idle_anim[self.model])
  self setanim(var_1);
}

vehicle_rumble() {
  self endon("_encstr_8E601457C8AB31F0C383CF89623581AD97FA9D6CE7A0");
  var_0 = get_vehicle_classname();
  var_1 = level.vehicle.templates.rumble[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkTo();
  var_4 linkTo(self);
  self.rumbletrigger = var_4;
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.rumbleon))
    self.rumbleon = 1;

  if(isDefined(var_1.scale))
    self.rumble_scale = var_1.scale;
  else
    self.rumble_scale = 0.15;

  if(isDefined(var_1.duration))
    self.rumble_duration = var_1.duration;
  else
    self.rumble_duration = 4.5;

  if(isDefined(var_1.radius))
    self.rumble_radius = var_1.radius;
  else
    self.rumble_radius = 600;

  if(isDefined(var_1.basetime))
    self.rumble_basetime = var_1.basetime;
  else
    self.rumble_basetime = 1;

  if(isDefined(var_1.randomaditionaltime))
    self.rumble_randomaditionaltime = var_1.randomaditionaltime;
  else
    self.rumble_randomaditionaltime = 1;

  var_4.radius = self.rumble_radius;

  for(;;) {
    var_4 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(vehicle_is_stopped() && !isDefined(self.forcerumble) || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var_1.rumble);

    if(isDefined(self.vehicletype)) {
      var_5 = self.vehicletype + "_encstr_8FC20C972D60955BE17111DB39C3";

      if(soundexists(var_5))
        level.player playSound(var_5);
    }

    while(level.player istouching(var_4) && self.rumbleon && (!vehicle_is_stopped() || isDefined(self.forcerumble))) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }

    self stoprumble(var_1.rumble);
  }
}

vehicle_setteam() {
  var_0 = get_vehicle_classname();

  if(!isDefined(self.script_team) && isDefined(level.vehicle.templates.team[var_0]))
    self.script_team = level.vehicle.templates.team[var_0];
}

vehicle_handleunloadevent() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.vehicletype;

  if(!scripts\engine\utility::ent_flag_exist("_encstr_BD82096B5DA4B07F924F29"))
    scripts\engine\utility::ent_flag_init("_encstr_BD82096B5DA4B07F924F29");
}

get_vehiclenode_any_dynamic(var_0) {
  var_1 = getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1))
    var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else if(ishelicopter_internal()) {}

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

vehicle_damagelogic() {
  self endon("_encstr_AD75063D571AE108");
  self.damage_functions = [];
  var_0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[var_0]) && !isDefined(self.script_bulletshield))
    self.script_bulletshield = level.vehicle.templates.bullet_shield[var_0];

  if(isDefined(level.vehicle.templates.grenade_shield[var_0]) && !isDefined(self.script_grenadeshield))
    self.script_grenadeshield = level.vehicle.templates.bullet_shield[var_0];

  self.healthbuffer = 20000;
  self.health = self.health + self.healthbuffer;
  var_1 = self.health;

  while(self.health > 0) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(istrue(self.interaction_is_jugg_maze_button)) {
      return;
    }
    foreach(var_13 in self.damage_functions)
    thread[[var_13]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_3)) {
      var_3 scripts\engine\utility::script_func("_encstr_8E9312A6ED6CB4A3BBC2F50FB20A28AB4F1ADBCB");

      if(scripts\engine\utility::func_ref_exist("_encstr_8D0E18DBB56330034C871198DFF8CFE7EDA87F3DF8A4E48B431B")) {
        var_15 = undefined;

        if(isDefined(level.player_xp))
          var_15 = [[level.player_xp]](var_3, self, var_2, var_11, var_6, undefined, var_5, var_4, var_7, var_9, var_8, var_10);

        if(isDefined(var_15))
          self.is_area_in_verdansk = var_15;
        else
          self.is_area_in_verdansk = undefined;

        var_16 = scripts\engine\utility::script_func("_encstr_8D0E18DBB56330034C871198DFF8CFE7EDA87F3DF8A4E48B431B", var_15);

        if(isDefined(var_16))
          var_2 = var_16;
      }
    }

    if(vehicle_should_regenerate(var_3, var_6) || _is_godmode()) {
      if(isDefined(self.regenerate) && !istrue(self.regenerate))
        var_1 = self.health;
      else
        self.health = var_1;
    } else {
      if(scripts\common\utility::issp() && isDefined(var_6)) {
        var_17 = 0;

        if(var_6 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_6 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")
          var_17 = var_2 * 12;
        else if(var_6 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_6 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")
          var_17 = var_2 * 5;

        if(var_17)
          self.health = self.health - int(var_17);
      }

      var_1 = self.health;
    }

    if(!istrue(self._id_13DD4) && self.health <= self.healthbuffer)
      self notify("_encstr_AD75063D571AE108", var_3, var_6, var_11, var_5);
  }
}

vehicle_isalive(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.healthbuffer) && var_0.health < var_0.healthbuffer)
    return 0;

  if(var_0.health <= 0)
    return 0;

  return 1;
}

grenadeshielded(var_0) {
  if(!isDefined(self.script_grenadeshield))
    return 0;

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "_encstr_8C8D08671D451291C849"))
    return 0;

  if(self.script_grenadeshield)
    return 1;
  else
    return 0;
}

bulletshielded(var_0) {
  if(!isDefined(self.script_bulletshield))
    return 0;

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "_encstr_A6260731BAD8D82BD1") || issubstr(var_0, "_encstr_AB440A3180D0C0109B17550B"))
    return 0;

  if(self.script_bulletshield)
    return 1;
  else
    return 0;
}

explosive_bulletshielded(var_0) {
  if(!isDefined(self.script_explosive_bullet_shield))
    return 0;

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "_encstr_AB440A3180D0C0109B17550B"))
    return 0;

  if(self.script_explosive_bullet_shield)
    return 1;
  else
    return 0;
}

vehicle_should_regenerate(var_0, var_1) {
  return !isDefined(var_0) && self.script_team != "_encstr_A7A408B9CA5D1D4E2C63" || attacker_isonmyteam(var_0) || attacker_troop_isonmyteam(var_0) || is_invulnerable_from_ai(var_0) || bulletshielded(var_1) || explosive_bulletshielded(var_1) || grenadeshielded(var_1) || var_1 == "_encstr_8DED0A21C79B660BC7588981";
}

_is_godmode() {
  return istrue(self.godmode);
}

is_invulnerable_from_ai(var_0) {
  if(!isDefined(self.script_ai_invulnerable))
    return 0;

  if(isDefined(var_0) && isai(var_0) && self.script_ai_invulnerable == 1)
    return 1;
  else
    return 0;
}

attacker_troop_isonmyteam(var_0) {
  if(!istrue(self._id_13DD4) && isDefined(self.script_team) && self.script_team == "_encstr_9A8507BA4040188D08" && isDefined(var_0) && isPlayer(var_0))
    return 1;
  else if(isai(var_0) && scripts\engine\utility::is_equal(var_0.team, self.script_team))
    return 1;
  else
    return 0;
}

attacker_isonmyteam(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team)
    return 1;

  return 0;
}

vehicle_setwheeldirection(var_0) {
  self.vehiclewheeldirection = scripts\engine\utility::ter_op(var_0 <= 0, 0, 1);
}

vehicle_playexhausteffect() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.vehicle.templates.exhaust_fx[self.model])) {
    return;
  }
  for(;;) {
    playFXOnTag(level.vehicle.templates.exhaust_fx[self.model], self, "_encstr_916813E8B076D75937ECD29B56FA590F1A16AEE647");
    waitframe();
  }
}

vehicle_playengineeffect() {
  var_0 = level.vehicle.templates.engine_fx[self.classname];

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0.25;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    if(!vehicle_isalive(self)) {
      return;
    }
    var_4 = var_0.effect;
    var_3 = var_0.effect_tag;
    var_5 = self vehicle_getspeed() / self vehicle_gettopspeedforward();

    if(isDefined(self.enginefx_effort_scale))
      var_5 = var_5 * self.enginefx_effort_scale;

    if(isDefined(var_0.max_effort_effect) && var_5 >= var_0.max_effort_ratio)
      var_4 = var_0.max_effort_effect;
    else if(isDefined(var_0.med_effort_effect) && var_5 >= var_0.med_effort_ratio)
      var_4 = var_0.med_effort_effect;
    else if(isDefined(var_0.min_effort_effect) && var_5 >= var_0.min_effort_ratio)
      var_4 = var_0.min_effort_effect;

    if(!isDefined(var_2) || var_2 != var_4) {
      if(isDefined(var_2)) {
        stopFXOnTag(var_2, self, var_3);
        waitframe();

        if(!vehicle_isalive(self))
          return;
      }

      playFXOnTag(var_4, self, var_3);
      var_2 = var_4;
    }

    wait(var_1);
  }
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("_encstr_87DE08E656DDC158E81A");

  if(ishelicopter_internal()) {
    self setgoalyaw(scripts\engine\utility::flat_angle(self.angles)[1]);
    self setvehgoalpos(self.origin + (0, 0, 4), 1);
  }
}

deathrollon() {
  if(self.health > 0)
    self.rollingdeath = 1;
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("_encstr_A2B90D8CAC0BD11A277BB163B7CC33");
}

_mainturretoff() {
  self.script_turretmain = 0;

  if(!isDefined(self.mainturret)) {
    return;
  }
  _turretoffshared(self.mainturret);
}

_mainturreton() {
  self.script_turretmain = 1;

  if(!isDefined(self.mainturret)) {
    return;
  }
  _turretonshared(self.mainturret);
}

_mgoff() {
  self.script_turretmg = 0;

  if(ishelicopter_internal() && hashelicopterturret()) {
    if(isDefined(level.chopperturretfunc)) {
      self thread[[level.chopperturretofffunc]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_2, var_1 in self.mgturret)
  _turretoffshared(var_1);
}

_mgon() {
  self.script_turretmg = 1;

  if(ishelicopter_internal() && hashelicopterturret()) {
    self thread[[level.chopperturretonfunc]]();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_1 in self.mgturret) {
    var_1 show();
    _turretonshared(var_1);
  }
}

_turretoffshared(var_0) {
  if(isDefined(var_0.script_fireondrones))
    var_0.script_fireondrones = 0;

  var_0 setmode("_encstr_849007B268BD03DFD8");
}

_turretonshared(var_0) {
  if(isDefined(var_0.script_fireondrones))
    var_0.script_fireondrones = 1;

  if(isDefined(var_0.defaultonmode)) {
    if(var_0.defaultonmode != "_encstr_9B1807D39B48FD93A3")
      var_0 setmode(var_0.defaultonmode);
  } else
    var_0 setmode("_encstr_97910BA3154320F8EBBA8811A2");

  set_turret_team(var_0);
}

get_vehicle_riders_spawners() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::noself_func_return("_encstr_BDF7104F95ABEF02DBA8EA5268337A13E103", self.target);

    if(!isDefined(var_1))
      var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_1))
      var_1 = [];

    foreach(var_3 in var_1) {
      if(isstruct(var_3)) {
        if(!isDefined(var_3.script_demeanor))
          continue;
      } else {
        if(!issubstr(var_3.code_classname, "_encstr_8B3906DEE920EF5B") && !issubstr(var_3.code_classname, "_encstr_9A50080BA7292FFA0DA2")) {
          continue;
        }
        if(issubstr(var_3.code_classname, "_encstr_8B3906DEE920EF5B")) {
          if(!isspawner(var_3))
            continue;
          else if(issubstr(var_3.code_classname, "_encstr_9A50080BA7292FFA0DA2")) {
            if(!(var_3.spawnflags & 2))
              continue;
          }
        }
      }

      if(isDefined(var_3.dont_auto_ride)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

vehicle_spawn_internal(var_0) {
  if(isDefined(var_0.script_delay_spawn)) {
    var_0 endon("_encstr_AD75063D571AE108");
    wait(var_0.script_delay_spawn);
  }

  if(!scripts\common\utility::issp())
    var_1 = vehicle_spawn_mp_internal(var_0);
  else
    var_1 = var_0 vehicle_dospawn();

  if(!isDefined(var_0.spawned_count))
    var_0.spawned_count = 0;

  var_0.spawned_count++;
  var_0.vehicle_spawned_thisframe = var_1;
  var_0.last_spawned_vehicle = var_1;
  var_0 thread remove_vehicle_spawned_thisframe();
  var_1.vehicle_spawner = var_0;
  thread vehicle_init(var_1);
  var_0 notify("_encstr_BA350853C128FB939DB9", var_1);
  return var_1;
}

vehicle_spawn_mp_internal(var_0) {
  var_1 = "_encstr_9319180375F213369BCA5B4F4E109FA949BFD26F5FC3521770A8";

  if(isDefined(var_0.targetname))
    var_1 = var_0.targetname;

  if(!isDefined(var_0.classname_mp))
    var_2 = var_0.classname;
  else
    var_2 = var_0.classname_mp;

  var_3 = spawnVehicle(level.vehicle.templates.model[var_2], var_1, var_0.vehicletype, var_0.origin, var_0.angles);
  var_3.vehicletype = var_0.vehicletype;
  var_3.classname_mp = var_2;

  if(isDefined(var_0.target))
    var_3.target = var_0.target;

  return var_3;
}

setvehgoalpos_wrap(var_0, var_1) {
  return _setvehgoalpos_wrap(var_0, var_1);
}

vehicle_liftoffvehicle(var_0) {
  if(!isDefined(var_0))
    var_0 = 512;

  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(var_1, 1);
  self waittill("_encstr_8B7205D9ED5958");
}

vehicle_shouldplaydeathanimation(var_0) {
  if(!vehicle_hasdeathanimations(var_0))
    return 0;

  if(istrue(self.vehicle_skipdeathanimation))
    return 0;

  return 1;
}

vehicle_hasdeathanimations(var_0) {
  return isDefined(level.vehicle.templates.deathanimations[var_0 get_vehicle_classname()]);
}

vehicle_getdeathanimation(var_0, var_1) {
  var_2 = level.vehicle.templates.deathanimations[var_0 get_vehicle_classname()];

  if(isDefined(var_1)) {
    var_3 = var_0 getpointinbounds(0.5, 0.5, 0.5);
    var_4 = var_1 - var_3;
    var_5 = [];
    var_5["_encstr_B42E085325A82CB3F221"] = anglesToForward(var_0.angles);
    var_5["_encstr_8253060E2B5FE330"] = anglestoright(var_0.angles);
    var_5["_encstr_8D5B09262CD8B5EEB02719"] = var_5["_encstr_B42E085325A82CB3F221"] * -1;
    var_5["_encstr_A5AD056A019C63"] = var_5["_encstr_8253060E2B5FE330"] * -1;
    var_6 = undefined;
    var_7 = -999999;
    var_8 = ["_encstr_B42E085325A82CB3F221", "_encstr_8253060E2B5FE330", "_encstr_8D5B09262CD8B5EEB02719", "_encstr_A5AD056A019C63"];

    foreach(var_10 in var_8) {
      var_11 = var_5[var_10];
      var_12 = scripts\engine\math::scalar_projection(var_11, var_4);

      if(!isDefined(var_6) || var_12 > var_7) {
        var_6 = var_10;
        var_7 = var_12;
      }
    }

    return var_2[var_6];
  } else
    return scripts\engine\utility::random(var_2);
}

#using_animtree("_encstr_B40101");

vehicle_playdeathanimation(var_0) {
  self vehicle_turnengineoff();
  scripts\engine\utility::self_func("_encstr_9266113317039421F5B9E9504ECB535EC3B9CA", self.origin, self.angles, 0, 0);
  self useanimtree(#animtree);
  self animScripted("_encstr_8D4E1BE3B77B04889DABBEBF2921D191521AABD19010285B6023F7BF9B", self.origin, self.angles, var_0);
  self setneargoalnotifydist(30);

  if(scripts\common\vehicle::ishelicopter()) {
    self setvehgoalpos(self.origin, 1);
    self setgoalyaw(self.angles[1]);
  }
}

vehicle_setcrashing(var_0) {
  self.vehiclecrashing = var_0;
}

vehicle_docrash(var_0, var_1) {
  if(istrue(self.vehicle_skipdeathcrash)) {
    return;
  }
  vehicle_setcrashing(1);

  if(self vehicle_isphysveh()) {
    self vehphys_crash();

    if(!istrue(self.dontdisconnectpaths))
      self disconnectPaths();

    while(!vehicle_iscorpse() && isDefined(self) && !vehicle_is_stopped())
      waitframe();
  } else if(ishelicopter_internal()) {
    thread vehicle_helicoptercrash(var_0, var_1);
    self waittill("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  }

  vehicle_setcrashing(0);
}

vehicle_helicoptercrash(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0))
    self.original_attacker = var_0;

  if(!isDefined(self)) {
    return;
  }
  detach_getoutrigs();
  thread helicopter_crash_move(var_0, var_1);
}

helicopter_crash_move(var_0, var_1) {
  self endon("_encstr_AFE311D273FA2CD2E4D7CAC30763BD375AED9B");

  if(isDefined(self.perferred_crash_location))
    var_2 = self.perferred_crash_location;
  else {
    var_3 = get_unused_crash_locations();
    var_2 = scripts\engine\utility::getclosest(self.origin, var_3);
  }

  var_2.claimed = 1;
  self notify("_encstr_87DE08E656DDC158E81A");
  self notify("_encstr_A29D0A462B161D1A3707B4E6");
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_2.script_parameters) && var_2.script_parameters == "_encstr_BE450734FB03DF9EA9")
    var_5 = 1;

  if(isDefined(self.heli_crash_indirect_zoff)) {
    var_5 = 0;
    var_4 = self.heli_crash_indirect_zoff;
  }

  if(var_5) {
    var_6 = 40;
    self vehicle_setspeed(var_6, 15, 10);
    self setneargoalnotifydist(var_2.radius);
    self setvehgoalpos(var_2.origin, 0);
    thread helicopter_crash_flavor(var_2.origin, var_6);
    scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536");
    helicopter_crash_path(var_2);
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isDefined(self.heli_crash_lead)) {
      var_7 = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    var_6 = 20;

    if(isDefined(self.crash_speed))
      var_6 = self.crash_speed;

    self vehicle_setspeed(var_6, 10, 10);
    self setneargoalnotifydist(350);
    self setvehgoalpos(var_7, 1);
    thread helicopter_crash_flavor(var_7, 40);
    var_8 = "_encstr_AFAB063620A0C612";

    while(var_8 != "_encstr_AD75063D571AE108") {
      var_8 = scripts\engine\utility::_id_143A6("_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_AD75063D571AE108");

      if(!isDefined(var_8) && !isDefined(self)) {
        var_2.claimed = undefined;
        self notify("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
        return;
      } else
        var_8 = "_encstr_AD75063D571AE108";
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("_encstr_8B7205D9ED5958");
    helicopter_crash_path(var_2);
  }

  var_2.claimed = undefined;
  self notify("_encstr_A96616DC3AF60EAF8D4E2C6E1AFAB1F6F60EBECDDBEAE623");
  self notify("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
}

helicopter_crash_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = 56;

    if(isDefined(var_0.radius))
      var_1 = var_0.radius;

    self setneargoalnotifydist(var_1);
    self setvehgoalpos(var_0.origin, 0);
    scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536");
  }
}

helicopter_crash_flavor(var_0, var_1) {
  self endon("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  self clearlookatent();

  if(soundexists("_encstr_A1C61B2410485CC11BE393BFD7B0FB84C89B11AF8AD8EE1AF89997AF19"))
    self playLoopSound("_encstr_A1C61B2410485CC11BE393BFD7B0FB84C89B11AF8AD8EE1AF89997AF19");

  var_2 = 0;

  if(isDefined(self.preferred_crash_style)) {
    var_2 = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      var_3 = [1, 2, 2];
      var_4 = 5;
      var_5 = randomint(var_4);
      var_6 = 0;

      foreach(var_9, var_8 in var_3) {
        var_6 = var_6 + var_8;

        if(var_5 < var_6) {
          var_2 = var_9;
          break;
        }
      }
    }
  }

  switch (var_2) {
    case 1:
      thread helicopter_crash_zigzag();
      break;
    case 2:
      thread helicopter_crash_directed(var_0, var_1);
      break;
    case 3:
      thread helicopter_in_air_explosion();
      break;
    case 4:
      thread helicopter_pilot_death_explosion();
      break;
    case 0:
    default:
      thread helicopter_crash_rotate();
      break;
  }
}

helicopter_in_air_explosion() {
  var_0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.vehicle_rocket_death_fx[var_0])) {
    var_1 = level.vehicle.templates.vehicle_rocket_death_fx[var_0];
    var_2 = var_1[1];

    if(isDefined(var_2.waitdelay))
      wait(var_2.waitdelay);

    waitframe();
  }

  self notify("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  self notify("_encstr_AFE311D273FA2CD2E4D7CAC30763BD375AED9B");
}

helicopter_pilot_death_explosion() {
  thread helicopter_crash_rotate();
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8B7205D9ED5958", 3);
  self notify("_encstr_A1600C8D2C668880FBD9A9F0F29F");
  thread helicopter_in_air_explosion();
}

helicopter_unloading_watcher() {
  if(!scripts\common\vehicle::ishelicopter()) {
    return;
  }
  self endon("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  self waittill("_encstr_A9210A283BEC90BB323450EC");
  self.unloading = 1;
  self waittill("_encstr_BD82096B5DA4B07F924F29");
  self.unloading = 0;
}

helicopter_crash_directed(var_0, var_1) {
  self endon("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_3 = var_0 - self.origin;
    var_4 = vectortoyaw(var_3);
    var_4 = var_4 + var_2;
    self settargetyaw(var_4);
    wait 0.1;
  }
}

helicopter_crash_zigzag() {
  self endon("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0)
      self settargetyaw(self.angles[1] + var_1);
    else
      self settargetyaw(self.angles[1] - var_1);

    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
  }
}

helicopter_crash_rotate() {
  self endon("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

get_unused_crash_locations() {
  var_0 = [];
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_removeundefined(level.vehicle.helicopter_crash_locations);

  foreach(var_2 in level.vehicle.helicopter_crash_locations) {
    if(isDefined(var_2.claimed)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

vehicle_iscorpse() {
  return isDefined(self) && get_vehicle_classname() == "_encstr_8EA916DF5BAA7817FBD1D3B98AA74688878F076FD292E0D5";
}

detach_getoutrigs() {
  if(!isDefined(self.fastroperig)) {
    return;
  }
  if(!self.fastroperig.size) {
    return;
  }
  var_0 = getarraykeys(self.fastroperig);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(self.fastroperig[var_0[var_1]]))
      self.fastroperig[var_0[var_1]] unlink();
  }
}

vehicle_setdeathmodel() {
  if(!isDefined(level.vehicle.templates.deathmodel[self.model])) {
    return;
  }
  if(istrue(self.vehicle_skipdeathmodel)) {
    return;
  }
  self setModel(level.vehicle.templates.deathmodel[self.model]);
}