/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_73a03aaf11b641f5.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_9342d78fcaacff0b;

function function_3cb68ff0e737a246() {}

function function_21a54af27815de3c() {}

function function_87feb89ed3bfcf19() {
  spatialzonecontainer = function_88721c23c7261770();
  return spatialzonecontainer;
}

function function_8e5a4cfaa06f6dd2(var_625dabbabd7b4fb2) {
  assert(isstruct(var_625dabbabd7b4fb2), "<dev string:x24>");
  var_625dabbabd7b4fb2.var_68f79730660dd4b1 = function_88721c23c7261770();
}

function function_8c15e5edf2535a72(var_83f483139796f6b1, var_3adb33893e80bde5) {
  function_8e5a4cfaa06f6dd2(var_83f483139796f6b1);
  assert(function_c79301fab4d28d85(var_3adb33893e80bde5), "<dev string:x6d>");
  assert(isstruct(var_83f483139796f6b1), "<dev string:x24>");
  var_85e5becc2811e6c0 = function_3d92fc12581db23a(var_3adb33893e80bde5);

  foreach(var_e2dbb702970ccf1 in var_85e5becc2811e6c0) {
    spatialzonestruct = function_8edb8285ca1169ea(var_e2dbb702970ccf1, var_83f483139796f6b1);
    function_7e80e24551ea59fa(var_83f483139796f6b1, spatialzonestruct);
  }
}

function function_74efd5899140b8f5() {}

function function_c79301fab4d28d85(var_23186aeda0c6bb85) {
  return isDefined(var_23186aeda0c6bb85.var_68f79730660dd4b1);
}

function function_a2f5a6979eb10328(spatialzonecontainer, zonename) {
  var_1cdd4ab9cb5e23a5 = spatialzonecontainer.var_68f79730660dd4b1;
  return isDefined(var_1cdd4ab9cb5e23a5.zones[zonename]);
}

function function_13f14550ca534a5e(spatialzonecontainer, zonename) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);
  hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
  return istrue(hasdynamicorigin);
}

function function_d155afd969a2a226(spatialzonecontainer, zonename) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    return function_4873ac3cc98f5f97(spatialzonecontainer, zonename);
  }

  return spatialzonestruct.spheres;
}

function function_6767d8780e93f549(spatialzonecontainer) {
  zonenames = [];
  spatialzonestructs = function_3d92fc12581db23a(spatialzonecontainer);

  foreach(spatialzonestruct in spatialzonestructs) {
    zonenames[zonenames.size] = spatialzonestruct.name;
  }

  return zonenames;
}

function function_cc3a9813862b30f9() {}

function function_d98dd1246d42a25e(spatialzonecontainer, zonename, orign, radius, ignoreheight) {
  if(!function_a2f5a6979eb10328(spatialzonecontainer, zonename)) {
    addspatialzone(spatialzonecontainer, zonename);
  }

  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    assertmsg("<dev string:xde>" + zonename + "<dev string:xf0>" + spatialzonestruct.linkedzonename + "<dev string:x102>" + spatialzonestruct.linkedzonename + "<dev string:x150>");
    return;
  }

  if(!function_13f14550ca534a5e(spatialzonecontainer, zonename) && !isDefined(orign)) {
    function_7ade4e318cc0a207(spatialzonecontainer, zonename, &function_1e9aef45b1953ed5);
  }

  newsphere = function_34a76480600d9ea2(spatialzonecontainer, zonename, orign, radius, ignoreheight);
  function_ac787cbee340df1(spatialzonestruct, newsphere);
  return newsphere;
}

function addspatialzone(spatialzonecontainer, zonename) {
  spatialzonestruct = function_b3d788222da68803(zonename);
  function_7e80e24551ea59fa(spatialzonecontainer, spatialzonestruct);
  return spatialzonestruct;
}

function function_2aec393c918e9b98(spatialzonecontainer, zonename, originfunc = &function_1e9aef45b1953ed5, originfuncparams = []) {
  spatialzonestruct = function_b3d788222da68803(zonename, originfunc, originfuncparams);
  function_7e80e24551ea59fa(spatialzonecontainer, spatialzonestruct);
  return spatialzonestruct;
}

function function_f76bf9dd3e47f0b4(spatialzonecontainer, zonename, var_81307438870ca129, var_44f02924bf665f2d = 1) {
  var_1cdd4ab9cb5e23a5 = function_ff1f820120ca4d58(spatialzonecontainer);

  if(!function_a2f5a6979eb10328(spatialzonecontainer, zonename)) {
    spatialzonestruct = addspatialzone(spatialzonecontainer, zonename);
  }

  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(!function_a2f5a6979eb10328(spatialzonecontainer, zonename)) {
    addspatialzone(spatialzonecontainer, var_81307438870ca129);
  }

  function_ff975354b6b397e(spatialzonestruct, var_81307438870ca129);
  function_375ef4c1392f5943(spatialzonestruct, var_44f02924bf665f2d);
}

function function_7ade4e318cc0a207(spatialzonecontainer, zonename, originfunc, originfuncparams = []) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);
  function_9c029354a997266e(spatialzonestruct, 1, originfunc, originfuncparams);
  var_b33e6eaec673647 = spatialzonestruct.spheres;

  foreach(spatialzonespherestruct in var_b33e6eaec673647) {
    dynamicorigin = function_75263756d8f9211b(spatialzonestruct);
    function_92641fb138d349d3(spatialzonespherestruct, dynamicorigin);
  }
}

