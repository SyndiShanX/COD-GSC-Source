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
  var0 = spawnStruct();
  init_encounters(var0);
  init_locations(var0);
  thread encounter_manager();
  level.disableinitplayergameobjects = 0;
}

function add_encounter_start_condition(var0, var1) {
  add_condition("encounter", var0, var1);
}

function add_location_start_condition(var0, var1) {
  add_condition("location", var0, var1);
}

function add_condition(var0, var1, var2) {
  if(!isDefined(self.startconditions[var0])) {
    self.startconditions[var0] = [];
  }

  var3 = spawnStruct();
  var3.func = var1;
  var3.params = var2;
  var4 = self.startconditions[var0].size;
  self.startconditions[var0][var4] = var3;
}

function add_encounter_start_function(var0) {
  self.func_encounterstart = var0;
}

function init_encounters() {
  self.encounters = [];
  self.allencounters = [];
  var0 = init_encounter("root");
  add_encounter_start_condition(var0, &condition_prematchdone);
  add_encounter_start_condition(var0, &condition_mintimepassed, 60);
  add_encounter_start_condition(var0, &condition_maxaliveplayers, 70);
  add_encounter_start_condition(var0, &condition_maxactivelocations, 1);
  add_encounter_start_condition(var0, &condition_lastencounterstarttime, 30);
  add_location_start_condition(var0, &condition_stateis, 0);
  add_location_start_condition(var0, &condition_insafecircle);
  add_encounter_start_condition(var0, &condition_circlecount, 2);
  add_encounter_start_condition(var0, &condition_circlesremaining, 2);
  add_location_start_condition(var0, &condition_anyplayerinsideradius, 7500);
  add_encounter_start_function(var0, &root_ecounterstart);
  var1 = init_encounter("root_ai", var0);
  add_encounter_start_function(var1, &rootai_ecounterstart);
  var2 = init_encounter("bank", var1);
  add_location_start_condition(var2, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var2, &bank_ecounterstart);
  var3 = init_encounter("airport", var1);
  add_location_start_condition(var3, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var3, &airport_ecounterstart);
  var4 = init_encounter("truck", var1);
  add_location_start_condition(var4, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var4, &truck_encounterstart);
  var5 = init_encounter("crate_guard", var1);
  add_location_start_condition(var5, &condition_allplayersoutsideradius, 3000);
  add_encounter_start_function(var5, &crateguard_encounterstart);
  var6 = init_encounter("jugg", var1);
  add_location_start_condition(var6, &condition_allplayersoutsideradius, 1000);
  add_encounter_start_condition(var6, &condition_disabled);
  var7 = init_encounter("test", var1);
  add_encounter_start_condition(var7, &condition_disabled);
  add_encounter_start_function(var7, &test_ecounterstart);
  var8 = init_encounter("root_non_ai", var0);
  add_location_start_condition(var8, &condition_allplayersoutsideradius, 2000);
  add_encounter_start_function(var8, &rootnonai_ecounterstart);
  var9 = init_encounter("dom", var8);
  add_encounter_start_function(var9, &dom_encounterstart);
  var10 = init_encounter("bomb_plant", var8);
  add_encounter_start_function(var10, &bombplant_encounterstart);
  var11 = init_encounter("extraction", var8);
  add_encounter_start_function(var11, &extraction_encounterstart);
  add_encounter_start_condition(var11, &condition_disabled);
  var12 = init_encounter("destruction", var8);
  add_encounter_start_function(var12, &destruction_encounterstart);
}

function init_encounter(var0, var1) {
  var2 = spawnStruct();
  var2.name = var0;
  var2.info = self;
  var2.parentencounter = var1;
  var2.encounters = [];
  var2.startconditions = [];
  var2.locations = [];
  self.allencounters[var0] = var2;

  if(isDefined(var1)) {
    var1.encounters[var1.encounters.size] = var2;
  } else {
    self.encounters[self.encounters.size] = var2;
  }

  return var2;
}

function init_locations() {
  self.alllocations = [];
  self.activelocations = [];
  var0 = scripts\engine\utility::getStructArray("ai_encounters", "targetname");

  foreach(var2 in var0) {
    init_location(var2);
  }
}

function init_location(var0) {
  var0.name = var0.script_noteworthy;
  var1 = self.allencounters[var0.name];
  var1.locations[var1.locations.size] = var0;
  var0.encounter = var1;
  var0.state = 0;
  var2 = self.alllocations.size;
  self.alllocations[var2] = var0;
}

function encounter_manager() {
  for(;;) {
    self.validlocations = [];
    update_conditions(self.encounters);

    if(self.validlocations.size) {
      var0 = scripts\engine\utility::random(self.validlocations);
      encounter_start(var0);
    }

    wait 0.05;
  }
}

