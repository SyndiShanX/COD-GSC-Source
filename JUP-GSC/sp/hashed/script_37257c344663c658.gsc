/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_37257c344663c658.gsc
*************************************************/

#using script_cbb0697de4c5728;
#using scripts\asm\asm_bb;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\perks\cp_perks;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\superdeploy;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace namespace_bb3382aff760c1a0;

function function_54655641d3957e3(grenade) {
  setdevdvarifuninitialized(@ "hash_d677956e73b3bfb4", 0.8);

  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(grenade.weapon_name);
  grenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(grenade.tableinfo.bundle)) {
    assertmsg("Shock Stick needs a bundle.");
  }

  if(istrue(grenade.tableinfo.bundle.var_b79e08e886b92d46)) {
    if(!isDefined(self.shocksticks)) {
      self.shocksticks = [];
      callback::add("onPlayerSpawn_destroyEquipment", &function_2bcd92a365fef09);
    }

    self.shocksticks[self.shocksticks.size] = grenade;
  }

  grenade thread function_c00fb7cc84f2d066();
  grenade thread function_50a6b61f28ff21c8();
  thread function_374b1abf46319e21(grenade);
}

function function_c00fb7cc84f2d066() {
  self endon("death");
  self endon("underwater_swap");
  self.owner waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread function_c44b639f5005afa();
}

function function_50a6b61f28ff21c8() {
  self endon("death");
  self endon("underwater_swap");
  self waittill("forceDeath");
  thread function_c44b639f5005afa();
}

function function_c44b639f5005afa(isimmediate) {
  if(istrue(self.exploding)) {
    return;
  }

  time = 0.25;

  if(istrue(isimmediate)) {
    time = 0;
  }

  self.exploding = 1;
  self setscriptablepartstate("destroy", "on", 0);
  thread function_c5852887bdea3efb(time);
}

function function_c5852887bdea3efb(deletiondelay) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.tableinfo.bundle.var_6bf09ccafb1e16d2)) {
    self setscriptablepartstate("electric", "neutral", 0);
    chaindelay = default_to(self.tableinfo.bundle.var_a3395b5076eb8a6c, 1);
    wait chaindelay + 0.5;
    self notify("death");
    wait deletiondelay;

    if(isDefined(self)) {
      if(isDefined(self.badplace)) {
        destroynavobstacle(self.badplace);
      }

      self.var_5bcbcef205cb1486 = undefined;
      self delete();
    }

    return;
  }

  self notify("death");
  wait deletiondelay;

  if(isDefined(self)) {
    if(isDefined(self.badplace)) {
      destroynavobstacle(self.badplace);
    }

    self.var_5bcbcef205cb1486 = undefined;
    self setscriptablepartstate("electric", "neutral", 0);
    self delete();
  }
}

function function_ca6c37e5d8f35c8b(data) {
  if(data.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  data.victim thread function_5d58ea6516bf050c(0.2);
  return true;
}

function function_2bcd92a365fef09(params) {
  if(isDefined(self.shocksticks)) {
    foreach(shockstick in self.shocksticks) {
      if(isDefined(shockstick)) {
        shockstick function_c44b639f5005afa();
      }
    }

    self.shocksticks = [];
  }
}

function function_a5e91eaa60d034d7(grenade) {
  newgrenade = undefined;

  if(issharedfuncdefined("weapons", "_launchGrenade")) {
    newgrenade = self[[getsharedfunc("weapons", "_launchGrenade")]]("shock_stick_underwater_mp", grenade.origin, (0, 0, 0), undefined, 1);
  }

  scripts\cp\weapon::grenadeinitialize(newgrenade, makeweapon("shock_stick_underwater_mp"), 0, self);
  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(grenade.weapon_name);
  newgrenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);
  newgrenade.owner = self;
  grenade notify("underwater_swap");
  grenade delete();
  newgrenade setscriptablepartstate("danger-icon", "on", 0);
  newgrenade thread function_ab90d143e732b403();
  return newgrenade;
}

function function_374b1abf46319e21(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade endon("death");
  bundle = grenade.tableinfo.bundle;
  stuckdata = grenade scripts\cp\weapon::function_f69ed22535d90b78();

  if(!isDefined(stuckdata)) {
    return;
  }

  stucktoplayer = 0;

  if(isDefined(stuckdata.stuckto)) {
    stuckto = stuckdata.stuckto;

    if(isPlayer(stuckto)) {
      grenade thread scripts\cp\weapon::grenadestuckto(grenade, stuckdata.stuckto);
      stucktoplayer = 1;
    } else {
      grenade thread scripts\cp\weapon::function_4af015619e2534ba(stuckto, &function_c44b639f5005afa, 1);
    }

    grenade.stuckto = stuckto;
  }

  if(!stucktoplayer) {
    grenade thread function_ab90d143e732b403();
    fusetime = default_to(bundle.var_359bfa5663381124, 0.35);
    fusetime = getdvarfloat(@ "hash_b3e986ad3c157f80", fusetime);
    grenade setscriptablepartstate("electric", "fuse", 0);
    wait fusetime;
  }

  thread function_c205d3a32bf04340(grenade, stuckdata);
}

