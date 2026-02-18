/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_soa.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using script_744259b349d834c7;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_destination_manager;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_ai_soa;

function private autoexec __init__system__() {
  system::register(#"zm_ai_soa", &preinit, undefined, undefined, "zm_destination_manager");
}

function preinit() {
  spawner::add_archetype_spawn_function(#"soa", &function_49bf8a32);
  spawner::function_89a2cd87(#"soa", &function_751146f8);
  zm_round_spawning::register_archetype(#"soa", &function_76a7a9ef, &function_ecce5272, &function_e803632f, 80);
  zm_cleanup::function_cdf5a512(#"soa", &function_9310b9ca);
  callback::add_callback(#"hash_72fd23232c4c7ab1", &function_53bc3572);
  callback::add_callback(#"hash_2a040f8b8142266d", &function_3138c2d5);
}

function function_49bf8a32() {
  self.b_ignore_cleanup = 0;
  self.closest_player_override = &zm_utility::function_3d70ba7a;
  self.var_64c67df3 = &function_7a71cf9f;
  self.var_b0709fcc = &function_6c3b6e9d;
  self.var_6fd4da3a = &function_bd4dbc6d;
  self.var_9d431816 = &function_9d431816;
  self.var_917994fb = &function_917994fb;
  level thread zm_spawner::zombie_death_event(self);
}

function function_751146f8() {
  self.completed_emerging_into_playable_area = 1;
  self.canbetargetedbyturnedzombies = 1;
  self.should_zigzag = 0;
  self.var_72411ccf = &function_dda06e36;
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  namespace_81245006::initweakpoints(self);
  self thread zm_audio::zmbaivox_notifyconvert();
  self thread zm_audio::play_ambient_zombie_vocals();
}

function function_9310b9ca() {
  self endon(#"death");

  if(level.zm_loc_types[# "zombie_location"].size <= 0) {
    return false;
  }

  closest_player = zm_utility::function_d7fedde2(self);

  if(isDefined(closest_player)) {
    var_debfdbf5 = 10;

    while(var_debfdbf5 > 0 && isalive(closest_player)) {
      point = getrandomnavpoint(closest_player.origin, 350);

      if(isDefined(point) && zm_utility::check_point_in_playable_area(point)) {
        angles = (0, vectortoyaw(closest_player.origin - point), 0);
        self forceteleport(self.origin, angles);
        self thread namespace_19c99142::function_940cd1d8();
        waitframe(1);
        zm_ai_utility::function_a8dc3363({
          #origin: point
        });
        self.completed_emerging_into_playable_area = 1;
        self.var_9817f19a = 0;
        break;
      }

      var_debfdbf5--;
      waitframe(1);
    }
  }

  return true;
}

function function_53bc3572(soa) {
  self.var_72411ccf = &function_7d1d7f3f;
  self.var_60d1126a = &function_e772df94;
}

function function_3138c2d5() {
  self.var_72411ccf = undefined;
  self.var_60d1126a = undefined;
}

function private function_dda06e36(entity) {
  if(getdvarint(#"hash_4ac64c7f46b01880", 0) > 0) {
    players = getplayers();
    entity.var_93a62fe = isDefined(players[1]) ? players[1] : players[0];
  }

  if(!isDefined(entity.var_93a62fe)) {
    entity.favoriteenemy = undefined;
  }

  var_cc7597dc = namespace_19c99142::function_3d972f3(entity);
  var_6d4f3481 = entity.team !== level.zombie_team;
  var_4d21f369 = namespace_19c99142::function_da71e09a(entity);

  switch (var_4d21f369) {
    case # "chase":
      if(namespace_19c99142::function_264f914c(entity) && !var_6d4f3481) {
        if(isDefined(var_cc7597dc) && namespace_19c99142::function_85d7a413(entity, var_cc7597dc)) {
          namespace_19c99142::function_708afe1d(entity, #"hash_6192d8af630c6c07");
        } else if(namespace_19c99142::function_47f3f527(entity)) {
          namespace_19c99142::function_708afe1d(entity, #"hash_685254f9ed0ce346");
        } else if(namespace_19c99142::function_d1293a5a(entity)) {
          namespace_19c99142::function_708afe1d(entity, #"circle");
        }
      }

      break;
    case # "hash_6192d8af630c6c07":
      if(!isDefined(var_cc7597dc) || !namespace_19c99142::function_85d7a413(entity, var_cc7597dc) || var_6d4f3481) {
        namespace_19c99142::function_708afe1d(entity, #"chase");
      }

      break;
    case # "hash_685254f9ed0ce346":
      if(namespace_19c99142::function_ee1f25af(entity)) {
        namespace_19c99142::function_708afe1d(entity, #"command_spot");
      }

      break;
    case # "command_spot":
      if(namespace_19c99142::function_89dbf30f(entity) || var_6d4f3481) {
        if(namespace_19c99142::function_47f3f527(entity)) {
          namespace_19c99142::function_708afe1d(entity, #"hash_685254f9ed0ce346");
        } else {
          namespace_19c99142::function_708afe1d(entity, #"chase");
        }
      }

      break;
    case # "procedural_traversal":
      break;
    case # "circle":
      if(isDefined(var_cc7597dc) && namespace_19c99142::function_85d7a413(entity, var_cc7597dc)) {
        namespace_19c99142::function_708afe1d(entity, #"hash_6192d8af630c6c07");
      } else if(namespace_19c99142::function_25517868(entity)) {
        namespace_19c99142::function_708afe1d(entity, #"chase");
      }

      break;
  }

  var_4d21f369 = namespace_19c99142::function_da71e09a(entity);

  switch (var_4d21f369) {
    case # "chase":
      if(namespace_19c99142::function_3c14ef44(entity)) {
        if(entity.var_7418f498 !== entity.favoriteenemy) {
          if(namespace_19c99142::function_264f914c(entity)) {
            namespace_19c99142::function_1b2f34c9(entity);
          } else if(!isPlayer(entity.var_7418f498) || zm_utility::is_player_valid(entity.var_7418f498, 1)) {
            entity.var_93a62fe = entity.var_7418f498;
          }
        }
      } else {
        namespace_19c99142::function_ff6a04bc(entity);
      }

      function_b7b2c72c(entity);
      zm_behavior::zombiefindflesh(entity);
      break;
    case # "hash_6192d8af630c6c07":
      assert(isDefined(var_cc7597dc), "<dev string:x38>");
      namespace_19c99142::function_ff6a04bc(entity);
      entity.favoriteenemy = var_cc7597dc;
      entity.goalradius = entity getpathfindingradius();
      entity zm_behavior::zombieupdategoal();
      break;
    case # "hash_685254f9ed0ce346":
      entity.favoriteenemy = entity.var_93a62fe;
      break;
    case # "command_spot":
      entity.favoriteenemy = entity.var_93a62fe;
      break;
    case # "procedural_traversal":
      entity.favoriteenemy = entity.var_93a62fe;
      break;
    case # "circle":
      namespace_19c99142::function_b046be53(entity);
      break;
  }

  if(getdvarint(#"hash_13f115c784a1f77b", 0) > 0) {
    if(!isDefined(level.var_48137965)) {
      level.var_48137965 = entity.origin;
    }

    goal_info = entity function_4794d6a3();
    entity setgoal(level.var_48137965);
  }
}

function private function_7d1d7f3f(entity) {
  if(!namespace_19c99142::function_9d13a2e7(entity)) {
    return;
  }

  soa = namespace_19c99142::function_9dd68a24(entity);
  namespace_19c99142::function_d9fe2b0(entity);
  var_4d21f369 = namespace_19c99142::function_2905c7db(entity);

  if(var_4d21f369 === # "attacking") {
    if(!isDefined(soa.favoriteenemy) || entity.favoriteenemy !== soa.favoriteenemy) {
      if(!isDefined(soa.favoriteenemy) || distance2dsquared(soa.origin, entity.origin) > sqr(1000)) {
        namespace_19c99142::function_c33fb385(entity, #"following");
      }
    }
  }

  if(var_4d21f369 === # "following") {
    if(isDefined(soa.favoriteenemy) && entity cansee(soa.favoriteenemy)) {
      namespace_19c99142::function_c33fb385(entity, #"attacking");
    }
  }

  var_4d21f369 = namespace_19c99142::function_2905c7db(entity);

  if(var_4d21f369 === # "following") {
    goal = namespace_19c99142::function_dd116fa9(entity);
    entity setgoal(goal);
    return;
  }

  if(var_4d21f369 === # "attacking") {
    if(isPlayer(soa.favoriteenemy) && is_true(entity.var_ff3cbd9e) && !getdvarint(#"hash_6f7afa24d5871b86", 0) > 0) {
      var_ce42b625 = zm_utility::function_d89330e6(soa.favoriteenemy);

      if(var_ce42b625 >= 0) {
        entity.var_93a62fe = soa.favoriteenemy;
      }
    }

    zm_behavior::zombiefindflesh(entity);
  }
}

function function_e772df94(entity, target_pos) {
  soa = namespace_19c99142::function_9dd68a24(entity);

  if(!(isDefined(entity.favoriteenemy) && isDefined(soa)) || soa.favoriteenemy !== entity.favoriteenemy) {
    return;
  }

  if(!entity cansee(entity.favoriteenemy)) {
    return;
  }

  if(entity flag::get(#"leading_pack")) {
    return {
      #angle: 0, #dist: 0
    };
  }

  if(isDefined(soa.var_6017b1f7) && distancesquared(soa.var_6017b1f7.origin, entity.origin) > sqr(400)) {
    return;
  }

  var_647ddc9d = isDefined(entity.var_bf2dba23) && (entity.var_bf2dba23 & 1) === 0;
  min_angle = -90 + (var_647ddc9d ? 135 : 0);
  max_angle = -45 + (var_647ddc9d ? 135 : 0);
  angle = vectortoyaw(target_pos - self.origin) + randomfloatrange(min_angle, max_angle);
  distance = randomfloatrange(128, 196);

  if(getdvarint(#"hash_20ead0e6e8e713d8", 0) > 0) {
    goalpos = checknavmeshdirection(target_pos, function_ba142845(angle), distance, self getpathfindingradius() * 1.1);
    recordline(goalpos, goalpos + (0, 0, 80 + (self getentitynumber() - 137) * 20), (1, 0, 0));
    record3dtext(self getentitynumber(), goalpos + (0, 0, 80 + (self getentitynumber() - 137) * 20), (1, 0, 0));
  }

  return {
    #angle: angle, #dist: distance
  };
}

function private function_b7b2c72c(entity) {
  if(!entity flag::get(#"hash_6142b8eaf31a60c6")) {
    if(isDefined(self.favoriteenemy) && self cansee(self.favoriteenemy)) {
      entity flag::set(#"hash_6142b8eaf31a60c6");
    }
  }
}

function function_7a71cf9f(zone_path, player) {
  self.var_ea989fd2 = undefined;

  if(isDefined(zone_path)) {
    return undefined;
  }

  zipline = function_4a3e695a(self, player);

  if(isDefined(zipline)) {
    zipline.var_ec8356c8 = 1;
    return zipline;
  }

  return player;
}

function function_4a3e695a(entity, player) {
  if(isDefined(level.var_f9bb6f24)) {
    return [[level.var_f9bb6f24]]();
  }

  if(!isDefined(entity) || !isPlayer(player)) {
    return undefined;
  }

  if(isDefined(entity.var_ea989fd2)) {
    return entity.var_ea989fd2;
  }

  var_26352dd8 = entity.cached_zone;

  if(!isDefined(var_26352dd8)) {
    return undefined;
  }

  var_bac59fe3 = struct::get_array("zipline_start_zm", "script_noteworthy");
  var_bac59fe3 = function_72d3bca6(var_bac59fe3, entity.origin, undefined, 0, 1500);
  var_79796f1c = [var_26352dd8.name];

  if(isDefined(var_26352dd8.adjacent_zones)) {
    var_79796f1c = arraycombine(var_79796f1c, getarraykeys(var_26352dd8.adjacent_zones));
  }

  foreach(current_zone in var_79796f1c) {
    foreach(zipline in var_bac59fe3) {
      var_2f9aedc0 = isDefined(zipline.zone_struct) ? zipline.zone_struct : zm_zonemgr::get_zone_from_position(zipline.origin);

      if(!isDefined(zipline.zone_struct)) {
        zipline.zone_struct = var_2f9aedc0;
      }

      if(isDefined(var_2f9aedc0) && isDefined(zipline.target) && current_zone === var_2f9aedc0) {
        var_b4a3c7c5 = struct::get(zipline.target, "targetname");

        if(player.var_5da09c55 === zipline) {
          entity.var_ea989fd2 = {
            #var_827228db: zipline, #var_b4a3c7c5: var_b4a3c7c5
          };
          return zipline;
        }

        var_fd1e4845 = isDefined(var_b4a3c7c5.zone_struct) ? var_b4a3c7c5.zone_struct : zm_zonemgr::get_zone_from_position(var_b4a3c7c5.origin);

        if(!isDefined(var_b4a3c7c5.zone_struct)) {
          var_b4a3c7c5.zone_struct = var_fd1e4845;
        }

        var_c6bd50df = player.cached_zone;

        if(isDefined(var_fd1e4845) && isDefined(var_c6bd50df) && var_c6bd50df === var_fd1e4845) {
          target_zone = level.zones[var_fd1e4845];

          if(isDefined(target_zone.a_loc_types[# "zombie_location"]) && isDefined(target_zone.a_loc_types[# "zombie_location"].size <= 0)) {
            return undefined;
          }

          entity.var_ea989fd2 = {
            #var_827228db: zipline, #var_b4a3c7c5: var_b4a3c7c5
          };
          return zipline;
        }
      }
    }
  }

  return undefined;
}

function function_6c3b6e9d() {
  closest_player = arraygetclosest(self.origin, getplayers());
  function_4a3e695a(self, closest_player);

  if(isDefined(self.var_ea989fd2) || isDefined(self.var_1389a0b3)) {
    return true;
  }

  var_4d21f369 = namespace_19c99142::function_da71e09a(self);

  if(var_4d21f369 === # "procedural_traversal") {
    return true;
  }

  return false;
}

function function_bd4dbc6d() {
  closest_player = arraygetclosest(self.origin, getplayers());
  zipline = function_4a3e695a(self, closest_player);

  if(isDefined(zipline)) {
    return zipline;
  }
}

function function_917994fb(entity, n_to_spawn) {
  assert(isDefined(n_to_spawn), "<dev string:x6b>");

  if(isDefined(level.zombie_total) && level.zombie_total < n_to_spawn) {
    return false;
  }

  return true;
}

function function_9d431816(entity, ai_spawned) {
  if(isDefined(level.zombie_total) && isDefined(level.zombie_respawns)) {
    level.zombie_total--;

    if(level.zombie_respawns > 0) {
      level.zombie_respawns--;
    }
  }
}

function function_76a7a9ef(var_dbce0c44) {
  if(isDefined(level.var_a1c6ba48) && level.round_number < level.var_a1c6ba48) {
    return 0;
  }

  var_8cf00d40 = int(floor(var_dbce0c44 / 80));

  if(level.round_number < 20) {
    var_e5d49e0f = 0.02;
  } else if(level.round_number < 30) {
    var_e5d49e0f = 0.03;
  } else {
    var_e5d49e0f = 0.04;
  }

  n_max = min(var_8cf00d40, int(ceil(level.zombie_total * var_e5d49e0f)));
  return n_max;
}

function function_ecce5272() {
  ai = function_e803632f();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function function_e803632f(b_force_spawn, var_eb3a8721 = 0, var_bc66d64b) {
  if(!var_eb3a8721 && !function_f761f651()) {
    return undefined;
  }

  if(isDefined(var_bc66d64b)) {
    s_spawn_loc = var_bc66d64b;
  } else if(isDefined(level.var_194823e7)) {
    s_spawn_loc = [[level.var_194823e7]]();
  } else {
    s_spawn_loc = function_41a4961d();
  }

  if(!isDefined(s_spawn_loc)) {
    if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
      iprintlnbold("<dev string:x8e>");
    }

    return undefined;
  }

  ai = spawnactor(#"spawner_bo5_soa", s_spawn_loc.origin, s_spawn_loc.angles);

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai.ignore_enemy_count = 0;
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
  }

  return ai;
}

function function_41a4961d(get_all = 0) {
  if(isDefined(level.zm_loc_types[# "hash_160b6f445abd3a60"]) && level.zm_loc_types[# "hash_160b6f445abd3a60"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[# "hash_160b6f445abd3a60"];
    } else {
      locs = level.zm_loc_types[# "hash_160b6f445abd3a60"];

      if(getplayers().size > 1) {
        var_a6c95035 = [];
        var_b0becd1e = namespace_19c99142::function_a64f7068();

        if(!isDefined(var_b0becd1e)) {
          return undefined;
        }

        str_target_zone = var_b0becd1e zm_zonemgr::get_player_zone();

        if(!isDefined(str_target_zone)) {
          return undefined;
        }

        target_zone = level.zones[str_target_zone];
        var_24f5d9f8 = array(target_zone.name);
        a_str_adj_zones = getarraykeys(target_zone.adjacent_zones);

        foreach(str_zone in a_str_adj_zones) {
          if(target_zone.adjacent_zones[str_zone].is_connected) {
            if(!isDefined(var_24f5d9f8)) {
              var_24f5d9f8 = [];
            } else if(!isarray(var_24f5d9f8)) {
              var_24f5d9f8 = array(var_24f5d9f8);
            }

            var_24f5d9f8[var_24f5d9f8.size] = str_zone;
          }
        }

        foreach(loc in locs) {
          if(array::contains(var_24f5d9f8, loc.zone_name)) {
            if(!isDefined(var_a6c95035)) {
              var_a6c95035 = [];
            } else if(!isarray(var_a6c95035)) {
              var_a6c95035 = array(var_a6c95035);
            }

            var_a6c95035[var_a6c95035.size] = loc;
          }
        }

        if(var_a6c95035.size === 0) {
          var_a6c95035 = locs;
        }

        s_spawn_loc = array::random(var_a6c95035);
      } else {
        s_spawn_loc = array::random(locs);
      }
    }
  }

  return s_spawn_loc;
}

function private function_f761f651() {
  var_268fb71d = function_ff7527d6();
  var_df9af27e = function_d7a21807();

  if(var_268fb71d >= var_df9af27e || !level flag::get("spawn_zombies")) {
    return false;
  }

  return true;
}

function function_ff7527d6() {
  var_805eef4e = getaiarchetypearray(#"soa");
  var_268fb71d = var_805eef4e.size;

  foreach(disciple in var_805eef4e) {
    if(!isalive(disciple)) {
      var_268fb71d--;
    }
  }

  return var_268fb71d;
}

function function_d7a21807() {
  switch (getplayers().size) {
    case 1:
      return 2;
    case 2:
      return 3;
    case 3:
      return 4;
    case 4:
      return 5;
  }
}