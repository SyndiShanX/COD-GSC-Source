/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_ai_encounters.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_AB4E156ED893D713E4BE1696D7959BC6EDEAB9D12BE46E", 0);

  if(!getdvarint("_encstr_AB4E156ED893D713E4BE1696D7959BC6EDEAB9D12BE46E", 0)) {
    return;
  }
  setdvarifuninitialized("_encstr_85A21FD2BEF5E17930D9BF8B20A825BA81C51A4A08713A8D1EA0EFAFA9E3E1720B", 30);
  var_0 = spawnStruct();
  var_0 init_encounters();
  var_0 init_locations();
  var_0 thread encounter_manager();
  level.disableinitplayergameobjects = 0;
}

add_encounter_start_condition(var_0, var_1) {
  add_condition("_encstr_99D20AC53DDEA89340F4D9CA", var_0, var_1);
}

add_location_start_condition(var_0, var_1) {
  add_condition("_encstr_AC6E09881A36337B5F6F30", var_0, var_1);
}

add_condition(var_0, var_1, var_2) {
  if(!isDefined(self.startconditions[var_0]))
    self.startconditions[var_0] = [];

  var_3 = spawnStruct();
  var_3.func = var_1;
  var_3.params = var_2;
  var_4 = self.startconditions[var_0].size;
  self.startconditions[var_0][var_4] = var_3;
}

add_encounter_start_function(var_0) {
  self.func_encounterstart = var_0;
}

init_encounters() {
  self.encounters = [];
  self.allencounters = [];
  var_0 = init_encounter("_encstr_9A1F0539BDB747");
  var_0 add_encounter_start_condition(::condition_prematchdone);
  var_0 add_encounter_start_condition(::condition_mintimepassed, 60);
  var_0 add_encounter_start_condition(::condition_maxaliveplayers, 70);
  var_0 add_encounter_start_condition(::condition_maxactivelocations, 1);
  var_0 add_encounter_start_condition(::condition_lastencounterstarttime, 30);
  var_0 add_location_start_condition(::condition_stateis, 0);
  var_0 add_location_start_condition(::condition_insafecircle);
  var_0 add_encounter_start_condition(::condition_circlecount, 2);
  var_0 add_encounter_start_condition(::condition_circlesremaining, 2);
  var_0 add_location_start_condition(::condition_anyplayerinsideradius, 7500);
  var_0 add_encounter_start_function(::root_ecounterstart);
  var_1 = init_encounter("_encstr_A3100893CF304BE16959", var_0);
  var_1 add_encounter_start_function(::rootai_ecounterstart);
  var_2 = init_encounter("_encstr_9A9B055B63DD14", var_1);
  var_2 add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  var_2 add_encounter_start_function(::bank_ecounterstart);
  var_3 = init_encounter("_encstr_A60108C05863AB184BF8", var_1);
  var_3 add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  var_3 add_encounter_start_function(::airport_ecounterstart);
  var_4 = init_encounter("_encstr_ADA706A3E4BA1BB6", var_1);
  var_4 add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  var_4 add_encounter_start_function(::truck_encounterstart);
  var_5 = init_encounter("_encstr_A3910CB7DB615B35B9BFCDA14D51", var_1);
  var_5 add_location_start_condition(::condition_allplayersoutsideradius, 3000);
  var_5 add_encounter_start_function(::crateguard_encounterstart);
  var_6 = init_encounter("_encstr_AFDD05A6AB763B", var_1);
  var_6 add_location_start_condition(::condition_allplayersoutsideradius, 1000);
  var_6 add_encounter_start_condition(::condition_disabled);
  var_7 = init_encounter("_encstr_82EF0594EDAE31", var_1);
  var_7 add_encounter_start_condition(::condition_disabled);
  var_7 add_encounter_start_function(::test_ecounterstart);
  var_8 = init_encounter("_encstr_8EE60CA31A57DD1945B70D77A1EC", var_0);
  var_8 add_location_start_condition(::condition_allplayersoutsideradius, 2000);
  var_8 add_encounter_start_function(::rootnonai_ecounterstart);
  var_9 = init_encounter("_encstr_8218041DF5FA", var_8);
  var_9 add_encounter_start_function(::dom_encounterstart);
  var_10 = init_encounter("_encstr_963D0B3D97ADE0402B22F1188B", var_8);
  var_10 add_encounter_start_function(::bombplant_encounterstart);
  var_11 = init_encounter("_encstr_A3F80BB32063825899CB03DA0B", var_8);
  var_11 add_encounter_start_function(::extraction_encounterstart);
  var_11 add_encounter_start_condition(::condition_disabled);
  var_12 = init_encounter("_encstr_8FE80CC2293E5B12385FD4C16FC8", var_8);
  var_12 add_encounter_start_function(::destruction_encounterstart);
}

init_encounter(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.info = self;
  var_2.parentencounter = var_1;
  var_2.encounters = [];
  var_2.startconditions = [];
  var_2.locations = [];
  self.allencounters[var_0] = var_2;

  if(isDefined(var_1))
    var_1.encounters[var_1.encounters.size] = var_2;
  else
    self.encounters[self.encounters.size] = var_2;

  return var_2;
}

init_locations() {
  self.alllocations = [];
  self.activelocations = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_81160EE64911ABCB2B80BFF8F3D830DF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  init_location(var_2);
}

init_location(var_0) {
  var_0.name = var_0.script_noteworthy;
  var_1 = self.allencounters[var_0.name];
  var_1.locations[var_1.locations.size] = var_0;
  var_0.encounter = var_1;
  var_0.state = 0;
  var_2 = self.alllocations.size;
  self.alllocations[var_2] = var_0;
}

encounter_manager() {
  for(;;) {
    self.validlocations = [];
    update_conditions(self.encounters);

    if(self.validlocations.size) {
      var_0 = scripts\engine\utility::random(self.validlocations);
      encounter_start(var_0);
    }

    wait 0.05;
  }
}

update_conditions(var_0) {
  foreach(var_2 in var_0) {
    if(!var_2 check_encounter_start_conditions()) {
      continue;
    }
    update_conditions(var_2.encounters);

    foreach(var_4 in var_2.locations) {
      if(!var_4 check_location_start_conditions()) {
        continue;
      }
      self.validlocations[self.validlocations.size] = var_4;
    }
  }
}

