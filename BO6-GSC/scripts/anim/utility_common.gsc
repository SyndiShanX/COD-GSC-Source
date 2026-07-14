/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\utility_common.gsc
*******************************************/

#using scripts\engine\utility;
#namespace utility_common;

function print3dtime(timer, org, msg, color, alpha, scale) {
  newtime = timer / 0.05;

  for(i = 0; i < newtime; i++) {
    print3d(org, msg, color, alpha, scale);

    wait 0.05;
  }
}

function print3drise(org, msg, color, alpha, scale) {
  newtime = 100;
  up = 0;
  org += utility::randomvector(30);

  for(i = 0; i < newtime; i++) {
    up += 0.5;

    print3d(org + (0, 0, up), msg, color, alpha, scale);

    wait 0.05;
  }
}

function crossproduct(vec1, vec2) {
  return vec1[0] * vec2[1] - vec1[1] * vec2[0] > 0;
}

function safemod(a, b) {
  result = int(a) % b;
  result += b;
  return result % b;
}

function quadrantanimweights(yaw) {
  forwardweight = cos(yaw);
  leftweight = sin(yaw);
  result["front"] = 0;
  result["right"] = 0;
  result["back"] = 0;
  result["left"] = 0;

  if(isDefined(self.alwaysrunforward)) {
    assert(self.alwaysrunforward);
    result["front"] = 1;
    return result;
  }

  if(forwardweight > 0) {
    if(leftweight > forwardweight) {
      result["left"] = 1;
    } else if(leftweight < -1 * forwardweight) {
      result["right"] = 1;
    } else {
      result["front"] = 1;
    }
  } else {
    backweight = -1 * forwardweight;

    if(leftweight > backweight) {
      result["left"] = 1;
    } else if(leftweight < forwardweight) {
      result["right"] = 1;
    } else {
      result["back"] = 1;
    }
  }

  return result;
}

function getquadrant(angle) {
  angle = angleclamp(angle);

  if(angle < 45 || angle > 315) {
    quadrant = "front";
  } else if(angle < 135) {
    quadrant = "left";
  } else if(angle < 225) {
    quadrant = "back";
  } else {
    quadrant = "right";
  }

  return quadrant;
}

function isinset(input, set) {
  for(i = set.size - 1; i >= 0; i--) {
    if(input == set[i]) {
      return true;
    }
  }

  return false;
}

function weapon_genade_launcher() {
  return !isnullweapon(self.weapon) && weaponclass(self.weapon) == "grenade";
}

function weapon_pump_action_shotgun() {
  return !isnullweapon(self.weapon) && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

function islmg(weapon) {
  return weaponclass(weapon) == "mg";
}

function ispistol(weapon) {
  return weaponclass(weapon) == "pistol";
}

function isshotgun(weapon) {
  return weaponclass(weapon) == "spread";
}

function issniperrifle(weapon) {
  return weaponclass(weapon) == "sniper";
}

function isshotgunai() {
  return isshotgun(self.primaryweapon);
}

function islongrangeai() {
  return self aiissniper() || usingrocketlauncher();
}

function usingrocketlauncher() {
  return weaponclass(self.weapon) == "rocketlauncher";
}

function usingmg() {
  return weaponclass(self.weapon) == "mg";
}

function isusingshotgun() {
  return weaponclass(self.weapon) == "spread";
}

function function_2fff89909fdbfbab(weapon) {
  class = weaponclass(weapon);

  switch (class) {
    case #"hash_690c0d6a821b42e":
    case #"hash_6191aaef9f922f96":
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_900cb96c552c5e8e":
    case #"hash_fa24dff6bd60a12d":
      return true;
  }

  return false;
}

function repeater_headshot_ammo_passive(objweapon, attacker, victim) {
  if(!(isDefined(attacker) && isDefined(objweapon) && isDefined(victim))) {
    return;
  }

  if(!isPlayer(attacker)) {
    return;
  }

  base_name = objweapon.basename;

  if(base_name != "iw7_repeater") {
    return;
  }

  if(!isDefined(victim.damagelocation)) {
    return;
  }

  if(victim.damagelocation != "head" && victim.damagelocation != "helmet") {
    return;
  }

  maxclipammo = weaponclipsize(objweapon);
  refundcount = maxclipammo * 1;
  currammo = attacker getweaponammoclip(objweapon);
  newammo = min(currammo + refundcount, maxclipammo);
  attacker setweaponammoclip(objweapon, int(newammo));
}

function needtoreload(thresholdfraction) {
  if(isnullweapon(self.weapon)) {
    return false;
  }

  if(self.disablereload) {
    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5) {
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);
    }

    if(self.bulletsinclip <= 0) {
      self.bulletsinclip = 0;
    }

    return false;
  }

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * thresholdfraction) {
    if(thresholdfraction == 0) {
      if(cheatammoifnecessary()) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function cheatammoifnecessary() {
  assert(!self.bulletsinclip);

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(self.team != "allies") {
    if(!isPlayer(self.enemy)) {
      return false;
    }
  }

  if(isusingsidearm() || usingrocketlauncher()) {
    return false;
  }

  if(gettime() - self.ammocheattime < self.ammocheatinterval) {
    return false;
  }

  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536) {
    return false;
  }

  self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);

  if(self.bulletsinclip > weaponclipsize(self.weapon)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
  }

  self.ammocheattime = gettime();
  return true;
}

