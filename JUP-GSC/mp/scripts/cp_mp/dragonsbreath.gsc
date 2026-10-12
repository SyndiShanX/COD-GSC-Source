/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\dragonsbreath.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\dragonsbreath;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;
#using scripts\mp\weapons;
#namespace dragonsbreath;

function function_df4e9a1e313ea352() {
  dragonsbreathdamage = spawnStruct();
  dragonsbreathdamage.newhitlocs = [];
  dragonsbreathdamage.hitslocs = [];
  dragonsbreathdamage.burningstate = "neutral";
  return dragonsbreathdamage;
}

function function_6dc8c5de229e86ff(newhitlocs, attacker, objweapon) {
  foreach(part in newhitlocs) {
    if(isshield(part)) {
      newhitlocs = array_remove(newhitlocs, part);
    }
  }

  if(newhitlocs.size == 0) {
    return;
  }

  thread function_a0888e06aa555932(newhitlocs, attacker, objweapon);
}

function function_56a694363da738ac(objweapon) {
  corpsetable = self getcorpseentity();

  if(!isDefined(corpsetable)) {
    return;
  }

  function_a1b485fd94771e09(objweapon);
  corpsetable setscriptablepartstate(self.dragonsbreathdamage.scriptablepart, "flareUp", 0);
}

function function_9fd9dc9d9d3a0bc4() {
  self notify("stop_dragonsbreathDamage");
  self.dragonsbreathdamage = function_df4e9a1e313ea352();
}

function function_a0888e06aa555932(newburningparts, attacker, objweapon) {
  self notify("newBurningParts");
  self endon("disconnect");
  self endon("newBurningParts");
  self endon("stop_dragonsbreathDamage");
  newburningparts = array_remove_duplicates(newburningparts);

  foreach(part in newburningparts) {
    if(isDefined(self.dragonsbreathdamage.hitslocs[part])) {
      self.dragonsbreathdamage.hitslocs[part] += 0.5;

      if(getweaponhasperk(objweapon, "specialty_ub_flamethrower")) {
        self.dragonsbreathdamage.hitslocs[part] = min(self.dragonsbreathdamage.hitslocs[part], 1);
      } else {
        self.dragonsbreathdamage.hitslocs[part] = min(self.dragonsbreathdamage.hitslocs[part], 4);
      }

      continue;
    }

    self.dragonsbreathdamage.hitslocs[part] = 0.5;
  }

  function_a1b485fd94771e09(objweapon);
  function_f21bfcf42e2f3e8b();

  while(true) {
    wait 0.25;

    if(!isreallyalive(self) || self.dragonsbreathdamage.hitslocs.size == 0) {
      break;
    }

    statechange = 0;
    function_8b5ae6ab700339f8(attacker, objweapon);

    foreach(key, hitsloc in self.dragonsbreathdamage.hitslocs) {
      self.dragonsbreathdamage.hitslocs[key] -= 0.25;

      if(self.dragonsbreathdamage.hitslocs[key] <= 0) {
        self.dragonsbreathdamage.hitslocs = array_remove_key(self.dragonsbreathdamage.hitslocs, key);
        statechange = 1;
      }
    }

    if(statechange) {
      function_a1b485fd94771e09(objweapon);
      function_f21bfcf42e2f3e8b();
    }
  }
}

function function_8b5ae6ab700339f8(attacker, objweapon) {
  if(isDefined(attacker) && isalive(attacker)) {
    attacker endon("death");
    var_9becaeedb8c6bf2c = makeweapon("dragonsbreath_mp");
    attacker function_49967318fbd12317(var_9becaeedb8c6bf2c, objweapon);
    var_3315791b141386c1 = 10 * 0.5;
    numevents = min(self.dragonsbreathdamage.hitslocs.size, 3);
    var_76e563db5d11a0ea = int(var_3315791b141386c1 * numevents);

    if(getweaponhasperk(objweapon, "specialty_ub_flamethrower")) {
      var_3315791b141386c1 = 4 * 0.5;
      var_76e563db5d11a0ea = int(var_3315791b141386c1 * numevents);
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
      var_76e563db5d11a0ea = 2;
    }

    if(var_76e563db5d11a0ea > 0) {
      self dodamage(var_76e563db5d11a0ea, attacker.origin, attacker, attacker, "MOD_FIRE", var_9becaeedb8c6bf2c, "torso_upper");
    }
  }
}

function function_a1b485fd94771e09(objweapon) {
  self.dragonsbreathdamage.scriptablepart = "burning";

  if(isDefined(objweapon) && isDefined(objweapon.underbarrel)) {
    if(objweapon.underbarrel == "jup_ub_flame_01" && objweapon.underbarrelvarindex == 5) {
      self.dragonsbreathdamage.scriptablepart = "virus";
    }
  }

  if(!self getscriptablehaspart(self.dragonsbreathdamage.scriptablepart)) {
    self.dragonsbreathdamage.scriptablepart = "burning";
  }
}

