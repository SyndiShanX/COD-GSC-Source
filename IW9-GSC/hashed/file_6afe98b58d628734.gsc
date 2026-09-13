/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6afe98b58d628734.gsc
***********************************************/

register_objectives() {
  scripts\engine\utility::flag_init("players_escaped");
  scripts\engine\utility::flag_init("ready_to_escape");
  scripts\engine\utility::flag_init("pause_c4_throwing");
  scripts\engine\utility::flag_init("leaving_final_samsite");
  scripts\engine\utility::flag_init("sites_destroyed");
  scripts\engine\utility::flag_init("intro_completed");
  scripts\engine\utility::flag_init("start_samsites");
  scripts\cp\cp_objectives::registerobjective("gauntlet_intro", ::default_init, ::_id_8D2D45C4857B246D, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_post_intro", ::default_init, ::_id_ACFE63574AE85A7F, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_samsites", ::default_init, ::_id_1C7EF425532B44E0, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_exfil", ::default_init, ::_id_331FED9D82F679CB, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_enterplane", ::default_init, ::_id_C53489887948B551, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_start_testexfil", ::default_init, ::_id_FCF4F8C158CF7F27, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_start_testapache", ::default_init, ::_id_FC8A8B832307D1C1, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);
  scripts\cp\cp_objectives::registerobjective("gauntlet_start_testc4heli", ::default_init, ::_id_729CAE4DC24CF7D9, ::_id_7A75150EDB163514, ::_id_A732A4F1B84650EB);

  if(!_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C()) {
    _id_7B8639F512D4CFE4::main();

    if(!isDefined(level._id_358AB8DF65CBB5B4))
      level._id_358AB8DF65CBB5B4 = 0;

    level.pre_map_restart_func = ::_id_B39EF66A3F692D97;
    level._id_082E220E37DEE38E = 1;

    if(!isDefined(level.vehicle._id_AAB9695C92B0ED96))
      level.vehicle._id_AAB9695C92B0ED96 = [];

    level thread _id_93036BEB20375B2E();
    level thread _id_3AE4C2F4B199AC47();
  }
}

_id_3AE4C2F4B199AC47() {
  level endon("game_ended");
  wait 5;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedataforvehicle("iw9_la_gromeo_mp", 10, "little_bird");
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setvehiclehitdamagedataforweapon("little_bird", 1, "iw9_la_gromeo_mp");
  _id_962A30A9BB8C0F09 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldata();
  _id_962A30A9BB8C0F09.table.skipburndownforvehicle["little_bird"]["iw9_la_gromeo_mp"] = 1;
}

_id_93036BEB20375B2E() {
  level endon("game_ended");
  trigger = getEnt("oob_kill", "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", ent);
    thread _id_2F42240A14051195(ent);
  }
}

_id_2F42240A14051195(ent) {
  if(!isPlayer(ent) && !isDefined(ent.owner)) {
    return;
  }
  if(isPlayer(ent)) {
    ent.oob = 1;
    ent.shouldskiplaststand = 1;
    ent dodamage(ent.health + 100, ent.origin);
  } else if(isDefined(ent.owner) && isPlayer(ent.owner)) {
    _id_962A30A9BB8C0F09 = scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_getleveldata();
    callback = _id_962A30A9BB8C0F09.outoftimecallbacks[ent.vehiclename];
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(_id_F85572CD5F6117C6 in occupants)
    _id_F85572CD5F6117C6.shouldskiplaststand = 1;

    ent[[callback]]();
  }
}

_id_B39EF66A3F692D97(result) {
  if(!isDefined(result) || result != "SUCCESS") {
    thread _id_5CB53B521945F4F1();
    return;
  }

  foreach(player in level.players)
  player thread intermission();

  wait 10;
  thread _id_5CB53B521945F4F1();
}

intermission(_id_1379934A423852EF) {
  self endon("disconnect");
  thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 2);
  camera = scripts\engine\utility::getStruct("end_cam_pos", "targetname");
  _id_116171939929AF39::setforcespawninfo(camera.origin, camera.angles);
  _id_E87CC8634B3E137F = self.forcespawnangles;
  _id_116171939929AF39::spawnplayer();
  self.anchor = spawn("script_model", self.origin);
  self.anchor setModel("tag_origin");
  self.anchor.angles = _id_E87CC8634B3E137F;
  self cameralinkTo(self.anchor, "tag_origin");
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 8000, 6, 1.8);
  self.anchor moveTo(self.anchor.origin + anglesToForward(self.anchor.angles) * 8000, 10);
}

_id_808702446B6BFFB3() {
  while(!isDefined(level.players) || level.players.size == 0)
    wait 0.1;

  waitframe();
  scripts\cp\cp_objectives::run_objective("gauntlet_intro");
}

_id_4E26236569C2AE4A() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("pause_trigger_spawn");
  y = 8378;
  _id_7EA61A73C7EE5FEC::_id_AF5F2033A9413E22(y);
  level.default_player_spawns = "gl_spawners";
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  spawners = scripts\engine\utility::getStructArray("gl_spawners", "targetname");

  foreach(index, player in level.players) {
    player setOrigin(spawners[index].origin);
    player setplayerangles((0, spawners[index].origin[1], 0));
  }

  _id_D6F97F42CBA0EF26 = scripts\engine\utility::getStruct("gl_truck", "targetname");

  while(!isDefined(level.cargo_truck))
    waitframe();

  level.cargo_truck vehicle_teleport(_id_D6F97F42CBA0EF26.origin, _id_D6F97F42CBA0EF26.angles);
  scripts\engine\utility::flag_wait("start_samsites");
  scripts\engine\utility::flag_clear("pause_trigger_spawn");
  scripts\cp\cp_objectives::run_objective("gauntlet_samsites");
}

_id_77845A860B8AC76D() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("pause_trigger_spawn");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_AB9251FEE3580AED = scripts\engine\utility::getStruct("intro_flyby_truck", "targetname");
  spawners = scripts\engine\utility::getStructArray("intro_flyby_playerspawn", "targetname");
  _id_5D61F034B126CBCA = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", _id_AB9251FEE3580AED);

  foreach(index, player in level.players) {
    player setOrigin(spawners[index].origin, 1);
    player setplayerangles(spawners[index].angles);
  }

  wait 10;
  _id_DFE49DA36E7CE757();
}

_id_28DDC63BC1259ED1() {
  scripts\cp\cp_objectives::run_objective("gauntlet_start_testexfil");
}

_id_FBCF2C9080275089() {
  scripts\cp\cp_objectives::run_objective("gauntlet_start_testapache");
}

_id_9C72EF06652E87C4() {
  scripts\cp\cp_objectives::run_objective("gauntlet_start_testc4heli");
}

default_init(objectivestruct) {}

_id_7A75150EDB163514(objectivestruct) {}

_id_A732A4F1B84650EB(objectivestruct) {}

_id_ACFE63574AE85A7F(objectivestruct) {
  level endon("game_ended");
  scripts\engine\utility::flag_set("intro_completed");

  if(isDefined(level._id_C6C53E4D14F28245))
    level._id_C6C53E4D14F28245 scripts\engine\utility::trigger_off();

  wait 2;
  objective_setshowoncompass(objectivestruct.objectiveindex, 1);
  objective_setfadedisabled(objectivestruct.objectiveindex, 1);
  objective_icon(objectivestruct.objectiveindex, "icon_waypoint_objective_general");
  objective_setshowdistance(objectivestruct.objectiveindex, 1);
  objective_setplayintro(objectivestruct.objectiveindex, 1);
  level thread _id_45F1B569B3225251(objectivestruct.objectiveindex);
  level thread _id_7EA61A73C7EE5FEC::_id_9C14E3A04CD5B468();
  level thread _id_4E1BDE9ACD5BAF9C();
  level thread _id_24ADC931F2A1EB2E();
  scripts\engine\utility::flag_wait("start_samsites");
}

_id_4E1BDE9ACD5BAF9C() {
  level endon("game_ended");
  wait 2;
  _id_4B51EFC61B1C7ECF::_id_775CD164C569E279("dx_cp_cpes_ntro_lasw_goodeffectbreakeralp");
  wait 1.5;
  _id_4B51EFC61B1C7ECF::_id_775CD164C569E279("dx_cp_cpes_ntro_lasw_aqknowyoureherenowth");
  wait 2;
  _id_4B51EFC61B1C7ECF::_id_775CD164C569E279("dx_cp_cpes_ntro_lasw_beadvisedyankee7isin");
}

_id_45F1B569B3225251(objectiveindex) {
  level endon("game_ended");
  waypoint = scripts\engine\utility::getStruct("introObjective", "targetname");
  _id_E5CFB04119570EF4 = spawn("script_origin", waypoint.origin);
  objective_position(objectiveindex, waypoint.origin);
  _id_89413BAD44FCF50C = 0;
  wait 1;
  dist = 4000;

  for(;;) {
    wait 0.1;

    if(isDefined(waypoint.radius))
      dist = waypoint.radius;

    if(!_id_232A98EB44881ED9(_id_E5CFB04119570EF4, dist)) {
      continue;
    }
    if(!_id_89413BAD44FCF50C) {
      _id_89413BAD44FCF50C = 1;
      thread _id_3A1D8DB6D92D73F8::_id_8AB55654A453F80C();
    }

    if(isDefined(waypoint.script_noteworthy) && waypoint.script_noteworthy == "vo_oilfield")
      thread _id_4B51EFC61B1C7ECF::_id_775CD164C569E279("dx_cp_cpes_cdst_lasw_theoilfieldsarejusta");

    if(!isDefined(waypoint.target)) {
      _id_E5CFB04119570EF4 delete();
      scripts\engine\utility::flag_set("start_samsites");
      return;
    } else {
      waypoint = scripts\engine\utility::getStruct(waypoint.target, "targetname");
      _id_E5CFB04119570EF4.origin = waypoint.origin;
      objective_position(objectiveindex, waypoint.origin);
    }
  }
}

