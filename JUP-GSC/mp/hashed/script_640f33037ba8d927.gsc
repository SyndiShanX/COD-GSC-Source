/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_640f33037ba8d927.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\utility\game;
#namespace namespace_1d412d516148e9b4;

function main() {
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh9_palfa");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_space_shipment_transport");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("little_bird");
  level thread init();

  level thread function_d6cfd14bfd2f0341();
}

function function_d6cfd14bfd2f0341() {
  if(getdvarint(@ "hash_c7c28f6839077045", 0)) {
    setDvar(@ "hash_416e5db4a55fedd9", 1);
    setDvar(@ "hash_82a69447b1c6aca1", 0);
    setDvar(@ "hash_4e43ead19ea87ecd", 0);
    setDvar(@ "hash_7dfd74ebfae4f209", 1);
  }
}

function init() {
  callback::add("player_vehicle_exit", &function_49cfeec2947a199c);

  if(getdvarint(@ "hash_2d70e59130fe03d9", 1) == 1) {
    callbacks::add("br_pickup_created", &function_82fb10ddff2170e7);
  }

  level thread function_6e3c1a25a2bcf899();
  level.var_54d973dccda0ef8b = &function_93c1540bbbb4de0b;
}

function function_93c1540bbbb4de0b(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!isPlayer(ent)) {
    return false;
  }

  if(!isDefined(level.var_55f74552ec70e1)) {
    return false;
  }

  if(distance2d(ent.origin, level.var_55f74552ec70e1.origin) > 1500) {
    return false;
  }

  if(abs(ent.origin[2] - level.var_55f74552ec70e1.origin[2]) > 800) {
    return false;
  }

  return true;
}

function function_6e3c1a25a2bcf899() {
  waittillframeend();
  level.var_f4b5441cbb768e84 = getStruct("flying_shipment_start", "targetname");
  path = get_path();
  level thread debug_path();
  level thread function_102dcc15b70e211a();
  level thread function_2ac6faaebdc20e28();
  level.space_shipment_radius_home = getStruct("space_shipment_radius_home", "targetname");
  level.var_db59b77ee6bc388a = getStruct("space_shipment_radius_limit", "targetname");
  level.var_48728117391ac630 = spawnStruct();
  level.var_48728117391ac630.origin = getdvarvector(@ "hash_8994e88f7781a490", (0, 0, 5000));
  level.var_48728117391ac630.radius = getdvarint(@ "hash_7f6629e51931a404", 10000);
  level.var_48728417391accc9 = spawnStruct();
  level.var_48728417391accc9.origin = getdvarvector(@ "hash_f1c5972db70415d3", (-2000, 6000, 5000));
  level.var_48728417391accc9.radius = getdvarint(@ "hash_fdbf3e238cbfc4ff", 9000);
  level.var_48728317391aca96 = spawnStruct();
  level.var_48728317391aca96.origin = getdvarvector(@ "hash_a75df99e6027e0da", (0, -4000, 5000));
  level.var_48728317391aca96.radius = getdvarint(@ "hash_3821b93c0900bb8e", 10000);

  if(getdvarint(@ "hash_7dfd74ebfae4f209", 0)) {
    thread draw_circle(level.var_48728117391ac630.origin, level.var_48728117391ac630.radius, (1, 0, 0), 1, 0, 10000);
    thread draw_circle(level.var_48728417391accc9.origin, level.var_48728417391accc9.radius, (1, 0, 0), 1, 0, 10000);
    thread draw_circle(level.var_48728317391aca96.origin, level.var_48728317391aca96.radius, (1, 0, 0), 1, 0, 10000);
  }

  level.limbo_flying_shipment_loot_ref = getStruct("limbo_flying_shipment_loot_ref", "targetname");

  if(!isDefined(level.limbo_flying_shipment_loot_ref.angles)) {
    level.limbo_flying_shipment_loot_ref.angles = (0, 0, 0);
  }

  level.limbo_flying_shipment_loot_ref.loot_spots = getStructArray(level.limbo_flying_shipment_loot_ref.target, "targetname");
  function_56940da4beb24898(path);
}

