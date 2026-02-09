/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\battlechatter_ai.gsc
********************************************/

_id_0AA9(var_0) {
  self endon("death");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  if(self._id_0AAB) {
    return;
  }
  if(!isDefined(self._id_0A7A._id_0AAB) || !self._id_0A7A._id_0AAB) {
    self._id_0A7A animscripts\battlechatter::_id_0AAC();
  }
  self._id_0AAD = "infantry";
  self._id_0AAE = [];

  if(isPlayer(self)) {
    self._id_0AAF = 0;
    self._id_0AB0 = 0;
    self.type = "human";
    return;
  }

  if(self.type == "dog") {
    self._id_0AAD = undefined;
    self._id_0AAF = 0;
    self._id_0AB0 = 0;
    return;
  }

  if(self.team == "neutral") {
    self._id_0AAD = undefined;
    self._id_0AAF = 0;
    self._id_0AB0 = 0;
    return;
  }

  if(_id_0AB7()) {
    if(self.team == "allies") {
      self._id_0AB1 = 0;
    } else {
      self.voice = "american";
    }
  }

  self._id_0AB4 = anim._id_0AB3[self.voice];

  if(isDefined(self._id_0AB5)) {
    var_1 = tolower(self._id_0AB5);

    if(issubstr(var_1, "price")) {
      self._id_0AB6 = "pri";
    } else if(issubstr(var_1, "mactavish") || issubstr(var_1, "soap")) {
      self._id_0AB6 = "mct";
    } else if(issubstr(var_1, "wallcroft")) {
      self._id_0AB6 = "wcf";
    } else if(issubstr(var_1, "griffin")) {
      self._id_0AB6 = "grf";
    } else if(issubstr(var_1, "grinch")) {
      self._id_0AB6 = "grn";
    } else if(issubstr(var_1, "truck")) {
      self._id_0AB6 = "trk";
    } else if(issubstr(var_1, "sandman")) {
      self._id_0AB6 = "snd";
    } else if(issubstr(var_1, "yuri")) {
      self._id_0AB6 = "yri";
    } else {
      _id_0ABA();
    }
  } else {
    _id_0ABA();
  }
  thread _id_0AC0();
  _id_0ACA();
  thread _id_0AB8();
}

_id_0AB7() {
  if(!getdvarint("bcs_forceEnglish", 0)) {
    return 0;
  }
  switch (level.script) {
    case "pmc_strike":
      return 1;
  }

  return 0;
}

_id_0AB8() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = 0.5;
  wait(var_0);
  thread _id_0B27();
  thread _id_0B30();

  if(self.team == "allies") {
    wait(var_0);
    thread _id_0B28();

    if(self._id_0AB4 == "CZ") {
      thread _id_0ABD();
    }
  } else if((self.team == "axis" || self.team == "team3") && !_id_0AB9(self._id_0AB4)) {
    thread _id_0ABD();
  }
  if(self.team == level.player.team) {
    thread _id_0B31();
  }
  wait(var_0);
  thread _id_0ABE();
}

_id_0AB9(var_0) {
  if(var_0 == "UK" || var_0 == "US" || var_0 == "NS" || var_0 == "TF" || var_0 == "SS") {
    return 1;
  }
  return 0;
}

_id_0ABA() {
  var_0 = anim._id_0ABB[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count) {
      var_3 = (var_2 + var_4) % var_1;
    }
  }

  thread _id_0ABC(var_3);
  self._id_0AB6 = var_0[var_3]._id_0AB6;
}

_id_0ABC(var_0) {
  anim._id_0ABB[self.voice][var_0].count++;
  common_scripts\utility::waittill_either("death", "removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  anim._id_0ABB[self.voice][var_0].count--;
}

_id_0ABD() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    if(distance(self.origin, level.player.origin) < 1024) {
      if(isDefined(self._id_0A7A._id_0A6A) && self._id_0A7A._id_0A6A > 1) {
        _id_0AE4("taunt", "hostileburst");
      }
    }

    wait(randomfloatrange(2, 5));
  }
}

_id_0ABE() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    animscripts\battlechatter::_id_0ABF();
    wait(0.3 + randomfloat(0.2));
  }
}

