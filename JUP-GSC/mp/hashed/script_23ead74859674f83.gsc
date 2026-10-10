/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_23ead74859674f83.gsc
*************************************************/

#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace rusher_util;

function function_b6fe5ecc5aa631e() {
  return 8;
}

function function_2e76ca63b9a152aa() {
  return 360 / function_b6fe5ecc5aa631e();
}

function function_6a71485bed30022f(point, sector, attackoffset) {
  angle = sector * function_2e76ca63b9a152aa() - 180;
  targetpoint = point + anglesToForward((0, angle, 0)) * attackoffset;
  return targetpoint;
}

function function_f483cb14cb6af004(type) {
  return self.var_c5b2a90477ee623e[type];
}

function function_9b72e8ac7409e020(type) {
  if(!isDefined(self.var_c5b2a90477ee623e)) {
    self.var_c5b2a90477ee623e = [];
  }

  if(!isDefined(self.var_c5b2a90477ee623e[type])) {
    self.var_c5b2a90477ee623e[type] = [];

    for(sector = 0; sector < function_b6fe5ecc5aa631e(); sector++) {
      self.var_c5b2a90477ee623e[type][sector] = spawnStruct();
      self.var_c5b2a90477ee623e[type][sector].timestamp = 0;
      self.var_c5b2a90477ee623e[type][sector].claimer = undefined;
      self.var_c5b2a90477ee623e[type][sector].origin = undefined;
      self.var_c5b2a90477ee623e[type][sector].num = sector;
    }
  }
}

function function_f814071e24378b97(ent) {
  origin = ent.origin;

  if(isDefined(ent.groundpos)) {
    origin = ent.groundpos;
  } else if(isPlayer(ent) && (ent isjumping() || ent ishighjumping())) {
    if(!isDefined(ent.var_43a5f500c0aeb33e)) {
      ent.var_43a5f500c0aeb33e = 0;
    }

    if(gettime() > ent.var_43a5f500c0aeb33e) {
      ent.playergroundpos = getgroundposition(ent.origin, 15);
      ent.var_43a5f500c0aeb33e = gettime();
    }

    if(isDefined(ent.playergroundpos)) {
      origin = ent.playergroundpos;
    }
  }

  return origin;
}

function function_47ed76e02c439723(ent, type) {
  for(isector = 0; isector < function_b6fe5ecc5aa631e(); isector++) {
    sectors = ent function_f483cb14cb6af004(type);
    sector = sectors[isector];

    if(isDefined(sector.origin)) {
      return true;
    }
  }

  return false;
}