function update_conditions(var0) {
  foreach(var2 in var0) {
    if(!check_encounter_start_conditions(var2)) {
      continue;
    }

    update_conditions(var2.encounters);

    foreach(var4 in var2.locations) {
      if(!check_location_start_conditions(var4)) {
        continue;
      }

      self.validlocations[self.validlocations.size] = var4;
    }
  }
}

function check_encounter_start_conditions() {
  return check_start_conditions(self, "encounter", 0);
}

function check_location_start_conditions() {
  return check_start_conditions(self.encounter, "location", 1);
}

function check_start_conditions(var0, var1, var2) {
  if(var2 && isDefined(var0.parentencounter)) {
    if(!check_start_conditions(var0.parentencounter, var1, var2)) {
      return false;
    }
  }

  if(!isDefined(var0.startconditions[var1])) {
    return true;
  }

  for(var3 = 0; var3 < var0.startconditions[var1].size; var3++) {
    var4 = var0.startconditions[var1][var3];

    if(isDefined(var4.params)) {
      var5 = self[[var4.func]](var4.params);
    } else {
      var5 = self[[var4.func]]();
    }

    if(!var5) {
      return false;
    }
  }

  return true;
}

function encounter_start(var0) {
  var0.state = 1;
  self.activelocations[self.activelocations.size] = var0;
  var0.starttime = gettime();
  encounter_location_start_functions(var0);
}

function encounter_location_start_functions(var0) {
  encounter_start_functions(var0, var0.encounter);
}

function encounter_start_functions(var0) {
  if(isDefined(var0.parentencounter)) {
    encounter_start_functions(var0.parentencounter);
  }

  if(isDefined(var0.func_encounterstart)) {
    self[[var0.func_encounterstart]]();
    return;
  }
}

function encounter_end(var0, var1) {
  if(var0) {
    self.state = 2;
  } else {
    self.state = 3;
  }

  self.endtime = gettime();
  self.duration = self.endtime - self.starttime;
  var2 = self.encounter.info;
  var2.activelocations = scripts\engine\utility::array_remove(var2.activelocations, self);
  var2.lastencounter = self;

  if(self.usesai) {
    foreach(var4 in self.agents) {
      if(isalive(var4)) {
        var4 suicide();
      }
    }
  }

  self notify("encounter_end", var0, var1);
}

function condition_disabled(var0) {
  return false;
}

function condition_stateis(var0) {
  if(self.state != var0) {
    return false;
  }

  return true;
}

function condition_anyplayerinsideradius(var0) {
  var1 = var0 * var0;
  var2 = sortbydistance(level.players, self.origin);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(!isalive(var4)) {
      continue;
    }

    var5 = distance2dsquared(var4.origin, self.origin);

    if(var5 < var1) {
      return true;
    }

    break;
  }

  return false;
}

function condition_allplayersoutsideradius(var0) {
  var1 = var0 * var0;
  var2 = sortbydistance(level.players, self.origin);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(!isalive(var4)) {
      continue;
    }

    var5 = distance2dsquared(var4.origin, self.origin);

    if(var5 < var1) {
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

  var0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var2 = distance2dsquared(self.origin, var0);

  if(var2 > var1 * var1) {
    return false;
  }

  return true;
}

function condition_circlecount(var0) {
  if(istrue(level.br_circle_disabled)) {
    return true;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
    return false;
  }

  var1 = getomnvar("ui_br_circle_num");

  if(var1 < var0) {
    return false;
  }

  return true;
}

function condition_circlesremaining(var0) {
  if(istrue(level.br_circle_disabled)) {
    return true;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex)) {
    return false;
  }

  var1 = level.br_level.br_circledelaytimes.size;
  var2 = var1 - level.br_circle.circleindex;

  if(var2 < var0) {
    return false;
  }

  return true;
}

function condition_maxaliveplayers(var0) {
  if(!isDefined(level.teamdata)) {
    return false;
  }

  var1 = 0;

  foreach(var3 in level.teamdata) {
    var1 += var3["aliveCount"];
  }

  if(var1 > var0) {
    return false;
  }

  return true;
}

function condition_maxactivelocations(var0) {
  if(self.info.activelocations.size >= var0) {
    return false;
  }

  return true;
}

function condition_mintimepassed(var0) {
  var1 = scripts\mp\utility\game::getsecondspassed();

  if(var1 < var0) {
    return false;
  }

  return true;
}

