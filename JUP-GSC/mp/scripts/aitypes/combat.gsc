/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\combat.gsc
***********************************************/

#using scripts\aitypes\bt_util;
#using scripts\aitypes\squad;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#namespace combat;

function soldier_init_common() {
  scripts\common\cap::init_cap();
  self.disablecoveringfire = 0;
  self.var_6a2525ae2b942b46 = 1.5;
  self function_8bbcaeb23a1512ef("all", 1, "bt");
}

function function_33ef051afbf024e2(guy) {
  points = [];
  forward = anglesToForward(self.angles);
  left = anglestoleft(self.angles);
  up = anglestoup(self.angles);
  guyspeed = 0;
  guyvehicle = guy getlinkedparent();
  guyspeed = length(guyvehicle vehicle_getvelocity());
  var_39c92ff067275632 = anglesToForward(guyvehicle.angles);
  selfvelocity = self vehicle_getvelocity();
  selfspeed = length(selfvelocity);
  isreverse = vectordot(forward, selfvelocity) < 0;

  if(isreverse) {
    selfspeed *= -1;
  }

  vehiclejumpoffsets = [];
  vehiclejumpoffsets[0] = (-50, 0, -10);

  foreach(offsetdata in vehiclejumpoffsets) {
    forwardvector = forward * offsetdata[0];
    leftvector = left * offsetdata[1];
    upvector = up * offsetdata[2];
    point = self.origin + forwardvector + leftvector + upvector;
    points[points.size] = point;
  }

  return points;
}

function vehiclejump(taskid) {
  if(!getdvarint(@ "hash_18f07c17515921ea")) {
    return anim.failure;
  }

  if(!istrue(self.var_a4ec4541434ca606)) {
    return anim.failure;
  }

  vehicle = self._blackboard.currentvehicle;

  if(gettime() < 5000) {
    return anim.failure;
  }

  if(!isDefined(level.player.veh)) {
    return anim.failure;
  }

  player_vehicle = level.player.veh;

  if(isDefined(player_vehicle.jumperrider)) {
    return anim.failure;
  }

  if(!isDefined(level.var_e9c7f2ae8af2293b)) {
    level.var_e9c7f2ae8af2293b = 0;
  }

  if(gettime() < level.var_e9c7f2ae8af2293b) {
    return anim.failure;
  }

  if(istrue(self.var_58e8388f04abb64e)) {
    return anim.failure;
  }

  var_71e1dfcb6998d10c = self._blackboard.currentvehicleanimalias;
  var_84cacb9685561983 = string(self._blackboard.var_9176cae5619d7fba);
  animresult = archetypegetrandomalias(var_71e1dfcb6998d10c, "vehicle_jumper_jump", var_84cacb9685561983, asm_isfrantic());

  if(!isDefined(animresult)) {
    return anim.failure;
  }

  jumptoarcname = player_vehicle.vehicleanimalias;
  jumptoalias = string(2);
  animresult = archetypegetrandomalias(jumptoarcname, "vehicle_jumper_get_up", jumptoalias, asm_isfrantic());

  if(!isDefined(animresult)) {
    return anim.failure;
  }

  if(!isalive(player_vehicle)) {
    return anim.failure;
  }

  if(distancesquared(player_vehicle.origin, vehicle.origin) > 40000) {
    return anim.failure;
  }

  if(self.vehicle_position == 0) {
    var_3c883bb046ccbae8 = vehicle.riders.size == 1 || vehicle.health < 25;

    if(!var_3c883bb046ccbae8) {
      return anim.failure;
    }
  }

  var_cbf88131408c3aed = istrue(self._blackboard.var_6a69fa6b0b354c93) && istrue(self.canshootinvehicle);
  var_501e62dddf768fc8 = vectortoangles(player_vehicle.origin - self.origin);
  var_be2f619c49b49ae3 = angleclamp(var_501e62dddf768fc8[1]);
  facing_yaw = angleclamp(self.angles[1]);
  angle_diff = angleclamp180(var_be2f619c49b49ae3 - facing_yaw);

  if(var_cbf88131408c3aed && abs(angle_diff) > 45) {
    return anim.failure;
  }

  if(!self islinked()) {
    return anim.failure;
  }

  jumpdata = spawnStruct();
  jumpdata.vehicle = player_vehicle;
  jumpdata.prevvehicle = vehicle;
  points = player_vehicle function_33ef051afbf024e2(self);
  var_195256e3fcc08d9a = 99999999;

  foreach(index, point in points) {
    var_c5675affb3e31d81 = distancesquared(point, self.origin);

    if(var_c5675affb3e31d81 <= 57600) {
      jumpdata.index = index;
      jumpdata.point = point;
      var_195256e3fcc08d9a = var_c5675affb3e31d81;
      break;
    }
  }

  if(!isDefined(jumpdata.point)) {
    return anim.failure;
  }

  foreach(rider in vehicle.riders) {
    if(self != rider) {
      drivercanjump = vehicle.health < 25;

      if(rider.vehicle_position != 0 || drivercanjump) {
        if(distancesquared(jumpdata.point, rider.origin) < var_195256e3fcc08d9a) {
          return anim.failure;
        }
      }
    }
  }

  vehicle_yaw = angleclamp180(player_vehicle.angles[1]);
  angles = vectortoangles(self.origin - jumpdata.point);
  yaw = angleclamp180(angles[1]);
  yaw_diff = angleclamp180(yaw - vehicle_yaw);

  if(yaw_diff < 90 - 16 / 2 && yaw_diff > -1 * (90 - 16 / 2) || yaw_diff > 90 + 16 / 2 || yaw_diff < -1 * (90 + 16 / 2)) {
    return anim.failure;
  }

  self.jumpdata = jumpdata;
  player_vehicle.jumperrider = self;
  level.var_e9c7f2ae8af2293b = gettime() + 20000;
  scripts\common\cap::cap_start("vehicle_jumper", player_vehicle.vehicleanimalias);
  vehicle.riders = array_remove(vehicle.riders, self);
  return anim.success;
}

