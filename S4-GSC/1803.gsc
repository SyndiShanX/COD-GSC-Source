/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1803.gsc
*************************************************/

_id_1174(var_0) {
  self endon("death");
  level endon("game_ended");

  if(!_id_070A::_id_2458()) {
    return;
  }
  if(self._id_341F) {
    return;
  }
  if(!isDefined(self._id_E478)) {
    return;
  }
  if(!isDefined(self._id_E478._id_341F) || !self._id_E478._id_341F) {
    self._id_E478 _id_070A::_id_80BF();
  }

  self._id_2359._id_540D = "infantry";
  self._id_2359._id_2F62 = [];

  if(isPlayer(self)) {
    self._id_237D = 0;
    self._id_5CDD = 0;
    self.type = "human";
    return;
  }

  if(self._id_04B9 == "dog") {
    self._id_2359._id_540D = undefined;
    self._id_237D = 0;
    self._id_5CDD = 0;
    return;
  }

  if(self._id_04B9 == "juggernaut") {
    self._id_2359._id_540D = undefined;
    self._id_237D = 0;
    self._id_5CDD = 0;
    return;
  }

  if(self.team == "neutral") {
    self._id_2359._id_540D = undefined;
    self._id_237D = 0;
    self._id_5CDD = 0;
    return;
  }

  self._id_75FC = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "head"));
  self._id_CF7D = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "scripted_talking"));
  self._id_45CA = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "default_talking"));

  if(!isDefined(self._id_10691)) {
    return;
  }
  self._id_2359._id_3DA9 = anim._id_3DAA[self._id_10691];

  if(!isDefined(self._id_2359._id_3DA9)) {
    return;
  }
  _id_1D07();
  thread _id_1360();
  _id_7EBA();
  thread _id_13EA();
  thread _id_070A::_id_243C();
}

_id_7EBA() {
  self._id_2359._id_3420 = [];
  self._id_2359._id_3420["threat"] = spawnStruct();
  self._id_2359._id_3420["threat"]._id_57AC = 0;
  self._id_2359._id_3420["threat"]._id_BD27 = 0.0;
  self._id_2359._id_3420["response"] = spawnStruct();
  self._id_2359._id_3420["response"]._id_57AC = 0;
  self._id_2359._id_3420["response"]._id_BD27 = 0.0;
  self._id_2359._id_3420["reaction"] = spawnStruct();
  self._id_2359._id_3420["reaction"]._id_57AC = 0;
  self._id_2359._id_3420["reaction"]._id_BD27 = 0.0;
  self._id_2359._id_3420["inform"] = spawnStruct();
  self._id_2359._id_3420["inform"]._id_57AC = 0;
  self._id_2359._id_3420["inform"]._id_BD27 = 0.0;
  self._id_2359._id_3420["order"] = spawnStruct();
  self._id_2359._id_3420["order"]._id_57AC = 0;
  self._id_2359._id_3420["order"]._id_BD27 = 0.0;
  self._id_2359._id_3420["custom"] = spawnStruct();
  self._id_2359._id_3420["custom"]._id_57AC = 0;
  self._id_2359._id_3420["custom"]._id_BD27 = 0.0;
  self._id_2359._id_3420["stealth"] = spawnStruct();
  self._id_2359._id_3420["stealth"]._id_57AC = 0;
  self._id_2359._id_3420["stealth"]._id_BD27 = 0.0;
  self._id_2359._id_A4D0 = gettime() + 50;
  self._id_2359._id_A4D1["threat"] = 0;
  self._id_2359._id_A4D1["reaction"] = 0;
  self._id_2359._id_A4D1["response"] = 0;
  self._id_2359._id_A4D1["inform"] = 0;
  self._id_2359._id_A4D1["order"] = 0;
  self._id_2359._id_A4D1["custom"] = 0;
  self._id_2359._id_A4D1["stealth"] = 0;
  self._id_2359._id_8A4B = 0;
  self._id_2359._id_9F35 = 0.0;
  self._id_15AC = [];
  _id_108B("exposed");

  if(self.team == "allies") {
    if(scripts\engine\utility::array_contains(anim._id_B725, self._id_10691)) {
      _id_108B("player_contact_clock");
      _id_108B("player_target_clock");
      _id_108B("player_cardinal");
      _id_108B("player_obvious");
      _id_108B("player_object_clock");
      _id_108B("player_location");
      _id_108B("ai_contact_clock");
      _id_108B("ai_target_clock");
    }

    _id_108B("generic_location");
    _id_108B("ai_obvious");
    _id_108B("concat_location");
    _id_108B("player_distance");
    _id_108B("ai_distance");

    if(self._id_10691 != "fsa" && self._id_10691 != "fsafemale") {
      _id_108B("ai_location");
      _id_108B("ai_contact_clock");
      _id_108B("ai_target_clock");
      _id_108B("ai_casual_clock");
      _id_108B("player_target_clock_high");
      _id_108B("ai_target_clock_high");
    }
  } else {
    _id_108B("ai_contact_clock");
    _id_108B("ai_target_clock");
  }

  self._id_237D = 0;

  if(isDefined(self._id_CCBD) && self._id_CCBD || anim._id_2440) {
    self._id_237D = level._id_2359[self.team];
  }

  self._id_5CDD = 0;

  if(_id_070A::_id_10693() && level._id_5CDD[self.team] == 1 && self != anim.player) {
    self._id_5CDD = 1;
  } else {
    self._id_5CDD = 0;
  }

  if(level._id_5FAD) {
    scripts\cp\utility::_id_D219(1);
  } else {
    scripts\cp\utility::_id_D219(0);
  }

  self._id_341F = 1;
}

