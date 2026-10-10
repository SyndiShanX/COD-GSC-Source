/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3eb75397640bf7c6.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_38c251115537f16e;
#using script_3b78d23dad7ec5be;
#using script_3badb8914eb5ac16;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\bt_util;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\shock_stick;
#namespace namespace_a1e8f903f5a909b5;

function autoexec function_f910d7995a4f798c() {
  level._effect["mangler_emp_blast"] = loadfx("vfx/iw9/fieldupgrades/vfx_electric_discharge_blast.vfx");
  callback::add("on_zombie_mangler_emp_spawned", &function_9954ad81428762a0);
  callback::add("on_zombie_mangler_hvt_emp_spawned", &function_9954ad81428762a0);
  utility::registersharedfunc("game", "shockStick_applyHaywire", &scripts\mp\equipment\shock_stick::shockstick_applyhaywire);
  utility::registersharedfunc("game", "shockstick_canBeHaywire", &scripts\mp\equipment\shock_stick::shockstick_canbehaywire);
  utility::registersharedfunc("game", "empdebuff_get_emp_ents", &scripts\cp_mp\emp_debuff::empdebuff_get_emp_ents);
  utility::registersharedfunc("game", "play_emp_scramble", &scripts\cp_mp\emp_debuff::play_emp_scramble);
  utility::registersharedfunc("game", "stop_emp_scramble", &scripts\cp_mp\emp_debuff::stop_emp_scramble);
}

function function_9954ad81428762a0(params) {
  thread function_4b225ffb3a8f07d8();
  self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  callback::add("on_zombie_ai_killed", &function_ac70a9f818593e76);

  if(getdvarint(@ "hash_443321bd9a70a4f3", 0)) {
    callback::add("damage_point", &function_6bd89820ff597631);
  }
}

function function_a8c9248308033e4e() {
  return false;
}

function function_4b225ffb3a8f07d8() {
  radius_emp = 1700;
  height_emp = 1700;
  emptrigger = spawn("trigger_radius", self.origin, 0, radius_emp, height_emp);
  self.emptrigger = emptrigger;
  emptrigger.owner = self;

  if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
    [[getsharedfunc("game", "makeEnterExitTrigger")]](self.emptrigger, &function_3fae690d4b8f72d7, &function_74c430277be6f877);
  }

  self.emptrigger enablelinkTo();
  thread pulseemp();
  thread function_395ccf02853e8649(emptrigger);
}

function function_238dbae32131b4a8(emptrigger) {
  self notify("trigger_removed");
  playerszapped = getplayersinradius(self.origin, 1700, 1700);

  foreach(player in playerszapped) {
    if(istrue(player.empscramblelevels.size > 0)) {
      player function_8887420281f3ff3f(1);
    }
  }

  if(isDefined(emptrigger)) {
    emptrigger delete();
    return;
  }

  if(isDefined(self.emptrigger)) {
    self.emptrigger delete();
  }
}

function function_395ccf02853e8649(emptrigger) {
  self waittill("death");
  function_238dbae32131b4a8(emptrigger);
}

function pulseemp() {
  self endon("death");
  self endon("trigger_removed");

  while(true) {
    randomtime = randomfloatrange(5, 22);
    wait randomtime;

    if(!istrue(self.hidden_in_prop) && !istrue(self.var_76d65f0b5902d51d)) {
      function_b07326afbb0334d3(500, 1.5);
      continue;
    }

    if(istrue(self.var_76d65f0b5902d51d) && !istrue(self.hidden_in_prop)) {
      wait 10;
    }
  }
}

function function_3fae690d4b8f72d7(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }

  iprintln("<dev string:x1c>");

  if(istrue(player.var_b3678b10abbf63e5)) {
    iprintln("<dev string:x2b>");

    return;
  }

  player thread function_377c97bfdd963952(1);
}

function function_74c430277be6f877(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }

  if(istrue(player.var_b3678b10abbf63e5)) {
    iprintln("<dev string:x2b>");

    return;
  }

  player thread function_8887420281f3ff3f(1);

  iprintln("<dev string:x3d>");
}

