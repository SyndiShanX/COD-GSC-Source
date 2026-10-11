/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6270e40f05163497.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_4c543f01345a2c04;
#using script_686729055b66c6e4;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\equipment\shock_stick;
#namespace namespace_77480c5ad1d5553d;

function function_62b558b5d9acd974(taskid, params) {
  settings = function_6ed820130bc9b67f();

  if(self.entitydata.islandlocations.size == 0 || settings.numlocations == 0) {
    function_4627f093a696bf5f(1);
    return anim.failure;
  }

  self.var_730fcb57528054fb.var_4674902b1ffe1500 = ["death", "fake_death"];
  self.var_730fcb57528054fb.var_8602f084896203b4 = self.var_730fcb57528054fb.var_4674902b1ffe1500;
  self.var_730fcb57528054fb.var_8602f084896203b4[self.var_730fcb57528054fb.var_8602f084896203b4.size] = "lightning_charge_end";
  self.var_730fcb57528054fb.var_8602f084896203b4[self.var_730fcb57528054fb.var_8602f084896203b4.size] = "lightning_attack_end";
  self function_3e89eb3d8e3f1811("in_lightning_strike", 1);
  self.var_730fcb57528054fb.starttime = gettime();

  if(!isDefined(self.var_730fcb57528054fb.var_c785f8f0a57bd3a9)) {
    self.var_730fcb57528054fb.var_c785f8f0a57bd3a9 = 0;
  }

  self.var_730fcb57528054fb.state = "start";
  return anim.success;
}

function function_b2c69230002d223d(taskid, params) {
  settings = function_6ed820130bc9b67f();
  assert(self.entitydata.islandlocations.size > 0);

  switch (settings.type) {
    case #"hash_6a36c93f02d6ebea":
      self.var_730fcb57528054fb.var_604a388e9ca055ae = array_sort_with_func(self.entitydata.islandlocations, &function_2623d68bf8490daf);
      break;
    case #"hash_41c7b70dbd510829":
      self.var_730fcb57528054fb.var_604a388e9ca055ae = namespace_7d1d1a833a0da9d8::function_276a136594f3f693();

      if(self.var_730fcb57528054fb.var_604a388e9ca055ae.size < settings.numlocations) {
        randomizedarray = array_randomize(self.entitydata.islandlocations);
        index = 0;

        while(self.var_730fcb57528054fb.var_604a388e9ca055ae.size < settings.numlocations) {
          island = self.entitydata.islandlocations[index];
          index++;

          if(!arraycontains(self.var_730fcb57528054fb.var_604a388e9ca055ae, island)) {
            self.var_730fcb57528054fb.var_604a388e9ca055ae[self.var_730fcb57528054fb.var_604a388e9ca055ae.size] = island;
          }
        }
      }

      break;
    case #"hash_d950ebd1da4d0aa2":
    default:
      randomizedarray = array_randomize(self.entitydata.islandlocations);
      self.var_730fcb57528054fb.var_604a388e9ca055ae = randomizedarray;
      break;
  }

  return anim.success;
}