check_encounter_start_conditions() {
  return check_start_conditions(self, "_encstr_99D20AC53DDEA89340F4D9CA", 0);
}

check_location_start_conditions() {
  return check_start_conditions(self.encounter, "_encstr_AC6E09881A36337B5F6F30", 1);
}

check_start_conditions(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_0.parentencounter)) {
    if(!check_start_conditions(var_0.parentencounter, var_1, var_2))
      return 0;
  }

  if(!isDefined(var_0.startconditions[var_1]))
    return 1;

  for(var_3 = 0; var_3 < var_0.startconditions[var_1].size; var_3++) {
    var_4 = var_0.startconditions[var_1][var_3];

    if(isDefined(var_4.params))
      var_5 = self[[var_4.func]](var_4.params);
    else
      var_5 = self[[var_4.func]]();

    if(!var_5)
      return 0;
  }

  return 1;
}

encounter_start(var_0) {
  var_0.state = 1;
  self.activelocations[self.activelocations.size] = var_0;
  var_0.starttime = gettime();
  encounter_location_start_functions(var_0);
}

encounter_location_start_functions(var_0) {
  var_0 encounter_start_functions(var_0.encounter);
}

encounter_start_functions(var_0) {
  if(isDefined(var_0.parentencounter))
    encounter_start_functions(var_0.parentencounter);

  if(isDefined(var_0.func_encounterstart))
    self[[var_0.func_encounterstart]]();
}

encounter_end(var_0, var_1) {
  if(var_0)
    self.state = 2;
  else
    self.state = 3;

  self.endtime = gettime();
  self.duration = self.endtime - self.starttime;
  var_2 = self.encounter.info;
  var_2.activelocations = scripts\engine\utility::array_remove(var_2.activelocations, self);
  var_2.lastencounter = self;

  if(self.usesai) {
    foreach(var_4 in self.agents) {
      if(isalive(var_4))
        var_4 suicide();
    }
  }

  self notify("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2", var_0, var_1);
}

condition_disabled(var_0) {
  return 0;
}

condition_stateis(var_0) {
  if(self.state != var_0)
    return 0;

  return 1;
}

condition_anyplayerinsideradius(var_0) {
  var_1 = var_0 * var_0;
  var_2 = sortbydistance(level.players, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 < var_1)
      return 1;
    else
      break;
  }

  return 0;
}

condition_allplayersoutsideradius(var_0) {
  var_1 = var_0 * var_0;
  var_2 = sortbydistance(level.players, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 < var_1)
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

  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_2 = distance2dsquared(self.origin, var_0);

  if(var_2 > var_1 * var_1)
    return 0;

  return 1;
}

condition_circlecount(var_0) {
  if(istrue(level.br_circle_disabled))
    return 1;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent))
    return 0;

  var_1 = getomnvar("_encstr_9561115DB4EB4CC9F56C9693B136CAF5DCBADA");

  if(var_1 < var_0)
    return 0;

  return 1;
}

condition_circlesremaining(var_0) {
  if(istrue(level.br_circle_disabled))
    return 1;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex))
    return 0;

  var_1 = level.br_level.br_circledelaytimes.size;
  var_2 = var_1 - level.br_circle.circleindex;

  if(var_2 < var_0)
    return 0;

  return 1;
}

condition_maxaliveplayers(var_0) {
  if(!isDefined(level.teamdata))
    return 0;

  var_1 = 0;

  foreach(var_3 in level.teamdata)
  var_1 = var_1 + var_3["_encstr_8A2A0B936CCCC3078547970A8B"];

  if(var_1 > var_0)
    return 0;

  return 1;
}

condition_maxactivelocations(var_0) {
  if(self.info.activelocations.size >= var_0)
    return 0;

  return 1;
}

condition_mintimepassed(var_0) {
  var_1 = scripts\mp\utility\game::getsecondspassed();

  if(var_1 < var_0)
    return 0;

  return 1;
}

condition_lastencounterstarttime(var_0) {
  var_1 = self.info;

  if(isDefined(var_1.lastencounter)) {
    var_2 = (gettime() - var_1.lastencounter.endtime) / 1000;

    if(var_2 < var_0)
      return 0;
  }

  return 1;
}

condition_prematchdone() {
  if(!isDefined(game["_encstr_B2A9066FF1CB8F67"]["_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"]))
    return 0;

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 1;

  return 0;
}

condition_debugpaused() {
  if(getdvarint("_encstr_82F318C337DDB97B2DE9C96E50B07B50EB68138E59A3CA0B5277", 0))
    return 0;

  return 1;
}

successcondition_enemykills(var_0) {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");

  for(;;) {
    self waittill("_encstr_8B0E0D2CD92B733AFAB6968DB1CA8C");

    if(self.agentskilled >= var_0)
      encounter_end(1);
  }
}

failcondition_noplayersinengagedradius(var_0) {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  var_0 = int(var_0);
  var_1 = var_0;

  for(;;) {
    wait 1;

    if(self.playersinengagedradius.size > 0) {
      var_0 = var_1;
      continue;
    }

    var_0--;

    if(var_0 <= 0)
      encounter_end(0);
  }
}

failcondition_outsidedangercircle() {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");

  for(;;) {
    wait 1;

    if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
      continue;
    }
    var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
    var_2 = distance2dsquared(self.origin, var_0);

    if(var_2 > var_1 * var_1) {
      if(self.playersinengagedradius.size > 0) {} else
        encounter_end(0);

      continue;
    }
  }
}

targetstart_spawner(var_0) {
  targetstart_spawner_init(var_0);
  var_1 = spawn_agent(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0.goalnodes)) {
      var_2 = scripts\engine\utility::random(var_0.goalnodes);
      var_1 setgoalnode(var_2);
    }

    if(isDefined(var_0.goalvolumes)) {
      var_3 = scripts\engine\utility::random(var_0.goalvolumes);

      if(var_3.auto)
        var_1 setgoalvolumeauto(var_3);
      else
        var_1 setgoalvolume(var_3);
    }
  }

  return var_1;
}

