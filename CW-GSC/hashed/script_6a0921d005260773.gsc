/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6a0921d005260773.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\cp_common\bb;
#namespace abilities;

function draworiginforever() {
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

function getclosestto(origin, entarray, max) {
  if(!isDefined(entarray)) {
    return;
  }

  if(entarray.size == 0) {
    return;
  }

  arraysortclosest(entarray, origin, 1, 0, isDefined(max) ? max : 2048);
  return entarray[0];
}

function cybercom_aioptoutgetflag(name) {}

function function_23c1f0b0() {
  if(!isDefined(self)) {
    return;
  }

  self cybercom_initentityfields();

  foreach(ability in level.abilities.abilities) {
    if(!isDefined(ability)) {
      continue;
    }

    flag = cybercom_aioptoutgetflag(ability.name);

    if(isDefined(flag)) {
      self.abilities.optoutflags |= flag;
    }
  }
}

function cybercom_aioptout(name) {
  if(!isDefined(self)) {
    return;
  }

  flag = cybercom_aioptoutgetflag(name);

  if(!isDefined(flag)) {
    return;
  }

  self cybercom_initentityfields();
  self.abilities.optoutflags |= flag;
}

function cybercom_aiclearoptout(name) {
  if(!isDefined(self)) {
    return;
  }

  self cybercom_initentityfields();
  flag = cybercom_aioptoutgetflag(name);

  if(!isDefined(flag)) {
    return;
  }

  self.abilities.optoutflags &= ~flag;
}

function cybercom_aicheckoptout(name) {
  if(!isDefined(self)) {
    return false;
  }

  if(is_true(self.nocybercom)) {
    return true;
  }

  self cybercom_initentityfields();
  flag = cybercom_aioptoutgetflag(name);

  if(!isDefined(flag)) {
    return false;
  }

  if(self.abilities.optoutflags &flag) {
    return true;
  }

  return false;
}

function cybercom_initentityfields() {
  if(!isDefined(self.abilities)) {
    self.abilities = spawnStruct();
  }

  if(!isDefined(self.abilities.optoutflags)) {
    self.abilities.optoutflags = 0;
  }
}

function notifymeonmatchend(note, animname) {
  self endon(note, #"death");
  self waittillmatch({
    #notetrack: "end"}, animname);
  self notify(note);
}

function stopanimscriptedonnotify(note, animname, kill = 0, attacker, weapon) {
  self notify("stopOnNotify" + note + animname);
  self endon("stopOnNotify" + note + animname);

  if(isDefined(animname)) {
    self thread notifymeonmatchend("stopOnNotify" + note + animname, animname);
  }

  self waittill(note, #"death");

  if(isDefined(self) && self isinscriptedstate()) {
    self stopanimScripted(0.3);
  }

  if(isalive(self) && is_true(kill)) {
    self kill(self.origin, isDefined(attacker) ? attacker : undefined, undefined, weapon);
  }
}

function isinstantkill() {
  if(isDefined(self.allowdeath)) {
    if(self.allowdeath == 0) {
      return false;
    }
  }

  if(is_true(self.instant_cybercom_death)) {
    return true;
  }

  if(isDefined(self.rider_info)) {
    return true;
  }

  if(isDefined(self.archetype) && self.archetype == "robot" && !hasbothlegs(self)) {
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

function seedanimationvariant(context, max = 2) {
  if(!isDefined(self.abilities.variants)) {
    self.abilities.variants = [];
  }

  if(isDefined(self.abilities.variants[context])) {
    self.abilities.variants[context] = undefined;
  }

  self.abilities.variants[context] = spawnStruct();
  self.abilities.variants[context].curvariant = 0;
  self.abilities.variants[context].maxvariant = max;
}

function getanimationvariant(context) {
  return "";
}

function debug_box(origin, mins, maxs, yaw, frames, color) {
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

function notifymeinnsec(note, seconds) {
  self endon(note, #"death");
  wait seconds;
  self notify(note);
}

function notifymeonnote(note, waitnote) {
  self endon(note, #"death");
  self waittill(waitnote);
  self notify(note);
}

function deleteentonnote(note, ent) {
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

function getanimprefixforpose() {
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

function hasbothlegs(entity) {
  if(is_true(entity.missinglegs)) {
    return 0;
  }

  if(is_true(entity.iscrawler)) {
    return 0;
  }

  return gibserverutils::isgibbed(entity, 384) == 0 ? 1 : 0;
}

function gadgetoffonnotify(slot, weapon, watchnote, endnote) {
  self endon(#"death", endnote);
  self waittill(watchnote);
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
    var_32419617 = level.var_277e6832[#"default"];
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
  if(isDefined(self.currentweapon) && (self.currentweapon == getweapon(#"gadget_unstoppable_force") || self.currentweapon == getweapon(#"gadget_unstoppable_force_upgraded"))) {
    return true;
  }

  return false;
}