/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_prototype_barrels.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#namespace zm_prototype_barrels;

function autoexec __init__sytem__() {
  system::register("zm_prototype_barrels", &__init__, undefined, undefined);
}

function __init__() {
  var_37ec7c95 = 0;
  a_barrels = getEntArray("explodable_barrel", "targetname");
  if(isDefined(a_barrels) && a_barrels.size > 0) {
    var_37ec7c95 = 1;
  }
  a_barrels = getEntArray("explodable_barrel", "script_noteworthy");
  if(isDefined(a_barrels) && a_barrels.size > 0) {
    var_37ec7c95 = 1;
  }
  if(!var_37ec7c95) {
    return;
  }
  clientfield::register("scriptmover", "exploding_barrel_burn_fx", 21000, 1, "int");
  clientfield::register("scriptmover", "exploding_barrel_explode_fx", 21000, 1, "int");
  level.barrelexpsound = "exp_redbarrel";
  level.barrelingsound = "exp_redbarrel_ignition";
  level.barrelhealth = 350;
  level.barrelexplodingthisframe = 0;
  array::thread_all(getEntArray("explodable_barrel", "targetname"), &explodable_barrel_think);
  array::thread_all(getEntArray("explodable_barrel", "script_noteworthy"), &explodable_barrel_think);
  level thread function_28ed3370();
}

function function_66d46c7d() {
  self clientfield::set("exploding_barrel_burn_fx", 1);
}

function function_b6fe19c5() {
  self clientfield::set("exploding_barrel_explode_fx", 1);
}

function explodable_barrel_think() {
  if(self.classname != "script_model") {
    return;
  }
  self endon("exploding");
  self.damagetaken = 0;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, p, type);
    println("" + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && (!isPlayer(attacker) && (isDefined(attacker.classname) && attacker.classname != "worldspawn"))) {
      continue;
    }
    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageowner = self;
    } else {
      self.damageowner = attacker;
    }
    if(level.barrelexplodingthisframe) {
      wait(randomfloat(1));
    }
    self.damagetaken = self.damagetaken + amount;
    if(self.damagetaken == amount) {
      self thread explodable_barrel_burn();
    }
  }
}

function explodable_barrel_burn() {
  count = 0;
  startedfx = 0;
  while(self.damagetaken < level.barrelhealth) {
    if(!startedfx) {
      function_66d46c7d();
      level thread sound::play_in_space(level.barrelingsound, self.origin);
      startedfx = 1;
    }
    if(count > 20) {
      count = 0;
    }
    if(count == 0) {
      self.damagetaken = self.damagetaken + (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250, "axis");
      self playSound("exp_barrel_fuse");
    }
    count++;
    wait(0.05);
  }
  self thread explodable_barrel_explode();
}

function explodable_barrel_explode() {
  self notify("exploding");
  self notify("death");
  up = anglestoup(self.angles);
  worldup = anglestoup(vectorscale((0, 1, 0), 90));
  dot = vectordot(up, worldup);
  offset = (0, 0, 0);
  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    end = physicstrace(start, start + (vectorscale((0, 0, -1), 64)));
    offset = end - self.origin;
  }
  offset = offset + vectorscale((0, 0, 1), 4);
  function_b6fe19c5();
  level thread sound::play_in_space(level.barrelexpsound, self.origin);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);
  playrumbleonposition("barrel_explosion", self.origin + vectorscale((0, 0, 1), 32));
  level notify("hash_83cc4809");
  level.barrelexplodingthisframe = 1;
  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }
  maxdamage = 250;
  if(isDefined(self.script_damage)) {
    maxdamage = self.script_damage;
  }
  blastradius = 250;
  if(isDefined(self.radius)) {
    blastradius = self.radius;
  }
  attacker = undefined;
  if(isDefined(self.damageowner)) {
    attacker = self.damageowner;
  }
  level.lastexplodingbarrel["time"] = gettime();
  level.lastexplodingbarrel["origin"] = self.origin + vectorscale((0, 0, 1), 30);
  self radiusdamage(self.origin + vectorscale((0, 0, 1), 30), blastradius, maxdamage, 1, attacker);
  if(randomint(2) == 0) {
    self setModel("p7_zm_nac_barrel_explosive_red_dmg_01");
  } else {
    self setModel("p7_zm_nac_barrel_explosive_red_dmg_02");
  }
  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    pos = physicstrace(start, start + (vectorscale((0, 0, -1), 64)));
    self.origin = pos;
    self.angles = self.angles + vectorscale((0, 0, 1), 90);
  }
  waittillframeend();
  level.barrelexplodingthisframe = 0;
}

function breakable_clip() {
  if(isDefined(self.target)) {
    targ = getent(self.target, "targetname");
    if(targ.classname == "script_brushmodel") {
      self.remove = targ;
      return;
    }
  }
  if(isDefined(self.remove)) {
    arrayremovevalue(level.breakables_clip, self.remove);
  }
}

function function_28ed3370() {
  var_e1c041e0 = getEntArray("explodable_barrel", "targetname");
  var_53c7b11b = getEntArray("explodable_barrel", "script_noteworthy");
  if(isDefined(var_e1c041e0)) {
    var_69238c0b = var_e1c041e0.size;
  }
  if(isDefined(var_53c7b11b)) {
    var_69238c0b = var_69238c0b + var_53c7b11b.size;
  }
  for(var_1d2242bc = 0; var_1d2242bc < var_69238c0b; var_1d2242bc++) {
    level waittill("hash_83cc4809");
  }
  level thread zm_audio::sndmusicsystem_playstate("undone");
}