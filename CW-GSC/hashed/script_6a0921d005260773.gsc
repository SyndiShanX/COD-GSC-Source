/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6a0921d005260773.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\cp_common\bb;
#namespace abilities;

function function_9b38e79c() {
  self endon(#"death");

  for(;;) {
    debug_arrow(self.origin, self.angles);
    waitframe(1);
  }
}

function debug_arrow(org, ang, opcolor) {
  forward = anglesToForward(ang);
  forwardfar = vectorscale(forward, 50);
  forwardclose = vectorscale(forward, 50 * 0.8);
  right = anglestoright(ang);
  leftdraw = vectorscale(right, 50 * -0.2);
  rightdraw = vectorscale(right, 50 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, 50);
  up = vectorscale(up, 50);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);

  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }

  line(org, org + forwardfar, red, 0.9);
  line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9);
  line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9);
  line(org, org + right, blue, 0.9);
  line(org, org + up, green, 0.9);
}

function debug_circle(origin, radius, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }

  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  frames = int(20 * seconds);
  circle(origin, radius, color, 0, 1, frames);
}

function function_519ae1ed(origin, entarray, max) {
  if(!isDefined(entarray)) {
    return;
  }

  if(entarray.size == 0) {
    return;
  }

  arraysortclosest(entarray, origin, 1, 0, isDefined(max) ? max : 2048);
  return entarray[0];
}

function function_f9b48b95(name) {}

function function_23c1f0b0() {
  if(!isDefined(self)) {
    return;
  }

  self function_6d4cf28e();

  foreach(ability in level.abilities.abilities) {
    if(!isDefined(ability)) {
      continue;
    }

    flag = function_f9b48b95(ability.name);

    if(isDefined(flag)) {
      self.abilities.var_b10e8797 |= flag;
    }
  }
}

function function_f204ea98(name) {
  if(!isDefined(self)) {
    return;
  }

  flag = function_f9b48b95(name);

  if(!isDefined(flag)) {
    return;
  }

  self function_6d4cf28e();
  self.abilities.var_b10e8797 |= flag;
}

function function_8fe77681(name) {
  if(!isDefined(self)) {
    return;
  }

  self function_6d4cf28e();
  flag = function_f9b48b95(name);

  if(!isDefined(flag)) {
    return;
  }

  self.abilities.var_b10e8797 &= ~flag;
}

function function_113a6123(name) {
  if(!isDefined(self)) {
    return false;
  }

  if(is_true(self.nocybercom)) {
    return true;
  }

  self function_6d4cf28e();
  flag = function_f9b48b95(name);

  if(!isDefined(flag)) {
    return false;
  }

  if(self.abilities.var_b10e8797 &flag) {
    return true;
  }

  return false;
}

function function_6d4cf28e() {
  if(!isDefined(self.abilities)) {
    self.abilities = spawnStruct();
  }

  if(!isDefined(self.abilities.var_b10e8797)) {
    self.abilities.var_b10e8797 = 0;
  }
}

