/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters.gsc
*****************************************************/

init() {
  setdvarifuninitialized("dvar_66A4F62FEFC77EFD", 0);

  if(!getdvarint("dvar_66A4F62FEFC77EFD", 0)) {
    return;
  }
  setdvarifuninitialized("dvar_AB50F58BB9979459", 30);
  _id_29F57A3BC4E1EC72 = spawnStruct();
  _id_29F57A3BC4E1EC72 init_encounters();
  _id_29F57A3BC4E1EC72 init_locations();
  _id_29F57A3BC4E1EC72 thread encounter_manager();
  level.disableinitplayergameobjects = 0;
}

add_encounter_start_condition(func, params) {
  add_condition("encounter", func, params);
}

add_location_start_condition(func, params) {
  add_condition("location", func, params);
}

add_condition(category, func, params) {
  if(!isDefined(self.startconditions[category]))
    self.startconditions[category] = [];

  _id_46260B6EEE9C6E62 = spawnStruct();
  _id_46260B6EEE9C6E62.func = func;
  _id_46260B6EEE9C6E62.params = params;
  count = self.startconditions[category].size;
  self.startconditions[category][count] = _id_46260B6EEE9C6E62;
}

add_encounter_start_function(func) {
  self.func_encounterstart = func;
}

init_encounters() {
  self.encounters = [];
  self.allencounters = [];
  root = init_encounter("root");
  root add_encounter_start_condition(::condition_prematchdone);
  root add_encounter_start_condition(::condition_mintimepassed, 60);
  root add_encounter_start_condition(::condition_maxaliveplayers, 70);
  root add_encounter_start_condition(::condition_maxactivelocations, 1);
  root add_encounter_start_condition(::condition_lastencounterstarttime, 30);
  root add_location_start_condition(::condition_stateis, 0);
  root add_location_start_condition(::condition_insafecircle);
  root add_encounter_start_condition(::condition_circlecount, 2);
  root add_encounter_start_condition(::condition_circlesremaining, 2);
  root add_location_start_condition(::condition_anyplayerinsideradius, 7500);
  root add_encounter_start_function(::root_ecounterstart);
  _id_7086D6FF5C8406C0 = init_encounter("root_ai", root);
  _id_7086D6FF5C8406C0 add_encounter_start_function(::rootai_ecounterstart);
  _id_00F5D9414137E12B = init_encounter("bank", _id_7086D6FF5C8406C0);
  _id_00F5D9414137E12B add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  _id_00F5D9414137E12B add_encounter_start_function(::bank_ecounterstart);
  _id_1C81FF5ADF650554 = init_encounter("airport", _id_7086D6FF5C8406C0);
  _id_1C81FF5ADF650554 add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  _id_1C81FF5ADF650554 add_encounter_start_function(::airport_ecounterstart);
  truck = init_encounter("truck", _id_7086D6FF5C8406C0);
  truck add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  truck add_encounter_start_function(::truck_encounterstart);
  _id_DCA92D2C4496032A = init_encounter("crate_guard", _id_7086D6FF5C8406C0);
  _id_DCA92D2C4496032A add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  _id_DCA92D2C4496032A add_encounter_start_function(::crateguard_encounterstart);
  _id_E21279FA90BDF012 = init_encounter("jugg", _id_7086D6FF5C8406C0);
  _id_E21279FA90BDF012 add_location_start_condition(::condition_allplayersoutsideradius, 1000);
  _id_E21279FA90BDF012 add_encounter_start_condition(::condition_disabled);
  test = init_encounter("test", _id_7086D6FF5C8406C0);
  test add_encounter_start_condition(::condition_disabled);
  test add_encounter_start_function(::test_ecounterstart);
  _id_B06C34EA735D9CC4 = init_encounter("root_non_ai", root);
  _id_B06C34EA735D9CC4 add_location_start_condition(::condition_allplayersoutsideradius, 2000);
  _id_B06C34EA735D9CC4 add_encounter_start_function(::rootnonai_ecounterstart);
  dom = init_encounter("dom", _id_B06C34EA735D9CC4);
  dom add_encounter_start_function(::dom_encounterstart);
  _id_1B3A8AF37328E37B = init_encounter("bomb_plant", _id_B06C34EA735D9CC4);
  _id_1B3A8AF37328E37B add_encounter_start_function(::bombplant_encounterstart);
  _id_DA33446112EF3644 = init_encounter("extraction", _id_B06C34EA735D9CC4);
  _id_DA33446112EF3644 add_encounter_start_function(::extraction_encounterstart);
  _id_DA33446112EF3644 add_encounter_start_condition(::condition_disabled);
  _id_69962146390B00BF = init_encounter("destruction", _id_B06C34EA735D9CC4);
  _id_69962146390B00BF add_encounter_start_function(::destruction_encounterstart);
}

init_encounter(name, parent) {
  encounter = spawnStruct();
  encounter.name = name;
  encounter.info = self;
  encounter.parentencounter = parent;
  encounter.encounters = [];
  encounter.startconditions = [];
  encounter.locations = [];
  self.allencounters[name] = encounter;

  if(isDefined(parent))
    parent.encounters[parent.encounters.size] = encounter;
  else
    self.encounters[self.encounters.size] = encounter;

  return encounter;
}

init_locations() {
  self.alllocations = [];
  self.activelocations = [];
  locations = scripts\engine\utility::getStructArray("ai_encounters", "targetname");

  foreach(location in locations)
  init_location(location);
}

init_location(location) {
  location.name = location.script_noteworthy;
  encounter = self.allencounters[location.name];
  encounter.locations[encounter.locations.size] = location;
  location.encounter = encounter;
  location.state = 0;
  _id_703CFCF7F6D5D0A1 = self.alllocations.size;
  self.alllocations[_id_703CFCF7F6D5D0A1] = location;
}

encounter_manager() {
  for(;;) {
    self.validlocations = [];
    update_conditions(self.encounters);

    if(self.validlocations.size) {
      location = scripts\engine\utility::random(self.validlocations);
      encounter_start(location);
    }

    wait 0.05;
  }
}

update_conditions(encounters) {
  foreach(encounter in encounters) {
    if(!encounter check_encounter_start_conditions()) {
      continue;
    }
    update_conditions(encounter.encounters);

    foreach(location in encounter.locations) {
      if(!location check_location_start_conditions()) {
        continue;
      }
      self.validlocations[self.validlocations.size] = location;
    }
  }
}

check_encounter_start_conditions() {
  return check_start_conditions(self, "encounter", 0);
}

check_location_start_conditions() {
  return check_start_conditions(self.encounter, "location", 1);
}

