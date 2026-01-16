/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\battlechatter_ai.gsc
********************************************/

addtosystem(var_0) {
  self endon("death");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  if(self.chatinitialized) {
    return;
  }
  if(!isdefined(self.squad.chatinitialized) || !self.squad.chatinitialized)
    self.squad animscripts\battlechatter::init_squadbattlechatter();

  self.enemyclass = "infantry";
  self.calledout = [];

  if(isplayer(self)) {
    self.battlechatter = 0;
    self.type = "human";
    return;
  }

  if(self.type == "dog") {
    self.enemyclass = undefined;
    self.battlechatter = 0;
    return;
  }

  self.countryid = anim.countryids[self.voice];

  if(isdefined(self.script_friendname)) {
    var_1 = tolower(self.script_friendname);

    if(issubstr(var_1, "grigsby"))
      self.npcid = "grg";
    else if(issubstr(var_1, "griggs"))
      self.npcid = "grg";
    else if(issubstr(var_1, "price"))
      self.npcid = "pri";
    else if(issubstr(var_1, "gaz"))
      self.npcid = "gaz";
    else
      setnpcid();
  } else
    setnpcid();

  thread ainameandrankwaiter();
  init_aibattlechatter();
  thread aithreadthreader();
}

aithreadthreader() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = 0.5;
  wait(var_0);
  thread aigrenadedangerwaiter();
  thread aifolloworderwaiter();

  if(self.team == "allies") {
    wait(var_0);
    thread aiflankerwaiter();
    thread aidisplacewaiter();
  }

  wait(var_0);
  thread aibattlechatterloop();
}

setnpcid() {
  var_0 = anim.usedids[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for (var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count)
      var_3 = (var_2 + var_4) % var_1;
  }

  thread npcidtracker(var_3);
  self.npcid = var_0[var_3].npcid;
}

npcidtracker(var_0) {
  anim.usedids[self.voice][var_0].count++;
  self waittill("death");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  anim.usedids[self.voice][var_0].count--;
}

aibattlechatterloop() {
  self endon("death");
  self endon("removed from battleChatter");

  for (;;) {
    animscripts\battlechatter::playbattlechatter();
    wait(0.3 + randomfloat(0.2));
  }
}

ainameandrankwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for (;;) {
    self.bcname = animscripts\battlechatter::getname();
    self.bcrank = animscripts\battlechatter::getrank();
    self waittill("set name and rank");
  }
}

removefromsystem(var_0) {
  if(!isalive(self) && animscripts\battlechatter::bcsenabled()) {
    aideathfriendly();
    aideathenemy();
  }

  if(isdefined(self)) {
    self.battlechatter = 0;
    self.chatinitialized = 0;
  }

  self notify("removed from battleChatter");

  if(isdefined(self)) {
    self.chatqueue = undefined;
    self.nextsaytime = undefined;
    self.nextsaytimes = undefined;
    self.isspeaking = undefined;
    self.enemyclass = undefined;
    self.calledout = undefined;
    self.countryid = undefined;
    self.npcid = undefined;
  }
}

init_aibattlechatter() {
  self.chatqueue = [];
  self.chatqueue["threat"] = spawnstruct();
  self.chatqueue["threat"].expiretime = 0;
  self.chatqueue["threat"].priority = 0.0;
  self.chatqueue["response"] = spawnstruct();
  self.chatqueue["response"].expiretime = 0;
  self.chatqueue["response"].priority = 0.0;
  self.chatqueue["reaction"] = spawnstruct();
  self.chatqueue["reaction"].expiretime = 0;
  self.chatqueue["reaction"].priority = 0.0;
  self.chatqueue["inform"] = spawnstruct();
  self.chatqueue["inform"].expiretime = 0;
  self.chatqueue["inform"].priority = 0.0;
  self.chatqueue["order"] = spawnstruct();
  self.chatqueue["order"].expiretime = 0;
  self.chatqueue["order"].priority = 0.0;
  self.chatqueue["custom"] = spawnstruct();
  self.chatqueue["custom"].expiretime = 0;
  self.chatqueue["custom"].priority = 0.0;
  self.nextsaytime = gettime() + 50;
  self.nextsaytimes["threat"] = 0;
  self.nextsaytimes["reaction"] = 0;
  self.nextsaytimes["response"] = 0;
  self.nextsaytimes["inform"] = 0;
  self.nextsaytimes["order"] = 0;
  self.nextsaytimes["custom"] = 0;
  self.isspeaking = 0;
  self.bcs_minpriority = 0.0;

  if(isdefined(self.script_battlechatter) && !self.script_battlechatter)
    self.battlechatter = 0;
  else
    self.battlechatter = level.battlechatter[self.team];

  self.chatinitialized = 1;
}

