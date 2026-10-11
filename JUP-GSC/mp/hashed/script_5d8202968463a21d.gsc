/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5d8202968463a21d.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#namespace namespace_4c2b495b8d79cc2e;

function function_cccba3f922586417() {}

function function_da25e77be5a0ad6d() {}

function function_7a6a7504cc87e758() {
  spatialzonecontainer = function_92d6ba64263cef01();
  return spatialzonecontainer;
}

function function_99a59990b4652967(var_e0071ac2f8a77fe3) {
  assertex(isstruct(var_e0071ac2f8a77fe3), "<dev string:x1c>");
  var_e0071ac2f8a77fe3.var_9504c866f3fb1c50 = function_92d6ba64263cef01();
}

function function_63dd1279e845df5b(var_b9c79f374983c9f4, var_b4bba111dd1edca8) {
  function_99a59990b4652967(var_b9c79f374983c9f4);
  assertex(function_9a9bd30dd7bfe358(var_b4bba111dd1edca8), "<dev string:x65>");
  assertex(isstruct(var_b9c79f374983c9f4), "<dev string:x1c>");
  var_62124a4aeaeba185 = function_14ae9707b3f6e0d3(var_b4bba111dd1edca8);

  foreach(var_c3abd07869aae560 in var_62124a4aeaeba185) {
    spatialzonestruct = function_e0f46a70ffb4d87f(var_c3abd07869aae560, var_b9c79f374983c9f4);
    function_e1751681d067c1bb(var_b9c79f374983c9f4, spatialzonestruct);
  }
}

function function_d70183decd8c2e1c() {}

function function_9a9bd30dd7bfe358(var_b54df0d66c0b6f60) {
  return isDefined(var_b54df0d66c0b6f60.var_9504c866f3fb1c50);
}

function function_1888d1b2aeeda25(spatialzonecontainer, zonename) {
  var_87041f4af6cd6c98 = spatialzonecontainer.var_9504c866f3fb1c50;
  return isDefined(var_87041f4af6cd6c98.zones[zonename]);
}

function function_6733741f628baeff(spatialzonecontainer, zonename) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);
  hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
  return istrue(hasdynamicorigin);
}

function function_5bbdc39a533d9d57(spatialzonecontainer, zonename) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(function_7674e05ba210de51(spatialzonestruct)) {
    return function_480085f3edb26a96(spatialzonecontainer, zonename);
  }

  return spatialzonestruct.spheres;
}

function function_803a3ef29d1b6598(spatialzonecontainer) {
  zonenames = [];
  spatialzonestructs = function_14ae9707b3f6e0d3(spatialzonecontainer);

  foreach(spatialzonestruct in spatialzonestructs) {
    zonenames[zonenames.size] = spatialzonestruct.name;
  }

  return zonenames;
}

function function_8681471a080af440() {}

function function_51ad14107ca158fb(spatialzonecontainer, zonename, orign, radius, ignoreheight) {
  if(!function_1888d1b2aeeda25(spatialzonecontainer, zonename)) {
    addspatialzone(spatialzonecontainer, zonename);
  }

  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(function_7674e05ba210de51(spatialzonestruct)) {
    assertmsg("<dev string:xd6>" + zonename + "<dev string:xe8>" + spatialzonestruct.linkedzonename + "<dev string:xfa>" + spatialzonestruct.linkedzonename + "<dev string:x148>");
    return;
  }

  if(!function_6733741f628baeff(spatialzonecontainer, zonename) && !isDefined(orign)) {
    function_79e69463947d9e86(spatialzonecontainer, zonename, &function_d062cecc46c021f8);
  }

  newsphere = function_fafa83b3d61f29bf(spatialzonecontainer, zonename, orign, radius, ignoreheight);
  function_bda026519a101554(spatialzonestruct, newsphere);
  return newsphere;
}

function addspatialzone(spatialzonecontainer, zonename) {
  spatialzonestruct = function_7504cd850bb3a272(zonename);
  function_e1751681d067c1bb(spatialzonecontainer, spatialzonestruct);
  return spatialzonestruct;
}

function function_9a33c4470751069d(spatialzonecontainer, zonename, originfunc, originfuncparams) {
  originfunc = default_to(originfunc, &function_d062cecc46c021f8);
  originfuncparams = default_to(originfuncparams, []);
  spatialzonestruct = function_7504cd850bb3a272(zonename, originfunc, originfuncparams);
  function_e1751681d067c1bb(spatialzonecontainer, spatialzonestruct);
  return spatialzonestruct;
}

function function_c4fb45a11de2d13d(spatialzonecontainer, zonename, var_a06fb23870ee1eec, var_f22e6ba735780bf0) {
  var_f22e6ba735780bf0 = default_to(var_f22e6ba735780bf0, 1);
  var_87041f4af6cd6c98 = function_1b52014ec8720ead(spatialzonecontainer);

  if(!function_1888d1b2aeeda25(spatialzonecontainer, zonename)) {
    spatialzonestruct = addspatialzone(spatialzonecontainer, zonename);
  }

  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(!function_1888d1b2aeeda25(spatialzonecontainer, zonename)) {
    addspatialzone(spatialzonecontainer, var_a06fb23870ee1eec);
  }

  function_d4756552d03feb4b(spatialzonestruct, var_a06fb23870ee1eec);
  function_273614bdb500882a(spatialzonestruct, var_f22e6ba735780bf0);
}

function function_79e69463947d9e86(spatialzonecontainer, zonename, originfunc, originfuncparams) {
  originfuncparams = default_to(originfuncparams, []);
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);
  function_52fde51c281eeab7(spatialzonestruct, 1, originfunc, originfuncparams);
  var_52e597b8a20c31b6 = spatialzonestruct.spheres;

  foreach(spatialzonespherestruct in var_52e597b8a20c31b6) {
    dynamicorigin = function_761ac31d57f48836(spatialzonestruct);
    function_b7cc79aa88b72aa(spatialzonespherestruct, dynamicorigin);
  }
}