function function_aebbe83f2fdc628(taskid, params) {
  settings = function_6ed820130bc9b67f();

  if(self getaiblackboarddynamic("in_lightning_strike") < 2) {
    return anim.running;
  }

  if(settings.numlocations == 0) {
    function_4627f093a696bf5f(1);
    return anim.success;
  }

  switch (self.var_730fcb57528054fb.state) {
    case #"hash_c6514c88e37149bf":
      currenttime = gettime();

      if(!isDefined(self.var_730fcb57528054fb.var_1ee9d9d3881cb95e) || self.var_730fcb57528054fb.var_1ee9d9d3881cb95e + settings.var_700e02b386c08562 < currenttime) {
        self.var_730fcb57528054fb.var_1ee9d9d3881cb95e = currenttime;
        self.var_730fcb57528054fb.state = "charge";

        if(self.entitydata.phase == "phase2vul") {
          ent_flag_set("lightning_strike_ultimate_vo");
        } else {
          ent_flag_set("lightning_strike_vo");
        }
      }

      return anim.running;
    case #"hash_170b14ddee806d1":
      assert(isDefined(self.var_730fcb57528054fb.var_604a388e9ca055ae) && self.var_730fcb57528054fb.var_604a388e9ca055ae.size > 0);

      if(gettime() >= self.var_730fcb57528054fb.var_1ee9d9d3881cb95e + settings.var_8eee116faeee52e0) {
        if(!istrue(self.var_730fcb57528054fb.charging)) {
          function_e7594d6f2ba674e(self.var_730fcb57528054fb.var_604a388e9ca055ae);
          function_1721cb88b7d01455();
          timedelay = settings.chargetime * 0.25 * 0.001;
          delaythreadendon(timedelay, self.var_730fcb57528054fb.var_8602f084896203b4, &function_3dc41a713eedb5b1);
        }

        function_e60a22ee5835cfb6();
      }

      if(gettime() >= self.var_730fcb57528054fb.var_1ee9d9d3881cb95e + settings.chargetime) {
        self.var_730fcb57528054fb.charging = 0;
        self.var_730fcb57528054fb.state = "pre-strike";
        self function_3e89eb3d8e3f1811("in_lightning_strike", 3);
        thread function_9f4da47d06d52394();
      }

      return anim.running;
    case #"hash_bc43085a8adecc3b":
      if(ent_flag("strike_lightning")) {
        function_1ff41ff97941904a(1);
        self.var_730fcb57528054fb.state = "strike";
        self notify("lightning_charge_end");
      }

      function_e60a22ee5835cfb6();
      return anim.running;
    case #"hash_2ab24ece3b5380af":
      function_1c589d92d8ddd361(self.var_730fcb57528054fb.var_604a388e9ca055ae);
      return anim.running;
    case #"hash_46ae47a56ec251e2":
      self notify("lightning_charge_end");
      self notify("lightning_attack_end");
      ent_flag_clear("strike_lightning");

      if(self.var_730fcb57528054fb.var_c785f8f0a57bd3a9 >= settings.numstrikes) {
        function_4627f093a696bf5f(1);
        self.phasedata[self.entitydata.phaseindex].var_43e413695b603f76++;
      }

      return anim.success;
  }

  return anim.failure;
}

function function_4627f093a696bf5f(var_cd49914bf215b4f3) {
  self notify("lightning_charge_end");
  self notify("lightning_attack_end");
  self.var_730fcb57528054fb.var_c785f8f0a57bd3a9 = undefined;
  self.var_730fcb57528054fb.var_1ee9d9d3881cb95e = undefined;
  self.var_730fcb57528054fb.charging = undefined;
  function_359ffc721968197();
  function_1ff41ff97941904a();
  ent_flag_clear("lightning_strike_ultimate_vo");
  ent_flag_clear("lightning_strike_vo");
  ent_flag_clear("strike_lightning");

  if(istrue(var_cd49914bf215b4f3)) {
    settings = function_6ed820130bc9b67f();
    self.entitydata.var_f17581d76b08d302 = gettime() + settings.cooldown;
  }

  self.entitydata.attack_lastattacktime = gettime();
  self function_3e89eb3d8e3f1811("in_lightning_strike", 0);
  self.entitydata.entitystate = 0;
}

function private function_e7594d6f2ba674e(var_ae5c9952fc39b03e) {
  settings = function_6ed820130bc9b67f();
  var_3b9fa7959a95ea60 = 0;

  for(index = 0; index < settings.numlocations; index++) {
    island = var_ae5c9952fc39b03e[index];

    if(!isDefined(island)) {
      continue;
    }

    if(isDefined(island.var_e98ecb0e8f990265)) {
      foreach(var_e2acb53fb28f1400 in island.var_e98ecb0e8f990265) {
        delaythreadendon(0.1 * var_3b9fa7959a95ea60, self.var_730fcb57528054fb.var_8602f084896203b4, &function_78eaa48aa4a9b4b, var_e2acb53fb28f1400);
        var_3b9fa7959a95ea60++;
      }

      continue;
    }

    delaythreadendon(0.1 * var_3b9fa7959a95ea60, self.var_730fcb57528054fb.var_8602f084896203b4, &function_78eaa48aa4a9b4b, island);
    var_3b9fa7959a95ea60++;
  }

  self.var_730fcb57528054fb.charging = 1;
}