function vehiclemaymelee(taskid) {
  vehicle = self._blackboard.currentvehicle;

  if(!isDefined(vehicle)) {
    return anim.failure;
  }

  pos = self._blackboard.var_9176cae5619d7fba;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, pos);

  if(!istrue(aianims.canmeleeinvehicle)) {
    return anim.failure;
  }

  return anim.success;
}

function updateeveryframe_noncombat(taskid) {
  bb_requestweapon(weaponclass(self.primaryweapon));
  whizbyevent = asm_getephemeraleventdata("ai_notify", "bulletwhizby");

  if(isDefined(whizbyevent)) {
    if(!self.disablebulletwhizbyreaction) {
      whizbyenemy = whizbyevent[0];
      enemynear = isDefined(whizbyenemy) && distancesquared(self.origin, whizbyenemy.origin) < 160000;

      if(enemynear || cointoss()) {
        self._blackboard.whizbyeventtime = gettime() - 50;
      }
    }
  } else {
    var_4b4adf39cfe6c5af = 100;

    if(isDefined(self._blackboard.whizbyeventtime) && gettime() > self._blackboard.whizbyeventtime + var_4b4adf39cfe6c5af) {
      self._blackboard.whizbyeventtime = undefined;
    }
  }

  self.looktarget = undefined;
  return anim.success;
}

function shouldbefrantic() {
  if(isDefined(self.frantic)) {
    return self.frantic;
  }

  return 0;
}

function hasammoinclip() {
  turret = getusedturret();

  if(isDefined(turret)) {
    return true;
  }

  if(!isDefined(self.weapon)) {
    return false;
  }

  if(self.bulletsinclip > 0 || istrue(self.disablereload)) {
    return true;
  }

  return false;
}

function islowonammo(task, params) {
  if(scripts\anim\utility_common::needtoreload(params)) {
    return anim.success;
  }

  return anim.failure;
}

function withindistancetoenemy(task, params) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(distancesquared(self.origin, self.enemy.origin) <= params * params) {
    return anim.success;
  }

  return anim.failure;
}

function mayshoot(task) {
  if(!isDefined(self.weapon)) {
    return anim.failure;
  }

  bshouldshoot = shouldshoot();

  if(bshouldshoot) {
    bshouldshoot = calcgoodshootpos();
  } else {
    self.goodshootpos = undefined;
  }

  if(!bshouldshoot) {
    return anim.failure;
  }

  return anim.success;
}

function updatelooktarget(taskid) {
  if(!isDefined(self.looktarget) || self.looktarget != self.enemy) {
    self.looktarget = self.enemy;
  }

  return anim.success;
}

function shoot_clearconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 0;
}

function shoot_enableconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 1;
}

function isaimedataimtarget() {
  return isDefined(self.asmtrackasm) && self aimedataimtarget();
}

function hasatleastammo(threshold) {
  if(isnullweapon(self.weapon)) {
    return false;
  }

  return self.bulletsinclip >= weaponclipsize(self.weapon) * threshold;
}

function reload_cheatammo() {
  clipsize = weaponclipsize(self.weapon);
  self.bulletsinclip = int(clipsize * 0.5);
  self.bulletsinclip = int(clamp(self.bulletsinclip, 0, clipsize));
}