function condition_lastencounterstarttime(var0) {
  var1 = self.info;

  if(isDefined(var1.lastencounter)) {
    var2 = (gettime() - var1.lastencounter.endtime) / 1000;

    if(var2 < var0) {
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

function successcondition_enemykills(var0) {
  self endon("encounter_end");

  for(;;) {
    self waittill("agent_killed");

    if(self.agentskilled >= var0) {
      encounter_end(1);
    }
  }
}

function failcondition_noplayersinengagedradius(var0) {
  self endon("encounter_end");
  var0 = int(var0);
  var1 = var0;

  for(;;) {
    wait 1;

    if(self.playersinengagedradius.size > 0) {
      var0 = var1;
      continue;
    }

    var0--;

    if(var0 <= 0) {
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

    var0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var2 = distance2dsquared(self.origin, var0);

    if(var2 > var1 * var1) {
      if(self.playersinengagedradius.size > 0) {} else {
        encounter_end(0);
      }
    }
  }
}

function targetstart_spawner(var0) {
  targetstart_spawner_init(var0);
  var1 = spawn_agent(var0);

  if(isDefined(var1)) {
    if(isDefined(var0.goalnodes)) {
      var2 = scripts\engine\utility::random(var0.goalnodes);
      var1 setgoalnode(var2);
    }

    if(isDefined(var0.goalvolumes)) {
      var3 = scripts\engine\utility::random(var0.goalvolumes);

      if(var3.auto) {
        var1 setgoalvolumeauto(var3);
      } else {
        var1 setgoalvolume(var3);
      }
    }
  }

  return var1;
}

function targetstart_spawner_init(var0) {
  var0.team = scripts\mp\gametypes\br_ai_encounters_util::get_ai_team();
  var0.aitype = [[self.func_getspawneraitype]](var0);
  var1 = var0 scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var3 in var1) {
    if(!isDefined(var3.script_noteworthy)) {
      continue;
    }

    switch (var3.script_noteworthy) {
      case "goal_volume":
        targetstart_spawner_volume(var0, var3, 0);
        break;
      case "goal_volume_auto":
        targetstart_spawner_volume(var0, var3, 1);
        break;
      case "goal_node":
      case "goal":
        targetstart_spawner_node(var0, var3);
        break;
      default:
        break;
    }
  }
}

function targetstart_spawner_node(var0, var1) {
  if(!isDefined(var0.goalnodes)) {
    var0.goalnodes = [];
  }

  var0.goalnodes[var0.goalnodes.size] = var1;
}

function targetstart_spawner_volume(var0, var1, var2) {
  if(!isDefined(var0.goalvolumes)) {
    var0.goalvolumes = [];
  }

  var1.auto = var2;
  var0.goalvolumes[var0.goalvolumes.size] = var1;
}

function targetstart_icon(var0) {
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(0);
  scripts\mp\objidpoolmanager::objective_add_objective(var1, "current", var0.origin, "icon_waypoint_objective_general", "icon_regular");
  objective_setshowoncompass(var1, 1);
  objective_setplayintro(var1, 1);
  objective_setlabel(var1, self.iconlabel);
  thread icon_update_visibility(var1);
  self waittill("encounter_end");
  scripts\mp\objidpoolmanager::returnobjectiveid(var1);
  objective_delete(var1);
}

function targetstart_reward(var0) {
  jumpiffalse(scripts\mp\utility\game::getgametype() != "br") LOC_00000011;
  return;
}

function targetstart_reward_prespawn(var0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var1 = rewardspawn(var0);
  scripts\mp\gametypes\br_ai_encounters_util::disablescriptableplayeruseall(var1);
  var2 = createnavobstaclebybounds(var1.origin, (30, 15, 10), var1.angles);
  self waittill("encounter_end", var3);
  destroynavobstacle(var2);

  if(isDefined(var1)) {
    if(var3) {
      scripts\mp\gametypes\br_ai_encounters_util::enablescriptableplayeruseall(var1);
      rewardicon(var1, "icon_waypoint_unlocked");
      return;
    }

    var1 freescriptable();
    return;
  }
}

function rewardspawn(var0, var1) {
  var2 = var0.script_parameters;

  if(!isDefined(var2)) {
    var2 = "brloot_killstreak_clusterstrike";
  }

  var3 = undefined;

  switch (var2) {
    case "brloot_killstreak_clusterstrike":
      var4 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var0.origin + (0, 0, 0.1), var0.angles);
      var3 = scripts\mp\gametypes\br_pickups::spawnpickup(var2, var4, 0, 1);
      break;
    default:
      break;
  }

  if(isDefined(var3)) {
    thread rewardobjectusewatch(var3);
    thread rewardobjectcleanup(var3);
  }

  return var3;
}

function rewardobjectlock(var0, var1, var2) {
  rewardobjectsetusable(var0, var1);
  var3 = spawn("script_model", var0.origin + (0, 0, 30));
  var3 setModel("tag_origin");
  var3 makeusable();
  var3 setHintString("MP/DOOR_USE_LOCK");
  var3 setuseholdduration("duration_long");
  var3 setusefov(15);
  var3 setCursorHint("HINT_BUTTON");

  foreach(var5 in var1) {
    var3 disableplayeruse(var5);
  }

  thread rewardobjectcleanup(var3);
  thread rewardobjectlockthink(var3, var0);
}

function rewardobjectlockthink(var0, var1) {
  self endon("reward_cleanup");
  var0 waittill("trigger", var2);
  var3 = var1.scriptablename;
  scripts\mp\gametypes\br_pickups::lootused(var1, var3, "visible", var2);
}

function rewardobjectusewatch(var0) {
  self endon("reward_cleanup");

  while(isDefined(var0)) {
    waitframe();
  }

  self notify("reward_cleanup");
}

function rewardobjectcleanup(var0) {
  self waittill("reward_cleanup");

  if(isDefined(var0)) {
    if(var0 isscriptable()) {
      var0 freescriptable();
      return;
    }

    var0 delete();
    return;
  }
}

function rewardobjectsetusable(var0, var1) {
  scripts\mp\gametypes\br_ai_encounters_util::disablescriptableplayeruseall(var0);

  foreach(var3 in var1) {
    var0 enablescriptableplayeruse(var3);
  }
}

function rewardicon(var0, var1, var2) {
  var3 = createrewardicon(var0, var1);

  if(var3 < 0) {
    return;
  }

  if(isDefined(var2)) {
    foreach(var5 in var2) {
      objective_addclienttomask(var3, var5);
    }
  }

  thread rewardiconcleanup(var3);
}

function createrewardicon(var0, var1) {
  var2 = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(var2 >= 0) {
    scripts\mp\objidpoolmanager::objective_add_objective(var2, "current", var0.origin + (0, 0, 50), var1, "icon_regular");
    objective_setshowoncompass(var2, 1);
    objective_setplayintro(var2, !istrue(self.norewardiconintro));
    objective_setlabel(var2, "BR_AI_ENCOUNTERS/OBJ_LABEL_REWARD");
    objective_showtoplayersinmask(var2);
    objective_removeallfrommask(var2);
  }

  return var2;
}

function rewardiconcleanup(var0) {
  self waittill("reward_cleanup");
  scripts\mp\objidpoolmanager::returnobjectiveid(var0);
}

function icon_update_visibility(var0) {
  self endon("encounter_end");
  objective_showtoplayersinmask(var0);

  for(;;) {
    objective_removeallfrommask(var0);

    foreach(var2 in self.playersinnotifyradius) {
      var3 = self.guidtoplayer[var4];

      if(isDefined(var3)) {
        objective_addclienttomask(var0, var3);
      }
    }

    self waittill("notify_list_changed");
  }
}

function spawn_agent(var0) {
  var1 = scripts\mp\mp_agent::spawnnewagent(var0.aitype, var0.team, var0.origin, var0.angles);

  if(isDefined(var1)) {
    var1.recentkillcount = 0;
    var1.recentdefendcount = 0;
    var1.kills = 0;
    var1.deaths = 0;
    var1.pers["cur_kill_streak"] = 0;
    var1.pers["cur_death_streak"] = 0;
    var1.pers["cur_kill_streak_for_nuke"] = 0;
    var1.tookweaponfrom = [];
    var1.killedplayers = [];
    var1.guid = var1 scripts\mp\utility\player::getuniqueid();
    var1.script_noteworthy = var0.script_noteworthy;
    var1.scripted_long_deaths = 0;
    var1.agentdamagefeedback = 1;
    self.agents[self.agents.size] = var1;
    thread watch_agent_death(var1);
  }

  return var1;
}

function watch_agent_death(var0) {
  var0 waittill("death");
  self.agents = scripts\engine\utility::array_remove(self.agents, var0);
  self.agentskilled++;
  self notify("agent_killed");
}

function targetstart_spawntrigger(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(isagent(var1)) {
      continue;
    }

    break;
  }

  var2 = var0 scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var4 in var2) {
    targetstart_spawner(var4);
  }
}

