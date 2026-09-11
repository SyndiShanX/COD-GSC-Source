/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters.gsc
*****************************************************/

function init() {
  setdvarifuninitialized("scr_br_ai_encounters", 0);

  if(!getdvarint("scr_br_ai_encounters", 0)) {
    return;
  }

  setdvarifuninitialized("scr_ai_encounters_dom_use_time", 30);
  var_0 = spawnStruct();
  init_encounters(var_0);
  init_locations(var_0);
  thread encounter_manager();
  level.disableinitplayergameobjects = 0;
}

function add_encounter_start_condition(var_0, var_1) {
  add_condition("encounter", var_0, var_1);
}

function add_location_start_condition(var_0, var_1) {
  add_condition("location", var_0, var_1);
}

function add_condition(var_0, var_1, var_2) {
  if(!isDefined(self.startconditions[var_0])) {
    self.startconditions[var_0] = [];
  }

  var_3 = spawnStruct();
  var_3.func = var_1;
  var_3.params = var_2;
  var_4 = self.startconditions[var_0].size;
  self.startconditions[var_0][var_4] = var_3;
}

function add_encounter_start_function(var_0) {
  self.func_encounterstart = var_0;
}

function init_encounters() {
  self.encounters = [];
  self.allencounters = [];
  var_0 = init_encounter("root");
  add_encounter_start_condition(var_0, &condition_prematchdone);
  add_encounter_start_condition(var_0, &condition_mintimepassed, 60);
  add_encounter_start_condition(var_0, &condition_maxaliveplayers, 70);
  add_encounter_start_condition(var_0, &condition_maxactivelocations, 1);
  add_encounter_start_condition(var_0, &condition_lastencounterstarttime, 30);
  add_location_start_condition(var_0, &condition_stateis, 0);
  add_location_start_condition(var_0, &condition_insafecircle);
  add_encounter_start_condition(var_0, &condition_circlecount, 2);
  add_encounter_start_condition(var_0, &condition_circlesremaining, 2);
  add_location_start_condition(var_0, &condition_anyplayerinsideradius, 7500);
  add_encounter_start_function(var_0, &root_ecounterstart);
  var_1 = init_encounter("root_ai", var_0);
  add_encounter_start_function(var_1, &rootai_ecounterstart);
  var_2 = init_encounter("bank", var_1);
  add_location_start_condition(var_2, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var_2, &bank_ecounterstart);
  var_3 = init_encounter("airport", var_1);
  add_location_start_condition(var_3, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var_3, &airport_ecounterstart);
  var_4 = init_encounter("truck", var_1);
  add_location_start_condition(var_4, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var_4, &truck_encounterstart);
  var_5 = init_encounter("crate_guard", var_1);
  add_location_start_condition(var_5, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var_5, &crateguard_encounterstart);
  var_6 = init_encounter("jugg", var_1);
  add_location_start_condition(var_6, &condition_allplayersoutsideradius, 1000);
  add_encounter_start_condition(var_6, &condition_disabled);
  var_7 = init_encounter("test", var_1);
  add_encounter_start_condition(var_7, &condition_disabled);
  add_encounter_start_function(var_7, &test_ecounterstart);
  var_8 = init_encounter("root_non_ai", var_0);
  add_location_start_condition(var_8, &condition_allplayersoutsideradius, 2000);
  add_encounter_start_function(var_8, &rootnonai_ecounterstart);
  var_9 = init_encounter("dom", var_8);
  add_encounter_start_function(var_9, &dom_encounterstart);
  var_10 = init_encounter("bomb_plant", var_8);
  add_encounter_start_function(var_10, &bombplant_encounterstart);
  var_11 = init_encounter("extraction", var_8);
  add_encounter_start_function(var_11, &extraction_encounterstart);
  add_encounter_start_condition(var_11, &condition_disabled);
  var_12 = init_encounter("destruction", var_8);
  add_encounter_start_function(var_12, &destruction_encounterstart);
}

function init_encounter(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.info = self;
  var_2.parentencounter = var_1;
  var_2.encounters = [];
  var_2.startconditions = [];
  var_2.locations = [];
  self.allencounters[var_0] = var_2;

  if(isDefined(var_1)) {
    var_1.encounters[var_1.encounters.size] = var_2;
  } else {
    self.encounters[self.encounters.size] = var_2;
  }

  return var_2;
}

function init_locations() {
  self.alllocations = [];
  self.activelocations = [];
  var_0 = scripts\engine\utility::getStructArray("ai_encounters", "targetname");

  foreach(var_2 in var_0) {
    init_location(var_2);
  }
}

function init_location(var_0) {
  var_0.name = var_0.script_noteworthy;
  var_1 = self.allencounters[var_0.name];
  var_1.locations[var_1.locations.size] = var_0;
  var_0.encounter = var_1;
  var_0.state = 0;
  var_2 = self.alllocations.size;
  self.alllocations[var_2] = var_0;
}