function private function_b07326afbb0334d3(radius, shockduration) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread function_3ce4b28ed71f750a();
  self.var_76d65f0b5902d51d = 1;
  blastorigin = self.origin;
  var_170b85c668cf4b59 = self.angles;
  step = 100;
  maxdist = radius;
  waittime = 0.1;
  currentdist = step;
  shockdata = function_1fd889c40c7941b8(shockduration);
  possibleplayers = function_2d7fd59d039fa69b(self.origin, maxdist);
  var_9ba81be3ce3691 = function_2c9f694b8b0758e1(possibleplayers, blastorigin, shockdata);

  if(issharedfuncdefined("game", "empdebuff_get_emp_ents")) {
    possibleents = [[getsharedfunc("game", "empdebuff_get_emp_ents")]](blastorigin, radius);
  }

  var_82636d311009a1eb = function_8b664d9dfe6f4a7e(possibleents, blastorigin);

  while(currentdist <= maxdist) {
    currentdistsq = currentdist * currentdist;
    var_fe93d078a44d7866 = [];

    foreach(playerinfo in var_9ba81be3ce3691) {
      victim = playerinfo["player"];
      var_88b443ee2963b2a0 = playerinfo["distanceSQ"];

      if(var_88b443ee2963b2a0 <= currentdistsq) {
        function_ef718870091ebbd9(victim, shockdata);
        continue;
      }

      var_fe93d078a44d7866[var_fe93d078a44d7866.size] = playerinfo;
    }

    var_9ba81be3ce3691 = var_fe93d078a44d7866;
    var_6bb2d94137551dbc = [];

    foreach(entinfo in var_82636d311009a1eb) {
      ent = entinfo["entity"];
      var_88b443ee2963b2a0 = entinfo["distanceSQ"];

      if(var_88b443ee2963b2a0 <= currentdistsq) {
        continue;
      }

      var_6bb2d94137551dbc[var_6bb2d94137551dbc.size] = entinfo;
    }

    var_82636d311009a1eb = var_6bb2d94137551dbc;
    currentdist += step;
    wait waittime;
  }

  wait 1;
  self.var_76d65f0b5902d51d = 0;
  self notify("finished_electric_blast");
}

function function_55d0db940f81e2e6(victim, weaponobj, shockdata) {
  self endon("disconnect");
  victim endon("death_or_disconnect");
  victim endon("haywire_cleared");
  level endon("game_ended");
  var_d51f1d877f3b9e9e = shockdata.tableinfo.bundle.var_aba76142349af9c0;
  totalshocktime = shockdata.tableinfo.bundle.var_95602b4d7262c11f;

  if(!isDefined(victim.var_99e82fcc9b77ec71)) {
    victim.var_99e82fcc9b77ec71 = 0;
  }

  victim.var_99e82fcc9b77ec71++;

  if(isDefined(victim.var_fe74f3f4d5afe567)) {
    if((gettime() - victim.var_fe74f3f4d5afe567) / 1000 <= totalshocktime) {
      var_dab7d922f4d7be0c = victim.var_99e82fcc9b77ec71;
      totalshocktime = int(totalshocktime / var_dab7d922f4d7be0c);
    }
  }

  shockendtime = gettime() + totalshocktime * 1000;
  victim.var_fe74f3f4d5afe567 = gettime();
  thread function_83a614bd6a1f69f0(victim, totalshocktime);
  victim thread function_b0e45c5c9f310e2f();

  while(gettime() < shockendtime) {
    victim.var_108e6be5e24e9d1d = 1;

    if(issharedfuncdefined("game", "shockStick_applyHaywire")) {
      shockdata thread[[getsharedfunc("game", "shockStick_applyHaywire")]](victim, shockdata.weapon, 0);
    }

    var_3af58b59b546738d = 3;
    damage = ter_op(isPlayer(victim), var_3af58b59b546738d, 0);

    if(victim isswimming()) {
      damage *= 2;
    }

    victim dodamage(damage, victim.origin, self, self, "MOD_EXPLOSIVE", weaponobj, "torso_upper");
    wait var_d51f1d877f3b9e9e;
  }
}

function function_b0e45c5c9f310e2f() {
  if(!isPlayer(self)) {
    return;
  }

  function_377c97bfdd963952(2);
  self waittill("haywire_cleared");
  function_8887420281f3ff3f(2);
  self.var_108e6be5e24e9d1d = undefined;
}

function function_83a614bd6a1f69f0(victim, totalshocktime) {
  victim endon("disconnect");
  victim notify("electricDischarge_haywire");
  victim endon("electricDischarge_haywire");
  level endon("game_ended");
  victim waittill_any_timeout_2(totalshocktime, "death", "last_stand_start");
  victim.var_108e6be5e24e9d1d = undefined;
  victim.var_99e82fcc9b77ec71 = 0;
}

function function_ef718870091ebbd9(victim, shockdata) {
  thread function_55d0db940f81e2e6(victim, shockdata.weapon, shockdata);
}

function function_3ce4b28ed71f750a() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  shakeduration = 0.75;
  var_ff85637831346339 = 0.25;
  var_ff624f78310def85 = 0.15;
  var_ff625578310dfcb7 = 0.08;
  radiusscalemax = 200;
  radiusscalemid = 400;
  radiusscalemin = 600;

  if(issharedfuncdefined("game", "artillery_earthQuake")) {
    [[getsharedfunc("game", "artillery_earthQuake")]](self.origin, shakeduration, var_ff85637831346339, var_ff624f78310def85, var_ff625578310dfcb7, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1);
  }

  self setscriptablepartstate("emp_pulse", "electric_blast", 0);
  self waittill("finished_electric_blast");
  self setscriptablepartstate("emp_pulse", "off", 0);
}

