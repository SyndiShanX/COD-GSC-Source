/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_utility.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;

init_utility() {}
lerp(chunk) {
  link = spawn("script_origin", self GetOrigin());
  link.angles = self.first_node.angles;
  self LinkTo(link);
  link RotateTo(self.first_node.angles, level._CONTEXTUAL_GRAB_LERP_TIME);
  link moveTo(self.attacking_spot, level._CONTEXTUAL_GRAB_LERP_TIME);
  link waittill_multiple("rotatedone", "movedone");
  self Unlink();
  link Delete();
  return;
}

clear_mature_blood() {
  blood_patch = getEntArray("mature_blood", "targetname");
  if(isDefined(blood_patch) && !is_mature()) {
    for(i = 0; i < blood_patch.size; i++) {
      blood_patch[i] Delete();
    }
  }
}

get_enemy_count() {
  enemies = [];
  valid_enemies = [];
  enemies = GetAiSpeciesArray("axis", "all");
  for(i = 0; i < enemies.size; i++) {
    if(isDefined(enemies[i].animname) && enemies[i].animname != "boss_zombie" && enemies[i].animname != "ape_zombie") {
      valid_enemies = array_add(valid_enemies, enemies[i]);
    }
  }
  return valid_enemies.size;
}

spawn_zombie(spawner, target_name) {
  if(!isDefined(spawner)) {
    return undefined;
  }
  spawner.script_moveoverride = true;
  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
    guy = spawner Stalingradspawn();
  } else {
    guy = spawner Dospawn();
  }
  spawner.count = 666;
  if(!spawn_failed(guy)) {
    if(isDefined(target_name)) {
      guy.targetname = target_name;
    }
    return guy;
  }
  return undefined;
}

create_simple_hud(client) {
  if(isDefined(client)) {
    hud = NewClientHudElem(client);
  } else {
    hud = NewHudElem();
  }
  level.hudelem_count++;
  hud.foreground = true;
  hud.sort = 1;
  hud.hidewheninmenu = false;
  return hud;
}

destroy_hud() {
  level.hudelem_count--;
  self Destroy();
}

all_chunks_intact(barrier_chunks) {
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i] get_chunk_state() != "repaired") {
      return false;
    }
  }
  return true;
}

no_valid_repairable_boards(barrier_chunks) {
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i] get_chunk_state() == "destroyed") {
      return false;
    }
  }
  return true;
}

all_chunks_destroyed(barrier_chunks) {
  ASSERT(isDefined(barrier_chunks), "_zombiemode_utility::all_chunks_destroyed - Barrier chunks undefined");
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i] get_chunk_state() != "destroyed") {
      return false;
    }
  }
  return true;
}

check_point_in_playable_area(origin) {
  playable_area = getentarray("player_volume", "script_noteworthy");
  check_model = spawn("script_model", origin + (0, 0, 40));
  valid_point = false;
  for(i = 0; i < playable_area.size; i++) {
    if(check_model istouching(playable_area[i])) {
      valid_point = true;
    }
  }
  check_model delete();
  return valid_point;
}

check_point_in_active_zone(origin) {
  player_zones = getentarray("player_volume", "script_noteworthy");
  if(!isDefined(level.zones) || !isDefined(player_zones)) {
    return true;
  }
  scr_org = spawn("script_origin", origin + (0, 0, 40));
  one_valid_zone = false;
  for(i = 0; i < player_zones.size; i++) {
    if(scr_org isTouching(player_zones[i])) {
      if(isDefined(level.zones[player_zones[i].targetname]) &&
        isDefined(level.zones[player_zones[i].targetname].is_enabled)) {
        one_valid_zone = true;
      }
    }
  }
  scr_org delete();
  return one_valid_zone;
}

round_up_to_ten(score) {
  new_score = score - score % 10;
  if(new_score < score) {
    new_score += 10;
  }
  return new_score;
}

round_up_score(score, value) {
  score = int(score);
  new_score = score - score % value;
  if(new_score < score) {
    new_score += value;
  }
  return new_score;
}

random_tan() {
  rand = randomInt(100);
  if(isDefined(level.char_percent_override)) {
    percentNotCharred = level.char_percent_override;
  } else {
    percentNotCharred = 65;
  }
}

places_before_decimal(num) {
  abs_num = abs(num);
  count = 0;
  while(1) {
    abs_num *= 0.1;
    count += 1;
    if(abs_num < 1) {
      return count;
    }
  }
}

create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on) {
  if(!isDefined(added_poi_value)) {
    self.added_poi_value = 0;
  } else {
    self.added_poi_value = added_poi_value;
  }
  if(!isDefined(start_turned_on)) {
    start_turned_on = true;
  }
  self.script_noteworthy = "zombie_poi";
  self.poi_active = start_turned_on;
  if(isDefined(attract_dist)) {
    self.poi_radius = attract_dist * attract_dist;
  } else {
    self.poi_radius = undefined;
  }
  self.num_poi_attracts = num_attractors;
  self.attract_to_origin = true;
  self.attractor_array = [];
}

