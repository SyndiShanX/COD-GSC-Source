/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_supply_drop.gsc
***********************************************/

#using script_340a2e805e35f7a2;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace item_supply_drop;

function private autoexec __init__system__() {
  system::register(#"item_supply_drop", &preinit, undefined, undefined, #"item_world");
}

function private preinit() {
  if(!item_world_util::use_item_spawns() || util::get_game_type() === # "zsurvival") {
    return;
  }

  level.item_supply_drops = [];
  level.var_3f771530 = [];

  level thread _setup_devgui();

  clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int");
  clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int");
  clientfield::register("scriptmover", "supply_drop_portal_fx", 1, 1, "int");
  clientfield::register("vehicle", "supply_drop_vehicle_landed", 1, 1, "counter");
}

function private function_eaba72c9() {
  while(true) {
    if(getdvarint(#"wz_supply_drop", 0) > 0) {
      switch (getdvarint(#"wz_supply_drop", 0)) {
        case 1:
          level thread function_418e26fe();
          break;
        case 2:
          vehicletypes = array(#"hash_28d512b739c9d9c1");
          level thread function_418e26fe(undefined, 1, 1, 0, 1, vehicletypes[randomint(vehicletypes.size)]);
          break;
      }

      setDvar(#"wz_supply_drop", 0);
    }

    if(getdvarint(#"wz_flare_drop", 0) > 0) {
      switch (getdvarint(#"wz_flare_drop", 0)) {
        case 1:
          level thread function_7d4a448f();
          break;
      }

      setDvar(#"wz_flare_drop", 0);
    }

    if(getdvarint(#"hash_5dc24c61c66f6fee", 0) > 0) {
      debug_supply_drop();
    }

    if(getdvarint(#"hash_40d4ca5923d72b3d", 0) > 0) {
      players = getplayers();

      if(isDefined(players[0])) {
        switch (getdvarint(#"hash_40d4ca5923d72b3d", 0)) {
          case 1:
            level thread drop_supply_drop(players[0].origin);
            break;
          case 2:
            level thread drop_supply_drop(players[0].origin, 1, undefined, undefined, #"hash_27bac84003da7795");
            break;
          case 3:
            vehicletypes = array(#"hash_28d512b739c9d9c1");
            level thread drop_supply_drop(players[0].origin, 1, 1, vehicletypes[randomint(vehicletypes.size)]);
            break;
        }
      }

      setDvar(#"hash_40d4ca5923d72b3d", 0);
    }

    waitframe(1);
  }
}

function private _setup_devgui() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x90>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xcf>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x110>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x152>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1a3>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1fa>");
  level thread function_eaba72c9();
}

function private debug_supply_drop() {
  if(isDefined(level.supplydropveh)) {
    deathcircleindex = isDefined(level.deathcircleindex) ? level.deathcircleindex : 0;
    deathcircle = level.deathcircles[deathcircleindex];
    nextdeathcircle = isDefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;
    height = nextdeathcircle.origin[2];
    radius = 200;
    sphere(level.var_d1c35a7a, radius, (1, 0, 0));
    sphere(level.var_ebe9f3de, radius, (1, 0, 0));

    if(isDefined(level.var_1b269b78)) {
      sphere(level.var_1b269b78, radius, (0, 1, 0));
      var_58d00116 = (level.var_1b269b78[0], level.var_1b269b78[1], height);
      line(level.var_1b269b78, var_58d00116, (0, 1, 0));
      sphere(var_58d00116, radius, (0, 1, 0));
    }

    if(isDefined(level.var_538928e3)) {
      sphere(level.var_538928e3, radius, (0, 1, 0));
      var_fb4d4118 = (level.var_538928e3[0], level.var_538928e3[1], height);
      line(level.var_538928e3, var_fb4d4118, (0, 1, 0));
      sphere(var_fb4d4118, radius, (0, 1, 0));
    }

    sphere(level.var_daa6e3f, radius, (1, 0.5, 0));

    for(index = 1; index < level.var_57e06aea.size; index++) {
      line(level.var_57e06aea[index - 1], level.var_57e06aea[index], (1, 0, 0));
    }

    if(isDefined(level.supplydropmax) && isDefined(level.supplydropmin)) {
      mintop = level.supplydropmin;
      var_9c1af46d = (level.supplydropmin[0], level.supplydropmax[1], level.supplydropmax[2]);
      var_c46271bf = (level.supplydropmax[0], level.supplydropmin[1], level.supplydropmin[2]);
      var_99a8be82 = level.supplydropmax;
      line(mintop, var_9c1af46d, (1, 1, 1));
      line(mintop, var_c46271bf, (1, 1, 1));
      line(var_99a8be82, var_9c1af46d, (1, 1, 1));
      line(var_99a8be82, var_c46271bf, (1, 1, 1));
      sphere(mintop, radius, (1, 1, 1));
      sphere(var_c46271bf, radius, (1, 1, 1));
      sphere(var_9c1af46d, radius, (1, 1, 1));
      sphere(var_99a8be82, radius, (1, 1, 1));
    }
  }
}

function private function_c7bd0aa8(point, startpoint) {
  assert(isvec(point));
  assert(isvec(startpoint));

  if(function_16bbdd8b(point)) {
    return point;
  }

  assert(function_16bbdd8b(startpoint));

  if(territory::function_c0de0601()) {
    var_bb96e272 = vectornormalize(startpoint - point);
    pathlength = distance2d(startpoint, point);
    var_28021cac = int(pathlength / 1000);

    for(var_c742cad6 = 1; var_c742cad6 <= var_28021cac; var_c742cad6++) {
      newpoint = startpoint + var_bb96e272 * 1000 * var_c742cad6;

      if(function_16bbdd8b(newpoint)) {
        return newpoint;
      }
    }

    return point;
  }

  min = level.supplydropmin;
  max = level.supplydropmax;
  var_1ccbeeaa = (point[0], point[1], 0);
  var_49e5fac9 = (startpoint[0], startpoint[1], 0);

  if(var_1ccbeeaa[0] < min[0]) {
    toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
    assert(toend[0] != 0);
    t = (min[0] - var_49e5fac9[0]) / toend[0];
    var_1ccbeeaa = var_49e5fac9 + toend * t;
  } else if(var_1ccbeeaa[0] > max[0]) {
    toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
    assert(toend[0] != 0);
    t = (max[0] - var_49e5fac9[0]) / toend[0];
    var_1ccbeeaa = var_49e5fac9 + toend * t;
  }

  if(var_1ccbeeaa[1] < min[1]) {
    toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
    assert(toend[1] != 0);
    t = (min[1] - var_49e5fac9[1]) / toend[1];
    var_1ccbeeaa = var_49e5fac9 + toend * t;
  } else if(var_1ccbeeaa[1] > max[1]) {
    toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
    assert(toend[1] != 0);
    t = (max[1] - var_49e5fac9[1]) / toend[1];
    var_1ccbeeaa = var_49e5fac9 + toend * t;
  }

  point = (var_1ccbeeaa[0], var_1ccbeeaa[1], point[2]);
  return point;
}

function private function_9ae8f99e() {
  self endon(#"death");
  self waittill(#"veh_landed");
  clientfield::increment("supply_drop_vehicle_landed");
}

function private function_13339b58(supplydrop, var_d91c179d, index) {
  self endon(#"death");
  var_13781019 = array(#"hash_51dcbe21849d4df0");
  idleanimations = array(#"hash_58b756555570c169");
  var_1a8acc15 = array(#"hash_6a42d559c2d990df");

  if(isDefined(var_d91c179d)) {
    switch (var_d91c179d.vehicletype) {
      case # "vehicle_t9_mil_fav_light":
        var_13781019 = array(#"hash_43e87a7d1f494a6e", #"hash_aa76ca9894b87b", #"hash_19296420b7b82e4", #"hash_af5b730d0f9b749");
        idleanimations = array(#"hash_44a6ed2c48d1a597", #"hash_2230d366d30fca2c", #"hash_126bd9e565a0db35", #"hash_4e468b786b07a70a");
        var_1a8acc15 = array(#"hash_5f67889cb298ce95", #"hash_652fc868ed16b8b4", #"hash_1211c06c537d210b", #"hash_2a57c0307d341062");
        break;
      default:
        var_13781019 = array(#"hash_6481b506b1de6549", #"hash_37143952d1dbe3e8", #"hash_3d3b8beecf975e2f", #"hash_1d747853002df86e");
        idleanimations = array(#"hash_1a22dfd4c582f10a", #"hash_6b21d5f85a66a061", #"hash_68385a0b5c4f0788", #"hash_10834188a34cef97");
        var_1a8acc15 = array(#"hash_3e3be065e18be62", #"hash_49edbe5ac4e375c7", #"hash_2362c027dd6f5060", #"hash_38f38672937d7c95");
        break;
    }
  }

  self animscripted("parachute_open", supplydrop.origin, supplydrop.angles, var_13781019[index], "normal", "root", 1, 0);
  self waittill(#"parachute_open");

  if(!is_true(self.parachute_close)) {
    self animscripted("parachute_idle", supplydrop.origin, supplydrop.angles, idleanimations[index], "normal", "root", 1, 0);
  }

  self flag::wait_till("parachute_close");
  self unlink();
  self animscripted("parachute_closed", self.origin, self.angles, var_1a8acc15[index], "normal", "root", 1, 0);
  animlength = getanimlength("parachute_closed");
  wait animlength * 0.35;

  if(isDefined(var_d91c179d)) {
    self setModel("p9_fxanim_wz_parachute_supplydrop_veh_fade");
  } else {
    self setModel("p9_fxanim_wz_parachute_supplydrop_01_fade");
  }

  self clientfield::set("supply_drop_parachute_rob", 0);
  wait animlength * 0.65;
  self delete();
}

function private function_71c31c8d() {
  self notify(#"pop_parachute");

  if(isDefined(self)) {
    self.pop_parachute = 1;
  }
}

function private function_500a6615(itemspawnlist = # "t9_supply_drop_stash_parent", var_93fe96a6 = 0, s_instance) {
  if(isDefined(self.supplydrop)) {
    supplydrop = self.supplydrop;
    self.supplydrop = undefined;

    if(isDefined(self.harness)) {
      var_6d9635e7 = # "hash_3ce4bc719a3ea6b";
      var_36ff1928 = # "hash_7e54508e8fa9ef96";

      if(isDefined(supplydrop.var_d5552131)) {
        switch (supplydrop.var_d5552131.vehicletype) {
          case # "vehicle_t9_mil_fav_light":
            var_6d9635e7 = # "hash_3791502c5d089d79";
            var_36ff1928 = # "hash_5e21433684751cdc";
            break;
          default:
            var_6d9635e7 = # "hash_66caa605c0a985bc";
            var_36ff1928 = # "hash_382ac153f17ffc5b";
            break;
        }
      }

      self.harness animscripted("harness_stop", self.origin, self.angles, var_6d9635e7, "normal", "root", 1, 0);
      animlength = getanimlength(#"hash_3ce4bc719a3ea6b");
      wait animlength;

      if(isDefined(self.harness)) {
        self.harness animscripted("harness_retract", self.origin, self.angles, var_36ff1928, "normal", "root", 1, 0);
      }
    }

    supplydrop.supplydropveh = undefined;

    if(isDefined(supplydrop.var_d5552131)) {
      supplydrop.var_d5552131.supplydropveh = undefined;
    }

    supplydrop endon(#"death");
    supplydrop unlink();
    supplydrop show();
    supplydrop.angles = (0, supplydrop.angles[1], 0);
    startpoint = (supplydrop.origin[0], supplydrop.origin[1], min(32000, supplydrop.origin[2] - 200));
    endpoint = (supplydrop.origin[0], supplydrop.origin[1], -32000);
    travelspeed = is_true(supplydrop.var_abd32694) ? 400 : 200;
    groundoffset = is_true(supplydrop.var_abd32694) ? 200 : 60;
    groundtrace = physicstraceex(startpoint, endpoint, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), supplydrop, 32);
    groundpoint = groundtrace[# "position"] + (0, 0, groundoffset);
    traveldistance = startpoint - groundpoint;
    movetime = traveldistance[2] / travelspeed;

    if(movetime < 0) {
      movetime = 1;
    }

    supplydrop moveto(groundpoint, movetime);
    supplydrop playSound("evt_supply_drop");
    var_f6dfa3da = is_true(supplydrop.var_abd32694) ? 1 : 1;
    wait var_f6dfa3da;
    var_d6cc4b8c = function_4daa76d4(supplydrop, supplydrop.var_d5552131);

    foreach(key, supplydropparachute in var_d6cc4b8c) {
      supplydropparachute thread function_13339b58(supplydrop, supplydrop.var_d5552131, key);
    }

    if(!is_true(supplydrop.pop_parachute)) {
      supplydrop waittill(#"movedone", #"pop_parachute");
    }

    foreach(supplydropparachute in var_d6cc4b8c) {
      supplydropparachute notify(#"parachute_close");
      supplydropparachute flag::set("parachute_close");
      supplydropparachute.parachute_close = 1;
    }

    if(is_true(supplydrop.var_abd32694)) {
      if(isDefined(supplydrop.var_d5552131)) {
        supplydrop.var_d5552131 unlink();
        supplydrop.var_d5552131.overridevehicledamage = undefined;
        callback::callback(#"hash_740a58650e79dbfd", supplydrop.var_d5552131);

        if(isDefined(level.var_cd8f416a)) {
          level.var_cd8f416a[level.var_cd8f416a.size] = supplydrop.var_d5552131;
        }

        supplydrop.var_d5552131 thread function_9ae8f99e();
      }

      supplydrop delete();
      return;
    }

    supplydrop physicslaunch();
    supplydrop thread function_924a11ff(itemspawnlist, var_93fe96a6, s_instance);
    supplydrop thread function_e21ceb1b();
  }
}

function private function_e21ceb1b() {
  self endon(#"death", #"movedone");
  extendbounds = (10, 10, 10);
  previousorigin = self.origin;

  while(true) {
    closeplayers = getentitiesinradius(self.origin, 128, 1);
    var_15d21979 = abs((previousorigin - self.origin)[2]);

    if(var_15d21979 > 4) {
      foreach(player in closeplayers) {
        if(isalive(player) && player istouching(self, extendbounds)) {
          player dodamage(player.health + 1, player.origin, self, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
          player playSound("evt_supply_crush");
        }
      }
    }

    previousorigin = self.origin;
    waitframe(1);
  }
}

function private function_ba3be344() {
  self endon(#"death");
  self notify(#"emergency_exit");
  exitangle = 60;
  right = anglesToForward(self.angles + (0, exitangle, 0));
  left = anglesToForward(self.angles + (0, exitangle * -1, 0));
  mapradius = function_43e35f94();
  startpoint = self.origin;
  leftpoint = function_c7bd0aa8(startpoint + left * mapradius, startpoint);
  rightpoint = function_c7bd0aa8(startpoint + right * mapradius, startpoint);
  endpoint = rightpoint;

  if(distance2d(startpoint, leftpoint) < distance2d(startpoint, rightpoint)) {
    endpoint = leftpoint;
  }

  var_57e06aea = function_eafcba42(startpoint, endpoint);
  self.var_57e06aea = var_57e06aea;
  self setspeed(50);
  wait 0.5;
  self thread function_c2edbefb(var_57e06aea);
  wait 0.5;
  self setspeed(100);
}

function private function_3c597e8d() {
  if(territory::function_c0de0601()) {
    return territory::get_center();
  }

  var_6024133d = getEntArray("map_corner", "targetname");

  if(var_6024133d.size) {
    return math::find_box_center(var_6024133d[0].origin, var_6024133d[1].origin);
  }

  return (0, 0, 0);
}

function private function_43e35f94() {
  if(territory::function_c0de0601()) {
    return territory::get_radius();
  }

  var_6024133d = getEntArray("map_corner", "targetname");

  if(var_6024133d.size) {
    x = abs(var_6024133d[0].origin[0] - var_6024133d[1].origin[0]);
    y = abs(var_6024133d[0].origin[1] - var_6024133d[1].origin[1]);
    return (max(x, y) / 2);
  }

  return 1000;
}

function private function_4daa76d4(supplydrop, var_d91c179d) {
  parachutes = [];

  if(!isDefined(var_d91c179d)) {
    parachute = spawn("script_model", (0, 0, 0));
    parachute.targetname = "supply_drop_chute";
    parachute.origin = supplydrop.origin;
    parachute.angles = supplydrop.angles;
    parachute setforcenocull();
    parachute setModel("p9_fxanim_wz_parachute_supplydrop_01_mod");
    parachute clientfield::set("supply_drop_parachute_rob", 1);
    parachute useanimtree("generic");
    parachute linkto(supplydrop, "tag_origin", (0, 0, -80));
    parachutes[parachutes.size] = parachute;
  } else {
    var_daf5f046 = 4;

    for(index = 0; index < var_daf5f046; index++) {
      parachute = spawn("script_model", (0, 0, 0));
      parachute.targetname = "supply_drop_chute";
      parachute.origin = supplydrop.origin;
      parachute.angles = supplydrop.angles;
      parachute setforcenocull();
      parachute setModel("p9_fxanim_wz_parachute_supplydrop_veh_mod");
      parachute clientfield::set("supply_drop_parachute_rob", 1);
      parachute useanimtree("generic");
      parachute linkto(supplydrop, "tag_origin", (0, 0, -80));
      parachutes[parachutes.size] = parachute;
    }
  }

  return parachutes;
}

function private function_67d7d040(var_d91c179d) {
  supplydrop = spawn("script_model", (0, 0, 0));
  supplydrop.targetname = "supply_drop";
  supplydrop setModel("wpn_t9_streak_care_package_friendly_world_nosight");
  supplydrop setforcenocull();
  supplydrop useanimtree("generic");
  supplydrop.var_a64ed253 = 1;
  supplydrop.var_bad13452 = 0;
  supplydrop.targetname = supplydrop getentitynumber() + "_stash_" + randomint(2147483647);
  supplydrop clientfield::set("dynamic_stash", 1);
  supplydrop clientfield::set("dynamic_stash_type", 1);
  supplydrop.stash_type = 1;
  supplydrop setweapon(getweapon(#"item_supplydrop"));
  supplydrop function_619a5c20();
  supplydrop.supplydropveh = var_d91c179d;
  return supplydrop;
}

function private function_70f0b08a(var_d91c179d, vehicletype) {
  var_c7acf5ad = spawn("script_model", (0, 0, 0));
  var_c7acf5ad.targetname = "supply_drop_harness";
  var_c7acf5ad setforcenocull();

  if(!isDefined(vehicletype)) {
    var_c7acf5ad setModel("p9_fxanim_wz_parachute_supplydrop_harness_01_mod");
  } else {
    switch (vehicletype) {
      case # "vehicle_t9_mil_fav_light":
        var_c7acf5ad setModel("p9_fxanim_wz_parachute_supplydrop_veh_fav_harness_mod");
        break;
      default:
        var_c7acf5ad setModel("p9_fxanim_wz_parachute_supplydrop_veh_tank_harness_mod");
        break;
    }
  }

  var_c7acf5ad useanimtree("generic");
  var_c7acf5ad.supplydropveh = var_d91c179d;
  return var_c7acf5ad;
}

function private function_546afbb6() {
  self endon(#"death");
  var_dc66f988 = self getvelocity();
  var_2497a956 = 0;

  while(true) {
    velocity = self getvelocity();
    var_2497a956 = min(var_2497a956, velocity[2]);

    if(abs(velocity[2] - var_dc66f988[2]) > 100) {
      if(abs(var_2497a956) > 1000) {
        self setvehvelocity((0, 0, 0));
        self dodamage(self.health, self.origin, self);
      }

      return;
    }

    waitframe(1);
    var_dc66f988 = velocity;
  }
}

function private function_a3832aa0(var_d91c179d, vehicletype, dropangles, vehicleangles) {
  supplydrop = spawn("script_model", (0, 0, -64000));
  supplydrop setModel("tag_origin");
  supplydrop useanimtree("generic");
  supplydrop.supplydropveh = var_d91c179d;
  var_d5552131 = spawnvehicle(vehicletype, (0, 0, 0), (0, 0, 0));

  if(!isDefined(var_d5552131)) {
    supplydrop delete();
    return;
  }

  if(!isDefined(dropangles)) {
    dropangles = (0, 0, 0);
  }

  var_da7d45d1 = (0, 90, 0);
  dropangles = dropangles - vehicleangles + var_da7d45d1;
  var_d5552131 linkto(supplydrop, "tag_origin", (0, 0, 0), dropangles);
  var_d5552131.var_b9b5403c = var_d5552131.health * 0.5;
  var_d5552131.overridevehicledamage = &function_9a275b1f;
  var_d5552131.supplydropveh = var_d91c179d;
  var_d5552131.supplydrop = supplydrop;
  var_d5552131 makeusable();
  var_d5552131 thread function_e1e33e0();

  if(is_true(var_d5552131.isphysicsvehicle)) {
    var_d5552131 setbrake(1);
  }

  supplydrop.var_d5552131 = var_d5552131;
  supplydrop.var_abd32694 = 1;
  arrayremovevalue(level.var_3f771530, undefined);
  level.var_3f771530[level.var_3f771530.size] = var_d5552131;
  return supplydrop;
}

function function_e1e33e0() {
  self endon(#"death");

  while(true) {
    if(self function_2c2c30e0()) {
      n_time_current = gettime();

      if(!isDefined(self.var_769bebf7)) {
        self.var_769bebf7 = n_time_current;
      }

      if(!(self.var_769bebf7 + int(40 * 1000) > n_time_current)) {
        self delete();
      }
    } else if(!self function_2c2c30e0() && isDefined(self.var_769bebf7)) {
      self.var_769bebf7 = undefined;
    }

    wait 1;
  }
}

function private function_6eb3f7bb() {
  if(!isDefined(level.supplydropmin) || !isDefined(level.supplydropmax)) {
    var_6024133d = getEntArray("map_corner", "targetname");

    if(var_6024133d.size) {
      minx = min(var_6024133d[0].origin[0], var_6024133d[1].origin[0]);
      miny = min(var_6024133d[0].origin[1], var_6024133d[1].origin[1]);
      minz = -10;
      level.supplydropmin = (minx, miny, minz);
      maxx = max(var_6024133d[0].origin[0], var_6024133d[1].origin[0]);
      maxy = max(var_6024133d[0].origin[1], var_6024133d[1].origin[1]);
      maxz = 10;
      level.supplydropmax = (maxx, maxy, maxz);
      return;
    }

    level.supplydropmin = level.mapcenter - (1000, 1000, 10);
    level.supplydropmax = level.mapcenter + (1000, 1000, 10);
  }
}

function private function_16bbdd8b(point) {
  if(territory::function_c0de0601()) {
    testpoint = (point[0], point[1], point[2]);
    return territory::is_inside(testpoint, 1);
  }

  function_6eb3f7bb();
  testpoint = (point[0], point[1], 0);
  return function_fc3f770b(level.supplydropmin, level.supplydropmax, testpoint);
}

function function_186f5ca3() {
  function_6eb3f7bb();

  for(index = 0; index < 10; index++) {
    droppoint = (randomfloatrange(level.supplydropmin[0], level.supplydropmax[0]), randomfloatrange(level.supplydropmin[1], level.supplydropmax[1]), randomfloatrange(level.supplydropmin[2], level.supplydropmax[2]));

    if(!oob::chr_party(droppoint)) {
      result = function_9cc082d2(droppoint, 15000);

      if(isDefined(result) && isDefined(result[# "materialflags"]) && ~(result[# "materialflags"] & 2)) {
        return droppoint;
      }
    }
  }
}

function private function_415bdb1d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(max(self.health - vsurfacenormal, 0) <= self.var_b9b5403c) {
    self thread function_500a6615();
    self thread function_ba3be344();
    self.var_b9b5403c = 0;
  }

  return vsurfacenormal;
}

function private function_9a275b1f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  newhealth = max(self.health - vsurfacenormal, 0);

  if(newhealth <= self.var_b9b5403c) {
    if(isDefined(self.supplydropveh)) {
      supplydropveh = self.supplydropveh;
      supplydropveh thread function_500a6615();
      supplydropveh thread function_ba3be344();
    } else {
      if(isDefined(self.supplydrop)) {
        self.supplydrop function_71c31c8d();
        self thread function_546afbb6();
      }

      self.var_b9b5403c = 0;
    }
  }

  if(newhealth <= 0) {
    self unlink();
    self.health = vsurfacenormal + 1;
  }

  return vsurfacenormal;
}

function private function_eafcba42(startpoint, endpoint, droppoint, maxheight, minheight) {
  points = [];
  startpoint = trace_point(startpoint);
  endpoint = trace_point(endpoint);
  var_bb96e272 = vectornormalize(endpoint - startpoint);
  pathlength = distance2d(startpoint, endpoint);
  var_28021cac = int(pathlength / 5000);
  points[0] = startpoint;

  if(isDefined(droppoint)) {
    var_66d25ef4 = distancesquared(startpoint, droppoint);
  }

  for(var_c742cad6 = 1; var_c742cad6 <= var_28021cac; var_c742cad6++) {
    var_a1bc57e1 = startpoint + var_bb96e272 * 5000 * var_c742cad6;

    if(isDefined(droppoint)) {
      if(distancesquared(startpoint, var_a1bc57e1) >= var_66d25ef4 && distancesquared(startpoint, points[points.size - 1]) <= var_66d25ef4) {
        points[points.size] = droppoint;
      }
    }

    points[points.size] = trace_point(var_a1bc57e1, undefined, maxheight, minheight);
    waitframe(1);
  }

  points[points.size] = endpoint;
  return points;
}

function private trace_point(point, var_5fd22b95 = 1, maxheight = 20000, minheight = 1000) {
  startpoint = (point[0], point[1], maxheight);
  endpoint = (point[0], point[1], minheight);
  trace = groundtrace(startpoint, endpoint, 0, undefined, var_5fd22b95);

  if(!var_5fd22b95) {
    if(trace[# "surfacetype"] == "water" || trace[# "surfacetype"] == "watershallow") {
      return;
    }
  }

  if(isDefined(trace[# "position"])) {
    return (trace[# "position"] + (0, 0, 2000));
  }

  return startpoint;
}

function private function_8234217e(var_faa1ea31, vectors) {
  assert(vectors.size > 0);
  var_54b25053 = vectors[0];
  bestdot = vectordot(var_54b25053, var_faa1ea31);

  for(index = 1; index < vectors.size; index++) {
    var_7aa67ca6 = vectordot(vectors[index], var_faa1ea31);

    if(abs(var_7aa67ca6) > abs(bestdot)) {
      var_54b25053 = vectors[index];
      bestdot = var_7aa67ca6;
    }
  }

  if(bestdot < 0) {
    var_54b25053 *= -1;
  }

  return var_54b25053;
}

function private function_a40836e(angles, worldforward = (1, 0, 0)) {
  axises = [];
  axises[axises.size] = anglesToForward(angles);
  axises[axises.size] = anglestoright(angles);
  axises[axises.size] = anglestoup(angles);
  worldup = (0, 0, 1);
  newforward = function_8234217e(worldforward, axises);
  newup = function_8234217e(worldup, axises);
  newangles = axistoangles(newforward, newup);
  return newangles;
}

function function_ee19f0b0(angles, worldforward) {
  return function_a40836e(angles, worldforward);
}

function private function_924a11ff(itemspawnlist, var_93fe96a6 = 0, s_instance) {
  assert(isDefined(itemspawnlist));
  self endon(#"death");
  self thread item_drop::function_10ececeb(1, 80, 24, (-25, -25, 0), (25, 25, 50));
  self waittill(#"stationary");

  if(isDefined(level.var_a16ff74d)) {
    self thread[[level.var_a16ff74d]](var_93fe96a6, s_instance);
    return;
  }

  var_e68facee = isDefined(self getlinkedent());
  self clientfield::set("supply_drop_fx", 1);
  self setModel("wpn_t9_streak_care_package_friendly_world_nosight");
  self.anglesoffset = (0, 90, 0);
  items = self namespace_65181344::function_5eada592(itemspawnlist, 1);
  wait 60;

  if(isDefined(self)) {
    self clientfield::set("supply_drop_fx", 0);
  }
}

function private function_9e8348e4() {
  self waittill(#"hash_7b6fafe066e13e0b", #"death");
  self thread function_500a6615();
}

function private function_c2edbefb(path, droppoint, var_86928932 = 1, var_2118f785 = undefined) {
  self endon(#"death", #"emergency_exit");

  for(pathindex = 1; pathindex < path.size; pathindex++) {
    var_f155e743 = 0;

    if(isDefined(droppoint)) {
      var_f155e743 = distancesquared(path[pathindex], droppoint) < sqr(128);
    }

    self function_a57c34b7(path[pathindex], var_f155e743 && var_86928932, 0);

    while(true) {
      if(var_f155e743) {
        if(distancesquared(droppoint, self.origin) < sqr(128)) {
          if(isDefined(level.var_79f9f7c9) && var_86928932) {
            wait level.var_79f9f7c9;

            if(isDefined(self.supplydrop)) {
              self.supplydrop.origin = droppoint;
            }
          } else if(var_86928932) {
            wait 2;
          }

          self thread function_500a6615(var_2118f785);

          if(var_86928932) {
            wait 1;
          }

          break;
        }
      } else if(distancesquared(path[pathindex], self.origin) < sqr(1800)) {
        break;
      }

      waitframe(1);
    }
  }

  self notify(#"hash_7b6fafe066e13e0b");

  if(isDefined(self.harness)) {
    self.harness delete();
  }

  self delete();
}

function private function_261b0e67(spawnpoint, endpoint, droppoint, dropflare = 1, vehicleoverride = undefined) {
  var_47736ddd = array(spawnpoint, droppoint, endpoint);
  var_7366c0ff = spawnvehicle(isDefined(vehicleoverride) ? vehicleoverride : "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration", spawnpoint, vectortoangles(vectornormalize(endpoint - spawnpoint)));

  if(!isDefined(var_7366c0ff)) {
    return;
  }

  var_7366c0ff endon(#"death");
  var_7366c0ff setforcenocull();
  var_7366c0ff.goalradius = 128;
  var_7366c0ff.goalheight = 128;
  var_7366c0ff.health = 10000;
  var_7366c0ff setspeed(125);
  var_7366c0ff setrotorspeed(1);
  var_7366c0ff vehicle::toggle_tread_fx(1);
  var_7366c0ff vehicle::toggle_exhaust_fx(1);
  var_7366c0ff vehicle::toggle_sounds(1);

  for(pathindex = 1; pathindex < var_47736ddd.size; pathindex++) {
    var_f155e743 = 0;

    if(isDefined(droppoint)) {
      var_f155e743 = distancesquared(var_47736ddd[pathindex], droppoint) < sqr(128);
    }

    var_7366c0ff function_a57c34b7(var_47736ddd[pathindex], 0, 0);

    while(true) {
      if(var_f155e743) {
        if(distancesquared(droppoint, var_7366c0ff.origin) < sqr(128)) {
          if(dropflare) {}

          break;
        }
      } else if(distancesquared(var_47736ddd[pathindex], var_7366c0ff.origin) < sqr(1800)) {
        break;
      }

      waitframe(1);
    }
  }

  var_7366c0ff delete();
}

function function_7d4a448f(var_47d17dcb = 0) {
  if(!is_true(level.deathcircle.enabled)) {
    return;
  }

  if(!isDefined(level.deathcircles) || level.deathcircles.size <= 0) {
    return;
  }

  deathcircleindex = isDefined(level.deathcircleindex) ? level.deathcircleindex : 0;
  deathcircle = level.deathcircles[deathcircleindex];
  nextdeathcircle = isDefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;

  if(var_47d17dcb) {
    nextdeathcircle = level.deathcircles[level.deathcircles.size - 1];
  }

  var_94f13d8b = 18000;
  deathcirclecenter = nextdeathcircle.origin;
  deathcirclecenter = (deathcirclecenter[0], deathcirclecenter[1], var_94f13d8b);
  var_4f59c30d = nextdeathcircle.radius;

  if(!function_16bbdd8b(deathcirclecenter)) {
    return;
  }

  var_396cbf6e = deathcircle.radius;
  var_be734526 = deathcircle.radius - var_4f59c30d;

  if(var_be734526 > 0) {
    dirtocenter = vectornormalize(deathcirclecenter - (deathcircle.origin[0], deathcircle.origin[1], var_94f13d8b));
    var_8df04549 = deathcirclecenter - dirtocenter * var_4f59c30d;
    exitpoint = deathcirclecenter + dirtocenter * var_4f59c30d;
  } else {
    degrees = randomint(360);
    var_8df04549 = (cos(degrees) * var_4f59c30d, sin(degrees) * var_4f59c30d, 0) + deathcirclecenter;
    exitpoint = (cos(degrees) * -1 * var_4f59c30d, sin(degrees) * -1 * var_4f59c30d, 0) + deathcirclecenter;
  }

  waitframe(1);
  droppoint = deathcirclecenter;
  var_8df04549 = function_c7bd0aa8(var_8df04549, droppoint);
  exitpoint = function_c7bd0aa8(exitpoint, droppoint);
  var_bb96e272 = vectornormalize(exitpoint - var_8df04549);
  var_142db926 = 5000;
  nextcircledistance = distance2d(deathcircle.origin, deathcirclecenter);
  var_6eae2ffb = var_396cbf6e + nextcircledistance + var_142db926;
  var_429b69c0 = max(var_6eae2ffb, 15000);
  despawndistance = max(var_396cbf6e, 45000);
  spawnpoint = var_8df04549 - var_bb96e272 * var_429b69c0;
  spawnpoint = function_c7bd0aa8(spawnpoint, droppoint);
  endpoint = exitpoint + var_bb96e272 * despawndistance;
  endpoint = function_c7bd0aa8(endpoint, droppoint);
  level thread function_261b0e67(spawnpoint, endpoint, droppoint, 1);
  angles = vectortoangles(var_bb96e272);
  rightoffset = vectornormalize(anglestoright(angles)) * 1024;
  leftoffset = rightoffset * -1;
  var_ae85ee87 = var_bb96e272 * -1024;
  vehicleoverride = undefined;
  offset = rightoffset + var_ae85ee87 + (0, 0, randomintrange(25, 50));
  level thread function_261b0e67(spawnpoint + offset, endpoint + offset, droppoint + offset, 0, vehicleoverride);
  offset = leftoffset + var_ae85ee87 + (0, 0, randomintrange(-50, -25));
  level thread function_261b0e67(spawnpoint + offset, endpoint + offset, droppoint + offset, 0, vehicleoverride);
}

function function_418e26fe(var_2118f785 = undefined, helicopter = 0, voiceevent = 1, var_541c190b = 0, vehicledrop = 0, vehicletype = undefined) {
  if(!is_true(level.deathcircle.enabled)) {
    return;
  }

  if(!isDefined(level.deathcircles) || level.deathcircles.size <= 0) {
    return;
  }

  var_f5f2246e = helicopter ? 20000 : 35000;
  deathcircleindex = isDefined(level.deathcircleindex) ? level.deathcircleindex : 0;
  deathcircle = level.deathcircles[deathcircleindex];
  nextdeathcircle = isDefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;

  if(helicopter) {
    var_729c4495 = 1000;
  } else {
    var_729c4495 = 20000;
  }

  var_729c4495 += var_541c190b;
  var_94f13d8b = 2000 + var_729c4495;
  deathcirclecenter = nextdeathcircle.origin;
  deathcirclecenter = (deathcirclecenter[0], deathcirclecenter[1], var_94f13d8b);
  var_4f59c30d = nextdeathcircle.radius;

  if(!function_16bbdd8b(deathcirclecenter)) {
    return;
  }

  var_396cbf6e = deathcircle.radius;
  var_be734526 = deathcircle.radius - var_4f59c30d;
  degrees = randomint(360);
  var_8df04549 = (cos(degrees) * var_4f59c30d, sin(degrees) * var_4f59c30d, var_94f13d8b) + deathcirclecenter;
  exitpoint = (cos(degrees) * -1 * var_4f59c30d, sin(degrees) * -1 * var_4f59c30d, var_94f13d8b) + deathcirclecenter;
  waitframe(1);
  var_e2be9787 = 10;
  droppoint = undefined;

  for(index = 0; index < var_e2be9787; index++) {
    randompoint = lerpvector(var_8df04549, exitpoint, randomfloatrange(0, 1));

    if(function_16bbdd8b(randompoint)) {
      droppoint = trace_point(randompoint, 0, undefined, -5000);

      if(isDefined(droppoint) && !oob::chr_party(droppoint)) {
        droppoint = trace_point(randompoint, 0, var_f5f2246e, var_729c4495);
        break;
      }
    }

    waitframe(1);
  }

  if(!isDefined(droppoint)) {
    return;
  }

  var_8df04549 = function_c7bd0aa8(var_8df04549, droppoint);
  var_8df04549 = trace_point(var_8df04549, undefined, var_f5f2246e, var_729c4495);
  exitpoint = function_c7bd0aa8(exitpoint, droppoint);
  exitpoint = trace_point(exitpoint, undefined, var_f5f2246e, var_729c4495);
  var_bb96e272 = vectornormalize(exitpoint - var_8df04549);
  var_429b69c0 = max(var_396cbf6e, 15000);
  despawndistance = max(var_396cbf6e, 45000);
  spawnpoint = var_8df04549 - var_bb96e272 * var_429b69c0;
  spawnpoint = function_c7bd0aa8(spawnpoint, droppoint);
  endpoint = exitpoint + var_bb96e272 * despawndistance;
  endpoint = function_c7bd0aa8(endpoint, droppoint);

  if(helicopter) {
    var_57e06aea = function_47ec98c4(spawnpoint, endpoint, droppoint, vehicledrop, vehicletype, var_f5f2246e, var_729c4495);
  } else {
    var_57e06aea = function_b8dd1978(spawnpoint, endpoint, droppoint, var_2118f785, voiceevent);
  }

  level.var_1b269b78 = var_8df04549;
  level.var_538928e3 = exitpoint;
}

function function_b8dd1978(startpoint, endpoint, droppoint, var_2118f785 = undefined, voiceevent = 1) {
  var_57e06aea = array(startpoint, droppoint, endpoint);
  supplydropveh = spawnvehicle("vehicle_t8_mil_air_transport_infiltration", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));

  if(!isDefined(supplydropveh)) {
    return;
  }

  supplydropveh setforcenocull();

  if(voiceevent) {
    callback::callback(#"hash_40cd438036ae13df", undefined);
  }

  supplydropveh.goalradius = 128;
  supplydropveh.goalheight = 128;
  supplydropveh.var_57e06aea = var_57e06aea;
  supplydropveh.maxhealth = supplydropveh.health;
  supplydropveh.var_b9b5403c = supplydropveh.maxhealth * 0.5;
  supplydropveh setspeed(100);
  supplydropveh setrotorspeed(1);
  supplydropveh vehicle::toggle_tread_fx(1);
  supplydropveh vehicle::toggle_exhaust_fx(1);
  supplydropveh vehicle::toggle_sounds(1);
  supplydropveh.var_5d0810d7 = 1;
  supplydrop = function_67d7d040(supplydropveh);

  if(!isDefined(supplydropveh)) {
    return;
  }

  supplydrop linkto(supplydropveh, "tag_origin", (0, 0, -120));
  supplydropveh.supplydrop = supplydrop;
  supplydropveh thread function_c2edbefb(var_57e06aea, droppoint, 0, var_2118f785);
  supplydropveh thread function_9e8348e4();
  level.item_supply_drops[level.item_supply_drops.size] = supplydrop;
  return var_57e06aea;
}

function function_47ec98c4(startpoint, endpoint, droppoint, var_d91c179d = 0, vehicletype = undefined, maxheight = undefined, minheight = undefined, var_2118f785, dropangles = undefined) {
  if(is_true(var_d91c179d) && !isDefined(vehicletype)) {
    return;
  }

  var_57e06aea = function_eafcba42(startpoint, endpoint, droppoint, maxheight, minheight);
  assert(var_57e06aea.size >= 2);
  startpoint = var_57e06aea[0];
  endpoint = var_57e06aea[var_57e06aea.size - 1];
  toendpoint = endpoint - startpoint;
  var_ce19c689 = vectortoangles(toendpoint);

  if(!var_d91c179d) {
    supplydropveh = spawnvehicle("vehicle_t9_mil_helicopter_care_package", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
  } else {
    supplydropveh = spawnvehicle("vehicle_t9_mil_ru_heli_transport_vehicle_drop", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
  }

  if(!isDefined(supplydropveh)) {
    return;
  }

  supplydropveh setforcenocull();
  callback::callback(#"hash_40cd438036ae13df", {
    #vehicletype: vehicletype, #droppoint: droppoint
  });
  supplydropveh.takedamage = 0;
  supplydropveh.goalradius = 128;
  supplydropveh.goalheight = 128;
  supplydropveh.var_57e06aea = var_57e06aea;
  supplydropveh.maxhealth = supplydropveh.health;
  supplydropveh.var_b9b5403c = supplydropveh.maxhealth * 0.5;
  supplydropveh.overridevehicledamage = &function_415bdb1d;
  supplydropveh setspeed(100);
  supplydropveh setrotorspeed(1);
  supplydropveh vehicle::toggle_tread_fx(1);
  supplydropveh vehicle::toggle_exhaust_fx(1);
  supplydropveh vehicle::toggle_sounds(1);
  supplydropveh.var_5d0810d7 = 1;

  if(var_d91c179d) {
    harness = function_70f0b08a(supplydropveh, vehicletype);
    supplydrop = function_a3832aa0(supplydropveh, vehicletype, dropangles, var_ce19c689);
  } else {
    harness = function_70f0b08a(supplydropveh);
    supplydrop = function_67d7d040(supplydropveh);
  }

  if(isDefined(harness)) {
    harness linkto(supplydropveh, "tag_cargo_attach", (0, 0, -90));
    var_6fe5490e = # "hash_7b1793df2c9b8245";
    attachtag = "tag_care_package";

    if(isDefined(supplydrop.var_d5552131)) {
      attachtag = "tag_vehicle_tank";

      switch (supplydrop.var_d5552131.vehicletype) {
        case # "vehicle_t9_mil_fav_light":
          var_6fe5490e = # "hash_333ac707d1003c63";
          break;
        default:
          var_6fe5490e = # "hash_105bba381b94f622";
          break;
      }
    }

    supplydrop linkto(harness, attachtag, (0, 0, 0), (0, -90, 0));
    harness animscripted("harness_idle", supplydropveh.origin, supplydropveh.angles, var_6fe5490e, "normal", "root", 1, 0);
  } else {
    supplydrop linkto(supplydropveh, "tag_cargo_attach", (0, 0, -45));
  }

  supplydropveh.harness = harness;
  supplydropveh.supplydrop = supplydrop;
  supplydropveh thread function_c2edbefb(var_57e06aea, droppoint, undefined, var_2118f785);
  supplydropveh thread function_9e8348e4();
  level.item_supply_drops[level.item_supply_drops.size] = supplydrop;
  level.supplydrop = supplydrop;
  level.supplydropveh = supplydropveh;
  level.var_57e06aea = var_57e06aea;
  level.var_daa6e3f = droppoint;
  level.var_d1c35a7a = startpoint;
  level.var_ebe9f3de = endpoint;
  return var_57e06aea;
}

function drop_supply_drop(droppoint, helicopter = 0, vehicledrop = 0, vehicletype = undefined, var_2118f785 = undefined, dropangles = undefined) {
  assert(isvec(droppoint));

  if(!function_16bbdd8b(droppoint)) {
    return;
  }

  maxheight = helicopter ? 20000 : 35000;
  minheight = helicopter ? 1000 : 20000;
  droppoint = trace_point(droppoint, 0, maxheight, minheight);

  if(!isDefined(droppoint) || !function_16bbdd8b(droppoint)) {
    return;
  }

  mapcenter = function_3c597e8d();
  mapradius = function_43e35f94();

  if(mapradius == 0) {
    mapradius = 10000;
  }

  var_1e8c19be = 5000;
  var_8dc158c7 = 15000;
  var_b98da7dd = droppoint - mapcenter;
  var_b98da7dd = (var_b98da7dd[0], var_b98da7dd[1], 0);
  var_b98da7dd = vectornormalize(var_b98da7dd);
  spawnpoint = mapcenter + var_b98da7dd * mapradius;
  spawnpoint = (spawnpoint[0], spawnpoint[1], droppoint[2]);

  if(!territory::function_c0de0601()) {
    spawnpoint = function_c7bd0aa8(spawnpoint, droppoint) + var_b98da7dd * var_1e8c19be;
  }

  endpoint = mapcenter - var_b98da7dd * mapradius;
  endpoint = (endpoint[0], endpoint[1], droppoint[2]);

  if(!territory::function_c0de0601()) {
    endpoint = function_c7bd0aa8(endpoint, droppoint) - var_b98da7dd * var_8dc158c7;
  }

  if(distance2dsquared(spawnpoint, endpoint) <= sqr(100)) {
    return;
  }

  if(helicopter) {
    var_57e06aea = function_47ec98c4(spawnpoint, endpoint, droppoint, vehicledrop, vehicletype, undefined, undefined, var_2118f785, dropangles);
    return;
  }

  var_57e06aea = function_b8dd1978(spawnpoint, endpoint, droppoint, var_2118f785);
}

function spawn_supply_drop(spawnpoint, itemspawnlist) {
  supplydrop = function_67d7d040(undefined);
  supplydrop.origin = spawnpoint;
  struct = spawnStruct();
  struct.supplydrop = supplydrop;
  struct thread function_500a6615(itemspawnlist);
  return supplydrop;
}

function function_9771c7db(spawnpoint, itemspawnlist, var_93fe96a6 = 0, s_instance) {
  supplydrop = function_67d7d040(undefined);
  supplydrop.origin = spawnpoint;
  struct = spawnStruct();

  if(isDefined(level.var_183bdb80)) {
    supplydrop thread[[level.var_183bdb80]](s_instance);
  } else {
    supplydrop thread supply_drop_portal_fx();
  }

  supplydrop.struct = struct;
  struct.supplydrop = supplydrop;
  struct thread function_500a6615(itemspawnlist, var_93fe96a6, s_instance);
  return supplydrop;
}

function supply_drop_portal_fx() {
  self clientfield::set("supply_drop_portal_fx", 1);
  wait 3;
  self clientfield::set("supply_drop_portal_fx", 0);
}