function function_b2b20b83dfc15105(spatialzonecontainer, zonename, spatialzonespherestruct) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    assertmsg("<dev string:xde>" + zonename + "<dev string:xf0>" + spatialzonestruct.linkedzonename + "<dev string:x159>" + spatialzonestruct.linkedzonename + "<dev string:x150>");
    return;
  }

  function_d9685670b95503ce(spatialzonestruct, spatialzonespherestruct);
}

function function_ad5d8806fb714e21(spatialzonecontainer, zonename) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    assertmsg("<dev string:xde>" + zonename + "<dev string:xf0>" + spatialzonestruct.linkedzonename + "<dev string:x1af>" + spatialzonestruct.linkedzonename + "<dev string:x150>");
    return;
  }

  spatialzonestruct.spheres = [];
}

function function_a6db495fdf1e6714(spatialzonecontainer, zonename, ignoreheight) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    assertmsg("<dev string:xde>" + zonename + "<dev string:xf0>" + spatialzonestruct.linkedzonename + "<dev string:x208>" + spatialzonestruct.linkedzonename + "<dev string:x150>");
    return;
  }

  var_b33e6eaec673647 = spatialzonestruct.spheres;

  foreach(spherestruct in var_b33e6eaec673647) {
    if(istrue(ignoreheight)) {
      spherestruct.shouldignoreheight = 1;
      continue;
    }

    spherestruct.shouldignoreheight = undefined;
  }
}

function function_ffcdcbaec734bc41() {}

function function_58f7e353fe6bde02(player, spatialzonecontainer, zonename, var_d7965e5102a3c3b9) {
  assert(function_a2f5a6979eb10328(spatialzonecontainer, zonename), "<dev string:x263>" + zonename + "<dev string:x26d>");

  if(!isDefined(var_d7965e5102a3c3b9)) {
    var_d7965e5102a3c3b9 = 1;
  }

  var_ebe2230b75ef39ab = function_d155afd969a2a226(spatialzonecontainer, zonename);

  foreach(spatialzonespherestruct in var_ebe2230b75ef39ab) {
    sphereorigin = function_4e71ca577d4d6ad9(spatialzonespherestruct);
    sphereradius = function_49eb13996d2d23ed(spatialzonespherestruct) * var_d7965e5102a3c3b9;
    shouldignoreheight = istrue(spatialzonespherestruct.shouldignoreheight);

    if(!function_7b56e68d559af704(sphereorigin, sphereradius)) {
      continue;
    }

    playerwithinradius = 0;

    if(shouldignoreheight) {
      playerwithinradius = utility::function_f52121cd5b6adecf(player, sphereorigin, sphereradius);
    } else {
      playerwithinradius = utility::playerwithindistance(player, sphereorigin, sphereradius);
    }

    if(playerwithinradius) {
      return true;
    }
  }

  return false;
}

function function_501d514afe3347(spatialzonecontainer, zonename, zonescaleoverride, excludedplayers) {
  assert(function_a2f5a6979eb10328(spatialzonecontainer, zonename), "<dev string:x263>" + zonename + "<dev string:x2d2>");

  if(!isDefined(zonescaleoverride)) {
    zonescaleoverride = 1;
  }

  var_ebe2230b75ef39ab = function_d155afd969a2a226(spatialzonecontainer, zonename);
  var_a10186f3103a99b9 = [];

  foreach(spatialzonespherestruct in var_ebe2230b75ef39ab) {
    sphereorigin = function_4e71ca577d4d6ad9(spatialzonespherestruct);
    sphereradius = function_49eb13996d2d23ed(spatialzonespherestruct) * zonescaleoverride;
    shouldignoreheight = istrue(spatialzonespherestruct.shouldignoreheight);

    if(!function_7b56e68d559af704(sphereorigin, sphereradius)) {
      continue;
    }

    if(shouldignoreheight) {
      foreach(player in level.players) {
        var_5475bfc08951e5eb = utility::function_f52121cd5b6adecf(player, sphereorigin, sphereradius);
        var_a10186f3103a99b9[var_a10186f3103a99b9.size] = player;
      }

      continue;
    }

    var_5475bfc08951e5eb = utility::callsharedfunc(#"spatial_zone", #"getplayersinspatialzonesphere", sphereorigin, sphereradius, excludedplayers);
    var_a10186f3103a99b9 = utility::array_combine_unique(var_a10186f3103a99b9, var_5475bfc08951e5eb);
  }

  return var_a10186f3103a99b9;
}

function function_f2e53542ee18227d(spatialzonecontainer, zonename, var_caa9cf830e4b8dd, var_39fd075f67e1d4dc, var_31a9a8b820d2a415) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  if(isDefined(var_caa9cf830e4b8dd) && isfunction(var_caa9cf830e4b8dd)) {
    function_18eca16d012d3b82(spatialzonestruct, var_caa9cf830e4b8dd);
  }

  if(istrue(spatialzonestruct.istrackingplayers)) {
    return;
  }

  function_207d0188ad2a9a89(spatialzonestruct, 1);

  if(istrue(var_31a9a8b820d2a415)) {
    childthread function_bcc312cdf4705406(spatialzonecontainer, zonename, var_39fd075f67e1d4dc);
    return;
  }

  thread function_bcc312cdf4705406(spatialzonecontainer, zonename, var_39fd075f67e1d4dc);
}

function function_46f0c8703af5a965(groupuniquename, var_6f9f78cc587ed65c, var_caa9cf830e4b8dd, zonename, var_5c202893abc9b40e) {
  if(!function_d24b81ba44d6188c(groupuniquename)) {
    var_5646f6535b64605a = function_205355139407173(groupuniquename);
    function_6201004edbc26fad(var_5646f6535b64605a);
    function_82ca7e91dde31c10(groupuniquename, var_caa9cf830e4b8dd);
    var_5646f6535b64605a thread function_414def5c93d0cf00(var_6f9f78cc587ed65c, var_5646f6535b64605a, zonename, var_5c202893abc9b40e);
    return;
  }

  function_82ca7e91dde31c10(groupuniquename, var_caa9cf830e4b8dd);
}