function function_bc40e686419d910e(enemy, var_807fe94e8ec14536) {
  var_f896ee073845fc13 = 0;

  if(var_f896ee073845fc13) {
    return enemy.origin;
  }

  if(getdvarint(@ "hash_9d4b3d44366c276d", 0)) {
    return enemy.origin;
  }

  enemy function_9b72e8ac7409e020(self.var_5754d6c3df1a2b31);
  sectors = enemy function_f483cb14cb6af004(self.var_5754d6c3df1a2b31);

  enemy_origin = var_807fe94e8ec14536;
  delta = self.origin - enemy_origin;
  mydisttoenemysq = lengthsquared(delta);

  if(mydisttoenemysq < 256) {
    var_b54f9acf902ff598 = -1;

    for(isector = 0; isector < function_b6fe5ecc5aa631e(); isector++) {
      sector = sectors[isector];

      if(isDefined(sector.claimer) && sector.claimer == self) {
        var_b54f9acf902ff598 = sector.num;
      }
    }

    if(var_b54f9acf902ff598 < 0) {
      var_b54f9acf902ff598 = self getentitynumber() % function_b6fe5ecc5aa631e();
    }

    var_b44e7861a744eba2 = var_b54f9acf902ff598;
  } else {
    angle = angleclamp180(vectortoyaw(delta)) + 180;
    var_b44e7861a744eba2 = angle / function_2e76ca63b9a152aa();
    var_b54f9acf902ff598 = int(var_b44e7861a744eba2 + 0.5);
  }

  result = undefined;
  dirstart = -1;
  dirstop = 3;
  dirstep = 2;

  if(var_b44e7861a744eba2 > var_b54f9acf902ff598) {
    dirstart *= -1;
    dirstop *= -1;
    dirstep *= -1;
  }

  var_c16422f50a5880a0 = function_b6fe5ecc5aa631e();

  for(step = 0; step < var_c16422f50a5880a0 / 2 + 1; step++) {
    dir = dirstart;

    while(dir != dirstop) {
      checksector = var_b54f9acf902ff598 + step * dir;

      if(checksector >= var_c16422f50a5880a0) {
        checksector -= var_c16422f50a5880a0;
      } else if(checksector < 0) {
        checksector += var_c16422f50a5880a0;
      }

      sector = sectors[checksector];

      if(!isDefined(result) && gettime() - sector.timestamp >= self.var_5cb3cc0c49ee04f1) {
        assert(sector.num == checksector);

        if(isDefined(level.var_3421a346c571fbae) && isDefined(level.var_3421a346c571fbae[self.agent_type])) {
          [[level.var_3421a346c571fbae[self.agent_type]]](sector, enemy_origin, self.attackoffset, self.radius);
        } else {
          function_3421a346c571fbae(sector, enemy_origin, self.attackoffset, self.radius);
        }
      }

      if(!isDefined(result) && isDefined(sector.origin)) {
        closest_point = getclosestpointonnavmesh(enemy.origin, self);
        traceresults = navtrace(sector.origin, closest_point, self, 1);

        if(traceresults["fraction"] < 0.95) {
          if(!ispointonnavmesh(enemy.origin)) {
            result = closest_point;
          }

          goto LOC_00000506;
        }

        var_c1bc7003e9e96206 = 0;

        if(isDefined(sector.claimer) && sector.claimer != self) {
          offsetcloser = vectorNormalize(enemy_origin - sector.claimer.origin) * self.radius * 2;
          var_c1bc7003e9e96206 = distancesquared(sector.claimer.origin + offsetcloser, enemy_origin);
        }

        if(!isalive(sector.claimer) || !isDefined(sector.claimer.enemy) || sector.claimer.enemy != enemy || sector.claimer == self || mydisttoenemysq < var_c1bc7003e9e96206) {
          if(isalive(sector.claimer) && sector.claimer != self) {
            sector.claimer.var_3d886dde9b70d929 = undefined;
            sector.claimer = undefined;
          }

          if(isDefined(self.var_3d886dde9b70d929) && self.var_3d886dde9b70d929 != sector) {
            self.var_3d886dde9b70d929.claimer = undefined;
            self.var_3d886dde9b70d929 = undefined;
          }

          if(!isDefined(self.var_3d886dde9b70d929) || self.var_3d886dde9b70d929 != sector) {
            self.var_3d886dde9b70d929 = sector;
            sector.claimer = self;
          }

          result = sector.origin;
        }
      }

      if(step == 0) {
        break;
      }

      LOC_00000506:
        dir += dirstep;
    }
  }

  return result;
}

function function_3421a346c571fbae(sector, var_65fcad9446d3a2f9, attackoffset, radius) {
  if(gettime() - sector.timestamp >= 50) {
    sector.origin = function_6a71485bed30022f(var_65fcad9446d3a2f9, sector.num, attackoffset);
    sector.origin = function_be302e4229f2239a(sector.origin, radius, 55);
    sector.timestamp = gettime();
  }
}

function function_be302e4229f2239a(position, radius, height, drop_distance) {
  assert(isDefined(radius) && isDefined(height));

  if(!isDefined(drop_distance)) {
    drop_distance = 18;
  }

  startpos = position + (0, 0, drop_distance);
  endpos = position + (0, 0, drop_distance * -1);
  droppedpos = self aiphysicstrace(startpos, endpos, radius, height, 1);

  if(abs(droppedpos[2] - startpos[2]) < 0.1) {
    return undefined;
  }

  if(abs(droppedpos[2] - endpos[2]) < 0.1) {
    return undefined;
  }

  return droppedpos;
}

function function_fcb16f2eaf12da83() {
  return self.meleeradius;
}

function function_7712021f38c94913() {
  return self.meleeradiussq;
}