function shouldbeajerk() {
  if(!isDefined(level.gameskill)) {
    return false;
  }

  return level.gameskill == 3 && isPlayer(self.enemy);
}

function shoulddosemiforvariety(distancesq) {
  choice = randomfloat(1);
  var_824f089b7c5f24be = shoulddosemiprobabilityline(distancesq);
  return choice <= var_824f089b7c5f24be;
}

function shoulddosemiprobabilityline(distancetotarget) {
  if(distancetotarget < 2.56e+06) {
    return -1;
  }

  return -0.3 / 6.44e+06 * distancetotarget - -0.3 / 6.44e+06 * 2.56e+06 + 0.5;
}

function getusedturret() {
  if(isDefined(self.fngetusedturret)) {
    return [[self.fngetusedturret]]();
  }
}

function shouldshoot() {
  if(!self aimayshoot()) {
    return false;
  }

  if(istrue(self._blackboard.partialgestureplaying)) {
    if(getdvarint(@ "hash_3493aa8adc34457e", 0)) {
      print3d(self.origin - (0, 0, 12), "<dev string:x1c>", (1, 0, 0), 1, 0.75);
    }

    return false;
  }

  if(self function_53fb16fcb6043bbc()) {
    if(getdvarint(@ "hash_3493aa8adc34457e", 0)) {
      print3d(self.origin - (0, 0, 12), "<dev string:x29>", (1, 0, 0), 1, 0.75);
    }

    return false;
  }

  return true;
}

function calcgoodshootpos() {
  if(self cansee(self.enemy)) {
    if(self canshootenemy()) {
      self.goodshootpos = self.enemy getshootatpos();
      return 1;
    }
  }

  bshouldshoot = cansuppressenemy();

  if(!bshouldshoot && getdvarint(@ "hash_3493aa8adc34457e", 0)) {
    print3d(self.origin - (0, 0, 12), "<dev string:x42>", (1, 0, 0), 1, 0.75);
  }

  return bshouldshoot;
}

function isenemyinlowcover(taskid) {
  if(!isDefined(self.enemy) || !issentient(self.enemy)) {
    return anim.failure;
  }

  if(self.in_melee) {
    return anim.failure;
  }

  if(!isDefined(self.enemy.lowcovervolume)) {
    return anim.failure;
  }

  if(!istrue(self.enemy.underlowcover)) {
    return anim.failure;
  }

  if(istrue(self.var_3db4fa492bdd5986)) {
    return anim.failure;
  }

  lastknownpos = self lastknownpos(self.enemy);
  var_9bc7ed05ea9a9090 = 0;

  if(istrue(self.aggressivelowcovermode)) {
    var_fc22138908af2b15 = distancesquared(self.origin, lastknownpos);
    var_95fbb30c0d7a739d = 3600;

    if(isDefined(self.var_c46e0df7e4fc8d94) && self.var_c46e0df7e4fc8d94 > 0) {
      var_95fbb30c0d7a739d = self.var_c46e0df7e4fc8d94 * self.var_c46e0df7e4fc8d94;
    }

    if(var_fc22138908af2b15 < var_95fbb30c0d7a739d) {
      var_9bc7ed05ea9a9090 = 1;
    } else if(distancesquared(self.origin, self.enemy.origin) < var_95fbb30c0d7a739d) {
      var_9bc7ed05ea9a9090 = 1;
    }
  }

  if(!var_9bc7ed05ea9a9090) {
    lastknowntime = self lastknowntime(self.enemy);

    if(lastknowntime <= gettime() - 5000) {
      return anim.failure;
    }

    if(!ispointinvolume(lastknownpos, self.enemy.lowcovervolume)) {
      return anim.failure;
    }
  }

  linkednodes = self.enemy.lowcovervolume get_linked_nodes();

  if(linkednodes.size == 0) {
    return anim.failure;
  }

  linkednodes = sortbydistance(linkednodes, lastknownpos);

  foreach(node in linkednodes) {
    if(isDefined(getnodeowner(node)) && getnodeowner(node) != self) {
      continue;
    }

    self setbtgoalnode(1, node);
    self setbtgoalRadius(1, 12);
    return anim.success;
  }

  return anim.failure;
}

function valid_reaction_sound(npcid) {
  switch (npcid) {
    case #"hash_31100bbc01bd3230":
    case #"hash_31100cbc01bd33c3":
    case #"hash_31100fbc01bd387c":
    case #"hash_311010bc01bd3a0f":
    case #"hash_311011bc01bd3ba2":
    case #"hash_311012bc01bd3d35":
    case #"hash_3689ba6c261f7001":
    case #"hash_9009aa6c552a085a":
    case #"hash_fa4482f6bd79a6ac":
    case #"hash_fa4484f6bd79a9d2":
    case #"hash_fa4485f6bd79ab65":
      return true;
  }

  return false;
}