function encounter_manager() {
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

function update_conditions(var_0) {
  foreach(var_2 in var_0) {
    if(!check_encounter_start_conditions(var_2)) {
      continue;
    }

    update_conditions(var_2.encounters);

    foreach(var_4 in var_2.locations) {
      if(!check_location_start_conditions(var_4)) {
        continue;
      }

      self.validlocations[self.validlocations.size] = var_4;
    }
  }
}

function check_encounter_start_conditions() {
  return check_start_conditions(self, "encounter", 0);
}

function check_location_start_conditions() {
  return check_start_conditions(self.encounter, "location", 1);
}

function check_start_conditions(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_0.parentencounter)) {
    if(!check_start_conditions(var_0.parentencounter, var_1, var_2)) {
      return false;
    }
  }

  if(!isDefined(var_0.startconditions[var_1])) {
    return true;
  }

  for(var_3 = 0; var_3 < var_0.startconditions[var_1].size; var_3++) {
    var_4 = var_0.startconditions[var_1][var_3];

    if(isDefined(var_4.params)) {
      var_5 = self[[var_4.func]](var_4.params);
    } else {
      var_5 = self[[var_4.func]]();
    }

    if(!var_5) {
      return false;
    }
  }

  return true;
}

function encounter_start(var_0) {
  var_0.state = 1;
  self.activelocations[self.activelocations.size] = var_0;
  var_0.starttime = gettime();
  encounter_location_start_functions(var_0);
}

function encounter_location_start_functions(var_0) {
  encounter_start_functions(var_0, var_0.encounter);
}

function encounter_start_functions(var_0) {
  if(isDefined(var_0.parentencounter)) {
    encounter_start_functions(var_0.parentencounter);
  }

  if(isDefined(var_0.func_encounterstart)) {
    self[[var_0.func_encounterstart]]();
    return;
  }
}

function encounter_end(var_0, var_1) {
  if(var_0) {
    self.state = 2;
  } else {
    self.state = 3;
  }

  self.endtime = gettime();
  self.duration = self.endtime - self.starttime;
  var_2 = self.encounter.info;
  var_2.activelocations = scripts\engine\utility::array_remove(var_2.activelocations, self);
  var_2.lastencounter = self;

  if(self.usesai) {
    foreach(var_4 in self.agents) {
      if(isalive(var_4)) {
        var_4 suicide();
      }
    }
  }

  self notify("encounter_end", var_0, var_1);
}

function condition_disabled(var_0) {
  return false;
}

function condition_stateis(var_0) {
  if(self.state != var_0) {
    return false;
  }

  return true;
}

function condition_anyplayerinsideradius(var_0) {
  var_1 = var_0 * var_0;
  var_2 = sortbydistance(level.players, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }

    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 < var_1) {
      return true;
    }

    break;
  }

  return false;
}

function condition_allplayersoutsideradius(var_0) {
  var_1 = var_0 * var_0;
  var_2 = sortbydistance(level.players, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }

    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 < var_1) {
      return false;
    }

    break;
  }

  return true;
}

function condition_insafecircle() {
  if(istrue(level.br_circle_disabled)) {
    return true;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
    return false;
  }

  var_0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_2 = distance2dsquared(self.origin, var_0);

  if(var_2 > var_1 * var_1) {
    return false;
  }

  return true;
}

function condition_circlecount(var_0) {
  if(istrue(level.br_circle_disabled)) {
    return true;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
    return false;
  }

  var_1 = getomnvar("ui_br_circle_num");

  if(var_1 < var_0) {
    return false;
  }

  return true;
}

function condition_circlesremaining(var_0) {
  if(istrue(level.br_circle_disabled)) {
    return true;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex)) {
    return false;
  }

  var_1 = level.br_level.br_circledelaytimes.size;
  var_2 = var_1 - level.br_circle.circleindex;

  if(var_2 < var_0) {
    return false;
  }

  return true;
}

function condition_maxaliveplayers(var_0) {
  if(!isDefined(level.teamdata)) {
    return false;
  }

  var_1 = 0;

  foreach(var_3 in level.teamdata) {
    var_1 += var_3["aliveCount"];
  }

  if(var_1 > var_0) {
    return false;
  }

  return true;
}

function condition_maxactivelocations(var_0) {
  if(self.info.activelocations.size >= var_0) {
    return false;
  }

  return true;
}

function condition_mintimepassed(var_0) {
  var_1 = scripts\mp\utility\game::getsecondspassed();

  if(var_1 < var_0) {
    return false;
  }

  return true;
}

function condition_lastencounterstarttime(var_0) {
  var_1 = self.info;

  if(isDefined(var_1.lastencounter)) {
    var_2 = (gettime() - var_1.lastencounter.endtime) / 1000;

    if(var_2 < var_0) {
      return false;
    }
  }

  return true;
}

