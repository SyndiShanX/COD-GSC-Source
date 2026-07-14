/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_interact.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace vehicle_interact;

function get_data(vehicleref, create, var_e6c819f806ce2c86) {
  data = vehicle::has_data(vehicleref) ? vehicle::get_data(vehicleref) : undefined;

  if(!isDefined(data.interact) && create) {
    data = undefined;

    if(!vehicle::has_data(vehicleref)) {
      data = spawnStruct();
    } else {
      data = vehicle::get_data(vehicleref);
    }

    if(!isDefined(data.interact)) {
      data.interact = spawnStruct();
    }

    data.interact.interactiontypes = [];
    data.interact.maxfuel = 180;
    data.interact.var_a5b1ad5fd2654e9a = 130;
    data.interact.var_a5d4975fd28b65f0 = 170;
    vehicle::add_data(vehicleref, data);
  }

  return data.interact;
}

function function_29894e0fa6bf739(vehicle, create, var_e6c819f806ce2c86) {
  if(getdvarint(@ "hash_74cacae425805743", 0) > 0) {
    return undefined;
  }

  instancedataforvehicle = vehicle.interactdata;

  if(!isDefined(instancedataforvehicle)) {
    leveldataforvehicle = get_data(vehicle vehicle::get_ref(), create, var_e6c819f806ce2c86);

    if(!isDefined(leveldataforvehicle)) {
      return undefined;
    }

    if(!isDefined(vehicle getlinkedscriptableinstance())) {
      return undefined;
    }

    if(create) {
      instancedataforvehicle = spawnStruct();
      vehicle.interactdata = instancedataforvehicle;
      instancedataforvehicle.disabledbyallow = 0;
      instancedataforvehicle.pointdata = [];

      foreach(pointref in leveldataforvehicle.interactiontypes) {
        instancedataforvehicle.pointdata[pointref] = function_c358ea472bd810ac(vehicle, pointref, create, var_e6c819f806ce2c86);
      }

      instancedataforvehicle.dirty = 1;
      instancedataforvehicle.disabled = undefined;
      instancedataforvehicle.availableteam = undefined;
    } else {
      assert(istrue(var_e6c819f806ce2c86), "<dev string:x24>");
    }
  }

  return instancedataforvehicle;
}

function function_addfe642323c541(vehicleref, pointref, activationdata) {
  leveldataforvehicle = get_data(vehicleref, undefined, 1);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  var_36d4ce271b7837bc = function_ac67a068455698f6(pointref);
  assert(isDefined(var_36d4ce271b7837bc), "<dev string:x72>" + pointref + "<dev string:x96>");
  leveldataforvehicle.interactiontypes[leveldataforvehicle.interactiontypes.size] = pointref;
  function_e27bbc419afe6871("activate", pointref, activationdata, leveldataforvehicle);
}

function register_instance(vehicle) {
  function_29894e0fa6bf739(vehicle, 1);
  update_usability(vehicle);
}

function deregister_instance(vehicle) {
  make_unusable(vehicle);
  vehicle.interactdata = undefined;
}

function instance_is_registered(vehicle) {
  return isDefined(vehicle.interactdata);
}

function allow_use_global(bool) {
  leveldata = get_level_data();
  vehicles = vehicle_tracking::function_5820a38c9873992e();

  if(!isDefined(vehicles)) {
    return;
  }

  if(!bool) {
    leveldata.disabledbyallow++;

    if(leveldata.disabledbyallow == 1) {
      foreach(vehicle in vehicles) {
        if(!isDefined(function_29894e0fa6bf739(vehicle))) {
          continue;
        }

        set_dirty(vehicle);
        update_usability(vehicle);
      }
    }

    return;
  }

  assert(leveldata.disabledbyallow > 0, "<dev string:xd1>" + bool + "<dev string:xfc>");
  leveldata.disabledbyallow--;

  if(leveldata.disabledbyallow == 0) {
    foreach(vehicle in vehicles) {
      if(!isDefined(function_29894e0fa6bf739(vehicle))) {
        continue;
      }

      set_dirty(vehicle);
      update_usability(vehicle);
    }
  }
}

function allow_use(vehicle, bool) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(!bool) {
    instancedataforvehicle.disabledbyallow++;

    if(instancedataforvehicle.disabledbyallow == 1) {
      set_dirty(vehicle);
      update_usability(vehicle);
    }

    return;
  }

  assert(instancedataforvehicle.disabledbyallow > 0, "<dev string:x125>" + bool + "<dev string:xfc>");
  instancedataforvehicle.disabledbyallow--;

  if(instancedataforvehicle.disabledbyallow == 0) {
    set_dirty(vehicle);
    update_usability(vehicle);
  }
}

function function_c9835ad3c3e5dab2(vehicle, scriptable_part) {
  vehicle.var_dcc4310e5380a5c9[scriptable_part] = "single";
}

function can_use(vehicle) {
  leveldata = get_level_data();
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);
  return leveldata.disabledbyallow == 0 && instancedataforvehicle.disabledbyallow == 0;
}

function function_7f6d4b46409d18b0(vehicle) {
  if(function_2942e71e54cd0a35(vehicle)) {
    function_ad6681d7d06bae11(vehicle);
  }
}

function function_2942e71e54cd0a35(vehicle) {
  dvarstring = hashcat(@ "scr_", vehicle.vehiclename);

  if(getDvar(dvarstring, "") == "") {
    setDvar(dvarstring, "enable");
  }

  println("<dev string:x14a>" + vehicle.vehiclename);
  dvarstatus = getDvar(dvarstring, "enable") == "disable";
  return dvarstatus;
}

function function_ad6681d7d06bae11(vehicle) {
  println("<dev string:x15e>");
  allow_use(vehicle, 0);
}

function init() {
  assert(isDefined(level.vehicle), "<dev string:x173>");
  assert(!isDefined(level.vehicle.interact), "<dev string:x1ac>");
  leveldata = spawnStruct();
  level.vehicle.interact = leveldata;
  leveldata.interactiontypes = [];
  leveldata.disabledbyallow = 0;
  function_6151151f5ee552b9("single", &function_f0f37484aa7a76b5, &function_d1e96ed8551162f3, &function_fecc57c15668b2c3, &function_104c6c0ffb051ff8);
  function_6151151f5ee552b9("upgrade", &function_93e5625d0761f3f7, &function_b45bbb4a007d4f69, &function_21c1135cab1ad90d, &function_ce94117e88989582);
  function_6151151f5ee552b9("copyofupgrade", &function_93e5625d0761f3f7, &function_b45bbb4a007d4f69, &function_21c1135cab1ad90d, &function_ce94117e88989582);
  level thread init_gas_stations();
  scriptable::scriptable_addusedcallback(&scriptable_used);

  if(utility::issharedfuncdefined(#"vehicle_interact", #"init")) {
    [[utility::getsharedfunc(#"vehicle_interact", #"init")]]();
  }

  level thread function_1f8597329cb7714e();
}

function function_bba2522f3d5de6e9(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    player waittill("luinotifyserver", notification);

    if(!isDefined(notification)) {
      continue;
    }

    var_800f9664a7db6ed2 = player.pers["telemetry"];

    if(notification == "vehicle_cruise_control_on" && isDefined(var_800f9664a7db6ed2.vehicle_autofwd_count)) {
      var_800f9664a7db6ed2.vehicle_autofwd_count++;
    }
  }
}

function function_1f8597329cb7714e() {
  while(true) {
    waitframe();
    waittillframeend();
    level.vehicle.partition = undefined;
  }
}

function create_partition() {
  if(isDefined(level.vehicle.partition)) {
    return;
  }

  vehicles = vehicle_tracking::function_5820a38c9873992e();

  if(isDefined(vehicles) && vehicles.size > 0) {
    level.vehicle.partition = utility::create_partition([], 650);

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle) && isDefined(vehicle.origin)) {
        level.vehicle.partition utility::add_to_partition(vehicle);
      }
    }
  }
}