create_zombie_point_of_interest_attractor_positions(num_attract_dists, diff_per_dist, attractor_width) {
  forward = (0, 1, 0);
  if(!isDefined(self.num_poi_attracts) || (isDefined(self.script_noteworthy) && self.script_noteworthy != "zombie_poi")) {
    return;
  }
  if(!isDefined(num_attract_dists)) {
    num_attract_dists = 4;
  }
  if(!isDefined(diff_per_dist)) {
    diff_per_dist = 45;
  }
  if(!isDefined(attractor_width)) {
    attractor_width = 45;
  }
  self.attract_to_origin = false;
  self.num_attract_dists = num_attract_dists;
  self.last_index = [];
  for(i = 0; i < num_attract_dists; i++) {
    self.last_index[i] = -1;
  }
  self.attract_dists = [];
  for(i = 0; i < self.num_attract_dists; i++) {
    self.attract_dists[i] = diff_per_dist * (i + 1);
  }
  max_positions = [];
  for(i = 0; i < self.num_attract_dists; i++) {
    max_positions[i] = int(3.14 * 2 * self.attract_dists[i] / attractor_width);
  }
  num_attracts_per_dist = self.num_poi_attracts / self.num_attract_dists;
  self.max_attractor_dist = self.attract_dists[self.attract_dists.size - 1] * 1.1;
  diff = 0;
  self thread debug_draw_attractor_positions();
  actual_num_positions = [];
  for(i = 0; i < self.num_attract_dists; i++) {
    if(num_attracts_per_dist > (max_positions[i] + diff)) {
      actual_num_positions[i] = max_positions[i];
      diff += num_attracts_per_dist - max_positions[i];
    } else {
      actual_num_positions[i] = num_attracts_per_dist + diff;
      diff = 0;
    }
  }
  self.attractor_positions = [];
  failed = 0;
  angle_offset = 0;
  prev_last_index = -1;
  for(j = 0; j < 4; j++) {
    if((actual_num_positions[j] + failed) < max_positions[j]) {
      actual_num_positions[j] += failed;
      failed = 0;
    } else if(actual_num_positions[j] < max_positions[j]) {
      actual_num_positions[j] = max_positions[j];
      failed = max_positions[j] - actual_num_positions[j];
    }
    failed += self generated_radius_attract_positions(forward, angle_offset, actual_num_positions[j], self.attract_dists[j]);
    angle_offset += 15;
    self.last_index[j] = int(actual_num_positions[j] - failed + prev_last_index);
    prev_last_index = self.last_index[j];
  }
  self notify("attractor_positions_generated");
  level notify("attractor_positions_generated");
}

generated_radius_attract_positions(forward, offset, num_positions, attract_radius) {
  failed = 0;
  degs_per_pos = 360 / num_positions;
  for(i = offset; i < 360 + offset; i += degs_per_pos) {
    altforward = forward * attract_radius;
    rotated_forward = ((cos(i) * altforward[0] - sin(i) * altforward[1]), (sin(i) * altforward[0] + cos(i) * altforward[1]), altforward[2]);
    pos = maps\_zombiemode_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 100));
    if(abs(pos[2] - self.origin[2]) < 60) {
      pos_array = [];
      pos_array[0] = pos;
      pos_array[1] = self;
      self.attractor_positions = array_add(self.attractor_positions, pos_array);
    } else {
      failed++;
    }
  }
  return failed;
}

debug_draw_attractor_positions() {}
get_zombie_point_of_interest(origin) {
  curr_radius = undefined;
  ent_array = getEntArray("zombie_poi", "script_noteworthy");
  best_poi = undefined;
  position = undefined;
  best_dist = 10000 * 10000;
  for(i = 0; i < ent_array.size; i++) {
    if(!isDefined(ent_array[i].poi_active) || !ent_array[i].poi_active) {
      continue;
    }
    dist = distanceSquared(origin, ent_array[i].origin);
    dist -= ent_array[i].added_poi_value;
    if(isDefined(ent_array[i].poi_radius)) {
      curr_radius = ent_array[i].poi_radius;
    }
    if((!isDefined(curr_radius) || dist < curr_radius) && dist < best_dist && ent_array[i] can_attract(self)) {
      best_poi = ent_array[i];
      best_dist = dist;
    }
  }
  if(isDefined(best_poi)) {
    if(isDefined(best_poi.attract_to_origin) && best_poi.attract_to_origin) {
      position = [];
      position[0] = groundpos(best_poi.origin + (0, 0, 100));
      position[1] = self;
    } else {
      position = self add_poi_attractor(best_poi);
    }
  }
  return position;
}

activate_zombie_point_of_interest() {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }
  self.poi_active = true;
}

deactivate_zombie_point_of_interest() {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }
  for(i = 0; i < self.attractor_array.size; i++) {
    self.attractor_array[i] notify("kill_poi");
  }
  self.attractor_array = [];
  self.claimed_attractor_positions = [];
  self.poi_active = false;
}

assign_zombie_point_of_interest(origin, poi) {
  position = undefined;
  doremovalthread = false;
  if(isDefined(poi) && poi can_attract(self)) {
    if(!isDefined(poi.attractor_array) || (isDefined(poi.attractor_array) && array_check_for_dupes(poi.attractor_array, self)))
      doremovalthread = true;
    position = self add_poi_attractor(poi);
    if(isDefined(position) && doremovalthread && !array_check_for_dupes(poi.attractor_array, self))
      self thread update_on_poi_removal(poi);
  }
  return position;
}

remove_poi_attractor(zombie_poi) {
  if(!isDefined(zombie_poi.attractor_array)) {
    return;
  }
  for(i = 0; i < zombie_poi.attractor_array.size; i++) {
    if(zombie_poi.attractor_array[i] == self) {
      self notify("kill_poi");
      zombie_poi.attractor_array = array_remove(zombie_poi.attractor_array, zombie_poi.attractor_array[i]);
      zombie_poi.claimed_attractor_positions = array_remove(zombie_poi.claimed_attractor_positions, zombie_poi.claimed_attractor_positions[i]);
    }
  }
}

add_poi_attractor(zombie_poi) {
  if(!isDefined(zombie_poi)) {
    return;
  }
  if(!isDefined(zombie_poi.attractor_array)) {
    zombie_poi.attractor_array = [];
  }
  if(array_check_for_dupes(zombie_poi.attractor_array, self)) {
    if(!isDefined(zombie_poi.claimed_attractor_positions)) {
      zombie_poi.claimed_attractor_positions = [];
    }
    if(!isDefined(zombie_poi.attractor_positions) || zombie_poi.attractor_positions.size <= 0) {
      return undefined;
    }
    start = -1;
    end = -1;
    last_index = -1;
    for(i = 0; i < 4; i++) {
      if(zombie_poi.claimed_attractor_positions.size < zombie_poi.last_index[i]) {
        start = last_index + 1;
        end = zombie_poi.last_index[i];
        break;
      }
      last_index = zombie_poi.last_index[i];
    }
    best_dist = 10000 * 10000;
    best_pos = undefined;
    if(start < 0) {
      start = 0;
    }
    if(end < 0) {
      return undefined;
    }
    for(i = int(start); i <= int(end); i++) {
      if(array_check_for_dupes(zombie_poi.claimed_attractor_positions, zombie_poi.attractor_positions[i])) {
        if(isDefined(zombie_poi.attractor_positions[i][0]) && isDefined(self.origin)) {
          dist = distancesquared(zombie_poi.attractor_positions[i][0], self.origin);
          if(dist < best_dist || !isDefined(best_pos)) {
            best_dist = dist;
            best_pos = zombie_poi.attractor_positions[i];
          }
        }
      }
    }
    if(!isDefined(best_pos)) {
      return undefined;
    }
    zombie_poi.attractor_array = array_add(zombie_poi.attractor_array, self);
    self thread update_poi_on_death(zombie_poi);
    zombie_poi.claimed_attractor_positions = array_add(zombie_poi.claimed_attractor_positions, best_pos);
    return best_pos;
  } else {
    for(i = 0; i < zombie_poi.attractor_array.size; i++) {
      if(zombie_poi.attractor_array[i] == self) {
        if(isDefined(zombie_poi.claimed_attractor_positions) && isDefined(zombie_poi.claimed_attractor_positions[i])) {
          return zombie_poi.claimed_attractor_positions[i];
        }
      }
    }
  }
  return undefined;
}

