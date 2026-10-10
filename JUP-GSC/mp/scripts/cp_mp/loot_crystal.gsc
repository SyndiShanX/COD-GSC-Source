/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\loot_crystal.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace loot_crystal;

function function_f009d47735dc7adb() {
  var_4af01a2d989e9f6f = level.gamemodebundle.var_4af01a2d989e9f6f;

  if(!isDefined(var_4af01a2d989e9f6f)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  s_bundle = getscriptbundle("lootcrystal:" + var_4af01a2d989e9f6f);
  level.var_4af01a2d989e9f6f = s_bundle;

  if(istrue(level.var_4af01a2d989e9f6f.forcetrailfx)) {
    assertex(isDefined(level.var_4af01a2d989e9f6f.var_2e0dc21e3310887f), "<dev string:x43>");
    level._effect["vfx_loot_crystal_trail"] = loadfx(level.var_4af01a2d989e9f6f.var_2e0dc21e3310887f);
  }

  scripts\cp_mp\content_manager::register_script("loot_crystal", &function_a60bb9caaac38e4e);
  level thread function_11d90b6aad7cc54f();
  scriptable_addnotifycallback("loot_crystal_destroyed", &loot_crystal_destroyed);
  callback::add("ob_content_process_create_script", &function_a62a277f18e23661);
}

function function_11d90b6aad7cc54f() {
  level endon("game_ended");
  waittillframeend();
  mapdestinations = getStructArray("content_destination", "variantname");

  if(isDefined(mapdestinations) && mapdestinations.size > 0) {
    foreach(destination in mapdestinations) {
      level thread function_fd67fc9069339eb0(destination);
    }
  }

  wait 1;

  if(is_equal(level.gametype, "zm_rb")) {
    function_a4c9c7827c00cf5();
  }
}

function function_fd67fc9069339eb0(destination) {
  if(istrue(level.var_4af01a2d989e9f6f.var_89e2af74eb7cf125) && isDefined(level.var_8241e0d86017df29)) {
    var_a4dee53b875bb846 = level.var_4af01a2d989e9f6f.var_e656a6b6a513b25d / 100;
    var_2665f3e21251620b = level.var_4af01a2d989e9f6f.var_6553b34b13330328 / 100;
    var_6c7b9c59a38ff415 = level.var_4af01a2d989e9f6f.var_a08d3d8f5639f6f6 / 100;
    var_6b28aa27cff8bf26 = level.var_4af01a2d989e9f6f.var_d1d73d2524d6bc6d / 100;
    var_af05cdbea35d46c = [];
    var_46b5992c2733accd = [];
    var_41464293eca8efd7 = [];
    var_6b94404ff55d952c = [];
    var_142e262ef4250cdd = [];

    foreach(location in destination.locations) {
      loot_crystal = location.instances["loot_crystal"];

      if(isDefined(loot_crystal)) {
        foreach(instance in loot_crystal.versions) {
          difficulty = [[level.var_8241e0d86017df29]](instance.origin);

          switch (difficulty) {
            case #"hash_7bb2cd766703d463":
              var_af05cdbea35d46c = array_add(var_af05cdbea35d46c, instance);
              break;
            case #"hash_af83e47edfa8900a":
              var_46b5992c2733accd = array_add(var_46b5992c2733accd, instance);
              break;
            case #"hash_5343b465e56ec9a4":
              var_41464293eca8efd7 = array_add(var_41464293eca8efd7, instance);
              break;
            case #"hash_651f76c0ad6741ec":
              var_6b94404ff55d952c = array_add(var_6b94404ff55d952c, instance);
              break;
            case #"hash_a1e09f51896088fb":
              var_142e262ef4250cdd = array_add(var_142e262ef4250cdd, instance);
              break;
          }
        }

        green_count = 0;
        yellow_count = 0;
        orange_count = 0;
        red_count = 0;
        var_f413f108e237053b = var_af05cdbea35d46c.size * var_a4dee53b875bb846;
        var_263a1961483d1c6c = var_46b5992c2733accd.size * var_2665f3e21251620b;
        var_59b0d07e8399e9a2 = var_41464293eca8efd7.size * var_6c7b9c59a38ff415;
        var_11fd29abbcd121fb = var_6b94404ff55d952c.size * var_6b28aa27cff8bf26;
        var_af05cdbea35d46c = array_randomize(var_af05cdbea35d46c);
        var_46b5992c2733accd = array_randomize(var_46b5992c2733accd);
        var_41464293eca8efd7 = array_randomize(var_41464293eca8efd7);
        var_6b94404ff55d952c = array_randomize(var_6b94404ff55d952c);

        foreach(instance in var_af05cdbea35d46c) {
          if(green_count < var_f413f108e237053b) {
            scripts\cp_mp\content_manager::spawn_instance(instance);
            green_count++;
          }
        }

        foreach(instance in var_46b5992c2733accd) {
          if(yellow_count < var_263a1961483d1c6c) {
            scripts\cp_mp\content_manager::spawn_instance(instance);
            yellow_count++;
          }
        }

        foreach(instance in var_41464293eca8efd7) {
          if(orange_count < var_59b0d07e8399e9a2) {
            scripts\cp_mp\content_manager::spawn_instance(instance);
            orange_count++;
          }
        }

        foreach(instance in var_6b94404ff55d952c) {
          if(red_count < var_11fd29abbcd121fb) {
            scripts\cp_mp\content_manager::spawn_instance(instance);
            red_count++;
          }
        }

        foreach(instance in var_142e262ef4250cdd) {
          scripts\cp_mp\content_manager::spawn_instance(instance);
        }

        level.var_4af01a2d989e9f6f.green_count = green_count;
        level.var_4af01a2d989e9f6f.yellow_count = yellow_count;
        level.var_4af01a2d989e9f6f.orange_count = orange_count;
        level.var_4af01a2d989e9f6f.red_count = red_count;
      }
    }

    return;
  }

  foreach(location in destination.locations) {
    loot_crystal = location.instances["loot_crystal"];

    if(isDefined(loot_crystal)) {
      foreach(instance in loot_crystal.versions) {
        scripts\cp_mp\content_manager::spawn_instance(instance);
      }
    }
  }
}

function function_a60bb9caaac38e4e(struct) {
  assert(isstruct(struct), "<dev string:x61>");

  if(isDefined(struct.contentgroups)) {
    spawn_points = struct.contentgroups["loot_crystal_spawn"];
  } else {
    spawn_points = getStructArray(struct.targetname, "target");
  }

  spawn_points = array_randomize(spawn_points);

  if(istrue(level.var_4af01a2d989e9f6f.var_89e2af74eb7cf125) && isDefined(level.var_8241e0d86017df29)) {
    spawnpointsgreen = level.var_4af01a2d989e9f6f.var_4819e64b57d10e5b / 100;
    spawnpointsyellow = level.var_4af01a2d989e9f6f.var_fb1f51496c10895c / 100;
    spawnpointsorange = level.var_4af01a2d989e9f6f.var_305ebee8191eb016 / 100;
    spawnpointsred = level.var_4af01a2d989e9f6f.var_818038caf4aeab2b / 100;
    difficulty = [[level.var_8241e0d86017df29]](struct.origin);
    totalspawnpoints = spawn_points.size;

    switch (difficulty) {
      case #"hash_7bb2cd766703d463":
        totalspawnpoints *= spawnpointsgreen;
        break;
      case #"hash_af83e47edfa8900a":
        totalspawnpoints *= spawnpointsyellow;
        break;
      case #"hash_5343b465e56ec9a4":
        totalspawnpoints *= spawnpointsorange;
        break;
      case #"hash_651f76c0ad6741ec":
        totalspawnpoints *= spawnpointsred;
        break;
      case #"hash_a1e09f51896088fb":
        totalspawnpoints = spawn_points.size;
        break;
    }

    for(count = 0; count < totalspawnpoints; count++) {
      point = spawn_points[count];
      point function_e87afa054556fca(point);
    }

    return;
  }

  foreach(point in spawn_points) {
    point function_e87afa054556fca(point);
  }
}

function function_e87afa054556fca(point) {
  randomindex = randomintrange(0, level.var_4af01a2d989e9f6f.var_63a804e036bfaf8f.size);
  scriptablename = level.var_4af01a2d989e9f6f.var_63a804e036bfaf8f[randomindex];
  var_2f49151159f060ba = spawnscriptable(scriptablename.lootcrystal, point.origin, point.angles);
  level.var_2161a5a5ecb28ea3 = array_add_safe(level.var_2161a5a5ecb28ea3, var_2f49151159f060ba);
}

function function_a4c9c7827c00cf5() {
  if(isDefined(level.var_2161a5a5ecb28ea3)) {
    var_2c796eac8075783b = array_randomize(level.var_2161a5a5ecb28ea3);

    for(i = 0; i < var_2c796eac8075783b.size - 2; i++) {
      loot_crystal = var_2c796eac8075783b[i];

      if(isDefined(loot_crystal)) {
        loot_crystal.var_f6f86c3af9ca88a0 = 1;
        loot_crystal setscriptablepartstate("loot_crystal", "dead");
        loot_crystal.var_f6f86c3af9ca88a0 = undefined;
      }
    }

    callback::add("on_round_end", &function_11817d38f58bbb);

    function_4a792a9a49c9da56();
  }
}

function function_1be1c2a4c44b823c() {
  self endon("death");
  waitframe();
  var_f3b3c6de643ff4ad = level.var_4af01a2d989e9f6f.var_1def69d4074b4408;
  n_round = namespace_53fc9ddbb516e6e1::function_560b2e700ce084a2(self.origin);

  if(n_round > 0 && n_round < 15) {
    var_f3b3c6de643ff4ad = level.var_4af01a2d989e9f6f.var_1def69d4074b4408;
  } else if(n_round >= 15 && n_round < 35) {
    var_f3b3c6de643ff4ad = level.var_4af01a2d989e9f6f.var_898998ee991b93d5;
  } else if(n_round >= 35 && n_round < 55) {
    var_f3b3c6de643ff4ad = level.var_4af01a2d989e9f6f.var_88ed1b1224856ddf;
  } else if(n_round >= 55) {
    var_f3b3c6de643ff4ad = level.var_4af01a2d989e9f6f.var_3443cad32959c5b8;
  }

  itemsspawned = level scripts\cp_mp\loot\common_item::function_cd45408bd44fab07(var_f3b3c6de643ff4ad, 1, self.origin);

  if(istrue(level.var_4af01a2d989e9f6f.forcetrailfx)) {
    foreach(item in itemsspawned) {
      item.var_1c9b1e35f32a7097 = 1;
    }
  }
}

function function_a120a3b57a6087c2(item, originpos) {
  itemlauncher = spawn("script_model", originpos);
  itemlauncher setModel("tag_origin");
  playFXOnTag(getfx("vfx_loot_crystal_trail"), itemlauncher, "tag_origin");
  dirpos = item.origin - originpos;
  itemlauncher movegravity(dirpos, 1);
  wait 1;
  itemlauncher delete();
}

function loot_crystal_destroyed(instance, note, param, var_535d9c3fdddab5a9) {
  if(!istrue(instance.var_f6f86c3af9ca88a0)) {
    instance thread function_1be1c2a4c44b823c();
  }

  sparams = spawnStruct();
  sparams.instance = instance;
  sparams.note = note;
  sparams.param = param;
  sparams.var_535d9c3fdddab5a9 = var_535d9c3fdddab5a9;
  callback::callback("loot_crystal_destroyed", sparams);
}

function function_11817d38f58bbb(params) {
  if(isDefined(level.var_2161a5a5ecb28ea3)) {
    var_260d30366b6c35dc = 0;
    var_e7cc345429d93ae3 = [];

    foreach(crystal in level.var_2161a5a5ecb28ea3) {
      if(isDefined(crystal) && crystal getscriptablepartstate("loot_crystal") == "healthy") {
        var_260d30366b6c35dc++;
        continue;
      }

      var_e7cc345429d93ae3 = array_add(var_e7cc345429d93ae3, crystal);
    }

    var_eecabbec50e06c39 = min(10, level.var_2161a5a5ecb28ea3.size);
    var_e098da9ac92f01ff = min(var_eecabbec50e06c39 - var_260d30366b6c35dc, 2);

    if(var_e098da9ac92f01ff > 0) {
      if(var_e098da9ac92f01ff > var_e7cc345429d93ae3.size) {
        foreach(crystal in var_e7cc345429d93ae3) {
          if(isDefined(crystal)) {
            crystal setscriptablepartstate("loot_crystal", "healthy");
          }
        }

        return;
      }

      var_e7cc345429d93ae3 = array_randomize(var_e7cc345429d93ae3);

      for(i = 0; i < var_e098da9ac92f01ff; i++) {
        var_e7cc345429d93ae3[i] setscriptablepartstate("loot_crystal", "healthy");
      }
    }
  }
}

function function_a62a277f18e23661(sparams) {
  if(getdvarint(@ "hash_3f9da19597f5e1ba", 0)) {
    return;
  }

  if(istrue(level.var_4af01a2d989e9f6f.var_89e2af74eb7cf125) && isDefined(level.var_8241e0d86017df29)) {
    var_a4dee53b875bb846 = level.var_4af01a2d989e9f6f.var_e656a6b6a513b25d / 100;
    var_2665f3e21251620b = level.var_4af01a2d989e9f6f.var_6553b34b13330328 / 100;
    var_6c7b9c59a38ff415 = level.var_4af01a2d989e9f6f.var_a08d3d8f5639f6f6 / 100;
    var_6b28aa27cff8bf26 = level.var_4af01a2d989e9f6f.var_d1d73d2524d6bc6d / 100;
    var_af05cdbea35d46c = [];
    var_46b5992c2733accd = [];
    var_41464293eca8efd7 = [];
    var_6b94404ff55d952c = [];
    var_142e262ef4250cdd = [];
    var_b139ae25c4db8bbe = [];
    var_cfa15b0adac0f8bd = getStructArray("content_instance", "variantname");

    foreach(struct in var_cfa15b0adac0f8bd) {
      if(isDefined(struct.content_script_name) && struct.content_script_name == "loot_crystal") {
        var_b139ae25c4db8bbe = array_add(var_b139ae25c4db8bbe, struct);
      }
    }

    foreach(instance in var_b139ae25c4db8bbe) {
      difficulty = [[level.var_8241e0d86017df29]](instance.origin);

      switch (difficulty) {
        case #"hash_7bb2cd766703d463":
          var_af05cdbea35d46c = array_add(var_af05cdbea35d46c, instance);
          break;
        case #"hash_af83e47edfa8900a":
          var_46b5992c2733accd = array_add(var_46b5992c2733accd, instance);
          break;
        case #"hash_5343b465e56ec9a4":
          var_41464293eca8efd7 = array_add(var_41464293eca8efd7, instance);
          break;
        case #"hash_651f76c0ad6741ec":
          var_6b94404ff55d952c = array_add(var_6b94404ff55d952c, instance);
          break;
        case #"hash_a1e09f51896088fb":
          var_142e262ef4250cdd = array_add(var_142e262ef4250cdd, instance);
          break;
      }
    }

    green_count = 0;
    yellow_count = 0;
    orange_count = 0;
    red_count = 0;
    var_f413f108e237053b = var_af05cdbea35d46c.size * var_a4dee53b875bb846;
    var_263a1961483d1c6c = var_46b5992c2733accd.size * var_2665f3e21251620b;
    var_59b0d07e8399e9a2 = var_41464293eca8efd7.size * var_6c7b9c59a38ff415;
    var_11fd29abbcd121fb = var_6b94404ff55d952c.size * var_6b28aa27cff8bf26;
    var_af05cdbea35d46c = array_randomize(var_af05cdbea35d46c);
    var_46b5992c2733accd = array_randomize(var_46b5992c2733accd);
    var_41464293eca8efd7 = array_randomize(var_41464293eca8efd7);
    var_6b94404ff55d952c = array_randomize(var_6b94404ff55d952c);

    if(isDefined(level.var_c383b967aa7e551b)) {
      var_af05cdbea35d46c = [[level.var_c383b967aa7e551b]]("green_crystal", var_af05cdbea35d46c);
    }

    foreach(instance in var_af05cdbea35d46c) {
      if(green_count < var_f413f108e237053b) {
        function_a60bb9caaac38e4e(instance);
        green_count++;
      }
    }

    if(isDefined(level.var_c383b967aa7e551b)) {
      var_46b5992c2733accd = [[level.var_c383b967aa7e551b]]("yellow_crystal", var_46b5992c2733accd);
    }

    foreach(instance in var_46b5992c2733accd) {
      if(yellow_count < var_263a1961483d1c6c) {
        function_a60bb9caaac38e4e(instance);
        yellow_count++;
      }
    }

    if(isDefined(level.var_c383b967aa7e551b)) {
      var_41464293eca8efd7 = [[level.var_c383b967aa7e551b]]("orange_crystal", var_41464293eca8efd7);
    }

    foreach(instance in var_41464293eca8efd7) {
      if(orange_count < var_59b0d07e8399e9a2) {
        function_a60bb9caaac38e4e(instance);
        orange_count++;
      }
    }

    if(isDefined(level.var_c383b967aa7e551b)) {
      var_6b94404ff55d952c = [[level.var_c383b967aa7e551b]]("red_crystal", var_6b94404ff55d952c);
    }

    foreach(instance in var_6b94404ff55d952c) {
      if(red_count < var_11fd29abbcd121fb) {
        function_a60bb9caaac38e4e(instance);
        red_count++;
      }
    }

    foreach(instance in var_142e262ef4250cdd) {
      function_a60bb9caaac38e4e(instance);
    }

    level.var_4af01a2d989e9f6f.green_count = green_count;
    level.var_4af01a2d989e9f6f.yellow_count = yellow_count;
    level.var_4af01a2d989e9f6f.orange_count = orange_count;
    level.var_4af01a2d989e9f6f.red_count = red_count;
    callback::callback("ob_crystals_create_script_done");
  }
}

function function_4a792a9a49c9da56() {
  function_6e7290c8ee4f558b("<dev string:x7f>");
  function_a9a864379a098ad6("<dev string:x93>", "<dev string:xab>", &function_11817d38f58bbb, 0);
  function_fe953f000498048f();
}

# /