/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_373f30c324803ba4.gsc
*************************************************/

#using script_5bc60484d17fa95c;
#using scripts\common\callbacks;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\trigger;
#namespace namespace_e05e905a3c01778f;

function autoexec main() {
  if(getdvarint(@ "hash_bee6f271b3232348", 0) == 1) {
    return;
  }

  level.var_2c4cb267d8d1cd85 = 1;
  function_7e4ada39cadeebf8();
  scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2("setupArena", &function_6fb82c7fdd547028);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("toggleLadderEscape", &function_acdf468e29550c88);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("removeLadderEscape", &function_13f686fc9f3c8840);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("getWinnerDialogOverride", &function_c8608aeb89ed5e36);
}

function function_7e4ada39cadeebf8() {
  level.var_4ca747cc86970811 = spawnStruct();
  level.var_4ca747cc86970811.shoulddelete = getdvarint(@ "hash_ef004c609f89f55", 0);
  level.var_4ca747cc86970811.waitforovertime = getdvarint(@ "hash_a53cd15a02823fc9", 0);
  level.var_4ca747cc86970811.var_7b8d762cf8c85dec = getdvarfloat(@ "hash_69b3f8dd2b6eaa4c", 1.5);
  level.var_4ca747cc86970811.rewardref = getDvar(@ "hash_929b4f3e72a26e65", "brloot_plunder_cash_rare_2");
  level.var_4ca747cc86970811.rewardamount = getdvarint(@ "hash_c8c6890374c076a4", 350);
}

function function_6fb82c7fdd547028(arena) {
  if(arena.ladders.size < 1) {
    return 0;
  }

  arena.var_80c48c7b9faeb550 = 0;
  arena.var_82c16918e12ad681 = undefined;
  function_85177aa5ffd825a(arena);

  foreach(ladderstruct in arena.ladders) {
    ladderstruct.arena = arena;

    if(!isDefined(ladderstruct.target)) {
      function_7e7f61cb536d3c0c(ladderstruct);
      continue;
    }

    function_a9218c1e84d16a40(ladderstruct);
  }
}

function function_a9218c1e84d16a40(ladderstruct) {
  components = getEntArray(ladderstruct.target, "targetname");

  foreach(component in components) {
    switch (component.script_noteworthy) {
      case #"hash_ba8af33d960fd422":
        ladderstruct.brush = component;
        break;
      case #"hash_fe0a0e43f6c24fa2":
        ladderstruct.trigger = component;
        scripts\mp\utility\trigger::makeenterexittrigger(ladderstruct.trigger);
        break;
    }
  }

  scriptables = getentitylessscriptablearray(ladderstruct.target, "targetname");

  foreach(scriptable in scriptables) {
    switch (scriptable.script_noteworthy) {
      case #"hash_d023a1ffba25729d":
        ladderstruct.animatedmodel = scriptable;
        break;
      case #"hash_867a7b9fb57d6788":
        ladderstruct.protector = scriptable;
        break;
    }
  }

  ladderstruct.down = 0;

  if(isDefined(ladderstruct.brush)) {
    ladderstruct.brush.origin -= (0, 0, 144);
    ladderstruct.brush notsolid();
  }

  if(!function_9ab1c5b876dc8c7c(ladderstruct) || level.var_4ca747cc86970811.shoulddelete) {
    function_7e7f61cb536d3c0c(ladderstruct);
    return;
  }

  function_a20583b52edba770(ladderstruct);
  function_a4b1de48eb1290a4(ladderstruct);
}

function function_9ab1c5b876dc8c7c(ladderstruct) {
  return isDefined(ladderstruct.animatedmodel) && isDefined(ladderstruct.trigger);
}

function function_a20583b52edba770(ladderstruct) {
  lootnode = spawnStruct();
  lootnode.origin = ladderstruct.trigger.origin - (0, 0, 10);
  lootnode.angles = ladderstruct.animatedmodel.angles + (0, 90, 0);
  lootnode.payload = 0;
  ladderstruct.var_db37a868a5f5fe34 = lootnode;
}

function function_a4b1de48eb1290a4(ladderstruct) {
  trigger = ladderstruct.trigger;
  model = ladderstruct.animatedmodel;
  position = (model.origin[0], model.origin[1], trigger.origin[2] + 50);
  trigger.origin = position;
}

function function_acdf468e29550c88(arena, activate) {
  if(arena.ladders.size < 1 || !istrue(arena.ladderescape)) {
    return 0;
  }

  if(arena.var_80c48c7b9faeb550 == activate) {
    return 0;
  }

  if(!activate) {
    arena notify("ladder_escape_stop_watcher");
    scripts\mp\gametypes\br_analytics::function_a951471036bd80de(arena.var_72b377bfe92c3499, arena.ladderkill);
    function_85177aa5ffd825a(arena);
    function_f88a5e25e9290dcf(arena);
  } else {
    foreach(player in arena.arenaplayers) {
      thread function_ef17db4d092d9b5e(player, arena);
    }

    function_4b188b3d73cd1824(arena);
  }

  arena.var_80c48c7b9faeb550 = activate;
  arena.var_82c16918e12ad681 = undefined;

  foreach(ladderstruct in arena.ladders) {
    thread function_3d9356bf0e591d4e(ladderstruct, activate);
    function_26e6507f5ae3fe8e(ladderstruct, activate);
  }
}

