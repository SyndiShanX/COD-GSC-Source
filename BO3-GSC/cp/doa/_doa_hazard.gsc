/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_hazard.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cp_doa_bo3_enemy;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_sfx;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace namespace_d88e3a06;

function init() {
  level.doa.var_61adacb4 = [];
  level.doa.hazards = [];
  level.doa.var_6a7fa24c = [];
  level.doa.var_2f019708 = 1;
  defs = struct::get_array("doa_hazard_def");
  for(i = 0; i < defs.size; i++) {
    def = spawnStruct();
    tokens = strtok(defs[i].script_noteworthy, " ");
    def.type = tokens[0];
    def.round = int(tokens[1]);
    if(tokens.size > 2) {
      def.width = int(tokens[2]);
    }
    if(tokens.size > 3) {
      def.height = int(tokens[3]);
    }
    if(tokens.size > 4) {
      def.var_1e40a680 = int(tokens[4]);
    }
    if(isDefined(defs[i].radius)) {
      def.radius = int(defs[i].radius);
    }
    def.model = defs[i].model;
    if(isDefined(level.doa.var_aeeb3a0e)) {
      [
        [level.doa.var_aeeb3a0e]
      ](def);
    }
    level.doa.var_61adacb4[level.doa.var_61adacb4.size] = def;
    if(def.type == "type_electric_mine") {
      level.doa.var_f6ba7ed2 = def;
    }
  }
  def = spawnStruct();
  def.round = 37;
  def.type = "type_spider_egg";
  def.model = "zombietron_spider_egg";
  level.doa.var_d402a78b = def;
}

function function_116bb43() {
  deathtriggers = getEntArray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_death", "targetname");
  for(i = 0; i < deathtriggers.size; i++) {
    trigger = deathtriggers[i];
    trigger triggerenable(0);
    trigger notify("hash_3c011e06");
  }
  var_825ea03d = getEntArray(namespace_3ca3c537::function_d2d75f5d() + "_water_volume", "targetname");
  for(i = 0; i < var_825ea03d.size; i++) {
    trigger = var_825ea03d[i];
    trigger triggerenable(0);
    trigger notify("hash_3c011e06");
  }
  for(i = 0; i < level.doa.hazards.size; i++) {
    if(isDefined(level.doa.hazards[i])) {
      level.doa.hazards[i] thread function_65192900();
    }
  }
  level.doa.hazards = [];
}

function private function_65192900() {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
  if(isDefined(self)) {
    self clientfield::set("hazard_activated", 9);
    if(isDefined(self.death_func)) {
      self thread[[self.death_func]]();
    }
    util::wait_network_frame();
  }
  if(isDefined(self)) {
    self delete();
  }
}

function function_f8530ca3() {
  level.doa.var_6a7fa24c = [];
  for(i = 0; i < level.doa.var_61adacb4.size; i++) {
    if(level.doa.var_61adacb4[i].round <= level.doa.round_number) {
      var_dbd69b20 = function_40c555dc(level.doa.var_61adacb4[i].type);
      if(isDefined(var_dbd69b20)) {
        level.doa.var_6a7fa24c[level.doa.var_6a7fa24c.size] = level.doa.var_61adacb4[i];
      }
    }
  }
}

function function_7b02a267() {
  level notify("hash_7b02a267");
  level endon("hash_7b02a267");
  while(true) {
    if(getdvarint("scr_doa_show_hazards", 0)) {
      for(i = 0; i < level.doa.var_6a7fa24c.size; i++) {
        var_1ab7e3a5 = level.doa.var_6a7fa24c[i];
        if(isDefined(var_1ab7e3a5)) {
          locs = function_a4d53f1f(var_1ab7e3a5.type);
          if(isDefined(locs)) {
            foreach(loc in locs) {
              radius = (isDefined(var_1ab7e3a5.radius) ? var_1ab7e3a5.radius : 85);
              if(isDefined(loc.radius)) {
                radius = loc.radius;
              }
              level thread namespace_2f63e553::drawcylinder(loc.origin, radius, 5, 20);
            }
          }
        }
      }
    }
    wait(1);
  }
}

