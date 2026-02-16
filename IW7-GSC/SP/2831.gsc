/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2831.gsc
*********************************************/

func_9543() {
  setdvarifuninitialized("skyambient_off", 0);
  func_9745();
  func_94E4();
}

func_9745() {
  level.var_1027E = [];
  level.var_11A24 = 0;
  if(!isDefined(level.var_10281)) {
    level.var_10281 = [];
    if(!isDefined(level.var_10281["axis"])) {
      level.var_10281["axis"] = "veh_mil_air_ca_jackal_01";
    }

    if(!isDefined(level.var_10281["allies"])) {
      level.var_10281["allies"] = "veh_mil_air_un_jackal_02";
    }
  }

  scripts\engine\utility::array_thread(getEntArray("skyambient_on", "targetname"), ::func_10285);
  scripts\engine\utility::array_thread(getEntArray("skyambient_off", "targetname"), ::func_10284);
}

func_10285() {
  self endon("entitydeleted");
  func_9746(self.target);
  for(;;) {
    self waittill("trigger");
    if(level.var_1027E[self.target].state) {
      continue;
    }

    var_0 = undefined;
    if(isDefined(self.var_EE6B)) {
      var_0 = self.var_EE6B;
    }

    if(isDefined(self.var_EF1C) && isDefined(self.var_EF1B)) {
      var_0 = [self.var_EF1C, self.var_EF1B];
    }

    var_1 = undefined;
    if(isDefined(self.var_EE11)) {
      var_1 = self.var_EE11;
    }

    func_10D23(self.target, var_0, var_1);
  }
}

func_10284() {
  self endon("entitydeleted");
  for(;;) {
    self waittill("trigger");
    if(!level.var_1027E[self.target].state) {
      continue;
    }

    var_0 = 0;
    if(func_C8ED("immediate", "")) {
      var_0 = 1;
    }

    var_1 = 0;
    if(func_C8ED("forGood", "")) {
      var_1 = 1;
    }

    thread func_1103F(self.target, var_0, var_1);
  }
}

func_10D23(var_0, var_1, var_2) {
  level endon("stop_" + var_0);
  if(getdvarint("skyambient_off")) {
    return;
  }

  func_9746(var_0);
  if(level.var_1027E[var_0].state) {
    return;
  }

  level.var_1027E[var_0].state = 1;
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = 15;
  if(isDefined(level.var_B460)) {
    var_3 = level.var_B460;
  }

  var_4 = level.var_1027E[var_0].var_108D5;
  for(;;) {
    if(isDefined(level.var_B460)) {
      var_3 = level.var_B460;
    }

    foreach(var_6 in var_4) {
      if(isDefined(var_6.cooldown) && isDefined(var_6.lastspawntime)) {
        if(gettime() - var_6.lastspawntime <= var_6.cooldown) {
          continue;
        }
      }

      var_7 = func_10283(var_6.spawners);
      if(!isDefined(var_7)) {
        continue;
      }

      if(level.var_11A24 >= var_3) {
        continue;
      }

      var_6.lastspawntime = gettime();
      var_8 = undefined;
      if(!isDefined(var_7.target)) {
        var_8 = scripts\sp\vehicle::func_13237(var_7);
      } else {
        var_8 = var_7 scripts\sp\vehicle::func_1080B();
      }

      var_8 notsolid();
      var_8 dontcastshadows();
      var_8.var_1326A = var_7;
      level.var_1027E[var_0].precachesuit = scripts\engine\utility::array_add(level.var_1027E[var_0].precachesuit, var_8);
      var_8 thread func_E02B(var_0);
      var_9 = 0;
      if(isaircraft(var_8) && !var_7 func_C8ED("no_chase", " ")) {
        var_10 = 1;
        if(level.var_11A24 >= var_3) {
          var_10 = 0;
        } else if(!var_7 func_C8ED("always_chase", " ") && !scripts\engine\utility::cointoss()) {
          var_10 = 0;
        }

        if(var_10) {
          var_9 = 1;
          var_8 thread func_48B2(var_7, undefined, var_0);
        }
      }

      if(isDefined(var_7.var_EE11) && !var_9) {
        var_11 = ["right", "left"];
        var_11 = scripts\engine\utility::array_randomize(var_11);
        var_12 = randomint(var_7.var_EE11 + 1);
        for(var_13 = 0; var_13 < var_12; var_13++) {
          var_14 = var_11[var_13];
          wait(0.1);
          var_8 thread func_4958(var_14);
        }
      }
    }

    if(isarray(var_1)) {
      wait(randomfloatrange(var_1[0], var_1[1]));
      continue;
    }

    wait(var_1);
  }
}

