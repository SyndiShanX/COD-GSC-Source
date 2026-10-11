/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_25d8bf4d117350f3.gsc
*************************************************/

#using script_3c30ef2503c2a953;
#using script_4fa7e9e11630166c;
#using script_711820027508efbb;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#namespace namespace_10816918163162;

function function_58176ae2f61825a8() {
  level flag_wait("ai_spawn_director_initialized");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.var_d23aeb1751c691a3 = [];
  level.var_1509c2e9eb38fea3 = [];
  level.var_5926e65ed5e4e5f8 = [];
  level.var_7331656f47ade43f = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("enc_toc_rescue_inside");
  level.var_93b887bd4bbdf9e3 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("enc_toc_rescue_defend");
  assert(isDefined(level.var_7331656f47ade43f), "<dev string:x1c>");
  assert(isDefined(level.var_93b887bd4bbdf9e3), "<dev string:x60>");

  if(!isDefined(level.var_7331656f47ade43f) || !isDefined(level.var_93b887bd4bbdf9e3)) {
    return;
  }

  function_f0cc0f2e6e1d085e(level.var_7331656f47ade43f, &function_3a3634d428236cb6);
  function_bc5315dc37ae4cf(level.var_93b887bd4bbdf9e3, &function_c05065e628cbd604);
  level thread function_1a529ef6a18ffe76();
  function_4edc29577f7e3d27();
  function_fc38783a3da0bc71(level.var_7331656f47ade43f, 1);

  if(getdvarint(@ "hash_dc2e92cfc46a05c2", 0)) {
    function_fc38783a3da0bc71(level.var_93b887bd4bbdf9e3, 1);
  }

  function_f66b9a343a32f313();
  level thread function_a802ed3ab73c2c37();
}

function function_e7fbcc8e485e01de() {
  wait 1;
  function_d5109375e2029bee();
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_RESCUEINTRO";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  scripts\cp_mp\overlord::playconversation("s2_soldiers_truce", level.players);
}

function function_3a3634d428236cb6(requestid, userdata) {
  level thread function_3ded3136b512013c();
}

function function_3ded3136b512013c() {
  while(true) {
    if(istrue(level.var_70ac71107500c644)) {
      break;
    }

    waitframe();
  }

  function_a39e9894083f4513(level.var_7331656f47ade43f);
}

function function_1a529ef6a18ffe76() {
  trigger = getnoentvolumearray("enc_toc_rescue_inside_trigger", "targetname");

  if(!isarray(trigger) || trigger.size <= 0 || trigger.size > 1) {
    assert(isarray(trigger), "<dev string:xa4>");
    assert(trigger.size > 0, "<dev string:xa4>");
    assert(trigger.size <= 1, "<dev string:x125>");
  }

  trigger = trigger[0];

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isalive(ent)) {
      level.var_70ac71107500c644 = 1;
      return;
    }
  }
}

function function_c05065e628cbd604(requestid, userdata) {
  return istrue(level.var_8b32fbd513ff5438);
}

function function_4edc29577f7e3d27() {
  triggervolumes = getnoentvolumearray("enc_toc_rescue_begin_defend_trigger", "targetname");

  if(!isDefined(triggervolumes) || !isarray(triggervolumes) || triggervolumes.size <= 0) {
    assert(0, "<dev string:x1a6>");
    return;
  }

  foreach(trigger in triggervolumes) {
    level thread function_b31a883b4154eb6d(trigger);
  }
}

function function_b31a883b4154eb6d(trigger) {
  level endon("toc_rescue_defend_begin_trigger_entered");

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isalive(ent)) {
      level.var_8b32fbd513ff5438 = 1;

      if(isDefined(level.var_d23aeb1751c691a3)) {
        foreach(soldier in level.var_d23aeb1751c691a3) {
          if(isDefined(soldier) && isalive(soldier)) {
            soldier.ignoreme = 0;
          }
        }
      }

      function_606642b946a01237("ambient_blocker_to_rescue", level.var_d23aeb1751c691a3[0].origin, 1000, 0);

      if(getdvarint(@ "hash_dc2e92cfc46a05c2", 0)) {
        level thread function_51268e6989b69634();
        level thread function_e9cd27cd39ef516c();
      } else {
        level thread function_907a00c8fa552ad2();
      }

      level notify("toc_rescue_defend_begin_trigger_entered");
      return;
    }

    waitframe();
  }
}

