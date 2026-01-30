/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_aerial_pathnodes.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

SCR_CONST_AERIAL_PATHNODE_OFFSET_DEFAULT = 500;
SCR_CONST_AERIAL_PATHNODE_GROUP_CONNECT_DIST_DEFAULT = 250;
SCR_CONST_AERIAL_PATHNODE_MAX_GROUP_CONNECTIONS = 3;

SCR_CONST_DEBUG_DONT_CONNECT_GROUPS = false;
SCR_CONST_DEBUG_SHOW_NODE_GROUPS = false;
SCR_CONST_DEBUG_SHOW_ADDED_LINKS = false;

waittill_aerial_pathnodes_calculated() {
  while(!isDefined(level.calculated_aerial_nodes_done) || !level.calculated_aerial_nodes_done) {
    wait(0.5);
  }
}

get_aerial_offset() {
  if(isDefined(level.aerial_pathnode_offset)) {
    return (0, 0, level.aerial_pathnode_offset);
  } else {
    return (0, 0, SCR_CONST_AERIAL_PATHNODE_OFFSET_DEFAULT);
  }
}

get_group_connect_dist() {
  if(isDefined(level.aerial_pathnode_group_connect_dist)) {
    if(level.nextgen) {
      Assert(level.aerial_pathnode_group_connect_dist <= 650);
    } else {
      Assert(level.aerial_pathnode_group_connect_dist <= 500);
    }
    return level.aerial_pathnode_group_connect_dist;
  } else {
    return SCR_CONST_AERIAL_PATHNODE_GROUP_CONNECT_DIST_DEFAULT;
  }
}

node_is_valid__to_convert_to_aerial_pathnode(node) {
  return (node.type == "Path" && NodeExposedToSky(node, true) && !node NodeIsDisconnected());
}