function turretrequested(task) {
  if(isDefined(bb_getrequestedturret())) {
    return anim.success;
  }

  return anim.failure;
}

function ifshoulddosmartobject(taskid) {
  smartobj = bb_getrequestedsmartobject();

  if(!isDefined(smartobj)) {
    return anim.failure;
  }

  if(isDefined(self.disablesmartobjects)) {
    return anim.failure;
  }

  zdiff = self.origin[2] - smartobj.origin[2];

  if(zdiff * zdiff > 5184) {
    return anim.failure;
  }

  if(distance2dsquared(self.origin, smartobj.origin) > 225) {
    return anim.failure;
  }

  return anim.success;
}

function dosmartobject_init(taskid) {
  bb_requestplaysmartobject();

  if(isDefined(self.customarrivalangles)) {
    self.customarrivalangles = undefined;
  }

  self.bt.instancedata[taskid] = self.disableautolookat;
  self.disableautolookat = 1;
}

function dosmartobject(taskid) {
  if(self asmephemeraleventfired("smartobject", "finished")) {
    smartobj = bb_getrequestedsmartobject();
    smartobj scripts\smartobjects\utility::smartobject_setnextuse();
    return anim.success;
  }

  return anim.running;
}

function dosmartobjectterminate(taskid) {
  scripts\smartobjects\utility::clearsmartobject(bb_getrequestedsmartobject());
  self.disableautolookat = self.bt.instancedata[taskid];
  self.bt.instancedata[taskid] = undefined;
}

function low_cover_combat_areas() {
  if(istrue(level.low_cover_combat_setup)) {
    return;
  }

  level.low_cover_combat_setup = 1;

  setdvarifuninitialized(@ "hash_e9e10e8b10abb8b", 0);

  while(true) {
    lowareas = getEntArray("low_cover_area", "targetname");

    foreach(player in level.players) {
      covervol = undefined;

      foreach(vol in lowareas) {
        if(istrue(vol.disabled)) {
          continue;
        }

        if(ispointinvolume(player.origin, vol)) {
          covervol = vol;
          break;
        }
      }

      if(isDefined(player.lowcovervolume) && (!isDefined(covervol) || player.lowcovervolume != covervol)) {
        player notify("left_low_cover");
        player.underlowcover = 0;
      }

      if(isDefined(covervol) && (!isDefined(player.lowcovervolume) || covervol != player.lowcovervolume)) {
        player thread transfer_damage_to_player(covervol);
        player thread player_under_low_cover_monitor(covervol);
      }

      player.lowcovervolume = covervol;
    }

    waitframe();
  }
}

function player_under_low_cover_monitor(vol) {
  self endon("left_low_cover");
  self endon("death");
  dotrace = 1;

  if(isDefined(vol.script_trace) && vol.script_trace == 0) {
    dotrace = 0;
  }

  while(true) {
    if(dotrace && !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 60), self)) {
      self.underlowcover = 1;
    } else if(!dotrace && ispointinvolume(self.origin, vol)) {
      self.underlowcover = 1;
    } else {
      self.underlowcover = 0;
    }

    if(getdvarint(@ "hash_e9e10e8b10abb8b") && self.underlowcover) {
      line(self.origin, vol.origin, (1, 1, 1), 1, 0, 3);
    }

    wait 0.15;
  }
}

function transfer_damage_to_player(vol) {
  self endon("left_low_cover");
  self endon("death");
  dmg_trig = vol get_linked_ents()[0];

  if(!isDefined(dmg_trig)) {
    return;
  }

  first_shot = 1;

  while(isDefined(dmg_trig)) {
    dmg_trig waittill("damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!isalive(attacker)) {
      continue;
    }

    if(attacker == self) {
      continue;
    }

    if(!self istouching(dmg_trig)) {
      continue;
    }

    if(is_equal(type, "MOD_MELEE")) {
      continue;
    }

    if(issubstr(type, "BULLET")) {
      forward = anglesToForward(attacker gettagangles("tag_flash"));
      normal = vectorNormalize(self getEye() - attacker gettagorigin("tag_flash"));

      if(vectordot(forward, normal) < 0.9) {
        continue;
      }

      if(first_shot) {
        first_shot = 0;
        wait 2;
        continue;
      }
    }

    self dodamage(amt, attacker.origin, attacker, attacker, type, attacker.weapon);
  }
}