function function_26732f46a05cc793(spatialzonecontainer, zonename) {
  spatialzonecontainer notify("\xe27\xda\xcb\xb2\x85\xe6n\xcbJ\xee\xa7K\x1d\x8aw|\fb\x10\xeb\xd4W*\xe7\xff" + zonename);
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  foreach(player in level.players) {
    function_634aab85c1008c01(spatialzonestruct, player, 2);
  }

  function_207d0188ad2a9a89(spatialzonestruct, 0);
}

function function_84d2f323c6f4d8cb(groupuniquename) {
  if(function_d24b81ba44d6188c(groupuniquename)) {
    level.var_16842167ea38b901[groupuniquename] notify("\xe27\xda\xcb\xb2\x85\xe6n\xcbJ\xee\xa7K\x1d\x8aw|\fb\x10\xeb\xd4W*\xe7\xff" + groupuniquename);
    level.var_16842167ea38b901[groupuniquename] = undefined;
  }
}

function function_82ca7e91dde31c10(groupuniquename, var_caa9cf830e4b8dd) {
  assert(isfunction(var_caa9cf830e4b8dd), "<dev string:x338>");
  var_5646f6535b64605a = level.var_16842167ea38b901[groupuniquename];

  if(isDefined(var_5646f6535b64605a)) {
    foreach(callbackfunc in var_5646f6535b64605a.var_71ebe3f8c3f0cb66) {
      if(callbackfunc == var_caa9cf830e4b8dd) {
        return;
      }
    }

    var_5646f6535b64605a.var_71ebe3f8c3f0cb66[var_5646f6535b64605a.var_71ebe3f8c3f0cb66.size] = var_caa9cf830e4b8dd;
    return;
  }

  assertmsg("<dev string:x386>" + groupuniquename + "<dev string:x3cd>");
}

function function_9bcbc89a972581c2(groupuniquename, var_3e919325046f993e) {
  assert(isfunction(var_3e919325046f993e), "<dev string:x338>");
  var_5646f6535b64605a = level.var_16842167ea38b901[groupuniquename];

  if(isDefined(var_5646f6535b64605a)) {
    var_5646f6535b64605a.var_3e919325046f993e = var_3e919325046f993e;
    return;
  }

  assertmsg("<dev string:x386>" + groupuniquename + "<dev string:x3cd>");
}

function function_3c5e9e0c21a366a4() {}

function private function_88721c23c7261770() {
  var_68f79730660dd4b1 = spawnStruct();
  var_68f79730660dd4b1.zones = [];
  return var_68f79730660dd4b1;
}

function function_5d078072f81634bd() {}

function private function_ff1f820120ca4d58(spatialzonecontainer) {
  assert(function_c79301fab4d28d85(spatialzonecontainer), "<dev string:x6d>");
  return spatialzonecontainer.var_68f79730660dd4b1;
}

function private function_840c78cc1249d102(spatialzonecontainer, zonename) {
  var_1cdd4ab9cb5e23a5 = function_ff1f820120ca4d58(spatialzonecontainer);
  assert(isDefined(var_1cdd4ab9cb5e23a5.zones[zonename]), "<dev string:x414>" + zonename + "<dev string:x42c>");
  return var_1cdd4ab9cb5e23a5.zones[zonename];
}

function private function_3d92fc12581db23a(spatialzonecontainer) {
  var_1cdd4ab9cb5e23a5 = function_ff1f820120ca4d58(spatialzonecontainer);
  return var_1cdd4ab9cb5e23a5.zones;
}

function function_fdb5956b4a023c29() {}

function private function_7e80e24551ea59fa(spatialzonecontainer, spatialzonestruct) {
  var_1cdd4ab9cb5e23a5 = function_ff1f820120ca4d58(spatialzonecontainer);
  zonename = spatialzonestruct.name;

  if(function_a2f5a6979eb10328(spatialzonecontainer, zonename)) {
    assertmsg("<dev string:x454>" + zonename + "<dev string:x476>");
    return;
  }

  var_1cdd4ab9cb5e23a5.zones[zonename] = spatialzonestruct;
}

function private function_4873ac3cc98f5f97(spatialzonecontainer, zonename) {
  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);
  spatialzonescale = spatialzonestruct.var_44f02924bf665f2d ?? 1;

  while(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    var_b543359f65f06022 = function_1293c52d696b1ff0(spatialzonecontainer, spatialzonestruct);
    var_e2831aecc3a61555 = var_b543359f65f06022.var_44f02924bf665f2d ?? 1;

    if(isnumber(var_e2831aecc3a61555)) {
      spatialzonescale *= var_e2831aecc3a61555;
    }

    spatialzonestruct = var_b543359f65f06022;
  }

  if(spatialzonescale != 1) {
    scaledspheres = [];
    spatialzonespheres = spatialzonestruct.spheres;

    foreach(zonesphere in spatialzonespheres) {
      origin = function_4e71ca577d4d6ad9(zonesphere);
      radius = function_49eb13996d2d23ed(zonesphere) * spatialzonescale;
      ignoreheight = istrue(zonesphere.shouldignoreheight);
      scaledspheres[scaledspheres.size] = function_34a76480600d9ea2(spatialzonecontainer, zonename, origin, radius, ignoreheight);
    }

    return scaledspheres;
  }

  return spatialzonestruct.spheres;
}

