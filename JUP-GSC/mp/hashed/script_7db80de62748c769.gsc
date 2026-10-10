/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7db80de62748c769.gsc
*************************************************/

#using scripts\common\ai_formation;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace namespace_753b428633ceb556;

function init() {
  if(!isDefined(level.var_865c7977a3a308a)) {
    level.var_865c7977a3a308a = [];
  }
}

function function_5921dc142b08795b(patrolname, formationtype) {
  if(!isDefined(level.var_865c7977a3a308a)) {
    init();
  }

  if(isDefined(level.var_865c7977a3a308a[patrolname])) {
    return level.var_865c7977a3a308a[patrolname];
  }

  assertex(formationtype >= 0 && formationtype < 4, "<dev string:x1c>" + formationtype);
  level.var_865c7977a3a308a[patrolname] = spawnStruct();
  level.var_865c7977a3a308a[patrolname].array = [];
  ai_formation::function_a18d80bcfacb9e00(patrolname, formationtype);
  return level.var_865c7977a3a308a[patrolname];
}

function delete_patrol(patrolname) {
  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    return;
  }

  notifyname = function_8e9e859313e267e2(patrolname);
  level notify(notifyname);
  ai_formation::leave_formation(level.var_865c7977a3a308a[patrolname].array);
  ai_formation::delete_formation(patrolname);
  level.var_865c7977a3a308a[patrolname] = undefined;
}

function function_b41baf16d62d21d8(patrolname, var_129f5d1ec2e3fec5, formationtype) {
  if(!isDefined(formationtype)) {
    formationtype = 3;
  }

  if(!isDefined(level.var_865c7977a3a308a)) {
    init();
  }

  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    function_5921dc142b08795b(patrolname, formationtype);
  }

  if(!isarray(var_129f5d1ec2e3fec5)) {
    var_129f5d1ec2e3fec5 = [var_129f5d1ec2e3fec5];
  }

  foreach(ai in var_129f5d1ec2e3fec5) {
    function_801b4f42c4aec0ff(patrolname, ai, formationtype);
    ai thread function_585606ec5af81775(patrolname);
  }
}

function private function_ef66f73bdae69270(formationtype) {
  level endon("game_ended");
  var_5f4b84705795db7d = self.var_5f4b84705795db7d;
  thread function_ca2000d72aa808e8();
  waittill_any_3("enemy", "leave_group_patrol", "death");

  if(isDefined(self)) {
    interactionid = self function_92435c7a6ae85c3c();

    if(isDefined(interactionid)) {
      despawninteraction(interactionid);
    }

    leave_patrol(var_5f4b84705795db7d, self);

    if(isalive(self)) {
      self enableavoidance(1);
      self.patroltarget = undefined;
      thread function_84cd8295dbc3496d(formationtype);
    }
  }
}

function private function_ca2000d72aa808e8() {
  self endon("death");
  self endon("enemy");
  level endon("game_ended");

  while(true) {
    if(self function_56ca2f4913fa8c91()) {
      break;
    }

    if(isDefined(self.stealth) && isDefined(self.fnisinstealthidle) && ![[self.fnisinstealthidle]]()) {
      break;
    }

    waitframe();
  }

  self notify("leave_group_patrol");
}

function private function_84cd8295dbc3496d(formationtype) {
  self endon("death");

  while(true) {
    if(!self function_56ca2f4913fa8c91() && isDefined(self.stealth) && isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]()) {
      break;
    }

    waitframe();
  }

  function_b41baf16d62d21d8(self.var_5f4b84705795db7d, self, formationtype);
}

function private function_8e9e859313e267e2(patrolname) {
  return patrolname + "_kill_update";
}