function function_e5bb9b7f1aadf178(spatialzonecontainer, zonename, spatialzonespherestruct) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(function_7674e05ba210de51(spatialzonestruct)) {
    assertmsg("<dev string:xd6>" + zonename + "<dev string:xe8>" + spatialzonestruct.linkedzonename + "<dev string:x151>" + spatialzonestruct.linkedzonename + "<dev string:x148>");
    return;
  }

  function_2a428fdf96745d77(spatialzonestruct, spatialzonespherestruct);
}

function function_99ea7dc018941548(spatialzonecontainer, zonename) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(function_7674e05ba210de51(spatialzonestruct)) {
    assertmsg("<dev string:xd6>" + zonename + "<dev string:xe8>" + spatialzonestruct.linkedzonename + "<dev string:x1a7>" + spatialzonestruct.linkedzonename + "<dev string:x148>");
    return;
  }

  spatialzonestruct.spheres = [];
}

function function_35da39cae76b832d(spatialzonecontainer, zonename, ignoreheight) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(function_7674e05ba210de51(spatialzonestruct)) {
    assertmsg("<dev string:xd6>" + zonename + "<dev string:xe8>" + spatialzonestruct.linkedzonename + "<dev string:x200>" + spatialzonestruct.linkedzonename + "<dev string:x148>");
    return;
  }

  var_52e597b8a20c31b6 = spatialzonestruct.spheres;

  foreach(spherestruct in var_52e597b8a20c31b6) {
    if(istrue(ignoreheight)) {
      spherestruct.shouldignoreheight = 1;
      continue;
    }

    spherestruct.shouldignoreheight = undefined;
  }
}

function function_fd482c9419cc7d94() {}

function function_b53f54c7e64f1e5b(player, spatialzonecontainer, zonename, var_af05175e4604c05c) {
  assertex(function_1888d1b2aeeda25(spatialzonecontainer, zonename), "<dev string:x25b>" + zonename + "<dev string:x265>");
  var_af05175e4604c05c = default_to(var_af05175e4604c05c, 1);
  var_e2ba8e54ae6fa092 = function_5bbdc39a533d9d57(spatialzonecontainer, zonename);

  foreach(spatialzonespherestruct in var_e2ba8e54ae6fa092) {
    sphereorigin = function_37c1f31d2434f628(spatialzonespherestruct);
    sphereradius = function_2403f7fe5d40cecc(spatialzonespherestruct) * var_af05175e4604c05c;
    shouldignoreheight = istrue(spatialzonespherestruct.shouldignoreheight);

    if(!function_cb1b89cc191e41a1(sphereorigin, sphereradius)) {
      continue;
    }

    playerwithinradius = 0;

    if(shouldignoreheight) {
      playerwithinradius = function_acb96530881571aa(player, sphereorigin, sphereradius);
    } else {
      playerwithinradius = playerwithindistance(player, sphereorigin, sphereradius);
    }

    if(playerwithinradius) {
      return true;
    }
  }

  return false;
}

function function_7ec62d1550b9897e(spatialzonecontainer, zonename, zonescaleoverride) {
  assertex(function_1888d1b2aeeda25(spatialzonecontainer, zonename), "<dev string:x25b>" + zonename + "<dev string:x2ca>");
  zonescaleoverride = default_to(zonescaleoverride, 1);
  var_e2ba8e54ae6fa092 = function_5bbdc39a533d9d57(spatialzonecontainer, zonename);
  var_aec21a5b011527dc = [];

  foreach(spatialzonespherestruct in var_e2ba8e54ae6fa092) {
    sphereorigin = function_37c1f31d2434f628(spatialzonespherestruct);
    sphereradius = function_2403f7fe5d40cecc(spatialzonespherestruct) * zonescaleoverride;
    shouldignoreheight = istrue(spatialzonespherestruct.shouldignoreheight);

    if(!function_cb1b89cc191e41a1(sphereorigin, sphereradius)) {
      continue;
    }

    if(shouldignoreheight) {
      foreach(player in level.players) {
        if(function_acb96530881571aa(player, sphereorigin, sphereradius)) {
          var_aec21a5b011527dc[var_aec21a5b011527dc.size] = player;
        }
      }

      continue;
    }

    var_c4c734be3d13cdf6 = getplayersinradius(sphereorigin, sphereradius, undefined);
    var_aec21a5b011527dc = array_combine_unique(var_aec21a5b011527dc, var_c4c734be3d13cdf6);
  }

  return var_aec21a5b011527dc;
}

function function_716a64eee61603d4(spatialzonecontainer, zonename, var_a9cb02436b6682c4, var_af754afeff6c9add, var_175b79dd6f604cac) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  if(isDefined(var_a9cb02436b6682c4) && isfunction(var_a9cb02436b6682c4)) {
    function_c95dbcaf321695bf(spatialzonestruct, var_a9cb02436b6682c4);
  }

  if(istrue(spatialzonestruct.istrackingplayers)) {
    return;
  }

  function_e2d5ed9933b02f0(spatialzonestruct, 1);

  if(istrue(var_175b79dd6f604cac)) {
    childthread function_8b2c457acbd14043(spatialzonecontainer, zonename, var_af754afeff6c9add);
    return;
  }

  thread function_8b2c457acbd14043(spatialzonecontainer, zonename, var_af754afeff6c9add);
}

function function_fca481c0e8fafd2c(groupuniquename, var_112b3319b6684d8d, var_a9cb02436b6682c4, zonename, var_8e455a7fd03e24c7) {
  if(!function_7c6ad7d6dbbe8f8d(groupuniquename)) {
    var_fddf10a2d71f933f = function_c105bef1dce7e126(groupuniquename);
    function_89a410e0520a2538(var_fddf10a2d71f933f);
    function_2dac62aa2032b9b1(groupuniquename, var_a9cb02436b6682c4);
    var_fddf10a2d71f933f thread function_772ac1165605d8d(var_112b3319b6684d8d, var_fddf10a2d71f933f, zonename, var_8e455a7fd03e24c7);
    return;
  }

  function_2dac62aa2032b9b1(groupuniquename, var_a9cb02436b6682c4);
}