function get_path() {
  if(!isDefined(level.var_bd5d23b9d4c065b7)) {
    var_ff600e44d1fa41d = getdvarint(@ "hash_dfca02d1fc7d4665", 5300);
    points = [];
    level.var_bd5d23b9d4c065b7 = level.var_f4b5441cbb768e84;

    if(!isDefined(level.var_bd5d23b9d4c065b7)) {
      level.var_bd5d23b9d4c065b7 = spawnStruct();
      level.var_bd5d23b9d4c065b7.origin = (443, 2028.62, 5000);
    }

    struct = level.var_bd5d23b9d4c065b7;
    points[points.size] = struct;

    while(isDefined(struct.target)) {
      struct.target = getStruct(struct.target, "targetname");
      struct = struct.target;
      points[points.size] = struct;
    }

    level.var_bd5d23b9d4c065b7.points = points;

    if(var_ff600e44d1fa41d > 0) {
      foreach(point in level.var_bd5d23b9d4c065b7.points) {
        point.origin = (point.origin[0], point.origin[1], var_ff600e44d1fa41d);
      }
    }
  }

  return level.var_bd5d23b9d4c065b7;
}

function function_49cfeec2947a199c(params) {
  vehicle = params.vehicle;
  vehicle endon("death");

  if(!is_equal(vehicle.targetname, "veh_jup_space_shipment_transport")) {
    return;
  }

  if(!vehicle hascomponent("p2p")) {
    vehicle addcomponent("p2p");
  }

  if(istrue(vehicle.returning)) {
    vehicle thread function_10784bbdd1979fe6();

    vehicle function_1c952754074bd3a1(vehicle.origin, 0, 2, 0.7, 0.25, 0, 0.35);
    maxspeed = getdvarint(@ "hash_14ca9a67e7678f3a", 200);
    vehicle function_77320e794d35465a("p2p", "manualSpeed", maxspeed);
    vehicle function_77320e794d35465a("p2p", "goalPoint", level.space_shipment_radius_home.origin);
    vehicle function_77320e794d35465a("p2p", "goalAngles", flat_angle(vectortoangles(level.space_shipment_radius_home.origin - vehicle.origin)));
    vehicle function_77320e794d35465a("p2p", "goalThreshold", level.space_shipment_radius_home.radius);
    vehicle childthread scriptstablizeflyingshipment();
    vehicle waittill_any_2("goal", "near_goal");
    vehicle.returning = 0;
  } else if(getdvarint(@ "hash_dd470278202c3c1d", 1)) {
    vehiclevelocity = vehicle vehicle_getvelocity();
    var_997deff038bae484 = vectorNormalize(vehiclevelocity);
    vehiclespeed = length(vehiclevelocity);

    if(vehiclespeed > getdvarint(@ "hash_4ac88472c5fdeb6d", 450)) {
      vehicle function_1c952754074bd3a1(vehicle.origin + 256 * var_997deff038bae484, 0, 2, 0.7, 0.25, 0, 0.35);
    }
  }

  vehicle thread wander_map();
}

function debug_path() {
  path = get_path();

  while(true) {
    for(i = 0; i < path.points.size; i++) {
      sphere(path.points[i].origin, 32, (1, 1, 1), 0, 1);
    }

    waitframe();
  }
}

function function_56940da4beb24898(path) {
  if(matchmakinggame()) {
    scripts\mp\flags::gameflagwait("infil_animatic_complete");
  }

  spawndata = spawnStruct();
  spawndata.origin = path.origin;
  spawndata.angles = vectortoangles(path.points[1].origin - path.points[0].origin);
  spawndata.spawntype = "GAME_MODE";
  spawndata.var_cae20238ee346e02 = 1;
  vehicledata = function_29b4292c92443328("veh_jup_space_shipment_transport");
  vehicledata.interact.var_c57febc7e53e3276 = 1;

  if(!getdvarint(@ "hash_b57c0891c69a1cb6", 0)) {
    vehicle = scripts\mp\gametypes\br_vehicles::spawnavehicle("veh_jup_space_shipment_transport", spawndata);
  } else if(getdvarint(@ "hash_b57c0891c69a1cb6", 0) == 1) {
    vehicle = scripts\mp\gametypes\br_vehicles::spawnavehicle("veh9_palfa", spawndata);
  } else {
    vehicle = scripts\mp\gametypes\br_vehicles::spawnavehicle("little_bird", spawndata);
  }

  if(!isDefined(vehicle)) {
    return;
  }

  vehicle.nullownerdamagefunc = &function_ffd405aecfd3d5b3;
  vehicle.godmode = 1;
  vehicle thread function_f127b537c5a07e5d();
  vehicle.var_9bd69326cfeb9fe9 = 1;

  if(getdvarint(@ "hash_26fe4f325c2ec824", 1)) {
    vehicle.override_unresolved_collision = &override_unresolved_collision;
  }

  nav_island_test = getEnt("nav_island_test", "targetname");

  if(isDefined(nav_island_test) && !getdvarint(@ "hash_d3e0f40dc366491e", 0)) {
    nav_island_test delete();
  }

  if(isDefined(nav_island_test)) {
    nav_island_test unlink();
    nav_island_test.origin = vehicle.origin + (0, 0, 300) - 300 * vectorNormalize(anglesToForward(vehicle.angles));
    nav_island_test linkTo(vehicle);
    vehicle.nav_island_test = nav_island_test;

    for(i = 1; i < 4; i++) {
      origin = vehicle gettagorigin("tag_loot_0" + i);
      ai = [[level.var_46421a8209361ea5]](origin);
    }
  }

  level.flying = vehicle;
  level thread function_d8ebb244badd9649(vehicle);

  reflection_probe = getEntArray("space_shipment_probes", "targetname");

  foreach(probe in reflection_probe) {
    probe unlink();
    probe linkTo(vehicle);
  }

  if(!isDefined(level.var_6fd795bdfd20074e)) {
    level.var_6fd795bdfd20074e = [];
  }

  struct = spawnStruct();
  struct.vehicle = vehicle;
  struct.distsq = 640000;
  level.var_6fd795bdfd20074e = array_add(level.var_6fd795bdfd20074e, struct);
  vehicle thread function_a3ecc821dbd5e9ed(path);
  vehicle thread spawn_loot();
  vehicle thread wander_map();
  vehicle thread watch_for_kickflip();
  vehicle.var_927a3bee873e1d8f = "tag_door_left_animate";
  level.var_55f74552ec70e1 = vehicle;
  return vehicle;
}

