/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_bee418c8d4a317c.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_1bfe8e965532ee8a;
#using script_21cf081b320a9938;
#using script_38c251115537f16e;
#using script_3b78d23dad7ec5be;
#using script_3badb8914eb5ac16;
#using script_40510196b9a59795;
#using script_5133812eb5db429a;
#using script_516de9f009ec5f26;
#using script_60dd6e3992c1f29;
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
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\mp_agent;
#using scripts\ob\points;
#namespace zombie_mimic_emp;

function autoexec function_f67abbf91bd2f54d() {
  level._effect["mimic_emp_blast"] = loadfx("vfx/iw9/fieldupgrades/vfx_electric_discharge_blast.vfx");
  callback::add("on_zombie_mimic_emp_spawned", &function_b9405466354e742f);
  callback::add("on_zombie_mimic_hvt_emp_spawned", &function_b9405466354e742f);
  utility::registersharedfunc("game", "shockStick_applyHaywire", &scripts\mp\equipment\shock_stick::shockstick_applyhaywire);
  utility::registersharedfunc("game", "shockstick_canBeHaywire", &scripts\mp\equipment\shock_stick::shockstick_canbehaywire);
  utility::registersharedfunc("game", "empdebuff_get_emp_ents", &scripts\cp_mp\emp_debuff::empdebuff_get_emp_ents);
  utility::registersharedfunc("game", "play_emp_scramble", &scripts\cp_mp\emp_debuff::play_emp_scramble);
  utility::registersharedfunc("game", "stop_emp_scramble", &scripts\cp_mp\emp_debuff::stop_emp_scramble);
  utility::registersharedfunc("game", "vehicle_isEnemyToPlayer", &scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer);
  utility::registersharedfunc("game", "vehicle_isNeutralToPlayer", &scripts\cp_mp\vehicles\vehicle::vehicle_isneutraltoplayer);
}

function function_b9405466354e742f(params) {
  thread function_4b225ffb3a8f07d8();
  self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  callback::add("on_zombie_ai_killed", &function_ee7c6e89281ad07d);
  callback::add("on_entity_hidden_in_prop", &function_454e4da9021b5310);
  callback::add("on_entity_revealed", &function_664465ce23144228);
  callback::add("on_zombie_ai_damaged", &function_502f87fbb5e89c3b);
}

function function_a8c9248308033e4e() {
  return false;
}

function private function_454e4da9021b5310(params) {
  if(isDefined(self.emptrigger) && self.emptrigger islinked(self)) {
    self.emptrigger unlink(self);
  }

  if(params.prop isscriptable()) {
    params.prop setscriptablepartstate("vfx", "on", 1);
  }
}