function function_d829ceb32b15c66a(spatialzonecontainer, zonename) {
  spatialzonecontainer notify("stop_player_zone_watching_" + zonename);
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  foreach(player in level.players) {
    function_86db5dfb83ed493c(spatialzonestruct, player, 2);
  }

  function_e2d5ed9933b02f0(spatialzonestruct, 0);
}

function function_9ba6374badfee1d2(groupuniquename) {
  if(function_7c6ad7d6dbbe8f8d(groupuniquename)) {
    level.var_7124e21f1a70f024[groupuniquename] notify("stop_player_zone_watching_" + groupuniquename);
    level.var_7124e21f1a70f024[groupuniquename] = undefined;
  }
}

function function_2dac62aa2032b9b1(groupuniquename, var_a9cb02436b6682c4) {
  assertex(isfunction(var_a9cb02436b6682c4), "<dev string:x330>");
  var_fddf10a2d71f933f = level.var_7124e21f1a70f024[groupuniquename];

  if(isDefined(var_fddf10a2d71f933f)) {
    foreach(callbackfunc in var_fddf10a2d71f933f.var_a946cf5961339ba3) {
      if(callbackfunc == var_a9cb02436b6682c4) {
        return;
      }
    }

    var_fddf10a2d71f933f.var_a946cf5961339ba3[var_fddf10a2d71f933f.var_a946cf5961339ba3.size] = var_a9cb02436b6682c4;
    return;
  }

  assertmsg("<dev string:x37e>" + groupuniquename + "<dev string:x3c5>");
}

function function_11a6c27cf403881f(groupuniquename, var_e8fd20aceb2acf03) {
  assertex(isfunction(var_e8fd20aceb2acf03), "<dev string:x330>");
  var_fddf10a2d71f933f = level.var_7124e21f1a70f024[groupuniquename];

  if(isDefined(var_fddf10a2d71f933f)) {
    var_fddf10a2d71f933f.var_e8fd20aceb2acf03 = var_e8fd20aceb2acf03;
    return;
  }

  assertmsg("<dev string:x37e>" + groupuniquename + "<dev string:x3c5>");
}

function function_8108bfce514bab99() {}

function private function_92d6ba64263cef01() {
  var_9504c866f3fb1c50 = spawnStruct();
  var_9504c866f3fb1c50.zones = [];
  return var_9504c866f3fb1c50;
}

function function_9cb6446bcc60c0b8() {}

function private function_1b52014ec8720ead(spatialzonecontainer) {
  assertex(function_9a9bd30dd7bfe358(spatialzonecontainer), "<dev string:x65>");
  return spatialzonecontainer.var_9504c866f3fb1c50;
}

function private function_8df6169f1826404f(spatialzonecontainer, zonename) {
  var_87041f4af6cd6c98 = function_1b52014ec8720ead(spatialzonecontainer);
  assertex(isDefined(var_87041f4af6cd6c98.zones[zonename]), "<dev string:x40c>" + zonename + "<dev string:x424>");
  return var_87041f4af6cd6c98.zones[zonename];
}

function private function_14ae9707b3f6e0d3(spatialzonecontainer) {
  var_87041f4af6cd6c98 = function_1b52014ec8720ead(spatialzonecontainer);
  return var_87041f4af6cd6c98.zones;
}

function function_7a1f9e98e65eaff8() {}

function private function_e1751681d067c1bb(spatialzonecontainer, spatialzonestruct) {
  var_87041f4af6cd6c98 = function_1b52014ec8720ead(spatialzonecontainer);
  zonename = spatialzonestruct.name;

  if(function_1888d1b2aeeda25(spatialzonecontainer, zonename)) {
    assertmsg("<dev string:x44c>" + zonename + "<dev string:x46e>");
    return;
  }

  var_87041f4af6cd6c98.zones[zonename] = spatialzonestruct;
}

function private function_480085f3edb26a96(spatialzonecontainer, zonename) {
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);
  spatialzonescale = ter_op(isDefined(spatialzonestruct.var_f22e6ba735780bf0), spatialzonestruct.var_f22e6ba735780bf0, 1);

  while(function_7674e05ba210de51(spatialzonestruct)) {
    var_e5dd54916c7dd3c7 = function_5d535ab79673ef9(spatialzonecontainer, spatialzonestruct);
    var_b085b58dbe9e7778 = ter_op(isDefined(var_e5dd54916c7dd3c7.var_f22e6ba735780bf0), var_e5dd54916c7dd3c7.var_f22e6ba735780bf0, 1);

    if(isnumber(var_b085b58dbe9e7778)) {
      spatialzonescale *= var_b085b58dbe9e7778;
    }

    spatialzonestruct = var_e5dd54916c7dd3c7;
  }

  if(spatialzonescale != 1) {
    scaledspheres = [];
    spatialzonespheres = spatialzonestruct.spheres;

    foreach(zonesphere in spatialzonespheres) {
      origin = function_37c1f31d2434f628(zonesphere);
      radius = function_2403f7fe5d40cecc(zonesphere) * spatialzonescale;
      ignoreheight = istrue(zonesphere.shouldignoreheight);
      scaledspheres[scaledspheres.size] = function_fafa83b3d61f29bf(spatialzonecontainer, zonename, origin, radius, ignoreheight);
    }

    return scaledspheres;
  }

  return spatialzonestruct.spheres;
}