check_start_conditions(encounter, _id_6CE38F522A4B3D32, _id_DD61FF0F315B80ED) {
  if(_id_DD61FF0F315B80ED && isDefined(encounter.parentencounter)) {
    if(!check_start_conditions(encounter.parentencounter, _id_6CE38F522A4B3D32, _id_DD61FF0F315B80ED))
      return 0;
  }

  if(!isDefined(encounter.startconditions[_id_6CE38F522A4B3D32]))
    return 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < encounter.startconditions[_id_6CE38F522A4B3D32].size; _id_AC0E594AC96AA3A8++) {
    _id_46260B6EEE9C6E62 = encounter.startconditions[_id_6CE38F522A4B3D32][_id_AC0E594AC96AA3A8];

    if(isDefined(_id_46260B6EEE9C6E62.params))
      result = self[[_id_46260B6EEE9C6E62.func]](_id_46260B6EEE9C6E62.params);
    else
      result = self[[_id_46260B6EEE9C6E62.func]]();

    if(!result)
      return 0;
  }

  return 1;
}

encounter_start(location) {
  location.state = 1;
  self.activelocations[self.activelocations.size] = location;
  location.starttime = gettime();
  encounter_location_start_functions(location);
}

encounter_location_start_functions(location) {
  location encounter_start_functions(location.encounter);
}

encounter_start_functions(encounter) {
  if(isDefined(encounter.parentencounter))
    encounter_start_functions(encounter.parentencounter);

  if(isDefined(encounter.func_encounterstart))
    self[[encounter.func_encounterstart]]();
}

encounter_end(success, _id_FE593BA7D0935BB5) {
  if(success)
    self.state = 2;
  else
    self.state = 3;

  self.endtime = gettime();
  self.duration = self.endtime - self.starttime;
  info = self.encounter.info;
  info.activelocations = scripts\engine\utility::array_remove(info.activelocations, self);
  info.lastencounter = self;

  if(self.usesai) {
    foreach(agent in self.agents) {
      if(isalive(agent))
        agent suicide();
    }
  }

  self notify("encounter_end", success, _id_FE593BA7D0935BB5);
}

condition_disabled(encounter) {
  return 0;
}

condition_stateis(state) {
  if(self.state != state)
    return 0;

  return 1;
}

condition_anyplayerinsideradius(radius) {
  _id_F85C8A0556EDF077 = radius * radius;
  _id_D0A837FCF948CC7E = sortbydistance(level.players, self.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D0A837FCF948CC7E.size; _id_AC0E594AC96AA3A8++) {
    player = _id_D0A837FCF948CC7E[_id_AC0E594AC96AA3A8];

    if(!isalive(player)) {
      continue;
    }
    _id_F95436827E16D133 = distance2dsquared(player.origin, self.origin);

    if(_id_F95436827E16D133 < _id_F85C8A0556EDF077)
      return 1;
    else
      break;
  }

  return 0;
}

condition_allplayersoutsideradius(radius) {
  _id_F85C8A0556EDF077 = radius * radius;
  _id_D0A837FCF948CC7E = sortbydistance(level.players, self.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D0A837FCF948CC7E.size; _id_AC0E594AC96AA3A8++) {
    player = _id_D0A837FCF948CC7E[_id_AC0E594AC96AA3A8];

    if(!isalive(player)) {
      continue;
    }
    _id_F95436827E16D133 = distance2dsquared(player.origin, self.origin);

    if(_id_F95436827E16D133 < _id_F85C8A0556EDF077)
      return 0;
    else
      break;
  }

  return 1;
}

condition_insafecircle() {
  if(istrue(level.br_circle_disabled))
    return 1;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent))
    return 0;

  circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
  circleradius = _id_2695A20D4011076D::getsafecircleradius();
  _id_4AAE5F1A6DC74DA0 = distance2dsquared(self.origin, circleorigin);

  if(_id_4AAE5F1A6DC74DA0 > circleradius * circleradius)
    return 0;

  return 1;
}

condition_circlecount(_id_8A7D4AA442793440) {
  if(istrue(level.br_circle_disabled))
    return 1;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent))
    return 0;

  _id_264E3329827F2DA3 = getomnvar("ui_br_circle_num");

  if(_id_264E3329827F2DA3 < _id_8A7D4AA442793440)
    return 0;

  return 1;
}

condition_circlesremaining(_id_8A7D4AA442793440) {
  if(istrue(level.br_circle_disabled))
    return 1;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex))
    return 0;

  _id_5CD0D923D30C3182 = level.br_level.br_circledelaytimes.size;
  _id_D6CADF9CBBF1F862 = _id_5CD0D923D30C3182 - level.br_circle.circleindex;

  if(_id_D6CADF9CBBF1F862 < _id_8A7D4AA442793440)
    return 0;

  return 1;
}

condition_maxaliveplayers(_id_A488B9199457E184) {
  if(!isDefined(level.teamdata))
    return 0;

  count = 0;

  foreach(_id_DB62C0CFC8A661CC in level.teamdata)
  count = count + _id_DB62C0CFC8A661CC["aliveCount"];

  if(count > _id_A488B9199457E184)
    return 0;

  return 1;
}

condition_maxactivelocations(_id_A075796C11E1B0DF) {
  if(self.info.activelocations.size >= _id_A075796C11E1B0DF)
    return 0;

  return 1;
}

condition_mintimepassed(_id_80B642A0F8C9659D) {
  _id_ADF94D60FB897E54 = scripts\mp\utility\game::getsecondspassed();

  if(_id_ADF94D60FB897E54 < _id_80B642A0F8C9659D)
    return 0;

  return 1;
}

condition_lastencounterstarttime(_id_80B642A0F8C9659D) {
  info = self.info;

  if(isDefined(info.lastencounter)) {
    _id_9C7A4F6C4F5640E3 = (gettime() - info.lastencounter.endtime) / 1000;

    if(_id_9C7A4F6C4F5640E3 < _id_80B642A0F8C9659D)
      return 0;
  }

  return 1;
}

condition_prematchdone() {
  if(!isDefined(game["flags"]["prematch_done"]))
    return 0;

  if(scripts\mp\flags::gameflag("prematch_done"))
    return 1;

  return 0;
}

condition_debugpaused() {
  if(getdvarint("dvar_A163377BB1005BF5", 0))
    return 0;

  return 1;
}

successcondition_enemykills(numkills) {
  self endon("encounter_end");

  for(;;) {
    self waittill("agent_killed");

    if(self.agentskilled >= numkills)
      encounter_end(1);
  }
}

failcondition_noplayersinengagedradius(_id_80B642A0F8C9659D) {
  self endon("encounter_end");
  _id_80B642A0F8C9659D = int(_id_80B642A0F8C9659D);
  _id_231AE15DEB765EC1 = _id_80B642A0F8C9659D;

  for(;;) {
    wait 1;

    if(self.playersinengagedradius.size > 0) {
      _id_80B642A0F8C9659D = _id_231AE15DEB765EC1;
      continue;
    }

    _id_80B642A0F8C9659D--;

    if(_id_80B642A0F8C9659D <= 0)
      encounter_end(0);
  }
}