function function_3d9356bf0e591d4e(ladderstruct, down) {
  if(ladderstruct.down == down) {
    return;
  }

  state = scripts\engine\utility::ter_op(istrue(ladderstruct.down), "up", "down");

  if(down) {
    if(level.var_4ca747cc86970811.waitforovertime) {
      ladderstruct.arena waittill("gulag_overtime_started");
    } else {
      wait level.var_4ca747cc86970811.var_7b8d762cf8c85dec;
    }

    if(isDefined(ladderstruct.brush)) {
      ladderstruct.brush solid();
    }
  } else if(isDefined(ladderstruct.brush)) {
    ladderstruct.brush notsolid();
  }

  ladderstruct.down = !ladderstruct.down;
  ladderstruct.animatedmodel setscriptablepartstate("ladder", state);
  ladderstruct.protector setscriptablepartstate("protector", state);
}

function function_26e6507f5ae3fe8e(ladderstruct, activate) {
  trigger = ladderstruct.trigger;
  arena = ladderstruct.arena;

  if(activate) {
    thread function_6eb8ca12ec6fc71(ladderstruct, arena);
  }
}

function function_4b188b3d73cd1824(arena) {
  foreach(ladderstruct in arena.ladders) {
    if(isDefined(ladderstruct.var_db37a868a5f5fe34)) {
      item = scripts\mp\gametypes\br_pickups::spawnpickup(level.var_4ca747cc86970811.rewardref, ladderstruct.var_db37a868a5f5fe34, level.var_4ca747cc86970811.rewardamount, undefined, undefined, 1);
      item.var_1b46a808091ea19c = 1;
      ladderstruct.plunder = item;
    }
  }
}

function function_ef17db4d092d9b5e(player, arena) {
  player callbacks::add("player_death", &function_c7b98110b2dbff43, arena);
  player waittill_any_2("gulag_end", "death");
  player callbacks::remove("player_death", &function_c7b98110b2dbff43);
}

function private function_c7b98110b2dbff43(params, arena) {
  player = self;
  attacker = params.attacker;
  objweapon = params.objweapon;

  if(player isonladder() && attacker isonladder() && objweapon.classname == "pistol") {
    arena.var_82c16918e12ad681 = "gulag_ladder_escape_kill";
    arena.ladderkill = 1;
  }
}

function function_c8608aeb89ed5e36(arena) {
  return arena.var_82c16918e12ad681;
}

function function_6eb8ca12ec6fc71(ladderstruct, arena) {
  arena endon("ladder_escape_stop_watcher");
  trigger = ladderstruct.trigger;

  while(true) {
    trigger waittill("trigger_enter", player);

    if(!player isonascender()) {
      function_f320d154ca60c728(ladderstruct, player);
      thread function_cc61daea9bf5854c(arena, player);
    }
  }
}

function function_f320d154ca60c728(ladderstruct, player) {
  plunder = ladderstruct.plunder;

  if(!isDefined(plunder)) {
    return;
  }

  scripts\mp\gametypes\br_pickups::lootused(plunder, plunder.type, "visible", player);
}

function function_cc61daea9bf5854c(arena, player) {
  player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();

  if(namespace_eb17b46cdcb98eea::function_1980065ce4dc067b()) {
    player scripts\mp\gametypes\br_twotwo_gulag::function_dc0a56e258889cb(arena, "br_twotwo_gulag_win_ladder_escape");
    arena.var_72b377bfe92c3499 += 1;
  }

  if(!istrue(arena.overtime)) {
    arena.forceovertime = 1;
    function_69c78f5a75eafdfc(arena);
  }

  if(arena.arenaplayers.size < 1) {
    arena notify("matchEnded");
    scripts\mp\gametypes\br_gulag::handleendarena(arena);
    arena notify("fight_over_early");
  }
}

function function_85177aa5ffd825a(arena) {
  arena.var_72b377bfe92c3499 = 0;
  arena.ladderkill = 0;
}

function function_69c78f5a75eafdfc(arena) {
  foreach(ladderstruct in arena.ladders) {
    ladderstruct.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid();

    if(ladderstruct.objidnum == -1) {
      return;
    }

    scripts\mp\objidpoolmanager::objective_add_objective(ladderstruct.objidnum, "current", ladderstruct.animatedmodel.origin, "ui_map_icon_obj_gulag_escape");
    scripts\mp\objidpoolmanager::update_objective_setbackground(ladderstruct.objidnum, 1);
    scripts\mp\objidpoolmanager::function_9cad42ac02eff950(ladderstruct.objidnum);

    foreach(player in arena.arenaplayers) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(ladderstruct.objidnum, player);
    }
  }
}

function function_f88a5e25e9290dcf(arena) {
  foreach(ladderstruct in arena.ladders) {
    scripts\mp\objidpoolmanager::returnobjectiveid(ladderstruct.objidnum);
    ladderstruct.objidnum = -1;
  }
}

function function_13f686fc9f3c8840(arena) {
  if(arena.ladders.size < 1) {
    return 0;
  }

  foreach(ladderstruct in arena.ladders) {
    function_7e7f61cb536d3c0c(ladderstruct);
  }
}

function function_7e7f61cb536d3c0c(ladderstruct) {
  arena = ladderstruct.arena;

  if(isDefined(ladderstruct.animatedmodel)) {
    ladderstruct.animatedmodel freescriptable();
  }

  if(isDefined(ladderstruct.brush)) {
    ladderstruct.brush delete();
  }

  if(isDefined(ladderstruct.trigger)) {
    ladderstruct.trigger delete();
  }

  arena.ladders = arrayremove(arena.ladders, ladderstruct);
  ladderstruct = undefined;
}