function function_51268e6989b69634() {
  var_e4d1678cede76da0 = 60;

  if(getdvarint(@ "hash_e8937d06187b99ba", 0) > 0) {
    var_e4d1678cede76da0 = getdvarint(@ "hash_e8937d06187b99ba", 0);
  }

  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_RIFT_S2_RESCUEINTRO_PROTECT", level.players);
  scripts\cp_mp\overlord::playevent("s2_toc_defend_start", level.players);
  var_54c33b5d87aa331b = 0;
  var_7deea9939acda793 = 0;
  var_3261caffadadb678 = var_e4d1678cede76da0 / 100;
  totaltime = var_e4d1678cede76da0;
  curpercent = 0;

  while(curpercent <= 100) {
    wait var_3261caffadadb678;
    curpercent++;

    foreach(player in level.players) {
      player setclientomnvar("ui_br_objective_param", curpercent);
    }

    if(curpercent >= 80 && !istrue(var_7deea9939acda793)) {
      function_18790a3cb3f88db7(level.var_93b887bd4bbdf9e3);
      var_7deea9939acda793 = 1;
    }

    if(curpercent >= 95 && !istrue(var_54c33b5d87aa331b)) {
      level thread update_soldier_goals();
      var_54c33b5d87aa331b = 1;
    }
  }

  player setclientomnvar("ui_br_objective_param", 100);
  function_907a00c8fa552ad2();
}

function function_907a00c8fa552ad2() {
  level.toc_rescued = 1;
  level thread update_soldier_goals();
  scripts\cp_mp\overlord::playconversation("s2_acv_escort", level.players);
  namespace_262d6474998a2356::function_b8b15f7f0820954e(level.activeplayers);
  wait 0.5;
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_ESCORT_INTRO";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  flag_set("toc_rescued");
  level notify("toc_rescued");
  objectivename = "regroup_acv_icon";
  level.objids[objectivename] = requestobjectiveid();
  objective_add_objective(level.objids[objectivename], "current", level.var_59a5ab1b4256bb79.origin + (0, 0, 100), "jup_ui_map_icon_obj_toc");
  update_objective_setbackground(level.objids[objectivename], 1);
  objective_addalltomask(level.objids[objectivename]);
  objective_playermask_showtoall(level.objids[objectivename]);

  if(isDefined(level.var_5926e65ed5e4e5f8) && isarray(level.var_5926e65ed5e4e5f8)) {
    for(i = 0; i < level.var_5926e65ed5e4e5f8.size; i++) {
      objectivename = level.var_5926e65ed5e4e5f8[i].objectivename;

      if(isDefined(level.objids[objectivename])) {
        returnreservedobjectiveid(level.objids[objectivename]);
      }
    }
  }
}

function update_soldier_goals() {
  level notify("update_soldier_goals");
  level endon("update_soldier_goals");
  level endon("game_ended");

  while(level.var_d23aeb1751c691a3.size > 0) {
    newgoalpos = level.var_59a5ab1b4256bb79.origin + anglesToForward(level.var_59a5ab1b4256bb79.angles) * 600;

    foreach(soldier in level.var_d23aeb1751c691a3) {
      if(isDefined(soldier) && isalive(soldier)) {
        soldier setgoalpos(newgoalpos);
        soldier.goalradius = 100;
      }
    }

    wait 0.1;
  }
}

function function_e9cd27cd39ef516c() {
  level endon("toc_rescued");

  while(true) {
    encounterdata = function_9a39e23c3c52c2af(level.var_93b887bd4bbdf9e3);

    if(!isDefined(encounterdata)) {
      continue;
    }

    foreach(zombie in encounterdata.ai) {
      zombie function_65cdab0fc78aba8f(zombie.origin, 2000);
    }

    wait 10;
  }
}