targetstart_spawner_init(var_0) {
  var_0.team = _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_ai_team();
  var_0.aitype = [[self.func_getspawneraitype]](var_0);
  var_1 = var_0 _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy)) {
      continue;
    }
    switch (var_3.script_noteworthy) {
      case "_encstr_92C50CD9ED85C6D79DDE8DAE6BAC":
        targetstart_spawner_volume(var_0, var_3, 0);
        break;
      case "_encstr_8F2E11B3DE581BF53BB736ABDACABEB0573AF6":
        targetstart_spawner_volume(var_0, var_3, 1);
        break;
      case "_encstr_883D0A3BCA6699AEF33F65ED":
      case "_encstr_8B7205D9ED5958":
        targetstart_spawner_node(var_0, var_3);
        break;
      default:
        break;
    }
  }
}

targetstart_spawner_node(var_0, var_1) {
  if(!isDefined(var_0.goalnodes))
    var_0.goalnodes = [];

  var_0.goalnodes[var_0.goalnodes.size] = var_1;
}

targetstart_spawner_volume(var_0, var_1, var_2) {
  if(!isDefined(var_0.goalvolumes))
    var_0.goalvolumes = [];

  var_1.auto = var_2;
  var_0.goalvolumes[var_0.goalvolumes.size] = var_1;
}

targetstart_icon(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(0);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_0.origin, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD", "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  objective_setshowoncompass(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_setlabel(var_1, self.iconlabel);
  thread icon_update_visibility(var_1);
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  objective_delete(var_1);
}

targetstart_reward(var_0) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2", var_1, var_2);

  if(!var_1) {
    return;
  }
  var_3 = rewardspawn(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  if(isDefined(var_2)) {
    var_4 = [];
    var_5 = [];

    foreach(var_9, var_7 in self.playersinnotifyradius) {
      var_8 = self.guidtoplayer[var_9];

      if(!isDefined(var_8)) {
        continue;
      }
      if(var_8.team == var_2) {
        var_4[var_4.size] = var_8;
        continue;
      }

      var_5[var_5.size] = var_8;
    }

    thread rewardicon(var_3, "_encstr_9BF917B41BDB9B7D770BE538ED9637D1EB57E6B1F61BD62B23", var_4);
    thread rewardicon(var_3, "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", var_5);
    rewardobjectlock(var_3, var_4, var_5);
  } else {
    var_10 = [];

    foreach(var_9, var_7 in self.playersinnotifyradius) {
      var_8 = self.guidtoplayer[var_9];

      if(!isDefined(var_8)) {
        continue;
      }
      var_10[var_10.size] = var_8;
    }

    thread rewardicon(var_3, "_encstr_9BF917B41BDB9B7D770BE538ED9637D1EB57E6B1F61BD62B23", var_10);
  }
}

targetstart_reward_prespawn(var_0) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  var_1 = rewardspawn(var_0);
  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::disablescriptableplayeruseall(var_1);
  var_2 = createnavobstaclebybounds(var_1.origin, (30, 15, 10), var_1.angles);
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2", var_3);
  destroynavobstacle(var_2);

  if(isDefined(var_1)) {
    if(var_3) {
      _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::enablescriptableplayeruseall(var_1);
      rewardicon(var_1, "_encstr_9BF917B41BDB9B7D770BE538ED9637D1EB57E6B1F61BD62B23");
    } else
      var_1 freescriptable();
  }
}

rewardspawn(var_0, var_1) {
  var_2 = var_0.script_parameters;

  if(!isDefined(var_2))
    var_2 = "_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5";

  var_3 = undefined;

  switch (var_2) {
    case "_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_0.origin + (0, 0, 0.1), var_0.angles);
      var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_2, var_4, 0, 1);
      break;
    default:
  }

  if(isDefined(var_4)) {
    thread rewardobjectusewatch(var_4);
    thread rewardobjectcleanup(var_4);
  }

  return var_4;
}

rewardobjectlock(var_0, var_1, var_2) {
  rewardobjectsetusable(var_0, var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 30));
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 makeusable();
  var_3 setHintString("_encstr_BE12116A82E588A77A25BE554D8AD789E91A2D");
  var_3 setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  var_3 setusefov(15);
  var_3 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");

  foreach(var_5 in var_1)
  var_3 disableplayeruse(var_5);

  thread rewardobjectcleanup(var_3);
  thread rewardobjectlockthink(var_3, var_0);
}

rewardobjectlockthink(var_0, var_1) {
  self endon("_encstr_8FC30FBA0370961BE536D22A594FB34BA0");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
  var_3 = var_1.scriptablename;
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::lootused(var_1, var_3, "_encstr_BE8B08E323FB2BCD6268", var_2);
}

rewardobjectusewatch(var_0) {
  self endon("_encstr_8FC30FBA0370961BE536D22A594FB34BA0");

  while(isDefined(var_0))
    waitframe();

  self notify("_encstr_8FC30FBA0370961BE536D22A594FB34BA0");
}

rewardobjectcleanup(var_0) {
  self waittill("_encstr_8FC30FBA0370961BE536D22A594FB34BA0");

  if(isDefined(var_0)) {
    if(var_0 isscriptable())
      var_0 freescriptable();
    else
      var_0 delete();
  }
}

rewardobjectsetusable(var_0, var_1) {
  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::disablescriptableplayeruseall(var_0);

  foreach(var_3 in var_1)
  var_0 enablescriptableplayeruse(var_3);
}

rewardicon(var_0, var_1, var_2) {
  var_3 = createrewardicon(var_0, var_1);

  if(var_3 < 0) {
    return;
  }
  if(isDefined(var_2)) {
    foreach(var_5 in var_2)
    objective_addclienttomask(var_3, var_5);
  }

  thread rewardiconcleanup(var_3);
}

createrewardicon(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(var_2 >= 0) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_AF5A081BBAC993AC73A3", var_0.origin + (0, 0, 50), var_1, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
    objective_setshowoncompass(var_2, 1);
    objective_setplayintro(var_2, !istrue(self.norewardiconintro));
    objective_setlabel(var_2, "_encstr_ADAB22E5328951F32F188C55C07F38B157AA4F878726F1204B70059DD87FCEE17BD1D5D9");
    objective_showtoplayersinmask(var_2);
    objective_removeallfrommask(var_2);
  }

  return var_2;
}

rewardiconcleanup(var_0) {
  self waittill("_encstr_8FC30FBA0370961BE536D22A594FB34BA0");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
}

