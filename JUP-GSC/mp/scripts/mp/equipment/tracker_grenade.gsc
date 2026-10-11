/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\tracker_grenade.gsc
*******************************************************/

#using script_3e145703891d9d8d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace tracker_grenade;

function autoexec main() {}

function function_b46c661d38c61aa2(grenade) {
  grenade thread notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  grenade thread function_d81cd8f4d92b77bf();
  scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_tracker_grenade", self, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  grenade setotherent(self);
  grenade thread scripts\mp\damage::monitordamage(19, "hitequip", &function_ad19dd03519e7590, &function_2b0e93490c5184bb);
  scripts\cp_mp\emp_debuff::add_emp_ent(grenade);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_6572bf82bf990570);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_6572bf82bf990570);
  }

  grenade thread function_4a7db4c5bc06b7c1();
  grenade waittill("explode", position);
  thread function_7eb7507182cfbd94(position, self, grenade.bundle);
}

function private function_d81cd8f4d92b77bf() {
  self endon("death");
  self.owner endon("disconnect");
  self endon("missile_stuck");
  self waittill("missile_water_impact", var_850fdf3fb1c7eb84, var_53f81081d4e7f40b, var_71c76f81eb0c95ee);
  self.var_37d6f0688aeef75d = 1;
}

function function_7eb7507182cfbd94(position, owner, bundle) {
  level endon("game_ended");
  self endon("death");
  owner endon("disconnect");

  if(!isDefined(owner)) {
    return;
  }

  playertargets = utility::function_2d7fd59d039fa69b(position, bundle.var_59ad6b3e238b636e);

  foreach(player in playertargets) {
    if(!isreallyalive(player)) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(owner, player))) {
      continue;
    }

    if(istrue(callsharedfunc("player", "isInLastStand", player))) {
      continue;
    }

    waitframe();
    startpos = position + (0, 0, 10);

    if(!player function_c1d424f2639c370e(startpos)) {
      continue;
    }

    thread function_8613a680f1ec0b46(player, owner, bundle, startpos);
    owner thread function_b43f676666043cee(player);
  }
}

function function_b43f676666043cee(victim) {
  level endon("game_ended");
  victim waittill("tracker_projectile_result", result);

  if(istrue(result) && isPlayer(victim) && isreallyalive(victim)) {
    scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_tracker_grenade", self, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
    scripts\mp\damage::combatrecordtacticalstat("equip_tracker_grenade");
    scripts\mp\utility\stats::incpersstat("trackerGrenadeHits", 1);
  }
}

function function_a0444bbae34753bb() {
  self missilehidetrail();
  thread function_1cd780b65cb4e2e0(0.35);
}

function function_1cd780b65cb4e2e0(delay) {
  self notify("death");
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);

  if(isDefined(delay)) {
    wait delay;
  }

  self delete();
}

function function_2b0e93490c5184bb(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isbulletdamage(meansofdeath)) {
    if(isDefined(objweapon)) {
      hits = 1;

      if(damage >= scripts\mp\weapons::minegettwohitthreshold()) {
        hits += 1;
      }

      if(scripts\mp\utility\damage::isfmjdamage(objweapon, meansofdeath)) {
        hits *= 2;
      }

      damage = hits * 19;
    }
  }

  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, meansofdeath);
  return damage;
}

function function_ad19dd03519e7590(data) {
  attacker = data.attacker;

  if(isDefined(attacker) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, data.objweapon);
  }

  thread function_a0444bbae34753bb();
}

function function_6572bf82bf990570(data) {
  if(!isDefined(self.owner)) {
    return;
  }

  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, undefined, 1);
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback("");
  }

  thread function_a0444bbae34753bb();
}

function function_4a7db4c5bc06b7c1() {
  self endon("death");
  function_68d0712494ec6197();

  if(isDefined(self)) {
    thread function_a0444bbae34753bb();
  }
}

function function_68d0712494ec6197() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  while(true) {
    waitframe();
  }
}

function function_88b7b96152f86153(dangericon) {
  dangericon endon("death");
  self waittill("death");
  dangericon delete();
}