function isusingprimary() {
  return self.weapon == self.primaryweapon && !isnullweapon(self.weapon);
}

function isusingsecondary() {
  return self.weapon == self.secondaryweapon && !isnullweapon(self.weapon);
}

function isusingsidearm() {
  return self.weapon == self.sidearm && !isnullweapon(self.weapon);
}

function getclaimednode() {
  return self.node;
}

function shootenemywrapper(var_3194eba7c1afe666) {
  if(!isDefined(var_3194eba7c1afe666)) {
    var_3194eba7c1afe666 = 1;
  }

  [[anim.shootenemywrapper_func]](var_3194eba7c1afe666);
}

function getnodeyawtoorigin(pos) {
  assert(!utility::actor_is3d());

  if(isDefined(self.node)) {
    yaw = self.node.angles[1] - utility::getyaw(pos);
  } else {
    yaw = self.angles[1] - utility::getyaw(pos);
  }

  yaw = angleclamp180(yaw);
  return yaw;
}

function getnodeyawtoenemy() {
  assert(!utility::actor_is3d());
  pos = undefined;

  if(isDefined(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      forward = anglesToForward(self.node.angles);
    } else {
      forward = anglesToForward(self.angles);
    }

    forward *= 150;
    pos = self.origin + forward;
  }

  if(isDefined(self.node)) {
    yaw = self.node.angles[1] - utility::getyaw(pos);
  } else {
    yaw = self.angles[1] - utility::getyaw(pos);
  }

  yaw = angleclamp180(yaw);
  return yaw;
}