function function_e99764063b47df86(yawdiff, numentries) {
  animindex = 0;

  if(numentries > 1) {
    halfentries = int(numentries * 0.5);
    randrange = halfentries + numentries % 2;

    if(yawdiff < 0) {
      animindex = randomint(randrange);
    } else {
      animindex = halfentries + randomint(randrange);
    }
  }

  return animindex;
}

function function_254992a907ee42e9(ent) {
  zmin = self.origin[2] + self.height;

  if(ent.origin[2] < zmin) {
    return false;
  }

  zmax = self.origin[2] + self.height + 2 * self.radius;

  if(ent.origin[2] > zmax) {
    return false;
  }

  if(isPlayer(ent)) {
    zvel = ent getvelocity()[2];

    if(abs(zvel) > 12) {
      return false;
    }
  }

  entradius = 15;

  if(isDefined(ent.radius)) {
    entradius = ent.radius;
  }

  radiussq = self.radius + entradius;
  radiussq *= radiussq;

  if(distance2dsquared(self.origin, ent.origin) > radiussq) {
    return false;
  }

  return true;
}

function setfavoriteenemy(enemy) {
  self.favoriteenemy = enemy;
}

function function_15b80ae6984f4ccc(vpoint, vdir) {
  hitangle = 0;

  if(isDefined(vpoint)) {
    var_c563ad9a49196c2e = vpoint - self gettagorigin("J_SpineLower");
    var_c563ad9a49196c2e = (var_c563ad9a49196c2e[0], var_c563ad9a49196c2e[1], 0);
    hitdirtoangles = vectortoangles(vectorNormalize(var_c563ad9a49196c2e));
    hitangle = hitdirtoangles[1];
  } else if(isDefined(vdir)) {
    hitdirtoangles = vectortoangles(vdir);
    hitangle = hitdirtoangles[1] - 180;
  }

  return hitangle;
}

function player_in_laststand(player) {
  return player.inlaststand;
}

function function_1ea5d1ad97d72da5(point, targetpoint) {
  var_63e2b577b3021861 = self.var_a9bbce143412f034 * self.var_a9bbce143412f034;
  return distancesquared(point, targetpoint) <= var_63e2b577b3021861;
}

function function_107e3c278ccf7264() {
  return function_1ea5d1ad97d72da5(self.origin, self.enemy.origin);
}

function function_859ce1caaf98db64() {
  if(function_fcb16f2eaf12da83() == self.var_fa4cf34a0c3681b8) {
    return function_e2c77ec2e423711();
  }

  withinradius = distancesquared(self.origin, self.enemy.origin) <= function_7712021f38c94913();
  return withinradius;
}

function function_e2c77ec2e423711() {
  withinradius = distancesquared(self.origin, self.enemy.origin) <= self.var_f5bd7eeb8c658300;

  if(!withinradius && (isPlayer(self.enemy) || isagent(self.enemy))) {
    enemygroundent = undefined;
    enemygroundent = self.enemy getgroundentity();

    if(isDefined(enemygroundent) && isDefined(enemygroundent.targetname) && enemygroundent.targetname == "care_package") {
      withinradius = distancesquared(self.origin, self.enemy.origin) <= self.var_f5bd7eeb8c658300 * 4;
    }
  }

  if(!withinradius && isPlayer(self.enemy) && istrue(self.enemy.var_a51f5edf259acc29)) {
    if(length(self getvelocity()) < 5) {
      withinradius = distancesquared(self.origin, self.enemy.origin) <= self.var_f5bd7eeb8c658300 * 4;
    }
  }

  return withinradius;
}

function function_a490d346d97d0167(radius) {
  self.meleeradius = radius;
  self.meleeradiussq = radius * radius;
}

function function_6f1f2cf8495fb8f2() {
  return true;
}

function function_2d78d2cf5681691a() {
  assert(isDefined(self.enemy));

  if(isDefined(self.var_3071905d9ea1749c) && isDefined(self.var_c72136d828c5dba2) && distance2dsquared(self.enemy.origin, self.var_3071905d9ea1749c) < 4 && distancesquared(self.origin, self.var_c72136d828c5dba2) < 2500) {
    return true;
  }

  return false;
}

