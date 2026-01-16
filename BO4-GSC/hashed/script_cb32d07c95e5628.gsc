/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_cb32d07c95e5628.gsc
***********************************************/

#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\mp_common\item_drop;
#include scripts\mp_common\item_world_util;

#namespace namespace_65181344;

private function_2c4d3d40() {
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

private function_440f0490(itemlistbundle) {
  assert(isDefined(itemlistbundle) && itemlistbundle.type === "<dev string:x38>");
  assert(itemlistbundle.itemlist.size > 0, "<dev string:x4d>" + itemlistbundle.name + "<dev string:x63>");

  if(itemlistbundle.itemlist.size <= 0) {
    return;
  }

  weights = [];
  weighttotal = 0;

  for(rowindex = 0; rowindex < itemlistbundle.itemlist.size; rowindex++) {
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

  rollchance = function_d59c2d03(weighttotal);
  currentweight = 0;

  for(weightindex = 0; weightindex < weights.size; weightindex++) {
    currentweight += weights[weightindex];

    if(rollchance <= currentweight) {
      itemlistbundle = getscriptbundle(itemlistbundle.itemlist[weightindex].itementry);
      assert(itemlistbundle.type === "<dev string:x6f>");
      break;
    }
  }

  return itemlistbundle;
}

private function_6a5c090c() {
  level.var_de3d5d56 = undefined;
}

function_9e9f43cd() {
  if(!level flagsys::get(#"hash_67b445a4b1d59922") && !level flagsys::get(#"hash_11c9cde7b522c5a9")) {
    assert(0);
    return;
  }

  foreach(targetname, points in level.var_1d777960) {
    for(index = 0; index < points.size; index++) {
      origin = points[index].origin;
      angles = points[index].angles;
      ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
      position = ground_pos[#"position"];
      function_53a81463(position, angles, targetname, #"");
    }

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }
}

function_e88ecf7f() {
  if(!level flagsys::get(#"hash_67b445a4b1d59922") && !level flagsys::get(#"hash_11c9cde7b522c5a9")) {
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

private function_35461e5f(row, stashitem = 0) {
  items = [];
  item_name = self.itemlistbundle.itemlist[row].itementry;
  item = function_62c0d32d(item_name, stashitem);

  if(isDefined(item)) {
    items[items.size] = item;
  }

  for(index = 1; index <= 5; index++) {
    item_name = self.itemlistbundle.itemlist[row].("childitementry_" + index);

    if(!isDefined(item_name)) {
      continue;
    }

    item = function_62c0d32d(item_name, stashitem);

    if(isDefined(item)) {
      items[items.size] = item;
    }
  }

  return items;
}

private function_62c0d32d(item_name, stashitem = 0) {
  if(isDefined(item_name) && isDefined(level.var_4afb8f5a[item_name])) {
    item_name = level.var_4afb8f5a[item_name];
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
  weapon = item_world_util::function_35e06774(itementry, isDefined(itementry.attachments));
  itemcount = isDefined(itementry.amount) ? itementry.amount : 1;
  var_aec6fa7f = 0;

  if(itementry.itemtype == #"weapon") {
    var_aec6fa7f = itementry.amount * weapon.clipsize;
  } else if(itementry.itemtype == #"armor" || itementry.itemtype == #"ammo") {
    var_aec6fa7f = itementry.amount;
    itemcount = 1;
  }

  item = item_drop::drop_item(weapon, itemcount, var_aec6fa7f, itemspawnpoint.id, origin, angles, stashitem);

  if(isDefined(item)) {
    item.spawning = 1;
  }

  return item;
}

private function_98013deb(row) {
  numchildren = 0;

  for(index = 1; index <= 5; index++) {
    item_name = self.itemlistbundle.itemlist[row].("childitementry_" + index);

    if(isDefined(item_name)) {
      numchildren++;
    }
  }

  return numchildren;
}

private _spawn_item(point, row, stashitem = 0) {
  if(!isDefined(point)) {
    return;
  }

  item_name = self.itemlistbundle.itemlist[row].itementry;

  if(isDefined(item_name) && isDefined(level.var_4afb8f5a[item_name])) {
    item_name = level.var_4afb8f5a[item_name];
  }

  if(!isDefined(item_name) || item_name == "") {
    function_43cd95f4(point.id, "");

    if(!isDefined(level.var_d80c35aa[#"blank"])) {
      level.var_d80c35aa[#"blank"] = 0;
    }

    level.var_d80c35aa[#"blank"]++;

      return;
  }

  itementry = isDefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);

  if(!stashitem && isDefined(itementry) && isDefined(itementry.itemtype)) {
    if(!isDefined(level.var_d80c35aa[itementry.itemtype])) {
      level.var_d80c35aa[itementry.itemtype] = 0;
    }

    level.var_d80c35aa[itementry.itemtype]++;
  }

    if(!isDefined(itementry) || !isDefined(itementry.itemtype) || itementry.itemtype == #"blank") {
      function_43cd95f4(point.id, "");
      return;
    }
  else if(itementry.itemtype == #"vehicle") {
    ground_pos = bulletTrace(point.origin + (0, 0, 128), point.origin - (0, 0, 128), 0, undefined, 1);

    if(ground_pos[#"surfacetype"] == "water" || ground_pos[#"surfacetype"] == "watershallow") {
      ground_pos = bulletTrace(point.origin + (0, 0, 2048), point.origin - (0, 0, 2048), 0, undefined, 1);
    }

    spawnpoint = ground_pos[#"position"] + (0, 0, 36);
    vehicle = undefined;

    if(item_world_util::function_74e1e547(spawnpoint)) {
      vehicle = spawnvehicle(itementry.vehicle, spawnpoint, point.angles);
    }

    if(isDefined(vehicle)) {
      level.item_vehicles[level.item_vehicles.size] = vehicle;
      level.var_8819644a[level.var_8819644a.size] = {
        #origin: vehicle.origin, 
        #vehicletype: vehicle.vehicletype, 
        #vehicle: vehicle, 
        #used: 0
      };

      if(isairborne(vehicle)) {
        spawnoffset = (0, 0, vehicle.height);
        vehicle.origin = point.origin + spawnoffset;
      }

      vehicle makeusable();

      if(isDefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle) {
        vehicle setbrake(1);
      }

      if(isDefined(getgametypesetting(#"hash_59ab05f71c3789c7")) && getgametypesetting(#"hash_59ab05f71c3789c7")) {
        target_remove(vehicle);
      }
    }

    function_43cd95f4(point.id, "");

    level.var_f2db6a7f++;

      if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
      }

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
        origin = ground_pos[#"position"];
        normal = ground_pos[#"normal"];
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

  if(item_name == #"sig_blade_wz_item") {
    level.var_5b2a8d88[point.id] = 1;
  }

  if(stashitem) {
    function_54ca5536(point.id, -1);
  }

  if(stashitem) {
    if(!isDefined(level.var_ecf16fd3[itementry.itemtype])) {
      level.var_ecf16fd3[itementry.itemtype] = 0;
    }

    level.var_ecf16fd3[itementry.itemtype]++;
    level.var_2850ef5++;
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

private function_f0e5262b(item_name, point, childindex, stashitem = 0, targetname) {
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
    origin = ground_pos[#"position"] + var_f05b52fe;
    normal = ground_pos[#"normal"];
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
    if(!isDefined(level.var_ecf16fd3[itementry.itemtype])) {
      level.var_ecf16fd3[itementry.itemtype] = 0;
    }

    level.var_ecf16fd3[itementry.itemtype]++;
    level.var_2850ef5++;
    return;
  }

  if(!isDefined(level.var_8d9ad8e8[itementry.itemtype])) {
    level.var_8d9ad8e8[itementry.itemtype] = 0;
  }

  level.var_8d9ad8e8[itementry.itemtype]++;
  level.var_5720c09a++;

}

private function_ea39d1fa(stash) {
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

      if(var_1dd9b7f1.type !== #"itemspawnlist") {
        assert(0, "<dev string:x7f>" + var_ee110db8);
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

  for(row = 0; row < var_eff83f3.itemlist.size; row++) {
    if(!isDefined(var_eff83f3.itemlist[row].itementry)) {
      continue;
    }

    itemlistbundle = getscriptbundle(var_eff83f3.itemlist[row].itementry);
    var_bbe618cc = itemlistbundle.type == #"itemspawnlist" || itemlistbundle.type == #"itemspawnlistalias";
    available = isDefined(var_eff83f3.itemlist[row].available) ? var_eff83f3.itemlist[row].available : 0;
    var_8107154f = [];

    do {
      point = function_53a81463(stash.origin, stash.angles, isDefined(stash.targetname) ? stash.targetname : stash.target, "");
      var_8107154f[var_8107154f.size] = point.id;

      if(!var_bbe618cc) {
        _spawn_item(point, row, 1);
      }

      available--;
    }
    while(available > 0);

    if(var_bbe618cc) {
      if(itemlistbundle.type == #"itemspawnlistalias") {
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
      itemspawnlist function_e25c9d12(var_8107154f, var_8107154f.size, 1);
    }

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }

  self.itemlistbundle = var_aa9f8f87;
}

private function_216a69d6(spawnchance, reset) {
  dynents = array();

  if(isDefined(self.target)) {
    dynents = getdynentarray(self.target, 1);
  }

  if(isDefined(self.targetname)) {
    var_ed91073b = function_c79d31c4(self.targetname, 1);
    dynents = arraycombine(dynents, var_ed91073b, 1, 0);
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

    if(isDefined(dynent.lootlocker) && dynent.lootlocker) {}

    randint = function_d59c2d03(100);
    shouldspawn = randint <= spawnchance;

    if(maxspawns > -1 && var_418a2e03.size >= maxspawns) {
      shouldspawn = 0;
    }

    if(shouldspawn && reset) {
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
    dynent.angles = point.angles;
    dynent.origin = point.origin;
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

private _spawn(reset) {
  if(isDefined(self.itemlistbundle.supplystash) && self.itemlistbundle.supplystash) {
    self function_216a69d6(isDefined(self.itemlistbundle.supplystashweight) ? self.itemlistbundle.supplystashweight : 100, reset);
    return;
  }

  self function_e25c9d12(self.var_8107154f, self.var_8107154f.size);
}

private _setup() {
  self.itemlistbundle = getscriptbundle(self.scriptbundlename);

  if(isDefined(self.itemlistbundle) && isDefined(level.var_fb9a8536[self.itemlistbundle.name])) {
    self.itemlistbundle = getscriptbundle(level.var_fb9a8536[self.itemlistbundle.name]);
  }

  assert(isDefined(self.itemlistbundle), "<dev string:xc6>" + self.scriptbundlename + "<dev string:xd7>");
  assert(isDefined(self.itemlistbundle.itemlist), "<dev string:xc6>" + self.scriptbundlename + "<dev string:x63>");
  self.remaining = isDefined(self.count) ? self.count : 0;
  self.points = function_d0dc448b(self.target);
  self.var_8107154f = [];

  foreach(pointid in self.points) {
    self.var_8107154f[pointid] = pointid;
  }

  if(!isDefined(level.var_28cd0b1f[self.target])) {
    assert(isDefined(self.points) && self.points.size > 0, "<dev string:xe4>" + self.itemlistbundle.name + "<dev string:xf5>" + self.target);
  }

  if(!isDefined(self.points)) {
    self.points = [];
  }
}

private _teardown() {
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

function_3095d12a() {
  if(isDefined(level.var_ccc3aaf)) {
    return;
  }

  level.var_ccc3aaf = 1;
  flagsys::set(#"item_world_traces");
}

private function_9db93def() {
  assert(isDefined(self.target) && self.target != "<dev string:x130>", "<dev string:x133>" + self.origin + "<dev string:x150>");
  assert(self.target !== self.targetname, "<dev string:x133>" + self.origin + "<dev string:x172>" + self.target + "<dev string:x1ae>");
}

private function_6b9be08d() {
  return getdvarint(#"hash_21e070fbb56cf0f", 1);
}

private function_e25c9d12(&var_8107154f, spawncount, stashitem = 0, &var_a1b91de4 = undefined) {
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
  assert(!(isDefined(self.vehiclespawner) && self.vehiclespawner));
  assert(!(isDefined(self.supplystash) && self.supplystash));

  if(spawncount <= 0) {
    return;
  }

  items = [];
  self.rows = isDefined(self.itemlistbundle.itemlist.size) ? self.itemlistbundle.itemlist.size : 0;
  self.count = spawncount;
  self.available = [];
  self.weights = [];
  self.weighttotal = 0;

  for(row = 0; row < self.rows; row++) {
    self.available[row] = isDefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;

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

    points = self.weights[row] / var_413b71b8 * var_399d601b;

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

      if(isDefined(scriptbundle) && isDefined(scriptbundle.type) && (scriptbundle.type == #"itemspawnlist" || scriptbundle.type == #"itemspawnlistalias")) {
        self.var_ccc6d5b7[var_75aa5cbb] = self.var_202d2992[var_75aa5cbb];
        self.var_202d2992[var_75aa5cbb] = 0;
        var_f5111345++;
        continue;
      }
    }

    if(var_8107154f[var_a1b91de4[pointindex]] == -2) {
      spawnitems = self function_35461e5f(var_75aa5cbb, stashitem);
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
          if(itemtype == #"vehicle") {
            vehicles = getvehiclearray();
            nearbyvehicles = arraysortclosest(vehicles, itemspawnpoint.origin, 1, 0, self.itemlistbundle.var_7fb0967b);
            var_8822f354 = nearbyvehicles.size;
          } else {
            var_8822f354 = function_579fdc53(itemspawnpoint.origin, undefined, itemtype, self.itemlistbundle.var_7fb0967b, -1, -2147483647);
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

    if(!isDefined(itemlistbundle.type) || itemlistbundle.type != #"itemspawnlist" && itemlistbundle.type != #"itemspawnlistalias") {
      continue;
    }

    if(itemlistbundle.type == #"itemspawnlistalias") {
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
    itemspawnlist.origin = self.origin;
    itemspawnlist.angles = self.angles;
    var_4168f4f3 = itemspawnlist function_e25c9d12(var_8107154f, self.var_ccc6d5b7[index], stashitem, var_a1b91de4);
    items = arraycombine(items, var_4168f4f3, 1, 0);
  }

  return items;
}

private function_c6477714(reset) {
  override = spawnStruct();
  override.scriptbundlename = #"prematch_override_list";
  override.itemlistbundle = getscriptbundle(override.scriptbundlename);
  override.var_ebfb74b9 = function_8322cf16();
  var_8107154f = [];

  for(index = 0; index < override.var_ebfb74b9; index++) {
    var_8107154f[index] = index;
  }

  item_spawn_groups = struct::get_array("scriptbundle_itemspawnlist", "classname");

  foreach(group in item_spawn_groups) {
    group.itemlistbundle = getscriptbundle(group.scriptbundlename);

    if(isDefined(group.itemlistbundle.vehiclespawner) && group.itemlistbundle.vehiclespawner) {
      spawnpoints = function_91b29d2a(group.target);

      foreach(spawnpoint in spawnpoints) {
        var_8107154f[spawnpoint.id] = -1;
        override.var_ebfb74b9--;
      }

      group function_9db93def();
      group _setup();
      group _spawn(reset);
    }
  }

  foreach(group in item_spawn_groups) {
    group.itemlistbundle = getscriptbundle(group.scriptbundlename);

    if(isDefined(group.itemlistbundle.supplystash) && group.itemlistbundle.supplystash) {
      dynents = getdynentarray(group.target, 1);

      foreach(dynent in dynents) {
        level.item_spawn_stashes[level.item_spawn_stashes.size] = dynent;
        setdynentenabled(dynent, 0);
      }

      spawnpoints = function_91b29d2a(group.target);

      foreach(spawnpoint in spawnpoints) {
        var_8107154f[spawnpoint.id] = -1;
        override.var_ebfb74b9--;
      }
    }
  }

  override function_e25c9d12(var_8107154f, override.var_ebfb74b9);
}

function_62fdaf9e() {
  keys = getarraykeys(level.struct);

  for(index = 0; index < keys.size; index++) {
    key = keys[index];
    value = level.struct[key];

    if(!isDefined(value)) {
      continue;
    }

    if(isDefined(value.classname) && value.classname == #"scriptbundle_itemspawnlist") {
      level.struct[key] = undefined;
    }

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }

  arrayremovevalue(level.struct, undefined, 0);
}

init_spawn_system() {
  level.var_d0676b07 = getrealtime();
  level.var_3e9c9a35 = 30;
  function_2c4d3d40();
  function_3095d12a();
}

is_enabled() {
  return isDefined(getgametypesetting(#"useitemspawns")) && getgametypesetting(#"useitemspawns");
}

reset_items() {
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

function_50a2c746(&var_f38d5b52, reset = 1, var_87e9f374 = 0) {
  assert(isarray(var_f38d5b52));

  if(var_87e9f374) {}

    item_spawn_groups = struct::get_array("scriptbundle_itemspawnlist", "classname");

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
      if(!(isDefined(itemlistbundle.var_dc91e192) && itemlistbundle.var_dc91e192) || !(isDefined(itemlistbundle.supplystash) && itemlistbundle.supplystash)) {
        continue;
      }
    } else if(isDefined(itemlistbundle.var_dc91e192) && itemlistbundle.var_dc91e192 && isDefined(itemlistbundle.supplystash) && itemlistbundle.supplystash) {
      continue;
    }

    if(isDefined(var_f38d5b52[group.target])) {
      if(!(isDefined(itemlistbundle.supplystash) && itemlistbundle.supplystash)) {
        continue;
      }
    }

    var_f38d5b52[group.target] = 1;

    if(getdvarint(#"hash_424f2e897e67b1ba", 0)) {
      if(!(isDefined(itemlistbundle.var_bb617d29) && itemlistbundle.var_bb617d29) && !(isDefined(itemlistbundle.supplystash) && itemlistbundle.supplystash) && !(isDefined(itemlistbundle.vehiclespawner) && itemlistbundle.vehiclespawner)) {
        continue;
      }
    } else if(isDefined(itemlistbundle.var_bb617d29) && itemlistbundle.var_bb617d29) {
      continue;
    }

    group function_9db93def();
    group _setup();
    group _spawn(reset);
    group _teardown();

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }
  }

  return var_f38d5b52;
}

setup_groups(reset = 1) {
  if(reset) {
    level flagsys::set(#"hash_67b445a4b1d59922");
  } else {
    level flagsys::set(#"hash_11c9cde7b522c5a9");
  }

  flagsys::wait_till(#"item_world_traces");

  if(!isDefined(level.var_55f723bd)) {
    level.var_3683df16 = 0;
    level.var_3062619 = "<dev string:x130>";
    level.var_55f723bd = openfile("<dev string:x1b3>", "<dev string:x1d1>");
  }

  if(reset) {}

    starttime = gettime();
  level.var_d0676b07 = getrealtime();
  level.var_4afb8f5a = reset ? level.itemreplacement : level.var_ee46a98d;

  foreach(key, value in level.var_4afb8f5a) {}

  level.var_fb9a8536 = reset ? level.var_ee110db8 : level.var_db0e7b82;

  foreach(value in level.var_fb9a8536) {}

  if(!isDefined(level.var_28cd0b1f)) {
    level.var_28cd0b1f = [];
  }

  if(reset) {
    reset_items();
  }

  function_e88ecf7f();
  function_9e9f43cd();
  level.item_spawn_stashes = [];
  level.var_5ce07338 = [];
  level.var_93d08989 = [];
  level.item_vehicles = [];
  level.var_8819644a = [];
  level.var_5b2a8d88 = [];
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

    if(isDefined(function_6b9be08d()) && function_6b9be08d() == 1) {
      function_c6477714(reset);
    }
  else {
    var_f38d5b52 = [];
    function_50a2c746(var_f38d5b52, reset, 1);

    if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
      waitframe(1);
      level.var_d0676b07 = getrealtime();
    }

    function_50a2c746(var_f38d5b52, reset, 0);
  }

  level.var_a7247d85 = function_8322cf16();
  level.var_66e56764 = level.var_136445c0 + level.var_5720c09a + level.var_2850ef5;
  level.var_efeab371 = [];

  foreach(type, count in level.var_d80c35aa) {
    level.var_efeab371[type] = (isDefined(count) ? count : 0) + (isDefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) + (isDefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0);
  }

  foreach(type, count in level.var_efeab371) {}

    if(reset) {
      function_62fdaf9e();
      function_6a5c090c();
    }

  if(reset) {
    closefile(level.var_55f723bd);
    level.var_55f723bd = undefined;
  }

    level.var_f1f90fd3 = float(gettime() - starttime) / 1000;
}

function_5eada592(scriptbundlename, linkto = 1) {
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

  for(row = 0; row < self.itemlistbundle.itemlist.size; row++) {
    if(!isDefined(self.itemlistbundle.itemlist[row].itementry)) {
      continue;
    }

    itemlistbundle = getscriptbundle(self.itemlistbundle.itemlist[row].itementry);
    var_bbe618cc = itemlistbundle.type == #"itemspawnlist" || itemlistbundle.type == #"itemspawnlistalias";
    available = isDefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;
    var_8107154f = [];

    do {
      var_8107154f[var_8107154f.size] = -2;

      if(!var_bbe618cc) {
        spawnitems = function_35461e5f(row, 1);
        items = arraycombine(items, spawnitems, 1, 0);
      }

      available--;
    }
    while(available > 0);

    if(var_bbe618cc) {
      if(itemlistbundle.type == #"itemspawnlistalias") {
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
      spawnitems = itemspawnlist function_e25c9d12(var_8107154f, var_8107154f.size, 1);
      items = arraycombine(items, spawnitems, 1, 0);
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

function_fd87c780(scriptbundlename, itemcount) {
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

  itemgroup = spawnStruct();
  itemgroup.itemlistbundle = getscriptbundle(scriptbundlename);
  itemgroup.origin = self.origin;
  itemgroup.angles = self.angles;
  var_8107154f = [];

  for(pointid = 0; pointid < itemcount; pointid++) {
    var_8107154f[var_8107154f.size] = -2;
  }

  items = itemgroup function_e25c9d12(var_8107154f, var_8107154f.size, 0);

  foreach(item in items) {
    if(!isDefined(item)) {
      continue;
    }

    item.spawning = 0;
  }

  return items;
}