function function_7a8a936b() {
  function_116bb43();
  function_f8530ca3();
  level thread function_7b02a267();
  for(i = 0; i < level.doa.var_6a7fa24c.size; i++) {
    var_1ab7e3a5 = level.doa.var_6a7fa24c[i];
    cluster_count = math::clamp(1 + (randomint(2 + (int((level.doa.round_number - 4) / 5)))), 1, 20);
    if(getdvarint("scr_doa_max_poles", 0)) {
      cluster_count = 20;
    }
    if(isDefined(level.doa.var_fdc1fa6b)) {
      count = [
        [level.doa.var_fdc1fa6b]
      ]();
      if(count != -1) {
        cluster_count = count;
      }
    }
    for(count = 0; count < cluster_count; count++) {
      if(!mayspawnentity()) {
        break;
      }
      locs = array::randomize(function_a4d53f1f(var_1ab7e3a5.type));
      loc = locs[0];
      radius = 85;
      if(isDefined(loc.radius)) {
        radius = loc.radius;
      }
      origin = loc.origin + (randomintrange(0 - radius, radius), randomintrange(0 - radius, radius), 0);
      origin = function_3341776e(origin, loc.origin, radius);
      if(isDefined(origin)) {
        hazard = spawn("script_model", origin);
        hazard.targetname = "hazard";
        hazard setModel(var_1ab7e3a5.model);
        hazard.def = var_1ab7e3a5;
        if(isDefined(var_1ab7e3a5.width) && isDefined(var_1ab7e3a5.height)) {
          hazard.trigger = spawn("trigger_radius", origin, 3, var_1ab7e3a5.width, var_1ab7e3a5.height);
          hazard.trigger.targetname = "hazard";
        }
        hazard thread function_5d31907f();
        level.doa.hazards[level.doa.hazards.size] = hazard;
        continue;
      }
      doa_utility::debugmsg("");
    }
  }
  deathtriggers = getEntArray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_death", "targetname");
  for(i = 0; i < deathtriggers.size; i++) {
    trigger = deathtriggers[i];
    trigger triggerenable(1);
    trigger thread function_6ec8176a();
  }
  var_825ea03d = getEntArray(namespace_3ca3c537::function_d2d75f5d() + "_water_volume", "targetname");
  for(i = 0; i < var_825ea03d.size; i++) {
    trigger = var_825ea03d[i];
    trigger triggerenable(1);
    trigger thread function_323a3e31();
  }
  var_88bc4fa4 = getEntArray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_warp", "targetname");
  for(i = 0; i < var_88bc4fa4.size; i++) {
    trigger = var_88bc4fa4[i];
    trigger triggerenable(1);
    trigger thread function_70dbf276();
  }
  if(level.doa.round_number >= level.doa.var_d402a78b.round) {
    level thread function_1cb931df(level.doa.var_afdb45da);
  }
}

function private _rotatevec(vector, angle) {
  return ((vector[0] * cos(angle)) - (vector[1] * sin(angle)), (vector[0] * sin(angle)) + (vector[1] * cos(angle)), vector[2]);
}

function function_1cb931df(def, var_3d19d2b1 = getdvarint("scr_doa_eggcount", 6)) {
  if(isDefined(level.doa.var_d0cde02c)) {
    if(isDefined(level.doa.var_d0cde02c.var_75f2c952)) {
      var_3d19d2b1 = level.doa.var_d0cde02c.var_75f2c952;
    } else {
      return;
    }
  } else if(def.round == level.doa.round_number) {
    var_3d19d2b1 = def.var_75f2c952;
  }
  spot = doa_utility::function_ada6d90();
  while(isDefined(spot) && var_3d19d2b1) {
    baseorigin = spot.origin;
    var_485dfece = 0;
    angle = randomint(180);
    while(var_3d19d2b1) {
      if(var_485dfece == 0) {
        origin = baseorigin;
      } else {
        origin = baseorigin + _rotatevec(vectorscale((1, 0, 0), 30), angle);
        angle = angle + randomintrange(30, 60);
      }
      namespace_51bd792::function_ecbf1358(origin, (randomfloatrange(-3, 3), randomfloatrange(0, 180), randomfloatrange(-3, 3)));
      var_3d19d2b1--;
      var_485dfece++;
      if(var_485dfece >= getdvarint("scr_doa_clutchcount_max", 6) || randomint(100) > 85) {
        nextspot = doa_utility::function_ada6d90();
        if(nextspot == spot) {
          var_3d19d2b1 = 0;
          break;
        }
        spot = nextspot;
        baseorigin = spot.origin;
        var_485dfece = 0;
        angle = randomint(180);
      }
    }
  }
}