function private function_585606ec5af81775(patrolname) {
  self endon("death");
  self endon("enemy");
  self endon("leave_group_patrol");
  self endon("following_entity");
  level endon("game_ended");
  wait 0.5;
  var_bfc2d8f5ab869cac = 200;
  goal_timeout = 5;
  goal_radius = 42;
  self.dont_enter_combat = 1;
  self notify("stop_going_to_node");
  waitframe();
  self.dont_enter_combat = undefined;
  self clearbtgoal(1);
  self clearbtgoal(3);
  self.goalradius = goal_radius;
  self function_b9ac4405e32e38b7(1);
  function_d49ad7e12f282a07(level.formationlist[patrolname], self aigetdesiredspeed());

  if(level.var_865c7977a3a308a[patrolname].array.size == 1) {
    if(isDefined(self.spawnpoint.target)) {
      self.patroltarget = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
      level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c = self.patroltarget;
      self.currentnode = self.patroltarget;
    } else {
      while(!isDefined(level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c)) {
        waitframe();
      }
    }
  } else {
    self setgoalpos(self.origin, goal_radius);

    if(isDefined(self.spawnpoint.target)) {
      leader = function_7a82c6e82e83e7d2(patrolname);

      if(!isDefined(leader.patroltarget)) {
        leadertarget = level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c;
      } else {
        leadertarget = leader.patroltarget;
      }

      if(isDefined(leadertarget)) {
        nexttarget = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
        self.patroltarget = nexttarget;
        bestdist = distance(self.patroltarget.origin, leadertarget.origin);
        visited = [nexttarget];

        while(true) {
          nexttarget = scripts\engine\utility::getStruct(nexttarget.target, "targetname");

          if(!isDefined(nexttarget) || array_contains(visited, nexttarget)) {
            break;
          }

          nextdist = distance(nexttarget.origin, leadertarget.origin);

          if(nextdist < bestdist) {
            self.patroltarget = nexttarget;
            bestdist = nextdist;
          }

          visited[visited.size] = nexttarget;
        }

        if(distancesquared(leader.origin, leadertarget.origin) < var_bfc2d8f5ab869cac) {
          self setgoalpos(self.patroltarget.origin, goal_radius);
          self.patroltarget = scripts\engine\utility::getStruct(self.patroltarget.target, "targetname");
          leader waittill("group_patrol_node_wait_ended");
        }
      } else {
        if(!isDefined(self.patroltarget)) {
          self.patroltarget = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
        }

        level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c = self.patroltarget;
        function_cc7045b3f96482ce();
      }

      self.currentnode = self.patroltarget;
    } else {
      while(!isDefined(level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c)) {
        waitframe();
      }
    }
  }

  interactionid = self function_92435c7a6ae85c3c();

  if(isDefined(interactionid)) {
    despawninteraction(interactionid);
  }

  while(true) {
    leader = function_7a82c6e82e83e7d2(patrolname);
    self function_b9ac4405e32e38b7(1);

    if(self != leader && isDefined(self.patroltarget) && self.patroltarget == level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c) {
      function_cc7045b3f96482ce();
      leader = self;
    }

    if(self == leader) {
      targetpos = isDefined(self.patroltarget) ? self.patroltarget.origin : level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c.origin;
      ai_formation::set_goal(patrolname, targetpos);
      wait 0.1;
      var_55576d80f4e2554d = level.var_865c7977a3a308a[patrolname].var_55576d80f4e2554d;

      if(isDefined(var_55576d80f4e2554d) && var_55576d80f4e2554d != 2) {
        var_75c3b1807b9d4e6 = level.var_865c7977a3a308a[patrolname].var_75c3b1807b9d4e6;
        var_b4060a330731f1bd = level.var_865c7977a3a308a[patrolname].var_b4060a330731f1bd;
        var_1b9a7d48f06da667 = level.var_865c7977a3a308a[patrolname].var_1b9a7d48f06da667;
        var_9af84e76946ada66 = level.var_865c7977a3a308a[patrolname].var_9af84e76946ada66;

        if(function_4dd09213ba28313a(level.formationlist[patrolname], self.origin, level.var_865c7977a3a308a[patrolname].var_e0a157723e031734, var_9af84e76946ada66)) {
          if(var_75c3b1807b9d4e6 != var_55576d80f4e2554d) {
            function_e1f50b1f60aa1b25(patrolname, var_55576d80f4e2554d, var_b4060a330731f1bd, var_1b9a7d48f06da667, var_9af84e76946ada66);
          }
        } else if(var_75c3b1807b9d4e6 == var_55576d80f4e2554d) {
          function_e1f50b1f60aa1b25(patrolname, 2, var_b4060a330731f1bd, var_1b9a7d48f06da667, var_9af84e76946ada66);
        }
      }
    }

    while(true) {
      if(!isDefined(leader)) {
        leader = function_7a82c6e82e83e7d2(patrolname);
        patrolgoal = undefined;
      }

      if(!isDefined(patrolgoal)) {
        if(isDefined(leader.patroltarget)) {
          patrolgoal = leader.patroltarget.origin;
        } else if(isDefined(level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c)) {
          patrolgoal = level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c.origin;
        }

        leader clearbtgoal(3);
        leader setgoalpos(patrolgoal, goal_radius);
      }

      if(isDefined(patrolgoal) && distance(leader.origin, patrolgoal) < var_bfc2d8f5ab869cac) {
        patrolgoal = undefined;
        break;
      }

      waitframe();
    }

    if(isDefined(self.patroltarget)) {
      leader = function_7a82c6e82e83e7d2(patrolname);

      if(self != leader) {
        self function_b9ac4405e32e38b7(0);
      }

      self clearbtgoal(1);
      self clearbtgoal(3);
      self setgoalpos(self.patroltarget.origin, goal_radius);
      self.goalradius = goal_radius;
    } else if(self == leader) {
      self clearbtgoal(1);
      self clearbtgoal(3);
      self setgoalpos(level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c.origin, goal_radius);
      self.goalradius = goal_radius;
    }

    leader = function_7a82c6e82e83e7d2(patrolname);

    if(function_8b93290be06b5b7f(leader.patroltarget)) {
      self notify("stop_going_to_node");
      array_wait(level.var_865c7977a3a308a[patrolname].array, "goal", goal_timeout);
    } else {
      self waittill("goal");
    }

    interactionai = [];
    node = self.patroltarget;
    var_10c8a4eb616b52f1 = 0;

    if(isDefined(node)) {
      leader = function_7a82c6e82e83e7d2(patrolname);

      if(self != leader) {
        self function_b9ac4405e32e38b7(0);
        wait randomfloatrange(0.5, 1);
      }

      if(isDefined(node.interaction)) {
        interactionid = self function_92435c7a6ae85c3c();
        ainode = self._blackboard.idlenode;

        if(isDefined(interactionid)) {
          if(node == ainode && isDefined(node.interactionid) && node.interactionid == interactionid) {
            self enableavoidance(0);
            interactionai[interactionai.size] = self;
            var_10c8a4eb616b52f1 = 1;
          } else {
            despawninteraction(interactionid);

            if(isDefined(ainode)) {
              ainode.interactionid = undefined;
            }
          }
        }

        if(!var_10c8a4eb616b52f1) {
          if(isDefined(node.interactionid)) {
            despawninteraction(node.interactionid);
            node.interactionid = undefined;
          }

          self._blackboard.idlenode = node;
          angles = node.angles;

          if(!isDefined(angles)) {
            angles = (0, 0, 0);
          }

          interactiontoks = strtok(node.interaction, "+");
          interaction = random(interactiontoks);
          node.interactionid = spawninteraction(interaction, node.origin, angles);
          self function_76b3cfb91ef40b3b(node.interactionid);
          self enableavoidance(0);
          interactionai[interactionai.size] = self;
        }
      }
    }

    childthread function_6d2707dbb5228999(node, leader);

    if(function_8b93290be06b5b7f(leader.patroltarget)) {
      array_wait(level.var_865c7977a3a308a[patrolname].array, "group_patrol_node_wait_ended");

      if(self != leader) {
        wait randomfloatrange(0.5, 1);
      }
    }

    self enableavoidance(1);
    self._blackboard.idlenode = node;
    node = self.patroltarget;

    if(isDefined(node) && isDefined(node.interactionid)) {
      despawninteraction(node.interactionid);
      node.interactionid = undefined;
    }

    if(isDefined(self.patroltarget)) {
      self.patroltarget = scripts\engine\utility::getStruct(self.patroltarget.target, "targetname");
      self.currentnode = self.patroltarget;
      self clearbtgoal(1);
    }

    leader = function_7a82c6e82e83e7d2(patrolname);

    if(self == leader && isDefined(level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c)) {
      level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c = scripts\engine\utility::getStruct(level.var_865c7977a3a308a[patrolname].var_aed4cacc8d6a6a0c.target, "targetname");
    }
  }
}