_id_232A98EB44881ED9(waypoint, dist) {
  _id_F7F9975C75F63C8B = 0;

  foreach(player in level.players) {
    if(distance(waypoint.origin, player.origin) < dist)
      return 1;
  }

  return 0;
}

_id_1C7EF425532B44E0(objectivestruct) {
  scripts\engine\utility::flag_set("intro_completed");
  level thread _id_52C503585B2D030A();

  if(!istrue(level._id_E2525C955D208FE5)) {
    scripts\cp\cp_checkpoint::checkpoint_set("gauntlet_intro_complete");
    thread scripts\cp\utility::objective_update("gauntlet_samsites", undefined, undefined, undefined, undefined, 3 - level._id_358AB8DF65CBB5B4);
  }

  level._id_932FE0B96E1A3BD6 = undefined;

  if(!istrue(level._id_E2525C955D208FE5)) {
    level._id_E7FFC1A29959BEC7 = 1;
    wait 2;
    thread _id_5A36FEFFB9852A53(1);

    while(istrue(level._id_E7FFC1A29959BEC7))
      wait 1;
  }

  if(!isDefined(level._id_E2EF6E27C8806484) || !scripts\engine\utility::array_contains(level._id_E2EF6E27C8806484, "b"))
    level thread _id_DE26C48A77206D22();

  level thread _id_7EA61A73C7EE5FEC::_id_CAEE85EBFEAB8BD1();

  if(isDefined(level._id_C6C53E4D14F28245))
    level._id_C6C53E4D14F28245 scripts\engine\utility::trigger_on();

  level thread _id_F1D6CF6BB0C1F376();
  level thread _id_F18FC9BA02A8CF88();

  if(!istrue(level._id_E2525C955D208FE5)) {
    locations = scripts\engine\utility::getStructArray("sam_site", "targetname");

    foreach(_id_AC0E594AC96AA3A8, location in locations) {
      _id_C327ADFAD89EFC23 = _id_2C17AA19D1E937B2::_id_9933B3B407347038(location);
      _id_C327ADFAD89EFC23 thread _id_52B931348EF23E0B(_id_AC0E594AC96AA3A8);
      location._id_C327ADFAD89EFC23 = _id_C327ADFAD89EFC23;
    }
  }

  scripts\engine\utility::flag_wait("sites_destroyed");
}

_id_52C503585B2D030A() {
  if(isDefined(level._id_495A85B8678D3C6A)) {
    foreach(mine in level._id_495A85B8678D3C6A) {
      if(!isDefined(mine)) {
        continue;
      }
      mine delete();
      waitframe();
    }
  }

  if(isDefined(level._id_F7F6CF2225966394)) {
    foreach(_id_C327ADFAD89EFC23 in level._id_F7F6CF2225966394) {
      _id_C327ADFAD89EFC23._id_2E1259FB590696E9 delete();
      _id_C327ADFAD89EFC23 delete();
    }
  }

  if(isDefined(level._id_E959C6E734621D0F))
    level._id_E959C6E734621D0F delete();
}

_id_52B931348EF23E0B(_id_0BE9720EAAAA043E) {
  level endon("game_ended");
  objectiveindex = scripts\cp\cp_objectives::requestworldid("samsite" + _id_0BE9720EAAAA043E, 1);
  org = self.origin + (0, 0, 120);
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_MISSION_ESC/SITES");
  objective_position(objectiveindex, org);
  objective_setshowoncompass(objectiveindex, 1);
  _id_D91F12B76628F311 = "a";

  if(distance(self.origin, (-13466.3, -23942.7, 1385.8)) < 3000) {
    objective_icon(objectiveindex, "icon_waypoint_dom_b");
    level._id_CF3FE0AA65A4C526 = self;
  } else if(distance(self.origin, (-27760.6, -41904.6, 841.8)) < 3000) {
    objective_icon(objectiveindex, "icon_waypoint_dom_c");
    level._id_CF3FDFAA65A4C2F3 = self;
    _id_D91F12B76628F311 = "b";
    thread scripts\cp\coop_stealth::_id_C72B7181608C8607((-28265.5, -43324, 2215.96));
  } else {
    objective_icon(objectiveindex, "icon_waypoint_dom_d");
    level._id_CF3FDEAA65A4C0C0 = self;
    _id_D91F12B76628F311 = "c";
  }

  self._id_D91F12B76628F311 = _id_D91F12B76628F311;
  objective_state(objectiveindex, "current");
  thread _id_1096D82549EFDCD7();
  thread _id_CF7B8CDEC337EF3A();
  thread _id_4B51EFC61B1C7ECF::_id_2315572ABC059BA1();
  self waittill("samsite_dead");

  switch (self._id_D91F12B76628F311) {
    case "a":
      thread _id_9196F0BCEF9A9917();
      break;
    case "b":
      thread _id_47BA9AEB1294B3A6();
      break;
    case "c":
      thread _id_4CEF429797B49AAD();
      break;
  }

  level._id_358AB8DF65CBB5B4++;

  if(!isDefined(game["samsites_completed"]))
    game["samsites_completed"] = [];

  game["samsites_completed"][game["samsites_completed"].size] = _id_D91F12B76628F311;
  level notify("samsiteDestroyed", _id_D91F12B76628F311);

  if(level._id_358AB8DF65CBB5B4 >= 3) {
    if(!istrue(level._id_8C876D36B2B7C949)) {
      scripts\cp\cp_checkpoint::checkpoint_set("gauntlet_sam3destroyed");
      game["startAtSamSite"] = _id_D91F12B76628F311;
    }

    scripts\engine\utility::flag_set("sites_destroyed");
    scripts\engine\utility::flag_set("ready_to_escape");
  }

  objective_delete(objectiveindex);
  thread scripts\cp\utility::objective_update("gauntlet_samsites", undefined, undefined, undefined, undefined, 3 - level._id_358AB8DF65CBB5B4);

  if(!istrue(level._id_8C876D36B2B7C949))
    wait 5;

  if(level._id_358AB8DF65CBB5B4 == 1) {
    if(!istrue(level._id_8C876D36B2B7C949)) {
      scripts\cp\cp_checkpoint::checkpoint_set("gauntlet_sam1destroyed");
      game["startAtSamSite"] = _id_D91F12B76628F311;
      wait 5;
      _id_7EA61A73C7EE5FEC::spawn_reinforcement_truck();
      wait 5;
      _id_7EA61A73C7EE5FEC::spawn_reinforcement_truck();
    }

    _id_4A11A6476D7B00B0(org);
  } else if(level._id_358AB8DF65CBB5B4 == 2) {
    if(!istrue(level._id_8C876D36B2B7C949)) {
      scripts\cp\cp_checkpoint::checkpoint_set("gauntlet_sam2destroyed");
      game["startAtSamSite"] = _id_D91F12B76628F311;
    }

    _id_9199A809FA26CF65(org);
  } else
    _id_6005F45F589CA8BE(org);
}

_id_4A11A6476D7B00B0(org) {
  thread _id_7EA61A73C7EE5FEC::_id_3688C7D73F659480();
  spawntime = gettime() + 120000;
  _id_C66CC15D361E6B45 = squared(2500);

  if(isDefined(org)) {
    while(scripts\cp\utility::are_all_players_nearby(org, _id_C66CC15D361E6B45) && gettime() < spawntime)
      wait 0.1;
  } else
    wait 15;

  wait 2;

  if(!isDefined(level._id_826A2E131D92A45A)) {
    _id_3A1D8DB6D92D73F8::_id_A48BAD21C6C1E0A9();

    if(isDefined(level._id_664E187FD885C2D5)) {
      wait 5;
      level._id_664E187FD885C2D5 thread _id_3A1D8DB6D92D73F8::_id_0F86BBD1CC392004();
    }
  }
}

_id_9199A809FA26CF65(org) {
  thread _id_7EA61A73C7EE5FEC::_id_3688C7D73F659480();
  spawntime = gettime() + 120000;
  _id_C66CC15D361E6B45 = squared(2500);

  if(isDefined(org)) {
    while(scripts\cp\utility::are_all_players_nearby(org, _id_C66CC15D361E6B45) && gettime() < spawntime)
      wait 0.2;
  } else
    wait 15;

  wait 2;
  level notify("spawn_apache");

  if(isDefined(level._id_826A2E131D92A45A)) {
    wait 5;
    level._id_826A2E131D92A45A thread _id_3A1D8DB6D92D73F8::_id_0F86BBD1CC392004();
  }
}

_id_6005F45F589CA8BE(org) {
  thread _id_7EA61A73C7EE5FEC::_id_3688C7D73F659480();
  _id_C66CC15D361E6B45 = squared(2500);

  if(isDefined(org)) {
    while(scripts\cp\utility::any_player_nearby(org, _id_C66CC15D361E6B45))
      wait 0.1;
  } else
    wait 5;

  scripts\engine\utility::flag_set("leaving_final_samsite");
  trigger = getEnt("end_of_script", "targetname");
  trigger scripts\cp\cp_spawning_util::trigger_wait();
  _id_DBF6BC12134508B0 = scripts\engine\utility::getStructArray("final_truck", "targetname");

  foreach(spawner in _id_DBF6BC12134508B0) {
    vehicle = level scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
    wait 0.5;
  }

  wait 1;
}

