/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_69514c4c056c768.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#namespace namespace_3d2704b3;

function private autoexec __init__system__() {
  system::register(#"hash_280fe2667ed2d300", &preinit, undefined, undefined, #"item_supply_drop");
}

function private preinit() {
  if(!item_world_util::use_item_spawns()) {
    return;
  }

  level.var_2ead97d1 = [];
  level.var_ef5dbc90 = [];
}

function private function_2d47ee1e(var_6ed927a6, var_caba78c2, waittime, var_ef5e1b44, vehicledrop = 0, vehicletype = undefined) {
  if(is_true(vehicledrop) && !isDefined(vehicletype)) {
    return;
  }

  wait randomfloatrange(var_caba78c2, waittime);

  if(isDefined(var_6ed927a6) && !vehicledrop) {
    level callback::callback(#"hash_258e15865427fb62", var_6ed927a6);

    if(isDefined(level.var_ef5dbc90[var_6ed927a6])) {
      var_6ed927a6 = level.var_ef5dbc90[var_6ed927a6];
    }
  }

  voiceevent = !var_ef5e1b44.var_7f40d76c;
  var_ef5e1b44.var_7f40d76c = 1;
  level thread item_supply_drop::function_418e26fe(var_6ed927a6, vehicledrop, voiceevent, var_ef5e1b44.heightoffset, vehicledrop, vehicletype);
  var_ef5e1b44.heightoffset += 600;
}

function function_f0297225(var_2ab9d3bd, replacementcount, var_3afaa57b) {
  if(!ishash(var_2ab9d3bd) || !isint(replacementcount) || !isint(var_3afaa57b)) {
    assert(0);
    return;
  }

  if(var_3afaa57b <= 0) {
    assert(0);
    return;
  }

  if(!isDefined(level.var_2ead97d1[var_3afaa57b])) {
    level.var_2ead97d1[var_3afaa57b] = [];
  }

  var_37d0690b = level.var_2ead97d1[var_3afaa57b].size;
  level.var_2ead97d1[var_3afaa57b][var_37d0690b] = {
    #replacement: var_2ab9d3bd, #count: replacementcount
  };
}

function function_d0178153(var_2ab9d3bd) {
  level.var_ef5dbc90[var_2ab9d3bd] = # "t9_supply_drop_stash_parent";
}

function start(supplydrops = 1, minwaittime = 20, var_fe6b2eab = 20) {
  if(isint(supplydrops) && supplydrops < 1) {
    return;
  }

  level flag::wait_till(#"hash_405e46788e83af41");

  if(isarray(minwaittime)) {
    foreach(key, value in minwaittime) {
      minwaittime[key] *= level.deathcircle.timescale;
    }
  } else {
    minwaittime *= level.deathcircle.timescale;
  }

  if(isarray(var_fe6b2eab)) {
    foreach(key, value in var_fe6b2eab) {
      var_fe6b2eab[key] *= level.deathcircle.timescale;
    }
  } else {
    var_fe6b2eab /= level.deathcircle.timescale;
  }

  var_b2003e21 = 0;

  if(!isarray(supplydrops)) {
    var_b2003e21 = supplydrops;
    supplydrops = [];

    for(index = 0; index < var_b2003e21; index++) {
      supplydrops[index] = 1;
    }
  } else {
    for(index = 0; index < supplydrops.size; index++) {
      var_b2003e21 += supplydrops[index];
    }
  }

  var_7003bde7 = [];
  var_68f65b5a = getarraykeys(level.var_2ead97d1);

  for(index = var_68f65b5a.size - 1; index >= 0; index--) {
    var_3afaa57b = var_68f65b5a[index];
    var_64f52ca3 = [];

    for(var_77c44f00 = 0; var_77c44f00 < var_3afaa57b; var_77c44f00++) {
      var_64f52ca3[var_64f52ca3.size] = var_77c44f00;
    }

    for(var_a6872bd0 = 0; var_a6872bd0 < var_64f52ca3.size; var_a6872bd0++) {
      randindex = randomint(var_64f52ca3.size);
      tempid = var_64f52ca3[var_a6872bd0];
      var_64f52ca3[var_a6872bd0] = var_64f52ca3[randindex];
      var_64f52ca3[randindex] = tempid;
    }

    replacements = level.var_2ead97d1[var_3afaa57b];

    for(var_4d83f68a = 0; var_4d83f68a < replacements.size; var_4d83f68a++) {
      randindex = randomint(replacements.size);
      tempid = replacements[var_4d83f68a];
      replacements[var_4d83f68a] = replacements[randindex];
      replacements[randindex] = tempid;
    }

    var_b7d663a9 = 0;

    foreach(replacement in replacements) {
      while(var_b7d663a9 < var_64f52ca3.size && replacement.count > 0) {
        var_efecc884 = var_64f52ca3[var_b7d663a9];

        if(isDefined(var_7003bde7[var_efecc884])) {} else {
          var_7003bde7[var_efecc884] = replacement.replacement;
          replacement.count--;
        }

        var_b7d663a9++;
      }
    }
  }

  var_77c44f00 = 0;

  for(var_f2cf27c4 = 0; true; var_f2cf27c4++) {
    if(!isDefined(level.deathcircleindex)) {
      wait 1;
      continue;
    }

    deathcircle = level.deathcircles[level.deathcircleindex];
    var_caba78c2 = minwaittime;

    if(isarray(minwaittime)) {
      var_caba78c2 = minwaittime[int(min(var_77c44f00, minwaittime.size - 1))];
    }

    var_205efcd5 = var_fe6b2eab;

    if(isarray(var_fe6b2eab)) {
      var_205efcd5 = var_fe6b2eab[int(min(var_77c44f00, var_fe6b2eab.size - 1))];
    }

    waitsec = deathcircle.waitsec;
    scalesec = deathcircle.scalesec;
    circletime = waitsec + scalesec;
    waittime = circletime - var_205efcd5;
    var_ef5e1b44 = spawnStruct();
    var_ef5e1b44.var_7f40d76c = 0;
    var_ef5e1b44.heightoffset = 0;

    if(waittime > var_caba78c2) {
      var_972b892d = supplydrops[var_f2cf27c4];

      if(var_972b892d > 0) {
        var_9356dcab = randomint(var_972b892d);

        for(index = 0; index < var_972b892d; index++) {
          var_6ed927a6 = undefined;

          if(index == var_9356dcab) {
            var_6ed927a6 = var_7003bde7[var_f2cf27c4];
          }

          level thread function_2d47ee1e(var_6ed927a6, var_caba78c2, waittime, var_ef5e1b44);
          var_77c44f00++;
        }
      }
    }

    if(var_77c44f00 >= var_b2003e21) {
      return;
    }

    level waittill(#"hash_1ff3496c9049969");
  }
}

function start_flare(maxflares = undefined, var_47d17dcb = 0) {
  level flag::wait_till(#"hash_405e46788e83af41");
  var_3d3a70a8 = 0;

  while(true) {
    if(!isDefined(level.deathcircleindex)) {
      return;
    }

    level thread item_supply_drop::function_7d4a448f(var_47d17dcb);
    var_3d3a70a8++;

    if(isDefined(maxflares) && var_3d3a70a8 > maxflares) {
      return;
    }

    level waittill(#"hash_1ff3496c9049969");
  }
}

function start_vehicle(vehicletype, supplydrops = 1, minwaittime = 20, var_fe6b2eab = 20) {
  if(!isDefined(vehicletype)) {
    return;
  }

  if(isint(supplydrops) && supplydrops < 1) {
    return;
  }

  level flag::wait_till(#"hash_405e46788e83af41");

  if(isarray(minwaittime)) {
    foreach(key, value in minwaittime) {
      minwaittime[key] *= level.deathcircle.timescale;
    }
  } else {
    minwaittime *= level.deathcircle.timescale;
  }

  if(isarray(var_fe6b2eab)) {
    foreach(key, value in var_fe6b2eab) {
      var_fe6b2eab[key] *= level.deathcircle.timescale;
    }
  } else {
    var_fe6b2eab /= level.deathcircle.timescale;
  }

  var_b2003e21 = 0;

  if(!isarray(supplydrops)) {
    var_b2003e21 = supplydrops;
    supplydrops = [];

    for(index = 0; index < var_b2003e21; index++) {
      supplydrops[index] = 1;
    }
  } else {
    for(index = 0; index < supplydrops.size; index++) {
      var_b2003e21 += supplydrops[index];
    }
  }

  var_77c44f00 = 0;

  for(var_f2cf27c4 = 0; true; var_f2cf27c4++) {
    if(!isDefined(level.deathcircleindex)) {
      wait 1;
      continue;
    }

    deathcircle = level.deathcircles[level.deathcircleindex];
    var_caba78c2 = minwaittime;

    if(isarray(minwaittime)) {
      var_caba78c2 = minwaittime[int(min(var_77c44f00, minwaittime.size - 1))];
    }

    var_205efcd5 = var_fe6b2eab;

    if(isarray(var_fe6b2eab)) {
      var_205efcd5 = var_fe6b2eab[int(min(var_77c44f00, var_fe6b2eab.size - 1))];
    }

    waitsec = deathcircle.waitsec;
    scalesec = deathcircle.scalesec;
    circletime = waitsec + scalesec;
    waittime = circletime - var_205efcd5;
    var_ef5e1b44 = spawnStruct();
    var_ef5e1b44.var_7f40d76c = 1;
    var_ef5e1b44.heightoffset = 0;
    var_30d3ad8b = vehicletype;

    if(isarray(vehicletype)) {
      var_30d3ad8b = vehicletype[randomint(vehicletype.size)];
    }

    if(waittime > var_caba78c2) {
      var_972b892d = supplydrops[var_f2cf27c4];

      for(index = 0; index < var_972b892d; index++) {
        level thread function_2d47ee1e(undefined, var_caba78c2, waittime, var_ef5e1b44, 1, var_30d3ad8b);
        var_77c44f00++;
      }
    }

    if(var_77c44f00 >= var_b2003e21) {
      return;
    }

    level waittill(#"hash_1ff3496c9049969");
  }
}

function function_7fc18ad5(var_2c229170, drops = 1, var_e72444ee = 30, minwaittime = 30, maxwaittime = 60) {
  var_b77770ba = 0;
  wait var_e72444ee;

  while(var_b77770ba < drops) {
    droppoint = undefined;

    if(isDefined(level.var_b7821ed9)) {
      droppoint = [[level.var_b7821ed9]](var_b77770ba);
    }

    if(!isDefined(droppoint)) {
      if(territory::function_c0de0601()) {
        droppoint = territory::function_b3791221();
      } else {
        droppoint = item_supply_drop::function_186f5ca3();
      }
    }

    if(isDefined(droppoint)) {
      item_supply_drop::drop_supply_drop(droppoint, 1, 0, undefined, var_2c229170);
    }

    wait randomfloatrange(minwaittime, maxwaittime);
    var_b77770ba++;
  }
}

function function_add63876(vehicletypes, var_4b43f3d = 1, var_e72444ee = 30, minwaittime = 30, maxwaittime = 60, var_6b662968 = 1, var_aeb310db = 0, var_a1f975d8 = undefined, var_69cea650 = undefined) {
  if(!isDefined(vehicletypes)) {
    return;
  }

  if(isint(var_4b43f3d) && var_4b43f3d < 1) {
    return;
  }

  if(!isDefined(level.var_3f771530)) {
    level.var_3f771530 = [];
  }

  var_b77770ba = 0;
  wait var_e72444ee;

  if(isDefined(var_a1f975d8)) {
    var_9fb224d1 = array::randomize(var_a1f975d8);
    var_d9c4a78c = 0;
  }

  while(var_b77770ba < var_4b43f3d) {
    var_41666f53 = vehicletypes;

    if(isarray(vehicletypes)) {
      var_41666f53 = array::random(vehicletypes);
    }

    if(isDefined(var_9fb224d1) && var_9fb224d1.size > 0) {
      if(isint(var_69cea650)) {
        var_aff86dc2 = sqr(var_69cea650);
        var_dedb993c = 0;
        droppoint = var_9fb224d1[var_d9c4a78c];
        currentindex = var_d9c4a78c;

        do {
          var_d9c4a78c = (var_d9c4a78c + 1) % var_9fb224d1.size;
          var_c4e86af5 = var_9fb224d1[var_d9c4a78c];

          for(vehicleindex = 0; vehicleindex < level.var_3f771530.size; vehicleindex++) {
            vehicle = level.var_3f771530[vehicleindex];

            if(!isalive(vehicle)) {
              continue;
            }

            if(distance2dsquared(vehicle.origin, var_c4e86af5.origin) <= var_aff86dc2) {
              continue;
            }

            droppoint = var_c4e86af5;
            var_dedb993c = 1;
            break;
          }

          if(level.var_3f771530.size == 0) {
            var_dedb993c = 1;
          }
        }
        while(var_d9c4a78c != currentindex && !var_dedb993c);
      } else {
        droppoint = var_9fb224d1[var_d9c4a78c];
        var_d9c4a78c = (var_d9c4a78c + 1) % var_9fb224d1.size;
      }

      if(isstruct(droppoint)) {
        dropangles = droppoint.angles;
        droppoint = droppoint.origin;
      }
    } else if(territory::function_c0de0601()) {
      droppoint = territory::function_b3791221();
    } else {
      droppoint = item_supply_drop::function_186f5ca3();
    }

    if(isDefined(droppoint)) {
      while(level.var_3f771530.size >= var_6b662968) {
        var_b3bb5eb4 = [];

        foreach(vehicle in level.var_3f771530) {
          if(isDefined(vehicle) && vehicle.health > 0) {
            var_b3bb5eb4[var_b3bb5eb4.size] = vehicle;
          }
        }

        level.var_3f771530 = var_b3bb5eb4;
        wait 1;
      }

      var_f5c3cebd = undefined;
      spawnedvehicle = 0;

      if(isDefined(level.var_11fa5782)) {
        var_f5c3cebd = [[level.var_11fa5782]](var_41666f53, droppoint);

        if(isDefined(var_f5c3cebd)) {
          level.var_3f771530[level.var_3f771530.size] = var_f5c3cebd;
          spawnedvehicle = 1;
        }
      }

      if(!isDefined(var_f5c3cebd)) {
        item_supply_drop::drop_supply_drop(droppoint, 1, 1, var_41666f53, undefined, dropangles);
        spawnedvehicle = 1;
      }

      if(spawnedvehicle && level.var_3f771530.size < var_6b662968) {
        wait var_aeb310db;
      }
    }

    if(!isDefined(droppoint) || level.var_3f771530.size >= var_6b662968) {
      wait randomfloatrange(minwaittime, maxwaittime);
    }

    var_b77770ba++;
  }
}