function private function_bcc312cdf4705406(spatialzonecontainer, zonename, var_39fd075f67e1d4dc) {
  spatialzonecontainer endon("\xe27\xda\xcb\xb2\x85\xe6n\xcbJ\xee\xa7K\x1d\x8aw|\fb\x10\xeb\xd4W*\xe7\xff" + zonename);

  if(!isDefined(var_39fd075f67e1d4dc)) {
    var_39fd075f67e1d4dc = 1;
  }

  spatialzonestruct = function_840c78cc1249d102(spatialzonecontainer, zonename);

  while(true) {
    function_dfd4d9fd84819c70(#"hash_86f9c9a6fb0a647e");
    var_479918c7c25ee949 = level.players.size;
    availableframes = max(var_39fd075f67e1d4dc / level.framedurationseconds, 1);
    var_21bc4098d3a685d8 = max(var_479918c7c25ee949 / availableframes, 1);
    var_e9e0f04ec2126b13 = 0;
    var_131486eae3682d7 = gettime() / 1000;
    var_3c366e125ce1266c = level.players;

    foreach(player in var_3c366e125ce1266c) {
      if(!isPlayer(player) || !isalive(player)) {
        continue;
      }

      if(var_e9e0f04ec2126b13 >= var_21bc4098d3a685d8) {
        profileendevent();
        var_e9e0f04ec2126b13 = 0;
        waitframe();
        function_dfd4d9fd84819c70(#"hash_86f9c9a6fb0a647e");
      }

      var_36ae14085240556c = function_58f7e353fe6bde02(player, spatialzonecontainer, zonename);
      var_e61c517ce38d67ab = function_3994f238ba38db55(spatialzonestruct, player);

      if(var_36ae14085240556c) {
        if(var_e61c517ce38d67ab != 0) {
          firsttimeinzone = var_e61c517ce38d67ab == 2;
          function_634aab85c1008c01(spatialzonestruct, player, 0);
          var_33811f0dcf8cbb6f = {
            #var_ba782b7c5f72c30d: &function_320752fa9e69e861, #var_c18845f1bf0a4e3a: spatialzonestruct.var_9fb5fbb4e21c4e49, #firsttimeinzone: firsttimeinzone, #enteredzone: 1, #zonename: zonename, #player: player
          };
          function_ccd9e1fe8ed10c13(spatialzonecontainer, spatialzonestruct, var_33811f0dcf8cbb6f);
        }
      } else if(var_e61c517ce38d67ab == 0) {
        wasinzone = var_e61c517ce38d67ab == 0;
        function_634aab85c1008c01(spatialzonestruct, player, 1);
        var_33811f0dcf8cbb6f = {
          #var_ba782b7c5f72c30d: &function_320752fa9e69e861, #var_c18845f1bf0a4e3a: spatialzonestruct.var_9fb5fbb4e21c4e49, #firsttimeinzone: 0, #enteredzone: 0, #zonename: zonename, #player: player
        };
        function_ccd9e1fe8ed10c13(spatialzonecontainer, spatialzonestruct, var_33811f0dcf8cbb6f);
      }

      var_e9e0f04ec2126b13++;
    }

    var_ab34bcc024468e14 = gettime() / 1000;
    elapsedtimeinseconds = var_ab34bcc024468e14 - var_131486eae3682d7;

    if(elapsedtimeinseconds < var_39fd075f67e1d4dc) {
      profileendevent();
      remainingtimeinseconds = var_39fd075f67e1d4dc - elapsedtimeinseconds;
      wait remainingtimeinseconds;
      function_dfd4d9fd84819c70(#"hash_86f9c9a6fb0a647e");
    } else {
      profileendevent();
      waitframe();
      function_dfd4d9fd84819c70(#"hash_86f9c9a6fb0a647e");
    }

    profileendevent();
  }
}

function private function_1293c52d696b1ff0(spatialzonecontainer, spatialzonestruct) {
  linkedspatialzonename = spatialzonestruct.linkedzonename;
  return function_840c78cc1249d102(spatialzonecontainer, linkedspatialzonename);
}

function ___zone() {}

function function_a2088660e978c06b() {}

function private function_b3d788222da68803(zonename, originfunc, originfuncparams) {
  spatialzonestruct = spawnStruct();
  spatialzonestruct.name = zonename;
  spatialzonestruct.spheres = [];
  spatialzonestruct.var_44f02924bf665f2d = undefined;
  spatialzonestruct.istrackingplayers = undefined;
  spatialzonestruct.linkedzonename = undefined;
  spatialzonestruct.var_9fb5fbb4e21c4e49 = undefined;
  spatialzonestruct.trackedplayercallbacks = undefined;

  if(isDefined(originfunc)) {
    function_9c029354a997266e(spatialzonestruct, 1, originfunc, originfuncparams);
  } else {
    function_9c029354a997266e(spatialzonestruct, 0);
  }

  return spatialzonestruct;
}

function private function_8edb8285ca1169ea(var_e2dbb702970ccf1, var_4b28c80afcdc7c37) {
  spatialzonestruct = spawnStruct();
  spatialzonestruct.name = var_e2dbb702970ccf1.name;
  spatialzonestruct.originfunc = var_e2dbb702970ccf1.originfunc;
  spatialzonestruct.originfuncparams = var_e2dbb702970ccf1.originfuncparams;
  spatialzonestruct.hasdynamicorigin = var_e2dbb702970ccf1.hasdynamicorigin;
  spatialzonestruct.spheres = [];
  spatialzonestruct.var_9fb5fbb4e21c4e49 = [];
  spatialzonestruct.istrackingplayers = undefined;
  spatialzonestruct.linkedzonename = var_e2dbb702970ccf1.linkedzonename;
  spatialzonestruct.var_44f02924bf665f2d = var_e2dbb702970ccf1.var_44f02924bf665f2d;
  spatialzonestruct.trackedplayercallbacks = var_e2dbb702970ccf1.trackedplayercallbacks;

  foreach(var_4eb7b1b88e89d428 in var_e2dbb702970ccf1.spheres) {
    spherestruct = function_aeeb1d28dcb81de7(var_4eb7b1b88e89d428, var_4b28c80afcdc7c37);
    spatialzonestruct.spheres[spatialzonestruct.spheres.size] = spherestruct;
  }

  return spatialzonestruct;
}

function function_5dd30c5d95ca5d28() {}

function private function_48a5a8521187d633(spatialzonestruct) {
  if(isDefined(spatialzonestruct.trackedplayercallbacks)) {
    return spatialzonestruct.trackedplayercallbacks;
  }

  return [];
}

function private function_3994f238ba38db55(spatialzonestruct, player) {
  if(isDefined(spatialzonestruct.var_9fb5fbb4e21c4e49)) {
    playerguid = player.guid ?? 0;
    var_e61c517ce38d67ab = spatialzonestruct.var_9fb5fbb4e21c4e49[playerguid];

    if(isDefined(var_e61c517ce38d67ab) && var_e61c517ce38d67ab != 2) {
      return var_e61c517ce38d67ab;
    }
  }

  return 2;
}

function function_35d45b07053ef7fc() {}

function private function_f6eb266a84db8821(spatialzonestruct, name) {
  assert(isstring(name), "<dev string:x49e>");
  spatialzonestruct.name = name;
}

function private function_ccf962bddba30de2(spatialzonestruct, spheres) {
  assert(isarray(spheres), "<dev string:x4da>");
  spatialzonestruct.spheres = spheres;
}

function private function_ff975354b6b397e(spatialzonestruct, linkedzonename) {
  assert(isstring(linkedzonename), "<dev string:x518>");
  spatialzonestruct.linkedzonename = linkedzonename;
}

function private function_375ef4c1392f5943(spatialzonestruct, var_44f02924bf665f2d) {
  assert(isnumber(var_44f02924bf665f2d), "<dev string:x55e>");
  assert(var_44f02924bf665f2d >= 0 && var_44f02924bf665f2d <= 1, "<dev string:x5a5>");

  if(var_44f02924bf665f2d == 1) {
    spatialzonestruct.var_44f02924bf665f2d = undefined;
    return;
  }

  spatialzonestruct.var_44f02924bf665f2d = var_44f02924bf665f2d;
}

function private function_e2802a4e6d4a94e6(spatialzonestruct, originfunc) {
  assert(isfunction(originfunc), "<dev string:x601>");
  spatialzonestruct.originfunc = originfunc;
}

function private function_c252027c9f447c0(spatialzonestruct, originfuncparams) {
  assert(isarray(originfuncparams), "<dev string:x645>");
  spatialzonestruct.originfuncparams = originfuncparams;
}

function private function_aedd59086a0e131d(spatialzonestruct, hasdynamicorigin) {
  spatialzonestruct.hasdynamicorigin = istrue(hasdynamicorigin);
}

function private function_9c029354a997266e(spatialzonestruct, hasdynamicorigin, originfunc, originfuncparams) {
  if(istrue(hasdynamicorigin)) {
    function_e2802a4e6d4a94e6(spatialzonestruct, originfunc);
    function_c252027c9f447c0(spatialzonestruct, originfuncparams);
    function_aedd59086a0e131d(spatialzonestruct, hasdynamicorigin);
    return;
  }

  spatialzonestruct.originfunc = undefined;
  spatialzonestruct.originfuncparams = undefined;
  function_aedd59086a0e131d(spatialzonestruct, hasdynamicorigin);
}

function private function_634aab85c1008c01(spatialzonestruct, player, state) {
  if(!isDefined(spatialzonestruct.var_9fb5fbb4e21c4e49)) {
    spatialzonestruct.var_9fb5fbb4e21c4e49 = [];
  }

  playerguid = player.guid ?? 0;
  spatialzonestruct.var_9fb5fbb4e21c4e49[playerguid] = state;
}

function private function_207d0188ad2a9a89(spatialzonestruct, trackingplayers) {
  if(istrue(trackingplayers)) {
    spatialzonestruct.istrackingplayers = 1;
    return;
  }

  spatialzonestruct.istrackingplayers = undefined;
}

function function_2ece52462211da46() {}

function private function_18eca16d012d3b82(spatialzonestruct, callbackfunc) {
  if(!isfunction(callbackfunc)) {
    zonename = spatialzonestruct.name;
    assert(isfunction(callbackfunc), "<dev string:x68c>" + zonename + "<dev string:x6be>");

    return;
  }

  if(!isDefined(spatialzonestruct.trackedplayercallbacks)) {
    spatialzonestruct.trackedplayercallbacks = [];
  }

  spatialzonestruct.trackedplayercallbacks[spatialzonestruct.trackedplayercallbacks.size] = callbackfunc;
}

function private function_ccd9e1fe8ed10c13(spatialzonecontainer, spatialzonestruct, var_33811f0dcf8cbb6f) {
  trackedplayercallbacks = function_48a5a8521187d633(spatialzonestruct);

  foreach(callbackfunc in trackedplayercallbacks) {
    spatialzonecontainer thread[[callbackfunc]](var_33811f0dcf8cbb6f);
  }
}

function private function_ac787cbee340df1(spatialzonestruct, spherestruct) {
  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    zonename = spatialzonestruct.name;
    linkedzonename = spatialzonestruct.linkedzonename;
    assertmsg("<dev string:x6f4>" + zonename + "<dev string:x713>" + linkedzonename + "<dev string:x742>");

    return;
  }

  spatialzonestruct.spheres[spatialzonestruct.spheres.size] = spherestruct;

  if(istrue(spatialzonestruct.hasdynamicorigin)) {
    dynamicorigin = function_75263756d8f9211b(spatialzonestruct);
    function_92641fb138d349d3(spherestruct, dynamicorigin);
  }
}

function private function_d9685670b95503ce(spatialzonestruct, spherestruct) {
  if(function_c5e6cfd6b72f1628(spatialzonestruct)) {
    zonename = spatialzonestruct.name;
    linkedzonename = spatialzonestruct.linkedzonename;
    assertmsg("<dev string:x6f4>" + zonename + "<dev string:x713>" + linkedzonename + "<dev string:x77d>");

    return;
  }

  spherefound = utility::array_find(spatialzonestruct.spheres, spherestruct);
  assert(isDefined(spherefound), "<dev string:x7bd>" + spatialzonestruct.name + "<dev string:x7df>");

  spatialzonestruct.spheres = arrayremove(spatialzonestruct.spheres, spherestruct);
}

function private function_c5e6cfd6b72f1628(spatialzonestruct) {
  return isDefined(spatialzonestruct.linkedzonename);
}

function private function_75263756d8f9211b(spatialzonestruct) {
  spatialzonename = spatialzonestruct.name;
  hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
  assert(istrue(hasdynamicorigin), "<dev string:x810>" + spatialzonename + "<dev string:x827>");

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

  assertmsg("<dev string:x857>");
}

function private function_1e9aef45b1953ed5() {
  return (0, 0, 0);
}

function function_576c1559ee964b44() {}

function function_ed4700be9613468b() {}

function function_4e71ca577d4d6ad9(spatialzonespherestruct) {
  var_4b28c80afcdc7c37 = spatialzonespherestruct.var_4b28c80afcdc7c37;
  associatedspatialzonename = spatialzonespherestruct.associatedspatialzonename;
  spatialzonestruct = function_840c78cc1249d102(var_4b28c80afcdc7c37, associatedspatialzonename);
  hasdynamicorigin = spatialzonestruct.hasdynamicorigin;

  if(istrue(hasdynamicorigin)) {
    dynamicorigin = function_75263756d8f9211b(spatialzonestruct);

    if(isDefined(spatialzonespherestruct.originoffset)) {
      sphereoriginoffset = spatialzonespherestruct.originoffset;
      dynamicorigin += sphereoriginoffset;
    }

    return dynamicorigin;
  }

  return spatialzonespherestruct.origin;
}

function function_49eb13996d2d23ed(spatialzonespherestruct) {
  if(isDefined(spatialzonespherestruct.radius)) {
    return spatialzonespherestruct.radius;
  }

  return 0;
}

function function_10d38bdfc220f832() {}

function private function_34a76480600d9ea2(var_4b28c80afcdc7c37, associatedspatialzonename, origin, radius, ignoreheightvalue) {
  spatialzonespherestruct = spawnStruct();
  spatialzonespherestruct.associatedspatialzonename = associatedspatialzonename;
  spatialzonespherestruct.var_4b28c80afcdc7c37 = var_4b28c80afcdc7c37;
  spatialzonespherestruct.origin = origin;
  spatialzonespherestruct.originoffset = undefined;
  spatialzonespherestruct.radius = istrue(radius) ? radius : undefined;
  spatialzonespherestruct.shouldignoreheight = istrue(ignoreheightvalue) ? ignoreheightvalue : undefined;
  return spatialzonespherestruct;
}

function private function_aeeb1d28dcb81de7(var_a8fb612ee2812e8, var_4b28c80afcdc7c37) {
  spatialzonespherestruct = spawnStruct();
  spatialzonespherestruct.associatedspatialzonename = var_a8fb612ee2812e8.associatedspatialzonename;
  spatialzonespherestruct.var_4b28c80afcdc7c37 = var_4b28c80afcdc7c37;
  spatialzonespherestruct.origin = var_a8fb612ee2812e8.origin;
  spatialzonespherestruct.radius = var_a8fb612ee2812e8.radius;
  spatialzonespherestruct.originoffset = var_a8fb612ee2812e8.originoffset;
  spatialzonespherestruct.shouldignoreheight = var_a8fb612ee2812e8.shouldignoreheight;
  return spatialzonespherestruct;
}

function function_b903c2b059c3eabf() {}

function private function_92641fb138d349d3(spherestruct, relativeorigin) {
  sphereorigin = spherestruct.origin;

  if(isDefined(sphereorigin)) {
    spherestruct.originoffset = spherestruct.origin - relativeorigin;
  }
}

function private function_a50cc6d1ad1eef1b(spatialzonespherestruct) {
  radius = function_49eb13996d2d23ed(spatialzonespherestruct);
  origin = function_4e71ca577d4d6ad9(spatialzonespherestruct);
  return function_7b56e68d559af704(origin, radius);
}

function private function_7b56e68d559af704(origin, radius) {
  return utility::callsharedfunc(#"spatial_zone", #"couldplayersbenearspatialzonesphere", origin, radius);
}

function function_9056e6553812ac62() {}

function function_ddad9fecfab84430() {}

function private function_205355139407173(groupuniquename) {
  var_5646f6535b64605a = spawnStruct();
  var_5646f6535b64605a.var_71ebe3f8c3f0cb66 = [];
  var_5646f6535b64605a.groupuniquename = groupuniquename;
  return var_5646f6535b64605a;
}

function function_5a14327c63798239() {}

function private function_c4e67667bc912b92(var_5646f6535b64605a, spatialzonecontainer, player) {
  groupeduniquename = var_5646f6535b64605a.groupuniquename;
  playerguid = player.guid ?? 0;

  if(isDefined(spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename][playerguid])) {
    return spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename][playerguid];
  }

  return 2;
}

function function_cac73a4548745a35() {}

function private function_ddc31ec984ca0b26(var_5646f6535b64605a, spatialzonecontainer, player, state) {
  groupeduniquename = var_5646f6535b64605a.groupuniquename;
  var_d48baaab96eda29b = spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename];
  playerguid = player.guid ?? 0;

  if(state == 2) {
    spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename][playerguid] = undefined;
    return;
  }

  spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename][playerguid] = state;
}