function private function_1721cb88b7d01455() {
  settings = function_6ed820130bc9b67f();

  for(index = 0; index < settings.numlocations; index++) {
    island = self.var_730fcb57528054fb.var_604a388e9ca055ae[index];

    if(!isDefined(island)) {
      continue;
    }

    if(!isDefined(island.scriptable)) {
      island.scriptable = spawnscriptable("scriptable_zombie_entity_lightning_charge", island.origin);
      island.scriptable setscriptablepartstate("lightning_charge", "charging", 0);
    }
  }

  thread function_b43e9876fb9a5704();
}

function private function_999eb63af70c36e1(part, state) {
  settings = function_6ed820130bc9b67f();

  for(index = 0; index < settings.numlocations; index++) {
    island = self.var_730fcb57528054fb.var_604a388e9ca055ae[index];

    if(!isDefined(island)) {
      continue;
    }

    if(isDefined(island.scriptable)) {
      island.scriptable setscriptablepartstate(part, state, 0);
    }
  }
}

function private function_b43e9876fb9a5704() {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("lightning_attack_end");
  self endon("lightning_charge_end");
  self endon("lightning_charge_free_scriptables");
  settings = function_6ed820130bc9b67f();
  addedtime = function_b330308e17eb473b(self.asmname, "lightning_strike_exit", "strike_lightning");

  if(!isDefined(addedtime)) {
    addedtime = 0;
  }

  while(true) {
    currenttime = gettime() - self.var_730fcb57528054fb.var_1ee9d9d3881cb95e;
    totaltime = settings.chargetime + addedtime;
    fraction = currenttime / totaltime;
    var_d1f178485ec31571 = totaltime * 0.001;
    var_dbeb08ed9aa02016 = currenttime * 0.001;
    timeleft = var_d1f178485ec31571 - var_dbeb08ed9aa02016;

    if(timeleft <= 3.1) {
      function_999eb63af70c36e1("lightning_charge", "charging_5");
      break;
    }

    wait 1;
  }
}

function private function_1ff41ff97941904a(var_e4f9026b2b11083a) {
  self notify("lightning_charge_free_scriptables");

  if(!isDefined(self.var_730fcb57528054fb) || !isDefined(self.var_730fcb57528054fb.var_604a388e9ca055ae) || self.var_730fcb57528054fb.var_604a388e9ca055ae.size <= 0) {
    return;
  }

  settings = function_6ed820130bc9b67f();

  for(index = 0; index < settings.numlocations; index++) {
    island = self.var_730fcb57528054fb.var_604a388e9ca055ae[index];

    if(!isDefined(island)) {
      continue;
    }

    if(isDefined(island.scriptable)) {
      island.scriptable setscriptablepartstate("lightning_charge", "off", 0);

      if(istrue(var_e4f9026b2b11083a)) {
        delaythreadendon(0.1, self.var_730fcb57528054fb.var_8602f084896203b4, &function_4a5e775c6690594a, island);
        continue;
      }

      island notify("scriptable_freed");
      island.scriptable freescriptable();
      island.scriptable = undefined;
    }
  }
}

function private function_4a5e775c6690594a(island) {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("lightning_attack_end");
  self endon("lightning_charge_end");

  if(!isDefined(island)) {
    return;
  }

  island endon("scriptable_freed");

  if(isDefined(island.scriptable)) {
    island.scriptable freescriptable();
    island.scriptable = undefined;
  }
}

function private function_78eaa48aa4a9b4b(island) {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("lightning_attack_end");
  self endon("lightning_charge_end");
  var_e935bc41ae8e04da = utility::spawn_model("tag_origin", island.origin);
  upvector = anglestoup(island.angles);
  testangles = vectortoangles(upvector);
  var_e935bc41ae8e04da rotateTo(testangles, 0.05);
  thread function_5ee1730c2e122134(var_e935bc41ae8e04da, "lightning_charge_end");
  chargevfx = spawnfx(getfx("entity_lightning_charge_vfx"), island.origin, upvector);

  if(isDefined(chargevfx)) {
    triggerfx(chargevfx);
    chargevfx forcenetfieldhighlod_sharedfunc(1);
    thread function_5ee1730c2e122134(chargevfx, "lightning_charge_end");
  }
}

