/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_utility.gsc
***********************************************/

#include scripts\abilities\ability_util;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_ai_faller;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_camos;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_maptable;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_server_throttle;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_utility;

autoexec __init__system__() {
  system::register(#"zm_utility", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int");
  clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int");
  clientfield::register("actor", "flame_corpse_fx", 1, 1, "int");
  clientfield::register("actor", "zombie_eye_glow", 1, 1, "int");
}

__main__() {}

init_utility() {
  level thread check_solo_status();
}

is_classic() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"zclassic") {
    return true;
  }

  return false;
}

is_standard() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"zstandard") {
    return true;
  }

  return false;
}

is_trials() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"ztrials" || level flag::exists(#"ztrial")) {
    return true;
  }

  return false;
}

is_tutorial() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"ztutorial") {
    return true;
  }

  return false;
}

is_grief() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"zgrief") {
    return true;
  }

  return false;
}

function_d6046228(str_classic, var_756ee4e5, var_bcb9de3e, var_299ea954, str_trials, var_1e31f083) {
  if(is_trials()) {
    if(function_8b1a219a() && isDefined(var_1e31f083)) {
      return var_1e31f083;
    } else if(isDefined(str_trials)) {
      return str_trials;
    }
  } else if(is_standard()) {
    if(function_8b1a219a() && isDefined(var_299ea954)) {
      return var_299ea954;
    } else if(isDefined(var_bcb9de3e)) {
      return var_bcb9de3e;
    }
  }

  if(function_8b1a219a() && isDefined(var_756ee4e5)) {
    return var_756ee4e5;
  }

  return str_classic;
}

get_cast() {
  return zm_maptable::get_cast();
}

get_story() {
  return zm_maptable::get_story();
}

check_solo_status() {
  if(getnumexpectedplayers() == 1 && (!sessionmodeisonlinegame() || !sessionmodeisprivate() || zm_trial::is_trial_mode())) {
    level.is_forever_solo_game = 1;
    return;
  }

  level.is_forever_solo_game = 0;
}