function condition_prematchdone() {
  if(!isDefined(game["flags"]["prematch_done"])) {
    return false;
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return true;
  }

  return false;
}

function condition_debugpaused() {
  if(getdvarint("scr_ai_encounters_pause", 0)) {
    return false;
  }

  return true;
}

function successcondition_enemykills(var_0) {
  self endon("encounter_end");

  for(;;) {
    self waittill("agent_killed");

    if(self.agentskilled >= var_0) {
      encounter_end(1);
    }
  }
}

function failcondition_noplayersinengagedradius(var_0) {
  self endon("encounter_end");
  var_0 = int(var_0);
  var_1 = var_0;

  for(;;) {
    wait 1;

    if(self.playersinengagedradius.size > 0) {
      var_0 = var_1;
      continue;
    }

    var_0--;

    if(var_0 <= 0) {
      encounter_end(0);
    }
  }
}

function failcondition_outsidedangercircle() {
  self endon("encounter_end");

  for(;;) {
    wait 1;

    if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
      continue;
    }

    var_0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var_1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var_2 = distance2dsquared(self.origin, var_0);

    if(var_2 > var_1 * var_1) {
      if(self.playersinengagedradius.size > 0) {} else {
        encounter_end(0);
      }
    }
  }
}

function targetstart_spawner(var_0) {
  targetstart_spawner_init(var_0);
  var_1 = spawn_agent(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0.goalnodes)) {
      var_2 = scripts\engine\utility::random(var_0.goalnodes);
      var_1 setgoalnode(var_2);
    }

    if(isDefined(var_0.goalvolumes)) {
      var_3 = scripts\engine\utility::random(var_0.goalvolumes);

      if(var_3.auto) {
        var_1 setgoalvolumeauto(var_3);
      } else {
        var_1 setgoalvolume(var_3);
      }
    }
  }

  return var_1;
}

function targetstart_spawner_init(var_0) {
  var_0.team = scripts\mp\gametypes\br_ai_encounters_util::get_ai_team();
  var_0.aitype = [[self.func_getspawneraitype]](var_0);
  var_1 = var_0 scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy)) {
      continue;
    }

    switch (var_3.script_noteworthy) {
      case "goal_volume":
        targetstart_spawner_volume(var_0, var_3, 0);
        break;
      case "goal_volume_auto":
        targetstart_spawner_volume(var_0, var_3, 1);
        break;
      case "goal_node":
      case "goal":
        targetstart_spawner_node(var_0, var_3);
        break;
      default:
        break;
    }
  }
}

function targetstart_spawner_node(var_0, var_1) {
  if(!isDefined(var_0.goalnodes)) {
    var_0.goalnodes = [];
  }

  var_0.goalnodes[var_0.goalnodes.size] = var_1;
}

function targetstart_spawner_volume(var_0, var_1, var_2) {
  if(!isDefined(var_0.goalvolumes)) {
    var_0.goalvolumes = [];
  }

  var_1.auto = var_2;
  var_0.goalvolumes[var_0.goalvolumes.size] = var_1;
}

function targetstart_icon(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(0);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "current", var_0.origin, "icon_waypoint_objective_general", "icon_regular");
  objective_setshowoncompass(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_setlabel(var_1, self.iconlabel);
  thread icon_update_visibility(var_1);
  self waittill("encounter_end");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  objective_delete(var_1);
}

function targetstart_reward(var_0) {
  jumpiffalse(scripts\mp\utility\game::getgametype() != "br") LOC_00000011;
  return;
}

function targetstart_reward_prespawn(var_0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var_1 = rewardspawn(var_0);
  scripts\mp\gametypes\br_ai_encounters_util::disablescriptableplayeruseall(var_1);
  var_2 = createnavobstaclebybounds(var_1.origin, (30, 15, 10), var_1.angles);
  self waittill("encounter_end", var_3);
  destroynavobstacle(var_2);

  if(isDefined(var_1)) {
    if(var_3) {
      scripts\mp\gametypes\br_ai_encounters_util::enablescriptableplayeruseall(var_1);
      rewardicon(var_1, "icon_waypoint_unlocked");
      return;
    }

    var_1 freescriptable();
    return;
  }
}

function rewardspawn(var_0, var_1) {
  var_2 = var_0.script_parameters;

  if(!isDefined(var_2)) {
    var_2 = "brloot_killstreak_clusterstrike";
  }

  var_3 = undefined;

  switch (var_2) {
    case "brloot_killstreak_clusterstrike":
      var_4 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_0.origin + (0, 0, 0.1), var_0.angles);
      var_3 = scripts\mp\gametypes\br_pickups::spawnpickup(var_2, var_4, 0, 1);
      break;
    default:
      break;
  }

  if(isDefined(var_3)) {
    thread rewardobjectusewatch(var_3);
    thread rewardobjectcleanup(var_3);
  }

  return var_3;
}