function private function_8b2c457acbd14043(spatialzonecontainer, zonename, var_af754afeff6c9add) {
  spatialzonecontainer endon("stop_player_zone_watching_" + zonename);
  var_af754afeff6c9add = default_to(var_af754afeff6c9add, 1);
  spatialzonestruct = function_8df6169f1826404f(spatialzonecontainer, zonename);

  while(true) {
    profilebeginevent(#"hash_86f9c9a6fb0a647e");
    var_536ac6b9e3d2178 = level.players.size;
    availableframes = max(var_af754afeff6c9add / level.framedurationseconds, 1);
    var_f7cb275e600c3881 = max(var_536ac6b9e3d2178 / availableframes, 1);
    var_fdec72ea7bdf0ed6 = 0;
    var_b9c43ea665a8cad2 = gettime() / 1000;
    var_5f307eb5b02ca2c1 = level.players;

    foreach(player in var_5f307eb5b02ca2c1) {
      if(!isPlayer(player) || !isalive(player)) {
        continue;
      }

      if(var_fdec72ea7bdf0ed6 >= var_f7cb275e600c3881) {
        profileendevent();
        var_fdec72ea7bdf0ed6 = 0;
        waitframe();
        profilebeginevent(#"hash_86f9c9a6fb0a647e");
      }

      var_8bd78a648ccdea91 = function_b53f54c7e64f1e5b(player, spatialzonecontainer, zonename);
      var_73e7a09080fc7032 = function_81cf0e4208bf4700(spatialzonestruct, player);

      if(var_8bd78a648ccdea91) {
        if(var_73e7a09080fc7032 != 0) {
          firsttimeinzone = var_73e7a09080fc7032 == 2;
          function_86db5dfb83ed493c(spatialzonestruct, player, 0);
          var_d6bfa53c531546d6 = function_e446aba84f4ffc9e(player, zonename, 1, firsttimeinzone, spatialzonestruct.var_fd58633b3f789a94);
          function_a958d8b86ac941fa(spatialzonecontainer, spatialzonestruct, var_d6bfa53c531546d6);
        }
      } else if(var_73e7a09080fc7032 == 0) {
        wasinzone = var_73e7a09080fc7032 == 0;
        function_86db5dfb83ed493c(spatialzonestruct, player, 1);
        var_d6bfa53c531546d6 = function_e446aba84f4ffc9e(player, zonename, 0, 0, spatialzonestruct.var_fd58633b3f789a94);
        function_a958d8b86ac941fa(spatialzonecontainer, spatialzonestruct, var_d6bfa53c531546d6);
      }

      var_fdec72ea7bdf0ed6++;
    }

    var_468c00b577420bbd = gettime() / 1000;
    elapsedtimeinseconds = var_468c00b577420bbd - var_b9c43ea665a8cad2;

    if(elapsedtimeinseconds < var_af754afeff6c9add) {
      profileendevent();
      remainingtimeinseconds = var_af754afeff6c9add - elapsedtimeinseconds;
      wait remainingtimeinseconds;
      profilebeginevent(#"hash_86f9c9a6fb0a647e");
    } else {
      profileendevent();
      waitframe();
      profilebeginevent(#"hash_86f9c9a6fb0a647e");
    }

    profileendevent();
  }
}

function private function_5d535ab79673ef9(spatialzonecontainer, spatialzonestruct) {
  linkedspatialzonename = spatialzonestruct.linkedzonename;
  return function_8df6169f1826404f(spatialzonecontainer, linkedspatialzonename);
}

function ___zone() {}

function function_dc399f19a760cfe() {}

function private function_7504cd850bb3a272(zonename, originfunc, originfuncparams) {
  spatialzonestruct = spawnStruct();
  spatialzonestruct.name = zonename;
  spatialzonestruct.spheres = [];
  spatialzonestruct.var_f22e6ba735780bf0 = undefined;
  spatialzonestruct.istrackingplayers = undefined;
  spatialzonestruct.linkedzonename = undefined;
  spatialzonestruct.var_fd58633b3f789a94 = undefined;
  spatialzonestruct.trackedplayercallbacks = undefined;

  if(isDefined(originfunc)) {
    function_52fde51c281eeab7(spatialzonestruct, 1, originfunc, originfuncparams);
  } else {
    function_52fde51c281eeab7(spatialzonestruct, 0);
  }

  return spatialzonestruct;
}

function private function_e0f46a70ffb4d87f(var_c3abd07869aae560, var_30b4c4c7de0af09a) {
  spatialzonestruct = spawnStruct();
  spatialzonestruct.name = var_c3abd07869aae560.name;
  spatialzonestruct.originfunc = var_c3abd07869aae560.originfunc;
  spatialzonestruct.originfuncparams = var_c3abd07869aae560.originfuncparams;
  spatialzonestruct.hasdynamicorigin = var_c3abd07869aae560.hasdynamicorigin;
  spatialzonestruct.spheres = [];
  spatialzonestruct.var_fd58633b3f789a94 = [];
  spatialzonestruct.istrackingplayers = undefined;
  spatialzonestruct.linkedzonename = var_c3abd07869aae560.linkedzonename;
  spatialzonestruct.var_f22e6ba735780bf0 = var_c3abd07869aae560.var_f22e6ba735780bf0;
  spatialzonestruct.trackedplayercallbacks = var_c3abd07869aae560.trackedplayercallbacks;

  foreach(var_8c0d87dc4c5d1519 in var_c3abd07869aae560.spheres) {
    spherestruct = function_597b29b9438e170e(var_8c0d87dc4c5d1519, var_30b4c4c7de0af09a);
    spatialzonestruct.spheres[spatialzonestruct.spheres.size] = spherestruct;
  }

  return spatialzonestruct;
}

function function_4f0760b2bbdff4a9() {}

function private function_a7498090b981e3ce(spatialzonestruct) {
  if(isDefined(spatialzonestruct.trackedplayercallbacks)) {
    return spatialzonestruct.trackedplayercallbacks;
  }

  return [];
}

function private function_81cf0e4208bf4700(spatialzonestruct, player) {
  if(isDefined(spatialzonestruct.var_fd58633b3f789a94)) {
    var_73e7a09080fc7032 = spatialzonestruct.var_fd58633b3f789a94[player.guid];

    if(isDefined(var_73e7a09080fc7032) && var_73e7a09080fc7032 != 2) {
      return var_73e7a09080fc7032;
    }
  }

  return 2;
}

function function_c39f5c7c7c2d462d() {}

function private function_838c21358befc7e8(spatialzonestruct, name) {
  assertex(isstring(name), "<dev string:x496>");
  spatialzonestruct.name = name;
}

function private function_94a148e71e81b6b7(spatialzonestruct, spheres) {
  assertex(isarray(spheres), "<dev string:x4d2>");
  spatialzonestruct.spheres = spheres;
}

function private function_d4756552d03feb4b(spatialzonestruct, linkedzonename) {
  assertex(isstring(linkedzonename), "<dev string:x510>");
  spatialzonestruct.linkedzonename = linkedzonename;
}

function private function_273614bdb500882a(spatialzonestruct, var_f22e6ba735780bf0) {
  assertex(isnumber(var_f22e6ba735780bf0), "<dev string:x556>");
  assertex(var_f22e6ba735780bf0 >= 0 && var_f22e6ba735780bf0 <= 1, "<dev string:x59d>");

  if(var_f22e6ba735780bf0 == 1) {
    spatialzonestruct.var_f22e6ba735780bf0 = undefined;
    return;
  }

  spatialzonestruct.var_f22e6ba735780bf0 = var_f22e6ba735780bf0;
}

function private function_e8a513e2ad91765f(spatialzonestruct, originfunc) {
  assertex(isfunction(originfunc), "<dev string:x5f9>");
  spatialzonestruct.originfunc = originfunc;
}

function private function_288aecc063db7ead(spatialzonestruct, originfuncparams) {
  assertex(isarray(originfuncparams), "<dev string:x63d>");
  spatialzonestruct.originfuncparams = originfuncparams;
}

function private function_8da40627a9767c84(spatialzonestruct, hasdynamicorigin) {
  spatialzonestruct.hasdynamicorigin = istrue(hasdynamicorigin);
}

function private function_52fde51c281eeab7(spatialzonestruct, hasdynamicorigin, originfunc, originfuncparams) {
  if(istrue(hasdynamicorigin)) {
    function_e8a513e2ad91765f(spatialzonestruct, originfunc);
    function_288aecc063db7ead(spatialzonestruct, originfuncparams);
    function_8da40627a9767c84(spatialzonestruct, hasdynamicorigin);
    return;
  }

  spatialzonestruct.originfunc = undefined;
  spatialzonestruct.originfuncparams = undefined;
  function_8da40627a9767c84(spatialzonestruct, hasdynamicorigin);
}

function private function_86db5dfb83ed493c(spatialzonestruct, player, state) {
  if(!isDefined(spatialzonestruct.var_fd58633b3f789a94)) {
    spatialzonestruct.var_fd58633b3f789a94 = [];
  }

  spatialzonestruct.var_fd58633b3f789a94[player.guid] = state;
}

function private function_e2d5ed9933b02f0(spatialzonestruct, trackingplayers) {
  if(istrue(trackingplayers)) {
    spatialzonestruct.istrackingplayers = 1;
    return;
  }

  spatialzonestruct.istrackingplayers = undefined;
}

function function_9e7e849efc9e0ff() {}

function private function_c95dbcaf321695bf(spatialzonestruct, callbackfunc) {
  if(!isfunction(callbackfunc)) {
    zonename = spatialzonestruct.name;
    assertex(isfunction(callbackfunc), "<dev string:x684>" + zonename + "<dev string:x6b6>");

    return;
  }

  if(!isDefined(spatialzonestruct.trackedplayercallbacks)) {
    spatialzonestruct.trackedplayercallbacks = [];
  }

  spatialzonestruct.trackedplayercallbacks[spatialzonestruct.trackedplayercallbacks.size] = callbackfunc;
}

function private function_a958d8b86ac941fa(spatialzonecontainer, spatialzonestruct, var_d6bfa53c531546d6) {
  trackedplayercallbacks = function_a7498090b981e3ce(spatialzonestruct);

  foreach(callbackfunc in trackedplayercallbacks) {
    spatialzonecontainer thread[[callbackfunc]](var_d6bfa53c531546d6);
  }
}

function private function_bda026519a101554(spatialzonestruct, spherestruct) {
  if(function_7674e05ba210de51(spatialzonestruct)) {
    zonename = spatialzonestruct.name;
    linkedzonename = spatialzonestruct.linkedzonename;
    assertmsg("<dev string:x6ec>" + zonename + "<dev string:x70b>" + linkedzonename + "<dev string:x73a>");

    return;
  }

  spatialzonestruct.spheres[spatialzonestruct.spheres.size] = spherestruct;

  if(istrue(spatialzonestruct.hasdynamicorigin)) {
    dynamicorigin = function_761ac31d57f48836(spatialzonestruct);
    function_b7cc79aa88b72aa(spherestruct, dynamicorigin);
  }
}

function private function_2a428fdf96745d77(spatialzonestruct, spherestruct) {
  if(function_7674e05ba210de51(spatialzonestruct)) {
    zonename = spatialzonestruct.name;
    linkedzonename = spatialzonestruct.linkedzonename;
    assertmsg("<dev string:x6ec>" + zonename + "<dev string:x70b>" + linkedzonename + "<dev string:x775>");

    return;
  }

  spherefound = array_find(spatialzonestruct.spheres, spherestruct);
  assertex(isDefined(spherefound), "<dev string:x7b5>" + spatialzonestruct.name + "<dev string:x7d7>");

  spatialzonestruct.spheres = array_remove(spatialzonestruct.spheres, spherestruct);
}

function private function_7674e05ba210de51(spatialzonestruct) {
  return isDefined(spatialzonestruct.linkedzonename);
}

function private function_761ac31d57f48836(spatialzonestruct) {
  spatialzonename = spatialzonestruct.name;
  hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
  assertex(istrue(hasdynamicorigin), "<dev string:x808>" + spatialzonename + "<dev string:x81f>");

  originfunc = spatialzonestruct.originfunc;
  originfuncparams = spatialzonestruct.originfuncparams;

  if(originfuncparams.size == 0) {
    return [[originfunc]]();
  }

  if(originfuncparams.size == 1) {
    return [[originfunc]](originfuncparams[0]);
  }

  if(originfuncparams.size == 2) {
    return [[originfunc]](originfuncparams[0], originfuncparams[1]);
  }

  if(originfuncparams.size == 3) {
    return [[originfunc]](originfuncparams[0], originfuncparams[1], originfuncparams[2]);
  }

  if(originfuncparams.size == 4) {
    return [[originfunc]](originfuncparams[0], originfuncparams[1], originfuncparams[2], originfuncparams[3]);
  }

  if(originfuncparams.size == 5) {
    return [[originfunc]](originfuncparams[0], originfuncparams[1], originfuncparams[2], originfuncparams[3], originfuncparams[4]);
  }

  assertmsg("<dev string:x84f>");
}

function private function_d062cecc46c021f8() {
  return (0, 0, 0);
}

function function_480fb313d80cf3f5() {}

function function_77d20a3b70a7283a() {}

function function_37c1f31d2434f628(spatialzonespherestruct) {
  var_30b4c4c7de0af09a = spatialzonespherestruct.var_30b4c4c7de0af09a;
  associatedspatialzonename = spatialzonespherestruct.associatedspatialzonename;
  spatialzonestruct = function_8df6169f1826404f(var_30b4c4c7de0af09a, associatedspatialzonename);
  hasdynamicorigin = spatialzonestruct.hasdynamicorigin;

  if(istrue(hasdynamicorigin)) {
    dynamicorigin = function_761ac31d57f48836(spatialzonestruct);

    if(isDefined(spatialzonespherestruct.originoffset)) {
      sphereoriginoffset = spatialzonespherestruct.originoffset;
      dynamicorigin += sphereoriginoffset;
    }

    return dynamicorigin;
  }

  return spatialzonespherestruct.origin;
}

function function_2403f7fe5d40cecc(spatialzonespherestruct) {
  if(isDefined(spatialzonespherestruct.radius)) {
    return spatialzonespherestruct.radius;
  }

  return 0;
}

function function_57b6f343b7d09b4f() {}

function private function_fafa83b3d61f29bf(var_30b4c4c7de0af09a, associatedspatialzonename, origin, radius, ignoreheightvalue) {
  spatialzonespherestruct = spawnStruct();
  spatialzonespherestruct.associatedspatialzonename = associatedspatialzonename;
  spatialzonespherestruct.var_30b4c4c7de0af09a = var_30b4c4c7de0af09a;
  spatialzonespherestruct.origin = origin;
  spatialzonespherestruct.originoffset = undefined;
  spatialzonespherestruct.radius = ter_op(istrue(radius), radius, undefined);
  spatialzonespherestruct.shouldignoreheight = ter_op(istrue(ignoreheightvalue), ignoreheightvalue, undefined);
  return spatialzonespherestruct;
}

function private function_597b29b9438e170e(var_db04b14477ee8a3d, var_30b4c4c7de0af09a) {
  spatialzonespherestruct = spawnStruct();
  spatialzonespherestruct.associatedspatialzonename = var_db04b14477ee8a3d.associatedspatialzonename;
  spatialzonespherestruct.var_30b4c4c7de0af09a = var_30b4c4c7de0af09a;
  spatialzonespherestruct.origin = var_db04b14477ee8a3d.origin;
  spatialzonespherestruct.radius = var_db04b14477ee8a3d.radius;
  spatialzonespherestruct.originoffset = var_db04b14477ee8a3d.originoffset;
  spatialzonespherestruct.shouldignoreheight = var_db04b14477ee8a3d.shouldignoreheight;
  return spatialzonespherestruct;
}

function function_9e4d4e02d806dcb6() {}

function private function_b7cc79aa88b72aa(spherestruct, relativeorigin) {
  sphereorigin = spherestruct.origin;

  if(isDefined(sphereorigin)) {
    spherestruct.originoffset = spherestruct.origin - relativeorigin;
  }
}

function private function_9bbcadf2b49388fe(spatialzonespherestruct) {
  radius = function_2403f7fe5d40cecc(spatialzonespherestruct);
  origin = function_37c1f31d2434f628(spatialzonespherestruct);
  return function_cb1b89cc191e41a1(origin, radius);
}

function private function_cb1b89cc191e41a1(origin, radius) {
  var_52d4532288e7d57b = getdvarfloat(@ "hash_7cea12faaeb9d47");
  var_c7fb046f48fd6f5d = 500;
  var_14e6c26fe86384ed = 150;

  if(radius > var_52d4532288e7d57b) {
    return true;
  }

  var_40ad756883c3a593 = function_e7cf54cfde888617(origin);
  radiusdistance = max(radius, var_c7fb046f48fd6f5d);
  radiusdistance += var_14e6c26fe86384ed;

  if(var_40ad756883c3a593 <= radiusdistance) {
    return true;
  }

  return false;
}

function function_5b838ee087a0dcf() {}

function function_a23cbc14c47de301() {}

function private function_c105bef1dce7e126(groupuniquename) {
  var_fddf10a2d71f933f = spawnStruct();
  var_fddf10a2d71f933f.var_a946cf5961339ba3 = [];
  var_fddf10a2d71f933f.groupuniquename = groupuniquename;
  return var_fddf10a2d71f933f;
}

function function_1b5676eddeadaac0() {}

function private function_7b11f0e21972b417(var_fddf10a2d71f933f, spatialzonecontainer, player) {
  groupeduniquename = var_fddf10a2d71f933f.groupuniquename;

  if(isDefined(spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename][player.guid])) {
    return spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename][player.guid];
  }

  return 2;
}

function function_6bd6b3b2a42ee49c() {}

function private function_8cb56cec0bc3aa3b(var_fddf10a2d71f933f, spatialzonecontainer, player, state) {
  groupeduniquename = var_fddf10a2d71f933f.groupuniquename;
  var_fd78ed23cea8879a = spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename];

  if(state == 2) {
    spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename][player.guid] = undefined;
    return;
  }

  spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename][player.guid] = state;
}