addthreatevent(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::cansay("threat", var_0, var_2)) {
    return;
  }
  if(isdefined(var_1.calledout) && isdefined(var_1.calledout[self.squad.squadname])) {
    return;
  }
  var_3 = animscripts\battlechatter::createchatevent("threat", var_0, var_2);

  switch (var_0) {
    case "infantry":
      var_3.threat = var_1;
      break;
    case "vehicle":
      var_3.threat = var_1;
      break;
  }

  if(isdefined(var_1.squad))
    self.squad animscripts\battlechatter::updatecontact(var_1.squad.squadname, self);

  self.chatqueue["threat"] = undefined;
  self.chatqueue["threat"] = var_3;
}

addresponseevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::cansay("response", var_0, var_3, var_1)) {
    return;
  }
  if(var_2 != level.player) {
    if(isstring(var_2.npcid) && isstring(self.npcid) && var_2.npcid == self.npcid)
      return;
    else if(!isstring(var_2.npcid) && !isstring(self.npcid) && var_2.npcid == self.npcid)
      return;
  }

  var_4 = animscripts\battlechatter::createchatevent("response", var_0, var_3);

  switch (var_0) {
    case "killfirm":
      var_4.respondto = var_2;
      var_4.modifier = var_1;
      break;
    case "ack":
      var_4.respondto = var_2;
      var_4.modifier = var_1;
  }

  self.chatqueue["response"] = undefined;
  self.chatqueue["response"] = var_4;
}

addinformevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::cansay("inform", var_0, var_3, var_1)) {
    return;
  }
  var_4 = animscripts\battlechatter::createchatevent("inform", var_0, var_3);

  switch (var_0) {
    case "reloading":
      var_4.modifier = var_1;
      var_4.informto = var_2;
      break;
    default:
      var_4.modifier = var_1;
  }

  self.chatqueue["inform"] = undefined;
  self.chatqueue["inform"] = var_4;
}

addreactionevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::cansay("reaction", var_0, var_3, var_1)) {
    return;
  }
  var_4 = animscripts\battlechatter::createchatevent("reaction", var_0, var_3);

  switch (var_0) {
    case "casualty":
      var_4.reactto = var_2;
      var_4.modifier = var_1;
      break;
    case "taunt":
      var_4.reactto = var_2;
      var_4.modifier = var_1;
  }

  self.chatqueue["reaction"] = undefined;
  self.chatqueue["reaction"] = var_4;
}

addorderevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::cansay("order", var_0, var_3, var_1)) {
    return;
  }
  if(isdefined(var_2) && var_2.type == "dog") {
    return;
  }
  var_4 = animscripts\battlechatter::createchatevent("order", var_0, var_3);
  var_4.modifier = var_1;
  var_4.orderto = var_2;

  switch (var_0) {}

  self.chatqueue["order"] = undefined;
  self.chatqueue["order"] = var_4;
}

squadofficerwaiter() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.squadname);

  for (;;) {
    var_0 = undefined;

    if(self.officers.size)
      var_1 = self.officers;
    else
      var_1 = self.members;

    var_2 = [];

    for (var_3 = 0; var_3 < var_1.size; var_3++) {
      if(isalive(var_1[var_3]))
        var_2[var_2.size] = var_1[var_3];
    }

    if(var_2.size) {
      var_0 = common_scripts\utility::getclosest(level.player.origin, var_2);
      var_0 aiofficerorders();
      var_0 waittill("death");
    }

    wait 3.0;
  }
}

getthreats(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isdefined(var_0[var_2].enemyclass)) {
      continue;
    }
    if(!level.player animscripts\battlechatter::pointinfov(var_0[var_2].origin)) {
      continue;
    }
    var_0[var_2].threatid = var_1.size;
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