function function_6151151f5ee552b9(pointred, useinstancefunc, cleaninstancefunc, activatefunc, createinstancefunc) {
  leveldata = get_level_data();
  interactiontype = spawnStruct();
  callbacks = [];
  callbacks["useInstance"] = useinstancefunc;
  callbacks["cleanInstance"] = cleaninstancefunc;
  callbacks["activate"] = activatefunc;
  callbacks["createInstance"] = createinstancefunc;
  interactiontype.callbacks = callbacks;
  leveldata.interactiontypes[pointred] = interactiontype;
}

function scriptable_used(instance, part, state, player, bautouse, usestring) {
  if(state == "vehicle_use") {
    vehicle = instance.entity;
    pointref = vehicle.var_dcc4310e5380a5c9[part] ?? part;
    assert(isDefined(vehicle), "<dev string:x1e3>");

    if(function_a6656fc74b98d1c9(player, vehicle)) {
      if(function_d6f72b4f2e4e6f19(vehicle, pointref)) {
        instancedataforpoint = function_c358ea472bd810ac(vehicle, pointref);
        function_e27bbc419afe6871("useInstance", pointref, instancedataforpoint, vehicle, player);
      }
    }
  }
}

function update_player_usability(player, vehicles) {
  leveldata = get_level_data();

  if(!function_89e68d4b41153c0e(player)) {
    foreach(vehicle in vehicles) {
      if(isDefined(vehicle) && vehicle getscriptablehaspart("single")) {
        vehicle disablescriptablepartplayeruse("single", player);
      }
    }

    return;
  }

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle)) {
      continue;
    }

    if(!vehicle getscriptablehaspart("single")) {
      continue;
    }

    if(function_a6656fc74b98d1c9(player, vehicle)) {
      vehicle enablescriptableplayeruse(player);
      vehicle enablescriptablepartplayeruse("single", player);
      continue;
    }

    vehicle disablescriptablepartplayeruse("single", player);
  }
}

function function_f3db94c7cb6b6461(player) {
  level endon("game_ended");
  player endon("disconnect");
  update_player_usability_func = level.func["update_player_usability"];

  while(true) {
    player waittill("update_vehicle_usability", vehiclelist);
    update_player_usability(player, vehiclelist);

    if(isDefined(update_player_usability_func)) {
      [[update_player_usability_func]](player, vehiclelist);
    }
  }
}

function private get_level_data() {
  assert(isDefined(level.vehicle), "<dev string:x22a>");
  assert(isDefined(level.vehicle.interact), "<dev string:x26b>");
  return level.vehicle.interact;
}

function private function_ac67a068455698f6(pointref) {
  assert(isDefined(level.vehicle), "<dev string:x22a>");
  assert(isDefined(level.vehicle.interact), "<dev string:x26b>");
  return level.vehicle.interact.interactiontypes[pointref];
}

function function_e27bbc419afe6871(callbackref, pointref, var_1d4b2087eab22320, var_7b5d8787732336f6, var_9661ab9a54353ed4) {
  var_36d4ce271b7837bc = function_ac67a068455698f6(pointref);
  callbackfunc = var_36d4ce271b7837bc.callbacks[callbackref];

  if(isDefined(callbackfunc)) {
    level thread[[callbackfunc]](pointref, var_1d4b2087eab22320, var_7b5d8787732336f6, var_9661ab9a54353ed4);
  }
}

function function_89e68d4b41153c0e(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!player utility::callsharedfunc(#"player", #"playerisalive")) {
    return false;
  }

  if(!player val::get("vehicle_use")) {
    return false;
  }

  if(player isparachuting() || player isskydiving()) {
    return false;
  }

  if(player isemoteactive()) {
    return false;
  }

  if(player utility::callsharedfunc(#"execution", #"isinexecutionattack") || player utility::callsharedfunc(#"execution", #"isinexecutionvictim")) {
    return false;
  }

  if(level.infiltransistioning) {
    return false;
  }

  return true;
}

function function_ecedc4c793a25cb(vehicle) {
  if(get_data(vehicle vehicle::get_ref(), 0, 1).var_c3d9b257664dde2a) {
    return false;
  }

  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return false;
  }

  if(instancedataforvehicle.dirty) {
    clean_vehicle(vehicle);
  }

  return !instancedataforvehicle.disabled;
}

function function_d6f72b4f2e4e6f19(vehicle, pointref) {
  instancedataforpoint = function_c358ea472bd810ac(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return undefined;
  }

  if(instancedataforpoint.dirty) {
    clean_point(vehicle, pointref);
  }

  return !instancedataforpoint.disabled;
}

function function_a6656fc74b98d1c9(player, vehicle) {
  if(!function_89e68d4b41153c0e(player)) {
    return false;
  }

  if(!function_ecedc4c793a25cb(vehicle)) {
    return false;
  }

  if(level.vehiclelockingenabled) {
    return true;
  } else if(level.teambased) {
    team = function_9c8b1439410b3157(vehicle);

    if(isDefined(team) && team != player.team) {
      return false;
    }
  } else {
    playerfriendlyto = vehicle_occupancy::function_e3f715e42f7b96c4(vehicle);

    if(isDefined(playerfriendlyto) && playerfriendlyto != player) {
      return false;
    }
  }

  return true;
}

function function_9c8b1439410b3157(vehicle) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return undefined;
  }

  if(instancedataforvehicle.dirty) {
    clean_vehicle(vehicle);
  }

  return instancedataforvehicle.availableteam;
}

function set_dirty(vehicle) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  instancedataforvehicle.dirty = 1;
}

function set_visibility(show) {
  if(isDefined(self) && self isscriptable() && self getscriptablehaspart("visibility")) {
    self setscriptablepartstate("visibility", istrue(show) ? "show" : "hide");
  }
}

function clean_vehicle(vehicle) {
  leveldata = get_level_data();
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(level.teambased) {
    teamfriendlyto = vehicle_occupancy::function_88fc32afbd317644(vehicle);

    if(isDefined(teamfriendlyto)) {
      instancedataforvehicle.availableteam = teamfriendlyto;
    } else {
      availableteam = undefined;
      reserving = vehicle_occupancy::get_reserving(vehicle);

      foreach(player in reserving) {
        if(isPlayer(player)) {
          availableteam = player.team;
          break;
        }
      }

      instancedataforvehicle.availableteam = availableteam;
    }
  }

  if(leveldata.disabledbyallow > 0) {
    instancedataforvehicle.disabled = 1;
  } else if(instancedataforvehicle.disabledbyallow > 0) {
    instancedataforvehicle.disabled = 1;
  } else {
    instancedataforvehicle.disabled = 0;
  }

  instancedataforvehicle.dirty = 0;
}

function function_c358ea472bd810ac(vehicle, pointref, create, var_e6c819f806ce2c86) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, create, var_e6c819f806ce2c86);

  if(!isDefined(instancedataforvehicle)) {
    return undefined;
  }

  instancedataforpoint = instancedataforvehicle.pointdata[pointref];

  if(!isDefined(instancedataforpoint) && isDefined(create)) {
    if(create) {
      instancedataforpoint = spawnStruct();
      instancedataforvehicle.pointdata[pointref] = instancedataforpoint;
      instancedataforpoint.dirty = 1;
      instancedataforpoint.disabled = undefined;
      function_e27bbc419afe6871("createInstance", pointref, instancedataforpoint, vehicle);
    } else {
      assert(istrue(var_e6c819f806ce2c86), "<dev string:x2b5>");
    }
  }

  return instancedataforpoint;
}