function function_8c1ebabcc8737d7e(startpos, targetpos) {
  assert(isDefined(startpos));
  assert(isDefined(targetpos));
  withinheight = 0;
  zdiff = targetpos[2] - startpos[2];
  withinheight = zdiff <= self.var_7a480deb4960d81e && zdiff >= self.var_a853a9004b90b766;

  if(!withinheight && isPlayer(self.enemy) && istrue(self.enemy.var_a51f5edf259acc29)) {
    if(length(self getvelocity()) < 5) {
      withinheight = zdiff <= self.var_7a480deb4960d81e * 2 && zdiff >= self.var_a853a9004b90b766;
    }
  }

  return withinheight;
}

function function_79bba7d55bf175a9(targetpos) {
  return function_8c1ebabcc8737d7e(self.origin, targetpos);
}

function function_b5c47115061c80c9(startpos, targetpos) {
  return distance2dsquared(startpos, targetpos) < function_7712021f38c94913() * 0.9 * 0.9;
}

function function_533184b35acabfe8(targetpos) {
  return function_b5c47115061c80c9(self.origin, targetpos);
}

function function_3044ff47cea632ac() {
  assert(isDefined(self.enemy));

  if(function_254992a907ee42e9(self.enemy)) {
    return false;
  }

  return !function_79bba7d55bf175a9(self.enemy.origin) && function_533184b35acabfe8(self.enemy.origin);
}

function ismeleeblocked() {
  startpos = self.origin + (0, 0, self.var_7c0157ec8b265f6e);
  endpos = self.enemy.origin + (0, 0, self.var_7c0157ec8b265f6e);

  if(!isPlayer(self.enemy) && !isai(self.enemy)) {
    return false;
  }

  contents = create_default_contents(1);

  if(ray_trace_passed(startpos, endpos, self.enemy, contents)) {
    return false;
  }

  return true;
}

function isreallyalive(player) {
  if(isalive(player) && !isDefined(player.fauxdead)) {
    return true;
  }

  return false;
}

function function_6f13d6be163ad9a(var_a7a462c25f695db5, var_afe6d98f578d1615) {
  if(!isDefined(var_afe6d98f578d1615)) {
    var_afe6d98f578d1615 = 1;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!isreallyalive(self.enemy)) {
    return false;
  }

  if(self.aistate == "traverse") {
    return false;
  }

  if(!function_254992a907ee42e9(self.enemy)) {
    if(!function_79bba7d55bf175a9(self.enemy.origin)) {
      return false;
    }

    if(var_a7a462c25f695db5 == "offmesh" && !function_107e3c278ccf7264()) {
      return false;
    }

    if(var_a7a462c25f695db5 == "normal" && !function_859ce1caaf98db64()) {
      return false;
    } else if(var_a7a462c25f695db5 == "base" && !function_e2c77ec2e423711()) {
      return false;
    }
  }

  self.var_16cf75ff2bb42685 = undefined;

  if(var_afe6d98f578d1615 && ismeleeblocked()) {
    self.var_16cf75ff2bb42685 = 1;
    return false;
  }

  return true;
}

function function_fd42be10a26fff59(enemy) {
  if(!isDefined(self.var_eb7921eab3ea5477)) {
    self.var_eb7921eab3ea5477 = spawnStruct();
  }

  var_1a9d3cfac74bf193 = function_f814071e24378b97(enemy);
  self.var_eb7921eab3ea5477.var_1a9d3cfac74bf193 = var_1a9d3cfac74bf193;
  targetpoint = function_bc40e686419d910e(enemy, var_1a9d3cfac74bf193);

  if(isDefined(targetpoint)) {
    self.var_eb7921eab3ea5477.valid = 1;
    self.var_eb7921eab3ea5477.origin = targetpoint;
  } else {
    self.var_eb7921eab3ea5477.valid = 0;
    self.var_eb7921eab3ea5477.origin = var_1a9d3cfac74bf193;
  }

  return self.var_eb7921eab3ea5477;
}

