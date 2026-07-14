/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\explosive_prop.gsc
*****************************************/

#using scripts\common\system;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\sp\equipment\molotov;
#using scripts\sp\player_death;
#using scripts\sp\utility;
#namespace explosive_prop;

function private autoexec __init__system__() {
  system::register(#"explosive_prop", undefined, &function_77f89db42151237c, undefined);
}

function private function_77f89db42151237c() {
  level thread function_d1bb85f1dfdf978b();
}

function private function_d1bb85f1dfdf978b() {
  utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
  scriptable::scriptable_addnotifycallback("\x91\x1f\xee\xf1#\x8cI|\"\x9b\xba\x0f\xe1\x19\xd0\x8e\x90\xd2", &function_6ccdc685f2d89573);
  scriptable::scriptable_addnotifycallback(":\x99fp\xc5\xb6\xd79\xef\xf1\xc4\x19\x81\xf7o\xf2R>\x98l", &function_cbd44dea21b65770);
  scriptable::scriptable_addnotifycallback("\xceXs\xbdcKs+\xd7\xa3,\xe6\xb6_2e\x16d", &function_150fde41d69bdc38);
  scriptable::scriptable_addnotifycallback("\vlV:/ce\xcd\xb2\xd7\xa3X\xb9[}\x8cV\vd", &function_ca04944ab5820ab6);
  scriptable::scriptable_addnotifycallback("\x1b7*\xde\xa0\x83\xcf\xd0\x7f\x13\xcd\x91\x81\xae\xe5\xb0\x88", &function_5c8192ac650f7307);
  scriptable::scriptable_addnotifycallback("\xf91\x12\x12~l\xa9q\xb1\xd4\x9a\x0e\xdb3\xa0\xfct\xcd\xaf\xe0\"\xf9\xaa", &function_ff338ef893a10af7);

  if(!isDefined(level.var_a2f1bd698c72b55a)) {
    level.var_a2f1bd698c72b55a = 3;
  }
}

function private function_6ccdc685f2d89573(instance, note, param, var_eea8295cd02cee64) {
  instance endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  instance notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

  if(isDefined(instance.script_noteworthy) && instance.script_noteworthy == "\xb7d;\x9a\x8aqxy\xe9") {
    return;
  }

  org = instance.origin;
  a_ai_enemies = getaiarrayinradius(org, 384, "?\xb1\xc0\x9a");

  foreach(ai_enemy in a_ai_enemies) {
    if(isDefined(ai_enemy) && isalive(ai_enemy)) {
      if(abs(ai_enemy.origin[2] - org[2]) > 576) {
        continue;
      }

      ai_enemy notify("f\x8d,nh\xc4\v\xb9\xb3", org, 1, 1, level.player, "O\x15\x1b\xad\x9ff", randomfloatrange(4, 6));
    }
  }

  var_c34510881b2989e2 = 1;
  var_878679c5b09a317c = 2;
  num_grenades = randomintrange(2, 4);
  var_351358cda7bcd99f = distancesquared(level.player.origin, org);
  var_5b9b27388473814 = squared(384);

  if(var_351358cda7bcd99f < var_5b9b27388473814) {
    var_c34510881b2989e2 += 3;
    var_878679c5b09a317c += 3;
    num_grenades = int(max(1, num_grenades * 0.5));
  }

  for(i = 0; i < num_grenades; i++) {
    dir = utility::flatten_vector(utility::randomvector(1));
    var_5ec45407300f037f = org + dir * randomfloat(64) + (0, 0, randomfloat(128));
    launchvelocity = var_5ec45407300f037f - org;
    n_fuse_time = randomfloatrange(var_c34510881b2989e2, var_878679c5b09a317c) + i * randomfloatrange(0.5, 1.5);
    grenade = magicgrenademanual("\r\xba?q\xff\x99t`\xb2v\xcdlB}\xd3_\x83/\x10\xe4X\x8d\xed$\xd1\xfb\n\x9e\x7fV\xf3g", org + (0, 0, 16), launchvelocity, n_fuse_time);
    waitframe();
  }
}

function private function_cbd44dea21b65770(instance, note, param, var_eea8295cd02cee64) {
  instance endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  instance notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

  if(isDefined(instance.script_noteworthy) && instance.script_noteworthy == "\xb7d;\x9a\x8aqxy\xe9") {
    return;
  }

  instance thread function_a03e1f53300cadf9();
  instance thread function_7c39e8d7c0a9b9cf(150, 350);
}

function private function_150fde41d69bdc38(instance, note, param, var_eea8295cd02cee64) {
  instance endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  instance notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

  if(isDefined(instance.script_noteworthy) && instance.script_noteworthy == "\xb7d;\x9a\x8aqxy\xe9") {
    return;
  }

  instance thread function_a03e1f53300cadf9();
  instance thread function_7c39e8d7c0a9b9cf(125, 250);
}

function private function_ca04944ab5820ab6(instance, note, param, var_eea8295cd02cee64) {
  instance endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  instance notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

  if(isDefined(instance.script_noteworthy) && instance.script_noteworthy == "\xb7d;\x9a\x8aqxy\xe9") {
    return;
  }

  instance thread function_7c39e8d7c0a9b9cf(100, 200);
}

function private function_5c8192ac650f7307(instance, note, param, var_eea8295cd02cee64) {
  instance endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  instance notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

  if(isDefined(instance.script_noteworthy) && instance.script_noteworthy == "\xb7d;\x9a\x8aqxy\xe9") {
    return;
  }

  instance thread function_7c39e8d7c0a9b9cf(100, 200);
}

function private function_ff338ef893a10af7(instance, note, param, var_eea8295cd02cee64) {
  instance endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  instance notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

  if(isDefined(instance.script_noteworthy) && instance.script_noteworthy == "\xb7d;\x9a\x8aqxy\xe9") {
    return;
  }

  instance thread function_7c39e8d7c0a9b9cf(200, 400);
}

function private function_a03e1f53300cadf9() {
  org = self.origin;
  ang = self.angles;
  dummy = utility::spawn_script_origin(org, ang);
  grenade = magicgrenade("7\x90XR\x87\xe6lZ]h\xe6\x0f`Z\xc5\xae\"\x85}", org + (0, 0, 4), org, 0, 0);
  up = anglestoup(ang);
  right = anglestoright(ang);
  angles = molotov::molotov_rebuild_angles_up_right(up, right);
  grenade notify("\x1e\xfd\xd1\xa2\a");
  dummy molotov::molotov_simulate_impact(grenade, grenade.origin, angles, undefined, (0, 0, 0), gettime(), undefined);

  if(isDefined(dummy)) {
    dummy delete();
  }
}

function private function_7c39e8d7c0a9b9cf(var_b7b3b0d3aa73f27c, var_39fc4398fb688ff1) {
  org = self.origin;
  ang = self.angles;
  var_f5a79ecbfcacd987 = squared(var_b7b3b0d3aa73f27c);
  var_625134842ad2480 = squared(var_39fc4398fb688ff1);
  thread function_b78682f4f093f444(org, var_b7b3b0d3aa73f27c, var_f5a79ecbfcacd987, var_39fc4398fb688ff1);
  thread function_c90fc60d45308d7(org, var_f5a79ecbfcacd987, var_625134842ad2480);
  thread function_f952388b358886b(org, var_f5a79ecbfcacd987);
}

function private function_b78682f4f093f444(org, var_b7b3b0d3aa73f27c, var_f5a79ecbfcacd987, var_39fc4398fb688ff1) {
  a_ai = getaiarrayinradius(org, var_39fc4398fb688ff1, "?\xb1\xc0\x9a", "\xba\xa5\x1f\xc9m\x80i", "O\x15\x1b\xad\x9ff");

  if(a_ai.size > 0) {
    foreach(ai in a_ai) {
      if(isDefined(ai) && isalive(ai)) {
        if(abs(ai.origin[2] - org[2]) > var_b7b3b0d3aa73f27c) {
          continue;
        }

        b_todeath = 0;

        if(ai function_bf2d94dfc6a76d34() || isDefined(ai.magic_bullet_shield) || isDefined(ai.team) && ai.team == "O\x15\x1b\xad\x9ff") {
          if(distancesquared(ai.origin, org) > var_f5a79ecbfcacd987) {
            continue;
          }
        } else if(distancesquared(ai.origin, org) < var_f5a79ecbfcacd987) {
          b_todeath = 1;
        }

        owner = level.player;

        if(!isDefined(ai.team) || ai.team == "O\x15\x1b\xad\x9ff" || ai.team == "\xba\xa5\x1f\xc9m\x80i") {
          owner = undefined;
        }

        molotov::molotovburnenemy(ai, b_todeath, org, owner);
      }
    }
  }
}

function private function_bf2d94dfc6a76d34() {
  if(!isDefined(self) || !isalive(self)) {
    return false;
  }

  if(istrue(self.enablehealthbar)) {
    return true;
  }

  if(issubstr(self.classname, "T\x83\x05\xac\x95K;y\x87]!O\xb6\xf18UW\v\x04\xbe") || issubstr(self.classname, "o\xab]\xf7\xc1\xc1\xe84,\xf0Q\x8dgM\xa7\xaa") || issubstr(self.classname, "P\xc1\x92\xb8\xb8\xa9\xdd\xbd\xfd\xc3\xa5E\xaaC\xdc\rswy") || issubstr(self.classname, "05\xc6\x12&\xa4\xe3\xf8t\xe4%\xb1&\x8b") || issubstr(self.classname, "m\xda\x15\xeb\xf1bS\xca\xad_Qy\x01\xc2a\x97f\x82\xd7\xb1d\x96") || issubstr(self.classname, "\x95nYm\xcb\xd7\xa3'ap\xbe\x16\x9b7\x85\xdc\xcdK\xdc") || issubstr(self.classname, "\xd8z'\b[y\xbe\x90_\x1bW\xfcY\xe9:\xf8") || issubstr(self.classname, "\xb1\x15\xa2H\x0e8sL\fRB.\x9c\x02\xb5\xf0\x80e") || issubstr(self.classname, "Rm\xa7\xa0\xb8\xd1\x12\xa6<\xfb\r%\x97P\xabQr\xd2\xe3#")) {
    return true;
  }

  return false;
}

function private function_c90fc60d45308d7(org, var_f5a79ecbfcacd987, var_625134842ad2480) {
  if(distancesquared(level.player.origin, org) < var_f5a79ecbfcacd987) {
    level.player utility_sp::do_damage(int(level.player.health * 0.5), org, undefined, undefined, "\b\x89z\xc1\xf1\xd4I\xf3", "\xb6\xbdc\xf6Gov");
    return;
  }

  if(distancesquared(level.player.origin, org) < var_625134842ad2480) {
    level.player utility_sp::do_damage(1, org, undefined, undefined, "\b\x89z\xc1\xf1\xd4I\xf3", "\xb6\xbdc\xf6Gov");
  }
}

function function_f952388b358886b(org, var_f5a79ecbfcacd987) {
  vehicles = function_848b6eca7b3e4652(org, var_f5a79ecbfcacd987);

  if(vehicles.size > 0) {
    foreach(ent in vehicles) {
      if(ent isscriptable()) {
        ent thread function_98aed4034a3121d1();
        continue;
      }

      ent thread function_51781508dd751b9();
    }
  }
}

function private function_df5379584c6b7887() {
  if(istrue(level.var_1692e52d562deb02)) {
    return;
  }

  level.var_1692e52d562deb02 = 1;
  level.var_c43f2603adaba864 = 0;
  level.var_3d7d5f39ce994690 = % "hash_587b428369a22228";
  level.player waittill("\x1e\xfd\xd1\xa2\a", attacker, cause, objweapon, movingplatform, inflictor);

  if(level.var_c43f2603adaba864 > gettime()) {
    player_death::set_custom_death_quote(level.var_3d7d5f39ce994690);
    return;
  }

  hint_string = undefined;

  if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "Z=\x96\x02\xbej\xf1 BZ\x1d\xae\x17\xfai=\x9fj\xcfy\x8by\xd8d\b\xfa\x04 \xa0") {
    hint_string = % "hash_587b428369a22228";

    if(isDefined(hint_string)) {
      player_death::set_custom_death_quote(hint_string, 1);
    }
  }
}

