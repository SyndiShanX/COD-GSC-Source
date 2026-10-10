/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_21f09868d3739a15.gsc
*************************************************/

#using scripts\asm\soldier\vehicle;
#using scripts\common\ai;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace namespace_df392a06b5c03994;

function setup_group(a_ai_allies, var_d1f4d0d1fc013b1f, origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_5f615c979fc694e4, var_2bacd2f368c003e9, var_2f4643efe82e3a06) {
  foreach(ai_ally in a_ai_allies) {
    thread setup(ai_ally, var_d1f4d0d1fc013b1f, origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_5f615c979fc694e4, var_2bacd2f368c003e9, var_2f4643efe82e3a06);
    waitframe();
  }
}

function setup(ai_ally, var_d1f4d0d1fc013b1f, origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_5f615c979fc694e4, var_2bacd2f368c003e9, var_2f4643efe82e3a06) {
  setDvar(@ "hash_6fce5c3eda16a53a", 0);
  ai_ally notify("terminate_color_wait");
  ai_ally notify("buddy_follow_stop");
  ai_ally endon("buddy_follow_stop");
  ai_ally endon("death");
  ai_ally thread function_ff820502f10e71b();
  var_5f615c979fc694e4 = default_to(var_5f615c979fc694e4, 5);

  if(!isDefined(var_d1f4d0d1fc013b1f)) {
    var_d1f4d0d1fc013b1f = "flag_buddy_follow";

    if(!flag_exist(var_d1f4d0d1fc013b1f)) {
      flag_init(var_d1f4d0d1fc013b1f);
    }

    flag_set(var_d1f4d0d1fc013b1f);
  }

  if(!flag_exist(var_d1f4d0d1fc013b1f)) {
    flag_init(var_d1f4d0d1fc013b1f);
  }

  while(true) {
    level flag_wait(var_d1f4d0d1fc013b1f);
    thread function_a73b25993f1f75da(ai_ally, origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_2bacd2f368c003e9, var_2f4643efe82e3a06);
    wait var_5f615c979fc694e4;
    level flag_waitopen(var_d1f4d0d1fc013b1f);
    thread disable(ai_ally);
    wait var_5f615c979fc694e4;
  }
}

function function_1660f7af3460d5db(a_ai_allies, origin_destination) {
  foreach(ai_ally in a_ai_allies) {
    ai_ally update_destination(origin_destination);
  }
}

function update_destination(origin_destination) {
  self.origin_destination = origin_destination;
}

function private function_a73b25993f1f75da(ai_ally, origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_2bacd2f368c003e9, var_2f4643efe82e3a06) {
  ai_ally endon("buddy_follow_stop");
  ai_ally endon("death");
  ai_ally enable_ai_color();
  waitframe();
  ai_ally.fixednode = 0;
  ai_ally thread function_a9b3b52ffeb476da(origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_2bacd2f368c003e9, var_2f4643efe82e3a06);
}

function disable(ai_ally) {
  ai_ally endon("buddy_follow_stop");
  ai_ally endon("death");
  ai_ally notify("buddy_follow_reset_color");
  ai_ally enable_ai_color();
}

function private function_ff820502f10e71b() {
  self endon("death");
  self endon("terminate_color_wait");
  self waittill("buddy_follow_stop");
  enable_ai_color();
}