func_1103F(var_0, var_1, var_2) {
  if(level.var_1027E.size == 0) {
    return;
  }

  if(!level.var_1027E[var_0].state) {
    return;
  }

  level.var_1027E[var_0].state = 0;
  level notify("stop_" + var_0);
  if(isDefined(var_1) && var_1) {
    foreach(var_4 in level.var_1027E[var_0].precachesuit) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(isDefined(var_4.var_3D38)) {
        if(isDefined(var_4.var_3D38.var_B911)) {
          var_4.var_3D38.var_B911 delete();
        }

        var_4.var_3D38 delete();
      }

      if(isDefined(var_4.var_A420)) {
        foreach(var_6 in var_4.var_A420) {
          var_6 delete();
        }
      }

      var_4 delete();
    }
  }

  if(isDefined(var_2) && var_2) {
    func_40C5(var_0);
  }
}

func_40C5(var_0) {
  if(!isDefined(level.var_1027E[var_0])) {
    return;
  }

  level notify("delete_" + var_0);
  scripts\sp\utility::func_228A(getEntArray(var_0, "targetname"));
  level.var_1027E[var_0] = undefined;
}

func_10283(var_0) {
  var_1 = undefined;
  var_2 = scripts\engine\utility::array_randomize(var_0);
  foreach(var_4 in var_2) {
    if(isDefined(var_4.disabled)) {
      continue;
    }

    if(isDefined(var_4.var_C374) && isDefined(var_4.var_A9F3)) {
      if(gettime() - var_4.var_A9F3 < var_4.var_C374) {
        continue;
      }
    }

    var_1 = var_4;
    var_1.var_A9F3 = gettime();
    break;
  }

  return var_1;
}

func_10282(var_0, var_1, var_2) {
  level.var_1027E[var_0].var_108D5[var_1].cooldown = var_2 * 1000;
}

func_9746(var_0) {
  if(isDefined(level.var_1027E[var_0])) {
    return;
  }

  level.var_1027E[var_0] = spawnStruct();
  level.var_1027E[var_0].state = 0;
  level.var_1027E[var_0].spawners = [];
  level.var_1027E[var_0].precachesuit = [];
  var_1 = func_9747(var_0);
  level.var_1027E[var_0].var_108D5 = var_1;
}

func_9747(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = 0;
  var_3 = [];
  foreach(var_5 in var_1) {
    var_6 = "group_" + var_2;
    if(isDefined(var_5.groupname)) {
      var_6 = var_5.groupname;
    } else {
      var_2++;
    }

    if(!isDefined(var_3[var_6])) {
      var_3[var_6] = spawnStruct();
      var_3[var_6].spawners = [];
    }

    var_5.var_C374 = 4;
    if(isDefined(var_5.var_EE6B)) {
      var_5.var_C374 = var_5.var_EE6B;
    }

    var_5.var_C374 = var_5.var_C374 * 1000;
    var_3[var_6].spawners = scripts\engine\utility::array_add(var_3[var_6].spawners, var_5);
  }

  return var_3;
}

func_E02B(var_0) {
  level endon("delete_" + var_0);
  var_1 = 0;
  if(isaircraft(self)) {
    level.var_11A24++;
    var_1 = 1;
  }

  self waittill("death");
  level.var_1027E[var_0].precachesuit = scripts\engine\utility::array_remove(level.var_1027E[var_0].precachesuit, self);
  if(isDefined(self.var_3D38)) {
    level.var_1027E[var_0].var_3D3A = scripts\engine\utility::array_remove(level.var_1027E[var_0].var_3D3A, self);
  }

  if(var_1) {
    level.var_11A24--;
  }
}