function rewardobjectlock(var_0, var_1, var_2) {
  rewardobjectsetusable(var_0, var_1);
  var_3 = spawn("script_model", var_0.origin + (0, 0, 30));
  var_3 setModel("tag_origin");
  var_3 makeusable();
  var_3 setHintString("MP/DOOR_USE_LOCK");
  var_3 setuseholdduration("duration_long");
  var_3 setusefov(15);
  var_3 setCursorHint("HINT_BUTTON");

  foreach(var_5 in var_1) {
    var_3 disableplayeruse(var_5);
  }

  thread rewardobjectcleanup(var_3);
  thread rewardobjectlockthink(var_3, var_0);
}

function rewardobjectlockthink(var_0, var_1) {
  self endon("reward_cleanup");
  var_0 waittill("trigger", var_2);
  var_3 = var_1.scriptablename;
  scripts\mp\gametypes\br_pickups::lootused(var_1, var_3, "visible", var_2);
}

function rewardobjectusewatch(var_0) {
  self endon("reward_cleanup");

  while(isDefined(var_0)) {
    waitframe();
  }

  self notify("reward_cleanup");
}

function rewardobjectcleanup(var_0) {
  self waittill("reward_cleanup");

  if(isDefined(var_0)) {
    if(var_0 isscriptable()) {
      var_0 freescriptable();
      return;
    }

    var_0 delete();
    return;
  }
}

function rewardobjectsetusable(var_0, var_1) {
  scripts\mp\gametypes\br_ai_encounters_util::disablescriptableplayeruseall(var_0);

  foreach(var_3 in var_1) {
    var_0 enablescriptableplayeruse(var_3);
  }
}

function rewardicon(var_0, var_1, var_2) {
  var_3 = createrewardicon(var_0, var_1);

  if(var_3 < 0) {
    return;
  }

  if(isDefined(var_2)) {
    foreach(var_5 in var_2) {
      objective_addclienttomask(var_3, var_5);
    }
  }

  thread rewardiconcleanup(var_3);
}

function createrewardicon(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(var_2 >= 0) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_2, "current", var_0.origin + (0, 0, 50), var_1, "icon_regular");
    objective_setshowoncompass(var_2, 1);
    objective_setplayintro(var_2, !istrue(self.norewardiconintro));
    objective_setlabel(var_2, "BR_AI_ENCOUNTERS/OBJ_LABEL_REWARD");
    objective_showtoplayersinmask(var_2);
    objective_removeallfrommask(var_2);
  }

  return var_2;
}

function rewardiconcleanup(var_0) {
  self waittill("reward_cleanup");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
}

function icon_update_visibility(var_0) {
  self endon("encounter_end");
  objective_showtoplayersinmask(var_0);

  for(;;) {
    objective_removeallfrommask(var_0);

    foreach(var_2 in self.playersinnotifyradius) {
      var_3 = self.guidtoplayer[var_4];

      if(isDefined(var_3)) {
        objective_addclienttomask(var_0, var_3);
      }
    }

    self waittill("notify_list_changed");
  }
}

function spawn_agent(var_0) {
  var_1 = scripts\mp\mp_agent::spawnnewagent(var_0.aitype, var_0.team, var_0.origin, var_0.angles);

  if(isDefined(var_1)) {
    var_1.recentkillcount = 0;
    var_1.recentdefendcount = 0;
    var_1.kills = 0;
    var_1.deaths = 0;
    var_1.pers["cur_kill_streak"] = 0;
    var_1.pers["cur_death_streak"] = 0;
    var_1.pers["cur_kill_streak_for_nuke"] = 0;
    var_1.tookweaponfrom = [];
    var_1.killedplayers = [];
    var_1.guid = var_1 scripts\mp\utility\player::getuniqueid();
    var_1.script_noteworthy = var_0.script_noteworthy;
    var_1.scripted_long_deaths = 0;
    var_1.agentdamagefeedback = 1;
    self.agents[self.agents.size] = var_1;
    thread watch_agent_death(var_1);
  }

  return var_1;
}

function watch_agent_death(var_0) {
  var_0 waittill("death");
  self.agents = scripts\engine\utility::array_remove(self.agents, var_0);
  self.agentskilled++;
  self notify("agent_killed");
}

function targetstart_spawntrigger(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isagent(var_1)) {
      continue;
    }

    break;
  }

  var_2 = var_0 scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_4 in var_2) {
    targetstart_spawner(var_4);
  }
}

function root_ecounterstart() {
  thread root_inittargets();
  thread root_monitorplayers();
  thread root_failconditions();
}