can_attract(attractor) {
  if(!isDefined(self.attractor_array)) {
    self.attractor_array = [];
  }
  if(!array_check_for_dupes(self.attractor_array, attractor)) {
    return true;
  }
  if(isDefined(self.num_poi_attracts) && self.attractor_array.size >= self.num_poi_attracts) {
    return false;
  }
  return true;
}

update_poi_on_death(zombie_poi) {
  self endon("kill_poi");
  self waittill("death");
  self remove_poi_attractor(zombie_poi);
}

update_on_poi_removal(zombie_poi) {
  zombie_poi waittill("death");
  if(!isDefined(zombie_poi.attractor_array))
    return;
  for(i = 0; i < zombie_poi.attractor_array.size; i++) {
    if(zombie_poi.attractor_array[i] == self) {
      zombie_poi.attractor_array = array_remove_index(zombie_poi.attractor_array, i);
      zombie_poi.claimed_attractor_positions = array_remove_index(zombie_poi.claimed_attractor_positions, i);
    }
  }
}

invalidate_attractor_pos(attractor_pos, zombie) {
  if(!isDefined(self) || !isDefined(attractor_pos)) {
    wait(0.1);
    return undefined;
  }
  if(isDefined(self.attractor_positions) && !array_check_for_dupes(self.attractor_positions, attractor_pos)) {
    index = 0;
    for(i = 0; i < self.attractor_positions.size; i++) {
      if(self.attractor_positions[i] == attractor_pos) {
        index = i;
      }
    }
    for(i = 0; i < self.last_index.size; i++) {
      if(index <= self.last_index[i]) {
        self.last_index[i]--;
      }
    }
    self.attractor_array = array_remove(self.attractor_array, zombie);
    self.attractor_positions = array_remove(self.attractor_positions, attractor_pos);
    for(i = 0; i < self.claimed_attractor_positions.size; i++) {
      if(self.claimed_attractor_positions[i][0] == attractor_pos[0]) {
        self.claimed_attractor_positions = array_remove(self.claimed_attractor_positions, self.claimed_attractor_positions[i]);
      }
    }
  } else {
    wait(0.1);
  }
  return get_zombie_point_of_interest(zombie.origin);
}

get_closest_valid_player(origin, ignore_player) {
  valid_player_found = false;
  players = get_players();
  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      players = array_remove(players, ignore_player[i]);
    }
  }
  while(!valid_player_found) {
    player = GetClosest(origin, players);
    if(!isDefined(player)) {
      return undefined;
    }
    if(!is_player_valid(player, true)) {
      players = array_remove(players, player);
      continue;
    }
    return player;
  }
}

is_player_valid(player, checkIgnoreMeFlag) {
  if(!isDefined(player)) {
    return false;
  }
  if(!IsAlive(player)) {
    return false;
  }
  if(!IsPlayer(player)) {
    return false;
  }
  if(player.is_zombie == true) {
    return false;
  }
  if(player.sessionstate == "spectator") {
    return false;
  }
  if(player.sessionstate == "intermission") {
    return false;
  }
  if(player maps\_laststand::player_is_in_laststand()) {
    return false;
  }
  if(player isnotarget()) {
    return false;
  }
  if(isDefined(checkIgnoreMeFlag) && player.ignoreme) {
    return false;
  }
  return true;
}

get_number_of_valid_players() {
  players = get_players();
  num_player_valid = 0;
  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i]))
      num_player_valid += 1;
  }
  return num_player_valid;
}

in_revive_trigger() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i]) || !IsAlive(players[i])) {
      continue;
    }
    if(isDefined(players[i].revivetrigger)) {
      if(self IsTouching(players[i].revivetrigger)) {
        return true;
      }
    }
  }
  return false;
}

get_closest_node(org, nodes) {
  return getClosest(org, nodes);
}

non_destroyed_bar_board_order(origin, chunks) {
  first_bars = [];
  first_bars1 = [];
  first_bars2 = [];
  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && (chunks[i].script_team == "classic_boards")) {
      if(isDefined(chunks[i].script_parameters) && (chunks[i].script_parameters == "board")) {
        return get_closest_2d(origin, chunks);
      } else if(isDefined(chunks[i].script_team) && chunks[i].script_team == "bar_board_variant1" || chunks[i].script_team == "bar_board_variant2" ||
        chunks[i].script_team == "bar_board_variant4" || chunks[i].script_team == "bar_board_variant5") {
        return undefined;
      }
    } else if(isDefined(chunks[i].script_team) && chunks[i].script_team == "new_barricade") {
      if(isDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "repair_board") {
        return get_closest_2d(origin, chunks);
      }
    }
  }
  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && (chunks[i].script_team == "6_bars_bent") || (chunks[i].script_team == "6_bars_prestine")) {
      if(isDefined(chunks[i].script_parameters) && (chunks[i].script_parameters == "bar")) {
        if(isDefined(chunks[i].script_noteworthy)) {
          if(chunks[i].script_noteworthy == "4" || chunks[i].script_noteworthy == "6") {
            first_bars[first_bars.size] = chunks[i];
          }
        }
      }
    }
  }
  for(i = 0; i < first_bars.size; i++) {
    if(isDefined(chunks[i].script_team) && (chunks[i].script_team == "6_bars_bent") || (chunks[i].script_team == "6_bars_prestine")) {
      if(isDefined(chunks[i].script_parameters) && (chunks[i].script_parameters == "bar")) {
        if(!first_bars[i].destroyed) {
          return first_bars[i];
        }
      }
    }
  }
  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && (chunks[i].script_team == "6_bars_bent") || (chunks[i].script_team == "6_bars_prestine")) {
      if(isDefined(chunks[i].script_parameters) && (chunks[i].script_parameters == "bar")) {
        if(!chunks[i].destroyed) {
          return get_closest_2d(origin, chunks);
        }
      }
    }
  }
}

