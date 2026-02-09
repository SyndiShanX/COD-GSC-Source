/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42784.gsc
**************************************/

waittill_aerial_pathnodes_calculated() {
  while(!isDefined(level.calculated_aerial_nodes_done) || !level.calculated_aerial_nodes_done) {
    wait 0.5;
  }
}

get_aerial_offset() {
  if(isDefined(level.aerial_pathnode_offset)) {
    return (0, 0, level.aerial_pathnode_offset);
  } else {
    return (0, 0, 500);
  }
}

get_group_connect_dist() {
  if(isDefined(level.aerial_pathnode_group_connect_dist)) {
    if(level.nextgen) {} else {}

    return level.aerial_pathnode_group_connect_dist;
  } else {
    return 250;
  }
}

node_is_valid__to_convert_to_aerial_pathnode(var_0) {
  return var_0.type == "Path" && nodeexposedtosky(var_0, 1) && !var_0 nodeisdisconnected() || isDefined(var_0.forceenableaerialnode) && var_0.forceenableaerialnode;
}

calculate_aerial_pathnodes() {
  if(isDefined(level.calculated_aerial_nodes_in_progress) || isDefined(level.calculated_aerial_nodes_done)) {
    return;
  }
  var_0 = getDvar("mapname");

  if(var_0 == getDvar("virtualLobbyMap") || var_0 == "mp_character_room" || getdvarint("virtualLobbyActive") == 1) {
    return;
  }
  level.calculated_aerial_nodes_in_progress = 1;
  level.calculated_aerial_nodes_done = 0;
  wait 0.5;
  level.aerial_pathnodes = [];
  var_1 = getallnodes();

  foreach(var_3 in var_1) {
    if(node_is_valid__to_convert_to_aerial_pathnode(var_3)) {
      level.aerial_pathnodes[level.aerial_pathnodes.size] = var_3;

      if(!isDefined(var_3.aerial_neighbors)) {
        var_3.aerial_neighbors = [];
      }

      var_4 = getlinkednodes(var_3);

      foreach(var_6 in var_4) {
        if(node_is_valid__to_convert_to_aerial_pathnode(var_6) && !common_scripts\utility::array_contains(var_3.aerial_neighbors, var_6)) {
          var_3.aerial_neighbors[var_3.aerial_neighbors.size] = var_6;

          if(!isDefined(var_6.aerial_neighbors)) {
            var_6.aerial_neighbors = [];
          }

          if(!common_scripts\utility::array_contains(var_6.aerial_neighbors, var_3)) {
            var_6.aerial_neighbors[var_6.aerial_neighbors.size] = var_3;
          }
        }
      }
    }
  }

  var_1 = undefined;
  wait 0.05;
  var_9 = divide_nodes_into_groups(level.aerial_pathnodes, 1);
  var_10 = 3;

  if(!0) {
    var_11 = get_group_connect_dist();
    var_12 = [];
    var_13 = 0;

    for(var_14 = 0; var_14 < var_9.size; var_14++) {
      if(!isDefined(var_12[var_14])) {
        var_12[var_14] = [];
      }

      foreach(var_3 in var_9[var_14]) {
        for(var_16 = var_14 + 1; var_16 < var_9.size; var_16++) {
          if(!isDefined(var_12[var_14][var_16])) {
            var_12[var_14][var_16] = [];
          }

          var_17 = [];

          foreach(var_19 in var_9[var_16]) {
            var_20 = distance(var_3.origin, var_19.origin);
            var_21 = var_20 < var_11;
            var_22 = 0;

            if(!var_21) {
              if(isDefined(level.aerial_pathnodes_force_connect)) {
                foreach(var_24 in level.aerial_pathnodes_force_connect) {
                  var_25 = squared(var_24.radius);

                  if(distance2dsquared(var_24.origin, var_3.origin) < var_25 && distance2dsquared(var_24.origin, var_19.origin) < var_25) {
                    var_22 = 1;
                    break;
                  }
                }
              }
            }

            var_27 = var_17.size < var_10 || var_20 < var_17[var_10 - 1][2];

            if(var_21 && var_27) {
              if(var_17.size == var_10) {
                var_17[var_10 - 1] = undefined;
              }

              var_17[var_17.size] = [var_3, var_19, var_20];
              var_17 = common_scripts\utility::array_sort_with_func(var_17, ::is_pair_a_closer_than_pair_b);
              continue;
            }

            if(var_22) {
              var_12[var_14][var_16][var_12[var_14][var_16].size] = [var_3, var_19, -1];
            }
          }

          foreach(var_30 in var_17) {
            var_12[var_14][var_16][var_12[var_14][var_16].size] = var_30;
          }
        }

        var_13++;

        if(var_13 >= 50) {
          var_13 = 0;
          wait 0.05;
        }
      }
    }

    wait 0.05;
    var_33 = 0;

    for(var_14 = 0; var_14 < var_9.size; var_14++) {
      for(var_16 = var_14 + 1; var_16 < var_9.size; var_16++) {
        var_33 = var_33 + var_12[var_14][var_16].size;
        var_12[var_14][var_16] = common_scripts\utility::array_sort_with_func(var_12[var_14][var_16], ::is_pair_a_closer_than_pair_b, 150);

        if(var_33 > 500) {
          wait 0.05;
          var_33 = 0;
        }
      }
    }

    wait 0.05;
    var_34 = get_aerial_offset();
    var_35 = 10;
    var_36 = 0;

    if(0) {
      level.added_aerial_links = [];
    }

    for(var_14 = 0; var_14 < var_9.size; var_14++) {
      for(var_16 = var_14 + 1; var_16 < var_9.size; var_16++) {
        foreach(var_38 in var_12[var_14][var_16]) {
          var_39 = var_38[0];
          var_40 = var_38[1];

          if(!node0_has_neighbor_connected_to_node1(var_39, var_40)) {
            var_41 = num_node_connections_to_group(var_39, var_40.aerial_group);
            var_42 = num_node_connections_to_group(var_40, var_39.aerial_group);

            if(var_41 < var_10 && var_42 < var_10) {
              var_43 = playerphysicstrace(var_39.origin + var_34, var_40.origin + var_34);
              var_36++;
              var_44 = distancesquared(var_43, var_40.origin + var_34) < 1;

              if(!var_44 && var_38[2] == -1) {
                var_44 = bullettracepassed(var_39.origin + var_34, var_40.origin + var_34, 0, undefined);
              }

              if(var_44) {
                var_39.aerial_neighbors[var_39.aerial_neighbors.size] = var_40;
                var_40.aerial_neighbors[var_40.aerial_neighbors.size] = var_39;

                if(0) {
                  level.added_aerial_links[level.added_aerial_links.size] = [var_39, var_40];
                }
              }

              if(var_36 % var_35 == 0) {
                wait 0.05;
              }
            }
          }
        }
      }
    }

    var_12 = undefined;
    var_9 = divide_nodes_into_groups(level.aerial_pathnodes);

    if(0) {
      var_9 = common_scripts\utility::array_sort_with_func(var_9, ::is_group_a_larger_than_group_b);

      for(var_14 = 0; var_14 < var_9.size; var_14++) {
        foreach(var_3 in var_9[var_14]) {
          var_3.aerial_group = var_14;
        }
      }
    } else {
      foreach(var_3 in level.aerial_pathnodes) {
        var_3.aerial_group = undefined;
      }
    }

    var_50 = 0;

    for(var_14 = 0; var_14 < var_9.size; var_14++) {
      var_50 = max(var_9[var_14].size, var_50);
    }

    for(var_14 = 0; var_14 < var_9.size; var_14++) {
      if(var_9[var_14].size < 0.1 * var_50) {
        foreach(var_3 in var_9[var_14]) {
          level.aerial_pathnodes = common_scripts\utility::array_remove(level.aerial_pathnodes, var_3);

          foreach(var_6 in var_3.aerial_neighbors) {
            for(var_16 = 0; var_16 < var_6.aerial_neighbors.size; var_16++) {
              var_53 = var_6.aerial_neighbors[var_16];

              if(var_53 == var_3) {
                var_6.aerial_neighbors[var_16] = var_6.aerial_neighbors[var_6.aerial_neighbors.size - 1];
                var_6.aerial_neighbors[var_6.aerial_neighbors.size - 1] = undefined;
                var_16--;
              }
            }
          }

          var_3.aerial_neighbors = undefined;
        }
      }
    }
  }

  level.calculated_aerial_nodes_done = 1;
  level.calculated_aerial_nodes_in_progress = 0;
}