function root_getspawneraitype(var_0) {
  return var_0.name;
}

function root_inittargets() {
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_GENERIC";
  waittillframeend();
  var_0 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(var_3)) {
      continue;
    }

    switch (var_3) {
      case "spawner":
        thread targetstart_spawner(var_2);
        break;
      case "spawn_trigger":
        thread targetstart_spawntrigger(var_2);
        break;
      case "icon":
        thread targetstart_icon(var_2);
        break;
      case "reward":
        thread targetstart_reward(var_2);
        break;
      case "reward_prespawn":
        thread targetstart_reward_prespawn(var_2);
        break;
      default:
        break;
    }
  }
}

function root_monitorplayers() {
  self endon("encounter_end");
  self.notifyradius = 7500;
  self.engagedradius = 2000;
  self.playersinnotifyradius = [];
  self.playersinengagedradius = [];
  self.guidtoplayer = [];
  waittillframeend();
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
        if(!isDefined(self.playersinnotifyradius[var_8.guid])) {
          var_5 = 1;
        }

        self.playersinnotifyradius[var_8.guid] = var_3;
      } else {
        var_10 = self.playersinnotifyradius[var_8.guid];

        if(isDefined(var_10) && var_3 - var_10 > 2000) {
          var_5 = 1;
          self.playersinnotifyradius[var_8.guid] = undefined;
        }
      }

      if(var_9 <= var_1) {
        if(!isDefined(self.playersinengagedradius[var_8.guid])) {
          var_6 = 1;
        }

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

    if(var_5) {
      self notify("notify_list_changed");
    }

    if(var_6) {
      self notify("engaged_list_changed");
    }

    wait 0.05;
  }
}

function root_failconditions() {
  self.failconditionengagedradiustime = 90;
  waittillframeend();
  thread failcondition_noplayersinengagedradius(self.failconditionengagedradiustime);
  thread failcondition_outsidedangercircle();
}

function rootai_ecounterstart() {
  self.usesai = 1;
  self.func_getspawneraitype = &root_getspawneraitype;
  self.agentskilled = 0;
  self.agents = [];
}

function bank_ecounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = &bank_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_BANK";
  thread alarm_sound_on();
  thread alarm_sound_off_encounter_end();
  thread vault_door_think();
  var_0 = getEnt("bank_vol_01", "targetname");
  var_1 = getEnt("bank_vol_01_upper", "targetname");
  level.wave1_enemies = [];
  var_2 = scripts\engine\utility::getStructArray("enemy_wave_01", "targetname");

  foreach(var_4 in var_2) {
    var_5 = targetstart_spawner(var_4);

    if(var_5.script_noteworthy == "wave01_upper") {
      var_5 setgoalvolumeauto(var_1);
      var_5.goalheight = 256;
    } else if(var_5.script_noteworthy == "wave01_lower") {
      var_5 setgoalvolumeauto(var_0);
    }

    level.wave1_enemies = scripts\engine\utility::array_add(level.wave1_enemies, var_5);
  }

  var_7 = getEnt("wave_01_overrun_trig", "targetname");
  waittill_trigger_or_dead(var_7, level.wave1_enemies, level.wave1_enemies.size - 3);
  level notify("spawn_wave2");
  var_8 = getEnt("bank_vol_02", "targetname");
  var_9 = [];
  var_10 = scripts\engine\utility::getStructArray("enemy_wave_02", "targetname");

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

  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var_9, var_9.size);
  wait 0.5;
  self notify("open_vault");
  var_17 = getEnt("bank_vol_03", "targetname");
  var_18 = [];
  var_19 = scripts\engine\utility::getStruct("enemy_wave_03_boss", "targetname");
  var_20 = targetstart_spawner(var_19);
  thread jug_behavior();
  var_18 = scripts\engine\utility::array_add(var_18, var_20);
  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var_18, var_18.size);
  encounter_end(1);
}

function vault_door_open_wait() {
  self endon("encounter_end");
  self waittill("open_vault");
}

function vault_door_init(var_0) {
  if(istrue(var_0.init)) {
    var_0.angles = var_0.start_angles;
    return;
  }

  var_1 = getEnt("vault_door_clip", "targetname");
  var_1 linkTo(var_0);
  var_0.start_angles = var_0.angles;
  var_0.init = 1;
}

function vault_door_think() {
  var_0 = getEnt("vault_door", "targetname");
  vault_door_init(var_0);
  vault_door_open_wait();
  thread vault_door_sound();
  var_0 rotateby((0, 180, 0), 5);
}

