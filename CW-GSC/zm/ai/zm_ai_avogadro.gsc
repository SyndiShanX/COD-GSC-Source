/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_avogadro.gsc
***********************************************/

#using scripts\core_common\ai\archetype_avogadro;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#namespace zm_ai_avogadro;

function private autoexec __init__system__() {
  system::register(#"zm_ai_avogadro", &preinit, &postinit, undefined, #"archetype_avogadro");
}

function private preinit() {
  spawner::add_archetype_spawn_function(#"avogadro", &function_8e4a7133);
  spawner::function_89a2cd87(#"avogadro", &function_c41e67c);
  level.var_c8827250 = &function_dc04aa1a;
  zm_cleanup::function_cdf5a512(#"avogadro", &function_c9791011);
  assert(isscriptfunctionptr(&function_f498585b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_76e19aed5b42448f", &function_f498585b);
  assert(isscriptfunctionptr(&function_5871bcf8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_408e0b3d57595bf7", &function_5871bcf8, 1);
  assert(isscriptfunctionptr(&function_14b5c940));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21f9e6b4d52f79cb", &function_14b5c940);
  zm_round_spawning::register_archetype(#"avogadro", &function_68ae7023, &round_spawn, undefined, 50);
  zm_round_spawning::function_306ce518(#"avogadro", &function_f53b79b4);
}

function private postinit() {}

function function_dc04aa1a(v_end_pos) {
  return zm_utility::check_point_in_playable_area(v_end_pos);
}

function function_f498585b(entity) {
  return false;
}

function function_5871bcf8(entity) {}

function function_14b5c940(entity) {
  return false;
}

function private function_8e4a7133() {
  self.closest_player_override = &zm_utility::function_3d70ba7a;
  self.completed_emerging_into_playable_area = 1;
  self.canbetargetedbyturnedzombies = 1;
  self callback::function_d8abfc3d(#"on_ai_damage", &function_ce2bd83c);
  self callback::function_d8abfc3d(#"hash_c1d64b00f1dc607", &function_f59c1777);
  self clientfield::set("sndAwarenessChange", 3);
  level thread zm_spawner::zombie_death_event(self);
}

function private function_c41e67c() {
  self.var_72411ccf = &function_7cabed4c;
  self.var_64099fad = 300;
  self.var_42a18a37 = 300;
  self.var_5f134efa = 1;
  self.phase_time = 0;
  self.var_533dbb42 = 20;
  self.var_7654fbc7 = 60;
  self.var_168f9987 = 200;
  self.var_946951ef = 100;
  self.var_36221cb6 = 1000;
  self.var_724ec089 = 1000;
}

function function_ce2bd83c(params) {
  if(is_true(self.is_phasing)) {
    return;
  }

  if(isDefined(params.einflictor) && isDefined(params.weapon) && params.smeansofdeath !== "MOD_DOT") {
    dot_params = function_f74d2943(params.weapon, 7);

    if(isDefined(dot_params)) {
      status_effect::status_effect_apply(dot_params, params.weapon, params.einflictor);
    }
  }

  if(params.smeansofdeath == "MOD_CRUSH") {
    self function_f59c1777({
      #origin: self.origin, #radius: 250, #jammer: self
    });

    if(isDefined(params.einflictor)) {
      params.einflictor dodamage(500, self.origin, self, self, "none", "MOD_UNKNOWN");
    }

    if(isalive(self)) {
      self.allowdeath = 1;
      level thread hud::function_c9800094(params.eattacker, self.origin, self.maxhealth, 1);
      self kill(self.origin, params.eattacker, params.einflictor, undefined, 0, 1);
    }
  }

  if(params.smeansofdeath === "MOD_MELEE") {
    if(isPlayer(params.einflictor)) {
      if(self.shield) {
        params.einflictor status_effect::status_effect_apply(level.var_2ea60515, undefined, self, 0);
      }
    }

    if(!self.shield) {
      self.shield = 1;
      self.hit_by_melee++;
    }
  } else if(self.hit_by_melee > 0) {
    self.hit_by_melee--;
  }

  self archetype_avogadro::function_ec39f01c(params.idamage, params.eattacker, params.vdir, params.vpoint, params.smeansofdeath, undefined, undefined, undefined, params.weapon);
}

function private function_b16c8865(entity, owner) {
  if(self == entity) {
    return false;
  }

  if(!isPlayer(entity) && (!isDefined(entity.model) || entity.model == # "")) {
    return false;
  }

  if(isactor(entity) && !is_true(entity.var_8f61d7f4)) {
    return false;
  }

  if(isDefined(entity.team) && !util::function_fbce7263(entity.team, owner.team)) {
    return false;
  }

  if(isDefined(entity.ignoreemp) ? entity.ignoreemp : 0) {
    return false;
  }

  return true;
}

function function_f59c1777(params) {
  entities = getentitiesinradius(params.origin, params.radius);

  foreach(entity in entities) {
    if(!function_b16c8865(entity, self)) {
      continue;
    }

    if(isPlayer(entity)) {
      entity status_effect::status_effect_apply(level.var_2ea60515, undefined, self, 0);
      continue;
    }

    if(isalive(entity) && isactor(entity)) {
      entity.isjammed = 1;
      entity.emped = 1;
    }
  }
}

function function_c9791011() {
  self endon(#"death");

  while(true) {
    var_31f7011a = arraysortclosest(getplayers(), self.origin);

    foreach(player in var_31f7011a) {
      if(zm_utility::is_player_valid(player)) {
        closest_player = player;
        break;
      }
    }

    if(isDefined(closest_player)) {
      break;
    }

    util::wait_network_frame();
  }

  s_spawn_locs = [];

  if(isDefined(level.var_4e1942d2)) {
    spawn_locs = [[level.var_4e1942d2]](1);

    if(isarray(spawn_locs)) {
      s_spawn_locs = spawn_locs;
    } else {
      array::add(s_spawn_locs, spawn_locs);
    }
  } else {
    spawn_locs = function_d9f5ec34(1);

    if(isarray(spawn_locs)) {
      s_spawn_locs = spawn_locs;
    }
  }

  var_69681a59 = [];

  if(isDefined(level.active_zone_names) && isarray(s_spawn_locs) && s_spawn_locs.size > 0) {
    foreach(spawn_loc in s_spawn_locs) {
      if(isDefined(spawn_loc.zone_name) && array::contains(level.active_zone_names, spawn_loc.zone_name)) {
        if(!isDefined(var_69681a59)) {
          var_69681a59 = [];
        } else if(!isarray(var_69681a59)) {
          var_69681a59 = array(var_69681a59);
        }

        var_69681a59[var_69681a59.size] = spawn_loc;
      }
    }
  }

  if(var_69681a59.size < 1) {
    return true;
  }

  spawn_points = arraysortclosest(var_69681a59, closest_player.origin, undefined, 500);

  if(spawn_points.size > 0) {
    var_b2aa54a9 = spawn_points[0];
  } else {
    var_b2aa54a9 = arraygetfarthest(closest_player.origin, var_69681a59);
  }

  if(!isDefined(var_b2aa54a9)) {
    return true;
  }

  iprintln("<dev string:x38>" + self.origin + "<dev string:x5a>" + var_b2aa54a9.origin);

  self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
  return true;
}

function function_d9f5ec34(get_all = 0) {
  if(isDefined(level.zm_loc_types[# "avogadro_location"]) && level.zm_loc_types[# "avogadro_location"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[# "avogadro_location"];
    } else {
      s_spawn_loc = array::random(level.zm_loc_types[# "avogadro_location"]);
    }
  }

  return s_spawn_loc;
}

function round_spawn() {
  ai = spawn_single();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function function_fa2289d5() {
  var_44a83920 = function_b7b928a7();
  var_894a9781 = function_a8880196();

  if(var_44a83920 >= var_894a9781 || !level flag::get("spawn_zombies")) {
    return false;
  }

  return true;
}

function function_b7b928a7() {
  var_bcd37ed4 = getaiarchetypearray(#"avogadro");
  var_44a83920 = var_bcd37ed4.size;

  foreach(avogadro in var_bcd37ed4) {
    if(!isalive(avogadro)) {
      var_44a83920--;
    }
  }

  return var_44a83920;
}

function function_a8880196() {
  n_player_count = zm_utility::function_a2541519(getplayers().size);

  switch (n_player_count) {
    case 1:
      return 1;
    case 2:
      return 2;
    case 3:
      return 3;
    case 4:
      return 4;
  }

  return 1;
}

function spawn_single(b_force_spawn, var_eb3a8721 = 0, var_bc66d64b) {
  if(!var_eb3a8721 && !function_fa2289d5()) {
    return undefined;
  }

  if(isDefined(var_bc66d64b)) {
    s_spawn_loc = var_bc66d64b;
  } else if(isDefined(level.var_4e1942d2)) {
    s_spawn_loc = [[level.var_4e1942d2]]();
  } else {
    s_spawn_loc = function_d9f5ec34();
  }

  if(!isDefined(s_spawn_loc)) {
    if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
      iprintlnbold("<dev string:x62>");
    }

    return undefined;
  }

  ai = spawnactor(#"spawner_bo5_avogadro_sr", s_spawn_loc.origin, s_spawn_loc.angles);

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai.ignore_enemy_count = 1;
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
  }

  return ai;
}

function function_68ae7023(var_dbce0c44) {
  if(isDefined(level.var_69f2520a) && level.round_number < level.var_69f2520a) {
    return 0;
  }

  var_8cf00d40 = int(floor(var_dbce0c44 / 50));

  if(level.round_number < 20) {
    var_24f4f99b = 0.02;
  } else if(level.round_number < 30) {
    var_24f4f99b = 0.03;
  } else {
    var_24f4f99b = 0.04;
  }

  return min(var_8cf00d40, int(ceil(level.zombie_total * var_24f4f99b)));
}

function function_f53b79b4(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_3fff25b4)) {
    level.var_3fff25b4 = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"avogadro")) {
      level.var_3fff25b4++;
      n_player_count = zm_utility::function_a2541519(getplayers().size);

      if(n_player_count == 1) {
        level.var_69f2520a = level.round_number + randomintrangeinclusive(2, 4);
        continue;
      }

      level.var_69f2520a = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function function_7cabed4c(entity) {
  target = archetype_avogadro::get_target_ent(entity);

  if(isDefined(target) && archetype_avogadro::function_d58f8483(entity)) {
    archetype_avogadro::function_de781d41(entity);
    return;
  }

  zm_behavior::zombiefindflesh(entity);
}