function watch_for_kickflip() {
  vehicle = self;
  vehicle notify("watch_for_kickflip");
  vehicle endon("watch_for_kickflip");
  vehicle endon("death");
  var_734426c18ce77585 = getdvarint(@ "hash_1894b901402db966", 3500);
  var_8110b53c967e6a9b = getdvarint(@ "hash_1b7fc2098b685e76", 65);

  if(!getdvarint(@ "hash_8147841e7a277a8d", 1)) {
    return;
  }

  while(isDefined(vehicle)) {
    if(vehicle hascomponent("p2p")) {
      waitframe();
      continue;
    }

    var_678b5473b06109c7 = lengthsquared(vehicle vehicle_getangularvelocity());
    currentangle = lengthsquared(vehicle.angles);
    var_fc8c06e5f7229ea7 = var_678b5473b06109c7 > var_734426c18ce77585;
    currentangle = scripts\engine\math::anglebetweenvectorsunit((0, 0, 1), anglestoup(self.angles));
    var_e31a5db1ba95c0e5 = currentangle > var_8110b53c967e6a9b;

    if(!var_fc8c06e5f7229ea7 && !var_e31a5db1ba95c0e5) {
      waitframe();
      continue;
    }

    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self);

    while(!vehicle hascomponent("p2p")) {
      waitframe();
      continue;
    }

    vehicle vehicle_setangularvelocity((0, 0, 0));
    waitframe();
  }
}

function override_unresolved_collision(player, var_4258fb168fb20ba6) {
  iprintlnbold("<dev string:x1c>");

  if(getdvarint(@ "hash_12d8cedf212f9a5a", 0)) {
    scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer(self, player, 1);
  }
}

function function_2ac6faaebdc20e28() {
  level endon("game_ended");

  while(true) {
    if(isDefined(level.var_55f74552ec70e1)) {
      break;
    }

    wait 1;
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    if(isDefined(level.var_71984ba28e527860)) {
      break;
    }

    wait 1;
  }

  while(true) {
    foreach(player in level.players) {
      var_2d58e8aae155cc83 = distance2d(level.var_55f74552ec70e1.origin, player.origin);

      if(var_2d58e8aae155cc83 < 1000 && !isDefined(player.var_dd38669292941f5)) {
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("limbo_shipmentNear", player, 1, 0);
        player.var_dd38669292941f5 = 1;
        player thread function_f29ea5f68b6f1af6();
      }
    }

    wait 1;
  }
}

function function_f29ea5f68b6f1af6() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 180;
  self.var_dd38669292941f5 = undefined;
}

function function_102dcc15b70e211a() {
  level endon("game_ended");

  while(true) {
    if(function_d8d4e1532346984a()) {
      break;
    }

    wait 1;
  }

  level.var_71984ba28e527860 = 1;
}

