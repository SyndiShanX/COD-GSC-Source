/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_champion_task.gsc
********************************************************/

#using script_3b9af437ca74921e;
#using script_50d581b454b6d41d;
#using script_538f66fce659a889;
#using script_5815e81b17277d5f;
#using script_7273c20b83d8ff3b;
#using script_74661dc598ae1a43;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\points;
#namespace br_champion_task;

function init() {
  level.taskinfo = spawnStruct();
  level.taskinfo.task = [];
  level.taskinfo.totalweight = 0;
  level.taskinfo.tabletsearchradius = getdvarint(@ "hash_157892394561c040", 20000);
  level.taskinfo.category = [];
  level.taskinfo.maxnum = getdvarint(@ "hash_19d0a0659e587943", 3);
  level.taskinfo.unlockcountdown = [];
  level.taskinfo.unlockcountdown[0] = getdvarint(@ "hash_20142df6ea94bbfb", 30);
  level.taskinfo.unlockcountdown[1] = getdvarint(@ "hash_270a15b4f57b1367", 30);
  level.taskinfo.cooldowntime = getdvarint(@ "hash_6e0cc95268573ee8", 2);
  level.taskinfo.permanenttask = getDvar(@ "hash_3e231620461938e3", "");
  function_6d00ae53ce465992();
  loadtables();
  function_76e0d0742a7d2ebc();
  inittasks();
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerFirstLand", &onplayerfirstland);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPickupItemUsed", &onpickupitemused);
  level thread postprematch();
}

function inittasks() {
  namespace_8073b31fb342e7bb::inittask();
  namespace_a7d5183f69e271b0::inittask();
  namespace_fd6c84ecada320b::inittask();
  namespace_587d60d37119a29f::inittask();
  namespace_f8aa7c160140e21::inittask();
  namespace_ac1fbb84a83113b9::inittask();
}

function onplayerfirstland(player) {
  if(scripts\mp\flags::gameflag("prematch_done") && !istrue(player.br_isplayerbeforeinitialinfildeploy)) {
    level.teamdata[player.team]["taskInfo"].activated = 1;
  }
}

function function_a978c2984ee71b09(left, right) {
  return left.weight < right.weight;
}