function function_8b93290be06b5b7f(node) {
  if(!isDefined(node)) {
    return false;
  }

  if(isDefined(node.interactionid)) {
    return true;
  }

  if(isDefined(node.interaction)) {
    return true;
  }

  return false;
}

function function_7a82c6e82e83e7d2(patrolname) {
  assertex(isDefined(level.var_865c7977a3a308a[patrolname]), "<dev string:x3a>");
  leader = ai_formation::get_leader(patrolname);

  if(!isDefined(leader) && level.var_865c7977a3a308a[patrolname].array.size > 0) {
    leader = level.var_865c7977a3a308a[patrolname].array[0];
  }

  return leader;
}

function private function_6d2707dbb5228999(node, leader) {
  interactionid = self function_92435c7a6ae85c3c();

  if(isDefined(interactionid)) {
    msg = waittill_any_return_2("bseq_user_deleted", "cap_exit_completed");

    if(msg == "bseq_user_deleted") {
      self waittill("cap_exit_completed");
    }
  } else if(!function_8b93290be06b5b7f(node)) {
    if(!isDefined(node)) {
      if(isDefined(leader.patroltarget)) {
        node = leader.patroltarget;
      } else {
        node = level.var_865c7977a3a308a[self.var_5f4b84705795db7d].var_aed4cacc8d6a6a0c;
      }
    }

    if(!isDefined(node.script_delay) && function_8b93290be06b5b7f(leader.patroltarget)) {
      wait 0.5;
      self notify("group_patrol_node_wait_ended");
      return;
    }

    node script_delay();
  }

  if(isDefined(node.script_flag_wait)) {
    flag_wait(node.script_flag_wait);
  }

  if(isDefined(node.script_ent_flag_wait)) {
    ent_flag_wait(node.script_ent_flag_wait);
  }

  node script_wait();
  self notify("group_patrol_node_wait_ended");
}