function function_a12ad0d0b2d4cc2c(vehicle, pointref) {
  instancedataforpoint = function_c358ea472bd810ac(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return;
  }

  instancedataforpoint.dirty = 1;
}

function set_points_dirty(vehicle) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  foreach(pointdata in instancedataforvehicle.pointdata) {
    pointdata.dirty = 1;
  }

  instancedataforvehicle.dirty = 1;
}

function clean_point(vehicle, pointref) {
  instancedataforpoint = function_c358ea472bd810ac(vehicle, pointref, undefined, 1);

  if(!isDefined(instancedataforpoint)) {
    return;
  }

  function_e27bbc419afe6871("cleanInstance", pointref, instancedataforpoint, vehicle);
  instancedataforpoint.dirty = 0;
}

function private make_unusable(vehicle) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(get_data(vehicle vehicle::get_ref()).var_c3d9b257664dde2a) {
    return;
  }

  pointrefs = getarraykeys(instancedataforvehicle.pointdata);

  foreach(pointref in pointrefs) {
    vehicle setscriptablepartstate(pointref, "vehicle_unusable");
  }
}

function update_usability(vehicle) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, undefined, 1);

  if(!isDefined(instancedataforvehicle)) {
    return;
  }

  if(get_data(vehicle vehicle::get_ref()).var_c3d9b257664dde2a) {
    return;
  }

  if(instancedataforvehicle.dirty) {
    clean_vehicle(vehicle);
  }

  if(instancedataforvehicle.disabled) {
    make_unusable(vehicle);
    return;
  }

  foreach(pointref, pointdata in instancedataforvehicle.pointdata) {
    if(pointdata.dirty) {
      clean_point(vehicle, pointref);
    }

    if(pointdata.disabled) {
      vehicle setscriptablepartstate(pointref, "vehicle_unusable");
      continue;
    }

    vehicle setscriptablepartstate(pointref, "vehicle_use");
  }
}

function function_f0f37484aa7a76b5(pointref, instancedataforpoint, vehicle, player) {
  seatid = instancedataforpoint.availableseatid;

  if(seatid != "driver" && seatid != "gunner") {
    seatid = function_f9d4c251d7f12be(player, vehicle, seatid);
  }

  forceseatid = getdvarint(@ "hash_fb517a5a3d736fa0", 0);

  if(forceseatid > 0) {
    seatids = vehicle_occupancy::function_8a8e1601e7e6610(vehicle);
    forceseatid = int(min(forceseatid - 1, seatids.size - 1));
    seatid = seatids[forceseatid];
    iprintlnbold("<dev string:x302>" + seatid);
  }

  thread vehicle_occupancy::enter(vehicle, seatid, player);
}

function function_f9d4c251d7f12be(player, vehicle, nextavailableseat) {
  closestseat = nextavailableseat;
  closestdistancesqr = undefined;

  foreach(seatid, seatdata in vehicle::get_data(vehicle vehicle::get_ref()).occupancy.seatdata) {
    if(vehicle_occupancy::function_42362fb16a07025e(vehicle, seatid) && isDefined(seatdata.animtag)) {
      if(seatdata.var_f10b778a5f7f1c62) {
        continue;
      }

      distancesqr = distancesquared(player.origin, vehicle gettagorigin(seatdata.animtag));

      if(!isDefined(closestdistancesqr) || distancesqr < closestdistancesqr) {
        closestseat = seatid;
        closestdistancesqr = distancesqr;
      }
    }
  }

  return closestseat;
}

function function_d1e96ed8551162f3(pointref, instancedataforpoint, vehicle, unusedtwo) {
  var_30c65d47028f9ff4 = instancedataforpoint.var_30c65d47028f9ff4;
  assert(isDefined(var_30c65d47028f9ff4), "<dev string:x30f>");
  availableseatid = undefined;

  foreach(seatid in var_30c65d47028f9ff4) {
    if(vehicle_occupancy::function_42362fb16a07025e(vehicle, seatid)) {
      availableseatid = seatid;
      break;
    }
  }

  instancedataforpoint.disabled = !isDefined(availableseatid);
  instancedataforpoint.availableseatid = availableseatid;
}

function function_fecc57c15668b2c3(pointref, var_30c65d47028f9ff4, leveldataforvehicle, unusedone) {
  assert(isDefined(var_30c65d47028f9ff4), "<dev string:x34e>");
  leveldataforvehicle.var_30c65d47028f9ff4 = var_30c65d47028f9ff4;
}

function function_104c6c0ffb051ff8(pointref, instancedataforpoint, vehicle, unusedone) {
  leveldataforvehicle = get_data(vehicle vehicle::get_ref(), undefined, 1);
  assert(isDefined(leveldataforvehicle.var_30c65d47028f9ff4), "<dev string:x392>");
  instancedataforpoint.availableseatid = undefined;
  instancedataforpoint.var_30c65d47028f9ff4 = leveldataforvehicle.var_30c65d47028f9ff4;
}

function function_b6d0fa9137efe75a(vehicle, player) {
  if(isDefined(vehicle)) {
    if(!isDefined(vehicle.var_e8cb705eb93ec8a4)) {
      vehicle.var_e8cb705eb93ec8a4 = [];
    }

    vehicle.var_e8cb705eb93ec8a4[vehicle.var_e8cb705eb93ec8a4.size] = player;
  }
}

function function_f8ec5cbb44385eaa(vehicle, player) {
  if(isDefined(vehicle) && isDefined(vehicle.var_e8cb705eb93ec8a4)) {
    vehicle.var_e8cb705eb93ec8a4 = arrayremove(vehicle.var_e8cb705eb93ec8a4, player);
  }
}

