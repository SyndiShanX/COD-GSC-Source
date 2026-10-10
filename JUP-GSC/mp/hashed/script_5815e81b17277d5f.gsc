/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5815e81b17277d5f.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\gasmask;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_public;
#namespace namespace_947f137e8c5c3d4;

function inittask() {
  function_ac97a4f2ab8c2d53("misc", "tryAssignTask", &function_1a86afc387820604);
  function_ac97a4f2ab8c2d53("misc", "checkTaskValid", &checktaskvalid);
}

function checktaskvalid(selectedtask, team) {
  if(selectedtask.subcategory == "equiped_full_armor") {
    foreach(player in level.teamdata[team]["players"]) {
      if(isDefined(player) && player scripts\cp_mp\armor::function_ac266fc218266d08() < player.maxarmorhealth) {
        return true;
      }
    }

    return false;
  } else if(selectedtask.subcategory == "picked_up_item_brloot_self_revive") {
    foreach(player in level.teamdata[team]["players"]) {
      if(isDefined(player) && !player scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
        return true;
      }
    }

    return false;
  } else if(selectedtask.subcategory == "picked_up_item_brloot_equip_gasmask") {
    foreach(player in level.teamdata[team]["players"]) {
      if(isDefined(player) && !scripts\cp_mp\gasmask::hasgasmask(player)) {
        return true;
      }
    }

    return false;
  }

  return false;
}

function function_1a86afc387820604(taskinstance) {
  flag = taskinstance.info.subcategory + "_" + taskinstance.team;

  if(taskinstance.info.subcategory == "equiped_full_armor") {
    thread function_ca3b60f5f124d2ad(flag, taskinstance);
    return;
  }

  if(taskinstance.info.subcategory == "picked_up_item_brloot_self_revive") {
    thread function_473b169b28634ac0(flag, taskinstance);
    return;
  }

  if(taskinstance.info.subcategory == "picked_up_item_brloot_equip_gasmask") {
    thread function_a1e5492242dcf7e5(flag, taskinstance);
  }
}

function function_ca3b60f5f124d2ad(flag, taskinstance) {
  level endon("game_ended");
  taskinstance endon("task_end");

  while(true) {
    level waittill(flag, player);
    var_876d422c8206879c = 1;

    foreach(player in level.teamdata[taskinstance.team]["players"]) {
      if(!isDefined(player) || player scripts\cp_mp\armor::function_ac266fc218266d08() < player.maxarmorhealth) {
        var_876d422c8206879c = 0;
        break;
      }
    }

    if(var_876d422c8206879c == 1 && isDefined(player)) {
      player function_89b8bce3baa45edc(taskinstance, 1);
    }
  }
}

function function_473b169b28634ac0(flag, taskinstance) {
  level endon("game_ended");
  taskinstance endon("task_end");

  while(true) {
    level waittill(flag, player);
    var_45b9b8130cdea6a5 = 1;

    foreach(player in level.teamdata[taskinstance.team]["players"]) {
      if(!isDefined(player) || !player scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
        var_45b9b8130cdea6a5 = 0;
        break;
      }
    }

    if(var_45b9b8130cdea6a5 == 1 && isDefined(player)) {
      player function_89b8bce3baa45edc(taskinstance, 1);
    }
  }
}

function function_a1e5492242dcf7e5(flag, taskinstance) {
  level endon("game_ended");
  taskinstance endon("task_end");

  while(true) {
    level waittill(flag, player);
    var_f1700ca637a7710f = 1;

    foreach(player in level.teamdata[taskinstance.team]["players"]) {
      if(!isDefined(player) || !scripts\cp_mp\gasmask::hasgasmask(player)) {
        var_f1700ca637a7710f = 0;
        break;
      }
    }

    if(var_f1700ca637a7710f == 1 && isDefined(player)) {
      player function_89b8bce3baa45edc(taskinstance, 1);
    }
  }
}