func_5582(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    if(isspawner(var_3)) {
      var_3.disabled = 1;
    }
  }
}

func_6238(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    if(isspawner(var_3)) {
      var_3.disabled = undefined;
    }
  }
}

func_48B2(var_0, var_1, var_2) {
  wait(randomfloatrange(0.5, 1.2));
  if(!isDefined(self)) {
    return;
  }

  thread func_A147();
  var_3 = getcsplineid(var_0.target);
  var_4 = getcsplinepointposition(var_3, 0);
  var_5 = getcsplinepointtangent(var_3, 0);
  var_6 = level.var_10281["axis"];
  var_7 = "axis";
  if(var_0.script_team == "axis") {
    var_6 = level.var_10281["allies"];
    var_7 = "allies";
  }

  var_8 = spawnvehicle(var_6, var_0.target + "_chase", "jackal_un", var_4, var_5);
  var_8.script_team = var_0.script_team;
  var_8.origin = var_0.origin;
  var_8.angles = var_0.angles;
  var_8 func_8184();
  var_8 notsolid();
  var_8 dontcastshadows();
  var_8 lib_0C24::func_10A49();
  var_8 thread lib_0C24::func_517E();
  self.var_3D38 = var_8;
  if(!isDefined(level.var_1027E[var_2].var_3D3A)) {
    level.var_1027E[var_2].var_3D3A = [];
    thread func_3D39(var_2);
  }

  var_9 = level.var_1027E[var_2].var_3D3A;
  var_9[var_9.size] = self;
  level.var_1027E[var_2].var_3D3A = var_9;
  level.var_1027E[var_0.var_336].precachesuit = scripts\engine\utility::array_add(level.var_1027E[var_0.var_336].precachesuit, var_8);
  var_8 thread func_E02B(var_0.var_336);
  var_10 = func_4921(var_8.origin, var_8.angles, var_7);
  var_8.var_B921 = var_10;
  var_11 = 1000;
  var_1 = (randomint(var_11), randomint(500), randomint(var_11));
  var_10 linkto(var_8, "tag_origin", var_1, (0, 0, 0));
  var_8 thread lib_0BDC::func_A342(var_3);
  var_8 waittill("death");
  var_10 delete();
}

func_3D39(var_0) {
  level endon("stop_" + var_0);
  var_1 = cos(25);
  for(;;) {
    wait(randomfloatrange(5, 7));
    var_2 = level.var_1027E[var_0].var_3D3A;
    var_3 = undefined;
    var_4 = undefined;
    foreach(var_3 in var_2) {
      if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_3.origin, var_1)) {
        var_4 = var_3;
        break;
      }
    }

    if(!isDefined(var_4)) {
      continue;
    }

    var_4 scripts\sp\utility::func_54C6();
  }
}

