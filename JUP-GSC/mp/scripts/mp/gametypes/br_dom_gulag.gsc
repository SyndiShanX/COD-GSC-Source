/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_dom_gulag.gsc
****************************************************/

#using script_3583ff375ab3a91e;
#using script_5bc60484d17fa95c;
#using script_5cda031797dce489;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_dom_quest;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#namespace br_dom_gulag;

function function_53088602ea68d303() {
  level.var_5b530d6e84ac2128 = spawnStruct();
  level.var_5b530d6e84ac2128.var_3e34096b136f9a10 = 1;
  level.var_5b530d6e84ac2128.var_991a2d40ae12a427 = getdvarint(@ "hash_cb50d86a5a28600f", 1);
  level.var_5b530d6e84ac2128.domflagcapturetime = getdvarint(@ "hash_90416440e434dbf2", 20);
  level.var_5b530d6e84ac2128.var_a93342ffb3c354e6 = getdvarint(@ "hash_2bd3933013dd58e3", 0);
  level.var_5b530d6e84ac2128.var_4d40d2fec8e9c5b0 = getdvarint(@ "hash_4ccf8b7c96d2ffb8", 0);
  level.var_5b530d6e84ac2128.var_c96eee8d172a57c6 = getdvarint(@ "hash_6de1d9ca39cf2712", 6);
  level.var_5b530d6e84ac2128.var_9313e9bbea781aed = getdvarint(@ "hash_d7e49331fb4e8054", 1);
  level.var_5b530d6e84ac2128.var_659e35594c7fc814 = getdvarint(@ "hash_645bd13059493f28", 1);
  level.var_5b530d6e84ac2128.var_599c54cfd95addad = getdvarint(@ "hash_d6b5a1019326f578", 0);
  level.var_5b530d6e84ac2128.var_c47a2536cbdbc9d7 = getdvarint(@ "hash_bb2e63007cc6f524", 0);
  level.var_5b530d6e84ac2128.var_ab48b8f9eb30c8fc = getdvarint(@ "hash_97da3c665fa2e83", 1);
  level.var_5b530d6e84ac2128.var_f455b3807d4ea69d = getdvarint(@ "hash_4657318b9060b437", 0);
  level.var_5b530d6e84ac2128.var_17ee664650bd17cb = getdvarint(@ "hash_79e30fa9726a9ea1", 1);
  level.var_5b530d6e84ac2128.var_b7b9865ca59961d9 = getDvar(@ "hash_966a30fda4998d93", "40, 10, 20, 6, 10, 4, 1, 2");
  level.var_5b530d6e84ac2128.var_b5b3db55c42637c3 = getdvarint(@ "hash_d9d6e11ccdbf1f1c", -1);
  level.var_5b530d6e84ac2128.var_f2adaafe5f7860e8 = getdvarint(@ "hash_d6134717439619f9", 0);
  level.var_5b530d6e84ac2128.var_1e63c57879330b37 = getdvarint(@ "hash_f155a7e8658f9b9c", 1);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetMatchDuration", &function_ab54f9edc268063b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagTrackPlayerBulletHitAI", &function_cd7c7d0fc6adf4b1);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagTrackPlayerBulletHitPlayer", &function_cd7c7d0fc6adf4b1);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetMaxPlayers", &function_f9d544f605dde72a);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagIsMatchPending", &function_a48b4bedb9bd286);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetClosedCircleIndex", &function_db27ff4a01ba7ace);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagIsOneTeamLeft", &function_301ed1c7ac115606);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetVictoryWait", &function_370f0564e0b9d801);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetPostVictoryWait", &function_196c3ee37902ff93);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagHandleLossInfiniteEarly", &function_f9fae1b8f601f0ea);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagCanPlayerDropKey", &function_db60abb28498007b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGiveAIKillRewards", &function_3104d393dc6cc377);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagLoseSequence", &function_115aa986e2c13fea);
  level function_93add0b65db9f722(&function_6ec844085b807d62);
  level thread function_202939344423679c();

  if(!isDefined(level.supportsai)) {
    thread scripts\mp\ai_mp_controller::init();
  }

  if(namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8()) {
    level thread function_a504bd9ae48a23d8();
  }

  if(level.var_5b530d6e84ac2128.var_ab48b8f9eb30c8fc) {
    scripts\mp\gametypes\br_dom_quest::setupdom();
  }

  level thread function_25a296c2ed85e35f();
}