_id_CF7B8CDEC337EF3A() {
  self endon("death");
  _id_1313DF0E598A68EC = 0;

  for(;;) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < squared(2000)) {
        self notify("shoot");
        wait 6;
        return;
      }

      wait 0.05;
    }

    wait 0.25;
  }
}

_id_331FED9D82F679CB(objectivestruct) {
  scripts\engine\utility::delaythread(15, _id_3A1D8DB6D92D73F8::_id_6C8E45C9F0D2ED69);
  thread _id_8615A6B7CD263577();
  scripts\engine\utility::flag_set("intro_completed");
  wait 3;
  trigger = getEnt("end_of_script", "targetname");
  _id_1BAB304729B19724 = scripts\engine\utility::getStruct("esc_waypoint_1", "script_noteworthy");
  objindex = objectivestruct.objectiveindex;
  objective_position(objindex, scripts\engine\utility::drop_to_ground(_id_1BAB304729B19724.origin, 5) + (0, 0, 40));
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objindex, "icon_regular");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_setlabel(objindex, &"CP_MISSION_ESC/OBJ_EXFIL");
  objective_state(objindex, "active");

  while(!scripts\cp\utility::any_player_nearby(_id_1BAB304729B19724.origin, squared(8000)))
    wait 0.05;

  thread _id_9D9B1CE2DFFD3E50();
  wait 10;
}

_id_C53489887948B551(objectivestruct) {
  scripts\engine\utility::flag_set("intro_completed");
  level thread _id_9F4817230A6F9A5C();
  objindex = objectivestruct.objectiveindex;
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_setlabel(objindex, &"CP_MISSION_ESC/OBJ_EXFIL");
  objective_state(objindex, "active");
  objective_onentity(objindex, level.c130);
  scripts\engine\utility::flag_wait("players_escaped");
}

_id_24ADC931F2A1EB2E() {
  trigger = getEnt("spawn_plains_lb", "script_noteworthy");
  trigger waittill("trigger");
  level._id_113DEA3BB5A11805 = 1;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_864197DF48AC9F87 = squared(13000);

  foreach(enemy in enemies) {
    if(distance2dsquared(enemy.origin, (3290.9, 20560.4, 4627.3)) < _id_864197DF48AC9F87) {
      if(isDefined(enemy) && isalive(enemy)) {
        enemy suicide();
        waitframe();
      }
    }
  }
}

