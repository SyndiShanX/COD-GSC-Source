/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\meatshield.gsc
***********************************************/

#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#namespace meatshield;

function init() {
  setdvarifuninitialized(@ "hash_c345ae56660f18a9", 2);
  setdvarifuninitialized(@ "hash_5e634bc109c427be", 10000);
  setdvarifuninitialized(@ "hash_325e0d531141e772", 500);
  setdvarifuninitialized(@ "hash_28aaa289c1be569", 5000);
  setdvarifuninitialized(@ "hash_933400a8bdb6c6c9", 0);
  setdvarifuninitialized(@ "hash_c06ce4e11c644c9b", 1);

  thread function_23f1fe988c0500d1();
}

function function_8f2f9f02b630ed27() {
  player = self;
  player.meatshielddamagetaken = 0;
  player.var_57685043ac8c8721 = 0;
  player.var_5a36dc72bf7db414 = 0;
  thread function_8562e6b396459b10();
  thread function_aaf92259b5005889();
}

function function_8562e6b396459b10() {
  self endon("disconnect");
  level endon("game_ended");
  player = self;

  while(true) {
    player waittill("meatshield_victim_start");
    function_a29f3f8e24309d49();
    player thread function_3f6c57b19f80fbd9();
    player waittill("meatshield_victim_stop");
    function_139a67a31afc452b();
  }
}

function function_3f6c57b19f80fbd9() {
  self endon("meatshield_victim_stop");
  self endon("disconnect");
  level endon("game_ended");
  player = self;
  var_9acb83ae781d5fb4 = (player.var_57685043ac8c8721 - player.var_5a36dc72bf7db414) * 0.001;
  damagepersecond = player.var_423a9f9e23833f65 / (var_9acb83ae781d5fb4 + 1);

  while(true) {
    tickdamagemode = getdvarint(@ "hash_c345ae56660f18a9", 2);

    if(tickdamagemode == 1) {
      if(player.var_5a36dc72bf7db414 < gettime()) {
        function_afdf3e6cbe0522d7(damagepersecond, 0);
      }
    } else if(tickdamagemode == 2) {
      if(player.var_57685043ac8c8721 < gettime()) {
        function_afdf3e6cbe0522d7(player.var_423a9f9e23833f65, 0);
      }
    }

    wait 1;
  }
}

function function_a29f3f8e24309d49() {
  player = self;
  player.meatshielddamagetaken = 0;
  player.var_57685043ac8c8721 = gettime() + getdvarint(@ "hash_5e634bc109c427be", 10000);
  player.var_423a9f9e23833f65 = getdvarint(@ "hash_325e0d531141e772", 500);
  player.var_5a36dc72bf7db414 = gettime() + getdvarint(@ "hash_28aaa289c1be569", 5000);
  player.var_5a36dc72bf7db414 = min(player.var_5a36dc72bf7db414, player.var_57685043ac8c8721);
  player function_90c280e11232303b(0);
}

function function_139a67a31afc452b() {
  player = self;
  player.meatshieldhealth = 0;
  player.var_5a36dc72bf7db414 = 0;
  player.var_57685043ac8c8721 = 0;
  player.meatshielddamagetaken = 0;
  player function_90c280e11232303b(1);
}

function function_90c280e11232303b(enabled) {
  self allowprone(enabled);
  self allowcrouch(enabled);
  val::set("meatshield", "killstreaks", enabled);
}

function function_afdf3e6cbe0522d7(damage, instantkill) {
  player = self;
  player.meatshielddamagetaken += damage;

  if(player.meatshielddamagetaken >= player.var_423a9f9e23833f65) {
    player.meatshielddamagetaken = 0;
    player stopmeatshield(1, instantkill);
  }
}

function function_aaf92259b5005889() {
  self endon("disconnect");
  level endon("game_ended");
  player = self;

  while(true) {
    player waittill("meatshield_attacker_start");
    function_7e80a2f5d64a4196();
    player waittill("meatshield_attacker_stop");
    function_a7db18d919050692();
  }
}

function function_7e80a2f5d64a4196() {
  player = self;
  player function_d8aeb1fac2d32123();
  player val::set("meatshield", "killstreaks", 0);
  level notify("uav_update");
}

function function_a7db18d919050692() {
  player = self;
  player function_7b59a9e133d4cb45();
  player val::set("meatshield", "killstreaks", 1);
  level notify("uav_update");
}

function function_d8aeb1fac2d32123() {
  player = self;

  if(!player function_1dc5d0827fd48729()) {
    player.switchweapon = player getcurrentweapon();
    var_a6a2e5fe25ca0f2b = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("t10_pi_p13_usugar9_mp");
    player giveweapon(var_a6a2e5fe25ca0f2b);
    player.var_121bfda4d22eca4 = var_a6a2e5fe25ca0f2b;
  }
}

function function_7b59a9e133d4cb45() {
  player = self;

  if(isDefined(player.var_121bfda4d22eca4)) {
    player takeweapon(player.var_121bfda4d22eca4);
    player.var_121bfda4d22eca4 = undefined;
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.switchweapon);
    player.switchweapon = undefined;
  }
}

function function_10de2964abd64e1f() {
  if(scripts\mp\gameobjects::function_781844c0c05b5ac7()) {
    return true;
  }

  if(!self function_fc05ebabfbf10e33()) {
    return true;
  }

  if(getdvarint(@ "hash_933400a8bdb6c6c9", 0) == 1) {
    return true;
  }

  return false;
}

function function_23f1fe988c0500d1() {
  setdevdvarifuninitialized(@ "hash_752231be3b803e3d", -1);
  setdevdvarifuninitialized(@ "hash_ec059bc7573bd896", -1);
  var_be7af47bf33d6b22 = [];

  while(true) {
    wait 1;
    attackerentnum = getdvarint(@ "hash_752231be3b803e3d", -1);
    victimentnum = getdvarint(@ "hash_ec059bc7573bd896", -1);

    if(attackerentnum == -2 || victimentnum == -2) {
      for(i = 0; i < var_be7af47bf33d6b22.size; i++) {
        victim = var_be7af47bf33d6b22[i].victim;
        attacker = var_be7af47bf33d6b22[i].attacker;

        if(!isDefined(victim) || !isDefined(attacker) || !isPlayer(victim) || !isPlayer(attacker)) {
          continue;
        }

        if(victim function_fc05ebabfbf10e33() && attacker function_a237aba99cf26050()) {
          victim stopmeatshield(0, 0);
        }
      }

      attackerentnum = setDvar(@ "hash_752231be3b803e3d", -1);
      victimentnum = setDvar(@ "hash_ec059bc7573bd896", -1);
      var_be7af47bf33d6b22 = [];
      continue;
    }

    if(attackerentnum == -1 || victimentnum == -1) {
      continue;
    }

    victiment = getentbynum(victimentnum);
    attackerent = getentbynum(attackerentnum);

    if(!isDefined(victiment) || !isDefined(attackerent) || !isPlayer(victiment) || !isPlayer(attackerent)) {
      continue;
    }

    var_11074bfcf9ce9e2b = spawnStruct();
    var_11074bfcf9ce9e2b.attacker = attackerent;
    var_11074bfcf9ce9e2b.victim = victiment;
    var_be7af47bf33d6b22 = scripts\engine\utility::array_add(var_be7af47bf33d6b22, var_11074bfcf9ce9e2b);
    victiment function_50d80b68bdd765d9(attackerent);
    attackerentnum = setDvar(@ "hash_752231be3b803e3d", -1);
    victimentnum = setDvar(@ "hash_ec059bc7573bd896", -1);
  }
}

# /