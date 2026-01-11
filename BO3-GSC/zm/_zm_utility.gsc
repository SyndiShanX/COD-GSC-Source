/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_faller;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_server_throttle;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_weapons;
#namespace zm_utility;

function init_utility() {}

function is_classic() {
  return true;
}

function is_standard() {
  dvar = getdvarstring("ui_gametype");
  if(dvar == "zstandard") {
    return true;
  }
  return false;
}

function convertsecondstomilliseconds(seconds) {
  return seconds * 1000;
}

function is_player() {
  return isplayer(self) || (isDefined(self.pers) && (isDefined(self.pers["isBot"]) && self.pers["isBot"]));
}

function lerp(chunk) {
  link = spawn("script_origin", self getorigin());
  link.angles = self.first_node.angles;
  self linkto(link);
  link rotateto(self.first_node.angles, level._contextual_grab_lerp_time);
  link moveto(self.attacking_spot, level._contextual_grab_lerp_time);
  link util::waittill_multiple("rotatedone", "movedone");
  self unlink();
  link delete();
}

function recalc_zombie_array() {}

function init_zombie_run_cycle() {
  if(isDefined(level.speed_change_round)) {
    if(level.round_number >= level.speed_change_round) {
      speed_percent = 0.2 + ((level.round_number - level.speed_change_round) * 0.2);
      speed_percent = min(speed_percent, 1);
      change_round_max = int(level.speed_change_max * speed_percent);
      change_left = change_round_max - level.speed_change_num;
      if(change_left == 0) {
        self zombie_utility::set_zombie_run_cycle();
        return;
      }
      change_speed = randomint(100);
      if(change_speed > 80) {
        self change_zombie_run_cycle();
        return;
      }
      zombie_count = zombie_utility::get_current_zombie_count();
      zombie_left = level.zombie_ai_limit - zombie_count;
      if(zombie_left == change_left) {
        self change_zombie_run_cycle();
        return;
      }
    }
  }
  self zombie_utility::set_zombie_run_cycle();
}

function change_zombie_run_cycle() {
  level.speed_change_num++;
  if(level.gamedifficulty == 0) {
    self zombie_utility::set_zombie_run_cycle("sprint");
  } else {
    self zombie_utility::set_zombie_run_cycle("walk");
  }
  self thread speed_change_watcher();
}

function make_supersprinter() {
  self zombie_utility::set_zombie_run_cycle("super_sprint");
}

function speed_change_watcher() {
  self waittill("death");
  if(level.speed_change_num > 0) {
    level.speed_change_num--;
  }
}

function move_zombie_spawn_location(spot) {
  self endon("death");
  if(isDefined(self.spawn_pos)) {
    self notify("risen", self.spawn_pos.script_string);
    return;
  }
  self.spawn_pos = spot;
  if(isDefined(spot.target)) {
    self.target = spot.target;
  }
  if(isDefined(spot.zone_name)) {
    self.zone_name = spot.zone_name;
    self.previous_zone_name = spot.zone_name;
  }
  if(isDefined(spot.script_parameters)) {
    self.script_parameters = spot.script_parameters;
  }
  if(!isDefined(spot.script_noteworthy)) {
    spot.script_noteworthy = "spawn_location";
  }
  tokens = strtok(spot.script_noteworthy, " ");
  foreach(index, token in tokens) {
    if(isDefined(self.spawn_point_override)) {
      spot = self.spawn_point_override;
      token = spot.script_noteworthy;
    }
    if(token == "custom_spawner_entry") {
      next_token = index + 1;
      if(isDefined(tokens[next_token])) {
        str_spawn_entry = tokens[next_token];
        if(isDefined(level.custom_spawner_entry) && isDefined(level.custom_spawner_entry[str_spawn_entry])) {
          self thread[[level.custom_spawner_entry[str_spawn_entry]]](spot);
          continue;
        }
      }
    }
    if(token == "riser_location") {
      self thread zm_spawner::do_zombie_rise(spot);
      continue;
    }
    if(token == "faller_location") {
      self thread zm_ai_faller::do_zombie_fall(spot);
      continue;
    }
    if(token == "spawn_location") {
      if(isDefined(self.anchor)) {
        return;
      }
      self.anchor = spawn("script_origin", self.origin);
      self.anchor.angles = self.angles;
      self linkto(self.anchor);
      self.anchor thread anchor_delete_failsafe(self);
      if(!isDefined(spot.angles)) {
        spot.angles = (0, 0, 0);
      }
      self ghost();
      self.anchor moveto(spot.origin, 0.05);
      self.anchor waittill("movedone");
      target_org = zombie_utility::get_desired_origin();
      if(isDefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill("rotatedone");
      }
      if(isDefined(level.zombie_spawn_fx)) {
        playFX(level.zombie_spawn_fx, spot.origin);
      }
      self unlink();
      if(isDefined(self.anchor)) {
        self.anchor delete();
      }
      if(!(isDefined(self.dontshow) && self.dontshow)) {
        self show();
      }
      self notify("risen", spot.script_string);
    }
  }
}

function anchor_delete_failsafe(ai_zombie) {
  ai_zombie endon("risen");
  ai_zombie waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

function run_spawn_functions() {
  self endon("death");
  waittillframeend();
  for(i = 0; i < level.spawn_funcs[self.team].size; i++) {
    func = level.spawn_funcs[self.team][i];
    util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
  }
  if(isDefined(self.spawn_funcs)) {
    for(i = 0; i < self.spawn_funcs.size; i++) {
      func = self.spawn_funcs[i];
      util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
    }
    self.saved_spawn_functions = self.spawn_funcs;
    self.spawn_funcs = undefined;
    self.spawn_funcs = self.saved_spawn_functions;
    self.saved_spawn_functions = undefined;
    self.spawn_funcs = undefined;
  }
}

function create_simple_hud(client, team) {
  if(isDefined(team)) {
    hud = newteamhudelem(team);
    hud.team = team;
  } else {
    if(isDefined(client)) {
      hud = newclienthudelem(client);
    } else {
      hud = newhudelem();
    }
  }
  level.hudelem_count++;
  hud.foreground = 1;
  hud.sort = 1;
  hud.hidewheninmenu = 0;
  return hud;
}

function destroy_hud() {
  level.hudelem_count--;
  self destroy();
}

function all_chunks_intact(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    pieces = barrier.zbarrier getzbarrierpieceindicesinstate("closed");
    if(pieces.size != barrier.zbarrier getnumzbarrierpieces()) {
      return false;
    }
  } else {
    for(i = 0; i < barrier_chunks.size; i++) {
      if(barrier_chunks[i] get_chunk_state() != "repaired") {
        return false;
      }
    }
  }
  return true;
}

function no_valid_repairable_boards(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
    if(pieces.size) {
      return false;
    }
  } else {
    for(i = 0; i < barrier_chunks.size; i++) {
      if(barrier_chunks[i] get_chunk_state() == "destroyed") {
        return false;
      }
    }
  }
  return true;
}

function is_survival() {
  return false;
}

function is_encounter() {
  return false;
}

function all_chunks_destroyed(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    pieces = arraycombine(barrier.zbarrier getzbarrierpieceindicesinstate("open"), barrier.zbarrier getzbarrierpieceindicesinstate("opening"), 1, 0);
    if(pieces.size != barrier.zbarrier getnumzbarrierpieces()) {
      return false;
    }
  } else if(isDefined(barrier_chunks)) {
    assert(isDefined(barrier_chunks), "");
    for(i = 0; i < barrier_chunks.size; i++) {
      if(barrier_chunks[i] get_chunk_state() != "destroyed") {
        return false;
      }
    }
  }
  return true;
}

function check_point_in_playable_area(origin) {
  playable_area = getEntArray("player_volume", "script_noteworthy");
  if(!isDefined(level.check_model)) {
    level.check_model = spawn("script_model", origin + vectorscale((0, 0, 1), 40));
  } else {
    level.check_model.origin = origin + vectorscale((0, 0, 1), 40);
  }
  valid_point = 0;
  for(i = 0; i < playable_area.size; i++) {
    if(level.check_model istouching(playable_area[i])) {
      valid_point = 1;
    }
  }
  return valid_point;
}

function check_point_in_enabled_zone(origin, zone_is_active, player_zones = getEntArray("player_volume", "script_noteworthy")) {
  if(!isDefined(level.zones) || !isDefined(player_zones)) {
    return 1;
  }
  if(!isDefined(level.e_check_point)) {
    level.e_check_point = spawn("script_origin", origin + vectorscale((0, 0, 1), 40));
  } else {
    level.e_check_point.origin = origin + vectorscale((0, 0, 1), 40);
  }
  one_valid_zone = 0;
  for(i = 0; i < player_zones.size; i++) {
    if(level.e_check_point istouching(player_zones[i])) {
      zone = level.zones[player_zones[i].targetname];
      if(isDefined(zone) && (isDefined(zone.is_enabled) && zone.is_enabled)) {
        if(isDefined(zone_is_active) && zone_is_active == 1 && (!(isDefined(zone.is_active) && zone.is_active))) {
          continue;
        }
        one_valid_zone = 1;
        break;
      }
    }
  }
  return one_valid_zone;
}

function round_up_to_ten(score) {
  new_score = score - (score % 10);
  if(new_score < score) {
    new_score = new_score + 10;
  }
  return new_score;
}

function round_up_score(score, value) {
  score = int(score);
  new_score = score - (score % value);
  if(new_score < score) {
    new_score = new_score + value;
  }
  return new_score;
}

function halve_score(n_score) {
  n_score = n_score / 2;
  n_score = round_up_score(n_score, 10);
  return n_score;
}

function random_tan() {
  rand = randomint(100);
  if(isDefined(level.char_percent_override)) {
    percentnotcharred = level.char_percent_override;
  } else {
    percentnotcharred = 65;
  }
}

function places_before_decimal(num) {
  abs_num = abs(num);
  count = 0;
  while(true) {
    abs_num = abs_num * 0.1;
    count = count + 1;
    if(abs_num < 1) {
      return count;
    }
  }
}

function create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on, initial_attract_func, arrival_attract_func, poi_team) {
  if(!isDefined(added_poi_value)) {
    self.added_poi_value = 0;
  } else {
    self.added_poi_value = added_poi_value;
  }
  if(!isDefined(start_turned_on)) {
    start_turned_on = 1;
  }
  if(!isDefined(attract_dist)) {
    attract_dist = 1536;
  }
  self.script_noteworthy = "zombie_poi";
  self.poi_active = start_turned_on;
  if(isDefined(attract_dist)) {
    self.max_attractor_dist = attract_dist;
    self.poi_radius = attract_dist * attract_dist;
  } else {
    self.poi_radius = undefined;
  }
  self.num_poi_attracts = num_attractors;
  self.attract_to_origin = 1;
  self.attractor_array = [];
  self.initial_attract_func = undefined;
  self.arrival_attract_func = undefined;
  if(isDefined(poi_team)) {
    self._team = poi_team;
  }
  if(isDefined(initial_attract_func)) {
    self.initial_attract_func = initial_attract_func;
  }
  if(isDefined(arrival_attract_func)) {
    self.arrival_attract_func = arrival_attract_func;
  }
  if(!isDefined(level.zombie_poi_array)) {
    level.zombie_poi_array = [];
  } else if(!isarray(level.zombie_poi_array)) {
    level.zombie_poi_array = array(level.zombie_poi_array);
  }
  level.zombie_poi_array[level.zombie_poi_array.size] = self;
  self thread watch_for_poi_death();
}

function watch_for_poi_death() {
  self waittill("death");
  if(isinarray(level.zombie_poi_array, self)) {
    arrayremovevalue(level.zombie_poi_array, self);
  }
}

function debug_draw_new_attractor_positions() {
  self endon("death");
  while(true) {
    foreach(attract in self.attractor_positions) {
      passed = bullettracepassed(attract[0] + vectorscale((0, 0, 1), 24), self.origin + vectorscale((0, 0, 1), 24), 0, self);
      if(passed) {
        debugstar(attract[0], 6, (1, 1, 1));
        continue;
      }
      debugstar(attract[0], 6, (1, 0, 0));
    }
    wait(0.05);
  }
}

function create_zombie_point_of_interest_attractor_positions(num_attract_dists, attract_dist) {
  self endon("death");
  if(!isDefined(self.num_poi_attracts) || (isDefined(self.script_noteworthy) && self.script_noteworthy != "zombie_poi")) {
    return;
  }
  if(!isDefined(num_attract_dists)) {
    num_attract_dists = 4;
  }
  queryresult = positionquery_source_navigation(self.origin, attract_dist / 2, self.max_attractor_dist, attract_dist / 2, attract_dist / 2, 1, attract_dist / 2);
  if(queryresult.data.size < self.num_poi_attracts) {
    self.num_poi_attracts = queryresult.data.size;
  }
  for(i = 0; i < self.num_poi_attracts; i++) {
    if(isDefined(level.validate_poi_attractors) && level.validate_poi_attractors) {
      passed = bullettracepassed(queryresult.data[i].origin + vectorscale((0, 0, 1), 24), self.origin + vectorscale((0, 0, 1), 24), 0, self);
      if(passed) {
        self.attractor_positions[i][0] = queryresult.data[i].origin;
        self.attractor_positions[i][1] = self;
      }
      continue;
    }
    self.attractor_positions[i][0] = queryresult.data[i].origin;
    self.attractor_positions[i][1] = self;
  }
  if(!isDefined(self.attractor_positions)) {
    self.attractor_positions = [];
  }
  self.num_attract_dists = num_attract_dists;
  self.last_index = [];
  for(i = 0; i < num_attract_dists; i++) {
    self.last_index[i] = -1;
  }
  self.last_index[0] = 1;
  self.last_index[1] = self.attractor_positions.size;
  self.attract_to_origin = 0;
  self notify("attractor_positions_generated");
  level notify("attractor_positions_generated");
}