_id_FCF4F8C158CF7F27(objectivestruct) {
  level.default_player_spawns = "exfil_spawners";
  level._id_43AD6A0654D9E695 = 1;
  spawners = scripts\engine\utility::getStructArray("exfil_spawners", "targetname");
  _id_AB9251FEE3580AED = scripts\engine\utility::getStruct("exfil_truck", "targetname");
  _id_AB9251FEE3580AED.origin = _id_AB9251FEE3580AED.origin + (0, 0, 100);
  _id_AAD5328DFA9FE86D = scripts\engine\utility::getStruct("exfil_truck_2", "targetname");

  while(!isDefined(level.cargo_truck))
    waitframe();

  wait 1;
  truck = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", _id_AB9251FEE3580AED);

  foreach(index, player in level.players) {
    player setOrigin(spawners[index].origin, 1);
    player setplayerangles(spawners[index].angles);
  }

  wait 5;
  truck vehicle_settopspeedforward(30);
  truck vehicle_settopspeedreverse(35);
  visionsetnaked("cp_mission_esc", 0.1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level thread _id_4B51EFC61B1C7ECF::_id_99330A19E0ACAA05();
  level thread _id_4B51EFC61B1C7ECF::_id_2E0C9F3B6E655703();
  level thread _id_4B51EFC61B1C7ECF::_id_F902F98E99291610();
  thread scripts\cp\cp_objectives::run_objective("gauntlet_exfil");
  wait 4;
  scripts\engine\utility::flag_set("start_samsites");
  scripts\engine\utility::flag_set("intro_completed");
  scripts\engine\utility::flag_set("ready_to_escape");
  level notify("stop_sending_reinforcements");
  level thread _id_F1D6CF6BB0C1F376();
  level thread _id_F18FC9BA02A8CF88();
  groundpos = getgroundposition(_id_AAD5328DFA9FE86D.origin, 8);
  _id_AAD5328DFA9FE86D.origin = groundpos;
  level thread _id_748251E7735AC6FC();
  _id_DBF6BC12134508B0 = scripts\engine\utility::getStructArray("final_truck", "targetname");

  foreach(spawner in _id_DBF6BC12134508B0) {
    vehicle = level scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
    wait 0.5;
  }
}

_id_FC8A8B832307D1C1(objectivestruct) {
  level.default_player_spawns = "exfil_spawners";
  scripts\engine\utility::flag_set("pause_trigger_spawn");
  level._id_43AD6A0654D9E695 = 1;
  spawners = scripts\engine\utility::getStructArray("exfil_spawners", "targetname");
  _id_AB9251FEE3580AED = scripts\engine\utility::getStruct("exfil_truck", "targetname");
  _id_AAD5328DFA9FE86D = scripts\engine\utility::getStruct("exfil_truck_2", "targetname");

  while(!isDefined(level.cargo_truck))
    waitframe();

  level.cargo_truck vehicle_teleport(_id_AB9251FEE3580AED.origin, _id_AB9251FEE3580AED.angles);
  _id_5D61F034B126CBCA = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", _id_AAD5328DFA9FE86D);
  _id_5D61F034B126CBCA.maxhealth = int(_id_5D61F034B126CBCA.health * 2);
  _id_5D61F034B126CBCA.health = _id_5D61F034B126CBCA.maxhealth;
  _id_5D61F034B126CBCA._id_CF1E271394C5DC95 = 2500;
  _id_5D61F034B126CBCA vehicle_settopspeedforward(30);
  _id_5D61F034B126CBCA vehicle_settopspeedforward(20);

  foreach(index, player in level.players) {
    player setOrigin(spawners[index].origin, 1);
    player setplayerangles(spawners[index].angles);
  }

  wait 5;
  visionsetnaked("cp_mission_esc", 0.1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread scripts\cp\cp_objectives::run_objective("obj_escape");
  wait 4;
  scripts\engine\utility::flag_set("start_samsites");
  level notify("stop_sending_reinforcements");
  level.cargo_truck vehicle_settopspeedforward(30);
  level.cargo_truck vehicle_settopspeedreverse(25);
  wait 5;

  if(getdvarint("dvar_BA494CC6B2B7E8E3", 0) > 0)
    level thread _id_7EA61A73C7EE5FEC::_id_82A14034C7D61307();

  for(;;) {
    _id_B85D8D5A0284FFB7 = _id_3A1D8DB6D92D73F8::_id_9C5F65BACCB9CCEC();

    if(!isDefined(_id_B85D8D5A0284FFB7)) {
      wait 1;
      continue;
    }

    while(!_id_B85D8D5A0284FFB7 isnearanyplayer(4000))
      wait 1;

    while(isDefined(_id_B85D8D5A0284FFB7) && !isDefined(_id_B85D8D5A0284FFB7._id_07436690EA0E728C)) {
      wait 0.5;

      if(getdvarint("dvar_AE2013600EC8B741", 0) < 1) {
        continue;
      }
      if(isDefined(_id_B85D8D5A0284FFB7))
        magicbullet("iw9_la_rpapa7_mp", _id_B85D8D5A0284FFB7.origin + (0, 0, -150), _id_B85D8D5A0284FFB7.origin, level.players[0]);

      wait 0.25;

      if(isDefined(_id_B85D8D5A0284FFB7))
        magicbullet("iw9_la_rpapa7_mp", _id_B85D8D5A0284FFB7.origin + (0, 0, -150), _id_B85D8D5A0284FFB7.origin, level.players[0]);

      wait 0.25;

      if(isDefined(_id_B85D8D5A0284FFB7))
        magicbullet("iw9_la_rpapa7_mp", _id_B85D8D5A0284FFB7.origin + (0, 0, -150), _id_B85D8D5A0284FFB7.origin, level.players[0]);
    }
  }

  wait 5;
}

_id_729CAE4DC24CF7D9(objectivestruct) {
  level.default_player_spawns = "exfil_spawners";
  scripts\engine\utility::flag_set("pause_trigger_spawn");
  level._id_43AD6A0654D9E695 = 1;
  spawners = scripts\engine\utility::getStructArray("exfil_spawners", "targetname");
  _id_AB9251FEE3580AED = scripts\engine\utility::getStruct("exfil_truck", "targetname");
  _id_AAD5328DFA9FE86D = scripts\engine\utility::getStruct("exfil_truck_2", "targetname");

  while(!isDefined(level.cargo_truck))
    waitframe();

  level.cargo_truck vehicle_teleport(_id_AB9251FEE3580AED.origin, _id_AB9251FEE3580AED.angles);
  _id_5D61F034B126CBCA = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", _id_AAD5328DFA9FE86D);
  _id_5D61F034B126CBCA.maxhealth = int(_id_5D61F034B126CBCA.health * 2);
  _id_5D61F034B126CBCA.health = _id_5D61F034B126CBCA.maxhealth;
  _id_5D61F034B126CBCA._id_CF1E271394C5DC95 = 2500;

  foreach(index, player in level.players) {
    player setOrigin(spawners[index].origin, 1);
    player setplayerangles(spawners[index].angles);
  }

  wait 5;
  visionsetnaked("cp_mission_esc", 0.1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level notify("stop_sending_reinforcements");
  _id_5D61F034B126CBCA vehicle_settopspeedforward(30);
  _id_5D61F034B126CBCA vehicle_settopspeedreverse(35);
  level.cargo_truck vehicle_settopspeedforward(30);
  level.cargo_truck vehicle_settopspeedreverse(35);

  for(;;) {
    heli = _id_3A1D8DB6D92D73F8::_id_A48BAD21C6C1E0A9();

    while(isDefined(heli))
      wait 1;

    wait 5;
  }
}

_id_8D2D45C4857B246D(objectivestruct) {
  level.default_player_spawns = "start_spawners";
  level thread _id_4B51EFC61B1C7ECF::_id_107CEEC27ED3A473();
  level._id_65A7FA3A254912E8 = 1;
  thread scripts\cp\utility::_id_61A3391D3AB5FAF7(::_id_FAE360C523A8890F, "weapon_fired");
  level thread _id_2049DE4343A9AC5A();
  trigger = getEnt("outofbounds_farms", "targetname");
  level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
  level thread scripts\cp\cp_outofbounds::watchoobtrigger(trigger);
  level._id_C6C53E4D14F28245 = trigger;
  _id_03A246920C9288C4::trophy_init();
  _id_77777288354109F8 = scripts\engine\utility::getStructArray("fake_trophy", "targetname");

  foreach(_id_776083776F6F0302 in _id_77777288354109F8)
  thread _id_03A246920C9288C4::_id_233602CC27D9FCF8(_id_776083776F6F0302, 1, 10, 200);

  level thread _id_0695F71BF4D39EA1();
  visionsetnaked("cp_mission_esc", 0.1);

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_set("player_spawned_with_loadout");

  scripts\engine\utility::flag_wait("intro_binks_complete");
  thread _id_1FBE81044AE1DFC8();
  level thread _id_7EA61A73C7EE5FEC::_id_CB5B7569FB75C56D();
  _id_678ADBED602DA5EB::_id_BCE89A6DE8A052AF();
  _id_74B74D356F108418();
  location = scripts\engine\utility::getStruct("intro_sam_site", "targetname");
  _id_C327ADFAD89EFC23 = _id_2C17AA19D1E937B2::_id_9933B3B407347038(location);
  objindex = scripts\cp\cp_objectives::requestworldid("intro", 1);
  objective_setminimapiconsize(objindex, "icon_regular");
  objective_setlabel(objindex, &"CP_MISSION_ESC/SITES");
  objective_position(objindex, _id_C327ADFAD89EFC23.origin + (0, 0, 80));
  objective_setshowoncompass(objindex, 1);
  objective_icon(objindex, "icon_waypoint_dom_a");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_state(objindex, "current");
  level thread _id_4B51EFC61B1C7ECF::intro_dialogue();
  level._id_065B39A7501C708E = _id_C327ADFAD89EFC23;
  level thread _id_38ABBF3666A60EF8();
  level thread _id_74BB2DEA339E2BA6();
  _id_C327ADFAD89EFC23 waittill("samsite_dead", player);
  thread _id_AADC5D152E372ED2();
  scripts\engine\utility::flag_set("intro_completed");
  level.stealth.bstayincombatoncealerted = 1;
  _func_AA9FA9C5A97D0F6E(1);
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(agent in enemies) {
    foreach(player in level.players) {
      agent aieventlistenerevent("combat", player, player.origin);
      agent getenemyinfo(player);
    }

    agent._id_50BA41F491586FBF = 67108864;
    agent _meth_9215CE6FC83759B9(8000);
    agent.pacifist = 0;
    agent.demeanoroverride = "combat";
    agent.goalradius = 2048;
    agent.script_radius = 2048;
  }

  trig = getEnt("intro_samsiteverify", "targetname");
  trig delete();
  trig = getEnt("kill_grenadelauncher", "targetname");
  trig delete();
  level._id_65A7FA3A254912E8 = undefined;
  level.battlechatterenabled = 1;
  objective_delete(objindex);
  level thread _id_FB023148D794EB27();
  setnojipscore(1, 1);
  setnojiptime(1, 1);
}

_id_74BB2DEA339E2BA6() {
  _id_DF15177AD74CF9AE = scripts\engine\utility::getStructArray("husk_spawner", "targetname");

  foreach(struct in _id_DF15177AD74CF9AE)
  scripts\cp_mp\vehicles\vehicle::_id_0FFFE750FCE66784(struct.script_noteworthy, struct, 1);
}

_id_0720E21A557B8574() {
  level endon("stealth_broken");
  trig = getEnt("kill_grenadelauncher", "targetname");
  trig endon("death");

  for(;;) {
    trig waittill("trigger", ent);

    if(isPlayer(ent)) {
      break;
    }
  }

  level._id_04E2EE4EC70DF280 = 1;
}

_id_FAE360C523A8890F() {
  thread _id_ABB5450F7E4777B9();
}

_id_ABB5450F7E4777B9() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    _id_DE88CD14114C1E24 = self getcurrentweapon();

    if(_id_DE88CD14114C1E24 issilenced()) {
      continue;
    }
    waitframe();
    level notify("weapon_fired");
    level._id_B6E2EDDB8435E6E0 = 1;
    break;
  }
}

_id_38ABBF3666A60EF8() {
  _id_04E4F703E8EA149C["spotted"]["explosion"] = 18000;
  _id_04E4F703E8EA149C["hidden"]["explosion"] = 18000;
  _id_04E4F703E8EA149C["spotted"]["gunshot"] = 18000;
  _id_04E4F703E8EA149C["hidden"]["gunshot"] = 18000;
  _id_04E4F703E8EA149C["hidden"]["silenced_shot"] = 2000;
  _id_04E4F703E8EA149C["spotted"]["silenced_shot"] = 9000;
  _id_04E4F703E8EA149C["hidden"]["gunshot_teammate"] = 10000;
  _id_04E4F703E8EA149C["spotted"]["gunshot_teammate"] = 10000;
  _id_04E4F703E8EA149C["spotted"]["death"] = 1250;
  _id_04E4F703E8EA149C["hidden"]["death"] = 1024;
  _id_04E4F703E8EA149C["hidden"]["glass_destroyed"] = 2500;
  _id_04E4F703E8EA149C["spotted"]["glass_destroyed"] = 2500;
  scripts\stealth\manager::set_custom_distances(_id_04E4F703E8EA149C);
}

_id_0695F71BF4D39EA1() {
  wait 5;
  spawner = scripts\engine\utility::getStruct("checkpoint_cargo_truck", "targetname");
  _id_BE66F9030B258BED = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawner);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(_id_BE66F9030B258BED);
  _id_BE66F9030B258BED.maxhealth = int(_id_BE66F9030B258BED.health * 2);
  _id_BE66F9030B258BED.health = _id_BE66F9030B258BED.maxhealth;
  _id_A1CCAF999BFFC776 = "TAG_SEAT_0";
  _id_BE66F9030B258BED.driver = spawn("script_model", _id_BE66F9030B258BED gettagorigin(_id_A1CCAF999BFFC776));
  _id_BE66F9030B258BED.driver setModel("body_civ_london_male_10_1");
  _id_BE66F9030B258BED.driver.head = spawn("script_model", _id_BE66F9030B258BED.driver gettagorigin("j_spine4"));
  _id_BE66F9030B258BED.driver.head setModel("head_sc_m_sharipov_mp_bg");
  _id_BE66F9030B258BED.driver.head linkTo(_id_BE66F9030B258BED.driver, "j_spine4", (0, 0, 0), (0, 0, 0));
  _id_BE66F9030B258BED.driver linkTo(_id_BE66F9030B258BED, _id_A1CCAF999BFFC776, (0, 0, 0), (0, 0, 0));
  _id_BE66F9030B258BED.driver scriptmodelplayanimdeltamotion("iw9_veh_suv_1996_seat_0_idle");
  _id_BE66F9030B258BED.driver notsolid();
  _id_BE66F9030B258BED thread _id_55713F55DF11B713();
  _id_BE66F9030B258BED thread scripts\engine\utility::delete_on_death(_id_BE66F9030B258BED.driver);
  _id_BE66F9030B258BED thread scripts\engine\utility::delete_on_death(_id_BE66F9030B258BED.driver.head);
  wait 0.3;
  _id_BE66F9030B258BED _meth_65AA053C077C003A(1);
  _id_BE66F9030B258BED setscriptablepartstate("lights", "on");
  wait 2;
  _id_BE66F9030B258BED vehicle_turnengineon();
  _id_BE66F9030B258BED _meth_D2E41C7603BA7697("p2p");
  _id_BE66F9030B258BED _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  _id_BE66F9030B258BED _meth_77320E794D35465A("p2p", "goalThreshold", 96);
  scripts\engine\utility::flag_wait("intro_binks_complete");
  _id_A9C45240836FE2A5 = scripts\engine\utility::getStruct("introskit_vehpath", "targetname");
  _id_2C8C204E0A499EBC = scripts\engine\utility::getStruct(_id_A9C45240836FE2A5.target, "targetname");
  _id_BE66F9030B258BED _meth_77320E794D35465A("p2p", "goalPoint", _id_2C8C204E0A499EBC.origin);
  key = _func_906E53C2FB9D3F9C("p2p", "targetTime");
  _id_BE66F9030B258BED _meth_77320E794D35465A(key, 11);
  wait 2;
  wait 9;
  _id_2C8C204E0A499EBC = scripts\engine\utility::getStruct(_id_2C8C204E0A499EBC.target, "targetname");
  _id_BE66F9030B258BED _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);
  _id_BE66F9030B258BED _id_0F3B4A4783EDE654::_id_26E9E22860C819CE(_id_BE66F9030B258BED.origin, _id_2C8C204E0A499EBC.origin, 200, _id_2C8C204E0A499EBC.origin);
  _id_BE66F9030B258BED waittill("path_finished");
  waittime = gettime() + 13000;

  while(!istrue(level._id_203C1D3D4FFB5FB1) && gettime() < waittime)
    wait 0.1;

  level notify("return_to_station");

  if(!istrue(level._id_203C1D3D4FFB5FB1))
    wait 5;

  _id_BE66F9030B258BED thread _id_EA8FC2E934A07F72();
}