function function_5d533973550bc682() {
  foreach(taskinfo in level.taskinfo.task) {
    if(taskinfo.scoreoverride > 0) {
      eventref = "champion_mission_" + taskinfo.ref + "_completed";
      scripts\mp\rank::registerscoreinfo(eventref, #"value", taskinfo.scoreoverride);
    }
  }
}

function registertaskid() {
  foreach(taskinfo in level.taskinfo.task) {
    eventref = "champion_mission_" + taskinfo.ref + "_completed";
    scripts\mp\rank::registerscoreinfo(eventref, #"hash_2a95da1330928b16", taskinfo.id);
  }
}

function function_6d00ae53ce465992() {
  var_592628de6512430c = getdvarint(@ "hash_3dfcd10ae7842553", 1);
  level.taskinfo.tasktable = ter_op(var_592628de6512430c == 1, "mp/brmission_champion_task.csv", "mp/brmission_champion_task_mixed_squad.csv");
  level.taskinfo.difficultytable = ter_op(var_592628de6512430c == 1, "mp/brmission_champion_task_difficulty.csv", "mp/brmission_champion_task_mixed_squad_difficulty.csv");
}

function function_76e0d0742a7d2ebc() {
  row = 0;
  difficultyweight = [];

  while(true) {
    finishednum = tablelookupbyrow(level.taskinfo.difficultytable, row, 0);

    if(!isDefined(finishednum) || finishednum == "") {
      break;
    }

    finishednum = int(finishednum);
    difficultyweight[finishednum] = [];
    curdifficulty = 0;

    for(i = 1; i <= 5; i++) {
      difficultyweight[finishednum][curdifficulty] = int(tablelookupbyrow(level.taskinfo.difficultytable, row, i));
      curdifficulty++;
    }

    row++;
  }

  assert(difficultyweight.size > 0);
  level.taskinfo.difficultyweight = difficultyweight;
}

function loadtables() {
  for(row = 0; true; row++) {
    taskref = tablelookupbyrow(level.taskinfo.tasktable, row, 1);

    if(!isDefined(taskref) || taskref == "") {
      break;
    }

    taskinfo = spawnStruct();
    taskinfo.ref = taskref;
    taskinfo.id = int(tablelookupbyrow(level.taskinfo.tasktable, row, 0));
    taskinfo.weight = int(tablelookupbyrow(level.taskinfo.tasktable, row, 2));
    taskinfo.category = tablelookupbyrow(level.taskinfo.tasktable, row, 3);
    taskinfo.subcategory = tablelookupbyrow(level.taskinfo.tasktable, row, 4);
    taskinfo.filteredcategory = tablelookupbyrow(level.taskinfo.tasktable, row, 5);
    taskinfo.targetnum = int(tablelookupbyrow(level.taskinfo.tasktable, row, 6));
    taskinfo.duration = int(tablelookupbyrow(level.taskinfo.tasktable, row, 7));
    taskinfo.objectiveicon = tablelookupbyrow(level.taskinfo.tasktable, row, 9);
    taskinfo.objectivedesc = tablelookupbyrow(level.taskinfo.tasktable, row, 10);
    taskinfo.scoreoverride = int(tablelookupbyrow(level.taskinfo.tasktable, row, 13));
    taskinfo.difficulty = int(tablelookupbyrow(level.taskinfo.tasktable, row, 14));
    assert(isDefined(taskinfo.ref));
    assert(isDefined(taskinfo.id));
    assert(isDefined(taskinfo.weight));
    assert(isDefined(taskinfo.category));
    level.taskinfo.task[level.taskinfo.task.size] = taskinfo;

    if(!isDefined(level.taskinfo.category[taskinfo.category])) {
      level.taskinfo.category[taskinfo.category] = spawnStruct();
      level.taskinfo.category[taskinfo.category].funcs = [];
    }
  }

  level.taskinfo.task = array_sort_with_func(level.taskinfo.task, &function_a978c2984ee71b09);

  foreach(task in level.taskinfo.task) {
    level.taskinfo.totalweight += task.weight;
  }
}

function postprematch() {
  level endon("game_ended");
  level waittill("prematch_done");
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_faf2c6a1a5a7aa93);
  function_5d533973550bc682();
  registertaskid();

  foreach(tablet in level.questinfo.activetablets) {
    tablet setscriptablepartstate(tablet.type, "hidden");
  }

  level thread function_8e45171e5c3a01be();
}

function function_ae0491bee1cd18b1(team) {
  level endon("game_ended");

  while(true) {
    waittime = level.taskinfo.unlockcountdown[self.var_e730e6b70780f72b];
    self.var_e730e6b70780f72b++;

    if(!isDefined(waittime)) {
      return;
    }

    wait waittime;
  }
}

function function_8e45171e5c3a01be() {
  level endon("game_ended");

  while(true) {
    foreach(entry in level.teamnamelist) {
      if(level.teamdata[entry]["alivePlayers"].size <= 0) {
        continue;
      }

      taskinfo = level.teamdata[entry]["taskInfo"];

      if(!isDefined(taskinfo)) {
        taskinfo = spawnStruct();
        taskinfo.tasklist = [];
        taskinfo.activated = 0;
        taskinfo.finishednum = 0;

        taskinfo.activated = getdvarint(@ "hash_25ad2925d6075c8f", 0) == 2;

        level.teamdata[entry]["taskInfo"] = taskinfo;
      }

      if(!istrue(taskinfo.activated)) {
        continue;
      }

      if(!isDefined(taskinfo.var_e730e6b70780f72b)) {
        taskinfo.var_e730e6b70780f72b = 0;
        taskinfo thread function_ae0491bee1cd18b1(entry);
      }

      if(isDefined(taskinfo.lastfinishtime) && taskinfo.lastfinishtime + level.taskinfo.cooldowntime * 1000 > gettime()) {
        continue;
      }

      if(taskinfo.tasklist.size < taskinfo.var_e730e6b70780f72b) {
        task = getnexttask(entry);
        tryassigntask(task, entry);
      }
    }

    wait 0.5;
  }
}

function function_a6cd232d5ae39984(team) {
  taskinfo = level.teamdata[team]["taskInfo"];
  finishednum = taskinfo.finishednum;

  if(taskinfo.finishednum >= level.taskinfo.difficultyweight.size) {
    finishednum = level.taskinfo.difficultyweight.size - 1;
  }

  difficultyweight = level.taskinfo.difficultyweight[finishednum];
  totalweight = 0;

  foreach(weight in difficultyweight) {
    totalweight += weight;
  }

  rand = randomintrange(1, totalweight + 1);
  curvalue = 0;
  difficulty = 1;

  for(i = 0; i < difficultyweight.size; i++) {
    curvalue += difficultyweight[i];

    if(curvalue >= rand) {
      difficulty = i;
      break;
    }
  }

  return difficulty;
}

function function_52c8c6ce1652ac8a(activetasklist) {
  if(level.taskinfo.permanenttask == "") {
    return undefined;
  }

  foreach(taskinstance in activetasklist) {
    if(taskinstance.info.ref == level.taskinfo.permanenttask) {
      return undefined;
    }
  }

  permanenttask = undefined;
  tasklist = level.taskinfo.task;

  foreach(task in tasklist) {
    if(task.ref == level.taskinfo.permanenttask) {
      permanenttask = task;
      break;
    }
  }

  return permanenttask;
}

function function_98e66ac4422e0a25(team, task, activecategories, currentdifficulty) {
  if(task.difficulty != currentdifficulty) {
    return true;
  }

  lasttask = level.teamdata[team]["taskInfo"].lasttask;
  var_598c27310477274 = isDefined(lasttask) && lasttask.filteredcategory == task.filteredcategory;
  return istrue(activecategories[task.filteredcategory]) || var_598c27310477274;
}

function getnexttask(team) {
  if(!isDefined(level.taskinfo.totalweight)) {
    return undefined;
  }

  activetasklist = level.teamdata[team]["taskInfo"].tasklist;
  permanenttask = function_52c8c6ce1652ac8a(activetasklist);

  if(isDefined(permanenttask)) {
    return permanenttask;
  }

  currentdifficulty = function_a6cd232d5ae39984(team);
  activecategories = [];

  foreach(task in activetasklist) {
    activecategories[task.info.filteredcategory] = 1;
  }

  filteredtasklist = [];
  maxweight = 0;

  foreach(task in level.taskinfo.task) {
    if(!function_98e66ac4422e0a25(team, task, activecategories, currentdifficulty)) {
      maxweight += task.weight;
      filteredtasklist[filteredtasklist.size] = task;
    }
  }

  if(maxweight <= 0) {
    return undefined;
  }

  rand = randomintrange(1, maxweight + 1);
  curvalue = 0;
  selectedtask = undefined;

  for(i = 0; i < filteredtasklist.size; i++) {
    curvalue += filteredtasklist[i].weight;

    if(curvalue >= rand) {
      selectedtask = filteredtasklist[i];
      break;
    }
  }

  return selectedtask;
}

function tryassigntask(selectedtask, team) {
  if(!isDefined(selectedtask)) {
    return;
  }

  taskfuncs = level.taskinfo.category[selectedtask.category].funcs;

  if(isDefined(taskfuncs["checkTaskValid"])) {
    isvalid = [[taskfuncs["checkTaskValid"]]](selectedtask, team);

    if(!isvalid) {
      return;
    }
  }

  taskinstance = function_2a01f2053fbdc8e4(selectedtask, team);
  [[taskfuncs["tryAssignTask"]]](taskinstance);

  if((issubstr(selectedtask.ref, "kill") || issubstr(selectedtask.ref, "down") || issubstr(selectedtask.ref, "damage")) && selectedtask.ref != "any_killstreak") {
    foreach(player in level.teamdata[team]["players"]) {
      if(!isbot(player)) {
        player.var_e54cc9323d3dc44e = 1;
      }
    }
  }

  if(selectedtask.duration != 0 && selectedtask.category != "tablet") {
    thread function_45ae11193c21e83a(taskinstance);
  }

  function_419ef70cfcbfafe(taskinstance, "assigned");
}

function function_2a01f2053fbdc8e4(selectedtask, team) {
  taskinfo = level.teamdata[team]["taskInfo"];
  taskinstance = spawnStruct();
  taskinstance.info = selectedtask;
  taskinstance.team = team;
  taskinstance.currentvalue = 0;

  for(i = 0; i < level.taskinfo.maxnum; i++) {
    if(!isDefined(taskinfo.tasklist[i])) {
      taskinfo.tasklist[i] = taskinstance;
      break;
    }
  }

  assert(taskinfo.tasklist.size <= level.taskinfo.maxnum, "<dev string:x1c>" + team);
  function_d0bdd994d7d8e9b9(taskinstance, selectedtask.id);
  function_e77af979434b2b4d(taskinstance, 0);
  function_f1c522713f6662fe(taskinstance);
  return taskinstance;
}

function function_32139ed00e90904a(taskinstance) {
  taskinfo = level.teamdata[taskinstance.team]["taskInfo"];

  for(i = 0; i < level.taskinfo.maxnum; i++) {
    if(isDefined(taskinfo.tasklist[i]) && taskinfo.tasklist[i] == taskinstance) {
      return i;
    }
  }

  return -1;
}

function function_89b8bce3baa45edc(taskinstance, value) {
  taskinstance.currentvalue += value;

  if(taskinstance.currentvalue >= taskinstance.info.targetnum) {
    getscore(taskinstance);
    ontaskend(taskinstance, "success");
    return;
  }

  function_e77af979434b2b4d(taskinstance, taskinstance.currentvalue);
}

function function_45ae11193c21e83a(taskinstance) {
  if(!isDefined(taskinstance)) {
    return;
  }

  level endon("game_ended");
  taskinstance endon("task_end");
  duration = taskinstance.info.duration;
  endtime = gettime() + duration * 1000;
  var_b10e35b5c472d03e = function_32139ed00e90904a(taskinstance) + 1;

  foreach(player in level.teamdata[taskinstance.team]["players"]) {
    player setclientomnvar("ui_champion_br_task" + var_b10e35b5c472d03e + "_countdown_timer", endtime);
  }

  wait duration;
  ontaskend(taskinstance, "timeout");
}

function ontaskend(taskinstance, result) {
  function_d0bdd994d7d8e9b9(taskinstance, 0);
  function_e77af979434b2b4d(taskinstance, 0);
  function_f1c522713f6662fe(taskinstance, result);
  function_a4762296e49d5615(taskinstance);
  taskinfo = level.teamdata[taskinstance.team]["taskInfo"];
  taskinfo.tasklist[function_32139ed00e90904a(taskinstance)] = undefined;
  taskinfo.lasttask = taskinstance.info;
  taskinfo.lastfinishtime = gettime();
  taskinfo.finishednum++;
  var_808a95cb8033c636 = 1;

  foreach(task in taskinfo.tasklist) {
    if((issubstr(task.info.ref, "kill") || issubstr(task.info.ref, "down") || issubstr(task.info.ref, "damage")) && task.info.ref != "any_killstreak") {
      var_808a95cb8033c636 = 0;
      break;
    }
  }

  if(var_808a95cb8033c636) {
    foreach(player in level.teamdata[taskinstance.team]["players"]) {
      if(!isbot(player) && istrue(player.var_e54cc9323d3dc44e)) {
        player.var_e54cc9323d3dc44e = undefined;
      }
    }
  }

  assert(taskinfo.tasklist.size >= 0, "<dev string:x4b>" + taskinstance.team);

  if(isDefined(result)) {
    if(result == "success") {
      function_419ef70cfcbfafe(taskinstance, "completed");
    } else if(result == "timeout") {
      function_419ef70cfcbfafe(taskinstance, "time_out");
    }
  }

  function_dc1ddf344f05f387(taskinstance);
  function_d306f944e9d41c98(taskinstance.info.category, "onTaskEnd", taskinstance);
  taskinstance notify("task_end");
}

function getscore(taskinstance) {
  taskinstance.needprocess = 1;
  eventref = "champion_mission_" + taskinstance.info.ref + "_completed";

  foreach(player in level.teamdata[taskinstance.team]["players"]) {
    player scripts\mp\utility\points::doscoreevent(function_1823ff50bb28148d(eventref));
  }
}

function function_7fd06dbd60481367(category, funclabel) {
  taskfuncs = level.taskinfo.category[category].funcs;
  return isDefined(taskfuncs) && isDefined(taskfuncs[funclabel]);
}

function function_ac97a4f2ab8c2d53(category, funclabel, func) {
  level.taskinfo.category[category].funcs[funclabel] = func;
}

function function_d306f944e9d41c98(category, funclabel, param1, param2) {
  assert(isDefined(level.taskinfo.category[category]));
  assert(isDefined(level.taskinfo.category[category].funcs));
  func = level.taskinfo.category[category].funcs[funclabel];

  if(isDefined(func)) {
    if(isDefined(param2)) {
      return [[func]](param1, param2);
    }

    if(isDefined(param1)) {
      return [[func]](param1);
    }

    return [[func]]();
  }
}

function function_4b70ee1a6ccda665(team) {
  var_e61e2fbf2fd48fc0 = [];
  index = 1;

  foreach(player in level.teamdata[team]["players"]) {
    if(index > 4) {
      break;
    }

    if(!isDefined(player.currenttask)) {
      var_e61e2fbf2fd48fc0[index] = 0;
    } else {
      clientnum = player getentitynumber();
      var_b10e35b5c472d03e = function_32139ed00e90904a(player.currenttask) + 1;
      value = clientnum;
      value = value << 4 | var_b10e35b5c472d03e;
      var_e61e2fbf2fd48fc0[index] = value;
    }

    index++;
  }

  return var_e61e2fbf2fd48fc0;
}

function function_5ce6ab0b7da3e97d(team) {
  var_e61e2fbf2fd48fc0 = function_4b70ee1a6ccda665(team);

  foreach(player in level.teamdata[team]["players"]) {
    for(i = 1; i <= 4; i++) {
      if(isDefined(var_e61e2fbf2fd48fc0[i])) {
        name = "ui_champion_player" + i + "_currentTask";
        player setclientomnvar(name, var_e61e2fbf2fd48fc0[i]);
      }
    }
  }
}

function function_a4762296e49d5615(taskinstance) {
  players = level.teamdata[taskinstance.team]["players"];

  foreach(player in players) {
    if(isDefined(player.currenttask) && player.currenttask == taskinstance) {
      player.currenttask = undefined;
    }
  }

  function_5ce6ab0b7da3e97d(taskinstance.team);
}

function function_d0bdd994d7d8e9b9(taskinstance, taskid) {
  var_b10e35b5c472d03e = function_32139ed00e90904a(taskinstance) + 1;

  if(var_b10e35b5c472d03e <= 0) {
    return;
  }

  omnvar = "ui_champion_br_task" + var_b10e35b5c472d03e + "_id";

  foreach(player in level.teamdata[taskinstance.team]["players"]) {
    player setclientomnvar(omnvar, taskid);
  }
}

function function_e77af979434b2b4d(taskinstance, taskvalue) {
  var_b10e35b5c472d03e = function_32139ed00e90904a(taskinstance) + 1;

  if(var_b10e35b5c472d03e <= 0) {
    return;
  }

  omnvar = "ui_champion_br_task" + var_b10e35b5c472d03e + "_value";

  foreach(player in level.teamdata[taskinstance.team]["players"]) {
    player setclientomnvar(omnvar, taskvalue);
  }
}

function function_f1c522713f6662fe(taskinstance, status) {
  var_b10e35b5c472d03e = function_32139ed00e90904a(taskinstance) + 1;

  if(var_b10e35b5c472d03e <= 0) {
    return;
  }

  omnvar = "ui_champion_br_task" + var_b10e35b5c472d03e + "_status";
  value = -1;

  if(isDefined(status)) {
    if(status == "timeout") {
      value = 0;
    } else if(status == "success") {
      value = 1;
    }
  }

  foreach(player in level.teamdata[taskinstance.team]["players"]) {
    player setclientomnvar(omnvar, value);
  }
}

function function_419ef70cfcbfafe(taskinstance, category) {
  if(!isDefined(taskinstance)) {
    return;
  }

  splashref = "br_champion_task_" + taskinstance.info.ref + "_" + category;
  splashid = scripts\mp\hud_message::function_73baf095c3b9cce6(splashref);

  if(!isDefined(splashid) || splashid < 0) {
    splashref = "br_champion_generic_task_" + category;
  }

  foreach(player in level.teamdata[taskinstance.team]["players"]) {
    player thread scripts\mp\hud_message::showsplash(splashref);
  }
}

function function_faf2c6a1a5a7aa93(channel, value) {
  if(channel != "champion_task_selected") {
    return;
  }

  tasklist = level.teamdata[self.team]["taskInfo"].tasklist;
  taskinstance = tasklist[value - 1];
  self.currenttask = taskinstance;
  function_5ce6ab0b7da3e97d(self.team);
  function_8fd21242a694aa72(taskinstance);

  foreach(task in tasklist) {
    selected = taskinstance == task;
    function_d306f944e9d41c98(task.info.category, "onPlayerSelectTask", task, selected);
  }
}

function function_2e55101ffd0d483c(taskinstance, items, objectivecheckfunc, iconheight, var_70696e1b9f55cbf7) {
  var_441c690181a13ac = undefined;
  target = undefined;

  foreach(item in items) {
    isvalid = [[objectivecheckfunc]](taskinstance, item);

    if(isvalid) {
      distancesq = distance2dsquared(item.origin, self.origin);

      if(!isDefined(var_441c690181a13ac) || distancesq < var_441c690181a13ac) {
        target = item;
        var_441c690181a13ac = distancesq;
      }
    }
  }

  function_709285b860caff8d(target, taskinstance, iconheight, var_70696e1b9f55cbf7);
}

function function_709285b860caff8d(target, taskinstance, iconheight, var_70696e1b9f55cbf7) {
  if(!isDefined(target)) {
    return;
  }

  if(!isDefined(iconheight)) {
    iconheight = 40;
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    objectiveinfo = spawnStruct();
    objectiveinfo.objectiveiconid = objectiveiconid;
    objectiveinfo.item = target;
    objectiveinfo.taskinstance = taskinstance;
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", target.origin, taskinstance.info.objectiveicon);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objectiveiconid, iconheight);

    if(istrue(var_70696e1b9f55cbf7) && isent(target)) {
      scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, target);
    }

    objective_setlabel(objectiveiconid, taskinstance.info.objectivedesc);
    objective_showtoplayersinmask(objectiveiconid);
    objective_addclienttomask(objectiveiconid, self);
    self.objectiveinfo = objectiveinfo;
  }
}