squadthreatwaiter() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.squadname);

  for (;;) {
    wait(randomfloatrange(0.25, 0.75));
    var_0 = getthreats(getaiarray("axis"));

    if(!var_0.size) {
      continue;
    }
    var_1 = [];

    for (var_2 = 0; var_2 < self.members.size; var_2++) {
      if(!isalive(self.members[var_2])) {
        continue;
      }
      if(!var_0.size) {
        var_0 = var_1;
        var_1 = [];
      }

      for (var_3 = 0; var_3 < var_0.size; var_3++) {
        if(!isdefined(var_0[var_3])) {
          if(var_3 == 0)
            var_0 = [];

          continue;
        }

        if(!isalive(var_0[var_3])) {
          continue;
        }
        if(!self.members[var_2] cansee(var_0[var_3])) {
          continue;
        }
        self.members[var_2] addthreatevent(var_0[var_3].enemyclass, var_0[var_3]);
        var_1[var_1.size] = var_0[var_3];
        var_0[var_3] = undefined;
        var_0[var_3] = var_0[var_0.size - 1];
        var_0[var_0.size - 1] = undefined;

        if(!isdefined(var_0[0]))
          var_0 = [];

        break;
      }

      wait 0.05;
    }
  }
}

flexiblethreatwaiter() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.squadname);

  for (;;) {
    wait 0.5;
    var_0 = filterthreats(getaiarray("axis"));

    if(!var_0.size) {
      continue;
    }
    var_1 = [];

    for (var_2 = 0; var_2 < self.members.size; var_2++) {
      if(!var_0.size) {
        var_0 = var_1;
        var_1 = [];
      }

      for (var_3 = 0; var_3 < var_0.size; var_3++) {
        if(!isdefined(var_0[var_3])) {
          if(var_3 == 0)
            var_0 = [];

          continue;
        }

        if(getdvar("bcs_threatLimitTargettedBySelf") == "on") {
          if(!isdefined(self.members[var_2].enemy) || var_0[var_3] != self.members[var_2].enemy) {
            continue;
          }
          if(gettime() > self.members[var_2].lastenemysighttime + 2000)
            continue;
        } else if(!self.members[var_2] cansee(var_0[var_3])) {
          continue;
        }
        if(getdvar("bcs_threatLimitSpeakerDist") != "off") {
          var_4 = int(getdvar("bcs_threatLimitSpeakerDist"));

          if(distance(level.player.origin, self.members[var_2].origin) > var_4)
            continue;
        }

        self.members[var_2] addthreatevent(var_0[var_3].enemyclass, var_0[var_3]);
        var_1[var_1.size] = var_0[var_3];
        var_0[var_3] = undefined;
        var_0[var_3] = var_0[var_0.size - 1];
        var_0[var_0.size - 1] = undefined;

        if(!isdefined(var_0[0]))
          var_0 = [];

        break;
      }
    }
  }
}

filterthreats(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!var_0[var_2].battlechatter) {
      continue;
    }
    if(getdvar("bcs_threatLimitTargetingPlayer") == "on") {
      if(!isdefined(var_0[var_2].enemy) || var_0[var_2].enemy != level.player)
        continue;
    }

    if(getdvar("bcs_threatLimitInPlayerFOV") == "on") {
      if(!level.player animscripts\battlechatter::pointinfov(var_0[var_2].origin))
        continue;
    }

    if(getdvar("bcs_threatLimitThreatDist") != "off") {
      var_3 = int(getdvar("bcs_threatLimitThreatDist"));

      if(distance(level.player.origin, var_0[var_2].origin) > var_3)
        continue;
    }

    if(getdvar("bcs_threatLimitInLocation") == "on") {
      if(!isdefined(var_0[var_2] animscripts\battlechatter::getlocation()) && !isdefined(var_0[var_2] animscripts\battlechatter::getlandmark()))
        continue;
    }

    var_0[var_2].threatid = var_1.size;
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

randomthreatwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  anim endon("squad deleted " + self.squadname);

  for (;;) {
    if(getdvar("bcs_enable") == "off") {
      wait 1.0;
      continue;
    }

    var_0 = gettime();

    for (var_1 = 0; var_1 < self.members.size; var_1++) {
      if(!isdefined(self.members[var_1].enemy)) {
        continue;
      }
      var_2 = self.members[var_1].enemy;

      if(!var_2.battlechatter) {
        continue;
      }
      if(!isdefined(var_2 animscripts\battlechatter::getlocation()) && !isdefined(var_2 animscripts\battlechatter::getlandmark())) {
        continue;
      }
      if(var_0 > self.members[var_1].lastenemysighttime + 2000) {
        continue;
      }
      self.squadlist[var_2.squad.squadname].calledout = 1;
      self.members[var_1] addthreatevent(var_2.enemyclass, var_2);
    }

    wait 1.0;
  }
}

aithreatwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
}