function private function_801b4f42c4aec0ff(patrolname, var_129f5d1ec2e3fec5, formationtype) {
  index = level.var_865c7977a3a308a[patrolname].array.size;
  level.var_865c7977a3a308a[patrolname].array[index] = var_129f5d1ec2e3fec5;
  var_129f5d1ec2e3fec5.var_5f4b84705795db7d = patrolname;
  ai_formation::function_73d6d4ee28a18071(patrolname, var_129f5d1ec2e3fec5, formationtype);
  var_129f5d1ec2e3fec5 thread function_ef66f73bdae69270(formationtype);
}

function function_e780688c49cc9549(patrolname, var_93e0bc97a6d45499) {
  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    return;
  }

  ai_formation::function_e780688c49cc9549(patrolname, var_93e0bc97a6d45499);
}

function function_bc785df299663d60(patrolname, formationslot, customoffset) {
  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    return;
  }

  ai_formation::function_bc785df299663d60(patrolname, formationslot, customoffset);
}

function set_goal(patrolname, goalposition) {
  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    return;
  }

  ai_formation::set_goal(patrolname, goalposition);
}

function leave_patrol(patrolname, var_cc408e19cc4792d2) {
  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    return;
  }

  if(!isarray(var_cc408e19cc4792d2)) {
    var_cc408e19cc4792d2 = [var_cc408e19cc4792d2];
  }

  foreach(ai in var_cc408e19cc4792d2) {
    ai_formation::leave_formation(ai);
    ai clearbtgoal(1);
    ai clearbtgoal(3);
    node = ai.patroltarget;

    if(isDefined(node) && isDefined(node.interactionid)) {
      despawninteraction(node.interactionid);
      node.interactionid = undefined;
    }
  }

  level.var_865c7977a3a308a[patrolname].array = array_remove_array(level.var_865c7977a3a308a[patrolname].array, var_cc408e19cc4792d2);
}

function function_cc7045b3f96482ce() {
  assertex(isDefined(self.var_5f4b84705795db7d) && self.var_5f4b84705795db7d != "<dev string:x52>", "<dev string:x56>");
  ai_formation::function_679b2830741a1384(self.var_5f4b84705795db7d);

  if(isDefined(self.patroltarget)) {
    level.var_865c7977a3a308a[self.var_5f4b84705795db7d].var_aed4cacc8d6a6a0c = self.patroltarget;
    return;
  }

  if(isDefined(self.spawnpoint.target)) {
    level.var_865c7977a3a308a[self.var_5f4b84705795db7d].var_aed4cacc8d6a6a0c = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
  }
}

function function_147af37cda62f235(patrolname, ent, followdistance, timestep, usegoalentity) {
  if(!isDefined(usegoalentity)) {
    usegoalentity = 0;
  }

  assertex(isDefined(patrolname) && isDefined(level.var_865c7977a3a308a) && isDefined(level.var_865c7977a3a308a[patrolname]), "<dev string:x86>");
  assertex(isDefined(ent), "<dev string:xa1>");

  if(usegoalentity) {
    thread function_67255c72f20ef2f3(patrolname, ent, followdistance, timestep);
    return;
  }

  thread function_7bcb65e6db709f70(patrolname, ent, followdistance, timestep);
}

function private function_67255c72f20ef2f3(patrolname, ent, followdistance, timestep) {
  level endon("game_ended");
  self endon("stop_following_" + patrolname);

  if(ai_formation::follow_entity(patrolname, ent, followdistance, timestep)) {
    foreach(agent in level.var_865c7977a3a308a[patrolname].array) {
      agent notify("following_entity");
    }

    ent waittill_any_3("death", "crashing", "entitydeleted");
    function_fded050d740c3e04(patrolname);
  }
}