function function_f66b9a343a32f313() {
  agentteam = "axis";

  if(isDefined(level.players[0])) {
    agentteam = level.players[0].team;
  }

  var_78f9bae8363cd1 = getStructArray("toc_rescue_soldier_spawn_building_1", "targetname");

  if(!isDefined(var_78f9bae8363cd1)) {
    assert(0, "<dev string:x223>");
    return;
  }

  for(i = 0; i < var_78f9bae8363cd1.size; i++) {
    spawnorigin = var_78f9bae8363cd1[i].origin;
    spawnangles = var_78f9bae8363cd1[i].angles;
    agent = undefined;

    if(i % 2 == 0) {
      agent = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_enemy_basic_soldier_short", spawnorigin, spawnangles, agentteam);
    } else {
      agent = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_enemy_basic_soldier_long", spawnorigin, spawnangles, agentteam);
    }

    if(isDefined(agent)) {
      agent setgoalpos(agent.origin);
      agent.goalradius = 4;
      agent.ignoreme = 1;
      agent.iscompanion = 1;
      level.var_d23aeb1751c691a3[level.var_d23aeb1751c691a3.size] = agent;
      level.var_1509c2e9eb38fea3[level.var_1509c2e9eb38fea3.size] = agent;
    }
  }

  foreach(soldier in level.var_d23aeb1751c691a3) {
    soldier.maxhealth += 10000;
    soldier.health = soldier.maxhealth;
    soldier thread function_15a14065386e8a7a();
  }
}

function function_d5109375e2029bee() {
  var_5c12e410e4da75fe = getStruct("toc_soldier_rescue_objective_building_1", "targetname");
  level.var_5926e65ed5e4e5f8[0] = var_5c12e410e4da75fe;

  for(i = 0; i < level.var_5926e65ed5e4e5f8.size; i++) {
    objectivename = "toc_rescue_objective_" + i;
    level.var_5926e65ed5e4e5f8[i].objectivename = objectivename;
    level.objids[objectivename] = requestobjectiveid();
    objective_add_objective(level.objids[objectivename], "current", level.var_5926e65ed5e4e5f8[i].origin + (0, 0, 40), "jup_ui_map_icon_obj_toc");
    update_objective_setbackground(level.objids[objectivename], 1);
    objective_addalltomask(level.objids[objectivename]);
    objective_playermask_showtoall(level.objids[objectivename]);
  }
}

function function_1e4a06136f0a738e() {
  if(!isDefined(level.var_d23aeb1751c691a3) || !isarray(level.var_d23aeb1751c691a3)) {
    return;
  }

  while(level.var_d23aeb1751c691a3.size > 0 && !istrue(level.toc_rescued)) {
    level.var_d23aeb1751c691a3 = function_fdc9d5557c53078e(level.var_d23aeb1751c691a3);
    level.var_1509c2e9eb38fea3 = function_fdc9d5557c53078e(level.var_1509c2e9eb38fea3);
    waitframe();
  }
}

function function_a802ed3ab73c2c37() {
  level endon("game_ended");
  var_60de69d206774bb8 = getStruct("toc_rescue_lone_zombie_spawnpoint", "targetname");
  level.var_249beb6047a3e92c = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base", var_60de69d206774bb8.origin + (0, 0, 30), var_60de69d206774bb8.angles, "team_two_hundred");

  while(!istrue(level.var_70ac71107500c644)) {
    if(!isDefined(level.var_249beb6047a3e92c) || !isalive(level.var_249beb6047a3e92c)) {
      level.var_249beb6047a3e92c = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base", var_60de69d206774bb8.origin + (0, 0, 30), var_60de69d206774bb8.angles, "team_two_hundred");
    }

    wait 0.5;
  }
}

function debug_zombie_location() {
  level notify("debug_zombie_location");
  level endon("debug_zombie_location");

  while(isDefined(level.var_249beb6047a3e92c) && isalive(level.var_249beb6047a3e92c)) {
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(level.var_249beb6047a3e92c.origin, 25, 0.1, (0, 1, 0));
    wait 0.1;
  }
}

function function_15a14065386e8a7a() {
  level endon("game_ended");
  offset = (0, 0, 40);

  while(!istrue(level.var_70ac71107500c644) && !istrue(level.var_8b32fbd513ff5438)) {
    if(isDefined(level.var_249beb6047a3e92c) && isalive(level.var_249beb6047a3e92c) && self.weapon.basename != "none") {
      magicbullet(self.weapon.basename, self.origin + offset, level.var_249beb6047a3e92c.origin + offset, self, self);
    }

    duration = randomfloatrange(0.2, 2);
    wait duration;
  }
}