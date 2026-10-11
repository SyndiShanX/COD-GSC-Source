/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_367c2e5a914658d7.gsc
*************************************************/

#using script_4948cdf739393d2d;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;
#namespace namespace_6d558624bef88b8;

function activewarzoneinit() {
  logstring("ActiveWarzone - Init");
  scripts\mp\ai_mp_controller::function_ba4022744dce59f6("activeWarzone");
  scripts\mp\gametypes\br_circle::registercirclecallbacks(10, &function_5684b9a123f38950);
  level thread _watchforcircleclosure();
}

function function_c4b698ed8dd5c33d() {
  agents = function_7eb04ca16d045775("activeWarzone");

  foreach(agent in agents) {
    if(isalive(agent) && !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(agent.origin)) {
      logstring("ActiveWarzone Kill Active AI in gas at " + agent.origin);
      agent kill();
    }
  }

}

function function_974a505e30d0049c() {
  agents = function_5508ddea3a84df39("activeWarzone");

  foreach(agent in agents) {
    infopackage = level.var_879053468f168806[agent];

    if(!scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(infopackage.origin)) {
      logstring("ActiveWarzone Delete Dormant AI in gas at " + infopackage.origin);
      deletedormant(agent);
    }
  }

}

function function_5684b9a123f38950(circleorigin, circleradius, thresholdradius) {
  radiussqr = circleradius * circleradius;
  agents = function_b4b9401715cf98ea("activeWarzone");

  foreach(agent in agents) {
    if(isint(agent)) {
      infopackage = level.var_879053468f168806[agent];
      distsqr = lengthsquared(infopackage.origin - circleorigin);

      if(distsqr >= radiussqr) {
        logstring("ActiveWarzone Delete Dormant AI in gas at " + infopackage.origin + " - gas center " + circleorigin + " r" + circleradius);
        deletedormant(agent);
      }

      continue;
    }

    distsqr = lengthsquared(agent.origin - circleorigin);

    if(distsqr >= radiussqr) {
      logstring("ActiveWarzone Kill Active AI in gas at " + agent.origin + " - gas center " + circleorigin + " r" + circleradius);
      agent kill();
    }
  }
}

function function_a9eaf2243763094d() {
  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    return;
  }

  dormants = 0;
  denieds = 0;
  nonodes = 0;
  var_9a1c1b5c5cb9c1e = 0;
  volumes = getnoentvolumearray("building_bounds", "script_noteworthy");

  for(i = 0; i < volumes.size; i++) {
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("pistol", 1);
    agent = spawnai(aitype, volumes[i], volumes[i].origin, (0, 0, 0));

    if(isint(agent)) {
      dormants++;
      var_9a1c1b5c5cb9c1e++;

      if(dormants % 100 == 0) {
        waitframe();
      }

      continue;
    }

    denieds++;
  }

  logstring("ActiveWarzone - Living World Only Spawns " + var_9a1c1b5c5cb9c1e + "/" + volumes.size);
  level.var_6db1fc6674f5c81d = undefined;
  level.var_35a97ceb54818616 = undefined;
  level.var_ba2aa87e33811b32 = undefined;
  waitframe();
  waitframe();
  waitframe();

  foreach(fortress in level.var_f1073fbd45b59a06.unusedfortresses) {
    if(!isDefined(fortress.spawnclosetnodes) || fortress.spawnclosetnodes.size == 0) {
      logstring("Skipping unused fortresses for no guard nodes at " + fortress.origin);
      nonodes++;
      continue;
    }

    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("pistol", 1);
    var_8c7cd2b569611279 = function_59d68c7b901fc998(fortress.var_c8c070d7375ef1e);

    for(i = 0; i < var_8c7cd2b569611279; i++) {
      spawnnode = fortress.spawnclosetnodes[randomint(fortress.spawnclosetnodes.size)];
      agent = function_1dd6dd044fd43e09(aitype, spawnnode.origin, spawnnode.angles, fortress.origin, 120);

      if(isint(agent)) {
        dormants++;

        if(dormants % 100 == 0) {
          waitframe();
        }

        continue;
      }

      denieds++;
    }
  }

  logstring("ActiveWarzone - World AI Spawned Dormant " + dormants);
  logstring("ActiveWarzone - World AI Denied Spawned " + denieds);
  logstring("ActiveWarzone - Total Unused fortresses " + level.var_f1073fbd45b59a06.unusedfortresses.size);
  logstring("ActiveWarzone - Unused Fortresses skipped from no Guard Nodes " + nonodes);

  level thread function_71111773fd81f5d2();
}