function private function_664465ce23144228(params) {
  self setscriptablepartstate("ambient_emp_vfx", "enabled");

  if(!isDefined(self.emptrigger)) {
    self notify("trigger_removed");
    function_4b225ffb3a8f07d8();
  }

  self.emptrigger linkTo(self);
  function_b07326afbb0334d3(500, 1.5);
  playsoundatpos(self.origin, "iw9_emp_blast");
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

function function_ee7c6e89281ad07d(params) {
  function_b07326afbb0334d3(500, 1.5);
  playFX(getfx("mimic_emp_blast"), self.origin);
  playsoundatpos(self.origin, "iw9_emp_blast");
}

function private function_502f87fbb5e89c3b(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  weaponelementtype = scripts\ob\points::function_591305dc9c07499b(inflictor.sweapon, inflictor.eattacker, inflictor.smeansofdeath);

  if(isDefined(weaponelementtype)) {
    if(istrue(inflictor.smeansofdeath == "MOD_ELEMENTAL_ELEC") && istrue(weaponelementtype == "electrical")) {
      inflictor.idamage *= 0.6;
    }
  }

  return inflictor.idamage;
}

function function_431bcc26c1ddfa0e(var_5c2e97a09f5107d2) {
  if(!isDefined(level.var_b28db24b1327bd78)) {
    level.var_b28db24b1327bd78 = [];
  }

  var_ce1ae0a8d9dba707 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_mimic_hvt_emp", var_5c2e97a09f5107d2.origin, var_5c2e97a09f5107d2.angles, "team_two_hundred");
  waitframe();
  var_19f21d182b248a8a = namespace_6119efd5d1925c17::function_7f3bb3916bbd189d([var_5c2e97a09f5107d2], var_ce1ae0a8d9dba707, undefined, "mimicproplist:jup_mimic_prop_list_perkmachines", &function_352933897a5f3b97);
  level.var_b28db24b1327bd78[level.var_b28db24b1327bd78.size] = var_19f21d182b248a8a;
  var_ce1ae0a8d9dba707 scripts\common\callbacks::add("on_zombie_ai_killed", &function_240cdc3880a68807);
  var_ce1ae0a8d9dba707 scripts\common\callbacks::add("on_entity_revealed", &function_7582f30dfddf1da6);

  switch (var_19f21d182b248a8a.model) {
    case #"hash_9fc3955022dcec7f":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_deadshot";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_deadshot";
      break;
    case #"hash_fd633a3369f49cd5":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_death_perception";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_death_perception";
      break;
    case #"hash_a9bd1b904c43abc8":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_elemental_pop";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_elemental_pop";
      break;
    case #"hash_457fd31b4a55de0b":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_juggernog";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_juggernog";
      break;
    case #"hash_74feee3f5b98d202":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_phd_flopper";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_phd_flopper";
      break;
    case #"hash_fd5cf1a493e9052a":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_quickrevive";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_quickrevive";
      break;
    case #"hash_189eaaac4ac8ebae":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_speedcola";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_speedcola";
      break;
    case #"hash_38a258c29023a3e4":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_staminup";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_staminup";
      break;
    case #"hash_c7f1279e3ac5baa6":
      var_ce1ae0a8d9dba707.perktype = "ob_jup_item_perk_tombstone";
      var_ce1ae0a8d9dba707.var_5c3069c29e795da8 = "specialty_tombstone";
      break;
    default:
      break;
  }
}

function function_240cdc3880a68807(params) {
  if(!isDefined(self.perktype)) {
    return;
  }

  spawnperk(self.perktype, params.einflictor);
}

function function_7582f30dfddf1da6(params) {}

function spawnperk(perkbundlename, player) {
  itembundlename = perkbundlename;
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, self.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function function_352933897a5f3b97() {
  prop_height = (0, 0, 64);
  var_807fb6a8cf7bb90e = 70;
  players = scripts\cp_mp\utility\player_utility::getplayersinradius(self.origin, var_807fb6a8cf7bb90e);

  if(players.size) {
    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }

      if(istrue(player.ignoreme) || istrue(player.inlaststand)) {
        continue;
      }

      if(getdvarint(@ "hash_821690ed248715f7", 0)) {
        sphere(player.origin, 20, (0, 1, 0), 0, 1, 1);
      }

      if(isDefined(player.last_valid_position) && isDefined(self.navmesh_position)) {
        if(!scripts\engine\trace::ray_trace_passed(player.last_valid_position, self.navmesh_position, [self], scripts\engine\trace::create_default_contents(1))) {
          if(getdvarint(@ "hash_821690ed248715f7", 0)) {
            line(player.last_valid_position, self.navmesh_position, (0, 1, 1), 1, 0, 1);
            sphere(self.navmesh_position, 20, (1, 0, 0), 0, 1, 1);
          }

          continue;
        }
      } else {
        player_center = player gettagorigin("j_spine4");
        player_center = scripts\engine\utility::default_to(player_center, player getcentroid());

        if(isDefined(player_center) && !sighttracepassed(self.origin + prop_height, player_center, 0, self)) {
          if(getdvarint(@ "hash_821690ed248715f7", 0)) {
            line(self.origin + prop_height, player gettagorigin("<dev string:x49>"), (1, 1, 0), 1, 0, 1);
          }

          continue;
        }
      }

      traceresult = playerphysicstrace(self.origin + (0, 0, 20), player.origin + (0, 0, 36), player, undefined, self, 1);

      if(traceresult["fraction"] >= 1) {
        self notify("stop_shake_tell");

        if(isDefined(self.interact)) {
          self.interact.activated = 1;
          self makeunusable();
        }

        return player;
      }

      if(getdvarint(@ "hash_821690ed248715f7", 0)) {
        line(self.origin + (0, 0, 8), player.origin + (0, 0, 8), (1, 0, 0), 1, 0, 1);
        sphere(traceresult["<dev string:x55>"], 4, (1, 0, 0), 1, 0, 10, 1);
      }
    }
  }
}