function private function_7b8369bf4c4adb52(stealth_radius, buddy_radius) {
  var_c5942556f6e977e0 = 0.5;
  var_7b8369bf4c4adb52 = level.player.origin;
  var_9717d7e4af0884e7 = level.player ent_flag("stealth_enabled") && isDefined(level.player.stealth) && isDefined(level.player.stealth.combatstate) && (level.player.stealth.combatstate.name == "stealth" || level.player.stealth.combatstate.name == "combat" && level.player.stealth.combatstate.type == "unaware");

  if(istrue(var_9717d7e4af0884e7) && isDefined(self.var_efa08cbe555cb7b7)) {
    dest_vector = vectornormalize2(self.var_efa08cbe555cb7b7 - level.player.origin);
    var_8f6f4e75ab8411bb = anglesToForward(level.player.angles);
    var_e8eab8a46dea3197 = 0;
    moving = 1;

    if(vectordot2(dest_vector, var_8f6f4e75ab8411bb) > var_c5942556f6e977e0) {
      buddy_vector = vectorNormalize(dest_vector + var_8f6f4e75ab8411bb);
      var_7b8369bf4c4adb52 = level.player.origin - buddy_vector * stealth_radius;
      var_e8eab8a46dea3197 = 1;
    }

    if(!var_e8eab8a46dea3197 || distance(self.origin, var_7b8369bf4c4adb52) > buddy_radius) {
      var_6cb48d65c9feac82 = vectornormalize2(level.player.origin - self.origin);
      var_7b8369bf4c4adb52 = level.player.origin - var_6cb48d65c9feac82 * stealth_radius;
    }

    if(distancesquared(var_7b8369bf4c4adb52, level.player.origin) > distancesquared(self.origin, level.player.origin)) {
      var_7b8369bf4c4adb52 = self.origin;
      moving = 0;
    }

    if(moving) {
      enemies = getaiarrayinradius(var_7b8369bf4c4adb52, buddy_radius);

      if(enemies.size > 0) {
        var_7b8369bf4c4adb52 = self.origin;
        moving = 0;
      }
    }
  }

  if(getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
    sphere(var_7b8369bf4c4adb52, 300, (1, 1, 0), 0, 20);
  }

  return var_7b8369bf4c4adb52;
}