failcondition_outsidedangercircle() {
  self endon("encounter_end");

  for(;;) {
    wait 1;

    if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
      continue;
    }
    circleorigin = _id_2695A20D4011076D::getdangercircleorigin();
    circleradius = _id_2695A20D4011076D::getdangercircleradius();
    _id_4AAE5F1A6DC74DA0 = distance2dsquared(self.origin, circleorigin);

    if(_id_4AAE5F1A6DC74DA0 > circleradius * circleradius) {
      if(self.playersinengagedradius.size > 0) {} else
        encounter_end(0);

      continue;
    }
  }
}

targetstart_spawner(target) {
  targetstart_spawner_init(target);
  agent = spawn_agent(target);

  if(isDefined(agent)) {
    if(isDefined(target.goalnodes)) {
      goalnode = scripts\engine\utility::random(target.goalnodes);
      agent setgoalnode(goalnode);
    }

    if(isDefined(target.goalvolumes)) {
      _id_448DCBC6F715EFDC = scripts\engine\utility::random(target.goalvolumes);

      if(_id_448DCBC6F715EFDC.auto)
        agent setgoalvolumeauto(_id_448DCBC6F715EFDC);
      else
        agent setgoalvolume(_id_448DCBC6F715EFDC);
    }
  }

  return agent;
}

targetstart_spawner_init(spawner) {
  spawner.team = _id_735A674748FC65EF::get_ai_team();
  spawner.aitype = [[self.func_getspawneraitype]](spawner);
  targets = spawner _id_735A674748FC65EF::get_targets();

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "goal_volume":
        targetstart_spawner_volume(spawner, target, 0);
        break;
      case "goal_volume_auto":
        targetstart_spawner_volume(spawner, target, 1);
        break;
      case "goal_node":
      case "goal":
        targetstart_spawner_node(spawner, target);
        break;
      default:
        break;
    }
  }
}

targetstart_spawner_node(spawner, node) {
  if(!isDefined(spawner.goalnodes))
    spawner.goalnodes = [];

  spawner.goalnodes[spawner.goalnodes.size] = node;
}

targetstart_spawner_volume(spawner, volume, auto) {
  if(!isDefined(spawner.goalvolumes))
    spawner.goalvolumes = [];

  volume.auto = auto;
  spawner.goalvolumes[spawner.goalvolumes.size] = volume;
}

targetstart_icon(_id_CD73BC5A9CBDA8CD) {
  id = scripts\mp\objidpoolmanager::requestobjectiveid(0);
  scripts\mp\objidpoolmanager::objective_add_objective(id, "current", _id_CD73BC5A9CBDA8CD.origin, "icon_waypoint_objective_general", "icon_regular");
  objective_setshowoncompass(id, 1);
  objective_setplayintro(id, 1);
  objective_setlabel(id, self.iconlabel);
  thread icon_update_visibility(id);
  self waittill("encounter_end");
  scripts\mp\objidpoolmanager::returnobjectiveid(id);
  objective_delete(id);
}

targetstart_reward(_id_C058970A10D37D8B) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  self waittill("encounter_end", success, _id_FE593BA7D0935BB5);

  if(!success) {
    return;
  }
  _id_DE19F33CB691869D = rewardspawn(_id_C058970A10D37D8B);

  if(!isDefined(_id_DE19F33CB691869D)) {
    return;
  }
  if(isDefined(_id_FE593BA7D0935BB5)) {
    _id_EEAE97CADD2906CE = [];
    _id_CEB1FF9428033CFD = [];

    foreach(guid, _id_B4C04337A6A90C84 in self.playersinnotifyradius) {
      player = self.guidtoplayer[guid];

      if(!isDefined(player)) {
        continue;
      }
      if(player.team == _id_FE593BA7D0935BB5) {
        _id_EEAE97CADD2906CE[_id_EEAE97CADD2906CE.size] = player;
        continue;
      }

      _id_CEB1FF9428033CFD[_id_CEB1FF9428033CFD.size] = player;
    }

    thread rewardicon(_id_DE19F33CB691869D, "icon_waypoint_unlocked", _id_EEAE97CADD2906CE);
    thread rewardicon(_id_DE19F33CB691869D, "icon_waypoint_locked", _id_CEB1FF9428033CFD);
    rewardobjectlock(_id_DE19F33CB691869D, _id_EEAE97CADD2906CE, _id_CEB1FF9428033CFD);
  } else {
    _id_BE4E32B47AD61C7D = [];

    foreach(guid, _id_B4C04337A6A90C84 in self.playersinnotifyradius) {
      player = self.guidtoplayer[guid];

      if(!isDefined(player)) {
        continue;
      }
      _id_BE4E32B47AD61C7D[_id_BE4E32B47AD61C7D.size] = player;
    }

    thread rewardicon(_id_DE19F33CB691869D, "icon_waypoint_unlocked", _id_BE4E32B47AD61C7D);
  }
}

targetstart_reward_prespawn(_id_C058970A10D37D8B) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  _id_DE19F33CB691869D = rewardspawn(_id_C058970A10D37D8B);
  _id_735A674748FC65EF::disablescriptableplayeruseall(_id_DE19F33CB691869D);
  navobstacleid = createnavobstaclebybounds(_id_DE19F33CB691869D.origin, (30, 15, 10), _id_DE19F33CB691869D.angles);
  self waittill("encounter_end", success);
  destroynavobstacle(navobstacleid);

  if(isDefined(_id_DE19F33CB691869D)) {
    if(success) {
      _id_735A674748FC65EF::enablescriptableplayeruseall(_id_DE19F33CB691869D);
      rewardicon(_id_DE19F33CB691869D, "icon_waypoint_unlocked");
    } else
      _id_DE19F33CB691869D freescriptable();
  }
}

rewardspawn(_id_C058970A10D37D8B, modifier) {
  _id_0F0B26F5F8DB069E = _id_C058970A10D37D8B.script_parameters;

  if(!isDefined(_id_0F0B26F5F8DB069E))
    _id_0F0B26F5F8DB069E = "brloot_killstreak_clusterstrike";

  _id_DE19F33CB691869D = undefined;

  switch (_id_0F0B26F5F8DB069E) {
    case "brloot_killstreak_clusterstrike":
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_C058970A10D37D8B.origin + (0, 0, 0.1), _id_C058970A10D37D8B.angles);
      _id_DE19F33CB691869D = _id_7E52B56769FA7774::spawnpickup(_id_0F0B26F5F8DB069E, _id_CB4FAD49263E20C4, 0, 1);
      break;
    default:
  }

  if(isDefined(_id_CB4FAD49263E20C4)) {
    thread rewardobjectusewatch(_id_CB4FAD49263E20C4);
    thread rewardobjectcleanup(_id_CB4FAD49263E20C4);
  }

  return _id_CB4FAD49263E20C4;
}