function onpickupitemused(pickupent) {
  if(!isDefined(pickupent.instance)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player.objectiveinfo) && player.objectiveinfo.item == pickupent.instance) {
      player.pickupitem = pickupent.instance;
      player function_8fd21242a694aa72();
      player.pickupitem = undefined;
    }
  }
}

function removeobjectiveinfo() {
  if(!isDefined(self.objectiveinfo)) {
    return;
  }

  taskinstance = self.objectiveinfo.taskinstance;

  if(function_7fd06dbd60481367(taskinstance.info.category, "removeObjectiveInfo")) {
    function_d306f944e9d41c98(taskinstance.info.category, "removeObjectiveInfo");
    return;
  }

  self.objectiveinfo notify("objective_removed");
  self.objectiveinfo.item scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();

  if(isDefined(self.objectiveinfo.objectiveiconid)) {
    self.objectiveinfo scripts\mp\gametypes\br_quest_util::deletequestobjicon();
  }

  self.objectiveinfo = undefined;
}

function function_dc1ddf344f05f387(taskinstance) {
  players = level.teamdata[taskinstance.team]["players"];

  foreach(player in players) {
    if(isDefined(player.objectiveinfo) && player.objectiveinfo.taskinstance == taskinstance) {
      player removeobjectiveinfo();
    }
  }
}

function function_8fd21242a694aa72(taskinstance) {
  if(!isDefined(taskinstance) && isDefined(self.objectiveinfo)) {
    taskinstance = self.objectiveinfo.taskinstance;
  }

  removeobjectiveinfo();

  if(isDefined(taskinstance)) {
    function_d306f944e9d41c98(taskinstance.info.category, "tryBindObjective", taskinstance);
  }
}