function private function_7bcb65e6db709f70(patrolname, ent, followdistance, timestep) {
  if(!isDefined(followdistance)) {
    followdistance = 100;
  }

  if(!isDefined(timestep)) {
    timestep = 2.5;
  }

  level endon("game_ended");
  self endon("stop_following_" + patrolname);

  foreach(agent in level.var_865c7977a3a308a[patrolname].array) {
    agent notify("following_entity");
  }

  function_34c06b9933952e67(level.formationlist[patrolname], followdistance);
  thread function_abf1531c14702dc8(patrolname, ent, followdistance, timestep);
  ent waittill_any_3("death", "crashing", "entitydeleted");
  function_fded050d740c3e04(patrolname);
}

function private function_abf1531c14702dc8(patrolname, ent, followdistance, timestep) {
  ent endon("death");
  ent endon("crashing");
  ent endon("entitydeleted");
  level endon("game_ended");
  self endon("stop_following_" + patrolname);
  notifyname = function_8e9e859313e267e2(patrolname);
  level endon(notifyname);
  self notify("formation_follow_ent_manual");
  self endon("formation_follow_ent_manual");

  while(isDefined(level.var_865c7977a3a308a) && isDefined(level.var_865c7977a3a308a[patrolname])) {
    enthalfsize = ent getboundshalfsize();
    entforward = anglesToForward(ent.angles);
    offset = -1 * (followdistance + enthalfsize[0]) * entforward;
    newgoal = ent.origin + offset;
    newgoal = getclosestpointonnavmesh(newgoal);

    if(level.var_865c7977a3a308a[patrolname].array.size > 0) {
      leader = function_7a82c6e82e83e7d2(patrolname);
      leader setbtgoalpos(3, newgoal);

      if(isagent(ent)) {
        leader aisetdesiredspeed(length(ent getvelocity()));
      } else if(ent scripts\common\vehicle::isvehicle()) {
        leader aisetdesiredspeed(length(ent vehicle_getvelocity()));
      } else if(isDefined(ent.speed)) {
        leader aisetdesiredspeed(ent.speed);
      }
    } else {
      break;
    }

    wait timestep;
  }
}

function function_fded050d740c3e04(patrolname) {
  if(ai_formation::function_5e8d7d93ecffa23f(patrolname)) {
    self notify("stop_following_" + patrolname);
    function_34c06b9933952e67(level.formationlist[patrolname], 0);
    leader = function_7a82c6e82e83e7d2(patrolname);
    leader aiclearscriptdesiredspeed();

    foreach(agent in level.var_865c7977a3a308a[patrolname].array) {
      agent thread function_585606ec5af81775(patrolname);
    }
  }
}

function function_e1f50b1f60aa1b25(patrolname, var_3f4d3640a452a225, var_b4060a330731f1bd, var_1b9a7d48f06da667, var_9af84e76946ada66) {
  if(!isDefined(var_9af84e76946ada66)) {
    var_9af84e76946ada66 = 0;
  }

  if(!isDefined(level.var_865c7977a3a308a[patrolname])) {
    return;
  }

  numai = level.var_865c7977a3a308a[patrolname].array.size;

  if(numai == 0) {
    return;
  }

  var_9af84e76946ada66 = var_9af84e76946ada66 || var_3f4d3640a452a225 == 1;
  level.var_865c7977a3a308a[patrolname].formationwidth = function_cf3f27c3c5266ee2(patrolname, var_3f4d3640a452a225, numai, var_b4060a330731f1bd, var_1b9a7d48f06da667, var_9af84e76946ada66);
  level.var_865c7977a3a308a[patrolname].var_b4060a330731f1bd = var_b4060a330731f1bd;
  level.var_865c7977a3a308a[patrolname].var_1b9a7d48f06da667 = var_1b9a7d48f06da667;
  level.var_865c7977a3a308a[patrolname].var_75c3b1807b9d4e6 = var_3f4d3640a452a225;
  level.var_865c7977a3a308a[patrolname].var_9af84e76946ada66 = var_9af84e76946ada66;

  if(!isDefined(level.var_865c7977a3a308a[patrolname].var_55576d80f4e2554d)) {
    level.var_865c7977a3a308a[patrolname].var_55576d80f4e2554d = var_3f4d3640a452a225;
  }

  if(var_3f4d3640a452a225 == level.var_865c7977a3a308a[patrolname].var_55576d80f4e2554d) {
    level.var_865c7977a3a308a[patrolname].var_e0a157723e031734 = level.var_865c7977a3a308a[patrolname].formationwidth;
  }
}