func_4958(var_0) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_A420)) {
    self.var_A420 = [];
  }

  if(isaircraft(self)) {
    var_1 = func_4921(self.origin, self.angles, self.script_team);
  } else {
    var_1 = self.var_1326A scripts\sp\utility::func_10808();
  }

  self.var_A420[var_0] = var_1;
  var_2 = (0, 0, randomintrange(-500, 500));
  var_3 = randomintrange(-1000, -500);
  if(scripts\engine\utility::cointoss()) {
    var_3 = var_3 * -1;
  }

  var_4 = randomintrange(800, 1300);
  if(var_0 == "left") {
    var_4 = var_4 * -1;
  }

  var_2 = (var_3, var_4, var_2[2]);
  var_1 linkto(self, "tag_origin", var_2, (0, 0, 0));
  self waittill("death");
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_4921(var_0, var_1, var_2) {
  var_3 = level.var_10281[var_2];
  var_4 = undefined;
  if(!isDefined(level.var_1027F) || isDefined(level.var_1027F) && level.var_1027F) {
    var_4 = % jackal_vehicle_strike_state_idle;
    if(var_2 == "axis") {
      var_4 = % jackal_ca_vehicle_strike_state_idle;
    }
  }

  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_3);
  var_5 notsolid();
  var_5 dontcastshadows();
  var_5 glinton(#animtree);
  var_5.angles = var_1;
  var_5.script_team = var_2;
  var_5.var_380 = self.var_380;
  var_5 lib_0C20::func_7598(0);
  var_5 lib_0C1A::func_25C5();
  if(isDefined(var_4)) {
    var_5 setanimknob(var_4, 1, 0.2);
  }

  var_5 give_attacker_kill_rewards(%jackal_motion_idle_ai, 1, 0);
  var_5 lib_0C24::func_10A49();
  var_5 lib_0C20::func_11132();
  var_5.var_284B = 0;
  var_5.var_284C[0] = "tag_flash_left";
  var_5.var_284C[1] = "tag_flash_right";
  return var_5;
}

func_A147() {
  self endon("death");
  if(scripts\engine\utility::cointoss()) {
    return;
  }

  wait(randomfloatrange(3, 8));
  if(isDefined(self) && isalive(self)) {
    scripts\sp\utility::func_54C6();
  }
}

func_A1C2(var_0) {
  self endon("stop_firing_turrets_scripted");
  self endon("death");
  self endon("entitydeleted");
  var_0 endon("death");
  for(;;) {
    wait(randomfloatrange(2, 4));
    var_1 = gettime();
    var_2 = randomfloatrange(1, 3);
    while(gettime() - var_1 <= var_2) {
      func_B912(var_0);
      wait(0.1);
    }
  }
}

func_B912(var_0) {
  var_1 = self gettagorigin(self.var_284C[self.var_284B]);
  var_2 = var_0.origin;
  magicbullet("magic_spaceship_30mm_projectile_fake", var_1, var_2);
  self.var_284B = self.var_284B + 1 % self.var_284C.size;
}

func_94E4() {
  scripts\engine\utility::array_thread(getEntArray("aiAmbient_on", "script_noteworthy"), ::func_1A01);
}

func_1A01() {
  self endon("entitydeleted");
  for(;;) {
    self waittill("trigger");
    if(func_9B57()) {
      continue;
    }

    func_19FF();
  }
}

func_19FF(var_0) {
  var_1 = self;
  if(isDefined(var_0)) {
    var_1 = getent(var_0, "targetname");
  }

  if(var_1 func_9B57()) {
    return;
  }

  if(!isDefined(var_1.spawners)) {
    var_1.spawners = [];
    var_2 = getEntArray(var_1.target, "targetname");
    var_3 = getspawnerarray(var_1.target);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
    var_4 = 0;
    foreach(var_6 in var_2) {
      var_7 = var_6.script_noteworthy;
      if(!isDefined(var_7)) {
        var_7 = "spawner_" + var_4;
        var_4++;
      }

      var_1.spawners[var_7] = var_6;
    }
  }

  if(!isDefined(var_1.var_1B04)) {
    var_1.var_1B04 = var_1 scripts\engine\utility::getStructArray(var_1.target, "targetname");
  }

  if(!isDefined(var_1.var_C375)) {
    var_1.var_C375 = var_1 scripts\sp\utility::func_7A8F();
  }

  if(!isDefined(var_1.var_C5B7)) {
    var_1.var_C5B7 = [];
    var_9 = getEntArray("aiAmbient_on", "script_noteworthy");
    foreach(var_11 in var_9) {
      if(var_11 == var_1) {
        continue;
      }

      if(var_11.target != var_1.target) {
        continue;
      }

      var_1.var_C5B7[var_1.var_C5B7.size] = var_11;
    }
  }

  if(!isDefined(var_1.var_1E08)) {
    var_1.var_1E08 = [];
  }

  var_1.enabled = 1;
  foreach(var_11 in var_1.var_C5B7) {
    var_11.enabled = 1;
  }

  var_6 = var_1.spawner;
  var_15 = var_1.var_1B04;
  var_10 = var_1.var_C375;
  foreach(var_12 in var_15) {
    var_13 = var_12 func_489B(var_1.spawners, var_1);
    var_13 hide();
    var_1.var_1E08[var_1.var_1E08.size] = var_13;
    wait(0.05);
  }

  var_1 notify("aiAmbient_spawned");
  scripts\engine\utility::array_thread(var_10, ::func_1A00, var_1);
}