aideathfriendly() {
  var_0 = self.attacker;

  if(isdefined(self)) {
    for (var_1 = 0; var_1 < self.squad.members.size; var_1++) {
      if(isalive(self.squad.members[var_1]))
        self.squad.members[var_1] thread aideatheventthread();
    }
  }

  if(isalive(var_0) && issentient(var_0) && isdefined(var_0.squad) && var_0.battlechatter) {
    if(isdefined(var_0.calledout[var_0.squad.squadname]))
      var_0.calledout[var_0.squad.squadname] = undefined;

    for (var_1 = 0; var_1 < self.squad.members.size; var_1++) {
      if(!isdefined(var_0.enemyclass)) {
        return;
      }
      if(!isdefined(var_0 animscripts\battlechatter::getlocation()) && !isdefined(var_0 animscripts\battlechatter::getlandmark())) {
        continue;
      }
      if(gettime() > self.squad.members[var_1].lastenemysighttime + 2000) {
        continue;
      }
      self.squad.members[var_1] addthreatevent(var_0.enemyclass, var_0);
    }
  }
}

aideatheventthread() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 1.5;
  addreactionevent("casualty", "generic", self, 0.9);
}

aideathenemy() {
  var_0 = self.attacker;

  if(!isalive(var_0) || !issentient(var_0) || !isdefined(var_0.squad)) {
    return;
  }
  if(isdefined(self.calledout[var_0.squad.squadname]) && isalive(self.calledout[var_0.squad.squadname].spotter) && self.calledout[var_0.squad.squadname].spotter != var_0 && gettime() < self.calledout[var_0.squad.squadname].expiretime) {
    if(var_0 == level.player) {
      return;
    }
    return;
  } else if(var_0 != level.player)
    var_0 thread aikilleventthread();
}

aikilleventthread() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 1.5;
  addinformevent("killfirm", "infantry");
}

aiofficerorders() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isdefined(self.squad.chatinitialized))
    self.squad waittill("squad chat initialized");

  for (;;) {
    if(getdvar("bcs_enable") == "off") {
      wait 1.0;
      continue;
    }

    addsituationalorder();
    wait(randomfloatrange(3.0, 6.0));
  }
}

aigrenadedangerwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for (;;) {
    self waittill("grenade danger", var_0);

    if(getdvar("bcs_enable") == "off") {
      continue;
    }
    if(!isdefined(var_0) || var_0.model != "projectile_m67fraggrenade") {
      continue;
    }
    if(distance(var_0.origin, level.player.origin) < 512)
      addinformevent("incoming", "grenade");
  }
}

aiflankerwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for (;;) {
    level waittill("flanker", var_0);

    if(getdvar("bcs_enable") == "off") {
      continue;
    }
    if(isdefined(self.customchatevent)) {
      return;
    }
    begincustomevent();
    addthreataliasex("infantry", "generic");
    addgenericaliasex("direction", "relative", var_0);
    endcustomevent(2000);
  }
}

aiflankerorderwaiter() {}

aidisplacewaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for (;;) {
    self waittill("trigger");

    if(getdvar("bcs_enable") == "off") {
      continue;
    }
    if(gettime() < self.a.paintime + 4000) {
      continue;
    }
    addresponseevent("ack", "yes", level.player, 1.0);
  }
}

evaluatemoveevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  if(!isdefined(self.node)) {
    return;
  }
  var_1 = distance(self.origin, self.node.origin);

  if(var_1 < 250) {
    return;
  }
  if(!animscripts\battlechatter::isnodecover()) {
    return;
  }
  var_2 = animscripts\battlechatter::getclosestspeaker("order", 0);

  if(!isdefined(var_2) || distance(self.origin, var_2.origin) > 800)
    var_2 = animscripts\battlechatter::getclosestspeaker("order");

  if(isdefined(var_2) && distance(self.origin, var_2.origin) < 800 && self.combattime > 0.0) {
    anim.moveorigin.origin = self.node.origin;
    var_3 = anim.moveorigin animscripts\battlechatter::getlandmark();
    self.squad animscripts\squadmanager::updatestates();

    if(isdefined(var_3) && soundexists(var_2.countryid + "_" + var_2.npcid + "_order_cover_" + var_3.script_landmark)) {
      var_2 addorderevent("cover", var_3.script_landmark, self);
      return;
    }

    if(self.squad.squadstates["move"].isactive) {
      var_2 addorderevent("move", "forward", self);
      return;
    }

    var_2 addorderevent("cover", "generic", self);
    return;
    return;
  } else if(isdefined(var_2) && distance(self.origin, var_2.origin) < 600) {
    if(animscripts\battlechatter::isofficer())
      addorderevent("move", "follow", var_2);
    else {
      if(self.combattime < 0.0) {
        return;
      }
      addorderevent("action", "coverme", var_2);
    }
  } else if(distance(self.origin, level.player.origin) < 500) {
    if(self.combattime < 0.0) {
      return;
    }
    addorderevent("action", "coverme", level.player);
  }
}

aifolloworderwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for (;;) {
    level waittill("follow order", var_0);

    if(!animscripts\battlechatter::bcsenabled()) {
      return;
    }
    if(var_0.team != self.team) {
      continue;
    }
    wait 1.5;

    if(!isalive(var_0)) {
      continue;
    }
    if(!animscripts\battlechatter::cansay("response")) {
      continue;
    }
    if(distance(self.origin, var_0.origin) < 600)
      addresponseevent("ack", "follow", var_0);
  }
}

evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  var_0 = animscripts\battlechatter::getclosestspeaker("response");

  if(isdefined(var_0) && isdefined(var_0.a.personimmeleeing))
    var_0 = undefined;

  addinformevent("reloading", "generic");
}

evaluatemeleeevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::bcsenabled())
    return 0;

  if(!isdefined(self.enemy))
    return 0;

  return 0;
}

evaluatefiringevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  if(!isdefined(self.enemy))
    return;
}

evaluatesuppressionevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  if(!self.suppressed) {
    return;
  }
  addinformevent("suppressed", "generic");
}

evaluateattackevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  switch (var_0) {
    case "grenade":
      addinformevent("attack", "grenade");
      break;
  }
}

addsituationalorder() {
  self endon("death");
  self endon("removed from battleChatter");

  if(self.squad.squadstates["combat"].isactive)
    addsituationalcombatorder();
  else
    addsituationalidleorder();
}

addsituationalidleorder() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = self.squad;
  var_0 animscripts\squadmanager::updatestates();

  if(var_0.squadstates["move"].isactive)
    addorderevent("move", "generic");
}

addsituationalcombatorder() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = self.squad;
  var_0 animscripts\squadmanager::updatestates();

  if(var_0.squadstates["suppressed"].isactive) {
    if(var_0.squadstates["move"].isactive)
      addorderevent("cover", "generic");
    else if(var_0.squadstates["cover"].isactive)
      addorderevent("action", "grenade");
    else if(randomfloat(1) > 0.5)
      addorderevent("displace", "generic");
    else
      addorderevent("cover", "generic");
  } else {
    if(self.team == "allies")
      var_1 = getaiarray("axis");
    else
      var_1 = getaiarray("allies");

    if(var_0.squadstates["attacking"].isactive) {
      var_2 = 0;

      for (var_3 = 0; var_3 < var_1.size; var_3++) {
        if(var_1[var_3] animscripts\battlechatter::isclaimednodewindow())
          var_2 = 1;
      }

      if(var_2) {
        addorderevent("attack", "window");
        return;
      }

      addorderevent("action", "boost");
      return;
    } else if(var_0.squadstates["combat"].isactive) {
      var_2 = 0;

      for (var_3 = 0; var_3 < var_1.size; var_3++) {
        if(var_1[var_3] animscripts\battlechatter::isclaimednodewindow())
          var_2 = 1;
      }

      if(var_2)
        addorderevent("attack", "window");
      else
        addorderevent("action", "suppress");
    }
  }
}

begincustomevent() {
  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  self.customchatphrase = animscripts\battlechatter::createchatphrase();
}

addthreataliasex(var_0, var_1) {
  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  self.customchatphrase animscripts\battlechatter::addthreatalias(1.0, var_0, var_1);
}

addgenericaliasex(var_0, var_1, var_2) {
  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  self.customchatphrase animscripts\battlechatter::addgenericalias(1.0, var_0, var_1, var_2);
}

endcustomevent(var_0, var_1) {
  if(!animscripts\battlechatter::bcsenabled()) {
    return;
  }
  var_2 = animscripts\battlechatter::createchatevent("custom", "generic", 1.0);

  if(isdefined(var_0))
    var_2.expiretime = gettime() + var_0;

  if(isdefined(var_1))
    var_2.type = var_1;
  else
    var_2.type = "custom";

  self.chatqueue["custom"] = undefined;
  self.chatqueue["custom"] = var_2;
}