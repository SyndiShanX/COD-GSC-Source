/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\oow.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\map;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;

#namespace oob;

autoexec __init__system__() {
  system::register(#"out_of_world", &__init__, undefined, undefined);
}

__init__() {
  level.oow = {
    #height_min: -2147483647, 
    #height_max: 2147483647
  };
  callback::on_game_playing(&on_game_playing);
}

on_game_playing() {
  mapbundle = map::get_script_bundle();

  if(isDefined(mapbundle)) {
    if(!isDefined(mapbundle.var_aa91547b)) {
      mapbundle.var_aa91547b = 0;
    }

    if(!isDefined(mapbundle.var_eac026ad)) {
      mapbundle.var_eac026ad = 0;
    }

    if(mapbundle.var_aa91547b != 0 || mapbundle.var_eac026ad != 0) {
      level.oow.height_min = isDefined(mapbundle.var_aa91547b) ? mapbundle.var_aa91547b : 0;
      level.oow.height_max = isDefined(mapbundle.var_eac026ad) ? mapbundle.var_eac026ad : 0;
      assert(level.oow.height_min <= level.oow.height_max);

      if(!(level.oow.height_min <= level.oow.height_max)) {
        return;
      }
    }
  }

  level thread function_e8f5803d();
}

function_e8f5803d() {
  while(true) {
    wait 5;

    foreach(team, _ in level.teams) {
      foreach(player in level.aliveplayers[team]) {
        if(!isDefined(player)) {
          continue;
        }

        if(player function_eb7eb3d4()) {
          kill_entity(player);
        }
      }
    }
  }
}

function_eb7eb3d4() {
  if(!isDefined(self)) {
    return false;
  }

  if(self isinmovemode("<dev string:x38>", "<dev string:x3e>")) {
    return false;
  }

  height = self.origin[2];

  if(level.oow.height_min > height || level.oow.height_max < height) {
    return true;
  }

  return false;
}

kill_entity(entity) {
  if(isplayer(entity) && entity isinvehicle()) {
    vehicle = entity getvehicleoccupied();
    occupants = vehicle getvehoccupants();

    foreach(occupant in occupants) {
      occupant unlink();
    }

    if(!(isDefined(vehicle.allowdeath) && !vehicle.allowdeath)) {
      vehicle dodamage(vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
    }
  }

  entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192 | 16384);

  if(isplayer(entity)) {
    entity suicide();
  }
}