rewardobjectlock(_id_DE19F33CB691869D, _id_0E5D6ABFF320CF8A, _id_E40AC825A44E8757) {
  rewardobjectsetusable(_id_DE19F33CB691869D, _id_0E5D6ABFF320CF8A);
  lock = spawn("script_model", _id_DE19F33CB691869D.origin + (0, 0, 30));
  lock setModel("tag_origin");
  lock makeusable();
  lock setHintString("MP/DOOR_USE_LOCK");
  lock setuseholdduration("duration_long");
  lock setusefov(15);
  lock setCursorHint("HINT_BUTTON");

  foreach(player in _id_0E5D6ABFF320CF8A)
  lock disableplayeruse(player);

  thread rewardobjectcleanup(lock);
  thread rewardobjectlockthink(lock, _id_DE19F33CB691869D);
}

rewardobjectlockthink(lock, _id_DE19F33CB691869D) {
  self endon("reward_cleanup");
  lock waittill("trigger", player);
  part = _id_DE19F33CB691869D.scriptablename;
  _id_7E52B56769FA7774::lootused(_id_DE19F33CB691869D, part, "visible", player);
}

rewardobjectusewatch(_id_DE19F33CB691869D) {
  self endon("reward_cleanup");

  while(isDefined(_id_DE19F33CB691869D))
    waitframe();

  self notify("reward_cleanup");
}

rewardobjectcleanup(_id_DE19F33CB691869D) {
  self waittill("reward_cleanup");

  if(isDefined(_id_DE19F33CB691869D)) {
    if(_id_DE19F33CB691869D isscriptable())
      _id_DE19F33CB691869D freescriptable();
    else
      _id_DE19F33CB691869D delete();
  }
}

rewardobjectsetusable(_id_DE19F33CB691869D, _id_9509C12EDF4F2C41) {
  _id_735A674748FC65EF::disablescriptableplayeruseall(_id_DE19F33CB691869D);

  foreach(player in _id_9509C12EDF4F2C41)
  _id_DE19F33CB691869D enablescriptableplayeruse(player);
}

rewardicon(_id_DE19F33CB691869D, _id_2EAF3F31852684FD, _id_BE4E32B47AD61C7D) {
  id = createrewardicon(_id_DE19F33CB691869D, _id_2EAF3F31852684FD);

  if(id < 0) {
    return;
  }
  if(isDefined(_id_BE4E32B47AD61C7D)) {
    foreach(player in _id_BE4E32B47AD61C7D)
    objective_addclienttomask(id, player);
  }

  thread rewardiconcleanup(id);
}

createrewardicon(_id_DE19F33CB691869D, _id_2EAF3F31852684FD) {
  id = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(id >= 0) {
    scripts\mp\objidpoolmanager::objective_add_objective(id, "current", _id_DE19F33CB691869D.origin + (0, 0, 50), _id_2EAF3F31852684FD, "icon_regular");
    objective_setshowoncompass(id, 1);
    objective_setplayintro(id, !istrue(self.norewardiconintro));
    objective_setlabel(id, "BR_AI_ENCOUNTERS/OBJ_LABEL_REWARD");
    objective_showtoplayersinmask(id);
    objective_removeallfrommask(id);
  }

  return id;
}

rewardiconcleanup(id) {
  self waittill("reward_cleanup");
  scripts\mp\objidpoolmanager::returnobjectiveid(id);
}

icon_update_visibility(objid) {
  self endon("encounter_end");
  objective_showtoplayersinmask(objid);

  for(;;) {
    objective_removeallfrommask(objid);

    foreach(guid, _id_B4C04337A6A90C84 in self.playersinnotifyradius) {
      player = self.guidtoplayer[guid];

      if(isDefined(player))
        objective_addclienttomask(objid, player);
    }

    self waittill("notify_list_changed");
  }
}

spawn_agent(_id_6F35BF8F6B43224C) {
  agent = scripts\mp\mp_agent::spawnnewagent(_id_6F35BF8F6B43224C.aitype, _id_6F35BF8F6B43224C.team, _id_6F35BF8F6B43224C.origin, _id_6F35BF8F6B43224C.angles);

  if(isDefined(agent)) {
    agent.recentkillcount = 0;
    agent.recentdefendcount = 0;
    agent.kills = 0;
    agent.deaths = 0;
    agent.pers["cur_kill_streak"] = 0;
    agent.pers["cur_death_streak"] = 0;
    agent.pers["cur_kill_streak_for_nuke"] = 0;
    agent.tookweaponfrom = [];
    agent.killedplayers = [];
    agent.guid = agent scripts\mp\utility\player::getuniqueid();
    agent.script_noteworthy = _id_6F35BF8F6B43224C.script_noteworthy;
    agent.scripted_long_deaths = 0;
    agent.agentdamagefeedback = 1;
    self.agents[self.agents.size] = agent;
    thread watch_agent_death(agent);
  } else {}

  return agent;
}

watch_agent_death(agent) {
  agent waittill("death");
  self.agents = scripts\engine\utility::array_remove(self.agents, agent);
  self.agentskilled++;
  self notify("agent_killed");
}

targetstart_spawntrigger(trigger) {
  for(;;) {
    trigger waittill("trigger", player);

    if(isagent(player)) {
      continue;
    }
    break;
  }

  targets = trigger _id_735A674748FC65EF::get_targets();

  foreach(target in targets)
  targetstart_spawner(target);
}

root_ecounterstart() {
  thread root_inittargets();
  thread root_monitorplayers();
  thread root_failconditions();
}

root_getspawneraitype(spawner) {
  return spawner.name;
}

root_inittargets() {
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_GENERIC";
  waittillframeend;
  targets = _id_735A674748FC65EF::get_targets();

  foreach(target in targets) {
    type = target.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "spawner":
        thread targetstart_spawner(target);
        break;
      case "spawn_trigger":
        thread targetstart_spawntrigger(target);
        break;
      case "icon":
        thread targetstart_icon(target);
        break;
      case "reward":
        thread targetstart_reward(target);
        break;
      case "reward_prespawn":
        thread targetstart_reward_prespawn(target);
        break;
      default:
        break;
    }
  }
}