icon_update_visibility(var_0) {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  objective_showtoplayersinmask(var_0);

  for(;;) {
    objective_removeallfrommask(var_0);

    foreach(var_4, var_2 in self.playersinnotifyradius) {
      var_3 = self.guidtoplayer[var_4];

      if(isDefined(var_3))
        objective_addclienttomask(var_0, var_3);
    }

    self waittill("_encstr_936414B8AFA9924ECB8F1189BBC8E71AE8C8FE372845");
  }
}

spawn_agent(var_0) {
  var_1 = scripts\mp\mp_agent::spawnnewagent(var_0.aitype, var_0.team, var_0.origin, var_0.angles);

  if(isDefined(var_1)) {
    var_1.recentkillcount = 0;
    var_1.recentdefendcount = 0;
    var_1.kills = 0;
    var_1.deaths = 0;
    var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
    var_1.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;
    var_1.pers["_encstr_8305198D5D93D7AD5AD8B1F5B93A9C5616D6BE33BD937DE6ABB6CA"] = 0;
    var_1.tookweaponfrom = [];
    var_1.killedplayers = [];
    var_1.guid = var_1 scripts\mp\utility\player::getuniqueid();
    var_1.script_noteworthy = var_0.script_noteworthy;
    var_1.scripted_long_deaths = 0;
    var_1.agentdamagefeedback = 1;
    self.agents[self.agents.size] = var_1;
    thread watch_agent_death(var_1);
  } else {}

  return var_1;
}

watch_agent_death(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  self.agents = scripts\engine\utility::array_remove(self.agents, var_0);
  self.agentskilled++;
  self notify("_encstr_8B0E0D2CD92B733AFAB6968DB1CA8C");
}

targetstart_spawntrigger(var_0) {
  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isagent(var_1)) {
      continue;
    }
    break;
  }

  var_2 = var_0 _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_4 in var_2)
  targetstart_spawner(var_4);
}

root_ecounterstart() {
  thread root_inittargets();
  thread root_monitorplayers();
  thread root_failconditions();
}

root_getspawneraitype(var_0) {
  return var_0.name;
}

root_inittargets() {
  self.iconlabel = "_encstr_AC4F23F89770E7B4117BB64397B98D7B950F61969CA6B379A15BB24DB9C18767A805E97865";
  waittillframeend;
  var_0 = _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(var_3)) {
      continue;
    }
    switch (var_3) {
      case "_encstr_BD3508CD07B0BB7356E4":
        thread targetstart_spawner(var_2);
        break;
      case "_encstr_860D0E536BD7B7F58991F2E15FA0FF7B":
        thread targetstart_spawntrigger(var_2);
        break;
      case "_encstr_A3C505966CBDE6":
        thread targetstart_icon(var_2);
        break;
      case "_encstr_8F9F07D3D81FB62369":
        thread targetstart_reward(var_2);
        break;
      case "_encstr_81EE10C956DD0BC919D7C12756DC0EC2EECD":
        thread targetstart_reward_prespawn(var_2);
        break;
      default:
        break;
    }
  }
}

