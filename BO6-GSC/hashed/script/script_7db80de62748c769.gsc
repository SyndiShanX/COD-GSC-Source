/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7db80de62748c769.gsc
*****************************************************/

#using scripts\common\ai_formation;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace namespace_58683191e356522f;

function init() {
  if(!isDefined(level.var_4d73ff8077782af)) {
    level.var_4d73ff8077782af = [];
  }
}

function function_9c3ef5815bfc33a(patrolname, formationtype) {
  if(!isDefined(level.var_4d73ff8077782af)) {
    init();
  }

  if(isDefined(level.var_4d73ff8077782af[patrolname])) {
    return level.var_4d73ff8077782af[patrolname];
  }

  assert(formationtype >= 0 && formationtype < 4, "<dev string:x24>" + formationtype);
  level.var_4d73ff8077782af[patrolname] = spawnStruct();
  level.var_4d73ff8077782af[patrolname].array = [];
  ai_formation::function_5b447ea9cfdca229(patrolname, formationtype);
  return level.var_4d73ff8077782af[patrolname];
}

function delete_patrol(patrolname, permanently = 0) {
  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    return;
  }

  if(permanently) {
    foreach(ai in level.var_4d73ff8077782af[patrolname].array) {
      ai notify("\xf0\x8b\xa21\x96\xf9\x1f\x13\xba%Gw\xe2\xa9Xk\xd1i=\xa9%\xd3\xeb\x9d\x92\xf0\xfc(\x06\x9e");
    }
  }

  notifyname = function_64bd7fabedd903a3(patrolname);
  level notify(notifyname);
  ai_formation::leave_formation(level.var_4d73ff8077782af[patrolname].array);
  ai_formation::delete_formation(patrolname);
  level.var_4d73ff8077782af[patrolname] = undefined;
}

function function_d824474e23341a95(patrolname, aitoadd, formationtype = 3) {
  if(!isDefined(level.var_4d73ff8077782af)) {
    init();
  }

  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    function_9c3ef5815bfc33a(patrolname, formationtype);
  }

  if(!isarray(aitoadd)) {
    aitoadd = [aitoadd];
  }

  foreach(ai in aitoadd) {
    function_ff1a10bc062c4e02(patrolname, ai, formationtype);
    ai thread function_e32caa8a3e5d9a58(patrolname);
  }
}

function private function_fc7f70a6c3f6f531(formationtype) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  grouppatrolname = self.grouppatrolname;
  thread function_e5f7c3940b02f82d();
  utility::waittill_any("\xba8C\xef\xc2", "\xfa6\xf2xTMp\xefw\xbf(\xcc\xaf\xfe+Y>&", "\x1e\xfd\xd1\xa2\a");

  if(isDefined(self)) {
    interactionid = self getinteractionid();

    if(isDefined(interactionid)) {
      despawninteraction(interactionid);
    }

    leave_patrol(grouppatrolname, self);

    if(isalive(self)) {
      self enableavoidance(1);
      self.patroltarget = undefined;
      thread function_449e91628a8f4920(formationtype);
    }
  }
}

function private function_e5f7c3940b02f82d() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xba8C\xef\xc2");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    if(self choreographer_iscontrolled()) {
      break;
    }

    if(isDefined(self.stealth) && isDefined(self.fnisinstealthidle) && ![[self.fnisinstealthidle]]()) {
      break;
    }

    waitframe();
  }

  self notify("\xfa6\xf2xTMp\xefw\xbf(\xcc\xaf\xfe+Y>&");
}

function private function_449e91628a8f4920(formationtype) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf0\x8b\xa21\x96\xf9\x1f\x13\xba%Gw\xe2\xa9Xk\xd1i=\xa9%\xd3\xeb\x9d\x92\xf0\xfc(\x06\x9e");

  while(true) {
    if(!self choreographer_iscontrolled() && isDefined(self.stealth) && isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]() && (!isDefined(self.var_9ddd812492745184) || [[self.var_9ddd812492745184]]())) {
      break;
    }

    waitframe();
  }

  function_d824474e23341a95(self.grouppatrolname, self, formationtype);
}

function private function_64bd7fabedd903a3(patrolname) {
  return patrolname + "}\xb6Zc6_\xea\xe0d\v\x8e\xac";
}