function function_f21bfcf42e2f3e8b() {
  burningstate = "";
  points = [];
  points["al_"] = 0;
  points["to_"] = 0;
  points["ar_"] = 0;
  points["ll_"] = 0;
  points["lr"] = 0;

  if(!isDefined(self.dragonsbreathdamage)) {
    return;
  }

  hitlocs = self.dragonsbreathdamage.hitslocs;

  if(isDefined(self.var_7e2abe421347dd30)) {
    foreach(damagestruct in self.var_7e2abe421347dd30) {
      if(!isDefined(hitlocs[damagestruct.hitloc])) {
        hitlocs[damagestruct.hitloc] = 1;
        continue;
      }

      hitlocs[damagestruct.hitloc] += 1;
    }
  }

  if(isDefined(self.dragonsbreathdamage.var_7b9feffaafce932)) {
    foreach(burningparts in self.dragonsbreathdamage.var_7b9feffaafce932) {
      if(!isDefined(hitlocs[burningparts])) {
        hitlocs[burningparts] = 2;
        continue;
      }

      hitlocs[burningparts] += 1;
    }
  }

  foreach(hitlocname, hitlocvalue in hitlocs) {
    burningpart = function_3d9255af28a82f08(hitlocname);

    if(isDefined(burningpart)) {
      points[burningpart] += hitlocvalue;
    }

    if(!isDefined(burningpart)) {
      assertmsg("<dev string:x1c>");
    }
  }

  if(points["al_"] > 0 || points["to_"] >= 2) {
    burningstate += "al_";
  }

  if(points["to_"] > 0 || points["al_"] >= 2 || points["ar_"] >= 2) {
    burningstate += "to_";
  }

  if(points["ar_"] > 0 || points["to_"] >= 2) {
    burningstate += "ar_";
  }

  if(points["ll_"] > 0 || points["lr"] >= 2) {
    burningstate += "ll_";
  }

  if(points["lr"] > 0 || points["ll_"] >= 2) {
    burningstate += "lr";
  }

  if(burningstate == "al_to_ar_ll_" || burningstate == "al_to_ar_lr" || burningstate == "al_to_ll_lr" || burningstate == "al_ar_ll_lr" || burningstate == "to_ar_ll_lr" || burningstate == "al_to_ar_ll_lr") {
    burningstate = "all_parts";
  } else if(burningstate == "") {
    burningstate = "neutral";
  }

  if(burningstate != self.dragonsbreathdamage.burningstate) {
    if(burningstate == "neutral") {
      scripts\mp\weapons::disableburnfx(1, self.dragonsbreathdamage.burningstate, self.dragonsbreathdamage.scriptablepart);
    } else {
      scripts\mp\weapons::enableburnfx(1, burningstate, self.dragonsbreathdamage.scriptablepart);
    }

    self.dragonsbreathdamage.burningstate = burningstate;
  }
}

function function_3d9255af28a82f08(hitloc) {
  switch (hitloc) {
    case #"hash_8a1772f5f912c880":
      return "to_";
    case #"hash_b107b5547c755d23":
      return "to_";
    case #"hash_92bbfe494d03d772":
      return "to_";
    case #"hash_b275b50677dcf6cb":
      return "to_";
    case #"hash_fbb61fc356f3c75e":
      return "to_";
    case #"hash_d42e71cd9f1e822f":
      return "ar_";
    case #"hash_51d5d0b9add9cc5a":
      return "al_";
    case #"hash_5d5aac570f6fd382":
      return "ar_";
    case #"hash_a7980c387477e7bb":
      return "al_";
    case #"hash_da2f35145aa58933":
      return "ar_";
    case #"hash_da51cc36a471058":
      return "al_";
    case #"hash_1cbc508a2fe01b79":
      return "lr";
    case #"hash_810a7426c8bac3ac":
      return "ll_";
    case #"hash_a638fec9040cfcf4":
      return "lr";
    case #"hash_7b36142458a6c2d5":
      return "ll_";
    case #"hash_9536712388e65bce":
      return "lr";
    case #"hash_168c74e879f0ba11":
      return "ll_";
  }
}

function isdragonsbreathweapon(objweapon) {
  if(istrue(objweapon.isalternate)) {
    if(getweaponhasperk(objweapon, "specialty_incendiary_alt")) {
      return true;
    }

    if(getweaponhasperk(objweapon, "specialty_ub_flamethrower")) {
      return true;
    }
  } else if(getweaponhasperk(objweapon, "specialty_incendiary")) {
    return true;
  }

  return false;
}

function function_cfd2e1e48edaf93(objweapon) {
  if(!istrue(objweapon.isalternate)) {
    if(objweapon.basename == "dragonsbreath_mp") {
      return true;
    }
  }

  return false;
}