_id_0AC0() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self._id_0AC2 = animscripts\battlechatter::_id_0AC1();
    self._id_0AC4 = animscripts\battlechatter::getrank();
    self waittill("set name and rank");
  }
}

_id_0AC5(var_0) {
  if(!isalive(self) && animscripts\battlechatter::_id_0AAA()) {
    _id_0B21();
    _id_0B24();
  }

  if(isDefined(self)) {
    self._id_0AAF = 0;
    self._id_0AAB = 0;
  }

  self notify("removed from battleChatter");

  if(isDefined(self)) {
    self._id_0AC6 = undefined;
    self._id_0AC7 = undefined;
    self._id_0AC8 = undefined;
    self._id_0AC9 = undefined;
    self._id_0AAD = undefined;
    self._id_0AAE = undefined;
    self._id_0AB4 = undefined;
    self._id_0AB6 = undefined;
  }
}

_id_0ACA() {
  self._id_0AC6 = [];
  self._id_0AC6["threat"] = spawnStruct();
  self._id_0AC6["threat"]._id_0ACB = 0;
  self._id_0AC6["threat"].priority = 0.0;
  self._id_0AC6["response"] = spawnStruct();
  self._id_0AC6["response"]._id_0ACB = 0;
  self._id_0AC6["response"].priority = 0.0;
  self._id_0AC6["reaction"] = spawnStruct();
  self._id_0AC6["reaction"]._id_0ACB = 0;
  self._id_0AC6["reaction"].priority = 0.0;
  self._id_0AC6["inform"] = spawnStruct();
  self._id_0AC6["inform"]._id_0ACB = 0;
  self._id_0AC6["inform"].priority = 0.0;
  self._id_0AC6["order"] = spawnStruct();
  self._id_0AC6["order"]._id_0ACB = 0;
  self._id_0AC6["order"].priority = 0.0;
  self._id_0AC6["custom"] = spawnStruct();
  self._id_0AC6["custom"]._id_0ACB = 0;
  self._id_0AC6["custom"].priority = 0.0;
  self._id_0AC7 = gettime() + 50;
  self._id_0AC8["threat"] = 0;
  self._id_0AC8["reaction"] = 0;
  self._id_0AC8["response"] = 0;
  self._id_0AC8["inform"] = 0;
  self._id_0AC8["order"] = 0;
  self._id_0AC8["custom"] = 0;
  self._id_0AC9 = 0;
  self._id_0ACD = 0.0;
  self._id_0ACE = [];
  animscripts\battlechatter::_id_0ACF("rpg");
  animscripts\battlechatter::_id_0ACF("exposed");

  if(self.voice != "shadowcompany") {
    if(self.voice != "british" && self.voice != "pmc") {
      animscripts\battlechatter::_id_0ACF("ai_obvious");
    }
    animscripts\battlechatter::_id_0ACF("ai_contact_clock");
    animscripts\battlechatter::_id_0ACF("ai_target_clock");
    animscripts\battlechatter::_id_0ACF("ai_cardinal");
  }

  if(self.voice == "delta") {
    animscripts\battlechatter::_id_0ACF("player_distance");
    animscripts\battlechatter::_id_0ACF("player_target_clock_high");
    animscripts\battlechatter::_id_0ACF("ai_distance");
    animscripts\battlechatter::_id_0ACF("ai_target_clock_high");
  }

  if(self.team == "allies") {
    if(maps\_utility::_id_0AD1(anim._id_0AD0, self.voice)) {
      animscripts\battlechatter::_id_0ACF("player_contact_clock");
      animscripts\battlechatter::_id_0ACF("player_target_clock");
      animscripts\battlechatter::_id_0ACF("player_cardinal");

      if(self.voice != "british" && self.voice != "pmc") {
        animscripts\battlechatter::_id_0ACF("player_obvious");
      }
      animscripts\battlechatter::_id_0ACF("player_object_clock");

      if(self.voice != "french") {
        animscripts\battlechatter::_id_0ACF("player_location");
      }
    }

    if(self.voice != "french") {
      animscripts\battlechatter::_id_0ACF("ai_location");
      animscripts\battlechatter::_id_0ACF("generic_location");
    }
  }

  if(isDefined(self._id_0AB1) && !self._id_0AB1) {
    self._id_0AAF = 0;
  } else {
    self._id_0AAF = level._id_0AAF[self.team];
  }
  if(animscripts\battlechatter::_id_0AD2()) {
    self._id_0AB0 = 1;
  } else {
    self._id_0AB0 = 0;
  }
  if(level._id_0AD3) {
    maps\_utility::_id_0AD4(1);
  } else {
    maps\_utility::_id_0AD4(0);
  }
  self._id_0AAB = 1;
}