function function_202939344423679c() {
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_drive", &function_34c2ab381e6c17cb);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral", 2, "neutral", "MP/BR_DOM_GULAG_EXIT", "ui_mp_br_icon_gulag_escape_objective", 0);

  foreach(arena in level.gulag.arenas) {
    arena.goaldoors = [];
    arena.keys = [];
    arena.var_45e35b44ec23ab43 = [];
    arena.domflag = [];
    arena.domflaglocs = [];
    arena.ai_structs = [];
    arena.pathstructs = [];
    arena.cameralocations = [];

    if(level.var_43307855f189eb31.var_732a414f682801cc) {
      arena.lootpickedup = [];
    }

    arenastructs = getStructArray(arena.target, "targetname");

    foreach(arenastruct in arenastructs) {
      if(arenastruct.script_noteworthy == "gulag_dom_escape") {
        triggerwin = spawn("trigger_radius", arenastruct.origin, 0, 60, 10);
        triggerwin thread function_8de238b2a0070a51(arena);
        arena.goaldoors[arena.goaldoors.size] = triggerwin;
      }

      if(arenastruct.script_noteworthy == "gulag_dom_key" && level.var_43307855f189eb31.var_cddd2b80c91e5cab > 0) {
        if(arena.keys.size < level.var_43307855f189eb31.var_cddd2b80c91e5cab) {
          arena.keys[arena.keys.size] = spawnscriptable("second_chance_drive", arenastruct.origin);
        }
      }

      if(arenastruct.script_noteworthy == "gulag_dom_point") {
        arena.domflaglocs[arena.domflaglocs.size] = arenastruct.origin;
      }

      if(arenastruct.script_noteworthy == "gulag_dom_ai_spawn") {
        arena.ai_structs[arena.ai_structs.size] = arenastruct;
      }

      if(arenastruct.script_noteworthy == "patrolstart" || issubstr(arenastruct.script_noteworthy, "patrolpath")) {
        pathstruct = function_9edcf99159abb0b(arenastruct, issubstr(arenastruct.script_noteworthy, "looped"));
        arena.pathstructs[arena.pathstructs.size] = pathstruct;
      }

      if(arenastruct.script_noteworthy == "gulag_dom_cameras") {
        arena.cameralocations[arena.cameralocations.size] = arenastruct;
      }
    }

    function_36805f4856473b76(arena);
    level function_12495ee9a0fa83c2(arena);
    level thread function_f534043debef1e2a(arena);

    if(level.var_5b530d6e84ac2128.var_ab48b8f9eb30c8fc && arena.domflaglocs.size >= 1) {
      arenadomflag = function_a4f7aa7494769dcc(arena, arena.domflaglocs[0]);
      arenadomflag gulagdom_arenaflagsetvisible(arena, 0);
      arena.domflag[arena.domflag.size] = arenadomflag;

      if(isDefined(arena.domflaglocs) && arena.domflaglocs.size > 1) {
        arena.domflaglocs = array_randomize(arena.domflaglocs);
      }
    }
  }
}

function function_c68da8e2dde4dfa3(arena) {
  player = self;
  level endon("game_ended");
  var_6e5fdafe4800cd7d = "gulagai" + arena.gulagindex;
  var_1ce1b071385a88f0 = "gulagplayers" + arena.gulagindex;

  if(!threatbiasgroupexists(var_1ce1b071385a88f0)) {
    createthreatbiasgroup(var_1ce1b071385a88f0);
  }

  if(!threatbiasgroupexists(var_6e5fdafe4800cd7d)) {
    createthreatbiasgroup(var_6e5fdafe4800cd7d);
    setthreatbiasagainstall(var_6e5fdafe4800cd7d, -100000);
    setthreatbias(var_6e5fdafe4800cd7d, var_1ce1b071385a88f0, 2000);
  }

  if(isDefined(arena.var_707537a8904aa962)) {
    foreach(ai in arena.var_707537a8904aa962) {
      if(isagent(ai)) {
        ai setthreatbiasgroup(var_6e5fdafe4800cd7d);
      }
    }
  }

  foreach(domflag in arena.domflag) {
    domflag function_22d8a6225e699c6e(1);
    domflag gulagdom_arenaflagsetvisible(arena, 1);
  }

  player.var_4af73ce40a5d8572 = undefined;
  player.var_c6e39e2728d28253 = player.plundercount;
  player.var_a6e134ca7661708d = level.br_circle.circleindex + 1;
  player.var_c1e95b394ca1743d = arena.arenaplayers.size;
  player namespace_ad49798629176e96::function_63776b389e7c92c1();
  player namespace_ad49798629176e96::function_1167994a7ce49346();

  if(istrue(level.var_5b530d6e84ac2128.var_4d40d2fec8e9c5b0)) {
    player function_de9ddf5a99c3e235(0);
  }

  if(istrue(level.var_5b530d6e84ac2128.var_a93342ffb3c354e6)) {
    foreach(p in arena.arenaplayers) {
      if(p == player) {
        continue;
      }

      p thread namespace_ad49798629176e96::function_da46de174875958a(player);
    }
  }

  player setthreatbiasgroup(var_1ce1b071385a88f0);
  player thread gulagdom_trackplayerbullets();

  if(level.var_43307855f189eb31.var_732a414f682801cc && isDefined(arena.lootpickedup) && arena.lootpickedup.size > 0) {
    foreach(loot in arena.lootpickedup) {
      if(!isDefined(loot)) {
        continue;
      }

      loot setscriptablepartstate(loot.type, "visible");
    }

    arena.lootpickedup = [];
  }

  if(level.var_43307855f189eb31.var_26f27e5acf1b3864) {
    arenacenter = arena.center;
    lootcaches = getlootscriptablearray("br_loot_cache_gulag");

    foreach(cache in lootcaches) {
      if(distance(cache.origin, arenacenter) < 8000) {
        items = getscriptablelootcachecontents(cache);
        cache.contents = scripts\mp\gametypes\br_lootcache::function_ec87b214cd429e96(items, undefined);
        cache setscriptablepartstate("body", "closed_usable");
      }
    }
  }

  if(isDefined(arena.var_707537a8904aa962)) {
    arena.var_28a470799d66ecd7 = arena.var_707537a8904aa962.size;
  }

  if(isDefined(arena.arenaplayers)) {
    arena.var_b6b01621833467d1 = arena.arenaplayers.size;
  }

  if(isDefined(arena.var_45e35b44ec23ab43) && arena.var_45e35b44ec23ab43.size > 0) {
    foreach(keylocation in arena.var_45e35b44ec23ab43) {
      spawnscriptable("second_chance_drive", keylocation);
    }

    arena.var_45e35b44ec23ab43 = [];
  }

  player setclientomnvar("ui_match_start_countdown", 0);

  if(level.var_5b530d6e84ac2128.var_b5b3db55c42637c3 >= 0) {
    player scripts\mp\gametypes\br_plunder::playersetplundercount(2);
  }

  arena notify("ai_gulag_matchStarted");
}