function private function_a9b3b52ffeb476da(origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97, var_2bacd2f368c003e9, var_2f4643efe82e3a06) {
  self endon("buddy_follow_stop");
  self endon("death");
  self endon("buddy_follow_reset_color");

  if(!isDefined(var_cd8bc43698a828cc)) {
    var_cd8bc43698a828cc = 300;
  }

  if(!isDefined(var_352a8978dcbaa34c)) {
    var_352a8978dcbaa34c = 500;
  }

  if(!isDefined(var_a4365597f945dcfd)) {
    var_a4365597f945dcfd = 100;
  }

  if(!isDefined(var_2bacd2f368c003e9)) {
    var_2bacd2f368c003e9 = 500;
  }

  if(!isDefined(var_2f4643efe82e3a06)) {
    var_2f4643efe82e3a06 = 500;
  }

  if(isDefined(origin_destination)) {
    self.var_efa08cbe555cb7b7 = origin_destination;
  } else {
    self.var_efa08cbe555cb7b7 = undefined;
  }

  set_goal_radius(var_cd8bc43698a828cc);
  var_31b07a6da1f527dd = var_cd8bc43698a828cc * var_cd8bc43698a828cc;
  var_96d01425dddb9157 = var_352a8978dcbaa34c * var_352a8978dcbaa34c;
  var_483ce96ebcb45635 = var_2bacd2f368c003e9 * var_2bacd2f368c003e9;
  var_f7f875896c86568b = var_2f4643efe82e3a06 * var_2f4643efe82e3a06;
  var_73e27a81a22f4ae = var_a4365597f945dcfd * var_a4365597f945dcfd;
  self.var_bbc91b82b805637b = 0;
  childthread function_4d76760fa4973094(2, 300, var_2bacd2f368c003e9);

  childthread function_b2e2745e9fab4f1c(var_a4365597f945dcfd);

  node = undefined;

  while(true) {
    if(isnotinvehicle()) {
      buddy_radius = var_cd8bc43698a828cc;
      var_4dbbca3f9a168ae0 = var_31b07a6da1f527dd;
      var_64c8bd1651cd31a7 = var_96d01425dddb9157;
      in_stealth = level.player ent_flag("stealth_enabled") && isDefined(level.player.stealth) && isDefined(level.player.stealth.combatstate) && level.player.stealth.combatstate.name == "stealth";

      if(istrue(in_stealth) && isDefined(self.var_efa08cbe555cb7b7)) {}

      if(!isDefined(node)) {
        self.status = "<dev string:x1c>";
      }

      node = undefined;
      cover_origin = function_7b8369bf4c4adb52(var_2bacd2f368c003e9, buddy_radius);
      a_nodes = getnodesinradius(cover_origin, buddy_radius, 16);

      if(isDefined(self.var_efa08cbe555cb7b7)) {
        a_nodes = sortbydistance(a_nodes, self.var_efa08cbe555cb7b7);

        if(istrue(in_stealth)) {
          a_nodes = array_reverse(a_nodes);
        }
      }

      int_tries = 0;

      while(!isDefined(node) && int_tries < 10 && isnotinvehicle()) {
        if(isDefined(self.var_efa08cbe555cb7b7)) {
          if(getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
            print3d(self.var_efa08cbe555cb7b7, "<dev string:x22>", (1, 0, 0), 1, 1, 100);
          }

          if(getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
            foreach(node in a_nodes) {
              print3d(node.origin, "<dev string:x22>", (0, 0, 1), 1, 1, 100);
            }
          }

          node = a_nodes[0];
          i = 0;

          while(isnotinvehicle() && isDefined(node) && i < a_nodes.size) {
            var_435b9e05bc66894a = 0;

            if(isDefined(node.script_noteworthy) && isDefined(var_7457e67b7a059a97)) {
              var_cc46cae885d1e678 = strtok(node.script_noteworthy, ",");

              if(var_cc46cae885d1e678.size > 0) {
                foreach(str_script_noteworthy in var_cc46cae885d1e678) {
                  if(str_script_noteworthy == var_7457e67b7a059a97) {
                    var_435b9e05bc66894a = 1;
                    break;
                  }
                }
              }
            }

            if(!var_435b9e05bc66894a) {
              if(!isnodeoccupied(node)) {
                break;
              } else if(isnodeoccupied(node) && isDefined(getnodeowner(node)) && getnodeowner(node) == self) {
                break;
              }
            }

            i++;
            node = a_nodes[i];
            waitframe();
          }

          if(isDefined(node) && getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
            print3d(node.origin + (0, 0, 32), "<dev string:x22>", (1, 0, 0), 1, 1, 100);
          }
        } else if(int_tries < 7.14286) {
          node = self findbestcovernode(undefined, undefined, cover_origin);
        } else {
          node = self findbestcovernode(undefined, 1, cover_origin, 1);
        }

        int_tries++;

        if(!isDefined(node) || distance2dsquared(level.player getorigin(), node.origin) > var_4dbbca3f9a168ae0) {
          if(isDefined(node) && getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
            sphere(node.origin, 6, (1, 0, 0), 0, 20);
            line(node.origin, self.origin, (1, 0, 0), 1, 0, 20);
          }

          node = undefined;
          self.claimed_node = undefined;
          wait 0.25;

          if(!self.var_bbc91b82b805637b) {
            self.status = "<dev string:x24>";
          }
        }
      }

      if(isDefined(node)) {
        var_25b85621d09fb28d = 0;

        if(!isDefined(self.claimed_node)) {
          var_25b85621d09fb28d = 1;
        } else if(isDefined(self.claimed_node) && self.claimed_node != node && isDefined(self.var_efa08cbe555cb7b7)) {
          dis_claimed = distance2dsquared(self.claimed_node.origin, self.var_efa08cbe555cb7b7);
          dis_node = distance2dsquared(node.origin, self.var_efa08cbe555cb7b7);
          var_cdd232e6e1878821 = distance2dsquared(level.player getorigin(), self.origin);
          dis_delta = dis_claimed - dis_node;

          if(var_73e27a81a22f4ae < dis_delta || var_cdd232e6e1878821 > var_64c8bd1651cd31a7) {
            var_25b85621d09fb28d = 1;
          }
        }

        if(var_25b85621d09fb28d) {
          self.status = "<dev string:x2c>";

          self.claimed_node = node;
          self.var_bbc91b82b805637b = 0;
          self.keepclaimednode = 0;
          set_goal_node(node);
        }

        if(getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
          sphere(node.origin, 8, (1, 1, 1), 0, 440);
          line(node.origin, self.origin, (1, 1, 1), 1, 0, 140);
        }

        if(isDefined(self.var_efa08cbe555cb7b7)) {
          while(isnotinvehicle() && isDefined(self.var_efa08cbe555cb7b7)) {
            var_8f80da667ab5b34e = distance2dsquared(self.origin, self.var_efa08cbe555cb7b7) + var_73e27a81a22f4ae;
            var_77f7ed9eb6ed7dbd = distance2dsquared(level.player getorigin(), self.var_efa08cbe555cb7b7);
            level.var_8f80da667ab5b34e = var_8f80da667ab5b34e;
            level.var_77f7ed9eb6ed7dbd = var_77f7ed9eb6ed7dbd;

            if(istrue(in_stealth) && !(level.player ent_flag("stealth_enabled") && isDefined(level.player.stealth.combatstate) && level.player.stealth.combatstate.name == "stealth")) {
              break;
            }

            if(var_8f80da667ab5b34e > var_77f7ed9eb6ed7dbd) {
              break;
            }

            var_cdd232e6e1878821 = distance2dsquared(level.player getorigin(), self.origin);

            if(var_cdd232e6e1878821 > var_64c8bd1651cd31a7) {
              break;
            }

            waitframe();
          }
        } else {
          while(isnotinvehicle() && distance2dsquared(level.player getorigin(), self.origin) + var_73e27a81a22f4ae < var_4dbbca3f9a168ae0) {
            if(istrue(in_stealth) && !(level.player ent_flag("stealth_enabled") && isDefined(level.player.stealth.combatstate) && level.player.stealth.combatstate.name == "stealth")) {
              break;
            }

            waitframe();
          }
        }
      } else {
        self.status = "<dev string:x2f>";

        self.var_bbc91b82b805637b = 1;
      }
    }

    waitframe();
  }
}