function generated_radius_attract_positions(forward, offset, num_positions, attract_radius) {
  self endon("death");
  epsilon = 1;
  failed = 0;
  degs_per_pos = 360 / num_positions;
  i = offset;
  while(i < (360 + offset)) {
    altforward = forward * attract_radius;
    rotated_forward = ((cos(i) * altforward[0]) - (sin(i) * altforward[1]), (sin(i) * altforward[0]) + (cos(i) * altforward[1]), altforward[2]);
    if(isDefined(level.poi_positioning_func)) {
      pos = [
        [level.poi_positioning_func]
      ](self.origin, rotated_forward);
    } else {
      if(isDefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning) {
        pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, (self.origin + rotated_forward) + vectorscale((0, 0, 1), 10));
      } else {
        pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, (self.origin + rotated_forward) + vectorscale((0, 0, 1), 100));
      }
    }
    if(!isDefined(pos)) {
      failed++;
    } else {
      if(isDefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning) {
        if(isDefined(self) && isDefined(self.origin)) {
          if(self.origin[2] >= (pos[2] - epsilon) && (self.origin[2] - pos[2]) <= 150) {
            pos_array = [];
            pos_array[0] = pos;
            pos_array[1] = self;
            if(!isDefined(self.attractor_positions)) {
              self.attractor_positions = [];
            } else if(!isarray(self.attractor_positions)) {
              self.attractor_positions = array(self.attractor_positions);
            }
            self.attractor_positions[self.attractor_positions.size] = pos_array;
          }
        } else {
          failed++;
        }
      } else {
        if((abs(pos[2] - self.origin[2])) < 60) {
          pos_array = [];
          pos_array[0] = pos;
          pos_array[1] = self;
          if(!isDefined(self.attractor_positions)) {
            self.attractor_positions = [];
          } else if(!isarray(self.attractor_positions)) {
            self.attractor_positions = array(self.attractor_positions);
          }
          self.attractor_positions[self.attractor_positions.size] = pos_array;
        } else {
          failed++;
        }
      }
    }
    i = i + degs_per_pos;
  }
  return failed;
}

function debug_draw_attractor_positions() {
  while(true) {
    while(!isDefined(self.attractor_positions)) {
      wait(0.05);
      continue;
    }
    for(i = 0; i < self.attractor_positions.size; i++) {
      line(self.origin, self.attractor_positions[i][0], (1, 0, 0), 1, 1);
    }
    wait(0.05);
    if(!isDefined(self)) {
      return;
    }
  }
}

function debug_draw_claimed_attractor_positions() {
  while(true) {
    while(!isDefined(self.claimed_attractor_positions)) {
      wait(0.05);
      continue;
    }
    for(i = 0; i < self.claimed_attractor_positions.size; i++) {
      line(self.origin, self.claimed_attractor_positions[i][0], (0, 1, 0), 1, 1);
    }
    wait(0.05);
    if(!isDefined(self)) {
      return;
    }
  }
}

function get_zombie_point_of_interest(origin, poi_array) {
  aiprofile_beginentry("get_zombie_point_of_interest");
  if(isDefined(self.ignore_all_poi) && self.ignore_all_poi) {
    aiprofile_endentry();
    return undefined;
  }
  curr_radius = undefined;
  if(isDefined(poi_array)) {
    ent_array = poi_array;
  } else {
    ent_array = level.zombie_poi_array;
  }
  best_poi = undefined;
  position = undefined;
  best_dist = 100000000;
  for(i = 0; i < ent_array.size; i++) {
    if(!isDefined(ent_array[i]) || !isDefined(ent_array[i].poi_active) || !ent_array[i].poi_active) {
      continue;
    }
    if(isDefined(self.ignore_poi_targetname) && self.ignore_poi_targetname.size > 0) {
      if(isDefined(ent_array[i].targetname)) {
        ignore = 0;
        for(j = 0; j < self.ignore_poi_targetname.size; j++) {
          if(ent_array[i].targetname == self.ignore_poi_targetname[j]) {
            ignore = 1;
            break;
          }
        }
        if(ignore) {
          continue;
        }
      }
    }
    if(isDefined(self.ignore_poi) && self.ignore_poi.size > 0) {
      ignore = 0;
      for(j = 0; j < self.ignore_poi.size; j++) {
        if(self.ignore_poi[j] == ent_array[i]) {
          ignore = 1;
          break;
        }
      }
      if(ignore) {
        continue;
      }
    }
    dist = distancesquared(origin, ent_array[i].origin);
    dist = dist - ent_array[i].added_poi_value;
    if(isDefined(ent_array[i].poi_radius)) {
      curr_radius = ent_array[i].poi_radius;
    }
    if(!isDefined(curr_radius) || dist < curr_radius && dist < best_dist && ent_array[i] can_attract(self)) {
      best_poi = ent_array[i];
      best_dist = dist;
    }
  }
  if(isDefined(best_poi)) {
    if(isDefined(best_poi._team)) {
      if(isDefined(self._race_team) && self._race_team != best_poi._team) {
        aiprofile_endentry();
        return undefined;
      }
    }
    if(isDefined(best_poi._new_ground_trace) && best_poi._new_ground_trace) {
      position = [];
      position[0] = groundpos_ignore_water_new(best_poi.origin + vectorscale((0, 0, 1), 100));
      position[1] = self;
    } else {
      if(isDefined(best_poi.attract_to_origin) && best_poi.attract_to_origin) {
        position = [];
        position[0] = groundpos(best_poi.origin + vectorscale((0, 0, 1), 100));
        position[1] = self;
      } else {
        position = self add_poi_attractor(best_poi);
      }
    }
    if(isDefined(best_poi.initial_attract_func)) {
      self thread[[best_poi.initial_attract_func]](best_poi);
    }
    if(isDefined(best_poi.arrival_attract_func)) {
      self thread[[best_poi.arrival_attract_func]](best_poi);
    }
  }
  aiprofile_endentry();
  return position;
}

function activate_zombie_point_of_interest() {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }
  self.poi_active = 1;
}

function deactivate_zombie_point_of_interest(dont_remove) {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }
  self.attractor_array = array::remove_undefined(self.attractor_array);
  for(i = 0; i < self.attractor_array.size; i++) {
    self.attractor_array[i] notify("kill_poi");
  }
  self.attractor_array = [];
  self.claimed_attractor_positions = [];
  self.poi_active = 0;
  if(isDefined(dont_remove) && dont_remove) {
    return;
  }
  if(isDefined(self)) {
    if(isinarray(level.zombie_poi_array, self)) {
      arrayremovevalue(level.zombie_poi_array, self);
    }
  }
}

function assign_zombie_point_of_interest(origin, poi) {
  position = undefined;
  doremovalthread = 0;
  if(isDefined(poi) && poi can_attract(self)) {
    if(!isDefined(poi.attractor_array) || (isDefined(poi.attractor_array) && !isinarray(poi.attractor_array, self))) {
      doremovalthread = 1;
    }
    position = self add_poi_attractor(poi);
    if(isDefined(position) && doremovalthread && isinarray(poi.attractor_array, self)) {
      self thread update_on_poi_removal(poi);
    }
  }
  return position;
}

function remove_poi_attractor(zombie_poi) {
  if(!isDefined(zombie_poi) || !isDefined(zombie_poi.attractor_array)) {
    return;
  }
  for(i = 0; i < zombie_poi.attractor_array.size; i++) {
    if(zombie_poi.attractor_array[i] == self) {
      arrayremovevalue(zombie_poi.attractor_array, zombie_poi.attractor_array[i]);
      arrayremovevalue(zombie_poi.claimed_attractor_positions, zombie_poi.claimed_attractor_positions[i]);
      if(isDefined(self)) {
        self notify("kill_poi");
      }
    }
  }
}

function array_check_for_dupes_using_compare(array, single, is_equal_fn) {
  for(i = 0; i < array.size; i++) {
    if([
        [is_equal_fn]
      ](array[i], single)) {
      return false;
    }
  }
  return true;
}

function poi_locations_equal(loc1, loc2) {
  return loc1[0] == loc2[0];
}

function add_poi_attractor(zombie_poi) {
  if(!isDefined(zombie_poi)) {
    return;
  }
  if(!isDefined(zombie_poi.attractor_array)) {
    zombie_poi.attractor_array = [];
  }
  if(!isinarray(zombie_poi.attractor_array, self)) {
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
    best_dist = 100000000;
    best_pos = undefined;
    if(start < 0) {
      start = 0;
    }
    if(end < 0) {
      return undefined;
    }
    for(i = int(start); i <= int(end); i++) {
      if(!isDefined(zombie_poi.attractor_positions[i])) {
        continue;
      }
      if(array_check_for_dupes_using_compare(zombie_poi.claimed_attractor_positions, zombie_poi.attractor_positions[i], &poi_locations_equal)) {
        if(isDefined(zombie_poi.attractor_positions[i][0]) && isDefined(self.origin)) {
          dist = distancesquared(zombie_poi.attractor_positions[i][0], zombie_poi.origin);
          if(dist < best_dist || !isDefined(best_pos)) {
            best_dist = dist;
            best_pos = zombie_poi.attractor_positions[i];
          }
        }
      }
    }
    if(!isDefined(best_pos)) {
      if(isDefined(level.validate_poi_attractors) && level.validate_poi_attractors) {
        valid_pos = [];
        valid_pos[0] = zombie_poi.origin;
        valid_pos[1] = zombie_poi;
        return valid_pos;
      }
      return undefined;
    }
    if(!isDefined(zombie_poi.attractor_array)) {
      zombie_poi.attractor_array = [];
    } else if(!isarray(zombie_poi.attractor_array)) {
      zombie_poi.attractor_array = array(zombie_poi.attractor_array);
    }
    zombie_poi.attractor_array[zombie_poi.attractor_array.size] = self;
    self thread update_poi_on_death(zombie_poi);
    if(!isDefined(zombie_poi.claimed_attractor_positions)) {
      zombie_poi.claimed_attractor_positions = [];
    } else if(!isarray(zombie_poi.claimed_attractor_positions)) {
      zombie_poi.claimed_attractor_positions = array(zombie_poi.claimed_attractor_positions);
    }
    zombie_poi.claimed_attractor_positions[zombie_poi.claimed_attractor_positions.size] = best_pos;
    return best_pos;
  }
  for(i = 0; i < zombie_poi.attractor_array.size; i++) {
    if(zombie_poi.attractor_array[i] == self) {
      if(isDefined(zombie_poi.claimed_attractor_positions) && isDefined(zombie_poi.claimed_attractor_positions[i])) {
        return zombie_poi.claimed_attractor_positions[i];
      }
    }
  }
  return undefined;
}

function can_attract(attractor) {
  if(!isDefined(self.attractor_array)) {
    self.attractor_array = [];
  }
  if(isDefined(self.attracted_array) && !isinarray(self.attracted_array, attractor)) {
    return false;
  }
  if(isinarray(self.attractor_array, attractor)) {
    return true;
  }
  if(isDefined(self.num_poi_attracts) && self.attractor_array.size >= self.num_poi_attracts) {
    return false;
  }
  return true;
}

function update_poi_on_death(zombie_poi) {
  self endon("kill_poi");
  self waittill("death");
  self remove_poi_attractor(zombie_poi);
}

function update_on_poi_removal(zombie_poi) {
  zombie_poi waittill("death");
  if(!isDefined(zombie_poi.attractor_array)) {
    return;
  }
  for(i = 0; i < zombie_poi.attractor_array.size; i++) {
    if(zombie_poi.attractor_array[i] == self) {
      arrayremoveindex(zombie_poi.attractor_array, i);
      arrayremoveindex(zombie_poi.claimed_attractor_positions, i);
    }
  }
}

function invalidate_attractor_pos(attractor_pos, zombie) {
  if(!isDefined(self) || !isDefined(attractor_pos)) {
    wait(0.1);
    return undefined;
  }
  if(isDefined(self.attractor_positions) && !array_check_for_dupes_using_compare(self.attractor_positions, attractor_pos, &poi_locations_equal)) {
    index = 0;
    for(i = 0; i < self.attractor_positions.size; i++) {
      if(poi_locations_equal(self.attractor_positions[i], attractor_pos)) {
        index = i;
      }
    }
    for(i = 0; i < self.last_index.size; i++) {
      if(index <= self.last_index[i]) {
        self.last_index[i]--;
      }
    }
    arrayremovevalue(self.attractor_array, zombie);
    arrayremovevalue(self.attractor_positions, attractor_pos);
    for(i = 0; i < self.claimed_attractor_positions.size; i++) {
      if(self.claimed_attractor_positions[i][0] == attractor_pos[0]) {
        arrayremovevalue(self.claimed_attractor_positions, self.claimed_attractor_positions[i]);
      }
    }
  } else {
    wait(0.1);
  }
  return get_zombie_point_of_interest(zombie.origin);
}

function remove_poi_from_ignore_list(poi) {
  if(isDefined(self.ignore_poi) && self.ignore_poi.size > 0) {
    for(i = 0; i < self.ignore_poi.size; i++) {
      if(self.ignore_poi[i] == poi) {
        arrayremovevalue(self.ignore_poi, self.ignore_poi[i]);
        return;
      }
    }
  }
}

function add_poi_to_ignore_list(poi) {
  if(!isDefined(self.ignore_poi)) {
    self.ignore_poi = [];
  }
  add_poi = 1;
  if(self.ignore_poi.size > 0) {
    for(i = 0; i < self.ignore_poi.size; i++) {
      if(self.ignore_poi[i] == poi) {
        add_poi = 0;
        break;
      }
    }
  }
  if(add_poi) {
    self.ignore_poi[self.ignore_poi.size] = poi;
  }
}

function default_validate_enemy_path_length(player) {
  max_dist = 1296;
  d = distancesquared(self.origin, player.origin);
  if(d <= max_dist) {
    return true;
  }
  return false;
}