function function_ab54f9edc268063b() {
  return getdvarfloat(@ "hash_8be34599dfa102b8", 150);
}

function function_f9d544f605dde72a() {
  return 99;
}

function function_a48b4bedb9bd286(nextmatch, arena) {
  return true;
}

function function_db27ff4a01ba7ace(offset) {
  return level.br_level.br_circledelaytimes.size - 1 - getdvarint(@ "scr_br_fc_circle_disable", 4) - offset;
}

function function_301ed1c7ac115606() {
  return false;
}

function function_370f0564e0b9d801() {
  return 2;
}

function function_196c3ee37902ff93() {
  return 2;
}

function function_8b208c4ca074aaeb(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player.plotarmor = 1;

  if(istrue(level.var_5b530d6e84ac2128.var_9313e9bbea781aed)) {
    player function_a593971d75d82113();
    player function_379bb555405c16bb("br_dom_gulag::gulagDom_matchStartCameraSequence()");
  }

  foreach(p in arena.arenaplayers) {
    if(p == player) {
      continue;
    }

    if(isDefined(p.team) && p.team == player.team) {
      color = "outline_nodepth_green";
    } else {
      color = "outline_nodepth_yellow";
    }

    player namespace_ad49798629176e96::function_da46de174875958a(p, color, 5.2);
  }

  foreach(agent in arena.var_707537a8904aa962) {
    player namespace_ad49798629176e96::function_da46de174875958a(agent, "outline_nodepth_red", -1);
  }

  if(level.var_43307855f189eb31.var_4749a3b876804ae5 == 1) {
    player namespace_ad49798629176e96::function_63cef9bb6769f404(arena);
  }

  if(istrue(level.var_5b530d6e84ac2128.var_9313e9bbea781aed)) {
    player function_6fb380927695ee76();
    player function_985b0973f29da4f8("br_dom_gulag::gulagDom_matchStartCameraSequence()");
  }

  player thread scripts\mp\hud_message::showsplash("br_dom_gulag_start");

  if(level.var_5b530d6e84ac2128.var_f2adaafe5f7860e8) {
    foreach(goaldoor in arena.goaldoors) {
      if(istrue(goaldoor.dooropen)) {
        player namespace_ad49798629176e96::function_6ce94cf4eee9eab7(goaldoor);
      }
    }
  }

  if(level.var_5b530d6e84ac2128.var_1e63c57879330b37) {
    foreach(p in arena.arenaplayers) {
      if(istrue(p.var_43b2a82936a5e974)) {
        player thread namespace_ad49798629176e96::function_da46de174875958a(p, "outline_nodepth_green");
      }
    }
  }

  player skydive_interrupt();
  player notify("gulag_done_with_camera_sequence");
  wait 2;

  if(!isDefined(player)) {
    return;
  }

  player.plotarmor = 0;
}

function gulagdom_trackplayerbullets() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulagDom_trackPlayerBullets");
  player endon("gulagDom_trackPlayerBullets");
  player endon("can_show_splashes");

  while(true) {
    player waittill("weapon_fired", objweapon);

    if(!isDefined(player.var_322535086c0890fa)) {
      player.var_322535086c0890fa = 0;
    }

    player.var_322535086c0890fa += 1;
  }
}

function function_8de238b2a0070a51(arena) {
  goaldoor = self;
  level endon("game_ended");

  while(true) {
    goaldoor waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && !istrue(player.var_4af73ce40a5d8572)) {
      if(!isDefined(player.var_c1057221e17f180b) || isDefined(player.var_c1057221e17f180b) && player.var_c1057221e17f180b == goaldoor) {
        if(istrue(player.var_43b2a82936a5e974)) {
          level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(player.origin, "revive", 1);
          goaldoor.dooropen = 1;
          goaldoor thread gulagdom_dooropened(arena);
          player function_ba3f4c627dcf8f8b(arena);
          player.var_43b2a82936a5e974 = undefined;
          continue;
        }

        if(istrue(goaldoor.dooropen) && !istrue(player.var_43b2a82936a5e974)) {
          player function_ba3f4c627dcf8f8b(arena);
        }
      }
    }
  }
}

function gulagdom_dooropened(arena) {
  goaldoor = self;
  goaldoor notify("gulagDom_DoorOpened");
  goaldoor endon("gulagDom_DoorOpened");

  foreach(p in arena.arenaplayers) {
    if(isDefined(p.var_c1057221e17f180b) && p.var_c1057221e17f180b == goaldoor) {
      continue;
    }

    p namespace_ad49798629176e96::function_6ce94cf4eee9eab7(goaldoor);
  }

  wait level.var_43307855f189eb31.dooropentime;
  goaldoor function_5f0d7586dda3b8db(arena);
  goaldoor.dooropen = 0;
}

function function_ba3f4c627dcf8f8b(arena) {
  player = self;
  player.var_4af73ce40a5d8572 = 1;
  player function_f63efa737ca0e7c1(arena);
}