function private function_fb78d226(var_6e476c41) {
  self endon("death");
  self asmsetanimationrate(0.8);
  self.in_water = 1;
  while(isDefined(var_6e476c41) && self istouching(var_6e476c41)) {
    wait(0.25);
  }
  self asmsetanimationrate(1);
}

function private function_323a3e31() {
  self notify("hash_323a3e31");
  self endon("hash_323a3e31");
  self endon("hash_3c011e06");
  while(true) {
    self waittill("trigger", guy);
    if(isDefined(guy) && isalive(guy) && (isDefined(guy.takedamage) && guy.takedamage) && (!(isDefined(guy.boss) && guy.boss)) && (!(isDefined(guy.in_water) && guy.in_water))) {
      if(isplayer(guy)) {
        if(isDefined(guy.doa) && isDefined(guy.doa.vehicle)) {
          guy notify("hash_d28ba89d");
        }
        continue;
      }
      guy thread function_fb78d226(self);
    }
  }
}

function private function_6ec8176a() {
  self notify("hash_6ec8176a");
  self endon("hash_6ec8176a");
  self endon("hash_3c011e06");
  while(true) {
    self waittill("trigger", guy);
    if(isDefined(guy) && isalive(guy) && (isDefined(guy.takedamage) && guy.takedamage) && (!(isDefined(guy.boss) && guy.boss))) {
      if(isDefined(self.script_noteworthy)) {
        switch (self.script_noteworthy) {
          case "water": {
            guy thread namespace_1a381543::function_90118d8c("zmb_hazard_water_death");
            guy thread namespace_eaa992c::function_285a2999("hazard_water");
            break;
          }
          case "lava": {
            break;
          }
        }
      }
      if(isDefined(self.script_parameters) && isDefined(guy.doa)) {
        guy.doa.var_bac6a79 = self.script_parameters;
      }
      if(isplayer(guy)) {
        guy notify("hash_d28ba89d");
      }
      guy dodamage(guy.health + 500, guy.origin);
    }
  }
}

function private function_70dbf276() {
  self notify("hash_70dbf276");
  self endon("hash_70dbf276");
  self endon("hash_3c011e06");
  while(true) {
    self waittill("trigger", guy);
    if(isDefined(guy)) {
      var_c99d2b6d = "spawn_at_safe";
      if(isDefined(self.script_parameters)) {
        var_bac6a79 = self.script_parameters;
      }
      if(!isplayer(guy)) {
        var_c99d2b6d = "spawn_at_safe";
      }
      if(isplayer(guy)) {
        guy notify("hash_d28ba89d");
      }
      switch (var_c99d2b6d) {
        case "spawn_at_safe": {
          spot = doa_utility::getclosestto(guy.origin, level.doa.arenas[level.doa.current_arena].var_1d2ed40).origin;
          break;
        }
        default: {
          spot = namespace_831a4a7c::function_68ece679(guy.entnum).origin;
          break;
        }
      }
      if(isplayer(guy)) {
        guy setorigin(spot);
        continue;
      }
      if(isactor(guy)) {
        guy forceteleport(spot, guy.angles);
        continue;
      }
      guy dodamage(guy.health + 500, guy.origin);
    }
  }
}

function private function_a4d53f1f(type) {
  spawn_locations = [];
  hazardtarget = namespace_3ca3c537::function_d2d75f5d() + "_doa_hazard";
  spawn_locations = struct::get_array(hazardtarget);
  if(spawn_locations.size == 0) {
    return;
  }
  locs = [];
  for(i = 0; i < spawn_locations.size; i++) {
    if(issubstr(spawn_locations[i].script_noteworthy, type)) {
      locs[locs.size] = spawn_locations[i];
    }
  }
  return locs;
}

function private function_40c555dc(type) {
  spawn_locations = [];
  hazardtarget = namespace_3ca3c537::function_d2d75f5d() + "_doa_hazard";
  spawn_locations = struct::get_array(hazardtarget);
  if(spawn_locations.size == 0) {
    return;
  }
  locs = [];
  for(i = 0; i < spawn_locations.size; i++) {
    if(issubstr(spawn_locations[i].script_noteworthy, type)) {
      locs[locs.size] = spawn_locations[i];
    }
  }
  return locs[randomint(locs.size)];
}