func_489B(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.script_noteworthy;
  if(isDefined(var_3) && isDefined(var_0[var_3])) {
    var_2 = var_0[var_3];
  } else {
    var_2 = scripts\engine\utility::random(var_0);
  }

  var_2.var_C1 = 1;
  var_4 = var_2 scripts\sp\utility::func_10619();
  var_4 dontinterpolate();
  if(!isai(var_4)) {
    var_4.var_6B14 = 1;
  }

  if(func_C8ED("notsolid", " ")) {
    var_4 notsolid();
  }

  if(func_C8ED("gun_remove", " ")) {
    var_4 scripts\sp\utility::func_86E4();
  }

  if(func_C8ED("friendname", " ")) {
    var_4 func_2C16();
  }

  if(func_C8ED("explo_ragdoll", " ")) {
    var_4 thread func_DC18();
  }

  if(func_C8ED("friendlyfire", " ")) {
    var_4 thread func_19FC(issubstr(var_2.classname, "civilian"), 1);
  }

  if(isDefined(self.script_sound)) {
    var_4 thread func_489C(self.script_sound, self.fgetarg, var_1);
  }

  if(isDefined(self.animation)) {
    var_4 thread func_1E09(var_1, self);
  }

  if(func_C8ED("bloodpool", " ")) {
    var_4 thread func_19FD();
  }

  return var_4;
}

func_1E09(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_0 waittill("aiAmbient_spawned");
  var_2 = var_1.animation;
  if(issubstr(self.model, "female")) {
    var_2 = func_79B6(var_2);
  }

  var_3 = 0;
  if(func_9DB6(var_2)) {
    var_3 = 1;
  }

  lib_0A1E::func_236C(self);
  if(var_3) {
    if(!isDefined(self.var_1FBB)) {
      if(isDefined(level.var_EC85["generic"][var_2])) {
        self.var_1FBB = "generic";
      }
    }

    if(!isDefined(self.angles)) {
      var_1.angles = (0, 0, 0);
    }

    thread scripts\sp\anim::func_1EC2(self, var_2, var_1.origin, var_1.angles);
  } else {
    var_1 thread scripts\sp\anim::func_1ECC(self, var_2);
  }

  self show();
}

func_79B6(var_0) {
  var_1 = self.var_1FBB;
  if(!isDefined(var_1)) {
    var_1 = "generic";
  }

  if(isDefined(level.var_EC85[var_1][var_0 + "_fem"])) {
    return var_0 + "_fem";
  }

  return var_0;
}

func_489C(var_0, var_1, var_2) {
  var_2 waittill("aiAmbient_spawned");
  scripts\engine\utility::waitframe();
  var_3 = spawn("trigger_radius", self.origin, 0, var_1, var_1);
  var_3 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "trigger");
  scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "entitydeleted");
  scripts\sp\utility::func_57D6();
  var_3 delete();
  if(isDefined(self)) {
    playworldsound(var_0, self.origin);
  }
}

func_DC18() {
  self endon("death");
  self setCanDamage(1);
  self.health = 500;
  wait(2);
  for(;;) {
    self waittill("damage", var_0, var_0, var_0, var_0, var_1);
    if(isDefined(var_1) && isexplosivedamagemod(var_1)) {
      if(isDefined(self.var_71C8)) {
        self[[self.var_71C8]]();
      }

      self giverankxp();
      return;
    }
  }
}