_id_0AD5(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AD6("threat", var_0, var_2)) {
    return;
  }
  if(animscripts\battlechatter::_id_0AD7(var_1) && !isPlayer(var_1)) {
    return;
  }
  var_3 = animscripts\battlechatter::_id_0AD8("threat", var_0, var_2);

  switch (var_0) {
    case "infantry":
      var_3._id_0AD9 = var_1;
      break;
  }

  if(isDefined(var_1._id_0A7A)) {
    self._id_0A7A animscripts\battlechatter::_id_0ADA(var_1._id_0A7A._id_0A66, self);
  }
  self._id_0AC6["threat"] = undefined;
  self._id_0AC6["threat"] = var_3;
}

_id_0ADB(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_0ADC(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_0ADC(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread _id_0AE1(var_2);
  var_6 = var_2 common_scripts\utility::waittill_any_return("death", "done speaking", "cancel speaking");

  if(var_6 == "cancel speaking") {
    return;
  }
  if(!isalive(var_2)) {
    return;
  }
  if(!animscripts\battlechatter::_id_0AD6("response", var_0, var_3, var_1)) {
    return;
  }
  if(!isPlayer(var_2)) {
    if(animscripts\battlechatter::_id_0ADD(var_2)) {
      return;
    }
  }

  var_7 = animscripts\battlechatter::_id_0AD8("response", var_0, var_3);

  if(isDefined(var_4)) {
    var_7._id_0ADE = var_4;
  }
  if(isDefined(var_5)) {
    var_7.location = var_5;
  }
  var_7._id_0ADF = var_2;
  var_7._id_0AE0 = var_1;
  self._id_0AC6["response"] = undefined;
  self._id_0AC6["response"] = var_7;
}

_id_0AE1(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 endon("death");
  var_0 endon("done speaking");
  var_0 endon("cancel speaking");
  wait 25;
  self notify("responseEvent_failsafe");
}

_id_0AE2(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AD6("inform", var_0, var_3, var_1)) {
    return;
  }
  var_4 = animscripts\battlechatter::_id_0AD8("inform", var_0, var_3);

  switch (var_0) {
    case "reloading":
      var_4._id_0AE0 = var_1;
      var_4._id_0AE3 = var_2;
      break;
    default:
      var_4._id_0AE0 = var_1;
  }

  self._id_0AC6["inform"] = undefined;
  self._id_0AC6["inform"] = var_4;
}

_id_0AE4(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self._id_0AC6)) {
    return;
  }
  var_4 = animscripts\battlechatter::_id_0AD8("reaction", var_0, var_3);
  var_4._id_0AE5 = var_2;
  var_4._id_0AE0 = var_1;
  self._id_0AC6["reaction"] = undefined;
  self._id_0AC6["reaction"] = var_4;
}

_id_0AE6(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AD6("order", var_0, var_3, var_1)) {
    return;
  }
  if(isDefined(var_2) && var_2.type == "dog") {
    return;
  }
  var_4 = animscripts\battlechatter::_id_0AD8("order", var_0, var_3);
  var_4._id_0AE0 = var_1;
  var_4._id_0AE7 = var_2;
  self._id_0AC6["order"] = undefined;
  self._id_0AC6["order"] = var_4;
}