function private function_e32caa8a3e5d9a58(patrolname) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xba8C\xef\xc2");
  self endon("\xfa6\xf2xTMp\xefw\xbf(\xcc\xaf\xfe+Y>&");
  self endon("\xbf\x95\xb30\xb9I\xab\xd8\xf9m\x03\x99C\x13\xf6X");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  wait 0.5;
  var_c6a33eef6f9c00c1 = 200;
  goal_timeout = 5;
  goal_radius = 42;
  self.dont_enter_combat = 1;
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  waitframe();
  self.dont_enter_combat = undefined;
  self clearbtgoal(1);
  self clearbtgoal(3);
  self.goalradius = goal_radius;
  self function_c8c0c9970b612d4a(1);
  function_801a07b4372fb0da(level.formationlist[patrolname], self aigetdesiredspeed());

  if(level.var_4d73ff8077782af[patrolname].array.size > 0 && level.var_4d73ff8077782af[patrolname].array[0] == self) {
    if(isDefined(self.spawnpoint.target)) {
      patroltargets = get_target_goals(self.spawnpoint.target);
      assert(isDefined(patroltargets) && patroltargets.size > 0, "<dev string:x42>");
      self.patroltarget = patroltargets[0];
      level.var_4d73ff8077782af[patrolname].groupleadertarget = self.patroltarget;
      self.currentnode = self.patroltarget;
    } else {
      while(!isDefined(level.var_4d73ff8077782af[patrolname].groupleadertarget)) {
        waitframe();
      }
    }
  } else {
    self setgoalpos(self.origin, goal_radius);

    if(isDefined(self.spawnpoint.target)) {
      leader = function_e99ef71b95bae0f7(patrolname);

      if(!isDefined(leader.patroltarget)) {
        leadertarget = level.var_4d73ff8077782af[patrolname].groupleadertarget;
      } else {
        leadertarget = leader.patroltarget;
      }

      if(isDefined(leadertarget)) {
        patroltargets = get_target_goals(self.spawnpoint.target);
        assert(isDefined(patroltargets) && patroltargets.size > 0, "<dev string:x7d>");
        self.patroltarget = patroltargets[0];
        bestdist = distance(self.patroltarget.origin, leadertarget.origin);
        visited = [patroltargets[0]];

        while(true) {
          nexttargets = get_target_goals(patroltargets[0].target);
          assert(isDefined(nexttargets) && nexttargets.size > 0, "<dev string:xc1>");
          nexttarget = nexttargets[0];

          if(!isDefined(nexttarget) || arraycontains(visited, nexttarget)) {
            break;
          }

          nextdist = distance(nexttarget.origin, leadertarget.origin);

          if(nextdist < bestdist) {
            self.patroltarget = nexttarget;
            bestdist = nextdist;
          }

          visited[visited.size] = nexttarget;
        }

        if(distancesquared(leader.origin, leadertarget.origin) < var_c6a33eef6f9c00c1) {
          self setgoalpos(self.patroltarget.origin, goal_radius);
          patroltargets = get_target_goals(self.patroltarget.target);
          self.patroltarget = patroltargets[0];
          leader waittill("\"\xa8\xf5\x1f&\xff4'\xd0e\xe2 \xc0w\x0f\xbe\xb6\b\xc92\">\x14\xfa(\xd3\xfa\x1c");
        }
      } else {
        if(!isDefined(self.patroltarget)) {
          patroltargets = get_target_goals(self.spawnpoint.target);
          self.patroltarget = patroltargets[0];
        }

        level.var_4d73ff8077782af[patrolname].groupleadertarget = self.patroltarget;
        function_66c0f36c1f06e14b();
      }

      self.currentnode = self.patroltarget;
    } else {
      while(!isDefined(level.var_4d73ff8077782af[patrolname].groupleadertarget)) {
        waitframe();
      }

      function_90ae44fe780e77ad(level.formationlist[patrolname], self);
    }
  }

  interactionid = self getinteractionid();

  if(isDefined(interactionid)) {
    despawninteraction(interactionid);
  }

  while(true) {
    leader = function_e99ef71b95bae0f7(patrolname);
    self function_c8c0c9970b612d4a(1);

    if(self != leader && isDefined(self.patroltarget) && self.patroltarget == level.var_4d73ff8077782af[patrolname].groupleadertarget) {
      function_66c0f36c1f06e14b();
      leader = self;
    }

    if(self == leader) {
      targetpos = isDefined(self.patroltarget) ? self.patroltarget.origin : level.var_4d73ff8077782af[patrolname].groupleadertarget.origin;
      ai_formation::set_goal(patrolname, targetpos);
      wait 0.1;
      var_cc888d8684d55970 = level.var_4d73ff8077782af[patrolname].var_cc888d8684d55970;

      if(isDefined(var_cc888d8684d55970) && var_cc888d8684d55970 != 2) {
        var_fc58572195a06a73 = level.var_4d73ff8077782af[patrolname].var_fc58572195a06a73;
        horizontalseparation = level.var_4d73ff8077782af[patrolname].horizontalseparation;
        verticalseparation = level.var_4d73ff8077782af[patrolname].verticalseparation;
        leaderinfront = level.var_4d73ff8077782af[patrolname].leaderinfront;

        if(function_7ab27e0fc1872043(level.formationlist[patrolname], self.origin, level.var_4d73ff8077782af[patrolname].desiredformationwidth, leaderinfront)) {
          if(var_fc58572195a06a73 != var_cc888d8684d55970) {
            function_81816c3d87acb174(patrolname, var_cc888d8684d55970, horizontalseparation, verticalseparation, leaderinfront);
          }
        } else if(var_fc58572195a06a73 == var_cc888d8684d55970) {
          if(verticalseparation == 0) {
            verticalseparation = 50;
          }

          function_81816c3d87acb174(patrolname, 2, horizontalseparation, verticalseparation, leaderinfront);
        }
      }
    }

    while(true) {
      if(!isDefined(leader)) {
        leader = function_e99ef71b95bae0f7(patrolname);
        patrolgoal = undefined;
      }

      if(!isDefined(patrolgoal)) {
        if(isDefined(leader.patroltarget)) {
          patrolgoal = leader.patroltarget.origin;
        } else if(isDefined(level.var_4d73ff8077782af[patrolname].groupleadertarget)) {
          patrolgoal = level.var_4d73ff8077782af[patrolname].groupleadertarget.origin;
        }

        leader clearbtgoal(3);
        leader setgoalpos(patrolgoal, goal_radius);
      }

      if(isDefined(patrolgoal) && distance(leader.origin, patrolgoal) < var_c6a33eef6f9c00c1) {
        patrolgoal = undefined;
        break;
      }

      waitframe();
    }

    if(isDefined(self.patroltarget)) {
      leader = function_e99ef71b95bae0f7(patrolname);

      if(self != leader) {
        self function_c8c0c9970b612d4a(0);
      }

      self clearbtgoal(1);
      self clearbtgoal(3);
      self setgoalpos(self.patroltarget.origin, goal_radius);
      self.goalradius = goal_radius;
    } else if(self == leader) {
      self clearbtgoal(1);
      self clearbtgoal(3);
      self setgoalpos(level.var_4d73ff8077782af[patrolname].groupleadertarget.origin, goal_radius);
      self.goalradius = goal_radius;
    }

    leader = function_e99ef71b95bae0f7(patrolname);

    if(function_1c4d8240d6eef5d6(leader.patroltarget)) {
      self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
      utility::array_wait(level.var_4d73ff8077782af[patrolname].array, "\x83\xd6\xaf\x11", goal_timeout);
    } else {
      self waittill("\x83\xd6\xaf\x11");
    }

    interactionai = [];
    node = self.patroltarget;
    var_46318f399b1320 = 0;

    if(isDefined(node)) {
      leader = function_e99ef71b95bae0f7(patrolname);

      if(self != leader) {
        self function_c8c0c9970b612d4a(0);
        wait randomfloatrange(0.5, 1);
      }

      if(isDefined(node.interaction)) {
        interactionid = self getinteractionid();
        ainode = self._blackboard.idlenode;

        if(isDefined(interactionid)) {
          if(node == ainode && isDefined(node.interactionid) && node.interactionid == interactionid) {
            self enableavoidance(0);
            interactionai[interactionai.size] = self;
            var_46318f399b1320 = 1;
          } else {
            despawninteraction(interactionid);

            if(isDefined(ainode)) {
              ainode.interactionid = undefined;
            }
          }
        }

        if(!var_46318f399b1320) {
          if(isDefined(node.interactionid)) {
            despawninteraction(node.interactionid);
            node.interactionid = undefined;
          }

          self._blackboard.idlenode = node;
          angles = node.angles;

          if(!isDefined(angles)) {
            angles = (0, 0, 0);
          }

          interactiontoks = strtok(node.interaction, "H");
          interaction = utility::random(interactiontoks);
          node.interactionid = spawninteraction(interaction, node.origin, angles);
          self function_47127b28b1fb3f1e(node.interactionid);
          self enableavoidance(0);
          interactionai[interactionai.size] = self;
        }
      }
    }

    childthread function_eff830f2c3f56ec4(node, leader);

    if(function_1c4d8240d6eef5d6(leader.patroltarget)) {
      utility::array_wait(level.var_4d73ff8077782af[patrolname].array, "\"\xa8\xf5\x1f&\xff4'\xd0e\xe2 \xc0w\x0f\xbe\xb6\b\xc92\">\x14\xfa(\xd3\xfa\x1c");

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

    if(isDefined(self.patroltarget) && isDefined(self.patroltarget.target)) {
      patroltargets = get_target_goals(self.patroltarget.target);
      self.patroltarget = patroltargets[0];
      self.currentnode = self.patroltarget;
      self clearbtgoal(1);
    }

    leader = function_e99ef71b95bae0f7(patrolname);

    if(self == leader && isDefined(level.var_4d73ff8077782af[patrolname].groupleadertarget.target)) {
      [level.var_4d73ff8077782af[patrolname].groupleadertarget] = get_target_goals(level.var_4d73ff8077782af[patrolname].groupleadertarget.target);
    }
  }
}