function private function_e60a22ee5835cfb6() {
  assert(isDefined(self.var_730fcb57528054fb.var_604a388e9ca055ae) && self.var_730fcb57528054fb.var_604a388e9ca055ae.size > 0);

  foreach(player in level.players) {
    var_d02ecf5a44aceba4 = 0;

    foreach(island in self.var_730fcb57528054fb.var_604a388e9ca055ae) {
      if(distancesquared(player.origin, island.origin) <= squared(island.radius)) {
        var_d02ecf5a44aceba4 = 1;
        break;
      }
    }

    if(var_d02ecf5a44aceba4) {
      player function_3ab9164ef76940fd("zombieEntityVFX", "lightning_strike_target");
      continue;
    }

    player function_3ab9164ef76940fd("zombieEntityVFX", "off");
  }
}

function private function_359ffc721968197() {
  foreach(player in level.players) {
    player function_3ab9164ef76940fd("zombieEntityVFX", "off");
  }
}

function private function_9f4da47d06d52394() {
  self notify("Entity_LightningStrike_Notify");
  self endon("Entity_LightningStrike_Notify");
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("lightning_attack_end");
  waittill_any_timeout_1(5, "strike_lightning");
  ent_flag_set("strike_lightning");
}

function private function_1c589d92d8ddd361(var_ae5c9952fc39b03e) {
  settings = function_6ed820130bc9b67f();
  function_359ffc721968197();
  var_3b9fa7959a95ea60 = 0;

  for(index = 0; index < settings.numlocations; index++) {
    island = var_ae5c9952fc39b03e[index];

    if(!isDefined(island)) {
      continue;
    }

    if(isDefined(island.var_e98ecb0e8f990265)) {
      foreach(var_e2acb53fb28f1400 in island.var_e98ecb0e8f990265) {
        delaythreadendon(0.1 * var_3b9fa7959a95ea60, self.var_730fcb57528054fb.var_4674902b1ffe1500, &function_129c910190cc13ea, var_e2acb53fb28f1400);
      }
    } else {
      delaythreadendon(0.1 * var_3b9fa7959a95ea60, self.var_730fcb57528054fb.var_4674902b1ffe1500, &function_129c910190cc13ea, island);
    }

    delaythreadendon(0.1 * var_3b9fa7959a95ea60, self.var_730fcb57528054fb.var_4674902b1ffe1500, &function_2971ef2fb6df97f4, island);
    var_3b9fa7959a95ea60++;
  }

  self.var_730fcb57528054fb.var_c785f8f0a57bd3a9++;
  self.var_730fcb57528054fb.state = "complete";
}