function function_571f1a4b(note, animname) {
  self endon(note, #"death");
  self waittillmatch({
    #notetrack: "end"}, animname);
  self notify(note);
}

function function_196c351c(note, animname, kill = 0, attacker, weapon) {
  self notify("stopOnNotify" + note + animname);
  self endon("stopOnNotify" + note + animname);

  if(isDefined(animname)) {
    self thread function_571f1a4b("stopOnNotify" + note + animname, animname);
  }

  self waittill(note, #"death");

  if(isDefined(self) && self isinscriptedstate()) {
    self stopanimscripted(0.3);
  }

  if(isalive(self) && is_true(kill)) {
    self kill(self.origin, isDefined(attacker) ? attacker : undefined, undefined, weapon);
  }
}

function function_ee76cb20() {
  if(isDefined(self.allowdeath)) {
    if(self.allowdeath == 0) {
      return false;
    }
  }

  if(is_true(self.var_4bc8b4c4)) {
    return true;
  }

  if(isDefined(self.var_8fbb3e63)) {
    return true;
  }

  if(isDefined(self.archetype) && self.archetype == "robot" && !function_4b870e5a(self)) {
    return true;
  }

  if(isactor(self) && !self isonground()) {
    return true;
  }

  return false;
}

function islinked() {
  return isDefined(self getlinkedent());
}

function function_733a4915(context, max = 2) {
  if(!isDefined(self.abilities.variants)) {
    self.abilities.variants = [];
  }

  if(isDefined(self.abilities.variants[context])) {
    self.abilities.variants[context] = undefined;
  }

  self.abilities.variants[context] = spawnStruct();
  self.abilities.variants[context].var_20f37629 = 0;
  self.abilities.variants[context].var_67ce2ba5 = max;
}

function function_566e25f9(context) {
  return "";
}

function function_e20f02eb(origin, mins, maxs, yaw, frames, color) {
  if(!isDefined(yaw)) {
    yaw = 0;
  }

  if(!isDefined(frames)) {
    frames = 20;
  }

  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  box(origin, mins, maxs, yaw, color, 1, 0, frames);
}

function debug_sphere(origin, radius, color, alpha, timeframes) {
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  if(!isDefined(alpha)) {
    alpha = 0.1;
  }

  if(!isDefined(timeframes)) {
    timeframes = 1;
  }

  sides = int(10 * (1 + int(radius) % 100));
  sphere(origin, radius, color, alpha, 1, sides, timeframes);
}

function function_eb47c624(note, seconds) {
  self endon(note, #"death");
  wait seconds;
  self notify(note);
}

function function_2a64e6ca(note, var_9b99ed8a) {
  self endon(note, #"death");
  self waittill(var_9b99ed8a);
  self notify(note);
}

function function_edf9c875(note, ent) {
  ent endon(#"death");
  self waittill(note);

  if(isDefined(ent)) {
    ent delete();
  }
}

function getentitypose() {
  assert(isactor(self) || isPlayer(self), "<dev string:x38>");

  if(isactor(self)) {
    return self getblackboardattribute("_stance");
  }

  if(isPlayer(self)) {
    return self getstance();
  }
}

function function_650c0f8f() {
  assert(isactor(self) || isPlayer(self), "<dev string:x38>");
  stance = self getentitypose();

  if(stance == "stand") {
    return "stn";
  }

  if(stance == "crouch") {
    return "crc";
  }

  return "";
}

function debugmsg(txt) {
  println("<dev string:x62>" + txt);
}

function function_4b870e5a(entity) {
  if(is_true(entity.missinglegs)) {
    return 0;
  }

  if(is_true(entity.iscrawler)) {
    return 0;
  }

  return gibserverutils::isgibbed(entity, 384) == 0 ? 1 : 0;
}

function function_e0a4efa(slot, weapon, var_55cd789e, endnote) {
  self endon(#"death", endnote);
  self waittill(var_55cd789e);
  self gadgetdeactivate(slot, weapon);
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function function_cc83a141(eattacker, eplayer, idamage) {
  if(!isPlayer(eplayer) || !isDefined(eattacker) || !isDefined(eattacker.aitype)) {
    return idamage;
  }

  if(!isDefined(eplayer.abilities.var_69544378) || !eplayer.abilities.var_69544378) {
    return idamage;
  }

  var_32419617 = level.var_277e6832[eattacker.aitype];

  if(!isDefined(var_32419617)) {
    var_32419617 = level.var_277e6832[# "default"];
  }

  damage_scale = 1;
  distancetoplayer = distance(eattacker.origin, eplayer.origin);

  if(distancetoplayer < 750) {
    damage_scale = var_32419617.var_79b26a3f;
  } else if(distancetoplayer < 1500) {
    damage_scale = var_32419617.var_9fa71cab;
  } else {
    damage_scale = var_32419617.var_b9d1b33b;
  }

  return idamage * damage_scale;
}

function function_8107e1c2() {
  if(isDefined(self.currentweapon) && (self.currentweapon == getweapon(#"gadget_unstoppable_force") || self.currentweapon == getweapon(#"hash_583cae2af0db7ab8"))) {
    return true;
  }

  return false;
}