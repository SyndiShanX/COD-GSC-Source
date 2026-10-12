/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_electric_discharge.gsc
**********************************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\equipment\temp_v;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\shellshock;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace super_electric_discharge;

function function_9e8a4373c9755f3d() {
  scripts\common\values::group_register("electricFire", ["usability", "mantle", "armor", "supers", "killstreaks", "ladder", "melee", "execution_attack", "execution_victim"]);
  scripts\engine\utility::registersharedfunc("super_electric_discharge", "giveAndFireOffhand", &function_1b73127b2849cc95);
  scripts\engine\utility::registersharedfunc("super_electric_discharge", "endSuper", &function_456170ef7257430b);
}

function function_c0327b881b392647() {
  giveperk("specialty_blastshield");
  result = function_4468fd6516623b9f();

  if(!istrue(result)) {
    removeperk("specialty_blastshield");
  }

  return result;
}

function function_4468fd6516623b9f() {
  if(self isinexecutionattack() || self isinexecutionvictim()) {
    return 0;
  }

  thread scripts\mp\hud_message::showsplash("super_electric_discharge" + "_activate", undefined, self, undefined, undefined, undefined, 1);
  self setscriptablepartstate("superpowers", "electric_charge", 0);
  return function_b275e1f539394ae1(undefined);
}

function function_1b73127b2849cc95(killstreakbundle) {
  self endon("disconnect");
  level endon("game_ended");

  if(self isinexecutionattack() || self isinexecutionvictim()) {
    return 0;
  }

  objweapon = makeweapon("electric_discharge_mp");
  heldoffhand = scripts\cp_mp\weapon::getgrenadeinpullback();

  if(isDefined(heldoffhand) && !isnullweapon(heldoffhand) && heldoffhand != objweapon) {
    self.var_f3bc490293d6afd5 = gettime();
  }

  if(isDefined(self.var_f3bc490293d6afd5)) {
    lastfiretime = self.var_f3bc490293d6afd5;

    if((gettime() - lastfiretime) / 1000 <= 1.5) {
      return 0;
    }
  }

  if(!function_da1cc53c13568565()) {
    return 0;
  }

  self giveandfireoffhand(objweapon);
  scripts\common\values::group_set("electricFire", 0);
  result = function_9abe408951f8cc02();
  scripts\common\values::group_reset("electricFire");

  if(isDefined(result) && (result == "offhand_fired" || result == "timeout")) {
    return function_b275e1f539394ae1(killstreakbundle);
  } else if(!isDefined(result) || result == "death") {
    self.var_f3bc490293d6afd5 = undefined;
  }

  return 0;
}

function function_e721c06d0e8502bf() {
  thread function_1b73127b2849cc95(undefined);
  return true;
}