_id_0AE8() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self._id_0A66);

  for(;;) {
    var_0 = undefined;

    if(self._id_0A6C.size) {
      var_1 = self._id_0A6C;
    } else {
      var_1 = self._id_0A6B;
    }
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(isalive(var_1[var_3])) {
        var_2[var_2.size] = var_1[var_3];
      }
    }

    if(var_2.size) {
      var_0 = maps\_utility::_id_0AE9(level.player.origin, var_2);
      var_0 _id_0B26();
      var_0 waittill("death");
    }

    wait 3.0;
  }
}

_id_0AEA(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2]._id_0AAD)) {
      continue;
    }
    if(!_id_0AEF(var_0[var_2])) {
      continue;
    }
    var_0[var_2]._id_0AEB = var_1.size;
    var_1[var_1.size] = var_0[var_2];
  }

  var_1 = maps\_utility::_id_0AEC(level.player.origin, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_1) {
    var_7 = var_6 animscripts\battlechatter::_id_0AED();

    if(isDefined(var_7) && !animscripts\battlechatter::_id_0AEE(var_7)) {
      var_3[var_3.size] = var_6;
      continue;
    }

    var_4[var_4.size] = var_6;
  }

  var_1 = common_scripts\utility::array_combine(var_3, var_4);
  return var_1;
}

_id_0AEF(var_0) {
  var_1 = level._id_0B1D * level._id_0B1D;

  if(distancesquared(level.player.origin, var_0.origin) > var_1) {
    return 0;
  }
  if(!level.player animscripts\battlechatter::_id_0B1E(var_0)) {
    return 0;
  }
  return 1;
}

_id_0B1F() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self._id_0A66);

  for(;;) {
    wait(randomfloatrange(0.25, 0.75));

    if(self.team == "allies") {
      var_0 = _id_0AEA(getaiarray("axis", "team3"));
    } else if(self.team == "team3") {
      var_0 = _id_0AEA(getaiarray("allies", "axis"));
    } else {
      var_0 = getaiarray("allies", "team3");
      var_0[var_0.size] = level.player;
    }

    if(!var_0.size) {
      continue;
    }
    var_1 = [];

    foreach(var_7, var_3 in self._id_0A6B) {
      if(!isalive(var_3)) {
        continue;
      }
      if(!var_0.size) {
        var_0 = var_1;
        var_1 = [];
      }

      foreach(var_6, var_5 in var_0) {
        if(!isDefined(var_5)) {
          if(var_6 == 0) {
            var_0 = [];
          }
          continue;
        }

        if(!isalive(var_5)) {
          continue;
        }
        if(!isDefined(var_5._id_0AAD)) {
          continue;
        }
        if(!var_3 cansee(var_5)) {
          if(isPlayer(var_5)) {
            continue;
          }
          if(var_5.team == level.player.team) {
            continue;
          }
          if(!maps\_utility::_id_0B20(var_5, 250)) {
            continue;
          }
        }

        var_3 _id_0AD5(var_5._id_0AAD, var_5);
        var_1[var_1.size] = var_5;
        var_0 = common_scripts\utility::array_remove(var_0, var_5);
        break;
      }

      wait 0.05;
    }
  }
}

_id_0B21() {
  var_0 = self.attacker;
  common_scripts\utility::array_thread(self._id_0A7A._id_0A6B, ::_id_0B23);

  if(isalive(var_0) && issentient(var_0) && isDefined(var_0._id_0A7A) && var_0._id_0AAF) {
    if(isDefined(var_0._id_0AAE[var_0._id_0A7A._id_0A66])) {
      var_0._id_0AAE[var_0._id_0A7A._id_0A66] = undefined;
    }
    if(!isDefined(var_0._id_0AAD)) {
      return;
    }
    if(!var_0 animscripts\battlechatter::_id_0B22()) {
      return;
    }
    foreach(var_2 in self._id_0A7A._id_0A6B) {
      if(gettime() > var_2._id_0A7F + 2000) {
        continue;
      }
      var_2 _id_0AD5(var_0._id_0AAD, var_0);
    }
  }
}

_id_0B23() {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");
  wait 1.5;
  _id_0AE4("casualty", "generic", self, 0.9);
}