root_monitorplayers() {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  self.notifyradius = 7500;
  self.engagedradius = 2000;
  self.playersinnotifyradius = [];
  self.playersinengagedradius = [];
  self.guidtoplayer = [];
  waittillframeend;
  var_0 = self.notifyradius * self.notifyradius;
  var_1 = self.engagedradius * self.engagedradius;
  var_2 = 20;

  for(;;) {
    var_3 = gettime();
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      var_8 = level.players[var_7];

      if(!isDefined(var_8)) {
        continue;
      }
      self.guidtoplayer[var_8.guid] = var_8;

      if(!isalive(var_8)) {
        if(isDefined(self.playersinnotifyradius[var_8.guid])) {
          var_5 = 1;
          self.playersinnotifyradius[var_8.guid] = undefined;
        }

        if(isDefined(self.playersinengagedradius[var_8.guid])) {
          var_6 = 1;
          self.playersinengagedradius[var_8.guid] = undefined;
        }

        continue;
      }

      var_9 = distance2dsquared(var_8.origin, self.origin);

      if(var_9 <= var_0) {
        if(!isDefined(self.playersinnotifyradius[var_8.guid]))
          var_5 = 1;

        self.playersinnotifyradius[var_8.guid] = var_3;
      } else {
        var_10 = self.playersinnotifyradius[var_8.guid];

        if(isDefined(var_10) && var_3 - var_10 > 2000) {
          var_5 = 1;
          self.playersinnotifyradius[var_8.guid] = undefined;
        }
      }

      if(var_9 <= var_1) {
        if(!isDefined(self.playersinengagedradius[var_8.guid]))
          var_6 = 1;

        self.playersinengagedradius[var_8.guid] = var_3;
      } else {
        var_10 = self.playersinengagedradius[var_8.guid];

        if(isDefined(var_10) && var_3 - var_10 > 2000) {
          var_6 = 1;
          self.playersinengagedradius[var_8.guid] = undefined;
        }
      }

      var_4++;

      if(var_4 >= var_2) {
        wait 0.05;
        var_4 = 0;
      }
    }

    if(var_5)
      self notify("_encstr_936414B8AFA9924ECB8F1189BBC8E71AE8C8FE372845");

    if(var_6)
      self notify("_encstr_8366158F2877530489F531DBA3A6417177D013454F9531");

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
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  self.func_getspawneraitype = ::bank_getspawneraitype;
  self.iconlabel = "_encstr_8FE920A0CF288FDC6913EEEB2F1155837DA7C9FEF40E6B810903DAF551196E1F103C";
  thread alarm_sound_on();
  thread alarm_sound_off_encounter_end();
  thread vault_door_think();
  var_0 = getEnt("_encstr_9A010C90921D5F664BF7A908807E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_A56B12CBFF70B82F6C3850397A9A999531205732", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.wave1_enemies = [];
  var_2 = scripts\engine\utility::getStructArray("_encstr_A17E0EBD35A22D526F48CF73FD7E23BA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    var_5 = targetstart_spawner(var_4);

    if(var_5.script_noteworthy == "_encstr_8B7D0D04627305B1E32FD56BE00A9B") {
      var_5 setgoalvolumeauto(var_1);
      var_5.goalheight = 256;
    } else if(var_5.script_noteworthy == "_encstr_88870DBB169DCA06267D8DF6772B4E")
      var_5 setgoalvolumeauto(var_0);

    level.wave1_enemies = scripts\engine\utility::array_add(level.wave1_enemies, var_5);
  }

  var_7 = getEnt("_encstr_913E1527FF83DF9121B2C1DA90D392CB5BD087BC8E880F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  waittill_trigger_or_dead(var_7, level.wave1_enemies, level.wave1_enemies.size - 3);
  level notify("_encstr_ABA10CC3AB2F1CD049EF5365E5FA");
  var_8 = getEnt("_encstr_A5010C1316DC5B7DD97B8DF581C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = [];
  var_10 = scripts\engine\utility::getStructArray("_encstr_8F7E0E25EA9A40A96FDB989461E812D6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_12 in var_10) {
    var_5 = targetstart_spawner(var_12);
    var_5 setgoalvolumeauto(var_8);
    var_9 = scripts\engine\utility::array_add(var_9, var_5);
  }

  foreach(var_15 in level.wave1_enemies) {
    if(isDefined(var_15) && isalive(var_15)) {
      var_15 setgoalvolumeauto(var_8);
      var_9 = scripts\engine\utility::array_add(var_9, var_15);
    }
  }

  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::waittill_dead(var_9, var_9.size);
  wait 0.5;
  self notify("_encstr_87B60BE0127560B87BA7C3E9EB");
  var_17 = getEnt("_encstr_8D010C9858B95B7D9DB7B1D76033", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_18 = [];
  var_19 = scripts\engine\utility::getStruct("_encstr_92C21359CD95D65ED7EE2CCE2BEB0666FA13BD9B37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_20 = targetstart_spawner(var_19);
  var_20 thread jug_behavior();
  var_18 = scripts\engine\utility::array_add(var_18, var_20);
  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::waittill_dead(var_18, var_18.size);
  encounter_end(1);
}

vault_door_open_wait() {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  self waittill("_encstr_87B60BE0127560B87BA7C3E9EB");
}

vault_door_init(var_0) {
  if(istrue(var_0.init)) {
    var_0.angles = var_0.start_angles;
    return;
  }

  var_1 = getEnt("_encstr_A9EC109337FB703CEFB7C7EFDAEF102920C3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 linkTo(var_0);
  var_0.start_angles = var_0.angles;
  var_0.init = 1;
}

vault_door_think() {
  var_0 = getEnt("_encstr_812A0B0396A5B0ED2973372F33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  vault_door_init(var_0);
  vault_door_open_wait();
  var_0 thread vault_door_sound();
  var_0 rotateby((0, 180, 0), 5);
}

jug_behavior() {
  var_0 = sortbydistance(level.players, self.origin);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isalive(var_2)) {
      self getenemyinfo(var_2);
      self setgoalentity(var_2);
      break;
    }
  }
}

alarm_sound_on() {
  var_0 = getEntArray("_encstr_AD450FBA28D847A8FFE4BB6B1A0883F863", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 playLoopSound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
}

alarm_sound_off() {
  var_0 = getEntArray("_encstr_AD450FBA28D847A8FFE4BB6B1A0883F863", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 stoploopsound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
}

vault_door_sound() {
  var_0 = 4000000;

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isalive(var_2)) {
      if(distancesquared(var_2.origin, self.origin) <= var_0)
        var_2 playSound("_encstr_BAE2136C07D79816B95BF5EC85EA8D3AF57B38CACD");
    }
  }
}

waittill_trigger_or_dead(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 endon("_encstr_8267056410C669");
  var_4 childthread _waittill_trigger(var_0);
  var_4 childthread _waittill_dead_notify_done(var_1, var_2, var_3);
  var_4 waittill("_encstr_8267056410C669");
}

_waittill_dead_notify_done(var_0, var_1, var_2) {
  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::waittill_dead(var_0, var_1, var_2);
  self notify("_encstr_8267056410C669");
}

_waittill_trigger(var_0) {
  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    break;
  }

  self notify("_encstr_8267056410C669");
}

alarm_sound_off_encounter_end() {
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  alarm_sound_off();
}

bank_getspawneraitype(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "_encstr_AFDD05A6AB763B":
        return "_encstr_A5BD1A960E3BEF0AE1CDC6590B43504EE38F3B20028FD0B350AB23D8";
      default:
        break;
    }
  }

  return "_encstr_857114C28DA3DBE4BE2BDC56B6CBBE26397D4C0B6E95";
}

airport_ecounterstart() {
  var_0 = getEnt("_encstr_8E5E13B0D2EB2BB91B7BABDC1D2B9CAFC627581D2B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 movez(256, 0.05);
  wait 0.5;
  createnavobstaclebyent(var_0);
  var_1 = getEnt("_encstr_8F6F1AD6A5C65BDECC997D85A5E4E0B74E1D7DB2E6D8DBAEB9D1CA93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
  var_3 = "_encstr_8823119675DAFF897F878020BB99612B219D8F";
  var_4 = magicgrenademanual(var_3, scripts\engine\utility::getStruct("_encstr_998717855A27C17B4E1D7DE65BBD5BACD7A3F637DCFA387B9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, anglesToForward(scripts\engine\utility::getStruct("_encstr_998717855A27C17B4E1D7DE65BBD5BACD7A3F637DCFA387B9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles) * 400, 1);
  wait 0.1;
  var_5 = magicgrenademanual(var_3, scripts\engine\utility::getStruct("_encstr_A2611A3F9AF3097A83F9B9DAA1875AA89F54FFD8C6075095CED1977F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, anglesToForward(scripts\engine\utility::getStruct("_encstr_A2611A3F9AF3097A83F9B9DAA1875AA89F54FFD8C6075095CED1977F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles) * 400, 1.3);
  var_6 = magicgrenademanual(var_3, scripts\engine\utility::getStruct("_encstr_95611A58B44E0EBD278EF59BB6B7D656BE3ADE37DCD7C1DBB9F50C33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, anglesToForward(scripts\engine\utility::getStruct("_encstr_95611A58B44E0EBD278EF59BB6B7D656BE3ADE37DCD7C1DBB9F50C33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles) * 450, 2);
  var_7 = getEnt("_encstr_84170FF143938A27A62B59D350F1AFD262", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 2;
  var_8 = [];
  var_9 = scripts\engine\utility::getStructArray("_encstr_B1BD1656871BBBC7EE93C9021E6FC0DB71831FA5EFB9F7F3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_11 in var_9) {
    var_12 = targetstart_spawner(var_11);
    var_12 setgoalvolumeauto(var_7);
    var_12 thread airport_enemy_setup();
    var_8 = scripts\engine\utility::array_add(var_8, var_12);
  }

  var_14 = getEnt("_encstr_913E1527FF83DF9121B2C1DA90D392CB5BD087BC8E880F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::waittill_dead(var_8, var_8.size);
  encounter_end(1);
}

airport_enemy_setup() {
  self.ignore_all = 1;
  wait(randomfloatrange(1, 2));
  self.ignore_all = 0;
  self.accuracy = 0.01;
}

truck_encounterstart() {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  self.func_getspawneraitype = ::truck_getspawneraitype;
  self.iconlabel = "_encstr_9B252190FF18BFEC39439E9B7F416553AD5719CEA47E5B51F9338AA561E93B03CDED10";
  thread failcondition_noplayersinengagedradius(90);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  var_3 = [];
  var_4 = _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_6 in var_4) {
    var_7 = var_6.script_noteworthy;

    if(!isDefined(var_7)) {
      continue;
    }
    switch (var_7) {
      case "_encstr_AA760E6EE80B93E8FA1D274BD9B3CAE4":
        var_0 = var_6;
        break;
      case "_encstr_A50311A327EA1BAD7D2BCD566BE5D7DDB0EC2B":
        var_2[var_2.size] = var_6;
        break;
      case "_encstr_9BA60AF0DF0CD0E71295F006":
        var_1 = var_6;
        thread truck_roll_door_init(var_1);
        break;
      case "_encstr_B6B70FA9576BE0AF19DEBB9BEB73ED23B2":
        var_3[var_3.size] = var_6;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_9);

    if(isalive(var_9) && isPlayer(var_9)) {
      break;
    }
  }

  destroynavobstacle(var_1 getentitynumber());
  truck_roll_door_open(var_1);
  var_10 = [];

  foreach(var_12 in var_2) {
    var_13 = targetstart_spawner(var_12);
    var_10 = scripts\engine\utility::array_add(var_10, var_13);
  }

  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::waittill_dead(var_10, var_10.size);
  encounter_end(1);
}

truck_roll_door_init(var_0) {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");

  if(!istrue(var_0.init)) {
    var_0.angle_ref = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_0.angle_ref.angles))
      var_0.angle_ref.angles = (0, 0, 0);

    var_0.start_origin = var_0.origin;
    var_0.start_angles = var_0.angles;
    var_0.init = 1;
  } else {
    var_0.origin = var_0.start_origin;
    var_0.angles = var_0.start_angles;
  }
}

truck_roll_door_open(var_0) {
  var_0 rotatepitch(-90, 1);
  truck_roll_door_sound(var_0);
  self notify("_encstr_BA9B150176782310C7489873938181A2F2E3C79F53534D");
}

truck_roll_door_sound(var_0) {
  var_1 = 1000000;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(distancesquared(var_3.origin, var_0.origin) <= var_1)
        var_3 playSound("_encstr_A1C712E633C15A2218FF5F87D33DAAAFD0F9DDAD");
    }
  }
}

truck_getspawneraitype(var_0) {
  return "_encstr_857114C28DA3DBE4BE2BDC56B6CBBE26397D4C0B6E95";
}

crateguard_encounterstart() {
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  self.func_getspawneraitype = ::crateguard_getspawneraitype;
  self.iconlabel = "_encstr_812F27855A8FD97329F77577C75128B96DA22FB0B53AD93070CF657323D9E6F1C18B15362F75494EC8";
  thread failcondition_noplayersinengagedradius(90);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  var_3 = _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_5 in var_3) {
    var_6 = var_5.script_noteworthy;

    if(!isDefined(var_6)) {
      continue;
    }
    switch (var_6) {
      case "_encstr_AF2206AF7DE90BA7":
        var_2[var_2.size] = var_5;
        break;
      case "_encstr_8C120B97E3B7236401B9353AB3":
        var_1 = var_5;
        break;
      case "_encstr_AA760E6EE80B93E8FA1D274BD9B3CAE4":
        var_0 = var_5;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_8);

    if(isalive(var_8) && isPlayer(var_8)) {
      break;
    }
  }

  var_9 = [];

  foreach(var_11 in var_2) {
    var_12 = targetstart_spawner(var_11);
    var_9[var_9.size] = var_12;
  }

  var_14 = targetstart_spawner(var_1);
  var_9[var_9.size] = var_14;
  childthread crateguard_bosssetup(var_14, var_9);
  _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::waittill_dead(var_9, var_9.size);
  encounter_end(1);
}