function function_3341776e(origin, var_891d7d80 = origin, var_ba2a535c = 85) {
  min_dist = 24;
  min_dist_squared = min_dist * min_dist;
  pushed = 1;
  max_tries = 3;
  while(pushed && max_tries > 0) {
    max_tries--;
    pushed = 0;
    for(i = 0; i < level.doa.hazards.size; i++) {
      hazard = level.doa.hazards[i];
      if(isDefined(hazard)) {
        dist_squared = distancesquared(origin, hazard.origin);
        if(dist_squared < min_dist_squared) {
          dir = origin - hazard.origin;
          dir = vectornormalize(dir);
          var_b72287b9 = origin - var_891d7d80;
          var_b72287b9 = vectornormalize(dir);
          if(vectordot(dir, var_b72287b9) < 0) {
            dir = dir * -1;
          }
          origin = origin + (dir * min_dist);
          pushed = 1;
        }
      }
    }
  }
  dist_squared = distancesquared(origin, var_891d7d80);
  if(dist_squared > (var_ba2a535c * var_ba2a535c)) {
    return undefined;
  }
  trace = worldtrace(origin + vectorscale((0, 0, 1), 32), origin + (48, 0, 32));
  var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
  if(!var_4a592d6b) {
    return undefined;
  }
  trace = worldtrace(origin + vectorscale((0, 0, 1), 32), origin + (-48, 0, 32));
  var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
  if(!var_4a592d6b) {
    return undefined;
  }
  trace = worldtrace(origin + vectorscale((0, 0, 1), 32), origin + (0, 48, 32));
  var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
  if(!var_4a592d6b) {
    return undefined;
  }
  trace = worldtrace(origin + vectorscale((0, 0, 1), 32), origin + (0, -48, 32));
  var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
  if(!var_4a592d6b) {
    return undefined;
  }
  return origin;
}

function private function_993013cd(trigger) {
  self endon("death");
  while(true) {
    if(isDefined(self.active) && self.active && isDefined(trigger)) {
      namespace_2f63e553::drawcylinder(trigger.origin, self.def.width, self.def.height);
    }
    wait(0.05);
  }
}

function private function_8a97d2c0(trigger) {
  self endon("death");
  trigger endon("death");
  while(true) {
    trigger waittill("trigger", guy);
    if(isDefined(guy) && (isDefined(self.active) && self.active)) {
      if(!isDefined(guy.doa)) {
        continue;
      }
      if(isDefined(guy.var_de3055b5) && guy.var_de3055b5) {
        continue;
      }
      if(!isDefined(guy.doa.var_84b9997f)) {
        guy.doa.var_84b9997f = 0;
      }
      curtime = gettime();
      if(curtime < guy.doa.var_84b9997f) {
        continue;
      }
      guy.doa.var_84b9997f = curtime + 1500;
      guy thread namespace_1a381543::function_90118d8c("zmb_hazard_hit");
      guy thread namespace_eaa992c::function_285a2999("hazard_electric");
      if(isDefined(guy.boss) && guy.boss) {
        continue;
      }
      if(guy.health > 0 && (isDefined(guy.takedamage) && guy.takedamage) && (isDefined(guy.allowdeath) && guy.allowdeath)) {
        guy dodamage(guy.health + 500, guy.origin, self, trigger, "none", "MOD_ELECTROCUTED");
      }
    }
  }
}

function function_5d31907f() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.def)) {
    return;
  }
  switch (self.def.type) {
    case "type_electric_mine": {
      self thread function_bf0f9f64();
      if(!isDefined(level.doa.var_f6ba7ed2)) {
        level.doa.var_f6ba7ed2 = self.def;
      }
      break;
    }
    default: {
      assert(0);
      break;
    }
  }
}

