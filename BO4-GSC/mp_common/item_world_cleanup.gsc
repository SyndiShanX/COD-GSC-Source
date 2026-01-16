/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_world_cleanup.gsc
***********************************************/

#include scripts\abilities\gadgets\gadget_cymbal_monkey;
#include scripts\abilities\gadgets\gadget_homunculus;
#include scripts\abilities\gadgets\gadget_tripwire;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\weapons\weaponobjects;

#namespace item_world_cleanup;

autoexec __init__system__() {
  system::register(#"item_world_cleanup", &__init__, undefined, undefined);
}

private __init__() {
  level thread _cleanup();
}

private _cleanup() {
  level flagsys::wait_till(#"item_world_reset");
  var_314770d8 = array(&function_b465b436, &function_35e11623, &function_b7c5f376, &function_6ef5c287, &function_ada16428);

  while(true) {
    if(isDefined(level.deathcircle)) {
      foreach(func in var_314770d8) {
        util::wait_network_frame(1);
        [
          [func]
        ](level.deathcircle, level.deathcircles[level.deathcircleindex - 1]);
      }
    }

    wait 1;
  }
}

private function_b465b436(deathcircle, var_898879a6) {
  if(!isDefined(level.var_ace9fb52)) {
    return;
  }

  deathstashes = arraycopy(level.var_ace9fb52);

  foreach(deathstash in deathstashes) {
    if(!isDefined(deathstash)) {
      continue;
    }

    if(function_3703bc36(deathstash, var_898879a6, 1)) {
      deathstash delete();
      waitframe(1);
    }
  }

  arrayremovevalue(level.var_ace9fb52, undefined, 0);
}

private function_35e11623(deathcircle, var_898879a6) {
  players = getplayers();
  excludelist = [#"eq_acid_bomb": 1, #"eq_cluster_semtex_grenade": 1, #"eq_molotov": 1, #"eq_slow_grenade": 1, #"eq_swat_grenade": 1, #"eq_wraith_fire": 1, #"frag_grenade": 1, #"willy_pete": 1];

  foreach(player in players) {
    if(!isplayer(player)) {
      continue;
    }

    if(!isarray(player.weaponobjectwatcherarray)) {
      continue;
    }

    foreach(watcherarray in player.weaponobjectwatcherarray) {
      if(!isDefined(watcherarray) || !isarray(watcherarray.objectarray)) {
        continue;
      }

      foreach(object in watcherarray.objectarray) {
        if(function_3703bc36(object, deathcircle)) {
          if(isDefined(object.weapon)) {
            weapon = object.weapon;

            if(isDefined(excludelist[weapon.name])) {
              continue;
            }

            if(weapon.name == #"hatchet" || weapon.name == #"tomahawk_t8") {
              velocity = object getvelocity();

              if(velocity[0] > 0 || velocity[1] > 0 || velocity[2]) {
                continue;
              }
            }

            watcherarray thread weaponobjects::waitanddetonate(object, 0);
          }

          if(isDefined(object)) {
            object kill();

            if(isDefined(object)) {
              object delete();
            }
          }
        }
      }

      arrayremovevalue(watcherarray.objectarray, undefined, 0);
    }

    waitframe(1);
  }

  var_a5a016fc = [];

  foreach(tripwire in level.tripwires) {
    if(function_3703bc36(tripwire, deathcircle)) {
      var_a5a016fc[var_a5a016fc.size] = tripwire;
    }
  }

  for(index = 0; index < var_a5a016fc.size; index++) {
    var_a5a016fc[index] gadget_tripwire::function_9e546fb3();
  }

  var_90afc439 = [];

  foreach(monkey in level.var_7d95e1ed) {
    if(isDefined(monkey) && function_3703bc36(monkey, deathcircle)) {
      var_90afc439[var_90afc439.size] = monkey;
    }
  }

  for(index = 0; index < var_90afc439.size; index++) {
    var_90afc439[index] gadget_cymbal_monkey::function_4f90c4c2();
  }

  var_2e20127d = [];

  foreach(homunculus in level.var_2da60c10) {
    if(isDefined(homunculus) && function_3703bc36(homunculus, deathcircle)) {
      var_2e20127d[var_2e20127d.size] = homunculus;
    }
  }

  for(index = 0; index < var_2e20127d.size; index++) {
    var_2e20127d[index] gadget_homunculus::function_7bfc867f();
  }
}

private function_b7c5f376(deathcircle, var_898879a6) {
  if(!isDefined(level.item_spawn_drops)) {
    return;
  }

  itemspawndrops = arraycopy(level.item_spawn_drops);

  foreach(dropitem in itemspawndrops) {
    if(!isDefined(dropitem)) {
      continue;
    }

    if(isDefined(dropitem.spawning) && dropitem.spawning) {
      continue;
    }

    supplydrop = dropitem getlinkedent();

    if(isDefined(supplydrop)) {
      parentvehicle = supplydrop getlinkedent();

      if(isDefined(parentvehicle) && isDefined(parentvehicle.var_5d0810d7) && parentvehicle.var_5d0810d7) {
        continue;
      }
    }

    if(function_3703bc36(dropitem, var_898879a6, 1)) {
      dropitem.hidetime = gettime();
      item_world::function_a54d07e6(dropitem, undefined);
      dropitem delete();
      waitframe(1);
    }
  }

  arrayremovevalue(level.item_spawn_drops, undefined, 1);
  arrayremovevalue(level.var_18dc9d17, undefined, 1);
}

private function_6ef5c287(deathcircle, var_898879a6) {
  if(!isDefined(level.item_supply_drops)) {
    return;
  }

  supplydrops = arraycopy(level.item_supply_drops);

  foreach(supplydrop in supplydrops) {
    if(!isDefined(supplydrop)) {
      continue;
    }

    if(isDefined(supplydrop.supplydropveh)) {
      continue;
    }

    if(function_3703bc36(supplydrop, var_898879a6, 1)) {
      supplydrop clientfield::set("supply_drop_fx", 0);
      util::wait_network_frame(1);
      supplydrop delete();
      waitframe(1);
    }
  }

  arrayremovevalue(level.item_supply_drops, undefined, 0);
}

private function_ada16428(deathcircle, var_898879a6) {
  time = gettime();

  if(time < level.var_63e0085) {
    return;
  }

  if(!isDefined(level.var_cd8f416a) || level.var_cd8f416a.size == 0) {
    return;
  }

  level.var_63e0085 = time + 10000;
  count = 0;
  var_3624d2c5 = 10;

  deleted = 0;

    time = gettime();

  foreach(vehicle in level.var_cd8f416a) {
    if(!isDefined(vehicle)) {
      continue;
    }

    if(isvehicle(vehicle) && vehicle function_213a12e4()) {
      continue;
    }

    if(function_3703bc36(vehicle, deathcircle, 1)) {
      if(!isDefined(vehicle.var_a6b3cbdc)) {
        delay = 60000;

        if(isDefined(vehicle.var_8e382c5f)) {
          delay += 300000;
        }

        vehicle.var_a6b3cbdc = time + delay;
      }

      if(vehicle.var_a6b3cbdc > time) {
        continue;
      }

      safedelete = 1;

      foreach(player in level.var_a8077fea) {
        if(!isDefined(player) || !isalive(player)) {
          continue;
        }

        var_6287b00e = distance2dsquared(vehicle.origin, player.origin);

        if(var_6287b00e < 10000 * 10000) {
          safedelete = 0;
          break;
        }

        var_42beec1c = (deathcircle.origin[0] - player.origin[0], deathcircle.origin[1] - player.origin[1], 0);
        var_42beec1c = vectornormalize(var_42beec1c);
        var_838d27e = (vehicle.origin[0] - player.origin[0], vehicle.origin[1] - player.origin[1], 0);
        var_838d27e = vectornormalize(var_838d27e);

        if(vectordot(var_42beec1c, var_838d27e) >= 0.9396) {
          var_c64c4a1f = distance2dsquared(vehicle.origin, player.origin);
          var_f25c153c = distance2dsquared(player.origin, deathcircle.origin);

          if(var_c64c4a1f < var_f25c153c) {
            safedelete = 0;
            break;
          }
        }
      }

      if(safedelete) {

        if(getdvarint(#"hash_55e8ad2b1d030870", 0)) {
          iprintlnbold("<dev string:x38>" + vehicle.scriptvehicletype + "<dev string:x45>" + vehicle.origin);
        }

        deleted++;

          vehicle delete();
      }
    }

    count++;

    if(count % var_3624d2c5 == 0) {
      util::wait_network_frame(1);
    }
  }

  arrayremovevalue(level.var_cd8f416a, undefined, 0);

  if(getdvarint(#"hash_55e8ad2b1d030870", 0) && deleted > 0) {
    iprintlnbold("<dev string:x4d>" + level.var_cd8f416a.size + "<dev string:x5f>" + deleted);
  }

}

private function_213a12e4() {
  b_occupied = 0;

  for(i = 0; i < 4; i++) {
    if(self function_dcef0ba1(i)) {
      if(self isvehicleseatoccupied(i)) {
        b_occupied = 1;
        break;
      }

      continue;
    }

    break;
  }

  return b_occupied;
}

private function_3703bc36(entity, deathcircle, var_7e2f7f1f = 0) {
  if(!isDefined(entity) || !isDefined(deathcircle) || !isfloat(deathcircle.radius)) {
    return false;
  }

  var_be38b475 = var_7e2f7f1f ? 5000 : 0;
  return distance2dsquared(entity.origin, deathcircle.origin) >= (deathcircle.radius + var_be38b475) * (deathcircle.radius + var_be38b475);
}