calculate_aerial_pathnodes() {
  if(isDefined(level.calculated_aerial_nodes_in_progress) || isDefined(level.calculated_aerial_nodes_done)) {
    return;
  }

  mapname = GetDvar("mapname");
  if(mapname == getdvar("virtualLobbyMap") || mapname == "mp_character_room" || GetDvarInt("virtualLobbyActive") == 1) {
    return;
  }

  level.calculated_aerial_nodes_in_progress = true;
  level.calculated_aerial_nodes_done = false;

  wait(0.5);

  SetDevDvarIfUninitialized("ai_showNodesAerial", 0);

  level.aerial_pathnodes = [];
  all_nodes = GetAllNodes();
  foreach(node in all_nodes) {
    if(node_is_valid__to_convert_to_aerial_pathnode(node)) {
      level.aerial_pathnodes[level.aerial_pathnodes.size] = node;
      if(!isDefined(node.aerial_neighbors)) {
        node.aerial_neighbors = [];
      }

      neighbors = GetLinkedNodes(node);
      foreach(neighbor_node in neighbors) {
        if(node_is_valid__to_convert_to_aerial_pathnode(neighbor_node) && !array_contains(node.aerial_neighbors, neighbor_node)) {
          node.aerial_neighbors[node.aerial_neighbors.size] = neighbor_node;

          if(!isDefined(neighbor_node.aerial_neighbors)) {
            neighbor_node.aerial_neighbors = [];
          }

          if(!array_contains(neighbor_node.aerial_neighbors, node)) {
            neighbor_node.aerial_neighbors[neighbor_node.aerial_neighbors.size] = node;
          }
        }
      }
    }
  }

  all_nodes = undefined;
  wait(0.05);

  node_groups = divide_nodes_into_groups(level.aerial_pathnodes, 1);
  max_group_connections = SCR_CONST_AERIAL_PATHNODE_MAX_GROUP_CONNECTIONS;

  if(!SCR_CONST_DEBUG_DONT_CONNECT_GROUPS) {
    close_dist = get_group_connect_dist();
    potential_aerial_neighbor_nodes = [];
    aerial_nodes_processed = 0;

    for(i = 0; i < node_groups.size; i++) {
      if(!isDefined(potential_aerial_neighbor_nodes[i])) {
        potential_aerial_neighbor_nodes[i] = [];
      }

      foreach(node in node_groups[i]) {
        for(j = i + 1; j < node_groups.size; j++) {
          if(!isDefined(potential_aerial_neighbor_nodes[i][j])) {
            potential_aerial_neighbor_nodes[i][j] = [];
          }

          potential_neighbors_node_in_i_to_group_j = [];
          foreach(other_node in node_groups[j]) {
            dist = Distance(node.origin, other_node.origin);
            within_close_dist = dist < close_dist;
            force_connection = false;
            if(!within_close_dist) {
              if(isDefined(level.aerial_pathnodes_force_connect)) {
                foreach(override in level.aerial_pathnodes_force_connect) {
                  radius_sq = squared(override.radius);
                  if(Distance2DSquared(override.origin, node.origin) < radius_sq && Distance2DSquared(override.origin, other_node.origin) < radius_sq) {
                    force_connection = true;
                    break;
                  }
                }
              }
            }
            room_in_array = potential_neighbors_node_in_i_to_group_j.size < max_group_connections || dist < potential_neighbors_node_in_i_to_group_j[max_group_connections - 1][2];
            if(within_close_dist && room_in_array) {
              if(potential_neighbors_node_in_i_to_group_j.size == max_group_connections) {
                potential_neighbors_node_in_i_to_group_j[max_group_connections - 1] = undefined;
              }

              potential_neighbors_node_in_i_to_group_j[potential_neighbors_node_in_i_to_group_j.size] = [node, other_node, dist];
              potential_neighbors_node_in_i_to_group_j = array_sort_with_func(potential_neighbors_node_in_i_to_group_j, ::is_pair_a_closer_than_pair_b);
            } else if(force_connection) {
              potential_aerial_neighbor_nodes[i][j][potential_aerial_neighbor_nodes[i][j].size] = [node, other_node, -1];
            }
          }

          foreach(node_pair in potential_neighbors_node_in_i_to_group_j) {
            potential_aerial_neighbor_nodes[i][j][potential_aerial_neighbor_nodes[i][j].size] = node_pair;
          }
        }

        aerial_nodes_processed++;
        if(aerial_nodes_processed >= 50) {
          aerial_nodes_processed = 0;
          wait(0.05);
        }
      }
    }

    wait(0.05);
    num_sorted = 0;
    for(i = 0; i < node_groups.size; i++) {
      for(j = i + 1; j < node_groups.size; j++) {
        num_sorted += potential_aerial_neighbor_nodes[i][j].size;
        potential_aerial_neighbor_nodes[i][j] = array_sort_with_func(potential_aerial_neighbor_nodes[i][j], ::is_pair_a_closer_than_pair_b, 150);

        if(num_sorted > 500) {
          wait(0.05);
          num_sorted = 0;
        }
      }
    }
    wait(0.05);

    aerial_offset = get_aerial_offset();
    increment = 10;
    num_traces = 0;
    if(SCR_CONST_DEBUG_SHOW_ADDED_LINKS) {
      level.added_aerial_links = [];
    }

    for(i = 0; i < node_groups.size; i++) {
      for(j = i + 1; j < node_groups.size; j++) {
        foreach(pair in potential_aerial_neighbor_nodes[i][j]) {
          node0 = pair[0];
          node1 = pair[1];

          if(!node0_has_neighbor_connected_to_node1(node0, node1)) {
            connections_0_to_group_1 = num_node_connections_to_group(node0, node1.aerial_group);
            connections_1_to_group_0 = num_node_connections_to_group(node1, node0.aerial_group);
            if(connections_0_to_group_1 < max_group_connections && connections_1_to_group_0 < max_group_connections) {
              hitPos = PlayerPhysicsTrace(node0.origin + aerial_offset, node1.origin + aerial_offset);
              num_traces++;
              trace_succeeded = DistanceSquared(hitPos, node1.origin + aerial_offset) < 1;
              if(!trace_succeeded && pair[2] == -1) {
                trace_succeeded = BulletTracePassed(node0.origin + aerial_offset, node1.origin + aerial_offset, false, undefined);
              }

              if(trace_succeeded) {
                Assert(!array_contains(node0.aerial_neighbors, node1));
                node0.aerial_neighbors[node0.aerial_neighbors.size] = node1;

                Assert(!array_contains(node1.aerial_neighbors, node0));
                node1.aerial_neighbors[node1.aerial_neighbors.size] = node0;

                if(SCR_CONST_DEBUG_SHOW_ADDED_LINKS) {
                  level.added_aerial_links[level.added_aerial_links.size] = [node0, node1];
                }
              }

              if((num_traces % increment) == 0) {
                wait(0.05);
              }
            }
          }
        }
      }
    }

    potential_aerial_neighbor_nodes = undefined;

    node_groups = divide_nodes_into_groups(level.aerial_pathnodes);
    if(SCR_CONST_DEBUG_SHOW_NODE_GROUPS) {
      node_groups = array_sort_with_func(node_groups, ::is_group_a_larger_than_group_b);
      for(i = 0; i < node_groups.size; i++) {
        foreach(node in node_groups[i]) {
          node.aerial_group = i;
        }
      }
    } else {
      foreach(node in level.aerial_pathnodes) {
        node.aerial_group = undefined;
      }
    }

    largest_group_size = 0;
    for(i = 0; i < node_groups.size; i++) {
      largest_group_size = max(node_groups[i].size, largest_group_size);
    }

    Assert(level.aerial_pathnodes.size < 40 || largest_group_size > 20);
    for(i = 0; i < node_groups.size; i++) {
      if(node_groups[i].size < 0.1 * largest_group_size) {
        foreach(node in node_groups[i]) {
          level.aerial_pathnodes = array_remove(level.aerial_pathnodes, node);

          foreach(neighbor_node in node.aerial_neighbors) {
            for(j = 0; j < neighbor_node.aerial_neighbors.size; j++) {
              neighbor_node_neighbor = neighbor_node.aerial_neighbors[j];
              if(neighbor_node_neighbor == node) {
                neighbor_node.aerial_neighbors[j] = neighbor_node.aerial_neighbors[neighbor_node.aerial_neighbors.size - 1];
                neighbor_node.aerial_neighbors[neighbor_node.aerial_neighbors.size - 1] = undefined;
                j--;
              }
            }
          }

          node.aerial_neighbors = undefined;
        }
      }
    }
  }

  level.calculated_aerial_nodes_done = true;
  level.calculated_aerial_nodes_in_progress = false;

  thread draw_debug_aerial_nodes();
}