function function_f63efa737ca0e7c1(arena) {
  player = self;

  if(level.var_5b530d6e84ac2128.var_b5b3db55c42637c3 >= 0) {
    var_9714ddda6a6df159 = player.plundercount + player.var_c6e39e2728d28253;
    player scripts\mp\gametypes\br_plunder::playersetplundercount(var_9714ddda6a6df159);
  }

  if(level.var_5b530d6e84ac2128.var_599c54cfd95addad) {
    player thread namespace_ad49798629176e96::function_a65df5d97ee38203(arena);
  }

  player namespace_ad49798629176e96::function_dcead2b56fdbf3e("gulag_key");
  player namespace_ad49798629176e96::function_3f18739ae34d9958();
  player function_de9ddf5a99c3e235(-1);
  player thread gulagvictory(arena, player, 1, 0, "gulag_ai", undefined, undefined, undefined, 1);

  foreach(goaldoor in arena.goaldoors) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(goaldoor.objid, player);
  }

  if(level.var_5b530d6e84ac2128.var_c47a2536cbdbc9d7) {
    if(isDefined(player.var_2c1b47fba58f503f)) {
      player.var_2c1b47fba58f503f destroy();
      player.var_2c1b47fba58f503f = undefined;
    }
  } else {
    player setclientomnvar("ui_br_special_item_acquired", 0);
  }

  foreach(domflag in arena.domflag) {
    domflag function_66cd97251e68435c(0, player);
  }

  if(namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8()) {
    player thread function_63a31da956c978ee();
  }
}

function function_115aa986e2c13fea(arena) {
  player = self;

  if(isDefined(self.var_2c1b47fba58f503f)) {
    self.var_2c1b47fba58f503f destroy();
    self.var_2c1b47fba58f503f = undefined;
  }

  foreach(domflag in arena.domflag) {
    domflag function_66cd97251e68435c(0, self);
  }

  if(self.health <= 0) {
    var_40d8983fc5e5c7a5 = "death_ai";
  } else {
    var_40d8983fc5e5c7a5 = "time_ran_out";
  }

  namespace_ad49798629176e96::function_dcead2b56fdbf3e(var_40d8983fc5e5c7a5);
  namespace_ad49798629176e96::function_3f18739ae34d9958();

  if(level.var_5b530d6e84ac2128.var_b5b3db55c42637c3 >= 0) {
    var_9714ddda6a6df159 = player.plundercount + player.var_c6e39e2728d28253;
    player scripts\mp\gametypes\br_plunder::playersetplundercount(var_9714ddda6a6df159);
  }
}

function function_34c2ab381e6c17cb(instance, part, state, player, bautouse, usestring) {
  if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return;
  }

  if(isDefined(player.var_43b2a82936a5e974)) {
    return;
  }

  player function_37f6a694b8c6656a();
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);
  arena.var_45e35b44ec23ab43[arena.var_45e35b44ec23ab43.size] = instance.origin;
  instance freescriptable();
}

function function_37f6a694b8c6656a() {
  player = self;
  var_f9cd7fda74e92e2a = 8;
  drawthroughgeo = 1;
  naturaldist = 500;
  maxdistance = 25000;
  iconname = "hud_icon_loot_key_skeleton";
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(isDefined(arena)) {
    foreach(p in arena.arenaplayers) {
      if(p == player) {
        continue;
      }

      p thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_enemy");

      if(level.var_5b530d6e84ac2128.var_f455b3807d4ea69d) {
        headicon = player scripts\cp_mp\entityheadicons::setheadicon_singleimage(p, iconname, var_f9cd7fda74e92e2a, drawthroughgeo, maxdistance, naturaldist, undefined, 1, 1, undefined);
        p thread function_fa6fe679b2067ac9(headicon, player);
        player thread function_e8a3fb7a095c39b8(headicon, p);
      }
    }
  }

  player.var_43b2a82936a5e974 = 1;

  if(level.var_5b530d6e84ac2128.var_17ee664650bd17cb == 0) {
    player function_6e29d1220ea1a70e();
  } else if(level.var_5b530d6e84ac2128.var_17ee664650bd17cb == 1) {
    player function_3c8729cdb6a4372b();
  } else if(level.var_5b530d6e84ac2128.var_17ee664650bd17cb == 2) {
    goaldoor = player function_c46cdee20f0bd709();
    player namespace_ad49798629176e96::function_6ce94cf4eee9eab7(goaldoor);
    player.var_c1057221e17f180b = goaldoor;
  }

  player thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_self");

  if(level.var_5b530d6e84ac2128.var_c47a2536cbdbc9d7) {
    player.var_2c1b47fba58f503f = player namespace_ad49798629176e96::function_573dfd8cb86d79f(&"MP/BR_DOM_GULAG_KEY_EARNED", undefined, "RIGHT", "CENTER", 90, 200);
  } else {
    player setclientomnvar("ui_br_special_item_acquired", 1);
  }

  if(level.var_5b530d6e84ac2128.var_1e63c57879330b37) {
    foreach(p in arena.arenaplayers) {
      if(p == player) {
        continue;
      }

      p thread namespace_ad49798629176e96::function_da46de174875958a(player, "outline_nodepth_green");
    }
  }
}

function function_c46cdee20f0bd709() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(!isDefined(arena)) {
    return;
  }

  doorsbydistance = sortbydistance(arena.goaldoors, player.origin);
  timeleft = abs((gettime() - player.arenastarttime + level.gulag.timelimit * 1000) / 1000);
  var_b7b9865ca59961d9 = strtok(level.var_5b530d6e84ac2128.var_b7b9865ca59961d9, " ");
  doorindex = 0;
  i = 0;

  while(i < var_b7b9865ca59961d9.size) {
    if(int(var_b7b9865ca59961d9[i]) < timeleft) {
      if(isDefined(var_b7b9865ca59961d9[i + 1])) {
        doorindex = var_b7b9865ca59961d9[i + 1];
      } else {
        doorindex = var_b7b9865ca59961d9[i - 1];
      }

      break;
    }

    i += 2;
  }

  return doorsbydistance[int(doorindex)];
}