function get_target_goals(target) {
  goals = getnodearray(target, #targetname);
  new_goals = utility::getStructArray(target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  foreach(new in new_goals) {
    goals[goals.size] = new;
  }

  new_goals = getEntArray(target, #targetname);

  foreach(new in new_goals) {
    if(!is_target_goal_valid(new)) {
      continue;
    }

    goals[goals.size] = new;
  }

  return goals;
}

function is_target_goal_valid(object) {
  if(isspawner(object)) {
    return false;
  }

  switch (object.code_classname) {
    case #"hash_1b79c5d9e0f9886a":
    case #"hash_5e0756fcd4e0adcd":
    case #"hash_8040aa10d9cac1e8":
    case #"hash_81903cb95a447b8c":
      return false;
  }

  return true;
}

function function_1c4d8240d6eef5d6(node) {
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

function function_e99ef71b95bae0f7(patrolname) {
  assert(isDefined(level.var_4d73ff8077782af[patrolname]), "<dev string:xea>");
  leader = ai_formation::get_leader(patrolname);

  if(!isDefined(leader) && level.var_4d73ff8077782af[patrolname].array.size > 0) {
    leader = level.var_4d73ff8077782af[patrolname].array[0];
  }

  return leader;
}

function private function_eff830f2c3f56ec4(node, leader) {
  interactionid = self getinteractionid();

  if(isDefined(interactionid)) {
    msg = utility::waittill_any_return("\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f", "\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");

    if(msg == "\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f") {
      self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
    }
  } else if(!function_1c4d8240d6eef5d6(node)) {
    if(!isDefined(node)) {
      if(isDefined(leader.patroltarget)) {
        node = leader.patroltarget;
      } else {
        node = level.var_4d73ff8077782af[self.grouppatrolname].groupleadertarget;
      }
    }

    if(!isDefined(node.script_delay) && function_1c4d8240d6eef5d6(leader.patroltarget)) {
      wait 0.5;
      self notify("\"\xa8\xf5\x1f&\xff4'\xd0e\xe2 \xc0w\x0f\xbe\xb6\b\xc92\">\x14\xfa(\xd3\xfa\x1c");
      return;
    }

    node utility::script_delay();
  }

  if(isDefined(node.script_flag_wait)) {
    utility::flag_wait(node.script_flag_wait);
  }

  if(isDefined(node.script_ent_flag_wait)) {
    utility::ent_flag_wait(node.script_ent_flag_wait);
  }

  node utility::script_wait();
  self notify("\"\xa8\xf5\x1f&\xff4'\xd0e\xe2 \xc0w\x0f\xbe\xb6\b\xc92\">\x14\xfa(\xd3\xfa\x1c");
}

function private function_ff1a10bc062c4e02(patrolname, aitoadd, formationtype) {
  index = level.var_4d73ff8077782af[patrolname].array.size;
  level.var_4d73ff8077782af[patrolname].array[index] = aitoadd;
  aitoadd.grouppatrolname = patrolname;
  ai_formation::function_8565456e89e312b0(patrolname, aitoadd, formationtype);
  aitoadd thread function_fc7f70a6c3f6f531(formationtype);
}

function function_c8d1dab4b8e9ecf4(patrolname, customoffsetlist) {
  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    return;
  }

  ai_formation::function_c8d1dab4b8e9ecf4(patrolname, customoffsetlist);
}

function function_d40312f436b7806d(patrolname, formationslot, customoffset) {
  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    return;
  }

  ai_formation::function_d40312f436b7806d(patrolname, formationslot, customoffset);
}

function set_goal(patrolname, goalposition) {
  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    return;
  }

  ai_formation::set_goal(patrolname, goalposition);
}

function leave_patrol(patrolname, aitoremove, permanently = 0) {
  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    return;
  }

  if(!isarray(aitoremove)) {
    aitoremove = [aitoremove];
  }

  foreach(ai in aitoremove) {
    ai_formation::leave_formation(ai);
    ai clearbtgoal(1);
    node = ai.patroltarget;

    if(isDefined(node) && isDefined(node.interactionid)) {
      despawninteraction(node.interactionid);
      node.interactionid = undefined;
    }

    if(permanently) {
      ai notify("\xf0\x8b\xa21\x96\xf9\x1f\x13\xba%Gw\xe2\xa9Xk\xd1i=\xa9%\xd3\xeb\x9d\x92\xf0\xfc(\x06\x9e");
    }
  }

  level.var_4d73ff8077782af[patrolname].array = utility::array_remove_array(level.var_4d73ff8077782af[patrolname].array, aitoremove);
}