root_monitorplayers() {
  self endon("encounter_end");
  self.notifyradius = 7500;
  self.engagedradius = 2000;
  self.playersinnotifyradius = [];
  self.playersinengagedradius = [];
  self.guidtoplayer = [];
  waittillframeend;
  _id_391B2531E976A730 = self.notifyradius * self.notifyradius;
  _id_ECB629D51F9EE6EE = self.engagedradius * self.engagedradius;
  _id_A2562E11884920F6 = 20;

  for(;;) {
    currenttime = gettime();
    _id_2F8B94E6F5C0C95F = 0;
    _id_6856B42EACC64814 = 0;
    _id_DA211178DCF27FBA = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(!isDefined(player)) {
        continue;
      }
      self.guidtoplayer[player.guid] = player;

      if(!isalive(player)) {
        if(isDefined(self.playersinnotifyradius[player.guid])) {
          _id_6856B42EACC64814 = 1;
          self.playersinnotifyradius[player.guid] = undefined;
        }

        if(isDefined(self.playersinengagedradius[player.guid])) {
          _id_DA211178DCF27FBA = 1;
          self.playersinengagedradius[player.guid] = undefined;
        }

        continue;
      }

      _id_F95436827E16D133 = distance2dsquared(player.origin, self.origin);

      if(_id_F95436827E16D133 <= _id_391B2531E976A730) {
        if(!isDefined(self.playersinnotifyradius[player.guid]))
          _id_6856B42EACC64814 = 1;

        self.playersinnotifyradius[player.guid] = currenttime;
      } else {
        _id_B4C04337A6A90C84 = self.playersinnotifyradius[player.guid];

        if(isDefined(_id_B4C04337A6A90C84) && currenttime - _id_B4C04337A6A90C84 > 2000) {
          _id_6856B42EACC64814 = 1;
          self.playersinnotifyradius[player.guid] = undefined;
        }
      }

      if(_id_F95436827E16D133 <= _id_ECB629D51F9EE6EE) {
        if(!isDefined(self.playersinengagedradius[player.guid]))
          _id_DA211178DCF27FBA = 1;

        self.playersinengagedradius[player.guid] = currenttime;
      } else {
        _id_B4C04337A6A90C84 = self.playersinengagedradius[player.guid];

        if(isDefined(_id_B4C04337A6A90C84) && currenttime - _id_B4C04337A6A90C84 > 2000) {
          _id_DA211178DCF27FBA = 1;
          self.playersinengagedradius[player.guid] = undefined;
        }
      }

      _id_2F8B94E6F5C0C95F++;

      if(_id_2F8B94E6F5C0C95F >= _id_A2562E11884920F6) {
        wait 0.05;
        _id_2F8B94E6F5C0C95F = 0;
      }
    }

    if(_id_6856B42EACC64814)
      self notify("notify_list_changed");

    if(_id_DA211178DCF27FBA)
      self notify("engaged_list_changed");

    wait 0.05;
  }
}

root_failconditions() {
  self.failconditionengagedradiustime = 90;
  waittillframeend;
  thread failcondition_noplayersinengagedradius(self.failconditionengagedradiustime);
  thread failcondition_outsidedangercircle();
}

rootai_ecounterstart() {
  self.usesai = 1;
  self.func_getspawneraitype = ::root_getspawneraitype;
  self.agentskilled = 0;
  self.agents = [];
}

bank_ecounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = ::bank_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_BANK";
  thread alarm_sound_on();
  thread alarm_sound_off_encounter_end();
  thread vault_door_think();
  _id_BAF4ED84461B1570 = getEnt("bank_vol_01", "targetname");
  _id_1F9B128600C9D94F = getEnt("bank_vol_01_upper", "targetname");
  level.wave1_enemies = [];
  _id_F9B64C981AA4EAD5 = scripts\engine\utility::getStructArray("enemy_wave_01", "targetname");

  foreach(struct in _id_F9B64C981AA4EAD5) {
    _id_280EE35A5ECCE148 = targetstart_spawner(struct);

    if(_id_280EE35A5ECCE148.script_noteworthy == "wave01_upper") {
      _id_280EE35A5ECCE148 setgoalvolumeauto(_id_1F9B128600C9D94F);
      _id_280EE35A5ECCE148.goalheight = 256;
    } else if(_id_280EE35A5ECCE148.script_noteworthy == "wave01_lower")
      _id_280EE35A5ECCE148 setgoalvolumeauto(_id_BAF4ED84461B1570);

    level.wave1_enemies = scripts\engine\utility::array_add(level.wave1_enemies, _id_280EE35A5ECCE148);
  }

  _id_4363CFB8B64DF5F4 = getEnt("wave_01_overrun_trig", "targetname");
  waittill_trigger_or_dead(_id_4363CFB8B64DF5F4, level.wave1_enemies, level.wave1_enemies.size - 3);
  level notify("spawn_wave2");
  _id_BAF4F084461B1C09 = getEnt("bank_vol_02", "targetname");
  _id_52D1D968632B4435 = [];
  _id_861E23EAE938B57F = scripts\engine\utility::getStructArray("enemy_wave_02", "targetname");

  foreach(guy in _id_861E23EAE938B57F) {
    _id_280EE35A5ECCE148 = targetstart_spawner(guy);
    _id_280EE35A5ECCE148 setgoalvolumeauto(_id_BAF4F084461B1C09);
    _id_52D1D968632B4435 = scripts\engine\utility::array_add(_id_52D1D968632B4435, _id_280EE35A5ECCE148);
  }

  foreach(enemy in level.wave1_enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      enemy setgoalvolumeauto(_id_BAF4F084461B1C09);
      _id_52D1D968632B4435 = scripts\engine\utility::array_add(_id_52D1D968632B4435, enemy);
    }
  }

  _id_735A674748FC65EF::waittill_dead(_id_52D1D968632B4435, _id_52D1D968632B4435.size);
  wait 0.5;
  self notify("open_vault");
  _id_BAF4EF84461B19D6 = getEnt("bank_vol_03", "targetname");
  _id_AE7126DE41CFDC3E = [];
  _id_293F0904152C71C1 = scripts\engine\utility::getStruct("enemy_wave_03_boss", "targetname");
  _id_415021716F694843 = targetstart_spawner(_id_293F0904152C71C1);
  _id_415021716F694843 thread jug_behavior();
  _id_AE7126DE41CFDC3E = scripts\engine\utility::array_add(_id_AE7126DE41CFDC3E, _id_415021716F694843);
  _id_735A674748FC65EF::waittill_dead(_id_AE7126DE41CFDC3E, _id_AE7126DE41CFDC3E.size);
  encounter_end(1);
}

vault_door_open_wait() {
  self endon("encounter_end");
  self waittill("open_vault");
}

vault_door_init(door) {
  if(istrue(door.init)) {
    door.angles = door.start_angles;
    return;
  }

  door_clip = getEnt("vault_door_clip", "targetname");
  door_clip linkTo(door);
  door.start_angles = door.angles;
  door.init = 1;
}

vault_door_think() {
  door = getEnt("vault_door", "targetname");
  vault_door_init(door);
  vault_door_open_wait();
  door thread vault_door_sound();
  door rotateby((0, 180, 0), 5);
}

jug_behavior() {
  players = sortbydistance(level.players, self.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(isalive(player)) {
      self getenemyinfo(player);
      self setgoalentity(player);
      break;
    }
  }
}

alarm_sound_on() {
  _id_1977D2FF9B8F08C3 = getEntArray("bank_alarm_pos", "targetname");

  foreach(pos in _id_1977D2FF9B8F08C3)
  pos playLoopSound("emt_alarm_bank_bell_lp");
}

alarm_sound_off() {
  _id_1977D2FF9B8F08C3 = getEntArray("bank_alarm_pos", "targetname");

  foreach(pos in _id_1977D2FF9B8F08C3)
  pos stoploopsound("emt_alarm_bank_bell_lp");
}

