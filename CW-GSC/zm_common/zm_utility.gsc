/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_utility.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using scripts\abilities\ability_util;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\battletracks;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_ai_faller;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_camos;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_server_throttle;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_utility;

function private autoexec __init__system__() {
  system::register(#"zm_utility", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.armorType", 1, 2, "int", 0);
  clientfield::register_clientuimodel("hudItems.armorPercent", 1, 7, "float", 0);
  clientfield::register_clientuimodel("hudItems.scrap", 1, 16, "int", 0);
  clientfield::register_clientuimodel("hudItems.rareScrap", 1, 16, "int", 0);
  clientfield::register_clientuimodel("pap_current", 1, 2, "int", 0);
  clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int");
  clientfield::register("actor", "flame_corpse_fx", 1, 1, "int");
  clientfield::register("scriptmover", "model_rarity_rob", 1, 3, "int");
  clientfield::register("scriptmover", "set_compass_icon", 1, 1, "int");
  clientfield::register("scriptmover", "force_stream", 1, 1, "int");
  level thread function_725e99fb();

  for(i = 0; i < 5; i++) {
    clientfield::function_5b7d846d("PlayerList.client" + i + ".playerIsDowned", 1, 1, "int");
    clientfield::function_5b7d846d("PlayerList.client" + i + ".self_revives", 1, 8, "int");
  }

  level.var_e63703cd = [];
  level.var_49f8cef4 = &function_bc5a54a8;
  callback::on_connect(&function_3ba26955);
  callback::on_disconnect(&on_disconnect);

  util::init_dvar(#"hash_26af2f9714c95db1", 0, &function_452938ed);

  if(!isDefined(level.var_75b29eed)) {
    level.var_75b29eed = new class_c6c0e94();
    [[level.var_75b29eed]] - > initialize(#"hash_14845cc22a76cc27", 10, 0.2);
  }

  level.var_a2ed0864 = &get_round_number;
  level.var_8f1e0b55 = &function_ffc279;
}

function private postinit() {}

function init_utility() {
  level thread check_solo_status();
}

function is_classic() {
  if(!isDefined(level.var_8d156cf3)) {
    level.var_8d156cf3 = util::get_game_type() == # "zclassic" || util::get_game_type() == # "zholiday";
  }

  return level.var_8d156cf3;
}

function is_survival() {
  if(!isDefined(level.var_50d2a17f)) {
    level.var_50d2a17f = util::get_game_type() == # "zsurvival";
  }

  return level.var_50d2a17f;
}

function function_c200446c() {
  if(!isDefined(level.var_e9ff2970)) {
    level.var_e9ff2970 = util::get_game_type() == # "zonslaught" || is_true(level.var_ce3ac5b6);
  }

  return level.var_e9ff2970;
}

function is_standard() {
  if(!isDefined(level.var_9bd33c61)) {
    level.var_9bd33c61 = util::get_game_type() == # "zstandard";
  }

  return level.var_9bd33c61;
}

function is_trials() {
  if(!isDefined(level.var_bc0dd8f3)) {
    level.var_bc0dd8f3 = util::get_game_type() == # "hash_32a608b582834498";
  }

  return level.var_bc0dd8f3 || level flag::exists(#"ztrial");
}

function is_tutorial() {
  if(!isDefined(level.var_f9cd414c)) {
    level.var_f9cd414c = util::get_game_type() == # "ztutorial";
  }

  return level.var_f9cd414c;
}

function is_grief() {
  if(!isDefined(level.var_80b0bb3d)) {
    level.var_80b0bb3d = util::get_game_type() == # "zgrief";
  }

  return level.var_80b0bb3d;
}

function function_c4b020f8() {
  if(!isDefined(level.var_7ef56397)) {
    level.var_7ef56397 = util::get_game_type() == # "zcranked";
  }

  return level.var_7ef56397;
}

function function_6931bc89() {
  if(!isDefined(level.var_2abedddf)) {
    level.var_2abedddf = util::get_game_type() == # "doa";
  }

  return level.var_2abedddf;
}

function function_d6046228(str_classic, var_756ee4e5, var_bcb9de3e, var_299ea954, str_trials, var_1e31f083) {
  if(is_trials()) {
    if(self function_8b1a219a() && isDefined(var_1e31f083)) {
      return var_1e31f083;
    } else if(isDefined(str_trials)) {
      return str_trials;
    }
  } else if(is_standard()) {
    if(self function_8b1a219a() && isDefined(var_299ea954)) {
      return var_299ea954;
    } else if(isDefined(var_bcb9de3e)) {
      return var_bcb9de3e;
    }
  }

  if(self function_8b1a219a() && isDefined(var_756ee4e5)) {
    return var_756ee4e5;
  }

  return str_classic;
}

function get_cast() {
  return zm_maptable::get_cast();
}

function get_story() {
  return zm_maptable::get_story();
}

function check_solo_status() {
  if(getnumexpectedplayers() == 1 && (!sessionmodeisonlinegame() || sessionmodeisprivate() || zm_trial::is_trial_mode() || getdvarint(#"com_maxclients", 0) == 1)) {
    level.is_forever_solo_game = 1;
    return;
  }

  level.is_forever_solo_game = 0;
}

function init_zombie_run_cycle() {
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

function change_zombie_run_cycle() {
  level.speed_change_num++;

  if(level.gamedifficulty == 0) {
    self zombie_utility::set_zombie_run_cycle("sprint");
  } else {
    self zombie_utility::set_zombie_run_cycle("run");
  }

  self thread speed_change_watcher();
}

function make_supersprinter() {
  self zombie_utility::set_zombie_run_cycle("super_sprint");
}

function speed_change_watcher() {
  self waittill(#"death");

  if(level.speed_change_num > 0) {
    level.speed_change_num--;
  }
}

function move_zombie_spawn_location(spot) {
  self endon(#"death");

  if(isDefined(self.spawn_pos)) {
    self notify(#"risen", {
      #find_flesh_struct_string: self.spawn_pos.script_string
    });
    return;
  }

  self.spawn_pos = spot;

  if(!isDefined(spot)) {
    return;
  }

  if(isDefined(spot.target)) {
    self.target = spot.target;
  }

  if(isDefined(spot.zone_name)) {
    self.zone_name = spot.zone_name;
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

      if(!is_true(self.dontshow)) {
        self show();
      }

      self notify(#"risen", {
        #find_flesh_struct_string: spot.script_string
      });
    }
  }
}

function anchor_delete_failsafe(ai_zombie) {
  ai_zombie endon(#"risen");
  ai_zombie waittill(#"death");

  if(isDefined(self)) {
    self delete();
  }
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
    assert(isDefined(barrier_chunks), "<dev string:x38>");

    for(i = 0; i < barrier_chunks.size; i++) {
      if(barrier_chunks[i] get_chunk_state() != "destroyed") {
        return false;
      }
    }
  }

  return true;
}

function check_point_in_playable_area(origin) {
  if(function_21f4ac36() && !isDefined(level.var_a2a9b2de)) {
    level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
  }

  if(function_c85ebbbc() && !isDefined(level.playable_area)) {
    level.playable_area = getEntArray("player_volume", "script_noteworthy");
  }

  valid_point = 0;

  if(isDefined(level.playable_area)) {
    var_12ed21a1 = function_72d3bca6(level.playable_area, origin, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      if(istouching(origin, area)) {
        valid_point = 1;
        break;
      }
    }
  }

  if(isDefined(level.var_a2a9b2de) && !valid_point) {
    node = function_52c1730(origin + (0, 0, 40), level.var_a2a9b2de, 500);

    if(isDefined(node)) {
      valid_point = 1;
    }
  }

  return valid_point;
}

function check_point_in_enabled_zone(origin, zone_is_active, player_zones, player_regions) {
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

  if(isDefined(player_zones)) {
    var_f9ef6a14 = origin + (0, 0, 40);
    var_12ed21a1 = function_72d3bca6(level.playable_area, var_f9ef6a14, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      zone = level.zones[area.targetname];

      if(isDefined(zone) && is_true(zone.is_enabled)) {
        if(zone_is_active === 1 && !is_true(zone.is_active)) {
          continue;
        }

        if(istouching(var_f9ef6a14, area)) {
          one_valid_zone = 1;
          break;
        }
      }
    }
  }

  if(isDefined(player_regions) && !one_valid_zone) {
    node = function_52c1730(origin + (0, 0, 40), player_regions, 500);

    if(isDefined(node)) {
      zone = level.zones[node.targetname];

      if(isDefined(zone) && is_true(zone.is_enabled)) {
        if(zone_is_active === 1 && !is_true(zone.is_active)) {
          one_valid_zone = 0;
        } else {
          one_valid_zone = 1;
        }
      }
    }
  }

  return one_valid_zone;
}

function round_up_to_ten(score) {
  new_score = score - score % 10;

  if(new_score < score) {
    new_score += 10;
  }

  return new_score;
}

function round_up_score(score, value = 5) {
  score = int(score);
  new_score = score - score % value;

  if(new_score < score) {
    new_score += value;
  }

  return new_score;
}

function halve_score(n_score) {
  n_score /= 2;
  n_score = round_up_score(n_score);
  return n_score;
}

function create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on, initial_attract_func, arrival_attract_func, poi_team) {
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

function watch_for_poi_death() {
  self waittill(#"death");

  if(isinarray(level.zombie_poi_array, self)) {
    arrayremovevalue(level.zombie_poi_array, self);
  }
}

function debug_draw_new_attractor_positions() {
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

function create_zombie_point_of_interest_attractor_positions(var_b09c2334 = 15, n_height = 60, var_6b5dd73c, var_7262d151 = 0) {
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
      if(is_true(level.var_565d6ce0)) {
        recordstar(queryresult.data[i].origin, (1, 0, 0));
        record3dtext("<dev string:x7b>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
      }

      continue;
    }

    if(is_true(level.validate_poi_attractors)) {
      passed = bullettracepassed(queryresult.data[i].origin + (0, 0, 24), self.origin + (0, 0, 24), 0, self);

      if(passed) {
        self.attractor_positions[position_index] = queryresult.data[i].origin;
        position_index++;
      } else {
        if(is_true(level.var_565d6ce0)) {
          recordstar(queryresult.data[i].origin, (1, 0, 0));
          record3dtext("<dev string:x93>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
        }
      }
    } else if(is_true(self.var_abfcb0d9)) {
      if(check_point_in_enabled_zone(queryresult.data[i].origin) && check_point_in_playable_area(queryresult.data[i].origin)) {
        self.attractor_positions[position_index] = queryresult.data[i].origin;
        position_index++;
      }
    } else {
      self.attractor_positions[position_index] = queryresult.data[i].origin;
      position_index++;

      if(is_true(level.var_565d6ce0)) {
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

function generated_radius_attract_positions(forward, offset, num_positions, attract_radius) {
  self endon(#"death");
  failed = 0;
  degs_per_pos = 360 / num_positions;
  i = offset;

  while(i < 360 + offset) {
    altforward = forward * attract_radius;
    rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);

    if(isDefined(level.poi_positioning_func)) {
      pos = [[level.poi_positioning_func]](self.origin, rotated_forward);
    } else if(is_true(level.use_alternate_poi_positioning)) {
      pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 10));
    } else {
      pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 100));
    }

    if(!isDefined(pos)) {
      failed++;
    } else if(is_true(level.use_alternate_poi_positioning)) {
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

function debug_draw_attractor_positions() {
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

function debug_draw_claimed_attractor_positions() {
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

  if(is_true(self.ignore_all_poi)) {
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
  var_a9740555 = undefined;
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

    if(is_true(best_poi._new_ground_trace)) {
      var_a9740555 = {};
      var_a9740555.position = groundpos_ignore_water_new(best_poi.origin + (0, 0, 100));
      var_a9740555.poi_ent = best_poi;
    } else if(isDefined(best_poi.attract_to_origin) && best_poi.attract_to_origin) {
      var_a9740555 = {};
      var_a9740555.position = groundpos(best_poi.origin + (0, 0, 100));
      var_a9740555.poi_ent = best_poi;
    } else {
      var_a9740555 = self add_poi_attractor(best_poi);
    }

    if(isDefined(best_poi.initial_attract_func)) {
      self thread[[best_poi.initial_attract_func]](best_poi);
    }

    if(isDefined(best_poi.arrival_attract_func)) {
      self thread[[best_poi.arrival_attract_func]](best_poi);
    }
  }

  aiprofile_endentry();
  return var_a9740555;
}

function activate_zombie_point_of_interest() {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }

  self.poi_active = 1;
}

function deactivate_zombie_point_of_interest(dont_remove) {
  if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "zombie_poi") {
    return;
  }

  arrayremovevalue(self.attractor_array, undefined);

  for(i = 0; i < self.attractor_array.size; i++) {
    self.attractor_array[i] notify(#"kill_poi");
  }

  self.attractor_array = [];
  self.claimed_attractor_positions = [];
  self.attractor_positions = [];
  self.poi_active = 0;

  if(is_true(dont_remove)) {
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

function remove_poi_attractor(zombie_poi) {
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

function array_check_for_dupes_using_compare(array, single, is_equal_fn) {
  for(i = 0; i < array.size; i++) {
    if([[is_equal_fn]](array[i], single)) {
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
      if(is_true(level.validate_poi_attractors)) {
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
    return {
      #position: best_pos, #poi_ent: zombie_poi
    };
  } else {
    for(i = 0; i < zombie_poi.attractor_array.size; i++) {
      if(zombie_poi.attractor_array[i] == self) {
        if(isDefined(zombie_poi.claimed_attractor_positions) && isDefined(zombie_poi.claimed_attractor_positions[i])) {
          return {
            #position: zombie_poi.claimed_attractor_positions[i], #poi_ent: zombie_poi
          };
        }
      }
    }
  }

  return undefined;
}

function function_49f80b6f(entity) {
  return entity.zombie_poi.position;
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
  self endon(#"kill_poi");
  self waittill(#"death");
  self remove_poi_attractor(zombie_poi);
}

function update_on_poi_removal(zombie_poi) {
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

function invalidate_attractor_pos(attractor_pos, zombie) {
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
  d = distancesquared(self.origin, player.origin);

  if(d <= 1296) {
    return true;
  }

  return false;
}

function function_d0f02e71(archetype) {
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

function function_55295a16() {
  level endon(#"end_game");
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
      if(is_true(zombie.need_closest_player)) {
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

function private function_5dcc54a8(players) {
  if(isDefined(self.last_closest_player) && is_true(self.last_closest_player.am_i_valid)) {
    return;
  }

  self.need_closest_player = 1;

  if(!isDefined(players)) {
    players = [];
  } else if(!isarray(players)) {
    players = array(players);
  }

  foreach(player in players) {
    if(is_true(player.am_i_valid)) {
      self.last_closest_player = player;
      return;
    }
  }

  self.last_closest_player = undefined;
}

function function_c52e1749(origin, players) {
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
          #player: player, #origin: pos
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
            if(distance2dsquared(position, goalpos) < sqr(16) && abs(position[2] - goalpos[2]) <= level.var_cd24b30) {
              closestplayer = players[index];
            }

            continue;
          }

          if(distancesquared(position, goalpos) < sqr(16)) {
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
    self.var_c6e0686b = sqr(pathdata.pathdistance);
  }

  self function_5dcc54a8(players);
  return self.last_closest_player;
}

function function_3d70ba7a(origin, players) {
  if(players.size == 0) {
    return undefined;
  }

  if(isDefined(self.zombie_poi)) {
    return undefined;
  }

  if(players.size == 1 && !is_true(self.var_15d21bbf)) {
    self.last_closest_player = players[0];
    self.var_c6e0686b = distancesquared(players[0].origin, origin);
    self function_5dcc54a8(players[0]);
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
        player_pos = getclosestpointonnavmesh(player_pos, 100, var_88e86621.radius);
      }

      pos = isDefined(player_pos) ? player_pos : player.origin;

      if(!isDefined(playerpositions)) {
        playerpositions = [];
      } else if(!isarray(playerpositions)) {
        playerpositions = array(playerpositions);
      }

      playerpositions[playerpositions.size] = pos;

      if(!isDefined(self.var_2d5cbb7[player getentitynumber()])) {
        self.var_2d5cbb7[player getentitynumber()] = {
          #var_e29d2657: 0, #dist: -1
        };
      }

      position_info = {
        #player: player, #origin: pos
      };

      if(!isDefined(var_448ee423)) {
        var_448ee423 = [];
      } else if(!isarray(var_448ee423)) {
        var_448ee423 = array(var_448ee423);
      }

      var_448ee423[var_448ee423.size] = position_info;
    }
  }

  closestplayer = undefined;
  self.var_c6e0686b = undefined;

  if(!isDefined(self.var_2d5cbb7)) {
    self.var_2d5cbb7 = [];
  }

  var_abdf4916 = 0;
  var_9b606bab = undefined;

  if(ispointonnavmesh(var_88e86621.origin, self)) {
    var_5e1a4c24 = -1;
    var_3f11f493 = -1;

    for(i = 0; i < var_448ee423.size; i++) {
      var_68a2859a = self.var_2d5cbb7[var_448ee423[i].player getentitynumber()].var_e29d2657;

      if(var_5e1a4c24 == -1 || var_68a2859a < var_3f11f493) {
        var_3f11f493 = var_68a2859a;
        var_5e1a4c24 = i;
      }
    }

    var_674755ca = function_5cb65d8a(var_88e86621.origin, playerpositions, self, var_88e86621.radius, var_88e86621.height, -1, var_5e1a4c24, 1000);

    if(!isDefined(var_674755ca)) {
      return undefined;
    }

    for(i = 0; i < var_674755ca.size; i++) {
      target = var_448ee423[i].player;

      if(var_674755ca[i] == -2) {
        var_674755ca[i] = self.var_2d5cbb7[target getentitynumber()].dist;
        continue;
      }

      self.var_2d5cbb7[target getentitynumber()].dist = var_674755ca[i];
      self.var_2d5cbb7[target getentitynumber()].var_e29d2657 = gettime();
    }

    var_e3958ef0 = arraycopy(var_674755ca);
    var_8aa6bded = -1;
    closest_target = undefined;

    for(i = 0; i < var_674755ca.size; i++) {
      if(var_674755ca[i] != -1) {
        if(!isDefined(closest_target) || var_8aa6bded > var_674755ca[i]) {
          closest_target = var_448ee423[i].player;
          var_8aa6bded = var_674755ca[i];
        }
      }
    }

    if(!isDefined(closest_target)) {
      return undefined;
    }

    for(i = 0; i < var_674755ca.size; i++) {
      potential_target = var_448ee423[i].player;

      if(isDefined(self.var_448aebc7[potential_target getentitynumber()])) {
        var_ab0d150d = self.var_448aebc7[potential_target getentitynumber()];
        var_7e10832f = 2;

        if(isDefined(self.var_ad033811)) {
          var_7e10832f = [[self.var_ad033811]](potential_target, var_ab0d150d);
        }

        var_e3958ef0[i] -= sqr(var_ab0d150d * var_7e10832f);
      }

      if(isDefined(self.var_d5e58936)) {
        var_e3958ef0[i] = [[self.var_d5e58936]](potential_target, var_e3958ef0[i]);
      }
    }

    var_abdf4916 = 0;
    var_9b606bab = undefined;

    for(i = 0; i < var_448ee423.size; i++) {
      if(var_674755ca[i] == -1) {
        continue;
      }

      if(var_e3958ef0[i] < var_abdf4916 || !isDefined(var_9b606bab)) {
        var_abdf4916 = var_e3958ef0[i];
        var_9b606bab = var_448ee423[i].player;
      }
    }

    if(!is_true(self.var_d8861a5f)) {
      if(!is_true(self.var_982e6932)) {
        if(closest_target == var_9b606bab) {
          self.var_982e6932 = 1;
          self.var_927ef4c0 = gettime() + 3000;
          self.var_448aebc7 = undefined;
          self.var_29a3768c = undefined;
        }

        self.last_closest_player = var_9b606bab;
        self.var_c6e0686b = var_abdf4916;
      } else {
        if(gettime() > self.var_927ef4c0) {
          self.var_982e6932 = 0;
        }

        self.last_closest_player = closest_target;
        self.var_c6e0686b = var_8aa6bded;
      }
    } else {
      self.last_closest_player = var_9b606bab;
    }

    if(isDefined(self.var_8a3828c6)) {
      var_e65cda3e = var_674755ca[self.var_8a3828c6 getentitynumber()];

      if(var_e65cda3e === -1) {
        zm_ai_utility::function_68ab868a(self);
        self.favoriteenemy = undefined;
        return;
      } else {
        self.var_c6e0686b = 0;
        self.last_closest_player = self.var_8a3828c6;
      }
    }
  }

  self.var_26f25576 = gettime();

  if(getDvar(#"hash_169a29e17dd1b916", 0) > 0) {
    var_edbf2d06 = "<dev string:xaa>";

    for(i = 0; i < var_448ee423.size; i++) {
      target = var_448ee423[i].player;
      score = var_e3958ef0[i];

      if(isDefined(target) && isDefined(var_9b606bab)) {
        color = var_9b606bab == target ? "<dev string:xae>" : "<dev string:xb4>";

        if(isDefined(self.var_29a3768c[target getentitynumber()])) {
          var_f24e54b = "<dev string:xba>" + self.var_29a3768c[target getentitynumber()];
        }

        var_edbf2d06 = color + "<dev string:xce>" + target getentitynumber() + "<dev string:xd7>" + score;
      } else {
        var_edbf2d06 = "<dev string:xe8>";
      }

      record3dtext(var_edbf2d06, self.origin + (0, 0, 80 - 30 * i), (1, 1, 1), "<dev string:xf8>", self, 0.5);

      if(isDefined(var_674755ca[i])) {
        record3dtext("<dev string:x102>" + var_674755ca[i], self.origin + (0, 0, 75 - 30 * i), (1, 1, 1), "<dev string:xf8>", self, 0.5);
      }
    }

    if(isDefined(self.var_c2dcab66)) {
      var_edbf2d06 = "<dev string:xaa>";

      foreach(attacker in self.var_c2dcab66) {
        var_76fc2ac9 = (gettime() - attacker.time) * 0.001;

        if(isDefined(attacker.player) && isDefined(self.var_448aebc7[attacker.player getentitynumber()])) {
          var_edbf2d06 += "<dev string:xce>" + attacker.player getentitynumber() + "<dev string:x10e>" + self.var_448aebc7[attacker.player getentitynumber()] + "<dev string:x115>" + var_76fc2ac9 + "<dev string:x120>";
        }
      }

      record3dtext(var_edbf2d06, self.origin + (0, 0, -20), (1, 1, 1), "<dev string:xf8>", self, 0.5);
    }

    if(is_true(self.var_982e6932)) {
      record3dtext("<dev string:x125>", self.origin + (0, 0, -25), (0, 1, 0), "<dev string:xf8>", self, 0.5);
    }
  }

  self function_5dcc54a8(players);
  return self.last_closest_player;
}

function function_d89330e6(player, var_21b12302 = 0) {
  if(!isDefined(player)) {
    return -1;
  }

  player_num = player getentitynumber();
  dist_to_player = -1;

  if(isDefined(self.var_2d5cbb7[player_num].dist)) {
    dist_to_player = self.var_2d5cbb7[player_num].dist;
  }

  if(is_true(var_21b12302) && dist_to_player < 0) {
    dist_to_player = distance2d(self.origin, player.origin);
  }

  return dist_to_player;
}

function get_closest_valid_player(origin, ignore_player = array(), var_b106b254 = 0) {
  aiprofile_beginentry("get_closest_valid_player");
  players = getplayers();

  if(isDefined(level.zombie_targets) && level.zombie_targets.size > 0) {
    function_1eaaceab(level.zombie_targets);
    arrayremovevalue(level.zombie_targets, undefined);
    players = arraycombine(players, level.zombie_targets, 0, 0);
  }

  b_designated_target_exists = 0;

  foreach(player in players) {
    if(!is_true(player.am_i_valid)) {
      continue;
    }

    if(isDefined(level.var_63707e9c)) {
      if(![[level.var_63707e9c]](player)) {
        array::add(ignore_player, player);
      }
    }

    if(is_true(player.b_is_designated_target)) {
      b_designated_target_exists = 1;
    }

    if(isDefined(level.var_6f6cc58)) {
      if(![[level.var_6f6cc58]](player)) {
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

      if(!is_true(player.am_i_valid)) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }

      if(b_designated_target_exists && !is_true(player.b_is_designated_target)) {
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

  var_3bd0e427 = undefined;

  if(isDefined(player.last_valid_position)) {
    var_3bd0e427 = player.last_valid_position[2];
    var_171dce2 = abs(player.last_valid_position[2] - self.origin[2]);
    var_1029d6d2 = self function_6a9ae71();

    if(distance2dsquared(self.origin, player.last_valid_position) < sqr(self getpathfindingradius()) && var_171dce2 > var_1029d6d2 * 0.25 && var_171dce2 < var_1029d6d2 || abs(self.origin[2] - player.last_valid_position[2]) < var_1029d6d2 * 0.25) {
      var_3bd0e427 = self.origin[2];
    }
  }

  var_3d3d6684 = length(player getvelocity());

  if(!(isDefined(player.last_valid_position) && isDefined(var_3bd0e427)) || !isDefined(player getgroundent()) && !player isonladder() && var_3d3d6684 != 0 || distancesquared(player.last_valid_position, player.origin) < (isDefined(self.var_154478e3) ? self.var_154478e3 : sqr(var_3d3d6684 + 45)) && abs(var_3bd0e427 - player.origin[2]) < (isDefined(self.var_737e8510) ? self.var_737e8510 : level.var_376e688) && (is_true(level.var_9f01688e) || !is_true(player.cached_zone_volume.var_8e4005b6))) {
    if(isDefined(self.var_81e5ae7) && is_true([[self.var_81e5ae7]](player))) {
      zm_ai_utility::function_68ab868a(self);
    } else {
      zm_ai_utility::function_4d22f6d1(self);
    }
  } else {
    zm_ai_utility::function_68ab868a(self);
  }

  aiprofile_endentry();
  return player;
}

function update_valid_players(origin, ignore_player) {
  aiprofile_beginentry("update_valid_players");
  players = arraycopy(level.players);

  foreach(player in players) {
    self setignoreent(player, 1);
  }

  b_designated_target_exists = 0;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!is_true(player.am_i_valid)) {
      continue;
    }

    if(isDefined(level.var_63707e9c)) {
      if(![[level.var_63707e9c]](player)) {
        array::add(ignore_player, player);
      }
    }

    if(is_true(player.b_is_designated_target)) {
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

      if(!is_true(player.am_i_valid)) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }

      if(b_designated_target_exists && !is_true(player.b_is_designated_target)) {
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

function is_player_valid(e_player, var_11e899f9 = 0, var_67fee570 = 0, var_6eefd462 = 1, var_da861165 = 1) {
  if(!isDefined(e_player)) {
    return 0;
  }

  if(!isentity(e_player)) {
    return 0;
  }

  if(!isPlayer(e_player)) {
    return 0;
  }

  if(!isalive(e_player)) {
    return 0;
  }

  if(is_true(e_player.is_zombie)) {
    return 0;
  }

  if(e_player.sessionstate == "spectator" || e_player.sessionstate == "intermission") {
    return 0;
  }

  if(is_true(level.intermission)) {
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

function function_1a01f2f7(e_player) {
  return isDefined(e_player.var_c069e1cd) && isDefined(level.var_173b2973) && is_true(e_player.var_c069e1cd >= level.var_173b2973);
}

function get_number_of_valid_players() {
  players = getplayers();
  num_player_valid = 0;

  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i])) {
      num_player_valid += 1;
    }
  }

  return num_player_valid;
}

function in_revive_trigger() {
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

function non_destroyed_bar_board_order(origin, chunks) {
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

function vehicle_outline_watcher(origin, chunks_grate) {
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
            iprintlnbold("<dev string:x13b>");

            grate_order3[i] thread show_grate_pull();
            return grate_order2[i];
          }

          if(grate_order3[i].state == "repaired") {
            iprintlnbold("<dev string:x14a>");

            grate_order4[i] thread show_grate_pull();
            return grate_order3[i];
          }

          if(grate_order4[i].state == "repaired") {
            iprintlnbold("<dev string:x159>");

            grate_order5[i] thread show_grate_pull();
            return grate_order4[i];
          }

          if(grate_order5[i].state == "repaired") {
            iprintlnbold("<dev string:x168>");

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

function show_grate_pull() {
  wait 0.53;
  self show();
  self vibrate((0, 270, 0), 0.2, 0.4, 0.4);
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
  if(function_21f4ac36() && !isDefined(level.var_a2a9b2de)) {
    level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
  }

  if(function_c85ebbbc() && !isDefined(level.playable_area)) {
    level.playable_area = getEntArray("player_volume", "script_noteworthy");
  }

  if(!isDefined(level.playable_area) && !isDefined(level.var_a2a9b2de)) {
    println("<dev string:x177>");
    return true;
  }

  if(isDefined(level.playable_area)) {
    var_12ed21a1 = function_72d3bca6(level.playable_area, self.origin, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      if(self istouching(area)) {
        return true;
      }
    }
  }

  if(isDefined(level.var_a2a9b2de)) {
    node = function_52c1730(self.origin, level.var_a2a9b2de, 500);

    if(isDefined(node)) {
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
  } else if(isDefined(chunks)) {
    return non_destroyed_bar_board_order(origin, chunks);
  } else if(isDefined(chunks_grate)) {
    return vehicle_outline_watcher(origin, chunks_grate);
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
          iprintlnbold("<dev string:x1be>");

          return grate_repair_order6[i];
        }

        if(grate_repair_order5[i].state == "destroyed") {
          iprintlnbold("<dev string:x1ce>");

          grate_repair_order6[i] thread show_grate_repair();
          return grate_repair_order5[i];
        }

        if(grate_repair_order4[i].state == "destroyed") {
          iprintlnbold("<dev string:x1de>");

          grate_repair_order5[i] thread show_grate_repair();
          return grate_repair_order4[i];
        }

        if(grate_repair_order3[i].state == "destroyed") {
          iprintlnbold("<dev string:x1ee>");

          grate_repair_order4[i] thread show_grate_repair();
          return grate_repair_order3[i];
        }

        if(grate_repair_order2[i].state == "destroyed") {
          iprintlnbold("<dev string:x1fe>");

          grate_repair_order3[i] thread show_grate_repair();
          return grate_repair_order2[i];
        }

        if(grate_repair_order1[i].state == "destroyed") {
          iprintlnbold("<dev string:x20e>");

          grate_repair_order2[i] thread show_grate_repair();
          return grate_repair_order1[i];
        }
      }
    }
  }
}

function show_grate_repair() {
  wait 0.34;
  self hide();
}

function get_chunk_state() {
  assert(isDefined(self.state));
  return self.state;
}

function fake_physicslaunch(target_pos, power) {
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

  println("<dev string:x21e>" + ref);
  return level.zombie_hints[#"undefined"];
}

function set_hint_string(ent, default_ref, cost) {
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

function get_hint_string(ent, default_ref, cost) {
  ref = cost;

  if(isDefined(default_ref.script_hint)) {
    ref = default_ref.script_hint;
  }

  return get_zombie_hint(ref);
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
    assertmsg("<dev string:x23d>" + ref + "<dev string:x248>");
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
    assertmsg("<dev string:x23d>" + ref + "<dev string:x248>");
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
    assertmsg("<dev string:x23d>" + ref + "<dev string:x248>");
    return;
  }

  self playSound(level.zombie_sounds[ref]);
}

function draw_line_ent_to_ent(ent1, ent2) {
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

function draw_line_ent_to_pos(ent, pos, end_on) {
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

function debug_print(msg) {
  if(getdvarint(#"zombie_debug", 0) > 0) {
    println("<dev string:x2b3>" + msg);
  }
}

function debug_blocker(pos, rad, height) {
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

function drawcylinder(pos, rad, height) {
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

function debug_attack_spots_taken() {
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

    msg = "<dev string:xaa>" + count + "<dev string:x2c9>" + self.attack_spots_taken.size;
    print3d(self.origin, msg);
  }
}

function float_print3d(msg, time) {
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

function is_magic_bullet_shield_enabled(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  return !is_true(ent.allowdeath);
}

function play_sound_2d(sound) {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playsoundwithnotify(sound, sound + "wait");
  temp_ent waittill(sound + "wait");
  waitframe(1);
  temp_ent delete();
}

function include_weapon(weapon_name, in_box) {
  println("<dev string:x2d0>" + function_9e72a96(weapon_name));

  if(!isDefined(in_box)) {
    in_box = 1;
  }

  zm_weapons::include_zombie_weapon(weapon_name, in_box);
}

function print3d_ent(text, color, scale, offset, end_msg, overwrite) {
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

  while(!is_true(level.disable_print3d_ent)) {
    print3d(self.origin + offset, self._debug_print3d_msg, color, scale);
    waitframe(1);
  }
}

function function_21f4ac36() {
  return getdvarint(#"hash_42c75b39576494a5", 1) == 1;
}

function function_c85ebbbc() {
  return getdvarint(#"hash_6ec233a56690f409", 1) == 1;
}

function function_b0eeaada(location, max_drop_distance = 500) {
  return function_9cc082d2(location, max_drop_distance);
}

function function_a1055d95(location, node) {
  return isDefined(location) && location[#"region"] === getnoderegion(node);
}

function get_current_zone(return_zone = 0, immediate = 1) {
  if(!isDefined(self)) {
    return undefined;
  }

  self endon(#"death");
  level flag::wait_till("zones_initialized");

  if(function_c85ebbbc()) {
    volumes = function_72d3bca6(level.var_541a988b, self.origin, undefined, undefined, level.var_603981f1);

    for(i = 0; i < volumes.size; i++) {
      if(self istouching(volumes[i])) {
        zone = level.zones[volumes[i].targetname];

        if(zone !== self.cached_zone) {
          self.cached_zone = zone;
          self.cached_zone_name = zone.name;
          self.var_3b65cdd7 = undefined;
          self notify(#"zone_change", {
            #zone: zone, #zone_name: zone.name
          });
        }

        self.cached_zone_volume = volumes[i];

        if(is_true(return_zone)) {
          return zone;
        }

        return zone.name;
      }
    }
  }

  if(!immediate) {
    waitframe(1);
  }

  if(function_21f4ac36()) {
    node = self.var_3b65cdd7;
    var_3e5dca65 = self.origin;

    if(isPlayer(self)) {
      if(isDefined(self.last_valid_position) && distancesquared(self.origin, self.last_valid_position) < sqr(32)) {
        var_3e5dca65 = self.last_valid_position;
      }
    }

    if(isDefined(var_3e5dca65)) {
      self.var_3b65cdd7 = function_52c1730(var_3e5dca65, level.zone_nodes, 500);

      if(isDefined(self.var_3b65cdd7)) {
        if(node !== self.var_3b65cdd7 || isDefined(node) && node.targetname !== self.var_3b65cdd7.targetname) {
          self.cached_zone = level.zones[self.var_3b65cdd7.targetname];
          self.cached_zone_name = self.cached_zone.name;
          self notify(#"zone_change", {
            #zone: self.cached_zone, #zone_name: self.cached_zone_name
          });
        }

        self.cached_zone_volume = undefined;

        if(return_zone) {
          return level.zones[self.var_3b65cdd7.targetname];
        } else {
          return self.var_3b65cdd7.targetname;
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

function update_zone_name() {
  self notify("21933cba123d42a");
  self endon("21933cba123d42a");
  self endon(#"death");

  while(isDefined(self)) {
    self.zone_name = get_current_zone(0, 0);
    wait randomfloatrange(0.5, 1);
  }
}

function shock_onpain() {
  self notify(#"stop_shock_onpain");
  self endon(#"stop_shock_onpain", #"death");

  if(getdvarstring(#"blurpain") == "") {
    setDvar(#"blurpain", "on");
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

      if(is_true(self.is_burning)) {
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

function shock_onexplosion(damage, shocktype, shocklight) {
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

function increment_is_drinking(var_12d2689b = 0) {
  if(is_true(level.devgui_dpad_watch)) {
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

function is_drinking() {
  return isDefined(self.is_drinking) && self.is_drinking > 0 || isPlayer(self) && self function_55acff10();
}

function is_multiple_drinking() {
  return isDefined(self.is_drinking) && self.is_drinking > 1;
}

function decrement_is_drinking() {
  if(self.is_drinking > 0) {
    self.is_drinking--;
  } else {
    assertmsg("<dev string:x2eb>");
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

function function_91403f47() {
  if(!isDefined(level.var_1d72fbba)) {
    level.var_1d72fbba = 0;
  }

  return level.var_1d72fbba > 0;
}

function function_3e549e65() {
  if(!isDefined(level.var_1d72fbba)) {
    level.var_1d72fbba = 0;
  }

  level.var_1d72fbba++;
}

function function_b7e5029f() {
  if(!isDefined(level.var_1d72fbba)) {
    level.var_1d72fbba = 0;
  }

  if(level.var_1d72fbba > 0) {
    level.var_1d72fbba--;
  } else {
    assertmsg("<dev string:x30d>");
  }

  level zm_player::function_8ef51109();
}

function can_use(e_player, b_is_weapon = 0, var_67fee570 = 0) {
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

function spawn_weapon_model(weapon, model = weapon.worldmodel, origin, angles, renderoptionsweapon, var_fd90b0bb) {
  weapon_model = spawn("script_model", origin);

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  if(isDefined(renderoptionsweapon) || isDefined(var_fd90b0bb)) {
    weapon_model useweaponmodel(weapon, model, renderoptionsweapon, var_fd90b0bb);
  } else {
    weapon_model useweaponmodel(weapon, model);
  }

  return weapon_model;
}

function spawn_buildkit_weapon_model(player, weapon, var_3ded6a21, origin, angles) {
  weapon_model = util::spawn_model("tag_origin", origin, angles);

  if(!isDefined(weapon)) {
    return weapon_model;
  }

  upgraded = zm_weapons::is_weapon_upgraded(weapon);

  if(isPlayer(player)) {
    if(upgraded && (!isDefined(var_3ded6a21) || 0 > var_3ded6a21)) {
      var_3ded6a21 = player zm_camos::function_4f727cf5(weapon);
    }

    weapon_model usebuildkitweaponmodel(player, weapon, var_3ded6a21);
  } else if(isDefined(weapon.worldmodel)) {
    weapon_model setModel(weapon.worldmodel);
  }

  return weapon_model;
}

function is_limited_weapon(weapon) {
  if(isDefined(level.limited_weapons) && isDefined(level.limited_weapons[weapon])) {
    return true;
  }

  return false;
}

function should_watch_for_emp() {
  return is_true(level.should_watch_for_emp);
}

function groundpos(origin) {
  return bulletTrace(origin, origin + (0, 0, -100000), 0, self)[#"position"];
}

function groundpos_ignore_water(origin) {
  return bulletTrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

function groundpos_ignore_water_new(origin) {
  return groundtrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

function self_delete() {
  if(isDefined(self)) {
    self delete();
  }
}

function ignore_triggers(timer) {
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

function give_achievement(achievement, all_players = 0) {
  if(achievement == "") {
    return;
  }

  if(is_true(level.zm_disable_recording_stats)) {
    return;
  }

  assert(ishash(achievement), "<dev string:x33f>");

  if(all_players) {
    foreach(player in getplayers()) {
      player giveachievement(achievement);
    }

    return;
  }

  if(!isPlayer(self)) {
    assertmsg("<dev string:x361>");
    return;
  }

  self giveachievement(achievement);
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
  assert(isalive(self), "<dev string:x38e>");
  self.allowreact = 0;
}

function enable_react() {
  assert(isalive(self), "<dev string:x3b4>");
  self.allowreact = 1;
}

function is_ee_enabled() {
  if(is_true(level.var_73d1e054)) {
    return false;
  }

  if(!getdvarint(#"zm_ee_enabled", 0)) {
    return false;
  }

  if(!is_true(zm_custom::function_901b751c(#"hash_3c5363541b97ca3e"))) {
    return false;
  }

  if(level.gamedifficulty === 0) {
    return false;
  }

  return true;
}

function function_36e7b4a2() {
  if(is_true(getgametypesetting(#"hash_5d6471cd7038852e")) && !is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return true;
  }

  return false;
}

function bullet_attack(type) {
  if(type == "MOD_PISTOL_BULLET") {
    return true;
  }

  return type == "MOD_RIFLE_BULLET";
}

function pick_up() {
  player = self.owner;
  self delete();
  clip_ammo = player getweaponammoclip(self.weapon);
  clip_max_ammo = self.weapon.clipsize;

  if(clip_ammo < clip_max_ammo) {
    clip_ammo++;
  }

  player setweaponammoclip(self.weapon, clip_ammo);
}

function function_ab9a9770() {
  s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);

  if(isDefined(s_trace[#"entity"]) && s_trace[#"entity"] ismovingplatform()) {
    return true;
  }

  return false;
}

function function_52046128() {
  s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);

  if(isDefined(s_trace[#"entity"])) {
    return s_trace[#"entity"];
  }

  return undefined;
}

function waittill_not_moving() {
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

function get_closest_player(org) {
  players = [];
  players = getplayers();

  if(players.size) {
    if(players.size > 1 && isDefined(org)) {
      return arraygetclosest(org, players);
    }

    return players[0];
  }
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
  self endon(#"death");
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
      if(is_true(players[i].var_f4e33249) || players[i] isplayerswimming() || players[i] laststand::player_is_in_laststand() || "playing" != players[i].sessionstate) {
        continue;
      }

      if(isbot(players[i])) {
        continue;
      }

      if(players[i] isinvehicle()) {
        continue;
      }

      if(lengthsquared(players[i] getvelocity()) > 15625) {
        continue;
      }

      if(is_true(players[i].var_c5e36086)) {
        continue;
      }

      for(j = 0; j < players.size; j++) {
        if(i == j || is_true(players[j].var_f4e33249) || players[j] isplayerswimming() || players[j] laststand::player_is_in_laststand() || "playing" != players[j].sessionstate) {
          continue;
        }

        if(isbot(players[j])) {
          continue;
        }

        if(lengthsquared(players[j] getvelocity()) > 15625) {
          continue;
        }

        if(is_true(players[j].var_c5e36086)) {
          continue;
        }

        if(isDefined(level.player_intersection_tracker_override)) {
          if(players[i][[level.player_intersection_tracker_override]](players[j])) {
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
        iprintlnbold("<dev string:x3d9>" + var_e42ab7b4.var_d28c72e5);
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
        iprintlnbold("<dev string:x405>" + var_e42ab7b4.var_d28c72e5);

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

function is_player_looking_at(origin, dot, do_trace, ignore_ent) {
  assert(isPlayer(self), "<dev string:x426>");

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
    if(isDefined(extra_check) && ![[extra_check]](entity, array[i])) {
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
  if(!isDefined(game.gamemode_match)) {
    game.gamemode_match = [];
  }

  game.gamemode_match[gvar] = val;
}

function set_gamemode_var_once(gvar, val) {
  if(!isDefined(game.gamemode_match)) {
    game.gamemode_match = [];
  }

  if(!isDefined(game.gamemode_match[gvar])) {
    game.gamemode_match[gvar] = val;
  }
}

function get_gamemode_var(gvar) {
  if(isDefined(game.gamemode_match) && isDefined(game.gamemode_match[gvar])) {
    return game.gamemode_match[gvar];
  }

  return undefined;
}

function waittill_subset(min_num, string1, string2, string3, string4, string5) {
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

function is_headshot(weapon, shitloc, smeansofdeath, var_f8c15d58 = 1) {
  if(!isDefined(smeansofdeath)) {
    return false;
  }

  if(smeansofdeath === "MOD_MELEE" || smeansofdeath === "MOD_UNKNOWN" || smeansofdeath === "MOD_MELEE_WEAPON_BUTT") {
    return false;
  }

  if(!isDefined(shitloc) || shitloc == "none") {
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

    return false;
  }

  if(shitloc != "head" && shitloc != "helmet" && shitloc != "neck") {
    return false;
  }

  return true;
}

function function_4562a3ef(shitloc, vpoint) {
  var_dd54fdb1 = namespace_81245006::function_3131f5dd(self, shitloc, 1);

  if(isDefined(vpoint)) {
    if(!isDefined(var_dd54fdb1)) {
      var_dd54fdb1 = namespace_81245006::function_73ab4754(self, vpoint, 1);
    }
  }

  return is_true(var_dd54fdb1.var_3765e777);
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

function function_7a35b1d7(var_c857a96d) {
  if(isPlayer(self)) {
    self luinotifyevent(#"zombie_notification", 2, var_c857a96d, self getentitynumber());
    return;
  }

  luinotifyevent(#"zombie_notification", 1, var_c857a96d);
}

function function_846eb7dd(type_id, var_c857a96d) {
  if(isPlayer(self)) {
    self luinotifyevent(type_id, 2, var_c857a96d, self getentitynumber());
    return;
  }

  luinotifyevent(type_id, 1, var_c857a96d);
}

function function_e64ac3b6(type_id, var_c857a96d) {
  if(isPlayer(self)) {
    self luinotifyevent(#"zombie_special_notification", 3, type_id, var_c857a96d, self getentitynumber());
    return;
  }

  luinotifyevent(#"zombie_special_notification", 2, type_id, var_c857a96d);
}

function sndswitchannouncervox(who) {
  switch (who) {
    case # "sam":
      game.zmbdialog[#"prefix"] = "vox_zmba_sam";
      level.zmb_laugh_alias = "zmb_player_outofbounds";
      level.sndannouncerisrich = 0;
      break;
  }
}

function do_player_general_vox(category, type, timer, chance) {
  if(isDefined(chance) && isDefined(level.votimer[timer]) && level.votimer[timer] > 0) {
    return;
  }

  self thread zm_audio::create_and_play_dialog(type, timer);

  if(isDefined(chance)) {
    level.votimer[timer] = chance;
    level thread general_vox_timer(level.votimer[timer], timer);
  }
}

function general_vox_timer(timer, type) {
  level endon(#"end_game");
  println("<dev string:x457>" + type + "<dev string:x478>" + timer + "<dev string:x47f>");

  while(timer > 0) {
    wait 1;
    timer--;
  }

  level.votimer[type] = timer;
  println("<dev string:x484>" + type + "<dev string:x478>" + timer + "<dev string:x47f>");
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

function set_demo_intermission_point() {
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

function disable_player_move_states(forcestancechange) {
  self allowcrouch(1);
  self allowads(0);
  self allowsprint(0);
  self allowprone(0);
  self allowmelee(0);

  if(is_true(forcestancechange)) {
    if(self getstance() == "prone") {
      self setstance("crouch");
    }
  }
}

function enable_player_move_states() {
  if(!isDefined(self)) {
    return;
  }

  if(!isPlayer(self)) {
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
    return spawnpathnode("node_pathnode", origin, angles, undefined, k1, v1, k2, v2);
  } else if(isDefined(k1)) {
    return spawnpathnode("node_pathnode", origin, angles, undefined, k1, v1);
  } else {
    return spawnpathnode("node_pathnode", origin, angles);
  }

  return undefined;
}

function delete_spawned_path_nodes() {}

function respawn_path_nodes() {
  if(!isDefined(level._spawned_path_nodes)) {
    return;
  }

  for(i = 0; i < level._spawned_path_nodes.size; i++) {
    node_struct = level._spawned_path_nodes[i];
    println("<dev string:x4a3>" + node_struct.origin);
    node_struct.node = spawn_path_node_internal(node_struct.origin, node_struct.angles, node_struct.k1, node_struct.v1, node_struct.k2, node_struct.v2);
  }
}

function undo_link_changes() {
  println("<dev string:x4c7>");
  println("<dev string:x4c7>");
  println("<dev string:x4ce>");

  delete_spawned_path_nodes();
}

function redo_link_changes() {
  println("<dev string:x4c7>");
  println("<dev string:x4c7>");
  println("<dev string:x4ea>");

  respawn_path_nodes();
}

function is_gametype_active(a_gametypes) {
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

  if(player hasperk(#"specialty_additionalprimaryweapon")) {
    weapon_limit = level.additionalprimaryweapon_limit;
  }

  return weapon_limit;
}

function function_e05ac4ad(e_player, n_cost) {
  if(isDefined(level.var_236b9f7a) && [[level.var_236b9f7a]](e_player, self.clientfieldname)) {
    return false;
  }

  return e_player zm_score::can_player_purchase(n_cost);
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

  if(self bgb::is_enabled(#"zm_bgb_unquenchable") || self bgb::is_enabled(#"zm_bgb_soda_fountain")) {
    return true;
  }

  return false;
}

function wait_for_attractor_positions_complete() {
  self endon(#"death");
  self waittill(#"attractor_positions_generated");
  self.attract_to_origin = 0;
}

function get_player_index(player) {
  assert(isPlayer(player));
  assert(isDefined(player.characterindex));

  if(player.entity_num == 0 && getdvarstring(#"zombie_player_vo_overwrite") != "<dev string:xaa>") {
    new_vo_index = getdvarint(#"zombie_player_vo_overwrite", 0);
    return new_vo_index;
  }

  return player.characterindex;
}

function function_828bac1(n_character_index) {
  foreach(character in level.players) {
    if(character zm_characters::function_dc232a80() === n_character_index) {
      return character;
    }
  }

  return undefined;
}

function zombie_goto_round(n_target_round) {
  level notify(#"restart_round");

  if(n_target_round < 1) {
    n_target_round = 1;
  }

  level.zombie_total = 0;
  zm_round_logic::set_round_number(n_target_round);
  zombies = zombie_utility::get_round_enemy_array();

  if(isDefined(zombies)) {
    array::run_all(zombies, &kill);
  }

  level.sndgotoroundoccurred = 1;
  level waittill(#"between_round_over");
}

function is_point_inside_enabled_zone(v_origin, ignore_zone) {
  if(function_c200446c() || is_survival()) {
    return true;
  }

  if(!isDefined(level.playable_area)) {
    level.playable_area = getEntArray("player_volume", "script_noteworthy");
  }

  if(function_c85ebbbc()) {
    var_12ed21a1 = function_72d3bca6(level.playable_area, v_origin, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      zone = level.zones[area.targetname];

      if(!zone.is_enabled) {
        continue;
      }

      if(isDefined(ignore_zone) && zone == ignore_zone) {
        continue;
      }

      if(istouching(v_origin, area)) {
        return true;
      }
    }
  }

  if(function_21f4ac36()) {
    node = function_52c1730(v_origin, level.zone_nodes, 500);

    if(isDefined(node)) {
      zone = level.zones[node.targetname];

      if(isDefined(zone) && zone.is_enabled && zone !== ignore_zone) {
        return true;
      }
    }
  }

  return false;
}

function clear_streamer_hint(var_49d474b2) {
  if(isarray(self.var_4a501715)) {
    if(isDefined(var_49d474b2)) {
      foreach(n_index, var_b0b08518 in self.var_4a501715) {
        if(n_index === var_49d474b2) {
          if(isDefined(var_b0b08518)) {
            var_b0b08518 delete();
          }
        }
      }
    } else {
      foreach(var_b0b08518 in self.var_4a501715) {
        if(isDefined(var_b0b08518)) {
          var_b0b08518 delete();
        }
      }
    }

    arrayremovevalue(self.var_4a501715, undefined, 1);
  }

  self notify(#"wait_clear_streamer_hint");
}

function wait_clear_streamer_hint(lifetime, str_id) {
  self endon(#"wait_clear_streamer_hint");
  wait lifetime;

  if(isDefined(self)) {
    self clear_streamer_hint(str_id);
  }
}

function create_streamer_hint(origin, angles, value, lifetime, var_49d474b2) {
  if(self == level) {
    foreach(player in getplayers()) {
      player clear_streamer_hint(var_49d474b2);
    }
  }

  self clear_streamer_hint(var_49d474b2);

  if(!isDefined(self.var_4a501715)) {
    self.var_4a501715 = [];
  }

  var_b0b08518 = createstreamerhint(origin, value);

  if(isDefined(angles)) {
    var_b0b08518.angles = angles;
  }

  if(isPlayer(self)) {
    var_b0b08518 setinvisibletoall();
    var_b0b08518 setvisibletoplayer(self);
  }

  var_b0b08518 setincludemeshes(1);

  if(isDefined(var_49d474b2)) {
    self.var_4a501715[var_49d474b2] = var_b0b08518;
  } else {
    if(!isDefined(self.var_4a501715)) {
      self.var_4a501715 = [];
    } else if(!isarray(self.var_4a501715)) {
      self.var_4a501715 = array(self.var_4a501715);
    }

    if(!isinarray(self.var_4a501715, var_b0b08518)) {
      self.var_4a501715[self.var_4a501715.size] = var_b0b08518;
    }
  }

  self notify(#"wait_clear_streamer_hint");

  if(isDefined(lifetime) && lifetime > 0) {
    self thread wait_clear_streamer_hint(lifetime, var_49d474b2);
  }

  return var_b0b08518;
}

function approximate_path_dist(player) {
  aiprofile_beginentry("approximate_path_dist");
  goal_pos = player.origin;

  if(isDefined(player.last_valid_position)) {
    goal_pos = player.last_valid_position;
  }

  if(is_true(player.b_teleporting)) {
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

function get_player_closest_to(e_target) {
  a_players = function_a1ef346b();
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
  return level.players.size == 1 && getdvarint(#"zm_private_rankedmatch", 0);
}

function function_e63cdbef() {
  return level.rankedmatch || getdvarint(#"zm_private_rankedmatch", 0);
}

function function_a3648315() {
  if(!isDefined(level.var_b03a2fc8)) {
    level.var_b03a2fc8 = new throttle();
    [[level.var_b03a2fc8]] - > initialize(1, 0.1);
  }
}

function function_ffc279(v_magnitude, e_attacker, n_damage, weapon) {
  self thread launch_ragdoll(v_magnitude, e_attacker, n_damage, weapon);
}

function private launch_ragdoll(v_magnitude, e_attacker, n_damage = self.health, weapon) {
  self endon(#"death");

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  self.var_bfffc79e = 1;
  [[level.var_b03a2fc8]] - > waitinqueue(self);
  self start_ragdoll();
  self launchragdoll(v_magnitude);
  util::wait_network_frame();

  if(isDefined(self)) {
    self.var_bfffc79e = undefined;
    self dodamage(n_damage, self.origin, e_attacker, undefined, "none", "MOD_UNKNOWN", 0, weapon);
  }
}

function set_max_health(var_54cb21f6 = 0) {
  if(self.health < self.var_66cb03ad) {
    self.health = self.var_66cb03ad;
  }

  if(var_54cb21f6) {
    if(self.health > self.var_66cb03ad) {
      self.health = self.var_66cb03ad;
    }
  }
}

function function_13cc9756() {
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

function function_45492cc4(var_cf5e7324 = 1) {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(self.owner)) {
    return false;
  }

  if(!(self.classname === "script_vehicle")) {
    return false;
  }

  if(var_cf5e7324 && isPlayer(self.owner)) {
    return true;
  }

  return isDefined(self.owner);
}

function function_1a4d2910() {
  if(isDefined(level.var_2456c78a)) {
    foreach(var_92254a2f in level.var_2456c78a) {
      if(distancesquared(self.origin, var_92254a2f) < 10000) {
        return true;
      }
    }
  }

  return false;
}

function function_64259898(position, search_radius = 128) {
  goal_pos = getclosestpointonnavmesh(position, search_radius, self getpathfindingradius());

  if(isDefined(goal_pos)) {
    self setgoal(goal_pos);
    return true;
  }

  self setgoal(self.origin);
  return false;
}

function function_372a1e12() {
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

function function_d7db256e(var_eaf129a0, var_6cc77d4e, var_888cf948 = 1, var_b96be97f = undefined) {
  if(isDefined(var_6cc77d4e)) {
    s_objective_loc = struct::get(var_eaf129a0);
    n_obj_id = function_f5a222a8(var_6cc77d4e, s_objective_loc.origin, var_b96be97f);
  }

  if(var_888cf948) {
    level thread function_75fd65f9(var_eaf129a0, 1);
  }

  return n_obj_id;
}

function function_b1f3be5c(n_obj_id, var_eaf129a0) {
  if(isDefined(n_obj_id)) {
    function_bc5a54a8(n_obj_id);
  }

  level thread function_75fd65f9(var_eaf129a0, 0);
}

function function_ba39d198(n_obj_id, b_show = 1) {
  if(isDefined(n_obj_id)) {
    if(b_show) {
      objective_setvisibletoplayer(n_obj_id, self);
      return;
    }

    objective_setinvisibletoplayer(n_obj_id, self);
  }
}

function function_f5a222a8(var_6cc77d4e, v_origin_or_ent, var_c87f9ad7, params) {
  n_obj_id = gameobjects::get_next_obj_id();
  function_ff902863(var_6cc77d4e, n_obj_id, 1);

  if(isentity(v_origin_or_ent) || isvec(v_origin_or_ent)) {
    objective_add(n_obj_id, "active", v_origin_or_ent, var_6cc77d4e);
  } else if(isstruct(v_origin_or_ent)) {
    objective_add(n_obj_id, "active", v_origin_or_ent.origin, var_6cc77d4e);
  }

  function_6da98133(n_obj_id);

  if(isDefined(var_c87f9ad7)) {
    level thread function_f23721f4(n_obj_id, v_origin_or_ent, var_c87f9ad7, params);
  }

  if(!isDefined(level.var_e63703cd[n_obj_id])) {
    level.var_e63703cd[n_obj_id] = {
      #var_6cc77d4e: var_6cc77d4e, #v_origin_or_ent: v_origin_or_ent, #var_c87f9ad7: var_c87f9ad7, #params: params
    };
  }

  return n_obj_id;
}

function private function_f23721f4(n_obj_id, v_origin_or_ent, var_c87f9ad7, params) {
  level flag::wait_till("start_zombie_round_logic");

  foreach(player in getplayers()) {
    player thread function_71071944(n_obj_id, v_origin_or_ent, var_c87f9ad7, params);
  }
}

function function_4a4cf79a(var_6cc77d4e, v_origin_or_ent, params) {
  n_obj_id = function_f5a222a8(var_6cc77d4e, v_origin_or_ent, &function_15f72a68, params);
  return n_obj_id;
}

function private function_71071944(n_obj_id, v_origin_or_ent, var_c87f9ad7, params) {
  self notify("cleanup_zm_objective_id_" + n_obj_id);
  level endon(#"end_game", "cleanup_zm_objective_id_" + n_obj_id);
  self endon(#"disconnect", "cleanup_zm_objective_id_" + n_obj_id);
  n_ent_num = self getentitynumber();

  if(!isDefined(level.var_cef2e607[#"hash_6aca065fb0d8bfbf"])) {
    level.var_cef2e607[#"hash_6aca065fb0d8bfbf"] = -1;
  }

  level.var_cef2e607[#"hash_6aca065fb0d8bfbf"]++;
  wait float(function_60d95f53()) / 1000 * (level.var_cef2e607[#"hash_6aca065fb0d8bfbf"] % int(0.5 / float(function_60d95f53()) / 1000) + 1);
  var_cb46b9ea = {};

  while(true) {
    [[level.var_75b29eed]] - > waitinqueue(var_cb46b9ea);

    if(is_true(level.var_e63703cd[n_obj_id].var_d0d552ea[n_ent_num])) {
      wait 0.5;
      continue;
    }

    if(self[[var_c87f9ad7]](v_origin_or_ent, params)) {
      objective_setvisibletoplayer(n_obj_id, self);
    } else {
      objective_setinvisibletoplayer(n_obj_id, self);
    }

    wait 0.5;
  }
}

function function_e8f4d47b(a_players, n_obj_id, b_disable = 1) {
  if(!isDefined(a_players)) {
    a_players = [];
  } else if(!isarray(a_players)) {
    a_players = array(a_players);
  }

  if(isDefined(level.var_e63703cd[n_obj_id])) {
    if(!isDefined(level.var_e63703cd[n_obj_id].var_d0d552ea)) {
      level.var_e63703cd[n_obj_id].var_d0d552ea = [];
    }

    foreach(player in a_players) {
      n_ent_num = player getentitynumber();

      if(b_disable) {
        level.var_e63703cd[n_obj_id].var_d0d552ea[n_ent_num] = 1;
        continue;
      }

      level.var_e63703cd[n_obj_id].var_d0d552ea[n_ent_num] = undefined;
    }
  }
}

function private function_15f72a68(v_origin_or_ent, params) {
  if(isentity(v_origin_or_ent) || isstruct(v_origin_or_ent)) {
    v_pos = v_origin_or_ent.origin;

    if(isDefined(v_origin_or_ent.var_8d3fc50c) && v_origin_or_ent.var_8d3fc50c > 0) {
      var_8d3fc50c = v_origin_or_ent.var_8d3fc50c;
    }
  } else {
    v_pos = v_origin_or_ent;
  }

  if(!isDefined(var_8d3fc50c)) {
    var_8d3fc50c = isDefined(params.var_5068abe1) ? params.var_5068abe1 : 160;
  }

  if(is_survival()) {
    return true;
  }

  if(abs(self.origin[2] - v_pos[2]) <= var_8d3fc50c) {
    return true;
  }

  return false;
}

function function_bc5a54a8(n_obj_id) {
  level notify("cleanup_zm_objective_id_" + n_obj_id);
  function_ff902863(undefined, n_obj_id, 0);
  gameobjects::release_obj_id(n_obj_id);
  objective_delete(n_obj_id);

  if(isDefined(level.var_e63703cd[n_obj_id])) {
    arrayremoveindex(level.var_e63703cd, n_obj_id, 1);
  }
}

function function_ff902863(var_6cc77d4e = level.var_e63703cd[n_obj_id].var_6cc77d4e, n_obj_id, var_3a9f00e9 = 1) {
  if(var_3a9f00e9) {
    s_objective = {
      #var_f23c87bd: var_6cc77d4e, #var_f81e2f33: n_obj_id, #var_3dce3470: function_f8d53445()
    };
  } else {
    s_objective = {
      #var_81d2684e: var_6cc77d4e, #var_9a059624: n_obj_id, #var_84820801: function_f8d53445()
    };
  }

  function_92d1707f(#"hash_57cacfb95186806d", s_objective);
}

function function_452938ed(params) {
  if(int(params.value)) {
    if(isarray(level.var_e63703cd)) {
      println("<dev string:x506>" + level.var_e63703cd.size + "<dev string:x522>");

      foreach(n_obj_id, s_objective in level.var_e63703cd) {
        println("<dev string:x533>" + n_obj_id + "<dev string:x545>" + function_9e72a96(s_objective.var_6cc77d4e));
      }
    }

    setDvar(params.name, 0);
  }
}

function function_3ba26955() {
  foreach(n_obj_id, var_1b589e4c in level.var_e63703cd) {
    if(isDefined(var_1b589e4c.var_c87f9ad7)) {
      self thread function_71071944(n_obj_id, var_1b589e4c.v_origin_or_ent, var_1b589e4c.var_c87f9ad7, var_1b589e4c.params);
    }
  }
}

function function_75fd65f9(str_targetname, b_enable = 1) {
  if(!isDefined(str_targetname)) {
    return;
  }

  var_f8f0b389 = struct::get(str_targetname);
  var_2a7c782 = [];
  var_77cd2496 = [];

  if(isDefined(var_f8f0b389.target)) {
    var_2a7c782 = struct::get_array(var_f8f0b389.target);
    var_77cd2496 = getEntArray(var_f8f0b389.target, "targetname");

    if(b_enable) {
      showmiscmodels(var_f8f0b389.target);
    } else {
      hidemiscmodels(var_f8f0b389.target);
    }
  }

  foreach(var_86802380 in var_77cd2496) {
    if(b_enable) {
      var_86802380 show();
      var_86802380 notsolid();
      continue;
    }

    var_86802380 hide();
    var_86802380 notsolid();
  }
}

function function_ebb2f490() {
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

function function_aa45670f(weapon, var_3a36e0dc) {
  root_weapon = zm_weapons::function_93cd8e76(weapon);

  if(isDefined(self.var_f6d3c3[var_3a36e0dc]) && isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
    var_dc69b88b = function_ebb2f490();

    if(isinarray(var_dc69b88b, root_weapon) || zm_weapons::function_93cd8e76(self.currentweapon) === root_weapon) {
      return true;
    }
  }

  return false;
}

function function_28ee38f4(weapon, var_3a36e0dc, var_87f6ae5) {
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

function function_18ce0c8(weapon, var_3a36e0dc) {
  root_weapon = zm_weapons::function_93cd8e76(weapon);

  if(!isDefined(self.var_f6d3c3[var_3a36e0dc]) || !isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
    return;
  }

  self.var_f6d3c3[var_3a36e0dc] = array::exclude(self.var_f6d3c3[var_3a36e0dc], root_weapon);

  if(root_weapon.splitweapon != level.weaponnone) {
    self.var_f6d3c3[var_3a36e0dc] = array::exclude(self.var_f6d3c3[var_3a36e0dc], root_weapon.splitweapon);
  }
}

function function_13f40482() {
  self notify("568d695ce7232fcf");
  self endon("568d695ce7232fcf");
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

function function_fdb0368(n_round_number, str_endon) {
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

function function_9ad5aeb1(var_a8d0b313 = 1, var_82ea43f2 = 1, b_hide_body = 0, var_b0e62e21 = 1, var_814b69d3 = 1, var_87c98387 = "white") {
  var_4b9821e4 = 0;
  a_players = function_a1ef346b();

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
    if(isalive(ai) && !is_true(ai.var_d45ca662) && !is_true(ai.marked_for_death)) {
      if(var_a8d0b313) {
        ai zm_cleanup::function_23621259(0);
      }

      if(var_82ea43f2 || ai.zm_ai_category !== # "normal") {
        if(is_magic_bullet_shield_enabled(ai)) {
          ai util::stop_magic_bullet_shield();
        }

        ai.allowdeath = 1;
        ai.no_powerups = 1;
        ai.deathpoints_already_given = 1;
        ai.marked_for_death = 1;

        if(!b_hide_body && ai.zm_ai_category === # "normal" && var_4b9821e4 < 6) {
          var_4b9821e4++;
          ai thread zombie_death::flame_death_fx();

          if(!is_true(ai.no_gib)) {
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

function function_508f636d() {
  level function_9ad5aeb1(0, 1, 0, 1, "black");
}

function function_850e7499(weapon, var_20c27a34 = 0) {
  if(weapon === level.weaponnone) {
    return false;
  }

  if(weapon === getweapon(#"eq_wraith_fire")) {
    return true;
  }

  if(var_20c27a34 && weapon === getweapon(#"wraith_fire_fire")) {
    return true;
  }

  return false;
}

function is_claymore(weapon) {
  if(weapon === level.weaponnone) {
    return false;
  }

  if(weapon === getweapon(#"claymore")) {
    return true;
  }

  return false;
}

function function_b797694c(weapon) {
  if(weapon === level.weaponnone) {
    return false;
  }

  if(weapon === getweapon(#"eq_acid_bomb")) {
    return true;
  }

  return false;
}

function is_frag_grenade(weapon) {
  if(weapon === level.weaponnone) {
    return false;
  }

  if(weapon === getweapon(#"eq_frag_grenade")) {
    return true;
  }

  return false;
}

function is_mini_turret(weapon, var_b69165c7 = 0) {
  if(weapon === level.weaponnone) {
    return false;
  }

  if(weapon === getweapon(#"mini_turret")) {
    return true;
  }

  if(var_b69165c7 && weapon === getweapon(#"gun_mini_turret")) {
    return true;
  }

  return false;
}

function function_a2541519(var_da4af4df) {
  if(is_standard()) {
    var_da4af4df = level.var_aaf21bbb;
  }

  return var_da4af4df;
}

function function_4a25b584(v_start_pos, var_487ba56d, n_radius = 512, b_randomize = 1, var_79ced64 = 0.2, n_half_height = 4, var_21aae2c6 = undefined, var_a5b5d950) {
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

    if(isDefined(var_a5b5d950)) {
      e_powerup setModel(var_a5b5d950);
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

function function_25e3484e(v_pos, n_spacing = 400, var_3e807a14) {
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
    if(![[level.var_3e96c707]](v_pos)) {
      return false;
    }
  }

  if(check_point_in_playable_area(v_pos) && check_point_in_enabled_zone(v_pos)) {
    return true;
  }

  return false;
}

function function_ce46d95e(v_origin, b_permanent = 1, var_4ecce348 = 1, var_9a5654a5) {
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

function is_jumping() {
  ground_ent = self getgroundent();
  return !isDefined(ground_ent);
}

function function_9f7fd525(var_c61df77f = "zombie_location", a_str_zones, var_a6f0ec9f = 1) {
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

function function_7618c8ef(var_6e4c63cc = 0.0667) {
  n_damage_multiplier = 1;

  if(is_true(self.ignore_health_regen_delay)) {
    n_damage_multiplier += 1.25;

    if(self hasperk(#"talent_quickrevive")) {
      n_damage_multiplier += 0.75;
    }
  }

  var_16e6b8ea = int(self.maxhealth * var_6e4c63cc * n_damage_multiplier);
  return var_16e6b8ea;
}

function function_10e38d86() {
  if(function_c200446c()) {
    return getscriptbundle("zombie_onslaught_vars_settings");
  }

  return getscriptbundle("zombie_vars_settings");
}

function function_36eb0acc(str_rarity = # "none") {
  switch (str_rarity) {
    case # "none":
      self clientfield::set("model_rarity_rob", 1);
      break;
    case # "resource":
    case # "white":
      self clientfield::set("model_rarity_rob", 2);
      break;
    case # "green":
    case # "uncommon":
      self clientfield::set("model_rarity_rob", 3);
      break;
    case # "blue":
    case # "rare":
      self clientfield::set("model_rarity_rob", 4);
      break;
    case # "purple":
    case # "epic":
      self clientfield::set("model_rarity_rob", 5);
      break;
    case # "orange":
    case # "legendary":
      self clientfield::set("model_rarity_rob", 6);
      break;
    case # "yellow":
    case # "ultra":
    case # "gold":
      self clientfield::set("model_rarity_rob", 7);
      break;
    default:
      self clientfield::set("model_rarity_rob", 0);
      break;
  }
}

function function_e3025ca5() {
  if(is_survival()) {
    var_3afe334f = level.var_b48509f9;
  } else if(function_c200446c()) {
    var_3afe334f = 1;
    var_cf03ccb6 = level.var_9b7bd0e8;

    if(isDefined(level.var_693d250e) && level.var_693d250e >= 1) {
      var_cf03ccb6 = level.var_9b7bd0e8 + 1;
    }

    if(util::get_game_type() === # "hash_125fc0c0065c7dea") {
      var_cf03ccb6 = floor(var_cf03ccb6 / 3);

      if(var_cf03ccb6 < 1) {
        var_cf03ccb6 = 1;
      }
    }

    if(var_cf03ccb6 < 8) {
      var_3afe334f = var_cf03ccb6;
    } else {
      var_3afe334f = 8;
    }
  } else {
    var_3afe334f = ceil(level.round_number / 5);
  }

  return int(var_3afe334f);
}

function get_round_number(var_ec585b8 = 0) {
  if(is_survival()) {
    var_88710b09 = zombie_utility::get_zombie_var(#"hash_6ba259e60f87bb15");

    if(var_ec585b8 > 0) {
      n_round_number = isDefined(var_88710b09[var_ec585b8 - 1].round) ? var_88710b09[var_ec585b8 - 1].round : 0;
    } else if(level.var_b48509f9 - 1 >= var_88710b09.size) {
      n_round_number = isDefined(var_88710b09[var_88710b09.size - 1].round) ? var_88710b09[var_88710b09.size - 1].round : 100;
    } else {
      n_round_number = isDefined(var_88710b09[level.var_b48509f9 - 1].round) ? var_88710b09[level.var_b48509f9 - 1].round : 0;
    }
  } else if(function_c200446c()) {
    return level.wave_number;
  } else {
    n_round_number = isDefined(self._starting_round_number) ? self._starting_round_number : level.round_number;
  }

  return int(n_round_number);
}

function function_747180ea(var_8861fa85, n_radius = 64, trigger, var_ab426dbb = 0) {
  if(!isDefined(var_8861fa85)) {
    var_8861fa85 = [];
  } else if(!isarray(var_8861fa85)) {
    var_8861fa85 = array(var_8861fa85);
  }

  self thread function_e1a11b1(var_8861fa85, n_radius, trigger, var_ab426dbb);
}

function private function_e1a11b1(var_8861fa85, n_radius, trigger, var_ab426dbb = 0) {
  self notify("7ca7585758ee8d2e");
  self endon("7ca7585758ee8d2e");

  foreach(n_obj_id in var_8861fa85) {
    level endon("cleanup_zm_objective_id_" + n_obj_id);
  }

  self endoncallback(&function_e5dcd07a, #"death", #"hash_261161e11cf95f9f");
  n_radius_sq = sqr(n_radius);
  self.var_45f78aa4 = arraycopy(var_8861fa85);

  while(true) {
    foreach(n_obj_id in self.var_45f78aa4) {
      if(isarray(level.releasedobjectives) && isinarray(level.releasedobjectives, n_obj_id)) {
        break;
      }

      foreach(player in getplayers()) {
        var_13dc7b2a = 1;
        n_ent_num = player getentitynumber();

        if(is_true(level.var_e63703cd[n_obj_id].var_d0d552ea[n_ent_num])) {
          var_13dc7b2a = 0;
        }

        if(isDefined(trigger)) {
          if(trigger function_4f593819(player, self)) {
            objective_setplayerusing(n_obj_id, player);

            if(var_ab426dbb && var_13dc7b2a) {
              objective_setinvisibletoplayer(n_obj_id, player);
            }
          } else {
            objective_clearplayerusing(n_obj_id, player);

            if(var_ab426dbb && var_13dc7b2a) {
              objective_setvisibletoplayer(n_obj_id, player);
            }
          }

          continue;
        }

        if(distancesquared(player.origin, self.origin) < n_radius_sq) {
          objective_setplayerusing(n_obj_id, player);

          if(var_ab426dbb && var_13dc7b2a) {
            objective_setinvisibletoplayer(n_obj_id, player);
          }

          continue;
        }

        objective_clearplayerusing(n_obj_id, player);

        if(var_ab426dbb && var_13dc7b2a) {
          objective_setvisibletoplayer(n_obj_id, player);
        }
      }
    }

    waitframe(1);
  }

  self function_48d9a9c9();
}

function function_48d9a9c9() {
  self notify(#"hash_261161e11cf95f9f");
}

function function_4f593819(player, ignore_ent) {
  if(isstruct(self) && isDefined(self.script_unitrigger_type)) {
    if(isDefined(self.playertrigger[player getentitynumber()])) {
      trigger = self.playertrigger[player getentitynumber()];
    } else if(isDefined(self.trigger)) {
      trigger = self.trigger;
    } else {
      return 0;
    }
  } else {
    trigger = self;
  }

  if(!trigger istouching(player)) {
    return 0;
  }

  if(!trigger triggerrequireslookat()) {
    return 1;
  }

  return player util::is_player_looking_at(trigger.origin, 0.76, 1, ignore_ent);
}

function private function_e5dcd07a(str_notify) {
  if(isarray(self.var_45f78aa4)) {
    foreach(n_obj_id in self.var_45f78aa4) {
      foreach(player in getplayers()) {
        objective_clearplayerusing(n_obj_id, player);
      }
    }

    self.var_45f78aa4 = undefined;
  }
}

function function_ee6da6f6(n_delay = 15, str_waittill = "player_intermission_spawned") {
  self endon(#"disconnect");
  self thread lui::screen_fade_out(0, (0, 0, 0), "end_game_blackscreen");
  self waittilltimeout(n_delay, str_waittill);
  self thread lui::screen_fade_in(0, (0, 0, 0), "end_game_blackscreen");
}

function function_5d356609(aat_name, n_tier) {
  if(isPlayer(self) && isDefined(aat_name)) {
    var_f35f3f4b = {
      #var_27ad1f0f: hash(aat_name), #var_93230b5d: n_tier, #var_9f39dfd4: function_f8d53445(), #var_c075f57d: get_round_number(), #var_dacb4b0b: function_e3025ca5()
    };
    self function_678f57c8(#"hash_69732e83f28ba309", var_f35f3f4b);
  }
}

function function_60daf5f7(str_name, str_key = "targetname", b_hide = 1) {
  e_machine = getent(str_name, str_key);

  if(isDefined(e_machine)) {
    if(b_hide) {
      if(isDefined(e_machine.objectiveid)) {
        function_e8f4d47b(getplayers(), e_machine.objectiveid, 1);
        objective_setinvisibletoall(e_machine.objectiveid);
      }

      e_machine.trigger hide();
      e_machine hide();
      e_machine notsolid();
      return;
    }

    e_machine.trigger show();
    e_machine show();
    e_machine solid();

    if(isDefined(e_machine.objectiveid)) {
      objective_setvisibletoall(e_machine.objectiveid);
      function_e8f4d47b(getplayers(), e_machine.objectiveid, 0);
    }
  }
}

function function_ca960904(e_machine, var_cc253f86, var_6f0e765d) {
  if(!isDefined(level.var_c427e93b)) {
    level.var_c427e93b = [];
  } else if(!isarray(level.var_c427e93b)) {
    level.var_c427e93b = array(level.var_c427e93b);
  }

  if(!isinarray(level.var_c427e93b, e_machine)) {
    level.var_c427e93b[level.var_c427e93b.size] = e_machine;
  }

  e_machine clientfield::set("force_stream", 1);
  e_machine.var_cc253f86 = var_cc253f86;
  e_machine.var_6f0e765d = var_6f0e765d;
}

function function_725e99fb() {
  level endon(#"end_game");

  if(!isDefined(level.var_c427e93b)) {
    level.var_c427e93b = [];
  }

  while(true) {
    arrayremovevalue(level.var_c427e93b, undefined);

    if(!getdvarint(#"hash_2769a6109d9d7b4d", 1)) {
      foreach(machine in level.var_c427e93b) {
        if(is_true(machine.var_c02c4d66)) {
          machine sethighdetail(0);
          machine.var_c02c4d66 = undefined;
        }
      }

      wait 1;
      continue;
    }

    foreach(machine in level.var_c427e93b) {
      if(!is_true(machine.var_cc253f86) && !is_true(machine.var_6f0e765d)) {
        continue;
      }

      foreach(player in getplayers()) {
        var_30300360 = 0;

        if(is_player_valid(player, undefined, 1) && isDefined(machine) && function_7757350c(player, machine)) {
          var_30300360 = 1;
        }

        if(isDefined(machine)) {
          var_4e157e21 = machine getentitynumber();

          if(var_30300360 && !is_true(machine.var_c02c4d66)) {
            if(!isDefined(player.var_4a501715[var_4e157e21])) {
              var_b0b08518 = player create_streamer_hint(machine.origin, machine.angles, 1, 10, var_4e157e21);
              var_b0b08518.var_86e2d95e = machine.model;
            }

            if(is_true(machine.var_6f0e765d)) {
              machine sethighdetail(1);
            }

            machine.var_c02c4d66 = 1;
          } else if(!var_30300360 && is_true(machine.var_c02c4d66)) {
            if(isDefined(player.var_4a501715[var_4e157e21])) {
              player clear_streamer_hint(var_4e157e21);
            }

            if(is_true(machine.var_6f0e765d)) {
              machine sethighdetail(0);
            }

            machine.var_c02c4d66 = undefined;
          }
        }

        waitframe(1);
      }
    }

    waitframe(10);
  }
}

function private function_7757350c(player, machine) {
  var_2cdb84bb = machine.origin + machine getboundsmidpoint();
  n_height_diff = abs(player.origin[2] - machine.origin[2]);

  if(n_height_diff < 140 && distance2dsquared(player.origin, var_2cdb84bb) < 360000) {
    return true;
  }

  if(player util::is_player_looking_at(var_2cdb84bb, 0.75, 1, machine, player)) {
    return true;
  }

  return false;
}

function on_disconnect() {
  self clear_streamer_hint();
}

function function_e77fca72() {
  self endoncallback(&function_6a447863, #"death", #"hash_7fb506f40bcf5962");
  self.var_624e969b = 1;
  self.original_angles = self.angles;

  while(true) {
    function_14bad487(self, 0.75, 0.05, 3);

    if(true) {
      wait 2;
    }
  }
}

function function_14bad487(trap_prop, total_time, iteration_time, angle) {
  original_angles = trap_prop.angles;
  iterations = total_time / iteration_time;
  start_roll = trap_prop.angles[2];
  current_delta = angle;

  if(isDefined(self.rattle_sound)) {
    playsoundatposition(self.rattle_sound, self.origin);
  }

  for(i = 0; i < iterations; i++) {
    trap_prop rotateroll(start_roll + current_delta, iteration_time);
    current_delta *= -1;
    wait iteration_time;
  }

  trap_prop.angles = original_angles;
}

function function_6a447863(notifyhash) {
  if(isDefined(self)) {
    self.angles = self.original_angles;
    self.var_624e969b = undefined;
  }
}

function function_ebd87099(player) {
  if(isDefined(level.var_23fc2144) && isDefined(level.var_f7794bb5)) {
    var_2a4e3502 = arraysortclosest(level.var_23fc2144, player.origin, undefined, undefined, level.var_f7794bb5 + 15);

    foreach(param in var_2a4e3502) {
      if(player.origin[2] >= param.origin[2] && player.origin[2] <= param.origin[2] + param.height && distance2dsquared(player.origin, param.origin) < sqr(param.radius)) {
        return param;
      }
    }
  }
}

function function_89dbd679(origin, radius, height, goal_origin, var_b9e9cdf3) {
  if(!isDefined(level.var_23fc2144)) {
    level.var_23fc2144 = [];
  }

  level.var_23fc2144[level.var_23fc2144.size] = {
    #origin: origin, #radius: radius, #height: height, #goal_origin: goal_origin, #var_b9e9cdf3: var_b9e9cdf3
  };
  max_radius = 0;

  foreach(override in level.var_23fc2144) {
    max_radius = max(max(max_radius, override.radius), override.height);
  }

  level.var_f7794bb5 = max_radius;
}

function function_cce73165(var_947b45e7, var_82706add, str_zone_name) {
  var_a96b643a = [];
  var_dbc18a74 = struct::get_array(var_947b45e7, "script_noteworthy");

  foreach(spawner in var_dbc18a74) {
    if(str_zone_name === spawner.zone_name) {
      if(!isDefined(var_a96b643a)) {
        var_a96b643a = [];
      } else if(!isarray(var_a96b643a)) {
        var_a96b643a = array(var_a96b643a);
      }

      var_a96b643a[var_a96b643a.size] = spawner;
    }
  }

  if(var_a96b643a.size > 0) {
    var_958f8634 = var_a96b643a[randomint(var_a96b643a.size)];
  } else {
    return;
  }

  if(getfreeactorcount() < 1) {
    a_zombie = getaiarchetypearray(#"zombie");

    if(isDefined(a_zombie)) {
      a_zombie[0].allowdeath = 1;
      a_zombie[0] kill();
    }
  }

  if(isDefined(var_958f8634)) {
    ai = spawnactor(var_82706add, var_958f8634.origin, var_958f8634.angles);
  } else {
    iprintlnbold("<dev string:x54a>" + str_zone_name + "<dev string:x562>");

    ai = spawnactor(var_82706add, var_dbc18a74[0].origin, var_dbc18a74[0].angles);
  }

  return ai;
}

function function_d729de6a(b_enable = 1, a_str_zones) {
  if(!is_classic()) {
    return;
  }

  if(!isDefined(a_str_zones)) {
    a_str_zones = [];
  } else if(!isarray(a_str_zones)) {
    a_str_zones = array(a_str_zones);
  }

  if(b_enable) {
    array::thread_all(getplayers(), &function_42ff30dc, a_str_zones);
    callback::on_ai_damage(&function_9452d2ee);
    function_cf7a0b3d(0, a_str_zones);
    function_c2da57a7(0, a_str_zones);
    return;
  }

  callback::remove_on_ai_damage(&function_9452d2ee);
  function_cf7a0b3d(1, a_str_zones);
  function_c2da57a7(1, a_str_zones);

  foreach(player in getplayers()) {
    player flag::clear(#"hash_35db0208f90f5145");
    player val::reset(#"hash_31f206367fcff836", "ignoreme");
    player.var_8dbfa2f5 = undefined;
  }

  level notify(#"hash_674491fa3bd36b34");
}

function function_42ff30dc(a_str_zones) {
  self notify("6d99fc4675da1628");
  self endon("6d99fc4675da1628");
  level endon(#"hash_674491fa3bd36b34");
  self endon(#"disconnect");
  var_b7153b99 = 0;
  self.var_8dbfa2f5 = a_str_zones;
  self flag::set(#"hash_35db0208f90f5145");

  while(true) {
    var_6494601f = 0;

    foreach(str_zone in a_str_zones) {
      if(self.cached_zone_name === str_zone) {
        var_6494601f = 1;
        break;
      }
    }

    if(!self flag::get(#"hash_35db0208f90f5145")) {
      break;
    }

    if(var_6494601f && !var_b7153b99) {
      self val::set(#"hash_31f206367fcff836", "ignoreme", 1);
      var_b7153b99 = 1;
    } else if(!var_6494601f && var_b7153b99) {
      self val::reset(#"hash_31f206367fcff836", "ignoreme");
      var_b7153b99 = 0;
    }

    s_waitresult = self waittill(#"zone_change", #"hash_35db0208f90f5145");
  }

  self flag::clear(#"hash_35db0208f90f5145");
  self val::reset(#"hash_31f206367fcff836", "ignoreme");

  foreach(player in getplayers()) {
    if(player flag::get(#"hash_35db0208f90f5145")) {
      return;
    }
  }

  level thread function_d729de6a(0, a_str_zones);
}

function function_9452d2ee(params) {
  if(self.team === level.zombie_team && isPlayer(params.eattacker) && params.eattacker flag::get(#"hash_35db0208f90f5145") && params.smeansofdeath !== "MOD_GRENADE_SPLASH" && params.smeansofdeath !== "MOD_GAS") {
    params.eattacker flag::clear(#"hash_35db0208f90f5145");
    params.eattacker val::reset(#"hash_31f206367fcff836", "ignoreme");
  }
}

function function_cf7a0b3d(var_81aa5a36 = 1, a_str_zones) {
  foreach(str_zone in a_str_zones) {
    if(zm_zonemgr::zone_is_enabled(str_zone)) {
      level.zones[str_zone].is_spawning_allowed = var_81aa5a36;
    }
  }
}

function function_c2da57a7(var_ac0be832 = 1, a_str_zones) {
  foreach(str_zone in a_str_zones) {
    if(zm_zonemgr::zone_is_enabled(str_zone)) {
      if(var_ac0be832) {
        if(isDefined(level.zones[str_zone].var_d4940e8c[#"wait_location"])) {
          level.zones[str_zone].a_loc_types[#"wait_location"] = arraycopy(level.zones[str_zone].var_d4940e8c[#"wait_location"]);
          level.zones[str_zone].var_d4940e8c[#"wait_location"] = undefined;
          level.zones[str_zone].var_d4940e8c = undefined;
        }

        continue;
      }

      level.zones[str_zone].var_d4940e8c[#"wait_location"] = arraycopy(level.zones[str_zone].a_loc_types[#"wait_location"]);
      level.zones[str_zone].a_loc_types[#"wait_location"] = [];
    }
  }
}

function function_2256923f(n_cost) {
  level endon(#"game_ended");
  self endon(#"death");

  while(true) {
    foreach(player in function_a1ef346b()) {
      var_99442276 = player zm_score::can_player_purchase(n_cost);

      if(!var_99442276 && player istouching(self)) {
        if(self function_4f593819(player)) {
          player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
          player.var_e62ad24a = self;
        } else {
          player globallogic::function_d96c031e();

          if(player.var_e62ad24a === self) {
            player.var_e62ad24a = undefined;
          }
        }

        continue;
      }

      if(player.var_e62ad24a === self) {
        player globallogic::function_d96c031e();
        player.var_e62ad24a = undefined;
      }
    }

    wait 0.5;
  }
}

function clear_vehicles(mdl_machine) {
  mdl_machine playrumbleonentity(#"sr_transmitter_clear");
  a_vehicles = [];
  var_a8b5d9cc = arraycombine(getentitiesinradius(mdl_machine.origin, 300, 12), getentitiesinradius(mdl_machine.origin, 300, 14));

  foreach(vehicle in var_a8b5d9cc) {
    if(vehicle istouching(mdl_machine)) {
      if(!isDefined(a_vehicles)) {
        a_vehicles = [];
      } else if(!isarray(a_vehicles)) {
        a_vehicles = array(a_vehicles);
      }

      a_vehicles[a_vehicles.size] = vehicle;
      continue;
    }

    if(isDefined(mdl_machine.trigger) && vehicle istouching(mdl_machine.trigger)) {
      if(!isDefined(a_vehicles)) {
        a_vehicles = [];
      } else if(!isarray(a_vehicles)) {
        a_vehicles = array(a_vehicles);
      }

      a_vehicles[a_vehicles.size] = vehicle;
    }
  }

  foreach(vehicle in a_vehicles) {
    if(!is_true(vehicle.var_2e436083)) {
      vehicle.var_2e436083 = 1;
      vehicle thread function_78e620d();
    }
  }
}

function function_78e620d() {
  if(isvehicle(self)) {
    var_9cfd0ea9 = self getvehoccupants();

    foreach(player in var_9cfd0ea9) {
      player unlink();
    }

    self makevehicleunusable();
    self battletracks::function_fe45d0ae();
    wait 0.2;
  }

  if(isDefined(self)) {
    self clientfield::increment("" + # "vehicle_teleport");
    wait 1.5;

    if(isDefined(self.var_e6604bb)) {
      foreach(ent in self.var_e6604bb) {
        if(isDefined(ent)) {
          ent delete();
        }
      }
    }

    if(isDefined(self)) {
      self delete();
    }
  }
}

function function_b42da08a(dynent) {
  if(!isDefined(dynent)) {
    return undefined;
  }

  if(!isDefined(level.var_4b8c034d)) {
    level.var_4b8c034d = [];
  }

  if(isDefined(level.var_4b8c034d[dynent.var_15d44120])) {
    dynent.bundle = level.var_4b8c034d[dynent.var_15d44120];
  } else {
    bundle = function_489009c1(dynent);
    level.var_4b8c034d[dynent.var_15d44120] = bundle;
    dynent.bundle = level.var_4b8c034d[dynent.var_15d44120];
  }

  return dynent.bundle;
}

function start_ragdoll(immediate) {
  if(is_true(self.var_873d65bd)) {
    return;
  }

  self startragdoll(immediate);
}

function function_d7fedde2(entity) {
  players = array::get_all_closest(entity.origin, function_a1ef346b());

  foreach(player in players) {
    if(!is_true(player.ignoreme) && !player isnotarget() && !player util::is_spectating()) {
      return player;
    }
  }

  return undefined;
}

function function_d34f6296(v_origin, n_radius) {
  if(!is_survival()) {
    return [];
  }

  var_1046ec68 = getEntArray("sr_aether_orb", "targetname");
  var_6bca202c = getEntArray("sr_demented_echo", "targetname");
  var_aa419446 = getEntArray("world_event_black_chest_swarm", "targetname");
  var_9e2c450b = getEntArray("sr_swarm_hulking_summoner", "targetname");
  var_e7464eb0 = arraycombine(var_aa419446, var_9e2c450b, 0, 0);
  a_ents = arraycombine(var_e7464eb0, var_1046ec68, 0, 0);
  a_ents = arraycombine(a_ents, var_6bca202c, 0, 0);

  if(isDefined(v_origin) && isDefined(n_radius)) {
    a_ents = arraysortclosest(a_ents, v_origin, undefined, undefined, n_radius);
  }

  foreach(ent in a_ents) {
    if(is_false(ent.takedamage)) {
      arrayremovevalue(a_ents, ent, 1);
    }
  }

  arrayremovevalue(a_ents, undefined, 0);
  return a_ents;
}

function function_da0eb3e4(itemname, func) {
  if(!isDefined(level.var_217d3a3b)) {
    level.var_217d3a3b = [];
  }

  level.var_217d3a3b[itemname] = func;
}