function jug_behavior() {
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

function alarm_sound_on() {
  var_0 = getEntArray("bank_alarm_pos", "targetname");

  foreach(var_2 in var_0) {
    var_2 playLoopSound("emt_alarm_bank_bell_lp");
  }
}

function alarm_sound_off() {
  var_0 = getEntArray("bank_alarm_pos", "targetname");

  foreach(var_2 in var_0) {
    var_2 stoploopsound("emt_alarm_bank_bell_lp");
  }
}

function vault_door_sound() {
  var_0 = 4000000;

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isalive(var_2)) {
      if(distancesquared(var_2.origin, self.origin) <= var_0) {
        var_2 playSound("cp_bank_vault_open");
      }
    }
  }
}

function waittill_trigger_or_dead(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 endon("done");
  GscBinSkip4(0x6e, var_4, var_0);
}

function _waittill_dead_notify_done(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var_0, var_1, var_2);
  self notify("done");
}

function _waittill_trigger(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    break;
  }

  self notify("done");
}

function alarm_sound_off_encounter_end() {
  self waittill("encounter_end");
  alarm_sound_off();
}

function bank_getspawneraitype(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "jugg":
        return "actor_enemy_br_juggernaut";
      default:
        break;
    }
  }

  return "actor_enemy_br_base";
}

function airport_ecounterstart() {
  var_0 = getEnt("ai_encounter_crate", "targetname");
  var_0 movez(256, 0.05);
  wait 0.5;
  createnavobstaclebyent(var_0);
  var_1 = getEnt("kickoff_airport_encounter", "targetname");
  var_1 waittill("trigger", var_2);
  var_3 = "smoke_grenade_mp";
  var_4 = magicgrenademanual(var_3, scripts\engine\utility::getStruct("airport_smoke_toss_pos", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos", "targetname").angles) * 400, 1);
  wait 0.1;
  var_5 = magicgrenademanual(var_3, scripts\engine\utility::getStruct("airport_smoke_toss_pos_02", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos_02", "targetname").angles) * 400, 1.3);
  var_6 = magicgrenademanual(var_3, scripts\engine\utility::getStruct("airport_smoke_toss_pos_03", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos_03", "targetname").angles) * 450, 2);
  var_7 = getEnt("airport_vol_01", "targetname");
  wait 2;
  var_8 = [];
  var_9 = scripts\engine\utility::getStructArray("airport_enemy_wave_01", "targetname");

  foreach(var_11 in var_9) {
    var_12 = targetstart_spawner(var_11);
    var_12 setgoalvolumeauto(var_7);
    thread airport_enemy_setup();
    var_8 = scripts\engine\utility::array_add(var_8, var_12);
  }

  var_14 = getEnt("wave_01_overrun_trig", "targetname");
  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var_8, var_8.size);
  encounter_end(1);
}

function airport_enemy_setup() {
  self.ignore_all = 1;
  wait randomfloatrange(1, 2);
  self.ignore_all = 0;
  self.accuracy = 0.01;
}

function truck_encounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = &truck_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_TRUCK";
  thread failcondition_noplayersinengagedradius(90);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  var_3 = [];
  var_4 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_6 in var_4) {
    var_7 = var_6.script_noteworthy;

    if(!isDefined(var_7)) {
      continue;
    }

    switch (var_7) {
      case "start_trigger":
        var_0 = var_6;
        break;
      case "truck_enemy_wave":
        var_2 = var_6;
        break;
      case "roll_door":
        var_1 = var_6;
        thread truck_roll_door_init(var_1);
        break;
      case "jump_down_node":
        var_3 = var_6;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var_0 waittill("trigger", var_9);

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

  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var_10, var_10.size);
  encounter_end(1);
}

function truck_roll_door_init(var_0) {
  self endon("encounter_end");

  if(!istrue(var_0.init)) {
    var_0.angle_ref = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(!isDefined(var_0.angle_ref.angles)) {
      var_0.angle_ref.angles = (0, 0, 0);
    }

    var_0.start_origin = var_0.origin;
    var_0.start_angles = var_0.angles;
    var_0.init = 1;
    return;
  }

  var_0.origin = var_0.start_origin;
  var_0.angles = var_0.start_angles;
}

function truck_roll_door_open(var_0) {
  var_0 rotatepitch(-90, 1);
  truck_roll_door_sound(var_0);
  self notify("truck_roll_door_open");
}

function truck_roll_door_sound(var_0) {
  var_1 = 1000000;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(distancesquared(var_3.origin, var_0.origin) <= var_1) {
        var_3 playSound("cp_bank_gate_fall");
      }
    }
  }
}

function truck_getspawneraitype(var_0) {
  return "actor_enemy_br_base";
}

function crateguard_encounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = &crateguard_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_CRATE_GUARD";
  thread failcondition_noplayersinengagedradius(90);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];
  var_3 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_5 in var_3) {
    var_6 = var_5.script_noteworthy;

    if(!isDefined(var_6)) {
      continue;
    }

    switch (var_6) {
      case "guard":
        var_2 = var_5;
        break;
      case "guard_boss":
        var_1 = var_5;
        break;
      case "start_trigger":
        var_0 = var_5;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var_0 waittill("trigger", var_8);

    if(isalive(var_8) && isPlayer(var_8)) {
      break;
    }
  }

  var_9 = [];

  foreach(var_11 in var_2) {
    var_12 = targetstart_spawner(var_11);
    var_9 = var_12;
  }

  var_14 = targetstart_spawner(var_1);
  var_9 = var_14;
  GscBinSkip4(0x35, var_14, var_9);
}

