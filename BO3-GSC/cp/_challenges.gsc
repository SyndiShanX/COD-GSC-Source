/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_challenges.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_achievements;
#using scripts\cp\_decorations;
#using scripts\cp\_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace challenges;

function autoexec __init__sytem__() {
  system::register("challenges", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
  callback::on_start_gametype(&start_gametype);
}

function start_gametype() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }
  waittillframeend();
  if(canprocesschallenges()) {
    registerchallengescallback("actorKilled", &challengeactorkills);
    registerchallengescallback("actorDamaged", &function_e0360654);
    registerchallengescallback("VehicleKilled", &function_2acd9b03);
    registerchallengescallback("VehicleDamage", &challengeactorkills);
  }
  callback::on_connect(&on_player_connect);
  callback::on_connect(&function_dadf37f9);
}

function function_2acd9b03(data, time) {
  challengeactorkills(data, time);
}

function function_7d1957ed(data, time) {
  function_e0360654(data, time);
}

function function_e0360654(data, time) {
  if(isDefined(data)) {
    switch (data.weapon.rootweapon.name) {
      case "emp_grenade": {
        break;
      }
      case "ravage_core_emp_grenade":
      case "ravage_core_emp_grenade_upg": {
        if(!isDefined(data.victim.var_fcad099b) && data.victim.archetype != "human") {
          data.attacker addplayerstat("cybercom_uses_esdamage", 1);
          data.attacker addplayerstat("cybercom_uses_ravagecore", 1);
          data.victim.var_fcad099b = 1;
        }
        break;
      }
    }
  }
}

function challengeactorkills(data, time) {
  if(isDefined(data)) {
    if(isDefined(data.victim) && isDefined(data.victim.swarm)) {
      data.attacker addplayerstat("cybercom_uses_fireflies", 1);
      data.attacker thread function_96ed590f("cybercom_uses_chaos");
    }
    if(isDefined(data.attacker.hijacked_vehicle_entity)) {
      data.attacker addplayerstat("cybercom_uses_remotehijack", 1);
    }
    if(data.smeansofdeath == "MOD_GRENADE_SPLASH" || data.smeansofdeath == "MOD_ELECTROCUTED" || data.smeansofdeath == "MOD_GRENADE" || data.smeansofdeath == "MOD_EXPLOSIVE" || data.smeansofdeath == "MOD_BURNED" || data.smeansofdeath == "MOD_PROJECTILE_SPLASH") {
      if(data.weapon.rootweapon.name != "gadget_concussive_wave" && data.weapon.rootweapon.name != "hero_gravityspikes_cybercom_upgraded") {
        data.attacker addplayerstat("cybercom_uses_explosives", 1);
        if(isDefined(data.attacker.heroability)) {
          if(data.attacker.heroability.name == "gadget_immolation_upgraded" || data.attacker.heroability.name == "gadget_immolation") {
            data.attacker notify("hash_a15c319", data.victim);
          }
        }
      }
    }
    switch (data.weapon.rootweapon.name) {
      case "gadget_rapid_strike":
      case "gadget_rapid_strike_upgraded": {
        data.attacker notify("hash_e11b0770");
        data.attacker thread function_4c17acc8();
        break;
      }
      case "gadget_immolation":
      case "gadget_immolation_upgraded": {
        if(isDefined(data.victim) && isDefined(data.attacker) && !isDefined(data.victim.var_e9560d5)) {
          data.victim.var_e9560d5 = 1;
          data.attacker addplayerstat("cybercom_uses_immolation", 1);
          data.attacker thread function_8ef347b3(data.victim.origin);
        }
        break;
      }
      case "gadget_unstoppable_force":
      case "gadget_unstoppable_force_upgraded": {
        data.attacker addplayerstat("cybercom_uses_force", 1);
        data.attacker addplayerstat("cybercom_uses_martial", 1);
        break;
      }
      case "ravage_core_emp_grenade":
      case "ravage_core_emp_grenade_upg": {
        if(isDefined(data.victim) && !isDefined(data.victim.var_fcad099b)) {
          data.attacker addplayerstat("cybercom_uses_ravagecore", 1);
          data.victim.var_fcad099b = 1;
        }
        break;
      }
      case "gadget_concussive_wave":
      case "hero_gravityspikes_cybercom_upgraded": {
        if(isvehicle(data.victim)) {
          data.attacker addplayerstat("cybercom_uses_martial", 1);
          data.attacker addplayerstat("cybercom_uses_concussive", 1);
        }
        break;
      }
    }
    if(isDefined(data.attacker) && isplayer(data.attacker)) {
      data.attacker decorations::function_2bc66a34();
    }
  }
}

function function_8ef347b3(v_location) {
  self endon("death");
  self endon("hash_31573b44");
  if(!isDefined(v_location)) {
    return;
  }
  self util::delay_notify(2, "stop_catching_immolation_secondaries");
  n_start_time = gettime();
  while((gettime() - n_start_time) < 2) {
    self waittill("hash_a15c319", e_enemy);
    if(!isDefined(e_enemy)) {
      break;
    }
    if((length(v_location - e_enemy.origin)) < 200) {
      if(isDefined(e_enemy) && isDefined(self) && !isDefined(e_enemy.var_e9560d5)) {
        e_enemy.var_e9560d5 = 1;
        self addplayerstat("cybercom_uses_immolation", 1);
      }
    }
  }
}