function function_a6cc014227a6df00() {}

function private function_89a410e0520a2538(var_fddf10a2d71f933f) {
  if(!isDefined(level.var_7124e21f1a70f024)) {
    level.var_7124e21f1a70f024 = [];
  }

  groupuniquename = var_fddf10a2d71f933f.groupuniquename;
  level.var_7124e21f1a70f024[groupuniquename] = var_fddf10a2d71f933f;
}

function private function_7c6ad7d6dbbe8f8d(groupuniquename) {
  if(isDefined(level.var_7124e21f1a70f024) && isDefined(level.var_7124e21f1a70f024[groupuniquename])) {
    return true;
  }

  return false;
}

function private function_e29cde2039de320b(spatialzonecontainer, var_fddf10a2d71f933f, var_d6bfa53c531546d6) {
  foreach(var_add82376d656f0a2 in var_fddf10a2d71f933f.var_a946cf5961339ba3) {
    spatialzonecontainer thread[[var_add82376d656f0a2]](var_d6bfa53c531546d6);
  }
}

function private function_a6fa763d7797fba4(spatialzonecontainer, var_fddf10a2d71f933f, var_5dd9cb9b94aebbec) {
  return spatialzonecontainer[[var_fddf10a2d71f933f.var_e8fd20aceb2acf03]](var_5dd9cb9b94aebbec);
}