is_group_a_larger_than_group_b(a, b) {
  return (a.size > b.size);
}

is_pair_a_closer_than_pair_b(a, b) {
  return (a[2] < b[2]);
}

num_node_connections_to_group(node0, group_index) {
  connections = 0;
  foreach(neighbor in node0.aerial_neighbors) {
    if(neighbor.aerial_group == group_index) {
      connections++;
    }
  }

  return connections;
}

node0_has_neighbor_connected_to_node1(node0, node1) {
  foreach(neighbor in node0.aerial_neighbors) {
    foreach(neighbor_neighbor in neighbor.aerial_neighbors) {
      if(neighbor_neighbor == node1) {
        return true;
      }
    }
  }

  return false;
}

divide_nodes_into_groups(nodes, ignore_size) {
  if(!isDefined(ignore_size)) {
    ignore_size = 0;
  }

  foreach(node in nodes) {
    node.aerial_group = undefined;
  }

  temp_aerial_nodes = nodes;
  node_groups = [];
  while(temp_aerial_nodes.size > 0) {
    current_index = node_groups.size;
    node_groups[current_index] = [];

    temp_aerial_nodes[0].aerial_group = -1;
    open_nodes = [temp_aerial_nodes[0]];
    open_nodes_processed_for_this_group = 0;
    while(open_nodes.size > 0) {
      current_open_node = open_nodes[0];
      node_groups[current_index][node_groups[current_index].size] = current_open_node;
      Assert(!isDefined(current_open_node.aerial_group) || current_open_node.aerial_group == -1);
      current_open_node.aerial_group = current_index;

      open_nodes[0] = open_nodes[open_nodes.size - 1];
      open_nodes[open_nodes.size - 1] = undefined;

      foreach(neighbor_node in current_open_node.aerial_neighbors) {
        if(!isDefined(neighbor_node.aerial_group)) {
          neighbor_node.aerial_group = -1;
          open_nodes[open_nodes.size] = neighbor_node;
        }
      }

      for(i = 0; i < temp_aerial_nodes.size; i++) {
        if(temp_aerial_nodes[i] == current_open_node) {
          temp_aerial_nodes[i] = temp_aerial_nodes[temp_aerial_nodes.size - 1];
          temp_aerial_nodes[temp_aerial_nodes.size - 1] = undefined;
          break;
        }
      }

      open_nodes_processed_for_this_group++;
      if(open_nodes_processed_for_this_group > 100) {
        wait(0.05);
        open_nodes_processed_for_this_group = 0;
      }
    }

    if(node_groups[current_index].size <= ignore_size) {
      node_groups[current_index] = undefined;
    } else {
      wait(0.05);
    }
  }

  wait(0.05);

  return node_groups;
}

should_draw_for_node(node, max_dist_sq, player_origin, player_angles, player_fov) {
  if(Distance2DSquared(player_origin, node.origin) > max_dist_sq) {
    return false;
  }

  if(!within_fov(player_origin, player_angles, (node.origin + get_aerial_offset()), player_fov)) {
    return false;
  }

  return true;
}