function function_7b7f58778d9d6990(agent) {
  agent = self;
  agent.var_14c360ebec241178 = agent.maxsightdistsqrd;
  agent.maxsightdistsqrd = 230400;
  agent.accuracy = 0.4;
  agent function_d493e7fe15e5eaf4("star_4");
  agent.var_cf430336d17e3afe = 1;
}

function private spawnai(aitype, volume, spawnorigin, spawnangles) {
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, spawnorigin, spawnangles, "low", "activeWarzone", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, undefined, 1);

  if(isint(agent)) {
    scripts\cp_mp\agents\agent_utils::function_58aab2edaec2599f(agent, "active", &function_7b7f58778d9d6990);
    patroldestination = undefined;
    bounds = volume getboundshalfsize();
    var_978098481752dc72 = min(max(bounds[0], bounds[1]), 360);
    nodes = getnodesinradius(volume.origin, var_978098481752dc72, 0, 120, "Cover");

    if(nodes.size > 0) {
      for(i = 0; i < nodes.size; i++) {
        if(ispointinvolume(nodes[i].origin, volume)) {
          patroldestination = nodes[i].origin;
          break;
        }
      }
    }

    if(isDefined(patroldestination)) {
      pathstruct = spawnStruct();
      pathstruct.path = [spawnorigin, patroldestination];
      pathstruct.claimed = 0;
      pathstruct.var_4437e81f60b6b5a0 = 1;
      scripts\mp\ai_behavior::function_4561fe6bfc76f8ec(agent, [agent], pathstruct, volume.origin, var_978098481752dc72);
    } else {
      scripts\mp\ai_behavior::function_e786aa52b93833eb(agent, volume.origin, 120, 0);
    }
  }

  return agent;
}

function private function_1dd6dd044fd43e09(aitype, spawnorigin, spawnangles, buildingcenterorigin, var_978098481752dc72) {
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, spawnorigin, spawnangles, "low", "activeWarzone", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, undefined, 1);

  if(isint(agent)) {
    scripts\cp_mp\agents\agent_utils::function_58aab2edaec2599f(agent, "active", &function_7b7f58778d9d6990);
    patroldestination = undefined;
    var_58194b37523adc95 = (buildingcenterorigin[0], buildingcenterorigin[1], spawnorigin[2]);
    nodes = getnodesinradius(var_58194b37523adc95, var_978098481752dc72, 0, 60, "Cover");

    if(nodes.size > 0) {
      for(i = 0; i < nodes.size; i++) {
        if(distance2dsquared(spawnorigin, nodes[i].origin) >= 9216) {
          patroldestination = nodes[i].origin;
          break;
        }
      }
    }

    if(!isDefined(patroldestination)) {
      if(distance2dsquared(spawnorigin, var_58194b37523adc95) >= 9216) {
        patroldestination = var_58194b37523adc95;
      }
    }

    if(isDefined(patroldestination)) {
      pathstruct = spawnStruct();
      pathstruct.path = [spawnorigin, patroldestination];
      pathstruct.claimed = 0;
      pathstruct.var_4437e81f60b6b5a0 = 1;
      scripts\mp\ai_behavior::function_4561fe6bfc76f8ec(agent, [agent], pathstruct, var_58194b37523adc95, var_978098481752dc72);
    } else {
      var_58194b37523adc95 = (buildingcenterorigin[0], buildingcenterorigin[1], spawnorigin[2]);
      scripts\mp\ai_behavior::function_e786aa52b93833eb(agent, var_58194b37523adc95, 120, 0);
    }
  }

  return agent;
}