_id_108B(var_0) {
  self._id_15AC[self._id_15AC.size] = var_0;
}

_id_1360() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self._id_2438 = _id_070A::_id_6B6E();
    self._id_243F = _id_070A::getrank();
    self waittill("set name and rank");
  }
}

_id_1D07() {
  if(isDefined(self._id_CD5F)) {
    var_0 = tolower(self._id_CD5F);
    self._id_2359._id_A6D6 = undefined;

    if(issubstr(var_0, "alex")) {
      self._id_2359._id_3DA9 = "alx";
      return;
    }

    if(issubstr(var_0, "farah")) {
      self._id_2359._id_3DA9 = "far";
      return;
    }

    if(issubstr(var_0, "captain price")) {
      self._id_2359._id_3DA9 = "pri";
      return;
    }

    if(issubstr(var_0, "kyle")) {
      self._id_2359._id_3DA9 = "kyle";
      return;
    }

    if(issubstr(var_0, "hadir")) {
      self._id_2359._id_3DA9 = "had";
      return;
    }

    _id_D612();
    return;
    return;
    return;
    return;
    return;
  } else
    _id_D612();
}

_id_D612() {
  var_0 = anim._id_FE49[self._id_10691];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1]._id_011A < var_0[var_3]._id_011A) {
      var_3 = (var_2 + var_4) % var_1;
    }
  }

  thread _id_A6D7(var_3);
  self._id_2359._id_A6D6 = var_0[var_3]._id_A6D6;
}

_id_A6D7(var_0) {
  var_1 = self._id_10691;
  anim._id_FE49[var_1][var_0]._id_011A++;
  scripts\engine\utility::_id_108C5("death", "removed from battleChatter");

  if(!_id_070A::_id_2458()) {
    return;
  }
  anim._id_FE49[var_1][var_0]._id_011A--;
}

_id_1316() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    level waittill("follow order", var_0);

    if(!_id_070A::_id_2458()) {
      return;
    }
    if(!isDefined(self.team)) {
      return;
    }
    if(!isDefined(var_0)) {
      continue;
    }
    if(!isalive(var_0) || var_0.team != self.team) {
      continue;
    }
    if(distancesquared(self.origin, var_0.origin) < 360000) {
      _id_1124("ack", "affirm", var_0, 0.9);
    }
  }
}