function private function_c205d3a32bf04340(grenade, stuckdata) {
  self endon("disconnect");
  level endon("game_ended");
  bundle = grenade.tableinfo.bundle;
  var_5fbadc0f9063d647 = istrue(bundle.var_b79e08e886b92d46);

  if(istrue(grenade.exploding)) {
    return;
  }

  if(isDefined(stuckdata.isunderwater)) {
    if(var_5fbadc0f9063d647) {
      grenade function_c44b639f5005afa();
    } else {
      grenade = function_a5e91eaa60d034d7(grenade);
    }
  }

  grenade endon("death");

  if(var_5fbadc0f9063d647) {
    if(!isDefined(stuckdata.isunderwater)) {
      grenade function_4d13735859a44508(stuckdata);
    }

    return;
  }

  grenade setscriptablepartstate("electric", "active", 0);
  grenade setscriptablepartstate("detonate", "detonate", 0);
  grenade thread function_f47ab824a48fe570(stuckdata);
}

function private function_ab90d143e732b403() {
  maxhp = default_to(self.tableinfo.bundle.var_890704710e61ebcc, 100);
  thread scripts\cp\weapon::monitordamage(maxhp, "hitequip", &function_8e8a3b7d66fdc1b1, undefined);
}

function private function_8e8a3b7d66fdc1b1(data) {
  function_4714b4df7581ef29(data.attacker);
  function_c44b639f5005afa();
}

function function_4714b4df7581ef29(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\cp\points::doscoreevent(#"destroyed_equipment");
    attacker scripts\cp\cp_player_battlechatter::equipmentdestroyed(self);
  }
}

function shockstick_canbehaywire(shockstick) {
  if(self == shockstick) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(isPlayer(self)) {
    return function_d3690389f7d8334c(shockstick);
  } else if(istrue(self.exploding)) {
    return 0;
  } else if(istrue(self.var_98e373d243c1936f)) {
    return 0;
  } else {
    return function_407cdd75e41a385d(shockstick);
  }

  return 1;
}

function function_407cdd75e41a385d(shockstick) {
  if(!isDefined(self.classname)) {
    return false;
  }

  if(!isDefined(self.owner) && !isagent(self) && self.classname != "misc_turret" && self.classname != "script_vehicle") {
    return false;
  }

  if(shockstick == self) {
    return false;
  }

  bundle = shockstick.tableinfo.bundle;

  if(!istrue(bundle.var_5dd66ebda239d1b)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(self.owner) && isDefined(self.team)) {
      if(shockstick.team == self.team && self.owner != shockstick.owner) {
        return false;
      }
    }

    if(isDefined(level.soldier_allies)) {
      for(i = 0; i < level.soldier_allies.size; i++) {
        if(level.soldier_allies[i] == self && self.team == shockstick.owner.team) {
          return false;
        }
      }
    }
  }

  if(isDefined(self.weapon_name)) {
    weapontype = scripts\cp\weapon::getweapontype(self.weapon_name);

    if(isDefined(weapontype)) {
      if(weapontype != "lethal" && weapontype != "tactical" && weapontype != "super" && !scripts\cp_mp\killstreaks\cluster_spike::function_60dface26506153e(self.weapon_name) && weapontype == "killstreak" && !isDefined(self.var_aa6fe6af4cbbdd47)) {
        return false;
      }
    }
  }

  return true;
}

function function_d3690389f7d8334c(shockstick) {
  bundle = shockstick.tableinfo.bundle;

  if(scripts\cp\utility::isjuggernaut()) {
    return 0;
  }

  if(istrue(bundle.var_b79e08e886b92d46) && (function_b80ed39805876e5c(shockstick) || self == shockstick.owner)) {
    return 0;
  }

  if(level.teambased) {
    if(!isDefined(self.team)) {
      return 1;
    }

    if(shockstick.team == self.team && self != shockstick.owner) {
      return 0;
    }
  }

  isalive = scripts\cp_mp\utility\player_utility::_isalive();
  haywireduration = shockstick function_91a16c9b36fa1b5c(self);
  maxhaywireduration = default_to(5, bundle.var_95602b4d7262c11f);

  if(!isalive || haywireduration >= maxhaywireduration) {
    return 0;
  }

  if(self sightconetrace(shockstick.origin, shockstick) <= 0) {
    return 0;
  }

  return function_5e15cf3721cdcaab(shockstick);
}