function get_closest_valid_player(origin, ignore_player) {
  aiprofile_beginentry("get_closest_valid_player");
  valid_player_found = 0;
  players = getplayers();
  if(isDefined(level.get_closest_valid_player_override)) {
    players = [[level.get_closest_valid_player_override]]();
  }
  b_designated_target_exists = 0;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player.am_i_valid) {
      continue;
    }
    if(isDefined(level.evaluate_zone_path_override)) {
      if(![[level.evaluate_zone_path_override]](player)) {
        array::add(ignore_player, player);
      }
    }
    if(isDefined(player.b_is_designated_target) && player.b_is_designated_target) {
      b_designated_target_exists = 1;
    }
  }
  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      arrayremovevalue(players, ignore_player[i]);
    }
  }
  done = 0;
  while(players.size && !done) {
    done = 1;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(!player.am_i_valid) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }
      if(b_designated_target_exists && (!(isDefined(player.b_is_designated_target) && player.b_is_designated_target))) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }
    }
  }
  if(players.size == 0) {
    aiprofile_endentry();
    return undefined;
  }
  if(!valid_player_found) {
    for(;;) {
      player = [
        [self.closest_player_override]
      ](origin, players);
      player = [
        [level.closest_player_override]
      ](origin, players);
      player = arraygetclosest(origin, players);
      aiprofile_endentry();
      return undefined;
      aiprofile_endentry();
      return player;
      arrayremovevalue(players, player);
      aiprofile_endentry();
      return undefined;
    }
    if(isDefined(self.closest_player_override)) {} else {
      if(isDefined(level.closest_player_override)) {} else {}
    }
    if(!isDefined(player) || players.size == 0) {}
    if(isDefined(level.allow_zombie_to_target_ai) && level.allow_zombie_to_target_ai || (isDefined(player.allow_zombie_to_target_ai) && player.allow_zombie_to_target_ai)) {}
    if(!player.am_i_valid) {
      if(players.size == 0) {}
    }
    aiprofile_endentry();
    return player;
  }
}

function update_valid_players(origin, ignore_player) {
  aiprofile_beginentry("update_valid_players");
  valid_player_found = 0;
  players = arraycopy(level.players);
  foreach(player in players) {
    self setignoreent(player, 1);
  }
  b_designated_target_exists = 0;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player.am_i_valid) {
      continue;
    }
    if(isDefined(level.evaluate_zone_path_override)) {
      if(![[level.evaluate_zone_path_override]](player)) {
        array::add(ignore_player, player);
      }
    }
    if(isDefined(player.b_is_designated_target) && player.b_is_designated_target) {
      b_designated_target_exists = 1;
    }
  }
  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      arrayremovevalue(players, ignore_player[i]);
    }
  }
  done = 0;
  while(players.size && !done) {
    done = 1;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(!player.am_i_valid) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }
      if(b_designated_target_exists && (!(isDefined(player.b_is_designated_target) && player.b_is_designated_target))) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }
    }
  }
  foreach(player in players) {
    self setignoreent(player, 0);
    self getperfectinfo(player);
  }
  aiprofile_endentry();
}

function is_player_valid(player, checkignoremeflag, ignore_laststand_players) {
  if(!isDefined(player)) {
    return 0;
  }
  if(!isalive(player)) {
    return 0;
  }
  if(!isplayer(player)) {
    return 0;
  }
  if(isDefined(player.is_zombie) && player.is_zombie == 1) {
    return 0;
  }
  if(player.sessionstate == "spectator") {
    return 0;
  }
  if(player.sessionstate == "intermission") {
    return 0;
  }
  if(isDefined(level.intermission) && level.intermission) {
    return 0;
  }
  if(!(isDefined(ignore_laststand_players) && ignore_laststand_players)) {
    if(player laststand::player_is_in_laststand()) {
      return 0;
    }
  }
  if(isDefined(checkignoremeflag) && checkignoremeflag && player.ignoreme) {
    return 0;
  }
  if(isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](player);
  }
  return 1;
}

function get_number_of_valid_players() {
  players = getplayers();
  num_player_valid = 0;
  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i])) {
      num_player_valid = num_player_valid + 1;
    }
  }
  return num_player_valid;
}

function in_revive_trigger() {
  if(isDefined(self.rt_time) && (self.rt_time + 100) >= gettime()) {
    return self.in_rt_cached;
  }
  self.rt_time = gettime();
  players = level.players;
  for(i = 0; i < players.size; i++) {
    current_player = players[i];
    if(isDefined(current_player) && isDefined(current_player.revivetrigger) && isalive(current_player)) {
      if(self istouching(current_player.revivetrigger)) {
        self.in_rt_cached = 1;
        return 1;
      }
    }
  }
  self.in_rt_cached = 0;
  return 0;
}

function get_closest_node(org, nodes) {
  return arraygetclosest(org, nodes);
}

function non_destroyed_bar_board_order(origin, chunks) {
  first_bars = [];
  first_bars1 = [];
  first_bars2 = [];
  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && chunks[i].script_team == "classic_boards") {
      if(isDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "board") {
        return get_closest_2d(origin, chunks);
      }
      if(isDefined(chunks[i].script_team) && chunks[i].script_team == "bar_board_variant1" || chunks[i].script_team == "bar_board_variant2" || chunks[i].script_team == "bar_board_variant4" || chunks[i].script_team == "bar_board_variant5") {
        return undefined;
      }
      continue;
    }
    if(isDefined(chunks[i].script_team) && chunks[i].script_team == "new_barricade") {
      if(isDefined(chunks[i].script_parameters) && (chunks[i].script_parameters == "repair_board" || chunks[i].script_parameters == "barricade_vents")) {
        return get_closest_2d(origin, chunks);
      }
    }
  }
  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent" || chunks[i].script_team == "6_bars_prestine") {
      if(isDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar") {
        if(isDefined(chunks[i].script_noteworthy)) {
          if(chunks[i].script_noteworthy == "4" || chunks[i].script_noteworthy == "6") {
            first_bars[first_bars.size] = chunks[i];
          }
        }
      }
    }
  }
  for(i = 0; i < first_bars.size; i++) {
    if(isDefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent" || chunks[i].script_team == "6_bars_prestine") {
      if(isDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar") {
        if(!first_bars[i].destroyed) {
          return first_bars[i];
        }
      }
    }
  }
  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent" || chunks[i].script_team == "6_bars_prestine") {
      if(isDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar") {
        if(!chunks[i].destroyed) {
          return get_closest_2d(origin, chunks);
        }
      }
    }
  }
}