function function_47a1150fbe3d6bd() {}

function private function_6201004edbc26fad(var_5646f6535b64605a) {
  if(!isDefined(level.var_16842167ea38b901)) {
    level.var_16842167ea38b901 = [];
  }

  groupuniquename = var_5646f6535b64605a.groupuniquename;
  level.var_16842167ea38b901[groupuniquename] = var_5646f6535b64605a;
}

function private function_d24b81ba44d6188c(groupuniquename) {
  if(isDefined(level.var_16842167ea38b901) && isDefined(level.var_16842167ea38b901[groupuniquename])) {
    return true;
  }

  return false;
}

function private function_790b43129cb6ed2a(spatialzonecontainer, var_5646f6535b64605a, var_33811f0dcf8cbb6f) {
  foreach(var_6955bdf879add383 in var_5646f6535b64605a.var_71ebe3f8c3f0cb66) {
    spatialzonecontainer thread[[var_6955bdf879add383]](var_33811f0dcf8cbb6f);
  }
}

function private function_f86f3e6612ea5991(var_5646f6535b64605a, spatialzonecontainer) {
  if(!isDefined(spatialzonecontainer.var_d48baaab96eda29b)) {
    spatialzonecontainer.var_d48baaab96eda29b = [];
  }

  groupeduniquename = var_5646f6535b64605a.groupuniquename;

  if(!isDefined(spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename])) {
    spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename] = [];
  }
}

