/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\contracts.gsc
***********************************************/

#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#namespace contracts;

function private autoexec __init__system__() {
  system::register(#"contracts", &preinit, undefined, &finalize_init, undefined);
}

function private preinit() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }

  init_player_contract_events();
}

function private finalize_init() {
  callback::on_connect(&on_player_connect);

  if(can_process_contracts()) {
    register_player_contract_event(#"headshot", &on_headshot_kill, 1);
    register_player_contract_event(#"air_assault_total_kills", &function_a0045e6a);
    register_player_contract_event(#"hash_10b0c56ae630070d", &function_8af6a5a);
    challenges::registerchallengescallback("playerKilled", &contract_kills);
    challenges::registerchallengescallback("gameEnd", &function_a4c8ce2a);
    challenges::registerchallengescallback("roundEnd", &function_3b024dd1);
    globallogic_score::registercontractwinevent(&contract_win);
    register_player_contract_event(#"double_kill", &function_a7a24a36, 1);
    register_player_contract_event(#"ekia", &on_ekia, 2);
    register_player_contract_event(#"objective_ekia", &on_objective_ekia);
    register_player_contract_event(#"objective_kill", &function_23ddb75);
    register_player_contract_event(#"offender_kill", &function_c933f2f5);
    register_player_contract_event(#"defender_kill", &function_9aa7974e);
    register_player_contract_event(#"hash_2f3b5cfd90466f60", &function_fb608f0a, 1);
    register_player_contract_event(#"hash_32ed5d2b274397c1", &function_4b024d04);
    register_player_contract_event(#"killstreak_activated", &function_2065738f, 1);
    level.var_79a93566 = &function_902ef0de;
    level.var_d9ae19f0 = &function_d9ae19f0;
    level.var_c3e2bb05 = 1;

    thread devgui_setup();
  }
}

function function_2065738f(killstreaktype) {
  if(!isDefined(self.pers[# "hash_4165475c88607447"])) {
    self.pers[# "hash_4165475c88607447"] = 0;
  }

  self.pers[# "hash_4165475c88607447"]++;
  self increment_contract(#"hash_bf49eb59a524a2c");

  if(self.pers[# "hash_4165475c88607447"] == 5) {
    self increment_contract(#"hash_60af0937d49dbe4f");
  }

  switch (killstreaktype) {
    case # "counteruav":
    case # "inventory_counteruav":
      self increment_contract(#"hash_55d5fc464b179a45");
      break;
    case # "uav":
    case # "inventory_uav":
      self increment_contract(#"hash_5faef94f35522583");
      break;
  }
}

function function_a7a24a36(weaponname) {
  attacker = self;

  switch (weaponname) {
    case # "frag_grenade":
      attacker increment_contract(#"hash_2414160d464f90ae");
      attacker increment_contract(#"hash_255d9fb4f18be3d4");
      break;
    case # "eq_molotov":
      attacker increment_contract(#"hash_28eee88b752d363a");
      attacker increment_contract(#"hash_255d9fb4f18be3d4");
      break;
    case # "satchel_charge":
      attacker increment_contract(#"hash_296479e90e353da1");
      attacker increment_contract(#"hash_255d9fb4f18be3d4");
      break;
    case # "eq_sticky_grenade":
      attacker increment_contract(#"hash_46ab1787f07dba5a");
      attacker increment_contract(#"hash_255d9fb4f18be3d4");
      break;
    case # "remote_missile":
      attacker increment_contract(#"hash_772e19fad283c8cf");
      break;
    case # "sig_bow_flame":
      attacker increment_contract(#"hash_6e992792aaf0dc10");
      break;
    case # "hero_pineapplegun":
      attacker increment_contract(#"hash_2977fecb56dd9b59");
      break;
    case # "recon_car":
      attacker increment_contract(#"hash_3d11e20647031a01");
      break;
    case # "blind_swat_grenade":
      attacker increment_contract(#"hash_42bc58cf2628c9ea");
      break;
    case # "hash_1527a22d8a6fdc21":
      attacker increment_contract(#"hash_48b83e73148056f6");
      break;
    case # "gadget_supplypod":
      attacker increment_contract(#"hash_2c52346554f155a5");
      break;
    case # "gadget_jammer":
      attacker increment_contract(#"hash_85cce48722a5003");
      break;
    case # "land_mine":
      attacker increment_contract(#"hash_40b0132274ac999");
      break;
    case # "tear_gas":
      attacker increment_contract(#"hash_4c13df5a3ef481e");
      break;
  }
}

function on_player_connect() {
  if(can_process_contracts()) {
    self setup_player_contracts(3, &function_90a854d2);
  }
}

function can_process_contracts() {
  if(getdvarint(#"contracts_enabled", 0) == 0) {
    return false;
  }

  if(getdvarint(#"contracts_enabled_mp", 1) == 0) {
    return false;
  }

  if(!(sessionmodeismultiplayergame() || sessionmodeiswarzonegame())) {
    return false;
  }

  if(level.var_73e51905 === 1) {
    return false;
  }

  return challenges::canprocesschallenges();
}

function contract_kills(data) {
  victim = data.victim;
  attacker = data.attacker;
  weapon = data.weapon;
  time = data.time;
  meansofdeath = data.smeansofdeath;

  if(weapons::isbulletdamage(meansofdeath)) {
    if(data.var_4c540e11 === 1) {
      attacker function_fd9fb79b(#"hash_6ed18c0ae164ca6f");
    } else {
      attacker function_fd9fb79b(#"hash_cc910f2e4f6e794");
    }
  } else if(weapons::ismeleemod(meansofdeath)) {
    if(meansofdeath === "MOD_MELEE_WEAPON_BUTT") {
      attacker function_fd9fb79b(#"hash_62601e47893fe859");
    }

    if(isDefined(data.var_26aed950[# "talent_deadsilence"])) {
      attacker function_fd9fb79b(#"hash_487a310ab6f55d17");
    }
  }

  weaponclass = util::getweaponclass(weapon);

  switch (weaponclass) {
    case # "weapon_knife":
      attacker function_fd9fb79b(#"hash_68ff70af9c6dc38e");
      break;
    case # "weapon_grenade":
      attacker function_fd9fb79b(#"hash_36c6e603e324874f");

      if(attacker function_db654c9(attacker.class_num, #"hash_4a12859000892dda")) {
        attacker function_fd9fb79b(#"hash_54de00dedfb8d882");
      }

      switch (weapon.statname) {
        case # "frag_grenade":
          attacker function_fd9fb79b(#"hash_4ab0678e609789bc");
          break;
        case # "eq_molotov":
          attacker function_fd9fb79b(#"hash_64d9cceff0f494c0");
          break;
        case # "eq_sticky_grenade":
          attacker function_fd9fb79b(#"hash_1d6f62c9feb07e20");
          break;
        case # "satchel_charge":
          attacker function_fd9fb79b(#"hash_21d156cd866d1a31");
          break;
        default:
          break;
      }
    case # "weapon_sniper":
      if(data.var_b0985dfc === 1) {
        attacker function_fd9fb79b(#"hash_51b6e9ab0fafc1d3");
      }

      break;
    default:
      break;
  }

  if(weapon.statname == # "land_mine") {
    attacker function_fd9fb79b(#"hash_6d99dd47b6819429");

    if(data.washacked === 1) {
      attacker function_fd9fb79b(#"hash_211bbd0f79bedaee");
    }
  }

  if(util::function_ed82a8a(weapon).loadoutslotname === "secondary") {
    attacker function_fd9fb79b(#"hash_482cefb4f3e4112c");
  }

  if(attacker hasperk(#"specialty_gpsjammer") && isDefined(level.activeuavs[victim.team]) && level.activeuavs[victim.team] > 0) {
    attacker function_fd9fb79b(#"hash_5d86bfc0085e782");
  }

  iskillstreak = isDefined(data.einflictor) && isDefined(data.einflictor.killstreakid);

  if(!iskillstreak && isDefined(level.iskillstreakweapon)) {
    iskillstreakweapon = [[level.iskillstreakweapon]](weapon);
  }

  if(iskillstreak || iskillstreakweapon === 1) {
    attacker function_fd9fb79b(#"hash_49d55f63ca883bf7");

    switch (weapon.statname) {
      case # "ac130":
        attacker function_fd9fb79b(#"hash_72605357218516e7");
        break;
      case # "recon_car":
        attacker function_fd9fb79b(#"hash_3c0c11fff49055d1");
        break;
      case # "planemortar":
        attacker function_fd9fb79b(#"hash_f46876334e34517");
        break;
      case # "remote_missile":
        attacker function_fd9fb79b(#"hash_1801dc5071019f1c");
        break;
      case # "hash_ed62df533816471":
      case # "napalm_strike":
        attacker function_fd9fb79b(#"hash_671056a002339a47");
        break;
      case # "sig_bow_flame":
        attacker function_fd9fb79b(#"hash_3595f542499fc68e");
        break;
      case # "sig_lmg":
        attacker function_fd9fb79b(#"hash_3cea69f39468dbe");
        break;
      case # "hero_annihilator":
        attacker function_fd9fb79b(#"hash_3b9fea4775b0688b");
        break;
      case # "hero_flamethrower":
        attacker function_fd9fb79b(#"hash_34b472512f87deca");
        break;
      case # "ultimate_turret":
        attacker function_fd9fb79b(#"hash_3a5a17dc41083865");
        break;
      case # "hero_pineapplegun":
        attacker function_fd9fb79b(#"hash_e160390bc7706a6");
        break;
      case # "supplydrop_marker":
        attacker function_fd9fb79b(#"hash_75f061e34769e78e");
        break;
      case # "helicopter_comlink":
        attacker function_fd9fb79b(#"hash_4bafcb75a048607b");
        break;
      case # "killstreak_straferun":
        attacker function_fd9fb79b(#"hash_6efdce6f0a3f1ab3");
        break;
      default:
        break;
    }

    if(weapon.issupplydropweapon === 1) {
      attacker function_fd9fb79b(#"hash_75f061e34769e78e");
    }
  }

  if(weapon.var_29d24e37 === 1) {
    attacker function_fd9fb79b(#"hash_768c7a6a36bcc892");
  }

  if(data.var_89187b46 === 1) {
    attacker function_fd9fb79b(#"hash_34e6da572a9a4365");

    if(data.var_8e0c4587.vehicleclass === "plane" || data.var_8e0c4587.vehicleclass === "helicopter") {
      attacker function_fd9fb79b(#"hash_2cb02550d0d53e98");
    } else if(!(data.var_8e0c4587.vehicleclass === "boat")) {
      attacker function_fd9fb79b(#"hash_7d38cb26403f57a6");
    }
  }

  if(data.var_58ecc225 === 1) {
    attacker function_fd9fb79b(#"hash_3cfd4a88fedc0909");
  }

  if(data.var_4e8a56b1 === 1) {
    attacker function_fd9fb79b(#"hash_5bcc57fa4fb8b497");
  }

  if(data.victimweapon.iscarriedkillstreak === 1) {
    attacker function_fd9fb79b(#"hash_20d87fd5522b859f");
  }
}

function on_ekia(weapon, victim) {
  attacker = self;
  attacker function_fd9fb79b(#"hash_224789279d37fc30");

  if(level.hardcoremode) {
    attacker function_fd9fb79b(#"contract_mp_hardcore_ekia");
  }

  switch (level.basegametype) {
    case # "fireteam_dirty_bomb":
      attacker function_fd9fb79b(#"hash_72338a9a4e12ba3a");
      break;
  }

  var_6b9aa5a0 = undefined;
  weaponclass = util::getweaponclass(weapon);

  if(!isDefined(weaponclass)) {
    weaponclass = # "unspecified";
  }

  switch (weaponclass) {
    case # "weapon_assault":
      var_6b9aa5a0 = # "hash_1005918e22a7865b";
      break;
    case # "weapon_lmg":
      var_6b9aa5a0 = # "hash_151c8e7a35e1e380";
      break;
    case # "weapon_pistol":
      var_6b9aa5a0 = # "hash_250c2d8ef2261723";
      break;
    case # "weapon_cqb":
      var_6b9aa5a0 = # "hash_5262d5b92e0fdc2";
      break;
    case # "weapon_smg":
      var_6b9aa5a0 = # "hash_2173bc0bfcbdf90f";
      break;
    case # "weapon_sniper":
      var_6b9aa5a0 = # "hash_21762ab1513fddf";
      break;
    case # "weapon_tactical":
      var_6b9aa5a0 = # "hash_1a4fe101c7aab2d";
      break;
    default:
      break;
  }

  if(isDefined(var_6b9aa5a0)) {
    attacker function_fd9fb79b(var_6b9aa5a0);
    var_2323b107 = 1;
  }

  var_197329e6 = weapon.name == self function_b958b70d(attacker.class_num, "secondary");

  if(var_197329e6) {
    attacker function_fd9fb79b(#"hash_16a722c6820d552e");
  }

  var_8a4cfbd = 0;

  if(weapon.var_76ce72e8) {
    scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
    var_8a4cfbd = isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
  }

  if(var_8a4cfbd) {
    attacker increment_contract(#"hash_6b52fb637a3c29cb");
  } else if(weapon.issignatureweapon) {
    attacker increment_contract(#"hash_31a6484e36a0a20f");
  }

  var_29d5cadd = attacker gettotalunlockedweaponattachments(weapon);
  loadout_primary_weapon = attacker loadout::function_18a77b37("primary");
  loadout_secondary_weapon = attacker loadout::function_18a77b37("secondary");

  if(var_29d5cadd >= 3) {
    if(loadout_primary_weapon === weapon) {
      attacker function_fd9fb79b(#"contract_mp_attachments3_primary_ekia");
    } else if(loadout_secondary_weapon === weapon) {
      attacker function_fd9fb79b(#"hash_264228bd931f8deb");
    }
  }

  if(var_29d5cadd >= 5) {
    if(loadout_primary_weapon === weapon) {
      attacker function_fd9fb79b(#"hash_d18e3651f508489");
    } else if(loadout_secondary_weapon === weapon) {
      attacker function_fd9fb79b(#"hash_469703d9a67cf0dd");
    }
  }

  if(!isDefined(weapon.attachments) || weapon.attachments.size == 0) {
    if(var_2323b107 === 1 || weaponclass === "weapon_launcher" || weaponclass === "weapon_special" || weaponclass === "weapon_melee") {
      attacker increment_contract(#"hash_6b4ba21787557a2e");
    }
  } else if(weapon.attachments.size >= 8) {
    if(loadout_primary_weapon === weapon) {
      attacker function_fd9fb79b(#"hash_734fc032835c6780");
    }
  }

  if(isDefined(loadout_secondary_weapon) && attacker function_db654c9(attacker.class_num, #"hash_639ebbcda56447e7")) {
    secondaryweaponclass = util::getweaponclass(loadout_secondary_weapon);

    if(secondaryweaponclass === # "weapon_assault" || secondaryweaponclass === # "weapon_lmg" || secondaryweaponclass === # "weapon_smg" || secondaryweaponclass === # "weapon_sniper" || secondaryweaponclass === # "weapon_tactical") {
      attacker function_fd9fb79b(#"hash_6439891be84a20b1");
    }
  }

  if(isDefined(level.vip) && level.vip === victim) {
    attacker function_fd9fb79b(#"hash_26d4790af9efa59c");
  }

  if(armor::get_armor() > 0 && isDefined(self.var_c79fb13d)) {
    attacker function_fd9fb79b(#"hash_7d90475d2d43eefd");
  }

  if(attacker hastalent(#"hash_5c80935e7a319f21")) {
    attacker function_fd9fb79b(#"hash_3b74e771915a1263");
  }

  if(attacker hastalent(#"talent_logistics")) {
    attacker function_fd9fb79b(#"hash_4213c8e332e36c4d");
  }

  if(attacker hasperk(#"specialty_paranoia")) {
    attacker function_fd9fb79b(#"hash_3ad67e164e5906b2");
  }

  if(attacker hastalent(#"talent_tracker")) {
    attacker function_fd9fb79b(#"hash_4a24ab4cfce022a4");
  }

  if(attacker hastalent(#"talent_flakjacket")) {
    attacker function_fd9fb79b(#"hash_7f48d852921a86fb");
  }

  if(attacker hastalent(#"talent_gungho")) {
    attacker function_fd9fb79b(#"hash_7c13c5e5e969a553");
  }

  if(attacker util::function_14e61d05()) {
    attacker function_fd9fb79b(#"hash_5e65e91adf9f955e");
  }
}

function on_objective_ekia() {
  self increment_contract(#"contract_mp_objective_ekia");
}

function function_23ddb75() {
  self increment_contract(#"hash_210a710134dbdaaa");
}

function function_c933f2f5() {
  self increment_contract(#"hash_71d34a613b3ac387");
}

function function_9aa7974e() {
  self increment_contract(#"hash_23648f4b37ee8ba1");
}

function function_fd9fb79b(var_38280f2f, delta = 1) {
  if(self is_contract_active(var_38280f2f)) {
    self function_902ef0de(var_38280f2f, delta);
  }
}

function function_fb608f0a(weapon) {
  self increment_contract(#"hash_186da11489a29d82");

  if(weapon.statname == # "land_mine") {
    increment_contract(#"hash_4ef18c4603d407ad");
    return;
  }

  if(util::getweaponclass(weapon) === # "weapon_grenade") {
    increment_contract(#"hash_58b984c08b43c46a");

    if(weapon.statname == # "satchel_charge") {
      increment_contract(#"hash_16feef44241889e5");
    }
  }
}

function function_4b024d04() {
  var_c421e6b = undefined;

  switch (level.basegametype) {
    case # "fireteam_dirty_bomb":
      var_c421e6b = # "hash_3a3d0c0b64f00008";
      break;
  }

  self increment_contract(var_c421e6b);
}

function private function_902ef0de(var_38280f2f, delta) {
  if(getdvarint(#"scr_contract_debug_multiplier", 0) > 0) {
    delta *= getdvarint(#"scr_contract_debug_multiplier", 1);
  }

  if(delta <= 0) {
    return;
  }

  target_value = self.pers[# "contracts"][var_38280f2f].target_value;
  old_progress = isDefined(self.pers[# "contracts"][var_38280f2f].current_value) ? self.pers[# "contracts"][var_38280f2f].current_value : self.pers[# "contracts"][var_38280f2f].var_59cb904f;

  if(old_progress == target_value) {
    return;
  }

  new_progress = int(old_progress + delta);

  if(new_progress > target_value) {
    new_progress = target_value;
  }

  if(new_progress != old_progress) {
    self.pers[# "contracts"][var_38280f2f].current_value = new_progress;

    if(isDefined(level.contract_ids[var_38280f2f])) {
      self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.contract_ids[var_38280f2f], new_progress);
    }
  }

  if(old_progress < target_value && target_value <= new_progress) {
    var_9d12108c = isDefined(self.team) && isDefined(self.timeplayed[self.team]) ? self.timeplayed[self.team] : 0;
    self.pers[# "contracts"][var_38280f2f].var_be5bf249 = self stats::get_stat_global(#"time_played_total") - self.pers[# "hash_5651f00c6c1790a4"] + var_9d12108c;

    if(isDefined(level.contract_ids[var_38280f2f])) {
      self stats::function_dad108fa(#"hash_4c27fd1e8308d82b", 1);
      self stats::function_42277145(#"hash_777766b99c35007f", 1);
      self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.contract_ids[var_38280f2f]);
    }
  }

  if(getdvarint(#"scr_contract_debug", 0) > 0) {
    iprintln(function_9e72a96(var_38280f2f) + "<dev string:x38>" + new_progress + "<dev string:x47>" + target_value);

    if(old_progress < target_value && target_value <= new_progress) {
      iprintln(function_9e72a96(var_38280f2f) + "<dev string:x4c>");
    }
  }

}

function function_90a854d2(slot) {
  if(getdvarint(#"hash_657185da33fd5f8", 0) > 0) {
    var_38280f2f = # "hash_6a1133003efe7380";

    switch (slot) {
      case 0:
        return {
          #var_38280f2f: # "contract_mp_headshot", #contract_id: 10011, #target_value: 100, #var_59cb904f: 98
        };
      case 1:
        return {
          #var_38280f2f: # "hash_2173bc0bfcbdf90f", #contract_id: 10004, #target_value: 200, #var_59cb904f: 195
        };
      case 2:
        return {
          #var_38280f2f: # "hash_250c2d8ef2261723", #contract_id: 10009, #target_value: 50, #var_59cb904f: 48
        };
      default:
        break;
    }

    return undefined;
  }

  return function_d17bcd3c(slot);
}

function function_a4c8ce2a(data) {
  if(!isDefined(data)) {
    return;
  }

  player = data.player;

  if(!isPlayer(player)) {
    return;
  }

  player function_c5958b54();
  player function_78083139();
}

function function_3b024dd1(data) {
  if(!isDefined(data)) {
    return;
  }

  player = data.player;

  if(!isPlayer(player)) {
    return;
  }

  winningteam = data.winner;

  if(isDefined(winningteam) && player.team == winningteam) {
    switch (level.basegametype) {
      case # "gunfight":
        player function_fd9fb79b(#"hash_244fe1eba6e2cbd", 1);
        break;
      case # "sd":
        player function_fd9fb79b(#"hash_11977b122e8c8671", 1);
        break;
    }
  }
}

function contract_win(winner) {
  winner function_fd9fb79b(#"contract_mp_match_wins");
  var_831b642b = undefined;

  switch (level.basegametype) {
    case # "conf":
      var_831b642b = # "hash_62eeb56528fb2dd2";
      break;
    case # "control":
      var_831b642b = # "hash_42a587fd027c16d7";
      break;
    case # "dom":
      var_831b642b = # "hash_1286a20fba67f00f";
      break;
    case # "dropkick":
      var_831b642b = # "hash_7fe7c331c3ac1d69";
      break;
    case # "gunfight":
      var_831b642b = # "hash_637c243c43c99f88";
      break;
    case # "koth":
      var_831b642b = # "hash_1fa6cd6ec6b44413";
      break;
    case # "tdm":
      if(level.hardcoremode) {
        winner function_fd9fb79b(#"hash_91095804fbbf4ae");
      }

      var_831b642b = # "hash_491aa3b35ce36b7f";
      break;
    case # "sd":
      var_831b642b = # "hash_7065ab34c90b39b4";
      break;
    case # "vip":
      var_831b642b = # "hash_769fc475cca99231";
      break;
    default:
      break;
  }

  if(isDefined(var_831b642b)) {
    winner function_fd9fb79b(var_831b642b);
  }
}

function function_c5958b54() {
  var_c421e6b = undefined;

  switch (level.basegametype) {
    case # "ball":
      var_c421e6b = # "contract_mp_play_uplink";
      break;
    case # "bounty":
      var_c421e6b = # "contract_mp_play_heist";
      break;
    case # "conf":
      var_c421e6b = # "hash_5de2883b8961e46f";
      break;
    case # "control":
      var_c421e6b = # "hash_62d0b4c184c48912";
      break;
    case # "ctf":
      var_c421e6b = # "hash_42b7ebc5926b0008";
      break;
    case # "dem":
      var_c421e6b = # "contract_mp_play_demolition";
      break;
    case # "dm":
      var_c421e6b = # "hash_5dbf89f59ac323e3";
      break;
    case # "dom":
      var_c421e6b = # "hash_4289a3f53c536915";
      break;
    case # "dropkick":
      var_c421e6b = # "hash_4d02445b8cdd4388";
      break;
    case # "gunfight":
      var_c421e6b = # "hash_6f88335358950e1";
      break;
    case # "escort":
      var_c421e6b = # "contract_mp_play_safeguard";
      break;
    case # "gun":
      var_c421e6b = # "hash_f916a0b9718fb8";
      break;
    case # "infect":
      var_c421e6b = # "contract_mp_play_infection";
      break;
    case # "koth":
      var_c421e6b = # "hash_50f232749a3c2486";
      break;
    case # "prop":
      var_c421e6b = # "contract_mp_play_prop_hunt";
      break;
    case # "sas":
      var_c421e6b = # "contract_mp_play_sticks_and_stones";
      break;
    case # "sd":
      var_c421e6b = # "hash_5039727046c10015";
      break;
    case # "tdm":
      if(level.hardcoremode) {
        self function_fd9fb79b(#"hash_30ac3098e945e653");
      }

      var_c421e6b = # "hash_697ce077df5b3b5a";
      break;
    case # "vip":
      var_c421e6b = # "hash_4384359f95ad0db0";
      break;
    case # "fireteam_dirty_bomb":
      var_c421e6b = # "hash_445752ece698bef2";
      break;
    default:
      break;
  }

  if(isDefined(var_c421e6b)) {
    self function_fd9fb79b(var_c421e6b);
    self function_fd9fb79b(#"contract_mp_play_public_match_games");
  }

  if(globallogic_utils::function_308e3379()) {
    self function_fd9fb79b(#"hash_1ffdd36f8bcda97d");
  }
}

function on_headshot_kill(weapon) {
  if(level.hardcoremode) {
    self function_fd9fb79b(#"contract_mp_headshots_hardcore");
  }

  self function_fd9fb79b(#"contract_mp_headshot");
  var_6b9aa5a0 = undefined;
  weaponclass = util::getweaponclass(weapon);

  if(!isDefined(weaponclass)) {
    weaponclass = # "unspecified";
  }

  switch (weaponclass) {
    case # "weapon_assault":
      var_6b9aa5a0 = # "hash_3a58a49b35b9fa33";
      break;
    case # "weapon_lmg":
      var_6b9aa5a0 = # "hash_4fad0a97fc2fd9d4";
      break;
    case # "weapon_pistol":
      var_6b9aa5a0 = # "hash_192947c83a9aafab";
      break;
    case # "weapon_cqb":
      var_6b9aa5a0 = # "hash_6a65c11816351cf2";
      break;
    case # "weapon_smg":
      var_6b9aa5a0 = # "hash_5a9d9828ffe3c05f";
      break;
    case # "weapon_sniper":
      var_6b9aa5a0 = # "hash_4e0aa3269ac3f32f";
      break;
    case # "weapon_tactical":
      var_6b9aa5a0 = # "hash_52862bdba426ec21";
      break;
    default:
      break;
  }

  if(isDefined(var_6b9aa5a0)) {
    self function_fd9fb79b(var_6b9aa5a0);
  }
}

function function_a0045e6a() {
  self function_fd9fb79b(#"hash_5903b7c9559be1e");
}

function function_8af6a5a() {
  self function_fd9fb79b(#"hash_31951837e7c9b9ef");
}

function function_d9ae19f0(player) {
  if(player.var_9cd2c51d.var_43797ec0.statname === # "eq_stimshot" && isDefined(player.heal.heal_amount) && isDefined(player.heal.var_fa57541f)) {
    player function_fd9fb79b(#"hash_4222068ae31bdf3f", player.heal.heal_amount - player.heal.var_fa57541f);
  }
}

function devgui_setup() {
  devgui_base = "<dev string:x6e>";
  wait 3;
  function_e07e542b(devgui_base, undefined);
  function_17a92a99(devgui_base);
  function_b308be00(devgui_base);
  function_aae10509(devgui_base);
  function_7402288f(devgui_base);
  function_ef925b75(devgui_base);
  function_5ab1c2d4(devgui_base);
  function_1379e87e(devgui_base);
  function_6339ba69(devgui_base);
  function_b8984e1a(devgui_base);
  function_6961cd46(devgui_base);
}

function function_17a92a99(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x7f>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:xd1>", var_c8d599b5 + "<dev string:xdd>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x106>", var_c8d599b5 + "<dev string:x118>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x140>", var_c8d599b5 + "<dev string:x14f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x174>", var_c8d599b5 + "<dev string:x183>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1a8>", var_c8d599b5 + "<dev string:x1b3>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1cb>", var_c8d599b5 + "<dev string:x1e1>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x200>", var_c8d599b5 + "<dev string:x212>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x234>", var_c8d599b5 + "<dev string:x249>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x26c>", var_c8d599b5 + "<dev string:x280>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x29c>", var_c8d599b5 + "<dev string:x2a8>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2c5>", var_c8d599b5 + "<dev string:x2d0>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2ed>", var_c8d599b5 + "<dev string:x301>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x321>", var_c8d599b5 + "<dev string:x331>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x354>", var_c8d599b5 + "<dev string:x360>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x380>", var_c8d599b5 + "<dev string:x38c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x3a8>", var_c8d599b5 + "<dev string:x3b7>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x3d1>", var_c8d599b5 + "<dev string:x3dd>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x400>", var_c8d599b5 + "<dev string:x40b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x427>", var_c8d599b5 + "<dev string:x439>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x45c>", var_c8d599b5 + "<dev string:x472>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x492>", var_c8d599b5 + "<dev string:x4a1>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x4ba>", var_c8d599b5 + "<dev string:x4cb>");
}

function function_b308be00(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x4f8>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x510>", var_c8d599b5 + "<dev string:x52a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x548>", var_c8d599b5 + "<dev string:x559>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x58e>", var_c8d599b5 + "<dev string:x59a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x5c6>", var_c8d599b5 + "<dev string:x5dc>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x5ff>", var_c8d599b5 + "<dev string:x60a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x634>", var_c8d599b5 + "<dev string:x648>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x677>", var_c8d599b5 + "<dev string:x687>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x6ac>", var_c8d599b5 + "<dev string:x6bf>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x6e6>", var_c8d599b5 + "<dev string:x6f0>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x71c>", var_c8d599b5 + "<dev string:x728>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x755>", var_c8d599b5 + "<dev string:x763>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x797>", var_c8d599b5 + "<dev string:x7a2>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x7df>", var_c8d599b5 + "<dev string:x7f1>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x81a>", var_c8d599b5 + "<dev string:x827>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x85b>", var_c8d599b5 + "<dev string:x86c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x892>", var_c8d599b5 + "<dev string:x89c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x8c9>", var_c8d599b5 + "<dev string:x8da>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x901>", var_c8d599b5 + "<dev string:x914>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x938>", var_c8d599b5 + "<dev string:x946>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x971>", var_c8d599b5 + "<dev string:x97a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x9a4>", var_c8d599b5 + "<dev string:x9ba>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x9e9>", var_c8d599b5 + "<dev string:x9f7>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xa1a>", var_c8d599b5 + "<dev string:xa2d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xa57>", var_c8d599b5 + "<dev string:xa6a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xa99>", var_c8d599b5 + "<dev string:xaa7>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xacb>", var_c8d599b5 + "<dev string:xadb>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xb03>", var_c8d599b5 + "<dev string:xb1a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xb3d>", var_c8d599b5 + "<dev string:xb46>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xb70>", var_c8d599b5 + "<dev string:xb7c>");
}

function function_aae10509(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:xba6>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:xbc2>", var_c8d599b5 + "<dev string:xbcc>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xbf6>", var_c8d599b5 + "<dev string:xc02>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xc32>", var_c8d599b5 + "<dev string:xc3f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xc72>", var_c8d599b5 + "<dev string:xc7c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xca2>", var_c8d599b5 + "<dev string:xcb6>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xce3>", var_c8d599b5 + "<dev string:xcf2>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xd1b>", var_c8d599b5 + "<dev string:xd29>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xd59>", var_c8d599b5 + "<dev string:xd79>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xdaf>", var_c8d599b5 + "<dev string:xdc7>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xdf2>", var_c8d599b5 + "<dev string:xe00>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xe3b>", var_c8d599b5 + "<dev string:xe4d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xe7f>", var_c8d599b5 + "<dev string:xe8b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xec4>", var_c8d599b5 + "<dev string:xed0>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xf04>", var_c8d599b5 + "<dev string:xf15>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xf48>", var_c8d599b5 + "<dev string:xf55>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xf8f>", var_c8d599b5 + "<dev string:xf9c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xfd1>", var_c8d599b5 + "<dev string:xfe3>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1021>", var_c8d599b5 + "<dev string:x1030>");
}

function function_7402288f(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x105d>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1074>", var_c8d599b5 + "<dev string:x1082>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x10a9>", var_c8d599b5 + "<dev string:x10b5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x10cf>", var_c8d599b5 + "<dev string:x10e6>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1107>", var_c8d599b5 + "<dev string:x111c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x113d>", var_c8d599b5 + "<dev string:x1156>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1173>", var_c8d599b5 + "<dev string:x118a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x11ac>", var_c8d599b5 + "<dev string:x11ca>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x11ee>", var_c8d599b5 + "<dev string:x120a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x122e>", var_c8d599b5 + "<dev string:x124b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x126e>", var_c8d599b5 + "<dev string:x1289>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x12ac>", var_c8d599b5 + "<dev string:x12b6>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x12e2>", var_c8d599b5 + "<dev string:x12f5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1322>", var_c8d599b5 + "<dev string:x1332>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x135c>", var_c8d599b5 + "<dev string:x1373>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1391>", var_c8d599b5 + "<dev string:x13aa>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x13c9>", var_c8d599b5 + "<dev string:x13e0>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x140d>", var_c8d599b5 + "<dev string:x141e>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x143f>", var_c8d599b5 + "<dev string:x1455>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1473>", var_c8d599b5 + "<dev string:x148b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x14a9>", var_c8d599b5 + "<dev string:x14c8>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x14e3>", var_c8d599b5 + "<dev string:x1504>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x151f>", var_c8d599b5 + "<dev string:x1540>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1561>", var_c8d599b5 + "<dev string:x1571>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1589>", var_c8d599b5 + "<dev string:x159b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x15b3>", var_c8d599b5 + "<dev string:x15c8>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x15e0>", var_c8d599b5 + "<dev string:x15f0>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1612>", var_c8d599b5 + "<dev string:x1624>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x163d>", var_c8d599b5 + "<dev string:x165f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x167e>", var_c8d599b5 + "<dev string:x16a3>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x16c2>", var_c8d599b5 + "<dev string:x16e5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1704>", var_c8d599b5 + "<dev string:x1716>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1738>", var_c8d599b5 + "<dev string:x1751>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1774>", var_c8d599b5 + "<dev string:x1782>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x17ae>", var_c8d599b5 + "<dev string:x17bd>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x17e7>", var_c8d599b5 + "<dev string:x17fb>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1817>", var_c8d599b5 + "<dev string:x182d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1849>", var_c8d599b5 + "<dev string:x185a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x187a>", var_c8d599b5 + "<dev string:x1891>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x18ae>", var_c8d599b5 + "<dev string:x18c3>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x18e0>", var_c8d599b5 + "<dev string:x18f7>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x191a>", var_c8d599b5 + "<dev string:x1931>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x194e>", var_c8d599b5 + "<dev string:x1963>");
}

function function_ef925b75(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x1980>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1998>", var_c8d599b5 + "<dev string:x19a4>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x19c5>", var_c8d599b5 + "<dev string:x19db>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x19f9>", var_c8d599b5 + "<dev string:x1a05>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1a2b>", var_c8d599b5 + "<dev string:x1a37>");
}

function function_5ab1c2d4(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x1a5d>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1a70>", var_c8d599b5 + "<dev string:x1a8c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1ab1>", var_c8d599b5 + "<dev string:x1acf>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1af6>", var_c8d599b5 + "<dev string:x1b0f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1b3a>", var_c8d599b5 + "<dev string:x1b54>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1b77>", var_c8d599b5 + "<dev string:x1b84>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1bad>", var_c8d599b5 + "<dev string:x1bc5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1be6>", var_c8d599b5 + "<dev string:x1c00>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1c23>", var_c8d599b5 + "<dev string:x1c30>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1c65>", var_c8d599b5 + "<dev string:x1c6e>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1c91>", var_c8d599b5 + "<dev string:x1ca9>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1cca>", var_c8d599b5 + "<dev string:x1cda>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1d14>", var_c8d599b5 + "<dev string:x1d1d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1d49>", var_c8d599b5 + "<dev string:x1d60>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1d8a>", var_c8d599b5 + "<dev string:x1d96>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1db9>", var_c8d599b5 + "<dev string:x1dc6>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x3d1>", var_c8d599b5 + "<dev string:x1ded>");
}

function function_1379e87e(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x1e27>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1e41>", var_c8d599b5 + "<dev string:x1e50>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1e70>", var_c8d599b5 + "<dev string:x1e83>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1eaf>", var_c8d599b5 + "<dev string:x1ebf>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1ee7>", var_c8d599b5 + "<dev string:x1efa>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1f23>", var_c8d599b5 + "<dev string:x1f2f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1f5c>", var_c8d599b5 + "<dev string:x1f69>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1f99>", var_c8d599b5 + "<dev string:x1fa6>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1fd3>", var_c8d599b5 + "<dev string:x1fe3>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x200a>", var_c8d599b5 + "<dev string:x2016>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x204a>", var_c8d599b5 + "<dev string:x205a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x207d>", var_c8d599b5 + "<dev string:x208b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x20b6>", var_c8d599b5 + "<dev string:x20c9>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x20e1>", var_c8d599b5 + "<dev string:x20f6>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2128>", var_c8d599b5 + "<dev string:x2143>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x216e>", var_c8d599b5 + "<dev string:x217e>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x21a1>", var_c8d599b5 + "<dev string:x21b5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x21e2>", var_c8d599b5 + "<dev string:x21f5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2228>", var_c8d599b5 + "<dev string:x2242>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2273>", var_c8d599b5 + "<dev string:x2291>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x22c6>", var_c8d599b5 + "<dev string:x22dd>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x230b>", var_c8d599b5 + "<dev string:x2317>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x231b>", var_c8d599b5 + "<dev string:x2317>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2330>", var_c8d599b5 + "<dev string:x2317>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x233f>", var_c8d599b5 + "<dev string:x2317>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2355>", var_c8d599b5 + "<dev string:x2317>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2361>", var_c8d599b5 + "<dev string:x237c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x23a6>", var_c8d599b5 + "<dev string:x23b5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x23da>", var_c8d599b5 + "<dev string:x23f4>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2420>", var_c8d599b5 + "<dev string:x2434>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2453>", var_c8d599b5 + "<dev string:x2460>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2495>", var_c8d599b5 + "<dev string:x24ac>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x24c7>", var_c8d599b5 + "<dev string:x24d8>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x24fb>", var_c8d599b5 + "<dev string:x250c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2546>", var_c8d599b5 + "<dev string:x2560>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2585>", var_c8d599b5 + "<dev string:x258f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x25c7>", var_c8d599b5 + "<dev string:x25d6>");
}

function function_6339ba69(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x25f8>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x260e>", var_c8d599b5 + "<dev string:x2624>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2645>", var_c8d599b5 + "<dev string:x2659>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2685>", var_c8d599b5 + "<dev string:x2694>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x26b6>", var_c8d599b5 + "<dev string:x26c4>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x26e7>", var_c8d599b5 + "<dev string:x26f4>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x272b>", var_c8d599b5 + "<dev string:x2737>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x275d>", var_c8d599b5 + "<dev string:x2769>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2788>", var_c8d599b5 + "<dev string:x279a>");
}

function function_b8984e1a(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x27bd>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x27d2>", var_c8d599b5 + "<dev string:x27f0>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x280e>", var_c8d599b5 + "<dev string:x2829>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x284b>", var_c8d599b5 + "<dev string:x286a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2889>", var_c8d599b5 + "<dev string:x28a5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x28c8>", var_c8d599b5 + "<dev string:x28ea>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2909>", var_c8d599b5 + "<dev string:x2928>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x294b>", var_c8d599b5 + "<dev string:x296a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x298e>", var_c8d599b5 + "<dev string:x29aa>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x29d2>", var_c8d599b5 + "<dev string:x29ef>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2a11>", var_c8d599b5 + "<dev string:x2a2b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2a51>", var_c8d599b5 + "<dev string:x2a68>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2a8c>", var_c8d599b5 + "<dev string:x2aa4>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2ac3>", var_c8d599b5 + "<dev string:x2ad8>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2afb>", var_c8d599b5 + "<dev string:x2b12>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2b34>", var_c8d599b5 + "<dev string:x2b48>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2b6e>", var_c8d599b5 + "<dev string:x2b7d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2b9e>", var_c8d599b5 + "<dev string:x2bae>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2bce>", var_c8d599b5 + "<dev string:x2bdd>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2c02>", var_c8d599b5 + "<dev string:x2c1a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2c3d>", var_c8d599b5 + "<dev string:x2c54>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2c7b>", var_c8d599b5 + "<dev string:x2c8a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2cbd>", var_c8d599b5 + "<dev string:x2ccf>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2d02>", var_c8d599b5 + "<dev string:x2d0b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2d36>", var_c8d599b5 + "<dev string:x2d46>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2d73>", var_c8d599b5 + "<dev string:x2d82>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2dac>", var_c8d599b5 + "<dev string:x2db7>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2de7>", var_c8d599b5 + "<dev string:x2dfb>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2e2b>", var_c8d599b5 + "<dev string:x2e41>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2e6e>", var_c8d599b5 + "<dev string:x2e7f>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2ea7>", var_c8d599b5 + "<dev string:x2eb3>");
}

function function_6961cd46(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x2ede>";
  var_c8d599b5 = "<dev string:x94>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2ef5>", var_c8d599b5 + "<dev string:x2f08>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2f2a>", var_c8d599b5 + "<dev string:x2f3a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2f63>", var_c8d599b5 + "<dev string:x2f74>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2f9b>", var_c8d599b5 + "<dev string:x2fb1>");
}