_id_0B24() {
  var_0 = self.attacker;

  if(!isalive(var_0) || !issentient(var_0) || !isDefined(var_0._id_0A7A)) {
    return;
  }
  if(!isDefined(var_0._id_0AB4) || var_0._id_0AB4 != "NS") {
    return;
  }
  if(!isPlayer(var_0)) {
    var_0 thread _id_0B25();
  }
}

_id_0B25() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 1.5;
  _id_0AE2("killfirm", "generic");
}

_id_0B26() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self._id_0A7A._id_0AAB)) {
    self._id_0A7A waittill("squad chat initialized");
  }
  for(;;) {
    if(getDvar("bcs_enable", "on") == "off") {
      wait 1.0;
      continue;
    }

    _id_0B3B();
    wait(randomfloatrange(3.0, 6.0));
  }
}

_id_0B27() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("grenade danger", var_0);

    if(getDvar("bcs_enable", "on") == "off") {
      continue;
    }
    if(!isDefined(var_0) || var_0.model != "projectile_m67fraggrenade") {
      continue;
    }
    if(distance(var_0.origin, level.player.origin) < 512) {
      _id_0AE2("incoming", "grenade");
    }
  }
}

_id_0B28() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("trigger");

    if(getDvar("bcs_enable", "on") == "off") {
      continue;
    }
    if(gettime() < self.a._id_0B29 + 4000) {
      continue;
    }
    _id_0ADB("ack", "yes", level.player, 1.0);
  }
}

_id_0B2A(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  if(!isDefined(self.node)) {
    return;
  }
  var_1 = distance(self.origin, self.node.origin);

  if(var_1 < 512) {
    return;
  }
  if(!animscripts\battlechatter::_id_0B2B()) {
    return;
  }
  if(!_id_0B2E()) {
    return;
  }
  var_2 = animscripts\battlechatter::_id_0B2C(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var_2)) {
      var_2 = level.player;
    } else if(randomint(100) < anim._id_0B2D["moveEvent"]["ordertoplayer"]) {
      var_2 = level.player;
    }
  }

  if(self._id_0A80 > 0.0) {
    if(randomint(100) < anim._id_0B2D["moveEvent"]["coverme"]) {
      _id_0AE6("action", "coverme", var_2);
    } else {
      _id_0AE6("move", "combat", var_2);
    }
  } else if(_id_0B2F()) {
    _id_0AE6("move", "noncombat", var_2);
  }
}

_id_0B2E() {
  if(self._id_0AB4 == "SS") {
    return 0;
  }
  return 1;
}

_id_0B2F() {
  if(self._id_0AB4 == "US") {
    return 1;
  }
  return 0;
}

_id_0B30() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    level waittill("follow order", var_0);

    if(!animscripts\battlechatter::_id_0AAA()) {
      return;
    }
    if(var_0.team != self.team) {
      continue;
    }
    if(distance(self.origin, var_0.origin) < 600) {
      _id_0ADB("ack", "yes", var_0, 0.9);
    }
  }
}

_id_0B31() {
  self endon("death");
  self endon("removed from battleChatter");
  thread _id_0B33();

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);

    if(!animscripts\battlechatter::_id_0AAA()) {
      continue;
    }
    if(!isPlayer(var_0)) {
      continue;
    }
    if(_id_0B35(var_0, var_1)) {
      _id_0B32();
      wait 3;
    }
  }
}

_id_0B32() {
  _id_0AE4("friendlyfire", undefined, level.player, 1.0);
}

_id_0B33() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1) && isPlayer(var_1)) {
      if(_id_0B34(var_4)) {
        _id_0B32();
      }
    }
  }
}

_id_0B34(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  switch (var_0) {
    case "MOD_IMPACT":
    case "MOD_CRUSH":
    case "MOD_MELEE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
      return 0;
  }

  return 1;
}

_id_0B35(var_0, var_1) {
  var_2 = 65536;
  var_3 = 42;

  if(distancesquared(var_0.origin, self.origin) < var_2) {
    return 0;
  }
  if(var_1 > var_3) {
    return 0;
  }
  return 1;
}

_id_0B36() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  _id_0AE2("reloading", "generic");
}

_id_0B37() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return 0;
  }
  if(!isDefined(self.enemy)) {
    return 0;
  }
  return 0;
}