function function_e8a3fb7a095c39b8(headicon, var_ca5a607c4f7a315) {
  playershowto = self;
  level endon("game_ended");
  var_ca5a607c4f7a315 endon("watchHeadIconDelete");
  waittill_any_ents(playershowto, "death", playershowto, "disconnect", playershowto, "gulag_end", playershowto, "gulagLost");

  if(!isDefined(playershowto)) {
    return;
  }

  removeclientfromheadiconmask(headicon, playershowto);
}

function function_fa6fe679b2067ac9(headicon, playershowto) {
  var_ca5a607c4f7a315 = self;
  level endon("game_ended");
  waittill_any_ents(var_ca5a607c4f7a315, "death", var_ca5a607c4f7a315, "disconnect", var_ca5a607c4f7a315, "gulag_end", var_ca5a607c4f7a315, "gulagLost");
  var_ca5a607c4f7a315 notify("watchHeadIconDelete");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
}

function function_12495ee9a0fa83c2(arena) {
  foreach(goaldoor in arena.goaldoors) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", goaldoor.origin + (0, 0, 60), "ui_mp_br_icon_gulag_exit_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
    } else {
      println("<dev string:x1c>");
    }

    goaldoor.objid = objid;
  }
}

function function_3c8729cdb6a4372b() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(!isDefined(arena)) {
    return;
  }

  closestdoor = arena.goaldoors[0];
  var_2b1cdedf8b109edb = distance(closestdoor.origin, player.origin);

  foreach(goaldoor in arena.goaldoors) {
    tempdistance = distance(goaldoor.origin, player.origin);

    if(var_2b1cdedf8b109edb > distance(goaldoor.origin, player.origin)) {
      closestdoor = goaldoor;
      var_2b1cdedf8b109edb = tempdistance;
    }
  }

  objective_addclienttomask(closestdoor.objid, player);
  objective_showtoplayersinmask(closestdoor.objid);
}

function function_5f0d7586dda3b8db(arena) {
  goaldoor = self;

  foreach(p in arena.arenaplayers) {
    if(isDefined(p.var_c1057221e17f180b) && p.var_c1057221e17f180b == goaldoor) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(goaldoor.objid, p);
  }
}

function function_6e29d1220ea1a70e() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  foreach(goaldoor in arena.goaldoors) {
    objective_addclienttomask(goaldoor.objid, player);
    objective_showtoplayersinmask(goaldoor.objid);
  }
}

function function_31b5a57beac56067() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";

  if(level.var_43307855f189eb31.matchstartweapons == 0) {
    loadout["loadoutPrimary"] = "iw9_me_fists";
  } else if(level.var_43307855f189eb31.matchstartweapons == 1) {
    loadout["loadoutPrimary"] = "iw9_pi_decho";
  } else if(level.var_43307855f189eb31.matchstartweapons == 2) {
    loadout["loadoutPrimary"] = "iw9_ar_mike4_mp";
  } else if(level.var_43307855f189eb31.matchstartweapons == 3) {
    loadout["loadoutPrimary"] = "iw9_sh_mbravo_mp";
  }

  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

function function_3104d393dc6cc377(arena) {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(!istrue(level.var_5b530d6e84ac2128.var_4d40d2fec8e9c5b0)) {
    return;
  }

  if(!isDefined(player.gulagkills)) {
    player.gulagkills = 0;
  }

  if(!isDefined(player.gulagaikills)) {
    player.gulagaikills = 0;
  }

  points = player.gulagkills + player.gulagaikills;
  wait 5;

  while(!player isonground()) {
    wait 0.5;
  }

  if(points >= 2) {
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(5);
  }

  if(points >= 6) {
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, 2);
  }

  if(points >= 8) {
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(10);
  }

  if(points >= 10) {
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_super_munitionsbox", 1);
  }
}

function function_6ec844085b807d62(agent, killer) {
  if(!isPlayer(killer)) {
    return;
  }

  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(killer);

  if(!isDefined(arena)) {
    return;
  }

  if(!isDefined(killer.gulagaikills)) {
    killer.gulagaikills = 0;
  }

  if(!isDefined(killer.gulagkills)) {
    killer.gulagkills = 0;
  }

  killer.gulagaikills += 1;

  if(istrue(level.var_5b530d6e84ac2128.var_4d40d2fec8e9c5b0)) {
    killer playsoundtoplayer("mp_killconfirm_tags_pickup", killer);
    killer function_de9ddf5a99c3e235(killer.gulagaikills + killer.gulagkills);
  }

  if(istrue(level.var_43307855f189eb31.var_6efb9d0afa7efcb2)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    agent thread scripts\mp\gametypes\br_pickups::function_55463a3679678e2f(dropstruct);
  }

  if(getdvarint(@ "hash_39d4d700e41d2edc", 1)) {
    spawnnode = arena.ai_structs[randomint(arena.ai_structs.size)];

    if(isDefined(agent.spawnnode)) {
      spawnnode = agent.spawnnode;
    }

    basetype = undefined;

    if(scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "subcategory") == "jugg") {
      basetype = "jugg";
    }

    agent thread function_62729cb2f806997a(arena, spawnnode, basetype);
  }
}

function function_d22e87091afd9fb7(attacker, victim) {
  if(!isDefined(attacker) || !isDefined(victim)) {
    return;
  }

  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(attacker);

  if(!isDefined(arena)) {
    return;
  }

  if(!isDefined(attacker.gulagkills)) {
    attacker.gulagkills = 0;
  }

  if(!isDefined(attacker.gulagaikills)) {
    attacker.gulagaikills = 0;
  }

  attacker.gulagkills += 1;

  if(istrue(level.var_5b530d6e84ac2128.var_4d40d2fec8e9c5b0)) {
    attacker playsoundtoplayer("mp_killconfirm_tags_pickup", attacker);
    attacker function_de9ddf5a99c3e235(attacker.gulagaikills + attacker.gulagkills);
  }

  if(isDefined(attacker.var_43b2a82936a5e974)) {
    return;
  }
}