function crateguard_bosssetup(var_0, var_1) {
  var_0.ignoreall = 1;
  var_2 = var_1;
  GscBinSkip0(0x2e, var_2.size, var_0);
}

function crateguard_getspawneraitype(var_0) {
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "guard_boss") {
    return "actor_enemy_br_boss";
  }

  return "actor_enemy_br_base";
}

function smoking() {
  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "smoking_death";
  thread smoking_idle("smoking_idle");
  thread smoking_react("smoking_react");
  thread smoking_death("smoking_death");
}

function smoking_idle(var_0) {
  self endon("death");
  self endon("damage");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::burndowntime(var_0);
    smoking_idle_end("smoking_idle_end");
  }
}

function smoking_idle_start(var_0) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

function smoking_idle_end(var_0) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

function smoking_react(var_0) {
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

  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self);
}

function smoking_death(var_0) {
  self endon("damage");
  self waittill("death");
  ai_smoking_cleanup();
}

function ai_notehandler_smoking(var_0) {
  switch (var_0) {
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

function ai_smoking_blowsmoke() {
  self endon("smoking_end");
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    playFX(level.g_effect["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    var_0 = randomintrange(5, 8);
    wait var_0;
  }
}

function ai_smoking_cleanup() {
  self notify("smoking_end");
  self endon("death");

  if(scripts\engine\utility::hastag(self.model, "tag_accessory_right")) {
    killfxontag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
    killfxontag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
    return;
  }
}

function standing_cellphone(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "stand_cellphone_death";
  thread ai_notetrack_loop("standing_cellphone");
  standing_cellphone_anim("stand_cellphone_intro");

  if(var_0 > 0) {
    standing_cellphone_loop("stand_cellphone_loop", var_0);
  }

  standing_cellphone_anim("stand_cellphone_exit");
}

function standing_cellphone_anim(var_0) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

function standing_cellphone_loop(var_0, var_1) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::bunkeropened(var_0, var_1);
}

function ai_notehandler_cellphone(var_0) {
  self endon("death");
  self endon("damage");

  switch (var_0) {
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

function setup_anim_guy() {
  self.playing_skit = 1;
}

function reset_guy(var_0) {
  var_0 allowedstances("prone", "stand", "crouch");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
  var_0.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function ai_notetrack_loop(var_0) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    self waittill("animscripted", var_1);

    if(!isDefined(var_1)) {
      var_1 = ["undefined"];
    }

    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    var_2 = undefined;

    foreach(var_4 in var_1) {
      if(var_0 == "smoking") {
        ai_notehandler_smoking(var_4);
        continue;
      }

      if(var_0 == "standing_cellphone") {
        ai_notehandler_cellphone(var_4);
      }
    }
  }
}

function test_ecounterstart() {}

function rootnonai_ecounterstart() {
  self.usesai = 0;
}

function dom_encounterstart() {
  self.norewardiconintro = 1;
  self.engagedradius = 1500;
  domencounter_icons();
  var_0 = undefined;
  var_1 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_3 in var_1) {
    var_4 = var_3.script_noteworthy;

    if(!isDefined(var_4)) {
      continue;
    }

    switch (var_4) {
      case "trigger_radius":
        var_5 = 315;
        var_6 = 120;
        var_0 = spawn("trigger_radius", var_3.origin, 0, int(var_5), int(var_6));
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }

  level.setdomscriptablepartstatefunc = &domencounter_setdomscriptablepartstate;
  var_8 = scripts\mp\gametypes\obj_dom::setupobjective(var_0);
  var_8.noscriptable = undefined;
  var_8.vfxnamemod = "_300";
  var_8.onuse = &domencounter_onuse;
  var_8.onuseupdate = &domencounter_onuseupdate;
  var_8.onenduse = &domencounter_onenduse;
  var_8 scripts\mp\gameobjects::setvisibleteam("any");
  var_8 scripts\mp\gametypes\obj_dom::domflag_setneutral();
  level.flagcapturetime = getdvarint("scr_ai_encounters_dom_use_time", 30);
  var_8 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_8.encounterlocation = self;
  thread encounterdeletedomgameobjectonend(var_8);
  thread icon_update_visibility(var_8.objidnum);
}

function encounterdeletedomgameobjectonend(var_0) {
  var_0 endon("deleted");
  self waittill("encounter_end");

  foreach(var_2 in var_0.visuals) {
    var_2 delete();
  }

  if(isDefined(var_0.flagmodel)) {
    var_0.flagmodel delete();
  }

  if(isDefined(var_0.scriptable)) {
    var_0.scriptable delete();
  }

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
    var_0.trigger = undefined;
  }

  thread gameobjectreleaseid_delayed();
  var_0 notify("deleted");
}

function gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

function domencounter_icons() {
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

function _setdomencountericoninfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 0;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "icon_waypoint_dom_a";
  level.waypointpulses[var_0] = var_3;
}

function domencounter_onuseupdate(var_0, var_1, var_2, var_3) {
  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    self.didstatusnotify = 1;
    return;
  }
}

function domencounter_onuse(var_0) {
  encounter_end(self.encounterlocation, 1, var_0.team);
}

function domencounter_onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function domencounter_setdomscriptablepartstate(var_0, var_1, var_2) {
  switch (var_1) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      var_1 = "using";

      if(isDefined(var_2)) {
        var_1 += var_2;
      }

      self.scriptable setscriptablepartstate(var_0, var_1);

      if(var_0 == "pulse") {
        self.scriptable setscriptablepartstate("flag", var_1);
      }

      return 1;
  }
}