_id_55713F55DF11B713() {
  level endon("return_to_station");

  for(;;) {
    self waittill("damage", amount, attacker, inflictor);

    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    break;
  }

  wait 2;
  level._id_B6E2EDDB8435E6E0 = 1;
}

_id_EA8FC2E934A07F72() {
  self endon("death");
  _id_CBD3F7020EC784E3 = scripts\engine\utility::getStruct("intro_truck_leave", "targetname");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  _id_A469FAAD80127B62 = scripts\engine\utility::getStruct(_id_CBD3F7020EC784E3.target, "targetname");
  self _meth_77320E794D35465A("p2p", "manualSpeed", 350);

  for(;;) {
    self _meth_77320E794D35465A("p2p", "goalPoint", _id_A469FAAD80127B62.origin);
    self _meth_77320E794D35465A("p2p", "manualSpeed", 350);

    while(isDefined(self) && isDefined(_id_A469FAAD80127B62) && distancesquared(self.origin, _id_A469FAAD80127B62.origin) > squared(200))
      waitframe();

    if(!isDefined(_id_A469FAAD80127B62.target)) {
      break;
    }

    _id_A469FAAD80127B62 = scripts\engine\utility::getStruct(_id_A469FAAD80127B62.target, "targetname");
  }

  if(isDefined(self))
    self delete();
}

_id_74B74D356F108418() {
  _id_B5DEFF62BA0378CA = scripts\engine\utility::getStruct("intro_mklauncher", "targetname");
  level._id_E959C6E734621D0F = _id_678ADBED602DA5EB::_id_9273BA79878B2221(_id_B5DEFF62BA0378CA, "weapon_wm_mg_mobile_turret");
  level._id_E959C6E734621D0F._id_5D186451F21D7020 = 640000;
  level._id_E959C6E734621D0F.maxrange = 46240000;
}

_id_2049DE4343A9AC5A() {
  level endon("intro_completed");

  for(;;) {
    if(istrue(level._id_B6E2EDDB8435E6E0)) {
      break;
    } else {
      if(_func_EAC0CD99C9C6D8EE() != "spotted") {
        waitframe();
        continue;
      }

      if(scripts\cp\coop_stealth::_id_1FCFEC6AECF17A41()) {
        thread _id_3D9D87F90D2F2201();
        break;
      } else
        waitframe();
    }
  }

  level notify("alertall");
  level._id_203C1D3D4FFB5FB1 = 1;
  level.stealth.bstayincombatoncealerted = 1;
  _func_AA9FA9C5A97D0F6E(1);
  level._id_704409D0747082DA = 0;
  wait 3;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(agent in enemies) {
    if(isDefined(agent._id_7B54E23EAA271E6B)) {
      agent _meth_73DEC7A4D991183E();
      agent _meth_EA63241A4D3092C4();
      agent._blackboard.idlenode = undefined;
      _func_2A627FA5FD1CE263(agent._id_7B54E23EAA271E6B);
      agent._id_7B54E23EAA271E6B = undefined;
    }

    foreach(player in level.players) {
      agent aieventlistenerevent("combat", player, player.origin);
      agent getenemyinfo(player);
    }

    agent._id_50BA41F491586FBF = 67108864;
    agent _meth_9215CE6FC83759B9(8000);
    agent.pacifist = 0;
    agent clearbtgoal(0);
    agent clearbtgoal(1);
    agent clearbtgoal(2);
    agent scripts\common\utility::demeanor_override("combat");
    agent.goalradius = 2500;
    node = agent _meth_518291FFA7F0C94C(3000);

    if(isDefined(node)) {
      agent setgoalnode(node);
      continue;
    }

    agent setgoalpos(agent.origin);
  }

  thread scripts\cp\coop_stealth::_id_C72B7181608C8607((25650.6, 22736.5, 6686.88), 1);
  wait 1.5;

  foreach(player in level.players)
  scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_C8122B0900BA529D");

  level notify("stealth_broken");
  level.battlechatterenabled = 1;
  level._id_65A7FA3A254912E8 = undefined;

  if(!istrue(level._id_04E2EE4EC70DF280)) {
    _id_1D19A8CDD2C4B6EF = scripts\engine\utility::getStructArray("turretguy", "targetname");
    scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_1D19A8CDD2C4B6EF, 1);
  }

  wait 2;
  _id_4B51EFC61B1C7ECF::_id_775CD164C569E279("dx_cp_cpes_ntro_lasw_somuchforstealth");
  wait 1.5;
  _id_4B51EFC61B1C7ECF::_id_775CD164C569E279("dx_cp_cpes_ntro_lasw_youreclearedhotfireo");
}

#using_animtree("mp_vehicles_always_loaded");

_id_9D9B1CE2DFFD3E50() {
  spawner = scripts\engine\utility::getStruct("escape_plane_spawn", "targetname");
  _id_4BC6A72EECCBDE80 = scripts\engine\utility::getStruct("escape_plane_land", "targetname");
  clips = getEntArray("plane_clip_new", "targetname");
  trigger = getEnt("escape_plane_trig", "targetname");
  trigger enablelinkTo();
  _id_2E1259FB590696E9 = getEnt("plane_dmg_trigger", "targetname");
  _id_2E1259FB590696E9 enablelinkTo();
  level.c130 = spawnVehicle("veh9_mil_air_cargo_plane_cp", "cargo_plane", "veh9_cargo_plane_cp", spawner.origin, spawner.angles);
  level.c130 vehicle_teleport(spawner.origin, spawner.angles);
  level.c130 notsolid();

  foreach(clip in clips)
  clip linkTo(level.c130);

  trigger linkTo(level.c130);
  _id_2E1259FB590696E9 linkTo(level.c130);
  _id_2E1259FB590696E9 thread _id_104FA495AABF12D4();
  level notify("exfil_plane_spawned");
  level.c130 setscriptablepartstate("lights", "on");
  level.c130 setscriptablepartstate("lights2", "on");
  level.c130 _id_75A661841BEB405C::_id_EAA62570A3C904BE();
  _id_C458EDAC96D58B16 = scripts\engine\utility::getStruct("landing_anim_struct", "targetname");
  _id_C458EDAC96D58B16.origin = _id_C458EDAC96D58B16.origin + (0, 0, 5);
  level.c130 vehicle_turnengineoff();
  level.c130 vehicle_teleport(_id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles);
  level.c130 animScripted("blah", _id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles, %cp_esc_gunship_landing);
  scriptables = getscriptablearray();

  foreach(item in scriptables) {
    if(isDefined(item.classname) && item.classname == "scriptable_vfx_destruction_cp_mission_esc_wirepole")
      item setscriptablepartstate("base", "dead");
  }

  level thread _id_748251E7735AC6FC();
  level.c130 thread _id_2542196AD71E3BC9();
  level.c130 scripts\engine\utility::delaythread(2, ::_id_214092DA7F26D9BB);
  playFXOnTag(level._effect["c130_landing_dust"], level.c130, "tag_origin");
  trigger thread _id_A85C037EA30D606F();
  wait 8;
  scripts\engine\utility::exploder("c130_landdust_amb");
  wait 5;
  level.c130 notify("stop_screenshake");
  scripts\engine\utility::exploder("c130_landdust_idle");
}

_id_104FA495AABF12D4() {
  _id_63BDDA00FC5A6B84 = gettime() + 35000;

  while(gettime() < _id_63BDDA00FC5A6B84) {
    self waittill("trigger", ent);
    level thread _id_C93B7A32FC6419C8(ent);
  }
}

_id_C93B7A32FC6419C8(ent) {
  if(!isPlayer(ent) && !isDefined(ent.owner)) {
    return;
  }
  if(istrue(level._id_0B21BD646994E182)) {
    return;
  }
  if(_id_0AFB7E332AEE4BF2::player_in_laststand(ent)) {
    return;
  }
  if(isPlayer(ent)) {
    ent.shouldskiplaststand = 1;
    ent dodamage(ent.health + 100, ent.origin);
  } else if(isDefined(ent.owner) && isPlayer(ent.owner)) {
    _id_962A30A9BB8C0F09 = scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_getleveldata();
    callback = _id_962A30A9BB8C0F09.outoftimecallbacks[ent.vehiclename];
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(_id_F85572CD5F6117C6 in occupants)
    _id_F85572CD5F6117C6.shouldskiplaststand = 1;

    ent[[callback]]();
  }
}