function root_ecounterstart() {
  thread root_inittargets();
  thread root_monitorplayers();
  thread root_failconditions();
}

function root_getspawneraitype(var0) {
  return var0.name;
}

function root_inittargets() {
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_GENERIC";
  waittillframeend();
  var0 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;

    if(!isDefined(var3)) {
      continue;
    }

    switch (var3) {
      case "spawner":
        thread targetstart_spawner(var2);
        break;
      case "spawn_trigger":
        thread targetstart_spawntrigger(var2);
        break;
      case "icon":
        thread targetstart_icon(var2);
        break;
      case "reward":
        thread targetstart_reward(var2);
        break;
      case "reward_prespawn":
        thread targetstart_reward_prespawn(var2);
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
  var0 = self.notifyradius * self.notifyradius;
  var1 = self.engagedradius * self.engagedradius;
  var2 = 20;

  for(;;) {
    var3 = gettime();
    var4 = 0;
    var5 = 0;
    var6 = 0;

    for(var7 = 0; var7 < level.players.size; var7++) {
      var8 = level.players[var7];

      if(!isDefined(var8)) {
        continue;
      }

      self.guidtoplayer[var8.guid] = var8;

      if(!isalive(var8)) {
        if(isDefined(self.playersinnotifyradius[var8.guid])) {
          var5 = 1;
          self.playersinnotifyradius[var8.guid] = undefined;
        }

        if(isDefined(self.playersinengagedradius[var8.guid])) {
          var6 = 1;
          self.playersinengagedradius[var8.guid] = undefined;
        }

        continue;
      }

      var9 = distance2dsquared(var8.origin, self.origin);

      if(var9 <= var0) {
        if(!isDefined(self.playersinnotifyradius[var8.guid])) {
          var5 = 1;
        }

        self.playersinnotifyradius[var8.guid] = var3;
      } else {
        var10 = self.playersinnotifyradius[var8.guid];

        if(isDefined(var10) && var3 - var10 > 2000) {
          var5 = 1;
          self.playersinnotifyradius[var8.guid] = undefined;
        }
      }

      if(var9 <= var1) {
        if(!isDefined(self.playersinengagedradius[var8.guid])) {
          var6 = 1;
        }

        self.playersinengagedradius[var8.guid] = var3;
      } else {
        var10 = self.playersinengagedradius[var8.guid];

        if(isDefined(var10) && var3 - var10 > 2000) {
          var6 = 1;
          self.playersinengagedradius[var8.guid] = undefined;
        }
      }

      var4++;

      if(var4 >= var2) {
        wait 0.05;
        var4 = 0;
      }
    }

    if(var5) {
      self notify("notify_list_changed");
    }

    if(var6) {
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
  var0 = getEnt("bank_vol_01", "targetname");
  var1 = getEnt("bank_vol_01_upper", "targetname");
  level.wave1_enemies = [];
  var2 = scripts\engine\utility::getStructArray("enemy_wave_01", "targetname");

  foreach(var4 in var2) {
    var5 = targetstart_spawner(var4);

    if(var5.script_noteworthy == "wave01_upper") {
      var5 setgoalvolumeauto(var1);
      var5.goalheight = 256;
    } else if(var5.script_noteworthy == "wave01_lower") {
      var5 setgoalvolumeauto(var0);
    }

    level.wave1_enemies = scripts\engine\utility::array_add(level.wave1_enemies, var5);
  }

  var7 = getEnt("wave_01_overrun_trig", "targetname");
  waittill_trigger_or_dead(var7, level.wave1_enemies, level.wave1_enemies.size - 3);
  level notify("spawn_wave2");
  var8 = getEnt("bank_vol_02", "targetname");
  var9 = [];
  var10 = scripts\engine\utility::getStructArray("enemy_wave_02", "targetname");

  foreach(var12 in var10) {
    var5 = targetstart_spawner(var12);
    var5 setgoalvolumeauto(var8);
    var9 = scripts\engine\utility::array_add(var9, var5);
  }

  foreach(var15 in level.wave1_enemies) {
    if(isDefined(var15) && isalive(var15)) {
      var15 setgoalvolumeauto(var8);
      var9 = scripts\engine\utility::array_add(var9, var15);
    }
  }

  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var9, var9.size);
  wait 0.5;
  self notify("open_vault");
  var17 = getEnt("bank_vol_03", "targetname");
  var18 = [];
  var19 = scripts\engine\utility::getStruct("enemy_wave_03_boss", "targetname");
  var20 = targetstart_spawner(var19);
  thread jug_behavior();
  var18 = scripts\engine\utility::array_add(var18, var20);
  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var18, var18.size);
  encounter_end(1);
}

function vault_door_open_wait() {
  self endon("encounter_end");
  self waittill("open_vault");
}

function vault_door_init(var0) {
  if(istrue(var0.init)) {
    var0.angles = var0.start_angles;
    return;
  }

  var1 = getEnt("vault_door_clip", "targetname");
  var1 linkTo(var0);
  var0.start_angles = var0.angles;
  var0.init = 1;
}

function vault_door_think() {
  var0 = getEnt("vault_door", "targetname");
  vault_door_init(var0);
  vault_door_open_wait();
  thread vault_door_sound();
  var0 rotateby((0, 180, 0), 5);
}

function jug_behavior() {
  var0 = sortbydistance(level.players, self.origin);

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(isalive(var2)) {
      self getenemyinfo(var2);
      self setgoalentity(var2);
      break;
    }
  }
}