function non_destroyed_grate_order(origin, chunks_grate) {
  grate_order = [];
  grate_order1 = [];
  grate_order2 = [];
  grate_order3 = [];
  grate_order4 = [];
  grate_order5 = [];
  grate_order6 = [];
  if(isDefined(chunks_grate)) {
    for(i = 0; i < chunks_grate.size; i++) {
      if(isDefined(chunks_grate[i].script_parameters) && chunks_grate[i].script_parameters == "grate") {
        if(isDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "1") {
          grate_order1[grate_order1.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "2") {
          grate_order2[grate_order2.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "3") {
          grate_order3[grate_order3.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "4") {
          grate_order4[grate_order4.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "5") {
          grate_order5[grate_order5.size] = chunks_grate[i];
        }
        if(isDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "6") {
          grate_order6[grate_order6.size] = chunks_grate[i];
        }
      }
    }
    for(i = 0; i < chunks_grate.size; i++) {
      if(isDefined(chunks_grate[i].script_parameters) && chunks_grate[i].script_parameters == "grate") {
        if(isDefined(grate_order1[i])) {
          if(grate_order1[i].state == "repaired") {
            grate_order2[i] thread show_grate_pull();
            return grate_order1[i];
          }
          if(grate_order2[i].state == "repaired") {
            iprintlnbold("");
            grate_order3[i] thread show_grate_pull();
            return grate_order2[i];
          }
          if(grate_order3[i].state == "repaired") {
            iprintlnbold("");
            grate_order4[i] thread show_grate_pull();
            return grate_order3[i];
          }
          if(grate_order4[i].state == "repaired") {
            iprintlnbold("");
            grate_order5[i] thread show_grate_pull();
            return grate_order4[i];
          }
          if(grate_order5[i].state == "repaired") {
            iprintlnbold("");
            grate_order6[i] thread show_grate_pull();
            return grate_order5[i];
          }
          if(grate_order6[i].state == "repaired") {
            return grate_order6[i];
          }
        }
      }
    }
  }
}

function non_destroyed_variant1_order(origin, chunks_variant1) {
  variant1_order = [];
  variant1_order1 = [];
  variant1_order2 = [];
  variant1_order3 = [];
  variant1_order4 = [];
  variant1_order5 = [];
  variant1_order6 = [];
  if(isDefined(chunks_variant1)) {
    for(i = 0; i < chunks_variant1.size; i++) {
      if(isDefined(chunks_variant1[i].script_team) && chunks_variant1[i].script_team == "bar_board_variant1") {
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
      if(isDefined(chunks_variant1[i].script_team) && chunks_variant1[i].script_team == "bar_board_variant1") {
        if(isDefined(variant1_order2[i])) {
          if(variant1_order2[i].state == "repaired") {
            return variant1_order2[i];
          }
          if(variant1_order3[i].state == "repaired") {
            return variant1_order3[i];
          }
          if(variant1_order4[i].state == "repaired") {
            return variant1_order4[i];
          }
          if(variant1_order6[i].state == "repaired") {
            return variant1_order6[i];
          }
          if(variant1_order5[i].state == "repaired") {
            return variant1_order5[i];
          }
          if(variant1_order1[i].state == "repaired") {
            return variant1_order1[i];
          }
        }
      }
    }
  }
}

function non_destroyed_variant2_order(origin, chunks_variant2) {
  variant2_order = [];
  variant2_order1 = [];
  variant2_order2 = [];
  variant2_order3 = [];
  variant2_order4 = [];
  variant2_order5 = [];
  variant2_order6 = [];
  if(isDefined(chunks_variant2)) {
    for(i = 0; i < chunks_variant2.size; i++) {
      if(isDefined(chunks_variant2[i].script_team) && chunks_variant2[i].script_team == "bar_board_variant2") {
        if(isDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "1") {
          variant2_order1[variant2_order1.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "2") {
          variant2_order2[variant2_order2.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "3") {
          variant2_order3[variant2_order3.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "4") {
          variant2_order4[variant2_order4.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "5" && isDefined(chunks_variant2[i].script_location) && chunks_variant2[i].script_location == "5") {
          variant2_order5[variant2_order5.size] = chunks_variant2[i];
        }
        if(isDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "5" && isDefined(chunks_variant2[i].script_location) && chunks_variant2[i].script_location == "6") {
          variant2_order6[variant2_order6.size] = chunks_variant2[i];
        }
      }
    }
    for(i = 0; i < chunks_variant2.size; i++) {
      if(isDefined(chunks_variant2[i].script_team) && chunks_variant2[i].script_team == "bar_board_variant2") {
        if(isDefined(variant2_order1[i])) {
          if(variant2_order1[i].state == "repaired") {
            return variant2_order1[i];
          }
          if(variant2_order2[i].state == "repaired") {
            return variant2_order2[i];
          }
          if(variant2_order3[i].state == "repaired") {
            return variant2_order3[i];
          }
          if(variant2_order5[i].state == "repaired") {
            return variant2_order5[i];
          }
          if(variant2_order4[i].state == "repaired") {
            return variant2_order4[i];
          }
          if(variant2_order6[i].state == "repaired") {
            return variant2_order6[i];
          }
        }
      }
    }
  }
}

function non_destroyed_variant4_order(origin, chunks_variant4) {
  variant4_order = [];
  variant4_order1 = [];
  variant4_order2 = [];
  variant4_order3 = [];
  variant4_order4 = [];
  variant4_order5 = [];
  variant4_order6 = [];
  if(isDefined(chunks_variant4)) {
    for(i = 0; i < chunks_variant4.size; i++) {
      if(isDefined(chunks_variant4[i].script_team) && chunks_variant4[i].script_team == "bar_board_variant4") {
        if(isDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "1" && !isDefined(chunks_variant4[i].script_location)) {
          variant4_order1[variant4_order1.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "2") {
          variant4_order2[variant4_order2.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "3") {
          variant4_order3[variant4_order3.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "1" && isDefined(chunks_variant4[i].script_location) && chunks_variant4[i].script_location == "3") {
          variant4_order4[variant4_order4.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "5") {
          variant4_order5[variant4_order5.size] = chunks_variant4[i];
        }
        if(isDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "6") {
          variant4_order6[variant4_order6.size] = chunks_variant4[i];
        }
      }
    }
    for(i = 0; i < chunks_variant4.size; i++) {
      if(isDefined(chunks_variant4[i].script_team) && chunks_variant4[i].script_team == "bar_board_variant4") {
        if(isDefined(variant4_order1[i])) {
          if(variant4_order1[i].state == "repaired") {
            return variant4_order1[i];
          }
          if(variant4_order6[i].state == "repaired") {
            return variant4_order6[i];
          }
          if(variant4_order3[i].state == "repaired") {
            return variant4_order3[i];
          }
          if(variant4_order4[i].state == "repaired") {
            return variant4_order4[i];
          }
          if(variant4_order2[i].state == "repaired") {
            return variant4_order2[i];
          }
          if(variant4_order5[i].state == "repaired") {
            return variant4_order5[i];
          }
        }
      }
    }
  }
}

function non_destroyed_variant5_order(origin, chunks_variant5) {
  variant5_order = [];
  variant5_order1 = [];
  variant5_order2 = [];
  variant5_order3 = [];
  variant5_order4 = [];
  variant5_order5 = [];
  variant5_order6 = [];
  if(isDefined(chunks_variant5)) {
    for(i = 0; i < chunks_variant5.size; i++) {
      if(isDefined(chunks_variant5[i].script_team) && chunks_variant5[i].script_team == "bar_board_variant5") {
        if(isDefined(chunks_variant5[i].script_noteworthy)) {
          if(chunks_variant5[i].script_noteworthy == "1" && !isDefined(chunks_variant5[i].script_location)) {
            variant5_order1[variant5_order1.size] = chunks_variant5[i];
          }
          if(chunks_variant5[i].script_noteworthy == "2") {
            variant5_order2[variant5_order2.size] = chunks_variant5[i];
          }
          if(isDefined(chunks_variant5[i].script_noteworthy) && chunks_variant5[i].script_noteworthy == "1" && isDefined(chunks_variant5[i].script_location) && chunks_variant5[i].script_location == "3") {
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
      if(isDefined(chunks_variant5[i].script_team) && chunks_variant5[i].script_team == "bar_board_variant5") {
        if(isDefined(variant5_order1[i])) {
          if(variant5_order1[i].state == "repaired") {
            return variant5_order1[i];
          }
          if(variant5_order6[i].state == "repaired") {
            return variant5_order6[i];
          }
          if(variant5_order3[i].state == "repaired") {
            return variant5_order3[i];
          }
          if(variant5_order2[i].state == "repaired") {
            return variant5_order2[i];
          }
          if(variant5_order5[i].state == "repaired") {
            return variant5_order5[i];
          }
          if(variant5_order4[i].state == "repaired") {
            return variant5_order4[i];
          }
        }
      }
    }
  }
}

function show_grate_pull() {
  wait(0.53);
  self show();
  self vibrate(vectorscale((0, 1, 0), 270), 0.2, 0.4, 0.4);
}

function get_closest_2d(origin, ents) {
  if(!isDefined(ents)) {
    return undefined;
  }
  dist = distance2d(origin, ents[0].origin);
  index = 0;
  temp_array = [];
  for(i = 1; i < ents.size; i++) {
    if(isDefined(ents[i].unbroken) && ents[i].unbroken == 1) {
      ents[i].index = i;
      if(!isDefined(temp_array)) {
        temp_array = [];
      } else if(!isarray(temp_array)) {
        temp_array = array(temp_array);
      }
      temp_array[temp_array.size] = ents[i];
    }
  }
  if(temp_array.size > 0) {
    index = temp_array[randomintrange(0, temp_array.size)].index;
    return ents[index];
  }
  for(i = 1; i < ents.size; i++) {
    temp_dist = distance2d(origin, ents[i].origin);
    if(temp_dist < dist) {
      dist = temp_dist;
      index = i;
    }
  }
  return ents[index];
}

function in_playable_area() {
  playable_area = getEntArray("player_volume", "script_noteworthy");
  if(!isDefined(playable_area)) {
    println("");
    return true;
  }
  for(i = 0; i < playable_area.size; i++) {
    if(self istouching(playable_area[i])) {
      return true;
    }
  }
  return false;
}

function get_closest_non_destroyed_chunk(origin, barrier, barrier_chunks) {
  chunks = undefined;
  chunks_grate = undefined;
  chunks_grate = get_non_destroyed_chunks_grate(barrier, barrier_chunks);
  chunks = get_non_destroyed_chunks(barrier, barrier_chunks);
  if(isDefined(barrier.zbarrier)) {
    if(isDefined(chunks)) {
      return array::randomize(chunks)[0];
    }
    if(isDefined(chunks_grate)) {
      return array::randomize(chunks_grate)[0];
    }
  } else {
    if(isDefined(chunks)) {
      return non_destroyed_bar_board_order(origin, chunks);
    }
    if(isDefined(chunks_grate)) {
      return non_destroyed_grate_order(origin, chunks_grate);
    }
  }
  return undefined;
}

function get_random_destroyed_chunk(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    ret = undefined;
    pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
    if(pieces.size) {
      ret = array::randomize(pieces)[0];
    }
    return ret;
  }
  chunk = undefined;
  chunks_repair_grate = undefined;
  chunks = get_destroyed_chunks(barrier_chunks);
  chunks_repair_grate = get_destroyed_repair_grates(barrier_chunks);
  if(isDefined(chunks)) {
    return chunks[randomint(chunks.size)];
  }
  if(isDefined(chunks_repair_grate)) {
    return grate_order_destroyed(chunks_repair_grate);
  }
  return undefined;
}

function get_destroyed_repair_grates(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i])) {
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate") {
        array[array.size] = barrier_chunks[i];
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

function get_non_destroyed_chunks(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    return barrier.zbarrier getzbarrierpieceindicesinstate("closed");
  }
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "classic_boards") {
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board") {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
    }
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "new_barricade") {
      if(isDefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "repair_board" || barrier_chunks[i].script_parameters == "barricade_vents")) {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
      continue;
    }
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "6_bars_bent") {
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar") {
        if(barrier_chunks[i] get_chunk_state() == "repaired") {
          if(barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
            array[array.size] = barrier_chunks[i];
          }
        }
      }
      continue;
    }
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "6_bars_prestine") {
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar") {
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

function get_non_destroyed_chunks_grate(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    return barrier.zbarrier getzbarrierpieceindicesinstate("closed");
  }
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate") {
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

function get_non_destroyed_variant1(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant1") {
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

function get_non_destroyed_variant2(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant2") {
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

function get_non_destroyed_variant4(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant4") {
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

function get_non_destroyed_variant5(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(isDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant5") {
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

function get_destroyed_chunks(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i] get_chunk_state() == "destroyed") {
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board") {
        array[array.size] = barrier_chunks[i];
        continue;
      }
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "repair_board" || barrier_chunks[i].script_parameters == "barricade_vents") {
        array[array.size] = barrier_chunks[i];
        continue;
      }
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar") {
        array[array.size] = barrier_chunks[i];
        continue;
      }
      if(isDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate") {
        return undefined;
      }
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

function grate_order_destroyed(chunks_repair_grate) {
  grate_repair_order = [];
  grate_repair_order1 = [];
  grate_repair_order2 = [];
  grate_repair_order3 = [];
  grate_repair_order4 = [];
  grate_repair_order5 = [];
  grate_repair_order6 = [];
  for(i = 0; i < chunks_repair_grate.size; i++) {
    if(isDefined(chunks_repair_grate[i].script_parameters) && chunks_repair_grate[i].script_parameters == "grate") {
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "1") {
        grate_repair_order1[grate_repair_order1.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "2") {
        grate_repair_order2[grate_repair_order2.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "3") {
        grate_repair_order3[grate_repair_order3.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "4") {
        grate_repair_order4[grate_repair_order4.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "5") {
        grate_repair_order5[grate_repair_order5.size] = chunks_repair_grate[i];
      }
      if(isDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "6") {
        grate_repair_order6[grate_repair_order6.size] = chunks_repair_grate[i];
      }
    }
  }
  for(i = 0; i < chunks_repair_grate.size; i++) {
    if(isDefined(chunks_repair_grate[i].script_parameters) && chunks_repair_grate[i].script_parameters == "grate") {
      if(isDefined(grate_repair_order1[i])) {
        if(grate_repair_order6[i].state == "destroyed") {
          iprintlnbold("");
          return grate_repair_order6[i];
        }
        if(grate_repair_order5[i].state == "destroyed") {
          iprintlnbold("");
          grate_repair_order6[i] thread show_grate_repair();
          return grate_repair_order5[i];
        }
        if(grate_repair_order4[i].state == "destroyed") {
          iprintlnbold("");
          grate_repair_order5[i] thread show_grate_repair();
          return grate_repair_order4[i];
        }
        if(grate_repair_order3[i].state == "destroyed") {
          iprintlnbold("");
          grate_repair_order4[i] thread show_grate_repair();
          return grate_repair_order3[i];
        }
        if(grate_repair_order2[i].state == "destroyed") {
          iprintlnbold("");
          grate_repair_order3[i] thread show_grate_repair();
          return grate_repair_order2[i];
        }
        if(grate_repair_order1[i].state == "destroyed") {
          iprintlnbold("");
          grate_repair_order2[i] thread show_grate_repair();
          return grate_repair_order1[i];
        }
      }
    }
  }
}

function show_grate_repair() {
  wait(0.34);
  self hide();
}

function get_chunk_state() {
  assert(isDefined(self.state));
  return self.state;
}

function array_limiter(array, total) {
  new_array = [];
  for(i = 0; i < array.size; i++) {
    if(i < total) {
      new_array[new_array.size] = array[i];
    }
  }
  return new_array;
}

function fake_physicslaunch(target_pos, power) {
  start_pos = self.origin;
  gravity = getdvarint("bg_gravity") * -1;
  dist = distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  drop = (0.5 * gravity) * (time * time);
  velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
  level thread draw_line_ent_to_pos(self, target_pos);
  self movegravity(velocity, time);
  return time;
}

function add_zombie_hint(ref, text) {
  if(!isDefined(level.zombie_hints)) {
    level.zombie_hints = [];
  }
  level.zombie_hints[ref] = text;
}

function get_zombie_hint(ref) {
  if(isDefined(level.zombie_hints[ref])) {
    return level.zombie_hints[ref];
  }
  println("" + ref);
  return level.zombie_hints["undefined"];
}

function set_hint_string(ent, default_ref, cost) {
  ref = default_ref;
  if(isDefined(ent.script_hint)) {
    ref = ent.script_hint;
  }
  if(isDefined(level.legacy_hint_system) && level.legacy_hint_system) {
    ref = (ref + "_") + cost;
    self sethintstring(get_zombie_hint(ref));
  } else {
    hint = get_zombie_hint(ref);
    if(isDefined(cost)) {
      self sethintstring(hint, cost);
    } else {
      self sethintstring(hint);
    }
  }
}

function get_hint_string(ent, default_ref, cost) {
  ref = default_ref;
  if(isDefined(ent.script_hint)) {
    ref = ent.script_hint;
  }
  if(isDefined(level.legacy_hint_system) && level.legacy_hint_system && isDefined(cost)) {
    ref = (ref + "_") + cost;
  }
  return get_zombie_hint(ref);
}

function unitrigger_set_hint_string(ent, default_ref, cost) {
  triggers = [];
  if(self.trigger_per_player) {
    triggers = self.playertrigger;
  } else {
    triggers[0] = self.trigger;
  }
  foreach(trigger in triggers) {
    ref = default_ref;
    if(isDefined(ent.script_hint)) {
      ref = ent.script_hint;
    }
    if(isDefined(level.legacy_hint_system) && level.legacy_hint_system) {
      ref = (ref + "_") + cost;
      trigger sethintstring(get_zombie_hint(ref));
      continue;
    }
    hint = get_zombie_hint(ref);
    if(isDefined(cost)) {
      trigger sethintstring(hint, cost);
      continue;
    }
    trigger sethintstring(hint);
  }
}

function add_sound(ref, alias) {
  if(!isDefined(level.zombie_sounds)) {
    level.zombie_sounds = [];
  }
  level.zombie_sounds[ref] = alias;
}

function play_sound_at_pos(ref, pos, ent) {
  if(isDefined(ent)) {
    if(isDefined(ent.script_soundalias)) {
      playsoundatposition(ent.script_soundalias, pos);
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
    assertmsg(("" + ref) + "");
    return;
  }
  playsoundatposition(level.zombie_sounds[ref], pos);
}

function play_sound_on_ent(ref) {
  if(isDefined(self.script_soundalias)) {
    self playSound(self.script_soundalias);
    return;
  }
  if(isDefined(self.script_sound)) {
    ref = self.script_sound;
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    assertmsg(("" + ref) + "");
    return;
  }
  self playSound(level.zombie_sounds[ref]);
}

function play_loopsound_on_ent(ref) {
  if(isDefined(self.script_firefxsound)) {
    ref = self.script_firefxsound;
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    assertmsg(("" + ref) + "");
    return;
  }
  self playSound(level.zombie_sounds[ref]);
}

function string_to_float(string) {
  floatparts = strtok(string, ".");
  if(floatparts.size == 1) {
    return int(floatparts[0]);
  }
  whole = int(floatparts[0]);
  decimal = 0;
  for(i = floatparts[1].size - 1; i >= 0; i--) {
    decimal = (decimal / 10) + (int(floatparts[1][i]) / 10);
  }
  if(whole >= 0) {
    return whole + decimal;
  }
  return whole - decimal;
}

function set_zombie_var(zvar, value, is_float = 0, column = 1, is_team_based) {
  if(isDefined(is_team_based) && is_team_based) {
    foreach(team in level.teams) {
      level.zombie_vars[team][zvar] = value;
    }
  } else {
    level.zombie_vars[zvar] = value;
  }
  return value;
}

function get_table_var(table = "mp/zombiemode.csv", var_d45c761e, value, is_float = 0, column = 1) {
  table_value = tablelookup(table, 0, var_d45c761e, column);
  if(isDefined(table_value) && table_value != "") {
    if(is_float) {
      value = string_to_float(table_value);
    } else {
      value = int(table_value);
    }
  }
  return value;
}

function hudelem_count() {
  max = 0;
  curr_total = 0;
  while(true) {
    if(level.hudelem_count > max) {
      max = level.hudelem_count;
    }
    println(((("" + level.hudelem_count) + "") + max) + "");
    wait(0.05);
  }
}

function debug_round_advancer() {
  while(true) {
    zombs = zombie_utility::get_round_enemy_array();
    for(i = 0; i < zombs.size; i++) {
      zombs[i] dodamage(zombs[i].health + 666, (0, 0, 0));
      wait(0.5);
    }
  }
}

function print_run_speed(speed) {
  self endon("death");
  while(true) {
    print3d(self.origin + vectorscale((0, 0, 1), 64), speed, (1, 1, 1));
    wait(0.05);
  }
}

function draw_line_ent_to_ent(ent1, ent2) {
  if(getdvarint("") != 1) {
    return;
  }
  ent1 endon("death");
  ent2 endon("death");
  while(true) {
    line(ent1.origin, ent2.origin);
    wait(0.05);
  }
}

function draw_line_ent_to_pos(ent, pos, end_on) {
  if(getdvarint("") != 1) {
    return;
  }
  ent endon("death");
  ent notify("stop_draw_line_ent_to_pos");
  ent endon("stop_draw_line_ent_to_pos");
  if(isDefined(end_on)) {
    ent endon(end_on);
  }
  while(true) {
    line(ent.origin, pos);
    wait(0.05);
  }
}

function debug_print(msg) {
  if(getdvarint("") > 0) {
    println("" + msg);
  }
}

function debug_blocker(pos, rad, height) {
  self notify("stop_debug_blocker");
  self endon("stop_debug_blocker");
  for(;;) {
    if(getdvarint("") != 1) {
      return;
    }
    wait(0.05);
    drawcylinder(pos, rad, height);
  }
}

function drawcylinder(pos, rad, height) {
  currad = rad;
  curheight = height;
  for(r = 0; r < 20; r++) {
    theta = (r / 20) * 360;
    theta2 = ((r + 1) / 20) * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
  }
}

function print3d_at_pos(msg, pos, thread_endon, offset) {
  self endon("death");
  if(isDefined(thread_endon)) {
    self notify(thread_endon);
    self endon(thread_endon);
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  while(true) {
    print3d(self.origin + offset, msg);
    wait(0.05);
  }
}

function debug_breadcrumbs() {
  self endon("disconnect");
  self notify("stop_debug_breadcrumbs");
  self endon("stop_debug_breadcrumbs");
  while(true) {
    if(getdvarint("") != 1) {
      wait(1);
      continue;
    }
    for(i = 0; i < self.zombie_breadcrumbs.size; i++) {
      drawcylinder(self.zombie_breadcrumbs[i], 5, 5);
    }
    wait(0.05);
  }
}

function debug_attack_spots_taken() {
  self notify("stop_debug_breadcrumbs");
  self endon("stop_debug_breadcrumbs");
  while(true) {
    if(getdvarint("") != 2) {
      wait(1);
      continue;
    }
    wait(0.05);
    count = 0;
    for(i = 0; i < self.attack_spots_taken.size; i++) {
      if(self.attack_spots_taken[i]) {
        count++;
        circle(self.attack_spots[i], 12, (1, 0, 0), 0, 1, 1);
        continue;
      }
      circle(self.attack_spots[i], 12, (0, 1, 0), 0, 1, 1);
    }
    msg = (("" + count) + "") + self.attack_spots_taken.size;
    print3d(self.origin, msg);
  }
}

function float_print3d(msg, time) {
  self endon("death");
  time = gettime() + (time * 1000);
  offset = vectorscale((0, 0, 1), 72);
  while(gettime() < time) {
    offset = offset + vectorscale((0, 0, 1), 2);
    print3d(self.origin + offset, msg, (1, 1, 1));
    wait(0.05);
  }
}

function do_player_vo(snd, variation_count) {
  index = get_player_index(self);
  sound = (("zmb_vox_plr_" + index) + "_") + snd;
  if(isDefined(variation_count)) {
    sound = (sound + "_") + randomintrange(0, variation_count);
  }
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(level.player_is_speaking == 0) {
    level.player_is_speaking = 1;
    self playsoundwithnotify(sound, "sound_done");
    self waittill("sound_done");
    wait(2);
    level.player_is_speaking = 0;
  }
}

function is_magic_bullet_shield_enabled(ent) {
  if(!isDefined(ent)) {
    return 0;
  }
  return !(isDefined(ent.allowdeath) && ent.allowdeath);
}

function really_play_2d_sound(sound) {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playsoundwithnotify(sound, sound + "wait");
  temp_ent waittill(sound + "wait");
  wait(0.05);
  temp_ent delete();
}

function play_sound_2d(sound) {
  level thread really_play_2d_sound(sound);
}

function include_weapon(weapon_name, in_box) {
  println("" + weapon_name);
  if(!isDefined(in_box)) {
    in_box = 1;
  }
  zm_weapons::include_zombie_weapon(weapon_name, in_box);
}

function trigger_invisible(enable) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      self setinvisibletoplayer(players[i], enable);
    }
  }
}

function print3d_ent(text, color, scale, offset, end_msg, overwrite) {
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
    scale = 1;
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  if(isDefined(end_msg)) {
    self endon(end_msg);
  }
  self._debug_print3d_msg = text;
  while(!(isDefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
    print3d(self.origin + offset, self._debug_print3d_msg, color, scale);
    wait(0.05);
  }
}

function create_counter_hud(x = 0) {
  hud = create_simple_hud();
  hud.alignx = "left";
  hud.aligny = "top";
  hud.horzalign = "user_left";
  hud.vertalign = "user_top";
  hud.color = (1, 1, 1);
  hud.fontscale = 32;
  hud.x = x;
  hud.alpha = 0;
  hud setshader("hud_chalk_1", 64, 64);
  return hud;
}

function get_current_zone(return_zone) {
  level flag::wait_till("zones_initialized");
  if(isDefined(self.cached_zone)) {
    zone = self.cached_zone;
    zone_name = self.cached_zone_name;
    vol = self.cached_zone_volume;
    if(self istouching(zone.volumes[vol])) {
      if(isDefined(return_zone) && return_zone) {
        return zone;
      }
      return zone_name;
    }
    for(i = 0; i < zone.volumes.size; i++) {
      if(i == vol) {
        continue;
      }
      if(self istouching(zone.volumes[i])) {
        self.cached_zone = zone;
        self.cached_zone_volume = i;
        if(isDefined(return_zone) && return_zone) {
          return zone;
        }
        return zone_name;
      }
    }
  }
  for(z = 0; z < level.zone_keys.size; z++) {
    zone_name = level.zone_keys[z];
    zone = level.zones[zone_name];
    if(zone === self.cached_zone) {
      continue;
    }
    for(i = 0; i < zone.volumes.size; i++) {
      if(self istouching(zone.volumes[i])) {
        self.cached_zone = zone;
        self.cached_zone_name = zone_name;
        self.cached_zone_volume = i;
        if(isDefined(return_zone) && return_zone) {
          return zone;
        }
        return zone_name;
      }
    }
  }
  self.cached_zone = undefined;
  self.cached_zone_name = undefined;
  self.cached_zone_volume = undefined;
  return undefined;
}

function remove_mod_from_methodofdeath(mod) {
  return mod;
}

function clear_fog_threads() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] notify("stop_fog");
  }
}

function display_message(titletext, notifytext, duration) {
  notifydata = spawnStruct();
  notifydata.titletext = notifytext;
  notifydata.notifytext = titletext;
  notifydata.sound = "mus_level_up";
  notifydata.duration = duration;
  notifydata.glowcolor = (1, 0, 0);
  notifydata.color = (0, 0, 0);
  notifydata.iconname = "hud_zombies_meat";
  self thread hud_message::notifymessage(notifydata);
}

function is_quad() {
  return self.animname == "quad_zombie";
}

function is_leaper() {
  return self.animname == "leaper_zombie";
}

function shock_onpain() {
  self endon("death");
  self endon("disconnect");
  self notify("stop_shock_onpain");
  self endon("stop_shock_onpain");
  if(getdvarstring("blurpain") == "") {
    setdvar("blurpain", "on");
  }
  while(true) {
    oldhealth = self.health;
    self waittill("damage", damage, attacker, direction_vec, point, mod);
    if(isDefined(level.shock_onpain) && !level.shock_onpain) {
      continue;
    }
    if(isDefined(self.shock_onpain) && !self.shock_onpain) {
      continue;
    }
    if(self.health < 1) {
      continue;
    }
    if(isDefined(attacker) && isDefined(attacker.custom_player_shellshock)) {
      self[[attacker.custom_player_shellshock]](damage, attacker, direction_vec, point, mod);
    } else {
      if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH") {
        continue;
      } else {
        if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE") {
          shocktype = undefined;
          shocklight = undefined;
          if(isDefined(self.is_burning) && self.is_burning) {
            shocktype = "lava";
            shocklight = "lava_small";
          }
          self shock_onexplosion(damage, shocktype, shocklight);
        } else if(getdvarstring("blurpain") == "on") {
          self shellshock("pain_zm", 0.5);
        }
      }
    }
  }
}

function shock_onexplosion(damage, shocktype, shocklight) {
  time = 0;
  scaled_damage = (100 * damage) / self.maxhealth;
  if(scaled_damage >= 90) {
    time = 4;
  } else {
    if(scaled_damage >= 50) {
      time = 3;
    } else {
      if(scaled_damage >= 25) {
        time = 2;
      } else if(scaled_damage > 10) {
        time = 1;
      }
    }
  }
  if(time) {
    if(!isDefined(shocktype)) {
      shocktype = "explosion";
    }
    self shellshock(shocktype, time);
  } else if(isDefined(shocklight)) {
    self shellshock(shocklight, time);
  }
}

function increment_ignoreme() {
  if(!isDefined(self.ignorme_count)) {
    self.ignorme_count = 0;
  }
  self.ignorme_count++;
  self.ignoreme = self.ignorme_count > 0;
}

function decrement_ignoreme() {
  if(!isDefined(self.ignorme_count)) {
    self.ignorme_count = 0;
  }
  if(self.ignorme_count > 0) {
    self.ignorme_count--;
  } else {
    assertmsg("");
  }
  self.ignoreme = self.ignorme_count > 0;
}

function increment_is_drinking() {
  if(isDefined(level.devgui_dpad_watch) && level.devgui_dpad_watch) {
    self.is_drinking++;
    return;
  }
  if(!isDefined(self.is_drinking)) {
    self.is_drinking = 0;
  }
  if(self.is_drinking == 0) {
    self disableoffhandweapons();
    self disableweaponcycling();
  }
  self.is_drinking++;
}

function is_multiple_drinking() {
  return self.is_drinking > 1;
}

function decrement_is_drinking() {
  if(self.is_drinking > 0) {
    self.is_drinking--;
  } else {
    assertmsg("");
  }
  if(self.is_drinking == 0) {
    self enableoffhandweapons();
    self enableweaponcycling();
  }
}

function clear_is_drinking() {
  self.is_drinking = 0;
  self enableoffhandweapons();
  self enableweaponcycling();
}

function increment_no_end_game_check() {
  if(!isDefined(level.n_no_end_game_check_count)) {
    level.n_no_end_game_check_count = 0;
  }
  level.n_no_end_game_check_count++;
  level.no_end_game_check = level.n_no_end_game_check_count > 0;
}

function decrement_no_end_game_check() {
  if(!isDefined(level.n_no_end_game_check_count)) {
    level.n_no_end_game_check_count = 0;
  }
  if(level.n_no_end_game_check_count > 0) {
    level.n_no_end_game_check_count--;
  } else {
    assertmsg("");
  }
  level.no_end_game_check = level.n_no_end_game_check_count > 0;
  if(!level.no_end_game_check) {
    level zm::checkforalldead();
  }
}

function getweaponclasszm(weapon) {
  assert(isDefined(weapon));
  if(!isDefined(weapon)) {
    return undefined;
  }
  if(!isDefined(level.weaponclassarray)) {
    level.weaponclassarray = [];
  }
  if(isDefined(level.weaponclassarray[weapon])) {
    return level.weaponclassarray[weapon];
  }
  baseweaponindex = getbaseweaponitemindex(weapon);
  statstablename = util::getstatstablename();
  weaponclass = tablelookup(statstablename, 0, baseweaponindex, 2);
  level.weaponclassarray[weapon] = weaponclass;
  return weaponclass;
}

function spawn_weapon_model(weapon, model = weapon.worldmodel, origin, angles, options) {
  weapon_model = spawn("script_model", origin);
  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }
  if(isDefined(options)) {
    weapon_model useweaponmodel(weapon, model, options);
  } else {
    weapon_model useweaponmodel(weapon, model);
  }
  return weapon_model;
}

function spawn_buildkit_weapon_model(player, weapon, camo, origin, angles) {
  weapon_model = spawn("script_model", origin);
  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }
  upgraded = zm_weapons::is_weapon_upgraded(weapon);
  if(upgraded && (!isDefined(camo) || 0 > camo)) {
    camo = zm_weapons::get_pack_a_punch_camo_index(undefined);
  }
  weapon_model usebuildkitweaponmodel(player, weapon, camo, upgraded);
  return weapon_model;
}

function is_player_revive_tool(weapon) {
  if(weapon == level.weaponrevivetool || weapon === self.weaponrevivetool) {
    return true;
  }
  return false;
}

function is_limited_weapon(weapon) {
  if(isDefined(level.limited_weapons) && isDefined(level.limited_weapons[weapon])) {
    return true;
  }
  return false;
}

function register_lethal_grenade_for_level(weaponname) {
  weapon = getweapon(weaponname);
  if(is_lethal_grenade(weapon)) {
    return;
  }
  if(!isDefined(level.zombie_lethal_grenade_list)) {
    level.zombie_lethal_grenade_list = [];
  }
  level.zombie_lethal_grenade_list[weapon] = weapon;
}

function is_lethal_grenade(weapon) {
  if(!isDefined(weapon) || !isDefined(level.zombie_lethal_grenade_list)) {
    return 0;
  }
  return isDefined(level.zombie_lethal_grenade_list[weapon]);
}

function is_player_lethal_grenade(weapon) {
  if(!isDefined(weapon) || !isDefined(self.current_lethal_grenade)) {
    return 0;
  }
  return self.current_lethal_grenade == weapon;
}

function get_player_lethal_grenade() {
  grenade = level.weaponnone;
  if(isDefined(self.current_lethal_grenade)) {
    grenade = self.current_lethal_grenade;
  }
  return grenade;
}

function set_player_lethal_grenade(weapon = level.weaponnone) {
  self notify("new_lethal_grenade", weapon);
  self.current_lethal_grenade = weapon;
}

function init_player_lethal_grenade() {
  self set_player_lethal_grenade(level.zombie_lethal_grenade_player_init);
}

function register_tactical_grenade_for_level(weaponname) {
  weapon = getweapon(weaponname);
  if(is_tactical_grenade(weapon)) {
    return;
  }
  if(!isDefined(level.zombie_tactical_grenade_list)) {
    level.zombie_tactical_grenade_list = [];
  }
  level.zombie_tactical_grenade_list[weapon] = weapon;
}

function is_tactical_grenade(weapon) {
  if(!isDefined(weapon) || !isDefined(level.zombie_tactical_grenade_list)) {
    return 0;
  }
  return isDefined(level.zombie_tactical_grenade_list[weapon]);
}

function is_player_tactical_grenade(weapon) {
  if(!isDefined(weapon) || !isDefined(self.current_tactical_grenade)) {
    return 0;
  }
  return self.current_tactical_grenade == weapon;
}

function get_player_tactical_grenade() {
  tactical = level.weaponnone;
  if(isDefined(self.current_tactical_grenade)) {
    tactical = self.current_tactical_grenade;
  }
  return tactical;
}

function set_player_tactical_grenade(weapon = level.weaponnone) {
  self notify("new_tactical_grenade", weapon);
  self.current_tactical_grenade = weapon;
}

function init_player_tactical_grenade() {
  self set_player_tactical_grenade(level.zombie_tactical_grenade_player_init);
}

function is_placeable_mine(weapon) {
  if(!isDefined(level.placeable_mines)) {
    level.placeable_mines = [];
  }
  if(!isDefined(weapon) || weapon == level.weaponnone) {
    return 0;
  }
  return isDefined(level.placeable_mines[weapon.name]);
}

function is_player_placeable_mine(weapon) {
  if(!isDefined(weapon) || !isDefined(self.current_placeable_mine)) {
    return 0;
  }
  return self.current_placeable_mine == weapon;
}

function get_player_placeable_mine() {
  placeable_mine = level.weaponnone;
  if(isDefined(self.current_placeable_mine)) {
    placeable_mine = self.current_placeable_mine;
  }
  return placeable_mine;
}

function set_player_placeable_mine(weapon = level.weaponnone) {
  self notify("new_placeable_mine", weapon);
  self.current_placeable_mine = weapon;
}

function init_player_placeable_mine() {
  self set_player_placeable_mine(level.zombie_placeable_mine_player_init);
}

function register_melee_weapon_for_level(weaponname) {
  weapon = getweapon(weaponname);
  if(is_melee_weapon(weapon)) {
    return;
  }
  if(!isDefined(level.zombie_melee_weapon_list)) {
    level.zombie_melee_weapon_list = [];
  }
  level.zombie_melee_weapon_list[weapon] = weapon;
}

function is_melee_weapon(weapon) {
  if(!isDefined(weapon) || !isDefined(level.zombie_melee_weapon_list) || weapon == getweapon("none")) {
    return 0;
  }
  return isDefined(level.zombie_melee_weapon_list[weapon]);
}

function is_player_melee_weapon(weapon) {
  if(!isDefined(weapon) || !isDefined(self.current_melee_weapon)) {
    return 0;
  }
  return self.current_melee_weapon == weapon;
}

function get_player_melee_weapon() {
  melee_weapon = level.weaponnone;
  if(isDefined(self.current_melee_weapon)) {
    melee_weapon = self.current_melee_weapon;
  }
  return melee_weapon;
}

function set_player_melee_weapon(weapon = level.weaponnone) {
  self notify("new_melee_weapon", weapon);
  self.current_melee_weapon = weapon;
}

function init_player_melee_weapon() {
  self set_player_melee_weapon(level.zombie_melee_weapon_player_init);
}

function register_hero_weapon_for_level(weaponname) {
  weapon = getweapon(weaponname);
  if(is_hero_weapon(weapon)) {
    return;
  }
  if(!isDefined(level.zombie_hero_weapon_list)) {
    level.zombie_hero_weapon_list = [];
  }
  level.zombie_hero_weapon_list[weapon] = weapon;
}

function is_hero_weapon(weapon) {
  if(!isDefined(weapon) || !isDefined(level.zombie_hero_weapon_list)) {
    return 0;
  }
  return isDefined(level.zombie_hero_weapon_list[weapon]);
}

function is_player_hero_weapon(weapon) {
  if(!isDefined(weapon) || !isDefined(self.current_hero_weapon)) {
    return 0;
  }
  return self.current_hero_weapon == weapon;
}

function get_player_hero_weapon() {
  hero_weapon = level.weaponnone;
  if(isDefined(self.current_hero_weapon)) {
    hero_weapon = self.current_hero_weapon;
  }
  return hero_weapon;
}

function set_player_hero_weapon(weapon = level.weaponnone) {
  self notify("new_hero_weapon", weapon);
  self.current_hero_weapon = weapon;
}

function init_player_hero_weapon() {
  self set_player_hero_weapon(level.zombie_hero_weapon_player_init);
}

function has_player_hero_weapon() {
  return isDefined(self.current_hero_weapon) && self.current_hero_weapon != level.weaponnone;
}

function should_watch_for_emp() {
  return isDefined(level.should_watch_for_emp) && level.should_watch_for_emp;
}

function register_offhand_weapons_for_level_defaults() {
  if(isDefined(level.register_offhand_weapons_for_level_defaults_override)) {
    [[level.register_offhand_weapons_for_level_defaults_override]]();
    return;
  }
  register_lethal_grenade_for_level("frag_grenade");
  level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
  register_tactical_grenade_for_level("cymbal_monkey");
  level.zombie_tactical_grenade_player_init = undefined;
  level.zombie_placeable_mine_player_init = undefined;
  register_melee_weapon_for_level("knife");
  register_melee_weapon_for_level("bowie_knife");
  level.zombie_melee_weapon_player_init = getweapon("knife");
  level.zombie_equipment_player_init = undefined;
}

function init_player_offhand_weapons() {
  init_player_lethal_grenade();
  init_player_tactical_grenade();
  init_player_placeable_mine();
  init_player_melee_weapon();
  init_player_hero_weapon();
  zm_equipment::init_player_equipment();
}

function is_offhand_weapon(weapon) {
  return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || zm_equipment::is_equipment(weapon);
}

function is_player_offhand_weapon(weapon) {
  return self is_player_lethal_grenade(weapon) || self is_player_tactical_grenade(weapon) || self is_player_placeable_mine(weapon) || self is_player_melee_weapon(weapon) || self is_player_hero_weapon(weapon) || self zm_equipment::is_player_equipment(weapon);
}

function has_powerup_weapon() {
  return isDefined(self.has_powerup_weapon) && self.has_powerup_weapon;
}

function has_hero_weapon() {
  weapon = self getcurrentweapon();
  return isDefined(weapon.isheroweapon) && weapon.isheroweapon;
}

function give_start_weapon(b_switch_weapon) {
  if(!isDefined(self.hascompletedsuperee)) {
    self.hascompletedsuperee = self zm_stats::get_global_stat("DARKOPS_GENESIS_SUPER_EE") > 0;
  }
  if(self.hascompletedsuperee) {
    self zm_weapons::weapon_give(level.start_weapon, 0, 0, 1, 0);
    self givemaxammo(level.start_weapon);
    self zm_weapons::weapon_give(level.super_ee_weapon, 0, 0, 1, b_switch_weapon);
  } else {
    self zm_weapons::weapon_give(level.start_weapon, 0, 0, 1, b_switch_weapon);
  }
}

function array_flag_wait_any(flag_array) {
  if(!isDefined(level._array_flag_wait_any_calls)) {
    level._n_array_flag_wait_any_calls = 0;
  } else {
    level._n_array_flag_wait_any_calls++;
  }
  str_condition = "array_flag_wait_call_" + level._n_array_flag_wait_any_calls;
  for(index = 0; index < flag_array.size; index++) {
    level thread array_flag_wait_any_thread(flag_array[index], str_condition);
  }
  level waittill(str_condition);
}

function array_flag_wait_any_thread(flag_name, condition) {
  level endon(condition);
  level flag::wait_till(flag_name);
  level notify(condition);
}

function groundpos(origin) {
  return bulletTrace(origin, origin + (vectorscale((0, 0, -1), 100000)), 0, self)["position"];
}

function groundpos_ignore_water(origin) {
  return bulletTrace(origin, origin + (vectorscale((0, 0, -1), 100000)), 0, self, 1)["position"];
}

function groundpos_ignore_water_new(origin) {
  return groundtrace(origin, origin + (vectorscale((0, 0, -1), 100000)), 0, self, 1)["position"];
}

function self_delete() {
  if(isDefined(self)) {
    self delete();
  }
}

function ignore_triggers(timer) {
  self endon("death");
  self.ignoretriggers = 1;
  if(isDefined(timer)) {
    wait(timer);
  } else {
    wait(0.5);
  }
  self.ignoretriggers = 0;
}

function giveachievement_wrapper(achievement, all_players) {
  if(achievement == "") {
    return;
  }
  if(isDefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
    return;
  }
  achievement_lower = tolower(achievement);
  global_counter = 0;
  if(isDefined(all_players) && all_players) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      players[i] giveachievement(achievement);
      has_achievement = 0;
      if(!(isDefined(has_achievement) && has_achievement)) {
        global_counter++;
      }
      if(issplitscreen() && i == 0 || !issplitscreen()) {
        if(isDefined(level.achievement_sound_func)) {
          players[i] thread[[level.achievement_sound_func]](achievement_lower);
        }
      }
    }
  } else {
    if(!isplayer(self)) {
      println("");
      return;
    }
    self giveachievement(achievement);
    has_achievement = 0;
    if(!(isDefined(has_achievement) && has_achievement)) {
      global_counter++;
    }
    if(isDefined(level.achievement_sound_func)) {
      self thread[[level.achievement_sound_func]](achievement_lower);
    }
  }
  if(global_counter) {
    incrementcounter("global_" + achievement_lower, global_counter);
  }
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function disable_react() {
  assert(isalive(self), "");
  self.a.disablereact = 1;
  self.allowreact = 0;
}

function enable_react() {
  assert(isalive(self), "");
  self.a.disablereact = 0;
  self.allowreact = 1;
}

function bullet_attack(type) {
  if(type == "MOD_PISTOL_BULLET") {
    return 1;
  }
  return type == "MOD_RIFLE_BULLET";
}

function pick_up() {
  player = self.owner;
  self destroy_ent();
  clip_ammo = player getweaponammoclip(self.weapon);
  clip_max_ammo = self.weapon.clipsize;
  if(clip_ammo < clip_max_ammo) {
    clip_ammo++;
  }
  player setweaponammoclip(self.weapon, clip_ammo);
}

function destroy_ent() {
  self delete();
}

function waittill_not_moving() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  if(self.classname == "grenade") {
    self waittill("stationary");
  } else {
    prevorigin = self.origin;
    while(true) {
      wait(0.15);
      if(self.origin == prevorigin) {
        break;
      }
      prevorigin = self.origin;
    }
  }
}

function get_closest_player(org) {
  players = [];
  players = getplayers();
  return arraygetclosest(org, players);
}

function ent_flag_init_ai_standards() {
  message_array = [];
  message_array[message_array.size] = "goal";
  message_array[message_array.size] = "damage";
  for(i = 0; i < message_array.size; i++) {
    self flag::init(message_array[i]);
    self thread ent_flag_wait_ai_standards(message_array[i]);
  }
}

function ent_flag_wait_ai_standards(message) {
  self endon("death");
  self waittill(message);
  self.ent_flag[message] = 1;
}

function flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

function clear_run_anim() {
  self.alwaysrunforward = undefined;
  self.a.combatrunanim = undefined;
  self.run_noncombatanim = undefined;
  self.walk_combatanim = undefined;
  self.walk_noncombatanim = undefined;
  self.precombatrunenabled = 1;
}

function track_players_intersection_tracker() {
  self endon("disconnect");
  self endon("death");
  level endon("end_game");
  wait(5);
  while(true) {
    killed_players = 0;
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(players[i] laststand::player_is_in_laststand() || "playing" != players[i].sessionstate) {
        continue;
      }
      for(j = 0; j < players.size; j++) {
        if(i == j || players[j] laststand::player_is_in_laststand() || "playing" != players[j].sessionstate) {
          continue;
        }
        if(isDefined(level.player_intersection_tracker_override)) {
          if(players[i][
              [level.player_intersection_tracker_override]
            ](players[j])) {
            continue;
          }
        }
        playeri_origin = players[i].origin;
        playerj_origin = players[j].origin;
        if((abs(playeri_origin[2] - playerj_origin[2])) > 60) {
          continue;
        }
        distance_apart = distance2d(playeri_origin, playerj_origin);
        if(abs(distance_apart) > 18) {
          continue;
        }
        iprintlnbold("");
        players[i] dodamage(1000, (0, 0, 0));
        players[j] dodamage(1000, (0, 0, 0));
        if(!killed_players) {
          players[i] playlocalsound(level.zmb_laugh_alias);
        }
        players[i] zm_stats::increment_map_cheat_stat("cheat_too_friendly");
        players[i] zm_stats::increment_client_stat("cheat_too_friendly", 0);
        players[i] zm_stats::increment_client_stat("cheat_total", 0);
        players[j] zm_stats::increment_map_cheat_stat("cheat_too_friendly");
        players[j] zm_stats::increment_client_stat("cheat_too_friendly", 0);
        players[j] zm_stats::increment_client_stat("cheat_total", 0);
        killed_players = 1;
      }
    }
    wait(0.5);
  }
}

function is_player_looking_at(origin, dot, do_trace, ignore_ent) {
  assert(isplayer(self), "");
  if(!isDefined(dot)) {
    dot = 0.7;
  }
  if(!isDefined(do_trace)) {
    do_trace = 1;
  }
  eye = self util::get_eye();
  delta_vec = anglesToForward(vectortoangles(origin - eye));
  view_vec = anglesToForward(self getplayerangles());
  new_dot = vectordot(delta_vec, view_vec);
  if(new_dot >= dot) {
    if(do_trace) {
      return bullettracepassed(origin, eye, 0, ignore_ent);
    }
    return 1;
  }
  return 0;
}

function add_gametype(gt, dummy1, name, dummy2) {}

function add_gameloc(gl, dummy1, name, dummy2) {}

function get_closest_index(org, array, dist = 9999999) {
  distsq = dist * dist;
  if(array.size < 1) {
    return;
  }
  index = undefined;
  for(i = 0; i < array.size; i++) {
    newdistsq = distancesquared(array[i].origin, org);
    if(newdistsq >= distsq) {
      continue;
    }
    distsq = newdistsq;
    index = i;
  }
  return index;
}

function is_valid_zombie_spawn_point(point) {
  liftedorigin = point.origin + vectorscale((0, 0, 1), 5);
  size = 48;
  height = 64;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  absmins = liftedorigin + mins;
  absmaxs = liftedorigin + maxs;
  if(boundswouldtelefrag(absmins, absmaxs)) {
    return false;
  }
  return true;
}

function get_closest_index_to_entity(entity, array, dist, extra_check) {
  org = entity.origin;
  if(!isDefined(dist)) {
    dist = 9999999;
  }
  distsq = dist * dist;
  if(array.size < 1) {
    return;
  }
  index = undefined;
  for(i = 0; i < array.size; i++) {
    if(isDefined(extra_check) && ![
        [extra_check]
      ](entity, array[i])) {
      continue;
    }
    newdistsq = distancesquared(array[i].origin, org);
    if(newdistsq >= distsq) {
      continue;
    }
    distsq = newdistsq;
    index = i;
  }
  return index;
}

function set_gamemode_var(gvar, val) {
  if(!isDefined(game["gamemode_match"])) {
    game["gamemode_match"] = [];
  }
  game["gamemode_match"][gvar] = val;
}

function set_gamemode_var_once(gvar, val) {
  if(!isDefined(game["gamemode_match"])) {
    game["gamemode_match"] = [];
  }
  if(!isDefined(game["gamemode_match"][gvar])) {
    game["gamemode_match"][gvar] = val;
  }
}

function set_game_var(gvar, val) {
  game[gvar] = val;
}

function set_game_var_once(gvar, val) {
  if(!isDefined(game[gvar])) {
    game[gvar] = val;
  }
}

function get_game_var(gvar) {
  if(isDefined(game[gvar])) {
    return game[gvar];
  }
  return undefined;
}

function get_gamemode_var(gvar) {
  if(isDefined(game["gamemode_match"]) && isDefined(game["gamemode_match"][gvar])) {
    return game["gamemode_match"][gvar];
  }
  return undefined;
}

function waittill_subset(min_num, string1, string2, string3, string4, string5) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;
  returned_threads = 0;
  if(isDefined(string1)) {
    self thread util::waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(string2)) {
    self thread util::waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(string3)) {
    self thread util::waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(string4)) {
    self thread util::waittill_string(string4, ent);
    ent.threads++;
  }
  if(isDefined(string5)) {
    self thread util::waittill_string(string5, ent);
    ent.threads++;
  }
  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
    returned_threads++;
    if(returned_threads >= min_num) {
      break;
    }
  }
  ent notify("die");
}

function is_headshot(weapon, shitloc, smeansofdeath) {
  if(!isDefined(shitloc)) {
    return 0;
  }
  if(shitloc != "head" && shitloc != "helmet") {
    return 0;
  }
  if(smeansofdeath == "MOD_IMPACT" && weapon.isballisticknife) {
    return 1;
  }
  return smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_UNKNOWN";
}

function is_jumping() {
  ground_ent = self getgroundent();
  return !isDefined(ground_ent);
}

function is_explosive_damage(mod) {
  if(!isDefined(mod)) {
    return false;
  }
  if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
    return true;
  }
  return false;
}

function sndswitchannouncervox(who) {
  switch (who) {
    case "sam": {
      game["zmbdialog"]["prefix"] = "vox_zmba_sam";
      level.zmb_laugh_alias = "zmb_laugh_sam";
      level.sndannouncerisrich = 0;
      break;
    }
  }
}

function do_player_general_vox(category, type, timer, chance) {
  if(isDefined(timer) && isDefined(level.votimer[type]) && level.votimer[type] > 0) {
    return;
  }
  self thread zm_audio::create_and_play_dialog(category, type);
  if(isDefined(timer)) {
    level.votimer[type] = timer;
    level thread general_vox_timer(level.votimer[type], type);
  }
}

function general_vox_timer(timer, type) {
  level endon("end_game");
  println(((("" + type) + "") + timer) + "");
  while(timer > 0) {
    wait(1);
    timer--;
  }
  level.votimer[type] = timer;
  println(((("" + type) + "") + timer) + "");
}

function create_vox_timer(type) {
  level.votimer[type] = 0;
}

function play_vox_to_player(category, type, force_variant) {}

function is_favorite_weapon(weapon_to_check) {
  if(!isDefined(self.favorite_wall_weapons_list)) {
    return false;
  }
  foreach(weapon in self.favorite_wall_weapons_list) {
    if(weapon_to_check == weapon) {
      return true;
    }
  }
  return false;
}

function add_vox_response_chance(event, chance) {
  level.response_chances[event] = chance;
}

function set_demo_intermission_point() {
  spawnpoints = getEntArray("mp_global_intermission", "classname");
  if(!spawnpoints.size) {
    return;
  }
  spawnpoint = spawnpoints[0];
  match_string = "";
  location = level.scr_zm_map_start_location;
  if(location == "default" || location == "" && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }
  match_string = (level.scr_zm_ui_gametype + "_") + location;
  for(i = 0; i < spawnpoints.size; i++) {
    if(isDefined(spawnpoints[i].script_string)) {
      tokens = strtok(spawnpoints[i].script_string, " ");
      foreach(token in tokens) {
        if(token == match_string) {
          spawnpoint = spawnpoints[i];
          i = spawnpoints.size;
          break;
        }
      }
    }
  }
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
}

function register_map_navcard(navcard_on_map, navcard_needed_for_computer) {
  level.navcard_needed = navcard_needed_for_computer;
  level.map_navcard = navcard_on_map;
}

function does_player_have_map_navcard(player) {
  return player zm_stats::get_global_stat(level.map_navcard);
}

function does_player_have_correct_navcard(player) {
  if(!isDefined(level.navcard_needed)) {
    return 0;
  }
  return player zm_stats::get_global_stat(level.navcard_needed);
}

function place_navcard(str_model, str_stat, org, angles) {
  navcard = spawn("script_model", org);
  navcard setModel(str_model);
  navcard.angles = angles;
  wait(1);
  navcard_pickup_trig = spawn("trigger_radius_use", org, 0, 84, 72);
  navcard_pickup_trig setcursorhint("HINT_NOICON");
  navcard_pickup_trig sethintstring(&"ZOMBIE_NAVCARD_PICKUP");
  navcard_pickup_trig triggerignoreteam();
  a_navcard_stats = array("navcard_held_zm_transit", "navcard_held_zm_highrise", "navcard_held_zm_buried");
  is_holding_card = 0;
  str_placing_stat = undefined;
  while(true) {
    navcard_pickup_trig waittill("trigger", who);
    if(is_player_valid(who)) {
      foreach(str_cur_stat in a_navcard_stats) {
        if(who zm_stats::get_global_stat(str_cur_stat)) {
          str_placing_stat = str_cur_stat;
          is_holding_card = 1;
          who zm_stats::set_global_stat(str_cur_stat, 0);
        }
      }
      who playSound("zmb_buildable_piece_add");
      who zm_stats::set_global_stat(str_stat, 1);
      who.navcard_grabbed = str_stat;
      util::wait_network_frame();
      is_stat = who zm_stats::get_global_stat(str_stat);
      thread sq_refresh_player_navcard_hud();
      break;
    }
  }
  navcard delete();
  navcard_pickup_trig delete();
  if(is_holding_card) {
    level thread place_navcard(str_model, str_placing_stat, org, angles);
  }
}

function sq_refresh_player_navcard_hud() {
  if(!isDefined(level.navcards)) {
    return;
  }
  players = getplayers();
  foreach(player in players) {
    player thread sq_refresh_player_navcard_hud_internal();
  }
}

function sq_refresh_player_navcard_hud_internal() {
  self endon("disconnect");
  navcard_bits = 0;
  for(i = 0; i < level.navcards.size; i++) {
    hasit = self zm_stats::get_global_stat(level.navcards[i]);
    if(isDefined(self.navcard_grabbed) && self.navcard_grabbed == level.navcards[i]) {
      hasit = 1;
    }
    if(hasit) {
      navcard_bits = navcard_bits + (1 << i);
    }
  }
  util::wait_network_frame();
  self clientfield::set("navcard_held", 0);
  if(navcard_bits > 0) {
    util::wait_network_frame();
    self clientfield::set("navcard_held", navcard_bits);
  }
}

function disable_player_move_states(forcestancechange) {
  self allowcrouch(1);
  self allowlean(0);
  self allowads(0);
  self allowsprint(0);
  self allowprone(0);
  self allowmelee(0);
  if(isDefined(forcestancechange) && forcestancechange == 1) {
    if(self getstance() == "prone") {
      self setstance("crouch");
    }
  }
}

function enable_player_move_states() {
  if(!isDefined(self._allow_lean) || self._allow_lean == 1) {
    self allowlean(1);
  }
  if(!isDefined(self._allow_ads) || self._allow_ads == 1) {
    self allowads(1);
  }
  if(!isDefined(self._allow_sprint) || self._allow_sprint == 1) {
    self allowsprint(1);
  }
  if(!isDefined(self._allow_prone) || self._allow_prone == 1) {
    self allowprone(1);
  }
  if(!isDefined(self._allow_melee) || self._allow_melee == 1) {
    self allowmelee(1);
  }
}

function check_and_create_node_lists() {
  if(!isDefined(level._link_node_list)) {
    level._link_node_list = [];
  }
  if(!isDefined(level._unlink_node_list)) {
    level._unlink_node_list = [];
  }
}

function link_nodes(a, b, bdontunlinkonmigrate = 0) {
  if(nodesarelinked(a, b)) {
    return;
  }
  check_and_create_node_lists();
  a_index_string = "" + a.origin;
  b_index_string = "" + b.origin;
  if(!isDefined(level._link_node_list[a_index_string])) {
    level._link_node_list[a_index_string] = spawnStruct();
    level._link_node_list[a_index_string].node = a;
    level._link_node_list[a_index_string].links = [];
    level._link_node_list[a_index_string].ignore_on_migrate = [];
  }
  if(!isDefined(level._link_node_list[a_index_string].links[b_index_string])) {
    level._link_node_list[a_index_string].links[b_index_string] = b;
    level._link_node_list[a_index_string].ignore_on_migrate[b_index_string] = bdontunlinkonmigrate;
  }
  if(isDefined(level._unlink_node_list[a_index_string])) {
    if(isDefined(level._unlink_node_list[a_index_string].links[b_index_string])) {
      level._unlink_node_list[a_index_string].links[b_index_string] = undefined;
      level._unlink_node_list[a_index_string].ignore_on_migrate[b_index_string] = undefined;
    }
  }
  linknodes(a, b);
}

function unlink_nodes(a, b, bdontlinkonmigrate = 0) {
  if(!nodesarelinked(a, b)) {
    return;
  }
  check_and_create_node_lists();
  a_index_string = "" + a.origin;
  b_index_string = "" + b.origin;
  if(!isDefined(level._unlink_node_list[a_index_string])) {
    level._unlink_node_list[a_index_string] = spawnStruct();
    level._unlink_node_list[a_index_string].node = a;
    level._unlink_node_list[a_index_string].links = [];
    level._unlink_node_list[a_index_string].ignore_on_migrate = [];
  }
  if(!isDefined(level._unlink_node_list[a_index_string].links[b_index_string])) {
    level._unlink_node_list[a_index_string].links[b_index_string] = b;
    level._unlink_node_list[a_index_string].ignore_on_migrate[b_index_string] = bdontlinkonmigrate;
  }
  if(isDefined(level._link_node_list[a_index_string])) {
    if(isDefined(level._link_node_list[a_index_string].links[b_index_string])) {
      level._link_node_list[a_index_string].links[b_index_string] = undefined;
      level._link_node_list[a_index_string].ignore_on_migrate[b_index_string] = undefined;
    }
  }
  unlinknodes(a, b);
}

function spawn_path_node(origin, angles, k1, v1, k2, v2) {
  if(!isDefined(level._spawned_path_nodes)) {
    level._spawned_path_nodes = [];
  }
  node = spawnStruct();
  node.origin = origin;
  node.angles = angles;
  node.k1 = k1;
  node.v1 = v1;
  node.k2 = k2;
  node.v2 = v2;
  node.node = spawn_path_node_internal(origin, angles, k1, v1, k2, v2);
  level._spawned_path_nodes[level._spawned_path_nodes.size] = node;
  return node.node;
}

function spawn_path_node_internal(origin, angles, k1, v1, k2, v2) {
  if(isDefined(k2)) {
    return spawnpathnode("node_pathnode", origin, angles, k1, v1, k2, v2);
  }
  if(isDefined(k1)) {
    return spawnpathnode("node_pathnode", origin, angles, k1, v1);
  }
  return spawnpathnode("node_pathnode", origin, angles);
}

function delete_spawned_path_nodes() {}

function respawn_path_nodes() {
  if(!isDefined(level._spawned_path_nodes)) {
    return;
  }
  for(i = 0; i < level._spawned_path_nodes.size; i++) {
    node_struct = level._spawned_path_nodes[i];
    println("" + node_struct.origin);
    node_struct.node = spawn_path_node_internal(node_struct.origin, node_struct.angles, node_struct.k1, node_struct.v1, node_struct.k2, node_struct.v2);
  }
}

function link_changes_internal_internal(list, func) {
  keys = getarraykeys(list);
  for(i = 0; i < keys.size; i++) {
    node = list[keys[i]].node;
    node_keys = getarraykeys(list[keys[i]].links);
    for(j = 0; j < node_keys.size; j++) {
      if(isDefined(list[keys[i]].links[node_keys[j]])) {
        if(isDefined(list[keys[i]].ignore_on_migrate[node_keys[j]]) && list[keys[i]].ignore_on_migrate[node_keys[j]]) {
          println(((("" + keys[i]) + "") + node_keys[j]) + "");
          continue;
        }
        println((("" + keys[i]) + "") + node_keys[j]);
        # / [[func]](node, list[keys[i]].links[node_keys[j]]);
      }
    }
  }
}

function link_changes_internal(func_for_link_list, func_for_unlink_list) {
  if(isDefined(level._link_node_list)) {
    println("");
    link_changes_internal_internal(level._link_node_list, func_for_link_list);
  }
  if(isDefined(level._unlink_node_list)) {
    println("");
    link_changes_internal_internal(level._unlink_node_list, func_for_unlink_list);
  }
}

function link_nodes_wrapper(a, b) {
  if(!nodesarelinked(a, b)) {
    linknodes(a, b);
  }
}

function unlink_nodes_wrapper(a, b) {
  if(nodesarelinked(a, b)) {
    unlinknodes(a, b);
  }
}

function undo_link_changes() {
  println("");
  println("");
  println("");
  link_changes_internal(&unlink_nodes_wrapper, &link_nodes_wrapper);
  delete_spawned_path_nodes();
}

function redo_link_changes() {
  println("");
  println("");
  println("");
  respawn_path_nodes();
  link_changes_internal(&link_nodes_wrapper, &unlink_nodes_wrapper);
}

function is_gametype_active(a_gametypes) {
  b_is_gametype_active = 0;
  if(!isarray(a_gametypes)) {
    a_gametypes = array(a_gametypes);
  }
  for(i = 0; i < a_gametypes.size; i++) {
    if(getdvarstring("g_gametype") == a_gametypes[i]) {
      b_is_gametype_active = 1;
    }
  }
  return b_is_gametype_active;
}

function register_custom_spawner_entry(spot_noteworthy, func) {
  if(!isDefined(level.custom_spawner_entry)) {
    level.custom_spawner_entry = [];
  }
  level.custom_spawner_entry[spot_noteworthy] = func;
}

function get_player_weapon_limit(player) {
  if(isDefined(self.get_player_weapon_limit)) {
    return [[self.get_player_weapon_limit]](player);
  }
  if(isDefined(level.get_player_weapon_limit)) {
    return [[level.get_player_weapon_limit]](player);
  }
  weapon_limit = 2;
  if(player hasperk("specialty_additionalprimaryweapon")) {
    weapon_limit = level.additionalprimaryweapon_limit;
  }
  return weapon_limit;
}

function get_player_perk_purchase_limit() {
  n_perk_purchase_limit_override = level.perk_purchase_limit;
  if(isDefined(level.get_player_perk_purchase_limit)) {
    n_perk_purchase_limit_override = self[[level.get_player_perk_purchase_limit]]();
  }
  return n_perk_purchase_limit_override;
}

function can_player_purchase_perk() {
  if(self.num_perks < self get_player_perk_purchase_limit()) {
    return true;
  }
  if(self bgb::is_enabled("zm_bgb_unquenchable") || self bgb::is_enabled("zm_bgb_soda_fountain")) {
    return true;
  }
  return false;
}

function give_player_all_perks(b_exclude_quick_revive = 0) {
  a_str_perks = getarraykeys(level._custom_perks);
  foreach(str_perk in a_str_perks) {
    if(str_perk == "specialty_quickrevive" && b_exclude_quick_revive) {
      continue;
    }
    if(!self hasperk(str_perk)) {
      self zm_perks::give_perk(str_perk, 0);
      if(isDefined(level.perk_bought_func)) {
        self[[level.perk_bought_func]](str_perk);
      }
    }
  }
}

function wait_for_attractor_positions_complete() {
  self waittill("attractor_positions_generated");
  self.attract_to_origin = 0;
}

function get_player_index(player) {
  assert(isplayer(player));
  assert(isDefined(player.characterindex));
  if(player.entity_num == 0 && getdvarstring("") != "") {
    new_vo_index = getdvarint("");
    return new_vo_index;
  }
  return player.characterindex;
}

function get_specific_character(n_character_index) {
  foreach(character in level.players) {
    if(character.characterindex == n_character_index) {
      return character;
    }
  }
  return undefined;
}

function zombie_goto_round(n_target_round) {
  level notify("restart_round");
  if(n_target_round < 1) {
    n_target_round = 1;
  }
  level.zombie_total = 0;
  zombie_utility::ai_calculate_health(n_target_round);
  zm::set_round_number(n_target_round - 1);
  zombies = zombie_utility::get_round_enemy_array();
  if(isDefined(zombies)) {
    array::run_all(zombies, &kill);
  }
  level.sndgotoroundoccurred = 1;
  level waittill("between_round_over");
}

function is_point_inside_enabled_zone(v_origin, ignore_zone) {
  temp_ent = spawn("script_origin", v_origin);
  foreach(zone in level.zones) {
    if(!zone.is_enabled) {
      continue;
    }
    if(isDefined(ignore_zone) && zone == ignore_zone) {
      continue;
    }
    foreach(e_volume in zone.volumes) {
      if(temp_ent istouching(e_volume)) {
        temp_ent delete();
        return true;
      }
    }
  }
  temp_ent delete();
  return false;
}

function clear_streamer_hint() {
  if(isDefined(self.streamer_hint)) {
    self.streamer_hint delete();
    self.streamer_hint = undefined;
  }
  self notify("wait_clear_streamer_hint");
}

function wait_clear_streamer_hint(lifetime) {
  self endon("wait_clear_streamer_hint");
  wait(lifetime);
  if(isDefined(self)) {
    self clear_streamer_hint();
  }
}

function create_streamer_hint(origin, angles, value, lifetime) {
  if(self == level) {
    foreach(player in getplayers()) {
      player clear_streamer_hint();
    }
  }
  self clear_streamer_hint();
  self.streamer_hint = createstreamerhint(origin, value);
  if(isDefined(angles)) {
    self.streamer_hint.angles = angles;
  }
  if(self != level) {
    self.streamer_hint setinvisibletoall();
    self.streamer_hint setvisibletoplayer(self);
  }
  self.streamer_hint setincludemeshes(1);
  self notify("wait_clear_streamer_hint");
  if(isDefined(lifetime) && lifetime > 0) {
    self thread wait_clear_streamer_hint(lifetime);
  }
}

function approximate_path_dist(player) {
  aiprofile_beginentry("approximate_path_dist");
  goal_pos = player.origin;
  if(isDefined(player.last_valid_position)) {
    goal_pos = player.last_valid_position;
  }
  if(isDefined(player.b_teleporting) && player.b_teleporting) {
    if(isDefined(player.teleport_location)) {
      goal_pos = player.teleport_location;
      if(!ispointonnavmesh(goal_pos, self)) {
        position = getclosestpointonnavmesh(goal_pos, 100, 15);
        if(isDefined(position)) {
          goal_pos = position;
        }
      }
    }
  }
  assert(isDefined(level.pathdist_type), "");
  approx_dist = pathdistance(self.origin, goal_pos, 1, self, level.pathdist_type);
  aiprofile_endentry();
  return approx_dist;
}

function register_slowdown(str_type, n_rate, n_duration) {
  if(!isDefined(level.a_n_slowdown_rates)) {
    level.a_n_slowdown_rates = [];
  }
  level.a_s_slowdowns[str_type] = spawnStruct();
  level.a_s_slowdowns[str_type].n_rate = n_rate;
  level.a_s_slowdowns[str_type].n_duration = n_duration;
}

function slowdown_ai(str_type) {
  self notify("starting_slowdown_ai");
  self endon("starting_slowdown_ai");
  self endon("death");
  assert(isDefined(level.a_s_slowdowns[str_type]), ("" + str_type) + "");
  if(!isDefined(self.a_n_slowdown_timeouts)) {
    self.a_n_slowdown_timeouts = [];
  }
  n_time = gettime();
  n_timeout = n_time + level.a_s_slowdowns[str_type].n_duration;
  if(!isDefined(self.a_n_slowdown_timeouts[str_type]) || self.a_n_slowdown_timeouts[str_type] < n_timeout) {
    self.a_n_slowdown_timeouts[str_type] = n_timeout;
  }
  while(self.a_n_slowdown_timeouts.size) {
    str_lowest_type = undefined;
    n_lowest_rate = 10;
    foreach(str_index, n_slowdown_timeout in self.a_n_slowdown_timeouts) {
      if(n_slowdown_timeout <= n_time) {
        self.a_n_slowdown_timeouts[str_index] = undefined;
        continue;
      }
      if(level.a_s_slowdowns[str_index].n_rate < n_lowest_rate) {
        str_lowest_type = str_index;
        n_lowest_rate = level.a_s_slowdowns[str_index].n_rate;
      }
    }
    if(isDefined(str_lowest_type)) {
      self asmsetanimationrate(n_lowest_rate);
      n_duration = self.a_n_slowdown_timeouts[str_lowest_type] - n_time;
      wait(n_duration);
      self.a_n_slowdown_timeouts[str_lowest_type] = undefined;
    }
  }
  self asmsetanimationrate(1);
}

function get_player_closest_to(e_target) {
  a_players = arraycopy(level.activeplayers);
  arrayremovevalue(a_players, e_target);
  e_closest_player = arraygetclosest(e_target.origin, a_players);
  return e_closest_player;
}

function is_facing(facee, requireddot = 0.5, b_2d = 1) {
  orientation = self getplayerangles();
  v_forward = anglesToForward(orientation);
  v_to_facee = facee.origin - self.origin;
  if(b_2d) {
    v_forward_computed = (v_forward[0], v_forward[1], 0);
    v_to_facee_computed = (v_to_facee[0], v_to_facee[1], 0);
  } else {
    v_forward_computed = v_forward;
    v_to_facee_computed = v_to_facee;
  }
  v_unit_forward_computed = vectornormalize(v_forward_computed);
  v_unit_to_facee_computed = vectornormalize(v_to_facee_computed);
  dotproduct = vectordot(v_unit_forward_computed, v_unit_to_facee_computed);
  return dotproduct > requireddot;
}

function is_solo_ranked_game() {
  return level.players.size == 1 && getdvarint("zm_private_rankedmatch", 0);
}

function upload_zm_dash_counters(force_upload = 0) {
  if(!sessionmodeisonlinegame()) {
    return;
  }
  if(isDefined(level.var_e097db22) && level.var_e097db22 || (isDefined(force_upload) && force_upload)) {
    util::function_ad904acd();
  }
  level.var_e097db22 = undefined;
}

function upload_zm_dash_counters_end_game() {
  foreach(player in getplayers()) {
    if(player flag::exists("finished_reporting_consumables")) {
      player flag::wait_till("finished_reporting_consumables");
    }
  }
  if(level flag::exists("consumables_reported") && level flag::get("consumables_reported")) {
    increment_zm_dash_counter("end_reported_consumables", 1);
  }
  upload_zm_dash_counters(1);
}

function increment_zm_dash_counter(counter_name, amount) {
  if(!sessionmodeisonlinegame()) {
    return;
  }
  counter_name = function_62f3bbf4(counter_name);
  level.var_e097db22 = 1;
  util::function_a4c90358(counter_name, amount);
}

function function_62f3bbf4(counter_name) {
  var_fa7fbeaf = "zm_dash_";
  if(is_solo_ranked_game()) {
    var_fa7fbeaf = var_fa7fbeaf + "solo_";
  } else {
    var_fa7fbeaf = var_fa7fbeaf + "coop_";
  }
  var_fa7fbeaf = var_fa7fbeaf + counter_name;
  return var_fa7fbeaf;
}

function private function_8eb96012(ishost, var_95597467, var_88b8e8ec) {
  path = spawnStruct();
  path.hosted = (ishost ? "HOSTED" : "PLAYED");
  path.var_95597467 = (var_95597467 ? "USED" : "UNUSED");
  path.var_c0cf8114 = (var_88b8e8ec ? "SOLO" : "COOP");
  return path;
}

function private function_9878c818(var_fabefe22, statname) {
  return self getdstat("dashboardingTrackingHistory", "gameSizeHistory", var_fabefe22.var_c0cf8114, "consumablesHistory", var_fabefe22.var_95597467, "periodHistory", var_fabefe22.hosted, statname);
}

function private function_96c1b925(var_fabefe22, statname, value) {
  self adddstat("dashboardingTrackingHistory", "gameSizeHistory", var_fabefe22.var_c0cf8114, "consumablesHistory", var_fabefe22.var_95597467, "periodHistory", var_fabefe22.hosted, statname, value);
  self adddstat("dashboardingTrackingHistory", "statsSinceLastComscoreEvent", statname, value);
}

function private function_e33a692a(type) {
  var_44222444 = self getdstat("dashboardingTrackingHistory", "currentDashboardingTrackingHistoryIndex");
  self setdstat("dashboardingTrackingHistory", "quitType", var_44222444, type);
  var_36d3e544 = (var_44222444 + 1) % 32;
  if(var_36d3e544 == 0) {
    self setdstat("dashboardingTrackingHistory", "bufferFull", 1);
  }
  self setdstat("dashboardingTrackingHistory", "currentDashboardingTrackingHistoryIndex", var_36d3e544);
}

function zm_dash_stats_game_start() {
  if(!(sessionmodeisonlinegame() && getdvarint("zm_dash_stats_enable_tracking", 0))) {
    return;
  }
  level flag::wait_till("all_players_connected");
  self setdstat("dashboardingTrackingHistory", "trackedFirstGame", 1);
  var_fabefe22 = function_8eb96012(self ishost(), 0, is_solo_ranked_game());
  self function_96c1b925(var_fabefe22, "started", 1);
  self setdstat("dashboardingTrackingHistory", "lastGameWasHosted", self ishost());
  self setdstat("dashboardingTrackingHistory", "lastGameUsedConsumable", 0);
  self setdstat("dashboardingTrackingHistory", "lastGameWasCoop", !is_solo_ranked_game());
  uploadstats(self);
}

function zm_dash_stats_game_end() {
  if(!(sessionmodeisonlinegame() && getdvarint("zm_dash_stats_enable_tracking", 0))) {
    return;
  }
  var_822c3017 = self getdstat("dashboardingTrackingHistory", "lastGameWasHosted");
  var_f4d48599 = self getdstat("dashboardingTrackingHistory", "lastGameUsedConsumable");
  var_44d1dba9 = self getdstat("dashboardingTrackingHistory", "lastGameWasCoop");
  var_fabefe22 = function_8eb96012(var_822c3017, var_f4d48599, !var_44d1dba9);
  self function_96c1b925(var_fabefe22, "completed", 1);
  self function_e33a692a(4);
}

function zm_dash_stats_wait_for_consumable_use() {
  if(!(sessionmodeisonlinegame() && getdvarint("zm_dash_stats_enable_tracking", 0))) {
    return;
  }
  self endon("disconnect");
  self flag::wait_till("used_consumable");
  self setdstat("dashboardingTrackingHistory", "lastGameUsedConsumable", 1);
  var_9eb8805a = self getdstat("dashboardingTrackingHistory", "lastGameWasHosted");
  var_b47e6298 = self getdstat("dashboardingTrackingHistory", "lastGameWasCoop");
  var_ab363340 = function_8eb96012(var_9eb8805a, 0, !var_b47e6298);
  var_c084221 = function_8eb96012(var_9eb8805a, 1, !var_b47e6298);
  self function_96c1b925(var_ab363340, "started", -1);
  self function_96c1b925(var_c084221, "started", 1);
  uploadstats(self);
}