function function_de9ddf5a99c3e235(value) {
  player = self;
  player setclientomnvar("ui_br_ai_gulag_score", value);
}

function function_6e49ea089039048a() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(!isDefined(arena)) {
    return;
  }

  firstplayerstatus = 0;
  var_4abdc6dfe813cd0e = 0;

  if(isDefined(arena.arenaplayers) && isDefined(arena.arenaplayers[0]) && isDefined(arena.arenaplayers[0].var_22f8f8d138d3c02f)) {
    firstplayerstatus = arena.arenaplayers[0].var_22f8f8d138d3c02f;
  }

  if(isDefined(arena.arenaplayers) && isDefined(arena.arenaplayers[1]) && isDefined(arena.arenaplayers[1].var_22f8f8d138d3c02f)) {
    var_4abdc6dfe813cd0e = arena.arenaplayers[1].var_22f8f8d138d3c02f;
  }

  assertex(firstplayerstatus < 16, "<dev string:x49>");
  assertex(var_4abdc6dfe813cd0e < 16, "<dev string:x8e>");

  var_3f65a52935223a7a = (var_4abdc6dfe813cd0e << 4) + firstplayerstatus;
  var_87b2be9fef844de = array_combine(arena.jailedplayers, arena.arenaplayers);

  foreach(p in var_87b2be9fef844de) {
    p setclientomnvar("ui_br_ai_gulag_player_state", var_3f65a52935223a7a);
  }
}

function function_19ecef885c1cec21(player) {
  for(i = 0; i < level.gulag.arenas.size; i++) {
    var_f40e6deec30ee209 = level.gulag.arenas[i];

    foreach(jailedplayers in var_f40e6deec30ee209.jailedplayers) {
      if(jailedplayers == player) {
        arena = level.gulag.arenas[i];
        return arena;
      }
    }
  }

  return undefined;
}

function function_9005af34e01bf8fe() {
  if(isDefined(level.var_5b530d6e84ac2128) && istrue(level.var_5b530d6e84ac2128.var_3e34096b136f9a10)) {
    return true;
  }

  return false;
}

function function_f79445ae166c7150(attacker, victim) {
  if(!function_9005af34e01bf8fe() || !isDefined(victim) || !isDefined(attacker)) {
    return false;
  }

  if(istrue(level.var_5b530d6e84ac2128.var_991a2d40ae12a427)) {
    return false;
  }

  if(isPlayer(victim) && isPlayer(attacker)) {
    if(istrue(victim.gulag) && istrue(attacker.gulag)) {
      return true;
    }
  }

  return false;
}

function function_db60abb28498007b() {
  player = self;

  if(isDefined(level.var_5b530d6e84ac2128) && istrue(level.var_5b530d6e84ac2128.var_3e34096b136f9a10) && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && istrue(player.var_43b2a82936a5e974) && istrue(level.var_43307855f189eb31.var_ec2eaa1a4b68c0cf)) {
    return true;
  }

  return false;
}

function function_cd7c7d0fc6adf4b1(eattacker, var_19ef223648735f8f) {
  if(function_9005af34e01bf8fe() && isDefined(eattacker) && istrue(eattacker.gulag) && isPlayer(eattacker)) {
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43(eattacker);

    if(isDefined(arena)) {
      if(!isDefined(eattacker.var_d25277121d9d0a6c)) {
        eattacker.var_d25277121d9d0a6c = 0;
      }

      eattacker.var_d25277121d9d0a6c = min(eattacker.var_d25277121d9d0a6c + 1, eattacker.var_322535086c0890fa);

      if(isDefined(var_19ef223648735f8f)) {
        if(!isDefined(eattacker.var_a6e0850023a9d8f9)) {
          eattacker.var_a6e0850023a9d8f9 = 0;
        }

        eattacker.var_a6e0850023a9d8f9 += var_19ef223648735f8f;
      }
    }
  }
}

function function_f534043debef1e2a(arena) {
  if(!isDefined(arena.var_707537a8904aa962)) {
    arena.aiset = 1;

    if(isDefined(arena.ai_structs)) {
      thread function_9971773d776c97ab(arena);
    }

    arena waittill("matchEnded");
    thread function_fb48c109b5c01f0(arena);
  }
}

function function_36805f4856473b76(arena) {
  category = "gulag";
  function_ba4022744dce59f6(category);
}

function function_9971773d776c97ab(arena) {
  if(namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena)) {
    thread function_89235e4fe5354b16(arena);
    return;
  }

  foreach(aispawn in arena.ai_structs) {
    thread function_7b5f223f3ea0fd5a(arena, aispawn);
  }
}

function function_7b5f223f3ea0fd5a(arena, aispawn) {
  aitype = "enemy_mp_smg_tier1_aq";
  spawnlocation = aispawn.origin;

  if(!getdvarint(@ "hash_b3d7a9483362813e", 0)) {
    spawnlocation = getclosestpointonnavmesh(aispawn.origin);
  }

  agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread function_65b46c19509929fe(arena);

    if(getdvarint(@ "hash_b3d7a9483362813e", 0)) {
      agent forceteleport(spawnlocation, aispawn.angles);
      agent setgoalpos(agent.origin, 32);
      agent clearpath();
      agent.fixednode = 1;
      agent thread function_b11c1964f528574b(agent, 1, agent.origin);
      return;
    }

    agent thread function_b11c1964f528574b(agent);
  }
}