function alarm_sound_on() {
  var0 = getEntArray("bank_alarm_pos", "targetname");

  foreach(var2 in var0) {
    var2 playLoopSound("emt_alarm_bank_bell_lp");
  }
}

function alarm_sound_off() {
  var0 = getEntArray("bank_alarm_pos", "targetname");

  foreach(var2 in var0) {
    var2 stoploopsound("emt_alarm_bank_bell_lp");
  }
}

function vault_door_sound() {
  var0 = 4000000;

  foreach(var2 in level.players) {
    if(isDefined(var2) && isalive(var2)) {
      if(distancesquared(var2.origin, self.origin) <= var0) {
        var2 playSound("cp_bank_vault_open");
      }
    }
  }
}

function waittill_trigger_or_dead(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4 endon("done");
  GscBinSkip4(0x6e, var4, var0);
}

function _waittill_dead_notify_done(var0, var1, var2) {
  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var0, var1, var2);
  self notify("done");
}

function _waittill_trigger(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(!isPlayer(var1)) {
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

function bank_getspawneraitype(var0) {
  if(isDefined(var0.script_noteworthy)) {
    switch (var0.script_noteworthy) {
      case "jugg":
        return "actor_enemy_br_juggernaut";
      default:
        break;
    }
  }

  return "actor_enemy_br_base";
}

function airport_ecounterstart() {
  var0 = getEnt("ai_encounter_crate", "targetname");
  var0 movez(256, 0.05);
  wait 0.5;
  createnavobstaclebyent(var0);
  var1 = getEnt("kickoff_airport_encounter", "targetname");
  var1 waittill("trigger", var2);
  var3 = "smoke_grenade_mp";
  var4 = magicgrenademanual(var3, scripts\engine\utility::getStruct("airport_smoke_toss_pos", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos", "targetname").angles) * 400, 1);
  wait 0.1;
  var5 = magicgrenademanual(var3, scripts\engine\utility::getStruct("airport_smoke_toss_pos_02", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos_02", "targetname").angles) * 400, 1.3);
  var6 = magicgrenademanual(var3, scripts\engine\utility::getStruct("airport_smoke_toss_pos_03", "targetname").origin, anglesToForward(scripts\engine\utility::getStruct("airport_smoke_toss_pos_03", "targetname").angles) * 450, 2);
  var7 = getEnt("airport_vol_01", "targetname");
  wait 2;
  var8 = [];
  var9 = scripts\engine\utility::getStructArray("airport_enemy_wave_01", "targetname");

  foreach(var11 in var9) {
    var12 = targetstart_spawner(var11);
    var12 setgoalvolumeauto(var7);
    thread airport_enemy_setup();
    var8 = scripts\engine\utility::array_add(var8, var12);
  }

  var14 = getEnt("wave_01_overrun_trig", "targetname");
  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var8, var8.size);
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
  var0 = undefined;
  var1 = undefined;
  var2 = [];
  var3 = [];
  var4 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var6 in var4) {
    var7 = var6.script_noteworthy;

    if(!isDefined(var7)) {
      continue;
    }

    switch (var7) {
      case "start_trigger":
        var0 = var6;
        break;
      case "truck_enemy_wave":
        var2 = var6;
        break;
      case "roll_door":
        var1 = var6;
        thread truck_roll_door_init(var1);
        break;
      case "jump_down_node":
        var3 = var6;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var0 waittill("trigger", var9);

    if(isalive(var9) && isPlayer(var9)) {
      break;
    }
  }

  destroynavobstacle(var1 getentitynumber());
  truck_roll_door_open(var1);
  var10 = [];

  foreach(var12 in var2) {
    var13 = targetstart_spawner(var12);
    var10 = scripts\engine\utility::array_add(var10, var13);
  }

  scripts\mp\gametypes\br_ai_encounters_util::waittill_dead(var10, var10.size);
  encounter_end(1);
}

function truck_roll_door_init(var0) {
  self endon("encounter_end");

  if(!istrue(var0.init)) {
    var0.angle_ref = scripts\engine\utility::getStruct(var0.target, "targetname");

    if(!isDefined(var0.angle_ref.angles)) {
      var0.angle_ref.angles = (0, 0, 0);
    }

    var0.start_origin = var0.origin;
    var0.start_angles = var0.angles;
    var0.init = 1;
    return;
  }

  var0.origin = var0.start_origin;
  var0.angles = var0.start_angles;
}

function truck_roll_door_open(var0) {
  var0 rotatepitch(-90, 1);
  truck_roll_door_sound(var0);
  self notify("truck_roll_door_open");
}

function truck_roll_door_sound(var0) {
  var1 = 1000000;

  foreach(var3 in level.players) {
    if(isDefined(var3) && isalive(var3)) {
      if(distancesquared(var3.origin, var0.origin) <= var1) {
        var3 playSound("cp_bank_gate_fall");
      }
    }
  }
}

function truck_getspawneraitype(var0) {
  return "actor_enemy_br_base";
}

function crateguard_encounterstart() {
  self endon("encounter_end");
  self.func_getspawneraitype = &crateguard_getspawneraitype;
  self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_CRATE_GUARD";
  thread failcondition_noplayersinengagedradius(90);
  var0 = undefined;
  var1 = undefined;
  var2 = [];
  var3 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var5 in var3) {
    var6 = var5.script_noteworthy;

    if(!isDefined(var6)) {
      continue;
    }

    switch (var6) {
      case "guard":
        var2 = var5;
        break;
      case "guard_boss":
        var1 = var5;
        break;
      case "start_trigger":
        var0 = var5;
        break;
      default:
        break;
    }
  }

  for(;;) {
    var0 waittill("trigger", var8);

    if(isalive(var8) && isPlayer(var8)) {
      break;
    }
  }

  var9 = [];

  foreach(var11 in var2) {
    var12 = targetstart_spawner(var11);
    var9 = var12;
  }

  var14 = targetstart_spawner(var1);
  var9 = var14;
  GscBinSkip4(0x35, var14, var9);
}

function crateguard_bosssetup(var0, var1) {
  var0.ignoreall = 1;
  var2 = var1;
  GscBinSkip0(0x2e, var2.size, var0);
}

function crateguard_getspawneraitype(var0) {
  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "guard_boss") {
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

function smoking_idle(var0) {
  self endon("death");
  self endon("damage");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::burndowntime(var0);
    smoking_idle_end("smoking_idle_end");
  }
}

function smoking_idle_start(var0) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::burndowntime(var0);
}

function smoking_idle_end(var0) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::burndowntime(var0);
}

function smoking_react(var0) {
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

  scripts\asm\shared\mp\utility::burndowntime(var0);
  reset_guy(self);
}

function smoking_death(var0) {
  self endon("damage");
  self waittill("death");
  ai_smoking_cleanup();
}

function ai_notehandler_smoking(var0) {
  switch (var0) {
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
    var0 = randomintrange(5, 8);
    wait var0;
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

function standing_cellphone(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "stand_cellphone_death";
  thread ai_notetrack_loop("standing_cellphone");
  standing_cellphone_anim("stand_cellphone_intro");

  if(var0 > 0) {
    standing_cellphone_loop("stand_cellphone_loop", var0);
  }

  standing_cellphone_anim("stand_cellphone_exit");
}

function standing_cellphone_anim(var0) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::burndowntime(var0);
}

function standing_cellphone_loop(var0, var1) {
  self endon("death");
  self endon("damage");
  scripts\asm\shared\mp\utility::bunkeropened(var0, var1);
}

function ai_notehandler_cellphone(var0) {
  self endon("death");
  self endon("damage");

  switch (var0) {
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

function reset_guy(var0) {
  var0 allowedstances("prone", "stand", "crouch");
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0 setlookatentity();
  var0.headlook_enabled = 1;
  var0.disableautolookat = 0;
  var0.deathstate = undefined;
  var0.deathalias = undefined;
  var0.ignoreall = 0;
  var0.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function ai_notetrack_loop(var0) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("damage");

  for(;;) {
    self waittill("animscripted", var1);

    if(!isDefined(var1)) {
      var1 = ["undefined"];
    }

    if(!isarray(var1)) {
      var1 = [var1];
    }

    var2 = undefined;

    foreach(var4 in var1) {
      if(var0 == "smoking") {
        ai_notehandler_smoking(var4);
        continue;
      }

      if(var0 == "standing_cellphone") {
        ai_notehandler_cellphone(var4);
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
  var0 = undefined;
  var1 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var3 in var1) {
    var4 = var3.script_noteworthy;

    if(!isDefined(var4)) {
      continue;
    }

    switch (var4) {
      case "trigger_radius":
        var5 = 315;
        var6 = 120;
        var0 = spawn("trigger_radius", var3.origin, 0, int(var5), int(var6));
        break;
      default:
        break;
    }
  }

  if(!isDefined(var0)) {
    return;
  }

  level.setdomscriptablepartstatefunc = &domencounter_setdomscriptablepartstate;
  var8 = scripts\mp\gametypes\obj_dom::setupobjective(var0);
  var8.noscriptable = undefined;
  var8.vfxnamemod = "_300";
  var8.onuse = &domencounter_onuse;
  var8.onuseupdate = &domencounter_onuseupdate;
  var8.onenduse = &domencounter_onenduse;
  var8 scripts\mp\gameobjects::setvisibleteam("any");
  var8 scripts\mp\gametypes\obj_dom::domflag_setneutral();
  level.flagcapturetime = getdvarint("scr_ai_encounters_dom_use_time", 30);
  var8 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var8.encounterlocation = self;
  thread encounterdeletedomgameobjectonend(var8);
  thread icon_update_visibility(var8.objidnum);
}

function encounterdeletedomgameobjectonend(var0) {
  var0 endon("deleted");
  self waittill("encounter_end");

  foreach(var2 in var0.visuals) {
    var2 delete();
  }

  if(isDefined(var0.flagmodel)) {
    var0.flagmodel delete();
  }

  if(isDefined(var0.scriptable)) {
    var0.scriptable delete();
  }

  if(isDefined(var0.trigger)) {
    var0.trigger delete();
    var0.trigger = undefined;
  }

  thread gameobjectreleaseid_delayed();
  var0 notify("deleted");
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

function _setdomencountericoninfo(var0, var1, var2, var3) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 0;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = "icon_waypoint_dom_a";
  level.waypointpulses[var0] = var3;
}

function domencounter_onuseupdate(var0, var1, var2, var3) {
  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    self.didstatusnotify = 1;
    return;
  }
}

function domencounter_onuse(var0) {
  encounter_end(self.encounterlocation, 1, var0.team);
}

function domencounter_onenduse(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function domencounter_setdomscriptablepartstate(var0, var1, var2) {
  switch (var1) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      var1 = "using";

      if(isDefined(var2)) {
        var1 += var2;
      }

      self.scriptable setscriptablepartstate(var0, var1);

      if(var0 == "pulse") {
        self.scriptable setscriptablepartstate("flag", var1);
      }

      return 1;
  }
}

function bombplant_encounterstart() {}

function extraction_encounterstart() {
  iprintlnbold("EXTRACTION START");
  var0 = scripts\mp\gametypes\br_ai_encounters_util::get_targets();

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;

    if(!isDefined(var3)) {
      continue;
    }

    switch (var3) {
      case "use_object":
        extraction_createescort(var2);
        break;
      case "goal":
        targetstart_extractiongoal(var2);
        break;
      default:
        break;
    }
  }
}

function targetstart_extractiongoal(var0) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var1 = spawn("script_model", var0.origin + (0, 0, 20));
  var1 setModel("ctf_game_flag_east");
  self.goal = var1;
  var1.encounter = self;
}

function extraction_createescort(var0) {
  var1 = spawn("script_model", var0.origin + (0, 0, 20));
  var1 setModel("fullbody_usmc_ar");
  var1 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var1 scriptmodelpauseanim(1);
  var1 makeusable();
  var1 setCursorHint("HINT_NOICON");
  var1 setuseholdduration("duration_medium");
  var1 sethintrequiresholding(1);
  var1 sethintdisplayfov(120);
  var1 setusefov(120);
  var1 setuserange(80);
  var1 setHintString(&"MP_BR_USE_PLUNDER_CACHE");
  var1 setasgametypeobjective();
  var1 show();
  var1.readytoextract = 0;
  thread extraction_escortthink();
  self.escort = var1;
  var1.encounter = self;
}

function extraction_escortthink() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!self.readytoextract) {
      extraction_playerpickupbody(var0, self, var0.team);
      continue;
    }

    thread extraction_attachfultonballoontoescort(var0);
  }
}

function extraction_playerpickupbody(var0, var1) {
  self endon("droppedBody");
  var0 makeunusable();
  var2 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var2.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = var2;
  var0 scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  var0 linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  scripts\mp\gametypes\br_respawn::playersetcarryteammates(1);

  while(!self stancebuttonPressed() || !self isonground()) {
    waitframe();
  }

  extraction_dropbody(var0, self, var2, var1);
}

function extraction_dropbody(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    var1 allowads(1);
    var1 allowcrouch(1);
    var1 allowprone(1);
    var1 allowjump(1);
    scripts\mp\gametypes\br_respawn::playersetcarryteammates(0);
  }

  if(isDefined(var2)) {
    var2 destroy();
  }

  if(var0 islinked()) {
    var0 unlink();
  }

  var4 = undefined;

  if(isDefined(var1)) {
    var0.angles = var1.angles;
    var4 = var1.origin;
    var0.origin = var4 + (0, 0, 40);
  } else {
    var4 = var0.origin;
    var0.origin = var4 + (0, 0, 40);
  }

  var0 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var0 scriptmodelpauseanim(1);
  var0.origin = var4 + (0, 0, 1);
  var0 makeusable();

  if(extraction_checkescortradius(var0)) {
    extraction_changeescortusefunction(var0);
  }

  var0 notify("droppedBody");
}

function extraction_checkescortradius(var0) {
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

function extraction_attachfultonballoontoescort(var0) {
  encounter_end(self.encounter, 1);
  self.encounter.goal delete();
  self delete();
}

function destruction_encounterstart() {
  var0 = getscriptablearray(self.target, "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3.script_noteworthy;

    if(!isDefined(var4)) {
      continue;
    }

    switch (var4) {
      case "destroy":
        var1 = var3;
        break;
      default:
        break;
    }
  }
}