function bombplant_encounterstart() {}

function extraction_encounterstart() {
  iprintlnbold("EXTRACTION START");
  var_0 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(var_3)) {
      continue;
    }

    switch (var_3) {
      case "use_object":
        extraction_createescort(var_2);
        break;
      case "goal":
        targetstart_extractiongoal(var_2);
        break;
      default:
        break;
    }
  }
}

function targetstart_extractiongoal(var_0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var_1 = spawn("script_model", var_0.origin + (0, 0, 20));
  var_1 setModel("ctf_game_flag_east");
  self.goal = var_1;
  var_1.encounter = self;
}

function extraction_createescort(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 20));
  var_1 setModel("fullbody_usmc_ar");
  var_1 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_1 scriptmodelpauseanim(1);
  var_1 makeusable();
  var_1 setCursorHint("HINT_NOICON");
  var_1 setuseholdduration("duration_medium");
  var_1 sethintrequiresholding(1);
  var_1 sethintdisplayfov(120);
  var_1 setusefov(120);
  var_1 setuserange(80);
  var_1 setHintString(&"MP_BR_USE_PLUNDER_CACHE");
  var_1 setasgametypeobjective();
  var_1 show();
  var_1.readytoextract = 0;
  thread extraction_escortthink();
  self.escort = var_1;
  var_1.encounter = self;
}

function extraction_escortthink() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!self.readytoextract) {
      extraction_playerpickupbody(var_0, self, var_0.team);
      continue;
    }

    thread extraction_attachfultonballoontoescort(var_0);
  }
}

function extraction_playerpickupbody(var_0, var_1) {
  self endon("droppedBody");
  var_0 makeunusable();
  var_2 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var_2.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = var_2;
  var_0 scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  var_0 linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  scripts\mp\gametypes\br_respawn::playersetcarryteammates(1);

  while(!self stancebuttonPressed() || !self isonground()) {
    waitframe();
  }

  extraction_dropbody(var_0, self, var_2, var_1);
}

function extraction_dropbody(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowjump(1);
    scripts\mp\gametypes\br_respawn::playersetcarryteammates(0);
  }

  if(isDefined(var_2)) {
    var_2 destroy();
  }

  if(var_0 islinked()) {
    var_0 unlink();
  }

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_0.angles = var_1.angles;
    var_4 = var_1.origin;
    var_0.origin = var_4 + (0, 0, 40);
  } else {
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, 40);
  }

  var_0 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_0 scriptmodelpauseanim(1);
  var_0.origin = var_4 + (0, 0, 1);
  var_0 makeusable();

  if(extraction_checkescortradius(var_0)) {
    extraction_changeescortusefunction(var_0);
  }

  var_0 notify("droppedBody");
}

function extraction_checkescortradius(var_0) {
  if(distance2d(self.origin, self.encounter.goal.origin) < 100) {
    return 1;
  }

  return 0;
}

function extraction_changeescortusefunction() {
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setuseholdduration("duration_long");
  self sethintrequiresholding(1);
  self setHintString(&"MP_BR_USE_PLUNDER_CACHE");
  self.readytoextract = 1;
}

function extraction_attachfultonballoontoescort(var_0) {
  encounter_end(self.encounter, 1);
  self.encounter.goal delete();
  self delete();
}

function destruction_encounterstart() {
  var_0 = getscriptablearray(self.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.script_noteworthy;

    if(!isDefined(var_4)) {
      continue;
    }

    switch (var_4) {
      case "destroy":
        var_1 = var_3;
        break;
      default:
        break;
    }
  }
}