function private function_4d76760fa4973094(refreshtime, follow_offset, stealth_radius) {
  if(!isDefined(follow_offset)) {
    follow_offset = 128;
  }

  if(isDefined(level.var_da112e44cbc8ba86)) {
    follow_offset = level.var_da112e44cbc8ba86;
  }

  var_de95bf48b4a3b6eb = follow_offset * follow_offset;

  while(true) {
    if(isnotinvehicle() && self.var_bbc91b82b805637b) {
      v_player_origin = function_7b8369bf4c4adb52(stealth_radius, follow_offset);

      if(distance2dsquared(self.origin, v_player_origin) > var_de95bf48b4a3b6eb) {
        var_1944e85ba80d8c3f = randomfloatrange(v_player_origin[0] - follow_offset, v_player_origin[0] + follow_offset);
        var_1944e75ba80d8a0c = randomfloatrange(v_player_origin[1] - follow_offset, v_player_origin[1] + follow_offset);
        var_1944ea5ba80d90a5 = v_player_origin[2];
        goal_pos = scripts\engine\utility::drop_to_ground((var_1944e85ba80d8c3f, var_1944e75ba80d8a0c, var_1944ea5ba80d90a5));
        set_goal_pos(goal_pos);

        self.status = "<dev string:x33>";
      }

      wait refreshtime;
      self.var_bbc91b82b805637b = 0;
      continue;
    }

    waitframe();
  }
}

function private function_b2e2745e9fab4f1c(var_a4365597f945dcfd) {
  self.status = "<dev string:x36>";

  while(true) {
    if(getdvarint(@ "hash_6fce5c3eda16a53a", 0)) {
      if(isDefined(self.var_efa08cbe555cb7b7)) {
        if(!isDefined(level.var_8f80da667ab5b34e)) {
          var_8f80da667ab5b34e = distance2d(self.origin, self.var_efa08cbe555cb7b7) + var_a4365597f945dcfd;
        } else {
          var_8f80da667ab5b34e = sqrt(level.var_8f80da667ab5b34e);
        }

        if(!isDefined(level.var_77f7ed9eb6ed7dbd)) {
          var_77f7ed9eb6ed7dbd = distance2d(level.player getorigin(), self.var_efa08cbe555cb7b7);
        } else {
          var_77f7ed9eb6ed7dbd = sqrt(level.var_77f7ed9eb6ed7dbd);
        }

        print3d(self.origin + (0, 0, 68), self.status + "<dev string:x38>" + var_8f80da667ab5b34e + "<dev string:x38>" + var_77f7ed9eb6ed7dbd, (0, 0, 0), 1, 0.5);
      } else {
        dist = int(distance2d(level.player getorigin(), self.origin));
        print3d(self.origin + (0, 0, 68), self.status + "<dev string:x38>" + dist, (0, 0, 0), 1, 0.5);
      }
    }

    waitframe();
  }
}

# /