function function_f793c14e21581402(shockstick, chainorigin) {
  bundle = shockstick.tableinfo.bundle;

  if(istrue(bundle.var_b79e08e886b92d46) && (function_b80ed39805876e5c(shockstick) || self == shockstick.owner)) {
    return 0;
  }

  isalive = scripts\cp_mp\utility\player_utility::_isalive();
  haywireduration = shockstick function_91a16c9b36fa1b5c(self);
  maxhaywireduration = default_to(5, bundle.var_95602b4d7262c11f);

  if(!isalive || haywireduration >= maxhaywireduration) {
    return 0;
  }

  if(self sightconetrace(chainorigin.origin, chainorigin) <= 0) {
    return 0;
  }

  return function_5e15cf3721cdcaab(shockstick);
}

function function_91a16c9b36fa1b5c(target) {
  if(!isDefined(self.var_5bcbcef205cb1486)) {
    return 0;
  }

  duration = self.var_5bcbcef205cb1486[target getentitynumber()];

  if(!isDefined(duration)) {
    return 0;
  }

  return duration;
}

function function_b80ed39805876e5c(shockstick) {
  if(!isDefined(self.var_cb886ff3371f4df8)) {
    return false;
  }

  bundle = shockstick.tableinfo.bundle;
  var_c3fa36eb9aa40509 = default_to(bundle.var_33bce1558051ceb5, 0.3);
  var_c3fa36eb9aa40509 *= 1000;
  return gettime() - self.var_cb886ff3371f4df8 <= var_c3fa36eb9aa40509;
}

