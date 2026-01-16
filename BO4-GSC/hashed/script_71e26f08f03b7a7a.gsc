/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_71e26f08f03b7a7a.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_supply_drop;

#namespace namespace_3d2704b3;

autoexec __init__system__() {
  system::register(#"hash_280fe2667ed2d300", &__init__, undefined, #"item_supply_drop");
}

private __init__() {
  if(!isDefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
    return;
  }

  level.var_2ead97d1 = [];
  level.var_ef5dbc90 = [];
}

private function_2d47ee1e(var_6ed927a6, var_caba78c2, waittime, var_ef5e1b44, vehicledrop = 0, vehicletype = undefined) {
  if(isDefined(vehicledrop) && vehicledrop && !isDefined(vehicletype)) {
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

function_f0297225(var_2ab9d3bd, replacementcount, var_3afaa57b) {
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
    #replacement: var_2ab9d3bd, 
    #count: replacementcount
  };
}

function_d0178153(var_2ab9d3bd) {
  level.var_ef5dbc90[var_2ab9d3bd] = #"supply_drop_stash_parent_dlc1";
}

start(supplydrops = 1, minwaittime = 20, var_fe6b2eab = 20) {
  if(isint(supplydrops) && supplydrops < 1) {
    return;
  }

  level flagsys::wait_till(#"hash_405e46788e83af41");

  if(isarray(minwaittime)) {
    foreach(key, value in minwaittime) {
      minwaittime[key] *= level.deathcircletimescale;
    }
  } else {
    minwaittime *= level.deathcircletimescale;
  }

  if(isarray(var_fe6b2eab)) {
    foreach(key, value in var_fe6b2eab) {
      var_fe6b2eab[key] *= level.deathcircletimescale;
    }
  } else {
    var_fe6b2eab /= level.deathcircletimescale;
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
      return;
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

          if(isDefined(level.var_2089aa11) && !isDefined(var_6ed927a6) && isDefined(getgametypesetting(#"wzheavymetalheroes")) && getgametypesetting(#"wzheavymetalheroes")) {
            var_6ed927a6 = level.var_2089aa11;
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

start_flare(maxflares = undefined, var_47d17dcb = 0) {
  level flagsys::wait_till(#"hash_405e46788e83af41");
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

start_vehicle(vehicletype, supplydrops = 1, minwaittime = 20, var_fe6b2eab = 20) {
  if(!isDefined(vehicletype)) {
    return;
  }

  if(isint(supplydrops) && supplydrops < 1) {
    return;
  }

  level flagsys::wait_till(#"hash_405e46788e83af41");

  if(isarray(minwaittime)) {
    foreach(key, value in minwaittime) {
      minwaittime[key] *= level.deathcircletimescale;
    }
  } else {
    minwaittime *= level.deathcircletimescale;
  }

  if(isarray(var_fe6b2eab)) {
    foreach(key, value in var_fe6b2eab) {
      var_fe6b2eab[key] *= level.deathcircletimescale;
    }
  } else {
    var_fe6b2eab /= level.deathcircletimescale;
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
      return;
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