function function_d8d4e1532346984a() {
  foreach(player in level.players) {
    if(player.origin[2] < level.var_55f74552ec70e1.origin[2] + 300 && player.origin[2] > level.var_55f74552ec70e1.origin[2]) {
      return true;
    }
  }

  return false;
}

function function_fd3cd0253843b763(vehicle) {
  while(isDefined(vehicle) && isDefined(vehicle.nav_island_test)) {
    line(vehicle.origin, vehicle.nav_island_test.origin, (1, 1, 1), 1, 0, 1);
    waitframe();
  }
}

function function_8c120031c64dbc05() {
  vehicle = self;

  if(isDefined(vehicle.occupants["driver"])) {
    player = vehicle.occupants["driver"];
    vehicle.returning = 1;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(vehicle, "driver", player);
    player setvelocity((0, 0, 0));
  }

  vehicle setscriptablepartstate("single", "vehicle_returning");
  vehicle thread function_fc183755db9eb3();
}

function function_fc183755db9eb3() {
  vehicle = self;
  vehicle endon("death");

  while(true) {
    if(distance2d(self.origin, level.space_shipment_radius_home.origin) < level.space_shipment_radius_home.radius) {
      break;
    }

    wait 0.5;
  }

  vehicle setscriptablepartstate("single", "vehicle_use");
  wait 5;
  vehicle thread function_f127b537c5a07e5d();
}

function function_f127b537c5a07e5d() {
  self endon("death");

  while(isDefined(self)) {
    if(distance2d(self.origin, level.var_48728117391ac630.origin) > level.var_48728117391ac630.radius && distance2d(self.origin, level.var_48728417391accc9.origin) > level.var_48728417391accc9.radius && distance2d(self.origin, level.var_48728317391aca96.origin) > level.var_48728317391aca96.radius) {
      function_8c120031c64dbc05();
      return;
    }

    wait 0.5;
  }
}

function wander_map() {
  vehicle = self;
  vehicle notify("wander_map");
  vehicle endon("wander_map");
  move_path = get_path();
  vehicle addcomponent("p2p");
  vehicle addcomponent("path");
  speed = getdvarint(@ "hash_a4af2500a18d6e9f", 200);
  speed_mph = ips_to_mph(speed);

  vehicle thread function_10784bbdd1979fe6();

  while(true) {
    vehicle setyawspeedbyname("slow");
    vehicle.var_d9ca4757da7a9a6 = 1;
    vehicle function_77320e794d35465a("p2p", "manualSpeed", speed);
    vehicle childthread scriptstablizeflyingshipment();
    vehicle childthread scripts\common\vehicle_paths::vehicle_paths_helicopter(move_path.points[0]);
    vehicle waittill("reached_dynamic_path_end");
  }
}

function scriptstablizeflyingshipment() {
  vehicle = self;
  timestep = 0.1;

  if(!getdvarint(@ "hash_a3732c7e8c69ef68", 1)) {
    return;
  }

  vehicle notify("scriptStablizeFlyingShipment");
  vehicle endon("scriptStablizeFlyingShipment");

  while(isDefined(vehicle)) {
    if(!vehicle hascomponent("p2p")) {
      return;
    }

    x = 0;
    y = self.angles[1];
    z = 0;
    var_bab97b1de1dc0b9d = (x, y, z);
    stop_duration = 1;
    stop_value = 1;
    cur_weight = 0.5;
    var_1cc8d25d6f1a4145 = 0.5;
    vehicle function_6d14d24a1888c646(var_bab97b1de1dc0b9d, stop_duration, stop_value, cur_weight, var_1cc8d25d6f1a4145);
    wait timestep;
  }
}

function function_10784bbdd1979fe6() {
  self endon("<dev string:x46>");
  self notify("<dev string:x4f>");
  self endon("<dev string:x4f>");

  while(isDefined(self) && isDefined(self.currentnode)) {
    line(self.origin, self.currentnode.origin, (0, 1, 0), 1, 0, 1);
    waitframe();
  }
}