_id_1318() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = undefined;

  for(;;) {
    self waittill("grenade danger", var_1);

    if(getdvarint("#x3c23f48a9e29249ee") == 0) {
      continue;
    }
    if(isDefined(var_1)) {
      var_0 = _id_1319(var_1);

      if(!isDefined(var_0)) {
        continue;
      }
    } else
      continue;

    _id_10C2("incoming", var_0);
  }
}

_id_1319(var_0) {
  var_1 = undefined;

  if(var_0.model == "offhand_wm_grenade_mike67") {
    var_1 = "grenade";
  }

  if(var_0.model == "emp_grenade_wm") {
    var_1 = "shock";
  }

  return var_1;
}

_id_13EA() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.team)) {
    return;
  }
  var_0 = 0.5;
  wait(var_0);
  thread _id_1318();
  thread _id_1316();

  if(self.team == "allies") {
    wait(var_0);
    thread _id_1313();
  } else if((self.team == "axis" || self.team == "team3") && !_id_8748(self._id_2359._id_3DA9)) {
    thread _id_1327();
    var_0 = 5.0;
  }

  if(isDefined(anim.player) && self.team == anim.player.team) {
    thread _id_B481();
  }

  wait(var_0);
  thread _id_130B();
}

_id_1313() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("trigger");

    if(getdvarint("#x3c23f48a9e29249ee") == 0) {
      continue;
    }
    if(gettime() < self._id_0DDF._id_ADFA + 4000) {
      continue;
    }
    _id_1124("ack", "affirm", anim.player, 1.0);
  }
}

_id_8748(var_0) {
  switch (var_0) {
    case "FSAW":
    case "SASW":
    case "USMW":
    case "FSA":
    case "USM":
    case "SAS":
      return 1;
    default:
      return 0;
  }
}

_id_1327() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 2;

  for(;;) {
    wait(randomfloatrange(2, 5));
  }
}

_id_B481() {
  self endon("death");
  self endon("removed from battleChatter");
  thread _id_B482();

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);

    if(!_id_070A::_id_2458()) {
      continue;
    }
    if(!isPlayer(var_0)) {
      if(anim._id_3DAA[self._id_10691] == "GM" && _id_070A::_id_31C0("reaction", "takingfire", 1.0)) {
        _id_111E("takingfire", undefined, var_0, 1.0);
      }

      continue;
    }
  }
}

_id_B482() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_2);

    if(isDefined(var_1) && var_1 == anim.player) {
      if(_id_42CA(var_2)) {
        _id_B480();
      }
    }
  }
}

_id_42CA(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_CRUSH":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      return 0;
  }

  return 1;
}

_id_B480() {
  _id_111E("friendlyfire", undefined, anim.player, 1.0);
}

_id_130B() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    _id_070A::_id_B367();
    wait(0.3 + randomfloat(0.2));
  }
}

_id_5674(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_2458()) {
    return;
  }
  if(!isDefined(self._id_02ED)) {
    return;
  }
  if(distancesquared(self.origin, self._id_02ED.origin) < 23040) {
    return;
  }
  if(!_id_070A::_id_8947()) {
    return;
  }
  if(!_id_A3D3()) {
    return;
  }
  var_1 = _id_070A::_id_6CF0(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var_1)) {
      var_1 = anim.player;
    } else if(randomint(100) < anim._id_56B4["moveEvent"]["ordertoplayer"]) {
      var_1 = anim.player;
    }
  }

  if(1) {
    if(randomint(100) < anim._id_56B4["moveEvent"]["coverme"]) {
      _id_1109("action", "coverme", var_1);
    } else {
      _id_1109("move", "movecombat", var_1);
    }
  } else if(_id_A3D4()) {
    if(gettime() - self._id_E72D > 3000) {
      _id_1109("move", "movenoncombat", var_1);
    }
  }
}

_id_A3D3() {
  if(isDefined(self._id_2359._id_3DA9) && self._id_2359._id_3DA9 == "SS") {
    return 0;
  }

  return 1;
}