function function_93e5625d0761f3f7(pointref, instancedataforpoint, vehicle, player) {
  if(utility::issharedfuncdefined(#"vehicle_upgrade", #"init")) {
    if(!isDefined(level.br_pe_data)) {
      iprintlnbold("<dev string:x3f0>");

      return;
    }

    [[instancedataforpoint.var_8c69bee942766d37]](vehicle, player);
    player setclientomnvar("ui_buystation_override", instancedataforpoint.var_705fd52b7e08a3b1);
    player.var_c305bd7c24a54d39 = 1;
    player.var_d5168c882218a620 = vehicle;
    function_b6d0fa9137efe75a(vehicle, player);
    var_699626b9a6f98958 = utility::getsharedfunc(#"vehicle_upgrade", #"init");
    kiosk = function_32634a21e1b09dd7(vehicle, pointref);
    player thread[[var_699626b9a6f98958]](kiosk);
  }
}

function function_b45bbb4a007d4f69(pointref, instancedataforpoint, vehicle, unusedtwo) {
  instancedataforpoint.disabled = 0;
}

function function_21c1135cab1ad90d(pointref, activationdata, leveldataforvehicle, unusedone) {
  if(!isDefined(leveldataforvehicle.kiosktagarrays)) {
    leveldataforvehicle.kiosktagarrays = [];
  }

  if(!isDefined(leveldataforvehicle.var_72e5ecefa1e310f0)) {
    leveldataforvehicle.var_72e5ecefa1e310f0 = [];
  }

  if(!isDefined(leveldataforvehicle.var_8c69bee942766d37)) {
    leveldataforvehicle.var_8c69bee942766d37 = [];
  }

  leveldataforvehicle.kiosktagarrays[pointref] = activationdata[0];
  leveldataforvehicle.var_72e5ecefa1e310f0[pointref] = activationdata[1];
  leveldataforvehicle.var_8c69bee942766d37[pointref] = activationdata[2];
}

function function_ce94117e88989582(pointref, instancedataforpoint, vehicle, unusedone) {
  leveldataforvehicle = get_data(vehicle vehicle::get_ref(), undefined, 1);
  assert(isDefined(leveldataforvehicle.kiosktagarrays), "<dev string:x427>");
  assert(isDefined(leveldataforvehicle.kiosktagarrays[pointref]), "<dev string:x47c>");
  instancedataforpoint.var_705fd52b7e08a3b1 = leveldataforvehicle.var_72e5ecefa1e310f0[pointref];
  instancedataforpoint.var_8c69bee942766d37 = leveldataforvehicle.var_8c69bee942766d37[pointref];
  kiosktag = leveldataforvehicle.kiosktagarrays[pointref];
  function_b38df110f76c5fd5(vehicle, pointref, kiosktag);
}

function function_32634a21e1b09dd7(vehicle, kioskid) {
  assert(isDefined(vehicle.kioskstructs), "<dev string:x4dd>");
  assert(isDefined(vehicle.kioskstructs[kioskid]), "<dev string:x4dd>");
  return vehicle.kioskstructs[kioskid];
}

function function_b38df110f76c5fd5(vehicle, kioskid, kiosktag) {
  if(!isDefined(vehicle.kioskstructs)) {
    vehicle.kioskstructs = [];
  }

  kiosk = spawnStruct();
  kiosk thread function_40ee39bbaed07062(vehicle, kiosktag);
  vehicle.kioskstructs[kioskid] = kiosk;
}

function function_40ee39bbaed07062(vehicle, kiosktag) {
  vehicle endon("death");

  while(true) {
    self.origin = vehicle gettagorigin(kiosktag);
    wait 0.5;
  }
}

function upgrade_activated(vehicle, upgradetype) {
  init_upgrade(vehicle);
  return isDefined(vehicle.upgradeactivated) && istrue(vehicle.upgradeactivated[upgradetype]);
}

function init_upgrade(vehicle) {
  if(!isDefined(vehicle.upgradeactivated)) {
    vehicle.upgradeactivated = [];
  }
}

function give_upgrade(vehicle, upgradetype, player) {
  set_upgrade_activated(vehicle, upgradetype);
  vehicle notify("give_upgrade", upgradetype, player);
}

function set_upgrade_activated(vehicle, upgradetype) {
  init_upgrade(vehicle);
  vehicle.upgradeactivated[upgradetype] = 1;
}

function fuel_is_enabled() {
  if(level.var_af2ad1dfcd5919b6) {
    return 0;
  }

  if(utility::callsharedfunc(#"game", #"isusingmatchrulesdata")) {
    return utility::callsharedfunc(#"game", #"getmatchrulesdata", "commonOption", "vehicleFuelEnabled");
  }

  return getdvarint(@ "hash_d8e266e83e6507f4", 0) == 1;
}

function private init_gas_stations() {
  level endon("game_ended");
  waitframe();

  if(!fuel_is_enabled()) {
    return;
  }

  if(getdvarint(@ "hash_48bb9b301ddec6d5", 0)) {
    utility::flag_wait("gas_station_create_script_initialized");
  }

  gasstations = [];

  foreach(gasstation in utility::getStructArray("gas_station", "targetname")) {
    scriptable = function_10d802507595088d(gasstation);
    gasstations[gasstations.size] = scriptable;
  }

  foreach(gasstation in utility::getStructArray("gas_station_marine", "targetname")) {
    scriptable = function_d04d1cfc18c6e2d0(gasstation);
    gasstations[gasstations.size] = scriptable;
  }

  foreach(gasstation in utility::getStructArray("charging_station", "targetname")) {
    struct = function_716915c972176706(gasstation);
    gasstations[gasstations.size] = struct;
  }

  function_74f59bfe412f9d11(gasstations);
  level.gasstations = gasstations;
  level.gasstationspawns = undefined;
  level.var_59beeaac5ae0103 = undefined;
  level.var_bf7bafd25df03005 = undefined;
}

function function_74f59bfe412f9d11(gasstationspawns) {
  if(!isDefined(gasstationspawns)) {
    return;
  }

  var_a9687b4f4899e655 = [];

  foreach(gasstation in gasstationspawns) {
    if(!isDefined(gasstation.triggertargetname)) {
      var_a9687b4f4899e655[var_a9687b4f4899e655.size] = gasstation;
      continue;
    }

    triggers = getnoentvolumearray(gasstation.triggertargetname, #targetname);
    gasstation.triggertargetname = undefined;

    if(!isDefined(triggers) || triggers.size == 0) {
      var_a9687b4f4899e655[var_a9687b4f4899e655.size] = gasstation;
      continue;
    }

    if(getdvarint(@ "hash_18e99507526e4c5d", 0)) {
      gasstation.triggers = triggers;

      foreach(trigger in triggers) {
        if(isDefined(trigger.struct) && isDefined(trigger.struct.radius)) {
          trigger.radiussquared = trigger.struct.radius * trigger.struct.radius;
        } else {
          trigger.radiussquared = gasstation.radiussquared;
        }

        gasstation thread function_c0c76b26f087eecf(trigger);
      }

      continue;
    }

    if(triggers.size == 1) {
      gasstation.trigger = triggers[0];
    } else {
      gasstation.trigger = sortbydistance(triggers, gasstation.origin)[0];
    }

    gasstation.trigger.radiussquared = gasstation.radiussquared;
    gasstation thread function_c0c76b26f087eecf(gasstation.trigger);
  }

  foreach(gasstation in var_a9687b4f4899e655) {
    radius = int(sqrt(gasstation.radiussquared));
    gasstation.trigger = spawn("noent_volume_trigger_radius", gasstation.origin - (0, 0, 200), 0, radius, 1000);
    gasstation.trigger.radiussquared = gasstation.radiussquared;
    gasstation thread function_c0c76b26f087eecf(gasstation.trigger);
  }
}

function private function_c0c76b26f087eecf(trigger) {
  if(isDefined(trigger)) {
    thread function_25e201cbedeb1f6d(trigger);
  }

  while(true) {
    trigger waittill("trigger", vehicle);

    if(!isDefined(vehicle) || !vehicle vehicle::is_vehicle() || !isDefined(vehicle.origin)) {
      continue;
    }

    if(!isDefined(vehicle.fuel)) {
      continue;
    }

    if(isDefined(vehicle.refuelingpercentage) || vehicle.repairing) {
      continue;
    }

    if(self.var_95a80d5cd68cee0e && vehicle vehicle::get_ref() != % "hash_38f9469ea4893813") {
      continue;
    }

    if(distance2dsquared(vehicle.origin, trigger.origin) > trigger.radiussquared) {
      continue;
    }

    driver = vehicle_occupancy::get_driver(vehicle);
    thread function_c4146d778f76e5c5(vehicle, trigger.origin, trigger.radiussquared, driver);
  }
}

function private function_25e201cbedeb1f6d(trigger) {
  wait 1.5;

  if(!(isDefined(trigger.struct) && isDefined(trigger.struct.radius))) {
    return;
  }

  scriptablesarray = getlootscriptablearrayinradius(undefined, undefined, trigger.origin, trigger.struct.radius * 5);

  foreach(scriptable in scriptablesarray) {
    if(isDefined(scriptable.interact) && isDefined(scriptable.interact.s_perk_machine)) {
      scriptable.ingasstation = 1;
    }
  }
}

function private spawn_gas_station(origin, radius, scriptablename) {
  level endon("game_ended");

  if(utility::callsharedfunc(#"poi", #"isSystemActive") && !istrue(utility::callsharedfunc(#"poi", #"isactive", origin))) {
    return;
  }

  if(utility::issharedfuncdefined(#"game", #"ispointwithininitialdangercircle") && ![[utility::getsharedfunc(#"game", #"ispointwithininitialdangercircle")]](origin)) {
    return;
  }

  if(isDefined(scriptablename)) {
    if(utility::issharedfuncdefined(#"logging", #"addevent")) {
      [[utility::getsharedfunc(#"logging", #"addevent")]]("<dev string:x51f>", scriptablename, "<dev string:x52d>", undefined, undefined, undefined, undefined, origin);
    }

    gasstation = spawnscriptable(scriptablename, origin);
  } else {
    gasstation = spawnStruct();
    gasstation.origin = origin;
  }

  gasstation.radiussquared = radius * radius;
  gasstation.minheight = origin[2] - 200;
  gasstation.maxheight = origin[2] + 1000 - 200;
  gasstation.var_7ed2d87e1b129d08 = gettime();
  return gasstation;
}

function function_10d802507595088d(gasstationstruct) {
  radius = gasstationstruct.script_noteworthy == "large" ? 600 : 400;
  scriptable = spawn_gas_station(gasstationstruct.origin, radius, "dmz_gas_station");

  if(scriptable) {
    scriptable.triggertargetname = gasstationstruct.target;

    if(!isDefined(level.gasstationspawns)) {
      level.gasstationspawns = [];
    }

    level.gasstationspawns[level.gasstationspawns.size] = scriptable;
  }

  return scriptable;
}

function function_d04d1cfc18c6e2d0(gasstationstruct) {
  scriptable = spawn_gas_station(gasstationstruct.origin, 650, "dmz_gas_station_marine");

  if(isDefined(scriptable)) {
    scriptable.triggertargetname = gasstationstruct.target;

    if(!isDefined(level.var_59beeaac5ae0103)) {
      level.var_59beeaac5ae0103 = [];
    }

    level.var_59beeaac5ae0103[level.var_59beeaac5ae0103.size] = scriptable;
  }

  return scriptable;
}

function function_716915c972176706(gasstationstruct) {
  radius = 400;

  if(isDefined(gasstationstruct.script_noteworthy)) {
    radius = float(gasstationstruct.script_noteworthy);
  }

  struct = spawn_gas_station(gasstationstruct.origin, radius);

  if(isDefined(struct)) {
    struct.var_95a80d5cd68cee0e = 1;
    struct.triggertargetname = gasstationstruct.target;

    if(!isDefined(level.var_bf7bafd25df03005)) {
      level.var_bf7bafd25df03005 = [];
    }

    level.var_bf7bafd25df03005[level.var_bf7bafd25df03005.size] = struct;
  }

  return struct;
}

function private function_c4146d778f76e5c5(vehicle, point, radiussquared, driver) {
  level endon("game_ended");
  currenttime = gettime();

  if(currenttime - 4000 > self.var_7ed2d87e1b129d08) {
    var_9436e120295fed17 = "veh_fuel_gas_station_service_bell";

    if(self.var_95a80d5cd68cee0e) {
      var_9436e120295fed17 = "veh_fuel_ev_station_service_bell_enter";
    }

    playsoundatpos(self.origin, var_9436e120295fed17);
    self.var_7ed2d87e1b129d08 = currenttime;
  }

  vehicleref = vehicle vehicle::get_ref();
  interactinfo = get_data(vehicleref);
  maxfuel = vehicle function_92f7f63d74bc91bc();
  isfuelonly = istrue(self.var_95a80d5cd68cee0e);
  vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647(maxfuel, isfuelonly);
  vehicle.evcharging = isfuelonly;
  wait 1;

  if(!(isDefined(vehicle.origin) && isDefined(vehicle) && isDefined(vehicle.maxhealth))) {
    if(isDefined(vehicle)) {
      vehicle.refuelingpercentage = undefined;
      vehicle.evcharging = undefined;
    }

    return;
  }

  if(distancesquared(vehicle.origin, point) >= radiussquared * 2.25) {
    vehicle.refuelingpercentage = undefined;
    vehicle.evcharging = undefined;
    return;
  }

  refilltime = interactinfo.var_b1b3d98efa01c5a5 ?? 30;

  if(isDefined(driver) && isDefined(driver.perks["specialty_trait_fast_refuel"])) {
    refilltime *= level.perkbundles["specialty_trait_fast_refuel"].refuelmod ?? 0.5;
  }

  refillamount = maxfuel / refilltime * 0.25;
  repairamount = vehicle.maxhealth / refilltime * 0.25;
  objidnum = undefined;
  var_e2fb7e50f8c58564 = gettime() + 2000;

  if(utility::issharedfuncdefined(#"game", #"requestobjectiveid")) {
    vehicle.curorigin = (0, 0, 0);
    vehicle.offset3d = (0, 0, 0);
    vehicle.objidnum = [[utility::getsharedfunc(#"game", #"requestobjectiveid")]](99);
    objidnum = vehicle.objidnum;
  }

  if(isDefined(objidnum) && objidnum != -1) {
    objective_delete(objidnum);
    objective_state(objidnum, "current");
    objective_setshowoncompass(objidnum, 1);
    objective_setplayintro(objidnum, 0);
    objective_setplayoutro(objidnum, 0);
    objective_setbackground(objidnum, 1);
    icon = vehicleref == % "hash_38f9469ea4893813" ? "ddos_emp_bolt" : "ui_map_icon_gas_refuel";
    objective_icon(objidnum, icon);
    objective_onentity(objidnum, vehicle);
    objective_setzoffset(objidnum, 75);
    objective_setshowprogress(objidnum, 1);
    objective_removeallfrommask(objidnum);
    objective_showtoplayersinmask(objidnum);
  }

  progressbarvisible = 0;
  vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647(maxfuel, isfuelonly);

  if(vehicle.refuelingpercentage < 0.99) {
    progressbarvisible = 1;

    foreach(occupant in vehicle.occupants) {
      vehicle function_24a07e6bdda36b21(occupant, objidnum, vehicleref);
    }
  }

  if(vehicle.health < vehicle.maxhealth && vehicle vehicle_damage::get_state() != "heavy") {
    playsoundatpos(vehicle.origin, "veh_repair_health");
  }

  while(isDefined(vehicle) && isDefined(vehicle.origin) && distancesquared(vehicle.origin, point) < radiussquared * 2.25) {
    if(!vehicle function_72e531fd35c679d9()) {
      vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647(maxfuel, isfuelonly);

      if(isDefined(objidnum) && objidnum != -1) {
        objective_setprogress(objidnum, vehicle.refuelingpercentage);
      }

      if(!progressbarvisible && vehicle.refuelingpercentage < 0.99) {
        progressbarvisible = 1;

        foreach(occupant in vehicle.occupants) {
          vehicle function_24a07e6bdda36b21(occupant, objidnum, vehicleref);
        }
      }

      wait 0.25;
      continue;
    }

    vehicle.fuel = min(maxfuel, vehicle.fuel + refillamount);
    vehicle vehicle_omnvar::function_9f4759fcb3acdc4(vehicle.fuel, maxfuel);

    if(!isfuelonly) {
      if(vehicle.health < vehicle.maxhealth && vehicle vehicle_damage::get_state() != "heavy") {
        vehicle vehicle_damage::add_health(repairamount);
      }
    }

    vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647(maxfuel, isfuelonly);

    if(isDefined(objidnum) && objidnum != -1) {
      objective_setprogress(objidnum, vehicle.refuelingpercentage);
    }

    if(progressbarvisible && vehicle.refuelingpercentage >= 0.99) {
      progressbarvisible = 0;

      foreach(occupant in vehicle.occupants) {
        vehicle function_2be7633e1c06b61c(occupant, objidnum, vehicleref, 1);
      }
    }

    if(!isfuelonly) {
      if(gettime() > var_e2fb7e50f8c58564) {
        var_e2fb7e50f8c58564 = gettime() + 2000;
        vehicle_damage::function_4b56eb7facbe21a6(vehicle);
      }
    }

    wait 0.25;
  }

  if(isDefined(vehicle) && progressbarvisible && isDefined(vehicle.occupants)) {
    foreach(occupant in vehicle.occupants) {
      vehicle function_2be7633e1c06b61c(occupant, objidnum, vehicleref, 1);
    }
  }

  if(isDefined(objidnum) && objidnum != -1 && utility::issharedfuncdefined(#"game", #"returnobjectiveid")) {
    [[utility::getsharedfunc(#"game", #"returnobjectiveid")]](objidnum);

    if(isDefined(vehicle)) {
      vehicle.objidnum = undefined;
    }
  }

  if(isDefined(vehicle)) {
    vehicle.refuelingpercentage = undefined;
    vehicle.evcharging = undefined;
  }
}

function function_92f7f63d74bc91bc() {
  data = get_data(vehicle::get_ref());
  maxfuel = data.maxfuel ?? 100;
  maxfuel *= self.spawndata.fuelmultiplier ?? 1;
  return maxfuel;
}

function function_72e531fd35c679d9() {
  return !isDefined(self.lasttimedamaged) || gettime() - self.lasttimedamaged >= 5000;
}

function private function_8e3678ef3f745647(maxfuel, isfuelonly) {
  if(isfuelonly) {
    return (self.fuel / maxfuel);
  }

  return 0.5 * self.fuel / maxfuel + 0.5 * self.health / self.maxhealth;
}

function on_enter_vehicle(vehicle, player) {
  if(isDefined(vehicle.refuelingpercentage) && vehicle.refuelingpercentage < 0.99) {
    vehicle function_24a07e6bdda36b21(player, vehicle.objidnum, vehicle vehicle::get_ref());
  }
}

function on_exit_vehicle(vehicle, player) {
  if(isDefined(vehicle.refuelingpercentage) && vehicle.refuelingpercentage < 0.99) {
    vehicle function_2be7633e1c06b61c(player, vehicle.objidnum, vehicle vehicle::get_ref());
  }
}

function private function_24a07e6bdda36b21(player, objidnum, vehicleref) {
  if(isDefined(objidnum) && objidnum != -1) {
    objective_addclienttomask(objidnum, player);
    objective_showtoplayersinmask(objidnum);
    objective_pinforclient(objidnum, player);
    objective_setshowpinnedprogressbar(2, player);
    refuelingtext = &"mp/refueling";

    if(vehicleref == % "hash_38f9469ea4893813") {
      refuelingtext = istrue(self.evcharging) ? &"mp/charging_fuel_only" : &"mp/charging";
    }

    objective_setpinnedprogressbartext(refuelingtext, player);
    function_954311ccae0b56f0(player, vehicleref);
  }
}

function private function_2be7633e1c06b61c(player, objidnum, vehicleref, success) {
  if(isDefined(objidnum) && objidnum != -1) {
    objective_removeclientfrommask(objidnum, player);
    objective_showtoplayersinmask(objidnum);
    objective_unpinforclient(objidnum, player);
    objective_setshowpinnedprogressbar(0, player);
    function_2e0206358d2dedca(player, vehicleref, success);
  }
}

function private function_954311ccae0b56f0(player, vehicleref) {
  if(isDefined(player)) {
    refuelingsound = vehicleref == % "hash_38f9469ea4893813" ? "uin_veh_fuel_ev_charger" : "uin_veh_fuel_gas_ticker";
    player playlocalsound(refuelingsound);
  }
}

function private function_2e0206358d2dedca(player, vehicleref, success) {
  if(isDefined(player)) {
    refuelingsound = "uin_veh_fuel_gas_ticker";
    var_5c1ddc2f27c9320 = "uin_veh_fuel_gas_ticker_stop";

    if(vehicleref == % "hash_38f9469ea4893813") {
      refuelingsound = "uin_veh_fuel_ev_charger";
      var_5c1ddc2f27c9320 = "uin_veh_fuel_ev_charger_stop";
    }

    player stoplocalsound(refuelingsound);

    if(success) {
      player playlocalsound(var_5c1ddc2f27c9320);
    }
  }
}

function init_fuel(vehicleref, vehicle, spawndata) {
  if(!vehicle vehicle::is_husk() && fuel_is_enabled() && !vehicle.isfromkillstreak) {
    vehicle.fuel = function_3449c0d22d6c9da(vehicleref);
    vehicle.fuel *= spawndata.fuelmultiplier ?? 1;
    vehicle thread function_d0aa8bbfd9d475ba(vehicleref, spawndata);
  }
}

function private function_3449c0d22d6c9da(vehicleref) {
  leveldataforvehicle = get_data(vehicleref);

  if(leveldataforvehicle.var_a5b1ad5fd2654e9a >= leveldataforvehicle.var_a5d4975fd28b65f0) {
    return leveldataforvehicle.var_a5b1ad5fd2654e9a;
  }

  return randomfloatrange(leveldataforvehicle.var_a5b1ad5fd2654e9a, leveldataforvehicle.var_a5d4975fd28b65f0);
}

function function_df89a6e21b8b4e65() {
  self notify("stop_fuel_usage");
}

function function_a21bb851f0405d37() {
  self.fuel = function_92f7f63d74bc91bc();
}

function private function_d0aa8bbfd9d475ba(vehicleref, spawndata) {
  self endon("death");
  self endon("stop_fuel_usage");
  level endon("game_ended");
  maxfuel = function_92f7f63d74bc91bc();

  if(maxfuel < 0) {
    return;
  }

  occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5(self);
  vehicle_omnvar::function_9f4759fcb3acdc4(self.fuel, maxfuel);
  topspeed = self vehicle_gettopspeedforward();
  lowFuel = 0;
  outOfFuel = 0;
  lowfuelsound = "uin_veh_warning_low_fuel";
  outoffuelsound = "uin_veh_warning_out_of_fuel";

  if(vehicle::ishelicopter()) {
    lowfuelsound = "uin_veh_warning_low_fuel_heli";
    outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
  }

  while(true) {
    wait 1;

    if(self.ishovering || !self.isempty && isPlayer(vehicle_occupancy::get_driver(self))) {
      speedfraction = min(vehicle::ishelicopter() ? 1 : self vehicle_getspeed() / topspeed, 1);
      self.fuel = max(self.fuel - speedfraction, 0);
    }

    if(getdvarint(@ "hash_f6ba20712f854462", 0) == 1) {
      self.fuel = maxfuel;
      outOfFuel = 0;
    }

    vehicle_omnvar::function_9f4759fcb3acdc4(self.fuel, maxfuel);

    if(self.fuel <= 0 && !outOfFuel) {
      outOfFuel = 1;
      vehicle_occupancy::disable_engine();
      vehicle_occupancy::function_961dfeea38feb976();
      vehicle_occupancy::allow_movement(self, 0, 0);
      vehicle_omnvar::show_warning("outOfFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5(self), vehicleref);

      if(utility::issharedfuncdefined(vehicleref, #"outOfFuel")) {
        [[utility::getsharedfunc(vehicleref, #"outOfFuel")]]();
      }

      callback::callback("vehicle_out_of_fuel", {
        #vehicleref: vehicleref, #player: self
      });
      function_a92ce326fa1c7bb9(lowfuelsound);
      function_20367b377c5ed9b3(outoffuelsound);
    } else if(self.fuel > 0 && outOfFuel) {
      outOfFuel = 0;
      function_a92ce326fa1c7bb9(outoffuelsound);
      vehicle_occupancy::enable_engine();
      vehicle_occupancy::function_b901181db6fc2774();
      vehicle_occupancy::allow_movement(self, 1);
      vehicle_omnvar::hide_warning("outOfFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5(self), vehicleref);
    }

    if(self.fuel <= 25 && self.fuel > 0 && !lowFuel) {
      lowFuel = 1;
      vehicle_omnvar::show_warning("lowFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5(self), vehicleref);
      function_20367b377c5ed9b3(lowfuelsound);
      player = vehicle_occupancy::get_driver(self);

      if(isDefined(player) && utility::issharedfuncdefined(#"hud", #"ftue_triggerTip")) {
        closestgasstation = undefined;
        var_2f2d5cf5237088a = undefined;

        foreach(gasstation in level.gasstations) {
          if(!isDefined(closestgasstation)) {
            closestgasstation = gasstation;
            var_2f2d5cf5237088a = distancesquared(self.origin, gasstation.origin);
          }

          distancesqr = distancesquared(self.origin, gasstation.origin);

          if(distancesqr < var_2f2d5cf5237088a) {
            closestgasstation = gasstation;
            var_2f2d5cf5237088a = distancesquared(self.origin, gasstation.origin);
          }
        }
      }

      continue;
    }

    if((self.fuel > 25 || self.fuel <= 0) && lowFuel) {
      lowFuel = 0;
      vehicle_omnvar::hide_warning("lowFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5(self), vehicleref);
      function_a92ce326fa1c7bb9(lowfuelsound);
    }
  }
}

function private function_20367b377c5ed9b3(soundaliasname) {
  if(soundexists(soundaliasname)) {
    foreach(occupant in vehicle_occupancy::function_8ed9bcd8e9ea74f5(self)) {
      occupant stoplocalsound(soundaliasname);
      occupant playlocalsound(soundaliasname);
    }
  }
}

function private function_a92ce326fa1c7bb9(soundaliasname) {
  if(soundexists(soundaliasname)) {
    foreach(occupant in vehicle_occupancy::function_8ed9bcd8e9ea74f5(self)) {
      occupant stoplocalsound(soundaliasname);
    }
  }
}

function function_168dac01f9aa2882(vehicle, gascancount, var_3df97f2404d99e4c, isexternaluse = 0) {
  if(!(isDefined(vehicle) && isDefined(vehicle.fuel))) {
    if(var_3df97f2404d99e4c) {
      return % "mp/cannot_use_gas_can_palfa";
    }

    return % "mp/cannot_use_gas_can";
  }

  ref = vehicle vehicle::get_ref();
  interactinfo = get_data(ref);

  if(level.var_1597e9e336c903e4 && !var_3df97f2404d99e4c && ref == % "hash_1dd941f8f4026e3") {
    return % "mp/cannot_use_gas_can_in_palfa";
  }

  if(var_3df97f2404d99e4c && ref != % "hash_1dd941f8f4026e3") {
    return % "mp/cannot_use_gas_can_palfa";
  }

  if(!var_3df97f2404d99e4c && (!isDefined(gascancount) || gascancount == 1)) {
    return % "mp/gas_can_is_empty";
  }

  if(ref == % "hash_38f9469ea4893813") {
    return % "mp/cannot_use_gas_can_electric";
  }

  if(vehicle function_92f7f63d74bc91bc() - vehicle.fuel < 1) {
    return % "mp/vehicle_full_gas";
  }

  if(!isexternaluse && interactinfo.var_5c3ccffdcf2e7d20) {
    return % "hash_33c5fc4187ae6d15";
  }
}

function function_6214761422372f09(gascan, var_3df97f2404d99e4c) {
  vehicle = vehicle::get_vehicle();
  var_7237854e3be197ca = function_168dac01f9aa2882(vehicle, gascan.count, var_3df97f2404d99e4c);

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  ref = vehicle vehicle::get_ref();
  refillamount = gascan.count - 1;

  if(var_3df97f2404d99e4c && ref == % "hash_1dd941f8f4026e3") {
    refillamount = 1000;
  }

  maxfuel = vehicle function_92f7f63d74bc91bc();

  if(vehicle.fuel + refillamount > maxfuel) {
    refillamount = int(floor(maxfuel - vehicle.fuel));
  }

  vehicle.fuel = min(maxfuel, vehicle.fuel + refillamount);

  if(var_3df97f2404d99e4c) {
    gascan.count = 0;
  } else {
    gascan.count -= refillamount;

    if(gascan.count < 1) {
      gascan.count = 1;
    }
  }

  vehicle vehicle_omnvar::function_9f4759fcb3acdc4();
  callback::callback("player_refuel_vehicle_with_gas_can", {
    #vehicle: vehicle, #player: self
  });
  return undefined;
}

function function_c3012fe6747e95bd(gascancount) {
  vehicle = vehicle::get_vehicle();

  if(!(isDefined(vehicle) && isDefined(vehicle.fuel))) {
    return [%"mp/cannot_use_gas_can", gascancount];
  }

  if(vehicle.fuel < 1) {
    return [%"hash_4d21ffc144e21f60", gascancount];
  }

  if(!isDefined(gascancount) || gascancount == 150) {
    return [%"mp/gas_can_full", gascancount];
  }

  ref = vehicle vehicle::get_ref();

  if(ref == % "hash_38f9469ea4893813") {
    return ["MP/GAS_CAN_SIPHON_ON_EV", gascancount];
  }

  siphonamount = 150 - gascancount + 1;

  if(vehicle.fuel < siphonamount) {
    siphonamount = int(floor(vehicle.fuel));
  }

  vehicle.fuel = max(0, vehicle.fuel - siphonamount);
  gascancount += siphonamount - 1;

  if(gascancount > 150) {
    gascancount = 150;
  }

  vehicle vehicle_omnvar::function_9f4759fcb3acdc4();
  callback::callback("player_siphoned_vehicle", {
    #vehicle: vehicle, #player: self
  });
  return [undefined, gascancount];
}

function on_damage(data) {
  if(isPlayer(data.attacker) && isagent(self.aidriver) && isalive(self.aidriver) && !self.aidriver isincombat()) {
    utility::callsharedfunc(#"stealth", #"event_broadcast_generic", "gunshot_impact", data.point ?? self.origin, 500, self);
  }

  if(self.playedcaralarm || isDefined(self.lastplayedcaralarm) && self.lastplayedcaralarm >= gettime() || !istrue(self.isempty)) {
    return;
  }

  didplay = car_alarm_on(5);

  if(didplay) {
    if(isDefined(level.var_ceb922993e45aec6)) {
      self.lastplayedcaralarm = gettime() + level.var_ceb922993e45aec6;
      return;
    }

    self.playedcaralarm = 1;
  }
}

function car_alarm_on(time) {
  self notify("420fa20f84709b01");
  self endon("420fa20f84709b01");

  if(vehicle::is_husk()) {
    return false;
  }

  vehicleleveldata = get_data(vehicle::get_ref());

  if(!isDefined(level.caralarmenabled)) {
    level.caralarmenabled = getdvarint(@ "hash_e42fc7d1e9196cff", 1) == 1;
  }

  if(!level.caralarmenabled || !vehicleleveldata.alarmpartname || vehicleleveldata.alarmpartname == "" || !self getscriptablehaspart(vehicleleveldata.alarmpartname) || !self getscriptableparthasstate(vehicleleveldata.alarmpartname, "on")) {
    return false;
  }

  self endon("death");
  self setscriptablepartstate(vehicleleveldata.alarmpartname, "on");
  utility::callsharedfunc(#"stealth", #"event_broadcast_generic", "cover_blown", self.origin, 2500, self);
  params = {
    #vehicle: self
  };
  callback::callback("car_alarm_on", params);
  function_e125e0390adb1522(time);

  if(self getscriptableparthasstate(vehicleleveldata.alarmpartname, "off")) {
    self setscriptablepartstate(vehicleleveldata.alarmpartname, "off");
  }

  callback::callback("car_alarm_off", params);
  return true;
}

function private function_e125e0390adb1522(seconds) {
  self endon("vehicle_owner_update");
  wait level.vehiclealarmtime ?? seconds;
}

function function_867ea9d5b4458d20() {
  if(!level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0) {
    return;
  }

  if(self.enginelightson) {
    return;
  }

  ref = vehicle::get_ref();

  if(!isDefined(ref) || !vehicle::has_data(ref)) {
    return;
  }

  data = vehicle::get_data(ref);

  if(!(isDefined(data.interact) && isDefined(data) && isDefined(data.interact.lights)) || data.interact.lights.size == 0) {
    return;
  }

  isnight = utility::isnightmap();

  foreach(light in data.interact.lights) {
    if(light.type == "engine_is_on_day_and_night" && self getscriptablepartstate(light.tag, 1) == "off") {
      self setscriptablepartstate(light.tag, "on", 1);
    } else if(isnight && light.type == "engine_is_on_at_night" && self getscriptablepartstate(light.tag, 1) == "off") {
      self setscriptablepartstate(light.tag, "on", 1);
    }

    self.enginelightson = 1;
  }
}

function function_e3ff6fb751c623a() {
  if(!level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0) {
    return;
  }

  if(!self.enginelightson) {
    return;
  }

  ref = vehicle::get_ref();

  if(!isDefined(ref) || !vehicle::has_data(ref)) {
    return;
  }

  data = vehicle::get_data(ref);

  if(!(isDefined(data.interact) && isDefined(data) && isDefined(data.interact.lights)) || data.interact.lights.size == 0) {
    return;
  }

  isnight = utility::isnightmap();

  foreach(light in data.interact.lights) {
    if(light.type == "engine_is_on_day_and_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
      continue;
    }

    if(isnight && light.type == "engine_is_on_at_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
    }
  }

  self.enginelightson = undefined;
}

function update_occupancy_lights() {
  if(!level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0) {
    return;
  }

  ref = vehicle::get_ref();

  if(!isDefined(ref) || !vehicle::has_data(ref)) {
    return;
  }

  data = vehicle::get_data(ref);

  if(!isDefined(data.interact.lights) || data.interact.lights.size == 0) {
    return;
  }

  var_ca904eadcab99f66 = !istrue(self.isempty);

  if(var_ca904eadcab99f66 && !self.occupancylightson) {
    function_6fb338fa250705a3(data);
    return;
  }

  if(!var_ca904eadcab99f66 && self.occupancylightson) {
    function_ae4f431f6e986187(data);
  }
}

function private function_6fb338fa250705a3(data) {
  isnight = utility::isnightmap();

  foreach(light in data.interact.lights) {
    if(light.type == "occupied_day_and_night" && self getscriptablepartstate(light.tag, 1) == "off") {
      self setscriptablepartstate(light.tag, "on", 1);
      continue;
    }

    if(isnight && light.type == "occupied_at_night" && self getscriptablepartstate(light.tag, 1) == "off") {
      self setscriptablepartstate(light.tag, "on", 1);
    }
  }

  self.occupancylightson = 1;
}

function private function_ae4f431f6e986187(data) {
  isnight = utility::isnightmap();

  foreach(light in data.interact.lights) {
    if(light.type == "occupied_day_and_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
      continue;
    }

    if(isnight && light.type == "occupied_at_night" && self getscriptablepartstate(light.tag, 1) == "on") {
      self setscriptablepartstate(light.tag, "off", 1);
    }
  }

  self.occupancylightson = undefined;
}

function function_ca5f55b11d5b4274() {
  if(!level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0) {
    return;
  }

  ref = vehicle::get_ref();

  if(!isDefined(ref) || !vehicle::has_data(ref)) {
    return;
  }

  data = vehicle::get_data(ref);

  if(!(isDefined(data.interact) && isDefined(data) && isDefined(data.interact.lights))) {
    return;
  }

  foreach(light in data.interact.lights) {
    if(light.type == "opening_door") {
      self setscriptablepartstate(light.tag, "on", 1);
    }
  }
}

function lights_on(var_35093a42728ddcc1, overridestate) {
  set_light_state(var_35093a42728ddcc1, "on", overridestate);
}

function lights_off(var_35093a42728ddcc1, overridestate) {
  set_light_state(var_35093a42728ddcc1, "off", overridestate);
}

function set_light_state(var_35093a42728ddcc1, state, overridestate) {
  ref = vehicle::get_ref();

  if(!isDefined(ref) || !vehicle::has_data(ref)) {
    return;
  }

  data = vehicle::get_data(ref);

  if(!(isDefined(data.interact) && isDefined(data) && isDefined(data.interact.lights))) {
    return;
  }

  foreach(light in data.interact.lights) {
    if(!self getscriptablehaspart(light.tag)) {
      continue;
    }

    if(self getscriptablepartstate(light.tag) == "death") {
      continue;
    }

    if(isDefined(var_35093a42728ddcc1) && !isarray(var_35093a42728ddcc1) && var_35093a42728ddcc1 != "all" && light.group != var_35093a42728ddcc1) {
      continue;
    }

    if(isarray(var_35093a42728ddcc1) && !arraycontains(var_35093a42728ddcc1, light.tag)) {
      continue;
    }

    if(isDefined(overridestate) && self getscriptablepartstate(light.tag, overridestate)) {
      self setscriptablepartstate(light.tag, overridestate);
      continue;
    }

    self setscriptablepartstate(light.tag, state);
  }
}

function function_47e6a0e01f805a2e(var_35093a42728ddcc1) {
  if(!(isDefined(self) && isDefined(self.damageableparts))) {
    return;
  }

  ref = vehicle::get_ref();

  if(!isDefined(ref) || !vehicle::has_data(ref)) {
    return;
  }

  data = vehicle::get_data(ref);

  if(!(isDefined(data.interact) && isDefined(data) && isDefined(data.interact.lights))) {
    return;
  }

  foreach(light in data.interact.lights) {
    if(isDefined(var_35093a42728ddcc1) && !isarray(var_35093a42728ddcc1) && light.group != var_35093a42728ddcc1) {
      continue;
    }

    if(isarray(var_35093a42728ddcc1) && !arraycontains(var_35093a42728ddcc1, light.tag)) {
      continue;
    }

    self.damageableparts[light.tag] = undefined;
  }
}

function function_253eb8c405fef8f2() {
  self.var_34b3e5f444f2a5f0 = 1;
}

function init_dev() {
  forceseatid = setdvarifuninitialized(@ "hash_fb517a5a3d736fa0", 0);
}

function function_ec354bb85bc131b2(vehicle) {
  instancedataforvehicle = function_29894e0fa6bf739(vehicle, 0);
  return getarraykeys(instancedataforvehicle.pointdata);
}

function function_3099e0a58dde7fff() {
  return "<dev string:x53f>";
}

# /