vault_door_sound() {
  _id_457471485336C961 = 4000000;

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player)) {
      if(distancesquared(player.origin, self.origin) <= _id_457471485336C961)
        player playSound("cp_bank_vault_open");
    }
  }
}

waittill_trigger_or_dead(trigger, guys, num, _id_F6A66E3FC1BF61C0) {
  struct = spawnStruct();
  struct endon("done");
  struct childthread _waittill_trigger(trigger);
  struct childthread _waittill_dead_notify_done(guys, num, _id_F6A66E3FC1BF61C0);
  struct waittill("done");
}

_waittill_dead_notify_done(guys, num, _id_F6A66E3FC1BF61C0) {
  _id_735A674748FC65EF::waittill_dead(guys, num, _id_F6A66E3FC1BF61C0);
  self notify("done");
}

_waittill_trigger(trigger) {
  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    break;
  }

  self notify("done");
}

alarm_sound_off_encounter_end() {
  self waittill("encounter_end");
  alarm_sound_off();
}

bank_getspawneraitype(spawner) {
  if(isDefined(spawner.script_noteworthy)) {
    switch (spawner.script_noteworthy) {
      case "jugg":
        return "actor_enemy_br_juggernaut";
      default:
        break;
    }
  }

  return "actor_enemy_br_base";
}

airport_ecounterstart() {
  _id_A4CCC78C8BA2C673 = getEnt("ai_encounter_crate", "targetname");
  _id_A4CCC78C8BA2C673 movez(256, 0.05);
  wait 0.5;
  createnavobstaclebyent(_id_A4CCC78C8BA2C673);
  trigger = getEnt("kickoff_airport_encounter", "targetname");
  trigger waittill("trigger", player);
  grenadeweapon = "smoke_grenade_mp";
  _id_C8AD4A3D631DB329 = magicgrenademanual(grenadeweapon, scripts\engine\utility::getStruct("airport_smoke_toss_pos", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos", "targetname").angles) * 400, 1);
  wait 0.1;
  _id_C8AD473D631DAC90 = magicgrenademanual(grenadeweapon, scripts\engine\utility::getStruct("airport_smoke_toss_pos_02", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos_02", "targetname").angles) * 400, 1.3);
  _id_C8AD483D631DAEC3 = magicgrenademanual(grenadeweapon, scripts\engine\utility::getStruct("airport_smoke_toss_pos_03", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos_03", "targetname").angles) * 450, 2);
  _id_BAF4ED84461B1570 = getEnt("airport_vol_01", "targetname");
  wait 2;
  _id_43E751AD559F1C24 = [];
  _id_F9B64C981AA4EAD5 = scripts\engine\utility::getStructArray("airport_enemy_wave_01", "targetname");

  foreach(struct in _id_F9B64C981AA4EAD5) {
    _id_280EE35A5ECCE148 = targetstart_spawner(struct);
    _id_280EE35A5ECCE148 setgoalvolumeauto(_id_BAF4ED84461B1570);
    _id_280EE35A5ECCE148 thread airport_enemy_setup();
    _id_43E751AD559F1C24 = scripts\engine\utility::array_add(_id_43E751AD559F1C24, _id_280EE35A5ECCE148);
  }

  _id_4363CFB8B64DF5F4 = getEnt("wave_01_overrun_trig", "targetname");
  _id_735A674748FC65EF::waittill_dead(_id_43E751AD559F1C24, _id_43E751AD559F1C24.size);
  encounter_end(1);
}

airport_enemy_setup() {
  self.ignore_all = 1;
  wait(randomfloatrange(1, 2));
  self.ignore_all = 0;
  self.accuracy = 0.01;
}

truck_encounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = ::truck_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_TRUCK";
  thread failcondition_noplayersinengagedradius(90);
  start_trigger = undefined;
  _id_8E440E8F6172B38F = undefined;
  _id_F2DDD0AA0E17AF6C = [];
  _id_E885AC175BF944E4 = [];
  targets = _id_735A674748FC65EF::get_targets();

  foreach(target in targets) {
    type = target.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "start_trigger":
        start_trigger = target;
        break;
      case "truck_enemy_wave":
        _id_F2DDD0AA0E17AF6C[_id_F2DDD0AA0E17AF6C.size] = target;
        break;
      case "roll_door":
        _id_8E440E8F6172B38F = target;
        thread truck_roll_door_init(_id_8E440E8F6172B38F);
        break;
      case "jump_down_node":
        _id_E885AC175BF944E4[_id_E885AC175BF944E4.size] = target;
        break;
      default:
        break;
    }
  }

  for(;;) {
    start_trigger waittill("trigger", player);

    if(isalive(player) && isPlayer(player)) {
      break;
    }
  }

  destroynavobstacle(_id_8E440E8F6172B38F getentitynumber());
  truck_roll_door_open(_id_8E440E8F6172B38F);
  _id_B71B94CD63885213 = [];

  foreach(guy in _id_F2DDD0AA0E17AF6C) {
    _id_280EE35A5ECCE148 = targetstart_spawner(guy);
    _id_B71B94CD63885213 = scripts\engine\utility::array_add(_id_B71B94CD63885213, _id_280EE35A5ECCE148);
  }

  _id_735A674748FC65EF::waittill_dead(_id_B71B94CD63885213, _id_B71B94CD63885213.size);
  encounter_end(1);
}

truck_roll_door_init(door) {
  self endon("encounter_end");

  if(!istrue(door.init)) {
    door.angle_ref = scripts\engine\utility::getStruct(door.target, "targetname");

    if(!isDefined(door.angle_ref.angles))
      door.angle_ref.angles = (0, 0, 0);

    door.start_origin = door.origin;
    door.start_angles = door.angles;
    door.init = 1;
  } else {
    door.origin = door.start_origin;
    door.angles = door.start_angles;
  }
}

truck_roll_door_open(_id_8E440E8F6172B38F) {
  _id_8E440E8F6172B38F rotatepitch(-90, 1);
  truck_roll_door_sound(_id_8E440E8F6172B38F);
  self notify("truck_roll_door_open");
}

truck_roll_door_sound(door) {
  _id_457471485336C961 = 1000000;

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player)) {
      if(distancesquared(player.origin, door.origin) <= _id_457471485336C961)
        player playSound("cp_bank_gate_fall");
    }
  }
}

truck_getspawneraitype(spawner) {
  return "actor_enemy_br_base";
}

crateguard_encounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = ::crateguard_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_CRATE_GUARD";
  thread failcondition_noplayersinengagedradius(90);
  start_trigger = undefined;
  _id_3A83F6349784BD99 = undefined;
  guard_spawners = [];
  targets = _id_735A674748FC65EF::get_targets();

  foreach(target in targets) {
    type = target.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "guard":
        guard_spawners[guard_spawners.size] = target;
        break;
      case "guard_boss":
        _id_3A83F6349784BD99 = target;
        break;
      case "start_trigger":
        start_trigger = target;
        break;
      default:
        break;
    }
  }

  for(;;) {
    start_trigger waittill("trigger", player);

    if(isalive(player) && isPlayer(player)) {
      break;
    }
  }

  _id_98AA513355E1A321 = [];

  foreach(struct in guard_spawners) {
    _id_280EE35A5ECCE148 = targetstart_spawner(struct);
    _id_98AA513355E1A321[_id_98AA513355E1A321.size] = _id_280EE35A5ECCE148;
  }

  _id_E2958F412A7425C0 = targetstart_spawner(_id_3A83F6349784BD99);
  _id_98AA513355E1A321[_id_98AA513355E1A321.size] = _id_E2958F412A7425C0;
  childthread crateguard_bosssetup(_id_E2958F412A7425C0, _id_98AA513355E1A321);
  _id_735A674748FC65EF::waittill_dead(_id_98AA513355E1A321, _id_98AA513355E1A321.size);
  encounter_end(1);
}