function function_1fd889c40c7941b8(shockduration) {
  shockdata = spawnStruct();
  shockdata.tableinfo = scripts\common\values::getequipmenttableinfo("equip_shockstick");
  shockdata.owner = self;
  shockdata.team = self.team;
  shockdata.origin = self.origin;
  shockdata.weapon = makeweapon("electric_discharge_mp");
  shockdata.tableinfo.var_b79e08e886b92d46 = 0;
  shockdata.tableinfo.var_5dd66ebda239d1b = 1;
  shockdata.tableinfo.bundle.var_33bce1558051ceb5 = 0.3;
  shockdata.tableinfo.bundle.var_7c742af3d434b807 = shockduration;
  shockdata.tableinfo.bundle.var_95602b4d7262c11f = shockduration + 0.25;
  shockdata.tableinfo.bundle.var_aba76142349af9c0 = 0.2;
  return shockdata;
}

function function_2c9f694b8b0758e1(sourcearray, reforigin, shockdata) {
  filteredplayers = [];

  foreach(player in sourcearray) {
    if(!isDefined(player)) {
      continue;
    }

    if(player == self) {
      continue;
    }

    if(issharedfuncdefined("game", "shockstick_canBeHaywire")) {
      var_daca8eb57598bcc1 = player[[getsharedfunc("game", "shockstick_canBeHaywire")]](shockdata, 1);
    }

    if(!istrue(var_daca8eb57598bcc1)) {
      continue;
    }

    index = filteredplayers.size;
    filteredplayers[index]["player"] = player;
    filteredplayers[index]["distanceSQ"] = distancesquared(player.origin, reforigin);
  }

  return filteredplayers;
}

function function_8b664d9dfe6f4a7e(sourcearray, reforigin) {
  filteredents = [];

  foreach(ent in sourcearray) {
    if(!isDefined(ent) || istrue(ent.isdestroyed)) {
      continue;
    }

    if(isDefined(ent.vehiclename)) {
      if(issharedfuncdefined("game", "vehicle_isEnemyToPlayer")) {
        vehicleisenemy = [[getsharedfunc("game", "vehicle_isEnemyToPlayer")]](ent, self);
      }

      if(issharedfuncdefined("game", "vehicle_isNeutralToPlayer")) {
        var_e2772225ec2bac16 = [[getsharedfunc("game", "vehicle_isNeutralToPlayer")]](ent, self);
      }

      if(!istrue(vehicleisenemy) && !istrue(var_e2772225ec2bac16)) {
        continue;
      }
    } else {
      var_fd38e227901f5bf8 = undefined;
      var_1513504db97a5be7 = undefined;

      if(isDefined(ent.owner)) {
        var_fd38e227901f5bf8 = ent.owner.team;
        var_1513504db97a5be7 = ent.owner;
      } else if(isDefined(ent.team)) {
        var_fd38e227901f5bf8 = ent.team;
      }

      if(isDefined(var_fd38e227901f5bf8) && var_fd38e227901f5bf8 == self.team && var_1513504db97a5be7 != self) {
        continue;
      }
    }

    index = filteredents.size;
    filteredents[index]["entity"] = ent;
    filteredents[index]["distanceSQ"] = distancesquared(ent.origin, reforigin);
  }

  return filteredents;
}

function function_377c97bfdd963952(var_686570a991b92948) {
  if(issharedfuncdefined("game", "play_emp_scramble")) {
    [[getsharedfunc("game", "play_emp_scramble")]](var_686570a991b92948);
  }

  self playsoundtoplayer("kls_emp_hud_deactivate", self);
}

function function_8887420281f3ff3f(var_686570a991b92948) {
  if(issharedfuncdefined("game", "stop_emp_scramble")) {
    if(!isDefined(self.empscramblelevels) || !isDefined(self.empscramblelevels[var_686570a991b92948])) {
      return;
    }

    [[getsharedfunc("game", "stop_emp_scramble")]](var_686570a991b92948);
  }
}

function function_ac70a9f818593e76(params) {
  function_b07326afbb0334d3(500, 1.5);
  playFX(getfx("mangler_emp_blast"), self.origin);
  playsoundatpos(self.origin, "iw9_emp_blast");
}

function function_6bd89820ff597631(params) {
  if(is_equal(params.meansofdeath, "MOD_PROJECTILE")) {
    grenade = magicgrenademanual("jup_gas_grenade_ob_aether", params.origin, (0, 0, 0), 0);
    grenade.owner = self;
    grenade.owner thread scripts\mp\equipment\gas_grenade::gas_used(grenade);
  }
}