_id_A3D4() {
  if(!isDefined(self._id_2359._id_3DA9)) {
    return 0;
  }

  switch (self._id_2359._id_3DA9) {
    case "SASW":
    case "USMW":
    case "USM":
    case "SAS":
      return 1;
    default:
      return 0;
  }
}

_id_1109(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_31C0("order", var_0, var_3)) {
    return;
  }
  var_4 = _id_070A::_id_3FAB("order", var_0, var_3);
  var_4._id_02D0 = var_1;
  var_4._id_AC65 = var_2;
  self._id_2359._id_3420["order"] = undefined;
  self._id_2359._id_3420["order"] = var_4;
}

_id_5677() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_2458()) {
    return;
  }
  _id_10C2("reloading", "generic");
}

_id_10C2(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_31C0("inform", var_0, var_2)) {
    return;
  }
  var_4 = _id_070A::_id_3FAB("inform", var_0, var_2);

  switch (var_0) {
    case "reloading":
      var_4._id_02D0 = var_1;
      break;
    case "killfirm":
      if(isDefined(var_3)) {
        var_4._id_F15D = var_3;
      }
    default:
      var_4._id_02D0 = var_1;
  }

  self._id_2359._id_3420["inform"] = undefined;
  self._id_2359._id_3420["inform"] = var_4;
}

_id_111E(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self._id_2359._id_3420)) {
    return;
  }
  if(!isDefined(anim._id_56B6) || !isDefined(anim._id_56BA)) {
    return;
  }
  var_4 = _id_070A::_id_3FAB("reaction", var_0, var_3);
  var_4._id_C099 = var_2;
  var_4._id_02D0 = var_1;
  self._id_2359._id_3420["reaction"] = undefined;
  self._id_2359._id_3420["reaction"] = var_4;
}

_id_1151(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_31C0("threat", var_0, var_2)) {
    return;
  }
  if(_id_070A::_id_F16D(var_1) && !isPlayer(var_1)) {
    return;
  }
  var_3 = _id_070A::_id_3FAB("threat", var_0, var_2);

  switch (var_0) {
    case "infantry":
      var_3._id_F13F = var_1;
      break;
    case "acquired":
      var_3._id_F13F = var_1;
      break;
  }

  if(isDefined(var_1._id_E478)) {
    self._id_E478 _id_070A::_id_FC3C(var_1._id_E478._id_E4A3, self);
  }

  self._id_2359._id_3420["threat"] = undefined;
  self._id_2359._id_3420["threat"] = var_3;
}

_id_566C(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_2458()) {
    return;
  }
  var_1 = 0;
  var_2 = "frag";

  switch (var_0) {
    case "frag":
      var_2 = "frag";
      break;
    case "grenade":
      var_2 = "grenade";
      break;
    case "emp":
      var_2 = "shock";
      break;
    case "offhandshield":
      var_2 = "shield";
      break;
    case "guns":
      var_2 = "weapon_guns";
      var_1 = 1;
      break;
    case "missile":
      var_2 = "weapon_missile";
      var_1 = 1;
      break;
    case "flare":
      var_2 = "weapon_flare";
      break;
    case "molotov":
      var_2 = "molotov";
      break;
  }

  _id_10C2("attack", var_2);

  if(var_1) {
    if(randomint(100) < 25) {
      wait(randomfloatrange(1, 2));

      if(isalive(self)) {
        thread _id_111E("movement");
      }
    }
  }
}