function private function_71aeee461af3fa0(var_5646f6535b64605a, spatialzonecontainer) {
  if(!isDefined(spatialzonecontainer.var_d48baaab96eda29b)) {
    return false;
  }

  groupeduniquename = var_5646f6535b64605a.groupuniquename;

  if(!isDefined(spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename])) {
    return false;
  }

  return true;
}

function private function_414def5c93d0cf00(var_6f9f78cc587ed65c, var_5646f6535b64605a, zonename, var_5c202893abc9b40e) {
  groupuniquename = var_5646f6535b64605a.groupuniquename;
  var_5646f6535b64605a endon("\xe27\xda\xcb\xb2\x85\xe6n\xcbJ\xee\xa7K\x1d\x8aw|\fb\x10\xeb\xd4W*\xe7\xff" + groupuniquename);
  var_f4f512ccc0d7d431 = var_5c202893abc9b40e ?? 2;

  while(true) {
    if(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
      continue;
    }

    var_b8e9fe5358d46b5e = self[[var_6f9f78cc587ed65c]]();
    var_ae1a1edf30221513 = level.players;
    var_1b876b5c07f8a442 = var_ae1a1edf30221513.size;
    var_d7cccadacd04fb94 = var_b8e9fe5358d46b5e.size;
    var_8766de8253aaf099 = var_1b876b5c07f8a442 * var_d7cccadacd04fb94;
    var_641b7c2af02d962a = max(var_f4f512ccc0d7d431 / level.framedurationseconds, 1);
    var_e284053f09e8b6ae = max(var_8766de8253aaf099 / var_641b7c2af02d962a, 1);
    var_e284053f09e8b6ae = ceil(var_e284053f09e8b6ae);
    var_c35c44abd0e46b03 = gettime() / 1000;
    var_e9e0f04ec2126b13 = 0;

    foreach(spatialzonecontainer in var_b8e9fe5358d46b5e) {
      if(!isDefined(spatialzonecontainer) || !function_a2f5a6979eb10328(spatialzonecontainer, zonename)) {
        continue;
      }

      if(!function_71aeee461af3fa0(var_5646f6535b64605a, spatialzonecontainer)) {
        function_f86f3e6612ea5991(var_5646f6535b64605a, spatialzonecontainer);
      }

      var_6083fc60ddcfda2e = 0;
      var_e9557f450b9c3fa = 0;
      var_d395f61594eed249 = var_ae1a1edf30221513.size;

      while(var_d395f61594eed249 > 0) {
        var_e33fc5af6c2f67ef = 0;
        var_90fd46670bcb91dc = var_e284053f09e8b6ae - var_e9e0f04ec2126b13;
        var_da5169c5df833699 = min(var_6083fc60ddcfda2e + var_90fd46670bcb91dc - 1, var_ae1a1edf30221513.size - 1);
        var_da5169c5df833699 = int(var_da5169c5df833699);
        function_f991815058f4a2d(var_ae1a1edf30221513, var_6083fc60ddcfda2e, var_da5169c5df833699, var_5646f6535b64605a, spatialzonecontainer, zonename);
        var_e33fc5af6c2f67ef = var_da5169c5df833699 - var_6083fc60ddcfda2e + 1;
        var_e9557f450b9c3fa += var_e33fc5af6c2f67ef;
        var_d395f61594eed249 -= var_e9557f450b9c3fa;
        var_e9e0f04ec2126b13 += var_e33fc5af6c2f67ef;
        var_6083fc60ddcfda2e = var_da5169c5df833699 + 1;

        if(var_e9e0f04ec2126b13 >= var_e284053f09e8b6ae) {
          waitframe();
          var_e9e0f04ec2126b13 = 0;
        }
      }

      var_da000a1becddaf38 = gettime() / 1000;
      var_c7bfca4078e4a0e5 = var_da000a1becddaf38 - var_c35c44abd0e46b03;

      if(var_c7bfca4078e4a0e5 < var_f4f512ccc0d7d431) {
        var_d6da6ebbb3508a41 = var_f4f512ccc0d7d431 - var_c7bfca4078e4a0e5;
        wait var_d6da6ebbb3508a41;
        continue;
      }

      waitframe();
    }

    waitframe();
  }
}