init_zombie_run_cycle() {
  if(isDefined(level.speed_change_round)) {
    if(!isDefined(self._starting_round_number)) {
      self._starting_round_number = level.round_number;
    }

    if(self._starting_round_number >= level.speed_change_round) {
      speed_percent = 0.2 + (self._starting_round_number - level.speed_change_round) * 0.2;
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

change_zombie_run_cycle() {
  level.speed_change_num++;

  if(level.gamedifficulty == 0) {
    self zombie_utility::set_zombie_run_cycle("sprint");
  } else {
    self zombie_utility::set_zombie_run_cycle("run");
  }

  self thread speed_change_watcher();
}

make_supersprinter() {
  self zombie_utility::set_zombie_run_cycle("super_sprint");
}

speed_change_watcher() {
  self waittill(#"death");

  if(level.speed_change_num > 0) {
    level.speed_change_num--;
  }
}

move_zombie_spawn_location(spot) {
  self endon(#"death");

  if(isDefined(self.spawn_pos)) {
    self notify(#"risen", {
      #find_flesh_struct_string: self.spawn_pos.script_string
    });
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
      self.anchor waittill(#"movedone");
      target_org = zombie_utility::get_desired_origin();

      if(isDefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill(#"rotatedone");
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

      self notify(#"risen", {
        #find_flesh_struct_string: spot.script_string
      });
    }
  }
}

anchor_delete_failsafe(ai_zombie) {
  ai_zombie endon(#"risen");
  ai_zombie waittill(#"death");

  if(isDefined(self)) {
    self delete();
  }
}

all_chunks_intact(barrier, barrier_chunks) {
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

no_valid_repairable_boards(barrier, barrier_chunks) {
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

is_survival() {
  return false;
}

is_encounter() {
  return false;
}

all_chunks_destroyed(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    pieces = arraycombine(barrier.zbarrier getzbarrierpieceindicesinstate("open"), barrier.zbarrier getzbarrierpieceindicesinstate("opening"), 1, 0);

    if(pieces.size != barrier.zbarrier getnumzbarrierpieces()) {
      return false;
    }
  } else if(isDefined(barrier_chunks)) {
    assert(isDefined(barrier_chunks), "<dev string:x38>");

    for(i = 0; i < barrier_chunks.size; i++) {
      if(barrier_chunks[i] get_chunk_state() != "destroyed") {
        return false;
      }
    }
  }

  return true;
}

check_point_in_playable_area(origin) {
  if(function_21f4ac36() && !isDefined(level.var_a2a9b2de)) {
    level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
  }

  if(function_c85ebbbc() && !isDefined(level.playable_area)) {
    level.playable_area = getEntArray("player_volume", "script_noteworthy");
  }

  valid_point = 0;

  if(isDefined(level.var_a2a9b2de)) {
    node = function_52c1730(origin + (0, 0, 40), level.var_a2a9b2de, 500);

    if(isDefined(node)) {
      valid_point = 1;
    }
  }

  if(isDefined(level.playable_area) && !valid_point) {
    if(!isDefined(level.check_model)) {
      level.check_model = spawn("script_model", origin + (0, 0, 40));
    } else {
      level.check_model.origin = origin + (0, 0, 40);
    }

    for(i = 0; i < level.playable_area.size; i++) {
      if(level.check_model istouching(level.playable_area[i])) {
        valid_point = 1;
        break;
      }
    }
  }

  return valid_point;
}

check_point_in_enabled_zone(origin, zone_is_active, player_zones, player_regions) {
  if(isDefined(level.var_304d38af) && ![[level.var_304d38af]](origin)) {
    return 0;
  }

  if(function_c85ebbbc() && !isDefined(level.playable_area)) {
    level.playable_area = getEntArray("player_volume", "script_noteworthy");
  }

  if(!isDefined(player_zones)) {
    player_zones = level.playable_area;
  }

  if(function_21f4ac36() && !isDefined(level.player_regions)) {
    level.player_regions = getnodearray("player_region", "script_noteworthy");
  }

  if(!isDefined(player_regions)) {
    player_regions = level.player_regions;
  }

  if(!isDefined(level.zones) || !isDefined(player_zones) && !isDefined(player_regions)) {
    return 1;
  }

  one_valid_zone = 0;

  if(isDefined(player_regions)) {
    node = function_52c1730(origin + (0, 0, 40), player_regions, 500);

    if(isDefined(node)) {
      zone = level.zones[node.targetname];

      if(isDefined(zone) && isDefined(zone.is_enabled) && zone.is_enabled) {
        if(zone_is_active === 1 && !(isDefined(zone.is_active) && zone.is_active)) {
          one_valid_zone = 0;
        } else {
          one_valid_zone = 1;
        }
      }
    }
  }

  if(isDefined(player_zones) && !one_valid_zone) {
    if(!isDefined(level.e_check_point)) {
      level.e_check_point = spawn("script_origin", origin + (0, 0, 40));
    } else {
      level.e_check_point.origin = origin + (0, 0, 40);
    }

    for(i = 0; i < player_zones.size; i++) {
      zone = level.zones[player_zones[i].targetname];

      if(isDefined(zone) && isDefined(zone.is_enabled) && zone.is_enabled) {
        if(isDefined(zone_is_active) && zone_is_active == 1 && !(isDefined(zone.is_active) && zone.is_active)) {
          continue;
        }

        if(level.e_check_point istouching(player_zones[i])) {
          one_valid_zone = 1;
          break;
        }
      }
    }
  }

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

halve_score(n_score) {
  n_score /= 2;
  n_score = round_up_score(n_score, 10);
  return n_score;
}

create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on, initial_attract_func, arrival_attract_func, poi_team) {
  if(!is_point_inside_enabled_zone(self.origin)) {
    return;
  }

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

watch_for_poi_death() {
  self waittill(#"death");

  if(isinarray(level.zombie_poi_array, self)) {
    arrayremovevalue(level.zombie_poi_array, self);
  }
}

debug_draw_new_attractor_positions() {
  self endon(#"death");

  while(true) {
    foreach(attract in self.attractor_positions) {
      passed = bullettracepassed(attract[0] + (0, 0, 24), self.origin + (0, 0, 24), 0, self);

      if(passed) {

        debugstar(attract[0], 6, (1, 1, 1));

          continue;
      }

      debugstar(attract[0], 6, (1, 0, 0));

    }

    waitframe(1);
  }
}

create_zombie_point_of_interest_attractor_positions(var_b09c2334 = 15, n_height = 60, var_6b5dd73c, var_7262d151 = 0) {
  self endon(#"death");

  if(!isDefined(self.num_poi_attracts) || isDefined(self.script_noteworthy) && self.script_noteworthy != "zombie_poi") {
    return false;
  }

  queryresult = positionquery_source_navigation(self.origin, var_b09c2334 / 2, isDefined(var_6b5dd73c) ? var_6b5dd73c : self.max_attractor_dist, n_height / 2, var_b09c2334 / 2, 1, var_b09c2334 / 2);

  if(var_7262d151) {
    var_7162cf15 = getclosestpointonnavmesh(self.origin, var_6b5dd73c);
  } else {
    var_7162cf15 = getclosestpointonnavmesh(self.origin);
  }

  if(!isDefined(var_7162cf15)) {
    return false;
  }

  if(queryresult.data.size < self.num_poi_attracts) {
    self.num_poi_attracts = queryresult.data.size;
  }

  position_index = 0;

  for(i = 0; i < queryresult.data.size; i++) {
    if(!tracepassedonnavmesh(var_7162cf15, queryresult.data[i].origin, 15)) {

      if(isDefined(level.var_565d6ce0) && level.var_565d6ce0) {
        recordstar(queryresult.data[i].origin, (1, 0, 0));
        record3dtext("<dev string:x7a>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
      }

        continue;
    }

    if(isDefined(level.validate_poi_attractors) && level.validate_poi_attractors) {
      passed = bullettracepassed(queryresult.data[i].origin + (0, 0, 24), self.origin + (0, 0, 24), 0, self);

      if(passed) {
        self.attractor_positions[position_index] = queryresult.data[i].origin;
        position_index++;
      } else {

        if(isDefined(level.var_565d6ce0) && level.var_565d6ce0) {
          recordstar(queryresult.data[i].origin, (1, 0, 0));
          record3dtext("<dev string:x91>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
        }

      }
    } else if(isDefined(self.var_abfcb0d9) && self.var_abfcb0d9) {
      if(check_point_in_enabled_zone(queryresult.data[i].origin) && check_point_in_playable_area(queryresult.data[i].origin)) {
        self.attractor_positions[position_index] = queryresult.data[i].origin;
        position_index++;
      }
    } else {
      self.attractor_positions[position_index] = queryresult.data[i].origin;
      position_index++;

      if(isDefined(level.var_565d6ce0) && level.var_565d6ce0) {
        recordstar(queryresult.data[i].origin, (0, 1, 0));
      }

    }

    if(self.num_poi_attracts == position_index) {
      break;
    }
  }

  if(!isDefined(self.attractor_positions)) {
    self.attractor_positions = [];
  }

  self.attract_to_origin = 0;
  self notify(#"attractor_positions_generated");
  level notify(#"attractor_positions_generated");
  return true;
}

generated_radius_attract_positions(forward, offset, num_positions, attract_radius) {
  self endon(#"death");
  failed = 0;
  degs_per_pos = 360 / num_positions;
  i = offset;

  while(i < 360 + offset) {
    altforward = forward * attract_radius;
    rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);

    if(isDefined(level.poi_positioning_func)) {
      pos = [
        [level.poi_positioning_func]
      ](self.origin, rotated_forward);
    } else if(isDefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning) {
      pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 10));
    } else {
      pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 100));
    }

    if(!isDefined(pos)) {
      failed++;
    } else if(isDefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning) {
      if(isDefined(self) && isDefined(self.origin)) {
        if(self.origin[2] >= pos[2] - 1 && self.origin[2] - pos[2] <= 150) {
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
    } else if(abs(pos[2] - self.origin[2]) < 60) {
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

    i += degs_per_pos;
  }

  return failed;
}

debug_draw_attractor_positions() {
  while(true) {
    while(!isDefined(self.attractor_positions)) {
      waitframe(1);
      continue;
    }

    for(i = 0; i < self.attractor_positions.size; i++) {
      line(self.origin, self.attractor_positions[i][0], (1, 0, 0), 1, 1);
    }

    waitframe(1);

    if(!isDefined(self)) {
      return;
    }
  }
}

debug_draw_claimed_attractor_positions() {
  while(true) {
    while(!isDefined(self.claimed_attractor_positions)) {
      waitframe(1);
      continue;
    }

    for(i = 0; i < self.claimed_attractor_positions.size; i++) {
      line(self.origin, self.claimed_attractor_positions[i][0], (0, 1, 0), 1, 1);
    }

    waitframe(1);

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

      if(isDefined(self.ignore_poi_targetname) && self.ignore_poi_targetname.size > 0 && isinarray(self.ignore_poi_targetname, ent_array[i].targetname)) {
        continue;
      }

      if(isDefined(self.ignore_poi) && self.ignore_poi.size > 0 && isinarray(self.ignore_poi, ent_array[i])) {
        continue;
      }

      dist = distancesquared(origin, ent_array[i].origin);
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
      if(isDefined(best_poi._team)) {
        if(isDefined(self._race_team) && self._race_team != best_poi._team) {
          aiprofile_endentry();
          return undefined;
        }
      }

      if(isDefined(best_poi._new_ground_trace) && best_poi._new_ground_trace) {
        position = [];
        position[0] = groundpos_ignore_water_new(best_poi.origin + (0, 0, 100));
        position[1] = self;
      } else if(isDefined(best_poi.attract_to_origin) && best_poi.attract_to_origin) {
        position = [];
        position[0] = groundpos(best_poi.origin + (0, 0, 100));
        position[1] = self;
      } else {
        position = self add_poi_attractor(best_poi);
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

activate_zombie_point_of_interest() {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }

  self.poi_active = 1;
}

deactivate_zombie_point_of_interest(dont_remove) {
  if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "zombie_poi") {
    return;
  }

  self.attractor_array = array::remove_undefined(self.attractor_array);

  for(i = 0; i < self.attractor_array.size; i++) {
    self.attractor_array[i] notify(#"kill_poi");
  }

  self.attractor_array = [];
  self.claimed_attractor_positions = [];
  self.attractor_positions = [];
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

assign_zombie_point_of_interest(origin, poi) {
  position = undefined;
  doremovalthread = 0;

  if(isDefined(poi) && poi can_attract(self)) {
    if(!isDefined(poi.attractor_array) || isDefined(poi.attractor_array) && !isinarray(poi.attractor_array, self)) {
      doremovalthread = 1;
    }

    position = self add_poi_attractor(poi);

    if(isDefined(position) && doremovalthread && isinarray(poi.attractor_array, self)) {
      self thread update_on_poi_removal(poi);
    }
  }

  return position;
}

remove_poi_attractor(zombie_poi) {
  if(!isDefined(zombie_poi) || !isDefined(zombie_poi.attractor_array)) {
    return;
  }

  for(i = 0; i < zombie_poi.attractor_array.size; i++) {
    if(zombie_poi.attractor_array[i] == self) {
      arrayremovevalue(zombie_poi.attractor_array, zombie_poi.attractor_array[i]);
      arrayremovevalue(zombie_poi.claimed_attractor_positions, zombie_poi.claimed_attractor_positions[i]);

      if(isDefined(self)) {
        self notify(#"kill_poi");
      }
    }
  }
}

array_check_for_dupes_using_compare(array, single, is_equal_fn) {
  for(i = 0; i < array.size; i++) {
    if([
        [is_equal_fn]
      ](array[i], single)) {
      return false;
    }
  }

  return true;
}

poi_locations_equal(loc1, loc2) {
  return loc1[0] == loc2[0];
}

add_poi_attractor(zombie_poi) {
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

    best_dist = 100000000;
    best_pos = undefined;

    for(i = 0; i <= zombie_poi.attractor_positions.size; i++) {
      if(!isDefined(zombie_poi.attractor_positions[i])) {
        continue;
      }

      if(!isinarray(zombie_poi.claimed_attractor_positions, zombie_poi.attractor_positions[i])) {
        if(isDefined(zombie_poi.attractor_positions[i]) && isDefined(self.origin)) {
          dist = distancesquared(zombie_poi.attractor_positions[i], zombie_poi.origin);

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
    return array(best_pos, zombie_poi);
  } else {
    for(i = 0; i < zombie_poi.attractor_array.size; i++) {
      if(zombie_poi.attractor_array[i] == self) {
        if(isDefined(zombie_poi.claimed_attractor_positions) && isDefined(zombie_poi.claimed_attractor_positions[i])) {
          return array(zombie_poi.claimed_attractor_positions[i], zombie_poi);
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

update_poi_on_death(zombie_poi) {
  self endon(#"kill_poi");
  self waittill(#"death");
  self remove_poi_attractor(zombie_poi);
}

update_on_poi_removal(zombie_poi) {
  zombie_poi waittill(#"death");

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

invalidate_attractor_pos(attractor_pos, zombie) {
  if(!isDefined(self) || !isDefined(attractor_pos)) {
    wait 0.1;
    return undefined;
  }

  if(isDefined(self.attractor_positions) && !array_check_for_dupes_using_compare(self.attractor_positions, attractor_pos, &poi_locations_equal)) {
    index = 0;

    for(i = 0; i < self.attractor_positions.size; i++) {
      if(poi_locations_equal(self.attractor_positions[i], attractor_pos)) {
        index = i;
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
    wait 0.1;
  }

  return get_zombie_point_of_interest(zombie.origin);
}

remove_poi_from_ignore_list(poi) {
  if(isDefined(self.ignore_poi) && self.ignore_poi.size > 0) {
    for(i = 0; i < self.ignore_poi.size; i++) {
      if(self.ignore_poi[i] == poi) {
        arrayremovevalue(self.ignore_poi, self.ignore_poi[i]);
        return;
      }
    }
  }
}

add_poi_to_ignore_list(poi) {
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

default_validate_enemy_path_length(player) {
  d = distancesquared(self.origin, player.origin);

  if(d <= 1296) {
    return true;
  }

  return false;
}

function_d0f02e71(archetype) {
  if(!isDefined(level.var_58903b1f)) {
    level.var_58903b1f = [];
  }

  if(!isDefined(level.var_58903b1f)) {
    level.var_58903b1f = [];
  } else if(!isarray(level.var_58903b1f)) {
    level.var_58903b1f = array(level.var_58903b1f);
  }

  if(!isinarray(level.var_58903b1f, archetype)) {
    level.var_58903b1f[level.var_58903b1f.size] = archetype;
  }
}

function_55295a16() {
  level waittill(#"start_of_round");

  while(true) {
    reset_closest_player = 1;
    zombies = [];

    if(isDefined(level.var_58903b1f)) {
      foreach(archetype in level.var_58903b1f) {
        ai = getaiarchetypearray(archetype, level.zombie_team);

        if(ai.size) {
          zombies = arraycombine(zombies, ai, 0, 0);
        }
      }
    }

    foreach(zombie in zombies) {
      if(isDefined(zombie.need_closest_player) && zombie.need_closest_player) {
        reset_closest_player = 0;
        zombie.var_3a610ea4 = undefined;
        break;
      }

      zombie.var_3a610ea4 = undefined;
    }

    if(reset_closest_player) {
      foreach(zombie in zombies) {
        if(isDefined(zombie.need_closest_player)) {
          zombie.need_closest_player = 1;

          zombie.var_26f25576 = undefined;

        }
      }
    }

    waitframe(1);
  }
}

private function_5dcc54a8(players) {
  if(isDefined(self.last_closest_player) && isDefined(self.last_closest_player.am_i_valid) && self.last_closest_player.am_i_valid) {
    return;
  }

  self.need_closest_player = 1;

  foreach(player in players) {
    if(isDefined(player.am_i_valid) && player.am_i_valid) {
      self.last_closest_player = player;
      return;
    }
  }

  self.last_closest_player = undefined;
}

function_c52e1749(origin, players) {
  if(players.size == 0) {
    return undefined;
  }

  if(isDefined(self.zombie_poi)) {
    return undefined;
  }

  if(players.size == 1) {
    self.last_closest_player = players[0];
    self.var_c6e0686b = distancesquared(players[0].origin, origin);
    return self.last_closest_player;
  }

  if(!isDefined(self.last_closest_player)) {
    self.last_closest_player = players[0];
  }

  if(!isDefined(self.need_closest_player)) {
    self.need_closest_player = 1;
  }

  level.last_closest_time = level.time;
  self.need_closest_player = 0;
  var_88e86621 = spawnStruct();
  var_88e86621.height = self function_6a9ae71();
  var_88e86621.radius = self getpathfindingradius();
  var_88e86621.origin = origin;

  if(isDefined(self.var_6392b6c4)) {
    var_448ee423 = self[[self.var_6392b6c4]](origin, players);
    playerpositions = [];

    if(isDefined(var_448ee423)) {
      foreach(var_5063dbdc in var_448ee423) {
        if(isDefined(var_5063dbdc.origin)) {
          if(!isDefined(playerpositions)) {
            playerpositions = [];
          } else if(!isarray(playerpositions)) {
            playerpositions = array(playerpositions);
          }

          playerpositions[playerpositions.size] = var_5063dbdc.origin;
        }
      }
    } else {
      var_448ee423 = [];
    }
  } else {
    playerpositions = [];
    var_448ee423 = [];

    foreach(player in players) {
      player_pos = player.last_valid_position;

      if(!isDefined(player_pos)) {
        player_pos = getclosestpointonnavmesh(player.origin, 100, var_88e86621.radius);

        if(!isDefined(player_pos)) {
          continue;
        }
      }

      if(var_88e86621.radius > player getpathfindingradius()) {
        player_pos = getclosestpointonnavmesh(player.origin, 100, var_88e86621.radius);
      }

      pos = isDefined(player_pos) ? player_pos : player.origin;

      if(!isDefined(playerpositions)) {
        playerpositions = [];
      } else if(!isarray(playerpositions)) {
        playerpositions = array(playerpositions);
      }

      playerpositions[playerpositions.size] = pos;

      if(getdvarint(#"hash_4477ab37a00b1492", 1) == 1) {
        position_info = {
          #player: player, 
          #origin: pos
        };

        if(!isDefined(var_448ee423)) {
          var_448ee423 = [];
        } else if(!isarray(var_448ee423)) {
          var_448ee423 = array(var_448ee423);
        }

        var_448ee423[var_448ee423.size] = position_info;
      }
    }
  }

  closestplayer = undefined;
  self.var_c6e0686b = undefined;

  if(ispointonnavmesh(var_88e86621.origin, self)) {
    pathdata = generatenavmeshpath(var_88e86621.origin, playerpositions, self);

    if(isDefined(pathdata) && pathdata.status === "succeeded") {
      goalpos = pathdata.pathpoints[pathdata.pathpoints.size - 1];

      if(getdvarint(#"hash_4477ab37a00b1492", 1) == 1) {
        position_info = arraygetclosest(goalpos, var_448ee423);

        if(isDefined(position_info)) {
          closestplayer = position_info.player;
        }
      } else {
        foreach(index, position in playerpositions) {
          if(isDefined(level.var_cd24b30)) {
            if(distance2dsquared(position, goalpos) < 16 * 16 && abs(position[2] - goalpos[2]) <= level.var_cd24b30) {
              closestplayer = players[index];
            }

            continue;
          }

          if(distancesquared(position, goalpos) < 16 * 16) {
            closestplayer = players[index];
            break;
          }
        }
      }
    }
  }

  self.var_26f25576 = gettime();

    self.last_closest_player = closestplayer;

  if(isDefined(closestplayer)) {
    self.var_c6e0686b = pathdata.pathdistance * pathdata.pathdistance;
  }

  self function_5dcc54a8(players);
  return self.last_closest_player;
}

get_closest_valid_player(origin, ignore_player = array(), var_b106b254 = 0) {
  aiprofile_beginentry("get_closest_valid_player");
  players = getplayers();

  if(isDefined(level.zombie_targets) && level.zombie_targets.size > 0) {
    function_1eaaceab(level.zombie_targets);
    arrayremovevalue(level.zombie_targets, undefined);
    players = arraycombine(players, level.zombie_targets, 0, 0);
  }

  b_designated_target_exists = 0;

  foreach(player in players) {
    if(!(isDefined(player.am_i_valid) && player.am_i_valid)) {
      continue;
    }

    if(isDefined(level.var_63707e9c)) {
      if(![
          [level.var_63707e9c]
        ](player)) {
        array::add(ignore_player, player);
      }
    }

    if(isDefined(player.b_is_designated_target) && player.b_is_designated_target) {
      b_designated_target_exists = 1;
    }

    if(isDefined(level.var_6f6cc58)) {
      if(![
          [level.var_6f6cc58]
        ](player)) {
        array::add(ignore_player, player);
      }
    }
  }

  if(isDefined(ignore_player)) {
    foreach(ignored_player in ignore_player) {
      arrayremovevalue(players, ignored_player);
    }
  }

  done = 0;

  while(players.size && !done) {
    done = 1;

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!(isDefined(player.am_i_valid) && player.am_i_valid)) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }

      if(b_designated_target_exists && !(isDefined(player.b_is_designated_target) && player.b_is_designated_target)) {
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

  if(!var_b106b254 && isDefined(self.closest_player_override)) {
    player = [[self.closest_player_override]](origin, players);
  } else if(!var_b106b254 && isDefined(level.closest_player_override)) {
    player = [[level.closest_player_override]](origin, players);
  } else {
    player = arraygetclosest(origin, players);
  }

  if(!isDefined(player)) {
    aiprofile_endentry();
    return undefined;
  }

  aiprofile_endentry();
  return player;
}

update_valid_players(origin, ignore_player) {
  aiprofile_beginentry("update_valid_players");
  players = arraycopy(level.players);

  foreach(player in players) {
    self setignoreent(player, 1);
  }

  b_designated_target_exists = 0;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!(isDefined(player.am_i_valid) && player.am_i_valid)) {
      continue;
    }

    if(isDefined(level.var_63707e9c)) {
      if(![
          [level.var_63707e9c]
        ](player)) {
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

      if(!(isDefined(player.am_i_valid) && player.am_i_valid)) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }

      if(b_designated_target_exists && !(isDefined(player.b_is_designated_target) && player.b_is_designated_target)) {
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

is_player_valid(e_player, var_11e899f9 = 0, var_67fee570 = 0, var_6eefd462 = 1, var_da861165 = 1) {
  if(!isDefined(e_player)) {
    return 0;
  }

  if(!isentity(e_player)) {
    return 0;
  }

  if(!isplayer(e_player)) {
    return 0;
  }

  if(!isalive(e_player)) {
    return 0;
  }

  if(isDefined(e_player.is_zombie) && e_player.is_zombie) {
    return 0;
  }

  if(e_player.sessionstate == "spectator" || e_player.sessionstate == "intermission") {
    return 0;
  }

  if(isDefined(level.intermission) && level.intermission) {
    return 0;
  }

  if(!var_67fee570) {
    if(e_player laststand::player_is_in_laststand()) {
      return 0;
    }
  }

  if(var_11e899f9) {
    if(e_player.ignoreme || e_player isnotarget()) {
      return 0;
    }
  }

  if(!var_6eefd462) {
    if(e_player isplayerunderwater()) {
      return 0;
    }
  }

  if(!var_da861165 && e_player scene::is_igc_active()) {
    return 0;
  }

  if(isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](e_player);
  }

  return 1;
}

get_number_of_valid_players() {
  players = getplayers();
  num_player_valid = 0;

  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i])) {
      num_player_valid += 1;
    }
  }

  return num_player_valid;
}

in_revive_trigger() {
  if(isDefined(self.rt_time) && self.rt_time + 100 >= gettime()) {
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

non_destroyed_bar_board_order(origin, chunks) {
  first_bars = [];
  first_bars1 = [];
  first_bars2 = [];

  for(i = 0; i < chunks.size; i++) {
    if(isDefined(chunks[i].script_team) && chunks[i].script_team == "classic_boards") {
      if(isDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "board") {
        return get_closest_2d(origin, chunks);
      } else if(isDefined(chunks[i].script_team) && chunks[i].script_team == "bar_board_variant1" || chunks[i].script_team == "bar_board_variant2" || chunks[i].script_team == "bar_board_variant4" || chunks[i].script_team == "bar_board_variant5") {
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

vehicle_outline_watcher(origin, chunks_grate) {
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
  
            iprintlnbold("<dev string:xa7>");
  

              grate_order3[i] thread show_grate_pull();
            return grate_order2[i];
          }

          if(grate_order3[i].state == "repaired") {
  
            iprintlnbold("<dev string:xb5>");
  

              grate_order4[i] thread show_grate_pull();
            return grate_order3[i];
          }

          if(grate_order4[i].state == "repaired") {
  
            iprintlnbold("<dev string:xc3>");
  

              grate_order5[i] thread show_grate_pull();
            return grate_order4[i];
          }

          if(grate_order5[i].state == "repaired") {
  
            iprintlnbold("<dev string:xd1>");
  

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

show_grate_pull() {
  wait 0.53;
  self show();
  self vibrate((0, 270, 0), 0.2, 0.4, 0.4);
}

get_closest_2d(origin, ents) {
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

in_playable_area() {
  if(function_21f4ac36() && !isDefined(level.var_a2a9b2de)) {
    level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
  }

  if(function_c85ebbbc() && !isDefined(level.playable_area)) {
    level.playable_area = getEntArray("player_volume", "script_noteworthy");
  }

  if(!isDefined(level.playable_area) && !isDefined(level.var_a2a9b2de)) {
    println("<dev string:xdf>");
    return true;
  }

  if(isDefined(level.var_a2a9b2de)) {
    node = function_52c1730(self.origin, level.var_a2a9b2de, 500);

    if(isDefined(node)) {
      return true;
    }
  }

  if(isDefined(level.playable_area)) {
    for(i = 0; i < level.playable_area.size; i++) {
      if(self istouching(level.playable_area[i])) {
        return true;
      }
    }
  }

  return false;
}

get_closest_non_destroyed_chunk(origin, barrier, barrier_chunks) {
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
  } else if(isDefined(chunks)) {
    return non_destroyed_bar_board_order(origin, chunks);
  } else if(isDefined(chunks_grate)) {
    return vehicle_outline_watcher(origin, chunks_grate);
  }

  return undefined;
}

get_random_destroyed_chunk(barrier, barrier_chunks) {
  if(isDefined(barrier.zbarrier)) {
    ret = undefined;
    pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");

    if(pieces.size) {
      ret = array::randomize(pieces)[0];
    }

    return ret;
  }

  chunks_repair_grate = undefined;
  chunks = get_destroyed_chunks(barrier_chunks);
  chunks_repair_grate = get_destroyed_repair_grates(barrier_chunks);

  if(isDefined(chunks)) {
    return chunks[randomint(chunks.size)];
  } else if(isDefined(chunks_repair_grate)) {
    return grate_order_destroyed(chunks_repair_grate);
  }

  return undefined;
}

get_destroyed_repair_grates(barrier_chunks) {
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

get_non_destroyed_chunks(barrier, barrier_chunks) {
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

get_non_destroyed_chunks_grate(barrier, barrier_chunks) {
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

get_destroyed_chunks(barrier_chunks) {
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

grate_order_destroyed(chunks_repair_grate) {
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

          iprintlnbold("<dev string:x125>");

            return grate_repair_order6[i];
        }

        if(grate_repair_order5[i].state == "destroyed") {

          iprintlnbold("<dev string:x134>");

            grate_repair_order6[i] thread show_grate_repair();
          return grate_repair_order5[i];
        }

        if(grate_repair_order4[i].state == "destroyed") {

          iprintlnbold("<dev string:x143>");

            grate_repair_order5[i] thread show_grate_repair();
          return grate_repair_order4[i];
        }

        if(grate_repair_order3[i].state == "destroyed") {

          iprintlnbold("<dev string:x152>");

            grate_repair_order4[i] thread show_grate_repair();
          return grate_repair_order3[i];
        }

        if(grate_repair_order2[i].state == "destroyed") {

          iprintlnbold("<dev string:x161>");

            grate_repair_order3[i] thread show_grate_repair();
          return grate_repair_order2[i];
        }

        if(grate_repair_order1[i].state == "destroyed") {

          iprintlnbold("<dev string:x170>");

            grate_repair_order2[i] thread show_grate_repair();
          return grate_repair_order1[i];
        }
      }
    }
  }
}

show_grate_repair() {
  wait 0.34;
  self hide();
}

get_chunk_state() {
  assert(isDefined(self.state));
  return self.state;
}

fake_physicslaunch(target_pos, power) {
  start_pos = self.origin;
  gravity = getdvarint(#"bg_gravity", 0) * -1;
  dist = distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * time * time;
  velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);

  level thread draw_line_ent_to_pos(self, target_pos);

    self movegravity(velocity, time);
  return time;
}

add_zombie_hint(ref, text) {
  if(!isDefined(level.zombie_hints)) {
    level.zombie_hints = [];
  }

  level.zombie_hints[ref] = text;
}

get_zombie_hint(ref) {
  if(isDefined(level.zombie_hints[ref])) {
    return level.zombie_hints[ref];
  }

  println("<dev string:x17f>" + ref);
  return level.zombie_hints[#"undefined"];
}

set_hint_string(ent, default_ref, cost) {
  ref = default_ref;

  if(isDefined(ent.script_hint)) {
    ref = ent.script_hint;
  }

  hint = get_zombie_hint(ref);

  if(isDefined(cost)) {
    self sethintstring(hint, cost);
    return;
  }

  self sethintstring(hint);
}

get_hint_string(ent, default_ref, cost) {
  ref = default_ref;

  if(isDefined(ent.script_hint)) {
    ref = ent.script_hint;
  }

  return get_zombie_hint(ref);
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
    assertmsg("<dev string:x19d>" + ref + "<dev string:x1a7>");
    return;
  }

  playsoundatposition(level.zombie_sounds[ref], pos);
}

play_sound_on_ent(ref) {
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
    assertmsg("<dev string:x19d>" + ref + "<dev string:x1a7>");
    return;
  }

  self playSound(level.zombie_sounds[ref]);
}

play_loopsound_on_ent(ref) {
  if(isDefined(self.script_firefxsound)) {
    ref = self.script_firefxsound;
  }

  if(ref == "none") {
    return;
  }

  if(!isDefined(level.zombie_sounds[ref])) {
    assertmsg("<dev string:x19d>" + ref + "<dev string:x1a7>");
    return;
  }

  self playSound(level.zombie_sounds[ref]);
}

draw_line_ent_to_ent(ent1, ent2) {
  if(getdvarint(#"zombie_debug", 0) != 1) {
    return;
  }

  ent1 endon(#"death");
  ent2 endon(#"death");

  while(true) {
    line(ent1.origin, ent2.origin);
    waitframe(1);
  }
}

draw_line_ent_to_pos(ent, pos, end_on) {
  if(getdvarint(#"zombie_debug", 0) != 1) {
    return;
  }

  ent notify(#"stop_draw_line_ent_to_pos");
  ent endon(#"stop_draw_line_ent_to_pos", #"death");

  if(isDefined(end_on)) {
    ent endon(end_on);
  }

  while(true) {
    line(ent.origin, pos);
    waitframe(1);
  }
}

debug_print(msg) {
  if(getdvarint(#"zombie_debug", 0) > 0) {
    println("<dev string:x211>" + msg);
  }
}

debug_blocker(pos, rad, height) {
  self notify(#"stop_debug_blocker");
  self endon(#"stop_debug_blocker");

  for(;;) {
    if(getdvarint(#"zombie_debug", 0) != 1) {
      return;
    }

    waitframe(1);
    drawcylinder(pos, rad, height);
  }
}

drawcylinder(pos, rad, height) {
  currad = rad;
  curheight = height;

  for(r = 0; r < 20; r++) {
    theta = r / 20 * 360;
    theta2 = (r + 1) / 20 * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
  }
}

debug_attack_spots_taken() {
  self notify(#"stop_debug_breadcrumbs");
  self endon(#"stop_debug_breadcrumbs");

  while(true) {
    if(getdvarint(#"zombie_debug", 0) != 2) {
      wait 1;
      continue;
    }

    waitframe(1);
    count = 0;

    for(i = 0; i < self.attack_spots_taken.size; i++) {
      if(self.attack_spots_taken[i]) {
        count++;
        circle(self.attack_spots[i], 12, (1, 0, 0), 0, 1, 1);
        continue;
      }

      circle(self.attack_spots[i], 12, (0, 1, 0), 0, 1, 1);
    }

    msg = "<dev string:x226>" + count + "<dev string:x229>" + self.attack_spots_taken.size;
    print3d(self.origin, msg);
  }
}

float_print3d(msg, time) {
  self endon(#"death");
  time = gettime() + time * 1000;
  offset = (0, 0, 72);

  while(gettime() < time) {
    offset += (0, 0, 2);
    print3d(self.origin + offset, msg, (1, 1, 1));
    waitframe(1);
  }
}

  function do_player_vo(snd, variation_count) {
    index = get_player_index(self);
    sound = "zmb_vox_plr_" + index + "_" + snd;

    if(isDefined(variation_count)) {
      sound = sound + "_" + randomintrange(0, variation_count);
    }

    if(!isDefined(level.player_is_speaking)) {
      level.player_is_speaking = 0;
    }

    if(level.player_is_speaking == 0) {
      level.player_is_speaking = 1;
      self playsoundwithnotify(sound, "sound_done");
      self waittill(#"sound_done");
      wait 2;
      level.player_is_speaking = 0;
    }
  }

is_magic_bullet_shield_enabled(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  return !(isDefined(ent.allowdeath) && ent.allowdeath);
}

play_sound_2d(sound) {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playsoundwithnotify(sound, sound + "wait");
  temp_ent waittill(sound + "wait");
  waitframe(1);
  temp_ent delete();
}

include_weapon(weapon_name, in_box) {
  println("<dev string:x22f>" + function_9e72a96(weapon_name));

  if(!isDefined(in_box)) {
    in_box = 1;
  }

  zm_weapons::include_zombie_weapon(weapon_name, in_box);
}

print3d_ent(text, color, scale, offset, end_msg, overwrite) {
  self endon(#"death");

  if(isDefined(overwrite) && overwrite && isDefined(self._debug_print3d_msg)) {
    self notify(#"end_print3d");
    waitframe(1);
  }

  self endon(#"end_print3d");

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
    waitframe(1);
  }

}

function_21f4ac36() {
  return getdvarint(#"hash_42c75b39576494a5", 1) == 1;
}

function_c85ebbbc() {
  return getdvarint(#"hash_6ec233a56690f409", 1) == 1;
}

function_b0eeaada(location, max_drop_distance = 500) {
  return function_9cc082d2(location, max_drop_distance);
}

function_a1055d95(location, node) {
  return isDefined(location) && location[#"region"] === getnoderegion(node);
}

get_current_zone(return_zone = 0) {
  if(!isDefined(self)) {
    return undefined;
  }

  self endon(#"death");
  level flag::wait_till("zones_initialized");

  if(function_21f4ac36()) {
    node = self.var_3b65cdd7;
    var_3e5dca65 = self.origin;

    if(isplayer(self)) {
      if(isDefined(self.last_valid_position) && distancesquared(self.origin, self.last_valid_position) < 32 * 32) {
        var_3e5dca65 = self.last_valid_position;
      }
    }

    self.var_3b65cdd7 = function_52c1730(var_3e5dca65, level.zone_nodes, 500);

    if(isDefined(self.var_3b65cdd7)) {
      if(node !== self.var_3b65cdd7 || isDefined(node) && node.targetname !== self.var_3b65cdd7.targetname) {
        self.cached_zone = level.zones[self.var_3b65cdd7.targetname];
        self.cached_zone_name = self.cached_zone.name;
        self.cached_zone_volume = undefined;
        self notify(#"zone_change", {
          #zone: self.cached_zone, 
          #zone_name: self.cached_zone_name
        });
      }

      if(return_zone) {
        return level.zones[self.var_3b65cdd7.targetname];
      } else {
        return self.var_3b65cdd7.targetname;
      }
    }
  }

  if(function_c85ebbbc()) {
    foreach(zone in level.zones) {
      for(i = 0; i < zone.volumes.size; i++) {
        if(self istouching(zone.volumes[i])) {
          if(zone !== self.cached_zone) {
            self.cached_zone = zone;
            self.cached_zone_name = zone.name;
            self.cached_zone_volume = i;
            self.var_3b65cdd7 = undefined;
            self notify(#"zone_change", {
              #zone: zone, 
              #zone_name: zone.name
            });
          }

          if(isDefined(return_zone) && return_zone) {
            return zone;
          }

          return zone.name;
        }
      }
    }
  }

  self.cached_zone = undefined;
  self.cached_zone_name = undefined;
  self.cached_zone_volume = undefined;
  self.var_3b65cdd7 = undefined;
  return undefined;
}

update_zone_name() {
  self notify("91efb2e47638985");
  self endon("91efb2e47638985");
  self endon(#"death");
  self.zone_name = get_current_zone();

  if(isDefined(self.zone_name)) {
    self.previous_zone_name = self.zone_name;
  }

  while(isDefined(self)) {
    if(isDefined(self.zone_name)) {
      self.previous_zone_name = self.zone_name;
    }

    self.zone_name = get_current_zone();
    wait randomfloatrange(0.5, 1);
  }
}

shock_onpain() {
  self notify(#"stop_shock_onpain");
  self endon(#"stop_shock_onpain", #"death");

  if(getdvarstring(#"blurpain") == "") {
    setdvar(#"blurpain", "on");
  }

  while(true) {
    oldhealth = self.health;
    waitresult = self waittill(#"damage");
    mod = waitresult.mod;
    damage = waitresult.amount;
    attacker = waitresult.attacker;
    direction_vec = waitresult.direction;
    point = waitresult.position;

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
      continue;
    }

    if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH") {
      continue;
    }

    if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE") {
      shocktype = undefined;
      shocklight = undefined;

      if(isDefined(self.is_burning) && self.is_burning) {
        shocktype = "lava";
        shocklight = "lava_small";
      }

      self shock_onexplosion(damage, shocktype, shocklight);
      continue;
    }

    if(getdvarstring(#"blurpain") == "on") {
      self shellshock(#"pain_zm", 0.5);
    }
  }
}

shock_onexplosion(damage, shocktype, shocklight) {
  time = 0;
  scaled_damage = 100 * damage / self.maxhealth;

  if(scaled_damage >= 90) {
    time = 4;
  } else if(scaled_damage >= 50) {
    time = 3;
  } else if(scaled_damage >= 25) {
    time = 2;
  } else if(scaled_damage > 10) {
    time = 1;
  }

  if(time) {
    if(!isDefined(shocktype)) {
      shocktype = "explosion_zm";
    }

    self shellshock(shocktype, time);
    return;
  }

  if(isDefined(shocklight)) {
    self shellshock(shocklight, time);
  }
}

increment_is_drinking(var_12d2689b = 0) {

  if(isDefined(level.devgui_dpad_watch) && level.devgui_dpad_watch) {
    self.is_drinking++;
    return;
  }

    if(!isDefined(self.is_drinking)) {
      self.is_drinking = 0;
    }

  if(self.is_drinking == 0) {
    if(!var_12d2689b) {
      self disableoffhandweapons();
    }

    self disableweaponcycling();
  }

  self.is_drinking++;
}

is_drinking() {
  return isDefined(self.is_drinking) && self.is_drinking > 0 || isplayer(self) && self function_55acff10();
}

is_multiple_drinking() {
  return isDefined(self.is_drinking) && self.is_drinking > 1;
}

decrement_is_drinking() {
  if(self.is_drinking > 0) {
    self.is_drinking--;
  } else {
    assertmsg("<dev string:x249>");
  }

  if(self.is_drinking == 0) {
    self enableoffhandweapons();
    self enableweaponcycling();
  }
}

clear_is_drinking() {
  self.is_drinking = 0;
  self enableoffhandweapons();
  self enableweaponcycling();
}

function_91403f47() {
  if(!isDefined(level.var_1d72fbba)) {
    level.var_1d72fbba = 0;
  }

  return level.var_1d72fbba > 0;
}

function_3e549e65() {
  if(!isDefined(level.var_1d72fbba)) {
    level.var_1d72fbba = 0;
  }

  level.var_1d72fbba++;
}

function_b7e5029f() {
  if(!isDefined(level.var_1d72fbba)) {
    level.var_1d72fbba = 0;
  }

  if(level.var_1d72fbba > 0) {
    level.var_1d72fbba--;
  } else {
    assertmsg("<dev string:x26a>");
  }

  level zm_player::function_8ef51109();
}

can_use(e_player, b_is_weapon = 0, var_67fee570 = 0) {
  if(!is_player_valid(e_player, 0, var_67fee570) || e_player in_revive_trigger() || e_player isthrowinggrenade() || e_player isswitchingweapons() || e_player is_drinking()) {
    return false;
  }

  if(b_is_weapon) {
    w_current = e_player getcurrentweapon();

    if(!e_player zm_magicbox::can_buy_weapon(0) || e_player bgb::is_enabled(#"zm_bgb_disorderly_combat") || zm_loadout::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || ability_util::is_weapon_gadget(w_current)) {
      return false;
    }
  }

  return true;
}

getweaponclasszm(weapon) {
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
  weaponinfo = getunlockableiteminfofromindex(baseweaponindex, 1);

  if(isDefined(weaponinfo)) {
    level.weaponclassarray[weapon] = weaponinfo.itemgroupname;
  } else {
    level.weaponclassarray[weapon] = "";
  }

  return level.weaponclassarray[weapon];
}

spawn_weapon_model(weapon, model = weapon.worldmodel, origin, angles, options) {
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

spawn_buildkit_weapon_model(player, weapon, var_3ded6a21, origin, angles) {
  weapon_model = spawn("script_model", origin);

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  upgraded = zm_weapons::is_weapon_upgraded(weapon);

  if(upgraded && (!isDefined(var_3ded6a21) || 0 > var_3ded6a21)) {
    var_3ded6a21 = player zm_camos::function_4f727cf5(weapon);
  }

  weapon_model usebuildkitweaponmodel(player, weapon, var_3ded6a21);
  return weapon_model;
}

is_player_revive_tool(weapon) {
  if(weapon == level.weaponrevivetool || weapon === self.weaponrevivetool) {
    return true;
  }

  return false;
}

is_limited_weapon(weapon) {
  if(isDefined(level.limited_weapons) && isDefined(level.limited_weapons[weapon])) {
    return true;
  }

  return false;
}

should_watch_for_emp() {
  return isDefined(level.should_watch_for_emp) && level.should_watch_for_emp;
}

groundpos(origin) {
  return bulletTrace(origin, origin + (0, 0, -100000), 0, self)[#"position"];
}

groundpos_ignore_water(origin) {
  return bulletTrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

groundpos_ignore_water_new(origin) {
  return groundtrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

self_delete() {
  if(isDefined(self)) {
    self delete();
  }
}

ignore_triggers(timer) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self.ignoretriggers = 1;

  if(isDefined(timer)) {
    wait timer;
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

giveachievement_wrapper(achievement, all_players) {
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

    return;
  }

  if(!isplayer(self)) {
    println("<dev string:x29b>");
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

getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

disable_react() {
  assert(isalive(self), "<dev string:x2dd>");
  self.allowreact = 0;
}

enable_react() {
  assert(isalive(self), "<dev string:x302>");
  self.allowreact = 1;
}

is_ee_enabled() {
  if(isDefined(level.var_73d1e054) && level.var_73d1e054) {
    return false;
  }

  if(!getdvarint(#"zm_ee_enabled", 0)) {
    return false;
  }

  if(!zm_custom::function_901b751c(#"hash_3c5363541b97ca3e")) {
    return false;
  }

  if(level.gamedifficulty === 0) {
    return false;
  }

  return true;
}

bullet_attack(type) {
  if(type == "MOD_PISTOL_BULLET") {
    return true;
  }

  return type == "MOD_RIFLE_BULLET";
}

pick_up() {
  player = self.owner;
  self delete();
  clip_ammo = player getweaponammoclip(self.weapon);
  clip_max_ammo = self.weapon.clipsize;

  if(clip_ammo < clip_max_ammo) {
    clip_ammo++;
  }

  player setweaponammoclip(self.weapon, clip_ammo);
}

function_ab9a9770() {
  s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);

  if(isDefined(s_trace[#"entity"]) && s_trace[#"entity"] ismovingplatform()) {
    return true;
  }

  return false;
}

function_52046128() {
  s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);

  if(isDefined(s_trace[#"entity"])) {
    return s_trace[#"entity"];
  }

  return undefined;
}

waittill_not_moving() {
  self endon(#"death", #"detonated");
  level endon(#"game_ended");

  if(self.classname == "grenade") {
    self waittill(#"stationary");
    return;
  }

  for(prevorigin = self.origin; true; prevorigin = self.origin) {
    wait 0.15;

    if(self.origin == prevorigin) {
      break;
    }
  }
}

get_closest_player(org) {
  players = [];
  players = getplayers();

  if(players.size) {
    if(players.size > 1 && isDefined(org)) {
      return arraygetclosest(org, players);
    }

    return players[0];
  }
}

ent_flag_init_ai_standards() {
  message_array = [];
  message_array[message_array.size] = "goal";
  message_array[message_array.size] = "damage";

  for(i = 0; i < message_array.size; i++) {
    self flag::init(message_array[i]);
    self thread ent_flag_wait_ai_standards(message_array[i]);
  }
}

ent_flag_wait_ai_standards(message) {
  self endon(#"death");
  self waittill(message);
  self.ent_flag[message] = 1;
}

flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

clear_run_anim() {
  self.alwaysrunforward = undefined;
  self.a.combatrunanim = undefined;
  self.run_noncombatanim = undefined;
  self.walk_combatanim = undefined;
  self.walk_noncombatanim = undefined;
  self.precombatrunenabled = 1;
}

track_players_intersection_tracker() {
  level endon(#"end_game");
  wait 5;
  var_76013453 = [];

  if(!isDefined(level.var_9db63456)) {
    level.var_9db63456 = 0;
  }

    if(!isDefined(level.var_9db63456)) {
      level.var_9db63456 = 1;
    }

  while(true) {
    var_1a1f860b = 0;
    players = getplayers();

    foreach(player in players) {
      if(!isDefined(player.var_ab8c5e97)) {
        player.var_ab8c5e97 = [];
      }

      if(!isDefined(player.var_d28c72e5)) {
        player.var_d28c72e5 = 1000;
      }
    }

      var_93bba48c = [];

    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].var_f4e33249) && players[i].var_f4e33249 || players[i] isplayerswimming() || players[i] laststand::player_is_in_laststand() || "playing" != players[i].sessionstate) {
        continue;
      }

      if(isbot(players[i])) {
        continue;
      }

      if(lengthsquared(players[i] getvelocity()) > 15625) {
        continue;
      }

      if(isDefined(players[i].var_c5e36086) && players[i].var_c5e36086) {
        continue;
      }

      for(j = 0; j < players.size; j++) {
        if(i == j || isDefined(players[j].var_f4e33249) && players[j].var_f4e33249 || players[j] isplayerswimming() || players[j] laststand::player_is_in_laststand() || "playing" != players[j].sessionstate) {
          continue;
        }

        if(isbot(players[j])) {
          continue;
        }

        if(lengthsquared(players[j] getvelocity()) > 15625) {
          continue;
        }

        if(isDefined(players[j].var_c5e36086) && players[j].var_c5e36086) {
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

        if(abs(playeri_origin[2] - playerj_origin[2]) > 60) {
          continue;
        }

        distance_apart = distance2d(playeri_origin, playerj_origin);

        if(!isDefined(players[i].var_ab8c5e97[j])) {
          players[i].var_ab8c5e97[j] = 1000;
        }

        players[i].var_ab8c5e97[j] = min(players[i].var_ab8c5e97[j], distance_apart);
        players[i].var_d28c72e5 = min(players[i].var_d28c72e5, distance_apart);

        if(abs(distance_apart) > 30) {
          if(players[i].var_ab8c5e97[j] === players[i].var_d28c72e5) {
            players[i].var_d28c72e5 = 1000;
          }

          players[i].var_ab8c5e97[j] = 1000;
        }

          if(abs(distance_apart) > 9) {
            continue;
          }

        if(!isDefined(var_93bba48c)) {
          var_93bba48c = [];
        } else if(!isarray(var_93bba48c)) {
          var_93bba48c = array(var_93bba48c);
        }

        if(!isinarray(var_93bba48c, players[i])) {
          var_93bba48c[var_93bba48c.size] = players[i];
        }

        if(!isDefined(var_93bba48c)) {
          var_93bba48c = [];
        } else if(!isarray(var_93bba48c)) {
          var_93bba48c = array(var_93bba48c);
        }

        if(!isinarray(var_93bba48c, players[j])) {
          var_93bba48c[var_93bba48c.size] = players[j];
        }
      }
    }

    foreach(var_e42ab7b4 in var_93bba48c) {

      if(!level.var_9db63456) {
        iprintlnbold("<dev string:x326>" + var_e42ab7b4.var_d28c72e5);
        continue;
      }

        if(isinarray(var_76013453, var_e42ab7b4)) {
          if(isDefined(var_e42ab7b4.maxhealth) && var_e42ab7b4.maxhealth > 0) {
            n_damage = var_e42ab7b4.maxhealth / 3 + 1;
          } else {
            n_damage = 51;
          }

          if(isDefined(var_e42ab7b4) && isvec(var_e42ab7b4.origin)) {
            self.var_dad8bef6 = 1;
            var_e42ab7b4 dodamage(n_damage, var_e42ab7b4.origin);
            self.var_dad8bef6 = undefined;
            var_e42ab7b4 zm_stats::increment_map_cheat_stat("cheat_too_friendly");
            var_e42ab7b4 zm_stats::increment_client_stat("cheat_too_friendly", 0);
            var_e42ab7b4 zm_stats::increment_client_stat("cheat_total", 0);
          }
        }

      if(!var_1a1f860b) {

        iprintlnbold("<dev string:x351>" + var_e42ab7b4.var_d28c72e5);

          foreach(e_player in level.players) {
            e_player playlocalsound(level.zmb_laugh_alias);
          }

        var_1a1f860b = 1;
      }
    }

    var_76013453 = var_93bba48c;
    wait 1;
  }
}

is_player_looking_at(origin, dot, do_trace, ignore_ent) {
  assert(isplayer(self), "<dev string:x371>");

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
    } else {
      return 1;
    }
  }

  return 0;
}

add_gametype(gt, dummy1, name, dummy2) {}

add_gameloc(gl, dummy1, name, dummy2) {}

get_closest_index(org, array, dist = 9999999) {
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

is_valid_zombie_spawn_point(point) {
  liftedorigin = point.origin + (0, 0, 5);
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

get_closest_index_to_entity(entity, array, dist, extra_check) {
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

set_gamemode_var(gvar, val) {
  if(!isDefined(game.gamemode_match)) {
    game.gamemode_match = [];
  }

  game.gamemode_match[gvar] = val;
}

set_gamemode_var_once(gvar, val) {
  if(!isDefined(game.gamemode_match)) {
    game.gamemode_match = [];
  }

  if(!isDefined(game.gamemode_match[gvar])) {
    game.gamemode_match[gvar] = val;
  }
}

get_gamemode_var(gvar) {
  if(isDefined(game.gamemode_match) && isDefined(game.gamemode_match[gvar])) {
    return game.gamemode_match[gvar];
  }

  return undefined;
}

waittill_subset(min_num, string1, string2, string3, string4, string5) {
  self endon(#"death");
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
    ent waittill(#"returned");
    ent.threads--;
    returned_threads++;

    if(returned_threads >= min_num) {
      break;
    }
  }

  ent notify(#"die");
}

is_headshot(weapon, shitloc, smeansofdeath, var_f8c15d58 = 1) {
  if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_UNKNOWN") {
    return false;
  }

  if(var_f8c15d58 && isDefined(self.var_e6675d2d) && (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH")) {
    v_head = self gettagorigin("j_head");

    if(!isDefined(v_head)) {
      return false;
    }

    n_distance_squared = distancesquared(self.var_e6675d2d, v_head);

    if(n_distance_squared < 80) {
      return true;
    }
  }

  if(!isDefined(shitloc) || shitloc == "none") {
    return false;
  }

  if(shitloc != "head" && shitloc != "helmet" && shitloc != "neck") {
    return false;
  }

  return true;
}

is_explosive_damage(mod) {
  if(!isDefined(mod)) {
    return false;
  }

  if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
    return true;
  }

  return false;
}

function_7a35b1d7(var_c857a96d) {
  if(isplayer(self)) {
    self luinotifyevent(#"zombie_notification", 2, var_c857a96d, self getentitynumber());
    return;
  }

  luinotifyevent(#"zombie_notification", 1, var_c857a96d);
}

function_846eb7dd(type_id, var_c857a96d) {
  if(isplayer(self)) {
    self luinotifyevent(type_id, 2, var_c857a96d, self getentitynumber());
    return;
  }

  luinotifyevent(type_id, 1, var_c857a96d);
}

function_e64ac3b6(type_id, var_c857a96d) {
  if(isplayer(self)) {
    self luinotifyevent(#"zombie_special_notification", 3, type_id, var_c857a96d, self getentitynumber());
    return;
  }

  luinotifyevent(#"zombie_special_notification", 2, type_id, var_c857a96d);
}

sndswitchannouncervox(who) {
  switch (who) {
    case #"sam":
      game.zmbdialog[#"prefix"] = "vox_zmba_sam";
      level.zmb_laugh_alias = "zmb_player_outofbounds";
      level.sndannouncerisrich = 0;
      break;
  }
}

do_player_general_vox(category, type, timer, chance) {
  if(isDefined(timer) && isDefined(level.votimer[type]) && level.votimer[type] > 0) {
    return;
  }

  self thread zm_audio::create_and_play_dialog(category, type);

  if(isDefined(timer)) {
    level.votimer[type] = timer;
    level thread general_vox_timer(level.votimer[type], type);
  }
}

general_vox_timer(timer, type) {
  level endon(#"end_game");
  println("<dev string:x3a1>" + type + "<dev string:x3c1>" + timer + "<dev string:x3c7>");

  while(timer > 0) {
    wait 1;
    timer--;
  }

  level.votimer[type] = timer;
  println("<dev string:x3cb>" + type + "<dev string:x3c1>" + timer + "<dev string:x3c7>");
}

play_vox_to_player(category, type, force_variant) {}

is_favorite_weapon(weapon_to_check) {
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

set_demo_intermission_point() {
  spawnpoints = getEntArray("mp_global_intermission", "classname");

  if(!spawnpoints.size) {
    return;
  }

  spawnpoint = spawnpoints[0];
  match_string = "";
  location = level.scr_zm_map_start_location;

  if((location == "default" || location == "") && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }

  match_string = level.scr_zm_ui_gametype + "_" + location;

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

register_map_navcard(navcard_on_map, navcard_needed_for_computer) {
  level.navcard_needed = navcard_needed_for_computer;
  level.map_navcard = navcard_on_map;
}

does_player_have_map_navcard(player) {
  return player zm_stats::get_global_stat(level.map_navcard);
}

does_player_have_correct_navcard(player) {
  if(!isDefined(level.navcard_needed)) {
    return 0;
  }

  return player zm_stats::get_global_stat(level.navcard_needed);
}

disable_player_move_states(forcestancechange) {
  self allowcrouch(1);
  self allowads(0);
  self allowsprint(0);
  self allowprone(0);
  self allowmelee(0);

  if(isDefined(forcestancechange) && forcestancechange) {
    if(self getstance() == "prone") {
      self setstance("crouch");
    }
  }
}

enable_player_move_states() {
  if(!isDefined(self)) {
    return;
  }

  if(!isplayer(self)) {
    return;
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

spawn_path_node(origin, angles, k1, v1, k2, v2) {
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

spawn_path_node_internal(origin, angles, k1, v1, k2, v2) {
  if(isDefined(k2)) {
    return spawnpathnode("node_pathnode", origin, angles, k1, v1, k2, v2);
  } else if(isDefined(k1)) {
    return spawnpathnode("node_pathnode", origin, angles, k1, v1);
  } else {
    return spawnpathnode("node_pathnode", origin, angles);
  }

  return undefined;
}

delete_spawned_path_nodes() {}

respawn_path_nodes() {
  if(!isDefined(level._spawned_path_nodes)) {
    return;
  }

  for(i = 0; i < level._spawned_path_nodes.size; i++) {
    node_struct = level._spawned_path_nodes[i];
    println("<dev string:x3e9>" + node_struct.origin);
    node_struct.node = spawn_path_node_internal(node_struct.origin, node_struct.angles, node_struct.k1, node_struct.v1, node_struct.k2, node_struct.v2);
  }
}

undo_link_changes() {

  println("<dev string:x40c>");
  println("<dev string:x40c>");
  println("<dev string:x412>");

    delete_spawned_path_nodes();
}

redo_link_changes() {

  println("<dev string:x40c>");
  println("<dev string:x40c>");
  println("<dev string:x42d>");

    respawn_path_nodes();
}

is_gametype_active(a_gametypes) {
  b_is_gametype_active = 0;

  if(!isarray(a_gametypes)) {
    a_gametypes = array(a_gametypes);
  }

  for(i = 0; i < a_gametypes.size; i++) {
    if(util::get_game_type() == a_gametypes[i]) {
      b_is_gametype_active = 1;
    }
  }

  return b_is_gametype_active;
}

register_custom_spawner_entry(spot_noteworthy, func) {
  if(!isDefined(level.custom_spawner_entry)) {
    level.custom_spawner_entry = [];
  }

  level.custom_spawner_entry[spot_noteworthy] = func;
}

get_player_weapon_limit(player) {
  if(isDefined(self.get_player_weapon_limit)) {
    return [[self.get_player_weapon_limit]](player);
  }

  if(isDefined(level.get_player_weapon_limit)) {
    return [[level.get_player_weapon_limit]](player);
  }

  weapon_limit = 2;

  if(player hasperk(#"specialty_additionalprimaryweapon")) {
    weapon_limit = level.additionalprimaryweapon_limit;
  }

  return weapon_limit;
}

function_e05ac4ad(e_player, n_cost) {
  if(isDefined(level.var_236b9f7a) && [[level.var_236b9f7a]](e_player, self.clientfieldname)) {
    return false;
  }

  return e_player zm_score::can_player_purchase(n_cost);
}

get_player_perk_purchase_limit() {
  n_perk_purchase_limit_override = level.perk_purchase_limit;

  if(isDefined(level.get_player_perk_purchase_limit)) {
    n_perk_purchase_limit_override = self[[level.get_player_perk_purchase_limit]]();
  }

  return n_perk_purchase_limit_override;
}

can_player_purchase_perk() {
  if(self.num_perks < self get_player_perk_purchase_limit()) {
    return true;
  }

  if(self bgb::is_enabled(#"zm_bgb_unquenchable") || self bgb::is_enabled(#"zm_bgb_soda_fountain")) {
    return true;
  }

  return false;
}

wait_for_attractor_positions_complete() {
  self endon(#"death");
  self waittill(#"attractor_positions_generated");
  self.attract_to_origin = 0;
}

get_player_index(player) {
  assert(isplayer(player));
  assert(isDefined(player.characterindex));

  if(player.entity_num == 0 && getdvarstring(#"zombie_player_vo_overwrite") != "<dev string:x226>") {
    new_vo_index = getdvarint(#"zombie_player_vo_overwrite", 0);
    return new_vo_index;
  }

    return player.characterindex;
}

function_828bac1(n_character_index) {
  foreach(character in level.players) {
    if(character zm_characters::function_dc232a80() === n_character_index) {
      return character;
    }
  }

  return undefined;
}

zombie_goto_round(n_target_round) {
  level notify(#"restart_round");

  if(n_target_round < 1) {
    n_target_round = 1;
  }

  level.zombie_total = 0;
  level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), n_target_round);
  zm_round_logic::set_round_number(n_target_round);
  zombies = zombie_utility::get_round_enemy_array();

  if(isDefined(zombies)) {
    array::run_all(zombies, &kill);
  }

  level.sndgotoroundoccurred = 1;
  level waittill(#"between_round_over");
}

is_point_inside_enabled_zone(v_origin, ignore_zone) {
  if(function_21f4ac36()) {
    node = function_52c1730(v_origin, level.zone_nodes, 500);

    if(isDefined(node)) {
      zone = level.zones[node.targetname];

      if(isDefined(zone) && zone.is_enabled && zone !== ignore_zone) {
        return true;
      }
    }
  }

  if(function_c85ebbbc()) {
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
  }

  return false;
}

clear_streamer_hint() {
  if(isDefined(self.streamer_hint)) {
    self.streamer_hint delete();
    self.streamer_hint = undefined;
  }

  self notify(#"wait_clear_streamer_hint");
}

wait_clear_streamer_hint(lifetime) {
  self endon(#"wait_clear_streamer_hint");
  wait lifetime;

  if(isDefined(self)) {
    self clear_streamer_hint();
  }
}

create_streamer_hint(origin, angles, value, lifetime) {
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
  self notify(#"wait_clear_streamer_hint");

  if(isDefined(lifetime) && lifetime > 0) {
    self thread wait_clear_streamer_hint(lifetime);
  }
}

approximate_path_dist(player) {
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

  approx_dist = pathdistance(self.origin, goal_pos, 1, self);
  aiprofile_endentry();
  return approx_dist;
}

get_player_closest_to(e_target) {
  a_players = arraycopy(level.activeplayers);
  arrayremovevalue(a_players, e_target);
  e_closest_player = arraygetclosest(e_target.origin, a_players);
  return e_closest_player;
}

is_facing(facee, requireddot = 0.5, b_2d = 1) {
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

is_solo_ranked_game() {
  return level.players.size == 1 && getdvarint(#"zm_private_rankedmatch", 0);
}

function_e63cdbef() {
  return level.rankedmatch || getdvarint(#"zm_private_rankedmatch", 0);
}

function_a3648315() {
  if(!isDefined(level.var_b03a2fc8)) {
    level.var_b03a2fc8 = new throttle();
    [[level.var_b03a2fc8]] - > initialize(1, 0.1);
  }
}

function_ffc279(v_magnitude, e_attacker, n_damage, weapon) {
  self thread launch_ragdoll(v_magnitude, e_attacker, n_damage, weapon);
}

private launch_ragdoll(v_magnitude, e_attacker, n_damage = self.health, weapon) {
  self endon(#"death");

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  self.var_bfffc79e = 1;
  [[level.var_b03a2fc8]] - > waitinqueue(self);
  self startragdoll();
  self launchragdoll(v_magnitude);
  util::wait_network_frame();

  if(isDefined(self)) {
    self.var_bfffc79e = undefined;
    self dodamage(n_damage, self.origin, e_attacker, undefined, "none", "MOD_UNKNOWN", 0, weapon);
  }
}

set_max_health(var_54cb21f6 = 0) {
  if(self.health < self.var_66cb03ad) {
    self.health = self.var_66cb03ad;
  }

  if(var_54cb21f6) {
    if(self.health > self.var_66cb03ad) {
      self.health = self.var_66cb03ad;
    }
  }
}

function_13cc9756() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"zone_change");

    if(isDefined(waitresult.zone)) {
      self.inner_zigzag_radius = waitresult.zone.inner_zigzag_radius;
      self.outer_zigzag_radius = waitresult.zone.outer_zigzag_radius;
      self.zigzag_distance_min = waitresult.zone.zigzag_distance_min;
      self.zigzag_distance_max = waitresult.zone.zigzag_distance_max;
      self.zigzag_activation_distance = waitresult.zone.zigzag_activation_distance;
      self.var_592a8227 = waitresult.zone.zigzag_enabled;
    }
  }
}

function_45492cc4(var_cf5e7324 = 1) {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(self.owner)) {
    return false;
  }

  if(!(self.classname === "script_vehicle")) {
    return false;
  }

  if(var_cf5e7324 && isplayer(self.owner)) {
    return true;
  }

  return isDefined(self.owner);
}

function_1a4d2910() {
  if(isDefined(level.var_2456c78a)) {
    foreach(var_92254a2f in level.var_2456c78a) {
      if(distancesquared(self.origin, var_92254a2f) < 10000) {
        return true;
      }
    }
  }

  return false;
}

function_64259898(position, search_radius = 128) {
  goal_pos = getclosestpointonnavmesh(position, search_radius, self getpathfindingradius());

  if(isDefined(goal_pos)) {
    self setgoal(goal_pos);
    return true;
  }

  self setgoal(self.origin);
  return false;
}

function_372a1e12() {
  a_e_players = getplayers();
  e_least_hunted = undefined;

  foreach(e_player in a_e_players) {
    if(!isDefined(e_player.hunted_by)) {
      e_player.hunted_by = 0;
    }

    if(!is_player_valid(e_player)) {
      continue;
    }

    if(!isDefined(e_least_hunted) || e_player.hunted_by < e_least_hunted.hunted_by) {
      e_least_hunted = e_player;
    }
  }

  return e_least_hunted;
}

function_d7db256e(var_eaf129a0, var_6cc77d4e, var_888cf948 = 1, var_b96be97f = undefined) {
  if(isDefined(var_6cc77d4e)) {
    s_objective_loc = struct::get(var_eaf129a0);
    n_obj_id = function_f5a222a8(var_6cc77d4e, s_objective_loc.origin, var_b96be97f);
  }

  if(var_888cf948) {
    level thread function_75fd65f9(var_eaf129a0, 1);
  }

  return n_obj_id;
}

function_b1f3be5c(n_obj_id, var_eaf129a0) {
  if(isDefined(n_obj_id)) {
    gameobjects::release_obj_id(n_obj_id);
  }

  level thread function_75fd65f9(var_eaf129a0, 0);
}

function_ba39d198(n_obj_id, b_show = 1) {
  if(isDefined(n_obj_id)) {
    if(b_show) {
      objective_setvisibletoplayer(n_obj_id, self);
      return;
    }

    objective_setinvisibletoplayer(n_obj_id, self);
  }
}

function_f5a222a8(var_6cc77d4e, v_origin_or_ent, var_b96be97f = undefined) {
  n_obj_id = gameobjects::get_next_obj_id();
  objective_add(n_obj_id, "active", v_origin_or_ent, var_6cc77d4e);
  function_da7940a3(n_obj_id, 1);

  if(isDefined(var_b96be97f)) {
    foreach(player in getplayers()) {
      player thread function_71071944(n_obj_id, var_b96be97f);
    }
  }

  return n_obj_id;
}

function_71071944(n_obj_id, var_b96be97f) {
  level endon(#"game_ended", #"hash_1dabaf25a56177a1");
  self endon(#"disconnect");
  self.var_fbb52104 = n_obj_id;
  self.var_d4778e21 = var_b96be97f;

  while([[var_b96be97f]]()) {
    objective_setinvisibletoplayer(n_obj_id, self);
    waitframe(1);
  }

  objective_setvisibletoplayer(n_obj_id, self);

  if(isDefined(level.var_81c681aa) && level.var_81c681aa) {
    var_880caa89 = 1;

    foreach(e_player in getplayers()) {
      if(e_player[[var_b96be97f]]()) {
        var_880caa89 = 0;
      }
    }

    if(var_880caa89) {
      level flag::set(#"disable_fast_travel");
    }
  }
}

function_bc5a54a8(n_obj_id) {
  gameobjects::release_obj_id(n_obj_id);
}

function_75fd65f9(str_targetname, b_enable = 1) {
  if(!isDefined(str_targetname)) {
    return;
  }

  var_f8f0b389 = struct::get(str_targetname);
  var_2a7c782 = struct::get_array(var_f8f0b389.target);

  foreach(var_bf20477f in var_2a7c782) {
    if(b_enable) {
      if(isDefined(var_bf20477f.var_8e8faeba)) {
        var_bf20477f.var_8e8faeba clientfield::set("zm_zone_edge_marker_count", 0);
        util::wait_network_frame();
      } else {
        var_bf20477f.var_8e8faeba = util::spawn_model("tag_origin", var_bf20477f.origin, var_bf20477f.angles);
      }

      var_eb0f1280 = 3;

      if(isDefined(var_bf20477f.var_d229e574) && var_bf20477f.var_d229e574 > 0) {
        var_eb0f1280 = var_bf20477f.var_d229e574;
      }

      var_bf20477f.var_8e8faeba clientfield::set("zm_zone_edge_marker_count", var_eb0f1280);
      continue;
    }

    if(isDefined(var_bf20477f.var_8e8faeba)) {
      var_bf20477f.var_8e8faeba clientfield::set("zm_zone_edge_marker_count", 0);
      var_bf20477f.var_8e8faeba thread util::delayed_delete(1);
    }
  }
}

function_ebb2f490() {
  a_w_list = self getweaponslistprimaries();
  var_dc69b88b = [];

  foreach(w_list_weapon in a_w_list) {
    if(!isDefined(var_dc69b88b)) {
      var_dc69b88b = [];
    } else if(!isarray(var_dc69b88b)) {
      var_dc69b88b = array(var_dc69b88b);
    }

    var_dc69b88b[var_dc69b88b.size] = zm_weapons::function_93cd8e76(w_list_weapon);

    if(w_list_weapon.splitweapon != level.weaponnone) {
      if(!isDefined(var_dc69b88b)) {
        var_dc69b88b = [];
      } else if(!isarray(var_dc69b88b)) {
        var_dc69b88b = array(var_dc69b88b);
      }

      var_dc69b88b[var_dc69b88b.size] = zm_weapons::function_93cd8e76(w_list_weapon.splitweapon);
    }
  }

  return var_dc69b88b;
}

function_aa45670f(weapon, var_3a36e0dc) {
  root_weapon = zm_weapons::function_93cd8e76(weapon);

  if(isDefined(self.var_f6d3c3[var_3a36e0dc]) && isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
    var_dc69b88b = function_ebb2f490();

    if(isinarray(var_dc69b88b, root_weapon) || zm_weapons::function_93cd8e76(self.currentweapon) === root_weapon) {
      return true;
    }
  }

  return false;
}

function_28ee38f4(weapon, var_3a36e0dc, var_87f6ae5) {
  root_weapon = zm_weapons::function_93cd8e76(weapon);

  if(isDefined(self.var_f6d3c3[var_3a36e0dc]) && isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
    return false;
  }

  var_dc69b88b = function_ebb2f490();

  if(isinarray(var_dc69b88b, root_weapon) || zm_weapons::function_93cd8e76(self.currentweapon) === root_weapon) {
    if(!isDefined(self.var_f6d3c3[var_3a36e0dc])) {
      self.var_f6d3c3[var_3a36e0dc] = [];
    } else if(!isarray(self.var_f6d3c3[var_3a36e0dc])) {
      self.var_f6d3c3[var_3a36e0dc] = array(self.var_f6d3c3[var_3a36e0dc]);
    }

    self.var_f6d3c3[var_3a36e0dc][self.var_f6d3c3[var_3a36e0dc].size] = root_weapon;

    if(root_weapon.splitweapon !== level.weaponnone) {
      if(!isDefined(self.var_f6d3c3[var_3a36e0dc])) {
        self.var_f6d3c3[var_3a36e0dc] = [];
      } else if(!isarray(self.var_f6d3c3[var_3a36e0dc])) {
        self.var_f6d3c3[var_3a36e0dc] = array(self.var_f6d3c3[var_3a36e0dc]);
      }

      self.var_f6d3c3[var_3a36e0dc][self.var_f6d3c3[var_3a36e0dc].size] = root_weapon.splitweapon;
    }

    self thread function_13f40482();

    if(var_87f6ae5) {
      self zm_weapons::ammo_give(weapon);
    }

    return true;
  }

  return false;
}

function_18ce0c8(weapon, var_3a36e0dc) {
  root_weapon = zm_weapons::function_93cd8e76(weapon);

  if(!isDefined(self.var_f6d3c3[var_3a36e0dc]) || !isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
    return;
  }

  self.var_f6d3c3[var_3a36e0dc] = array::exclude(self.var_f6d3c3[var_3a36e0dc], root_weapon);

  if(root_weapon.splitweapon != level.weaponnone) {
    self.var_f6d3c3[var_3a36e0dc] = array::exclude(self.var_f6d3c3[var_3a36e0dc], root_weapon.splitweapon);
  }
}

function_13f40482() {
  self notify("680d457051e93357");
  self endon("680d457051e93357");
  self endon(#"disconnect");

  while(true) {
    self waittill(#"weapon_change");

    if(self scene::function_c935c42() || level flag::get("round_reset")) {
      continue;
    }

    var_dc69b88b = function_ebb2f490();

    for(i = 0; i < 1; i++) {
      foreach(var_406a430d in self.var_f6d3c3[i]) {
        if(!isinarray(var_dc69b88b, var_406a430d)) {
          self function_18ce0c8(var_406a430d, i);
        }
      }
    }
  }
}

function_fdb0368(n_round_number, str_endon) {
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  if(!isDefined(level.round_number) || level.round_number < n_round_number) {
    while(true) {
      s_waitresult = level waittill(#"start_of_round");

      if(s_waitresult.n_round_number >= n_round_number) {
        return;
      }
    }
  }
}

function_9ad5aeb1(var_a8d0b313 = 1, var_82ea43f2 = 1, b_hide_body = 0, var_b0e62e21 = 1, var_814b69d3 = 1, var_87c98387 = "white") {
  var_4b9821e4 = 0;
  a_players = util::get_active_players();

  foreach(player in a_players) {
    player val::set(#"hash_2f1b514922b9901e", "takedamage", 0);
  }

  if(!isarray(var_b0e62e21)) {
    if(var_b0e62e21) {
      if(var_814b69d3) {
        level thread lui::screen_flash(1, 1, 0.5, 1, var_87c98387);
      } else {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, var_87c98387);
      }
    }
  } else {
    var_72487f42 = var_b0e62e21[0];
    n_hold = var_b0e62e21[1];
    var_7012f1e9 = var_b0e62e21[2];
    n_alpha = array(0.8, 1)[var_814b69d3];
    level thread lui::screen_flash(var_72487f42, n_hold, var_7012f1e9, n_alpha, var_87c98387);
  }

  foreach(ai in getaiteamarray(level.zombie_team)) {
    if(isalive(ai) && !(isDefined(ai.var_d45ca662) && ai.var_d45ca662) && !(isDefined(ai.marked_for_death) && ai.marked_for_death)) {
      if(var_a8d0b313) {
        ai zm_cleanup::function_23621259(0);
      }

      if(var_82ea43f2 || ai.zm_ai_category !== #"basic" && ai.zm_ai_category !== #"popcorn" && ai.zm_ai_category !== #"enhanced") {
        if(is_magic_bullet_shield_enabled(ai)) {
          ai util::stop_magic_bullet_shield();
        }

        ai.allowdeath = 1;
        ai.no_powerups = 1;
        ai.deathpoints_already_given = 1;
        ai.marked_for_death = 1;

        if(!b_hide_body && (ai.zm_ai_category === #"basic" || ai.zm_ai_category === #"enhanced") && var_4b9821e4 < 6) {
          var_4b9821e4++;
          ai thread zombie_death::flame_death_fx();

          if(!(isDefined(ai.no_gib) && ai.no_gib)) {
            ai zombie_utility::zombie_head_gib();
          }
        }

        ai dodamage(ai.health + 666, ai.origin);

        if(b_hide_body) {
          ai hide();
          ai notsolid();
        }
      } else {
        ai delete();
      }
    }

    waitframe(1);
  }

  foreach(player in a_players) {
    if(isDefined(player)) {
      player val::reset(#"hash_2f1b514922b9901e", "takedamage");
    }
  }
}

function_508f636d() {
  level function_9ad5aeb1(0, 1, 0, 1, "black");
}

function_850e7499(weapon, var_20c27a34 = 0) {
  if(weapon === getweapon(#"eq_wraith_fire") || weapon === getweapon(#"eq_wraith_fire_extra")) {
    return true;
  }

  if(var_20c27a34 && weapon === getweapon(#"wraith_fire_fire")) {
    return true;
  }

  return false;
}

is_claymore(weapon) {
  if(weapon === getweapon(#"claymore") || weapon === getweapon(#"claymore_extra")) {
    return true;
  }

  return false;
}

function_b797694c(weapon) {
  if(weapon === getweapon(#"eq_acid_bomb") || weapon === getweapon(#"eq_acid_bomb_extra")) {
    return true;
  }

  return false;
}

is_frag_grenade(weapon) {
  if(weapon === getweapon(#"eq_frag_grenade") || weapon === getweapon(#"eq_frag_grenade_extra")) {
    return true;
  }

  return false;
}

is_mini_turret(weapon, var_b69165c7 = 0) {
  if(weapon === getweapon(#"mini_turret")) {
    return true;
  }

  if(var_b69165c7 && weapon === getweapon(#"gun_mini_turret")) {
    return true;
  }

  return false;
}

function_a2541519(var_da4af4df) {
  if(is_standard()) {
    var_da4af4df = level.var_aaf21bbb;
  }

  return var_da4af4df;
}

function_4a25b584(v_start_pos, var_487ba56d, n_radius = 512, b_randomize = 1, var_79ced64 = 0.2, n_half_height = 4, var_21aae2c6 = undefined) {
  level endon(#"end_game");
  var_bf08dccd = [];
  v_start_pos = groundtrace(v_start_pos + (0, 0, 8), v_start_pos + (0, 0, -100000), 0, undefined)[#"position"];

  if(isDefined(var_21aae2c6)) {
    s_result = positionquery_source_navigation(var_21aae2c6, 32, n_radius, n_half_height, 16, 1, 32);
  } else {
    s_result = positionquery_source_navigation(v_start_pos, 32, n_radius, n_half_height, 16, 1, 32);
  }

  if(isDefined(s_result) && isarray(s_result.data)) {
    if(b_randomize) {
      s_result.data = array::randomize(s_result.data);
    }

    foreach(var_c310df8c in s_result.data) {
      if(function_25e3484e(var_c310df8c.origin, 24, var_bf08dccd)) {
        var_7a4cb7eb = var_c310df8c.origin;
        n_height_diff = abs(var_7a4cb7eb[2] - v_start_pos[2]);

        if(n_height_diff > 60) {
          continue;
        }

        if(!isDefined(var_bf08dccd)) {
          var_bf08dccd = [];
        } else if(!isarray(var_bf08dccd)) {
          var_bf08dccd = array(var_bf08dccd);
        }

        var_bf08dccd[var_bf08dccd.size] = var_7a4cb7eb;

        if(var_bf08dccd.size > var_487ba56d + 20) {
          break;
        }
      }
    }
  }

  if(b_randomize) {
    var_bf08dccd = array::randomize(var_bf08dccd);
  }

  level.var_ec45f213 = 0;

  switch (level.players.size) {
    case 1:
      var_487ba56d = int(var_487ba56d * 0.5);
      break;
    case 2:
      var_487ba56d = int(var_487ba56d * 0.75);
      break;
  }

  if(var_487ba56d > var_bf08dccd.size) {
    var_487ba56d = var_bf08dccd.size;
  }

  var_487ba56d = int(max(var_487ba56d, 1));

  for(i = 0; i < var_487ba56d; i++) {
    e_powerup = function_ce46d95e(v_start_pos, 0, 0, 1);

    if(!isDefined(e_powerup)) {
      continue;
    }

    if(isDefined(var_bf08dccd[i])) {
      var_96bdce8a = length(v_start_pos - var_bf08dccd[i]);
      n_move_time = e_powerup fake_physicslaunch(var_bf08dccd[i] + (0, 0, 35), var_96bdce8a);
    } else {
      n_move_time = e_powerup fake_physicslaunch(v_start_pos + (0, 0, 35), n_radius / 3.5);
    }

    if(isDefined(level.var_b4ff4ec)) {
      e_powerup thread[[level.var_b4ff4ec]](n_move_time);
    }

    wait var_79ced64;
  }

  if(is_standard()) {
    level.var_ec45f213 = 1;
  }
}

function_25e3484e(v_pos, n_spacing = 400, var_3e807a14) {
  var_91890e6 = zm_powerups::get_powerups(v_pos, n_spacing);

  if(var_91890e6.size > 0) {
    return false;
  }

  if(isarray(var_3e807a14)) {
    foreach(var_a8f85c02 in var_3e807a14) {
      if(distance(v_pos, var_a8f85c02) < n_spacing) {
        return false;
      }
    }
  }

  if(isDefined(level.var_3e96c707)) {
    if(![
        [level.var_3e96c707]
      ](v_pos)) {
      return false;
    }
  }

  if(check_point_in_playable_area(v_pos) && check_point_in_enabled_zone(v_pos)) {
    return true;
  }

  return false;
}

function_ce46d95e(v_origin, b_permanent = 1, var_4ecce348 = 1, var_9a5654a5) {
  if(var_4ecce348) {
    while(level.active_powerups.size >= 75) {
      waitframe(1);
    }
  }

  if(level.active_powerups.size < 75) {
    e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", v_origin, undefined, var_9a5654a5, undefined, b_permanent, 1);

    if(isDefined(e_powerup)) {
      if(isDefined(level.var_48e2ab90)) {
        e_powerup setscale(level.var_48e2ab90);
      }

      if(isDefined(level.var_6463d67c)) {
        e_powerup.var_258c5fbc = level.var_6463d67c;
      }
    }
  }

  return e_powerup;
}

is_jumping() {
  ground_ent = self getgroundent();
  return !isDefined(ground_ent);
}

function_9f7fd525(var_c61df77f = "zombie_location", a_str_zones, var_a6f0ec9f = 1) {
  a_s_locs = [];

  if(isDefined(a_str_zones)) {
    if(!isDefined(a_str_zones)) {
      a_str_zones = [];
    } else if(!isarray(a_str_zones)) {
      a_str_zones = array(a_str_zones);
    }

    if(var_a6f0ec9f) {
      var_5386ca1d = level.zm_loc_types[var_c61df77f];
    } else {
      var_5386ca1d = struct::get_array("spawn_location", "script_noteworthy");
    }

    foreach(str_zone in a_str_zones) {
      foreach(s_loc in var_5386ca1d) {
        if(str_zone === s_loc.zone_name) {
          if(!isDefined(a_s_locs)) {
            a_s_locs = [];
          } else if(!isarray(a_s_locs)) {
            a_s_locs = array(a_s_locs);
          }

          if(!isinarray(a_s_locs, s_loc)) {
            a_s_locs[a_s_locs.size] = s_loc;
          }
        }
      }
    }
  } else if(var_a6f0ec9f) {
    var_5386ca1d = level.zm_loc_types[var_c61df77f];
  } else {
    var_5386ca1d = struct::get_array("spawn_location", "script_noteworthy");
  }

  return a_s_locs;
}

function_7618c8ef(var_6e4c63cc = 0.0667) {
  n_damage_multiplier = 1;

  if(isDefined(self.ignore_health_regen_delay) && self.ignore_health_regen_delay) {
    n_damage_multiplier += 1.25;

    if(self hasperk(#"specialty_quickrevive")) {
      n_damage_multiplier += 0.75;
    }
  }

  var_16e6b8ea = int(self.maxhealth * var_6e4c63cc * n_damage_multiplier);
  return var_16e6b8ea;
}