function private function_d945c3caff4dfe6a(var_fddf10a2d71f933f) {
  return isDefined(var_fddf10a2d71f933f.var_e8fd20aceb2acf03);
}

function private function_1fa32a566ea388ec(var_fddf10a2d71f933f, spatialzonecontainer) {
  if(!isDefined(spatialzonecontainer.var_fd78ed23cea8879a)) {
    spatialzonecontainer.var_fd78ed23cea8879a = [];
  }

  groupeduniquename = var_fddf10a2d71f933f.groupuniquename;

  if(!isDefined(spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename])) {
    spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename] = [];
  }
}

function private function_67e9780e178e0f49(var_fddf10a2d71f933f, spatialzonecontainer) {
  if(!isDefined(spatialzonecontainer.var_fd78ed23cea8879a)) {
    return false;
  }

  groupeduniquename = var_fddf10a2d71f933f.groupuniquename;

  if(!isDefined(spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename])) {
    return false;
  }

  return true;
}

function private function_772ac1165605d8d(var_112b3319b6684d8d, var_fddf10a2d71f933f, zonename, var_8e455a7fd03e24c7) {
  groupuniquename = var_fddf10a2d71f933f.groupuniquename;
  var_fddf10a2d71f933f endon("stop_player_zone_watching_" + groupuniquename);
  var_b4879576df4e0a18 = default_to(var_8e455a7fd03e24c7, 2);

  while(true) {
    if(!isDefined(level.players)) {
      waitframe();
      continue;
    }

    var_b93495deafd94e3f = self[[var_112b3319b6684d8d]]();
    var_ce232bf9498cb4aa = level.players;
    var_457fb4e5e28e3bff = var_ce232bf9498cb4aa.size;
    var_167520872fb644e9 = var_b93495deafd94e3f.size;
    var_e8a501af877f0ba0 = var_457fb4e5e28e3bff * var_167520872fb644e9;
    var_e67e40114df7cf27 = max(var_b4879576df4e0a18 / level.framedurationseconds, 1);
    var_e778e7213e094e03 = max(var_e8a501af877f0ba0 / var_e67e40114df7cf27, 1);
    var_e778e7213e094e03 = ceil(var_e778e7213e094e03);
    var_7e37925a7863886e = gettime() / 1000;
    var_fdec72ea7bdf0ed6 = 0;

    foreach(spatialzonecontainer in var_b93495deafd94e3f) {
      if(!isDefined(spatialzonecontainer) || !function_1888d1b2aeeda25(spatialzonecontainer, zonename)) {
        continue;
      }

      if(!function_67e9780e178e0f49(var_fddf10a2d71f933f, spatialzonecontainer)) {
        function_1fa32a566ea388ec(var_fddf10a2d71f933f, spatialzonecontainer);
      }

      var_daffb4098d7ba87 = 0;
      var_bbc0c327dc7508fb = 0;
      var_a0a6bb97d0f7cf8 = var_ce232bf9498cb4aa.size;

      while(var_a0a6bb97d0f7cf8 > 0) {
        var_783eb6b458f23ed6 = 0;
        var_af5ea151937c1c71 = var_e778e7213e094e03 - var_fdec72ea7bdf0ed6;
        var_46405c045ed46de0 = min(var_daffb4098d7ba87 + var_af5ea151937c1c71 - 1, var_ce232bf9498cb4aa.size - 1);
        var_46405c045ed46de0 = int(var_46405c045ed46de0);
        var_ce60632ae996343a = function_19a1763950dc39f2(var_ce232bf9498cb4aa, var_daffb4098d7ba87, var_46405c045ed46de0, spatialzonecontainer, var_fddf10a2d71f933f, zonename);

        for(playerindex = var_daffb4098d7ba87; playerindex <= var_46405c045ed46de0; playerindex++) {
          player = var_ce232bf9498cb4aa[playerindex];

          if(!isDefined(player)) {
            continue;
          }

          var_8bd78a648ccdea91 = istrue(var_ce60632ae996343a[player.guid]);
          var_73e7a09080fc7032 = function_7b11f0e21972b417(var_fddf10a2d71f933f, spatialzonecontainer, player);

          if(var_8bd78a648ccdea91) {
            if(var_73e7a09080fc7032 != 0) {
              firsttimeinzone = var_73e7a09080fc7032 == 2;
              function_8cb56cec0bc3aa3b(var_fddf10a2d71f933f, spatialzonecontainer, player, 0);
              groupeduniquename = var_fddf10a2d71f933f.groupuniquename;
              var_fd78ed23cea8879a = spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename];
              var_d6bfa53c531546d6 = function_e446aba84f4ffc9e(player, zonename, 1, firsttimeinzone, var_fd78ed23cea8879a);
              function_e29cde2039de320b(spatialzonecontainer, var_fddf10a2d71f933f, var_d6bfa53c531546d6);
            }

            continue;
          }

          if(var_73e7a09080fc7032 == 0) {
            function_8cb56cec0bc3aa3b(var_fddf10a2d71f933f, spatialzonecontainer, player, 1);
            groupeduniquename = var_fddf10a2d71f933f.groupuniquename;
            var_fd78ed23cea8879a = spatialzonecontainer.var_fd78ed23cea8879a[groupeduniquename];
            var_d6bfa53c531546d6 = function_e446aba84f4ffc9e(player, zonename, 0, 0, var_fd78ed23cea8879a);
            function_e29cde2039de320b(spatialzonecontainer, var_fddf10a2d71f933f, var_d6bfa53c531546d6);
          }
        }

        var_783eb6b458f23ed6 = var_46405c045ed46de0 - var_daffb4098d7ba87 + 1;
        var_bbc0c327dc7508fb += var_783eb6b458f23ed6;
        var_a0a6bb97d0f7cf8 -= var_bbc0c327dc7508fb;
        var_fdec72ea7bdf0ed6 += var_783eb6b458f23ed6;
        var_daffb4098d7ba87 = var_46405c045ed46de0 + 1;

        if(var_fdec72ea7bdf0ed6 >= var_e778e7213e094e03) {
          waitframe();
          var_fdec72ea7bdf0ed6 = 0;
        }
      }

      var_3fc8f38998f11641 = gettime() / 1000;
      var_2c3ea2fc1caa85b8 = var_3fc8f38998f11641 - var_7e37925a7863886e;

      if(var_2c3ea2fc1caa85b8 < var_b4879576df4e0a18) {
        var_94f6d0227b36c6f8 = var_b4879576df4e0a18 - var_2c3ea2fc1caa85b8;
        wait var_94f6d0227b36c6f8;
        continue;
      }

      waitframe();
    }

    waitframe();
  }
}