function function_276d8f79560a28f8() {
  level endon("game_ended");
  level waittill("infils_ready");
  var_f501d4e6074a9d91 = getdvarint(@ "hash_1f417cb6adc43c30", 240);
  wait var_f501d4e6074a9d91;
  logstring("ActiveWarzone - Updating AI weapons at " + var_f501d4e6074a9d91 + " seconds");
  function_a3e821eb4249f933();
}

function _watchforcircleclosure() {
  level endon("game_ended");
  var_dff50030f50c58ea = getdvarint(@ "hash_4dc5c5741b807bae", 5);

  if(var_dff50030f50c58ea) {
    while(true) {
      level waittill("br_circle_set");
      circleindex = level.br_circle.circleindex + 1;

      if(circleindex >= var_dff50030f50c58ea) {
        function_a92ff5cdced1873e();
        return;
      }
    }
  }
}

function private deletedormant(id) {
  scripts\cp_mp\agents\agent_utils::function_4e065f1747aadd51(id, "activeWarzone");
}

function private function_a92ff5cdced1873e() {
  logstring("ActiveWarzone - Deleting All " + level.var_879053468f168806.size + " dormant AI");
  dormants = function_5508ddea3a84df39("activeWarzone");

  foreach(id in dormants) {
    logstring("ActiveWarzone - Deleting dormant id #" + id);
    deletedormant(id);
  }
}

function private function_a3e821eb4249f933() {
  dormants = function_5508ddea3a84df39("activeWarzone");
  logstring("ActiveWarzone - Upgrading " + dormants.size + " dormant AI");

  foreach(id in dormants) {
    if(isDefined(level.var_879053468f168806[id])) {
      if(randomint(5) == 0) {
        aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("shotgun", 1);
      } else {
        aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("smg", 1);
      }

      logstring("ActiveWarzone - Upgrading dormant id #" + id + " to " + aitype);
      level.var_879053468f168806[id].aitype = aitype;
      continue;
    }

    logstring("ActiveWarzone - Cant Find Dormant AI " + id + " - This should never happen");
  }
}

function private function_59d68c7b901fc998(var_c8c070d7375ef1e) {
  if(var_c8c070d7375ef1e == "large" || var_c8c070d7375ef1e == "hero") {
    return getdvarint(@ "hash_3a990161316ef42c", 2);
  } else if(var_c8c070d7375ef1e == "medium") {
    return getdvarint(@ "hash_264c33ce5715aa10", 1);
  }

  return getdvarint(@ "hash_d4b060e8da9b92c0", 1);
}

function function_71111773fd81f5d2() {
  level endon("<dev string:x60>");
  color = (1, 0, 0);

  while(true) {
    if(getdvarint(@ "hash_7d784e3984c4b5b1", 0)) {
      foreach(dormant in level.var_879053468f168806) {
        top = dormant.origin + (0, 0, 72);
        cylinder(dormant.origin, top, 30, color, 0, 60);
        print3d(top, "<dev string:x6e>" + dormant.aitype, color, 1, 1, 60);

        if(isDefined(dormant.behaviorpackage.pathstruct) && dormant.behaviorpackage.pathstruct.path.size > 1) {
          if(isvector(dormant.behaviorpackage.pathstruct.path[0]) && isvector(dormant.behaviorpackage.pathstruct.path[1])) {
            cylinder(dormant.behaviorpackage.pathstruct.path[0], dormant.behaviorpackage.pathstruct.path[0] + (0, 0, 12), 15, (0, 1, 0), 0, 60);
            cylinder(dormant.behaviorpackage.pathstruct.path[1], dormant.behaviorpackage.pathstruct.path[1] + (0, 0, 12), 15, (0, 1, 0), 0, 60);
            line(dormant.behaviorpackage.pathstruct.path[0], dormant.behaviorpackage.pathstruct.path[1], color, 0, 0, 60);
          }
        }
      }
    }

    wait 1;
  }
}

# /