crateguard_bosssetup(_id_E2958F412A7425C0, _id_896452C986F0513B) {
  _id_E2958F412A7425C0.ignoreall = 1;
  _id_6FDBC1BB50C4D774 = _id_896452C986F0513B;
  _id_6FDBC1BB50C4D774[_id_6FDBC1BB50C4D774.size] = _id_E2958F412A7425C0;
  scripts\engine\utility::waittill_any_ents_array(_id_6FDBC1BB50C4D774, "death", "damage", "enemy");

  if(isDefined(_id_E2958F412A7425C0))
    _id_E2958F412A7425C0.ignoreall = 0;
}

crateguard_getspawneraitype(spawner) {
  if(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == "guard_boss")
    return "actor_enemy_br_boss";

  return "actor_enemy_br_base";
}

smoking() {
  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "smoking_death";
  thread smoking_idle("smoking_idle");
  thread smoking_react("smoking_react");
  thread smoking_death("smoking_death");
}

smoking_idle(animalias) {
  self endon("death");
  self endon("damage");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::animscripted_single(animalias);
    smoking_idle_end("smoking_idle_end");
  }
}

smoking_idle_start(animalias) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::animscripted_single(animalias);
}

smoking_idle_end(animalias) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::animscripted_single(animalias);
}

smoking_react(_id_E25CA6F64FDB941F) {
  self endon("death");
  self waittill("damage");
  ai_smoking_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::animscripted_single(_id_E25CA6F64FDB941F);
  reset_guy(self);
}

smoking_death(_id_85DD2D48556B2B7F) {
  self endon("damage");
  self waittill("death");
  ai_smoking_cleanup();
}

ai_notehandler_smoking(_id_A234A65C378F3289) {
  switch (_id_A234A65C378F3289) {
    case "attach":
      playFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      break;
    case "light":
      playFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
      stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level.g_effect["lighter_glow"], self gettagorigin("tag_accessory_right"));
      thread ai_smoking_blowsmoke();
      break;
    case "detach":
      stopFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
      stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
      break;
  }
}

ai_smoking_blowsmoke() {
  self endon("smoking_end");
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    playFX(level.g_effect["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    waittime = randomintrange(5, 8);
    wait(waittime);
  }
}

ai_smoking_cleanup() {
  self notify("smoking_end");
  self endon("death");

  if(scripts\engine\utility::hastag(self.model, "tag_accessory_right")) {
    killfxontag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
    killfxontag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
  }
}

standing_cellphone(_id_FF75B4157A7AA48A) {
  if(!isDefined(_id_FF75B4157A7AA48A))
    _id_FF75B4157A7AA48A = 0;

  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "stand_cellphone_death";
  thread ai_notetrack_loop("standing_cellphone");
  standing_cellphone_anim("stand_cellphone_intro");

  if(_id_FF75B4157A7AA48A > 0)
    standing_cellphone_loop("stand_cellphone_loop", _id_FF75B4157A7AA48A);

  standing_cellphone_anim("stand_cellphone_exit");
}

standing_cellphone_anim(animalias) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::animscripted_single(animalias);
}

standing_cellphone_loop(animalias, loops) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::animscripted_loop_n_times(animalias, loops);
}

ai_notehandler_cellphone(_id_A234A65C378F3289) {
  self endon("death");
  self endon("damage");

  switch (_id_A234A65C378F3289) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("equipment_personal_smartphone_01", "tag_accessory_right");
      wait 2;
      break;
    case "detach":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
  }
}

setup_anim_guy() {
  self.playing_skit = 1;
}

reset_guy(guy) {
  guy allowedstances("prone", "stand", "crouch");
  guy scripts\asm\shared\mp\utility::animscripted_clear();
  guy setlookatentity();
  guy.headlook_enabled = 1;
  guy.disableautolookat = 0;
  guy.deathstate = undefined;
  guy.deathalias = undefined;
  guy.ignoreall = 0;
  guy.playing_skit = undefined;

  if(isDefined(self.anchor))
    self.anchor delete();
}

ai_notetrack_loop(_id_887D46B1410C42CA) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    self waittill("animscripted", notes);

    if(!isDefined(notes))
      notes = ["undefined"];

    if(!isarray(notes))
      notes = [notes];

    _id_FC9A12FE1F57542A = undefined;

    foreach(_id_A234A65C378F3289 in notes) {
      if(_id_887D46B1410C42CA == "smoking") {
        ai_notehandler_smoking(_id_A234A65C378F3289);
        continue;
      }

      if(_id_887D46B1410C42CA == "standing_cellphone")
        ai_notehandler_cellphone(_id_A234A65C378F3289);
    }
  }
}

test_ecounterstart() {}

rootnonai_ecounterstart() {
  self.usesai = 0;
}

dom_encounterstart() {
  self.norewardiconintro = 1;
  self.engagedradius = 1500;
  domencounter_icons();
  trigger = undefined;
  targets = _id_735A674748FC65EF::get_targets();

  foreach(target in targets) {
    type = target.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "trigger_radius":
        radius = 315;
        height = 120;
        trigger = spawn("trigger_radius", target.origin, 0, int(radius), int(height));
        trigger.script_label = "_a";
        break;
      default:
        break;
    }
  }

  if(!isDefined(trigger)) {
    return;
  }
  level.setdomscriptablepartstatefunc = ::domencounter_setdomscriptablepartstate;
  domflag = _id_6663215F917210AE::setupobjective(trigger);
  domflag.noscriptable = undefined;
  domflag.vfxnamemod = "_300";
  domflag.onuse = ::domencounter_onuse;
  domflag.onuseupdate = ::domencounter_onuseupdate;
  domflag.onenduse = ::domencounter_onenduse;
  domflag scripts\mp\gameobjects::setvisibleteam("any");
  domflag _id_6663215F917210AE::domflag_setneutral();
  level.flagcapturetime = getdvarint("dvar_AB50F58BB9979459", 30);
  domflag scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  domflag.encounterlocation = self;
  thread encounterdeletedomgameobjectonend(domflag);
  thread icon_update_visibility(domflag.objidnum);
}

