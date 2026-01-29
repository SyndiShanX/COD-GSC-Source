/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1361.gsc
**************************************/

main() {
  var_0 = getEntArray("leaking", "targetname");

  if(!var_0.size) {
    return;
  }
  var_0 thread precachefx();
  var_0 thread methodsinit();
  common_scripts\utility::array_thread(var_0, ::_id_40BE);
}

_id_40BE() {
  switch (self.script_noteworthy) {
    case "barrel_oil":
      _id_40BF();
      break;
    case "barrel_acid":
      _id_40BF();
      break;
    case "barrel_sludge":
      _id_40BF();
      break;
    case "barrel_water":
      _id_40BF();
      break;
  }

  thread _id_40C3();
}

_id_40BF() {
  self.a = self.origin;
  self.up = anglestoup(self.angles);
  var_0 = anglestoup((0, 90, 0));
  self._id_1F49 = self.a + self.up * 22;
  self.a = self.a + self.up * 1.5;
  self.b = self.a + self.up * 41.4;
  self._id_1542 = 25861.7;
  self._id_40C0 = self._id_1542;
  var_1 = vectordot(self.up, var_0);
  var_2 = self.b;

  if(var_1 < 0) {
    var_2 = self.a;

  }
  var_1 = abs(1 - abs(var_1));
  self._id_40C1 = physicstrace(self._id_1F49, self._id_1F49 + (0, 0, -80))[2];
  self._id_40C2 = var_2[2] + var_1 * 14;
}

_id_40C3() {
  self setCanDamage(1);
  self endon("drained");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    var_3 = self[[level._id_40C4[var_4]]](var_3, var_4);

    if(!isDefined(var_3)) {
      continue;
    }
    thread _id_40C5(var_3);
  }
}

_id_40C5(var_0) {
  var_1 = pointonsegmentnearesttopoint(self.a, self.b, var_0);
  var_2 = undefined;

  if(var_1 == self.a) {
    var_2 = self.up * -1;
  } else if(var_1 == self.b) {
    var_2 = self.up;
  } else {
    var_2 = vectorfromlinetopoint(self.a, self.b, var_0);

  }
  var_3 = var_0[2] - self._id_40C1;

  if(var_3 < 0.02) {
    var_3 = 0;

  }
  var_4 = var_3 / (self._id_40C2 - self._id_40C1) * self._id_1542;

  if(self._id_40C0 > var_4) {
    while(self._id_40C0 > var_4) {
      playFX(level._effect["leak_interactive_leak"][self.script_noteworthy], var_0, var_2);
      self._id_40C0 = self._id_40C0 - 100;
      wait 0.1;
    }

    playFX(level._effect["leak_interactive_drain"][self.script_noteworthy], var_0, var_2);
  }

  if(self._id_40C0 / self._id_1542 <= 0.05) {
    self notify("drained");
  }
}

methodsinit() {
  level._id_40C4 = [];
  level._id_40C4["MOD_UNKNOWN"] = ::_id_40C7;
  level._id_40C4["MOD_PISTOL_BULLET"] = ::_id_40C6;
  level._id_40C4["MOD_RIFLE_BULLET"] = ::_id_40C6;
  level._id_40C4["MOD_GRENADE"] = ::_id_40C7;
  level._id_40C4["MOD_GRENADE_SPLASH"] = ::_id_40C7;
  level._id_40C4["MOD_PROJECTILE"] = ::_id_40C7;
  level._id_40C4["MOD_PROJECTILE_SPLASH"] = ::_id_40C7;
  level._id_40C4["MOD_MELEE"] = ::_id_40C8;
  level._id_40C4["MOD_HEAD_SHOT"] = ::_id_40C8;
  level._id_40C4["MOD_CRUSH"] = ::_id_40C8;
  level._id_40C4["MOD_TELEFRAG"] = ::_id_40C8;
  level._id_40C4["MOD_FALLING"] = ::_id_40C8;
  level._id_40C4["MOD_SUICIDE"] = ::_id_40C8;
  level._id_40C4["MOD_TRIGGER_HURT"] = ::_id_40C7;
  level._id_40C4["MOD_EXPLOSIVE"] = ::_id_40C7;
  level._id_40C4["MOD_IMPACT"] = ::_id_40C8;
}

_id_40C6(var_0, var_1) {
  return var_0;
}

_id_40C7(var_0, var_1) {
  var_2 = vectornormalize(vectorfromlinetopoint(self.a, self.b, var_0));
  var_0 = pointonsegmentnearesttopoint(self.a, self.b, var_0);
  return var_0 + var_2 * 4;
}

_id_40C8(var_0, var_1) {
  return undefined;
}

_id_40C9(var_0, var_1) {}

precachefx() {
  for(var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "barrel_oil") {
      continue;
    }
    level._effect["leak_interactive_leak"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_leak");
    level._effect["leak_interactive_drain"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_drain");
    break;
  }

  for(var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "barrel_acid") {
      continue;
    }
    level._effect["leak_interactive_leak"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_leak");
    level._effect["leak_interactive_drain"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_drain");
    break;
  }

  for(var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "barrel_water") {
      continue;
    }
    level._effect["leak_interactive_leak"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_leak");
    level._effect["leak_interactive_drain"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_drain");
    break;
  }

  for(var_0 = 0; var_0 < self.size; var_0++) {
    if(self[var_0].script_noteworthy != "barrel_sludge") {
      continue;
    }
    level._effect["leak_interactive_leak"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_leak");
    level._effect["leak_interactive_drain"][self[var_0].script_noteworthy] = loadfx("impacts/barrel_drain");
    break;
  }
}