function private function_b275e1f539394ae1(killstreakbundle) {
  self notify("electric_blast_succeed");
  self.var_f3bc490293d6afd5 = gettime();

  if(!isDefined(killstreakbundle)) {
    self.super.isactive = 1;
    scripts\cp_mp\challenges::function_d997435895422ecc("super_electric_discharge", ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  }

  thread function_b07326afbb0334d3(killstreakbundle);
  return true;
}

function private function_da1cc53c13568565() {
  return isreallyalive(self) && !isinlaststand(self) && !self isonascender() && !self isonladder() && !self ismantling() && !self ishanging() && !self isinfreefall() && !self isparachuting() && !self isdiving() && !self ismeleeing() && !self isswitchingweapon() && !isusingremote();
}

function private function_9abe408951f8cc02() {
  self endon("disconnect");
  level endon("game_ended");
  thread function_127ef8142005081a();
  result = waittill_any_timeout_4(0.9, "offhand_fired", "electric_blast_fail");
  return result;
}

function function_127ef8142005081a() {
  self endon("disconnect");
  self endon("electric_blast_succeed");
  failblast = 0;

  while(true) {
    if(!function_da1cc53c13568565()) {
      failblast = 1;
      break;
    }

    waitframe();
  }

  if(istrue(failblast)) {
    self notify("electric_blast_fail");
  }
}

function private function_b07326afbb0334d3(killstreakbundle) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread function_3ce4b28ed71f750a();
  blastorigin = self.origin;
  var_170b85c668cf4b59 = self.angles;
  step = 100;
  maxdist = isDefined(killstreakbundle) ? killstreakbundle.var_bb6132ef022b0ed1 : 400;
  waittime = 0.1;
  currentdist = step;
  shockdata = function_1fd889c40c7941b8();
  possibleplayers = function_2d7fd59d039fa69b(self.origin, maxdist);
  var_9ba81be3ce3691 = function_2c9f694b8b0758e1(possibleplayers, blastorigin, shockdata);
  possibleents = empdebuff_get_emp_ents();
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
        function_822a7fd2e23b8fb6(ent);
        continue;
      }

      var_6bb2d94137551dbc[var_6bb2d94137551dbc.size] = entinfo;
    }

    var_82636d311009a1eb = var_6bb2d94137551dbc;
    currentdist += step;
    wait waittime;
  }

  if(!isDefined(killstreakbundle)) {
    self.super.isactive = 0;
  }

  wait 1;
  self notify("finished_electric_blast");
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

    if(!istrue(player scripts\mp\equipment\shock_stick::shockstick_canbehaywire(shockdata, 1))) {
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

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(!scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(ent, self) && !scripts\cp_mp\vehicles\vehicle::vehicle_isneutraltoplayer(ent, self)) {
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

function function_3ce4b28ed71f750a() {
  self endon("disconnect");
  level endon("game_ended");
  shakeduration = 0.75;
  var_ff85637831346339 = 0.25;
  var_ff624f78310def85 = 0.15;
  var_ff625578310dfcb7 = 0.08;
  radiusscalemax = 200;
  radiusscalemid = 400;
  radiusscalemin = 600;
  scripts\mp\shellshock::artillery_earthquake(self.origin, shakeduration, var_ff85637831346339, var_ff624f78310def85, var_ff625578310dfcb7, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1);
  self setscriptablepartstate("superpowers", "electric_blast", 0);
  waittill_any_2("finished_electric_blast", "death");
  self setscriptablepartstate("superpowers", "off", 0);
}

function function_ef718870091ebbd9(victim, shockdata) {
  thread function_55d0db940f81e2e6(victim, shockdata.weapon, shockdata);
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

  while(gettime() < shockendtime) {
    shockdata thread scripts\mp\equipment\shock_stick::shockstick_applyhaywire(victim, shockdata.weapon, 0);
    damage = ter_op(isPlayer(victim), 3, 5);

    if(victim isswimming()) {
      damage *= 2;
    }

    victim dodamage(damage, victim.origin, self, self, "MOD_EXPLOSIVE", weaponobj, "torso_upper");
    wait var_d51f1d877f3b9e9e;
  }
}

function function_83a614bd6a1f69f0(victim, totalshocktime) {
  victim endon("disconnect");
  victim notify("electricDischarge_haywire");
  victim endon("electricDischarge_haywire");
  level endon("game_ended");
  victim waittill_any_timeout_2(totalshocktime, "death", "last_stand_start");
  victim.var_99e82fcc9b77ec71 = 0;
}

function function_822a7fd2e23b8fb6(ent) {
  electricweapon = makeweapon("electric_discharge_mp");

  if(isDefined(ent)) {
    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(istrue(ent.exfilhelicopter)) {
        return;
      } else if(isDefined(ent.bossname)) {
        healthdamage = 200;

        if(isDefined(ent.maxhealth)) {
          healthdamage = ent.maxhealth / 6;
        }

        ent dodamage(healthdamage, ent.origin, self, self, "MOD_EXPLOSIVE", electricweapon);
      } else if(ent scripts\cp_mp\vehicles\vehicle::isvehiclekillstreak()) {
        ent dodamage(9999, ent.origin, self, self, "MOD_EXPLOSIVE", electricweapon);
      } else {
        ent.dontspawnhusk = 1;
        damagedata = spawnStruct();
        damagedata.attacker = self;
        damagedata.inflictor = ent;
        damagedata.objweapon = ent.objweapon;
        damagedata.meansofdeath = "MOD_EXPLOSIVE";
        ent scripts\cp_mp\vehicles\vehicle::vehicle_explode(damagedata);
      }

      return;
    }

    ent dodamage(9999, ent.origin, self, self, "MOD_EXPLOSIVE", electricweapon);
  }
}

function function_456170ef7257430b(var_58e914135e6ea706, iskillstreak) {
  self endon("disconnect");
  level endon("game_ended");
  shouldfinish = 0;
  dontclear = 0;

  if(!istrue(var_58e914135e6ea706)) {
    self waittill("finished_electric_blast");
  }

  if(isDefined(self.super) && !istrue(iskillstreak)) {
    self.super.isactive = 0;
  }

  removeperk("specialty_blastshield");
  thread scripts\mp\equipment\temp_v::function_269b97f3d86eb172(shouldfinish, dontclear, "super_use_finished", istrue(iskillstreak));
  return true;
}

function function_1fd889c40c7941b8(killstreakbundle) {
  shockdata = spawnStruct();
  shockdata.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo("equip_shockstick");
  shockdata.owner = self;
  shockdata.team = self.team;
  shockdata.origin = self.origin;
  shockdata.weapon = makeweapon("electric_discharge_mp");
  duration = isDefined(killstreakbundle) ? killstreakbundle.var_6abfe91d36e0c7f : 5;
  shockdata.tableinfo.var_b79e08e886b92d46 = 0;
  shockdata.tableinfo.var_5dd66ebda239d1b = 1;
  shockdata.tableinfo.bundle.var_33bce1558051ceb5 = 0.3;
  shockdata.tableinfo.bundle.var_7c742af3d434b807 = duration;
  shockdata.tableinfo.bundle.var_95602b4d7262c11f = duration;
  shockdata.tableinfo.bundle.var_aba76142349af9c0 = 0.2;
  return shockdata;
}