function function_f6147f8ae8d6deb(arena) {
  if(!istrue(arena.aiset)) {
    function_f534043debef1e2a(arena);
  }

  var_c99a915a0dd0df12 = 0;

  if(var_c99a915a0dd0df12) {
    foreach(agent in arena.var_707537a8904aa962) {
      if(isagent(agent)) {}
    }
  }
}

function function_65b46c19509929fe(arena) {
  if(!isDefined(arena.var_707537a8904aa962)) {
    arena.var_707537a8904aa962 = [];
  }

  arena.var_707537a8904aa962 = array_add(arena.var_707537a8904aa962, self);

  foreach(player in arena.arenaplayers) {
    player namespace_ad49798629176e96::function_da46de174875958a(self, "outline_nodepth_red", -1);
  }
}

function function_6af7deb2b9a1dd06(arena) {
  if(isDefined(arena.var_707537a8904aa962)) {
    arena.var_707537a8904aa962 = array_remove(arena.var_707537a8904aa962, self);

    if(isagent(self)) {
      self notify("hidePlayerOutlineToPlayer");

      if(isalive(self)) {
        function_28b90eb2b591003f();
      } else {
        body = self getcorpseentity();

        if(isDefined(body)) {
          body delete();
        }
      }
    }

    if(arena.var_707537a8904aa962.size <= 0) {
      arena.var_707537a8904aa962 = undefined;
    }
  }
}

function function_fb48c109b5c01f0(arena) {
  if(isDefined(arena.var_707537a8904aa962)) {
    foreach(agent in arena.var_707537a8904aa962) {
      if(isagent(agent)) {
        agent function_6af7deb2b9a1dd06(arena);
        agent setthreatbiasgroup();
      }
    }

    arena.var_707537a8904aa962 = undefined;
    arena.aiset = undefined;
  }

  waitframe();
  var_2e903a90a966d9c2 = 2950;
  nearbyloot = getlootscriptablearrayinradius(undefined, undefined, arena.center, var_2e903a90a966d9c2);

  foreach(lootitem in nearbyloot) {
    if(lootitem getscriptableisreserved() && lootitem getscriptableisloot()) {
      lootitem scripts\mp\gametypes\br_pickups::deletescriptableinstance();
    }
  }
}

function function_a4f7aa7494769dcc(arena, flaglocation) {
  domradius = getdvarint(@ "hash_177d32d81bd6bc15", 130);
  domtrigger = spawn("trigger_radius", flaglocation, 0, domradius, 120);
  domtrigger.script_label = "_a";
  arenaflag = scripts\mp\gametypes\obj_dom::setupobjective(domtrigger, "neutral", undefined, 1);
  arenaflag.onuse = &function_ac9e0da4d9b4494d;
  arenaflag.onbeginuse = &function_f49d19b1b7acfa56;
  arenaflag.onenduse = &function_9a942fefe2c0e3b2;
  arenaflag.isarena = 1;
  arenaflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  arenaflag.id = "domFlag";
  arenaflag scripts\mp\gameobjects::setcapturebehavior("all_teams_dom_together");
  arenaflag.scriptable delete();
  arenaflag.ignorestomp = 1;
  arenaflag scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  arenaflag.visibilitymanuallycontrolled = 1;
  arenaflag function_22d8a6225e699c6e(1);
  arenaflag gulagdom_arenaflagsetvisible(arena, 1);
  arenaflag.arena = arena;
  return arenaflag;
}

function function_ac9e0da4d9b4494d(var_5ab435632b934364) {
  level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(self.flagmodel.origin, "revive", 1);
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(var_5ab435632b934364);
  var_2b24aedf3a828b22 = self.touchlist;
  function_22d8a6225e699c6e(0);
  thread gulagdom_arenaflagrestartdom(arena);

  if(!isDefined(arena)) {
    return;
  }

  foreach(teamtouching in var_2b24aedf3a828b22) {
    foreach(touchlist in teamtouching) {
      p = touchlist.player;

      if(!isDefined(p)) {
        continue;
      }

      if(!istrue(p.gulag)) {
        continue;
      }

      p function_9a942fefe2c0e3b2(p.team, p, 1);
      p function_66cd97251e68435c(0, p);
      p function_f63efa737ca0e7c1(arena);
    }
  }
}

function gulagdom_arenaflagrestartdom(arena) {
  arenaflag = self;
  level endon("game_ended");
  arenaflag notify("gulagDom_arenaFlagRestartDom");
  arenaflag endon("gulagDom_arenaFlagRestartDom");
  arenaflag gulagdom_arenaflagsetvisible(arena, 0);
  wait 3;
  arenaflag function_22d8a6225e699c6e(1);
  arenaflag gulagdom_arenaflagsetvisible(arena, 1);
  arenaflag.flagmodel playsoundonmovingent("flag_spawned");

  if(isDefined(arena.domflaglocs) && arena.domflaglocs.size > 1) {
    arena.domflaglocs = array_randomize(arena.domflaglocs);
  }

  index = randomint(arena.domflaglocs.size);
  location = arena.domflaglocs[index];
  arenaflag.flagmodel.origin = location;
  arenaflag.visuals[0].origin = location;
  arenaflag.trigger.origin = location;
  objective_position(arenaflag.objidnum, location + (0, 0, 100));
}

