/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_538f66fce659a889.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\utility\teams;
#namespace namespace_dbc1018dd2e067e;

function inittask() {
  function_ac97a4f2ab8c2d53("loot", "tryAssignTask", &function_1a86afc387820604);
  function_ac97a4f2ab8c2d53("loot", "onPlayerSelectTask", &onplayerselecttask);
  function_ac97a4f2ab8c2d53("loot", "onTaskEnd", &function_afaacbffddff4911);
  function_ac97a4f2ab8c2d53("loot", "tryBindObjective", &trybindobjective);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerKioskUsed", &playerkioskused);
}

function function_1a86afc387820604(taskinstance) {
  thread function_78d7a14c7dfb37c4(taskinstance);
}

function function_78d7a14c7dfb37c4(taskinstance) {
  level endon("game_ended");
  taskinstance endon("task_end");

  while(true) {
    flag = taskinstance.info.subcategory + "_" + taskinstance.team;
    level waittill(flag, player, value, instance);

    if(taskinstance.info.subcategory == "open_loot_box") {
      function_dc3e112cadb47514(instance);
    }

    if(isDefined(player)) {
      player function_89b8bce3baa45edc(taskinstance, value);
    }
  }
}

function function_afaacbffddff4911(taskinstance) {
  foreach(player in getteamdata(taskinstance.team, "players")) {
    player onplayerselecttask(taskinstance, 0);
  }
}

function onplayerselecttask(taskinstance, selected) {
  if(taskinstance.info.subcategory == "buy_station_cash_spent") {
    self setclientomnvar("ui_champion_br_task_buy_station_hint", selected);
  }
}

function function_8e36f666c0242fe6(taskinstance, kiosk) {
  return !istrue(kiosk.disabled);
}

function function_44b2e353a03c56a5(taskinstance, lootcache) {
  partname = lootcache function_ec5f4851431f3382();
  state = lootcache getscriptablepartstate(partname, 1);
  return isDefined(state) && state == "closed_usable";
}

function trybindobjective(taskinstance) {
  switch (taskinstance.info.subcategory) {
    case #"hash_4245429f5ab3bc91":
      function_2e55101ffd0d483c(taskinstance, level.br_armory_kiosk.scriptables, &function_8e36f666c0242fe6);
      break;
    case #"hash_c66674337f5f82a6":
      function_2e55101ffd0d483c(taskinstance, function_3525b317dc93f4e9(), &function_44b2e353a03c56a5);
      break;
  }
}

function playerkioskused(kiosk) {
  if(isDefined(self.objectiveinfo) && isDefined(self.objectiveinfo.item.type) && self.objectiveinfo.item.type == "br_plunder_box") {
    removeobjectiveinfo();
  }
}

function function_dc3e112cadb47514(lootcache) {
  if(!isDefined(lootcache)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player.objectiveinfo) && player.objectiveinfo.item == lootcache) {
      player function_8fd21242a694aa72();
    }
  }
}

function function_3525b317dc93f4e9() {
  var_510c132b62d77d0a = ["br_loot_cache", "br_loot_cache_lege", "br_reusable_loot_cache"];
  return getlootscriptablearrayinradius(var_510c132b62d77d0a, undefined, self.origin, 10000);
}