function spawn_loot() {
  vehicle = self;
  vehicle endon("entitydeleted");

  while(!isDefined(level.br_pickups)) {
    waitframe();
  }

  ref = level.limbo_flying_shipment_loot_ref;
  var_5f3c22cdb001de2c = anglesToForward(ref.angles);

  foreach(loot_spot in level.limbo_flying_shipment_loot_ref.loot_spots) {
    loot_spot.var_264fc2e617ad4a3 = distance2d(loot_spot.origin, ref.origin);
    loot_spot.var_d5f51aabafa981d4 = vectortoangles(ref.origin - loot_spot.origin);
    loot_spot.var_d5f51aabafa981d4 = flat_angle(loot_spot.var_d5f51aabafa981d4);
    loot_spot.rightoffset = loot_spot.var_264fc2e617ad4a3 * sin(loot_spot.var_d5f51aabafa981d4[1]);
    loot_spot.forwardoffset = loot_spot.var_264fc2e617ad4a3 * cos(loot_spot.var_d5f51aabafa981d4[1]);
    loot_spot.verticaloffset = loot_spot.origin - ref.origin;
    loot_spot.verticaloffset = (0, 0, loot_spot.verticaloffset[2]);
    loot_spot.anglesoffset = flat_angle(loot_spot.angles - ref.angles);
  }

  foreach(loot_spot in level.limbo_flying_shipment_loot_ref.loot_spots) {
    scriptablename = "br_loot_cache_lege_novehiclecollision";

    if(is_equal(loot_spot.script_noteworthy, "isBuyStation")) {
      if(!getdvarint(@ "hash_341d65eb35599c77", 0)) {
        continue;
      }

      scriptablename = "br_plunder_box";
    }

    x = vectorNormalize(anglestoright(vehicle.angles)) * loot_spot.rightoffset;
    y = vectorNormalize(anglesToForward(vehicle.angles)) * loot_spot.forwardoffset;
    z = loot_spot.verticaloffset;
    origin = vehicle.origin + x - y + z;
    angles = flat_angle(vehicle.angles + loot_spot.anglesoffset);
    instance = spawnscriptable(scriptablename, origin, angles);
    scripts\mp\gametypes\br_pickups::registerscriptableinstance(instance);
    localorigin = rotatevectorinverted(origin - vehicle.origin, vehicle.angles);
    localangles = combineangles(invertangles(vehicle.angles), angles);
    instance scriptablesetparententity(vehicle, localorigin, localangles);
    instance setscriptablepartstate("body", "closed_usable");
    instance thread function_e6b94ee7f1f923e0(vehicle);
  }
}

function function_e45e3cc2d3e7ebf9(vehicle) {
  while(true) {
    origin = vehicle gettagorigin("tag_loot_01");

    sphere(origin, 16, (1, 1, 1), 0, 1);

    waitframe();
  }
}

function function_a3ecc821dbd5e9ed(path) {
  while(true) {
    if(!isDefined(level.player)) {
      waitframe();
      continue;
    }

    if(!isDefined(self)) {
      function_56940da4beb24898(path);
      return;
    }

    waitframe();
  }
}

function function_d8ebb244badd9649(vehicle) {
  level notify("<dev string:x60>");
  level endon("<dev string:x60>");

  while(isDefined(vehicle)) {
    if(getdvarint(@ "hash_2fdf021822704f83", 0)) {
      level.players[0] setOrigin(vehicle gettagorigin("<dev string:x7f>"));
      setDvar(@ "hash_2fdf021822704f83", 0);
    }

    if(getdvarint(@ "hash_93db170544366664", 0)) {
      level.var_a80709cbd73efbc1 = &function_5c71579f9179972c;
    }

    wait 0.2;
  }
}

function function_5c71579f9179972c() {
  struct = spawnStruct();
  struct.origin = level.flying gettagorigin("<dev string:x7f>") + (0, 0, -16);
  struct.angles = (0, 0, 0);
  struct.index = 16;
  return struct;
}

function function_e6b94ee7f1f923e0(vehicle) {
  while(isDefined(vehicle)) {
    waitframe();
  }

  self freescriptable();
}

function function_ffd405aecfd3d5b3(attacker) {
  return true;
}

function function_82fb10ddff2170e7(dropinfo) {
  if(!(isDefined(level.var_55f74552ec70e1.linkedchildren) && isDefined(level.var_55f74552ec70e1) && isDefined(dropinfo.groundentity)) || dropinfo.groundentity != level.var_55f74552ec70e1) {
    return;
  }

  maxloot = getdvarint(@ "hash_db0cadfc5731965d", 50);

  if(level.var_55f74552ec70e1.linkedchildren.size >= maxloot) {
    for(i = 0; i < level.var_55f74552ec70e1.linkedchildren.size; i++) {
      var_c3eb9eeb3172067a = level.var_55f74552ec70e1.linkedchildren[i];

      if(isDefined(var_c3eb9eeb3172067a) && var_c3eb9eeb3172067a getscriptableisloot()) {
        scripts\mp\gametypes\br_pickups::loothide(var_c3eb9eeb3172067a);
        break;
      }
    }
  }
}