function function_bf0f9f64() {
  self endon("death");
  self.active = 0;
  self clientfield::set("hazard_type", (isDefined(self.var_d05d7e08) ? self.var_d05d7e08 : 1));
  wait(0.05);
  self thread function_8a97d2c0(self.trigger);
  self clientfield::set("hazard_activated", 1);
  wait(randomfloatrange(2.1, 8));
  while(true) {
    self clientfield::set("hazard_activated", 2);
    wait(1.2);
    self clientfield::set("hazard_activated", 3);
    self.active = 1;
    wait(randomfloatrange(4, 10));
    self clientfield::set("hazard_activated", 1);
    self.active = 0;
    wait(randomfloatrange(3, 6));
  }
}

function function_193a95a6() {
  self.death_func = undefined;
  origin = self.origin;
  self clientfield::set("hazard_activated", 9);
  self thread namespace_1a381543::function_90118d8c("exp_barrel_explo");
  self function_65192900();
  util::wait_network_frame();
  radiusdamage(origin, 200, 10000, 10000);
  physicsexplosionsphere(origin, 200, 128, 4);
}

function private function_2a738695() {
  self waittill("death");
  arrayremovevalue(level.doa.hazards, self);
}

function function_d8d20160() {
  self thread function_d8c94716();
  self thread function_441547f1();
  self thread function_2a738695();
  if(isDefined(self)) {
    self clientfield::set("hazard_type", 2);
  }
  util::wait_network_frame();
  if(isDefined(self)) {
    self clientfield::set("hazard_activated", 3);
    self.takedamage = 1;
    self.health = level.doa.rules.var_5e3c9766;
    self.maxhealth = self.health;
    self.team = "axis";
    self.trashcan = 1;
    self.var_1a563349 = 1;
    self.var_262e30aa = vectorscale((0, 0, 1), 42);
    self.death_func = &function_193a95a6;
    level.doa.hazards[level.doa.hazards.size] = self;
    while(isDefined(self)) {
      self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon);
      if(isDefined(meansofdeath) && meansofdeath == "MOD_BURNED") {
        damage = int(max(self.health * 0.5, damage));
      }
      doa_utility::debugmsg((((("" + damage) + "") + meansofdeath) + "") + self.health);
      lasthealth = self.health;
      self.health = self.health - damage;
      if(self.health <= 0) {
        self function_193a95a6();
        return;
      }
      var_5a614ecc = lasthealth / self.maxhealth;
      ratio = self.health / self.maxhealth;
      if(var_5a614ecc > 0.75 && ratio < 0.75) {
        self clientfield::set("hazard_activated", 4);
      }
      if(var_5a614ecc > 0.5 && ratio < 0.5) {
        self clientfield::set("hazard_activated", 5);
      }
      if(var_5a614ecc > 0.25 && ratio < 0.25) {
        self clientfield::set("hazard_activated", 6);
      }
    }
  }
}

function private function_d8c94716() {
  self thread doa_utility::function_783519c1("exit_taken", 1);
  self thread doa_utility::function_783519c1("doa_game_is_over", 1);
}

function private function_441547f1() {
  self endon("death");
  while(true) {
    pickupsitems = getEntArray("a_pickup_item", "script_noteworthy");
    var_f3646f56 = self.origin + (isDefined(self.var_262e30aa) ? self.var_262e30aa : (0, 0, 0));
    for(i = 0; i < pickupsitems.size; i++) {
      pickup = pickupsitems[i];
      if(!isDefined(pickup)) {
        continue;
      }
      distsq = distance2dsquared(pickup.origin, var_f3646f56);
      if(distsq > (12 * 12)) {
        continue;
      }
      pickup thread doa_pickups::function_6b4a5f81();
    }
    wait(0.05);
  }
}

function function_ffe39afe() {
  count = 0;
  foreach(hazard in level.doa.hazards) {
    if(isDefined(hazard) && (isDefined(hazard.trashcan) && hazard.trashcan)) {
      count++;
    }
  }
  return count;
}

function function_cda60edb() {
  if(level.doa.round_number < level.doa.rules.var_8c016b75) {
    return false;
  }
  if(!isDefined(level.doa.var_932f9d4d)) {
    return true;
  }
  if(function_ffe39afe() >= level.doa.rules.var_3210f224) {
    return false;
  }
  if((gettime() - level.doa.var_932f9d4d) > (level.doa.rules.var_6e5d36ba * 1000)) {
    return true;
  }
  if(randomint(level.doa.rules.var_d82df3d5) > level.doa.rules.var_4a5eec4) {
    return false;
  }
  return true;
}