_id_9F4817230A6F9A5C() {
  level endon("players_escaped");
  wait 240;
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_gexf_niko_fuckimbingofuelihave", "dx_cp_cpes_gexf_niko_damnitfuelstoolow", "dx_cp_cpes_gexf_niko_watcher1icantwaitany", "dx_cp_cpes_gexf_niko_yankee7isbingofuelia"];
  _id_4B51EFC61B1C7ECF::_id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
  wait 1;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_CFC703319D85670F(trig) {
  self endon("death_or_disconnect");

  if(istrue(self._id_47702A442C42A782)) {
    return;
  }
  self._id_47702A442C42A782 = 1;
  self sethudtutorialmessage(&"CP_MISSION_ESC/NEED_PLAYER", 1);

  while(self istouching(trig) && !istrue(level._id_0B21BD646994E182))
    wait 1;

  self clearhudtutorialmessage();
  self._id_47702A442C42A782 = undefined;
}

_id_A85C037EA30D606F() {
  level endon("game_ended");
  wait 30;
  _id_59DB5D0F4E3000A7 = 0;

  for(;;) {
    waitframe();
    _id_59DB5D0F4E3000A7 = _id_50CB5DC95600ADFA();

    if(_id_59DB5D0F4E3000A7 == level.players.size) {
      break;
    } else {
      if(_id_59DB5D0F4E3000A7 == 0) {
        thread _id_B8FEAE74D1522E8E();
        continue;
      }

      if(_id_59DB5D0F4E3000A7 != level.players.size) {
        wait 1;
        _id_59DB5D0F4E3000A7 = _id_50CB5DC95600ADFA();

        if(_id_59DB5D0F4E3000A7 != level.players.size) {
          foreach(player in level.players) {
            if(player istouching(self)) {
              player thread _id_CFC703319D85670F(self);
              player thread _id_61BB562B41AAEC35();
              continue;
            }

            player thread _id_279EE6376E5C48CB();
          }
        } else
          break;
      }
    }
  }

  foreach(player in level.players)
  player.ability_invulnerable = 1;

  scripts\cp\cp_analytics::_id_B6283AC45A607764("gauntlet_enterplane");
  level notify("escaped");
  level._id_0B21BD646994E182 = 1;

  foreach(vehicle in level._id_6E5FF6CAE14C4081)
  vehicle notify("stop_chasing");

  wait 1;
  thread _id_0FB467EB4C40D080();

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 1, 1);
    player disableoffhandweapons();
    player disableusability();
    player allowmovement(0);
    player setclientomnvar("ui_hide_hud", 1);
  }

  thread _id_F26C57F3FD8AD269();
  scripts\engine\utility::delaythread(1, ::_id_0F89E8CAEE93A3AC);
  wait 7;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_50CB5DC95600ADFA() {
  _id_59DB5D0F4E3000A7 = 0;

  foreach(player in level.players) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    if(player istouching(self))
      _id_59DB5D0F4E3000A7++;
  }

  return _id_59DB5D0F4E3000A7;
}

_id_0F89E8CAEE93A3AC() {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(enemy in enemies) {
    enemy.nocorpse = 1;
    enemy suicide();
  }

  foreach(vehicle in level._id_6E5FF6CAE14C4081) {
    if(isDefined(vehicle))
      vehicle delete();
  }
}

_id_61BB562B41AAEC35() {
  if(!isDefined(self._id_A6A6A0EDBC6E329A))
    self._id_A6A6A0EDBC6E329A = gettime();

  if(gettime() < self._id_A6A6A0EDBC6E329A) {
    return;
  }
  self._id_A6A6A0EDBC6E329A = gettime() + randomintrange(30, 45) * 1000;

  if(self == level.players[0]) {
    if(!isDefined(level._id_CDB17A9091E030C0))
      level._id_CDB17A9091E030C0 = scripts\engine\utility::create_deck(["dx_cp_cpes_ltbh_lasw_11wecantleaveanyoneb", "dx_cp_cpes_ltbh_lasw_noonesleftbehind11go", "dx_cp_cpes_ltbh_lasw_youneedtogogetyourte", "dx_cp_cpes_ltbh_lasw_weneedeveryoneonboar", "dx_cp_cpes_ltbh_lasw_youneedtogogetyourte_01"]);

    _id_4B51EFC61B1C7ECF::_id_775CD164C569E279(level._id_CDB17A9091E030C0 scripts\engine\utility::deck_draw(), self);
  } else if(self == level.players[1]) {
    if(!isDefined(level._id_8C64BA8DA46A4253))
      level._id_8C64BA8DA46A4253 = scripts\engine\utility::create_deck(["dx_cp_cpes_ltbh_lasw_12wecantleaveanyoneb", "dx_cp_cpes_ltbh_lasw_noonesleftbehind12go", "dx_cp_cpes_ltbh_lasw_youneedtogogetyourte", "dx_cp_cpes_ltbh_lasw_weneedeveryoneonboar", "dx_cp_cpes_ltbh_lasw_youneedtogogetyourte_01"]);

    _id_4B51EFC61B1C7ECF::_id_775CD164C569E279(level._id_8C64BA8DA46A4253 scripts\engine\utility::deck_draw(), self);
  }
}

_id_279EE6376E5C48CB() {
  if(!isDefined(self._id_33F9497025F46286))
    self._id_33F9497025F46286 = gettime();

  if(gettime() < self._id_33F9497025F46286) {
    return;
  }
  if(self == level.players[0])
    _id_4B51EFC61B1C7ECF::_id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_ltbh_lasw_11gettothelz", "dx_cp_cpes_ltbh_lasw_waitingonyou11letsmo"]), self);
  else if(self == level.players[1])
    _id_4B51EFC61B1C7ECF::_id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_ltbh_lasw_12gettothelz", "dx_cp_cpes_ltbh_lasw_waitingonyou12letsgo"]), self);

  self._id_33F9497025F46286 = gettime() + randomintrange(30, 45) * 1000;
}

_id_B8FEAE74D1522E8E() {
  if(!isDefined(level._id_916E7E89585BFCA3)) {
    _id_6F62E3BF9E640A6C = ["dx_cp_cpes_ltbh_niko_feelingalittlelightb", "dx_cp_cpes_ltbh_niko_ithoughtthereweretwo", "dx_cp_cpes_ltbh_niko_lookslikeweremissing", "dx_cp_cpes_ltbh_lasw_hurry", "dx_cp_cpes_ltbh_lasw_wecantstayinthisvall", "dx_cp_cpes_ltbh_lasw_wererunningoutoftime", "dx_cp_cpes_ltbh_niko_fuelsrunningout", "dx_cp_cpes_ltbh_niko_icantstickaroundmuch", "dx_cp_cpes_ltbh_niko_weneedtogetairborne"];
    level._id_916E7E89585BFCA3 = scripts\engine\utility::create_deck(_id_6F62E3BF9E640A6C);
  }

  if(!isDefined(level._id_33F9497025F46286))
    level._id_33F9497025F46286 = gettime();

  if(gettime() >= level._id_33F9497025F46286) {
    level._id_33F9497025F46286 = gettime() + randomintrange(30, 45) * 1000;
    _id_4B51EFC61B1C7ECF::_id_775CD164C569E279(level._id_916E7E89585BFCA3 scripts\engine\utility::deck_draw());
  }
}

_id_5CB53B521945F4F1() {}

_id_F26C57F3FD8AD269() {
  wait 3;
  camera = scripts\engine\utility::getStruct("end_cam_pos", "targetname");
  exfil_struct = scripts\engine\utility::getStruct("exfil_anim_struct", "targetname");
  c130 = spawnVehicle("veh9_mil_air_cargo_plane_cp", "cargo_plane1", "veh9_cargo_plane_cp", exfil_struct.origin, exfil_struct.angles);
  c130 setscriptablepartstate("lights", "on");
  c130 setscriptablepartstate("lights2", "on");
  _id_C458EDAC96D58B16 = exfil_struct;
  c130 vehicle_teleport(_id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles);
  c130 animScripted("cargoplane1", _id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles, %iw9_cp_esc_gunship_intro);
}

_id_2542196AD71E3BC9() {
  _id_D713F2AF9E5EF4E5 = spawn("script_origin", self.origin);
  _id_B28D16A58E9EA2FE = spawn("script_origin", self.origin);
  _id_5708381B70AFAEF3 = spawn("script_origin", self.origin);
  _id_CC64588F4EA9EA8B = spawn("script_origin", self.origin);
  _id_9C108941FF44A41F = spawn("script_origin", self.origin);
  _id_D713F2AF9E5EF4E5 linkTo(self, "tag_origin", (0, -550, 100), (0, 0, 0));
  _id_B28D16A58E9EA2FE linkTo(self, "tag_origin", (0, 550, 100), (0, 0, 0));
  _id_CC64588F4EA9EA8B linkTo(self, "tag_origin", (-1090, 0, 0), (0, 0, 0));
  _id_9C108941FF44A41F linkTo(self, "tag_origin", (-1400, 0, 0), (0, 0, 0));
  _id_D713F2AF9E5EF4E5 playLoopSound("iw9_gunship_ext_descending_left_wing_lp");
  _id_B28D16A58E9EA2FE playLoopSound("iw9_gunship_ext_descending_right_wing_lp");
  _id_5708381B70AFAEF3 playSound("cp_esc_exfil_c130_flyover");
  wait 10;

  foreach(index, player in level.players)
  player playlocalsound("cp_esc_exfil_c130_flyover_wash_lr");

  wait 2;
  _id_CC64588F4EA9EA8B playSound("iw9_gunship_ext_land_on_dirt");
  wait 3;
  _id_9C108941FF44A41F playLoopSound("iw9_gunship_ext_dirt_cloud_hitting_truck_lp");
  _id_D713F2AF9E5EF4E5 stoploopsound();
  _id_B28D16A58E9EA2FE stoploopsound();
  _id_D713F2AF9E5EF4E5 playLoopSound("iw9_gunship_ext_idle_left_wing_lp");
  _id_B28D16A58E9EA2FE playLoopSound("iw9_gunship_ext_idle_right_wing_lp");
  level waittill("escaped");
  wait 0.2;

  foreach(index, player in level.players) {
    player playlocalsound("cp_esc_exfil_c130_takeoff_lr");
    player setclienttriggeraudiozone("cp_mission_esc_ac130", 4);
  }

  wait 1;

  if(isDefined(level.cargo_truck))
    level.cargo_truck vehicle_turnengineoff();

  _id_9C108941FF44A41F stoploopsound();
  wait 2;
  _id_D713F2AF9E5EF4E5 stoploopsound();
  _id_B28D16A58E9EA2FE stoploopsound();
}