function function_66c0f36c1f06e14b() {
  assert(isDefined(self.grouppatrolname) && self.grouppatrolname != "<dev string:x102>", "<dev string:x106>");
  ai_formation::function_eab946ce0e4b65c1(self.grouppatrolname);

  if(isDefined(self.patroltarget)) {
    level.var_4d73ff8077782af[self.grouppatrolname].groupleadertarget = self.patroltarget;
    return;
  }

  if(isDefined(self.spawnpoint.target)) {
    [level.var_4d73ff8077782af[self.grouppatrolname].groupleadertarget] = get_target_goals(self.spawnpoint.target);
  }
}

function function_48c0b4b26ea84d48(patrolname, ent, followdistance, timestep, usegoalentity = 0) {
  assert(isDefined(level.var_4d73ff8077782af) && isDefined(patrolname) && isDefined(level.var_4d73ff8077782af[patrolname]), "<dev string:x136>");
  assert(isDefined(ent), "<dev string:x151>");

  if(usegoalentity) {
    thread function_8e2f09567734b7e6(patrolname, ent, followdistance, timestep);
    return;
  }

  thread function_75205eb8f2d5644d(patrolname, ent, followdistance, timestep);
}

function private function_8e2f09567734b7e6(patrolname, ent, followdistance, timestep) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("|M\xc0TF\v\xe5~\xd1?\x04 \xd1\x03\x1a" + patrolname);

  if(ai_formation::follow_entity(patrolname, ent, followdistance, timestep)) {
    foreach(agent in level.var_4d73ff8077782af[patrolname].array) {
      agent notify("\xbf\x95\xb30\xb9I\xab\xd8\xf9m\x03\x99C\x13\xf6X");
    }

    ent utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xcc\x15n\xfb\x98|?\xc5", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
    function_91bc361b1ddc4511(patrolname);
  }
}