crateguard_bosssetup(var_0, var_1) {
  var_0.ignoreall = 1;
  var_2 = var_1;
  var_2[var_2.size] = var_0;
  scripts\engine\utility::waittill_any_ents_array(var_2, "_encstr_AD75063D571AE108", "_encstr_B2BE0788BAF573592F", "_encstr_88BF06FD784A6393");

  if(isDefined(var_0))
    var_0.ignoreall = 0;
}

crateguard_getspawneraitype(var_0) {
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_8C120B97E3B7236401B9353AB3")
    return "_encstr_9671143FA033AFE3777D4D875103096A5BD9BBFFC80B";

  return "_encstr_857114C28DA3DBE4BE2BDC56B6CBBE26397D4C0B6E95";
}

smoking() {
  setup_anim_guy();
  self.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
  self.deathalias = "_encstr_B13D0E7BD370D4B720F1D16A998F9B4C";
  thread smoking_idle("_encstr_A2CB0D9B5BDE6DD2739DF55A32C62B");
  thread smoking_react("_encstr_A6E40EE01D3FFA1848A7D0B37F28BF03");
  thread smoking_death("_encstr_B13D0E7BD370D4B720F1D16A998F9B4C");
}

smoking_idle(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2BE0788BAF573592F");
  thread ai_notetrack_loop("_encstr_8F2E08B9DADBDA9637B3");

  for(;;) {
    smoking_idle_start("_encstr_9278139783E0E23938A9E96CA1407DF94619671B29");
    scripts\asm\shared\mp\utility::burndowntime(var_0);
    smoking_idle_end("_encstr_A7DE1192197F10CFDEA7E00BC5FC1DF7F30228");
  }
}