_id_1096D82549EFDCD7() {
  self endon("death");
  self.soundent = spawn("script_origin", self.origin + (0, 0, 100));
  _id_2F6E4314682FDF62 = gettime();

  while(istrue(level._id_E7FFC1A29959BEC7))
    wait 1;

  wait 5;

  for(;;) {
    time = randomintrange(26, 56);
    scripts\engine\utility::waittill_any_timeout_1(time, "shoot");

    if(!isDefined(self._id_692FC766D262881A) && !isDefined(self._id_692FC666D26285E7) && isDefined(self._id_692FC566D26283B4)) {
      if(self isnearanyplayer(3000))
        continue;
    }

    if(!isDefined(self._id_692FC566D26283B4)) {
      continue;
    }
    if(!istrue(level._id_0440A96296312FCD) && !istrue(level._id_E4457DA98181E336)) {
      continue;
    }
    _id_2C17AA19D1E937B2::_id_71CF043AF949590C();
    _id_E0D3AA590B2BA79E();
  }
}

_id_F3780A892E3B8280(org, _id_E085CF82ADC280A3) {
  if(!isDefined(org))
    org = (-28265.5, -43324, 2215.96);

  pos = spawn("script_origin", org);

  if(!istrue(_id_E085CF82ADC280A3)) {
    while(!pos isnearanyplayer(2500))
      wait 0.1;
  }

  pos playLoopSound("weap_samsite_warning");
  wait 11;
  pos stoploopsound();
  pos delete();
}

_id_E0D3AA590B2BA79E(target) {
  self endon("death");
  thread _id_2C17AA19D1E937B2::_id_44E4433EBAC52609();
  level notify("samsite_launch");
}

_id_F18FC9BA02A8CF88() {
  trigger = getEnt("turret_spawn", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent) && (!isDefined(ent.owner) || !isPlayer(ent.owner))) {
      continue;
    }
    break;
  }

  _id_678ADBED602DA5EB::_id_BCE89A6DE8A052AF();
  _id_B5DEFF62BA0378CA = scripts\engine\utility::getStruct("mklauncher", "targetname");
  turret = _id_678ADBED602DA5EB::_id_9273BA79878B2221(_id_B5DEFF62BA0378CA, "weapon_wm_mg_mobile_turret");
  operator = undefined;

  for(;;) {
    _id_B6217B906C6BE73E = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(scripts\engine\utility::getStruct("turret_operator_samc", "targetname"), 1);

    if(_id_B6217B906C6BE73E.size) {
      operator = _id_B6217B906C6BE73E[0];
      break;
    }

    wait 1;
  }

  operator.goalradius = 24;
  operator.ignoreall = 1;
  operator setgoalnode(turret.covernode);
  operator waittill("goal");
  turret._id_2C5E84C1F846661B = operator;
  turret scripts\common\ai::ai_operate_turret(operator, turret);
  operator._id_FE3B2F26B45598BA = _id_678ADBED602DA5EB::_id_BA8597CB7C12D254;
  operator.turret = turret;
  turret thread[[level.turretsettings[turret.turrettype]._id_7E1467DC63368749]]();
  turret thread _id_678ADBED602DA5EB::_id_F3A3BBA54AA3A0A2(operator);
  operator thread _id_4B51EFC61B1C7ECF::_id_CCD7A6907F25864A();
  operator thread _id_678ADBED602DA5EB::_id_200CFD3D04D2510F(turret);
}

_id_FB023148D794EB27() {
  _id_90096803CAEAAECD = scripts\engine\utility::getStructArray("intro_c4_mine_a", "targetname");
  _id_7B9275A42826A296(_id_90096803CAEAAECD);
  trigger = getEnt("cleanup_intro_area", "targetname");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!ent scripts\cp\utility::is_valid_player() && (!isDefined(ent.owner) || !isPlayer(ent.owner))) {
      continue;
    }
    break;
  }

  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_864197DF48AC9F87 = squared(4000);

  foreach(enemy in enemies) {
    if(distance2dsquared(enemy.origin, (25125.7, 23050, 6072)) < _id_864197DF48AC9F87) {
      _id_AC0A60A93BEAEF5B = 0;

      foreach(player in level.players) {
        if(distancesquared(player.origin, enemy.origin) < squared(850))
          _id_AC0A60A93BEAEF5B = 1;
      }

      if(!_id_AC0A60A93BEAEF5B)
        enemy suicide();
    }
  }
}

_id_7B9275A42826A296(_id_90096803CAEAAECD) {
  if(!isDefined(level._id_495A85B8678D3C6A))
    level._id_495A85B8678D3C6A = [];

  foreach(loc in _id_90096803CAEAAECD) {
    mine = spawn("script_model", loc.origin + (0, 0, 100));
    mine setModel("offhand_wm_at_mine_bomb_cp");
    mine.team = "axis";
    trace = scripts\engine\trace::_bullet_trace(mine.origin + (0, 0, 20), mine.origin - (0, 0, 250), 0, mine);
    pos = getgroundposition(trace["position"], 2);
    finalangles = trace["normal"];
    mine.angles = finalangles;
    mine.health = 100000;
    mine setCanDamage(1);
    org = getgroundposition(mine.origin, 4, 150);
    mine.origin = org;
    mine thread _id_945A9AB839F2EEA0();
    mine thread _id_26C2D9123065FEFB();
    level._id_495A85B8678D3C6A[level._id_495A85B8678D3C6A.size] = mine;
    waitframe();
  }
}

_id_F1D6CF6BB0C1F376() {
  trigger = getEnt("minefield_spawn", "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent) || isDefined(ent.owner) && !isPlayer(ent.owner)) {
      continue;
    }
    break;
  }

  if(isDefined(level._id_495A85B8678D3C6A)) {
    foreach(mine in level._id_495A85B8678D3C6A) {
      if(!isDefined(mine)) {
        continue;
      }
      mine delete();
      waitframe();
    }
  }

  _id_90096803CAEAAECD = scripts\engine\utility::getStructArray("c4_mine", "targetname");
  _id_7B9275A42826A296(_id_90096803CAEAAECD);
}

_id_26C2D9123065FEFB() {
  self endon("death");

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, shitloc, partname, idflags, sweapon, origin, angles, normal, einflictor);
    _id_354C862768CFE202::process_damage_feedback(eattacker, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, partname, undefined, self);
    wait 0.25;
    self setscriptablepartstate("explode", "fromDamage");
    self notify("detonate");
    return;
  }
}

_id_945A9AB839F2EEA0() {
  self endon("entitydeleted");
  thread _id_1D2711033DE4EE0B();
  self setscriptablepartstate("arm", "active");
  self setscriptablepartstate("visibility", "show");
  self waittill("detonate");
  wait 0.1;
  self setscriptablepartstate("arm", "neutral");
  wait 3;
  self delete();
}

_id_1D2711033DE4EE0B() {
  self endon("entitydeleted");
  _id_F5A2985226F286F0 = 0;
  _id_2237BDCCAB8A4D35 = 0;

  for(;;) {
    foreach(player in level.players) {
      if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
        if(distance2d(self.origin, player.vehicle.origin) < 200)
          _id_F5A2985226F286F0 = 1;

        continue;
      }

      if(distance2d(self.origin, player.origin) < 80)
        _id_2237BDCCAB8A4D35 = 1;
    }

    if(_id_2237BDCCAB8A4D35 || _id_F5A2985226F286F0) {
      break;
    }

    waitframe();
  }

  self setscriptablepartstate("trigger", "active");
  self setscriptablepartstate("launch", "land");
  self movez(50, 0.5);
  wait 0.5;

  if(_id_2237BDCCAB8A4D35) {
    level notify("at_mine_exploded_near_player");
    self setscriptablepartstate("explode", "fromPlayer");
  } else
    self setscriptablepartstate("explode", "fromDamage");

  self notify("detonate");
}

_id_5A36FEFFB9852A53(_id_8C4747268ABC29AB) {
  _id_DFE49DA36E7CE757();
  level._id_E7FFC1A29959BEC7 = 0;
  wait 15;
  level notify("stop_intro");
}