function isshield(hitloc) {
  if(hitloc == "shield") {
    return 1;
  }

  return 0;
}

function function_c206c109a26f598(idamage, attacker, objweapon, hitloc) {
  if(!isDefined(self.var_7e2abe421347dd30)) {
    self.var_7e2abe421347dd30 = [];
  }

  if(!isDefined(self.dragonsbreathdamage)) {
    self.dragonsbreathdamage = scripts\cp_mp\dragonsbreath::function_df4e9a1e313ea352();
  }

  basedamage = idamage * getdvarfloat(@ "hash_ba97c3be3b58a828", 0.2);
  ticksleft = getdvarint(@ "hash_632c2d7b6b4c3771", 2);
  damagetime = getdvarfloat(@ "hash_a55cc107911a0ce0", 0.75);
  var_60d435c6357875ea = damagetime / ticksleft;
  damagestruct = spawnStruct();
  damagestruct.ticksleft = ticksleft;
  damagestruct.var_76e563db5d11a0ea = round(basedamage / damagestruct.ticksleft);
  damagestruct.attacker = attacker;
  damagestruct.objweapon = objweapon;
  damagestruct.hitloc = hitloc;
  self.var_7e2abe421347dd30[self.var_7e2abe421347dd30.size] = damagestruct;
  thread function_1a50056b16521c9e(attacker, var_60d435c6357875ea);
}

function function_1a50056b16521c9e(attacker, var_60d435c6357875ea) {
  self notify("db_damage");
  self endon("db_damage");
  self endon("death_or_disconnect");
  self.var_35116e057346139e = 1;
  function_f21bfcf42e2f3e8b();
  var_9becaeedb8c6bf2c = makeweapon("dragonsbreath_mp");
  initialwait = getdvarfloat(@ "hash_de9e421a9bb5c99a", 0.3);
  wait initialwait;

  while(isDefined(self.var_7e2abe421347dd30) && self.var_7e2abe421347dd30.size > 0) {
    var_5ae1ceeb2401dbd5 = self.var_7e2abe421347dd30[0];

    while(var_5ae1ceeb2401dbd5.ticksleft > 0 && isDefined(var_5ae1ceeb2401dbd5.attacker)) {
      wait var_60d435c6357875ea;
      damage = 0;

      for(i = 0; i < self.var_7e2abe421347dd30.size; i++) {
        attacker = self.var_7e2abe421347dd30[i].attacker;
        objweapon = self.var_7e2abe421347dd30[i].objweapon;
        hitloc = self.var_7e2abe421347dd30[i].hitloc;

        if(isDefined(attacker)) {
          attacker function_49967318fbd12317(var_9becaeedb8c6bf2c, objweapon);
          damage = self.var_7e2abe421347dd30[i].var_76e563db5d11a0ea;
          self dodamage(damage, attacker.origin, attacker, attacker, "MOD_FIRE", var_9becaeedb8c6bf2c, "torso_lower");
          self.var_7e2abe421347dd30[i].ticksleft--;
        }
      }
    }

    self.var_7e2abe421347dd30 = array_remove(self.var_7e2abe421347dd30, var_5ae1ceeb2401dbd5);
    function_f21bfcf42e2f3e8b();
    waitframe();
  }

  function_d36940aa00b20558();
  function_f21bfcf42e2f3e8b();
}

function function_22d1fced237d6878() {
  self notify("db_damage");
  function_d36940aa00b20558();
}

function function_d36940aa00b20558() {
  self.var_7e2abe421347dd30 = undefined;
  self.var_35116e057346139e = undefined;
}

function function_5a05899bb304a6d4(hitloc, burningtime) {
  if(!isPlayer(self)) {
    return;
  }

  note = "crossbowBurning" + hitloc;
  self notify(note);
  self endon(note);
  self endon("death_or_disconnect");
  self endon("stop_dragonsbreathDamage");

  if(!isDefined(self.dragonsbreathdamage)) {
    self.dragonsbreathdamage = scripts\cp_mp\dragonsbreath::function_df4e9a1e313ea352();
  }

  if(!isDefined(self.dragonsbreathdamage.var_7b9feffaafce932)) {
    self.dragonsbreathdamage.var_7b9feffaafce932 = [];
  }

  self.dragonsbreathdamage.var_7b9feffaafce932 = array_add(self.dragonsbreathdamage.var_7b9feffaafce932, hitloc);
  function_f21bfcf42e2f3e8b();
  wait burningtime;

  if(isDefined(self) && isDefined(self.dragonsbreathdamage) && isDefined(self.dragonsbreathdamage.var_7b9feffaafce932)) {
    self.dragonsbreathdamage.var_7b9feffaafce932 = array_remove(self.dragonsbreathdamage.var_7b9feffaafce932, hitloc);
  }

  function_f21bfcf42e2f3e8b();
}