_id_0B38() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  if(!isDefined(self.enemy)) {
    return;
  }
}

_id_0B39() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  if(!self._id_0A9D) {
    return;
  }
  _id_0AE2("suppressed", "generic");
}

_id_0B3A(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  _id_0AE2("attack", "grenade");
}

_id_0B3B() {
  self endon("death");
  self endon("removed from battleChatter");

  if(self._id_0A7A._id_0AA0["combat"]._id_0AA2) {
    _id_0B3C();
  }
}

_id_0B3C() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = self._id_0A7A;
  var_0 animscripts\squadmanager::_id_0A99();

  if(var_0._id_0AA0["suppressed"]._id_0AA2) {
    if(var_0._id_0AA0["cover"]._id_0AA2) {
      var_1 = animscripts\battlechatter::_id_0B2C(96, 512, "response");
      _id_0AE6("action", "grenade", var_1);
    } else {
      _id_0AE6("displace", "generic");
    }
  } else if(var_0._id_0AA0["combat"]._id_0AA2) {
    if(self._id_0AB4 != "SS") {
      var_1 = animscripts\battlechatter::_id_0B2C(24, 1024, "response");
      _id_0AE6("action", "suppress", var_1);
    }
  }
}

_id_0B3D() {
  var_0 = [];
  var_0[var_0.size] = "order_move_combat";
  var_0[var_0.size] = "order_move_noncombat";
  var_0[var_0.size] = "order_action_coverme";
  var_0[var_0.size] = "inform_reloading";
  level._id_0B3E = var_0;
}

_id_0B3F(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_0B3E) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_0B40(var_0) {
  if(!isDefined(level._id_0B3E)) {
    _id_0B3D();
  }
  var_0 = tolower(var_0);
  var_1 = anim._id_0B41 + "custom battlechatter phrase '" + var_0 + "' isn't valid.look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
  var_2 = anim._id_0B41 + "AI at origin " + self.origin + "wasn't able to play custom battlechatter because his nationality is '" + self._id_0AB4 + "'.";

  if(!_id_0B3F(var_0)) {
    return 0;
  }
  var_3 = animscripts\battlechatter::_id_0B2C(24, 512, "response");
  _id_0B44();

  switch (var_0) {
    case "order_move_combat":
      if(!_id_0B2E()) {
        return 0;
      }
      animscripts\battlechatter::_id_0B43(self._id_0B42, var_3);
      _id_0B48();
      break;
    case "order_move_noncombat":
      if(!_id_0B2F()) {
        return 0;
      }
      _id_0B49();
      break;
    case "order_action_coverme":
      animscripts\battlechatter::_id_0B43(self._id_0B42, var_3);
      _id_0B46();
      break;
    case "inform_reloading":
      _id_0B4A();
      break;
    default:
      return 0;
  }

  _id_0B4E(2000);
  return 1;
}

_id_0B44() {
  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  self._id_0B42 = animscripts\battlechatter::_id_0B45();
}

_id_0B46() {
  self._id_0B42 animscripts\battlechatter::_id_0B47("action", "coverme");
}

_id_0B48() {
  self._id_0B42 animscripts\battlechatter::_id_0B47("move", "combat");
}

_id_0B49() {
  self._id_0B42 animscripts\battlechatter::_id_0B47("move", "noncombat");
}

_id_0B4A() {
  self._id_0B42 animscripts\battlechatter::_id_0B4B("reloading", "generic");
}

_id_0B4C(var_0) {
  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  self._id_0B42 animscripts\battlechatter::_id_0B4D(var_0);
}

_id_0B4E(var_0, var_1) {
  if(!animscripts\battlechatter::_id_0AAA()) {
    return;
  }
  var_2 = animscripts\battlechatter::_id_0AD8("custom", "generic", 1.0);

  if(isDefined(var_0)) {
    var_2._id_0ACB = gettime() + var_0;
  }
  if(isDefined(var_1)) {
    var_2.type = var_1;
  } else {
    var_2.type = "custom";
  }
  self._id_0AC6["custom"] = undefined;
  self._id_0AC6["custom"] = var_2;
}