function private function_19a1763950dc39f2(playerlist, startingplayerindex, endingplayerindex, spatialzonecontainer, var_fddf10a2d71f933f, zonename, var_af05175e4604c05c) {
  assertex(startingplayerindex <= endingplayerindex && startingplayerindex >= 0, "<dev string:x8fb>");
  assertex(endingplayerindex < playerlist.size, "<dev string:x95f>");
  assertex(function_1888d1b2aeeda25(spatialzonecontainer, zonename), "<dev string:x25b>" + zonename + "<dev string:x265>");
  var_af05175e4604c05c = default_to(var_af05175e4604c05c, 1);
  var_e2ba8e54ae6fa092 = function_5bbdc39a533d9d57(spatialzonecontainer, zonename);
  var_aefb4954fb48f074 = [];
  var_ef85bfc09583aed6 = function_d945c3caff4dfe6a(var_fddf10a2d71f933f);

  foreach(spatialzonespherestruct in var_e2ba8e54ae6fa092) {
    playerwithinradius = 0;
    sphereorigin = function_37c1f31d2434f628(spatialzonespherestruct);
    sphereradius = function_2403f7fe5d40cecc(spatialzonespherestruct) * var_af05175e4604c05c;
    shouldignoreheight = istrue(spatialzonespherestruct.shouldignoreheight);

    if(!function_cb1b89cc191e41a1(sphereorigin, sphereradius)) {
      continue;
    }

    for(playerindex = startingplayerindex; playerindex <= endingplayerindex; playerindex++) {
      player = playerlist[playerindex];

      if(!isPlayer(player) || !isalive(player)) {
        continue;
      }

      if(shouldignoreheight) {
        playerwithinradius = function_acb96530881571aa(player, sphereorigin, sphereradius);
      } else {
        playerwithinradius = playerwithindistance(player, sphereorigin, sphereradius);
      }

      if(var_ef85bfc09583aed6) {
        var_e33aa6ec4a9e8de9 = function_e90a0002d2d986ea(player, zonename, playerwithinradius);
        playerwithinradius = function_a6fa763d7797fba4(spatialzonecontainer, var_fddf10a2d71f933f, var_e33aa6ec4a9e8de9);
      }

      if(playerwithinradius) {
        var_aefb4954fb48f074[player.guid] = 1;
      }
    }
  }

  return var_aefb4954fb48f074;
}

