/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\deployable.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\oob;
#include scripts\core_common\system_shared;

#namespace deployable;

autoexec __init__system__() {
  system::register(#"deployable", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&on_player_spawned);
  level.var_160dcfef = spawnStruct();
  level.var_160dcfef.var_1b8ab31d = [];
  level.var_160dcfef.var_d4ef836e = 0;
  level.var_160dcfef.var_a48608a0 = [];

  if(!isDefined(level.var_1765ad79)) {
    level.var_1765ad79 = 1;
  }

  level.var_160dcfef.var_193db709 = [];
  setdvar(#"hash_8d4e58d73e3f876", 0);

}

register_deployable(weapon, var_c0064c29, var_94b4fa08 = undefined, placehintstr = undefined, var_a39cb3db = undefined, var_fe12c0d9 = undefined) {
  if(!isDefined(level._deployable_weapons)) {
    level._deployable_weapons = [];
  }

  if(weapon.name == "#none") {
    return;
  }

  assert(weapon.name != "<dev string:x38>");
  level._deployable_weapons[weapon.statindex] = spawnStruct();
  level._deployable_weapons[weapon.statindex].var_159652c0 = &function_6654310c;
  level._deployable_weapons[weapon.statindex].var_9f2c21ea = var_c0064c29;
  level._deployable_weapons[weapon.statindex].var_1463c9a8 = var_94b4fa08;
  level._deployable_weapons[weapon.statindex].placehintstr = placehintstr;
  level._deployable_weapons[weapon.statindex].var_a39cb3db = var_a39cb3db;
  level._deployable_weapons[weapon.statindex].var_fe12c0d9 = var_fe12c0d9;
}

function_209fda28(weapon) {
  if(!isDefined(level._deployable_weapons)) {
    level._deployable_weapons = [];
  }

  if(isDefined(level._deployable_weapons[weapon.statindex]) && isDefined(level._deployable_weapons[weapon.statindex].var_159652c0)) {
    self[[level._deployable_weapons[weapon.statindex].var_159652c0]](weapon);
  }
}

function_84fa8d39(weapon) {
  println("<dev string:x40>");
}

  function function_cf538621(weapon) {
    println("<dev string:x4f>");
    self clientfield::set_to_player("gameplay_allows_deploy", 1);
  }

function_d60e5a06(center, radius) {
  var_5795c216 = spawnStruct();
  var_5795c216.origin = center;
  var_5795c216.radiussqr = radius * radius;
  var_5795c216._id = level.var_160dcfef.var_d4ef836e;

  if(!isDefined(level.var_160dcfef.var_1b8ab31d)) {
    level.var_160dcfef.var_1b8ab31d = [];
  } else if(!isarray(level.var_160dcfef.var_1b8ab31d)) {
    level.var_160dcfef.var_1b8ab31d = array(level.var_160dcfef.var_1b8ab31d);
  }

  level.var_160dcfef.var_1b8ab31d[level.var_160dcfef.var_1b8ab31d.size] = var_5795c216;
  returnid = level.var_160dcfef.var_d4ef836e;
  level.var_160dcfef.var_d4ef836e++;
  return returnid;
}

function_b20df196(zoneid) {
  for(index = 0; index < level.var_160dcfef.var_1b8ab31d.size; index++) {
    if(level.var_160dcfef.var_1b8ab31d[index]._id == zoneid) {
      level.var_160dcfef.var_1b8ab31d = array::remove_index(level.var_160dcfef.var_1b8ab31d, index, 0);
      break;
    }
  }
}

function_89d64a2c(origin) {
  foreach(var_5795c216 in level.var_160dcfef.var_1b8ab31d) {
    if(distance2dsquared(var_5795c216.origin, origin) < var_5795c216.radiussqr) {
      return true;
    }
  }

  return false;
}

function_6ec9ee30(var_a2a6139a, deployable_weapon) {
  if(isDefined(level.var_7b83b300)) {
    self[[level.var_7b83b300]](deployable_weapon);
  }

  var_a2a6139a.weapon = deployable_weapon;
  var_a2a6139a thread function_670cd4a3();
  var_4d5b521e = self gadgetgetslot(deployable_weapon);
  self function_69b5c53c(var_4d5b521e, 0);
}

function_81598103(var_a2a6139a) {
  var_a2a6139a function_34d37476();
}

function_416f03e6(deployableweapon) {
  if(!isDefined(self)) {
    return;
  }

  var_4d5b521e = self gadgetgetslot(deployableweapon);

  if(isDefined(deployableweapon)) {
    self function_69b5c53c(var_4d5b521e, 0);
  }

  if(isDefined(deployableweapon) && deployableweapon.issupplydropweapon !== 1) {
    self setriotshieldfailhint();
  }

  if(isDefined(level.var_cf16ff75)) {
    self[[level.var_cf16ff75]](deployableweapon);
  }
}

function_b3d993e9(deployable_weapon, sethintstring = 0) {
  player = self;

  if(deployable_weapon.var_e0d42861) {
    player function_bf191832(1, (0, 0, 0), (0, 0, 0));
    return 1;
  }

  var_2e7d45cb = player function_27476e09(deployable_weapon, sethintstring);
  player.var_7a3f3edf = function_ab25be55(deployable_weapon, sethintstring) && var_2e7d45cb.isvalid && function_d6ac81c7(deployable_weapon, player, var_2e7d45cb.origin, var_2e7d45cb.angles);
  player setplacementhint(player.var_7a3f3edf);
  player function_bf191832(player.var_7a3f3edf, var_2e7d45cb.origin, var_2e7d45cb.angles);
  player clientfield::set_to_player("gameplay_allows_deploy", player.var_7a3f3edf);

  if(player.var_7a3f3edf) {
    self.var_b8878ba9 = var_2e7d45cb.origin;
    self.var_ddc03e10 = var_2e7d45cb.angles;
  } else {
    self.var_b8878ba9 = undefined;
    self.var_ddc03e10 = undefined;
  }

  return player.var_7a3f3edf;
}

private function_ab25be55(weapon, sethintstring) {
  if(self isplayerswimming() && !(isDefined(weapon.canuseunderwater) ? weapon.canuseunderwater : 0)) {
    self sethintstring(#"hash_37605398dce96965");
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  return true;
}

private function_831707e8(player, deployable_weapon) {
  if(!(isDefined(deployable_weapon.var_dbbd4cec) && deployable_weapon.var_dbbd4cec)) {
    return false;
  }

  if(player depthinwater() > (isDefined(deployable_weapon.var_76127e14) ? deployable_weapon.var_76127e14 : 0)) {
    return false;
  }

  if(oob::chr_party(player.origin)) {
    return false;
  }

  if(!player isonground()) {
    return false;
  }

  if(function_89d64a2c(player.origin)) {
    return false;
  }

  if(function_54267517(player.origin)) {
    return false;
  }

  traceresults = bulletTrace(player.origin + (0, 0, 10), player.origin + (0, 0, -10), 0, player);

  if(isDefined(traceresults[#"entity"])) {
    entity = traceresults[#"entity"];

    if(!function_db9eb027(entity)) {
      return false;
    }
  }

  return true;
}

private function_867664f6(player) {
  var_8a074131 = worldentnumber();
  groundent = player getgroundent();

  if(!isDefined(groundent)) {
    return false;
  }

  return var_8a074131 == groundent getentitynumber();
}

private function_27476e09(deployable_weapon, sethintstring = 0) {
  var_ac12dd4b = level._deployable_weapons[deployable_weapon.statindex].var_1463c9a8;

  if(!isDefined(var_ac12dd4b)) {
    results = self function_242060b9(deployable_weapon);
  } else {
    results = [[var_ac12dd4b]](self);
  }

  assert(isDefined(results));
  assert(isDefined(results.isvalid));
  assert(isDefined(results.origin));
  assert(isDefined(results.angles));

  if(!isDefined(results.waterdepth)) {
    results.waterdepth = 0;
  }

  var_a98c3ea7 = 1;

  if(results.waterdepth > (isDefined(deployable_weapon.var_76127e14) ? deployable_weapon.var_76127e14 : 0)) {
    results.isvalid = 0;
  } else if((isDefined(results.waterdepth) ? results.waterdepth : 0) > 0 && isDefined(results.waterbottom)) {
    results.origin = results.waterbottom;
  }

  results.isvalid = results.isvalid && !oob::chr_party(results.origin);
  results.isvalid = results.isvalid && !function_89d64a2c(results.origin);
  results.isvalid = results.isvalid && !function_54267517(results.origin);
  results.isvalid = results.isvalid && function_db9eb027(results.hitent);

  if(level.var_1765ad79) {
    results.isvalid = results.isvalid && function_867664f6(self);
  }

  if(!results.isvalid && function_831707e8(self, deployable_weapon)) {
    results.origin = self.origin;
    results.angles = self.angles;
    results.isvalid = 1;
  }

  return results;
}

private function_d6ac81c7(deployable_weapon, player, origin, angles) {
  var_9f2c21ea = level._deployable_weapons[deployable_weapon.statindex].var_9f2c21ea;

  if(!isDefined(var_9f2c21ea)) {
    return 1;
  }

  return [[var_9f2c21ea]](origin, angles, player);
}

private function_6654310c(weapon) {
  player = self;

  if(level.time == player.var_3abd9b54) {
    return;
  }

  player.var_3abd9b54 = level.time;
  var_7a3f3edf = player function_b3d993e9(weapon);

  if(!var_7a3f3edf && isDefined(level.var_228e8cd6)) {
    player[[level.var_228e8cd6]](weapon);
  }
}

location_valid() {
  return isDefined(self.var_b8878ba9);
}

function_dd266e08(owner) {
  if(isDefined(owner) && isDefined(owner.var_b8878ba9)) {
    self.origin = owner.var_b8878ba9;
  }

  if(isDefined(owner) && isDefined(owner.var_ddc03e10)) {
    self.angles = owner.var_ddc03e10;
  }
}

on_player_spawned() {
  self.var_3abd9b54 = 0;
  self clientfield::set_to_player("gameplay_allows_deploy", 1);
  self callback::on_weapon_change(&on_weapon_change);
}

private function_aab01e08() {
  weapon = undefined;

  if(self isusingoffhand()) {
    weapon = self getcurrentoffhand();
  } else {
    weapon = self getcurrentweapon();
  }

  if(!weapon.deployable || weapon.var_e0d42861) {
    return undefined;
  }

  return weapon;
}

private function_f0adf9c() {
  self notify("3bd5bdfdc5aacef9");
  self endon("3bd5bdfdc5aacef9");
  player = self;
  player endon(#"death", #"disconnect");
  deployable_weapon = player function_aab01e08();

  if(!isDefined(deployable_weapon)) {
    player thread function_765a2e96();
    return;
  }

  while(true) {
    waitframe(1);
    var_7a3f3edf = player function_b3d993e9(deployable_weapon);

    if(var_7a3f3edf) {
      if(isDefined(level._deployable_weapons[deployable_weapon.statindex].placehintstr)) {
        player sethintstring(level._deployable_weapons[deployable_weapon.statindex].placehintstr);
      }

      continue;
    }

    if(isDefined(level._deployable_weapons[deployable_weapon.statindex].var_a39cb3db)) {
      player sethintstring(level._deployable_weapons[deployable_weapon.statindex].var_a39cb3db);
    }
  }
}

function_765a2e96() {
  self endon(#"death", #"disconnect");
  wait 1.5;
  self sethintstring("");
}

function_db9eb027(entity) {
  if(!isDefined(entity)) {
    return true;
  }

  if(isvehicle(entity) || isai(entity) || entity ismovingplatform()) {
    return false;
  }

  if(isDefined(entity.weapon) || isDefined(entity.killstreakid)) {
    return false;
  }

  return true;
}

function_54d27855(client_pos, client_angles, var_36baa3f1, previs_weapon, ignore_entity) {
  results = spawnStruct();
  var_5130f5dd = 0;
  var_caa96e8a = 0;
  var_a7bfb = 0;
  var_e76d3149 = 0;
  var_68e91c5c = 0;
  var_ae7d780d = 0;
  var_f94d59f8 = 2;
  var_5adff8ce = (0, 0, 0);
  var_4c59d56 = (0, 0, 0);
  forward = anglesToForward(client_angles);
  var_6c16750a = previs_weapon.var_f7e67f28;

  if(previs_weapon.var_9111ccc0 && previs_weapon.var_5ac2e7a4 > previs_weapon.var_f7e67f28) {
    var_6c16750a = previs_weapon.var_5ac2e7a4;
  }

  trace_distance = var_6c16750a / abs(cos(client_angles[0]));
  forward_vector = vectorscale(forward, trace_distance);
  trace_start = var_36baa3f1;
  trace_result = bulletTrace(trace_start, trace_start + forward_vector, 0, ignore_entity);
  hit_location = trace_start + forward_vector;
  hit_normal = (0, 0, 1);
  hit_distance = 10;
  var_def28dc4 = previs_weapon.var_9111ccc0;
  hitent = undefined;
  var_d22ba639 = 0;

  if(trace_result[#"fraction"] < 1) {
    hit_location = trace_result[#"position"];
    hit_normal = trace_result[#"normal"];
    var_6165e0de = hit_normal[2] < 0.7;
    hit_distance = trace_result[#"fraction"] * trace_distance;

    if(distance2dsquared(client_pos, hit_location) < previs_weapon.var_f7e67f28 * previs_weapon.var_f7e67f28) {
      var_caa96e8a = 1;
    }

    height_offset = hit_location[2] - client_pos[2];

    if(var_def28dc4 && var_6165e0de) {
      if(height_offset <= previs_weapon.var_ab300840 && height_offset >= previs_weapon.var_849af6b4) {
        var_a7bfb = 1;
      }

      var_e76d3149 = 1;
      wall_dot = vectordot(forward * -1, hit_normal);

      if(wall_dot > cos(previs_weapon.var_c4aae0fa)) {
        var_68e91c5c = 1;
      }

      if(!var_68e91c5c) {
        var_d22ba639 = 1;
      }

      hitent = trace_result[#"entity"];
    } else {
      if(height_offset <= previs_weapon.var_227c90e1 && height_offset >= previs_weapon.var_849af6b4) {
        var_a7bfb = 1;
      }

      out_of_range = hit_distance > previs_weapon.var_f7e67f28;

      if(out_of_range) {
        var_d22ba639 = 1;
      }

      if(!var_def28dc4 && var_6165e0de) {
        hit_location = client_pos + (forward_vector[0], forward_vector[1], 0) * trace_result[#"fraction"];
        hit_normal = (0, 0, 1);
        var_ae7d780d = 1;
        var_d22ba639 = 0;
      }
    }
  } else {
    var_d22ba639 = 1;
  }

  water_depth = 0;
  water_bottom = hit_location;

  if(var_d22ba639) {
    forward2d = anglesToForward((0, client_angles[1], 0));
    var_f7e67f28 = previs_weapon.var_f7e67f28;
    var_75e7a61 = client_pos + (0, 0, previs_weapon.var_227c90e1);
    var_1a606e14 = var_75e7a61 + forward2d * var_f7e67f28;
    var_b6085963 = bulletTrace(var_75e7a61, var_1a606e14, 0, ignore_entity);

    if(var_b6085963[#"fraction"] > 0) {
      var_f7e67f28 = previs_weapon.var_f7e67f28 * var_b6085963[#"fraction"] - var_f94d59f8;
      ground_trace_start = client_pos + forward2d * var_f7e67f28 + (0, 0, previs_weapon.var_227c90e1);
      ground_trace_end = ground_trace_start - (0, 0, previs_weapon.var_227c90e1 - previs_weapon.var_849af6b4);
      var_4bc118b9 = groundtrace(ground_trace_start, ground_trace_end, 0, ignore_entity);
      hitent = var_4bc118b9[#"entity"];

      if(var_4bc118b9[#"fraction"] > 0.01 && var_4bc118b9[#"fraction"] < 1 && var_4bc118b9[#"normal"][2] > 0.9) {
        hit_location = var_4bc118b9[#"position"];
        hit_normal = var_4bc118b9[#"normal"];
        hit_distance = var_4bc118b9[#"fraction"] * var_f7e67f28;
        var_caa96e8a = 1;
        var_a7bfb = 1;

        if(isDefined(var_4bc118b9[#"waterdepth"])) {
          water_depth = var_4bc118b9[#"waterdepth"];
          water_bottom = var_4bc118b9[#"waterbottom"];
        }
      }
    }
  }

  if(isDefined(hit_location)) {
    var_5adff8ce = hit_location;

    if(hit_normal[2] < 0.7) {
      var_89135834 = angleclamp180(vectortoangles(hit_normal)[0] + 90);
      var_503578d3 = vectortoangles(hit_normal)[1];
      var_e8a49b1 = 0;
    } else {
      hit_angles = vectortoangles(hit_normal);
      var_503578d3 = client_angles[1];
      pitch = angleclamp180(hit_angles[0] + 90);
      var_18f32ba4 = absangleclamp360(hit_angles[1] - client_angles[1]);
      var_aba68694 = cos(var_18f32ba4);
      var_c59a47b6 = sin(var_18f32ba4) * -1;
      var_89135834 = pitch * var_aba68694;
      var_e8a49b1 = pitch * var_c59a47b6;
    }

    var_4c59d56 = (var_89135834, var_503578d3, var_e8a49b1);
  }

  var_5130f5dd = var_caa96e8a && var_a7bfb && (!var_e76d3149 || var_68e91c5c) && !var_ae7d780d;

  if(var_5130f5dd && !(isDefined(previs_weapon.var_33d50507) && previs_weapon.var_33d50507)) {
    var_e3c2e9c6 = var_5adff8ce + (0, 0, 1) * 30;
    var_cc9ea9b = physicstrace(var_36baa3f1, var_e3c2e9c6, (-16, -16, -16), (16, 16, 16), ignore_entity);
    var_5130f5dd = var_cc9ea9b[#"fraction"] == 1;
  }

  results.isvalid = var_5130f5dd;
  results.origin = var_5adff8ce;
  results.angles = var_4c59d56;
  results.hitent = hitent;
  results.waterdepth = water_depth;
  results.waterbottom = water_bottom;
  return results;
}

private on_weapon_change(params) {
  self setplacementhint(1);
  self clientfield::set_to_player("gameplay_allows_deploy", 1);
  self thread function_f0adf9c();
}

function_670cd4a3() {
  self endon(#"death");
  self.var_19fde5b7 = [];

  while(true) {
    waitresult = self waittill(#"grenade_stuck");

    if(isDefined(waitresult.projectile)) {
      array::add(self.var_19fde5b7, waitresult.projectile);
    }
  }
}

function_34d37476() {
  if(!isDefined(self.var_19fde5b7)) {
    return;
  }

  foreach(var_221be278 in self.var_19fde5b7) {
    if(!isDefined(var_221be278)) {
      continue;
    }

    var_221be278 dodamage(500, self.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
  }
}