function function_f47ab824a48fe570(stuckdata) {
  self endon("death");
  self.owner endon("disconnect");
  bundle = self.tableinfo.bundle;
  ticks = 0;
  objweapon = makeweapon("shock_stick_mp");
  contents = ["physicscontents_item", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  totalduration = default_to(bundle.var_48d181037894a0fe, 5);
  totalduration = getdvarfloat(@ "hash_2c69cb8cd7d267cd", totalduration);
  tickrate = default_to(bundle.var_aba76142349af9c0, 0.2);
  tickrate = getdvarfloat(@ "hash_b2f16983a17dc833", tickrate);
  tickcount = totalduration / tickrate;
  detonationradius = default_to(bundle.var_f196cc01f2b12053, 125);
  electrocutedamage = default_to(bundle.var_4d5d534ef8820d0a, 6);
  var_46d6554bcb2371a1 = istrue(bundle.var_6bf09ccafb1e16d2);

  if(var_46d6554bcb2371a1) {
    self.var_dac6c64c0c59d452 = [];
  }

  self.badplace = function_9c95c914395a9d4a(self.origin, detonationradius);
  function_daf6c5596bb31dff("decoy_grenade", self.owner, self.origin, 512);

  while(ticks < tickcount) {
    ents = scripts\cp\utility::getentitiesinradius(self.origin, detonationradius, undefined, undefined, physics_createcontents(contents));

    foreach(ent in ents) {
      if(!isDefined(ent)) {
        continue;
      }

      if(ent == self) {
        continue;
      }

      if(!ent shockstick_canbehaywire(self)) {
        continue;
      }

      if(isagent(ent) || isPlayer(ent)) {
        if(ent isswimming()) {
          ent dodamage(electrocutedamage, self.origin, self.owner, self, "MOD_EXPLOSIVE", objweapon, "torso_upper");
        } else if(ent != self.owner) {
          if(ent scripts\cp\utility::_hasperk("specialty_tac_resist")) {
            self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
          } else {
            self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("");
          }
        }
      }

      if(var_46d6554bcb2371a1) {
        self.var_dac6c64c0c59d452[self.var_dac6c64c0c59d452.size] = ent;
      }

      thread shockstick_applyhaywire(ent, objweapon, var_46d6554bcb2371a1);
      function_bba576fc720ed9c5(ent);
      entisvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

      if(entisvehicle && istrue(ent.occupied) || !entisvehicle) {}
    }

    ticks++;
    wait tickrate;
  }

  function_c44b639f5005afa();
}

function function_bba576fc720ed9c5(ent) {
  entisvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(!istrue(entisvehicle)) {
    if(ent != self.owner) {
      if(level.teambased) {
        if(isDefined(ent.team) && isDefined(self.team)) {
          if(ent.team != self.team) {}
        }
      }
    }

    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(ent, self.owner)) {}
}

function function_afa7236ce2426c99(victim) {
  self endon("death");
  self.owner endon("disconnect");
  chaindelay = default_to(self.tableinfo.bundle.var_a3395b5076eb8a6c, 1);
  wait chaindelay;
  bundle = self.tableinfo.bundle;
  objweapon = makeweapon("shock_stick_mp");
  contents = ["physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  electrocutedamage = default_to(bundle.var_4d5d534ef8820d0a, 6);
  var_804ec4ef50698a33 = default_to(bundle.var_606c50913543c2f6, 3);
  var_b22bec491ee6513d = default_to(bundle.var_c0ee4e9b4b96de5a, 125);
  ents = scripts\cp\utility\entity::getentitiesinradius(victim.origin, var_b22bec491ee6513d, undefined, undefined, physics_createcontents(contents));
  targets = [];
  victimorigin = victim.origin;
  firsttimecheck = 1;
  maxdistance = -1;
  maxdistanceindex = 0;

  foreach(ent in ents) {
    if(!isDefined(ent)) {
      continue;
    }

    if(ent == victim) {
      continue;
    }

    if(isagent(ent) || isPlayer(ent)) {
      if(!ent function_f793c14e21581402(self, victim)) {
        continue;
      }

      if(level.teambased) {
        if(self.team == ent.team) {
          continue;
        }
      }

      if(array_contains(self.var_dac6c64c0c59d452, ent)) {
        continue;
      }

      if(ent isswimming()) {
        ent dodamage(electrocutedamage, self.origin, self.owner, self, "MOD_EXPLOSIVE", objweapon, "torso_upper");
      } else if(ent != self.owner) {
        self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("");
      }

      if(targets.size < var_804ec4ef50698a33) {
        targetstruct = spawnStruct();
        targetstruct.ent = ent;
        targets[targets.size] = targetstruct;
        continue;
      }

      if(firsttimecheck) {
        firsttimecheck = 0;

        for(i = 0; i < targets.size; i++) {
          targets[i].dist = distancesquared(victimorigin, targets[i].ent.origin);

          if(targets[i].dist > maxdistance) {
            maxdistance = targets[i].dist;
            maxdistanceindex = i;
          }
        }
      }

      targetdist = distancesquared(victimorigin, ent.origin);

      if(targetdist < maxdistance) {
        targets[maxdistanceindex].ent = ent;
        targets[maxdistanceindex].dist = targetdist;
        maxdistance = -1;
        maxdistanceindex = -1;

        for(i = 0; i < targets.size; i++) {
          if(targets[i].dist > maxdistance) {
            maxdistance = targets[i].dist;
            maxdistanceindex = i;
          }
        }
      }
    }
  }

  foreach(target in targets) {
    thread shockstick_applyhaywire(target.ent, objweapon, 0);
  }
}

function function_4d13735859a44508(stuckdata) {
  self endon("death");
  self setscriptablepartstate("beacon", "active", 0);
  contents = ["physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  var_775635eb25c3c213 = 0;
  bundle = self.tableinfo.bundle;
  triggerradius = default_to(bundle.var_4262c0e42874114f, 125);

  while(!var_775635eb25c3c213) {
    if(!isDefined(self.owner)) {
      function_c44b639f5005afa();
    }

    ents = scripts\cp\utility\entity::getentitiesinradius(self.origin, triggerradius, undefined, undefined, physics_createcontents(contents));

    foreach(ent in ents) {
      if(!isDefined(ent)) {
        continue;
      }

      if(ent == self) {
        continue;
      }

      if(!ent shockstick_canbehaywire(self)) {
        continue;
      }

      if(isagent(ent) || isPlayer(ent)) {
        var_775635eb25c3c213 = 1;
      }
    }

    if(!var_775635eb25c3c213) {
      wait 0.1;
    }
  }

  self setscriptablepartstate("electric", "active", 0);
  self setscriptablepartstate("detonate", "detonate", 0);
  thread function_f47ab824a48fe570(stuckdata);
}

function function_9b3d2da91a6665(victim) {
  victim endon("haywire_cleared");
  self endon("death");

  if(!isDefined(self.var_5bcbcef205cb1486)) {
    self.var_5bcbcef205cb1486 = [];
  }

  if(!isDefined(self.var_5bcbcef205cb1486[victim getentitynumber()])) {
    self.var_5bcbcef205cb1486[victim getentitynumber()] = 0;
  }

  bundle = self.tableinfo.bundle;
  maxduration = default_to(bundle.var_95602b4d7262c11f, 5);

  while(true) {
    self.var_5bcbcef205cb1486[victim getentitynumber()] += 0.05;

    if(self.var_5bcbcef205cb1486[victim getentitynumber()] >= maxduration) {
      victim notify("haywire_max_duration");
      break;
    }

    wait 0.05;
  }
}

function shockstick_applyhaywire(victim, objweapon, chain) {
  level endon("game_ended");
  victim endon("disconnect");
  victim notify("shockStick_haywireApplied");
  victim endon("shockStick_haywireApplied");
  assertex(isDefined(victim), "shockStick_applyHaywire() doesn't have a victim. ");
  assertex(isDefined(objweapon), "shockStick_applyHaywire() doesn't have a weapon reference. ");

  if(isPlayer(victim)) {
    victim thread namespace_46e942396566f2da::function_943511ab1f39db66();
  }

  data = packdamagedata(self.owner, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);

  if(chain) {
    childthread function_afa7236ce2426c99(victim);
  }

  if(isPlayer(victim) || isagent(victim)) {
    childthread function_9b3d2da91a6665(victim);
  }

  function_ea2863c73339ae9e(data);
  function_fb327fd48c0e34e0(data);
  fromdeath = 0;

  if(isPlayer(data.victim) || isagent(data.victim)) {
    fromdeath = !scripts\cp\utility\player::isreallyalive(data.victim);
  }

  function_46b866d198a76ddc(data, fromdeath);
}

function function_ea2863c73339ae9e(data) {
  assertex(isDefined(data), "shockStick_applyHaywireStruct() called without data.");
  assertex(isDefined(data.attacker), "shockStick_applyHaywireStruct() data does not have a .attacker.");
  assertex(isDefined(data.victim), "shockStick_applyHaywireStruct() data does not have a .victim.");
  assertex(isDefined(data.objweapon), "shockStick_applyHaywireStruct() data does not have a .objWeapon.");
  assertex(isweapon(data.objweapon), "shockStick_applyHaywireStruct() data.objWeapon is not a weapon object.");

  if(!isDefined(data.damage)) {
    data.damage = 1;
  }

  if(!isDefined(data.meansofdeath)) {
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!isDefined(data.point)) {
    data.point = (0, 0, 0);
  }

  if(!isDefined(data.direction_vec)) {
    data.direction_vec = (0, 0, 0);
  }

  if(!isDefined(data.modelname)) {
    data.modelname = 0;
  }

  if(!isDefined(data.partname)) {
    data.partname = "";
  }

  if(!isDefined(data.tagname)) {
    data.tagname = 0;
  }

  if(!isDefined(data.damageflags)) {
    data.damageflags = 0;
  }

  if(!isDefined(data.hitloc)) {
    data.hitloc = "none";
  }

  if(!isDefined(data.timeoffset)) {
    data.timeoffset = 0;
  }

  if(isagent(data.victim)) {
    thread shockstick_haywireagent(data);
    return;
  }

  if(isPlayer(data.victim)) {
    thread function_c927fd013fc6e502(data.victim);
    return;
  }

  if(scripts\cp\utility\entity::isturret(data.victim) && !isDefined(data.victim.var_aa6fe6af4cbbdd47)) {
    thread function_805969ca0925b2bd(data);
    return;
  }

  thread function_5dd66ebda239d1b(data);
}

function function_805969ca0925b2bd(data) {
  level endon("game_ended");
  data.victim endon("death");
  data.victim endon("haywire_cleared");

  if(istrue(data.victim.ishaywire)) {
    return;
  }

  data.victim.ishaywire = 1;
  turretweapon = data.victim.objweapon;

  if(!isDefined(turretweapon)) {
    return;
  }

  turretuser = data.victim.owner;
  achievement_unlocked = 0;

  if(isDefined(turretuser)) {
    turretuser startforcedfire();
    return;
  }

  if(is_equal(data.victim.turrettype, "sentry_turret")) {
    if(isDefined(data.victim.disable_func)) {
      data.victim thread[[data.victim.disable_func]]();
    }

    achievement_unlocked = 1;

    if(!isPlayer(turretuser)) {
      scripts\common\utility::giveachievement_wrapper("jup_sp_haveyoutriedturningitoff");
    }
  }
}

function function_fb327fd48c0e34e0(data) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  data.victim childthread function_48f07ea78daa5b21();
  bundle = self.tableinfo.bundle;
  haywireduration = default_to(bundle.var_7c742af3d434b807, 0.25);
  haywireduration = getdvarfloat(@ "hash_e66e541920ac9101", haywireduration);
  data.victim waittill_any_timeout_3(haywireduration, "haywire_cleared", "haywire_max_duration", "shockstick_interrupt");
}

function function_48f07ea78daa5b21() {
  self endon("haywire_cleared");
  self endon("haywire_max_duration");

  while(true) {
    if(isPlayer(self)) {
      if(self isinexecutionvictim()) {
        self notify("shockstick_interrupt");
        break;
      }
    }

    waitframe();
  }
}

function function_a9a57668997e3c85(ishaywire, var_b121ab4966bfb436) {
  if(ishaywire) {
    val::set("haywire_controls", "sprint", 0);
    val::set("haywire_controls", "supersprint", 0);
    val::set("haywire_controls", "ads", 0);
    val::set("haywire_controls", "weapon_switch", 0);
    val::set("haywire_controls", "weapon_pickup", 0);
    val::set("haywire_controls", "ascender_use", 0);
    val::set("haywire_controls", "autoreload", 0);
    val::set("haywire_controls", "reload", 0);
    val::set("haywire_controls", "weapon_switch_clip", 0);
    val::set("haywire_controls", "melee", 0);
    val::set("haywire_controls", "offhand_throwback", 0);
    val::set("haywire_controls", "offhand_weapons", 0);
    val::set("haywire_controls", "supers", 0);
    val::set("haywire_controls", "usability", 0);
    val::set("haywire_controls", "interactions", 0);
    val::set("haywire_controls", "ladder", 0);

    if(!istrue(var_b121ab4966bfb436)) {
      val::set("haywire_controls", "mantle", 0);
    }

    return;
  }

  val::reset_all("haywire_controls");
}

function function_c927fd013fc6e502(victim) {
  level endon("game_ended");

  if(istrue(victim.ishaywire) || victim isusingremote()) {
    return;
  }

  if(isDefined(victim.carryobject)) {
    victim notify("force_manual_drop");
  }

  var_9d97a6befbeac652 = !isDefined(self.tableinfo);
  victim function_a9a57668997e3c85(1, var_9d97a6befbeac652);

  if(istrue(victim.revivingteammate)) {
    victim.var_4a2f2f50a9020e2e = 1;
  }

  victim.ishaywire = 1;
  victim setscriptablepartstate("shockStickVfx", "vfx_start", 0);

  if(!istrue(var_9d97a6befbeac652)) {
    scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_shockstick", self.owner, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
  }

  gestureref = "vm_ges_shockstick_react";
  curweapon = victim getcurrentweapon();

  if(curweapon.basename == "iw9_me_fists_mp") {
    gestureref = "vm_ges_shockstick_react_fists";
  }

  while(!victim isgestureplaying(gestureref)) {
    victimweapon = victim getcurrentweapon();

    if(isDefined(victimweapon) && victimweapon.basename != "none") {
      victim forceplaygestureviewmodel(gestureref);
    }

    waitframe();
  }

  bundle = undefined;

  if(!istrue(var_9d97a6befbeac652)) {
    bundle = self.tableinfo.bundle;

    if(istrue(bundle.var_b79e08e886b92d46)) {
      victim setempjammed(1);
      victim.var_cb886ff3371f4df8 = gettime();
    }

    if(istrue(bundle.var_d5798377c05f4edf)) {
      victim startforcedfire();
    }

    if(istrue(bundle.var_7c149d627799674)) {
      victim function_600c7c4c73c6a773(1);
    }

    movespeedscale = default_to(bundle.var_77ae83eedd8cab0c, 0.8);
  } else {
    victim setempjammed(1);
    victim.var_cb886ff3371f4df8 = gettime();
    victim startforcedfire();
    movespeedscale = 0.8;
  }

  movespeedscale = getdvarfloat(@ "hash_d677956e73b3bfb4", movespeedscale);

  if(!victim scripts\cp\utility::_hasperk("specialty_tac_resist")) {
    victim setmovespeedscale(movespeedscale);

    while(!victim isswimming() && istrue(victim.ishaywire)) {
      wait 0.1;
    }

    victim setmovespeedscale(1);
  } else {
    victim scripts\cp\perks\cp_perks::activateperk("specialty_tac_resist");
  }

  victim setempjammed(0);

  if(istrue(var_9d97a6befbeac652)) {
    victim function_600c7c4c73c6a773(0);
    return;
  }

  if(isDefined(self.tableinfo)) {
    bundle = self.tableinfo.bundle;

    if(istrue(bundle.var_7c149d627799674)) {
      victim function_600c7c4c73c6a773(0);
    }
  }
}

function function_cf082013d5205e0d(weapon) {
  weaponname = weapon.basename;

  if(function_aa6acff8443c394b(weaponname)) {
    return 1;
  }

  if(scripts\cp_mp\weapon::function_5419ac7173288fc1(weapon)) {
    return 1;
  }

  if(scripts\cp_mp\weapon::iskillstreakweapon(weapon)) {
    return 1;
  }

  if(scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(weaponname) || scripts\cp_mp\superdeploy::function_b04cbd5db8951229(weaponname)) {
    return 1;
  }

  if(scripts\cp_mp\killstreaks\helper_drone::function_8c4ab0a7799e7ab8(weapon)) {
    return 1;
  }

  return 0;
}

function function_aa6acff8443c394b(weaponname) {
  switch (weaponname) {
    case #"hash_22f1c67a16accbe":
    case #"hash_4391d14a10c9085b":
    case #"hash_5be4c94863c15240":
      return 1;
    default:
      return 0;
  }
}

function function_5e15cf3721cdcaab(shockstick) {
  self endon("death_or_disconnect");
  shockstick endon("death");
  currentweapon = undefined;

  if(scripts\cp\weapon::grenadeinpullback()) {
    currentweapon = scripts\cp_mp\weapon::getgrenadeinpullback();

    if(shockstick.owner == self && (currentweapon.basename == "shock_stick_mp" || currentweapon.basename == "jup_shock_stick_cp")) {
      return 1;
    }

    currentweapon = scripts\cp_mp\weapon::getgrenadeinpullback();

    if(!isDefined(currentweapon)) {
      currentweapon = self.currentweapon;
    }
  } else {
    currentweapon = self.currentweapon;
  }

  if(!isDefined(currentweapon) || isnullweapon(currentweapon)) {
    return 0;
  }

  ammocount = self getweaponammoclip(currentweapon);
  shouldstowweapon = function_cf082013d5205e0d(currentweapon);
  prevweapon = self.prevweaponobj;

  if(!isDefined(prevweapon)) {
    prevweapon = makeweapon("iw9_me_fists");
  }

  if(!shouldstowweapon) {
    var_87caac6bf5e569e7 = self.origin;
    equipmenttype = scripts\cp\utility::getequipmenttype(currentweapon.basename);

    if(!isDefined(equipmenttype)) {
      return 1;
    }

    if(equipmenttype == "tactical") {
      var_87caac6bf5e569e7 = self gettagorigin("tag_accessory_right");
    } else if(equipmenttype == "lethal") {
      var_87caac6bf5e569e7 = self gettagorigin("tag_accessory_left");
    }

    velocityvec = (0, 0, 0);
    velocityvec += anglesToForward(self.angles) * getdvarfloat(@ "hash_c7f7fb9ea22e108f", 200);
    velocityvec += anglestoup(self.angles) * getdvarfloat(@ "hash_b2d4c6bd7da9e85f", 100);
    scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(currentweapon, undefined, undefined, 1);
    droppedgrenade = scripts\cp\utility::_launchgrenade(currentweapon.basename, var_87caac6bf5e569e7, velocityvec);
    self setweaponammoclip(currentweapon, ammocount - 1);
    scripts\cp\weapon::grenadeinitialize(droppedgrenade, currentweapon, 0, self);
    function_54655641d3957e3(droppedgrenade);
    return 1;
  }

  return function_de0e81433eb4b20c(currentweapon);
}

function function_de0e81433eb4b20c(currentweapon) {
  if(scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(currentweapon.basename)) {
    return 0;
  }

  if(scripts\cp_mp\killstreaks\helper_drone::function_8c4ab0a7799e7ab8(currentweapon)) {
    return 0;
  }

  if(scripts\cp_mp\weapon::function_5419ac7173288fc1(currentweapon)) {
    self.var_4a2f2f50a9020e2e = 1;
    self notify("cancel_location");
    return 0;
  }

  if(currentweapon.basename == "deploy_sentry_mp") {
    self notify("equip_deploy_cancel");
    return 1;
  }

  if(function_84422a637aa542e2(currentweapon.basename)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(currentweapon, undefined, undefined, 1);
    return 1;
  }

  scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
  return 1;
}

function function_84422a637aa542e2(weaponname) {
  var_5a4002dd20a8c7b = 0;

  switch (weaponname) {
    case #"hash_22f1c67a16accbe":
    case #"hash_5be4c94863c15240":
      return 1;
    default:
      return 0;
  }
}

function shockstick_haywireagent(var_91beb5c3a5ab6910) {
  level endon("game_ended");
  victim = var_91beb5c3a5ab6910.victim;
  inflictor = var_91beb5c3a5ab6910.inflictor;
  attacker = var_91beb5c3a5ab6910.attacker;
  objweapon = var_91beb5c3a5ab6910.objweapon;

  if(victim.health > 0 && !victim scripts\asm\asm_bb::bb_isanimScripted()) {
    firstshock = gettime() > victim._blackboard.var_dc51d4ea36da3ae1 + getdvarint(@ "hash_acf5b8fed3c019");
    victim._blackboard.var_dc51d4ea36da3ae1 = gettime();

    if(victim asmhaspainstate(victim.asmname)) {
      victim asmevalpaintransition(victim.asmname);
    }

    victim setscriptablepartstate("shockStickVfx", "vfx_start", 0);
    victim.ishaywire = 1;

    if(firstshock) {
      victim dodamage(1, victim.origin, attacker, inflictor, "MOD_EXPLOSIVE", objweapon, "torso_upper");
    }
  }
}

function function_5dd66ebda239d1b(data) {
  level endon("game_ended");

  if(isDefined(data.victim.var_aa6fe6af4cbbdd47)) {
    data.victim thread[[data.victim.var_aa6fe6af4cbbdd47]](data);
  }
}

function function_46b866d198a76ddc(data, fromdeath) {
  if(istrue(data.victim.ishaywire)) {
    data.victim.ishaywire = undefined;

    if(isagent(data.victim)) {
      data.victim setscriptablepartstate("shockStickVfx", "off", 0);
    } else if(isPlayer(data.victim)) {
      data.victim thread function_6c0a9d95ebb14f2a(fromdeath);
    } else if(scripts\cp\utility\entity::isturret(data.victim)) {
      if(isDefined(data.victim.owner)) {
        data.victim.owner stopforcedfire();
      }
    } else if(isDefined(data.victim.var_2ca1a8cc9f467817)) {
      data.victim[[data.victim.var_2ca1a8cc9f467817]](data);
    }

    data.victim notify("haywire_cleared");
  }
}

function function_f100472240074998(applycallback) {
  self.var_aa6fe6af4cbbdd47 = applycallback;
}

function function_6eb20c71654fb6b4(removecallback) {
  self.var_63cf7c55a99888eb = removecallback;
}

function function_6c0a9d95ebb14f2a(fromdeath) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self stopforcedfire();
  blendouttime = getdvarfloat(@ "hash_bcf804b0535227b8", 1.3);
  self setscriptablepartstate("shockStickVfx", "off", 0);
  gestureref = "vm_ges_shockstick_react";
  curweapon = self getcurrentweapon();

  if(curweapon.basename == "iw9_me_fists_mp") {
    gestureref = "vm_ges_shockstick_react_fists";
  }

  if(!fromdeath) {
    self stopgestureviewmodel(gestureref);
    function_a9a57668997e3c85(0);
  }
}

function function_600c7c4c73c6a773(lock) {
  stance = self getstance();

  if(lock) {
    if(stance == "stand") {
      val::set("shockstick_stance", "crouch", 0);
      val::set("shockstick_stance", "prone", 0);
    } else if(stance == "crouch") {
      val::set("shockstick_stance", "stand", 0);
      val::set("shockstick_stance", "prone", 0);
    } else if(stance == "prone") {
      val::set("shockstick_stance", "crouch", 0);
      val::set("shockstick_stance", "stand", 0);
    }

    return;
  }

  val::reset_all("shockstick_stance");
}

function function_9c95c914395a9d4a(impactorigin, radius) {
  badplace = createnavbadplacebybounds(impactorigin, (radius, radius, 125), (0, 0, 0));
  return badplace;
}

function function_5d58ea6516bf050c(duration) {
  self endon("clearShockFX");
  self endon("disconnect");
  self notify("shockFX_active");
  self endon("shockFX_active");
  thread function_17adeb1fe103990d();
  wait duration;
  stopshockfx();
}

function function_17adeb1fe103990d() {
  self notify("stopShockFX");
  self endon("disconnect");
  self endon("stopShockFX");

  while(true) {
    if(!isreallyalive(self)) {
      return;
    }

    var_d0fe1a6b5a5e42b5 = !istrue(self isswimming());
    var_a576cb241180fb7f = istrue(self.var_a576cb241180fb7f);

    if(var_d0fe1a6b5a5e42b5 && var_a576cb241180fb7f) {
      if(issharedfuncdefined("damage", "dequeueCorpsetableFunc")) {
        self[[getsharedfunc("damage", "dequeueCorpsetableFunc")]]("shockStickDeath");
      }

      self.var_a576cb241180fb7f = undefined;
    } else if(!var_d0fe1a6b5a5e42b5 && !var_a576cb241180fb7f) {
      if(issharedfuncdefined("damage", "enqueueCorpsetableFunc")) {
        self[[getsharedfunc("damage", "enqueueCorpsetableFunc")]]("shockStickDeath", &function_a09639f24d4e918e);
      }

      self.var_a576cb241180fb7f = 1;
    }

    waitframe();
  }
}

function stopshockfx() {
  self notify("stopShockFX");

  if(issharedfuncdefined("damage", "dequeueCorpsetableFunc")) {
    self[[getsharedfunc("damage", "dequeueCorpsetableFunc")]]("shockStickDeath");
  }

  self.var_a576cb241180fb7f = undefined;
}

function function_a09639f24d4e918e(corpsetable) {
  corpsetable setscriptablepartstate("shockStickDeath", "vfx_start", 0);
}