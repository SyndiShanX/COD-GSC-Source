/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\spawners\procedural_spawner.gsc
******************************************************/

init_procedural_spawner() {
  scripts\cp\spawners\agent_spawner::register_spawner("procedural", ::_id_E0AC);
}

_id_E0AC(var_0) {
  var_1 = scripts\engine\utility::array_random(level.players);

  if(isDefined(var_1)) {
    var_2 = _func_02AB(var_1.origin);

    if(!isDefined(var_2)) {
      return undefined;
    }

    var_3 = undefined;

    for(var_4 = 0; var_4 < 16; var_4++) {
      var_5 = randomfloatrange(300, 800);
      var_6 = randomfloat(360);
      var_7 = var_2 + (var_5 * sin(var_6), var_5 * cos(var_6), 0);
      var_8 = _func_02AB(var_7);

      if(!isDefined(var_8)) {
        continue;
      }
      if(distance2dsquared(var_2, var_8) < 90000) {
        continue;
      }
      if(isDefined(level.check_in_playable_area_func)) {
        if(![[level.check_in_playable_area_func]](var_8)) {
          continue;
        }
      }

      if(distance2dsquared(var_2, var_8) > 250000) {
        var_3 = var_8;
        break;
      }

      var_3 = var_8;
    }

    if(!isDefined(var_3)) {
      return undefined;
    }

    var_9 = vectortoangles(var_1.origin - var_3);
    var_10 = spawnStruct();
    var_10._id_CC9D = "spawn_ground";
    var_10._id_0481 = "spawnStruct";
    var_10.origin = var_3;
    var_10.angles = var_9;
    var_11 = _id_09A4::_id_110AD(var_0, var_3, var_9, var_10);

    if(isDefined(var_11)) {
      var_11.spawn_loc = spawnStruct();
      var_11.origin = var_3;
    }

    return var_11;
  }

  return undefined;
}