func_2C16() {
  scripts\sp\names::func_7B05();
  self func_8307(self.name, &"");
}

func_9DB6(var_0) {
  if(issubstr(var_0, "dead")) {
    return 1;
  }

  if(issubstr(var_0, "death")) {
    return 1;
  }

  return 0;
}

func_19FD() {
  wait(0.05);
  var_0 = spawn("trigger_radius", self.origin, 0, 512, 64);
  var_0 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "trigger");
  scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "entitydeleted");
  scripts\sp\utility::func_57D6();
  var_0 delete();
  if(isDefined(self)) {
    lib_0C60::play_blood_pool();
  }
}

func_19FC(var_0, var_1) {
  self endon("entitydeleted");
  self setCanDamage(1);
  thread scripts\sp\utility::func_7748();
  scripts\sp\utility::func_16B7(scripts\sp\damagefeedback::func_4D4C);
  if(isDefined(var_0) && var_0) {
    self.type = "civilian";
  }

  thread scripts\sp\friendlyfire::func_73B1(self);
  if(!isDefined(var_1) || !var_1) {
    return;
  }

  self waittill("death");
  self giverankxp();
}

func_1A00(var_0) {
  var_0 endon("aiAmbient_off");
  self waittill("trigger");
  var_0 func_19FE();
}

func_19FE(var_0) {
  var_1 = self;
  if(isDefined(var_0)) {
    var_1 = getent(var_0, "targetname");
  }

  if(!var_1 func_9B57()) {
    return;
  }

  var_1.enabled = 0;
  foreach(var_3 in var_1.var_1E08) {
    if(isDefined(var_3.var_3122)) {
      var_3.var_3122 delete();
    }

    var_3 delete();
  }

  var_1.var_1E08 = [];
  self notify("aiAmbient_off");
}

func_9B57() {
  if(!isDefined(self.enabled)) {
    self.enabled = 0;
  }

  if(self.enabled) {
    return 1;
  }

  return 0;
}

func_1D84() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_1 = func_39D3(var_0);
  var_2 = func_39D2();
  self.var_B8B4 = var_1;
  self.var_B8B2 = var_2;
}

func_39BC() {
  self endon("reached_end_node");
  self endon("death");
  func_1D84();
  var_0 = undefined;
  for(;;) {
    self waittill("noteworthy", var_1);
    var_2 = strtok(var_1, " ");
    foreach(var_4 in var_2) {
      switch (var_4) {
        case "start_entry":
          var_0 = scripts\engine\utility::spawn_tag_origin();
          var_0 linkto(self, "fx_entryburn_1", (0, 0, 0), (0, 0, 0));
          playFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a"), var_0, "tag_origin");
          break;

        case "stop_entry":
          stopFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a"), var_0, "tag_origin");
          var_0 delete();
          break;

        case "fire_missiles":
          self notify("stop_fire_missiles");
          var_5 = self.var_4BF7;
          var_6 = var_5 scripts\sp\utility::func_7A97();
          var_7 = func_39D3(var_6);
          foreach(var_9 in var_7) {
            thread func_3987(var_9, [1, 3], [0.25, 0.5]);
          }
          break;

        case "stop_fire_missiles":
          self notify("stop_fire_missiles");
          break;
      }
    }
  }
}

func_1D83() {
  scripts\engine\utility::waittill_either("death", "ambient_capitalship_cleanup");
  self notify("stop_fire_missiles");
  scripts\sp\utility::func_228A(self.var_B8B4);
}

func_3987(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_fire_missiles");
  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  for(;;) {
    if(isarray(var_1)) {
      var_7 = randomintrange(var_1[0], var_1[1]);
    } else {
      var_7 = var_1;
    }

    for(var_8 = 0; var_8 <= var_7; var_8++) {
      if(isarray(var_0)) {
        var_9 = scripts\engine\utility::random(var_0);
      } else {
        var_9 = var_0;
      }

      var_10 = undefined;
      if(isDefined(var_9.script_radius) && var_9.script_radius) {
        var_10 = spawnStruct();
        var_10.var_FF23 = var_9.var_FF23;
        var_10.var_FF3E = var_9.var_FF3E;
        var_10.origin = func_E45E(var_9.origin, var_9.fgetarg);
        var_9 = var_10;
      }

      func_3986(var_9, var_4, var_5, var_6);
      wait(randomfloatrange(0.45, 0.9));
    }

    wait(randomfloatrange(var_2[0], var_2[1]));
  }
}