function private function_129c910190cc13ea(island) {
  self endon("death");
  self endon("fake_death");
  level endon("game_ended");
  profilebeginevent(#"hash_4d468d8852c2e62e");
  lightningpos = getrandomnavpoint(island.origin, 100);

  if(!isDefined(lightningpos)) {
    lightningpos = island.origin;
  }

  upvector = anglestoup(island.angles);
  var_85d4a0106b97123b = lightningpos + upvector * 2000;
  var_d9e80a671452617f = function_3b3825d7947867dd(getfx("entity_lightning_vfx"), var_85d4a0106b97123b, island.angles, lightningpos);
  playFX(getfx("entity_lightning_impact_vfx"), lightningpos);
  var_d9e80a671452617f thread function_10e846e7342fdb9c();
  profileendevent();
}

function private function_2971ef2fb6df97f4(island) {
  self endon("death");
  self endon("fake_death");
  level endon("game_ended");
  profilebeginevent(#"hash_b506d0b247b36370");
  settings = function_6ed820130bc9b67f();

  if(function_a794fcf9545f2062()) {
    var_21fe9a8469d10e30 = getentitiesinradiusfrompartitiongrid(island.origin, island.radius, createentitytypemask(["etype_ai", "etype_player"]), [], undefined);

    foreach(ent in var_21fe9a8469d10e30) {
      if(!isDefined(ent) || !isalive(ent) || istrue(ent.inlaststand)) {
        continue;
      }

      if(isPlayer(ent)) {
        var_e14f497b26ad281d = island.origin;

        if(abs(ent.origin[2] - var_e14f497b26ad281d[2]) >= settings.var_253536622d01ef2) {
          var_e14f497b26ad281d = getgroundposition(ent.origin, 10, settings.var_253536622d01ef2);

          if(!isDefined(var_e14f497b26ad281d) || abs(ent.origin[2] - var_e14f497b26ad281d[2]) >= settings.var_253536622d01ef2) {
            continue;
          }
        }

        thread function_472845918e5d8af6(ent);
        continue;
      }

      if(isagent(ent)) {
        if(abs(ent.origin[2] - island.origin[2]) > settings.var_253536622d01ef2) {
          continue;
        }

        if(ent.team == "team_two_hundred" || isDefined(ent.var_66c1831357048c02)) {
          thread function_936e86655b174be5(ent);
        }
      }
    }
  } else {
    nearbyplayers = getplayersinradius(island.origin, island.radius);

    foreach(player in nearbyplayers) {
      if(!isDefined(player) || !isalive(player) || istrue(player.inlaststand)) {
        continue;
      }

      thread function_472845918e5d8af6(player);
    }

    nearbyzombies = getaiarrayinradius(island.origin, island.radius);

    foreach(zombie in nearbyzombies) {
      if(!isDefined(zombie) || !isalive(zombie) || zombie == self) {
        continue;
      }

      thread function_936e86655b174be5(zombie);
    }
  }

  profileendevent();
}

function private function_10e846e7342fdb9c() {
  level endon("game_ended");
  wait 1;
  self delete();
}

function private entity_lightningstrike_tickdamage(attacker, damage, ticktime, var_3a534a5beabefc87) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  attacker endon("death");
  self notify("Entity_LightningStrike_TickDamage");
  self endon("Entity_LightningStrike_TickDamage");
  currenttime = gettime();
  duration = currenttime + var_3a534a5beabefc87;

  while(duration >= gettime()) {
    self dodamage(damage, self.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC");
    wait ticktime;
  }
}

function private function_936e86655b174be5(zombie) {
  zombie endon("death");
  level endon("game_ended");
  settings = function_6ed820130bc9b67f();

  if(isai(zombie) && isDefined(zombie.var_66c1831357048c02)) {
    damage = zombie.maxhealth * 0.12;
    zombie function_5654a6509f8875ea(1);
    zombie dodamage(damage, zombie.origin, self, self, "MOD_ELEMENTAL_ELEC");
    return;
  }

  switch (settings.var_8992397197cec28a.type) {
    case #"hash_db714df2b8d2b246":
      zombie utility::ent_flag_set("plasma_death");
      zombie kill(zombie.origin, self, self, "MOD_ELEMENTAL_ELEC");
      break;
    case #"hash_6a33c20e7b932184":
      damage = zombie function_8b88258b2c064072();
      zombie function_5654a6509f8875ea(1);
      zombie dodamage(damage, zombie.origin, self, self, "MOD_ELEMENTAL_ELEC");
      break;
    case #"hash_bd41d5cc80144cb5":
      damage = zombie function_8b88258b2c064072();
      zombie thread entity_lightningstrike_tickdamage(self, damage, settings.var_8992397197cec28a.var_364c8f94aa59c799, settings.var_8992397197cec28a.var_c3d2c88493cb29b9);
      zombie function_5654a6509f8875ea(settings.var_8992397197cec28a.var_c3d2c88493cb29b9);
      break;
  }
}

function private function_5654a6509f8875ea(duration) {
  namespace_ed7c38f3847343dc::stun_ai(duration);
  self setscriptablepartstate("shockStickVfx", "vfx_start", 0);
  wait duration;

  if(isalive(self) && self getscriptablehaspart("shockStickVfx")) {
    self setscriptablepartstate("shockStickVfx", "off", 0);
  }
}

function private function_8b88258b2c064072() {
  settings = function_6ed820130bc9b67f();
  damage = settings.var_8992397197cec28a.var_ef90ab33a3185784;

  if(is_equal(self.subclass, "zombie_hellhound_pet")) {
    damage = settings.var_8992397197cec28a.var_9f0ac38c596f3dc9;
  } else if(is_equal(self.aicategory, "special")) {
    damage = settings.var_8992397197cec28a.var_94fc2dd9f615fc2d;
  } else if(is_equal(self.aicategory, "elite")) {
    damage = settings.var_8992397197cec28a.var_970a23e2ff759401;
  }

  return damage;
}

function private function_472845918e5d8af6(player) {
  self endon("death");
  self endon("fake_death");
  player endon("death_or_disconnect");
  level endon("game_ended");
  settings = function_6ed820130bc9b67f();

  switch (settings.var_8992397197cec28a.type) {
    case #"hash_db714df2b8d2b246":
      player dodamage(player.maxarmorhealth + player.maxhealth, player.origin, self, self, "MOD_ELEMENTAL_ELEC", "<explicitweaponnone>", "head");
      break;
    case #"hash_bd41d5cc80144cb5":
      damage = settings.var_8992397197cec28a.var_6ca1f1efc8215745;
      player thread entity_lightningstrike_tickdamage(self, damage, settings.var_364c8f94aa59c799, settings.var_8992397197cec28a.var_c3d2c88493cb29b9);
      player function_cec29f052c3e36b3(settings.var_8992397197cec28a.var_c3d2c88493cb29b9);
      break;
    case #"hash_6a33c20e7b932184":
      player dodamage(settings.var_8992397197cec28a.var_6ca1f1efc8215745, player.origin, self, self, "MOD_ELEMENTAL_ELEC");
      player function_cec29f052c3e36b3(1);
      break;
  }
}

function private function_cec29f052c3e36b3(duration) {
  if(!isPlayer(self)) {
    return;
  }

  scripts\mp\equipment\shock_stick::function_a9a57668997e3c85(1);

  if(istrue(self.revivingteammate)) {
    self.var_4a2f2f50a9020e2e = 1;
  }

  self setscriptablepartstate("shockStickVfx", "vfx_start", 0);
  self setscriptablepartstate("harvesterOrbSfx", "sfx_start", 0);
  gestureref = "vm_ges_shockstick_react";
  curweapon = self getcurrentweapon();

  if(curweapon != nullweapon()) {
    if(curweapon.basename == "iw9_me_fists_mp") {
      gestureref = "vm_ges_shockstick_react_fists";
    }

    while(!self isgestureplaying(gestureref)) {
      weapon = self getcurrentweapon();

      if(!isDefined(weapon)) {
        break;
      }

      self forceplaygestureviewmodel(gestureref);
      waitframe();
    }
  }

  self startforcedfire();
  scripts\mp\equipment\shock_stick::function_600c7c4c73c6a773(1);
  self setmovespeedscale(0.8);
  self setempjammed(1);
  wait duration;
  scripts\mp\equipment\shock_stick::function_a9a57668997e3c85(0);
  self stopgestureviewmodel(gestureref);
  self stopforcedfire();
  self setscriptablepartstate("shockStickVfx", "off", 0);
  self setscriptablepartstate("harvesterOrbSfx", "sfx_done", 0);
  scripts\mp\equipment\shock_stick::function_600c7c4c73c6a773(0);
  self setmovespeedscale(1);
  self setempjammed(0);
}

function function_3dc41a713eedb5b1() {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("lightning_attack_end");
  self playSound("evt_ai_entity_lightning_strike_hold_warning");
}

function private function_2623d68bf8490daf(var_a2adb76d7ea448b3, var_a2adb86d7ea44ae6) {
  return distancesquared(var_a2adb76d7ea448b3.origin, self.origin) <= distancesquared(var_a2adb86d7ea44ae6.origin, self.origin);
}

function private function_6ed820130bc9b67f() {
  return self.var_730fcb57528054fb.phase[self.entitydata.phaseindex];
}

function function_e72c887ec81b95a7() {
  scripts\mp\equipment\shock_stick::function_a9a57668997e3c85(0);
  self setscriptablepartstate("shockStickVfx", "off", 0);
  self setscriptablepartstate("harvesterOrbSfx", "sfx_done", 0);
  scripts\mp\equipment\shock_stick::function_600c7c4c73c6a773(0);
  function_3ab9164ef76940fd("zombieEntityVFX", "off");
}