function function_f49d19b1b7acfa56(var_5ab435632b934364) {
  player = var_5ab435632b934364;
  player.iscapturing = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral" && isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 1);
  }

  self.didstatusnotify = 1;
  scripts\mp\gameobjects::setusetime(level.var_5b530d6e84ac2128.domflagcapturetime);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_taking", "waypoint_taking");
}

function function_9a942fefe2c0e3b2(team, player, success) {
  self.didstatusnotify = 0;

  if(success) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_dom_securing = undefined;
  }

  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  self.neutralized = 0;
}

function function_22d8a6225e699c6e(enable) {
  if(enable) {
    scripts\mp\gameobjects::allowuse("any");
    self.trigger scripts\engine\utility::trigger_on();
    return;
  }

  scripts\mp\gameobjects::allowuse("none");
  self.trigger scripts\engine\utility::trigger_off();
  scripts\mp\gameobjects::resetcaptureprogress();
}

function gulagdom_arenaflagsetvisible(arena, enable, preview, var_ddf49b0f7bd17a0c) {
  self notify("gulagDom_arenaFlagSetVisible");

  if(enable) {
    icon = "waypoint_captureneutral";

    if(istrue(preview)) {
      icon = level.iconovertime;
    }

    thread function_eec0f9596304fdbf(arena);
    thread scripts\mp\gameobjects::setobjectivestatusicons(icon);
    thread scripts\mp\gameobjects::setownerteam("neutral");
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0, "none");
    self.flagmodel show();
    thread function_b97c83e94112cc1a(arena, 1);

    if(!istrue(preview)) {
      setovertimeomnvarenabled(arena, 1);
    }

    return;
  }

  thread function_c47b28b610fc1026(arena, preview, var_ddf49b0f7bd17a0c);
}

function function_c47b28b610fc1026(arena, preview, var_ddf49b0f7bd17a0c) {
  self endon("arenaFlag_setVisible");

  if(!istrue(var_ddf49b0f7bd17a0c)) {
    objective_setpinned(self.objidnum, 0);
    wait 1;
  }

  thread function_b97c83e94112cc1a(arena, 0);
  thread function_5614184015570a1a(var_ddf49b0f7bd17a0c);
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0, "none");
  self.flagmodel hide(1);

  if(!istrue(preview)) {
    setovertimeomnvarenabled(arena, 0);
    setovertimeomnvarprogress(arena, 0);
  }
}

function function_eec0f9596304fdbf(arena) {
  objective_removeallfrommask(self.objidnum);

  foreach(player in arena.arenaplayers) {
    objective_addclienttomask(self.objidnum, player);
  }

  objective_showtoplayersinmask(self.objidnum);
}

function function_5614184015570a1a(var_ddf49b0f7bd17a0c) {
  objective_setshowprogress(self.objidnum, 0);
  objective_removeallfrommask(self.objidnum);
  objective_showtoplayersinmask(self.objidnum);
}

function function_b97c83e94112cc1a(arena, enable) {
  if(!isDefined(arena) || !isDefined(arena.arenaplayers)) {
    return;
  }

  if(enable) {
    if(arena.arenaplayers.size > 0) {
      self.flagmodel hudoutlineenableforclients(arena.arenaplayers, "outline_nodepth_orange");
    }

    return;
  }

  if(arena.arenaplayers.size > 0) {
    self.flagmodel hudoutlinedisableforclients(arena.arenaplayers);
  }
}

function function_66cd97251e68435c(enable, player) {
  player endon("death_or_disconnect");

  if(enable) {
    player setclientomnvar("ui_overtime_timer_show", 1);
    objective_addclienttomask(self.objidnum, player);
  } else {
    objective_unpinforclient(self.objidnum, player);
    wait 1;
    player setclientomnvar("ui_overtime_timer_show", 0);
    objective_removeclientfrommask(self.objidnum, player);
  }

  thread arenaflag_showflagoutlineplayer(enable, player);
}

function function_a504bd9ae48a23d8() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait level.var_5b530d6e84ac2128.var_c96eee8d172a57c6;

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      continue;
    }

    player kill();
    wait 1;
  }
}

function function_63a31da956c978ee() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 13;
  player kill();
}

function function_f9fae1b8f601f0ea(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player namespace_ad49798629176e96::function_3f18739ae34d9958();

  if(isDefined(arena.goaldoors)) {
    foreach(goaldoor in arena.goaldoors) {
      if(isDefined(goaldoor) && isDefined(goaldoor.objid) && isDefined(player)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(goaldoor.objid, player);
      }
    }
  }

  if(level.var_5b530d6e84ac2128.var_c47a2536cbdbc9d7) {
    if(isDefined(player.var_2c1b47fba58f503f)) {
      player.var_2c1b47fba58f503f destroy();
      player.var_2c1b47fba58f503f = undefined;
    }
  } else {
    player setclientomnvar("ui_br_special_item_acquired", 0);
  }

  foreach(domflag in arena.domflag) {
    domflag function_66cd97251e68435c(0, player);
  }

  if(player.health <= 0) {
    wait 6;

    if(!isDefined(player)) {
      return;
    }

    player.gulag = 0;
    teammate = player;
    teammates = level.teamdata[player.team]["players"];

    foreach(p in teammates) {
      if(p == player) {
        continue;
      }

      teammate = p;
    }

    if(isDefined(teammate)) {
      teammate = teammates[0];
      teammate scripts\mp\gametypes\br_pickups::addrespawntoken(1);
      player playergulagautowin("domGulag", teammate);
      wait 6;

      if(!isDefined(player)) {
        return;
      }

      player kill();
    }

    return;
  }

  player thread gulagvictory(arena, player, 1, 0, "shutdown");
  wait 9;

  if(!isDefined(player)) {
    return;
  }

  player kill();
}