_id_1124(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_1125(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_6DE3(var_0, var_1) {
  var_2 = var_0.size;

  if(var_2 == 0) {
    wait(var_1);
    return var_0;
  }

  var_3 = var_1 * 20;
  var_4 = var_2 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0[var_6];

    if(!isDefined(var_7) || isDefined(var_7) && !isDefined(var_7._id_10691)) {
      continue;
    }
    if(!isDefined(var_7._id_2359._id_540D)) {
      continue;
    }
    var_5[var_5.size] = var_0[var_6];
  }

  if(var_5.size == 0) {
    wait(var_1);
    return var_5;
  }

  var_5 = _func_0204(var_5, anim.player.origin);
  var_8 = [];
  var_9 = [];
  var_10 = 0;

  foreach(var_12 in var_5) {
    if(isDefined(var_12) && _id_F167(var_12)) {
      var_13 = var_12 _id_070A::_id_6B1C();

      if(isDefined(var_13) && !_id_070A::_id_96D2(var_13)) {
        var_8[var_8.size] = var_12;
      } else {
        var_9[var_9.size] = var_12;
      }
    }

    var_10++;

    if(var_10 >= var_4) {
      waitframe();
      var_10 = 0;
    }
  }

  var_5 = [];

  foreach(var_16 in var_8) {
    var_5[var_5.size] = var_16;
  }

  foreach(var_16 in var_9) {
    var_5[var_5.size] = var_16;
  }

  return var_5;
}

_id_130F() {
  var_0 = self.attacker;
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0) || !_func_011D(var_0) && var_0 != anim.player || !isDefined(var_0._id_E478)) {
    return;
  }
  if(!isDefined(var_0._id_2359._id_3DA9)) {
    return;
  }
  switch (var_0._id_2359._id_3DA9) {
    case "FSAW":
    case "SASW":
    case "USMW":
    case "FSA":
    case "USM":
    case "SAS":
      break;
    default:
      return;
  }

  if(!isDefined(var_1)) {
    var_1 = self._id_04B9;
  }

  if(isDefined(var_1)) {
    var_0 thread _id_1329(var_1);
  }
}

_id_1311() {
  var_0 = self.attacker;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self._id_04B9) && self._id_04B9 == "seeker") {
    return;
  }
  if(isDefined(self._id_E478) && isDefined(var_0._id_E478) && self._id_E478 == var_0._id_E478) {
    return;
  }
  scripts\engine\utility::_id_1BE2(self._id_E478._id_9DB5, ::_id_1310, self);

  if(!isDefined(var_0._id_237D)) {
    return;
  }
  if(isalive(var_0) && !isPlayer(var_0) && isDefined(var_0._id_E478) && var_0._id_237D) {
    if(isDefined(var_0._id_2359._id_2F62) && isDefined(var_0._id_2359._id_2F62[var_0._id_E478._id_E4A3])) {
      var_0._id_2359._id_2F62[var_0._id_E478._id_E4A3] = undefined;
    }

    if(!isDefined(var_0._id_2359._id_540D)) {
      return;
    }
    if(!var_0 _id_070A::_id_8603()) {
      return;
    }
    foreach(var_2 in self._id_E478._id_9DB5) {
      if(var_2 == anim.player) {
        continue;
      }
      if(gettime() > var_2._id_8FCD + 2000) {
        continue;
      }
      var_2 _id_1151(var_0._id_2359._id_540D, var_0);
    }
  }
}

_id_1310(var_0) {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");

  if(self == anim.player) {
    if(isDefined(var_0) && !anim.player _id_070A::_id_2425(var_0)) {
      return;
    }
  }

  wait 1.2;
  _id_111E("casualty", "generic", var_0, 0.9);
}

_id_1329(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(var_0 == "civilian") {
    return;
  }
  wait 1.2;
  _id_10C2("killfirm", "generic", undefined, var_0);
}

_id_C4BA(var_0) {
  if(_id_070A::_id_2458()) {
    if(!isalive(self)) {
      if(isDefined(self)) {
        _id_1311();
        _id_130F();
      }
    }
  }

  if(isDefined(self)) {
    self._id_237D = 0;
    self._id_341F = 0;
    self._id_237A = 1;
  }

  self notify("removed from battleChatter");

  if(isDefined(self) && isDefined(self._id_2359)) {
    self._id_2359._id_3420 = undefined;
    self._id_2359._id_A4D0 = undefined;
    self._id_2359._id_A4D1 = undefined;
    self._id_2359._id_8A4B = undefined;
    self._id_2359._id_540D = undefined;
    self._id_2359._id_2F62 = undefined;
    self._id_2359._id_3DA9 = undefined;
    self._id_2359._id_A6D6 = undefined;
  }
}