function private function_f991815058f4a2d(playerlist, startingplayerindex, endingplayerindex, var_5646f6535b64605a, spatialzonecontainer, zonename, var_d7965e5102a3c3b9) {
  assert(startingplayerindex <= endingplayerindex && startingplayerindex >= 0, "<dev string:x903>");
  assert(endingplayerindex < playerlist.size, "<dev string:x967>");
  assert(function_a2f5a6979eb10328(spatialzonecontainer, zonename), "<dev string:x263>" + zonename + "<dev string:x26d>");

  if(!isDefined(var_d7965e5102a3c3b9)) {
    var_d7965e5102a3c3b9 = 1;
  }

  var_ebe2230b75ef39ab = function_d155afd969a2a226(spatialzonecontainer, zonename);
  var_40c04bcb3959ffe1 = [];

  for(playerindex = startingplayerindex; playerindex <= endingplayerindex; playerindex++) {
    player = playerlist[playerindex];
    playerguid = player.guid ?? 0;
    var_36ae14085240556c = 0;
    cachedorigins = [];
    cachedradii = [];
    skipspheres = [];

    if(istrue(var_40c04bcb3959ffe1[playerguid]) || !isPlayer(player) || !isalive(player)) {
      continue;
    }

    for(sphereindex = 0; sphereindex < var_ebe2230b75ef39ab.size; sphereindex++) {
      if(istrue(skipspheres[sphereindex])) {
        continue;
      }

      spatialzonespherestruct = var_ebe2230b75ef39ab[sphereindex];
      shouldignoreheight = istrue(spatialzonespherestruct.shouldignoreheight);

      if(!isDefined(cachedorigins[sphereindex])) {
        cachedorigins[sphereindex] = function_4e71ca577d4d6ad9(spatialzonespherestruct);
      }

      if(!isDefined(cachedradii[sphereindex])) {
        cachedradii[sphereindex] = function_49eb13996d2d23ed(spatialzonespherestruct) * var_d7965e5102a3c3b9;
      }

      if(!function_7b56e68d559af704(cachedorigins[sphereindex], cachedradii[sphereindex])) {
        skipspheres[sphereindex] = 1;
        continue;
      }

      if(shouldignoreheight) {
        var_36ae14085240556c = utility::function_f52121cd5b6adecf(player, cachedorigins[sphereindex], cachedradii[sphereindex]);
        continue;
      }

      var_36ae14085240556c = utility::playerwithindistance(player, cachedorigins[sphereindex], cachedradii[sphereindex]);
    }

    var_e61c517ce38d67ab = function_c4e67667bc912b92(var_5646f6535b64605a, spatialzonecontainer, player);

    if(var_36ae14085240556c) {
      if(var_e61c517ce38d67ab != 0) {
        firsttimeinzone = var_e61c517ce38d67ab == 2;
        function_ddc31ec984ca0b26(var_5646f6535b64605a, spatialzonecontainer, player, 0);
        groupeduniquename = var_5646f6535b64605a.groupuniquename;
        var_d48baaab96eda29b = spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename];
        var_33811f0dcf8cbb6f = {
          #var_ba782b7c5f72c30d: &function_320752fa9e69e861, #var_c18845f1bf0a4e3a: var_d48baaab96eda29b, #firsttimeinzone: firsttimeinzone, #enteredzone: 1, #zonename: zonename, #player: player
        };
        function_790b43129cb6ed2a(spatialzonecontainer, var_5646f6535b64605a, var_33811f0dcf8cbb6f);
      }

      continue;
    }

    if(var_e61c517ce38d67ab == 0) {
      function_ddc31ec984ca0b26(var_5646f6535b64605a, spatialzonecontainer, player, 1);
      groupeduniquename = var_5646f6535b64605a.groupuniquename;
      var_d48baaab96eda29b = spatialzonecontainer.var_d48baaab96eda29b[groupeduniquename];
      var_33811f0dcf8cbb6f = {
        #var_ba782b7c5f72c30d: &function_320752fa9e69e861, #var_c18845f1bf0a4e3a: var_d48baaab96eda29b, #firsttimeinzone: 0, #enteredzone: 0, #zonename: zonename, #player: player
      };
      function_790b43129cb6ed2a(spatialzonecontainer, var_5646f6535b64605a, var_33811f0dcf8cbb6f);
    }
  }
}

function function_36b2575c87eb59d1() {}

function private function_320752fa9e69e861(var_71fd462de0b60a26) {
  var_d3d20534b62b4ba6 = [];

  if(isDefined(var_71fd462de0b60a26.var_c18845f1bf0a4e3a)) {
    foreach(playerzonestate in var_71fd462de0b60a26.var_c18845f1bf0a4e3a) {
      if(playerzonestate == 0) {
        player = utility::function_f7df1adc31ff406e(playerguid);

        if(isDefined(player) && isPlayer(player)) {
          var_d3d20534b62b4ba6[var_d3d20534b62b4ba6.size] = player;
        }
      }
    }
  }

  return var_d3d20534b62b4ba6;
}