function getyawtoenemy() {
  assert(!utility::actor_is3d());
  pos = undefined;

  if(isDefined(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.angles);
    forward *= 150;
    pos = self.origin + forward;
  }

  yaw = self.angles[1] - utility::getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw2d(org) {
  assert(!utility::actor_is3d());
  angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
  return angles[1];
}

function absyawtoenemy() {
  assert(!utility::actor_is3d());
  assert(isDefined(self.enemy));
  yaw = self.angles[1] - utility::getyaw(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function absyawtoenemy2d() {
  assert(!utility::actor_is3d());
  assert(isDefined(self.enemy));
  yaw = self.angles[1] - getyaw2d(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function absyawtoorigin(org) {
  assert(!utility::actor_is3d());
  yaw = self.angles[1] - utility::getyaw(org);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function absyawtoangles(angles) {
  assert(!utility::actor_is3d());
  yaw = self.angles[1] - angles;
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function getyawfromorigin(org, start) {
  assert(!utility::actor_is3d());
  angles = vectortoangles(org - start);
  return angles[1];
}

function getgrenademodel() {
  return getweaponmodel(self.grenadeweapon);
}

function getenemyeyepos(enemy) {
  if(!isDefined(enemy)) {
    enemy = self.enemy;
  }

  if(isDefined(enemy)) {
    self.a.lastenemypos = enemy getshootatpos();
    self.a.lastenemytime = gettime();
    return self.a.lastenemypos;
  }

  if(isDefined(self.a.lastenemytime) && isDefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime()) {
    return self.a.lastenemypos;
  }

  targetpos = self getshootatpos();
  targetpos += 196 * self.lookforward;
  return targetpos;
}

function gettruenodeangles(node) {
  if(!isDefined(node)) {
    return (0, 0, 0);
  }

  if(!isDefined(node.script_angles)) {
    return node.angles;
  }

  var_70123e445fbedb76 = node.angles;
  node_x = angleclamp180(var_70123e445fbedb76[0] + node.script_angles[0]);
  node_y = var_70123e445fbedb76[1];
  node_z = angleclamp180(var_70123e445fbedb76[2] + node.script_angles[2]);
  return (node_x, node_y, node_z);
}

function getyawtoorigin(org) {
  assert(!utility::actor_is3d());

  if(isDefined(self.type) && utility::isnode3d(self)) {
    node_angles = gettruenodeangles(self);
    forward = anglesToForward(node_angles);
    rotatedorg = rotatepointaroundvector(forward, org - self.origin, node_angles[2] * -1);
    rotatedorg += self.origin;
    yaw = utility::getyaw(rotatedorg) - node_angles[1];
    yaw = angleclamp180(yaw);
    return yaw;
  }

  yaw = utility::getyaw(org) - self.angles[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

function canseepointfromexposedatcorner(point, node) {
  yaw = node getyawtoorigin(point);

  if(yaw > 60 || yaw < -60) {
    return false;
  }

  if(utility::isnodecoverleft(node) && yaw < -14) {
    return false;
  }

  if(utility::isnodecoverright(node) && yaw > 12) {
    return false;
  }

  return true;
}

function getnodeoffset(node) {
  var_7237854e3be197ca = node.offset;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  cover_left_crouch_offset = (-26, 0.4, 36);
  cover_left_stand_offset = (-32, 7, 63);
  cover_right_crouch_offset = (43.5, 11, 36);
  cover_right_stand_offset = (36, 8.3, 63);
  cover_crouch_offset = (3.5, -12.5, 45);
  cover_stand_offset = (-3.7, -22, 63);
  var_cc785dd8ae24381e = (0, 30, 13);
  cornernode = 0;
  nodeoffset = (0, 0, 0);
  axis = anglestoaxis(node.angles);
  right = axis["right"];
  forward = axis["forward"];
  up = axis["up"];
  nodetype = node.type;

  switch (nodetype) {
    case #"hash_e1d8e1adebed5a61":
      higheststance = node gethighestnodestance();

      if(!isDefined(higheststance) || higheststance == "crouch") {
        nodeoffset = calculatenodeoffset(right, forward, up, cover_left_crouch_offset);
      } else {
        nodeoffset = calculatenodeoffset(right, forward, up, cover_left_stand_offset);
      }

      break;
    case #"hash_cd3ffe799551db82":
      higheststance = node gethighestnodestance();

      if(!isDefined(higheststance) || higheststance == "crouch") {
        nodeoffset = calculatenodeoffset(right, forward, up, cover_right_crouch_offset);
      } else {
        nodeoffset = calculatenodeoffset(right, forward, up, cover_right_stand_offset);
      }

      break;
    case #"hash_410b602cd708b472":
    case #"hash_78b110033ccb68b0":
    case #"hash_805ed2ec27b468f7":
    case #"hash_bdacbb6eaaa538c7":
      nodeoffset = calculatenodeoffset(right, forward, up, cover_stand_offset);
      break;
    case #"hash_2c4ea8d9cb1d214":
    case #"hash_776752872754e5ee":
    case #"hash_c3b74422dec48736":
      nodeoffset = calculatenodeoffset(right, forward, up, cover_crouch_offset);
      break;
    case #"hash_b786e406d37a0dd7":
      nodeoffset = getcover3dnodeoffset(node);
      break;
    case #"hash_c051a32186a33cae":
      nodeoffset = calculatenodeoffset(right, forward, up, var_cc785dd8ae24381e);
      break;
  }

  node.offset = nodeoffset;
  return node.offset;
}

function getcover3dnodeoffset(node, leandir) {
  assert(isDefined(node) && node.type == "<dev string:x24>");
  var_64d970aef87b1b2b = (2, -10, 35);
  var_d68838c109759213 = (-19, -10, 32);
  var_8c00c7ee1f26521c = (16, -10, 32);
  right = anglestoright(node.angles);
  forward = anglesToForward(node.angles);
  up = anglestoup(node.angles);
  offset = var_64d970aef87b1b2b;

  if(isDefined(leandir)) {
    if(leandir == "left") {
      offset = var_d68838c109759213;
    } else if(leandir == "right") {
      offset = var_8c00c7ee1f26521c;
    } else {
      assertmsg("<dev string:x30>");
    }
  }

  return calculatenodeoffset(right, forward, up, offset);
}

function calculatenodeoffset(right, forward, up, baseoffset) {
  return right * baseoffset[0] + forward * baseoffset[1] + up * baseoffset[2];
}

function persistentdebugline(start, end) {
  self endon("<dev string:x3f>");
  level notify("<dev string:x48>");
  level endon("<dev string:x48>");

  for(;;) {
    line(start, end, (0.3, 1, 0), 1);
    wait 0.05;
  }
}

function canseeenemyfromexposed() {
  now = gettime();
  node = self.node;
  enemy = self.enemy;
  rechecktime = !isDefined(self.canseeenemyfromexposednext) || now >= self.canseeenemyfromexposednext;

  if(rechecktime || self.canseeenemyfromexposedenemy != enemy || self.canseeenemyfromexposednode != node) {
    self.canseeenemyfromexposed = canseeenemyfromexposedatnode(enemy, node);
    self.canseeenemyfromexposednext = now + 1000;
    self.canseeenemyfromexposednode = node;
    self.canseeenemyfromexposedenemy = enemy;
  }

  result = self.canseeenemyfromexposed;

  if(!result) {
    if(self getentitynumber() == getdvarint(@ "hash_c407a6f2012f4956")) {
      thread persistentdebugline(node.origin + getnodeoffset(node), getenemyeyepos());
    }
  }

  return result;
}

function canseeenemyfromexposedatnode(enemy, node) {
  if(!isDefined(enemy)) {
    return 0;
  }

  if(!isDefined(node)) {
    result = self cansee(enemy);
  } else {
    enemyeye = undefined;

    if(isscriptedai(enemy)) {
      enemyeye = enemy getapproxeyepos();
    } else {
      enemyeye = getenemyeyepos(enemy);
    }

    if(utility::actor_is3d() && utility::isnode3d(node)) {
      result = function_51bb3933b1f667fe(enemy, enemyeye, node);

      if(!result) {
        enemyeye = (enemy.origin + enemyeye) / 2;
        result = function_51bb3933b1f667fe(enemy, enemyeye, node);
      }
    } else {
      result = function_51bb3933b1f667fe(enemy, enemyeye, node);
    }
  }

  return result;
}

function function_51bb3933b1f667fe(enemy, point, node) {
  if(utility::isnodecoverleft(node) || utility::isnodecoverright(node)) {
    if(!canseepointfromexposedatcorner(point, node)) {
      return 0;
    }
  }

  nodeoffset = getnodeoffset(node);
  lookfrompoint = node.origin + nodeoffset;

  if(!checkpitchvisibility(lookfrompoint, point, node)) {
    return 0;
  }

  if(!sighttracepassed(lookfrompoint, point, 0, enemy)) {
    if(utility::isnodecovercrouch(node)) {
      lookfrompoint = (0, 0, 64) + node.origin;
      return sighttracepassed(lookfrompoint, point, 0, enemy);
    }

    return 0;
  }

  return 1;
}

function checkpitchvisibility(frompoint, topoint, atnode) {
  minpitch = self.upaimlimit - anim.aimpitchdifftolerance;
  maxpitch = self.downaimlimit + anim.aimpitchdifftolerance;
  directionvec = topoint - frompoint;

  if(utility::actor_is3d()) {
    if(isDefined(atnode) && utility::isnode3d(atnode)) {
      angles = atnode.angles;
    } else {
      angles = self.angles;
    }

    directionvec = rotatevectorinverted(directionvec, angles);
  }

  pitch = angleclamp180(vectortopitch(directionvec));

  if(pitch < minpitch) {
    return false;
  }

  if(pitch > maxpitch) {
    if(isDefined(atnode) && !utility::isnodecovercrouch(atnode)) {
      return false;
    }

    if(pitch > anim.covercrouchleanpitch + maxpitch) {
      return false;
    }
  }

  return true;
}

function dontgiveuponsuppressionyet() {
  assertmsg("<dev string:x58>");
}

function cansuppressenemy() {
  if(!hassuppressableenemy() || self.doingambush) {
    self.goodshootpos = undefined;
    return 0;
  }

  suppressiondisabled = istrue(self.disablesuppressingfire);

  if(!isPlayer(self.enemy)) {
    if(!suppressiondisabled || self.forcesuppressai) {
      return aisuppressai();
    }
  }

  if(suppressiondisabled) {
    return 0;
  }

  if(!checkpitchvisibility(self getEye(), self.lastenemysightpos)) {
    return 0;
  }

  startoffset = self getapproxeyepos();
  return findgoodsuppressspot(startoffset);
}

function hassuppressableenemy() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!isDefined(self.lastenemysightpos)) {
    return false;
  }

  if(!self iscurrentenemyvalid()) {
    return false;
  }

  if(!isDefined(self.goodshootpos) && !needrecalculatesuppressspot()) {
    return false;
  }

  return true;
}

function aisuppressai() {
  if(!self canattackenemynode() && !self.forcesuppressai) {
    return false;
  }

  shootpos = undefined;

  if(isDefined(self.enemy.covernode)) {
    nodeoffset = getnodeoffset(self.enemy.covernode);
    shootpos = self.enemy.covernode.origin + nodeoffset;
  } else {
    shootpos = self.enemy getshootatpos();
  }

  if(!self canshoot(shootpos) && !self.forcesuppressai) {
    return false;
  }

  self.goodshootpos = shootpos;
  return true;
}

function canseeandshootpoint(point) {
  if(isDefined(self.a.weaponpos) && isundefinedweapon(self.a.weaponpos["right"])) {
    return 0;
  }

  if(!sighttracepassed(self getshootatpos(), point, 0, undefined)) {
    return 0;
  }

  gunpoint = self getapproxeyepos();
  return sighttracepassed(gunpoint, point, 0, undefined);
}

function needrecalculatesuppressspot() {
  if(isDefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos)) {
    return true;
  }

  return !isDefined(self.lastenemysightposold) || distancesquared(self.lastenemysightposold, self.lastenemysightpos) > 256 || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

function findgoodsuppressspot(startoffset) {
  var_310cad2a53e7bf9d = min(self.enemy.maxvisibledist, 1024);

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(var_310cad2a53e7bf9d + 768)) {
    self.goodshootpos = undefined;
    return false;
  }

  if(needrecalculatesuppressspot()) {
    self.lastenemysightposselforigin = self.origin;
    self.lastenemysightposold = self.lastenemysightpos;

    if(self.suppress_uselastenemysightpos) {
      self.goodshootpos = self.lastenemysightpos;
      return true;
    }

    currentenemypos = getenemyeyepos();
    self.goodshootpos = self aicalcsuppressspot(startoffset, currentenemypos, self.suppress_numgoodtracesneeded);
    return isDefined(self.goodshootpos);
  } else if(isDefined(self.goodshootpos) && isDefined(self.pathgoalpos) && distancesquared(self.origin, self.goodshootpos) < 1024) {
    self.goodshootpos = undefined;
  }

  return isDefined(self.goodshootpos);
}

function canseeenemy(cacheduration) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(isDefined(cacheduration) && self cansee(self.enemy, cacheduration) || self cansee(self.enemy)) {
    if(!checkpitchvisibility(self getEye(), self.enemy getshootatpos())) {
      return false;
    }

    return true;
  }

  return false;
}

function recentlysawenemy(time = 5) {
  return isDefined(self.enemy) && self seerecently(self.enemy, time);
}

function issuppressedwrapper() {
  if(self.forcesuppression) {
    return 1;
  }

  if(self.suppressionmeter <= self.suppressionthreshold) {
    return 0;
  }

  return self issuppressed();
}

function enemyishiding() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(self.enemy utility::isflashed()) {
    return true;
  }

  if(isPlayer(self.enemy)) {
    if(self.enemy.health < self.enemy.maxhealth) {
      return true;
    }
  } else if(isai(self.enemy) && self.enemy issuppressedwrapper()) {
    return true;
  }

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading) {
    return true;
  }

  return false;
}

function shouldshootenemyent() {
  assert(isDefined(self));

  if(!canseeenemy()) {
    return false;
  }

  if(!self canshootenemy()) {
    return false;
  }

  return true;
}

function sortandcullanimstructarray(animstructarray) {
  newanimstructarray = [];

  foreach(animstruct in animstructarray) {
    if(animstruct.weight <= 0) {
      continue;
    }

    for(i = 0; i < newanimstructarray.size; i++) {
      if(animstruct.weight < newanimstructarray[i].weight) {
        for(j = newanimstructarray.size; j > i; j--) {
          newanimstructarray[j] = newanimstructarray[j - 1];
        }

        break;
      }
    }

    newanimstructarray[i] = animstruct;
  }

  return newanimstructarray;
}

function player_can_see_ai(player, ai, latency) {
  currenttime = gettime();

  if(!isDefined(latency)) {
    latency = 0;
  }

  if(isDefined(ai.playerseesmetime) && ai.playerseesmetime + latency >= currenttime) {
    assert(isDefined(ai.playerseesme));
    return ai.playerseesme;
  }

  ai.playerseesmetime = currenttime;

  if(!utility::within_fov(player.origin, player.angles, ai.origin, 0.766)) {
    ai.playerseesme = 0;
    return 0;
  }

  playereye = player getEye();
  feetorigin = ai.origin;

  if(sighttracepassed(playereye, feetorigin, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  eyeorigin = ai getapproxeyepos();

  if(sighttracepassed(playereye, eyeorigin, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  midorigin = (eyeorigin + feetorigin) * 0.5;

  if(sighttracepassed(playereye, midorigin, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  ai.playerseesme = 0;
  return 0;
}