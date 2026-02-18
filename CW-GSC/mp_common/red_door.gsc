/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\red_door.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace red_door;

function private autoexec __init__system__() {
  system::register(#"red_door", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  init_clientfields();

  function_bc3bedde();
}

function init_clientfields() {
  clientfield::register("allplayers", "" + # "hash_57c792bbf6365c17", 1, 1, "counter");
  clientfield::register("allplayers", "" + # "hash_520c94f4af55e3b8", 1, 1, "counter");
  clientfield::register("allplayers", "" + # "hash_60d81b0a1fcd2454", 1, 1, "counter");
  clientfield::register("scriptmover", "" + # "hash_7948e032082fdac", 1, 2, "int");
  clientfield::register("toplayer", "" + # "hash_3c5be6b25c626e06", 1, 3, "int");
  clientfield::register("toplayer", "" + # "hash_60df070a1fd32106", 1, 1, "int");
}

function private postinit() {
  scene::add_scene_func("p8_fxanim_zm_office_wormhole_bundle", &function_1d5c7052);
  level.var_d03afa3 = [];
  level.var_e30d350e = [];
  level.var_f3901984 = 1.6;
  level.var_7b2bc947 = # "hash_451f320375b42851";
  level.var_7c48c7c3 = "_right";
  var_c10384b6 = struct::get_array("red_door", "groupname");

  foreach(var_d5d4e4c5 in var_c10384b6) {
    door_setup(undefined, var_d5d4e4c5);
  }
}

function function_1d5c7052(a_ents) {
  e_wormhole = a_ents[getfirstarraykey(a_ents)];

  do {
    util::wait_network_frame();
  }
  while(!e_wormhole isplayinganimscripted());

  e_wormhole clientfield::set("" + # "hash_7948e032082fdac", 1);
}

function function_a78584c0(var_6c365dbf, var_7ccf65c7, var_1f8fbe0b = 0) {
  level endon(#"end_game");
  self endon(#"disconnect");
  v_start_origin = self.origin;
  self allowcrouch(0);
  self allowprone(0);
  var_1e1e92e9 = [];

  for(i = 0; i < 4; i++) {
    str_name = "s_teleport_room_" + i + 1;
    var_1e1e92e9[i] = struct::get(str_name, "targetname");
  }

  if(!isDefined(level.var_98b11ed9)) {
    level.var_98b11ed9 = 0;
  }

  s_teleport_room = var_1e1e92e9[level.var_98b11ed9];
  level.var_98b11ed9++;
  var_98b11ed9 = level.var_98b11ed9;

  if(level.var_98b11ed9 >= var_1e1e92e9.size) {
    level.var_98b11ed9 = 0;
  }

  self childthread function_fdb3b5(v_start_origin, s_teleport_room, var_98b11ed9);
  v_vortex_origin = s_teleport_room.origin + anglesToForward(s_teleport_room.angles) * 1000;
  var_291fc0f7 = struct::spawn(v_vortex_origin, s_teleport_room.angles - (0, 90, 0));
  self function_82c1415f(var_291fc0f7, var_1f8fbe0b);
  self clientfield::set_to_player("" + # "hash_3c5be6b25c626e06", 0);

  if(isDefined(self.var_805b8325)) {
    self.var_805b8325 delete();
    self.var_805b8325 = undefined;
  }

  if(isDefined(var_6c365dbf)) {
    if(isarray(var_6c365dbf)) {
      var_f0bbde5 = self function_d4fbc062(var_6c365dbf, var_7ccf65c7);
    } else {
      var_f0bbde5 = var_6c365dbf;
    }

    self function_2aed1d83(var_f0bbde5);
  }

  self allowcrouch(1);
  self allowprone(1);
  self notify(#"fasttravel_over");
}

function private function_fdb3b5(var_a16f5b07, s_teleport_room, var_98b11ed9) {
  util::wait_network_frame();
  self dontinterpolate();
  self setorigin(s_teleport_room.origin);
  self setplayerangles(s_teleport_room.angles);
  self childthread function_e4af83af(s_teleport_room);
  waittillframeend();
  self function_bc82f900(#"hash_5d8a1a68b12dfb24");
  self clientfield::set_to_player("" + # "hash_3c5be6b25c626e06", var_98b11ed9);
}

function private function_e4af83af(s_teleport_room) {
  util::wait_network_frame();
  self.var_805b8325 = spawn("script_origin", s_teleport_room.origin);
  self.var_805b8325.angles = s_teleport_room.angles;
  self linkto(self.var_805b8325);
}

function function_82c1415f(var_291fc0f7, var_1f8fbe0b = 0) {
  level endon(#"end_game");
  self endon(#"death", #"disconnect");
  var_e830c896 = "p8_fxanim_zm_office_wormhole_bundle";

  if(!isDefined(level.var_f3901984)) {
    if(var_1f8fbe0b) {
      var_291fc0f7 thread scene::play(var_e830c896);
      level util::streamer_wait();
      var_291fc0f7 thread scene::stop(var_e830c896);
    } else {
      var_291fc0f7 scene::play(var_e830c896);
    }
  } else if(var_1f8fbe0b) {
    var_291fc0f7 thread scene::play(var_e830c896);
    level util::streamer_wait();
    wait level.var_f3901984;
    var_291fc0f7 thread scene::stop(var_e830c896);
  } else {
    self lui::play_movie(hash("mp_firebase_red_door_tunnel_movie"), "fullscreen", 0, 0, 0, #"", level.var_f3901984);
  }

  self stoprumble(#"hash_5d8a1a68b12dfb24");
  var_291fc0f7 struct::delete();
}

function function_d4fbc062(var_6a4c362c, var_7ccf65c7) {
  n_index = function_4fb1c2d2(var_7ccf65c7);
  a_e_players = getplayers();

  if(self function_60d91d03(var_6a4c362c[n_index], a_e_players)) {
    return var_6a4c362c[n_index];
  }

  foreach(var_f0bbde5 in var_6a4c362c) {
    if(var_f0bbde5 == var_6a4c362c[n_index]) {
      continue;
    }

    if(self function_60d91d03(var_f0bbde5, a_e_players)) {
      return var_f0bbde5;
    }
  }

  iprintln("<dev string:x38>");

  return var_6a4c362c[n_index];
}

function function_4fb1c2d2(var_7ccf65c7) {
  level.var_e30d350e[var_7ccf65c7]++;

  if(level.var_e30d350e[var_7ccf65c7] >= 4) {
    level.var_e30d350e[var_7ccf65c7] = 0;
  }

  return level.var_e30d350e[var_7ccf65c7];
}

function function_60d91d03(var_f0bbde5, a_e_players) {
  b_safe = 1;
  assert(isDefined(var_f0bbde5), "<dev string:x6c>");

  foreach(e_player in a_e_players) {
    if(is_true(e_player.var_16735873)) {
      continue;
    }

    if(abs(var_f0bbde5.origin[2] - e_player.origin[2]) > 60) {
      continue;
    }

    if(distance2dsquared(var_f0bbde5.origin, e_player.origin) > 1024) {
      continue;
    }

    b_safe = 0;
    break;
  }

  return b_safe;
}

function function_32bd90e0(var_7c48c7c3) {
  if(var_7c48c7c3 == "red_door_volume_right") {
    level.var_7c48c7c3 = "_left";
    return;
  }

  if(var_7c48c7c3 == "red_door_volume_left") {
    level.var_7c48c7c3 = "_right";
  }
}

function function_4e050b78(str_volume) {
  e_volume = getent(str_volume, "targetname");
  var_6a4c362c = struct::get_array(str_volume + level.var_7c48c7c3, "script_noteworthy");
  a_e_players = getplayers();
  var_bfeb630c = [];

  foreach(e_player in a_e_players) {
    if(e_player.team != self.team && e_player istouching(e_volume)) {
      if(!isDefined(var_bfeb630c)) {
        var_bfeb630c = [];
      } else if(!isarray(var_bfeb630c)) {
        var_bfeb630c = array(var_bfeb630c);
      }

      var_bfeb630c[var_bfeb630c.size] = e_player;
    }
  }

  var_ab8445e = arraycopy(var_6a4c362c);

  if(var_bfeb630c.size > 0) {
    var_ab8445e = function_3ec6cff6(var_bfeb630c, var_ab8445e, 1);
  } else {
    var_ab8445e = array::randomize(var_ab8445e);
  }

  foreach(var_f0bbde5 in var_ab8445e) {
    if(self function_60d91d03(var_f0bbde5, a_e_players)) {
      function_32bd90e0(var_f0bbde5.script_noteworthy);
      return var_f0bbde5;
    }
  }

  var_6a4c362c = struct::get_array(str_volume);
  var_ab8445e = arraycopy(var_6a4c362c);

  if(var_bfeb630c.size > 0) {
    var_ab8445e = function_3ec6cff6(var_bfeb630c, var_ab8445e);
  }

  foreach(var_f0bbde5 in var_ab8445e) {
    if(self function_60d91d03(var_f0bbde5, a_e_players)) {
      function_32bd90e0(var_f0bbde5.script_noteworthy);
      return var_f0bbde5;
    }
  }

  iprintln("<dev string:xa1>");

  var_6a4c362c = array::randomize(var_6a4c362c);

  foreach(var_f0bbde5 in var_6a4c362c) {
    if(self function_60d91d03(var_f0bbde5, a_e_players)) {
      function_32bd90e0(var_f0bbde5.script_noteworthy);
      return var_f0bbde5;
    }
  }

  iprintln("<dev string:x38>");

  return var_6a4c362c[0];
}

function function_3ec6cff6(var_bfeb630c, var_ab8445e, var_879ad2b9) {
  var_8684b5a9 = [];

  foreach(e_enemy in var_bfeb630c) {
    var_61b87fb = e_enemy getplayerangles();
    var_f27c0c46 = anglesToForward(var_61b87fb);

    foreach(var_f0bbde5 in var_ab8445e) {
      var_342fe9d7 = undefined;
      var_e52d5d9c = vectornormalize(var_f0bbde5.origin - e_enemy.origin);
      n_dot = vectordot(var_f27c0c46, var_e52d5d9c);

      if(n_dot > 0.16) {
        if(is_true(var_879ad2b9)) {
          if(!sighttracepassed(e_enemy getEye(), var_f0bbde5.origin + (0, 0, 64), 0, e_enemy)) {
            var_342fe9d7 = function_26eb27e2(e_enemy, var_f0bbde5);
          }
        }
      } else {
        var_342fe9d7 = function_26eb27e2(e_enemy, var_f0bbde5);
      }

      if(isDefined(var_342fe9d7)) {
        if(!isDefined(var_8684b5a9)) {
          var_8684b5a9 = [];
        } else if(!isarray(var_8684b5a9)) {
          var_8684b5a9 = array(var_8684b5a9);
        }

        var_8684b5a9[var_8684b5a9.size] = var_342fe9d7;
      }
    }

    var_ab8445e = arraycopy(var_8684b5a9);
    var_8684b5a9 = [];
  }

  var_ab8445e = array::sort_by_script_int(var_ab8445e, 0);
  return var_ab8445e;
}

function function_26eb27e2(e_enemy, var_f0bbde5) {
  n_dist_2d_sq = distance2dsquared(e_enemy.origin, var_f0bbde5.origin);

  if(n_dist_2d_sq > 1024) {
    if(!isDefined(var_f0bbde5.script_int)) {
      var_f0bbde5.script_int = n_dist_2d_sq;
    } else if(isDefined(var_f0bbde5.script_int) && var_f0bbde5.script_int > n_dist_2d_sq) {
      var_f0bbde5.script_int = n_dist_2d_sq;
    }

    return var_f0bbde5;
  }

  return undefined;
}

function function_2aed1d83(var_f0bbde5, var_b3733073 = 1) {
  self dontinterpolate();
  self setorigin(var_f0bbde5.origin);
  self setvelocity((0, 0, 0));

  if(var_b3733073 && !isDefined(var_f0bbde5.angles)) {
    println("<dev string:xdf>" + (isDefined(var_f0bbde5.origin) ? var_f0bbde5.origin : "<dev string:x10b>") + "<dev string:x11f>");
  }

  self function_e61d152a();

  if(var_b3733073 && isDefined(var_f0bbde5.angles)) {
    waitframe(1);
    self setplayerangles(var_f0bbde5.angles);
  }

  self.var_16735873 = 0;
  self playSound(#"hash_39708dbc29e8e671");
  self thread function_f86439bc();
}

function function_7a607f29(var_12230d08) {
  self.var_27583a48 = 1;
  self val::set(#"red_door", "ignoreme", 1);
  self val::set(#"red_door", "freezecontrols", 1);
  self val::set(#"red_door", "show_hud", 0);
  self val::set(#"red_door", "takedamage", 0);
  b_disable_weapons = 1;

  if(b_disable_weapons) {
    if(self isusingoffhand()) {
      self forceoffhandend();
    }

    self val::set(#"red_door", "disable_weapons", 1);
  }

  self util::magic_bullet_shield();
}

function function_e61d152a() {
  self show();
  self val::reset(#"red_door", "ignoreme");
  self val::reset(#"red_door", "disable_weapons");
  self val::reset(#"red_door", "freezecontrols");
  self val::reset(#"red_door", "show_hud");
  self val::reset(#"red_door", "takedamage");
  self util::stop_magic_bullet_shield();
  self.var_27583a48 = 0;
}

function function_f86439bc() {
  level endon(#"end_game");
  self endon(#"death", #"disconnect");
  var_e9a9a32a = 1;

  do {
    util::wait_network_frame();
    var_e9a9a32a = 0;
    players = getplayers();

    foreach(e_player in players) {
      if(!isDefined(e_player)) {
        continue;
      }

      n_distance_squared = distance2dsquared(e_player.origin, self.origin);

      if(self != e_player && !is_true(e_player.var_16735873) && n_distance_squared <= 1024) {
        iprintlnbold("<dev string:x143>");

        var_e9a9a32a = 1;
        break;
      }
    }
  }
  while(var_e9a9a32a);
}

function door_setup(struct_targetname, struct, var_9409066b, var_f1096822, var_17716e4f) {
  if(isDefined(struct_targetname)) {
    door_struct = struct::get(struct_targetname, "targetname");
  } else if(isDefined(struct)) {
    door_struct = struct;
  }

  if(!isDefined(door_struct)) {
    return;
  }

  if(isDefined(door_struct.script_noteworthy)) {
    if(door_struct.script_noteworthy == "left") {
      level thread function_bb42a4ce(door_struct.script_noteworthy, "p9_fxanim_mp_firebase_red_door_lt_bundle");
    } else if(door_struct.script_noteworthy == "right") {
      level thread function_bb42a4ce(door_struct.script_noteworthy, "p9_fxanim_mp_firebase_red_door_rt_bundle");
    }
  }

  level.var_e30d350e[door_struct.targetname] = 0;

  if(isDefined(door_struct.linkto)) {
    door_struct.linked_structs = struct::get_array(door_struct.linkto, "linkname");

    if(isDefined(door_struct.linked_structs) && door_struct.linked_structs.size > 0 && !isDefined(door_struct.var_408c6332)) {
      foreach(struct in door_struct.linked_structs) {
        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "door_interact" && isDefined(var_9409066b)) {
          continue;
        }

        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "door_fx" && !isDefined(var_17716e4f)) {
          continue;
        }

        ent = spawn("script_model", struct.origin);
        ent.angles = struct.angles;

        if(isDefined(struct.script_parameters)) {
          ent setModel(struct.script_parameters);
        }

        if(isDefined(struct.script_noteworthy)) {
          ent.script_noteworthy = struct.script_noteworthy;
        }

        if(isDefined(struct.script_string)) {
          ent.script_string = struct.script_string;
        }

        ent.linkname = struct.linkname;

        if(!isDefined(door_struct.var_408c6332)) {
          door_struct.var_408c6332 = 1;
        }
      }
    }

    door_struct.linked_ents = getEntArray(door_struct.linkto, "linkname");

    foreach(ent in door_struct.linked_ents) {
      if(isDefined(ent.script_noteworthy)) {
        switch (ent.script_noteworthy) {
          case # "door_left":
            door_struct.door_left = ent;
            break;
          case # "door_right":
            door_struct.door_right = ent;
            break;
          case # "hash_474cd81e3615d473":
            door_struct.door_frame = ent;
            break;
          case # "hash_7d5f05ba8b4de0a4":
            door_struct.var_113d9d43 = ent;
            break;
          case # "hash_1d188472b888f844":
            if(isDefined(var_f1096822)) {
              if(isDefined(ent.script_parameters) && ent.script_parameters == "door_light_script_model") {
                ent delete();
                break;
              }
            }

            if(!isDefined(door_struct.var_cb5b8c95)) {
              door_struct.var_cb5b8c95 = [];
            }

            if(!isDefined(door_struct.var_cb5b8c95)) {
              door_struct.var_cb5b8c95 = [];
            } else if(!isarray(door_struct.var_cb5b8c95)) {
              door_struct.var_cb5b8c95 = array(door_struct.var_cb5b8c95);
            }

            if(!isinarray(door_struct.var_cb5b8c95, ent)) {
              door_struct.var_cb5b8c95[door_struct.var_cb5b8c95.size] = ent;
            }

            break;
          case # "door_interact":
            door_struct.door_interact = ent;
            door_struct thread function_736b8a03(1);
            break;
          case # "hash_4e931f37285562af":
            if(isDefined(var_f1096822)) {
              if(isDefined(ent)) {
                ent delete();
              }
            } else {
              if(!isDefined(door_struct.var_2c0374ca)) {
                door_struct.var_2c0374ca = [];
              }

              if(!isDefined(door_struct.var_2c0374ca)) {
                door_struct.var_2c0374ca = [];
              } else if(!isarray(door_struct.var_2c0374ca)) {
                door_struct.var_2c0374ca = array(door_struct.var_2c0374ca);
              }

              if(!isinarray(door_struct.var_2c0374ca, ent)) {
                door_struct.var_2c0374ca[door_struct.var_2c0374ca.size] = ent;
              }
            }

            break;
        }
      }
    }
  }

  door_struct.door_setup = 1;
  return door_struct;
}

function function_736b8a03(on) {
  t_door = function_a6dcc63f(self);
  t_door.enemyobjid = gameobjects::get_next_obj_id();
  objective_add(t_door.enemyobjid, "active", t_door.origin, level.var_7b2bc947);
}

function function_a6dcc63f(s_door) {
  if(!isDefined(s_door.door_interact.script_string)) {
    return;
  }

  if(!isDefined(s_door.door_interact.radius)) {
    s_door.door_interact.radius = 26;
  }

  if(!isDefined(s_door.door_interact.height)) {
    s_door.door_interact.height = 88;
  }

  if(!isDefined(s_door.door_interact.z_offset)) {
    s_door.door_interact.z_offset = -39;
  }

  t_door = spawn("trigger_radius", s_door.door_interact.origin + (0, 0, s_door.door_interact.z_offset), 0, s_door.door_interact.radius, s_door.door_interact.height);
  t_door.s_door = s_door;
  t_door triggerignoreteam();
  t_door setvisibletoall();
  t_door setteamfortrigger(#"none");
  t_door callback::on_trigger(&function_e1544483);
  return t_door;
}

function function_e1544483(var_10d5f200) {
  player = var_10d5f200.activator;
  player endon(#"disconnect");

  if(is_true(player.var_27583a48)) {
    return;
  }

  var_8f1ba730 = 0;
  player function_7a607f29();

  if(!var_8f1ba730) {
    while(level.var_d03afa3[self.s_door.door_interact.script_string] === 1) {
      util::wait_network_frame();
    }

    level thread function_78e3c2ba(self.s_door.door_interact.script_string);
  }

  if(isalive(self)) {
    str_stance = self getstance();

    if(self isstanceallowed("stand")) {
      switch (str_stance) {
        case # "crouch":
          self setstance("stand");
          wait 0.2;
          break;
        case # "prone":
          self setstance("stand");
          wait 1;
          break;
        default:
          break;
      }
    }
  }

  self.s_door.door_interact playSound(#"hash_779c0992525e3838");
  player ghost();

  if(isDefined(self.s_door.script_noteworthy)) {
    if(self.s_door.script_noteworthy == "left") {
      player clientfield::increment("" + # "hash_57c792bbf6365c17", 1);
    } else if(self.s_door.script_noteworthy == "right") {
      player clientfield::increment("" + # "hash_520c94f4af55e3b8", 1);
    }
  }

  player function_a78584c0(undefined, self.s_door.targetname);
  var_f0bbde5 = player function_c78572ab(self.s_door.door_interact.script_string, self.s_door.targetname);
  player function_2aed1d83(var_f0bbde5);
  player thread function_71178f71();
}

function function_71178f71() {
  self endon(#"death", #"disconnect");
  self clientfield::set_to_player("" + # "hash_60df070a1fd32106", 1);
  self clientfield::increment("" + # "hash_60d81b0a1fcd2454", 1);
  wait 1.6;
  self clientfield::set_to_player("" + # "hash_60df070a1fd32106", 0);
}

function function_78e3c2ba(var_5817f611) {
  level endon(#"end_game");
  level.var_d03afa3[var_5817f611] = 1;
  util::wait_network_frame(2);
  level.var_d03afa3[var_5817f611] = undefined;
}

function function_c78572ab(var_f80635c, var_7ccf65c7) {
  str_volume = "red_door_volume";
  var_f0bbde5 = self function_4e050b78(str_volume);
  return var_f0bbde5;
}

function function_7a74dbfd(str_targetname) {
  var_6a4c362c = [];

  for(i = 1; i <= 4; i++) {
    var_f0bbde5 = struct::get(str_targetname + i);
    assert(isDefined(var_f0bbde5), "<dev string:x16b>" + str_targetname + i);

    if(!isDefined(var_6a4c362c)) {
      var_6a4c362c = [];
    } else if(!isarray(var_6a4c362c)) {
      var_6a4c362c = array(var_6a4c362c);
    }

    var_6a4c362c[var_6a4c362c.size] = var_f0bbde5;
  }

  return var_6a4c362c;
}

function function_bb42a4ce(str_side, var_3b3f5ecb) {
  trigger::wait_till("red_door_trigger_" + str_side);
  scene::play(var_3b3f5ecb);
}

function function_bc3bedde() {
  var_2c251c2e = util::get_map_name();
  adddebugcommand("<dev string:x18f>" + var_2c251c2e + "<dev string:x1a0>");
  level thread devgui_think();
}

function devgui_think() {
  while(true) {
    var_faa79144 = getDvar(#"start_teleport", "<dev string:x1cc>");

    if(var_faa79144 == "<dev string:x1d1>") {
      setDvar(#"start_teleport", "<dev string:x1cc>");

      if(!is_true(level.var_2a40310c)) {
        level.var_2a40310c = 1;
        level thread function_8d419972(1);
      }
    }

    waitframe(1);
  }
}

function function_8d419972(b_play_once) {
  level endon(#"end_game");
  s_loc = struct::spawn((0, 0, 0));
  player = level.players[0];
  player endon(#"disconnect");
  var_78e5d9d1 = player.origin;
  v_start_angles = player.angles;

  while(is_true(level.var_2a40310c)) {
    player function_a78584c0(s_loc);

    if(is_true(b_play_once)) {
      level.var_2a40310c = 0;
    }
  }

  player setorigin(var_78e5d9d1);
  player setplayerangles(v_start_angles);
}