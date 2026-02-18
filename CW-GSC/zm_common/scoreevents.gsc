/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\scoreevents.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_challenges;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace scoreevents;

function private autoexec __init__system__() {
  system::register(#"scoreevents", &preinit, &init, undefined, undefined);
}

function private preinit() {
  registerscoreeventcallback("scoreEventZM", &scoreeventzm);
  registerscoreeventcallback("killingBlow", &function_970a97b2);
  level.var_c90fb58a = [];

  for(i = 0; i < 4; i++) {
    new_throttle = new class_c6c0e94();
    [[new_throttle]] - > initialize(#"hash_489786730d0b07be", 2, float(function_60d95f53()) / 1000);
    level.var_c90fb58a[level.var_c90fb58a.size] = new_throttle;
  }

  level.var_1acb0192 = &function_7d26a389;
  level.var_4bcd94b = [];
  level.var_42648a02 = [# "hash_3e68a28d3c2e0479": [0, 0.15, #"hash_1561254978f7d1ed", 750, undefined], #"hash_25f082a4f62ed553": [0, 0.15, #"hash_d6e9cf445a840a", 750, undefined], #"hash_46c54199043c3149": [1000, 0.15, #"se_vehiclekill", 1000, undefined], #"hash_4efbe7fdd1c5873d": [2000, 0.35, #"hash_4d97a2cf6c712d4e", 1000, 2], #"hash_2bdba8dd04a772a9": [3000, 0.85, #"hash_7e2f32f691207aca", 1000, 2], #"hash_7d61681b4a86f9c1": [4000, 1, #"hash_56bc9b3d6947b8b6", 1000, 1], #"satchel_charge_multikill_zm": [2000, 0.85, "SE_SatchelChargeMultikill", 1500, 2], #"nightengale_multikill_zm": [2000, 0.85, "SE_NightingaleMultikill", 1500, 2], #"frag_multikill_zm": [2000, 0.85, "SE_FragMultikill", 1500, 2], #"molotov_multikill_zm": [2000, 0.85, "SE_MolotovCocktailMultikill", 1500, 2], #"semtex_multikill_zm": [2000, 0.85, "SE_SemtexMultikill", 1500, 2], #"concussion_grenade_multikill_zm": [2000, 0.85, "SE_ConcussionGrenadeMultikill", 1500, 2], #"monkey_bomb_multikill_zm": [2000, 0.85, #"hash_28808125fce8c8e7", 1500, 1], #"multikillstreak_5_zm": [1800, 0.6, #"hash_4bd8ffae8d5281c9", 1500, 2], #"multikillstreak_10_zm": [1900, 0.6, #"hash_3449e69a233e305f", 1500, 2], #"multikillstreak_15_zm": [2500, 0.6, #"hash_3449e19a233e27e0", 1500, 1], #"multikillstreak_20_zm": [3100, 0.65, #"hash_343f749a23351a24", 2000, 1], #"multikillstreak_25_zm": [3200, 0.75, #"hash_343f719a2335150b", 2000, 1], #"crit_finisher_multikill_zm": [1850, 0.85, #"hash_406609dcd40a348e", 1000, 2], #"oneshot_multikill_zm": [1950, 0.85, #"hash_31d075ffaf2c230a", 1000, 2], #"oneshot_explosive_multikill_zm": [1950, 0.85, #"hash_68d4ef9c937aa223", 1000, 2], #"melee_weapon_multikill_zm": [2000, 0.85, #"hash_6b704db2e152d216", 1000, 2], #"aether_shroud_multikill_zm": [2000, 0.85, #"hash_3e454dbd28a162b0", 1500, 2], #"energy_mine_multikill_zm": [2000, 0.85, #"hash_2af4d13403d833e5", 1250, 2], #"frost_blast_multikill_zm": [2000, 0.85, #"hash_2d45724fc1a86740", 1500, 2], #"healing_aura_multikill_zm": [2000, 0.85, #"hash_684963f03f8a86a5", 1500, 2], #"ring_of_fire_multikill_zm": [2000, 0.85, #"hash_5dc5c0d8c259c02d", 1500, 2], #"frenzied_guard_multikill_zm": [2000, 0.85, #"hash_62579373c5d67ce0", 1500, 2], #"toxic_growth_multikill_zm": [2000, 0.85, #"hash_541ae7332eba41be", 1500, 2], #"tesla_storm_multikill_zm": [2000, 0.85, #"hash_6e779060a26706e1", 1500, 2], #"ieu_multikill_zm": [2000, 0.58, #"hash_394f4a59df1d0c17", 1250, 1], #"hash_18e3e5b441fb51b0": [2000, 0.58, #"hash_394f4a59df1d0c17", 1250, 1], #"ray_rifle_multikill_zm": [2000, 0.9, #"hash_394f4a59df1d0c17", 1250, 1], #"crystal_axe_blade_multikill_zm": [2000, 0.9, #"hash_35b4f1037b7d4ed1", 1250, 1], #"crystal_axe_shardshooter_multikill_zm": [2000, 0.9, #"hash_35b4f1037b7d4ed1", 1250, 1]];
}

function function_7d26a389(var_42648a02) {
  var_f6ba1c32 = isDefined(var_42648a02[1]) ? var_42648a02[1] : 1;
  n_round = zm_utility::get_round_number();

  if(var_f6ba1c32 == 0) {
    return 0;
  }

  if(isDefined(var_42648a02[2]) && zm_vo::function_384269f(var_42648a02[2])) {
    if(n_round < 5) {
      var_f6ba1c32 = 0.75 / var_f6ba1c32;
    } else if(n_round >= 5 && n_round < 10) {
      var_f6ba1c32 = 0.6 / var_f6ba1c32;
    } else if(n_round >= 10 && n_round < 15) {
      var_f6ba1c32 = 0.5 / var_f6ba1c32;
    } else {
      var_f6ba1c32 = 0.3 / var_f6ba1c32;
    }
  } else {
    var_f6ba1c32 = 13 / (13 + n_round);
  }

  return var_f6ba1c32;
}

function init() {
  function_af57ad40();
}

function function_af57ad40() {
  function_9451b95c(#"hatchet", "hatchet_killingblow_zm", "hatchet_killingblow_special_zm", "hatchet_killingblow_elite_zm");
  function_9451b95c(#"frag_grenade", "frag_killingblow_zm", "frag_killingblow_special_zm", "frag_killingblow_elite_zm");
  function_9451b95c(#"eq_sticky_grenade", "semtex_killingblow_zm", "semtex_killingblow_special_zm", "semtex_killingblow_elite_zm");
  function_9451b95c(#"satchel_charge", "satchel_charge_killingblow_zm", "satchel_charge_killingblow_special_zm", "satchel_charge_killingblow_elite_zm");
  function_9451b95c(#"cymbal_monkey", "monkey_bomb_killingblow_zm", "monkey_bomb_killingblow_zm", "monkey_bomb_killingblow_zm");
  function_9451b95c(#"molotov_fire", "molotov_killingblow_zm", "molotov_killingblow_special_zm", "molotov_killingblow_elite_zm");
  function_9451b95c(#"eq_slow_grenade", "concussion_grenade_killingblow_zm", "concussion_grenade_killingblow_special_zm", "concussion_grenade_killingblow_elite_zm");
  function_9451b95c(#"gun_ultimate_turret", "sentry_turret_kill_zm", "sentry_turret_special_kill_zm", "sentry_turret_elite_kill_zm");
  function_9451b95c(#"sig_lmg", "death_machine_kill_zm", "death_machine_special_kill_zm", "death_machine_elite_kill_zm");
  function_9451b95c(#"hero_flamethrower", "flamethrower_kill_zm", "flamethrower_special_kill_zm", "flamethrower_elite_kill_zm");
  function_9451b95c(#"hero_pineapplegun", "grenade_launcher_kill_zm", "grenade_launcher_special_kill_zm", "grenade_launcher_elite_kill_zm");
  function_9451b95c(#"remote_missile", "cruise_missile_kill_zm", "cruise_missile_kill_special_zm", "cruise_missile_kill_elite_zm");
  function_9451b95c(#"remote_missile_missile", "cruise_missile_kill_zm", "cruise_missile_kill_special_zm", "cruise_missile_kill_elite_zm");
  function_9451b95c(#"remote_missile_bomblet", "cruise_missile_kill_zm", "cruise_missile_kill_special_zm", "cruise_missile_kill_elite_zm");
  function_9451b95c(#"sig_bow_flame", "combat_bow_kill_zm", "combat_bow_special_kill_zm", "combat_bow_elite_kill_zm");
  function_9451b95c(#"hash_1734871fef9c0549", "chopper_gunner_kill_zm", "chopper_gunner_kill_special_zm", "chopper_gunner_kill_elite_zm");
  function_9451b95c(#"hero_annihilator", "hand_cannon_kill_zm", "hand_cannon_special_kill_zm", "hand_cannon_elite_kill_zm");
  function_9451b95c(#"recon_car_zm", "arcxd_kill_zm", "arcxd_special_kill_zm", "arcxd_elite_kill_zm");
  function_9451b95c(#"planemortar", "artillery_strike_kill_zm", "artillery_strike_kill_special_zm", "artillery_strike_kill_elite_zm");
  function_9451b95c(#"napalm_strike", "napalm_strike_kill_zm", "napalm_strike_kill_special_zm", "napalm_strike_kill_elite_zm");
  function_9451b95c(#"hash_6a4dd5ed56f6e3f6", "lt53_kazimir_portal_kill_zm", "lt53_kazimir_portal_kill_special_zm", "lt53_kazimir_portal_kill_elite_zm");
  function_9451b95c(#"energy_mine", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"energy_mine_1", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"energy_mine_2", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"energy_mine_3", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"energy_mine_4", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"energy_mine_5", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"hash_7e4053e6965bafa7", "energy_mine_kill_zm", "energy_mine_kill_special_zm", "energy_mine_kill_elite_zm");
  function_9451b95c(#"frost_blast", "frost_blast_kill_zm", "frost_blast_kill_special_zm", "frost_blast_kill_elite_zm");
  function_9451b95c(#"frost_blast_1", "frost_blast_kill_zm", "frost_blast_kill_special_zm", "frost_blast_kill_elite_zm");
  function_9451b95c(#"frost_blast_2", "frost_blast_kill_zm", "frost_blast_kill_special_zm", "frost_blast_kill_elite_zm");
  function_9451b95c(#"frost_blast_3", "frost_blast_kill_zm", "frost_blast_kill_special_zm", "frost_blast_kill_elite_zm");
  function_9451b95c(#"frost_blast_4", "frost_blast_kill_zm", "frost_blast_kill_special_zm", "frost_blast_kill_elite_zm");
  function_9451b95c(#"frost_blast_5", "frost_blast_kill_zm", "frost_blast_kill_special_zm", "frost_blast_kill_elite_zm");
  function_9451b95c(#"ring_of_fire", "ring_of_fire_burn_finisher_zm", "ring_of_fire_burn_finisher_special_zm", "ring_of_fire_burn_finisher_elite_zm");
  function_9451b95c(#"ring_of_fire_1", "ring_of_fire_burn_finisher_zm", "ring_of_fire_burn_finisher_special_zm", "ring_of_fire_burn_finisher_elite_zm");
  function_9451b95c(#"ring_of_fire_2", "ring_of_fire_burn_finisher_zm", "ring_of_fire_burn_finisher_special_zm", "ring_of_fire_burn_finisher_elite_zm");
  function_9451b95c(#"ring_of_fire_3", "ring_of_fire_burn_finisher_zm", "ring_of_fire_burn_finisher_special_zm", "ring_of_fire_burn_finisher_elite_zm");
  function_9451b95c(#"ring_of_fire_4", "ring_of_fire_burn_finisher_zm", "ring_of_fire_burn_finisher_special_zm", "ring_of_fire_burn_finisher_elite_zm");
  function_9451b95c(#"ring_of_fire_5", "ring_of_fire_burn_finisher_zm", "ring_of_fire_burn_finisher_special_zm", "ring_of_fire_burn_finisher_elite_zm");
  function_9451b95c(#"toxic_growth", "toxic_growth_poison_finisher_zm", "toxic_growth_poison_special_finisher_zm", "toxic_growth_poison_elite_finisher_zm");
  function_9451b95c(#"toxic_growth_1", "toxic_growth_poison_finisher_zm", "toxic_growth_poison_special_finisher_zm", "toxic_growth_poison_elite_finisher_zm");
  function_9451b95c(#"toxic_growth_2", "toxic_growth_poison_finisher_zm", "toxic_growth_poison_special_finisher_zm", "toxic_growth_poison_elite_finisher_zm");
  function_9451b95c(#"toxic_growth_3", "toxic_growth_poison_finisher_zm", "toxic_growth_poison_special_finisher_zm", "toxic_growth_poison_elite_finisher_zm");
  function_9451b95c(#"toxic_growth_4", "toxic_growth_poison_finisher_zm", "toxic_growth_poison_special_finisher_zm", "toxic_growth_poison_elite_finisher_zm");
  function_9451b95c(#"toxic_growth_5", "toxic_growth_poison_finisher_zm", "toxic_growth_poison_special_finisher_zm", "toxic_growth_poison_elite_finisher_zm");
  function_9451b95c(#"lightning_links", "tesla_storm_stun_finisher_zm", "tesla_storm_stun_finisher_special_zm", "tesla_storm_stun_finisher_elite_zm");
  function_9451b95c(#"lightning_links_1", "tesla_storm_stun_finisher_zm", "tesla_storm_stun_finisher_special_zm", "tesla_storm_stun_finisher_elite_zm");
  function_9451b95c(#"lightning_links_2", "tesla_storm_stun_finisher_zm", "tesla_storm_stun_finisher_special_zm", "tesla_storm_stun_finisher_elite_zm");
  function_9451b95c(#"lightning_links_3", "tesla_storm_stun_finisher_zm", "tesla_storm_stun_finisher_special_zm", "tesla_storm_stun_finisher_elite_zm");
  function_9451b95c(#"lightning_links_4", "tesla_storm_stun_finisher_zm", "tesla_storm_stun_finisher_special_zm", "tesla_storm_stun_finisher_elite_zm");
  function_9451b95c(#"lightning_links_5", "tesla_storm_stun_finisher_zm", "tesla_storm_stun_finisher_special_zm", "tesla_storm_stun_finisher_elite_zm");
}

function function_9451b95c(equipment_name, var_92746e82, var_f3af4e17, var_5ef88cf) {
  assert(!isDefined(level.var_4bcd94b[equipment_name]), "<dev string:x38>" + (ishash(equipment_name) ? function_9e72a96(equipment_name) : equipment_name));
  level.var_4bcd94b[equipment_name] = {
    #var_fd2db56a: var_92746e82, #special_event: var_f3af4e17, #var_9b275351: var_5ef88cf
  };
}

function scoreeventzm(params) {
  if(isDefined(params.scoreevent) && zm_utility::is_player_valid(params.attacker, 0, 0)) {
    processscoreevent(params.scoreevent, params.attacker, params.enemy, params.weapon);

    if(params.scoreevent === # "avogadro_projectile_destroyed_zm") {
      params.attacker zm_stats::increment_challenge_stat(#"hash_2fa65e71a6411a7a");
    }

    if(params.scoreevent === "disciple_stun_drain_life_zm") {
      params.attacker zm_stats::increment_challenge_stat(#"hash_15bf92bd80c31d99");
    }

    if(params.scoreevent === "mangler_arm_cannon_kill_zm") {
      params.attacker zm_stats::function_7ec42fbf(#"hash_453e998083809449");
    }
  }
}

function function_a1f450c2(event, attacker, enemy, weapon) {
  if(zm_utility::is_player_valid(attacker, 0, 0)) {
    if(enemy.zm_ai_category === # "elite") {
      processscoreevent(event + "_elite_zm", attacker, enemy, weapon);
    } else if(enemy.zm_ai_category === # "special") {
      processscoreevent(event + "_special_zm", attacker, enemy, weapon);
    } else {
      processscoreevent(event + "_zm", attacker, enemy, weapon);
    }

    if(!isDefined(attacker.var_40cd3e93)) {
      attacker.var_40cd3e93 = [];
    }

    if(isDefined(attacker.var_40cd3e93[event])) {
      if(attacker.var_40cd3e93[event].time > gettime() - 2000 && attacker.var_40cd3e93[event].on_cooldown === 0) {
        attacker.var_40cd3e93[event].multikills++;
        attacker.var_40cd3e93[event].time = gettime() + 2000;
      } else if(attacker.var_40cd3e93[event].time < gettime()) {
        attacker.var_40cd3e93[event] = {
          #player: attacker, #time: gettime(), #weapon: undefined, #multikills: 1, #on_cooldown: 0
        };
      }

      return;
    }

    attacker.var_40cd3e93[event] = {
      #player: attacker, #time: gettime(), #weapon: undefined, #multikills: 1, #on_cooldown: 0
    };
  }
}

function function_970a97b2(params) {
  pixbeginevent(#"");
  updatemultikill(params);
  pixendevent();
  var_a0345f37 = {};

  if(isactor(params.enemy)) {
    var_a0345f37.origin = params.enemy.origin;
    var_a0345f37.angles = params.enemy.angles;
    var_a0345f37.archetype = params.enemy.archetype;
    var_a0345f37.actor_name = params.enemy function_7f0363e8(1);
    var_a0345f37.var_24f0cbe0 = params.enemy.var_24f0cbe0;
    var_a0345f37.var_c588eb = params.enemy.var_c588eb;
    var_a0345f37.var_14e19734 = params.enemy.var_14e19734;
    var_a0345f37.zm_ai_category = params.enemy.zm_ai_category;
    var_a0345f37.score_events = params.enemy.score_events;
    var_a0345f37.var_9624a42c = params.enemy.var_9624a42c;
    var_a0345f37.var_1d8cde9 = params.enemy.var_1d8cde9;
    var_a0345f37.var_e293f8ac = params.enemy.var_e293f8ac;
    var_a0345f37.var_c2dcab66 = params.enemy.var_c2dcab66;
    var_a0345f37.var_7b22b800 = params.enemy.var_7b22b800;
    var_a0345f37.var_c6f48ff5 = params.enemy.var_c6f48ff5;
    var_a0345f37.var_3f87fe17 = params.enemy.var_3f87fe17;
    var_a0345f37.var_49fdad6a = params.enemy.var_49fdad6a;
    var_a0345f37.var_8221e855 = params.enemy.var_8221e855;
    var_a0345f37.smeansofdeath = params.enemy.smeansofdeath;
    var_a0345f37.var_f42aed2a = params.enemy.var_f42aed2a;
    var_a0345f37.var_aa2ce9a4 = params.enemy.var_aa2ce9a4;
    var_a0345f37.var_12745932 = params.enemy.var_12745932;
    var_a0345f37.var_d1b39105 = params.enemy flag::get(#"deadwire_stun");
    var_a0345f37.var_9c33fa32 = params.enemy.var_9c33fa32;
    var_a0345f37.var_8126f3c8 = params.enemy.var_8126f3c8;
    var_a0345f37.var_fc304017 = params.enemy.var_fc304017;
    var_a0345f37.damagemod = params.enemy.damagemod;
    var_a0345f37.var_d3ed3a9b = params.enemy zm_utility::function_4562a3ef(params.enemy.damagelocation);
    var_a0345f37.var_9b0f545e = params.enemy.var_9b0f545e;
    var_a0345f37.var_531d35d4 = params.enemy.var_531d35d4;
    var_a0345f37.var_81651e9f = is_true(params.enemy.var_390850ac);
    var_a0345f37.var_958cf9c5 = params.enemy.var_958cf9c5;
    var_a0345f37.var_e5d5f66e = params.enemy.var_e5d5f66e;
    var_a0345f37.var_991315b5 = params.enemy.var_991315b5;
    var_a0345f37.var_25e2200c = params.enemy.var_25e2200c;
    var_a0345f37.var_4439c2d9 = params.enemy.var_4439c2d9;
    var_a0345f37.var_8a3828c6 = params.enemy.var_8a3828c6;
    var_a0345f37.var_d0de7f41 = is_true(params.enemy.var_d0de7f41) || is_true(params.enemy.var_7fb7de87);
    var_a0345f37.var_9258f88f = params.enemy.var_9258f88f;
    var_a0345f37.var_379bc25d = is_true(params.enemy.interdimensional_gun_kill);
    var_a0345f37.var_5f6261a5 = params.enemy.var_5f6261a5;
    var_a0345f37.var_7fde19e8 = params.enemy.var_7fde19e8;
    var_a0345f37.var_c3e92aaf = params.enemy.var_c3e92aaf;
    var_a0345f37.var_2bd7ca9d = params.enemy flag::get(#"hash_5047ba8da693e1c5");
  }

  if(!isPlayer(params.eattacker)) {
    return;
  }

  if(is_true(var_a0345f37.var_d3ed3a9b) && killstreaks::is_killstreak_weapon(params.weapon)) {
    var_a0345f37.var_d3ed3a9b = 0;
  }

  var_fdf0b12f = params.eattacker getentitynumber();
  w_stat = zm_weapons::get_base_weapon(params.weapon);
  var_947d01ee = level.zombie_weapons[w_stat].weapon_classname;
  waitframe(1);

  if(!isPlayer(params.eattacker)) {
    return;
  }

  [[level.var_c90fb58a[var_fdf0b12f]]] - > waitinqueue(var_a0345f37);
  pixbeginevent(#"");

  if(isDefined(level.var_ade393f4)) {
    level[[level.var_ade393f4]](var_a0345f37, params.eattacker, params.weapon);
  }

  if(zm_utility::is_player_valid(params.eattacker, 0, 0)) {
    if(params.eattacker.var_d853c1af !== 1) {
      if(var_a0345f37.zm_ai_category === # "special") {
        function_644d867a(params.eattacker, params.time, #"hash_4efbe7fdd1c5873d", params.weapon);
      } else if(var_a0345f37.zm_ai_category === # "elite") {
        function_644d867a(params.eattacker, params.time, #"hash_2bdba8dd04a772a9", params.weapon);
      } else if(var_a0345f37.zm_ai_category === # "boss") {
        function_644d867a(params.eattacker, params.time, #"hash_7d61681b4a86f9c1", params.weapon);
      } else {
        function_8fb658e2(params);
      }
    } else {
      function_8fb658e2(params);
    }

    if(is_true(params.eattacker.var_b1164fd0) || is_true(var_a0345f37.var_25e2200c) || isDefined(var_a0345f37.var_991315b5)) {
      params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_c95b11060979bcb", 1);
    }

    if(is_true(var_a0345f37.var_81651e9f)) {
      if(var_a0345f37.zm_ai_category === # "elite") {
        processscoreevent("phd_slider_kill_elite_zm", params.eattacker, var_a0345f37, level.weaponnone, undefined, params);
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("phd_slider_kill_special_zm", params.eattacker, var_a0345f37, level.weaponnone, undefined, params);
      } else {
        processscoreevent("phd_slider_kill_zm", params.eattacker, var_a0345f37, level.weaponnone, undefined, params);
      }

      params.eattacker.var_9c448324 = 1;
    }

    var_6fc038a1 = get_distance_for_weapon(params.weapon);

    if(isDefined(var_6fc038a1) && var_6fc038a1 > 0 && (params.smeansofdeath === "MOD_PISTOL_BULLET" || params.smeansofdeath === "MOD_RIFLE_BULLET" || params.smeansofdeath === "MOD_PROJECTILE" || params.smeansofdeath === "MOD_PROJECTILE_SPLASH")) {
      if(distancesquared(params.eattacker.origin, var_a0345f37.origin) > var_6fc038a1) {
        if(is_true(level.is_survival)) {
          params.eattacker zm_stats::increment_challenge_stat(#"hash_748d4c2ba56a6cdd");
        }

        if(var_947d01ee === "tr") {
          params.eattacker stats::function_d0de7686(#"hash_36199b2fd0602c5d", 1, #"hash_79710ef1b5aafb5e");
        }

        if(var_a0345f37.zm_ai_category === # "elite") {
          processscoreevent("longshot_killingblow_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else if(var_a0345f37.zm_ai_category === # "special") {
          processscoreevent("longshot_killingblow_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else {
          processscoreevent("longshot_killingblow_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        }
      }
    }

    if(is_true(var_a0345f37.var_379bc25d)) {
      if(params.smeansofdeath != "MOD_UNKNOWN" && params.weapon.name !== # "hash_6a4dd5ed56f6e3f6") {
        if(var_a0345f37.zm_ai_category === # "elite") {
          processscoreevent("lt53_kazimir_grav_pull_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else if(var_a0345f37.zm_ai_category === # "special") {
          processscoreevent("lt53_kazimir_grav_pull_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);

          if(var_947d01ee === "ar") {
            params.eattacker zm_stats::function_51c1448(#"hash_60eb36f8a47a2d1a", 1, #"hash_1b9cabf1c8e31391", #"ar_slowfire_t9");
          }
        } else {
          processscoreevent("lt53_kazimir_grav_pull_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        }
      }
    }

    if(isDefined(var_a0345f37.var_5f6261a5)) {
      if(zm_utility::is_player_valid(var_a0345f37.var_5f6261a5, 0, 0)) {
        if(var_a0345f37.var_5f6261a5 === params.eattacker) {
          params.eattacker stats::function_622feb0d(#"lightning_links", #"kills", 1);

          if(var_a0345f37.zm_ai_category === # "elite") {
            processscoreevent("tesla_storm_finisher_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
          } else if(var_a0345f37.zm_ai_category === # "special") {
            processscoreevent("tesla_storm_finisher_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
          } else {
            processscoreevent("tesla_storm_finisher_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
          }

          params.eattacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
          params.eattacker zm_stats::increment_challenge_stat(#"hash_2c0504992b5785f2");
          params.eattacker zm_stats::increment_challenge_stat(#"hash_7c5dfd9a8b4b34e");
          params.eattacker zm_stats::function_7ec42fbf(#"hash_2d451e3bdc5fc297", 1);

          if(var_947d01ee === "lmg") {
            params.eattacker zm_stats::function_51c1448(#"hash_174d558bf59e241a", 1, #"hash_329170867acd33e9", #"lmg_fastfire_t9");
          }

          var_aebccf30 = function_2bf1d1bb("tesla_storm_multikill_zm", params.eattacker, #"lightning_links", params.weapon, 2000, 5, 1);

          if(var_aebccf30) {
            params.eattacker function_deb933ff();
          }
        } else {
          processscoreevent("tesla_storm_assist_zm", var_a0345f37.var_5f6261a5, var_a0345f37, params.weapon, undefined, params);
        }
      }
    }

    if(is_true(var_a0345f37.var_d0de7f41)) {
      if(zm_utility::is_player_valid(var_a0345f37.var_9258f88f, 0, 0)) {
        if(var_a0345f37.var_9258f88f === params.eattacker) {
          params.eattacker stats::function_622feb0d(#"toxic_growth", #"kills", 1);

          if(var_a0345f37.zm_ai_category === # "elite") {
            processscoreevent("toxic_growth_finisher_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
          } else if(var_a0345f37.zm_ai_category === # "special") {
            processscoreevent("toxic_growth_finisher_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
          } else {
            processscoreevent("toxic_growth_finisher_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
          }

          params.eattacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
          params.eattacker zm_stats::increment_challenge_stat(#"hash_2c0504992b5785f2");
          var_aebccf30 = function_2bf1d1bb("toxic_growth_multikill_zm", params.eattacker, #"toxic_growth", params.weapon, 2000, 5, 1);

          if(var_aebccf30) {
            params.eattacker zm_stats::increment_challenge_stat(#"hash_18840c28c3e337a6");
            params.eattacker function_deb933ff();
          }
        } else {
          processscoreevent("toxic_growth_assist_zm", var_a0345f37.var_9258f88f, var_a0345f37, params.weapon, undefined, params);
        }
      }
    }

    if(isDefined(var_a0345f37.var_8a3828c6)) {
      if(var_a0345f37.var_8a3828c6 === params.eattacker) {
        if(!isDefined(params.eattacker.var_4d3653eb)) {
          params.eattacker.var_4d3653eb = 1;
        } else {
          params.eattacker.var_4d3653eb++;
        }

        if(var_a0345f37.zm_ai_category === # "elite") {
          processscoreevent("frenzied_guard_elite_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else if(var_a0345f37.zm_ai_category === # "special") {
          processscoreevent("frenzied_guard_special_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else {
          processscoreevent("frenzied_guard_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        }

        params.eattacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
        params.eattacker zm_stats::increment_challenge_stat(#"hash_2c0504992b5785f2");

        if(params.eattacker.var_4d3653eb >= 10) {
          params.eattacker.var_4d3653eb = -1000;
          processscoreevent("frenzied_guard_multikill_zm", params.eattacker, undefined, params.weapon, undefined, params);
          params.eattacker stats::function_622feb0d(#"hash_55569355da0f0f68", #"hash_7bf29fa438d54aad", 1);
          params.eattacker function_deb933ff();
        }
      } else if(zm_utility::is_player_valid(var_a0345f37.var_8a3828c6, 0, 0)) {
        processscoreevent("frenzied_guard_assist_zm", var_a0345f37.var_8a3828c6, var_a0345f37, params.weapon, undefined, params);
      }
    } else if(isDefined(params.eattacker) && isDefined(params.eattacker.var_4d3653eb)) {
      params.eattacker.var_4d3653eb = undefined;
    }

    if(is_true(params.eattacker.var_b1164fd0)) {
      params.eattacker zm_stats::function_17ee4529(#"hash_513bcb963a91d81b", 1, #"hash_735ace6b22542a65");

      if(!isDefined(params.eattacker.var_edae10c)) {
        params.eattacker.var_edae10c = 1;
      } else {
        params.eattacker.var_edae10c++;
      }

      if(var_a0345f37.zm_ai_category === # "elite") {
        processscoreevent("aether_shroud_kill_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("aether_shroud_kill_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      } else {
        processscoreevent("aether_shroud_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      }

      if(var_947d01ee === "melee") {
        params.eattacker stats::function_d0de7686(#"hash_1e7c5dc6e73c2ea9", 1, #"hash_20ba08b29e1de57e");
      }

      params.eattacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
      params.eattacker zm_stats::increment_challenge_stat(#"hash_2c0504992b5785f2");

      if(params.eattacker.var_edae10c >= 5) {
        params.eattacker.var_edae10c = -1000;
        processscoreevent("aether_shroud_multikill_zm", params.eattacker, undefined, params.weapon, undefined, params);
        params.eattacker zm_stats::increment_challenge_stat(#"aether_shroud_medals");
        params.eattacker contracts::increment_zm_contract(#"hash_58e200f3e5061cb9");
        params.eattacker stats::function_622feb0d(#"aether_shroud", #"hash_7bf29fa438d54aad", 1);
        params.eattacker function_deb933ff();
      }
    } else if(isDefined(params.eattacker.var_edae10c)) {
      params.eattacker.var_edae10c = undefined;
    }

    if(var_a0345f37.archetype === # "abom" && is_true(var_a0345f37.var_2bd7ca9d)) {
      processscoreevent("abomination_kill_while_stunned_from_charge_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
    }

    if(isDefined(params.var_a3660fca) || is_true(var_a0345f37.var_f42aed2a)) {
      if(var_a0345f37.zm_ai_category === # "elite") {
        processscoreevent("brain_rot_turned_kill_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("brain_rot_turned_kill_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;

        if(var_a0345f37.archetype === # "raz") {
          params.eattacker zm_stats::increment_challenge_stat(#"hash_3eed494910a05bbc");
        }
      } else {
        processscoreevent("brain_rot_turned_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      }

      if(params.einflictor.archetype === # "soa") {
        params.eattacker zm_stats::function_7ec42fbf(#"hash_7c2104436691d80d");
        params.eattacker zm_stats::increment_challenge_stat(#"hash_5698f14f777a2bf5");
      }

      params.eattacker stats::function_dad108fa(#"hash_4bcd9e9baf9fef9d", 1);
    }

    if(isDefined(var_a0345f37.var_3f87fe17)) {
      if(var_a0345f37.var_3f87fe17.stun_time > gettime() - 2.5 * 1000) {
        if(var_a0345f37.var_3f87fe17.player === params.eattacker) {
          if(var_a0345f37.zm_ai_category === # "elite") {} else if(var_a0345f37.zm_ai_category === # "special") {}
        } else if(var_a0345f37.zm_ai_category === # "elite" && var_a0345f37.zm_ai_category === # "special") {
          processscoreevent("healing_aura_stun_assist_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        }
      } else {
        var_a0345f37.var_3f87fe17 = undefined;
      }
    }

    if(params.smeansofdeath === "MOD_MELEE") {
      if(is_true(params.eattacker.var_b1164fd0)) {
        params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"meleecombo", 1);
      }

      if(var_a0345f37.zm_ai_category === # "elite") {
        processscoreevent("melee_killingblow_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("melee_killingblow_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      } else {
        processscoreevent("melee_killingblow_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      }
    } else if(var_a0345f37.var_d3ed3a9b && params.weapon.name !== # "gun_ultimate_turret" && params.weapon.name !== # "hatchet" && !killstreaks::is_killstreak_weapon(params.weapon)) {
      params.var_3fb48d9c = 1;

      if(var_a0345f37.zm_ai_category === # "elite" && !isDefined(params.enemy.var_e293f8ac)) {
        processscoreevent("headshot_killingblow_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("headshot_killingblow_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      } else {
        processscoreevent("headshot_killingblow_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        params.eattacker.var_9c448324 = 1;
      }
    }

    if(is_true(var_a0345f37.var_9b0f545e)) {
      params.eattacker function_841e454b("napalm_burst_burn_finisher", var_a0345f37, params.weapon, params);
    } else if(is_true(var_a0345f37.var_531d35d4)) {
      params.eattacker function_841e454b("shatter_blast_finisher", var_a0345f37, params.weapon, params);
    }

    if(is_equipment(params.weapon)) {
      if(isDefined(params.weapon.statname)) {
        switch (params.weapon.statname) {
          case # "frag_grenade":
            params.eattacker stats::function_622feb0d(#"eq_frag_grenade", #"kills", 1);
            break;
          default:
            params.eattacker stats::function_622feb0d(params.weapon.statname, #"kills", 1);
            break;
        }
      }
    }

    if(isDefined(level.var_4bcd94b[params.weapon.name]) && (!killstreaks::is_killstreak_weapon(params.weapon) || killstreaks::is_killstreak_weapon(params.weapon) && var_a0345f37.damagemod !== "MOD_MELEE")) {
      event_struct = level.var_4bcd94b[params.weapon.name];
      params.eattacker.var_9c448324 = 1;
      scoreevent = undefined;

      if(var_a0345f37.zm_ai_category === # "elite") {
        scoreevent = event_struct.var_9b275351;
      } else if(var_a0345f37.zm_ai_category === # "special") {
        scoreevent = event_struct.special_event;
      }

      if(!isDefined(scoreevent)) {
        scoreevent = event_struct.var_fd2db56a;
      }

      processscoreevent(scoreevent, params.eattacker, var_a0345f37, params.weapon, undefined, params);
    } else if(isDefined(params.weapon.name)) {
      switch (params.weapon.name) {
        case # "ww_ieu_gas_t9_upgraded":
        case # "ww_ieu_plasma_t9_upgraded":
        case # "ww_ieu_acid_t9_upgraded":
        case # "ww_ieu_shockwave_t9_upgraded":
        case # "ww_ieu_shockwave_t9":
        case # "ww_ieu_electric_t9_upgraded":
        case # "ww_ieu_electric_t9":
        case # "ww_ieu_acid_t9":
        case # "ww_ieu_gas_t9":
        case # "ww_ieu_plasma_t9":
          if(is_true(params.enemy.var_49fdad6a) && params.enemy.zm_ai_category === # "elite" && (!isDefined(var_a0345f37.var_e293f8ac) || isDefined(var_a0345f37.var_e293f8ac) && var_a0345f37.var_e293f8ac.size === 0)) {
            params.eattacker zm_stats::increment_challenge_stat(#"hash_3969fa6c05de12ef");
            processscoreevent("kill_steiner_caught_with_ieu_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            params.eattacker.var_9c448324 = 1;
          }

          break;
      }
    }
  }

  if(var_a0345f37.var_d1b39105 === 1 && zm_utility::is_player_valid(var_a0345f37.var_9c33fa32, 0, 0)) {
    if(params.eattacker === var_a0345f37.var_9c33fa32) {
      if(var_a0345f37.zm_ai_category === # "elite") {
        processscoreevent("dead_wire_stun_kill_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("dead_wire_stun_kill_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      } else {
        processscoreevent("dead_wire_stun_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      }

      if(var_947d01ee === "ar") {
        params.eattacker zm_stats::function_51c1448(#"hash_20a9dbd1ca99a444", 1, #"hash_51465116c1efc9be", #"ar_fasthandling_t9");
      }
    } else {
      processscoreevent("dead_wire_stun_assist_zm", var_a0345f37.var_9c33fa32, var_a0345f37, params.weapon, undefined, params);
    }
  } else if(var_a0345f37.var_fc304017 === 1 && zm_utility::is_player_valid(params.eattacker, 0, 0)) {
    if(params.eattacker === var_a0345f37.var_9c33fa32) {
      if(var_a0345f37.zm_ai_category === # "elite") {
        processscoreevent("dead_wire_stun_kill_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      } else if(var_a0345f37.zm_ai_category === # "special") {
        processscoreevent("dead_wire_stun_kill_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      } else {
        processscoreevent("dead_wire_stun_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
      }

      if(var_947d01ee === "ar") {
        params.eattacker stats::function_d0de7686(#"hash_20a9dbd1ca99a444", 1, #"hash_51465116c1efc9be");
      }
    } else {
      processscoreevent("dead_wire_stun_assist_zm", var_a0345f37.var_9c33fa32, var_a0345f37, params.weapon, undefined, params);
    }
  }

  if(isDefined(params.eattacker.var_d93ab65) && params.eattacker.var_d93ab65.size > 0) {
    foreach(var_23662c1b in params.eattacker.var_d93ab65) {
      if(zm_utility::is_player_valid(var_23662c1b.owner, 0, 0)) {
        if(var_23662c1b.owner === params.eattacker) {
          if(isDefined(params.eattacker.var_a25e160d)) {
            params.eattacker.var_a25e160d++;
            params.eattacker stats::function_622feb0d(#"ring_of_fire", #"hash_65e055407b6d8c3e", 1);
            params.eattacker stats::function_622feb0d(#"ring_of_fire", #"ekia", 1);
            params.eattacker stats::function_6fb0b113(#"ring_of_fire", #"best_ekia");

            if(var_a0345f37.zm_ai_category === # "elite") {
              processscoreevent("ring_of_fire_finisher_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            } else if(var_a0345f37.zm_ai_category === # "special") {
              processscoreevent("ring_of_fire_finisher_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            } else {
              processscoreevent("ring_of_fire_finisher_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            }

            params.eattacker contracts::increment_zm_contract(#"hash_1d79330297e3f68b");
            params.eattacker zm_stats::increment_challenge_stat(#"hash_2c0504992b5785f2");
          }

          continue;
        }

        processscoreevent("ring_of_fire_assist_zm", var_23662c1b.owner, var_a0345f37, params.weapon, undefined, params);
      }
    }
  }

  if(var_a0345f37.var_958cf9c5 === 1) {
    if(var_a0345f37.damagemod === "MOD_MELEE" && zm_utility::is_player_valid(params.eattacker, 0, 0)) {
      params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"meleecombo", 1);
    }

    if(zm_utility::is_player_valid(var_a0345f37.var_e5d5f66e, 0, 0) && !is_true(var_a0345f37.var_aa2ce9a4)) {
      if(params.eattacker === var_a0345f37.var_e5d5f66e) {
        if(var_a0345f37.zm_ai_category === # "elite") {
          processscoreevent("cryo_freeze_slow_kill_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else if(var_a0345f37.zm_ai_category === # "special") {
          processscoreevent("cryo_freeze_slow_kill_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else {
          processscoreevent("cryo_freeze_slow_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        }
      } else {
        processscoreevent("cryo_freeze_slow_assist_zm", var_a0345f37.var_e5d5f66e, var_a0345f37, params.weapon, undefined, params);
      }
    } else if(zm_utility::is_player_valid(var_a0345f37.var_991315b5, 0, 0)) {
      if(params.eattacker === var_a0345f37.var_991315b5) {
        if(var_a0345f37.zm_ai_category === # "elite") {
          processscoreevent("frost_blast_frozen_kill_elite_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else if(var_a0345f37.zm_ai_category === # "special") {
          processscoreevent("frost_blast_frozen_kill_special_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        } else {
          processscoreevent("frost_blast_frozen_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
        }

        if(var_947d01ee === "melee") {
          params.eattacker stats::function_d0de7686(#"hash_cec186092dce3f2", 1, #"hash_34a28edc5d90a87");
        }
      } else {
        processscoreevent("frost_blast_frozen_assist_zm", var_a0345f37.var_991315b5, var_a0345f37, params.weapon, undefined, params);
      }
    }
  }

  if(isDefined(params.enemy.enemy_override)) {
    if(zm_utility::is_player_valid(params.enemy.enemy_override.owner, 0, 0)) {
      switch (params.enemy.enemy_override.item.name) {
        case # "nightingale_zm":
          if(zm_utility::is_player_valid(params.eattacker, 0, 0)) {
            if(var_a0345f37.damagemod === "MOD_MELEE") {
              params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_1f451bc4d664e2ad", 1);
            }

            params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_362cbd72d16eaa5d", 1);
          }

          params.eattacker stats::function_6fb0b113(#"nightingale", #"hash_54fc499311f0b3d");

          if(params.enemy.enemy_override.owner === params.eattacker) {
            if(var_947d01ee === "melee") {
              params.eattacker stats::function_d0de7686(#"hash_351323b673476913", 1, #"hash_653135ec012bf674");
            }

            params.enemy.enemy_override.owner stats::function_622feb0d(#"nightingale", #"kills", 1);

            if(params.enemy.zm_ai_category === # "elite") {
              processscoreevent("nightengale_elite_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            } else if(params.enemy.zm_ai_category === # "special") {
              processscoreevent("nightengale_special_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            } else {
              processscoreevent("nightengale_kill_zm", params.eattacker, var_a0345f37, params.weapon, undefined, params);
            }
          } else {
            processscoreevent("nightengale_assist_zm", params.enemy.enemy_override.owner, var_a0345f37, params.weapon, undefined, params);
            params.enemy.enemy_override.owner stats::function_622feb0d(#"nightingale", #"assists", 1);
          }

          break;
      }
    } else if(params.enemy.enemy_override.anim_debug_name === "monkey") {
      if(zm_utility::is_player_valid(params.eattacker, 0, 0)) {
        if(var_a0345f37.damagemod === "MOD_MELEE") {
          params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_1f451bc4d664e2ad", 1);
        }

        if(var_947d01ee === "melee" && params.enemy.enemy_override.var_38af96b9.owner === params.eattacker) {
          params.eattacker stats::function_d0de7686(#"hash_351323b673476913", 1, #"hash_653135ec012bf674");
        }

        params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_362cbd72d16eaa5d", 1);
      }
    }
  }

  if(isDefined(var_a0345f37.score_events[# "kill"]) && (!isDefined(var_a0345f37.var_e293f8ac) || isDefined(var_a0345f37.var_e293f8ac) && (!is_true(params.eattacker.var_9c448324) || var_a0345f37.var_e293f8ac.size === 0))) {
    processscoreevent(var_a0345f37.score_events[# "kill"], params.eattacker, var_a0345f37, params.weapon, undefined, params);
  }

  if(isPlayer(params.eattacker) && params.eattacker isinvehicle()) {
    var_ab120e5 = params.eattacker getvehicleoccupied();
    players = getplayers();

    foreach(player in players) {
      if(player != params.eattacker) {
        veh = player getvehicleoccupied();

        if(veh === var_ab120e5) {
          player function_a1f450c2("vehicle_shared_kia", player, var_a0345f37, undefined);
          player.var_9c448324 = 1;
        }
      }
    }
  }

  params.enemy = var_a0345f37;
  function_f2ce8b86(params);
  pixendevent();
  level notify(#"hash_6c17824062de93e5");
}

function function_841e454b(var_f6537fa9, enemy, weapon, params) {
  if(enemy.zm_ai_category === # "elite") {
    scoreevent = var_f6537fa9 + "_elite_zm";
  } else if(enemy.zm_ai_category === # "special") {
    scoreevent = var_f6537fa9 + "_special_zm";
  } else {
    scoreevent = var_f6537fa9 + "_zm";
  }

  if(isDefined(scoreevent)) {
    processscoreevent(scoreevent, params.eattacker, enemy, weapon, undefined, params);
    params.eattacker.var_9c448324 = 1;
  }
}

function function_82234b38(victim, attacker, weapon, meansofdeath, var_a3660fca, einflictor, var_b7a35db0) {
  if(!isDefined(victim.var_c2dcab66)) {
    victim.var_c2dcab66 = [];
  }

  if(zm_utility::is_player_valid(var_a3660fca, 0, 0)) {
    victim.var_c2dcab66[var_a3660fca getentitynumber()] = {
      #player: var_a3660fca, #time: gettime(), #weapon: weapon, #var_569e4e47: 1
    };
  } else if(zm_utility::is_player_valid(attacker, 0, 0)) {
    if(isDefined(victim.var_c2dcab66[attacker getentitynumber()]) && is_true(victim.var_c2dcab66[attacker getentitynumber()].var_569e4e47)) {
      var_569e4e47 = 1;
    }

    if(zm_weapons::is_wonder_weapon(weapon) || weapon.statname === # "ray_gun") {
      victim.var_c2dcab66[attacker getentitynumber()] = {
        #player: attacker, #time: gettime(), #weapon: weapon, #signature_weapon: 1, #var_569e4e47: var_569e4e47
      };
    } else if(weapon.name === # "eq_sticky_grenade" || weapon.name === # "satchel_charge" || weapon.name === # "frag_grenade" || weapon.name === # "cymbal_monkey" || weapon.name === # "molotov_fire" || weapon.name === # "concussion_grenade" || weapon.name === # "hatchet") {
      victim.var_c2dcab66[attacker getentitynumber()] = {
        #player: attacker, #time: gettime(), #weapon: weapon, #var_b8fea68d: 1, #var_569e4e47: var_569e4e47
      };
    } else {
      victim.var_c2dcab66[attacker getentitynumber()] = {
        #player: attacker, #time: gettime(), #weapon: weapon, #var_569e4e47: var_569e4e47, #einflictor: einflictor, #var_b7a35db0: var_b7a35db0
      };
    }
  }

  if(weapon.name === # "eq_slow_grenade" && meansofdeath !== "MOD_IMPACT" && !(victim.zm_ai_category === # "boss")) {
    processscoreevent("concussion_grenade_concussed_enemy_zm", attacker, victim, weapon);
    attacker contracts::increment_zm_contract(#"hash_51d4ecc2bd44fb2b");
  }
}

function function_46e3cf42(zombie, player) {
  if(zm_utility::is_player_valid(player, 0, 0)) {
    zombie.var_9624a42c = {
      #player: player, #time: gettime()
    };
  }
}

function function_513fa6e4(zombie, player) {
  if(isDefined(zombie.var_9624a42c)) {
    if(zm_utility::is_player_valid(zombie.var_9624a42c.player, 0, 0) && player !== zombie.var_9624a42c.player && zombie.var_9624a42c.time > gettime() - 10000) {
      processscoreevent("kill_enemy_injuring_teammate_zm", player);
    }
  }
}

function function_f2ce8b86(params) {
  if(isDefined(params.enemy.score_events[# "assist"]) && isDefined(params.enemy.var_c2dcab66)) {
    foreach(var_c2dcab66 in params.enemy.var_c2dcab66) {
      if(zm_utility::is_player_valid(var_c2dcab66.player, 0, 0) && var_c2dcab66.time > gettime() - 10000 && (is_true(params.enemy.var_7b22b800) || var_c2dcab66.player != params.eattacker)) {
        if(var_c2dcab66.player !== params.eattacker) {
          function_4ffff5df(var_c2dcab66.player, var_c2dcab66.weapon, params.var_9c448324, params.enemy);
        }

        if(is_equipment(var_c2dcab66.weapon)) {
          if(isDefined(var_c2dcab66.weapon.statname)) {
            switch (var_c2dcab66.weapon.statname) {
              case # "frag_grenade":
                var_c2dcab66.player stats::function_6fb0b113(#"eq_frag_grenade", #"best_ekia");
                break;
              default:
                var_c2dcab66.player stats::function_6fb0b113(var_c2dcab66.weapon.statname, #"best_ekia");
                break;
            }
          }
        } else if(isDefined(var_c2dcab66.weapon.name)) {
          switch (var_c2dcab66.weapon.name) {
            case # "energy_mine":
            case # "energy_mine_4":
            case # "energy_mine_5":
            case # "energy_mine_2":
            case # "energy_mine_3":
            case # "energy_mine_1":
            case # "hash_7e4053e6965bafa7":
              var_c2dcab66.player stats::function_6fb0b113(#"energy_mine", #"best_ekia");
              break;
            case # "frost_blast":
            case # "frost_blast_1":
            case # "frost_blast_3":
            case # "frost_blast_2":
            case # "frost_blast_5":
            case # "frost_blast_4":
              var_c2dcab66.player stats::function_6fb0b113(#"frost_blast", #"best_ekia");
              break;
          }
        }

        if(var_c2dcab66.player === params.eattacker && var_c2dcab66.player isinvehicle() && !is_true(var_c2dcab66.player.var_9c448324)) {
          veh = var_c2dcab66.player getvehicleoccupied();

          if(veh.vehicleclass === "tank") {
            var_c2dcab66.player zm_stats::function_7ec42fbf(#"hash_d89d61477cee38f");
          }

          var_a5165f0e = veh getoccupantseat(var_c2dcab66.player);

          if(isDefined(veh.var_260e3593) && var_a5165f0e === veh.var_260e3593) {
            if(params.enemy.zm_ai_category === # "elite") {
              processscoreevent("driver_kia_elite_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
              var_c2dcab66.player.var_9c448324 = 1;
            } else if(params.enemy.zm_ai_category === # "special") {
              processscoreevent("driver_kia_special_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
              var_c2dcab66.player.var_9c448324 = 1;
            } else {
              processscoreevent("driver_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
              var_c2dcab66.player.var_9c448324 = 1;
            }
          } else {
            switch (var_a5165f0e) {
              case 0:
                if(params.enemy.zm_ai_category === # "elite") {
                  processscoreevent("driver_kia_elite_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                  var_c2dcab66.player.var_9c448324 = 1;
                } else if(params.enemy.zm_ai_category === # "special") {
                  processscoreevent("driver_kia_special_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                  var_c2dcab66.player.var_9c448324 = 1;
                } else {
                  processscoreevent("driver_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                  var_c2dcab66.player.var_9c448324 = 1;
                }

                break;
              case 1:
              case 2:
              case 3:
              case 4:
                if(var_c2dcab66.weapon.statname !== # "chopper_gunner") {
                  if(params.enemy.zm_ai_category === # "elite") {
                    processscoreevent("gunner_kia_elite_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                    var_c2dcab66.player.var_9c448324 = 1;
                  } else if(params.enemy.zm_ai_category === # "special") {
                    processscoreevent("gunner_kia_special_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                    var_c2dcab66.player.var_9c448324 = 1;
                  } else {
                    processscoreevent("gunner_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                    var_c2dcab66.player.var_9c448324 = 1;
                  }
                }

                break;
              case 5:
              case 6:
              case 7:
              case 8:
              case 9:
              case 10:
                if(params.enemy.zm_ai_category === # "elite") {
                  processscoreevent("freelance_kia_elite_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                  var_c2dcab66.player.var_9c448324 = 1;
                } else if(params.enemy.zm_ai_category === # "special") {
                  processscoreevent("freelance_kia_special_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                  var_c2dcab66.player.var_9c448324 = 1;
                } else {
                  processscoreevent("freelance_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
                  var_c2dcab66.player.var_9c448324 = 1;
                }

                break;
            }
          }
        }

        if(isDefined(params.enemy.var_c6f48ff5) && params.enemy.var_c6f48ff5 > 1) {
          var_c2dcab66.player zm_stats::increment_challenge_stat(#"hash_2a35d5d67e994b88");
        }

        if(var_c2dcab66.var_569e4e47 === 1) {
          var_c2dcab66.player zm_stats::increment_challenge_stat(#"hash_7fe169cf58d1d6ef");
        }

        if(var_c2dcab66.signature_weapon === 1) {
          var_c2dcab66.player zm_stats::increment_challenge_stat(#"hash_1ceaeed13ab4546b");
        }

        if(var_c2dcab66.var_b8fea68d === 1) {
          var_c2dcab66.player zm_stats::increment_challenge_stat(#"equipment_kills");
        }

        if(killstreaks::is_killstreak_weapon(var_c2dcab66.weapon)) {
          killstreak_item = var_c2dcab66.einflictor.item;

          switch (var_c2dcab66.weapon.statname) {
            case # "remote_missile":
            case # "remote_missile_bomblet":
            case # "remote_missile_missile":
              var_c2dcab66.player stats::function_8fb23f94(#"remote_missile_zm", #"kills", 1);
              var_c2dcab66.player stats::function_b04e7184(#"remote_missile_zm", #"best_kills");
              break;
            case # "recon_car":
              var_c2dcab66.player stats::function_8fb23f94(#"recon_car_zm", #"kills", 1);
              var_c2dcab66.player stats::function_b04e7184(#"recon_car_zm", #"best_kills");
            default:
              var_c2dcab66.player stats::function_8fb23f94(var_c2dcab66.weapon.statname, #"kills", 1);
              break;
          }

          if(var_c2dcab66.einflictor.item.name === # "gun_ultimate_turret" && var_c2dcab66.einflictor.owner !== params.eattacker) {
            if(zm_utility::is_player_valid(var_c2dcab66.einflictor.owner, 0, 0)) {
              processscoreevent("sentry_turret_assist_zm", var_c2dcab66.einflictor.owner, params.enemy, var_c2dcab66.weapon);
              var_c2dcab66.einflictor.owner.var_9c448324 = 1;
            }
          }

          if(isDefined(killstreak_item)) {
            if(!isDefined(killstreak_item.var_8f44f2c0)) {
              killstreak_item.var_8f44f2c0 = 0;
            }

            killstreak_item.var_8f44f2c0++;

            if(isDefined(killstreak_item.kills)) {
              killstreak_item.kills++;

              if(killstreak_item.kills >= 50) {
                killstreak_item.kills = undefined;
                var_c2dcab66.player zm_stats::increment_challenge_stat(#"hash_3d79fa20a5d0fb7");
              }
            } else {
              killstreak_item.kills = 1;
            }
          }
        }

        if(isDefined(params.enemy.var_e293f8ac)) {
          function_1eaaceab(params.enemy.var_e293f8ac);

          if(params.enemy.var_e293f8ac.size === 1) {
            if(params.enemy.score_events[# "assist"] === "steiner_kia_zm") {
              params.enemy.var_e293f8ac[0].var_8221e855 = gettime();
            }
          }
        }

        if(!is_true(var_c2dcab66.player.var_9c448324)) {
          if(isDefined(params.enemy.var_e293f8ac)) {
            function_1eaaceab(params.enemy.var_e293f8ac);

            if(params.enemy.var_e293f8ac.size === 0) {
              if(isDefined(params.enemy.var_8221e855) && params.enemy.var_8221e855 > gettime() - 2000) {
                params.enemy.var_8221e855 = undefined;
                var_c2dcab66.player zm_stats::increment_challenge_stat(#"hash_6baa731ac0cca35a");
                processscoreevent("kill_both_steiner_halves_rapidly_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
              }

              if(var_c2dcab66.player === params.eattacker && var_c2dcab66.weapon.name === # "satchel_charge") {
                params.eattacker zm_stats::increment_challenge_stat(#"hash_1a8c582d9511cea8");
              }

              params.enemy.var_c7e611ea = params.enemy.var_24f0cbe0;
              processscoreevent("steiner_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
            }
          } else {
            processscoreevent(params.enemy.score_events[# "assist"], var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
          }
        } else if(isDefined(params.enemy.var_e293f8ac)) {
          function_1eaaceab(params.enemy.var_e293f8ac);

          if(params.enemy.var_e293f8ac.size === 0) {
            if(isDefined(params.enemy.var_8221e855) && params.enemy.var_8221e855 > gettime() - 2000) {
              params.enemy.var_8221e855 = undefined;
              var_c2dcab66.player zm_stats::increment_challenge_stat(#"hash_6baa731ac0cca35a");
              processscoreevent("kill_both_steiner_halves_rapidly_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
            }

            if(var_c2dcab66.player === params.eattacker && var_c2dcab66.weapon.name === # "satchel_charge") {
              params.eattacker zm_stats::increment_challenge_stat(#"hash_1a8c582d9511cea8");
            }

            params.enemy.var_c7e611ea = params.enemy.var_24f0cbe0;
            processscoreevent("steiner_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
          }
        }

        if(params.enemy.archetype === # "avogadro" && gettime() - (isDefined(params.enemy.var_7fde19e8) ? params.enemy.var_7fde19e8 : 0) <= 2000) {
          processscoreevent("avogadro_teleport_kia_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
        }

        if(!isDefined(params.enemy.var_9624a42c) && params.enemy.archetype === # "mimic") {
          processscoreevent("mimic_killed_without_getting_hit_zm", var_c2dcab66.player, params.enemy, var_c2dcab66.weapon);
        }

        if((params.enemy.zm_ai_category === # "elite" || params.enemy.zm_ai_category === # "special") && isDefined(var_c2dcab66.weapon) && (!isDefined(params.enemy.var_e293f8ac) || isDefined(params.enemy.var_e293f8ac) && params.enemy.var_e293f8ac.size === 0)) {
          var_c2dcab66.player zm_challenges::function_d6b32ad3(var_c2dcab66.weapon, #"eliteeliminations", 1);
        }

        if(is_true(var_c2dcab66.player.var_b1164fd0)) {
          var_c2dcab66.player stats::function_622feb0d(#"aether_shroud", #"kills", 1);
          var_c2dcab66.player stats::function_6fb0b113(#"aether_shroud", #"best_ekia");
        }

        if(isDefined(params.enemy.var_8a3828c6)) {
          if(params.enemy.var_8a3828c6 === var_c2dcab66.player) {
            var_c2dcab66.player stats::function_622feb0d(#"hash_55569355da0f0f68", #"kills", 1);
            var_c2dcab66.player stats::function_6fb0b113(#"hash_55569355da0f0f68", #"best_ekia");
          }
        }

        if(is_true(params.enemy.var_d0de7f41)) {
          if(params.enemy.var_9258f88f === var_c2dcab66.player) {
            var_c2dcab66.player stats::function_622feb0d(#"toxic_growth", #"ekia", 1);
            var_c2dcab66.player stats::function_6fb0b113(#"toxic_growth", #"best_ekia");
          }
        }

        if(isDefined(params.enemy.var_5f6261a5)) {
          if(params.enemy.var_5f6261a5 === var_c2dcab66.player) {
            var_c2dcab66.player stats::function_622feb0d(#"lightning_links", #"ekia", 1);
            var_c2dcab66.player stats::function_6fb0b113(#"lightning_links", #"best_ekia");
          }
        }

        var_c2dcab66.player.var_9c448324 = undefined;

        if(isDefined(level.var_f8b76690)) {
          level[[level.var_f8b76690]](params.enemy, var_c2dcab66.player, var_c2dcab66.weapon);
        }

        var_c2dcab66.player zm_challenges::function_575c37e0(var_c2dcab66.weapon, params.enemy);
      }
    }
  }
}

function function_4ffff5df(attacker, weapon, var_9c448324, enemy) {
  if(!is_true(var_9c448324)) {
    if(is_equipment(weapon)) {
      if(isDefined(weapon.statname)) {
        switch (weapon.statname) {
          case # "frag_grenade":
            attacker stats::function_622feb0d(#"eq_frag_grenade", #"assists", 1);
            break;
          default:
            attacker stats::function_622feb0d(weapon.statname, #"assists", 1);
            break;
        }
      }
    }

    if(weapon.name === # "molotov_fire") {
      processscoreevent("molotov_assist_zm", attacker, enemy);
      return;
    }

    if(weapon.name === # "eq_slow_grenade") {
      processscoreevent("concussion_grenade_assist_zm", attacker, enemy);
      return;
    }

    if(weapon.name === # "hash_6a4dd5ed56f6e3f6") {
      processscoreevent("lt53_kazimir_assist_zm", attacker, enemy);
    }
  }
}

function is_equipment(weapon) {
  if(!isDefined(weapon.name)) {
    return false;
  }

  switch (weapon.name) {
    case # "molotov_fire":
    case # "frag_grenade":
    case # "hatchet":
    case # "eq_sticky_grenade":
    case # "eq_slow_grenade":
    case # "hash_6a4dd5ed56f6e3f6":
    case # "satchel_charge":
    case # "cymbal_monkey":
      return true;
    default:
      return false;
  }

  return false;
}

function updatemultikill(params) {
  if(isDefined(level.var_88e6f8b7)) {
    level[[level.var_88e6f8b7]](params);
  }

  if(!isDefined(params.eattacker.var_4927d3d)) {
    params.eattacker.var_4927d3d = [];
  }

  w_stat = zm_weapons::get_base_weapon(params.weapon);
  var_947d01ee = level.zombie_weapons[w_stat].weapon_classname;

  if(isDefined(params.enemy.enemy_override)) {
    if(zm_utility::is_player_valid(params.enemy.enemy_override.owner, 0, 0)) {
      switch (params.enemy.enemy_override.item.name) {
        case # "nightingale_zm":
          if(isDefined(params.eattacker.var_4927d3d[# "nightengale"])) {
            if(params.eattacker.var_4927d3d[# "nightengale"].time > gettime() - 2000 && params.eattacker.var_4927d3d[# "nightengale"].on_cooldown === 0) {
              params.eattacker.var_4927d3d[# "nightengale"].multikills++;
              params.eattacker contracts::increment_zm_contract(#"hash_a8b4dbd0271141f");
              params.eattacker.var_4927d3d[# "nightengale"].time = gettime() + 2000;

              if(params.eattacker.var_4927d3d[# "nightengale"].multikills === 3) {
                params.eattacker stats::function_622feb0d(#"nightingale", #"hash_7bf29fa438d54aad", 1);
                processscoreevent("nightengale_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_3de460c73d2f29e3");
              }
            } else if(params.eattacker.var_4927d3d[# "nightengale"].time < gettime()) {
              params.eattacker contracts::increment_zm_contract(#"hash_a8b4dbd0271141f");
              params.eattacker.var_4927d3d[# "nightengale"] = {
                #player: params.eattacker, #time: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0
              };
            }
          } else {
            params.eattacker contracts::increment_zm_contract(#"hash_a8b4dbd0271141f");
            params.eattacker.var_4927d3d[# "nightengale"] = {
              #player: params.eattacker, #time: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0
            };
          }

          break;
      }
    }
  }

  if(zm_utility::is_player_valid(params.eattacker, 0, 0)) {
    var_1c91bc3c = 0;

    if(!killstreaks::is_killstreak_weapon(params.weapon) && is_true(params.enemy zm_utility::function_4562a3ef(params.enemy.damagelocation)) && (params.smeansofdeath === "MOD_PISTOL_BULLET" || params.smeansofdeath === "MOD_RIFLE_BULLET" || (params.weapon.statname === # "special_crossbow_t9" || params.weapon.statname === # "special_nailgun_t9") && (params.smeansofdeath === "MOD_PROJECTILE" || params.smeansofdeath === "MOD_IMPACT"))) {
      var_1c91bc3c = 1;
    }

    if(params.enemy.var_958cf9c5 === 1 && zm_utility::is_player_valid(params.enemy.var_991315b5, 0, 0)) {
      if(isDefined(params.eattacker.var_4927d3d[# "frost_blast"])) {
        if(params.eattacker.var_4927d3d[# "frost_blast"].time > gettime() - 2000 && params.eattacker.var_4927d3d[# "frost_blast"].on_cooldown === 0) {
          params.eattacker.var_4927d3d[# "frost_blast"].multikills++;
          params.eattacker.var_4927d3d[# "frost_blast"].time = gettime() + 2000;

          if(params.eattacker.var_4927d3d[# "frost_blast"].multikills === 3) {
            processscoreevent("frost_blast_multikill_zm", params.eattacker, undefined, params.weapon);
            params.eattacker stats::function_622feb0d(#"frost_blast", #"hash_7bf29fa438d54aad", 1);
            params.eattacker contracts::increment_zm_contract(#"hash_4a72dbfac556f4ad");
            params.eattacker function_deb933ff();
            var_d4907104 = 1;
          }
        } else if(params.eattacker.var_4927d3d[# "frost_blast"].time < gettime()) {
          params.eattacker.var_4927d3d[# "frost_blast"] = {
            #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
          };
        }
      } else {
        params.eattacker.var_4927d3d[# "frost_blast"] = {
          #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
        };
      }
    }

    if(isDefined(params.eattacker.var_4927d3d[params.eattacker getentitynumber()])) {
      if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].time > gettime() - 2000 && params.eattacker.var_4927d3d[params.eattacker getentitynumber()].on_cooldown === 0) {
        if(is_true(var_1c91bc3c)) {
          if(isDefined(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_510ca9f9)) {
            params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_510ca9f9++;

            if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_510ca9f9 === 5) {
              if(var_947d01ee === "sniper") {
                params.eattacker zm_stats::function_51c1448(#"hash_61fccc0731a4a01a", 1, #"hash_34403f1f2912461f", #"sniper_accurate_t9");
              }

              processscoreevent("crit_finisher_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker contracts::increment_zm_contract(#"hash_6c0f79b069d2ab27");

              if(var_947d01ee === "ar") {
                params.eattacker zm_stats::function_51c1448(#"hash_2afbe016fb359bb5", 1, #"hash_564ac287fb7075d8", #"ar_season6_t9");
              }

              params.eattacker zm_stats::function_fbce465a(#"hash_734eed49f5390a8");
              params.eattacker zm_stats::function_fbce465a(#"hash_24abac59aafa49d1");
              params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_510ca9f9 = 0;
            }
          } else {
            params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_510ca9f9 = 1;
          }
        }

        if(params.weapon.statname === # "ray_gun") {
          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_5524bc59++;

          if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_5524bc59 === 5) {
            function_644d867a(params.eattacker, gettime(), #"hash_18e3e5b441fb51b0", params.weapon);
          }
        }

        if(var_947d01ee === "melee") {
          if(!isDefined(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_757d8d93)) {
            params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_757d8d93 = 1;
          }

          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_757d8d93++;

          if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_757d8d93 == 20) {
            params.eattacker zm_stats::increment_challenge_stat(#"hash_110c57c2a15f9f1f");
            params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_757d8d93 = 1;
          }
        } else {
          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_757d8d93 = 1;
        }

        if(!params.eattacker zm_powerups::is_insta_kill_active() && !params.eattacker zm_powerups::function_a4e210c7()) {
          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].multikills++;
          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].time = gettime() + 2000;

          switch (params.eattacker.var_4927d3d[params.eattacker getentitynumber()].multikills) {
            case 5:
              processscoreevent("multikillstreak_5_zm", params.eattacker, undefined, params.weapon);
              params.eattacker notify(#"multikill_scoreevent", {
                #scoreevent: "multikillstreak_5_zm"});
              params.eattacker zm_stats::function_17ee4529(#"hash_5a96ee436e73190", 1, #"hash_6abe83944d701459");

              if(params.weapon.statname === # "ar_mobility_t9" || params.weapon.statname === # "smg_handling_t9") {
                params.eattacker zm_stats::function_fbce465a(#"hash_76bf58f08a08d598");
              }

              if(params.weapon.statname === # "ar_damage_t9" || params.weapon.statname === # "smg_burst_t9" || params.weapon.statname === # "shotgun_pump_t9") {
                params.eattacker zm_stats::function_fbce465a(#"hash_734f1d49f5395c1");
              }

              if(params.weapon.statname === # "ar_standard_t9" || params.weapon.statname === # "smg_heavy_t9") {
                params.eattacker zm_stats::function_fbce465a(#"hash_777767b99c350232");
              }

              if(params.weapon.statname === # "ar_british_t9" || params.weapon.statname === # "smg_burst_t9") {
                params.eattacker zm_stats::function_fbce465a(#"hash_24abaa59aafa466b");
              }

              if(params.weapon.statname === # "special_grenadelauncher_t9" || params.weapon.statname === # "smg_standard_t9") {
                params.eattacker zm_stats::function_fbce465a(#"hash_3a26c6202d86ed8d");
              }

              if(params.weapon.statname === # "smg_handling_t9" || params.weapon.statname === # "ar_british_t9" || params.weapon.statname === # "pistol_fullauto_t9") {
                params.eattacker zm_stats::function_fbce465a(#"hash_7208e21496453ace");
              }

              if(var_947d01ee === "shotgun") {
                params.eattacker zm_stats::function_51c1448(#"hash_1c14b86adf849ce0", 1, #"hash_776eb055b10b2533", #"shotgun_leveraction_t9");
              }

              if(getdvarint(#"hash_1ad35129069d0b0a", 0)) {
                params.eattacker zm_stats::function_17ee4529(#"hash_47351685227336cc", 1, #"hash_5c49df97f4f82e12");
              }

              if(var_947d01ee === "shotgun") {
                params.eattacker stats::function_dad108fa(#"hash_398fdc7794697d06", 1);
              }

              break;
            case 10:
              processscoreevent("multikillstreak_10_zm", params.eattacker, undefined, params.weapon);
              params.eattacker notify(#"multikill_scoreevent", {
                #scoreevent: "multikillstreak_10_zm"});
              params.eattacker zm_stats::function_fbce465a(#"hash_777764b99c34fd19");
              params.eattacker zm_stats::function_17ee4529(#"hash_513bc8963a91d302", 1, #"hash_735ace6b22542a65");

              if(var_947d01ee === "smg") {
                params.eattacker zm_stats::function_51c1448(#"hash_339ce8c4252def9e", 1, #"hash_1e39c78c6ebed29b", #"smg_season6_t9");
              }

              break;
            case 15:
              processscoreevent("multikillstreak_15_zm", params.eattacker, undefined, params.weapon);
              params.eattacker notify(#"multikill_scoreevent", {
                #scoreevent: "multikillstreak_15_zm"});
              break;
            case 20:
              params.eattacker zm_stats::function_fbce465a(#"hash_3d915cbfdb04556d");
              processscoreevent("multikillstreak_20_zm", params.eattacker, undefined, params.weapon);
              params.eattacker notify(#"multikill_scoreevent", {
                #scoreevent: "multikillstreak_20_zm"});
              break;
            case 25:
              processscoreevent("multikillstreak_25_zm", params.eattacker, undefined, params.weapon);
              params.eattacker zm_stats::increment_challenge_stat(#"hash_5a554472dd2b62ad");
              params.eattacker notify(#"multikill_scoreevent", {
                #scoreevent: "multikillstreak_25_zm"});
              level thread popups::displayteammessagetoteam(#"hash_355d99b37cf5e6f4", params.eattacker, params.eattacker.team);
              break;
          }
        }

        if(isDefined(params.eattacker.var_9cd2c51d.var_3ca3137f) && params.eattacker.var_9cd2c51d.var_3ca3137f > gettime() - 6500) {
          if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].multikills === 3) {
            params.eattacker stats::function_8fb23f94(#"self_revive", #"hash_7bf29fa438d54aad", 1);
            processscoreevent("stim_shot_multikill_zm", params.eattacker, undefined, params.weapon);
          }
        }

        if(params.eattacker.var_9cd2c51d.var_158e75d4 === # "eq_stimshot" && isDefined(params.eattacker.var_9cd2c51d.var_63362b1e) && params.eattacker.var_9cd2c51d.var_63362b1e > gettime() - 6500) {
          if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].multikills === 3) {
            params.eattacker stats::function_622feb0d(#"eq_stimshot", #"hash_7bf29fa438d54aad", 1);
            processscoreevent("stim_shot_multikill_zm", params.eattacker, undefined, params.weapon);
            params.eattacker contracts::increment_zm_contract(#"hash_5edb2e1208dc3974");
            params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_52c02390 = 1;
          }
        }

        if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].multikills === 5) {
          if(isDefined(params.eattacker.var_9cd2c51d.var_232f5c31) && params.eattacker.var_9cd2c51d.var_232f5c31 > gettime() - 6500) {
            params.eattacker stats::function_622feb0d(#"heal_aoe", #"hash_7bf29fa438d54aad", 1);
            processscoreevent("healing_aura_multikill_zm", params.eattacker, undefined, params.weapon);
            params.eattacker contracts::increment_zm_contract(#"hash_2e2aa09daaaff416");
            params.eattacker function_deb933ff();
          }
        }
      } else if(params.eattacker.var_4927d3d[params.eattacker getentitynumber()].time < gettime()) {
        if(is_true(var_1c91bc3c)) {
          var_4105b7a0 = 1;
        } else {
          var_4105b7a0 = 0;
        }

        params.eattacker.var_4927d3d[params.eattacker getentitynumber()] = {
          #player: params.eattacker, #time: gettime(), #weapon: params.weapon, #multikills: 1, #var_510ca9f9: var_4105b7a0, #on_cooldown: 0
        };
        params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_52c02390 = undefined;
        params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_e5ae4603 = undefined;

        if(params.weapon.statname === # "ray_gun") {
          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_5524bc59 = 1;
        } else {
          params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_5524bc59 = 0;
        }
      }
    } else {
      if(is_true(var_1c91bc3c)) {
        var_4105b7a0 = 1;
      } else {
        var_4105b7a0 = 0;
      }

      params.eattacker.var_4927d3d[params.eattacker getentitynumber()] = {
        #player: params.eattacker, #time: gettime(), #weapon: params.weapon, #multikills: 1, #var_510ca9f9: var_4105b7a0, #on_cooldown: 0
      };
      params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_52c02390 = undefined;
      params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_e5ae4603 = undefined;

      if(params.weapon.statname === # "ray_gun") {
        params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_5524bc59 = 1;
      } else {
        params.eattacker.var_4927d3d[params.eattacker getentitynumber()].var_5524bc59 = 0;
      }
    }

    if(isDefined(params.eattacker.var_4927d3d[params.weapon.name])) {
      if(params.smeansofdeath === "MOD_MELEE" && params.eattacker.var_4927d3d[params.weapon.name].var_9ccfda84 > gettime() - 2000 && params.eattacker.var_4927d3d[params.weapon.name].on_cooldown === 0) {
        params.eattacker.var_4927d3d[params.weapon.name].var_e1ebf0a8++;
        params.eattacker.var_4927d3d[params.weapon.name].var_9ccfda84 = gettime() + 2000;

        if(params.eattacker.var_4927d3d[params.weapon.name].var_e1ebf0a8 >= 5) {
          processscoreevent("melee_weapon_multikill_zm", params.eattacker, undefined, params.weapon);
          params.eattacker stats::function_561716e6(params.weapon.name, #"hash_7bf29fa438d54aad", 1);
          params.eattacker zm_stats::increment_challenge_stat(#"hash_726e331558583e86");
          params.eattacker zm_stats::function_7ec42fbf(#"hash_17759c33232585f");
          params.eattacker zm_stats::function_51c1448(#"hash_cb6c1fa7289ca52", 1, #"hash_f9572f1792a7862", #"melee_sai_t9_dw");
          params.eattacker zm_stats::function_17ee4529(#"hash_513bcd963a91db81", 1, #"hash_735ace6b22542a65");
          params.eattacker.var_4927d3d[params.weapon.name].var_9ccfda84 = gettime();
          params.eattacker.var_4927d3d[params.weapon.name].var_e1ebf0a8 = 0;
        }
      } else if(params.eattacker.var_4927d3d[params.weapon.name].var_9ccfda84 < gettime()) {
        params.eattacker.var_4927d3d[params.weapon.name].var_9ccfda84 = gettime();
        params.eattacker.var_4927d3d[params.weapon.name].var_e1ebf0a8 = 1;
      }

      if(var_947d01ee === "shotgun") {
        if(!isDefined(params.eattacker.var_4927d3d[params.weapon.name].var_8d567858)) {
          params.eattacker.var_4927d3d[params.weapon.name].var_8d567858 = gettime();
        }

        if(!isDefined(params.eattacker.var_4927d3d[params.weapon.name].var_a0c3d1d8)) {
          params.eattacker.var_4927d3d[params.weapon.name].var_a0c3d1d8 = 0;
        }

        params.eattacker.var_4927d3d[params.weapon.name].var_a0c3d1d8++;

        if(params.eattacker.var_4927d3d[params.weapon.name].var_8d567858 > gettime() - 2000) {
          if(params.eattacker.var_4927d3d[params.weapon.name].var_a0c3d1d8 >= 10) {
            params.eattacker.var_4927d3d[params.weapon.name].var_a0c3d1d8 = 0;
            params.eattacker.var_4927d3d[params.weapon.name].var_8d567858 = undefined;
            params.eattacker stats::function_d0de7686(#"hash_2da7b8a1df41011c", 1, #"hash_37fcfdb6e2a551aa");
          } else {
            params.eattacker.var_4927d3d[params.weapon.name].var_8d567858 = gettime();
          }
        } else {
          params.eattacker.var_4927d3d[params.weapon.name].var_a0c3d1d8 = 1;
          params.eattacker.var_4927d3d[params.weapon.name].var_8d567858 = gettime();
        }
      }

      if(!isDefined(params.eattacker.var_4927d3d[params.weapon.name].var_8935d078)) {
        params.eattacker.var_4927d3d[params.weapon.name].var_8935d078 = gettime();
      }

      if(!isDefined(params.eattacker.var_4927d3d[params.weapon.name].var_541b7be6)) {
        params.eattacker.var_4927d3d[params.weapon.name].var_541b7be6 = 0;
      }

      params.eattacker.var_4927d3d[params.weapon.name].var_541b7be6++;

      if(params.eattacker.var_4927d3d[params.weapon.name].var_8935d078 > gettime() - 2000) {
        w_base = zm_weapons::get_base_weapon(params.weapon);

        if(w_base.name === # "special_ballisticknife_t9_dw") {
          var_95d7a0e4 = 10;
        } else {
          var_95d7a0e4 = 2;
        }

        if(params.eattacker.var_4927d3d[params.weapon.name].var_541b7be6 >= var_95d7a0e4) {
          params.eattacker.var_4927d3d[params.weapon.name].var_541b7be6 = 0;
          params.eattacker.var_4927d3d[params.weapon.name].var_8935d078 = undefined;
          params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"rapidkills", 1);
        } else {
          params.eattacker.var_4927d3d[params.weapon.name].var_8935d078 = gettime();
        }
      } else {
        params.eattacker.var_4927d3d[params.weapon.name].var_541b7be6 = 1;
        params.eattacker.var_4927d3d[params.weapon.name].var_8935d078 = gettime();
      }

      if(!params.eattacker function_f5c2c1ec()) {
        if(params.eattacker.var_4927d3d[params.weapon.name].var_81be4996 > gettime() - 100 && params.eattacker.var_4927d3d[params.weapon.name].on_cooldown === 0) {
          params.eattacker.var_4927d3d[params.weapon.name].oneshotmultikills++;
          params.eattacker.var_4927d3d[params.weapon.name].var_81be4996 = gettime() + 100;

          if(params.eattacker.var_4927d3d[params.weapon.name].oneshotmultikills === 5 && isDefined(params.weapon.statname)) {
            switch (params.weapon.statname) {
              case # "special_grenadelauncher_t9":
              case # "launcher_freefire_t9":
              case # "launcher_standard_t9":
                processscoreevent("oneshot_explosive_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker stats::function_561716e6(params.weapon.statname, #"hash_7bf29fa438d54aad", 1);
                params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"bigbang", 1);
                params.eattacker zm_stats::function_fbce465a(#"hash_3a26c3202d86e874");
                params.eattacker.var_4927d3d[params.weapon.name].var_81be4996 = gettime();
                break;
              default:
                break;
            }
          } else if(params.eattacker.var_4927d3d[params.weapon.name].oneshotmultikills === 3 && (params.weapon.statname !== # "launcher_freefire_t9" || params.weapon.statname !== # "special_grenadelauncher_t9" || params.weapon.statname !== # "launcher_standard_t9")) {
            if(isweapon(params.weapon) && !zm_loadout::is_lethal_grenade(params.weapon) && !zm_loadout::is_tactical_grenade(params.weapon) && !zm_loadout::is_placeable_mine(params.weapon) && !zm_loadout::is_melee_weapon(params.weapon)) {
              if(params.weapon.statname === # "special_crossbow_t9") {
                params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"bigbang", 1);
              }

              processscoreevent("oneshot_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker.var_4927d3d[params.weapon.name].var_81be4996 = gettime();
              params.eattacker zm_stats::function_fbce465a(#"hash_734efd49f53925b");
            }
          }
        } else if(params.eattacker.var_4927d3d[params.weapon.name].var_81be4996 < gettime() - 100) {
          params.eattacker.var_4927d3d[params.weapon.name].var_81be4996 = gettime();
          params.eattacker.var_4927d3d[params.weapon.name].oneshotmultikills = 1;
        }
      }

      if(params.eattacker.var_4927d3d[params.weapon.name].time > gettime() - 2000 && params.eattacker.var_4927d3d[params.weapon.name].on_cooldown === 0) {
        if(isDefined(params.weapon.name)) {
          switch (params.weapon.name) {
            case # "frost_blast":
            case # "frost_blast_1":
            case # "frost_blast_3":
            case # "frost_blast_2":
            case # "frost_blast_5":
            case # "frost_blast_4":
              if(isDefined(params.eattacker.var_4927d3d[# "frost_blast"])) {
                if(params.eattacker.var_4927d3d[# "frost_blast"].time > gettime() - 2000 && params.eattacker.var_4927d3d[# "frost_blast"].on_cooldown === 0) {
                  params.eattacker.var_4927d3d[# "frost_blast"].multikills++;
                  params.eattacker.var_4927d3d[# "frost_blast"].time = gettime() + 2000;

                  if(params.eattacker.var_4927d3d[# "frost_blast"].multikills === 3) {
                    params.eattacker stats::function_622feb0d(#"frost_blast", #"hash_7bf29fa438d54aad", 1);
                    processscoreevent("frost_blast_multikill_zm", params.eattacker, undefined, params.weapon);
                    params.eattacker contracts::increment_zm_contract(#"hash_4a72dbfac556f4ad");
                    params.eattacker function_deb933ff();
                    var_d4907104 = 1;
                  }
                } else if(params.eattacker.var_4927d3d[# "frost_blast"].time < gettime()) {
                  params.eattacker.var_4927d3d[# "frost_blast"] = {
                    #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
                  };
                }
              } else {
                params.eattacker.var_4927d3d[# "frost_blast"] = {
                  #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
                };
              }

              break;
            default:
              params.eattacker.var_4927d3d[params.weapon.name].multikills++;
              params.eattacker.var_4927d3d[params.weapon.name].time = gettime() + 2000;
              break;
          }
        } else {
          params.eattacker.var_4927d3d[params.weapon.name].multikills++;
          params.eattacker.var_4927d3d[params.weapon.name].time = gettime() + 2000;
        }

        if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 10) {
          params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"multikill", 1);
        }

        if(var_1c91bc3c === 1) {
          if(params.eattacker.var_4927d3d[params.weapon.name].var_1c91bc3c === 1) {
            params.eattacker.var_4927d3d[params.weapon.name].var_510ca9f9++;

            if(params.eattacker.var_4927d3d[params.weapon.name].var_510ca9f9 === 3) {
              if(params.weapon.statname === # "special_crossbow_t9") {
                params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"rapidkills", 1);
              }

              params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"criticalmultikill", 1);
              params.eattacker.var_4927d3d[params.weapon.name].var_510ca9f9 = 0;
            }
          } else {
            params.eattacker.var_4927d3d[params.weapon.name].var_510ca9f9 = 1;
          }
        }

        if(isDefined(params.weapon.name)) {
          switch (params.weapon.name) {
            case # "energy_mine":
            case # "energy_mine_4":
            case # "energy_mine_5":
            case # "energy_mine_2":
            case # "energy_mine_3":
            case # "energy_mine_1":
            case # "hash_7e4053e6965bafa7":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3) {
                params.eattacker stats::function_622feb0d(#"energy_mine", #"hash_7bf29fa438d54aad", 1);
                processscoreevent("energy_mine_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_291784e921549410");
                params.eattacker function_deb933ff();
                reset_values = 1;
              } else if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 15) {
                params.eattacker zm_stats::increment_challenge_stat(#"hash_2bcf4fba492d765a");
              }

              break;
          }
        }

        if(isDefined(params.weapon.name) && killstreaks::is_killstreak_weapon(params.weapon) && params.enemy.damagemod !== "MOD_MELEE") {
          switch (params.weapon.name) {
            case # "gun_ultimate_turret":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 5) {
                params.eattacker stats::function_8fb23f94(#"ultimate_turret", #"hash_7bf29fa438d54aad", 1);
                processscoreevent("sentry_turret_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker zm_stats::increment_challenge_stat(#"hash_30f04720fb250afb");
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "sig_lmg":
              if(getdvarint(#"hash_5c49df97f4f82e12", 0) && params.eattacker.var_4927d3d[params.weapon.name].multikills === 5) {
                processscoreevent("soa_death_machine_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker zm_stats::function_17ee4529(#"hash_122768477016f4e5", 1, #"hash_5c49df97f4f82e12");
                reset_values = 0;
              } else if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 10) {
                if(getdvarint(#"hash_5c49df97f4f82e12", 0)) {
                  processscoreevent("soa_death_machine_multikill_zm", params.eattacker, undefined, params.weapon);
                  params.eattacker zm_stats::function_17ee4529(#"hash_122768477016f4e5", 1, #"hash_5c49df97f4f82e12");
                } else {
                  processscoreevent("death_machine_multikill_zm", params.eattacker, undefined, params.weapon);
                }

                params.eattacker contracts::increment_zm_contract(#"hash_373ccb70a9ba33f8");
                params.eattacker stats::function_8fb23f94(#"sig_lmg", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "hero_annihilator":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3) {
                processscoreevent("hand_cannon_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_7f2cbf48327c2513");
                params.eattacker stats::function_8fb23f94(#"hero_annihilator", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "hero_flamethrower":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3) {
                processscoreevent("flamethrower_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_1f555a384246b0de");
                params.eattacker stats::function_8fb23f94(#"hero_flamethrower", #"hash_7bf29fa438d54aad", 1);
                params.eattacker zm_stats::function_17ee4529(#"hash_513bc9963a91d4b5", 1, #"hash_735ace6b22542a65");
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "remote_missile":
            case # "remote_missile_bomblet":
            case # "remote_missile_missile":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 5) {
                processscoreevent("cruise_missile_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_1a6125474b0d46e1");
                params.eattacker stats::function_8fb23f94(#"remote_missile_zm", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "hero_pineapplegun":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3) {
                processscoreevent("grenade_launcher_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_77c4f06d1c02d2d7");
                params.eattacker stats::function_8fb23f94(#"hero_pineapplegun", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "sig_bow_flame":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3) {
                processscoreevent("combat_bow_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_1bdaa70759b87110");
                params.eattacker stats::function_8fb23f94(#"sig_bow_flame", #"hash_7bf29fa438d54aad", 1);
                params.eattacker zm_stats::function_17ee4529(#"hash_513bc9963a91d4b5", 1, #"hash_735ace6b22542a65");
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "planemortar":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3) {
                processscoreevent("artillery_strike_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker zm_stats::increment_challenge_stat(#"hash_152390f1e6352547");
                params.eattacker contracts::increment_zm_contract(#"hash_5f0960d2a8cfa351");
                params.eattacker stats::function_8fb23f94(#"planemortar", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "napalm_strike":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 5) {
                params.eattacker contracts::increment_zm_contract(#"hash_fc717066caec57c");
                processscoreevent("napalm_strike_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker zm_stats::increment_challenge_stat(#"hash_4a546c8840434f5b");
                params.eattacker stats::function_8fb23f94(#"napalm_strike", #"hash_7bf29fa438d54aad", 1);
                params.eattacker zm_stats::function_17ee4529(#"hash_513bc9963a91d4b5", 1, #"hash_735ace6b22542a65");
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "hash_1734871fef9c0549":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 5) {
                processscoreevent("chopper_gunner_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker stats::function_8fb23f94(#"chopper_gunner", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
            case # "recon_car_zm":
              if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 5) {
                processscoreevent("arcxd_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker stats::function_8fb23f94(#"recon_car_zm", #"hash_7bf29fa438d54aad", 1);
                params.eattacker function_529d54aa();
                reset_values = 1;
              }

              break;
          }
        }

        if(isDefined(params.smeansofdeath) && (params.smeansofdeath == "MOD_RIFLE_BULLET" || params.smeansofdeath == "MOD_PISTOL_BULLET")) {
          if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 5 && isDefined(params.weapon.name)) {
            params.eattacker stats::function_561716e6(params.weapon.name, #"hash_7bf29fa438d54aad", 1);
          }
        }

        if(params.eattacker.var_4927d3d[params.weapon.name].multikills === 3 && isDefined(params.weapon.name)) {
          switch (params.weapon.name) {
            case # "eq_sticky_grenade":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              processscoreevent("semtex_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker stats::function_622feb0d(#"eq_sticky_grenade", #"hash_7bf29fa438d54aad", 1);
              params.eattacker contracts::increment_zm_contract(#"hash_2a3b30f3663d00ed");
              params.eattacker function_5fb97568();
              reset_values = 1;
              break;
            case # "satchel_charge":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              processscoreevent("satchel_charge_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker stats::function_622feb0d(#"satchel_charge", #"hash_7bf29fa438d54aad", 1);
              params.eattacker contracts::increment_zm_contract(#"hash_4382dd5d9e99a17a");
              params.eattacker function_5fb97568();
              reset_values = 1;
              break;
            case # "frag_grenade":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              processscoreevent("frag_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker stats::function_622feb0d(#"eq_frag_grenade", #"hash_7bf29fa438d54aad", 1);
              params.eattacker contracts::increment_zm_contract(#"hash_52f740ced65f6ee1");
              params.eattacker function_5fb97568();
              reset_values = 1;
              break;
            case # "cymbal_monkey":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              processscoreevent("monkey_bomb_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker stats::function_622feb0d(#"cymbal_monkey", #"hash_7bf29fa438d54aad", 1);
              params.eattacker contracts::increment_zm_contract(#"hash_331f341976ba7749");
              reset_values = 1;
              break;
            case # "molotov_fire":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              params.eattacker contracts::increment_zm_contract(#"hash_57299228edd7d8ad");
              params.eattacker stats::function_622feb0d(#"eq_molotov", #"hash_7bf29fa438d54aad", 1);
              processscoreevent("molotov_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker zm_stats::function_17ee4529(#"hash_513bc9963a91d4b5", 1, #"hash_735ace6b22542a65");
              params.eattacker function_5fb97568();
              reset_values = 1;
              break;
            case # "eq_slow_grenade":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              params.eattacker contracts::increment_zm_contract(#"hash_3b1aea9829803ac1");
              params.eattacker stats::function_622feb0d(#"eq_slow_grenade", #"hash_7bf29fa438d54aad", 1);
              processscoreevent("concussion_grenade_multikill_zm", params.eattacker, undefined, params.weapon);
              reset_values = 1;
              break;
            case # "hatchet":
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              params.eattacker stats::function_622feb0d(#"hatchet", #"hash_7bf29fa438d54aad", 1);
              params.eattacker function_5fb97568();

              if(getdvarint(#"hash_5c49df97f4f82e12", 0)) {
                processscoreevent("soa_hatchet_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker zm_stats::function_17ee4529(#"hash_725adb52613ffb99", 1, #"hash_5c49df97f4f82e12");
              } else {
                processscoreevent("combat_axe_multikill_zm", params.eattacker, undefined, params.weapon);
              }

              reset_values = 1;
              break;
            case # "hash_6a4dd5ed56f6e3f6":
              params.eattacker stats::function_622feb0d(#"hash_6a4dd5ed56f6e3f6", #"hash_7bf29fa438d54aad", 1);
              params.eattacker zm_stats::increment_challenge_stat(#"hash_60594d8f8bc8764b");
              params.eattacker zm_stats::increment_challenge_stat(#"hash_7ae5fe673f863826");
              processscoreevent("lt53_kazimir_multikill_zm", params.eattacker, undefined, params.weapon);
              reset_values = 1;
              break;
            case # "ww_ieu_gas_t9_upgraded":
            case # "ww_ieu_plasma_t9_upgraded":
            case # "ww_ieu_acid_t9_upgraded":
            case # "ww_ieu_shockwave_t9_upgraded":
            case # "ww_ieu_shockwave_t9":
            case # "ww_ieu_electric_t9_upgraded":
            case # "ww_ieu_electric_t9":
            case # "ww_ieu_acid_t9":
            case # "ww_ieu_gas_t9":
            case # "ww_ieu_plasma_t9":
              processscoreevent("ieu_multikill_zm", params.eattacker, undefined, params.weapon);
              reset_values = 1;
              break;
            case # "ww_mega_barrel_fullauto_copycat_t9_upgraded":
            case # "ww_mega_barrel_fullauto_copycat_t9":
              params.eattacker notify(#"hash_44abe1c14b998f86", {
                #weapon_name: params.weapon.name
              });
              processscoreevent("crbrs_multikill_zm", params.eattacker, undefined, params.weapon);
              reset_values = 1;
              break;
            case # "ww_mega_barrel_fullauto_blazer_beam_t9":
            case # "ww_mega_barrel_fullauto_diffusion_beam_t9_upgraded":
            case # "ww_mega_barrel_fullauto_diffusion_beam_t9":
            case # "ww_mega_barrel_fullauto_blazer_beam_t9_upgraded":
            case # "ww_mega_barrel_fullauto_micro_missile_t9_upgraded":
            case # "ww_mega_barrel_fullauto_micro_missile_t9":
              processscoreevent("crbrs_variants_multikill_zm", params.eattacker, undefined, params.weapon);
              params.eattacker notify(#"hash_44abe1c14b998f86", {
                #weapon_name: params.weapon.name
              });
              reset_values = 1;
              break;
          }
        }

        if(is_true(reset_values)) {
          params.eattacker.var_4927d3d[params.weapon.name].player = params.eattacker;
          params.eattacker.var_4927d3d[params.weapon.name].time = gettime();
          params.eattacker.var_4927d3d[params.weapon.name].weapon = params.weapon;
        } else if(is_true(var_d4907104)) {
          params.eattacker.var_4927d3d[params.weapon.name].player = params.eattacker;
          params.eattacker.var_4927d3d[params.weapon.name].time = gettime();
          params.eattacker.var_4927d3d[params.weapon.name].weapon = params.weapon;
          params.eattacker.var_4927d3d[# "frost_blast"].player = params.eattacker;
          params.eattacker.var_4927d3d[# "frost_blast"].time = gettime();
          params.eattacker.var_4927d3d[# "frost_blast"].weapon = params.weapon;
        }
      } else if(params.eattacker.var_4927d3d[params.weapon.name].time < gettime()) {
        if(is_true(var_1c91bc3c)) {
          var_4105b7a0 = 1;
        } else {
          var_4105b7a0 = 0;
        }

        if(params.smeansofdeath === "MOD_MELEE") {
          var_b8275b80 = 1;
        } else {
          var_b8275b80 = 0;
        }

        params.eattacker.var_4927d3d[params.weapon.name] = {
          #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: var_1c91bc3c, #var_510ca9f9: var_4105b7a0, #oneshotmultikills: 1, #var_e1ebf0a8: var_b8275b80
        };
      }
    } else {
      if(is_true(var_1c91bc3c)) {
        var_4105b7a0 = 1;
      } else {
        var_4105b7a0 = 0;
      }

      if(params.smeansofdeath === "MOD_MELEE") {
        var_b8275b80 = 1;
      } else {
        var_b8275b80 = 0;
      }

      params.eattacker.var_4927d3d[params.weapon.name] = {
        #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: var_1c91bc3c, #var_510ca9f9: var_4105b7a0, #oneshotmultikills: 1, #var_e1ebf0a8: var_b8275b80
      };
    }
  }

  if(isDefined(params.eattacker.var_d93ab65) && params.eattacker.var_d93ab65.size > 0) {
    if(isDefined(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"])) {
      if(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].time > gettime() - 2000 && params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].on_cooldown === 0) {
        arrayremovevalue(params.eattacker.var_d93ab65, undefined);

        foreach(var_23662c1b in params.eattacker.var_d93ab65) {
          if(params.smeansofdeath === "MOD_MELEE" && zm_utility::is_player_valid(params.eattacker)) {
            params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"meleecombo", 1);
          }

          if(zm_utility::is_player_valid(var_23662c1b.owner, 0, 0)) {
            if(var_23662c1b.owner === params.eattacker) {
              if(!isDefined(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].multikills)) {
                params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].multikills = 0;
              }

              params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].multikills++;
              params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].time = gettime() + 2000;

              if(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].multikills >= 10 && !isDefined(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].var_d7f6715a) && isDefined(var_23662c1b) && !is_true(var_23662c1b.var_6ef480ca)) {
                if(isDefined(var_23662c1b)) {
                  var_23662c1b.var_6ef480ca = 1;
                }

                params.eattacker zm_stats::increment_challenge_stat(#"hash_3ada34911786e667");
                params.eattacker stats::function_dad108fa(#"hash_3a4cc9109fa72702", 1);
                params.eattacker stats::function_622feb0d(#"ring_of_fire", #"hash_7bf29fa438d54aad", 1);
                processscoreevent("ring_of_fire_multikill_zm", params.eattacker, undefined, params.weapon);
                params.eattacker contracts::increment_zm_contract(#"hash_aac5702f5f9c94d");
                params.eattacker zm_stats::function_17ee4529(#"hash_513bc9963a91d4b5", 1, #"hash_735ace6b22542a65");
                params.eattacker function_deb933ff();
                params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"] = {
                  #player: params.eattacker, #time: gettime() + 2000, #weapon: params.weapon, #multikills: 0, #var_d7f6715a: var_23662c1b
                };
              }
            }
          }
        }
      } else if(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].time < gettime()) {
        params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"] = {
          #player: params.eattacker, #time: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_d7f6715a: params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].var_d7f6715a
        };
      }
    } else {
      params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"] = {
        #player: params.eattacker, #time: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_d7f6715a: params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"].var_d7f6715a
      };
    }
  } else if(isDefined(params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"])) {
    params.eattacker.var_4927d3d[# "hash_7ed9a65979594954"] = undefined;
  }

  var_5f6e2918 = params.enemy.var_95d94ac4;

  if(!isDefined(var_5f6e2918)) {
    var_5f6e2918 = 5;
  }

  if(params.enemy ai::is_stunned() && isDefined(params.enemy.var_31cadcc9[# "eq_slow_grenade"]) && isDefined(params.enemy.var_31cadcc9[# "eq_slow_grenade"].time) && params.enemy.var_31cadcc9[# "eq_slow_grenade"].time > gettime() - var_5f6e2918 * 1000) {
    if(zm_utility::is_player_valid(params.eattacker, 0, 0)) {
      if(params.enemy.damagemod === "MOD_MELEE") {
        params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_1f451bc4d664e2ad", 1);
      }

      params.eattacker zm_challenges::function_d6b32ad3(params.weapon, #"hash_362cbd72d16eaa5d", 1);

      if(var_947d01ee === "ar") {
        params.eattacker stats::function_d0de7686(#"hash_20a9dbd1ca99a444", 1, #"hash_51465116c1efc9be");
      }
    }

    params.eattacker stats::function_6fb0b113(#"eq_slow_grenade", #"hash_6b0fbad1bb3b10f1");

    if(params.enemy.var_31cadcc9[# "eq_slow_grenade"].player === params.eattacker) {
      params.eattacker stats::function_6fb0b113(#"eq_slow_grenade", #"kills");
      params.eattacker contracts::increment_zm_contract(#"hash_4936408b808baff1");
    } else if(zm_utility::is_player_valid(params.enemy.var_31cadcc9[# "eq_slow_grenade"].player)) {
      params.enemy.var_31cadcc9[# "eq_slow_grenade"].player stats::function_6fb0b113(#"eq_slow_grenade", #"assists");
    }

    if(params.enemy.zm_ai_category === # "elite") {
      processscoreevent("concussion_grenade_killingblow_elite_zm", params.eattacker, params.enemy, undefined, undefined, params);
    } else if(params.enemy.zm_ai_category === # "special") {
      processscoreevent("concussion_grenade_killingblow_special_zm", params.eattacker, params.enemy, undefined, undefined, params);
    } else {
      processscoreevent("concussion_grenade_killingblow_zm", params.eattacker, params.enemy, undefined, undefined, params);
    }

    if(params.enemy.var_31cadcc9[# "eq_slow_grenade"].player === params.eattacker) {
      if(isDefined(params.eattacker.var_4927d3d[# "concussed_kills"])) {
        if(params.eattacker.var_4927d3d[# "concussed_kills"].time > gettime() - 2000 && params.eattacker.var_4927d3d[# "concussed_kills"].on_cooldown === 0) {
          params.eattacker.var_4927d3d[# "concussed_kills"].var_ae122a53++;
          params.eattacker.var_4927d3d[# "concussed_kills"].time = gettime() + 2000;

          if(params.eattacker.var_4927d3d[# "concussed_kills"].var_ae122a53 >= 3) {
            params.eattacker zm_stats::increment_challenge_stat(#"hash_2ad38b3cd161c0e8");
            processscoreevent("concussion_grenade_multikill_zm", params.eattacker, undefined, params.weapon);
            params.eattacker stats::function_622feb0d(#"eq_slow_grenade", #"hash_7bf29fa438d54aad", 1);
            params.eattacker contracts::increment_zm_contract(#"hash_3b1aea9829803ac1");
            params.eattacker.var_4927d3d[# "concussed_kills"] = {
              #player: params.eattacker, #time: gettime() + 2000, #weapon: params.weapon, #var_ae122a53: 0
            };
          }
        } else if(params.eattacker.var_4927d3d[# "concussed_kills"].time < gettime()) {
          params.eattacker.var_4927d3d[# "concussed_kills"] = {
            #player: params.eattacker, #time: gettime() + 2000, #weapon: params.weapon, #var_ae122a53: 1, #on_cooldown: 0
          };
        }
      } else {
        params.eattacker.var_4927d3d[# "concussed_kills"] = {
          #player: params.eattacker, #time: gettime() + 2000, #weapon: params.weapon, #var_ae122a53: 1, #on_cooldown: 0
        };
      }
    }
  }

  if(zm_utility::is_player_valid(params.eattacker, 0, 0)) {
    if(params.enemy.damagemod === "MOD_UNKNOWN" && (params.weapon.name === # "hash_ac86d29509a8939" || params.weapon.name === # "hash_493fc891e20b4f8a")) {
      function_2bf1d1bb("ray_rifle_multikill_zm", params.eattacker, params.weapon.name, params.weapon, 2000, 10);
    } else if(params.enemy.damagemod === "MOD_MELEE" && (params.weapon.name === # "ww_axe_gun_melee_t9" || params.weapon.name === # "ww_axe_gun_melee_t9_upgraded")) {
      function_2bf1d1bb("crystal_axe_blade_multikill_zm", params.eattacker, params.weapon.name, params.weapon, 2000, 10);
    } else if(params.enemy.damagemod === "MOD_PISTOL_BULLET" && (params.weapon.name === # "hash_18696150427f2efb" || params.weapon.name === # "hash_7eab88123b09e2c")) {
      function_2bf1d1bb("crystal_axe_shardshooter_multikill_zm", params.eattacker, params.weapon.name, params.weapon, 2000, 10);
    } else if(params.enemy.damagemod === "MOD_EXPLOSIVE" && isDefined(params.eattacker.var_6de2953f) && params.eattacker.var_6de2953f > gettime() - 100) {
      function_2bf1d1bb("mechz_jetpack_multikill_zm", params.eattacker, #"mechz_jetpack", params.weapon, 2000, 3);
    }

    if(getdvarint(#"hash_5c49df97f4f82e12", 0)) {
      if(params.enemy.damagemod === "MOD_EXPLOSIVE" || params.enemy.damagemod === "MOD_PROJECTILE_SPLASH" || params.enemy.damagemod === "MOD_GRENADE_SPLASH") {
        var_e6309676 = function_2bf1d1bb("soa_explosion_multikill_zm", params.eattacker, #"hash_796b4920123a2915", params.weapon, 2000, 3);

        if(var_e6309676) {
          params.eattacker zm_stats::function_17ee4529(#"hash_3d48d424c78e2c71", 1, #"hash_5c49df97f4f82e12");
        }
      }

      if(var_947d01ee === "ar" || var_947d01ee === "smg" || var_947d01ee === "lmg") {
        if(!isDefined(params.eattacker.var_4927d3d[# "hash_77171abf81b62dfd"].var_4e54d7b2)) {
          function_2bf1d1bb("soa_multikill_without_reloading_auto_zm", params.eattacker, #"hash_77171abf81b62dfd", params.weapon, 2000, 10);
          params.eattacker.var_4927d3d[# "hash_77171abf81b62dfd"].var_4e54d7b2 = gettime();
        } else {
          var_b8e3bdf5 = !isDefined(params.eattacker.var_b6cd4a03) || params.eattacker.var_b6cd4a03 < params.eattacker.var_4927d3d[# "hash_77171abf81b62dfd"].var_4e54d7b2;

          if(var_b8e3bdf5) {
            var_e6309676 = function_2bf1d1bb("soa_multikill_without_reloading_auto_zm", params.eattacker, #"hash_77171abf81b62dfd", params.weapon, 2000, 10);

            if(var_e6309676) {
              params.eattacker zm_stats::function_17ee4529(#"hash_6c9bd8c5ae1a5496", 1, #"hash_5c49df97f4f82e12");
            }
          } else {
            params.eattacker.var_4927d3d[# "hash_77171abf81b62dfd"] = {
              #player: params.eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: params.weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
            };
          }
        }
      }

      w_base = zm_weapons::get_base_weapon(params.weapon);

      if(var_947d01ee === "melee" || params.enemy.damagemod === "MOD_MELEE" && w_base.name === # "special_ballisticknife_t9_dw") {
        var_e6309676 = function_2bf1d1bb("soa_melee_weapon_multikill_zm", params.eattacker, #"hash_562f799525140a69", params.weapon, 2000, 7);

        if(var_e6309676) {
          params.eattacker zm_stats::function_17ee4529(#"hash_5135a4983fb81980", 1, #"hash_5c49df97f4f82e12");
        }
      }
    }
  }

  if(zm_utility::is_player_valid(params.eattacker, 0, 0) && params.eattacker isinvehicle()) {
    veh = params.eattacker getvehicleoccupied();

    switch (veh getoccupantseat(params.eattacker)) {
      case 0:
        if(isvehicle(params.einflictor)) {
          function_2bf1d1bb("vehicle_impact_multikill_zm", params.eattacker, #"vehicle_driver", params.weapon, 2000, 3);

          if(params.enemy.zm_ai_category === # "elite" || params.enemy.zm_ai_category === # "special") {
            processscoreevent("vehicle_impact_kill_special_elite_zm", params.eattacker, params.enemy, params.weapon);
          }
        }

        break;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
      case 10:
        driver = veh getseatoccupant(0);

        if(isPlayer(driver)) {
          if(veh.scriptvehicletype === "player_fav_light" || veh.scriptvehicletype === "player_btr40" || veh.scriptvehicletype === "player_truck_transport") {
            function_2bf1d1bb("driver_fav_passenger_multikill_zm", driver, #"hash_597b0f997ce2f620", params.weapon, 2000, 3);
          }
        }

        if(isDefined(params.weapon) && is_true(params.weapon.var_29d24e37)) {
          params.eattacker contracts::increment_zm_contract(#"hash_19119ba23b3826c7");
          var_d285ed68 = function_2bf1d1bb("passenger_gunner_multikill_zm", params.eattacker, #"vehicle_turret", params.weapon, 2000, 3);

          if(var_d285ed68) {
            params.eattacker zm_stats::increment_challenge_stat(#"hash_4a0bf1a42205d8a1");
          }
        } else {
          var_1bfe9029 = function_2bf1d1bb("vehicle_weapon_multikill_zm", params.eattacker, #"vehicle_passenger", params.weapon, 2000, 3);

          if(var_1bfe9029) {
            params.eattacker zm_stats::increment_challenge_stat(#"hash_758066c25ccc99a8");
          }
        }

        break;
    }
  }

  if(isDefined(params.enemy.a_n_slowdown_timeouts[# "hash_10d83afaeb265fde"].timeout) && params.enemy.a_n_slowdown_timeouts[# "hash_10d83afaeb265fde"].timeout > gettime()) {
    params.eattacker zm_stats::increment_challenge_stat(#"hash_1fb0f883567707e2");
  }

  if(isDefined(params.enemy.var_a5cccd85) && params.enemy.var_a5cccd85 > gettime() - 300) {
    params.eattacker zm_stats::increment_challenge_stat(#"hash_6e761859bc1ffd3d");
  }

  if(params.enemy.zm_ai_category === # "elite") {
    if(isDefined(params.enemy.var_e293f8ac)) {
      function_1eaaceab(params.enemy.var_e293f8ac);

      if(params.enemy.var_e293f8ac.size === 0) {
        params.eattacker zm_stats::increment_challenge_stat(#"hash_45814ac55657fc62");
      }

      return;
    }

    params.eattacker zm_stats::increment_challenge_stat(#"hash_45814ac55657fc62");
  }
}

function function_5fb97568(amount = 1) {
  self zm_stats::function_fbce465a(#"hash_777765b99c34fecc", amount);
  self zm_stats::function_17ee4529(#"hash_5a975e436e73d75", amount, #"hash_6abe83944d701459");
}

function function_529d54aa(amount = 1) {
  self zm_stats::function_fbce465a(#"hash_7208e01496453768", amount);
  self zm_stats::function_17ee4529(#"hash_5a972e436e7385c", amount, #"hash_6abe83944d701459");
}

function function_deb933ff(amount = 1) {
  self zm_stats::function_17ee4529(#"hash_5a979e436e74441", amount, #"hash_6abe83944d701459");
}

function event_handler[reload] function_b4174270(eventstruct) {
  self.var_b6cd4a03 = gettime();
}

function function_2bf1d1bb(multikill_scoreevent, eattacker, weapon_name, weapon, var_5c5dff23, var_c7381107, var_6ccf95ba = 0) {
  if(isDefined(eattacker.var_4927d3d[weapon_name])) {
    if(eattacker.var_4927d3d[weapon_name].time > gettime() - var_5c5dff23 && eattacker.var_4927d3d[weapon_name].on_cooldown === 0) {
      eattacker.var_4927d3d[weapon_name].multikills++;
      eattacker.var_4927d3d[weapon_name].time = gettime() + var_5c5dff23;

      if(eattacker.var_4927d3d[weapon_name].multikills === var_c7381107) {
        processscoreevent(multikill_scoreevent, eattacker, undefined, weapon);

        if(var_6ccf95ba) {
          eattacker stats::function_622feb0d(weapon_name, #"hash_7bf29fa438d54aad", 1);
        }

        return true;
      }
    } else if(eattacker.var_4927d3d[weapon_name].time < gettime()) {
      eattacker.var_4927d3d[weapon_name] = {
        #player: eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
      };
    }
  } else {
    eattacker.var_4927d3d[weapon_name] = {
      #player: eattacker, #time: gettime(), #var_81be4996: gettime(), #var_9ccfda84: gettime(), #weapon: weapon, #multikills: 1, #on_cooldown: 0, #var_1c91bc3c: undefined, #var_510ca9f9: undefined, #oneshotmultikills: 1, #var_e1ebf0a8: undefined
    };
  }

  return false;
}

function get_distance_for_weapon(weapon, weaponclass = util::getweaponclass(weapon)) {
  distance = 0;

  if(!isDefined(weaponclass)) {
    return 0;
  }

  if(weapon.statname === # "pistol_shotgun_t9") {
    return 187489;
  }

  switch (weaponclass) {
    case # "weapon_smg":
      distance = 1960000;
      break;
    case # "weapon_assault":
      distance = 2560000;
      break;
    case # "weapon_tactical":
      distance = 2560000;
      break;
    case # "weapon_lmg":
      distance = 2560000;
      break;
    case # "weapon_sniper":
      distance = 4000000;
      break;
    case # "weapon_pistol":
      distance = 1000000;
      break;
    case # "weapon_cqb":
      distance = 302500;
      break;
    case # "weapon_special":
      baseweapon = weapon.rootweapon;

      if(weapon.isballisticknife || baseweapon == level.weaponspecialcrossbow) {
        distance = 2250000;
      }

      break;
    case # "weapon_grenade":
      if(weapon.rootweapon.name == "hatchet") {
        distance = 2250000;
      }

      break;
    default:
      distance = 0;
      break;
  }

  return distance;
}

function function_8fb658e2(params) {
  if(is_true(params.einflictor.aat_turned) || is_true(params.enemy.aat_turned) || is_true(params.enemy.var_f42aed2a) || is_true(params.enemy.var_b70158b5) || is_true(params.enemy.var_865b1595) || params.enemy.archetype === # "zombie_dog") {
    return;
  }

  if(zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath) && isDefined(params.enemy.archetype) && params.enemy.archetype !== # "zombie_dog" && function_39571ae(params.eattacker, params.enemy)) {
    statname = # "hash_25f082a4f62ed553";
  } else if(params.eattacker function_f5c2c1ec()) {
    statname = # "hash_46c54199043c3149";
  } else {
    statname = # "hash_3e68a28d3c2e0479";
  }

  var_42648a02 = level.var_42648a02[statname];

  if(isDefined(var_42648a02) && var_42648a02[1] > randomfloatrange(0, 1)) {
    function_31eb1b07(params.eattacker, statname, var_42648a02[0], var_42648a02[3], params.weapon);
  }
}

function private function_39571ae(player, enemy) {
  if(!isDefined(player) || !isDefined(enemy)) {
    return false;
  }

  n_dist = distancesquared(player.origin, enemy.origin);

  if(n_dist >= 122500 && n_dist <= 1440000) {
    return true;
  }

  return false;
}

function function_f5c2c1ec() {
  if(zm_utility::is_player_valid(self, 0, 0) && self isinvehicle()) {
    veh = self getvehicleoccupied();

    if(isDefined(veh) && veh getoccupantseat(self) === 0) {
      return true;
    }

    if(isDefined(veh.var_260e3593) && veh getoccupantseat(self) === veh.var_260e3593) {
      return true;
    }
  }

  return false;
}