function function_2fc81158cd76e4d0() {}

function private function_e446aba84f4ffc9e(player, zonename, var_18e24f887f518d61, firsttimeinzone, var_d1afc0a367bfc7f2) {
  var_757bf8d3263ee8b7 = spawnStruct();
  var_757bf8d3263ee8b7.player = player;
  var_757bf8d3263ee8b7.zonename = zonename;
  var_757bf8d3263ee8b7.enteredzone = var_18e24f887f518d61;
  var_757bf8d3263ee8b7.firsttimeinzone = firsttimeinzone;
  var_757bf8d3263ee8b7.var_9f2dab34edc7e257 = [];

  if(isDefined(var_d1afc0a367bfc7f2)) {
    foreach(playerguid, playerzonestate in var_d1afc0a367bfc7f2) {
      if(playerzonestate == 0) {
        player = getplayerforguid(playerguid);

        if(isDefined(player) && isPlayer(player)) {
          var_757bf8d3263ee8b7.var_9f2dab34edc7e257[var_757bf8d3263ee8b7.var_9f2dab34edc7e257.size] = player;
        }
      }
    }
  }

  return var_757bf8d3263ee8b7;
}

function private function_e90a0002d2d986ea(player, zonename, playerwithinradius) {
  var_e33aa6ec4a9e8de9 = spawnStruct();
  var_e33aa6ec4a9e8de9.player = player;
  var_e33aa6ec4a9e8de9.zonename = zonename;
  var_e33aa6ec4a9e8de9.withinradius = playerwithinradius;
  return var_e33aa6ec4a9e8de9;
}