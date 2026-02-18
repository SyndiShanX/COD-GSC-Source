/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_340a2e805e35f7a2.gsc
***********************************************/

#using script_1160d62024d6945b;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\struct;
#using scripts\core_common\territory;
#using scripts\core_common\territory_util;
#using scripts\core_common\vehicles\player_vehicle;
#namespace namespace_65181344;

function private function_2c4d3d40() {
  function_4233b851();
  level.var_de3d5d56 = [];
  var_3a1737b4 = getscriptbundles(#"itemspawnentry");
  var_cce250bc = function_d634ed59();
  index = 0;
  offsetorigin = (0, 0, -64000);

  foreach(var_1461de43, var_28f8f6a9 in var_3a1737b4) {
    if(isDefined(level.var_de3d5d56)) {
      level.var_de3d5d56[var_1461de43] = var_28f8f6a9;
    }

    function_43cd95f4(index, var_1461de43);
    function_54ca5536(index, 1);
    function_b97dfce0(index, offsetorigin);
    index++;

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }
}

function private function_440f0490(itemlistbundle) {
  assert(isDefined(itemlistbundle) && itemlistbundle.type === "<dev string:x38>");
  assert(itemlistbundle.itemlist.size > 0, "<dev string:x4e>" + itemlistbundle.name + "<dev string:x65>");

  if(itemlistbundle.itemlist.size <= 0) {
    return;
  }

  weights = [];
  weighttotal = 0;

  for(rowindex = 0; rowindex < itemlistbundle.itemlist.size; rowindex++) {
    if(!isDefined(itemlistbundle.itemlist[rowindex].itementry)) {
      continue;
    }

    var_35843db5 = isDefined(itemlistbundle.itemlist[rowindex].minweight) ? itemlistbundle.itemlist[rowindex].minweight : 0;
    var_ccef9e25 = isDefined(itemlistbundle.itemlist[rowindex].maxweight) ? itemlistbundle.itemlist[rowindex].maxweight : 0;
    minweight = int(min(var_35843db5, var_ccef9e25));
    maxweight = int(max(var_35843db5, var_ccef9e25));
    diff = maxweight - minweight;
    randomint = function_d59c2d03(diff + 1);
    weight = randomint + minweight;
    weights[weights.size] = weight;
    weighttotal += weight;
  }

  if(weighttotal <= 0) {
    return;
  }

  rollchance = function_d59c2d03(weighttotal);
  currentweight = 0;

  for(weightindex = 0; weightindex < weights.size; weightindex++) {
    if(!isDefined(itemlistbundle.itemlist[weightindex].itementry)) {
      continue;
    }

    currentweight += weights[weightindex];

    if(rollchance <= currentweight) {
      itemlistbundle = getscriptbundle(itemlistbundle.itemlist[weightindex].itementry);
      assert(itemlistbundle.type === "<dev string:x72>");
      break;
    }
  }

  return itemlistbundle;
}

function private function_6a5c090c() {
  level.var_de3d5d56 = undefined;
}

function function_9e9f43cd() {
  if(!level flag::get(#"hash_67b445a4b1d59922")) {
    assert(0);
    return;
  }

  foreach(targetname, points in level.var_1d777960) {
    for(index = 0; index < points.size; index++) {
      origin = points[index].origin;
      angles = points[index].angles;
      position = origin;
      function_53a81463(position, angles, targetname, #"");
    }

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }
}

function function_e88ecf7f() {
  if(!level flag::get(#"hash_67b445a4b1d59922")) {
    assert(0);
    return;
  }

  assert(level.var_bf9b06d3.size == level.var_8d50adaa.size);

  for(index = 0; index < level.var_bf9b06d3.size; index++) {
    points = function_abaeb170(level.var_bf9b06d3[index], undefined, undefined, level.var_8d50adaa[index], undefined, 0);

    for(pointindex = 0; pointindex < points.size; pointindex++) {
      function_b2cf8bc6(points[pointindex].id, #"");

      if(isDefined(points[pointindex].targetname)) {
        level.var_28cd0b1f[points[pointindex].targetname] = 1;
      }
    }

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }
}

function private function_35461e5f(index, row, stashitem = 0, falling = 2) {
  items = [];
  item_name = self.itemlistbundle.itemlist[row].itementry;
  item = function_62c0d32d(index, item_name, stashitem, falling);

  if(isDefined(item)) {
    items[items.size] = item;
  }

  for(index = 1; index <= 5; index++) {
    item_name = self.itemlistbundle.itemlist[row].("childitementry_" + index);

    if(!isDefined(item_name)) {
      continue;
    }

    item = function_62c0d32d(index + items.size, item_name, stashitem, falling);

    if(isDefined(item)) {
      items[items.size] = item;
    }
  }

  return items;
}

function private function_62c0d32d(index, item_name, stashitem = 0, falling = 2) {
  if(isDefined(item_name) && isDefined(level.var_4afb8f5a[item_name])) {
    item_name = level.var_4afb8f5a[item_name];
  }

  if(isDefined(item_name) && isDefined(level.var_a332ae5f[item_name])) {
    var_8ac22deb = [[level.var_a332ae5f[item_name]]]();

    if(isDefined(var_8ac22deb)) {
      item_name = var_8ac22deb;
    }
  }

  if(!isDefined(item_name) || item_name == "") {
    return;
  }

  itemspawnpoint = function_4ba8fde(item_name);

  if(!isDefined(itemspawnpoint)) {
    return;
  }

  origin = (0, 0, 0);
  angles = (0, 0, 0);

  if(!stashitem) {
    origin = self.origin;
    angles = self.angles;
  }

  itementry = isDefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);
  var_e91aba42 = undefined;

  if(item_world_util::function_6daf3c87(itementry)) {
    weaponinfo = item_world_util::function_4ea13733(itementry);

    if(isDefined(weaponinfo)) {
      weapon = weaponinfo.weapon;
      var_e91aba42 = weaponinfo.var_fd90b0bb;
    }
  } else if(isDefined(itementry.random_attachments) || isDefined(itementry.var_3e805062)) {
    weapon = function_67456242(itementry);
  } else {
    weapon = item_world_util::function_35e06774(itementry, isDefined(itementry.attachments));
  }

  itemcount = isDefined(itementry.amount) ? itementry.amount : 1;
  var_aec6fa7f = 0;

  if(itementry.itemtype == # "weapon") {
    var_aec6fa7f = itementry.amount * weapon.clipsize;
  } else if(itementry.itemtype == # "armor" || itementry.itemtype == # "ammo") {
    var_aec6fa7f = itementry.amount;
    itemcount = 1;
  }

  item = item_drop::function_fd9026e4(index, weapon, itemcount, var_aec6fa7f, itemspawnpoint.id, origin, angles, falling, stashitem, undefined, undefined, undefined, undefined, undefined, undefined, var_e91aba42);

  if(isDefined(item)) {
    item.spawning = 1;
  }

  if(isDefined(itementry.spawnsound)) {
    playsoundatposition(itementry.spawnsound, origin);
  }

  return item;
}

function private function_98013deb(row) {
  numchildren = 0;

  for(index = 1; index <= 5; index++) {
    item_name = self.itemlistbundle.itemlist[row].("childitementry_" + index);

    if(isDefined(item_name)) {
      numchildren++;
    }
  }

  return numchildren;
}

function private _spawn_item(point, row, stashitem = 0) {
  if(!isDefined(point)) {
    return;
  }

  item_name = self.itemlistbundle.itemlist[row].itementry;

  if(isDefined(item_name) && isDefined(level.var_4afb8f5a[item_name])) {
    item_name = level.var_4afb8f5a[item_name];
  }

  if(!isDefined(item_name) || item_name == "") {
    function_43cd95f4(point.id, "");

    if(!isDefined(level.var_d80c35aa[# "blank"])) {
      level.var_d80c35aa[# "blank"] = 0;
    }

    level.var_d80c35aa[# "blank"]++;

    return;
  }

  itementry = isDefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);

  if(!stashitem && isDefined(itementry) && isDefined(itementry.itemtype)) {
    if(!isDefined(level.var_d80c35aa[itementry.itemtype])) {
      level.var_d80c35aa[itementry.itemtype] = 0;
    }

    level.var_d80c35aa[itementry.itemtype]++;
  }

  if(!isDefined(itementry) || !isDefined(itementry.itemtype) || itementry.itemtype == # "blank") {
    function_43cd95f4(point.id, "");
    return;
  } else if(itementry.itemtype == # "vehicle") {
    ground_pos = bulletTrace(point.origin + (0, 0, 128), point.origin - (0, 0, 128), 0, undefined, 1);

    if(ground_pos[# "surfacetype"] == "water" || ground_pos[# "surfacetype"] == "watershallow") {
      ground_pos = bulletTrace(point.origin + (0, 0, 2048), point.origin - (0, 0, 2048), 0, undefined, 1);
    }

    spawnpoint = ground_pos[# "position"] + (0, 0, 36);
    vehicle = undefined;

    if(item_world_util::function_74e1e547(spawnpoint) && territory::is_inside(spawnpoint)) {
      params = spawnStruct();
      params.origin = point.origin;
      var_b9c86846 = getscriptbundle(item_name);
      params.var_45e1ab0 = spawnStruct();
      params.var_45e1ab0.presetname = var_b9c86846.var_423d0316;
      vehicle = namespace_d0eacb0d::function_f863c07e(itementry.vehicle, spawnpoint, point.angles, &player_vehicle::function_934f56ec, params);
    }

    if(isDefined(vehicle)) {
      level.item_vehicles[level.item_vehicles.size] = vehicle;
      level.var_8819644a[level.var_8819644a.size] = {
        #origin: vehicle.origin, #vehicletype: vehicle.vehicletype, #vehicle: vehicle, #used: 0
      };
    }

    function_43cd95f4(point.id, "");

    level.var_f2db6a7f++;

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }

    return;
  } else if(!sessionmodeiszombiesgame() && is_true(getgametypesetting(#"hash_36c2645732ad1c3b"))) {
    return;
  }

  numchildren = self function_98013deb(row);

  if(!stashitem) {
    origin = point.origin;
    angles = point.angles;

    if(numchildren > 0) {
      if(!isDefined(itementry.wallbuyitem)) {
        angles = (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0);
        forward = anglesToForward(angles) * level.raw\spanish\sound\vox\scripted\hrt\vox_hr0_attack_grenade_000.SN60.xenon.snd[0];
        offset = rotatepoint(forward, (0, level.var_cc113617[0], 0));
        origin += offset;
        ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
        origin = ground_pos[# "position"];
        normal = ground_pos[# "normal"];
        angles = function_c1fa62a2(angles, normal);
      }
    } else if(!isDefined(itementry.wallbuyitem)) {
      angles = combineangles(angles, (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0));
    } else {
      angles = (0, angles[1], 0);
    }

    angles = combineangles(angles, (isDefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isDefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isDefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));
    originoffset = (isDefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0, isDefined(itementry.positionoffsety) ? itementry.positionoffsety : 0, isDefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0);
    origin += originoffset;

    if(numchildren > 0 || isDefined(itementry.wallbuyitem)) {
      point = function_53a81463(origin, angles, point.targetname, item_name);
    } else {
      function_b97dfce0(point.id, origin);
      function_3eab95b5(point.id, angles);
      point.angles = angles;
    }
  }

  function_43cd95f4(point.id, item_name);

  if(isDefined(itementry.random_attachments) || isDefined(itementry.var_3e805062)) {
    function_126ac556(point.id, function_67456242(itementry));
  }

  if(stashitem) {
    function_54ca5536(point.id, -1);
  }

  if(stashitem) {
    if(isDefined(itementry.itemtype) && !isDefined(level.var_ecf16fd3[itementry.itemtype])) {
      level.var_ecf16fd3[itementry.itemtype] = 0;
      level.var_ecf16fd3[itementry.itemtype]++;
      level.var_2850ef5++;
    }
  } else {
    level.var_136445c0++;
  }

  if(numchildren > 0) {
    for(index = 1; index <= 5; index++) {
      item_name = self.itemlistbundle.itemlist[row].("childitementry_" + index);

      if(isDefined(item_name)) {
        function_f0e5262b(item_name, point, index, stashitem, point.targetname);
      }
    }
  }
}

function private function_f0e5262b(item_name, point, childindex, stashitem = 0, targetname) {
  if(isDefined(level.var_4afb8f5a[item_name])) {
    item_name = level.var_4afb8f5a[item_name];
  }

  itementry = isDefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);
  offset = (0, 0, 0);
  angles = (0, 0, 0);
  origin = point.origin;

  if(!stashitem) {
    assert(childindex > 0 && childindex <= 5);
    parentangles = (0, point.angles[1], 0);
    degree = level.var_cc113617[childindex];
    distance = level.raw\spanish\sound\vox\scripted\hrt\vox_hr0_attack_grenade_000.SN60.xenon.snd[childindex];
    offset = (cos(degree) * distance, sin(degree) * distance, 0);
    offset = rotatepoint(offset, parentangles);
    origin += offset;
    ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
    var_f05b52fe = (isDefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0, isDefined(itementry.positionoffsety) ? itementry.positionoffsety : 0, isDefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0);
    origin = ground_pos[# "position"] + var_f05b52fe;
    normal = ground_pos[# "normal"];
    angles += (0, level.var_82e94a26[childindex], 0);
    angles += (0, point.angles[1], 0);
    angles = function_c1fa62a2(angles, normal);
    angles = combineangles(angles, (isDefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isDefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isDefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }

  var_23972ae0 = function_53a81463(origin, angles, targetname, item_name);

  if(stashitem) {
    function_54ca5536(var_23972ae0.id, -1);
  }

  if(stashitem) {
    if(isDefined(itementry.itemtype) && !isDefined(level.var_ecf16fd3[itementry.itemtype])) {
      level.var_ecf16fd3[itementry.itemtype] = 0;
      level.var_ecf16fd3[itementry.itemtype]++;
      level.var_2850ef5++;
    }

    return;
  }

  if(isDefined(itementry.itemtype) && !isDefined(level.var_8d9ad8e8[itementry.itemtype])) {
    level.var_8d9ad8e8[itementry.itemtype] = 0;
    level.var_8d9ad8e8[itementry.itemtype]++;
    level.var_5720c09a++;
  }
}

function private function_ea39d1fa(stash) {
  stash.var_aa9f8f87 = self.scriptbundlename;
  var_aa9f8f87 = self.itemlistbundle;

  if(isDefined(var_aa9f8f87) && isDefined(level.var_fb9a8536[var_aa9f8f87.name])) {
    var_aa9f8f87 = getscriptbundle(level.var_fb9a8536[var_aa9f8f87.name]);
  }

  var_eff83f3 = var_aa9f8f87;

  if(isDefined(level.var_93c59949[var_aa9f8f87.name])) {
    var_cf36f90d = level.var_93c59949[var_aa9f8f87.name];

    for(index = 0; index < var_cf36f90d.size; index++) {
      randindex = function_d59c2d03(var_cf36f90d.size);
      var_ec7042e9 = var_cf36f90d[index];
      var_cf36f90d[index] = var_cf36f90d[randindex];
      var_cf36f90d[randindex] = var_ec7042e9;
    }

    foreach(var_ee110db8 in var_cf36f90d) {
      if(isDefined(var_ee110db8.var_52a66db0)) {
        if(stash.targetname !== var_ee110db8.var_52a66db0) {
          continue;
        }
      }

      if(var_ee110db8.count == 0) {
        continue;
      }

      var_1dd9b7f1 = getscriptbundle(var_ee110db8.replacement);

      if(var_1dd9b7f1.type !== # "itemspawnlist") {
        assert(0, "<dev string:x83>" + var_ee110db8);
        continue;
      }

      var_eff83f3 = var_1dd9b7f1;
      self.itemlistbundle = var_eff83f3;

      if(var_ee110db8.count > 0) {
        var_ee110db8.count--;
      }

      break;
    }
  }

  stash.itemlistbundle = var_eff83f3;

  if(is_true(var_eff83f3.var_4f220d03)) {
    if(isDefined(stash.targetname)) {
      function_f0e5262b(#"hash_b52c813369f685d", stash, -1, 1, stash.targetname);
      spawncount = 0;

      for(row = 0; row < var_eff83f3.itemlist.size; row++) {
        available = isDefined(var_eff83f3.itemlist[row].available) ? var_eff83f3.itemlist[row].available : 0;
        available = int(max(available, 0));
        spawncount += available;
      }

      stash.available = spawncount;
    } else {
      assert(0);
    }
  } else {
    var_f16b79a = 0;

    for(row = 0; row < var_eff83f3.itemlist.size; row++) {
      if(!isDefined(var_eff83f3.itemlist[row].itementry)) {
        continue;
      }

      itemlistbundle = getscriptbundle(var_eff83f3.itemlist[row].itementry);

      if(itemlistbundle.name == "defaultscriptbundle") {
        continue;
      }

      var_bbe618cc = itemlistbundle.type == # "itemspawnlist" || itemlistbundle.type == # "itemspawnlistalias";
      available = isDefined(var_eff83f3.itemlist[row].available) ? var_eff83f3.itemlist[row].available : 0;
      var_8107154f = [];

      do {
        point = function_53a81463(stash.origin + stash.centeroffset, stash.angles, isDefined(stash.targetname) ? stash.targetname : stash.target, "");
        var_8107154f[var_8107154f.size] = point.id;

        if(!var_bbe618cc) {
          _spawn_item(point, row, 1);
        }

        available--;
      }
      while(available > 0);

      if(var_bbe618cc) {
        if(itemlistbundle.type == # "itemspawnlistalias") {
          var_12ab6449 = function_440f0490(itemlistbundle);

          if(!isDefined(var_12ab6449)) {
            continue;
          }

          itemlistbundle = var_12ab6449;
        }

        if(isDefined(itemlistbundle) && isDefined(level.var_fb9a8536[itemlistbundle.name])) {
          itemlistbundle = getscriptbundle(level.var_fb9a8536[itemlistbundle.name]);
        }

        itemspawnlist = spawnStruct();
        itemspawnlist.itemlistbundle = itemlistbundle;
        items = itemspawnlist function_e25c9d12(var_f16b79a, var_8107154f, var_8107154f.size, 1);
        var_f16b79a += items.size;
      }

      if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
      }
    }
  }

  self.itemlistbundle = var_aa9f8f87;
}

function private function_216a69d6(spawnchance) {
  dynents = array();

  if(isDefined(self.target)) {
    dynents = getdynentarray(self.target, 1);
  }

  if(isDefined(self.targetname)) {
    var_ed91073b = function_c79d31c4(self.targetname, 1);
    dynents = arraycombine(dynents, var_ed91073b, 0, 0);
  }

  for(index = 0; index < self.points.size; index++) {
    randindex = function_d59c2d03(self.points.size);
    tempid = self.points[index];
    self.points[index] = self.points[randindex];
    self.points[randindex] = tempid;
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  maxspawns = isDefined(self.itemlistbundle.var_9b009839) ? self.itemlistbundle.var_9b009839 : 0;
  var_418a2e03 = [];

  foreach(dynent in dynents) {
    level.item_spawn_stashes[level.item_spawn_stashes.size] = dynent;
    dynent.lootlocker = self.itemlistbundle.lootlocker;

    if(is_true(dynent.lootlocker)) {}

    randint = function_d59c2d03(100);
    shouldspawn = randint <= spawnchance;

    if(maxspawns > -1 && var_418a2e03.size >= maxspawns) {
      shouldspawn = 0;
    }

    if(shouldspawn) {
      var_418a2e03[var_418a2e03.size] = dynent;
      continue;
    }

    setdynentenabled(dynent, 0);
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  var_c041d1bd = 0;
  var_a9826383 = 0;

  for(pointindex = 0; var_c041d1bd < var_418a2e03.size; pointindex++) {
    if(var_c041d1bd >= self.points.size) {
      break;
    }

    if(pointindex >= self.points.size) {
      if(var_a9826383) {
        break;
      }

      var_a9826383 = 1;
      pointindex = 0;
    }

    if(self.points[pointindex] == -1) {
      continue;
    }

    point = function_b1702735(self.points[pointindex]);

    if(point.hidetime == -1) {
      continue;
    }

    if(isDefined(self.itemlistbundle.var_7fb0967b) && !var_a9826383) {
      var_1ba7b9c8 = arraysortclosest(level.var_5ce07338, point.origin, 1, 0, self.itemlistbundle.var_7fb0967b);

      if(var_1ba7b9c8.size > 0) {
        continue;
      }
    }

    function_54ca5536(self.points[pointindex], -1);
    self.points[pointindex] = -1;
    dynent = var_418a2e03[var_c041d1bd];
    centeroffset = (0, 0, 0);

    if(isDefined(dynent.var_15d44120)) {
      centeroffset = getxmodelcenteroffset(dynent.var_15d44120);
    }

    angleoffset = (isDefined(self.itemlistbundle.var_9b80f2b0) ? self.itemlistbundle.var_9b80f2b0 : 0, isDefined(self.itemlistbundle.var_713a9e24) ? self.itemlistbundle.var_713a9e24 : 0, isDefined(self.itemlistbundle.var_c52545f8) ? self.itemlistbundle.var_c52545f8 : 0);
    dynent.angles = combineangles(point.angles, angleoffset);
    dynent.origin = point.origin;
    dynent.centeroffset = centeroffset;
    dynent.hintstring = self.itemlistbundle.hintstring;
    dynent.displayname = self.itemlistbundle.displayname;
    dynent.var_3d685b35 = isDefined(self.itemlistbundle.var_3d685b35) ? self.itemlistbundle.var_3d685b35 : 0;
    level.var_5ce07338[level.var_5ce07338.size] = dynent;
    targetname = isDefined(dynent.targetname) ? dynent.targetname : dynent.target;

    if(!isDefined(level.var_93d08989[targetname])) {
      level.var_93d08989[targetname] = array();
    }

    var_2a4308b9 = level.var_93d08989[targetname].size;
    level.var_93d08989[targetname][var_2a4308b9] = dynent;
    setdynentenabled(dynent, 1);
    setdynentstate(dynent, 0);
    self function_ea39d1fa(dynent);
    var_c041d1bd++;
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  for(var_63d7a070 = var_c041d1bd; var_63d7a070 < var_418a2e03.size; var_63d7a070++) {
    dynent = var_418a2e03[var_63d7a070];
    setdynentenabled(dynent, 0);
  }
}

function private _spawn() {
  if(is_true(self.itemlistbundle.supplystash)) {
    self function_216a69d6(isDefined(self.itemlistbundle.supplystashweight) ? self.itemlistbundle.supplystashweight : 100);
    return;
  }

  self function_e25c9d12(0, self.var_8107154f, self.var_8107154f.size);
}

function private _setup() {
  self.itemlistbundle = getscriptbundle(self.scriptbundlename);

  if(isDefined(self.itemlistbundle) && isDefined(level.var_fb9a8536[self.itemlistbundle.name])) {
    self.itemlistbundle = getscriptbundle(level.var_fb9a8536[self.itemlistbundle.name]);
  }

  assert(isDefined(self.itemlistbundle), "<dev string:xcb>" + self.scriptbundlename + "<dev string:xdd>");

  if(!isDefined(self.itemlistbundle.itemlist)) {
    self.itemlistbundle.itemlist = [];
  }

  self.remaining = isDefined(self.count) ? self.count : 0;
  self.points = function_d0dc448b(self.target);
  self.var_8107154f = [];

  foreach(pointid in self.points) {
    self.var_8107154f[pointid] = pointid;
  }

  if(!isDefined(level.var_28cd0b1f[self.target]) && self.target !== # "hash_4f6d836b1441bd94") {}

  if(!isDefined(self.points)) {
    self.points = [];
  }
}

function private _teardown() {
  self.points = undefined;
  self.var_8107154f = undefined;
  self.itemlistbundle = undefined;
  self.angles = undefined;
  self.available = undefined;
  self.var_ccc6d5b7 = undefined;
  self.modelscale = undefined;
  self.remaining = undefined;
  self.var_3ddde668 = undefined;
  self.var_5d3a106 = undefined;
  self.var_202d2992 = undefined;
  self.rows = undefined;
  self.weights = undefined;
  self.weighttotal = undefined;
}

function function_3095d12a() {
  if(isDefined(level.var_ccc3aaf)) {
    return;
  }

  level.var_ccc3aaf = 1;
  flag::set(#"item_world_traces");
}

function private function_9db93def() {
  assert(isDefined(self.target) && self.target != "<dev string:xeb>", "<dev string:xef>" + self.origin + "<dev string:x10d>");
  assert(self.target !== self.targetname, "<dev string:xef>" + self.origin + "<dev string:x130>" + self.target + "<dev string:x16d>");
}

function private function_a8e0dc24(itementry, data, limit, var_a3a56d95, maxattachments) {
  assert(isstruct(itementry));
  assert(itementry.itemtype == # "weapon");
  assert(maxattachments >= var_a3a56d95);
  assert(isarray(data.currentattachments));
  assert(isarray(data.possibleattachments));
  assert(isarray(data.availableslots));
  attachments = data.currentattachments;

  if(maxattachments < var_a3a56d95) {
    return attachments;
  }

  possibleattachments = data.possibleattachments;
  attachmentkeys = getarraykeys(possibleattachments);

  for(index = 0; index < possibleattachments.size; index++) {
    randindex = function_d59c2d03(possibleattachments.size);
    tempid = possibleattachments[attachmentkeys[randindex]];
    possibleattachments[attachmentkeys[randindex]] = possibleattachments[attachmentkeys[index]];
    possibleattachments[attachmentkeys[index]] = tempid;
  }

  var_a3a56d95 = int(min(var_a3a56d95, possibleattachments.size));
  maxattachments = int(min(maxattachments, possibleattachments.size));
  assert(maxattachments >= var_a3a56d95);
  var_5f5def05 = var_a3a56d95;
  var_ac516129 = maxattachments - var_a3a56d95;

  if(var_ac516129 > 0) {
    var_5f5def05 += function_d59c2d03(var_ac516129);
  }

  var_5f5def05 = min(var_5f5def05, 8);
  var_5f5def05 = min(var_5f5def05, attachments.size + limit);

  for(index = 0; index < possibleattachments.size && attachments.size < var_5f5def05; index++) {
    var_41ade915 = possibleattachments[index].attachment_type;
    var_fe35755b = getscriptbundle(var_41ade915);

    if(!isstruct(var_fe35755b)) {
      assert(0);
      continue;
    }

    var_e77f982 = 1;

    foreach(slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
      if(is_true(var_fe35755b.(slot)) && !is_true(data.availableslots[slot])) {
        var_e77f982 = 0;
        break;
      }
    }

    if(!var_e77f982) {
      continue;
    }

    var_8d5b1d0 = arraycopy(attachments);

    foreach(attachment in var_fe35755b.attachments) {
      var_8d5b1d0[var_8d5b1d0.size] = attachment.attachment_type;
    }

    weapon = getweapon(itementry.weapon.name, var_8d5b1d0);
    weapon = function_1242e467(weapon);

    if(weapon.attachments.size == var_8d5b1d0.size) {
      attachments = var_8d5b1d0;

      foreach(slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
        if(is_true(var_fe35755b.(slot))) {
          data.availableslots[slot] = 0;
        }
      }
    }
  }

  return attachments;
}

function function_67456242(itementry) {
  assert(isstruct(itementry));
  assert(itementry.itemtype == # "weapon");
  assert(isDefined(itementry.random_attachments) || isDefined(itementry.var_3e805062));
  weapon = item_world_util::function_35e06774(itementry, 1);
  attachments = weapon.attachments;
  availableslots = [];

  foreach(slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
    availableslots[slot] = is_true(itementry.(slot));
  }

  foreach(attachment in attachments) {
    var_41ade915 = item_world_util::function_6a0ee21a(attachment);
    var_fe35755b = getscriptbundle(var_41ade915);

    if(!isstruct(var_fe35755b)) {
      assert(0);
      continue;
    }

    foreach(slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
      if(is_true(var_fe35755b.(slot))) {
        availableslots[slot] = 0;
      }
    }
  }

  var_a3a56d95 = isDefined(itementry.var_8e212f46) ? itementry.var_8e212f46 : 0;
  maxattachments = isDefined(itementry.var_d0e99a2a) ? itementry.var_d0e99a2a : 0;
  assert(maxattachments >= var_a3a56d95);
  data = spawnStruct();
  data.currentattachments = attachments;
  data.availableslots = availableslots;

  if(isDefined(itementry.var_3e805062)) {
    data.possibleattachments = itementry.var_3e805062;
    data.currentattachments = function_a8e0dc24(itementry, data, 1, var_a3a56d95, maxattachments);
    weapon = getweapon(itementry.weapon.name, data.currentattachments);
    weapon = function_1242e467(weapon);
  }

  if(isDefined(itementry.random_attachments)) {
    data.possibleattachments = itementry.random_attachments;
    data.currentattachments = function_a8e0dc24(itementry, data, 2147483647, var_a3a56d95, maxattachments);
    weapon = getweapon(itementry.weapon.name, data.currentattachments);
    weapon = function_1242e467(weapon);
  }

  return weapon;
}

function private function_e25c9d12(var_f16b79a, &var_8107154f, spawncount, stashitem = 0, falling = 2, &var_a1b91de4 = undefined, var_7d55e249 = undefined) {
  if(!isstruct(self)) {
    assert(0);
    return;
  }

  if(isDefined(self.points) && isDefined(self.target)) {
    level.var_2e96a450[self.target] = self.points.size;
  }

  assert(isstruct(self));
  assert(isarray(var_8107154f));
  assert(isint(spawncount));
  assert(isDefined(self.itemlistbundle));
  assert(!is_true(self.vehiclespawner));
  assert(!is_true(self.supplystash));

  if(spawncount <= 0) {
    return;
  }

  items = [];
  self.rows = isDefined(self.itemlistbundle.itemlist.size) ? self.itemlistbundle.itemlist.size : 0;
  self.count = spawncount;
  self.var_5b4935 = [];
  self.available = [];
  self.weights = [];
  self.weighttotal = 0;

  for(row = 0; row < self.rows; row++) {
    item_name = self.itemlistbundle.itemlist[row].itementry;

    if(!isDefined(item_name) || item_name == "") {
      continue;
    }

    if(isDefined(item_name) && isDefined(level.var_4afb8f5a[item_name])) {
      item_name = level.var_4afb8f5a[item_name];
    }

    itementry = isDefined(level.var_de3d5d56) && isDefined(level.var_de3d5d56[item_name]) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);

    if(!isDefined(itementry) || itementry.name == "defaultscriptbundle") {
      self.var_5b4935[row] = 1;
    }
  }

  for(row = 0; row < self.rows; row++) {
    self.available[row] = isDefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;

    if(is_true(self.var_5b4935[row])) {
      self.available[row] = 0;
    }

    if(self.available[row] != 0) {
      var_35843db5 = isDefined(self.itemlistbundle.itemlist[row].minweight) ? self.itemlistbundle.itemlist[row].minweight : 0;
      var_ccef9e25 = isDefined(self.itemlistbundle.itemlist[row].maxweight) ? self.itemlistbundle.itemlist[row].maxweight : 0;
      minweight = int(min(var_35843db5, var_ccef9e25));
      maxweight = int(max(var_35843db5, var_ccef9e25));
      diff = maxweight - minweight;
      weight = function_d59c2d03(diff + 1) + minweight;
      self.weights[row] = weight;
      self.weighttotal += self.weights[row];
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  var_399d601b = spawncount;
  var_413b71b8 = self.weighttotal;
  self.weighttotal = 0;

  for(row = 0; row < self.rows; row++) {
    if(self.available[row] == 0) {
      continue;
    }

    if(self.available[row] < 0) {
      self.weighttotal += self.weights[row];
      continue;
    }

    points = 0;

    if(var_413b71b8 > 0 && var_399d601b > 0) {
      points = self.weights[row] / var_413b71b8 * var_399d601b;
    }

    if(points > self.available[row]) {
      self.weights[row] = 2147483647;
      spawncount -= self.available[row];
      continue;
    }

    self.weighttotal += self.weights[row];
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  self.var_202d2992 = [];
  self.var_3ddde668 = [];
  self.var_43feff59 = 0;
  self.var_5d3a106 = 0;
  totalspawncount = spawncount / max(self.weighttotal, 1);

  for(row = 0; row < self.rows; row++) {
    if(self.available[row] != 0) {
      if(self.weights[row] == 2147483647) {
        points = self.available[row];
      } else {
        points = self.weights[row] * totalspawncount;
      }

      self.var_202d2992[row] = int(floor(points));
      self.var_3ddde668[row] = int((points - self.var_202d2992[row]) * 1000);
      self.var_43feff59 += self.var_202d2992[row];
      self.var_5d3a106 += self.var_3ddde668[row];
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  arrayremovevalue(self.var_202d2992, 0, 1);
  arrayremovevalue(self.var_3ddde668, 0, 1);
  assert(self.var_43feff59 <= var_399d601b);
  var_c499a7fa = getarraykeys(self.var_3ddde668);

  if(self.var_5d3a106 > 0) {
    for(pointindex = self.var_43feff59; pointindex < spawncount && self.var_5d3a106 > 0; pointindex++) {
      randomval = function_d59c2d03(self.var_5d3a106);
      var_28ef6352 = 0;

      for(var_56c03814 = 0; var_56c03814 < self.var_3ddde668.size; var_56c03814++) {
        var_75aa5cbb = var_c499a7fa[var_c499a7fa.size - var_56c03814 - 1];

        if(self.available[var_75aa5cbb] != 0) {
          var_cc5fea3d = var_28ef6352 + self.var_3ddde668[var_75aa5cbb];

          if(var_28ef6352 <= randomval && randomval <= var_cc5fea3d) {
            self.var_5d3a106 -= self.var_3ddde668[var_75aa5cbb];
            self.var_3ddde668[var_75aa5cbb] = 0;
            self.var_202d2992[var_75aa5cbb] = (isDefined(self.var_202d2992[var_75aa5cbb]) ? self.var_202d2992[var_75aa5cbb] : 0) + 1;
            self.var_43feff59++;
            break;
          }

          var_28ef6352 = var_cc5fea3d;
        }
      }
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  assert(self.var_43feff59 <= var_399d601b);

  if(!isDefined(var_a1b91de4)) {
    var_a1b91de4 = getarraykeys(var_8107154f);

    for(index = 0; index < var_8107154f.size; index++) {
      randindex = function_d59c2d03(var_8107154f.size);
      tempid = var_8107154f[var_a1b91de4[randindex]];
      var_8107154f[var_a1b91de4[randindex]] = var_8107154f[var_a1b91de4[index]];
      var_8107154f[var_a1b91de4[index]] = tempid;
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  self.var_ccc6d5b7 = [];
  spawneditems = 0;
  var_a9826383 = 0;
  arraykeys = getarraykeys(self.var_202d2992);
  var_f5111345 = 0;

  for(pointindex = 0; var_f5111345 < arraykeys.size && spawneditems < self.count; pointindex++) {
    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }

    var_75aa5cbb = arraykeys[var_f5111345];

    if(pointindex >= var_8107154f.size) {
      assert(var_a9826383 === 0);
      var_a9826383 = 1;
      pointindex = 0;
    }

    if(var_8107154f[var_a1b91de4[pointindex]] == -1) {
      continue;
    }

    itementry = self.itemlistbundle.itemlist[var_75aa5cbb].itementry;

    if(isDefined(itementry) && itementry != "") {
      scriptbundle = isDefined(level.var_de3d5d56) && isDefined(level.var_de3d5d56[itementry]) ? level.var_de3d5d56[itementry] : getscriptbundle(itementry);

      if(isDefined(scriptbundle) && isDefined(scriptbundle.type) && (scriptbundle.type == # "itemspawnlist" || scriptbundle.type == # "itemspawnlistalias")) {
        self.var_ccc6d5b7[var_75aa5cbb] = self.var_202d2992[var_75aa5cbb];
        self.var_202d2992[var_75aa5cbb] = 0;
        var_f5111345++;
        continue;
      }
    }

    if(var_8107154f[var_a1b91de4[pointindex]] == -2) {
      spawnitems = undefined;

      if(isDefined(var_7d55e249) && isarray(var_7d55e249)) {
        self.origin = var_7d55e249[var_a1b91de4[pointindex]].origin;
      }

      spawnitems = self function_35461e5f(var_f16b79a + items.size, var_75aa5cbb, stashitem, falling);
      items = arraycombine(items, spawnitems, 1, 0);
    } else {
      itemspawnpoint = function_b1702735(var_8107154f[var_a1b91de4[pointindex]]);

      if(isDefined(self.itemlistbundle.var_7fb0967b) && !var_a9826383) {
        var_8822f354 = 0;
        itemtype = undefined;

        if(isDefined(itementry)) {
          scriptbundle = isDefined(level.var_de3d5d56) && isDefined(level.var_de3d5d56[itementry]) ? level.var_de3d5d56[itementry] : getscriptbundle(itementry);

          if(isDefined(scriptbundle)) {
            itemtype = scriptbundle.itemtype;
          }
        }

        if(isDefined(self.itemlistbundle.var_dc7ffbef) && isDefined(itemtype)) {
          if(itemtype == # "vehicle") {
            vehicles = getvehiclearray();
            nearbyvehicles = arraysortclosest(vehicles, itemspawnpoint.origin, 1, 0, self.itemlistbundle.var_7fb0967b);
            var_8822f354 = nearbyvehicles.size;
          } else {
            var_f4b807cb = function_abaeb170(itemspawnpoint.origin, undefined, undefined, self.itemlistbundle.var_7fb0967b, -1, 1, -2147483647);

            for(var_55879fe2 = 0; var_55879fe2 < var_f4b807cb.size; var_55879fe2++) {
              if(isDefined(var_f4b807cb[var_55879fe2]) && isDefined(var_f4b807cb[var_55879fe2].itementry) && var_f4b807cb[var_55879fe2].itementry.itemtype == itemtype) {
                var_8822f354++;
                break;
              }
            }

            var_f4b807cb = [];
          }
        } else {
          var_8822f354 = function_6de8969b(itemspawnpoint.origin, undefined, self.itemlistbundle.var_7fb0967b, -1, 1, -2147483647);
        }

        if(var_8822f354 > 0) {
          continue;
        }
      }

      self _spawn_item(itemspawnpoint, var_75aa5cbb, stashitem);
    }

    var_8107154f[var_a1b91de4[pointindex]] = -1;
    self.var_202d2992[var_75aa5cbb]--;
    spawneditems++;

    if(self.var_202d2992[var_75aa5cbb] == 0) {
      var_f5111345++;
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  for(index = 0; index < self.itemlistbundle.itemlist.size; index++) {
    if(!isDefined(self.var_ccc6d5b7[index])) {
      continue;
    }

    itemlist = self.itemlistbundle.itemlist[index];

    if(!isDefined(itemlist.itementry) || itemlist.itementry === "") {
      continue;
    }

    itemlistbundle = getscriptbundle(itemlist.itementry);

    if(!isDefined(itemlistbundle.type) || itemlistbundle.type != # "itemspawnlist" && itemlistbundle.type != # "itemspawnlistalias") {
      continue;
    }

    if(itemlistbundle.type == # "itemspawnlistalias") {
      var_12ab6449 = function_440f0490(itemlistbundle);

      if(!isDefined(var_12ab6449)) {
        continue;
      }

      itemlistbundle = var_12ab6449;
    }

    if(isDefined(itemlistbundle) && isDefined(level.var_fb9a8536[itemlistbundle.name])) {
      var_12ab6449 = getscriptbundle(level.var_fb9a8536[itemlistbundle.name]);

      if(!isDefined(var_12ab6449)) {
        println("<dev string:x173>" + itemlistbundle.name);
        assert(0);
        continue;
      }

      itemlistbundle = var_12ab6449;
    }

    if(isDefined(level.var_9af526f0) && itemlistbundle.name !== level.var_9af526f0 && getdvarint(#"hash_362cb8a4f269c52c", 0) == 0) {
      var_45749876 = function_d59c2d03(100);

      if(!isDefined(level.var_50cd96dc)) {
        level.var_50cd96dc = 0;
      }

      level.var_50cd96dc++;

      if(var_45749876 < (isDefined(level.var_546946af) ? level.var_546946af : 100)) {
        var_3224b39a = 0;

        if(isDefined(itemlistbundle.itemlist) && itemlistbundle.itemlist.size > 0 && isDefined(itemlistbundle.itemlist[0].itementry)) {
          var_9c6a2603 = getscriptbundle(itemlistbundle.itemlist[0].itementry);
          var_3224b39a = var_9c6a2603.type !== "itemspawnlist";
        }

        if(var_3224b39a) {
          itemlistbundle = getscriptbundle(level.var_9af526f0);
        }
      }
    }

    itemspawnlist = spawnStruct();
    itemspawnlist.itemlistbundle = itemlistbundle;
    itemspawnlist.origin = self.origin;
    itemspawnlist.angles = self.angles;
    var_4168f4f3 = itemspawnlist function_e25c9d12(var_f16b79a + items.size, var_8107154f, self.var_ccc6d5b7[index], stashitem, falling, var_a1b91de4);
    items = arraycombine(items, var_4168f4f3, 1, 0);
  }

  return items;
}

function function_62fdaf9e() {
  if(getdvarint(#"hash_68dcd0d52e11b957", 0)) {
    return;
  }

  foreach(value in struct::get_array("scriptbundle_itemspawnlist", "classname")) {
    value struct::delete();

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }
}

function init_spawn_system() {
  level.var_d0676b07 = getrealtime();
  level.var_3e9c9a35 = 30;
  function_2c4d3d40();
  function_3095d12a();
}

function reset_items() {
  originalpoints = function_c77ddcd6();

  for(pointid = 0; pointid < originalpoints; pointid++) {
    point = function_b1702735(pointid);
    itementry = point.itementry;

    if(!isDefined(itementry)) {
      continue;
    }

    origin = point.origin;
    angles = point.angles;
    angles = function_bdd10bae(angles, (isDefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isDefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isDefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));

    if(!isDefined(itementry.wallbuyitem)) {
      angles = function_bdd10bae(angles, (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0));
    }

    originoffset = ((isDefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0) * -1, (isDefined(itementry.positionoffsety) ? itementry.positionoffsety : 0) * -1, (isDefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0) * -1);
    origin += originoffset;
    function_b97dfce0(point.id, origin);
    function_3eab95b5(point.id, angles);

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }

  function_682385e7();

  if(isarray(level.item_spawn_drops)) {
    foreach(item in level.item_spawn_drops) {
      if(isDefined(item)) {
        item delete();
      }
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  level.item_spawn_drops = [];

  if(isarray(level.var_8ac64bf3)) {
    foreach(stash in level.var_8ac64bf3) {
      if(isDefined(stash)) {
        stash delete();
      }
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  level.var_8ac64bf3 = [];

  if(isarray(level.item_vehicles)) {
    foreach(vehicle in level.item_vehicles) {
      if(isDefined(vehicle)) {
        vehicle delete();
      }
    }
  }

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  level.item_vehicles = [];
  level.var_8819644a = [];
  level.item_spawn_drops = [];
}

function function_ca77960f() {
  item_spawn_groups = struct::get_array("scriptbundle_itemspawnlist", "classname");

  if(isDefined(level.var_9af526f0)) {
    var_52096b93 = spawnStruct();
    var_52096b93.scriptbundlename = level.var_9af526f0;
    var_52096b93.angles = (0, 0, 0);
    var_52096b93.origin = (0, 0, 0);
    var_52096b93.classname = "scriptbundle_itemspawnlist";
    var_52096b93.count = -1;
    var_52096b93.modelscale = 1;
    var_52096b93.target = # "hash_4f6d836b1441bd94";
    item_spawn_groups[item_spawn_groups.size] = var_52096b93;
  }

  return item_spawn_groups;
}

function function_50a2c746(&var_f38d5b52, var_87e9f374 = 0) {
  assert(isarray(var_f38d5b52));

  if(var_87e9f374) {}

  item_spawn_groups = function_ca77960f();

  foreach(group in item_spawn_groups) {
    if(!isDefined(group.target)) {
      continue;
    }

    itemlistbundle = getscriptbundle(group.scriptbundlename);

    if(isDefined(itemlistbundle) && isDefined(level.var_fb9a8536[itemlistbundle.name])) {
      itemlistbundle = getscriptbundle(level.var_fb9a8536[itemlistbundle.name]);
    }

    if(!isDefined(itemlistbundle)) {
      continue;
    }

    if(var_87e9f374) {
      if(!is_true(itemlistbundle.var_dc91e192) || !is_true(itemlistbundle.supplystash)) {
        continue;
      }
    } else if(is_true(itemlistbundle.var_dc91e192) && is_true(itemlistbundle.supplystash)) {
      continue;
    }

    if(isDefined(var_f38d5b52[group.target])) {
      if(!is_true(itemlistbundle.supplystash)) {
        continue;
      }
    }

    var_f38d5b52[group.target] = 1;
    group function_9db93def();
    group _setup();
    group _spawn();
    group _teardown();

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }

  return var_f38d5b52;
}

function private function_4233b851() {}

function setup_groups() {
  self notify("56d5c19f2e922cdc");
  self endon("56d5c19f2e922cdc");

  while(level.var_21f73755 !== 1) {
    waitframe(1);
  }

  level flag::set(#"hash_67b445a4b1d59922");
  flag::wait_till(#"item_world_traces");
  function_4233b851();

  starttime = gettime();
  level.var_d0676b07 = getrealtime();
  level.var_4afb8f5a = level.itemreplacement;

  foreach(key, value in level.var_4afb8f5a) {}

  level.var_fb9a8536 = level.var_ee110db8;

  foreach(value in level.var_fb9a8536) {}

  if(!isDefined(level.var_28cd0b1f)) {
    level.var_28cd0b1f = [];
  }

  function_e88ecf7f();
  function_9e9f43cd();
  level.item_spawn_stashes = [];
  level.var_5ce07338 = [];
  level.var_93d08989 = [];
  level.item_vehicles = [];
  level.var_8819644a = [];
  level.var_cc113617 = [-130, 50, 120, 315, 225, 270];
  level.var_82e94a26 = [1: 10, 2: -5, 3: -15, 4: 5, 5: 0];
  level.raw\spanish\sound\vox\scripted\hrt\vox_hr0_attack_grenade_000.SN60.xenon.snd = [17, 34, 32, 25, 25, 25];

  level.var_136445c0 = 0;
  level.var_d80c35aa = [];
  level.var_5720c09a = 0;
  level.var_8d9ad8e8 = [];
  level.var_2850ef5 = 0;
  level.var_ecf16fd3 = [];
  level.var_f2db6a7f = 0;

  var_f38d5b52 = [];
  function_50a2c746(var_f38d5b52, 1);

  if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
    waitframe(1);
    level.var_d0676b07 = getrealtime();
  }

  function_50a2c746(var_f38d5b52, 0);

  level.var_a7247d85 = function_8322cf16();
  level.var_66e56764 = level.var_136445c0 + level.var_5720c09a + level.var_2850ef5;
  level.var_efeab371 = [];

  foreach(type, count in level.var_d80c35aa) {
    level.var_efeab371[type] = (isDefined(count) ? count : 0) + (isDefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) + (isDefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0);
  }

  foreach(type, count in level.var_efeab371) {}

  function_62fdaf9e();
  function_6a5c090c();
  var_282e0a11 = function_d59c2d03(65536 - 1);
  item_world::function_5d4b134e(var_282e0a11);

  level.var_f1f90fd3 = float(gettime() - starttime) / 1000;
  println("<dev string:x1bd>" + var_282e0a11);
}

function function_5eada592(scriptbundlename, linkto = 1) {
  if(!isDefined(self)) {
    assert(0);
    return;
  }

  if(!isDefined(scriptbundlename)) {
    assert(0);
    return;
  }

  self.itemlistbundle = getscriptbundle(scriptbundlename);

  if(!isDefined(self.itemlistbundle)) {
    assert(0);
    return;
  }

  items = [];

  if(is_true(self.itemlistbundle.var_4f220d03)) {
    item = function_62c0d32d(0, #"hash_b52c813369f685d", 1, 1);
    items[items.size] = item;
    spawncount = 0;

    for(row = 0; row < self.itemlistbundle.itemlist.size; row++) {
      available = isDefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;
      available = int(max(available, 0));
      spawncount += available;
    }

    self.available = spawncount;
  } else {
    for(row = 0; row < self.itemlistbundle.itemlist.size; row++) {
      if(!isDefined(self.itemlistbundle.itemlist[row].itementry)) {
        continue;
      }

      itemlistbundle = getscriptbundle(self.itemlistbundle.itemlist[row].itementry);
      var_bbe618cc = itemlistbundle.type == # "itemspawnlist" || itemlistbundle.type == # "itemspawnlistalias";
      available = isDefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;
      var_8107154f = [];

      do {
        var_8107154f[var_8107154f.size] = -2;

        if(!var_bbe618cc) {
          spawnitems = function_35461e5f(items.size, row, 1, 1);
          items = arraycombine(items, spawnitems, 1, 0);
        }

        available--;
      }
      while(available > 0);

      if(var_bbe618cc) {
        if(itemlistbundle.type == # "itemspawnlistalias") {
          var_12ab6449 = function_440f0490(itemlistbundle);

          if(!isDefined(var_12ab6449)) {
            continue;
          }

          itemlistbundle = var_12ab6449;
        }

        if(isDefined(itemlistbundle) && isDefined(level.var_fb9a8536[itemlistbundle.name])) {
          itemlistbundle = getscriptbundle(level.var_fb9a8536[itemlistbundle.name]);
        }

        itemspawnlist = spawnStruct();
        itemspawnlist.itemlistbundle = itemlistbundle;
        spawnitems = itemspawnlist function_e25c9d12(items.size, var_8107154f, var_8107154f.size, 1);
        items = arraycombine(items, spawnitems, 1, 0);
      }
    }
  }

  foreach(item in items) {
    if(!isDefined(item)) {
      continue;
    }

    item.targetnamehash = self.targetname;
    item.origin = self.origin;

    if(linkto) {
      item linkto(self);
    }

    item.spawning = 0;
  }

  return items;
}

function function_ae93ad7b(scriptbundlename, points, falling = 2, var_9961d9f3) {
  if(!isDefined(scriptbundlename)) {
    assert(0);
    return;
  }

  if(!isarray(points) || points.size <= 0) {
    assert(0);
    return;
  }

  scriptbundle = getscriptbundle(scriptbundlename);

  if(!isDefined(scriptbundle)) {
    assert(0);
    return;
  }

  itemgroup = spawnStruct();
  itemgroup.itemlistbundle = scriptbundle;
  itemgroup.origin = (0, 0, 0);
  itemgroup.angles = (0, 0, 0);
  var_8107154f = [];

  for(pointid = 0; pointid < points.size; pointid++) {
    var_8107154f[var_8107154f.size] = -2;
  }

  var_a1b91de4 = getarraykeys(var_8107154f);

  for(index = 0; index < var_8107154f.size; index++) {
    randindex = function_d59c2d03(var_8107154f.size);
    tempid = var_8107154f[var_a1b91de4[randindex]];
    var_8107154f[var_a1b91de4[randindex]] = var_8107154f[var_a1b91de4[index]];
    var_8107154f[var_a1b91de4[index]] = tempid;
  }

  items = itemgroup function_e25c9d12(0, var_8107154f, var_8107154f.size, 0, falling, var_a1b91de4, points);

  foreach(item in items) {
    if(!isDefined(item)) {
      continue;
    }

    if(isDefined(var_9961d9f3) && isDefined(item.itementry)) {
      item.itementry.var_31dcb18d = var_9961d9f3;
    }

    item.spawning = 0;

    if(isentity(item) && isDefined(item.var_627c698b.attachments) && !isDefined(item.attachments)) {
      attachments = item.var_627c698b.attachments;

      foreach(attachment in attachments) {
        var_41ade915 = item_world_util::function_6a0ee21a(attachment);
        attachmentitem = function_4ba8fde(var_41ade915);
        item_inventory_util::function_8b7b98f(item, attachmentitem);
      }
    }
  }
}

function function_fd87c780(scriptbundlename, itemcount, falling = 2, var_9961d9f3) {
  if(!isDefined(self)) {
    assert(0);
    return;
  }

  if(!isDefined(scriptbundlename)) {
    assert(0);
    return;
  }

  if(!isint(itemcount) || itemcount <= 0) {
    assert(0);
    return;
  }

  scriptbundle = getscriptbundle(scriptbundlename);

  if(!isDefined(scriptbundle)) {
    assert(0);
    return;
  }

  assert(isDefined(self.origin));
  itemgroup = spawnStruct();
  itemgroup.itemlistbundle = scriptbundle;
  itemgroup.origin = self.origin;
  itemgroup.angles = isDefined(self.angles) ? self.angles : (0, 0, 0);

  if(is_true(scriptbundle.var_4f220d03)) {
    angleoffset = (isDefined(self.itemlistbundle.var_eec6a9b) ? self.itemlistbundle.var_eec6a9b : 0, isDefined(self.itemlistbundle.var_56257910) ? self.itemlistbundle.var_56257910 : 0, isDefined(self.itemlistbundle.var_24681596) ? self.itemlistbundle.var_24681596 : 0);
    itemgroup.angles = combineangles(itemgroup.angles, angleoffset);
  }

  if(isvec(self.anglesoffset)) {
    itemgroup.angles += self.anglesoffset;
  }

  var_8107154f = [];

  for(pointid = 0; pointid < itemcount; pointid++) {
    var_8107154f[var_8107154f.size] = -2;
  }

  items = itemgroup function_e25c9d12(0, var_8107154f, var_8107154f.size, 0, falling);

  foreach(item in items) {
    if(!isDefined(item)) {
      continue;
    }

    if(isDefined(var_9961d9f3) && isDefined(item.itementry)) {
      item.itementry.var_31dcb18d = var_9961d9f3;
    }

    item.spawning = 0;

    if(isentity(item) && isDefined(item.var_627c698b.attachments) && !isDefined(item.attachments)) {
      attachments = item.var_627c698b.attachments;

      foreach(attachment in attachments) {
        var_41ade915 = item_world_util::function_6a0ee21a(attachment);
        attachmentitem = function_4ba8fde(var_41ade915);
        item_inventory_util::function_8b7b98f(item, attachmentitem);
      }
    }
  }

  return items;
}