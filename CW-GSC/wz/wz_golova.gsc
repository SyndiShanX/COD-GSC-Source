/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz\wz_golova.gsc
***********************************************/

#using script_72d96920f15049b8;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#namespace wz_golova;

function event_handler[level_init] main(eventstruct) {
  callback::on_vehicle_spawned(&debug_vehicle_spawn);

  load::main();
  level.var_e1206a08 = 1;
  function_a387f4f5();
  scene::function_497689f6(#"cin_hpc_intro", "hpc_intro_air_transport", "tag_probe_attach", "probe_hpc_intro_hero_plane");
  scene::function_497689f6(#"cin_hpc_intro_allies", "hpc_intro_air_transport", "tag_probe_attach", "probe_hpc_intro_hero_plane");
  scene::function_497689f6(#"cin_hpc_outro", "helicopter", "tag_probe_cabin", "prb_tn_us_heli_lg_cabin");
  scene::function_497689f6(#"cin_hpc_outro", "helicopter", "tag_probe_cockpit", "prb_tn_us_heli_lg_cockpit");
  compass::setupminimap("");
  function_e8fa58f2();
  function_564698fd();
}

function function_e8fa58f2() {
  hidemiscmodels("sv_holdout_aetherfungus");
  hidemiscmodels("defend_corpses_1");
  hidemiscmodels("defend_corpses_2");
  hidemiscmodels("defend_corpses_3");
  hidemiscmodels("defend_corpses_4");
  hidemiscmodels("defend_corpses_5");
  hidemiscmodels("defend_corpses_6");
  hidemiscmodels("hvt_mechz_corpses");
  hidemiscmodels("hvt_mimic_corpses");
  hidemiscmodels("hvt_raz_corpses");
  hidemiscmodels("hvt_steiner_corpses");
  hidemiscmodels("payload_teleport_corpses");
  hidemiscmodels("payload_noteleport_corpses");
  hidemiscmodels("retrieval_corpses");
  hidemiscmodels("retrieval_corpses_2");
  hidemiscmodels("secure_corpses");
  hidemiscmodels("hordehunt_corpses_1");
  hidemiscmodels("hordehunt_corpses_2");
  hidemiscmodels("hordehunt_corpses_3");
  hidemiscmodels("fishing_setup");
  hidemiscmodels("transport_corpses");
}

function function_564698fd() {
  gametype = function_be90acca(util::get_game_type());

  if(gametype === "zsurvival") {
    level.mapcenter = (-9863.87, 9707.61, 257.607);
    namespace_e8c18978::function_d887d24d("chopper_gunner_vol_golova_1");
    namespace_e8c18978::function_d887d24d("chopper_gunner_vol_golova_2");
  }
}

function function_a387f4f5() {
  if(level.basegametype == # "fireteam_dirty_bomb" || level.basegametype == # "fireteam_elimination" || level.basegametype == # "fireteam_koth" || level.basegametype == # "fireteam_satlink") {
    level thread function_f9492b33();

    if(isDefined(level.var_574cc797)) {
      level thread[[level.var_574cc797]](#"hash_5a88477bbf0736f1", level.var_b9f31e66);
      level thread[[level.var_574cc797]](#"hash_1c4eccf00713d9c7", level.var_b9f31e66);
      level thread[[level.var_574cc797]](#"hash_d5c723294842e7c", level.var_b9f31e66);
    }
  }
}

function debug_vehicle_spawn() {
  self thread function_f42944c7();
}

function function_f42944c7() {
  if(!getdvarint(#"hash_57a9b32c8a8503f1", 0) || !self function_1221d304()) {
    return;
  }

  self endon(#"death");

  if(!isDefined(level.var_6eef6733)) {
    level.var_6eef6733 = [];
  }

  if(!isDefined(level.var_6eef6733[function_9e72a96(self.vehicletype)])) {
    level.var_6eef6733[function_9e72a96(self.vehicletype)] = [];
  }

  if(!isDefined(level.var_6eef6733[function_9e72a96(self.vehicletype)])) {
    level.var_6eef6733[function_9e72a96(self.vehicletype)] = [];
  } else if(!isarray(level.var_6eef6733[function_9e72a96(self.vehicletype)])) {
    level.var_6eef6733[function_9e72a96(self.vehicletype)] = array(level.var_6eef6733[function_9e72a96(self.vehicletype)]);
  }

  level.var_6eef6733[function_9e72a96(self.vehicletype)][level.var_6eef6733[function_9e72a96(self.vehicletype)].size] = self;
  v_spawn_pos = self.origin;
  level thread function_f567f0cd();
  level flag::wait_till("<dev string:x38>");
  str_type = function_9e72a96(self.vehicletype);
  v_color = self function_b2775b52();

  while(getdvarint(#"hash_57a9b32c8a8503f1", 0)) {
    var_91d1913b = distance2d(level.players[0].origin, self.origin);
    n_radius = 0.015 * var_91d1913b;

    if(n_radius > 768) {
      n_radius = 768;
    }

    if(var_91d1913b > 768) {
      sphere(self.origin, n_radius, v_color);

      if(var_91d1913b < 2048) {
        print3d(self.origin + (0, 0, 32), str_type, v_color);
      }
    }

    if(getdvarint(#"hash_491fd7f96bbc8909", 0) && distance2d(v_spawn_pos, self.origin) > 768) {
      line(v_spawn_pos, self.origin, v_color);
      circle(v_spawn_pos, 64, v_color, 0, 1);
    }

    waitframe(1);
  }
}

function function_f567f0cd() {
  level notify(#"hash_79845fe0e187bb22");
  level endon(#"hash_79845fe0e187bb22");

  while(getdvarint(#"hash_57a9b32c8a8503f1", 0)) {
    n_total = 0;
    var_bd9acc19 = 176;

    foreach(var_f0ffe8b2 in level.var_6eef6733) {
      var_bd9acc19 += 24;
      n_total += var_f0ffe8b2.size;

      foreach(var_3ed342fe in var_f0ffe8b2) {
        if(isvehicle(var_3ed342fe) && isDefined(var_f0ffe8b2) && isDefined(var_f0ffe8b2[0]) && isDefined(var_f0ffe8b2[0].vehicletype)) {
          debug2dtext((810, var_bd9acc19, 0), function_9e72a96(var_f0ffe8b2[0].vehicletype) + "<dev string:x50>" + var_f0ffe8b2.size, var_3ed342fe function_b2775b52());
          break;
        }
      }
    }

    debug2dtext((810, 176, 0), "<dev string:x56>" + n_total, (1, 1, 1));
    waitframe(1);
  }
}

function function_1221d304() {
  a_str_types = array(#"veh_quad_player_wz_blk", #"hash_232abda4e81275f4", #"veh_quad_player_wz_grn", #"hash_2f8d60a5381870ee", #"veh_quad_player_wz_tan", #"veh_mil_ru_fav_heavy", #"vehicle_t9_mil_fav_light", #"hash_42b91f3544c1a9e1", #"hash_6595f5efe62a4ec", #"hash_17e868e0ebf3c1d6", #"vehicle_motorcycle_mil_us_offroad", #"hash_2c0e11a1e87bbcd5", #"vehicle_t9_mil_snowmobile", #"hash_28d512b739c9d9c1", #"hash_2d32c08b862baa46", #"vehicle_t9_mil_ru_truck_light_player", #"hash_2a245bf3738fed8b", #"vehicle_t9_civ_ru_sedan_80s_player", #"hash_dd63f34c77a725e");

  foreach(str_type in a_str_types) {
    if(self.vehicletype == str_type) {
      return 1;
    }
  }

  return 0;
}

function function_b2775b52() {
  switch (self.vehicletype) {
    case # "hash_6595f5efe62a4ec":
      return (1, 0, 0);
    case # "hash_17e868e0ebf3c1d6":
      return (1, 0, 0);
    case # "hash_2c0e11a1e87bbcd5":
      return (1, 0, 0);
    case # "hash_dd63f34c77a725e":
    case # "hash_2a245bf3738fed8b":
      return (1, 1, 1);
    case # "veh_mil_ru_fav_heavy":
      return (1, 0.5, 0);
    case # "hash_28d512b739c9d9c1":
      return (1, 1, 0);
    case # "vehicle_t9_mil_fav_light":
      return (0, 1, 0);
    case # "hash_42b91f3544c1a9e1":
      return (0, 1, 1);
    case # "hash_2d32c08b862baa46":
    case # "vehicle_t9_mil_ru_truck_light_player":
    case # "vehicle_t9_civ_ru_sedan_80s_player":
      return (0, 1, 1);
    case # "vehicle_t9_mil_snowmobile":
      return (0, 0, 1);
    case # "vehicle_motorcycle_mil_us_offroad":
      return (1, 0, 1);
    case # "veh_quad_player_wz_tan":
    case # "veh_quad_player_wz_blk":
    case # "hash_232abda4e81275f4":
    case # "hash_2f8d60a5381870ee":
    case # "veh_quad_player_wz_grn":
      return (1, 0, 1);
    default:
      return (0, 0, 0);
  }
}

function function_f9492b33() {
  if(!getdvarint(#"hash_31ae3e289b7b921d", 0)) {
    return;
  }

  level flag::wait_till("<dev string:x38>");

  if(!isDefined(level.dirtybombs)) {
    return;
  }

  while(getdvarint(#"hash_31ae3e289b7b921d", 0)) {
    dirtybombs = arraysortclosest(level.dirtybombs, level.players[0].origin, 32, 0, 100000);

    foreach(dirtybomb in dirtybombs) {
      waitframe(1);

      if(!level.players[0] util::is_player_looking_at(dirtybomb.origin, 0.6, 0)) {
        continue;
      }

      sphere(dirtybomb.origin, 32, (1, 1, 0), 1, 0, 8, 2);
      circle(dirtybomb.origin, 96, (1, 1, 0), 0, 1, 2);
    }
  }
}

function function_d72aa67e(str_list, str_name) {
  a_str_tok = strtok(str_list, "<dev string:x70>");

  foreach(tok in a_str_tok) {
    if(tok == str_name) {
      return 1;
    }
  }

  return 0;
}

function function_47351fa3(org, ang, opcolor, frames) {
  if(!isDefined(frames)) {
    frames = 1;
  }

  forward = anglesToForward(ang);
  forwardfar = vectorscale(forward, 50);
  forwardclose = vectorscale(forward, 50 * 0.8);
  right = anglestoright(ang);
  left = anglestoright(ang) * -1;
  leftdraw = vectorscale(right, 50 * -0.2);
  rightdraw = vectorscale(right, 50 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, 50);
  left = vectorscale(left, 50);
  up = vectorscale(up, 50);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);

  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }

  line(org, org + forwardfar, red, 0.9, 0, frames);
  line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9, 0, frames);
  line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9, 0, frames);
  line(org, org + right, blue, 0.9, 0, frames);
  line(org, org + left, blue, 0.9, 0, frames);
  line(org, org + up, green, 0.9, 0, frames);
}