non_destroyed_grate_order(origin, chunks_grate) {
  grate_order = [];
  grate_order1 = [];
  grate_order2 = [];
  grate_order3 = [];
  grate_order4 = [];
  grate_order5 = [];
  grate_order6 = [];
  if(isDefined(chunks_grate)) {
    for(i = 0; i < chunks_grate.size; i++) {
      if(isDefined(chunks_grate[i].script_parameters) && (chunks_grate[i].script_parameters == "grate")) {
        if(isDefined(chunks_grate[i].script_noteworthy) && (chunks_grate[i].script_noteworthy == "1")) {
          grate_order1[grate_order1.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && (chunks_grate[i].script_noteworthy == "2")) {
          grate_order2[grate_order2.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && (chunks_grate[i].script_noteworthy == "3")) {
          grate_order3[grate_order3.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && (chunks_grate[i].script_noteworthy == "4")) {
          grate_order4[grate_order4.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && (chunks_grate[i].script_noteworthy == "5")) {
          grate_order5[grate_order5.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && (chunks_grate[i].script_noteworthy == "6")) {
          grate_order6[grate_order6.size] = chunks_grate[i];
        }
      }
    }
    for(i = 0; i < chunks_grate.size; i++) {
      if(isDefined(chunks_grate[i].script_parameters) && (chunks_grate[i].script_parameters == "grate")) {
        if(isDefined(grate_order1[i])) {
          if((grate_order1[i].state == "repaired")) {
            grate_order2[i] thread show_grate_pull();
            return grate_order1[i];
          }
          if((grate_order2[i].state == "repaired")) {
            grate_order3[i] thread show_grate_pull();
            return grate_order2[i];
          } else if((grate_order3[i].state == "repaired")) {
            grate_order4[i] thread show_grate_pull();
            return grate_order3[i];
          } else if((grate_order4[i].state == "repaired")) {
            grate_order5[i] thread show_grate_pull();
            return grate_order4[i];
          } else if((grate_order5[i].state == "repaired")) {
            grate_order6[i] thread show_grate_pull();
            return grate_order5[i];
          } else if((grate_order6[i].state == "repaired")) {
            return grate_order6[i];
          }
        }
      }
    }
  }
}

non_destroyed_variant1_order(origin, chunks_variant1) {
  variant1_order = [];
  variant1_order1 = [];
  variant1_order2 = [];
  variant1_order3 = [];
  variant1_order4 = [];
  variant1_order5 = [];
  variant1_order6 = [];
  if(isDefined(chunks_variant1)) {
    for(i = 0; i < chunks_variant1.size; i++) {
      if(isDefined(chunks_variant1[i].script_team) && (chunks_variant1[i].script_team == "bar_board_variant1")) {
        if(isDefined(chunks_variant1[i].script_noteworthy)) {
          if(chunks_variant1[i].script_noteworthy == "1") {
            variant1_order1[variant1_order1.size] = chunks_variant1[i];
          }
          if(chunks_variant1[i].script_noteworthy == "2") {
            variant1_order2[variant1_order2.size] = chunks_variant1[i];
          }
          if(chunks_variant1[i].script_noteworthy == "3") {
            variant1_order3[variant1_order3.size] = chunks_variant1[i];
          }
          if(chunks_variant1[i].script_noteworthy == "4") {
            variant1_order4[variant1_order4.size] = chunks_variant1[i];
          }
          if(chunks_variant1[i].script_noteworthy == "5") {
            variant1_order5[variant1_order5.size] = chunks_variant1[i];
          }
          if(chunks_variant1[i].script_noteworthy == "6") {
            variant1_order6[variant1_order6.size] = chunks_variant1[i];
          }
        }
      }
    }
    for(i = 0; i < chunks_variant1.size; i++) {
      if(isDefined(chunks_variant1[i].script_team) && (chunks_variant1[i].script_team == "bar_board_variant1")) {
        if(isDefined(variant1_order2[i])) {
          if((variant1_order2[i].state == "repaired")) {
            return variant1_order2[i];
          } else if((variant1_order3[i].state == "repaired")) {
            return variant1_order3[i];
          } else if((variant1_order4[i].state == "repaired")) {
            return variant1_order4[i];
          } else if((variant1_order6[i].state == "repaired")) {
            return variant1_order6[i];
          } else if((variant1_order5[i].state == "repaired")) {
            return variant1_order5[i];
          } else if((variant1_order1[i].state == "repaired")) {
            return variant1_order1[i];
          }
        }
      }
    }
  }
}

non_destroyed_variant2_order(origin, chunks_variant2) {
  variant2_order = [];
  variant2_order1 = [];
  variant2_order2 = [];
  variant2_order3 = [];
  variant2_order4 = [];
  variant2_order5 = [];
  variant2_order6 = [];
  if(isDefined(chunks_variant2)) {
    for(i = 0; i < chunks_variant2.size; i++) {
      if(isDefined(chunks_variant2[i].script_team) && (chunks_variant2[i].script_team == "bar_board_variant2")) {
        if(isDefined(chunks_variant2[i].script_noteworthy) && (chunks_variant2[i].script_noteworthy == "1")) {
          variant2_order1[variant2_order1.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && (chunks_variant2[i].script_noteworthy == "2")) {
          variant2_order2[variant2_order2.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && (chunks_variant2[i].script_noteworthy == "3")) {
          variant2_order3[variant2_order3.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && (chunks_variant2[i].script_noteworthy == "4")) {
          variant2_order4[variant2_order4.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && (chunks_variant2[i].script_noteworthy == "5") && isDefined(chunks_variant2[i].script_location) && (chunks_variant2[i].script_location == "5")) {
          variant2_order5[variant2_order5.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && (chunks_variant2[i].script_noteworthy == "5") && isDefined(chunks_variant2[i].script_location) && (chunks_variant2[i].script_location == "6")) {
          variant2_order6[variant2_order6.size] = chunks_variant2[i];
        }
      }
    }
    for(i = 0; i < chunks_variant2.size; i++) {
      if(isDefined(chunks_variant2[i].script_team) && (chunks_variant2[i].script_team == "bar_board_variant2")) {
        if(isDefined(variant2_order1[i])) {
          if((variant2_order1[i].state == "repaired")) {
            return variant2_order1[i];
          } else if((variant2_order2[i].state == "repaired")) {
            return variant2_order2[i];
          } else if((variant2_order3[i].state == "repaired")) {
            return variant2_order3[i];
          } else if((variant2_order5[i].state == "repaired")) {
            return variant2_order5[i];
          } else if((variant2_order4[i].state == "repaired")) {
            return variant2_order4[i];
          } else if((variant2_order6[i].state == "repaired")) {
            return variant2_order6[i];
          }
        }
      }
    }
  }
}

non_destroyed_variant4_order(origin, chunks_variant4) {
  variant4_order = [];
  variant4_order1 = [];
  variant4_order2 = [];
  variant4_order3 = [];
  variant4_order4 = [];
  variant4_order5 = [];
  variant4_order6 = [];
  if(isDefined(chunks_variant4)) {
    for(i = 0; i < chunks_variant4.size; i++) {
      if(isDefined(chunks_variant4[i].script_team) && (chunks_variant4[i].script_team == "bar_board_variant4")) {
        if(isDefined(chunks_variant4[i].script_noteworthy) && (chunks_variant4[i].script_noteworthy == "1") && !isDefined(chunks_variant4[i].script_location)) {
          variant4_order1[variant4_order1.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && (chunks_variant4[i].script_noteworthy == "2")) {
          variant4_order2[variant4_order2.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && (chunks_variant4[i].script_noteworthy == "3")) {
          variant4_order3[variant4_order3.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && (chunks_variant4[i].script_noteworthy == "1") && isDefined(chunks_variant4[i].script_location) && (chunks_variant4[i].script_location == "3")) {
          variant4_order4[variant4_order4.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && (chunks_variant4[i].script_noteworthy == "5")) {
          variant4_order5[variant4_order5.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && (chunks_variant4[i].script_noteworthy == "6")) {
          variant4_order6[variant4_order6.size] = chunks_variant4[i];
        }
      }
    }
    for(i = 0; i < chunks_variant4.size; i++) {
      if(isDefined(chunks_variant4[i].script_team) && (chunks_variant4[i].script_team == "bar_board_variant4")) {
        if(isDefined(variant4_order1[i])) {
          if((variant4_order1[i].state == "repaired")) {
            return variant4_order1[i];
          } else if((variant4_order6[i].state == "repaired")) {
            return variant4_order6[i];
          } else if((variant4_order3[i].state == "repaired")) {
            return variant4_order3[i];
          } else if((variant4_order4[i].state == "repaired")) {
            return variant4_order4[i];
          } else if((variant4_order2[i].state == "repaired")) {
            return variant4_order2[i];
          } else if((variant4_order5[i].state == "repaired")) {
            return variant4_order5[i];
          }
        }
      }
    }
  }
}

non_destroyed_variant5_order(origin, chunks_variant5) {
  variant5_order = [];
  variant5_order1 = [];
  variant5_order2 = [];
  variant5_order3 = [];
  variant5_order4 = [];
  variant5_order5 = [];
  variant5_order6 = [];
  if(isDefined(chunks_variant5)) {
    for(i = 0; i < chunks_variant5.size; i++) {
      if(isDefined(chunks_variant5[i].script_team) && (chunks_variant5[i].script_team == "bar_board_variant5")) {
        if(isDefined(chunks_variant5[i].script_noteworthy)) {
          if((chunks_variant5[i].script_noteworthy == "1") && !isDefined(chunks_variant5[i].script_location)) {
            variant5_order1[variant5_order1.size] = chunks_variant5[i];
          }
          if(chunks_variant5[i].script_noteworthy == "2") {
            variant5_order2[variant5_order2.size] = chunks_variant5[i];
          }
          if(isDefined(chunks_variant5[i].script_noteworthy) && (chunks_variant5[i].script_noteworthy == "1") && isDefined(chunks_variant5[i].script_location) && (chunks_variant5[i].script_location == "3")) {
            variant5_order3[variant5_order3.size] = chunks_variant5[i];
          }
          if(chunks_variant5[i].script_noteworthy == "4") {
            variant5_order4[variant5_order4.size] = chunks_variant5[i];
          }
          if(chunks_variant5[i].script_noteworthy == "5") {
            variant5_order5[variant5_order5.size] = chunks_variant5[i];
          }
          if(chunks_variant5[i].script_noteworthy == "6") {
            variant5_order6[variant5_order6.size] = chunks_variant5[i];
          }
        }
      }
    }
    for(i = 0; i < chunks_variant5.size; i++) {
      if(isDefined(chunks_variant5[i].script_team) && (chunks_variant5[i].script_team == "bar_board_variant5")) {
        if(isDefined(variant5_order1[i])) {
          if((variant5_order1[i].state == "repaired")) {
            return variant5_order1[i];
          } else if((variant5_order6[i].state == "repaired")) {
            return variant5_order6[i];
          } else if((variant5_order3[i].state == "repaired")) {
            return variant5_order3[i];
          } else if((variant5_order2[i].state == "repaired")) {
            return variant5_order2[i];
          } else if((variant5_order5[i].state == "repaired")) {
            return variant5_order5[i];
          } else if((variant5_order4[i].state == "repaired")) {
            return variant5_order4[i];
          }
        }
      }
    }
  }
}

show_grate_pull() {
  wait(0.53);
  self Show();
  self vibrate((0, 270, 0), 0.2, 0.4, 0.4);
}

get_closest_2d(origin, ents) {
  if(!isDefined(ents)) {
    return undefined;
  }
  dist = Distance2d(origin, ents[0].origin);
  index = 0;
  temp_array = [];
  for(i = 1; i < ents.size; i++) {
    if(isDefined(ents[i].unbroken) && ents[i].unbroken == true) {
      ents[i].index = i;
      temp_array = array_add(temp_array, ents[i]);
    }
  }
  if(temp_array.size > 0) {
    index = temp_array[RandomIntRange(0, temp_array.size)].index;
    return ents[index];
  } else {
    for(i = 1; i < ents.size; i++) {
      temp_dist = Distance2d(origin, ents[i].origin);
      if(temp_dist < dist) {
        dist = temp_dist;
        index = i;
      }
    }
    return ents[index];
  }
}

disable_trigger() {
  if(!isDefined(self.disabled) || !self.disabled) {
    self.disabled = true;
    self.origin = self.origin - (0, 0, 10000);
  }
}

enable_trigger() {
  if(!isDefined(self.disabled) || !self.disabled) {
    return;
  }
  self.disabled = false;
  self.origin = self.origin + (0, 0, 10000);
}

in_playable_area() {
  playable_area = getentarray("player_volume", "script_noteworthy");
  if(!isDefined(playable_area)) {
    println("No playable area playable_area found! Assume EVERYWHERE is PLAYABLE");
    return true;
  }
  for(i = 0; i < playable_area.size; i++) {
    if(self IsTouching(playable_area[i])) {
      return true;
    }
  }
  return false;
}

get_closest_non_destroyed_chunk(origin, barrier_chunks) {
  chunks = undefined;
  chunks_grate = undefined;
  chunks_variant1 = undefined;
  chunks_variant2 = undefined;
  chunks_variant4 = undefined;
  chunks_variant5 = undefined;
  chunks_grate = get_non_destroyed_chunks_grate(barrier_chunks);
  chunks = get_non_destroyed_chunks(barrier_chunks);
  chunks_variant1 = get_non_destroyed_variant1(barrier_chunks);
  chunks_variant2 = get_non_destroyed_variant2(barrier_chunks);
  chunks_variant4 = get_non_destroyed_variant4(barrier_chunks);
  chunks_variant5 = get_non_destroyed_variant5(barrier_chunks);
  if(isDefined(chunks)) {
    return non_destroyed_bar_board_order(origin, chunks);
  } else if(isDefined(chunks_grate)) {
    return non_destroyed_grate_order(origin, chunks_grate);
  } else if(isDefined(chunks_variant1)) {
    return non_destroyed_variant1_order(origin, chunks_variant1);
  } else if(isDefined(chunks_variant2)) {
    return non_destroyed_variant2_order(origin, chunks_variant2);
  } else if(isDefined(chunks_variant4)) {
    return non_destroyed_variant4_order(origin, chunks_variant4);
  } else if(isDefined(chunks_variant5)) {
    return non_destroyed_variant5_order(origin, chunks_variant5);
  }
  return undefined;
}

get_random_destroyed_chunk(barrier_chunks) {
  chunk = undefined;
  chunks_repair_grate = undefined;
  chunks = get_destroyed_chunks(barrier_chunks);
  chunks_repair_grate = get_destroyed_repair_grates(barrier_chunks);
  if(isDefined(chunks)) {
    return chunks[randomInt(chunks.size)];
  } else if(isDefined(chunks_repair_grate)) {
    return grate_order_destroyed(chunks_repair_grate);
  }
  return undefined;
}

get_destroyed_repair_grates(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i])) {
      if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "grate")) {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_non_destroyed_chunks(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "classic_boards")) {
      if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "board")) {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
    }
    if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "new_barricade")) {
      if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "repair_board")) {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
    } else if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "6_bars_bent")) {
      if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "bar")) {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
    } else if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "6_bars_prestine")) {
      if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "bar")) {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_non_destroyed_chunks_grate(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "grate")) {
      if(isDefined(barrier_chunks[i])) {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_non_destroyed_variant1(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "bar_board_variant1")) {
      if(isDefined(barrier_chunks[i])) {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_non_destroyed_variant2(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "bar_board_variant2")) {
      if(isDefined(barrier_chunks[i])) {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_non_destroyed_variant4(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "bar_board_variant4")) {
      if(isDefined(barrier_chunks[i])) {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_non_destroyed_variant5(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && (barrier_chunks[i].script_team == "bar_board_variant5")) {
      if(isDefined(barrier_chunks[i])) {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_destroyed_chunks(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i] get_chunk_state() == "destroyed") {
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board") {
        array[array.size] = barrier_chunks[i];
      } else if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "repair_board") {
        array[array.size] = barrier_chunks[i];
      } else if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "bar")) {
        array[array.size] = barrier_chunks[i];
      } else if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "grate")) {
        return undefined;
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

grate_order_destroyed(chunks_repair_grate) {
  grate_repair_order = [];
  grate_repair_order1 = [];
  grate_repair_order2 = [];
  grate_repair_order3 = [];
  grate_repair_order4 = [];
  grate_repair_order5 = [];
  grate_repair_order6 = [];
  for(i = 0; i < chunks_repair_grate.size; i++) {
    if(isDefined(chunks_repair_grate[i].script_parameters) && (chunks_repair_grate[i].script_parameters == "grate")) {
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && (chunks_repair_grate[i].script_noteworthy == "1")) {
        grate_repair_order1[grate_repair_order1.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && (chunks_repair_grate[i].script_noteworthy == "2")) {
        grate_repair_order2[grate_repair_order2.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && (chunks_repair_grate[i].script_noteworthy == "3")) {
        grate_repair_order3[grate_repair_order3.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && (chunks_repair_grate[i].script_noteworthy == "4")) {
        grate_repair_order4[grate_repair_order4.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && (chunks_repair_grate[i].script_noteworthy == "5")) {
        grate_repair_order5[grate_repair_order5.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && (chunks_repair_grate[i].script_noteworthy == "6")) {
        grate_repair_order6[grate_repair_order6.size] = chunks_repair_grate[i];
      }
    }
  }
  for(i = 0; i < chunks_repair_grate.size; i++) {
    if(isDefined(chunks_repair_grate[i].script_parameters) && (chunks_repair_grate[i].script_parameters == "grate")) {
      if(isDefined(grate_repair_order1[i])) {
        if((grate_repair_order6[i].state == "destroyed")) {
          return grate_repair_order6[i];
        }
        if((grate_repair_order5[i].state == "destroyed")) {
          grate_repair_order6[i] thread show_grate_repair();
          return grate_repair_order5[i];
        } else if((grate_repair_order4[i].state == "destroyed")) {
          grate_repair_order5[i] thread show_grate_repair();
          return grate_repair_order4[i];
        } else if((grate_repair_order3[i].state == "destroyed")) {
          grate_repair_order4[i] thread show_grate_repair();
          return grate_repair_order3[i];
        } else if((grate_repair_order2[i].state == "destroyed")) {
          grate_repair_order3[i] thread show_grate_repair();
          return grate_repair_order2[i];
        } else if((grate_repair_order1[i].state == "destroyed")) {
          grate_repair_order2[i] thread show_grate_repair();
          return grate_repair_order1[i];
        }
      }
    }
  }
}

show_grate_repair() {
  wait(0.34);
  self hide();
}

get_chunk_state() {
  assertex(isDefined(self.state));
  return self.state;
}

is_float(num) {
  val = num - int(num);
  if(val != 0) {
    return true;
  } else {
    return false;
  }
}

array_limiter(array, total) {
  new_array = [];
  for(i = 0; i < array.size; i++) {
    if(i < total) {
      new_array[new_array.size] = array[i];
    }
  }
  return new_array;
}

array_validate(array) {
  if(isDefined(array) && array.size > 0) {
    return true;
  } else {
    return false;
  }
}

add_spawner(spawner) {
  if(isDefined(spawner.script_start) && level.round_number < spawner.script_start) {
    return;
  }
  if(isDefined(spawner.is_enabled) && !spawner.is_enabled) {
    return;
  }
  if(isDefined(spawner.has_been_added) && spawner.has_been_added) {
    return;
  }
  spawner.has_been_added = true;
  level.enemy_spawns[level.enemy_spawns.size] = spawner;
}

fake_physicslaunch(target_pos, power) {
  start_pos = self.origin;
  gravity = GetDvarInt(#"bg_gravity") * -1;
  dist = Distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * (time * time);
  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);
  level thread draw_line_ent_to_pos(self, target_pos);
  self MoveGravity(velocity, time);
  return time;
}

add_to_spectate_list() {
  if(!isDefined(level.spectate_list)) {
    level.spectate_list = [];
  }
  level.spectate_list[level.spectate_list.size] = self;
}

remove_from_spectate_list() {
  if(!isDefined(level.spectate_list)) {
    return undefined;
  }
  level.spectate_list = array_remove(level.spectate_list, self);
}

get_next_from_spectate_list(ent) {
  index = 0;
  for(i = 0; i < level.spectate_list.size; i++) {
    if(ent == level.spectate_list[i]) {
      index = i;
    }
  }
  index++;
  if(index >= level.spectate_list.size) {
    index = 0;
  }
  return level.spectate_list[index];
}

get_random_from_spectate_list() {
  return level.spectate_list[randomInt(level.spectate_list.size)];
}

add_zombie_hint(ref, text) {
  if(!isDefined(level.zombie_hints)) {
    level.zombie_hints = [];
  }
  PrecacheString(text);
  level.zombie_hints[ref] = text;
}

get_zombie_hint(ref) {
  if(isDefined(level.zombie_hints[ref])) {
    return level.zombie_hints[ref];
  }
  return level.zombie_hints["undefined"];
}

set_hint_string(ent, default_ref) {
  if(isDefined(ent.script_hint)) {
    self SetHintString(get_zombie_hint(ent.script_hint));
  } else {
    self SetHintString(get_zombie_hint(default_ref));
  }
}

add_sound(ref, alias) {
  if(!isDefined(level.zombie_sounds)) {
    level.zombie_sounds = [];
  }
  level.zombie_sounds[ref] = alias;
}

play_sound_at_pos(ref, pos, ent) {
  if(isDefined(ent)) {
    if(isDefined(ent.script_soundalias)) {
      PlaySoundAtPosition(ent.script_soundalias, pos);
      return;
    }
    if(isDefined(self.script_sound)) {
      ref = self.script_sound;
    }
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    AssertMsg("Sound \"" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
    return;
  }
  PlaySoundAtPosition(level.zombie_sounds[ref], pos);
}

play_sound_on_ent(ref) {
  if(isDefined(self.script_soundalias)) {
    self PlaySound(self.script_soundalias);
    return;
  }
  if(isDefined(self.script_sound)) {
    ref = self.script_sound;
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    AssertMsg("Sound \"" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
    return;
  }
  self PlaySound(level.zombie_sounds[ref]);
}

play_loopsound_on_ent(ref) {
  if(isDefined(self.script_firefxsound)) {
    ref = self.script_firefxsound;
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    AssertMsg("Sound \"" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
    return;
  }
  self PlaySound(level.zombie_sounds[ref]);
}

string_to_float(string) {
  floatParts = strTok(string, ".");
  if(floatParts.size == 1)
    return int(floatParts[0]);
  whole = int(floatParts[0]);
  decimal = 0;
  for(i = floatParts[1].size - 1; i >= 0; i--) {
    decimal = decimal / 10 + int(floatParts[1][i]) / 10;
  }
  if(whole >= 0)
    return (whole + decimal);
  else
    return (whole - decimal);
}

set_zombie_var(var, value, is_float, column) {
  if(!isDefined(is_float)) {
    is_float = false;
  }
  if(!isDefined(column)) {
    column = 1;
  }
  table = "mp/zombiemode.csv";
  table_value = TableLookUp(table, 0,
    var, column);
  if(isDefined(table_value) && table_value != "") {
    if(is_float) {
      value = float(table_value);
    } else {
      value = int(table_value);
    }
  }
  level.zombie_vars[var] = value;
  return value;
}

get_table_var(table, var_name, value, is_float, column) {
  if(!isDefined(table)) {
    table = "mp/zombiemode.csv";
  }
  if(!isDefined(is_float)) {
    is_float = false;
  }
  if(!isDefined(column)) {
    column = 1;
  }
  table_value = TableLookUp(table, 0, var_name, column);
  if(isDefined(table_value) && table_value != "") {
    if(is_float) {
      value = string_to_float(table_value);
    } else {
      value = int(table_value);
    }
  }
  return value;
}

debug_ui() {}
hudelem_count() {}
debug_round_advancer() {}
print_run_speed(speed) {}
draw_line_ent_to_ent(ent1, ent2) {}
draw_line_ent_to_pos(ent, pos, end_on) {}
debug_print(msg) {}
debug_blocker(pos, rad, height) {}
drawcylinder(pos, rad, height) {}
print3d_at_pos(msg, pos, thread_endon, offset) {}
debug_breadcrumbs() {}
debug_attack_spots_taken() {
  while(1) {
    if(GetDvarInt(#"zombie_debug") != 2) {
      wait(1);
      continue;
    }
    wait(0.05);
    count = 0;
    for(i = 0; i < self.attack_spots_taken.size; i++) {
      if(self.attack_spots_taken[i]) {
        count++;
      }
    }
    msg = "" + count + " / " + self.attack_spots_taken.size;
    print3d(self.origin, msg);
  }
}

float_print3d(msg, time) {}
do_player_vo(snd, variation_count) {
  index = maps\_zombiemode_weapons::get_player_index(self);
  sound = "zmb_vox_plr_" + index + "_" + snd;
  if(isDefined(variation_count)) {
    sound = sound + "_" + randomintrange(0, variation_count);
  }
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(level.player_is_speaking == 0) {
    level.player_is_speaking = 1;
    self playsound(sound, "sound_done");
    self waittill("sound_done");
    wait(2);
    level.player_is_speaking = 0;
  }
}

is_magic_bullet_shield_enabled(ent) {
  if(!isDefined(ent))
    return false;
  return (isDefined(ent.magic_bullet_shield) && ent.magic_bullet_shield == true);
}

really_play_2D_sound(sound) {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playsound(sound, sound + "wait");
  temp_ent waittill(sound + "wait");
  wait(0.05);
  temp_ent delete();
}

play_sound_2D(sound) {
  level thread really_play_2D_sound(sound);
}

include_weapon(weapon_name, in_box, collector, weighting_func) {
  if(!isDefined(in_box)) {
    in_box = true;
  }
  if(!isDefined(collector)) {
    collector = false;
  }
  maps\_zombiemode_weapons::include_zombie_weapon(weapon_name, in_box, collector, weighting_func);
}

include_powerup(powerup_name) {
  maps\_zombiemode_powerups::include_zombie_powerup(powerup_name);
}

trigger_invisible(enable) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      self SetInvisibleToPlayer(players[i], enable);
    }
  }
}

print3d_ent(text, color, scale, offset, end_msg, overwrite) {
  self endon("death");
  if(isDefined(overwrite) && overwrite && isDefined(self._debug_print3d_msg)) {
    self notify("end_print3d");
    wait(0.05);
  }
  self endon("end_print3d");
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  if(!isDefined(scale)) {
    scale = 1.0;
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  if(isDefined(end_msg)) {
    self endon(end_msg);
  }
  self._debug_print3d_msg = text;
  while(1) {
    print3d(self.origin + offset, self._debug_print3d_msg, color, scale);
    wait(0.05);
  }
}

isExplosiveDamage(meansofdeath) {
  explosivedamage = "MOD_GRENADE MOD_GRENADE_SPLASH MOD_PROJECTILE_SPLASH MOD_EXPLOSIVE";
  if(isSubstr(explosivedamage, meansofdeath))
    return true;
  return false;
}

isPrimaryDamage(meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET")
    return true;
  return false;
}

isFireDamage(weapon, meansofdeath) {
  if((isSubStr(weapon, "flame") || isSubStr(weapon, "molotov_") || isSubStr(weapon, "napalmblob_")) && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH"))
    return true;
  return false;
}

isPlayerExplosiveWeapon(weapon, meansofdeath) {
  if(!isExplosiveDamage(meansofdeath))
    return false;
  if(weapon == "artillery_mp")
    return false;
  if(issubstr(weapon, "turret"))
    return false;
  return true;
}

swap_to_dissolve_models() {}
add_teampot_icon() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  {
    self SetCursorHint("HINT_NOICON");
  }
}

set_counter(value) {
  if(self.model != level.counter_model[value]) {
    self setModel(level.counter_model[value]);
  }
}

create_counter_hud(x) {
  if(!isDefined(x)) {
    x = 0;
  }
  hud = create_simple_hud();
  hud.alignX = "left";
  hud.alignY = "top";
  hud.horzAlign = "user_left";
  hud.vertAlign = "user_top";
  hud.color = (1, 1, 1);
  hud.fontscale = 32;
  hud.x = x;
  hud.alpha = 0;
  hud SetShader("hud_chalk_1", 64, 64);
  return hud;
}

get_current_zone() {
  flag_wait("zones_initialized");
  zkeys = GetArrayKeys(level.zones);
  for(z = 0; z < zkeys.size; z++) {
    zone_name = zkeys[z];
    zone = level.zones[zone_name];
    for(i = 0; i < zone.volumes.size; i++) {
      if(self IsTouching(zone.volumes[i])) {
        return zone_name;
      }
    }
  }
  return undefined;
}

remove_mod_from_methodofdeath(mod) {
  modStrings = strtok(mod, "_");
  modName = "";
  for(i = 1; i < modStrings.size; i++) {
    modName += modStrings[i];
  }
  return modName;
}

set_fog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
  sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
  sun_stop_ang, fade_time, max_fog_opacity) {
  self notify("stop_fog");
  self endon("disconnect");
  self endon("stop_fog");
  starting_height = self.origin[2];
  while(1) {
    height_offset = self.origin[2] - starting_height;
    self setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, fade_time, max_fog_opacity);
    wait(fade_time);
    fade_time = 1;
  }
}

clear_fog_threads() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] notify("stop_fog");
  }
}

display_message(msg) {
  notifyData = spawnStruct();
  notifyData.titleText = msg;
  self thread maps\_hud_message::notifyMessage(notifyData);
}

is_quad() {
  return self.animname == "quad_zombie";
}

increment_is_drinking() {
  self endon("death");
  if(self.is_drinking == 0) {
    self DisableOffhandWeapons();
    self DisableWeaponCycling();
  }
  self.is_drinking++;
}

is_drinking() {
  self endon("death");
  return (self.is_drinking > 0);
}

decrement_is_drinking() {
  self endon("death");
  if(self.is_drinking > 0) {
    self.is_drinking--;
  } else {
    AssertMsg("making is_drinking less than 0");
  }
  if(self.is_drinking == 0) {
    self EnableOffhandWeapons();
    self EnableWeaponCycling();
  }
}

clear_is_drinking() {
  self endon("death");
  self.is_drinking = 0;
  self EnableOffhandWeapons();
  self EnableWeaponCycling();
}