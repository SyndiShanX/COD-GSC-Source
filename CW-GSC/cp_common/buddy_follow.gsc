/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\buddy_follow.gsc
***********************************************/

#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#namespace buddy_follow;

function setup_group(a_ai_allies, var_77bf059, origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f) {
  foreach(ai_ally in a_ai_allies) {
    thread setup(ai_ally, var_77bf059, origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f);
    waitframe(1);
  }
}

function setup(ai_ally, var_77bf059, origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f) {
  setDvar(#"hash_38c88655f7992f1", 0);
  ai_ally notify(#"hash_b28e3170e3298cc");
  ai_ally notify(#"hash_7328a58406b403f2");
  ai_ally endon(#"hash_7328a58406b403f2");
  ai_ally endon(#"death");
  ai_ally thread function_26516a6b();

  if(!isDefined(var_77bf059)) {
    var_77bf059 = "flag_buddy_follow";

    if(!flag::exists(var_77bf059)) {
      flag::init(var_77bf059);
    }

    flag::set(var_77bf059);
  }

  if(!flag::exists(var_77bf059)) {
    flag::init(var_77bf059);
  }

  while(true) {
    level flag::wait_till(var_77bf059);
    thread enable(ai_ally, origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f);
    wait 5;
    level flag::wait_till_clear(var_77bf059);
    thread disable(ai_ally);
    wait 5;
  }
}

function function_87d6e56c(a_ai_allies, origin_destination) {
  foreach(ai_ally in a_ai_allies) {
    ai_ally update_destination(origin_destination);
  }
}

function update_destination(origin_destination) {
  self.origin_destination = origin_destination;
}

function private enable(ai_ally, origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f) {
  ai_ally endon(#"hash_7328a58406b403f2");
  ai_ally endon(#"death");
  ai_ally colors::enable();
  waitframe(1);
  ai_ally.fixednode = 0;
  ai_ally thread function_3bec0f16(origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f);
}

function private disable(ai_ally) {
  ai_ally endon(#"hash_7328a58406b403f2");
  ai_ally endon(#"death");
  ai_ally notify(#"hash_44705d910aba5899");
  ai_ally colors::enable();
}

function private function_26516a6b() {
  self endon(#"death");
  self endon(#"hash_b28e3170e3298cc");
  self waittill(#"hash_7328a58406b403f2");
  self colors::enable();
}

function private function_3bec0f16(origin_destination, var_b05557d5, var_7b06dc88, var_90c75dbe, var_92c0650f) {
  self endon(#"hash_7328a58406b403f2");
  self endon(#"death");
  self endon(#"hash_44705d910aba5899");

  if(!isDefined(var_b05557d5)) {
    var_b05557d5 = 300;
  }

  if(!isDefined(var_7b06dc88)) {
    var_7b06dc88 = 500;
  }

  if(!isDefined(var_90c75dbe)) {
    var_90c75dbe = 100;
  }

  if(isDefined(origin_destination)) {
    self.origin_destination = origin_destination;
  } else {
    self.origin_destination = undefined;
  }

  self.radius = var_b05557d5;
  var_1f293173 = var_b05557d5 * var_b05557d5;
  var_fecff539 = var_7b06dc88 * var_7b06dc88;
  var_e9aa7ce8 = var_90c75dbe * var_90c75dbe;
  self.var_974e3fcf = 0;
  e_player = getplayers()[0];
  self childthread function_dceb4d78(5);

  self childthread debug(e_player, var_90c75dbe);

  while(true) {
    node = undefined;

    self.status = "<dev string:x38>";

    int_tries = 0;

    while(!isDefined(node) && int_tries < 10) {
      if(isDefined(self.origin_destination)) {
        if(getDvar(#"hash_38c88655f7992f1", 0)) {
          print3d(self.origin_destination, "<dev string:x41>", (1, 0, 0), 1, 1, 100);
        }

        a_nodes = getnodesinradius(e_player.origin, var_b05557d5, 16);
        a_nodes = arraysortclosest(a_nodes, self.origin_destination);

        if(getDvar(#"hash_38c88655f7992f1", 0)) {
          foreach(node in a_nodes) {
            print3d(node.origin, "<dev string:x41>", (0, 0, 1), 1, 1, 100);
          }
        }

        node = a_nodes[0];
        int = 0;

        while(isDefined(node) && int < a_nodes.size) {
          var_6321fdbe = 0;

          if(isDefined(node.script_noteworthy) && isDefined(var_92c0650f)) {
            var_d168712b = strtok(node.script_noteworthy, ",");

            if(var_d168712b.size > 0) {
              foreach(str_script_noteworthy in var_d168712b) {
                if(str_script_noteworthy == var_92c0650f) {
                  var_6321fdbe = 1;
                  break;
                }
              }
            }
          }

          if(!var_6321fdbe) {
            if(!isnodeoccupied(node)) {
              break;
            } else if(isnodeoccupied(node) && isDefined(getnodeowner(node)) && getnodeowner(node) == self) {
              break;
            }
          }

          int++;
          node = a_nodes[int];
          waitframe(1);
        }

        if(isDefined(node) && getDvar(#"hash_38c88655f7992f1", 0)) {
          print3d(node.origin + (0, 0, 32), "<dev string:x41>", (1, 0, 0), 1, 1, 100);
        }
      } else if(int_tries < 7.14286) {
        node = self findbestcovernode();
      } else {
        node = self choosebettercovernode();
      }

      int_tries++;

      if(!isDefined(node) || distance2dsquared(e_player getorigin(), node.origin) > var_1f293173) {
        if(isDefined(node) && getDvar(#"hash_38c88655f7992f1", 0)) {
          sphere(node.origin, 6, (1, 0, 0), 0, 20);
          line(node.origin, self.origin, (1, 0, 0), 1, 0, 20);
        }

        node = undefined;
        self.claimed_node = undefined;
        wait 0.25;
      }
    }

    self.status = "<dev string:x46>";

    if(isDefined(node)) {
      var_c664461e = 0;

      if(!isDefined(self.claimed_node)) {
        var_c664461e = 1;
      } else if(isDefined(self.claimed_node) && self.claimed_node != node && isDefined(self.origin_destination)) {
        dis_claimed = distance2dsquared(self.claimed_node.origin, self.origin_destination);
        dis_node = distance2dsquared(node.origin, self.origin_destination);
        var_d919d37b = distance2dsquared(e_player getorigin(), self.origin);
        dis_delta = dis_claimed - dis_node;

        if(var_e9aa7ce8 < dis_delta || var_d919d37b > var_fecff539) {
          var_c664461e = 1;
        }
      }

      if(var_c664461e) {
        self.status = "<dev string:x51>";

        self.claimed_node = node;
        self.var_974e3fcf = 0;
        self.keepclaimednode = 0;
        self setgoal(node);
        self usecovernode(node);
      }

      if(getDvar(#"hash_38c88655f7992f1", 0)) {
        sphere(node.origin, 8, (1, 1, 1), 0, 440);
        line(node.origin, self.origin, (1, 1, 1), 1, 0, 140);
      }

      if(isDefined(self.origin_destination)) {
        while(true) {
          var_eaa1c88c = distance2dsquared(self.origin, self.origin_destination) + var_e9aa7ce8;
          var_ec55cf58 = distance2dsquared(e_player getorigin(), self.origin_destination);
          level.var_eaa1c88c = var_eaa1c88c;
          level.var_ec55cf58 = var_ec55cf58;

          if(var_eaa1c88c > var_ec55cf58) {
            break;
          }

          var_d919d37b = distance2dsquared(e_player getorigin(), self.origin);

          if(var_d919d37b > var_fecff539) {
            break;
          }

          waitframe(1);
        }
      } else {
        while(distance2dsquared(e_player getorigin(), self.origin) + var_e9aa7ce8 < var_1f293173) {
          waitframe(1);
        }
      }
    } else {
      self.status = "<dev string:x57>";

      self.var_974e3fcf = 1;
    }

    waitframe(1);
  }
}

function private function_dceb4d78(var_e9430cc4) {
  e_player = getplayers()[0];

  if(!isDefined(level.var_f1028da5)) {
    level.var_f1028da5 = 128;
  }

  while(true) {
    if(self.var_974e3fcf) {
      self.status = "<dev string:x5e>";

      v_player_origin = e_player.origin;
      var_35af15c0 = randomfloatrange(v_player_origin[0] - level.var_f1028da5, v_player_origin[0] + level.var_f1028da5);
      var_6372f147 = randomfloatrange(v_player_origin[1] - level.var_f1028da5, v_player_origin[1] + level.var_f1028da5);
      var_59ecde3b = v_player_origin[2];
      self setgoal((var_35af15c0, var_6372f147, var_59ecde3b));
      wait var_e9430cc4;
      self.var_974e3fcf = 0;
      continue;
    }

    waitframe(1);
  }
}

function private debug(e_player, var_90c75dbe) {
  self.status = "<dev string:x64>";

  while(true) {
    if(getDvar(#"hash_38c88655f7992f1", 0)) {
      if(isDefined(self.origin_destination)) {
        if(!isDefined(level.var_eaa1c88c)) {
          var_eaa1c88c = distance2d(self.origin, self.origin_destination) + var_90c75dbe;
        } else {
          var_eaa1c88c = sqrt(level.var_eaa1c88c);
        }

        if(!isDefined(level.var_ec55cf58)) {
          var_ec55cf58 = distance2d(e_player getorigin(), self.origin_destination);
        } else {
          var_ec55cf58 = sqrt(level.var_ec55cf58);
        }

        print3d(self.origin + (0, 0, 68), self.status + "<dev string:x69>" + var_eaa1c88c + "<dev string:x69>" + var_ec55cf58, (0, 0, 0), 1, 0.5);
      } else {
        dist = int(distance2d(e_player getorigin(), self.origin));
        print3d(self.origin + (0, 0, 68), self.status + "<dev string:x69>" + dist, (0, 0, 0), 1, 0.5);
      }
    }

    waitframe(1);
  }
}