encounterdeletedomgameobjectonend(domflag) {
  domflag endon("deleted");
  self waittill("encounter_end");

  foreach(_id_06D8B9034036E075 in domflag.visuals)
  _id_06D8B9034036E075 delete();

  if(isDefined(domflag.flagmodel))
    domflag.flagmodel delete();

  if(isDefined(domflag.scriptable))
    domflag.scriptable delete();

  if(isDefined(domflag.trigger)) {
    domflag.trigger delete();
    domflag.trigger = undefined;
  }

  domflag thread gameobjectreleaseid_delayed();
  domflag notify("deleted");
}

gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

domencounter_icons() {
  level.iconneutral = "waypoint_captureneutral_br";
  level.iconcapture = "waypoint_capture_br";
  level.icondefend = "waypoint_defend_br";
  level.icondefending = "waypoint_defending_br";
  level.iconcontested = "waypoint_contested_br";
  level.icontaking = "waypoint_taking_br";
  level.iconlosing = "waypoint_losing_br";
  _setdomencountericoninfo("icon_waypoint_dom_br", "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
  _setdomencountericoninfo("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomencountericoninfo("waypoint_capture_br", "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
  _setdomencountericoninfo("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomencountericoninfo("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomencountericoninfo("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _setdomencountericoninfo("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _setdomencountericoninfo("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _setdomencountericoninfo("waypoint_captureneutral_br", "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
  _setdomencountericoninfo("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomencountericoninfo("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomencountericoninfo("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
}

_setdomencountericoninfo(name, colors, string, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 0;
  level.waypointstring[name] = string;
  level.waypointshader[name] = "icon_waypoint_dom_a";
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

domencounter_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify)
    self.didstatusnotify = 1;
}

domencounter_onuse(_id_22282E7D48CA3400) {
  self.encounterlocation encounter_end(1, _id_22282E7D48CA3400.team);
}

domencounter_onenduse(team, player, success) {
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
}

domencounter_setdomscriptablepartstate(part, state, _id_BA360E4FF7BE8D96) {
  switch (state) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      state = "using";

      if(isDefined(_id_BA360E4FF7BE8D96))
        state = state + _id_BA360E4FF7BE8D96;

      self.scriptable setscriptablepartstate(part, state);

      if(part == "pulse")
        self.scriptable setscriptablepartstate("flag", state);

      return 1;
  }
}

bombplant_encounterstart() {}

extraction_encounterstart() {
  iprintlnbold("EXTRACTION START");
  targets = _id_735A674748FC65EF::get_targets();

  foreach(target in targets) {
    type = target.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "use_object":
        extraction_createescort(target);
        break;
      case "goal":
        targetstart_extractiongoal(target);
        break;
      default:
        break;
    }
  }
}

targetstart_extractiongoal(goalstruct) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  goal = spawn("script_model", goalstruct.origin + (0, 0, 20));
  goal setModel("ctf_game_flag_east");
  self.goal = goal;
  goal.encounter = self;
}

extraction_createescort(target) {
  escort = spawn("script_model", target.origin + (0, 0, 20));
  escort setModel("fullbody_usmc_ar");
  escort scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  escort scriptmodelpauseanim(1);
  escort makeusable();
  escort setCursorHint("HINT_NOICON");
  escort setuseholdduration("duration_medium");
  escort sethintrequiresholding(1);
  escort sethintdisplayfov(120);
  escort setusefov(120);
  escort setuserange(80);
  escort setHintString(&"MP/BR_USE_PLUNDER_CACHE");
  escort setasgametypeobjective();
  escort show();
  escort.readytoextract = 0;
  escort thread extraction_escortthink();
  self.escort = escort;
  escort.encounter = self;
}

extraction_escortthink() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!self.readytoextract) {
      player extraction_playerpickupbody(self, player.team);
      continue;
    }

    thread extraction_attachfultonballoontoescort(player);
  }
}

extraction_playerpickupbody(_id_DBCE45A33308630D, team) {
  self endon("droppedBody");
  _id_DBCE45A33308630D makeunusable();
  holdingbodyhud = scripts\mp\hud_util::createfontstring("default", 1.5);
  holdingbodyhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  holdingbodyhud.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = holdingbodyhud;
  _id_DBCE45A33308630D scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  _id_DBCE45A33308630D linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  _id_123A6F38785CDF2D::playersetcarryteammates(1);

  while(!self stancebuttonPressed() || !self isonground())
    waitframe();

  extraction_dropbody(_id_DBCE45A33308630D, self, holdingbodyhud, team);
}

extraction_dropbody(_id_DBCE45A33308630D, _id_11F6008C3B0C47BF, holdingbodyhud, team) {
  if(isDefined(_id_11F6008C3B0C47BF)) {
    _id_11F6008C3B0C47BF allowads(1);
    _id_11F6008C3B0C47BF allowcrouch(1);
    _id_11F6008C3B0C47BF allowprone(1);
    _id_11F6008C3B0C47BF allowjump(1);
    _id_123A6F38785CDF2D::playersetcarryteammates(0);
  }

  if(isDefined(holdingbodyhud))
    holdingbodyhud destroy();

  if(_id_DBCE45A33308630D islinked())
    _id_DBCE45A33308630D unlink();

  origin = undefined;

  if(isDefined(_id_11F6008C3B0C47BF)) {
    _id_DBCE45A33308630D.angles = _id_11F6008C3B0C47BF.angles;
    origin = _id_11F6008C3B0C47BF.origin;
    _id_DBCE45A33308630D.origin = origin + (0, 0, 40);
  } else {
    origin = _id_DBCE45A33308630D.origin;
    _id_DBCE45A33308630D.origin = origin + (0, 0, 40);
  }

  _id_DBCE45A33308630D scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  _id_DBCE45A33308630D scriptmodelpauseanim(1);
  _id_DBCE45A33308630D.origin = origin + (0, 0, 1);
  _id_DBCE45A33308630D makeusable();

  if(_id_DBCE45A33308630D extraction_checkescortradius())
    _id_DBCE45A33308630D extraction_changeescortusefunction();

  _id_DBCE45A33308630D notify("droppedBody");
}

extraction_checkescortradius(player) {
  if(distance2d(self.origin, self.encounter.goal.origin) < 100)
    return 1;
  else
    return 0;
}

extraction_changeescortusefunction() {
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setuseholdduration("duration_long");
  self sethintrequiresholding(1);
  self setHintString(&"MP/BR_USE_PLUNDER_CACHE");
  self.readytoextract = 1;
}

extraction_attachfultonballoontoescort(player) {
  self.encounter encounter_end(1);
  self.encounter.goal delete();
  self delete();
}

destruction_encounterstart() {
  scriptables = getscriptablearray(self.target, "targetname");
  _id_023535F5A1AF3F7F = [];

  foreach(scriptable in scriptables) {
    type = scriptable.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "destroy":
        _id_023535F5A1AF3F7F[_id_023535F5A1AF3F7F.size] = scriptable;
        break;
      default:
        break;
    }
  }
}