function private function_848b6eca7b3e4652(org, radius_sq) {
  validvehicles = [];
  scriptables = getscriptablearray("X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", #code_classname);

  if(arraycontains(scriptables, self)) {
    scriptables = arrayremove(scriptables, self);
  }

  vehicles = utility::array_combine(scriptables, getEntArray("\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e", #code_classname));

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle.model) || !isstartstr(vehicle.model, "\xcc\xcdn@\x13")) {
      continue;
    }

    distancesq = distancesquared(vehicle.origin, org);

    if(distancesq <= radius_sq) {
      validvehicles = utility::array_add(validvehicles, vehicle);
    }
  }

  return validvehicles;
}

function private function_98aed4034a3121d1() {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 1;
  cur_state = self getscriptablepartstate("\xb7\x1bs\xf8", 1);

  if(!isDefined(cur_state)) {
    states = ["\xcc\xb1a\x9c\x95\xba\a", "\x9eb\xb9N\xbc;"];

    foreach(state in states) {
      if(self getscriptableparthasstate("\xb7\x1bs\xf8", state)) {
        self setscriptablepartstate("\xb7\x1bs\xf8", state, 1);
      }

      wait 0.5;
    }
  }
}

function private function_51781508dd751b9() {
  self endon("\x1e\xfd\xd1\xa2\a");
  utility_sp::do_damage(75, self.origin, undefined, undefined, "\b\x89z\xc1\xf1\xd4I\xf3");
}