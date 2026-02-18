/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4ac176571c275fbf.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace namespace_d2883a2e;

function private autoexec __init__system__() {
  system::register(#"hash_624dc0720663b513", &preinit, &postinit, undefined, undefined);
}

function preinit() {
  var_f7d8aaa7 = strtok("koth10v10 ctf vip conf10v10 dom10v10 tdm10v10 war12v12 zsurvival", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_f7d8aaa7, gametype)) {
    level thread scene::skipto_end(#"hash_6985968bcd70fea5");
  }
}

function postinit() {
  init_devgui();

  callback::on_vehicle_spawned(&on_vehicle_spawned);
}

function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  var_6031fb1f = eventstruct.vehicle;

  if(isvehicle(var_6031fb1f) && is_true(var_6031fb1f.var_a419f368)) {
    waitframe(1);

    if(isalive(var_6031fb1f)) {
      var_6031fb1f takeplayercontrol();

      while(isalive(var_6031fb1f) && var_6031fb1f function_7548ecb2()) {
        waitframe(1);
      }

      if(isalive(var_6031fb1f)) {
        var_6031fb1f returnplayercontrol();
      }
    }
  }
}

function on_vehicle_spawned() {
  level endon(#"game_ended");
  var_6031fb1f = self;

  if(isDefined(var_6031fb1f.target)) {
    var_6031fb1f.var_a419f368 = 1;
    var_d8cde75b = struct::get(var_6031fb1f.target);

    if(isDefined(var_d8cde75b.target)) {
      fall = struct::get(var_d8cde75b.target);
      fall.targetname = undefined;
      fall thread scene::init(fall.scriptbundlename);
    }
  }

  wait 1;
  waitframe(1);

  if(isDefined(var_6031fb1f) && isDefined(var_d8cde75b)) {
    var_6031fb1f thread function_d765ccad();

    if(isDefined(var_d8cde75b) && is_true(var_d8cde75b.var_2fdd4465) && getdvarint(#"hash_11091de0ff4dd715", 1)) {
      var_6031fb1f player_vehicle::function_971ca64b();

      if(!isDefined(var_d8cde75b.script_side)) {
        var_d8cde75b.script_side = "port";
      }

      var_d487d45c = fall.scene_ents[# "prop 1"];

      while(!isDefined(var_d487d45c) && isalive(var_6031fb1f)) {
        var_d487d45c = fall.scene_ents[# "prop 1"];
        waitframe(1);
      }

      if(isalive(var_6031fb1f)) {
        var_6031fb1f.var_369c83bd = 1;
        var_6031fb1f.var_475b9991 = 1;
        var_6031fb1f.var_c0381a15 = 1;
        var_6031fb1f linkto(var_d487d45c, "tag_jetski", (0, 0, 0), (0, 0, 0));
      }

      var_c8229258 = "enter_vehicle";

      if(getdvarint(#"hash_23e9bea0349746ee", 0)) {
        var_c8229258 = "deploy";
      }

      if(isalive(var_6031fb1f)) {
        var_71383cea = var_6031fb1f waittill(#"death", #"delete", var_c8229258);

        if(var_71383cea._notify === "death") {
          if(isDefined(var_6031fb1f)) {
            var_6031fb1f notsolid();

            while(isDefined(var_6031fb1f)) {
              waitframe(1);
            }
          }
        }

        level thread function_9610785e(var_6031fb1f, var_c8229258);
      }

      var_75fd5da3 = 1;

      if(isvehicle(var_6031fb1f) && function_a6b2f443(var_6031fb1f)) {
        var_75fd5da3 = 1;
      }

      if(isDefined(var_d8cde75b)) {
        if(isDefined(fall) && isDefined(fall.scriptbundlename)) {
          fall thread scene::play(fall.scriptbundlename);

          if(isalive(var_6031fb1f)) {
            var_2e4576cb = groundtrace(var_6031fb1f.origin, var_6031fb1f.origin + (0, 0, -1024), 1, var_6031fb1f, 0, 0);
            offset = vectorscale(anglestoright(var_6031fb1f.angles) * -1, 8);
            rotation = 42;

            if(var_d8cde75b.script_side == "starboard") {
              rotation = -42;
              offset = vectorscale(anglestoright(var_6031fb1f.angles), 8);
            }

            var_6b6fec6c = var_2e4576cb[# "position"] + offset;
            fall_time = abs(distance(var_6031fb1f.origin, var_6b6fec6c) / 390);

            if(isDefined(var_6031fb1f)) {
              if(var_75fd5da3) {
                recenter_time = fall_time + 1;
                var_6b6fec6c = var_6031fb1f.origin + offset;
                fall_time = 0.1;
              }

              var_c11876a8 = util::spawn_model(#"tag_origin", var_6031fb1f.origin, var_6031fb1f.angles, undefined, 1);

              while(!isDefined(var_c11876a8) && isalive(var_6031fb1f)) {
                waitframe(1);
              }

              if(isalive(var_6031fb1f)) {
                var_6031fb1f unlink();
                var_6031fb1f linkto(var_c11876a8);
                var_c11876a8 rotateyaw(rotation, fall_time);

                if(isDefined(var_c11876a8)) {
                  var_c11876a8 moveto(var_6b6fec6c, fall_time);
                  var_c11876a8 waittill(#"movedone");
                }
              }
            }

            player = var_6031fb1f.var_3ba86b09;

            if(isalive(player) && isDefined(var_6031fb1f)) {
              player setplayerangles(var_6031fb1f.angles);
            }
          }
        }

        if(isDefined(var_6031fb1f)) {
          var_6031fb1f.var_369c83bd = 0;
          var_6031fb1f.var_475b9991 = 0;
          var_6031fb1f.var_c0381a15 = 0;
          var_6031fb1f unlink();
          var_6031fb1f.var_a419f368 = 0;
        }

        if(isDefined(var_c11876a8)) {
          var_c11876a8 delete();
        }
      }

      wait 10;

      if(isalive(var_6031fb1f)) {
        var_6031fb1f player_vehicle::function_a2626745();
      }
    }
  }
}

function function_a6b2f443(vehicle) {
  var_33423a7b = getentitiesinradius(vehicle.origin, 256, 12);

  foreach(var_59efbf47 in var_33423a7b) {
    if(isvehicle(vehicle) && isvehicle(var_59efbf47)) {
      var_f29b8c9e = 1;

      for(i = 0; i < 3; i++) {
        occupant = var_59efbf47 getseatoccupant(i);

        if(isPlayer(occupant)) {
          var_f29b8c9e = 1;
        }
      }

      if(vehicle == var_59efbf47 || !var_f29b8c9e) {
        continue;
      }

      near_dist = 0;

      if(vehicle.vehicletype === var_59efbf47.vehicletype) {
        near_dist = 128;
      } else if(var_59efbf47.vehicletype === # "hash_2c0e11a1e87bbcd5") {
        near_dist = 256;
      }

      if(getdvarint(#"hash_1a2565fdb8e16ca9", 0)) {
        sphere(vehicle.origin, 32, (1, 0, 0));
        circle(var_59efbf47.origin, near_dist, (1, 0, 0), undefined, 1);
      }

      if(distance2dsquared(vehicle.origin, var_59efbf47.origin) <= near_dist * near_dist) {
        return true;
      }
    }
  }

  return false;
}

function function_d765ccad() {
  if(!getdvarint(#"hash_434bcbd42475a326", 0)) {
    return;
  }

  str_type = function_9e72a96(self.vehicletype);

  if(str_type === "<dev string:x38>") {
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
  level flag::wait_till("<dev string:x5c>");
  location = self.origin;

  if(isDefined(self.target)) {
    deploy = struct::get(self.target);
    var_b3d2d0b5 = deploy.origin;
  }

  while(getdvarint(#"hash_434bcbd42475a326", 0)) {
    var_91d1913b = distance(level.players[0].origin, location);
    n_radius = 0.015 * var_91d1913b;

    if(n_radius > 768) {
      n_radius = 768;
    }

    if(var_91d1913b > 768) {
      sphere(location, n_radius, (1, 0, 1));

      if(var_91d1913b < 2048) {
        print3d(location + (0, 0, 32), str_type, (1, 0, 1));
      }

      if(isDefined(deploy)) {
        sphere(var_b3d2d0b5, n_radius, (1, 1, 0));

        if(var_91d1913b < 2048) {
          print3d(var_b3d2d0b5 + (0, 0, 32), str_type, (1, 1, 0));
        }
      }
    }

    if(getdvarint(#"hash_434bcbd42475a326", 0) && distance2d(v_spawn_pos, location) > 768) {
      line(v_spawn_pos, location, (0, 1, 0));
      circle(v_spawn_pos, 64, (0, 1, 0), 0, 1);
    }

    waitframe(1);
  }
}

function function_f567f0cd() {
  level notify(#"hash_79845fe0e187bb22");
  level endon(#"hash_79845fe0e187bb22");

  while(getdvarint(#"hash_434bcbd42475a326", 0)) {
    n_total = 0;
    var_bd9acc19 = 176;

    foreach(var_f0ffe8b2 in level.var_6eef6733) {
      var_bd9acc19 += 24;
      n_total += var_f0ffe8b2.size;

      foreach(var_3ed342fe in var_f0ffe8b2) {
        if(isvehicle(var_3ed342fe) && isDefined(var_f0ffe8b2) && isDefined(var_f0ffe8b2[0]) && isDefined(var_f0ffe8b2[0].vehicletype)) {
          debug2dtext((810, var_bd9acc19, 0), function_9e72a96(var_f0ffe8b2[0].vehicletype) + "<dev string:x74>" + var_f0ffe8b2.size, var_3ed342fe function_b2775b52());
          break;
        }
      }
    }

    debug2dtext((810, 176, 0), "<dev string:x7a>" + n_total, (1, 1, 1));
    waitframe(1);
  }
}

function function_b2775b52(deploy, type) {
  if(isDefined(type)) {
    return (1, 1, 0);
  }

  return (0, 1, 0);
}

function init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x94>" + mapname + "<dev string:xa5>");
  adddebugcommand("<dev string:x94>" + mapname + "<dev string:x10a>");
  adddebugcommand("<dev string:x94>" + mapname + "<dev string:x171>");
}

function function_d40977b5(var_c11876a8) {
  while(getdvarint(#"hash_7a02ac0fa3a4eb82", 0) && isDefined(var_c11876a8)) {
    sphere(var_c11876a8.origin, 4, (1, 0, 1));
    waitframe(1);
  }
}

function function_9610785e(var_6031fb1f, var_c8229258) {
  if(!getdvarint(#"hash_5e29e20bd416e7e1", 0)) {
    return;
  }

  foreach(vehicle in getvehiclearray()) {
    if(var_6031fb1f !== vehicle && is_true(vehicle.var_a419f368)) {
      waittillframeend();
      vehicle notify(var_c8229258);
    }
  }
}