function shouldignoreent(var_af4cbac5d9f8d2dd, var_ba056d5b8ef945be) {
  if(getdvarint(@ "hash_d264fee13c04085c", 0) != 0) {
    return true;
  }

  if(isPlayer(var_af4cbac5d9f8d2dd) && var_af4cbac5d9f8d2dd function_f1dcadc8f7c3477c()) {
    return true;
  }

  if(isDefined(var_af4cbac5d9f8d2dd.team) && isDefined(self.team) && self.team == var_af4cbac5d9f8d2dd.team) {
    return true;
  }

  if(isplayerteleporting(var_af4cbac5d9f8d2dd)) {
    return true;
  }

  if(isDefined(var_af4cbac5d9f8d2dd.killing_time)) {
    return true;
  }

  if(istrue(var_af4cbac5d9f8d2dd.notarget)) {
    return true;
  }

  if(istrue(var_af4cbac5d9f8d2dd.ignoreme)) {
    return true;
  }

  if(!isalive(var_af4cbac5d9f8d2dd)) {
    return true;
  }

  if(isDefined(level.var_cd41441b70af845e)) {
    if([[level.var_cd41441b70af845e]](var_af4cbac5d9f8d2dd)) {
      return true;
    }
  }

  return false;
}

function isplayerteleporting(player) {
  return isDefined(player.inteleport) && player.inteleport;
}

function function_d2272a70b9d7e404(hitloc) {
  return level.var_f2ce94caf2fb708d.deathanims["hitLoc"][hitloc];
}

function function_5c077abb4750bca3(direction) {
  return false;
}

function function_546a879305abdc4a(state, damagedirection, hitloc, animarray) {
  if(isDefined(hitloc)) {
    var_a54ab16bb0ef3c60 = animarray[state][damagedirection][hitloc];
  } else {
    var_a54ab16bb0ef3c60 = animarray[state][damagedirection];
  }

  return var_a54ab16bb0ef3c60[randomint(var_a54ab16bb0ef3c60.size)];
}

function function_cf169a8de2a0d355(var_59b3bc67d984b46f) {
  self.var_6e8bc2a1f79b2398 = var_59b3bc67d984b46f;
  assert(self.var_6e8bc2a1f79b2398 == "<dev string:x1c>" || self.var_6e8bc2a1f79b2398 == "<dev string:x24>" || self.var_6e8bc2a1f79b2398 == "<dev string:x2b>");
  scripts\asm\asm_bb::bb_requestmovetype(self.var_6e8bc2a1f79b2398);

  if(var_59b3bc67d984b46f == "walk") {
    self.var_da951e8204605e7 = 0.8;
    return;
  }

  if(var_59b3bc67d984b46f == "run") {
    self.var_da951e8204605e7 = 1;
    return;
  }

  if(var_59b3bc67d984b46f == "sprint") {
    self.var_da951e8204605e7 = 1.2;
  }
}

function function_e8f9a124778cc606(var_430d5c97ac6d7f48) {
  var_2de2d8565d288f81["walk"] = [0.65, 1.2];
  var_2de2d8565d288f81["run"] = [0.8, 1.1];
  var_2de2d8565d288f81["sprint"] = [0.9, 1.3];
  assert(var_430d5c97ac6d7f48 >= 0 && var_430d5c97ac6d7f48 <= 2);

  if(!isDefined(self.var_6daf599c19e44691)) {
    self.var_6daf599c19e44691 = randomfloatrange(-0.1, 0.1);
  }

  var_6adfc5befba25f92 = clamp(var_430d5c97ac6d7f48 + self.var_6daf599c19e44691, 0, 2);

  if(var_430d5c97ac6d7f48 <= 1) {
    minscalar = var_2de2d8565d288f81[self.var_6e8bc2a1f79b2398][0];
    maxscalar = 1;
    var_4f439c539cf632a1 = minscalar + var_430d5c97ac6d7f48 * (maxscalar - minscalar);
  } else {
    minscalar = 1;
    maxscalar = var_2de2d8565d288f81[self.var_6e8bc2a1f79b2398][1];
    var_4f439c539cf632a1 = minscalar + (var_430d5c97ac6d7f48 - 1) * (maxscalar - minscalar);
  }

  self.var_8d31c7eacb516468 = var_4f439c539cf632a1;
  self.var_d2d25942e3b908e9 = var_4f439c539cf632a1;
}