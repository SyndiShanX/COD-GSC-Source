/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_176597095ddfaa17.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_d0ab5955;

function private autoexec __init__system__() {
  system::register(#"hash_d07e35f920d16a8", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  clientfield::register("scriptmover", "fogofwarflag", 1, 1, "int");
  clientfield::register("toplayer", "fogofwareffects", 1, 2, "int");
  clientfield::register("toplayer", "fogofwartimer", 1, 1, "int");
  clientfield::register("allplayers", "outsidetile", 1, 1, "int");
  clientfield::register("world", "tile_id", 1, 6, "int");

  if(!is_true(getgametypesetting(#"hash_59854c1f30538261"))) {
    return;
  }

  level.var_ac22a760 = struct::get_array(#"hash_3460aae6bb799a99", "content_key");

  for(index = 1; index <= level.var_ac22a760.size; index++) {
    level.var_ac22a760[index - 1].id = index;
  }
}

function init() {
  if(!is_true(getgametypesetting(#"hash_59854c1f30538261"))) {
    return;
  }

  level.var_3814eac9 = getEntArray("trigger_within_bounds", "classname");

  foreach(var_df0c0b31 in level.var_3814eac9) {
    var_df0c0b31.activated = 0;
  }

  level.var_f2211522 = getEntArray("survival_fow", "script_noteworthy");
  callback::on_connect(&on_connect);
  callback::on_game_playing(&start);
}

function private on_connect() {
  self val::set(#"fog_of_war", "disable_oob", 1);
  self.oob_start_time = -1;
}

function start() {
  level thread function_dc15ad60();
  level thread function_e568ca74();
  var_ef325671 = getEntArray("sr_boundary_clip", "targetname");

  foreach(var_b3a455bb in var_ef325671) {
    var_b3a455bb setforcenocull();
  }
}

function function_e568ca74() {
  level endon(#"hash_1c6770a6f6ea06b6");
  level flag::wait_till_clear(#"hash_4930756571725d11");
  var_123dc898 = getent("fow_border_all", "targetname");

  if(isDefined(var_123dc898)) {
    var_123dc898 clientfield::set("fogofwarflag", 1);
  }
}

function function_1c5219e4(var_6874207, var_d001b56c) {
  var_df0c0b31 = getent(var_6874207, "targetname");
  var_9bdd487c = getent(var_d001b56c, "targetname");

  if(isDefined(var_df0c0b31) && isDefined(var_9bdd487c)) {
    var_df0c0b31.var_9bdd487c = var_9bdd487c;
  }
}

function function_d4dec4e8(destination, str_targetname) {
  level.var_973f0101 = 1;

  if(isDefined(destination.contentgroups[# "hash_3460aae6bb799a99"])) {
    if(isDefined(str_targetname)) {
      foreach(var_87e97a7a in destination.contentgroups[# "hash_3460aae6bb799a99"]) {
        if(var_87e97a7a.targetname === str_targetname) {
          var_6c486d1a = var_87e97a7a;
          break;
        }
      }
    } else {
      var_6c486d1a = destination.contentgroups[# "hash_3460aae6bb799a99"][0];
    }

    if(isDefined(var_6c486d1a)) {
      var_6c486d1a.activated = 1;
      var_f6b2bc6f = getent(var_6c486d1a.targetname, "target");

      if(isDefined(var_f6b2bc6f)) {
        var_f6b2bc6f.activated = 1;
      }

      level clientfield::set("tile_id", var_6c486d1a.id);

      if(!isDefined(var_6c486d1a.spawned_model)) {
        var_6c486d1a.spawned_model = util::spawn_model(var_6c486d1a.model, var_6c486d1a.origin, var_6c486d1a.angles);
      } else {
        var_6c486d1a.spawned_model show();
      }

      if(isDefined(var_6c486d1a.script_noteworthy)) {
        if(!isDefined(var_6c486d1a.var_47f0063b)) {
          var_6c486d1a.var_47f0063b = util::spawn_model(var_6c486d1a.script_noteworthy, var_6c486d1a.origin, var_6c486d1a.angles);
        } else {
          var_6c486d1a.var_47f0063b show();
        }

        var_6c486d1a.var_47f0063b clientfield::set("fogofwarflag", 1);
      }

      var_6c486d1a.spawned_model clientfield::set("fogofwarflag", 1);
    }
  }
}

function function_f1ad7968(destination, str_targetname) {
  if(isDefined(destination.contentgroups[# "hash_3460aae6bb799a99"])) {
    if(isDefined(str_targetname)) {
      foreach(var_87e97a7a in destination.contentgroups[# "hash_3460aae6bb799a99"]) {
        if(var_87e97a7a.targetname === str_targetname) {
          var_6c486d1a = var_87e97a7a;
          break;
        }
      }
    } else {
      var_6c486d1a = destination.contentgroups[# "hash_3460aae6bb799a99"][0];
    }

    if(isDefined(var_6c486d1a)) {
      var_6c486d1a.activated = 0;
      var_f6b2bc6f = getent(var_6c486d1a.targetname, "target");

      if(isDefined(var_f6b2bc6f)) {
        var_f6b2bc6f.activated = 0;
      }

      if(isDefined(var_6c486d1a.spawned_model)) {
        var_6c486d1a.spawned_model hide();
      }

      if(isDefined(var_6c486d1a.var_47f0063b)) {
        var_6c486d1a.var_47f0063b hide();
      }
    }
  }
}

function function_ac8a88de(var_6874207, var_d0c31a32) {
  level.var_973f0101 = 1;
  var_df0c0b31 = getent(var_d0c31a32, "targetname");

  if(isDefined(var_df0c0b31)) {
    var_df0c0b31.activated = 1;

    foreach(var_ea0ed69c in level.var_ac22a760) {
      if(var_ea0ed69c.target == var_df0c0b31.targetname) {
        level clientfield::set("tile_id", var_ea0ed69c.id);
      }
    }

    if(isDefined(var_df0c0b31.var_9bdd487c)) {
      var_62567791 = getent(var_df0c0b31.var_9bdd487c.target, "targetname");

      if(isDefined(var_62567791)) {
        var_62567791 clientfield::set("fogofwarflag", 1);
      }
    }

    var_df0c0b31 thread function_fcf7c9c8();
  }
}

function private function_fcf7c9c8() {
  self endon(#"death");
  move_origin = self.origin + (0, 0, -20000);
  self moveto(move_origin, 3);
  wait 5;
  self delete();
}

function function_3824d2dc(v_loc) {
  if(!isDefined(level.var_3814eac9)) {
    return true;
  }

  if(!isDefined(v_loc)) {
    v_loc = self.origin;
  }

  foreach(var_df0c0b31 in level.var_3814eac9) {
    if(!is_true(var_df0c0b31.activated)) {
      continue;
    }

    if(var_df0c0b31 istouching(v_loc)) {
      return true;
    }
  }

  return false;
}

function function_dc15ad60() {
  level endoncallback(&cleanup_feedback, #"game_ended");
  level flag::wait_till_clear(#"hash_4930756571725d11");

  while(true) {
    if(is_true(level.var_973f0101)) {
      break;
    }

    waitframe(1);
  }

  var_39106ebf = [];
  var_f4d9a132 = gettime() + int(1 * 1000);
  var_549429b9 = int(3.33333 * 1000);
  var_3c43f4e0 = var_549429b9 * 2;
  var_10e74788 = 10;
  var_69a1706b = int(var_10e74788 / 3);
  var_2df437f5 = 0;

  for(i = 1; i <= var_69a1706b; i++) {
    var_2df437f5 += var_69a1706b * i;
  }

  while(true) {
    time = gettime();
    dodamage = time >= var_f4d9a132;
    var_6effa129 = arraycombine(getplayers(), getvehiclearray());

    foreach(entity in var_6effa129) {
      if(!isDefined(entity.var_6a2e2f41)) {
        entity.var_6a2e2f41 = gettime();
      }

      if(isPlayer(entity) && (!isalive(entity) || entity scene::is_igc_active())) {
        entity clientfield::set("outsidetile", 0);
        entity hide_effects();
        continue;
      }

      if(!entity function_3824d2dc() && !is_true(entity.b_ignore_fow_damage) && isDefined(entity.maxhealth)) {
        player = undefined;
        vehicle = undefined;

        if(!isDefined(entity.var_9a1624b5)) {
          entity.var_9a1624b5 = time;
        }

        elapsed_time = time - entity.var_9a1624b5;

        if(elapsed_time < var_549429b9) {
          intensity = 1;
        } else if(elapsed_time < var_3c43f4e0) {
          intensity = 2;
        } else {
          intensity = 3;
        }

        var_727ff533 = entity.maxhealth / var_2df437f5;
        var_9d778583 = int(var_727ff533 * intensity);

        if(isPlayer(entity)) {
          entity clientfield::set("outsidetile", 1);
          entity show_effects(intensity);
          player = entity;
        }

        if(dodamage) {
          if(isDefined(player)) {
            if(is_true(player.var_e5f956c5)) {
              var_9d778583 *= 2;
            }

            player dodamage(var_9d778583, player.origin, undefined, undefined, undefined, "MOD_TRIGGER_HURT", 8192);
            player playsoundtoplayer(#"hash_11f49f9aedeeff5e", player);
            player function_bc82f900(#"damage_light");

            if(time >= player.var_6a2e2f41) {
              player thread globallogic_audio::play_taacom_dialog("fogOfWarTrappedPlayer");
              player.var_6a2e2f41 = time + int(240 * 1000);
            }
          } else if(isvehicle(entity)) {
            vehicle = entity;

            if(is_true(vehicle.var_e5f956c5)) {
              var_9d778583 *= 2;
            }

            if(!is_false(vehicle.allowdeath) && var_9d778583 >= vehicle.health) {
              occupants = vehicle getvehoccupants();

              foreach(occupant in occupants) {
                occupant unlink();
              }
            }

            callback::callback(#"hash_473c82ed6a4bc96c", {
              #vehicle: vehicle
            });
            vehicle dodamage(var_9d778583, vehicle.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE", 8192);
          }
        }

        continue;
      }

      if(isPlayer(entity)) {
        entity clientfield::set("outsidetile", 0);
        entity hide_effects();
      }

      entity.var_9a1624b5 = undefined;
    }

    if(dodamage) {
      var_f4d9a132 = gettime() + int(1 * 1000);
    }

    waitframe(1);
  }
}

function private cleanup_feedback(notifyhash) {
  foreach(player in getplayers()) {
    player hide_effects();
  }
}

function show_effects(intensity) {
  if(self clientfield::get_to_player("fogofwareffects") == 0 && !self isinmovemode("ufo", "noclip")) {
    self clientfield::set_to_player("fogofwartimer", 1);
  }

  self clientfield::set_to_player("fogofwareffects", 2);
}

function hide_effects() {
  if(self clientfield::get_to_player("fogofwareffects") != 0) {
    self clientfield::set_to_player("fogofwartimer", 0);
  }

  self clientfield::set_to_player("fogofwareffects", 0);
}