_id_DFE49DA36E7CE757() {
  level thread _id_4B51EFC61B1C7ECF::_id_23F764E736E39B94();
  wait 3;
  level notify("show_chyrons");
  wait 3;
  level._id_6F8BCD4A2212597D = spawnVehicle("veh9_mil_air_cargo_plane_cp", "cargo_plane", "veh9_cargo_plane_cp", (3296, 20561, 4500), (360, 240, 0));
  level._id_6F8BCD4A2212597D setscriptablepartstate("lights", "on");
  level._id_6F8BCD4A2212597D setscriptablepartstate("lights2", "on");
  _id_C458EDAC96D58B16 = scripts\engine\utility::getStruct("gl_truck", "targetname");
  missile = spawn("script_model", _id_C458EDAC96D58B16.origin);
  missile.angles = _id_C458EDAC96D58B16.angles;
  missile setModel("tag_origin");
  level._id_6F8BCD4A2212597D vehicle_teleport(_id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles);
  level._id_6F8BCD4A2212597D animScripted("cargoplane", _id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles, %iw9_cp_esc_gunship_intro);
  missile scriptmodelplayanimdeltamotionfrompos("iw9_cp_esc_missile_intro", _id_C458EDAC96D58B16.origin, _id_C458EDAC96D58B16.angles);
  level._id_6F8BCD4A2212597D thread _id_214092DA7F26D9BB();
  level._id_6F8BCD4A2212597D thread _id_380FE94BD649A4F6();
  wait 1;
  missile setModel("military_missile_rig_skeleton");
  missile setscriptablepartstate("military_samsite_missile", "on");
  missile thread _id_ED33706654249FA5();
  level._id_6F8BCD4A2212597D thread _id_899396D67085A64E(missile);
  playFXOnTag(scripts\engine\utility::getfx("vfx_c130_flyby_dust"), level._id_6F8BCD4A2212597D, "tag_origin");
  wait 9;
  level._id_6F8BCD4A2212597D notify("flares");
  _id_2E0A8EAB6CF805E3 = getanimlength(%iw9_cp_esc_gunship_intro);
  wait(_id_2E0A8EAB6CF805E3 - 11);
  level._id_6F8BCD4A2212597D._id_98AC01A65B073642 delete();
  level._id_6F8BCD4A2212597D delete();
  level._id_EDC36D7017B13BBD = 1;
}

_id_899396D67085A64E(missile) {
  self waittill("flares");
  playsoundatpos(self.origin, "cp_esc_intro_flares");
  playFXOnTag(scripts\engine\utility::getfx("vfx_c130_flyby_angel_flares"), self, "tag_origin");
  missile notify("explode");
}

_id_ED33706654249FA5() {
  self waittill("explode");
  playsoundatpos(self.origin, "cp_esc_intro_sam_launch");
  wait 1.5;
  playsoundatpos(self.origin, "cp_esc_intro_missile_expl");
  playFX(level._effect["vfx_cp_sam_missile_explo"], self.origin);
  wait 0.1;
  self delete();
}

_id_214092DA7F26D9BB() {
  self endon("death");
  self endon("stop_screenshake");
  self._id_98AC01A65B073642 = spawn("script_origin", self.origin);
  self._id_98AC01A65B073642 linkTo(self);
  wait 2;

  for(;;) {
    earthquake(0.2, 3, self._id_98AC01A65B073642.origin, 7500);
    wait 0.1;
  }
}

_id_380FE94BD649A4F6() {
  _id_B59621010D84A7C8 = spawn("script_origin", self.origin);
  _id_B59621010D84A7C8 linkTo(self);
  _id_D713F2AF9E5EF4E5 = spawn("script_origin", self.origin);
  _id_B28D16A58E9EA2FE = spawn("script_origin", self.origin);
  _id_CC64588F4EA9EA8B = spawn("script_origin", self.origin);
  _id_9C108941FF44A41F = spawn("script_origin", self.origin);
  _id_D713F2AF9E5EF4E5 linkTo(self, "tag_origin", (0, -550, 100), (0, 0, 0));
  _id_B28D16A58E9EA2FE linkTo(self, "tag_origin", (0, 550, 100), (0, 0, 0));
  truck = level.cargo_truck;
  _id_B5469F3F9A9FB22E = undefined;

  if(!isDefined(truck))
    truck = _id_3A1D8DB6D92D73F8::_id_AEAB160D1452A77E();

  if(isDefined(truck)) {
    _id_B5469F3F9A9FB22E = spawn("script_origin", truck.origin);
    _id_B5469F3F9A9FB22E linkTo(truck);
  }

  _id_D713F2AF9E5EF4E5 playLoopSound("iw9_gunship_ext_descending_left_wing_lp");
  _id_B28D16A58E9EA2FE playLoopSound("iw9_gunship_ext_descending_right_wing_lp");
  wait 2;
  _id_B59621010D84A7C8 playSound("cp_esc_intro_c130_flyover");

  if(isDefined(_id_B5469F3F9A9FB22E))
    _id_B5469F3F9A9FB22E playSound("cp_esc_intro_c130_flyover_truck_dirt");

  foreach(index, player in level.players)
  player playlocalsound("cp_esc_intro_c130_flyover_wash_lr");

  wait 15;
  _id_B59621010D84A7C8 delete();
  _id_D713F2AF9E5EF4E5 delete();
  _id_B28D16A58E9EA2FE delete();

  if(isDefined(_id_B5469F3F9A9FB22E))
    _id_B5469F3F9A9FB22E delete();
}

_id_DE26C48A77206D22() {
  level endon("stop_samsite_b_goalradius");
  _id_22706B6DB1DF9F6A = getEnt("samsite_b_radius", "targetname");

  for(;;) {
    _id_22706B6DB1DF9F6A waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    break;
  }

  triggers = getEntArray("samsite_b_gate_triggers", "script_noteworthy");

  foreach(trigger in triggers)
  trigger delete();

  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(enemy in enemies) {
    if(distance2dsquared(enemy.origin, _id_22706B6DB1DF9F6A.origin) < squared(3000)) {
      enemy.goalradius = 2048;
      enemy.script_origin_other = undefined;
      enemy.spawnpoint.script_origin_other = undefined;

      foreach(player in level.players)
      enemy getenemyinfo(player);
    }
  }
}

_id_22CDC9BDD0A96C1E(location) {
  if(!isDefined(self.origin))
    return "intro";

  if(distance(self.origin, (25392, 23464, 6552)) < 3000)
    return "intro";

  if(distance(self.origin, (-13466.3, -23942.7, 1385.8)) < 3000)
    return "a";
  else if(distance(self.origin, (-27760.6, -41904.6, 841.8)) < 3000)
    return "b";

  return "c";
}

_id_E5E5AEF86B891977(location) {
  switch (location) {
    case "intro":
      return (25392, 23464, 6552);
    case "a":
      return (-13466.3, -23942.7, 1385.8);
    case "b":
      return (-27760.6, -41904.6, 841.8);
    case "c":
      return (-32320.6, -12952.6, 617.8);
  }
}

_id_748251E7735AC6FC() {
  trig = getEnt("exfil_final_trig", "targetname");
  _id_730AE106EAD85E60 = scripts\engine\utility::getStructArray("final_truck_unload", "targetname");

  for(;;) {
    trig waittill("trigger", ent);

    if(isPlayer(ent)) {
      break;
    } else if(isDefined(ent.owner) && isPlayer(ent.owner)) {
      break;
    }

    continue;
  }

  if(isDefined(level.exfil_heli))
    level.exfil_heli notify("flyaway");

  level._id_835E60CE3246564F = 1;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  vehicles = [];

  foreach(enemy in enemies) {
    if(isDefined(enemy.vehicle) && isDefined(enemy.vehicle.riders) && enemy.vehicle.riders[0] == enemy)
      vehicles = scripts\engine\utility::_id_6D6AF8144A5131F1(vehicles, enemy.vehicle);
  }

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle) && isalive(vehicle))
      vehicle thread _id_899F25499446AF83(_id_730AE106EAD85E60);
  }
}

_id_899F25499446AF83(_id_730AE106EAD85E60) {
  self endon("death");
  _id_09B8C5CD15FEFEF8 = undefined;

  foreach(struct in _id_730AE106EAD85E60) {
    if(!isDefined(struct.taken) && !isDefined(_id_09B8C5CD15FEFEF8)) {
      struct.taken = 1;
      _id_09B8C5CD15FEFEF8 = struct;
      break;
    }
  }

  if(!isDefined(_id_09B8C5CD15FEFEF8)) {
    return;
  }
  self notify("stop_chasing");
  self _meth_77320E794D35465A("p2p", "goalPoint", self.origin);
  wait 0.1;
  _id_0F3B4A4783EDE654::_id_26E9E22860C819CE(self.origin, _id_09B8C5CD15FEFEF8.origin, 2500);
  scripts\engine\utility::waittill_any_timeout_1(10, "path_finished");
  self notify("path_updated");
  thread _id_24E4405CF93F20ED::_id_FB7E5919765650EA();
  return;
}

_id_1FBE81044AE1DFC8() {
  wait 5;
  setmusicstate("mx_cp_mission_esc_intro_stealth");
}

_id_3D9D87F90D2F2201() {
  wait 4.75;
  setmusicstate("mx_cp_mission_esc_intro_combat");
}

_id_8615A6B7CD263577() {
  wait 18;
  setmusicstate("mx_cp_mission_esc_exfil");
}

_id_0FB467EB4C40D080() {
  wait 6.5;
  _func_A3901A965FC1D7DD("mx_cp_mission_esc_exfil");
}

_id_AADC5D152E372ED2() {
  setmusicstate("mx_cp_mission_esc_intro_chargeplanted");
}

_id_9196F0BCEF9A9917() {
  _func_A3901A965FC1D7DD("mx_cp_mission_esc_sambcombat");
}

_id_47BA9AEB1294B3A6() {
  _func_A3901A965FC1D7DD("mx_cp_mission_esc_samccombat");
}

_id_4CEF429797B49AAD() {
  _func_A3901A965FC1D7DD("mx_cp_mission_esc_samdcombat");
}