function function_4c17acc8() {
  self endon("death");
  self endon("hash_534b9c4b");
  self util::delay_notify(2, "stop_catching_rapid_strike_attacks");
  n_start_time = gettime();
  while((gettime() - n_start_time) < 2) {
    self waittill("hash_e11b0770");
    self addplayerstat("cybercom_uses_rapidstrike", 1);
  }
}

function actorkilled(einflictor, attacker, idamage, smeansofdeath, weapon = level.weaponnone, shitloc) {
  attacker endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  waitandprocessactorkilledcallback(data);
  data.attacker notify("actorkilledchallengesprocessed");
}

function waitandprocessactorkilledcallback(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon("disconnect");
  }
  wait(0.05);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("actorKilled", data);
  level thread doscoreeventcallback("actorKilled", data);
}

function actordamaged(einflictor, attacker, idamage, weapon = level.weaponnone, shitloc) {
  attacker endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  function_2a703585(data);
  data.attacker notify("hash_3cf360d1");
}

function function_2a703585(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon("disconnect");
  }
  wait(0.05);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("actorDamaged", data);
}

function vehiclekilled(einflictor, attacker, idamage, smeansofdeath, weapon = level.weaponnone, shitloc) {
  attacker endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  function_79c2e402(data);
  data.attacker notify("hash_962e5616");
}

function function_79c2e402(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon("disconnect");
  }
  wait(0.05);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("VehicleKilled", data);
}

function vehicledamaged(einflictor, attacker, idamage, weapon = level.weaponnone, shitloc) {
  attacker endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  function_c0fc6584(data);
  data.attacker notify("hash_37eb53e2");
}

function function_c0fc6584(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon("disconnect");
  }
  wait(0.05);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("VehicleDamaged", data);
}

function function_85ec34dc() {
  self thread function_96ed590f("career_decorations");
}

function function_96ed590f(statname, n_amount = 1) {
  self endon("disconnect");
  if(!isplayer(self)) {
    return;
  }
  self addplayerstat(statname, n_amount);
}

function function_dadf37f9() {
  self.challenge_callback_cp = &function_97666686;
  self thread function_4f96d6bd();
}

function function_7fd6c70d(challenge_index) {
  return tablelookup("gamedata/stats/cp/statsmilestones3.csv", 0, challenge_index, 5);
}

function function_97666686(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex) {
  self function_5bb05b72();
  if(challengeindex == 565) {
    self givedecoration("cp_medal_all_accolades");
  }
  tier = int(tablelookup("gamedata/stats/cp/statsmilestones3.csv", 0, challengeindex, 1));
  switch (challengetype) {
    case 0: {
      challengename = function_7fd6c70d(challengeindex);
      switch (challengename) {
        case "CP_CHALLENGES_CAREER_MASTERY": {
          break;
        }
        case "CP_CHALLENGES_ALL_COMPLETE": {
          self givedecoration("cp_medal_all_calling_cards");
          break;
        }
      }
      break;
    }
    case 1: {
      if(itemindex != 0) {
        self setdstat("ItemStats", itemindex, "challengeCompleted", tier, 1);
        self achievements::checkweaponchallengecomplete(tier);
      }
      break;
    }
    case 4: {
      var_2de0b3d4 = tablelookup("gamedata/stats/cp/statsmilestones3.csv", 0, challengeindex, 13);
      self setdstat("Attachments", var_2de0b3d4, "challengeCompleted", tier, 1);
      break;
    }
  }
}

function function_5bb05b72() {
  if(sessionmodeisonlinegame()) {
    return;
  }
  var_671e7f8c = self getdstat("PlayerStatsList", "cp_challenges", "statValue");
  if(var_671e7f8c > 0) {
    var_2b0fb6af = tablelookuprowcount("gamedata/stats/cp/statsmilestones3.csv");
    challenge_data = [];
    for(i = 0; i < (var_2b0fb6af - 1); i++) {
      challenge_data = tablelookuprow("gamedata/stats/cp/statsmilestones3.csv", i);
      var_ec486758 = challenge_data[3];
      if(var_ec486758 == "global") {
        challenge_stat_name = challenge_data[4];
        if(isDefined(challenge_stat_name) && challenge_stat_name != "") {
          var_db5490e3 = self getdstat("PlayerStatsList", challenge_stat_name, "statValue");
          if(challenge_data[10] != "") {
            var_60596ad1 = int(challenge_data[2]);
            if(var_db5490e3 >= var_60596ad1) {
              var_9050c19b = "";
              var_9050c19b = challenge_data[16];
              switch (var_9050c19b) {
                case "missions": {
                  self addplayerstat("conf_gamemode_mastery", 1);
                  break;
                }
                case "tott": {
                  self addplayerstat("hq_gamemode_mastery", 1);
                  break;
                }
                case "career": {
                  self addplayerstat("career_mastery", 1);
                  break;
                }
              }
            }
          }
        }
      }
    }
    self setdstat("PlayerStatsList", "cp_challenges", "StatValue", 0);
  }
}

function function_4f96d6bd() {
  while(true) {
    if(getdvarint("", 0) == 1) {
      self function_f2d8f1d0();
      setdvar("", 0);
    }
    wait(0.1);
  }
}

function function_f2d8f1d0() {
  var_2884746a = [];
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  array::add(var_2884746a, "");
  foreach(challenge in var_2884746a) {
    self addplayerstat(challenge, 1000);
    iprintln("" + challenge);
    wait(1);
  }
}