is_group_a_larger_than_group_b(var_0, var_1) {
  return var_0.size > var_1.size;
}

is_pair_a_closer_than_pair_b(var_0, var_1) {
  return var_0[2] < var_1[2];
}

num_node_connections_to_group(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0.aerial_neighbors) {
    if(var_4.aerial_group == var_1) {
      var_2++;
    }
  }

  return var_2;
}

node0_has_neighbor_connected_to_node1(var_0, var_1) {
  foreach(var_3 in var_0.aerial_neighbors) {
    foreach(var_5 in var_3.aerial_neighbors) {
      if(var_5 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}

divide_nodes_into_groups(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_3 in var_0) {
    var_3.aerial_group = undefined;
  }

  var_5 = var_0;
  var_6 = [];

  while(var_5.size > 0) {
    var_7 = var_6.size;
    var_6[var_7] = [];
    var_5[0].aerial_group = -1;
    var_8 = [var_5[0]];
    var_9 = 0;

    while(var_8.size > 0) {
      var_10 = var_8[0];
      var_6[var_7][var_6[var_7].size] = var_10;
      var_10.aerial_group = var_7;
      var_8[0] = var_8[var_8.size - 1];
      var_8[var_8.size - 1] = undefined;

      foreach(var_12 in var_10.aerial_neighbors) {
        if(!isDefined(var_12.aerial_group)) {
          var_12.aerial_group = -1;
          var_8[var_8.size] = var_12;
        }
      }

      for(var_14 = 0; var_14 < var_5.size; var_14++) {
        if(var_5[var_14] == var_10) {
          var_5[var_14] = var_5[var_5.size - 1];
          var_5[var_5.size - 1] = undefined;
          break;
        }
      }

      var_9++;

      if(var_9 > 100) {
        wait 0.05;
        var_9 = 0;
      }
    }

    if(var_6[var_7].size <= var_1) {
      var_6[var_7] = undefined;
      continue;
    }

    wait 0.05;
  }

  wait 0.05;
  return var_6;
}

node_is_aerial(var_0) {
  return isDefined(var_0.aerial_neighbors);
}

get_ent_closest_aerial_node(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1500;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = getnodesinradiussorted(self.origin, var_0, var_1, get_aerial_offset()[2] * 2, "path");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(node_is_aerial(var_2[var_3])) {
      return var_2[var_3];
    }
  }
}

find_path_between_aerial_nodes(var_0, var_1) {
  var_0.path_to_this_node = [];
  var_2 = [var_0];
  var_3 = [var_0];

  while(!isDefined(var_1.path_to_this_node)) {
    var_4 = var_2[0];
    var_2 = common_scripts\utility::array_remove(var_2, var_4);

    foreach(var_6 in var_4.aerial_neighbors) {
      if(!isDefined(var_6.path_to_this_node)) {
        var_6.path_to_this_node = common_scripts\utility::array_add(var_4.path_to_this_node, var_4);
        var_2[var_2.size] = var_6;
        var_3[var_3.size] = var_6;
      }
    }
  }

  var_8 = common_scripts\utility::array_add(var_1.path_to_this_node, var_1);

  foreach(var_10 in var_3) {
    var_10.path_to_this_node = undefined;
  }

  return var_8;
}