draw_debug_aerial_nodes() {
  self notify("bot_draw_debug_aerial_nodes");
  self endon("bot_draw_debug_aerial_nodes");
  level endon("teleport_to_zone");

  node_colors = [(0, 1, 1), (0, 1, 0), (0, 0, 1), (1, 0, 1), (1, 1, 0), (1, 0, 0), (1, 0.6, 0.6), (0.6, 1, 0.6), (0.6, 0.6, 1), (0.1, 0.1, 0.1)];
  draw_time = 0.5;

  while(1) {
    ai_showNodesAerial = GetDvar("ai_showNodesAerial");
    if(ai_showNodesAerial == "1" || ai_showNodesAerial == "2") {
      max_dist_sq = squared(GetDvarFloat("ai_ShowNodesDist"));
      player = maps\mp\gametypes\_dev::getNotBot();
      aerial_offset = get_aerial_offset();
      if(isDefined(player) && max_dist_sq > 0) {
        if(isDefined(level.aerial_pathnodes_force_connect)) {
          foreach(override in level.aerial_pathnodes_force_connect) {
            maps\mp\bots\_bots_util::bot_draw_cylinder(override.origin - (0, 0, 500), override.radius, 1000, draw_time, undefined, (1, 0, 0), true, 20);
          }
        }

        player_origin = player GetViewOrigin();
        player_angles = player GetPlayerAngles();
        fov = cos(85 * 0.5);

        current_nodes = level.aerial_pathnodes;
        for(i = 0; i < current_nodes.size; i++) {
          if(should_draw_for_node(current_nodes[i], max_dist_sq, player_origin, player_angles, fov)) {
            if(SCR_CONST_DEBUG_SHOW_NODE_GROUPS) {
              color_index = current_nodes[i].aerial_group % 10;
              color = node_colors[color_index];
            } else {
              color = (0, 1, 1);
            }

            if(ai_showNodesAerial == "2") {
              maps\mp\bots\_bots_util::bot_draw_cylinder(current_nodes[i].origin - (0, 0, 5) + aerial_offset, 10, 12, draw_time, undefined, color, true, 4);
            } else {
              foreach(neighbor_node in current_nodes[i].aerial_neighbors) {
                if(array_contains(current_nodes, neighbor_node)) {
                  if(SCR_CONST_DEBUG_SHOW_ADDED_LINKS && !SCR_CONST_DEBUG_DONT_CONNECT_GROUPS) {
                    foreach(node_pair in level.added_aerial_links) {
                      if(node_pair[0] == current_nodes[i] && node_pair[1] == neighbor_node || node_pair[0] == neighbor_node && node_pair[1] == current_nodes[i]) {
                        color = (1, 0, 0);
                        break;
                      }
                    }
                  }

                  line(current_nodes[i].origin + aerial_offset, neighbor_node.origin + aerial_offset, color, 1.0, true, INT(draw_time * 20));
                }
              }
            }

            current_nodes[i] = current_nodes[current_nodes.size - 1];
            current_nodes[current_nodes.size - 1] = undefined;
            i--;
          }
        }
      }
    }

    wait(draw_time);
  }
}

node_is_aerial(node) {
  return isDefined(node.aerial_neighbors);
}

get_ent_closest_aerial_node(max_radius, min_radius) {
  if(!isDefined(max_radius)) {
    max_radius = 1500;
  }
  if(!isDefined(min_radius)) {
    min_radius = 0;
  }

  nodes = GetNodesInRadiusSorted(self.origin, max_radius, min_radius, get_aerial_offset()[2] * 2, "path");
  for(i = 0; i < nodes.size; i++) {
    if(node_is_aerial(nodes[i])) {
      return nodes[i];
    }
  }
}

find_path_between_aerial_nodes(node_start, node_end) {
  Assert(node_is_aerial(node_start));
  Assert(node_is_aerial(node_end));

  node_start.path_to_this_node = [];
  node_queue = [node_start];
  all_nodes_explored = [node_start];

  while(!isDefined(node_end.path_to_this_node)) {
    current_node = node_queue[0];
    node_queue = array_remove(node_queue, current_node);

    foreach(neighbor_node in current_node.aerial_neighbors) {
      if(!isDefined(neighbor_node.path_to_this_node)) {
        neighbor_node.path_to_this_node = array_add(current_node.path_to_this_node, current_node);
        node_queue[node_queue.size] = neighbor_node;
        all_nodes_explored[all_nodes_explored.size] = neighbor_node;
      }
    }
  }

  path = array_add(node_end.path_to_this_node, node_end);
  foreach(node in all_nodes_explored) {
    node.path_to_this_node = undefined;
  }

  return path;
}