smoking_idle_start(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2BE0788BAF573592F");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

smoking_idle_end(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2BE0788BAF573592F");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

smoking_react(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B2BE0788BAF573592F");
  ai_smoking_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self);
}

smoking_death(var_0) {
  self endon("_encstr_B2BE0788BAF573592F");
  self waittill("_encstr_AD75063D571AE108");
  ai_smoking_cleanup();
}

ai_notehandler_smoking(var_0) {
  switch (var_0) {
    case "_encstr_A19A077135838FDED1":
      playFXOnTag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      break;
    case "_encstr_8FA906CC80677438":
      playFXOnTag(level.g_effect["_encstr_AFD40E33339FC96BA2953B0BA1A818F3"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      stopFXOnTag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      playFX(level.g_effect["_encstr_881A0DC6B4B3343A2B277D9D36EDDD"], self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"));
      thread ai_smoking_blowsmoke();
      break;
    case "_encstr_A1A107973D7982FB90":
      stopFXOnTag(level.g_effect["_encstr_AFD40E33339FC96BA2953B0BA1A818F3"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      stopFXOnTag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      playFX(level.g_effect["_encstr_88F913764BD7E813A959859AF04C87A8971B87B2FF"], self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"), anglesToForward(self gettagangles("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5")));
      break;
  }
}

ai_smoking_blowsmoke() {
  self endon("_encstr_BD9E0CFF517A028B22D7B9B1DBE8");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_B2BE0788BAF573592F");

  for(;;) {
    playFX(level.g_effect["_encstr_91A41017B917C0FE57FB3B01515739F8AC0D"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("_encstr_A130084D2FDAD8AA8F62")));
    var_0 = randomintrange(5, 8);
    wait(var_0);
  }
}

ai_smoking_cleanup() {
  self notify("_encstr_BD9E0CFF517A028B22D7B9B1DBE8");
  self endon("_encstr_AD75063D571AE108");

  if(scripts\engine\utility::hastag(self.model, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5")) {
    killfxontag(level.g_effect["_encstr_AFD40E33339FC96BA2953B0BA1A818F3"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
    killfxontag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
  }
}

standing_cellphone(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  setup_anim_guy();
  self.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
  self.deathalias = "_encstr_826616739DC908BC212611B3FB13CCBFCDB5B1ECF26F1CBA";
  thread ai_notetrack_loop("_encstr_8C78135ABD4B6AF4B8E83FD7A811A41201DB2595AD");
  standing_cellphone_anim("_encstr_B1EA169F034E48A01FEAD361224A78BDF573C95CBD246E5F");

  if(var_0 > 0)
    standing_cellphone_loop("_encstr_837315DCA3C273C8BEC6CA8D8D8334DBCD957DB1B7F61C", var_0);

  standing_cellphone_anim("_encstr_822515E6434A85D90FC76858835810CFE2AF4865D82249");
}

standing_cellphone_anim(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2BE0788BAF573592F");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

standing_cellphone_loop(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2BE0788BAF573592F");
  scripts\asm\shared\mp\utility::bunkeropened(var_0, var_1);
}

ai_notehandler_cellphone(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2BE0788BAF573592F");

  switch (var_0) {
    case "_encstr_A19A077135838FDED1":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("_encstr_916E21ED6B20D453213142EB5E875F4A782F6E71F9C99AEFDFCBDBB3C050BB47C13949", "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      wait 2;
      break;
    case "_encstr_A1A107973D7982FB90":
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

reset_guy(var_0) {
  var_0 allowedstances("_encstr_922406F1A6FD5E05", "_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
  var_0.playing_skit = undefined;

  if(isDefined(self.anchor))
    self.anchor delete();
}

ai_notetrack_loop(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_B2BE0788BAF573592F");

  for(;;) {
    self waittill("_encstr_84610D49100897C2DF809A03583BFF", var_1);

    if(!isDefined(var_1))
      var_1 = ["_encstr_8C500ABA9B23CACC2D37AC8C"];

    if(!isarray(var_1))
      var_1 = [var_1];

    var_2 = undefined;

    foreach(var_4 in var_1) {
      if(var_0 == "_encstr_8F2E08B9DADBDA9637B3") {
        ai_notehandler_smoking(var_4);
        continue;
      }

      if(var_0 == "_encstr_8C78135ABD4B6AF4B8E83FD7A811A41201DB2595AD")
        ai_notehandler_cellphone(var_4);
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
  var_0 = undefined;
  var_1 = _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_3 in var_1) {
    var_4 = var_3.script_noteworthy;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "_encstr_956B0F193B6244C0659AE65B464C78857B":
        var_5 = 315;
        var_6 = 120;
        var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin, 0, int(var_5), int(var_6));
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  level.setdomscriptablepartstatefunc = ::domencounter_setdomscriptablepartstate;
  var_8 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_0);
  var_8.noscriptable = undefined;
  var_8.vfxnamemod = "_encstr_A64505BE660C06";
  var_8.onuse = ::domencounter_onuse;
  var_8.onuseupdate = ::domencounter_onuseupdate;
  var_8.onenduse = ::domencounter_onenduse;
  var_8 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_8 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
  level.flagcapturetime = getdvarint("_encstr_85A21FD2BEF5E17930D9BF8B20A825BA81C51A4A08713A8D1EA0EFAFA9E3E1720B", 30);
  var_8 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_8.encounterlocation = self;
  thread encounterdeletedomgameobjectonend(var_8);
  thread icon_update_visibility(var_8.objidnum);
}

encounterdeletedomgameobjectonend(var_0) {
  var_0 endon("_encstr_8BE208E31FA8E1631D65");
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");

  foreach(var_2 in var_0.visuals)
  var_2 delete();

  if(isDefined(var_0.flagmodel))
    var_0.flagmodel delete();

  if(isDefined(var_0.scriptable))
    var_0.scriptable delete();

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
    var_0.trigger = undefined;
  }

  var_0 thread gameobjectreleaseid_delayed();
  var_0 notify("_encstr_8BE208E31FA8E1631D65");
}

gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

domencounter_icons() {
  level.iconneutral = "_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992";
  level.iconcapture = "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6";
  level.icondefend = "_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E";
  level.icondefending = "_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9";
  level.iconcontested = "_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B";
  level.icontaking = "_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA";
  level.iconlosing = "_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39";
  _setdomencountericoninfo("_encstr_8B99155A36DB9BD7DDC2970E7B2DE63AAF19BDB5FA2693", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", 0);
  _setdomencountericoninfo("_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", 1);
  _setdomencountericoninfo("_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6", "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", 0);
  _setdomencountericoninfo("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", 0);
  _setdomencountericoninfo("_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", 0);
  _setdomencountericoninfo("_encstr_A2D015BBB0BCC1DB5AE647D713C6DBD8B6B4DC3BD789E4", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", 0);
  _setdomencountericoninfo("_encstr_966014DF178A63454BE0CB7168A9BDD7208D547F3EB3", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", 0);
  _setdomencountericoninfo("_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", 1);
  _setdomencountericoninfo("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", 0);
  _setdomencountericoninfo("_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", 1);
  _setdomencountericoninfo("_encstr_81A5177FCBC012AFA3D063D9B988FF81C0B3F2F76B101153D6", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", 0);
  _setdomencountericoninfo("_encstr_8C4418A5D8BDCDF5DD58CB387BA5E647BED12C39D9CAA3FA9839", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", 0);
}

_setdomencountericoninfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 0;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1";
  level.waypointpulses[var_0] = var_3;
}

domencounter_onuseupdate(var_0, var_1, var_2, var_3) {
  if(var_1 > 0.05 && var_2 && !self.didstatusnotify)
    self.didstatusnotify = 1;
}

domencounter_onuse(var_0) {
  self.encounterlocation encounter_end(1, var_0.team);
}

domencounter_onenduse(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

domencounter_setdomscriptablepartstate(var_0, var_1, var_2) {
  switch (var_1) {
    case "_encstr_B85C0AD87B9B8E95CD8E2B46":
    case "_encstr_A7C5056BD931D1":
    case "_encstr_BA19049F4B2D":
      return 0;
    default:
      var_1 = "_encstr_8F7106EACDD273CE";

      if(isDefined(var_2))
        var_1 = var_1 + var_2;

      self.scriptable setscriptablepartstate(var_0, var_1);

      if(var_0 == "_encstr_8A0C06B1E08832D3")
        self.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", var_1);

      return 1;
  }
}

bombplant_encounterstart() {}

extraction_encounterstart() {
  iprintlnbold("_encstr_9AFB11B5994B3E19DE5C9367BEEE41E5C7912F");
  var_0 = _encstr_8C682FABF20B0B38ABC3F77BE845B8C7DF0AC3122B8FBE8A46BA0F5BE9B160189F027B78D3E776B0D195514304B5285E37::get_targets();

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(var_3)) {
      continue;
    }
    switch (var_3) {
      case "_encstr_882E0BABDC597DDE98A9B26C1D":
        extraction_createescort(var_2);
        break;
      case "_encstr_8B7205D9ED5958":
        targetstart_extractiongoal(var_2);
        break;
      default:
        break;
    }
  }
}

targetstart_extractiongoal(var_0) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 20));
  var_1 setModel("_encstr_A2931336D1CCBEB3585B2BEB661B8576EB95C237A3");
  self.goal = var_1;
  var_1.encounter = self;
}

extraction_createescort(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 20));
  var_1 setModel("_encstr_967A1199571BD84CF6195EEB57DC5B6CEB0B4E");
  var_1 scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
  var_1 scriptmodelpauseanim(1);
  var_1 makeusable();
  var_1 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_1 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_1 sethintrequiresholding(1);
  var_1 sethintdisplayfov(120);
  var_1 setusefov(120);
  var_1 setuserange(80);
  var_1 setHintString(&"_encstr_8A5F18892A478A49C12FEF21413F0D01D8C14F367E86391F6311");
  var_1 setasgametypeobjective();
  var_1 show();
  var_1.readytoextract = 0;
  var_1 thread extraction_escortthink();
  self.escort = var_1;
  var_1.encounter = self;
}

extraction_escortthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!self.readytoextract) {
      var_0 extraction_playerpickupbody(self, var_0.team);
      continue;
    }

    thread extraction_attachfultonballoontoescort(var_0);
  }
}

extraction_playerpickupbody(var_0, var_1) {
  self endon("_encstr_97120C8C397B1CC1598C90F691BC");
  var_0 makeunusable();
  var_2 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, 120);
  var_2.label = &"_encstr_8E9F133514CB2492FA942A6A14827527BE84F48856";
  self.holdingbodyhud = var_2;
  var_0 scriptmodelplayanim("_encstr_86C91C87817EB123B8DE34FD73B0698A5D5F0F47692A791018232B46E9C0");
  var_0 linkTo(self, "_encstr_B4DF0E4DFAC663163BD21B1B59AFB12B", (0, 0, 0), (0, 0, 0));
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::playersetcarryteammates(1);

  while(!self stancebuttonPressed() || !self isonground())
    waitframe();

  extraction_dropbody(var_0, self, var_2, var_1);
}

extraction_dropbody(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowjump(1);
    _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::playersetcarryteammates(0);
  }

  if(isDefined(var_2))
    var_2 destroy();

  if(var_0 islinked())
    var_0 unlink();

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_0.angles = var_1.angles;
    var_4 = var_1.origin;
    var_0.origin = var_4 + (0, 0, 40);
  } else {
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, 40);
  }

  var_0 scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
  var_0 scriptmodelpauseanim(1);
  var_0.origin = var_4 + (0, 0, 1);
  var_0 makeusable();

  if(var_0 extraction_checkescortradius())
    var_0 extraction_changeescortusefunction();

  var_0 notify("_encstr_97120C8C397B1CC1598C90F691BC");
}

extraction_checkescortradius(var_0) {
  if(distance2d(self.origin, self.encounter.goal.origin) < 100)
    return 1;
  else
    return 0;
}

extraction_changeescortusefunction() {
  self makeusable();
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  self sethintrequiresholding(1);
  self setHintString(&"_encstr_8A5F18892A478A49C12FEF21413F0D01D8C14F367E86391F6311");
  self.readytoextract = 1;
}

extraction_attachfultonballoontoescort(var_0) {
  self.encounter encounter_end(1);
  self.encounter.goal delete();
  self delete();
}

destruction_encounterstart() {
  var_0 = getscriptablearray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.script_noteworthy;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "_encstr_AFCB082AC1D6A3EA7B73":
        var_1[var_1.size] = var_3;
        break;
      default:
        break;
    }
  }
}