_id_F167(var_0) {
  if(distancesquared(anim.player.origin, var_0.origin) > level._id_244A) {
    return 0;
  }

  if(isDefined(self.team)) {
    return 1;
  }

  if(self.team != "allies" && !anim.player _id_070A::_id_54ED(var_0)) {
    return 0;
  }

  return 1;
}

_id_E4B1() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self._id_E4A3);

  for(;;) {
    while(!isDefined(anim._id_2440) || !anim._id_2440) {
      waitframe();
    }

    while(anim._id_2440) {
      if(self.team == "allies") {
        var_0 = _id_6DE3(_func_0070("axis"), 0.5);
      } else if(self.team == "team3") {
        var_0 = _id_6DE3(_func_0070("allies", "axis"), 0.5);
      } else {
        waitframe();
        var_0 = _func_0070("allies");
        var_0[var_0.size] = anim.player;
      }

      if(!var_0.size) {
        wait 0.1;
        continue;
      }

      var_1 = [];

      foreach(var_11, var_3 in self._id_9DB5) {
        if(!isalive(var_3)) {
          continue;
        }
        while(isalive(var_3) && var_3.team == "axis" && isDefined(var_3._id_9098) && gettime() - var_3._id_9098 < 1000) {
          waitframe();
        }

        if(!var_0.size) {
          var_0 = var_1;
          var_1 = [];
        }

        foreach(var_10, var_5 in var_0) {
          if(!isDefined(var_5)) {
            if(var_10 == 0) {
              var_0 = [];
            }

            continue;
          }

          if(!isalive(var_5)) {
            continue;
          }
          if(!var_3 _id_070A::_id_2425(var_5)) {
            if(!anim.player _id_070A::_id_2425(var_5)) {
              continue;
            }
          }

          if(isDefined(var_3._id_2C5E) && isDefined(var_3._id_2C5E._id_BE34)) {
            var_3 _id_111E("danger", undefined, var_3._id_2C5E._id_BE34);
          } else {
            var_3 _id_1151("infantry", var_5);
          }

          var_1[var_1.size] = var_5;
          var_6 = [];

          foreach(var_8 in var_0) {
            if(var_8 != var_5) {
              var_6[var_6.size] = var_8;
            }
          }

          var_0 = var_6;
          break;
        }

        waitframe();
      }

      waitframe();
    }
  }
}

_id_113C(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!_id_070A::_id_31C0("stealth", var_0, var_2)) {
    return 0;
  }

  if(anim._id_56BA["stealth"][var_0] < self._id_2359._id_3420["stealth"]._id_BD27) {
    return 0;
  }

  var_4 = _id_070A::_id_3FAB("stealth", var_0, var_2);

  if(isDefined(var_3)) {
    var_4._id_96CF = var_3.origin;
  }

  var_4._id_02D0 = var_1;
  self._id_2359._id_3420["stealth"] = undefined;
  self._id_2359._id_3420["stealth"] = var_4;
  return 1;
}

_id_1125(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread _id_C6D0(var_2);
  var_6 = var_2 scripts\engine\utility::_id_10898("death", "done speaking", "cancel speaking");

  if(var_6 == "cancel speaking") {
    return;
  }
  if(!isalive(var_2)) {
    return;
  }
  if(!_id_070A::_id_31C0("response", var_0, var_3)) {
    return;
  }
  if(!isPlayer(var_2)) {
    if(_id_070A::_id_8AD1(var_2)) {
      return;
    }
  }

  var_7 = _id_070A::_id_3FAB("response", var_0, var_3);

  if(isDefined(var_4)) {
    var_7._id_C560 = var_4;
  }

  if(isDefined(var_5)) {
    var_7._id_96CF = var_5;
  }

  var_7._id_C6CD = var_2;
  var_7._id_02D0 = var_1;
  self._id_2359._id_3420["response"] = undefined;
  self._id_2359._id_3420["response"] = var_7;
}

_id_C6D0(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 endon("death");
  var_0 endon("done speaking");
  var_0 endon("cancel speaking");
  wait 25;
  self notify("responseEvent_failsafe");
}