func_3986(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  if(isDefined(var_0.var_FF23)) {
    var_4 = var_0.var_FF23;
  }

  var_5 = 1;
  if(isDefined(var_0.var_FF3E)) {
    var_5 = var_0.var_FF3E;
  }

  var_6 = undefined;
  if(isDefined(var_2)) {
    var_6 = [];
    var_6[0] = var_2;
    var_6[1] = var_3;
    var_6[2] = 5;
  }

  thread lib_0BB6::func_3989(var_0, var_1, var_6, var_4, var_5);
}

func_39B9(var_0) {
  var_1 = self.origin;
  while(isDefined(self)) {
    var_1 = self.origin;
    wait(0.05);
  }

  earthquake(0.25, 1, var_1, 5000);
  if(isDefined(var_0)) {
    playFX(scripts\engine\utility::getfx(var_0), var_1);
  }
}

func_39D2() {
  var_0 = ["l", "r"];
  var_1 = [];
  foreach(var_3 in var_0) {
    var_1[var_3] = [];
    for(var_4 = 1; var_4 < 25; var_4++) {
      var_5 = "amb_missile_" + var_3 + "_" + var_4;
      if(!scripts\sp\utility::hastag(self.model, var_5)) {
        break;
      }

      var_1[var_3][var_4] = var_5;
    }
  }

  return var_1;
}

func_39D3(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = var_3;
    var_4.var_F1 = 0;
    if(var_4 func_C8ED("direct")) {
      var_4.var_F1 = 1;
    }

    if(isDefined(var_3.script_damage)) {
      if(!int(var_3.script_damage)) {
        var_4.var_FF23 = int(var_3.script_damage);
      }
    }

    if(isDefined(var_3.script_earthquake)) {
      if(!int(var_3.script_earthquake)) {
        var_4.var_FF3E = int(var_3.script_earthquake);
      }
    }

    var_5 = var_3.script_noteworthy;
    if(!isDefined(var_1[var_5])) {
      var_1[var_5] = [];
    }

    var_1[var_5] = ::scripts\engine\utility::array_add(var_1[var_5], var_4);
  }

  return var_1;
}

func_C120(var_0, var_1) {
  if(!isDefined(self.script_noteworthy)) {
    return 0;
  }

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_noteworthy);
  if(!isDefined(var_1)) {
    if(var_2 == var_0) {
      return 1;
    }

    return 0;
  }

  var_3 = strtok(var_2, var_1);
  foreach(var_5 in var_3) {
    if(var_5 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_C8ED(var_0, var_1) {
  if(!isDefined(self.script_parameters)) {
    return 0;
  }

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_parameters);
  if(!isDefined(var_1)) {
    if(var_2 == var_0) {
      return 1;
    }

    return 0;
  }

  var_3 = strtok(var_2, var_1);
  foreach(var_5 in var_3) {
    if(var_5 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_E45E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(isDefined(var_3)) {
    var_5 = var_3 / var_1;
    var_4 = var_1 - var_1 * randomfloat(var_5);
  } else {
    var_4 = var_1 * randomfloat(1);
  }

  var_6 = randomfloat(360);
  var_7 = sin(var_6);
  var_8 = cos(var_6);
  var_9 = var_4 * var_8;
  var_10 = var_4 * var_7;
  var_11 = 0;
  if(isDefined(var_2)) {
    var_11 = randomfloatrange(var_2 * -1, var_2);
  }

  var_9 = var_9 + var_0[0];
  var_10 = var_10 + var_0[1];
  var_11 = var_11 + var_0[2];
  return (var_9, var_10, var_11);
}