function private function_75205eb8f2d5644d(patrolname, ent, followdistance = 100, timestep = 2.5) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("|M\xc0TF\v\xe5~\xd1?\x04 \xd1\x03\x1a" + patrolname);

  foreach(agent in level.var_4d73ff8077782af[patrolname].array) {
    agent notify("\xbf\x95\xb30\xb9I\xab\xd8\xf9m\x03\x99C\x13\xf6X");
  }

  function_d9e8c9199d57afaa(level.formationlist[patrolname], followdistance);
  thread function_24d32ca516498081(patrolname, ent, followdistance, timestep);
  ent utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xcc\x15n\xfb\x98|?\xc5", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  function_91bc361b1ddc4511(patrolname);
}

function private function_24d32ca516498081(patrolname, ent, followdistance, timestep) {
  ent endon("\x1e\xfd\xd1\xa2\a");
  ent endon("\xcc\x15n\xfb\x98|?\xc5");
  ent endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("|M\xc0TF\v\xe5~\xd1?\x04 \xd1\x03\x1a" + patrolname);
  notifyname = function_64bd7fabedd903a3(patrolname);
  level endon(notifyname);
  self notify("!\xbe\xcd \x18o\xb4T\x15D\xee\xc9\x88:\xd3)\tM\xbd\xfesq\xa8\xe2!\xba\x1a");
  self endon("!\xbe\xcd \x18o\xb4T\x15D\xee\xc9\x88:\xd3)\tM\xbd\xfesq\xa8\xe2!\xba\x1a");

  while(isDefined(level.var_4d73ff8077782af) && isDefined(level.var_4d73ff8077782af[patrolname])) {
    enthalfsize = ent getboundshalfsize();
    entforward = anglesToForward(ent.angles);
    offset = -1 * (followdistance + enthalfsize[0]) * entforward;
    newgoal = ent.origin + offset;
    newgoal = getclosestpointonnavmesh(newgoal);

    if(level.var_4d73ff8077782af[patrolname].array.size > 0) {
      leader = function_e99ef71b95bae0f7(patrolname);
      leader setbtgoalpos(3, newgoal);

      if(isagent(ent)) {
        leader aisetdesiredspeed(length(ent getvelocity()));
      } else if(ent vehicle::is_vehicle()) {
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

function function_91bc361b1ddc4511(patrolname) {
  if(ai_formation::function_4229ac53690d5052(patrolname)) {
    self notify("|M\xc0TF\v\xe5~\xd1?\x04 \xd1\x03\x1a" + patrolname);
    function_d9e8c9199d57afaa(level.formationlist[patrolname], 0);
    leader = function_e99ef71b95bae0f7(patrolname);
    leader aiclearscriptdesiredspeed();

    foreach(agent in level.var_4d73ff8077782af[patrolname].array) {
      agent thread function_e32caa8a3e5d9a58(patrolname);
    }
  }
}

function function_81816c3d87acb174(patrolname, formationshape, horizontalseparation, verticalseparation, leaderinfront = 0) {
  if(!isDefined(level.var_4d73ff8077782af[patrolname])) {
    return;
  }

  numai = level.var_4d73ff8077782af[patrolname].array.size;

  if(numai == 0) {
    return;
  }

  leaderinfront = leaderinfront || formationshape == 1;
  level.var_4d73ff8077782af[patrolname].formationwidth = ai_formation::function_4b7f6ccb8ef62b13(patrolname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront);
  level.var_4d73ff8077782af[patrolname].horizontalseparation = horizontalseparation;
  level.var_4d73ff8077782af[patrolname].verticalseparation = verticalseparation;
  level.var_4d73ff8077782af[patrolname].var_fc58572195a06a73 = formationshape;
  level.var_4d73ff8077782af[patrolname].leaderinfront = leaderinfront;

  if(!isDefined(level.var_4d73ff8077782af[patrolname].var_cc888d8684d55970)) {
    level.var_4d73ff8077782af[patrolname].var_cc888d8684d55970 = formationshape;
  }

  if(formationshape == level.var_4d73ff8077782af[patrolname].var_cc888d8684d55970) {
    level.var_4d73ff8077782af[patrolname].desiredformationwidth = level.var_4d73ff8077782af[patrolname].formationwidth;
  }
}