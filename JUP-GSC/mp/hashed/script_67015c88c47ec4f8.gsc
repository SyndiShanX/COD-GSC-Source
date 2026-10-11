/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_67015c88c47ec4f8.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\equipment\disguise;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\utility\player;
#namespace namespace_5011b59e71c1167f;

function function_8bfea85875208730() {
  thread function_78e92e0d2c1ad4a0();
  thread function_239121f5ed13aa9e();
  thread function_b72324b3d1d917d9();
  thread function_c7e19922ab223b93();
}

function function_3efecef2c469dfca(var_8a127de2ec4f8b49) {
  thread function_3ede6b66136c0f93(var_8a127de2ec4f8b49);
}

function function_7407394ba40e686b() {
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_disguise_destroyed", [self]);
}

function function_78e92e0d2c1ad4a0() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("disconnect");
  self waittill("death");
  self notify("disguise_state_change", "death");
}

function function_239121f5ed13aa9e() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("death_or_disconnect");
  childthread function_f5e4aa8637afb835();
}

function function_3fb0cb7d9a396243() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("weapon_fired");

    if(function_26b13dc209dedbe()) {
      self notify("disguise_state_change", "combat");
      break;
    }

    waitframe();
  }
}

function function_26b13dc209dedbe() {
  var_674daafffc0aacf3 = function_bc96cf8a43c99435();

  foreach(agent in var_674daafffc0aacf3) {
    if(agent cansee(self)) {
      agent setthreatsight(self, 1);
      agent setpatrolreact(self.origin, "med");

      if(istrue(agent.stealth_enabled)) {
        agent setstealthstate("combat");
      }

      return true;
    }
  }

  return false;
}

function function_f5e4aa8637afb835() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("grenade_thrown", grenade);
    weaponrootname = getweaponrootstring(grenade.weapon_object);
    shouldnotify = 1;

    if(function_ec0d05ac91ab5d4(weaponrootname)) {
      shouldnotify = 0;
    } else {
      shouldnotify = function_26b13dc209dedbe();
    }

    if(shouldnotify) {
      self notify("disguise_state_change", "combat");
      break;
    }

    waitframe();
  }
}

function function_fb972c00e1d438a4(weaponrootname) {
  switch (weaponrootname) {
    case #"hash_11a03a12f93f62b2":
    case #"hash_1ff8309cfb0a09c5":
    case #"hash_2ab98cab4066a74e":
    case #"hash_333525cef39d0c66":
    case #"hash_36b7174a04de8799":
    case #"hash_3c2d21aea30374d4":
    case #"hash_3cc897796b318cd9":
    case #"hash_42dcb6ce7ecb709c":
    case #"hash_8670ac083666f3a4":
    case #"hash_8747706404533493":
    case #"hash_9d57562863499a06":
    case #"hash_b7f5380094623046":
    case #"hash_b97f84c02b147504":
    case #"hash_e1f6f84e4cd950eb":
    case #"hash_fa1e80f6bd5b8e72":
    case #"hash_fb36696c0708bf42":
      return 1;
    default:
      return 0;
  }
}

function function_ec0d05ac91ab5d4(weaponrootname) {
  switch (weaponrootname) {
    case #"hash_7a494a6441a8df6":
    case #"hash_e61f1a05dec2770":
    case #"hash_13d1f84d0ae96a5f":
    case #"hash_17d5fde761fc574b":
    case #"hash_22dbe57b7df54899":
    case #"hash_26f2bb279cde043f":
    case #"hash_444e24c19329aec0":
    case #"hash_526718f50b85440e":
    case #"hash_64358af9c6c1edea":
    case #"hash_6bc36a1e4f485a79":
    case #"hash_72d6951f1472c8b3":
    case #"hash_7983828e72e83a3e":
    case #"hash_7e0a03ed7c4c87be":
    case #"hash_85d7e1863dca54c4":
    case #"hash_8ae2b02f9a08357a":
    case #"hash_a68928468343f517":
    case #"hash_c03ed6f6f4fe9dad":
    case #"hash_c749c88b18be256f":
    case #"hash_d197e38e5fa659dd":
    case #"hash_e5163523e542c46c":
    case #"hash_f219d5163a73c117":
      return 1;
    default:
      return 0;
  }
}

function function_b72324b3d1d917d9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("disguise_ended");

  while(true) {
    self waittill("disguise_state_change", statechange);

    if(function_1a0072fd9feef602(statechange)) {
      var_8a127de2ec4f8b49 = statechange == "damaged";

      if(statechange == "damaged" || statechange == "combat") {
        thread function_fcc882ac112294d();
      }

      function_3efecef2c469dfca(var_8a127de2ec4f8b49);
    }

    wait 0.1;
  }
}

function function_1a0072fd9feef602(disguisestate) {
  if(!isDefined(disguisestate)) {
    return 0;
  }

  switch (disguisestate) {
    case #"hash_62ff127829215ed0":
    case #"hash_f3194deac31f2ae6":
      return 1;
    default:
      return 0;
  }
}

function function_43207ffc5e843003() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isnullweapon(self.currentweapon) || !isDefined(self.currentweapon)) {
    return 0;
  }

  if(isincombat()) {
    return 0;
  }

  if(!isreallyalive(self)) {
    return 0;
  }

  if(isinlaststand(self)) {
    return 0;
  }

  return function_5a56d6ecb885ec19();
}

function function_15e7a42c79a6b4f6(damage, attacker) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("disguise_ended");
  thread function_fcc882ac112294d();
  var_b47e8230e27e8a6a = function_34e1df38dea3e196(damage);
  var_8c0f3022529be75e = function_3275d6441a8e838a();
  curhealth = var_8c0f3022529be75e.health;
  newhealth = curhealth - damage;
  newhealth = int(clamp(newhealth, 0, 108));
  var_8c0f3022529be75e.health = newhealth;

  if(isDefined(var_8c0f3022529be75e.backpackslot)) {
    namespace_aead94004cf4c147::function_e900e7e66383ad97(self, var_8c0f3022529be75e.backpackslot, newhealth, 0);
  }

  statemsg = ter_op(newhealth == 0, "end_disguise", "damaged");
  self notify("disguise_state_change", statemsg);

  if(statemsg == "end_disguise") {
    delaythread(getdvarfloat(@ "hash_307d1884bcaef28f", 0.45), &function_7407394ba40e686b);
  }
}

function function_34e1df38dea3e196(damage) {
  return damage;
}

function function_fcc882ac112294d(cooldowntime) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("killed_player");
  self notify("disguise_cooldown_start");
  self notify("disguise_cooldown_start");

  if(!isDefined(cooldowntime)) {
    cooldowntime = 5;
  }

  self.var_ef8c89617046f3b7 = 1;
  counter = 0;

  while(counter < cooldowntime) {
    if(isincombat()) {
      counter = 0;
    } else {
      counter += level.framedurationseconds;
    }

    waitframe();
  }

  self.var_ef8c89617046f3b7 = undefined;
}

function function_5a56d6ecb885ec19() {
  if(!isDefined(self.lastdamagedtime)) {
    return 1;
  }

  currenttime = gettime();
  var_47aed03ff4ccd04e = (currenttime - self.lastdamagedtime) / 1000;

  if(var_47aed03ff4ccd04e <= 5) {
    return 0;
  }

  return 1;
}

function function_c7e19922ab223b93() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("disguise_ended");

  while(true) {
    self waittill("execution_begin");
    scripts\mp\equipment\disguise::function_890834271f0a6fc5();
  }
}

function function_df0fe5ac51164868(event) {}